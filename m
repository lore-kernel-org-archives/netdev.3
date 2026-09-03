Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6884F6482;
	Thu,  3 Sep 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455927; cv=none; b=dmS3z4udAFP4vB9l3OU5kWYpFA68YfNdLpUvyeDXgJxkMfiNzIrK29UwyYP+qz7A27nmK/lyaZHK9nYhd5xw0W3AaaaTy6IpOlzdbDJmZsi0lDYNmDEJaiMtAC3aw+GpVHYGSGqxa48U+/C76oXEB4F3Su06sb2fOJlIqHgHJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455927; c=relaxed/simple;
	bh=SproD9EVvEjX2d85Qy+RJG2tz9WOx/zM4zeDlfICLEg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUVhOVcVFq6SSVa44AjiiddJXSP7ZvDotJO8he0JlMu5Ql/zUxRrc+2/TE6DX6F00x5I3bZdvolCg5tnvQMrBceiqNv7F5gk7heDsok3wtFEI5sI1wcVfx8H8CH/t8M+Tfboo6IUuP9CJbMEDiEL4CHJtuXDsdr81pzrXTeQz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdrP4OEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdrP4OEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341DC1F00A3F;
	Thu,  3 Sep 2026 17:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455925;
	bh=i5M5lIotdS18jd0lktx+ox3dLyD3xrY3JiUctRX0idc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bdrP4OEhkuQjv8CwoXEK6P59lBKjjJ/G1cL9RZYY4QMtnLR1ViCSVhaZH+lD4U77e
	 vpTIn4N90KSfFDg04ZpzElBzRvZ6oQGezsELRG7apld4lhhLDv1Z0GZCitcWYejMs+
	 EpVGrW5ZTeuuxUtvDom7toYtyax8wWOV0tYYVRodAbPvcjGP0FWYCOf/j+XRYwMCnZ
	 qSkSwMqV8Old6sHrin7gOK/gv3i6Vk7ZqAXmi/2G5czOrgCTPvYsAkbQ+lGLDx7NEP
	 b2WFoWZSz2DLIs86Ee+j/S4tFiYQ5fwB/YDoeuD5YEEMG+tPLb48X+kVkfTf+n4Nt5
	 up0DvBnzt1ChA==
Subject: Re: [v26,net-next,09/10] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:43 +0000
Message-ID: <178845592378.3394541.15652479231011482818@kernel.org>
In-Reply-To: <20260831021408.2325-10-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-10-illusion.wang@nebula-matrix.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 2

- [Medium] nbl_dev_setup_common_dev() issues two synchronous ACK-waiting
  mailbox requests (disp_ops->get_vsi_id(), disp_ops->get_eth_id())…
- [Medium] nbl_dev_setup_common_dev() enables the PF mailbox queue
  (nbl_chan_setup_queue(): config_mailbox_txq/rxq with QUEUE_EN=1,…
- [Medium] nbl_dev_remove() relies on nbl_dev_remove_ctrl_dev() ->
  disp_ops->deinit_module() -> nbl_hw_deinit_module(), which only does a…
- [Low] The justification comment block added above
  nbl_dev_remove_ctrl_dev() in nbl_core/nbl_dev.c is factually wrong and…
- [Low] The in-tree comment documenting the ordering contract for
  common->hw_bus in nbl_res_ctrl_dev_sriov_info_init()…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This adds the nbl_dev core layer with nbl_dev_setup_common_dev() and
nbl_dev_setup_ctrl_dev() plus their teardown counterparts, and wires them
into nbl_dev_init()/nbl_dev_remove() from nbl_core_init()/nbl_core_remove().
A few questions below about the probe/remove ordering and about some of the
new comments and the commit message.

> Enforce the deinit sequence: remove ctrl dev first to notify firmware
> to clean all per-PF hardware state including qinfo registers. Afterwards
> tear down common device queue resources. Firmware cleanup ensures valid
> register access during common dev deinit and prevents PCIe master abort.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 000000000000..4fc52cadf60f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,236 @@

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

[Severity: Low]

This is the only in-tree caller of cfg_chan_qinfo_map_table(), and it is
reached as nbl_dev_init() -> nbl_dev_setup_ctrl_dev() ->
nbl_dev_setup_chan_qinfo().  The existing comment that documents the
ordering contract for common->hw_bus names a different call site:

nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c:nbl_res_ctrl_dev_sriov_info_init() {
	/*
	 * common->hw_bus supplies bus number for channel mailbox QINFO mapping.
	 * Execution order guarantee: this assignment runs before
	 * cfg_chan_qinfo_map_table() in nbl_dev_start(), only executed
	 * on control PF path.
	 */
	common->hw_bus = hw_bus;
}

There is no nbl_dev_start() at this commit, and the nbl_dev_start() added
later in the series calls nbl_dev_cfg_msix_map(),
nbl_dev_init_interrupt_scheme(), nbl_dev_request_mailbox_irq() and
nbl_dev_enable_mailbox_irq() only, so it never programs the qinfo map.  The
ordering itself does hold today, since nbl_res_init_leonis() runs before
nbl_dev_init() in nbl_core_init().  Could that comment be updated to point
at nbl_dev_setup_ctrl_dev() instead?

[ ... ]

> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);
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

