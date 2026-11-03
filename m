Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712755;
	b=p4xNx2moUJ9PcAAktyfugpY+33A/4J657bPHhbP14SPUvOK398rZ915jnwIhr+tpNKzQ
	 1klaCmAEcdf4dTk7dzMxU9Vwc/5zB2jUewrM2EO6UIDwMLz8dPyAlq01ernOSLGdMmowT
	 ShpM3jS4eNm0vXMXS6FEx6zFztxsF8HD6YEiAwdxNcAxpRxg8WnM/MYPXDgj0CkvTJ1HI
	 J8yhUZL4qEU89yb+tkV76mJd8n72CUFLTuWU4C6bIr6Brp681Z45sDBgrQEcczxrcT796
	 SOxpt0uUkEVDuC0k4yr/qiMLD+0glqRSIro3T11z6cBim+hIrHmc+X8nA8R6kuB8XCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712755;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5ZlT402uNxQcromagOx+7rY5rxu2jyL0ri26T9/QgEI=;
	b=oSTDJeojzYtrt/C78nkfY/FtnJvhJ3hJPLiOV7XOJ1PjuORPhpxMKx6uVQEES6npOXIZ
	 k0t1T48pGyM32lEllG095YM6lQpvt45BhV4I4g8jY50ZunqbknKXKj/8xV/0jEggv3TPo
	 oQ8CCLOL5yxwftOwXIBHRNmMbSH88RpASSKFCfGVESUIsJ/dSbQeho1zy9CsRUcdlNJs+
	 8zxVTsy16NVfN/GkrmoxWdrKi+smk/vNjXkUKswnSBoVK3XCksbMsHznAYKHOwc1UOt2Y
	 w79K1e+2Kh9KLuguaL4UmttXDAnd5MY7KsVtPHJ60FwSUXPuMmcBZRqC6UeldkDGxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrukZSFM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A36606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrukZSFM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167D51F000C1;
	Tue,  3 Nov 2026 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712754;
	bh=5ZlT402uNxQcromagOx+7rY5rxu2jyL0ri26T9/QgEI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JrukZSFMi8BFlhLKjN1K8VGvw9T+T8iZYD0QdVWFQi0O+i3T6QUtBOnChrjRGMLey
	 0f/PPMR4JOGRwkEdJDhUjN1LXPnxlAdmJJU0JUf4GCPM9z9HRB+BoWbeBSJbLKy+Js
	 mNu8chm/0pMxqmw7kUsBEQjIfiD//lNKufxNF/G9Rrt3T30+D3ggKUDUKdFxvGtJih
	 D8JrE8+qIry9RbLFLAoakvrtdtW1wU8Lz2RRMp3fAXocO+b9kCSxh954IvqdmfNDPO
	 FSr4g8xFrVPNQmhYeXNTCevL6onuG0KEm4GqqWAEflABoBnzkjTmY/kQNAEPSP8Ve0
	 V7hgOQnpj65ew==
Subject:
 Re: [PATCH net 6/9] xsk: do not clear frags flag when acquiring a buffer
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Date: Tue, 03 Nov 2026 13:32:33 +0000
Message-ID: <179371275367.488856.10068896187953533629@kernel.org>
In-Reply-To: <20261102124950.958345-7-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-7-maciej.fijalkowski@intel.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 (1) · High: 2 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says "The driver XDP_TX paths ... already
  clear it".
- [High] libeth: xsk: uncleared frags flag and frag leak in
  libeth_xsk_tx_queue_bulk()
- [Medium] xp_alloc() (xsk_buff_pool.c:632) and xsk_buff_set_size()
  (xdp_sock_drv.h:229) now keep XDP_FLAGS_HAS_FRAGS when they hand out a…
- [Low] The i40e hunk moves rx_bytes = xdp_get_buff_len(first) to before
  i40e_run_xdp_zc(), and i40e_handle_xdp_result_zc() no longer…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but AF_XDP
  zero-copy multi-buffer Rx keeps its authoritative frag metadata…
