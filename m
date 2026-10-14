Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D5388E72
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968686; cv=none; b=EyqSsf3ypvzGtTwV702XYuPj7121/QsAON1Xn6oi4EFEMs+FkEddV9v8lLdqolmpQHT9UD+Xr9DN5SkZnwQKV5MoaH3qA+2xeauiKxWIsFp5MeOcWJRcTpKb/37qecV/uO/nJ4p5wUKU1n1kYj5ZfizpXvcK8TtH6dsZvWfswF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968686; c=relaxed/simple;
	bh=ZQ9BS6O97vKgCe65Gq8Hqc50dd2Ub9IfK+WMm4pfJC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1PUk1upWED2LUNh5gT6cVf87UmxugMYn7wBJUjdUGOm89tatNeMgzA8YgY+iQnPB7BsJvMkwlQHynjW/MqLKMBYfyG+qFCqLkMwncYUEgcPqwx7Wb+F+8J9SURsAd7RHBHvFZ9GWHIyqT/FdS/ZrMEx6iFryIdFQNrVwheEgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gzUkZN65; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QXrNw9AG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gzUkZN65";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QXrNw9AG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E6jSBO2088499
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Tw9zAIFrrfXrOTzkc0WmYnxI
	oH9x6CiP1Stz5Zlwuwc=; b=gzUkZN653bXJbID41oRN9YnCGU2OF4MwTXJqUHGo
	5QkQV9MPj59rRW8ORczlVg9V+lNZaLa/sOyF6d9aENFh7tgeo+sbfHsQR4sB2M62
	fXjHJa29CSgK4DRMPh/kqHGjVCox3kYqvIxuQC4MEIp87jTtvpfca6YM1asTXssq
	fgW5rnHrDMJQ4OVuJm7wekawG+gEHLYtck0mTOBk8H9XXNwE52nzRK6XAMZbokcr
	NBEEgHuNrPR8Whg3iINq6Vn3tcxouVmHuE66Evz2DH3prF/wKAw1n9nJxGcfN81V
	vuQxZDPWHGs6q5Jj0/1f7rLibQrBWFyBy17SPEH3XN5Xfw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49j0rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:04:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso182087485a.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791968683; x=1792573483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tw9zAIFrrfXrOTzkc0WmYnxIoH9x6CiP1Stz5Zlwuwc=;
        b=QXrNw9AGBQ6cIEHEvH0UWLKOvixx/wmOFz39mnzWuKj+zWVIvLSAVd7qnTLXAbZHFV
         qdSdAqEVEnWucHd62ioP3lJbny6urzp/bmnl4HcONf+atGmzNyzQuZMYhiUrHqizG9ie
         BqAzBfZPE9sfp8yug/bNdouSZAlz4VobS1VWstz8GQn3fBp4KZeOhJk8SvtW0p/S2E4f
         uBT3yBI7I4loTC2qZ9+XeSllcvJ9l7/Bv5yjkOnQlExV4JsYPpA2ro+K6jnACpEH8hRI
         eqTildE5EymIeFBLJpDrveMYS9pEdoTfsbwPk38oAJfkrGv0kIxc005YCqLC4IGb0w1B
         /PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791968683; x=1792573483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tw9zAIFrrfXrOTzkc0WmYnxIoH9x6CiP1Stz5Zlwuwc=;
        b=gaxuYFT5zouO+77QC9WFwurDEcctu1Jpw48T8bF34PH4ydUj4Ix9KY8LsXgE9HZQsv
         hqY3ifJOzC7vL6LCufEMnefS7FDdyicgv7kN0DEUQsQN5HuiOV936waMF8hNiuFqLuHM
         1yde/iQQaZ2YTaFA+uAgEjmRKVA8DRXd8ZLJh7E5iexkVYtavp/WOvqF0HcpYU2XiWgY
         FjXMNKfJt24gwRDJmRcfHgR9tP8EpA/sflRYcoh2dGjkz3LmUi34xuyvI9nnfpSz/GpO
         PDsHGU0UwKP0dqOD2ofeZmKyabHSK4loOaNJwss+RLo8quXQV2UuoYagddxBHmGZs8wz
         BCHA==
X-Forwarded-Encrypted: i=1; AKwUvBxNuC0hR0xMohX6gffIhTEXG5mJ8lyW40u/sbnt3FAd2/RVeDxPVux3gVN+olqneY859Dh3Ptg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjTTloOUIedq9u0q7BgNBn32T+axCQTQq8Pe4x06onINXWwbF2
	GwJTp3KHrhLKWOWUyo/W1XDQzhsaSRHX3ULSasyYJW4BYwW1MBXU0l+mhTxuSrIP9uB/OWSlueB
	YoV8mgOU8Mtn4rtxzWghernhpzRmOTztpWuh6RTqjcsvsUwH4YTHyn2YZaF8=
