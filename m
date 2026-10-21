Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570796;
	b=uNzRcEUMBXU8DBe8e4I+hh8DXqcm33s41Vnxk2eJ/erpuAW255E6ijJzA636Gnoq0zuk
	 J6Y3GITFPW97/BjRLy/9a24Okn04uStggJ/sqkgHDGujKBtF8ok0KY/fH3izT3v5xD95L
	 7L4iZ3YF+i2WTARUK8eqVv9YhXcxC/TWIsRhI6PMrLpbu+HL3/lQcHDPfXwTyohavr/C9
	 Fon+Bm+7klQOkVxkvFFlSeCMKyWyFOIwLv+kdgsw5ptbZrHCW2htXRXNA4deexHRLt5xA
	 IRIkkEc/zpHak1IYwwT8yrEtQtSCV9mYOYbSMVT7OXrxkb0Cj4lx32q7EJrNefUPjbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=jPmMJP9XaJAqIjOJfTpuq8v7m+WOlSidQuT//rexL5I=;
	b=JoNxMR+voPz7AHAtZvlRUraeIzoZqLhSS5L3OfJpoyBmJcTtZuxDItIGEWy6hy3nt6no
	 b7wisyWtEWYbqndf+HjsY50wbMpucET21piFoOU2PCSllxZ2eJuYijrLy+KJFCB3ZaJvI
	 Lt59yAmgTxlvaBdWv011ksVjkgUTZyZAfUoCrsJV6mnVkT0GtfJBjYnrd+9N6UMBajEUU
	 yNVVVZ5Vrv65ziz+IqmiU9HZKHBJcqH7XwBSQmDmztskY2iU3z1yComNlVqD3LWjm9nI4
	 /AyV2+04vEilvartjifhMVgOqWs500J+XufCk98kTcma1tYz0deKdPQHVPw1wqInpRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jzI9VoGz;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E767606A319;
	Wed, 21 Oct 2026 08:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E767606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jzI9VoGz
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5iVOQ1212415;
	Wed, 21 Oct 2026 01:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=jPmMJP9XaJAqIjOJfTpuq8v7m
	+WOlSidQuT//rexL5I=; b=jzI9VoGzFPb1MYQWTjBj23I+uoJhDq5q3MhIcPkJU
	VobBoC/VkIfBXwIQOLS7R117vx1R9cvc8TXb8nnVfWouRAo36iQmEO4NORvfca02
	iECgwJkfkQfMpwDPlEc2KeceICZmQmJJZPaJj2s+D5j5Q/c5Nd8xDzJFriQN5Qif
	0yaFJLefn/pDOABqNI2lVLrOi97sxOjFVbdtKzAn6flnX0s3jjyV7y9cirBcgYFY
	k19Ql2Yt9R/sYJbthjwoT1+VxT7Mkj/ckxwcjdFbMIJLF8AWa/CFDSv0xJzoBmp5
	F7dwEXBfUAkol5WYKmobP9iqucqndFZpt5GwPTdETN7dA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hdw4qfybg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 01:19:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 Oct 2026 01:19:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 21 Oct 2026 01:19:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7097B3F7075;
	Wed, 21 Oct 2026 01:19:40 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:49:39 +0530
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
Message-ID: <ath1m4xQ_f7VVknP@rkannoth-OptiPlex-7090>
References: <20261019-nb-otx2-xfrm-unshare-net-v1-1-ee9b24f9e673@tipi-net.de>
 <atgugPFCpueeAiB8@rkannoth-OptiPlex-7090>
 <a790194252203ea6736acc1554206fd2@tipi-net.de>
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
In-Reply-To: <a790194252203ea6736acc1554206fd2@tipi-net.de>
X-Authority-Analysis: v=2.4 cv=epdKXYpX c=1 sm=1 tr=0 ts=6ad875a1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=SO4i1onKFI0sYab2KpUA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=u34awES8lKBFzNfVaQUm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMiBTYWx0ZWRfX0GcKL8valUvG
 Krql0PJ+uqf6UZOu/9K+LoCBeH1Hm5tcoNOlCVs5YhvYpa8G3stfrGy/gcfuGAfd4WTZrq6p7VH
 nCZeco4Ynwr1UBEaEn1/1NnDLL703qQ=
X-Proofpoint-GUID: E1jeEBi62ILj2Np0TcEAg9EcgNpqF8IS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMiBTYWx0ZWRfX3JtmVy0bidyU
 f+9DNsuaY3q9PQbf/gSIhq/3GGDrxYwgj3tHVMxYDsIhumN88D6h7wToeXFegAQnhVOg3GFQNDc
 +4T2R7iADxsMbUFpqtCTWyqqHVfa62RH7dhtcS3YcLWK+qtDNE/0/E6/nyXa6P2+NaelHgJn9YG
 xUUwnfY01Xvjrnnr3ZYdbTyWcoxl6DP6SwQQuhVGuYfBtiUbFFjjjCCL4JewwhwG0jDculTfJIs
 3usy7edjBgjTymotWmvjptvigCvrkFb3Ym6LAa7vEuiljKB9NVkUbgWr9jy15qI3x73lQqW3StP
 bsBwl9nmkinmBFhG/C9nPQL0F6D/WlfEFcT6oCx3XLfERjlVZ9l/r4qI1+mnbJLVAosIeZvc2uM
 RUEiRr9X2XSDvJ0VjQ5pSV6ciDS5J3A25FH2UKuqazwNwTESMgRnbrw0S0k+KI7684YEO/RAq4x
 ditC3zGs0Ol5XMkhGYg==
X-Proofpoint-ORIG-GUID: E1jeEBi62ILj2Np0TcEAg9EcgNpqF8IS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01

On 2026-10-21 at 12:29:27, Nicolai Buchwitz (nb@tipi-net.de) wrote:
> Hi Ratheesh
>
> On 21.10.2026 05:16, Ratheesh Kannoth wrote:
> > On 2026-10-19 at 20:34:33, Nicolai Buchwitz (nb@tipi-net.de) wrote:
> > >  	if (!seg) {
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > index 8d2d607bc92f9..4a20d73d27c06 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > @@ -1205,6 +1205,13 @@ bool otx2_sq_append_skb(void *dev, struct
> > > netdev_queue *txq,
> > >  	if (free_desc < otx2_get_sqe_count(pfvf, skb))
> > >  		return false;
> > >
> > > +	/* Crypto hardware need write permission for ipsec crypto offload */
> > > +	if (unlikely(xfrm_offload(skb)) && skb_cloned(skb) &&
> > > +	    skb_ensure_writable(skb, skb->len)) {
> >
> > Thanks for the fix!
> >
> > Just wanted to double-check the behavior of `skb_ensure_writable(skb,
> > skb->len)` on a cloned
> > SG packet. Does it end up copying the data twice (once via
> > `pskb_may_pull()` to linearize into
> > the shared buffer, and again via `pskb_expand_head()` into a new
> > buffer)?
> >
> > I'm a bit concerned about potential performance regressions.
>
> No, AFAIU it copies once. On a cloned skb it will be
>
>   __pskb_pull_tail()
>     -> pskb_expand_head()
>        -> private head, skb->cloned cleared
>
> The frags are copied into that head and skb_ensure_writable() returns.
> That matches what the old skb_unshare() did and also only cloned
> xfrm skbs take this path.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>

>
> > [...]
>
> Regards,
> Nicolai
