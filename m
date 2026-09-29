Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33439CCE6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666017; cv=none; b=q14JnAoxlCSEzkrWTm9N31CIQaTh4hTdTJYk5NFASW5geGQ8SIlIi9AOKV2brHBqDra6I+3Vi/pw44nThS0j/VlOxjFmd2UmsqT6/Aaf/VDxjD6kdPZAcB7VupVAaJvro7zYL4rTPCI4TB6+KigB2nsGa4mYKnsPwI4GZ7iRlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666017; c=relaxed/simple;
	bh=OD/2Z9i5FlYVANmscJPSCqUoHst2gkiQD2aSmRFY5y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBk5Jp7hTC9JvZSxlS9KANIyuvSPbqEJtmsBlEelK4og1NZDJGQXJ0M6xVZ6VNQTGmtGhBSwvKXFiGJlgK7023LHDa6eG+UXIgCyWNw/ihzpab578X5bDc7Z95mUi63vRASxvLj45wdXlHV9BAZShbSaZjxJRsJAaeqvcz7MIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ppg4JIaN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayq/Caop; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ppg4JIaN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayq/Caop"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4755k3390851
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aRA7DODR2959lHEtpusPTNFu
	ptGLf/zMYDjv6njZNl0=; b=ppg4JIaNJrD60qPhc3j5QQ2Br97bfPxdFzjvjiAH
	wVEg2El/VgB1E8kCP2fxP2I+Bb8VSI6MgatqI5IKjhXWtaeY/LK1d9vYP1KKLmry
	jOZ/m8gusaZI7lLOH9Qv8iDEJfS56NdIbO4fRANNs5+O31eR0EAQGLk1dEEM+w4b
	SoAk2yyRrN5k5eZ1PYf3B2Jz9UYqH4HMzpxe8C9t8u9f54LcBRJw4zMr0FDHjnoX
	BLZZrFNxjAktdirKEzOC3XZWk25lJLXwD2aKr13UFF8Jxo9OGH1aF492qZGEfUqM
	uYy6NVQ5IC5zkBO+dIifZKY1hE5wuLx2L7xPazOfkrTsDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkhgak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:13:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93c614646e9so419204185a.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790666014; x=1791270814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRA7DODR2959lHEtpusPTNFuptGLf/zMYDjv6njZNl0=;
        b=ayq/CaopsnaAu8Bvndioau0ZnOZQEQQ/5Stz609XV2KRJXObQYDdI+EUL6/urxvD3z
         Hw8A3aRh4CsFWhaItAWw5ucbkmerHP9qlOEI2afZSxs8xZP9VZX/s/meWvAI0GEg056L
         H2EmekYNj7bQ9CmLIQx43Cpointkbd6+Yjw/EwCQ/PROB45KBvv27KhDwGR9Gx7fP3fb
         5GxSShSq52p43uy2Hlo/h+DgxxLvjD5HalFOtSeIcoaASx4+iYts59dCj3hcT1R8AwGZ
         j+yW4mbhRGJspJxULnjvA7XqqSfxQ+xqtCySjGiajaxCZ42UCECpMJQ4WUauHHSiWYYQ
         s68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666014; x=1791270814;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRA7DODR2959lHEtpusPTNFuptGLf/zMYDjv6njZNl0=;
        b=q2jwS8jv3tJcnOH7cJs8E6NBcDyYhbpcCEWygPIXeWz3idqQB4s+Ze6MB6mXhvMr6e
         xomQWUG6c9+uk9syAgHDkgulqkbLUacsSGq1uiJHY+xlV/VjBTzc9Oi4kx4AwUd4yvh4
         zMSVyRq5CwDpinGSAT3RdrqhPr/NT5xvmqKUybM3hp1X7jcwDhxkXut3JXpxHquLXZ5S
         hPzwMcxB3IyYjCFqRcGQSGVhLc1HUbG0mnFQA5fEp1KK6Yyp1T/PKvm8FGdR7YY7m107
         KEeWsO17VhGD/EbR3zGTEeuP3erzACS4up/HmDjNCQJ7euoMulTBQEXWGctZYK21FvFe
         m9OQ==
X-Forwarded-Encrypted: i=1; AKwUvByAWUunS+Ah+Vz7eNocUobLIVxEf7fzg+Sgs0aPICdp9eD7htgfsHxlstcV2eRLwSzkE1bsPfs=@vger.kernel.org
X-Gm-Message-State: AFuF++mREliZt/W/N9FFyIbWD8YPv7aHNfUylghgMe4/EQTDMDWrNdnO
	M6th1BsxNPuZcuau8hjzJaSF92g8bWr4zWcqNCvxa7P3qs8JMJdPC8sgWHi0XzB1JZ/3fVw03v4
	+BXYHGgy8mBpPynDgRF/oKjiUtH7ljtQlR02AzkMXz8efVJueatgQiN0hvAc=
