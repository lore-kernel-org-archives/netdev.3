Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011F502D55;
	Tue, 13 Oct 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908568; cv=none; b=F8aswQQ3DTipp9Z71Ne/7YH9mNVAmjIfqP1tKReFu1/44LZOutPfy7naifNECcASQ18rwvJYWh17SDfznXqatPDCDrnB30mjsT8wTivtUm9H1W/JRxS3F6lDm/jOuJOSymLOwK2gkqWi9uu+etqOV7xcp5KaHcCbN15LVgfy/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908568; c=relaxed/simple;
	bh=zRJxuOVYQTNcPnPYqTgvUfVbxqZCkxhjzqBFG3X+/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klulxQG2DmaGB6lXuZlZ2eopPR1sNxW2CNLYe9Jgfk0fsiaGJMo73U3rgES0kNUDD8xc4NDAfDcVsVL6PWaetR1AbI1bx1h+XurVFEAbqIEUZk7j7gOUaalFwBphOvG/N457351gC+A7q1cb1tgSP+TdgSmQeEPtoxi2F8gjoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqiS6SNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqiS6SNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D241F000FF;
	Tue, 13 Oct 2026 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908566;
	bh=RruG4ycM1RDlyZhr3aFgF7U9rGlonUOm6YZBye8aWoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VqiS6SNvYr81gHOz6sWd2drWdeahWpXx+WTjJV0a29MnSmc5QfS18A11p4u9/cXYG
	 LwDngovM0JtfEmzBtUOPyrQkTi2ljMEnbDi8MWrjaAdpbdEUgIt64XI/FAzoj4LqRP
	 OM8BErFC2nmF/IuLTUNNC6vkQIw8ugK2adjIVy8i7sBPWb9q3ZoDIa2j7rlVpuywDa
	 9OEIUh7J7avXvu94kI4jT3N1IujK8d5X/Kf2lqmsyW2RDNKxWvBY0V0r+/8BwiOzm2
	 b+kanaTWOrAHFT6Ap8x07uLp965j6i6+hHT4CTceliJRGMp1HwzMOfupEq7iD6Wqwn
	 vP8lIQiNficaw==
Date: Tue, 13 Oct 2026 17:22:41 +0100
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
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?= =?utf-8?Q?xt?= v2 1/6]
 dt-bindings: net: ftgmac100: Add AST2700 compatible
Message-ID: <20261013-subwoofer-zestfully-fe98c6158ba9@spud>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
 <179161911824.434549.4075299707625994950@kernel.org>
 <20261012-aide-wimp-4edf96aaca1d@spud>
 <SEYPR06MB51346A6CB5D7D7FC6D3FC4DD9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="04Khn4zl3vmOXjoL"
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51346A6CB5D7D7FC6D3FC4DD9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>

--04Khn4zl3vmOXjoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 05:23:21AM +0000, Jacky Chou wrote:
> Hi Conor,
>=20
> Thank you for your reply.
>=20
> > > dt-bindings: net: ftgmac100: Add AST2700 compatible
> > >
> > > This adds aspeed,ast2700-mac to the FTGMAC100 compatible list, which
> > > requires the faraday,ftgmac100 fallback. It also updates the RMII RCLK
> > > clock description to include AST2700, and allows the resets property
> > > for
> > > AST2700 in the same way as for AST2600.
> > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > > b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > > index d14410018bcf6..bee9570a6f63f 100644
> > > > --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > > > @@ -18,6 +18,7 @@ properties:
> > > >                - aspeed,ast2400-mac
> > > >                - aspeed,ast2500-mac
> > > >                - aspeed,ast2600-mac
> > > > +              - aspeed,ast2700-mac
> > > >            - const: faraday,ftgmac100
> > >
> > > [Severity: Low]
> > > With this patch, "aspeed,ast2700-mac", "faraday,ftgmac100" becomes a
> > > valid compatible pair. However, at this commit, ftgmac100_of_match[]
> > > in drivers/net/ethernet/faraday/ftgmac100.c has no aspeed,ast2700-mac
> > entry.
> > > Such a node could only bind through the generic faraday,ftgmac100
> > > entry (FTGMAC100_FARADAY).
> > >
> > > On that path, ftgmac100_probe() would do the following:
> > >
> > >   - program the ring-end bits at BIT(15) instead of the Aspeed BIT(30)
> > >   - leave is_aspeed false, so ftgmac100_setup_clk() never claims
> > >     MACCLK/RCLK
> > >   - register the embedded MDIO bus through ftgmac100_setup_mdio()
> > >   - never set a DMA mask wider than 32 bits
> > >
> > > Would an AST2700 node work correctly if it fell back to the Faraday
> > > match?
> >=20
> > Sounds like no, can the submitter please clarify if the fallback is val=
id?
> >=20
>=20
> Agreed. I think the 'aspeed,ast2700-mac' should not be based on the 'fara=
day,ftgmac100'.
> Maybe the dt-bindings put ast2700-mac as a const like:
> ```
> ...
> properties:
>   compatible:
>     oneOf:
>       - const: faraday,ftgmac100
>       - const: aspeed,ast2700-mac             // as a const
>       - items:
>           - enum:
>               - aspeed,ast2400-mac
>               - aspeed,ast2500-mac
>               - aspeed,ast2600-mac
>           - const: faraday,ftgmac100

Looks good. I am curious whether the existing fallbacks used with other
aspeed devices are also inaccurate? Could be worth looking into?

--04Khn4zl3vmOXjoL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas5a0QAKCRB4tDGHoIJi
0o+LAP9JUwd35G4Tddq1MXi0RiDXQvzTdxhiFYm4I4c91blSHwD+N66kE3iFrYOh
sDgkxcrp8cn1htDbzr1Dve3Jh1FYqA0=
=nq6T
-----END PGP SIGNATURE-----

--04Khn4zl3vmOXjoL--
