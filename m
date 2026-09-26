Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6A374E5B;
	Sat, 26 Sep 2026 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431241; cv=none; b=As9c8fg47THNIyr6fEl8uk0S1iCTwH5v16QFhFoVSayR0ICxn859FoMUvt4Ak6g4FPfL7HvOG9P3977LRyeU4FI74YTnamcYaYfDFB26yPEuDTqtQ2QfSovYXq4n2SR773XGwG4cR+cD0EITHdu8E71L1bwdGIdaQVH8Ssj1HOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431241; c=relaxed/simple;
	bh=fQuGVyxsArBujDs+HgBh92jk0XkvGSKmCx3EJRSFv+Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dYvBKZQYsnk9Bln4y3AWQkqggxJr2pa4EDSBgF2jggP7ZbDoTP3n4Zv/YNPhYhANK8gznjUnIRjqBrNaqh7W8nAG7u7qF28QneInfrjk7ZdJ5j28UZAFpG1lrivzcsSkaZkhl2IjOwDvm1b0tXzhW2hfEW8FoqtkGhrX5NU1F8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToGJ81yE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToGJ81yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4611F000FF;
	Sat, 26 Sep 2026 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431228;
	bh=428jnVP6FoTDWLaAZUhSAopzPRfjP1uhPlVxqjv93mE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ToGJ81yE2O42KIWR7IuBzmcmnuuYibKPMpjx32LmwcXEVhmKGwdu9yAKJB6AY32Lk
	 OTcMFwDjZ0RR1UU7pB5M9VKk6dbpmge0J1ZIZmDtZi50yuJivqwkAClTZWWGzb9BnW
	 jRBG5QwUrFO2nOTELMtJnC97QhiCk6qaw8RIO904pK/kpPZkt73OBN01qmh3Ctf68N
	 mIMbnTl7NpL/nscztEqVuXn3PQDror2LyX/s+BZ37l3gfxhYYmDzDEyVOs3wOaCJAC
	 9UjrJScE1SCdqOMM02CVpPP3X0VCt62Ii8qPkJfLRw7bt3P/MOctn4HOrzlDJVKdnC
	 UsUYV5e1PzD8w==
Subject: Re: [PATCH v29 net-next 1/8] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:27 +0000
Message-ID: <179043122731.2160803.11621015133630521459@kernel.org>
In-Reply-To: <20260922120311.86593-2-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-2-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the "zombie" teardown path of nbl_chan_teardown_queue()
  (inflight-TX drain timeout followed by a failed…
- [High] nbl_chan_teardown_queue() uses
  mutex_trylock(&chan_info->txq_lock) with a fallback that skips the…
- [Medium] nbl_chan_teardown_queue() step 2 calls
  nbl_chan_reset_wait_head() on every wait slot under pending_lock,…
- [Medium] The inflight drain protocol lets the counter reach zero before
  the last sender has finished touching channel-owned objects.
- [Low] The comment block in nbl_chan_teardown_queue() that justifies the
  5000 ms drain timeout states that 'polling senders re-check shutdn…
- [Low] Reported concern: the commit message presents an active inter-PF
  mailbox ('implement core inter-PF communication capability', 'One-shot…
- [Low] Reported concern: new comments and kerneldoc describe helpers and
  validation that do not exist at this commit -- nbl_channel.c…
- [Low] Reported concern: nbl_chan_send_msg() gates only on
  chan_info->shutdn, never on chan_info->active or num_txq_entries != 0.
- [Low] Reported concern: chan_info->active and chan_info->dma_allocated
  are used as check-then-set duplicate-call guards in…

--

net/nebula-matrix: add channel layer

This adds a mailbox-based channel layer for the nebula-matrix driver: an
xarray of message handlers, TX/RX mailbox queue lifecycle management with
devm/dmam allocated rings, and a small hw_ops layer for the mailbox queue
registers.  The channel ops are published into adapter->intf at probe; the
callers arrive in later patches of the series.

No Link: tags were present in the commit header.

A few questions below, mostly around the teardown path.

First, one wording question about the changelog itself:

> - Create device-independent dedicated workqueue for RX cleanup tasks

[Severity: Low]
This isn't a bug, but is "device-independent" the right description?  The
workqueue created by nbl_common_create_wq() is named per device and stored
in the per-device nbl_common_info:

	snprintf(wq_name, sizeof(wq_name), "nbl_wq_%s", pci_name(common->pdev));
	common->wq = alloc_workqueue(wq_name, WQ_UNBOUND, 0);

so it looks like one workqueue per adapter rather than a device-independent
one.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..706875751836c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1421 @@

[ ... ]

> +static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +
> +	hw_ops->stop_mailbox_rxq(chan_mgt->hw_ops_tbl->priv);
> +	hw_ops->stop_mailbox_txq(chan_mgt->hw_ops_tbl->priv);
> +}

[ ... ]

> +	mutex_lock(&chan_info->pending_lock);
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		wait_head = &chan_info->wait[i];
> +		nbl_chan_reset_wait_head(chan_info, wait_head);
> +		WRITE_ONCE(wait_head->ack_err, (s32)-EIO);
> +		WRITE_ONCE(wait_head->acked, 1);
> +		wake_up(&wait_head->wait_queue);
> +	}
> +	mutex_unlock(&chan_info->pending_lock);

