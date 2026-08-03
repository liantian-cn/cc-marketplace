#!/usr/bin/env python3
"""
Set QCC_API_KEY in Claude Code's ~/.claude/settings.json.

Usage:
  python set_qcc_key.py <QCC_API_KEY value>

Reads/writes the "env" field in ~/.claude/settings.json.
Creates the file or "env" field if missing; preserves existing settings.
"""

import json
import os
import sys
from pathlib import Path

VAR_NAME = "QCC_API_KEY"


def main():
    if len(sys.argv) != 2:
        print(f"Usage: python set_qcc_key.py <{VAR_NAME} value>", file=sys.stderr)
        sys.exit(1)

    value = sys.argv[1].strip()
    if not value:
        print(f"Error: {VAR_NAME} value cannot be empty.", file=sys.stderr)
        sys.exit(1)

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

    print(f"[OK] {VAR_NAME} written to {path}")


if __name__ == "__main__":
    main()
