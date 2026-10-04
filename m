Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0941930F;
	Sun,  4 Oct 2026 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105163; cv=none; b=dS6n3fOMtBxKRr/YNX/+GveKX18+2U3JhLDTKmlIzgZTYEyHrbq1TclqXzNlfAtH/LCozC35KnYwvZUjvIYecegsqwRQuX0euCdJbHQ3cp89DvBcy47XoS3Gi7foPPUjOb+9hoNZYncAbR/onCqoIKrwWxVFngQVjOpD+3UmY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105163; c=relaxed/simple;
	bh=R6nm5CPtgMHSNQf/4kCuBxGM9l7+uDkqPCKvf87tjIk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcSmoQn6JprwcBa6rdrJF6oic8wcYVSpYDzxqaix8mldSCVPv/CDaRNt8Lr1PdO0GMbcSom1DRSDhBGY0h0/pXehmweeTD6uWUMklg9KcYLiHnCc1+Wzpu0aFLmhALIcgkl2CGXwUKDkKDXTI1kv4y1/mjcFRbR4vnGy3i6rP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8dYDMBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8dYDMBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395131F00899;
	Sun,  4 Oct 2026 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105160;
	bh=Zna8m+vw1RWGEQgBqdQPaVJmN/rHO5KCpQzP/sBKZ78=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j8dYDMBPS8oIzpb2EOIEaWeR2glu/blQr58/rYM/pkeCEMrsTfyyep14jBIKRitNq
	 yBMY6BpkLic2S4h+4VLjIPEHo54fxLbfa3THsbXDRlECzF1PMpmvtTmEId9lyBNRMN
	 kZK1P2jgUGWdiOLveiQzqk3EkSYL8vBUrIaCcTUk/M4j6ZF0lyG/JL5uMpx7rNtLKb
	 z9kwkIsWX9eFzOYTJOfrua+BP2470vop3qwgW1bksqSaBk1L7K9MKHggPbEDCbJ9v0
	 SvijqnjtmrPjvlyPfF9QPF5INs+G9XTXZ4Azq4VJWMUjk+zTsz82g8+9Yo3hd1OJdi
	 sfdrr5HYYPDkA==
Subject: Re: [PATCH v9 5/6] net: wwan: t9xx: Add FSM thread
From: netdev-bot+sashiko@kernel.org
To: jackbb_wu@compal.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wen-zhi.huang@mediatek.com, shi-wei.yeh@mediatek.com,
 Minano.tseng@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robert_yu@compal.com, Jeff_Chang@compal.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-doc@vger.kernel.org
Date: Sun, 04 Oct 2026 09:12:38 +0000
Message-ID: <179110515875.434549.15342661090118032987@kernel.org>
In-Reply-To: <20260930-t9xx_driver_v1-v9-5-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-5-3248b9256956@compal.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 15 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 7 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Recovery can unmap TX buffers the device still owns.
- [High] Use-after-free of rxq in mtk_cldma_rxq_free().
- [High] Use-after-free on trb_srv during HIF teardown.
- [High] The RX DMA engine can be restarted after mtk_cldma_rxq_free()
  has stopped it, and the buffers are then freed under live DMA.
- [Medium] An RX error can be dropped for good in mtk_cldma_err_work().
- [Medium] mtk_mhccif_isr_work() acks MHCCIF_EP2RC_SW_INT_ACK before it
  dispatches callbacks, and it ignores their return values.
- [Medium] The IRQ teardown in mtk_cldma_dev_exit() relies on 'mask first
  so no new interrupt can fire, then wait out any in-flight handler'.
- [Medium] In mtk_cldma_txq_free() and mtk_cldma_rxq_free(),
  synchronize_irq() and flush_work(&drv_info->err_work) run before the…
- [Medium] mtk_cldma_err_work() calls mtk_cldma_stop_queue(DIR_RX) with
  no serialization against rxq->rx_done_work.
