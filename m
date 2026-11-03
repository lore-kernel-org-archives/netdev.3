Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741594;
	b=kpN4ntqpjmTGVv/OGfFSTlk3xLfigBbF6JDWxKJjnMQYw7gBzgc3TJnzttyH0c62xwZl
	 6xFZ2lIGtQnwgWHpSyTOgFBDRNJoFJ7kGxnxm9JDSv4Mrm2IfE3GmXiaxGqwHm9KxAqp7
	 zgzzYWEs9wrmjFNAqAPrWVAqH1NsNHFn/ob+WODvY+Vgoxcm53Kdxa1FBbMC50W146Rgx
	 Vab82E0P2sa1gGThg7jCj6uMaEiaEiY5uC0tdbPWZs21IJqNbaZlQ4ht/uK62A/cJogAq
	 C6bMQnyoaPhgkZ0iKJm2hAohrgQXts6Sf33HQPzJw27OvVQrqC55MGjk/jST64ES3LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741594;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=I/SWgdvBQORkmJ1e0fuSL5vTNEEBTfiMVW1AioLHo8Q=;
	b=zILIn3Fle9Lh/chHVKFkPUFB7FlCUzjWC2dPQ+pXj89g23bgxkZhDkYvfOsD90F7hSi5
	 MCTomKjpxw6XD0zbaP4+Ndv59N9vmoqpV0uLYJXY28TtB6THRy4NRni9JN5jSqsnRGDsZ
	 lbkxeBFFD7tqjQ+WUVL/BKVndaWmurkbeejhDQYQEUpySktIgAcF/N5LePCUrcjhQaF7g
	 hEtHhzK+4O1QmD7LEJiPPvLJfAJ0GWy3W6FpPeyPiNIifXhhvf9CVWdp/mZNQkXVeSpij
	 WFgQdYl93rkKPtJaaG/pmvezR5E12Wbq7rJgmQKFI37pylfv/EjaZeTDoHcX8w+1o2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=puWd8yuw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UjGEVjPN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351ED606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=puWd8yuw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UjGEVjPN
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LKYcE854601
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 21:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I/SWgdvBQORkmJ1e0fuSL5vT
	NEEBTfiMVW1AioLHo8Q=; b=puWd8yuwnkgAQxDtWtP5ppHxB1L812wu3Y0Um7i+
	wAJi7w/OX+12jmzrRZnKOtwN/cuxIpqvPUNnHGyhIRUNWBMTtVlC4PBcFhpUEp4s
	znlb7c8uaqoPMnONTa6Vcmy61AoRXI9UvyGedjOjT6KCPBE5vccmSjm6uw2g2Em2
	nJ8j/RJzSxydhbFFojuFfGnDp5/31Fy/SiOyhh6Tzb31xPGaf9rz1d0w20NEOvxw
	Rf7v094GouAUHvciyo3i/rgkm3QpbjHh/ENuHtqhodiQY9nQ/h9Nq1Daw+TZ9ZJo
	B/wVg1VviKLBaBuEUnhJMcQ2+JNbEc1Xcz+cNOrlsEBUnw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv85ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 21:33:13 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7bf634a101fso9236137.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793741592; x=1794346392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I/SWgdvBQORkmJ1e0fuSL5vTNEEBTfiMVW1AioLHo8Q=;
        b=UjGEVjPNbWqAZAjyWY2eBp8QJsENcNTY/CRc7Zi5aFmkDJciV7t6B/1Dh26b+Y1okD
         fMBIfL03n/dyUF9qNlSUx9Q4kw3TV0ciFCC6QplULhuIrNjmRkkOXE2MgWHq5uFcqomJ
         wrOnw8KUmpOk6DdB9uwCITlRgnqutG8V+N6FaE9Pp8W50e5apQHFMWk0VYZ35Tx/M06d
         u6sncIa+OHfd/PQbyHJwjH/FuJajC4oH2QVGmdPxQ0rWwEJanPYUZA+SqeTUvrzrJzjV
         rfwTLogCqxfn08mEC1BrxH7SupPGD9FEnaFn083azcqaY5N230EUks7vlbCYergSETS2
         0Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741592; x=1794346392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/SWgdvBQORkmJ1e0fuSL5vTNEEBTfiMVW1AioLHo8Q=;
        b=P9b6z4ewXnOt8Cyu5bVJMHGWCd0HmQO0VQGw/8Lz3Wj4Ud7kbqh1ESwnIxJzRCLc17
         3JxIUWBY3V50upnDqIKTQWTyLi6Kqc0+TmvDkSZdGZVe3tk43MZBbyuLbmt6Z9tF5oNO
         5U0/Dcp6E9Bc8xSQrpT3sfgAAsPU1mQSsCeefZ+Icmd3s/7mWJTtT1+H369OOwu8RSz9
         WYBA+5MejYlpC5cBDGhYTsgk/mFxIpSyvm+HZnTbIgBbqV1po8uEcx02gmXbFPUZuo1O
         tx+JDdEFRpQ9w6r0fRvBrKCqKhEIq+G4eMyccx+L9ntfwx8pY9wTX86hIGXigHg0aVzE
         H6Ig==
