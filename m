Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AB41F5DB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962421; cv=none; b=MMBzTjA33fuU5EmA8XwDOIQwvJPvK7VIFi0267kW01shytVZSaM6R/ncGPWd7QXvIJOyIkJrzQjjVnT1oO58S7mjypyezQDbbS6X3wf7Vz6PJz/B2sUroZWmI6U3QWVTbKyN5/jlB3DjY1F9qEzOE67CCMzb+/ePbDj3fsND3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962421; c=relaxed/simple;
	bh=yQaBCeJX4iIOgtGSatzhMksHWRZ9BfWOqAnVI+31ysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlwVsWts7u9ohx8grWyNIz/rDxeYuG1p1cIa/YgVpxlX2BWZq9TDRKLV5AquMr5paHwEnJetQeyOU9ZoB6U1YGIV9CsK9ayRL0Lctp8OvwC9Fnhi8JBIO4cYGXkFL2kvGQzB0VeL3oF8w7wR0RJUXwNtqFLgLtVRPZ6yg0gzl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aDSLw7HP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bFlV6oPc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDSLw7HP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bFlV6oPc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HSC213888726
	for <netdev@vger.kernel.org>; Wed, 5 Aug 2026 20:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5LZuDa/NBmLZez6CPV0BSels
	kEx0FfB09wzrO8qwC5Q=; b=aDSLw7HPQn+240k6hE37hqqjTT+GY/ZhUHnrSr80
	ABYts9WsyXAw9M0QuRLpRJ5cra2uoz2KbpM8CNfZttNlpr24/u4gQiCFSVd1vOzP
	snoWfB6c8FTuz/ZIfXHYOjFT2N56tHJrHHFoeVxQGWVn8TdOhWItE9wyUR01Latw
	g0wFItOGcESe3emO8ypP6hdjBaVThtM1lem/EEzRH0vbp1pWpiANBtZJoGeSRHTU
	q5Ay2zU2VGOkBMkcfR+wsE11aT1OPmUIZgJ8KOjBZpU/Aj0griG7JXxN8PUE0ZjT
	KbphGuSFvrzcCgWpn1ca/5Vo4qonLFVo4DxHrHNBJE+/Fw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5t1ct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 20:40:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1b4d961dso2412631cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785962414; x=1786567214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5LZuDa/NBmLZez6CPV0BSelskEx0FfB09wzrO8qwC5Q=;
        b=bFlV6oPcjguL7q9awJXp3rxLS0O0JxxQpMs7Fp7bbR6NaBM2uF5noIzGQg79Lfs0ii
         uy0TMUjVjgtUK7yhktw04cBp8CssCYVZrXOE0WAG8HLF5+uWQB9jzb1YZTCr+gZ6GHcH
         9crodjsQPt9tzNNPnjmrQJf1euS/oAS95gQEfbUWKFX3dApqFzcWUjsrIDER4NRlChBC
         ExK6Fmlp91rpjs2Wc+Vo7Sm0/dUCZ/ywb0vO5it796Sq1RT8a6s1vaQEn5RQ8GDJFKu4
         +ChFdKAe0OM8PEfFHCUtEXy7GP+H1VjjIbjb9PBjj/jfi/jQqfPQodN0/Fpe11GFo+/P
         U2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962414; x=1786567214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LZuDa/NBmLZez6CPV0BSelskEx0FfB09wzrO8qwC5Q=;
        b=AubcRbWLeZAIC0o7lZXPkOEsViRGbchd4dJHhPr59oS0nc169mNckmduA3rJ9BTv0L
         zrqtJerOfzPCjncdJ/QUI/Nb0shhkGM5nQfJ6Y37LmW043OdZgg2+njsmn4f2EN+B4yk
         ul7US2E7+HdlszblH0p+ElmCDVzSNfA+VEfDeXlKDFpSD34npS0M4uRoDxaMmIJzQWAA
         d/TEXS3Ewu35yiT6EdvxDlDPFfT/NA3vSIlokneS+VWVyef5p4nMsP2LKN8viXvvLgR2
         t6qnlB96jCjZ0tT0TrfYUz3/PaIZGkP6XD1v5X6OYeLKpfjnYvrNDqIwsC+A0OFZ2acv
         9U2w==
