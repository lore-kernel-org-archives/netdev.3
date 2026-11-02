Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618422;
	b=wZ0j3Tfm3z19imYYe1NeYVlJGP6JagGbWtDoRJ0qVutB1GyvYoZP6aPxyd99Ik5H0wAT
	 cCMDak9BAh2F9sJqSMmSf5w6L1dwBZCF3xoSB8QxMVoYmqAIwX/WjnY/yzWbjBtQbqlMp
	 6KKgDsivf/6RGJgqhgp6MsvmmPu7HV0k+E4QtqR0Pjma9KpjT4Cv/P2bVD/v/amK4aJ5g
	 qNOU5gKGlUDlb9nMALmaxYVkOC7dWbWsCwpcOFdKuonT1FzafMSYpMOAWaIGJMfkGerUK
	 4W2bG9klWlngquup2JKxyDf5tY6jMpZ1ybH3B6DdaJqUAAjGhEHgoXg4/bBaoOMZbKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618422;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4wytZ7YbEEeBBVHe06rvMZ2OXjLqmKmm9QBKQw7r92U=;
	b=45I9LHiy09dTmO4rQ/7McXF5uNm1V2vTFC8eCoCzfpD5EKVWfbE/xP3mlHXq9BfhVRgM
	 BmqJAQ/IPmXtMzjLKItUI4D1dtVu7yRqQrguCNCeCPmCsL/DrDJyPjIbrwNsKebKLmdcY
	 HkShKh3L6a9XZkw6FD+qUYkZ8NyoHJQ88Fy6rUB0ItFGRT+RA0RI2fLcBTB6HIcUN+1Sg
	 odtSMhHsHKb7Uf/jeZcwuYk2PTvR5qLM/oa9fDVXfxyT4aU2w5hgmXDHs6RRtRk0pU8Fa
	 kEo4aQnj69QvccFYD40SuSLuw+U6/VwQgXFtRXrVmywI7VW6uEfQomfFkX0440xlmUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8yr7sZN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PBwPkcB5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1567606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1567606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8yr7sZN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PBwPkcB5
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B4Mrr2616194
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 11:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4wytZ7YbEEeBBVHe06rvMZ2O
	XjLqmKmm9QBKQw7r92U=; b=a8yr7sZNLXHq3Db4S5ywPHTmKS0PcMcbZGpvGH3Z
	XfsPbdkJRkqN6yHDHFOhGzPOXpGKCfdi48pdlRNjNGyF19BtrGh31SvKOvwJZ4m7
	jmdfxXwCaXYlOdg6K+oH7LC4zyhQu4rm81KjGJF54WI6nLVMEErlQsdWpzedLU1l
	Pau4Yz6VgzsCkN8gREtTS1Z99EYL2AeUZ2GypyWcPdShSKS1072NVIMm2tZ77w6O
	k/YjvFJkRCdRkTamxj3CuQXS63nvEWnGUv196JKAGug8pLoy8dglRXz9xg0akoBF
	yzcqeefh3Kbe968GXXdhUcmfwF8uagWC5o0QQT+aspkBfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavg1uj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:20:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f13c143c8so530420985a.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793618420; x=1794223220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wytZ7YbEEeBBVHe06rvMZ2OXjLqmKmm9QBKQw7r92U=;
        b=PBwPkcB5aVMz6afRAneNpy0uSCJV5IRVGCnhVzleR9BZjQKqY8mts3NSGenlV2gU4U
         74RCDVmnmwA/c9Se3YEIcqXKcxzcZjNT8p8m6rYAWufJlnHI+CVsBACrybaNK49gQ609
         wlb1GeXJKdwqSCNWPbMoM9IMeSaLr0G3o/fC/+xB6N5hbzLVLHaSmRk+OFeiUS8Yo/kk
         sC/HZUS0hE2XVjRp+BlQL5BDWksWVsqHN8Cr/k//VHrR7gSrFXCD8dHsDSDevS0MNgWl
         XdGsCYdMwDzjfs03vfr80L5MEEltibADnX63qBT+KiMQssUkoj73098xQCaIvaWhG13X
         Tt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618420; x=1794223220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wytZ7YbEEeBBVHe06rvMZ2OXjLqmKmm9QBKQw7r92U=;
        b=H4Noh0hY/i9XqECmrlts98dby2lFof7p29WDXCQ90/0hFJ3tRPpbzmyHAy39uWW22G
         ykHbU+n6uq4bUuX61uc3+cZM5Wx6zsCW9p+CZeJ9K5qE9AtCRCPWJpMKI4NhC1k4jbJQ
         N5mN3gYl8upLvUTF0l5gctvycrQ7sABGgFqk5r0RuAWeBB2ZoQX4gd1t/zL5wTAhKhpN
         dt6vPdHvHlCnr9odOoFUf0kXrVrFrXlC/hwInmIMHBXQXISa0GzjCzFdMhegfBNi/tGi
         NjStQtLzUJmVf2p/bQDsrKxqbpuqy0hAy0hE2PULUfrbD2KIREOQXPA6rnjS5ZGkivmd
         DkPg==