X-Forwarded-Encrypted: i=1; AKwUvBy2M5grYIKolr45s+JPY00R/tzEj3V+eWX85bPUr6orTOHiAdoCnGT/BjT8iYgFxSh2yj6sw2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3uHXXjs4EJ+q3h+dZ84gVnzQINL3hv3CU1ghVn/c5Zv1lND1p
	pUhtuFHoMV9YUyi0364VdUuNUU1hdVKZJ4fVK/PaYbX0J7c9Q9f03gGNsBmINYtEJsnsYeGJDOU
	CrTSQMg42aP2is7ra5Wqz0Lp6v5UDivP6mH/tRTJjHzkSFw0c6CEgFz1K/s0=
X-Gm-Gg: AYBFou3ocp4U4nfJJw3J1XmZIRJ72wbMpBnrEa9j4r5/jULxfzhLeFswmBnX281sPLx
	C5ReqKxB2O/Pe19k2ri0KQTv/XgpiNrnnOLWejCyvXViVwxK2U7i3fmzw304RFE0W2CrGNf0kP+
	bgeShyb9VANqMcm8cyWIh+G9UcZjDdSaVdeEHTvymqJ8BJF3OpYKQ2P74+/KK4TTBkqS1pnZqOV
	hH4aZwO9hdGbDgB+Vx70Mf+6T7BlEQz8tHFM5/MdReXMm4Qj9SPz+/X50MXHk+q5ugXS4x3wy6r
	whDUSJ2DqK4WYVDSWnoohrKCBeytACv5UxTOL2kmAcUwJw+FyUkKKmiNV2DNiwxIZpei8Crsz1Z
	YIAY7tBb0Ohp5ybqFZ7zoAxgb75LztIni0VhEawgsh3ElBnm11KUnBgW0mR/D6Q==
X-Received: by 2002:a05:6102:162a:b0:7cf:61e8:c508 with SMTP id ada2fe7eead31-7d0726cb55dmr5782298137.21.1793741592058;
        Tue, 03 Nov 2026 13:33:12 -0800 (PST)
X-Received: by 2002:a05:6102:162a:b0:7cf:61e8:c508 with SMTP id ada2fe7eead31-7d0726cb55dmr5782283137.21.1793741591374;
        Tue, 03 Nov 2026 13:33:11 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda203b6sm128037f8f.48.2026.11.03.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:33:10 -0800 (PST)
Date: Tue, 3 Nov 2026 22:33:09 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: keep est_lock across PTP clock
 adjustment
