Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D430C177;
	Tue,  6 Oct 2026 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791252799; cv=none; b=TRZWmb/xidr9czM9Zb/CXqwNe2egCbXvVZ1aoHscKmkbAho5lBsLys/u1JoBdqCrpU89rSR6pXfJOyN9ziJykVZ/PnIUmnWYi3W6AkUvIOl6JO8Zrc5/ZIo2GllQUrpw/5eWPFr7XtAPsMKzUS0jmbT2g44JJSglV5I+tArwngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791252799; c=relaxed/simple;
	bh=np6q9pJW9P1F/+Hhh4mToljOyoqITkRLHhJSogV1KuQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PLiFZsS5m/7nBHJ20tDCJXHnTaGD7cJKvNM8a6jL1NVvH2w4LbUnpjFtxecm+UGobH90pBiqTfqEIkG7bYizfp/EYXfHPzxmdH9Wx65BC+f/wEeD2QcXfwl/l9bZixwRe7WFLWzV8GGdJiEYlyWAQOEDEH148N71+6t1lh1DQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSTefVO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSTefVO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC171F00893;
	Tue,  6 Oct 2026 02:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791252797;
	bh=x9zt8PinhKlyCrMCR/lpX5exNjAA5c9lk5rrohEnMl8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hSTefVO+vE8fzPjiKiDRpzbbojcKYVrHHbLZbKMwF7KybxYOrtV3dMrnwI+6RA8PP
	 uq4HdMQghi+1FXcD0wvqg3KgwJNyVdWP/CKmbvPFTQZa8qLLDwJIiHPiCK7V0xDQQT
	 +k7DG/1WgLC1MKnNu/X6cn2bP+2b8YGyqj/4GBIC+qwKOIr1unXCUH3CJDJMdPwNjo
	 4SoDG8MOdteCESkWhz3GbhaamozmJH+BmK4KJfWV/adtX0d+rFyr4jCNhXdvcZf/Wk
	 Wr7yV+YExae8mQo3me4Zejp0ofUt0ZTxVzt8slxoG8CbJowemBaF/VeywdYBhu/CmU
	 wqjYjEtlhwtTA==
Subject: Re: [PATCH net v6 3/4] net: wwan: t7xx: fix race between TX/RX data
 path and system PM suspend
From: netdev-bot+sashiko@kernel.org
To: tim770802@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ilpo.jarvinen@linux.intel.com, johannes@sipsolutions.net,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, linux-kernel@vger.kernel.org,
 tim.jh.chen@wnc.com.tw, Chih.Hung.Huang@wnc.com.tw
Date: Tue, 06 Oct 2026 02:13:16 +0000
Message-ID: <179125279630.434549.6372677921979413125@kernel.org>
In-Reply-To: <20261002014638.47981-4-tim770802@gmail.com>
References: <20261002014638.47981-4-tim770802@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] t7xx_dpmaif_suspend()
  (drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c:424-425) now calls…
- [High] The fix relies on t7xx_dpmaif_rx_stop() to "clear que_started
  and wait for the in-flight NAPI poll", so that no poll does MMIO or…
- [High] t7xx_dpmaif_suspend() assumes that after
  t7xx_dpmaif_disable_irq() "nothing re-arms the contexts drained below"…
- [High] Runtime suspend can now deadlock.
- [Medium] The commit message says "kthread_freezable_should_stop() also
  lets a concurrent kthread_stop() proceed while the thread is frozen".
- [Medium] The patch moves t7xx_dpmaif_hw_stop_all_txq() and
  t7xx_dpmaif_hw_stop_all_rxq() from the start of t7xx_dpmaif_suspend()…
- [Medium] In t7xx_do_tx_hw_push() (t7xx_hif_dpmaif_tx.c:416-455), the
  new freezing(current) bail-out at line 434 only sits in the…
- [Medium] The new cancel_work_sync(&dpmaif_ctrl->bat_release_work) in
  t7xx_dpmaif_suspend() (t7xx_hif_dpmaif.c:435) can discard a pending…

--

net: wwan: t7xx: fix race between TX/RX data path and system PM suspend

This patch makes the DPMAIF TX push kthread freezable. It also reworks
t7xx_dpmaif_suspend() to mask interrupts, drain the TX-done workers, stop
RX and cancel bat_release_work before the hardware queues are stopped.
The aim is to keep data-plane contexts off the device while the suspend
callback tears it down, which showed up as a soft lockup with ASPM L1.

> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
> index 7ff33c1d6ac75..b5a857e940b7c 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
> @@ -410,12 +410,32 @@ static int t7xx_dpmaif_stop(struct dpmaif_ctrl *dpmaif_ctrl)
>  static int t7xx_dpmaif_suspend(struct t7xx_pci_dev *t7xx_dev, void *param)
>  {
>  	struct dpmaif_ctrl *dpmaif_ctrl = param;
> +	unsigned int i;
>  
> +	/* Stop new TX and mask interrupts first, so nothing re-arms the
> +	 * contexts drained below.
> +	 */
>  	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
> -	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
> -	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
>  	t7xx_dpmaif_disable_irq(dpmaif_ctrl);

[Severity: High]
Does masking here really stop everything that can re-arm the contexts
drained below?

t7xx_dpmaif_disable_irq() only writes the PCIe MAC mask through
t7xx_pcie_mac_clear_int(). It does not call synchronize_irq(), and it
leaves dpmaif_ctrl->state unchanged.

Suppose a DPMAIF interrupt fired just before suspend. The hardirq handler
has already masked and returned IRQ_WAKE_THREAD, so the threaded handler
may still be running:

t7xx_dpmaif_isr_thread()
	t7xx_dpmaif_irq_cb(isr_para);
	t7xx_pcie_mac_set_int(dpmaif_ctrl->t7xx_dev, isr_para->pcie_int);

>From t7xx_dpmaif_irq_cb(), that thread can still reach:

- t7xx_dpmaif_irq_tx_done() -> queue_work(dpmaif_tx_work), after the
  cancel_work_sync() loop below has finished.
- t7xx_dpmaif_irq_rx_done() -> napi_schedule(), after
  t7xx_dpmaif_rx_stop(). The device is still RPM_ACTIVE during system
  suspend, so pm_runtime_resume_and_get() returns at once.

The mask_ulq_intr() MMIO poll inside the thread can take up to 10ms,
which makes this window realistic. IRQ threads are not frozen, and
suspend_device_irqs() only runs later, in the noirq phase.

The thread then calls t7xx_pcie_mac_set_int() unconditionally. That
unmasks the interrupt suspend has just masked.

Could TX-done work, NAPI polls and a re-enabled interrupt then reach the
hardware after hw_stop_all_txq/rxq and the H2D suspend handshake? Is a
synchronize_irq() on the DPMAIF vectors needed after disable_irq()?

> +
> +	/* irq_tx_done is masked now and cancel_work_sync() also blocks a
> +	 * self-requeue, so the TX-done workers can be drained here.
> +	 */
> +	for (i = 0; i < DPMAIF_TXQ_NUM; i++)
> +		cancel_work_sync(&dpmaif_ctrl->txq[i].dpmaif_tx_work);

[Severity: High]
Can this cancel_work_sync() discard the only code that unmasks the
queue's UL-DONE interrupt?

The ISR masks UL-DONE for each queue before it queues the work:

t7xx_dpmaif_irq_cb()
  t7xx_dpmaif_hw_get_intr_cnt()
    t7xx_dpmaif_hw_check_tx_intr()
		for_each_set_bit(index, &value, DPMAIF_TXQ_NUM)
			t7xx_dpmaif_mask_ulq_intr(hw_info, index);

At runtime, only t7xx_dpmaif_tx_done() unmasks it, and only on its final
pass:

		if (ret == -EAGAIN ||
		    (t7xx_dpmaif_ul_clr_done(hw_info, txq->index) &&
		     t7xx_dpmaif_drb_ring_not_empty(txq))) {
			queue_work(dpmaif_ctrl->txq[txq->index].worker,
				   &dpmaif_ctrl->txq[txq->index].dpmaif_tx_work);
			/* Give the device time to enter the low power state */
			t7xx_dpmaif_clr_ip_busy_sts(hw_info);
		} else {
			t7xx_dpmaif_clr_ip_busy_sts(hw_info);
			t7xx_dpmaif_unmask_ulq_intr(hw_info, txq->index);
		}

The unmask is skipped in two cases:

- The work is pending when suspend runs. It is removed and never
  executes.
- The work is running and takes the requeue branch. cancel_work_sync()
  blocks the requeue, as the new comment notes.

t7xx_dpmaif_resume() then does:

	t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);
	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
	t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);
	t7xx_dpmaif_start_hw(&dpmaif_ctrl->hw_info);

That restores the DL masks but not UL-DONE, and the cancelled work is
never requeued. The only other unmask, t7xx_dpmaif_init_intr(), runs only
on a full re-init.

Would the queue then get no further UL-DONE interrupts? In that case
t7xx_dpmaif_tx_release() never runs again, the DRB ring and tx_budget are
never reclaimed, and TX on that queue stalls until the modem is
re-initialised. This callback is also used for runtime suspend, so system
suspend is not the only trigger.

[Severity: High]
Could this cancel_work_sync() deadlock on the runtime suspend path?
Runtime suspend calls the same callback:

t7xx_pci_pm_runtime_suspend()
  __t7xx_pci_pm_suspend()
    entity->suspend()
      t7xx_dpmaif_suspend()

