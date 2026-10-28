Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155101;
	b=0Z/SMBZphDmS5YkbvuDWttFVtlHLJt6gBwFxU+wwb8Z0D555PCBZWnAZS5E56yMDX5YT
	 4X+E6PUOrK5wLX9l2P06qESlfmxyJEiMkrHN2xf4U898KX7hkLWhiBYfUG10TWgdAqYe5
	 gQfVdNE0dxEX22iiwD2rBneDORRpXanIlcj8g4yDOF8kI9+dCMDtFecfYQfX3vXfbSdqA
	 0/Kj9zQhDu7zFV/NYzGPRM63Zj2RYxKpp1ayZrI8V7npymLIUquvKm7B3pvLr2nhndfD3
	 aLjnJt/f2IgNrEHPutAXscxnXR3s11RbCGAq1X81cxlt+8tBNrsIDw1dNJlWlBIeSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155101;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=0RkIbvE5bVns9Dq3iZQPM9pC/n5nH6FuvYmj/Tc5+Jo=;
	b=zJs6keOVQ9U8XfEwu3pTx2QYXAmbTEr1jSX2wDSa66L4+KG4UvHhUQH4hnIG1jyKh4e2
	 WMscfcrcDXG6eCBaRWfl1teQc7JfDlOgVeua0pv5QOf2nO3u/dTyei239J2ipe9NFmB0a
	 2GaRS/QmEkevtWgCTbqK4uegcNbGcMAZo5WgQtcI/yb8SiwDWUYheiwjWQ3cjWhRh/hb8
	 LhjoLP9b+I7l30N/XpkolbGngfcnCJpXCy8YWIglb4tz9gj4ZzehRbtgenlOikYIdsYzT
	 jWSjlEVVyssK2iScE1rCuMHNicaK+VhLQuBp59yMMwRq6rk4bK4zo09En94kJB/LByQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=G6Ue8S84;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D700606A31A;
	Wed, 28 Oct 2026 02:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D700606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=G6Ue8S84
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S0hRxd3340378;
	Tue, 27 Oct 2026 19:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=0RkIbvE5bVns9Dq3iZQPM9pC/
	n5nH6FuvYmj/Tc5+Jo=; b=G6Ue8S84uG+dYnJRS+2bIthWcS0eZFNvaqoFX2pWn
	cK7x3AvrDyehEEiOXhrufF/SH7R7t0Rb67DkssQzuxRd8teO6k6IYG8biSwfsurD
	qv9p0vqfv7HReMiMzFQ6cP2gSaYgab5C4wVMSs2Dm64TL8IdVRtR4uw8oqBx1U7m
	l0vHT84DOpJo6hmnRpVxiVbIoqWCjYvJlmz1lRoFz1NdYeaF2zAQIyYzb4Ukn0bx
	/FsddmcLFLib8lu2d9LHXpcYwdstOOHiM3e76Ii40kH8wXHP2bV4V4Gg9763ZuQh
	9YM1HV0kgVogH9JG1Kf+sbXWex36+us10cg4+sM6yHUfQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hk1a3sxr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 19:38:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Oct 2026 19:38:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Oct 2026 19:38:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 31AFF3F70CF;
	Tue, 27 Oct 2026 19:38:04 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:08:04 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] octeontx2-pf: pass the skb to
 otx2_dma_unmap_skb_frags()
Message-ID: <auFgDIyangziDH4V@rkannoth-OptiPlex-7090>
References: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
 <20261027-nb-otx2-ipsec-tx-fixes-net-v1-2-2114c4f10c36@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-2-2114c4f10c36@tipi-net.de>
X-Authority-Analysis: v=2.4 cv=cLh1IVeN c=1 sm=1 tr=0 ts=6ae16012 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=Ha73tMEPztgjm5QTfB4A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -Zi98IZkC548Tm_8DZ9cusYWHHdV1CHc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAxMCBTYWx0ZWRfX7T8tP8iqyCh5
 VEvWet3ukM4CSRs/BS7y3dpqmRJe0EXz2xAcO+SpQ2WprqgPpxyODD5TsDpkghhsBIiFc5/0wr+
 8lh6bDefGBKWfzGKu77L9r90iDiWet0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAxMCBTYWx0ZWRfX8Vs9Lbf5shjP
 OOoLSQIyQZHxWhOUB8bsudfI7WJ9Xrk+jORbSKxvObo/CczfWcT8dzTWSheDcHm1TWW333wSBOP
 54+oUt6ARW87/6ZL9Vnn7n+kRVW6hodfw8V+OffLL2PgGTT/o1vwM9gsh/uh+QTX97Ued2GuQDv
 78kB0MM4KA3vjbjSoFuGeNuc0J0QKcM0PUbY0A1dlKW6xC4jW4kwDiwnxXQI8e4xhTweVhjtPtV
 2KDok6Oi3W8aZ2tjz3BWGJHy8aY+3nSKmpBa/h3qLb8Jc9i5bhKH+kqZE7IY1tuLN4k9pHKYXDY
 jmKv5M+Wq3Wdd9P0fn7AiBp4R6sxM7i5O/jU92mc5wKQ0z+2JITdk3HIXFmrVIX48UhaTMLTZKV
 a8dI/FrtiKl4ADyNbuasf3drcKI/8Ac6fvW58jaWzFfwc432LVcGTW9ED16iLHzXOftSq4xItWv
 jJBESPbfWUFzWSoUeLw==
X-Proofpoint-ORIG-GUID: -Zi98IZkC548Tm_8DZ9cusYWHHdV1CHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01

On 2026-10-28 at 01:24:07, Nicolai Buchwitz (nb@tipi-net.de) wrote:
> After a DMA mapping error, the unmap reads an skb pointer that is not
> set yet. It can be NULL or left over from an earlier packet.
>
> Fixes: 195c3d463181 ("octeontx2-pf: map skb data as device writeable")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c |  2 +-
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |  5 ++---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h |  3 ++-
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 10 +++++-----
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> index 3920cd0985831..4434356087814 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
> @@ -1037,7 +1037,7 @@ bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
>  	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
>  	return true;
>  drop:
> -	otx2_dma_unmap_skb_frags(pf, &sq->sg[sq->head]);
> +	otx2_dma_unmap_skb_frags(pf, &sq->sg[sq->head], skb);
>  	sq->sg[sq->head].skb = (u64)NULL;
>  	atomic_long_inc(&pf->hw.dev_stats.tx_discards);
>  	dev_kfree_skb_any(skb);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index c441c0161dbf4..c85436457286e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -2132,13 +2132,12 @@ dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
>  	return otx2_dma_map_page(pfvf, page, offset, *len, dir);
>  }
>
> -void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
> +void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg,
> +			      struct sk_buff *skb)
>  {
>  	enum dma_data_direction dir = DMA_TO_DEVICE;
> -	struct sk_buff *skb = NULL;
>  	int seg;
>
> -	skb = (struct sk_buff *)sg->skb;
>  	if (unlikely(xfrm_offload(skb)))
>  		dir = DMA_BIDIRECTIONAL;
>
Acked-by: Ratheesh Kannoth <rkannoth@marvell.com>