Message-ID: <aupTFHhGMYg0hsFN@lore-desk>
References: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
 <179372771896.488856.1466229272637573919@kernel.org>
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
	protocol="application/pgp-signature"; boundary="u7LTxgNDxJpjZZUD"
Content-Disposition: inline
In-Reply-To: <179372771896.488856.1466229272637573919@kernel.org>
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aea5319 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=06Dy6m6j6oPXgT3fdksA:9 a=wPNLvfGTeEIA:10
 a=Eqgwt4SHBu7x9DO010sA:9 a=gYDTvv6II1OnSo0itH1n:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: EgyPTvwvpHsDxSz0FtgEDdFtUyrw3jXT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4NSBTYWx0ZWRfXyamLfOL9tx/L
 QxnqTKxMB6c6Lxv0L6Bx7gR1i8Z7VtFpLVYmxnIT/XMJsU2eCi6hipjLeAaTgcrlggmEdr4Ujc9
 xnYYJZd1G5EgEuANDfNdn9mdgRJJ4GY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4NSBTYWx0ZWRfXyLlpzOalVrbv
 DSwOQQKRhqtFrJqIARL+rP+avQbM9w3bgsQ7980tT6JuDjRcFTIQU4wzvSH9EfFKqzu9nMKCY7p
 MXCWLO3xCao3Z5ecxV936fSaBZBEaV8Te43VowwBFk2WRAhwVqpRhdNtx/CJk91qU3dpn+/vYPf
 1i4b8JqC7H4s4P36DW3HQlGJkQuawThStxAc+3kd2ZB1LNYsYUKAf0LQHMo27B9xHxiTsdBCjE9
 4UMoGnNvlDVzBUltU3g5CnHUBq7sUCZ7hCX++i3KNSBt0JI/QER5QwbmvaSmsT4AChzGhcEvkJm
 E8/4eIcLs7lKMn9YcOOPprbnmOnfgozDiYK+vrQMN6h959hlHjxBlhjLEJx/hnUxj6BkceFp4/D
 Lp0ruLw3ZXKlYeTZlRzowZQR8fWzqw15GgycYBD0S7+X6b+LI4OkjcPKbXKe+Kiuf9ejqYhD0oo
 tlmZfsgjS8+UolZNdAA==
X-Proofpoint-GUID: EgyPTvwvpHsDxSz0FtgEDdFtUyrw3jXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030085

--u7LTxgNDxJpjZZUD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =B7 High: 0 =B7 Medium: 1 (1) =B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] This patch closes the EST-vs-clock-step window only in
>   stmmac_adjust_time(), which serves adjtime/ADJ_SETOFFSET.
>=20
> Pre-existing issues:
> - [Medium] stmmac_adjust_time() discards the return value of every step
>   in its disable/step/re-base sequence and always returns 0.
>=20
> --
>=20
> net: stmmac: keep est_lock across PTP clock adjustment
>=20
> Before this patch, stmmac_adjust_time() dropped priv->est_lock while it
> stepped the PTP clock. A concurrent tc_taprio_configure() could then
> program EST with a base time taken from the clock before the step. The
> patch keeps est_lock held across the whole disable/step/reprogram
> sequence.
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index a37405534bebf..6ad6c2f52a0d2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > @@ -73,14 +73,12 @@ static int stmmac_adjust_time(struct ptp_clock_info=
 *ptp, s64 delta)
> >  	if (priv->est && priv->est->enable)
> >  		stmmac_est_configure(priv, priv, priv->est,
> >  				     priv->plat->clk_ptp_rate, false);
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but stmmac_adjust_time()
> ignores the return value of all three steps in this sequence and always
> returns 0.

This is a pre-existing issue and it needs to be addressed with a dedicated
patch.

