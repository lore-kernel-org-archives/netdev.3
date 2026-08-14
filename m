Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BA2BEFE8;
	Fri, 14 Aug 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736309; cv=none; b=Ad7R+MgU7hKoYVa2ZTYkgTkdPle8zyrGq4MJEQK2OL1KEJaBc7xdFrgUY2JH1LQkFoaMSpphdcOl36tJszdGZdWKkRpx9hj83g3q1ZiuXQsjnXq84gkc989Xm5yQM4SVF1HIKqg45HZ6DOitoiLFeAEnWhe6xhYMQSP6OPcs/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736309; c=relaxed/simple;
	bh=fTZRH1jYJ5jimrnKepQj5HDws9oqXx6c3lOJbM+yvDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFy0E1omJJGAfKJv1ksDIqMrS/HNyGQjExaEONSSWqUQGY/QAh/j2Coa4i8MePtex0c3YjguviaM0pPxPqsWUnsu/WnjGfzvI0P1mcaKOOunHApx2kELkLicxjFYdjwDfkSRnlIVPV/hIrwOWl40Ywbh2v2bAWOmi/9LAzAaB0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW3ULMl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW3ULMl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6271F000E9;
	Fri, 14 Aug 2026 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736307;
	bh=L7gpos0zTj8w4mctBovTY/zqJO6eOYoX/n4xPLEt/Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oW3ULMl6Yi9MsQy3ZIbpGnaCzPSbyR2jgoHUmlYKYtuHXw7Bdc0edUE5IwFfOzHhc
	 +49GBPbplsJEEkCnS4/D5VYlQB6KuwaNtFDNRyLzmgTPdUXFXuSUnzzQVUB14jL1z+
	 T2AFwrcUedM34yqopMmY28CM71AB+6d4H3E0TvCUL3m8obOWMGJaku4EZOoyBb7IfN
	 Uoo777ZUACO9zy8hcW6WV7+vkpoDcyn/P+6GPtw82KHEqYiKysh3KiuGgsxO30EsKq
	 qpSPWW6epkhib2mBnFD2rv1Yo3xPjl6RiiddgD88SP5X9BHtRd4U3lUejP7maEWXAP
	 e2ywBdBH2+lTA==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v24 net-next 04/11] net/nebula-matrix: add channel layer
Date: Fri, 14 Aug 2026 12:38:25 -0700
Message-ID: <20260814193825.3197607-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807044422.2356-5-illusion.wang@nebula-matrix.com>
References: <20260807044422.2356-5-illusion.wang@nebula-matrix.com>
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
net/nebula-matrix: add channel layer

This adds a mailbox based channel layer for the nbl driver, with message
registration through a hash table, synchronous send-with-ack and
fire-and-forget send, and TX/RX ring setup and teardown backed by devm
and dmam allocations.  A leonis hardware operations table is added for
mailbox queue configuration and doorbell updates.

A few questions on the locking, barriers and teardown ordering below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 000000000000..3eb795199217
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1068 @@

[ ... ]

> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +	struct nbl_chan_waitqueue_head *wait_head;
> +	unsigned long wait_start, wait_timeout;
> +	int ret = 0;
> +	u16 i;
> +
> +	/* Step 1: Mark shutdown flag, reject all new send requests */
> +	WRITE_ONCE(chan_info->shutdown, true);

[ ... ]

> +	/* Stop hardware queues */
> +	nbl_chan_stop_queue(chan_mgt);
> +
> +	/*
> +	 * Step 2: Wait all in-flight send_msg threads exit FIRST.
> +	 * Guarantee no further queue_work() can be triggered during cleanup.
> +	 * Add timeout to avoid permanent blocking.
> +	 */
> +	wait_start = jiffies;
> +	wait_timeout = msecs_to_jiffies(5000);
> +	while (atomic_read(&chan_info->inflight_tx_cnt) != 0) {

[Severity: Low]
The comment says "Step 2: Wait all in-flight send_msg threads exit FIRST",
but nbl_chan_stop_queue() runs before the inflight_tx_cnt drain loop.  Is
that ordering intended?

nbl_chan_stop_queue() -> nbl_hw_stop_mailbox_txq()/rxq() asserts
NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK and clears QUEUE_EN, so a sender that
already passed the early shutdown check can still publish a descriptor and
ring the doorbell into a queue that is held in reset:

nbl_chan_send_msg()
  nbl_chan_update_txqueue()   /* no shutdown check at all */
     tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));
     txq->tail_ptr++;
  nbl_chan_kick_tx_ring()
     nbl_chan_update_tail_ptr(...)   /* doorbell, before the shutdown re-check */

