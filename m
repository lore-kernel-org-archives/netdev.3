Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAEC3C456B
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923774; cv=none; b=DXmohWMvT5cEsqV9obW07RgWmbTucMyQvotNtSCq0oPYQbn18QiPWpY5j4B9mymGuZfhyBVzEu7f8JsF0tx/WGS6oqWDtXWPEAlfMgrBPBIQRUZrh8CWm8aOIc2hHZEG+jBXtriyBOQCKa2yDOk8zhanCUU9BX3qnatAmVEN/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923774; c=relaxed/simple;
	bh=eV/MZpigoY7eQVTxB//FZOps8t3Fw+uKiqpIed3H7yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFiFZIGNis62BMzm+1rYhkDo6laS8vIzD8qQzoOIAB4Gb/+ryjdSI+ubFXMInWs4y/ktEWJx1UEFxbB9Nl1nN6dKA2zwg+Fg7ZRRrsOxsJvX+5C+LwhtwlvZtkmpof1xy0j3FqJRlRfzq/akJILZuipHLsUYvTcuHj6tMnTR2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYM0e5TZ; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYM0e5TZ"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc53988d9f3so1289062a12.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923771; x=1790528571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg8/YZyIZ3CihMksQCv23yBYBJSGhmM45ppIsWYSP5M=;
        b=CYM0e5TZCVwoa98/M0TqxxKHtvDo8BA7FhxiJHWSXK66zGBba08pLcOtGzeLuelziS
         s3TUYmlAuM37Lr823h/A3VzOWlN7/QgDjvg2Hdn8MIrWuPzd1lWqLxfTBvsmhXNWG5at
         s1Jz09oRT7TvWHy1UPaCNvH6/BvRMs4dcuqO1DraEiB4PQBAqiFpm6g5YhfV8h8TNNXI
         3vm7dlFlWtDiKuuzwkJEBbuXQURjYQEkvm7qkBtburV5QewwV2JgjEwgiV5UhCse4Qwt
         h5jPkB7fR9bsVo7IeZjqzqyTYBSoFLDzxBZb+uuCGchEWZyqrFS5+qvQCo+QhA+eCuXB
         wkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923771; x=1790528571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mg8/YZyIZ3CihMksQCv23yBYBJSGhmM45ppIsWYSP5M=;
        b=B5KQghmZxx8U58uODuo5Eo5Zvyt41PC8Ff2NKKoW8dmuoGWG4HlGup7NZrYpA+XI4p
         wqewo/FEjX7qEr5ulHCfYTUNESC9y8kNJ2oArTje/OS97+wZB5QjZSyYj4WRP8BoWPuC
         5MRTh5q5Vlz5dkIvedzV9Wr3g4YES1cOgvZHOrKpVgpjMj4zwa4zOILLE8v4rq19OLHl
         5uHMEhrG4y6kWxu9FTuoQH6FcQamXhAJ9fwrShCr3tsRmi2QqHDGWNdLNGTDECqHRBx3
         fBbOAvZ49WGPbFIZSs4O2oTqz1UwOQVMmt5N9QLqJDBNmvenVsL3I0JUXLuNSONQ6ILZ
         CHKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZkLPxP0JPTH3/HJr5Rh+PqbbavsYSuQfNNJt0ernjuvcib+vHUHgytXQGQaIdnBolwSwUPMw=@vger.kernel.org
X-Gm-Message-State: AFuF++lJyweg06gKiygpiz3ExoQyU4sJSIeQUpNtJaf0dgqMUbo3uhMP
	lG/shua7C2zAtpB4yZM+l4ovdFaE/k3I6fM6yERdKANfqdO2+WjyL8Xk
X-Gm-Gg: AYBFou2m9DwbcKcEW6kDxX4dETwQdrLC7qmlNMnYZL39Ji91wXvI71QHhD7E5WYaH+z
	ElzQ1PljW3rEcqw2iUpXCQWxpa17HP8/29zJEPBRg3/8kgSByYe5o5e/6ekX1iD3N/8Le3u/2qr
	nT8wkq+d1B3QvP6sQbCetso+aiJ+9oJvT/dck8A/PAe8sbX4bSo10Y4SZvI7wi7E38NiHArXW8X
	r5LD56q4k7zpGjWtZM9xwYwXkUpsePm7lEpq9HbcDFuT8gPxOndY/uoz13RPCrGi7XJ866udt8W
	PAC8W8k5ljRoAhNS8QrFhrLUhKHyPIOL7LBGkOXZUvwfou95kunXM5CZmi4UWWhBKq9eTMTmVoL
	Ct539RqFwHzS7nniSUbsCAh9MPmDlIstngXFGO5b02CCSLh/sUDzEJZIv+1fm2kO1hTQg1yixjK
	Lyc/q/jcLCi2vv6rQN1XH+hdF16FonZzalVXcH77ElrSHHPvk2FMqQxVhA2ctDxkMNzZ8W7eqgq
	s/L7m/D
X-Received: by 2002:a05:6a00:1ca2:b0:851:8baf:5b26 with SMTP id d2e1a72fcca58-874dc5eb6b5mr12081998b3a.14.1789923771468;
        Sun, 20 Sep 2026 10:02:51 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:02:50 -0700 (PDT)
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
Subject: [PATCH net-next v9 05/11] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
Date: Mon, 21 Sep 2026 01:01:09 +0800
Message-ID: <20260920170116.3624104-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920170116.3624104-1-coiaprant@gmail.com>
References: <20260920170116.3624104-1-coiaprant@gmail.com>
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
index 3bc653f027f1f..227d03e336043 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -110,6 +110,51 @@ sata0: sata@fc000000 {
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
 	pipe_phy_grf0: syscon@fdc70000 {
 		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
 		reg = <0x0 0xfdc70000 0x0 0x1000>;
-- 
2.47.3

