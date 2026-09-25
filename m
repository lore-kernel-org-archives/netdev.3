Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAA4A4850
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345022; cv=none; b=m41PKhsKCgjLzQ3lG9lAKYcmLcfElX2N9U07jWCXgmB4cQPvoPGl+72ZSCQM8ZioNqxbRlCb2/ENqDF+xSQNA0wC0ZwBgAMrv4M6omE+ameUcSu8j8hcr+A8LR3Mk7HaWGT5EonFNtnzsoxAhlXWRvHCLYb5/nhh4AVnlawt/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345022; c=relaxed/simple;
	bh=b2BexNpbWlzWY+oKFi+Ndwtz4ibH3bDA7y2cw1FQ38I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETKAJtWVc81lTd3kCSI7gKomof+6Pod4s7mW380jYnNP1T0JhmcvqumilMjZHg4U3UFxgUz5L6w8Mvb5hyk4bpJyY30hESbqFIak1VsG9PBSrUe8HiH1zAeyNs3s3tpQcMNsvKgaRYl5LWlMiR5fSm1hBeBMaON8dPSMbfxBcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTGtX+Yq; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTGtX+Yq"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso6532395e9.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790345014; x=1790949814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJteatqAHIpdjs7mhmpRi/bW8E8PvXc5C9Wf8JAX6nI=;
        b=DTGtX+YqjN60QZ0nW9jAYSdmtU0ACafNM1gClmdDafpA95WhS4GxS/+IL7BnRL02JA
         GcX5qOQL2L4xcO7Hs7agNPV+DR2K+p3EVkechXJxXyAlH9PnFCQ4qkAcPp+U/DhyPeeB
         dnz4KCukmXV3mJ1Jcx+8gb0h6kvz2ahjx8KZHfcmkaBYHqRJ+9EY6HNS6QewWg56q4vC
         P5Q7lu0HvSoJuNJdd3dhf9ikmWzK0ZgLOIBT8t7ctC3J+ZGfJ///dFzvlRPhWLuJ8YGe
         NmSihsfyoBdvbMAj57/VCne6MnTcVJ4pzzNLQgtkXN0bBi7jf/ofBoLRL5+nt8C3yJ6/
         A0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345014; x=1790949814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJteatqAHIpdjs7mhmpRi/bW8E8PvXc5C9Wf8JAX6nI=;
        b=f8lo/RP5jU5uVJJmabBWBiVZ9sy+gTFMs39wZYVJsKvBBIXRYb9Av1QaFMgGunvDtE
         By+JKxCrPEKbAdelX5BHQ1IchC+R5EE0yKTIuSjC8GPaJnwRteQGOBsKkQOREjH26Nfm
         Y5VdTsVN18dAjyYf6iVbijc8ByZ/Ouj3t7gWpM+Cra889X4ENKw2SckwiJXHlEx/Hr+s
         rDOVBInJ5FvkemcyvYi6D/ii6L+ao3yCGb+hPhvyaKrba2P9hQnN3mQUEtO/ag88cBvW
         KEqzGNVG4QH+Od/krb/LC8ZDPD+7xWtvC1zhzu8cf7NI7leAgqCxh856moNSKiYAMSAP
         d4tA==
X-Forwarded-Encrypted: i=1; AKwUvBw0yfEYhAHTJs9jafZ8qW4CdKp/ot/7RwGtYXxDTbS0RDWx/AsyJpbld+9VtXKGp+W/uNha8QI=@vger.kernel.org
X-Gm-Message-State: AFuF++ktVz/oJOM1zi/fAI/7UzhFlz7Ae1l5f/XY517v9kQjKSJO3uFn
	cLfC16YiSG70Dz9o2zb+6tERBCOs2dEcYTJK/E6nFVyvxm7X3opBGP95
