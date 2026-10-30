Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396441;
	b=RFpUAVIyh28hs4T8ynhH+OflaKbDCWhxBHp0zPZcVZttFQ93kR3qwltAZXL2+7/OWT7s
	 LeMbO0N3H+P6WQESytPDCxrnRNbUjLkRDc854ovZ08pFmbS8BheP6wsRYMGO8alh7oJJ+
	 UYbGjbfA/U09NEQ/8baBWUWc+TylKDowz8KjOWnIAPHvbraSplX7ncE9t/EpuqTlzy8kC
	 yI5jCZ38XDl+v7A6NzESxaY0LDQEYaqq/qF22jiLkE+ptpdufVSRVMcwoxreRkwo+eHGY
	 AZCMLjxrMfYJQh3aqFUJ0I6IbT1R1MmTFAMWDSJawnQSOgxGIYFAo6tKj+yBLUEVFNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396441;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6bFYuiEoKw1614shRF6GWo2fYDlOOFFFzj6T/JItuZE=;
	b=asuFyZ0GMWwt6cFpEpQCiM9OSX7p+hzJnfcXNFQMmEWYTpqLrzQHxx5t01COyvP9Viw+
	 PNeb3/sHDBG0b0+BlD4uvx1iYv7s09yAxEezNekNbIU0Ft5XRKJFtjNDbQXCxTrxcmouf
	 xvk7VnrWZzL7fnnc7qnWI3jZ0YjLxbvYDzVux9lv8hnySiNkXse8vxOSD5H1lrSl5rsSG
	 TOfGze8+QDbLCDJVPdgLq/oxix0lY1JxGANBkJk97rF7a4n6mMveu13RL6jKsnOCtSug8
	 38BbfRBfJ97IO5Wm5GyHHFeopKZHlKcpdS+EO1H2/zpfjRWQI7E0Nke0CS0QUwl806g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2d+RCTi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE315606A327
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2d+RCTi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4131F0093A;
	Fri, 30 Oct 2026 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793396440;
	bh=6bFYuiEoKw1614shRF6GWo2fYDlOOFFFzj6T/JItuZE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I2d+RCTiuSwGsVG8jTnBmBleuudC1oRvBbXSD3s5nWTcz56dlfN44ueFUpPMdxMu2
	 I3oSIXONB//umL7tuz9MM4Q5M66JLlFXZmlQiL3Exh5I214agmCiLPLoRoQDN3Qq+4
	 1vGgcqM75XIypMH95kff0jHqksrpm+XG9wiU0ejFtWhAL6sRZ7TW+LvQwhMcchGNB5
	 dl4CEfdrOzkVaT4lcDczR4jvZimL/7WHAao8qedd6hJ6BezGsKrHUjWZNUsY+I7PwH
	 VX/vsYizC4VJ7tR//eevhyy7ZHw75UyIiIOdOQHm+DzAO+MQy5okU0ZMO1vBRqnayf
	 dyzvnCefV6HDA==
Subject: Re: [PATCH net 3/3] ice: E825: perform a soft reset when starting the
 PHY timer
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Fri, 30 Oct 2026 21:40:38 +0000
Message-ID: <179339643889.3131.9026864983755179552@kernel.org>
In-Reply-To:
 <20261029-jk-e825c-critical-timestamping-fixes-v1-3-72128d1dd928@intel.com>
References:
 <20261029-jk-e825c-critical-timestamping-fixes-v1-3-72128d1dd928@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the E825 link-change restart path, the software Tx
  timestamp tracker is not flushed, yet the PHY timestamp memory it…
- [Medium] ice_ptp_phy_soft_reset_eth56g() now runs on every E825 PHY
  restart, including while Tx traffic is live, but in-flight timestamp…

--

ice: E825: perform a soft reset when starting the PHY timer

This commit adds a call to ice_ptp_phy_soft_reset_eth56g() in
ice_start_phy_timer_eth56g(), so the E825 PHY timer block starts in a
clean state. The soft reset sweeps the Tx timestamp memory and resets the
PHY timestamp counter before the PHY is programmed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index ef59b34ba52dc..ee945ce08eb72 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>  	if (err)
>  		return err;
>  
> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> +	if (err)
> +		return err;
> +

