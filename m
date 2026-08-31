Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D83DD52B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170115; cv=none; b=pTsJEsCiqvpFN5yHFgwKUGHf9MTnJ+hFjHWOLvs98NKNB87NyJ6lmK5RipApSSRsAyInKqNyybMGUtlT+UsbwYEA8g+3Nf9zZMSkBx/1h4Ze/vgTeL4uG63FgfvwGKz6qiuXWQ9pNExHjNFo5hGeSANI8uc961HUutDaj2Bg/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170115; c=relaxed/simple;
	bh=hJDq03LjHzJGYpGFeDmnp2Jf3MdiUbdoJpYyvxOKjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTpxVxJaF3CJYZZTCqvCr8Kmhbbm7Lj5FMGPMBMywxZNTUzv8TazHtwH16Gmy8HAVzHW5JfK1zjT/KxbiUzYqCqeAkiEWZPWBfzMpfvD78EAWeM/ilMCA+/6xMvhYXgSYmiof8nxPRglXEZWkjyEs6ldiBKUh3ZhxezSvNLKX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laUUXLAO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEojGls3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laUUXLAO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEojGls3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xHUW4081405
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oRdUPsnNzxRUVLTcFatiqKu+
	uDqmGhQcvxZJaUARUuw=; b=laUUXLAO1ca9F8h7lr/IoXmXLZzsW4/mzgyVcniX
	Z5YmSPDaZ/kP7I6dL8jUPJ7QaHW55GvEPrj/5YRtULgtC4Sd47VmqqJO7+Tmu6M8
	9Yz3umcuKNPMAcEhmqWJEt5D0L6Sbt4qKm7EQM2XDotFD0DMCXYVg9u+piD/dUt/
	sjDicwC4g6J6maQMFgKBxFv/poL4yFwwoHQ+pEKjjhWTtaCBbdnwC8loA0G2Cjmx
	uXjMqVGEx2oz7V7q646QWY4d4YALNfN6d01IFUNjEnK58J7et1aXqmE9A6jpWba7
	tp0z1fKS5fvrIvgVOxeTw/QDiTtX/15R3wyr65u/rR70zA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h22su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:55:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9382f9430deso515471285a.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788170112; x=1788774912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRdUPsnNzxRUVLTcFatiqKu+uDqmGhQcvxZJaUARUuw=;
        b=IEojGls3R9rksJy86PuC1S18mPereVJz8oNSjYSLX/RGfWuubVg4YONMRxM/tiM0A/
         gHien24LHInkQOjOYRI/uAPVBwYXajqJ4BNdyffueBIpguv/hwufSRIK7HNxfUnW3QpR
         Il2bBCG3nB83wLiYUzzI9ZRS4eSVYQbiy02wWmoqrDuRqC4FgAGIMSWzSVnNuOIlNZKy
         I7jQfTGJmEdtHtvNP9zVs7SeJ5aQZ+M/W2xPcrKh+RVoCtUG19FKVBwXg7C99hh4umn6
         nWcFK3DBjvui6UCWi/m09hiOKDuki6o0v8lvb51KnHZ2J70bZv0inGkWA59U6F5euEeF
         jMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170112; x=1788774912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRdUPsnNzxRUVLTcFatiqKu+uDqmGhQcvxZJaUARUuw=;
        b=ITM+QNvsr8NZMsVSd1x6EKDYz5lxTZy29X458EdLJNZbe90psXu5aJkgb1gXvMaUpX
         k4lwqXOMhAufZGTCKqCk92i6KeARH2e6t91QqfiDny13mZKYXVNGse1NUG7x68LfGoAU
         D9Yj1GNkqZo3+in1jb5tC0M5NiA+pQXYxT2RwDSjArALJjjh9wL3jWTkqd49mWpKMrh6
         /XIyZBK/cc5r4i2+2Hc9C39eeV7vAGUVi/jlzz/T3MBjEvZuf4+tQ6iwwFq4WhY/IZcr
         wJbBQd86Th6oRj/bCz0zovlWElnBlDG889+rv3+bi+B53h0ZdQtdFmYFB5a2gUwDPOVw
         GeQQ==
X-Gm-Message-State: AFuF++k4Ccmimlgf+ncUja8/XvYBUOlnD1puHFCKsiw8dhsXabnF4gVU
	w84bmPNbE9GLf/2+DqzyG8+Tsr+5lY3+UHjsUN6LoTsiLW3n6aGdD8QbVZ2+/AhhT/W0H0QlnMg
	jG4Tq0zJYoQiKS1wB2VhJ88qLTzygNSNFZyAj/7qIV53Ma4Kr5/68Cn1ph3Ip/sBry/I=
