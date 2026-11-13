Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572337;
	b=k7dW1Tdt+6Eye70QzUYqA50kKyZ9RKdptwpdBcVdC3erN5ZcHvuqaX7oAuEqHX6cSHC1
	 +maojo7PksFT2eIlQUj79JygfdWxYnihtAIBcM0UXorjQbF72b4PUDOZFbjRaTlpviqGr
	 GShvA6M7Yc5kbOtfm0Boqa8jWjKunrJwp0YTRAMqGimvSmjPHyM7nSZLS9RUQpYeQKGfV
	 Bxi4xyOyLxLWBOh33I5Ale5HDHNZq5d7aW8ixM/PbXSmZ2PdXql2udQQ5ydchTkCiXDak
	 5I4gSjaKC+q74rQ9UEozrdJf+rLrab5hgq0KPuF6CissPdu2LafVAY9e+TNKfP+FCgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572337;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pzwdGume78d+Ss8/RtaDjaZog/9tADCa21G3bSQ/eAo=;
	b=MwhvKZ92jfXGVbx+HEfHOYCX8tmQbR3D+E27H8ws09Yw5fBit6ZLFIrm8EnOptfn4MvC
	 h8UxBj4UKE91MFM0sYBF4hXKXgbj5xhFEVM1CwEeCkalt+F1ETqXUurcvebarAqCz7Jap
	 B7S6m5LSSXd7Hm/ifAlE8xie0UZheCclJYt/RNFmXy+gPFqLslH+ENx+tjoqbWDr3pPfT
	 GlF4bS0QZ9d7w5xuRTw8aoHboTJ3BOSg2Cvzt+tv4cjQws1oROqfjBZ62wEebZklHthE3
	 vM3qlhPsNZhagx2oauqsZqtkrNOkdVeMqb/s+7StAM8pCOQ8zgcOP4XDMetHwuabwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B533606A88D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B533606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4922dbcee23so393714f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572335; x=1795177135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzwdGume78d+Ss8/RtaDjaZog/9tADCa21G3bSQ/eAo=;
        b=LJ3nKFmYYWnbst+q897ypVW9+mtscsAdFnwgvn1ez2PS9vNlXqnzMhwasF9yPFnqW1
         YiKL0VagFhCl1M/MjkLEdABIf+PICFlJU4MBZRwGTmyGrkYi6tew2aFXN5B/JGCYTh3L
         0sZUBmEc4AYOdDIakQkBuMBk0jtGLVKFhQqvyBvlaFN8gxIR3HpI7SkHcwNKC/B1Hdh9
         29Qe7qix/YRZ5TQY/YmZRHjH3A0JPhkIR8yGbuf9vtZGDkoot39OdT//o+OVSMCTeoBT
         u9k3fF878Po0P7w1Fv6+K4dCzJnjfMx1c7P+TIPNQMZoltbQRRhg0igMAtwo6+b/O+tJ
         WVjA==
X-Gm-Message-State: APuU4Z/7jyTt/Cy+pHR1do+5Z7yj8/FgzKe8ZO1qOT1CBbEViFvmjwkV
	slTydqgjQ5V0K8BuJQZ6bHyXJrPO3RuwbVoTG1xllpoTED1QWLtlKPqQ
X-Gm-Gg: AYBFou0s58QzQFTGf+LRn2P46I62lW10Hj4SkjCl9iyPJ5ozNbkvqpzfiuuXrV28Yij
	5JsM6l11Pr7TdGM45IvkRdl0E3Sq2FP4r0c115Id4If0brAxQBQof/cEzi9+Hgjggmun/eJXt4S
	27F4AyPmCbko0bVbny53Okee6vSah9Gsx4SuvEGPtoxi4Zr4ssWV+J8b1TKmLdH8KIcz9dAf/uX
	M+eKYYXk0kZnbA2ALo8+8a5W0tS9pTEKtrG4c5tFSkWMAu+T9m2rqsAhPFRYDenVIvgnVmQRYdL
	hqHMQVa99+Q2wz0jhRgA3ci/NWwtlPnMuVA8TajZBEbE5/as71PQbxy4HXdd9VfWX/AIJcLyGLG
	qJQzJD/d0nzqtXSvmASMZTisXkRzhg1qJ22dRTXWYtTZ9wIxK9jjQeiRGlol7rIEFClu5n8i0pm
	TQbpHG026m2XSkhYtMrDvgausRNfFV5LgAcnGlCj5jBr2NyyRghty7xUFXefAta0X/Mejb4E6Uf
	3b7D6k70QO9szwNtk2xgF5WNPoCk4bZmiwfW1iYhzR6Ak6MXFtw24OGC19f91RP/Hxvw8Vqa0tE
	0iA98gbJ/pkEbf/m9YM0hVZ7kV2r6x4K5Hwpx178pUh5z8RKA4ATW9BdBoUiIFoNK1bfKVCi05W
	GGbXOMNNQjmi1KFoIqJirs8ai
