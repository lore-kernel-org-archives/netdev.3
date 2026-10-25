Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792897496;
	b=BkimFqkF2caY0zss7fFkL8UOAjEWTWjQKdTadlNZ57FsLlIP/pDAJyAXzT3tTqekE3xC
	 FuWBipUtvMJ2izdq7yb61C2b97vrcGKBs9jTY3e1B4xIRxXN6XXOHrqfyR9y7mwflza9z
	 Fiq4iqTUpuT9w5+7AfR/ZLKlWnP3i5wxa/TW8H+LJFsiIdU8S/VQx5N2gD9l/Bl0YT/Uj
	 9YgKt1iPVZ7ee0cVvs463Pyy/vvzLsCbtOXNxjryWGtPsO+s8gyRIjSma8auaMKHQFJwh
	 xBWAhjpdoJRTnqe3+zqLPGVFdX07md4p3jeR6astS7NN4BkLxuKA1OqeZ2tiVuVyejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792897496;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=m/jRo2nTUZb8IscfInKypH1e/pfflNw6ctGifv66KX8=;
	b=EgBTRSx5vU2WGYlj0C2VVAI0RrZThTxjgHzVtsXmoNVev8HhwR3j1LuYAlSXp8hoE+KJ
	 ujmE1kmMJxpMcd0R58bUegpTNV+BVhdUAwqg7cDPDJnvyt3+3VxH/1IU7XaOU/OCgFq/2
	 5zq+HT5WHt8s22PveO56TQW72OUQZwss53GF+OMhcmtnHAxVBhYRx5pR0iL4Hj/ZNwOiH
	 AafoT3MI++f4dsycf+EDRxtuRqAjNxQdTO9WCLS7OjseIHqadyKVPYvuPhfWzh5UDDOiI
	 Vspt9ybX4NkAT9mWo41JtFoulopK0ACSbJ+zB6UT+SU3FQ3r5mxAvLrZlmwHlAd/v3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z38HZRjd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63E606A31A;
	Sun, 25 Oct 2026 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z38HZRjd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A71F01825;
	Sun, 25 Oct 2026 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792897495;
	bh=m/jRo2nTUZb8IscfInKypH1e/pfflNw6ctGifv66KX8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z38HZRjdFbu5rseDBrWWAhA3PNvXL15Xi2fMlej9IXoil4QTJi0zC5NRPM2+yYaOt
	 xtPDIt4fEFIFP5he7rvj21NEJ2wLDeoolHI4V31BQbMzUT4zvplWbJrT0UnBOW5tx5
	 UrVFBEntghaV8LjI08nWUN7B04Iirvd4WIM7N08zBQjPjU32TqGX4jR1jQpmIMLPCB
	 FiQoiDajbdnn8GeDvr+yfHBR3Z3XtHkdw4GU+Fjb0TkB/U+yDZN98mSo8PWVp74LeQ
	 CsdoCPeqfMgWjjg0nI0t7MFILBfiMeq2LmjyMyQQpEBjpKPVpyRStBDkdo5nr4Lssu
	 gwo1CNDKTAycQ==
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, namangulati@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Sun, 25 Oct 2026 03:04:54 +0000
Message-ID: <179289749460.3134.17105687099040790537@kernel.org>
In-Reply-To: <20261024030401.852598-1-almasrymina@google.com>
References: <20261024030401.852598-1-almasrymina@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the skb leak in place for HW-timestamped packets,
  and the Tx timestamp latch they hold is also never released.

Pre-existing issues:
- [Medium] This bug was not introduced by this patch, but in FLOW_SCH_EN
  mode idpf_tx_splitq_frame() increments…

--

idpf: free the skb on TX DMA mapping errors

This commit frees the skb at the end of the TX DMA mapping error unwind
in idpf_tx_splitq_pkt_err_unmap() and idpf_tx_singleq_dma_map_error().
At that point the first buffer is not yet typed LIBETH_SQE_SKB, so
libeth_tx_complete() only unmaps it, and before this change the skb
leaked.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 885df6294ad94..a92e2457781e6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2606,6 +2606,7 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
>  	struct idpf_sw_queue *refillq = txq->refillq;
>  	struct libeth_sq_napi_stats ss = { };
>  	struct idpf_tx_buf *tx_buf = first;
> +	struct sk_buff *skb = first->skb;
>  	struct libeth_cq_pp cp = {
>  		.dev    = txq->dev,
>  		.ss     = &ss,
> @@ -2621,6 +2622,8 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
>  		libeth_tx_complete(tx_buf, &cp);
>  	}
>  
> +	dev_kfree_skb_any(skb);

