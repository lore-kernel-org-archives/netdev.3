Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75C53A3B9
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695106; cv=none; b=on7Y+FwTiDcmlbAQE0b4FLLzOwFUVxbtLYltbrvR7+Oeq+7NM/DDaRmmiPzrNp5ZtYvv3IecU6KV12010CBuQamg7DObQVqcveF85AI9sTfjK4fyE/l+rgmeWVaoWLzNsPpi6Md7sRTsZEjRYw+PV2JLDEPD1aAFjaWMX9dwGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695106; c=relaxed/simple;
	bh=wwcBl49Ua3J3rYrGGFwCrJgl8mVZATulcKk0CqxbWsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfVSQ4haf5FSBK4AvyJKNOI6U804tHcJPdxckfbxKjnkuX+44pLA2SfWfyv2LFGD8SH5IQxxC1MHxbe/omD7nUN/KnyZjHSYdIORU8WGe3CNDgbfPiO2d138cpJm9/LOwrFabsLiFWoaidcWe3i/R5fmZE96NLTeLtFQHMeQv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pouwFsGp; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pouwFsGp"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so32370985e9.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695082; x=1791299882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bv6TdBf236Ze+yr88XSw2RKmmfBrco1ijoRwG9znPDc=;
        b=pouwFsGpCNLAg5mvGmenhOQmE9Yqxrskjkiy4qmu8QdPS7utB9SttLM5/uqVo1PDpn
         J9e07Cn7OMX3g10vG5d5xqCqw6pCMpd6ZWfbBTg7vmFcEar5uxtvUWRHgUc0hPsYryip
         hzVnpmhavBtSEo2BcOCKdJ3CMJGDms83Nk2BYwuqPsKRplwFd9uP9pdyJ7A8Q1mV/zH0
         sLxEgEPXm3hnSN7wO6ky3XEt5O/zyaa1MUdvhGN+hHGcWJJ/IWP0Iu+ZNgrtNzq/9n68
         4vLPCdVfzN1kZfXXYoE8lGHzoc0LytFR5ln6eZZfZJhI/eQaT1PK3ReULwW9y2PcUXaI
         jUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695082; x=1791299882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bv6TdBf236Ze+yr88XSw2RKmmfBrco1ijoRwG9znPDc=;
        b=Wu9nPY/v5pw3fiECXhRom2NWMyStV7Pv7KNnTc7QXKMth5JHWid3y80lGs6XwQvVLC
         0JumxMVszPW4Nn1cSJjtIss5tPBvdLb/8eF4zcdtgmddMFWbaQ+go5HbYrKVRC3TDQck
         IBdrk4l04aQA9ksHVnFWCcRrilWpPWVXbHkV4aZL+tadxVKqxqI/x2HLjbCE3+XMhc60
         1peHlFKlalxN0fWnBMkWgiRJbPOicUj745xT4IxEDJOtAFNmitTbqpGoEFTJ179HMfbV
         P1ro/ZxfqPzi+vlRvhWTPqbD2XwQ6RPs+xOzAWsNp66fiGDR+4V7YGnoKzNotH1yMA4j
         Ssag==
X-Forwarded-Encrypted: i=1; AKwUvBx0S7jrIBwen8yOxrxrC8eGWbPrtvx818n80nZVKy0senOE6VXK/eFKjq18C397r7AU6+wi4lU=@vger.kernel.org
X-Gm-Message-State: AFuF++k25gfZRqgpvI+YJp8SR75xardiJYqCsjz26hkMQT/M4VYr5n/k
	bmxJXzZrif7HdQjXAlRLnyoWu7Rc84SZs5NFcpj5mJV9+744eS1rFAGP
X-Gm-Gg: AYBFou3wr1w5fwHVcyhknzYxsBuK+fcmusX4ToZlJfZS+gwYGa/JVs+pn26/igocHe6
	jvZXWw8fml+JvfP4t/o0YBKvxJztNNcGnWXui4ou9PiwC8E8PqoTdeVSFz09pV1QhXI+CID7L4S
	8QZdT57ayBoKYdtk5oY90QLkqu6/crXIGuFSlTSiL4f8MAMsZFkHY4O1vuk0aTs0hnp3WvuWS6H
	5JJJ+wnDuwBvQiOQSx5cKCKBCuz+XbvrYHRW3e677y8KCrEeLzh/n5vLhKn0azPNmFLXlX5Ndub
	1DRdpPwlvSYPML5MLZk/megDqWUErYg+z8qslNhQIEujFhg8W+b5UHwE/cdsUJgDducZ4orU7Vg
	HuIoVpBuaHJ/XEUwwUBpQnCZSxl0y5KC5Z+iXVPNQu5URUIb/nrcwandDBVXtNIqiE/+ray2WZB
	LLqMCVTWoOwRBxNNphMF/22De9C4IH3E/PWHsIfnTGYFdbgL2m6LrJWeE4Hn8n43UqQK6C6mWw4
	nuWFiUr57GySg3cSPUjOw3RyEpVqEuI/jV/5gNGIB5dt1HPgpvnoLx7tZFav0KKgsmG362B6LxE
	yRVftymKKw48SKuHhj5PJ2XzsfOw9m44
