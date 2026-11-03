Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723845;
	b=jKTnII10YbCVACuVep3uwWQE/X3jUs09n2fg7CgvtwPsMlDqQvJwZ/4wGCe0lnxpQrVo
	 eilLzP2/QODw5+n/HPjs1lWO8qatJm/LZhOpllkXOpZWLCNlFsDapFPJphToqof9VPaF+
	 hGQ4swpT7OX/pb63TVhm0I1YorfHDorWFc8aX829ZhocGeWQzUwbGjXii3t29GDah1LAz
	 4+TpCGUUx9HJuO7KIt1O8Uri7mBhN5m81uNAqPgfG5G63ucSgcJvYyhaA+xS9Zbf3mJeu
	 tIWFDw9ETSMXSkma+nFZNCDJE/nJMvHwNIY4kBTv4XPf3z1GvvOMSPN2WpEnE+QkGhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723845;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=paduv/zXRliBqDWBFf1W5OOKpbqC02TK32FfMcPBmKs=;
	b=b0A0lILD4Nwe/zKluM9pDDkER1bCGy/I0iMK7M43aXOr5rNWYQGV79ITqPdMorwPQiMy
	 Os0T0wECV+zV2rWGQGFJFpqsV1NLAUGhKcnKjN3qp8ByEajzmDd08b4kDvaanE1i9bbrF
	 RUVHf5mMAo27vd+a0+DY67fxwOAl4wQArJKlrU23KWo4XgsYZr0CSIXlf/lpLWL+xHjtk
	 x3xLpsVYmAMx+VCGDt+J4F4tUIgiF/J3JUZ5aN2KlabSYhCC0xBJ6Hc98BOqBdfWtRFwO
	 BXrm2WzilvUm7YkC4uRENRNyEHuC8gan/DjwEdFnUKpe7xYcl93aO10p7aldqY1DXXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DD6082BD2
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 638DD6082BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so43621575e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723844; x=1794328644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=paduv/zXRliBqDWBFf1W5OOKpbqC02TK32FfMcPBmKs=;
        b=w+ZUAeEHHNDfal++9M9zoNdNu0bxVLMrBhmpYSj6WKWE1ZiWh9yU9hz0f6pzzoLSuN
         RBxfKLOLeQKR0uPTQO1fPMU2bYekhIQQwykdVjc+Vkb1URieq1fpVM3K4UQCN4G69nz7
         9tXGXNdgZOjtowtjWTIxLXIypRYia1UFRuJztyxPtET69Z12YVf1L8hcTCZV/xsorND5
         2940xTX/YS7DAxFXlqfbuCkNj60+Dat/eEHHxrbmt5ATE5bIyzoUVzTNtShR2SGu5Fw7
         rghpu1z3n1+uoReXQxcDlLOMmdXMZg/tP36hnChxDzw6fxkAk+Xy7+yex0E8HCAicjd5
         q6JA==
X-Gm-Message-State: APuU4Z9/UPBNhihM98leeH2KUF/8O138pdjKtla5WDAZNxCnsC4fqDPC
	lXAe5W8MiGaYfVY9/Io0WBUix7WFSgDgmWpQ339I1/MaK/wVO5yQ9j79
X-Gm-Gg: AYBFou0XzFYX4MEFjfKmwaz7WpEvjQR7PCUMNt2bJ6J9pK0yG3+1oRzmBcpmhuk6H5J
	3PaxSnymwDaU5y4wXJQtUKoxgTNSGCCKdOHb0vvOrriKra62VflA8RmJJG87Hi0tXortOnB9b8+
	dv9vkSZYwNgw2RwZXzMAGF35pu9klsIA22za8c6lpw2OTtfu0nfbE9ydp6tgBKSJD0BHkQDO8uV
	34rwYJmcU2NDpMSloIgUk7Z+1/68LZkM8vF2554sNT9LMiLvZ84hlSdiivmVW/GhkzoZShEOPun
	GbRhwYrNanzTJ/V0Ncpxznrp07SHCqhm8cBP3wZZX6mBeavCTmrUd91QzTXNXN8oCg3MW1PsOVG
	Y789iJx+hDT3SB3r5JU+D4LXexMjg8f/q9FtsifON3OeIy0lNGwjVSTD3zoGVBb6vAzzTxhp+ud
	aVu7t8pL+XpYmPbNCJ37Paj/1hIDxEzhtTEFRYXFSPY0q8i5MRFmgSlFUewtCc5bURjQOoqMVPz
	p80I/jPS7rAyswvdyA7eOJvynyM3wC7VFfNQhfcV2MMxnhrQzzpPHqkOYvKdAJ3O6SRLiqm3wUT
	hiDOPYi4CDWwleXbtYkxlb/E7ciJxuto81XadzOPF5uzsvJfs4vPv6xR9qDzvp+j8oYuYBv/yg/
	S9zqQgX85GrcmmdTCmcsQF3E7Rw==
X-Received: by 2002:a05:600c:608d:b0:4a2:1197:1de0 with SMTP id 5b1f17b1804b1-4ac18b7dcdbmr311763505e9.19.1793723843721;
        Tue, 03 Nov 2026 08:37:23 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:23 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
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
Subject: [PATCH v5 6/7] arm64: dts: amlogic: t7: add the ethernet controller
Date: Tue,  3 Nov 2026 16:37:14 +0000
Message-ID: <20261103163715.385394-7-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103163715.385394-1-tanure@linux.com>
References: <20261103163715.385394-1-tanure@linux.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SoC has a Synopsys gigabit MAC, glue registers for the interface
type and clock timing, and a multiplexer that points the management bus
at the on-chip 100M PHY or the external pins. None of it was described.

The controller reaches memory through a pipeline stage with a gate
nothing else claims, so it is switched off as unused. The
glue registers share a clock with the multiplexer, which probes after
the controller has programmed them: unless the controller holds that
clock, the writes are lost and the port keeps the
bootloader's delays.

The multiplexer and the on-chip PHY bus start disabled: a board enables
the multiplexer with the controller, and the on-chip bus only when it
uses that PHY.

Assisted-by: LLM
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 7bd53ec16607..f15fd8f6cdd2 100644
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
@@ -645,6 +672,39 @@ gpio_intc: interrupt-controller@4080 {
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
+				status = "disabled";
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
+					status = "disabled";
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