X-Gm-Gg: AR+sD10biXkkMP8do1PTzdI2pDSNTiglIO0HAY/V3J/Gf7fHpzCFg/IADFwbqc4Szkh
	fge5CcxCQRt/h0pDAXlE7gsL40uHA+HE8fzEmIFrXu8Ju1V0aBqR6UDqD8YV3RVUD8YxSMy4STZ
	PBHcAeA2OvswVzC0CaUR8eOM/inNpPt38gCsdnPicxToGnTpTQbFAE3nQsxp5AHmIep7M7u7mIa
	YVDj9h+F+AKns0w2HZFjwcgo6Ukd68SCXmML6myZHGGzx6urAwPmmVPVyfayOxrJqsrHSMawMxc
	eSYedp7o+Az2YcOR00EgsJYwczCWvIsmOiPho65zjYmyEaFZDcEMLoMXA2eI3rLolnKj1H8dF1h
	rR8Rbx5Z9D3iLPw==
X-Received: by 2002:a05:620a:448a:b0:936:cae5:8b38 with SMTP id af79cd13be357-939137fb875mr2493932785a.10.1788170112174;
        Mon, 31 Aug 2026 02:55:12 -0700 (PDT)
X-Received: by 2002:a05:620a:448a:b0:936:cae5:8b38 with SMTP id af79cd13be357-939137fb875mr2493929285a.10.1788170111595;
        Mon, 31 Aug 2026 02:55:11 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8148fbdsm34913945e9.3.2026.08.31.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:55:10 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:55:09 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: hold runtime PM reference in setup_tc
Message-ID: <apVPfWikwo5pqh4f@lore-desk>
References: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xKx+OafTtXKdsrQn"
Content-Disposition: inline
In-Reply-To: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a954f81 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LK5SnTVSdOS2cW5lnr8A:9 a=CjuIK1q_8ugA:10
 a=psPUyEKxvqZN-xNySdUA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NSBTYWx0ZWRfX+oJFyWgmTmkL
 kCk2P9TCP8LX0h1qygN1xqYL0gkCd1u5xQldFALNWsHN31fjy2U1BvvykD82ooP4onEVY2GKvDK
 sTNXIqv4jHfXFUU2IjrlsnEJbu3mdAapuHz/kCKogCd+9PpKCs3F6vcdoxuAv5gXcJZibDeTBkA
 hDKTD6IzYuS/zCQZQB+a7URU7EowWnEUTVEpi3Lhn+RIrQyuEFb8DEt+RWJKbkkt0tp7qHrbiog
 wsF/X54IewuOjVbUF9O8GMuXaxiEvwoIXJetcbtJPeRMUXrSr6LX/jz/PPm0eTgaaxyZczjizfs
 PpoXiol0ugPXwy99DkRbscRyDtIaSVGNnndyvu9qW3swJjxDNamJ5+MSmSF6DIgKMITDaZxRoR2
 8PZA9wexGZjTleyHeHg+Umwz9N4yBHZ06qI6/jCCvuxk7zUn9h005yqNfApEYjNzNuuXq/hYkST
 suGDtmj6cM5HDt1tM3w==
X-Proofpoint-ORIG-GUID: cIMEFKtBLZS_LFcsqFng6ESyeVnhRXft
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NSBTYWx0ZWRfXybI2DyW1LwAE
 HDwj6T/4njNmhQUkbLSTjT7tPHPB4tNV8xc/6C4agYvNpRQJhI4GzVF2oiw3BR/w7CStZdlnXVS
 LCiDZaQAKTRv69R3BjBCF+L+qaigGlg=
X-Proofpoint-GUID: cIMEFKtBLZS_LFcsqFng6ESyeVnhRXft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310085

