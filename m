Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559686;
	b=sJ0BRrNDOW9+gkAKiL7mOD1zVssrODIwbzj+fw/DOfaDiNS+fjcXFGSeW1djbe5ah8DU
	 xqz3BiZMAKxl3RZhURESWdKUQ2/AdaK1ylmYGVZCq78mGAI+YBQVWfQZBj/2BsbGiatmd
	 vq8+mC8yBoyWXQniWLqbaTluku2jI42deaUdv7vQ0Q3dmIxsgWSBh6SC7algaISuhdspz
	 94tT+YtOwFSaetJEO6f3fw0lcXJR2DCVbbO7kyzVYcS12OVJgHS0fFDVaCq5Ayj3eTEM5
	 eaTBkTCrOspAFjKemx6aYh3FuXIuS/D89cYX7mRjJTfEGB3odz/rYdpCVRdPsN4DlUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=P6PGMZFxc6UhpNPssneEJ0B1sY5J1KKjecVwvvRM188=;
	b=XCR5VtnTc2hVG+Acz0f+hT3EpL1LwHHlO2wVAHDYDA/+MoyL+DbwZnpIDKf4qbl31vnT
	 iQmbhVOnKNmakWf0LItLsqYzw8LJ3GRYQ8A27RBLsoBwjxApnxZoWx56WZvXtTxfP971J
	 uO6GtQmWSksAgMhJs+BETcSnE6FKnJOfTQFHBrKtUL1z5uvWqdMDHEnjh74jxVfiVmX5/
	 pU5DG0P5694YR3j5ogMRscNI4eNTLuF1rQ4+5WKlZghlfAmouW91Iu9nLIcduD62ayl1u
	 sykrAU1hDKCDoPdMTgYs5m0/he5471WatyRW0NZPF2Qi6g9ABJOw9riGN9WbxHxwyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pLruQmzb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UtTxCXHF;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53781606B353
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53781606B353
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pLruQmzb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UtTxCXHF
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VKdH2515663
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P6PGMZFxc6UhpNPssneEJ0B1
	sY5J1KKjecVwvvRM188=; b=pLruQmzbk64QqOwvEb8+G4xkq5jhWCxdWZPr0xhI
	WIQPs0PLzldrHLuiBnylPRHumzBXeSdxxAzx2p9PmUCK3kiDSZCkbwCfzQW2W53R
	0YCPCGHhc9JuUlguBcuc3K0UduB0b9uy+7cTcc7Q8KgXDMwFnkUSKQZlVyKogDB5
	xLqUeWjAzpDzjqeCOA/DuX97Cb+jgpOy0FVHrPUm6HP8J+bapHiWSJ2Lk3ssi4+m
	UouEmDn0Ol3UnT+55MQX9DGVzp7EhRWck/3FzJirTYo9hY27E1JnuPgf/aGgSlpd
	XIl4RHm3JzOI9PYuImUhdD4SLntCCItuiPSek9DlJGF96g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bb9vy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 08:48:05 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91f12cc95a0so16343396d6.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794559684; x=1795164484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P6PGMZFxc6UhpNPssneEJ0B1sY5J1KKjecVwvvRM188=;
        b=UtTxCXHF8tj7PeYTluOqC7aY929DFbBn9B3PIckRn1adix/cZb5UfxaFW8UguprRum
         YvLcFRNB2CpBBtCdNfYHv8M+o89JmnqHTCJokVDtccPZ9hbS6NwUCToaTa1DrqvSdqGc
         scAeybwy7YkIrveLWyD6/bnB/QGx18xuPuNi7+B9x6mF5NADVrXhQOEVHmcFu7DrIT7o
         guLCQoGygP4vOksYKjEaoxpJ1/aXtBCTslUGMeJzobXk4vT9VYzIdLAOCBbwC0dKqzXN
         v/Pm2+O2RVrrNOEc1WFbzgDieWgXGR02V5pD1Nb5Qd8FG2ix71teouyuluW4+jPE6Lu9
         Q+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559684; x=1795164484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6PGMZFxc6UhpNPssneEJ0B1sY5J1KKjecVwvvRM188=;
        b=Njz5RyNdVxHAz24vUtzuxyjCcmXza2uboRP+YEDJ8qZm6tV8DZh69sYomwgDQ3UTaa
         ToUkgkmQxohTiiGBp70KA88F4bpYutHs9Qz48xRO3CDqryJTFpT2ONGtHBnKh4fo7xhi
         znAuUQ0FrxGVWSUkWeI/G8LldoJAUvan5Vn9A/8qnB2zcRC8CC65XE1KdNruw6P1EEDz
         UiJzICGgbLlz1GfW+v6bwGjb7aZ7B73U7CBRMnlmaZnZWQDlBrnG0tui2QOO1TLDrZQR
         nb/VlggLdvpqkhpWQ6k4iqxOWa5dQYFEa43CPCzdJrrwV+sdf7O2gSPDzpp7Ggb3isqN
         Do5g==
