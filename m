Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B57414435
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581580; cv=none; b=LSR3zKAQKcBIrx6aEI8CqmdsvEc+k0BbM1OduUPuB7PIKo33k6Tbv6iZ2DdAr6MABe34UZ67HzmGkbW14FQVHq9cbSQojsoHxVUiBvCOV2Dd8a6VngTFSw0uT1JbkCm13MD5pjfxOZtXc+mtHqQiCMhbwWdtBFSU2UDy60LltJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581580; c=relaxed/simple;
	bh=LlO3K2BS3h21cc49zr26PZCqpaH/WITkpYqrUSqcQX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3dAVaTLez8mMhD/o+Q2ugzccllOqDHPJKsoyEHwzzwumSDJ/jVmpwBi3Cyn4MZghTzlkstHyo0hvZuDSFG1JkY90EySBcrcv/8+K5GydlbsDMMHBkoDLJl/u4D9u8Th6s2+Wom96gFRy1vNg5H3srxi//aWe9LN9uxF7cq1qhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQkbuyX6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OfgMTtL4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQkbuyX6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfgMTtL4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFeYIe2432361
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M9vsehtLoSTXZx5xXdJaU0H7
	tyNg+1K0SoermXNYaMs=; b=kQkbuyX64Pj8WXXDfZtbblOAzh0JXt2F8khZfDFi
	W2D9wpqqRBjtmHOZ3HW+A4SUTy9JAf9LTpnWxnCKY63KeXF4BEaUyI8Nbyv5nm8Y
	mgfgoKXTUTvPhZpsUApfFNkdOq4ui709ycHTkY7y3CPJoZMmtAviMiHJbVsdDjpG
	b40ybWXsfb1JnkYxTbP1jIO9K0HS+cq3xGJoBb0fBDcknJ1JGCDAAA0to06SGq0l
	l6QpGE1LuzDDF6LLY5SqRtuVAzEw/vb2LmXknDvkDz41z2WoSmdKLhqvrGmvsfqI
	6wjMIY45SqPl/pPo5Yghgrnl/qbm/2q+MMP38UST6a7kDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqthnsqas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:59:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso914711285a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789581562; x=1790186362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M9vsehtLoSTXZx5xXdJaU0H7tyNg+1K0SoermXNYaMs=;
        b=OfgMTtL47zXrpY0VliH/xlx5k8mH3/cguGtFZUEa9uxHYoIMxJFGNkdkGlk9Dmfh6k
         cKTDnUT/sWotK/TqxijAWUa1q38chDQ7THBKP74QxSy/ZnwMQZfJAVzLCQthIQXFPt9T
         B7UNr9v9Crs9mWjmqixwdx3jFoRAptal4kXwo0DSZKrCKyV12ZKqdbO//QIn1CK7Hbia
         9WoIQlHH1R0i5kLXpc8Bxe5CIGDaGVyzgjABKo4njXmGhVPj6MGY50txMK663RjYD+b0
         J/41fZFnjQQDqEIyVAiFjf9BgItNyF9LwK0S1DyHirC5o8j/+JREvEmfN7EOEiTbEpd2
         bBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581562; x=1790186362;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9vsehtLoSTXZx5xXdJaU0H7tyNg+1K0SoermXNYaMs=;
        b=hEQ/mxVTHD7Hum/K+SPulvnDxOpFB+XLLqUFcRRWaioo/gRXnHlwZC52opS0FSn2A/
         P2SKeDABJm0wSR0AH56BZR0+RYCrwWDvg/V2Qw3FGRwAEh96GUMqU+XD0fSWsRjhUWBC
         SLLm1N03J8JusvhMnA98MGpTNxE/27lIyT/WPupGIlulkBbWe2DkkijXnsX+ooByHdpS
         hqs1fYqHO4xX4QK8XmgcmdJwTaOhY6Mnx+S4K/rwJYjoz5NqNVs0ubiuirX91t4C1Gvg
         HMQH6ZB9LIOARZhTibcKzJEGsvGzIQ5Z0MnuAN1grOHb2fgIABotOHHy6eDFMCsie/FU
         0ltw==
