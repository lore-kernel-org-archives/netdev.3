Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6C37EFEF;
	Fri,  3 Jul 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079012; cv=none; b=f2wkLqKcu/7attpXThgOoswv7jN0BNGn1nyt6I9NFcT5L4687GsdyeaBhGJNqx32ZffNyRuOnMP6EyHyRePPcCcefRd8dXxHxTJ7L26oAwU0Z1npgfGNHsxaeEwp4KCBlLBairhyF7sGYwL7GPAFI7fzkdWXMrCyfCfA+nyipVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079012; c=relaxed/simple;
	bh=2IeM7RAr37uQgMi3fIypMsLSilrjKtRAaVzIfgX/kAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYY/3xt1mLZtnZH0hgIaktF66ug00KyAhLWmSa3A4h3zmDPavLW/If25+2v7dKOZk2yBpzUEX16BgAKO3yjiTYPQrCIHakWePMPP9uE/oIxkHr/0eY8pRrI0ohDurZz5ME9KogXLpzg/BZpAWlmVxRDvOs9ToQnViIxrAk8Y8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0/a6txG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0/a6txG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF8F1F000E9;
	Fri,  3 Jul 2026 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079011;
	bh=2IeM7RAr37uQgMi3fIypMsLSilrjKtRAaVzIfgX/kAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j0/a6txGcmaZtfnwS8iuF+5v0clrpCiuR54sr7WWu7L1Eg134w/EYrIbNu+eA4vei
	 YmmKd0lYMJI4rUF1FsXsOGACX3aR9Ig8WseCdBDxTKMNrTf1UXffUl259gAOWJm8Xk
	 vhHE50cr0h91k3/D040s0DT1ANfOmXRHEdD71g5pwq/nSK4quiUwQmUEk1mqjXZc8C
	 WRTxGoVszyPbQNojk0XE9AaQOarKgr2FWNIAHoC8dzVZp7JxUIE4oR+TNy91BJabSZ
	 VjgD0yOCrAq2FrFzTAWH2ZQN5bYIMU3mruz1yXMK2IuB9NmGoLPIdnz+HwL/L5DGu4
	 4vw0X4Fm9HIYw==
Date: Fri, 3 Jul 2026 12:43:25 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paolo Valerio <pvalerio@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 10/15] net: macb: change caps helpers
 signatures
Message-ID: <20260703-ember-coasting-ceb93b002fe7@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-10-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oYi7AVu0DmYYqiMJ"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-10-00268d5b1502@bootlin.com>

--oYi7AVu0DmYYqiMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oYi7AVu0DmYYqiMJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakegXQAKCRB4tDGHoIJi
0hZvAQDOxnyPUWXNZcwpRogY1qcrubXWE5gj9lyLv+8luFKknQD+LPT3SKp/93Vu
bZ/tpvkXjjSmX0V/RjZlPDgrlkXWogY=
=IGfX
-----END PGP SIGNATURE-----

--oYi7AVu0DmYYqiMJ--
