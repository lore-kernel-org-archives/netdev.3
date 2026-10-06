Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A130ACF0;
	Tue,  6 Oct 2026 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252803; cv=none; b=hW0qW1FsKNQ60Pv3ZMCALfgcSRP0KnoRV9wFxTv+84wgfb/bSQYHfqFsJ+Mqs53EXAVWlcLf9uGrYs1SBWQEtEJ1jskSJfQ+kF8yUQRmThWqN3E8jsUAw9Lr4ce6893+lyzIqJm4ukq+SqYq+MuOQDdIvwM1QtngLN1Y5LRE77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252803; c=relaxed/simple;
	bh=Sy7ZG8F8I42UlJSn2r+fZy8Yz7GXel3s+WmXnuZMCI4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhYpeUdl68sGC3NytiKPhuLbn6wjs2CzidfA6cSEZ2rKVug8FArEbP2q4q3s9m1NGgRjxmYl0KV1sdS2o4RDYAepe4jxxQ4XIocANw09pmGSaHl0l61lJSa/oTuioTPdCY0tWHfE7klHJEglhFN1iDwlx6a3+wXW3d8PM0bMF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cExTTGNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cExTTGNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC921F000FF;
	Tue,  6 Oct 2026 02:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791252799;
	bh=0vv3oOj+BuuQqlFyQE4+IDBtBVeSsbYAbbUXZ72DE8E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cExTTGNo+4jVcUxVo7UGK13ndTLETjD6Pi1Q3Ke+WmWjhFGinBgK21HW3hqoXzl8m
	 +gPD3ix/snFGp8ounFUg0bQx1/Sp4ar741vtvdoTbOEnc5UHonsGxbuTpAkdw4a8mf
	 ywJ+tsypGCdJeXqrURB3cjn0quv5fc5lkNKeuXGZ/Cr39DyTqlCGpnwWBGjTZae5Es
	 ivnw4RVsvgKnMUS2ww7ABIglRd/OvB2FCIYGtM4XPTh9hGarVgR8xjp3aPhXcGeCl/
	 OxO4HTtEx7+NJ3mVzXT61V7Kz87mp9EUX8ejL3OmRTXeiEC1cBhzCHCaBnl4XW5xPU
	 2oLbX+uadjgXg==
Subject: Re: [PATCH net v6 4/4] net: wwan: t7xx: complete NAPI on the
 not-started RX poll early return
From: netdev-bot+sashiko@kernel.org
To: tim770802@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ilpo.jarvinen@linux.intel.com, johannes@sipsolutions.net,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, linux-kernel@vger.kernel.org,
 tim.jh.chen@wnc.com.tw, Chih.Hung.Huang@wnc.com.tw
Date: Tue, 06 Oct 2026 02:13:18 +0000
Message-ID: <179125279802.434549.7622382865971659585@kernel.org>
In-Reply-To: <20261002014638.47981-5-tim770802@gmail.com>
References: <20261002014638.47981-5-tim770802@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The handshake between t7xx_dpmaif_rx_stop() and
  t7xx_dpmaif_napi_rx_poll() can let a poll run past the stop.
