Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4CE30C160;
	Fri,  2 Oct 2026 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912115; cv=none; b=UDXNYqzLGTq4GgX68PlQdiJJ2xiIuZEWy5ys2YNVCwz7ARoqN4STUeVDmicywnmSzWXqKdSYmZBsSJHvle7/6rfjscZT35hEpQl4O9A5ALvjm5iUpHeRoAqc9DNzGDrelSInZvTADY0XTGv9gYV0kuNc0Yn1YrxDiX0pnS7zJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912115; c=relaxed/simple;
	bh=nbXx9b5B0i2z9NYWBIHZZl6u7UXcSmxPPfB+Kt47x40=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JqbcdGQo/nl9o/LXxbT5rXx/negKOav6d7nZNNaJhZ6mADktc9L0HrsWB2ySUy1ETXsFiAt23DpWygFc128ke73T2Ed7R/y5OjO5eD4s/EPSRBgaKrFKzCd+2wU17gecHhBdurOnMuxADSmwoXLPtPefmvcen+PITFvzXU+DZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSbdrbGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSbdrbGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6561F000FF;
	Fri,  2 Oct 2026 03:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912113;
	bh=8CJrEWWmuu3mgIibLReSPkdw2Rf8j663qYr8i0zTI18=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BSbdrbGCXBlfgRbwfNvb0SveKg79Bugs7H+CA3Wpwi3YRRZHCH0r4R+2e9zke0oUh
	 057TXjCceP1a7HxNB2V5LzV2999dh+naEJ/3o2OoVdAh8bWFb1F2G3yaamcAmhIxFd
	 EEWtxTZ65n9NDUbATaIFBsRTcgerIA7GcH74hBwWHW505BydDBi7nMzUQC5HWmHvyg
	 2WbSgr2DQsKPqvUw5gihhurwcUJPZOxFP3RIcuRd+uy2suW/W4J69YRdKXkPlrFfEA
	 xRds7lYQvALKfcyT/YCOzwAICFu/3cw42co6OrELXdMvYtLNhPvJQD6IBFu8O7UMwE
	 xIaw7yHdfA1yg==
Subject: Re: [PATCH v30 net-next 1/8] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:12 +0000
Message-ID: <179091211293.434549.4895858664996273015@kernel.org>
In-Reply-To: <20260928123237.88994-2-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-2-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_chan_alloc_all_tx_bufs() and nbl_chan_alloc_all_rx_bufs()
  make a separate dmam_alloc_coherent(dev, 4096, ...) call for each of…
- [Low] Most of the channel layer (setup_queue, teardown_queue, send_msg,
  cfg_chan_qinfo_map_table, clean_queue_subtask, register_chan_task,…
- [Low] Some specific claims in the commit message don't match the code.
- [Low] The get_host_pf_mask kernel-doc says unsupported masks are
  'rejected with -EINVAL', and nbl_chan_cfg_qinfo_map_table() defers…
- [Low] The lock comments in struct nbl_chan_info are wrong.
- [Low] send_msg, clean_queue and set_queue_state do not check
  chan_info->active.
- [Low] If setup fails partway, its devres/dmam allocations are orphaned
  when setup is retried.

--

net/nebula-matrix: add channel layer

This adds a mailbox-based channel layer to the nbl driver. It carries
control messages between PF0 and the other PFs. The patch adds the
channel ops table, TX/RX ring handling with ACK tracking, a workqueue for
RX cleanup, and the BAR0/BAR2 hw_ops that program the mailbox queues.

> - TX slot concurrency control, returning -EAGAIN when slots are full to
>   avoid congestion and resource exhaustion. Supports 16B inline small
>   payload and 4KB max DMA-based large payload transmission.

[ ... ]

> - Isolated hw_ops layer decouples low-level hardware implementation from
>   upper channel logic. Fine-grained register locking optimizes BAR0/BAR2
>   access for stability under high stress.

[Severity: Low]
Do these claims match the code?

nbl_chan_get_msg_id() returns -EAGAIN when the ACK wait slots run out.
When the descriptor ring is full, though, nbl_chan_update_txqueue()
returns -EBUSY:

	if (nbl_chan_txq_full(txq, chan_info->num_txq_entries))
		return -EBUSY;
	if (param->arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc))
		return -EINVAL;

