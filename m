Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BF2DA75A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408521; cv=none; b=T731xN8JNepAtpi/VTJA/7QtSon0HurBjUGdPQq9wnfTGHaFX5rHUcdlaJrFgbXTNsaj7L9dU4qaw060cUz68TJhRY9g5U98BMP7eBfTTcJf4mrxYIQh2O7RmFmp7laR4LJkaQ4lHpj5omVd93ZpOSxE+/MIM6rHbetyxZqFV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408521; c=relaxed/simple;
	bh=0O6dXgKqPwdJ/29wsoSSD4RBnNL6gM6ww/Z8vuM8dgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ck2K+bWIp9/GePDNLP5SfyUlHNqd1BYYdCnQXu1FUaRuqBYmkdKMdcJH4gJg3pDzPyhGjIIBd3y9nfBqrxKGEsW7IoEAaU7YceRdCJobMDFpodClGF0uqPtRb3ii+qFXNr4nP9Z1mnllPZ0u4Yfpt/naagWP+UhRccNRMKtRH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMtFxgRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMtFxgRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7331F00A3A;
	Tue, 11 Aug 2026 00:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408519;
	bh=VSccGdhxMHqkAdiL8mtnO6So0yrNRw1SN1gLxUFVAf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMtFxgRuovpPfcQna+MiUBT+zknoiZJ9hKF4vBXOMfoMkWlf2Ko6u2DadO4avfUJn
	 rd9r2QM17eTh8NedsVz/9xcjfMEDw4qHnU8zVoF6qokYWw/jHGudf/Iuq5SXDEmCzI
	 hQD+aBxemSme5D0otE3Lky2+G3922jA2hUaR8Mn0Xts9D8fKYlKUU8Q9+W6u/ZePtV
	 mE1RYerRixlDbyxMIT2kLNmka1C2RtufUtYffo6T7qD3Y1FBHG8ilug83b4xYTDV3N
	 qFemLbqxCpV8ZQIKyMQ1DRKxS7JjSIw48ayih8w4kFVmKXAsLVQGf42A+1NbDS9r47
	 9vxljc3QP+rGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	tactii@gmail.com,
	dima.ruinskiy@intel.com,
	aleksandr.loktionov@intel.com,
	pmenzel@molgen.mpg.de,
	michalx.cohen@intel.com
Subject: Re: [PATCH net-next 10/15] i40e: prepare for XDP metadata ops support
Date: Mon, 10 Aug 2026 17:35:19 -0700
Message-ID: <20260811003519.1056926-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-11-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-11-anthony.l.nguyen@intel.com>
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
i40e: prepare for XDP metadata ops support

This adds struct i40e_xdp_buff, which wraps the xdp_buff stored on the Rx
ring together with a pointer to the Rx descriptor, and sets that pointer
before running the XDP program in both the normal and the AF_XDP zero-copy
receive paths.  The ZC path also gains XSK_CHECK_PRIV_TYPE() to verify the
new struct fits in the xdp_buff_xsk cb area.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 0cd0e5597c909..4b11ae9ed8d53 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3622,7 +3622,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>  	}
>  
>  skip:
> -	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
> +	xdp_init_buff(&ring->xdp_ctx.xdp, xdp_frame_sz, &ring->xdp_rxq);

[Severity: High]
This isn't a bug introduced by this patch, but can the state persisted in
rx_ring->xdp_ctx outlive the pages it points at?

i40e_clean_rx_ring() unmaps and drains every Rx page and resets the
next_to_* indices, but leaves the saved buffer alone:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_clean_rx_ring() {
	...
		__page_frag_cache_drain(rx_bi->page, rx_bi->pagecnt_bias);

		rx_bi->page = NULL;
		rx_bi->page_offset = 0;
	}
skip_free:
	...
	rx_ring->next_to_alloc = 0;
	rx_ring->next_to_clean = 0;
	rx_ring->next_to_process = 0;
	rx_ring->next_to_use = 0;
}

On bring-up the only re-initialization is the xdp_init_buff() call above,
and that touches rxq, frame_sz and flags only:

include/net/xdp.h:xdp_init_buff() {
	xdp->rxq = rxq;
	...
	xdp->frame_sz_flags_init = frame_sz;
	...
}

So data, data_hard_start and the frag state survive an ifdown/ifup, MTU
change, ring resize or PF reset.  If NAPI returned in the middle of a
multi-buffer packet (the state the comment above the member says is kept on
purpose), does the first iteration after the ring comes back up then take
the fragment-append branch on stale data?

drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_clean_rx_irq() {
	...
		if (!xdp->data) {
			...
			xdp_prepare_buff(xdp, hard_start, offset, size, true);
		} else if (i40e_add_xdp_frag(xdp, &nfrags, rx_buffer, size) &&
			   !neop) {
	...
}

i40e_add_xdp_frag() derives sinfo from data_hard_start and writes nr_frags,
xdp_frags_size and a frag entry, which would land in a page already handed
back by __page_frag_cache_drain(), and the following i40e_build_skb() /
i40e_process_rx_buffs() would then operate on and drop a reference to that
page.

ice does clear the stash in this situation: ice_clean_rx_ring() calls
libeth_xdp_return_stash(&rx_ring->xdp), described as freeing an incomplete
buffer stash when the queue is about to be destroyed.  Would clearing
xdp_ctx (data = NULL and the new desc = NULL) in i40e_clean_rx_ring() be
appropriate here?

The new desc pointer inherits the same lifetime problem: it is a raw
pointer into the descriptor ring that i40e_free_rx_resources() releases via
dma_free_coherent(), and it is only assigned on the EOP path, never
cleared.

>  
>  	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
>  				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ef5e657816f00..7f68adb5109b0 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c

[ ... ]

> @@ -2530,6 +2531,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
>  		if (neop)
>  			continue;
>  
> +		xdp_ctx->desc = rx_desc;
> +
>  		xdp_res = i40e_run_xdp(rx_ring, xdp, xdp_prog);
>  
>  		if (xdp_res) {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index 1e5fd63d47f47..bb741ff3e5f2c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -283,6 +283,11 @@ struct i40e_rx_buffer {
>  	__u32 page_count;
>  };
>  
> +struct i40e_xdp_buff {
> +	struct xdp_buff xdp;
> +	const union i40e_rx_desc *desc;
> +};
> +
>  struct i40e_queue_stats {
>  	u64 packets;
>  	u64 bytes;
> @@ -345,7 +350,7 @@ struct i40e_ring {
>  	 * and to resume packet building for this ring in the next call to
>  	 * i40e_clean_rx_ring_irq().
>  	 */
> -	struct xdp_buff xdp;
> +	struct i40e_xdp_buff xdp_ctx;

[Severity: Low]
This is a pre-existing issue, not something this patch introduced, but the
comment just above this member names i40e_clean_rx_ring_irq() twice and
that function does not exist; git grep for it matches only these two
comment lines.  The function that saves and resumes this state is
i40e_clean_rx_irq().  Since the hunk already touches the member, would it
make sense to fix the name, and also the "Storing xdp_buff on ring" wording
now that the member is a struct i40e_xdp_buff?

While there, could the lifetime of the new desc field be described?  It is
set only on the EOP path in i40e_clean_rx_irq() and is not initialized by
the xdp_init_buff() call in i40e_configure_rx_ring().

>  
>  	/* Next descriptor to be processed; next_to_clean is updated only on
>  	 * processing EOP descriptor
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba53..51a05ce4c7ce8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c

[ ... ]

> @@ -472,6 +482,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  		if (i40e_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> +		xsk_buff_to_i40e_ctx(first)->desc = rx_desc;
> +
>  		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
>  		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
>  					  &rx_bytes, xdp_res, &failure);

[Severity: High]
This isn't a bug introduced by this patch either, but can "first" here
already be a freed xsk buffer, so that this new store writes into the cb of
a buffer that is back on the pool free list?

Two places in i40e_clean_rx_irq_zc() free a buffer without advancing
next_to_clean and without clearing the rx_bi_zc slot.  The programming
status branch:

		if (i40e_rx_is_programming_status(qword)) {
			...
			bi = *i40e_rx_bi(rx_ring, next_to_process);
			xsk_buff_free(bi);
			if (++next_to_process == count)
				next_to_process = 0;
			continue;
		}

and the multi-buffer error path:

		if (!first)
			first = bi;
		else if (!xsk_buff_add_frag(first, bi)) {
			xsk_buff_free(first);
			break;
		}

If the loop then exits at:

		size = FIELD_GET(I40E_RXD_QW1_LENGTH_PBUF_MASK, qword);
		if (!size)
			break;

the function writes back rx_ring->next_to_clean unchanged while
next_to_process has moved on, and i40e_alloc_rx_buffers_zc() cannot refill
that slot because I40E_DESC_UNUSED stops at next_to_clean - 1.  So does
rx_bi_zc[next_to_clean] keep pointing at a freed buffer that the next poll
picks up?

	if (next_to_process != next_to_clean)
		first = *i40e_rx_bi(rx_ring, next_to_clean);

That buffer is then passed to xsk_buff_set_size(), xsk_buff_add_frag() and
i40e_run_xdp_zc(), and with this patch also written through by
xsk_buff_to_i40e_ctx(first)->desc = rx_desc.

On teardown, does the same stale pointer get freed a second time?
i40e_xsk_clean_rx_ring() walks [next_to_clean, next_to_use):

	while (ntc != ntu) {
		struct xdp_buff *rx_bi = *i40e_rx_bi(rx_ring, ntc);

		xsk_buff_free(rx_bi);

and it runs before i40e_clear_rx_bi_zc() zeroes the array.

ice_clean_rx_irq_zc() frees, clears first, and still advances ntc:

		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
			xsk_buff_free(first);
			first = NULL;
		}

		if (++ntc == cnt)
			ntc = 0;

Would the same handling be right for i40e?

The multi-buffer error leg looks hard to reach on this hardware, since
xsk_buff_add_frag() only fails at MAX_SKB_FRAGS while rx_ctx.rxmax is
programmed from I40E_MAX_CHAINED_RX_BUFFERS, but the programming status leg
needs no oversized frame.
