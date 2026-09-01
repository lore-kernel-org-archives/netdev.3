Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111E3CB579
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234625; cv=none; b=MQfBpkA0zivKuwMP6v13u+VG8SLUkkyeDs1GOkM7UlH8SCGtQb6Q6PX2ntODTgyNDvRUbs8MtmfmsyyMNCN7nYc1cLUQ02KXu7+OiQl3rXYIhbh27fJQnt60ttDaFSb/Z02stc+TRs8XoB6V6VDwQJB13dugPaHRXmIJbwpaczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234625; c=relaxed/simple;
	bh=Igt94N9mHc9AM+xVGYbOdd5entWuLAAmHL+i+Nc8zOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJYSCXF5GppJ/16nc7dOsxb440l2QrBUw4E0TszLOAQKsHgjQCCLwA44z4zTMMIVwhWi7Cw7UL7lU2Cnks1JcjMM1eL9QLaqo+evEisH3MeCLvcNVarpnmG2X9DnO8vG8dtVeAwOXSHioT7VRwQN5hUJJIIhvP/X1Fvm3mYG8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sCRA5s3j; arc=none smtp.client-ip=91.218.175.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sCRA5s3j"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Igt94N9mHc9AM+xVGYbOdd5entWuLAAmHL+i+Nc8zOU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788234620; v=1; x=1788839420;
 b=sCRA5s3j/dRyMszHGA6yqlWaO5/kuANZOgHuQDnUucI6wNNi2yPw6EMeDi2OSwnX+D6Ga5Lb
 A274Hm99f9L9aM1m2XmKa9Mnu/IUs1oBMsfVjH5gEeIgexA+EQFqwVvGBGgaSz2txw9QcRLx0MV
 aN1rmbRQDHJ57+t2Fn5ZFKv8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c089a648f6b2069;
	Tue, 01 Sep 2026 03:50:09 +0000
X-Mizu-Trace-ID: 8c089a648f6b2069
X-Migadu-Flow: FLOW_OUT
Message-ID: <710b8c70-a7fb-484a-957f-ec230952739b@linux.dev>
Date: Tue, 1 Sep 2026 11:50:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
To: Ratheesh Kannoth <rkannoth@marvell.com>, davem@davemloft.net,
 gakula@marvell.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sgoutham@marvell.com
Cc: andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
References: <20260901015621.2708182-1-rkannoth@marvell.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260901015621.2708182-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026/9/1 9:56, Ratheesh Kannoth wrote:
> qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> regions (including CN10K LMTST areas that span page boundaries), so
> consumption grows with enabled interfaces and is hard to provision in CMA.
>
> Switch qmem to a streaming-DMA-style path: allocate physically contiguous
> compound pages from the buddy allocator via __get_free_pages(), then map
> them for device access with dma_map_phys() and dma_unmap_phys() using
> DMA_ATTR_REQUIRE_COHERENT. Add otx2_dma_alloc_coherent() and
> otx2_dma_free_coherent() helpers that enforce dev_is_dma_coherent(),
> retry with GFP_DMA32 when the physical range is outside the device DMA
> mask, and wire qmem_alloc()/qmem_free() through them instead of
> dma_alloc_attrs()/dma_free_attrs().

__get_free_pages() can only allocate memory in power-of-two pages. You 
can use alloc_pages_exact() and free_pages_exact() to save memory.

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

Can you confirm that no existing allocations exceeds MAX_PAGE_ORDER?

> cc: Geetha sowjanya <gakula@marvell.com>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>
> ---
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
> ---
>   .../ethernet/marvell/octeontx2/af/common.h    | 93 +++++++++++++++++--
>   1 file changed, 87 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b7..061dd907f7fa 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -7,6 +7,11 @@
>   #ifndef COMMON_H
>   #define COMMON_H
>   
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
>   #include "rvu_struct.h"
>   
>   #define OTX2_ALIGN			128  /* Align to cacheline */
> @@ -44,6 +49,83 @@ struct qmem {
>   	u32		qsize;
>   };
>   
> +/* Buddy-backed coherent DMA alloc (Option 3): pages from __get_free_pages(),
> + * DMA-reachable RAM via dma_coherent_ok(), and bus/SMMU mappings via
> + * dma_map_phys() -> iommu_dma_map_phys() -> iommu_map() on SMMU systems.
> + */
> +#define OTX2_DMA_COHERENT_ATTRS	DMA_ATTR_REQUIRE_COHERENT
> +
> +static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
> +					 size_t size)
> +{
> +	u64 mask = dma_get_mask(dev);
> +
> +	return paddr + size - 1 <= mask;
> +}
> +
> +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +	dma_addr_t dma_addr;
> +	unsigned int order;
> +	phys_addr_t paddr;
> +	void *vaddr;
> +	gfp_t alloc_gfp;
> +
> +	if (!dev || !dma_handle || !size)
> +		return NULL;
> +
> +	if (!dev_is_dma_coherent(dev))
> +		return NULL;
> +
> +	size = PAGE_ALIGN(size);
> +	order = get_order(size);
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;
> +
> +	alloc_gfp = (gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM)) |
> +		__GFP_ZERO | __GFP_COMP | __GFP_RECLAIM;
> +
> +	vaddr = (void *)__get_free_pages(alloc_gfp, order);
> +	while (vaddr &&
> +	       !otx2_dma_phys_in_mask(dev, page_to_phys(virt_to_page(vaddr)), size)) {

page_to_phys(virt_to_page(vaddr)) can be simplifed to virt_to_phys(vaddr).

> +		free_pages((unsigned long)vaddr, order);
> +		if (alloc_gfp & GFP_DMA32)
> +			return NULL;
> +		alloc_gfp |= GFP_DMA32;
> +		vaddr = (void *)__get_free_pages(alloc_gfp, order);
> +	}
> +	if (!vaddr)
> +		return NULL;
> +
> +	paddr = page_to_phys(virt_to_page(vaddr));

Same here.

> +	dma_addr = dma_map_phys(dev, paddr, size, DMA_BIDIRECTIONAL,
> +				OTX2_DMA_COHERENT_ATTRS);
> +	if (dma_mapping_error(dev, dma_addr)) {
> +		free_pages((unsigned long)vaddr, order);
> +		return NULL;
> +	}
> +
> +	*dma_handle = dma_addr;
> +	return vaddr;
> +}
Kind regards,
Qingfang
