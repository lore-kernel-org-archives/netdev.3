Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F04F6495;
	Thu,  3 Sep 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455919; cv=none; b=dJXShSXNssKfkU8aKwIMEqx8JkBQNLOQGAUyN4La7/PYmosd/KpWiNZbFWA0WnheMk6UhWaRxUjO8OPdJ0+TjR37vZCrPcqCTw6D/o3zHnTn+fDxt8nC1WseM2AyM2LRzH9hZX1dzIGTAYh2TtQ+Tz6/f3OS6gmz7l3woQ7bkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455919; c=relaxed/simple;
	bh=4r9xdRuw+nfGSIJsqPwKloMG7ugsToOcHD7QcXoN4mY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYFxXDkZI55uVD0J2a1/ERJ4KCggbt3L+MabAafMSFuKGXmPny+MF1Zku7eYIcImWGQcRPqLRuBPWyO94QK2T3VonK0trTplrIL5qftOkL/yvDK7qHPGYwFzk5aIjFbz0ZvZOhTgr9L2y068D7+gzqZz5hBwpUXaY7ctqjRERYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbDTUD15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbDTUD15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575E21F000E9;
	Thu,  3 Sep 2026 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455917;
	bh=/VlosYE0+mQOcEd4YYUN3JGZzyrLKYH0CsOIAzr3Ma4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fbDTUD15HPDgyk7HtC4A+TLUQKRnjiRQuSufDjDfETdMczGneycGW3j7qcjIS38Ax
	 L5eK2yLlkVsZSomz5kzqndPt0FBVLedGQwLlKEjm+YFGWaOvr/a9UNuorvzzTAL+Lv
	 ucYsOq+E3PapRfKL5CmPruyDKfKJBHmpQNHPVIiqCmrhMzoqCrrbOERdlpUvicWRLl
	 CkdHJxJr9B5Wdk6dZdwzhSZ0lHzv1sILksS6SqOC8PKD3mVPcvMV+404eEmhQe1FQ4
	 qWrw21vovksrJxuHYJWCjdmRupOLE31wt3Vn0+xO2Tx6WZmI8G2jqg4mKE9QIROYcD
	 mwR96LsF/MEdg==
Subject: Re: [v26,net-next,03/10] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:35 +0000
Message-ID: <178845591590.3394541.2319447689516880002@kernel.org>
In-Reply-To: <20260831021408.2325-4-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-4-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 22 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 20

- [Medium] nbl_chan_get_msg_id() treats a wait slot in
  NBL_MBX_STATUS_TIMEOUT as free, but the timed-out owner has not…
- [Medium] nbl_chan_kick_tx_ring() rings the TX doorbell and polls for
  NBL_CHAN_TX_DESC_USED; on timeout it executes 'txq->next_to_clean =…
- [Low] Commit message describes an operational mailbox framework (queue
  lifecycle, dual RX modes, DMA buffers "allocated once in probe phase")…
- [Low] nbl_chan_setup_queue() re-runs all
  dmam_alloc_coherent()/devm_kcalloc() allocations (~2 MB per cycle)…
- [Low] The data paths (nbl_chan_send_msg(), nbl_chan_clean_queue()) gate
  only on chan_info->shutdn and never on chan_info->active, so a send or…
- [Low] The commit message claims the patch adds "register lock
  protection for hardware register read/write to ensure concurrent…
- [Low] The comment in nbl_chan_cfg_qinfo_map_table() justifies iterating
  raw hardware PF func_ids by claiming nbl_res_init_pf_num() already…
- [Low] nbl_hw_rd_regs_lock()/nbl_hw_wr_regs_lock() perform
  readl()/writel() at BAR0 offsets 0x1505004 (k_pf_mask) and 0xfb1000+…
- [Low] nbl_chan_cfg_qinfo_map_table() consumes the raw k_pf_mask value
  without honouring the driver's own documented contract (bit0 reserved…
- [Low] The kernel-doc block for struct nbl_hw_ops::get_host_pf_mask
  documents '@priv: hw ops private context', but the documented member's…
- [Low] The drain-strategy comment in nbl_chan_teardown_queue() justifies
  the 5 s inflight-drain timeout by asserting that every sender has 'its…
