Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938873EF0D3;
	Fri, 11 Sep 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098109; cv=none; b=uWn45HynRYbMJB2IGxiJ2XjAiXitUCVz90KxmcqqDlvZu4blUSmfM2D8SYMY/9W1J+XnJ1SUlkY1D0Yc+E3rgID2zh+2Yt3Kq92eHIySghoxAJBXjDTfhHE0oJ3siXPQDj5B5BOT0s71bDyxMDlXZ6cPP6eDqpXfNJry+q3V66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098109; c=relaxed/simple;
	bh=+GA/2k2nsBNp//R5tgVMewp7rjktNMjV7PfWt3LhZx4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLnhQwngbO004KL0i8yxP0p5ZwVrZTqw3jKTddNyGuH0RYiiFMeaa5UMsIJBbEfEsfiexPjSuep0hJMQLh6LgPZnlqEgEgygDSPinPrw/U2zryRrHCkx1hjQmn2Infki8j0vEfNrEgb2KYRpeIpiZ8AARk6YY5jLPMn2lBf5qbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFe6bMlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFe6bMlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590791F000FF;
	Fri, 11 Sep 2026 03:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098107;
	bh=5BSjft3i4y3jWfafXI1flGf0Xh6nrttiHGDbj+PFSdw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NFe6bMlwP/v+ZGxKfA6tlBAdQuNbLFj9+ERZnCAEsVy+I9ZRGs/0l3nqL+ptr64CC
	 /lO2UggMy3fukMR1qJg9m3sdL9fkoeXdZV4Rev1J5gURLvox8vET90Gp+GhqmduQ2R
	 d2h1L9V08jNN+zjtXj6kHt3LEBskXPCjeU5PICB0LSDdjsEt55QQNWDcGPWZ+KDlkU
	 eJ5z5CmoCkZIHy4sBO38OmijQQjpYot2uI506VQ+5L3Ba0vcXZm2PreYAVRK/AjbZp
	 IJQUX2xACAfG2IqgXJ9zheAtLFSuq1jocerZ8XrGZSQIxU27fkeQ0mW3wBBltXLIEv
	 sQ1ZlN1HI8fSw==
Subject: Re: [PATCH v27 net-next 03/10] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:45 +0000
Message-ID: <178909810593.219967.8709638663166999561@kernel.org>
In-Reply-To: <20260907123848.30256-4-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-4-illusion.wang@nebula-matrix.com>
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

Critical: 0 · High: 1 · Medium: 4 · Low: 7

- [High] nbl_chan_quiesce_and_reclaim_tx() (TX timeout recovery) resets
  the software doorbell counter txq->tail_ptr to 0 to match the…
- [Medium] The commit message justifies leaving the mailbox BAR2 register
  path unlocked by asserting that the multi-dword QINFO config sequences…
- [Medium] nbl_chan_recv_ack_msg() completes a request slot (copies the
  response, sets wait_head->acked = 1) but never transitions…
- [Medium] nbl_chan_quiesce_and_reclaim_tx() uses wmb() with the comment
  "Ensure reset write is posted before reclaiming descriptors" and then…
- [Medium] nbl_hw_cfg_mailbox_qinfo() builds the QINFO map dword from
  scratch (FUNCTION/DEVID/BUS only) and writes it, unconditionally…
- [Low] Concern (verified FALSE POSITIVE): nbl_chan_send_msg() never
  checks chan_info->active, so a send issued before…
- [Low] Concern (verified FALSE POSITIVE): nbl_chan_teardown_queue()
  frees nothing but clears chan_info->active, so a subsequent…
