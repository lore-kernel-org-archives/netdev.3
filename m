Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2730649C;
	Tue,  1 Sep 2026 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236848; cv=none; b=onP+SYEACdXn7CYvEbkViHdFcBmzR8finTa1mDKV9FxUwO5zos7OISNLrQ+P1L58cX4UKLqc+bBnU0M7zjm5DxNSOPcFHXKpFvhWfHt49RRJPMLboU5Ma53d5nNJ1VSeFv6pFzovPypyWYm/q+Mbu//qsnvyPYwf7MrZwNlAFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236848; c=relaxed/simple;
	bh=muRkWO7Tp34zgl3pqZqCwAacrwRwlWxq6BDlBE6EEKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIi2OIQMBndy+mI33xEWnotLnlYU5azo4Tpdwdiq8DWkQQ114oFCd7QjuWHQSoH5C3oU24VyxpbDVGv0ty/yiCNPAMMbJyNjHN47+rq3q8g95GYzoyJmVDrw0Enq8pyeBk5802c4qLXO4+rWF5n+68iPKkrvmI1GFISUkMgspYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Of5z6iNS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Of5z6iNS"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6811G4XN2183940;
	Mon, 31 Aug 2026 21:27:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=N31moCfPPwymPMZk+/+3+Jk5b
	XNyQsO1Ut2mXUB2vu4=; b=Of5z6iNSkFzZL44AzxbkeY7kHq5pX5tMSXbQo3UK1
	w7vKYwYQA7T1DxbzRYfoFcU47y65Yw0uFIR2KQceeoZKdrinUchFSvaTXKRFW0NI
	EH0qQ1oOFeSdoG4Xb1zRxgJrmaF7t5GGEQFmMzmIX74OMAWIk3KS0c03kjcvqjAA
	Zy6fSmpyLVeI9pfaEiuGleI7++uqLbM1PATDWUCQiinuoQHs8fP2mEB6vZk2la5M
	S3OhvJ6lONV2Ps8DLNd+MN/uBOIOrNRRxX2DCn29f5Tj89YGY8w6+XgH6mCWJ3Ka
	eYSuoYxP8MS2lJE7DMpQYsl3AEbZbf93nlAHrVIDIdD3w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gdmvqrhfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 21:27:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 21:27:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 21:27:15 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 674995B6926;
	Mon, 31 Aug 2026 21:27:12 -0700 (PDT)
Date: Tue, 1 Sep 2026 09:57:06 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v5 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <apZUGpdCKJZiX_ta@rkannoth-OptiPlex-7090>
References: <20260901015621.2708182-1-rkannoth@marvell.com>
 <710b8c70-a7fb-484a-957f-ec230952739b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <710b8c70-a7fb-484a-957f-ec230952739b@linux.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAzNiBTYWx0ZWRfX0k8dgLRfCc8f
 t7s2wT1JVpiPZIm09Cdj1/3SVHta1YPCVY03qSgDMwswv48iSlnAGueWCxMs2mBD2tnzTvBwlb2
 /sCYiqzn3+PAGW/0oC+/XQj1jnJW4hBavKAYyPu8XWuHwSZE6I8Lg9Iza0MDXBvlrc0pMtLjWg6
 IVeU4pzRPjnOcytZ73ALdnKy/Xd9zWdpyiG0ZNcHQOp9rg6LeUddZe4M6rHSjYGDl/jo9kun55q
 WKq61V5PW06mIpRI3R3csbUjpQ7srdhqnhOlGxpBD+D0uH2PanCGputiBqJwR7HRAyvZIGz4TdD
 qWzBxMWX/hw/kIv/NHrhy8QL78zKv0I9gJWEMlBAvuq4aTOu/N4KXfV8CvLMVfcc2E8FtmnPtP0
 jbhgVhF7PVaxjzfDV0WYO5M0v1exivQGmnqkxF5LfhEQNYnNxk4FWoo1bxVehE8fKpqVQCtQScQ
 l0g+DwJTAtzzTFSxwHg==
X-Authority-Analysis: v=2.4 cv=HYQkiCE8 c=1 sm=1 tr=0 ts=6a965424 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8 a=OB1bGeSAjrwdn4wCMFAA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: Rn_fEmMohaCO7R3hHCwegbU6HtiujxBF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAzNiBTYWx0ZWRfX3vNUIolV2eB+
 +v45RPVQ/xO+V+6NFafLPmp630fJDXsvrxHDQLF//EOe6D3yFxJx89/Pq++EiWvdR4qH6crf68E
 ORzDfj0h4XbSzSMX0g6ioFK68yD954c=
X-Proofpoint-GUID: Rn_fEmMohaCO7R3hHCwegbU6HtiujxBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

