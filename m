Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888892882A6;
	Fri, 23 Jan 2026 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188390; cv=none; b=qcvLhoC4MsxiwGuuOkBh9sTHZ+Fnpb9jSkF3l7pFheeXH2b9Ie+QuYgNk9B2Y+nyPYTXCJzJ6Mku24go1MJw/jy56Kb09dNsyf+uc3XkMqWojYSoyQ32D/rXT4nqIJSfaZw5zZMQ+TpAR/qoO/62B47U74XpN7bFGjrjQWp4oFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188390; c=relaxed/simple;
	bh=wtBeifSy7qkeJSaa0IMYScFgBsLsttybf7MyqZ5Ulws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiFXR/76prx9J/y9EBVPftGKTUAA8NvsqWbuP31vg8aIqnqDh5MmJMKMxvLK5yUj656sfidzfh+1yQScT1nSKLpB8QN4KBdHkuyTy0ROJo5/go1aqC1Tb4XB1Gq9OtXqG7BONDIkZDdNYtgxuow97HJebkGCydyKNzSTq9GuD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k79oYPse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k79oYPse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCF9C4CEF1;
	Fri, 23 Jan 2026 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188390;
	bh=wtBeifSy7qkeJSaa0IMYScFgBsLsttybf7MyqZ5Ulws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k79oYPse/L1sv/YX6gJcWkGhylaU8B9HD6kaP3063X795y8ZtfqlzuF/03WXxJi0I
	 RySylMiECpmbkzxUtu6VSA6Lju9ytkyWDU5ckRNmSGAMXcKixifqtgHXWzgLkpdbE4
	 ev3ivypvrafmMuRIMWDRLumU69o7D0cIF/Yok4Ch2VT88EQ9QmLuyYo6MCGrNvfNMz
	 qkpoySzejqbuf2/Dmw2VzKz5l/HifyMAqAZJyF+bwxIR8fmbP6frLNA6ABpTeo3H6h
	 oFzKh7cTYWbL+OPuA7UlMYXpejTqSs4dRSJ8lnP2yQwuzuGDIAB4pL/yhEJucaCv/I
	 VAcjpLHqFD/Fw==
Date: Fri, 23 Jan 2026 17:13:03 +0000
From: Conor Dooley <conor@kernel.org>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <20260123-dinner-aloft-e57deb6c546a@spud>
References: <20260123-dwmac_multi_irq-v3-0-cc53f2be8961@oss.nxp.com>
 <20260123-dwmac_multi_irq-v3-2-cc53f2be8961@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzRpkmi5BmiBkcB1"
Content-Disposition: inline
In-Reply-To: <20260123-dwmac_multi_irq-v3-2-cc53f2be8961@oss.nxp.com>


--pzRpkmi5BmiBkcB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 11:09:55AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>=20
> The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
> set them to allow using Multi-IRQ mode when supported.

The binding only supports s32{g,r} devices, why is the existing minimum
retained? What devices are going to not have all 11 interrupts
connected?

Cheers,
Conor.

>=20
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 42 ++++++++++++++++=
+++---
>  1 file changed, 37 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/D=
ocumentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> index 2b8b74c5feec..31d1dfeb098e 100644
> --- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -# Copyright 2021-2024 NXP
> +# Copyright 2021-2026 NXP
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/net/nxp,s32-dwmac.yaml#
> @@ -33,10 +33,22 @@ properties:
>        - description: GMAC PHY mode control register
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 11
> =20
>    interrupt-names:
> -    const: macirq
> +    items:
> +      - const: macirq
> +      - const: tx-queue-0
> +      - const: rx-queue-0
> +      - const: tx-queue-1
> +      - const: rx-queue-1
> +      - const: tx-queue-2
> +      - const: rx-queue-2
> +      - const: tx-queue-3
> +      - const: rx-queue-3
> +      - const: tx-queue-4
> +      - const: rx-queue-4
> =20
>    clocks:
>      items:
> @@ -75,8 +87,28 @@ examples:
>          reg =3D <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
>                <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
>          interrupt-parent =3D <&gic>;
> -        interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> -        interrupt-names =3D "macirq";
> +        interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 0: tx, rx */
> +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 1: tx, rx */
> +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 2: tx, rx */
> +                     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 3: tx, rx */
> +                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +                     /* CHN 4: tx, rx */
> +                     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "macirq",
> +                          "tx-queue-0", "rx-queue-0",
> +                          "tx-queue-1", "rx-queue-1",
> +                          "tx-queue-2", "rx-queue-2",
> +                          "tx-queue-3", "rx-queue-3",
> +                          "tx-queue-4", "rx-queue-4";
>          snps,mtl-rx-config =3D <&mtl_rx_setup>;
>          snps,mtl-tx-config =3D <&mtl_tx_setup>;
>          clocks =3D <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;
>=20
> --=20
> 2.47.0
>=20
>=20

--pzRpkmi5BmiBkcB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXOsHwAKCRB4tDGHoIJi
0hDtAQDBlMUSfWsHHQg8yRbhsQ71gVddQ3WlmA98T1YtlwurwgEAj6PZ1+oZoTDk
mOqOpsArfAkfNxVnyMEO1zFuSv7QAAs=
=Tnki
-----END PGP SIGNATURE-----

--pzRpkmi5BmiBkcB1--
