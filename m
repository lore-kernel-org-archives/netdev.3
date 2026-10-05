Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F92E975E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195138; cv=none; b=p+EmcrSILkrlMAbB6gNoWD2iklk693NfNEA9e/k4tl7nlpOZXWiEU5sq6FveKe7ZkA/Pbrbsdxy8ZIOOG3hTimztFu8R8fSNE6IIr01tXRqUAoG5+jNPoZ+9paFeP7xMy3zxgNsLK6EbNFgO4gmb+VnxE+OEwqVTa9g+ZSPt48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195138; c=relaxed/simple;
	bh=29Ynm9Vz8sSrTkrm8NDeRK/xaPFNEqxziwHyw7DDe3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5vt/o3d2RjAO4etzeytXyTZHei6HDfBHb3srP3a7wGzeiawOSMRPB5cEZ3mbfz6jmGC4Ce50i3gRnCDigEixKV8RaHOJnuJz6E3XdzM1vw0E9dCnMSNksEUmhrnspi4zE8cm1iFh5/1u7VgwAlYP35nh/VV0AXsfH6vwoMWcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJspakl/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXSfS4Wg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJspakl/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXSfS4Wg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6958xRw12471563
	for <netdev@vger.kernel.org>; Mon, 5 Oct 2026 10:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wTpXd2xcXmR9jaqSnaJI/lPy
	n8DKYRE9YWWV6/HaoMI=; b=HJspakl/D69qWYxop7Ch866rgarzmM6aBt1VrN/G
	mcmGUKHdvQegqiobw9pjzMJyk88qynk/bAwRJ8hee69FbTgmQwjII0/kMv/4bHBi
	yaO9LB4EE7bUhqLe6/Lp4U9zEi58ZoBb5+xJFk1dmWhi7VxQDwzH4eD7vyn0QkjG
	DzgapdM/0CcFy+qFiD8mWVOWICllHIUFCwxj+ub9F8tixnifo0lg5M0+TiQKtK0j
	V2Y42MEmZUtaVPGIAl0WC0p47TUY8agIlaLT/ihZPi+hvQquefxBqF5jiC3B/A2b
	zLvU1/F2ib4w16ekdF5rLkklPU+ym0gdsIa0BnP/uw2lqA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssncmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 10:12:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a3f673221so358887085a.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791195135; x=1791799935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wTpXd2xcXmR9jaqSnaJI/lPyn8DKYRE9YWWV6/HaoMI=;
        b=IXSfS4WgnmwKuuM/ALrarsFVR6Fbwb0DXC7HML0DvrrOSvNa0iCUZuUOdrellnnH0r
         szpf3o6CkPEx+Mp3VxJyq0CnapjBZK5O/ZzEvp/YAZNPSvwFCTc9zsqw8xJRyu+ajNz9
         9ZRH3ZyG1AWkGCyGhUNOFFp3HjOEHzedmeXXYxElBODEtRKXwgoO/EkcSxESZc3F4pQz
         zDtTEkpPDMYmd7EI3JDG4sI1WMzM9C2UNWUEOdqy0jrx2/9q5CpQURTKUekDtx+1r+aV
         JDISkidqOImP6tVCFpqcvtmCr8tZU91KLwPBsQkEffooliKouN/oupV/lwsA1ASJBbDe
         qVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791195135; x=1791799935;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTpXd2xcXmR9jaqSnaJI/lPyn8DKYRE9YWWV6/HaoMI=;
        b=szrUTlrfVvpq9G3K5U1ROaBB42yppjU88dd+vwgUnBF0fMuQ4oumOHNcq5IPie4C7j
         ayxf2REpy3i+XiSVZkS1JjVJ1mEaSFRq0+KvqhjKU4zt056Lul/1RT5KGKCTKQKXofgH
         Wr1lASluS+v9nuUqJgjawqVKomq5/+RVdunmWv1h0o5C8bdwZAHdQ4a6r91yBcm/ules
         J/FR9aAs3VQjEoibT6PaNpmxAmgeHaQZxWPTlxPzHTWh0nqDuaKHQLXOry1635I+3Crv
         VjbaNf3skebnD8yOb2VezfQXWAF2r3wu95mgQTy6RSUwq3XspWEA5tn538bnVfBn2UXJ
         8Mpg==
X-Forwarded-Encrypted: i=1; AKwUvBz0CF+TMLzQ/E/dhy98UWXPVCX47KHfyvAMS4MrywM6oSTTSziCOMFAzAvXvQVHswNYGWomMcQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mOdIC/puJsiEorncuYnBR8n9w/R1FR9ugTmb1FTlMJir8DvcpC
	UH31i/sr9olYZZ4izDcTvMSp5TCF1tS4gNE65K0KWjR0JAClExCqlOWkhu7r2Ay0G6Cxo4nTVX8
	vtRYxqCH2vmwYWtjl4YwJMa8sW4eZ3frSEY3dolxLeBWi1d/XWxxj+oEjqOU=