- [Low] Concern (verified FALSE POSITIVE): the commit message advertises
  working capabilities (dual RX modes, complete queue lifecycle, PF…
- [Low] Concern (verified FALSE POSITIVE): nbl_common_get_hash_node()
  returns hash_node->data after dropping the per-bucket spinlock while…
- [Low] Concern (verified FALSE POSITIVE): setup_queue/teardown_queue
  check and modify chan_info->active, shutdn, the state bitmap,…
- [Low] Concern (verified FALSE POSITIVE): nbl_chan_update_txqueue()
  accepts arg_len > 0 with arg == NULL; in the external-buffer branch it…
- [Low] Concern (verified FALSE POSITIVE): nbl_chan_remove_common()
  destroys the workqueue and frees the handler table but never tears…

--

net/nebula-matrix: add channel layer

This adds the mailbox-based inter-PF channel layer for the Nebula Matrix
adapter, including the TX/RX descriptor ring management, a hash table of
message handlers, and the hardware ops that program the mailbox QINFO
tables and the tail pointer doorbell.

A few questions about the TX timeout recovery path, the ACK completion
handshake, and the QINFO map table write.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..879e7bab14e94
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c

[ ... ]

> +static int nbl_chan_alloc_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
> +				      struct nbl_chan_info *chan_info)
> +{

[ ... ]

> +	txq->next_to_clean = 0;
> +	txq->next_to_use = 0;
> +	txq->tail_ptr = 0;
> +
> +	return 0;
> +}

[ ... ]

> +static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
> +				   struct nbl_chan_info *chan_info,
> +				   struct nbl_chan_tx_param *param)
> +{

[ ... ]

> +	/* Ensure descriptor data visible to device before AVAIL flag */
> +	dma_wmb();
> +	tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));
> +
> +	txq->next_to_use =
> +		NBL_NEXT_ID(txq->next_to_use, chan_info->num_txq_entries - 1);
> +	txq->tail_ptr++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Quiesce the TX mailbox queue and reclaim all outstanding
> + * descriptors.  Called from the timeout path of nbl_chan_kick_tx_ring()
> + * with txq_lock held.
> + *
> + * The device failed to fetch/complete the current descriptor within the
> + * polling window.  We assert QUEUE_RST to stop further DMA fetches,
> + * reclaim every descriptor between next_to_clean and next_to_use,
> + * reset the software tail_ptr counter to match the hardware reset state,
> + * and re-enable the queue so subsequent sends can proceed.
> + */
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
> +	/* Ensure reset write is posted before reclaiming descriptors */
> +	wmb();

[Severity: Medium]
Does this wmb() actually guarantee the posted QUEUE_RST write has reached
the device before the descriptor flags below are rewritten?

writel() already contains the MMIO ordering barriers (__io_bw() and
__io_aw() in include/asm-generic/io.h), so the extra wmb() adds nothing
with respect to the device.  nbl_hw_stop_mailbox_txq() only performs
posted BAR2 writes with no read-back, and nbl_chan_config_queue() below
de-asserts RST and sets EN in the immediately following writes:

	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);

The QINFO_CFG layout added in this patch exposes RST/EN/DIF_ERR/PTR_ERR
but no reset-done bit, and nothing reads the register back.

Would a read from the same BAR, or a device status poll, be needed before
mutating descriptors the device may still own and before re-enabling the
queue?

> +
> +	/*
> +	 * Reclaim all outstanding descriptors between next_to_clean and
> +	 * next_to_use.  Under txq_lock there is at most one in-flight
> +	 * descriptor, but iterate the full range for robustness.
> +	 */
> +	while (txq->next_to_clean != txq->next_to_use) {
> +		tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq,
> +						   txq->next_to_clean);
> +		WRITE_ONCE(tx_desc->flags, 0);
> +		txq->next_to_clean =
> +			NBL_NEXT_ID(txq->next_to_clean,
> +				    chan_info->num_txq_entries - 1);
> +	}
> +
> +	/*
> +	 * Hardware tail_ptr counter is cleared by QUEUE_RST.  Reset
> +	 * software counter to match so the next doorbell update does
> +	 * not produce a false 16-bit wrap delta.
> +	 */
> +	txq->tail_ptr = 0;

[Severity: High]
tail_ptr is reset to 0 here, but next_to_use and next_to_clean keep their
pre-timeout values.  Can this leave the ring index and the doorbell
counter permanently out of step?

Everywhere else the two advance together:

nbl_chan_alloc_all_tx_bufs():
	txq->next_to_clean = 0;
	txq->next_to_use = 0;
	txq->tail_ptr = 0;

