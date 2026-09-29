Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC151524AF5
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687535; cv=none; b=kTDpKQT7BQs+/tEMU1Px0+CBE26kjU3z9uirOMPogf9mXgsln4o6hvS39OYys7P01CTKc45hzQ6MxqkIbazU2pfcp+u4avrhwojwQk8yaaxrz96NMHR7qUDSC4QuC0M5bOXhSNl7mWUIyORbaKVqkfQDqQDWK4/SOHvkgDJIwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687535; c=relaxed/simple;
	bh=ojnjk/wbNTHwXEe8jBo3xTGAZd2HsptAJf6O4Zf1yK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSD0wTZrnPB1zfVy6Dcs5uiQxn1rnRhETX+OO9rDnut5hEvB0Evt20ptQ0namNO0NtX3AjmP9A4rctBrzuhXpgC/ENyT2IBnBSy8zInuRkfnvQd86hyEUTlWSwE3on66amEJe1p9qBeN9qhBrb7P97syJsfm956xZyfCXLXDY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hJqld45D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fe0MUiNt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hJqld45D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fe0MUiNt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqnfw4151558
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EjG8/uIKj4fF9C0fjKOLgLTr
	otKBVJW8kyX0llTR/J8=; b=hJqld45DWBgRyjXu3jt5hm6P9E0kR2qFRF08wYTH
	Waz7kNuLocJCbNN7ad/5E7ahQcso85HSQd0Yjrlaf0tLLjrZTA95XAXcQd66+4Jy
	MyXG/TQPV4iFY6O1RXJygO2njMjjL/qNIXmVJKGLDxQivAyEYZlRzose8NLHbrH7
	92XqDuYQGAj6BTAuCPg2uR+tkY+p7Lbs12L/U4L8Lt9vRCEkk5qu4op3mi1bmq5o
	eMCl+GBME6NwIFBS+XmgaazME3rAMxLtZDgGQN539aJZQAyOLmcF18vcE8sK5tL4
	smkQXiYzP3gaYuZImAr8tES2JANLCVQgVc/P5lqDsu9Brw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnc6g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:12:12 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7ac2663eba2so3012883137.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790687532; x=1791292332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EjG8/uIKj4fF9C0fjKOLgLTrotKBVJW8kyX0llTR/J8=;
        b=Fe0MUiNt9dn4zLVGLXvJLjeZhG/X+vi7R5pifHGoC7g7JE07BOOiXl8oZYVgHypWM3
         QYJF6aK14ss6VSG8nF/hDWy4Ppfpe93GZvM59ogH0MvLEydUhQ28wAbBkxeGQDk6Doqo
         h/Gw8E92B3jHulPxqs1k/0pSuHop85OFrJSg8Q4tCofcucxXPfMo1gpGFcfKa7qbvNiY
         a5o+knPRLtqCo9M51Qr+J94TDnkuAzLUHP9QMtd66UOm1DMUzKZlqoHQEotFlTCpaP0V
         mPiZMv+AQYtgPz91fPgKbZVZ8UahhDOhPB5BsWoS54j9P4HzD0u6F7t7JWri3mpLtIaq
         Lrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687532; x=1791292332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjG8/uIKj4fF9C0fjKOLgLTrotKBVJW8kyX0llTR/J8=;
        b=Zc01NKzgCDdfeKoqBIgQPsfrm0uk0q8w328J/0wrU8rjbkCTemCRE8vvz2Xowhvqam
         FvGx9tIZYJr2eB2Mk2xGH4BPugzhw1S1zugp0drEUQULQpAnZJ4rjLpdzOxzrmgEjomF
         kXBKs4b+X8F+XSNN3WzEcsWzGDwOfZyUCwQgvzvBAFK802FhD3e0HHnif/QgYB7jhOjW
         Vpcoal3zsaV5qrSmU6Mr8+iklbttYqGRPUM/jSgaPWohGCJ0wOFJ5Qbg4Sbrpj7q+d1F
         Iiao0EgG+4j+VqdvvRk6NafiGYoHgXwyDLy48POYavfHy11irjNT7yK2dTsRAuy6K2fG
         VD9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzDkbcYY+IzVnsDpnEp9F0i/zNKz/awLbtVKFATNVd7ilDlc+Ck9dvX9ENYviodn2l0KARTOo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFHV9QZydT32VS3V6u2l0GAI4EFBvkqKx1PuDwP0D/zjeNGkMk
	mMboznscTsczFHphixZryVL+KQZQKmqY/jKsZ3E2jXPw35L3Va83MKepmYepdsx3zeSXf7IZSr5
	rTuC0U6Nt5hB2nD9Zs8FDVQwvRhUAAt/ewPIyljnSIblUVjmw5BSXSE4GkT8=
