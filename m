Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FF3C343C;
	Tue,  1 Sep 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227619; cv=none; b=WqjDICNRQFV2OPakseII2+l/llUKF8a/wV0yBzlv5vDweL5b2SfGGM/0bpoSrbvbrYQ71BCNw63X0jZ+fe3Tr//jtWPzegXOivJZgz414GagkM1x6MBjl6L6KOkqt8H4uXb7wVxPUCJIY5Ns817vgLdQ1SJj3fdR+5Qq4oejw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227619; c=relaxed/simple;
	bh=XycQwGoRvQSlVWFDuFy25DcECuwWa6dKWgzZH0rTlKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+rjs8tydLubct7sbNo0nmjmljt4w8HzKeCfQ1UTZ5Wk0+NiA1sVIFi3gzheETTQsQW8fVy88IQCXxvPDlFhG71nVdLLMVmOwy40+1v1Goz+VHWcZkuAutW0+RoPkpW/ewzvQZDeWJCe7WfFDLKdB6fchpObPlvS9N2XfPa+qZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UZClLaKJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UZClLaKJ"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810pOZX2006718;
	Mon, 31 Aug 2026 18:53:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XycQwGoRvQSlVWFDuFy25DcEC
	uwWa6dKWgzZH0rTlKQ=; b=UZClLaKJeyrPmwH6GDrYdStN63fNq20urjxJ0jo4o
	1cMlovI7+wE8sBKAEqKuV6p/dAo1jNUQeFHoGDcd5h5acV6g7ZwfBePvuteqdXor
	gKENKhYYif6hSatx20FS753UXC4kXCc6sJ4qISskMIIKuQgO/zd1pywtO+soaovt
	OAUCivC0rVUW7aIU2iW8Ypmib2Psu7d3VUUY0MCv1Pfon8lDiIgpuCf0MMLqmI++
	2AbruUmA0vORJ64nfhbR1PnOIzg9kHs8Ocpg4UdsjT3OYlHybkCNRrYt3pSD0H15
	A6e43m08LC5lsl1CUukwkfayIjN4vQYLVtadZcNyxTKEA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8mtmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:53:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 18:53:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 18:53:23 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DE6835B6926;
	Mon, 31 Aug 2026 18:53:20 -0700 (PDT)
Date: Tue, 1 Sep 2026 07:23:14 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v4 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <apYwCjDVQJAq1TnM@rkannoth-OptiPlex-7090>
References: <20260831024210.208447-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260831024210.208447-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAxNCBTYWx0ZWRfX+U72g7j0Zcj+
 31d0DePCDtbTpfJMu1rS1IIV1Cqf8t1uLCEdfzz0jHCSP92SnFXnY4qyDwk158FhNUgaA23PJX+
 +7BsHcU9uWWxTym/dmadCO6eTeWrYFfrVeDFYMwB8XAePuQjiY0+OVHgPNyZGx1CpsnW9pLzFbC
 aRxPtveh49v8W7ivdz8vdZ0F3g85SavEo95MbXoX5HWSLBOYGTOWgoR7LWn4qynEXuXz8rt0rJ5
 yM4YWlDLrjNeZE4JjPThrB8XauaIUH4xjsLMP0px9qNhVGim7+aKFVDb4WqWQX88ztHzBZZ6F4f
 Kma4CxAQZOabECpKnVFdCiz7YrraaBb5m7ARmh1RveqpHEd2UsA1/UgcCceBC/EQLlXI/hgyq8m
 LCQHzmXB/Lko4YsXVnOFZ5CLPnqIeu4ByWv44Cb2sYHxClc322HeEKnTHuKqVtjBR3gc1rHASIg
 tXBQgmBKKGB/pEBPF+Q==
X-Proofpoint-GUID: l1qlalu_grBv6VFn4qX6nGYJEmHIXs1m
X-Proofpoint-ORIG-GUID: l1qlalu_grBv6VFn4qX6nGYJEmHIXs1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAxNCBTYWx0ZWRfX4DQLcxvLrp47
 dOd99WTpMv52xW7PpXcexI8CV0w0z3+QBnLVw1Lu2iEC/BOrhcocVoyyu8UuaRKQpBLkNlbN29s
 o2XOslgafwvGh6tG/rYeUDMZOwnmKtY=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a963015 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=jRrpLzF2Pmby-JSRoQ0A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

On 2026-08-31 at 08:12:09, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

Will address issues in v5

pw-bot: changes-requested
