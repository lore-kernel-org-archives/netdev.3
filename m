Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6A23ABB9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947270; cv=none; b=fGMZRXZW/+sydWLFEHXHUyop/agaL7huuin+53mJ1XWIofBal+XVxB2ulMMiZgR9mR4tpXeCBE9Loh94G7Gd/6zVFGc9kTQmIsN2SNhO7Noll95R8FJjje9CyWKa1L9YxoX2HRADX+J5qvRkovQ250WZjWWhm4o4KOjY8ovaLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947270; c=relaxed/simple;
	bh=L22Y1zavgwZ95n+BoSwN7dp1LDiXfZ38mDgp81TC7nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6nTKpKgKOakz8xDTdKVhePsK5kGjecg7zKbPpXhSip5RLrt/hQ/+iz2fVXe7yAj0k51x/cnTQQE4KGURQVULE8VhodgPuJAu9A5CRXqcT2pfTDDtSNHL3z4rkLplc30Sh0lzAeuLgwDoNd7FLMsABlEj+juhq63sZcPtHwlJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9Ndbftj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RK0nFPIa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9Ndbftj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RK0nFPIa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DAECB2008402
	for <netdev@vger.kernel.org>; Fri, 2 Oct 2026 13:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e2pajeozWoQyPpjiKXh/ib63
	RkSnF91Fry4CrnLwmA8=; b=a9NdbftjUN29nrjV4nGPZObxiaKQknHrsVyv7gh+
	yskXr2t5Wjywqgbqmm5v5aYLBApndUb6i8pZ9XmeWN8C8PjTIO1/1woFl/mr/6oX
	C0Yc4SNzYHVjOF0JPi4YgYPjkZa5JPjopeJI67hnqxwPoCRp7wI7U9vpRgETikcH
	aLum6qOvMxjAVmbBon8mUZQ1BBrlxTEqB9XQtj+a2VUAzpnyE6n5oNLaOCrtHlJ+
	5kexKoqEQDG09jmJlhxNl9UYBogt5Q4sIqcoDpAWc59VEsatyjYwljB4FwHn0SyJ
	yrBFrgZ3EhI0pk+sJ8o2TX5GaIed4gQ/b7bMpoFP3KwqXA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj00kr3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:21:07 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bf71bbf197so1629948137.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790947267; x=1791552067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2pajeozWoQyPpjiKXh/ib63RkSnF91Fry4CrnLwmA8=;
        b=RK0nFPIaE+6lz1hQ8M3Z/KhUt+x7yJiWnKZljAJOTit8qnc052HPtO7Pxy+66wUlHE
         lU3waE89Gu1/ZncizrW2ymAGatPfEh7Gec+V8UOvn1Ij4S0x8r1zEmY5BfPm1y0CLj4Q
         bZojQtLt96Ghm725XBOHdid3g3w6mK1Z/sGrvHZpwENQmlt39Vxhm3Y9M1KjGzti7QI/
         jQH/gveK2TVboUKHw0XEAGJAFVlUvg7g02TGAkYYzFYwQUblm14HmiiA3TAXGOBXz5ij
         mO5OfWg4WwnWUNkx0cisvCgFRY3vQOTah3OvevOWIeWaEjqNgcHQuaVgTt6w6alDmsJl
         ogsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947267; x=1791552067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2pajeozWoQyPpjiKXh/ib63RkSnF91Fry4CrnLwmA8=;
        b=p+MLzqfoddOl8Q8wYP1ULlD3Dq4Ew4W/g3xmu6hhKbkm+g+7XNoxtXV3zONuAjT4el
         x9Mg+doNnXotvYmOeOnqX/tVp7kx00d+dBE/2Wd3w03QOmnT60HExHyqS/5LoVH00P4/
         wkeY73C7BSMK5Rw387SmIXCieqtTWC0QZGUNw6Ww/bov6cEcnHY/oGq+9SooI7luaYNp
         ndNzmGGrIUai2rgmnAQ1kqW52QCnjBBQWKE6J6JGS5Zewir9fABrE1mFb09uHt6RWl8v
         ZnlfFcUuG0mYbSnInhkx0VwGY+f9cI9lIwvEKpMns4Fmf42gpJdeScCyypJoH7pLdRnE
         zjZQ==
