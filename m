Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936A4192EF;
	Sun,  4 Oct 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105159; cv=none; b=i7IS4719B/MDCI1Ll9ztAO5jLsikIT27waO955njQ5ZMI9CPmdXQYYjplFqdtF98W5YBbqitjhACD0ymap4U2g698DhUr8X354iCp8cTLoYHhjsVYKVdwZBykUYzNMIUZNn//Pj+aKa7sGbRAkGGjkvjLNCTOG58lA3N5UqlpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105159; c=relaxed/simple;
	bh=ByLXeI4o9mIuBE/ZVS1tJ1eLIkIRhmDeWJIRXOg2Rdo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6lIHNyTjV2HhmtAboBf/a7AS5kALjiR6aiPnMjGn7Y/xTqw9SbEKo/XImfcpuUnHRUBCz6Xt46OCRS6M2fsSLcUBE6i1dqbi58iKJuAyNQgLtAts1mbDdSkHfEmdJ+ZAw/kTxxl0sVLhQUCUjqf6Kro1SrDYRcjEzZyQ8mym8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha+DgrdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha+DgrdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED91F00898;
	Sun,  4 Oct 2026 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105156;
	bh=Ih4oAK0OwMwrSLYuUhAbQsNHv2aEGyrlLMOjMr0/TgM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ha+DgrdWUodRP4XlBpkXbNZlUsKt+y1Uze+63wzFexGpxe1u3cYBbogFojAWq2kol
	 hmr7qvYuDIhzcJwNUemNlXl5JCbsorqGz9KxtlBprR/5hNErxEXFpzqisNqWk/Uuh9
	 W8SzkB5IZ6DBs4o6GNtu6HsAaDzFDlK/uJMddy76DDO5QPzZ43INS5IhJRBjRAgzDo
	 OEtayE4MVZeY+EbKMxHd03tHpUNEm1ShVfHl90Z9MI+EBVPMZPSdoumSWUAmgIgGUH
	 1bF2wl4BkTIQRD14PC/yzuIpHEOqTkLlwXT+9RC8xAZsZqsK1bhlRd6Fe0wP5hVbUb
	 n6jCCfCKJ8znw==
Subject: Re: [PATCH v9 3/6] net: wwan: t9xx: Add control DMA interface
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
Date: Sun, 04 Oct 2026 09:12:34 +0000
Message-ID: <179110515484.434549.9164635676367238537@kernel.org>
In-Reply-To: <20260930-t9xx_driver_v1-v9-3-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-3-3248b9256956@compal.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 8 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free of struct trb_srv on HIF teardown.
- [High] Race between mtk_cldma_rx_done_work() and mtk_cldma_rxq_free()
  that restarts DMA into freed memory.
- [High] net: wwan: t9xx: use-after-free when deleting radix tree entries
  during iteration
- [Medium] In BD mode, mtk_cldma_rx_skb_adjust() limits each BD's
  recv_len only by data_allow_len, which it reads back from the device-…
- [Medium] mtk_pcie_hif_submit_skb() inserts a DISABLE before the first
  non-ENABLE entry in the queue list.
- [Medium] In non-BD mode, when mtk_cldma_reload_rx_skb() fails and the
  recycle dma_map_single() also fails, mtk_cldma_rx_done_work() jumps to…
- [Medium] In mtk_ch_status_check(), a TRB_CMD_ENABLE increments
  usr_cnt[hif_id][txqno] unconditionally.
- [Medium] Pending TRBs in skb_list are flushed (completed with -EIO)
  only at the end of mtk_ctrl_trb_thread(), via mtk_ctrl_chs_flush().
- [Medium] mtk_cldma_drv_reset() drives the infracfg RST0_SET and
  RST0_CLR registers with read-modify-write: 'val = read(SET); val |=…
- [Medium] When mtk_cldma_start_xfer() fails, mtk_cldma_tx() calls
  mtk_cldma_txq_flush() without stopping the TX queue first.
- [Medium] mtk_cldma_rearm_queues() restarts each TX queue at
  req_pool[free_idx] without reclaiming completed descriptors first.
- [Low] mtk_ctrl_trb_handler() keeps using the skb after
  mtk_cldma_submit_tx() has published it to the hardware ring.

--

net: wwan: t9xx: Add control DMA interface

This commit adds the CLDMA (Cross Layer DMA) driver for the t9xx control
plane. The driver manages GPD/BD rings for TX and RX, and the patch also
adds a transport control layer with a TRB service kthread. Probe now
registers the transport plane and the queue info table. The FSM listener
that brings CLDMA up arrives later in the series.

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> new file mode 100644
> index 0000000000000..0f281bfb38cc7
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> @@ -0,0 +1,1520 @@

[ ... ]