X-Received: by 2002:a05:600c:4eca:b0:49d:2450:68ac with SMTP id 5b1f17b1804b1-49fe66caac9mr308931855e9.5.1790695082090;
        Tue, 29 Sep 2026 08:18:02 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013cf8402sm10313705e9.2.2026.09.29.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:18:01 -0700 (PDT)
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
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v4 10/13] ARM: dts: imx6ul: Reuse Variscite DTSI files for Concerto
Date: Tue, 29 Sep 2026 17:17:37 +0200
Message-ID: <34f8a8ecb891d559531f879aeeacea53e2d8d3ba.1790693249.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790693249.git.stefano.r@variscite.com>
References: <cover.1790693249.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Convert the existing i.MX6UL and i.MX6ULL Concerto boards to the
shared module, option and carrier DTSI files. Keep the existing DTB
names and compatible strings.

The former LVDS panel graph did not describe the working Variscite
display setup. Replace it with the LCDIF display timings and backlight
configuration for the actual Concerto hardware.

The old Wi-Fi power sequence and Bluetooth nodes modeled enable and
reset control in the kernel. On these SoMs those controls are handled
in userspace, so use the shared Broadcom Wi-Fi description without the
old kernel-managed nodes.

Fold the remaining common, audio, SD and Ethernet descriptions into
the shared module and carrier DTSI files.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v2->v3:
 - Use the shared storage and wireless option DTSI files.

