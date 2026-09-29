Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643E358399
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699743; cv=none; b=jKp1QIze+lmQ3Ut48zx7p+ZXrBZ61oizE6CRUJcsrZcNA3ZXr9K+hMDVHXrHI2YuE9K8UgRcu7H+ll+9D77SPRusa38V/SiWAIlCpApTilKZORhnvU1jzqoQY4SdvMkjzx2l9pCWWYiZSEWxK8TF1LgzYVIJ051eIeFZyZd4oCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699743; c=relaxed/simple;
	bh=7HCAvBY31Fcso/YH0DRSom85NWi4yGpq+lk6RBQcKOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSWd/ivneYF1sHvUExEp5riTJwgi3kDhVYeWr9ww7KyuXYrC0WNkDlutRf1qOWCFjNSyy1BxPTFv99QJJR9PTpOb9PpNk+QCy8078p2+GLyHDAi2olIeM9Bo6zg+IIn1UwBJ4o31bclkbSua51oajv0XadwBcJHVQCy3rAFlmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtR+IK2y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MMogzi5q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtR+IK2y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MMogzi5q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCr6jk206325
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KgswDTUC6heFE7Kb6HjIW/Q+
	kQDgzcu9CfQIYuxeCuk=; b=XtR+IK2y+R3kVV5rIcaJToX++TeBAbdcSFnIDHOU
	mjgG/Epwzd7BwvDbmqPZQjGYlP+LU7jCuI4bhQZhplw2NdwjxERxwE6OkY5ewNFA
	vIWVUEeUq6DVS6+BfxlTjnGSTLN68OHfLZmhvoCegxZ4NjJqpwfACiqqaCd6Bqha
	HzVyMvwaOWA+N/Ge2QzuVPxw4i5mX+Jmgmu0x5ZygJiKpCqklUwEtVlqsOPILNxp
	lXpHbuT3XirjLpEjpnziPTn1Vqsc1zKELsJ0WTS/WV2QXf8iYy15zPLR/cFCs+jT
	U786o475DpXutHii0UpwOkHQXv8sQwTJQMpmxDHin+SjSw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144v392-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:35:39 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso3512015241.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790699739; x=1791304539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KgswDTUC6heFE7Kb6HjIW/Q+kQDgzcu9CfQIYuxeCuk=;
        b=MMogzi5qdOowCUN5yfyu/AyTeruXq5gaYdNNBGmALyYwRuuphFiIzSEuMX8PCvNYKp
         P6WZFgaVzCFJCt7G6XPaIPdc/v2Tl4uCgdFq0zXYqah1fvAx0lDVwJ+Pcr+9j7QARwvh
         Jr3R6Pp1KojNgzJ+AHhfhYjq0tL1p6s8McC4FxDOEQznnKUuhkaad71HvV6i15Zh1KP6
         yd4lcPGnbcnYTUyj8qfCeg+2SKfz7FwJqy7avwzK/f9Ln8mfesQf6BH0GEyFxiacO6Vd
         4BJu9qq8TeBd6NHwTcap+G4hL3dCV1IhbmmginNOW+Gj/yuK+f5ZpErtlWGlka3QWUjP
         UeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699739; x=1791304539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgswDTUC6heFE7Kb6HjIW/Q+kQDgzcu9CfQIYuxeCuk=;
        b=CJI0SyvYVkGwDgpA5Oo3z0XcfRIs7M0D9BhTV2gqq3XBacpXmA+oq+0s9bFA0Rf96p
         MR6XrcBl1roWDyaQEShbdqq1H+5qiDZopSrVLwPV7DAKCTJnLob8559JIMCVOd6GpN2p
         ZhGum0kyEyJI0Y792MrXHoRuR1CqDgk4UWLrZoJqG7C6hlDG15yyp0TIT4TNR0x0Qs8A
         GBe2g7rXy0hOoTZJaoLaW72sH8trNbxyIF+7FWJ7PCJv9PYRm1zWr4D50lzz+Uwx1Gzy
         80M4Ao9/w20Vc5KYXfrDYBKda3gH1nmUQ/wzvGfaS5ooDI/IKPlVfLm6LPFd7Kc5ZDKq
         W7WQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAQuUh/mx9aVr11cVVw1kmN5p0N3HfrcpTIfj1KCPqX7osAxqS/WwwoeM8E5H5NX6PELHdjFc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWL3CB/4XeournhS8qPWbPup/k+HRRb5vF7gkcsmp/f0c96fhU
	Vy2ngRJPfbKVyIHdzVRyFkOgq5MuyBm++WQBtvUMPspqxHgdGBIXlPE92HXzGmuHpOsI5omZLAs
	EnYRiik9LieZ3f9eLt4kGmd7RYulLqGnYc0AZ3rc4QpveWd5LMILBOcbLq/E=
