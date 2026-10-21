Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552615;
	b=NcXHXrlSOFS/to6rfSqJ2SlvQqOtQQhYZPxA6d+0+YHkWCoaEghCOZkyt0Dd1bPcPuud
	 BmzzLbf/OfFKgXJWB4dpeGy6+TZtN6Yxu78D0r7Vff+t0Nb0p5kIq7Q5UNUqnpFQNHFf1
	 3g384Xalhvri9KodzKgb+72S5sWDY48oqzVggiGAxgrVmwq5ckEYGh3nicbKJM1vW2PBh
	 7nuRH5BcAjOKvWRMbePdVuFx2tXGbTQho22YIU5JgKTK8GoMuZobtAXkfX81raSHu8fRc
	 w7R+ydsDaDHk7TgYtoDU523Em8zchgAr1XYC1pJqYHGe1ObTmy63jxoRpyrbk89DNrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552615;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=sEQ4jLlJ+mFZxju5jJMetg/8Q/EO5YmSdycWcWjeTyI=;
	b=x9ybPndNXtVmaufATPj12TseK+NLUM68klWdoX4aUH+ZoLS0yVedz8xRLZn1wRGMWqa4
	 myeFNTr8GPh4f0aEmXGXG4uEhGiH9IJXRu3szCmpRAOJSS1jeBVh6O1YoaGSj5ooBN4uO
	 Sx3qFqL4uzO0M8BXSq0NOOrAXeeUvXC3nY9C7101ZwRLt7S+98yvUVdFbjbQ4Qn6XBmGW
	 ysIXpZQDqRHB6MT+jnIfZXa+ahZ0wAv8DNkzG6N3GDTpH97ScGC+I78pbsQhxZRgZaPU5
	 L7MkeIVLjL45IHWfAD9AZFTz7Zy74x8cOT2obV/l5wy0N0ZY5k7lBkYfdjMODEclfrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=iNA278sp;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2B607156F;
	Wed, 21 Oct 2026 03:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B2B607156F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=iNA278sp
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2GqvD1249701;
	Tue, 20 Oct 2026 20:16:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=sEQ4jLlJ+mFZxju5jJMetg/8Q
	/EO5YmSdycWcWjeTyI=; b=iNA278spXqq1YFNadNWgP1lHuOsAos3XyZrT3HxCC
	11CjQTb+unwPGr9KcQCu/AhT/di/+1yHFNb3g3WXcXYuogUhs3yWfc15UPUgk0Qx
	pjh0IpFltCv1Ih8t87E958x57L9J8IFiPXHnDG77BGelMdQPGq+CERV/5LqoRbgP
	MHO6BR4H9TTrRDxqChHVAgO7glIbamcXbvVzqWj+7Abt28mEyDM7WnGpSxmZLbuO
	UjEKOsRCQf26XbpxZ5Ge3j57dzvRAgsy6YSG/D340ZFcrMLfNzvfFhZeTWhp1los
	V435RA88t5BWzh2zyLPJm1EjWnj8mF5ghQoQ+RIhJwE1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hemfbr7kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:16:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Oct 2026 20:16:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Oct 2026 20:16:21 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9DF913F70C5;
	Tue, 20 Oct 2026 20:16:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:46:16 +0530
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
Subject: Re: [PATCH net] octeontx2-pf: fix skb use-after-free with ipsec
 crypto offload
Message-ID: <atgugPFCpueeAiB8@rkannoth-OptiPlex-7090>
References: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
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
In-Reply-To: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
X-Authority-Analysis: v=2.4 cv=AvJ7T+9P c=1 sm=1 tr=0 ts=6ad82e86 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=BFT64OGgbsAsvVcCU9oA:9
 a=CjuIK1q_8ugA:10 a=u34awES8lKBFzNfVaQUm:22
X-Proofpoint-ORIG-GUID: UIq-_s_MQ5RVjKOVHRuj01i_8WvUs9on
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX2ej0Q7lMjkfV
 gkzg6hEWLW1K3H33lofs/rIqvRj3Lyzd2hUzgxDP6YcxTvv47VtP6x8OtdhsDMSBixwucWmy3ls
 rnfswvV/IRnQH2xQa7SBCIvrXE5fgAc=
X-Proofpoint-GUID: UIq-_s_MQ5RVjKOVHRuj01i_8WvUs9on
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/LhX9CGAw/ko
 yiGLiK5TQoQQxUTJ5zrZqrOb6XahCR8Gpujn9zkDylyO/Acw0jF2D0Z5Wy8GLYNzvZSpbpg0HDW
 ESFliKDddJTMt4a7jzjGtDg0CX3YNfwxkKCkaFMgP61tsekM8gl9/E/i5IQ2Z2eTQzwPexjYhEg
 es9oy/3NFtVMeDTOgkkCe7wfpky+0dpNah7cdvvou3FzO1nZdyCaioJxDToPK6bdHLhv0YSMXh+
 /x8FbIKiEtanDgRr9Cyxt3PNb7JWGcuRwU8VZFMS8lVVfm46aTOt2DN1QcfCrLwqR7Fm9zChOgq
 89tZjlOTqNKEw0NBSxn2gi/A1UtVgC25peXI2OstIKk60t00xssxGNpwOy2be9yq98L/gy+1gdA
 YQ4a83tmVQwEdb1f1BrabOdeCO3TXq5Zp7fKyLgSWTMYkjQY1k0dzkzehEHI5f024qSYnWexSbQ
 oQPDD+w34BabbjiXS+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01

On 2026-10-19 at 20:34:33, Nicolai Buchwitz (nb@tipi-net.de) wrote:
>  	if (!seg) {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 8d2d607bc92f9..4a20d73d27c06 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1205,6 +1205,13 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
>  	if (free_desc < otx2_get_sqe_count(pfvf, skb))
>  		return false;
>
> +	/* Crypto hardware need write permission for ipsec crypto offload */
> +	if (unlikely(xfrm_offload(skb)) && skb_cloned(skb) &&
> +	    skb_ensure_writable(skb, skb->len)) {

Thanks for the fix!

Just wanted to double-check the behavior of `skb_ensure_writable(skb, skb->len)` on a cloned
SG packet. Does it end up copying the data twice (once via `pskb_may_pull()` to linearize into
the shared buffer, and again via `pskb_expand_head()` into a new buffer)?

I'm a bit concerned about potential performance regressions.

> +		dev_kfree_skb_any(skb);
> +		return true;
> +	}
> +
>  	num_segs = skb_shinfo(skb)->nr_frags + 1;
>
>  	/* If SKB doesn't fit in a single SQE, linearize it.
>
> ---
> base-commit: 78731b46967e3e7102b5cd5062bef185f3404b5c
> change-id: 20261019-nb-otx2-xfrm-unshare-net-6b74a96a8d9e
>
> Best regards,
> --
> Nicolai Buchwitz <nb@tipi-net.de>
>
