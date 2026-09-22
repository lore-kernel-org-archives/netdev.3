Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88B4BE450
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107483; cv=none; b=fFLSeq0TH0B/FtL6HDEFf6uLoUpu5wYeG3MbavRpTYGiE9Rdu9FYkkWPn1yphSLv0D+VaiTAUdqbLiKXMq5IvNXdnYLlliK+F0hYdr4Rb9600Huxeu1KZ/AoZY4LaIeSKz+EqLp+HxwmHGA6aW44L0MzNKLI0v0/99wPSAExZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107483; c=relaxed/simple;
	bh=xsSc6ydPheU6yQKTsn8eVtJAu8IiKQ9vJAoJqkKw3sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr7rZC5NqM46Qf0jIXe32QZFWkD4J5OQWkrYZtpK0EKdrWZ7CssLjeu/6WNUMzvG9kNXnXIRAJGoxjyVcM1H+1zYRkZUcLwwlqj+RhGqWotgNvsryE0IZ+6L+zl+gb8yzYXHTWMBiTiuGyGR/Eq6Xdj5tjAzL6YpgGzsx2fg6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOeRIH6g; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOeRIH6g"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d903e972efso1029005ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107466; x=1790712266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIbZ2Qb+jhg9YxUorYRFCm5h/dMc9oDQD6qvJFZg4XI=;
        b=aOeRIH6gNBwyXu7l5Z7cO83FPF3dKeNG2iYUnz4jNWJ+QrtDFFr1SywQRo4Im44NAd
         jV6snxM7C3DUvwoaIcpczNOg0FkwRM9QqaCceb+M20bu+xstqgWUWFof33epYjOkUPt5
         arxga6ZgJoiM8ETG4kbK5wsBHpmmgGAomKI2h6kp6zeX64cjJTbyE15Fx64hK9+p/O0z
         UQlJSVkLF4NK1tWhL9v4eWPrwGVUAo8gP0jhacLug1Z7hNBPp+hWA4xdn4jlHKCEMvzf
         uwv6WuxINhUXD6hfD+Ve+VZorPK38h2wz+KyYIwCT8cvKyuKvW7943TuNJCF54CADEQ3
         7LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107466; x=1790712266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIbZ2Qb+jhg9YxUorYRFCm5h/dMc9oDQD6qvJFZg4XI=;
        b=OQfCXfl1Y/kRFlPM91gFyutTur4BkIDznfCaCX/BEXO7g4gQidC6hwsiUHErRksxvB
         Fo//A8emEJSOv1ClvNmEqLCfgrH3Tp+oBI5nUPp0IqQlY7JIf/rwpQi9XWuT3G/r6JnE
         pzkIFYccGhVOp2gzSQoyO6YPYV212ykI6pmIi4jNq+icI947dqtoMo6k0AnzGseqmZiv
         Mu2wCAcsJ7gGmiCbBEegmVvLwWKbp0s6vA5YoEhbWa0ItER9tuxaDHq62VXh13vn+JSI
         hTpI6uc2Xuu6B4rBLLCCMAVpEaaGXrEWRvnJT5dRjKbLAF825l6kHDchbbrS4FgtHtLQ
         ri8w==
X-Forwarded-Encrypted: i=1; AKwUvBxz8kln4rhR5qMkhjkBG/qKpphYzLrmCD/aIJ21nseAKGIGmDLrRSFtPMny3GTQ9wwir8ZKLws=@vger.kernel.org
X-Gm-Message-State: AFuF++kRpLT6wemwJFrYybSBSXDE1z8lpTxQ7gaNYZPzimMTi/LHcE3d
	R+G/7UGPfkHog0gfSYtgZ//dO338PckAYDtswCrmsq55ec1+w0pfUjLC
