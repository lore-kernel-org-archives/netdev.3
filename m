Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF396442105
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943098; cv=none; b=ZCFM9IM858aBfL5zSCm1/lSxbJmgOw6vT2N0xZvDKGqvd8ixUwEaaIHiz6M0tBeyK7AcRatK0Gd1dVdXCoW3IqMvw8MFOdOZqyowOUzbzrBuKwsvxEXFgSceJe/Qm149EIbB60Sp4yXmxwRWVO80AuyrRCHzvEeIf5wYF6xVEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943098; c=relaxed/simple;
	bh=dRRXLXKKWNfD3FCli6Efmg2XdRxcLSMjitQvd9THfrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urh9+cOJpuKC3ESy8gd7zQtWcLD7zN1fPtmOH16SEvKaErYVTlkvrPwoUJx8+IxbJ6AQ+R8YhmcQaZVY6+bQe4PO2UC9dGqx7fp8CQQ07T13h/+tHH5YDOub+JkWXMhTQO9RBnilApxLGRR5KZ7l1Dax0p6hXQmbjD+Wko+mpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kE/H1Fre; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ArDwp3Ou; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kE/H1Fre";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArDwp3Ou"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896aLQZ3817269
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 08:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bMjWX5pavrydURXNQCtsJ9aw
	ujZ/D4pSSnWLXnJcWww=; b=kE/H1Fre5Ym2u4tFBHcjMzg1TPGxgQSmzRaIxOss
	eAMp9vGZGyysjTpXreCpyP9Dc8eNsYHilu8R71UDcq6u3yAsfvHu8SCbdkSZB7DF
	vQ/XsaBqmjQGiYBV0Aw+Yj9Vq8hmXWnC5OM1bCHxvTtpIMH1tUJ4Gmcpjtym32U1
	yXWF6snUDaFdjncKzSkQoVjYV+hXxGE79JTjpjO2LhMHmyHpCJER9eWqTK6JtWw1
	EST6GizioqYJF0Gi6u/87/GPnmlLoHFZFHMU3nZx2hvDLNzkpVpjJjv/3xgmHuDQ
	Z+tvNtpSrGIIaekrhT3P3MEl4bZTnSAYI/7DE9rIUWRrHw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjstuaa5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:38:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e820609d9so890632385a.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788943095; x=1789547895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bMjWX5pavrydURXNQCtsJ9awujZ/D4pSSnWLXnJcWww=;
        b=ArDwp3Ou5tX6dBvp6JI1PfK4Hy2aMOpDRvOOftCaZ+DAoXKBuUjtmb6+GND6U/kSHr
         BLb2auYEvn199hIw4BjF1bifBouPNVCknEgaCv0lY8dgr6eyNXxxeHAwMQwhF73w0z/b
         4pjUFKDyw4SCGDElxoVOQcJjhBVsqAaDCXWaMkhHpJ1VNw5YBlsMdRtR/Wttga7DhFzq
         v/3GiznPazlRPqvD7ii1cF/PFVooEeG+yBuVA5r4I/y65TE775ldByRvMrlmdGsbwFGE
         cGUH1F3n5m+WO7TzjXzYqXhbpJnUqV0r52FccGFATYVB8x78BySxMX599rjUMp3pO1MJ
         OIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788943095; x=1789547895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMjWX5pavrydURXNQCtsJ9awujZ/D4pSSnWLXnJcWww=;
        b=b9oj6NE4cypxNT3UfXbtbjwjALmDTZSxpvWQMQADQ9mEZdLJhxa8AeRZu4WYDzQVJS
         Lx3eJvLp1SPxd6kkYRRz9GT8vS3MeEuknh4PTqzHOSghN6jNem73pCKjT4jHUZgFUKit
         l+rGnSiVT0NKRGjmZmYPdCbVCpeNaxHt3WUJgxmQKJ5WOZVLmsjo5uWXb/YwBFLVlYam
         ZBq+bUNPzdnsiGFF1opEfNRCqmgk61XZtDDSHR6ssqJDbo8COKVA7qSkmvjVhKUS8fam
         JViJyCay6b2zzmu9pWAgDC+OHgnPbu9P0vsfqVZJuJj5CsjrDnv7rFF7//y9ho7Mg9vq
         lcBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx66He3u16Hc1QsKhlE2H07DUhNIG2RbWrSbMd+6KueYkDgY2ubnFBXLnlLRh5UUGLIWkQ4PyU=@vger.kernel.org
