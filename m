Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009B472F83
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146649; cv=none; b=uXzUa84dwmdjq7yW/gV+VnuW8zNoYbqcyDoXOB6fd/5tVLlSScOcPXNoM/ypNvhvdwCCzCe+4mNNl2o45Oal+t4T1DtfyLYVnd916UNYfv6a2dcelVQIBmYxeuoJLqHrUo6awJaP5O9tViQQALxBR/Ib9F1VQhn+y6wtfhvQOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146649; c=relaxed/simple;
	bh=G4VSqVe1DypmfEvCezrBpXLylcDmqXTCY/nLWX1ELto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCeGD/F2U41yc8AaQy+nPo7oHIyHdcJGMZAxgNLrj63YORobS3K4K4DnrxSGopBDx9UAgAq/L+bsb2UnPremOv94mM17GFrx46SmOP1QGyZPh199chY72rlRLE994tca5B4FL34XVnPSDWXuU/xCk11K3N9MWmdv9DZers1r88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgYcZNjo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgYcZNjo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2acc1e170cso1062667166b.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146644; x=1792751444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQKLRUdMlLSBUekzZJpinIZOOSjB4LUAvJOk+PTbgrU=;
        b=MgYcZNjoSq4EXvLuXvkekNl39wD1zl3R5iP2xKxXCp8Iv+g2vc333tqeYPkAUcEq4u
         fyMM3nb4lGXHbKaDUTJF3ST7agcnmwEYGsyKiIo56BHulGrQ4i3FEbSpl+oB2TyppD3r
         z6rYnmywSe2joGeivgIM8rfl1h0pAqD8iZr0eAMKArwzJpBgaCYSPRGyq8JfO9jEBO5O
         xasApoF9lZjMljC/Tghz8UpOHPxRsRTRceYzwHufv5E+6Gf3JLc+4W3VD74uJ8pgR8cR
         4B43ygGZQEtLe5Ubeuf3Hn9NMBxL/vfgdvr1rLlJBeNCtL8uCdluYlTCHeKVy3g01Vga
         E0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146644; x=1792751444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQKLRUdMlLSBUekzZJpinIZOOSjB4LUAvJOk+PTbgrU=;
        b=yvcgvXTBaSDnkbfs+abOxd3NbMd1092ip6ojFMOGfMRn2bjH7tgpe3KaMO/zqRQ52O
         f4GYrqF28SqKT8cQgi8ezNGnCJHfwDiSKdEEdgjrRSUFcoxKVQOGlKV0TgWm3bYnMpsa
         Bx/bP0IO+D2onfy40s7vNgSH9xcRtGPnPisHqtO4ZtgmHn7e7HHHp4wu0G4wQOIJofYC
         JHRwXK9mNUDDpdwXc7ifWCLdggNu3ApxFl3GV4qchqOYnGz21F/zyXy/aeCC0KIT0x/s
         j67acnu9E+rF7N8LheoqcKx4zwsMHhbHHWcyuBqkHgfjNrqgCihcEL6TrukIQy5Bvn5H
         iJcQ==
X-Gm-Message-State: AFq9FYISe+22zITyBHzVGCb2OFs0mbKpUpJdmORk6DFL9qjI4OX+urpW
	LxSznriNhOBND6StA3l3czyKEcxhXHGdiRTIuESNkiEOEt9DMVqTRVC2
X-Gm-Gg: AYBFou2jShOdD6Z9bmp5KyHrUcH2krn2+OIFvIWwRDXh7Ifww9Vc5+lQeVpnQ2GSo1E
	8/rZco8J262E1DcCconw00lpHB/+daM2f1UMHCQIzMTcVAW7igq3w9G3hINQqm4yI2SyYHnwx+6
	bjtezXfz9ifiWUjiMBl0wjldvXRVay2b5bXPHtLIZ2MOnJGnp0PfqPhNegNKLfmuoXUYdooRooZ
	wm0S4b+rVTDtsNZJ30p7TNJtjGcgZgSUTvUGVT9MTofnEK0tDvwQvKJUYGi8j91ZEM6Pvecwcjk
	mfW07Xy7zYd0DrcXVpSR8Ai9BS2Gu/Q5Qe7luVaRJ1jbRlQjZeV4Nu136/ii6xzpDa0C4qpJa78
	vLRmrBkyG4eIQWpXhUyrhi86IBsc5c4DQuDqNBZBGwFYIGZnhWIaQkwsW58skL4zcQII5wtNGkI
	bf8dPgX/r4JgXtupkH8j97ck9O/K/h7xnjbheeLGvrHZXw0rUzOaXTyb9kQ3L2NKLLZy0PZrgLu
	cL5vureThWMGd33cfsvLD0=