X-Gm-Message-State: AFq9FYJigdo6h5/zpOhqf4A6QKHFJb7R6/5hmgtQkQObzsnmNbs5g623
	gjQv3kVNnXZtxi57kfv1Cby4JtfOvpU8NDQc6k8/8M3rquLXFLNCmwf+SGNWxEG+lEn02w4lB6H
	ws2s+zQCS5B2dmCsK2268QO4thLclVpuSlhbO8PMNYMeajiZ9PGc+v/tcJkw=
X-Gm-Gg: AYBFou1UseoUhpRdKNKTLXEhOWiSBmVotbD15a0ufvIBCODvQTXisn8qLPe+8G6caJ8
	EZvZ8jVF+wgoifZzqf0K07shC2K6bPZ++dRD01XsRUm1U4V4BQ8BASXKkEPsTLXQ3s7vlufBvBk
	28qEzMPXLn5SK8PfP3mJqcE7cQ5AkslsPr6TtYl4Wx8a+ENhE2k2bmE9mzYMTgc0wlczqcmUJDf
	9NuPvFqoZ5DWdhvA1anDpLYnjkAXG9pDoNFrcpBFez8f3MzTiYnfO34Q91zwS7dVgZtYyqu//eQ
	s8AXUaobmS02qzrtuOFOcjzD9DAjei+UIZxptXgpGYC1WPD8BBgWGBMQ9ONQDM2yCiRNN0FwPBm
	hkiGAFre4T/5Y+g==
X-Received: by 2002:a05:6102:f10:b0:7c2:7a0:ae28 with SMTP id ada2fe7eead31-7c207a0b5bdmr76892137.30.1790947266639;
        Fri, 02 Oct 2026 06:21:06 -0700 (PDT)
X-Received: by 2002:a05:6102:f10:b0:7c2:7a0:ae28 with SMTP id ada2fe7eead31-7c207a0b5bdmr76874137.30.1790947265935;
        Fri, 02 Oct 2026 06:21:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff106d8sm53025675e9.3.2026.10.02.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:21:04 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:21:04 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
Message-ID: <ar-vwAy1PRMQMDuR@lore-desk>
References: <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B7t3o89WLFnL+/xl"
Content-Disposition: inline
In-Reply-To: <20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MyBTYWx0ZWRfX/ygTvk7sel5Z
 MW/uZq74zwq6+W9XtNevkPvYbdA8s6ntOB8RjkRSg+aDPtcoVEJXZjuj6t1Q7Hl+4VjztD1RSBf
 m04XBVfHV9lazn/iXNXTrb3ObuI5Xxc=
X-Proofpoint-GUID: 0t8_8IoXYgbBDawCAQOEGfcdb1jgkQCO
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6abfafc3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=-_Ip9hOUUtcLEFov2a0A:9 a=CjuIK1q_8ugA:10 a=PTu4yKYEXk-SadUjOcEA:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MyBTYWx0ZWRfXxhiC//zY0un0
 f68QImFEPXWI8Ncg5Igr07Oa7lUT29Wr+MI++y1J0dPnuNkQttf8OIXJS3pGXt3Jx2x2XccVKPP
 xaj8sslBc6v4t1fyb9+Cb92K0KErvot8WYRfFoTlTDrnfktgC6R1GS169Ng0fPjSALfHnPf61k7
 ndTOK+8TTFOls5ADfVH3Hu2CxGAPXHKVkaRXD+T+575qzfRP27eGWOkAdSQZqf08InKFUmf8B5S
 QAgkK8I667wMKcGgzt1MA0u2K3QUHUY0TTxvWEdiai0q3dCCWov86V2xhZfENDPvrCfobzW+zgC
 XejO+rBVywvOJzcm5L2Tun8/RBSxb5+H+VpGoFfxQ0K0LW8XYEMh3OUzEis5UzxSSXAaSC/QdeW
 +XPXYIemqbM/ejxybYMzg+d/2JL+KTP8Ap3yT41+Ps7ppvbng+VX8oeM7glGlRD73dyaH21Djbi
 sIqxHo5SwijTRZihaDQ==
X-Proofpoint-ORIG-GUID: 0t8_8IoXYgbBDawCAQOEGfcdb1jgkQCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020053

