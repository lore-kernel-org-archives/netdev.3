Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249189;
	b=tE6XuAwntqEgDB3PzmOtBGlB44QVsI2xjulcvsXQM+H+cggzwgPEePkfXdtDEI2ggRBF
	 uGEUDHwcO+RP+g+bYVmaXrBzRSgNPLkcWs0G7hSy6qxkE1caYKIHJU2uA0JwCTGFE3gHo
	 Lmd+VONC04ZNcRh8TI/8xPkLRpEePm/LPZcseJPESAA2SIFXuCi88uUJXVVySAFoW4QU1
	 nJoZs+W4qL4q5Zmcib+kCi57YRvjyyPr7BpScrdBeLPh6cLsJCJvOJc+kTtK0vZmk4+L4
	 Q/6WCtTeKvSqHStd1Gqsh8RmUoQf6W/+BxKDr245Gfkgrclkh14CFByNYCWCeY5XEnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5QqEXwmctImB2/RSSvLeaLHACbFNWEAT+e+zjZl/oOk=;
	b=fpTYEqwLfYLzdD+2XusgbYZAR0CrizW7ls37PEd2FKHR4QULzSed51/cziFdIE52KY90
	 07FJUMtKulE5c3I4ByNTjtRat9s4kbBIDyGk8zmCa/DNdECuIvlLsOOqzCLtuEx1ryw5X
	 /gPiCN/jpTw8aWNeaocwu8v6VsliMgxqtzaztw2ms73NYBgivrc0qdRYoOUb8H1tDF8Np
	 2ZC4R9/X4hS3WV0fm91gbF7aq4kWtsDh8fWNbzGGWGEUQipOFU0ba860tfYDYBE6W4YF0
	 2nZ9FVqiJPgtPPgkxVjg7eo9taOf5IJi7ZBGhZ/vVL7/GNjlxvrK6rUitbwgSVLtHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rv+LeCjS;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C2606B5B8
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C9C2606B5B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rv+LeCjS
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36caa19b0ffso900901eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794249187; x=1794853987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5QqEXwmctImB2/RSSvLeaLHACbFNWEAT+e+zjZl/oOk=;
        b=Rv+LeCjSGM46zIB/QgtUgYeq0ONIpvm1Ekc/vgCuTw8zzFzOKAXV5vviqgPznxoyLs
         U6BtiQlUVASpfCEzMKeQuOEtZ/xAOZvYBnRw/pH0rbhZ1Mlm2nPKlod+hqfiRln4th8L
         nzwqP4cbcnk7CaQ6iEgp7JnmlUvmCnffQqnyOCcMHZaOy9eYJYKAZqudxT+GIU9FZnp9
         9iYxFSsKMY+nzkA9xkosPslLk9iS6C9KCrtMlY8eruLwaqXtvVXx+omHkDvPXv/mpPvP
         xZ/5hdYvdGCJQuXhwP8KOiLXfiSIk/71ZlBhnEkILOc0aUFoxsL/0krXaURWnH8n0+Gp
         xs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249187; x=1794853987;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QqEXwmctImB2/RSSvLeaLHACbFNWEAT+e+zjZl/oOk=;
        b=vt/ZLN9W56l6c6khFKEFTjCBbE/jeKQjiWzn8kut9STxCnqFU8No81s1zNrTS+4ID6
         a8nDE/5h1d/bhzprJOqlwpmGhM+VbgjKJw3t6zB6kAsJEvRgKE2hI2H0M894gQzx3/Lt
         Vz2fUJaHerQhE0oEyXmlCtsDs/WQ+JfUKwN+f+xRJxQ98bVRzuACRA4URlPT1pOBfFq7
         k/h1BPCIQXeg+Y0ei6NNzNbKesTKiGM8QulXLnE/42Ev5+7zpTK/u9QW9mF6gowXX8rB
         vuoexgK456MDXDko6uBZoC/3fU0Y1eMKhEs2/BlGBa7iHMx5tpWOXqj4JNSbZWO+Hnt2
         ylTg==
X-Gm-Message-State: APuU4Z+mL2GfbuwJqiJlI6XjIrU1RlixKICtP9CqqF4nw6DPR1hJ96Rg
	Putr7rITPa1F9pHV+WdH/gBX9DIKCxJ7SDvUUywG87GjXGB7uPDG79o/
