Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE33BE146;
	Wed, 16 Sep 2026 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541118; cv=none; b=k7LUtZxJC9I09oJpCy8Yb0QFfFR8PBmWl9qhOucCYOmveAMqeo5EQKHVn21aAA4Y1eKnoGGERWPopko2iHJ6ufRkrbOjeuyFSmx2633+96UAEtq2CB3MFq3Hn4EgIgHvDMqmNZSwc1MKa1F/YcYImY465+zGsu0EyobaUb91y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541118; c=relaxed/simple;
	bh=M+Dy4hfdzKr1mC3pzwMJT0ZQBgMsvSHf4Z0mHzxQnL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVnt+vXHfFMjvY3o6HlBDutKWtSUcldKronLSm1SKZwiYv3qXDyxQANZz8xW1/XCcfRVTr6fjaF7vUyS3Zz7cLO9vm1NgAXdl76aLPHHrXYKelRlRGJw5AOG8sucwc3aMuspUSU1ekT9rBb78FeW92wTQOfDOqwk4xr10pBR5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=DnXOpwgv; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="DnXOpwgv"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 90DC240B5A;
	Wed, 16 Sep 2026 16:45:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789541106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M+Dy4hfdzKr1mC3pzwMJT0ZQBgMsvSHf4Z0mHzxQnL0=;
	b=DnXOpwgviacP2DhK2BYPRRrVyAIkSBt3eDumbyDy01rnRZwe63pGxFi3W4jlRmMeiSnnNf
	10o9KN5ENRAjkCFq3eDiz2dfrwqhLg0av0ilv1uz7MbEqJb38ejgYcn3DBRvqsGr2GlHTH
	PU999QCMrh0GHivRTeNnX3J9WG1CI8u6k9WFeaJ58KbpT+rkysguz8bKTgtwvTv76b6Iho
	vK1vVUKmPV2Lv9PrbPD/u6Gvt83tC5ZsWH0fsYugJfCZzLSoXD8jbTM/UyhFAfODn9r8Ae
	RJzMAH7c75wK4JH60HGaIShrKtjNjhLQ8bZ9Vz9SkO1llGJfv2nmLFdPzNkxeA==
X-GPT-Reason: legitimate; the email is a technical discussion regarding
	a Linux kernel patch (net-next) which perfectly matches the technical
	content of a developer-focused mailbox; the sender domain (d-silva.org)
	aligns with the personal mailbox (alastair@d-silva.org), and the
	content includes a specific code diff and a link to a reputable
	developer platform (lore.kernel.org); there are no indicators of
	phishing, urgency, or unsolicited marketing.
Message-ID: <4404f56f441a4f61e01ebde721ca0220cc96a948.camel@d-silva.org>
Subject: Re: [PATCH net-next 4/4] net: stmmac: dwmac-sun8i: Add Allwinner
 H616 EMAC clock index and internal PHY support
From: Alastair D'Silva <alastair@d-silva.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King	 <linux@armlinux.org.uk>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  "David S . Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, James
 Hilliard	 <james.hilliard1@gmail.com>, richard.genoud@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>
Date: Wed, 16 Sep 2026 16:45:06 +1000
In-Reply-To: <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
References: <20260916044119.475666-1-alastair@d-silva.org>
	 <20260916044119.475666-5-alastair@d-silva.org>
	 <579d7650-583e-49bd-aa51-02fc52940ea1@bootlin.com>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:24 +0200, Maxime Chevallier wrote:
> Hi,
>=20
> >=20
<snip>

> > =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 65
> > ++++++++++++++++---
> > =C2=A01 file changed, 55 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > index 48c52eb96233..1728893589a6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> > @@ -130,6 +130,16 @@ static const struct emac_variant
> > emac_variant_a64 =3D {
> > =C2=A0 .tx_delay_max =3D 7,
> > =C2=A0};
> > =C2=A0
> > +static const struct emac_variant emac_variant_h616_internal =3D {
> > + .syscon_field =3D &sun8i_syscon_reg_field,
> > + .soc_has_internal_phy =3D true,
> > + .support_mii =3D true,
> > + .support_rmii =3D true,
> > + .support_rgmii =3D true,
> > + .rx_delay_max =3D 31,
> > + .tx_delay_max =3D 7,
> > +};
> James's series [1] says this SoC only supports RMII (yet includes
> RGMII timing
> control), and here for seemingly the same device, there's MII and
> RGMII
> support listed.
>=20
> [1] : https://lore.kernel.org/r/20260915-submit-h616-emac1-v1-v1-0-
> 195de0bb1f8a@gmail.com
>=20
> Maybe you can coordinate with one another, can we connect that SoC to
> a non-internal PHY ?
> If so, can we use MII, RMII and RGMII ? or is it just RMII ?
>=20
> Maxime

I just double checked, MII & RGMII are bogus.

Only EMAC0 can be connected to an external PHY.

--=20
Alastair D'Silva
