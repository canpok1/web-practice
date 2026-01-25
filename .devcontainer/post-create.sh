#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Set up Claude Code
curl -fsSL https://claude.ai/install.sh | bash
