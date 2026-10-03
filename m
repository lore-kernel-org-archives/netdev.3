Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2443B52F4
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070518; cv=none; b=RkBCH7L+p0doL940QTH6udxrHEOGDiNOd4LxQ5OOsLhadfuDdWRzBbnIvSmU2olh24iD2DaN4E2TxSVHV791d1/W3TOh2mNsDJJULhZsCZNJx/J/zuwBWD33l5JbSiixwlsQLtjjiyTEhLcNvh+gViranDtJS0Ra8UZIME/36+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070518; c=relaxed/simple;
	bh=JypSIAm/BrMzKfG3PFQSftEvrtIDTVPeF1f1QIsppuo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzrN7lxwubYAfTnQSj0PusPuKTRfqCtfE3xE1punsDO2/0f8UPpkrW43LtdhK6XXzqKnOugkMZL5sPZ8Ew6oLhxZ5Ag5e+qGPS02/pH7mIoQnZrBHExGf8wX2SYuv6+vN3f54EKGtfgsiPT/hOpWKDQDScdJw7NsBQi/EQ7E2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUUmwJqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUUmwJqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D15D1F0089B;
	Sat,  3 Oct 2026 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791070516;
	bh=JmcxrfEeW10z2CzRG/D20dWfokHmttRkMCqRTH+Cjek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bUUmwJqWAwSjQ2bohzYY6AN/Q3Nky39FtPVwQhDPVwZFFUGkAqwyUSeOjZXZxWE4l
	 0BaMG+kndnFsm6+7rDLzAEyMHEAFnTk7OOA8dDjN17/JHFLaikphlAGXmvyipLCFnt
	 MZuc/Kr7vlmTso9Ld6K/tm8A/O8qv0S5zPOMibd1sTtiBSALxa8K+rdcxmgU2XqyAN
	 LudP7kSfz0SeDcws7XpVinfUzuFSOSVp8vt/NuhFxVNdPr697eva/qZbXidUiuRgKh
	 vHgrPo3e1rpF+tJddSVTxL96LyVIRHM8HCBS19htYDgUOHyJTSrDRP6dq9QlUadZlg
	 tGqOIN1NnuzfQ==
