/**
 * Hidden Bid Battle — Anchor Program Tests
 *
 * These tests run against `solana-test-validator` (localnet) when `anchor test`
 * is invoked. They will be expanded as we add real instructions in Step 3+.
 */

import * as anchor from '@coral-xyz/anchor';
import { Program } from '@coral-xyz/anchor';
import { HiddenBidBattle } from '../target/types/hidden_bid_battle';

describe('hidden-bid-battle', () => {
  // Configure the client to use the local cluster.
  anchor.setProvider(anchor.AnchorProvider.env());

  const program = anchor.workspace.HiddenBidBattle as Program<HiddenBidBattle>;

  it('Pings the program', async () => {
    const tx = await program.methods
      .ping()
      .accounts({
        player: program.provider.publicKey!,
      })
      .rpc();

    console.log('Ping transaction signature:', tx);
  });
});
