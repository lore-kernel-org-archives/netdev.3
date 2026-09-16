Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FD38E8BB
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521151; cv=none; b=RF7Cmd0ly8reHzGA1xQd5Zo0S8qugdoK5FNnBJHQ2t24QR/yuk/1HaFaXU6T7qiQpfUqv/FcCq8I+qi9FUGeNAA9vgAENnT6T5gmNbL7e4jZZsOmzRQLjufxGORry5kqhHg+BmtPDTLWek/D0wH8LnqXDkK2EMHagM+/v09OpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521151; c=relaxed/simple;
	bh=SWwSURtlbchWO4sNpRQrELoSvVt80frYe2b+zDQVwrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYpMLIr72vyXVvTAYFBylV4c/EG5p90QZxM3B+6jTD6weaO1/0Gq/Q1foE3ESplSaz1zL0nz2MuhBWCgNrqtZWOw6Kg3t6Ap7xC5Ukp2flFYxBt3Bn0BPio5X3RIDhRp/721Djk4ilNi4JV+Q+kfBWaHRrKcgGAT1ilLM2iF1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcrMPl9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcrMPl9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D531F000FF;
	Wed, 16 Sep 2026 01:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521149;
	bh=DD3f5szWWXWmpQRP6BoY+q6Cqkv4rpBwmj47eQU640U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcrMPl9ncnqNYUq9Rg57Ldqr9CQe1ZsuO+4x+WQsUj+N7kANTi8a31rL39R7lBUVA
	 XCqcEv4bjwH/5e7ZOiLVtoCi2TUDMK4Asje3zQJE36jp+vvhETmYXrCK+lg1zBIA/B
	 mFEHdbdc3p1bIZHhtGRO3iecBWKoXYlLTrU+94r1Xx/zrJ6kkHiRZxMT4Fx1yBJ51J
	 m2LTAiZ5E6hZe7feTMLh0kC8Uuw1Ygh5+W/oHaeJtv7RzQWYR/uU8yz/KU0MEG2GAE
	 ycw8iOUaoYXF5V6d8j6x3posX4OvNS68IehF2avVAbHPaL9OqEUQktp5Rk3RhpZoH5
	 sp5ks7hLnm4AQ==
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
Subject: Re: [PATCH net 15/15] ice: Recalibrate PHY after settime64 on E825-C
Date: Tue, 15 Sep 2026 18:12:28 -0700
Message-ID: <20260916011228.1632848-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-16-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-16-anthony.l.nguyen@intel.com>
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
ice: Recalibrate PHY after settime64 on E825-C

The patch extends the post-settime PHY recalibration path in
ice_ptp_settime64() so that it also runs for ICE_MAC_GENERIC_3K_E825,
not only for ICE_MAC_GENERIC (E822/E823). The stated motivation is that
the E825-C PHY needs recalibration after large system time jumps,
otherwise PHY timestamps read back incorrectly.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 832cc6ad2f90c..a5efb0a95941e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2020,8 +2020,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>  	/* Reenable periodic outputs */
>  	ice_ptp_enable_all_perout(pf);
>  
> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> -	if (hw->mac_type == ICE_MAC_GENERIC)
> +	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
> +	if (hw->mac_type == ICE_MAC_GENERIC ||
> +	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_restart_all_phy(pf);

[Severity: High]

The E82X sequence has two halves: timestamps are invalidated before the
time is written, and the PHY is recalibrated afterwards.  Only the second
half is being extended to E825-C here.  Earlier in ice_ptp_settime64() the
invalidation is still E82X only:

	if (hw->mac_type == ICE_MAC_GENERIC) {
		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
		if (err)
			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
	}

Should something equivalent run for ICE_MAC_GENERIC_3K_E825?  There is no
eth56g counterpart of ice_ptp_clear_phy_offset_ready_e82x() in the tree, and
ice_stop_phy_timer_eth56g() clears only PHY_REG_RX_OFFSET_READY, so
PHY_REG_TX_OFFSET_READY stays at 1 for the whole restart window while the
PHY timer is being re-initialised.

Related to that, the ICE_MAC_GENERIC_3K_E825 branch of
ice_ptp_port_phy_restart() does not quiesce the Tx tracker at all:

	case ICE_MAC_GENERIC_3K_E825:
		err = ice_start_phy_timer_eth56g(hw, port);
		break;

whereas the ICE_MAC_GENERIC branch does:

		spin_lock_irqsave(&ptp_port->tx.lock, flags);
		ptp_port->tx.calibrating = true;
		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);

