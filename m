Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8304B0489;
	Thu, 24 Sep 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269666; cv=none; b=HlZromo+6xRKy7T5I2OB44+w8jmoJbTU6+mwV6HlqTz1eVfAOxFvHrOaJ0r7Twsk25r6CLfrthGJIn05gV/k0P8Lf5uW364gx+GGxUpEZATP597fUostlzuWJBXp7mrTsf0/6Ms9Fz5LzsYQcqr+xdOfUPSv8j72GLUsnlxqytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269666; c=relaxed/simple;
	bh=644BvEwPB5tOoL1EHbN0cP//S6FbslV/jzIUe7lQuCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/8TK8uxVvSRDZ1mKACccwORXnE2Prhbs+zdPtab1DpPxsfs/b7BiU3Q67qhhBp60mKhKWtf+JqY/5RM12fY28J193UTiW8T2FKBZBYoFa7mOHg5XxS9IO2Y1A1M/U6jWefmTwxLgYGc74e73WU12izOtiAZRngOjw72aVWiaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyd4wWdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyd4wWdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFC11F000FF;
	Thu, 24 Sep 2026 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269665;
	bh=cyMegrf82e7WKPoUzbh4gaX6JpbgZe+DZgjW9g4vKpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dyd4wWdW7MjntaSCG+6LZklQY6GmT39nQUvfIG6IPyRoXviwRmKe9awlvkY7km1g/
	 0PbKMdaIjnf/fpiYm9N9YZ4mC5dUKC3GwedwX3JPNqIkeFJmbiGAysgfjd7Do/Si3R
	 qOwilo9l3Y/m8sYd+kuGEqVJ4Dn1+2YHjvrmpi3nbz/HNvONVxlAvOTM5h13kFlj9B
	 p6dZ25K7jnjB2/HUQ77gfVgv2muKBBKtDvVC3YTEuEdBDCW3H2x7c91Cy+mY6WZAlq
	 SnicNU4o369IEovaRVOPGwN7KAl8DsfEbuYOK9+LCdqQxnmvwvppMo0xAKWSZV7JJ5
	 DlgV4XztEjVHg==
Date: Thu, 24 Sep 2026 18:07:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
Message-ID: <20260924-vowed-roulette-abda42cec444@spud>
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KEBf6CeFx3H+YGOi"
Content-Disposition: inline
In-Reply-To: <20260924075048.4060414-2-kyle.switch@motor-comm.com>

--KEBf6CeFx3H+YGOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 03:50:46PM +0800, Kyle Switch wrote:
> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.
>=20
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
>  .../bindings/net/motorcomm,yt8824.yaml        | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt882=
4.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml =
b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> new file mode 100644
> index 000000000000..fd62b309e7ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MotorComm YT8824 Ethernet PHY
> +
> +maintainers:
> +  - Kyle Switch <kyle.switch@motor-comm.com>
> +
> +description:
> +  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
> +
> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motorcomm,yt8824-package
> +  phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ internal, 10g-qxgmii ]

This should be after ref, but also have a vendor prefix.
Additionally, the qcom ethernet-phy-package user also has a mode
property. Net folks, should this be made common?

> +  reg:
> +    description:
> +      The absolute MDIO address of the YT8824 shared top extend
> +      register block.
> +      For internal mode, this is fixed at 9;
> +      For external mode it is (base MDIO address of the four
> +      member PHYs) + 4.
> +      Note that this is NOT the base ID of the first member PHY.
> +required:

Please use blank lines between properties and other elements of the
binding.


> +  - compatible
> +  - phy-mode
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet-phy-package@9 {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            compatible =3D "motorcomm,yt8824-package";
> +            reg =3D <9>;
> +
> +            phy-mode =3D "internal";
> +
> +            ethernet-phy@4 {
> +                reg =3D <4>;
> +            };
> +
> +            ethernet-phy@5 {
> +                reg =3D <5>;
> +            };
> +
> +            ethernet-phy@6 {
> +                reg =3D <6>;
> +            };
> +
> +            ethernet-phy@7 {
> +                reg =3D <7>;
> +            };

Unless the addresses and numbers of phys are entirely unconstrained, I
think you should add some pattern properties for them.

Thanks,
Conor.

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3ce77c839b0..ed7af1bd9521 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18409,8 +18409,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-mot=
orcomm.c
> =20
>  MOTORCOMM PHY DRIVER
>  M:	Frank <Frank.Sae@motor-comm.com>
> +M:	Kyle Switch <kyle.switch@motor-comm.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>  F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>  F:	drivers/net/phy/motorcomm.c
> =20
> --=20
> 2.25.1
>=20

--KEBf6CeFx3H+YGOi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVY2wAKCRB4tDGHoIJi
0kBtAP9gvzvMgaC7OCQYcF5YZ4f9JyQsltwQa+9COQutQHKzaQEA+BY2RPtGkYxJ
4BDLPdsVwy4Rg6wCPlqHApzUwwK2Fgs=
=winZ
-----END PGP SIGNATURE-----

--KEBf6CeFx3H+YGOi--
