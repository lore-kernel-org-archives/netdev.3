Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF324F85D4;
	Thu, 15 Oct 2026 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091954; cv=none; b=rw3exh7fj6IErK6Z6eZxVUgt+ToYvvrpDU87BD21GGEpCMsNbf2INi7JwekfDSaPpD8Lho7HarRZtTYKgcH8Dzo58MhXKKj3t/u9IKxSHT93Pij0+/u+H/fvDPVghHBiElU82q0WK7V6kHcyu5A7sAgbIsWVU+YMckmZ3GvONRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091954; c=relaxed/simple;
	bh=HQRyGIwCyD6KQ/SubEoF8tyFS9aUEx1UUBvhQHXufEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqVrYEZQO4g8S6F/uG6eI5QM0ntcLN4IsMr59aW2ZRFt5SP1i9ujOHuypPvS6UUYKTjG7e/lQWnIzFcBLRXM3YAW8N/GcZ2I8kn8f/w2KfXY+LlFTaDD8KUh9rDTPNt0RX6Sy1b0g3Ppc/w3psD9zOIqGOTMjALuKtWl65716pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+4xA+rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+4xA+rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051681F000C4;
	Thu, 15 Oct 2026 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792091947;
	bh=8BFzn4MpV/rLytOd6a1wwUut7z6g1IMcMQ0sY+6qkTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h+4xA+rnBsj+BlKQeMUZDO33npAUNRADJso2vZTNrYTbYkDbqGYyApuQwvhIdegLm
	 sn61cK7b6BGHnWW5mpOnUJhj9j18y2BPeEa/RiWVTwiH8PJtPPbSavZ4gmF5IDElst
	 QdFzUbs4MZhVUpdeeT0j03BuymitBj5Q18xfzZIBuoHSfSWQDz5Ejd+TBq577D+9tW
	 GKhW3Azy/RumQrrPdT3cinMdWIKuJqaUubEQOGhSQ0KL0eWEwP1HZCn0w+J+gQjOWS
	 93yxmAzYyoR5Yl+mb9UyAaWG44A7nsKxgdOB45OIeVqSYODIM88WfSQoR6xLRlhhTA
	 FatKBTFdexEzA==
Date: Thu, 15 Oct 2026 20:19:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Message-ID: <20261015-anthem-kitty-d0f8794da246@spud>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
 <20261015-support_ast2700-v3-1-8d7999171ac4@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P44lgaogo9RFWpq3"
Content-Disposition: inline
In-Reply-To: <20261015-support_ast2700-v3-1-8d7999171ac4@aspeedtech.com>

--P44lgaogo9RFWpq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 02:46:53PM +0800, Jacky Chou wrote:
> Add AST2700 to the FTGMAC100 compatible list and document that its
> RMII RCLK gate matches the earlier Aspeed SoCs. Allow the reset line for
> AST2700 as it follows the same reset requirements as AST2600.
>=20
> Require "phy-mode" to be present in the device tree when the AST2700
> compatible is used, matching the driver's probe-time requirement.
>=20
> Make aspeed,ast2700-mac a standalone compatible instead of pairing it
> with the generic "faraday,ftgmac100" fallback: if a node ever bound
> through the generic entry alone, ftgmac100_probe() would set
> rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
> BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.
>=20
> The existing aspeed,ast2400-mac, aspeed,ast2500-mac, and
> aspeed,ast2600-mac compatibles have the same structural problem: they
> are currently only valid when paired with "faraday,ftgmac100", and a
> node that bound through the generic entry alone would hit the same
> BIT(15) vs BIT(30) mismatch. Give them the same standalone treatment as
> AST2700, so none of the Aspeed compatibles require the generic fallback
> alongside them.

This needs to be two commits. One fixing the existing devices and one
adding the new one.

> ftgmac100_of_match[] has had dedicated entries for AST2400, AST2500,
> and AST2600 since commit 03a2aba50b2c ("net: ftgmac100: List all
> compatibles"), so there is no known kernel + devicetree combination
> where a node has actually bound through the generic entry and gotten
> the wrong EDORR bit. This part is a binding correctness fix, not a fix
> for an observed failure.

> Note that arch/arm/boot/dts/aspeed/aspeed-g4.dtsi, aspeed-g5.dtsi, and
> aspeed-g6.dtsi still declare their MAC nodes with the two-string
> "aspeed,astXXXX-mac", "faraday,ftgmac100" compatible, so this will make
> dtbs_check warn against those files until the redundant fallback
> compatible is dropped there as well. That .dtsi change will be sent as
> a separate series through the Aspeed/arm-soc tree, since dt-bindings
> changes don't go through that tree.

This should be below the --- line or not even included in the patch.

pw-bot: changes-requested

Thanks,
Conor.

>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 26 ++++++++++++++--=
------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml=
 b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..0a376b849a91 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -13,12 +13,11 @@ properties:
>    compatible:
>      oneOf:
>        - const: faraday,ftgmac100
> -      - items:
> -          - enum:
> -              - aspeed,ast2400-mac
> -              - aspeed,ast2500-mac
> -              - aspeed,ast2600-mac
> -          - const: faraday,ftgmac100
> +      - enum:
> +          - aspeed,ast2400-mac
> +          - aspeed,ast2500-mac
> +          - aspeed,ast2600-mac
> +          - aspeed,ast2700-mac
> =20
>    reg:
>      maxItems: 1
> @@ -30,7 +29,7 @@ properties:
>      minItems: 1
>      items:
>        - description: MAC IP clock
> -      - description: RMII RCLK gate for AST2500/2600
> +      - description: RMII RCLK gate for AST2500/2600/2700
> =20
>    resets:
>      maxItems: 1
> @@ -82,26 +81,35 @@ allOf:
>            contains:
>              enum:
>                - aspeed,ast2600-mac
> +              - aspeed,ast2700-mac
>      then:
>        properties:
>          resets: true
>      else:
>        properties:
>          resets: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2700-mac
> +    then:
> +      required:
> +        - phy-mode
> =20
>  unevaluatedProperties: false
> =20
>  examples:
>    - |
>      ethernet@1e660000 {
> -        compatible =3D "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        compatible =3D "aspeed,ast2500-mac";
>          reg =3D <0x1e660000 0x180>;
>          interrupts =3D <2>;
>          use-ncsi;
>      };
> =20
>      ethernet@1e680000 {
> -        compatible =3D "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        compatible =3D "aspeed,ast2500-mac";
>          reg =3D <0x1e680000 0x180>;
>          interrupts =3D <2>;
> =20
>=20
> --=20
> 2.34.1
>=20

--P44lgaogo9RFWpq3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatEnJgAKCRB4tDGHoIJi
0tRMAQDunFlmCDfUviJ8sA+t0KnHIDIY75AwiPa4adWnmVqXSwEAp1wrIKwwHcIF
8bkBRdV58YYTs+hsuuMHbKyf8BjdoQ0=
=a6xG
-----END PGP SIGNATURE-----

--P44lgaogo9RFWpq3--
