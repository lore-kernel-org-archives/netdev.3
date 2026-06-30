Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F973DB64A;
	Tue, 30 Jun 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839660; cv=none; b=cu/R0oyaWc7EfgERKdIGOmFugutTZ/x6UUAJBpmkSL2/QxF49D5K7MQ7r5Ps0fulan0WPU36uU5PxQUWrcBYuygKNpxLIFQhG+9Qtwxg01teXyR7ZNze+XnoPJ2ueJqtoVImQCxHX/ciNe+OMG0uy1F4jcbsf8bZH5Z0rLCZT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839660; c=relaxed/simple;
	bh=KL2Qh3JlwcMGBS2Xp+GdGwlsEo7x8Qy6c5ebOhuRvXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leAdI5L7sIRjcrO9QHDu4DHFTFnKOtsC5NlBsnJXYlhiLXVx9SemTWM3f9bsnp/buN557G1RxxpZB24s7WVIGObr4UQi1EZP1uO3D0W/IWheniU9k7JAvGuKy6nTQhysGfvJQksswoiTpA7jCUtxPqiY4G1ZbL8vYPCxvRD9Ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPckqt5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPckqt5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174F41F000E9;
	Tue, 30 Jun 2026 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839659;
	bh=KL2Qh3JlwcMGBS2Xp+GdGwlsEo7x8Qy6c5ebOhuRvXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IPckqt5KA/8jJBh7o3E+1zaKIw3HHmP0Ha8iqh3DNz08lMmyrAat4Vqsxk0vWlUNZ
	 1Fpq3CaHT/CFIjtL9EPMhkIX5gzwu7lVyA+UqJExC605cULzigG4TS1jkZ2dIhOmpb
	 xgAV39foJ9AsEwpyj9kthoRrfiiH6Jnxw2wUczMdKaAhCIoLT/Z7T4O2ndYD8KXXQD
	 ybf/cRNQXFOgEo9kAf72EQ1cHVj8QoIKWezWdQe/9qspbW2xnJegWoxi9Shc8plDSB
	 tG7jiR5WFggpbeB9mUZe/MBfAfFo19emmPLxN1Tbdq3QsLKbquJxgLft3tpJ7uSfQu
	 gSRHUQq/7hudg==
Date: Tue, 30 Jun 2026 18:14:11 +0100
From: Conor Dooley <conor@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org, lee@kernel.org, wens@kernel.org
Subject: Re: [PATCH net-next v9 2/6] dt-bindings: ethernet: eswin: add
 EIC7700 eth1 RX clock inversion variant
Message-ID: <20260630-kennel-depict-ad1572381eb1@spud>
References: <20260630063123.1118-1-lizhi2@eswincomputing.com>
 <20260630063239.1158-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FV9cckqVldztFxpL"
Content-Disposition: inline
In-Reply-To: <20260630063239.1158-1-lizhi2@eswincomputing.com>

--FV9cckqVldztFxpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--FV9cckqVldztFxpL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakP5YwAKCRB4tDGHoIJi
0ivXAP9PZtCkBxkZG5rl5e4zSoQMTxB0Fq9zhsdUTq8V3Tq5uQEA12mNGB1ngWZw
6ygV3Z3Xn/OI2pRFvtxK/25tHcy3xws=
=1Xpo
-----END PGP SIGNATURE-----

--FV9cckqVldztFxpL--