v1->v2:
 - Use the shared WM8904 codec DTSI in the existing Concerto boards.

 .../dts/nxp/imx/imx6ul-var-som-audio.dtsi     |  30 ---
 .../dts/nxp/imx/imx6ul-var-som-common.dtsi    | 187 ---------------
 .../imx/imx6ul-var-som-concerto-common.dtsi   | 215 ------------------
 .../nxp/imx/imx6ul-var-som-concerto-full.dts  |  15 +-
 .../dts/nxp/imx/imx6ul-var-som-concerto.dts   |  14 +-
 .../dts/nxp/imx/imx6ul-var-som-enet1.dtsi     |  44 ----
 .../dts/nxp/imx/imx6ul-var-som-enet2.dtsi     |  79 -------
 .../nxp/imx/imx6ul-var-som-lvds-panel.dtsi    | 112 ---------
 .../boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi   |  27 ---
 .../boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi |  75 ------
 .../nxp/imx/imx6ull-var-som-concerto-full.dts |  15 +-
 .../dts/nxp/imx/imx6ull-var-som-concerto.dts  |  14 +-
 12 files changed, 32 insertions(+), 795 deletions(-)
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-audio.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet1.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-audio.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-audio.dtsi
deleted file mode 100644
index 3c480bc7a6ad..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-audio.dtsi
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Audio support for Variscite VAR-SOM-6UL module.
- *
- * Copyright 2019-2024 Variscite Ltd.
- * Copyright 2026 Dimonoff
- */
-
-&iomuxc {
-	pinctrl_sai2: sai2grp {
-		fsl,pins = <
-			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
-			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
-			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
-			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
-			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
-		>;
-	};
-};
-
-&sai2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai2>;
-	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
-			  <&clks IMX6UL_CLK_SAI2>;
-	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
-	assigned-clock-rates = <0>, <12288000>;
-	fsl,sai-mclk-direction-output;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi
deleted file mode 100644
index 5600eeaa5854..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-common.dtsi
+++ /dev/null
@@ -1,187 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Support for the common parts shared by all the different CPU options on
- * Variscite VAR-SOM-6UL Module
- *
- * Copyright 2019 Variscite Ltd.
- * Copyright 2025 Bootlin
- */
-
-#include <dt-bindings/clock/imx6ul-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Variscite VAR-SOM-6UL module";
-	compatible = "variscite,var-som-imx6ul", "fsl,imx6ul";
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x20000000>;
-	};
-
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "3P3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	reg_gpio_dvfs: reg-gpio-dvfs {
-		compatible = "regulator-gpio";
-		regulator-min-microvolt = <1300000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-name = "gpio_dvfs";
-		regulator-type = "voltage";
-		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
-		states = <1300000 0x1
-			  1400000 0x0>;
-	};
-};
-
-&clks {
-	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
-	assigned-clock-rates = <786432000>;
-};
-
-&iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
-			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
-		>;
-	};
-
-	pinctrl_tsc: tscgrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
-			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
-			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
-			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
-			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
-			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
-			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
-			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
-			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
-			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
-			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170b9
-			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170b9
-			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170b9
-			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170b9
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
-			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
-			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
-			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
-			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
-		>;
-	};
-};
-
-&pxp {
-	status = "okay";
-};
-
-&snvs_poweroff {
-	status = "okay";
-};
-
-&tsc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_tsc>;
-	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
-	measure-delay-time = <0xffff>;
-	pre-charge-time = <0xfff>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
-	bus-width = <8>;
-	no-1-8-v;
-	non-removable;
-	keep-power-in-suspend;
-	wakeup-source;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
deleted file mode 100644
index e5637310ba63..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-common.dtsi
+++ /dev/null
@@ -1,215 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Support for Variscite Concerto Carrier board with the VAR-SOM-6UL
- * Variscite SoM mounted on it (all CPU variants)
- *
- * Copyright 2019 Variscite Ltd.
- * Copyright 2025 Bootlin
- */
-
-#include <dt-bindings/leds/common.h>
-
-/ {
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_key_back>, <&pinctrl_gpio_key_wakeup>;
-
-		key-back {
-			gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_BACK>;
-		};
-
-		key-wakeup {
-			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_WAKEUP>;
-			wakeup-source;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_leds>;
-
-		led-0 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_GREEN>;
-			label = "gpled2";
-			gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
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
-};
-
-&can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "okay";
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	rtc@68 {
-		/*
-		 * To actually use this interrupt
-		 * connect pins J14.8 & J14.10 on the Concerto-Board.
-		 */
-		compatible = "dallas,ds1337";
-		reg = <0x68>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-	};
-};
-
-&iomuxc {
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_RTS_B__FLEXCAN1_RX	0x1b020
-			MX6UL_PAD_UART3_CTS_B__FLEXCAN1_TX	0x1b020
-		>;
-	};
-
-	pinctrl_gpio_key_back: gpio-key-backgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x17059
-		>;
-	};
-
-	pinctrl_gpio_key_wakeup: gpio-keys-wakeupgrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x17059
-		>;
-	};
-
-	pinctrl_gpio_leds: gpio-ledsgrp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x1b0b0	/* GPLED2 */
-		>;
-	};
-
-	pinctrl_rtc: rtcgrp {
-		fsl,pins = <
-			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0 /* RTC alarm IRQ */
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
-			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
-		>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA00__UART5_DCE_TX	0x1b0b1
-			MX6UL_PAD_CSI_DATA01__UART5_DCE_RX	0x1b0b1
-			MX6UL_PAD_GPIO1_IO09__UART5_DCE_CTS	0x1b0b1
-			MX6UL_PAD_GPIO1_IO08__UART5_DCE_RTS	0x1b0b1
-		>;
-	};
-
-	pinctrl_usb_otg1_id: usbotg1idgrp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_TX_DATA__ANATOP_OTG1_ID	0x17059
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO01__WDOG1_WDOG_B	0x78b0
-		>;
-	};
-};
-
-&snvs_pwrkey {
-	status = "disabled";
-};
-
-&snvs_rtc {
-	status = "disabled";
-};
-
-&tsc {
-	/*
-	 * Conflics with wdog1 ext-reset-output & SD CD pins,
-	 * so we keep it disabled by default.
-	 */
-	status = "disabled";
-};
-
-/* Console UART */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-/* ttymxc4 UART */
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&usbotg1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb_otg1_id>;
-	dr_mode = "otg";
-	disable-over-current;
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	disable-over-current;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	/*
-	 * To actually use ext-reset-output
-	 * connect pins J17.3 & J17.8 on the Concerto-Board
-	 */
-	fsl,ext-reset-output;
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
index 725f34d6b7ee..4af1445f885b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto-full.dts
@@ -8,15 +8,16 @@
 
 /dts-v1/;
 
+#include "imx6ul.dtsi"
 #include "imx6ul-var-som.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