Can these two calls complete at this point in the series?

On a non-control PF, get_vsi_id()/get_eth_id() resolve to
nbl_disp_chan_get_vsi_id_req()/nbl_disp_chan_get_eth_id_req(), i.e. real
mailbox round trips to mgt_pf that wait for an ACK.

At this commit nothing in the tree requests a mailbox interrupt and
NBL_CHAN_IRQ_RDY is never set, so in nbl_chan_send_msg() the polling branch
only drains the sender's own RX ring:

nbl_channel/nbl_channel.c:nbl_chan_send_msg() {
	if (test_bit(NBL_CHAN_IRQ_RDY, chan_info->state)) { ... }
	else { /* Polling path for synchronous ACK */ }
}

The control PF has nothing driving nbl_chan_clean_queue() on its side, so
the responder never runs and both requests appear to time out, failing
probe on every non-control PF.

The later patch in this series ("net/nebula-matrix: add common dev
start/stop operation") adds nbl_dev_request_mailbox_irq() and
nbl_dev_enable_mailbox_irq(), and nbl_probe() then calls nbl_core_start()
-> nbl_dev_start(), which is what makes the control PF drain its RX ring
and answer.  So the ACK path does exist at the end of the series and this
looks limited to the intermediate tree state.  Would it be possible to
order the series so probe works at each step, or is the intermediate
bisect state intentional here?

Also, nbl_dev_init_msix_cnt() records
msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1 in this patch while no
vector is allocated or requested yet, which fits the same observation.

[ ... ]

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
> + * This is intentional.  The qinfo registers are managed by the chip
> + * firmware, not by the driver.  Setting driver status to false is the
> + * designed teardown mechanism — it notifies the firmware, which then
> + * performs its own cleanup of all per-PF state including the qinfo
> + * registers.
> + * An inverse helper would duplicate work that the firmware already
> + * does, and would add error-path complexity for no benefit.  We keep
> + * the deinit path minimal and rely on the firmware cleanup for
> + * correctness, including in abnormal reset scenarios.
> + */
> +static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +
> +	disp_ops->deinit_module(dev_mgt->disp_ops_tbl->priv);
> +}

[Severity: Low]

Is the claim that "The qinfo registers are managed by the chip firmware,
not by the driver" accurate?  The path added just above this comment
programs them from the driver:

nbl_dev_setup_chan_qinfo()
  chan_ops->cfg_chan_qinfo_map_table()
    nbl_chan_cfg_qinfo_map_table()
      hw_ops->cfg_mailbox_qinfo()
        nbl_hw_cfg_mailbox_qinfo()

nbl_channel/nbl_channel.c:nbl_chan_cfg_qinfo_map_table() {
	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
		if (!(pf_mask & (1 << func_id)))
			hw_ops->cfg_mailbox_qinfo(p, func_id, bus, devid, func_id);
	}
}

Only the cleanup is delegated to firmware, so would something like "the
qinfo registers are cleaned up by firmware on driver-status change" be
closer to what happens?

