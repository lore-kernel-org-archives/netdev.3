Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E45411A17
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629957; cv=none; b=MbqvXNtyPjRVvDfaDefnLlZa+0zORfI3IZ9XfeWfcIhz2SClAPhOezYAf73rruIZVOEKZBHhpc3aFlLa3dvR79DBBCTkVhFcq43UU/iBSjCUX+gOMABRKC989D6C1UvnKvJqVOOhmMYv1rcxF7NYlZqmnDCZhPdLgz5SrxMpjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629957; c=relaxed/simple;
	bh=E50djWjs9HzrIwMAPSAgWNboiugZf7l9Qt9MucnhH9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6IeRJ8sEoJpForQ0wtM6lpWnMV+imoQpGohE0HDbblCO0PV+/vBDfoAv9TVz7B71fRcBaiQPNdnbSH9y1fIq50PN/tYRoV+OyZem4BS9ZQrjZrwZNUsm59to1pRMZwyoJr7NVVSJ0I2HqTXirQbAZ8oFW5GhNbQg9ZV6DS86GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4649b35bso447261f8f.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 03:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629950; x=1792234750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElpMWQpElxyvYVfod7vt+zc/cJPBYXPVQKctc5VqWXw=;
        b=0auntrcI2fKBOfmoKj+kIygGWLIWJ96jtWCqV/Ezc/lZK4cy8XTVPPWhg30Stz5ai7
         0YeGeDF+5o7DXNm0kxjERLdSsoJxcPxM4j2Cdr8VApoL6PzjQrVXiGoCffRPRzrvEClM
         o7P6/0oduRopA+9mVQZy196e8pqylXr2h90KGILLGtMZa8KkSoGdk+Ie55XISLrFVRQ1
         pmthfDfGoqPdxKcPf/LclJHCMV6XqQYC5imJDPAt5jElyt25SGt5rS/etRarrUxfxglI
         Lakuz4tb4PIi340nyzkG2X9cfCV2PLHOguV/fOpvx/vvWDpsaJPydWuYv0ECbX/he5h6
         BiOw==
X-Gm-Message-State: AFq9FYIRM+TuBBwDalsKUYdEA2stzd+qX1n3PPnvdzZAZ4BPLzDfpgYX
	JKv8mEvPlPZTHfUpx4RC31OLG4R4i8ACWv1dtCSLBE+C9YEFYw64kx3J
X-Gm-Gg: AYBFou2XjNjJBBHWN0pqFqTgwx16s1vtB9Ivhun2J9uwULOeWhqHc5Qhfju7eg155UJ
	dXrEx7TptJIysotjx6ikDrzFyKO+DVQ49mRGiFzX1ECzUdqWpBDQgSoLTYxXJC3CkdzfmInpl+B
	1Kez9W018EC0i3N6maGs6O2C+Td7+UDOElUAYx2N0R/7gZoFaNwxy26OyRUe2SUQqgVbWhSPQiR
	5bAKKI4vs8kQePRoBJCnQbJi7Y/BwOOZB6V9EzTfWLFmBL/rSFrqgktFEEnsu0A/FY+dtP6q3ff
	peA1ZaZm1ewl90C28xKd3CgxGTtjIPI9UMUzl9GUFS7pfYFR6jJreAbeEL1/2McgICesktCvwav
	zJN9ciKnbVsNrDJ4iL7gV7ti38Inz20Ca4uHncpf7BsxZ/z0J/8VCEMhjkm5a59nsmn55txBZ6f
	REpvBST7Ng5OF3NmIlqWaoN/6UOBs9cJFLzNTY04OMsj9bGfaqgLfy2bf4tHtLNCE+hV8+KAW4A
	LsvNzOQrv95joX0fK/kmf2nIi1obTZ7F/Q=
X-Received: by 2002:adf:e011:0:20b0:488:57ad:d5c8 with SMTP id ffacd0b85a97d-48dba787c28mr6104337f8f.3.1791629950054;
        Sat, 10 Oct 2026 03:59:10 -0700 (PDT)
Received: from threads.localdomain ([84.70.176.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm8709526f8f.57.2026.10.10.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:59:09 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] arm64: dts: amlogic: t7: add the ethernet controller
Date: Sat, 10 Oct 2026 11:58:58 +0100
Message-ID: <20261010105900.247342-7-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010105900.247342-1-tanure@linux.com>
References: <20261010105900.247342-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC has a Synopsys gigabit MAC, glue registers for the interface
type and clock timing, and a multiplexer that points the management bus
at the on-chip 100M PHY or the external pins. None of it was described.

The controller reaches memory through a pipeline stage with its own
gate that nothing else claims, so it is switched off as unused.
The glue registers share a clock with the multiplexer, which probes
only after the controller has programmed them: unless the controller
holds that clock itself, the writes are lost and the port keeps the
bootloader's delays.

The on-chip PHY follows the G12A; no board in tree uses it, so it is
untested. It stays disabled for boards to enable.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 7bd53ec16607..94ea22514501 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -250,6 +250,33 @@ gic: interrupt-controller@fff01000 {
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		ethmac: ethernet@fdc00000 {
+			compatible = "amlogic,t7-dwmac",
+				     "snps,dwmac-5.10a",
+				     "snps,dwmac";
+			reg = <0x0 0xfdc00000 0x0 0x10000>,
+			      <0x0 0xfe024000 0x0 0x8>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clkc_periphs CLKID_SYS_ETH>,
+				 <&scmi_clk CLKID_FCLK_DIV2>,
+				 <&mpll CLKID_MPLL2>,
+				 <&clkc_periphs CLKID_SYS_AMPIPE_ETH>,
+				 <&clkc_periphs CLKID_SYS_ETHPHY>;
+			clock-names = "stmmaceth", "clkin0", "clkin1", "pipeline",
+				      "pclk";
+			power-domains = <&pwrc PWRC_T7_ETH_ID>;
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
+			status = "disabled";
+
+			mdio0: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		apb4: bus@fe000000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xfe000000 0x0 0x480000>;
@@ -645,6 +672,37 @@ gpio_intc: interrupt-controller@4080 {
 					<10 11 12 13 14 15 16 17 18 19 20 21>;
 			};
 
+			eth_phy: mdio-multiplexer@28000 {
+				compatible = "amlogic,g12a-mdio-mux";
+				reg = <0x0 0x28000 0x0 0xa4>;
+				clocks = <&clkc_periphs CLKID_SYS_ETHPHY>,
+					 <&xtal>,
+					 <&scmi_clk CLKID_FCLK_50M>;
+				clock-names = "pclk", "clkin0", "clkin1";
+				mdio-parent-bus = <&mdio0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ext_mdio: mdio@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				int_mdio: mdio@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					internal_ephy: ethernet-phy@8 {
+						compatible = "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
+						reg = <8>;
+					};
+				};
+			};
+
 			uart_a: serial@78000 {
 				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
 				reg = <0x0 0x78000 0x0 0x18>;
-- 
2.56.0

