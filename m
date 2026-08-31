Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6346EC60;
	Mon, 31 Aug 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190026; cv=none; b=ctuCUiy9EhXPbBOjid48g4YsDChZGvUapQUhlOACP1Z55yWbE6AfV/KKZKi85MxnNfsDIC9xwcjPzKYzVm0X01wEhboVwZ0aDi15qx0Mqz2sz7X09JtWxRpm8w9q6WWkox7qB2PtTy0uwWxPtfO9gj51wr/6w13Z85iyDuzKWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190026; c=relaxed/simple;
	bh=0yLUrBjl+Iob/60mpPR6kEDtqWBSv7Fl622SR8uCUtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX3eh+2I6b94tpiOvdNCp1Xd6cKf0vqOIhBnk6GVReqate8Oa+VpfBTU3X6Qgy6hu8+J7FUwoxE3rKvcE/iaNSFxLbfy/a0AJv84V0n/r9+ELYyeq7RKTxii+nE7BUbuJwDxDEzJMPI755wvRAR1bQ94qOcd6AIRIJ0VwQPzcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUF8P4gM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUF8P4gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CE41F000E9;
	Mon, 31 Aug 2026 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788190024;
	bh=gUP5n/WznTmHuMrpnHMPx1TVwBqtMo5tyX2g2aCSv0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUF8P4gMGLlHFojUT/Xod7XxAXCoVoONPee4fv1BbuY65cPI3nHoixSzmyJDXOXYP
	 cxIZaO9/MJyn0wPTye7sTgjrYMNzDFYMzNYX654PnzhKxhiIjevSqQ9vAGaBuxZJw1
	 neuMfi/4kEfSVoOTx0A7K+pYk7yLVxxut+jjdREF+1r2lAtbFy33CBarPVyUTa5irQ
	 Pv6xIlF9Ht3WwfStXtvJYqZc8ATQBumuI+QaMhqdLkGKJL4zrHcF8rXRdHtHkeMCOH
	 gkQcuwTPC4tAgXrMS/rj8eFXTuzUZ1xVFkWtDHzRxfKUJGm/KDySxG3i+gTgjZ7hcP
	 NRSSR9irC+r8Q==
Date: Mon, 31 Aug 2026 16:26:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: dsa: realtek: add
 RTL8365MB power supplies
Message-ID: <20260831-awkward-routine-4198a7d5e7e2@spud>
References: <20260831123637.666457-1-o.rempel@pengutronix.de>
 <20260831123637.666457-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="07g483MsH5ZneH74"
Content-Disposition: inline
In-Reply-To: <20260831123637.666457-2-o.rempel@pengutronix.de>

--07g483MsH5ZneH74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 02:36:35PM +0200, Oleksij Rempel wrote:
> Document the RTL8365MB power rails as optional supplies. They are optional
> because the rails are often always-on; some designs break them out for
> granular hwmon monitoring and regulator control.
>=20
> They are scoped to realtek,rtl8365mb: different Realtek switch families u=
se
> different power-rail naming schemes, so these rails do not apply to other
> families such as realtek,rtl8366rb (VDDA/VDD_CORE/VDDIO/...).
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
> Changes since v2:
> - Move the *-supply properties to the top level; if:/then: now only forbi=
ds
>   them on non-rtl8365mb compatibles (Krzysztof Kozlowski).
> ---
>  .../devicetree/bindings/net/dsa/realtek.yaml  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Doc=
umentation/devicetree/bindings/net/dsa/realtek.yaml
> index 473facd87a62..b7bb60af623c 100644
> --- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
> @@ -8,6 +8,20 @@ title: Realtek switches for unmanaged switches
> =20
>  allOf:
>    - $ref: dsa.yaml#/$defs/ethernet-ports
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: realtek,rtl8365mb
> +    then:
> +      properties:
> +        avddh-supply: false
> +        avddl-supply: false
> +        dvddio-supply: false
> +        dvddio1-supply: false
> +        dvddl-supply: false
> +        pllvddl-supply: false
> =20
>  maintainers:
>    - Linus Walleij <linusw@kernel.org>
> @@ -62,6 +76,24 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  avddh-supply:
> +    description: AVDDH high-voltage analog supply.
> +
> +  avddl-supply:
> +    description: AVDDL low-voltage analog supply.
> +
> +  dvddio-supply:
> +    description: DVDDIO digital I/O supply.
> +
> +  dvddio1-supply:
> +    description: DVDDIO_1 secondary digital I/O supply for the RGMII ban=
k.
> +
> +  dvddl-supply:
> +    description: DVDDL digital core supply.
> +
> +  pllvddl-supply:
> +    description: PLLVDDL PLL analog supply.
> +
>    realtek,disable-leds:
>      type: boolean
>      description: |
> @@ -243,6 +275,7 @@ examples:
>      platform {
>              ethernet-switch {
>                      compatible =3D "realtek,rtl8365mb";
> +                    avddh-supply =3D <&avddh>;
>                      mdc-gpios =3D <&gpio1 16 GPIO_ACTIVE_HIGH>;
>                      mdio-gpios =3D <&gpio1 17 GPIO_ACTIVE_HIGH>;
>                      reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> --=20
> 2.47.3
>=20

--07g483MsH5ZneH74
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWdQgAKCRB4tDGHoIJi
0kk/AQD1Ik9lwiWECiSAZss9j3Fl4diaY24XH893jL/RxTvYpAD8DNOhT3dLrj0g
qzyx6j8ZEosO3b2fYxeOYtYWxlpbrw0=
=fqMU
-----END PGP SIGNATURE-----

--07g483MsH5ZneH74--
