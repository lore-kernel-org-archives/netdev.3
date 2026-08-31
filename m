Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53C3A59BC;
	Mon, 31 Aug 2026 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788143941; cv=none; b=dpeqjleeFmTajPt5XxREDDBE9SQIbwNy/+palo5WaQ48HZSX8CKwolg5H0fad8HuPRhWg8GDjY3Q+Sv0/fPe2iwdhM3xII9bPo24ms56l2JH+QauKDFpzF4a8ErWBZYRx+XylFV7nTg1bQn6rh6pdBbb64MyzzCXsYsYEFwpFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788143941; c=relaxed/simple;
	bh=7s0xBomybd8KcX7yxMNeR6pnGCzyWJA1/waJv9jtQrc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT7Nf/gYUWuMiYnqmX7S74A/PS6rd2VEP3n8mToqE7VJ2BXopvRcIJLirXisdRFVVLfr16SJ1l4G9rnGaj6SWwAVhsZf7BBdOncKNLLz8vSakLxE13hAVqfa9I66sTsktGZHZgB7t5sknvIAMVa83nyZktRzYLRxOCEtTzPvz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SYlMqLk8; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SYlMqLk8"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V1buKx3698144;
	Sun, 30 Aug 2026 19:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=7s0xBomybd8KcX7yxMNeR6pnG
	CzyWJA1/waJv9jtQrc=; b=SYlMqLk8Vu4g3TD01TJ24xUo1jWRfnNHTwLX23v0y
	D2x2RPWXwXGZxMxMdfUrI2x6DlzZl8eHmaWueiPMQlO2vLKWvLnLssZg4NclmRu7
	Diqq0YTNzg3ZT324fh6i3XxT04iT8RZse33MO+p9eVTv8Ho0eI7OL2OalHAt6gP8
	q3QxDVfR4z1qd7Ou0d4BXQNOeTxUklxYapdszQgScmTtUN1/IpY/8cze67RvGOdP
	xL4ykb1egaD9IIjWo7C7eJTmg811SB0GYSf7oElC2EMkCXOiCy+h5pc2JG+U1RE3
	bg5QdWTXtwokOwbc1UDmQKlXWup/so3CgxvzjHiR0A5zg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8h1yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 19:38:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 30 Aug 2026 19:38:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 30 Aug 2026 19:38:36 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 30ABC3F7082;
	Sun, 30 Aug 2026 19:38:33 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:08:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v3 net] octeontx2-af: allocate qmem from page allocator
 to avoid CMA
Message-ID: <apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090>
References: <20260827070554.3919891-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260827070554.3919891-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAyMSBTYWx0ZWRfX9HRkKDcgwrJg
 XObUHqm8ri0S7Fz75BU0k1B1Vd9j65s1JxEdbDlTJRlUCrz9X5NaQK4hZI1r5rq0gC89W+5b2zd
 KV4rlqqKIPLp07U3JDTzLQVyeLtANocJ2mLMfL6hZBmHOq77LDnJdGtL+5BtTiM8S1q3RCD5QX3
 +/vwqfXbQWRbG9vF2zjS5SQi/xJ66TiL1TfOQqlMNBbMSSlOcXjh1SIzhPnypUAnDRB6lJEob40
 XsqUSJbR5Dyl2wkwYv9wdTzzxOSsW/fiy9AXX2gsdhMpdOeS6JR+fVRKg6CB2sVc7vgNl2xbdJ8
 j+ZD1sF62GCQIegYXHX1Fv25N6yNhGST/2y3OAL+0qXiFl3WqcMfecUexN+vX/6Nv76nkc2U0Ou
 DpHTZVM0WVkR0CaAbnyYpINJk4YoYd84p9vNhhGPPmeZUnZJcursfSN3N+nDuctWf032WvkTPJ2
 TMO4NgdB/BrOaPJvG6A==
X-Proofpoint-GUID: nvP_6FqLw9Hou00AEJV7fcgiXAQvx7mw
X-Proofpoint-ORIG-GUID: nvP_6FqLw9Hou00AEJV7fcgiXAQvx7mw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAyMSBTYWx0ZWRfX+Ltj68FyYyMp
 WK9mOjSUcHYp6khdxtRx108EGcokNISwwpTQ4p9RcHEndkrbpd6SFk7BfKGm73JBHL5+F1Xdvpu
 h1/FFF4gwaTssSoKUKV0dTwxlKmXe2Q=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a94e92d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=X1YraWbzWtjX4d_u3iIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01

On 2026-08-27 at 12:35:53, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS for
> physically contiguous DMA memory (e.g. CN10K LMTST regions spanning page
> boundaries). With CMA enabled, those allocations are drawn from the CMA
> pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST regions,
> so total usage scales with enabled interfaces and is hard to provision in
> CMA.
>
> Add otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers that
> allocate compound pages from the buddy allocator via __get_free_pages()
> with __GFP_COMP, __GFP_ZERO, and __GFP_RECLAIM (qmem_alloc() runs in
> GFP_KERNEL context), select DMA-reachable memory with dma_coherent_ok()
> (retrying with GFP_DMA32), and map the contiguous physical range for DMA
> through dma_map_phys() and dma_unmap_phys() with DMA_ATTR_REQUIRE_COHERENT
> so SMMU/IOMMU page table entries are installed on IOMMU-backed platforms.
> Switch qmem_alloc() and qmem_free() to these helpers instead of
> dma_alloc_attrs()/dma_free_attrs() with DMA_ATTR_FORCE_CONTIGUOUS.
>

Will address compilation issues in v4.

pw-bot: changes-requested
