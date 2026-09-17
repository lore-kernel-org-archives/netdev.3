Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE44973AB;
	Thu, 17 Sep 2026 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670293; cv=none; b=kIwwTR3wzG5rncc7cAttfwuB/vGGySS9F31fnOdCDYk9beP0YzvNZ40lxi3qsqdeTAw5wP9ZwubNb+oYejki+NOKnRj0imWaSatMEoKUaK8d5LLWdeFt16+d81zWyx6fYVFtsjattwRaUqX7Fq0Kcr8L9yuSTi+2ZbdMi4VUs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670293; c=relaxed/simple;
	bh=tWw9nYmX6y82wl7DH4Sw8fpWjw/zEIfBm5SzKYAZVfE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyxeSs7CrG4OVGhsVoOiSb8EC3fpAbva6x7URbklFpK+7Gxx3dLgUGfz/oJcdVk8/ljNPvzVVl0XX2JP1o6OIdUOAbcKzQ+3kPml5zQXls2vyFbF9WK3u4vHreD8s1une2Xq0L1WUf7a7i7FmnetTfi4XjJ0bkuck62++IhvVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDnBLQhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDnBLQhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164D31F000FF;
	Thu, 17 Sep 2026 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670291;
	bh=wz7ynco97WHqvgbZ/Bh5SA7Wz6otJSPrEA15/FgWv6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TDnBLQheIeWQmYvRhrxYPJhx8S25S8ThmPsf7SKU1+1N5fDmjsC1dqinkmY9AAvau
	 3tc8ofayc8hBOk11I0oC04ZSt35cNK9hRBz59poz1KajiUcUh1IUo59f+1rqGejDPz
	 wWFBukaqFKu5By7CI423UEG3rHcUg+BSgnV34Aru0xo9Z7+HPXTV79e2J6KikESd0G
	 A9RYx43ZM+oRQtcLJ0fnUogKaPAXmP2bOwjBanQ0hR3vtgs/QEwbkL3prjJRlzFced
	 XaUacDVhdebipIMtb+m6LgGs45/DH4dwXuqif2kw9yg4o6s+3E+Es44ZZuI479psTr
	 +jyOjiCELLXrA==
Subject: Re: [PATCH net-next v6 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
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
Date: Thu, 17 Sep 2026 18:38:09 +0000
Message-ID: <178967028966.22033.2377561177851606071@kernel.org>
In-Reply-To: <20260915123802.1561724-4-coiaprant@gmail.com>
References: <20260915123802.1561724-4-coiaprant@gmail.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:380-381 reads
  'rockchip,sgmii-mac-sel' with device_property_read_u32() for every…

--

phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568

This adds a "rockchip,sgmii-mac-sel" DT property so the RK3568 SGMII
interface can be routed to GMAC0 or GMAC1 via the PIPE_GRF_XPCS_CON0
pipe_sgmii_mac_sel bit, defaulting to GMAC1 to match the hardware reset
value.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 7843356a4dd47..7b867e7520064 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

[ ... ]

> @@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
>  
>  	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
>  
> +	priv->sgmii_mac_sel = 1;
> +	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
> +

[Severity: Low]
This isn't a bug for any schema-checked device tree, but would it be worth
reacting to the return value here?

The binding restricts the property to two values and to one compatible:

  rockchip,sgmii-mac-sel:
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [0, 1]
    default: 1

  ...
        rockchip,sgmii-mac-sel: true
    else:
      properties:
        rockchip,sgmii-mac-sel: false

In rockchip_combphy_parse_dt() the result of device_property_read_u32() is
dropped, so a malformed property (for example a zero-length or wrong-sized
cell, which returns -ENODATA/-EOVERFLOW and leaves the output untouched)
ends up indistinguishable from an explicit request for GMAC1.

The read also happens for every compatible, including rk3528/rk3562/rk3576/
rk3588 where the binding declares the property invalid; there the value is
parsed and then never used, since only rk3568_combphy_cfg() consumes it.

[ ... ]

> @@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		break;
>  
>  	case PHY_TYPE_SGMII:
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
> +					     priv->sgmii_mac_sel > 0);

[Severity: Low]
Should out-of-range values be rejected rather than folded into GMAC1?

The "priv->sgmii_mac_sel > 0" test collapses the u32 to a boolean, so a
device tree with rockchip,sgmii-mac-sel = <2> (or 0xffffffff) that was never
run through dtbs_check gets the GMAC1 routing and rk3568_combphy_cfg() still
returns success, with nothing logged.

A range check in rockchip_combphy_parse_dt() returning -EINVAL, or at least
a dev_warn(), would make such a device tree visible instead of silently
selecting the default route.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
