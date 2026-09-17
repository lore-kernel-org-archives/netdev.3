Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F54A33E1;
	Thu, 17 Sep 2026 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684515; cv=none; b=chHiQOUeVRL2KJbi0xAIsALUEQEb8KI3bB1YlzZDIcyeer5PoBXvRA8sEclVPw/2IwYzjgAK8REXdAUR/Y/ZMgonUQvT9nQx68QSi5m5yPB5Kn4Y0WGo7sYFIzjaJejo1EFi/gqofq1XvRt6IURlMCBdYcxxBRYDbLX+GrcD8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684515; c=relaxed/simple;
	bh=E81EzTF2YE0q5fKGkj7CoihBC31oASaqeVOBCZzI/IQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=go0S4GOYkQG3RFZLObBybqdf6fdukqNZDxhYnsLSzLshXhsYfVw0WO1F27qnz/Q6p93G64gPIVmlwj5gIEpBZDpJ9hMqP6zEP2OEhKlRA2zgXc236uKzfUXUU4iVMfEK3Lpo6TlTu9kp335DD/OdkA+h3oPqq045t94N5AQxk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKYctAt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKYctAt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015381F000FF;
	Thu, 17 Sep 2026 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684512;
	bh=l2q7dcj+cgI4tSys127UKH4A9BSfcc/MijqXW/vWg3k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bKYctAt25G6X2o78Wf8jcPe2n5XE+zyMkVfca+N3ry2I/TKVZClWthrbe5oNTv4uQ
	 2R+a+bvHzkaUALkWOLRHtAcwgn2FAKOxazqN/4qNhv1bEBqdrLceyxGPN/zGLXKdOU
	 KFtnDmIuxVMFSiBvtQJp3YRsOVnS+LpMEntUTIq1N+rSB3LiFgC6WSh8kWAx05KQgF
	 ZEZei1Lz46TkHE4oTc/BAbmU1Sx/978Juj0m+OOAassYZetLumlNBWF7GPA6wd3mu+
	 Nyfw1mvbTHMvnBbnbzjE29nHWQa1ok60JF7KjeK9kAEwEca2vlQ2WFmIqJ81ghhYlk
	 mpEIg/1TuscMw==
Subject: Re: [PATCH v28 net-next 09/10] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:11 +0000
Message-ID: <178968451158.22033.8034737519557582768@kernel.org>
In-Reply-To: <20260914123429.56596-10-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-10-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 5 · Low: 0

- [Medium] Commit message contradicts the code: it states that common
  device setup does "On the control PF only: fetch VSI/ETH identity via…
- [Medium] nbl_dev_setup_common_dev() calls
  cancel_work_sync(&common_dev->clean_mbx_task) on a work_struct that…
- [Medium] The patch introduces an unguarded chip-global cross-PF
  dependency: nbl_dev_setup_ctrl_dev() -> nbl_dev_setup_chan_qinfo() ->…
- [Medium] nbl_dev_remove_common_dev() (nbl_dev.c:115-125) discards the
  int return value of nbl_dev_remove_chan_queue() ->…
- [Medium] Hardware sequencing bug: the mailbox TX/RX rings are armed in
  hardware before the chip-side mailbox routing entry that identifies…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This adds the nbl_dev layer with nbl_dev_setup_common_dev() and
nbl_dev_setup_ctrl_dev() plus their teardown counterparts, wired into
nbl_dev_init() / nbl_dev_remove() from nbl_core_init() / nbl_core_remove().
Common dev setup brings up the mailbox channel queue and registers the
mailbox cleanup work; ctrl dev setup calls init_module() and programs the
mailbox QINFO routing map.

A few questions below.

>     Common device setup (nbl_dev_setup_common_dev):
>     - Allocate per-device state (nbl_dev_common)
>     - Set up mailbox channel queue and register cleanup work
>     - Initialize MSI-X service counts (mailbox = 1 vector; actual
>       allocation deferred to nbl_dev_start() in the next patch; this
>       patch only populates service vector counts)
>     - On the control PF only: fetch VSI/ETH identity via local
>       dispatch ops. Non-control PFs defer this to nbl_dev_start(),
>       when the mailbox channel is fully operational and the control
>       PF's responder is running; this keeps every intermediate commit
>       bisect-bootable on multi-PF systems.

