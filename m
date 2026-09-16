Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211B38DC49
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521144; cv=none; b=p/inv1WaiQAP+992HWuyT5hSDqPiX9S7tjtsOS/eGXLpEJSvDBtTSg3ULfLynFDA8N240SPBScya7GwkYh0CBZvdNIkgAEoF0DVOqmp4M45Y51VGGxW5h/PrPlSFf//dBH7EX05GY1YmWxn9EvyW+oatjxUUXNrryNkKdLQbUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521144; c=relaxed/simple;
	bh=2HCGR8VyvvHep1Mjulsix0T3GVyBlTpx5rxQghyC3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emfC678Qxn44tk0IubM8eTA2la4BcA10gRSw+3Bu/ZRgeXkiWh7ia48W45pRQuC/nlfhLUYrvE1ujGjOvNeP3DPKK4gmiISflbX0X+dPcS/L/Xdb+ywSfRY7fbH6WplpdIDb8BlHB1p8k9liHB91VajO9JYKq42aqY62CuZc1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBGq3xDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBGq3xDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D381F00893;
	Wed, 16 Sep 2026 01:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521143;
	bh=mzxykHThVDbs3bJufL6Los58VUZS/9r9YA2njZqvkTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBGq3xDt1Id++W+MdfFWa70sHsqemXzpMteMSdK0skp3lNbBcuV6/UFT5JgH2Y8ZF
	 urlOOhpIfvjQ+peOn8JXUFRq8VVBGvLIq0x+bOmLVVp69AuY1+wuhxapv9Okk8pwMx
	 qkcYd6lLl8nbpB5uf4geXeOWeklDVfWVaD0rwH1yp6mHvCKQb9wBgBsFgcL8TfxBPu
	 +29w1kIRfeQ/v4Uy6xI2OcfN0idYM2huiiQFVvlvpgmikPEoxqn0cteRuz69pZ1T5h
	 u6R0gTbJQSe4XdkSxDmrIfPtfHhIGM7uGgKWoXGmF6snaa0Pt6ALCKblD1qVBJ6n8y
	 vs9OJW5YKcnRg==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	maciej.machnikowski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 09/15] ice: E825: perform a soft reset when starting the PHY timer
Date: Tue, 15 Sep 2026 18:12:21 -0700
Message-ID: <20260916011222.1632652-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-10-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-10-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ice: E825: perform a soft reset when starting the PHY timer

This adds a call to ice_ptp_phy_soft_reset_eth56g() at the top of
ice_start_phy_timer_eth56g() so that the E825 PHY PTP block is reset before
it is reprogrammed. The kernel-doc for the function is updated to mention
the reset.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index a3a9f7ce04d2b..64e18fe1176b1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -2138,6 +2140,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>  
>  	tmr_idx = ice_get_ptp_src_clock_index(hw);
>  
> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> +	if (err)
> +		return err;
> +

[Severity: Medium]
Should the software Tx timestamp tracker be reconciled here?

ice_ptp_phy_soft_reset_eth56g() calls
ice_ptp_clear_tx_memory_status_eth56g(), whose kernel-doc says:

  * for the port (two 32-bit reads each). This discards all timestamp data on the port,
  * so it must only be used for a full reset; callers that must preserve
  * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().

This now runs on an ordinary link-up path:

  ice_ptp_link_change(true)
    -> ice_ptp_port_phy_restart()
      -> case ICE_MAC_GENERIC_3K_E825: ice_start_phy_timer_eth56g()
        -> ice_ptp_phy_soft_reset_eth56g()

The ICE_MAC_GENERIC branch of ice_ptp_port_phy_restart() sets
ptp_port->tx.calibrating under tx->lock, and ice_ptp_rebuild_owner() does:

  /* Flush software tracking of any outstanding timestamps since we're
   * about to flush the PHY timestamp block.
   */
  ice_ptp_flush_all_tx_tracker(pf);

The ICE_MAC_GENERIC_3K_E825 branch does neither, so indices still set in
tx->in_use keep their skb references while the hardware timestamp memory
and ready bits are wiped underneath them. Those entries are then only
resolved by the 2 second timeout in ice_ptp_process_tx_tstamp(), bumping
tx_hwtstamp_timeouts. Later patches in the series ("ice: keep Tx timestamp
slots tracked until completion or timeout" and "ice: don't clear in_use
until HW clears ready bitmap") make the periodic work reap those slots, so
the effect is bounded rather than permanent, but should the E825 branch
still gate or flush the tracker around the reset?

[Severity: Medium]
Can this leave the PHY parked in soft reset?

ice_ptp_phy_soft_reset_eth56g() asserts the bit and then has several
error returns before the final de-assert:

  global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
  err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
  if (err) {
          ice_debug(...);
          return err;
  }
  usleep_range(5000, 6000);

  global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
  ...

If a sideband access fails after the assert (queue full, timeout, or a
concurrent device reset returning -EBUSY/-EIO/-ETIMEDOUT), the new early
return here skips ice_stop_phy_timer_eth56g(),
ice_phy_cfg_parpcs_eth56g(), ice_phy_cfg_ptp_1step_eth56g(),
ice_phy_cfg_mac_eth56g(), the incval programming, the timer sync and the
TX/RX_OFFSET_READY writes.

ice_ptp_port_phy_restart() only logs the failure:

  if (err)
          dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
                  port, err);

  mutex_unlock(&ptp_port->ps_lock);

