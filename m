Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9A322749;
	Wed,  2 Sep 2026 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314587; cv=none; b=GcDLQReJPXUrvOa2WktOn1cLz+nMJN/mKE7femB/EQ4i21eZHlIxUztpAW0k92tCg/eG1x7+76L8Mwhk/3ckejq6OccZWHQKmV2B1mc5wtVDcImniNPqzdRyPxMOyVSi5jwDNn0umxd5dsO7aV6Lzj0MmB/OxFt7Ialu9d3IuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314587; c=relaxed/simple;
	bh=w5OaS2zfLVVyxb5YouQsP2pQd3E14CJoRKS3d9fLPhw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCQ+vdssOXwDXTxWmgHbSoG9l1gBqdyavTSoRbe5q9T8Kw8B5lJClE/xVrMvq3dvonehsY9449jVvP9lReEeucCDAdcPVKNY5kpfpNHgbbKLB8qfawp+tDi5B73PdxF4j8gyNACeOgcmyWq7EY3tXQ7jmTEfA6X102PrkCO/YsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CJ+MkXqN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CJ+MkXqN"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWAEw075428;
	Tue, 1 Sep 2026 19:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=w5OaS2zfLVVyxb5YouQsP2pQd
	3E14CJoRKS3d9fLPhw=; b=CJ+MkXqNEM/qGlsTkJaBgpa9i5q4fgi3nk6f8VIda
	LVxrfPjPHWx8X3ZnwAXFzUlAqP3GVVXSxOIwMREVtU7IIzSYzdLO2FwhI+3Sx3/D
	TGvFNMH3CKJ/zMsDfKrMCtSAPEPAViRVpA5jqOPPOsTl0qwluidFxi78vSHs7d9W
	8mqtELK0MUH5hw5Vn+KOTERv9XORqgZ1MdaFwDU/KjqGF9ReMgZO7DxA20jId/DL
	yv1B5Q8DKSn2Nta5lsmzWQlMGj0IeoQ15MqUP2aUy7AIRcI7OQUOLAJlNOelL20+
	fDc6fUfEymD20TJVCU1fT07WerZFVr2F1CUvjFFNNWJKQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gdmvqv67x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 19:02:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 19:02:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 19:02:49 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7650C3F704D;
	Tue,  1 Sep 2026 19:02:46 -0700 (PDT)
Date: Wed, 2 Sep 2026 07:32:40 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v5 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <apeDwFzaNg7pDbqJ@rkannoth-OptiPlex-7090>
References: <20260901015621.2708182-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901015621.2708182-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAxNSBTYWx0ZWRfX4B8VIqSfOl3l
 TtJMiHufFdrbWcHl74NgapS2tqyVWpnAZYalwoXiGTxaf5dxUsB+jje+LA8Ky9pbFErtU+vC2f5
 mAT0ucusB2bagdShqXKRa7dQmuFgAZGL2T2mkTucZ1LwsSg8PQ1LtFM1b1KVt4asGrkb/lneWER
 dizMURcR7TUGNf2+FDl85uUbGWMLBttbIdO+wGaQrK+C3ckxJ/dRobeojFC1+5gN1Albv3tfFW7
 kNvKe8vf+3Ub2pg7Wj35lKNgM5faZNdWnqEtP7U1vzdhUXzYYf9d24f4Hx1bfV0vF6AVZfaCflw
 7QpUXkX8piTLkUx6pljBccYwZL2eGo64NlkZfrWGLKy0SctgTmuQPJTUY/209RnCQgAHa7cPs1j
 gM0N1QD5RHZFYNL/OQPWdT9BG30JZeJ3lERGi8iszO/YxNBeVJi86goLAr16ojJzX/4uoTB8Pk6
 XC2S42JbCvyJOIqATTw==
X-Authority-Analysis: v=2.4 cv=HYQkiCE8 c=1 sm=1 tr=0 ts=6a9783ca cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=4vHE_U3LIvQQrYn2mp0A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: Kyr-3_4iD7X3Xv6CNXTGfYP4lE92wUPz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAxNSBTYWx0ZWRfX8z3GFHpSSIak
 9HFLmGwoNAtYbFTLGG9g9cU+VcDmsrcYlCWFNtg2KRWsvL+WNbtfJadXZthcjdvu5dcpl4DdkkF
 hpa8tesCqtlWppEle4oI+FZp3u+JT8o=
X-Proofpoint-GUID: Kyr-3_4iD7X3Xv6CNXTGfYP4lE92wUPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01

On 2026-09-01 at 07:26:21, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

Will address Qingfang, Leon comments in V6

pw-bot: changes-requested
