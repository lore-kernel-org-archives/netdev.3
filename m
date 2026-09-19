Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEA3ACF1D;
	Sat, 19 Sep 2026 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780080; cv=none; b=DjWEf+/uaiul7I0iWlJv/auFri3gY1SXKPxs54Z4bTd6eXZgcKMFYI14EMrbG/MtJlpZrQsYlWx5AcuExz61wkAAccfnSPEpeeAiV/aT5Qky9Ey/vH4juISXkTGh7esulpcS7bLy581dtZcX8KTrFmGWrCulkVZAcgzOqt8Jkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780080; c=relaxed/simple;
	bh=6HewLLL8ipgY9ww2B3n9+2RGXN10iLBb3PUHWKJHjHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c86rJtf7ZZ2MTu4xqHokt7oIkJdFCdBaSll5PPJ7j5bcOS1XwLYQ1HqzGKKOrIEfZglbd8slIBLP0hAwk9kJmj6cjwd61sUDlGENn3KLYpZ178tP9nsZ4roERVepx9C2lmMPxOJF3MPpfSycGZBYBWZFj+iZq+BS+y50cF+7W6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=JF4OYFnz; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="JF4OYFnz"
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 551E140497;
	Sat, 19 Sep 2026 11:07:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789780051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6HewLLL8ipgY9ww2B3n9+2RGXN10iLBb3PUHWKJHjHA=;
	b=JF4OYFnz5uVwSTxfHxbiXOwgyD1ltxZwUJokhs/GboS1lWV2BGfUDtEpycPy0epafOFMww
	/ideq4L0YJLp4kwiHDr5Sq8u/mdXbsXynYgW/l9uGHbXoguumsI/Zy5wxbEHU2gnGu0t8P
	MfvQTuCHWNIsYVvqooav+p2J6x6Ufi/PkdAUftABbjc5qsdFVyXzKlxGZqEWYqcy0WzFHc
	S8nHxBCGAWjGTjvFRAVjClB3+2W8x/mNIfuDaGCmOqNsG13X646mqz9pjl7mHdNOn5zbxq
	0wHXVtCGyKQXwwok0npnNsev4zL+mdzuS49ghAOdcEnRxMsrtrkM4Pc0YrX9oQ==
X-GPT-Reason: legitimate; the email is a technical discussion regarding
	Linux kernel patches (net-next) and contains highly specific engineering
	details about stmmac drivers and Allwinner H616 EMAC support; the
	sender identity (alastair@d-silva.org) perfectly matches the recipient
	mailbox (alastair@d-silva.org), indicating a personal/professional
	communication; the presence of a link to msgid.link is consistent
	with standard Linux kernel mailing list practices for patch submission;
	there are no indicators of phishing, urgency, or unsolicited marketing.
Message-ID: <ae87fcbacadb7447d5e249c03f43a49ee49cfdce.camel@d-silva.org>
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: add Allwinner H616 EMAC1
 support
From: Alastair D'Silva <alastair@d-silva.org>
To: James Hilliard <james.hilliard1@gmail.com>, Richard Genoud	
 <richard.genoud@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro	
 <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Chevallier	 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Sat, 19 Sep 2026 11:07:31 +1000
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
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

On Thu, 2026-09-17 at 11:55 -0600, James Hilliard wrote:
> The H616 secondary EMAC supports RMII at 10/100 Mbps and uses a
> separate
> system-control clock register at offset 0x34. Add its binding and a
> sun8i stmmac variant using that register. A distinct compatible
> without
> an older fallback prevents the driver from using EMAC0's clock
> register.
>=20
> EMAC1 connects internally to the co-packaged AC200 or AC300 EPHY and
> has
> no external PHY pins. Leave PHY initialization to the PHY driver
> instead
> of using the H3 internal-PHY controls. The RMII-only variant does not
> expose the RGMII clock-delay properties.
>=20
> First move the MAC software reset from probe to the DMA reset
> callback,
> after PHY initialization. This lets the MAC and its MDIO bus remain
> registered when the PHY driver or one of its suppliers is not ready
> yet.
> Keep the separate H3 MDIO-mux reset sequence unchanged.
>=20
> The AC200/AC300 EPHY driver and package bindings are already in
> net-next. This series separates the H616 EMAC1 MAC driver and binding
> support from the earlier combined series. PWM, MFD and device-tree
> enablement are being handled separately.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v3:
> - Add a prerequisite fix moving the MAC software reset to the DMA
> reset
> =C2=A0 callback, after PHY initialization, so delayed module loading and
> =C2=A0 deferred PHY probes do not tear down the MAC and its MDIO bus.
> - Preserve the H3 MDIO-mux reset and propagate hardware-reset
> failures
> =C2=A0 through the normal stmmac hardware-setup error path.
> - Add Alastair D'Silva to Cc and rebase onto current net-next.
> - Link to v2: https://patch.msgid.link/20260915-submit-h616-emac1-v1-
> v2-0-322b32e40eb9@gmail.com
>=20
> Changes in v2:
> - Drop EMAC1 TX/RX clock-delay property support and keep the existing
> =C2=A0 RGMII-only delay descriptions unchanged, as requested by Maxime
> Ripard.
> - Clarify that EMAC1 connects internally to a co-packaged PHY, not an
> =C2=A0 external PHY or the H3-style internal-PHY controls.
> - Rebase onto current net-next.
> - Link to v1: https://patch.msgid.link/20260915-submit-h616-emac1-v1-
> v1-0-195de0bb1f8a@gmail.com
>=20
> ---
> James Hilliard (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net: stmmac: sun8i: reset the MAC after PH=
Y initialization
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: net: allwinner: add H616 EMAC=
1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net: stmmac: sun8i: add support for Allwin=
ner H616 EMAC1
>=20
> =C2=A0.../bindings/net/allwinner,sun8i-a83t-emac.yaml=C2=A0=C2=A0=C2=A0 |=
 13 +++++
> =C2=A0.../devicetree/bindings/net/snps,dwmac.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c=C2=A0 | 66
> +++++++++++++---------
> =C2=A03 files changed, 55 insertions(+), 26 deletions(-)
> ---
> base-commit: 26ee8cd69d46a14b37ba5e512084fe80d730127a
> change-id: 20260914-submit-h616-emac1-v1-143703842abb
>=20
> Best regards,
> --=C2=A0=20
> James Hilliard <james.hilliard1@gmail.com>
>=20

Tested-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by:=C2=A0Alastair D'Silva <alastair@d-silva.org>

As a follow-up (non blocking), I would add the LED control registers I
mentioned at the bottom of my test results.=20

--=20
Alastair D'Silva