X-Gm-Gg: AYBFou0NDDYZ2d3XV270y+9Pbj4+3qVpAp4fGeIzWeV9MDVVTUTaIeNLMkeQiYTi9Xo
	V7bC4SfwJktQkroxCBcivztm3STq/GeKn8SjiSstIzb2CDD67J2fwSVaMDS7qWm4H9OTPWE4plp
	C76TyFHSVygtEnNQY5x/wlDQ39c/kPowwQfHiRygq81Rk8IGhDTfoXYAYxMSRYp8a6jrQoDgIFn
	VuMru5L9V4j0E61GYLKWCojSSkznGFa/zGqr5N2dvu1uMpWb6ixYNxmgdIpXWpfHiUOhdkrHPfx
	EQn9rWnPDLNy+q0/5zj7Wl8sq6KpvM5sQZXoCa+P2u6ziyvZignBBljkf/mgITsipsYcx6Yf/f9
	fIzf4c33szbVtPw==
X-Received: by 2002:a05:620a:6f92:20b0:939:a834:98f2 with SMTP id af79cd13be357-93ce7c126d3mr1270435185a.15.1791195135323;
        Mon, 05 Oct 2026 03:12:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6f92:20b0:939:a834:98f2 with SMTP id af79cd13be357-93ce7c126d3mr1270430585a.15.1791195134577;
        Mon, 05 Oct 2026 03:12:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm306620895e9.15.2026.10.05.03.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:12:13 -0700 (PDT)
Date: Mon, 5 Oct 2026 12:12:12 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, sdf@fomichev.me, boon.leong.ong@intel.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: fix TX coalesce race and
 div-by-zero in XDP/legacy path
Message-ID: <asN3_ExreXflhcPN@lore-desk>
References: <20261001-b4-stmmac-xmit-mb-v4-1-664e0c3eb289@oss.qualcomm.com>
 <179119366947.434549.18258387588944949725@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfQjmt/PTQh8Ar59"
Content-Disposition: inline
In-Reply-To: <179119366947.434549.18258387588944949725@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzOSBTYWx0ZWRfX20eqZINDFHx2
 mJwZjSGDI311iYVFiJ9bB0GW0bAkapOQsqS/wIJGtQ3WyN3Ik0tt7RLRY700+Bj+i+D5PwsRIF6
 5TV+kf8mReBDeIlw/xagq73qMPlc3uQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzOSBTYWx0ZWRfX5174H9iAfXEV
 dhNUChXNb3+csA1r+HfpSlB4HTPu7SyxQWKCGCuBn2pSywWZB3kcxBuL4NoZIOZxx6U94pDknd5
 THL3oIkjYCpNX9mw6Zf9wyEESciX9rJ9gY1bW3XiPAKro9iP5W7keOU44LywnsCch9kLEyAwRXq
 0+3FwHFJaafn73+GBeMqq3gXulP1c32linCFWdwkmpZrEXn8r4LM/005fyV9E4D8aSe+e9GStMa
 hBmPhPdlTwtDccpQ6GYhemKo89CfHBvIHUg0mbA7sEnkN9gFLxbZRS1ghsEjDC5t01IGrodELEH
 J0M/Gn/Cwl0poYDYQImHL0CkaWzWsB11+3cgZM3gtX7ENGCamT8/kdeI2bS3msTcTxzpAAtxKds
 tLHR1NE1jdxb2BTGsG79m6Spe4TP2FbGkDHCR2qDYYP+yoMkh3ICCrcmfkBqN8cbtmLJnlriNhr
 e7HG2RgB0ZVFUFXHepw==
X-Proofpoint-GUID: CFQwzKHeotqsrjknFZeCfu2zjrPJeUyq
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac37800 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=9R54UkLUAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=hMNoLFnnqX5p7295vMQA:9 a=QEXdDO2ut3YA:10
 a=UvE2pUckuqDNxODme40A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: CFQwzKHeotqsrjknFZeCfu2zjrPJeUyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050039

--UfQjmt/PTQh8Ar59
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 05, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>=20
> - [Medium] The commit message says the stmmac_xdp_xmit_xdpf() divide-by-
>   zero is "only theoretical", but a privileged user can trigger it and=E2=
=80=A6
>=20
> Pre-existing issues:
> - [Low] __stmmac_set_coalesce() publishes tx_coal_frames[q] and
>   tx_coal_timer[q] as two separate stores and shares no synchronisation=
=E2=80=A6
>=20
> --
>=20
> net: stmmac: fix TX coalesce race and div-by-zero in XDP/legacy path
>=20
> This patch wraps every access to tx_coal_frames[] in READ_ONCE() or
> WRITE_ONCE(), since ethtool writes the array while the TX fast paths read
> it without a lock. It also guards the modulo in stmmac_xdp_xmit_xdpf()
> against a zero tx_coal_frames[queue].
>=20
> > Both issues were found by code inspection while extending the XDP TX
> > path with multi-buff support, and neither has ever been triggered, so
> > they are only theoretical. Tested on the Qualcomm RB3-gen2 board.
>=20
> [Severity: Medium]
>=20
> Is the division by zero in stmmac_xdp_xmit_xdpf() really only
> theoretical?