- [High] At this commit, the frag loop in i40e_construct_skb_zc() does
  `memcpy(addr, skb_frag_page(frag), skb_frag_size(frag))` (line 335).

--

xsk: do not clear frags flag when acquiring a buffer

This patch keeps XDP_FLAGS_HAS_FRAGS when xp_alloc() and
xsk_buff_set_size() hand out a buffer. The flag is now cleared when the
frags are released, in xsk_buff_free() and xsk_rcv_zc(). It also moves
the i40e ZC rx_bytes accounting to before the XDP program runs.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index e6ae4c7a5cb39..57b0f520fbb29 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -354,7 +354,6 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  	struct sk_buff *skb;
>  
>  	*rx_packets = 1;
> -	*rx_bytes = xdp_get_buff_len(xdp_buff);
>  
>  	if (likely(xdp_res == I40E_XDP_REDIR) || xdp_res == I40E_XDP_TX)
>  		return;
> @@ -492,6 +491,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  
>  		xsk_buff_to_i40e_ctx(first)->desc = rx_desc;
>  
> +		rx_bytes = xdp_get_buff_len(first);
>  		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
>  		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
>  					  &rx_bytes, xdp_res, &failure);

[Severity: Low]

rx_bytes is now sampled before i40e_run_xdp_zc(), and
i40e_handle_xdp_result_zc() no longer recomputes it. Does XDP_PASS now
report the pre-program length instead of the length of the skb built by
i40e_construct_skb_zc()?

If the program calls bpf_xdp_adjust_head(), bpf_xdp_adjust_tail() or
bpf_xdp_pull_data() and then returns XDP_PASS, the counter would no
longer match what is passed up the stack.

The commit message says this is "like ice and libeth".
ice_clean_rx_irq_zc() uses the pre-program length only for
TX/REDIR/CONSUMED. For XDP_PASS it uses:

	total_rx_bytes += skb->len;

The i40e non-ZC path also uses skb->len for XDP_PASS. libeth does count
pre-program bytes for XDP_PASS.

The move is needed for TX and REDIR. On XDP_PASS the driver still owns
the buffer, so could that case keep using the post-program length? If
not, could the commit message mention the change?

[Severity: High]

This is a pre-existing issue and was not introduced by this patch. The
XDP_PASS path above ends up in i40e_construct_skb_zc(), and its frag
loop looks wrong at this commit:

	memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
	...
	__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
				   addr, 0, skb_frag_size(frag));

Doesn't the memcpy() copy from the struct page itself rather than from
the frag data? It also ignores the frag offset.

Doesn't __skb_fill_page_desc_noacc() get a virtual address where a
struct page pointer is expected? skb->len, data_len and truesize are
not updated either.

The dev_alloc_page() failure path also returns NULL without calling
xsk_buff_free(). That leaks the head, which keeps its flag while its
frags stay on pool->xskb_list.

The next patch in the series, "i40e: xsk: fix multi-buffer XDP_PASS skb
construction", seems to fix all of this. It switches to
skb_frag_address() and skb_add_rx_frag(), and sends the allocation
failure through xsk_buff_free().

> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 29965e3695983..a40ad3f90f13c 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -153,6 +153,7 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
>  	}
>  
>  	xdp_get_shared_info_from_buff(xdp)->nr_frags = 0;
> +	xdp_buff_clear_frags_flag(xdp);
>  out:
>  	xp_free(xskb);
>  }

[Severity: High]

The commit message says:

  "The driver XDP_TX paths, bpf_xdp_adjust_tail() and bpf_xdp_pull_data()
  already clear it"

Does that hold for libeth_xsk_tx_queue_bulk() when a flush fails partway
through a frame? The flag is only cleared once xsk_buff_get_frag()
returns NULL:

