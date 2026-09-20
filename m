Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844528C009;
	Sun, 20 Sep 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938080; cv=none; b=JvH/EDw/f71WiJovbmMrarNvsm0eMUpj4tR6i1puqtaBpqIpeqyRx8vgRCiYrDbFVhaxs6JV7LZcK26dDKdlhbpylO0I3b/bZrY91wYFfI9iswGfStvf8uIEp4ODZNU18UZbJZmT8LwaInPwVu12gM0JV+02pjoE4oBd7xFGqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938080; c=relaxed/simple;
	bh=dzrFmzREZdA/NlqgWry4425SORTpLjv8soalDKbQv8s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuoVKKi6OiOZ4REfcd4vnGGS4Sexsk+U4sj2PVisYpmfNbPBEtW6tkzQGmLUBk0MYNR8DX+zm+uikaLFwzp2qKdctywUzOU0GOc3EgAGT1Ne7O/Ins7JJdDtIHWVfQ8gPjZlxm2y0jgXKOCZJSnglMkcdx/Vwq5E+/g8g099y2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LssfaTuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LssfaTuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E91F00893;
	Sun, 20 Sep 2026 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789938079;
	bh=q9/HCBOpVKb1/6WnFqrB+rxgaVuA/u2dNkE48QiqQ1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LssfaTuH6g9xcjavH5OeN/FnDn78KG28cRuGb1FjIZDcQwChrA3nYU/tOZA9sK9CX
	 tWMI2WnspgPDkLDFOxAsz4XJcyl2Ttf2Bg6jCMBtGqR1tjcEbwbnwNLVG4PQXvXbfk
	 vyI0+n7rCFm9x184pbaTh73OialRI4OWe37Xo+mFlIftK91JcDG8RIDrkQPfezaGH3
	 iPiCTrmGZvpJql30RyDYtdV0LlytUcfPPYFkHdBZlHXutR9PcXZCI6RwmaLkVATQ5a
	 qgL6WLmFhpnGEe5sODt6hmGnF4Ca07AWbO/5Mk/QwoLJOYS7nZ00OE4gn0014bXZUj
	 BIWcKi1Xk3y1Q==
Subject:
 Re: [PATCH net-next v3 1/3] net: devmem: replace gen_pool with freelist
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 21:01:17 +0000
Message-ID: <178993807798.2160803.6987249829072277558@kernel.org>
In-Reply-To: <20260917181116.3319017-2-sdf@fomichev.me>
References: <20260917181116.3319017-2-sdf@fomichev.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net_devmem_bind_dmabuf() (net/core/devmem.c) sizes all per-
  binding arrays from the declared DMA-BUF size (total_niovs =…
- [Low] net_devmem_free_dmabuf() replaces
  gen_pool_free()/gen_pool_has_addr() with a bare LIFO push guarded only…

Pre-existing issues:
- [Low] net_devmem_bind_dmabuf() ignores the return value of
  page_pool_set_dma_addr_netmem() when recording each net_iov's DMA…

--

net: devmem: replace gen_pool with freelist

This replaces the per-binding gen_pool with a binding-level LIFO freelist of
net_iov pointers protected by spin_lock_bh(), using a single net_iov_area
owner per binding and filling each net_iov DMA address while walking the SG
table. It also validates the DMA-BUF size against the net_iov size up front,
derives the RX and TX entry counts from that size, and drops the NET_DEVMEM
select of GENERIC_ALLOCATOR.

A few questions below.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..2ac9d74010a9f 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -62,24 +51,20 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  {
>  	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
>  
> -	size_t size, avail;
> -
> -	gen_pool_for_each_chunk(binding->chunk_pool,
> -				net_devmem_dmabuf_free_chunk_owner, NULL);
> -
> -	size = gen_pool_size(binding->chunk_pool);
> -	avail = gen_pool_avail(binding->chunk_pool);
> -
> -	if (!WARN(size != avail, "can't destroy genpool. size=%zu, avail=%zu",
> -		  size, avail))
> -		gen_pool_destroy(binding->chunk_pool);
> +	if (binding->freelist)
> +		WARN(binding->free_count != binding->chunk_owner->area.num_niovs,
> +		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%zu",
> +		     binding->chunk_owner->area.num_niovs,
> +		     binding->free_count);

[ ... ]

> @@ -113,14 +92,16 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  void net_devmem_free_dmabuf(struct net_iov *niov)
>  {
>  	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
> -	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
> -	size_t niov_size = 1UL << binding->niov_shift;
>  
> -	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
> -				       niov_size)))
> +	spin_lock_bh(&binding->freelist_lock);
> +	if (WARN_ON_ONCE(binding->free_count >=
> +			 binding->chunk_owner->area.num_niovs)) {
> +		spin_unlock_bh(&binding->freelist_lock);
>  		return;
> +	}
>  
> -	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
> +	binding->freelist[binding->free_count++] = niov;
> +	spin_unlock_bh(&binding->freelist_lock);
>  }

