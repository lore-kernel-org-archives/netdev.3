Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6B4F7CD6
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488451; cv=none; b=fXha3iGX5DSvV9mCNgG/zE5HesmNNZpsZyl7m6QPBkZ3WoXXYOaJBlzC7OLvn2gSekxYHSCphytjUoevwTMow8uyDaEtmczI7WTtnwf+Kz7dhTk5qzdFpvRwQgXjg9vfSmSjtmxUYSOLTdCTwXtGaMahAZ43/sjswfBEkLQJXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488451; c=relaxed/simple;
	bh=CIehRwOxXq/MMdKbOuoZuVUbusoMsXzjpSnVa9ZXTsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4Nj5Wo7PiJFADNHrKIxVbipfnpmEudKMe6yskakoIMVkCZIRGLPuQJqDJU8+oJtm9kIHfall+MXur32Y+r5KIKIDn2LvAD9VTCMVcnn0agARZedWRlPrqSf76vw023sYSruTjYynjghgULFZOPMvOpIN0CqRB6zIEZEjYfCqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9HTk11G; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9HTk11G"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso801166f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488436; x=1792093236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QbmxrA61mON5UV6KCWUsT1o7RUovBs5qxlAH9xJa5bk=;
        b=e9HTk11GTJ7X2Exl1CZIiPwK29AwG7XVA5cM3kGjPvg9bGHfySqLeA0k25ZZjccUvo
         MIsS4AOPVZFgzAbhVHnJWHt0jBAgWk0X+GR006Guruugo7mij/HYx0PpXTUiZOOan9ma
         yYohZDKAFubygN8GTT2dDuF/IREoMYZXZPFFpS0ou4TtmjA6QaUS9xl74vCfsxwR6y0i
         IWvTNYyN2JibgPpjqLQxgtSk5YVMATuN1xWYZqNF8VT9MSGGftzrBRVBlmNypSjbFuxO
         BiWYD5YMrDCFPhVwK3OeFPFJVgAynJT+LpivkTLfX+qbmUFZ9fyKutCP6hvINCSVnMeq
         nmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488436; x=1792093236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbmxrA61mON5UV6KCWUsT1o7RUovBs5qxlAH9xJa5bk=;
        b=Tr2J/P+igyV3xw1s1O2HaaPQ1u3Y5rLqhZNGIu0cP95xOPlepB/++XlV46pY+vTpkQ
         1YJNfXAX2H2ob4B54/NXQzEUuY2vB55AQH5EXuRpU0Bhtt6ivQZVh9IeZqX0RYTzhSVH
         KSLGjj0Fy2X8sBZz2JTpA19qvXLjJVlS2/9Hovy2OOQ+Jrr9bUbc9P2oTtEdwICrCPT/
         6WGvxIWmtSVa9tGQf6c0BUqurkpbrO+M4rarnO1yxs5qQevppQKiZkDezwiP63YNllyV
         S6aX4EDJlHv6NfxBc4JydNimM+aP7UXV48ozjrEEa/+IgtOSoe5BXtSZMW6jOMut4hPE
         8Zvw==
X-Forwarded-Encrypted: i=1; AKwUvByQFACGPe3nwyEAYVDiP7FuFGNFblL/KxcRcfYt/Zba42f11EqAIjjC0lZVC83JwgOF6ClQLI0=@vger.kernel.org
X-Gm-Message-State: AFuF++mzGJ4k64EEKKlMXmiaW6QLjo1ljsqvVyKXGoS3jESViX+i6KkN
	xBziNv4ZhE9lzO2nxtw8wjW0cbp9YYjyqOGGZkYKCb27u7vQ2+JmHmW4
X-Gm-Gg: AYBFou2kpPfi9Ldh7q7b4zuSQolZPSX5ro8h1P9WF533NN9LJpsb8+eCMWztGhIM9xk
	U8wG5ZEt9o06JOYPce17bojc+GcJrRMk2+eq2qn1SS0n1d8vjUPBA4nVFizWWnq79awjm++zpG7
	RGI+K+Hd/uDmPTRUTOn+XXAvTq3Ov5v1TpYYJToV+BZ+59kJRUMcc5R+rQSDCgM6LLy5mv0QcqI
	1uIMm+iyxDdFh7wfGRyLiUZ8KPtAGM3J/k3U6NQFezG/mBkcbLKUbpKGj6FfPudM2L63T+6sPtK
	ihenj21otyRzS/P/l8NfjpKezX83dXpct0lO1aj/HrjoTfiInyPtwnH+HhJyULJaXn5Dx7OzrB5
	jmfOOEOrAL2yGOMQzPs77mD3RvcL6b01ScBvopOas+GbGrDYPVJMYX0cpo64QFvHrSHEEywq7Va
	oSQvxSXywLn2PYxZnVFUZD1YPzvVCO/URUmde4Cc2j9p40hLEJSFQwCHGSLcYGC3obacLCnN3n0
	eLDS0RhUSuSZlIwgiySaTRsL9imPDkIHrOEkVndgheTx2fkDMWS1gTkWzwYr2gIuuUnPOFwUFNd
	2c72EB32gisvrnIQcV38Vno=