X-Gm-Gg: AYBFou1Wz2DeOXGD+kTsOQzu8QMJUdPj4kzCAiJAYjtPq2SR03fXX6UOhMpgQS6nx4q
	sg76SaXXB+BncJlytHN/9ObyNd27UmQwTIqfjg2CknhY6fQ5sD9dBzU0YbNWD0denY+0cOURmDu
	zeBtJi5sDEimCNA4K/Qbpr+n7rFvapPK33phXy3urcOGn3LALrpY8Wa/AOw+tbXsgtoINyaGzWM
	ZqfCuL32MQ22Xhl4qhYRosuR3im24OkaQgnPX7o3LDmziwTyq7Yvm3UHuc1Jk8QzuLUlhGNuNYB
	n+pP1a3RIyhYoSBmw/au1bz4huVD/UIcrWukNUpXL3oWYSpJpPxnYFGCULxsYk7QVHrfQOlph+t
	yrWuRz8ShFvsZCw==
X-Received: by 2002:a05:620a:800a:b0:93c:6341:1d66 with SMTP id af79cd13be357-93eb961ca81mr2530092985a.19.1791968682482;
        Wed, 14 Oct 2026 02:04:42 -0700 (PDT)
X-Received: by 2002:a05:620a:800a:b0:93c:6341:1d66 with SMTP id af79cd13be357-93eb961ca81mr2530089085a.19.1791968681822;
        Wed, 14 Oct 2026 02:04:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2343asm769625065e9.9.2026.10.14.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:04:40 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:04:39 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dcaratti@redhat.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, daniel@riscstar.com
Subject: Re: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
Message-ID: <as9Fp6tT8-R26zsW@lore-desk>
References: <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
 <179192615470.434549.15391678719442132292@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n3UHTxbxQXy0YYKA"
Content-Disposition: inline
In-Reply-To: <179192615470.434549.15391678719442132292@kernel.org>
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf45ab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=J8u11l3eBsutwK0vV1QA:9 a=QEXdDO2ut3YA:10
 a=pLGSq0pBND5JrVecVpgA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNSBTYWx0ZWRfXzaw13exzqBBc
 574Faqn8ue2wPudmtZtfB4pcaKzHHKDoaeGUE0fU8o019RgwTlSqIphw2oOjJGU1SCnOsM/n30i
 QWO7RhBjEx8gCZo6pdLeMmwtI4ZYyRiqo78r5n8NPDZ+mNso4KvWpzKZ6uTNU6dLGWjoEw/JQ+x
 95OfVhdb3B8eobMCn7gUAQeQtyNdY3G0XPg7zL4YYRZjnRKy8om+37XnCUG4HxgkNY6Zj4a0GkU
 oD6vsnG6Dt03RCNeP19X/EUfeOp1A4VQRS8nXTboIrhjNrxWB9NzhyT9QjSU4sONABUutTTZWHt
 Xt7pfKgcZjHYvyQglMzRr/eNAVeR+vKRuIm1snCmysza7OyvPTLtG97iSbeG/37+/W8JxTndrGP
 yM6enRrCrVlFROgnH3wphg+tTrN4c9kNXmcHP0wyluVNN7yxh4iHPkwSJUnDFuBbF60LM0g/AVD
 OOwCB8D6IemxwS2tJeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNSBTYWx0ZWRfX9qQmkjSOMBxf
 cGP3YcPPQloFqMpxrQILWZD1d1fzXM9Jz6pX0l2ISZHaaqJWte4csunB6f6JTzeln1lPgSOtho2
 d/xBqyPHv9hLydCgBI9NsB50KfgHNzo=
X-Proofpoint-GUID: BpNjr7kErcx4KWL3__HDRMO7db7JP5N7
X-Proofpoint-ORIG-GUID: BpNjr7kErcx4KWL3__HDRMO7db7JP5N7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140035

