Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144E46DFF1;
	Wed, 16 Sep 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545759; cv=none; b=Rdtd3Ilw/zv4Bb/zxNqHv7EiO1UZPDg65Zv2l6iLJLwfbluSqJPzDonXKZjn//PGacsJUhCQavKmMbtO102JeScp1vuTuKpZbmRtD8RF5WLlJ1nu4gALbg8StEy1i2/y7ADjhNrtXZkVCtBW1wuHaagtT5bM6EOF9E4fMdXXxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545759; c=relaxed/simple;
	bh=zPCY6/vUjWDI+sFBANAGcLfIUObtGn4bFnBc8Fjrn40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYoePU85fcVDZCN0m05cdbVe7iQ96bgU3J2DYAzeng9hUGi2VuD+7+MzPMFF69+H/lxParaLpuIRPhq3krsrLKV6NeyFZ7BuNuwJRn54TsSQ53ieuEYu0pkgHSA7xKdyS9vZKlRCOu+3sJpLRyWgyfDZCmg+Os2uHX/RiAAZtpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=1ti+bg6o; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="1ti+bg6o"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id BD2FE424F0;
	Wed, 16 Sep 2026 18:02:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789545728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qySEvs8hSKqFW9xRbMnFJTfjwY1BWKalrlpW2SDfROM=;
	b=1ti+bg6oQ0pvM5B9lpqBTOzlQQQRN2HUkiO1sKJvUdK+t8WqTnb3l3iXJfbLU31bcj2WU2
	Q+vZ0sPRUkFymCQciORp9qEReBUuqz64To8pjdEfCMaG8dJHbMjFchecehW1e/ooZz7b8d
	EhEWI9J7fRcZGo9Q0yEBIrXD+te4Mv4PSKqd+O6OMS0TDYzA7Cgq7gsO1pMsTJ6RAmMS7F
	6Ogcgssfprnnfu02QKpZBzAaJvdApxWeoWyTF8DUcAQoTZFtXGXW8ZqVqVFnzj/P1mWnbS
	uOZMKGoJCscQiyeL4ed7T0dEXkNyxbE9JtzuM6bowZicxJ8KgBkl/26c4kC3rw==
X-GPT-Reason: legitimate; the email is a technical discussion regarding
	Linux kernel patches (net-next) for Allwinner H616/H618 hardware,
	which perfectly matches the technical nature of the "alastair@d-silva.org" mailbox;
	 the sender domain "d-silva.org" aligns with the "From" header,
	and the content is a detailed, multi-paragraph engineering analysis
	with no signs of marketing, phishing, or urgency; there are no URLs
	or suspicious requests for credentials, and the conversation thread
	follows a standard developer mailing list format.
Message-ID: <a5fed5614eb09f958772fae636e748069851e059.camel@d-silva.org>
Subject: Re: [PATCH net-next 0/4] net: Add Allwinner H616/H618 EMAC1 and
 AC300 EPHY support
From: Alastair D'Silva <alastair@d-silva.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, James Hilliard
	 <james.hilliard1@gmail.com>, wens@kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>,  Russell King <linux@armlinux.org.uk>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "David S . Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, 	netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Date: Wed, 16 Sep 2026 18:02:08 +1000
In-Reply-To: <3196ccec-7cf3-434b-b7bb-dec64fe29583@bootlin.com>
References: <20260916044119.475666-1-alastair@d-silva.org>
	 <CAGb2v64HZoqBscyKTkTin6DnMv5_kZpBxoS+cm7aYy09pRc7hA@mail.gmail.com>
	 <CADvTj4qRMviM=KXinCKi657pVC_kj7Kt1yizW_EGDu4m7VKQFg@mail.gmail.com>
	 <2ac659ffa08eeddc6654827f5a8fbd7fe374a128.camel@d-silva.org>
	 <3196ccec-7cf3-434b-b7bb-dec64fe29583@bootlin.com>
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