X-Received: by 2002:a05:6000:2003:b0:490:411a:1eed with SMTP id ffacd0b85a97d-49c72f7a66cmr5198418f8f.39.1794572335385;
        Fri, 13 Nov 2026 04:18:55 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm5167103f8f.40.2026.11.13.04.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:18:54 -0800 (PST)
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
Subject: [PATCH v7 2/7] dt-bindings: net: add amlogic,t7-dwmac
Date: Fri, 13 Nov 2026 12:18:47 +0000
Message-ID: <20261113121852.334604-3-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113121852.334604-1-tanure@linux.com>
References: <20261113121852.334604-1-tanure@linux.com>
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

The T7 has the same ethernet glue as the G12A but needs two clocks of
its own. The controller reaches memory through a pipeline stage with
its own gate; nothing else claims it, so it is switched off as unused
and transfers never finish. The glue registers share a gate with the
MDIO multiplexer, which probes after the controller has programmed
them: the writes are lost and the port keeps the bootloader's delays.

With a newer core, a clock list of its own and delays that follow
ethernet-controller.yaml, the T7 gets a binding of its own: the PHY
adds the 2ns, and only the receive delay line offers fine tuning, so
only rx-internal-delay-ps is valid here.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,t7-dwmac.yaml        | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/amlogic,t7-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/amlogic,t7-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,t7-dwmac.yaml
new file mode 100644
index 000000000000..9b7c3864cd29
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/amlogic,t7-dwmac.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/amlogic,t7-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic T7 DWMAC Ethernet controller
+
+maintainers:
+  - Lucas Tanure <tanure@linux.com>
+
+# The select keeps this schema from matching every "snps,dwmac-5.10a" node.
+select:
+  properties:
+    compatible:
+      contains:
+        const: amlogic,t7-dwmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: amlogic,t7-dwmac
+      - const: snps,dwmac-5.10a
+
+  reg:
+    items:
+      - description: registers of the DWMAC controller
+      - description: the glue registers PRG_ETH0 and PRG_ETH1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: macirq
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: First parent clock of the internal mux
+      - description: Second parent clock of the internal mux
+      - description:
+          clock of the pipeline stage inserted in the bus path between
+          the controller and the DRAM. Without it, the controller cannot
+          complete DMA transfers.
+      - description:
+          APB clock of the glue registers PRG_ETH0 and PRG_ETH1.
+          Without it, they read as zero and ignore writes.
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: clkin0
+      - const: clkin1
+      - const: pipeline
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  rx-internal-delay-ps:
+    description:
+      Fine tuning of the RX clock, added on top of the delays that
+      phy-mode describes. The PHY adds the 2ns RGMII delays, see
+      ethernet-controller.yaml.
+    default: 0
+    maximum: 3000
+    multipleOf: 200
+
+  # The TX clock has no fine tuning, its only step is a quarter of the
+  # clock period, the full 2ns at 1Gbit/s. The PHY adds the TX delay, so
+  # the property is not accepted.
+  tx-internal-delay-ps: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - phy-mode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/amlogic,t7-peripherals-clkc.h>
+    #include <dt-bindings/clock/amlogic,t7-pll-clkc.h>
+    #include <dt-bindings/clock/amlogic,t7-scmi.h>
+    #include <dt-bindings/power/amlogic,t7-pwrc.h>
+
+    ethernet@fdc00000 {
+        compatible = "amlogic,t7-dwmac", "snps,dwmac-5.10a";
+        reg = <0xfdc00000 0x10000>, <0xfe024000 0x8>;
+        interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clkc_periphs CLKID_SYS_ETH>,
+                 <&scmi_clk CLKID_FCLK_DIV2>,
+                 <&mpll CLKID_MPLL2>,
+                 <&clkc_periphs CLKID_SYS_AMPIPE_ETH>,
+                 <&clkc_periphs CLKID_SYS_ETHPHY>;
+        clock-names = "stmmaceth", "clkin0", "clkin1", "pipeline", "pclk";
+        power-domains = <&pwrc PWRC_T7_ETH_ID>;
+        phy-mode = "rgmii-id";
+    };
-- 
2.56.1

