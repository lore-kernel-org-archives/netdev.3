Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997D3CE48F;
	Sat, 12 Sep 2026 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244021; cv=none; b=SHUH7RpFvELsLPtLTThg9Tr9i0NvsFyex+zRT9y7wR+KKFzYpe2E3qMw+Zp3q0qXp2Y/VACuMf7cXKSMtVFNeBU9RhrR86W1HhUUI/vcmSoPsdn1F8zN5aagraNOgGwAGojs8wEwrDY0EyBHQq12JcGuBqZ1p3AsbTfWRyT9IGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244021; c=relaxed/simple;
	bh=J6kOxJJPFHZoXJxjaKq2UjJZD1zlpQR5DbQJMbFIKs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4JMUC9SnLehK6/kLvpW6LC73MU1BCae9Mg7dcm4Kj7QBE1FEmjhbpdqN1xyrt1kS8+S7v4zwiqwkgp6oUVPIe13i3JuQ9tt2uYeHk8r7UFpxVaY0z7KiGkFfwVaQDuUSHx0LnZj8d3TEmvlY3amfCWlKQXaw5mVGo2uA0UgBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaSSM90H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaSSM90H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13751F0089A;
	Sat, 12 Sep 2026 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244013;
	bh=I+13VNAMtbfGWdAp2t9CtnZz1iOetM/SVsqh/1Alnmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CaSSM90H1iqfHVJcq4ufihT3xNXDC6v0I17M5rAuwzqOlPRfPR2eb+U/BNcXLePB9
	 MYgYTEYbDoFnoEpf+lkjONoZk+x4JgFxsU1mgZkLOc9Jx3Kx4jHVLoJqxbObP7tE3M
	 copcTTej5DfnIHmo02HOJGRswBjjcRWBOGZ4St5898KPzLLrp9LI6eIDrLp8r5rm2H
	 8k2QYPNS3cOJp3fnPA/2wT7uFd+oW/xYoOab5cgqZOxfgRlEiY1KqN8F24FRc335cD
	 uQjUT+weaush7M2F0ifsoiY4LyV81L9Q0sd/u6kahrSGyAO1or8CEmZEQVDGskz8FA
	 GMLuqVnV5gZVw==
From: Jakub Kicinski <kuba@kernel.org>
To: coiaprant@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vkoul@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	romain.gantois@bootlin.com,
	hkallweit1@gmail.com,
	neil.armstrong@linaro.org,
	linux@armlinux.org.uk,
	shawn.lin@rock-chips.com,
	david@ixit.cz,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v4 09/10] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Sat, 12 Sep 2026 13:13:32 -0700
Message-ID: <20260912201332.127297-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907153713.2572547-11-coiaprant@gmail.com>
References: <20260907153713.2572547-11-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port

This enables the GMAC0 SGMII LAN port on the Ariaboard Photonicat by
adding the xpcs/xpcs_mii0 overrides, the combphy2 SGMII MAC selection, and
an mdio0 node with the YT8521SC PHY.  It also adds PHY LED descriptions on
both mdio0 and mdio1.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> index 58c1052ba8ef3..25caa44198843 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts

[ ... ]

> @@ -242,6 +243,7 @@ &combphy1 {
>  
>  &combphy2 {
>  	status = "okay";
> +	rockchip,sgmii-mac-sel = <0>;
>  };

[Severity: Low]
The changelog says:

  "Enable combphy2 with rockchip,sgmii-mac-sel = <0> to route the SGMII
   interface to GMAC0."

Is that description accurate?  In the baseline the node already reads:

  &combphy2 {
          status = "okay";
  };

so the only new thing here is the rockchip,sgmii-mac-sel property.  Could
the wording be adjusted to say the property is added to an already enabled
combphy2?

[Severity: Low]
This isn't a bug, but the new properties do not follow the ordering used by
the rest of this file, where properties come roughly alphabetically and
status is last.  Here rockchip,sgmii-mac-sel lands after status, in &gmac0
below pcs-handle comes before managed, and in the new &xpcs override status
is first with phys/phy-names after it.  Compare the existing &gmac1
override, which ends with status = "okay";.  Could these be reordered?

>  
>  &cpu0 {
> @@ -260,9 +262,18 @@ &cpu3 {
>  	cpu-supply = <&vdd_cpu>;
>  };
>  
> -/* Motorcomm YT8521SC LAN port (require SGMII) */
> +/* Motorcomm YT8521SC LAN port */
>  &gmac0 {
> -	status = "disabled";
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>;
> +	assigned-clock-parents = <&xpcs_gmac0_clk>;
> +	pcs-handle = <&xpcs_mii0>;
> +	managed = "in-band-status";
> +	phy-handle = <&sgmii_phy>;
> +	phy-mode = "sgmii";
> +	phy-supply = <&vcc_3v3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim>;
> +	status = "okay";
>  };

[ ... ]

> @@ -350,6 +391,25 @@ rgmii_phy: ethernet-phy@3 {
>  		reset-gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
>  		rx-internal-delay-ps = <1500>;
>  		tx-internal-delay-ps = <1500>;
> +
> +		leds {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			led@1 {
> +				reg = <1>;
> +				color = <LED_COLOR_ID_AMBER>;
> +				function = LED_FUNCTION_WAN;
> +				default-state = "keep";
> +			};
> +
> +			led@2 {
> +				reg = <2>;
> +				color = <LED_COLOR_ID_GREEN>;
> +				function = LED_FUNCTION_WAN;
> +				default-state = "keep";
> +			};
> +		};
>  	};
>  };

[Severity: Low]
This hunk describes the LEDs of the pre-existing RGMII WAN PHY on &mdio1,
which is already functional and unaffected by the SGMII enablement.  The
changelog justifies it only with:

  "Also add LED configuration for the existing RGMII PHY on mdio1 for
   consistency."

Would it be preferable to split this into its own patch, so this commit
contains only the SGMII LAN port enablement?

[ ... ]

> @@ -586,3 +646,13 @@ &xin32k {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&clk32k_out1>;
>  };
> +
> +&xpcs {
> +	status = "okay";
> +	phys = <&combphy2 PHY_TYPE_SGMII>;
> +	phy-names = "serdes";
> +};

[Severity: Medium]
Should phys/phy-names live in rk3568.dtsi rather than in each board file?

The binding lists them as required properties of the XPCS node:

  Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
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

but the SoC node in arch/arm64/boot/dts/rockchip/rk3568.dtsi has neither:

  xpcs: pcs@fda00000 {
          compatible = "rockchip,rk3568-xpcs";
          #address-cells = <1>;
          #size-cells = <0>;
          reg = <0x0 0xfda00000 0x0 0x200000>;
          clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
          clock-names = "csr", "eee";
          power-domains = <&power RK3568_PD_PIPE>;
          status = "disabled";

Does this mean every rk3568 dtb reports pcs@fda00000 as missing the required
phys and phy-names under make CHECK_DTBS=y, including boards that do not
enable the XPCS?

The XPCS to combphy2 connection is internal to the SoC, so each board that
enables it will have to repeat the same phandle, as this patch does.  Could
phys = <&combphy2 PHY_TYPE_SGMII>; and phy-names = "serdes"; be moved into
the dtsi node instead?

> +
> +&xpcs_mii0 {
> +	status = "okay";
> +};