X-Forwarded-Encrypted: i=1; AKwUvBxg1vPLimOPJnjGuwteq2KKj7XPu6UKxGAZ8Lw3jEUcslE7HBeFJt1wDmIdr11/S37suEU28LM=@vger.kernel.org
X-Gm-Message-State: AFuF++mb+Zp1k9kWRMhtLNZDESM6KN1aqySpU7ynF07s/rmO2vSErHW7
	1kJNAn1hVVZhQiOgZBxNLtf8A2B+rZyc2JRccwlJyQy7wfAN5aua5mERSq+m7Gbmr9wlz+ccnFm
	JXNtlgZ2TQjPauEbxKpYPp2e9fdscvxxmFUhMx9ul3PsZY8+YruOBi7BFR8w=
X-Gm-Gg: AYBFou0iZrtjFiXLUpFFhWHYJc6W1bKq4CHla4MVmxWdgmc/vSzHhCQvjQvjooWEG0e
	JbzWnkIx5DeB0ZjDIUlVIteM2aU7WWk82VsOjQoRBgOIHQdbGbGWKpTp/2aE9NBH50/jWLfXtbw
	RxH7LeGkv39s1v4w+mxtOcJ/klwk8qamAtQQWXoViWBS9Nuwj2/EHXhA52qEpIOhx7JtTMd0kGv
	Y15FBoXBWInYhWhSFu1/vozfYoAjp3/1sBWqUXfujr0NqqYCuHka1pTL6q/3pVcTnDJxWqQPn2s
	fp/D/QoW07ucMfwe+4ahaqIDLE1WofCE3kPd2FxnqaDlqxKv9XR5SputdYZb5xWKn4H0KqkwKCs
	DkiFzGc1TOkYj1Hv5F++73hTPd/NlTkwfcvLvC4pdLxfzgkABNQ==
X-Received: by 2002:a05:620a:8085:b0:939:6de7:a624 with SMTP id af79cd13be357-93bb79829damr664426685a.48.1789581561617;
        Wed, 16 Sep 2026 10:59:21 -0700 (PDT)
X-Received: by 2002:a05:620a:8085:b0:939:6de7:a624 with SMTP id af79cd13be357-93bb79829damr664372385a.48.1789581556223;
        Wed, 16 Sep 2026 10:59:16 -0700 (PDT)