[Severity: Low]
This isn't a bug in the new code as such, but the check in
net_devmem_free_dmabuf() is now only an aggregate capacity test, while the
gen_pool path it replaces also caught a repeated release of the same
net_iov:

gen_pool_free() -> gen_pool_free_owner() -> bitmap_clear_ll()
	BUG_ON(remain);

The freelist keeps no per-niov state, so pushing the same net_iov twice
while other net_iovs are still outstanding passes the
free_count >= area.num_niovs test and is accepted silently. After that,
net_devmem_alloc_dmabuf() and net_devmem_alloc_dmabuf_bulk() can hand the
same net_iov, and hence the same DMA region, to two independent consumers,
and the duplicate can also let free_count reach area.num_niovs at teardown
while an object is still in flight, so the new WARN in
__net_devmem_dmabuf_binding_free() stays quiet.

Reaching this requires a separate page_pool refcount bug, since
mp_dmabuf_devmem_release_page() rejects refcount != 1, so this is only a
loss of a fail-stop diagnostic. Is dropping that check intentional to match
io_uring zcrx, which uses the same unguarded LIFO?

[ ... ]

> @@ -249,33 +233,55 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		goto err_detach;
>  	}
>  
> +	if (!IS_ALIGNED(dmabuf->size, niov_size)) {
> +		err = -EINVAL;
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "dmabuf size %zu not aligned to niov size %zu",
> +				   dmabuf->size, niov_size);
> +		goto err_unmap;
> +	}
> +
> +	total_niovs = dmabuf->size >> niov_shift;
>  	if (direction == DMA_TO_DEVICE) {
> -		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
> -			err = -EINVAL;
> -			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
> +		binding->tx_vec = kvmalloc_objs(struct net_iov *, total_niovs);
> +		if (!binding->tx_vec) {
> +			err = -ENOMEM;
>  			goto err_unmap;
>  		}
> -		binding->tx_vec = kvmalloc_objs(struct net_iov *,
> -						dmabuf->size / PAGE_SIZE);
> -		if (!binding->tx_vec) {
> +	} else {
> +		spin_lock_init(&binding->freelist_lock);
> +		binding->freelist = kvmalloc_array(total_niovs,
> +						   sizeof(binding->freelist[0]),
> +						   GFP_KERNEL);
> +		if (!binding->freelist) {
>  			err = -ENOMEM;
>  			goto err_unmap;
>  		}
>  	}

[ ... ]

> +	owner->area.base_virtual = 0;
> +	owner->area.num_niovs = total_niovs;
> +	owner->binding = binding;
> +	owner->area.niovs = kvmalloc_objs(*owner->area.niovs,
> +					  owner->area.num_niovs);
> +	if (!owner->area.niovs) {
>  		err = -ENOMEM;
> -		goto err_tx_vec;
> +		goto err_free_owner;
>  	}
> +	binding->chunk_owner = owner;
>  
> -	virtual = 0;
> +	niov_idx = 0;
>  	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {

[ ... ]

> @@ -283,64 +289,40 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
> -		for (i = 0; i < owner->area.num_niovs; i++) {
> -			niov = &owner->area.niovs[i];
> +		nr_niovs = len >> niov_shift;
> +		for (i = 0; i < nr_niovs; i++, niov_idx++) {
> +			niov = &owner->area.niovs[niov_idx];
>  			net_iov_init(niov, &owner->area, NET_IOV_DMABUF);
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
> -						      net_devmem_get_dma_addr(niov));
> +						      dma_addr);

[Severity: Low]
This is a pre-existing issue and not introduced here, since the baseline
call site discarded the same value, but while this line is being rewritten:
the return value of page_pool_set_dma_addr_netmem() is dropped.

On PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA the helper reports a lossy store:

net/core/page_pool_priv.h:page_pool_set_dma_addr_netmem() {
	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
				       << PAGE_SHIFT;
	}
	...
}

page_pool_dma_map() treats that as fatal with WARN_ONCE plus unmap, and
io_uring zcrx checks the equivalent net_mp_niov_set_dma_addr() return.
Would it be worth failing the bind here as well?

The two failure modes look unreachable today: non-page-aligned addresses are
excluded by niov_shift >= PAGE_SHIFT plus the IS_ALIGNED(dma_addr,
niov_size) check above, and the truncation case needs a DMA address beyond
16 TB on a 32-bit-with-64-bit-DMA system.

>  			if (direction == DMA_TO_DEVICE)
> -				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> +				binding->tx_vec[niov_idx] = niov;
> +			else
> +				binding->freelist[binding->free_count++] = niov;
> +			dma_addr += niov_size;
>  		}
> -
> -		virtual += len;
>  	}

