Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CC4418F0;
	Sat, 26 Sep 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431249; cv=none; b=muh0AY7DP+t6pqJ7dAF+wpYmKe+2Jgi0Aq+12UAxX12mLok1mMaG7GvmY6jftEZkjUzmrsd9kCj6i0uEkqT8JYUV048gloTZlW5yP0WkYj9ACTx4LSzcVh+RyqOlL2qQJdGx9OQKOJBjJS8mIRCLNe8KdmZMciLsgre5+hRmDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431249; c=relaxed/simple;
	bh=G+9u/CVuxQJLViGVZtloBJwKTlG2Zbx3U6oEuOnJg/E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChWNFz+B1hB1Gxp021gACsqkCb6vgaXPDFRqW5IA7Kq/GgIcGY6q0Defc5JoF9lptECQZHcvbRogC8mS1rLyURUZXzdNQzAvrVNvJGwxKjio3QR4epPjyjqH14Sr239F4BfLm8ZUBMzcArk9OV4Dreqjv5T0VQmR8XERbBRRQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+4roPw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+4roPw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7601F0089C;
	Sat, 26 Sep 2026 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431235;
	bh=6Mjhsps4m/5az2aSJpNK4HCAF92PT0bofHC2tJDdkDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e+4roPw0+W6ER8ubnXgLt0V+0/75H1TsmQGzwCvcktlld4gYhTVLaffQOtKNftd4V
	 GfOugupojMdCZq6GZSmEsFtFaffWUomngsbBKhP1cz7bnsldnb56xdxYt4Ys04cOPS
	 aSsNMw+j572lqVBvAX4pu5TZxlTo39DXzkT3S9Q1aJ4AVDhjgxwHn5ajtzlTewCjUk
	 kzgPzYieswn24EQHcniRk3jZHSUrq34QVSWi07tB9i1oI9LJLm7PBTOwQH2XqEqkrS
	 k8UBsLAOYG4b+d1/nNMDqnOSW5ZHE/mvQnS33+cBg41xHm5yfWGG6FN4GD5/YfhUne
	 yOF1vPhpCkncg==
Subject: Re: [PATCH v29 net-next 7/8] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:34 +0000
Message-ID: <179043123425.2160803.17622692985729273243@kernel.org>
In-Reply-To: <20260922120311.86593-8-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-8-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nbl_dev_remove_ctrl_dev() (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_core/nbl_dev.c:177-183) calls disp_ops->deinit_module()…
- [High] There is no synchronization between the chip-global operations
  this patch adds and sibling (non-control) PFs that are concurrently…
- [Medium] The commit message lists "Program mailbox QINFO routing map
  (bus/devid for each PF)" under "Control device setup…
