Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAA305677;
	Fri,  3 Jul 2026 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096486; cv=none; b=qG4rGH2A8LUTRDk9AzGpTez2PtiW5fTFTczzAPvUfr9yDD7IgGkMv7RvXDGqlG92ZCCPwCD2Y/e5Zk7X76DvaG9mXNk8iuw3o/UEu1c47sCJ6O429Pu2MjhQaLSuNtOJIHneT/RLzv2hlukbl8dOae33znDpZQbGuGRzCLbKNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096486; c=relaxed/simple;
	bh=2KlGz+EQlrhE9YllZ1rEkCsD4xH7FfhVIWF2EzsMdJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAE8OxT9DfdfNE9/EQ4/AJJlSO9UrFhIynooY9MCkrdM3JhbdSDYEQSaPL8SKsXCplwQ2puQQAZyFuTJPp/Qwcc99ExgvdVfhm1o98Gf+4zWDJcTi/9fLIEBeEC9QXHA1wGDZ5UfH00iQDmVMKjCIsgJPE50JQVJG4quwsB8fq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKA2S+LI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKA2S+LI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66941F000E9;
	Fri,  3 Jul 2026 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096484;
	bh=ffWK8nJCHeQyF+GufY4cWTKWZVOirovX5C2tQ3pdKaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WKA2S+LIlIkAjp2aZrkLB9NTJ3s+OcNAvVtr4CEZNwtJ3pJ+rpKEVCEv1B7sZf8UX
	 in570xMARUn0OzS3XvY2qkO9I9tgkTGR6kI57E8YbRLISxym14MzIp6GppKemjDJOY
	 4U13c//1ElLzAny6Sfnj2xJFfvW/+B4YlZRX8tnCeIB7XyFEIkeEM4Bt8IigNmJm6C
	 klu4c90pV16f74VCV73TpP/LBaV50kghl1LCgci3NJ2bbR2v3HBOfPkBwU3H52rwYi
	 BQynaDJqnHrryyhonc0VPc0H8DA4G4Coxx0IL/b8ZhhTJGJmhwsZ8fYJpyOV0HPzvk
	 3vWQmCLCllm5w==
Date: Fri, 3 Jul 2026 17:34:38 +0100
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
Message-ID: <20260703-tidings-reflected-3799e7d6ae99@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
 <20260703-stucco-broadly-d9393f789868@spud>
 <DJP2W90JJK0G.1DBR4RMJKJO2Z@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yvgv7c3J9eKvyYhE"
Content-Disposition: inline
In-Reply-To: <DJP2W90JJK0G.1DBR4RMJKJO2Z@bootlin.com>

--Yvgv7c3J9eKvyYhE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2026 at 06:32:08PM +0200, Th=E9o Lebrun wrote:
> Hello Conor,
>=20
> On Fri Jul 3, 2026 at 1:28 PM CEST, Conor Dooley wrote:
> > On Wed, Jul 01, 2026 at 05:59:04PM +0200, Th=E9o Lebrun wrote:
> >> Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
> >> functions have not been only allocating or freeing consistent memory
> >> mappings.
> >>=20
> >> Rename from macb_alloc_consistent() to macb_alloc() and
> >>        from macb_free_consistent()  to macb_free().
> >
> > What does "consistent" even mean? Is it intended to be analogous to
> > coherent?
>=20
> That's my guess. We used to have pci_alloc_consistent(), being an alias
> to dma_alloc_coherent().
>=20
> This alias has been present since forever (since Git):
>=20
>    git show 1da177e4c3f4:include/asm-generic/pci-dma-compat.h
>=20
> The alias got removed in commit 7968778914e5 ("PCI: Remove the
> deprecated "pci-dma-compat.h" API", 2022-03-09).

Right, I did figure given the commit you cited as being the end of it
that it was something like that.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Yvgv7c3J9eKvyYhE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakfkngAKCRB4tDGHoIJi
0qssAP0cTev9V9ZbCz5UlxvArclAmuCYrtSEKCkUzJFkcwJzvQEAsqMl8cEMh3XU
fPPkDlbsk6FVkUXKpc1JF/OeTejO4Ao=
=gySm
-----END PGP SIGNATURE-----

--Yvgv7c3J9eKvyYhE--
