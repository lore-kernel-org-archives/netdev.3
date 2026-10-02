Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E941D12C
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945988; cv=none; b=Ru/iX1jdDkHoBHDFw2zQ3XvmMt+fpuz7c69K0N9+6MSFV6XQ5IBTua1Pbg7WdCYohEirvQykKchs7wPEo4Iaj23hO4n+HGrq6Llj3QkFIxV6PvG1KzZfLG66u0E38a3CWGkXHZz+EGe+W1qGYu3Gky26l/5lKemPvYkQaP20JFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945988; c=relaxed/simple;
	bh=1kyDt4JTb22Uoi2LnkpQhAiVJKN25v4eLOJunyfK0HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPQm9Lja0GlOMXM2hkUMDt8BZN6+E4m9lWJIBWGRSDFGBPhKyZgUf6cV0ryOxd+7IsZYek08h9xCvMOk3QpjbdGMv9ogWDXBcKuK4okxB9cmVYfJOusyU7gJuw4ITqT2ynmWhsUpERE7dilgzDAbTxeCz7SlazstfmAHCXGFoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JAziJZBi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fnsaTMSI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JAziJZBi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fnsaTMSI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929naJa960661
	for <netdev@vger.kernel.org>; Fri, 2 Oct 2026 12:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y7x/VlWWy2BsRTiBpnYJg7ky
	XQlMniK9j0tDbkxyDLY=; b=JAziJZBiG50qprKDeSWjkAGyyLrmlrLfC69no1ZS
	G/CoEvxY/4B1wFMoES0WmgXCV+tCAd6v4btzjfFHw90+2ypP/vG8Ss3rLOkORPdO
	2Qunr3eLSx363QKnCm4eIp5FUzyj/uu4ja2SNoxhYec8wwbjt63//YxLTVylAJLT
	myHl/Sm2uK2dY6Rby8WPaiOGxWc8VqAvwVTJuBUzb3q/5Vw0RgrX9NuLpCoc2uXD
	gNPL1ne5Ab4XwaIoZY9cK3Zl603ptLUGa1RD87MbR8Rqn/zApAkzmgEZvvndTqme
	vXax4apSTVU7FBTrE8F2uR2kU9+4wnTq+MBqAvCTcz8vhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdcme8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 12:59:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbacbb996so258131785a.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790945985; x=1791550785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y7x/VlWWy2BsRTiBpnYJg7kyXQlMniK9j0tDbkxyDLY=;
        b=fnsaTMSIHO7rzPtkr5Zd/MwvEvsm8anrGRtQDbxpEHFtQpShqqI3kUY8AmqvJ8ZXC9
         jRBvpyKgDXk6ymCGpxgxXxcV9rBkd+l13gSBT69WMW5bO1hF34o+8gnIAY8PIVa5iUi9
         JAvdCbu2bFvRJIAaFO3OugvWmGepHzTXHVClVH8cIw2ZPKJY9WtPwIKkHMiAgjNxaQUH
         liCMsISavy7o3d7gpfNTlD1WmtKDSvlWZAHqkINOUj2rdVz+9+poO7ttJLPFrkZVTUf/
         Kj3EzO+JUmmeD+mitAHg0NKpSrLdgxx3tt2IDiqiKcAT3S4bkvzNnO0LipDF+nL8fsNj
         m09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945985; x=1791550785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7x/VlWWy2BsRTiBpnYJg7kyXQlMniK9j0tDbkxyDLY=;
        b=sMEhvh2R16TW7NEFMEVFW6rLzOD/G0h/cbmJ8zmUicMxVhUFsOlyi8ZFF9peNP9Tpt
         NVgJRd6Rb+8iHs8gVm85SYddftJl327+YsTQ7I7MDlVWADc4L01nXP5D9ZvpvyKNmvyk
         H4IgkpDyreCrBR1VJP/sgOrPx+yF49vYaxwf6M+QHe3FH1I4Oist8N4TxqbUnIN+5f/n
         rZ4QTb9+aL2MKK8KHbcdYmoLquDyyvE63VeFWznH5Vzsfy6q6McXJ4h53AZC+y9qAW/m
         VCXcSv3JKX2/XqntVlDzz8ESOPRxW9OWjIfDYRtPG+01x+xeXBi5uL1Pwy0aGsUoycZt
         NOqg==
