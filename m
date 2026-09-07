Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27750AC19
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795587; cv=none; b=cCns7mNoAi6+iRIgXLjNCJpxPhXXHdwIziykx6BGxp9l/qcANBc2EKaX3KFh5p1ZRU2E9FWPhKnRSBCsM08CO/PuOp1YUFyF1Ru6W7kWdI5MOpky12KmCbfcOHZjBrv1uxA/vgQ2RKAIajWx09ayRlS3Mn3+AVLU1hA3fJlK5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795587; c=relaxed/simple;
	bh=Pbqc17ixdKV04mbPvez2/xb4avNWEBnmgCndr6ae4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZA+Dkps1dMEvPuwMpLx3QHe4Gdtwty3hY5LJZw925C5solnKKfPYo/kQWXHc5m1Fa892Hil/BEuXUCp6Ox/oEOXFrXpqPEKW+z6/OVc6JHWgE0+Csxsb1L3pmtJ4r3eBeTskHR0cgpFaJvaVGbPc1pRpfwvZH8IG3Div9NMnS+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNTRezsL; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNTRezsL"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so2170391a91.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795585; x=1789400385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2srrqsfvZcRiNitfhUr7DhaIgxeXboMwTknQApvQL7A=;
        b=LNTRezsLA4/pyrQprJySUmdEqEmNmKHmTulOd58FBcLRM9EDSh+45rbgOSgtiOk7I2
         Qfr8xBUt6co7TYauKOZhRvguRKaGM1AW74TV5AKZFeAKGrrcSouIRWZTizVBsPhpdoPu
         jQaLqskHXQAwWlAGsrhmSKw43pnvZOBdHpKDfLMoc+JTEXCGEvqFs7owgOrUKpmqO3BH
         19THbpnrTvT4zzT8gB/LiURsqpjm2EckuDlOCbURYygARDclA+Lxfyp3AsVjTInba/WN
         chSl/8HXSw+CeNX/BlAOLbS40CuvSo2Kt/0EWB/DENYPJnvqOSp5IW3zKuIJcjl0qaeW
         E2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795585; x=1789400385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2srrqsfvZcRiNitfhUr7DhaIgxeXboMwTknQApvQL7A=;
        b=V6/jEtPIvJXzsCJ1y5SAwR8oF1yh0bRSyxeHm45SFuiKLV6WdFE+5nb7OcuyIbyCXh
         TUWagAr67MeKLI9m18W9FLHfBB836t8MxtSfI7BdpjD3B46stcowLsBF4dxgLFAg7oka
         rC4wMUQJetf4OoFuFwIlOgHNGcWpPirKEEpEC99VeO7zbDSg/D+lmUrsNJAhw9AeWPkK
         JTnYHScuw/sW/CF9IhFabF+uOi8Mgx0j53GyWepzVWlfzuSk/VhLuB5HRPpDMxFpwuVp
         TmMdooQXLMwrN/VNGsnM1Uhuu18t+lPJjyK/Ms8vVTjDOz3ak6VA1AWp41sUp/adBT0s
         Acuw==
X-Forwarded-Encrypted: i=1; AKwUvBzhmMjyaD/uebqARV5R69cJz5QIDnopyP9200OvfQufVNT/ysPdWuQ/63nahxGz2CIbS8Ltxho=@vger.kernel.org
X-Gm-Message-State: AFuF++nhGsqOwk/O97ZuU5Vdm2WdCId39yknhgKocIcXnfrnG7qW5m3T
	yQLFuYN3lDrW8X0YSVnb5udEagnszA5KZRC4TOWoUVo7frOttU8eKzhg
