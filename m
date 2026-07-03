Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E032FA2C;
	Fri,  3 Jul 2026 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078168; cv=none; b=P68ciJ6YWxE2CUb34jy6ZCPEeN1Q0KBRUBgZtx3gG1Bn8mssOkcUiA9sXhNwMXtqPZkW1vlN5wwhSL2jX5Y7NUhCY5Ll5pU5a7dFdksbNDCydtP8oP0A0EfDxWUQt+RUsw2mKRfUdAK09GLzgEMFV7q9zbdyG7fHrmHApGMMSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078168; c=relaxed/simple;
	bh=jlk6O5BjCPJSnRVl18eI7ybdbR77bdupSyj+B8T+peg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/NIKS79ryO9glgRaKZNU+LmlRWVsW//chVIypyOtZmxVEfujOIXvIkLz+Xh9/x4cKvoh8tD11oqzCt7VsEtewVvHaxeF1nKCXu2vqAziGsRoHXgybDCZxxh/i0J8rO+Ffc74PohKEZTzvt0FkWIxsipLcjNv+LRYaRdSah0JOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1SLrBLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1SLrBLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C2B1F000E9;
	Fri,  3 Jul 2026 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078159;
	bh=nhYEhzI2zrGJ5BQVU/pw8kBzQBK5diB7Er9NsAUP/sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O1SLrBLnC0X962dpqHKSAPzFFfTqEOTns59EWY6pbU7a6SatJYz+gLa0D13Uuk9e5
	 4IVxYQOuP8uwkWJV1Fy/DzbHngt8EfoSQqK7og2akwTNSflt1zDjAiZJYgYVlp3RU2
	 AxWhDFBcu7ganwPZuaokZ5eWjigNpXuEszJoPNsf4rD2NAffZjXl8V7hPjuhkwzaqh
	 Lbno0wzXFAXPQRtwIvvMkxazATzzt3pX97srzjG2LrmUFqkWWtOa+LEO7QJlQiYck5
	 LvVss85IvE/7tMZ9gRbfNBDvrIqAe4eO8VxdIGjr11LblforyJ5O8D7eH8SZ3niPql
	 2LF+W+pYuBUPQ==
Date: Fri, 3 Jul 2026 12:29:13 +0100
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
Subject: Re: [PATCH net-next v3 02/15] net: macb: unify device pointer naming
 convention
Message-ID: <20260703-plant-remark-e6e2e7cf8a12@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-2-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/8cqNE0dp0l3TZIn"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-2-00268d5b1502@bootlin.com>

--/8cqNE0dp0l3TZIn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:59:05PM +0200, Th=E9o Lebrun wrote:
> Here are all device pointer variable permutations inside MACB:
>=20
>    struct device *dev;
>    struct net_device *dev;
>    struct net_device *ndev;
>    struct net_device *netdev;
>    struct pci_dev *pdev;              // inside macb_pci.c
>    struct phy_device *phy;
>    struct phy_device *phydev;
>    struct platform_device *pdev;
>    struct platform_device *plat_dev;  // inside macb_pci.c
>=20
> Unify to this convention:
>=20
>    struct device *dev;
>    struct net_device *netdev;
>    struct pci_dev *pci;
>    struct phy_device *phydev;
>    struct platform_device *pdev;

Oh lovely, OCD approved.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--/8cqNE0dp0l3TZIn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakedCQAKCRB4tDGHoIJi
0iHXAQCIrhUS2y3KjGpoKQZoWWwT6ila9E1u8Zd419pgu3Lg6wEA62Iqqppd/AkZ
sg0RekYDVFleJj2vfE8vjKIYmAV+dgk=
=RSd3
-----END PGP SIGNATURE-----

--/8cqNE0dp0l3TZIn--