- [Low] nbl_chan_get_msg_id() stores the slot it just claimed back into
  chan_info->wait_head_index under a comment saying 'Advance starting…
- [Low] nbl_hw_wr32() in nbl_hw_reg.h carries the comment 'Used for emu,
  make sure that we won't write too frequently' although the body is a…
- [Low] nbl_chan_teardown_queue() returns the raw wait_event_timeout()
  result, so on success it returns a positive jiffies count (up to…
- [Low] The device-removal path never tears down an active mailbox queue
  before releasing channel resources: nbl_chan_remove_common() destroys…
- [Low] nbl_common_get_hash_node() returns hash_node->data after dropping
  the per-bucket spin_lock_bh with no reference count or RCU, and…
- [Low] chan_info->active/shutdn, the state bitmap, inflight_wait and
  inflight_tx_cnt are documented as guarded by state_lock, but…
- [Low] nbl_chan_set_queue_state() clears NBL_CHAN_IRQ_RDY, which is part
  of the wait condition used by the interrupt-mode ACK waiter in…
- [Low] In nbl_chan_update_txqueue() the external-buffer path copies the
  payload only 'if (param->arg)' but unconditionally programs…
- [Low] Every channel op taking a u8 chan_type indexes
  chan_mgt->chan_info[chan_type] (array size NBL_CHAN_TYPE_MAX == 1)…
- [Low] In nbl_chan_kick_tx_ring()'s completion-poll loop, dma_rmb() is
  issued before the load of tx_desc->flags with the comment 'Order…
- [Low] nbl_hw_init_leonis() accepts any non-zero mailbox BAR length,
  while nbl_hw_write_mbx_regs() silently drops out-of-range register…

--

net/nebula-matrix: add channel layer

This adds the mailbox based inter-PF channel layer for the nbl driver,
including the message handler hash table, TX/RX descriptor ring
management with coherent DMA buffers, and a hardware abstraction layer
for the mailbox queue registers.  A few questions below about the
channel state machine, the TX completion poll and some comments that
do not appear to match the code.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 000000000000..c29ff76a75ae
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1220 @@

[ ... ]

> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{

[ ... ]

> +	/*
> +	 * Step3:
> +	 * wait all sender exit
> +	 *
> +	 * Drain strategy mirrors mlx5 command interface teardown:
> +	 * set shutdown flag first, abort all pending waiters, then
> +	 * block until inflight_tx_cnt reaches zero.
> +	 *
> +	 * A timeout here is treated as an exceptional condition rather
> +	 * than a fatal error, following the same rationale as mlx5:
> +	 *   - shutdn is already set, so every sender path observes it
> +	 *     at its next checkpoint and exits;
> +	 *   - each sender has its own bounded timeout (3s ACK wait,
> +	 *     12ms max TX ring poll), all far shorter than this 5s
> +	 *     drain window, so stalling beyond 5s should never happen

[Severity: Low]
Is the "3s ACK wait" bound accurate for both wait modes?  The 3 * HZ
bound (NBL_CHAN_ACK_WAIT_TIME) applies only to the interrupt branch of
nbl_chan_send_msg().  The polling branch loops
NBL_CHAN_TX_WAIT_ACK_TIMES times with usleep_range():

	int i = NBL_CHAN_TX_WAIT_ACK_TIMES;
	...
		while (i--) {
			...
			usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
				     NBL_CHAN_TX_WAIT_ACK_US_MAX);

With NBL_CHAN_TX_WAIT_ACK_TIMES = 5000 and 1000-1200 us per iteration
that is roughly 5-6 s, which is longer than the 5 s drain window the
comment says every sender bound is "far shorter" than.  Should the
comment be corrected, or the constants adjusted?

> +	 *   - in that hardware-dead case proceeding with teardown cannot
> +	 *     make the situation worse, and avoids hanging rmmod forever.
> +	 */
> +	ret = wait_event_timeout(chan_info->inflight_wait,
> +				 atomic_read(&chan_info->inflight_tx_cnt) == 0,
> +				 msecs_to_jiffies(5000));
> +
> +	if (!ret) {
> +		dev_warn(chan_mgt->common->dev,
> +			 "teardown: inflight tx drain timeout\n");
> +		ret = -ETIMEDOUT;
> +	}

[Severity: Low]
On the success path this returns the raw wait_event_timeout() value,
i.e. the remaining jiffies (up to ~5000), through

	int (*teardown_queue)(struct nbl_channel_mgt *chan_mgt, u8 chan_type);

while the early "channel not active" path of the same function returns
0.  Would it be better to normalise the success case to 0 so a caller
doing "if (ret) goto err;" does not treat a fully drained queue as a
failure?

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
> +
> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{

[ ... ]

> +	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
> +	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
> +	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
> +				 rxq->tail_ptr, NBL_MB_RX_QID);
> +	WRITE_ONCE(chan_info->active, true);
> +	return 0;
> +}

[Severity: Low]
Can this mark the channel active when the hardware queues were never
programmed?  nbl_chan_config_queue() calls config_mailbox_txq/rxq,
which are void and end up in nbl_hw_write_mbx_regs(); that helper drops
out-of-range writes after a dev_err_once() and returns void, so the
failure cannot reach here.

nbl_hw_init_leonis() only rejects a mailbox BAR of length zero, while
the queue configuration tables are written at
NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR (0x10) and
NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR (0x20) plus 16 bytes each.  On a
BAR2 smaller than 0x30 the writes are silently skipped, the RX doorbell
is still rung and active is set to true.

Would it make sense to validate the mailbox BAR against the highest
register offset the driver uses at probe time, and/or let the config
ops return an error?

> +
> +static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,

[ ... ]

> +static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{

[ ... ]

> +	while (retry_count < max_retries) {
> +		if (READ_ONCE(chan_info->shutdn))
> +			return -ESHUTDOWN;
> +
> +		/* Order descriptor read after hardware DMA completion */
> +		dma_rmb();
> +		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
> +		    BIT(NBL_CHAN_TX_DESC_USED)) {
> +			break;
> +		}

[Severity: Low]
Does the dma_rmb() here provide the ordering the comment describes?  It
is issued before the load of tx_desc->flags, so it cannot order later
reads of device-written descriptor fields against observing USED.  The
RX side in nbl_chan_clean_queue() uses the other order:

	while (le16_to_cpu(READ_ONCE(rx_desc->flags)) &
	       BIT(NBL_CHAN_RX_DESC_USED)) {
		...
		/* Make sure hardware written descriptor visible to CPU */
		dma_rmb();
		nbl_chan_recv_msg(chan_mgt, rx_buf->va);

Should the TX poll follow the same pattern, loading flags first and
placing dma_rmb() between the USED test and any other descriptor field?

> +
> +		retry_count++;
> +		if (retry_count == max_retries) {
> +			msg_type = le16_to_cpu(READ_ONCE(tx_desc->msg_type));
> +			dev_err_ratelimited(dev, "chan send msg type: %d timeout\n",
> +					    msg_type);
> +			txq->next_to_clean = txq->next_to_use;
> +			return -ETIMEDOUT;
> +		}
> +		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
> +	}

[Severity: Medium]
On the timeout path the descriptor is still marked AVAIL, i.e. owned by
the device, but next_to_clean is force-synced to next_to_use and the
mailbox TX queue is left enabled with no reset.  The -ESHUTDOWN early
return leaves next_to_clean behind next_to_use with a device-owned
descriptor outstanding.

nbl_chan_update_txqueue() then republishes slots with no producer /
consumer fullness or ownership test:

	struct nbl_chan_tx_desc *tx_desc =
		NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_use);
	struct nbl_chan_buf *tx_buf =
		NBL_CHAN_TX_RING_TO_BUF(txq, txq->next_to_use);
	...
		if (param->arg)
			memcpy(tx_buf->va, param->arg, param->arg_len);
	...
	tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));

