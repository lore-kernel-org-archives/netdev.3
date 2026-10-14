Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8244D6C29;
	Wed, 14 Oct 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972812; cv=none; b=s1Xa78sIsMl1J2KSDaggxseeQWZgJoKDWGLRCl8xNbWqGep5RZ+rYuTucD5jWc06p64uIlCYAcOGhk/NtVaQox4L8BnSINkWISaonhgO5LvbMmOwD3FokBl+nMcdo0FRKmaLdVJs//KY9sfWvyYcmpGl+iKmjLz2GmKqdC1eZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972812; c=relaxed/simple;
	bh=y0LXYz06eLc1awS4A+4wZsXvtHg9Ab4gR/Rw5m3qAPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd5hXbdFwDYKaCe/dw1v4CAL5QuGeLRYyxgjWhr7EkBhFJzJ5FsQeSBrRLR9v1PVDpHewL2AN2tnTE37jcslHn419mqRneb9dqkgkETKSG6ffBVgbt17muXOoRZOymut+zwOIKrmFHrqyWAHuah0317wWTHZQGKyecCAUlJ803k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2VzbbXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2VzbbXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7832A1F000FF;
	Wed, 14 Oct 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791972806;
	bh=zGTeo/o6MXC8ggKT++feST1mPlhs83LOuRDxy2LxEno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N2VzbbXKH0jFChxSk+53iw38ynWTdqTKekMe/AHhuUICzv7wR1viNpQCBVxOGStv0
	 6tnZjyi+HTR+Oehu4mpBBsgXXdRHrNtXSkGJvJD3HrPnMke88bzVQqFjdyHK8DUsc7
	 6e/mASXRS9tNjBcVxwH6S3JJ3wVRhoADPSGiX2kkFLqHEAfANaldHgJ3TCErpUpOoS
	 P8ziFhelH855wbbEPNYqTPV4Yz7aPn4xTZJpNRYdRQTTkamSX0s+y8cNhaAEyUgP2M
	 zK6ksK0mXt7R3j+WXdqYKIetq5FSEKMq8uYB2M57c11CciMhstsf7URqpOQmdrQb3j
	 IIHoVqEeiWp+g==
Date: Wed, 14 Oct 2026 11:13:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"edumazet@kernel.org" <edumazet@kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRD?= =?utf-8?Q?H_net-nex?=
 =?utf-8?Q?t?= v2 1/6] dt-bindings: net: ftgmac100: Add AST2700 compatible
Message-ID: <20261014-buffing-gilled-91576ce86eaa@spud>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
 <179161911824.434549.4075299707625994950@kernel.org>
 <20261012-aide-wimp-4edf96aaca1d@spud>
 <SEYPR06MB51346A6CB5D7D7FC6D3FC4DD9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261013-subwoofer-zestfully-fe98c6158ba9@spud>
 <SEYPR06MB513411BA847E7973291259959D9D2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eQ9FHgCev0JHGD+O"
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513411BA847E7973291259959D9D2@SEYPR06MB5134.apcprd06.prod.outlook.com>

--eQ9FHgCev0JHGD+O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 02:49:37AM +0000, Jacky Chou wrote:
> > > > > > @@ -18,6 +18,7 @@ properties:
> > > > > >                - aspeed,ast2400-mac
> > > > > >                - aspeed,ast2500-mac
> > > > > >                - aspeed,ast2600-mac
> > > > > > +              - aspeed,ast2700-mac
> > > > > >            - const: faraday,ftgmac100
> > > > >
> > > > > [Severity: Low]
> > > > > With this patch, "aspeed,ast2700-mac", "faraday,ftgmac100" becomes
> > > > > a valid compatible pair. However, at this commit,
> > > > > ftgmac100_of_match[] in drivers/net/ethernet/faraday/ftgmac100.c
> > > > > has no aspeed,ast2700-mac
> > > > entry.
> > > > > Such a node could only bind through the generic faraday,ftgmac100
> > > > > entry (FTGMAC100_FARADAY).
> > > > >
> > > > > On that path, ftgmac100_probe() would do the following:
> > > > >
> > > > >   - program the ring-end bits at BIT(15) instead of the Aspeed BI=
T(30)
> > > > >   - leave is_aspeed false, so ftgmac100_setup_clk() never claims
> > > > >     MACCLK/RCLK
> > > > >   - register the embedded MDIO bus through ftgmac100_setup_mdio()
> > > > >   - never set a DMA mask wider than 32 bits
> > > > >
> > > > > Would an AST2700 node work correctly if it fell back to the
> > > > > Faraday match?
> > > >
> > > > Sounds like no, can the submitter please clarify if the fallback is=
 valid?