X-Forwarded-Encrypted: i=1; AKwUvBxrIB3DzuT5aN8BohSLb+XfdPx1D0nhGR9f/QkmBCgsjGCndIU5s5XhBIaEMyR8muf2CdWsgRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhnpWIBrYvm1F9Q0zy0C5raXE9XiC02EWey2fg+xSrH3+Soz8s
	xYB4ERtNnKtQDb1KpAbf4ByQiVANrvOLckNIFrCBs+V44dj3kd1pYkGBGpiP1AR6y0KkijocdM4
	R2dwlCjsPU+ACJ+aaqM/iGU3gbAOQjl3SNWX9NluU2pTW6J0OhE9iJbT6Tvs=
X-Gm-Gg: AYBFou38THAkBxoz1QUXJ6Ulto3QslHzCWk4EdeX469zu94cxRzFKpYqf62cdJxdgXM
	bN8LDwL1CgN//DLS0F/FxaPXQbGKD8UeRM8Saj0s1wMZ2i+eBMvU0+jjAO6yE+PKCpDTu70MgPb
	JSlMojm6Y1fQ0BW78xpgGIlQDDYIVsymtO6nWV3ibEMJ4TjMOZZIEM8Kj+tFD5phg0n+WstZaZu
	kclO/1KU0Yzryf/TdQCbwn4/cFcBCRPscfoRqwd/zfUNe4YGSypvaeD5nVVg6NWiJYOsYmBU0i5
	JZc5B2apClhBfj8FXOivNKlFIMrff1Sz8qHHwf9GJiOQxMiuNT9EGc/YPJ6l4iQJmDvk/gJw84m
	KAU7HuldY3JemX7a4ZtSkr5XIe6nvR70PswxHp3STG2nMN5krgx+pI9Axz3HKLg==
X-Received: by 2002:a05:620a:4402:b0:93f:1af1:7952 with SMTP id af79cd13be357-94421584b85mr1636762285a.4.1793618419887;
        Mon, 02 Nov 2026 03:20:19 -0800 (PST)
X-Received: by 2002:a05:620a:4402:b0:93f:1af1:7952 with SMTP id af79cd13be357-94421584b85mr1636757985a.4.1793618419168;
        Mon, 02 Nov 2026 03:20:19 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba53d7sm24879798f8f.53.2026.11.02.03.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:20:18 -0800 (PST)
Date: Mon, 2 Nov 2026 12:20:17 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, linux@armlinux.org.uk,
        Jose.Abreu@synopsys.com, james.hilliard1@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rayagond@vayavyalabs.com
Subject: Re: [PATCH net v5 2/3] net: stmmac: pass the desired EST enable
 state to est_configure()
Message-ID: <auhx8SuHafjAnzJ9@lore-desk>
References: <20261029-stmmac-est-fixes-v5-2-85b830a795a9@oss.qualcomm.com>
 <179361656635.3131.18359030964578099180@kernel.org>
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
	protocol="application/pgp-signature"; boundary="w09fbWP8zAPXJjBS"
Content-Disposition: inline
In-Reply-To: <179361656635.3131.18359030964578099180@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfX1RIeEv4x6kUU
 1Pfyjj8vEKd3R1KQmK6nuRynw9ppXyJThPcHuMNL/r18+KgsAk672u997xD1YSLYKycs+7Q4uhD
 ZXoT2SPvCI8BKlSU1Rn297UgTkL9ngt+BHAj9zfjUf9AqPAEz8XpqVICTBLt5dW5LcZcx/UilVB
 iHaPvVFD//pUxlQMYI/7rwJLgerXn3T8GPHJnOXPlYUEXgwupc+jPXk7dTnR/RbCc05JKSwhi06
 0hRnjhuOPDZCxVQeFqhWsqhtjCH0ori2RD2pmQRk4iVaRZF0QolvJl0z4ZJTcry81+b0oBxTnyw
 +izTI5BFqrtofDPZb6s81zIHXZVsmIO7+cKKkC39sma/NsDZ1xU4BDLYDpCSEGbMbUbsVDSpK+T
 w9ILF9YJ/ZDJoq9GPuwd4dSdFJay1CVqpzS2f6Lpezhmka6VapnZHhhkR/JxEXXyGEzYOzJIdAZ
 QfxBwMzaJZZubLFVsCA==