[Severity: Medium]
This loop resets every slot, including slots still owned by a live sender.
Can that hand a wrong result back to that sender?

nbl_chan_reset_wait_head() publishes:

	WRITE_ONCE(wait_head->ack_data_len, 0);
	WRITE_ONCE(wait_head->ack_err, 0);

while nbl_chan_send_msg() consumes its completion without pending_lock, in
both the interrupt branch and the polling fast path:

	if (READ_ONCE(wait_head->acked)) {
		smp_rmb();
		chan_send->ack_len = READ_ONCE(wait_head->ack_data_len);
		ret = READ_ONCE(wait_head->ack_err);
	}

If the genuine ACK already landed (acked=1, status=ACKD) and teardown runs
between those two loads, the sender can pair the real ack_data_len with the
reset's ack_err == 0, reporting success for a remote failure, or the real
ack_err with ack_data_len == 0.  READ_ONCE()/smp_rmb() order the reads but
do not exclude the concurrent overwrite.

The same reset also publishes status = NBL_MBX_STATUS_IDLE for a slot that
still has an owner.  nbl_chan_get_msg_id() allocates any IDLE or TIMEOUT
slot and has no shutdn check, so can a sender that was admitted before
shutdn was set be handed a slot that still belongs to another sender?

> +	/*
> +	 * Drain strategy mirrors mlx5 command interface teardown:
> +	 * set shutdown flag first, abort all pending waiters, then
> +	 * block until inflight_tx_cnt reaches zero.
> +	 *
> +	 * After shutdn is set every sender exits promptly at its next
> +	 * checkpoint:
> +	 *   - interrupt-driven senders wake on shutdn immediately
> +	 *     (it is part of the wait_event condition);
> +	 *   - polling senders re-check shutdn every 100-120us;

[Severity: Low]
The ACK-polling sender in nbl_chan_send_msg() sleeps:

	usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
		     NBL_CHAN_TX_WAIT_ACK_US_MAX);

which is 1000-1200us, not 100-120us.  The 100-120us figure is
NBL_CHAN_TX_WAIT_US/NBL_CHAN_TX_WAIT_US_MAX, used only by the descriptor
poll in nbl_chan_kick_tx_ring().

Worth noting that the polling sender's unshortened worst case is
NBL_CHAN_TX_WAIT_ACK_TIMES (5000) x 1000-1200us = 5.0-6.0s, which equals or
exceeds the msecs_to_jiffies(5000) drain window this comment is sizing.  The
shutdn check at the top of each iteration keeps that from mattering today.

[ ... ]

> +	err = !wait_event_timeout(chan_info->inflight_wait,
> +				  atomic_read(&chan_info->inflight_tx_cnt) == 0,
> +				  msecs_to_jiffies(5000));
> +	if (err) {
> +		dev_warn(chan_mgt->common->dev,
> +			 "teardown: inflight tx drain timeout\n");
> +		ret = -ETIMEDOUT;
> +	}

[ ... ]

> +	if (!err) {
> +		mutex_lock(&chan_info->txq_lock);
> +		nbl_chan_stop_queue(chan_mgt);
> +		mutex_unlock(&chan_info->txq_lock);
> +	} else if (mutex_trylock(&chan_info->txq_lock)) {
> +		nbl_chan_stop_queue(chan_mgt);
> +		mutex_unlock(&chan_info->txq_lock);
> +	} else {
> +		dev_crit(chan_mgt->common->dev,
> +			 "zombie channel: inflight sender holds txq_lock; HW stop skipped, queue left in QUEUE_RST; device requires reset before re-bind\n");
> +	}

[Severity: High]
When the trylock fails, nbl_chan_stop_queue() is skipped for both queues.
Can this leave the mailbox RX engine DMAing into freed coherent memory?

nbl_chan_stop_queue() is the only path to hw_ops->stop_mailbox_rxq(), and
the sender-side recovery in nbl_chan_quiesce_and_reclaim_tx() only touches
TX:

	hw_ops->stop_mailbox_txq(hw_priv);

So after this branch the RX QINFO table still has QUEUE_EN=1 with 255 AVAIL
descriptors whose buf_addr point at dmam_alloc_coherent() buffers:

nbl_chan_teardown_queue() returns -ETIMEDOUT
  -> nbl_dev_remove_common_dev() only dev_warn()s the error
  -> nbl_core_remove() returns
  -> devres frees rxq->desc.rx_desc and all 256 RX buffers

while the device can still write incoming peer messages and descriptor
writeback into them.

Related, is the dev_crit() text accurate?  It says "queue left in
QUEUE_RST", but RX is never reset on this path, and for TX both shutdn
checkpoints in nbl_chan_kick_tx_ring() return without emitting any register
write:

		if (READ_ONCE(chan_info->shutdn))
			return -ESHUTDOWN;

Since nbl_hw_stop_mailbox_rxq() writes a different 16-byte QINFO region
(NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR) than any sender ever writes
(NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR), could the RX reset be issued
unconditionally before the rings are released, rather than being gated on
txq_lock?

[Severity: High]
The other half of this: teardown never waits for the lock holder, so can the
surviving sender read freed memory?

A sender parked in nbl_chan_kick_tx_ring() holds txq_lock and polls the
coherent TX descriptor ring:

		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
		    BIT(NBL_CHAN_TX_DESC_USED)) {

Meanwhile teardown takes the trylock failure branch, runs
cancel_work_sync(), sets active = false and returns -ETIMEDOUT, which is
only dev_warn()ed, so nbl_core_remove() completes and devres frees the
rings.  The same sender then continues into its exit path and touches
chan_info->state_lock and chan_info->wait[], which are devm allocated in
nbl_chan_setup_chan_mgt() and freed at detach too:

	mailbox = devm_kzalloc(dev, sizeof(*mailbox), GFP_KERNEL);

There is no bounded wait for the lock holder and no reference on chan_info,
so nothing in the remove path joins it.  Would a blocking wait for txq_lock
(or a refcount/completion covering senders) be preferable to skipping the
hardware stop here?

[ ... ]

> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{
[ ... ]
> +	if (READ_ONCE(chan_info->active)) {
> +		dev_warn(common->dev, "channel already active, reject duplicate setup\n");
> +		return -EBUSY;
> +	}

[Severity: Low]
This isn't a bug, since setup and teardown are only reachable from the
probe and remove paths which the driver core serializes, but the header
comment says otherwise:

	/* Guards channel state bitmap, active and shutdn flags */
	struct mutex state_lock;

