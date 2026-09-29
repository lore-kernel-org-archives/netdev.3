Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31709514751;
	Tue, 29 Sep 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698558; cv=none; b=QznAdq8F6KYj3mg8yqWrZn3tNPVGPuT293x7e4UHEyySl3afy5fQRypKKyTNibUkZP6UboKIC7eqqfn2XLUHk5Ns/BBjZOTM30cLo1A3pudWb7Vmynsbn07b/QwTyf2y8xJeblYCqD6hF/GCyC9nreeLIh2Sc187udd40ZiKB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698558; c=relaxed/simple;
	bh=aJ3xEMMqDXYrQRthmwU6vu9RbEl06GtbP/sY6yxmzao=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MgGWSz8d3zhW8sU59IAPaQB0TOkylPl/1/vB0XgvND9gYCoTePIA9/Jcj0jh+lZl9FBHruauJNjdVT3BXIIVTbbwJWrnNER3xj5KqF8IIUeS3GtxMoH/8UrzX2+BUCqY9ihGmqJphcIcJzC2QOdzHupn0iqnQ1+P+rx+VLJzBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BKnowrTQ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BKnowrTQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=AXgOmn9ba4LrxI+qIIii2prjx3jjVaTnKJjnhOZ2+vk=; b=BKnowrTQ9oulNBGfP0oIiZiaYk
	JDA46mE+z64i5iByuJKYYLV5W3i2VcXel9B32T63STfK2Smnek/gbgWQGRBTNOFACpPfy0AVzR1n0
	377WzcLbmlyZv3+axFgCyS6lcDN8pBzB5aw45eukH3tMkOk2dtnqHfuvUpNOdSPUOMag=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xBaUf-000000002Kp-3tIk;
	Tue, 29 Sep 2026 12:15:51 -0400
Date: Tue, 29 Sep 2026 12:15:49 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, pierluigi.p@variscite.com, Stefano
 Radaelli <stefano.r@variscite.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, Joseph Guo
 <qijian.guo@nxp.com>, Josua Mayer <josua@solid-run.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Mehmet Fide
 <mehmet.fide@screeningeagle.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Stefan Eichenberger <eichest@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v4 06/13] ARM: dts: imx6ul: Add Variscite SoM and DART
 base files
Message-Id: <20260929121549.05f677bd86c4c10991f09c4d@hugovil.com>
In-Reply-To: <150c7e64d34a12a4fb9cec1a5b2c805246590100.1790693249.git.stefano.r@variscite.com>
References: <cover.1790693249.git.stefano.r@variscite.com>
	<150c7e64d34a12a4fb9cec1a5b2c805246590100.1790693249.git.stefano.r@variscite.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Stefano,
the title is confusing to me. Does "Variscite SoM" refers to
VAR-SOM-6UL? And DART should be DART6UL?

And again, VAR-SOM-6UL support did exist before...


On Tue, 29 Sep 2026 17:17:33 +0200
Stefano Radaelli <stefano.radaelli21@gmail.com> wrote:

> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Add shared DTSI files for the VAR-SOM-6UL and DART-6UL modules and
> SoC-specific wrappers for i.MX6UL, i.MX6ULL and i.MX6ULZ.
> 
> Describe the touch and ADC reference supply as a fixed 3.3 V
> regulator on both modules so the ADC can report the correct scale.
> 
> Keep storage, audio and carrier options in separate DTSI files so
> board variants can include the hardware assembled on each board.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v2->v3:
>  - Constrain the fixed touch and ADC reference regulators to 3.3 V on
>    both modules so the ADC can report a valid scale.
> 
>  .../dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi  | 207 ++++++++++++++++++
>  .../dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi   | 203 +++++++++++++++++
>  .../arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi |  31 +++
>  arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi |  31 +--
>  .../boot/dts/nxp/imx/imx6ull-var-dart.dtsi    |  31 +++
>  .../arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi |  31 ++-
>  .../boot/dts/nxp/imx/imx6ulz-var-dart.dtsi    |  38 ++++
>  .../arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi |  38 ++++
>  8 files changed, 573 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
> new file mode 100644
> index 000000000000..f7190f6d50b5
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	/* ref_clk for micrel ethernet phy */
> +	rmii_ref_clk: clock-rmii-ref {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "rmii-ref";
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_gpio_dvfs: regulator-gpio-dvfs {
> +		compatible = "regulator-gpio";
> +		regulator-name = "gpio_dvfs";
> +		regulator-min-microvolt = <1300000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-type = "voltage";
> +		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
> +		states = <1300000 0x1
> +			  1400000 0x0>;
> +	};
> +
> +	touch_3v3_regulator: regulator-touch-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "touch_3v3_supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <786432000>;
> +};
> +
> +&cpu0 {
> +	arm-supply = <&reg_arm>;
> +	soc-supply = <&reg_soc>;
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>, <&pinctrl_enet1_mdio>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			clocks = <&rmii_ref_clk>;
> +			clock-names = "rmii-ref";
> +			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <100000>;
> +			micrel,rmii-reference-clock-select-25-mhz = <1>;
> +			micrel,led-mode = <1>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&pxp {
> +	status = "okay";
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +
> +&tsc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_tsc>;
> +	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
> +	measure-delay-time = <0xffff>;
> +	pre-charge-time = <0xfff>;
> +	status = "okay";
> +};
> +
> +/* Bluetooth UART */
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_enet1: enet1-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +		>;
> +	};
> +
> +	pinctrl_enet1_mdio: enet1-mdio-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
> +			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
> +			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2_gpio: i2c2-gpio-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30	0x1b0b0
> +			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_tsc: tsc-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
> +			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
> +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
> +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
> +			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
> new file mode 100644
> index 000000000000..cd93f618e907
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
> + */
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	/* ref_clk for micrel ethernet phy */
> +	rmii_ref_clk: clock-rmii-ref {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "rmii-ref";
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_gpio_dvfs: regulator-gpio-dvfs {
> +		compatible = "regulator-gpio";
> +		regulator-name = "gpio_dvfs";
> +		regulator-min-microvolt = <1300000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-type = "voltage";
> +		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
> +		states = <1300000 0x1
> +			  1400000 0x0>;
> +	};
> +
> +	touch_3v3_regulator: regulator-touch-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "touch_3v3_supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <786432000>;
> +};
> +
> +&cpu0 {
> +	arm-supply = <&reg_arm>;
> +	soc-supply = <&reg_soc>;
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>, <&pinctrl_enet1_mdio>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			clocks = <&rmii_ref_clk>;
> +			clock-names = "rmii-ref";
> +			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +			reset-deassert-us = <100000>;
> +			micrel,rmii-reference-clock-select-25-mhz = <1>;
> +			micrel,led-mode = <1>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio4 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio4 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&pxp {
> +	status = "okay";
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
> +&tsc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_tsc>;
> +	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
> +	measure-delay-time = <0xffff>;
> +	pre-charge-time = <0xfff>;
> +	status = "okay";
> +};
> +
> +/* Bluetooth UART */
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_enet1: enet1-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +		>;
> +	};
> +
> +	pinctrl_enet1_mdio: enet1-mdio-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
> +			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_HSYNC__I2C2_SCL		0x4001b8b0
> +			MX6UL_PAD_CSI_VSYNC__I2C2_SDA		0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2_gpio: i2c2-gpio-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_tsc: tsc-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
> +			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
> +			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
> +			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
> +			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
> new file mode 100644
> index 000000000000..83da4f9c5588
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Common dtsi for Variscite DART-6UL
> + *
> + * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/dart-6ul/
> + *
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
> + *
> + */
> +
> +#include "imx6ul-imx6ull-var-dart.dtsi"
> +
> +&adc1 {
> +	vref-supply = <&touch_3v3_regulator>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_enet1_gpio: enet1-gpio-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_wifi: wifi-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
> +			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
> index feea24c0e068..8e3c2d72811f 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
> @@ -2,37 +2,30 @@
>  /*
>   * Support for Variscite VAR-SOM-6UL Module
>   *
> - * Copyright 2019 Variscite Ltd.
> + * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/var-som-6ul/
> + *
>   * Copyright 2025 Bootlin
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
>   */
>  
> -/dts-v1/;
> -
> -#include "imx6ul.dtsi"
> -#include "imx6ul-var-som-common.dtsi"
> +#include "imx6ul-imx6ull-var-som.dtsi"
>  
> -/ {
> -	model = "Variscite VAR-SOM-6UL module";
> -	compatible = "variscite,var-som-imx6ul", "fsl,imx6ul";
> +&adc1 {
> +	vref-supply = <&touch_3v3_regulator>;
> +	status = "okay";
>  };
>  
>  &iomuxc {
> -	pinctrl_brcm_bt: brcm-bt-grp {
> -		fsl,pins = <
> -			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* BT_REG_ON (BT_EN) */
> -		>;
> -	};
> -
> -	pinctrl_brcm_wifi: brcm-wifi-grp {
> +	pinctrl_enet1_gpio: enet1-gpio-grp {
>  		fsl,pins = <
> -			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* WL_PWR (WIFI_PWR 5G) */
> -			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0	/* WL_REG_ON (WIFI_EN) */
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
>  		>;
>  	};
>  
> -	pinctrl_enet1_gpio: enet1-gpiogrp {
> +	pinctrl_wifi: wifi-grp {
>  		fsl,pins = <
> -			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* fec1 reset */
> +			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
> +			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
>  		>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
> new file mode 100644
> index 000000000000..bb8d392d8f54
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Common dtsi for Variscite DART-6ULL
> + *
> + * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/dart-6ul/
> + *
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
> + *
> + */
> +
> +#include "imx6ul-imx6ull-var-dart.dtsi"
> +
> +&adc1 {
> +	vref-supply = <&touch_3v3_regulator>;
> +	status = "okay";
> +};
> +
> +&iomuxc_snvs {
> +	pinctrl_enet1_gpio: enet1-gpio-grp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_wifi: wifi-grp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
> +			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi
> index f120b1dca75c..0341c181ed8e 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi
> @@ -2,35 +2,30 @@
>  /*
>   * Support for Variscite VAR-SOM-6UL module with imx6ull CPU
>   *
> - * Copyright 2019-2024 Variscite Ltd.
> + * https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/var-som-6ul/
> + *
>   * Copyright 2026 Dimonoff
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
>   */
>  
> -#include "imx6ull.dtsi"
> -#include "imx6ul-var-som-common.dtsi"
> +#include "imx6ul-imx6ull-var-som.dtsi"
>  
> -/ {
> -	model = "Variscite VAR-SOM-6UL module";
> -	compatible = "variscite,var-som-imx6ull", "fsl,imx6ull";
> +&adc1 {
> +	vref-supply = <&touch_3v3_regulator>;
> +	status = "okay";
>  };
>  
> -&iomuxc {
> -	pinctrl_brcm_bt: brcm-bt-grp {
> -		fsl,pins = <
> -			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* BT_REG_ON (BT_EN) */
> -		>;
> -	};
> -
> -	pinctrl_brcm_wifi: brcm-wifi-grp {
> +&iomuxc_snvs {
> +	pinctrl_enet1_gpio: enet1-gpio-grp {
>  		fsl,pins = <
> -			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* WL_PWR (WIFI_PWR 5G) */
> -			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0	/* WL_REG_ON (WIFI_EN) */
> +			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
>  		>;
>  	};
>  
> -	pinctrl_enet1_gpio: enet1-gpiogrp {
> +	pinctrl_wifi: wifi-grp {
>  		fsl,pins = <
> -			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* fec1 reset */
> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
> +			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
>  		>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
> new file mode 100644
> index 000000000000..a3fdfb92bb82
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Common dtsi for Variscite DART-6ULZ
> + *
> + * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/dart-6ul/
> + *
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
> + *
> + */
> +
> +#include "imx6ul-imx6ull-var-dart.dtsi"
> +
> +&fec1 {
> +	status = "disabled";
> +};
> +
> +&pxp {
> +	status = "disabled";
> +};
> +
> +&tsc {
> +	status = "disabled";
> +};
> +
> +&iomuxc_snvs {
> +	pinctrl_enet1_gpio: enet1-gpio-grp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_wifi: wifi-grp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
> +			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
> +		>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi
> new file mode 100644
> index 000000000000..f37607fb207a
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Common dtsi for Variscite VAR-SOM-6ULZ
> + *
> + * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/var-som-6ul/
> + *
> + * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
> + *
> + */
> +
> +#include "imx6ul-imx6ull-var-som.dtsi"
> +
> +&fec1 {
> +	status = "disabled";
> +};
> +
> +&pxp {
> +	status = "disabled";
> +};
> +
> +&tsc {
> +	status = "disabled";
> +};
> +
> +&iomuxc_snvs {
> +	pinctrl_enet1_gpio: enet1-gpio-grp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_wifi: wifi-grp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
> +			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
> +		>;
> +	};
> +};
> -- 
> 2.47.3


-- 
Hugo Villeneuve
