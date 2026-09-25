Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D2373BE6;
	Fri, 25 Sep 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301820; cv=none; b=cRVzAHvXJgttSc8M1FINGRsS6S+K9bzdCsx48fYzJOMNElpwtQf7KYwKAFNdXXfZgnkyw/Wnft/C+NMI80vodRLIUN1FeWoaCTl8VNQJlR3RITeaX3lHhkVHja9idg36HVxWqLBDaNGgLi47Fgh/XBw/dwhHH9Hj2VgaaBzUteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301820; c=relaxed/simple;
	bh=S+pqyUnWJC6JbxyS4V1AYa4EwbbjPAhP5E6sCr9jQtw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CoUYSAdLfNrUEOLp5jMePEWFGey4HazSBHbS3aRrMBsxnjAV88gv0bIRJXnpuA70CyQt3+XwUMqgNh+RjCkxhk38CIqo8losvRXZcOIuQZzglEYTCqjjOm1HzmpDhtRCC3tvQGKCxUiqif+7rndE7bM1GJ/4wL1fn3FrAQei9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2IWEw2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2IWEw2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17431F00893;
	Fri, 25 Sep 2026 02:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301819;
	bh=2DcEvfwfmeVBZJUGXm+guglmvCS4PPEV/BwTo5J2CK8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2IWEw2XjaXAKHXjlq/hSecnxIaNI96jV/cdtiOIjs0hrVaqddPU2KgtIpqwzhdI/
	 Vc5t30TIluHsim1Cu1eDG5nQqEDg3gVLlmTWWLCYyBeowOiQj4SoL2WadbBJNOKL0Y
	 25PeBfxgqNu4iqIxwOOOIgU3Cr6JRMB6JcjnkBlS0wuyjZjCiVmL9VaPH82NSqQEbz
	 v03gQ3C23S0I/LA2DNOFFLny5UAHXkXHXQr1o+w4diItkyxnNOahXcKY4MQj+voR7f
	 nzToISoDB7OAxyJgYRcGP507tClq2PJpZnUDDD2Jyfi8CKMKqQLtewrhNZBqr4W+zF
	 Yq8/xKfPQ7COQ==
Subject: Re: [PATCH net-next v10 02/11] dt-bindings: phy: rockchip:
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
 linux-renesas-soc@vger.kernel.org
Date: Fri, 25 Sep 2026 02:03:37 +0000
Message-ID: <179030181733.2160803.4810080310196721706@kernel.org>
In-Reply-To: <20260922200336.2201212-3-coiaprant@gmail.com>
References: <20260922200336.2201212-3-coiaprant@gmail.com>
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

- [Low] Concern (verified FALSE POSITIVE, retained for policy): "The
  binding documents `rockchip,sgmii-mac-sel` but no in-tree code reads…

--

dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property

This adds an optional rockchip,sgmii-mac-sel property to the Rockchip
naneng-combphy binding so a device tree can select whether the RK3568
SGMII interface is routed to GMAC0 or GMAC1. The property is a uint32
limited to 0 or 1, defaulting to 1, and is only allowed for the RK3568
compatible.

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
This isn't a bug, just a note on ordering within the series.

At this commit alone, nothing in tree reads rockchip,sgmii-mac-sel, so a
device tree setting it to 0 would validate without any effect on the
pipe GRF mux bit.

Checking the rest of the series, the consumer does land immediately
afterwards: rockchip_combphy_parse_dt() in
drivers/phy/rockchip/phy-rockchip-naneng-combphy.c gains

	priv->sgmii_mac_sel = 1;
	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);

and the PHY_TYPE_SGMII case of rk3568_combphy_cfg() programs the bit
described here:

		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
					     priv->sgmii_mac_sel > 0);

with the matching descriptor added to rk3568_combphy_grfcfgs, so the
behaviour is complete at the end of the series and no change is needed
here.

> [ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