X-Forwarded-Encrypted: i=1; AHgh+RpL2iYr/vc78VvJWj9nR28b75+6WaKsgXjztGVe8O1O0QCC9WQlZig/h+3PFQw2pRgjwrOUtHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWKY71Tts9MiKUeQk1IYRyDxnQLeUmIVxlV4Y91bnwRd5YOfw
	7+tUMMZPIPs7feGtkpNQVxjnejut6aq7BKEZYUvu8NUG/6M0vD5lo/ruOd9rEThm6C8A3yrVaQc
	9p6ckhxW4h4Wd+fgQMLR4kEfw63flhdGQ0rDhX7/Rf7RN1yKczZFC8+c4DKA=
X-Gm-Gg: AR+sD10vZPeINap0lWrD8j9hj5dyoWQJZOOJfyHtDYYxEbZMKqlsM//UTesvsu7rfhE
	0lCZUwUg+e3++jf95/FQ5LETfDZRBFvQCB7M6DFKYLY7iatgvmDU4hPHkK58s2XfbhUeCXT4g5o
	S46lNuUCK8qPHl7FTVw216QZ1cBURTYdz+OXDRPmdQe1QOi1tHPGN0yZ0uHpXWRf1ke3wXWbesv
	baI8p3qFz3tn3oF3Ul7iFw9DsRZ+9MHwUsBf+4iyHZNHteaDL93uVYRfwl2VasmO8mU8ED7h2r6
	I4Ayj0MIZeIErQBAQHg/pk74Zfzxb9edrJmputpi++pmAi+rEnnSIuwScerf4SbiPsv4qu8bfY4
	chXhrOLZ9pzSLwRU=
X-Received: by 2002:a05:622a:5145:b0:517:c65c:4987 with SMTP id d75a77b69052e-52cfb0a9111mr22805521cf.22.1785962414453;
        Wed, 05 Aug 2026 13:40:14 -0700 (PDT)
X-Received: by 2002:a05:622a:5145:b0:517:c65c:4987 with SMTP id d75a77b69052e-52cfb0a9111mr22804911cf.22.1785962413964;
        Wed, 05 Aug 2026 13:40:13 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b31975sm97158f8f.33.2026.08.05.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:40:13 -0700 (PDT)
Date: Wed, 5 Aug 2026 22:40:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: add tc-ets qdisc offload
Message-ID: <anOfrP0IZPYnfzE3@lore-qca>
References: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>
 <anN6sHZt47dRZeaE@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DmZsoeZb2q28/CCl"
Content-Disposition: inline
In-Reply-To: <anN6sHZt47dRZeaE@dcaratti.users.ipa.redhat.com>
X-Authority-Analysis: v=2.4 cv=Xea5Co55 c=1 sm=1 tr=0 ts=6a739fb1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=P-IC7800AAAA:8
 a=ivObySnqZvrQ93kweaYA:9 a=CjuIK1q_8ugA:10 a=WgJNjlqc4YYCZ52uAfgA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 7G1Q_gcOmzl2YMukJZ6iGlxJjValQK0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2OSBTYWx0ZWRfX2DYWNd6VDglg
 fGKdsjGjuBGMJnw2PXLRpAvhvj3y42SHHISofKt4wn+gK+AcHe6L/EKU4TZLKpNLcG080lBE4Gm
 83tkwc11FjeFNFiV3aRSPYdY71oGUwX+yjS6kV4/T6vAsqzwlxd39OjKrlTVO62qAhkTFebn5lD
 rAHj/sIB3fVczpiJCU4iD9Sqg5wQB06qdQpnFyC5sOcUu6YHfKFZHbGfWry8y+tbOJGNk0DWtRF
 2QvK/BNDexOE0A/CNv0VohSZCxjAt4UwvMmXsTRgJwbrlsUOdpyQpWLvUl0YGPyTPyyi2c49qAs
 9zF2hFcTc2+zFtDBv7q40zrR9PgeSR4bdQAffhGvWrYdIw5hF4EQHXnNaq6SQtO2cT1Rzjjo0pL
 C5CrMl23oRjOUXeAepPLhEzEKXmIvxxq/XFuXDGdeOsL7ld4aA3pUt8uLmBwnjho23ZvptPSZe2
 UuyxK0ny0G31Ba+7jRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2OSBTYWx0ZWRfX2d9uOeqODfm7
 /xWtG+ZJvNXL4Cp21eLFruhmWq+Ysoh9KYfkpuPZtm2UC6kp5qzxLmYJqnuZQIQJKYVmuDSxgTn
 HQrZCKt/AUG6T+ctbUv+90ogo/Tm4a4=
