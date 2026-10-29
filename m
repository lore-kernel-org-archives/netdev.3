Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267727;
	b=y5XBlQ2JegU/J1BpOrHdKhr0HinO+0BD8st9BYy8s93U5wZlTkzAgwgciqo2G41NTn2z
	 iYDqfuzK4PaWcd6PXCn+TzWb17j5hJW/21KxSM3tNBX9zZ1c05rW0rz0AY6gcHIHq2dQ6
	 EEyoL2jB6bAb9USALszQ09hIvq/AiOw2iPst8WMnHykPRO3j6ZJd7AkHNP9osswJAQevM
	 mH24NmRR/CC1O+iCNfzrX3m+eVQXr7VixmxdY2+69S0jolRZ4NEZbvCXDmDs1g1dBeonG
	 Z1Si+3TKqH5Ze01ttyDSbFzOkf2W9utnUj5/zkjP0mQ5EFAkWbBUyFrK4aFMkJ/ARQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kPMrNR5XuqrD2/EsiVlrT5xfK46VmBxcrpdSODzCzU4=;
	b=Z4772Z0xw3XJ6HAKUr4i73o/keHf2kS4XNUZQlsYRRqheqgUlOVmV0WthuWAbxEIXQJj
	 BcWJHZ0utRN8wBZhroGfQY/ObW2srAojOyvo/yVv50wbyvUGh69BcpPebXFCVOAN0DgED
	 //1jApJbzRji5lHlRpxuElCGfAiKZIOh5IuMzGvqi1EsWo80Q39P0krIP30wlQaapU3ID
	 2Rkki8XFdbWAsrtPURu2fHXhrk/L2kpffNeuezFxOwrMvQoWKQBKBy6wCs+EdBh7bo3MK
	 emINehIcu5eEusLsy2P56/IUxLQTEAD5eIgH55L+PmPWUWZAX9XZGNmiOHHP/z3im9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pmotw7g5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UbtkKFgf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D0606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pmotw7g5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UbtkKFgf
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8v9YL659632
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kPMrNR5XuqrD2/EsiVlrT5xf
	K46VmBxcrpdSODzCzU4=; b=Pmotw7g5ljQf0pNzL8oDHKK8kaqdYfpJQMAr9Eq8
	meyQBnFtCPLf49y0ayFCQ6ymilkYN8oweVVQ4doK3er5e0unXeCPKBKs3IQ71J/F
	0QzRxEcogax8rmVyclTdUHr3EAcj/nhrkGODEcAOjIc2Y3/rsQm6DisUqmcqoxX1
	WHTQn0s9KJ7wbKExi9Tv4gZIDZI9WS0nodEmnN3VcgwuOTr5vEgsDUlX0kWCw4Tm
	JGKD33WeTge0coSjyP0hjWPWEh62g4CO+3VAQWQTChkozjaFePvC7mcD/qOwtOvF
	VLfVMY92BjbpTFxSf77Z3HjV0Iy8vvryLi8Ka5q5wBzp9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehv12x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:55:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-944138ed63fso122056685a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793267720; x=1793872520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kPMrNR5XuqrD2/EsiVlrT5xfK46VmBxcrpdSODzCzU4=;
        b=UbtkKFgfkZfZ0saYiH3eo9QooYLIqtkAGQu33Stflpfi538c+Uu9EFBNG/pyUB62Q6
         SdGuzsa8VzTpyiEOqGoddCa2Nc6xmP6eDUEhEjQkAvUn+OFmnSvQJyzGpaYDVYbduFQS
         F5KIiPkuucFBXOj8Con8A4Qgkhh4nMuKr+EfkKM5R2MWBfav0MYxmxeFyOwTVbf+OIb7
         Qdp5CXpmP24Q/NSGN27fSv7OVYFJJ4U2Kq6oKjQyvjKxAAtm46CS4n1qILxQfLwVLPBq
         Fxk5sLYuIrrBh7o3DoSF9w5VYGdGwe7TAhBMdEZxxQoHZNEN90DD+VewnK759rwyNINd
         BWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267720; x=1793872520;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPMrNR5XuqrD2/EsiVlrT5xfK46VmBxcrpdSODzCzU4=;
        b=EumJNTR2cHhCq2/9c0wtbF2jO3FFZIOuxJeZSp6BGCs2xzcGFI5DbjVrve9csMAidN
         Swsh8icnaHfEJxgsZZ9ztvHbjPnywZTYP/IezLFX8++Ipxo+DeEAT0DeoI944BQ/f7vA
         rH9/tBuesFPcHm44JS8cgF9kLKu19KJokKNtRVkbq5TvHKnWZWpcTEm2YUJ7tJjD2zkS
         LJ3870XMqvW52TxtJ9C5iOmEUeZOY+AWpw8hqdUozyVDWIrcwmv6o5QMZUvcw1Ek8U5C
         BtVudOaTT6Kv8t0Y7WeyIOyEnSM3wY7L8PRUNxwQhql5/0ASIkNEM/DUVq2lL+rJtpsp
         Ddgw==
