Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79148A2D1;
	Mon, 21 Sep 2026 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034221; cv=none; b=sI35FfvCuE0IDFP97O1LYSefUCn+uEPWd744ZnRpkTM2I70wMJC3B9sGeYQ+6gXiXiUPP/EF5u0L4Ng+iblmKHj6M6iJWl4sGFSEqdohHKbU3eNbRP/PkaEk3zERU1fVA1yzARguOtZBZDpc5W/R+sonFlFOX4KcodAzG4f9bK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034221; c=relaxed/simple;
	bh=MHE9EYl78HRGVHygYyZT0cQEDmD66HV8q4YoF+2bQiw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/DxwknF6N6pztewx7Fthf8GWCyWm5UmYGHLele91yoh+yZfQjpMlADoiP5zWyX4qqDT7zZwu0gvR8ax8/4oewyaUTlpNL+hwLHZbFO5fbM/kdPyE8qmWuIL8MTG0LgMPr5eqi1RqS/kLeiqWvJ5TpknJLLj4tdpHc4wkD7eRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF6G0PmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF6G0PmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79FC1F00893;
	Mon, 21 Sep 2026 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034219;
	bh=YI29IQP2xezR62b+5zBXyIijN6X8d17e5umPu2y3XFs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VF6G0PmE1pYi7UpVqfg4pDWKTKj2ibBF/5FgWEtffUfTe90hAG7dyjixUqPHd3g0M
	 9+KOOU1DSTaNCsbpIfOpNK1Hih84qE/B3dIa8AiW9LYdqtBW2z6xHxhsGUPX+4m7WR
	 zSu6sps/VJlbLAj7bacp5Jv4zrN1zEyapITC7mAV8nSiiRdyWOJ8KoddklmfnQA785
	 AMop2h4PTO/NWm1XUS4hH/VDaCxUoxxT0mkwpEFOMehjLnAmT+1ob0tKuvjfEjL7Y6
	 yW8MCXH+8miIENqPP8sLWgUejIEikfHexhcNJi2qhjuZYzpYeET+Rv5OqmNeL5vNar
	 gHBEXO6kHHYhA==
Subject: Re: [PATCH net-next v7 02/11] dt-bindings: phy: rockchip:
 naneng-combphy: add rockchip,sgmii-mac-sel property
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
Date: Mon, 21 Sep 2026 23:43:37 +0000
Message-ID: <179003421738.2160803.13963773583177622439@kernel.org>
In-Reply-To: <20260917204624.2427486-3-coiaprant@gmail.com>
References: <20260917204624.2427486-3-coiaprant@gmail.com>
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

- [Low] Concern that the newly documented `rockchip,sgmii-mac-sel`
  property has no in-tree consumer, so a DT setting `rockchip,sgmii-mac-…

--

dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property

This adds an optional rockchip,sgmii-mac-sel property to the naneng-combphy
binding so that a device tree can select whether the RK3568 SGMII lane is
routed to GMAC0 or GMAC1 via the pipe_sgmii_mac_sel GRF bit.  The property
is restricted to the values 0 and 1, with a documented default of 1, and is
allowed only for the compatible handled by the surrounding if block.

> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> index 379b08bd9e97a..8e898bce9af73 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> @@ -80,6 +80,15 @@ properties:
>      description:
>        Some additional pipe settings are accessed through GRF regs.
>  
> +  rockchip,sgmii-mac-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    default: 1
> +    description:
> +      Select gmac0 or gmac1 to be used as SGMII controller.
> +      The hardware reset value is GMAC1 (1). Set this to 0 to route
> +      SGMII to GMAC0.

[Severity: Low]
This isn't a bug, just a note for the record in case anyone looks at this
commit in isolation.

At this commit alone there is no consumer of rockchip,sgmii-mac-sel in
drivers/phy/rockchip/phy-rockchip-naneng-combphy.c, so a device tree with
rockchip,sgmii-mac-sel = <0> would pass dt_binding_check and probe while the
SGMII lane stays routed to GMAC1.

The following patch in the series, "phy: rockchip: naneng-combphy: add SGMII
MAC selection for RK3568", adds the consumer:

  rockchip_combphy_parse_dt() {
      ...
      priv->sgmii_mac_sel = 1;
      device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
      ...
  }

  rk3568_combphy_cfg() {
      ...
      case PHY_TYPE_SGMII:
          rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
                                       priv->sgmii_mac_sel > 0);
      ...
  }

The 0/1 encoding and the default of 1 in the schema match that driver code,
and bindings-before-driver is the expected submission order, so nothing needs
changing here.

> +
>    "#phy-cells":
>      const: 1
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