include/net/libeth/xsk.h:libeth_xsk_tx_queue_bulk() {
    ...
		if (!xdp) {
			...
			xdp_buff_clear_frags_flag(&head->base);
			break;
		}

		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
			ret = false;
			break;
		}
    ...
}

Suppose the bulk fills up mid-frame and flush_bulk() fails, for example
because the XDPSQ has no free descriptors and prep() returns 0. Then:

  - the frag just returned by xsk_buff_get_frag() is neither queued nor
    put back on pool->xskb_list. Is that UMEM buffer leaked?
  - the rest of the frame's frags stay on pool->xskb_list
  - libeth_xdp_tx_exception() without LIBETH_XDP_TX_DROP keeps the head
    and the frags already queued in the bulk (bq->count = left)
  - the head still has XDP_FLAGS_HAS_FRAGS set

__libeth_xdp_run_flush() then only changes the verdict and frees
nothing:

	if (act == LIBETH_XDP_TX && unlikely(!queue(bq, xdp, flush_bulk)))
		act = LIBETH_XDP_DROP;

The Rx loop keeps going with stale frags on the shared list, and the
next multi-buffer frame appends its frags behind them.

For XDP_REDIRECT, xsk_rcv_zc() checks for room using the head's frag
count:

	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;

It then writes one descriptor per entry on pool->xskb_list.
__xskq_prod_reserve_desc() has no bounds check. Can this overwrite Rx
descriptors that user space has not consumed yet? For XDP_TX, the stale
frags would go out inside the next frame.

The stale head is eventually freed, either by a DROP flush or on Tx
completion via libeth_xsk_buff_free_slow(). At that point
xsk_buff_free() still sees HAS_FRAGS and drains pool->xskb_list:

	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
		list_del_init(&pos->list_node);
		xp_free(pos);
	}

Could that release in-flight frags of a partial frame stashed in
rxq->xsk? This is the outcome described here ("leaves its frags on
pool->xskb_list, where they are taken as frags of the next frame").
It is also what the earlier series patch "libeth: xsk: do not free
in-flight frags on XDP_TX completion" aims to prevent. No later patch
in the series appears to touch include/net/libeth/xsk.h.

> @@ -225,7 +226,8 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>  	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
>  	xdp->data_meta = xdp->data;
>  	xdp->data_end = xdp->data + size;
> -	xdp->flags = 0;
> +	/* Frags flag is cleared when the frags of a head are released */
> +	xdp->flags &= XDP_FLAGS_HAS_FRAGS;
>  }

[Severity: High]
The commit message relies on the driver XDP_TX paths clearing
XDP_FLAGS_HAS_FRAGS once the frags have been handed off. However,
libeth_xsk_tx_queue_bulk() only clears it after xsk_buff_get_frag()
returns NULL:

	xdp = container_of(xsk_buff_get_frag(&head->base),
			   typeof(*xdp), base);
	if (!xdp) {
		xdp_buff_clear_frags_flag(&head->base);
		break;
	}

	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
	    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
		ret = false;
		break;
	}

xp_alloc() and xsk_buff_set_size() no longer reset the flag. So
nothing else clears it for a head that leaves this loop early.

Suppose the bulk fills up mid-frame and flush_bulk() fails:

  - the frag just unlinked by xsk_buff_get_frag() is neither queued
    nor freed. Isn't that UMEM buffer leaked?
  - the remaining frags stay on pool->xskb_list, and the next
    multi-buffer Rx frame picks them up
  - the head stays in the bulk with HAS_FRAGS set

When that head is later freed, through libeth_xsk_tx_return_bulk() or
on Tx completion, xsk_buff_free() drains whatever is on
pool->xskb_list at that point.

The successful case looks risky too. When a mid-frame flush_bulk()
succeeds, the head has already been written to sq->sqes[] as
LIBETH_SQE_XSK_TX. HAS_FRAGS is still set on it, and its remaining
frags are still on pool->xskb_list.

