Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712751;
	b=Ft03F4kw7yc/F7Wxazg0ErOJRGAulzTbMB3Y5gdfnD1dfRZA+9DMQKMN+ckJDWtyv/RQ
	 y9KZ8rvC/B6Qr6tuZHzOlyZFxmuM8thDuuDqvOwuTXMh2U9eS5SWas4xh9u1Ib8VGhCb2
	 8Yx5lzleITNIkMqjxp7l6U6udKMBkV5T3/vjHyrvvZDdNAdGDjG4ZlILQlWRxG3PGxNJo
	 XOBQG88cA+wVgAYIzTjT2Yj33ZEZV45f1wA8vn39PDdfoZ4tuK8/Pib7WLbRH30OVDRz5
	 7Pj8dC4Uwf3vMH0eBl+fGqJ9ZbguhhmuslOgTP9Fis2yhYDzBukW0K5p3LSZ3eJu7xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712751;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aOZBik79GgI0qJpop6SwzKu730Z6eMSnmgM9dn8Qba8=;
	b=HlrNYHl4iGI7w8UNwU3oxxPg8RM/8WY5ldf3Y2vOODmJbymfSRK6DYsmIXPfR3kYlYvi
	 ayN0CVNobO7Y+dIBkXYe1v67BAZMYezaxyF9QKQIK+t7zEv/qtTavYAQZaY25AC3d+Bv6
	 VrHQphU08id+uUCkyzx2WgTYj4fbQnB5NQWkavygOMjqPG+Br5b/SseLMtpULT1EGJBq2
	 RsgfBEC1xTvLzK3frxGbAUFZujlo/MZi7UOz+dtWFOA28vxWeN/PSks6khhEiUQnc4Rqm
	 4aKJbPJkt79j4HTgWz+U7ttR2RQiPH15nlFcuKhKPaaai6/fFVvbYqGSirJqYqn0fAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDaUWntN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4240606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDaUWntN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BC91F000C1;
	Tue,  3 Nov 2026 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712750;
	bh=aOZBik79GgI0qJpop6SwzKu730Z6eMSnmgM9dn8Qba8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LDaUWntN2pQ1YOSElkGCiG++VwR1VumID1Ax7czwbN8HxzrFXvDvhMRgBt2uvncNP
	 ehoJYrZrk5rXnUg9gYlRuLZUw7VS8zAOG3z8YZTeOK2cY2y6v222BoAoyIbEL8x+fH
	 hFKc8bquqr5xS9vZeYD5F/vW5cf8BPEiL92F+yZHStTV4G7jCN+KuwVmzNIGnzFzhm
	 zFXILc4/hZvq8ajyL1hhTK+nqVNZIAJmHmKKjCWJYRLtvglOqN86eenz8vXtqITcD5
	 OvDA4BLzhpX9gxBEnSaCeB8//bOE1mS8kd9nEYCwBTmaEAxLkHzc9IfMTMw/Krge5K
	 Fk033wrSvun+w==
Subject: Re: [PATCH net 1/9] xsk: fix list corruption in xsk_buff_add_frag()
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Date: Tue, 03 Nov 2026 13:32:29 +0000
Message-ID: <179371274919.488856.4452814542770594161@kernel.org>
In-Reply-To: <20261102124950.958345-2-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-2-maciej.fijalkowski@intel.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At the reviewed commit, the new `xdp == head` rejection in
  xsk_buff_add_frag() (include/net/xdp_sock_drv.h:166-168) runs after…
- [High] At the reviewed commit, the new rejection in xsk_buff_add_frag()
  fails the same way every time it sees the same input.
- [Low] The kernel-doc for libeth_xsk_buff_add_frag()
  (drivers/net/ethernet/intel/libeth/xsk.c:50-51) says it returns '%NULL…

Pre-existing issues:
- [Low] When xsk_buff_add_frag() fails, ice_clean_rx_irq_zc() frees the
  partial frame and sets first = NULL but does not skip ahead to EOP.

--

xsk: fix list corruption in xsk_buff_add_frag()

This patch changes xsk_buff_add_frag() to reject a frag buffer that is the
frame head or that is already linked on pool->xskb_list or
pool->free_list. In aligned mode this happens when user space posts the
same fill ring address twice. The goal is to prevent list corruption and
the resulting NULL pointer dereference in xp_free().

> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index d94aeb506379c..29965e3695983 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -160,15 +160,18 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
>  static inline bool xsk_buff_add_frag(struct xdp_buff *head,
>  				     struct xdp_buff *xdp)
>  {
> +	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
>  	const void *data = xdp->data;
> -	struct xdp_buff_xsk *frag;
> +
> +	/* Duplicate fill ring entries map to the same xskb in aligned mode */
> +	if (unlikely(xdp == head || !list_empty(&frag->list_node)))
> +		return false;

[Severity: High]
Can the xdp == head case still leave stale frags on pool->xskb_list?

Drivers call xsk_buff_set_size() on the new buffer before they call
xsk_buff_add_frag(). For example, in ice_clean_rx_irq_zc():

    xsk_buff_set_size(xdp, size);
    xsk_buff_dma_sync_for_cpu(xdp);

    if (!first) {
        first = xdp;
    } else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
        xsk_buff_free(first);
        first = NULL;
    }

When the duplicate is the head, xsk_buff_set_size() has already reset the
flags on the live head:

include/net/xdp_sock_drv.h:xsk_buff_set_size() {
    ...
    xdp->flags = 0;
}

So XDP_FLAGS_HAS_FRAGS is gone by the time xsk_buff_free(first) runs, and
xsk_buff_free() skips draining the list:

    if (likely(!xdp_buff_has_frags(xdp)))
        goto out;

With fill ring entries A, B, A, wouldn't B stay on pool->xskb_list and get
attached to a later frame? xsk_rcv_zc() reserves nr_frags + 1 slots but
emits one descriptor per xskb_list entry, so the Rx ring accounting would
go out of sync.

A later patch in this series, "xsk: do not clear frags flag when acquiring
a buffer", seems to fix this. It makes xsk_buff_set_size() and xp_alloc()
keep XDP_FLAGS_HAS_FRAGS, and it makes xsk_buff_free() and xsk_rcv_zc()
clear it. Could that patch go before this one, or be folded into it, so
this commit works on its own?

[Severity: High]
The commit message says:

    Callers already drop the frame on failure.

Is that true for i40e? i40e_clean_rx_irq_zc() handles the failure like
this:

    else if (!xsk_buff_add_frag(first, bi)) {
        xsk_buff_free(first);
        break;
    }

It advances neither next_to_process nor next_to_clean. On the next poll the
head is rebuilt from the ring:

    if (next_to_process != next_to_clean)
        first = *i40e_rx_bi(rx_ring, next_to_clean);

The new rejection gives the same result for the same input. With duplicate
fill entries A, A, wouldn't the same head/frag pair fail on every poll,
each time starting from a head that was already freed? next_to_clean would
never move, and the ring would stop being refilled.

The next patch in the series, "i40e: xsk: fix xsk_buff_add_frag() error
handling in Rx", seems to fix this. It frees both buffers, sets
next_to_clean to next_to_process, clears first and continues. Should that
patch come before this one?

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
this check makes the caller failure paths reachable through duplicate fill
ring entries.

In ice_clean_rx_irq_zc(), a failed xsk_buff_add_frag() frees the partial
frame and sets first to NULL, but the remaining descriptors up to EOP are
not skipped:

    } else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
        xsk_buff_free(first);
        first = NULL;
    }

Won't the rest of the hardware frame then be assembled and delivered as a
new frame? idpf_xskrq_poll() does the same when libeth_xsk_process_buff()
returns NULL.

The i40e patch later in this series calls this intended ("The rest of the
dropped frame is received as a new frame"). It also does not appear to
corrupt kernel memory, so it may be acceptable as is.

[Severity: Low]
This isn't a bug, but the kernel-doc for libeth_xsk_buff_add_frag() in
drivers/net/ethernet/intel/libeth/xsk.c still lists running out of frag
space as the only failure reason:

 * Return: main buffer with attached frag on success, %NULL on error (no space
 * for a new frag).

With these new checks, it also returns NULL when the frag is the head, or
when it is already on pool->xskb_list or pool->free_list. Should that
comment be updated too? The text is unchanged at the end of the series.

>  
>  	if (!__xdp_buff_add_frag(head, virt_to_netmem(data),
>  				 offset_in_page(data), xdp->data_end - data,
>  				 xdp->frame_sz, false))
>  		return false;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
