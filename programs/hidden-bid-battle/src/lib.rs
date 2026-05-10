//! # Hidden Bid Battle Program
//!
//! Privacy-preserving bid comparison game on Solana, powered by Arcium MPC.
//!
//! Two players each submit an encrypted bid. Arcium's MPC network privately
//! determines the winner. Only the winner is revealed onchain — losing bids
//! remain permanently hidden.
//!
//! See `docs/architecture.md` for full system design.

use anchor_lang::prelude::*;

// NOTE: This is a placeholder Program ID. We replace it in Step 2.B
// after generating our actual program keypair with `solana-keygen`.
declare_id!("2v7VurFDYeNNpSDBNdjVK6wrB5Tru14PrhoMMKTV1Y53");

#[program]
pub mod hidden_bid_battle {
    use super::*;

    /// Placeholder instruction. Will be replaced by `init_room`, `join_room`,
    /// `submit_bid`, and `settle_room` in subsequent steps.
    pub fn ping(_ctx: Context<Ping>) -> Result<()> {
        msg!("Hidden Bid Battle: ping");
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Ping<'info> {
    pub player: Signer<'info>,
}
