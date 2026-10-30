Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363563;
	b=BFWimNJYw0a2jWhrye+tDy3f9LBxhoJqKwOEzeIeYCAGMhwC0Am+yZB0xoSM1KUQ1Xjd
	 tvlu3kIR6AqdHf7wRGffYhGsBN4xdd0P7oTb1PS2Jxzq/WTJOEVlX1iH8YGuSS4gMtUGP
	 /eRuDkrst90rPD+yjytDV/q4F0X8kF9MdogHhIn07Pz5/S76vgNyJ4C0Dnumm562i+5tE
	 hAaWJ+eFq4bj6JKH2pyklMqsUj0bTW98lug5nzkYBn0KI6UzX6Kfmy4gYK61PrTQ63I4T
	 jAAgT5fJ6O+cv5G9qPOTwLOyx0iVa1VLGvd0ur4lQJcnqZsreqGq4qGzAluIPQY5LEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363563;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rQqAjjFnrAFg1/5l+3pgQ8JrQXRSksXXCKCV2WK0j4o=;
	b=f8fF9pQNZGgzjDxqJ041YZZkizHVpucmc0UuuHXOk7Xm/PdVBtLYUlNoJQzQnBNDWqmL
	 /m5gZ/SwQnC56f3sc5NBNcF7dpOlPIHJlJeXV2CHL8xWNg1mADWV4G1Uc37AYQg0zdzVW
	 /TklsNcULpCBEpa7c3OksYL0TQc1t+F/i5jsb//n74d2moJEomLJoutpMJocD8fARdMrP
	 doaTlj+d3f516FdODLWMHmLoW2wunoQNuDEj7glGisJGrI9lU+9//BKGDetAZxWkpI07w
	 6xfLIcqem6rML7H1mFBSSRTypXJtOGuEgC6rhXsBTO3lGukSl+PAbY9mDsnjJu20S1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GCHkCNGf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MW9pU9NW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4A606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GCHkCNGf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MW9pU9NW
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG4NU2072280
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rQqAjjFnrAFg1/5l+3pgQ8Jr
	QXRSksXXCKCV2WK0j4o=; b=GCHkCNGfmbNNJjSHkVyyxURW1u7Wzc/Wm2MtFr8F
	mnIhv2WWR6NYTnRHkZ/grOTE6esHEj9SQdNnkreNf5NtADxww6qjKZqHUkofExKv
	tJp8w6o242AQCI5Ndu/sulPY5KwSuZ2qNzmwyjay7LuF1qoJIWM5rU7JJo4fpFGn
	CT+bmjUEYAWWMauwZ/94UNJV22uP5aL6ZRuGqFw6PbeGmJKA1NasvN4Y7MQSqYN9
	fiGmSbIYvht5V28cytcEvXU/XHBB7gL6qdIErJSZjHpRNY5m+Z2pJA2dQMK8QMAZ
	BIRc5OTfmxulMcyUaIeYJr1wEuB4qM6FZZoQ+yWKsSttJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p32gx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:32:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cbf2fd504so104632085a.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793363560; x=1793968360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rQqAjjFnrAFg1/5l+3pgQ8JrQXRSksXXCKCV2WK0j4o=;
        b=MW9pU9NWrgXxrvWh413S7Xp7NsFhFFvr1vI0eCNvDERBYjb4narC06K811S7C8zYlz
         qxdVu2e7qDwDXoV8YCnUB28RN3kHFbYfm9W+N8mBUmk4Fdzq1xh/2bN4Mkeu31otueEg
         vxw/Jw0mMN8CLtmCkGbE86TEyzrL2vckbMQ4jg9Nj0KcrlK+W+7P4gvmg+Me6Ctxd21E
         JE+fJUYW/rcEdgyYW7UH2DdXZgoIeb3KRN6qAcyTl5SeNC4TMYIdpLpiE0Xa87w1erxx
         kTFchlss2OBkhpCNg+ZYuYbEjxFPCpdkRrRH0XRJa0Z99f4YdMqdLp/hu/abHGZOTuw3
         eoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363560; x=1793968360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQqAjjFnrAFg1/5l+3pgQ8JrQXRSksXXCKCV2WK0j4o=;
        b=S+FofjsEVCslrqKOez5oCSGr7gxqcdH8NEJ/lf7ArPuk0EfzFHu9BLnPSftx6cONLQ
         TghKUkyZeYonR3MjGRveSyKN8deTnmfHcMGmut3MwLfo2ZDcOOeY8olOcHqvZNrZEPya
         tHGB/lH7E0VJHZvhecJoBJSBxYLBejrbdUnOwRfg89I8lkuD9SfSSIrATyOOcNXW707Z
         CVJ4vZ2wpjMAM4uqBUBZNHsR2GzoslfLx7zxK7BhhSAopdvRLA6khugz+nZyPOf+G2Vq
         EDX6cD+gPq4IUuqenIdabUMlKqTy6c3PiaAgkdKbKBn7xglc4MgRt2FNQ0fVla22r2C+
         M2yg==
