Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873015;
	b=UtZuvM+MDz95DQj1SJrxFr3s+LOox7BEe5qlLCyCKCs57pSezjbemz5gsFWFxBsUFiA5
	 hw40isFIFFD644BaYtekBVtJl/noyRzscZoqoveVW06XJVC2n6q8OajyGCbp2KP+q6AIL
	 lIWdqiXGgT53pOa/vbNwTascLJcaGmJFsSYe3T+NsAlHjbKx1DWDRovwRbBoO/eMOMjq0
	 oqvZyYDxKG6ZAjSH9EA5XkE7R9+JB2Mk9qBi0rNI9reBx4t3Fc1OYIomcP+Rrpv2D9iTf
	 EA2nfAj17+q2cMJLxAIYgjtGfbhXxA5Nl3CT8e2chA3ZqN0E3TsrO7disqmfw798qWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873015;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=paduv/zXRliBqDWBFf1W5OOKpbqC02TK32FfMcPBmKs=;
	b=a9ICCMBma09rHGIDhL0NY9rmQoNN/eOXqDq7l4cGvqw3asF2SzvxwX9qwHc/uchZuPGg
	 WzIcf8MuiNH21WQExNdnoRE0t68IZBEcYO4HePuTL/OemhFu9kY8xFkY18+ywTfIdypnX
	 ahdKX0Z1LmbskD4auWjbrTNSs1q1RIAEiV9KdQ5f0wGuKk1d1qvU/0IjIEryVWuPQ40PH
	 xQ/H6OmSP3wNAiE4609c5gA/AvjaVtRySct3OHwlINCXUvyW8X3I9EDHwCwhd+jqL5eCM
	 LMcEC6UCAJce2Ay7NPrXK8voIIEbZMhoYygN/gRIU+3Ge8OSlEhSyvmp2PZeDEj8Y7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D0606EEA1
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 462D0606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so11787775e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873013; x=1794477813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=paduv/zXRliBqDWBFf1W5OOKpbqC02TK32FfMcPBmKs=;
        b=RXhwmpC9amxr6suPh77cs0F3s2xNk+Xfy3h/TKc22BpI0OjX1OrfKJt41EqYkXKDjh
         Lkp3PN38ALkUOcjTyFNIchF/LmIdOkxuvGashkrzywEHaBkVQ1F0ZNw5GUWAUANmqg/X
         XTXLUqCKdkCdl2zvWc0hYYk7ODPvh7hWbtGNf+CsFgfXCjXqfy3knDo9ITqE7+C+2igQ
         JEf8WMXnYSIo9DzHQcxm0hAUjBMcyMwynF/OHgBAy4GV5KYOHkzjU9Rlm/RJHHrUmuZ0
         xWdv6toTZzP5vXnxAgczV3o6UNqRK+CaqTFhpJNhHlxW1FuZ4VAz6N6CJ9zIi0kdJmRy
         iYVQ==
X-Gm-Message-State: APuU4Z9c1UJlGHhlwCd3ayg41+VTNarBu9105aOro7VVqb9ciud0BXlh
	QEYVQQUKN71oFoOCMmaIqxxGMnp/rzDFRwLhOy/3SlJ32Zy2sOdSSA/U
X-Gm-Gg: AYBFou1gNO66vR07FMTBnPrN2Cawd4upXPpTNqtzsiMdcRpBjEyX02VoZnoSlgi1sWW
	D5Xjf2+rI4Dxf/Vr/nZ2yOh2j4ompy/j2R/TkfkUzFvDeWVyL0ENRWcjRgiShE9gL5dMQ/zgZS8
	8IOPASPDYQkQcGRpseZ3E7RHpiaZ8Yv3VXj+ZyTviZxa7KwxBwJ2f0AYugWitDlr5heA/RFzXm0
	GoXJcv+TEj/Q/fRPI40LmZz/tXK8S7N8wfaLJkFPSD4YL+aJgsA1pURdyfad94rR6+UXIdGqie/
	UoDaxpWSwYwCCfTGxG8BDR84XZxXlfXQa8MNuPvSUfddUc6MafCBISd4r6uk4bGpr+9wqnqstrb
	fiu1W6SNNTHfRUVpnQ0Iy3xNSpqeVYjIPdQRPCqBahUvr1QSFDRF0Iii7T5Sok8sLovYN2WwrEl
	QEpwHxDAD1fnIOlZ8RWBX+fpKg+Mip+HMAnueEeYDY8TJL/H7sjuC6AIJZtTcgKa+VreJl8hFBG
	/aiSk19He15tVY80kTrz+QTok6vvGD3cGwwUWEDjTzSmLioStrZI0EC0d0Eq/UWGu4hk5KGmHZV
	8bb1R3Ims2+HES8xxyWh9h0rqXA5ItNFs3+Yl2fZwPX2YaI4v6tj2bl4C9wnVrcmushEZzx4xJs
	zgyG9bkQCO2nilDzKwm2VXUNUjkg=
X-Received: by 2002:a05:600c:6095:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4ac182dc30fmr364050625e9.22.1793873012541;
        Thu, 05 Nov 2026 02:03:32 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43342773esm53455775e9.4.2026.11.05.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:03:32 -0800 (PST)
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
Subject: [PATCH v6 6/7] arm64: dts: amlogic: t7: add the ethernet controller
Date: Thu,  5 Nov 2026 10:03:21 +0000
Message-ID: <20261105100322.37816-7-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105100322.37816-1-tanure@linux.com>
References: <20261105100322.37816-1-tanure@linux.com>
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