- [Medium] nbl_dev_remove_common_dev() (nbl_dev.c:128-142) reduces a
  failed mailbox queue teardown to dev_warn("mailbox queue teardown…
- [Low] nbl_dev_setup_ctrl_dev() (nbl_dev.c:144-155) contains a pointless
  round trip: `ret = disp_ops->init_module(...); if (ret) return ret;…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This patch adds the nbl_dev layer with nbl_dev_setup_common_dev() and
nbl_dev_setup_ctrl_dev() plus their teardown counterparts, and wires
nbl_dev_init() / nbl_dev_remove() into nbl_core_init() / nbl_core_remove().
Common device setup creates the mailbox channel queue and the mailbox clean
work, while control device setup runs the chip-wide init_module() callback.

A few questions below about the control-PF paths and about some commit
message and comment text that does not seem to match the code.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..35410c6f1fb9c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,259 @@

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
> +	/*
> +	 * common->hw_bus is the control PF's real bus number, captured in
> +	 * nbl_res_ctrl_dev_sriov_info_init() during nbl_res_init_leonis().
> +	 * nbl_core_init() runs resource init before nbl_dev_init(), so the
> +	 * value is always initialized when this control-PF-only path runs;
> +	 * nbl_res_intr_cfg_msix_map() consumes it for cfg_msix_map() the
> +	 * same way.
> +	 */
> +	chan_ops->cfg_chan_qinfo_map_table(priv, common->hw_bus, common->devid);
> +}

[ ... ]

> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	int ret;
> +
> +	if (!common_dev)
> +		return;
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	ret = nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret)
> +		dev_warn(&adapter->pdev->dev, "mailbox queue teardown failed, inflight DMA may exist: %d\n",
> +			 ret);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +}

[Severity: Medium]
Should the teardown failure be propagated instead of only warned about?

nbl_dev_remove_common_dev() returns void, so nbl_dev_remove() continues to
nbl_dev_remove_ctrl_dev() -> deinit_module() even after this dev_warn()
fires, and devres then releases the mailbox rings once remove() returns.

nbl_chan_teardown_queue() returns -ETIMEDOUT when the inflight TX drain
times out, and on that same branch it can also fail the trylock and skip
the hardware stop entirely:

nbl_channel.c:nbl_chan_teardown_queue() {
	...
	} else if (mutex_trylock(&chan_info->txq_lock)) {
		nbl_chan_stop_queue(chan_mgt);
		mutex_unlock(&chan_info->txq_lock);
	} else {
		dev_crit(... "zombie channel: ... HW stop skipped ...");
	...
}

nbl_chan_stop_queue() is what disables both the mailbox RX and TX queues,
so on that path the RX queue stays enabled pointing at the
dmam_alloc_coherent() rings that devres frees right after remove().

That also seems to conflict with the precondition documented in the
hardware layer:

nbl_hw_leonis.c:nbl_hw_deinit_module() {
 * Caller must ensure no new DMA is initiated after this point.
 * The mailbox channel is stopped by nbl_chan_teardown_queue()
 * before this function is called, so no in-flight mailbox DMA
 * remains.
}

Can the device write into the freed coherent mailbox buffers in that case?

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
> +	return 0;
> +}

[Severity: Medium]
The commit message lists, under "Control device setup
(nbl_dev_setup_ctrl_dev, control PF only)":

    - Program mailbox QINFO routing map (bus/devid for each PF)

and the teardown comment below says "The qinfo map programmed in
setup_ctrl_dev".  Does nbl_dev_setup_ctrl_dev() program the QINFO map?

The body above only calls disp_ops->init_module(); the QINFO map is
programmed from nbl_dev_init() via nbl_dev_setup_chan_qinfo(), which runs
before nbl_dev_setup_common_dev() creates the mailbox queue and before
init_module():

	if (common->has_ctrl)
		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

That call performs chip-wide register writes for every active PF:

nbl_channel.c:nbl_chan_cfg_qinfo_map_table() {
	for (func_id = 0; func_id < NBL_MAX_PF; func_id++)
		if (!(pf_mask & (1 << func_id)))
			hw_ops->cfg_mailbox_qinfo(p, func_id, bus, devid, func_id);
}

So the documented "Init order: create mailbox(common_dev) → ctrl dev init"
does not seem to describe the order in which hardware writes actually
happen, and this QINFO programming is also outside the setup_ctrl_dev_fail
unwind path.  Could the changelog and the comment be adjusted to match, or
the call moved into nbl_dev_setup_ctrl_dev()?

[Severity: Low]
This isn't a bug, but there is nothing between the call and the return, so
the local ret and the error check are redundant here:

	return disp_ops->init_module(dev_mgt->disp_ops_tbl->priv);

> +
> +/*
> + * Tear down control device: deinit_module sets driver_status=false
> + * to notify firmware to clean all per-PF hardware state (including
> + * qinfo registers).  The qinfo map programmed in setup_ctrl_dev is
> + * not explicitly cleared; firmware handles it on driver_status change.
> + *
> + * Teardown ordering guarantee: every non-management PF creates a
> + * consumer->control PF device link in its probe path, so the driver
> + * core always unbinds all siblings before allowing the control PF to
> + * be detached (sysfs unbind, driver unregister and hot-unplug alike).
> + *
> + * Safety net: this registry check additionally blocks the chip-global
> + * deinit if a sibling PF is somehow still bound on the same chip
> + * (defense in depth for paths that bypass device-link ordering).
> + * Skipping deinit leaves firmware/qinfo routing alive for the siblings;
> + * their control plane stays functional at the cost of deferring the
> + * global firmware cleanup until the next control PF init_module().
> + * Direct control-PF FLR (which never runs driver teardown) cannot be
> + * guarded here.
> + */
> +static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +
> +	disp_ops->deinit_module(dev_mgt->disp_ops_tbl->priv);
> +}

[Severity: High]
Where is the registry check that this comment and the commit message
describe?

The commit message says:

    A registry check is added as defense-in-depth, to skip global chip deinit
    if sibling PFs remain bound.

and the comment above says "this registry check additionally blocks the
chip-global deinit if a sibling PF is somehow still bound on the same chip".

The function body is a single unconditional deinit_module() call, and the
only condition below it is has_ctrl:

nbl_chip.c:nbl_res_chip_deinit_module() {
	if (!common->has_ctrl)
		return;
	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
}

The only chip-dependency code in the driver is nbl_probe_chip_deps() in
nbl_main.c, and it just creates a device link:

	if (!device_link_add(&pdev->dev, &mgt->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {

There is no registry, sibling list or sibling-bound check anywhere for the
teardown path to consult.  Should the check be implemented, or should the
changelog and the comment be corrected so reviewers do not assume a guard
that is not there?

> +
> +static struct nbl_dev_mgt *nbl_dev_setup_dev_mgt(struct nbl_common_info *common)

[ ... ]

> +int nbl_dev_init(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	dev_mgt->disp_ops_tbl = disp_ops_tbl;
> +	dev_mgt->chan_ops_tbl = chan_ops_tbl;
> +	adapter->core.dev_mgt = dev_mgt;
> +	if (common->has_ctrl)
> +		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

[Severity: High]
What serializes these chip-global operations against sibling PFs that are
already bound or still probing?

This call rewrites the shared mailbox QINFO entry of every hardware-active
PF, clearing MSIX_IDX / MSIX_IDX_VALID in nbl_hw_cfg_mailbox_qinfo(), with
no check for siblings that are already live.  On the other side,
nbl_dev_remove_ctrl_dev() -> deinit_module() sets driver_status=false, which
per the comments makes firmware asynchronously wipe per-PF state including
sibling QINFO registers.

The commit message states:

    The device link guarantees the kernel unbinds all non-control PFs before
    the control PF can be removed, preventing broken cross-PF mailbox RPC.

Does the managed link created inside the consumer's own probe give that
guarantee?  In drivers/base/core.c, device_link_init_status() assigns
DL_STATE_DORMANT when the supplier has no driver, device_links_driver_bound()
later promotes DORMANT only to DL_STATE_AVAILABLE, and
device_links_unbind_consumers() force-unbinds only ACTIVE links:

drivers/base/core.c:device_links_unbind_consumers() {
		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND);
		if (status == DL_STATE_ACTIVE) { /* only then force-unbind consumer */
}

So a sequence like "unbind func0; bind func1; bind func0; unbind func0"
leaves func1 bound and live while the control PF runs deinit_module().

In the opposite direction, device_link_add() returns a valid link with
status DL_STATE_SUPPLIER_UNBIND when the supplier is already unbinding, and
nbl_probe_chip_deps() only checks for NULL, so a sibling can keep probing
into nbl_dev_init() and enable its mailbox while func0 is inside
nbl_dev_remove().  PCI does not set need_parent_lock, so no common device
lock serializes the two.  Can this leave a sibling PF with its mailbox
routing torn down underneath it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