-#include "imx6ul-var-som-wifi.dtsi"
-#include "imx6ul-var-som-enet2.dtsi"
-#include "imx6ul-var-som-enet1.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
-#include "imx6ul-var-som-lvds-panel.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
 
 / {
 	model = "Variscite VAR-SOM-6UL Concerto Board (6UL CPU)";
-	compatible = "variscite,mx6ulconcerto", "variscite,var-som-imx6ul", "fsl,imx6ul";
+	compatible = "variscite,mx6ulconcerto",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
index c249e15772b8..343f6b97aefc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-concerto.dts
@@ -9,14 +9,16 @@
 
 /dts-v1/;
 
+#include "imx6ul.dtsi"
 #include "imx6ul-var-som.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
-#include "imx6ul-var-som-sd.dtsi"
-#include "imx6ul-var-som-enet2.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
-#include "imx6ul-var-som-lvds-panel.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ul-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
 
 / {
 	model = "Variscite VAR-SOM-6UL Concerto Board (6UL CPU)";
-	compatible = "variscite,mx6ulconcerto", "variscite,var-som-imx6ul", "fsl,imx6ul";
+	compatible = "variscite,mx6ulconcerto",
+		     "variscite,var-som-imx6ul",
+		     "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet1.dtsi
deleted file mode 100644
index 6b1e34347bec..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet1.dtsi
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Ethernet ENET1 support for Variscite VAR-SOM-6UL module with
- * the EC configuration option ((ethernet PHY assembled on SOM).
- *
- * Copyright 2019-2024 Variscite Ltd.
- * Copyright 2026 Dimonoff
- */
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>, <&pinctrl_enet1_gpio>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy0>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
-			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
-			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
-		>;
-	};
-};
-
-&mdio_enet2 {
-	ethphy0: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <1>;
-		clocks = <&rmii_ref_clk>;
-		clock-names = "rmii-ref";
-		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
-		reset-assert-us = <100000>;
-		micrel,led-mode = <1>;
-		micrel,rmii-reference-clock-select-25-mhz;
-	};
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
deleted file mode 100644
index b29fcdc079e3..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-enet2.dtsi
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Ethernet ENET2 support for Variscite VAR-SOM-6UL module.
- *
- * Copyright 2019-2024 Variscite Ltd.
- * Copyright 2026 Dimonoff
- */
-
-/ {
-	rmii_ref_clk: rmii-ref-clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-		clock-output-names = "rmii-ref";
-	};
-};
-
-&fec2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet2>, <&pinctrl_enet2_gpio>, <&pinctrl_enet2_mdio>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio_enet2: mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			clocks = <&rmii_ref_clk>;
-			clock-names = "rmii-ref";
-			reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <100000>;
-			micrel,led-mode = <1>;
-			micrel,rmii-reference-clock-select-25-mhz;
-		};
-
-		ethphy1: ethernet-phy@3 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <3>;
-			clocks = <&rmii_ref_clk>;
-			clock-names = "rmii-ref";
-			reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <100000>;
-			micrel,led-mode = <0>;
-			micrel,rmii-reference-clock-select-25-mhz;
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_enet2: enet2grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
-		>;
-	};
-
-	pinctrl_enet2_gpio: enet2-gpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* fec2 reset */
-		>;
-	};
-
-	pinctrl_enet2_mdio: enet2-mdiogrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
-			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
deleted file mode 100644
index 996b37d35d6e..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-lvds-panel.dtsi
+++ /dev/null
@@ -1,112 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * LVDS panel support for Variscite VAR-SOM-6UL module.
- *
- * Copyright 2019-2024 Variscite Ltd.
- * Copyright 2026 Dimonoff
- */
-
-/ {
-	lcd_backlight: lcd-backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 2000000 0>;
-		pwm-names = "LCD_BKLT_PWM";
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-		status = "okay";
-	};
-
-	lvds_encoder: lvds-encoder {
-		compatible = "ti,sn75lvds93", "lvds-encoder";
-		power-supply = <&reg_3p3v>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				lvds_enc_in: endpoint {
-					remote-endpoint = <&lcdif_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				lvds_enc_out: endpoint {
-					remote-endpoint = <&lvds_panel_in>;
-				};
-			};
-		};
-	};
-};
-
-&iomuxc {
-	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
-			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
-		>;
-	};
-
-	pinctrl_lcdif_dat: lcdif-dat-grp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
-			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
-			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
-			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
-			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
-			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
-			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
-			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
-			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
-			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
-			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
-			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
-			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
-			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
-			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
-			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
-			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
-			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
-		>;
-	};
-
-	pinctrl_pwm4: pwm4-grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO05__PWM4_OUT		0x110b0 /* LCD BACKLIGHT */
-		>;
-	};
-};
-
-&lcdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif_dat
-		     &pinctrl_lcdif_ctrl>;
-	status = "okay";
-
-	port {
-		lcdif_out: endpoint {
-			remote-endpoint = <&lvds_enc_in>;
-		};
-	};
-};
-
-&lvds_panel {
-	status = "okay";
-
-	port {
-		lvds_panel_in: endpoint {
-			remote-endpoint = <&lvds_enc_out>;
-		};
-	};
-};
-
-/* PWM LCD */
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi
deleted file mode 100644
index 0e6d9b945eb4..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-sd.dtsi
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Support optional SD card interface on Variscite VAR-SOM-6UL module.
- *
- * Copyright 2019-2024 Variscite Ltd.
- * Copyright 2026 Dimonoff
- */
-
-&iomuxc {
-	pinctrl_usdhc1_gpio: usdhc1-gpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x1b0b1 /* CD */
-		>;
-	};
-};
-
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
-	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
-	no-1-8-v;
-	keep-power-in-suspend;
-	wakeup-source;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi
deleted file mode 100644
index 6d16ff7909da..000000000000
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-var-som-wifi.dtsi
+++ /dev/null
@@ -1,75 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Support optional Wifi/Bluetooth on Variscite VAR-SOM-6UL module.
- *
- * Copyright 2019-2024 Variscite Ltd.
- * Copyright 2026 Dimonoff
- */
-
-/ {
-	reg_sd1_vmmc: regulator_sd1_vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "VMMC1";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <10000>;
-	};
-
-	usdhc1_pwrseq: usdhc1-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_brcm_wifi>;
-		reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
-	};
-};
-
-&iomuxc {
-	pinctrl_32k_clk: 32kclkgrp {
-		/*
-		 * For TP option, an additional oscillator is assembled on the
-		 * SOM to provide 32 kHz to the WiFi module. Without TP option,
-		 * this pin is configured to provide the 32 KHz clock to the
-		 * WiFi module.
-		 */
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x03029
-		>;
-	};
-};
-
-&tsc {
-	status = "disabled";
-};
-
-/* Bluetooth UART */
-&uart2 {
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_brcm_bt>;
-		shutdown-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
-		vbat-supply = <&reg_3p3v>;
-		vddio-supply = <&reg_3p3v>;
-	};
-};
-
-&usdhc1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_32k_clk>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_32k_clk>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_32k_clk>;
-	no-1-8-v;
-	non-removable;
-	mmc-pwrseq = <&usdhc1_pwrseq>;
-	vmmc-supply = <&reg_sd1_vmmc>;
-	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac"; /* LWB option: Sterling LWB5 */
-		reg = <1>;
-	};
-};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
index 1b7c1a3383ee..9e9286bf2eff 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto-full.dts
@@ -8,15 +8,16 @@
 
 /dts-v1/;
 
