Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971836;
	b=0CMUGZufDth4AG+u34RUs0uuKSSHo4cGJSMc1cALy3u8NjJSZv7ZR5M6fkUI1qvuxMWg
	 Bxm/4ReEHz5rQr82eocXx7dp+Z5yGJDK/PdiW8aXLp0iZ4kMlpd9RtBE3C7Hr1nxRAxoi
	 a+amCt1vJpnsRHqTgXM3nKyVs4XYN+UqQN2433yZS5+pAzPRX23diDW1dTAaganxyZdIN
	 abwzqytnWVNG5O13SDrNflXJzA2NcpKgMgJFGy6LCVUpvnj+5wFkKoYd1tyaaPaxEhcoW
	 viGoOUklfGUfKM3JXciDv5Ec51TYLEivtWNHbB4tKe7sgQqm4C5mbgUEHqQyJUiq6kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971836;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zLTTZuRlp6EimEh8SBZmZz7gt+9H0C46ju7PufG8QTY=;
	b=uOJ/rsK1CWHAKCHlnYD29TEuv+ae12Dz23gJj40ZZPj2cwC+dv7e1eZo2smzBRQjr2uT
	 0jwLamsllcdysg6ZnLi+Aq3s4U5U7c/ibLrapvOkO7ZOIxhaSUiQ7VG485IwJkbKFOsIO
	 iHt1CjTXS5OH4oKxf79f8KP68QhMAyrZtCE3zP0yoDXUV8M7QAZiZbqStbrGQ6biP1bJa
	 H98PVl7lBVxHS/0ruqgrU+hGitYgtfZuD8KqcuZk1S86jY8BaQmQRcY/HK5Ko9s/faNV1
	 JMfMfZPGPf7WK1ETcdOVcz4hAshC/sGaEc0zYLvZQkmb5LN/m2DQ+ThEw7/QgYcUU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fur9zyp6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD2606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fur9zyp6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B81F01825;
	Sun, 25 Oct 2026 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971835;
	bh=zLTTZuRlp6EimEh8SBZmZz7gt+9H0C46ju7PufG8QTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fur9zyp69fqhoXhrpvaDhAMlIO6aABjZ1rjX+zo7y4vnDYpHqFwKGWE9WpJTZVrMF
	 d4v3lyX0xy5lV2/kNSXwStQR+Sx15aSdcsDaFsMIOhhQJBDBu5ZQQ9fPgv4PPl3/p5
	 4nL56gYip3TJsf6R1mHiC6JQ10PfzQJXoAggdgiXIdz4XeQ1kLZVuwYxr+Ne0T0o0x
	 QmKDljQjnc1ne/D6J11kguQ6U/HMdbqIhJbt/BUNnzcmZ43iRwyEdHIhyZ8xUNNAO1
	 Sy8XpLuDqrjJOsuue7B/kjYBlf6mUYZVMDZdChQnlfy/GOBGFM762JrrSh7tmETYmd
	 1e5zwFVsuJ8ww==
Subject: Re: [PATCH net v5 01/13] ice: fix removal of PTP timestamp tracker
 during reset
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:43:54 +0000
Message-ID: <179297183411.3134.15060779235779250719@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-1-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-1-72289a4ac8eb=40intel=2Ecom=3E?=
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new error unwind in ice_ptp_init() destroys the PTP
  kworker while the owner's PTP clock is still registered.
- [Medium] On E810 (has_ready_bitmap == 0), the Tx tracker now survives
  CORE/GLOBAL/EMP resets.

Pre-existing issues:
- [Medium] Concern: ice_ptp_flush_all_tx_tracker(),
  ice_ptp_restart_all_phy() and ice_ptp_prepare_rebuild_sec() walk…

--

ice: fix removal of PTP timestamp tracker during reset

This patch stops ice_ptp_prepare_for_reset() from releasing the Tx
timestamp tracker, so timestamping works again after CORE, GLOBAL or EMP
resets. It also reorders ice_ptp_init() so the kworker and tracker are set
up before the port is added to the port list, with a matching error
unwind. The non-READY branch of ice_ptp_release() now frees the tracker
and kworker.

Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index eaec36ab6ae3..e1c66cd0f94f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>  
> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> -
>  	/* Disable periodic outputs */
>  	ice_ptp_disable_all_perout(pf);

[Severity: Medium]
The tracker now survives CORE/GLOBAL/EMP resets. On E810, can the
cached_tstamp values then drift from the PHY state after the post-reset
flush?

The rebuild path runs after hw->reset_ongoing has already been set back
to false:

ice_rebuild()->ice_ptp_rebuild()->ice_ptp_rebuild_owner()
  ->ice_ptp_flush_all_tx_tracker()->ice_ptp_flush_tx_tracker()

On E810, ice_get_phy_tx_tstamp_ready_e810() reports every slot as ready:

	*tstamp_ready = 0xFFFFFFFFFFFFFFFF;

So ice_ptp_flush_tx_tracker() clears every in_use slot in hardware:

	if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
		ice_clear_phy_tstamp(hw, tx->block, phy_idx);

That writes 0 to the PHY slot. However, tx->tstamps[idx].cached_tstamp
keeps its old non-zero value.

E810 has has_ready_bitmap == 0, so ice_ptp_process_tx_tstamp() treats any
raw value that differs from the cache as captured:

	if (!drop_ts && !tx->has_ready_bitmap &&
	    raw_tstamp == tx->tstamps[idx].cached_tstamp)
		continue;

	/* Discard any timestamp value without the valid bit set */
	if (!(raw_tstamp & ICE_PTP_TS_VALID))
		drop_ts = true;

The next request on that slot might be processed before hardware captures
it, for example because another slot raised the TSYN_TX interrupt. In that
case raw is 0, which does not match the stale cache. The skb then
completes without a timestamp and in_use is cleared. The cache is not
updated, because raw is 0.

The real capture for that packet then lands in the slot that was just
freed. Could the next request that reuses the slot read this leftover
value and report it as its own timestamp?

Would resetting cached_tstamp when the flush clears the PHY slot keep the
software and hardware state in sync?

[ ... ]

> @@ -3363,16 +3366,19 @@ void ice_ptp_init(struct ice_pf *pf)

[ ... ]

>  	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
>  	return;
>  
> -err_clean_pf:
> +err_release_tx_tracker:
> +	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> +err_release_kworker:
> +	kthread_cancel_delayed_work_sync(&ptp->work);
> +	kthread_destroy_worker(ptp->kworker);
> +	ptp->kworker = NULL;
>  	mutex_destroy(&ptp->port.ps_lock);
> -	ice_ptp_cleanup_pf(pf);
>  err_exit:
>  	/* If we registered a PTP clock, release it */
>  	if (pf->ptp.clock) {

[Severity: Medium]
Is the PTP clock still registered while the kworker is torn down here?

On the clock owner, ice_ptp_init_owner() has already registered the
clock. /dev/ptpN stays live until err_exit calls ptp_clock_unregister().

The settime64 and adjtime ops do not check ptp->state, and they call
ice_ptp_reset_cached_phctime(). Suppose ice_ptp_update_cached_phctime()
returns -EAGAIN because ICE_CFG_BUSY is held, for example by a concurrent
adjtime on the same PHC. That function then does:

	kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
				   msecs_to_jiffies(10));

If this runs after kthread_cancel_delayed_work_sync() but before or during
kthread_destroy_worker(), a timer is left pending. Could
kthread_delayed_work_timer_fn() later touch the freed worker?

If it runs after ptp->kworker = NULL, would it dereference NULL?

One way to reach this window: ice_ptp_init_port() fails with -ENOMEM from
ice_ptp_alloc_tx_tracker() while a process with /dev/ptpN open calls
clock_settime() or clock_adjtime().

In this same patch, the non-READY branch of ice_ptp_release() unregisters
the clock before tearing down the worker. Should the init error path use
the same order? This ordering is still present at the end of the series.

> @@ -3399,12 +3405,22 @@ void ice_ptp_release(struct ice_pf *pf)
>  		return;
>  
>  	if (pf->ptp.state != ICE_PTP_READY) {
> -		mutex_destroy(&pf->ptp.port.ps_lock);
> -		ice_ptp_cleanup_pf(pf);
>  		if (pf->ptp.clock) {
>  			ptp_clock_unregister(pf->ptp.clock);
>  			pf->ptp.clock = NULL;
>  		}
> +		ice_ptp_cleanup_pf(pf);
> +		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy() and
ice_ptp_prepare_rebuild_sec() walk the adapter port list without holding
ports.lock:

	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);

At the same time, a peer PF's ice_ptp_release() can remove its port from
the list and free the tracker, kworker and ps_lock. Since trackers are now
kept across resets, the owner's flush walks memory that belongs to live
peers.

The next patch in the series, "ice: use reference counting and SRCU for
PTP port access", fixes this. It converts these walkers to
srcu_read_lock() with list_for_each_entry_srcu() and
kref_get_unless_zero(). It also makes ice_ptp_cleanup_pf() wait for the
references and SRCU readers to finish before the tracker and worker are
freed. The race is gone by the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