tx.calibrating is only ever set in that E82X branch and only ever cleared in
ice_ptp_wait_for_offsets(), so on E825-C ice_ptp_is_tx_tracker_up() keeps
returning true (link_up is true, which is why the port was picked in
ice_ptp_restart_all_phy()):

	return tx->init && !tx->calibrating && ptp_port->link_up;

Does that mean Tx timestamp requests keep being armed and reported while
ice_start_phy_timer_eth56g() is soft-resetting the PTP block, reprogramming
PHY_REG_TIMETUS/INCVAL and re-running ice_sync_phy_timer_eth56g()?  The
comment in the ICE_MAC_GENERIC branch describes that state as producing bad
values:

		/* Do not clear calibrating flag here. Tx timestamps remain
		 * disabled until ice_ptp_wait_for_offsets() has verified
		 * that the Tx and Rx offset calibration has completed.
		 * Clearing it here would allow Tx timestamps to be reported
		 * before the PHY offset registers are configured, leading
		 * to incorrect timestamp values.
		 */

One more effect of the same window: the call chain
ice_start_phy_timer_eth56g() -> ice_ptp_phy_soft_reset_eth56g() ->
ice_ptp_clear_tx_memory_status_eth56g() clears every hardware Tx timestamp
entry:

	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);

but the software tracker keeps its in_use bits and skbs, since nothing calls
ice_ptp_mark_tx_tracker_stale() on this path.  Can those already-outstanding
requests then only complete via the 2 second timeout?

[Severity: Medium]

This is also the first E825-C path that can reach ice_ptp_port_phy_stop(),
because ice_ptp_link_change() only calls ice_ptp_port_phy_restart() on a
link-up transition for this MAC type:

	case ICE_MAC_GENERIC_3K_E825:
		if (linkup)
			ice_ptp_port_phy_restart(ptp_port);
		goto exit_kref_put;

ice_ptp_port_phy_restart() tests link_up outside ps_lock:

	if (!ptp_port->link_up)
		return ice_ptp_port_phy_stop(ptp_port);

	mutex_lock(&ptp_port->ps_lock);

and ice_ptp_link_change() stores that field with no lock held:

	/* Update cached link status for this port immediately */
	ptp_port->link_up = linkup;

Can a link bounce concurrent with a settime invert the decision here?

CPU0 (ice_ptp_settime64 -> ice_ptp_restart_all_phy)
	if (port->link_up)                /* true */
		ice_ptp_port_phy_restart(port);
	   -> !ptp_port->link_up          /* link just went down */
	   -> ice_ptp_port_phy_stop()     /* waits on ps_lock */

CPU1 (link comes back up)
	ice_ptp_link_change()
	   ptp_port->link_up = true;
	   ice_ptp_port_phy_restart()
	      -> ice_start_phy_timer_eth56g()   /* holds ps_lock, takes ms */

CPU0 then acquires ps_lock and issues ice_stop_phy_timer_eth56g(hw, port,
true), which does:

	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);

Since the E825-C link handler only restarts on link-up, would this leave the
port with the link up but Rx offsets marked not ready, with no recovery until
the next link flap?

The unlocked check itself predates this change on the E82x path, but the
E825-C path that can now hit it is new here.
