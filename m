Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5B4AA1EB;
	Mon, 12 Oct 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829077; cv=none; b=Xmk+CP1YGe62+OOL+byO/b2kIY54ZRdSPKgC1DPlx+OONDCmXFrdmkTCjZkjwmzMjuVufdqSXIK2dr9y8azteBt3yVSHQSpmN9WhxOa/IdUhx86OAfmwd5gG+BX+KhrxX07Sut9jLlDbmCZJd4WukzEy6qG3kd57T1nWroT1lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829077; c=relaxed/simple;
	bh=2BkQe0cPMfnSaWkaR260fccQkLruK74GyLLMi/bkJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOuekeBmRYxP/TiKH5/AsZi5bPzZyX9P6SfRLNh4vFajDnIdO/fVYsafWiAvixyCvWc4l1HVxkEU0v5AK7ZNIi+W9HEg2cT9YYzOvdPCdHH2HsPlKi1ThiBnujN0bjLecIyl5cs8jh7aH0UaanthbGyORcM+kaake8I3GN4NGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+mieiEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+mieiEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51BF1F0089B;
	Mon, 12 Oct 2026 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791829076;
	bh=CBeQqtobZlJEzGuyYJNrwxZ4pA/3QS4wDhBW1e67RRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+mieiEj0R6HLEJ19czXCyv8eLqxr1urLGS/lBP8kgfwAWQcC3oANujjH93ykSxV4
	 hQcCgSrQ+YUBkU09aVqAZr6qgpmET6odwK2iaMR8zZV6IS61cIEYF/u5yhMm69rAj4
	 sp7Js44YvQlCMoo6sgEvYW9EIe21nxP88eJ3kNWn+Uoss5f/Xm2XpSad4Ow1OdgZ/w
	 fAGqVQjdRAH6ixWNTR1qgLSWHXRfg8loeiHORzCFm6s8QCBfUUOBXHlKJRYNzPnfsr
	 7i6rmTRXvXwSbdMkws94vb8SMEjnvycGvFoH1Waa4Va7kg8XgmWIS5+YbBi4fyzI6j
	 TiDnizU4yeoJA==
Date: Mon, 12 Oct 2026 19:17:51 +0100
From: Conor Dooley <conor@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: jacky_chou@aspeedtech.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ratbert@faraday-tech.com,
	edumazet@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Message-ID: <20261012-aide-wimp-4edf96aaca1d@spud>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
 <179161911824.434549.4075299707625994950@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SKpaERQPP4yzf68I"
Content-Disposition: inline
In-Reply-To: <179161911824.434549.4075299707625994950@kernel.org>

--SKpaERQPP4yzf68I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 07:58:38AM +0000, netdev-bot+sashiko@kernel.org wro=
te:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>=20
> Low priority / nit picks for your consideration:
>=20
> - [Low] Already fixed later in this series, so the baseline decision is
>   false.
>=20
> --
>=20
> dt-bindings: net: ftgmac100: Add AST2700 compatible
>=20
> This adds aspeed,ast2700-mac to the FTGMAC100 compatible list, which
> requires the faraday,ftgmac100 fallback. It also updates the RMII RCLK
> clock description to include AST2700, and allows the resets property for
> AST2700 in the same way as for AST2600.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.ya=
ml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > index d14410018bcf6..bee9570a6f63f 100644
> > --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> > @@ -18,6 +18,7 @@ properties:
> >                - aspeed,ast2400-mac
> >                - aspeed,ast2500-mac
> >                - aspeed,ast2600-mac
> > +              - aspeed,ast2700-mac
> >            - const: faraday,ftgmac100
>=20
> [Severity: Low]
> With this patch, "aspeed,ast2700-mac", "faraday,ftgmac100" becomes a
> valid compatible pair. However, at this commit, ftgmac100_of_match[] in
> drivers/net/ethernet/faraday/ftgmac100.c has no aspeed,ast2700-mac entry.
> Such a node could only bind through the generic faraday,ftgmac100 entry
> (FTGMAC100_FARADAY).
>=20
> On that path, ftgmac100_probe() would do the following:
>=20
>   - program the ring-end bits at BIT(15) instead of the Aspeed BIT(30)
>   - leave is_aspeed false, so ftgmac100_setup_clk() never claims
>     MACCLK/RCLK
>   - register the embedded MDIO bus through ftgmac100_setup_mdio()
>   - never set a DMA mask wider than 32 bits
>=20
> Would an AST2700 node work correctly if it fell back to the Faraday
> match?

Sounds like no, can the submitter please clarify if the fallback is
valid?

>=20
> Later patches in this series fix this. "net: ftgmac100: Add AST2700
> compatible support" adds FTGMAC100_AST2700 and an aspeed,ast2700-mac
> match entry, ahead of the faraday fallback. That entry selects the
> BIT(30) and is_aspeed path.
>=20
> "net: ftgmac100: Add AST2700 upper DMA address support" then adds
> dma_set_mask_and_coherent(..., DMA_BIT_MASK(35)).
>=20
> So the problem only shows up when bisecting to this commit, and only with
> an out-of-tree AST2700 DTS on an ARM64 build. ARM64 builds are only
> enabled by "net: ftgmac100: Allow building on ARM64". Landing the binding
> before the driver match is the usual order for dt-bindings series.
>=20
> [ ... ]
>=20
> ^ annotation: none needed for the [ ... ] above; snipped hunks are the RC=
LK description and the resets allOf block.
>=20
> --=20
> Sashiko AI review =B7 https://netdev-ai.bots.linux.dev/sashiko/#/patchset=
/20261006-support_ast2700-v2-0-36de51fb8066%40aspeedtech.com

--SKpaERQPP4yzf68I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0kTwAKCRB4tDGHoIJi
0kA1AP9CO8HcgI3YQSQVtiyE5eYE1WX8RXey9PsMPJ//+flR8AEA/oL5cohuyAl0
GG/lUTcGDK6NdK6nkVGVfCV/N+mkVAo=
=uWkZ
-----END PGP SIGNATURE-----

--SKpaERQPP4yzf68I--
