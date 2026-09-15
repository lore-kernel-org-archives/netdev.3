Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91C3B47E0
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475994; cv=none; b=glAQBMOXhH08MpoOwro/MEFPqr+Bo1+T/SD+VEn4UWfdOpRWUUKrgOXABN71sepx64qwhcWcOORgZXTmVwhQAzy05bbdhxPO0w+j4nYc0DDw9VW9sq/01YxE2rwyO6l4uewkp2ivmrN64m2tVe5eLugGSA+8ESjjfqYYe36dm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475994; c=relaxed/simple;
	bh=RGeiUbt1ILnRnxxwfPtaUyN72PdSbFuLoFXljuwFvyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8Sjvoq1Vkxm/LMT3xTCQ+UuYaaTh3nBNozXlQ3f7fC2wJN6L2LAIrN30Dm7f31191ORMs95cqzxt7MB4xnAu5hzMgtZYxlIMuzngWHhfZIlw5UMWvetEejA8yLOXWwH2Jl8nl06smOID2m8+v3RSEe/Jxn+egXZR0NgUtyCVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5QlstoG; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5QlstoG"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39dba377357so1910362a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475991; x=1790080791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUBpSQaA91JU4u4hSD0CHnRFwoDOkNzew04B1AEq+dc=;
        b=E5QlstoGG8mVr347nR+abOpjGg3JzrCE9aFXhbqoAsuMK3E4sn2MhBV9VC13L3sET7
         vvkqb+1ryKuI4dXfaXl1ejOnVT7TJ7DbwWW/HPkTSw4c5pLeRDoWIuBkr/6DnqsJYf3u
         pgfmjrG6bAl/5rg1xLNqBPqmumecV8yOAKNsCJm3vRINqTBQFFkotGKN1E4yu0fBEauS
         Um3V/vq2rrJ9U6DCHSYfWfoXHgl4GZkNr59VHAT2qJCyEQB2P3IYNCYm6dEF3YhQXmIB
         tmnOnN3fQ4J6oAQ78HdPetDN8EWwVwOtF911hRQIgKa7wFvBPftfN3TVn+Fh0xLLg16R
         4zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475991; x=1790080791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUBpSQaA91JU4u4hSD0CHnRFwoDOkNzew04B1AEq+dc=;
        b=Svnq7uicNnv+S8ytgjcwuMGaXk73qB3l/iqY16jMHiW4ItB77ff0xgi8DZBTwf26WY
         BtdDb0E1Q5pExZpWswXHneFZmhAIoElr55eafsnESl3hHl5u4WVtBx7gjaDCZG3WOUyS
         WxqZ4kKlpzsfUHcqNRevXe2xlGfjO6kfRZM07nfYgzCxq24x9itMpd/yVh3q9vWybwyM
         0UALp5jDL7f4NGbuKMhJC6jhYfK24EI9z3vvhfHmgvdULhgknavoagd7wwNUiRzQ0Imk
         eBKxjbtbjRWHukrrlxAbuoN9GPjs+Bg+I8/HolXchvQ8oeZkkUrNL4n1QTy+mzcyOlOE
         xw4A==
X-Forwarded-Encrypted: i=1; AKwUvBygMnybemXhW+KShI5FH1sRJOVuyDTwlBVTRFf6aZSSukCZk+naaY8viMfT6ZIOD/sRFoIi0YQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mpumIEcwoLJ7gfARpTel2jkyhuUtBG8rG9mbB2h+YHkH2gn0wQ
	b+3Vac0VEf9aeNyEfgs6uv8M4BrYmsqHWHf4zcC+M8oJtxN49uPZXLBV
X-Gm-Gg: AYBFou0HKEZmLdU9buu6zAfRadGIAvmlAEAF335gcfPjPS0dXkOcOLRGryfI6dIFSyn
	cd+8qjmvkee6L/rJxfpD4EGCe3pvUwCPfs7LIaK17jrCeRfSEGztA+vgT070oV5NlMTX0GkHZ+d
	h12+qekmdBy1+tvUPV8Z3+L8c7s17G8EsUcCGyZKwk13Rx3D9oYjW4no1GfSmiXizmIya9o9v13
	o8BpuZ1dLDKTjrM/rACsU9hDbdzuOnDdJmJg4ubCwtBjpg2x7W6E/txPkPuXqJQZEyQsy8gCKOD
	PcWq+295Sh2pihhGjGtgAXKmqpzY60SJL9W3nlEnBg5AZseI2SMLwTZPNV+L15ZO74ATSPDuQ2T
	7QZk4wwQMEiGSOB7TS+VQYntr5n8vnHCuoOn2ziAB9PZaQUnmF6MR7eXvJN9rrZMonEHF1aB+S4
	cApaR5BLZWd/pbIDVj4i+WVEb68vxkRIrQDS+Ffiwih2+q7Yri0MDLDnP/f9IBstjkk5owSA==
X-Received: by 2002:a17:90b:5887:b0:39e:8d5:fcee with SMTP id 98e67ed59e1d1-39e08d5fe14mr4270765a91.17.1789475991205;
        Tue, 15 Sep 2026 05:39:51 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm5307259a91.10.2026.09.15.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:39:50 -0700 (PDT)
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
Subject: [PATCH net-next v6 10/11] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Tue, 15 Sep 2026 20:37:59 +0800
Message-ID: <20260915123802.1561724-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915123802.1561724-1-coiaprant@gmail.com>
References: <20260915123802.1561724-1-coiaprant@gmail.com>
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
to route the SGMII interface to GMAC0.

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

