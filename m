Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082022AE65
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689804; cv=none; b=FwPcz5eQjrXxa1o2su3qYVliy+3Os7+b/n6c/iv9IL6XVob8OjqSJKJIsUvu6EHs84MdjdpclsGDwaYi//uNt1QeFoMeUM26572YqIwwHkpFPqhU4SsXsOEh/W8+yEDXDXbmBYo/K+61amuvFy0YYrqTW3U9ocdnYibuLdnEfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689804; c=relaxed/simple;
	bh=An0f2FVXLAxnf7Z3EJYZ9Ctc6tXr8eBZ+t+GetBjUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI8eKGaRPHuFQ7LfYIGtQaVObCW30NcAyJdNrOi/suVjxaW7/Ly7sXvLdz6uYWUWGKlRWoif2k+qoCZANCoSRZOtSvTRBbRvWM3oNtJucmlOOY/aXyQgnLG+h6059YSzhda8SDa5n4SjO74hfqOMjxpiHyabMm+TxkkCltSC4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYH/Lv16; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GExQVpdM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYH/Lv16";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GExQVpdM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 685NxFMk680046
	for <netdev@vger.kernel.org>; Sun, 6 Sep 2026 10:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RAES5tpI2Om0LxX7UY7ndKBI
	WV90CK/isHyIRSM50fQ=; b=KYH/Lv16SOyT1IcTpvV29LqYbunK9yIig9Smgia+
	SUg7ZYuNtRG8t0eVEavLC27+D4EhX5NcXEFxe2SmJyxlzl5mPLPWT7GptRx1aRQq
	za9+HpkWWW/jyKwRMCVm8s5UD+Rbd5MXxwUxN6vHC+cQNEMUXq1UKm4e61hJxUFv
	p53Lwie5648DnYlU/qjG6jM3udzOpqMrw06fJhT9LA3j2gTHIAzyANgTv8a8PHaT
	PMKz1+zed35eFz1IjuF8g9Xl3bDIkHZLGyiR7uAmDWRRaX64YlwWSZUZjsqNs/xw
	Ingci2jlnKzWUOd7kU2v8uopF4mTs5gpop/ZyISxpXWfVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8sd3r07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:16:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ec3146553so641895385a.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788689801; x=1789294601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAES5tpI2Om0LxX7UY7ndKBIWV90CK/isHyIRSM50fQ=;
        b=GExQVpdMMMbD+0kbhdZvOPlaHT71qFnL2ljDUPmmusZ5LHbC56VyC8ZhIclJvOxYFQ
         vAjeQfSSxGls0eViTQC5XKPVk+VHchyBug1srL+cG9Xle75NynkjOM7TO4D7jQ0CqZTX
         N+6QXc+AK5mNlSLv529Jkwx15Os6+1LoXDFR68R5rlwUZE+fjuAy4bjAwQjQfjsTHTLJ
         uJcoaeRVi+dwXOsLO0pCwG0f5oMhYhnN9CZqeLgSwoTPhZD04aYF6g41yhgk4vZB1aUO
         y0+Ef4UkcJv7TnkzvwPwY4wc2kjjPna3u/0JCd5DZmElk3allA87vhxRy8qNRWO8YlRW
         gFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788689801; x=1789294601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAES5tpI2Om0LxX7UY7ndKBIWV90CK/isHyIRSM50fQ=;
        b=dajihXED1yx8pCthY01N4UHX/PUO27U/HAJSPl6WDZjkYut5XxferNuPbU0v8wGBv/
         pN03IXZwC0Q0qp1MbC/3iFV3hy55wckNcfmdiJAde6n0FqrhJZEaKy9wa4GP2Rb2O8Fw
         jDo5kgSgLwA8PHqZwafdK38fwBIiWQZ0m5ToBOet0zVc+1WXnwiIhXtYVo9rX/TufLil
         RHeEZ4wk1mamud02J3/myxEf6In+c4gXDC/Eilj2tk645NximyU8EcLPA3TjJLbT386G
         LDLHKkUsCt8i+7Pl1Azz+UdomHW2PiEINOp0r2fk2ZB/ARDANSaG5gKGU+vybXZVpAud
         WjwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA2H4f7mAhL5YbMXpyS9H8Dv+vhKB2b1/HHRjyd/RscG+sOP2bRK6YNRmek7WSC0Q4pN95zu4=@vger.kernel.org
