Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB7466B13;
	Mon,  7 Sep 2026 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777784; cv=none; b=pygR0Q/1essffkFpQNoFZC6NgtfW/g49MGjuf7wg1WMYCuDuAMBKO6Ij7fqI6N6kd0WKZeFm3kIuGG97IgKhSa2+nOzvk11tee79hXfPnkXSmp5I8BfQ/oakzP94yHsghGL7QaRGR7sf0MutT7av1g2pp0AjLB4IOPxpnCqfdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777784; c=relaxed/simple;
	bh=O/3lZmd9Tpd763kgMr0bM6yO6JuGxJgP5YkA6idLypk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8SjyfpzVaXQ7vay6EahtgPNe2dcKC19OfUpwFjrKbIQMK5wFSbvuO+lvAD5DDRa4m/w+B262omstsm6ZVL6kRddarsO4PywSMfTIEQ0lFTUk6Xj7Qv0YAB9tJNmYL73dpw7vrhMryODVLNJqiX/3BcMPDjYYvuJ3SpVR6uDlgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AZxhbdaR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AZxhbdaR"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879agJj1383010;
	Mon, 7 Sep 2026 03:42:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=21KkDWdAktLy8YBRu2XNERHvz
	oGhoA4qLRHPo612CP8=; b=AZxhbdaRBzTcnsgOieIK7DYU+L3GYLq4k8qxfGVKR
	xEjOJjhHzJa4MzvOfB98+N5cubsWREqi7K1Na3SWIf5LYmi3ar5fJNQbx0F4XGfx
	ZQ+1HUmVthXbBMlhMjN2KS0/9f0ipZUhSaV39nyvYdMBQL7mPRecwCZbYNexC+KE
	kBTeQh/JSY1MoIzKNEvDfjQxuYG2mKXkQ/mjVIu5lcnQ45pafntLV8OFTcpgYeOz
	jGNy03H4a6kj3IvrrKb8pLkhCR7IvPvRtJYOoFpi60bu+uj7GJBk0wOKf0SeSPe1
	ZsK6Ip8ZMvMNrmEuNvzUlOQcHoLdiDqKcll6I34VNVsZg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gh7b924dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:42:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 03:42:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 03:42:46 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2FC7E3F70B2;
	Mon,  7 Sep 2026 03:42:42 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:12:37 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Leon Romanovsky <leon@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v7 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <ap6VHVYnXcUcMTNG@rkannoth-OptiPlex-7090>
References: <20260907042617.4076723-1-rkannoth@marvell.com>
 <20260907072055.GF13683@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907072055.GF13683@unreal>
X-Authority-Analysis: v=2.4 cv=J/SaKgnS c=1 sm=1 tr=0 ts=6a9e9527 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=Uh9ost2sU1c5p5usfAIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: euHD3zQKkzUx4wl-4ojpyI_FWWP2TXcl
X-Proofpoint-ORIG-GUID: euHD3zQKkzUx4wl-4ojpyI_FWWP2TXcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExNyBTYWx0ZWRfX3iiz+5Mr799q
 jWynMEkZ+WRRcL+Y6G33GQMf/TjUdS0pYXwrHN2t7GuaOh0F+31bA0hWZ6W0CAbn1HlKSSClnfu
 /PJvf7mMIbIpkHEoKispS2W8CdnLOVjUals9xp+rU9ThXYR28Ns27nRYtaSwaIEnrNNA0A2XLeV
 UJ1bSHeEzHSGWrB6cuoZAWWVluLl3HTw5YEO5/4ptR2TCHyotYmUPsIQUBEbjzhagHOZP1OeGbB
 p047VzE97Xsq1417wFmpJ/zAUBTsBhmPE+tlvjSL8OpxT2Calk6uDrcp4ELaV5xf98u1TfNn/EQ
 tPAAq6XsfomgoZaGIr6qviex/So5ain32CP1R3QHQbyDvlBLHAwuQaF1uKV7HXJqJU8cDA/QsIX
 kjt5QIZAFywUZdP6Imuz5H6WC90kOtL/jLqTiXG6SLlC2PJApqJ0hjgG7BBh9waJgz7GkZ/qOs1
 MS5I1KUe5176T4nKvOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExNyBTYWx0ZWRfXyntdYQsZArLK
 IzO/EAChEl9Gk6wXP/AVZTH8lvFmLY7TwK4g+9EDoVxIFjiI2qsDPZK69biTroYlk4875IKWyOp
 Q0kPmo2GXXmZobCcenWLYToQed2aNR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01