rpm_suspend() sets RPM_SUSPENDING before it calls the callback. The
DPMAIF interrupt stays enabled until t7xx_dpmaif_disable_irq() runs here.
The ISR only checks dpmaif_ctrl->state, so a UL-DONE interrupt in that
window queues dpmaif_tx_work. The work then does:

t7xx_dpmaif_tx_done()
  pm_runtime_resume_and_get()
    rpm_resume()
      /* sleeps uninterruptibly while runtime_status == RPM_SUSPENDING */

Meanwhile the suspend callback sits in cancel_work_sync() waiting for
that same work. The callback cannot return, so the status never leaves
RPM_SUSPENDING. t7xx_dpmaif_bat_release_work() makes the same
pm_runtime_resume_and_get() call, and it is also cancelled synchronously
below.

The commit message says:

  Runtime suspend is already safe: while any of these contexts holds its PM
  reference the runtime suspend callback cannot run.

That covers contexts that already hold a reference. Does it cover a
context that is still trying to take one? Before this patch the suspend
callback never waited on these works, so this cycle could not form.

> +
> +	/* t7xx_dpmaif_rx_stop() clears que_started and waits for the
> +	 * in-flight NAPI poll (rx_processing) to finish, so no poll issues
> +	 * MMIO after this point. It is also the sole producer of
> +	 * bat_release_work, so cancel that work only after rx_stop();
> +	 * otherwise a residual poll re-queues it and it runs against
> +	 * torn-down hardware.
> +	 */
>  	t7xx_dpmaif_rx_stop(dpmaif_ctrl);

[Severity: High]
Does t7xx_dpmaif_rx_stop() give the guarantee this comment and the commit
message describe ("clears que_started and waits for the in-flight NAPI RX
poll to finish")? It does the two steps in the other order:

t7xx_dpmaif_rx_stop() {
	...
		timeout = readx_poll_timeout_atomic(atomic_read, &rxq->rx_processing, value,
						    !value, 0, DPMAIF_CHECK_INIT_TIMEOUT_US);
		if (timeout)
			dev_err(dpmaif_ctrl->dev, "Stop RX SW failed\n");

		/* Ensure RX processing has stopped before we set rxq->que_started to false */
		smp_mb();
		rxq->que_started = false;
	...
}

The poll side sets rx_processing first and reads que_started afterwards:

t7xx_dpmaif_napi_rx_poll() {
	atomic_set(&rxq->rx_processing, 1);
	/* Ensure rx_processing is changed to 1 before actually begin RX flow */
	smp_mb();

	if (!rxq->que_started) {
	...
}

Take a poll that starts after the rx_processing check but before the
que_started store. It sees que_started == true and runs a full pass:

- t7xx_dpmaif_rx_start() -> t7xx_dpmaifq_rx_notify_hw() ->
  queue_work(bat_release_work)
- t7xx_dpmaif_clr_ip_busy_sts()
- t7xx_dpmaif_dlq_unmask_rx_done()

The timeout case is a second way in, since the timeout is only logged.
rx_processing stays at 1 across once_more and budget-exhausted repolls.
The DL hardware queues now stay enabled until after rx_stop(), so
sustained downlink could keep rx_processing set for the whole
DPMAIF_CHECK_INIT_TIMEOUT_US. rx_stop() would then return with a poll
still in progress.

In either case, could that poll do MMIO and requeue bat_release_work
after the cancel_work_sync() below and after hw_stop_all_rxq()?

> +	cancel_work_sync(&dpmaif_ctrl->bat_release_work);

[Severity: Medium]
Can this cancel drop a BAT refill that nothing replays on resume?
t7xx_dpmaif_bat_release_work() is the code that refills consumed RX
buffers:

	if (t7xx_pci_sleep_disable_complete(dpmaif_ctrl->t7xx_dev)) {
		t7xx_dpmaif_bat_release_and_add(rxq);
		t7xx_dpmaif_frag_bat_release_and_add(rxq);
	}

Its only producer is t7xx_dpmaifq_rx_notify_hw(), called from the NAPI
poll. t7xx_dpmaif_resume() does not requeue it.

Suppose heavy RX just before suspend used up the BAT ring. After resume
the hardware has no free entry to place a packet in. So no DL-DONE
interrupt fires, no NAPI poll runs, and the refill never happens.
DPF_INTR_DL_BATCNT_LEN_ERR only unmasks itself again.

Would RX then stay stalled after resume? If the ring was not fully used
up, the next poll recovers it. So this depends on the ring running dry
first.

> +
> +	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
> +	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);

[Severity: Medium]
The hardware queue-disable calls move from the start of the callback to
the end:

  old: tx_stop -> hw_stop_all_txq -> hw_stop_all_rxq -> disable_irq
       -> rx_stop
  new: tx_stop -> disable_irq -> cancel TX work -> rx_stop
       -> cancel bat work -> hw_stop_all_txq -> hw_stop_all_rxq

The commit message does not mention this reorder. Was it intentional?

DL hardware is now still enabled during t7xx_dpmaif_rx_stop(). Sustained
downlink can keep NAPI returning full budget, which makes the rx_stop()
timeout above reachable. Before the patch DL was stopped first, so NAPI
could drain.

There is a second effect. Once rx_stop() marks the queues stopped, PIT
entries the hardware produces before hw_stop_all_rxq() are not consumed.
The "middle PIT sync" wait in t7xx_dpmaif_hw_stop_all_rxq() now runs with
software consumption already stopped:

	count = 0;
	do {
		wr_idx = ioread32(hw_info->pcie_base + DPMAIF_AO_DL_PIT_WR_IDX);
		wr_idx &= DPMAIF_DL_RD_WR_IDX_MSK;
		rd_idx = ioread32(hw_info->pcie_base + DPMAIF_AO_DL_PIT_RD_IDX);
		rd_idx &= DPMAIF_DL_RD_WR_IDX_MSK;

		if (wr_idx == rd_idx)
			return 0;
	} while (++count < DPMAIF_MAX_CHECK_COUNT);

The caller also ignores its return value. Is that wait still expected to
succeed with the new order?

>  	return 0;
>  }
>  
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> index 2a405bc743121..450e030fc6962 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c