Two more notes on the same block: it is a near-verbatim copy of the comment
already sitting above nbl_hw_deinit_module() in
nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c, which is where the described register
write actually lives, and the opening "This is intentional." reads as a
reply to review feedback rather than as documentation.  Could it be dropped
here and kept only at the hw layer?

Relatedly, the commit message says:

> Introduce nbl_dev_setup_common_dev()
> and nbl_dev_setup_ctrl_dev() initialization helpers with paired
> teardown routines

nbl_dev_setup_ctrl_dev() does init_module() plus qinfo map programming while
nbl_dev_remove_ctrl_dev() does deinit_module() only, so the two are not
symmetric.

[ ... ]

> +int nbl_dev_init(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	/*
> +	 * Chip hardware initialization is completed by firmware at power-up.
> +	 * Only driver functional table/register config follows here, safe to
> +	 * access hardware registers before ctrl dev setup.
> +	 */
> +	ret = nbl_dev_setup_common_dev(adapter);
> +	if (ret)
> +		goto setup_err;
> +
> +	if (common->has_ctrl) {
> +		ret = nbl_dev_setup_ctrl_dev(adapter);
> +		if (ret)
> +			goto setup_ctrl_dev_fail;
> +	}

[Severity: Medium]

What guarantees the mailbox routing table entry for a non-control PF is
programmed before that PF starts using its mailbox?

nbl_dev_setup_common_dev() enables the PF mailbox queue
(nbl_chan_setup_queue() -> config_mailbox_txq/rxq with QUEUE_EN=1, RST=0,
RX tail written) and then immediately sends mailbox messages, but
NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id) is written only afterwards and only
on the control PF:

nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c:nbl_hw_cfg_mailbox_qinfo() {
	data = FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);
}

has_ctrl is set only for PCI function 0 in nbl_get_func_param(), so PF1..PF3
never program that table themselves.  Their probe path depends on PF0 having
already done it, and nothing in nbl_dev_init() checks or enforces that.

Cases where the entry may not be programmed yet look reachable: PF0 unbound
via sysfs, PF0 bound to a different driver, or concurrent probing when async
probing is enabled.  If the entry still holds zero, the mailbox ring BDF is
also zero.  Best case that means the two ACK timeouts above and a probe
failure with no retry; is a write towards a zero BDF also possible on this
chip, and if so what stops it?

> +/*
> + * Teardown order: ctrl dev first, then common dev.
> + * nbl_dev_remove_ctrl_dev() notifies firmware to clean all per-PF state
> + * (including qinfo registers), so subsequent common dev queue cleanup
> + * will not trigger PCIe master abort or invalid register access.
> + */
> +void nbl_dev_remove(struct nbl_adapter *adapter)
> +{
> +	struct nbl_common_info *common = &adapter->common;
> +
> +	if (common->has_ctrl)
> +		nbl_dev_remove_ctrl_dev(adapter);
> +	nbl_dev_remove_common_dev(adapter);
> +}

[Severity: Medium]

How is the firmware cleanup serialized against the queue teardown that
follows it?  The notification is a bare register write plus a flush:

nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c:nbl_hw_deinit_module() {
	nbl_hw_set_driver_status(hw_mgt, false);
	/* ensure registers written */
	nbl_flush_writes(hw_mgt);
}

There is no completion poll, status read-back or delay before
nbl_dev_remove_common_dev() -> nbl_chan_teardown_queue() writes the queue
reset:

nbl_hw_stop_mailbox_rxq() / nbl_hw_stop_mailbox_txq() {
	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
			      cfg_tbl.data, sizeof(cfg_tbl));
}

and the QUEUE_RST/QUEUE_EN state is never read back, so a firmware write
landing after the driver's reset write would leave the queue enabled in
hardware while the driver believes it is stopped, with no way to notice.

Could a driver-status handshake or a queue-reset read-back be added, or the
claim in the commit message be dropped:

> Firmware cleanup ensures valid
> register access during common dev deinit and prevents PCIe master abort.

For what it is worth, the DMA-after-free variant of this does not seem to
apply: nbl_remove() calls pci_clear_master(pdev) before returning, and the
dmam_alloc_coherent() rings are released by devres only after .remove()
returns, so bus mastering is already off when the ring memory goes away.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