X-Gm-Message-State: AFuF++kB/NKrDe8K+0/pI63hiCclL14l9uzC+r9dZF1i3i9wlhMY2Etc
	zHA6Abj+zUMaPFqP+wIa2dAM4uzgHG1vsdiyivz4VnBqZzQYX3WXvu5JJaLYJL7qCFqkXLrSTVy
	bAr80iamqmeBvtucw7L8CVhwHx81sPRaczWsdfImyYIGBQp8hMNPNj+I6OZk=
X-Gm-Gg: AYBFou0G1BPZmZ6iCtwNcqhXr8zg3gln1lEyNkbRrdfi8dJncdRoCJ9XbPA3K1Nq49a
	MDbyS9QO3Tj84vGg+jPzRVrMh4cCqTMn+Yz1bZdAFvfNfOFzygHxk37ZtSYTU+gBLfjqvgDEPs4
	ieaexY38ZZ4kho1hfmjnxUOtMQyVWJX0U7G1tLIFDXmsaEm0R6K1yjxaYRc2InRw0NXouqNag26
	HW3BISJ3fNTD3k2K+uCdri3UWvrT4T65HsjMOrmJDP5BSjmPNeXXd36XWH8HXHtakRSW8pS34Vo
	FOBCRqlys+tM8nBlUsWzxv7Qct5g3KGi7okg+yaRUKf2zDsRbZ7Jhm1NfeHDWLj0XOZKzuI6Z/U
	FWtefVdUgvwDgSQ==
X-Received: by 2002:a05:620a:294c:b0:930:f723:35f5 with SMTP id af79cd13be357-939805f1809mr1625300285a.20.1788689801352;
        Sun, 06 Sep 2026 03:16:41 -0700 (PDT)
X-Received: by 2002:a05:620a:294c:b0:930:f723:35f5 with SMTP id af79cd13be357-939805f1809mr1625296685a.20.1788689800828;
        Sun, 06 Sep 2026 03:16:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm673032615e9.0.2026.09.06.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 03:16:39 -0700 (PDT)
Date: Sun, 6 Sep 2026 12:16:39 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Ding Hui <dinghui1111@163.com>
Cc: andrew@lunn.ch, Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, dinghui@lixiang.com,
        xiasanbo@lixiang.com, yangchen11@lixiang.com, liuxuanjun@lixiang.com
Subject: Re: [PATCH net-next v2] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
Message-ID: <ap09hwoKJjqQWIrB@lore-desk>
References: <20260905154654.1725313-1-dinghui1111@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xWjH8VhHG9dCfn2h"
Content-Disposition: inline
In-Reply-To: <20260905154654.1725313-1-dinghui1111@163.com>
X-Proofpoint-GUID: 1XVeOSCOULUed9DW_HYCEVmY0Cr-dPtu
X-Proofpoint-ORIG-GUID: 1XVeOSCOULUed9DW_HYCEVmY0Cr-dPtu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDExMiBTYWx0ZWRfX7zoX8YVWGvrT
 JdFHBbTU+A8A3A7tRJlQTXmNz97u0efpqjnGo9LozmVivZI8uSHfuxX7U7wG1ATBTG0Mkl7gpSe
 O3G7qftYMoxfZKf44s2FemKZDEHj/qw=
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a9d3d8a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=FvjeeQ-HAAAA:8
 a=OGClekyxBy5Cn5ele3gA:9 a=CjuIK1q_8ugA:10 a=pK0oTnKYjgWuoMMSC_sA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=Xg4jrX4_cAy-VDzvcMla:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDExMiBTYWx0ZWRfX3LQhyYXQWwSF
 IVzGR3kz5i3TckNTU21c8LoYPEj2vWqiuaX5pMS8YJG+rzhrZ6ckUFn95xZMSRZWQVYTxgXHtp4
 uOhUlLHT/EE/pPbO/bvn86mKBDW4xDBgezA0c2/vlpbyYFpArajsdvkZs4IWwTKp5xnrXEcPbBT
 USsmgCGLAE9YIwFWIMnKM5WCX3bFH5Lf0lmwfVckSM6OFrF3nSm02VFw1g4uYuH+zGiJN6gdq7j
 zvlZLHSEvfjxfl+cPbjzqAXMmDe8tT3HIg8qG6a3KWzbfZGNbD1pXVn688f+cAh0uS5Ihy2ICE3
 0p5JAmizYdV5+Y78u14JgdXmCftFhjQolo49RHUbycbtIXOu2oeL03TelSpZsw09hRxTFS5XQtA
 y6PQV+Bdw2T0wdHdR/TgMr/0ftQiDA7HKa9S4FJ5/d7SUHFsWMbnIQTQ+kFouVqBBt/OkTWxIHf
 AydObrYTVMGdLLNyPJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060112