- [Medium] An incompatible OPTIONAL_SUPPORT reply satisfies the handshake
  even though the host marked the feature mandatory.
- [Medium] HS1 masking race.
- [Low] The justification for leaking the DMA pools contradicts itself.
- [Low] The new comment in mtk_cldma_exit() says 'the caller holds
  trans->submit_lock'.
- [Low] In mtk_cldma_dev_exit(), WRITE_ONCE(cd->cldma_drv_info[hif_id],
  NULL) carries the comment 'Unpublish before teardown; pairs with the…
- [Low] In mtk_fsm_feature_set_match(), the
  RTFT_TYPE_SUPPORT_BACKWARD_COMPAT case only compares versions and…

--

net: wwan: t9xx: Add FSM thread

This adds an FSM kthread. It serializes device and OS events into state
transitions and notifies registered listeners before and after each one.
The MD and SAP HS1/HS2/HS3 runtime feature handshake is wired into the
FSM, and CLDMA bring-up and teardown are driven from FSM state
transitions. That includes the IRQ registration and a new QUEUE_ERROR
recovery worker.

> diff --git a/drivers/net/wwan/t9xx/mtk_fsm.c b/drivers/net/wwan/t9xx/mtk_fsm.c
> new file mode 100644
> index 0000000000000..94617933e7713
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_fsm.c
> @@ -0,0 +1,1174 @@

[ ... ]