X-Forwarded-Encrypted: i=1; AKwUvByo8eZjr3ZOpQyVtiHjUx0TOa5GWhrB4LhnozSfhgaq0t04mulq6aidxMxd/B3IQVo7a5oT8B8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBUDLAApPBr/z3N4NjRVC6GD5zZXXHA27ppFkl+0y9QNQAanT0
	DJEg8pDobGxgE4TPD1+XZLSy+K7ZuEJubcjVpNuA6Ntbz0SSA2NwjyseRyH87mwLEqUO7CfZlz2
	O7/fpEtct77yAC/yrlz42kpB4KyetNcavjFSsMeFPyHFVJx58srYPwfhyYSg=
X-Gm-Gg: AYBFou2g5Oixy+z8OeNvxiLvXAi9zKH0/rlfI2A8bXRGdo4217UlFlTBsYVzNehfnXf
	vP3RVSeZJdxilqc/ByJkN/nE7uvLpIKfJbhQHODxt3j/cus4O6Shp+Ff7y1EPP+VEEWOYym502X
	CyOb6QuDRCAGgfUSEnd9yti1DR12dF+eWpbC3ZxD/7ZX8njYHNktUeAjg9DBiEOrwITeEXmGPrY
	shQHF1jhN4svCVjHc3Uk+bV5Vt127vvsa7YpRFhmyU6Q8T+K5pB9GphVsDX6864Rlmzb9oqSi6d
	/TcHYZue3eraSufVXuw7Wqmr7MXyl8xS9qFcNHIwA3dPMlA3qhpN1WqZr7roXldKMobwdKtpiNV
	ZzpZ2GiGimioWi9Xa8cpBdH8Yjut1IpLZ+E7XjhR4bGIithbuYv/4wy+//ZM97TV1HG+8I62g4G
	vYZg2AK1JSFxFgDw6sTaSaYw==
X-Received: by 2002:a05:620a:31a1:b0:93c:ba44:673d with SMTP id af79cd13be357-94408a71711mr719386085a.23.1793267719476;
        Thu, 29 Oct 2026 02:55:19 -0700 (PDT)
X-Received: by 2002:a05:620a:31a1:b0:93c:ba44:673d with SMTP id af79cd13be357-94408a71711mr719379685a.23.1793267718655;
        Thu, 29 Oct 2026 02:55:18 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f25fsm32594807f8f.2.2026.10.29.02.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:55:17 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:55:16 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, linux@armlinux.org.uk,
        Jose.Abreu@synopsys.com, james.hilliard1@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rayagond@vayavyalabs.com