> +static int mtk_cldma_rx_skb_adjust(struct mtk_md_dev *mdev, struct rxq *rxq,
> +				   struct rx_req *req)
> +{

[ ... ]

> +		recv_len = le16_to_cpu(bd_dsc->bd->rx_bd.data_recv_len);
> +		allow_len = le16_to_cpu(bd_dsc->bd->rx_bd.data_allow_len);
> +		if (recv_len > allow_len) {
> +			ret = -EPROTO;
> +			recv_len = allow_len;
> +		}
> +		total_len += recv_len;
> +		if (total_len > req->mtu) {
> +			ret = -EPROTO;
> +			recv_len -= min(total_len - req->mtu, recv_len);
> +			total_len = req->mtu;
> +		}
> +		bd_dsc->skb->len = 0;
> +		skb_reset_tail_pointer(bd_dsc->skb);
> +		skb_put(bd_dsc->skb, recv_len);

[Severity: Medium]
Can a device overrun a single BD skb here?

The only per-BD bound is data_allow_len, and that value is read back from
the dma_pool BD, which the device can write. The BD skbs themselves are
only frag_size bytes:

mtk_cldma_alloc_rx_bd()
    bd_dsc->skb = __dev_alloc_skb(req->frag_size, GFP_KERNEL);
    ...
    bd_dsc->bd->rx_bd.data_allow_len =
        cpu_to_le16(min(req->frag_size, left_size));

mtk_cldma_reload_rx_skb() uses the same size.

Suppose the device writes data_allow_len and data_recv_len up to mtu into
BD 0. Then recv_len passes both checks, and skb_put() runs past skb->end
into skb_over_panic(). The comment above the function says "a device that
inflates data_allow_len cannot grow the packet past the buffer". That is
true of the running total, but not of each BD.

Should recv_len also be clamped to req->frag_size?

BD mode is not configured today, because Q_MTU_3_5K == Q_FRAG_3_5K keeps
nr_bds at 0. This path becomes reachable as soon as a queue uses
mtu > frag_size.

[ ... ]

> +		ret = mtk_cldma_reload_rx_skb(mdev, rxq, req);
> +		if (ret) {

[ ... ]

> +			skb_trim(rx_skb, 0);
> +			req->skb = rx_skb;
> +			req->data_dma_addr = dma_map_single(mdev->dev,
> +							    rx_skb->data,
> +							    req->mtu,
> +							    DMA_FROM_DEVICE);
> +			if (dma_mapping_error(mdev->dev, req->data_dma_addr)) {
> +				req->data_dma_addr = 0;
> +				/* Keep rx_skb in req->skb for clean stall.
> +				 * HWO is not set — HW won't touch this slot.
> +				 * Queue stalls until modem reset recovery.
> +				 */
> +				goto out;

[Severity: Medium]
What brings this slot back after the goto out?

At this point req->skb is rx_skb trimmed to 0, data_dma_addr is 0, HWO is
clear and data_recv_len is already 0. free_idx has not advanced, the
previous GPD has not been re-armed, and the queue has not been resumed.
Nothing marks the slot dead or schedules a retry.

On the next run of mtk_cldma_rx_done_work(), the slot passes both the
!req->skb check and the HWO check as a completed descriptor.
mtk_cldma_rx_skb_adjust() then does skb_put(skb, 0). If the reload
succeeds this time, a zero-length skb goes up through rxq->rx_done().

If no further completion arrives at all, doesn't RX stay stalled even
after memory pressure clears? Nothing appears to implement the "clean
stall until modem reset recovery" in the comment.

[ ... ]

> +	if (!atomic_read(&rxq->need_exit)) {
> +		if (atomic_xchg(&rxq->need_restart, 0))
> +			mtk_cldma_rxq_restart(drv_info, rxq);
> +		else if (ret != -ENXIO)
> +			mtk_cldma_resume_queue(drv_info, DIR_RX, rxq->rxqno);
> +	}

[Severity: High]
Is the need_exit check atomic with respect to mtk_cldma_rxq_free()?
Consider this ordering:

rx_done_work                        mtk_cldma_rxq_free()
atomic_read(need_exit) == 0
<preempted>
                                    atomic_set(&rxq->need_exit, 1);
                                    mtk_cldma_stop_queue() returns 0
                                    synchronize_irq()
                                    flush_work(&rxq->rx_done_work)
mtk_cldma_resume_queue() or
mtk_cldma_rxq_restart()
return
                                    ret == 0, unmap and free RX skbs,
                                    BDs and GPDs

mtk_cldma_rxq_free() does not stop the queue again after flush_work(). Can
the engine then be running on GPDs with HWO set while their buffers and
descriptors are being unmapped and freed?

[ ... ]

> +static void mtk_cldma_rearm_queues(struct cldma_drv_info *drv_info)
> +{

[ ... ]

> +		txq = drv_info->txq[i];
> +		if (txq) {
> +			spin_lock(&txq->ring_lock);
> +			mtk_cldma_setup_start_addr(drv_info, DIR_TX, i,
> +						   txq->req_pool[txq->free_idx].gpd_dma_addr);
> +			mtk_cldma_unmask_intr(drv_info, DIR_TX, i, QUEUE_ERROR);
> +			mtk_cldma_unmask_intr(drv_info, DIR_TX, i, QUEUE_XFER_DONE);
> +			if (READ_ONCE(txq->tx_started))
> +				mtk_cldma_start_queue(drv_info, DIR_TX, i);
> +			spin_unlock(&txq->ring_lock);
> +		}

[Severity: Medium]
What happens if free_idx names a GPD the hardware has already completed
(HWO=0) but mtk_cldma_tx_done_work() has not reclaimed yet?

In that case the engine would restart at that descriptor, stop there, and
never reach the HWO=1 descriptors behind it. tx_started stays true, so
later kicks from mtk_cldma_start_xfer() only resume:

mtk_cldma_start_xfer()
    } else {
        mtk_cldma_resume_queue(drv_info, DIR_TX, qno);
    }

That never moves the hardware cursor. Could the pending slots between the
old free_idx and wr_idx then stay unprocessed, draining req_budget to zero
and stalling TX? This depends on how the hardware handles RESUME at an
HWO=0 descriptor.

[ ... ]

> +static int mtk_cldma_tx(struct cldma_dev *cd, struct sk_buff *skb)
> +{

[ ... ]

> +	ret = mtk_cldma_start_xfer(drv_info, que->txqno);
> +	if (unlikely(ret)) {
> +		dev_err(mdev->dev, "Failed to trigger cldma tx\n");
> +		mtk_cldma_txq_flush(drv_info, txq, ret);
> +	}

[Severity: Medium]
Is it safe to flush here without stopping the TX queue first?

mtk_cldma_start_xfer() can fail after mtk_cldma_hw_recovery() ->
mtk_cldma_rearm_queues() has already issued UL_START. It can also fail on
a transient all-ones read. mtk_cldma_txq_flush() then does three things
on descriptors the engine may still own:

  - clears CLDMA_GPD_FLAG_HWO in place
  - dma_unmap_single()s their buffers
  - advances free_idx

tx_started also stays true. The next successful kick therefore only
resumes from the hardware's stale current-GPD pointer, which now names an
HWO=0 slot behind wr_idx.

The err_work added later in the series stops the queue before flushing,
with the comment "the device may still be walking the ring: unmapping its
buffers here would leave it writing into unmapped memory".

Should this path also stop the queue and clear tx_started before calling
mtk_cldma_txq_flush()?

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c
> new file mode 100644
> index 0000000000000..8ab153da2083e
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma_drv.c
> @@ -0,0 +1,561 @@

[ ... ]

> +void mtk_cldma_drv_reset(struct cldma_drv_info *drv_info)
> +{
> +	struct cldma_hw_regs *hw_regs;
> +	struct mtk_md_dev *mdev;
> +	u32 val;
> +
> +	mdev = drv_info->mdev;
> +	hw_regs = drv_info->hw_regs;
> +
> +	val = mtk_pci_read32(mdev, REG_DEV_INFRA_BASE + hw_regs->reg_infra_rst0_set);
> +	val |= 1 << (REG_CLDMA0_RST_SET_BIT + drv_info->hw_id);
> +	mtk_pci_write32(mdev, REG_DEV_INFRA_BASE + hw_regs->reg_infra_rst0_set, val);
> +	udelay(1);
> +	val = mtk_pci_read32(mdev, REG_DEV_INFRA_BASE + hw_regs->reg_infra_rst0_clr);
> +	val |= 1 << (REG_CLDMA0_RST_CLR_BIT + drv_info->hw_id);
> +	mtk_pci_write32(mdev, REG_DEV_INFRA_BASE + hw_regs->reg_infra_rst0_clr, val);
> +}

[Severity: Medium]
Are RST0_SET and RST0_CLR write-1-to-set and write-1-to-clear registers?
On MediaTek set/clear reset banks every 1 written is normally a command,
and the in-tree MediaTek reset code writes only BIT(id).

If these registers read back the current reset status, the
read-modify-write on RST0_CLR would release every other block in bank 0
that is currently held in reset. Would writing just the CLDMA bit be
safer?

Separately, udelay(1) follows a posted write with no read-back. Is the
reset assert width actually guaranteed?

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> new file mode 100644
> index 0000000000000..531940b06e2a9
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> @@ -0,0 +1,615 @@

[ ... ]

> +	switch (trb->cmd) {
> +	case TRB_CMD_ENABLE:
> +		trb_open_priv = (struct trb_open_priv *)skb->data;
> +		trb_open_priv->log_rg_offset = que->log_rg_offset;
> +		trans->usr_cnt[que->hif_id][que->txqno]++;
> +		if (trans->usr_cnt[que->hif_id][que->txqno] == 1)
> +			break;
> +		trb_open_priv->tx_mtu = que->tx_mtu;
> +		trb_open_priv->rx_mtu = que->rx_mtu;
> +		trb_open_priv->tx_frag_size = que->tx_frag_size;
> +		trb_open_priv->rx_frag_size = que->rx_frag_size;
> +		if (mtk_cldma_check_ch_cfg(trans->dev, que)) {
> +			trb->status = -EINVAL;
> +			ret = -EINVAL;
> +		} else {

[Severity: Medium]
Should usr_cnt be rolled back when the ENABLE is rejected with -EINVAL?

mtk_cldma_open() drops the count on its own failure paths:

mtk_cldma_open()
    if (ret)
        cd->trans->usr_cnt[que->hif_id][que->txqno]--;

This path leaves the increment in place. One leaked increment keeps
usr_cnt at 1 or more. The real owner's DISABLE would then never reach
mtk_cldma_close(), and later ENABLEs would keep failing until
mtk_pcie_hif_init() resets the count.

[ ... ]

> +		case TRB_CMD_TX:
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			err = mtk_cldma_submit_tx(trans->dev, skb);

[ ... ]

> +			trans_list->tx_burst_cnt[qno]++;
> +			spin_lock_irqsave(&skb_list->lock, flags);
> +			if (trans_list->tx_burst_cnt[qno] >= TX_BURST_MAX_CNT ||
> +			    skb_queue_is_last(skb_list, skb)) {
> +				kick = true;
> +			} else {
> +				skb_next = skb_peek_next(skb, skb_list);
> +				trb_next = (struct trb *)skb_next->cb;
> +				if (trb_next->cmd != TRB_CMD_TX)
> +					kick = true;
> +			}
> +
> +			__skb_unlink(skb, skb_list);
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			break;

[Severity: Low]
Once mtk_cldma_submit_tx() has published the skb to the ring,
mtk_cldma_tx_done_work() can complete it through trb_complete(). The
handler then still uses the skb for skb_queue_is_last(), __skb_unlink()
and mtk_cldma_trb_process(trans->dev, skb). What keeps it alive?

At this commit the path is not reachable, because submit_tx always fails
and trb_complete does not free anything. The later patch "net: wwan: t9xx:
Add control port" adds kref_get(&trb->kref) in mtk_ctrl_trb_handler()
under skb_list->lock, which covers this.

Would it be clearer to take that reference here, where the code is
introduced?

[ ... ]

> +static int mtk_ctrl_trb_thread(void *args)
> +{

[ ... ]

> +	mtk_ctrl_chs_flush(srv);
> +	return 0;
> +}

[Severity: Medium]
What happens to queued TRBs if kthread_stop() arrives before this thread
has run for the first time?

kthread() skips threadfn entirely when KTHREAD_SHOULD_STOP is already set,
so mtk_ctrl_chs_flush() would never run. mtk_pcie_hif_init() sets
available to 1 right after kthread_run(), so skbs can be queued before
the thread is scheduled.

mtk_ctrl_trb_srv_exit() does not flush the lists itself, and the next
mtk_pcie_hif_init() calls skb_queue_head_init() over the orphaned
entries. Are those skbs then leaked and their waiters never completed?

Would flushing in mtk_ctrl_trb_srv_exit() after kthread_stop() cover this?

[ ... ]

> +int mtk_pcie_hif_exit(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct mtk_ctrl_trans *trans;
> +
> +	trans = ctrl_blk->ctrl_hw_priv;
> +
> +	mutex_lock(&trans->submit_lock);
> +	atomic_set(&trans->available, 0);
> +	mutex_unlock(&trans->submit_lock);
> +
> +	/* Join the service threads before freeing what they dereference: they
> +	 * read trans->dev without a lock, so clearing it cannot stop a
> +	 * consumer that has already loaded the pointer.
> +	 */
> +	mtk_ctrl_trb_srv_exit(trans);
> +	mtk_cldma_exit(trans);

[Severity: High]
Can this free struct trb_srv while the CLDMA completion paths still
dereference it?

mtk_ctrl_trb_srv_exit() calls kthread_stop() and kfree(srv), and only
afterwards sets trans->trb_srv[i] = NULL. The CLDMA IRQ and TX queues are
torn down after that point (at the end of the series in
mtk_cldma_exit()->mtk_cldma_dev_exit()). Until then,
mtk_cldma_tx_done_work() and mtk_cldma_txq_flush() can still run:

mtk_cldma_tx_done_work()
    srv = trans->trb_srv[trans->srv_cfg[hif_id][txqno]];
    if (was_starved && srv)
        wake_up(&srv->trb_waitq);

A worker can load srv before the NULL store, or between kfree() and the
NULL store. wake_up() would then take the waitqueue lock inside the freed
trb_srv.

The comment "The service may already have been torn down" treats the NULL
check as sufficient, but nothing orders that check against the free.

Would it be safer to quiesce the CLDMA IRQ and workers before freeing the
service?

[ ... ]

> +	if (trb->cmd == TRB_CMD_DISABLE) {
> +		struct sk_buff *entry = NULL;
> +		struct sk_buff_head *list;
> +		struct sk_buff *iter;
> +		unsigned long flags;
> +
> +		/* A disable may overtake queued data, so teardown does not
> +		 * wait for a TX backlog, but it must never overtake a pending
> +		 * ENABLE for the same queue: the two do not commute, and a
> +		 * DISABLE consumed before its ENABLE closes nothing while the
> +		 * ENABLE then arms rings nobody owns.
> +		 */
> +		list = &trans->trans_list[que->hif_id].skb_list[que->txqno];
> +		spin_lock_irqsave(&list->lock, flags);
> +		skb_queue_walk(list, iter) {
> +			if (((struct trb *)iter->cb)->cmd != TRB_CMD_ENABLE) {
> +				entry = iter;
> +				break;
> +			}
> +		}
> +		if (entry)
> +			__skb_queue_before(list, entry, skb);
> +		else
> +			__skb_queue_tail(list, skb);

[Severity: Medium]
Does this walk hold up the promise in the comment when an ENABLE sits
behind a TX entry?

The walk stops at the first non-ENABLE entry. With a list of TX, ENABLE,
a new DISABLE is inserted at the front, which gives DISABLE, TX, ENABLE.

The DISABLE is then handled while usr_cnt is 0. It completes with -EBUSY
in mtk_ch_status_check() without closing anything. The later ENABLE then
arms the rings after the close has already been reported.

Should the DISABLE go after the last pending ENABLE for this queue
instead?

[ ... ]

> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, MediaTek Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/freezer.h>
> +#include <linux/hashtable.h>
> +#include <linux/kthread.h>
> +#include <linux/list.h>
> +#include <linux/nospec.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
> +
> +#include "mtk_cldma.h"
> +#include "mtk_ctrl_plane.h"
> +#include "mtk_dev.h"
> +#include "mtk_pci.h"
> +#include "mtk_trans_ctrl.h"
> +
> +#define QUEUE_CHL_MASK	0xFFFF
> +#define TRB_SRV_NUM	(1)
> +
> +static const int mtk_srv_cfg[NR_CLDMA][HW_QUE_NUM] = {
> +	{0},
> +	{0},
> +};
> +
> +/* the number of RX GPDs should be at least two */
> +static const struct queue_info mtk_queue_info[] = {
> +	{CCCI_CONTROL_TX, CCCI_CONTROL_RX, CLDMA1, TXQ(0), RXQ(0),
> +	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
> +	{CCCI_SAP_CONTROL_TX, CCCI_SAP_CONTROL_RX, CLDMA0, TXQ(0), RXQ(0),
> +	 Q_MTU_3_5K, Q_MTU_3_5K, TX_GPD_NUM, RX_GPD_NUM, Q_FRAG_3_5K, Q_FRAG_3_5K, 0},
> +};
> +
> +static bool mtk_queue_list_is_full(struct mtk_ctrl_trans *trans, struct queue_info *que)
> +{
> +	return skb_queue_len_lockless(&trans->trans_list[que->hif_id].skb_list[que->txqno]) >=
> +	       SKB_LIST_MAX_LEN;
> +}
> +
> +static bool mtk_ctrl_chs_is_busy_or_empty(struct trb_srv *srv)
> +{
> +	struct srv_que *srv_que;
> +	int i;
> +
> +	for (i = 0; i < NR_CLDMA; i++) {
> +		list_for_each_entry(srv_que, &srv->srv_q_list[i], list) {
> +			struct sk_buff *skb;
> +			struct trb *trb;
> +
> +			skb = skb_peek(&srv->trans->trans_list[i].skb_list[srv_que->qno]);
> +			if (!skb)
> +				continue;
> +
> +			/* ENABLE and DISABLE are software-only and are queued at
> +			 * the head, so gating them on TX budget would make a queue
> +			 * that cannot drain impossible to close.
> +			 */
> +			trb = (struct trb *)skb->cb;
> +			if (trb->cmd != TRB_CMD_TX ||
> +			    mtk_cldma_get_tx_budget(srv->trans->dev, i, srv_que->qno))
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static void mtk_ctrl_ch_flush(struct sk_buff_head *skb_list)
> +{
> +	struct sk_buff *skb;
> +	struct trb *trb;
> +
> +	while (!skb_queue_empty(skb_list)) {
> +		skb = skb_dequeue(skb_list);
> +		trb = (struct trb *)skb->cb;
> +		trb->status = -EIO;
> +		trb->trb_complete(skb);
> +	}
> +}
> +
> +static void mtk_ctrl_chs_flush(struct trb_srv *srv)
> +{
> +	struct srv_que *srv_que;
> +	int i;
> +
> +	for (i = 0; i < NR_CLDMA; i++)
> +		list_for_each_entry(srv_que, &srv->srv_q_list[i], list)
> +			mtk_ctrl_ch_flush(&srv->trans->trans_list[i].skb_list[srv_que->qno]);
> +}
> +
> +static int mtk_ch_status_check(struct mtk_ctrl_trans *trans, struct sk_buff *skb)
> +{
> +	struct trb *trb = (struct trb *)skb->cb;
> +	struct trb_open_priv *trb_open_priv;
> +	struct queue_info *que;
> +	int ret = 0;
> +
> +	que = radix_tree_lookup(&trans->queue_tbl, trb->channel_id & QUEUE_CHL_MASK);
> +
> +	switch (trb->cmd) {
> +	case TRB_CMD_ENABLE:
> +		trb_open_priv = (struct trb_open_priv *)skb->data;
> +		trb_open_priv->log_rg_offset = que->log_rg_offset;
> +		trans->usr_cnt[que->hif_id][que->txqno]++;
> +		if (trans->usr_cnt[que->hif_id][que->txqno] == 1)
> +			break;
> +		trb_open_priv->tx_mtu = que->tx_mtu;
> +		trb_open_priv->rx_mtu = que->rx_mtu;
> +		trb_open_priv->tx_frag_size = que->tx_frag_size;
> +		trb_open_priv->rx_frag_size = que->rx_frag_size;
> +		if (mtk_cldma_check_ch_cfg(trans->dev, que)) {
> +			trb->status = -EINVAL;
> +			ret = -EINVAL;
> +		} else {
> +			trb->status = -EBUSY;
> +			ret = -EBUSY;
> +		}
> +		trb->trb_complete(skb);
> +		break;
> +	case TRB_CMD_DISABLE:
> +		if (trans->usr_cnt[que->hif_id][que->txqno] > 0) {
> +			trans->usr_cnt[que->hif_id][que->txqno]--;
> +			if (!trans->usr_cnt[que->hif_id][que->txqno])
> +				break;
> +		}
> +		trb->status = -EBUSY;
> +		trb->trb_complete(skb);
> +		ret = -EBUSY;
> +		break;
> +	default:
> +		dev_err((trans->mdev)->dev, "Invalid trb command(%d)\n", trb->cmd);
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +/* Single consumer per srv_que — only this kthread dequeues from skb_list.
> + * The list lock is held around every list read (peek, is_last, peek_next,
> + * unlink) so a producer inserting a DISABLE at the head cannot race the
> + * traversal, but it is dropped across submit and dispatch: those paths
> + * may allocate with GFP_KERNEL and thus sleep. Dropping the lock there
> + * is safe because no other consumer can steal the peeked skb.
> + */
> +static void mtk_ctrl_trb_handler(struct trb_srv *srv, struct trans_list *trans_list, u32 qno)
> +{
> +	struct sk_buff_head *skb_list = &trans_list->skb_list[qno];
> +	struct mtk_ctrl_trans *trans = srv->trans;
> +	struct sk_buff *skb, *skb_next;
> +	struct trb *trb, *trb_next;
> +	unsigned long flags;
> +	bool kick = false;
> +	int loop = 0;
> +	int err;
> +
> +	do {
> +		spin_lock_irqsave(&skb_list->lock, flags);
> +		skb = skb_peek(skb_list);
> +		if (!skb) {
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			break;
> +		}
> +		trb = (struct trb *)skb->cb;
> +
> +		switch (trb->cmd) {
> +		case TRB_CMD_ENABLE:
> +		case TRB_CMD_DISABLE:
> +			__skb_unlink(skb, skb_list);
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			err = mtk_ch_status_check(trans, skb);
> +			if (!err) {
> +				kick = true;
> +				if (trb->cmd == TRB_CMD_DISABLE)
> +					mtk_ctrl_ch_flush(skb_list);
> +			}
> +			break;
> +		case TRB_CMD_TX:
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			err = mtk_cldma_submit_tx(trans->dev, skb);
> +			if (err) {
> +				if (trans_list->tx_burst_cnt[qno]) {
> +					kick = true;
> +					break;
> +				}
> +				if (err == -EAGAIN)
> +					return;
> +
> +				skb_unlink(skb, skb_list);
> +				trb->status = err;
> +				trb->trb_complete(skb);
> +				break;
> +			}
> +
> +			trans_list->tx_burst_cnt[qno]++;
> +			spin_lock_irqsave(&skb_list->lock, flags);
> +			if (trans_list->tx_burst_cnt[qno] >= TX_BURST_MAX_CNT ||
> +			    skb_queue_is_last(skb_list, skb)) {
> +				kick = true;
> +			} else {
> +				skb_next = skb_peek_next(skb, skb_list);
> +				trb_next = (struct trb *)skb_next->cb;
> +				if (trb_next->cmd != TRB_CMD_TX)
> +					kick = true;
> +			}
> +
> +			__skb_unlink(skb, skb_list);
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			break;
> +		default:
> +			__skb_unlink(skb, skb_list);
> +			spin_unlock_irqrestore(&skb_list->lock, flags);
> +			trb->status = -EINVAL;
> +			trb->trb_complete(skb);
> +			break;
> +		}
> +
> +		if (kick) {
> +			err = mtk_cldma_trb_process(trans->dev, skb);
> +			if (err)
> +				dev_err_ratelimited((trans->mdev)->dev,
> +						    "Failed to process trb on queue %u: %d\n",
> +						    qno, err);
> +			trans_list->tx_burst_cnt[qno] = 0;
> +			kick = false;
> +		}
> +
> +		loop++;
> +	} while (loop < TRB_NUM_PER_ROUND);
> +}
> +
> +static void mtk_ctrl_trb_process(struct trb_srv *srv)
> +{
> +	struct mtk_ctrl_trans *trans = srv->trans;
> +	struct srv_que *srv_que;
> +	int i;
> +
> +	for (i = 0; i < NR_CLDMA; i++)
> +		list_for_each_entry(srv_que, &srv->srv_q_list[i], list)
> +			mtk_ctrl_trb_handler(srv, &trans->trans_list[i], srv_que->qno);
> +}
> +
> +static int mtk_ctrl_trb_thread(void *args)
> +{
> +	struct trb_srv *srv = args;
> +
> +	for (;;) {
> +		wait_event_interruptible(srv->trb_waitq,
> +					 !mtk_ctrl_chs_is_busy_or_empty(srv) ||
> +					 kthread_should_stop() || kthread_should_park());
> +		if (kthread_should_stop())
> +			break;
> +
> +		if (kthread_should_park())
> +			kthread_parkme();
> +
> +		do {
> +			mtk_ctrl_trb_process(srv);
> +			cond_resched();
> +		} while (!mtk_ctrl_chs_is_busy_or_empty(srv) && !kthread_should_stop() &&
> +			 !kthread_should_park());
> +	}
> +	mtk_ctrl_chs_flush(srv);
> +	return 0;
> +}
> +
> +static int mtk_ctrl_trb_srv_init(struct mtk_ctrl_trans *trans)
> +{
> +	struct srv_que *srv_que;
> +	struct trb_srv *srv;
> +	int i, j;
> +	int ret;
> +
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		srv = kzalloc_obj(*srv);
> +		if (!srv) {
> +			ret = -ENOMEM;
> +			goto err_free_srv;
> +		}
> +
> +		srv->trans = trans;
> +		srv->srv_id = i;
> +		trans->trb_srv[i] = srv;
> +
> +		init_waitqueue_head(&srv->trb_waitq);
> +		for (j = 0; j < NR_CLDMA; j++)
> +			INIT_LIST_HEAD(&srv->srv_q_list[j]);
> +	}
> +
> +	for (i = 0; i < NR_CLDMA; i++)
> +		for (j = 0; j < HW_QUE_NUM; j++) {
> +			if (trans->srv_cfg[i][j] < 0 ||
> +			    trans->srv_cfg[i][j] >= trans->trb_srv_num)
> +				trans->srv_cfg[i][j] = 0;
> +			srv_que = kzalloc_obj(*srv_que);
> +			if (!srv_que) {
> +				ret = -ENOMEM;
> +				goto err_free_srv_que;
> +			}
> +			srv_que->hif_id = i;
> +			srv_que->qno = j;
> +			list_add_tail(&srv_que->list,
> +				      &trans->trb_srv[trans->srv_cfg[i][j]]->srv_q_list[i]);
> +		}
> +
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		trans->trb_srv[i]->trb_thread = kthread_run(mtk_ctrl_trb_thread, trans->trb_srv[i],
> +							    "mtk_trb_srv%d_%s", i,
> +							    trans->mdev->dev_str);
> +		if (IS_ERR(trans->trb_srv[i]->trb_thread)) {
> +			ret = PTR_ERR(trans->trb_srv[i]->trb_thread);
> +			trans->trb_srv[i]->trb_thread = NULL;
> +			goto err_stop_kthread;
> +		}
> +	}
> +
> +	return 0;
> +err_stop_kthread:
> +	while (--i >= 0)
> +		kthread_stop(trans->trb_srv[i]->trb_thread);
> +err_free_srv_que:
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		for (j = 0; j < NR_CLDMA; j++) {
> +			struct srv_que *next_srv_que;
> +
> +			list_for_each_entry_safe(srv_que, next_srv_que,
> +						 &trans->trb_srv[i]->srv_q_list[j], list) {
> +				list_del(&srv_que->list);
> +				kfree(srv_que);
> +			}
> +		}
> +	}
> +err_free_srv:
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		if (!trans->trb_srv[i])
> +			break;
> +		kfree(trans->trb_srv[i]);
> +		trans->trb_srv[i] = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void mtk_ctrl_trb_srv_exit(struct mtk_ctrl_trans *trans)
> +{
> +	struct srv_que *srv_que, *next_srv_que;
> +	struct trb_srv *srv;
> +	int i, j;
> +
> +	for (i = 0; i < trans->trb_srv_num; i++) {
> +		srv = trans->trb_srv[i];
> +		if (!srv)
> +			continue;
> +		kthread_stop(srv->trb_thread);
> +		for (j = 0; j < NR_CLDMA; j++) {
> +			list_for_each_entry_safe(srv_que, next_srv_que,
> +						 &trans->trb_srv[i]->srv_q_list[j], list) {
> +				list_del(&srv_que->list);
> +				kfree(srv_que);
> +			}
> +		}
> +		kfree(srv);
> +		trans->trb_srv[i] = NULL;
> +	}
> +}
> +
> +static void mtk_ctrl_remove_radix_tree(struct mtk_ctrl_trans *trans)
> +{
> +	struct radix_tree_iter iter;
> +	struct queue_info *queue;
> +	void __rcu **slot;
> +
> +	radix_tree_for_each_slot(slot, &trans->queue_tbl, &iter, 0) {
> +		queue = radix_tree_deref_slot(slot);
> +		if (!queue)
> +			continue;
> +		radix_tree_delete(&trans->queue_tbl, iter.index);
> +		kfree(queue);
> +	}
> +}
> +
> +int mtk_pcie_hif_init(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct queue_info *queue, *queue_info;
> +	struct mtk_ctrl_trans *trans;
> +	int i, j;
> +	int ret;
> +
> +	trans = ctrl_blk->ctrl_hw_priv;
> +	trans->ctrl_blk = ctrl_blk;
> +	queue_info = trans->queue_info;
> +
> +	INIT_RADIX_TREE(&trans->queue_tbl, GFP_KERNEL);
> +	for (i = 0; i < trans->queue_info_num; i++) {
> +		queue = kmemdup(queue_info + i, sizeof(*queue), GFP_KERNEL);
> +		if (!queue) {
> +			ret = -ENOMEM;
> +			goto err_free_radix_tree;
> +		}
> +		if (queue->txqno >= HW_QUE_NUM || queue->rxqno >= HW_QUE_NUM ||
> +		    queue->hif_id >= NR_CLDMA) {
> +			dev_err(mdev->dev, "Failed to get correct queue info %x\n",
> +				queue->rx_chl);
> +			kfree(queue);
> +			ret = -EINVAL;
> +			goto err_free_radix_tree;
> +		}
> +		ret = radix_tree_insert(&trans->queue_tbl, queue->rx_chl & QUEUE_CHL_MASK, queue);
> +		if (ret) {
> +			dev_err(mdev->dev, "Insert %x fail, ret: %d", queue->rx_chl, ret);
> +			kfree(queue);
> +			goto err_free_radix_tree;
> +		}
> +	}
> +
> +	for (i = 0; i < NR_CLDMA; i++) {
> +		for (j = 0; j < HW_QUE_NUM; j++) {
> +			skb_queue_head_init(&trans->trans_list[i].skb_list[j]);
> +			trans->trans_list[i].tx_burst_cnt[j] = 0;
> +			/* usr_cnt tracks the queues rebuilt by mtk_cldma_init()
> +			 * below, so it must be reset with them. Otherwise a
> +			 * count left over from a torn-down cycle makes the
> +			 * channel permanently unopenable.
> +			 */
> +			trans->usr_cnt[i][j] = 0;
> +		}
> +	}
> +	ret = mtk_cldma_init(trans);
> +	if (ret)
> +		goto err_free_radix_tree;
> +
> +	ret = mtk_ctrl_trb_srv_init(trans);
> +	if (ret)
> +		goto err_cldma_exit;
> +
> +	atomic_set(&trans->available, 1);
> +
> +	return 0;
> +
> +err_cldma_exit:
> +	mtk_cldma_exit(trans);
> +err_free_radix_tree:
> +	mtk_ctrl_remove_radix_tree(trans);
> +
> +	return ret;
> +}
> +
> +int mtk_pcie_hif_exit(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct mtk_ctrl_trans *trans;
> +
> +	trans = ctrl_blk->ctrl_hw_priv;
> +
> +	mutex_lock(&trans->submit_lock);
> +	atomic_set(&trans->available, 0);
> +	mutex_unlock(&trans->submit_lock);
> +
> +	/* Join the service threads before freeing what they dereference: they
> +	 * read trans->dev without a lock, so clearing it cannot stop a
> +	 * consumer that has already loaded the pointer.
> +	 */
> +	mtk_ctrl_trb_srv_exit(trans);
> +	mtk_cldma_exit(trans);
> +
> +	/* Late submitters may still hold the lock and walk the tree. */
> +	mutex_lock(&trans->submit_lock);
> +	mtk_ctrl_remove_radix_tree(trans);
> +	mutex_unlock(&trans->submit_lock);
> +
> +	return 0;
> +}
> +
> +int mtk_pcie_hif_submit_skb(struct mtk_md_dev *mdev, struct sk_buff *skb, bool force_send)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct mtk_ctrl_trans *trans;
> +	struct queue_info *que;
> +	struct trb *trb;
> +	int ret;
> +
> +	trans = ctrl_blk->ctrl_hw_priv;
> +	trb = (struct trb *)skb->cb;
> +
> +	if (trb->cmd == TRB_CMD_STOP || trb->cmd == TRB_CMD_RECOVER) {
> +		trb->trb_complete(skb);
> +		return 0;
> +	}
> +
> +	mutex_lock(&trans->submit_lock);
> +
> +	if (!atomic_read(&trans->available)) {
> +		ret = -EIO;
> +		goto unlock;
> +	}
> +
> +	que = radix_tree_lookup(&trans->queue_tbl, trb->channel_id & QUEUE_CHL_MASK);
> +	if (!que) {
> +		dev_warn(mdev->dev, "lookup que fail, ch_id: %x\n",
> +			 trb->channel_id);
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	if (mtk_queue_list_is_full(trans, que) && !force_send) {
> +		ret = -EAGAIN;
> +		goto unlock;
> +	}
> +
> +	if (trb->cmd == TRB_CMD_DISABLE) {
> +		struct sk_buff *entry = NULL;
> +		struct sk_buff_head *list;
> +		struct sk_buff *iter;
> +		unsigned long flags;
> +
> +		/* A disable may overtake queued data, so teardown does not
> +		 * wait for a TX backlog, but it must never overtake a pending
> +		 * ENABLE for the same queue: the two do not commute, and a
> +		 * DISABLE consumed before its ENABLE closes nothing while the
> +		 * ENABLE then arms rings nobody owns.
> +		 */
> +		list = &trans->trans_list[que->hif_id].skb_list[que->txqno];
> +		spin_lock_irqsave(&list->lock, flags);
> +		skb_queue_walk(list, iter) {
> +			if (((struct trb *)iter->cb)->cmd != TRB_CMD_ENABLE) {
> +				entry = iter;
> +				break;
> +			}
> +		}
> +		if (entry)
> +			__skb_queue_before(list, entry, skb);
> +		else
> +			__skb_queue_tail(list, skb);
> +		spin_unlock_irqrestore(&list->lock, flags);
> +	} else {
> +		skb_queue_tail(&trans->trans_list[que->hif_id].skb_list[que->txqno], skb);
> +	}
> +
> +	wake_up(&trans->trb_srv[trans->srv_cfg[que->hif_id][que->txqno]]->trb_waitq);
> +	ret = 0;
> +
> +unlock:
> +	mutex_unlock(&trans->submit_lock);
> +	return ret;
> +}
> +
> +int mtk_pcie_hif_cmd_func(struct mtk_md_dev *mdev, int cmd, void *data)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct mtk_ctrl_trans *trans;
> +	struct queue_info *que;
> +	int ret;
> +
> +	switch (cmd) {
> +	case HIF_CTRL_CMD_CHECK_TX_FULL:
> +		trans = ctrl_blk->ctrl_hw_priv;
> +		mutex_lock(&trans->submit_lock);
> +		if (!atomic_read(&trans->available)) {
> +			ret = -EIO;
> +			break;
> +		}
> +		que = radix_tree_lookup(&trans->queue_tbl,
> +					((union ctrl_hif_cmd_data *)data)->rx_ch & QUEUE_CHL_MASK);
> +		if (!que) {
> +			dev_warn(mdev->dev, "Failed to find que to check tx full\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = mtk_queue_list_is_full(trans, que);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&trans->submit_lock);
> +
> +	return ret;
> +}
> +
> +int mtk_trans_ctrl_init(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_trans *trans;
> +	struct mtk_ctrl_blk *ctrl_blk;
> +	int err;
> +
> +	trans = devm_kzalloc(mdev->dev, sizeof(*trans), GFP_KERNEL);
> +	if (!trans)
> +		return -ENOMEM;
> +	trans->mdev = mdev;
> +	mutex_init(&trans->submit_lock);
> +	atomic_set(&trans->available, 0);
> +
> +	memcpy(trans->srv_cfg, mtk_srv_cfg, sizeof(mtk_srv_cfg));
> +	trans->queue_info = (struct queue_info *)mtk_queue_info;
> +	trans->queue_info_num = ARRAY_SIZE(mtk_queue_info);
> +	trans->trb_srv_num = TRB_SRV_NUM;
> +
> +	err = mtk_ctrl_init(mdev);
> +	if (err)
> +		return err;
> +
> +	ctrl_blk = mdev->ctrl_blk;
> +	ctrl_blk->ctrl_hw_priv = trans;
> +
> +	return 0;
> +}
> +
> +int mtk_trans_ctrl_exit(struct mtk_md_dev *mdev)
> +{
> +	mtk_ctrl_exit(mdev);
> +
> +	return 0;
> +}

[Severity: High]
Is it safe to call radix_tree_delete() from inside
radix_tree_for_each_slot() in mtk_ctrl_remove_radix_tree()?

radix_tree_delete() frees the node holding the current slot once its
last entry is gone, and it may also shrink the tree. The iterator
then advances by stepping slot within that same node, so the next
radix_tree_deref_slot(slot) reads from it. The node is released
through call_rcu(), but this walk holds no rcu_read_lock(), so
nothing keeps the node alive.

With the two channels in mtk_queue_info[] this is the normal case,
not a corner case. 0x1000 and 0x2000 land in separate leaf nodes of
a three level tree, so deleting the first entry already empties and
frees its node before the iterator moves on.

The walk runs from mtk_pcie_hif_exit() and from the error unwind in
mtk_pcie_hif_init(). Once the FSM patch later in the series calls
those, every teardown and every failed init goes through it.

radix_tree_iter_delete() exists for deleting at the iterator
position, and it moves the iterator past a freed node. Would that
work here? Or, since this is new code, would an xarray with
xa_for_each() and xa_erase() be simpler?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-t9xx_driver_v1-v9-0-3248b9256956%40compal.com
