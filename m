Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3A3FCB11
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326076; cv=none; b=ZnA/LgDG1eg6DBHqGN6pLzJfcT4C+TNfq+wAekAAd2mwFcapTsMEXu7o7cRtXxA3iF/lVYjrxGdLQwC+1KQlAoKaQFEQ0Np8wWUbnLwWRXCG0OyEhbbF1qFxoOrHjYPu22NBl/t6eQvRU4o7r4veAb8/Y7wUTSnK2IJvycRYwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326076; c=relaxed/simple;
	bh=RGeiUbt1ILnRnxxwfPtaUyN72PdSbFuLoFXljuwFvyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9i+g9eKRC+QWwEq4mj+bJnjHU10rKKmEF6+VtS1N4a4ddD+L2OyWsf0ynY/fAxP1N5BM48mqy8L9SG9WkIoZzv4aYJ4u817dtiRA3EKxgH7e7RhG19h7zap45YlRw/hWvyKIhIgOUWgbP/xFcjwhmqRQJF377UhKhuwNiwhWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdvuoUsn; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdvuoUsn"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d942de6574so15901825ad.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326072; x=1789930872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUBpSQaA91JU4u4hSD0CHnRFwoDOkNzew04B1AEq+dc=;
        b=rdvuoUsnUw3igx7ZbMagUUA9L33bfl7eM56BNx2tnreQbYbT3XZy8glHxpR5NfKH22
         no09nUPoAx2OvveW79xdpwDfYR+05riW5YoWm71XTLFHLuYhKIP8U7SIfdi6K/C1m21s
         djc2dtoJT8fC1ty8KqmJkHfa/QVS0clzyuPyLqbVbhH/e32LKK+I9bfulBOCjlCGwr4y
         kj2LBGl9NTBqwFPwKbDB2I4DHD0guy59gFt/v6ph56GeV4yNWAshH9CVh22auotuk4oy
         musnjj8cfO3GCzMS3n9ivfZbJSJqQLHsvtHP5sthKshndLP1ju+Dgcw4zNUr3trxtB1s
         r/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326072; x=1789930872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUBpSQaA91JU4u4hSD0CHnRFwoDOkNzew04B1AEq+dc=;
        b=LySA5mfMCHgXWMLc2fsi0fMXDe3o407aYzFYnDDo4wxVefRmDntjsrFrNPauXGGaet
         oO58pPh75dDMGEe8amnuVmoUOjUxvlGgJ62FU5g12dillGBgqpEbVDGYCWSUkvBHBOE2
         9sptyLwDRaMZn2qOgLA4KhM636yuo0Am2b6aU2npTDHToIOSBUtQqTZgKoIM9AjfZe9h
         WPPuJn7NLvCxrW0sQwfeWFv4c/3VTW6i1DvLXO2vfNLfkaz4Z2knmyQ4asDBCwwkPYGA
         Qe1uRIZLnhHojogQJIcqD1GXNaXC2CglQUplzGZTPk58E0AdaVaXSlP12YWagRj+d3sT
         tQ3A==
X-Forwarded-Encrypted: i=1; AKwUvByhcYc1Z8N5pqmZcuuS46ImBuUiBERHTixxhZn3ynrCqEuqrfxhbsTcwnAllliaRiJqEkon+Hk=@vger.kernel.org
X-Gm-Message-State: AFuF++l/Viot4OgeFRme9T7m9mCuOdowD7/aHRSNcDZYrPwXtukYirvx
	L0Bnb6fRtFMvFJdleH+2IpL1oNuG68sRl8u95zF3fDAvPZQ37Ys4/jwW
X-Gm-Gg: AYBFou1vWJCo0hncvDarVBWJ39GN7N2giRFhYbSsHSanfC2eqxvD+RGWB0EmXqjT+jQ
	BK8JyysBdNawgHQqtsjRRLUdTYjyoVbwVIFNYRU2HK811gmJAkD46OEJXtoGcjiIg959bYebTAd
	1if7aptaFMOSfjlE1U/FFj1zHqO4cKeMAqyXC7xikzQthiaAhAiZGOdJnQmtYc9cVsWMM5G5Bmx
	LQYmlO+kW+xR42ycWyEngBQQKYJeVaR3Sq1G6BB6rdXFvBETgo/vL3Lkwae9Tuh9cWLOtlDYuTe
	sGhxSO4sqOkwH/LCWIp0FXXNp3r+7GZE3Xrssi6lbgh5bExarqY/J8yhEtYrbTKDr9rNl6dDTmy
	16yapbROTHySk31njGb9snFJ2MHRBh0khHaEHy2pyCzBYpVk66zyRt//jc0mBDvICeGcRke6SEZ
	3U1yE8UJHtnVwQGu1dANf10IKAyAEHjgpqZJhK/CDqbQnapPQ6KcNalurmuzKmmTHKrCMiKQ==
X-Received: by 2002:a17:903:298f:b0:2d9:43f5:b462 with SMTP id d9443c01a7336-2dd2a1ce8d4mr275603645ad.5.1789326072035;
        Sun, 13 Sep 2026 12:01:12 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b7bsm36808655ad.3.2026.09.13.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:01:11 -0700 (PDT)
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
Subject: [PATCH net-next v5 10/11] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Mon, 14 Sep 2026 02:58:45 +0800
Message-ID: <20260913185849.907479-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913185849.907479-1-coiaprant@gmail.com>
References: <20260913185849.907479-1-coiaprant@gmail.com>
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

