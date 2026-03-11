Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB949248F64
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243488; cv=none; b=H/LZwjP5gSLMjGP1fpdzUSHk6eRV0aQ4B3q5/vkHhMRxdl84+IIaBNad1M7eyG2TWJCAkrdEH0ye+ie5hNBwWQ4kNKu12gTgz4xCttrFtdr3l1bDnSsBk3Tgu8nWDhzjlqZkym0uC7uv0sIHOJ57ewBdifLm/20Cp8SROT2rLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243488; c=relaxed/simple;
	bh=9c1KmNx/1kugbyZtg9R0AjdverE+udHK6mVAWAY7vUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jloPyd9ogJMsIvH+UsrVituGeOig6+/gEJdQkvmrlMFLkQL6jhmHoJ+Rpir7qrEpi0jtt1NQ8/0w9HPD3G32W7qSouwMGsQPq7iOEyTIcGXJNmMg8pRM3lZYXwYDjY431hDC0bYiN2zgaQPN5t0nAtAiKF55VKh+t+Fi+ChNkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah6P06b5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah6P06b5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D08C4CEF7;
	Wed, 11 Mar 2026 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773243488;
	bh=9c1KmNx/1kugbyZtg9R0AjdverE+udHK6mVAWAY7vUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ah6P06b5AARp8V/Uwgkf9Cvoqk8tbrzrV6ZQsGGVxqvDZp9kGZQZoo7q2OGeHbBmF
	 JKqXNgEzEJKJdhTbAL8A/z6NH5BjTCFywmVZF5+ovQRtrwfqkmBGlwYpKdmg+l57ed
	 qEaLuhdUTCVjJZN/zGFpKtmR0xDtU2E5kV02FelLkbP9f7VWqFXK2H/RZV/guiz2Mx
	 TMGiwByowD5F79tKFKu1E66Irlcxi0H1dxaW4QQVC910sSJKDtnePX3DZSQZiAheHa
	 6z9B3cub5fua/Tqw/m0QUKkXldCoKuBcUhnwB400wKT5ZGXoElTw2G/zvNMEAoWoth
	 EHVbfWO6kvxYg==
Date: Wed, 11 Mar 2026 15:38:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <20260311-promotion-pruning-c9f5c597cc68@spud>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <20260311140135.937544-1-geert+renesas@glider.be>
 <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
 <abGKEfPmxjyiNWer@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PlHMzROBK1c9sp4D"
Content-Disposition: inline
In-Reply-To: <abGKEfPmxjyiNWer@bby-cbu-swbuild03.eng.microchip.com>


--PlHMzROBK1c9sp4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 08:28:17AM -0700, Charles Perry wrote:
> On Wed, Mar 11, 2026 at 02:26:11PM +0000, Russell King (Oracle) wrote:
> > On Wed, Mar 11, 2026 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > > 	Hi Russell,
> > >=20
> > > On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrot=
e:
> > > > Add support for VSC8662 reporting its inband capabilities, and also
> > > > hook to configure the PHY's inband mode.
> > > >
> > > > This fixes a regression in the macb driver caused by commit
> > > > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> > >=20
> > > Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disab=
led")
> > >=20
> > > > Reported-by: Conor Dooley <conor@kernel.org>
> > > > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81=
a2ba1@spud
> > >=20
> > > s/Link/Closes/
> >=20
> > I avoided it because any other PHY used with macb that is also connected
> > via SGMII will run into this same issue. It just happens that adding
> > this support fixes the above commit.
> >=20
> > Conversely, we have stmmac, which unconditionally enables SGMII inband
> > at the MAC end no matter what phylink says to do, and should this
> > PHY be used with this patch in a stmmac system, it will cause that to
> > break, because we end up with either end misconfigured.
> >=20
>=20
> macb also unconditionally activated inband aneg before I added the
> ->pcs_config() callback.
>=20
> One of the way I think we could fix macb is by adding:
>=20
>         if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
>                 bp->phylink_config.poll_fixed_state =3D true;
>                 bp->phylink_config.get_fixed_state =3D macb_get_pcs_fixed=
_state;
> +               bp->phylink_config.default_an_inband =3D true;
>         }
>=20
> in macb_mii_probe(). This would force phylink into using inband aneg
> every time, unless there's a fixed link or the PHY explicitly doesn't
> support in-band. This would make it compatible with legacy system that we=
re
> setup with in-band aneg activated. It would fix MPFS without the need for
> this patch or device-tree modifications ('managed =3D "in-band-status"').

No commentary on whether or not this is the correct approach, but it
restores functionality on both boards I have on-hand.

Thanks,
Conor.

--PlHMzROBK1c9sp4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabGMXAAKCRB4tDGHoIJi
0ofAAP9s4xBx5f3404o7yVLkxqTr/IGslfpeCfAJGHO8JRNGigD/VRMO9fBFEANt
zUMznA0rRXmi3R6UlmcAbCVzVQJNgw4=
=g4J7
-----END PGP SIGNATURE-----

--PlHMzROBK1c9sp4D--
