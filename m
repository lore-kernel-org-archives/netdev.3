Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747423AAF7A;
	Tue, 15 Sep 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460199; cv=none; b=b5uJH6XwI6jIArYD4iibjr0FS0ih2bMzrfHTrJwrnlXY0N9fOraRaHk+/7cd9Qil1SPjw0Rx0DnffCNX2mtTqYELT3UGn6UPPPj7GKu+w8rl5S2RlUFErgvec7eiAqtOgWzeLzfJcEf82O5a2FYr5ffhEPYi8qvTZNw4M3Nw5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460199; c=relaxed/simple;
	bh=4WcOkJHjRLjC4AKu9UPFI0KGx7DCrb78C8PL9fLCOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9NbIhV7ItwEDHdT3unBUhALF78z2tHWurVABER/UIPwa0mX/96ZcoUULL3ZGR1QIp0zReQgVSmiIoQjVEFlEOuqlAtcrjd4/Tw5d6w3Fu5DMqlhK76RIsL8VhZv0nEwPD6l8sA1xHeO0z3E7k6UiZG5GzFLQO8i/RYh22xSWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9uRY8/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9uRY8/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241121F000FF;
	Tue, 15 Sep 2026 08:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460198;
	bh=Hpy4v10/0kkxj2Bv1k7hazVd+W80HeuVCRsBuC8+OC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9uRY8/9SsQIseoFqwlz3GWOZVunC1nJvdw31xULiSIGnzLdcBIQWxghV81fa1wE3
	 BHQb7xrIfuV+NxB/mpSx5xHFy81Y0e3zycvAEkG/NZLaBWFuNYBJ9nQSqiJzsS8hS4
	 l/DSnjVQuwJ7q/jVM050M04BwcnMTAa9nMX9oLtHaxS2jbQ10dxAhsykBHQnTiYkIl
	 XDz7uZ7etW9LHnUI7Zl/wH81PUxEmFecYVRX4K/ttFihZZ5woW9Ef40uLI6j2SSI6z
	 6dctUyz1O4i7P7v+XgaVCGBuHDfolawCwaRO7qIC4KFOjLIpCdlu2pinnE4Xb9v8IS
	 H99ncHuubejMA==
Date: Tue, 15 Sep 2026 11:16:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v9 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <20260915081633.GH13683@unreal>
References: <20260911022649.573300-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911022649.573300-1-rkannoth@marvell.com>

On Fri, Sep 11, 2026 at 07:56:49AM +0530, Ratheesh Kannoth wrote:
> qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> regions (including CN10K LMTST areas that span page boundaries), so
> consumption grows with enabled interfaces and is hard to provision in CMA.
> 
> Switch qmem to a streaming-DMA-style path: allocate memory with kmalloc(),
> then map it for device access with dma_map_single(). Add
> otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers and wire
> qmem_alloc()/qmem_free() through them instead of dma_alloc_attrs()/
> dma_free_attrs().
> 
> This works on Octeon because the octeontx2 driver is written for
> DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
> the driver already uses streaming DMA APIs for packet data while
> deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
> The same IO coherency lets qmem use a streaming map of kmalloc-backed
> memory instead of a dedicated coherent allocator or CMA reservation. That
> is valid because the platform is DMA-coherent, not because omitting
> dma_sync_* magically makes memory coherent.
> 
> cc: Leon Romanovsky <leon@kernel.org>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")

The code itself looks fine now, but the commit message does not explain
why this patch is needed. It only describes what the patch does, which is
unnecessary here since the change itself is straightforward.

Also, no bug is described, so neither the Fixes tag nor the "net" target
is appropriate for this patch.

Thanks

> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v8 -> v9: Addressed Leon comment.
> - Used kzalloc instead of kmalloc.
> 
> v7 -> v8: Addressed Leon comments.
> - Replace __get_free_pages() and __GFP_COMP with kmalloc()
> - Drop GFP_DMA32 retry loop and dma_capable()/phys_to_dma() mask probing
> - Use dma_map_single()/dma_unmap_single() instead of dma_map_page_attrs()
>   with DMA_ATTR_REQUIRE_COHERENT
> - Remove defensive parameter checks and dma_max_mapping_size() from the
>   allocator helper
> - Move MAX_PAGE_ORDER validation to qmem_alloc()
> 
> v6 -> v7: Addressed Sashiko comments.
> 	https://lore.kernel.org/netdev/178863855246.219967.10510865726694393307@kernel.org/
> 
> v5 -> v6: Addressed review comments.
> 	https://lore.kernel.org/netdev/20260901015621.2708182-1-rkannoth@marvell.com/
> 
> v4 -> v5: Fixed compilation issues.
> 	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/
> 
> v3 -> v4: Fixed compilation issues.
> 	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/
> 
> v2 -> v3: Addressed sashiko comments.
> 	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com
> 
> v1 -> v2: Rewrote patch as per sashiko comment.
> ---
>  .../ethernet/marvell/octeontx2/af/common.h    | 45 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b7..78e42549d990 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -7,6 +7,10 @@
>  #ifndef COMMON_H
>  #define COMMON_H
>  
> +#include <linux/dma-mapping.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
>  #include "rvu_struct.h"
>  
>  #define OTX2_ALIGN			128  /* Align to cacheline */
> @@ -44,6 +48,33 @@ struct qmem {
>  	u32		qsize;
>  };
>  
> +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle)
> +{
> +	dma_addr_t dma_addr;
> +	void *vaddr;
> +
> +	vaddr = kzalloc(size, GFP_KERNEL);
> +	if (!vaddr)
> +		return NULL;
> +
> +	dma_addr = dma_map_single(dev, vaddr, size, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, dma_addr)) {
> +		kfree(vaddr);
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
> +	dma_unmap_single(dev, dma_handle, size, DMA_BIDIRECTIONAL);
> +	kfree(vaddr);
> +}
> +
>  static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  			     int qsize, int entry_sz)
>  {
> @@ -60,8 +91,11 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
> -	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
> -				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
> +
> +	if (get_order(PAGE_ALIGN(qmem->alloc_sz)) > MAX_PAGE_ORDER)
> +		return -ENOMEM;
> +
> +	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova);
>  	if (!qmem->base)
>  		return -ENOMEM;
>  
> @@ -80,10 +114,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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
