Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756195505C2;
	Wed, 14 Oct 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996277; cv=none; b=LgDRldvvkDEWZxQQSbcRAL6ohw3fN83jV/KIIHDEL8JL62aw6NfqWkum0bEsPY/d/S72FQHwhC8A+4ICJqxIyhDOrDdgVRwr8WfnvsejHnjLuLxua+/Pgy7lkilhGeUAnDlkzm6az/3vHv9W69WcPHHkR/ega2/UcjpKkF7NJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996277; c=relaxed/simple;
	bh=8P7SJHcSYOw5JSY/nnJb9EuSGTBEOwXJIo2/lEXq9T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkNChtmCIWvn5xOiX5lW6u17P4AVHt/6jc0bRNJW4SuUg/3k+sj5FuP0ls/9t0t4xaKNcUDFa/vvgXhI608PdpDU1JvoQ3gxyd5xbC8QURDP9G2uIuyJHYNk4TwyjBwEq1cg5PA95Vyl2ifQnQTlsbVZ20cSnqK71606BwiiNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep315XNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep315XNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324A71F000CE;
	Wed, 14 Oct 2026 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791996276;
	bh=GWhJq/1R6+HWndzsyOvpydL/Jcy4VCioKQ6402YATvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ep315XNi4vdI4OVim8vklEJQHg/Fi4oOfQBEKbQCKCe+lXf0huWHf7Ygb9ZRz4Thh
	 tBHs9FMTu19rVLyHPtglvef8lwC6w2XSylEvTAmWGYEKHF/cdeX3ST5RIJGDgYfSuE
	 Svxza1o5FLg7mc2DsyL6+0i7zKMHktSnrGG+5Trx+LXxiax0vHMnrXurVghZQdjuMy
	 7Eqsks0D0E0Qr6JIofgsGvhfdzLew86YTx9WTUIW5a7zBU/+yxQEQbrIsKjzAANL9E
	 +cqUJwVlrddH3lsl98atJs9+6WsZW0WsM8UNh2qf5kDdbOSZR/jbOaq2zQrAu73Oko
	 /eS7aNh/qWAkw==
Date: Wed, 14 Oct 2026 17:44:31 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiBbUEFUQ0ggbmV0LW5leA==?= =?utf-8?Q?t?= v2 1/6] dt-bindings:
 net: ftgmac100: Add AST2700 compatible
Message-ID: <20261014-smog-runny-75f5f1370bd2@spud>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
 <179161911824.434549.4075299707625994950@kernel.org>
 <20261012-aide-wimp-4edf96aaca1d@spud>
 <SEYPR06MB51346A6CB5D7D7FC6D3FC4DD9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261013-subwoofer-zestfully-fe98c6158ba9@spud>
 <SEYPR06MB513411BA847E7973291259959D9D2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261014-buffing-gilled-91576ce86eaa@spud>
 <SEYPR06MB513426D89C46D45519406E219D9D2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AysUfoOGaDSmX+kK"
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513426D89C46D45519406E219D9D2@SEYPR06MB5134.apcprd06.prod.outlook.com>

