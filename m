Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC923909F;
	Mon, 24 Aug 2026 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552957; cv=none; b=MQ8dmzHQAByqHkFkiHQJqyUqIUCxXo2Jl3hnovSms9uWsmOzmQPPDUYcmaVudT9UFojcDLiO3gt1P/8QA4BV/nKna2e07fX4T43891n11gZEgBLuqqzGjbN5vwJ46Ezm22NYyO+bpALgLzA9wXk1iXDFW/9SaB4CHIHK4e+bNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552957; c=relaxed/simple;
	bh=5p7GH1VNohR3cBj6DwO9gI7XqTuwOX2BewNsmW3b4Bo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFhBFb6Zzfu65HnSewRTEe0qwMZ9RVaJFt5cf4VcAZ67OKjntR885G5EoBLDVcZ/kVr1MrPZ4DUsbomk+LUvEMmJwUky7+0WXBTVmzc3V4/lUNIYhapL7tLTbgDC8wzDGn2Cclw1RXMiCuyrVNLOG/M9LIlKcMBBhzUTbbuWTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dAN//Ng9; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dAN//Ng9"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5V0vi3164014;
	Sun, 23 Aug 2026 23:28:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=nalZ5CDNrJOW5qezdOt2zJL9p
	aLi5ESfKa0RfspD3T4=; b=dAN//Ng96zKnnnz+4bnoxIwtOig6b0DqwgsSMz7vO
	Vzc89pIsT1zMi7KwJr/0plkOBNOWwSC+2/I+3W+LObSbPzrUyc/kf4xm6nbsOyik
	4g2Sv4vCyIO3CMisxFHGm3k7zdepKaEGjdJcA/BO6LUPF0HHEonT8NvKZyfttfzQ
	hTQtM0qmjjJ4g8oTFNQG+BhVfCNEFYNAbClcefH2BkgrPkdeTgWSEQ+Wgnsu3+m6
	4QkjK1rNYA8GD1lm+T5HcW5eOYWJx+vrbYG3yHmbA0VEd0UAcE1c9RIl1NeUt+XO
	2yTY8rfmNySeNNaOSWvwvAX3Io//UIqSh82foroGSxFpA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g7vh72bbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 23:28:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 23 Aug 2026 23:28:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 23 Aug 2026 23:28:53 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 21D733F704A;
	Sun, 23 Aug 2026 23:28:49 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:58:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2: use GFP_ATOMIC for QMEM dma_alloc_attrs
Message-ID: <aovkoPmDb3rZXDTA@rkannoth-OptiPlex-7090>
References: <20260820085347.2672889-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820085347.2672889-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1NSBTYWx0ZWRfX9mzuGBXndbcj
 38bKvPf7Ziy4wMUOR9zYxNv7w/BNzHhkluoPHIxbupCqgypPfawViHvhEWkQkWa8NuaeahmM391
 FHRJmLWuPNvI4kkl5GnBN96UlxEO9ZA=
X-Authority-Analysis: v=2.4 cv=QJJYgALL c=1 sm=1 tr=0 ts=6a8be4a5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=1hHV0BX2vR0Rk4jNmwkA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1NSBTYWx0ZWRfX9Xh/+QBVq2u2
 1KpGJno20yvcEpw7tzyjSLhOWehTokhYeT3Cxm+HCbhDO1DrhuCx5XeyFGcVegTQVKSSUfh8Mmq
 PzN4tGoTmiwGHPJVPNYvcUv+XCd/08JTqhUHBoRon+B7If7q7jxqwrT7jm25NdV+ebwzx71BmhQ
 J2UeOsslLsVzaD5GXV3B7szmuF17VbiQo76X7+h5PTqs8DFRnmcQ8OxBf9SaKXD1Us1nli3kONS
 poQXVv1nXtvkPhHUczQGdCnMDIZZarlEIf3rdWvDIHhG3quLIUO2T8mw1nnNGEUv91FintosUJY
 1N+dw8RCffDUyAd8kDYiNSamjlr1Bcx4ua57tcdfCL7ENwhGSTgnHW06yM3nj0+ia9K+bzMzm1V
 kHIDSziN+UmlRh0fDj7e9j2E6E93ZN8ajv+JEGT7vPQID3WwpQKLQyd2Ku9qqb0GpzkBukAVjgo
 bi0WlUClukkrJ78wlJQ==
X-Proofpoint-GUID: ZCJ881N3uofvIPsyQP2LfHpCtP51MB-b
X-Proofpoint-ORIG-GUID: ZCJ881N3uofvIPsyQP2LfHpCtP51MB-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01

On 2026-08-20 at 14:23:47, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
>
> Queue context memory for NIX/NPA and other qmem_alloc() users in the
> AF and NIC drivers is allocated via dma_alloc_attrs() with
> GFP_KERNEL. On platforms with CMA enabled, each attached interface can
> consume a large contiguous allocation from the CMA pool, making CMA
> sizing grow with the number of enabled interfaces.
>
> Use GFP_ATOMIC for the DMA backing allocation in qmem_alloc() to reduce
> pressure on the CMA pool when many interfaces are enabled.
>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b7..ff5d66dd10f3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -61,7 +61,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
>  	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
> -				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
> +				     GFP_ATOMIC, DMA_ATTR_FORCE_CONTIGUOUS);
>  	if (!qmem->base)
>  		return -ENOMEM;
>
> --
> 2.43.0
>

Will address sashiko comments in v2

pw-bot: changes-requested
