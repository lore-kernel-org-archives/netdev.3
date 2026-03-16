Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A12EB10;
	Mon, 16 Mar 2026 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773619579; cv=none; b=Weom0UgatkyRivyIzsUND7ZA1fsGrdl2vJI2VjrW1V9r6hWvsJ6AHQJDs9f1MBxJvecXZB9WMzrJbl8MhQ8Jvgz0VvshkS6tynx78dw1GpxeTe1bz3s5JQe+xmx8oiKOGyJErlhNS7sEsRP9vPnkXPn3WQ0395mTsZxrOtaKn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773619579; c=relaxed/simple;
	bh=jDi/p2FT0fjenQH4WT4qegMh0NwnmJgGko0oRJl32Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLnDkAjpyw3pb83qO7qYThIocfnjGecf+ceXX5MRcU2BwklfGg3jMPQ47TkzmJPNBbXlVbckuyRM72NOK4sKmBX2/VVfrdDGWFcdDAswg/9XEUh6WN7HnOybQP24jipxTJ7p0AfBJ4L9dGjYUT001ihvCx7nw2I2wKuF5Vwl2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGeNm8I7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGeNm8I7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999D3C4CEF7;
	Mon, 16 Mar 2026 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773619578;
	bh=jDi/p2FT0fjenQH4WT4qegMh0NwnmJgGko0oRJl32Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGeNm8I7sliWMDn72D3Ii2+DIgsub7nuRHcmYXexCd55bYDWPkACP6xijo/V2DbrC
	 mzdWBx+TpJNKZDwsg7HQjNncnlzfamDJdvxbdv+mPrSAy+i5ldPSSXw8G95UHX9YSS
	 hGHWbgG/jD4Wn2seJmCY20obfdGpSBegmiy6OyCETSdsiKV1Iq4DkDxgUc6pPU2TgV
	 GlSzWz4MZKGfLZTHGWP4Sg8Jp/sa8cZJKn0DNolhP9T4iXSNplEmt5Rk8cCKOYJZqn
	 Zcfi6gQZnn0POVmsyfs0kDUxB4zNCYnahvlvNlwfxYnMrkjNkCaXoZmOprt80EZwWj
	 27JuaQsV+4upw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 39D2E1AC565F; Mon, 16 Mar 2026 00:06:16 +0000 (GMT)
Date: Mon, 16 Mar 2026 00:06:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] regmap: mdio: make it depend on PHYLIB
Message-ID: <abdJeNebOG89N3qh@sirena.co.uk>
References: <bc63cf87-3dba-4ab6-9c84-caa7357c3273@gmail.com>
 <a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvsZrsgL2wcEh61O"
Content-Disposition: inline
In-Reply-To: <a21a3b3e-272e-4c61-986e-48a2cb3421d9@gmail.com>
X-Cookie: Identify your visitor.


--wvsZrsgL2wcEh61O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 15, 2026 at 05:48:43PM +0100, Heiner Kallweit wrote:
> MDIO-based regmap is the last user of config symbol MDIO_BUS.
> MDIO access needs a MII bus, which requires PHYLIB for the provider part.
> Therefore make REGMAP_MDIO depend on PHYLIB, what allows to remove
> config symbol MDIO_BUS in a follow-up patch.

Acked-by: Mark Brown <broonie@kernel.org>

--wvsZrsgL2wcEh61O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm3SXcACgkQJNaLcl1U
h9BVUwf+L6/z5axFZLrGcdWAE9lnGsxhKDaMy74q+I9rKxhimbcZ8yiJQypPFlOL
m/92zolD0eCGWuaHIisMfynGpcgXun7izRUhn96K/8HS4Aaa6jaO64Nn3BiXiDaI
o4CWjlRGibxngYXaX48VJXnifxbkbzO3XujNeFl9WmuQyPDi1JxqCeh2vJLmUCv5
+E6yWYvCpKhsb1Il0cjzkJfEYLUACENykrBlLbsMPVGLcp+RUYGekvgXsr99v7/m
E81OvriYq3ERuztVIvN3arSNgYhpchJnFw9qiE9B3A+qoh6+nRdvO6Ca1Ab/Qjnu
7fr3aobV7nNJL6tVGnlGC86XKDML2Q==
=6sua
-----END PGP SIGNATURE-----

--wvsZrsgL2wcEh61O--