--AysUfoOGaDSmX+kK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 10:24:47AM +0000, Jacky Chou wrote:
> > > > > > > > @@ -18,6 +18,7 @@ properties:
> > > > > > > >                - aspeed,ast2400-mac
> > > > > > > >                - aspeed,ast2500-mac
> > > > > > > >                - aspeed,ast2600-mac
> > > > > > > > +              - aspeed,ast2700-mac
> > > > > > > >            - const: faraday,ftgmac100
> > > > > > >
> > > > > > > [Severity: Low]
> > > > > > > With this patch, "aspeed,ast2700-mac", "faraday,ftgmac100"
> > > > > > > becomes a valid compatible pair. However, at this commit,
> > > > > > > ftgmac100_of_match[] in
> > > > > > > drivers/net/ethernet/faraday/ftgmac100.c
> > > > > > > has no aspeed,ast2700-mac
> > > > > > entry.
> > > > > > > Such a node could only bind through the generic
> > > > > > > faraday,ftgmac100 entry (FTGMAC100_FARADAY).
> > > > > > >
> > > > > > > On that path, ftgmac100_probe() would do the following:
> > > > > > >
> > > > > > >   - program the ring-end bits at BIT(15) instead of the Aspeed
> > BIT(30)
> > > > > > >   - leave is_aspeed false, so ftgmac100_setup_clk() never cla=
ims
> > > > > > >     MACCLK/RCLK
> > > > > > >   - register the embedded MDIO bus through
> > ftgmac100_setup_mdio()
> > > > > > >   - never set a DMA mask wider than 32 bits
> > > > > > >
> > > > > > > Would an AST2700 node work correctly if it fell back to the
> > > > > > > Faraday match?
> > > > > >
> > > > > > Sounds like no, can the submitter please clarify if the fallbac=
k is valid?
> > > > > >
> > > > >
> > > > > Agreed. I think the 'aspeed,ast2700-mac' should not be based on
> > > > > the
> > > > 'faraday,ftgmac100'.
> > > > > Maybe the dt-bindings put ast2700-mac as a const like:
> > > > > ```
> > > > > ...
> > > > > properties:
> > > > >   compatible:
> > > > >     oneOf:
> > > > >       - const: faraday,ftgmac100
> > > > >       - const: aspeed,ast2700-mac             // as a const
> > > > >       - items:
> > > > >           - enum:
> > > > >               - aspeed,ast2400-mac
> > > > >               - aspeed,ast2500-mac
> > > > >               - aspeed,ast2600-mac
> > > > >           - const: faraday,ftgmac100
> > > >
> > > > Looks good. I am curious whether the existing fallbacks used with
> > > > other aspeed devices are also inaccurate? Could be worth looking in=
to?
> > >
> > > Thanks for digging into this further.
> > >
> > > I went back to the current driver to confirm the exact bit
> > > (drivers/net/ethernet/faraday/ftgmac100.c, ftgmac100_probe()):
> > >
> > > if (priv->mac_id =3D=3D FTGMAC100_AST2400 ||
> > >     priv->mac_id =3D=3D FTGMAC100_AST2500 ||
> > >     priv->mac_id =3D=3D FTGMAC100_AST2600 ||
> > >     priv->mac_id =3D=3D FTGMAC100_AST2700) {
> > >         priv->rxdes0_edorr_mask =3D BIT(30);
> > >         priv->txdes0_edotr_mask =3D BIT(30);
> > >         priv->is_aspeed =3D true;
> > > } else {
> > >         priv->rxdes0_edorr_mask =3D BIT(15);
> > >         priv->txdes0_edotr_mask =3D BIT(15); }
> > >
> > > So it's actually BIT(30) for all Aspeed variants
> > > (AST2400/2500/2600/2700), vs
> > > BIT(15) for the plain Faraday IP =E2=80=94 not BIT(16). The conclusio=
n still
> > > holds either
> > > way: none of the Aspeed compatibles can safely fall back to
> > > faraday,ftgmac100 alone, since the driver would mark the wrong bit as
> > > end-of-ring in rxdes0, and the MAC would walk past the end of the RX
> > > descriptor ring instead of wrapping, exactly as you described.
> > >
> > > That said, I don't think we should extend the same fix to
> > > AST2400/2500/2600 in this series. AST2700 is a brand-new compatible
> > > with no existing devicetree using it, so making it a standalone const
> > > (compatible =3D "aspeed,ast2700-mac" only) has zero migration cost.
> > >
> > > AST2400/2500/2600 are different: every upstream devicetree already
> > > declares the pair, e.g. aspeed-g6.dtsi:
> > >
> > > compatible =3D "aspeed,ast2600-mac", "faraday,ftgmac100";
> > >
> > > If we turn aspeed,ast2600-mac (etc.) into a standalone const in the
> > > oneOf, the schema would only accept a single-element compatible array,
> > > which would break make dtbs_check for every existing AST2400/2500/2600
> > > board devicetree. We'd also need to strip the faraday,ftgmac100
> > > fallback from aspeed-g4.dtsi, aspeed-g5.dtsi, aspeed-g6.dtsi (and any=
thing
> > inheriting from them) =E2=80=94 a much bigger, unrelated change.
> > >
> > > It's also not fixing a live bug: ftgmac100_of_match[] only had the
> > > generic
> > > faraday,ftgmac100 entry until Feb 2026 (commit 03a2aba50b2c), when the
> > > Aspeed-specific of_device_id rows for AST2400/2500/2600 were added as=
 a
> > refactor.
> > > Before that, the driver always bound through the generic fallback
> > > string and used
> > > of_device_is_compatible() internally in probe() to pick the right
> > > EDORR bit / clocks / MDIO. So there's never been a real kernel +
> > > devicetree combination where an
> > > AST2400/2500/2600 node bound through the generic entry and got the
> > > wrong EDORR bit =E2=80=94 the pairing has been safe in practice.
> > >
> > > So I'd suggest leaving AST2400/2500/2600 as-is (paired with the
> > > fallback, same as
> > > today) and keeping the standalone-const treatment scoped to AST2700
> > > only, since that's the one case where the binding and match table gen=
uinely
> > diverge right now.
> >=20
> > It's wrong, and there's no pain involved in fixing it (just have to sen=
d patches),
> > so I think it should be fixed. Breaking dtbs_check isn't an excuse to n=
ot fix
> > things, we "break" it all the time adding new devices etc.
>=20
> Fair enough =E2=80=94 you're right that "it breaks dtbs_check" isn't a re=
ason not to fix it, and if the=20
> EDORR bit mismatch is real for AST2400/2500/2600 too, it should be fixed =
properly rather=20
> than left as a known landmine.
>=20
> I'll prepare a follow-up series for this:
>=20
> - dt-bindings: net: ftgmac100: make aspeed,ast2400/2500/2600-mac standalo=
ne consts
>   (drop the faraday,ftgmac100 fallback requirement, same shape as the AST=
2700 fix here)
> - ARM: dts: aspeed: drop the faraday,ftgmac100 fallback compatible from
>   aspeed-g4.dtsi / aspeed-g5.dtsi / aspeed-g6.dtsi
>=20
> I'd like to keep it as a separate series rather than folding it into this=
 one, since the
> dtsi changes go through the Aspeed/arm-soc tree rather than net-next, and=
 I'd rather not
> block this AST2700 series on cross-tree coordination. I'll send it as a f=
ollow-up once
> this series lands (or in parallel, if that's preferred) =E2=80=94 let me =
know if you'd rather
> see it done differently.

I'd fix the binding here, since you're gonna generate conflicts with
yourself otherwise. The dts changes need to be sent separately anyway
(or at least applied separately) since binding changes don't go via soc
maintainers.

--AysUfoOGaDSmX+kK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas+xbwAKCRB4tDGHoIJi
0n4XAQC/vpFXlrqYYxFRyP5O1UZSrVT66Z0RtZrn4N9W8vXGXgEA6Rpzuk1DX4+p
S3y8ajBPXBIEI2sRavXKPvQtOuZZfAE=
=1oCZ
-----END PGP SIGNATURE-----

--AysUfoOGaDSmX+kK--
