Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C13AE6F6;
	Tue,  3 Mar 2026 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563034; cv=none; b=AXNnHRivDlMP+7L6ALWh/HMnZI0l8BBlxnXIC3Sc4+cQ+9wU1t+BElnbovshFMNSrp8GXt12XKjxmyUyH62XNQGs31WR+zdle1wvRtqDIUzhbHPKVoEt77QBwTbHCWwPEkE9+6cfWb+OV+fsXDAjfRdCr83r6GyHG0DgVloguCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563034; c=relaxed/simple;
	bh=kwOmp+qzdCBCeL8vOcckdV89zWe7a57AR+uVS2+JelA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGQvuKkVSmwYIGvmnFffiSBRiMRMsGoC0eo5oQLtA68kM2sGu1jiATPjIold9QjKL8lmg2CERRWkLTDCtVssDjjP7YdX1N91C/zBk5piTw8CSWXS704/nmvcy+wMEqdOaLyfldTkb9rKPGU7z4ZB2DRI9/muJcdV2IC76N4z5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9PBuaK3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9PBuaK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BCC116C6;
	Tue,  3 Mar 2026 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772563033;
	bh=kwOmp+qzdCBCeL8vOcckdV89zWe7a57AR+uVS2+JelA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9PBuaK31MG6Z/um9L8vhMteALXVjLa0QbxG/iN+F8Q4YEjU0CepE2DDZY9GX+pAc
	 Pg941bNaRoFS4VJKSFUrvSq+MHMqEcSDg6vEjV9jg1jsYa1pBCA2EgXYtjPfLBYPwa
	 i7sYHbf6/SwPJOSp8M4oNcCmxd/N+NO4ZQ9ocfErXyJmbSj8aGccY4CirW24GegSiD
	 pH4jJg3dhBsutyIUKpAJztSm1ftG6W/RbHTGtS945KtXrOA+ClhR7spZ2P16fNsf0R
	 VuHdyeGswojjcqfVT9+ybSwD9skyO6CkpHqm+mvdzNg3bWbXlrf0ywpr966OEj7A+S
	 EUGcZTRbT5JsQ==
Date: Tue, 3 Mar 2026 18:37:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: sff,sfp: Describe power
 supply pins
Message-ID: <20260303-mocker-hydrogen-46039709225e@spud>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-1-7101ae34cb84@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V/AaYsTivkyNLhEy"
Content-Disposition: inline
In-Reply-To: <20260303-sfp-regulators-v1-1-7101ae34cb84@bootlin.com>


--V/AaYsTivkyNLhEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 02:54:26PM +0100, Romain Gantois wrote:
> SFP cages and soldered-on SFF transceivers have two separate power supply
> pins: one for the transmitter circuit, and one for the receiver circuit.
>=20
> Describe these two pins and the regulators supplying them.
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--V/AaYsTivkyNLhEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacqUwAKCRB4tDGHoIJi
0vWxAP9iqqHYRAkj1N4dKuJIqdl0zBlBdDr+OGxtGd8l8WsRPgEAjj2m9niGL747
VRgVLWjNw7LUdDKzizSE0KOU9/nZ7gg=
=GHMH
-----END PGP SIGNATURE-----

--V/AaYsTivkyNLhEy--
