Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EEB395ACD
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665855; cv=none; b=QErQhRZkhYflztC0pt5m2eqEB8hen1XG2v90qe7VqasGa0xLYc624eXyuYRe8N/VAqSyB1naWTmT6RJH1Ur7PlqIDpLTDsdThlLhYTVwRxX+EuMLnwy7w5TIX8uTYJ52SUYRd4HnarNiG4I2rQOWucq+XtSjmIcgzFCueCtGlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665855; c=relaxed/simple;
	bh=lLsSUBgEQVlXHsBeHvf4J4EvkWgzwmRzhMGQZkbTeeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGcauiYcA0BMqAjS7cfcIdfZASiXcl01Y7RYAvMp8fQ2/BO6q+y7JROea0XhSzoxLu6g6kMbcEr6n2pqgu/wwVF0vebjnzumPPaLbbz+udTmB1ZEceOfbrkNtddxdEOuw2a9lu3r+SLgTsyAwNKVZ/etjUHyhl6Cid4QLiBjY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DX6ZhtWi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bREHOwJV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DX6ZhtWi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bREHOwJV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47KYf3241633
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tIGmr+KvNWef7LSTquglUqpd
	DXRoxpli+2obPHQ+hnQ=; b=DX6ZhtWica0BFeSKF1fZplVB4QfjMX01tZgHePdy
	t3r/iZdKeFHh4IrRNDnIQMwftXwKLEQZjxikUDgxG2nlrj44mNp/neBgKluoSK4n
	YtXToHMDRDx9vNoFsNi221QOLAcLQymvX0tDG8hvfyR+Ul1SZ9dWYdjBCTQGWfSt
	OwSRzKUjfltDm94Qr/yWp1kUooYDOyGP2Pw/LPYC9DqpJhZjhLf8KVp+wfdHLsQH
	y+rYKkXGG4Selym37s8n+V9MrPU7KO0tjpvbhON5pfr+5nMe/x1zRFtDoMQchEPr
	HN8VqHm5rbQKj7pJF9xiqSPZ2vbUS6Rad9sCMkJp9dVI2g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144sn1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:10:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9143cb073b9so71276306d6.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790665852; x=1791270652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tIGmr+KvNWef7LSTquglUqpdDXRoxpli+2obPHQ+hnQ=;
        b=bREHOwJVt0VfmgHYxVJyQpaMWO0DPIT/92O72SDxEOzl/VInIoc11/MtV24nlq2Rxw
         azMC3hus2J9nysqS4Ng+10N+5z4TunfxAANncunR4gPUQ1fl/R9l37W/DlwbfYdLtuOg
         HQIgQKdaEGa+LU1ZowrcvAF0bIMHA5Xa/WMZYRa8DprG+iTfgJbHZc0ZMDaSiSjEyc0M
         P/H7j1FVShoAMjJYKBHNhit7mwVqt+0rs9Md4UksylvVQgFNQLeNwr83qm58bf8DjBQ7
         CC/c0tAE3OM2RuZgzoD1gEMpB3ZeggsmvHw+PNHOShgBFVdLljvnigyhd4qjzENOBOhe
         8W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665852; x=1791270652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIGmr+KvNWef7LSTquglUqpdDXRoxpli+2obPHQ+hnQ=;
        b=A/XgMdCjar2dznYMXpD2WOXqCWvq8s8Q/1YC+z4+EJJmPRf4zVCq22PDHMBxvFwGg7
         QxH/Z8U0Y2yeK1MIPC3XLozkxbC7e+YVOVhIheoCexjv7s4qAv66fKelcG7ex9OX3ULA
         YnO02na4Jb1TEokOLS5vQW0HQxwcgxaM7fqBGfHqGSl2JlMEY8jOA8i0oXUxl3vqDP3p
         K/sgtoPSQs7xctxzxSWCj7Hp4WWXmRBef1MH+bo1lf4B0/ek/EkiYhzZKjulu6VULGLI
         7GZw05Xrd14BGHjMz+601LpUzCod/tGoUxK+Dbemp8KotUfyRSaY7rk0x0VvyybEWCiR
         KGpA==
X-Forwarded-Encrypted: i=1; AKwUvBxRELyPUjQH7zcJDJjSGGfxJ1jgCCO8naGwLmfujYZP9JpXsaRgc5M420oyr0yv0tFkOwTy9o8=@vger.kernel.org
X-Gm-Message-State: AFuF++kou8YA9EakETfwyiTQmSG0aSSt8Ll39XipdV0OOVzUFiqjDmfs
	Lv5WrD4Z1p05yYJwpmwlc5Iq5Ijr2nVgBuVE7SZxL7d1he/NpyzPrAMOsSipsBtfNyp9sZHkQ9T
	m8D7u5V8irX0fQXQ70sjNX+bej7Uk1yLgByB8kXuIedoONRE/ybEU3bQSCaM=
X-Gm-Gg: AYBFou3EvOZ38Bfv8O1+XhDBnNEPLRX0WVfj899LMDt8sQaQQsKRKiBgYQdYubHHnUx
	91g8upuWRiXprYCm2HSjKCqUBMLKEMSZDmzUZ6IJqeA1QRkDWkAxhuSE4+qwtFj0Qr9Gxh+zJMy
	XUrpYH6IfeZ3lg4JIgjk17AeINyFaHiJ1E+xqnul4vXMIokvaB+JwDLOG/aYJ5uomOMKPwyb17T
	QRBPoUNST4qAX6LCejP2B8UGmZekMA8J2U3fm0emLYDYmwZmcKbMkvx9hgm9r+OVKz2+50Y5xD0
	a/stjpESH43+qS+5HYx7l4kXYYOn2vll2ghdWJs3Bn3T0WchvmG8YUhQEulVkJHw9bX5afS2mdp
	3MHlgUBXg6a28Ag==