Subject: Re: [PATCH net v4 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Message-ID: <auMYBOj_y_Z-AXjO@lore-desk>
References: <20261026-stmmac-est-fixes-v4-3-999dac4de44f@oss.qualcomm.com>
 <179326067100.3134.15863707026342807337@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mG7OudezMBGU53l"
Content-Disposition: inline
In-Reply-To: <179326067100.3134.15863707026342807337@kernel.org>
X-Proofpoint-ORIG-GUID: i676S2gHHh5BgkqSF1NX5HgBgXfqO4qs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzOCBTYWx0ZWRfX/jrOzRMHHljw
 dnAtcdJLhx+Pn/760uXPRuTUMkXPHmeg3SQtX1xT5DvgNcVqGAX5iunrCXeJpYGqxJQ4QpDn36k
 LO5W5/oOdDv8+bZdaoejAQ2PV9GH50I18yDjIcDD5TUZG5mJWbEr8a+dEoKclJLKE6Lab6VESi8
 KuVr9tIs9QkpJVRFHNIDaPUg8abe+Gk7BMhFzRVD0Ov3cE0a9YY1uFNzkHYZrBGrq6rd486JkMJ
 78niebZQ+iTCh2Utc6Uw8AADM4EldOntt/Mp9wHPdc897PAJZCVnV/ChDILd1272BgDNIwSBhAx
 HxuCUt6a70t+lhn8WfKiHdV8GZrUFyIm1C5+GhS4XSiQyCPxa3/K6L6c1ZUd/xRxeD1C+4wm9Si
 N4kLBFelrnkvRrMTQOyT0YHvoJbXi3zNAglw2HCfUUf03DDh8PZGMM+RvWlGlH5ggR3GtBh2yqA
 /ftB+nJKAHqyyCAae0g==
X-Proofpoint-GUID: i676S2gHHh5BgkqSF1NX5HgBgXfqO4qs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzOCBTYWx0ZWRfX8DP+DsC1lKed
 h5T62BHmK8BlUY8vgTtWOuUzmk9ilUMJYytwlzk8LuYFgkw9Ni+DzSPNwVQrxwGqAFDPSn/BTW3
 i6PnHOvMh1SeV2EhPgsvedSTubtZwXA=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae3180d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=P5ZTCZ6uBUcQaEklmTEA:9 a=QEXdDO2ut3YA:10
 a=qjOxD71wWHld8yX8xuoA:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290038

--7mG7OudezMBGU53l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 4 =C2=B7 Low: 0 (1)
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The patch says it re-applies "the taprio offload" after the
>   core soft reset, but it only replays the EST block.
> - [Medium] The patch handles a failed EST re-apply inconsistently between
>   open and resume.
> - [Medium] A taprio REPLACE that is rejected only by the software checks
>   in dwmac5_fpe_map_preemption_class() still tears down the installed=E2=
=80=A6
> - [Medium] stmmac_adjust_time() checks and clears priv->est->enable in
>   one est_lock section (stmmac_ptp.c:72-79), drops the lock while it=E2=
=80=A6
>=20
> Pre-existing issues:
> - [Low] The TX hot paths (stmmac_xmit around stmmac_main.c:4861,
>   stmmac_tso_xmit, the XSK zero-copy path around 2753, and=E2=80=A6
>=20
> --
>=20
> net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume=
()
>=20
> The core soft reset in stmmac_hw_setup() clears the MTL_EST registers. Th=
is
> patch re-programs EST from __stmmac_open() and stmmac_resume(), recomputi=
ng
> the base time from the reserved base time and the current PTP time, and
> reuses the same helper in stmmac_adjust_time(). It also reworks
> tc_taprio_configure() to hold est_lock across validation and programming,
> and to set priv->est->enable only after hardware programming succeeds.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_est.h
> > index f70221c9c84af..0f0f162794c84 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
>=20
> [ ... ]
>=20
> > @@ -65,3 +68,18 @@
> >  #define EST_GCL_DATA			0x00000034
> > =20
> >  extern const struct stmmac_est_ops dwmac510_est_ops;
> > +
> > +int __stmmac_setup_est(struct stmmac_priv *priv);
> > +static inline int stmmac_setup_est(struct stmmac_priv *priv)
> > +{
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&priv->est_lock);
> > +	if (priv->est && priv->est->enable)
> > +		ret =3D __stmmac_setup_est(priv);
>=20
> [Severity: Medium]
>=20
> The commit message says this re-applies "the taprio offload" after the co=
re
> soft reset. Does stmmac_setup_est() restore everything that taprio
> programmed, or only the EST block?
>=20
> On a successful TAPRIO_CMD_REPLACE, tc_taprio_configure() also calls:
>=20
> 	ret =3D stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
> 					      qopt->mqprio.preemptible_tcs);
>=20
> On GMAC5, dwmac5_fpe_map_preemption_class() writes FPE_MTL_PREEMPTION_CLA=
SS
> in GMAC5_MTL_FPE_CTRL_STS. On XGMAC, dwxgmac3_fpe_map_preemption_class()
> also writes the per-queue XGMAC_Q2TCMAP field and XGMAC_MTL_FPE_CTRL_STS,
> even when pclass is 0. During stmmac_hw_setup(), dwxgmac2_dma_tx_mode() t=
hen
> rewrites Q2TCMAP back to the channel index:
>=20
> 	value |=3D FIELD_PREP(XGMAC_Q2TCMAP, channel);
>=20
> preemptible_tcs is not saved in priv, and stmmac_fpe_map_preemption_class=
()
> is only called from stmmac_tc.c. That means neither __stmmac_open() nor
> stmmac_resume() can replay it.
>=20
> So what happens after ifdown/ifup, an MTU or ring size change, or
> suspend/resume? On GMAC5, would the preemptible TCs silently turn into
> express TCs? On XGMAC, would the queues go back to the default queue =3D=
=3D TC
> mapping, so the EST gate masks no longer cover the intended queues?
>=20
> Meanwhile __stmmac_setup_est() sets priv->est->enable =3D true, so taprio
> would keep reporting the full offload as installed.

I will fix it in v5.

>=20
> > +	mutex_unlock(&priv->est_lock);
> > +
> > +	return ret;
> > +}
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 9e09e11cc35e5..a13a3790207d5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>=20
> [ ... ]
>=20
> > @@ -4201,6 +4202,10 @@ static int __stmmac_open(struct net_device *dev,
> >  	if (ret)
> >  		goto ptp_error;
> > =20
> > +	ret =3D stmmac_setup_est(priv);
> > +	if (ret)
> > +		goto est_error;
> > +
> >  	stmmac_init_coalesce(priv);
> > =20
> >  	phylink_start(priv->phylink);
>=20
> [ ... ]
>=20
> > @@ -8518,6 +8523,10 @@ int stmmac_resume(struct device *dev)
> >  		ret =3D stmmac_init_timestamping(priv);
> >  		if (ret)
> >  			goto error_stop_dma;
> > +
> > +		ret =3D stmmac_setup_est(priv);
> > +		if (ret)
> > +			goto error_stop_dma;
> >  	}
> > =20
> >  init_coalesce:
>=20
> [Severity: Medium]
>=20
> The callers seem to handle a failed EST re-apply in different ways. There
> are a few cases.
>=20
> In __stmmac_open(), stmmac_setup_ptp() can return 0 without enabling PTP:
>=20
> stmmac_setup_ptp() {
>     ...
> 	if (stmmac_init_ptp_clk_freq(priv)) {
> 		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> 		return 0;
> 	}
>     ...
> }
>=20
> This can happen when clk_ptp_rate is 0. For example, qcom-ethqos re-reads
> clk_get_rate() in ethqos_ptp_clk_freq_config() on every open, so the rate
> can become 0 after an earlier successful taprio REPLACE.
>=20
> stmmac_setup_est() still runs in that case. __stmmac_setup_est() reads the
> time through gettimex64 with the timestamp counter never initialised, and
> est_configure() returns -EINVAL for a zero ptp_rate. Wouldn't ndo_open th=
en
> fail, where it succeeded before this patch?
>=20
> In stmmac_resume(), any EST programming error (for example -ETIMEDOUT from
> est_write()) now goes to error_stop_dma. That path stops DMA, disables the
> MAC, powers down the serdes and returns without calling
> netif_device_attach(), while netif_running() is still true. Is it intended
> that losing EST now leaves the interface dead after resume?
>=20
> Also in stmmac_resume(), when stmmac_init_ptp_clk_freq() fails, the code
> jumps to init_coalesce and skips stmmac_setup_est(). Resume then returns
> success with priv->est->enable still true, even though the soft reset has
> cleared MTL_EST. Isn't that the stale state the commit message says it
> removes?
>=20
> When __stmmac_setup_est() fails, it returns without clearing
> priv->est->enable:
>=20
> 	if (err) {
> 		netdev_err(priv->dev, "failed to re-configure EST\n");
> 		return err;
> 	}
>=20
> For the open and resume callers the flag was already true on entry. It
> stays true while EEST is off or only partly programmed. The commit message
> says the helper "only marks the offload enabled once the hardware
> programming succeeds". Does that hold for these callers?
>=20
> Finally, stmmac_adjust_time() ignores the return value of the same helper.
> Should the three callers share one failure policy?