On 2026-09-01 at 09:20:01, Qingfang Deng (qingfang.deng@linux.dev) wrote:
> Hi,
>
> On 2026/9/1 9:56, Ratheesh Kannoth wrote:
> > qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> > allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> > the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> > regions (including CN10K LMTST areas that span page boundaries), so
> > consumption grows with enabled interfaces and is hard to provision in CMA.
> >
> > Switch qmem to a streaming-DMA-style path: allocate physically contiguous
> > compound pages from the buddy allocator via __get_free_pages(), then map
> > them for device access with dma_map_phys() and dma_unmap_phys() using
> > DMA_ATTR_REQUIRE_COHERENT. Add otx2_dma_alloc_coherent() and
> > otx2_dma_free_coherent() helpers that enforce dev_is_dma_coherent(),
> > retry with GFP_DMA32 when the physical range is outside the device DMA
> > mask, and wire qmem_alloc()/qmem_free() through them instead of
> > dma_alloc_attrs()/dma_free_attrs().
>
> __get_free_pages() can only allocate memory in power-of-two pages. You can
> use alloc_pages_exact() and free_pages_exact() to save memory.
Thank you ! will take it as an enhancement to net-next tree after this patch is merged.

>
> > This works on Octeon because the octeontx2 driver is written for
> > DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
> > the driver already uses streaming DMA APIs for packet data while
> > deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
> > The same IO coherency lets qmem use a streaming map of buddy-allocated
> > pages instead of a dedicated coherent allocator or CMA reservation. That
> > is valid because the platform is DMA-coherent, not because omitting
> > dma_sync_* magically makes memory coherent.
> >
> > Allocations requiring more than MAX_PAGE_ORDER pages are still rejected,
> > since the buddy allocator cannot serve them without CMA.
>
> Can you confirm that no existing allocations exceeds MAX_PAGE_ORDER?
Tested this patch on cn10k platforms.

>
> > cc: Geetha sowjanya <gakula@marvell.com>
> > Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> > Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> >
> > ---
> >
> > v4 -> v5: Fixed compilation issues.
> > 	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/
> >
> > v3 -> v4: Fixed compilation issues.
> > 	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/
> >
> > v2 -> v3: Addressed sashiko comments
> > 	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com
> >
> > v1 -> v2: Rewrote patch as per sashiko comment
> > ---
> >   .../ethernet/marvell/octeontx2/af/common.h    | 93 +++++++++++++++++--
> >   1 file changed, 87 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> > index 779413a383b7..061dd907f7fa 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> > @@ -7,6 +7,11 @@
> >   #ifndef COMMON_H
> >   #define COMMON_H
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dma-map-ops.h>
> > +#include <linux/gfp.h>
> > +#include <linux/mm.h>
> > +
> >   #include "rvu_struct.h"
> >   #define OTX2_ALIGN			128  /* Align to cacheline */
> > @@ -44,6 +49,83 @@ struct qmem {
> >   	u32		qsize;
> >   };
> > +/* Buddy-backed coherent DMA alloc (Option 3): pages from __get_free_pages(),
> > + * DMA-reachable RAM via dma_coherent_ok(), and bus/SMMU mappings via
> > + * dma_map_phys() -> iommu_dma_map_phys() -> iommu_map() on SMMU systems.
> > + */
> > +#define OTX2_DMA_COHERENT_ATTRS	DMA_ATTR_REQUIRE_COHERENT
> > +
> > +static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
> > +					 size_t size)
> > +{
> > +	u64 mask = dma_get_mask(dev);
> > +
> > +	return paddr + size - 1 <= mask;
> > +}
> > +
> > +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> > +					    dma_addr_t *dma_handle, gfp_t gfp)
> > +{
> > +	dma_addr_t dma_addr;
> > +	unsigned int order;
> > +	phys_addr_t paddr;
> > +	void *vaddr;
> > +	gfp_t alloc_gfp;
> > +
> > +	if (!dev || !dma_handle || !size)
> > +		return NULL;
> > +
> > +	if (!dev_is_dma_coherent(dev))
> > +		return NULL;
> > +
> > +	size = PAGE_ALIGN(size);
> > +	order = get_order(size);
> > +	if (order > MAX_PAGE_ORDER)
> > +		return NULL;
> > +
> > +	alloc_gfp = (gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM)) |
> > +		__GFP_ZERO | __GFP_COMP | __GFP_RECLAIM;
> > +
> > +	vaddr = (void *)__get_free_pages(alloc_gfp, order);
> > +	while (vaddr &&
> > +	       !otx2_dma_phys_in_mask(dev, page_to_phys(virt_to_page(vaddr)), size)) {
>
> page_to_phys(virt_to_page(vaddr)) can be simplifed to virt_to_phys(vaddr).
ACK.

>
> > +		free_pages((unsigned long)vaddr, order);
> > +		if (alloc_gfp & GFP_DMA32)
> > +			return NULL;
> > +		alloc_gfp |= GFP_DMA32;
> > +		vaddr = (void *)__get_free_pages(alloc_gfp, order);
> > +	}
> > +	if (!vaddr)
> > +		return NULL;
> > +
> > +	paddr = page_to_phys(virt_to_page(vaddr));
>
> Same here.
ACK.
>
> > +	dma_addr = dma_map_phys(dev, paddr, size, DMA_BIDIRECTIONAL,
> > +				OTX2_DMA_COHERENT_ATTRS);
> > +	if (dma_mapping_error(dev, dma_addr)) {
> > +		free_pages((unsigned long)vaddr, order);
> > +		return NULL;
> > +	}
> > +
> > +	*dma_handle = dma_addr;
> > +	return vaddr;
> > +}
> Kind regards,
> Qingfang