X-Received: by 2002:a05:600c:4691:b0:4a1:6282:1cf3 with SMTP id 5b1f17b1804b1-4a1851b3756mr76649545e9.9.1791488436245;
        Thu, 08 Oct 2026 12:40:36 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:35 -0700 (PDT)
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
	Joseph Guo <qijian.guo@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v5 09/13] ARM: dts: imx6ul: Extend Variscite carrier board descriptions
Date: Thu,  8 Oct 2026 21:37:49 +0200
Message-ID: <c53a23adc1e3e9ae7b8c8ffe9e080d743b7af8db.1791487179.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791487179.git.stefano.r@variscite.com>
References: <cover.1791487179.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Add Symphony and VAR-6ULCustomBoard descriptions and SoC-specific
Concerto wrappers. Update the four existing Concerto boards to
include the wrappers.

Move UART5 and the ENET2 reset and wakeup-key pin groups into the
Concerto wrappers in the same patch. Omit UART5 on i.MX6ULZ and
use iomuxc_snvs for the i.MX6ULL and i.MX6ULZ tamper pads.

Move the I2C1 pin group to the Concerto common file and add GPIO
bus recovery and the external touchscreen. Move the panel node
and its timings into imx6ul-var-som-lvds-panel.dtsi for reuse on
the other carriers. Add a DART wrapper for its PWM1 backlight.

Describe Symphony's FEC1 MDIO wiring separately from the FEC2 bus
on Concerto and VAR-6ULCustomBoard. Keep peripheral selection in
the board DTS files so ULZ boards do not instantiate a display.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v4->v5:
 - Extend imx6ul-var-som-concerto-common.dtsi instead of replacing it,
   and switch the four existing Concerto boards to SoC-specific wrappers
   in the same patch as the UART5 and SNVS pin-group moves.
 - Move I2C1 pinctrl into the Concerto common file and add GPIO bus
   recovery and the external touchscreen there.
 - Reuse imx6ul-var-som-lvds-panel.dtsi, moving the panel node and its
   unchanged timings into it. Keep the existing display graph and add
   a DART wrapper for the PWM1 backlight. Omit display files on ULZ.
 - Describe Symphony's FEC1 MDIO bus in its carrier file, independently
   of the Concerto Ethernet option files.

