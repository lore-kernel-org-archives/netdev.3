Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C738B123
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551100; cv=none; b=liBWdcyi450EOYLPxef5wIFjAz68B+m0lU/ZNYty1e5vSpiOVIFL0dKGkYN7r4EaclJrEGH3djcnSFO0aq4pDdRMlOHI/VM3pzg6eRK/Sn4A6FyoMdeoR3GCt8HkMXDLfGWQ9h2O/Z8v+6VDa+pjr4LMCqbuK1OtWjpePfo4cu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551100; c=relaxed/simple;
	bh=eOg5efoIcioA1CJ8I8K8EhrFmWYxJPNxZcSPjMrOcCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XATZpHQF+yYmQkNW64zEEihewtBSutns6MMwXp9pGB8UIRfeNq3DACUtEvG4xxwV2yQJOaSer45gxS/caCbGPabkm9twYpGlmciVV2KvZgbaD/O4E8u5MKhURLT71XUocqCzsIm6ULd6X8XR2dRXKrqqZ0fT36e/pOByY5NQt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGQlhvAP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alX54aVu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGQlhvAP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alX54aVu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbni13949799
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XbfAZdLb7Gd/qSUJdj/UERpG
	GTxWx7AQk4XHSPv4SiM=; b=KGQlhvAP0jr9XkEYhBKvzXRjo3jo54aXUdukIUr6
	XluiRkeMgXQolEUr9aFip878cPikWcX9lgw5DpllZWms2Vd/a/AE9sw+kdyDrOhF
	0dyZATXtKB5FywtApFQjwvuGNhlMV2fGv4Z2H9iMuB4r+QlnP0/TqPK/sLAf6LWi
	DYLK3QcT1Jv3lH+fYxmwKPhyCPqgmary9VOTYYzixKQWmK40ZErIjQBGc6gNJv2N
	6mOgBfvpPRenzxU8Ae4JAihR6wyOTxum4YsLOxVNH8NLq3LYEgfUOUNBj5z5Yb3F
	9mIX/hMoAl9li1hAK8AUjJfrr0sW6pMhki4PkAqXxo618g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2txa7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:11:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e04598adeso1053159b3a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786551095; x=1787155895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XbfAZdLb7Gd/qSUJdj/UERpGGTxWx7AQk4XHSPv4SiM=;
        b=alX54aVum1mcofpsxX8chRFLdCmhzosMQe398UminSZt2K0F6fnF0x2UT9i0nXNCJx
         WaBZITI5lz2bv/ulXl2YkThE1qrATfaDFQ5BLQEcp7BmQDMZMIG3gzwEukwwMr/CXVpP
         gU8Ug6N6a7RNkZ+BeVj5YvVji3fg6Mela5P2cgYfKMVoyIAUSnqGqfqwFhnkHnKmJM6h
         r6K3OIwOPcmWaQLnPyE67nBJE7pWz2PdF2tM6zZGZ5sytCh33bMKd6ypGgF6Dt4kygyJ
         fSlICDGHJXBkmyvM6M3mGebh/EvIQG6xLvrRyKdGcIXBc0wCk49Ds0soEMvtPPtIBVS3
         3OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551095; x=1787155895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbfAZdLb7Gd/qSUJdj/UERpGGTxWx7AQk4XHSPv4SiM=;
        b=fw81TEf/g3V2jgGMyn9NqD+M3KR3dAXscv9DVOd/CPW1r8Q2FYWC4PlqV1adEayJIn
         7bDISWQzDtfF9qQ8IKfFeKiEuhLEQbsjhj1z3VpoiT7JkM4UE5lkRGOl0Av6RpU9XQyu
         R5dPxjURKdxjXeErsQIiITCzofmxPssoRetQ9W9V/gOelFpYChfgq8bL8WexgBlxnGu0
         tK39g4+w+wUEwipVFiaUiTY07r0RWcxeNozpJQOwg78OuFhu4lF3J2RC4zl/qyTUubuT
         E/WBzAcxU1a07uaHDMNJviwJRXuwTuS8m/1wEGGlfFHxZ8UbM8MSi/gi3JsiikgAA3kF
         apFw==
X-Gm-Message-State: AOJu0YwvGomfN3EbOpBHWcXJMB9o/sisf5i5oiX0qkeUSTPI5fTbj3Wc
	4d9KtITfxAQe5I4px2G4PFqyi48UCwSKT9AkD0rY9lOfsVzuYOxmLu1G2vjk5U+Qu/FyCVJSrrH
	QWfknK2ccxBBeMuEZzJovphyyoT5kYFghdvZCfnFjWko7tIwNTQQVon64Fz4=
X-Gm-Gg: AR+sD12bF64VoJbCgA+lsn+lopiLrXvqTf3Fp2769Xu8EIKqBD6k5WvbIFkx6k2EHmI
	2DP0UZk2WAvDyUAr3IxOiVVRpASiNI8sNHfck0R7qc4G3Oynnjay3PR4/vypaTfn7ljCJxL7LoH
	8y57TwNQ6aLCBsY5CeZ2Go38JZ+/qGaie0MpGQyOU0t2IRXwXXMJGZedNky066O3p4bY3X5dG4W
	U3cYihtXHOymrfm6+s8hx4Ic7YNGn8/tu9Fj6DfbymZ6i2NKRicajdJoGD3d+HCXgMEOsRpmWf8
	xUz3Fma7axx8ufT4Hy1Ht6XyiqRJqeL6DxL78Lq9WMcAXCkoVWcEOIC09yp+TfNJKdFczMMJEHm
	LAXS42ZL3vzxmtA==