I will fix it in v5.

>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index 9a32af00d7d2d..81ee896698653 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>=20
> [ ... ]
>=20
> > @@ -69,14 +69,14 @@ static int stmmac_adjust_time(struct ptp_clock_info=
 *ptp, s64 delta)
> >  	nsec =3D reminder;
> > =20
> >  	/* If EST is enabled, disabled it before adjust ptp time. */
> > +	mutex_lock(&priv->est_lock);
> >  	if (priv->est && priv->est->enable) {
> >  		est_rst =3D true;
> > -		mutex_lock(&priv->est_lock);
> >  		priv->est->enable =3D false;
> >  		stmmac_est_configure(priv, priv, priv->est,
> >  				     priv->plat->clk_ptp_rate, false);
> > -		mutex_unlock(&priv->est_lock);
> >  	}
> > +	mutex_unlock(&priv->est_lock);
> > =20
> >  	write_lock_irqsave(&priv->ptp_lock, flags);
> >  	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
> > @@ -84,31 +84,9 @@ static int stmmac_adjust_time(struct ptp_clock_info =
*ptp, s64 delta)
> > =20
> >  	/* Calculate new basetime and re-configured EST after PTP time adjust=
=2E */
> >  	if (est_rst) {
> > -		struct timespec64 current_time, time;
> > -		ktime_t current_time_ns, basetime;
> > -		u64 cycle_time;
> > -
> >  		mutex_lock(&priv->est_lock);
>=20
> [ ... ]
>=20
> > -		ret =3D stmmac_est_configure(priv, priv, priv->est,
> > -					   priv->plat->clk_ptp_rate, true);
> > +		__stmmac_setup_est(priv);
> >  		mutex_unlock(&priv->est_lock);
> > -		if (ret)
> > -			netdev_err(priv->dev, "failed to configure EST\n");
> >  	}
>=20
> [Severity: Medium]
>=20
> est_lock is dropped between clearing priv->est->enable and calling
> __stmmac_setup_est() here. est_rst is not re-checked once the lock is tak=
en
> again. Can a taprio operation that runs inside that window get overridden?
>=20
> ptp_clock_adjtime() does not take RTNL, so this ordering looks possible:
>=20
> CPU1 (stmmac_adjust_time)
>   mutex_lock(&priv->est_lock);
>   est_rst =3D true;
>   priv->est->enable =3D false;
>   mutex_unlock(&priv->est_lock);
>   stmmac_adjust_systime();
>=20
> CPU2 (tc_taprio_configure, TAPRIO_CMD_DESTROY)
>   mutex_lock(&priv->est_lock);
>   priv->est->enable =3D false;
>   stmmac_est_configure(..., false);
>   stmmac_fpe_map_preemption_class(..., 0);
>   mutex_unlock(&priv->est_lock);
>=20
> CPU1
>   mutex_lock(&priv->est_lock);
>   __stmmac_setup_est(priv);
>     stmmac_est_configure(..., true);
>     priv->est->enable =3D true;
>=20
> A REPLACE that fails and goes to disable: would race the same way.
>=20
> The disable: path leaves gcl, ctr, btr_reserve and max_sdu[] in priv->est.
> Would the old schedule, or the rejected one, then be programmed back into
> hardware with enable set to true after the qdisc offload is gone? If so, =
the
> TX/XDP paths would keep dropping frames larger than the stale max_sdu[].
>=20
> __stmmac_open() and stmmac_resume() now trust that flag, so the schedule
> would also be re-armed on every ifup and resume. taprio would not send
> another DESTROY because q->offloaded is already false.
>=20
> Should the decision to re-enable be re-validated under est_lock before
> __stmmac_setup_est() is called?

