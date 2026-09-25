Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997B378D7B;
	Fri, 25 Sep 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301824; cv=none; b=elf5gcc1Bn4Stb1Lam1FbnpnQmm1NwJb3xD2H8t2ylhcbsQyQH1NHbY9XOE7cG1y6YrvuTXtxq6FFcN95Lmwbjf4xIG4ODQ3InVfzuNDQvgMBzmVrQ5p4isiW3g8Ve/Qr3vg13LghnaxCIaR6uLGcRKr6Z/JYQER1gVy8AI1bwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301824; c=relaxed/simple;
	bh=jbPlUfHarXKW7IgHmgHchup5uMQKI8caFK9hM7eovfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzSG8EEWx1Qun+NEasum3+g0ZggIxuWqTubp+DCCGeR1TT1Gf8SBE0kV/Mb5uLtOb/1FFKqldykDzWOqeSaXYdyFj0kkWNRDd/gQTcMG+Scm2kve2bAWBhYem0OaEJpcnJXcTXit+FIyK+rZ2D2S6gCfd8OS6daEMyXkn+FiRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNvmYH+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNvmYH+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37E51F000FF;
	Fri, 25 Sep 2026 02:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301821;
	bh=+3x17hI2eG4aqh5yipVDUNrlIY4rDva+XyGlofdKPB4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UNvmYH+jY5xeVCRN6cxxBNA58LNYdyQIh2GDLAzQubvq1h12MD/JDxJQ8oe6jAlNe
	 DQYpjbhQKa/ga2xVlW8h80QLDwKhzK5d+FFytAPu0JywsYUXMK0xphS7CyjAjXrwNM
	 tKCAJuLskPZb3WpNLq6117HRO4NcBKF95IUG8olvxbBrwKcjl0aABoyKR9M++hOGXc
	 hYW+L5HEVtsBz3taFmqIXrdi3GNMiMlZb3KhUCmMviFdXLyZnTM8h+/bLOLKaW+1oI
	 fHF9WAN7mceqRqFDSZzoHEr6peER7LrmQEmX9HCRy3c7ZqNv/ak9RlM95Juc9xOR1h
	 TSTU/m6mv9p5A==
Subject: Re: [PATCH net-next v10 05/11] arm64: dts: rockchip: rk3568: add XPCS
 and fixed-clock nodes
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
Date: Fri, 25 Sep 2026 02:03:39 +0000
Message-ID: <179030181943.2160803.8250149004228493490@kernel.org>
In-Reply-To: <20260922200336.2201212-6-coiaprant@gmail.com>
References: <20260922200336.2201212-6-coiaprant@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] DT/binding mismatch: the new `xpcs: ethernet-pcs@fda00000`
  node in arch/arm64/boot/dts/rockchip/rk3568.dtsi omits `phys` and…
- [Medium] The two new nodes `clk_gmac0_xpcs_mii: clock-xpcs-gmac0` and
  `clk_gmac1_xpcs_mii: clock-xpcs-gmac1`…
- [Low] Concern (retained per experiment protocol, judged INVALID): the
  claim that nothing in the tree consumes the DT description added here…

--

arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes

This adds an ethernet-pcs node at 0xfda00000 for the RK3568 XPCS, with four
ethernet-pcs-mii child nodes, all disabled by default.  It also adds two
125 MHz fixed-clock nodes whose clock-output-names are chosen to match the
CRU gmac RX/TX mux parent name strings so boards can reparent
SCLK_GMAC{0,1}_RX_TX.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 3bc653f027f1f..2cea108b31a4e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -8,6 +8,20 @@
>  / {
>  	compatible = "rockchip,rk3568";
>  
> +	clk_gmac0_xpcs_mii: clock-xpcs-gmac0 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clk_gmac0_xpcs_mii";
> +		#clock-cells = <0>;
> +	};
> +
> +	clk_gmac1_xpcs_mii: clock-xpcs-gmac1 {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clk_gmac1_xpcs_mii";
> +		#clock-cells = <0>;
> +	};

[Severity: Medium]

Is a root-level fixed-clock the right description for this clock?  As the
commit message says, the 125 MHz MII clock is generated inside the XPCS
from the Naneng combo SerDes, so it only exists once PD_PIPE is powered,
PCLK_XPCS is ungated and the SerDes has locked.  The CRU has
SRST_XPCS_TX_DIV10 / SRST_XPCS_RX_DIV10 / SRST_XPCS_XGXS_RX for that
divide-by-10 path, and pcs-xpcs-rk.c later in the series notes:

    /*
     * Accessing the XPCS registers also requires a TX clock from the
     * SerDes, which is needed for the soft reset.
     */

These two nodes carry no status, no gate, no power-domains and no relation
to the xpcs node that produces the clock.

Does that hide the dependency from the clock framework?  A board doing

    assigned-clocks = <&cru SCLK_GMAC0_RX_TX>;
    assigned-clock-parents = <&clk_gmac0_xpcs_mii>;