[ ... ]

> @@ -426,6 +427,12 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
>  
>  		drb_send_cnt = t7xx_txq_burst_send_skb(txq);
>  		if (drb_send_cnt <= 0) {
> +			/* Bail out promptly on a pending freeze so the caller can
> +			 * drop its runtime-PM reference and this thread can reach
> +			 * the freeze point instead of looping here under load.
> +			 */
> +			if (freezing(current))
> +				return;

[Severity: Medium]
The freeze check only covers the drb_send_cnt <= 0 branch. On the
success path the loop calls t7xx_dpmaif_ul_update_hw_drb_cnt() and
cond_resched(), then repeats on:

	} while (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) && !kthread_should_stop() &&
		 (dpmaif_ctrl->state == DPMAIF_STATE_PWRON));

That condition does not check for a pending freeze.

Consider skbs that arrive fast enough to keep the lists non-empty but not
fast enough to fill the ring. Forwarded traffic, or TCP ACKs and
retransmits sent from softirq after userspace is frozen, would do it.
Does the thread ever get back to kthread_freezable_should_stop() in
t7xx_dpmaif_tx_hw_push_thread() in that case?

If it doesn't, freeze_kernel_threads() hits freeze_timeout_msecs and
system suspend aborts. Before this patch the thread was not freezable, so
it could not block the freezer.

Should the loop condition check freezing(current) as well?

>  			usleep_range(10, 20);
>  			cond_resched();
>  			continue;
> @@ -457,19 +464,30 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)

[ ... ]

> +		/* Park on a pending freeze here, outside the runtime-PM and MMIO
> +		 * section below, so the PM freezer quiesces this thread before
> +		 * dpm_suspend() runs the device suspend callbacks.
> +		 * kthread_freezable_should_stop() also honours a concurrent
> +		 * kthread_stop() while the thread is frozen.
> +		 */
> +		if (kthread_freezable_should_stop(NULL))
> +			break;

[Severity: Medium]
Is the last sentence of this comment accurate? The commit message makes
the same claim:

  kthread_freezable_should_stop() also lets a concurrent
  kthread_stop() proceed while the thread is frozen

In the refrigerator the thread is in TASK_FROZEN. kthread_stop() does:

	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
	kthread_unpark(k);
	set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
	wake_up_process(k);
	wait_for_completion(&kthread->exited);

wake_up_process() uses TASK_NORMAL, and ttwu_state_match() does not wake
a TASK_FROZEN task. A saved_state match only updates saved_state.

__refrigerator(true) re-checks kthread_should_stop() only after it has
been woken. That handles a stop issued before the thread freezes, not
one issued while it is frozen.

So during the freeze window, this kthread_stop() now blocks until
thaw_processes():

t7xx_ccmni_exit()
  t7xx_dpmaif_hif_exit()
    t7xx_dpmaif_sw_release()
      t7xx_dpmaif_tx_thread_rel()
        kthread_stop()

The commit message mentions unbind holding device_lock as a non-frozen
context. If this runs from such a context, could dpm_suspend() or
dpm_resume() end up waiting on that same lock?

The kerneldoc for kthread_freezable_should_stop() makes a similar claim,
which may be where this wording came from.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002014638.47981-1-tim770802%40gmail.com