> > > >
> > >
> > > Agreed. I think the 'aspeed,ast2700-mac' should not be based on the
> > 'faraday,ftgmac100'.
> > > Maybe the dt-bindings put ast2700-mac as a const like:
> > > ```
> > > ...
> > > properties:
> > >   compatible:
> > >     oneOf:
> > >       - const: faraday,ftgmac100
> > >       - const: aspeed,ast2700-mac             // as a const
> > >       - items:
> > >           - enum:
> > >               - aspeed,ast2400-mac
> > >               - aspeed,ast2500-mac
> > >               - aspeed,ast2600-mac
> > >           - const: faraday,ftgmac100
> >=20
> > Looks good. I am curious whether the existing fallbacks used with other=
 aspeed
> > devices are also inaccurate? Could be worth looking into?
>=20
> Thanks for digging into this further.
>=20
> I went back to the current driver to confirm the exact bit
> (drivers/net/ethernet/faraday/ftgmac100.c, ftgmac100_probe()):
>=20
> if (priv->mac_id =3D=3D FTGMAC100_AST2400 ||
>     priv->mac_id =3D=3D FTGMAC100_AST2500 ||
>     priv->mac_id =3D=3D FTGMAC100_AST2600 ||
>     priv->mac_id =3D=3D FTGMAC100_AST2700) {
>         priv->rxdes0_edorr_mask =3D BIT(30);
>         priv->txdes0_edotr_mask =3D BIT(30);
>         priv->is_aspeed =3D true;
> } else {
>         priv->rxdes0_edorr_mask =3D BIT(15);
>         priv->txdes0_edotr_mask =3D BIT(15);
> }
>=20
> So it's actually BIT(30) for all Aspeed variants (AST2400/2500/2600/2700)=
, vs
> BIT(15) for the plain Faraday IP =E2=80=94 not BIT(16). The conclusion st=
ill holds either
> way: none of the Aspeed compatibles can safely fall back to faraday,ftgma=
c100 alone,
> since the driver would mark the wrong bit as end-of-ring in rxdes0, and t=
he MAC would
> walk past the end of the RX descriptor ring instead of wrapping, exactly =
as you
> described.
>=20
> That said, I don't think we should extend the same fix to AST2400/2500/26=
00 in this
> series. AST2700 is a brand-new compatible with no existing devicetree usi=
ng it, so
> making it a standalone const (compatible =3D "aspeed,ast2700-mac" only) h=
as zero
> migration cost.
>=20
> AST2400/2500/2600 are different: every upstream devicetree already declar=
es the pair,
> e.g. aspeed-g6.dtsi:
>=20
> compatible =3D "aspeed,ast2600-mac", "faraday,ftgmac100";
>=20
> If we turn aspeed,ast2600-mac (etc.) into a standalone const in the oneOf=
, the
> schema would only accept a single-element compatible array, which would b=
reak
> make dtbs_check for every existing AST2400/2500/2600 board devicetree. We=
'd also need
> to strip the faraday,ftgmac100 fallback from aspeed-g4.dtsi, aspeed-g5.dt=
si,
> aspeed-g6.dtsi (and anything inheriting from them) =E2=80=94 a much bigge=
r, unrelated change.
>=20
> It's also not fixing a live bug: ftgmac100_of_match[] only had the generic
> faraday,ftgmac100 entry until Feb 2026 (commit 03a2aba50b2c), when the
> Aspeed-specific of_device_id rows for AST2400/2500/2600 were added as a r=
efactor.
> Before that, the driver always bound through the generic fallback string =
and used
> of_device_is_compatible() internally in probe() to pick the right EDORR b=
it /
> clocks / MDIO. So there's never been a real kernel + devicetree combinati=
on where an
> AST2400/2500/2600 node bound through the generic entry and got the wrong =
EDORR bit =E2=80=94
> the pairing has been safe in practice.
>=20
> So I'd suggest leaving AST2400/2500/2600 as-is (paired with the fallback,=
 same as
> today) and keeping the standalone-const treatment scoped to AST2700 only,=
 since that's
> the one case where the binding and match table genuinely diverge right no=
w.

It's wrong, and there's no pain involved in fixing it (just have to send
patches), so I think it should be fixed. Breaking dtbs_check isn't
an excuse to not fix things, we "break" it all the time adding new
devices etc.

--eQ9FHgCev0JHGD+O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas9VwQAKCRB4tDGHoIJi
0k05AQDhoqwA/YKc4ZnPsJH/TZgCVc9LPQEru+F4+URb1665MAEA81DqM/APzlCd
ug+XodaxwAEPYCYzYlQYz70xWhkjqQ8=
=Ass3
-----END PGP SIGNATURE-----

--eQ9FHgCev0JHGD+O--