--xWjH8VhHG9dCfn2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ding Hui <dinghui@lixiang.com>

Hi Ding Hui,

just a couple of nits inline.

Regards,
Lorenzo

[...]

>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 59 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index f2fc89176654..f0e06c011b8d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1728,7 +1728,7 @@ static void stmmac_free_tx_buffer(struct stmmac_pri=
v *priv,
>  					 DMA_TO_DEVICE);
>  	}
> =20

Is it more appropriate to move the tx_q->tx_skbuff_dma check here from
dma_free_tx_skbufs()?

> -	if (tx_q->xdpf[i] &&
> +	if (tx_q->xdpf && tx_q->xdpf[i] &&
>  	    (tx_q->tx_skbuff_dma[i].buf_type =3D=3D STMMAC_TXBUF_T_XDP_TX ||
>  	     tx_q->tx_skbuff_dma[i].buf_type =3D=3D STMMAC_TXBUF_T_XDP_NDO)) {
>  		xdp_return_frame(tx_q->xdpf[i]);
> @@ -1738,7 +1738,7 @@ static void stmmac_free_tx_buffer(struct stmmac_pri=
v *priv,
>  	if (tx_q->tx_skbuff_dma[i].buf_type =3D=3D STMMAC_TXBUF_T_XSK_TX)
>  		tx_q->xsk_frames_done++;
> =20
> -	if (tx_q->tx_skbuff[i] &&
> +	if (tx_q->tx_skbuff && tx_q->tx_skbuff[i] &&
>  	    tx_q->tx_skbuff_dma[i].buf_type =3D=3D STMMAC_TXBUF_T_SKB) {
>  		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
>  		tx_q->tx_skbuff[i] =3D NULL;
> @@ -1761,6 +1761,10 @@ static void dma_free_rx_skbufs(struct stmmac_priv =
*priv,
>  	struct stmmac_rx_queue *rx_q =3D &dma_conf->rx_queue[queue];
>  	int i;
> =20
> +	/* buf_pool may not be allocated if alloc failed early */
> +	if (!rx_q->buf_pool)
> +		return;
> +
>  	for (i =3D 0; i < dma_conf->dma_rx_size; i++)
>  		stmmac_free_rx_buffer(priv, rx_q, i);
>  }
> @@ -1802,6 +1806,10 @@ static void dma_free_rx_xskbufs(struct stmmac_priv=
 *priv,
>  	struct stmmac_rx_queue *rx_q =3D &dma_conf->rx_queue[queue];
>  	int i;
> =20
> +	/* buf_pool may not be allocated if alloc failed early */
> +	if (!rx_q->buf_pool)
> +		return;
> +
>  	for (i =3D 0; i < dma_conf->dma_rx_size; i++) {
>  		struct stmmac_rx_buffer *buf =3D &rx_q->buf_pool[i];
> =20
> @@ -2097,6 +2105,10 @@ static void dma_free_tx_skbufs(struct stmmac_priv =
*priv,
>  	struct stmmac_tx_queue *tx_q =3D &dma_conf->tx_queue[queue];
>  	int i;
> =20
> +	/* tx_skbuff_dma may not be allocated if alloc failed early */
> +	if (!tx_q->tx_skbuff_dma)
> +		return;
> +
>  	tx_q->xsk_frames_done =3D 0;
> =20
>  	for (i =3D 0; i < dma_conf->dma_tx_size; i++)
> @@ -2272,15 +2284,19 @@ static int __alloc_dma_rx_desc_resources(struct s=
tmmac_priv *priv,
>  	}
> =20
>  	rx_q->buf_pool =3D kzalloc_objs(*rx_q->buf_pool, dma_conf->dma_rx_size);
> -	if (!rx_q->buf_pool)
> -		return -ENOMEM;
> +	if (!rx_q->buf_pool) {
> +		ret =3D -ENOMEM;
> +		goto err_destroy_pool;
> +	}
> =20
>  	size =3D stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
> =20
>  	addr =3D dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy,
>  				  GFP_KERNEL);
> -	if (!addr)
> -		return -ENOMEM;
> +	if (!addr) {
> +		ret =3D -ENOMEM;
> +		goto err_free_buf_pool;
> +	}
> =20
>  	if (priv->extend_desc)
>  		rx_q->dma_erx =3D addr;
> @@ -2296,10 +2312,27 @@ static int __alloc_dma_rx_desc_resources(struct s=
tmmac_priv *priv,
>  	ret =3D xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
>  	if (ret) {
>  		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
> -		return -EINVAL;
> +		goto err_free_dma;
>  	}
> =20
>  	return 0;
> +
> +err_free_dma:
> +	if (priv->extend_desc)
> +		dma_free_coherent(priv->device, size, rx_q->dma_erx,
> +				  rx_q->dma_rx_phy);
> +	else
> +		dma_free_coherent(priv->device, size, rx_q->dma_rx,
> +				  rx_q->dma_rx_phy);

I guess you can use addr here and remove the if/else block

> +	rx_q->dma_erx =3D NULL;
> +	rx_q->dma_rx =3D NULL;
> +err_free_buf_pool:
> +	kfree(rx_q->buf_pool);
> +	rx_q->buf_pool =3D NULL;
> +err_destroy_pool:
> +	page_pool_destroy(rx_q->page_pool);
> +	rx_q->page_pool =3D NULL;
> +	return ret;
>  }
> =20
>  static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
> @@ -2352,14 +2385,14 @@ static int __alloc_dma_tx_desc_resources(struct s=
tmmac_priv *priv,
> =20
>  	tx_q->tx_skbuff =3D kzalloc_objs(struct sk_buff *, dma_conf->dma_tx_siz=
e);
>  	if (!tx_q->tx_skbuff)
> -		return -ENOMEM;
> +		goto err_free_skbuff_dma;
> =20
>  	size =3D stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
> =20
>  	addr =3D dma_alloc_coherent(priv->device, size,
>  				  &tx_q->dma_tx_phy, GFP_KERNEL);
>  	if (!addr)
> -		return -ENOMEM;
> +		goto err_free_skbuff;
> =20
>  	if (priv->extend_desc)
>  		tx_q->dma_etx =3D addr;
> @@ -2369,6 +2402,14 @@ static int __alloc_dma_tx_desc_resources(struct st=
mmac_priv *priv,
>  		tx_q->dma_tx =3D addr;
> =20
>  	return 0;
> +
> +err_free_skbuff:
> +	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff =3D NULL;
> +err_free_skbuff_dma:
> +	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma =3D NULL;
> +	return -ENOMEM;
>  }
> =20
>  static int alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
> --=20
> 2.34.1
>=20
>=20

--xWjH8VhHG9dCfn2h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCap09hwAKCRA6cBh0uS2t
rFpLAP998k3ZRb2rMMqwIUOKvZsgOTIcD0qc6Q58kuCly+atjgEA5pEAnwMWgdJ1
vQpssx8NIzwM3dXQbIr/iNqtu5ZGQgU=
=XDBs
-----END PGP SIGNATURE-----

--xWjH8VhHG9dCfn2h--
