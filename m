Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06A2ED154
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891628; cv=none; b=eNsnHwQSMhYN3mRP8Vnnn5jAeQtezGqewwYGmt5HSsIhcJk9sb8eyRQjMiJA0HgC+/Xgg2FMKgskzf4yt0BqcQVYWQ9T6UZwVf0lEDZr0BGjmC4/5yek0ynNv0SvRc7RM/kWzeJzlkP0Fct6lKV2xT0adKhQYh3/3R+7bUbX+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891628; c=relaxed/simple;
	bh=NxKn2zgdt91w1kXFCzpOjTEpxO7DBd/+TEc3QoOOwRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiT2x72Wj58zCc7VJrdeELD9n01P91KfCx44EpPxJKaLJBCkQoMC70c70SOijIKRMlCXn44QUa19LKkqm+HlxIM0AwewGrWWwWmYX8x4XL3SCdEQZSexsZiZu1ga/p8umD24xLm4bYpyLKFBpMThYPP1X0hyO38lhTUe7R82OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kty1hwW4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D6OAkr6+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kty1hwW4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D6OAkr6+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K55mZ71946608
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e5jUCEkf9yLnafQe149Ub/uG
	ZIIw9CugVMd5LhvprM4=; b=Kty1hwW416uA8gajdA7yNh0yY+XBuf1N7vMsN3UU
	zxxkWksof4NOoXgHcirirZU6rUOPJlhCeVnM5VolI9KftZO1xKVU+aimHRjYN7BQ
	eGkvzUlwuf2rnRAQuMwBwjJFXlhIHtCI+bwySg2c4ZkOhUjog6AQgKE8hriAR5z1
	uWLrjPkPBUo78q/fGFEY/yVx+TbYOO9LloQ8/Egwj0g+gkh2ndhR5TRsxSqWOi/B
	7Z9oNZ5AWCJ4k3KJp0P/wWh9clA1Uyz0Y9ixKmOdLjqiUrIdpXjl4W/VsBs8zGsb
	WDkNsVtuFtlQ6Mq32mKXR+euyskVuwluBixrn/UM981OXw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gshd62nvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:07:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93be1861d2dso321955685a.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789891623; x=1790496423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5jUCEkf9yLnafQe149Ub/uGZIIw9CugVMd5LhvprM4=;
        b=D6OAkr6+6g/R472yARxyArSMcc5perYQGwMmkq2ZUXzGhgC4618VY7VBD8NvF3pmPP
         bld+YnHMR9uANqaqlRngBd2PiK7iTXGZdLPbMzqsUAFz5HwDQExvHmlBcvTk6six4tnK
         Wj8GOGGkpiYZ1o1xNIfYL9yI9CJ+reELrI7OqmNuqmmptTSqh5jlFblpMiQbowr0zP6e
         xD5q/fvSxFZbHeaGNX1nOSmJIHNG+KJT+oqnfT6+sJ/q4JFBXfImkuRv5WWFEBF6lx0C
         iLlxCLZ4A4V4+/rcZlN7v99E07gdDfJ6+Om7uI+uhXIdzQrFRhO4+i8iC+1ogzJjG+1P
         yABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789891623; x=1790496423;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5jUCEkf9yLnafQe149Ub/uGZIIw9CugVMd5LhvprM4=;
        b=SpYo3wYK1MxoYHoYLW2hta1gzY4aVPLNwLX+6OZB/Sy6xCuy6efRn1JbPFBROGqrZn
         c+vfYJdZgTjK08cpQ8e9gDuhANFWUZi/t/bq36Y8B3TviRCm+RT71uAxH2M4uU6mC9ew
         1aUso81j6++upBSwrmsDkOM04zmlygo/2dMYBzIW8DJm2Nsgx6FdQFTYmTYuD543572D
         7YgrABuBcExZBTPNAiHJhjHApGC4b0lGZN2cTDlw3viGtARu6hq66jhYxhCZJ6icvQOt
         PccrBhS5JGQBSzekwzqta5IHNSvBqb/oDTYD6uEcP7evKA2kf2X15KHPme74EOGCtFkV
         U3Tg==
