Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6E3EFD26;
	Fri, 11 Sep 2026 03:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098117; cv=none; b=UlwjDZfnXrqFe6Rsz+piWIKrwm3e3eKE7Ra3+p9s6hIokfLGIZXQ97T7FHoUgwhMB5I/e5OzB9S2AyUYjmDlGtSYKnSJc0tY5I+pJk4RQNXFL7ni3pA10CtiGgUlyu2TMVDIKM9c0WFNme2xgv3GFQrIo0uYCeT4J3QTmTOcRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098117; c=relaxed/simple;
	bh=W9HHPIhLr827ioGyiOJ1l2fXcts7Zs8rMgo3U+N+1lg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+t5oJKZcWRkv230KMJE7qGm9DDZW//9B897WiJbYtHdQEdJPoj6djz65INKVlItNLrC2kcocWwJHpmZiawAqL2rnpeaoK56sqsZb9zaE5cNGYaKiG/H2JQ/axtCLXafCouWYKX6dE6nZRC3ZtpYwZEMzsG7wpY/5NP3K17xkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bma56F7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bma56F7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371101F00893;
	Fri, 11 Sep 2026 03:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098115;
	bh=VIl26yVmNz0Oy3fGC5s9m+cizzxv3+orvYHEhoX815s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bma56F7Er9DMLOGVylzGRAD/LAQwgZkwSd+XIp9/u2EPlSKChTmP9ESLgevF+pniO
	 TKVEa8S9esjlE1UEprQO8aVrbuvrmU34lm4CgsmRuydgwXobN/43poGME3EeGx1/5p
	 ivk/WLnZcSaD1T1980PD0FrpXzHTuP5tuNhsCDwg8xnw9ox/IOPOGLtP1AJSFeP1wI
	 io5Nnn3AaFSSELclamH/vN1pjKReuP0EKUI2pMMZBJiFEZYpQKMEdYwYWQSnQbEUzb
	 BStlRQWf8LcUzIgIOfXmgq1AJtUhJvI1GuCT9Y6Qxg51oySIpA3P4z8ysi38PlhAyp
	 ywK2q2lZGAMbw==
Subject: Re: [PATCH v27 net-next 09/10] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:53 +0000
Message-ID: <178909811379.219967.7808911055302339629@kernel.org>
In-Reply-To: <20260907123848.30256-10-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-10-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] nbl_dev_remove() (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_core/nbl_dev.c) calls nbl_dev_remove_ctrl_dev() ->…
- [Medium] nbl_dev_remove_ctrl_dev() -> deinit_module() clears
  driver_status, which per nbl_hw_deinit_module()'s own documentation…
- [Low] If disp_ops->init_module() fails, nbl_dev_setup_ctrl_dev()
  returns the error and nbl_dev_init() unwinds only the common dev (goto…
- [Low] The int return of nbl_dev_remove_chan_queue() - which propagates
  nbl_chan_teardown_queue()'s -ETIMEDOUT, documented as 'callers must…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This adds the nbl_dev core layer with nbl_dev_setup_common_dev() and
nbl_dev_setup_ctrl_dev() plus their teardown counterparts, and wires
nbl_dev_init() / nbl_dev_remove() into nbl_core_init() / nbl_core_remove().
A few questions about the teardown ordering and the error paths below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..7813ff31a3cfc
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,233 @@

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

> +static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
> +	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
> +	int ret = 0;
> +
> +	if (chan_ops->check_queue_exist(priv, chan_type))
> +		ret = chan_ops->teardown_queue(priv, chan_type);
> +
> +	return ret;
> +}

[ ... ]

> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	if (!common_dev)
> +		return;
> +	cancel_work_sync(&common_dev->clean_mbx_task);
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);

[Severity: Low]
nbl_dev_remove_chan_queue() returns int, and it propagates the -ETIMEDOUT
that nbl_chan_teardown_queue() reports when the inflight drain does not
complete:

	ret = wait_event_timeout(chan_info->inflight_wait,
				 atomic_read(&chan_info->inflight_tx_cnt) == 0,
				 msecs_to_jiffies(5000));
	if (!ret) { ... ret = -ETIMEDOUT; }

Both new callers, here and the err_cleanup path in
nbl_dev_setup_common_dev(), discard that status, and nbl_dev_remove() is
void, so nbl_core_remove() goes on to destroy the workqueue and the message
handler table while devres later frees the dmam_alloc_coherent() mailbox
rings.

As far as I can tell this is not reachable in the current tree: every
nbl_chan_send_msg() caller in the series runs either in the probe/remove
thread itself or inside clean_mbx_task, and cancel_work_sync() runs just
above, so inflight_tx_cnt is always 0 here today. Is the intent to keep the
status unchecked once asynchronous senders (netdev/ethtool paths) are added,
or should the timeout at least be logged?

> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +}
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

[Severity: Low]
When init_module() fails there is no hardware rollback here, and
nbl_dev_init() only unwinds the common dev (goto setup_ctrl_dev_fail ->
nbl_dev_remove_common_dev()), so deinit_module() is never called.

nbl_hw_init_module() can fail partway through:

	ret = nbl_dp_init(hw_mgt, eth_speed, eth_num);
	if (ret)
		return ret;
	nbl_intf_init(hw_mgt);
	nbl_hw_set_driver_status(hw_mgt, true);

and nbl_dp_init() programs nbl_dped_init()/nbl_uped_init() before the first
call that can return an error (nbl_shaping_init(), and later
nbl_ustore_init()).

Since nbl_hw_set_driver_status(hw_mgt, true) is only reached at the end,
the driver_status true->false transition that the patch relies on for
cleanup can never fire for this partially programmed chip-wide datapath
state. Should this path either roll back explicitly or call deinit_module()?

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
> + */
> +static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +
> +	disp_ops->deinit_module(dev_mgt->disp_ops_tbl->priv);
> +}

[Severity: Medium]
What happens to sibling PFs that are still bound when only the control PF
is unbound?

nbl_dev_setup_chan_qinfo() -> nbl_chan_cfg_qinfo_map_table() programs the
mailbox routing for every hardware-active func_id, i.e. chip-global state
shared with the other PF driver instances.

Per the comment above, deinit_module() then makes firmware clean all per-PF
hardware state including those qinfo registers, but only this adapter's
mailbox queue is stopped afterwards by nbl_dev_remove_common_dev().

The resource layer already acknowledges that remote PFs can still be bound
at this point:

	/*
	 * Tear down all MSI-X maps before devres releases the coherent
	 * tables.	This is critical on the control PF, which may hold
	 * maps for remote PFs that are still bound.
	 */

There is no refcount or cross-instance exclusion here, so after
"echo <control PF BDF> > /sys/bus/pci/drivers/nbl/unbind" the sibling
instances keep their mailbox rings armed and their software state marked
active while their routing entries are gone; their next dispatch RPC
(get_vsi_id, cfg/destroy_msix_map, set_mailbox_irq) can then only fail by
ACK timeout. Is that intentional, or should control-PF teardown be
serialized against still-bound siblings?

[ ... ]

> +int nbl_dev_init(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	ret = nbl_dev_setup_common_dev(adapter);
> +	if (ret)
> +		goto setup_err;
> +
> +	if (common->has_ctrl) {
> +		ret = nbl_dev_setup_ctrl_dev(adapter);
> +		if (ret)
> +			goto setup_ctrl_dev_fail;
> +	}
> +
> +	return 0;
> +setup_ctrl_dev_fail:
> +	nbl_dev_remove_common_dev(adapter);
> +setup_err:
> +	return ret;
> +}
> +
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

[Severity: High]
Is this ordering the inverse of what the hardware layer asks for?

nbl_hw_deinit_module() documents the precondition:

	/* Caller must ensure no new DMA is initiated after this point.
	 * The mailbox channel is stopped by nbl_chan_teardown_queue()
	 * before this function is called, so no in-flight mailbox DMA
	 * remains. */
	nbl_hw_set_driver_status(hw_mgt, false);

But nbl_chan_teardown_queue() is the only place the mailbox hardware queues
are actually stopped and senders drained:

	WRITE_ONCE(chan_info->shutdn, true);
	...
	/* After all TX drained, stop hardware queue */
	nbl_chan_stop_queue(chan_mgt);

and it runs after deinit_module() in this path:

nbl_dev_remove()
  nbl_dev_remove_ctrl_dev()
    disp_ops->deinit_module()      /* driver_status = false */
  nbl_dev_remove_common_dev()
    nbl_dev_remove_chan_queue()
      nbl_chan_teardown_queue()    /* shutdn, drain, stop queue */

At the end of the series the remove path is nbl_remove() -> nbl_core_stop()
-> nbl_core_remove() -> nbl_dev_remove(), and nbl_dev_stop() only frees the
IRQ and the MSI-X map, so the mailbox rings are still enabled with posted RX
descriptors when driver_status is cleared. Can firmware then wipe the
routing/queue state while the chip can still DMA into those rings, for
example for a message another PF sends to the control PF?

The commit message also states the opposite of the code:

    No completion handshake exists in the
    current hardware revision; the caller must ensure no new DMA is
    initiated after deinit (the mailbox channel is stopped first).

The mailbox channel is stopped last here, not first. Should the common dev
teardown run before deinit_module(), or should nbl_dev_remove_ctrl_dev()
stop the channel itself before calling deinit_module()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
