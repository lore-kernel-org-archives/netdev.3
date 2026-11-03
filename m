Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713297;
	b=0LwDLihY1rUW0Z3PLWISKwrtxTFX37TEVYoHPsl8TIo3vbgyQZYdR5bxr/BG8oTFdrE5
	 vhELKGf0IEy+3fsVceuY/1NEm4tOp86mtRZ5e4yUyiYtdLgBYepw25JAxK7/g0FgbIXiX
	 evCEMGyeIz7Oa6ZrRkDip6uAcyc5kc9oG7pt66KFmr/ez9BuPsUTd+72tamYtNhN1hexA
	 61ZWvwIkzmi+GWzSIXnuZm9bmpYigOm9OCU5IDpThMXXHtnZHVFsmMTEkC6i9T7/U9tpq
	 7HmwlqBqpyT2S2DJE9AFUHg9ybaE2sR/niwss/ricGTYC9XhIbVTnCdNIto60Mt5g6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bcYDRPzyHHMEv/pDR4h+hjr434XL94uQThpC2nQ5TSs=;
	b=giMMrU5Crg9ec87r1B1yQOBtdQw1vDG0PG+AfcOsMC4X7L5i9tEntNAKu3FYoZa3Jpnj
	 qfK/QRej5s/HQSd4tDQl5GvSrQIIcnnXnfEJkSc5TBt1cj15fpxmwnS0fIgXiTs1ahS4F
	 BBpdKiYuF7qMeZlgNz6MtLq+KmA41hsshQ45bYN7kLZgjQKLLWXWqbY6DPTCpzsZATa4R
	 5HLGGkEkG6jQQuor+AY92gUh/Th5+1Iq+H5ItMpNyAtt4AH8D+NdjSwx5mhehmY0+2BBa
	 qgfxM6dmEfvf5pXu+Y4KZA3It8qNuL6CyY7RqCUr/gtittvPQElNGkRg4ZYJUHODgqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsuknYPv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HOZclklt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E493606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E493606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsuknYPv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HOZclklt
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZ4xD3003228
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 13:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bcYDRPzyHHMEv/pDR4h+hjr4
	34XL94uQThpC2nQ5TSs=; b=BsuknYPvWkJzbbIe1z590ijeM3b2T7J3/0ij5cgZ
	0rnhsw38ER2IaEilQDxD0QG1tG4kpQWj2bRyAbn/Z1p3/IsX0hBU0A8hbyB2sZEA
	kw5jcPMc+IPFplYRN2gfTVO+iAShtYvWIOsQUcdOHSYFenTIWeA7ur8i2Er9H+GI
	2J7ozGwle8lWyl3wqa+9tZeATzwSjHW51SmraQKCwyOyMNDGuE9U/Sg8Y0NZteyw
	V0uKTrrY9Hedxn3ZBW21ZDnBU5MemPuko2429Pk1Gece9258eG3Cyi4r+ZrZBCR3
	Xnw7c7AEJdZAXe1FY4uT3RLKRUzX57C1uYdqCYNYsaGWrw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2ackcek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:41:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb98809caso708288985a.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793713295; x=1794318095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bcYDRPzyHHMEv/pDR4h+hjr434XL94uQThpC2nQ5TSs=;
        b=HOZclkltWSPIWa5oH+pkBt/SFOv3nGdWHoGI7gp15Zht3WljsG+AlzBpd13pEXpGfX
         Ea6zW0XfrRNSx5YGp+I+HIHaHpAoLpdgu3LBROoPq/zIqFtOu1mt1U4MjcTZLmTI2UQp
         e/CRJinNNP0mragngj6+YljvsJtjL4OblH/FQFT/krhpEPLF9xAkGhs5js6w1Z0fp/Rq
         mIS4EjiwSAE0dWAJVHDYEp4fu93KBC7iBPos8KsqHXYfJFZxJcM0084I5ynYv6Z0CqCe
         fbxeKOdsJAkYambEzrFl4rfXNAQDXWQyfYqVJIHzwceJx7ioYUIuYjg2la86qbBLl7ZK
         38qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713295; x=1794318095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcYDRPzyHHMEv/pDR4h+hjr434XL94uQThpC2nQ5TSs=;
        b=nVyFueeLBz5Qf1eZJY45cpUft9V3Ny0S+5WXzkCJGtXFBDtUzKl4gijT8vBJ8OXN+J
         ICR/5Bbz0K7xFkulelnJabqI+dqi78ziPHufs49XRwgLez53uP5uSCanbMuW8yAT34Oy
         AgI7vdVuT9emLdubt6O5W7qtHWb5h+fbCUnZi+h2aj7J6jv2GZZVvASA9BqLu7on+Azr
         XqtP1xEtME+7iweJQAMHVTTQjQ40ncy1gkyywLt3cOYHshOEE7/KHesFUW6zPder8Mis
         kXa4zh4MdoCJPOKLTCcDrjgKHoFEFfZFBGDBRaGhGXe2fHuKLwNcGl8KvG0iRBQXxkpw
         eAXg==