X-Gm-Gg: AYBFou39XNWVweb+aXDz0Vhng8Ot4qa/a1nD4jajxThw5/9sl0zGn42LoAAP08bfKGs
	NmNfts1C44c5WHUc1UnxIdnMb2KQwjPz509I7aUYbNMs89f4b0OmHxnHAvRBNbQ2tUOQGuahGbo
	bJeFqT4J90T/JpMypTM6Cy9DZ5pwa9P7TyKd3R2FLIR3lYEE2lhsA11tEAgEDSio1dfpqw7r5vS
	zmt0+jNQ4CMvfz1b7PlpuGgWW7kJkq3sIIIs6YCYKZHXhFMyplrKCNP5fEFXlyYsAa+T+7NquQl
	XBCMF+tjo2qVjgyBXxCowK7OPIGDtmUOFhKlOw+KXcOBU02VD6Ibxirl60yIUB4OQcFxS+7sqnH
	YA2MfLEUdh1OcLwWaQ0vcltUzk0zOiUR4oqPN7+RIeGI5sblI6IrmjZNBpnHx528r2KG9zgiH9u
	GU9h/Etw9r3ekjBlIihUOAg4VTh8mKzQjlhGOm96xZDokzPNQffo2vgDoa0UmJN+29MEO0TmiUi
	q5IjpqnmFtgfpjaUi3TpENOJIxZnsyNB+9yqXMYDdHHDeJWKlJbP6KfmW6eOndduD9G1gwxYZbz
	mRodlr4uY+dkNI64B7Ox4Q==
X-Received: by 2002:a05:600c:354a:b0:49f:bd3c:bc1d with SMTP id 5b1f17b1804b1-49fe66fd425mr96579845e9.24.1790345013975;
        Fri, 25 Sep 2026 07:03:33 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7522431f8f.19.2026.09.25.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:03:33 -0700 (PDT)
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
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 06/11] ARM: dts: imx6ul: Add Variscite carrier board files
Date: Fri, 25 Sep 2026 16:02:23 +0200
Message-ID: <cb4e36a01f0e6dbbcebe86fff78686934dd845c6.1790344389.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790344389.git.stefano.r@variscite.com>
References: <cover.1790344389.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Add DTSI files for the Concerto-Board, Symphony-Board and
VAR-6ULCustomBoard carriers used with VAR-SOM-6UL and DART-6UL.

Share common carrier wiring across the SoC variants and keep the
SoC-specific connections in separate wrapper files.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 ...x6ull-var-dart-6ulcustomboard-sd-card.dtsi |  31 ++
 ...mx6ul-imx6ull-var-dart-6ulcustomboard.dtsi | 321 ++++++++++++++++
 ...mx6ull-var-som-concerto-board-sd-card.dtsi |  42 +++
 ...imx6ul-imx6ull-var-som-concerto-board.dtsi | 350 ++++++++++++++++++
 ...imx6ul-imx6ull-var-som-symphony-board.dtsi | 317 ++++++++++++++++
 .../imx/imx6ul-var-dart-6ulcustomboard.dtsi   |  18 +
 .../imx/imx6ul-var-som-concerto-board.dtsi    |  38 ++
 .../imx/imx6ul-var-som-symphony-board.dtsi    |  88 +++++
 .../imx/imx6ull-var-dart-6ulcustomboard.dtsi  |  18 +
 .../imx/imx6ull-var-som-concerto-board.dtsi   |  38 ++
 .../imx/imx6ull-var-som-symphony-board.dtsi   |  88 +++++
 .../imx/imx6ulz-var-dart-6ulcustomboard.dtsi  |  24 ++
 .../imx/imx6ulz-var-som-concerto-board.dtsi   |  44 +++
 .../imx/imx6ulz-var-som-symphony-board.dtsi   |  24 ++
 14 files changed, 1441 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-concerto-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi
new file mode 100644
index 000000000000..f6cec58f5a4e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_usdhc1_gpio: usdhc1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
new file mode 100644
index 000000000000..f7bfaaf91700
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 20000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		key-user {
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-d16 {
+			gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>;
+	/delete-node/ mdio;
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>, <&pinctrl_enet2_gpio>, <&pinctrl_enet2_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
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
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <100000>;
+			micrel,rmii-reference-clock-select-25-mhz = <1>;
+			micrel,led-mode = <1>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c2 {
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ft5x06_ts_gpio>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <4 0>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	/* DS1337 RTC module */
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display0 {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <35000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <40>;
+				hsync-len = <48>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+/* Console UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* ttymxc2 UART */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&iomuxc {
+	pinctrl_enet2: enet2-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+		>;
+	};
+
+	pinctrl_enet2_gpio: enet2-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0
+		>;
+	};
+
+	pinctrl_enet2_mdio: enet2-mdio-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
+			MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
+		>;
+	};
+
+	pinctrl_ft5x06_ts_gpio: ft5x06-ts-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_RESET__GPIO3_IO04		0x80000000
+		>;
+	};
+
+	pinctrl_gpio_keys: gpio-keys-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x17059
+		>;
+	};
+
+	pinctrl_gpio_leds: gpio-leds-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__GPIO1_IO28	0x1b0b0
+			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29	0x1b0b0
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdif-dat-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+		>;
+	};
+
+	pinctrl_pwm1: pwm1-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_uart1: uart1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX   0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX   0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_wdog: wdog-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO08__WDOG1_WDOG_B	0x78b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi
new file mode 100644
index 000000000000..a6a3f417ca5e
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	wakeup-source;
+	status = "okay";
+};
+
+&iomuxc {
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
+	pinctrl_usdhc1_gpio: usdhc1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x1b0b1 /* CD */
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board.dtsi
new file mode 100644
index 000000000000..a7c03f89e14d
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-concerto-board.dtsi
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>, <&pinctrl_gpio_keys_snvs>;
+
+		key-back {
+			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		key-wakeup {
+			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
+	lcd_backlight: lcd-backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 20000 0>;
+		pwm-names = "LCD_BKLT_PWM";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			label = "gpled2";
+			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&fec1 {
+	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>;
+	/delete-node/ mdio;
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>, <&pinctrl_enet2_gpio>, <&pinctrl_enet2_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
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
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <100000>;
+			micrel,rmii-reference-clock-select-25-mhz = <1>;
+			micrel,led-mode = <0>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio4 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio4 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ft5x06_ts_gpio>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <9 0>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		wakeup-source;
+	};
+
+	/* DS1337 RTC module */
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		/*
+		 * To actually use this interrupt
+		 * connect pins J14.8 & J14.10 on the Concerto-Board
+		 */
+		interrupt-parent = <&gpio1>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display0 {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency =<35000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <40>;
+				hsync-len = <48>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "disabled";
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&tsc {
+	/*
+	 * Conflicts with wdog1 ext-reset-output & SD CD pins,
+	 * so we keep it disabled by default
+	 */
+	status = "disabled";
+};
+
+/* Console UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	dr_mode = "otg";
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	/*
+	 * To actually use ext-reset-output
+	 * connect pins J17.3 & J17.8 on the Concerto-Board
+	 */
+	fsl,ext-reset-output;
+};
+
+&iomuxc {
+	pinctrl_enet2: enet2-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+		>;
+	};
+
+	pinctrl_enet2_mdio: enet2-mdio-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
+		>;
+	};
+
+	pinctrl_gpio_keys: gpio-keys-grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x17059 /* Back */
+		>;
+	};
+
+	pinctrl_gpio_leds: gpio-leds-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x1b0b0	/* GPLED2 */
+		>;
+	};
+
+	pinctrl_i2c1: i2c1-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18	0x1b0b0
+			MX6UL_PAD_CSI_MCLK__GPIO4_IO17		0x1b0b0
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdif-dat-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+		>;
+	};
+
+	pinctrl_pwm4: pwm4-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__PWM4_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_rtc: rtc-grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0 /* RTC alarm IRQ */
+		>;
+	};
+
+	pinctrl_uart1: uart1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA00__UART5_DCE_TX	0x1b0b1
+			MX6UL_PAD_CSI_DATA01__UART5_DCE_RX	0x1b0b1
+			MX6UL_PAD_GPIO1_IO09__UART5_DCE_CTS	0x1b0b1
+			MX6UL_PAD_GPIO1_IO08__UART5_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usb-otg1-id-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__ANATOP_OTG1_ID	0x17059
+		>;
+	};
+
+	pinctrl_wdog: wdog-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__WDOG1_WDOG_B	0x78b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..070011d37205
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 20000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-back {
+			label = "Back";
+			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		key-home {
+			label = "Home";
+			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+		};
+
+		key-menu {
+			label = "Menu";
+			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-heartbeat {
+			label = "heartbeat";
+			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio4 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio4 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	/* GPIO expander */
+	pca9534: gpio@20 {
+		compatible = "nxp,pca9534";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9534>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	/* USB Type-C Controller */
+	extcon_ptn5150: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_extcon>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <3 IRQ_TYPE_NONE>;
+
+		port {
+			typec1_dr_sw: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display0 {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <35000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <40>;
+				hsync-len = <48>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "disabled";
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&tsc {
+	/*
+	 * Conflicts with wdog1 ext-reset-output & SD CD pins,
+	 * so we keep it disabled by default
+	 */
+	status = "disabled";
+};
+
+/* Console UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_ft5x06_ts_gpio: ft5x06-ts-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA01__GPIO3_IO06	0x80000000
+		>;
+	};
+
+	pinctrl_ecspi4: ecspi4-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_TX_DATA1__ECSPI4_SCLK	0x100b1
+			MX6UL_PAD_ENET2_TX_EN__ECSPI4_MOSI	0x100b1
+			MX6UL_PAD_ENET2_TX_CLK__ECSPI4_MISO	0x100b1
+		>;
+	};
+
+	pinctrl_ecspi4_cs: ecspi4-cs-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x100b1
+		>;
+	};
+
+	pinctrl_extcon: extcon-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03		0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
+			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
+		>;
+	};
+
+	pinctrl_i2c1: i2c1-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18	0x1b0b0
+			MX6UL_PAD_CSI_MCLK__GPIO4_IO17		0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c3: i2c3-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_DATA0__I2C3_SCL	0x4001b8b0
+			MX6UL_PAD_ENET2_RX_DATA1__I2C3_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c4: i2c4-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__I2C4_SCL		0x4001b8b0
+			MX6UL_PAD_ENET2_TX_DATA0__I2C4_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11	0x1b0b0
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+		>;
+	};
+
+	pinctrl_lcdif_dat: lcdif-dat-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+		>;
+	};
+
+	pinctrl_pwm4: pwm4-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__PWM4_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_uart1: uart1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart7: uart7-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA16__UART7_DCE_TX	0x1b0b1
+			MX6UL_PAD_LCD_DATA17__UART7_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usb_otg1_id: usb-otg1-id-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__ANATOP_OTG1_ID	0x17059
+		>;
+	};
+
+	pinctrl_pca9534: pca9534-grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-6ulcustomboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-6ulcustomboard.dtsi
new file mode 100644
index 000000000000..142ffd381e69
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-6ulcustomboard.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Variscite VAR-6ULCustomBoard for DART-6UL
+ *
+ * Link: https://variscite.com/carrier-boards/var-6ulcustomboard/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi"
+
+&iomuxc {
+	pinctrl_rtc: rtc-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi
new file mode 100644
index 000000000000..d321f4d786dd
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Variscite Concerto carrier board for VAR-SOM-6UL
+ *
+ * Link: https://variscite.com/carrier-boards/concerto-board/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-concerto-board.dtsi"
+
+/* ttymxc4 UART */
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet2_gpio: enet2-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0
+		>;
+	};
+
+	pinctrl_ft5x06_ts_gpio: ft5x06-ts-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x80000000
+		>;
+	};
+
+	pinctrl_gpio_keys_snvs: gpio-keys-snvs-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..cfed9c7b6c6b
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Variscite Symphony carrier board for VAR-SOM-6UL
+ *
+ * Link: https://variscite.com/carrier-boards/symphony-board/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-symphony-board.dtsi"
+
+&ecspi4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4 &pinctrl_ecspi4_cs>;
+	cs-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio2 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	/* GPIO Expander */
+	pcal6408: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/* RGB_SEL*/
+		lvds-brg-enable-hog {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "lvds_brg_en";
+		};
+	};
+
+	/* TPM */
+	st33ktpm2xi2c: tpm@2e {
+		compatible = "st,st33ktpm2xi2c", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		reset-gpios = <&pcal6408 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ft5x06_ts_gpio>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <6 0>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	/* DS1337 RTC module */
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio2 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 11 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+/* ttymxc6 UART */
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-6ulcustomboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-6ulcustomboard.dtsi
new file mode 100644
index 000000000000..bc975ffaf372
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-dart-6ulcustomboard.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Variscite VAR-6ULCustomBoard for DART-6ULL
+ *
+ * Link: https://variscite.com/carrier-boards/var-6ulcustomboard/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi"
+
+&iomuxc_snvs {
+	pinctrl_rtc: rtc-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-board.dtsi
new file mode 100644
index 000000000000..b7b8f46e0655
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-board.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Variscite Concerto carrier board for VAR-SOM-6ULL
+ *
+ * Link: https://variscite.com/carrier-boards/concerto-board/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-concerto-board.dtsi"
+
+/* ttymxc4 UART */
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc_snvs {
+	pinctrl_enet2_gpio: enet2-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0
+		>;
+	};
+
+	pinctrl_ft5x06_ts_gpio: ft5x06-ts-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x80000000
+		>;
+	};
+
+	pinctrl_gpio_keys_snvs: gpio-keys-snvs-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..229f3bd1025b
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Variscite Symphony carrier board for VAR-SOM-6ULL
+ *
+ * Link: https://variscite.com/carrier-boards/symphony-board/
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-symphony-board.dtsi"
+
+&ecspi4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi4 &pinctrl_ecspi4_cs>;
+	cs-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio2 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	/* GPIO Expander */
+	pcal6408: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/* RGB_SEL*/
+		lvds-brg-enable-hog {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "lvds_brg_en";
+		};
+	};
+
+	/* TPM */
+	st33ktpm2xi2c: tpm@2e {
+		compatible = "st,st33ktpm2xi2c", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		reset-gpios = <&pcal6408 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ft5x06_ts_gpio>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <6 0>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	/* DS1337 RTC module */
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio2 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 11 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+/* ttymxc6 UART */
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-6ulcustomboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-6ulcustomboard.dtsi
new file mode 100644
index 000000000000..a421888663a5
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-6ulcustomboard.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
+
+/ {
+	backlight {
+		status = "disabled";
+	};
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&fec2 {
+	status = "disabled";
+};
+
+&lcdif {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-concerto-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-concerto-board.dtsi
new file mode 100644
index 000000000000..377715fb4d78
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-concerto-board.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-concerto-board.dtsi"
+
+/ {
+	backlight {
+		status = "disabled";
+	};
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&fec2 {
+	status = "disabled";
+};
+
+&lcdif {
+	status = "disabled";
+};
+
+&iomuxc_snvs {
+	pinctrl_enet2_gpio: enet2-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0
+		>;
+	};
+
+	pinctrl_ft5x06_ts_gpio: ft5x06-ts-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x80000000
+		>;
+	};
+
+	pinctrl_gpio_keys_snvs: gpio-keys-snvs-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..8d75f19483a2
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-symphony-board.dtsi"
+
+/ {
+	backlight {
+		status = "disabled";
+	};
+};
+
+&can1 {
+	status = "disabled";
+};
+
+&fec2 {
+	status = "disabled";
+};
+
+&lcdif {
+	status = "disabled";
+};
-- 
2.47.3

