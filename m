Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F122D739C
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326053; cv=none; b=MQp6baEtPrGW+apPVeRZDLP82t9YqXirSxrmLykJT56uQxQSrbPUuKEEyREjrUT2gMK7/+Q9NbaNyd2hS0dQxlDWY2t/hiBBhghvBE2/iGRlyNDA/XDZii6I872y9JSmwiOSHqSyq3N77SQC3FOknYXZVhliispEUr0Sw8Xa3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326053; c=relaxed/simple;
	bh=q7Sl/MMSPIpc6WmMgm64X4BAPmv2q5e4+Iz3zCyG3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l04HNiKQI83MUDSOy1TsSeKJkSsDkX2C2K94MXmMWrXRG0pBTY7juIIglEpejjw7WV85uvgbtcRoMwEAGhCbWaEO6baKRK/RmVuA8u/eIJfx2pXwOY5rGs/temiNHnfgr+lPhVrKR2ZWBiigHQphDcLcCd5QN8Qf32EXcZlUMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEpLzs2k; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEpLzs2k"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso9781895ad.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326023; x=1789930823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=af5XJnE7hcWtAkVsrU4T0JVcIxPb3Aa/NhPJOVNgxm8=;
        b=AEpLzs2kZShzq2Cmy3quhj8Ov8qpGWbON5B6xIIi/KL73ZzNJs5AKAB3PP2lhH28v2
         LKsgnnQD+fLWFV5OXMg70deCcgaAwQyX6MzWZXtueKdhQ8+L1x6L/TTplzJ+6YwvhwjK
         2wybRVYV+eKHWc3DKbO1kzBt6HobTWcXfcJKAJwRwbNxN8paVlugd+Or/YsCa5xLXZDZ
         tipAkS+H7WNkJK0i+qC72elLN3j4pt5m00F3A+SN7ehXDS1DMsABC63fTTvjznWGy83y
         GewltVnjYHqaTTcLBhluPM4eihtlSGfmjnwZrbnT3O/XdOCBy3w180xwf+sszo/i0YWH
         NbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326023; x=1789930823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=af5XJnE7hcWtAkVsrU4T0JVcIxPb3Aa/NhPJOVNgxm8=;
        b=YYGepkDXCfVl7QnJ9VAZEgd4/Y7AVBrRqWBDPL/n/nHBx05tyyDsm7ATIeGhnPefAV
         Dh07h6Q7r40vvgLYU1+Dek8G5ojFYM36V6aFnSIgHSwnoaVM5ZSCvmUkhAKydIuQbVlK
         2OLEvO0ZydlvCx3ZHrGjV1vrDs10cE5F/gxioRove7dQCCM85aIw4SApO0fScptLzqzc
         jVI3NqPtZLej5PxT5cQozxy80p9scEq8Dk+QZbKcChYAGpDDIlrDXPtXrmWqLXvl9qM0
         2/i8lGuzVC29V2TyLi4wRj+eoLbnh2lagIaW9Eh5ohC1OywBSMZkJ9jKvzo6IHQnLS7J
         efdA==
X-Forwarded-Encrypted: i=1; AKwUvBx0EcDxIAd5K3Dw0ApqQSO1AhnrZogV5rWZXLU+A2zRb5CeAes2X1d+RCY7Q8ajUzdbIIrW6c4=@vger.kernel.org
X-Gm-Message-State: AFuF++lxUn0FVSxzQc/pzGIIys2xKiEkDnzMlO8U2t8g4BIUkAzyl7SO
	ldjBH0fRxpPFWmpwRhkDgBFzaV/HFHQv6WjvqSb05IOGKddN1ordwJDD
X-Gm-Gg: AYBFou1rLzjail6EU0CxV5FhWOojmqD/l8vChimcRCode8zUI5WdFpLddGTf1Dc7Mdb
	QXC45Rs6JmHYeaPcqajXXqgpfeoPDS5ikK9EmhOATXubR8H7UOny70hfUoMLelTsHWNfmFGRdFa
	g9NiVi7wtVL66Z9u8S4XK7pvcl3yxnvlZEBR3Dk+Fs93lOPqZ6Q89q/7c/E2a/1oPmHFiKumdoV
	li16caC3hBmKsTkuqcDLMf1pZ/coia+ByP0TfynBxRQoXSeaCxbYOm1Ky52VkEN+/k6hHaNnndn
	rS36duS0FBu1QHip7vJ70ovSvVpHpslWMp3L25MILdEKEM1mcOssUKdE9itEgVcfC0SAXGpKmsw
	oL5kfAm1DYaipyxJnPTXunIYJ473IVFmsH/iKMMbK78oKdHxhDNS085fX77og11OSBGVJBn34Ju
	iF0l8qp3AXQd/J1njQ6gRhyBcd6l/3AlCXlgvNb+zAQfNUb1gZ7IJ96uKCT6i0b38g4172sA==
X-Received: by 2002:a17:903:98f:b0:2d9:26b3:547 with SMTP id d9443c01a7336-2dd2a46f4cfmr250162755ad.20.1789326022854;
        Sun, 13 Sep 2026 12:00:22 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b7bsm36808655ad.3.2026.09.13.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:00:19 -0700 (PDT)
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
Subject: [PATCH net-next v5 05/11] arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
Date: Mon, 14 Sep 2026 02:58:40 +0800
Message-ID: <20260913185849.907479-6-coiaprant@gmail.com>
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