[Severity: Medium]

On the link change path, should the software Tx timestamp tracker be
flushed before this runs?

ice_start_phy_timer_eth56g() is also called at runtime. The chain is
ice_link_event() or ice_up_complete() -> ice_ptp_link_change() ->
ice_ptp_port_phy_restart(). For E825, that path only marks the
outstanding entries as stale:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
    ...
	case ICE_MAC_GENERIC_3K_E825:
		...
		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

		err = ice_start_phy_timer_eth56g(hw, port);
    ...
}

ice_ptp_mark_tx_tracker_stale() only ORs in_use into stale. Both in_use
and tstamps[idx].skb stay set.

With this patch, ice_ptp_phy_soft_reset_eth56g() then calls
ice_ptp_clear_tx_memory_status_eth56g(). That function reads all 64
entries of the port, which clears their valid and ready bits. The soft
reset then clears the ready bitmap and the counter.

Take an in_use index whose timestamp the PHY has already captured but the
IRQ thread has not yet read. Its ready bit is now gone, so
ice_ptp_process_tx_tstamp() skips that index on every pass:

	if (tx->has_ready_bitmap &&
	    !(tstamp_ready & BIT_ULL(phy_idx))) {
		if (drop_ts)
			goto skip_ts_read;

		continue;
	}

This continues until the 2 second timeout fires, and the timeout also
increments pf->ptp.tx_hwtstamp_timeouts.

Until then, ice_misc_intr_thread_fn() keeps re-arming the interrupt,
because ice_ptp_tx_tstamps_pending() sees a non-empty in_use. Each pass
does a sideband read of the ready bitmap. The skb reference taken in
ice_ptp_request_ts() is also held for that whole time.

Before this patch, those entries stayed ready in hardware. They were read
and dropped right away through the stale bit, and were not counted as
timeouts.

ice_ptp_rebuild_owner() already flushes the tracker before
ice_ptp_restart_all_phy():

	/* Flush software tracking of any outstanding timestamps since we're
	 * about to flush the PHY timestamp block.
	 */
	ice_ptp_flush_all_tx_tracker(pf);

Does the link change path need the same flush? The timeout does
eventually release these entries, so the slots are not lost for good.

[Severity: Medium]

Could a timestamp captured during the soft reset window leave the PHY
counter and the timestamp memory out of sync?

On E825, the Tx queues can be live when this runs. ice_up_complete()
starts the queues before it restarts the PHY:

	netif_tx_start_all_queues(vsi->netdev);
	netif_carrier_on(vsi->netdev);
	ice_ptp_link_change(pf, true);

ice_link_event() also restarts on a speed change while the link stays up.

ice_ptp_port_phy_restart() sets tx.disabled, but descriptors already
posted with ICE_TX_FLAGS_TSYN can still be sent.
ice_stop_phy_timer_eth56g() also leaves PHY_REG_TX_OFFSET_READY set, so
such a packet is captured as valid.

Inside ice_ptp_phy_soft_reset_eth56g(), the memory sweep runs about 5 ms
before the reset is asserted, and the reset is deasserted about 5 ms
after that:

	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
	...
	usleep_range(5000, 6000);

	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;

Suppose a packet is captured after the sweep but before the reset is
deasserted. The kernel-doc of ice_ptp_clear_tx_memory_status_eth56g()
says "the soft reset does not clear the timestamp memory", so that valid
entry stays in memory. Meanwhile the reset zeroes the counter and the
ready bitmap.

Only the 2 second timeout would free that software entry. The entry could
still be read, for example by a concurrent reader, or depending on how the
hardware handles reuse of an index that is already valid. Would that read
underflow the counter and stop Tx timestamp interrupts, as that kernel-doc
warns?

Should in-flight timestamp requests be quiesced before the soft reset?
Packets captured after the reset but before ice_sync_phy_timer_eth56g()
look like they are dropped safely through the stale bitmap.

>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>  
>  	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-jk-e825c-critical-timestamping-fixes-v1-0-72128d1dd928%40intel.com