Subject: Re: [PATCH net-next 1/2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 boolli@google.com, aleksander.lobakin@intel.com, sridhar.samudrala@intel.com,
 emil.s.tantilov@intel.com, decot@google.com, brianvv@google.com,
 aleksandr.loktionov@intel.com, Samuel.salin@intel.com
Date: Sat, 03 Oct 2026 23:35:14 +0000
Message-ID: <179107051461.434549.11114177164296812377@kernel.org>
In-Reply-To: <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
References: <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 1 · High: 2 · Medium: 3 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Flow-based (FB) XDP completion can release descriptors that
  were never sent to the hardware.
- [High] idpf_xdpsq_poll_fb() cannot handle a completely full ring.
- [High] The FB XDP path gives each descriptor its own compl_tag (the
  ring index i) and sets EOP only on the LIBETH_XDP_TX_LAST descriptor.
- [Medium] In FB mode, XDP SQs now keep FLOW_SCH_EN set:
  idpf_xdpsqs_get() calls idpf_queue_assign(FLOW_SCH_EN, xdpsq,…
- [Medium] The patch moves cached_tstamp_caps and tstamp_task into the
  skb-only arm of the union in struct idpf_tx_queue.
- [Medium] idpf_xdpsqs_put() decides whether to call
  static_branch_dec(&idpf_xdp_fb) only from vport->xdpsq_fb, not from…
- [Low] The commit message says XDP "doesn't work there at all" on
  firmware without Tx FIFO (QB) support.
- [Low] idpf_xdpsqs_get() mixes scope-based cleanup with goto-based
  cleanup.
- [Low] idpf_xdp_tx_xmit_fb() writes desc.len (a u32) into the flow
  descriptor's rxr_bufsize with no masking and no length check:…
- [Low] The kernel-doc for idpf_xdp_tx_finalize() in
  drivers/net/ethernet/intel/idpf/xdp.h still says "Set the RS bit…
- [Low] idpf_xdpsq_poll_fb() uses the 16-bit completion tag from a
  device-written CQE (idpf_xdp_parse_cqe() returns upper_16_bits(val))…

--

idpf: add flow-based XDP fallback for FWs without Tx FIFO support

This adds a fallback for XDP Tx queues that uses flow-based scheduling. It
applies to firmware that does not advertise VIRTCHNL2_CAP_SPLITQ_QSCHED,
and it is guarded by a static key. Completions can arrive out of order, so
each queue tracks them in a bitmap and reports contiguous blocks of
completed descriptors back to libeth XDP/XSk.

> basically means simple FIFO. However, turned out not every firmware
> supports this mode and XDP doesn't work there at all.

[Severity: Low]
The previous idpf_xdpsqs_get() always did
idpf_queue_clear(FLOW_SCH_EN, ...) on XDP SQs, whatever
VIRTCHNL2_CAP_SPLITQ_QSCHED said. That makes this read like a fix for XDP
being broken on such firmware.

Should this carry a Fixes: tag for the commit that added the QB-only XDP
SQ setup? Or is it meant only as a net-next feature?

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 885df6294ad94..1f989fe476b1a 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -227,7 +227,7 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
>  
>  	idpf_xsk_setup_queue(vport, tx_q, VIRTCHNL2_QUEUE_TYPE_TX);
>  
> -	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
> +	if (!idpf_queue_has(FLOW_SCH_EN, tx_q) || idpf_queue_has(XDP, tx_q))
>  		return 0;

[Severity: Medium]
The refillq setup is now skipped for XDP SQs. What about the tx_buf
allocation earlier in this same function?

In FB mode, idpf_xdpsqs_get() now leaves FLOW_SCH_EN set on XDP SQs.
idpf_vport_queues_alloc() calls idpf_xdpsqs_get() before
idpf_tx_desc_alloc_all(). So idpf_tx_desc_alloc()->idpf_tx_buf_alloc_all()
takes the flow scheduling branch:

idpf_tx_buf_alloc_all() {
	if (idpf_queue_has(FLOW_SCH_EN, tx_q))
		tx_q->buf_pool_size = U16_MAX;
	else
		tx_q->buf_pool_size = tx_q->desc_count;
	tx_q->tx_buf = kzalloc_objs(*tx_q->tx_buf, tx_q->buf_pool_size);
	...
}

XDP only uses tx_buf[0] to tx_buf[desc_count - 1], because compl_tag is
the ring index. Does this allocate about 3 MB of physically contiguous
memory (65535 * sizeof(struct libeth_sqe)) for each XDP SQ? There is
usually one XDP SQ per CPU.

If that high-order allocation fails, vport open or soft reset fails with
-ENOMEM. idpf_tx_buf_clean() also walks all 65535 entries at teardown.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index fe0c913f9bb95..37b9beccc0185 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h

[ ... ]

> @@ -695,6 +697,9 @@ struct idpf_tx_queue {
>  			u16 cleaned_pkts;
>  
>  			struct idpf_sw_queue *refillq;
> +
> +			struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
> +			struct work_struct *tstamp_task;
>  		};
>  		struct {
>  			u32 pending;
> @@ -702,12 +707,12 @@ struct idpf_tx_queue {
>  
>  			struct libeth_xdpsq_timer *timer;
>  			struct libeth_xdpsq_lock xdp_lock;
> +
> +			unsigned long *pending_mask;
> +			u32 last_ntu;
>  		};
>  	};
>  
> -	struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
> -	struct work_struct *tstamp_task;
> -
>  	struct u64_stats_sync stats_sync;
>  	struct idpf_tx_queue_stats q_stats;
>  	__cacheline_group_end_aligned(read_write);

[Severity: Medium]
cached_tstamp_caps and tstamp_task are now in the skb-only arm of the
union. Is it still safe for idpf_vport_init_fast_path_txqs() to write them
on every Tx queue, XDP SQs included?

idpf_vport_init_fast_path_txqs() {
	...
		for (unsigned int j = 0; j < tx_grp->num_txq; j++, k++) {
			vport->txqs[k] = tx_grp->txqs[j];
			vport->txqs[k]->idx = k;

			if (!caps)
				continue;

			vport->txqs[k]->cached_tstamp_caps = caps;
			vport->txqs[k]->tstamp_task = tstamp_task;
		}
	...
}

This runs before idpf_xdpsqs_get(). On 32-bit SMP builds without spinlock
debugging, cached_tstamp_caps seems to sit at the same offset as
xdp_lock.share.

idpf_xdpsqs_get() only clears refillq, which overlaps the spinlock.
libeth_xdpsq_get(..., false) never writes share. So share keeps the low
byte of the caps pointer.

Suppose another user has enabled the global libeth_xdpsq_share key. Would
libeth_xdpsq_put() then call __libeth_xdpsq_put() and do a
static_branch_dec() for a reference that was never taken? That could turn
off locking for another device's shared XDPSQs.

> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index cbccd45467681..c771663677a52 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c

[ ... ]

> @@ -149,10 +151,12 @@ void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_vec_rsrc *rsrc,
>  
>  static void idpf_xdp_tx_timer(struct work_struct *work);
>  
> -int idpf_xdpsqs_get(const struct idpf_vport *vport)
> +int idpf_xdpsqs_get(struct idpf_vport *vport)
>  {
>  	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
> -	struct net_device *dev;
> +	unsigned long **masks __free(kvfree) = NULL;
> +	const struct net_device *dev;
> +	bool warn;
>  	u32 sqs;
>  
>  	if (!idpf_xdp_enabled(vport))
> @@ -176,6 +180,34 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
>  	dev = vport->netdev;
>  	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
>  
> +	vport->xdpsq_fb = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
> +					   VIRTCHNL2_CAP_SPLITQ_QSCHED);
> +	if (!vport->xdpsq_fb)
> +		goto setup;
> +
> +	masks = kvzalloc_objs(*masks, vport->num_xdp_txq);
> +	if (!masks)
> +		goto err_masks;

[ ... ]

> @@ -197,12 +229,25 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
>  		xdpsq->pending = 0;
>  		xdpsq->xdp_tx = 0;
>  		xdpsq->thresh = libeth_xdp_queue_threshold(xdpsq->desc_count);
> +
> +		if (static_branch_unlikely(&idpf_xdp_fb) && vport->xdpsq_fb) {
> +			xdpsq->pending_mask = masks[i - sqs];
> +			xdpsq->last_ntu = 0;
> +		}
>  	}
>  
>  	return 0;
> +
> +err_masks:
> +	vport->xdpsq_fb = false;
> +
> +	for (u32 i = 0; i < vport->num_xdp_txq; i++)
> +		kfree(timers[i]);
> +
> +	return -ENOMEM;
>  }

