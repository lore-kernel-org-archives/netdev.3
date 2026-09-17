Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32094A5C39;
	Thu, 17 Sep 2026 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684505; cv=none; b=BZBYSXMCFEl6srkYGrQ1hvoRFVaILBMU2FKOvk6lW6jaP/sZctiykNphAKpq4Jy9jFAu3cSGvJwfs9iol7sOyT9H/kt2rntAatnsd3774QDLK2tvdDwwD8KGqr899+tE6dRGsY21/Mt2+8eqCmmDB2yL8qsnqVLHIwGd6/FQMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684505; c=relaxed/simple;
	bh=R60oJ5sMn8RX7w7vrBx1lUtRWzaG/omclbKuwAusJx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izj4PviwYls5ZNox9hXspMfZBsRgXBaRqviDsWrYl22qNPp3T7BZjhAF1UmiXV33rU91v7/Ru8i4aU8nS0x3G+bTfZ69B18/5PZmdmq2YDP9MzECAdoCp1of3XJLmKlizYJpai7qJJ3rgnBdRZ25ZUw1o7V6ckeqCfgNtXA7/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz5hSICS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz5hSICS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF4E1F000FF;
	Thu, 17 Sep 2026 22:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684503;
	bh=syuoXHc1STCidK2at4f5/BtpItQ2zu3/4URIf6fmz6s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zz5hSICS5LdwlFcoF+a8mcX0mWWbJBmnhecfq+CSDDybW+ESXNRyELQjlYI9mJnxC
	 4TaMkUYL7ue4UGtZIwx8CMmX0Pl7sKv2xnAYvZbbbtTsYqdYE/OiJK6CQlVeS3o5ZG
	 LwVBDQwRA3o1tm3zD5Z5fmKmZpZRfbwWRTInl7t8bt1zEPDz48h/r94WM9B0Twtz/E
	 ieUeUTK4GvWBeS8b/m18O4goVCDpRxUL0tj6u35RcuhTLguJurMvyzkYQdc+CeHK4+
	 MwhT8fBugkRjUFxZCgX4iRoEddGgufWNBZUPg4XPcC9E5FLxsIctq8M4L9knOS5P1A
	 2vfNpLC9tebog==
Subject: Re: [PATCH v28 net-next 03/10] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:01 +0000
Message-ID: <178968450187.22033.978316452717622419@kernel.org>
In-Reply-To: <20260914123429.56596-4-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-4-illusion.wang@nebula-matrix.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 · Low: 7

- [High] nbl_chan_quiesce_and_reclaim_tx() calls hw_ops->flush_write()
  unconditionally from the generic channel layer.
- [High] In the interrupt-driven ACK wait of nbl_chan_send_msg(), when
  wait_event_timeout() returns 0 the code takes pending_lock and only…
- [Medium] The commit message justifies leaving the mailbox BAR2 register
  path unlocked with the invariant "the multi-dword QINFO config…
- [Medium] nbl_chan_teardown_queue() converts a failed inflight-TX drain
  into a return value (-ETIMEDOUT) but continues the teardown…
- [Medium] nbl_chan_teardown_queue() never acquires chan_info->txq_lock;
  it relies solely on atomic_read(&chan_info->inflight_tx_cnt) == 0 for…