I will fix it in v5.

>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index ac926c60f9f9a..95c5f6100c66a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>=20
> [ ... ]
>=20
> > @@ -1060,13 +1065,26 @@ static int tc_taprio_configure(struct stmmac_pr=
iv *priv,
>=20
> [ ... ]
>=20
> > -		priv->est->gcl[i] =3D delta_ns | (gates << wid);
> > +		gcl[i] =3D delta_ns | (gates << wid);
> >  	}
> > =20
> > -	mutex_lock(&priv->est_lock);
> > +	if (!priv->est) {
> > +		priv->est =3D devm_kzalloc(priv->device, sizeof(*priv->est),
> > +					 GFP_KERNEL);
> > +		if (!priv->est) {
> > +			ret =3D -ENOMEM;
> > +			goto error_unlock;
> > +		}
> > +	} else {
> > +		memset(priv->est, 0, sizeof(*priv->est));
> > +	}
>=20
> [Severity: Low]
>=20
> This is a pre-existing issue and was not introduced by this patch. The TX
> hot paths read priv->est, priv->est->enable and priv->est->max_sdu[] with
> plain loads and without est_lock. For example, in stmmac_xmit():
>=20
> 	if (priv->est && priv->est->enable &&
> 	    priv->est->max_sdu[queue]) {
>=20
> stmmac_tso_xmit(), stmmac_xdp_xmit_zc() and stmmac_xdp_xmit_xdpf() do the
> same.
>=20
> The writers hold only est_lock. They use plain stores, a memset() of the
> live struct, and a devm_kzalloc() pointer publish with no release orderin=
g.
>=20
> Could a REPLACE that runs concurrently with transmit briefly let oversize
> frames through, or drop them? Two ways this could happen: the memset
> temporarily zeroes max_sdu[], or a weakly ordered CPU sees the new pointer
> before its zeroing is visible.
>=20
> This patch does improve the ordering somewhat, since enable is now set on=
ly
> after max_sdu[] is populated. The effect is limited to transient per-pack=
et
> filtering decisions.
>=20
> > +	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
> > +	priv->est->gcl_size =3D qopt->num_entries;
> > +
> >  	/* Adjust for real system time */
> >  	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
> >  				       NULL);
>=20
> [ ... ]
>=20
> > @@ -1102,11 +1119,15 @@ static int tc_taprio_configure(struct stmmac_pr=
iv *priv,
> >  	if (ret)
> >  		goto disable;
>=20
> [Severity: Medium]
>=20
> The commit message says "A rejected REPLACE then leaves the currently
> installed schedule intact in both software and hardware". However,
> stmmac_fpe_map_preemption_class() can still reject the request after
> priv->est has been memset, overwritten with the new schedule and programm=
ed
> into hardware.
>=20
> dwmac5_fpe_map_preemption_class() returns -EINVAL with an extack message
> based only on configuration checks, before it writes any register:
>=20
> 		if (priv->xmit_qdisc.algo =3D=3D MTL_TX_ALGORITHM_SP) {
> 			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
> 			return -EINVAL;
> 		}
>=20
> It does the same for unequal queue weights within a TC. That error goes to
> disable:, which clears priv->est->enable, disables EST in hardware and
> resets the preemption class to 0.
>=20
> On the taprio side, taprio_enable_offload() returns the error before it
> touches q->offloaded, which stays true from the previous schedule.
> taprio_change() then goes to free_sched without installing the new admin
> schedule. Doesn't this leave the qdisc reporting the old schedule as
> offloaded while hardware EST is off?
>=20
> enable is now false, so stmmac_setup_est() will not restore the schedule =
on
> a later open or resume either.
>=20
> One way to hit this:
>=20
> 1. Install an express-only schedule with a TC mapped to two queues. This =
is
>    accepted, because pclass =3D=3D 0 skips the checks.
> 2. Run tc qdisc change to mark that TC preemptible.
>=20
> Should the FPE mapping checks run before the installed configuration is
> replaced?

This behaviour has not been introduced in this patch and it needs to be fix=
ed
with a dedicated patch.

Regards,
Lorenzo

>=20
> > +
> > +	priv->est->enable =3D true;
> > +
> > +	mutex_unlock(&priv->est_lock);
> > +	kfree(gcl);
> > +
> >  	return 0;
> > =20
> >  disable:
> >  	if (priv->est) {
> > -		mutex_lock(&priv->est_lock);
> >  		priv->est->enable =3D false;
> >  		stmmac_est_configure(priv, priv, priv->est,
> >  				     priv->plat->clk_ptp_rate, false);
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261026-stmmac-est-fixes-v4-0-999dac4de44f%40oss.qualcomm.com

--7mG7OudezMBGU53l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauMYBAAKCRA6cBh0uS2t
rPhLAP9n3WI1Il/HUYZwkpR+EzGsbN/qOd/XhtP3A+8muzMFyAEAoxwijLgqLJOS
I3g1IObe+OfcYqQcoR+5j9TuDlWOQgQ=
=9DUU
-----END PGP SIGNATURE-----

--7mG7OudezMBGU53l--
