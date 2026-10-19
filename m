Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440846;
	b=E1d5vZTCYibcrSNkBjdO8z5UWXpGDmsBnqCH92bbaRqQ2eeyaUIiM0s2dl2rteh3QjhL
	 xORK+n5bGRISBTfhjjRm8fqBI3+QXAihAZ5TofwISCt+Wrxds7KtfDig+vkps5Gq7qRBO
	 hk63Sj2Mbc1ZXL6ZIv4AkuO8izwJW8bHpJxuXmNHpnlMk00kmUMfzhQd5TWm7YbFSIF+l
	 0CldGDuEKRJZD0iMD8kHDwiW95pgYIshhjB772npIGj3xWQFmT01vLR1Y6fHPNaz6HZ8d
	 BiJYNPr5HasLRCNbVa19F2Q+01N8ZEgdGaS4oXftCVRFY4KKu54gHVWAnEmjoHXe5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440846;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cRWyfKKBmm1uGHeWBw9D/a4PXNziON4sDgB9zQeb4y4=;
	b=fJ/HHVdnBQDlFEBkIv00LcOyPYOmQ4WQvC2tbAOH7+O9nTLsrQ42QnkQ1VP0hdOqT8rd
	 tN5x4HIrOwufvKrWirY7riQSZMsLDnJZHh4ZNvnBAOYeso8sz+4bpZDhR8cu9W198WVXX
	 Mlmj2GV778qerz48rTqLrFV0YKKD+KW6E9CN9qA06U2Z4XKQ0zN1myVlrP9X8F/WGPLWz
	 aeQoVb7jWhS/kdtDx3iTdntFvS9huk79JR2Ks7FYWBJ4da+b5xFSvRUlGGqEDG1Ojv7Z6
	 pt5E1qhHkt808UiZklfheJuFwxkMpHZp36Z7JpDC3Q9gxGg8S9ohIV3JLZmX0i5Frsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQi8ZlCF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E66606A32A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQi8ZlCF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671601F000C8;
	Mon, 19 Oct 2026 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440845;
	bh=cRWyfKKBmm1uGHeWBw9D/a4PXNziON4sDgB9zQeb4y4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BQi8ZlCFJmghh1+PNGqYVZ8iqRgOGFQc1qQRYdjuX46htAdSmVSwB2zUBZDI++PZE
	 StNn+3saN3CVfoixS2bPz6ZD8kJhul8UAtf8OkYwdHslY7MMeNuBAPCQnqGFUBwOeH
	 IFx96TNMWlMToXmaT9KM+HmhPCXm9Ao71CAsrM6Aw3uFtrfKiCBT5bZLX4bXnRE+E3
	 RQMYhpALSIFjzkAh9Ol1oi8RdWv0VtN2ubfMuV49ISIsEHXQGfZh2pB61wetlTbntm
	 ikWBnUG4OjWC9E52wLzmHe+utX+EOQxvOuRzSyOZ/xQs7oiEUb1XGH7ph/RDy+lgNk
	 2PQe1XzgaNsTA==
Subject: Re: [PATCH net v3 03/14] ice: fix PHY port restart serialization
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:03 +0000
Message-ID: <179244084394.3135.13607937299434468009@kernel.org>
In-Reply-To: <20261015191102.1174111-4-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-4-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, ice_ptp_link_change() still returns early on
  `pf->ptp.state != ICE_PTP_READY` (ice_ptp.c:1312).

Pre-existing issues:
- [High] ice_ptp_release() runs its teardown without ps_lock and without
  serializing against ice_ptp_link_change().
- [Low] At this commit ptp_port->link_up is written with a plain store
  under ps_lock in ice_ptp_link_change() (ice_ptp.c:1319).

--

ice: fix PHY port restart serialization

This commit replaces the per-port ps_lock with a single ps_lock mutex in
struct ice_adapter. ice_ptp_link_change() now takes that lock to write
link_up and run the PHY restart. ice_ptp_restart_all_phy(), ice_ptp_init()
and ice_ptp_release() also take it around the PHY start/stop calls.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 55241802d17ae..d1cdd38ea27c8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1314,12 +1314,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  
>  	ptp_port = &pf->ptp.port;
>  
> -	/* Update cached link status for this port immediately */
> +	mutex_lock(&pf->adapter->ps_lock);

[Severity: Medium]
Can a link edge still be lost here? Just above this hunk,
ice_ptp_link_change() still returns before it takes ps_lock and before it
writes link_up:

	if (pf->ptp.state != ICE_PTP_READY)
		return;

	ptp_port = &pf->ptp.port;

	mutex_lock(&pf->adapter->ps_lock);

