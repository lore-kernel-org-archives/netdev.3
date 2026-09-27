Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C523D3481
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790513208; cv=none; b=rra2IpGW7WYRuh7IjlWKUf6ntVkhVNEd/9BtZMmbl4Lt7kGwN4jCVEKfoiDh6oEA97qCRs35TKB+AqVy6UKNpCLo1mP/Kp/zi4JDC8BvyoeXNYow0711rYAb5kkPiFE7MCs2yUIk0PVET44YZNv6NIO5WONNMVbH+kHyuJPL20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790513208; c=relaxed/simple;
	bh=67zydm0Q0KzR374obII8YlARuJffsoipk8zAbRVyseg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiD32ds6sJff/bVjSLFS66hzhfg4/NNISOgRIzNNWqAz0++z0/0eFC0jxnoMeGG9bLlOjGUJlj9lmExVAznx36ryGWJ8Mv+SeNIbqNVsT81NLiAoCbQlRVbBc8oggepoaEYhywRJWSaEWc36ZoC/amM4q4q41TI+b5lq4peD/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPYfJkzl; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPYfJkzl"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffed768deso3530175e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790513200; x=1791118000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8d89tWgXYwUCIAoIbQ8mg9HLXq8Ydq7zeYQBsrGRvg=;
        b=jPYfJkzlU0+ZAj2arPF8aj15h0tGpwZaoPpKAvuHIdoH9mJRU4VhKhaIuqaTnK7VmE
         LhNm8uvRpTZkEpuQ8ymiSR3/Qy/iUAw1UOgqr/fEzBBEM898NdDeU6NNAAaI87onfDah
         wzXDS5q5lbTmLRoxC4RZQ1mQUVdaVKm7KeKEauhbADYIouklZRF5YYVh5GoLmY6yXKgl
         JVtuTVPH2/z0JbeB2QeZkmV5YzgSOehDvL4/Rj215H9RWOcRSjAiHWDHWY4ipZHli/DK
         3oCQl+sx35xVuPQtf2QSXPPiHzgLjprssAmO5VJgVsd/UqxbzfjXgpaUdt4T1OlMS/z0
         SSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790513200; x=1791118000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8d89tWgXYwUCIAoIbQ8mg9HLXq8Ydq7zeYQBsrGRvg=;
        b=yX+O1+plMbJrRFJK8woD6jYOxvlXKYfK8dHpcTTYd5YcNVjYki/CuyTiCDbHaeu012
         vuHEjfP8gA+z4FS35urZn6zL7yFo4Afj+m2LOL1XOecz9rME0l562i4hwIG9ijJdRaec
         Mh0VYRLlF2IgfMraD5rE5a86nSsiqXCrPwd9LOGyKrD2JELEZHjjb6jt0xOEMy9PPkrd
         G9bxE7bJ4kz3N7Pz/c9uGmJ7r/erwmQCgj8+qDqTRufixwfygHpv8zOhGdPv0yfA4Cf3
         Yo4E0oilFuIMm90gRWDk/PzR4MwQJeizQxWzRBcWs/NlPgp6Uaa6sKjyGQ3IMHO1B9Y4
         2WJw==
X-Forwarded-Encrypted: i=1; AKwUvBxxNNAGElakf9yZUIyGWMHHY6T+83W0Obi3+GslbfPsopnPjUUv/zWmbxa/rOT4mZCvNI6XJKs=@vger.kernel.org
X-Gm-Message-State: AFuF++nkBJvwHFFuJPZeYl8VlrUBsETvk1B2EZu7qVYI4uMrR019jkC2
	cslQ/VMgR4tPz6HG1iAuVHaaxOTRiN2DxdltyWo2Pi1rK3EdJ8SqZbWX
X-Gm-Gg: AYBFou2R5oroQYb7jFnNBP2j1VHeGwE7fNpd15PAhqnoPCEaEluqz3pi0HsWQjziUBO
	qxAmLvSobUISoxw0LJb0GsXoZ8wJS1eGkdYQH8gGkwRF+TBuFleJeTX7kyBF3VTSfYiU0Wrk2Xd
	heTVh3+SKlNZhORonaLaFoNI698I7ERDFAEi/pbARHXjaH0fsOkbaKrucNN48agp7oMfujXzcif
	D5KweXvM39qfP/GJg6myeonBA8LfR3j15NSHigyZWkufCIjMl462SuJ90sLpcpCwhbcIXsjgoOf
	CXSGyWSGQH64Yp3DxXxOL/n1aN+naeetpEa5p9RKs4yazMWc3JQ9RKvmuPGBuZJOwV3MhLhuS8q
	SrCI9wS5nvRk0vTSsFDOysIU5ws9ZFHZU5Wd1rYyjYYWy2sLt118HVTOyMXz3wO28sc9XXcbaOs
	mjKPGlciEnYpn0EQgFCQYIY0/TTz3YOuXNdrMGDDFAtUqLSNY+N5a8pHrGK74p0TmHhu0fI1BCw
	dWzmSmwK/IBlSj3DHXvDlKMLJacBJYZ1SZh5M6rGNG8Uo1B0ce3tnF6iITTmnOS3gZswmQKlNdj
	OAVZMRNckzUbP+8XbZbauQ==
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fe66ca6f5mr199795615e9.0.1790513199847;
        Sun, 27 Sep 2026 05:46:39 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm148440605e9.4.2026.09.27.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 05:46:39 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 04/12] ARM: dts: imx6ul: Add Variscite SoM and DART base files
