Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7033F20E3;
	Mon, 17 Aug 2026 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006219; cv=none; b=WlXc0Lz1JPIYpKusjLst7SNsUGfvznGoE+FymTDBa9dqECSuZzPjdzdLs5pL3Je5HqUP0iibaFRJGOH1ISm1V5c3Du0pVb2AZ/j5J/H90BeWeTUepaUpwVhsmPBkfIbIYbELTO77GFSS5D0WulNfIEyhXMCn7cS6bUtZ4oJ2riQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006219; c=relaxed/simple;
	bh=ef/mbDn7MVqQl/uLnCBphoE5QBppXdcsLDFwUMlo8t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt9b390FH26sKsB9pMA0MOnkPfQnNWuQjqffE5QBI2Ur+YQ/mZ/zhRLJSQj47G+VHzsJgKNJaQU7UGgIP1XoVtAzBuxfAAcSBqpn81DsGCXVHqg3Rh60DyXyLLLi+ep+0G0bL1cmOlttNl1VK44kXswArbG7QOmXKXZEm1umw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVmocYKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVmocYKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EC51F000E9;
	Mon, 17 Aug 2026 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006217;
	bh=e6Se03rxYsiXMFxFi3du27XbfEDbkaYzxJk9r/yx4lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVmocYKGogrprNyP9/tRE3jU904XsdcmjTaOcn0zra0k2wDYYwpfHb+kYYuLjW1PK
	 0w+8zxE63jlQUvN34YvG34mEDBSa08dgluFj3NxTRQTDiyKyLyAFeYfmPNCGKBu57K
	 EOQ7tMOZfvFuPrxK/SRKsnOban0gLh76Djny5O5S6DbXBwhgzwn/Nj9YKhIGXJDhFX
	 Xy8N8AWzGwmyaTw6Ro6ZdvzhBhp2l5VUilP/59ph8OKWYzonplW71QoVfCbfqmLagf
	 oR54bGbtCsWPYrhmJGi5nT4ckRJMd9xyw58pcp6IOKyXE5zo2WZBbVZLFYjnffJbPC
	 JdyKXqLZK0OKA==
From: Jakub Kicinski <kuba@kernel.org>
To: jackbb_wu@compal.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	robert_yu@compal.com,
	Jeff_Chang@compal.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/7] net: wwan: t9xx: Add control DMA interface
Date: Mon, 17 Aug 2026 15:36:54 -0700
Message-ID: <20260817223654.3688701-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-t9xx_driver_v1-v6-3-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-3-2c969fad57c6@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: t9xx: Add control DMA interface

This adds the CLDMA hardware interface used by the control plane, together
with the TRB service threads and PCIe transport glue that drive the GPD
rings.  The new code allocates TX/RX queues, maps SKB payloads for DMA and
completes requests back to the port layer.

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> new file mode 100644
> index 0000000000000..097b20d8fbd38
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> @@ -0,0 +1,1232 @@

[ ... ]

