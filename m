Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D244437858;
	Thu, 27 Aug 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846756; cv=none; b=M7elryTCzZkjx984X/aOT5sTPv3DXRFfAqCLpwsSf+rezGGFt1IlyozPhqWseTLZaCBdn/Trbik0PNu6CfQ5jz2PFmLrBHq4oUfwxLiG/hU1pUdSDGkotNJw4aCnzPgppn2FJJ+GH9SJy2poiSuJVDJlEX/+rkPZZhrauGwh6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846756; c=relaxed/simple;
	bh=lacU/TSx1NcvabfxvNBRGifDGK3o9moYIvo+260BSeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAtBE5wm9mDv0GM3ieNUJEV4PGP8Yxb9FWE3emDVxToydFZa3qSE4mTjmCRmDvobsqD5Ffq7rWaP0566ieSR3rwhnviC7TauRk3dtM9Mbdlbgs8oqt4elLFdIbwHnmMCigvbO4+88VTDDylDQVtKL4gZYQVtm18P0sIguYmW+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPpXPEkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPpXPEkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79421F000E9;
	Thu, 27 Aug 2026 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846755;
	bh=q6F3biC/iYrHhvp5844L0IIL+RiXhuFzeg4V45yJTy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KPpXPEkF3+4Zg+igYUAjGWxy/dUdkDcXbN6DerCJ/AfY7aWbUlVp5zdhQOnCL2I0+
	 HItC7noi1Yuygq5IUEsTbkVlTheIBJ7Up45m/qhPnUMun30kEoiUrBxN6DGaAc9q+K
	 +YiwVQS0OESkYLCw4cTAnUvOlsJVkLx6iZxBypRcpe1JZkpfqxIyorJN6US2Mp1X7X
	 Mu6V9EEof6EbNTL5r9NoB6o/7YbaS6ZIaydN8TcrMkWkgbvmwELfJdmrsrr3tux5CB
	 14g6KxUUGvUXiaXjLlc1RLgvRucugKjTNXkSY4vRoS45sQNRPwR6uTeP+p7sdL+Yy/
	 hsG7dTdPr3P9g==
Date: Thu, 27 Aug 2026 17:05:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
Message-ID: <20260827-skipper-egomaniac-ac6aeb078b9d@spud>
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
 <20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
 <20260826-salutary-skype-524c69932dc2@spud>
 <87ik4wgfbc.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I5t7dZcYEjhqEG0J"
Content-Disposition: inline
In-Reply-To: <87ik4wgfbc.fsf@pengutronix.de>

--I5t7dZcYEjhqEG0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:04:07AM +0200, Steffen Trumtrar wrote:
> On 2026-08-26 at 17:01 +01, Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Aug 26, 2026 at 02:48:40PM +0200, Steffen Trumtrar wrote:
> > > Currently, the output-impedance can only be set to default, minimum or
> > > maximum or via a nvmem cell.
> > > In cases where there is no backend for a nvmem cell, a value can not =
be
> > > set.
> > > > Add a DT binding, 'ti,output-impedance-ohms', for specifying the
> > > output-impedance via a fixed value. The existing boolean values for
> > > minimum and maximum still take precedence over the new value.
> > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 +++++++++=
+++++++
> > >  1 file changed, 16 insertions(+)
> > > > diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > index 7a6fe516bab27..49fafe3ce6f47 100644
> > > --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > @@ -38,6 +38,16 @@ properties:
> > >      items:
> > >        - const: io_impedance_ctrl
> > >  > +  ti,output-impedance-ohms:
> > > +    description: |
> > > +      MAC Interface Impedance control to set the programmable output=
 impedance.
> > > +      Valid range is 0x00 to 0x1f (32 steps).
> > > +      - 0x1f =3D 35 ohms (minimum impedance)
> > > +      - 0x00 =3D 70 ohms (maximum impedance)
> > > +      - Step size varies with process.
> > > +    minimum: 0
> > > +    maximum: 31
> >=20
> > Your property is named in ohms, but not implemented in ohms.
>=20
> So without the -ohms?
>=20
> > pw-bot: changes-requested
> >=20
> > Can't you just achieve the same result using the existing max property?
>=20
> The max property is a boolean which just says "use 70ohms".

Ah, I somehow missed that. I thought it was a uint32...

>=20
> > I don't get the use case where you specify a max, but then don't want to
> > use that max. Just set the max to what you actually want?

And this question was based on that assumption, so while your answer
makes no sense that's because the question didn't. Sorry bout that.

>=20
> That's why I added the exclusion in the binding, because having nvmem-cel=
ls
> and/or any of the other output-impedance bindings doesn't make any sense.

--I5t7dZcYEjhqEG0J
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapBgXQAKCRB4tDGHoIJi
0k5uAQC8qINi5nlfRFTvNWGd3w0ol15pK4HH52QQGhPE/H47lwEA1Hl4qytjPTrZ
fKXD4HlmX5L6WxP1b57iK9WHwP8BfQI=
=58fY
-----END PGP SIGNATURE-----

--I5t7dZcYEjhqEG0J--