X-Proofpoint-GUID: 9t-j-pS1g9K2WuONBEi_HoNCYj1c2nNq
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae871f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=UarSiPXRvnQt6UJiVTEA:9 a=QEXdDO2ut3YA:10
 a=NGW1ISiYAZ_3V0LsNgwA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfX7oBHVUcjNP94
 ziCXWTYn3C/+zE9Tk7PIFA0taQ/D5nIb1mdoiioHwKHcY3g4CyQUGX83nh50CXw3tTq9LGUuCbK
 3n8ImOg2MiMvJXwPOshA8lYgK/i+/bM=
X-Proofpoint-ORIG-GUID: 9t-j-pS1g9K2WuONBEi_HoNCYj1c2nNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020045

--w09fbWP8zAPXJjBS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] The commit says "No functional change intended", but there is a
>   change when stmmac_adjust_time() runs concurrently.
>=20
> Pre-existing issues:
> - [High] This happens at this commit in tc_taprio_configure()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c).
> - [High] At this commit stmmac_adjust_time() (stmmac_ptp.c:72) checks
>   priv->est->enable without est_lock.
> - [Medium] est_configure()
>   (drivers/net/ethernet/stmicro/stmmac/stmmac_est.c) rewrites=E2=80=A6
> - [Medium] At this commit stmmac_adjust_time() decides est_rst from an
>   unlocked read of priv->est->enable (stmmac_ptp.c:72-73) and drops=E2=80=
=A6
>=20
> --
>=20
> net: stmmac: pass the desired EST enable state to est_configure()
>=20
> This patch adds an explicit enable argument to est_configure() so it no
> longer reads cfg->enable. The callers in stmmac_adjust_time() and
> tc_taprio_configure() now pass true or false directly, and they still set
> priv->est->enable around the EST programming as before.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_est.c
> > index afc516059b897..f15d4d046aa74 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
>=20
> [ ... ]
>=20
> > @@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, st=
ruct stmmac_est *cfg,
> >  		ctrl |=3D ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
> >  			 EST_GMAC5_PTOV_SHIFT;
> >  	}
> > -	if (cfg->enable)
> > +	if (enable)
> >  		ctrl |=3D EST_EEST | EST_SSWL | EST_DFBS;
> >  	else
> >  		ctrl &=3D ~EST_EEST;
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but when enable is false,
> est_configure() still rewrites BTR, TER, LLR, CTR and the whole GCL
> through est_write() before it gets here:

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
>     ret |=3D est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
>     ...
>     if (ret)
>         return ret;
>=20
>     for (i =3D 0; i < cfg->gcl_size; i++) {
>         ret =3D est_write(est_addr, i, cfg->gcl[i], true);
>         if (ret)
>             return ret;
>     }
>=20
> If one of the SRWO polls in est_write() times out, the function returns
> before it clears EST_EEST here and before it zeroes EST_INT_EN.
>=20
> The disable callers ignore that return value and set
> priv->est->enable =3D false anyway. These are the disable: label in
> tc_taprio_configure() and the quiesce block in stmmac_adjust_time().
>=20
> On TAPRIO_CMD_DESTROY, tc_taprio_configure() returns only the result of
> stmmac_fpe_map_preemption_class(), so taprio treats the offload as
> removed.
>=20
> Could the MAC keep gating TX with the old schedule, with EST interrupts
> still on, while software thinks EST is off? This ordering is unchanged at
> the end of the series.
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index e54a3c8878265..9a32af00d7d2d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > @@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *=
ptp, s64 delta)
> >  		mutex_lock(&priv->est_lock);
> >  		priv->est->enable =3D false;
> >  		stmmac_est_configure(priv, priv, priv->est,
> > -				     priv->plat->clk_ptp_rate);
> > +				     priv->plat->clk_ptp_rate, false);
> >  		mutex_unlock(&priv->est_lock);
> >  	}
>=20
> [Severity: High]
> This is a pre-existing issue, but the check that guards this block reads
> priv->est->enable without holding est_lock:

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
>     if (priv->est && priv->est->enable) {
>         est_rst =3D true;
>         mutex_lock(&priv->est_lock);
>=20
> A TAPRIO_CMD_REPLACE in tc_taprio_configure() drops est_lock between
> steps:
>=20
>     mutex_lock(&priv->est_lock);
>     memset(priv->est, 0, sizeof(*priv->est));
>     mutex_unlock(&priv->est_lock);
>     ...
>     mutex_lock(&priv->est_lock);
>     priv->est->gcl_size =3D size;
>     priv->est->enable =3D qopt->cmd =3D=3D TAPRIO_CMD_REPLACE;
>     mutex_unlock(&priv->est_lock);
>=20
>     for (i =3D 0; i < size; i++) {
>         ...
>         priv->est->gcl[i] =3D delta_ns | (gates << wid);
>     }
>=20
>     mutex_lock(&priv->est_lock);
>     /* ctr[] and btr_reserve[] are filled only here */
>=20
> Suppose the second est_lock section of stmmac_adjust_time() runs in that
> gap. It then computes:
>=20
>     cycle_time =3D (u64)priv->est->ctr[1] * NSEC_PER_SEC +
>                  priv->est->ctr[0];    /* still 0 */
>     time =3D stmmac_calc_tas_basetime(basetime, current_time_ns,
>                                     cycle_time);
>=20
> and stmmac_calc_tas_basetime() does:
>=20
>     n =3D div64_s64(ktime_sub_ns(current_time, old_base_time),
>                   cycle_time);
>=20
> Can this divide by zero and oops on x86? It would also program a GCL
> that is still half written through est_configure(..., true).
>=20
> This looks to be addressed later in the series by "net: stmmac: re-apply
> taprio offload in __stmmac_open() and stmmac_resume()". That commit:
>=20
>   - holds est_lock across the whole validate, memset and program
>     sequence in tc_taprio_configure()
>   - sets enable only after programming succeeds
>   - checks enable under est_lock in stmmac_adjust_time()
>=20
> > @@ -105,7 +105,7 @@ static int stmmac_adjust_time(struct ptp_clock_info=
 *ptp, s64 delta)
> >  		priv->est->btr[1] =3D (u32)time.tv_sec;
> >  		priv->est->enable =3D true;
> >  		ret =3D stmmac_est_configure(priv, priv, priv->est,
> > -					   priv->plat->clk_ptp_rate);
> > +					   priv->plat->clk_ptp_rate, true);
> >  		mutex_unlock(&priv->est_lock);
> >  		if (ret)
> >  			netdev_err(priv->dev, "failed to configure EST\n");
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but est_rst comes from the
> unlocked check before the first critical section. Nothing is re-checked
> here after est_lock was dropped around the systime step.

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

