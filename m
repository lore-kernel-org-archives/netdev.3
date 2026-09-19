Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892639A4C4;
	Sat, 19 Sep 2026 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862097; cv=none; b=GmiQCxjhWx7Mi/sf1Zn/INcpnXuzNNDaWMSmsfcXkZGrIlzWcNITOCdFFl95Xu/cUfDcqimHaYELW98w072zM8PvYLIFIixbegtZP1L8ZGbDxXz5LvTq6nYyzITavCdn4FaVP67qPuR+oa6Z0ziXXUwfAtPJYEMasYlktix83Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862097; c=relaxed/simple;
	bh=O+b+vfDuNsrfsRK9loy86JP9cgDE8RvPtnr1F6sWMaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS8mP7axe93xn0ljsra/tSJXtuOS3WBhQdl8OKYabDH2sFv3YLEKGQRsEt60IdFXFQV7+hA2bvFS8USWQd6SPxXtQydhrn/ULr0E4Fv7k/8fPZyptNuNqV3shkHZY4m3QugiuGntQ3xwEMun2TRsWMd9/bIuNgj1PzwzQJz8YUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+CyaGJ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+CyaGJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3851F00893;
	Sat, 19 Sep 2026 23:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789862094;
	bh=tAgW92+Gk3fFbTAWQkAegnrtSsnlZMKYapHgM127OE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+CyaGJ+nnf20LdSsK6bkGM+24JRcIvHgRyNrQDnwYJ0saDBTz3O6IB/tLDO3/Cy+
	 lbouIn0njcI2+iGqRQVzFFV/ydqQfPUBDsaTulJmjrW+L/GVACCyJvh6PGW2hiDV2V
	 B3QyhMcVIB7ZpxrTkERT6n7dIv1k3Hy52tkLmJkeC86ksQ/Fr3g/lYn0iblnua9zrb
	 m0iqFtZI2xQHZdestUMjRFuTxzB4uWOd46cKbDJvNjkiz8XCY4tW31SbGAdDNc/QpK
	 r3MYFGSl0J7CHuextX9LJh5/G6mSwVrpJHfreg/Rh9WHZACOKh061JZB0/IWTqc74i
	 eRXDW36sdHpcQ==
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
Subject: Re: [PATCH v8 5/6] net: wwan: t9xx: Add FSM thread
Date: Sat, 19 Sep 2026 16:54:53 -0700
Message-ID: <20260919235453.839788-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914-t9xx_driver_v1-v8-5-5206c2e6bea0@compal.com>
References: <20260914-t9xx_driver_v1-v8-5-5206c2e6bea0@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: t9xx: Add FSM thread

This adds an FSM kthread that serializes asynchronous device/OS events
into state transitions, wires the HS1/HS2/HS3 runtime feature handshake
into the FSM, and drives CLDMA bring-up/teardown from FSM state changes.

A few questions below about the new teardown ordering, the CLDMA error
worker, the boot-flow notification path, and the commit message scope.

