Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D19385D94;
	Mon,  5 Oct 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197187; cv=none; b=Qs6igASj+htYNAxan0nkoGBuqNCk4iVMwQg2udw/6oR5tVwxTTOPFEjHSnMPMx2QZbjM0DOekOFsyH2Wrul9SfOxwkxp8AXP2OYfgD8K3fb1mauJsAns33a5ihVdZLkgLLXVKJ4mhj22pbHV5hRpczHSG2uZD5v9FsFDLqsaSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197187; c=relaxed/simple;
	bh=dHMACaWYMeE13Va/fHy15h8CSXR5scS7BNxw2ctt8y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks23uG5S+V3T5UqCmVd+OlcSpwnsguJh6AYV6eZ2NzLmzLz/TsZs1LsiVhhX17N4dKXeRU3XBL20rqbNu8mMz1WTAssBpynNKzpxyg+SvQhFCsfBG3D1PMN3xUhcPIaKKwcF/ly538jzfqtuvCjMh+bjojVDzIxxS9ZueNRV4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcun3XAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcun3XAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F9D1F00893;
	Mon,  5 Oct 2026 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197186;
	bh=/d8LfWyLYdaFbqA2Zb7PPVzA3eT0mVZ68XMXAvLeC0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bcun3XAstKR5IyK7IU9Nfj+U15NzNKZwLn5GhGzfSHOfATfiIPYoSMvvmSUe6in/h
	 lAbpP66YUjBUB6fAdtJhFkLYxx2LYFqfjhKwjTlpZQrgPmyNsoq0A1BuvskXwdrXDq
	 oR9U1vkXfbQuxfNwMCAUx1R1BA2OIDcL+9ANhlnCW9qfS9Ih6UZnNDv+JUYEN9lCw1
	 Lr9LQalvJRFbQdxbL86oUuKjJM/gn/TmSfk5cY36e72pDeP3g0/c/uxDOiJrTvS3Jv
	 ltuxqcVz2cDdjvMGrCHYNvdMuXwo6egJ38MQLg4oW5pMWQ0LY6go7qxYpE/h/eeSDt
	 lxzPLwmmYOmoA==
Date: Mon, 5 Oct 2026 11:46:19 +0100
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
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH 2/6] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
Message-ID: <asN_-5zalENhkdVA@squawk>
References: <20261004144046.391444-1-tanure@linux.com>
 <20261004144046.391444-3-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JIUT8vrAkNrJ90Yp"
Content-Disposition: inline
In-Reply-To: <20261004144046.391444-3-tanure@linux.com>

--JIUT8vrAkNrJ90Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 03:40:42PM +0100, Lucas Tanure wrote:
> The T7 has the same ethernet glue as the G12A, but the controller
> reaches DRAM through a pipeline stage that the hardware design inserts
> in the bus path. That stage has a gate of its own, which no other member
> of the family has. Nothing else in Linux claims the gate, so it is
> switched off as unused and the port can then no longer complete a
> transfer.
>=20
> Describing it means a fourth clock, and the fourth clock of the existing
> list is the one driving the timing adjustment logic. The T7 applies the
> RGMII RX delay through PRG_ETH1 and never enables that logic, so it has
> no use for that clock. Give the T7 a list of its own with the pipeline
> gate as the fourth entry, under the same name the SD/eMMC controllers of
> this SoC already use for the equivalent stage on their own bus path. All
> four entries are required, since the port cannot move data without any
> of them.
>=20
> The RX delay range is the one the G12A has, since it is the same
> register field.
>=20
> The compatible pairs the T7 name with the 5.10a Synopsys core the MAC
> reports, and with the generic fallback.
>=20
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
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

Have you checked that this actually works as a limiter to only 4 clocks?
There's an additionalItems: true in the snps,dwmac.yaml that I don't
know if will permit random additional items here.

Cheers,
Conor.

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

--JIUT8vrAkNrJ90Yp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasN/+wAKCRB4tDGHoIJi
0oDyAP4+IQpTnFmpW2yrTw+Bsr5db2sboD7vx1z7xYwq24/bEgEAgceiW2kGrrqP
RgLSuoYLpe5+tAKurXzLtYmc7bAuaQs=
=bcjg
-----END PGP SIGNATURE-----

--JIUT8vrAkNrJ90Yp--