There is no ov_work retry for ICE_MAC_GENERIC_3K_E825, and
ice_ptp_link_change() only calls the restart on a link-up transition, so
the port stays with SOFT_RESET asserted and stale offset-ready bits until
the next link-up or a rebuild. Would it be better to de-assert the bit on
the error paths inside ice_ptp_phy_soft_reset_eth56g()?

[Severity: Medium]
What serialises this reset against the Tx timestamp reader on the other PF?

The reset holds the block in reset across two settling windows:

  usleep_range(5000, 6000);

  global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
  ...
  usleep_range(5000, 6000);

The writer side holds only its own ptp_port->ps_lock:

  ice_ptp_link_change() -> ice_ptp_port_phy_restart() -> ice_start_phy_timer_eth56g()

The reader side runs on the source-timer-owning PF:

  ice_ptp_process_ts() -> ice_ptp_tx_tstamp_owner() -> ice_ptp_process_tx_tstamp()
      ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
      ...
      ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);

and for E825 that PF processes all ports, including the peer PF's port:

  if (ice_pf_src_tmr_owned(pf))
          pf->ptp.tx_interrupt_mode = ICE_PTP_TX_INTERRUPT_ALL;

ice_ptp_process_tx_tstamp() takes only tx->lock around the bitmap/skb
update, never ps_lock, and the E825 branch of ice_ptp_port_phy_restart()
does not set tx.calibrating. So can ice_read_phy_tstamp() land on a PHY
PTP block that another PF is holding mid-reset, and if such a read returns
a word with ICE_PTP_TS_VALID set, would it be extended with the cached PHC
and reported to userspace as a real hardware timestamp?

[Severity: Medium]
Does PHY_REG_TS_INT_CONFIG survive this reset?

Everything else in the per-lane PTP block is reprogrammed below this point
(PAR/PCS, 1-step, MAC/XIF, TIMETUS incval, timer sync, TX/RX_OFFSET_READY),
but PHY_REG_TS_INT_CONFIG (Tx timestamp interrupt enable plus threshold, in
the same per-lane block as PHY_REG_GLOBAL) is not. Its only writer is
ice_phy_cfg_intr_eth56g() via ice_ptp_cfg_phy_interrupt(), reached only from
ice_ptp_init_owner() and ice_ptp_rebuild_owner(), and it is a
read-modify-write, so a value returned to defaults cannot be recovered.

The existing ordering in ice_ptp_init_phc_e825c() is reset first:

  /* Soft reset all ports, to ensure everything is at a clean state */
  for (int port = 0; port < hw->ptp.num_lports; port++) {
          err = ice_ptp_phy_soft_reset_eth56g(hw, port);

whereas ice_ptp_rebuild_owner() now configures the interrupt and then
resets every port:

  err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
  if (err)
          return err;

  ice_ptp_restart_all_phy(pf);

Given the commit message says the reset "ensures that the PHY internal
state has been completely reset", could this disarm the port's Tx timestamp
threshold interrupt after the first link-up while software still believes
it is enabled? The software fallback ice_ptp_maybe_trigger_tx_interrupt()
only runs on the source-timer-owning PF. Commit 3ec46e157c7f describes the
reset's effects without mentioning configuration registers, so this may
well be fine; could the commit message state whether
PHY_REG_TS_INT_CONFIG is preserved, or should
ice_phy_cfg_intr_eth56g() be re-applied after the reset?

>  	err = ice_stop_phy_timer_eth56g(hw, port, false);

[Severity: Low]
This is a pre-existing issue, not introduced by this patch, but the new
juxtaposition makes it more visible. ice_stop_phy_timer_eth56g() documents
a parameter and an action it does not implement:

  * @soft_reset: if true, hold the SOFT_RESET bit of PHY_REG_PS
  *
  * Stop the clock of a PHY port. ...
  int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
  {
          err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);

soft_reset is never read, so ice_ptp_port_phy_stop() passing true gets no
soft reset:

  case ICE_MAC_GENERIC_3K_E825:
          err = ice_stop_phy_timer_eth56g(hw, port, true);

Now that the soft reset is done explicitly right before a call that passes
false, could the parameter be dropped and the summary line corrected?

>  	if (err)
>  		return err;
