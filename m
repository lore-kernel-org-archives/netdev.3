Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE54D4867
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107521; cv=none; b=bo5CiussyGUoMTHu6XJN2UswSnkJiI7DBuPYScXKMmGaVvY/K4RPaooKSzgXXHnh+6nBsX1nZQNYkeYm/MIdA9OqisAy4Or4Z/hd7wIJabBRsA+ey55glseTy8GXvXdaum49iVmxA8e6CxvQFAj4g9AjbOf+zapnOqHWESWmiZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107521; c=relaxed/simple;
	bh=EAepGZi5JJgVl5A2Zgbnsm82y7MavVep4jBcaMjh1U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpTGZpcR66kFdDdpY4QaHBHIh5v5X6F+KA2lN6TkYtqtPqu4cNSHLx4xSzdLURBWzhKJq/64e/E8snmQ0loRlgRRCzP3iSz0oww9m14rIEzsHrFe4gU8kUya7gG/tN8ScR+xednlQv8dygsPFQN0ooUVCsjzO2Y3v8r7Ff2l/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehzT3xUx; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehzT3xUx"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6f9dddd99so963155ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107504; x=1790712304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IeBd/f+KYPaUD3mTxXbAK7RiokjVClr9ke91eN5DQPw=;
        b=ehzT3xUx4rW/uBTmhMgoj333w78TBs0axtGyz1PuWXSgzFgovhSIFTBMgMikJOrc4k
         vHCtiAN0fJk+Ya9hRaCZcmQjOoE46/QVdISEQZOf9cpnpUElvyTVj7cbxxa57FiLlNAB
         jKp6D6uUTqgIbRDtPBGtUpTHVZAomote5esBDTvq/4U1PZrjFlr0ON1sbIMIgqNTGaTE
         tLO2l8zW80vI2TQEfmJUitGA/q9tnk9amO8cYAXzEbv3HND/OnHoG2g2dkuAz9vRLHcT
         iyzJfvrD+HN4PHZmzzuHPKZqr5Rgw8OOCL33l9oJm3qcF3DVws+4iJd3YxA8c8k6RlVs
         RNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107504; x=1790712304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IeBd/f+KYPaUD3mTxXbAK7RiokjVClr9ke91eN5DQPw=;
        b=sorQpKWPgA42n1jkvT7YmKiYCnZ78avrecB1cx19sG6b7XOSQ1YZWHdi6qwh3DW657
         1QYZicocdB4TmmLeFIKZH9hTwgel74Xjy4chCdLOReinwFII8prmi88VT9+GJXt3kDDt
         l0EF5wng0AibhgHrBTNlZPTC9MbMTDQCXxI4bID6f1JnxY5wSP/tkrqtQt7I9AG4PlL0
         IHOG1uy6q4dx03KjBnJDlH85/0B3DQTD7+064rf35T8pT8F1FKRyEByyaVx6/3y0YT58
         yaxZwmdZ+QIOW39vUkq8k7b8gcUz/QtwL56RwpM983mATLW7qP2udqQkVK233avkVnPl
         l0xQ==
X-Forwarded-Encrypted: i=1; AKwUvBzru7smCUOZuKrzV+ga4PfcGlyF/3Omgw1bqDc4rKLFvdy82uSPDj8mLUwrXxEI1tf+KSfnMrw=@vger.kernel.org
X-Gm-Message-State: AFuF++nXEhBHmPkvzQd9QO+wwzUfW7GfAkq9XdfwgZeFi/O2UdWbyMDy
	u8N4ZoxhEl9WxbN601Nhc68jtMycU95FFs+4BH/aZ6GQyVfwiJampZnP
X-Gm-Gg: AYBFou1fjfY1YbeqqnO69dihTtORHS43cdrYDWVy9kYaTjFF1pcepk4W+29cpl5SqT3
	SRWx30GFPRUT8eLqUuTrsH40i8ceNfTgNUynoU9koxX8GJ2q+Q6eilZTVrzX5yl7GvTYzEwmeuJ
	Geq4D9y1RKpu2EkM4wx9iPrBOV3pK36yEYnsAvNyU/n8dZj+mVfpHZwsHFBDBntUQoKp2JjM7ru
	CmpyqQeyzRntKy47Iuz1DZYJf4rjl9gSE2m8VgwfQ3b6Mb379QfA9yJOf0scHMFw4zvaDqe1KFK
	vaaOYIyXgH240rJc4zrFJftwe+slwwEFDX7kUE5iIoahwJmIwz8EXQ3egnQ2xncbWK9+HGdZKsF
	NEHNkIAXMWh4aY1XHYk9QAiQ0xNI11wVXHy/BWwQPLNxdAjlFLJQLdIQoxgSGal9wHk6aw9cT62
	MnU5qzJ1lkWc9bjstcqS9X4wzlfyCTUQ2myFL4+uNM9JIg9EmsPprpt4dgiGSEl3AL86nC
X-Received: by 2002:a17:903:228e:b0:2dd:ad73:c984 with SMTP id d9443c01a7336-2df69d5ac91mr4126585ad.28.1790107504081;
        Tue, 22 Sep 2026 13:05:04 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:05:03 -0700 (PDT)
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
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v10 10/11] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Wed, 23 Sep 2026 04:03:34 +0800
Message-ID: <20260922200336.2201212-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
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

Add rockchip,sgmii-mac-sel = <0> to the already enabled combphy2,
to route the SGMII interface to GMAC0.  RK3568 has three Combo PHYs
that can carry SGMII; which one is wired to the XPCS is a board-level
choice, and Photonicat uses combphy2.

Enable the xpcs node and its port 0 sub-node, referencing combphy2
as the SerDes PHY.

Add the mdio0 node with the YT8521SC PHY at address 3, including its
reset GPIO and LED configuration.  Also add LED configuration for the
existing RGMII PHY on mdio1 for consistency.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 74 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
index 58c1052ba8ef3..fdaa4a2a4328b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3568.dtsi"
@@ -241,6 +242,7 @@ &combphy1 {
 };
 
 &combphy2 {
+	rockchip,sgmii-mac-sel = <0>;
 	status = "okay";
 };
 
@@ -260,9 +262,18 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
-/* Motorcomm YT8521SC LAN port (require SGMII) */
+/* Motorcomm YT8521SC LAN port */
 &gmac0 {
-	status = "disabled";
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>;
+	assigned-clock-parents = <&clk_gmac0_xpcs_mii>;
+	managed = "in-band-status";
+	pcs-handle = <&xpcs_mii0>;
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
+	phys = <&combphy2 PHY_TYPE_SGMII>;
+	phy-names = "serdes";
+	status = "okay";
+};
+
+&xpcs_mii0 {
+	status = "okay";
+};
-- 
2.47.3