- [Low] Reported concern: nbl_chan_setup_queue() re-allocates all
  ring/wait/buffer memory (dmam_alloc_coherent + devm_kcalloc, ~2 MiB of…
- [Low] Reported concern: at this commit none of the published channel
  ops (setup_queue, teardown_queue, send_msg, send_ack,…
- [Low] Reported concern: the exported ops do not validate
  chan_info->active, so a send before (or after a failed)…
- [Low] Reported concern: nbl_common_get_hash_node() returns the handler
  data pointer after dropping the per-bucket spinlock and…
- [Low] Reported concern: nbl_chan_remove_common() never asserts
  QUEUE_RST, so the mailbox TX/RX queues could stay enabled (QUEUE_EN)…
- [Low] Reported concern: chan_info->active/shutdn and the state bitmap
  are documented as guarded by state_lock, but…
- [Low] Reported concern: in nbl_chan_update_txqueue()'s external-buffer
  path (arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) the payload copy…

--

net/nebula-matrix: add channel layer

This adds the generic mailbox channel layer for the Nebula Matrix adapter:
message handler hash table, TX/RX descriptor ring setup and teardown, the
synchronous send-and-wait-for-ACK path, and a small hardware abstraction
layer for the mailbox registers.  A few questions below, mostly around the
TX timeout recovery path and the interrupt-driven ACK wait.

>From the changelog:

> - Mailbox BAR2 register access is intentionally left unlocked: single
> dword mailbox writes are atomic, and the multi-dword QINFO config
> sequence (config_mailbox_txq/rxq, stop_mailbox_txq/rxq) only runs
> during queue setup/teardown when chan_info->active is false, with no
> concurrent producers.

[Severity: Medium]
Does the code still match this description?

nbl_chan_quiesce_and_reclaim_tx() runs stop_mailbox_txq() followed by the
full 4-dword config_mailbox_txq() sequence (through nbl_chan_config_queue())
from the TX timeout path of nbl_chan_kick_tx_ring(), which is only reachable
from nbl_chan_send_msg() on a channel where active is true.

nbl_chan_teardown_queue() also calls nbl_chan_stop_queue() while active is
still true; it is cleared only afterwards.

Should the changelog also describe the new TX timeout recovery behaviour?
nbl_chan_quiesce_and_reclaim_tx() resets next_to_use, next_to_clean and
tail_ptr to 0 on a live queue and re-enables it, which is not mentioned
anywhere in the commit message.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..090a17b00dbbe
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1331 @@

[ ... ]

> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{

[ ... ]

> +	ret = wait_event_timeout(chan_info->inflight_wait,
> +				 atomic_read(&chan_info->inflight_tx_cnt) == 0,
> +				 msecs_to_jiffies(5000));
> +
> +	if (!ret) {
> +		dev_warn(chan_mgt->common->dev,
> +			 "teardown: inflight tx drain timeout\n");
> +		ret = -ETIMEDOUT;
> +	} else {
> +		ret = 0;
> +	}
> +
> +	/* After all TX drained, stop hardware queue */
> +	nbl_chan_stop_queue(chan_mgt);
> +
> +	/* All send paths drained, safely cancel cleanup work */
> +	if (task)
> +		cancel_work_sync(task);
> +	WRITE_ONCE(chan_info->active, false);
> +	return ret;
> +}

[Severity: Medium]
When the drain times out, teardown continues anyway: it stops the hardware,
cancels the cleanup work and clears active even though inflight_tx_cnt is
still non-zero.

The comment above this wait says "callers must not access queue resources
while an inflight sender may still be active", but is there anything that
enforces it?  Later in the series the only caller,
nbl_dev_remove_chan_queue() from nbl_dev_remove_common_dev(), discards the
return value and the remove path proceeds to detach, where devres releases
the dmam_alloc_coherent() descriptor rings and buffers and the
devm_kcalloc() wait array.

A surviving sender is still polling that memory:

nbl_chan_kick_tx_ring()
	if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
	    BIT(NBL_CHAN_TX_DESC_USED))

and nbl_chan_send_msg() still reads wait_head->acked / ack_data_len.  Can
this end up as a use-after-free of the coherent ring and the wait array,
with the device still writing into freed pages?

[Severity: Medium]
A second question about the same path: teardown never takes
chan_info->txq_lock, it relies only on inflight_tx_cnt reaching zero.  After
the drain timeout, can this interleave?

CPU0, in nbl_chan_send_msg() holding txq_lock:
	nbl_chan_kick_tx_ring()
	  /* 100 polling iterations expired */
	  nbl_chan_quiesce_and_reclaim_tx()
	    hw_ops->stop_mailbox_txq(hw_priv);
	    ...
	    nbl_chan_config_queue(chan_mgt, chan_info, true); /* QUEUE_EN=1 */

CPU1, in nbl_chan_teardown_queue() after the 5s wait expired:
	nbl_chan_stop_queue(chan_mgt);          /* no txq_lock */
	WRITE_ONCE(chan_info->active, false);

If CPU1's stop lands before CPU0's re-config, does the mailbox TX queue end
up armed again after teardown declared the channel inactive, pointing at
rings that devres is about to free?  This is also two concurrent writers of
the same BAR2 QINFO block, which is the case the changelog says cannot
occur.

> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	int err;
> +
> +	if (READ_ONCE(chan_info->active)) {
> +		dev_warn(common->dev, "channel already active, reject duplicate setup\n");
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

[Severity: Low]
This isn't reachable today, but the one-shot lifecycle the changelog
describes ("DMA buffers are allocated once in probe phase ... dynamic
runtime queue reinit is not supported") does not seem to be enforced by
anything except the active flag.

nbl_chan_teardown_queue() releases none of the dmam_alloc_coherent() or
devm_kcalloc() allocations and only clears active, so a
setup -> teardown -> setup sequence on the same chan_info would redo every
allocation (roughly 2 MiB of coherent DMA) and orphan the previous set until
device detach.  Would it be worth making teardown_queue refuse to re-open
the setup path, or documenting the constraint in the ops prototypes?

[ ... ]

> +static void nbl_chan_quiesce_and_reclaim_tx(struct nbl_channel_mgt *chan_mgt,
> +					    struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *hw_priv = chan_mgt->hw_ops_tbl->priv;
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct nbl_chan_tx_desc *tx_desc;
> +
> +	/* Assert QUEUE_RST to stop hardware fetching new descriptors */
> +	hw_ops->stop_mailbox_txq(hw_priv);
> +	hw_ops->flush_write(hw_priv);

[Severity: High]
Is this flush_write() safe on functions other than PF0?

flush_write() is nbl_flush_writes(), which reads NBL_HW_DUMMY_REG
(0x1300904, about 19.9 MiB into BAR0):

drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
/*
 * Only call this when has_ctrl=true, which maps enough space
 * (bar_len - 8192) to cover NBL_HW_DUMMY_REG (0x1300904).
 * The flow/design guarantees this is only called in the
 * has_ctrl path.
 */
static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
{
	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
}

But nbl_hw_init_leonis() only maps 8 KiB of BAR0 when has_ctrl is clear:

	hw_size = NBL_REG_NET_ONLY_LEN;
	hw_mgt->hw_addr = pcim_iomap(pdev, NBL_MEMORY_BAR, hw_size);

and nbl_get_func_param() sets has_ctrl only for
PCI_FUNC(pdev->devfn) == 0 && !pdev->is_virtfn.

So on PF1..PF3 (which do send mailbox messages later in the series), does
nbl_chan_send_msg() -> nbl_chan_kick_tx_ring() -> quiesce path perform a
readl() roughly 20 MiB past the end of the ioremap mapping when the device
fails to set NBL_CHAN_TX_DESC_USED within NBL_CHAN_TX_WAIT_TIMES iterations
(around 10 ms)?  That is exactly the precondition the comment on
nbl_flush_writes() states.

Should flush_write() be gated on common->has_ctrl, or bounds-checked the way
nbl_hw_write_mbx_regs() already checks mailbox_bar_size?

[ ... ]

> +		retry_count++;
> +		if (retry_count == max_retries) {
> +			msg_type = le16_to_cpu(READ_ONCE(tx_desc->msg_type));
> +			dev_err_ratelimited(dev, "chan send msg type: %d timeout\n",
> +					    msg_type);
> +			/*
> +			 * Device failed to complete this descriptor.
> +			 * Quiesce the queue, reclaim the timed-out
> +			 * descriptor, and re-enable so future sends can
> +			 * proceed instead of stalling the ring full.
> +			 */
> +			nbl_chan_quiesce_and_reclaim_tx(chan_mgt,
> +							chan_info);
> +			return -ETIMEDOUT;
> +		}

[ ... ]

> +		while (!READ_ONCE(wait_head->acked)) {

[ ... ]

> +			if (ret == 0) {
> +				mutex_lock(&chan_info->pending_lock);
> +				if (READ_ONCE(wait_head->status) ==
> +				    NBL_MBX_STATUS_WAITING) {
> +					WRITE_ONCE(wait_head->status,
> +						   NBL_MBX_STATUS_TIMEOUT);
> +					WRITE_ONCE(wait_head->acked, 0);
> +					WRITE_ONCE(wait_head->ack_data, NULL);
> +					WRITE_ONCE(wait_head->ack_data_len, 0);
> +					/*
> +					 * Ensure all status/ack slot
> +					 * updates are visible before subsequent
> +					 * readers observe acked == 0
> +					 */
> +					smp_wmb();
> +				}
> +				mutex_unlock(&chan_info->pending_lock);
> +				dev_err_ratelimited(dev,
> +						    "Channel waiting ack failed, message type: %d, msg id: %u\n",
> +						    chan_send->msg_type, msgid);
> +				ret = -ETIMEDOUT;
> +				/*
> +				 * TIMEOUT slots can be reused by another
> +				 * sender. The current sender no longer
> +				 * owns the slot after transitioning it to
> +				 * TIMEOUT.
> +				 */
> +				goto out_clean_inflight;
> +			}

[Severity: High]
What happens to the wait slot when the ACK arrives just as the 3s
wait_event_timeout() expires?

wait_event_timeout() returns 0 only after its last condition check saw
acked == 0.  Between that check and the pending_lock acquisition here,
nbl_chan_recv_ack_msg() can take pending_lock and publish:

	WRITE_ONCE(wait_head->acked, 1);
	WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_ACKD);

The sender then sees status == NBL_MBX_STATUS_ACKD, skips the WAITING-only
fixup, sets ret = -ETIMEDOUT and jumps to out_clean_inflight, so
out_clear_wait_slot / nbl_chan_reset_wait_head() is never reached for that
slot.

nbl_chan_get_msg_id() only hands out slots in IDLE or TIMEOUT state:

	if (status == NBL_MBX_STATUS_IDLE ||
	    status == NBL_MBX_STATUS_TIMEOUT) {

Does that leak the slot permanently out of the 256-entry pool, so repeated
occurrences eventually make every synchronous send return -EAGAIN?  The
caller also gets -ETIMEDOUT for a request whose ACK payload was already
copied into its response buffer.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> index e281109f502e6..795f29bfb47a9 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h

[ ... ]

> +/*
> + * Only call this when has_ctrl=true, which maps enough space
> + * (bar_len - 8192) to cover NBL_HW_DUMMY_REG (0x1300904).
> + * The flow/design guarantees this is only called in the
> + * has_ctrl path.
> + */
> +static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +}

See the question above at nbl_chan_quiesce_and_reclaim_tx(): the new
unconditional flush_write() call comes from the generic channel layer, which
runs on every PF, so the has_ctrl precondition stated here no longer holds.

Thanks for looking at these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
