Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A738D01E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521142; cv=none; b=r9r7TrbJxYldqfLqepRvATc5cYTcOHQ8zeBbm+jgyKqjHVASm9vf6vTmlP/IfEjPsCklbLnjKvwk7paRE3MvUeREjr6IFtAXGN6YyLDeO/OfTsqEjJig6wwIWhzxInrRWp3wLd5+K8PMvaKzEFUN1f1ozf4ZEWWJABuZNTodVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521142; c=relaxed/simple;
	bh=1RhHThSqd/KimY9wRNFitg2SUVjj0NwoM03Zdo+X1XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNZfI9ytt3MmaFjiKySGIG6PnkSXN3TgVpyhiLFmveyPqLZnVfS1Nf6Xq1PFqGPvAYTDqpcprFzNvR4cKvS0IzHU2MBNJSwJB2sKRV0sx+HAF341wDKhZHSYK74DGHQCBlaj699qGsjKvuc9Wp14NEkMaOvjJ+EWckUMrUB5pNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGeF1vUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGeF1vUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25811F00893;
	Wed, 16 Sep 2026 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521140;
	bh=E8n5W4uIXIGIlbAsMP6HBa4XricOo8OG6gef/U1L/wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cGeF1vUrICI3jF6d9AXIkzapMX7LAnCbZGCidz5yq1K8yFzp8FdTO8xXFBRcExD/q
	 EsMtnI3j8k93zlpc+aHj0mmtU7UPOvRBYf83CEi07giyMKORnDIAPrpC9iX4OHB2ZA
	 evOhuMmkcNdpnINw+XrvmabJ+6GFgSlmoG4B9nxLwBGO00mDtDFCmbCGGklHPsswb9
	 +WX+iQom/eTpUh1qBfsyda8NKg1iKSTFJd555EDNGsby2/WPGNaEhHSZ4RLMOpkCIL
	 5dg0qYAgDOrhgb6xZrBw5H5qAzk/vFuTFmOGII5jnfbX0d2IZXtMsgGLsEvmdA9siu
	 asBkrCWMnJkKg==
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
Subject: Re: [PATCH net 07/15] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
Date: Tue, 15 Sep 2026 18:12:19 -0700
Message-ID: <20260916011219.1632582-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-8-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-8-anthony.l.nguyen@intel.com>
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
    ice: E825: stop clearing PHY_REG_TX_OFFSET_READY

This drops the PHY_REG_TX_OFFSET_READY = 0 write from
ice_stop_phy_timer_eth56g() on E825 devices. Clearing that bit left hardware
capturing Tx timestamps without the valid bit, which desynchronized the
internal outstanding timestamp counter until a PHY soft reset. Only
PHY_REG_RX_OFFSET_READY is cleared now.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 3a41c711e751b..d48eb3c618231 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2115,10 +2115,6 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
>  {
>  	int err;
>  
> -	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 0);
> -	if (err)
> -		return err;
> -

[Severity: High]
With this write gone, is anything left that suppresses Tx timestamp
reporting while the E825 PHY is being re-calibrated?

ice_start_phy_timer_eth56g() begins by calling the stop helper and only
asserts Tx readiness at the very end:

	err = ice_stop_phy_timer_eth56g(hw, port, false);
	...
	err = ice_phy_cfg_parpcs_eth56g(hw, port);
	err = ice_phy_cfg_ptp_1step_eth56g(hw, port);
	err = ice_phy_cfg_mac_eth56g(hw, port);	/* PHY_REG_TOTAL_TX_OFFSET_L/U */
	...
	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
	...
	err = ice_sync_phy_timer_eth56g(hw, port);
	...
	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 1);

Across that whole window the Tx offset registers are being reprogrammed and
the port timer has not yet been re-synced to the PHC, but per the commit
message hardware now marks captures valid, so this check in
ice_ptp_process_tx_tstamp() no longer drops them:

		/* Discard any timestamp value without the valid bit set */
		if (!(raw_tstamp & ICE_PTP_TS_VALID))
			drop_ts = true;

The E82x branch of ice_ptp_port_phy_restart() gates this in software:

		spin_lock_irqsave(&ptp_port->tx.lock, flags);
		ptp_port->tx.calibrating = true;
		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
		...
		/* Do not clear calibrating flag here. Tx timestamps remain
		 * disabled until ice_ptp_wait_for_offsets() has verified
		 * that the Tx and Rx offset calibration has completed.
		 * Clearing it here would allow Tx timestamps to be reported
		 * before the PHY offset registers are configured, leading
		 * to incorrect timestamp values.
		 */

while the E825 branch does not:

	case ICE_MAC_GENERIC_3K_E825:
		err = ice_start_phy_timer_eth56g(hw, port);
		break;

Since ice_ptp_is_tx_tracker_up() only tests tx->init && !tx->calibrating,
new requests keep being accepted during the restart, and the restart path
holds only ps_lock while the reader takes tx->lock, so the two do not
exclude each other. Should the E825 case set tx.calibrating around
ice_start_phy_timer_eth56g() to replace the removed hardware gate?

The same exposure looks unbounded on the early-return paths of
ice_start_phy_timer_eth56g(), for example the ice_ptp_lock() failure:

	if (!ice_ptp_lock(hw)) {
		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
		return -EBUSY;
	}

because PHY_REG_TX_OFFSET_READY is only re-asserted on the success path.
The reachable trigger is a link up or link speed change
(ice_ptp_link_change() -> ice_ptp_port_phy_restart()) concurrent with any
SO_TIMESTAMPING application. Could the commit message also mention this
change in reporting behaviour during calibration?

>  	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
>  	if (err)
>  		return err;

[Severity: Low]
The kernel-doc and the debug print of ice_stop_phy_timer_eth56g() now
describe more than the body does:

 * Stop the clock of a PHY port. This must be done as part of the flow to
 * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
 * initialized or when link speed changes.

	ice_debug(hw, ICE_DBG_PTP, "Disabled clock on PHY port %u\n", port);

After this change the body only clears PHY_REG_RX_OFFSET_READY, so no Tx
offset is invalidated and no clock enable bit is touched, while
ice_start_phy_timer_eth56g() still asserts both PHY_REG_TX_OFFSET_READY and
PHY_REG_RX_OFFSET_READY. ice_ptp_port_phy_stop() is likewise documented as
"Stop timestamping for a PHY port" while Tx timestamping stays enabled for
ICE_MAC_GENERIC_3K_E825. Should the comment and the log message be updated
to say only the Rx offset-ready bit is cleared?

[Severity: Low]
This isn't a bug introduced by this patch, but with the body reduced to a
single register write the unused soft_reset parameter becomes quite visible:

 * @soft_reset: if true, hold the SOFT_RESET bit of PHY_REG_PS

ice_stop_phy_timer_eth56g() never reads soft_reset, and PHY_REG_PS appears
nowhere in drivers/net/ethernet/intel/ice/ outside this comment; the E82x
counterpart ice_stop_phy_timer_e82x() does honour the flag via P_REG_PS and
P_REG_PS_SFT_RESET_M. Both call sites are therefore equivalent:
ice_ptp_port_phy_stop() passes true for ICE_MAC_GENERIC_3K_E825 and
ice_start_phy_timer_eth56g() passes false. Would it make sense to drop the
parameter, or to document that it is ignored on ETH56G?
