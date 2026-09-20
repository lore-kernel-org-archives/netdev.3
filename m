Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A13515FD;
	Sun, 20 Sep 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938081; cv=none; b=rhZ3pwam0Ll9kA/7wjGKEsEKvWvR7MgKv4zCekS5WdQW2hLAKTPCi9PRMgJoWfrrzCC171eDFV/FUi9j6uPQSufp9i+xx59gg1b2dTPUjoWOlMhOuSVzNgKmTorp3x3SPRPkjj7ctDEQN6SMT5UWq1XezeYgRCXPoK4P+E5SrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938081; c=relaxed/simple;
	bh=g6cPWX7j/9o5MxNW1pkqfk/LmUuv8uZGyZ3e4yRRcC0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qs6bh/Nksr+onPa460F/sA7AMmi5k64xZqkvOCN5+J0Lrst3Jy78Fsaia8NK5GY8Y4h0fTDmf8IzroNc108WbDQ04xNLN/lzqExCc9rGR2FntYKTUjoOfu/bx7Ajz03N3OC2E4vWtoZCVI4sS233ZWoJ9Rx4J1Mfx7LLN990Lpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LukJCmoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LukJCmoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6281F00898;
	Sun, 20 Sep 2026 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789938080;
	bh=5I+T/Z99HkjtvA11SNCZ2Ec833d07YGNRal7u+qd1EU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LukJCmocX9F09FNymFVQjbxZI0ckTVaehneWkJcf/WAfmSMn78B2K700BiHR9pBtK
	 a/ijpprovcmoOuRcrqXwdCQP7/Vwbtm8ekIeyx/0SSXLEtQphte/bskDrA200SwQ/B
	 cK0wzDS5Kj6Zj5Ab+oiujCp9H9bLz6Lm0CQn501TRAbmnywPF6LWMIxB+OTHCSYLLj
	 G400hiwK4j/g7rdroTwaMC3x1jgghL8aW4i3SgDJDaZLoXokiwtcMhBFRilp5DBiSC
	 SrsvGq0WJH0JUmPzHRY5U94Y4kKHNucBZKz9pIiI7xarb6m+zZDZmSlQqkMh7GwscD
	 A0RwmbgrxWfdw==