--n3UHTxbxQXy0YYKA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [High] The commit message says the strict-priority scheduler selected
>   by the channel-mode mqprio offload and the per-queue CBS shaper "are=E2=
=80=A6
>=20
> --
>=20
> net: stmmac: fix mqprio and cbs combination
>=20
> This patch removes the checks that stopped the channel-mode mqprio offload
> and the CBS offload from being enabled together. It drops the AVB queue
> rejection in tc_mqprio_validate_chan_mode(), the prio_offload check in
> tc_setup_cbs(), and the matching AVB check in stmmac_reinit_queues().
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index ea1f97d6f0bd5..175236ba379d0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>=20
> [ ... ]
>=20
> > @@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(struct s=
tmmac_priv *priv,
> >  		return -EOPNOTSUPP;
> >  	}
> > =20
> > -	/* Forcing strict priority conflicts with the CBS algorithm
> > -	 * of AVB queues, so reject the offload when any queue is
> > -	 * configured as AVB.
> > -	 */
> > -	for (i =3D 0; i < pdata->tx_queues_to_use; i++) {
> > -		if (pdata->tx_queues_cfg[i].mode_to_use =3D=3D MTL_QUEUE_AVB) {
> > -			NL_SET_ERR_MSG_MOD(mqprio->extack,
> > -					   "SP conflicts with AVB queues");
> > -			return -EOPNOTSUPP;
> > -		}
> > -	}
> > -
>=20
> [Severity: High]
>=20
> The commit message says:
>=20
>   The strict-priority scheduler selected by the channel-mode mqprio
>   offload and the per-queue CBS shaper are independent MTL settings and do
>   not conflict
>=20
> Is that true on XGMAC/XLGMAC cores? They use dwmac510_tc_ops, so both
> tc_setup_dwmac510_mqprio() and tc_setup_cbs() can be reached on them.
>=20
> On XGMAC, SP and CBS look like two values of the same per-TC TSA field.
> dwxgmac2_prog_mtl_tx_algorithms() rewrites that field on every TC:
>=20
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_prog_mtl_tx_=
algorithms() {
>     ...
> 	for (i =3D 0; i < MTL_MAX_TX_QUEUES; i++) {
> 		value =3D readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
> 		value &=3D ~XGMAC_TSA;
> 		if (ets)
> 			value |=3D XGMAC_ETS;
> 		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
> 	}
> }
>=20
> dwxgmac2_config_cbs() turns CBS on by writing the same field:
>=20
> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_config_cbs()=
 {
>     ...
> 	value =3D readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
> 	value &=3D ~XGMAC_TSA;
> 	value |=3D XGMAC_CC | XGMAC_CBS;
> 	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
> }
>=20
> With this check gone, what happens if a TX queue is already in AVB mode?
> One way to get there is a DT mtl-tx-config queue with snps,avb-algorithm.
> In that case stmmac_open()->stmmac_mtl_configuration() programs CBS for t=
he
> queue when the device is opened.

I guess the only case that is not covered yet is if the user configures CBS
via the device-tree and then applies mqprio via tc on top of it.
I will fix in v2.

Regards,
Lorenzo

>=20
> After that, "tc qdisc replace ... mqprio ... mode channel hw 1" now
> succeeds and runs:
>=20
> tc_setup_dwmac510_mqprio()
>   tc_mqprio_validate_chan_mode()
>   tc_mqprio_config_queue_prio()
>     stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP)
>       dwxgmac2_prog_mtl_tx_algorithms()
>=20
> Would this also clear TSA on the AVB queue and turn CBS off in hardware?
> Nothing calls stmmac_configure_cbs() again afterwards. Meanwhile
> tx_queues_cfg[].mode_to_use still says MTL_QUEUE_AVB, so the driver state
> and the hardware would disagree until the next ndo_open.
>=20
> Removing mqprio seems to cause the same problem. prio_offload can now be
> true while AVB queues exist, and stmmac_reset_tc_mqprio() then does:
>=20
> 	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> 				      priv->plat->tx_sched_algorithm);
>=20
> On XGMAC this rewrites TSA on every TC again (to ETS or SP). That would
> wipe CBS on any AVB queue and not restore it.
>=20
> The example in the commit message (mqprio first, then the cbs children)
> works because config_cbs runs after the SP write.
>=20
> On dwmac4/EQoS the claim does seem to hold.
> dwmac4_prog_mtl_tx_algorithms() only touches MTL_OPERATION_SCHALG_MASK, a=
nd
> CBS is enabled separately through MTL_ETS_CTRL_AVALG.
>=20
> The commit in the Fixes: tag added these checks on purpose:
>=20
>   Forcing strict priority conflicts with the CBS algorithm of AVB queues
>=20
> Should the checks be kept for XGMAC? Or could the mqprio set and reset
> paths call stmmac_configure_cbs() again after reprogramming the TX
> algorithm?
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef%40oss.qualcomm.com

--n3UHTxbxQXy0YYKA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas9FpwAKCRA6cBh0uS2t
rGZPAP98x72otE4qA4N1TGw3slHXH9KEzgmf4M4VZf0q5OUz6AD/cxcAm5sdDz7I
xoiNkdA1JAF4hqpK3e/kZFVzTHNjbw4=
=Rw3M
-----END PGP SIGNATURE-----

--n3UHTxbxQXy0YYKA--
