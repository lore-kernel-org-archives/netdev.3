Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE622D78A;
	Tue,  3 Mar 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547767; cv=none; b=Liu9w4ACIVZaaUw8gTBSHGUsUtpbU/65iF2rs5rkeEl3Z6Dir4FDaU4p+MieIg0SKTtqDut/wD7SlVLGmHeFN+4x6y24wlocWfD2ShLt7bc0ZfzWroE/cNXcH1xgNhuMXTOlJmae15FFofr4K3b3rLOBFscC2L8beLRQa/RFwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547767; c=relaxed/simple;
	bh=fmIzBeG7V3dFsTj5XgLJ7EJA0//bJ27nvbhrB//k1wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap1trlufDb3+1iZj99PoUdMUwpI0yz3vbBByunj0GJcZEJAjN4pBVOaVyAx9BGJc6DLvQaWM7chod9Y9dLFkZWhRW2bTkhu/iqL3BUNIcTod9avZBerC8K7Fts2h/Ml29CPuZGB7dEp+SW7ZfYWtH+p0fbKI7ZKmRxsbQrMM0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk6hCvQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk6hCvQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10725C116C6;
	Tue,  3 Mar 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772547766;
	bh=fmIzBeG7V3dFsTj5XgLJ7EJA0//bJ27nvbhrB//k1wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk6hCvQPidzD1efpFbAYnrMAPm5N3CXZAdHFZaqra+BYXPez/glHWpiyYaDdbgngx
	 36hG9x8V4hwQ59nPMzI82DPQoFcMryBWuXkEj0gGXrNM23mxCvuCiblIzxJX/t29rg
	 5Y+q39J7vsBz890ijfyhHSek1GjNNT8pd+Jugedr6bis6AvhCNFvPEjPYc4Dixi2cL
	 00xD233xxuboZZSxRvrhPTe01UQo5i46pODgVQmVFF4rKfYiUTLbOgppC6+ZSzpInL
	 /v9jssqIF1q1Tigg9Y45ejMIUOd+cA7RgFvacS6H5lFYaoPijvw/wqmvqwyOY81zsN
	 JmkCP3hdHEugQ==
Date: Tue, 3 Mar 2026 14:22:40 +0000
From: Mark Brown <broonie@kernel.org>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p/30oyvGo8fa1FjH"
Content-Disposition: inline
In-Reply-To: <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
X-Cookie: Use the Force, Luke.


--p/30oyvGo8fa1FjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 02:54:27PM +0100, Romain Gantois wrote:
> If phandles to receiver and/or transmitter regulators for an SFP device are
> found, enable them at probe time.

The driver should unconditionally request whatever power the device
needs.

--p/30oyvGo8fa1FjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmm7q8ACgkQJNaLcl1U
h9DIUAf+IFtRN8RW/wPpZlRhg1JC6tm3i1AHNUDZi6oX3sR8/67YGqwDcr2sp+2j
f87HeZh7bt/qKhZlWxihEgtyHKF17+DAihZa8vSTs5uYKoey7Gf2AmnLZRUR5csy
U/eBA4m0wW/pungnlZOpeF0n7CSffCrAfQXrIuCqttjPavmooM62PPE+tyum59oI
KiVm8ylnoguxVm0ULE8VyWViNzUAvCe1L136+ksuU6BGYrbe/EKm9PKq9CwdXvLb
Ns0KUkqyvowvyuUEeLpKc1R94b0TOblQU8iuRVzzo2b/pz95vi5eaIHRCTX9kZkb
VxkDnBZItz6LV4ckzZt9rdBZYUw1Ug==
=Rw+z
-----END PGP SIGNATURE-----

--p/30oyvGo8fa1FjH--