On 2026-09-07 at 12:50:55, Leon Romanovsky (leon@kernel.org) wrote:
> On Mon, Sep 07, 2026 at 09:56:16AM +0530, Ratheesh Kannoth wrote:
> > qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> > allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> > the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> > regions (including CN10K LMTST areas that span page boundaries), so
> > consumption grows with enabled interfaces and is hard to provision in CMA.
> >
> >
> > v1 -> v2: Rewrote patch as per sashiko comment
>
> Your changelog says nothing. It should contain bullet points describing
> what was actually changed. A generic "Addressed Sashiko comments" is not
> sufficient.

Thanks for pointing this out. I relied on the Sashiko link to avoid
over-cluttering the notes, as sashiko coments are many.
I will make sure to explicitly list all notable changes in the
changelog in future revisions.

> >
> > +static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
> > +					 size_t size)
> > +{
> > +	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
> > +
> > +	return dma_capable(dev, dma_addr, size, true, 0);
>
> This line makes no sense in the driver code.

ACK. will remove internal APIs

>
> > +}
> > +
> > +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> > +					    dma_addr_t *dma_handle)
> > +{
> > +	dma_addr_t dma_addr;
> > +	unsigned int order;
> > +	gfp_t alloc_gfp;
> > +	void *vaddr;
> > +
> > +	if (!dev || !dma_handle || !size)
> > +		return NULL;
>
> Please remove defensive programming style, how can you call to DMA API
> without device, dma_handle or size?
ACK.

>
> > +
> > +	if (!dev_is_dma_coherent(dev))
> > +		return NULL;
> > +
> > +	size = PAGE_ALIGN(size);
> > +	order = get_order(size);
> > +
> > +	/* Octeontx2 qmem call sites size their allocations within
> > +	 * MAX_PAGE_ORDER; mailbox, queue context, and ring memory
> > +	 * requirements stay below the buddy allocator's limit.
> > +	 */
> > +	if (order > MAX_PAGE_ORDER) {
>
> Size is coming from the kernel, how can it be with order more than MAX_PAGE_ORDER?
There is contigious memory allocation request from driver for PF-to-VF mail box memory.
It is crossing max page order in newer platforms as number of VFs per PF increased.

>
> > +		dev_err(dev,
> > +			"CONFIG_ARCH_FORCE_MAX_ORDER is set to %u, minimum needed is %u\n",
> > +			MAX_PAGE_ORDER, order);
> > +		return NULL;
> > +	}
> > +
> > +	if (size > dma_max_mapping_size(dev))
> > +		return NULL;
>
> Same comment.
Will remove this code and depend on dma_map_page_attrs().

>
> > +
> > +	alloc_gfp = GFP_KERNEL | __GFP_ZERO | __GFP_COMP;
>
> __GFP_COMP???
Will remove this flag.

>
> > +
> > +	vaddr = (void *)__get_free_pages(alloc_gfp, order);
>
> You should use plain ksmalloc(). There was ongoing effort to remove
> useless __get_free_pages().
> https://lore.kernel.org/all/20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org/
will replace get_free_pages with kmalloc.

>
> > +	while (vaddr &&
> > +	       !otx2_dma_phys_in_mask(dev, virt_to_phys(vaddr), size)) {
> > +		free_pages((unsigned long)vaddr, order);
> > +		if (alloc_gfp & GFP_DMA32)
> > +			return NULL;
> > +		alloc_gfp |= GFP_DMA32;
> > +		vaddr = (void *)__get_free_pages(alloc_gfp, order);
> > +	}
>
> If you want to use streamline API, please use it like any other driver
> without these DMA32 hacks.
Will kmalloc() with GFP_ZERO | GFP_KERNEL

>
> > +	if (!vaddr)
> > +		return NULL;
> > +
> > +	/* dev_is_dma_coherent() only guarantees cache coherency, not that the
> > +	 * mapped DMA address aliases qmem->base.  Require a coherent mapping
> > +	 * so the DMA API rejects SWIOTLB bounce buffers.
> > +	 */
> > +	dma_addr = dma_map_page_attrs(dev, virt_to_page(vaddr), 0, size,
> > +				      DMA_BIDIRECTIONAL, DMA_ATTR_REQUIRE_COHERENT);
>
> I don't understand why you insist on DMA_ATTR_REQUIRE_COHERENT. It is
> clearly documented as being required for UAPI-visible memory.
ACK.
I overlooked this uAPI part, as  AI tool recommended adding
this logic to reject allocations with SWIOTLB or cache management
support.
