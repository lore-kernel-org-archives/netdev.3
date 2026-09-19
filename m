Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9193D668F
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822348; cv=none; b=N7EYLE+ksOIsCM/3AmfoYUigoReMH4ZZXXA7WE1WIRCAOLKlDoIr80K6XDTgbeHyvtgCfg2AcJ9yVRCfzEUxRssfc/EJtwPa9Oj5efvFj+JSgkuyyZd48XuT8wt92cF3qOrjJqd/U9wKdr73LywLabDGJ+wAO55MqfEkftaVQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822348; c=relaxed/simple;
	bh=eV/MZpigoY7eQVTxB//FZOps8t3Fw+uKiqpIed3H7yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvDalaF+qaVei38nEuaG8TKSPRpk4DnNWo9GDAbUgAbClycf6DDYPcaNrr6pOKGIIxefUTDWtRIeabhQGO+lsu2Fa/0R2AGnvrJB5kXx3EfCZyiC12nnARPkKCvsBloCOKilV9EMAB81CiNd43+nrcEuCzss1CNdH5Fsv8aH9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUdqsItY; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUdqsItY"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cc4aa027fe4so436137a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789822345; x=1790427145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg8/YZyIZ3CihMksQCv23yBYBJSGhmM45ppIsWYSP5M=;
        b=JUdqsItYxkOTyriWU7D7WZ6CQxdEWm46RV55ndGCn8SQBcI4ikwZaakIuwtOHHPC1L
         LIJosjDWY6SndrCpaOKRRzHUR/qU7KebSAe0vBbTMHfpWamdw716jCddvb/pmLr3+dub
         qT3kAPO1wjLqvOt0wEz87gl5mZ5kVOyHb+8k3eH08f9x1dDj5zBFikCF356yDyxP/L6D
         82vTR2eqBihmEl0vjN4Aqmyrqf63i8GOqWQf4ADp4hjhUGAnGhZCL1pZyzC0GlxMevew
         jz7VdrT7ndQAXFOuf5ZdkYwZVRXbPYO1hv+l9j6T6o/bNEoK+U0AQCP5gePc7bepqSpH
         ABGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789822345; x=1790427145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mg8/YZyIZ3CihMksQCv23yBYBJSGhmM45ppIsWYSP5M=;
        b=F3n/wIKKmgPbvaFjCxLhG+SiOuTRNznJAvFUMz9Ey9Z/BTpu1pYUbxmrrcTueEDQw6
         vVVyFSDFdkrHvDEV4Br6dPxRS8w63p6Em625lLYsXVBo14anb3ghaeJw4uv0xXzZp+Tx
         8w9sPXgOX/49ILq1aHRJbiJmoOLTNJpuYVl3XjufEi5Upo2alZT06LcaqZnLskWVOInZ
         WBs9TyycdpXOk9A1iVqOmrKR+BjbnibLf4gIW/Mt7vb+C5/3VqTtAo7WhX29jqgZ/vjJ
         8Nuntl5G1r3ldyB4TzOKJV5ZDjSAZ1eaBHFFvJfoCx6bJJVKzpSI5eVTfaiGyFtsipsd
         R8Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxkJoxyOXYJQwKh0BLfGPeZ2R/V2Qfp3R2QJGcJCpAVlmYGjCzrfEBmfwiUd3K5ZQOKj4Foe24=@vger.kernel.org
X-Gm-Message-State: AFuF++nSBlEyeSI/uPEsGI//a6Klt29cC2MvwNSpLku9zmfd5HGbYlll
	zDvdmLJVJ63HIBrKuNdjoU8K16KeSAcRQsIEAtzK+Ar2hgjIUZ2BQpfu
X-Gm-Gg: AYBFou2bhkCB7VRemcv5OCViOwE4/2t5ial/i0n3anh9C/em+JiJtL1K+L5Orm3BTi9
	DenjhI+grKknE4V7Z3YPY2kMfTUDjTt3tKZtqrYooJnPpFmEAz8T8MD66hUCFYKKS8C980rtg40
	8zE3rzYEwa57rxOhyFSbp1NCY3CFxS/yKBhGmDuyMWIbeRWzHJ1Xun9LbSV8tt+rt57fSfPGmqj
	swRlVwKMRn7Zf2jv3tXz6e22YQ7DwLOvCPDg5bCrB2Q7Hwm6vekkeQmpcV5/CBvX6L2sCJh47PU
	P+rngBM2sYtEPsG6HU4dVrCSQPxDqiksIp0agEv/9rNe8N4vqdlIeSDQjNjfFqwX3yTs0hgAwM7
	Tfd+Z1Shffhqk/Y5gm+aYz0tDgE5wVtDMWfl0Jf4vfVdXAefrEbZBbprZ4kBskE445+2QNC4ZON
	S+naz1CFAHVK801XJqHHCP1kq7Lcc6gCCdaQq6pdiKI4rgDZ5FPh0qr0j51kUlkYAZEpDEAw==
X-Received: by 2002:a05:6a00:148a:b0:878:34d7:69b0 with SMTP id d2e1a72fcca58-87834d76faamr1660285b3a.55.1789822344779;
        Sat, 19 Sep 2026 05:52:24 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa0026b2sm991805b3a.44.2026.09.19.05.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:52:23 -0700 (PDT)
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
Subject: [PATCH net-next v8 05/11] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
Date: Sat, 19 Sep 2026 20:51:12 +0800
Message-ID: <20260919125119.2107089-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919125119.2107089-1-coiaprant@gmail.com>
References: <20260919125119.2107089-1-coiaprant@gmail.com>
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