X-Received: by 2002:a17:907:a4ca:b0:c29:f5d8:9c82 with SMTP id a640c23a62f3a-c31aa0dc185mr1999601666b.49.1792146644128;
        Fri, 16 Oct 2026 03:30:44 -0700 (PDT)
Received: from localhost.localdomain ([193.107.16.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce133sm60613866b.31.2026.10.16.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:30:43 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
Date: Fri, 16 Oct 2026 15:29:36 +0500
Subject: [PATCH v2 4/5] arm64: dts: rockchip: add Forlinx OK3568-C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ok3568-c-v2-4-068d68430e6d@gmail.com>
References: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
In-Reply-To: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Dmitry Yashin <dmt.yashin@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146625; l=15237;
 i=dmt.yashin@gmail.com; s=20260930; h=from:subject:message-id;
 bh=G4VSqVe1DypmfEvCezrBpXLylcDmqXTCY/nLWX1ELto=;
 b=wZ/EkHjBx/pNx4oryQA83uZ1yXWIxu65caIIxuqvkmTrETtJPoIrE1nvixO7FLNi3D0kEgYit
 OGMmR8WoL6aBG7ZguObCjsH39WadC8VJeV7oF2FybweNbrywsBoH8iU
X-Developer-Key: i=dmt.yashin@gmail.com; a=ed25519;
 pk=vBe9jaaOEH5bQEvfzb1tWOlz3AMIcXCu/GL/CdlwJco=

OK3568-C is the carrier board for FET3568-C System on Module.

OK3568-C features:

2x 1GbE Realtek RTL8211F Ethernet
1x HDMI Type A out
1x Edp and LVDS headers
2x USB Type C (2.0 and debug console)
1x USB 3.0 OTG Type A (2.0 part is multiplexed with Type C)
1x USB 3.0 M.2 M Key (4G/5G modem)
2x USB 2.0 Type A
1x PCIE 3.0 PCIe (2 lanes)
1x PCIE 2.1 PCIe (1 lane)
1x TF scard slot
1x MIPI CSI
1x MIPI DSI
2x CAN 2.0
1x RTC
1x earphone output and Speaker output, 1x mic.
50-pin expansion header
ADC keys
onboard WiFi And BT (AW-CM358SM)

Add support for Forlinx OK3568-C board.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile            |   1 +
 arch/arm64/boot/dts/rockchip/rk3568-ok3568-c.dts | 579 +++++++++++++++++++++++
 2 files changed, 580 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e7936a21c118..48c83f79f83b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-mecsbc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-ok3568-c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts233.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts233-pcb-12-11.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-ok3568-c.dts b/arch/arm64/boot/dts/rockchip/rk3568-ok3568-c.dts
new file mode 100644
index 000000000000..24418ea0be86
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-ok3568-c.dts
@@ -0,0 +1,579 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3568-fet3568-c.dtsi"
+
+/ {
+	model = "Forlinx OK3568-C";
+	compatible = "forlinx,ok3568-c", "forlinx,fet3568-c", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		mmc1 = &sdmmc0;
+	};
+
+	adc-keys-0 {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1750000>;
+		poll-interval = <100>;
+
+		button-volume-up {
+			label = "V+/Recovery";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <1750>;
+		};
+
+		button-volume-down {
+			label = "V-";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <297500>;
+		};
+
+		button-menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			press-threshold-microvolt = <980000>;
+		};
+
+		button-escape {
+			label = "ESC";
+			linux,code = <KEY_ESC>;
+			press-threshold-microvolt = <1305500>;
+		};
+	};
+
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	/* DSC557-0344FI1 clock generator */
+	pcie30_refclk: pcie-clock-generator {
+		compatible = "gated-fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "pcie30_refclk";
+		vdd-supply = <&vcc3v3_pi6c_oe>;
+	};
+
+	rfkill-modem {
+		compatible = "rfkill-gpio";
+		label = "M.2 USB Modem";
+		pinctrl-names = "default";
+		pinctrl-0 = <&modem_5g_reset>;
+		radio-type = "wwan";
+		reset-gpios = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
+	};
+
+	rk809-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,hp-det-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphones",
+			"Speaker", "Speaker",
+			"Microphone", "Onboard Microphone",
+			"Microphone", "Headset Microphone";
+		simple-audio-card,routing =
+			"Headphones", "HPOL",
+			"Headphones", "HPOR",
+			"Speaker", "SPKO",
+			"MICL", "Onboard Microphone",
+			"MICR", "Headset Microphone";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
+	vcc12v_dcin: regulator-12v-vcc-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc1v8_wifi_bt_reg_on: regulator-1v8-vcc-wifi-bt-reg-on {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_reg_on>;
+		off-on-delay-us = <20000>;
+		regulator-name = "vcc1v8_wifi_bt_reg_on";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <200>;
+	};
+
+	vcc1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3>;
+	};
+
+	vcc3v3_pi6c_oe: regulator-3v3-vcc-pi6c-oe {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pi6c_oe>;
+		regulator-name = "vcc3v3_pi6c_oe";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+	};
+
+	vcc3v3_pcie20: regulator-3v3-vcc-pcie20 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie20";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0>;
+	};
+
+	vcc3v3_pcie30: regulator-3v3-vcc-pcie30 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie30";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0>;
+	};
+
+	vcc3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0>;
+	};
+
+	vcc4v2_5g: regulator-4v2-vcc-5g {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&modem_5g_pwr>;
+		regulator-name = "vcc4v2_5g";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc5v0>;
+	};
+
+	vcc5v0: regulator-5v0-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+};
+
+&can0 {
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
+	assigned-clocks = <&cru CLK_CAN0>;
+	assigned-clock-rates = <300000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0m0_pins>;
+	status = "okay";
+};
+
+&can1 {
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
+	assigned-clocks = <&cru CLK_CAN1>;
+	assigned-clock-rates = <300000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1m1_pins>;
+	status = "okay";
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&gmac0 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus
+		     &gmac0_clkinout
+		     &eth0_pins>;
+	status = "okay";
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus
+		     &gmac1m1_clkinout
+		     &eth1m1_pins>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	pcf8563: rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2s0_8ch {
+	status = "okay";
+};
+
+&i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx
+		     &i2s1m0_lrcktx
+		     &i2s1m0_sdi0
+		     &i2s1m0_sdo0>;
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0x1>;
+		clocks = <&cru CLK_MAC0_OUT>;
+		assigned-clocks = <&cru CLK_MAC0_OUT>;
+		assigned-clock-rates = <25000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rgmii_phy0_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0x1>;
+		clocks = <&cru CLK_MAC1_OUT>;
+		assigned-clocks = <&cru CLK_MAC1_OUT>;
+		assigned-clock-rates = <25000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rgmii_phy1_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PA2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20m0_pins>;
+	reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie20>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x2 {
+	clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
+		 <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
+		 <&cru CLK_PCIE30X2_AUX_NDFT>,
+		 <&cru CLK_PCIE30X2_PIPE_DFT>,
+		 <&pcie30_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk", "aux",
+		      "pipe", "ref";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x2m0_pins>;
+	reset-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pinctrl {
+	bluetooth {
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		host_wake_bt: host-wake-bt {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	ethernet {
+		rgmii_phy0_rst: rgmii-phy0-rst {
+			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		rgmii_phy1_rst: rgmii-phy1-rst {
+			rockchip,pins = <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	modem {
+		modem_5g_pwr: modem-5g-pwr {
+			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		modem_5g_reset: modem-5g-reset {
+			rockchip,pins = <1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	/* Drop pcie20_clkreqnm0 pin. Used as DSC557-0344FI1 enable-gpio instead. */
+	pcie20 {
+		pcie20m0_pins: pcie20m0-pins {
+			rockchip,pins =
+				/* pcie20_perstnm0 */
+				<0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
+				/* pcie20_wakenm0 */
+				<0 RK_PB5 3 &pcfg_pull_none>;
+		};
+	};
+
+	pcie30x2 {
+		pcie30x2m0_pins: pcie30x2m0-pins {
+			rockchip,pins =
+				/* pcie30x2_clkreqnm0 */
+				<0 RK_PA6 2 &pcfg_pull_none>,
+				/* pcie30x2_perstnm0 */
+				<0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>,
+				/* pcie30x2_wakenm0 */
+				<0 RK_PC5 3 &pcfg_pull_none>;
+		};
+
+		pi6c_oe: pi6c-oe {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sound {
+		hp_detect: hp-detect {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_reg_on: wifi-reg-on {
+			rockchip,pins = <3 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+/* WiFi part of the AW-CM358SM connected with SDIO */
+&sdmmc2 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3>;
+	vqmmc-supply = <&vcc1v8_wifi_bt_reg_on>;
+	status = "okay";
+};
+
+/* BT part of the AW-CM358SM connected with UART */
+&uart8 {
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart8m0_xfer &uart8m0_ctsn &uart8m0_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+		device-wakeup-gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "wakeup";
+		nxp,wakein-pin = /bits/ 8 <18>;
+		nxp,wakeout-pin = /bits/ 8 <19>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_wake_host &host_wake_bt>;
+		vcc-supply = <&vcc1v8_wifi_bt_reg_on>;
+		wakeup-source;
+	};
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc4v2_5g>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0>;
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	phy-supply = <&vcc5v0>;
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0>;
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};

-- 
2.56.0