X-Gm-Gg: AYBFou1FI80pBVlKaxKB+LRc0iIapx4lFVE8Vh7gGlg8OjhxmQzVDBlxqJY/yXtr8Qj
	gdQRvUbBn32ckaP7oSGOkUDEGSkYBAye9fL0xnGkog0o8kIvDsHsFYlir5X7yVSCGBwNlKQPb37
	00WL6e/AF6wajBrVpzvCA18aHFkCh6aE29I5Jrcoh4FliCrM9mf4s8gLPfg3psv0ta+rQixyI0w
	H5ivq5B6vfnPl8+xULQKDZHuw7NUec2prppJ57woRbS1E8UJ5Rpyr9zsG9GDoxo58omNAkgE5H6
	+kkihk/NyQiV/O5O8/1w1lEERY5nKylQAxakxtTonftpPjIkZTTeG8QpFBa3pLKdlqX0tWAmImt
	yESFK1Gynv2GJuahU9/kIGmHiHNbi9e9BZjuViGDVq9wNtWHypHsy8f+2O4Cl1QwsfnxuzjNkmq
	zByjzbF+eBW2njV8a9wO1UCX28i9XrbPBblc9ZU2gEE3eQDvBI3sbdH7MjxFPI/h6VSjsSoGviL
	bHEHesPYgZA6yvmGTdHoR0G4zEQCsE6HYnfmr2i1y6ZYNeCkdNJ3a6RxR00s1A05PK0m0khiYYp
	IqOofIHPNo7qJeKP1eJFFQ==
X-Received: by 2002:a05:7023:a4c:b0:1b2:60ab:1e9a with SMTP id a92af1059eb24-1b3b605b765mr299989c88.10.1794249187342;
        Mon, 09 Nov 2026 10:33:07 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm802762c88.4.2026.11.09.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:33:06 -0800 (PST)
Date: Mon, 9 Nov 2026 10:32:44 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v4 2/2] net: prevent mixing frags from different
 memory providers or bindings
Message-ID: <avIRJ3vdIj6Jr9zJ@devvm16445.scu0.facebook.com>
References: <20261108013838.1454450-1-almasrymina@google.com>
 <20261108013838.1454450-3-almasrymina@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108013838.1454450-3-almasrymina@google.com>