X-Forwarded-Encrypted: i=1; AKwUvByhjFE1iVdKrQ2u5w8nu4/sBvRh6EfEAXTpaHb/rCupnv3Viw/LgfQ17cupkU+eyJrS+3Pwmm4=@vger.kernel.org
X-Gm-Message-State: AFuF++kBEYp7I8l2o7y4saeAi5DoKpAKEhqmpTVmPCh3QbCjyxJSGFKS
	/uDI7X1W4uHaQj03oYUnxdb1G93xUVRO4fKc8PKDownOu+ZDvUMaD1pfuboh4zQJsJPZ0yw1kOe
	2VFQeovDJ+SZDHCRuXXizbhflcBA/rjUshlJFBOd+VjQtEeYCdBCHu3YWKMY=
X-Gm-Gg: AYBFou1GbThry9/nC7NRj8RIlfVBcIJO9hLqpYh4iA9QJDbAaGc3AC2gi1pa4HQYdct
	znppTAo9k8gx/Z7qcCvI/eE2/pYd9oE4n/41fDLT9bJdGR3eECJCe3nCnmdaPWThWR7LJ+bzhQF
	oCGqq7mnXgIwxjK1mxXdqeG7EgTZ/Ptu276AaxzNeSOe5pzHGchUM8dflX+PUzHnzINg+oQZWpK
	jZek/dzYBexJCiQ55blEVXxhQCJ6kjUvx8gq5fjpJY3bg0KcIV7qCdL7Fwc5mZ5ESqWPDGPUlfg
	HtsNBObSgN7hJMzwn9Ckf8D2SXWkxQHJ0IaxIDDCvDzgz7EjwDBsO2N8V1fAvI7PQz46u30DjFf
	F1u9TCfbOSI5YeQ==
X-Received: by 2002:a05:620a:271c:b0:939:6de6:9518 with SMTP id af79cd13be357-93cf1763839mr390082585a.47.1790945984831;
        Fri, 02 Oct 2026 05:59:44 -0700 (PDT)
X-Received: by 2002:a05:620a:271c:b0:939:6de6:9518 with SMTP id af79cd13be357-93cf1763839mr390075885a.47.1790945984155;
        Fri, 02 Oct 2026 05:59:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0304407d2sm49887535e9.0.2026.10.02.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:59:43 -0700 (PDT)
Date: Fri, 2 Oct 2026 14:59:42 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <ar-qvvGVATQ8-YxY@lore-desk>
References: <ar-iXZa3AIidNzsZ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O4EjaSrLBJhM+Fvw"
Content-Disposition: inline
In-Reply-To: <ar-iXZa3AIidNzsZ@sirena.org.uk>
X-Proofpoint-ORIG-GUID: FTGJ-ub8DnEzJxywFMLYNJ0lQFsH6_Rf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MSBTYWx0ZWRfX5zMqb1sJzN0z
 KU7PcgeBNnyxErhMXo5g6HGO2WKfYGuMHBzxaRmcxE41CeIVxLD+49zojxaWPqx3z35p+MnYp2x
 QuHV/kzkCvXosKJaa69nFgCIFvHO/wM=
X-Proofpoint-GUID: FTGJ-ub8DnEzJxywFMLYNJ0lQFsH6_Rf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MSBTYWx0ZWRfX4tM7eSZQg9Lb
 XS9Pft7gYc5nYOPUSKx3COnaIx8o2qaktq1+BSMCKU2msMNWC0qqzIPQIpz8yYgqx3BIa1QVnC4
 XuUJlo1QerPUW0EUQdPRtSgFNgY0OKUioqilphXxMs+2yPO8FAxxk/vABRBuFnegIneCpLDtJlL
 85mhNOgIdWQCQFZcr3Gr2ANV+fNWKlZMmUHoFx8EFGubOk2RoxkRnWew56eJVKamZKz7EtsQUu8
 g5t+MRshEB/hyH13/G3Y8yfN2ZLKKNZZJHpsoseQmtW1zLB4CP7R0D0tG0idYPNzJfuiQqpwhBS
 gzAF0fo8nvs4b8MEpH2Hg+mwJqdFi/kO9ijho+wZIu/fVDxEk9ZKoz5+xEgq+9Qv1nzOWr79tyW
 vxRjKQijCLKIlTDhT4BHq5DrKdabWEl38fjfLLTVkQoYtYWhD/f/dJH9b7SH+pHDNpG7Ma5TdLa
 rSpiibXfPKx/hrw7qQQ==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abfaac1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=C2QiusJkKhMZhfYo:21 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EEJO2GkaDteSM9pISacA:9 a=CjuIK1q_8ugA:10 a=nKQr2Z7tQUnx1KUvgakA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020051

