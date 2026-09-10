Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F9472F8C;
	Thu, 10 Sep 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039830; cv=none; b=b+1KyD8rey3Fg4ysElKuVIUE7gPsZfYsZhDWSCFZGSAZDBU2qdRe04A+v1bM78b+fCAbofc3x04W2t9vtnSdpgSf2Of+tZ2M/8AwQeGcFgWkYAjWx6swJnkQVMvsDu7l0m1IM02X95xoyj9N4zVxHqzMb0/eX2ieRns/zrRzTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039830; c=relaxed/simple;
	bh=EYa/EXPaMF3lVJtQI9DTQfWGwSnPDHUuKmzBG5+MpM8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJhCw1649SKkY+yicUHYUJWfvuxbsYX20CB/WtJhRkJQjB8+0+i0J27p2grdC28SRhgMoHYgzkr9/UV3zH/iVkJLJdyuLut4DFbAuwsg6WLPKlmMoJRJuCC37b0LsB+E9Bkl3iJ1mnd9ryWmoxoCBygA63ZkNlGq72++6v0ru1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqw4Qr1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqw4Qr1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6019F1F000FF;
	Thu, 10 Sep 2026 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039827;
	bh=pnKRiiLrT6lTR111wGlkfOuwWMt/vBsd0mE0cj4XhjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Aqw4Qr1DboeAHEY+fIsDlQWqoj2LHPPiZZ2qjLdkvBe2s2P2tjQTTiDYw/k21BmBq
	 /GUqLV6cqSMX3nsYTtA6sWHn3hc3lFFqj4ubuCw89KN+EksaMio887ot4zeA1S1QTE
	 Li9Dpp1lXuBXhp7HcZ3k+q+S9WmdXMrRvp8C8a6xPElVxi1Bi40YmAgCfZI2xXQ9ZC
	 1yhYn168mmgEVv1yMus1JELPFyDdIwnA2m+my1RGtNLgrPs/InKysI3ykvXPLTMZKX
	 kB2tPe0/QWBGKlvZthl7cj7oWl1F225ogGDmA2AvYvqJsF4ONpczUqZqstScJ8OvWS
	 RNU3VlYQNwRGw==
Subject: Re: [PATCH net v5] net: wwan: t7xx: fix race between TX path and
 system PM suspend
From: netdev-bot+sashiko@kernel.org
To: tim770802@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, simon.horman@ghnetworks.de,
 haijun.liu@mediatek.com, chandrashekar.devegowda@intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, tim.jh.chen@wnc.com.tw,
 Chih.Hung.Huang@wnc.com.tw
Date: Thu, 10 Sep 2026 11:30:25 +0000
Message-ID: <178903982593.219967.5206374303136094723@kernel.org>
In-Reply-To: <20260907082938.7500-1-tim770802@gmail.com>
References: <20260907082938.7500-1-tim770802@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 3 (1) · Medium: 0 (1) · Low: 0

- [High] Incomplete fix: the commit message claims to "Quiesce all
  hardware-accessing contexts with the PM freezer" and that "none of…
- [High] Marking the CLDMA TX/RX workers, the DPMAIF TX-done worker and
  the BAT-release workqueue WQ_FREEZABLE creates blocking dependencies…
- [High] The TX push kthread is parked with plain try_to_freeze(), which
  calls __refrigerator(false) (include/linux/freezer.h:56-64).

