# Hidden Bid Battle — Architecture

> This document is the source of truth for system design. Update it when designs change; do not let code and docs drift.

## Four-Plane Model

Hidden Bid Battle operates across four cleanly-separated planes:

| Plane | Stack | Responsibility | Trust |
|---|---|---|---|
| Presentation | Next.js + Wallet Adapter | UX, wallet signing, client-side encryption | Untrusted |
| Onchain | Solana + Anchor program | Source of truth, escrow, settlement | Trustless (verifiable) |
| Privacy | Arcium MXE + Arcis circuit | Confidential comparison computation | Trust-minimized (MPC) |
| Coordination | Firebase | Lobby state, presence, realtime UI sync | Trusted for liveness only |

## Round Lifecycle

1. Connect wallet → Sign-In With Solana → Firebase custom token
2. Discover/create room (Firestore lobby + onchain `init_room`)
3. Both players stake equal SOL into Escrow PDA
4. Each player encrypts bid client-side to MXE cluster pubkey, submits ciphertext + commitment hash via `submit_bid`
5. When 2 bids received, program queues Arcium computation
6. Arcium MPC nodes execute `compare_bids` circuit; only winner index is revealed
7. Arcium callback into program triggers `settle_room`: payout from escrow, event emission
8. Frontend mirrors event from Firestore (via Cloud Function indexer)

## Account Model

See [account-model.md](./account-model.md) (TODO).

## Encryption Lifecycle

See [encryption.md](./encryption.md) (TODO).

## Threat Model

See [threat-model.md](./threat-model.md) (TODO).