Would draining inflight_tx_cnt before nbl_chan_stop_queue() avoid the driver
tail pointer diverging from the device consumer pointer?

> +		if (time_after(jiffies, wait_start + wait_timeout)) {
> +			dev_warn(chan_mgt->common->dev,
> +				 "teardown: wait inflight_tx_cnt timeout, force continue\n");
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
> +		cpu_relax();
> +		usleep_range(1000, 2000);
> +	}
> +
> +	/* Step3: All send paths drained, safely cancel cleanup work */
> +	if (chan_info->clean_task) {
> +		cancel_work_sync(chan_info->clean_task);
> +		chan_info->clean_task = NULL;
> +	}
> +	return ret;
> +}
> +
> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_common_info *common = chan_mgt->common;
> +	struct nbl_chan_ring *rxq = &chan_info->rxq;
> +	int err;
> +
> +	if (READ_ONCE(chan_info->init_done))
> +		return 0;

[Severity: Low]
Are .setup_queue and .teardown_queue meant to be a symmetric pair?

nbl_chan_teardown_queue() leaves chan_info->init_done true and
chan_info->shutdown true, and does not reset txq/rxq next_to_use,
next_to_clean or tail_ptr.  With the init_done early return above, a
setup_queue() after a teardown_queue() returns 0 without re-running
nbl_chan_config_queue() (the only code that deasserts QUEUE_RST and sets
QUEUE_EN), without re-ringing the RX doorbell, and without clearing
shutdown, since only nbl_chan_init_queue_param() does that and it sits
behind the guard:

	if (READ_ONCE(chan_info->init_done))
		return 0;
	...
	nbl_chan_init_queue_param(chan_info, ...);   /* clears shutdown */

Today both ops are only reached from probe and remove with a freshly
devm_kzalloc'ed chan_info, so nothing hits this.  Should teardown clear
init_done and the ring indices so a later stop/restart cycle (device reset,
PF down/up) does not silently succeed on a channel whose queues are still in
reset?

[ ... ]

