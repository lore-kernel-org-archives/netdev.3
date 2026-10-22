Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699614;
	b=te0SD7VnB0GdtYRMS5e1BRP7PuwrhywJ1CXcKZOCMU5a3AonxREt7NRsqx9eyw/YGdqF
	 x0+GhO8+QWlEpPRo4q6pDVjT5OAbxNsGEToNX7vSk9ZpAx+gQbl4UYYmQXR1N/q4ZKzG4
	 YF9dmnONiu0ihbtcwrIMkZ1cC0sTCbWUGO6e+FQapoSEtpMpZ8sf/f/8hYKMO7c2nq28y
	 XtwwhBtwO7aQHxhXwmJCgwCAM8FibPOF/JN+1yZTPnlkt6cZHuwJWlVOwTqfzaEooGV/Z
	 dgphZbqXeOkZHI1oHdpdNxWH3HGD8zUSQOxmjXPPsMiS9uSINQzDYKb+CaZDkR7m5Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699614;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ElpMWQpElxyvYVfod7vt+zc/cJPBYXPVQKctc5VqWXw=;
	b=S/DW0AI07yvcwl6baHeQ5hiQ0IcKSyzCOuAy+r1Aa7ls6lNAQM/VjVNVH435ce7rLC4R
	 Ij3mwKSB3PIpVrVM49wZuO1lq2h4pH37O/VqWqBvgNglj+CqQ117pi7bOIU94qsaB+sQ1
	 mZlw1VKEK2n8k/MCIZO5Rkua8kWyCZmD4BITibP6ulYRRQcqHdT49b3bu9LEmwiYi3iPT
	 YG3A1DUKJsQxVhvRrwe9L4jCF4/vLYoq4ZNOmQ/dXd9VpfcFXH4m4gusY0dNcHentrFBm
	 v21psIPZ8BYS7yHyo3qHlaEkjis+GFETS/BsmASmpKpZbEqcL4Tys7DcowzZQKQYX6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076160A381C
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3076160A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20c923847so1491925e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 13:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699613; x=1793304413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElpMWQpElxyvYVfod7vt+zc/cJPBYXPVQKctc5VqWXw=;
        b=Gmxn0ViH+9TP+nEa1P3K13qOBT7dJnfnZ6ix9tO2oj8TpRlWsQ8vTZlfJxtPIq/otK
         ZZpu8QfadeBn6b+QFbMoXXgozWXXR8eM8u67PMmE/WlYVnWhrKZGmimAhHjdz2B+pwX+
         DTwG6s4x+nDg9tAVlCFvV8U45iLnpqiXQlMKknPxnSOp1QfAg+bT+sS02DSL+0Kw06th
         vYCZ6WyBMcCWF0uRVU4D+78GWXMIYdYhJCxcVOixPTzdUAZubNo+PW8DTcOtSY/c11t0
         JKqxL9MCou0OU3MaSZ96XDjP7URhFJZe70BWIL4OTucMxn7xcxqPinIp6bEwMbH2NJg2
         dwjg==
X-Gm-Message-State: AFq9FYJM+cagVTpaW+AF8p6lxqu2XYKbEcFTQl5Mw9EL25xphl9pk+vl
	XFw4hMg25ZWMrA1ARBqZJ03VZ1j53etbWs9wEuumAyvsYIZuEPNyyzB/
X-Gm-Gg: AYBFou0rPef0dRCL3DoEDmEn7ppAr7vxcUYroc/U+7ktNz2AFgJfUWIHUGtsFowwg+Y
	XBCJZ1piSxLlDAvbwOnIj8vXMItEKjwf7MlSbbPhBUJtHmH8uXf3vfFUQ0RgubNYnTraZiA2r65
	rPwuErLBXENaygfv62t8JyO6shT48mmZimh0H1QpMaIcxACnQkBBP3zeKOlzOLkE592BB9MOeqc
	V9U2l47NnevpTO/sxEaM7ZNyAqDAdhZxUwYBdllyMigUqhEJDdUrJ3hRBNazqDRWyoJEPGT3bGn
	sUG+ipL8oA4hcLB9jtnyeUpHuKAtB1LEQvI4NkPw4HqFeMOlTLaQSVtVUfMcFjjsSpQ2xHgg1Ik
	x+z5ughQvjzK2TdMhzWyCu+y7/mt24AFjUvKIe5ltSn0yx9OvUmFyncuVqTupSZQuqQFCtZVZmG
	B2UFRV7WpxO3spU2ouVvK5mJevSCCxP36moifGgDvTbh/sqZV3rKDh2MsRxs9cWX9CUDQxieQqr
	ZI0Aag/RlrkewGQqCiqxYcN9sx5N3zMxFcUD14wXbDi4rhTL5+21kqC/2c7/kgqZhE+AbzcCsXq
	3FtpIRIQOkmcfqKR
X-Received: by 2002:a05:600c:4e43:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4a211ed57e1mr2298085e9.13.1792699612466;
        Thu, 22 Oct 2026 13:06:52 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm35965e9.1.2026.10.22.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:06:51 -0700 (PDT)
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
Subject: [PATCH v4 6/7] arm64: dts: amlogic: t7: add the ethernet controller
Date: Thu, 22 Oct 2026 21:06:39 +0100
Message-ID: <20261022200640.3101932-7-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022200640.3101932-1-tanure@linux.com>
References: <20261022200640.3101932-1-tanure@linux.com>
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

