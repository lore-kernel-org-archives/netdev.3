Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754443DEB8;
	Sun, 11 Oct 2026 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715890; cv=none; b=W9b66rJ+Ez0KgqdPtmqTNMKHe+vBkJ46KCvG4+RAzuHIUp6M2t4qMiWLtbP2lRzQ+HTKMbGO75sX3dRt0q7rWBZcXy9qRoOQeb29w2uY7Lt5NOAyD5uBvk413wLiMhIn3o6+wWl67Px6jYE/GCWcN8Z6tTsj62+4IKgM/M+OsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715890; c=relaxed/simple;
	bh=PsAfYd49OHMeODQ3Mq0wT33FkMnFYX6UM6ikRWGaNWc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhBFK/IX15S1/obhPd+G8Oa4B71IWAHgsYsL9BA+V2rZ8t3fzDBTS5jKWnbwIaQd1AyJP5uhRzSOoMbh7aBOJoFep1LBuDjViSfOvcVsLBAnbL1IqkxOy0PhSEMkOttobgDYJZn0t+y1LJeJw6TKrTxbCSDdlaLqDh2iyT4LiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry7xQ0Wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry7xQ0Wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DFB1F0089B;
	Sun, 11 Oct 2026 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715887;
	bh=0ZiPzLLsunpFjxud+nHoxtXRJRmla9xr/zDYtqM4KTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ry7xQ0WpNpx+d/XSf42nU2gaGasqQz/ToTZZuQaocnBX8DEHs7RYqa8ZhkO1n+W3f
	 qFSCYtkD1xrxMEfPkJAQ4TCKFm7wkGn/LAAILsBwGUJ09yiH0vEwlMm5Vvrz9CczKo
	 Kjj/HGkMZ1A5cbk3/VTU53mR9jG8e544ieYIdDMIafPrx2qasU85jFQr8f0CE+Kaes
	 gl7b7A93k1I3OtQDrpt9QFE8Xy6x9GYxhJfVzO2Y9mNDFzjDhdOEcKzoPZPKNT49As
	 e3fMTZFIQ82Tr51+ARF196KBEMMSZbjJhMFVfTU746IQdtR7pl6aiQXG22CTMsuaVR
	 3NsGtU7YckJjw==
Subject: Re: [PATCH v31 net-next 7/8] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:26 +0000
Message-ID: <179171588699.434549.5822865886335028632@kernel.org>
In-Reply-To: <20261010095939.2230-8-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-8-illusion.wang@nebula-matrix.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On the control PF, nbl_dev_init() runs its steps in an order
  that conflicts with the stale-status recovery in nbl_hw_init_module().
- [Low] On the control PF, nbl_dev_init() writes
  NBL_MAILBOX_QINFO_MAP_REG_ARR entries for every enabled PF (via…
- [Low] The error-path comment in nbl_dev_setup_common_dev() says no
  unwinding is needed after a failed setup_queue() because the partially…
- [Low] nbl_dev_remove_common_dev() calls
  nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL) right…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This adds nbl_dev.c with nbl_dev_init() and nbl_dev_remove().  On every
PF they set up the mailbox channel queue and its clean work.  On the
control PF they also program the mailbox QINFO routing and run
init_module.  The new entry points are called from nbl_core_init() and
nbl_core_remove().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..390bc2b177e21
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ret) {
> +		/*
> +		 * Nothing to unwind: chan_info->active is only set on a
> +		 * successful setup_queue(), so a failed one left no
> +		 * sender, no registered work item and no mailbox
> +		 * traffic.  Calling teardown_queue() here would only
> +		 * take its "channel not active" early exit and emit a
> +		 * misleading duplicate-teardown warning.  The partially
> +		 * allocated DMA rings are intentionally kept until devres
> +		 * releases them at detach (chan_info->dma_allocated
> +		 * blocks a re-setup).
> +		 */
> +		return ret;
> +	}

[Severity: Low]
Is the "chan_info->dma_allocated blocks a re-setup" part of this comment
accurate?  nbl_chan_setup_queue() clears the flag again when
nbl_chan_init_queue() fails:

nbl_channel/nbl_channel.c:nbl_chan_setup_queue() {
    ...
	chan_info->dma_allocated = true;
	err = nbl_chan_init_queue(common, chan_info);
	if (err) {
		chan_info->dma_allocated = false;
		return err;
	}
    ...
}

The TX and RX init helpers use dmam_alloc_coherent() and devm_kcalloc().
They free nothing on a partial failure, for example when the TX rings
are allocated and the RX descriptor allocation then fails.

