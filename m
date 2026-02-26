Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C43226D00;
	Thu, 26 Feb 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139935; cv=none; b=BFSxwrakcSDCWQ3cdTWEOLcczP7FbbzHg4/vmrqTTM0fA4cilPP5NdW5XXEh+MPBzUmKkXI8mseyPkas1FUl5htlzak+GFUoGCgiE8iV7nbcy0oX8uU16agIgqioUX1IXG5KsQwveMjvGpdOzcEi4X13AFvkXiBgNbuZXZoXBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139935; c=relaxed/simple;
	bh=uc2Eq1H6971eNvHKFTRJYOX7q5n+tCYl7A9InNjRaH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw6pEv1ThH59eODX56GuxfJ5bMQ/3BXb1uyIKtoqyk3H4PC1lvZ8KJp7OJLxUUND4rjk0XxFiva5JqfNnXjkZjOYNZJk3jnskJxQ9MRsWaCmAQEa5wAY0b90IHGGUSGPr4UGvgelnxAyeMuQQfB/9aDTb9ah04NyfAqohZNePLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA1lSey7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA1lSey7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E3DC116C6;
	Thu, 26 Feb 2026 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772139934;
	bh=uc2Eq1H6971eNvHKFTRJYOX7q5n+tCYl7A9InNjRaH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SA1lSey7XhMAKn/SCMxAPovHfyKkgOinYudsb7u/ytZIPYcSHCzd10SKo2nsoUFtW
	 Bq+XgqE/POnX0vlY/JUby2FpVZWzBkwMR1v32u514TFk4+QeQBqvmaHJOsQ+s457a3
	 BJASiId8grbDjYc8RizCmYUFhfranVDAqSQw45Zjrg8pSEYUVXFUq2gCWnvEI8/A+7
	 F/dg7mlPHiDmPvouR5ezn9CL4IYxyZ+1J75IJ1cGvOPQGLbHrNpJ2cXk+4ZVebzgPR
	 2ixhclO0NrYwcAJ8lWL+cOwB0aCsg43sQ0ZoJmpZDLFELG/1JH0hxtj9qhfntbjV7H
	 XnSPcNMvTy1rg==
Date: Thu, 26 Feb 2026 21:05:28 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <20260226-marry-blend-0a63d3572d76@spud>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
 <20260226-folic-excitable-82eff83a125a@spud>
 <aaCd_zV5kY-s1RBL@shell.armlinux.org.uk>
 <20260226-perennial-sanctity-25c6adae5ec0@spud>
 <aaCwxeMHMSCHk0nx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KjizatTjNwr03SpN"
Content-Disposition: inline
In-Reply-To: <aaCwxeMHMSCHk0nx@shell.armlinux.org.uk>


--KjizatTjNwr03SpN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 08:44:53PM +0000, Russell King (Oracle) wrote:

> Ethernet PHYs are described in Ethernet controller DT using the
> "phy-handle" property (and previously "phy" or "phy-device"
>=20
> Generic PHYs are described using the "phys" property.

Ahh, this was key and I think I understand the analysis now.
Thanks for explaining Russell.

--KjizatTjNwr03SpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaC1mAAKCRB4tDGHoIJi
0rsSAQCic9F4/sDeaWWJyHR/xFKd96b3VtkDllYQPQdMbb+i8wEAtlcgj2zLLZmO
9dAyRADtpjYNIZiAWFvipaTFX19dBgM=
=rTs1
-----END PGP SIGNATURE-----

--KjizatTjNwr03SpN--