nbl_chan_update_txqueue():
	txq->next_to_use =
		NBL_NEXT_ID(txq->next_to_use, chan_info->num_txq_entries - 1);
	txq->tail_ptr++;

After a timeout on slot X the reclaim loop above leaves
next_to_use == next_to_clean == X + 1 while tail_ptr == 0.

The next send then writes descriptor X + 1 and rings the doorbell with
tail_ptr == 1.  If QUEUE_RST cleared the hardware fetch pointer as the
comment states, the device looks at slot 0, whose flags the reclaim loop
just zeroed, while nbl_chan_kick_tx_ring() polls descriptor X + 1 for
NBL_CHAN_TX_DESC_USED, times out again and re-enters this same recovery.
Would that make every subsequent nbl_chan_send_msg() return -ETIMEDOUT?

And if QUEUE_RST does not clear the hardware counter, does writing
tail_ptr = 0 produce exactly the bogus 16-bit delta the comment is trying
to avoid?

Should next_to_use and next_to_clean be reset to 0 here as well?

> +
> +	/* Re-enable queue with current ring base and size */
> +	nbl_chan_config_queue(chan_mgt, chan_info, true);
> +}

[Severity: Medium]
The commit message states:

  Mailbox BAR2 register access is intentionally left unlocked: single
  dword mailbox writes are atomic, and the multi-dword QINFO config
  sequence (config_mailbox_txq/rxq, stop_mailbox_txq/rxq) only runs
  during queue setup/teardown when chan_info->active is false, with no
  concurrent producers.

Does this recovery path match that description?  It issues
stop_mailbox_txq() and config_mailbox_txq() at runtime from the send
path, and chan_info->active is only cleared at the very end of
nbl_chan_teardown_queue(), so active is true throughout.

Related to that, nbl_chan_teardown_queue() calls nbl_chan_stop_queue()
without taking txq_lock, and it does so even when the drain times out:

	if (!ret) {
		dev_warn(chan_mgt->common->dev,
			 "teardown: inflight tx drain timeout\n");
		ret = -ETIMEDOUT;
	}
	...
	/* After all TX drained, stop hardware queue */
	nbl_chan_stop_queue(chan_mgt);

Can teardown's 4-dword QINFO sequence then interleave with a sender still
executing the stop + config sequence above, leaving QUEUE_EN=1 on a ring
the driver considers torn down?

> +
> +static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = chan_mgt->common->dev;
> +	int max_retries = NBL_CHAN_TX_WAIT_TIMES;
> +	struct nbl_chan_tx_desc *tx_desc;
> +	int retry_count = 0;
> +	u16 msg_type;
> +
> +	nbl_chan_update_tail_ptr(hw_ops, chan_mgt->hw_ops_tbl->priv,
> +				 txq->tail_ptr, NBL_MB_TX_QID);
> +
> +	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);

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
> +		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
> +	}
> +
> +	txq->next_to_clean = txq->next_to_use;
> +
> +	return 0;
> +}

[ ... ]

> +static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
> +				  u32 data_len)
> +{

[ ... ]

> +	if (w_status != NBL_MBX_STATUS_WAITING) {
> +		mutex_unlock(&chan_info->pending_lock);
> +		dev_err_ratelimited(dev,
> +				    "Skip ack invalid status, wait msgtype:%u idx:%u status:%d ack msgtype:%u msgid:%u datalen:%u\n",
> +				    w_msgtype, w_msgidx, w_status,
> +				    ack_msgtype, ack_msgid, ack_datalen);
> +		return;
> +	}

[ ... ]

> +ack_done:
> +	/* Guarantee payload data finished before acked flag visible */
> +	smp_wmb();
> +	WRITE_ONCE(wait_head->acked, 1);
> +	mutex_unlock(&chan_info->pending_lock);
> +	wake_up(&wait_head->wait_queue);
> +}

[Severity: Medium]
This completes the slot by setting acked = 1 but leaves
wait_head->status at NBL_MBX_STATUS_WAITING.  Can that make the timeout
paths in nbl_chan_send_msg() discard a delivered ACK?

