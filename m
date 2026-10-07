Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE24534AD;
	Wed,  7 Oct 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366689; cv=none; b=NfbuwYC7VRh49LGc+LnjmlD86AD4iqFlw0he7s1yEA7dz1A3JOXssqOW5FSPYLaTOIQ4Ahb/q1gTwqx7VoIi8GaBJFHYrdqLz0BM588rryYj6FW2XRzEwheaiNE85xwfuc2w/4rA9OM12dIBnLSnGsnhYgAikrY2I0iBGVKbyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366689; c=relaxed/simple;
	bh=LtRhB3/nWXvq6tuzqCA7rMyyY9+I83hH/iRsI/1S4xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxDQqMSztaY+YHm97YVqy8eHlZ/rju6ZQ/YGAbc2qmR9uooDoyIYlUvHyLye93Udix4gT2xrkeIr5WK2Q6JeZCKRU/N9zMWs6zn+Bk/XB9N3zchf2YjNVqfBtnTlR8NAx+QkqaFsvG8MbPJyJZaTVgAOQgd41fc7UGJXtMzwZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzUM7Q3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzUM7Q3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1096A1F0089B;
	Wed,  7 Oct 2026 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791366682;
	bh=tOz45MFV4Kd6InTf2fNUwVjM1vD8FNKrSsFNkWG9jKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KzUM7Q3tQ7f7gdBPajsnsVyfrl0X+VcgmmljBuwxnIyastOWSy9k503gClGgl/n0j
	 j0FRiV24qhwVt0HxUfiGOTWf5LHku8NAMNwGjUWiOAWy8wTz67xbvljsKlDK66V5D3
	 +XSOXXkAGBDplT0HzC/elsbLZ0rQTEk+olQrpe1J6YN3G/4PR8a5oUqXqQpIuCV3Sv
	 B7dRFOrmTT1u0qr5H44oiazyrhZYcCg3Ui6LODgmStu2bvBx2CYSb4YwVEYpIJMK1h
	 k/X6L45sUr5dGlKQlXOPRsUPF9Q4OpXOC+eoQGlIRak/BIgAtH/2OAJwsjBcLT0MER
	 nZgIugSJzb7dg==
Date: Wed, 7 Oct 2026 10:51:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <asYWEwjFO8g50o1i@squawk>
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-4-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qM3efczHaYFLahFS"
Content-Disposition: inline
In-Reply-To: <20261007082627.63807-4-tanure@linux.com>

--qM3efczHaYFLahFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 09:26:23AM +0100, Lucas Tanure wrote:
> The T7 has the same ethernet glue as the G12A, but the controller
> reaches memory through a pipeline stage that this SoC inserts in the
> bus path. That stage has a gate of its own, which no other member of
> the family has, and nothing else in Linux claims it. It is therefore
> switched off as unused, and the port can then no longer finish a
> transfer.
>=20
> Describing it needs a fourth clock, and the fourth clock of the
> existing list drives the timing adjustment logic, which the T7 never
> uses. So the T7 gets a list of its own with the gate in that place,
> under the name the SD and eMMC controllers already use.
>=20
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>

Didn't I ack the previous version?

What changed?

Thanks,
Conor.

> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.ya=
ml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> index 90ef79161ab1..96118b4d1560 100644
> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
> @@ -23,6 +23,7 @@ select:
>            - amlogic,meson-gxbb-dwmac
>            - amlogic,meson-axg-dwmac
>            - amlogic,meson-g12a-dwmac
> +          - amlogic,t7-dwmac
>    required:
>      - compatible
> =20
> @@ -57,6 +58,47 @@ allOf:
>              - const: clkin1
>              - const: timing-adjustment
> =20
> +  # The T7 applies the RGMII RX delay through PRG_ETH1 and never enables=
 the
> +  # timing adjustment logic, so it has no timing-adjustment clock. What =
it does
> +  # need is the gate of the pipeline stage the controller reaches DRAM t=
hrough.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,t7-dwmac
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GMAC main clock
> +            - description: First parent clock of the internal mux
> +            - description: Second parent clock of the internal mux
> +            - description:
> +                clock of the pipeline stage inserted in the bus path bet=
ween
> +                the controller and the DRAM. Without it, the controller =
cannot
> +                complete DMA transfers.
> +
> +        clock-names:
> +          items:
> +            - const: stmmaceth
> +            - const: clkin0
> +            - const: clkin1
> +            - const: pipeline
> +
> +  # Delay definitions for Meson8b and newer (including T7)
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8b-dwmac
> +              - amlogic,meson8m2-dwmac
> +              - amlogic,meson-gxbb-dwmac
> +              - amlogic,meson-axg-dwmac
> +              - amlogic,meson-g12a-dwmac
> +              - amlogic,t7-dwmac
> +    then:
> +      properties:
>          amlogic,tx-delay-ns:
>            enum: [0, 2, 4, 6]
>            default: 2
> @@ -106,6 +148,7 @@ allOf:
>            contains:
>              enum:
>                - amlogic,meson-g12a-dwmac
> +              - amlogic,t7-dwmac
>      then:
>        properties:
>          rx-internal-delay-ps:
> @@ -143,6 +186,10 @@ properties:
>                - amlogic,meson6-dwmac
>                - amlogic,meson8m2-dwmac
>            - const: snps,dwmac
> +      - items:
> +          - const: amlogic,t7-dwmac
> +          - const: snps,dwmac-5.10a
> +          - const: snps,dwmac
> =20
>    reg:
>      items:
> --=20
> 2.56.0
>=20

--qM3efczHaYFLahFS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYWEwAKCRB4tDGHoIJi
0gQiAQCnRNDWnYbBw+1lohiWh6F2GylN3jQDADGtPXSsfCKhvQEA4omhqA+mhCtG
sD965n7CT9LfUf20zqI2y5eeBX/8Oww=
=RzBf
-----END PGP SIGNATURE-----

--qM3efczHaYFLahFS--