X-Proofpoint-ORIG-GUID: 7G1Q_gcOmzl2YMukJZ6iGlxJjValQK0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050169

--DmZsoeZb2q28/CCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Aug 04, 2026 at 08:17:35PM +0200, Lorenzo Bianconi wrote:
>=20
> [...]
>=20
> > When all bands are strict priority, the MTL scheduler is programmed with
> > SP scheduling;=20
>=20
> ... and I replied too early _ sorry for the noise _ there is another smal=
l thing

thx for the review :)

> w.r.t. SP scheduling:
>=20
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > @@ -1210,6 +1210,73 @@ static int tc_setup_etf(struct stmmac_priv *priv,
> >  	return 0;
> >  }
> > =20
> > +static int tc_setup_sp_sched(struct stmmac_priv *priv)
> > +{
> > +	struct plat_stmmacenet_data *pdata =3D priv->plat;
> > +	int i;
> > +
> > +	for (i =3D 0; i < pdata->tx_queues_to_use; i++)
> > +		pdata->tx_queues_cfg[i].weight =3D 0;
> > +	stmmac_set_tx_queue_weight(priv);
> > +
> > +	pdata->tx_sched_algorithm =3D MTL_TX_ALGORITHM_SP;
> > +	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
> > +				      pdata->tx_sched_algorithm);
> > +
> > +	return 0;
> > +}
>=20
> The above function configures the stmmac SP queues to a well-known state =
where all
> queues are SP. However,
>=20
> [...]
>=20
> > +
> > +static int tc_setup_ets_sched(struct stmmac_priv *priv,
> > +			      struct tc_ets_qopt_offload *qopt)
> > +{
> > +	struct tc_ets_qopt_offload_replace_params *p =3D &qopt->replace_param=
s;
> > +	struct plat_stmmacenet_data *pdata =3D priv->plat;
> > +	int i, nstrict =3D 0;
> > +
> > +	if (p->bands > priv->plat->tx_queues_to_use)
> > +		return -EOPNOTSUPP;
> > +
> > +	for (i =3D 0; i < p->bands; i++) {
> > +		if (!p->quanta[i])
> > +			nstrict++;
> > +	}
> > +
> > +	if (p->bands && nstrict)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (nstrict) {
> > +		tc_setup_sp_sched(priv);
>=20
> This is not necessarily what the user wants when setting up the ETS qdisc.
> The driver should parse 'priomap' (like in [1] or [2]) so that only 'nstr=
ict'
> queues are involved, and selected based on the packet priority. Otherwise=
, the
> offloaded ETS is going to behave very differently from its full-software
> implementation _ which is something we probably want to avoid.
>=20
> [1] https://elixir.bootlin.com/linux/v7.1.5/source/drivers/net/ethernet/m=
icrochip/lan966x/lan966x_ets.c#L36
> [2] https://elixir.bootlin.com/linux/v7.1.5/source/drivers/net/ethernet/a=
iroha/airoha_eth.c#L2281
> =09
> WDYT? Any feedback appreciated!

ack, I agree. Since the hw assigns increasing priority to the sp queues (pr=
io_n+1 > prio_n),
we should check the priomap according to the following code:

	if (nstrict) {
		if (nstrict !=3D p->bands)
			return -EINVAL;

		for (i =3D 0; i < p->bands; i++) {
			if (p->priomap[p->bands - i - 1] !=3D i)
				return -EINVAL;
		}
		...
	}

Agree?

Regard,
Lorenzo

>=20
> --=20
> davide
>=20

--DmZsoeZb2q28/CCl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanOfrAAKCRA6cBh0uS2t
rL4wAQDb78rIKeY8ylrviZj54UjKHnTb97dp/vkXS3Qr9qcgSQEA28BfSF9ibFLs
EEVoTHxAuTnIYoUBUvdbgvhPNhdiDQ0=
=jIeP
-----END PGP SIGNATURE-----

--DmZsoeZb2q28/CCl--