X-Gm-Gg: AYBFou1kE8aLsV4ilb+RYNgrvhkyORKuMjCxqMDqlQ0HEOPPzljF9aCOw8ZN5AE4Hp0
	BbKYSrhuN8Cg+WS1QEgl9rjlEcSuZcV3naum7vrRHzIxbp6590nAsh04E3BUseDaM2wmulgqWeU
	o03BNqvLwnjY5eB+1sw0JsGvMgFvEmNovlXzys9hOgFtJNGyyuFgGWn4ZQva4akJYnnt93qnraf
	K/ND59X6AslJWxM4TXdIb4umdSOuqWM0LEPscFX1pHDyBmL5Vbsq8TAVvSXrO209sFQl+LL8lKE
	HgkGxWOnoTDMICClF5O/xD+jZr/MyOx5Nbio7X4pis+/JDnHfO4dRivhVQp5oGrLU/I44ZPg21t
	C/lQ+Y/z0ph28VA==
X-Received: by 2002:a05:6102:3e8e:b0:7a7:198b:6748 with SMTP id ada2fe7eead31-7af1edf1724mr6690840137.29.1790687531274;
        Tue, 29 Sep 2026 06:12:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8e:b0:7a7:198b:6748 with SMTP id ada2fe7eead31-7af1edf1724mr6690822137.29.1790687530476;
        Tue, 29 Sep 2026 06:12:10 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af4f8b1eesm4223084f8f.3.2026.09.29.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:12:09 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:12:08 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, Jose.Abreu@synopsys.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: propagate PTP addend and system time
 programming errors
Message-ID: <aru5KHddKAOBUT5f@lore-desk>
References: <20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com>
 <179033656748.2160803.6725984933967085758@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aVQ8ZswR1ZqLphIm"
Content-Disposition: inline
In-Reply-To: <179033656748.2160803.6725984933967085758@kernel.org>
X-Proofpoint-ORIG-GUID: gGDSpcRmm7FVm857UYBB5gcbgF_f0jlr
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abbb92c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=32yqpjcMs3itML3eInoA:9 a=QEXdDO2ut3YA:10
 a=xloJuupI3-Lpbi46SewA:9 a=gYDTvv6II1OnSo0itH1n:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX7I/HzyLE5bIR
 4oS9k2tCIIIIHig6S564cw/bQvTyVE1c7k3ETuvvdeeT9dP3RmMjpbZxDbji4Ud14Q+CpECzFh6
 eS9Q/38YsNHKH8G8hSRKd5HkY0yNhJEY9IZasl73t43IeREJBHkf3H+eNFylKCYHU8LUsTLfDJb
 XWQFzzspyFOV1gONYqwDXrQkP0tGECPszDys+F/RdVaJpjzC9fY0/o4dF8Ms0kfrirJavQF6qF4
 t7LRMil7GVLfoXuQYyjr1ZQy+xWDJPvZJ68KAf0n/1lO7hi6uhY+67hk72vSw/dZNnkY8GrYV+x
 64vmOrbR5w2+i/64P5U3GpafSPPykDzJ42RcNTIGhZfTw79g5vGgfwjYSguXPdJcLAc3PmIqqmp
 iEiTDMjBW92+9p4e2m+NSo7iO/4WKw+IravO+00INGQMVfF0ulayvy9s1qKSWHcqQEivCyjOa+A
 KWgGcOQmLJeHDRu+MeA==