X-Forwarded-Encrypted: i=1; AL+hErHHvhHSPEMGXMRJ1Z5yMATny0r7cocnOcwNDfFZqm8keqhiArj8cx8QgixOLJbet6Lt4FEx8aA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Co1Jqq0OCKQfpJKa/DovPwS23yEQvMxWmdrjznio0Ep2PlP2b
	yyS4yxfs1X89Cj5clIQyIyMHiW6B3mr0mzbGiGwMB0z7ecvm4CyEgMI0VRABsCLf4YcpFXId0Am
	f4PYrr/fGn0mBbUHq/tJbiQC3kkDMm+Ki6kzHL13PwNK+jdm4WpOQch0/rhg=
X-Gm-Gg: AYBFou06fRyP9aDWv8I6AfoOsqKI/kF2/BIHyAjOudamj/wNPgsbRWm2gIDXa+lr8g+
	dR0jev5vwEFuyHwkx4yKSq6PXsS5nQpvfaw7mLXpxK+1XaQlJGkb15An40O4eOVdiZ8+sHney/o
	da0dr0P8JCJBZjzzg7xnVk5xPWjJl6Z7t17kz/3YtUG7cRAxWGZ1mJCxmZpl9VlRwEB2x3sNFLj
	xTflCPhIqJ6Ev6hjEJ2DKl9WYza2W+WSzC8sanFeSnSL7d6d5LEWzWvq7Ka7Fbb8j2t3Q8KGp8w
	F0r5048ACO08J+rDXh65H5ElvC/ympW6shhmwEyI06HD9Pe90l5X9RywjN9l7/apu5nDLsCb/jX
	mlabNYqfFd7oh55JmtDLCNvWll8oeLe1eKYCpEJp5X49JPAmqIuoJAoPd95C+8g==
X-Received: by 2002:a05:6214:5906:b0:91c:77ef:21f3 with SMTP id 6a1803df08f44-91f241e0909mr25559676d6.35.1794559684248;
        Fri, 13 Nov 2026 00:48:04 -0800 (PST)
X-Received: by 2002:a05:6214:5906:b0:91c:77ef:21f3 with SMTP id 6a1803df08f44-91f241e0909mr25559336d6.35.1794559683623;
        Fri, 13 Nov 2026 00:48:03 -0800 (PST)