[Severity: Low]
This isn't a bug on the current paths, but idpf_xdpsqs_get() now mixes
__free(kvfree) on the timers and masks arrays with goto setup, goto
err_masks and a manual cleanup label for timers[i]. The cleanup.h guidance
is not to mix goto-based and scope-based cleanup in one function.

Could this be restructured so the array elements are freed in one place?

[ ... ]

> @@ -222,10 +267,23 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport)

[ ... ]

>  		kfree(xdpsq->timer);
>  		xdpsq->refillq = NULL;
>  		idpf_queue_clear(NOIRQ, xdpsq);
>  	}
> +
> +	if (!vport->xdpsq_fb)
> +		return;
> +
> +	static_branch_dec(&idpf_xdp_fb);
> +	vport->xdpsq_fb = false;
>  }

[Severity: Medium]
Can this static_branch_dec() run without a matching static_branch_inc()?

The decision depends only on vport->xdpsq_fb. idpf_initiate_soft_reset()
copies the vport into new_vport while FB XDP SQs are live, so the copy has
xdpsq_fb == true. The sequence is then:

idpf_initiate_soft_reset()
  idpf_vport_stop()
    idpf_vport_queues_rel()
      idpf_xdpsqs_put()        <- dec, xdpsq_fb = false
  memcpy(vport, new_vport, offsetof(struct idpf_vport, link_up))
                               <- xdpsq_fb is true again
  idpf_vport_open()
    idpf_vport_queues_alloc()
      <fails before xdpsq_fb is recomputed, for example the
       timers allocation in idpf_xdpsqs_get() returns -ENOMEM>
      idpf_vport_queues_rel()
        idpf_xdpsqs_put()      <- dec again with no inc

The fresh queues don't have the XDP flag, so the per-queue loop is
skipped, but the key is still decremented.