X-Received: by 2002:a05:620a:2586:b0:93b:d7a0:d9e2 with SMTP id af79cd13be357-93c43d43f47mr2464692385a.60.1790665852301;
        Tue, 29 Sep 2026 00:10:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:93b:d7a0:d9e2 with SMTP id af79cd13be357-93c43d43f47mr2464687985a.60.1790665851689;
        Tue, 29 Sep 2026 00:10:51 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5056b1bsm1729250f8f.17.2026.09.29.00.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:10:50 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:10:49 +0200
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
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: Introduce a helper to check
 RSS support
Message-ID: <artkeRrj8cIntC5Q@lore-desk>
References: <20260928145043.1228968-1-maxime.chevallier@bootlin.com>
 <20260928145043.1228968-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4AbA0v2YJAqeW/6p"
Content-Disposition: inline
In-Reply-To: <20260928145043.1228968-2-maxime.chevallier@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfXyD56KpPDk9Ko
 tr1isIlKdXXfhJQo12UPkYwyA9+RDQO/7VZvb8B+n8OKEOAOSvc+aswvE1SCpL5LM2VhZyS2NLf
 C9Ae6tqO37I5rQH5EfAvJjF6hIug712NevKm9dtAVN6SVzCSjd+5XoA+Gf/MysrAqW1qk6QoU56
 S2aQuDpD4Ne24BTq2ff4dJPLObMNRf5cdvVCQf87tL/tjoKkOcQjTld9tAMMfZEIy6QJQHZvsCw
 TUz7FYQgcYECAAls3yL2MdQKLWfi+vnS/xTY55MBC+bwH2YuxqiA1/ZvSdhndprM182jB/i0zLl
 LBdqO34JMpRsYsKymRSSpExAbOu7n7uhIujjBpqiatN0FwWPlSk4K5Dtqu9AK+wE9WRmbKOCvcy
 sSfj4NIbfgbmqMoWfOTHaEcieLR8ZKuy68KlhXtXCmGgo2JLAI8dy4/Mzhwh35NXGJbby2Dbm7K
 xX0mVYWF7zOWxGFILNw==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abb647d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=dmaecK2fVo5vuBnwg-kA:9 a=CjuIK1q_8ugA:10
 a=9DQBYnkIQOUhDWc-jbMA:9 a=1HOtulTD9v-eNWfpl4qZ:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 1OixXWhWl7CuC0r_-wh5JTshgLot3xPq
X-Proofpoint-GUID: 1OixXWhWl7CuC0r_-wh5JTshgLot3xPq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX6/h5mqfnEba/
 TEgdl/zdrvAhLLNi7l8YkIlIob+9uXJycVjQLgoTQBy4W085K6cFCGXmoFR991t2J0PqCe2q7AR
 mOtBSxoKb+ceGbegyll/QsTuJ25Iiqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290028

--4AbA0v2YJAqeW/6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The RSS feature is only available in stmmac if the hardware reports it
> through the DMA caps and if the platform glue sets rss_en.
>=20
> Introduce a helper that checks both.
>=20
> For now, no platform sets rss_en, but there's interest in the topic so
> leave the door open instead of dropping the feature altogether.
>=20
> No functional changes intended.
>=20
> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 5 +++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/e=
thernet/stmicro/stmmac/stmmac.h
> index 7582fca63741..e2873d46e049 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -433,6 +433,11 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t o=
ld_base_time,
>  					   ktime_t current_time,
>  					   u64 cycle_time);
> =20
> +static inline bool stmmac_rss_is_supported(const struct stmmac_priv *pri=
v)
> +{
> +	return priv->dma_cap.rssen && priv->plat->rss_en;
> +}
> +
>  #if IS_ENABLED(CONFIG_STMMAC_SELFTESTS)
>  void stmmac_selftest_run(struct net_device *dev,
>  			 struct ethtool_test *etest, u64 *buf);
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4dee3542df3b..08feb18d62ba 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3538,7 +3538,7 @@ static void stmmac_mac_config_rx_queues_routing(str=
uct stmmac_priv *priv)
> =20
>  static void stmmac_mac_config_rss(struct stmmac_priv *priv)
>  {
> -	if (!priv->dma_cap.rssen || !priv->plat->rss_en) {
> +	if (!stmmac_rss_is_supported(priv)) {
>  		priv->rss.enable =3D false;
>  		return;
>  	}
> @@ -8037,7 +8037,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	for (i =3D 0; i < ARRAY_SIZE(priv->rss.table); i++)
>  		priv->rss.table[i] =3D ethtool_rxfh_indir_default(i, rxq);
> =20
> -	if (priv->dma_cap.rssen && priv->plat->rss_en)
> +	if (stmmac_rss_is_supported(priv))
>  		ndev->features |=3D NETIF_F_RXHASH;
> =20
>  	ndev->vlan_features |=3D ndev->features;
> --=20
> 2.55.0
>=20
>=20

--4AbA0v2YJAqeW/6p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCartkeQAKCRA6cBh0uS2t
rKlgAP9BrJf6LgP4y529UEKl/BwyjNkwWuBoOJca9HEjS70dawD/W/Zd/sqjZ93X
o19uP0B7YwHzyKwrFC+mqd5ths/LnQA=
=Wv2k
-----END PGP SIGNATURE-----

--4AbA0v2YJAqeW/6p--
