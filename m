Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA810486BA2;
	Tue,  1 Sep 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284874; cv=none; b=UZcTe16RagdkD8ObDFWfzStgn8he1etWhqjdnxPkQ0oUU2aX6MAHxeZOn3QZJx9gI6s3OZWtubzAksYTEQZ9YBQUhkD+0DCHwGUA/eGyoUs4R/WWsFbf0IZeddHTHImbu/CwdGI2iHL8XK1TrgDCHt655hTfBNt52p4CaXMPg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284874; c=relaxed/simple;
	bh=wPYvRtpXvkiZI37d11xCLTEtgmrY79MeudmLn8+T5cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQaRVVmOY2lWP/nUUveP+I66CoVB/raA19iXmIzimirZLtDxGp4HBY97B98eVoK98Z9/369mMdjZIg9ITsLSzcUG1mqFhKTo6GvmGxNuF04eXZ3D9BSOjROrZuugIeBbklHO4gHvUt7AN5TIiExNF2CZIWThVWQ6PUPunsqDtnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJTcllE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJTcllE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32271F000E9;
	Tue,  1 Sep 2026 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284872;
	bh=F71iV2K6uhTaZHgM7xzoajeOIGdtNapawXJMwfpxo0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LJTcllE1UC7DFlflnRn/4rMyH0K/WsekncLEkaNEShM2uwbdCQUPJlNi55JmIQaMv
	 OmQnqdPLFahSLW9b5Bg9en6P9RrOoZ8D6WYBhJPUAZH4v2lMZRuDc3mfFHHRb9Mw+i
	 yFTWZT8X5RyAnNxxPU/GLTZ/x1gvRAgdP7+Bpp7FvrdPNqBGA+M0nf3YugVFs4S1dz
	 SusDICEs9FSwRGY0OOBRJK2SMyuNnDRYrlXUuJjhLuW/Y9YnXlqOj60AAeDgXQtEEv
	 xSn+14eJIPjUHy0Exsg7PQ5ocR/A6qsoGzHFaYc8eMIWbf5k4PvZ3dDY3okX+pyrbZ
	 GmzlHfjpdbvFw==
Date: Tue, 1 Sep 2026 18:47:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] dt-bindings: net: Add UltraRISC DP1000 GMAC
Message-ID: <20260901-ungloved-lumping-8decad5493cd@spud>
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-2-f19454814bcf@ultrarisc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E+EGgjFlskGXNCQa"
Content-Disposition: inline
In-Reply-To: <20260901-dwmac-ultrarisc-v1-2-f19454814bcf@ultrarisc.com>

--E+EGgjFlskGXNCQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 09:27:31AM +0800, Jia Wang wrote:
> The DP1000 integrates a Synopsys DesignWare GMAC from the 5.20 series with
> one MMIO register range, one clock and one interrupt.
>=20
> It also provides fixed TX and RX RGMII clock delays that cannot be
> disabled. Board connections must therefore not add either delay in PCB
> traces, making "rgmii-id" the only supported phy-mode.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

This seems fine, just squash in the other binding patch.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../bindings/net/ultrarisc,dp1000-gmac.yaml        | 74 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 79 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.=
yaml b/Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
> new file mode 100644
> index 000000000000..13029302877b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ultrarisc,dp1000-gmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UltraRISC DP1000 DWMAC Ethernet controller
> +
> +maintainers:
> +  - Jia Wang <wangjia@ultrarisc.com>
> +
> +description:
> +  The DP1000 integrates a Synopsys DesignWare GMAC controller from the
> +  5.20 series. The SoC integration adds fixed RGMII TX and RX clock dela=
ys
> +  which cannot be disabled. Consequently, a functional RGMII link requir=
es
> +  a PCB without TX or RX clock delays, represented by "rgmii-id".
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: ultrarisc,dp1000-gmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ultrarisc,dp1000-gmac
> +      - const: snps,dwmac-5.20
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: stmmaceth
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: macirq
> +
> +  phy-mode:
> +    const: rgmii-id
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phy-mode
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@38000000 {
> +        compatible =3D "ultrarisc,dp1000-gmac", "snps,dwmac-5.20";
> +        reg =3D <0x38000000 0x1000000>;
> +        clocks =3D <&clk 0>;
> +        clock-names =3D "stmmaceth";
> +        interrupts =3D <84>;
> +        interrupt-names =3D "macirq";
> +        phy-mode =3D "rgmii-id";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..3b96ff0734e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28004,6 +28004,11 @@ F:	Documentation/devicetree/bindings/clock/ultra=
risc,dp1000-clk.yaml
>  F:	drivers/clk/ultrarisc/*
>  F:	include/dt-bindings/clock/ultrarisc,dp1000-clk.h
> =20
> +ULTRARISC DP1000 DWMAC GLUE LAYER
> +M:	Jia Wang <wangjia@ultrarisc.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
> +
>  ULTRARISC DP1000 PINCTRL DRIVER
>  M:	Jia Wang <wangjia@ultrarisc.com>
>  L:	linux-gpio@vger.kernel.org
>=20
> --=20
> 2.34.1
>=20

--E+EGgjFlskGXNCQa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcPwgAKCRB4tDGHoIJi
0hubAQCAFLjSWZmZU0E1r3KuYk46yvzG+991PAT0Er9z5PVP2gEAr/BS16qT/i57
kaDZmUxD93BsX16WxfpwvVRNbML23gw=
=tziw
-----END PGP SIGNATURE-----

--E+EGgjFlskGXNCQa--