is reparented by of_clk_set_defaults() before the MAC driver's probe body
runs, and the reparent plus clk_get_rate() always succeed with 125 MHz even
when the xpcs node is disabled, PD_PIPE is off, or the SerDes PLL is not
locked.  Instead of -EPROBE_DEFER or an error, wouldn't the MAC just run
against a dead MII clock?  The phantom clock also stays "enabled" across
PD_PIPE power-down.

The other half of this is the coupling mechanism.  The only thing tying
these nodes to the CRU is the global clock name, matched by strcmp in
clk_fetch_parent_index() against the hard-coded strings in
drivers/clk/rockchip/clk-rk3568.c:

    PNAME(mux_gmac0_rx_tx_p)	= { "clk_gmac0_rgmii_speed", "clk_gmac0_rmii_speed", "clk_gmac0_xpcs_mii" };
    PNAME(mux_gmac1_rx_tx_p)	= { "clk_gmac1_rgmii_speed", "clk_gmac1_rmii_speed", "clk_gmac1_xpcs_mii" };

If the RK3568 CRU is later converted to parent_data/fw_name, or those
strings are renamed, board reparenting breaks silently with no build or
schema error.  Would it be preferable to have the real provider export this
clock, either the CRU leg or the xpcs node itself as a clock provider, so
the PD_PIPE / PCLK_XPCS / SerDes dependency is expressible?

[ ... ]

> @@ -110,6 +124,37 @@ sata0: sata@fc000000 {
>  		status = "disabled";
>  	};
>  
> +	xpcs: ethernet-pcs@fda00000 {
> +		compatible = "rockchip,rk3568-xpcs";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x0 0xfda00000 0x0 0x200000>;
> +		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> +		clock-names = "csr", "eee";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";

[Severity: Medium]

Does this node match the binding added earlier in the same series?
Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml lists
phys and phy-names unconditionally:

    required:
      - compatible
      - reg
      - "#address-cells"
      - "#size-cells"
      - clocks
      - clock-names
      - phys
      - phy-names
      - power-domains

and its example supplies:

    phys = <&combphy2 PHY_TYPE_SGMII>;
    phy-names = "serdes";

There is no if/then in that schema exempting disabled nodes, so wouldn't
make dtbs_check report "'phys' is a required property" and "'phy-names' is
a required property" for every rk3566/rk3568 DTB that includes
rk3568.dtsi?  At the end of the series only rk3568-photonicat.dts adds them
via a &xpcs override.

The commit message justification is:

    dtbs_check only validates required properties for enabled nodes, so the
    SoC dtsi does not provide phys/phy-names

Is that accurate?  dt-validate selects schemas by compatible and validates
the nodes present in the DTB; status = "disabled" controls whether the OS
binds a driver, not schema conformance.  The same file appears to
contradict the assumption, since the disabled sata0 node right above this
hunk does carry its combphy reference:

    sata0: sata@fc000000 {
        ...
        phys = <&combphy0 PHY_TYPE_SATA>;
        phy-names = "sata-phy";
        ...
        status = "disabled";
    };

The disabled pcie3x1/pcie3x2 nodes and the disabled USB/SATA nodes in
rk356x-base.dtsi do the same.

Separately from tooling, is the node a complete hardware description
without the SerDes phandle?  xpcs_rk_serdes_phy_init() in
drivers/net/pcs/pcs-xpcs-rk.c does:

    pxpcs->serdes_phy = devm_phy_get(dev, "serdes");
    if (IS_ERR(pxpcs->serdes_phy))
            return dev_err_probe(dev, PTR_ERR(pxpcs->serdes_phy), "Failed to get SerDes PHY\n");

so a board that only flips status to "okay" gets a probe failure.  Would it
make sense to settle this on one side, either dropping phys/phy-names from
the binding's required list, or giving the dtsi node a default SerDes
phandle that boards override?

[Severity: Low]

One note that turned out to be a non-issue, recorded for completeness: at
this commit alone nothing in the tree matches rockchip,rk3568-xpcs, consumes
the "eee" clock-name, or parses the ethernet-pcs-mii@N children.  That is
resolved by later patches in the same series, so there is nothing to change
here.  At the series tip, drivers/net/pcs/pcs-xpcs-rk.c has:

    static const struct of_device_id xpcs_rk_of_ids[] = {
            { .compatible = "rockchip,rk3568-xpcs" },
            { /* sentinel */ },
    };

xpcs_rk_init_clk() fetches both "csr" and "eee" and derives the EEE
multiplier from clk_get_rate() on the eee clock, xpcs_rk_create() reads the
ethernet-pcs-mii@N child's reg as the port number, and
rk3568-photonicat.dts wires pcs-handle = <&xpcs_mii0> into gmac0.

> +
> +		xpcs_mii0: ethernet-pcs-mii@0 {
> +			reg = <0>;
> +			status = "disabled";
> +		};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