[Severity: Medium]
Does the code match this description?  nbl_dev_setup_common_dev() only
allocates nbl_dev_common, sets up the mailbox channel queue, does
INIT_WORK() plus nbl_dev_register_chan_task(), stores common_dev and calls
nbl_dev_init_msix_cnt().  There is no get_vsi_id()/get_eth_id() call in
nbl_dev.c at all, and the in-code comment says the opposite of the
changelog:

	/*
	 * VSI/ETH identity fetch moved to nbl_dev_start().
	 * This avoids cross-PF probe race when manager PF is not ready.
	 */

So common->vsi_id / common->eth_id / common->eth_num stay zero after
nbl_dev_init() on every PF, including the control PF.

Should the changelog say the identity fetch is deferred to nbl_dev_start()
for all PFs rather than "On the control PF only: fetch VSI/ETH identity via
local dispatch ops"?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..75c0d83663b9c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,235 @@

[ ... ]

> +/* ----------  Channel config  ---------- */
> +static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
> +	struct nbl_common_info *common = dev_mgt->common;
> +
> +	if (!chan_ops->check_queue_exist(priv, chan_type))
> +		return;
> +
> +	chan_ops->cfg_chan_qinfo_map_table(priv, common->hw_bus, common->devid);
> +}

[ ... ]

> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev;
> +	int ret;
> +
> +	common_dev = devm_kzalloc(&adapter->pdev->dev, sizeof(*common_dev),
> +				  GFP_KERNEL);
> +	if (!common_dev)
> +		return -ENOMEM;
> +	common_dev->dev_mgt = dev_mgt;
> +
> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		goto err_cleanup;

[Severity: Medium]
Is the hardware ordering here safe with respect to the mailbox routing map?
This call arms the mailbox rings:

nbl_dev_setup_chan_queue() -> nbl_chan_setup_queue()
    nbl_hw_config_mailbox_txq() / nbl_hw_config_mailbox_rxq()  (QUEUE_EN=1)
    nbl_chan_update_tail_ptr()                                 (rx doorbell)

but the per-function BUS/DEVID/FUNCTION routing entry is only written later,
and only when common->has_ctrl:

nbl_dev_init()
    nbl_dev_setup_common_dev()          <- queues enabled here
    if (common->has_ctrl)
        nbl_dev_setup_ctrl_dev()
            nbl_dev_setup_chan_qinfo()  <- QINFO_MAP written here
                nbl_chan_cfg_qinfo_map_table() -> nbl_hw_cfg_mailbox_qinfo()

	data |= FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);

A non-control PF never programs its own entry, and this patch states firmware
clears those chip-global entries when the control PF sets driver_status=false.

Can a PF then run with mailbox queues enabled while its QINFO_MAP entry is
zero or stale, for example when a non-control PF is bound while function 0 is
not bound, or in the window on control PF re-probe between arming its rings
and writing QINFO_MAP for function 0?  Would mailbox DMA in that window be
tagged with 00:00.0 or a stale bus?

Would it be safer to program a function's QINFO routing entry before enabling
that function's mailbox queue?

> +
> +	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);
> +	/*
> +	 * VSI/ETH identity fetch moved to nbl_dev_start().
> +	 * This avoids cross-PF probe race when manager PF is not ready.
> +	 */
> +	dev_mgt->common_dev = common_dev;
> +	nbl_dev_init_msix_cnt(dev_mgt);
> +
> +	return 0;
> +err_cleanup:
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +	return ret;
> +}

[Severity: Medium]
Can this warn on an uninitialized work item?  The only jump to err_cleanup is
the nbl_dev_setup_chan_queue() failure, which is before the INIT_WORK(), so
clean_mbx_task is still all zeros from devm_kzalloc() (work->func == NULL, no
lockdep map) when cancel_work_sync() runs:

cancel_work_sync() -> __cancel_work_sync() -> __flush_work(work, true)

kernel/workqueue.c:__flush_work() {
	...
	if (WARN_ON(!work->func))
		return false;
	...
}