The interrupt path tests only status:

	if (ret == 0) {
		mutex_lock(&chan_info->pending_lock);
		if (READ_ONCE(wait_head->status) ==
		    NBL_MBX_STATUS_WAITING) {
			WRITE_ONCE(wait_head->status,
				   NBL_MBX_STATUS_TIMEOUT);
			WRITE_ONCE(wait_head->acked, 0);

So if the RX cleanup work runs the code above in the window between
wait_event_timeout() evaluating its condition for the last time and the
sender taking pending_lock, the sender sees WAITING, clears acked and
returns -ETIMEDOUT for a request that was answered.

The polling path has a similar window: it checks acked, then sleeps
NBL_CHAN_TX_WAIT_ACK_US_MIN..MAX, and after the last iteration falls
straight through to ret = -ETIMEDOUT with no further locked check, so an
ACK arriving during that final ~1 ms sleep is dropped.

Since status also stays WAITING, would a duplicate ACK for the same
msgid still pass all the validation above and memcpy into the requester's
response buffer a second time?

Should the ACK handler move the slot to a completed state (or should the
timeout transitions re-check acked under pending_lock)?

> +
> +static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
> +			     struct nbl_chan_send_info *chan_send)
> +{

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 0ba0b7f643c64..379dbb9dc0034 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -10,6 +10,156 @@

[ ... ]

> +static void nbl_hw_stop_mailbox_txq(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
> +
> +	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
> +	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
> +	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
> +			      cfg_tbl.data, sizeof(cfg_tbl));
> +}
> +
> +static void nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask)
> +{
> +	nbl_hw_rd_regs_lock(hw_mgt, NBL_PCIE_HOST_K_PF_MASK_REG, pf_mask,
> +			    sizeof(*pf_mask));
> +}
> +
> +static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				     u8 bus, u8 devid, u8 function)
> +{
> +	u32 data = 0;
> +
> +	data = FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
> +	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
> +	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);
> +	nbl_hw_wr_regs_lock(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
> +			    &data,
> +			    sizeof(data));
> +}

[Severity: Medium]
This builds the whole dword from FUNCTION/DEVID/BUS and writes it, but
the MSI-X fields share the same dword:

#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK		GENMASK(28, 16)
#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK	BIT(29)

Does this zero the mailbox MSI-X routing of the entries it rewrites?

nbl_chan_cfg_qinfo_map_table() programs an entry for every unmasked PF,
not just the local function:

	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
		if (!(pf_mask & (1 << func_id)))
			hw_ops->cfg_mailbox_qinfo(p, func_id, bus,
						  devid, func_id);
	}

so re-probing one PF would clear MSIX_IDX and MSIX_IDX_VALID for its
already-bound siblings.  Those siblings keep NBL_CHAN_IRQ_RDY set, so
each synchronous send would wait out NBL_CHAN_ACK_WAIT_TIME and fail with
-ETIMEDOUT until they are re-bound.

The commit message also says:

  Add per-hw_mgt reg_lock to protect read-modify-write sequences on the
  general-purpose register BAR (hw_addr, BAR0), such as QINFO map table
  entries and k_pf_mask reads

Where is the read-modify-write on the QINFO map entry?  This helper only
writes.  Should it read the entry first and preserve the MSI-X fields?

> +
> +static struct nbl_hw_ops hw_ops = {
> +	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
> +	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
> +	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
> +	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
> +	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
> +	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
> +	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
> +
> +};

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 1f9e509dc6312..71691e893790e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> @@ -11,5 +11,61 @@

[ ... ]

> +/* MAILBOX qinfo_map_table */
> +#define NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK		GENMASK(2, 0)
> +#define NBL_MAILBOX_QINFO_MAP_DEVID_MASK		GENMASK(7, 3)
> +#define NBL_MAILBOX_QINFO_MAP_BUS_MASK			GENMASK(15, 8)
> +#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK		GENMASK(28, 16)
> +#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK	BIT(29)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
