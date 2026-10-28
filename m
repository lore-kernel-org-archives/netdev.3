Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154428;
	b=a4k4yupj2EzYdR4m50T1G518SvgFMiOZamP2GmR+cB6H8zmp9pnH71fEbfgDOzM9sytM
	 i2Sl++ftEtC3CbRqO9eA9C/Ts1C9Vp2p4Unh260qToTVp2yt51f00gGyD3x4IBJiH2Rxt
	 cQzyLePcK6gD6RY3v1l1y4EbeDRSLpdk2fofhFUe2OfPfCTmkREWMiEtZk6j1wGBD8ztV
	 OqSD2v2fvw5pOYSpFqTsuouQ6kGyG7426TCMip2SMrHqoccDUnXTT+1vOLLNyJqkB+k0o
	 YJsHrRuU/sFCC1dQsEFdNxQ9R1MK0JeFiWx28a/X4C4bzqwKM6ejuqU7hzQLr3zYL9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154428;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=pqJIzHfgyyj9J8gEY92zpLVMOO1BDYmlJyEtGzlJKMA=;
	b=UzqmWAWEH3isBFuVEM1ETzOeJjL68b4Ps/r58qI5Zi8XZMvXDlWs9jY7xaU+dq7x5Oyg
	 9moj/mxBsBSTwl2phJHg40Z5uqjf0uz985GyMu9p08YNgwmRMg0LftX9WayR/aJ01lFEq
	 CfrJjP9BjmY6WXTGifA/gdQtrZLDaWtCbedAQf97zDah7DJ7F7PG/9pxTadE7EoNVcmwa
	 WFK2zdgh0M9hUFAvTnuGDORSGdTIYa5x0I8n81tXWhjKxuMJDkfWts+H5TsUfzAB4TsYd
	 Cw7JojJ6awZBRgnYUHwPBvsfWr4gfkdF57MOnXePuPu+5bjUBYTi8+2gFS3xb2tHOxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=E6isyq0G;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D11606A321;
	Wed, 28 Oct 2026 02:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D11606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=E6isyq0G
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S0hRwf3340378;
	Tue, 27 Oct 2026 19:26:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=pqJIzHfgyyj9J8gEY92zpLVMO
	O1BDYmlJyEtGzlJKMA=; b=E6isyq0GYsa0UJRSa/Ti4IHmG6vkzUEufB7l4aw8x
	gHIBkxFEAfJkzLwtMkI7U/ZimZ/GxWSw8j+54d8rWe1FMCeaDTB0eQVJtDn2BfQp
	L2flaYAsEFC0kGyPwnIDMoZ8J6/p4wRhKk6OI7Vn3BdYkjV702KY2zs2ekicLE9e
	9rkI+OThJ4HdEUvJdkit8HD+k/MDTU5ZtyY6aJ9x7Z1z8sVA/OcaVTZ09a/mbKVK
	atxnoPYtn2XurfPeP0cK+rfvkmexXQha0acgHeHxND9dtTy10IxkLiu2Cyc21Bm4
	xRl5QtIpE8k6ardTI3u08JNLQ0cG8kn/laNcPM64CyyrA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hk1a3swdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 19:26:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Oct 2026 19:26:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Oct 2026 19:26:52 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7DB723F70CF;
	Tue, 27 Oct 2026 19:26:48 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:56:47 +0530
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
Subject: Re: [PATCH net 1/2] octeontx2-pf: fix skb use-after-free on ipsec
 transmit drop
Message-ID: <auFdZ-A2hKNWa7Wu@rkannoth-OptiPlex-7090>
References: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
 <20261027-nb-otx2-ipsec-tx-fixes-net-v1-1-2114c4f10c36@tipi-net.de>
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
In-Reply-To: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-1-2114c4f10c36@tipi-net.de>
X-Authority-Analysis: v=2.4 cv=cLh1IVeN c=1 sm=1 tr=0 ts=6ae15d6d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=QHCe3XYpHXApH8-DLgEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ghP3MFGJZ4YCrKQJxmQ18xwOGpku-PXP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwOSBTYWx0ZWRfX5wum5hUnmGG1
 /p5c/LPA0oYVRHj7pqYhZOzL8j82LTLbbPS4taPHFJwR8+SpbWO5XaET7uskGlbml62cKH3FefM
 RwOY8b2mXYFVQrL7pa3T/1hVNIM4CM0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwOSBTYWx0ZWRfXzl3YSLExK83x
 sKxy3xU79bSgdsfLh8oYFOuyc9QnxIkTKSBrhOsFqzaxV3nNTa1I4COoKOAM0lurLMkK4usC9oZ
 tdzdR6gb/upFPRr+L1T5e1xBDX0jHS/6J8Qu8NJHv0Y9chXQrRwaXM2sEorxHuXKPqwozOExfJ/
 X9iIxuh1pfkgnwZeY4wYTpdgv5xwPGr1VE7dFzT5sFUebqBJvHlgE3ZoF1bXo//Bb7IjuUko6MS
 gI3h8rEJdO3JjKUn2lrDdK6dDUrcAd8Pi1TV6u4rH07ou4BWubVF0rTSb5JuoS8QLa7mfzaG2rQ
 Yy9GVL0+40qBayhw55g0eFynpB0/ifQQ90galinjkNSbK24Su+tXNtTg6ZwOWmB+velzgWk+/qH
 +GKHgISgFOZmbS6myLlV9RLsymY0dm/OiGOShVNjSgPHITC7PPpkPqpQrxEnekEKFlgV8T1GRpb
 2BlBKwXF9D3tLySqEXw==
X-Proofpoint-ORIG-GUID: ghP3MFGJZ4YCrKQJxmQ18xwOGpku-PXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01

On 2026-10-28 at 01:24:06, Nicolai Buchwitz (nb@tipi-net.de) wrote:
> When an SA is removed while packets for it are still queued, the
> transmit path frees the packet but reports the queue as busy. The stack
> then requeues the freed skb, and the DMA mappings leak.
>
> Fixes: 6a77a158848a ("cn10k-ipsec: Process outbound ipsec crypto offload")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
