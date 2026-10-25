Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971845;
	b=K3fqyTTrNd877kqUhEEyPwmwZjbe9ebU+DSQM+gVSDXO3JjAAbsu5pcnWgpTE33UHDWu
	 RfY82RYOHAjDMhqy5o98/zwKNWt8SJlOd4CVfRpcXC4SfE9A2rBJC3IMPEjoZoT+zvKHg
	 X1+RUJV2z4kavpEkNkkgJ0gjG55pVTZnrU08r+1nsSMKMa4nvCDNZF/Smz/9nQj//sWAn
	 l9wkTlAD1RLeorHaN5/uXPsIA2hHUSTR75MZsAZFwJlK0wCxct+u3/fQgm6Hfb2n2tm4G
	 gEigE4mbI8MJPgrw2Hauzq5UGvxtKRrX7W1o49eOunShrKcVXzqut5Y0HYGpAUhj4bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971845;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=k3N+rDq+/wK9k5QwJlILu6CXlHNYiLo2QB9IXeLNF0Q=;
	b=EKS6SPV6MLBWo02IC3N/GJeHFrkeTcf0qKfxLMaP1el39iR4o139if677gEnbqz78JEh
	 Qw71voreOPz7DURFb7KFVbEkPDz+SwrBzmh2xNLxkTocqGGz90FYqQP+tLb6j7briZFfS
	 pCIoNYTq3vPtsA03xiE7CfEfjwoTXaLgKqyQ0CwxTY0y5elsiPAO/txaeKKF518SrGJMG
	 3eXQowX96SYCzVe74LvBKDXPKc0Qo+MLFD1u5NAsQozToyTuDbGE5ALvlg8XA/SaGnyi3
	 t5JAxx9S0z6gjjCUk+DCLHx1thb9Qc0g4UdcfuSLqmWWQGRUSffZXywgvnEyk7RQevA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkHZ5wrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B12606A323
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkHZ5wrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF61F01828;
	Sun, 25 Oct 2026 23:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971845;
	bh=k3N+rDq+/wK9k5QwJlILu6CXlHNYiLo2QB9IXeLNF0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kkHZ5wrgPZqXaHzLig/R6Ffs7Wo/+6rr2Q5TjTxDOCu+gFrGinhXc3ISXbS0gLSvQ
	 4g2knxP57OZbdu5n7Y4+YB3qVnh22zvULkI6Z3sbOE6mFxmKBBY4DlPXa5fqkN9DjL
	 sXbhMg1lKOu/yjEjBn2ipIe8LBo2KK+C/vUcHjP9IONWHXyiHSa/k6HM+De88VBzQj
	 15i89W1TPcgFD+7+BMSCNHFzEGzxCtWueEaKBQu88pF1Km6VT31cnZqAVCMzKAbFfR
	 lOyoOikodeJw9mpTDTapruc1rkvBm+QARienk0+rtddQiEyH/4ZF2dsdBGmRa3r4G2
	 tpVgFe8z2rmTQ==
Subject: Re: [PATCH net v5 10/13] ice: E825: perform a soft reset when
 starting the PHY timer
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:44:03 +0000
Message-ID: <179297184384.3134.3372650759308982003@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-10-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-10-72289a4ac8eb=40intel=2Ecom=3E?=
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

- [Medium] ice_start_phy_timer_eth56g()
  (drivers/net/ethernet/intel/ice/ice_ptp_hw.c) now calls…
- [Medium] With this patch, the destructive E825 PHY soft-reset sequence
  runs at runtime from ice_start_phy_timer_eth56g(), mainly on E825…

--

ice: E825: perform a soft reset when starting the PHY timer

This patch makes ice_start_phy_timer_eth56g() call
ice_ptp_phy_soft_reset_eth56g() before it programs the E825 PHY. The goal
is to clear any outstanding Tx timestamp memory and the PHY timestamp
counter. Only the timer block of the PHY is reset.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 5637925c0e68..2d000251b185 100644
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
Should the software Tx timestamp tracker be flushed before this reset
wipes the hardware timestamp memory?