>=20
> A TAPRIO_CMD_DESTROY can land in that gap:
>=20
> CPU1 (stmmac_adjust_time)        CPU2 (tc_taprio_configure, DESTROY)
> est_rst =3D true
> priv->est->enable =3D false
> est_configure(..., false)
> mutex_unlock(&priv->est_lock)
>                                  disable:
>                                  priv->est->enable =3D false
>                                  est_configure(..., false)
>                                  returns success
> stmmac_adjust_systime()
> mutex_lock(&priv->est_lock)
> priv->est->enable =3D true
> est_configure(..., true)
>=20
> Does this bring back a schedule that taprio has already removed? The
> xmit paths would then also enforce the priv->est->max_sdu[] drops again.
>=20
> The same later commit, "net: stmmac: re-apply taprio offload in
> __stmmac_open() and stmmac_resume()", appears to fix this. It re-checks
> priv->est && priv->est->enable under est_lock before calling
> __stmmac_setup_est(), and stmmac_adjust_time() no longer writes the
> enable flag.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index aea235a69105e..ac926c60f9f9a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > @@ -1090,7 +1090,7 @@ static int tc_taprio_configure(struct stmmac_priv=
 *priv,
> >  	tc_taprio_map_maxsdu_txq(priv, qopt);
> > =20
> >  	ret =3D stmmac_est_configure(priv, priv, priv->est,
> > -				   priv->plat->clk_ptp_rate);
> > +				   priv->plat->clk_ptp_rate, true);
>=20
> [Severity: Low]
> The commit message says:
>=20
>   No functional change intended: the callers keep toggling
>   priv->est->enable around the EST programming, as before.
>=20
> Does that still hold when stmmac_adjust_time() runs at the same time?
>=20
> Before this patch, this call read cfg->enable under est_lock. The REPLACE
> path sets enable =3D true in an earlier critical section and then drops
> est_lock while it fills the GCL. Consider this sequence:
>=20
> CPU1 (tc_taprio_configure, REPLACE)  CPU2 (stmmac_adjust_time)
> priv->est->enable =3D true
> mutex_unlock(&priv->est_lock)
> fill priv->est->gcl[]
>                                      priv->est->enable =3D false
>                                      est_configure(..., false)
>                                      mutex_unlock(&priv->est_lock)
> mutex_lock(&priv->est_lock)
> est_configure(..., true)
>                                      stmmac_adjust_systime()