After NBL_CHAN_QUEUE_LEN further sends the ring wraps onto that slot.
Can this rewrite a descriptor and its coherent tx_buf while the device
is still fetching or DMAing them?  Would quiescing the queue with
stop_mailbox_txq() (or rolling tail_ptr back) on the timeout path, plus
a fullness check in nbl_chan_update_txqueue(), be needed here?

> +
> +	txq->next_to_clean = txq->next_to_use;
> +
> +	return 0;
> +}

[ ... ]

> +static int nbl_chan_get_msg_id(struct nbl_chan_info *chan_info,
> +			       u16 *msgid)
> +{
> +	int search_loc = READ_ONCE(chan_info->wait_head_index), i;
> +	struct nbl_chan_waitqueue_head *wait = NULL;
> +	int status;
> +
> +	lockdep_assert_held(&chan_info->pending_lock);
> +	for (i = 0; i < chan_info->num_txq_entries; i++) {
> +		wait = &chan_info->wait[search_loc];
> +		status = READ_ONCE(wait->status);
> +		if (status == NBL_MBX_STATUS_IDLE ||
> +		    status == NBL_MBX_STATUS_TIMEOUT) {

[Severity: Medium]
Is a slot in NBL_MBX_STATUS_TIMEOUT really free at this point?  The
timed-out owner sets that status under pending_lock and then drops the
lock before it releases the slot:

nbl_chan_send_msg()
	mutex_lock(&chan_info->pending_lock);
	if (READ_ONCE(wait_head->status) == NBL_MBX_STATUS_WAITING) {
		WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_TIMEOUT);
		...
	}
	mutex_unlock(&chan_info->pending_lock);
	dev_err_ratelimited(...);
	ret = -ETIMEDOUT;
	goto out_clear_wait_slot;

out_clear_wait_slot:
	mutex_lock(&chan_info->pending_lock);
	nbl_chan_reset_wait_head(chan_info, wait_head);

If a second sender claims the same slot in that window, the reset then
clears the new owner's state, since nbl_chan_reset_wait_head() has no
ownership check:

	WRITE_ONCE(wait_head->status, NBL_MBX_STATUS_IDLE);
	WRITE_ONCE(wait_head->ack_data, NULL);
	WRITE_ONCE(wait_head->ack_data_len, 0);

The second sender can then be woken on the shared wait_queue and
consume another request's ack_data_len / ack_err:

		if (READ_ONCE(wait_head->acked)) {
			smp_rmb();
			chan_send->ack_len = READ_ONCE(wait_head->ack_data_len);
			ret = READ_ONCE(wait_head->ack_err);

Can that return success with a non-zero ack_len while chan_send->resp
was never written, so the caller reads uninitialised memory as a
mailbox reply?  Would releasing the slot to IDLE in the same critical
section that sets TIMEOUT, or adding a generation/ownership check in
nbl_chan_reset_wait_head(), close this?

> +			WRITE_ONCE(wait->msg_index,
> +				   NBL_NEXT_ID(wait->msg_index,
> +					       NBL_CHAN_MSG_INDEX_MAX));
> +
> +			*msgid = FIELD_PREP(NBL_CHAN_MSGID_INDEX_MASK,
> +					    wait->msg_index) |
> +				 FIELD_PREP(NBL_CHAN_MSGID_LOC_MASK,
> +					    search_loc);
> +
> +			/* Advance starting search position for next caller */
> +			WRITE_ONCE(chan_info->wait_head_index, search_loc);

[Severity: Low]
The comment says the search position is advanced, but the slot that was
just claimed is stored back, so the next caller starts at the same
index.  Was NBL_NEXT_ID(search_loc, chan_info->num_txq_entries - 1)
intended?

As written, a single sender keeps reusing wait[0], so the 6-bit
generation field NBL_CHAN_MSGID_INDEX_MASK wraps every 64 requests
instead of the msgid space being spread over the 256 slots.  That is
the field nbl_chan_recv_ack_msg() uses to reject stale ACKs:

	if (FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, ack_msgid) != w_msgidx) {

> +			return 0;
> +		}

[ ... ]

> +static void nbl_chan_set_queue_state(struct nbl_channel_mgt *chan_mgt,
> +				     enum nbl_chan_state state, u8 chan_type,
> +				     u8 set)
> +{
> +	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
> +
> +	if (set)
> +		set_bit(state, chan_info->state);
> +	else
> +		clear_bit(state, chan_info->state);
> +}

[Severity: Low]
Clearing NBL_CHAN_IRQ_RDY makes the wait condition in
nbl_chan_send_msg() true:

			ret = wait_event_timeout(wait_head->wait_queue,
						 READ_ONCE(wait_head->acked) ||
						 READ_ONCE(chan_info->shutdn) ||
						 !test_bit(NBL_CHAN_IRQ_RDY,
							   chan_info->state),
						 NBL_CHAN_ACK_WAIT_TIME);

but no wake_up() of the per-slot wait queues follows the clear_bit().
Should the waiters be woken here?  Otherwise a sleeping sender only
notices the mode change when the 3 s timeout expires and then reports
-ETIMEDOUT rather than the -EIO the !test_bit() branch is meant to
return.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> new file mode 100644
> index 000000000000..e6d96768a5b5
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> @@ -0,0 +1,170 @@

[ ... ]

> +#define NBL_CHAN_TX_WAIT_ACK_US_MIN		1000
> +#define NBL_CHAN_TX_WAIT_ACK_US_MAX		1200
> +#define NBL_CHAN_TX_WAIT_ACK_TIMES		5000

[ ... ]

> +#define NBL_CHAN_MSG_INDEX_MAX 63
> +
> +#define NBL_CHAN_MSGID_INDEX_MASK GENMASK(5, 0)
> +#define NBL_CHAN_MSGID_LOC_MASK GENMASK(13, 6)

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index a67d1a674466..24b15418e601 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -10,6 +10,156 @@
>  #include <linux/bitfield.h>
>  #include "nbl_hw_leonis.h"
>  
> +static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
> +				  const u32 *data, u32 len)
> +{
> +	u32 i;
> +
> +	if (len % 4)
> +		return;
> +	if (reg >= (u64)hw_mgt->mailbox_bar_size ||
> +	    reg + len > (u64)hw_mgt->mailbox_bar_size) {
> +		dev_err_once(hw_mgt->common->dev,
> +			     "mbx write out of range: reg=0x%llx len=%u bar_size=%pa\n",
> +			     reg, len, &hw_mgt->mailbox_bar_size);
> +		return;
> +	}
> +	for (i = 0; i < len / 4; i++)
> +		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), data[i]);
> +}
> +
> +static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
> +				u32 len)
> +{
> +	u32 size = len / 4;
> +	u32 i;
> +
> +	if (len % 4)
> +		return;
> +
> +	spin_lock(&hw_mgt->reg_lock);
> +
> +	for (i = 0; i < size; i++)
> +		data[i] = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
> +	spin_unlock(&hw_mgt->reg_lock);
> +}

