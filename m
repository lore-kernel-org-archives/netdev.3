Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E0493D5A;
	Mon, 21 Sep 2026 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034235; cv=none; b=fZ58LTPxjdryeTwYysDtFatJGmLpdxOt5ydBP44r2V9wrG1LE/65Wmxw+8ou5rFtznNMID+p8wr9vuysTjSd36yeIwYPEIDEO8mXUoLrAPK4l0Tw9r5cbITSNSbadJBJOgBO2oGfHzTFxwQcbHmMZ9xSVSf1eJ0ORy7waVzXcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034235; c=relaxed/simple;
	bh=uvx/Lf5Gu/vAt7Rz23eYYLnWBLI1zmAAPErL+1qKheM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4Csp4iDEkSTHBvP/XEg94/k08Y6lCD3lJDCNFcbDqpzIUyJK2X2TCOh92W/stG/qQC8TRai7Q8HT5sfGBm7rI+TBNzNz5U+ebmS/cmnMPhoVAVdk/9zU8VATDHDGBRzeKuVkuXRawaFMg3wAqRJdohR8HztAFFAKrK+g1gZW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgxPIqsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgxPIqsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E211F0089C;
	Mon, 21 Sep 2026 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034232;
	bh=Dju3+S6OUKK1WseHTuR/piRFLe87JxUt0W2aIyTXBpA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MgxPIqsOU1REpixYxa96+IORbVp6Tfd7AxMK0tmm/0cZ2aOxEycf8zX1drqBzeh57
	 dd5TD8jzq9pQXMdVUx1jU97L9dZy2NXLjjp3Op8LMkiO47sfHLFtt8zQgBOeRX2a7u
	 PEmTeDSE40l9VfplmQ4FxQnfWyC2IIlgnR0/dJstnvb7j+ouadQwUt3u5rLfup8R6P
	 OGx8GL/GReRuhavMLID+WImU0vO1HJaWHyB1alsiwPVqS1/WC4eIF94nDkKY/1U8aF
	 2khhtiWIx8cYJaG2lniLkxu8twsyi/SlSdNeelWBXrokljXoAYTMqg2upvqeOHeqhW
	 SpZfARksSZO+A==
Subject: Re: [PATCH net-next v7 08/11] dt-bindings: net: rockchip-dwmac:
 document pcs-handle
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Date: Mon, 21 Sep 2026 23:43:50 +0000
Message-ID: <179003423043.2160803.14939298320345950361@kernel.org>
In-Reply-To: <20260917204624.2427486-9-coiaprant@gmail.com>
References: <20260917204624.2427486-9-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern (INVALIDATED): the commit message claims `pcs-handle`
  "will be parsed by rk_pcs_init(), and a missing phandle fails the…

--

dt-bindings: net: rockchip-dwmac: document pcs-handle

This adds a pcs-handle property to the Rockchip GMAC binding and makes it
required when phy-mode is "sgmii" on rockchip,rk3568-gmac.  The property
describes the PCS device used by the SGMII support added by a later patch
in the same series.

No regressions to report on this patch.

> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 80c252845349c..bb7540e838033 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -120,6 +120,12 @@ properties:
>      maximum: 0x7F
>      default: 0x10
>  
> +  pcs-handle:
> +    description:
> +      Specifies a reference to a node representing the PCS device
> +      connected to this GMAC. Required when phy-mode is "sgmii".
> +    maxItems: 1
> +
>    phy-supply:
>      description: PHY regulator
>  

[ ... ]

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-gmac
> +        phy-mode:
> +          contains:
> +            const: sgmii
> +    then:
> +      required:
> +        - pcs-handle
> +

One concern was raised during review of the hunks above and then dropped
after checking the rest of the series: the claim that the commit message
references a rk_pcs_init() that does not exist in tree, leaving a required
property with no consumer.

Looking at the end of the series, drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
does gain rk_pcs_init(), which parses the new property:

  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_pcs_init() {
      ...
      pcs_node = of_parse_phandle(np, "pcs-handle", 0);
      if (!pcs_node)
              return -ENODEV;

      xpcs = xpcs_rk_create(priv->device, pcs_node);
      ...
  }

and rk_gmac_probe() installs it for PHY_INTERFACE_MODE_SGMII:

  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_gmac_probe() {
      ...
      if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
              /* SGMII clock always runs at 125 MHz */
              plat_dat->set_clk_tx_rate = NULL;

              /* SGMII requires a PCS */
              plat_dat->default_an_inband = true;
              plat_dat->pcs_init = rk_pcs_init;
      ...
  }

So the documented property does have an in-tree consumer and the commit
message matches the code.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