--B7t3o89WLFnL+/xl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> stmmac_dl_ts_coarse_set() runs under devl_lock only while
> stmmac_hwtstamp_set() runs under RTNL. They read/write
> systime_flags/tsfupdt_coarse and run stmmac_config_hw_tstamping().
>=20
> stmmac_dl_ts_coarse_set() snapshots priv->systime_flags, programs
> PTP_TCR, PTP_SSIR and PTP_TAR, and only then publishes tsfupdt_coarse
> and systime_flags. A concurrent stmmac_hwtstamp_set() can read the
> stale tsfupdt_coarse, build fine-mode flags, program PTP_TCR in fine
> mode and set hwts_rx_en.
>=20
> Take priv->lock in both stmmac_dl_ts_coarse_set() and
> stmmac_hwtstamp_set() so the timestamping configuration is updated
> under a single lock.
>=20
> Fixes: 4347287b8627 ("net: stmmac: propagate PTP addend and system time p=
rogramming errors")

I will repost with proper Fixes tag in v2.

Regards,
Lorenzo

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++++++++---=
------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a..a6793054a179 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -685,14 +685,7 @@ static int stmmac_hwtstamp_set(struct net_device *de=
v,
>  	u32 snap_type_sel =3D 0;
>  	u32 ts_master_en =3D 0;
>  	u32 ts_event_en =3D 0;
> -
> -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> -		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> -		priv->hwts_tx_en =3D 0;
> -		priv->hwts_rx_en =3D 0;
> -
> -		return -EOPNOTSUPP;
> -	}
> +	int ret =3D 0;
> =20
>  	if (!netif_running(dev)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> @@ -700,13 +693,23 @@ static int stmmac_hwtstamp_set(struct net_device *d=
ev,
>  		return -ENODEV;
>  	}
> =20
> -	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x=
%x\n",
> -		   __func__, config->flags, config->tx_type, config->rx_filter);
> -
>  	if (config->tx_type !=3D HWTSTAMP_TX_OFF &&
>  	    config->tx_type !=3D HWTSTAMP_TX_ON)
>  		return -ERANGE;
> =20
> +	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x=
%x\n",
> +		   __func__, config->flags, config->tx_type, config->rx_filter);
> +
> +	mutex_lock(&priv->lock);
> +
> +	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> +		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> +		priv->hwts_tx_en =3D 0;
> +		priv->hwts_rx_en =3D 0;
> +		ret =3D -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
>  	if (priv->adv_ts) {
>  		switch (config->rx_filter) {
>  		case HWTSTAMP_FILTER_NONE:
> @@ -829,7 +832,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  			break;
> =20
>  		default:
> -			return -ERANGE;
> +			ret =3D -ERANGE;
> +			goto unlock;
>  		}
>  	} else {
>  		switch (config->rx_filter) {
> @@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *de=
v,
>  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
> =20
>  	priv->tstamp_config =3D *config;
> +unlock:
> +	mutex_unlock(&priv->lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  /**
> @@ -7753,9 +7759,12 @@ static int stmmac_dl_ts_coarse_set(struct devlink =
*dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv =3D devlink_priv(dl);
>  	struct stmmac_priv *priv =3D dl_priv->stmmac_priv;
> -	u32 systime_flags =3D priv->systime_flags;
> +	u32 systime_flags;
>  	int ret;
> =20
> +	mutex_lock(&priv->lock);
> +
> +	systime_flags =3D priv->systime_flags;
>  	if (ctx->val.vbool)
>  		systime_flags &=3D ~PTP_TCR_TSCFUPDT;
>  	else
> @@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink=
 *dl, u32 id,
>  	if (ret) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "failed to reconfigure PTP adjustment");
> -		return ret;
> +		goto unlock;
>  	}
> =20
>  	priv->tsfupdt_coarse =3D ctx->val.vbool;
>  	priv->systime_flags =3D systime_flags;
> +unlock:
> +	mutex_unlock(&priv->lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,
>=20
> ---
> base-commit: 232d49dd4b40a666283de9e722899f088ed581b2
> change-id: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--B7t3o89WLFnL+/xl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar+vwAAKCRA6cBh0uS2t
rKpRAP9xiTlhpINh0zbVZ7FsOJaz1VGKpFCs9Z+N5bWuXKvLBwD/TT6049wDYnOf
jpvZk0Qguu9eTM/22fErhp9ZPUUozAU=
=EFtC
-----END PGP SIGNATURE-----

--B7t3o89WLFnL+/xl--