X-Gm-Message-State: AFuF++nT9ZjtuXz+q+GMtJCRzzuKW5KoXhpiS3l3/SHHDjUee53jIKB7
	iNmxNVGjd8IoE8cfVrzqZ0RPAOr0Ra/fmg/DT4X8HqkyO/BLH1i6GDDlnGSFdhW9cxByWpaa6LS
	z8YsyBgSCIj1zxogmp76BaOGDsWTOA6oxvNo3cdmy/EQ6Pa3FifoqVIqn0Cs=
X-Gm-Gg: AYBFou1eahLRwAaB29otu6NeTCZMMQ0ERssqZwh3nLyDN3u1DwrX5xtNCY9iy4HErKO
	zcnxGnwuAet9jTRYLJWSJPUIatMLmNQOY62MR3l0c5ua9c4rimtLf6TmOWVPG8lSHTwBGKneWfH
	2Dzi47OrR9rNfma0qE9y8d61vd+bUkZEJhqcB10kK9izEjO+JGUq9k73GYAtlv2CMOowtljWUo4
	2bp0i+V1Hh/09fMYJK1U4nT+Vo3H/jrAwN6K6uDPKfopyMGGro1m/fbpK8U98rlUSsXxr/S5LNo
	kNpTEKgKpsT/RehohqZ0rXN6jZuCi7Kzoz1afQou2YVWRvZvNfpVyGTFbM6FfMROH/0u8hhZ9JY
	066CReUjCZx0nMg==
X-Received: by 2002:a05:620a:bc5:b0:939:6de4:3e04 with SMTP id af79cd13be357-93980400918mr4146020885a.29.1788943094758;
        Wed, 09 Sep 2026 01:38:14 -0700 (PDT)
X-Received: by 2002:a05:620a:bc5:b0:939:6de4:3e04 with SMTP id af79cd13be357-93980400918mr4146014585a.29.1788943094102;
        Wed, 09 Sep 2026 01:38:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm36312242f8f.19.2026.09.09.01.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:38:12 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:38:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, Jose.Abreu@synopsys.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: initialize ptp_lock at probe time
Message-ID: <aqEa83wUlsn8XvO9@lore-desk>
References: <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
 <178890689580.219967.13444061926951235815@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Nhkga0lfi66/HXt"
Content-Disposition: inline
In-Reply-To: <178890689580.219967.13444061926951235815@kernel.org>
X-Authority-Analysis: v=2.4 cv=ItAutr/g c=1 sm=1 tr=0 ts=6aa11af7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9R54UkLUAAAA:8 a=EeFZAZPpTBPm1tKgb9AA:9 a=QEXdDO2ut3YA:10
 a=FM_-4msm2eu4xFHii-gA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA5NSBTYWx0ZWRfXyf9TXJnEtWfl
 AHicFJfFO0Shs2eOrKg721SqJ7SA6j12E7AgCxM8TitRIEo52HSqfga/wP+9j+WgYgSpxWbIFXK
 kxgc6M5+yXrFgxBHPU/Xpe90ok/Mmcw=
X-Proofpoint-ORIG-GUID: xGko3z7oyatL-mKZyhrTzK-iPK0f_NGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA5NSBTYWx0ZWRfXy0PoSpqNVjIt
 Vwm4qa0TG7TOugre16R2Vq7hGRWPW8LOqZEpOjsWrWR+BJ1NzyPQQAGuKteb8e1rdPYcEeTIKDY
 oToKR3UliIHXMK2XvhThYicHlw2Ta7ILVd8yYdakmTg3groXgClIYjDiLpfr4YsAnj4qHTl+fzo
 r9CbDpgwHKHbu7N1NvDXh+XLaFv7zUeY3DBMTVy6wFiZtLZsJrYW+0WCrfhZp9jRY0+O1wYGf8V
 tutNQ1/RM2OLjF/D7d/lMmv2c8LEmL1sewJlzQ0+IR1y5HViY9su21nJnPKtstrs2PP1cb+Hefd
 U10tHVuPGO2pkKt2gMSI0ZTCF6hNUhCUuO82eHQuReNCCr1KhW5HMx411+Pk0MEHXjqGD0t62LQ
 fpJ7Z021ijSjr/3BATUAvBVcATGHsH/PF1fsI6QpMBpn5+Hxlg/3A0P0DlxCOYPV18EJXP62xOQ
 rGCaBS2IEDLLYvYF2aA==
