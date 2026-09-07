Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4F479886;
	Mon,  7 Sep 2026 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780771; cv=none; b=elnnh2egPwu7JgrSXc9ktbotJvagAfoc4Vzroq3vjuBSHq/q5poDolhS3+urQD9y5iUBXUlvANMXiyaZFGvtbk3YO2ebLgPSmEr860G516XvSyYRcxtaO1cojJWqRDDkuI7TZX9HaMsXkaxjs0W0Gn3wFZUJSrfGykJjIsFWHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780771; c=relaxed/simple;
	bh=Eryxkc+5uZyy4HoMtxI4QtWpECagGBo+0fE0foLxOFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDSIlLbaFWZDiyUV/ZlbL3IPz3WBUdkv1z9loM/+aNFgq/LUvipwvJBi6VGdTb4kLK0TSqOlN0jyIkO6ziEhHfyTg6ta+8IxbU3b0dxNLvYwJCHi8sIwWUZ5wEjVDuu8kRcN6oay2svamT0wGUiVntnolhZW8uX9iqz4WKEakNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEGOAoGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEGOAoGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA01F00A3A;
	Mon,  7 Sep 2026 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780769;
	bh=uSwnGHna/HhpEuW+/2vue0u2qq89fYjiX092bCBvH2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LEGOAoGQ0zFB3jVJCmP0i8rjFzdsuB5BWykhpY0TenwRgb9ulXf1XQ0Wibi0gNksT
	 qLsGBgamLKjNHTnhQ00l171qwl4bxT+eIAogZqLOWPEWg3pxYymBdOLcEcLp0idpul
	 EJJJjoOyyy56n1XviKGX75bZd1qJYgiTzxtVkVhZh+JB6SjFrybb5gD2zvK7CFP33J
	 xWCd+RxOVKYrf31DKa8t/sjs2lE7O2iIo1HsGD5IuJmoMDPSnnwY3o2bQPfSF1H/0s
	 J4ymO5tIJYuBzVdPa/R/C2clHYEcxz+1mXD0BCTqSDQLkZo4R91K26OAwit1JZGHoH
	 1vP1uWt9uKyLw==
Date: Mon, 7 Sep 2026 14:32:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v7 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <20260907113244.GJ13683@unreal>
References: <20260907042617.4076723-1-rkannoth@marvell.com>
 <20260907072055.GF13683@unreal>
 <ap6VHVYnXcUcMTNG@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap6VHVYnXcUcMTNG@rkannoth-OptiPlex-7090>

On Mon, Sep 07, 2026 at 04:12:37PM +0530, Ratheesh Kannoth wrote:
> On 2026-09-07 at 12:50:55, Leon Romanovsky (leon@kernel.org) wrote:
> > On Mon, Sep 07, 2026 at 09:56:16AM +0530, Ratheesh Kannoth wrote:
> > > qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> > > allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> > > the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> > > regions (including CN10K LMTST areas that span page boundaries), so
> > > consumption grows with enabled interfaces and is hard to provision in CMA.
> > >
> > >
> > > v1 -> v2: Rewrote patch as per sashiko comment
> >
> > Your changelog says nothing. It should contain bullet points describing
> > what was actually changed. A generic "Addressed Sashiko comments" is not
> > sufficient.
> 
> Thanks for pointing this out. I relied on the Sashiko link to avoid
> over-cluttering the notes, as sashiko coments are many.
> I will make sure to explicitly list all notable changes in the
> changelog in future revisions.
> 
> > >
> > > +static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
> > > +					 size_t size)
> > > +{
> > > +	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
> > > +
> > > +	return dma_capable(dev, dma_addr, size, true, 0);
> >
> > This line makes no sense in the driver code.
> 
> ACK. will remove internal APIs
> 
> >
> > > +}
> > > +
> > > +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> > > +					    dma_addr_t *dma_handle)
> > > +{
> > > +	dma_addr_t dma_addr;
> > > +	unsigned int order;
> > > +	gfp_t alloc_gfp;
> > > +	void *vaddr;
> > > +
> > > +	if (!dev || !dma_handle || !size)
> > > +		return NULL;
> >
> > Please remove defensive programming style, how can you call to DMA API
> > without device, dma_handle or size?
> ACK.
> 
> >
> > > +
> > > +	if (!dev_is_dma_coherent(dev))
> > > +		return NULL;
> > > +
> > > +	size = PAGE_ALIGN(size);
> > > +	order = get_order(size);
> > > +
> > > +	/* Octeontx2 qmem call sites size their allocations within
> > > +	 * MAX_PAGE_ORDER; mailbox, queue context, and ring memory
> > > +	 * requirements stay below the buddy allocator's limit.
> > > +	 */
> > > +	if (order > MAX_PAGE_ORDER) {
> >
> > Size is coming from the kernel, how can it be with order more than MAX_PAGE_ORDER?
> There is contigious memory allocation request from driver for PF-to-VF mail box memory.
> It is crossing max page order in newer platforms as number of VFs per PF increased.

I'm not sure what this means. You can't create a VF without assigning it
enough memory for DMA. You shouldn't get an "order > MAX_PAGE_ORDER"
error at this stage. If you do, there is likely another bug involved.

Thanks

> 
> >
> > > +		dev_err(dev,
> > > +			"CONFIG_ARCH_FORCE_MAX_ORDER is set to %u, minimum needed is %u\n",
> > > +			MAX_PAGE_ORDER, order);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	if (size > dma_max_mapping_size(dev))
> > > +		return NULL;
> >
> > Same comment.
> Will remove this code and depend on dma_map_page_attrs().
> 
> >
> > > +
> > > +	alloc_gfp = GFP_KERNEL | __GFP_ZERO | __GFP_COMP;
> >
> > __GFP_COMP???
> Will remove this flag.
> 
> >
> > > +
> > > +	vaddr = (void *)__get_free_pages(alloc_gfp, order);
> >
> > You should use plain ksmalloc(). There was ongoing effort to remove
> > useless __get_free_pages().
> > https://lore.kernel.org/all/20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org/
> will replace get_free_pages with kmalloc.
> 
> >
> > > +	while (vaddr &&
> > > +	       !otx2_dma_phys_in_mask(dev, virt_to_phys(vaddr), size)) {
> > > +		free_pages((unsigned long)vaddr, order);
> > > +		if (alloc_gfp & GFP_DMA32)
> > > +			return NULL;
> > > +		alloc_gfp |= GFP_DMA32;
> > > +		vaddr = (void *)__get_free_pages(alloc_gfp, order);
> > > +	}
> >
> > If you want to use streamline API, please use it like any other driver
> > without these DMA32 hacks.
> Will kmalloc() with GFP_ZERO | GFP_KERNEL
> 
> >
> > > +	if (!vaddr)
> > > +		return NULL;
> > > +
> > > +	/* dev_is_dma_coherent() only guarantees cache coherency, not that the
> > > +	 * mapped DMA address aliases qmem->base.  Require a coherent mapping
> > > +	 * so the DMA API rejects SWIOTLB bounce buffers.
> > > +	 */
> > > +	dma_addr = dma_map_page_attrs(dev, virt_to_page(vaddr), 0, size,
> > > +				      DMA_BIDIRECTIONAL, DMA_ATTR_REQUIRE_COHERENT);
> >
> > I don't understand why you insist on DMA_ATTR_REQUIRE_COHERENT. It is
> > clearly documented as being required for UAPI-visible memory.
> ACK.
> I overlooked this uAPI part, as  AI tool recommended adding
> this logic to reject allocations with SWIOTLB or cache management
> support.
