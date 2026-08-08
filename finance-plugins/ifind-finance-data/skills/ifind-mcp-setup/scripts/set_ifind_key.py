#!/usr/bin/env python3
"""
Set IFIND_API_KEY for the current environment.

Usage:
  python set_ifind_key.py <IFIND_API_KEY value>

Auto-detects the host environment:

* Inside Claude Code (CLAUDECODE=1 is set in every subprocess Claude Code
  spawns) -> writes the "env" field in ~/.claude/settings.json, where
  Claude Code reads env vars for MCP servers.
* Anywhere else -> sets a persistent user-level environment variable:
  - Windows: [System.Environment]::SetEnvironmentVariable("IFIND_API_KEY",
    value, "User") via PowerShell (registry-backed, survives reboots);
  - Linux/macOS: appends `export IFIND_API_KEY="value"` to the rc file of
    the user's login shell (~/.zshrc for zsh, ~/.bashrc otherwise),
    replacing an existing assignment of the same variable if present.

Exit code 0 means the key was stored; non-zero means it was not.
"""

import json
import os
import re
import subprocess
import sys
from pathlib import Path

# Make printed messages UTF-8 even on Windows consoles with non-UTF-8
# codepages, so the Chinese hints below stay readable in any terminal/tool.
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

VAR_NAME = "IFIND_API_KEY"


def _in_claude_code() -> bool:
    """True when run inside Claude Code: it sets CLAUDECODE=1 in every
    subprocess it spawns (Bash/PowerShell tools, hooks, MCP servers)."""
    return os.environ.get("CLAUDECODE") == "1"


def _write_settings_json(value: str) -> Path:
    """Claude Code path: store the key in the "env" field of
    ~/.claude/settings.json. Creates the file or field if missing,
    preserves existing settings."""
    path = Path.home() / ".claude" / "settings.json"
    settings = {}
    if path.exists():
        try:
            with open(path, "r", encoding="utf-8") as f:
                settings = json.load(f)
        except json.JSONDecodeError as e:
            print(f"Error: {path} contains invalid JSON: {e}", file=sys.stderr)
            sys.exit(1)

    settings.setdefault("env", {})[VAR_NAME] = value

    path.parent.mkdir(parents=True, exist_ok=True)
    # os.open with mode=0o600 so the credentials file is not world-readable
    # (best-effort on Windows, where permission bits are largely ignored)
    fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    with os.fdopen(fd, "w", encoding="utf-8") as f:
        json.dump(settings, f, indent=2, ensure_ascii=False)
        f.write("\n")
    return path


def _set_windows_user_env(value: str) -> None:
    """Windows path: persist a user-scope env var via PowerShell
    (registry-backed). The value is embedded in a single-quoted PowerShell
    string; embedded single quotes are escaped by doubling them."""
    ps_value = value.replace("'", "''")
    cmd = (
        "[System.Environment]::SetEnvironmentVariable("
        f"'{VAR_NAME}', '{ps_value}', 'User')"
    )
    try:
        result = subprocess.run(
            ["powershell", "-NoProfile", "-NonInteractive", "-Command", cmd],
            capture_output=True,
            text=True,
        )
    except OSError as e:
        print(f"Error: cannot run PowerShell to set the env var: {e}", file=sys.stderr)
        sys.exit(1)
    if result.returncode != 0:
        print(
            "Error: PowerShell failed to set the user environment variable:\n"
            + result.stderr.strip(),
            file=sys.stderr,
        )
        sys.exit(1)


def _shell_rc_path() -> Path:
    """rc file of the user's login shell: ~/.zshrc for zsh, else ~/.bashrc."""
    shell = os.environ.get("SHELL", "").lower()
    if shell.endswith("zsh"):
        return Path.home() / ".zshrc"
    return Path.home() / ".bashrc"


def _bash_escape(value: str) -> str:
    """Escape a value for embedding in a double-quoted POSIX shell string."""
    return (
        value.replace("\\", "\\\\")
        .replace('"', '\\"')
        .replace("$", "\\$")
        .replace("`", "\\`")
    )


def _write_shell_rc(value: str) -> Path:
    """Linux/macOS path: set the variable in the shell rc file. Replaces
    any existing `export VAR=...` (or bare `VAR=...`) line in place,
    otherwise appends one, so re-running never creates duplicates."""
    path = _shell_rc_path()
    export_line = f'export {VAR_NAME}="{_bash_escape(value)}"'
    pattern = re.compile(rf"^\s*(?:export\s+)?{VAR_NAME}=")

    lines = []
    if path.exists():
        try:
            lines = path.read_text(encoding="utf-8").splitlines()
        except OSError as e:
            print(f"Error: cannot read {path}: {e}", file=sys.stderr)
            sys.exit(1)

    replaced = False
    out = []
    for line in lines:
        if pattern.match(line):
            out.append(export_line)
            replaced = True
        else:
            out.append(line)
    if not replaced:
        out.append(export_line)

    try:
        path.write_text("\n".join(out) + "\n", encoding="utf-8")
    except OSError as e:
        print(f"Error: cannot write {path}: {e}", file=sys.stderr)
        sys.exit(1)
    return path


def main():
    if len(sys.argv) != 2:
        print(f"Usage: python set_ifind_key.py <{VAR_NAME} value>", file=sys.stderr)
        sys.exit(1)

    value = sys.argv[1].strip()
    if not value:
        print(f"Error: {VAR_NAME} value cannot be empty.", file=sys.stderr)
        sys.exit(1)

    if _in_claude_code():
        path = _write_settings_json(value)
        print(f"[OK] {VAR_NAME} written to {path}")
        print("生效方式：重启 Claude Code（或 /mcp 重新连接）后生效")
    elif os.name == "nt":
        _set_windows_user_env(value)
        print(f"[OK] {VAR_NAME} set as a user environment variable (Windows)")
        print("生效方式：新开终端，或重启使用该环境变量的 MCP 客户端/应用后生效")
    else:
        path = _write_shell_rc(value)
        print(f"[OK] {VAR_NAME} written to {path}")
        print(f"生效方式：新开终端，或执行 source {path.name} 后生效")


if __name__ == "__main__":
    main()