v2->v3:
 - Put the Symphony Type-C interrupt pinctrl under the correct IOMUX
   controller for each SoC variant.
 - Specify falling-edge triggers for the Type-C controller and
   touchscreens, and disable the actual i.MX6ULZ Concerto backlight.

 ...x6ull-var-dart-6ulcustomboard-sd-card.dtsi |  31 ++
 ...mx6ul-imx6ull-var-dart-6ulcustomboard.dtsi | 240 +++++++++++++++
 ...imx6ul-imx6ull-var-som-symphony-board.dtsi | 275 ++++++++++++++++++
 .../imx/imx6ul-var-dart-6ulcustomboard.dtsi   |  18 ++
 .../nxp/imx/imx6ul-var-dart-lvds-panel.dtsi   |  30 ++
 .../dts/nxp/imx/imx6ul-var-som-common.dtsi    |   7 -
 .../imx/imx6ul-var-som-concerto-board.dtsi    |  38 +++
 .../imx/imx6ul-var-som-concerto-common.dtsi   |  67 ++---
 .../nxp/imx/imx6ul-var-som-concerto-full.dts  |   4 +-
 .../dts/nxp/imx/imx6ul-var-som-concerto.dts   |   6 +-
 .../dts/nxp/imx/imx6ul-var-som-enet2.dtsi     |   7 +-
 .../nxp/imx/imx6ul-var-som-lvds-panel.dtsi    |  24 ++
 .../imx/imx6ul-var-som-symphony-board.dtsi    |  96 ++++++
 .../imx/imx6ull-var-dart-6ulcustomboard.dtsi  |  18 ++
 .../imx/imx6ull-var-som-concerto-board.dtsi   |  38 +++
 .../nxp/imx/imx6ull-var-som-concerto-full.dts |   4 +-
 .../dts/nxp/imx/imx6ull-var-som-concerto.dts  |   6 +-
 .../imx/imx6ull-var-som-symphony-board.dtsi   |  96 ++++++
 .../imx/imx6ulz-var-dart-6ulcustomboard.dtsi  |  18 ++
 .../imx/imx6ulz-var-som-concerto-board.dtsi   |  38 +++
 .../imx/imx6ulz-var-som-symphony-board.dtsi   |  30 ++
 21 files changed, 1032 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard-sd-card.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-6ulcustomboard.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-lvds-panel.dtsi
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
index 000000000000..acb6ff31af48
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-dart-6ulcustomboard.dtsi
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
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
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..d2ba0c560fb6
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-var-som-symphony-board.dtsi
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+/ {
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
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+
+		port {
+			typec1_dr_sw: endpoint {
+				remote-endpoint = <&usb1_drd_sw>;
+			};
+		};
+	};
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
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-lvds-panel.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-lvds-panel.dtsi
new file mode 100644
index 000000000000..75af399a35ab
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-dart-lvds-panel.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * LVDS panel backlight wiring for DART-6UL on VAR-6ULCustomBoard.
+ *
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-var-som-lvds-panel.dtsi"
+
+&lcd_backlight {
+	pwms = <&pwm1 0 20000 0>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm4 {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_pwm1: pwm1-grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi
index 0a1a23bca0c7..d2a9877344ce 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi
@@ -69,13 +69,6 @@ &i2c2 {
 };
 
 &iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
-			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
-		>;
-	};
-
 	pinctrl_i2c2: i2c2-grp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_HSYNC__I2C2_SCL		0x4001b8b0
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-board.dtsi
new file mode 100644
index 000000000000..b44093b393c0
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
+#include "imx6ul-var-som-concerto-common.dtsi"
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
+	pinctrl_enet2_gpio: enet2-gpiogrp {
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
+	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
index e5637310ba63..cdd5be9738a8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
@@ -5,6 +5,7 @@
  *
  * Copyright 2019 Variscite Ltd.
  * Copyright 2025 Bootlin
+ * Copyright (C) 2026 Variscite Ltd.
  */
 
 #include <dt-bindings/leds/common.h>
@@ -44,29 +45,6 @@ led-0 {
 			linux,default-trigger = "heartbeat";
 		};
 	};
-
-	lvds_panel: lvds-panel {
-		compatible = "sgd,gktw70sdae4se", "panel-lvds";
-		data-mapping = "jeida-18";
-		width-mm = <153>;
-		height-mm = <86>;
-
-		panel-timing {
-			clock-frequency = <35000000>;
-			hactive = <800>;
-			vactive = <480>;
-			hback-porch = <40>;
-			hfront-porch = <40>;
-			vback-porch = <29>;
-			vfront-porch = <13>;
-			hsync-len = <48>;
-			vsync-len = <3>;
-			hsync-active = <0>;
-			vsync-active = <0>;
-			de-active = <1>;
-			pixelclk-active = <0>;
-		};
-	};
 };
 
 &can1 {
@@ -77,10 +55,27 @@ &can1 {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio4 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio4 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
+	touchscreen@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ft5x06_ts_gpio>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		wakeup-source;
+	};
+
 	rtc@68 {
 		/*
 		 * To actually use this interrupt
@@ -109,15 +104,23 @@ MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x17059
 		>;
 	};
 
-	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {
+	pinctrl_gpio_leds: gpio-ledsgrp {
 		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x1b0b0	/* GPLED2 */
 		>;
 	};
 
-	pinctrl_gpio_leds: gpio-ledsgrp {
+	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x1b0b0	/* GPLED2 */
+			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18	0x1b0b0
+			MX6UL_PAD_CSI_MCLK__GPIO4_IO17		0x1b0b0
 		>;
 	};
 
@@ -179,14 +182,6 @@ &uart1 {
 	status = "okay";
 };
 
-/* ttymxc4 UART */
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb_otg1_id>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
index bd39138b67dd..10ffdb3989f8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
@@ -10,11 +10,11 @@
 
 #include "imx6ul-var-som.dtsi"
 #include "imx6ul-imx6ull-var-emmc.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
 #include "imx6ul-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
 #include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-var-som-enet1.dtsi"
-#include "imx6ul-imx6ull-var-wm8904.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
index 82920ebd812b..158d6fab44b1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
@@ -11,11 +11,11 @@
 
 #include "imx6ul-var-som.dtsi"
 #include "imx6ul-imx6ull-var-emmc.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
-#include "imx6ul-var-som-sd.dtsi"
-#include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+#include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
+#include "imx6ul-var-som-sd.dtsi"
 
 / {
 	model = "Variscite VAR-SOM-6UL Concerto Board (6UL CPU)";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
index b29fcdc079e3..f0ed71798617 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
@@ -4,6 +4,7 @@
  *
  * Copyright 2019-2024 Variscite Ltd.
  * Copyright 2026 Dimonoff
+ * Copyright (C) 2026 Variscite Ltd.
  */
 
 / {
@@ -64,12 +65,6 @@ MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
 		>;
 	};
 
-	pinctrl_enet2_gpio: enet2-gpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* fec2 reset */
-		>;
-	};
-
 	pinctrl_enet2_mdio: enet2-mdiogrp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
index 996b37d35d6e..f2ce219d9f3f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
@@ -4,6 +4,7 @@
  *
  * Copyright 2019-2024 Variscite Ltd.
  * Copyright 2026 Dimonoff
+ * Copyright (C) 2026 Variscite Ltd.
  */
 
 / {
@@ -41,6 +42,29 @@ lvds_enc_out: endpoint {
 			};
 		};
 	};