> +static void mtk_cldma_rx_done_work(struct work_struct *work)
> +{
> +	struct rx_req *req = NULL, *pre_req = NULL;
> +	struct rxq *rxq = container_of(work, struct rxq, rx_done_work);
> +	struct cldma_drv_info *drv_info;
> +	struct cldma_drv_ops *drv_ops;
> +	struct mtk_md_dev *mdev;
> +	struct sk_buff *rx_skb;
> +	int i, ret, idx;
> +
> +	drv_info = rxq->drv_info;
> +	mdev = drv_info->mdev;
> +	drv_ops = drv_info->drv_ops;
> +
> +again:
> +	for (i = 0; i < rxq->nr_gpds; i++) {
> +		req = rxq->req_pool + rxq->free_idx;
> +		if (!req->skb) {
> +			dev_err(mdev->dev,
> +				"Failed to get valid req cldma%d rxq%d req%d\n",
> +				drv_info->hw_id, rxq->rxqno, rxq->free_idx);
> +			goto out;
> +		}
> +
> +		if (req->gpd->rx_gpd.gpd_flags & CLDMA_GPD_FLAG_HWO)
> +			break;
> +
> +		dma_rmb(); /* read descriptor fields after HWO check */
> +
> +		mtk_cldma_rx_skb_adjust(mdev, rxq, req);
> +		rx_skb = req->skb;
> +		req->skb = NULL;
> +
> +		ret = mtk_cldma_reload_rx_skb(mdev, rxq, req);
> +		if (ret) {
> +			/* Alloc failed — recycle old buffer, drop packet.
> +			 * BD mode cannot recycle directly (BDP flag mismatch),
> +			 * so accept the stall and let reset recovery handle it.
> +			 */
> +			if (rxq->nr_bds) {
> +				dev_kfree_skb_any(rx_skb);
> +				goto out;
> +			}
> +
> +			skb_trim(rx_skb, 0);
> +			req->skb = rx_skb;
> +			req->data_dma_addr = dma_map_single(mdev->dev,
> +							    rx_skb->data,
> +							    req->mtu,
> +							    DMA_FROM_DEVICE);
> +			if (dma_mapping_error(mdev->dev, req->data_dma_addr)) {
> +				req->data_dma_addr = 0;
> +				dev_kfree_skb_any(rx_skb);
> +				req->skb = NULL;
> +				/* Advance free_idx below to prevent ring stall */
> +			} else {

[Severity: High]
Can the device DMA into freed memory here?  When both the refill in
mtk_cldma_reload_rx_skb() and this fallback re-map fail, req->skb and
req->data_dma_addr are cleared, but the descriptor still carries the old
programmed address:

mtk_cldma_rx_skb_adjust() {
	if (req->data_dma_addr) {
		dma_unmap_single(mdev->dev, req->data_dma_addr,
				 req->mtu, DMA_FROM_DEVICE);
		req->data_dma_addr = 0;
	}
	...
}

The else branch that reprograms rx_gpd.data_buff_ptr_h/l is skipped, so
gpd->rx_gpd still points at the buffer that was just unmapped and freed
with dev_kfree_skb_any(rx_skb).

Control then falls through to the arming code below, which arms the
previous slot unconditionally, so on the next processed request this
poisoned descriptor becomes pre_req and is handed back to the hardware.

Are the two failures independent?  If the first failure was itself a
dma_map_single() failure from IOVA or swiotlb exhaustion, the immediate
retry of the same mapping would fail too, which makes this path
reachable under memory pressure.

> +				req->gpd->rx_gpd.data_buff_ptr_h =
> +					cpu_to_le32((u64)req->data_dma_addr >> 32);
> +				req->gpd->rx_gpd.data_buff_ptr_l =
> +					cpu_to_le32(req->data_dma_addr);
> +			}
> +		} else {
> +			do {
> +				ret = rxq->rx_done(rx_skb, rxq->arg,
> +						   atomic_read(&rxq->need_exit) ? true : false);
> +				if (ret == -EAGAIN)
> +					usleep_range(1000, 2000);
> +			} while (ret == -EAGAIN);
> +		}
> +
> +		wmb(); /* ensure addr set done before HWO setup done  */
> +
> +		idx = rxq->free_idx == 0 ? rxq->nr_gpds - 1 : rxq->free_idx - 1;
> +		pre_req = rxq->req_pool + idx;
> +		pre_req->gpd->rx_gpd.gpd_flags |= CLDMA_GPD_FLAG_HWO;
> +		rxq->free_idx = (rxq->free_idx + 1) % rxq->nr_gpds;

Also, is the comment "Advance free_idx below to prevent ring stall"
inverted?  Advancing past a slot with no buffer leaves req->skb NULL, and
on the next wrap-around the check at the top of this loop:

	if (!req->skb) {
		dev_err(mdev->dev, ...);
		goto out;
	}

aborts the RX work permanently for that queue, which looks like exactly
the stall the comment says it is preventing.

> +	}

[ ... ]

> +static struct rxq *mtk_cldma_rxq_alloc(struct cldma_drv_info *drv_info, struct sk_buff *skb)
> +{
> +	struct trb_open_priv *trb_open_priv = (struct trb_open_priv *)skb->data;

[ ... ]

> +	INIT_WORK(&rxq->rx_done_work, mtk_cldma_rx_done_work);
> +
> +	drv_info->rxq[rxq->rxqno] = rxq;
> +	drv_ops->cldma_stop_queue(drv_info, DIR_RX, rxq->rxqno);
> +	drv_ops->cldma_setup_start_addr(drv_info, DIR_RX,
> +					rxq->rxqno, rxq->req_pool[0].gpd_dma_addr);
> +	drv_ops->cldma_start_queue(drv_info, DIR_RX, rxq->rxqno);

[Severity: Medium]
Should the result of cldma_stop_queue() be checked here and in the other
three call sites?  mtk_cldma_stop_queue() polls with read_poll_timeout()
but drops the -ETIMEDOUT and returns only the last sampled status:

mtk_cldma_drv.c:mtk_cldma_stop_queue() {
	mtk_pci_write32(drv_info->mdev, addr, val);

	read_poll_timeout(mtk_cldma_queue_status, active,
			  active == LINK_ERROR_VAL || !active,
			  WAIT_QUEUE_STOP, WAIT_QUEUE_STOP * 10, false,
			  drv_info, dir, qno);

	return active;
}

WAIT_QUEUE_STOP is 70, so the budget is roughly 700 us.  None of
mtk_cldma_txq_alloc(), mtk_cldma_rxq_alloc(), mtk_cldma_txq_free() or
mtk_cldma_rxq_free() looks at the value.

If a busy or hung modem does not stop the queue within that window, the
free paths go on to dma_unmap_single() the payload buffers and
dma_pool_free() the GPD and BD descriptors while the engine may still be
fetching them.  synchronize_irq() only quiesces the interrupt handler, not
the DMA engine.  Would returning the timeout and bailing out (or forcing a
CLDMA reset) be safer here?

> +	drv_ops->cldma_unmask_intr(drv_info, DIR_RX, rxq->rxqno, QUEUE_ERROR);
> +	drv_ops->cldma_unmask_intr(drv_info, DIR_RX, rxq->rxqno, QUEUE_XFER_DONE);
> +
> +	return rxq;

[ ... ]

> +static int mtk_cldma_start_xfer(struct cldma_drv_info *drv_info, u32 qno)
> +{
> +	struct cldma_drv_ops *drv_ops;
> +	struct txq *txq;
> +	u32 val;
> +
> +	txq = drv_info->txq[qno];
> +	drv_ops = drv_info->drv_ops;
> +
> +	val = drv_ops->cldma_get_tx_start_addr(drv_info, qno);
> +	if (unlikely(val == LINK_ERROR_VAL))
> +		return -EIO;
> +
> +	if (unlikely(!val)) {
> +		drv_ops->cldma_drv_init(drv_info);
> +		txq = drv_info->txq[qno];
> +		drv_ops->cldma_setup_start_addr(drv_info, DIR_TX, qno,
> +						txq->req_pool[txq->free_idx].gpd_dma_addr);
> +		drv_ops->cldma_start_queue(drv_info, DIR_TX, qno);
> +		txq->tx_started = true;
> +	} else if (unlikely(!txq->tx_started)) {

[Severity: Medium]
Are txq->free_idx and txq->tx_started safe to read here without any
annotation or lock?  This function runs from the TRB service thread via
mtk_cldma_tx(), while mtk_cldma_tx_done_work() advances the same field
from workqueue context with a plain store:

mtk_cldma_tx_done_work() {
	...
	txq->free_idx = (txq->free_idx + 1) % txq->nr_gpds;
}

The reader above uses txq->req_pool[txq->free_idx].gpd_dma_addr to
re-program the UL start address, so a stale index could point the hardware
at a GPD whose HWO bit has already been cleared.

Interesting that tx_done_work() itself uses READ_ONCE()/WRITE_ONCE() for
free_idx and wr_idx, which suggests the fields are known to be shared -
was the reader here just missed?

[Severity: Low]
Is zero a safe sentinel for "queue not programmed" given only the low half
of the address is read?

mtk_cldma_drv.c:mtk_cldma_get_tx_start_addr() {
	addr = drv_info->base_addr + drv_info->hw_regs->reg_cldma_ul_start_addrl_0 +
	       qno * HW_QUEUE_NUM;
	val = mtk_pci_read32(drv_info->mdev, addr);

	return val;
}

mtk_cldma_setup_start_addr() programs both ADDRL and ADDRH and
mtk_cldma_drv_init() puts CLDMA into 64-bit GPD mode, so a GPD DMA address
of, say, 0x1_0000_0000 would read back as zero here and trigger a full
cldma_drv_init() plus queue restart.  Should the high word be read too, as
the analogous t7xx code does?

> +		drv_ops->cldma_start_queue(drv_info, DIR_TX, qno);
> +		txq->tx_started = true;
> +	} else {
> +		drv_ops->cldma_resume_queue(drv_info, DIR_TX, qno);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int mtk_cldma_open(struct cldma_dev *cd, struct sk_buff *skb)
> +{
> +	struct trb_open_priv *trb_open_priv = (struct trb_open_priv *)skb->data;
> +	struct trb *trb = (struct trb *)skb->cb;
> +	struct cldma_drv_info *drv_info;
> +	struct queue_info *que;
> +	struct txq *txq;
> +	struct rxq *rxq;
> +	int ret = 0;
> +
> +	que = radix_tree_lookup(&cd->trans->queue_tbl, trb->channel_id & 0xFFFF);
> +	drv_info = cd->cldma_drv_info[que->hif_id];
> +	if (!drv_info) {
> +		ret = -EIO;
> +		goto out;
> +	}

[Severity: Medium]
Can a failure here permanently poison the channel?  mtk_ch_status_check()
already incremented the user count before this function runs:

mtk_trans_ctrl.c:mtk_ch_status_check() {
	case TRB_CMD_ENABLE:
		...
		trans->usr_cnt[que->hif_id][que->txqno]++;
		if (trans->usr_cnt[que->hif_id][que->txqno] == 1)
			break;
	...
}

and mtk_ctrl_trb_handler() discards the dispatch result:

	if (kick) {
		mtk_cldma_trb_process(trans->dev, skb);
		trans_list->tx_burst_cnt[qno] = 0;
		kick = false;
	}

So on -EIO here, on -EINVAL for a zero MTU, or on -ENOMEM from
mtk_cldma_txq_alloc()/mtk_cldma_rxq_alloc(), usr_cnt stays at 1 with no
txq or rxq.  A retried ENABLE then takes the usr_cnt != 1 path and
mtk_cldma_check_ch_cfg() fails with -EINVAL because txq and rxq are NULL.
Since usr_cnt lives in the devm-allocated struct mtk_ctrl_trans and is not
re-zeroed by mtk_pcie_hif_init(), does the channel stay unusable until the
device is removed?

> +
> +	if (que->tx_mtu == 0 || que->rx_mtu == 0) {

[ ... ]

> +static int mtk_cldma_close(struct cldma_dev *cd, struct sk_buff *skb)
> +{
> +	struct trb *trb = (struct trb *)skb->cb;
> +	struct cldma_drv_info *drv_info;
> +	struct queue_info *que;
> +
> +	que = radix_tree_lookup(&cd->trans->queue_tbl, trb->channel_id & 0xFFFF);
> +	drv_info = cd->cldma_drv_info[que->hif_id];
> +	if (unlikely(!drv_info))
> +		return -EPIPE;

[Severity: Medium]
Does this early return leak the disable request?  Unlike the success path
below, this branch never sets trb->status nor calls
trb->trb_complete(skb), and mtk_ctrl_trb_handler() has already unlinked
the SKB and ignores the return value of mtk_cldma_trb_process().

The submitter is left waiting on the completion:

mtk_port.c:mtk_port_ch_disable() {
	ret = wait_event_timeout(port->trb_wq, trb->status <= 0,
				 MTK_DFLT_TRB_TIMEOUT);
	if (!ret)
		ret = -ETIMEDOUT;
	...
}

so the close path stalls for the full timeout, and since trb_complete() is
where the last reference is dropped, is the 3.5 KiB command SKB leaked
too?  This looks reachable after mtk_cldma_dev_exit() has NULLed
cldma_drv_info[] on modem off, with a userspace close arriving afterwards.

> +
> +	if (drv_info->txq[que->txqno])
> +		mtk_cldma_txq_free(drv_info, que->txqno);
> +	if (drv_info->rxq[que->rxqno])
> +		mtk_cldma_rxq_free(drv_info, que->rxqno);
> +
> +	trb->status = 0;
> +	trb->trb_complete(skb);
> +
> +	return 0;
> +}

[ ... ]

> +	} else {
> +		req->data_dma_addr = dma_map_single(mdev->dev, skb->data,
> +						    skb_headlen(skb), DMA_TO_DEVICE);
> +		ret = dma_mapping_error(mdev->dev, req->data_dma_addr);
> +		if (unlikely(ret)) {
> +			req->data_dma_addr = 0;
> +			goto err_exit;
> +		}

[ ... ]

> +err_exit:
> +	dev_err(mdev->dev, "Failed to map dma! error:%d\n", ret);
> +	return -EAGAIN;
> +}

[Severity: Medium]
Can a persistent mapping failure spin the TRB service thread at 100% CPU?
A mapping failure is reported with the same -EAGAIN used for an exhausted
descriptor ring, and mtk_cldma_submit_tx() returns before it consumes any
budget, so the ring-full backpressure does not apply:

mtk_trans_ctrl.c:mtk_ctrl_trb_handler() {
	case TRB_CMD_TX:
		err = mtk_cldma_submit_tx(trans->dev, skb);
		if (err) {
			...
			if (err == -EAGAIN)
				return;
	...
}

The SKB stays queued and req_budget stays positive, so:

mtk_ctrl_chs_is_busy_or_empty() {
	if (!skb_queue_empty(...) &&
	    mtk_cldma_get_tx_budget(srv->trans->dev, i, srv_que->qno))
		return false;
	...
}

reports work available and the thread's inner loop reruns immediately:

	do {
		mtk_ctrl_trb_process(srv);
		cond_resched();
	} while (!mtk_ctrl_chs_is_busy_or_empty(srv) && ...);

Would that also flood the log, given dev_err() is unconditional on every
retry?  Should the mapping failure use a distinct error and complete the
request, or add some backoff?

> +
> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> new file mode 100644
> index 0000000000000..55297cfcdbc61
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> @@ -0,0 +1,541 @@

[ ... ]

> +static struct mtk_ctrl_info_desc mtk_ctrl_info_tbl[] = {
> +	{2304, &ctrl_info_name(m9xx)},
> +	{0, NULL},
> +};

[Severity: Medium]
Does this table cover both PCI IDs the driver claims?  t9xx_pci_table[]
lists both:

	MTK_PCI_DEV_CFG(0x0900, mtk_dev_cfg_0900),
	CEI_PCI_DEV_CFG(0x01CA, mtk_dev_cfg_0900),

but this table holds only 2304 (0x0900), so a 0x01CA device finds no
match, trans->queue_info stays NULL and mtk_trans_ctrl_init() aborts with
"Failed to get ctrl info!".

The mismatch also persists to the end of the series with the IDs inverted:
mtk_ctrl_info_tbl[] and cldma_drv_info_tbl[] are then keyed on 0x01CA only,
while t9xx_pci_table[] still claims both, so the 0x0900 device becomes the
one that can never bind.  Since both entries share mtk_dev_cfg_0900, is
the omission intentional?

> +
> +#define QUEUE_CHL_MASK	0xFFFF
> +
> +static bool mtk_queue_list_is_full(struct mtk_ctrl_trans *trans, struct queue_info *que)
> +{
> +	return trans->trans_list[que->hif_id].skb_list[que->txqno].qlen >= SKB_LIST_MAX_LEN;
> +}

[Severity: Medium]
Is qlen safe to read here without the queue lock, and is the depth limit
actually enforced?  In mtk_pcie_hif_submit_skb() the fullness test and the
insertion are separate critical sections:

	if (mtk_queue_list_is_full(trans, que) && !force_send)
		return -EAGAIN;
	...
	if (trb->cmd == TRB_CMD_DISABLE)
		skb_queue_head(&trans->trans_list[que->hif_id].skb_list[que->txqno], skb);
	else
		skb_queue_tail(&trans->trans_list[que->hif_id].skb_list[que->txqno], skb);

so concurrent submitters on the same hardware queue can all pass the test
and push past SKB_LIST_MAX_LEN.

Separately, mtk_ctrl_trb_handler() walks the list with skb_peek(),
skb_queue_is_last() and skb_peek_next() outside the lock, and reads a
freshly published SKB's control block with no acquire barrier:

			skb_next = skb_peek_next(skb, skb_list);
			trb_next = (struct trb *)skb_next->cb;
			if (trb_next->cmd != TRB_CMD_TX)
				kick = true;

Can that observe stale ->cb contents on a weakly ordered CPU and
mis-decide whether to kick the hardware?  Multiple ports share one
hardware queue, so concurrent producers plus this single consumer look
like normal operation.

[ ... ]

> +static int mtk_pcie_hif_exit(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct mtk_ctrl_trans *trans;
> +
> +	trans = ctrl_blk->ctrl_hw_priv;
> +
> +	atomic_set(&trans->available, 0);
> +	mtk_ctrl_trb_srv_exit(trans);
> +	mtk_ctrl_remove_radix_tree(trans);
> +	mtk_cldma_exit(trans);
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_hif_submit_skb(struct mtk_md_dev *mdev, struct sk_buff *skb, bool force_send)
> +{

[ ... ]

> +	que = radix_tree_lookup(&trans->queue_tbl, trb->channel_id & QUEUE_CHL_MASK);
> +	if (!que) {
> +		dev_warn(mdev->dev, "lookup que fail, ch_id: %x, que: 0x%p\n",
> +			 trb->channel_id, que);
> +		return -EINVAL;
> +	}
> +
> +	if (!atomic_read(&trans->available))
> +		return -EIO;

[Severity: High]
Does this atomic actually provide mutual exclusion against teardown?  It
looks like a state flag rather than a lock, and the objects it is guarding
are freed immediately after it is cleared:

mtk_pcie_hif_exit() {
	atomic_set(&trans->available, 0);
	mtk_ctrl_trb_srv_exit(trans);      /* kthread_stop, kfree(srv), trb_srv[i] = NULL */
	mtk_ctrl_remove_radix_tree(trans); /* radix_tree_delete + kfree(queue) */
	mtk_cldma_exit(trans);
}

The radix-tree lookup above is also lockless with no RCU read-side
section, while mtk_ctrl_remove_radix_tree() deletes and kfree()s each
entry with no grace period:

	radix_tree_delete(&trans->queue_tbl, iter.index);
	kfree(queue);

So can this sequence occur?

CPU0 (write/close on a WWAN port)
mtk_pcie_hif_submit_skb()
   que = radix_tree_lookup(...);       /* que valid */
   atomic_read(&trans->available);     /* 1 */
   <preempted>

CPU1 (FSM thread on FSM_STATE_OFF)
mtk_pcie_hif_exit()
   atomic_set(&trans->available, 0);
   kfree(srv); trans->trb_srv[i] = NULL;
   kfree(queue);

CPU0 resumes and uses the freed que, then:

	wake_up(&trans->trb_srv[trans->srv_cfg[que->hif_id][que->txqno]]->trb_waitq);

which dereferences a NULL or freed trb_srv.  The SKB is also stranded
because the service thread has already run mtk_ctrl_chs_flush() and
exited.  Would a mutex or RCU around the lookup and submit be more
appropriate than the flag?

> +
> +	if (mtk_queue_list_is_full(trans, que) && !force_send)
> +		return -EAGAIN;

[ ... ]

> +static int mtk_pcie_hif_cmd_func(struct mtk_md_dev *mdev, int cmd, void *data)
> +{
> +	struct mtk_ctrl_blk *ctrl_blk = mdev->ctrl_blk;
> +	struct mtk_ctrl_trans *trans;
> +	struct queue_info *que;
> +
> +	switch (cmd) {
> +	case HIF_CTRL_CMD_CHECK_TX_FULL:
> +		trans = ctrl_blk->ctrl_hw_priv;
> +		que = radix_tree_lookup(&trans->queue_tbl,
> +					((union ctrl_hif_cmd_data *)data)->rx_ch & QUEUE_CHL_MASK);
> +		if (!que) {
> +			dev_warn(mdev->dev, "Failed to find que to check tx full\n");
> +			return -EINVAL;
> +		}
> +		return mtk_queue_list_is_full(trans, que);

This path does the same lockless lookup and dereference without even
testing trans->available.  Is that intentional?

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[ ... ]

The remaining items below were also raised during review but appear to be
resolved by later patches in this series, or could not be shown to be
reachable.  They are listed for completeness only.

[Severity: Low]
At this commit, mtk_ctrl_cfg_m9xx.c defines an empty table:

	static const struct queue_info mtk_queue_info_m9xx[] = {
	};

with .queue_info_num = ARRAY_SIZE(mtk_queue_info_m9xx), so queue_info_num
is 0 and mtk_trans_ctrl_init() rejects it via "trans->queue_info_num <= 0",
failing probe for every device.  The later patch "net: wwan: t9xx: Add
control port" populates four entries, so this is only a transient
bisect-window concern - was that ordering deliberate?

[Severity: Low]
None of the new control-plane and CLDMA code is reachable at this commit:
mtk_ctrl_init() only stores ops, mtk_ctrl_exit() only NULLs
mdev->ctrl_blk, mtk_pci_dev_start() is a bare return 0, and nothing
assigns cd->cldma_drv_info[], so there are no DMA pools, no base_addr, no
IRQ handler and the tx_done_work/rx_done_work items are never queued.  The
TX and RX flows described in the commit message start working only after
the later "Add control port" and "Add FSM thread" patches.  Could the
commit message note that the paths are wired up later in the series?

[Severity: Low]
Related to the above: at this commit mtk_trans_ctrl_exit() calls only
mtk_ctrl_exit(), which never invokes ops->exit, so mtk_pcie_hif_exit() has
no caller and the radix-tree entries, cldma_dev, trb_srv/srv_que objects
and TRB kthreads would have no release path.  This is vacuous here since
ops->init is not called either, and the FSM teardown added later closes it.

[Severity: Low]
In mtk_ctrl_trb_handler(), the default case unlinks the SKB without
completing or freeing it, and kick stays false:

		default:
			skb_unlink(skb, skb_list);
		}

No in-tree producer can reach it, since mtk_pcie_hif_submit_skb()
completes TRB_CMD_STOP and TRB_CMD_RECOVER without queueing them and the
only other values assigned to trb->cmd are ENABLE, TX and DISABLE.  Would
completing the request there be worth it as hardening?

[Severity: Low]
In the non-BD TX path, mtk_cldma_txbuf_set() maps skb_headlen(skb) while
mtk_cldma_submit_tx() advertises data_buff_len = skb->len and records
req->data_len = skb->len for the unmap.  These agree today because non-BD
mode is chosen only when que->tx_mtu <= que->tx_frag_size, and the port
layer builds a frag_list only when port->tx_mtu > port->tx_frag_size, so
every non-BD SKB is linear.  Would an explicit skb_is_nonlinear() check or
a comment make the invariant clearer?

[Severity: Low]
skb->data is overlaid with struct trb_open_priv in mtk_ch_status_check()
and mtk_cldma_rxq_alloc() (including loading the rx_done function pointer
that is later called) with no length check on the linear region.  The only
producer, mtk_port_ch_enable(), allocates Q_MTU_3_5K and skb_put()s
sizeof(struct trb_open_priv), so there is enough room in practice.