- [Low] The Fixes: tag points at the wrong commit.
- [Low] The new comment in t7xx_dpmaif_napi_rx_poll() says the hang
  happens in "napi_synchronize() in t7xx_ccmni_disable_napi() (which…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the
  !que_started early return in t7xx_dpmaif_napi_rx_poll() (lines…

--

net: wwan: t7xx: complete NAPI on the not-started RX poll early return

The patch adds a napi_complete_done() call to the !que_started early
return in t7xx_dpmaif_napi_rx_poll(). Without that call, a poll that
returns 0 after t7xx_dpmaif_rx_stop() leaves NAPI_STATE_SCHED set. A later
napi_synchronize() in t7xx_ccmni_disable_napi() then hangs.

> Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")

[Severity: Low]
Is this the right commit for the Fixes: tag?

At d642b012df70, drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c has no NAPI
code. RX ran from a workqueue, so returning early on !que_started was fine
at that point.

The NAPI ->poll() form came from 5545b7b9f294 ("net: wwan: t7xx: Add NAPI
support"). That is t7xx_dpmaif_napi_rx_poll(napi, budget), with the
dev_err() followed by return work_done and no napi_complete_done().

Should it be this instead?

Fixes: 5545b7b9f294 ("net: wwan: t7xx: Add NAPI support")

d642b012df70 is in v5.19, and 5545b7b9f294 was merged for v6.2. With the
current tag, stable tooling would try to apply this to 6.1.y, which has no
t7xx_dpmaif_napi_rx_poll().

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index 0e1174ee611df..6272956fe0535 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> @@ -848,6 +848,12 @@ int t7xx_dpmaif_napi_rx_poll(struct napi_struct *napi, const int budget)
>  		atomic_set(&rxq->rx_processing, 0);
>  		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
>  		dev_err(rxq->dpmaif_ctrl->dev, "Work RXQ: %d has not been started\n", rxq->index);
> +		/* Returning work_done < budget without completing the NAPI would
> +		 * leave NAPI_STATE_SCHED set, hanging a later napi_synchronize()
> +		 * in t7xx_ccmni_disable_napi() (which holds rtnl_lock). Complete
> +		 * it here so the queue is cleanly unscheduled after rx_stop().
> +		 */

[Severity: Low]
Is the "(which holds rtnl_lock)" part of this comment accurate?
t7xx_ccmni_disable_napi() doesn't take any lock:

drivers/net/wwan/t7xx/t7xx_netdev.c:t7xx_ccmni_disable_napi() {
	if (!ctlb->is_napi_en)
		return;

	for (i = 0; i < RXQ_NUM; i++) {
		napi_synchronize(ctlb->napi[i]);
		napi_disable(ctlb->napi[i]);
	}
	...
}

rtnl is held only when the core reaches it through .ndo_stop, which is
t7xx_ccmni_close().

The other caller is the modem state path. It runs in FSM context without
rtnl:

t7xx_ccmni_md_state_callback()    /* MD_STATE_EXCEPTION / MD_STATE_STOPPED */
  t7xx_ccmni_post_stop()
    t7xx_ccmni_disable_napi()
      napi_synchronize()

On the exception path, this is the first napi_synchronize() to hit a
stranded NAPI_STATE_SCHED. By then que_started has already been cleared
through
t7xx_dpmaif_md_state_callback()->t7xx_dpmaif_stop()->t7xx_dpmaif_stop_sw()->t7xx_dpmaif_rx_stop().

The t7xx driver never takes rtnl_lock itself. Could the comment say that
rtnl_lock is held only on the ndo_stop path, or drop the lock reference?

> +		napi_complete_done(napi, work_done);
>  		return work_done;
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but this early return still
doesn't undo an earlier t7xx_pci_disable_sleep() from the same scheduling
cycle. It doesn't call t7xx_pci_enable_sleep(), and it doesn't clear
rxq->sleep_lock_pending.

There are two ways to reach it with a sleep-disable vote still
outstanding.

(a) An earlier poll used up its budget or set once_more. It returned with
sleep_disable_count incremented and rx_processing still 1.

(b) An earlier poll took the retry branch:

	ret = try_wait_for_completion(&t7xx_dev->sleep_lock_acquire);
	if (!ret) {
		napi_complete_done(napi, work_done);
		rxq->sleep_lock_pending = true;
		napi_schedule(napi);
		return work_done;
	}

In both cases t7xx_dpmaif_rx_stop() can time out and clear que_started
anyway:

		timeout = readx_poll_timeout_atomic(atomic_read, &rxq->rx_processing, value,
						    !value, 0, DPMAIF_CHECK_INIT_TIMEOUT_US);
		if (timeout)
			dev_err(dpmaif_ctrl->dev, "Stop RX SW failed\n");
		...
		rxq->que_started = false;

Can the next poll then take this early return with sleep_disable_count
still raised, or with sleep_lock_pending stale?

sleep_disable_count is never reset. If it stays raised,
t7xx_dev_set_sleep_capability(true) wouldn't run again. Later
t7xx_pci_disable_sleep() calls would also skip the count == 1 DS_LOCK
handshake.

The accounting also looks unbalanced apart from this branch. Each repoll
after a budget-exhausting or once_more return calls
t7xx_pci_disable_sleep() again, because sleep_lock_pending is false. The
completion branch calls t7xx_pci_enable_sleep() only once.

This patch doesn't make things worse. In case (b), the stale flag now makes
the next poll skip t7xx_pci_disable_sleep() and call
t7xx_pci_enable_sleep() on completion, which cancels out the leaked count.

[Severity: High]
Can a new poll still get past t7xx_dpmaif_rx_stop() through this check?
The current ordering doesn't seem able to keep a newly starting poll out.

t7xx_dpmaif_rx_stop() loads rx_processing, does smp_mb(), and then stores
que_started = false. The poll stores rx_processing = 1, does smp_mb(), and
then loads que_started. Because the stop side does a load and then a
store, this interleaving is allowed:

CPU0 (t7xx_dpmaif_rx_stop)        CPU1 (t7xx_dpmaif_napi_rx_poll)
reads rx_processing == 0
                                  atomic_set(&rxq->rx_processing, 1);
                                  smp_mb();
                                  reads que_started == true
smp_mb();
rxq->que_started = false;
returns

A new poll can be scheduled here even after the IRQ is masked. If an RX
IRQ arrived during the previous poll, NAPIF_STATE_MISSED is set. That
poll's napi_complete_done() then reschedules it with __napi_schedule(), and
only afterwards does it store rx_processing = 0.

CPU1 would then run the full RX path while the rest of
t7xx_dpmaif_suspend() runs. That includes:

t7xx_dpmaifq_rx_notify_hw()
  queue_work(dpmaif_ctrl->bat_release_wq, &dpmaif_ctrl->bat_release_work);

This can run after cancel_work_sync(&dpmaif_ctrl->bat_release_work). The
PIT/BAT updates and the MMIO in t7xx_dpmaif_clr_ip_busy_sts() and
t7xx_dpmaif_dlq_unmask_rx_done() can also run at the same time as
t7xx_dpmaif_hw_stop_all_rxq() and the H2D suspend requests.

That conflicts with what the earlier patch in this series ("net: wwan:
t7xx: fix race between TX/RX data path and system PM suspend") relies on
in t7xx_dpmaif_suspend():

	/* t7xx_dpmaif_rx_stop() clears que_started and waits for the
	 * in-flight NAPI poll (rx_processing) to finish, so no poll issues
	 * MMIO after this point. It is also the sole producer of
	 * bat_release_work, so cancel that work only after rx_stop();
	 ...
	 */
	t7xx_dpmaif_rx_stop(dpmaif_ctrl);
	cancel_work_sync(&dpmaif_ctrl->bat_release_work);

The same path can also be reached on a modem exception through
t7xx_dpmaif_stop_sw().

The load-then-store order in t7xx_dpmaif_rx_stop() dates back to
d642b012df70, but this series now depends on it to guarantee that no
MMIO happens after the stop.

Would this ordering close the window?

- In t7xx_dpmaif_rx_stop(): store que_started = false with WRITE_ONCE(),
  then smp_mb(), then wait for rx_processing == 0.
- In t7xx_dpmaif_napi_rx_poll(): read que_started with READ_ONCE().

>  
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002014638.47981-1-tim770802%40gmail.com
