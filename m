Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0243264DD;
	Thu,  3 Sep 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403550; cv=none; b=gN50VGEyevob5EfSmhI6aW0QVosp2yTh3zH/RSVs/D0VKjU7vqcTMq2QfYzQ0YiElOYBR47fRcCbtu1xiP/461+QqlCGeobcPmKjiJb54pNY8L4hJE/DRk8unaJQ5cqtHuTkSNkw9n+7JkWm4Ig78jDORKjC31CSZHgnBsMf/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403550; c=relaxed/simple;
	bh=cHeasC3egrd/P0tqKFV3vji49P28jJyvXWoZX/3gJMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUurUywdM/AnVA3who7gy9Jfm/CkmAE+moe1snpXrshK2+9CqHL22vxFv9HIqUFmYMmsKaHrQzP0VuQx4isIZAULBWm3Z9iAdoCG03hszDw7CL4i5+Eiy2xrOkCwtYNYACbfbahlgOQZUzw9SuUiVeN8DNa8s12BhG6e0MCQtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RUvTBmNs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RUvTBmNs"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682NKRbV2930214;
	Wed, 2 Sep 2026 19:45:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=g1n2EG/HAXuFXi8MKPUc3ODOY
	gpg2kKUsWiHTexNwvM=; b=RUvTBmNs27aa/o5XPyJgcQxnOj7uJXkUvmJYxFbqG
	q6990OmbjVgz1vXoTieZBJEVKmm/mM2/NdvNOx7DbKf4k3epKFx2zKKTl1yvpe70
	voNlEk/TCCd2SrFYlOttn7QK7gyQARyXZGq4EJ8W/WAxiFfD93qLhcaFC8B+dGxd
	6a3Sg7Ng3HqBSJtznyx1yHkYSrHWqFMHbWBVTPZXZFxUz8TVhprl+is6bdKQMz0b
	674qr/te309nO9NWom/ciDx3kSOvX4z7TWHSRVI7Ejy1NIJS76MGBCicUVSvflNw
	v76Wv6F4EE3nrqJnKPfpooLCTSzYIULf+ybp7wZ7CQZ6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gef5b35x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 19:45:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Sep 2026 19:45:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 2 Sep 2026 19:45:38 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 2962F3F707A;
	Wed,  2 Sep 2026 19:45:34 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:15:28 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <leon@kernel.org>, <Qqingfang.deng@linux.dev>
Subject: Re: [PATCH v6 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <apjfSOEYGJwuogmt@rkannoth-OptiPlex-7090>
References: <20260902021023.2987908-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902021023.2987908-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyNCBTYWx0ZWRfX6SnjlF3JyRD7
 +wi+ZThcIld0B9qAR9Ry2reduVIhNiAq7DnmXNGfdwhipkUY/LU8hvO7/9XhJ4NQ40arqRTXpwh
 A+XRUmDIn/WUSKu1rZpxQKfBf0uqYjXH0bwH57tPqyAFGSLQIsg86GYaeYLCnEME9jcDDfu9WRJ
 QUhKZRWGuyVn1OTWg4V3Q/P95Rj16uu8JvZVYazuzOsMTQTWqFGY2ATxBjP4kzYK3nQv44GEbea
 uKlQ/CHG3TDKZFQrITgPg1UGiW0Ve6GLUqZB38JFwi5jrleoeV1xnW2QCnE3yE+ZV1zvrmSxyoN
 zLrGze6F7o29kcuQCYHYyXqfwv78ar+X7THpvDZfPuASzU593hXroVqHHQzMHWcTXWm/JUpZKbT
 i6/5HCDHaorJ/i/SnXv5rPhrOmR9IseRsgjbC2X6a59rdJs21X8znYvU/2MsPWoKULMhp1boy02
 nHbTYvwGU0VIrSrieyg==
X-Proofpoint-GUID: SmTCHTKMfghKvWnRN5R79HIt961llE_C
X-Authority-Analysis: v=2.4 cv=e6Y2j6p/ c=1 sm=1 tr=0 ts=6a98df53 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=JtdUpyMMoso3z9NwtCIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SmTCHTKMfghKvWnRN5R79HIt961llE_C
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyNCBTYWx0ZWRfX+vwOBYMKUJkm
 gQA/7t6XWGQYqYCdZZ/UCb4GXuWxpPbAi+dOK15AVkVdVeRjGmq0lXx3xFm8exDmorp5hdYnyYe
 j9yfpMZA9OVnaM0Z+AiK8Wug7nWPM34=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_06,2026-09-02_04,2025-10-01_01

On 2026-09-02 at 07:40:23, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

My reply to sashiko comments

+----+------------+------------+-----+----------+----------------+---------------+-----------------+
| #  | Location   | Issue      | Sev | Preexist | When it bites  | Suggested fix | My comments     |
+----+------------+------------+-----+----------+----------------+---------------+-----------------+
| 1  | otx2_dma_  | alloc_gfp  | Med | No       | GFP_ATOMIC/    | Preserve      |  All existing callers of this static function
|    | alloc_     | ORs in     |     |          | NOWAIT may     | caller GFP;   |  use GFP_KERNEL. So in sleep in context.
|    | coherent() | __GFP_     |     |          | sleep in       | add RECLAIM   |                 |
|    | GFP        | RECLAIM;   |     |          | atomic ctx     | only when     |                 |
|    | handling   | violates   |     |          | (sched while   | allowed.      |                 |
|    |            | caller GFP |     |          | atomic).       |               |                 |
|    |            | semantics  |     |          | qmem uses      |               |                 |
|    |            |            |     |          | GFP_KERNEL.    |               |                 |
+----+------------+------------+-----+----------+----------------+---------------+-----------------+
| 2  | otx2_dma_  | Coherent   | Hi  | No       | SWIOTLB bounce | Keep coherent |                 |
|    | alloc_     | DMA ->     |     |          | (swiotlb=force | DMA or add    | Commit message clearly explains the reason
|    | coherent() | streaming  |     |          | ARM CCA): CPU  | dma_sync_*;   |                 |
|    | DMA map    | map; no    |     |          | and device use | detect bounce |                 |
|    |            | dma_sync_* |     |          | disjoint mem;  | fallback.     |                 |
|    |            | in queue   |     |          | queue broken.  |               |                 |
+----+------------+------------+-----+----------+----------------+---------------+-----------------+
