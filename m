Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897956;
	b=NE1F0I5iUwKGyFeYYas1dtDiT/UYBAQ6OJu30AVbJ914XYVh6893hWBkh1dNqbqt0VyY
	 Za52LqhVUgDSl75i+WriqTKH+/4Ju3Hf8m57ZOGmB4kUFEiJscQFpOluAKeHdsCDk7nkK
	 UBZZ8/BZar8R8+wym+tlVDwIz+L53KGJxM9oVkXR+lSZ+YlfuS1Lv11vxo+b0GdZ3Ncf/
	 M79lII7vhEhhWXkLbUuUdx8kWgLvnYm60P9Zbs7N+VH4fYpUXC4MXhfvP+iu9YfeJFuUk
	 0evpgPdFkn6vT4OvghOU0CekixziSwbGRS2/1/Epx7YLYwGL1IEfgSXSToHC+bOWaiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BblA8xMRj2hShO9QEYp5l8nk1qexS+YtM6CJDTGE8oQ=;
	b=czphJkheo7zAyHLlHErZtVFR+ek1B791tB4dBnzekLLVZSgW3qAL0lzmQ7HARHhorCpT
	 poNc3QYNnz7QS5SetT49zobjFEB+pCRq18hTk3OPcLaTEUQNyJpfozdvuDFgp3iCGRrs8
	 iATxYWn6UKoeHN7RoIKuJs8AKnF5qMUTabZWMwQfdZyl+5MNCaNg/XguUY/yCiLItDeWZ
	 RZQ9z/Ax9PLwKjOrQe5qiwTg7xMpmDeE/AgN4B/qUKIaTm2QxOPHS+vSGNMHfsC1XrgbN
	 UAxdGvwP7hNsGxoCkWJx4WPpyLDJkuMAMzpcJOtOAnWca8QfASaHpA/nebKL9s5LexA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjWLQ7EV;
	arc=none smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A52606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56A52606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjWLQ7EV
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so264327eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897955; x=1794502755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BblA8xMRj2hShO9QEYp5l8nk1qexS+YtM6CJDTGE8oQ=;
        b=HjWLQ7EVFUE+4RNIIskJhCqwes51RsBjMRSwSz3ErDY1kU/7gs1uOeMgTCT5DQG6t+
         f8AFwK1fklYDwJzcXHNs6Y1Gke8+4VfWyoaRCKZybNYA5Jy7hUPqEOUecKzxyM1kThCk
         RbvsW51nt9wrrZAMUgfpb6LCQloOLZjpr8QUvyYNsmYdUGLcH1FqZ8CXlzM/YGEHq8Zs
         zRBRAdB7L+qY66ajgtSsuA0iOVBMhh9asFcWdC9tJ5l5L2DLDiV1r60HyPkqdqvUNMNp
         2nCBGLr0Xa85FJVcEtDHBUEcXvpdFJBHDLr+05QlSy7RT3phk6zX0z8BwhumNPWyrckS
         o6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897955; x=1794502755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BblA8xMRj2hShO9QEYp5l8nk1qexS+YtM6CJDTGE8oQ=;
        b=ADcQEWTuZT2vmd3WbcFkpa5AGuESoiIjTDIz0owSizf61f+57Sjq4I6gpXnUsci4AI
         ZB8g5ueqlaDmcqKiArChSRGrqwJRHwEi9linMOMI81IHzQQeAgGWJLNgPGU1dSg6JNr+
         a6uDQYWCi8cUiiizQNrkt8bP66a3ynoiQj51Pu5USfC/9yMo74G54rcMw9X5KTHngeKz
         6upULAUQCQmnXIKCyql3/vhx5tZJgT22JZYBheejn3cS3tr4hG2UJHvkg4GPrt0U/2nC
         k0//7bWtfSci50hv1DF5kO6RU84I/PmBE7jLuHV6x1trm5y1M2GJ5wHPiVGZxPnKBoiA
         xQew==
X-Forwarded-Encrypted: i=1; AKwUvBzM9eJlsQ9/nSxYhqPPdO1edSDOLJHe2Pvuw2/ugCw4GVXE9zjalJ0R4pLfwPp80hslVuZks7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KrlvhTwDgBYTk5CmPDqzy/DFPKz8iZ3yLtNYzLMuocqqtsEHU
	1T+toKoG//Q9MpXsgU0N0LEJMAOSe47bA29pT1tcaXPNvdeHHqg5/2W8
X-Gm-Gg: AYBFou3tgDct4G7jDHYXWkbQQ33H1QB55W/qcGUgQZ1Hw5GDWLgzQC28mp5kaW8MVLP
	2WcaZ8SAsfZhl2QgbcQYnnECdoQhGPYkrgfFVuhXRmIbhzCEqLgRpIXUZpWQIHHYwjIfU7NPcPq
	hFYxM2qEIbXSGvlBPX4n48xxYV0kW+g8FU0g0cNLCgs6UjcQGRdiWyRjtxmiyQeCPI4DJ1GHil8
	6P2ruvd40ixgvuBPmlUlKsUeg2bR0wH2/OXhj4P7OJPaWdIIPdYRzXeF7qLhhxpmSjYDhYH+ZtC
	X559RSPUbQ5IT50ccGc1ZcUOTzVsheQxIaJhjrpQxF5omZgJKj+19l193IGMXem63BwI+YS3PL2
	CkfIBSFSBlRN0hP99S0MdVosaa3kak0ZVunYiI5hHPeGTi8sNAbzu/uAO8d+2nYjWe2pP+HkSFT
	N4Uzzv5kFiTU/Q0IIesJCp/8NXRjsrbNPwc0AsqbIvbFsHaOr5Ho4Cdsr8R44B1LgkxMWccDV++
	HseYvH2ol8NumHL00s4Ne6OtMmssSNMB00YhZA45J7xYDgoeViGzEmPpQRlxBNXjURZ2jDVO/9X
	x1F1W5yAR3aHmhAAb81AWw==