X-Gm-Gg: AYBFou0Iq6AHM/lVsYe6SmshR31JN1T8h1gkvrZ6t0dIT8J5ap08OFvxbZb3wakToRB
	XpWhucYIi/R2hOprcc/rjAFsXNp+HO/XeAVUExZ7hdlyfIYSc6dpG7A3sloIR2k5I6XbHHXwQoz
	k+R1VPkEYNcQ1IuTdGqwf1p/IelL6uVpHNwOdQ8N8puPPa6gDIZXAUe20yuvdhshnLr49koKWWs
	ON9lpIMbuJhbgQAYBrbTdIdg9F4y1LjbKPobzjEFdJuSnOWJXLwNRBwnFOE4hxNsM1yJuZjWpIC
	dDFgJW3qmQwAbFmjvMWrqIQhZdIit0bV6B6d9UaYcQ/1TvDMWmENw5ggtXPqmJZUMO45clECZnt
	6z0e6bJLN3KSu1g==
X-Received: by 2002:a05:620a:404d:b0:93b:ee1e:6714 with SMTP id af79cd13be357-93c43d2359dmr2340391085a.60.1790666013998;
        Tue, 29 Sep 2026 00:13:33 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:93b:ee1e:6714 with SMTP id af79cd13be357-93c43d2359dmr2340386485a.60.1790666013318;
        Tue, 29 Sep 2026 00:13:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af507f33fsm1745638f8f.24.2026.09.29.00.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:13:32 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:13:31 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
        thomas.petazzoni@bootlin.com,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Don't set or get RSS
 parameters when not supported
Message-ID: <artlGxdHjIKyuPuP@lore-desk>
References: <20260928145043.1228968-1-maxime.chevallier@bootlin.com>
 <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UlNQx2lngAS2JeLJ"
Content-Disposition: inline
In-Reply-To: <20260928145043.1228968-3-maxime.chevallier@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX6YMjtgetyTSl
 hC/FsmmjPahgHaYsXJ8WZTIjjPk2bsw5X0UNHGigkmmyoNqrmE2pC39HvwA1+GONLAssqtgGiL8
 UFSeYQiNmNWXAO34JfZjqB7pmKrnd8PrDwpRBCf1TFTnZDQCkDX3Dz+U3ZCgSW0mPWOjHrSIgVX
 lbXXXq6Xelh2Jl8nF/h2DUemIe0OY5j1SkK1MKA5W0bvKelxPy3SW7r5JnwhGnefdSaL+UolwyQ
 JKcJfYisvixJPOdwOGxgg73+/9DfE+jIAWwECBrUXOrbLr0GesjfZRyFz1QbYl9dj6ZCC1JeWzg
 uh7KSX10R7SFw8/OqOwTjZ2RWMvoH3Phm8i9nZ1kobgYXFQzjeICCFiHIQr8j1lLOR+oYV+RycY
 d3HRor59LgDhfuMmVjlIePcSOK2MHbGfuHlfiS9EaIPufc1WQAGmql6bs8FeGoE2U4ur6C6Gv1w
 IdUs0F5hZv9ssErNAKw==
X-Proofpoint-GUID: YCw32qHM-lUUQzjNRdIBQtpy9KNI6aKg
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abb651e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=8xPVtbtLPbnhiEF_wpUA:9 a=CjuIK1q_8ugA:10
 a=pZA6dvReJZDbMZWyEwoA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: YCw32qHM-lUUQzjNRdIBQtpy9KNI6aKg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX4QYbk/Qkztwg
 2Lbrk+J2XLRjdR6Yv42zqjTHICdhDrk9xfoqNNxwk9C46zgA5y91qE8fTa6LqUSs9k1JQ+wT5sK
 5/OCbSNpgPHPsMUJV7NQ62I5IgtEteA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290028

--UlNQx2lngAS2JeLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
>=20
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.
>=20
> Let's return early in the rss ops if we know the hardware and platform
> don't support RSS.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 154cc0c7623d..b78dc301d70d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct net_device=
 *dev)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
> =20
> +	if (!stmmac_rss_is_supported(priv))
> +		return 0;
> +
>  	return sizeof(priv->rss.key);
>  }
> =20
> @@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct net_devi=
ce *dev)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
> =20
> +	if (!stmmac_rss_is_supported(priv))
> +		return 0;
> +
>  	return ARRAY_SIZE(priv->rss.table);
>  }
> =20
> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	int i;
> =20
> +	if (!stmmac_rss_is_supported(priv))
> +		return -EOPNOTSUPP;
> +
>  	if (rxfh->indir) {
>  		for (i =3D 0; i < ARRAY_SIZE(priv->rss.table); i++)
>  			rxfh->indir[i] =3D priv->rss.table[i];
> @@ -962,6 +971,9 @@ static int stmmac_set_rxfh(struct net_device *dev,
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	int i;
> =20
> +	if (!stmmac_rss_is_supported(priv))
> +		return -EOPNOTSUPP;
> +
>  	if (rxfh->hfunc !=3D ETH_RSS_HASH_NO_CHANGE &&
>  	    rxfh->hfunc !=3D ETH_RSS_HASH_TOP)
>  		return -EOPNOTSUPP;
> --=20
> 2.55.0
>=20
>=20

--UlNQx2lngAS2JeLJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCartlGwAKCRA6cBh0uS2t
rJCeAQCl/sM1/UiVOqNd4jhL5Oy3pU029vOCKWXEOSlJSz+XZgD/d+i/oeT18HiZ
DpFlaHzEx66iglM4gU7yoatpOMjQPwc=
=kiG3
-----END PGP SIGNATURE-----

--UlNQx2lngAS2JeLJ--
