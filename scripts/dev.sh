#!/usr/bin/env bash
# Hidden Bid Battle — local development helpers
# Usage: ./scripts/dev.sh <command>
#
# NOTE on toolchain workaround: Solana 2.3.x ships cargo-build-sbf with
# platform-tools v1.48 (rustc 1.84.1) by default, but several transitive
# dependencies (e.g. indexmap 2.14) require Rust 1.85+ for `edition2024`.
# We pin --tools-version v1.52 (rustc 1.89-dev) for the BPF compile.
# IDL generation uses the host toolchain so it doesn't need the flag.

set -euo pipefail

PLATFORM_TOOLS_VERSION="v1.52"
IDL_OUT="target/idl/hidden_bid_battle.json"
TS_OUT="target/types/hidden_bid_battle.ts"

CMD="${1:-help}"

case "$CMD" in
  build)
    echo "→ Building program (.so)..."
    anchor build --no-idl -- --tools-version "$PLATFORM_TOOLS_VERSION"
    echo "→ Building IDL + TS types..."
    mkdir -p "$(dirname "$IDL_OUT")" "$(dirname "$TS_OUT")"
    anchor idl build -o "$IDL_OUT" -t "$TS_OUT"
    echo "✓ Build complete"
    echo "  .so:  $(ls -lh target/deploy/hidden_bid_battle.so | awk '{print $5}')"
    echo "  IDL:  $IDL_OUT"
    echo "  TS:   $TS_OUT"
    ;;
  test)
    echo "→ Building before test..."
    "$0" build
    echo "→ Running anchor test (localnet)..."
    anchor test --skip-build
    ;;
  test-skip-build)
    anchor test --skip-build
    ;;
  validator)
    solana-test-validator --reset
    ;;
  airdrop)
    AMOUNT="${2:-2}"
    solana airdrop "$AMOUNT"
    ;;
  pubkey)
    echo "Wallet:   $(solana address)"
    echo "Program:  $(solana-keygen pubkey target/deploy/hidden_bid_battle-keypair.json)"
    ;;
  clean)
    cargo clean
    rm -rf .anchor target/idl target/types
    echo "✓ Clean complete"
    ;;
  help|*)
    cat << 'HELP'
Hidden Bid Battle — Dev Helper

Usage: ./scripts/dev.sh <command>

Commands:
  build              Build the program (.so), IDL, and TS types
  test               Full build + anchor test (full lifecycle)
  test-skip-build    Run tests without rebuilding
  validator          Start a fresh local Solana validator (Ctrl-C to stop)
  airdrop [amount]   Airdrop SOL to your wallet (default: 2 SOL)
  pubkey             Show wallet address and program ID
  clean              Remove all build artifacts
  help               Show this message
HELP
    ;;
esac
