Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96787331EB6;
	Fri,  3 Jul 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078106; cv=none; b=RKdjg1qU9cneO9voO4nC2x+nYUtHghTb/HThb40EbbhEP9LLpESj3NoxbYbr3mFEKFjP9R9eG+QPeqdkJNQfxzQ/1OQlizTDWFeMCnd5ab9auRbKLn0gDMsU/nQd81VzL4miZAvR8TBJxryrpsrPFCorBV0AlGQELKtj1IdugE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078106; c=relaxed/simple;
	bh=rIbDPUNqO68w1gZBHKkRrI3IxHlLVS++RxUYj3zS24g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdwcQBkanuW3ku3edxrF2TdVDiuyLJU7icbTddV3x9zrOnO//8y1kHbk+fWFHktwxZuPETmm2kVCo9+HGTNzIeiXHGMmo/oOYIWjhkmBE7ICEBnZexrt22wNAMo19jw68hTX+Kz8p7xnbCPMXUboGhxKjd73+56fzm6hYULkgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtjL+p7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtjL+p7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86D81F000E9;
	Fri,  3 Jul 2026 11:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078098;
	bh=qcFxB7z7yPHPBU6/05GylRlFlIQiByW9FreyRYjlzD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XtjL+p7PBQnlsiTlRQmyZGGzqNbar5fB3pgW5m6Igvcr+s48DiSFWFDtqtzeMfY/F
	 t65lphPAIOabkqwqfxpYB+RN4L1o94y641rNyVChnMsP2pEUG2ZkrXCz9yXz9NCckA
	 ubjd2A59HRPPZ0Qb3Mx+8xx1FwXbEnau1cMotkdZVUa6GYgRCaXAknRBomjBIfP8u2
	 5cE1Nzfslca0yR/Je4fnvwicblgFr9NCtk6at0cT5pU8goiwshQWM9vIb0owDXrpWR
	 VI7Uav9+aewXK3dMXAeQ3VzK+pEoVXooVFDgl2QOJ3lw4swhs5L+6jP9663lLFh6Od
	 A1/pg5ApZQgKQ==
Date: Fri, 3 Jul 2026 12:28:12 +0100
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
Subject: Re: [PATCH net-next v3 01/15] net: macb: drop "consistent" from
 alloc/free function names
Message-ID: <20260703-stucco-broadly-d9393f789868@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="utlYZwaLXZavGKQm"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>

--utlYZwaLXZavGKQm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:59:04PM +0200, Th=E9o Lebrun wrote:
> Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
> functions have not been only allocating or freeing consistent memory
> mappings.
>=20
> Rename from macb_alloc_consistent() to macb_alloc() and
>        from macb_free_consistent()  to macb_free().

What does "consistent" even mean? Is it intended to be analogous to
coherent?

--utlYZwaLXZavGKQm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakecyQAKCRB4tDGHoIJi
0ghHAQC69+jnjQRNzi+ViehZDrsEVTD0zsZ8F6J/rxdf2KTFIwEAs5T3hu6jGLdV
QjLeCu7Mx/tQKJFu50DOpNOd+8ACrQw=
=sdf/
-----END PGP SIGNATURE-----

--utlYZwaLXZavGKQm--