X-Gm-Gg: AYBFou0iNlfva4RJVVTrovAnKu1H0/MjqZRY8jXqbjkplsAkfsHzRt6ByKukZNMvXE0
	lrli52Cfhef/RoMKOm6pixDk0j49jjjUrpauOcqG/JqsIeJExNw33Esukz9NwS09Hv9bsgwpUef
	dh4sqRggX5r0yTmerzXtMU8bLTUL7zNZOySB33mNOzVKI2nMu6Q2a3v8hTlElbzGiFHHDU0/1Hx
	8H3a/z1LijoP6QfAbNAeihw+M0fXwwxZYhjut/PQIFr2XsAWJ6dX+Hpo28pB9G5x6shaxD2Y3z4
	xdx1eSHhHZxlnk34MoI66qWC1lC1N+Jqh0+iegc4s0emT/OpybOAld9ObcaMGFNbrsgH2h9RZG1
	UJMGWnN2WWXWgtA==
X-Received: by 2002:a05:6102:1486:b0:7a7:ad9f:53e2 with SMTP id ada2fe7eead31-7bc2ecee87cmr47632137.1.1790699738715;
        Tue, 29 Sep 2026 09:35:38 -0700 (PDT)
X-Received: by 2002:a05:6102:1486:b0:7a7:ad9f:53e2 with SMTP id ada2fe7eead31-7bc2ecee87cmr47606137.1.1790699738086;
        Tue, 29 Sep 2026 09:35:38 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af508bebesm5857887f8f.29.2026.09.29.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:35:37 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:35:36 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: stmmac: add XDP multi-buff support for
 TX side
Message-ID: <arvo2GYtvVZ9FDyf@lore-desk>
References: <20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c@oss.qualcomm.com>
 <179069820857.434549.2531492906306099121@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lCMFkcEL7KUIgE/T"
Content-Disposition: inline
In-Reply-To: <179069820857.434549.2531492906306099121@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX2g7c5zuVYawo
 T+PV0loKsD6lczsmGMzvbigevBqCIpDZDmz+RwmLdqiVRoohgvmf8b/qVz0wDX2vTHPkjAPOWAL
 sZYPa31KRg+BCRiImkM4/b9E7M4CFN98uyVqXFtimtilOO0pBZvdmL9h3JW0Y/U+8LsPnkjLAOu
 oljP4MB+ovaEmPWEdKthXua8I3ME1EHSxuieCqKS/87vbfj1TF4D61rIEOUQ/amUabwsdbvbVFA
 lBP/roOY3QjqELREnTkEOEQATpUWsnHlkJyZ9Z+b6900Dx474hBW8rYhLvhE1umcemx0WV43XgN
 oqmb+dtxvZy35CyHDYjxWwYmt6ps3EJCzmRmlJPY53UZY4IZLXytXSRM3GqX0maReDBrdA/qe9z
 qOEO5HeG7ehl8O+jbPc1nO1N6pbaURj7VXeoh6k+BPQhSfOCb5vgTAB+MRw43DTuZTRX3lhAzmX
 piw9VSbC/Eb2c/htBZw==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abbe8db cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=jf9qpCBZcCKH78LjphgA:9 a=QEXdDO2ut3YA:10
 a=vBZCTss2YYTdBBQYqEIA:9 a=1WsBpfsz9X-RYQiigVTh:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: DY3mVQ-bpRIhgGw9raoVsfYk5COQ6ihe
X-Proofpoint-GUID: DY3mVQ-bpRIhgGw9raoVsfYk5COQ6ihe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NiBTYWx0ZWRfX24CcyuOIOIL8
 Cxi+GGNcV4173O/lP3Hs/20tYhlnjW3iloAc8SEuIe5aSz42KeX7FCfakKlzCKP+koHrwjW8nOm
 y729EtEOn+BBtNPaZ6xVczDZ/wBU9sA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290066