Pre-existing issues:
- [High] t7xx_dpmaif_tx_hw_push_thread() can end its own lifetime
  ('return ret' when pm_runtime_resume_and_get() fails with anything…
- [Medium] In t7xx_dpmaif_tx_hw_push_thread() the -EACCES return of
  pm_runtime_resume_and_get() is treated as success, but…

--

net: wwan: t7xx: fix race between TX path and system PM suspend

This makes the DPMAIF TX push kthread freezable (set_freezable(),
wait_event_freezable(), try_to_freeze(), plus a freezing(current) bail-out
in the DRB-ring-full retry loop) and marks the CLDMA TX/RX workers, the
DPMAIF TX-done worker and the BAT-release workqueue WQ_FREEZABLE, so the PM
freezer parks them before the device suspend callbacks run.

A few questions about the freezer-based approach below.

[Severity: High]

The commit message says:

  "Quiesce all hardware-accessing contexts with the PM freezer, which runs
   before dpm_suspend() invokes the device suspend callbacks."

and

  "Tasks and work items are thawed only after the resume callbacks have
   re-armed the hardware, so none of these contexts can issue MMIO against
   a torn-down or not-yet-rearmed device."

Are all such contexts really covered?  t7xx_cldma_send_skb() has the same
pattern this patch is trying to quiesce:

drivers/net/wwan/t7xx/t7xx_hif_cldma.c:t7xx_cldma_send_skb() {
	ret = pm_runtime_resume_and_get(md_ctrl->dev);
	if (ret < 0 && ret != -EACCES)
		return ret;

	t7xx_pci_disable_sleep(md_ctrl->t7xx_dev);
	...
}

and it is reached from contexts the freezer never touches:

  fsm_main_thread()      (kthread_run in t7xx_state_monitor.c, no
                          set_freezable(), plain wait_event_interruptible)
  port_ctl_rx_thread()   (kthread_run in t7xx_port_ctrl_msg.c, same)
  md_hk_wq              (WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI, not
                          freezable)

After this patch the only set_freezable() in the driver is the one added to
t7xx_dpmaif_tx_hw_push_thread(), so those two kthreads inherit PF_NOFREEZE
from kthreadd and keep running through the whole freeze window.  A modem
MHCCIF interrupt during that window appends an FSM command
(t7xx_fsm_recv_md_intr() -> t7xx_fsm_append_cmd()) and wakes the FSM
kthread, which then drives CLDMA start/stop and control-message MMIO.

The DPMAIF receive side looks similarly uncovered:

  t7xx_dpmaif_irq_rx_done()   takes the runtime PM reference from the
                              non-freezable threaded IRQ handler and
                              napi_schedule()s
  t7xx_dpmaif_napi_rx_poll()  writes registers via
                              t7xx_dpmaif_clr_ip_busy_sts() and
                              t7xx_dpmaif_dlq_unmask_rx_done() from softirq

The freezer cannot park a softirq, and t7xx_dpmaif_suspend() only calls
t7xx_dpmaif_rx_stop() after it has already run
t7xx_dpmaif_hw_stop_all_txq()/t7xx_dpmaif_hw_stop_all_rxq() and
t7xx_dpmaif_disable_irq(), with no napi_disable()/napi_synchronize()
anywhere in the PM callbacks.

Would explicit quiescing in the PM callbacks (napi_disable() /
napi_synchronize(), plus gating or making the control kthreads freezable) be
needed for those paths, rather than more freezer participation?

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> index 2917cee9b8028..b70ec84d50a99 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
> @@ -1316,7 +1316,7 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
>  		md_cd_queue_struct_init(&md_ctrl->txq[i], md_ctrl, MTK_TX, i);
>  		md_ctrl->txq[i].worker =
>  			alloc_ordered_workqueue("md_hif%d_tx%d_worker",
> -					WQ_MEM_RECLAIM | (i ? 0 : WQ_HIGHPRI),
> +					WQ_MEM_RECLAIM | WQ_FREEZABLE | (i ? 0 : WQ_HIGHPRI),
>  					md_ctrl->hif_id, i);
>  		if (!md_ctrl->txq[i].worker)
>  			goto err_workqueue;

[Severity: High]

Can marking these four workqueues WQ_FREEZABLE block contexts that are not
themselves frozen?

freeze_workqueues_begin() sets workqueue_freezing and wq_adjust_max_active()
forces max_active to 0 for every WQ_FREEZABLE workqueue, so items queued
during the freeze window sit on pwq->inactive_works until thaw_workqueues()
at the very end of resume.  A flush_work() on such an item links its barrier
behind the inactive item, so the flush blocks until thaw.  The WQ_MEM_RECLAIM
rescuer only walks pool->worklist, so it cannot drain inactive items either.

There are synchronous waiters on exactly these items that the freezer does
not freeze:

drivers/net/wwan/t7xx/t7xx_hif_cldma.c:t7xx_cldma_stop() {
	if (md_ctrl->is_late_init) {
		for (i = 0; i < CLDMA_TXQ_NUM; i++)
			flush_work(&md_ctrl->txq[i].cldma_work);

		for (i = 0; i < CLDMA_RXQ_NUM; i++)
			flush_work(&md_ctrl->rxq[i].cldma_work);
	}
}

t7xx_cldma_stop() is reached from the non-freezable FSM kthread
(fsm_routine_start() -> t7xx_lk_stage_event_handling(), fsm_routine_stopping()),
from t7xx_md_exception() and from t7xx_cldma_exit() on the remove path.

There is also a budget wait with no timeout:

drivers/net/wwan/t7xx/t7xx_hif_cldma.c:t7xx_cldma_send_skb() {
	ret = wait_event_interruptible_exclusive(queue->req_wq, queue->budget > 0);
}

The only place that replenishes queue->budget is t7xx_cldma_gpd_tx_collect()
(the sole "queue->budget++"), which runs from t7xx_cldma_tx_done() on the
md_hif%d_tx%d_worker this hunk freezes.  That wait is held with a runtime PM
reference and t7xx_pci_disable_sleep() in effect.

The same shape exists for the two DPMAIF workqueues touched below:
t7xx_dpmaif_bat_wq_rel() flushes bat_release_work with no preceding cancel,
and t7xx_dpmaif_txq_flush_rel() does cancel_work_sync() followed by
flush_work() on an item that t7xx_dpmaif_irq_tx_done() can re-queue after
the cancel.

If the blocked waiter is t7xx_cldma_exit() -> t7xx_cldma_stop() on an
unbind/hot-unplug, it holds device_lock(), and dpm_prepare() (which runs
after the freezer) then blocks in wait_for_device_probe()/device_prepare(),
so the suspend can never reach thaw_processes().  Can this hang the suspend
outright?

Separately, t7xx_pci_pm_prepare() waits on init_done with
T7XX_INIT_TIMEOUT; if the handshake path is stuck on a frozen workqueue,
does that turn into an aborted suspend after the timeout?

> @@ -1330,7 +1330,7 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
>  
>  		md_ctrl->rxq[i].worker =
>  			alloc_ordered_workqueue("md_hif%d_rx%d_worker",
> -						WQ_MEM_RECLAIM,
> +						WQ_MEM_RECLAIM | WQ_FREEZABLE,
>  						md_ctrl->hif_id, i);
>  		if (!md_ctrl->rxq[i].worker)
>  			goto err_workqueue;
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index 5af90ca6e0631..0fe2dd1363a4b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> @@ -1088,7 +1088,7 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
>  int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl)
>  {
>  	dpmaif_ctrl->bat_release_wq = alloc_workqueue("dpmaif_bat_release_work_queue",
> -						      WQ_MEM_RECLAIM | WQ_PERCPU,
> +						      WQ_MEM_RECLAIM | WQ_PERCPU | WQ_FREEZABLE,
>  						      1);
>  	if (!dpmaif_ctrl->bat_release_wq)
>  		return -ENOMEM;
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> index 236d632cf591b..cce71c827e7b2 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c

[ ... ]

> @@ -421,6 +422,12 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
>  
>  		drb_send_cnt = t7xx_txq_burst_send_skb(txq);
>  		if (drb_send_cnt <= 0) {
> +			/* If a freeze is pending the TX-done worker may already be
> +			 * frozen and unable to drain the DRB ring; return to the
> +			 * caller so PM resources are released before try_to_freeze().
> +			 */
> +			if (freezing(current))
> +				return;
>  			usleep_range(10, 20);
>  			cond_resched();
>  			continue;
> @@ -447,19 +454,28 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
>  	struct dpmaif_ctrl *dpmaif_ctrl = arg;
>  	int ret;
>  
> +	set_freezable();
> +
>  	while (!kthread_should_stop()) {
>  		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
>  		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
> -			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
> -						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
> -						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
> -						     kthread_should_stop()))
> +			if (wait_event_freezable(dpmaif_ctrl->tx_wq,
> +						 (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
> +						  dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
> +						 kthread_should_stop()))
>  				continue;
>  
>  			if (kthread_should_stop())
>  				break;
>  		}
>  
> +		/* Freeze here, outside the runtime-PM and MMIO section below, so
> +		 * the system suspend freezer parks this thread before the device
> +		 * suspend callbacks tear the DPMAIF hardware down.
> +		 */
> +		if (try_to_freeze())
> +			continue;
> +

[Severity: High]

Should this be kthread_freezable_should_stop() instead of a bare
try_to_freeze()?

try_to_freeze() calls __refrigerator(false), and inside __refrigerator() the
loop condition is:

kernel/freezer.c:__refrigerator() {
	...
	for (;;) {
		bool freeze;
		...
		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
	...
}

With check_kthr_stop false a pending stop is ignored, and the task sits in
TASK_FROZEN, which wake_up_process()'s TASK_NORMAL mask does not match.  So
a concurrent

drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c:t7xx_dpmaif_tx_thread_rel() {
	if (dpmaif_ctrl->tx_thread)
		kthread_stop(dpmaif_ctrl->tx_thread);
}

blocks in wait_for_completion(&kthread->exited) until thaw_processes().

kthread_freezable_should_stop() documents this case:

kernel/kthread.c:
 * kthread_should_stop() for freezable kthreads, which will enter
 * refrigerator if necessary.  This function is safe from kthread_stop() /
 * freezer deadlock and freezable kthreads should use this function instead
 * of calling try_to_freeze() directly.

The only callers of t7xx_dpmaif_tx_thread_rel() are the probe error path and
remove (t7xx_ccmni_exit() -> t7xx_dpmaif_hif_exit()), both of which hold
device_lock()/the probe count.  If dpm_prepare() then blocks on
wait_for_device_probe()/device_lock() for the same device, does the suspend
ever reach thaw_processes()?

>  		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
>  		if (ret < 0 && ret != -EACCES)
>  			return ret;

[Severity: Medium]

This isn't a bug introduced by this patch, and the changelog already notes
it is deferred, but for the record: pm_runtime_resume_and_get() already
dropped the usage count before returning -EACCES:

include/linux/pm_runtime.h:pm_runtime_get_active() {
	ret = __pm_runtime_resume(dev, RPM_GET_PUT | rpmflags);
	if (ret < 0) {
		pm_runtime_put_noidle(dev);
		return ret;
	}
}

The loop body still ends with an unconditional
pm_runtime_put_autosuspend(dpmaif_ctrl->dev), so does each -EACCES
iteration drop a reference the thread does not hold and drive usage_count
negative?

[Severity: High]

This is also pre-existing rather than something this patch introduces, but
the "return ret" here ends the thread's own lifetime while
dpmaif_ctrl->tx_thread still points at that task.  The thread is created
with kthread_run() and no extra task reference is kept, so kthreadd can reap
the task_struct.  A later t7xx_dpmaif_tx_thread_rel() then does:

drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c:t7xx_dpmaif_tx_thread_rel() {
	if (dpmaif_ctrl->tx_thread)
		kthread_stop(dpmaif_ctrl->tx_thread);
}

and kthread_stop() immediately does get_task_struct(k) and to_kthread(k) on
that pointer.  kthread_stop()'s kerneldoc covers this:

kernel/kthread.c:
 * If threadfn() may call kthread_exit() itself, the caller must ensure
 * task_struct can't go away.

Can this be a use-after-free of the task_struct when a hard error (for
example -EINVAL once dev->power.runtime_error is set after a failed resume)
makes the thread self-exit and the device is later unbound?  Before that,
TX push is permanently dead with nothing reported.

Would clearing dpmaif_ctrl->tx_thread on exit, holding a task reference, or
not self-exiting at all fit better here, given that this thread's PM
handling is being reworked anyway?

>  
>  		t7xx_pci_disable_sleep(dpmaif_ctrl->t7xx_dev);
>  		t7xx_do_tx_hw_push(dpmaif_ctrl);
>  		t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
>  		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
>  	}
> @@ -617,7 +633,7 @@ int t7xx_dpmaif_txq_init(struct dpmaif_tx_queue *txq)
>  	}
>  
>  	txq->worker = alloc_ordered_workqueue("md_dpmaif_tx%d_worker",
> -				WQ_MEM_RECLAIM | (txq->index ? 0 : WQ_HIGHPRI),
> +				WQ_MEM_RECLAIM | WQ_FREEZABLE | (txq->index ? 0 : WQ_HIGHPRI),
>  				txq->index);
>  	if (!txq->worker)
>  		return -ENOMEM;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907082938.7500-1-tim770802%40gmail.com
