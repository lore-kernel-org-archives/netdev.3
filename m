Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EE3F075A;
	Fri, 11 Sep 2026 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098119; cv=none; b=Kh1DoDfumu6zvLwMfA9aITX1AiNn4juugZo9JUEDNwgF/DhM6FtWDVjqiQ/hcXJ66gwoVHJ9c7tvFp4VHF/inMNuA53nnR5lubOpvmRe6wMCOQpaS5fW9TV/LoWbslWMpSKc7pNBDIOSAh+tYNbFEYalW/xwgUsHsKC+rmO8iI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098119; c=relaxed/simple;
	bh=VpJGxMTipozDFAvYMDee2tr9QCYZI5q2bpenjluesyw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5pFGbhDsLk6gclcGoPX8LOlTKsHCIiK4kYy9M4wbumqKuoYpj1gaNG142cKSGQivLYJPOEV/nF2MuIw6D1zxLSVts/MheuDxzvtY0jsn95j5ynO4tzFNipM3OCg2uMW7NkcbGBOetd1KhDsulgp35QKFH9FZwXiHirwrXes324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8+JpELe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8+JpELe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE55D1F00898;
	Fri, 11 Sep 2026 03:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098116;
	bh=eRxR7RzZLbKx/bUm1gKHR338EUGdzrRDXLG5n5wIHcc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h8+JpELeHqO8nvZTwVm2fbiwANf7pnx4oQ2s+fI4nFFufjobi6+FDUtpNBpU1snwF
	 hXm+Iuh1+Noa6TgKKwX5BuECghri2kvjLFuha23e8UCm1btageDK9TAXCCuX+9BhdH
	 hl2bNf+ubakyqPJcPhWbX2bDBz+xCiT1qvWnvNJ+E6lEWzj1DClmQTANC0sP/fPqRW
	 5ZdJDvisNzLV1oxmoovUuAvN/MrFwBPwP7/ugkVr5g3BM+Ycoh6l/x70PEvRObb6x6
	 ZIh9hH1A2LDunrHxJC8vMmxinhRQrMd6sWJWDvE+KYpG8JVbtSYqiSpZ++jFMr6laq
	 p4JKGUr8NaX5g==
Subject: Re: [PATCH v27 net-next 10/10] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:55 +0000
Message-ID: <178909811525.219967.16038617986565417580@kernel.org>
In-Reply-To: <20260907123848.30256-11-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-11-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 5 · Low: 3

