Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76635C185
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816312; cv=none; b=fB9021EAe3ThcV1EQgiSmnyaPyy0bmhPfZKiwluoZAMb3Bu7WQkDvKpflDtwlwV5eyyC1LY8ABUKekrPtnnZ8Q68B9rROV/Ok7xqG0i0ekX4SKRucL7Ups7IGJKrBmVHprpv1FGojFjY2CWCO8N+/NBMumSf4GhQh0/31Do4crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816312; c=relaxed/simple;
	bh=AKzxBI1sYO3N/bgDdviS6pwi3X9RzpL64Pi7AsCyK78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H86L2LhFmx7xUpyyHfIVvO2UfH3kBEJlYktlmOxFt18zkLlsVvUIckTTtKPEjMjaeMD6eu0/+AcNRt53yI5WthfQzRm6N4t/yLwMiNCH/rsqeVDgFPym2sRL5JvBvfK/q/tYWXRZGR1YMU8zmDuTM1NZesgK/rk2Hdll52Sc8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTyMm3qB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQuRDoZv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTyMm3qB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQuRDoZv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RI4W2708688
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mCq1pXof4PNvwoWC3gxNhgB3
	/AV5Ee7h6VXEYj74taI=; b=WTyMm3qBM35T1CiCnhos9UpQSma8pX+y6bZDJkjU
	1V8rWtEbLf4VS3gdqqB+fH3hCaOeFyC+4TWGfUhJE4Mq0EbFnQsaMIsnfJhLyjRn
	RWJU4GDB7lErxG8ktBNL6oP5W/H+EANSjqla0t8NDxCFSYP2UQfKBYMVqqhHZqzF
	Psz4eAy1Uwix9HBdwKhBG7BfrLSUHDrwXc5fDcLosA3g2BmHTpM7n1cHTdsGvgHr
	LSDsb/gdkK1h0QbVvyUimgR5EkkDd5W7r/Q7qU32vIr4X2xFImYv150N3qFV+BTb
	KfSSUEqDQh+EwI/Sx5DY+hb8XLmstMDeKau2ROKajpj6dA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwjnwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:38:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21c01cf3so32923051cf.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787816308; x=1788421108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mCq1pXof4PNvwoWC3gxNhgB3/AV5Ee7h6VXEYj74taI=;
        b=SQuRDoZvLTpANGQRLJELDMFHu2bFKz5wd2Vbojvhr30Gaf2MRyOrry8tnLZ3HLvbwa
         NUk0FJ60jHqZB6xgMvjJ6NfXeu5ut0N3eU3r48EHMgh+jBQDscQ0ArTlcvrTlm+N2R+u
         /7xHuyLjtnZZlADbDuTCxOp6Qo3qxJPGgI3eRwjigy46AewwgrB4jCfRrbKYCyfr0XgO
         O7u6LfuI8Hz+rwS3ZSw8sg2R/f8aweVr4PGegC7vkOJ8mwNi+VnzjlVfyc/vnvnlaK9G
         7x0Qp1462aGnQ5UUnfklZhrk58E9AAAyJX6Nbmv41zZGIZkUfFgKJ1XxdOxBXugvSxX2
         Qryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787816308; x=1788421108;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCq1pXof4PNvwoWC3gxNhgB3/AV5Ee7h6VXEYj74taI=;
        b=sO2nBvPZ49jANQCBI+B8DK0tak3VmkQGzvL/2sufgrIjHb/lrx2rvpHF7d/UkvFGLl
         ocyGXVZhdJv8gcyaWAt6zZ6bOx/m4e5/onhOkV7qfCcYqbObKmn78xNS+2ErhWBQnNmM
         YpXMhr9VCE6yHk3LTIitPmWoGonFL5lImXFd+tXc4o5jgp2f4Gn/Q7xVy6fw/q1MV0K7
         xJ0IvkZ6zS6zKY4i7akA/2UPg81qF9yTqcgsoh/XB7vX6tV/avACMF8XVKvGaWAdXv8w
         FDgvJ6Q86AaS1NAQa8/gSup82RtbUFUxKDPe4tBQJWkbSNyvXssHAwAIJ3qoetrzrh+v
         fsKg==
X-Gm-Message-State: AFuF++loHa6IaElJ1UYxBXEBwDz75v2b+JkRf6P/K9LbiesjWj4d1L+H
	f0AwI8blKPCfIlSPqIxxiFeRt36x/Rk5McWih9h0TyGrlQjxaJ0nL23J2VoOTkDUG9dpnoW+b6y
	Fz1utEhjDV4vC8brDC67VIbfB9r5ON8l/xfocOuE/ps0ChpuPIVPX/+R6Mgo=