active is read and written here and in nbl_chan_teardown_queue() without
state_lock.  Could the comment be narrowed to what state_lock actually
guards?

[ ... ]

> +	mutex_lock(&chan_info->state_lock);
> +	if (READ_ONCE(chan_info->shutdn)) {
> +		mutex_unlock(&chan_info->state_lock);
> +		return -ESHUTDOWN;
> +	}
> +	atomic_inc(&chan_info->inflight_tx_cnt);
> +	mutex_unlock(&chan_info->state_lock);

[Severity: Low]
This isn't a bug with the current call order, but the entry gate checks only
shutdn, not active or num_txq_entries.  send_msg is published in the ops
table by nbl_chan_init_common() before setup_queue() runs, and with
num_txq_entries still 0 this would reach:

	return NBL_NEXT_ID(txq->next_to_use, num_entries - 1) ==
	       txq->next_to_clean;

which is a modulo by zero, followed by a NULL txq->desc.tx_desc.  Every
in-tree caller runs after a successful setup_queue(), so nothing hits it
today.  Would an active check here be worth adding as a guard?

[ ... ]

> +out_clean_inflight:
> +	mutex_lock(&chan_info->state_lock);
> +	if (atomic_dec_and_test(&chan_info->inflight_tx_cnt))
> +		wake_up(&chan_info->inflight_wait);
> +	mutex_unlock(&chan_info->state_lock);
> +	return ret;

[Severity: Medium]
The counter reaches zero and teardown is woken before this sender has
finished with state_lock.  Can the mutex be freed under it?

sender:
	mutex_lock(&chan_info->state_lock);
	atomic_dec_and_test(&chan_info->inflight_tx_cnt);	/* true */
	wake_up(&chan_info->inflight_wait);
	<preempted here>
	mutex_unlock(&chan_info->state_lock);

teardown only waits on the counter and never takes state_lock:

	err = !wait_event_timeout(chan_info->inflight_wait,
				  atomic_read(&chan_info->inflight_tx_cnt) == 0,
				  msecs_to_jiffies(5000));

so it can proceed through nbl_chan_stop_queue(), cancel_work_sync() and
return, and nbl_core_remove() can complete, letting devres release
chan_info and run mutex_destroy() on a mutex that is still held.  Does the
wake_up() need to move after the unlock, or does the drain need to wait for
the sender itself rather than the counter?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index ecbf440e43666..ce092005d7672 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> @@ -10,6 +10,44 @@

[ ... ]

> +	 *   All-zero mask (0x00) means all 8 PFs enabled, which is
> +	 *   unsupported by the driver and rejected with -EINVAL.
> +	 *
> +	 * Firmware contract: number of unmasked PFs MUST equal
> +	 * get_board_info()->eth_num.
> +	 */
> +	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);

[Severity: Low]
This isn't a bug, but several of the new comments describe code that only
appears later in the series, which makes this patch hard to verify on its
own: this kerneldoc's -EINVAL rejection lives in nbl_res_init_pf_num(), the
get_board_info() op does not exist yet, and nbl_chan_cfg_qinfo_map_table()
defers to "resource initialization logic" that is not in the tree at this
point.  Likewise nbl_channel.c refers to hw_ops->flush_write() and
nbl_hw_leonis.c refers to nbl_flush_writes(), cfg_msix_map(),
set_mailbox_irq() and intr_mgt_stop, and NBL_HW_DUMMY_REG plus
NBL_PCIE_HOST_TL_CFG_BUSDEV are added here with no user.  Could the forward
references be trimmed or the definitions land with their users?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