That gives a WARNING backtrace (panic with panic_on_warn) instead of a clean
probe failure.

The same label also tears down a queue that was never brought up
(nbl_chan_teardown_queue() then logs "channel not active, skip duplicate
teardown") and unregisters a task that was never registered.

Would moving INIT_WORK() above nbl_dev_setup_chan_queue(), or just returning
ret directly on that path, be preferable?

> +
> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	if (!common_dev)
> +		return;
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +}

[Severity: Medium]
Should the return value of nbl_dev_remove_chan_queue() be checked here?  It
propagates -ETIMEDOUT from the drain in nbl_chan_teardown_queue():

nbl_channel.c:nbl_chan_teardown_queue() {
	...
	ret = wait_event_timeout(chan_info->inflight_wait,
				 atomic_read(&chan_info->inflight_tx_cnt) == 0,
				 msecs_to_jiffies(5000));

	if (!ret) {
		dev_warn(chan_mgt->common->dev,
			 "teardown: inflight tx drain timeout\n");
		ret = -ETIMEDOUT;
	...
}

whose comment says callers must not access queue resources while an inflight
sender may still be active.  nbl_dev_remove() then proceeds to
nbl_dev_remove_ctrl_dev() -> deinit_module() -> nbl_hw_deinit_module(), which
documents a premise nobody verifies:

nbl_hw_leonis.c:nbl_hw_deinit_module() {
	 * Caller must ensure no new DMA is initiated after this point.
	 * The mailbox channel is stopped by nbl_chan_teardown_queue()
	 * before this function is called, so no in-flight mailbox DMA
	 * remains.
}

On the timeout path that premise does not hold: driver_status=false starts the
asynchronous firmware cleanup while a sender may still be writing descriptors
into the dmam_alloc_coherent() rings, which devres frees right after remove()
returns.

Can this at least log or bail out on the -ETIMEDOUT case rather than
discarding it?

> +
> +static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	int ret;
> +
> +	ret = disp_ops->init_module(dev_mgt->disp_ops_tbl->priv);
> +	if (ret)
> +		return ret;
> +
> +	nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +
> +	return 0;
> +}
> +
> +/*
> + * Tear down control device: deinit_module sets driver_status=false
> + * to notify firmware to clean all per-PF hardware state (including
> + * qinfo registers).  The qinfo map programmed in setup_ctrl_dev is
> + * not explicitly cleared; firmware handles it on driver_status change.
> + *
> + * NOTE: Firmware clears chip-global qinfo routing entries when control PF
> + * deinit runs.  MUST unbind all sibling non-control PFs on the same chip
> + * BEFORE unbinding the control PF. Unbinding control PF while siblings are
> + * still bound will leave those sibling PFs with broken mailbox RPC,
> + * causing RPC ACK timeouts. This operation sequence is NOT supported.
> + */
> +static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +
> +	disp_ops->deinit_module(dev_mgt->disp_ops_tbl->priv);
> +}

[Severity: Medium]
Can anything stop the unbind order that this comment says is unsupported?

nbl_dev_setup_ctrl_dev() -> nbl_dev_setup_chan_qinfo() ->
nbl_chan_cfg_qinfo_map_table() programs NBL_MAILBOX_QINFO_MAP_REG_ARR() for
every hardware-active PF, and nbl_dev_remove_ctrl_dev() calls deinit_module()
-> nbl_hw_deinit_module() (driver_status=false) unconditionally.

nbl_remove() runs per PCI function with no cross-function coordination:

nbl_remove()
    pci_set_drvdata(pdev, NULL);
    nbl_core_remove(adapter);
        nbl_dev_remove()
            if (common->has_ctrl)
                nbl_dev_remove_ctrl_dev()   <- chip-global deinit

So a plain

  echo <pf0-bdf> > /sys/bus/pci/drivers/nbl/unbind

silently breaks every still-bound sibling PF: their mailbox RPCs are no longer
routed, so each dispatch RPC ends in an ACK timeout (3s ACK wait, 5s drain),
and their own later teardown RPCs fail too.

Would a refusal or a reference count on the control PF be better than
documenting the hazard, or can the chip-global dependency be avoided?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