X-Proofpoint-GUID: xGko3z7oyatL-mKZyhrTzK-iPK0f_NGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090095

--9Nhkga0lfi66/HXt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 08, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (2) =C2=B7 Low: 0
>=20
> - [High] Incomplete fix: the TAPRIO offload path that this commit
>   legitimizes for a never-opened interface still performs MMIO on a=E2=80=
=A6
>=20
> Pre-existing issues:
> - [Medium] EST state (priv->est->enable, priv->est->gcl[]) is accessed
>   with inconsistent locking between the taprio offload path and the PTP=
=E2=80=A6
> - [Medium] An EST/taprio schedule programmed while the interface is down
>   is silently discarded by the MAC/DMA software reset performed at open,=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: initialize ptp_lock at probe time
>=20
> This moves rwlock_init(&priv->ptp_lock) from stmmac_ptp_register() to
> __stmmac_dvr_probe() so that the lock is initialized even when the
> interface has never been opened, which is the case when tc_taprio_configu=
re()
> calls the PTP gettime64() callback to compute the EST base time.
>=20
> No Link: tags present in the commit header.
>=20
> A few questions about the paths this touches.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 24656b35350b1..5fe7e95fdd345 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -8025,6 +8025,7 @@ static int __stmmac_dvr_probe(struct device *devi=
ce,
> >  	stmmac_napi_add(ndev);
> > =20
> >  	mutex_init(&priv->lock);
> > +	rwlock_init(&priv->ptp_lock);
>=20
> [Severity: High]
> The commit message describes the down-interface gettime64() call as a
> legitimate use ("the lock is also used while the interface is down and has
> never been opened").  Is that call safe once the lock is initialized?
>=20
> __stmmac_dvr_probe() ends with pm_runtime_put(), and
> stmmac_runtime_suspend() in stmmac_platform.c gates the CSR clocks:
>=20
> 	stmmac_bus_clks_config(priv, false);
> 	  clk_disable_unprepare(priv->plat->stmmac_clk);
> 	  clk_disable_unprepare(priv->plat->pclk);
>=20
> So a probed-but-never-opened device is runtime suspended.  The taprio
> offload path does not take a runtime-PM reference and does not check
> netif_running():
>=20
>   stmmac_setup_tc()  case TC_SETUP_QDISC_TAPRIO
>     tc_setup_taprio()
>       tc_taprio_configure()
>         priv->ptp_clock_ops.gettime64()  ->  stmmac_get_time()
>                                                stmmac_get_systime(priv->p=
tpaddr)
>         stmmac_est_configure()           ->  writes/polls priv->estaddr
>=20
> Every other register-touching ndo in this driver wraps the access in
> pm_runtime_resume_and_get(), for example stmmac_set_mac_address(),
> stmmac_vlan_rx_add_vid(), stmmac_vlan_rx_kill_vid() and __stmmac_open().
> Can the MMIO in stmmac_get_systime() and est_configure() read/write a
> clock-gated MAC/PTP block here, and on SoCs that actually gate pclk, can
> that abort or stall?

The goal of this patch is just fixing the undefined behaviour due to the
uninitialized rwlock. Moreover, the reported issue is fixed in the following
patch (not merged yet):
https://lore.kernel.org/netdev/20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8=
a5948f41@oss.qualcomm.com/

>=20
> There is a second aspect to the same call.  The PTP counter is only
> programmed from the open path:
>=20
>   __stmmac_open()
>     stmmac_setup_ptp()
>       stmmac_init_timestamping()
>         stmmac_init_tstamp_counter()   /* TCR enable, SSINC, init systime=
 */
>=20
> If the interface was never opened, does gettime64() return a usable time
> base, and does stmmac_calc_tas_basetime() then program priv->est->btr[]
> from a meaningless value?
>=20
> Would it make sense to gate TC_SETUP_QDISC_TAPRIO on netif_running() (or
> on the PTP counter being started), and/or take a runtime-PM reference in
> stmmac_setup_tc(), in addition to moving the rwlock_init()?  Reproducer
> is "tc qdisc replace dev ethX root taprio ... flags 0x2" on an interface
> that has never been brought up; taprio_enable_offload() in
> net/sched/sch_taprio.c has no netif_running() gate.
>=20
> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but since
> the change makes the down-interface configuration sequence easier to
> reach it seems worth mentioning.  Is an EST schedule programmed while the
> interface is down preserved across open?

This issue is not introduced by this patch and it is already fixed in the
following series (not merged yet):
https://lore.kernel.org/netdev/20260902-stmmac-est-reapply-after-open-v3-0-=
e72a6df5a7ef@oss.qualcomm.com/

>=20
> tc_taprio_configure() commits priv->est->enable, btr[]/ctr[] and
> max_sdu[] and pushes them to hardware via stmmac_est_configure().  Then
> open does:
>=20
>   __stmmac_open()
>     stmmac_hw_setup()
>       /* DMA initialization and SW reset */
>       stmmac_init_dma_engine(priv);
>=20
> which asserts DMA SWR and resets the MAC/MTL registers, including
> MTL_EST_CONTROL, the GCL RAM and BTR/CTR.  stmmac_est_configure() has no
> call site in stmmac_main.c (only tc_taprio_configure() and the disable
> label in stmmac_tc.c, plus stmmac_adjust_time() in stmmac_ptp.c), and
> taprio_dev_notifier() in net/sched/sch_taprio.c only recomputes
> picos_per_byte/max_sdu on NETDEV_UP rather than re-issuing the offload.
>=20
> Does that leave priv->est->enable true with EST disabled in hardware,
> while stmmac_xmit(), stmmac_xdp_xmit_back() and the XSK path keep
> enforcing priv->est->max_sdu[] and the taprio dump reports an active
> offloaded schedule?
>=20
> > =20
> >  	stmmac_fpe_init(priv);
> > =20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index 960249960004c..3bfcc9760dce7 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > @@ -365,7 +365,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
> >  	if (priv->plat->crosststamp)
> >  		priv->ptp_clock_ops.getcrosststamp =3D stmmac_getcrosststamp;
> > =20
> > -	rwlock_init(&priv->ptp_lock);
>=20
> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but while
> looking at the locking in this file: is the est_lock coverage of
> priv->est consistent between the taprio path and the adjtime path?

This issue is not introduced by this patch and it is already fixed in the
following series (not merged yet):
https://lore.kernel.org/netdev/20260902-stmmac-est-reapply-after-open-v3-0-=
e72a6df5a7ef@oss.qualcomm.com/

Regards,
Lorenzo

>=20
> In stmmac_adjust_time() the decision is taken with no lock held:
>=20
> 	/* If EST is enabled, disabled it before adjust ptp time. */
> 	if (priv->est && priv->est->enable) {
>=20
> and it is acted upon later, after est_lock has been taken again, where
> priv->est->enable is set back to true and stmmac_est_configure() is
> called.
>=20
> Meanwhile tc_taprio_configure() publishes the new size and enable flag
> under the lock:
>=20
> 	mutex_lock(&priv->est_lock);
> 	priv->est->gcl_size =3D size;
> 	priv->est->enable =3D qopt->cmd =3D=3D TAPRIO_CMD_REPLACE;
> 	mutex_unlock(&priv->est_lock);
>=20
> but fills the entries with the lock dropped:
>=20
> 		priv->est->gcl[i] =3D delta_ns | (gates << wid);
>=20
> tc_taprio_configure() runs under rtnl from ndo_setup_tc while
> stmmac_adjust_time() runs from PTP_CLOCK_ADJTIME on /dev/ptpX without
> rtnl, so the two can run concurrently.
>=20
> Can an adjtime landing in that window make stmmac_est_configure()
> program the hardware gate list from a partially written gcl[] with the
> new gcl_size already visible?
>=20
> And can a "tc qdisc del" that clears enable and takes the disable: path
> be undone by a concurrent adjtime that re-enables EST from its stale
> unlocked observation?
>=20
> >  	mutex_init(&priv->aux_ts_lock);
> > =20
> >  	priv->ptp_clock =3D ptp_clock_register(&priv->ptp_clock_ops,
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d%40oss.qualcomm.com

--9Nhkga0lfi66/HXt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqEa9AAKCRA6cBh0uS2t
rDqwAQDQMTlh0BeXlsV2l5nbvkLul3MQW0q4Z0f/itQmzcAB8AEAhGxUkFWINm6y
QbZs7pwaBlqNBLk7VBbgQiXK/wGd8AQ=
=tgYq
-----END PGP SIGNATURE-----

--9Nhkga0lfi66/HXt--