X-Received: by 2002:a05:6a00:1311:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84fb55806bamr5807432b3a.35.1786551095083;
        Wed, 12 Aug 2026 09:11:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1311:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84fb55806bamr5807350b3a.35.1786551094390;
        Wed, 12 Aug 2026 09:11:34 -0700 (PDT)
Received: from localhost ([4.43.230.115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d3607bsm941868a12.25.2026.08.12.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:11:32 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:11:31 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: stmmac: improve TSO/GSO queue selection
Message-ID: <anybM_3Rdg8X8CMs@lore-qca>
References: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iLzute234UfZUCF8"
Content-Disposition: inline
In-Reply-To: <20260808-stmmac_select_queue-tso-fix-v2-1-67175b29772e@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c9b38 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=f2H3biQdujjI0Mw2rri0Ng==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=eOeSzAT4wrZiS6Nb83cA:9 a=CjuIK1q_8ugA:10
 a=CIrVCWbjoDn5-O6LZhoA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: gaRmcSaKtUbwLTnYP41hCttnECOK_pdf
X-Proofpoint-GUID: gaRmcSaKtUbwLTnYP41hCttnECOK_pdf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX5BZradAzb0UL
 EZbg51G5oe6KXVWXe7XpyiT2djsF9G5PjsPajdNLnq1eDxe7FqKgPdSIEw/F1aNKTeC984AgLhl
 bAHV0Xn80YDae3BVZqhXqdr0Ps7KJzw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMSBTYWx0ZWRfX7X6/4L+Ra8Ee
 4J21ANRk6/K5uumZFr1GQRTld74x2fwYqyVs1tZxs+VzxifuHKGO9TU04KPvFbo9qJiyscEefwE
 L3/ci69m0O+AQ2FUlZdff/GUem4QqUooq77nBEWrlbeAjW3qWm3aDBdyNzSXroetDaw5UEUeUBl
 ZfWBRRrymqRXsNcyZ0NpzTjTA2Y1wxnyqGAlwXFtWUbc9Ix5ZvIZezf9Kq+RFbOA5apGGd1IPrG
 Pt/WJ8TY/q7kS5BSjnUJ2WusDWE/gNTdYmErGA4yrqqQKM1UYIgtI0S5eEkNZKTml+uiA8yD6om
 rSDmaYdwyyIi9ZltCFppU2OTYEvQiurkUPm0wmIZPMbDn8mGVP0xwiK+7sxcFBBSnAeWXyd/HaE
 iW4j/vWVba/NamFzcCArJAHl43gjhloC6eKfqtshHqoxRieluWORUvdx8Jlz8FgqPR6FeFYVuvu
 WPBpMGAaRRUytl1PznA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120131

--iLzute234UfZUCF8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> GSO (TSO/USO) frames are currently always sent through queue 0 since
> the driver assumed there was no way to determine which queues are TSO
> capable. This unconditionally pins all GSO traffic to queue 0, bypassing
> the per-flow queue distribution and any XPS setup.
>=20
> Instead, pick the queue through netdev_pick_tx() and fall back to queue 0
> only when the selected queue cannot provide hardware checksumming (COE
> disabled) or, for the GSO types offloaded by hardware, cannot run TSO
> (TBS enabled), since TSO and TBS cannot coexist on the same channel (see
> stmmac_tso_channel_permitted()).
>=20
> While at it, base the TSO capability check on priv->gso_enabled_types
> rather than a hardcoded GSO type mask, so it matches the TSO/USO
> capability actually used by the transmit path (e.g. UDP segmentation is
> only offloaded on GMAC4).
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

please drop this version, I will post v3 to fix some pending issues.

Regards,
Lorenzo

> ---
> Changes in v2:
> - Take into account when checksum offload is not supported.
> - Link to v1: https://lore.kernel.org/r/20260807-stmmac_select_queue-tso-=
fix-v1-1-4c4787bad02b@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3..7a4bd0292966 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6445,19 +6445,21 @@ static int stmmac_setup_tc(struct net_device *nde=
v, enum tc_setup_type type,
>  static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *s=
kb,
>  			       struct net_device *sb_dev)
>  {
> -	int gso =3D skb_shinfo(skb)->gso_type;
> +	u32 queue =3D netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
> +	struct stmmac_priv *priv =3D netdev_priv(dev);
> =20
> -	if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6 | SKB_GSO_UDP_L4)) {
> -		/*
> -		 * There is no way to determine the number of TSO/USO
> -		 * capable Queues. Let's use always the Queue 0
> -		 * because if TSO/USO is supported then at least this
> -		 * one will be capable.
> +	if (skb_is_gso(skb) &&
> +	    (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
> +	     ((skb_shinfo(skb)->gso_type & priv->gso_enabled_types) &&
> +	      !stmmac_tso_channel_permitted(priv, queue)))) {
> +		/* GSO frames need hardware checksumming. Moreover, hardware
> +		 * TSO/USO can't run on COE-less or TBS queues. In this case
> +		 * fall back to the queue reserved for TSO (queue 0).
>  		 */
>  		return 0;
>  	}
> =20
> -	return netdev_pick_tx(dev, skb, NULL) % dev->real_num_tx_queues;
> +	return queue;
>  }
> =20
>  static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
>=20
> ---
> base-commit: 8ac4255c1e0c83d2e1559a18b8918673116fc8d6
> change-id: 20260807-stmmac_select_queue-tso-fix-06cc586d4022
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--iLzute234UfZUCF8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanybMwAKCRA6cBh0uS2t
rLw+AQDYUIq7wRrULOWg4CrNbvX2N9Op34JkkAtDXEeQQ97yNwD/Vpyc3UeG+iXt
waxrD4T3gZH18kfuM0iEjSHBI2wMBgk=
=TbQQ
-----END PGP SIGNATURE-----

--iLzute234UfZUCF8--