> +static int mtk_fsm_feature_set_match(enum runtime_feature_support_type *cur_ft_spt,
> +				     struct runtime_feature_info rtft_info_st,
> +				     struct runtime_feature_info rtft_info_cfg)
> +{

[ ... ]

> +	case RTFT_TYPE_OPTIONAL_SUPPORT:
> +		if (FIELD_GET(FEATURE_TYPE, rtft_info_cfg.feature) == RTFT_TYPE_NOT_EXIST ||
> +		    FIELD_GET(FEATURE_TYPE, rtft_info_cfg.feature) == RTFT_TYPE_NOT_SUPPORT) {
> +			*cur_ft_spt = RTFT_TYPE_NOT_SUPPORT;
> +		} else {
> +			if (FIELD_GET(FEATURE_VER, rtft_info_st.feature) ==
> +			    FIELD_GET(FEATURE_VER, rtft_info_cfg.feature))
> +				*cur_ft_spt = RTFT_TYPE_MUST_SUPPORT;
> +			else
> +				*cur_ft_spt = RTFT_TYPE_NOT_SUPPORT;
> +		}
> +		break;

[Severity: Medium]
Should a version mismatch here fail the handshake when the host has
marked the feature mandatory?

mtk_fsm_hs_info_init_by_hsid() configures MD_PORT_ENUM and SAP_PORT_ENUM
as RTFT_TYPE_MUST_SUPPORT, version 0. Suppose the device replies
OPTIONAL_SUPPORT with a different version. This code sets cur_ft_spt to
RTFT_TYPE_NOT_SUPPORT and returns 0. BACKWARD_COMPAT with a lower version
gives NOT_EXIST in the same way.

mtk_fsm_parse_hs2_msg() then skips the port enumeration action:

    if (cur_ft_spt == RTFT_TYPE_MUST_SUPPORT && query_rtft_action[ft_id]) {

HS3 still goes out, and the FSM can reach READY without the mandatory
enumeration ever running. That seems to contradict the comment in the
NOT_SUPPORT case above: "The device refusing a feature the host declared
mandatory must fail the handshake".

> +	case RTFT_TYPE_SUPPORT_BACKWARD_COMPAT:
> +		if (FIELD_GET(FEATURE_VER, rtft_info_st.feature) >=
> +		    FIELD_GET(FEATURE_VER, rtft_info_cfg.feature))
> +			*cur_ft_spt = RTFT_TYPE_MUST_SUPPORT;
> +		else
> +			*cur_ft_spt = RTFT_TYPE_NOT_EXIST;
> +		break;

[Severity: Low]
This case only compares versions and never looks at the host's
configured type. For a feature the host never offered, query_ft_set[] is
zero (NOT_EXIST, version 0). The >= check then always passes and
cur_ft_spt becomes MUST_SUPPORT.

mtk_fsm_parse_hs2_msg() will then run query_rtft_action[ft_id] on data
supplied by the device. For example, during the MD handshake the device
could trigger the SAP_PORT_ENUM action (mtk_port_status_update()).

Should this case reject or downgrade when the host config is NOT_EXIST
or NOT_SUPPORT, as the MUST_SUPPORT and OPTIONAL_SUPPORT cases do?

[ ... ]

> +static int mtk_fsm_idle_evt_handler(struct mtk_md_dev *mdev,
> +				    u32 dev_state, struct mtk_md_fsm *fsm)
> +{

[ ... ]

> +	/* On failure keep the handshake channels masked and report it, so
> +	 * the device's next boot-flow notification can retrigger us.
> +	 */
> +	if (mtk_fsm_evt_submit(mdev, FSM_EVT_STARTUP, FSM_F_DFLT,
> +			       NULL, 0, 0) == FSM_EVT_RET_FAIL) {
> +		dev_err(mdev->dev, "Failed to submit STARTUP evt, waiting for retry\n");
> +		return -ENOMEM;
> +	}

[Severity: Medium]
Can this retry ever arrive?

mtk_mhccif_isr_work() acks MHCCIF_EP2RC_SW_INT_ACK before it dispatches
the callbacks, and it ignores their return values. mtk_mhccif_init()
documents EP2RC notifications as one-shot: the device never re-sends
them.

The callback runs under spin_lock_bh, so mtk_fsm_evt_submit() allocates
with GFP_ATOMIC here and can fail under memory pressure. When it fails,
this function returns before it unmasks the HS channels. In addition,
mtk_fsm_early_bootup_handler() leaves last_dev_state unlatched so that
the repeated notification is not filtered out.

mtk_fsm_hs1_handler() relies on the same assumption:

    /* Only consume the notification once the event is queued; on a
     * failed submit the channel stays unmasked and uncleared so the
     * device's retry still reaches us.
     */

The status has already been acked, and DEV_STAGE_IDLE is the last stage,
so no second notification seems to come. The FSM would then stay in ON
with the HS channels masked, and the device would never reach READY.

The callbacks also ack a second time through mtk_pci_clear_ext_evt().
That contradicts the dispatcher's ack-first ordering, and it can erase
an event that was re-asserted in the meantime.

[ ... ]

> +static int mtk_fsm_hs1_handler(u32 status, void *__hs_info)
> +{

[ ... ]

> +	if (mtk_fsm_evt_submit(mdev, FSM_EVT_STARTUP, hs_info->fsm_flag_hs1,
> +			       hs_info, sizeof(*hs_info), 0) == FSM_EVT_RET_FAIL) {
> +		dev_err(mdev->dev, "Failed to submit HS1 evt(hs%d), waiting for retry\n",
> +			hs_info->id);
> +		return -ENOMEM;
> +	}
> +	mtk_pci_mask_ext_evt(mdev, hs_info->mhccif_ch);
> +	mtk_pci_clear_ext_evt(mdev, hs_info->mhccif_ch);

[Severity: Medium]
Can the mask here undo the FSM thread's re-arm?

mtk_fsm_evt_submit() queues the event and wakes the FSM thread before
this callback masks and clears the channel. Meanwhile the FSM thread on
another CPU can process the STARTUP event and fail. Examples are the
-EPROTO state check, a mtk_fsm_ctrl_ch_start() failure, or a failed HS1
send. On failure it unmasks the HS channels in mtk_fsm_startup_act() so
that a retry can come in:

    hs_err:
        for (int hs_id = 0; hs_id < HS_ID_MAX; hs_id++)
            mtk_pci_unmask_ext_evt(mdev, fsm->hs_info[hs_id].mhccif_ch);

This callback then masks the channel again, and later HS notifications
stay masked.

The FSM side does not take mhccif_lock, so the lock held here does not
order the two paths. On PREEMPT_RT the spin_lock_bh section can also be
preempted, which makes the window wider.

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> index 0f281bfb38cc7..080ae29d3a887 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> @@ -32,11 +32,184 @@

[ ... ]

> +static int mtk_cldma_isr(int irq_id, void *param)
> +{

[ ... ]

> +	mtk_pci_clear_irq(mdev, drv_info->pci_ext_irq_id);
> +	mtk_pci_unmask_irq(mdev, drv_info->pci_ext_irq_id);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Does this unconditional unmask defeat the mask in mtk_cldma_dev_exit()?

mtk_cldma_dev_exit() relies on this sequence:

    mtk_pci_mask_irq(mdev, drv_info->pci_ext_irq_id);
    synchronize_irq(virq_id);
    mtk_pci_unregister_irq(mdev, drv_info->pci_ext_irq_id);

Its comment says "mask first so no new interrupt can fire". A handler
that is already running would unmask L1 again here before
synchronize_irq() returns.

mtk_pci_unregister_irq() uses the same mask plus synchronize_irq()
sequence and then clears irq_cb_list[] and irq_cb_data[].
mtk_pci_irq_handler() reads cb and data as two separate loads, without
irq_cb_lock:

    cb = READ_ONCE(priv->irq_cb_list[irq_id]);
    if (likely(cb)) {
        smp_rmb();
        cb(irq_id, priv->irq_cb_data[irq_id]);

A new interrupt could then call mtk_cldma_isr() with NULL data. It could
also run against a drv_info whose workqueue is being destroyed and which
is freed later.

In the queue-timeout path, mtk_cldma_rearm_queues() and
mtk_cldma_drv_init() can also rewrite int_mask and unmask L2 sources
after the handler has been removed.

mtk_pci_irq_msix() masks L1 before dispatch, so an interrupt that finds
no handler leaves L1 masked rather than armed indefinitely.

[ ... ]

> @@ -679,8 +853,11 @@ static void mtk_cldma_txq_free(struct cldma_drv_info *drv_info, u32 txqno)
>  
>  	irq_id = mtk_pci_get_virq_id(mdev, drv_info->pci_ext_irq_id);
>  	synchronize_irq(irq_id);
> -	/* flush on-going work */
> +	/* flush on-going work; the error worker may have loaded this txq
> +	 * before it was unpublished above, so it has to be retired too
> +	 */
>  	flush_work(&txq->tx_done_work);
> +	flush_work(&drv_info->err_work);
>  	mtk_cldma_mask_intr(drv_info, DIR_TX, txqno, QUEUE_XFER_DONE);
>  	mtk_cldma_mask_intr(drv_info, DIR_TX, txqno, QUEUE_ERROR);

[Severity: Medium]
Is err_work flushed too early here? synchronize_irq() and
flush_work(&drv_info->err_work) both run before QUEUE_ERROR is masked
for this queue.

If a QUEUE_ERROR interrupt lands in between, mtk_cldma_isr() sets the
tx_err_qs bit, unmasks QUEUE_ERROR again and queues err_work after the
flush has finished.

A later OPEN could reallocate the same queue number before the stale
err_work runs. err_work would then stop the new queue and complete its
pending TX requests with -EPIPE.

mtk_cldma_rxq_free() uses the same ordering. On RX, a stale bit would
stop and restart a healthy new queue, which is the case the new comment
in rxq_free says the flush prevents.

> @@ -987,8 +1165,11 @@ static void mtk_cldma_rxq_free(struct cldma_drv_info *drv_info, u32 rxqno)
>  
>  	irq_id = mtk_pci_get_virq_id(mdev, drv_info->pci_ext_irq_id);
>  	synchronize_irq(irq_id);
> -	/* flush on-going work */
> +	/* flush on-going work; the error worker may still be about to stop
> +	 * this queue number, which a later allocation could already reuse
> +	 */
>  	flush_work(&rxq->rx_done_work);
> +	flush_work(&drv_info->err_work);

[Severity: High]
Is this flush ordering enough to keep rxq alive?

mtk_cldma_err_work() can load rxq with
smp_load_acquire(&drv_info->rxq[i]) before rxq_free() unpublishes the
slot. It then spends time in mtk_cldma_stop_queue(DIR_RX), and finally
does:

    atomic_set(&rxq->need_restart, 1);
    queue_work(drv_info->wq, &rxq->rx_done_work);

If that queue_work() runs after flush_work(&rxq->rx_done_work) has
returned, flush_work(&drv_info->err_work) waits only for err_work
itself. rxq_free() then goes on to kfree(rxq) while rx_done_work is
still pending, and mtk_cldma_rx_done_work() later runs on freed memory.

need_exit does not help, because the work_struct itself is inside the
freed rxq.

Should err_work be flushed before rx_done_work? This path can be reached
from both mtk_cldma_close() and mtk_cldma_dev_exit().

[ ... ]

> @@ -1072,6 +1254,67 @@ static int mtk_cldma_hw_recovery(struct cldma_drv_info *drv_info, u32 qno)

[ ... ]

> +static int mtk_cldma_dev_exit(struct cldma_dev *cd, int hif_id)
> +{

[ ... ]

> +	/* quiesce the IP before releasing descriptor memory: disable its
> +	 * interrupt output and reset it, so it cannot touch the rings again
> +	 */
> +	mtk_pci_write32(mdev, drv_info->base_addr + drv_info->hw_regs->reg_cldma_int_mask,
> +			LINK_ERROR_VAL);
> +	mtk_cldma_drv_reset(drv_info);
> +
> +	if (drv_info->ring_leaked) {
> +		/* A ring is leaked and its descriptors live in these pools:
> +		 * the device may still master DMA into them, so handing them
> +		 * back to the allocator would open a use-after-free window.
> +		 */
> +		dev_err(mdev->dev, "CLDMA%d rings leaked, leaking DMA pools too\n",
> +			drv_info->hw_id);
> +	} else {
> +		dma_pool_destroy(drv_info->bd_dma_pool);
> +		dma_pool_destroy(drv_info->gpd_dma_pool);
> +	}

[Severity: Low]
Which of these two comments is correct? The reset above is said to
quiesce the IP "so it cannot touch the rings again". This branch then
skips dma_pool_destroy() because "the device may still master DMA into
them".

ring_leaked is only set after txq_free() or rxq_free() has already reset
the instance and the stop still timed out. So the code already assumes
that a reset is not enough in that case.

Either the pool leak is unnecessary, or the "cannot touch the rings
again" claim is wrong. The leak policy in the commit message does not
say which guarantee it relies on.

> +
> +	/* Unpublish before teardown; pairs with the acquire loads of this
> +	 * slot. No release is needed, there is no prior store to expose.
> +	 */
> +	WRITE_ONCE(cd->cldma_drv_info[hif_id], NULL);
> +	kfree(drv_info);

[Severity: Low]
Does this comment match the code? It says "Unpublish before teardown".
The store actually runs after the IRQ unregister, the queue frees,
destroy_workqueue(), the reset and dma_pool_destroy().

The comment looks copied from txq_free() and rxq_free(), where the order
really is the other way round. The protection today comes from
mtk_cldma_exit() clearing trans->dev first and from the trb threads
being joined.

[ ... ]

> @@ -1095,6 +1338,11 @@ static int mtk_cldma_start_xfer(struct cldma_drv_info *drv_info, u32 qno)
>  	 * names; tx_done_work advances free_idx under the same lock.
>  	 */
>  	spin_lock(&txq->ring_lock);
> +	if (unlikely(txq->is_stopping)) {
> +		spin_unlock(&txq->ring_lock);
> +		return -EPIPE;
> +	}

[Severity: High]
Can this -EPIPE return lead to unmapping TX buffers that the device
still owns?

mtk_cldma_tx() treats any error from mtk_cldma_start_xfer() as a reason
to flush the ring:

    ret = mtk_cldma_start_xfer(drv_info, que->txqno);
    if (unlikely(ret)) {
        dev_err(mdev->dev, "Failed to trigger cldma tx\n");
        mtk_cldma_txq_flush(drv_info, txq, ret);
    }

mtk_cldma_txq_flush() clears CLDMA_GPD_FLAG_HWO, calls
dma_unmap_single() and completes every pending skb.

mtk_cldma_err_work() sets is_stopping before it polls
mtk_cldma_stop_queue(). If the stop fails, it leaves is_stopping set on
purpose and skips the flush, because the device may still be walking the
ring. A TRB_CMD_TX that arrives during the stop poll, or any time after
a failed stop, would flush exactly the requests err_work is trying to
keep.

mtk_cldma_submit_tx() also never checks is_stopping, although the new
comment in struct txq says the producer reads it under ring_lock. So new
HWO descriptors keep being published into the ring.

Nothing clears is_stopping after a failed stop. Wouldn't every later TX
on that queue take the flush path?

[ ... ]

> @@ -1124,11 +1372,22 @@ int mtk_cldma_init(struct mtk_ctrl_trans *trans)

[ ... ]

> +	/* Latch-and-clear up front: the caller holds trans->submit_lock, so
> +	 * publishing the NULL here makes any later submit path bail out in
> +	 * mtk_cldma_get_tx_budget() instead of walking freed queues.
> +	 */
>  	trans->dev = NULL;

[Severity: Low]
Is the locking precondition in this comment accurate? The err_cldma_exit
path in mtk_pcie_hif_init() is taken when mtk_ctrl_trb_srv_init() fails,
and it calls mtk_cldma_exit() without holding submit_lock.

That is harmless today because trans->available is still 0 on that
path. Should the comment cover this case as well?

[ ... ]

> @@ -1250,6 +1510,82 @@ static void mtk_cldma_txq_flush(struct cldma_drv_info *drv_info,

[ ... ]

> +	tx_err = atomic_xchg(&drv_info->tx_err_qs, 0);
> +	rx_err = atomic_xchg(&drv_info->rx_err_qs, 0);
> +
> +	for (i = 0; i < HW_QUEUE_NUM; i++) {
> +		if (tx_err & BIT(i)) {
> +			/* pairs with smp_store_release() in txq_alloc */
> +			txq = smp_load_acquire(&drv_info->txq[i]);
> +			if (!txq)
> +				continue;

[ ... ]

> +			ret = mtk_cldma_stop_queue(drv_info, DIR_TX, i);
> +			if (ret) {
> +				/* the device may still be walking the ring:
> +				 * unmapping its buffers here would leave it
> +				 * writing into unmapped memory. is_stopping is
> +				 * left set so nothing submits to it again.
> +				 */
> +				dev_err(drv_info->mdev->dev,
> +					"TX queue %d stop failed (%d), keeping its requests\n",
> +					i, ret);
> +				continue;
> +			}

[Severity: Medium]
Does this continue, and the one after the !txq check above, also skip
RX error handling for the same queue index?

Both masks are consumed up front with atomic_xchg(). When the TX branch
hits either continue, the "if (rx_err & BIT(i))" branch for the same i
never runs.

The ISR has already cleared and unmasked the RX QUEUE_ERROR source. As
the comment in the RX branch notes, a stopped RX queue raises no further
interrupt. Wouldn't that RX queue then stay stalled until it is closed
and reopened?

[ ... ]

> +		if (rx_err & BIT(i)) {
> +			/* pairs with smp_store_release() in rxq_alloc */
> +			rxq = smp_load_acquire(&drv_info->rxq[i]);
> +			if (!rxq)
> +				continue;
> +			ret = mtk_cldma_stop_queue(drv_info, DIR_RX, i);

[Severity: Medium]
Is this stop serialized with rxq->rx_done_work? drv_info->wq is
allocated with WQ_UNBOUND, so err_work and rx_done_work can run at the
same time on different CPUs.

Consider an rx_done_work near its end. It can read need_restart == 0 and
call mtk_cldma_resume_queue(DIR_RX) right after this stop. err_work then
sets need_restart and queues rx_done_work again. That call runs
mtk_cldma_rxq_restart() and reprograms the start address on a queue that
may already be running again.

The comment below says the queue is handed back to its worker instead
of being programmed here. The stop command is also queue programming,
though, and it is not serialized with the owner's resume or restart.

> +			if (ret) {

[ ... ]

> +			atomic_set(&rxq->need_restart, 1);
> +			queue_work(drv_info->wq, &rxq->rx_done_work);

[Severity: High]
Can the RX engine be restarted after mtk_cldma_rxq_free() has stopped
it?

The end of mtk_cldma_rx_done_work() checks need_exit and then acts on
it, with no lock:

    if (!atomic_read(&rxq->need_exit)) {
        if (atomic_xchg(&rxq->need_restart, 0))
            mtk_cldma_rxq_restart(drv_info, rxq);
        else if (ret != -ENXIO)
            mtk_cldma_resume_queue(drv_info, DIR_RX, rxq->rxqno);
    }

rxq_free() sets need_exit and calls mtk_cldma_stop_queue(DIR_RX), then
synchronize_irq() and flush_work(). A worker that read need_exit == 0
before that can still call mtk_cldma_rxq_restart() after the stop has
completed. flush_work() only waits for the restart to finish.

The stop returned 0, so ring_leaked stays false. rxq_free() then unmaps
and frees the RX skbs and returns the GPDs, while the SO engine may be
running on HWO descriptors.

Setting need_restart here on every RX QUEUE_ERROR makes this
interleaving concrete. The added flush_work(&drv_info->err_work) in
rxq_free() does not stop the hardware again.

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> index d485bd7e3bf9c..658189dace01b 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> @@ -473,19 +473,23 @@ int mtk_pcie_hif_exit(struct mtk_md_dev *mdev)

[ ... ]

>  	/* Join the service threads before freeing what they dereference: they
>  	 * read trans->dev without a lock, so clearing it cannot stop a
>  	 * consumer that has already loaded the pointer.
>  	 */
>  	mtk_ctrl_trb_srv_exit(trans);
>  	mtk_cldma_exit(trans);

[Severity: High]
Does this ordering leave a window where trb_srv is used after it has
been freed?

mtk_ctrl_trb_srv_exit() calls kthread_stop() and kfree(srv), and only
then sets trans->trb_srv[i] = NULL. The CLDMA IRQ is masked, and
drv_info->wq drained, only later in
mtk_cldma_exit()->mtk_cldma_dev_exit().

This patch registers mtk_cldma_isr(), so mtk_cldma_tx_done_work() and
mtk_cldma_err_work()->mtk_cldma_txq_flush() can run inside that window.
Both do this without a lock:

    srv = trans->trb_srv[trans->srv_cfg[hif_id][txqno]];
    if (was_starved && srv)
        wake_up(&srv->trb_waitq);

srv can already be freed at that point. It is even still non-NULL
between the kfree() and the NULL store.

The commit message says "mtk_pcie_hif_exit() joins the trb service
threads before mtk_cldma_exit() frees what they dereference". However,
the IRQ and work producers that also dereference trb_srv[] are not
quiesced before srv is freed.

A queue can still be open at this point. That happens, for example, when
the DEV_RM submit fails and removal forces cleanup, or when
mtk_port_ch_disable() times out.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-t9xx_driver_v1-v9-0-3248b9256956%40compal.com
