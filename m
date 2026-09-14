Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095A479887;
	Mon, 14 Sep 2026 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417485; cv=none; b=GLAzr9kpIcOz6YQFm8WoQKAEF4ZiSrjRmKWeV57stj1w4NDLzYQrGuZ6OX3d8RPnzcgcw6XfreyndGpgLxtpqiYI4rBBadtqRnG0M0rpyzC/DcnsTbJmcKg9Ixeea+HcRQQz8/eUPPoMnUOLeA15oE3L89pElILiWuIeVXLb2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417485; c=relaxed/simple;
	bh=e3c3F6kyLYw6jjJmSNz6crZSHDjAsGM1iERF9iP5cas=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1IkqIx1itFf8WenjP7pD8RBPZc1eOsg4WdEv8I77U6Su6Jd17XO9lUTQ6f98nlxLX8atLtk9utN/hvqsOkLvUjQVgov/YxEaSft64ZhWNpEp8dHEQKtU5fhma65E0HUpzXNrOD8LZOIuIIPTWabueibKeixfHK03cBw+SJm1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZSabgrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZSabgrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B91F000FF;
	Mon, 14 Sep 2026 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417483;
	bh=PX6Mb7LnvShr+I2gbXnVlA2PsFbnU1H/eODFKdsuXn0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mZSabgrU37uqXQERnxDZDn+joXc0PFT+PMJQDTe40rDxjOotL664KqzVsv8YFBhla
	 iz6uIvB22podbe6U24Ue1TJO/eutvdJYjhlYohH6ctaP9IsWZrinIUDoAfx1RxAG48
	 YJvlocLIgP71CjRu/tHysLvCKKkjHK5f4a5m2nRLDFZdz0pg2o9fo6xferPzM1xNv9
	 owo508dkLY9sSWd/q2JoUeQjWAV+roQYwgj9OfUjhRNlC3c1mzKFUfQOn0HZ5aZh7e
	 Js8O1qMMDu058FAOAy3m632G9duU2s8iU457a8K7Lqq+TH//tfpikAOlsZdM67ntp3
	 /dPXiSylfqnaw==
Subject: Re: [PATCH net-next v5 04/11] dt-bindings: net: pcs: add
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
Date: Mon, 14 Sep 2026 20:24:41 +0000
Message-ID: <178941748146.22033.11565395251077332405@kernel.org>
In-Reply-To: <20260913185849.907479-5-coiaprant@gmail.com>
References: <20260913185849.907479-5-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 5

- [Low] Concern (validated as a false positive): the new schema was said
  to fork the DW XPCS description in two, to lack the conventional…
- [Low] Concern (validated as a false positive): the four `ethernet-pcs-
  mii@[0-3]` child nodes were said to have no in-tree implementation,…
