Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A722C234E;
	Thu, 10 Sep 2026 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027722; cv=none; b=P9b7qwkAZa/oBazezp+gEBOvMSy088S/S3QwsUVrbQP4PS5SNDAuJShp6t5ki9LuAzLP28neaIMMkakUhovpxB5qZekxp0t+ZLs00wpf3qF2//pMAopd6E5WlM91kAIihz9hEkTkgRyK2w5RsYcQmKVTSV+EuAgKlZCYYjOW7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027722; c=relaxed/simple;
	bh=0Dx6Tiafs1bI5WjYxecNRkN9oWTS0ku7QZGgrAHKvtw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKXrEYqxl6MBz5AY8HnqsqERsWaQ1UIozyTFewNgGuU5FtqbvLiVxodIzSv+Ip3gEeIMUa/+gz0Edp4RF+80w/kaV8FLhO5PVLpe3eoMaZb0pRvLfSZZ47L7HxN9FDP2B2UEJrVM2qF4EWpbswuBEeuqDzSFo7nxYEMTKbNBKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L17xMoND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L17xMoND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F071F000FF;
	Thu, 10 Sep 2026 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789027721;
	bh=N/dfTFSYIJI0KlIowkfqgMTTkhWReiFAfFddaWbLYdc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L17xMoNDAy3MvI6ioQL67gAuAn4CgrGWq61d77/tFvaK0WueetEZOSgspX123gluw
	 hmDJYmL4zTm2JyjdCHuzTPylhEyQV7U8u38OUoX3b16tBdm4q9Z9kGta8mnvSMYCnM
	 QEKdYn8aloOUMtGbyDqcm5Xonk9dSZ2//5BOoKjJJA9yBn25u7Tp3uI47zDLvkBov2
	 ymcquXCCenh4k2WYaesvInTDvJPZmnO2Ps+LIl1QjZLnXLvktJeUBh5GuOwm3uU5NR
	 whhfeZj2fNZBPIiIA+cj03ofybaMh4dbpVlrADYOZwd4sTk1siM/cB9VFID5Vq7cdH
	 c6jolalH6VClw==
Subject:
 Re: [PATCH] dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset name
From: netdev-bot+sashiko@kernel.org
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, dinguyen@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 08:08:39 +0000
Message-ID: <178902771990.219967.12244559692120688678@kernel.org>
In-Reply-To:
 <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References:
 <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] The SoCFPGA-only reset name "stmmaceth-ocp" is added
  unconditionally to the *generic* snps,dwmac.yaml second-reset slot…

Pre-existing issues:
- [Low] After this patch,
  Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml…

--

dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset name

The patch relaxes the second entry of reset-names in the generic
snps,dwmac.yaml schema so that "stmmaceth-ocp" is accepted alongside
"ahb", and removes the Arria10 TODO note from the Altera SoCFPGA DWMAC
binding description.

> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> index db93436c96fa..d8f90d36d246 100644
> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> @@ -13,8 +13,6 @@ description:
>    This binding describes the Altera SOCFPGA SoC implementation of the
>    Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
>    families of chips.
> -  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> -  # does not validate against net/snps,dwmac.yaml.

[Severity: Low]
This isn't a bug introduced by this patch, but after the TODO is removed
this file no longer mentions Arria10 anywhere, while the family list in
the same description block still reads:

  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
  families of chips.

The compatible documented in this same file, altr,socfpga-stmmac-a10-s10,
is the string used by the Arria10 gmac nodes in
arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi.  Could Arria10 be
added to that family list along with dropping the TODO?

> 
>  select:
>    properties:
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 2449311c6d28..c7f1a7c11c8d 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -174,7 +174,7 @@ properties:
>      minItems: 1
>      items:
>        - description: GMAC stmmaceth reset
> -      - description: AHB reset
> +      - description: AHB or OCP reset
>  
>    reset-names:
>      oneOf:
> @@ -182,7 +182,7 @@ properties:
>            - enum: [stmmaceth, ahb]
>        - items:
>            - const: stmmaceth
> -          - const: ahb
> +          - enum: [ahb, stmmaceth-ocp]

[Severity: Medium]
Should this new name be gated on the Altera compatible instead of being
allowed for every DWMAC binding?

"stmmaceth-ocp" only has one in-tree consumer,
drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:socfpga_dwmac_probe():

	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");

The generic parser, stmmac_probe_config_dt() in stmmac_platform.c, only
ever asks for the second reset by the name "ahb":

	plat->stmmac_ahb_rst = devm_reset_control_get_optional_shared(
							&pdev->dev, "ahb");

Since every other DWMAC binding (mediatek, rockchip, starfive, st, qcom,
...) $refs snps,dwmac.yaml, a device tree for one of those platforms can
now write reset-names = "stmmaceth", "stmmaceth-ocp" and still pass
dt_binding_check, while no driver on those platforms looks that name up,
so that reset is never deasserted and validation reports nothing.  Would
an if/then on the compatible be preferable?  snps,dwmac.yaml already
carries such blocks (for example the compatible-gated snps,tso: false
block), and altr,socfpga-stmmac.yaml already has an allOf with an
if: on altr,socfpga-stmmac-agilex5, which looks like the natural place to
constrain the Arria10 (altr,socfpga-stmmac-a10-s10) reset naming.

> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -174,7 +174,7 @@ properties:
>      minItems: 1
>      items:
>        - description: GMAC stmmaceth reset
> -      - description: AHB reset
> +      - description: AHB or OCP reset

[Severity: Medium]
Related to the above: this description now covers two different resets
with different acquisition semantics in one slot.  The AHB reset is taken
as a shared control via devm_reset_control_get_optional_shared() in
stmmac_platform.c, while the OCP reset is taken as an exclusive control
via devm_reset_control_get_optional() in dwmac-socfpga.c.  Would separate
per-compatible descriptions make the contract clearer?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade%40altera.com