Received: from localhost ([93.66.91.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60ca70a7sm3689140f8f.51.2026.11.13.00.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:48:02 -0800 (PST)
Date: Fri, 13 Nov 2026 09:48:01 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: re-base EST after PTP settime64
Message-ID: <avbOwepxkFf1F717@lore-desk>
References: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
 <ea9ae0f9-d373-4e97-b96b-3855c01100ee@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="8vOlyl6HxoyVuXhq"
Content-Disposition: inline
In-Reply-To: <ea9ae0f9-d373-4e97-b96b-3855c01100ee@bootlin.com>
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6cec5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=vJIuTH4p0ATK6gluz4evpA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=2dOafQFslBOt0hFCmmYA:9 a=CjuIK1q_8ugA:10 a=-1ZYPXEuWJ9im3w4qA0A:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: JH9j-3uwd7tkalXsO4JzgYO4NoXQ1ryd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX4zadBrCOv/i3
 FCB2IR8oR4P/j6z19tPb/YYVs/CWX99l095Kpzw1037ffHOQ68cqrxB1gGkCcZgZaflyRP/obpe
 Hg16fWaO53WuPsWcawambaDlfO7phPFlN7G/pBXqnzALE86EPB+I5wQZTgiVzPTTqYb1Bj3Pvud
 MYN9i9Zn3KraNbZHUPzXGtLgGmtFoAQvyMVEHawLZwd/FFrrftJT/w7ger9qzeBlf01qzhCvyH9
 Iw5saw27J4RS3/oKW9p2kAPP/xmTBc4UdGoJReE5L63AaTu3F+hhxdxsDNAbfcTa9H3poUw9BCs
 xpCXz74WftdkEaaQI6mIU7UX41z0HIpAnmOYmwNYQCovg88BU6DftGZ8Ym6xYERzuqB7EUZ4uZX
 40pxITlr7bh2Y0fCsvLrl/M6wCXRYgy3//TqM1RzhClne21Zy/ZqYC0uqNEJKyotITx0Zn/nXGz
 tAdfkne7MUlWzlzc+dA==
X-Proofpoint-ORIG-GUID: JH9j-3uwd7tkalXsO4JzgYO4NoXQ1ryd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX60GHbQIMFsxH
 ExGq72U6lP1TuVWStLnFbGtBaiTgPMMj5vP3ZT04OTx0SLp+K2qbd1lNPl7cA0GXQ2p5nwojlT+
 SGlKAL5nc/K+dVMLgYetIGBxmb+KMuA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034

--8vOlyl6HxoyVuXhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 12, Maxime Chevallier wrote:
> Hi Lorenzo,
>=20
> On 11/11/26 10:54, Lorenzo Bianconi wrote:
> > stmmac_set_time() initializes the PTP clock through
> > stmmac_init_systime() (TSINIT) while holding only ptp_lock.  It neither
> > takes est_lock nor disables and re-bases EST around the step, unlike
> > stmmac_adjust_time(), which performs TSUPDT through
> > stmmac_adjust_systime() under est_lock.
> >=20
> > Both operations change the PHC system time, so both invalidate the
> > absolute EST base time.  With settime64, a concurrent
> > tc_taprio_configure() can read the pre-step clock through gettimex64()
> > and program EST with a base time that is already stale once TSINIT
> > lands.  Separately, a taprio offload installed before the clock_settime=
()
> > is never re-based and keeps running with its old base time until taprio
> > is reconfigured.
> >=20
> > Take est_lock for the whole disable/step/reprogram sequence, as
> > stmmac_adjust_time() does: disable EST before initializing the clock and
> > call __stmmac_setup_est() afterwards so the base time is recomputed from
> > the reserved taprio base time and the new clock.
> >=20
> > This keeps the established est_lock -> ptp_lock ordering:
> > stmmac_init_systime() only uses readl_poll_timeout_atomic() under
> > ptp_lock, and __stmmac_setup_est() takes ptp_lock through gettimex64().
> >=20
> > Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler =
API")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>=20
> This LGTM, the return values from stmmac_est_configure/__stmmac_setup_est=
 are=20
> ignored though, the [cl|s]ashiko gang may not like that.
>=20
> Besides one of the EST commands timing out, it seems unlikely though.

I used the same approach used in stmmac_adjust_time(). I guess we can update
both of them if required.

Regards,
Lorenzo

>=20
> Maxime
>=20
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > index 31a66e855d6b..6370bdc6c58b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> > @@ -129,10 +129,19 @@ static int stmmac_set_time(struct ptp_clock_info =
*ptp,
> >  	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
> >  	unsigned long flags;
> > =20
> > +	mutex_lock(&priv->est_lock);
> > +	if (priv->est && priv->est->enable)
> > +		stmmac_est_configure(priv, priv, priv->est,
> > +				     priv->plat->clk_ptp_rate, false);
> > +
> >  	write_lock_irqsave(&priv->ptp_lock, flags);
> >  	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
> >  	write_unlock_irqrestore(&priv->ptp_lock, flags);
> > =20
> > +	if (priv->est && priv->est->enable)
> > +		__stmmac_setup_est(priv);
> > +	mutex_unlock(&priv->est_lock);
> > +
> >  	return 0;
> >  }
> > =20
> >=20
> > ---
> > base-commit: 22b7cb932c6a0f7566d41072be6956cb6c8af4e1
> > change-id: 20261111-stmmac_set_time-est_lock-f74f4ce678b7
> >=20
> > Best regards,
>=20

--8vOlyl6HxoyVuXhq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavbOwQAKCRA6cBh0uS2t
rP9pAP0We69d9Ja/MXjMeW89Cr8mxmls0sCUfHoNch9W4wFTyQD+PQGPg/6xOrPm
7DwhYebqBdZ1m1ZFNeW4g5iWhoPSsgs=
=OVPM
-----END PGP SIGNATURE-----

--8vOlyl6HxoyVuXhq--