with 'theoretical' I mean I spotted the issue with code inspection and I ha=
ve
never observed it in practice. I agree this is a real issue.

>=20
> __stmmac_set_coalesce() only rejects the case where both values are zero:
>=20
> 	if ((ec->tx_coalesce_usecs =3D=3D 0) &&
> 	    (ec->tx_max_coalesced_frames =3D=3D 0))
> 		return -EINVAL;
>=20
> So "ethtool -C ethX tx-frames 0" is accepted. tx-usecs keeps its default
> of STMMAC_COAL_TX_TIMER, and stmmac_ethtool_ops advertises
> ETHTOOL_COALESCE_MAX_FRAMES. After that, tx_coal_frames[queue] is 0.
>=20
> >From then on, before this patch, every XDP_TX verdict
> (stmmac_xdp_xmit_back()->stmmac_xdp_xmit_xdpf()) and every ndo_xdp_xmit
> redirect into the device would evaluate:
>=20
> 	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] =3D=3D 0)
>=20
> On x86, for example the dwmac-intel platforms that advertise XDP
> basic and redirect, this raises a divide error in NAPI softirq context.
>=20
> On arm64, UDIV with a zero divisor returns 0 instead of trapping. That
> may be why the RB3-gen2 board never hit it.
>=20
> CAP_NET_ADMIN can trigger this with standard tools. Could the commit
> message describe it as a reachable crash rather than a theoretical one?
> Would it also make sense to send the div-by-zero fix separately from the
> READ_ONCE()/WRITE_ONCE() annotations?
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/dri=
vers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > index 1cf0f8820b337..30e0d499326d8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>=20
> [ ... ]
>=20
> > @@ -887,14 +888,14 @@ static int __stmmac_set_coalesce(struct net_devic=
e *dev,
> >  		int i;
> > =20
> >  		for (i =3D 0; i < tx_cnt; i++) {
> > -			priv->tx_coal_frames[i] =3D
> > -				ec->tx_max_coalesced_frames;
> > +			WRITE_ONCE(priv->tx_coal_frames[i],
> > +				   ec->tx_max_coalesced_frames);
> >  			priv->tx_coal_timer[i] =3D
> >  				ec->tx_coalesce_usecs;
> >  		}
> >  	} else if (queue < tx_cnt) {
> > -		priv->tx_coal_frames[queue] =3D
> > -			ec->tx_max_coalesced_frames;
> > +		WRITE_ONCE(priv->tx_coal_frames[queue],
> > +			   ec->tx_max_coalesced_frames);
> >  		priv->tx_coal_timer[queue] =3D
> >  			ec->tx_coalesce_usecs;
> >  	}
>=20
> [Severity: Low]
>=20
> This is a pre-existing issue and was not introduced by this patch.
> tx_coal_frames[] and tx_coal_timer[] are still published as two separate
> stores, with no synchronisation against the TX path.

as pointed out by sashiko, this is a pre-existing issue and it needs to be
fixed with a dedicated patch.

Regards,
Lorenzo

>=20
> Can a concurrent stmmac_xmit() see a mixed pair? Take a change from
> (frames=3DN, usecs=3D0) to (frames=3D0, usecs=3DU). The TX path could rea=
d the
> new frames value:
>=20
> 	tx_coal =3D READ_ONCE(priv->tx_coal_frames[queue]);
> 	...
> 	else if (!tx_coal)
> 		set_ic =3D false;
>=20
> It could then read the old timer value in stmmac_tx_timer_arm():
>=20
> 	u32 tx_coal_timer =3D priv->tx_coal_timer[queue];
>=20
> 	if (!tx_coal_timer)
> 		return;
>=20
> That frame would then get neither an IC interrupt nor the completion
> timer. Its completion would wait for the next TX or NAPI activity on that
> queue. The same window exists for stmmac_tso_xmit() and
> stmmac_xdp_xmit_xdpf().
>=20
> READ_ONCE()/WRITE_ONCE() make each field consistent on its own, which is
> all the commit message claims. The window across the two fields is still
> there.
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289%40oss.qualcomm.com

--UfQjmt/PTQh8Ar59
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCasN3/AAKCRA6cBh0uS2t
rHGpAP4u5rsRmhyEgCWlJ1hLUiJ6poy7UiqYIcRNsGH2h4wwIgD/SAI26R14/nqi
gX/DwdFmAvUo2UpQ/YeWx60UO70Togw=
=Hpyz
-----END PGP SIGNATURE-----

--UfQjmt/PTQh8Ar59--