+
+	lvds_panel: lvds-panel {
+		compatible = "sgd,gktw70sdae4se", "panel-lvds";
+		data-mapping = "jeida-18";
+		width-mm = <153>;
+		height-mm = <86>;
+
+		panel-timing {
+			clock-frequency = <35000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hback-porch = <40>;
+			hfront-porch = <40>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			hsync-len = <48>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <0>;
+		};
+	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..04868ef8a425
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-symphony-board.dtsi
@@ -0,0 +1,96 @@
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
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
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
+&iomuxc {
+	pinctrl_extcon: extcon-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0b0
+		>;
+	};
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
index 000000000000..38845763ebd1
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
+#include "imx6ul-var-som-concerto-common.dtsi"
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
+	pinctrl_enet2_gpio: enet2-gpiogrp {
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
+	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
index 2a3c75ce8dfa..825553f297e4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
@@ -10,11 +10,11 @@
 
 #include "imx6ull-var-som.dtsi"
 #include "imx6ul-imx6ull-var-emmc.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
 #include "imx6ul-var-som-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
 #include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-var-som-enet1.dtsi"
-#include "imx6ul-imx6ull-var-wm8904.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
index 3a527e7de682..c943133abc93 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
@@ -10,11 +10,11 @@
 
 #include "imx6ull-var-som.dtsi"
 #include "imx6ul-imx6ull-var-emmc.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
-#include "imx6ul-var-som-sd.dtsi"
-#include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+#include "imx6ul-var-som-enet2.dtsi"
 #include "imx6ul-var-som-lvds-panel.dtsi"
+#include "imx6ul-var-som-sd.dtsi"
 
 / {
 	model = "Variscite VAR-SOM-6UL Concerto Board (6ULL CPU)";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..6e6f0c3e7140
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-symphony-board.dtsi
@@ -0,0 +1,96 @@
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
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
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
+&iomuxc_snvs {
+	pinctrl_extcon: extcon-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0b0
+		>;
+	};
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
index 000000000000..c2b27175e32a
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-dart-6ulcustomboard.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ull-var-dart-6ulcustomboard.dtsi"
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
index 000000000000..5a11e43027a4
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-concerto-board.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-var-som-concerto-common.dtsi"
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
+	pinctrl_enet2_gpio: enet2-gpiogrp {
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
+	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi
new file mode 100644
index 000000000000..b20a67dcea7a
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6ulz-var-som-symphony-board.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Variscite Ltd. - https://www.variscite.com
+ */
+
+#include "imx6ul-imx6ull-var-som-symphony-board.dtsi"
+
+&can1 {
+	status = "disabled";
+};
+
+&fec1 {
+	status = "disabled";
+};
+
+&fec2 {
+	status = "disabled";
+};
+
+&iomuxc_snvs {
+	pinctrl_extcon: extcon-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0b0
+		>;
+	};
+};
+
+&lcdif {
+	status = "disabled";
+};
-- 
2.47.3