- [Medium] nbl_dev_setup_common_dev() (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_core/nbl_dev.c:304-314) drops the `if…
- [Medium] nbl_dev_stop() (nbl_dev.c:510-521) and the nbl_dev_start()
  err_destroy_map unwind (nbl_dev.c:472-488) only log a failed…
- [Medium] nbl_dev_enable_mailbox_irq() (nbl_dev.c:80-99) publishes the
  software interrupt-mode flag before the hardware interrupt exists: it…
- [Medium] In nbl_dev_start() (nbl_dev.c:446-448) a failure of
  nbl_dev_cfg_msix_map() jumps to err_cancel_work, deliberately skipping…
- [Medium] The device is enabled with pcim_enable_device() in
  nbl_probe(), which makes MSI/MSI-X vector release devres-managed:…
- [Low] The err_destroy_map comment added to nbl_dev_start()
  (nbl_dev.c:480-481) states "If the RPC fails the device may remain…
- [Low] The comment in nbl_dev_init_msix_cnt() (nbl_dev.c:22-24) states
  that the mailbox vector is "allocated in nbl_dev_start() via…
- [Low] Several newly added call sites in nbl_dev.c have continuation
  lines that do not line up with the open parenthesis (checkpatch CHECK:…

--

net/nebula-matrix: add common dev start/stop operation

This adds nbl_dev_start() and nbl_dev_stop() to configure the hardware
MSI-X map, allocate MSI-X vectors, request the mailbox interrupt and tear
all of that down again.  Thin nbl_core_start() / nbl_core_stop() wrappers
are hooked into nbl_probe() and nbl_remove().  The VSI/ETH identity fetch
in nbl_dev_setup_common_dev() is also changed to run unconditionally.

A few questions below on the interrupt enable ordering, the rollback paths
and some of the new comments.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 7813ff31a3cfc..af003a240e7ba 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -17,6 +28,189 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
>  	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
>  }
>  

[ ... ]

> +static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	u16 local_vec_id;
> +
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
> +
> +	local_vec_id =
> +		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
> +				  NBL_CHAN_IRQ_RDY,
> +				  NBL_CHAN_TYPE_MAILBOX, true);
> +
> +	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
> +					    local_vec_id, true);
> +}

[Severity: Medium]
Is this ordering the reverse of the invariant documented a few lines below
in nbl_dev_disable_mailbox_irq()?  NBL_CHAN_IRQ_RDY is published here
before the hardware interrupt is armed, and on a non-control PF
set_mailbox_irq() is itself an ack-requesting mailbox RPC
(nbl_disp_chan_set_mailbox_irq_req()).

With IRQ_RDY already set, nbl_chan_send_msg() takes the sleeping branch:

	if (test_bit(NBL_CHAN_IRQ_RDY, chan_info->state)) {
		while (!READ_ONCE(wait_head->acked)) {
			ret = wait_event_timeout(wait_head->wait_queue, ...);

That branch has no queue_work(clean_task) fallback, unlike the polling
else-branch, so the ring is only drained by the very mailbox MSI-X this RPC
is supposed to arm.  nbl_hw_cfg_mailbox_qinfo() clears MSIX_IDX and
MSIX_IDX_VALID at init and only nbl_hw_set_mailbox_irq() sets them again.

If the responder's nbl_disp_chan_set_mailbox_irq_resp() takes an error
branch, it still sends the ack without arming the requester's routing:

	if (src_id >= disp_mgt->common->max_pf) { err = NBL_CHAN_RESP_PERM_DENY; goto ack_out; }
	...
	ack_out:
		nbl_chan_fill_ack_info(&chan_ack, src_id, NBL_CHAN_MSG_MAILBOX_SET_IRQ, msg_id, err, NULL, 0);

Can that wakeup then be lost, so the sender burns the full
NBL_CHAN_ACK_WAIT_TIME and reports -ETIMEDOUT instead of the remote error,
with the late ack later hitting a slot already marked
NBL_MBX_STATUS_TIMEOUT?  That looks like exactly the "Channel waiting ack
failed" / "Skip ack with invalid status" class of message the disable-path
comment says it wants to avoid.

Would arming the hardware while still in polling mode and setting
NBL_CHAN_IRQ_RDY afterwards be the mirror of the disable path?

[Severity: Low]
This isn't a bug, but the continuation line here is indented past the open
parenthesis, which checkpatch flags as "Alignment should match open
parenthesis".  The same applies to the set_mailbox_irq() call in
nbl_dev_disable_mailbox_irq(), the cfg_msix_map() call in
nbl_dev_cfg_msix_map(), and the reworked get_eth_id() call in
nbl_dev_setup_common_dev().

[ ... ]

> +static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	int needed = 0;
> +	int err;
> +	int i;
> +
> +	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
> +		needed += msix_info->serv_info[i].num;
> +
> +	err = pci_alloc_irq_vectors(common->pdev, needed, needed,
> +				    PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);

[Severity: Low]
With this function added, is the existing comment in nbl_dev_init_msix_cnt()
still accurate?

	/* mailbox vector allocated in nbl_dev_start() via
	 * nbl_dev_request_mailbox_irq()
	 */

The vectors are allocated here by pci_alloc_irq_vectors(), while
nbl_dev_request_mailbox_irq() only resolves an already allocated vector via
pci_irq_vector() and attaches a handler with request_irq().  The matching
release is likewise in nbl_dev_clear_interrupt_scheme(), not in
nbl_dev_free_mailbox_irq().  The commit message itself lists allocation as
step 2 and the IRQ request as step 3, so should that comment be updated to
point at nbl_dev_init_interrupt_scheme()?

> +	if (err < 0) {
> +		dev_err(common->dev,
> +			"pci_alloc_irq_vectors failed, err = %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_common_info *common = dev_mgt->common;
> +
> +	pci_free_irq_vectors(common->pdev);
> +}

[Severity: Medium]
nbl_probe() enables the device with pcim_enable_device(), which makes MSI-X
release devres-managed: pci_alloc_irq_vectors() -> __pci_enable_msix_range()
-> pci_setup_msi_context() -> pcim_setup_msi_release() registers
pcim_msi_release(), and that action calls pci_free_irq_vectors() itself on
detach.

Is the explicit call here safe in that case?  The kernel-doc of
pci_free_irq_vectors() in drivers/pci/msi/api.c says:

 * WARNING: Do not call this function if the device has been enabled
 * with pcim_enable_device(). In that case, IRQ vectors are automatically
 * managed via pcim_msi_release() and calling pci_free_irq_vectors() can
 * lead to double-free issues.

Today the second call appears to be absorbed by the !dev->msix_enabled early
return in pci_disable_msix(), but should the driver either use unmanaged
pci_enable_device() with explicit cleanup, or leave the release to the
managed lifecycle?

[ ... ]

> @@ -99,17 +301,18 @@ static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
>  	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
>  	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
>  				   &common_dev->clean_mbx_task);
> -	if (common->has_ctrl) {
> -		ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
> -		if (ret)
> -			goto err_cleanup;
> -		ret = disp_ops->get_eth_id(priv, common->vsi_id,
> -					   &common->eth_num,
> -					   &common->eth_id,
> -					   &common->logic_eth_id);
> -		if (ret)
> -			goto err_cleanup;
> -	}
> +	/*
> +	 * Even if has_ctrl=false (no dedicated control PF channel), we fetch
> +	 * VSI/ETH info via regular mailbox message instead of dedicated
> +	 * control command.
> +	 */
> +	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
> +	if (ret)
> +		goto err_cleanup;
> +	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
> +			     &common->eth_id, &common->logic_eth_id);
> +	if (ret)
> +		goto err_cleanup;

[Severity: Medium]
Dropping the has_ctrl guard makes every non-control PF issue two
synchronous mailbox RPCs from inside its own probe():

nbl_probe() -> nbl_core_init() -> nbl_dev_init() ->
nbl_dev_setup_common_dev() -> nbl_disp_chan_get_vsi_id_req() ->
nbl_chan_send_msg(dstid = common->mgt_pf = 0)

and the transport error propagates straight out:

	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
	if (ret < 0)
		return ret;

What happens if function 0 is not bound yet?  The mailbox QINFO entries used
to route a non-control PF's traffic are programmed only by the control PF:

nbl_chan_cfg_qinfo_map_table() {
	hw_ops->get_host_pf_mask(p, &pf_mask);
	for (func_id = 0; func_id < NBL_MAX_PF; func_id++)
		if (!(pf_mask & (1 << func_id)))
			hw_ops->cfg_mailbox_qinfo(p, func_id, bus, devid, func_id);
}

and that is only reached from nbl_dev_setup_ctrl_dev().  So before PF0's
probe has run, does the non-control PF get -ETIMEDOUT here and fail probe
permanently, with no -EPROBE_DEFER and no retry?

This is reachable without special hardware, for example unbinding PF0 and
then binding another PF, PF0 probe failing for an unrelated reason, or
async_probe making PF1 race ahead of PF0.

The commit message says:

    The control PF's responder is reachable once its own probe has
    completed and the mailbox queue is operational.

Should the identity fetch be deferred to a later point such as
nbl_dev_start() or ndo_open(), or should probe return -EPROBE_DEFER when
the manager PF has not answered?  This cross-PF probe dependency also looks
unrelated to the patch subject.

>  
>  	dev_mgt->common_dev = common_dev;
>  	nbl_dev_init_msix_cnt(dev_mgt);
> @@ -231,3 +434,96 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  		nbl_dev_remove_ctrl_dev(adapter);
>  	nbl_dev_remove_common_dev(adapter);
>  }
> +
> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	int cleanup_ret;
> +	int ret;
> +
> +	ret = nbl_dev_cfg_msix_map(dev_mgt);
> +	if (ret)
> +		goto err_cancel_work;

[Severity: Medium]
Does skipping nbl_dev_destroy_msix_map() on this branch leak resources on
the manager PF?

On a non-control PF, cfg_msix_map is an ack-requesting RPC
(nbl_disp_chan_cfg_msix_map_req()), and `if (ret < 0) return ret;` cannot
tell "remote never configured" from "remote configured but the ack was lost
or timed out".  On the responder side the commit point has no rollback:

nbl_res_intr_cfg_msix_map() {
	intr_mgt->func_intr_res[func_id].interrupts = tmp_interrupts;
	...
	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
			     true, official_tbl->dma, common->hw_bus,
			     common->devid, common->function);
}

so the coherent MSI-X map table, the interrupts[] array, the global vector
IDs taken from intr_net_bmap/intr_other_bmap and an armed FUNCTION_MSIX_MAP
entry all stay committed for the requesting function.

The requester never sends NBL_CHAN_MSG_DESTROY_MSIX_MAP afterwards, since
nbl_probe() only runs nbl_core_remove() when nbl_core_start() fails:

	core_start_err:
		nbl_core_remove(adapter);

Calling nbl_dev_destroy_msix_map() on this path looks harmless, as
__nbl_res_intr_destroy_msix_map() returns 0 immediately when interrupts is
NULL.  Would jumping to err_destroy_map here be more consistent with the
commit message claim that "a failure at any stage leaves the device and
kernel in a consistent state"?

> +
> +	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
> +	if (ret)
> +		goto err_destroy_map;
> +
> +	ret = nbl_dev_request_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto err_destroy_map;
> +
> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto err_disable_irq;
> +
> +	return 0;
> +
> +err_disable_irq:
> +	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
> +	if (cleanup_ret)
> +		dev_err(dev_mgt->common->dev,
> +			"rollback: disable mailbox IRQ failed: %d\n",
> +			cleanup_ret);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +err_destroy_map:
> +	/*
> +	 * Destroy device-side MSI-X map BEFORE releasing kernel-side
> +	 * vectors.  This masks all hardware vectors and clears the
> +	 * pcompleter map entry, so no MSI-X message can fire after
> +	 * pci_free_irq_vectors() releases the vectors.
> +	 *
> +	 * For non-control PFs this is a polling-mode mailbox RPC
> +	 * (IRQ_RDY already cleared by disable above, or never set).
> +	 * If the RPC fails the device may remain armed; pci_clear_master()
> +	 * in nbl_remove() is the final safety net.
> +	 */

[Severity: Low]
Is nbl_remove() actually reached on this path?  A nbl_dev_start() failure
propagates through nbl_core_start() into nbl_probe(), which does
`goto core_start_err` and falls through to the adapter_init_err label:

	core_start_err:
		nbl_core_remove(adapter);
	adapter_init_err:
		pci_clear_master(pdev);
		return err;

The PCI core does not call .remove after a failed probe, so the safety net
described here appears to live in nbl_probe()'s error label rather than in
nbl_remove().  Could the comment name the label that really runs?

> +	cleanup_ret = nbl_dev_destroy_msix_map(dev_mgt);
> +	if (cleanup_ret)
> +		dev_err(dev_mgt->common->dev,
> +			"rollback: destroy MSI-X map failed: %d\n",
> +			cleanup_ret);
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +err_cancel_work:
> +	/*
> +	 * destroy_msix_map() polling send may requeue clean_mbx_task.
> +	 * Drain before returning on all rollback paths.
> +	 */
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	return ret;
> +}
> +
> +void nbl_dev_stop(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	int ret;
> +
> +	ret = nbl_dev_disable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to disable mailbox IRQ: %d\n", ret);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +
> +	/*
> +	 * Destroy hardware MSI-X map BEFORE releasing kernel-side
> +	 * vectors.  Masks all device vectors and clears pcompleter
> +	 * map entry first; pci_free_irq_vectors() then runs with no
> +	 * possibility of a stale MSI-X message arriving.
> +	 */
> +	ret = nbl_dev_destroy_msix_map(dev_mgt);
> +	if (ret)
> +		dev_err(dev_mgt->common->dev,
> +			"Failed to destroy MSI-X map: %d\n", ret);
> +
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);

[Severity: Medium]
Does the code above match the comment when nbl_dev_destroy_msix_map()
fails?  The failure is only logged and pci_free_irq_vectors() runs anyway,
so the device-side pcompleter map entry stays valid and the vectors stay
armed while the host side releases them.  The same applies to the
err_destroy_map path in nbl_dev_start().

On a non-control PF that RPC can return -ETIMEDOUT, -EREMOTEIO or -EPERM
whenever the manager PF cannot answer (PF0 unbound first, lost ack,
responder error).

The fallback named in both the comment and the changelog also looks like it
runs too late.  In nbl_remove():

	nbl_core_stop(adapter);
	nbl_core_remove(adapter);

	pci_clear_master(pdev);

pci_clear_master() only executes after the vectors are already freed.  And
nbl_res_intr_cfg_msix_map() tags the map-table DMA with the control PF's
BDF:

	/*
	 * cfg_msix_map uses the control PF's own BDF (common->hw_bus etc.),
	 * not the target function's BDF. ...
	 */
	hw_ops->cfg_msix_map(..., true, official_tbl->dma, common->hw_bus, common->devid, common->function);

so can clearing bus mastering on the departing non-control PF quiesce that
DMA at all?  Should the teardown either retry or keep the vectors until the
device-side map is confirmed destroyed, and should the comment and the
changelog sentence "pci_clear_master() in nbl_remove() provides the final
safety net if a teardown RPC to the manager PF cannot complete" be adjusted?

> +
> +	/*
> +	 * destroy_msix_map() sends ack-requested messages which may
> +	 * requeue clean_mbx_task via polling send path.  Drain work
> +	 * after the operation.
> +	 */
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +}

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 9896c1b49be2b..02cb35d32012f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> @@ -127,7 +137,13 @@ static int nbl_probe(struct pci_dev *pdev,
>  		goto adapter_init_err;
>  	}
>  	pci_set_drvdata(pdev, adapter);
> +	err = nbl_core_start(adapter);
> +	if (err)
> +		goto core_start_err;
> +
>  	return 0;
> +core_start_err:
> +	nbl_core_remove(adapter);
>  adapter_init_err:
>  	pci_clear_master(pdev);
>  	return err;

[ ... ]

Thanks for considering these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