[Severity: Medium]
Can this walk overrun owner->area.niovs[], binding->freelist[] and
binding->tx_vec[]?

All three arrays are sized from the declared DMA-BUF size:

	total_niovs = dmabuf->size >> niov_shift;

but they are filled from the exporter's DMA-mapped SG table, with niov_idx
and free_count advancing once per sg entry chunk:

		nr_niovs = len >> niov_shift;
		for (i = 0; i < nr_niovs; i++, niov_idx++) {

There is no niov_idx + nr_niovs > total_niovs guard inside the loop and no
niov_idx == total_niovs check after it. The only new validation is
IS_ALIGNED(dmabuf->size, niov_size) plus the per-sg-entry address and length
alignment, and none of those relate the SG table's total coverage to
dmabuf->size.

If sum(sg_dma_len) exceeds dmabuf->size, net_iov_init() writes past the end
of the kvmalloc'd area.niovs[] and the pointer stores run past the end of
freelist[] or tx_vec[].

If it is shorter, the tail of area.niovs[] and tx_vec[] stays uninitialized,
since kvmalloc_objs() does not zero, and then:

  - RX free_count can never equal area.num_niovs, so the new WARN in
    __net_devmem_dmabuf_binding_free() fires on every unbind even with no
    outstanding net_iovs;

  - net_devmem_get_niov_at() validates the user offset only against
    binding->dmabuf->size:

	if (virt_addr >= binding->dmabuf->size)
		return NULL;
	...
	return binding->tx_vec[virt_addr / PAGE_SIZE];

    so an unpopulated tx_vec slot is handed to the TX path as a garbage
    net_iov pointer.

Before this patch the RX side sized each owner->area.niovs from that sg
entry's own len >> niov_shift, so an SG/size disagreement could not overrun
the net_iov metadata; that structural guarantee goes away here without a
replacement check.

For what it is worth, the io_uring model the commit message says this
mirrors does check both directions: io_import_dmabuf() sums sg_dma_len() and
rejects total_size != len, and io_zcrx_map_area_dmabuf() bounds its walk and
post-checks niov_idx != num_niovs.

The in-tree exporters I looked at (udmabuf, dma-heaps, drm_prime) do build
SG tables totalling dmabuf->size, and the iommu-dma path preserves total
segment length, so I could not demonstrate an in-tree trigger. But
dma_buf_export() only records exp_info->size and never validates the
sg_table returned later by map_dma_buf, so nothing in the dma-buf core
enforces the invariant this code now depends on. Would adding the sum check
or the post-loop equality check be worthwhile?

>  	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
>  			      binding, xa_limit_32b, &id_alloc_next,
>  			      GFP_KERNEL);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917181116.3319017-1-sdf%40fomichev.me