As the one above, this issue has not been introduced by this patch and I th=
ink
we should fix it with a dedicated patch.

>=20
> With the old code, the REPLACE would program EST with EEST cleared,
> because cfg->enable was false. EST then stayed off across the time step.
>=20
> With the hard-coded true, EST is turned on with a BTR computed from the
> pre-step time. The PHC step then happens with EST active while
> priv->est->enable is false, until the second section of
> stmmac_adjust_time() reprograms it.
>=20
> The underlying race is pre-existing, since no lock covers the time step
> together with the EST programming. Still, this interleaving behaves
> differently after this patch, and the window remains at the end of the
> series.
>=20
> >  	mutex_unlock(&priv->est_lock);
> >  	if (ret) {
> >  		netdev_err(priv->dev, "failed to configure EST\n");
> > @@ -1109,7 +1109,7 @@ static int tc_taprio_configure(struct stmmac_priv=
 *priv,
> >  		mutex_lock(&priv->est_lock);
> >  		priv->est->enable =3D false;
> >  		stmmac_est_configure(priv, priv, priv->est,
> > -				     priv->plat->clk_ptp_rate);
> > +				     priv->plat->clk_ptp_rate, false);
>=20
> [Severity: High]
> This is a pre-existing issue, but the entry validation loop earlier in
> tc_taprio_configure() returns directly instead of going through this
> disable: label:

This issue has not been introduced by this patch and it needs to be fixed w=
ith
a dedicated patch.

Regards,
Lorenzo

>=20
>     priv->est->enable =3D qopt->cmd =3D=3D TAPRIO_CMD_REPLACE;
>     mutex_unlock(&priv->est_lock);
>=20
>     for (i =3D 0; i < size; i++) {
>         ...
>         if (delta_ns > GENMASK(wid - 1, 0))
>             return -ERANGE;
>         if (gates > GENMASK(31 - wid, 0))
>             return -ERANGE;
>         ...
>         default:
>             return -EOPNOTSUPP;
>         }
>=20
> By that point priv->est has already been memset. So a REPLACE with one
> invalid interval, gate mask or command leaves enable =3D=3D true while ct=
r[]
> and btr_reserve[] are zero.
>=20
> taprio_disable_offload() does not call back into the driver when the
> first offload attempt failed, so nothing clears the flag later.
>=20
> A later clock_adjtime(ADJ_SETOFFSET) on the PHC then does:
>=20
> stmmac_adjust_time()
>   cycle_time =3D 0
>   stmmac_calc_tas_basetime(0, now, 0)
>     div64_s64(now, 0)
>=20
> Can this divide by zero and oops on x86?
>=20
> This also looks to be fixed later in the series by "net: stmmac: re-apply
> taprio offload in __stmmac_open() and stmmac_resume()". That commit
> validates every entry into a temporary kcalloc() buffer before it touches
> priv->est, and sets enable only after programming succeeds.
>=20
> >  		/* Reset taprio status */
> >  		for (i =3D 0; i < priv->plat->tx_queues_to_use; i++) {
> >  			priv->xstats.max_sdu_txq_drop[i] =3D 0;
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029-stmmac-est-fixes-v5-0-85b830a795a9%40oss.qualcomm.com

--w09fbWP8zAPXJjBS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCauhx8QAKCRA6cBh0uS2t
rCUIAPsFCawyd5Cgdr32fDn3TYCpBDWq+i/xcujYMtMHg9vX2wD5AeYukKEBM4cM
dYZTujhnUqwzaV1c+1K9K3KbsJLciAE=
=Eylt
-----END PGP SIGNATURE-----

--w09fbWP8zAPXJjBS--
