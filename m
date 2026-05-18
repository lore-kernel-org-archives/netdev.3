Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843F405C33;
	Mon, 18 May 2026 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136753; cv=none; b=d0kyscRs5ClJluszXmizsWPCe5K2qqKm+978/yF8JhntAzAeHRbofieSGyOGlDYZ2DHIKrtmwz4LKGVQUFAFCWS33JrAVcm1/Z8DjBp5qAwN8uBtHAX5v+PBfFGHQj0eMgSaZyfdDiF487hTny+UD2qE5LMnAtA7KOm3Ay+LGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136753; c=relaxed/simple;
	bh=IBsdB8Nuuwi1MR6kLJwaKONOD3M/Wjoh1pALRTWL4wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpiftKYaleYaCdn+/kz8SVwQnrG3KNY3cj1KwVuHzgNxhecbXIECcx/dceEezY43ra/wwIAdEXoeWgB2vuZ4tHyjzVnzqIT4OAnvI2uzwzl5WyMEMxxEKWwTyFbdzpiBU8E/x5eD9u71il8D7GiOWkv+BJ7op0ac/C5p4zzKTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDVJFcs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDVJFcs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78E4C2BCC6;
	Mon, 18 May 2026 20:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779136753;
	bh=IBsdB8Nuuwi1MR6kLJwaKONOD3M/Wjoh1pALRTWL4wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDVJFcs9S3dQSeuf2JbHQ1PyqqkxmFvhpEBMwfi1KvUFgGFBjf7XFSNBRO1USUFcv
	 SouTl7HkQ5Tk8AtVCi/sbtbomdMLCGvKKgGm/EvLjQlJ74klVOkkEGY1vlxS1iNgMh
	 d8lZ2mj57fRgxjbauXlK9DJPEBsXAyEVbzqWBCNFCNH/9NK9H1u3ggSPKpW2XyW7LF
	 kL2Uhk0U2DnV3CxFbWR+DRjWV46Ok3wy69dhTcNqxgdycU5dOBW1R6S29LrF5tWRjE
	 uTmhGVsKxPt6lsZ4mbFxHT54k3EvXX06HypG/Ozn705JhJfGNkCL9/LeKQs29d+OaU
	 li7m3j7OFAQ2w==
Date: Mon, 18 May 2026 22:39:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 01/10] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Message-ID: <agt47l8NuOj-Ufr8@lore-desk>
References: <20260516-airoha-eth-multi-serdes-v7-1-99e0093303e2@kernel.org>
 <20260517055811.EFECEC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z58LbN+oPyY9Nri3"
Content-Disposition: inline
In-Reply-To: <20260517055811.EFECEC2BCB3@smtp.kernel.org>


--z58LbN+oPyY9Nri3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Unconditionally requiring `#address-cells` and `#size-cells` f=
or `ethernet@3` and `ethernet@4` breaks backward compatibility and causes `=
dtc` warnings.
> - [Low] The `reg` property in the `airoha,eth-port` node incorrectly uses=
 `maxItems: 5` instead of `maximum: 5`.
> --
>=20
> commit f8c9c25c14697c9de91b47f1ea5850c1b33f44a9
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
>=20
> The EN7581 and AN7583 SoCs support connecting multiple external SerDes to=
 GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner. =
This
> commit introduces the ethernet-port property in order to model a given
> net_device connected via the external arbiter.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > index fbe2ddcdd909c..7144d6da7394b 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -130,6 +130,46 @@ patternProperties:
> >          maximum: 4
> >          description: GMAC port identifier
> > =20
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            reg:
> > +              contains:
> > +                items:
> > +                  - enum:
> > +                      - 3
> > +                      - 4
> > +        then:
> > +          properties:
> > +            '#address-cells':
> > +              const: 1
> > +
> > +            '#size-cells':
> > +              const: 0
> > +
> > +          patternProperties:
> > +            "^ethernet@[0-5]$":
> > +              type: object
> > +              unevaluatedProperties: false
> > +              $ref: ethernet-controller.yaml#
> > +              description: External ethernet port ID available on the =
GDM port
> > +
> > +              properties:
> > +                compatible:
> > +                  const: airoha,eth-port
> > +
> > +                reg:
> > +                  maxItems: 5
>=20
> Could this maxItems constraint allow the reg array to contain up to 5 ele=
ments
> (e.g., reg =3D <0 1 2 3 4>)? Since the parent node enforces #address-cell=
s =3D <1>
> and #size-cells =3D <0>, shouldn't this use maximum: 5 instead to restric=
t the
> numeric value of a single port ID?

ack, I will fix it in v8.

>=20
> > +                  description: External ethernet port identifier
> > +
> > +              required:
> > +                - reg
> > +                - compatible
> > +
> > +          required:
> > +            - "#address-cells"
> > +            - "#size-cells"
>=20
> Will unconditionally requiring #address-cells and #size-cells for etherne=
t@3
> and ethernet@4 break configurations that don't use the external arbiter?
>=20
> If a board connects the GDM3 or GDM4 port directly to a PHY without child=
 nodes,
> it seems these properties would fail schema validation.
>=20
> Also, if added merely to satisfy dtbs_check, wouldn't dtc emit an
> avoid_unnecessary_addr_size warning when the node has no children?

ack, I will fix it in v8.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260516-airoha-eth-=
multi-serdes-v7-0-99e0093303e2@kernel.org?part=3D1

--z58LbN+oPyY9Nri3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagt47gAKCRA6cBh0uS2t
rMrVAP9EyZsTnfyXznRd7nmTwDer3FoKXkXeqfHnIc5wUwqBCgEAphGulHI1Ji5e
QcSZXkF6lIsgk56KBTjhf2pNY+UG2Ak=
=wFbV
-----END PGP SIGNATURE-----

--z58LbN+oPyY9Nri3--
