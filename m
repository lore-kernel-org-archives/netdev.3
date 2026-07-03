Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BB353A96;
	Fri,  3 Jul 2026 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078539; cv=none; b=qXaC1+9wVW3QfLJZhhCtkV19DN3S6D3VUC4oinQoZt+WOry+Pn0wkXif0bY+sdFtclUkguJ5G/6UIZcz16ruix7ehG9978yn1j7SSSnwcK9upQ/AaIG+23FckdY8o3aIVZah9tI4g1QmlwLxPivuenEb9XgDTz0i/z477VF9DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078539; c=relaxed/simple;
	bh=g4rvhVYrGW91S28UGIzCGMbJK+S9pkjQ4W8EVoIZXVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgtgaFvWx7UmQD0ygQwDqHGuNP1FdO3RgLir/hsn2UTGJVf4st0YGfIG5Ch9Neg2by2M2orMa2XCJC8xpy5qB8e4i+6s6GfWP5o/gdg2Agh3BP6R1yrSnB2ovOavJkHYszUCA4+RXf4uq5OOJBpthftBP+vGbRfD9Yk8hll8blc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR374ew6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR374ew6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D694D1F00A3F;
	Fri,  3 Jul 2026 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078538;
	bh=g4rvhVYrGW91S28UGIzCGMbJK+S9pkjQ4W8EVoIZXVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MR374ew6sDPqG74BhCYlixAReyESci44wijy14bcKXAX8yzQZKa62ZCDSPdu6qo7B
	 w6MvvKd1fZZSGrTbc9XE+PJh1DoZxII736QuIbTElgCEBKdnVaup2SQdNH7/jsr1DR
	 aJrv6FLiTjD5P90QOus0XKtk0AMbChzdulZsk+UjydWDj88ndgP9bvzUTEDTU53hij
	 vnJqEzFugNBrNHP2RW6mps+0QI8PFxFkanNiSvk/aHOE86p3pntYgePu5TwgjR005e
	 JLg204sh7xNPx3X2gfAg+RtVK+PWZbuJ9s7Sb29HtDWjVENwl6IOrebR0QoKulxVAc
	 6tQ/rsXvGc5YA==
Date: Fri, 3 Jul 2026 12:35:32 +0100
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
Subject: Re: [PATCH net-next v3 05/15] net: macb: enforce reverse christmas
 tree (RCT) convention
Message-ID: <20260703-clunky-moonlit-7ce6bc8c5660@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-5-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9meh0AzFQKGbdoqQ"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-5-00268d5b1502@bootlin.com>

--9meh0AzFQKGbdoqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9meh0AzFQKGbdoqQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakeehAAKCRB4tDGHoIJi
0tA5AP9sutj1+68JRLK0Vwm6EeuUkg103cf923V+J24wMQlNlgD+IHTchiTDxBJp
Wu+1JF7Gio+ro9ivlZZu1i0VNg3LEgk=
=ZEk3
-----END PGP SIGNATURE-----

--9meh0AzFQKGbdoqQ--
