Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A619383C95;
	Thu, 10 Sep 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052420; cv=none; b=ZLDg8IVjJIeS6blqrZBcDuGsT0mupsmymCHZ0HKv5oYuY+BsXCyiSWG0deoDht67dXydK1TPcqwhJc/UHKeTmTM+vl7VVCqDJPHmYGZSy+83oULSrKJvl9lPWvdZVr29ObcEr2G/gBzGEVwanF6u6W2zHO4Urytim/1eGrU0b4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052420; c=relaxed/simple;
	bh=OgCf/EbQMVyH6G6TXP43FLA2Ksxvf73yc8ffBuqMpBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBboEbdFtm0nj9r8XwgS3DONpO7t/IJRawZHJm1gkQSukkyzOTVharffcBoGD4zGbHFeV3qLyKBzLVmQvh39ICE0Q7zN3UYMalvbfjlIOfWnSh+y4uWxGoOgi8o9hPDEMSOhFjTW1HQDCXCZ482mQhqUovTSR/EzGpv462tnJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8R9mQGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8R9mQGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273E21F00893;
	Thu, 10 Sep 2026 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052418;
	bh=PMYNdJ4Zjr+51JyD7Eo5iQ8q4At/IKBF8JY0RCqZTA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I8R9mQGcOFY71yGlt2rEFhUQzz4nAWSeWMF7IqocBlNuO7vL1mBgudVU+XmCr0wlc
	 1Ca0Hcbwow5FLAGrPcfO6lmoIcX1l5rJMQpanIELFgDK8lsCJqn6dH6hfUfYaRiFl2
	 C3jookfK9TLPff8Hsq5D7XwZDfdAc/vgC1G+X1c9X96iMgoLpdaoPcgxD9JiKNqkYt
	 kBBfqg84JaYjbHw5+1+RHW/NWSBDt6XP85LAKE6cA9NLZoYSHxY3BzhxIIDFrc6DDL
	 n5E3e7ZzepyTjs++0T6ZQFIdGji9qrw+zemo+wEQseojCE3KgEkHEqR+yorJfYEIvD
	 6FzSIKdL1hktw==
Date: Thu, 10 Sep 2026 18:00:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v8 net-next] octeontx2-af: switch qmem from coherent DMA
 alloc to streaming DMA mapping
Message-ID: <20260910150014.GR13683@unreal>
References: <20260908063411.257228-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908063411.257228-1-rkannoth@marvell.com>

On Tue, Sep 08, 2026 at 12:04:11PM +0530, Ratheesh Kannoth wrote:
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
> cc: Geetha sowjanya <gakula@marvell.com>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> v7 -> v8: Addressed Leon comments.
> - Replace __get_free_pages() and __GFP_COMP with kmalloc()
> - Drop GFP_DMA32 retry loop and dma_capable()/phys_to_dma() mask probing
> - Use dma_map_single()/dma_unmap_single() instead of dma_map_page_attrs()
>   with DMA_ATTR_REQUIRE_COHERENT
> - Remove defensive parameter checks and dma_max_mapping_size() from the
>   allocator helper
> - Move MAX_PAGE_ORDER validation to qmem_alloc()
> - Retain dev_is_dma_coherent() guard in otx2_dma_alloc_coherent()
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
> index 779413a383b7..0569b6d9f03b 100644
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
> +	vaddr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);

This is kzalloc(size, GFP_KERNEL)

Thanks