After such a failure, active and dma_allocated are both false.  A second
setup_queue() would get past both checks and allocate a second set of
coherent rings, and the first set would be orphaned until detach.

The channel code has its own comment just above that reset ("a retry
must be rejected instead of allocating a second set and orphaning the
first one"), and the reset contradicts it as well.

Nothing retries today, so for now the comment just doesn't match the
code.

> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	if (!common_dev)
> +		return;
> +	cancel_work_sync(&common_dev->clean_mbx_task);

[ ... ]

> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +}

[Severity: Low]
Does the nbl_dev_register_chan_task(..., NULL) call here have any
effect?

common_dev is only set after setup_queue() succeeds, so the channel is
always active by the time this runs.  nbl_chan_teardown_queue() then
sets shutdn and clears clean_task under state_lock.  After that,
nbl_chan_register_chan_task() ignores the write:

nbl_channel/nbl_channel.c:nbl_chan_register_chan_task() {
    ...
	mutex_lock(&chan_info->state_lock);
	if (!READ_ONCE(chan_info->shutdn))
		WRITE_ONCE(chan_info->clean_task, task);
	mutex_unlock(&chan_info->state_lock);
}

teardown_queue() does the real unregister and drain: it clears
clean_task and calls cancel_work_sync() on it.  The cancel_work_sync()
above runs before teardown, while the sender poll paths can still
re-queue the work.

This has no functional effect today.  The problem is that this sequence
reads as if the dev layer does the unregister and drain, when the
channel layer actually does it.  Could the NULL registration be dropped,
or a comment added saying which layer is responsible?

> +int nbl_dev_init(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	adapter->core.dev_mgt = dev_mgt;
> +	if (common->has_ctrl)
> +		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
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

[Severity: High]
Can this ordering make firmware wipe the mailbox state that this probe
has just programmed?

On the control PF the sequence is:

nbl_dev_init()
    nbl_dev_setup_chan_qinfo()      /* QINFO routing for all PFs */
    nbl_dev_setup_common_dev()
        nbl_chan_setup_queue()      /* TX/RX queue config, active=true */
    nbl_dev_setup_ctrl_dev()
        init_module -> nbl_hw_init_module()

If the active bit in NBL_DRIVER_STATUS_REG is still set,
nbl_hw_init_module() forces it from 1 to 0:

nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c:nbl_hw_init_module() {
    ...
	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);
	if (status & BIT(NBL_DRIVER_STATUS_BIT)) {
		dev_warn(hw_mgt->common->dev,
			 "driver_status already set at init, cleanup forced\n");
		nbl_hw_set_driver_status(hw_mgt, false);
		nbl_flush_writes(hw_mgt);
		usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US,
			     NBL_FW_CLEANUP_SYNC_MAX_US);
    ...
}

The bit can still be set after kexec or kdump, because nbl_pci_driver
has no .shutdown callback.  It can also be set after an unload that
never reached deinit_module().

The commit message says firmware asynchronously reclaims "mailbox QINFO
routing, qinfo registers and the like" when the bit goes from 1 to 0.
Here that happens after the new routing and the live queue registers are
in place.  Nothing later in init, or in the start path, programs them
again.

Wouldn't that leave the control PF mailbox dead, so that sibling-PF RPCs
in nbl_dev_start() time out?  Firmware could also reclaim the routing
while a mailbox transfer is in flight, which is the hazard the teardown
ordering is meant to avoid.

Should the stale-status cleanup run before nbl_dev_setup_chan_qinfo()
and setup_queue()?

> +
> +	return 0;
> +setup_ctrl_dev_fail:
> +	nbl_dev_remove_common_dev(adapter);
> +setup_err:
> +	return ret;
> +}

[Severity: Low]
Do these error paths leave the NBL_MAILBOX_QINFO_MAP_REG_ARR entries
written by nbl_dev_setup_chan_qinfo() in hardware?

The comment above nbl_dev_remove_ctrl_dev() says the map "is not
explicitly cleared; firmware handles it on driver_status change".  But
neither label clears the entries or calls deinit_module().

This applies in two cases:

- nbl_dev_setup_common_dev() fails.
- nbl_hw_init_module() fails, either in the eth_speed/eth_num checks or
  in nbl_dp_init().  Both return before
  nbl_hw_set_driver_status(true).

In both cases driver_status never goes from 1 to 0, so the firmware
reclaim never runs.  The routing entries stay until a later successful
probe overwrites them or the chip is reset.

The practical impact looks small, since sibling PFs can't bind without
the control PF.  The hardware state still no longer matches what the
driver thinks it is.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