X-Forwarded-Encrypted: i=1; AKwUvBy7jt1E8qz+xF3BDZvShXPY4cZ6GF/agQAcU2Kr9aQDdTuozqg1C7vQjIinqwf4/O0JPCxbUKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKec1uOxH8xZpn1qGsmMMjYCsFFnuRH4YBF2wYMzMOnjWea+YSo
	Sla2SxVKforh6mCaVeCrF0iBoycmkKbCechaeaqoSCc5ElhVVGx99cJ/atEWHrHstS0GHx6yy0H
	/vbsEsIs9y5w52b9mwXcAFDy+5HL81aBeud4QXGVQ+EH4L3b1kk8DhdpAcsE=
X-Gm-Gg: AYBFou1Om/3yI8uoJcp2u+Sf9pK8yy00HU+bJ32wMG7lPLVnKu4eXDaRx2muDYGgxNm
	UKFS00SBzljG6TY5nbTDAwzdkWMSuMZhnjPh0bKODcgI92zE0kXAl938zrjiJz6Ejuo1AjY8rIB
	qpq9aLB9bMxYjxhr1+uvTGoN+Pd5B1IiDwW4L60Kt2XJjyWRliHKr1/ZWubb52JTnTunn/YB3Mm
	cuJcJ9MmKWUuUNX1s7f5XfneQmsCqLOjWkb9CHc+HY86Nl4jCeoHR0q45jDvEExL2dRb892c67F
	qrxHbsqOSV2krzjmha+kzMvStmdm7YXJmI+yn9HhUq0nTojUgtKN4NEoieHq4KXa4IpAU7oMpnc
	T85iNkUDVUSnrAXJjfV765jWNL7siTOz9a0LKueCA/8AAg3J6iZjlLKWvnbXT6ofr5iaGLQpDxa
	BVl94eB9jT8JJKrk6MPMU4iw==
X-Received: by 2002:a05:620a:838b:b0:93f:5593:5750 with SMTP id af79cd13be357-944216ee79emr335402085a.17.1793363560100;
        Fri, 30 Oct 2026 05:32:40 -0700 (PDT)
X-Received: by 2002:a05:620a:838b:b0:93f:5593:5750 with SMTP id af79cd13be357-944216ee79emr335394785a.17.1793363559439;
        Fri, 30 Oct 2026 05:32:39 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d295csm136475475e9.7.2026.10.30.05.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:32:38 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:32:37 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
        thomas.petazzoni@bootlin.com,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: Clear DMA errors for multi-channel
 interrupts
Message-ID: <auSOZaH_Hu6caTSH@lore-desk>
References: <20261030102251.208929-1-maxime.chevallier@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MiK4MvEZXEgqTADb"
Content-Disposition: inline
In-Reply-To: <20261030102251.208929-1-maxime.chevallier@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfXw/J4X1m4ncTX
 mXNZ6UDvjinZrC87CRZHLVnKATnSeJP49gHTaBNzCyXywKvidWCUqPzFAiCRnrjiyztw6aePwIV
 Oo+pWF3rbkpScw1gYfd39um7CakMWVldmO0FNvEArdc/wKJU18994pjInIu1vT/UMJhIQ25QWjE
 o0ZBn1km64Zf4faOuSZFP2HROO+IEvjJQ42qe/te5O/8of22wsh2rIDCZ3cy89syGgD3sqWF9j6
 bL81WGdUSS9N+nkH7JkcitjDKXCLn0/tVNKdkmjnTDzTrtuGU3jV6UHBbo/Xno9GDb71Wioccar
 QTtJyv+6oWz2/mca9CqnKK4PlIJc7T9AdXt51EidYzn1HDIwg5vP87wFGgkKV7z9hs7MD9ZpF6R
 fiFwvU9RkORyWNQGeZ97HOj5yksbVzTZ+QJHuY2EWX90wEV1ByIsqwLvL6u1VPw3Voj/uTXn7um
 eDDm2D0D6w6Cuw8v9MA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfX7UpTRr4f4wXv
 54oszRxFNvEvjsi6cxU7yXoJ4TWFJmExQIuMCRoP/snMTmf+jbkrFMq0KItH0fXc/EAl/wV/zcK
 WaDvVDULBH9LK9nTrMJpqLwFRN8BYiM=