What happens if that SQE completes before the loop finishes? That
could come from the cleanup done by a later flush_bulk() for the same
frame. It could also come from libeth_xdpsq_run_timer() on another
CPU, which does not serialise against pool->xskb_list.

In that case, doesn't xsk_buff_free(&head->base) free the frags this
loop is about to pop? The rest of the frame would then be silently
dropped. In the timer case, the list itself would also be modified
concurrently.

Each frag gets its own SQE. Could the flag be cleared as soon as the
head is queued, before any flush can run? The flush failure path
would then also need to put the popped frag back, or free it together
with the rest of the frame. Does that match your intent here, or is
there something that keeps the head from completing mid-loop?

[Severity: Medium]

xsk_buff_set_size() and xp_alloc() now keep XDP_FLAGS_HAS_FRAGS, so a
new head no longer starts with clean frag state. Before, flags = 0
meant the first __xdp_buff_add_frag() always took the
!xdp_buff_has_frags() branch. That branch resets nr_frags,
xdp_frags_size and xdp_frags_truesize.

If a head is handed out again while still flagged, __xdp_buff_add_frag()
trusts the skb_shared_info at the tail of the UMEM chunk:

	nr_frags = sinfo->nr_frags;

The only check before indexing frags[] is nr_frags == MAX_SKB_FRAGS. A
user-written value such as 200 would let __skb_fill_netmem_desc_noacc()
write about 3 KB past sinfo. xdp_copy_frags_from_zc() and
i40e_construct_skb_zc() also loop over that nr_frags.

Later patches in the series fix the ice, i40e and idpf leak paths:

  "ice: xsk: free stashed Rx frame when cleaning the ring"
  "i40e: xsk: fix multi-buffer XDP_PASS skb construction"
  "idpf: free stashed XSk Rx frame when releasing the queue"

The libeth_xsk_tx_queue_bulk() mid-frame flush failure above still
seems to be open. Head H stays in the Tx bulk with HAS_FRAGS until the
NAPI poll ends. If user space posted H's address twice in the fill ring,
H can come back as the first buffer of a later frame in the same poll.
Its stale sinfo would then be used, with no race needed.

Would it make sense to re-initialise nr_frags, xdp_frags_size and
xdp_frags_truesize whenever a buffer becomes a new head, as a safety
net?

[Severity: Critical]

This isn't a bug introduced by this patch, but the patch now relies on
frag state surviving hand-out, and that metadata lives in user-writable
memory. xp_init_xskb_addr() places the buffer inside the UMEM mapping:

	xskb->xdp.data_hard_start = pool->addrs + addr + pool->headroom;

So xdp_get_shared_info_from_buff() points at the tail of a chunk that
user space keeps mapped writable. Once the first frag sets HAS_FRAGS, a
thread in the process that owns the UMEM can overwrite sinfo->nr_frags
before the next xsk_buff_add_frag().

__xdp_buff_add_frag() only rejects nr_frags == MAX_SKB_FRAGS (XSk passes
try_coalesce=false). __skb_fill_netmem_desc_noacc() then indexes
shinfo->frags[i] with no bounds check.

nr_frags is a u8. Can the write land up to about 3.8 KB past the chunk,
or past the end of the vmap area for the last chunk?

On XDP_PASS, xdp_copy_frags_from_zc() then does:

	nr_frags = xinfo->nr_frags;

	for (u32 i = 0; i < nr_frags; i++) {

This writes skb_shinfo(skb)->frags[i] beyond MAX_SKB_FRAGS. It also
memcpy()s from frag descriptors read out of UMEM, and
i40e_construct_skb_zc() has the same loop. Can this overflow the head
of the new skb, or copy arbitrary kernel memory into packet data?

Keeping the kernel-side HAS_FRAGS flag does not make the nr_frags stored
in UMEM trustworthy. This appears to date back to commit 24ea50127ecf.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