X-Gm-Gg: AR+sD123iiEL0KptGfDPACEN67SKNmaFSi+FeTUjfKJcxelOD6H1YVbsCMR7nPKe2jW
	xmGsCRTyQtKWR7PKOaVrX8NH6HkRwd3j7R+8osFny4/RRbSVSribThObTDt9srM7y3gctHlzIwr
	IgeHIhP1/ngPe97sJFnQZGtOCA8CGYcvuBkKSPF4XIlw2dqligIoeQwBITEM7DLSBY8V2VB24+f
	JKq2Ucuiyi2vBNP8KUt5zjO/rTagVsMKn2kkXjGCwk73Zss94IKlSjn9RVeuSTWe83c5+JHY7NT
	1gnVuHG6OGvMLhEfm02OW1oD5FoWygg8R+H7s0ESlIcA2eXfy+Whdwoha8yyDLsGkctKR/Dn/vc
	vTnunfMZr9NUC5w==
X-Received: by 2002:a05:622a:4cc3:b0:51c:1fa1:80da with SMTP id d75a77b69052e-52e42416041mr149362361cf.40.1787816308377;
        Thu, 27 Aug 2026 00:38:28 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc3:b0:51c:1fa1:80da with SMTP id d75a77b69052e-52e42416041mr149361731cf.40.1787816307708;
        Thu, 27 Aug 2026 00:38:27 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc134sm7009250f8f.20.2026.08.27.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:38:26 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:38:25 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v3] net: stmmac: drop gso_enabled_types and rely on
 netdev features
Message-ID: <ao_pcS4SirBPBzNk@lore-desk>
References: <20260824-stmmac-fix-tso6-features-v3-1-c73a7a4a0ec7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tXbvHYpj5TCCyFOR"
Content-Disposition: inline
In-Reply-To: <20260824-stmmac-fix-tso6-features-v3-1-c73a7a4a0ec7@oss.qualcomm.com>
X-Proofpoint-GUID: HY2qfSHv27rySUUhqkRCOR1Fcf5EO8R-
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8fe975 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=3-RhneuVAAAA:8 a=jIQo8A4GAAAA:8
 a=LMpWeGtwpFfhV3Ya4SMA:9 a=CjuIK1q_8ugA:10 a=Fh8iizVe-TJUZqW4ftEA:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=YTcpBFlVQWkNscrzJ_Dz:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-Proofpoint-ORIG-GUID: HY2qfSHv27rySUUhqkRCOR1Fcf5EO8R-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXxbRQR8L2p03/
 ZFdyHMApNqTtLcm0J0XHYDsN2CjoSicv8SAlGOAK9fXxBMEe6kelG9pLM8GfAOU7blqiuYbY8Dq
 hMJq+MW11dtCdG1XnoAJTFM9gTVw87YMsRYggsy6HJw/T9HMBa/vdzqT06fe5XlKztsQFakoaBe
 fQu2awp4Dr48xX64IBwrzMoz6CZnlSQqN/Zt8UVVkqkgDHKzSs6w/WHDA9CTe0sxuDfmda2Cwza
 RddBg7YePkYyZ5Qm4lH337wcxBKhFaD4k5sYJ1BrbdoLw/i2hysDGZhMY+bfjrVKxyHfEZjJ5+M
 4ULiTVcB4P455OSqInVsFJBn0ca0QWnlf30wl3YEfzMLXiliQ360MCxNlKYo9d2uA0g0a/HU3RD
 lFp4yIBNjHuKYOd5qESZ3gjMimQ/ZmljMoabmVExu3NCE+760eHw5aoYxIMaRCY6HZ3d+9RRwrh
 GHJo0eSg+Y6g/8O3whQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXwEDhuAavS1m7
 tbxDdMszye9jhmiWMFtKO3m77oalKhqIbvky9aKRgWfoyhyIvuDQEYA0TOngC9AEMR6WuNectaW
 g4SaB+2lVxSZYt8yuQuYTsYMAPOHF5k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061