idpf_xdp_fb is module-global. Could this underflow the key? Could it also
drop the key to zero while another vport still has FB XDP SQs? Those
queues would then take the QB branches in idpf_xdp_tx_xmit(),
idpf_xdpsq_set_rs() and idpf_xdpsq_poll().

> @@ -250,6 +308,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
>  	return upper_16_bits(val);
>  }
>  
> +static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
> +{
> +	struct idpf_compl_queue *cq = xdpsq->complq;
> +	unsigned long *mask = xdpsq->pending_mask;
> +	u32 done_frames, tx_cnt, new_ntc;
> +	u32 ntc = cq->next_to_clean;
> +	u32 cnt = cq->desc_count;
> +	bool gen;
> +
> +	gen = idpf_queue_has(GEN_CHK, cq);
> +
> +	for (done_frames = 0; done_frames < budget; ) {
> +		int ret;
> +
> +		ret = idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
> +		if (ret >= 0) {
> +			__clear_bit(ret, mask);

[Severity: Low]
Should ret be checked against xdpsq->desc_count before it is used as a bit
index here?

idpf_xdpsqs_get() allocates pending_mask with only desc_count bits, but
the completion tag from the CQE can be any 16-bit value. An unexpected tag
from the device would clear a bit outside the bitmap.

> +			done_frames++;
> +
> +			goto next;
> +		}

[ ... ]

> +out:
> +	cq->next_to_clean = ntc;
> +
> +	if (unlikely(!done_frames))
> +		return 0;
> +
> +	tx_cnt = xdpsq->desc_count;
> +
> +	/* Don't go past next_to_use */
> +	__set_bit(xdpsq->next_to_use, mask);
> +
> +	new_ntc = find_next_bit(mask, tx_cnt, xdpsq->next_to_clean);
> +	done_frames = new_ntc - xdpsq->next_to_clean;

[Severity: Critical]
Can this report descriptors as completed when they were never posted to
the hardware?

Only idpf_xdpsq_set_rs_fb(), called from idpf_xdp_tx_finalize(), sets
pending_mask bits. libeth_xdp_tx_xmit_bulk() advances next_to_use and
pending, then drops the lock without finalizing.

On the Rx NAPI path, finalize runs once at the end of the poll, possibly
after several bulk flushes. So in the middle of a poll, the range
[last_ntu, next_to_use) has been written but is not marked in the bitmap
and has not been posted to the tail.

A later flush in the same poll goes through idpf_xdp_tx_prep():

	free = xdpsq->desc_count - xdpsq->pending;
	if (free < xdpsq->thresh)
		free += idpf_xdpsq_complete(xdpsq, xdpsq->thresh);

If everything in [next_to_clean, last_ntu) has completed, find_next_bit()
skips over the zero bits of the unposted window. It stops at the stop bit
at next_to_use and returns next_to_use - next_to_clean.

idpf_xdpsq_complete() then runs libeth_xdp_complete_tx() on those SQEs.
That recycles XDP_TX pages, returns xdp_frames, unmaps ndo_xdp_xmit DMA
and completes XSk frames. It also moves next_to_clean and pending past
them.

The finalize that follows marks the range pending and bumps the tail. The
NIC then DMAs from buffers that were already released, and the slots can
be reused while the hardware still owns them.

Should the stop bit be at last_ntu, the boundary actually handed to the
hardware, instead of next_to_use?

> +
> +	if (new_ntc == tx_cnt)
> +		done_frames += find_first_bit(mask, tx_cnt);
> +
> +	__clear_bit(xdpsq->next_to_use, mask);

[Severity: High]
What happens here when the ring is completely full and next_to_use equals
next_to_clean?

idpf_xdp_tx_prep() returns free = desc_count - pending and keeps no slot
in reserve, and libeth_xdp_tx_xmit_bulk() uses all of it:

	n = min(n, prep(xdpsq, &sq));

So if completion returns 0 while 0 < free < bulk size, pending can reach
desc_count. From then on, the stop bit lands on next_to_clean,
find_next_bit() returns next_to_clean, and done_frames is 0.

The __clear_bit(xdpsq->next_to_use, mask) above also clears the pending
bit of the descriptor at next_to_clean, which may still be in flight.
Every later poll returns 0, next_to_clean never moves, and free stays at 0.

Does this stall XDP_TX, redirect and XSk Tx on the queue until the queue
is reset?

The QB idpf_xdpsq_poll() handles this case explicitly (ret == tx_ntc gives
tx_cnt), but the FB variant does not seem to.

> +
> +	return done_frames;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
> index 63e56f7d43e00..95e47ea2ccba8 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h

[ ... ]

> +static inline void idpf_xdp_tx_xmit_fb(struct libeth_xdp_tx_desc desc, u32 i,
> +				       const struct libeth_xdpsq *sq, u64 priv)
> +{
> +	struct idpf_flex_tx_sched_desc *tx_desc = sq->descs;
> +	u32 cmd;
> +
> +	cmd = FIELD_PREP(IDPF_TXD_FLEX_FLOW_DTYPE_M,
> +			 IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE);
> +	if (desc.flags & LIBETH_XDP_TX_LAST)
> +		cmd |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
> +	if (priv && (desc.flags & LIBETH_XDP_TX_CSUM))
> +		cmd |= IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
> +
> +	tx_desc = &tx_desc[i];
> +	tx_desc->buf_addr = cpu_to_le64(desc.addr);
> +
> +#ifdef __LIBETH_WORD_ACCESS
> +	*(u64 *)&tx_desc->qw1 = ((u64)desc.len << 48) | ((u64)i << 32) | cmd;
> +#else
> +	tx_desc->qw1.rxr_bufsize = cpu_to_le16(desc.len);

[Severity: Low]
Should desc.len be masked with IDPF_TXD_FLEX_FLOW_BUFSIZE_M here and in
the __LIBETH_WORD_ACCESS variant above? rxr_bufsize holds only 14 bits of
size, and bit 14 is IDPF_TXD_FLEX_FLOW_RXR:

	__le16 rxr_bufsize;
#define IDPF_TXD_FLEX_FLOW_RXR		BIT(14)
#define IDPF_TXD_FLEX_FLOW_BUFSIZE_M	GENMASK(13, 0)

A buffer of 16K or more would set RXR or bit 15. It is not clear that XDP
or XSk can pass such a buffer to this path, so this may not be reachable
today.

> +	tx_desc->qw1.compl_tag = cpu_to_le16(i);

[Severity: High]
How are multi-buffer frames completed in this mode?

Each descriptor gets its own compl_tag, the ring index i, and only the
LIBETH_XDP_TX_LAST descriptor has EOP set. idpf_xdpsq_poll_fb() clears
exactly one pending_mask bit per RS completion.

The existing flow scheduling skb path seems to assume one RS completion
per packet. idpf_tx_splitq_frame() sets tx_params.compl_tag = buf_id once
per packet, and that tag goes into every descriptor of the packet.
idpf_tx_handle_rs_completion()->idpf_tx_clean_bufs() then cleans the whole
buffer chain from a single completion.

idpf_xdp_set_features() still advertises multi-buffer Tx through
libeth_xdp_set_features_noredir(..., idpf_get_max_tx_bufs(), ...) in
every scheduling mode.

For a frame of N descriptors, would N-1 bits stay set forever? If so,
find_next_bit() stops at the first stuck bit and XDP/XSk Tx on that queue
hangs permanently.

The commit message says "The FB mode generates a completion for each Tx
descriptor". Does that also hold for descriptors without EOP?

> +	tx_desc->qw1.ts[0] = 0;

[ ... ]

> @@ -84,7 +146,8 @@ static inline void idpf_xdpsq_update_tail(const struct idpf_tx_queue *xdpsq)
>   * Set the RS bit ("end of batch"), bump the tail, and queue the cleanup timer.
>   * To be called after a NAPI polling loop, at the end of .ndo_xdp_xmit() etc.
>   */
> -static inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent, bool flush)
> +static __always_inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent,
> +						 bool flush)
>  {
>  	struct idpf_tx_queue *xdpsq = _xdpsq;

[Severity: Low]
This isn't a bug, but the kernel-doc still says this sets the RS bit. In
FB mode, idpf_xdpsq_set_rs() returns early through idpf_xdpsq_set_rs_fb(),
which only updates pending_mask and last_ntu.

Could the comment be updated to cover the FB case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929231305.1515873-1-anthony.l.nguyen%40intel.com
