Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C283B0AF8;
	Mon,  7 Sep 2026 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765662; cv=none; b=DJYzF2JAXcU4DFjptvJHGA2OkJe1ZCEw/yssG0pYcC2A/cWrZDNgQhYlMANj7+GJKsZHQ4ieCOsV8kC9pCtebh83PH7rHBNr9t3Fe4F3d6cOpp8GiLzsT0Q5J/znDpYktujF0CF2Em2xgxwYCS+xOjR9WM/eJf3MS7UeBLrefsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765662; c=relaxed/simple;
	bh=mHKyplDpMnkx1uTKj5BFGnKcUH8YmAQC9USBmMyMm4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmbNswGMJYGXYfb6Ta6Yg/clv9ZtKZFxhvkc1lhc2ITNMmd8CEusUOzsKVipeBkXuj6SgrcAbdnajRih7uJYNvWKN1M7lJgxrEW071so6Qpm7ewgFF1Yly+bl9CG/CXUyEY7yd6H5yPpeNrnrJwFjWvXCLI1YW6+VCbXaM8Bc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QssIiPdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QssIiPdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765451F00A3A;
	Mon,  7 Sep 2026 07:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788765660;
	bh=Fh4nIXEc46CLzKEaUTzNpdWpkc0RIh50f/WAlJVmzzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QssIiPdoKluxQNZbkf+oqDFslHn3cnqbW3yvcXmGD0mpA45+04tehXgB7ND+nY5gk
	 c73yf0ziOfW25KdugDr/WCmf61YGIRG+VtRCtdQBpnpE2WbNWeN5IK3I40I9CEHR2d
	 eaqdYpN3RmhGRrSHYuCsRNH8UHvkQVbirtvcmJdJwTPBb4ijGEbVFl2Oa23fTjCwz/
	 /eDdpCsrodwggrZQTXFsKye7c7mW9FRrRvdOzP/LHN2bMlKW4ZLe3smjPUvTSoYevU
	 IwrDX0urqYNZANhirtHBi4ZB3bP7mLUuZq4/wVn3OefUtnD3RXNTWwK6X7gEp7MZTl
	 Fs5hFKF74QbfA==
Date: Mon, 7 Sep 2026 10:20:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v7 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <20260907072055.GF13683@unreal>
References: <20260907042617.4076723-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907042617.4076723-1-rkannoth@marvell.com>

On Mon, Sep 07, 2026 at 09:56:16AM +0530, Ratheesh Kannoth wrote:
> qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> regions (including CN10K LMTST areas that span page boundaries), so
> consumption grows with enabled interfaces and is hard to provision in CMA.
> 
> Switch qmem to a streaming-DMA-style path: allocate physically contiguous
> compound pages from the buddy allocator via __get_free_pages(), then map
> them for device access with dma_map_page_attrs(). Add
> otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers that
> enforce dev_is_dma_coherent(), retry with GFP_DMA32 when the physical
> range is outside the device DMA mask, and wire qmem_alloc()/qmem_free()
> through them instead of dma_alloc_attrs()/dma_free_attrs().
> 
> This works on Octeon because the octeontx2 driver is written for
> DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
> the driver already uses streaming DMA APIs for packet data while
> deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
> The same IO coherency lets qmem use a streaming map of buddy-allocated
> pages instead of a dedicated coherent allocator or CMA reservation. That
> is valid because the platform is DMA-coherent, not because omitting
> dma_sync_* magically makes memory coherent.
> 
> Allocations requiring more than MAX_PAGE_ORDER pages are still rejected,
> since the buddy allocator cannot serve them without CMA.
> 
> cc: Geetha sowjanya <gakula@marvell.com>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v6 -> v7: Addressed Sashiko comments
> 	https://lore.kernel.org/netdev/178863855246.219967.10510865726694393307@kernel.org/
> 
> v5 -> v6: Addressed Review comments
> 	https://lore.kernel.org/netdev/20260901015621.2708182-1-rkannoth@marvell.com/
> 
> v4 -> v5: Fixed compilation issues.
> 	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/
> 
> v3 -> v4: Fixed compilation issues.
> 	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/
> 
> v2 -> v3: Addressed sashiko comments
> 	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com
> 
> v1 -> v2: Rewrote patch as per sashiko comment

Your changelog says nothing. It should contain bullet points describing
what was actually changed. A generic "Addressed Sashiko comments" is not
sufficient.