--tXbvHYpj5TCCyFOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The gso_enabled_types field is used by stmmac_xmit() to decide whether a
> GSO skb should be passed to stmmac_tso_xmit(). It is updated in
> stmmac_set_features() based solely on NETIF_F_TSO, so disabling IPv4
> TSO while keeping IPv6 TSO (NETIF_F_TSO6) enabled zeroes the mask. As a
> result IPv6 GSO frames, which the networking stack still generates since
> NETIF_F_TSO6 is enabled, fall through to the non-TSO xmit path where
> they are not handled.
>=20
> The networking stack already manages the GSO logic: a GSO skb is only
> delivered to the driver when the matching offload feature (NETIF_F_TSO,
> NETIF_F_TSO6 or NETIF_F_GSO_UDP_L4) is enabled, otherwise the frame is
> segmented in software before reaching ndo_start_xmit().
> stmmac_features_check() also validates each GSO frame against the TSO
> hardware constraints and falls back to software GSO when they are not met.
>=20
> Drop the gso_enabled_types field and rely on skb_is_gso() in
> stmmac_xmit() instead, which correctly routes IPv6 GSO frames to the TSO
> path when NETIF_F_TSO is disabled. This also removes the data race
> between stmmac_set_gso_types(), called from the feature-set path, and
> the lockless read of gso_enabled_types in stmmac_xmit().
>=20
> Fixes: 2e4082e4b739 ("net: stmmac: simplify GSO/TSO test in stmmac_xmit()=
")

Commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824-stmmac-fix-tso=
6-features-v3-1-c73a7a4a0ec7%40oss.qualcomm.com

- Is 2e4082e4b739 really the commit that introduced this behaviour?
  - Commit 2e4082e4b739 is introducing the gso_enabled_types field. Using a
    cached value for gso capabilities introduces a race when the user modif=
ies
    them via ethtool.
    The other issues this patch is resolving are quite old:
    - commit 9edfa7dab8112a012b349b7937f5444fdc21e8f9
      Author: Niklas Cassel <niklas.cassel@axis.com>
      Date:   Mon Jun 19 18:36:44 2017 +0200
    - commit b776620651a1182976b51643bb2c5b08d535fb2e
      Author: Jose Abreu <Jose.Abreu@synopsys.com>
      Date:   Mon Nov 11 15:42:39 2019 +0100
    We can add these two more Fixes tag to the patch but I guess it will be
    hard to backport till that version.

Regards,
Lorenzo

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
> Changes in v3:
> - Drop gso_enabled_types field and rely on the network stack to manage
>   TSO/GSO logic.
> - Link to v2: https://lore.kernel.org/r/20260812-stmmac-fix-tso6-features=
-v2-1-72c3b06eb8d4@oss.qualcomm.com
>=20
> Changes in v2:
> - Fix possible race between stmmac_set_gso_types() and stmmac_xmit().
> - Fix fixes tag.
> - Link to v1: https://lore.kernel.org/r/20260808-stmmac-fix-tso6-features=
-v1-1-f82b17595052@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 --
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +----------------=
--
>  2 files changed, 1 insertion(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
> index 8ba8f03e1ce0..7582fca63741 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -265,8 +265,6 @@ struct stmmac_priv {
>  	u32 rx_coal_frames[MTL_MAX_RX_QUEUES];
> =20
>  	int hwts_tx_en;
> -	/* skb_shinfo(skb)->gso_type types that we handle */
> -	unsigned int gso_enabled_types;
>  	bool tx_path_in_lpi_mode;
>  	bool sph_active;
>  	bool sph_capable;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3..3a956c8b611b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4375,18 +4375,6 @@ static void stmmac_flush_tx_descriptors(struct stm=
mac_priv *priv, int queue)
>  	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
>  }
> =20
> -static void stmmac_set_gso_types(struct stmmac_priv *priv, bool tso)
> -{
> -	if (!tso) {
> -		priv->gso_enabled_types =3D 0;
> -	} else {
> -		/* Manage oversized TCP frames for GMAC4 device */
> -		priv->gso_enabled_types =3D SKB_GSO_TCPV4 | SKB_GSO_TCPV6;
> -		if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
> -			priv->gso_enabled_types |=3D SKB_GSO_UDP_L4;
> -	}
> -}
> -
>  static void stmmac_set_gso_features(struct net_device *ndev)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(ndev);
> @@ -4420,8 +4408,6 @@ static void stmmac_set_gso_features(struct net_devi=
ce *ndev)
>  	if (priv->plat->core_type =3D=3D DWMAC_CORE_GMAC4)
>  		ndev->hw_features |=3D NETIF_F_GSO_UDP_L4;
> =20
> -	stmmac_set_gso_types(priv, true);
> -
>  	dev_info(priv->device, "TSO feature enabled\n");
>  }
> =20
> @@ -4771,8 +4757,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>  	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
>  		stmmac_stop_sw_lpi(priv);
> =20
> -	if (skb_is_gso(skb) &&
> -	    skb_shinfo(skb)->gso_type & priv->gso_enabled_types)
> +	if (skb_is_gso(skb))
>  		return stmmac_tso_xmit(skb, dev);
> =20
>  	if (priv->est && priv->est->enable &&
> @@ -6206,8 +6191,6 @@ static int stmmac_set_features(struct net_device *n=
etdev,
>  			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
>  	}
> =20
> -	stmmac_set_gso_types(priv, features & NETIF_F_TSO);
> -
>  	if (features & NETIF_F_HW_VLAN_CTAG_RX)
>  		priv->hw->hw_vlan_en =3D true;
>  	else
>=20
> ---
> base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
> change-id: 20260808-stmmac-fix-tso6-features-7fdc5e9448e2
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--tXbvHYpj5TCCyFOR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCao/pcQAKCRA6cBh0uS2t
rJ+VAP9w6VkmkvlGVEsS5KD8+U1H7kNAEKqk8M8zXLPQB8fvWwEA573p7JTWZLHj
nOV6RZuzOf6yxkiM0CtRe1139XUhqg8=
=V9MW
-----END PGP SIGNATURE-----

--tXbvHYpj5TCCyFOR--
