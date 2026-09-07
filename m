Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716973EEAC1;
	Mon,  7 Sep 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801997; cv=none; b=Age4/QKtXTfGvIKUEKO7Vc7qKyIXdqIvNHHEPgR6sfybvqO6xu8Ir9dAENEZZeZ2ZasgTaa+iuEndjkJ4K4j3STlzWPVUQYOx/uj+dBm2Rod9jWyFfUXj0f2JvyLoZxGti5IBuLW1nA1eMmsryyGJ4d8fPMt75qGva2gka/mHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801997; c=relaxed/simple;
	bh=eqskA1VjthOmHKa0hZ6Zmh2m5htnj0F978lZrJxeTx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM9Zc5CgUQi3ZghL7XT4Ozyl2OyvrMMCWTkaetV87SuNUZOim/2LQYDQNEcw4Ab5Zum4TXlxhotIdKW9UT/K19dhS6Pnc1BKzegMdHYBDmRPbjtT0LjLz8gtKvq+btDTKPQoqR0qLYq+Do/kWl9reu5yB/bIwNm4QhMblZaqDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENU9nkXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENU9nkXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A8B1F00A3A;
	Mon,  7 Sep 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801996;
	bh=91SRoZDdLD+HhVe8dFmoX9MKbAE8G0CUPo4lkv6+zTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ENU9nkXtX1rg/XAELd15uYMWC9pZLh/+Wzjk3JTk9w4Lq+hfeGuGkTINVPsPXcENa
	 mesgXj7LZuw/o8E49l5s0IXNEwacqEgf5JdwO7SOJdxX7TzqtqxpGEQe2U7uYChRmu
	 eaUsTabeDrFlUYgdShrKyxmBIUSz7sLiVBHt4CqIMgrzEZNZFB5yywIFznIDrNx1IZ
	 QY8ZwwAFLUIYAhkspCEGvsMOxdmcU7y9nodTXXCGtP7MAMm64ANJBNH1tdfTrkuo1b
	 DwSJqbPaF57zBoyi+zAJ3TJECmertmVKH2fPaumz3eDYrtIn2FGvB28Q3vzQuo2BJz
	 RAIufsyM5OkCw==
Date: Mon, 7 Sep 2026 18:26:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, andrew+netdev@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: ethernet-controller:
 add phy-needs-host-firmware
Message-ID: <20260907-shallow-universal-b614da6fe0c4@spud>
References: <cover.1788711837.git.f@lex.la>
 <20260906174621.4107320-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jqVFKD0jBpgf4Aly"
Content-Disposition: inline
In-Reply-To: <20260906174621.4107320-1-f@lex.la>

--jqVFKD0jBpgf4Aly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2026 at 05:46:18PM +0000, Aleksei Sviridkin wrote:
> A port can reference a PHY that cannot be identified or driven when
> the controller connects to it, because the firmware the chip needs is
> not in hand yet. Such a port is dropped at setup and stays unusable for
> the whole uptime, even though the PHY works seconds later.
>=20
> The flag declares that the PHY behind phy-handle is expected to become
> usable only after this controller has probed. A consumer that sees it
> keeps the port and connects the PHY once its driver binds, instead of
> failing the connect. The prefix names the entity, like the other
> properties here that name what they describe rather than the
> controller; a PCS needing firmware would get pcs-needs-host-firmware
> by the same rule.
>=20
> It sits on the controller here because that is where the waiting
> happens. The flag says nothing without a phy-handle to qualify, so it
> depends on one; the deprecated phy and phy-device spellings are left
> out, since no tree combines them with a property this new.

That doesn't seem right, sounds like it should be on the phy if the
behaviour is caused by the phy.
In fact, it seems like something that should be determined when the phy
is identified, not really sure why it needs a property at all? Or based
on the fact that the phy has firmware-name.

>=20
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>  .../devicetree/bindings/net/ethernet-controller.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.ya=
ml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 1bafd687dcb1..074c54fa6d78 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -108,6 +108,13 @@ properties:
>      $ref: "#/properties/phy-handle"
>      deprecated: true
> =20
> +  phy-needs-host-firmware:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The PHY referenced by phy-handle runs firmware that the host must
> +      load before the PHY can be driven, and so is not usable for as
> +      long as that has not happened.
> +
>    ptp-timer:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -240,6 +247,7 @@ properties:
> =20
>  dependencies:
>    pcs-handle-names: [pcs-handle]
> +  phy-needs-host-firmware: [phy-handle]
> =20
>  allOf:
>    - $ref: /schemas/net/network-class.yaml#
> --=20
> 2.53.0
>=20

--jqVFKD0jBpgf4Aly
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap7zxwAKCRB4tDGHoIJi
0pNiAQCPmq9WGlOMGaIUC4rvMdLDP9jYBzLwQnKtTcsk/5RolQD9HEgJmCDW2Q8y
TgkdOWSWcTYwlHPZKBT9auPJTJfwAws=
=XDrU
-----END PGP SIGNATURE-----

--jqVFKD0jBpgf4Aly--