> diff --git a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> index aea8a911006e8..52ea24c5c18f3 100644
> --- a/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> +++ b/drivers/net/wwan/t9xx/mtk_ctrl_plane.c
> @@ -38,8 +80,17 @@ int mtk_ctrl_init(struct mtk_md_dev *mdev, struct mtk_ctrl_hif_ops *ops, struct
> +static void mtk_ctrl_trans_fsm_state_handler(struct mtk_fsm_param *param,
> +					     struct mtk_ctrl_blk *ctrl_blk)
> +{
> +	struct mtk_md_dev *mdev = ctrl_blk->mdev;
> +	int ret;
> +
> +	switch (param->to) {
> +	case FSM_STATE_OFF:
> +		ctrl_blk->ops->exit(mdev);
> +		ctrl_blk->ops->fsm_indication(mdev, param);
> +		break;
> +	case FSM_STATE_ON:
> +		ret = ctrl_blk->ops->init(mdev);
> +		if (ret) {
> +			dev_err(mdev->dev, "Failed to init HIF: %d\n", ret);
> +			mtk_fsm_hif_err_record(mdev, ret);

[Severity: Medium]
Can this record of hif_err ever be cleared again?

The only clear site is mtk_fsm_dev_add_act():

	/* a fresh device lifecycle starts with a clean HIF error record */
	fsm->hif_err = 0;
	mtk_fsm_switch_state(fsm, FSM_STATE_ON, event);

so the clear happens before the ON-transition listeners run, and this
FSM_STATE_ON case is one of those listeners. A failing ops->init() here
latches hif_err in the same transition that just zeroed it.

mtk_fsm_startup_act() then refuses the promotion permanently:

	if (fsm->hif_err) {
		dev_err(mdev->dev,
			"Refusing READY: HIF init failed with %d\n",
			fsm->hif_err);
		return fsm->hif_err;
	}

The same applies to mtk_cldma_fsm_state_listener(), which records a CLDMA
init failure on an HS1 transition; if a later HS1 retry initializes CLDMA
successfully, hif_err stays set.

Because the transitions run in the FSM kthread, mtk_pci_dev_start() and
probe still return success, so the driver stays bound with a device parked
in FSM_STATE_BOOTUP forever. Should a successful (re-)init clear hif_err,
or should the failure be surfaced to probe?

> diff --git a/drivers/net/wwan/t9xx/mtk_fsm.c b/drivers/net/wwan/t9xx/mtk_fsm.c
> new file mode 100644
> index 0000000000000..d57defc793087
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/mtk_fsm.c

[ ... ]

> +static int mtk_fsm_parse_hs2_msg(struct mtk_md_fsm *fsm, struct fsm_hs_info *hs_info,
> +				 struct sk_buff *skb)
> +{

[ ... ]

> +	offset = sizeof(struct feature_query);
> +	for (ft_id = 0; ft_id < FEATURE_CNT; ft_id++) {
> +		if (offset + sizeof(*rtft_entry) > rt_data_len)
> +			break;
> +
> +		rtft_entry = (struct runtime_feature_entry *)(rt_data + offset);

[ ... ]

> +		data_len = le32_to_cpu(rtft_entry->data_len);

[Severity: Low]
Is this read guaranteed to be aligned?

struct runtime_feature_entry is not packed and data_len is a naturally
aligned __le32:

	struct runtime_feature_entry {
		u8 feature_id;
		struct runtime_feature_info support_info;
		u8 reserved[2];
		__le32 data_len;
		u8 data[];
	};

offset advances by sizeof(*rtft_entry) + data_len, and data_len comes
from the device, so an odd first payload length leaves the next entry's
data_len member at an odd address. Would get_unaligned_le32() (or copying
each wire entry into aligned storage) be better here for
strict-alignment architectures?

[ ... ]

> +static void mtk_fsm_switch_state(struct mtk_md_fsm *fsm,
> +				 enum mtk_fsm_state to_state, struct mtk_fsm_evt *event)
> +{

[ ... ]

> +	snprintf(fsm_info, MTK_FSM_INFO_LEN,
> +		 "state=%d, fsm_flag=0x%x", to_state, fsm->fsm_flag);
> +	mtk_uevent_notify(fsm->mdev->dev, MTK_UEVENT_FSM, fsm_info);

[Severity: Medium]
This adds a userspace-visible interface that the changelog does not
mention. Every FSM transition broadcasts a KOBJ_CHANGE uevent whose
payload is the ad-hoc string:

	"<kobj name>:event_id=%d, info=state=%d, fsm_flag=0x%x"

Once merged, udev rules and modem managers can parse that format, so it
becomes ABI that cannot be changed later. Should this be described and
justified in the commit message, and could the state be reported through
the wwan framework instead?

The new enum in mtk_utility.h also pre-declares values nothing emits:

	MTK_UEVENT_MINIDUMP = 2,
	MTK_UEVENT_LOWPOWER = 3,

[ ... ]

> +static int mtk_fsm_early_bootup_handler(u32 status, void *__fsm)
> +{
> +	struct mtk_md_fsm *fsm = __fsm;
> +	struct mtk_md_dev *mdev;
> +	u32 dev_state, dev_stage;
> +
> +	mdev = fsm->mdev;
> +	mtk_dev_mask_dev_evt(mdev, status);
> +	mtk_dev_clear_dev_evt(mdev, status);
> +
> +	dev_state = mtk_dev_get_dev_state(mdev);
> +	dev_stage = dev_state & REGION_BITMASK;
> +	if (dev_stage >= DEV_STAGE_MAX) {
> +		dev_err(mdev->dev, "Invalid dev state 0x%x\n", dev_state);
> +		return -ENXIO;
> +	}

[Severity: High]
Does this early return leave the boot-flow channel masked forever?

The channel was masked and cleared on entry, and this return skips the
exit: label that re-arms it:

exit:
	mtk_dev_unmask_dev_evt(mdev, status);

The dispatcher in pcie/mtk_pci.c discards the callback return value and
filters masked channels out of the status:

mtk_mhccif_isr_work() {
	...
	stat &= ~mask;
	...
	list_for_each_entry(cb, &priv->mhccif_cb_list, entry) {
		if (cb->chs & chs)
			cb->evt_cb(cb->chs & chs, cb->data);
}

so nothing re-delivers the dropped notification, and the only other
unmask of DEV_EVT_D2H_BOOT_FLOW_SYNC is in mtk_fsm_dev_add_act(), which
runs once per probe. dev_state is device-supplied, so a single transient
read with the low nibble in 5..0xF (e.g. an all-ones read during reset)
would park the FSM in FSM_STATE_ON with no timeout or retry.

The sibling failure path in this same function deliberately falls through
to the unmask:

	if (dev_stage == DEV_STAGE_IDLE &&
	    mtk_fsm_idle_evt_handler(mdev, dev_state, fsm))
		goto exit;

Was the asymmetry intentional, or should the invalid-state case also
goto exit?

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> index 8f6aa6809a536..18ad5308c2555 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_cldma.c
> @@ -32,11 +32,206 @@
> +static int mtk_cldma_isr(int irq_id, void *param)
> +{

[Severity: Medium]
Could the commit message cover the scope of these CLDMA changes? The
message says only that mtk_cldma_dev_init() "allocates DMA pools,
creates a workqueue, and registers the MSI-X IRQ", but the patch also
adds:

  - mtk_cldma_isr(), the first and only code that dispatches
    tx_done_work/rx_done_work, i.e. it activates the whole
    interrupt-driven completion path earlier patches left inert
  - a new hardware error-recovery policy (mtk_cldma_err_work(),
    tx_err_qs/rx_err_qs, completing pending TX requests with -EPIPE)
  - a deliberate permanent-leak policy: drv_info->ring_leaked makes
    mtk_cldma_dev_exit() skip dma_pool_destroy() for both pools
  - teardown behaviour changes: mtk_pcie_hif_exit() made idempotent and
    holding submit_lock across the whole teardown, mtk_cldma_exit()
    latching trans->dev to NULL, and mtk_trans_ctrl_exit() now calling
    mtk_pcie_hif_exit()

It also removes an unrelated register define:

  -#define REG_CLDMA_INT_WF_MASK				(0x0800 + 0x0120)

Would splitting the CLDMA interrupt/error-recovery work into its own
patch make these decisions easier to review and bisect?

> +	if (tx_err || rx_err) {
> +		dev_err_ratelimited(mdev->dev, "CLDMA%d queue error: TX 0x%x RX 0x%x\n",
> +				    drv_info->hif_id, tx_err, rx_err);

[ ... ]

> +		atomic_or(tx_err, &drv_info->tx_err_qs);
> +		atomic_or(rx_err, &drv_info->rx_err_qs);
> +		queue_work(drv_info->wq, &drv_info->err_work);
> +	}
> +
> +	if (tx_done) {
> +		for (i = 0; i < HW_QUEUE_NUM; i++) {
> +			/* pairs with smp_store_release() in txq_alloc */
> +			txq = smp_load_acquire(&drv_info->txq[i]);
> +			if (!(tx_done & BIT(i)) || !txq)
> +				continue;
> +			queue_work(drv_info->wq, &txq->tx_done_work);
> +		}
> +	}
> +	if (rx_done) {
> +		for (i = 0; i < HW_QUEUE_NUM; i++) {
> +			/* pairs with smp_store_release() in rxq_alloc */
> +			rxq = smp_load_acquire(&drv_info->rxq[i]);
> +			if (!(rx_done & BIT(i)) || !rxq)
> +				continue;
> +			queue_work(drv_info->wq, &rxq->rx_done_work);
> +		}
> +	}

[Severity: High]
Can err_work and the per-queue done worker run concurrently for the same
queue and issue contradictory commands to it?

mtk_cldma_get_intr_status() in mtk_cldma_drv.c builds tx_sta/rx_sta from
one register read and masks every asserted bit:

	*tx_sta = (*tx_sta) & (~tx_mask);
	*rx_sta = (*rx_sta) & (~rx_mask);

so a single status word can carry QUEUE_XFER_DONE and QUEUE_ERROR for the
same queue index, and both work items get queued here onto the same
WQ_UNBOUND workqueue.

On RX, mtk_cldma_rx_done_work() ends with:

	if (!atomic_read(&rxq->need_exit)) {
		if (atomic_xchg(&rxq->need_restart, 0))
			mtk_cldma_rxq_restart(drv_info, rxq);
		else
			drv_ops->cldma_resume_queue(drv_info, DIR_RX, rxq->rxqno);

while err_work issues cldma_stop_queue(DIR_RX). err_work never sets
need_exit.

On TX, err_work stops the queue, clears HWO and dma_unmaps descriptors in
mtk_cldma_txq_flush(), while mtk_cldma_tx()/mtk_cldma_start_xfer() can
start or resume it. The producer guard there is:

	txq = drv_info->txq[que->txqno];
	if (unlikely(!txq) || txq->is_stopping)
		return -EPIPE;

but err_work never sets txq->is_stopping either, so nothing keeps the
producer out while the flush runs.

Should the error worker record a persistent stopping state (is_stopping /
need_exit) and hold ring_lock across stop-through-flush, and should the RX
cldma_stop_queue() return value be checked rather than discarded?

[ ... ]

> +static int mtk_cldma_dev_init(struct cldma_dev *cd, int hif_id)
> +{

[ ... ]

> +	drv_info->gpd_dma_pool = dma_pool_create(gpd_pool_name, mdev->dev,
> +						 sizeof(union gpd), 4, 0);

[Severity: Medium]
Is 4-byte alignment sufficient for GPDs? Every address from this pool is
programmed into CLDMA UL/SO start-address and next-GPD registers, and the
existing in-tree CLDMA driver for the same descriptor layout uses 16:

drivers/net/wwan/t7xx/t7xx_hif_cldma.h:
	#define GPD_DMAPOOL_ALIGN	16

Does the T9xx DMA engine tolerate GPD addresses that are only 4- or
8-byte aligned?

[ ... ]

> +	cd->cldma_drv_info[hif_id] = drv_info;
> +	return 0;

[Severity: Medium]
Should this publication use smp_store_release()? The MSI-X handler is
already registered and unmasked at this point, and readers reached from
the trb service kthreads (mtk_cldma_tx(), mtk_cldma_open(),
mtk_cldma_check_ch_cfg(), mtk_cldma_get_tx_budget()) use plain loads with
no acquire.

This file already uses the opposite convention for the queue arrays, as
the comments in mtk_cldma_isr() note:

	/* pairs with smp_store_release() in txq_alloc */
	txq = smp_load_acquire(&drv_info->txq[i]);

and mtk_pci_register_irq() uses smp_wmb() before publishing its callback.
On a weakly ordered machine, can a reader see a non-NULL
cldma_drv_info[hif_id] while drv_ops, hw_regs, base_addr or wq are still
stale?

> @@ -679,8 +874,11 @@ static void mtk_cldma_txq_free(struct cldma_drv_info *drv_info, u32 txqno)
>  	txq = drv_info->txq[txqno];
>  	drv_info->txq[txqno] = NULL;

[Severity: Low]
This isn't a bug, but the removal side is a plain store while the new
mtk_cldma_isr() and mtk_cldma_err_work() read the same slots with
smp_load_acquire(), so the annotated pairing is one-sided. The same
applies to mtk_cldma_rxq_free() and the txq_alloc error path. Would
WRITE_ONCE() or smp_store_release() here make the pairing consistent?

[ ... ]

> @@ -1282,6 +1282,64 @@
> +static int mtk_cldma_dev_exit(struct cldma_dev *cd, int hif_id)
> +{

[ ... ]

> +	flush_workqueue(drv_info->wq);
> +	destroy_workqueue(drv_info->wq);

[ ... ]

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
> +
> +	cd->cldma_drv_info[hif_id] = NULL;
> +	kfree(drv_info);
> +
> +	return 0;
> +}

[ ... ]

> @@ -1133,11 +1394,22 @@ int mtk_cldma_init(struct mtk_ctrl_trans *trans)
>  void mtk_cldma_exit(struct mtk_ctrl_trans *trans)
>  {
> -	if (!trans->dev)
> +	struct cldma_dev *cd = trans->dev;
> +	int i;
> +
> +	if (!cd)
>  		return;
>  
> -	kfree(trans->dev);
> +	/* Latch-and-clear up front: the caller holds trans->submit_lock, so
> +	 * publishing the NULL here makes any later submit path bail out in
> +	 * mtk_cldma_get_tx_budget() instead of walking freed queues.
> +	 */
>  	trans->dev = NULL;
> +
> +	for (i = 0; i < NR_CLDMA; i++)
> +		mtk_cldma_dev_exit(cd, i);
> +
> +	kfree(cd);
>  }

[Severity: Critical]
Can this free memory the trb service kthreads are still using?

mtk_pcie_hif_exit() calls mtk_cldma_exit() before
mtk_ctrl_trb_srv_exit():

	atomic_set(&trans->available, 0);
	mtk_cldma_exit(trans);
	mtk_ctrl_trb_srv_exit(trans);

so by the time the kthreads are stopped, mtk_cldma_dev_exit() has already
freed every txq/rxq ring, req_pool, both DMA pools, the workqueue,
drv_info and cd.

The trb kthreads never take submit_lock, so holding it here gives no
exclusion. They read trans->dev unlocked in the wait condition:

mtk_ctrl_chs_is_busy_or_empty() {
	...
	if (trb->cmd != TRB_CMD_TX ||
	    mtk_cldma_get_tx_budget(srv->trans->dev, i, srv_que->qno))
}

and in the handler:

mtk_ctrl_trb_handler() {
	...
	err = mtk_cldma_submit_tx(trans->dev, skb);
	...
	mtk_cldma_trb_process(trans->dev, skb);
}

Latching trans->dev = NULL does not stop a consumer that already loaded
the pointer. mtk_cldma_txq_free()/mtk_cldma_txq_flush() also call
trb->trb_complete() and wake_up(&trans->trb_srv[...]->trb_waitq) during
this very teardown, so the kthread is actively woken and re-evaluates the
unlocked read while the frees are in progress.

Should mtk_ctrl_trb_srv_exit() run before mtk_cldma_exit()?

[ ... ]

> +static void mtk_cldma_err_work(struct work_struct *work)
> +{
> +	struct cldma_drv_info *drv_info = container_of(work, struct cldma_drv_info, err_work);
> +	u32 tx_err, rx_err;
> +	struct txq *txq;
> +	struct rxq *rxq;
> +	int i, ret;
> +
> +	tx_err = atomic_xchg(&drv_info->tx_err_qs, 0);
> +	rx_err = atomic_xchg(&drv_info->rx_err_qs, 0);
> +
> +	for (i = 0; i < HW_QUEUE_NUM; i++) {
> +		if (tx_err & BIT(i)) {

[ ... ]

> +		if (rx_err & BIT(i)) {
> +			/* pairs with smp_store_release() in rxq_alloc */
> +			rxq = smp_load_acquire(&drv_info->rxq[i]);
> +			if (!rxq)
> +				continue;
> +			drv_info->drv_ops->cldma_stop_queue(drv_info, DIR_RX, i);
> +		}
> +	}
> +}

[Severity: High]
Once this stops an errored RX queue, what re-arms it?

The TX branch above sets tx_started = false, so the next
mtk_cldma_start_xfer() re-programs the start address and restarts the
queue. The RX branch sets neither rxq->need_restart nor queues
rx_done_work.

mtk_cldma_rxq_restart() is reachable only from mtk_cldma_rx_done_work()
under need_restart, and rx_done_work is queued only from
mtk_cldma_isr() on an RX QUEUE_XFER_DONE interrupt:

	if (rx_done) {
		for (i = 0; i < HW_QUEUE_NUM; i++) {
			rxq = smp_load_acquire(&drv_info->rxq[i]);
			if (!(rx_done & BIT(i)) || !rxq)
				continue;
			queue_work(drv_info->wq, &rxq->rx_done_work);

A stopped SO queue cannot raise that interrupt, so the RX ring stays
stopped for the rest of the CLDMA instance's life while
drv_info->rxq[rxqno] remains published and mtk_cldma_check_ch_cfg() still
reports the channel enabled.

Separately, the cldma_stop_queue(DIR_RX) return value is discarded here,
so an -ETIMEDOUT queue that never quiesced looks identical to one that
did. Should the RX branch mirror the TX recovery?

[Severity: Medium]
Related to the above: can reset recovery restart RX queues at all?

mtk_cldma_rearm_queues() defers RX re-programming to the worker:

	atomic_set(&rxq->need_restart, 1);
	queue_work(drv_info->wq, &rxq->rx_done_work);

but mtk_cldma_rx_done_work() calls mtk_cldma_check_rx_req() before
consuming need_restart, and that helper bails out on a freshly reset
instance:

	curr_addr = drv_info->drv_ops->cldma_get_rx_curr_addr(drv_info, rxq->rxqno);
	if (unlikely(!curr_addr))
		return -ENXIO;

mtk_cldma_drv_reset_m9xx() asserts REG_INFRA_RST0 for the instance, which
clears the SO address registers, so curr_addr reads back as zero and the
worker jumps to out: without ever reaching:

	if (atomic_xchg(&rxq->need_restart, 0))
		mtk_cldma_rxq_restart(drv_info, rxq);

Since the queue was never started, no further completion interrupt can
retry the path. Should mtk_cldma_rearm_queues() program the RX queue
directly instead of relying on the worker?

[Severity: High]
On the receive completion path, mtk_cldma_rx_skb_adjust() bounds the put
length with a descriptor field the device itself writes:

	recv_len = le16_to_cpu(req->gpd->rx_gpd.data_recv_len);
	allow_len = le16_to_cpu(req->gpd->rx_gpd.data_allow_len);
	if (recv_len > allow_len) {
		ret = -EPROTO;
		recv_len = allow_len;
	}
	req->skb->len = 0;
	skb_reset_tail_pointer(req->skb);
	skb_put(req->skb, recv_len);

For the in-tree queue config rx_mtu == rx_frag_size == Q_MTU_3_5K, so
mtk_cldma_rxq_alloc() leaves nr_bds at 0 and this unclamped path is the
one taken:

	rx_frag_size = rxq->que->rx_frag_size;
	if (rxq->que->rx_mtu > rx_frag_size && rx_frag_size)
		rxq->nr_bds = (rxq->que->rx_mtu + rx_frag_size - 1) / rx_frag_size;

The skb was allocated with __dev_alloc_skb(req->mtu), i.e. 3584 bytes, so
a device writing data_recv_len = data_allow_len = 0xFFFF would push
skb->tail past skb->end and hit skb_over_panic() -> BUG(). Should the
bound come from host-only state (req->mtu / the known allocation size)
rather than from descriptor memory the device can write?

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> index 5406f807747eb..4d379f3f4abaa 100644
> --- a/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_trans_ctrl.c
> @@ -453,15 +453,19 @@ static int mtk_pcie_hif_exit(struct mtk_md_dev *mdev)
>  	mutex_lock(&trans->submit_lock);
> +	if (!atomic_read(&trans->available)) {
> +		mutex_unlock(&trans->submit_lock);
> +		return 0;
> +	}
>  	atomic_set(&trans->available, 0);
> -	mutex_unlock(&trans->submit_lock);
> -
>  	mtk_cldma_exit(trans);
>  	mtk_ctrl_trb_srv_exit(trans);
> -
> -	/* Late submitters may still hold the lock and walk the tree. */
> -	mutex_lock(&trans->submit_lock);
>  	mtk_ctrl_remove_radix_tree(trans);
>  	mutex_unlock(&trans->submit_lock);

This is the ordering referenced in the mtk_cldma_exit() comment above:
mtk_cldma_exit() frees the CLDMA rings, pools, workqueue, drv_info and cd
one statement before mtk_ctrl_trb_srv_exit() stops the kthreads that
dereference them.