On 11/08, Mina Almasry wrote:
> Enforce that all fragments in a nonlinear skb come from compatible
> memory providers (and for devmem, the exact same binding):
> 
> - Add skb_has_net_iovs(skb) (skb->unreadable && skb_shinfo(skb)->nr_frags),
>   assuming skb->unreadable and net_iov-backed frags are equivalent for
>   now (with a comment noting the two can be decoupled in the future if
>   readable net_iovs are introduced).
> - Add skb_net_iov_provider(), skb_mem_provider_compat(), and
>   skb_frags_can_coalesce() so multi-skb coalescing, shifting, and GRO
>   paths can share a single check across pp_recycle, skb_zcopy(), and
>   fragment memory providers:
>   - page vs net_iov is rejected via skb_has_net_iovs() without chasing
>     frags[0] or struct net_iov
>   - page vs page and net_iov vs net_iov compare skb_net_iov_provider()
>     (NULL == NULL with 0 pointer chases for page-backed skbs;
>     net_iov_owner(niov) for devmem and niov->desc.pp for other net_iov
>     providers such as io_uring zcrx)
>   - Because skb_has_net_iovs() requires nr_frags > 0, coalescing or
>     shifting net_iov frags into a frag-less (nr_frags == 0) skb is also
>     rejected (no in-tree TCP caller shifts net_iov frags into an empty
>     skb; update netmem_ref_test_net_iov to pre-populate the target skb
>     with a frag from the same binding before calling skb_shift()).
> - Add net_devmem_skb_binding() and use it in
>   validate_xmit_unreadable_skb(), zerocopy_fill_skb_from_devmem(), and
>   tcp_sendmsg_locked() so frags from different devmem bindings or memory
>   providers cannot be mixed on TX.
> - Use skb_frags_can_coalesce() across skb_try_coalesce(), skb_shift(),
>   and skb_gro_receive().
> - Use skb_mem_provider_compat() in skb_gro_receive_list(),
>   tcp_skb_can_collapse(), and tcp_skb_can_collapse_rx().
> - Reject converting linear head_frag payloads into page frags on
>   unreadable skbs in skb_try_coalesce() and skb_gro_receive().
> - Propagate skb->unreadable and compare skb_frag_netmem() instead of
>   skb_frag_page() (which returns NULL for net_iovs) when merging frags
>   in tcp_clone_payload().
> 
> This issue is theoretical and was found by manual code inspection and
> LLM review; it was not triggered in production. Verified with the
> net_core KUnit test suite; not tested on real hardware.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  include/linux/skbuff.h | 65 ++++++++++++++++++++++++++++++++++++++++++
>  include/net/tcp.h      |  5 ++--
>  net/core/datagram.c    |  4 +--
>  net/core/dev.c         | 14 ++++-----
>  net/core/devmem.h      | 22 ++++++++++++++
>  net/core/gro.c         | 16 ++++-------
>  net/core/net_test.c    | 42 +++++++++++++++++++++++----
>  net/core/skbuff.c      | 24 ++++++----------
>  net/ipv4/tcp.c         |  2 +-
>  net/ipv4/tcp_output.c  |  3 +-
>  10 files changed, 150 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..e6f63450a193a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1882,6 +1882,17 @@ static inline bool skb_frags_readable(const struct sk_buff *skb)
>  	return !skb->unreadable;
>  }
>  
> +/* Return true if frags in this skb are backed by net_iovs.
> + * Assumes skb->unreadable and net_iov-backed frags are equivalent for now;
> + * the two can be decoupled in the future if readable net_iovs in skbs are
> + * introduced. Also check nr_frags because not all frag-removal paths clear
> + * skb->unreadable when nr_frags drops to 0.
> + */
> +static inline bool skb_has_net_iovs(const struct sk_buff *skb)
> +{
> +	return skb->unreadable && skb_shinfo(skb)->nr_frags;
> +}
> +
>  static inline void skb_mark_not_on_list(struct sk_buff *skb)
>  {
>  	skb->next = NULL;
> @@ -3763,6 +3774,60 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
>  	return page_address(skb_frag_page(frag)) + skb_frag_off(frag);
>  }
>  
> +/* Return an opaque pointer identifying the memory provider instance of @skb's
> + * net_iov fragments:
> + * - For devmem (NET_IOV_DMABUF), net_iov_owner(niov) (&binding->area, 1:1 with
> + *   the binding across RX queues and TX).
> + * - For other net_iov providers (e.g., io_uring zcrx), niov->desc.pp (shared
> + *   across all areas of an io_zcrx_ifq).
> + */
> +static inline void *skb_net_iov_provider(const struct sk_buff *skb)
> +{
> +	struct net_iov *niov;
> +
> +	if (!skb_has_net_iovs(skb))
> +		return NULL;
> +
> +	niov = skb_frag_net_iov(&skb_shinfo(skb)->frags[0]);
> +	if (!niov)
> +		return NULL;
> +
> +	if (net_is_devmem_iov(niov))
> +		return net_iov_owner(niov);
> +
> +	return niov->desc.pp;
> +}
> +
> +/* Return true if the memory providers of @skb1 and @skb2 are compatible
> + * for coalescing. For any struct page-backed provider (the buddy allocator
> + * or a future provider handing out struct pages), coalescing is assumed
> + * feasible. For net_iov-backed providers, the provider instance pointer
> + * must match.
> + */
> +static inline bool skb_mem_provider_compat(const struct sk_buff *skb1,
> +					   const struct sk_buff *skb2)
> +{
> +	/* Check skb_has_net_iovs() first to avoid chasing frags[0] and
> +	 * struct net_iov when only one skb is net_iov-backed.
> +	 */
> +	if (skb_has_net_iovs(skb1) != skb_has_net_iovs(skb2))
> +		return false;
> +
> +	return skb_net_iov_provider(skb1) == skb_net_iov_provider(skb2);
> +}
> +
> +static inline bool skb_frags_can_coalesce(struct sk_buff *to,
> +					  struct sk_buff *from)
> +{
> +	if (to->pp_recycle != from->pp_recycle)
> +		return false;
> +
> +	if (skb_zcopy(to) || skb_zcopy(from))
> +		return false;
> +
> +	return skb_mem_provider_compat(to, from);
> +}
> +
>  /**
>   * skb_frag_address_safe - gets the address of the data contained in a paged fragment
>   * @frag: the paged fragment buffer
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 3560adddf8215..07a222c0fe2d7 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1268,14 +1268,15 @@ static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
>  		      mptcp_skb_can_collapse(to, from) &&
>  		      !skb_cmp_decrypted(to, from) &&
>  		      skb_pure_zcopy_same(to, from) &&
> -		      skb_frags_readable(to) == skb_frags_readable(from));
> +		      skb_mem_provider_compat(to, from));
>  }
>  
>  static inline bool tcp_skb_can_collapse_rx(const struct sk_buff *to,
>  					   const struct sk_buff *from)
>  {
>  	return likely(mptcp_skb_can_collapse(to, from) &&
> -		      !skb_cmp_decrypted(to, from));
> +		      !skb_cmp_decrypted(to, from) &&
> +		      skb_mem_provider_compat(to, from));
>  }
>  
>  /* Events passed to congestion control interface */
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index ecc30a6f83023..1e7db61e25a56 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,8 +712,8 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> -	if (i && skb_frags_readable(skb))
> -		return -EFAULT;
> +	if (skb->len && net_devmem_skb_binding(skb) != binding)
> +		return -EMSGSIZE;
>  
>  	/* Devmem filling works by taking an IOVEC from the user where the
>  	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1aece2fe2429f..f241d8c650fcd 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4169,8 +4169,7 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
>  static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  						    struct net_device *dev)
>  {
> -	struct skb_shared_info *shinfo;
> -	struct net_iov *niov;
> +	struct net_devmem_dmabuf_binding *binding;
>  
>  	if (likely(skb_frags_readable(skb) ||
>  		   dev->netmem_tx == NETMEM_TX_NO_DMA))
> @@ -4179,14 +4178,11 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  	if (dev->netmem_tx == NETMEM_TX_NONE)
>  		goto out_free;
>  
> -	shinfo = skb_shinfo(skb);
> -
>  	/* All net_iovs in an unreadable skb share the same binding. */
> -	if (shinfo->nr_frags > 0) {
> -		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> -		if (net_is_devmem_iov(niov) &&
> -		    (net_devmem_iov_binding(niov)->direction != DMA_TO_DEVICE ||
> -		     READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev))
> +	if (skb_shinfo(skb)->nr_frags > 0) {
> +		binding = net_devmem_skb_binding(skb);
> +		if (!binding || binding->direction != DMA_TO_DEVICE ||
> +		    READ_ONCE(binding->dev) != dev)
>  			goto out_free;
>  	}
>  
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index c4f476947dfaa..9d7fc2914de14 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -10,6 +10,7 @@
>  #ifndef _NET_DEVMEM_H
>  #define _NET_DEVMEM_H
>  
> +#include <linux/skbuff.h>
>  #include <net/net_namespace.h>
>  #include <net/netmem.h>
>  #include <net/netdev_netlink.h>
> @@ -117,6 +118,21 @@ net_devmem_iov_binding(const struct net_iov *niov)
>  			    struct net_devmem_dmabuf_binding, area);
>  }
>  
> +static inline struct net_devmem_dmabuf_binding *
> +net_devmem_skb_binding(const struct sk_buff *skb)
> +{
> +	struct net_iov *niov;
> +
> +	if (!skb_has_net_iovs(skb))
> +		return NULL;
> +
> +	niov = skb_frag_net_iov(&skb_shinfo(skb)->frags[0]);
> +	if (!niov || !net_is_devmem_iov(niov))
> +		return NULL;
> +
> +	return net_devmem_iov_binding(niov);
> +}
> +
>  static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
>  {
>  	return net_devmem_iov_binding(niov)->id;
> @@ -250,6 +266,12 @@ net_devmem_iov_binding(const struct net_iov *niov)
>  {
>  	return NULL;
>  }
> +
> +static inline struct net_devmem_dmabuf_binding *
> +net_devmem_skb_binding(const struct sk_buff *skb)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #endif /* _NET_DEVMEM_H */
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 1b033855a20db..51a694b26401b 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -100,16 +100,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  	struct sk_buff *lp;
>  	int segs;
>  
> -	/* Do not splice page pool based packets w/ non-page pool
> -	 * packets. This can result in reference count issues as page
> -	 * pool pages will not decrement the reference count and will
> -	 * instead be immediately returned to the pool or have frag
> -	 * count decremented.
> -	 */
> -	if (p->pp_recycle != skb->pp_recycle)
> -		return -ETOOMANYREFS;
> -
> -	if (skb_zcopy(p) || skb_zcopy(skb))
> +	if (!skb_frags_can_coalesce(p, skb))
>  		return -ETOOMANYREFS;
>  
>  	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
> @@ -158,7 +149,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  		NAPI_GRO_CB(skb)->free = NAPI_GRO_FREE;
>  		goto done;
> -	} else if (skb->head_frag) {
> +	} else if (skb->head_frag && skb_frags_readable(skb)) {
>  		int nr_frags = pinfo->nr_frags;
>  		skb_frag_t *frag = pinfo->frags + nr_frags;
>  		struct page *page = virt_to_head_page(skb->head);
> @@ -233,6 +224,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  
>  int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  {
> +	if (!skb_mem_provider_compat(p, skb))
> +		return -ETOOMANYREFS;
> +
>  	/* make sure to check flush flag and to not merge */
>  	if (unlikely(p->len + skb->len >= 65536 ||
>  		     NAPI_GRO_CB(skb)->flush))
> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 2b5080c226636..4a56b44f4addb 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c
> @@ -947,6 +947,9 @@ static void netmem_ref_test_net_iov(struct kunit *test)
>  	copy = alloc_skb(0, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, copy);
>  	copy->pp_recycle = 1;
> +	skb_fill_netmem_desc(copy, 0, netmem, 64, 16);
> +	copy->len = 16;
> +	copy->data_len = 16;
>  	KUNIT_EXPECT_EQ(test, skb_shift(copy, skb, 16), 16);
>  	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 3L);
>  	KUNIT_EXPECT_EQ(test, atomic_long_read(&binding.ref.data->count),
> @@ -1485,9 +1488,10 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
>  	};
>  	struct sk_buff *to, *from, *clone;
>  	struct net_devmem_dmabuf_binding binding = {};
> -	struct net_iov niov = {};
> +	struct net_iov_area area2 = {};
> +	struct net_iov niov = {}, niov2 = {};
>  	struct page *pp_page, *reg_page;
> -	netmem_ref pp_nm, niov_nm;
> +	netmem_ref pp_nm, niov_nm, niov2_nm;
>  	struct page_pool *pool;
>  	long base_pp_ref, base_iov_ref;
>  	int base_pp_page_ref, base_reg_ref;
> @@ -1578,18 +1582,19 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
>  	from = alloc_skb(0, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, to);
>  	KUNIT_ASSERT_NOT_NULL(test, from);
> -	skb_put(to, skb_tailroom(to));
>  	to->pp_recycle = 1;
> -	to->unreadable = 1;
>  	from->pp_recycle = 1;
> -	skb_add_rx_frag_netmem(from, 0, niov_nm, 0, 64, PAGE_SIZE);
> +	skb_add_rx_frag_netmem(to, 0, niov_nm, 0, 32, PAGE_SIZE);
> +	napi_pp_get_page(niov_nm);
> +	skb_add_rx_frag_netmem(from, 0, niov_nm, 32, 64, PAGE_SIZE);
>  	napi_pp_get_page(niov_nm);
>  
>  	clone = skb_clone(from, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, clone);
>  	KUNIT_EXPECT_TRUE(test, skb_try_coalesce(to, from, &fragstolen,
>  						 &delta));
> -	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 4L);
> +	KUNIT_EXPECT_TRUE(test, to->unreadable);
> +	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 5L);
>  	KUNIT_EXPECT_EQ(test, atomic_long_read(&binding.ref.data->count),
>  			base_iov_ref);
>  	consume_skb(from);
> @@ -1597,6 +1602,31 @@ static void netmem_ref_test_try_coalesce(struct kunit *test)
>  	consume_skb(to);
>  	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 2L);
>  
> +	/* 4. Reject coalescing net_iov skbs from different bindings. */
> +	net_iov_init(&niov2, &area2, NET_IOV_DMABUF);
> +	niov2_nm = net_iov_to_netmem(&niov2);
> +	netmem_set_pp(niov2_nm, pool);
> +	netmem_or_pp_magic(niov2_nm, PP_SIGNATURE);
> +	atomic_long_set(&niov2.desc.pp_ref_count, 2);
> +	to = alloc_skb(0, GFP_KERNEL);
> +	from = alloc_skb(0, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, to);
> +	KUNIT_ASSERT_NOT_NULL(test, from);
> +	to->pp_recycle = 1;
> +	from->pp_recycle = 1;
> +	skb_add_rx_frag_netmem(to, 0, niov_nm, 0, 32, PAGE_SIZE);
> +	napi_pp_get_page(niov_nm);
> +	skb_add_rx_frag_netmem(from, 0, niov2_nm, 0, 32, PAGE_SIZE);
> +	napi_pp_get_page(niov2_nm);
> +	KUNIT_EXPECT_FALSE(test, skb_try_coalesce(to, from, &fragstolen,
> +						  &delta));
> +	consume_skb(from);
> +	consume_skb(to);
> +	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), 2L);
> +	KUNIT_EXPECT_EQ(test, atomic_long_read(&niov2.desc.pp_ref_count), 2L);
> +	netmem_clear_pp_magic(niov2_nm);
> +	netmem_set_pp(niov2_nm, NULL);
> +
>  	page_pool_put_full_page(pool, pp_page, false);
>  	page_pool_put_full_page(pool, pp_page, false);
>  	__free_page(reg_page);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 43e720d30b67b..90d7691e5f545 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4342,10 +4342,9 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>  
>  	if (skb_headlen(skb))
>  		return 0;
> -	if (skb_zcopy(tgt) || skb_zcopy(skb))
> +	if (!skb_frags_can_coalesce(tgt, skb))
>  		return 0;
>  
> -	DEBUG_NET_WARN_ON_ONCE(tgt->pp_recycle != skb->pp_recycle);
>  	DEBUG_NET_WARN_ON_ONCE(skb_cmp_decrypted(tgt, skb));
>  
>  	todo = shiftlen;
> @@ -6300,17 +6299,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  	 * tricky (due to potential race with the clone disappearing) and
>  	 * rare, so not worth dealing with.
>  	 */
> -	if (to->pp_recycle != from->pp_recycle)
> -		return false;
> -
> -	/* All frags in an skb must either all be struct page-backed or all
> -	 * belong to the same memory provider instance; do not coalesce skbs
> -	 * that would mix them.
> -	 */
> -	if (skb_frags_readable(from) != skb_frags_readable(to))
> -		return false;
> -
> -	if (len <= skb_tailroom(to) && skb_frags_readable(from)) {
> +	if (len <= skb_tailroom(to) && to->pp_recycle == from->pp_recycle &&
> +	    skb_frags_readable(to) && skb_frags_readable(from)) {
>  		if (len) {
>  			if (unlikely(skb_copy_bits(from, 0,
>  						   skb_tail_pointer(to),
> @@ -6324,17 +6314,21 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>  		return true;
>  	}
>  
> +	if (!skb_frags_can_coalesce(to, from))
> +		return false;
> +
>  	to_shinfo = skb_shinfo(to);
>  	from_shinfo = skb_shinfo(from);
>  	if (to_shinfo->frag_list || from_shinfo->frag_list)
>  		return false;
> -	if (skb_zcopy(to) || skb_zcopy(from))
> -		return false;
>  
>  	if (skb_headlen(from) != 0) {
>  		struct page *page;
>  		unsigned int offset;
>  
> +		if (!skb_frags_readable(to) || !skb_frags_readable(from))
> +			return false;
> +
>  		if (to_shinfo->nr_frags +
>  		    from_shinfo->nr_frags >= MAX_SKB_FRAGS)
>  			return false;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b9de7c302ba83..67651b1936a8d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1251,7 +1251,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
>  
>  		if (copy <= 0 || !tcp_skb_can_collapse_to(skb) ||
> -		    unlikely(skb_frags_readable(skb) != !binding)) {
> +		    unlikely(net_devmem_skb_binding(skb) != binding)) {
>  			bool first_skb;
>  
>  new_segment:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index cf3ddc055d48d..b8a5c3556243b 100644

[..]

> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2692,8 +2692,9 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
>  				     probe_size - len);
>  			len += todo;
>  			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +			to->unreadable |= skb->unreadable;
>  			if (lastfrag &&
> -			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
> +			    skb_frag_netmem(fragfrom) == skb_frag_netmem(lastfrag) &&
>  			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
>  						      skb_frag_size(lastfrag)) {
>  				skb_frag_size_add(lastfrag, todo);

From [0]:

Maybe easier to not merge niovs here? Add '&& !skb_frag_is_net_iov' to
that 'if (lastfrag' check? (or your new skb_has_net_iovs)

Looks like it is tcp_mtu_probe path, not sure we care about merging there?

0: https://lore.kernel.org/netdev/86219505a92ebc720950d87dc76662f3@gmail.com/T/#m4dee51f9a8bf1600add71955d468a983e114d4b6
