Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516AE3F9281;
	Mon, 14 Sep 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417480; cv=none; b=iBiaXm29kpMoOBGHDNz6Nc4/KRtPvk2QOqqVfCm7C1XYAl2gFTbolRTIqmydhkoHRrpI+kEPev+EtXpc/u05cy0uOZ86Pnn7K4t/b0bJk1mj6ESdayFY/jP9Zt0uobZ3j/DUwH+Jckh4azwUy60wb6gr7tBqat7uncvIv1Gg9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417480; c=relaxed/simple;
	bh=dm251GqTT3gyfm+K1Bfjq7a+8epZgLsWuIE81uDPgNs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o79VX/exYt6vlky7AzcO3DUeepMQewjgvsaZs+Gplm8DZLOLYZkUL+S/nqyMPWAQaxIVa2pjwsaoYULBe+1f/IKMf/EvRmYnHLVWQJwp26PK/dLQkZA8Gdv/hG4gAvd1OTOxj3B2sAm0NeHrZN0aWoQHNKBJ5ZuNKkUaKktUkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Q/E5xB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8Q/E5xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9161F0089E;
	Mon, 14 Sep 2026 20:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417479;
	bh=w587efkOjiQf9pLi3wYoyzihoJi5RgWEhsC3DWDduOI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c8Q/E5xBLlpVxk8HmFhY6cfDA7hI4fRNR/3W/efZKa9vyQzeaSLvRcYsG0+FW8ZYy
	 7ZSdFWp7b1aOLOdyfjh8uENE+aE35r9MiUTDggEJCKY89RvwO5cSsj06/p0MWVzxe9
	 AlDg3ZeTnVfNeKU38bTpzyjnywHAwVAGSgBPkkaLKXZ1u23spa1IqMF8tJwLFQtW8t
	 MDFeFzcuTHiB0wd+hLlHUmO95dCZR4CVRhzi9M0R2wARVMqBVJAsI5BNkmk8l/bCjL
	 WIldtGsE3g4di0Z8D9Ys5RybXB9k6t1tqJPFF7hZtOtDc5IzmQ07sm29oq5sazcLQr
	 H8h4foIq0Z7Vg==
Subject: Re: [PATCH net-next v5 02/11] dt-bindings: phy: rockchip:
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
Date: Mon, 14 Sep 2026 20:24:37 +0000
Message-ID: <178941747711.22033.8495700704733189874@kernel.org>
In-Reply-To: <20260913185849.907479-3-coiaprant@gmail.com>
References: <20260913185849.907479-3-coiaprant@gmail.com>
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

- [Low] Concern (validated as NOT a defect in the series context): the
  binding adds `rockchip,sgmii-mac-sel` while, at this commit alone, no…

--

dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property

This adds an optional rockchip,sgmii-mac-sel property to the naneng-combphy
binding so a board can select whether the RK3568 SGMII interface is routed
to GMAC0 or GMAC1.  The property is restricted to the RK3568 compatible via
the existing allOf conditional and defaults to 1 (GMAC1).

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
> +

[Severity: Low]
At this commit alone, is rockchip,sgmii-mac-sel read by anything?

rockchip_combphy_parse_dt() in
drivers/phy/rockchip/phy-rockchip-naneng-combphy.c does not look it up,
struct rockchip_combphy_grfcfg has no pipe_sgmii_mac_sel descriptor, and
no in-tree DTS sets it, so a kernel built from exactly this commit would
silently ignore the property.

This resolves itself later in the same series: "phy: rockchip:
naneng-combphy: add SGMII MAC selection for RK3568" adds the parsing

	priv->sgmii_mac_sel = 1;
	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);

along with the RK3568 pipe-GRF descriptor

	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },

and the write in the PHY_TYPE_SGMII path of rk3568_combphy_cfg(), and
"arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port" adds the
first user:

	&combphy2 {
		rockchip,sgmii-mac-sel = <0>;
		status = "okay";
	};

So this is noted only for the record, since the binding and its consumer
being split across consecutive patches is the normal series layout.

The remaining point is a design question rather than a bug: is a raw
uint32 MAC index the interface preferred here, or would a phandle to the
GMAC controller node be a better fit for describing the routing?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