- [Low] Concern (validated as a false positive): the binding omits
  `resets`/`reset-names` for the RK3568 XPCS soft resets (SRST_XPCS,…
- [Low] Concern (validated as a false positive): the mandatory `eee`
  clock is a documented property that no in-tree XPCS code requests…
- [Low] Concern (validated as a false positive): the binding omits `reg-
  names` (direct/indirect) and `reg-io-width`, so the CSR mapping style…

--

dt-bindings: net: pcs: add rockchip,rk3568-xpcs support

This adds a new YAML binding for the Synopsys DesignWare XPCS as
integrated on the RK3568, described as an APB3-mapped block with a
Naneng Combo SerDes PHY and four MII child ports.  All the observations
below are documentation-level questions only; the accompanying driver
patches in the series do implement what the schema describes.

> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..703fcff0e3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> @@ -0,0 +1,110 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: rockchip,rk3568-xpcs

[Severity: Low]
This isn't a bug, but would it be worth saying in the commit message why
this gets its own schema and a single compatible, rather than the usual
"rockchip,rk3568-xpcs", "snps,dw-xpcs" fallback?

The glue driver added later in the series maps registers differently from
the generic one:

  drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_addr_format() {
      return FIELD_PREP(0x70000, dev) | FIELD_PREP(0xffff, reg);
  }

and remaps MDIO_MMD_PMAPMD/MDIO_MMD_VEND2 per port in
xpcs_rk_mdio_read_remapping(), so a snps,dw-xpcs fallback would let
pcs-xpcs-plat bind and touch the wrong MMDs.  Recording that reasoning in
the changelog would save the next reader the same investigation.

> +  reg:
> +    maxItems: 1

[Severity: Low]
The existing snps,dw-xpcs binding describes reg-names (direct/indirect)
and reg-io-width; neither appears here.  Is the intent that the compatible
alone implies a direct-mapped 2 MiB window with a fixed 4-byte stride?

That is what the driver assumes:

  drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_init_res() {
      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
      ...
      if (resource_size(res) < SZ_2M) {

  drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_read_reg() {
      ret = readl(pxpcs->reg_base + (csr << 2)) & 0xffff;

Would it help to state the 2 MiB size and the 4-byte register stride in
the description so the omission of reg-names and reg-io-width is clearly
deliberate?

> +  clocks:
> +    items:
> +      - description: APB3 bus interface clock (clk_csr_i), required for register access
> +      - description: EEE clock (clk_eee_i), required for Energy Efficient Ethernet operation
> +
> +  clock-names:
> +    items:
> +      - const: csr
> +      - const: eee

[Severity: Low]
The fixed [csr, eee] list differs from the names the generic XPCS code
looks up ("core" and "pad" in pcs-xpcs.c, "csr" in pcs-xpcs-plat.c).  Is
the exclusion of core/pad intentional here?

Both documented clocks are used by the Rockchip glue:

  drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_init_clk() {
      pxpcs->csr_clk = devm_clk_get(dev, "csr");
      ...
      pxpcs->eee_clk = devm_clk_get(dev, "eee");
      ...
      pxpcs->eee_mult_fact = DIV_ROUND_CLOSEST(100 * clk_get_rate(pxpcs->eee_clk),
                                               1000000000UL) - 1;

so the naming looks consistent with the implementation; a sentence in the
changelog noting that this integration does not use the core/pad clocks
would make the difference from snps,dw-xpcs obvious.

[ ... ]

> +patternProperties:
> +  "^ethernet-pcs-mii@[0-3]$":
> +    type: object
> +    description:
> +      One of the four MII ports of the XPCS. The port is linked to an
> +      Ethernet MAC controller via the pcs-handle property in the MAC's
> +      device tree node.

[Severity: Low]
This isn't a bug, but the changelog doesn't mention the two patches that
consume these child nodes, which makes the new ABI look unimplemented when
the binding patch is read on its own.

The consumers are:

  drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_create() {
      if (of_property_read_u32(np, "reg", &port))
              return ERR_PTR(-EINVAL);
      ...
      xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);

  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_pcs_init() {
      pcs_node = of_parse_phandle(np, "pcs-handle", 0);
      ...
      xpcs = xpcs_rk_create(priv->device, pcs_node);

Could the commit message reference them?

[ ... ]

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
> +
> +additionalProperties: false

[Severity: Low]
The RK3568 CRU defines four XPCS soft resets:

  include/dt-bindings/clock/rk3568-cru.h:
      #define SRST_XPCS               150
      #define SRST_XPCS_TX_DIV10      151
      #define SRST_XPCS_RX_DIV10      152
      #define SRST_XPCS_XGXS_RX       153

but the schema has no resets/reset-names, so a device tree cannot express
them.  Is that because bring-up relies only on the power domain, the
SerDes PHY and the XPCS register-level soft reset?

  drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_probe() {
      ret = dev_pm_genpd_rpm_always_on(dev, true);
      ...
      ret = phy_init(pxpcs->serdes_phy);
      ...
      ret = phy_power_on(pxpcs->serdes_phy);

A grep at the end of the series shows SRST_XPCS* matching only the
dt-bindings header, with no driver or DTS user, so this may well be
intentional; a note confirming the resets are left at their SoC defaults
would settle it.

Documenting them now as optional properties would also stay backwards
compatible if they turn out to be needed later.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