That same check caps the payload at 4096 - 64 = 4032 bytes, not 4KB.
nbl_chan_send_ack() allows 12 bytes less than that.

On locking, the patch adds only one reg_lock spinlock, and only the BAR0
helpers take it (nbl_hw_rd_regs_lock() and nbl_hw_cfg_mailbox_qinfo()).
nbl_hw_read_mbx_regs(), nbl_hw_write_mbx_regs() and the doorbell write in
nbl_hw_update_mailbox_queue_tail_ptr() go through BAR2 without any
register lock.

Could the commit message be updated to match?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 000000000000..d2c8182c72b6
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1467 @@

[ ... ]

> +static int nbl_chan_alloc_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
> +				      struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = chan_mgt->common->dev;
> +	struct nbl_chan_buf *buf;
> +	u16 i;
> +
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		buf = &txq->buf[i];
> +		buf->va = dmam_alloc_coherent(dev, chan_info->txq_buf_size,
> +					      &buf->pa, GFP_KERNEL);

[Severity: Medium]
Is one coherent allocation per ring entry intended here?
nbl_chan_alloc_all_rx_bufs() does the same, so each PF makes 512 separate
dmam_alloc_coherent(dev, 4096, ...) calls.

Coherent allocations are rounded up to whole pages. On 16K or 64K page
kernels (arm64, ppc64le), one PF's mailbox uses 8 MiB or 32 MiB of
coherent memory, not the ~2 MiB the comment in nbl_chan_setup_queue()
assumes. The driver can build for these, since Kconfig only requires
64BIT and !CPU_BIG_ENDIAN. A 4-PF card with 64K pages would use 128 MiB.
Each call also adds its own devres node and IOMMU mapping.

Could this be one contiguous allocation split into 4K slots, or a
dma_pool?

[ ... ]

> +	/*
> +	 * DMA resources are allocated once and released only by devres
> +	 * at device detach.  A teardown does not free them, so a second
> +	 * setup would orphan ~2 MiB of coherent DMA per channel.
> +	 */
> +	if (chan_info->dma_allocated) {
> +		dev_warn(common->dev,
> +			 "channel DMA already allocated, re-setup not supported\n");
> +		return -EBUSY;
> +	}
> +	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
> +				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
> +				  NBL_CHAN_BUF_LEN);
> +	err = nbl_chan_init_queue(common, chan_info);
> +	if (err)
> +		return err;
> +	err = nbl_chan_alloc_all_bufs(chan_mgt, chan_info);
> +	if (err)
> +		return err;
> +	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
> +	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
> +	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
> +				 rxq->tail_ptr, NBL_MB_RX_QID);
> +	WRITE_ONCE(chan_info->active, true);
> +	chan_info->dma_allocated = true;
> +	return 0;
> +}

[Severity: Low]
What happens if nbl_chan_setup_queue() fails partway, for example in
nbl_chan_alloc_all_rx_bufs()? At that point active and dma_allocated are
both still false. A second call would get past both checks and allocate
everything again. The first set of dmam buffers would stay allocated
until detach.

In the rest of the series, setup_queue runs once per probe from
nbl_dev_setup_common_dev(), and a failure fails the probe. So no retry
path exists today.

Should dma_allocated be set before the first allocation, so the guard
does what its comment says?

[ ... ]

> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{

[ ... ]

> +	mutex_lock(&chan_info->state_lock);
> +	if (READ_ONCE(chan_info->shutdn)) {
> +		mutex_unlock(&chan_info->state_lock);
> +		return -ESHUTDOWN;
> +	}
> +	atomic_inc(&chan_info->inflight_tx_cnt);
> +	mutex_unlock(&chan_info->state_lock);

[Severity: Low]
Can nbl_chan_send_msg() be called on a channel that hasn't gone through
setup_queue? Nothing here checks chan_info->active.

Before setup, num_txq_entries is 0, so this path divides by zero:

nbl_chan_update_txqueue()->nbl_chan_txq_full()
    NBL_NEXT_ID(next_to_use, num_entries - 1)

nbl_chan_clean_queue() has a similar problem: before setup it reads
through rxq->desc.rx_desc, which is still NULL. nbl_chan_set_queue_state()
walks wait[], which can be NULL after a partial setup failure.

In the rest of the series, every caller runs after
nbl_dev_setup_common_dev(), so this doesn't look reachable today. Would
it be worth checking active in these entry points anyway?

[ ... ]

> +static struct nbl_channel_ops chan_ops = {
> +	.send_msg			= nbl_chan_send_msg,
> +	.send_ack			= nbl_chan_send_ack,
> +	.register_msg			= nbl_chan_register_msg,
> +	.cfg_chan_qinfo_map_table	= nbl_chan_cfg_qinfo_map_table,
> +	.check_queue_exist		= nbl_chan_check_queue_exist,
> +	.setup_queue			= nbl_chan_setup_queue,
> +	.teardown_queue			= nbl_chan_teardown_queue,
> +	.clean_queue_subtask		= nbl_chan_clean_queue_subtask,
> +	.register_chan_task		= nbl_chan_register_chan_task,
> +	.set_queue_state		= nbl_chan_set_queue_state,
> +};

[Severity: Low]
This isn't a bug on its own, but most of these ops have no caller in
this patch: setup_queue, teardown_queue, send_msg,
cfg_chan_qinfo_map_table, clean_queue_subtask, register_chan_task and
set_queue_state. nbl_core_init() only calls nbl_chan_init_common().

The commit message describes probe-time DMA allocation and IRQ/polling
RX as if they already work here. Later patches in the series add the
callers in nbl_dev.c and nbl_dispatch.c.

Could the commit message say that queue setup and the RX paths are
wired up in later patches?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> new file mode 100644
> index 000000000000..21cbb21946cf
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> @@ -0,0 +1,181 @@

[ ... ]

> +struct nbl_chan_info {

[ ... ]

> +	/* Guards channel state bitmap and shutdn flag */
> +	struct mutex state_lock;
> +	/* Guards pending requests and pending work list operations */
> +	struct mutex pending_lock;

[Severity: Low]
Are these lock comments accurate? The state bitmap is never accessed
under state_lock. nbl_chan_set_queue_state() changes it without the lock:

	if (set)
		set_bit(state, chan_info->state);
	else
		clear_bit(state, chan_info->state);

nbl_chan_send_msg() also tests NBL_CHAN_IRQ_RDY without the lock. The
code relies on atomic bitops instead.

There is also no pending work list. pending_lock seems to guard the
wait[] slot array.

Could the comments be updated to say what each lock actually protects?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index ecbf440e4366..d87bf9d41a24 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> @@ -10,6 +10,41 @@

[ ... ]

> +	/**
> +	 * get_host_pf_mask - Fetch host PF mask from firmware k_pf_mask reg
> +	 * @hw_mgt: hardware management context
> +	 * @pf_mask: output pointer for PF mask value
> +	 *
> +	 * k_pf_mask register rule:
> +	 *   bit N == 0 -> PF#N enabled; bit N == 1 -> PF#N masked out.
> +	 *   bit0 is PF0's mask bit (not reserved); PF0 can be masked but
> +	 *   the driver requires at least PF0 enabled.
> +	 *   Only 1/2/4 PFs are supported:
> +	 *     1 PF  (PF0):     mask = 0xfe
> +	 *     2 PFs (PF0,PF1): mask = 0xfc
> +	 *     4 PFs (PF0~PF3): mask = 0xf0
> +	 *   All-zero mask (0x00) means all 8 PFs enabled, which is
> +	 *   unsupported by the driver and rejected with -EINVAL.
> +	 */
> +	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);

[Severity: Low]
Where does the -EINVAL rejection described here happen? The comment in
nbl_chan_cfg_qinfo_map_table() also defers to a check this patch doesn't
contain:

	 * Non-contiguous or unsupported PF count
	 * will be rejected in resource initialization logic.

Later in the series, "net/nebula-matrix: add common resource
implementation" adds nbl_res_init_pf_num(), which does this check. It
runs before cfg_chan_qinfo_map_table is called, so at the end of the
series only these comments are affected.

Could the comments point to where the check lives, or be added in the
same patch as the check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
