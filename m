Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8974369D7D;
	Wed, 23 Sep 2026 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207191; cv=none; b=rTyDQq9vWO9J1LEXHO5imxliJmhsWD9WjC+cxVWHQkB5g2UIAAdgL6DL5j3dE3voTpHYCKCPcL7/Jjv53IE4TWCrMK4M/8mqBpRzk9zzr+4xBssePbCzI1yhiW/D0ezjS/R3U0zNjB1oROXZ2E5zKC9RVJd5ae8Y0onx4ZuahrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207191; c=relaxed/simple;
	bh=AWydxPzmRb1CohhTYoZZq3OqoUHv1pUxxzBpLjcMG/A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGUpmelsMbnjmXlqyn4ynXcJSe5LLJzBtJPZZ0yYjpoa2IKoyG4Jn8RrQ1gwjz612Y0AO0Y3u7KfJIrODEy6kS7sThnUbqUr2Zjjy8YctQ4wl5czdMb4CA4OF+C85gkk4cVvlzuzy2EO6oEx+q+x1WWVrndpH7l/sOAYXkS6Qgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ7993uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ7993uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D51F000FF;
	Wed, 23 Sep 2026 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207189;
	bh=hF/pDuqLUfEL4enlyWMhBbX6DHx3mD9gHwLhe/KnO64=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mQ7993uz7Z5EeKhewJMrqV/FZFcDta1hvhYsAOg5VuMqcYzgJQ5EHR0wsR4e2qOq/
	 0vdC27Bn3ipjjzHUIakbCNVwgnIdQzAe1JZzJx8v8zkVP6q+Yswt3loi11mjLTrTlu
	 boDdnacKEzaNjRplsPVbWFqtE46a1vf0W192cCmCe6Hmu9tc1hFGGcbVd/rfC6fS4q
	 pkt2Q/pqWLbjhx4KQSyv075dvl6JgbgW6hxngHzB+UAslwNRGvnsMFVunOdRs/ZXy4
	 hCPh6YOIq9BkbxQnr0H+HBIE1kgkL+stR51daDte7VqraVw+9hvBUy6HSJAOf9Rsbc
	 pVsQY5VEqAUcA==
Subject:
 Re: [PATCH net-next 1/3] net: netmem: add net_iov_area freelist helpers
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk,
 sdf@fomichev.me, bobbyeshleman@meta.com, almasrymina@google.com,
 kaiyuanz@google.com, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Date: Wed, 23 Sep 2026 23:46:27 +0000
Message-ID: <179020718794.2160803.10755922661656548396@kernel.org>
In-Reply-To: <20260922204348.717198-2-sdf@fomichev.me>
References: <20260922204348.717198-2-sdf@fomichev.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net/core/devmem.h: the refactor moves `spinlock_t
  freelist_lock` from the tail of `struct net_devmem_dmabuf_binding`…

Pre-existing issues:
- [Medium] In `net_devmem_bind_dmabuf()` (net/core/devmem.c) the per-sg-
  entry population loop advances `niov_idx` over the whole mapped…

--

net: netmem: add net_iov_area freelist helpers

This moves the bounded LIFO freelist that io_uring zcrx and devmem each
maintained into struct net_iov_area, and adds net_iov_area_pop() and
net_iov_area_push() helpers. The freelist now stores u32 indices instead of
pointers, and devmem rejects areas with more than U32_MAX entries before
narrowing num_niovs to u32.

> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index bccacd21b6c37..da885d95ea63b 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -101,10 +101,15 @@ struct net_iov {
>  struct net_iov_area {
>  	/* Array of net_iovs for this area. */
>  	struct net_iov *niovs;
> -	size_t num_niovs;
> +
> +	/* Stack of free net_iov indices. */
> +	u32 *freelist;
>  
>  	/* Offset into the dma-buf where this chunk starts.  */
>  	unsigned long base_virtual;
> +
> +	u32 num_niovs;
> +	u32 free_count;
>  };
>  
>  static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
> @@ -117,6 +122,27 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
>  	return niov - net_iov_owner(niov)->niovs;
>  }
>  
> +static inline struct net_iov *net_iov_area_pop(struct net_iov_area *area)
> +{
> +	u32 idx;
> +
> +	if (unlikely(!area->free_count))
> +		return NULL;
> +
> +	idx = area->freelist[--area->free_count];
> +	return &area->niovs[idx];
> +}
> +
> +static inline void net_iov_area_push(struct net_iov_area *area,
> +				     struct net_iov *niov)
> +{
> +	if (WARN_ON_ONCE(net_iov_owner(niov) != area ||
> +			 area->free_count >= area->num_niovs))
> +		return;
> +
> +	area->freelist[area->free_count++] = net_iov_idx(niov);
> +}
> +

[ ... io_uring/zcrx.c, io_uring/zcrx.h snipped ... ]

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index a9d86b5a55885..c1c1872b88de2 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -67,12 +67,10 @@ net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
>  
>  	spin_lock_bh(&binding->freelist_lock);
>  
> -	count = min_t(size_t, count, binding->free_count);
> -	for (i = 0; i < count; i++) {
> -		struct net_iov *niov = binding->freelist[--binding->free_count];
> -
> -		netmems[i] = net_iov_to_netmem(niov);
> -	}
> +	count = min(count, binding->area.free_count);
> +	for (i = 0; i < count; i++)
> +		netmems[i] =
> +			net_iov_to_netmem(net_iov_area_pop(&binding->area));
>  
>  	spin_unlock_bh(&binding->freelist_lock);
>  
> @@ -84,12 +82,7 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>  	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
>  
>  	spin_lock_bh(&binding->freelist_lock);
> -	if (WARN_ON_ONCE(binding->free_count >= binding->area.num_niovs)) {
> -		spin_unlock_bh(&binding->freelist_lock);
> -		return;
> -	}
> -
> -	binding->freelist[binding->free_count++] = niov;
> +	net_iov_area_push(&binding->area, niov);
>  	spin_unlock_bh(&binding->freelist_lock);
>  }