--xKx+OafTtXKdsrQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The qdisc offload callbacks invoked by stmmac_setup_tc() program
> MTL/MAC registers, but they can be reached while the interface is down,
> when stmmac_release() has dropped the runtime PM usage counter and the
> device may be suspended with its clocks gated. Accessing the registers
> in that state can trigger a bus error.
>=20
> Hold a runtime PM reference while configuring the register-touching
> qdisc offloads (mqprio, cbs and taprio) so the device is active, and its
> clocks enabled, whenever the MTL/MAC registers are programmed.
>=20
> The TC block callback stmmac_setup_tc_block_cb() programs the MTL/MAC
> registers as well, but it runs asynchronously from stmmac_setup_tc(),
> outside the runtime PM reference held there. Hold a runtime PM reference
> for the whole stmmac_setup_tc_block_cb() call as well, covering the
> cls_u32/cls_flower setup and the queue enable/disable accesses.
>=20
> No reference is held for the TC_SETUP_BLOCK bookkeeping itself, the
> TC_QUERY_CAPS query or the tc-etf path, since none of them touch the
> registers synchronously. In particular the block bind/unbind must reach
> flow_block_cb_setup_simple() even when the device is suspended, so the
> driver never leaves a stale flow_block_cb on its block list.
>=20
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Fixes: 4dbbe8dde848 ("net: stmmac: Add support for U32 TC filter using Fl=
exible RX Parser")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8=
a5948f41%40oss.qualcomm.com

> ---
> Changes in v2:
> - Return -EOPNOTSUPP in stmmac_setup_tc_block_cb() for unsupported TC
>   blocks.
> - Link to v1: https://lore.kernel.org/r/20260824-stmmac-setup-tc-enable-p=
m-v1-1-45172d241a4b@oss.qualcomm.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 +++++++++++++++++=
+++---
>  1 file changed, 31 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index efa35cfecc4f..90753d5af6d6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6393,9 +6393,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_=
type type, void *type_data,
>  				    void *cb_priv)
>  {
>  	struct stmmac_priv *priv =3D cb_priv;
> -	int ret =3D -EOPNOTSUPP;
> +	int ret;
> =20
>  	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D pm_runtime_resume_and_get(priv->device);
> +	if (ret < 0)
>  		return ret;
> =20
>  	__stmmac_disable_all_queues(priv);
> @@ -6408,10 +6412,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup=
_type type, void *type_data,
>  		ret =3D stmmac_tc_setup_cls(priv, priv, type_data);
>  		break;
>  	default:
> +		ret =3D -EOPNOTSUPP;
>  		break;
>  	}
> =20
>  	stmmac_enable_all_queues(priv);
> +	pm_runtime_put(priv->device);
> +
>  	return ret;
>  }
> =20
> @@ -6421,26 +6428,46 @@ static int stmmac_setup_tc(struct net_device *nde=
v, enum tc_setup_type type,
>  			   void *type_data)
>  {
>  	struct stmmac_priv *priv =3D netdev_priv(ndev);
> +	int ret;
> =20
>  	switch (type) {
>  	case TC_QUERY_CAPS:
>  		return stmmac_tc_query_caps(priv, priv, type_data);
>  	case TC_SETUP_QDISC_MQPRIO:
> -		return stmmac_tc_setup_mqprio(priv, priv, type_data);
> +		ret =3D pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D stmmac_tc_setup_mqprio(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_BLOCK:
>  		return flow_block_cb_setup_simple(type_data,
>  						  &stmmac_block_cb_list,
>  						  stmmac_setup_tc_block_cb,
>  						  priv, priv, true);
>  	case TC_SETUP_QDISC_CBS:
> -		return stmmac_tc_setup_cbs(priv, priv, type_data);
> +		ret =3D pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D stmmac_tc_setup_cbs(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_QDISC_TAPRIO:
> -		return stmmac_tc_setup_taprio(priv, priv, type_data);
> +		ret =3D pm_runtime_resume_and_get(priv->device);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D stmmac_tc_setup_taprio(priv, priv, type_data);
> +		break;
>  	case TC_SETUP_QDISC_ETF:
>  		return stmmac_tc_setup_etf(priv, priv, type_data);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> +
> +	pm_runtime_put(priv->device);
> +

- Does configuring TC offloads while the interface is down result in silent
  data loss when the interface is later brought up?
  By wrapping these accesses in pm_runtime_resume_and_get(), the driver now
  successfully programs the MAC/MTL registers while offline. However, when
  the interface is brought up, stmmac_open() calls stmmac_hw_setup(), which
  performs a hardware reset via stmmac_reset().
  This hardware reset wipes all MAC and MTL registers back to default value=
s.
  Since the driver lacks a mechanism to restore the TAPRIO, MQPRIO, or RXP
  configurations during stmmac_open() or system resume, the TC offloads are
  silently wiped from the hardware, leaving the software TC state completely
  diverged from the hardware state.
  - This issues have not been introduced by this patch and they should be
    addressed with a dedicated patches. Moreover, EST issue has been already
    addressed in this patch:
    https://lore.kernel.org/netdev/20260829-stmmac-est-reapply-after-open-v=
2-1-5e5ccb185e92@oss.qualcomm.com/

Regards,
Lorenzo

> +	return ret;
>  }
> =20
>  static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *s=
kb,
>=20
> ---
> base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
> change-id: 20260824-stmmac-setup-tc-enable-pm-149aa563d797
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20

--xKx+OafTtXKdsrQn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapVPfQAKCRA6cBh0uS2t
rC+FAQD4I8PucCebxzhGTP3k59QxgwKNXiDiNOUrxC6FKLzNcQD/SspChm3h57Gj
8kg/zNBbgQQ3NTji4kmloA2qeRf5YQY=
=TAX9
-----END PGP SIGNATURE-----

--xKx+OafTtXKdsrQn--
