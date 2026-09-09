Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054C59574B;
	Wed,  9 Sep 2026 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988945; cv=none; b=dSL3q+tU3R/GKY3gKF2lP0drgxhAb6sZE68UmDsb5RTKtCAFtzZoEsUGc9EQ1qdNBx6BlrB+7exiYzrceNTl2+JQrmP3RYtw9hYnKGz6c0zrRImgsuZy9mMP0o8WmkBy2T590jH/aHX8C4Tj7UmHAyrX8dUdTSAdXY5LGC1N9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988945; c=relaxed/simple;
	bh=G9ioAeL7lW+KA+43AM9vqX4kJY0wEV2WPDzrhhfKLeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCnhVxSXip1/ptup3W+++yVRloOCxEXl8xQ7+ulQBYXtzeHa851Ou9Ce4yuT6u8zK4AxKlfuFwsHn2szB09N/knGCBid1HBf5MQttYzmPuj4mU18Y202C1VutQ4gIf8ewxb1t+4SGzbsuJf/sDwI44UBM6xdattLqeFy9wVbn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=WexsMZQL; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="WexsMZQL"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB19740935D;
	Wed,  9 Sep 2026 23:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788988940; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Eh26+fMTBRHost86hhgYFkXWy1BCjqv4Lpa79eE87Vg=;
	b=WexsMZQLNOm5xpeKwK54w03P0PEIFh/hCTjPusUrn07KG0NvYkQLi0LHusZPpzmgOz4sRX
	7Ua5+xTBmTqCfHI6bnrYnEiVOuh8bCPfkAJMwd4tOfPb0Di7fTUBwmvGOAYdgrWHO+ec+M
	aaGmK+xPoq2WVR/x3YYBAgiKsDFDmXDkeF06lLxvVPRRnFH6S4YML0a524SE+Trjdg5Vqe
	1d88WLkwpFvnVEPgJV2Zm7YIlMQioqO2juPABeF/Sp2a3rNg0MugP+mfayWzK69tTjfOPm
	0NiFYmi3ETasiUiiwgmOKN4XWqttTXtsAfQ/+hK7JtBeR412Y7P5up4OsBUnXw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	vadim.fedorenko@linux.dev,
	maxime.chevallier@bootlin.com,
	dong100@mucse.com,
	wangruikang@iscas.ac.cn,
	25181214217@stu.xidian.edu.cn,
	hkallweit1@gmail.com,
	han.junyang@zte.com.cn,
	xuanzhuo@linux.alibaba.com,
	enelsonmoore@gmail.com,
	jes@trained-monkey.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH net-next 1/2] dt-bindings: net: econet: add EN751221 ethernet
Date: Wed,  9 Sep 2026 21:21:45 +0000
Message-Id: <20260909212146.3184077-2-cjd@cjdns.fr>
In-Reply-To: <20260909212146.3184077-1-cjd@cjdns.fr>
References: <20260909212146.3184077-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EN751221 ethernet controller is somewhat similar to the
airoha,en7581-eth but it has a different register layout and different
capabilities of the QDMA engines.

The engine is roughly made up of two "QDMA" modules (which provide QoS
and also DMA), two GDM modules which service the two ports, a PPE
(packet processing engine) similar to that in mediatek,net, and an
overall "frame engine" which coordinates the components.

The QDMA modules provide both communication with the CPU and QoS
prioritized forwarding. For example GDM0 -> QDMA0 -> GDM1 forwarding
path is possible.

Add DT documentation for the EN751221 ethernet system.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 .../bindings/net/econet,en751221-eth.yaml     | 127 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/econet,en751221-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/econet,en751221-eth.yaml b/Documentation/devicetree/bindings/net/econet,en751221-eth.yaml
new file mode 100644
index 000000000000..5d953eaa16e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/econet,en751221-eth.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/econet,en751221-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EcoNet EN751221 Frame Engine Ethernet controller
+
+maintainers:
+  - Caleb James DeLisle <cjd@cjdns.fr>
+
+description:
+  The frame engine ethernet controller can be found on EcoNet chips
+  based on the EN751221 SoC.
+
+properties:
+  compatible:
+    enum:
+      - econet,en751221-eth
+      - econet,en7528-eth
+
+  reg:
+    items:
+      - description: Ethernet device
+
+  interrupts:
+    items:
+      - description: QDMA0 IRQ
+      - description: QDMA1 IRQ
+
+  resets:
+    items:
+      - description: Frame engine
+      - description: QDMA0
+      - description: QDMA1
+      - description: xPON MAC
+      - description: xPON PHY
+
+  reset-names:
+    items:
+      - const: fe
+      - const: qdma0
+      - const: qdma1
+      - const: xpon-mac
+      - const: xpon-phy
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^mac@[0-1]$":
+    type: object
+    unevaluatedProperties: false
+    $ref: ethernet-controller.yaml#
+    description:
+      Ethernet GMAC port associated to the MAC controller
+    properties:
+      compatible:
+        const: econet,eth-mac
+
+      reg:
+        items:
+          - description: GMAC port number
+
+    required:
+      - reg
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/econet,en751221-scu.h>
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      ethernet: ethernet@1fb50000 {
+        compatible = "econet,en751221-eth";
+        reg = <0x1fb50000 0x8000>;
+
+        resets = <&scuclk EN751221_FE_RST>,
+          <&scuclk EN751221_FE_QDMA1_RST>,
+          <&scuclk EN751221_FE_QDMA2_RST>,
+          <&scuclk EN751221_XPON_MAC_RST>,
+          <&scuclk EN751221_XPON_PHY_RST>;
+        reset-names = "fe", "qdma0", "qdma1",
+                "xpon-mac", "xpon-phy";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <21>, <22>;
+
+        gmac0: mac@0 {
+          compatible = "econet,eth-mac";
+          reg = <0>;
+          phy-mode = "trgmii";
+          status = "disabled";
+
+          fixed-link {
+            speed = <1000>;
+            full-duplex;
+            pause;
+          };
+        };
+
+        gmac1: mac@1 {
+          compatible = "econet,eth-mac";
+          reg = <1>;
+          status = "disabled";
+          phy-mode = "rgmii-rxid";
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..7417ca4ccc79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9330,6 +9330,12 @@ F:	drivers/irqchip/irq-econet-en751221.c
 F:	include/dt-bindings/clock/econet,en751221-scu.h
 F:	include/dt-bindings/reset/econet,en751221-scu.h
 
+ECONET ETHERNET DRIVER
+M:	Caleb James DeLisle <cjd@cjdns.fr>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/econet,en751221-eth.yaml
+
 ECONET PCIE PHY DRIVER
 M:	Caleb James DeLisle <cjd@cjdns.fr>
 L:	linux-mips@vger.kernel.org
-- 
2.39.5

