Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71093FF8B6;
	Sun, 18 Oct 2026 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305931; cv=none; b=Ku9lZFqd0COdTKyzcRSSWJAqEVofMJzI3Zj06+1XV1AasuQtcIyTBPe7QgOjOc8fxRp4qfiFCmpr8wagsUDVdipDeR8vAUdCib8Wldj1Xnv44jMPfG2CBPMhNCty3o0eWYPUY0dDAswQxKrjhhMGWupNEv9hhwMAO0HMu/G2uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305931; c=relaxed/simple;
	bh=9dViw+Y6M0pF7uvLyznKBWKdfoj2NaUfYgrhXpjj7fk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvr0AvTDGPztY90e66ftXLdbPISnsjF2nSLq9t9vs5jCVfizpa2kSByhVBvQHq4YKpOThiUb9bYlju3EGyANSnWhrxtWpZbdOgLotdkW3oVvMtrcsr5xatUVfLer9bXLVDEOtZqrR0kBJwGaa6Pr/Mw0hML/ae5ghkurbqMC8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zogmw17u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zogmw17u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320A71F000C5;
	Sun, 18 Oct 2026 06:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792305930;
	bh=7foX2sltJUBrduQaVLWCnWkINXoCkL4ewEk5y5ZKQ58=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zogmw17uoSjVmvTpbTjGgSQHk/XQKQObiSDRXGOMLOqj8YxLEaWE4DCQwudfUyuzJ
	 GEjLPRfApfAvyS6x9APx5Yr4MO9E5I5b3tCAZ13Dkxzy9mbt+Ekz4FsLZNlY/nKd2U
	 HGStFM2SUZoqs2sWqHojVeCh/dswU9yY6cQkSWRrSmQYR3pZbp9SFVeSCJajUEv3SJ
	 iWzKzWf9ZXpjSsIVp9Pj4sxX2VktaHgX/3fcJ3GC+2rWUAisjlXlQsKYqmQsJ5SeS/
	 quS33+0yUAwrG7STT+Sqeo/LJ9sCsyXWivR63BWr+mj2518y1r7+JfT+BwB3K1Qirz
	 tOmqHQkZZMKWQ==
Subject: Re: [PATCH net-next v12 2/6] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 06:45:28 +0000
Message-ID: <179230592878.3135.12873232337699291552@kernel.org>
In-Reply-To: <20261017054406.1828061-3-coiaprant@gmail.com>
References: <20261017054406.1828061-3-coiaprant@gmail.com>
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

- [Low] The new binding
  Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml…

--

dt-bindings: net: pcs: add rockchip,rk3568-xpcs support

This patch adds a device tree binding for the Synopsys DesignWare XPCS on
the Rockchip RK3568 SoC. The XPCS sits on the APB3 bus and connects
internally to the Naneng Combo SerDes PHY. It supports 1000BASE-X, SGMII
and QSGMII.

> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..a331880eb11c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml

[ ... ]

> +properties:
> +  compatible:
> +    const: rockchip,rk3568-xpcs
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: APB3 bus interface clock (clk_csr_i), required for register access
> +      - description: EEE clock (clk_eee_i), required for Energy Efficient Ethernet operation
> +
> +  clock-names:
> +    items:
> +      - const: csr
> +      - const: eee
> +
> +  phys:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - phys
> +  - power-domains
> +
> +additionalProperties: false

[Severity: Low]
Should this binding let the XPCS act as a clock provider?

The RK3568 CRU uses XPCS-named clocks as parents for the GMAC RX/TX
muxes, in drivers/clk/rockchip/clk-rk3568.c:

PNAME(mux_gmac0_rx_tx_p) = { "clk_gmac0_rgmii_speed", "clk_gmac0_rmii_speed", "clk_gmac0_xpcs_mii" };
PNAME(mux_gmac1_rx_tx_p) = { "clk_gmac1_rgmii_speed", "clk_gmac1_rmii_speed", "clk_gmac1_xpcs_mii" };

These are the parents of SCLK_GMAC0_RX_TX and SCLK_GMAC1_RX_TX.
rk356x-base.dtsi passes those clocks to the GMAC as mac_clk_rx,
mac_clk_tx and clk_mac_speed. Nothing in the tree registers
clk_gmac0_xpcs_mii or clk_gmac1_xpcs_mii today.

For SGMII on GMAC0/GMAC1, a board DT would need assigned-clock-parents
to point SCLK_GMACn_RX_TX at the XPCS MII clock. This schema has no
#clock-cells or clock-output-names, and additionalProperties: false
means dt_binding_check rejects them. So the DT can't name the XPCS node
as the source of that clock. Boards would have to use a fixed-clock
placeholder carrying the CRU's string name instead.

Documentation/devicetree/bindings/writing-bindings.rst says "DO attempt
to make bindings complete even if a driver doesn't support some
features". The commit message explains why the SRST_XPCS* resets are
left out but says nothing about the MII clock outputs.

Could #clock-cells (and clock-output-names, if needed) be added for the
per-port MII clocks? Or could the commit message say why they are left
out?

> +
> +examples:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017054406.1828061-1-coiaprant%40gmail.com