> +static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
> +				   struct nbl_chan_info *chan_info,
> +				   struct nbl_chan_tx_param *param)
> +{
[ ... ]
> +	tx_desc->dstid = cpu_to_le16(param->dstid);
> +	tx_desc->msg_type = cpu_to_le16(param->msg_type);
> +	tx_desc->msgid = cpu_to_le16(param->msgid);

[Severity: Low]
Who writes tx_desc->srcid?  This is the only producer of the descriptor and
it sets dstid, msg_type, msgid, the data/buf fields and flags, but never
assigns or clears srcid, while both receive paths consume it:

nbl_chan_recv_msg()
	srcid = le16_to_cpu(READ_ONCE(tx_desc->srcid));
	...
	msg_handler->func(msg_handler->priv, srcid, msgid, payload, payload_len);

nbl_chan_recv_ack_msg()
	if (srcid != READ_ONCE(wait_head->dstid)) {
		... "ACK srcid=%u != dstid=%u, rejecting"

If the mailbox engine populates srcid in the copy delivered to the peer,
could a comment say so?  Otherwise the field is whatever the reused ring
slot held.

[ ... ]

> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{
[ ... ]
> +	atomic_inc(&chan_info->inflight_tx_cnt);
> +	inflight_inc = true;
> +	/*
> +	 * Ensure reading chan_info->shutdown happens
> +	 * strictly after inflight_tx_cnt increment above on this CPU.
> +	 * Prevent compiler/cpu reordering: read shutdown before incrementing
> +	 * inflight counter, which would cause missing shutdown check and leak
> +	 * tx inflight count.
> +	 */
> +	smp_rmb();
> +	if (READ_ONCE(chan_info->shutdown)) {
> +		atomic_dec(&chan_info->inflight_tx_cnt);
> +		return -ESHUTDOWN;
> +	}

[Severity: Medium]
Does smp_rmb() give the ordering the comment claims here?  This is a store
followed by a load, and smp_rmb() only orders load-load pairs; the
non-value-returning atomic_inc() provides no ordering of its own.

The peer half in nbl_chan_teardown_queue() uses a full barrier and so
depends on the sender mirroring it:

CPU0 nbl_chan_send_msg()             CPU1 nbl_chan_teardown_queue()
  atomic_inc(&inflight_tx_cnt);        WRITE_ONCE(shutdown, true);
  smp_rmb();                           smp_mb();
  load shutdown  -> false              atomic_read(&inflight_tx_cnt) -> 0

Can the shutdown load be satisfied before the increment is visible, so that
teardown concludes the drain, calls nbl_chan_stop_queue() and
cancel_work_sync() and returns while CPU0 goes on to take txq_lock, write a
descriptor and ring the doorbell?  Since teardown_queue() is the last thing
guarding the rings before devres releases the dmam_alloc_coherent()
descriptor rings and the devm_kcalloc() wait array, would smp_mb() (or
atomic_fetch_inc()) be the right primitive here?

> +
> +	mutex_lock(&chan_info->txq_lock);
> +	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state)) {
> +		ret = -EIO;
> +		goto unlock_out;
> +	}

[Severity: Low]
Is anything expected to set NBL_CHAN_ABNORMAL?  This test_bit() is its only
user in the tree; the only writer would be nbl_chan_set_queue_state(), and
its callers pass NBL_CHAN_INTERRUPT_READY, so this branch cannot be taken.

Related, the patch defines NBL_MAILBOX_QINFO_CFG_DIF_ERR_MASK and
NBL_MAILBOX_QINFO_CFG_PTR_ERR_MASK in nbl_hw_leonis.h, but the qinfo cfg
table is only ever written (nbl_hw_write_mbx_regs has no read-back
counterpart), so those status bits are never sampled.  With no reader, a
queue the hardware has flagged as errored is never detected, and
nbl_chan_kick_tx_ring() just logs and advances next_to_clean:

	dev_err_ratelimited(dev, "chan send msg type: %d timeout\n", msg_type);
	txq->next_to_clean = txq->next_to_use;
	return -ETIMEDOUT;

Is the error-bit sampling and queue reconfigure planned for a follow-up?

[ ... ]

> +	ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
> +	if (ret) {
[ ... ]
> +		goto unlock_out;
> +	}
> +	mutex_unlock(&chan_info->txq_lock);
> +	if (!chan_send->ack) {
> +		tmp = FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, msgid);
> +		wait_head = &chan_info->wait[tmp];
> +		spin_lock_irq(&wait_head->status_lock);
> +		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_IDLE);
> +		spin_unlock_irq(&wait_head->status_lock);
> +		atomic_dec(&chan_info->inflight_tx_cnt);
> +		return 0;
> +	}

[Severity: Medium]
Can this write to a slot the caller no longer owns?  txq_lock is what
serializes TX slot ownership, and it is dropped just above.  The slot was
already set to IDLE inside the earlier status_lock block:

	WRITE_ONCE(wait_head->status, chan_send->ack ?
		   NBL_MBX_STATUS_WAITING : NBL_MBX_STATUS_IDLE);

