#!/usr/bin/env bash
set -euo pipefail

echo "
=== Project initializer: learn-solidity ===
This script will:
  - check for required tools (pnpm, forge)
  - install Node dev dependencies
  - run the project build (exports ABIs + builds with forge)

If a tool is missing, the script will print instructions rather than attempting to install it.
"

check_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "\n⚠️  Missing command: $1"
    case "$1" in
      pnpm)
        echo "   Install pnpm: npm i -g pnpm  OR use corepack: corepack enable && corepack prepare pnpm@latest --activate"
        ;;
      forge)
        echo "   Install Foundry (forge): curl -L https://foundry.paradigm.xyz | bash && foundryup"
        ;;
      *)
        echo "   Please install $1 and re-run this script."
        ;;
    esac
    return 1
  fi
  return 0
}

missing=0
for cmd in pnpm forge; do
  if ! check_cmd "$cmd"; then
    missing=$((missing + 1))
  fi
done

if [ "$missing" -ne 0 ]; then
  echo "\nPlease install the missing tools above and re-run: ./init.sh"
  exit 1
fi

echo "\nInstalling Node dependencies with pnpm..."
pnpm install

echo "\nRunning project build (this will export ABIs and run forge build)..."
pnpm run build

echo "\n✅ Initialization complete. Useful commands:
  - pnpm run build        # build contracts and export ABIs
  - pnpm run export-abis  # only export ABIs
  - forge test            # run solidity tests
"

exit 0
