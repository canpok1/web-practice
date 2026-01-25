#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

sudo chown vscode:vscode ${SCRIPT_DIR}/../node_modules -R

uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