[ ... ]

> @@ -279,7 +279,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  			if (direction == DMA_TO_DEVICE)
>  				binding->tx_vec[niov_idx] = niov;
>  			else
> -				binding->freelist[binding->free_count++] = niov;
> +				net_iov_area_push(&binding->area, niov);
>  			dma_addr += niov_size;
>  		}
>  	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the conversion makes the
population loop in net_devmem_bind_dmabuf() look better validated than it
actually is.

The freelist store is now bounds-checked inside net_iov_area_push(), which
warns and drops the entry when free_count reaches num_niovs. The two
sibling writes in the very same iteration are still unbounded:

	nr_niovs = len >> niov_shift;
	for (i = 0; i < nr_niovs; i++, niov_idx++) {
		niov = &binding->area.niovs[niov_idx];
		net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
		if (net_mp_niov_set_dma_addr(niov, dma_addr)) {
			...
		}
		if (direction == DMA_TO_DEVICE)
			binding->tx_vec[niov_idx] = niov;
		else
			net_iov_area_push(&binding->area, niov);

niov_idx accumulates across every sg entry and is never compared against
binding->area.num_niovs, which is derived only from
dmabuf->size >> niov_shift. The loop checks per-entry alignment
(IS_ALIGNED(dma_addr, niov_size), IS_ALIGNED(len, niov_size)) but never that
the summed sg length equals dmabuf->size.

Can area.niovs[] and tx_vec[] be written past their ends if an exporter's
mapped sg_table covers more bytes than dmabuf->size?

In the other direction, if the mapping is shorter than dmabuf->size, can the
tail of tx_vec be dereferenced as struct net_iov *? It is allocated with
kvmalloc_objs() and never zeroed:

	binding->tx_vec = kvmalloc_objs(struct net_iov *,
					binding->area.num_niovs);

I could not construct this with an in-tree exporter (udmabuf, dma-heaps and
DRM PRIME all map exactly the object size), and I did not find an explicit
dma-buf API guarantee that the mapped sg length equals dmabuf->size either.
Would it be worth bounding niov_idx against area.num_niovs, or zeroing
tx_vec, while the push side is being touched here?

This is still the case at the end of the series (3ee6ae62e2d2): the later
patch "net: devmem: use memory provider helpers for net_iovs" zeroes
area.niovs but leaves tx_vec unzeroed and niov_idx unbounded.

> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index f71d9a2bcb3d3..5edb763b89b26 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -17,6 +17,9 @@ struct netlink_ext_ack;
>  
>  struct net_devmem_dmabuf_binding {
>  	struct net_iov_area area;
> +	/* Protects area.freelist and area.free_count. */
> +	spinlock_t freelist_lock;
> +
>  	struct dma_buf *dmabuf;
>  	struct dma_buf_attachment *attachment;
>  	struct sg_table *sgt;
> @@ -57,10 +60,6 @@ struct net_devmem_dmabuf_binding {
>  	/* rxq's this binding is active on. */
>  	struct xarray bound_rxqs;
>  
> -	spinlock_t freelist_lock ____cacheline_aligned_in_smp;
> -	size_t free_count;
> -	struct net_iov **freelist;
> -

[Severity: Medium]
The ____cacheline_aligned_in_smp annotation on freelist_lock is dropped
here, and the lock moves from the tail of the binding to right after the
embedded struct net_iov_area. Was that intentional?

With the new area layout (niovs at 0, freelist at 8, base_virtual at 16,
num_niovs at 24, free_count at 28) the write-hot lock word and free_count
end up in the same 64-byte line as the read-mostly area.niovs and
area.base_virtual.

The writers dirty that line on every allocation and release:

net/core/devmem.c:net_devmem_alloc_dmabuf_bulk() {
	spin_lock_bh(&binding->freelist_lock);
	count = min(count, binding->area.free_count);
	...
}

net/core/devmem.c:net_devmem_free_dmabuf() {
	spin_lock_bh(&binding->freelist_lock);
	net_iov_area_push(&binding->area, niov);
	...
}

while the receive path reads the same line per fragment, via
net_iov_idx() -> net_iov_owner(niov)->niovs and
net_devmem_iov_virtual_addr() -> net_iov_owner(niov)->base_virtual.

In the common devmem setup, where page pool refill/release runs on a
different core than the recvmsg() consumer, does this re-introduce the false
sharing the removed annotation was there to prevent?

The commit message says:

    Keep devmem's area adjacent to its lock.

but it does not mention removing the SMP cacheline isolation, and no numbers
are given. Annotating freelist_lock (or the lock plus free_count pair)
____cacheline_aligned_in_smp again would keep the refactor intact.

I checked the end of the series (3ee6ae62e2d2) and net/core/devmem.h still
declares the lock right after the area with no ____cacheline_aligned_in_smp,
so nothing later restores it.

>  	/* ID of this binding. Globally unique to all bindings currently
>  	 * active.
>  	 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922204348.717198-1-sdf%40fomichev.me
