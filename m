Received: from mail-pz2-f2.google.com (mail-pz2-f2.google.com [74.125.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B642415F06
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274975; cv=none; b=OlHVYp8lQMAe8ht0RbFaP+agARlHURTXxC+xWc+z4+ex83n4ad8AjtLA82q4lGHp7sQasdCocPir91xaGezty/i1/1JJpveVaTqsmW2fXomtPDj4XlpGI30mZz7gpXIoeTvSM07IqWKbJ6PpfaJZgYLBDpQv7IK3tQf2/tHWE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274975; c=relaxed/simple;
	bh=A5WWFF/meLRT9K96dBTf7EzhnS37KtSW6R5N30B3Ssw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK6BVQKXe9TCOwSsrylYHIg0/dZyOEinNyuSGsUUd8ZYRHNWGxtTDiadDPAcLJlDvDRD9yCT4VGn5dimC1MTPTl9OBK78aBsg9B0Ah0VjCJ9Y9oeWoPtDLxe9ykN8gTQiln4ZFQ5kjmzyqMA+Lnf+uzxMNtLUc06C/wksGN7CFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYn+MPpa; arc=none smtp.client-ip=74.125.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYn+MPpa"
Received: by mail-pz2-f2.google.com with SMTP id 41be03b00d2f7-cc1bf4744e6so2319022a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274973; x=1788879773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/ufsj+YTp5B4a6XdY0sQWUkJ+NQSUpM6CSLQJOVS40=;
        b=RYn+MPpaRnU+UI8/JU4pkHEQGaS/T0CaF+kGuANe0jv8pi6MeaoiTfXR1c+eai2Vwt
         V4fT5/HkYVUeWAYdubgRNxvHcn7Oj2qH0+OZPdp9k4J8FGxhNHTtXGAADHna7GSCkavd
         NafG3564BX1VIw5VelUjMctuAHFDZMsGkleDWm4G5yb8X3lHHg1bMM+YHx1pinqjANoU
         9y2e7BErJWLRQQ1J9Svzef6oaMD/troO58sRhMm9TcGFa57CpMu+lUUxCCHRkdr2hBTZ
         AuYfVErHto1dZ3uTGEQ4isylKPLw7N8DTT4+QpFSIFVMGkeOpfTTzyt6k0B6ryjCnb24
         DRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274973; x=1788879773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/ufsj+YTp5B4a6XdY0sQWUkJ+NQSUpM6CSLQJOVS40=;
        b=r7Iz1+raZ3r28EwLQzRMzefTCwETQqFucI1F7jfCEmgKybLRJJFlsu1XQ/vr4typ7d
         qEfhxay9s/7KSuwTMybwYiDZMK6iBXXoXkBmMAmkcDqGbI+z7uM3ZcCpgVHfCzVgEaYA
         qwNqacxmOnfVAi/9OPJZj/cywJ+Ppc1Ce+VUBLme5zGvyoFknJ4juHPRG/5Q5yWdbNIx
         lPbHA9CWHMoX56Dk+eB1qBBrv817SHEcKMkhBfuwm0byXAaWaOLT5QRu3wjGXpcrIn15
         +kly2wbo1UYSZ/+iha9Hyq7f8nnyF8d7SMm3CkD2mW5+ieiGaKI0VRHi0fIOaawf/wyT
         F1Mg==
X-Forwarded-Encrypted: i=1; AHgh+RrjdMqVz3sawuAWN5Ga+PkhOMdzWGuahxz0o2ZjJv/nMPpkgdxVZIps7FBnVsTxmZCu4Da1wEY=@vger.kernel.org
X-Gm-Message-State: AFuF++nxYCRmHdZEXMeYvBEkewn/fBAYTEEeQpRR9BKDyWKqb79ILI78
	hDNKrWPhSD+xO/qRj/KBExGjhSX/3GvVZfsF5SX2xi72DC4CaZm5kxy+
X-Gm-Gg: AR+sD10HYpGtlFrwCzdU2KsnCU0NY9to6pm7j/Cx8OAmp/JR4lKXZwNSC6PM5uzW+Y9
	wPQjngPXY8fjOlg8MprJvA6Us1u11PCR4gENX/5xDCw46XAZy6H+q5LCIfbhc6lnBmhdegGprYA
	Huw7Ym2bSCHwxfMmB6LT9YnakQk7i3KgC/B59ses2UO2O+iToXYJbNHe3jJxiJqxCqjJbEdw5w4
	jB0j+jaOeDVicP3KopC2I8r0dpga89GeELRiUuKn3a+u6rjGFM072IadRUSVHrQ+An05t17UoYU
	rkPrnN9MKi/LTkNidDf+eYLbtYiC59J1mrg8NBiHs3l+XLUo1/Xqmdu3Wcm321Fyv0MAygFdSNm
	asQspFDk25erB4QcSx/fcukd9hKuOZ2AY9fqodqxElbtZ3y0ViNZ70awHjcB4+TGTKUorAfIaTu
	N4Nznma+Hx3tvfF5JVmX/zEVxwh0HmtuyD9azPxN9s53yo1a3chwwstpMARko=
X-Received: by 2002:a05:6a00:4187:b0:851:b03a:fcb with SMTP id d2e1a72fcca58-85629543442mr61618818b3a.14.1788274968953;
        Tue, 01 Sep 2026 08:02:48 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:02:47 -0700 (PDT)
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
Subject: [PATCH net-next v3 05/10] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
Date: Tue,  1 Sep 2026 23:01:05 +0800
Message-ID: <20260901150111.141037-6-coiaprant@gmail.com>
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

The RK3568 SoC integrates a Synopsys DesignWare XPCS that provides
the Physical Coding Sublayer for 1000BASE-X, SGMII, and QSGMII
interfaces via its four MII ports.  Add the XPCS device node and
its pcs-mii sub-nodes to the SoC device tree.

The XPCS device is accessed via the APB3 bus at 0xfda00000 and
requires the CSR clock (PCLK_XPCS) for register access and the EEE
clock (CLK_XPCS_EEE) for Energy Efficient Ethernet operation.  The
PD_PIPE power domain must be enabled before any register access.

Also add two fixed-clock nodes (xpcs_gmac0_clk and xpcs_gmac1_clk)
providing the 125 MHz reference clock for the GMACs when operating
with XPCS.  These clocks are used as the assigned-clock-parents
for the respective GMAC nodes in board-level device trees.

The XPCS node and its pcs-mii sub-nodes are disabled by default and
must be enabled at the board level when 1000BASE-X/SGMII/QSGMII is
in use.  The fixed-clock nodes are always present and do not have a
status property, as they are static clock sources.

The XPCS node also requires a reference to the appropriate Naneng
Combo PHY via the phys property at the board level.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 3bc653f027f1f..989e164c0eb39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -110,6 +110,51 @@ sata0: sata@fc000000 {
 		status = "disabled";
 	};
 
+	xpcs: pcs@fda00000 {
+		compatible = "rockchip,rk3568-xpcs";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0xfda00000 0x0 0x200000>;
+		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
+		clock-names = "csr", "eee";
+		power-domains = <&power RK3568_PD_PIPE>;
+		status = "disabled";
+
+		xpcs_mii0: pcs-mii@0 {
+			reg = <0>;
+			status = "disabled";
+		};
+
+		xpcs_mii1: pcs-mii@1 {
+			reg = <1>;
+			status = "disabled";
+		};
+
+		xpcs_mii2: pcs-mii@2 {
+			reg = <2>;
+			status = "disabled";
+		};
+
+		xpcs_mii3: pcs-mii@3 {
+			reg = <3>;
+			status = "disabled";
+		};
+	};
+
+	xpcs_gmac0_clk: xpcs-gmac0-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clk_gmac0_xpcs_mii";
+		#clock-cells = <0>;
+	};
+
+	xpcs_gmac1_clk: xpcs-gmac1-clock {
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