X-Forwarded-Encrypted: i=1; AKwUvBy22a0mcCbDc2hWNqaRaBECCAGcpWINMLI/M1F+kX4Juu+al2wHxGuWE+p+v/TTmT7G/mH/BiQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gez2C0VawhZXpM5Qu4JEQrCHtIyI/5Kz1RExAdb2YXd6gI3lL
	ZPuyPN0lMvl7u5U9AyBCrIGABwdlGKaxXQnLx1vSi+8uhftlpphjOUJhutb3V0Jb36Nh9aQ/rUf
	lU6uRbmizV1dNJ5xcyQs6gA3kfYO8fOxVrKJ1jjO1bCYylxmMAnCxHhX1Z6M=
X-Gm-Gg: AYBFou2FmEhNOPCkB0DH4wKgkBtbge9ImNLAxoov+HEfhlFD7B++FY9PSnJYz5gonUd
	OfpPLvYiaerKcH4lWqs4wMxbZI01y6l8WBCwRvbNgX4P6YYD7nW9qeiz/T9XCatl+Kzs+7OTJ1J
	Ict589M7iiwlrK/iJcRSl/kiUZIMNYdBuP068AOD59AzT+5jR4CvgEbjloDNaFXolG/9QX/HZ7Z
	+6xPlWlTEPHRcWgcwRJ67bT2iN2KunHjRHsS5vmnOICyJQsQ3k4Cg9kLf1ss3En2C7rM7eCHqwG
	9MA4XFDJ0wFewYHabCZNH5WEF1+7ZWCS1Ua/LqOBelEYyNQDjxBrc1vjBWImz6JBsViNOZ3Xy6Z
	dses2yHhu9Ql1YUrPBYoGX/cqc3Y6efX5p3XMCJfw1uKPxALtgca1X5tCuwqXZw==
X-Received: by 2002:a05:620a:272a:b0:93e:c35b:2332 with SMTP id af79cd13be357-9442184e908mr2122585685a.73.1793713294551;
        Tue, 03 Nov 2026 05:41:34 -0800 (PST)
X-Received: by 2002:a05:620a:272a:b0:93e:c35b:2332 with SMTP id af79cd13be357-9442184e908mr2122580485a.73.1793713293852;
        Tue, 03 Nov 2026 05:41:33 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09fadb75sm222751545e9.3.2026.11.03.05.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:41:32 -0800 (PST)
Date: Tue, 3 Nov 2026 14:41:31 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Magnus Leatti <magnusleatti@kernelriot.com>,
        thomas.petazzoni@bootlin.com,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel
 interrupts
Message-ID: <aunki9NNExOeLaAb@lore-desk>
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="VCchJjwU/KronfNG"
Content-Disposition: inline
In-Reply-To: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9e48f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=hUCKMWOQsVhIjlt2O00A:9 a=CjuIK1q_8ugA:10
 a=N9U-9oHc826BwoMl2xwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfXz9pgYEEGGi80
 vW/Mb3YoqiUMhFnRnIzMiArMuGCWPOKvLC4R1XZIoS1Ch3r9VIfuSKbksqtE82t3JrTlOmFQ06Q
 /myUu7JZ4yCSgUENq6dr68RMmziGvukwvznV/NhrpxdtKOFN3x0VK/PSCFcw9nhfcM9L+MTUI76
 Ne/8IGOBhPxCOJSHD/13fjJ2BfeU88vr476EAmvKzdpic9MZRWvQb6OEurfk0hBJlNSR5Ibd4zC
 Hyblt0Evhw9ED2DiemKJuLwcRDCv8n4uWIMx2agIbl6bCWSdBWb9qi/U/ogKx82i2bUv7grPjJQ
 CIXrdrawzxhNbHjjn1mbNzDeBWHos6JgqTvW6Ux1sk1aldgTyWXREhWA1HnsdePn69F1uzFTcCr
 Oem1ALNlkKw3eyE4ygY3A3ZCW8RUm0bp25aJvSKkiGYw43SXVtLxhmGWz1ByKIdTiEVf47KU+Wf
 U9IhOmZyYQpUZhZq1Dw==
