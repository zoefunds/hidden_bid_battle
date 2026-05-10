# Hidden Bid Battle

A privacy-preserving prediction game on Solana, powered by Arcium confidential compute.

Two players secretly submit numbers. Arcium's MPC network privately computes who has the higher number. The blockchain reveals only the winner — losing bids stay permanently hidden.

> **Status:** 🚧 Under active construction.

## Architecture

Hidden Bid Battle is built on four planes:

- **Presentation** — Next.js + TypeScript + Tailwind + Solana Wallet Adapter
- **Onchain** — Anchor program (Rust) on Solana Devnet
- **Privacy** — Arcium MXE (confidential MPC computation)
- **Coordination** — Firebase (Auth, Firestore, Cloud Functions)

See [`docs/architecture.md`](./docs/architecture.md) for full system design.

## Quick start

> Setup instructions coming once Step 1 is complete.

## Tech stack

| Layer | Stack |
|---|---|
| Frontend | Next.js 14, TypeScript, Tailwind, Framer Motion, Zustand |
| Onchain | Solana, Anchor 0.32, Rust |
| Privacy | Arcium, Arcis (MXE circuit DSL) |
| Backend | Firebase Auth, Firestore, Cloud Functions |
| Infra | Docker, GitHub Actions, Vercel, Turborepo, pnpm |

## License

MIT — see [LICENSE](./LICENSE).
