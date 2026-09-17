Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D940EB82
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678115; cv=none; b=SPqdH1f8k+L/4HgxdFL+iNv8NgfmA9k93sKRFYazJUAQ146+eazUUdnpHnxMQDKZBwTdDpTtmqyv3L7qOeLBlc0P2MFN4K4FYUgtivAvXME4ROMl+67OWOagfnJEkXcOLZwZkKDPdezTk+TEuIPOXoG4Ia/XCCOB7aUxHUlmj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678115; c=relaxed/simple;
	bh=EAepGZi5JJgVl5A2Zgbnsm82y7MavVep4jBcaMjh1U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsRfnSi/u/v67e9FwuCnhauv7pNd0jbK7HIGaADU5h1DyLqvwiaeqIPcyEm1E5eRkszs3+9QpIMEqQBV+UCOvlssoDFvc9MNFC67uYhV9OLUnuGD4/2evyKTPRqbrZmh7ZJq6wUcXVE8qj++ReRL3AofTucMylYpN6dVAbM8nhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSxTfRF5; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSxTfRF5"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso56367a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678113; x=1790282913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IeBd/f+KYPaUD3mTxXbAK7RiokjVClr9ke91eN5DQPw=;
        b=cSxTfRF5jJcK/iay2vCUdb+L70rSeSPe+vbur13dQSQ3oKnU43EpF/gGMiGA/ZFfJM
         t2yF3ZRkFkaYYDmZbwxz7OjvkO0DpcE4K61KOJ2x/mb9zsKgr5RgqpMeTC16JcbEYbtB
         cjk3qbL09xvFSfzMSAV32ytV8vhXtz3YVN6skZcXVqqvaNHFmum+Ph/Uyi0BiZA2pFQk
         NufLHAzKW91/Myts2TXWw9+yZZZ4BGDeu/qjyeu0kxZTcHo18IMrcMIjAY/TDAo3Hf59
         6WVmDPXpdHmu488ihmbvVf7UZElUscxetKstqyfN+UpGKxeNzOGc5Qh3YQQ9Kv/RFUxU
         xu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678113; x=1790282913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IeBd/f+KYPaUD3mTxXbAK7RiokjVClr9ke91eN5DQPw=;
        b=i0a5J3qDXl/mhsSxNVKaWnNXc7sttm5auihLQdx92Du8iNtLO+i+OqemvlcVigAucU
         F3f5pE9RlllvzXOTTs+Pou1a5RaTU7HYxIiLWmkKHtLKQXyqBZVGjlrMXTq6T17pM0Go
         Tuy9OKrMNzLn/FHl5p1YF5a8Nhy31P0rzatFeKozLyqUuMmNvxe2t1vDRBuqTVxd0Fh7
         9fX13lVFK/gcfnF474gGDxUqAyNPmGTSfrbdMmgjaG8wyBfTHYf5Vq65dZnaN4P5x26R
         BhIpNmJGc52CDv01zVgi3XuSJ3yjDOd7GrMHMpaydgnCtM2NDB9lj8SDjMiWHHLetkd1
         shGQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4lks2m7GlW+GPcOuPIOs7CXEkI48xVi0YmT4vLiIRwzrvmT4ZWTRyDBEUbzNP2k0ZnNdEkvE=@vger.kernel.org
X-Gm-Message-State: AFuF++n8TI23S3zSdYw1HWOkbEK5z8p4vivwhwNAnymNg/33gIeTM5Lu
	sHxO+dC8rPsgvh4skWmC4k663W+1pTT/xlG2rr9CL+JUE75lm9nLDLwV
X-Gm-Gg: AYBFou2/unBnELdsjzhFrZvK6Qk+AoRUULXIt5+2A7WmGVZzjAFXCy6Dc/bYnQnz58z
	msk59533uJKBW3Q6obEpk9ikOIwfbqekrAuaYDB2ECqkBKdqrxGCX/lwCT6Xp8+hcgGGhFI8lwg
	F95Q7ztmvwN92/tzymPKWWhKAma/RTBpGBYcaBbkH0GqcGUkZYRrC/xQS4M1Otk1ZBguY3KotgF
	sFdKpNZ+rCBJdLC0ECDMG140jmWsDErFR7goxQ2zGsi//Dh0XmQyHXWP5LZNFrSHP8yiOZzV7Xl
	rU/lf7HIKF1Ol8TXAPJmMNBHW6zpRDf+/1jTKdw+7sQLb1jbWqgxmkkp7qGLqz0AZ2drlF4PGOR
	2cPOfAI0EvAC8AeoPklDaVDvBYy8U+tJ0E2nrk6qeMAW3ItfdFUNmoit2UfWLczErcryxPyFROm
	GYCLEnT52FNdglTNCRNRuhAIB5MJu3X9vMQdMQ/2YlqU1vtXheaK8Z0ZsqR9cUycyi4L38QA==
X-Received: by 2002:a17:90b:548d:b0:39e:4c7e:f040 with SMTP id 98e67ed59e1d1-39e54f889a8mr664123a91.29.1789678112838;
        Thu, 17 Sep 2026 13:48:32 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1232196a91.17.2026.09.17.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:48:32 -0700 (PDT)
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
Subject: [PATCH net-next v7 10/11] arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
Date: Fri, 18 Sep 2026 04:46:21 +0800
Message-ID: <20260917204624.2427486-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917204624.2427486-1-coiaprant@gmail.com>
References: <20260917204624.2427486-1-coiaprant@gmail.com>
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