X-Proofpoint-GUID: 9rhmqE6ZnLdVPusYMueFvTLVcTJhOEqt
X-Proofpoint-ORIG-GUID: 9rhmqE6ZnLdVPusYMueFvTLVcTJhOEqt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX11i0V8VU0aui
 NiK70F9gqMZ5f221CbG6VBg8Tn0UA5s4DnkONmCkkEU2/0EFkicLFxRpM4KEO4yY3OOvgfCQ1xm
 gDrwh3hMqhiuMAMUEFA4/QPHUd6x26g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054

--VCchJjwU/KronfNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 03, Maxime Chevallier wrote:
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
> Let's make sure we clear these interrupts for multi-MSI cases, and call
> stmmac_global_err() upon tx_hard_error to avoid possible races with
> other interrupts/napi.
>=20
> For that introduce an "ERR" DMA dir, as we don't want to touch the
> RI/TI bits when handling these interrupts.
>=20
> Both of the above storms have been found on dwmac-motorcomm (YT6801),
> and are triggered by the xdp.py, xsk_reconfig.py, xdp_features.py,
> ring_reconfig.py and netpoll_basic kernel selftests.
>=20
> This seems to only affect dwmac4, there's no multi-msi mode on
> dwmac1000, and on dwxgmac these interrupts are masked as of today.
>=20
> Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=3D1 for multi-=
MSI")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V2:
>  - Dropped reviews/tested tags as the implementation has substantially
>    changed, sorry :(
>  - Discarded the helper, call directly stmmac_dma_interrupt_status on
>    all chans and use stmmac_global_err() for TX hard errors, following
>    sashiko's review.
>=20
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  5 +++++
>  .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
>  4 files changed, 27 insertions(+)
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
> index 7ffed295eb14..6360605ef5ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3145,6 +3145,22 @@ static int stmmac_napi_check(struct stmmac_priv *p=
riv, u32 chan, u32 dir)
>  	return status;
>  }
> =20
> +static void stmmac_dma_err_interrupt(struct stmmac_priv *priv)
> +{
> +	u8 channels_to_check =3D max(priv->plat->rx_queues_to_use,
> +				   priv->plat->tx_queues_to_use);
> +	int status;
> +	u8 chan;
> +
> +	for (chan =3D 0; chan < channels_to_check; chan++) {
> +		status =3D stmmac_dma_interrupt_status(priv, priv->ioaddr,
> +						     &priv->xstats, chan,
> +						     DMA_DIR_ERR);
> +		if (unlikely(status & tx_hard_error))
> +			stmmac_global_err(priv);
> +	}
> +}
> +
>  /**
>   * stmmac_dma_interrupt - DMA ISR
>   * @priv: driver private structure
> @@ -6494,6 +6510,9 @@ static irqreturn_t stmmac_mac_interrupt(int irq, vo=
id *dev_id)
>  	/* To handle Common interrupts */
>  	stmmac_common_interrupt(priv);
> =20
> +	if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
> +		stmmac_dma_err_interrupt(priv);
> +
>  	return IRQ_HANDLED;
>  }

Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> =20
> --=20
> 2.56.0
>=20

--VCchJjwU/KronfNG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaunkiwAKCRA6cBh0uS2t
rGlyAP9/4lNlgiouhiFLBiFnn00p1XBEQmgCE2YDorFQ6N0/GgD/WxuwNcrXlVbI
Kpjv1IOByUWMenAa0cv2atKZQJ1IKgg=
=mOzg
-----END PGP SIGNATURE-----

--VCchJjwU/KronfNG--
