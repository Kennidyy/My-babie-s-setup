#!/usr/bin/env bash
set -euo pipefail

SERVER="${1:-server@192.168.0.111}"
PORT="${2:-2222}"

cd "$(dirname "$0")"

echo "🔍 Dry build..."
nix build .#nixosConfigurations.server.config.system.build.toplevel --dry-run 2>&1 | tail -3

echo "🔥 Building server config on workstation..."
nix build .#nixosConfigurations.server.config.system.build.toplevel

echo "📦 Copying to server..."
nix copy --to "ssh://$SERVER?port=$PORT" ./result

echo "🚀 Activating on server..."
ssh "$SERVER" -p "$PORT" "sudo ./result/bin/switch-to-configuration switch"

echo "✅ Deploy complete"