--lCMFkcEL7KUIgE/T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The patch fixes a divide-by-zero crash in the XDP TX path
>   without saying so and without a Fixes: tag.
> - [Low] In stmmac_xdp_xmit_xdpf(), the new coalescing check reads
>   priv->tx_coal_frames[queue] twice with plain loads: once for the zero=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: add XDP multi-buff support for TX side
>=20
> This commit extends stmmac_xdp_xmit_xdpf() so it can transmit XDP frames
> that carry fragments. The frame head and each frag get their own TX
> descriptor. The driver now also advertises NDO_XMIT_SG for the redirect
> target.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3ad9252bf6aea..f1e9ac2f98598 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5241,77 +5241,118 @@ static unsigned int stmmac_rx_buf2_len(struct =
stmmac_priv *priv,
> >  static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> >  				struct xdp_frame *xdpf, bool dma_map)
> >  {
>=20
> [ ... ]
>=20
> > +	tx_q->tx_count_frames +=3D num_frames;
> > =20
> > -	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] =3D=3D 0)
> > -		set_ic =3D true;
> > -	else
> > -		set_ic =3D false;
> > +	if (priv->tx_coal_frames[queue] &&
> > +	    (tx_q->tx_count_frames % priv->tx_coal_frames[queue]) < num_frame=
s) {
>=20
> [Severity: Medium]
> The old code here divided by priv->tx_coal_frames[queue] without checking
> it for zero. That code came in with be8b38a722e6 ("net: stmmac: Add suppo=
rt
> for XDP_TX action").
>=20
> Can tx_coal_frames[queue] be 0 here? __stmmac_set_coalesce() only rejects
> the request when both values are zero:
>=20
> 	if ((ec->tx_coalesce_usecs =3D=3D 0) &&
> 	    (ec->tx_max_coalesced_frames =3D=3D 0))
> 		return -EINVAL;
>=20
> So a command like "ethtool -C ethX tx-usecs 100 tx-frames 0" is accepted
> and stores 0 in priv->tx_coal_frames[]. Before this patch, the next XDP_TX
> or ndo_xdp_xmit frame would then do a modulo by zero in softirq context.
>=20
> The new priv->tx_coal_frames[queue] guard fixes that, but the commit
> message only describes multi-buff TX support. stmmac_xmit(),
> stmmac_tso_xmit() and stmmac_xdp_xmit_zc() already have this check.
>=20
> Could the fix be split into its own patch with a
> "Fixes: be8b38a722e6" tag, so it can reach stable?

I guess we can avoid to add the 'Fixes tag' here (and so to backport this
patch) since the issue seems quite a corner case.

>=20
> [Severity: Low]
> This check does two plain loads of priv->tx_coal_frames[queue]: one for t=
he
> zero test and one for the divisor.
>=20
> __stmmac_set_coalesce() writes this field under RTNL. It does not hold the
> TX queue lock that stmmac_xdp_xmit() and stmmac_xdp_xmit_back() take, and
> it can store 0.
>=20
> If the compiler reloads the field between the two reads and a 0 is stored
> in that window, can the modulo still divide by zero? Would taking a single
> snapshot help, for example:
>=20
> 	u32 coal =3D READ_ONCE(priv->tx_coal_frames[queue]);
>=20
> and then using coal for both the test and the division?
>=20
> stmmac_xmit(), stmmac_tso_xmit() and stmmac_xdp_xmit_zc() read the field
> twice in the same way.

I agree there is a small race here, but the same issue is present in
stmmac_xmit() and in stmmac_tso_xmit(). I think we can fix them with a sing=
le
dedicated patch.

Regards,
Lorenzo

>=20
> > +		struct stmmac_txq_stats *txq_stats;
> > =20
> > -	if (set_ic) {
> > +		desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
> > +		stmmac_set_tx_ic(priv, desc);
> >  		tx_q->tx_count_frames =3D 0;
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c%40oss.qualcomm.com

--lCMFkcEL7KUIgE/T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCarvo2AAKCRA6cBh0uS2t
rPbYAQC4FHOuUC7np8NscKyMG+sNI0axYle6eOCMGcv4Wg//lgEAs5kYtXHqr0Vo
h852u1vJB4hxTP+jHlpF7k5OBbOhzAo=
=f2Al
-----END PGP SIGNATURE-----

--lCMFkcEL7KUIgE/T--