Subject:
 Re: [PATCH net-next v3 2/3] net: devmem: embed net_iov_area in binding
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 bobbyeshleman@meta.com, almasrymina@google.com, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 21:01:19 +0000
Message-ID: <178993807923.2160803.4802601925465816308@kernel.org>
In-Reply-To: <20260917181116.3319017-3-sdf@fomichev.me>
References: <20260917181116.3319017-3-sdf@fomichev.me>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net_devmem_bind_dmabuf() (net/core/devmem.c) sizes all three
  per-binding arrays from dmabuf->size (`binding->area.num_niovs =…

--

net: devmem: embed net_iov_area in binding

The chunk owner object is dropped and the single net_iov_area is stored
directly in struct net_devmem_dmabuf_binding.  net_devmem_iov_binding()
now derives the binding with container_of() on net_iov_owner(), and the
dmabuf_genpool_chunk_owner wrapper plus its alloc/free path are removed.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 2ac9d74010a9f..7cac0dab8ea87 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -52,12 +43,11 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
>  
>  	if (binding->freelist)
> -		WARN(binding->free_count != binding->chunk_owner->area.num_niovs,
> +		WARN(binding->free_count != binding->area.num_niovs,
>  		     "destroying dmabuf binding with outstanding net_iovs: total=%zu, free=%zu",
> -		     binding->chunk_owner->area.num_niovs,
> -		     binding->free_count);
> +		     binding->area.num_niovs, binding->free_count);

[ ... ]

> @@ -241,16 +228,18 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		goto err_unmap;
>  	}
>  
> -	total_niovs = dmabuf->size >> niov_shift;
> +	binding->area.base_virtual = 0;
> +	binding->area.num_niovs = dmabuf->size >> niov_shift;
>  	if (direction == DMA_TO_DEVICE) {
> -		binding->tx_vec = kvmalloc_objs(struct net_iov *, total_niovs);
> +		binding->tx_vec = kvmalloc_objs(struct net_iov *,
> +						binding->area.num_niovs);
>  		if (!binding->tx_vec) {
>  			err = -ENOMEM;
>  			goto err_unmap;
>  		}
>  	} else {
>  		spin_lock_init(&binding->freelist_lock);
> -		binding->freelist = kvmalloc_array(total_niovs,
> +		binding->freelist = kvmalloc_array(binding->area.num_niovs,
>  						   sizeof(binding->freelist[0]),
>  						   GFP_KERNEL);
>  		if (!binding->freelist) {

[ ... ]

> @@ -289,13 +267,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		nr_niovs = len >> niov_shift;
>  		for (i = 0; i < nr_niovs; i++, niov_idx++) {
> -			niov = &owner->area.niovs[niov_idx];
> -			net_iov_init(niov, &owner->area, NET_IOV_DMABUF);
> +			niov = &binding->area.niovs[niov_idx];
> +			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      dma_addr);
>  			if (direction == DMA_TO_DEVICE)

[Severity: Medium]
Can this loop in net_devmem_bind_dmabuf() write past
binding->area.niovs[], binding->freelist[] and binding->tx_vec[]?

All three arrays are now sized from the dmabuf size:

	binding->area.num_niovs = dmabuf->size >> niov_shift;

but the fill loop advances niov_idx (and binding->free_count) purely from
the mapped scatter-gather lengths, with no comparison against
binding->area.num_niovs:

	nr_niovs = len >> niov_shift;
	for (i = 0; i < nr_niovs; i++, niov_idx++) {
		niov = &binding->area.niovs[niov_idx];
		...
		if (direction == DMA_TO_DEVICE)
			binding->tx_vec[niov_idx] = niov;
		else
			binding->freelist[binding->free_count++] = niov;

The only per-entry check before this is
IS_ALIGNED(dma_addr, niov_size) / IS_ALIGNED(len, niov_size), which
constrains neither the total nor the index, and nothing sums
sg_dma_len() over binding->sgt to confirm it equals dmabuf->size.  If an
exporter's mapped sgt describes more bytes than dmabuf->size, does this
store net_iov contents, DMA addresses and net_iov pointers beyond the end
of the three allocations?

In the other direction, if the sgt describes fewer bytes than
dmabuf->size, the tail of tx_vec[] stays uninitialized (kvmalloc, not
zeroed), while net_devmem_get_niov_at() bounds the user-supplied offset
only against the dmabuf size:

	if (virt_addr >= binding->dmabuf->size)
		return NULL;
	...
	return binding->tx_vec[virt_addr / PAGE_SIZE];

Can that return a garbage pointer that is then used as a struct net_iov?
For the RX case the same shortfall would leave free_count below
area.num_niovs, so the teardown WARN in
__net_devmem_dmabuf_binding_free() quoted above would fire on every
unbind.

Before this series the RX niovs were sized per scatter-gather entry
(owner->area.num_niovs = len >> niov_shift), so an sgt/size mismatch
could not overrun them; the count is now derived from dmabuf->size with
no bound check added.

The io_uring zcrx code this series says it mirrors performs both checks -
io_import_dmabuf() sums sg_dma_len() and rejects a mismatch:

	for_each_sgtable_dma_sg(mem->sgt, sg, i)
		total_size += sg_dma_len(sg);

	if (total_size != len) {
		ret = -EINVAL;
		goto err;
	}

and io_populate_area_dma() bounds its fill loop with
while (sg_len && niov_idx < area->nia.num_niovs).  Would it make sense to
do the same here, either by validating the sg total against dmabuf->size
or by capping niov_idx at binding->area.num_niovs?

I could not identify an in-tree exporter that provably returns an sgt
whose total differs from dmabuf->size, so this may not be reachable
today; the gap does still appear to be present at the end of the series
(0942efb741d9 does not touch net_devmem_bind_dmabuf()).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917181116.3319017-1-sdf%40fomichev.me
