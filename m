Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0A3DFC80;
	Thu, 17 Sep 2026 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670296; cv=none; b=rKaZSbALBxpYXDZYB/Z4QuYicfbMdQRyx5UAPPpTMY1ZcNdusNlz27fQ6jJxHmUynKD4x8qv4t66jPV7Xpkn48sbaULRqhijlj+ouzShirMKB4iAD6CCsEBbpRW/aCfqf7VdDcQX7VFFAtMNhgTZCkMpvMxTvZjgB59X8nf+lng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670296; c=relaxed/simple;
	bh=QTCddo+Hxufifd6nVje0XSLNtkGGDn+rj/tx/TNb9Us=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxLGVicQ7YmjtJkdaLr9m6iwqXiHIM37eVG6Mr4a+JwzcBQLNQBZWUkUmSV8E0mSMOFlQmDYiWolpk092Kkqwj1XFqDVSjk2IvHEXyW/ZDTvL55QiUixqVzIXPGf7M7biK07ML9lKNsH9yDY4MJD300gWsBfbI9z84JIN9A6VnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhTSq03i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhTSq03i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C461F00893;
	Thu, 17 Sep 2026 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670293;
	bh=zf1kCUu8WM4L383+s6LUcW/esuJTLzipcrstdCcOVKA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hhTSq03iQ6zoXwR+lFp9B+FXwhS0dIOeXGbEXOWMBs/CNKPCppfi1QtjswRE53GWN
	 h/uHSXBfV6IikDxZFYH8r8ZjaKwVNhQDGxAB1SM+zISsFK9jDzRQzI9ZttyfLq87u/
	 nQ/LewJ9rby5oxBwUpDul8rm1bzMEI0myliNMGS9mkcmVGjxo6hP3jfc8GaxCze6qI
	 tZ5SY4YgLK/7Ls1epXeLpxVxInifmWRTp3nyWKUma1XpGJSIfuEwp61mo8S/EBrNhd
	 q0oHpNzI4mOl6ArkcPORR1TthO7EUbpdH+Ti8vU3AqwpSkhO1gyrVQKnOwSJqw8i+Y
	 0GDIvGNrX0bPw==
Subject: Re: [PATCH net-next v6 04/11] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
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
Date: Thu, 17 Sep 2026 18:38:11 +0000
Message-ID: <178967029166.22033.17008867040431994896@kernel.org>
In-Reply-To: <20260915123802.1561724-5-coiaprant@gmail.com>
References: <20260915123802.1561724-5-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] The 'required:' list of the new schema mandates 'phys' and
  'phy-names', but the SoC-level node added by the companion patch…
- [Low] Concern: the binding invents a per-port child-node ABI
  ('ethernet-pcs-mii@[0-3]') and mandatory property set that no in-tree…
- [Low] Concern: the binding omits 'resets'/'reset-names' (RK3568 CRU
  exposes SRST_XPCS, SRST_XPCS_TX_DIV10, SRST_XPCS_RX_DIV10,…

--

dt-bindings: net: pcs: add rockchip,rk3568-xpcs support

This adds a new YAML binding for the Synopsys DesignWare XPCS block
integrated on the Rockchip RK3568 SoC.  The block is described as being
accessed over APB3, fed by a Naneng Combo SerDes PHY, and exposing four
MII ports as child nodes selected through pcs-handle from a MAC node.

A few questions below, mostly about how the required property list lines
up with the dtsi node added in the same series.

> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..703fcff0e3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> @@ -0,0 +1,110 @@

[ ... ]

> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: serdes
> +
> +  power-domains:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^ethernet-pcs-mii@[0-3]$":
> +    type: object
> +    description:
> +      One of the four MII ports of the XPCS. The port is linked to an
> +      Ethernet MAC controller via the pcs-handle property in the MAC's
> +      device tree node.

[Severity: Low]

This isn't a bug, but as a standalone patch this per-port child node
scheme documents an ABI that nothing in the tree consumes yet.  With the
rest of the series applied it does line up:

drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_create() {
	if (of_property_read_u32(np, "reg", &port))
		return ERR_PTR(-EINVAL);
	...
	pcs_np = of_get_parent(np);
	...
	if (!of_match_node(xpcs_rk_of_ids, pcs_np))

and the consumer side resolves the same node:

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_pcs_init() {
	pcs_node = of_parse_phandle(np, "pcs-handle", 0);
	...
	xpcs = xpcs_rk_create(priv->device, pcs_node);

Would it be worth mentioning in the changelog which patch in the series
implements and consumes the ethernet-pcs-mii@N children, so the ABI is
not read as unexercised?

> +
> +    properties:
> +      reg:
> +        description: MII port number.
> +        enum: [0, 1, 2, 3]
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - power-domains

[Severity: Medium]

Does making phys and phy-names mandatory here conflict with the SoC node
added by "arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes"?

arch/arm64/boot/dts/rockchip/rk3568.dtsi:

	xpcs: ethernet-pcs@fda00000 {
		compatible = "rockchip,rk3568-xpcs";
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <0x0 0xfda00000 0x0 0x200000>;
		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
		clock-names = "csr", "eee";
		power-domains = <&power RK3568_PD_PIPE>;
		status = "disabled";

The SerDes link is only filled in at board level:

arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts:

	&xpcs {
		phys = <&combphy2 PHY_TYPE_SGMII>;
		phy-names = "serdes";
		status = "okay";
	};

dt-validate checks disabled nodes too, so wouldn't make CHECK_DTBS=y
report missing required properties phys and phy-names for the xpcs node
on every rk3568 board dtb other than Photonicat?

Should phys/phy-names be dropped from the required list (or gated), or
should rk3568.dtsi carry them instead?

> +
> +additionalProperties: false

[Severity: Low]

This isn't a bug, but the RK3568 CRU exposes SRST_XPCS,
SRST_XPCS_TX_DIV10, SRST_XPCS_RX_DIV10 and SRST_XPCS_XGXS_RX for this
block, and the schema has no resets/reset-names, while
additionalProperties: false forbids describing them.

Nothing in the tree needs them today: git grep SRST_XPCS at the end of
the series only matches include/dt-bindings/clock/rk3568-cru.h,
drivers/net/pcs/pcs-xpcs-rk.c requests no reset control, and
resynchronisation goes through the in-IP soft reset:

drivers/net/pcs/pcs-xpcs.c:
	static int xpcs_soft_reset(struct dw_xpcs *xpcs,
				   const struct dw_xpcs_compat *compat)

The power-cycle case is also avoided in the driver, which keeps PD_PIPE
powered:

drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_serdes_phy_poweron() {
	ret = dev_pm_genpd_rpm_always_on(dev, true);

Adding optional resets later stays backward compatible, so this is only
a suggestion: is it intentional to leave the CRU reset lines out of the
binding?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
