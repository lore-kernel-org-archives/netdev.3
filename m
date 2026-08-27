Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174EF303CAB;
	Thu, 27 Aug 2026 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810058; cv=none; b=DY460jcc6E4xP5rJDZpS5pW0KYLMprvvFR/BTFc/LlB4Bm+M0wV8t956ysrVWResNt3UVtypUOZzHat2JM9TT4DyUHo3skmAuetU2N0sn/osg2hWlayBjdL/KRTgHks2bw99xQgeZ0mJbkpvyY0gwTOrU0SY9HPO337d9bHSBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810058; c=relaxed/simple;
	bh=/G6iAWc4FYPn/V+EoSVVwxeq1U5YZSLZd53vROooY04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnbqSG2n7qqnYqM8ri+4YREGKGK3IkWT0rrCDigJUTAbE2pzp+SRfI9un6L4+jECqBpKndCcDxKQUNY1B+IdFUwhwLYtGFyKXnaIxslgSaPrGHqbQCuEDMXSOalaCjx8DmDkdkjx7AYjG29R7GoNzZPDk9cnYEsn8QHXkEBseAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KdvJR7w1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KdvJR7w1"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3KWXZ2560829;
	Wed, 26 Aug 2026 22:53:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ewQFocWI4Gi3kw7+QTl0ecalB
	8+/SU+XZVkXMXgdWPk=; b=KdvJR7w15slc4LW0v0GghdwuwNQ9j7yNA2V8wNL8y
	tc+++R9YM3F6q8/q27TNk1tMSm9CEripXYVq0AaSJ5omeL0ix0ypOCXsOXD6tUHC
	KZBsdlHdWiow5j2XdMTnQrzw9JTj2o6qlXlBd4UgLbtZggNiLAZaoAaq8QPa2FQg
	sFmL/EaakYvfHTBjh3HqFY8p3T5C7JJ2oYm79VWci/UMpvwGKeob1phcFjav1NBv
	VQHKMmDHcP66A61hfc3Hv4rlILj1pdmvzIFZOf0YBobUofiNBdkALBu0AwBb77tm
	l2EuyYjJ3nbUIoZOrZgqA6qeMVSNORPXp5q29dgq8E57w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g9xjqktjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 22:53:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 26 Aug 2026 22:53:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 26 Aug 2026 22:53:54 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 73BD43F709E;
	Wed, 26 Aug 2026 22:53:51 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:23:50 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] octeontx2-af: allocate qmem from page allocator
 to avoid CMA
Message-ID: <ao_Q7lClzT-yeK-0@rkannoth-OptiPlex-7090>
References: <20260825045616.3723078-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260825045616.3723078-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0NiBTYWx0ZWRfX2dxSBv+S2NfX
 sHTJtIX+5QKZYJC3JrKQv4znFock6wm4Q4i6AMsjFPbd+TOwzEy1HumUmA3+AhH6alE+m38k16Q
 lkv5MrZQ1XvHQFkLHIBCY2ouztp1oVg=
X-Proofpoint-ORIG-GUID: AKENDr7iJ3urEj31f3ub611BSUOc6-A7
X-Authority-Analysis: v=2.4 cv=C/jZDwP+ c=1 sm=1 tr=0 ts=6a8fd0f3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=F5F7DfbbKpmmxRlMgb4A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0NiBTYWx0ZWRfXzbQ3fuy3U5/6
 kCHhaz7XoNSnhozG6H7Vwinp6Et51ffhyd7eVNq0tVAIhwUn2bn41jk/0p59T7OMDWvoWKCITcm
 RBDxDJEHtf44EwPfEGI3i7HM7ZtfnpVTRNYexNdZBYKF6oRg9e4lKDqWKrPyAeFxvaYIuRWCsSn
 20DjPl1p0pGDfCU+JIX0pbl11AI73qKxqwnIbPFQE9mwLqIfyxjOkT0GjiBUTflAMDwR6f5XTJj
 +9q4GOJTTdzvIv6JcxSzwWy3jkyxwmoFgO4YpEpz1A0eb7lNHK3m7ZWIA84zFPEz8AYuV4C5MJq
 V8OPltbjLfW/AR7rp4verVZRK12NnDMNjb1SQ8VwYLKmKxcCS1a6thi8k+rytAxNW4MiQvjUdwW
 +Rt5oK7Kp5+wy4/jT2PZkoyO2EPOVFzZM069dvG5zc6UJ9HuHWCuuEW40XDbyJ24r2bQj3iFao6
 3RVofys7gxbhgovu0hg==
X-Proofpoint-GUID: AKENDr7iJ3urEj31f3ub611BSUOc6-A7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01

On 2026-08-25 at 10:26:16, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS so
> CN10K LMTST regions get physically contiguous DMA memory across page
> boundaries.  On platforms with CMA enabled, that attribute causes
> allocations to be drawn from the CMA pool.  qmem is used for NIX and
> NPA queue contexts, admin queues, and LMTST regions, so the footprint
> grows with the number of enabled interfaces and is difficult to
> provision in CMA.
>
> Add otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers
> that allocate compound pages with __get_free_pages(__GFP_COMP),
> DMA-map them with dma_map_page(), and retry with GFP_DMA32 when the
> physical address exceeds the device DMA mask.  Switch qmem_alloc()
> and qmem_free() to use them instead of
> dma_alloc_attrs()/dma_free_attrs().
>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko comments in v3

pw-bot: changes-requested