--O4EjaSrLBJhM+Fvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> between commit:
>=20
>   232d49dd4b40a ("net: stmmac: propagate PTP addend and system time progr=
amming errors")
>=20
> from the net tree and commit:
>=20
>   8181678a92f01 ("net: stmmac: propagate PTP init failures in __stmmac_op=
en() and stmmac_resume()")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Hi Mark,

I double checked the diff and it seems correct to me. Thanks.

Regards,
Lorenzo

>=20
> diff --cc drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a2,0c381ae0d0ffa..0000000000000
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@@ -893,38 -862,38 +894,46 @@@ static int stmmac_hwtstamp_get(struct n
>    * Will be rerun after resuming from suspend, case in which the timesta=
mping
>    * flags updated by stmmac_hwtstamp_set() also need to be restored.
>    */
>  -static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
>  -				      u32 systime_flags)
>  +static int stmmac_init_tstamp_counter(struct stmmac_priv *priv)
>   {
>  +	u32 default_addend =3D priv->default_addend;
>   	struct timespec64 now;
>  +	int ret;
>  =20
> - 	if (!priv->plat->clk_ptp_rate) {
> - 		netdev_err(priv->dev, "Invalid PTP clock rate");
> - 		return -EINVAL;
> - 	}
>  -	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
>  -	priv->systime_flags =3D systime_flags;
> --
>  -	stmmac_update_subsecond_increment(priv);
>  +	ret =3D stmmac_update_subsecond_increment(priv, priv->systime_flags);
>  +	if (ret)
>  +		return ret;
>  =20
>   	/* initialize system time */
>   	ktime_get_real_ts64(&now);
>  =20
>   	/* lower 32 bits of tv_sec are safe until y2106 */
>  -	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
>  +	ret =3D stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
>  +				  now.tv_nsec);
>  +	if (ret)
>  +		goto error;
>  =20
>   	return 0;
>  +error:
>  +	/* Restore previous configuration */
>  +	stmmac_restore_subsecond_increment(priv, default_addend);
>  +
>  +	return ret;
>   }
>  =20
> + static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
> + {
> + 	if (priv->plat->ptp_clk_freq_config)
> + 		priv->plat->ptp_clk_freq_config(priv);
> +=20
> + 	if (!priv->plat->clk_ptp_rate) {
> + 		netdev_info(priv->dev, "PTP clock rate not configured\n");
> + 		return -EINVAL;
> + 	}
> +=20
> + 	return 0;
> + }
> +=20
>   /**
>    * stmmac_init_timestamping - initialise timestamping
>    * @priv: driver private structure
> @@@ -937,22 -912,8 +952,14 @@@ static int stmmac_init_timestamping(str
>   	bool xmac =3D dwmac_is_xmac(priv->plat->core_type);
>   	int ret;
>  =20
> - 	if (priv->plat->ptp_clk_freq_config)
> - 		priv->plat->ptp_clk_freq_config(priv);
> -=20
> - 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
> - 		netdev_info(priv->dev, "PTP not supported by HW\n");
> - 		return -EOPNOTSUPP;
> - 	}
> -=20
>  -	ret =3D stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
>  -					       PTP_TCR_TSCFUPDT);
>  +	/* Reset hw ts configuration */
>  +	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
>  +	priv->systime_flags =3D STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
>  +	priv->tsfupdt_coarse =3D false;
>  +	priv->hwts_tx_en =3D 0;
>  +	priv->hwts_rx_en =3D 0;
>  +
>  +	ret =3D stmmac_init_tstamp_counter(priv);
>   	if (ret) {
>   		netdev_warn(priv->dev, "PTP init failed\n");
>   		return ret;



--O4EjaSrLBJhM+Fvw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCar+qvgAKCRA6cBh0uS2t
rG+dAP96RtWcVw97+ysSLMsHdkn7pHCvHn20QqWpLICWQ/MJPAEAv5uAMJxDnb3x
dWajHJaVos9QdyaVvlOK466kOrSyawY=
=tita
-----END PGP SIGNATURE-----

--O4EjaSrLBJhM+Fvw--