X-Proofpoint-ORIG-GUID: uldj8c90oWvhGEnb7LK3-d7RfSIHHw4O
X-Proofpoint-GUID: uldj8c90oWvhGEnb7LK3-d7RfSIHHw4O
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae48e68 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=TdYLlOzfE9KcRv6nyNQA:9 a=CjuIK1q_8ugA:10
 a=4nU4Df6lw9LS-X-cepgA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300049

--MiK4MvEZXEgqTADb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The Multi-MSI interrupt handler doesn't clear the DMA error interrupts,
> and this leads to interrupt storms when one of these interrupts starts
> firing :
>=20
>  - The RBU (rx buff unav) which triggers under high traffic load
>=20
>    This triggers easily with iperf3 and small udp packets, and shows
>    when running the netpoll kselftest
>=20
>  - The RPS (rx process stop) which triggers when we stop the DMA RX.
>=20
>    This one shows when restarting the RX logic without doing a down/up
>    cycle, like when attaching an XDP program. The XSK kselftests
>    triggers it.
>=20
> Let's make sure we clear these interrupts for multi-MSI cases. It's
> already properly done for the single-chan interrupt, and for that
> introduce an "ERR" DMA dir, as we don't want to touch the RI/TI bits
> when handling these interrupts.
>=20
> To avoid duplication, the DMA TX error handling is factored out in a
> dedicated helper (in the same commit to ease backporting).
>=20
> Both of the above storms have been found on dwmac-motorcomm (YT8601),
> and are triggered by the xdp.py, xsk_reconfig.py, xdp_features.py,
> ring_reconfig.py and netpoll_basic kernel selftests.
>=20
> This seems to only affect dwmac4, there's no multi-msi mode on
> dwmac1000, and on dwxgmac these interrupts are masked as of today.
>=20
> Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=3D1 for multi-=
MSI")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  5 ++
>  .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 46 +++++++++++++------
>  4 files changed, 40 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/e=
thernet/stmicro/stmmac/common.h
> index c74bc7c9750e..a972bee66504 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -382,6 +382,7 @@ enum dma_irq_dir {
>  	DMA_DIR_RX =3D 0x1,
>  	DMA_DIR_TX =3D 0x2,
>  	DMA_DIR_RXTX =3D 0x3,
> +	DMA_DIR_ERR =3D 0x4,
>  };
> =20
>  enum request_irq_err {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 43b036d4e95b..a7caac3c98e6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -173,6 +173,11 @@ static inline u32 dma_chanx_base_addr(const struct d=
wmac4_addrs *addrs,
>  					 DMA_CHAN_STATUS_TI | \
>  					 DMA_CHAN_STATUS_MSK_COMMON)
> =20
> +#define DMA_CHAN_STATUS_MSK_ERR		(DMA_CHAN_STATUS_AIS | \
> +					 DMA_CHAN_STATUS_FBE | \
> +					 DMA_CHAN_STATUS_RPS | \
> +					 DMA_CHAN_STATUS_RBU)
> +
>  int dwmac4_dma_reset(void __iomem *ioaddr);
>  void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioadd=
r,
>  			   u32 chan, bool rx, bool tx);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac4_lib.c
> index a0249715fafa..02aa1a3dd1e2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> @@ -150,6 +150,8 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, vo=
id __iomem *ioaddr,
>  		intr_status &=3D DMA_CHAN_STATUS_MSK_RX;
>  	else if (dir =3D=3D DMA_DIR_TX)
>  		intr_status &=3D DMA_CHAN_STATUS_MSK_TX;
> +	else if (dir =3D=3D DMA_DIR_ERR)
> +		intr_status &=3D DMA_CHAN_STATUS_MSK_ERR;
> =20
>  	/* ABNORMAL interrupts */
>  	if (unlikely(intr_status & DMA_CHAN_STATUS_AIS)) {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9ded31150fbe..2068b57df8d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3141,6 +3141,16 @@ static int stmmac_napi_check(struct stmmac_priv *p=
riv, u32 chan, u32 dir)
>  	return status;
>  }
> =20
> +static void stmmac_dma_tx_error(struct stmmac_priv *priv, u32 chan, int =
status)
> +{
> +	if (unlikely(status & tx_hard_error_bump_tc)) {
> +		/* Try to bump up the dma threshold on this failure */
> +		stmmac_bump_dma_threshold(priv, chan);
> +	} else if (unlikely(status =3D=3D tx_hard_error)) {
> +		stmmac_tx_err(priv, chan);
> +	}
> +}
> +
>  /**
>   * stmmac_dma_interrupt - DMA ISR
>   * @priv: driver private structure
> @@ -3165,13 +3175,24 @@ static void stmmac_dma_interrupt(struct stmmac_pr=
iv *priv)
>  		status[chan] =3D stmmac_napi_check(priv, chan,
>  						 DMA_DIR_RXTX);
> =20
> -	for (chan =3D 0; chan < tx_channel_count; chan++) {
> -		if (unlikely(status[chan] & tx_hard_error_bump_tc)) {
> -			/* Try to bump up the dma threshold on this failure */
> -			stmmac_bump_dma_threshold(priv, chan);
> -		} else if (unlikely(status[chan] =3D=3D tx_hard_error)) {
> -			stmmac_tx_err(priv, chan);
> -		}
> +	for (chan =3D 0; chan < tx_channel_count; chan++)
> +		stmmac_dma_tx_error(priv, chan, status[chan]);
> +}
> +
> +static void stmmac_dma_err_interrupt(struct stmmac_priv *priv)
> +{
> +	u8 tx_channel_count =3D priv->plat->tx_queues_to_use;
> +	u8 channels_to_check =3D max(priv->plat->rx_queues_to_use,
> +				   tx_channel_count);
> +	int status;
> +	u8 chan;
> +
> +	for (chan =3D 0; chan < channels_to_check; chan++) {
> +		status =3D stmmac_dma_interrupt_status(priv, priv->ioaddr,
> +						     &priv->xstats, chan,
> +						     DMA_DIR_ERR);
> +		if (chan < tx_channel_count)
> +			stmmac_dma_tx_error(priv, chan, status);
>  	}
>  }
> =20
> @@ -6466,6 +6487,9 @@ static irqreturn_t stmmac_mac_interrupt(int irq, vo=
id *dev_id)
>  	/* To handle Common interrupts */
>  	stmmac_common_interrupt(priv);
> =20
> +	if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
> +		stmmac_dma_err_interrupt(priv);
> +
>  	return IRQ_HANDLED;
>  }
> =20
> @@ -6500,13 +6524,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, voi=
d *data)
>  		return IRQ_HANDLED;
> =20
>  	status =3D stmmac_napi_check(priv, chan, DMA_DIR_TX);
> -
> -	if (unlikely(status & tx_hard_error_bump_tc)) {
> -		/* Try to bump up the dma threshold on this failure */
> -		stmmac_bump_dma_threshold(priv, chan);
> -	} else if (unlikely(status =3D=3D tx_hard_error)) {
> -		stmmac_tx_err(priv, chan);
> -	}
> +	stmmac_dma_tx_error(priv, chan, status);
> =20
>  	return IRQ_HANDLED;
>  }
> --=20
> 2.56.0
>=20

--MiK4MvEZXEgqTADb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauSOZQAKCRA6cBh0uS2t
rLt2AP94/xq3HXI972oCxjUn64hJJfAqS/VqduknEbpg04vgCQEAoFB4EmEfJdaY
5GXrYPGGorHqDH29hb7XSJ6BbhpAnQI=
=yMqN
-----END PGP SIGNATURE-----

--MiK4MvEZXEgqTADb--