so this second write looks redundant.  In the gap, another sender can be
handed the same slot, and nbl_chan_get_msg_id() starts its search exactly
there because wait_head_index was just pointed at it:

	int search_loc = chan_info->wait_head_index, i;
	...
		if (status == NBL_MBX_STATUS_IDLE ||
		    status == NBL_MBX_STATUS_TIMEOUT) {
	...
		WRITE_ONCE(chan_info->wait_head_index, search_loc);

Sender B then arms the slot WAITING and blocks, sender A forces it back to
IDLE, and the ACK is dropped:

nbl_chan_recv_ack_msg()
	if (READ_ONCE(wait_head->status) != NBL_MBX_STATUS_WAITING) {
		spin_unlock_irq(&wait_head->status_lock);
		dev_err_ratelimited(dev, "Skip ack with invalid status, ...");

B then fails with -ETIMEDOUT after NBL_CHAN_ACK_WAIT_TIME.  The interrupt
mode timeout path only cleans up when it still sees NBL_MBX_STATUS_WAITING,
so it can instead clobber a third sender's freshly armed slot, setting it to
TIMEOUT and NULLing its ack_data while that sender waits.  Note
nbl_chan_send_ack() is exactly a chan_send->ack == 0 sender, so both
participants are the workqueue ACK sender and a synchronous RPC.  Can this
write simply be dropped?

[ ... ]

> +static int nbl_chan_send_ack(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_ack_info *chan_ack)
> +{
[ ... ]
> +	len = head_len + data_len;
> +	tmp = kzalloc(len, GFP_ATOMIC);
> +	if (!tmp)
> +		return -ENOMEM;

[Severity: Low]
Is GFP_ATOMIC needed here?  This path cannot be atomic: nbl_chan_send_msg()
below takes mutex_lock(&chan_info->txq_lock) and nbl_chan_kick_tx_ring()
calls usleep_range().  The only caller chain is the clean_task work item
(the mailbox IRQ handler just schedules work), so GFP_KERNEL would match the
actual context, and the GFP_ATOMIC here documents a contract the code cannot
honour.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> new file mode 100644
> index 000000000000..92db39e1b05e
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> @@ -0,0 +1,170 @@

[ ... ]

> +	/*
> +	 * Spinlock protecting all fields.
> +	 * Must be held when reading/writing: status, acked, ack_err,
> +	 * ack_data_len, etc.
> +	 * The lock ensures atomic updates of these fields and
> +	 * proper memory ordering with smp_wmb()/smp_rmb().
> +	 */
> +	spinlock_t status_lock;

[Severity: Low]
Does this comment match the code?  Two readers of acked run with
status_lock dropped:

nbl_chan_send_msg()
		ret = wait_event_timeout(wait_head->wait_queue,
					 READ_ONCE(wait_head->acked) || ...

nbl_chan_recv_ack_msg()
	spin_unlock_irq(&wait_head->status_lock);
	if (READ_ONCE(wait_head->acked))
		wake_up(&wait_head->wait_queue);

There is also no smp_wmb() anywhere in the driver, so the documented barrier
pairing does not exist.  Could the comment be narrowed to the fields the
lock actually serializes?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> new file mode 100644
> index 000000000000..fc9b489ca02c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> @@ -0,0 +1,166 @@

[ ... ]

> +/*
> + * Allocate a hash node and add to the hash table.
> + *
> + * Note: The hash table is protected by the caller's mutex (txq_lock),
> + * not lock-free. The "single context" comment refers to: this function
> + * is only called during init from nbl_chan_init_msg_handler, so there
> + * is no concurrent mutation during init.
> + * After init, the table is read-only (no unregister API), so no lock is needed
> + * for lookups either.

[Severity: Low]
Both claims in this note look inaccurate.

nbl_chan_init_msg_handler() only creates the table via
nbl_common_init_hash_table(); the caller of this function is
nbl_chan_add_msg_handler() reached through the exported op:

static int nbl_chan_register_msg(struct nbl_channel_mgt *chan_mgt, u16 msg_type,
				 nbl_chan_resp func, void *callback)
{
	return nbl_chan_add_msg_handler(chan_mgt, msg_type, func, callback);
}

and chan_info->txq_lock is taken only by nbl_chan_send_msg(), never on the
registration path.  Insertion is a plain hlist_add_head() plus a non-atomic
node_num++, while nbl_common_get_hash_node() traverses with the non-RCU
hlist_for_each_entry() from the clean_task work item.

Today all registrations complete before the RX queue is programmed, so
nothing races.  Could the note instead state that requirement, since the
current wording points at a mutex that is not involved?

[ ... ]

Cross-instance finding from sashiko-gemini (b71ef5b11f4458a07533fdf4c44ce80b1dc5c6eaa0b8f201e2c68859763e947e):
[Severity: Medium]
The code implements the `clean_task` requeue optimization, directly contradicting the commit message.

Cross-instance finding from sashiko-gemini (f61ba5020ca4df734e90e4522b80858df46b2e1c1ebb7645f42be89a01ba9a4a):
[Severity: Critical]
Wait slot leak and stack corruption when interrupts are not ready in nbl_chan_send_msg.
-- 
pw-bot: cr