X-Gm-Gg: AYBFou0Rf5EYXpbTXDJzemvX/KDl0k5Ttp3GZoYWTymQt6YiHQBoLnWPjxrWnzAuvzh
	QTHhhYvpo/jMHFs5NWKmPtTW80hEQ7PukgZXMrmULtfeoYLRIrbBcPk05AnI+GKgRxnnZDcFjKg
	E3lICFrlF4L2IfJjdq6yYXA0XxIh1KYxjSbZiwYIhuFDgFsQieIujMK6uX1GhP5qgCLIq8GRxK2
	1YO51DOukDbiYT6ba3YGjjnjVmW/S/2prmJvzLCeOU+YTDvMXQtYhRD6gCVG7hbiA+8qKe9BIWe
	3SuQ3Yb53cAqbUBwmrgAlPNMWItf1GRzW1eEn8UY/ZV9p0LFkzTsBMiS5pBQqcEDIO+ml5yv5NM
	SAPD/t+v5Fw20Y3f51+rQ2sdCjiyhPkiLF6VW2FtLiUHirlnSuw9WH3UwiItG7KfslICuFnP5Ik
	1CzWOV8QDda/8NFh6/g84tjxgE01lsRNrGl+WVZwkTkk/zZZN/WYfY6fqFsf+pz44qNrYUYLxxx
	QpnXaA=
X-Received: by 2002:a17:903:3245:b0:2d9:438e:b70d with SMTP id d9443c01a7336-2df69d0cfd9mr4017475ad.1.1790107465799;
        Tue, 22 Sep 2026 13:04:25 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:04:25 -0700 (PDT)
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
Subject: [PATCH net-next v10 05/11] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
Date: Wed, 23 Sep 2026 04:03:29 +0800
Message-ID: <20260922200336.2201212-6-coiaprant@gmail.com>
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

The RK3568 SoC integrates a Synopsys DesignWare XPCS that provides
the Physical Coding Sublayer for 1000BASE-X, SGMII, and QSGMII
interfaces via its four MII ports.  Add the XPCS device node and
its pcs-mii sub-nodes to the SoC device tree.

The XPCS device is accessed via the APB3 bus at 0xfda00000 and
requires the CSR clock (PCLK_XPCS) for register access and the EEE
clock (CLK_XPCS_EEE) for Energy Efficient Ethernet operation.  The
PD_PIPE power domain must be enabled before any register access.

Also add two fixed-clock nodes (clock-xpcs-gmac0 and clock-xpcs-gmac1,
labelled clk_gmac0_xpcs_mii and clk_gmac1_xpcs_mii) providing the
125 MHz reference clock for the GMACs when operating with XPCS.  Their
clock-output-names match the CRU mux parent names in clk-rk3568.c, so
boards can reparent SCLK_GMAC0_RX_TX / SCLK_GMAC1_RX_TX through
assigned-clock-parents.

The XPCS node and its mii sub-nodes are disabled by default and
must be enabled at the board level when 1000BASE-X/SGMII/QSGMII is
in use.  The fixed-clock nodes are always present and do not have a
status property, as they are static clock sources.

The XPCS node requires a reference to the appropriate Naneng Combo PHY
via the phys property.  dtbs_check only validates required properties
for enabled nodes, so the SoC dtsi does not provide phys/phy-names:
boards that enable the XPCS must supply them, since the SerDes link is
a board-level design choice (combphy1 on some boards, combphy2 on
others).

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 3bc653f027f1f..2cea108b31a4e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -8,6 +8,20 @@
 / {
 	compatible = "rockchip,rk3568";
 
+	clk_gmac0_xpcs_mii: clock-xpcs-gmac0 {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_gmac0_xpcs_mii";
+		#clock-cells = <0>;
+	};
+
+	clk_gmac1_xpcs_mii: clock-xpcs-gmac1 {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_gmac1_xpcs_mii";
+		#clock-cells = <0>;
+	};
+
 	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
@@ -110,6 +124,37 @@ sata0: sata@fc000000 {
 		status = "disabled";
 	};
 
+	xpcs: ethernet-pcs@fda00000 {
+		compatible = "rockchip,rk3568-xpcs";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0xfda00000 0x0 0x200000>;
+		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
+		clock-names = "csr", "eee";
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+
+		xpcs_mii0: ethernet-pcs-mii@0 {
+			reg = <0>;
+			status = "disabled";
+		};
+
+		xpcs_mii1: ethernet-pcs-mii@1 {
+			reg = <1>;
+			status = "disabled";
+		};
+
+		xpcs_mii2: ethernet-pcs-mii@2 {
+			reg = <2>;
+			status = "disabled";
+		};
+
+		xpcs_mii3: ethernet-pcs-mii@3 {
+			reg = <3>;
+			status = "disabled";
+		};
+	};
+
 	pipe_phy_grf0: syscon@fdc70000 {
 		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
 		reg = <0x0 0xfdc70000 0x0 0x1000>;
-- 
2.47.3

