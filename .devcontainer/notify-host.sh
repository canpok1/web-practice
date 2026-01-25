#!/bin/bash
set -e

if [ -z "$WORKSPACE_DIR" ]; then
    echo "[ERROR] 環境変数 'WORKSPACE_DIR' が設定されていません。" >&2
    exit 1
fi

echo "{\"message\": \"${1:-Done}\", \"title\": \"${2:-Dev Container}\"}" > "${WORKSPACE_DIR}/.devcontainer/host-notifier.json"