+#include "imx6ull.dtsi"
 #include "imx6ull-var-som.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
-#include "imx6ul-var-som-wifi.dtsi"
-#include "imx6ul-var-som-enet2.dtsi"
-#include "imx6ul-var-som-enet1.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
-#include "imx6ul-var-som-lvds-panel.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wifi-brcm.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
 
 / {
 	model = "Variscite VAR-SOM-6UL Concerto Board (6ULL CPU)";
-	compatible = "variscite,mx6ullconcerto", "variscite,var-som-imx6ull", "fsl,imx6ull";
+	compatible = "variscite,mx6ullconcerto",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
index 9c9d16eb1a11..af60735203c1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-var-som-concerto.dts
@@ -8,14 +8,16 @@
 
 /dts-v1/;
 
+#include "imx6ull.dtsi"
 #include "imx6ull-var-som.dtsi"
-#include "imx6ul-var-som-concerto-common.dtsi"
-#include "imx6ul-var-som-sd.dtsi"
-#include "imx6ul-var-som-enet2.dtsi"
-#include "imx6ul-var-som-audio.dtsi"
-#include "imx6ul-var-som-lvds-panel.dtsi"
+#include "imx6ul-imx6ull-var-emmc.dtsi"
+#include "imx6ul-imx6ull-var-wm8904.dtsi"
+#include "imx6ull-var-som-concerto-board.dtsi"
+#include "imx6ul-imx6ull-var-som-concerto-board-sd-card.dtsi"
 
 / {
 	model = "Variscite VAR-SOM-6UL Concerto Board (6ULL CPU)";
-	compatible = "variscite,mx6ullconcerto", "variscite,var-som-imx6ull", "fsl,imx6ull";
+	compatible = "variscite,mx6ullconcerto",
+		     "variscite,var-som-imx6ull",
+		     "fsl,imx6ull";
 };
-- 
2.47.3