>=20
> The disable call above can fail before EST_EEST is cleared.
> est_configure() returns early on a zero ptp_rate or on an est_write()
> SRWO poll timeout, and both returns come before the EST_CONTROL write:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_est.c:est_configure() {
> 	if (!ptp_rate) {
> 		netdev_warn(priv->dev, "Invalid PTP rate");
> 		return -EINVAL;
> 	}
>=20
> 	ret |=3D est_write(est_addr, EST_BTR_LOW, cfg->btr[0], false);
> 	...
> 	if (ret)
> 		return ret;
> 	...
> 	else
> 		ctrl &=3D ~EST_EEST;
>=20
> 	writel(ctrl, est_addr + EST_CONTROL);
> 	...
> }
>=20
> In that case, is the clock stepped with the old schedule still armed?
>=20
> stmmac_adjust_systime() can return -ETIMEDOUT if PTP_TCR_TSUPDT never
> clears. Even then, the code recomputes the base time and re-enables EST.
>=20
> If __stmmac_setup_est() fails, it logs "failed to re-configure EST" and
> the error is dropped. EST_EEST and EST_INT_EN can then stay cleared while
> priv->est->enable stays true.
>=20
> In all three cases, ptp_clock_adjtime() reports success to userspace.
>=20
> Commit 23d96de472f7 says that the third case is intentional: "On a
> failed re-apply the open and resume callers abort, while
> stmmac_adjust_time() keeps the offload configured." Should the disable
> and adjust_systime failures still be propagated, though?
>=20
> > -	mutex_unlock(&priv->est_lock);
> >
> >  	write_lock_irqsave(&priv->ptp_lock, flags);
> >  	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
> >  	write_unlock_irqrestore(&priv->ptp_lock, flags);
> >
> >  	/* Calculate new basetime and re-configured EST after PTP time adjust=
=2E */
> > -	mutex_lock(&priv->est_lock);
> >  	if (priv->est && priv->est->enable)
> >  		__stmmac_setup_est(priv);
> >  	mutex_unlock(&priv->est_lock);
>=20
> [Severity: Medium]
> This closes the window for adjtime, but what about the settime64 path?
> The commit message says:
>=20
>   Keep est_lock held for the whole disable/step/reprogram sequence so no
>   other EST user can program the block while the clock is being stepped.
>=20
> stmmac_set_time() also steps the PHC, but it only takes ptp_lock:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:stmmac_set_time() {
> 	...
> 	write_lock_irqsave(&priv->ptp_lock, flags);
> 	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
> 	write_unlock_irqrestore(&priv->ptp_lock, flags);
>=20
> 	return 0;
> }
>=20
> It never takes est_lock, never disables EST before the step and never
> calls __stmmac_setup_est() afterwards.
>=20
> tc_taprio_configure() holds est_lock, reads the clock with gettimex64(),
> computes priv->est->btr[] with stmmac_calc_tas_basetime(), and then calls
> stmmac_est_configure(..., true). A concurrent
> clock_settime()->ptp_clock_settime()->stmmac_set_time() is not excluded
> by est_lock, so it can step the clock between that read and the
> programming.
>=20
> Doesn't that leave the same stale base time race open through settime64?
>=20
> There is a second effect. A taprio schedule installed before a
> clock_settime() is never re-based, so it keeps its old base time until
> taprio is reconfigured.
>=20
> Should stmmac_set_time() use the same disable/step/__stmmac_setup_est()
> sequence under est_lock? Should the commit message mention this path?

The reported issue is valid, but it is a pre-existing problem out of scope =
for
this patch (it needs to be addressed with a dedicated patch).

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d%40oss.qualcomm.com

--u7LTxgNDxJpjZZUD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaupTFAAKCRA6cBh0uS2t
rDvIAP9tPpHWKQVQUbTr/cKabQ0rfGmIlQxmZcAOxJ6ZZrEPPgD/QP2fAC6xHv5x
Yo1LtT60Zj45J1FEXP5eCG5PXtZpcgY=
=c9CI
-----END PGP SIGNATURE-----

--u7LTxgNDxJpjZZUD--