X-Received: by 2002:a05:7022:b042:10b0:19d:233:989d with SMTP id a92af1059eb24-1b24f44feecmr4573967c88.14.1793897955219;
        Thu, 05 Nov 2026 08:59:15 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:41::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c30521sm19263403c88.13.2026.11.05.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:59:14 -0800 (PST)
Date: Thu, 5 Nov 2026 08:57:07 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Eric Dumazet <edumazet@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v3 2/2] net: prevent mixing frags from different
 memory providers or bindings
Message-ID: <auy0aaY0-g32aYi9@devvm16445.scu0.facebook.com>
References: <20261104042521.3979880-1-almasrymina@google.com>
 <20261104042521.3979880-3-almasrymina@google.com>
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
In-Reply-To: <20261104042521.3979880-3-almasrymina@google.com>

On 11/04, Mina Almasry wrote:
> Enforce that all fragments in a nonlinear skb come from compatible
> memory providers (and for devmem, the exact same binding):
> 
> - Add skb_has_net_iovs(skb), assuming skb->unreadable and net_iov-backed
>   frags are equivalent for now (with a comment noting the two can be
>   decoupled in the future if readable net_iovs are introduced).
> - Add skb_net_iov_provider(), skb_mem_provider_compat(), and
>   skb_frags_can_coalesce() so multi-skb coalescing, shifting, and GRO
>   paths can share a single check across pp_recycle, skb_zcopy(), and
>   fragment memory providers:
>   - empty skbs (!len && !nr_frags && !skb_has_net_iovs()) are compatible
>     without mixing readable payload
>   - page vs net_iov is rejected via skb_has_net_iovs() (0 pointer chases)
>   - page vs page is allowed via !skb_has_net_iovs() (0 pointer chases)
>   - net_iov vs net_iov compares net_iov_owner(niov) for devmem and
>     niov->desc.pp for other net_iov providers (e.g., io_uring zcrx)
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
> - Reject unreadable skbs in tcp_can_coalesce_send_queue_head() since
>   tcp_clone_payload() does not propagate skb->unreadable and merges
>   frags via skb_frag_page() (which returns NULL for net_iovs).
> 
> This issue is theoretical and was found by manual code inspection and
> LLM review; it was not triggered in production. Verified with the
> net_core KUnit test suite; not tested on real hardware.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  include/linux/skbuff.h | 74 ++++++++++++++++++++++++++++++++++++++++++
>  include/net/tcp.h      |  5 +--
>  net/core/datagram.c    |  4 +--
>  net/core/dev.c         | 14 +++-----
>  net/core/devmem.h      | 22 +++++++++++++
>  net/core/gro.c         | 16 +++------
>  net/core/net_test.c    | 39 ++++++++++++++++++----
>  net/core/skbuff.c      | 28 +++++++---------
>  net/ipv4/tcp.c         |  2 +-
>  net/ipv4/tcp_output.c  |  3 ++
>  10 files changed, 160 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6ac3e4..7723c24786c34 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1882,6 +1882,16 @@ static inline bool skb_frags_readable(const struct sk_buff *skb)
>  	return !skb->unreadable;
>  }
>  
> +/* Return true if frags in this skb are backed by net_iovs.
> + * Assumes skb->unreadable and net_iov-backed frags are equivalent for now;
> + * the two can be decoupled in the future if readable net_iovs in skbs are
> + * introduced.
> + */
> +static inline bool skb_has_net_iovs(const struct sk_buff *skb)
> +{
> +	return skb->unreadable;
> +}
> +
>  static inline void skb_mark_not_on_list(struct sk_buff *skb)
>  {
>  	skb->next = NULL;
> @@ -3763,6 +3773,70 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
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

[..]

> +	if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> +		return NULL;

(a few nits/questions)

Why !skb_has_net_iovs is not enough? (and if !nr_frags is required,
maybe fold it into skb_has_net_iovs?)

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
> +	void *prov1, *prov2;
> +

[..]

> +	if ((!skb1->len && !skb_shinfo(skb1)->nr_frags &&
> +	     !skb_has_net_iovs(skb1)) ||
> +	    (!skb2->len && !skb_shinfo(skb2)->nr_frags &&
> +	     !skb_has_net_iovs(skb2)))
> +		return true;

This deserves an explanation or a comment?

> +
> +	if (skb_has_net_iovs(skb1) != skb_has_net_iovs(skb2))
> +		return false;
> +

[..]

> +	if (!skb_has_net_iovs(skb1))
> +		return true;

This also seems extra? The bottom prov1 == prov2 covers this?

> +
> +	prov1 = skb_net_iov_provider(skb1);
> +	prov2 = skb_net_iov_provider(skb2);
> +	return prov1 && prov1 == prov2;
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
> index c4f476947dfaa..33817b9e7c007 100644
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

[..]

> +	if (!skb_has_net_iovs(skb) || !skb_shinfo(skb)->nr_frags)
> +		return NULL;

Same question here about 'why !nr_frags' is needed. Can we simplify
(or cover this in !skb_has_net_iovs)