X-Gm-Gg: AYBFou2D6sfqWpPn586NBQ9IZQ3RGtwB1gS4rLsQcVKIFQ7O8JUMDX24mzR5kNQTrgP
	bFRGv/zb1tdgcz0qkcncMva3kQiGckqDIgWAcsQDpUfA8vW08iJQEmOa3lj+wuRiuWwLCYcZtzD
	CkxScaImFshfa5ugwHjxekS37tyi3omRwpJNwaq5q64U6fc5kHtMbEYnfTD1Z3RkcVt/yo0Tkxq
	CftOA9rAqHScf0jyqrRsFGzPriM+wJjKb10CoHzfcm6euEx+tHIcPuit4w4SN1OrVlaMJLKFFmw
	7wCdTJbMhT8Anfb18/MFo2O9dXyCZzABSaTYuEayOIDMIbweVwyi8LnQK5guywcyMmRpHzcXpTf
	+4LvWCbxLgapJy/SMYI477X8bn2U5jlO0/o3TQLXMwOps/yz4SCPRG7JlsbPf3D+Pkybj+hteTn
	FiErZ2fLaXf7sZ8FhEQOND+H+0fx/fvrZebt9+biedvFjTjV0VlgsTd/qXtJPF
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-39b260d2977mr35605265a91.4.1788795584940;
        Mon, 07 Sep 2026 08:39:44 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm21690121a91.9.2026.09.07.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:39:44 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v4 09/10] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Mon,  7 Sep 2026 23:37:12 +0800
Message-ID: <20260907153713.2572547-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907153713.2572547-2-coiaprant@gmail.com>
References: <20260907153713.2572547-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ariaboard Photonicat has a Motorcomm YT8521SC Gigabit Ethernet PHY
connected to GMAC0 via XPCS SGMII.  Enable the necessary nodes to make
this port functional.

Enable combphy2 with rockchip,sgmii-mac-sel = <0> to route the SGMII
interface to GMAC0.  Enable the xpcs node and its port 0 sub-node,
referencing combphy2 as the SerDes PHY.

Add the mdio0 node with the YT8521SC PHY at address 3, including its
reset GPIO and LED configuration.  Also add LED configuration for the
existing RGMII PHY on mdio1 for consistency.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 74 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
index 58c1052ba8ef3..25caa44198843 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3568.dtsi"
@@ -242,6 +243,7 @@ &combphy1 {
 
 &combphy2 {
 	status = "okay";
+	rockchip,sgmii-mac-sel = <0>;
 };
 
 &cpu0 {
@@ -260,9 +262,18 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
-/* Motorcomm YT8521SC LAN port (require SGMII) */
+/* Motorcomm YT8521SC LAN port */
 &gmac0 {
-	status = "disabled";
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>;
+	assigned-clock-parents = <&xpcs_gmac0_clk>;
+	pcs-handle = <&xpcs_mii0>;
+	managed = "in-band-status";
+	phy-handle = <&sgmii_phy>;
+	phy-mode = "sgmii";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim>;
+	status = "okay";
 };
 
 /* Motorcomm YT8521SC WAN port */
@@ -341,6 +352,36 @@ &i2s0_8ch {
 	status = "okay";
 };
 
+&mdio0 {
+	sgmii_phy: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x3>;
+		max-speed = <1000>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PC6 GPIO_ACTIVE_LOW>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_AMBER>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
 &mdio1 {
 	rgmii_phy: ethernet-phy@3 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -350,6 +391,25 @@ rgmii_phy: ethernet-phy@3 {
 		reset-gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_LOW>;
 		rx-internal-delay-ps = <1500>;
 		tx-internal-delay-ps = <1500>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_AMBER>;
+				function = LED_FUNCTION_WAN;
+				default-state = "keep";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_WAN;
+				default-state = "keep";
+			};
+		};
 	};
 };
 
@@ -586,3 +646,13 @@ &xin32k {
 	pinctrl-names = "default";
 	pinctrl-0 = <&clk32k_out1>;
 };
+
+&xpcs {
+	status = "okay";
+	phys = <&combphy2 PHY_TYPE_SGMII>;
+	phy-names = "serdes";
+};
+
+&xpcs_mii0 {
+	status = "okay";
+};
-- 
2.47.3