X-Proofpoint-GUID: gGDSpcRmm7FVm857UYBB5gcbgF_f0jlr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX9W4WLS3m9p2I
 MlVRqncwB9WpDwEztJ2g1RL8SP9RrvB//NIXIGRW5wDR5p0/IhrSfPI/juk+2RdDRpPSFURil3B
 FyfPvH0jB6QwO7aYJzov1rNl6Nhar4c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290052

--aVQ8ZswR1ZqLphIm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 4 (1) =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [High] The fix stops at returning an error.
> - [Medium] The patch is titled 'propagate PTP addend and system time
>   programming errors', but the PHC callbacks that call the same hooks=E2=
=80=A6
> - [Medium] The new failure paths leave timestamping enabled with stale
>   state.
> - [Medium] The patch reorders stmmac_dl_ts_coarse_set() so that
>   priv->systime_flags is copied into a local variable at entry, all=E2=80=
=A6
> - [Medium] stmmac_restore_subsecond_increment() calls
>   stmmac_config_addend() unconditionally and ignores its result,=E2=80=A6
> - [Low] stmmac_dl_ts_coarse_set() can now return -EINVAL (sub-second
>   increment computed as 0) or -ETIMEDOUT (TSADDREG poll timeout in=E2=80=
=A6
> - [Low] The new rollback in stmmac_update_subsecond_increment() (line
>   658) passes priv->default_addend to=E2=80=A6
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the devlink
>   'phc_coarse_adj' param (priv->tsfupdt_coarse) is not honoured when=E2=
=80=A6
> - [Medium] This problem wasn't introduced by this patch, but
>   stmmac_update_subsecond_increment() and the new=E2=80=A6
>=20

I will fix the issues reported by sashiko in v3.

Regards,
Lorenzo

> --
>=20
> net: stmmac: propagate PTP addend and system time programming errors
>=20
> This patch makes stmmac_update_subsecond_increment(),
> stmmac_init_tstamp_counter() and stmmac_dl_ts_coarse_set() return the
> errors from addend and system time programming instead of always
> returning success. It also adds stmmac_restore_subsecond_increment() to
> roll back the PTP configuration when programming fails.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 1fb5f804ea234..fae2a90283ce4 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -601,31 +601,63 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_=
priv *priv, struct dma_desc *p,
> >  	}
> >  }
> > =20
> > -static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
> > +static void stmmac_restore_subsecond_increment(struct stmmac_priv *pri=
v,
> > +					       u32 default_addend,
> > +					       u32 systime_flags)
> >  {
> >  	bool xmac =3D dwmac_is_xmac(priv->plat->core_type);
> >  	u32 sec_inc =3D 0;
> > +
> > +	stmmac_config_addend(priv, priv->ptpaddr, default_addend);
> > +	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
> > +	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
> > +					   priv->plat->clk_ptp_rate,
> > +					   xmac, &sec_inc);
> > +	priv->default_addend =3D default_addend;
> > +	priv->sub_second_inc =3D sec_inc;
> > +}
>=20
> [Severity: Medium]
> Is it safe to call stmmac_config_addend() again here and ignore its
> result?
>=20
> When this rollback runs because config_addend() has just timed out in
> stmmac_update_subsecond_increment(), PTP_TCR_TSADDREG may still be set.
> One way to get there is a PTP ref clock domain that is not running,
> since stmmac_setup_ptp() only warns when clk_prepare_enable() fails.
> config_addend() then overwrites PTP_TAR and sets TSADDREG again while
> the previous update is still pending:
>=20
> stmmac_hwtstamp.c:config_addend() {
> 	writel(addend, ioaddr + PTP_TAR);
> 	/* issue command to update the addend value */
> 	value =3D readl(ioaddr + PTP_TCR);
> 	value |=3D PTP_TCR_TSADDREG;
> 	writel(value, ioaddr + PTP_TCR);
> 	...
> }
>=20
> The DWMAC programming model expects this bit to read 0 before it is set
> again. The call also adds a second 100 ms readl_poll_timeout_atomic()
> busy-wait, so the failing devlink path spins for about 200 ms.
>=20
> If the pending update latches later, TAR could end up holding the old
> value (or 0 on the first open after probe) rather than the one just
> computed.
>=20
> On the TSINIT timeout path in stmmac_init_tstamp_counter(), the TCR
> read-modify-write in config_addend() also writes the still-pending
> TSINIT bit back as 1, so the pending system time load is not cancelled.
>=20
> In every case, the helper then sets priv->default_addend and
> priv->sub_second_inc as if the old configuration had been restored in
> hardware.
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but
> stmmac_update_subsecond_increment() and this new helper program
> PTP_TCR, PTP_SSIR and PTP_TAR, and update priv->default_addend and
> priv->sub_second_inc, without holding priv->ptp_lock. Both run from the
> devlink set path while the PHC is registered.
>=20
> The PHC callbacks use that lock around the same registers:
>=20
> stmmac_ptp.c:stmmac_adjust_freq() {
> 	...
> 	write_lock_irqsave(&priv->ptp_lock, flags);
> 	stmmac_config_addend(priv, priv->ptpaddr, addend);
> 	write_unlock_irqrestore(&priv->ptp_lock, flags);
> 	...
> }
>=20
> stmmac_enable() also reads priv->sub_second_inc and
> priv->systime_flags under ptp_lock for PEROUT.
>=20
> Could a concurrent adjfine and phc_coarse_adj devlink set lose a TCR
> mode change, or program a TAR derived from a stale default_addend? This
> error path adds one more unlocked config_addend() plus
> config_hw_tstamping() sequence.
>=20
> > +
> > +static int stmmac_update_subsecond_increment(struct stmmac_priv *priv,
> > +					     u32 systime_flags)
> > +{
>=20
> [ ... ]
>=20
> > +	ret =3D stmmac_config_addend(priv, priv->ptpaddr, val);
> > +	if (ret)
> > +		goto error;
> > +
> > +	priv->sub_second_inc =3D sec_inc;
> > +	priv->default_addend =3D val;
> > +
> > +	return 0;
> > +error:
> > +	/* Restore previous configuration */
> > +	stmmac_restore_subsecond_increment(priv, priv->default_addend,
> > +					   priv->systime_flags);
>=20
> [Severity: Low]
> Is priv->default_addend really the previous configuration here?
> stmmac_adjust_freq() programs an adjusted addend into PTP_TAR but does
> not update default_addend:
>=20
> 	addend =3D adjust_by_scaled_ppm(priv->default_addend, scaled_ppm);
>=20
> If a phc_coarse_adj devlink set fails (for example with sec_inc =3D=3D 0),
> the rollback writes the nominal addend into PTP_TAR. That drops the
> frequency correction the servo had applied, so a failed operation still
> changes the PHC frequency, which the "Restore previous configuration"
> comment doesn't reflect.
>=20
> > +	return ret;
> >  }
> > =20
> >  /**
> > @@ -864,25 +896,37 @@ static int stmmac_hwtstamp_get(struct net_device =
*dev,
> >  static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
> >  				      u32 systime_flags)
> >  {
>=20
> [ ... ]
>=20
> >  	/* lower 32 bits of tv_sec are safe until y2106 */
> > -	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec=
);
> > +	ret =3D stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
> > +				  now.tv_nsec);
> > +	if (ret)
> > +		goto error;
>=20
> [Severity: Medium]
> The subject says addend and system time programming errors are now
> propagated, but the PHC callbacks that call the same hooks still drop
> the result:
>=20
> stmmac_ptp.c:stmmac_set_time() {
> 	...
> 	write_lock_irqsave(&priv->ptp_lock, flags);
> 	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
> 	write_unlock_irqrestore(&priv->ptp_lock, flags);
>=20
> 	return 0;
> }
>=20
> stmmac_adjust_freq() also ignores the return of stmmac_config_addend()
> and returns 0.
>=20
> When the TSINIT or TSADDREG poll times out, clock_settime() or
> clock_adjtime() from ptp4l or phc2sys still reports success. Should
> settime64 and adjfine return the error too, since the ptp_clock_info
> callbacks are allowed to fail?
>=20
> > +
> > +	priv->systime_flags =3D systime_flags;
>=20
> [Severity: High]
> This is a pre-existing issue, but this path is being reworked here:
> stmmac_init_timestamping() always sets PTP_TCR_TSCFUPDT and ignores
> priv->tsfupdt_coarse:
>=20
> 	ret =3D stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
> 					       PTP_TCR_TSCFUPDT);
>=20
> Suppose phc_coarse_adj is set to true and then the interface goes down
> and up (or through suspend/resume). config_sub_second_increment() then
> programs the fine mode SSINC (2e9 / clk_ptp_rate) and the ~2^31 addend.
> priv->tsfupdt_coarse stays true, so stmmac_dl_ts_coarse_get() still
> reports coarse mode.
>=20
> The next SIOCSHWTSTAMP clears TSCFUPDT in stmmac_hwtstamp_set():
>=20
> 	priv->systime_flags =3D STMMAC_HWTS_ACTIVE;
> 	if (!priv->tsfupdt_coarse)
> 		priv->systime_flags |=3D PTP_TCR_TSCFUPDT;
>=20
> It then only calls stmmac_config_hw_tstamping(), and SSIR and TAR are
> not reprogrammed.
>=20
> Does that leave the hardware in coarse mode, adding twice the clock
> period on every cycle, so the PHC runs about twice as fast?
>=20
> > =20
> >  	return 0;
> > +error:
> > +	/* Restore previous configuration */
> > +	stmmac_restore_subsecond_increment(priv, default_addend,
> > +					   priv->systime_flags);
> > +
> > +	return ret;
> >  }
>=20
> [Severity: Medium]
> Can this failure path leave timestamping enabled with stale state?
>=20
> stmmac_hwtstamp_set() sets priv->hwts_rx_en, priv->hwts_tx_en,
> priv->tstamp_config and a priv->systime_flags value that includes TSENA
> and the RX filter bits. None of these is cleared on close or suspend.
>=20
> On a later open or resume, if stmmac_init_tstamp_counter() fails, this
> rollback writes the old priv->systime_flags, filter bits included, back
> into PTP_TCR. The rollback in stmmac_update_subsecond_increment() does
> the same. stmmac_init_timestamping() then returns early:
>=20
> 	if (ret) {
> 		netdev_warn(priv->dev, "PTP init failed\n");
> 		return ret;
> 	}
>=20
> and never reaches:
>=20
> 	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
> 	priv->hwts_tx_en =3D 0;
> 	priv->hwts_rx_en =3D 0;
>=20
> TX timestamp requests and RX timestamp delivery in
> stmmac_get_rx_hwtstamp() would then keep running on a counter whose
> init just failed, and stmmac_hwtstamp_get() reports the stale config.
>=20
> Before this patch, these paths always reached the reset, and TCR was
> left at STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT with no filters.
>=20
> [Severity: High]
> The error now reaches stmmac_init_timestamping(), but do any callers
> act on it?
>=20
> stmmac_resume() ignores the result:
>=20
> 	stmmac_init_timestamping(priv);
>=20
> 	stmmac_init_coalesce(priv);
>=20
> After the MAC reset in stmmac_hw_setup(), a TSADDREG or TSINIT timeout
> here leaves the PHC registered at open still in place. gettime64,
> adjfine, settime64 and tc_taprio_configure(), which calls gettime64 for
> the EST base time, keep using a counter that was never re-initialized.
>=20
> On open, stmmac_setup_ptp() only skips registration:
>=20
> 	if (stmmac_init_timestamping(priv) =3D=3D 0)
> 		stmmac_ptp_register(priv);
>=20
> The interface still comes up. stmmac_hwtstamp_set() only checks the
> timestamp capability bits and netif_running(), so SIOCSHWTSTAMP can
> still turn on packet timestamping with the uninitialized counter and
> return 0.
>=20
> The commit message describes the problem as the driver that "keeps
> operating as if timestamping were up" and names TAPRIO/EST. On the
> resume path, the only visible change seems to be the "PTP init failed"
> warning. Isn't that still the situation this patch is meant to fix?
>=20
> > =20
> >  /**
> > @@ -7693,18 +7737,23 @@ static int stmmac_dl_ts_coarse_set(struct devli=
nk *dl, u32 id,
> >  {
> >  	struct stmmac_devlink_priv *dl_priv =3D devlink_priv(dl);
> >  	struct stmmac_priv *priv =3D dl_priv->stmmac_priv;
> > +	u32 systime_flags =3D priv->systime_flags;
> > +	int ret;
>=20
> [ ... ]
>=20
> > -	stmmac_update_subsecond_increment(priv);
> > +	ret =3D stmmac_update_subsecond_increment(priv, systime_flags);
> > +	if (ret)
> > +		return ret;
>=20
> [Severity: Low]
> This now returns -EINVAL or -ETIMEDOUT to devlink without filling in
> the extack it receives. Would an NL_SET_ERR_MSG_MOD() help user space
> understand why setting phc_coarse_adj failed?
>=20
> > +
> > +	priv->tsfupdt_coarse =3D ctx->val.vbool;
> > +	priv->systime_flags =3D systime_flags;
>=20
> [Severity: Medium]
> Does moving these assignments after the hardware programming widen a
> race with stmmac_hwtstamp_set()? The devlink set callback runs under
> the devlink instance lock and stmmac_hwtstamp_set() runs under RTNL, so
> the two paths share no lock.
>=20
> CPU0 (devlink, vbool =3D true)
> stmmac_dl_ts_coarse_set()
>   systime_flags =3D priv->systime_flags, TSCFUPDT cleared
>   stmmac_update_subsecond_increment()
>     writes TCR in coarse mode and the coarse SSIR
>     config_addend() polls TSADDREG for up to 100 ms
>=20
> CPU1 (SIOCSHWTSTAMP)
> stmmac_hwtstamp_set()
>   reads priv->tsfupdt_coarse =3D=3D false
>   priv->systime_flags =3D ACTIVE | TSCFUPDT | filters
>   writes TCR back to fine mode
>=20
> CPU0
>   priv->tsfupdt_coarse =3D true
>   priv->systime_flags =3D stale copy, no TSCFUPDT and no filters
>=20
> The hardware ends up in fine mode with the coarse SSIR and addend, so
> the PHC runs at the wrong rate. priv->systime_flags then matches neither
> the hardware nor the hwtstamp request, and it is used later by flex PPS
> in stmmac_enable() and by the new restore paths.
>=20
> The old code set tsfupdt_coarse before the MMIO programming, so the
> window was only a few instructions. Here it covers the whole
> programming sequence, including the poll.
>=20
> > =20
> >  	return 0;
> >  }
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866%40oss.qualcom=
m.com

--aVQ8ZswR1ZqLphIm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaru5KAAKCRA6cBh0uS2t
rP53AQDlqQsb9Nw3V9lI5TNUSFSF54usPiT/0grzpx6PlOWmbgD/SP6S7pnXE11A
Lhyu6Hvg3EIdyDsitgRQa1/HEDiXkQE=
=en7k
-----END PGP SIGNATURE-----

--aVQ8ZswR1ZqLphIm--