On Wed, 2026-09-16 at 09:06 +0200, Maxime Chevallier wrote:
> Hi,
> On 9/16/26 08:49, Alastair D'Silva wrote:
>=20
> > There is one subtle timing issue worth highlighting from our
> > Armbian
> > testing on the Mellow Fly-C5 (H618):
> >=20
> > In James's dwmac patch, setting soc_has_internal_phy =3D false causes
> > sun8i_dwmac_probe() to fall through to sun8i_dwmac_reset(priv). The
> > Synopsys EMAC DMA soft reset (EMAC_BASIC_CTL1 bit 0) requires a
> > running
> > RMII clock from the PHY to clear.
> >=20
> > While this reset succeeds when the PHY driver is built-in and
> > probes
> > synchronously, if CONFIG_XPOWERS_ACX00_PHY is built as a module
> > (=3Dm)
> > or if the PHY probe defers (-EPROBE_DEFER on
> > regulator/clock/nvmem),
> > the PHY is unpowered and not clocking when sun8i_dwmac_probe()
> > runs.
> >=20
> > This causes sun8i_dwmac_reset() to time out after 100ms ("EMAC
> > reset
> > timeout"), failing MAC driver probe. In our testing, deferring the
> > MAC
> > reset until sun8i_dwmac_init() (which runs upon ndo_open after
> > phylink
> > has attached and the PHY is active) avoided this probe failure.
>=20
> I'm OK with going with James' version, however this seems like a
> valid
> point that needs to be figured out.
>=20
> James, can you add Alastair in CC of your next iterations, and
> Alastair
> it would be great if you could give James's patches a test when he
> submits them :)
>=20
> There's more stuff in the dwmac part for Alastair's version, some
> -EPROBEFER handling for clocks, the reset thing as well as the MUX
> part, for which use-cases is all of that required ?
>=20
> If that's something that needs to land with proper EMAC1 support,
> maybe
> this could be split out from Alastair's work (in individual patches
> please), and integrated in James's series ?
>=20
> Maxime

Thanks Maxime. Here is the breakdown of why those pieces were in my
earlier patch and how they relate to James's series:

1. MDIO MUX & H3_EPHY_SELECT:
   These are NOT needed for James's series.
   My initial test tree was using the legacy
   "allwinner,sun8i-h3-mdio-mux" node inherited from older
   vendor/Armbian DTs. That mux driver attempts to toggle
   H3_EPHY_SELECT (bit 0 of SYSCON), which on H616 register 0x34 is
   actually SYSCON_EPIT (interface type), so I had to mask it out.
   With James's series, there is no fake mdio-mux node (direct MDIO bus
   with the ethernet-phy-package), which is much cleaner and completely
   bypasses all H3 mux code.

2. -EPROBE_DEFER handling in get_ephy_nodes():
   Also NOT needed for H616 EMAC1.
   get_ephy_nodes() is only called when soc_has_internal_phy =3D true.
   In James's series, all PHY clocks, regulators, and NVMEM cells are
   managed inside the PHY package driver
   (drivers/net/phy/xpowers/ac300.c), where -EPROBE_DEFER is already
   handled cleanly via dev_err_probe().
   (The get_ephy_nodes() fix is only relevant as an independent=C2=A0
   cleanup=C2=A0for legacy H3/V3s platforms).

3. MAC Soft Reset timing (The one piece that IS needed):
   This is the one issue that affects James's series.
   Because emac_variant_h616_emac1 sets soc_has_internal_phy =3D false,
   sun8i_dwmac_probe() falls through to line 1221:
       ret =3D sun8i_dwmac_reset(priv);

   The Allwinner EMAC DMA soft reset (EMAC_BASIC_CTL1 bit 0) requires
   the RMII clock from the PHY to toggle in order to complete.
   If CONFIG_XPOWERS_ACX00_PHY is built as a module (=3Dm), or if any of
   the AC300 package resources defer probe, the PHY is unpowered and
   not clocking during sun8i_dwmac_probe(). sun8i_dwmac_reset() will
   time out after 100ms ("EMAC reset timeout"), aborting the MAC probe
   completely.
   For EMAC1, skipping sun8i_dwmac_reset() during probe and letting it
   run in sun8i_dwmac_init() (which runs upon ndo_open after phylink
   has connected and the PHY is clocked) avoids this probe failure.

James, I'm happy to test your next revision on physical Mellow Fly-C5
(H618) hardware as both a builtin driver, and a module.

--=20
Alastair D'Silva
0493 18 5566