Date: Sun, 27 Sep 2026 14:46:19 +0200
Message-ID: <113cc7361186943effcbcfe88913c6f528a54db6.1790512621.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790512621.git.stefano.r@variscite.com>
References: <cover.1790512621.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Add shared DTSI files for the VAR-SOM-6UL and DART-6UL modules and
SoC-specific wrappers for i.MX6UL, i.MX6ULL and i.MX6ULZ.

Describe the touch and ADC reference supply as a fixed 3.3 V
regulator on both modules so the ADC can report the correct scale.

Keep storage, audio and carrier options in separate DTSI files so
board variants can include the hardware assembled on each board.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v2->v3:
 - Constrain the fixed touch and ADC reference regulators to 3.3 V on
   both modules so the ADC can report a valid scale.

 .../dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi  | 207 ++++++++++++++++++
 .../dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi   | 203 +++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi |  31 +++
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi |  31 +--
 .../boot/dts/nxp/imx/imx6ull-var-dart.dtsi    |  31 +++
 .../arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi |  31 ++-
 .../boot/dts/nxp/imx/imx6ulz-var-dart.dtsi    |  38 ++++
 .../arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi |  38 ++++
 8 files changed, 573 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
new file mode 100644
index 000000000000..f7190f6d50b5
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart.dtsi
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	/* ref_clk for micrel ethernet phy */
+	rmii_ref_clk: clock-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "rmii-ref";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_gpio_dvfs: regulator-gpio-dvfs {
+		compatible = "regulator-gpio";
+		regulator-name = "gpio_dvfs";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-type = "voltage";
+		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		states = <1300000 0x1
+			  1400000 0x0>;
+	};
+
+	touch_3v3_regulator: regulator-touch-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_3v3_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
+};
+
+&cpu0 {
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>, <&pinctrl_enet1_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <100000>;
+			micrel,rmii-reference-clock-select-25-mhz = <1>;
+			micrel,led-mode = <1>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&pxp {
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure-delay-time = <0xffff>;
+	pre-charge-time = <0xfff>;
+	status = "okay";
+};
+
+/* Bluetooth UART */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet1: enet1-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet1_mdio: enet1-mdio-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30	0x1b0b0
+			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31	0x1b0b0
+		>;
+	};
+
+	pinctrl_tsc: tsc-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
+		>;
+	};
+
+	pinctrl_uart2: uart2-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
new file mode 100644
index 000000000000..cd93f618e907
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som.dtsi
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	/* ref_clk for micrel ethernet phy */
+	rmii_ref_clk: clock-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "rmii-ref";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reg_gpio_dvfs: regulator-gpio-dvfs {
+		compatible = "regulator-gpio";
+		regulator-name = "gpio_dvfs";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-type = "voltage";
+		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		states = <1300000 0x1
+			  1400000 0x0>;
+	};
+
+	touch_3v3_regulator: regulator-touch-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_3v3_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
+};
+
+&cpu0 {
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>, <&pinctrl_enet1_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <100000>;
+			micrel,rmii-reference-clock-select-25-mhz = <1>;
+			micrel,led-mode = <1>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio4 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio4 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&pxp {
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure-delay-time = <0xffff>;
+	pre-charge-time = <0xfff>;
+	status = "okay";
+};
+
+/* Bluetooth UART */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet1: enet1-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet1_mdio: enet1-mdio-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__I2C2_SCL		0x4001b8b0
+			MX6UL_PAD_CSI_VSYNC__I2C2_SDA		0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b0
+		>;
+	};
+
+	pinctrl_tsc: tsc-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
+		>;
+	};
+
+	pinctrl_uart2: uart2-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
new file mode 100644
index 000000000000..83da4f9c5588
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common dtsi for Variscite DART-6UL
+ *
+ * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/dart-6ul/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
+ *
+ */
+
+#include "imx6ul-imx6ull-var-dart.dtsi"
+
+&adc1 {
+	vref-supply = <&touch_3v3_regulator>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet1_gpio: enet1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_wifi: wifi-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
index feea24c0e068..8e3c2d72811f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi
@@ -2,37 +2,30 @@
 /*
  * Support for Variscite VAR-SOM-6UL Module
  *
- * Copyright 2019 Variscite Ltd.
+ * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/var-som-6ul/
+ *
  * Copyright 2025 Bootlin
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
  */
 
-/dts-v1/;
-
-#include "imx6ul.dtsi"
-#include "imx6ul-var-som-common.dtsi"
+#include "imx6ul-imx6ull-var-som.dtsi"
 
-/ {
-	model = "Variscite VAR-SOM-6UL module";
-	compatible = "variscite,var-som-imx6ul", "fsl,imx6ul";
+&adc1 {
+	vref-supply = <&touch_3v3_regulator>;
+	status = "okay";
 };
 
 &iomuxc {
-	pinctrl_brcm_bt: brcm-bt-grp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* BT_REG_ON (BT_EN) */
-		>;
-	};
-
-	pinctrl_brcm_wifi: brcm-wifi-grp {
+	pinctrl_enet1_gpio: enet1-gpio-grp {
 		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* WL_PWR (WIFI_PWR 5G) */
-			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0	/* WL_REG_ON (WIFI_EN) */
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
 		>;
 	};
 
-	pinctrl_enet1_gpio: enet1-gpiogrp {
+	pinctrl_wifi: wifi-grp {
 		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* fec1 reset */
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
new file mode 100644
index 000000000000..bb8d392d8f54
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common dtsi for Variscite DART-6ULL
+ *
+ * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/dart-6ul/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
+ *
+ */
+
+#include "imx6ul-imx6ull-var-dart.dtsi"
+
+&adc1 {
+	vref-supply = <&touch_3v3_regulator>;
+	status = "okay";
+};
+
+&iomuxc_snvs {
+	pinctrl_enet1_gpio: enet1-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_wifi: wifi-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi
index f120b1dca75c..0341c181ed8e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som.dtsi
@@ -2,35 +2,30 @@
 /*
  * Support for Variscite VAR-SOM-6UL module with imx6ull CPU
  *
- * Copyright 2019-2024 Variscite Ltd.
+ * https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/var-som-6ul/
+ *
  * Copyright 2026 Dimonoff
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
  */
 
-#include "imx6ull.dtsi"
-#include "imx6ul-var-som-common.dtsi"
+#include "imx6ul-imx6ull-var-som.dtsi"
 
-/ {
-	model = "Variscite VAR-SOM-6UL module";
-	compatible = "variscite,var-som-imx6ull", "fsl,imx6ull";
+&adc1 {
+	vref-supply = <&touch_3v3_regulator>;
+	status = "okay";
 };
 
-&iomuxc {
-	pinctrl_brcm_bt: brcm-bt-grp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* BT_REG_ON (BT_EN) */
-		>;
-	};
-
-	pinctrl_brcm_wifi: brcm-wifi-grp {
+&iomuxc_snvs {
+	pinctrl_enet1_gpio: enet1-gpio-grp {
 		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* WL_PWR (WIFI_PWR 5G) */
-			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0	/* WL_REG_ON (WIFI_EN) */
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
 		>;
 	};
 
-	pinctrl_enet1_gpio: enet1-gpiogrp {
+	pinctrl_wifi: wifi-grp {
 		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* fec1 reset */
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
new file mode 100644
index 000000000000..a3fdfb92bb82
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common dtsi for Variscite DART-6ULZ
+ *
+ * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/dart-6ul/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
+ *
+ */
+
+#include "imx6ul-imx6ull-var-dart.dtsi"
+
+&fec1 {
+	status = "disabled";
+};
+
+&pxp {
+	status = "disabled";
+};
+
+&tsc {
+	status = "disabled";
+};
+
+&iomuxc_snvs {
+	pinctrl_enet1_gpio: enet1-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_wifi: wifi-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi
new file mode 100644
index 000000000000..f37607fb207a
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Common dtsi for Variscite VAR-SOM-6ULZ
+ *
+ * Link: https://variscite.com/system-on-module-som/i-mx-6/i-mx-6ul/var-som-6ul/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com/
+ *
+ */
+
+#include "imx6ul-imx6ull-var-som.dtsi"
+
+&fec1 {
+	status = "disabled";
+};
+
+&pxp {
+	status = "disabled";
+};
+
+&tsc {
+	status = "disabled";
+};
+
+&iomuxc_snvs {
+	pinctrl_enet1_gpio: enet1-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0
+		>;
+	};
+
+	pinctrl_wifi: wifi-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x03029
+		>;
+	};
+};
-- 
2.47.3