> ---
>  .../ethernet/marvell/octeontx2/af/common.h    | 99 +++++++++++++++++--
>  1 file changed, 93 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b7..cca2ae22c753 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -7,6 +7,11 @@
>  #ifndef COMMON_H
>  #define COMMON_H
>  
> +#include <linux/dma-direct.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
>  #include "rvu_struct.h"
>  
>  #define OTX2_ALIGN			128  /* Align to cacheline */
> @@ -44,6 +49,90 @@ struct qmem {
>  	u32		qsize;
>  };
>  
> +static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
> +					 size_t size)
> +{
> +	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
> +
> +	return dma_capable(dev, dma_addr, size, true, 0);

This line makes no sense in the driver code.

> +}
> +
> +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle)
> +{
> +	dma_addr_t dma_addr;
> +	unsigned int order;
> +	gfp_t alloc_gfp;
> +	void *vaddr;
> +
> +	if (!dev || !dma_handle || !size)
> +		return NULL;

Please remove defensive programming style, how can you call to DMA API
without device, dma_handle or size?

> +
> +	if (!dev_is_dma_coherent(dev))
> +		return NULL;
> +
> +	size = PAGE_ALIGN(size);
> +	order = get_order(size);
> +
> +	/* Octeontx2 qmem call sites size their allocations within
> +	 * MAX_PAGE_ORDER; mailbox, queue context, and ring memory
> +	 * requirements stay below the buddy allocator's limit.
> +	 */
> +	if (order > MAX_PAGE_ORDER) {

Size is coming from the kernel, how can it be with order more than MAX_PAGE_ORDER?

> +		dev_err(dev,
> +			"CONFIG_ARCH_FORCE_MAX_ORDER is set to %u, minimum needed is %u\n",
> +			MAX_PAGE_ORDER, order);
> +		return NULL;
> +	}
> +
> +	if (size > dma_max_mapping_size(dev))
> +		return NULL;

Same comment.

> +
> +	alloc_gfp = GFP_KERNEL | __GFP_ZERO | __GFP_COMP;

__GFP_COMP???

> +
> +	vaddr = (void *)__get_free_pages(alloc_gfp, order);

You should use plain ksmalloc(). There was ongoing effort to remove
useless __get_free_pages().
https://lore.kernel.org/all/20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org/

> +	while (vaddr &&
> +	       !otx2_dma_phys_in_mask(dev, virt_to_phys(vaddr), size)) {
> +		free_pages((unsigned long)vaddr, order);
> +		if (alloc_gfp & GFP_DMA32)
> +			return NULL;
> +		alloc_gfp |= GFP_DMA32;
> +		vaddr = (void *)__get_free_pages(alloc_gfp, order);
> +	}

If you want to use streamline API, please use it like any other driver
without these DMA32 hacks.

> +	if (!vaddr)
> +		return NULL;
> +
> +	/* dev_is_dma_coherent() only guarantees cache coherency, not that the
> +	 * mapped DMA address aliases qmem->base.  Require a coherent mapping
> +	 * so the DMA API rejects SWIOTLB bounce buffers.
> +	 */
> +	dma_addr = dma_map_page_attrs(dev, virt_to_page(vaddr), 0, size,
> +				      DMA_BIDIRECTIONAL, DMA_ATTR_REQUIRE_COHERENT);

I don't understand why you insist on DMA_ATTR_REQUIRE_COHERENT. It is
clearly documented as being required for UAPI-visible memory.

> +	if (dma_mapping_error(dev, dma_addr)) {
> +		free_pages((unsigned long)vaddr, order);
> +		return NULL;
> +	}
> +
> +	*dma_handle = dma_addr;
> +	return vaddr;
> +}
> +
> +static inline void otx2_dma_free_coherent(struct device *dev, size_t size,
> +					  void *vaddr, dma_addr_t dma_handle)
> +{
> +	unsigned int order;
> +
> +	if (!dev || !vaddr)
> +		return;
> +
> +	size = PAGE_ALIGN(size);
> +	order = get_order(size);
> +
> +	dma_unmap_page_attrs(dev, dma_handle, size, DMA_BIDIRECTIONAL,
> +			     DMA_ATTR_REQUIRE_COHERENT);
> +	free_pages((unsigned long)vaddr, order);
> +}
> +
>  static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  			     int qsize, int entry_sz)
>  {
> @@ -60,8 +149,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
> -	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
> -				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
> +	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova);
>  	if (!qmem->base)
>  		return -ENOMEM;
>  
> @@ -80,10 +168,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
>  		return;
>  
>  	if (qmem->base)
> -		dma_free_attrs(dev, qmem->alloc_sz,
> -			       qmem->base - qmem->align,
> -			       qmem->iova - qmem->align,
> -			       DMA_ATTR_FORCE_CONTIGUOUS);
> +		otx2_dma_free_coherent(dev, qmem->alloc_sz,
> +				       qmem->base - qmem->align,
> +				       qmem->iova - qmem->align);
>  	devm_kfree(dev, qmem);
>  }
>  
> -- 
> 2.43.0
> 
> 
