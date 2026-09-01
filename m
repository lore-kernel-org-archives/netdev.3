Received: from mail-pz2-f10.google.com (mail-pz2-f10.google.com [74.125.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23B421EFB
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275011; cv=none; b=d6jFV8KprZJpoLaBVttCYtdQV/xb6U2SkQ3q2eyUf5SheQGkibvyeItZXuxas9QiBjtqo845J6lP20nJHAfAYm4mUU46kkF6eA8kLPemYwPEYwopILRcpwMTmKFNKz4G1csF0TraBVciGNe0tqe1lAEiIy2i0ETg8Je/4PhAXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275011; c=relaxed/simple;
	bh=Pbqc17ixdKV04mbPvez2/xb4avNWEBnmgCndr6ae4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5aIarTaRI7tGPVi7vox5Glezpe9jAiXpz1gXCnIiS4Je4E8XskyTuedDV2rZnAl2kDiuohP9rMNFpVWHzsPsxSamE7Hk01Gzibel5/7kaGkQbLgqlFRR4MVVkho66tS2YyiEunwLT6nIcQrPQ/Rr/dWQvqPx91i2+g8Et2JmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+RXE0bp; arc=none smtp.client-ip=74.125.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+RXE0bp"
Received: by mail-pz2-f10.google.com with SMTP id 41be03b00d2f7-cc1c753b1bbso1221174a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275009; x=1788879809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2srrqsfvZcRiNitfhUr7DhaIgxeXboMwTknQApvQL7A=;
        b=p+RXE0bpL3+o4Lw3WrP7+HU4iGx0qwT/vSMITaGgptxH3XfAdpuWVov0LoVrFj1vD3
         sSroPXV9z+hO8tJ4gJ2zG113VLfY3Ovc/Wm2A7g0xYd6YrOPq0nhtdcuxPtNBgfvvNLd
         gT9FViRjd6y8Zj3BCVFbYrOMzXwCS+08wRJbY7Y0J/dXQxBqnxjdimPyCANXva+t7M0J
         fx7FcBrZiBWw0nC9Z2w/EqTo3KC0INrIUX8C2QHnC6ArY9/2aa67BmRqHnYlBDOU9aAl
         CbiJFvTkRJTLb03QVDMPNmd7awBTI2vcqZKTHhbujzrUKAoap7xJfFxFKZCr1TNnb81m
         1o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275009; x=1788879809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2srrqsfvZcRiNitfhUr7DhaIgxeXboMwTknQApvQL7A=;
        b=TgX7y8P7znwJ0+aQNC4UskEhcqYycpdjDIkGXSBdCGzO6rk+jbFXYYmlDFzYNn1yQ/
         Q78MJiqVcLx56kJv/Tr7xbIu65L88CYrNCMpqXfNJgnHmEiv9sLObrOkOKoWGsVXBNgH
         k1h2TCerfk/HwGDB+mBIhjgEbkuvubBrj1rmdJ+VJTmVKpoEqm8uLHHSFrbv78ORF2cI
         APQV7ARnRh58r4AlA/AhfFBW1PbePM+zRv6S6FwX0gH9sBVJoJoD0geIm3Ri8b8/9Wta
         7DgPPNogBH9nUo/PXlBfk9pNLfvmEvoAjeCE1Hg3Q/5CRNQ7G5W1mIW00czO3JGh8STr
         YEkw==
X-Forwarded-Encrypted: i=1; AHgh+RpseR8hm6Rs7dSvpEhKvj0WJ26qLHN1eD/eqsStgijRfQOKOEWoFOVlnTYQYonuJElEzJNXzw4=@vger.kernel.org
X-Gm-Message-State: AFuF++kvo/X0vsz9f8fWtVgxMYlvWEuwKs1WQBjZ/eWg7/ig7pJmjEMp
	3ExgmoWOcCbZeolvHQEfjtnLYCVqvddFss1iruE4ZWeU50aHK1Xe20My
X-Gm-Gg: AR+sD13aejXHUnOju55hNRmtSC54vekijs0w6QDk2+nLkOH8x7/CaK7dHL6v8QOAORb
	ZVriBzaZW0XTaX41H6qxOVWnleK2nh7jwL0i63SMmt06UTun9eTLVh3RGcUYg3D3+bE40GzeT43
	WQxmav5tVV47zFtxDcQFFEhRlUzwZ42wNUueiBXGWYKnfZ3weM65XE9nVMhwQB4ScHDklyLsFX7
	VWerr8/C3xeZUvE8D1rIi2bRSWMNbTvw0g0iOBUQHgn8J/qJooQAqI2UA+ZnN8Gy1Ug1jURlRuo
	7+HiV/PlvIt3JAGTOHEQJVEYcawB/v6Lut7V+K/v87djBSAsuInc0cE9f3MHInE3JvGEcvfTYOX
	0dfvruvJEpXPaSsWVf55DNiIxUco4mWN0FnHsxsrmkgut+cX7Irz3Ti+6KCk6DWjCZW//I0LvL/
	WI+8hXmxYZTlPrrUVKhPLScwPz6dFRYQsvqUnRlm71EQeT9A5/Nr/Mm9gr0Mo=
X-Received: by 2002:a05:6a00:a213:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-85b5b324108mr11831442b3a.14.1788275008779;
        Tue, 01 Sep 2026 08:03:28 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:03:28 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/10] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Tue,  1 Sep 2026 23:01:09 +0800
Message-ID: <20260901150111.141037-10-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901150111.141037-1-coiaprant@gmail.com>
References: <20260901150111.141037-1-coiaprant@gmail.com>
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