Received: from localhost (mob-176-242-39-34.net.vodafone.it. [176.242.39.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd226ee5sm8078025e9.3.2026.09.16.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:59:14 -0700 (PDT)
Date: Wed, 16 Sep 2026 19:59:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, rayagond@vayavyalabs.com, treding@nvidia.com,
        linux@armlinux.org.uk, qiangqing.zhang@nxp.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v5] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Message-ID: <aqrY8JRIyUZRCR_R@lore-qca>
References: <20260914-stmmac-ptp-error-propagate-v5-1-81149897e65d@oss.qualcomm.com>
 <178957251673.22033.10412264976351408309@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PT3V21VG+697wK/X"
Content-Disposition: inline
In-Reply-To: <178957251673.22033.10412264976351408309@kernel.org>
X-Proofpoint-ORIG-GUID: vUqo-RGXAB3coStVbWCc5gVjAB8w0cMl
X-Authority-Analysis: v=2.4 cv=IsKL47/g c=1 sm=1 tr=0 ts=6aaad8fb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=AQCpnuTwkiGt/6pP7chwVg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=EUspDBNiAAAA:8 a=ecuMlwGbzXfNJWZHU9kA:9 a=wPNLvfGTeEIA:10
 a=yjX2QIIuNVbvbjtVbqQA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI0NyBTYWx0ZWRfX7AxYjBZo2bJ6
 Pr3C+q4VXCK1IVgHl1VlJWB8zh+lM5eAQjB2XKqRhkAPdDvFUw8rsNOAxuXg1qA8mQwyn2kqS3M
 Ll5yGgLvFeMyQmu/BFrEyaZpSfGhCpYPPkGlpxoAB2oJG6SomNU5S9/jL8dALJw/p/LnQx3styf
 zRk7qiF4mQNJ6LlQiKIr8fP+p4ffGyrHsiIj431Hm4LIDupJg/CgUxiwdFVT99wdxTiffFtu/Ny
 eAJEHT1JPMXrEP5XqIrZHMFLqhp8fNqeRUm2RHVL2qevfY1v6D0kpdVw2ozYz8UCL7RJUbWT42e
 CZlg6gmDwBloKX1jdRZdzbRwHiAzmDOI0d2tfsAMOaOUAWAJeNYlbMVzGEoT6UF+9PuflZkBF5L
 1zxUEU7CNOgQXxdmygFO84TAbDPk0j778dw0C9ayVlgcDHG9Q9BheS0SZz98IiKPp45Jb3FlsYA
 2ESnLZ6+eEMery7P7ag==
X-Proofpoint-GUID: vUqo-RGXAB3coStVbWCc5gVjAB8w0cMl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI0NyBTYWx0ZWRfX3D7wxM70jkKq
 a+k8M2eJij5RRK6y2CH+EVY8hBYp4B7AsBKUErS7uCrABbiHP186lJRoCwN+tM2YR66y3eIqkI1
 zzqsgAFPzQsFiqqhbyQX5I/AjpuNQo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160247

--PT3V21VG+697wK/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

>=20
> A few questions below.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net=
/ethernet/stmicro/stmmac/stmmac.h
> > index 7582fca637419..4fc96b317d79c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>=20
> [ ... ]
>=20
> > @@ -419,6 +421,11 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct =
clk *clk_tx_i,
> > =20
> >  struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev);
> > =20
> > +static inline bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
> > +{
> > +	return priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp;
> > +}
> > +
> >  static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
> >  {
> >  	return !!priv->xdp_prog;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/dri=
vers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > index 154cc0c7623da..7758b854700a3 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > @@ -1007,8 +1007,7 @@ static int stmmac_get_ts_info(struct net_device *=
dev,
> >  {
> >  	struct stmmac_priv *priv =3D netdev_priv(dev);
> > =20
> > -	if ((priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
> > -
> > +	if (stmmac_check_timestamp_cap(priv)) {
> >  		info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE |
> >  					SOF_TIMESTAMPING_TX_HARDWARE |
> >  					SOF_TIMESTAMPING_RX_HARDWARE |
>=20
> [Severity: Medium]
> This is a pre-existing issue and not something this patch introduces, but
> this branch of stmmac_get_ts_info() reports phc_index =3D 0 when
> priv->ptp_clock is NULL:
>=20
> 	if (priv->ptp_clock)
> 		info->phc_index =3D ptp_clock_index(priv->ptp_clock);
> 	else
> 		info->phc_index =3D 0;
>=20
> The ethtool core expresses "no PHC" with -1 (ethtool_init_tsinfo() and
> ethtool_op_get_ts_info() both set info->phc_index =3D -1), so index 0 is
> reported to userspace as a real PHC that usually belongs to another
> device.

This issue is already fixed in the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Df0ef4b1eaed000a304726a43091588e8426ba08a

>=20
> The patch makes the unregistered-PHC case a normal outcome, since
> stmmac_setup_ptp() now returns success without registering the clock when
> no rate is available. Should the else branch leave the core's -1 in place?
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 62c3441911e71..0cc6eafa19a3d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -653,7 +653,8 @@ static int stmmac_hwtstamp_set(struct net_device *d=
ev,
> >  	u32 ts_master_en =3D 0;
> >  	u32 ts_event_en =3D 0;
> > =20
> > -	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> > +	if (!priv->plat->clk_ptp_rate ||
> > +	    !(priv->dma_cap.time_stamp || priv->adv_ts)) {
> >  		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
> >  		priv->hwts_tx_en =3D 0;
> >  		priv->hwts_rx_en =3D 0;
>=20
> [Severity: Medium]
> Should the clk_ptp_rate requirement be applied to the peer sites of the
> same uAPI too?
>=20
> The set path now returns -EOPNOTSUPP when clk_ptp_rate is zero, while
> stmmac_hwtstamp_get() and stmmac_get_ts_info() were converted to
> stmmac_check_timestamp_cap(), which only tests dma_cap.time_stamp /
> dma_cap.atime_stamp.

I have not changed the logic in stmmac_get_ts_info() since I do not think i=
t is
required (priv->tstamp_config is set just in stmmac_set_ts_info()).

>=20
> On the configuration this patch newly declares supported (PTP-capable
> silicon, no PTP clock rate, so stmmac_setup_ptp() returns 0 without
> registering the PHC) ethtool -T still advertises
> SOF_TIMESTAMPING_TX_HARDWARE / SOF_TIMESTAMPING_RX_HARDWARE plus the full
> rx_filters list and SIOCGHWTSTAMP still succeeds, but every SIOCSHWTSTAMP
> is rejected.
>=20
> That state looks reachable at probe time, since stmmac_probe_config_dt()
> does:
>=20
> 	plat->clk_ptp_rate =3D clk_get_rate(plat->stmmac_clk);
>=20
> which yields 0 when the CSR clock lookup only warned and stmmac_clk is
> NULL and no ptp_ref clock is described.
>=20
> > @@ -843,7 +844,7 @@ static int stmmac_hwtstamp_get(struct net_device *d=
ev,
> >  {
> >  	struct stmmac_priv *priv =3D netdev_priv(dev);
> > =20
> > -	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
> > +	if (!stmmac_check_timestamp_cap(priv))
> >  		return -EOPNOTSUPP;
> > =20
> >  	*config =3D priv->tstamp_config;
> > @@ -866,11 +867,6 @@ static int stmmac_init_tstamp_counter(struct stmma=
c_priv *priv,
> >  {
> >  	struct timespec64 now;
> > =20
> > -	if (!priv->plat->clk_ptp_rate) {
> > -		netdev_err(priv->dev, "Invalid PTP clock rate");
> > -		return -EINVAL;
> > -	}
> > -
> >  	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
> >  	priv->systime_flags =3D systime_flags;
>=20
> [Severity: High]
> With this check moved out, does stmmac_init_tstamp_counter() still have a=
ny
> failure path left? The remainder is:

I will improve stmmac_init_tstamp_counter() error path in a subsequent patch

>=20
> 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
> 	priv->systime_flags =3D systime_flags;
>=20
> 	stmmac_update_subsecond_increment(priv);
>=20
> 	ktime_get_real_ts64(&now);
>=20
> 	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
>=20
> 	return 0;
>=20
> stmmac_update_subsecond_increment() is void and discards the status of
> config_addend(), and the int returned by the stmmac_init_systime() callba=
ck
> is dropped, so the function looks like it can only return 0.
>=20
> If that is the case, stmmac_init_timestamping() can only return 0 as well,
> and then the netdev_warn("PTP init failed") branch, the
>=20
> 	ret =3D stmmac_init_timestamping(priv);
> 	if (ret) {
> 		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> 		return ret;
> 	}
>=20
> block in stmmac_setup_ptp(), the goto error_stop_dma in stmmac_resume() a=
nd
> the whole new error_stop_dma label are unreachable.
>=20
> The failure named in the commit message ("the MAC system time counter is
> left in its post-reset, non-running state") is exactly what init_systime()
> reports:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c:init_systime() {
> 	...
> 	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
> 				 !(value & PTP_TCR_TSINIT),
> 				 10, 100000);
> }
>=20
> When that times out with -ETIMEDOUT, execution still reaches
> stmmac_ptp_register() and priv->ptp_enabled =3D true, so the interface co=
mes
> up with a stopped time base that TAPRIO/EST offload will arm against.
> Should the hwif return values be checked so the only genuinely propagated
> error is not just the clk_prepare_enable() one?

This change is part of a dedicated patch (the one containing
stmmac_init_tstamp_counter() error path changes) that I will post as follow=
-up

>=20
> > @@ -885,26 +881,37 @@ static int stmmac_init_tstamp_counter(struct stmm=
ac_priv *priv,
> >  	return 0;
> >  }
> > =20
> > +static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
> > +{
> > +	if (priv->plat->ptp_clk_freq_config)
> > +		priv->plat->ptp_clk_freq_config(priv);
> > +
> > +	if (!priv->plat->clk_ptp_rate) {
> > +		netdev_info(priv->dev, "PTP clock rate not configured\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * stmmac_init_timestamping - initialise timestamping
> >   * @priv: driver private structure
> > - * Description: this is to verify if the HW supports the PTPv1 or PTPv=
2.
> > - * This is done by looking at the HW cap. register.
> > - * This function also registers the ptp driver.
> > + *
> > + * Description: initialise the hardware timestamping counter, reset the
> > + * timestamping configuration and derive the advanced timestamping fla=
gs from
> > + * the HW capabilities. The caller must have ensured a valid PTP refer=
ence
> > + * clock rate (see stmmac_init_ptp_clk_freq()); the configured state i=
s valid
> > + * as long as the interface is open and not suspended, and this functi=
on is
> > + * re-run on resume.
> > + *
> > + * Return: 0 on success, a negative errno otherwise.
> >   */
> >  static int stmmac_init_timestamping(struct stmmac_priv *priv)
> >  {
> >  	bool xmac =3D dwmac_is_xmac(priv->plat->core_type);
> >  	int ret;
> > =20
> > -	if (priv->plat->ptp_clk_freq_config)
> > -		priv->plat->ptp_clk_freq_config(priv);
> > -
> > -	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
> > -		netdev_info(priv->dev, "PTP not supported by HW\n");
> > -		return -EOPNOTSUPP;
> > -	}
> > -
> >  	ret =3D stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
> >  					       PTP_TCR_TSCFUPDT);
> >  	if (ret) {
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but since the resume path is
> being reworked to re-run stmmac_init_timestamping() under
> if (priv->ptp_enabled), the hardcoded PTP_TCR_TSCFUPDT here reverts a
> devlink-configured coarse mode after every suspend/resume, while
> stmmac_dl_ts_coarse_get() keeps reporting the old value:

As pointed out by sashiko, this issue is not introduced by this patch and it
will be fixed with a dedicated patch.

Regards,
Lorenzo

>=20
> 	priv->tsfupdt_coarse =3D ctx->val.vbool;
> 	...
> 	ctx->val.vbool =3D priv->tsfupdt_coarse;
>=20
> The same function also does:
>=20
> 	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
> 	priv->hwts_tx_en =3D 0;
> 	priv->hwts_rx_en =3D 0;
>=20
> so an active SIOCSHWTSTAMP configuration is dropped across suspend as
> well. I see from the v4/v5 notes that the subsecond increment rework was
> deliberately deferred, so this is noted only for completeness.
>=20
> > @@ -937,24 +944,48 @@ static int stmmac_init_timestamping(struct stmmac=
_priv *priv)
> >  	return 0;
> >  }
> > =20
> > -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> > +static int stmmac_setup_ptp(struct stmmac_priv *priv)
> >  {
> >  	int ret;
> > =20
> > +	if (!stmmac_check_timestamp_cap(priv)) {
> > +		netdev_info(priv->dev, "PTP not supported\n");
> > +		return 0;
> > +	}
> > +
> >  	ret =3D clk_prepare_enable(priv->plat->clk_ptp_ref);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> >  		netdev_warn(priv->dev,
> >  			    "failed to enable PTP reference clock: %pe\n",
> >  			    ERR_PTR(ret));
> > +		return ret;
> > +	}
> > =20
> > -	if (stmmac_init_timestamping(priv) =3D=3D 0)
> > -		stmmac_ptp_register(priv);
> > +	if (stmmac_init_ptp_clk_freq(priv)) {
> > +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> > +		return 0;
> > +	}
>=20
> [Severity: Medium]
> This path makes "interface up with clk_ptp_rate =3D=3D 0 and clk_ptp_ref
> disabled" a supported state. Is the devlink runtime setter still safe in
> that state?
>=20
> stmmac_dl_ts_coarse_set() ("phc_coarse_adj", CAP_NET_ADMIN) has no
> clk_ptp_rate or ptp_enabled check:
>=20
> 	/* In Coarse mode, we can use a smaller subsecond increment, let's
> 	 * reconfigure the systime, subsecond increment and addend.
> 	 */
> 	stmmac_update_subsecond_increment(priv);
>=20
> and that helper divides by the rate:
>=20
> 	priv->default_addend =3D div_u64(temp, priv->plat->clk_ptp_rate);
>=20
> as does the hwif callback it invokes:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c:config_sub_second_i=
ncrement() {
> 	if (value & PTP_TCR_TSCFUPDT)
> 		data =3D (2000000000ULL / ptp_clock);
> 	else
> 		data =3D (1000000000ULL / ptp_clock);
> 	...
> }
>=20
> Devlink is only registered when clk_ptp_rate was nonzero at probe, but a
> platform ptp_clk_freq_config() callback can turn it into zero later, e.g.
>=20
> drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c:ethqos_ptp_clk_fr=
eq_config() {
> 	...
> 	plat_dat->clk_ptp_rate =3D clk_get_rate(plat_dat->clk_ptp_ref);
> }
>=20
> after which this return 0 (and the goto init_coalesce in stmmac_resume())
> keeps the interface and its registered devlink params alive. A subsequent
> devlink dev param set then divides by zero and programs PTP_SSIR/addend
> with clk_ptp_ref disabled. Should the rate requirement be extended to the
> devlink setter as well?
>=20
> > +
> > +	ret =3D stmmac_init_timestamping(priv);
> > +	if (ret) {
> > +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> > +		return ret;
> > +	}
> > +
> > +	stmmac_ptp_register(priv);
> > +	priv->ptp_enabled =3D true;
> > +
> > +	return 0;
> >  }
> > =20
> >  static void stmmac_release_ptp(struct stmmac_priv *priv)
> >  {
> > +	if (!priv->ptp_enabled)
> > +		return;
> > +
> >  	stmmac_ptp_unregister(priv);
> >  	clk_disable_unprepare(priv->plat->clk_ptp_ref);
> > +	priv->ptp_enabled =3D false;
> >  }
>=20
> [ ... ]
>=20
> > @@ -4161,10 +4192,12 @@ static int __stmmac_open(struct net_device *dev,
> >  	ret =3D stmmac_hw_setup(dev);
> >  	if (ret < 0) {
> >  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> > -		goto init_error;
> > +		return ret;
> >  	}
> > =20
> > -	stmmac_setup_ptp(priv);
> > +	ret =3D stmmac_setup_ptp(priv);
> > +	if (ret)
> > +		goto ptp_error;
> > =20
> >  	stmmac_init_coalesce(priv);
> > =20
> > @@ -4189,7 +4222,10 @@ static int __stmmac_open(struct net_device *dev,
> >  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> > =20
> >  	stmmac_release_ptp(priv);
> > -init_error:
> > +ptp_error:
> > +	stmmac_stop_all_dma(priv);
> > +	stmmac_mac_set(priv, priv->ioaddr, false);
> > +
> >  	return ret;
> >  }
>=20
> [Severity: High]
> This is a pre-existing issue that the patch does not introduce, but the n=
ew
> ptp_error return adds one more way to leave __stmmac_open() after
>=20
> 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
>=20
> has aliased priv->dma_conf to the caller's descriptor and page pool
> pointers. On the reopen path the caller then frees them:
>=20
> stmmac_change_mtu() {
> 	...
> 			free_dma_desc_resources(priv, dma_conf);
> 			kfree(dma_conf);
> 			...
> 			return ret;
> }
>=20
> __free_dma_rx_desc_resources() only clears buf_alloc_num and xsk_pool, so
> dma_rx/dma_erx, buf_pool and page_pool stay set in priv->dma_conf. Since
> the netdev remains netif_running() after a failed ndo_change_mtu, a later
> ip link set down runs:
>=20
> __stmmac_release() {
> 	...
> 	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
> 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> 	...
> 	free_dma_desc_resources(priv, &priv->dma_conf);
> }
>=20
> Can this free the same dma_free_coherent()/buf_pool/page_pool objects a
> second time? The ptp_error path also skips stmmac_init_coalesce(), so the
> txtimers in the freshly zeroed dma_conf were never passed to
> hrtimer_setup() before hrtimer_cancel() runs on them.
>=20
> [ ... ]
>=20
> > @@ -8346,14 +8381,19 @@ int stmmac_resume(struct device *dev)
> >  	ret =3D stmmac_hw_setup(ndev);
> >  	if (ret < 0) {
> >  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> > -		stmmac_legacy_serdes_power_down(priv);
> > -		mutex_unlock(&priv->lock);
> > -		rtnl_unlock();
> > -		return ret;
> > +		goto error_unlock;
> >  	}
> > =20
> > -	stmmac_init_timestamping(priv);
> > +	if (priv->ptp_enabled) {
> > +		if (stmmac_init_ptp_clk_freq(priv))
> > +			goto init_coalesce;
> > =20
> > +		ret =3D stmmac_init_timestamping(priv);
> > +		if (ret)
> > +			goto error_stop_dma;
> > +	}
> > +
> > +init_coalesce:
> >  	stmmac_init_coalesce(priv);
>=20
> [Severity: Medium]
> When priv->ptp_enabled is true and stmmac_init_ptp_clk_freq() fails here,
> the interface is resumed via init_coalesce with an info-level log only.
> Does that leave software and hardware state inconsistent?
>=20
> stmmac_hw_setup() has just done the DMA/MAC software reset, so PTP_TCR
> (TSENA), PTP_SSIR, the addend and the system time registers are back at
> reset values and the counter is stopped, yet:
>=20
>  - priv->ptp_clock stays registered and priv->ptp_enabled stays true, so a
>    PHC whose time never advances remains exposed to userspace
>  - stmmac_pltfr_noirq_resume() re-enables clk_ptp_ref because
>    ptp_enabled is true
>  - priv->hwts_tx_en/hwts_rx_en/systime_flags/sub_second_inc/default_addend
>    still describe the pre-suspend hardware configuration
>  - priv->plat->clk_ptp_rate stays 0 for the code that divides by it, e.g.
>    stmmac_update_subsecond_increment()
>=20
> The open path handles the same failure differently: it also disables
> clk_ptp_ref and leaves the PHC unregistered, so software and hardware
> agree. Should resume unregister the PHC and clear ptp_enabled instead of
> continuing?
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/dr=
ivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 6128ed1bd521a..19d4815544990 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>=20
> [ ... ]
>=20
> > @@ -984,6 +985,9 @@ static int __maybe_unused stmmac_pltfr_noirq_resume=
(struct device *dev)
> >  		if (ret)
> >  			return ret;
> > =20
> > +		if (!priv->ptp_enabled)
> > +			return 0;
> > +
> >  		ret =3D clk_prepare_enable(priv->plat->clk_ptp_ref);
> >  		if (ret < 0) {
> >  			netdev_warn(priv->dev,
>=20
> [Severity: Medium]
> This is a pre-existing issue rather than something the patch adds, but wi=
th
> the new gating the two flags can now disagree. If clk_prepare_enable() he=
re
> fails, the function returns the error with priv->ptp_enabled still true, =
so
> no PTP clock reference is held while the flag says one is.
>=20
> A later close or driver removal then passes the new gate in
> stmmac_release_ptp():
>=20
> 	if (!priv->ptp_enabled)
> 		return;
>=20
> 	stmmac_ptp_unregister(priv);
> 	clk_disable_unprepare(priv->plat->clk_ptp_ref);
>=20
> and calls clk_disable_unprepare() without a matching enable. Should the
> failure path clear priv->ptp_enabled?
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20260914-stmmac-ptp-error-propagate-v5-1-81149897e65d%40oss.qualcomm.com

--PT3V21VG+697wK/X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqrY8AAKCRA6cBh0uS2t
rJ3eAP9BIjZhtG4sskuvPZNvOry24AAitOSVQbiK5nrZZ4vUkwEAj+SXxwgtcVcx
LXyrZdiZ4V4bXWrZGh/vOQeCoRkFqQg=
=hIwK
-----END PGP SIGNATURE-----

--PT3V21VG+697wK/X--
