Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635D3793AC;
	Mon,  3 Aug 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752127; cv=none; b=ZCSU1pmw/JSVH6xORP02tOK0x96bZiN6B9o8PUeTki+zwpkQCYDcSzvgIJtskWm5j24FY5O2gn0A3a0f5HjzA6TOt7AQwXpnWmFLAURkeIZ+sLj2ZzFxCOr1ziQieGtkCgL39ky5PNnBUuNSNRfSulh0bcPfP75H8Fasmgbo6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752127; c=relaxed/simple;
	bh=VqSq/RFgnYRFkrdByzSG0050K4hOTZSeg3klIsefLjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy33c9G1KEQx1XoMUsdNMvsY/h5Y10vPw6RLPPjj8m9UxUKM8djru+xpv+GZ8+CA1My+oZARoLSsCLBKeO3L12xKwVfl4Lckkogsdga8CepP+PNVmDF+DvJAQ4pl+LQgH0pV6ngEibQe3AhYjHq+4AyGYTNUB/vsBIlic20KdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k8rZGnfZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k8rZGnfZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC4F7165C;
	Mon,  3 Aug 2026 03:15:21 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55AC93F632;
	Mon,  3 Aug 2026 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785752125; bh=VqSq/RFgnYRFkrdByzSG0050K4hOTZSeg3klIsefLjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8rZGnfZxZfbkexDhrnLAo1lZg5wso/9INZUYurtRxpRj7B8bPg6xTk8nzMWCBSaF
	 9Zw1t9V4MSO7PN7u5CcloZo0nKDfp54uLwByTmOZWJ/SUqdGzWx2BoFWbjlCBc/6hr
	 uGWf8cAnHL7Hfb+DTP6ePo02wG0GlE7l/0lOOqRo=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Liu Changjie <liucj1228@outlook.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable Ethernet support
Date: Mon,  3 Aug 2026 12:14:52 +0200
Message-ID: <20260803101452.2993721-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101452.2993721-1-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X96QPro+ TV Box features a Gigabit Ethernet capable port, which is
driven by the secondary EMAC, and supported by a Maxio MAE0621A PHY.

Add the required devicetree nodes to enable that port.

The PHY is not clocked by an external crystal oscillator, but relies on a
SoC-provided clock fanout pin for its 25 MHz reference input clock. The
clock is referenced in the PHY DT node, which not all systems might enable
before scanning the MDIO bus. To help with that problem, the PHY compatible
string is using the PHY ID, which means the MDIO bus scanning can be
skipped.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../dts/allwinner/sun55i-h728-x96qpro+.dts    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
index a96927fbdadd..568a4fae84df 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
@@ -13,6 +13,7 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac1;
 	};
 
 	chosen {
@@ -54,11 +55,38 @@ &ehci1 {
 	status = "okay";
 };
 
+&gmac1 {
+	clocks = <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_cldo3>;
+
+	tx-internal-delay-ps = <200>;
+	rx-internal-delay-ps = <500>;
+
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&reg_dcdc2>;
 	status = "okay";
 };
 
+&mdio1 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-id7b74.4411";
+		reg = <1>;
+		clocks = <&ccu CLK_EMAC1_25M>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ephy_25m_pin>;
+		reset-gpios = <&pio 9 16 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <150000>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
-- 
2.43.0

