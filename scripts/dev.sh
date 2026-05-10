#!/usr/bin/env bash
# Hidden Bid Battle — local development helpers
# Usage: ./scripts/dev.sh <command>

set -euo pipefail

CMD="${1:-help}"

case "$CMD" in
  build)
    anchor build
    ;;
  test)
    anchor test
    ;;
  test-skip-build)
    anchor test --skip-build
    ;;
  validator)
    # Start a local validator separately (useful for long-running dev sessions)
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
  help|*)
    cat << 'HELP'
Hidden Bid Battle — Dev Helper

Usage: ./scripts/dev.sh <command>

Commands:
  build              Run anchor build
  test               Run anchor test (full lifecycle)
  test-skip-build    Run tests without rebuilding the program
  validator          Start a fresh local Solana validator (Ctrl-C to stop)
  airdrop [amount]   Airdrop SOL to your wallet (default: 2 SOL)
  pubkey             Show wallet address and program ID
  help               Show this message
HELP
    ;;
esac