[Severity: Low]
The changelog says:

    - Add register lock protection for hardware register read/write to
    ensure concurrent access safety

Does that cover the mailbox path?  Only nbl_hw_rd_regs_lock() and
nbl_hw_wr_regs_lock() take hw_mgt->reg_lock.  nbl_hw_write_mbx_regs()
above takes no lock, and it is the only writer used by
config_mailbox_rxq/txq and stop_mailbox_rxq/txq for the four dword
QINFO configuration sequence, which looks like it wants to be one
atomic programming step.  nbl_hw_update_mailbox_queue_tail_ptr() is
also unlocked.  Should the changelog be narrowed, or should the mailbox
BAR helpers take the same lock?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> index 5e9823e01d39..35604bdff2ae 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h

[ ... ]

> +static inline void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
> +{
> +	/* Used for emu, make sure that we won't write too frequently */
> +	wr32(hw_mgt->hw_addr, reg, value);
> +}

[Severity: Low]
The comment promises rate limiting, but the body is a plain writel()
with no delay or throttling.  Should the comment be dropped?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index ecbf440e4366..587ac0c58c24 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> @@ -10,6 +10,39 @@

[ ... ]

> +	/**
> +	 * get_host_pf_mask - Fetch host PF mask from firmware k_pf_mask reg
> +	 * @priv: hw ops private context
> +	 * @pf_mask: output pointer for PF mask value

[Severity: Low]
The documented member has no priv parameter:

	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);

kernel-doc will report an excess parameter priv and a missing hw_mgt.
Should the tag be renamed to @hw_mgt?

[ ... ]

> +	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