ice_ptp_init() does its locked restart while the state is still
ICE_PTP_INITIALIZING, and sets READY only after that:

	mutex_lock(&pf->adapter->ps_lock);
	ice_ptp_port_phy_restart(&ptp->port);
	mutex_unlock(&pf->adapter->ps_lock);
	...
	ptp->state = ICE_PTP_READY;

A link event that arrives during init, or while the state is RESETTING,
is dropped without updating link_up. It does not wait on ps_lock. After
that, the init restart or ice_ptp_restart_all_phy() during rebuild
programs the PHY from a stale link_up value:

		if (port->link_up)
			ice_ptp_port_phy_restart(port);

ice_link_event() does not replay the edge once old_link has been updated:

	if (link_up == old_link && link_speed == old_link_speed)

So on E82x/E825 the PHY timer could stay stopped, or be restarted from
stale state, until the next link toggle.

Doesn't this undercut the commit message's goal of setting link_up in the
same critical section as the restart?

The later patch in this series, "ice: call PTP link change only from link
events", appears to fix this. It writes link_up under ps_lock
unconditionally, checks the READY state inside the lock, and sets READY
before the init restart. Could that ordering be folded into this patch so
the fix stands on its own?

> +
>  	ptp_port->link_up = linkup;

[Severity: Low]
This is a pre-existing issue, but link_up is written here with a plain
store. ice_ptp_process_tx_tstamp() reads it without a lock from the misc
IRQ thread:

	/* Drop packets if the link went down */
	link_up = ptp_port->link_up;

Should these accesses use WRITE_ONCE()/READ_ONCE()? KCSAN would report
this as a data race. The only effect is a stale bool deciding whether a
batch of timestamps is dropped around a link edge.

The later patch "ice: keep Tx timestamp slots tracked until completion or
timeout" removes this read from ice_ptp_process_tx_tstamp(). In the final
series, all remaining accesses use READ_ONCE()/WRITE_ONCE().

[ ... ]

> @@ -3498,8 +3497,10 @@ void ice_ptp_release(struct ice_pf *pf)
>  
>  	kthread_cancel_delayed_work_sync(&pf->ptp.work);
>  
> +	mutex_lock(&pf->adapter->ps_lock);
>  	ice_ptp_port_phy_stop(&pf->ptp.port);
> -	mutex_destroy(&pf->ptp.port.ps_lock);
> +	mutex_unlock(&pf->adapter->ps_lock);
> +
>  	if (pf->ptp.kworker) {
>  		kthread_destroy_worker(pf->ptp.kworker);
>  		pf->ptp.kworker = NULL;

[Severity: High]
This isn't a bug introduced by this patch, but here only phy_stop is
serialized against ice_ptp_link_change(). Can a concurrent link change
restart the PHY after release has torn things down?

ice_ptp_release() does three things outside ps_lock:

- sets pf->ptp.state = ICE_PTP_UNINIT with a plain store
- calls ice_ptp_release_tx_tracker() before taking the lock
- destroys pf->ptp.kworker after dropping the lock

ice_unload() calls ice_deinit_features()->ice_ptp_release() while the
netdev is still registered. The service task is only stopped later, in
ice_deinit_dev(). So ice_link_event(), ice_down() and ice_up_complete()
can still call ice_ptp_link_change() at this point.

The READY check in ice_ptp_link_change() runs before mutex_lock(), so a
caller that already passed it can block on ps_lock while release runs
phy_stop:

CPU1 (link event)                  CPU2 (ice_ptp_release)
ice_ptp_link_change()
  state == ICE_PTP_READY
                                   state = ICE_PTP_UNINIT
                                   mutex_lock(ps_lock)
  mutex_lock(ps_lock) blocks
                                   ice_ptp_port_phy_stop()
                                   mutex_unlock(ps_lock)
  ice_ptp_port_phy_restart()       kthread_destroy_worker(kworker)
                                   pf->ptp.kworker = NULL
    kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0)

On E82x, wouldn't this use the worker after it was destroyed, or
dereference NULL once kworker has been cleared?

"ice: call PTP link change only from link events" later in the series
moves the READY check under ps_lock, which closes the kworker case.

An E825 variant seems to remain in the final series, though:

- ice_ptp_link_change() can take ps_lock and see READY before release's
  unlocked UNINIT store.
- Its restart path then calls ice_ptp_flush_tx_tracker(pf, &ptp_port->tx),
  which walks tx->in_use and tx->tstamps without checking tx->init.
- At the same time, ice_ptp_release_tx_tracker() runs outside ps_lock and
  does kfree(tx->tstamps) and bitmap_free(tx->in_use).

Should the state change and the tracker and kworker teardown in
ice_ptp_release() also happen under ps_lock?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