On E825 link-up the path is ice_ptp_link_change() ->
ice_ptp_port_phy_restart() -> ice_start_phy_timer_eth56g(). The E825 case
in ice_ptp_port_phy_restart() only marks the outstanding entries stale:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
    ...
		ptp_port->tx.disabled = true;
		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);

		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

		err = ice_start_phy_timer_eth56g(hw, port);
    ...
}

The in_use bits and tstamps[idx].skb stay in place. After that,
ice_ptp_phy_soft_reset_eth56g() calls
ice_ptp_clear_tx_memory_status_eth56g() and pulses the soft reset, which
clears every ready bit on the port.

Take an entry whose timestamp was captured but not read yet. Before this
patch it would have been read through the ready bit path and quietly
dropped as stale. Now its ready bit never comes back, so
ice_ptp_process_tx_tstamp() can only release it through the timeout:

		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
			drop_ts = true;

			/* Count the number of Tx timestamps that timed out */
			pf->ptp.tx_hwtstamp_timeouts++;
		}

Does this hold the slot and the skb from ice_ptp_request_ts() for about
2 seconds? Does it also count a timestamp the driver threw away itself in
tx_hwtstamp_timeouts, which ethtool -S reports?

At this commit there is also no time bound on the hold. The periodic
fallback in ice_ptp_maybe_trigger_tx_interrupt() fires only when the
hardware ready bits are set, and the reset has just cleared them.

The later commit "ice: keep Tx timestamp slots tracked until completion
or timeout" changes that trigger to check the software in_use bitmap.
That bounds the reclaim to about 2.5 seconds. The miscounted timeouts and
the temporary slot and skb hold are still there at the end of the series.

ice_ptp_rebuild_owner() already flushes the software state before it
restarts the PHYs:

	/* Flush software tracking of any outstanding timestamps since we're
	 * about to flush the PHY timestamp block.
	 */
	ice_ptp_flush_all_tx_tracker(pf);

Would the link change restart path need a matching flush? The commit
message says only that the reset will "clear any outstanding Tx timestamp
memory". It doesn't mention what happens to the software tracker.

[Severity: Medium]
What keeps the Tx timestamp interrupt thread and in-flight hardware
captures away from this port while the soft reset sequence runs?

Before this patch, the only caller of ice_ptp_phy_soft_reset_eth56g() was
ice_ptp_init_phc_e825c(), at PHC init. Now it also runs on every E825
link-up restart. The sequence sweeps all slots and sleeps before the
reset is asserted:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_ptp_phy_soft_reset_eth56g() {
	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
    ...
	usleep_range(5000, 6000);

	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
    ...
	usleep_range(5000, 6000);
    ...
}

ice_stop_phy_timer_eth56g() leaves PHY_REG_TX_OFFSET_READY set, so the
PHY keeps capturing timestamps for descriptors that were posted before
tx.disabled was set. A capture can land on an index the sweep has already
passed, during the 5 ms gap before the reset is asserted.

The consumer path is ice_misc_intr_thread_fn() -> ice_ptp_process_ts() ->
ice_ptp_tx_tstamp_owner() -> ice_ptp_process_tx_tstamp(). It never takes
ps_lock. Its ice_is_reset_in_progress() check doesn't cover a link
triggered PHY restart. It snapshots the ready bitmap and then calls
ice_read_phy_tstamp() based on that snapshot.

Suppose the thread snapshots that new ready bit and then reads the slot
after the soft reset. It would read a slot whose valid bit is still set,
against a counter that was just reset to zero. The kdoc for
ice_ptp_clear_tx_memory_status_eth56g() says the soft reset does not clear
the timestamp memory.

The earlier commit "ice: E825: clear PHY_TSTAMP memory prior to soft
reset" says an unbalanced read "underflows the counter, and prevents new
timestamp interrupts from being triggered".

Could this stall Tx timestamp interrupts on the port until the next soft
reset? That is the failure this patch is meant to prevent. Whether it
happens depends on PHY behavior described only in this series and on a
narrow timing window. Even so, nothing in the code seems to prevent the
interleaving.

Does this path need to synchronize with the misc IRQ thread, or wait for
in-flight captures, before it runs the sweep and the reset?

>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>  
>  	err = ice_phy_cfg_parpcs_eth56g(hw, port);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