X-Forwarded-Encrypted: i=1; AKwUvBwYWokKIcGZ7SRD0WkLNmw2NU6Z/GLcVUDWpsdQJxflgANR0GDdBF4mIeDofTyiWrFJc1yfJOU=@vger.kernel.org
X-Gm-Message-State: AFuF++lVYlJCGaRNzjj0C19qbkGYufgMd4OGzED5ccEp8BuBcOWwDDsy
	vd/BXu676D4kFd369vv6XoVH8wgxXFjFNTfxV30uOU/Mm0WZXHLXXh7ryFKs6t+3lBii4Dyk4KC
	tbdaAAz9hdWNTR6WMALrgC6wO7fW0B1EbhJJJyhD5idAhOoi3FBG28WDv2Qo=
X-Gm-Gg: AYBFou2TjLQEpTwRNcHBj3NNt2t3dxNubysokTEDjK88C4zOhQpP7DhZrdIlG1fgt0V
	L4J+O2c+/sDByma6lbaLlKMmhW/11q/9+ZMc9/OclYomG8z1K3nr9kdqKlkJnbifs2b4P4w2G5i
	nJyFq1Ed7isa/3ccKVhdoLS+fuKbV3jKPFOx0rM2y3wJXvgLYWob1rigSeNl2nfoz9Mh6SucCoW
	xUev9N4eYXY92f0+0ATDDupXWFAlgPM49xlxia+ERptcMsfCoMT09DqPx3U79Vbdhy5BF6AL28R
	VPFvUyEwo/p0Z/jOgFd+g7lQEhIVhXpIEO7OvhC4rIbY7syLbz8UqyXXlmPTAAHhRjY2MriGJh7
	yhoUIf0gz4ArEdA==
X-Received: by 2002:a05:620a:2311:10b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93bfb3c2d27mr213524385a.66.1789891622743;
        Sun, 20 Sep 2026 01:07:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2311:10b0:93b:fb3c:2d09 with SMTP id af79cd13be357-93bfb3c2d27mr213522885a.66.1789891622276;
        Sun, 20 Sep 2026 01:07:02 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc55cd8a8sm196415225e9.0.2026.09.20.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 01:07:01 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:07:00 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: request the MDIO reset GPIO only once
Message-ID: <aq-UJEFIq2aHfEee@lore-desk>
References: <20260920054703.1897755-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yyGVeVacvTbMRAa"
Content-Disposition: inline
In-Reply-To: <20260920054703.1897755-1-xiaolinkui@126.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDExNSBTYWx0ZWRfX9yQMUtd02F4D
 weQGUmOe+4DfAYWPa8ssVActQiMFl1jRV8M0WzjnsiOhK0s2BIat+1lsdt4ux36eDf/ArgcuQGt
 Ts9/HXgYkHyNRAttRmFp9N/6ut1taYN9SxjjnA89o/4/jo8rbmVEoNEZbI97h/tohKpB6alLuv2
 phlbOMkspMWiwQvygaOYqVSkOe1pMAHgeMA8R9a+y2lL9XXGjZrwidObJmpjx/DmWkCg4JS17MM
 W6Qb/wy1y2otNo3dijhR2pwhrU609uAZj0HBad+/EmnsjYwZdsE2eR0HET38itlTqCMt/D2Xh3x
 7pi1WrtnYD+SPI/nlf4ByB9dzUj7QtMUBz+nIF7j3uSaASzVuKkg15cdH1rGIFmuikdJaTn6m7b
 eXip0FT7tCDAjfmummqFGt9dSsK9uW+RYtHdc1LhGNYPNPB71XnXobkFiMAP15vejwIszNStfkU
 8EbSzYEE0wbDHTxbqzQ==
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aaf9427 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=ROrK7FBXa46LgAKx6Y4A:9 a=CjuIK1q_8ugA:10 a=3qf_Ru5Olzpm8D4UWuwA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: BEnYUQmVRt2l-O2-zsn1rwntW7w7tLP4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDExNSBTYWx0ZWRfX4aXCVr4SyHaR
 yV90gv0nUxO0PsIflAi60whyqM1eTle6ctv5wlVek1MyQLwB5kJDXgJrWaLbwOqH2YweH8xNNQP
 BS+IQIrKjwgHtYcn8FA3p2v9FWdDlAc=
X-Proofpoint-GUID: BEnYUQmVRt2l-O2-zsn1rwntW7w7tLP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200115

--5yyGVeVacvTbMRAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
> A GPIO line can only be requested once, so from the second call on
> gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
> turns -ENOENT into NULL, hence the error is passed straight back and
> stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
> running the STE101P MDC workaround.
>=20
> The first call, made by of_mdiobus_register(), succeeds, so the failure
> is only visible later on: every resume that does not use WoL goes
> through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
> the return value, so the PHY silently stays un-reset.
>=20
> The descriptor used to be requested exactly once: stmmac_mdio_reset()
> resolved "snps,reset-gpio" itself and cached the GPIO number in
> stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
> PHY reset during resume") relies on that cache to reuse the line on
> every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
> stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
> caches nothing, so the request is repeated on every call and fails from
> the second one on.
>=20
> Request the GPIO in stmmac_mdio_register(), at probe time, and keep the
> descriptor in struct stmmac_priv. This is where devm-gpiod is meant to be
> used: the line is acquired with the device and released with it, and any
> failure to acquire it is reported during probe instead of being ignored
> by stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line.
>=20
> The request is still gated on mdio_bus_data->needs_reset, which is the
> condition that installs the reset callback, and on the device using DT,
> as the reset itself is.
>=20
> Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_re=
set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v2:
> - Do not request the GPIO from stmmac_mdio_reset(); request it once in
>   stmmac_mdio_register() at probe time instead. (Maxime Chevallier)
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 19 ++++++++++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
> index 7582fca63741..986fb43db45f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -25,6 +25,7 @@
>  #include <net/xdp.h>
>  #include <uapi/linux/bpf.h>
> =20
> +struct gpio_desc;
>  struct stmmac_pcs;
> =20
>  struct stmmac_resources {
> @@ -287,6 +288,7 @@ struct stmmac_priv {
> =20
>  	unsigned int pause_time;
>  	struct mii_bus *mii;
> +	struct gpio_desc *mdio_reset_gpio;
> =20
>  	struct stmmac_pcs *integrated_pcs;
> =20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb..346f93f86abe 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -386,15 +386,8 @@ int stmmac_mdio_reset(struct mii_bus *bus)
> =20
>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
>  		u32 delays[3] =3D { 0, 0, 0 };
> =20
> -		reset_gpio =3D devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> -
>  		device_property_read_u32_array(priv->device,
>  					       "snps,reset-delays-us",
>  					       delays, ARRAY_SIZE(delays));

nit: what about moving even these properties to stmmac_mdio_register()? It
seems a bit odd to have half of the parsing in stmmac_mdio_register() and
half in stmmac_mdio_reset(). What do you think?

Regards,
Lorenzo

> @@ -402,11 +395,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  		if (delays[0])
>  			msleep(DIV_ROUND_UP(delays[0], 1000));
> =20
> -		gpiod_set_value_cansleep(reset_gpio, 1);
> +		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 1);
>  		if (delays[1])
>  			msleep(DIV_ROUND_UP(delays[1], 1000));
> =20
> -		gpiod_set_value_cansleep(reset_gpio, 0);
> +		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 0);
>  		if (delays[2])
>  			msleep(DIV_ROUND_UP(delays[2], 1000));
>  	}
> @@ -608,6 +601,14 @@ int stmmac_mdio_register(struct net_device *ndev)
>  	if (!mdio_bus_data)
>  		return 0;
> =20
> +	if (mdio_bus_data->needs_reset && dev_of_node(priv->device)) {
> +		priv->mdio_reset_gpio =3D
> +			devm_gpiod_get_optional(priv->device, "snps,reset",
> +						GPIOD_OUT_LOW);
> +		if (IS_ERR(priv->mdio_reset_gpio))
> +			return PTR_ERR(priv->mdio_reset_gpio);
> +	}
> +
>  	stmmac_mdio_bus_config(priv);
> =20
>  	new_bus =3D mdiobus_alloc();
> --=20
> 2.25.1
>=20
>=20

--5yyGVeVacvTbMRAa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaq+UJAAKCRA6cBh0uS2t
rG2zAP9gsrCleSZRt7ExqFD7e5Mo2sDtzXBvEdUjogUqIwHIFgEA/iL8xVFwvzmN
CrJXix3dYybHYLP1NiQCPZif+Yis2A4=
=/udT
-----END PGP SIGNATURE-----

--5yyGVeVacvTbMRAa--