[Severity: High]
Does this still leak the skb for packets that asked for a HW Tx
timestamp?

idpf_tx_splitq_frame() reserves a timestamp latch before it maps the
packet:

idpf_tx_splitq_frame() {
    ...
	idx = idpf_tx_tstamp(tx_q, skb, &tx_params.offload);
	if (idx != -1) {
		ctx_desc = idpf_tx_splitq_get_ctx_desc(tx_q);
		idpf_tx_set_tstamp_desc(ctx_desc, idx);
	}
    ...
	idpf_tx_splitq_map(tx_q, &tx_params, first);
}

idpf_tx_tstamp()->idpf_ptp_request_ts() then takes a second reference
on the skb and moves the latch to latches_in_use:

idpf_ptp_request_ts() {
    ...
	ptp_tx_tstamp->skb = skb_get(skb);
	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

	/* Move the element to the used latches list */
	list_add(&ptp_tx_tstamp->list_member,
		 &tx_q->cached_tstamp_caps->latches_in_use);
    ...
}

idpf_tx_splitq_map() can then fail in two ways: dma_mapping_error(),
or idpf_tx_get_free_buf_id() failing between fragments in FLOW_SCH_EN
mode. In either case this dev_kfree_skb_any() drops only the xmit
reference. The tail is rewound to params->prev_ntu, so the hardware
never fetches the TSYN context descriptor.

Normally a latch is retired only through the completion path.
idpf_tx_clean_bufs() sees a LIBETH_SQE_SKB buffer with
SKBTX_IN_PROGRESS set and calls idpf_tx_read_tstamp(). After that,
idpf_ptp_get_tx_tstamp() asks firmware about latches in the
IDPF_PTP_REQUEST state.

A packet that went through this unwind never reaches that path. The
only other cleanup is idpf_ptp_release_vport_tstamp() at vport
teardown.

Wouldn't the skb then stay pinned until teardown, along with the socket
wmem charged to it, and one hardware latch per failure? Once every latch
is used up this way, it looks like all later HW Tx timestamp requests
would fail with -ENOBUFS until the vport is torn down.

The refillq exhaustion drop path in idpf_tx_splitq_frame() also runs
after the latch has been reserved. It seems to be missing the same
rollback:

	if (unlikely(!idpf_tx_get_free_buf_id(tx_q->refillq,
					      &buf_id))) {
		...
		tx_q->next_to_use = tx_params.prev_ntu;
		return idpf_tx_drop_skb(tx_q, skb);
	}

Should the unwind also move the latch back to latches_free, clear
SKBTX_IN_PROGRESS, and drop the latch's skb reference?

> +
>  	/* Update tail in case netdev_xmit_more was previously true. */
>  	idpf_tx_buf_hw_update(txq, params->prev_ntu, false);

[Severity: Medium]
This is a pre-existing issue that was not introduced by this patch, but
does this unwind leave num_completions_pending too high?

In FLOW_SCH_EN mode, idpf_tx_splitq_frame() increments the counter and
sets last_re before calling idpf_tx_splitq_map():

	if (idpf_tx_splitq_need_re(tx_q)) {
		tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
		tx_q->txq_grp->num_completions_pending++;
		tx_q->last_re = tx_q->next_to_use;
	}

When mapping fails, the tail is rewound to prev_ntu. The RE descriptor
is never posted, so its completion never arrives. This unwind restores
neither num_completions_pending nor last_re.

When a context descriptor was used, the stale last_re can also make
idpf_tx_splitq_need_re() return true again for the retried packet.

Once IDPF_TX_COMPLQ_PENDING() exceeds IDPF_TX_COMPLQ_OVERFLOW_THRESH(),
idpf_txq_has_room() returns 0:

	if (IDPF_DESC_UNUSED(tx_q) < descs_needed ||
	    IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
		IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
	...

idpf_tx_clean_complq() also sets complq_ok = false, so the queue is
never woken.

Could enough of these failures stall the Tx queue until the tx timeout
reset reinitializes the counter?

>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024030401.852598-1-almasrymina%40google.com
