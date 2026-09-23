Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA347CA90;
	Wed, 23 Sep 2026 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159993; cv=none; b=mqDXP0IpQGTC1/oLDQ4y+Wy+YaLcUD6GhaEv+Jf7uWOq5dQFb7Vq6wASVM2qeohN/76SGNSsA+E6a57Q6SJ4KJVrmB4wCNfO2gf9pRk8X/tmYMyrx/BCX1QSG6HGBRZmt5JtkmJ7NYZsuxrXOb9fgRja2jVC/fCDz/7mlVdpCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159993; c=relaxed/simple;
	bh=eLfyXIHP+DBOk1PaWgQ0C2aUrJQphj77LAyGq2bH0I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtUM9nDIrouCji1Q3/6i7awdjXn5hORlBpPGspUNqmPCoBuwOiRdttnd8zbXv1GWyQPjn+0HVMRmde9p+nnR/BYQXHQMoR0vX+DgRCVun8SRoRHELZnvwDUNIEn07qOiCYbFPeKDSfCNDyjpYVAN3YthWUmSP+984R8lYctRQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxNYQZ4W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7j7ABW3k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxNYQZ4W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7j7ABW3k"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpUhfJx82Oe5JKxsiqQBFzO4QLK+0xqpIhBiq0nUpi8=;
	b=yxNYQZ4W0k2ggJCZiDD5tVXQVqUFIpcaoSNIJsrUqvmp7VQ+SJQEwJ7SUD1mDkGzuuOEsV
	/S/cSsRssgL5LWrQtshU2vyWIhYuYjUZPhoL3sgKHytbycqfaI5/7Onw9EiktSnez8Aync
	MaDEJzzw2bAnfeHxJEK1+vMonVC65Vv1UVKk53LwLj31lXj3PNgmgraB7P+Q9J/xoWKMT+
	3a0QcXJgraFZDikiZasojoURuSSr5hcFVjzc4oRkaE0H/nwVcNE8J40FKg0ikUr6TA/WPL
	fXlz3s2gBtLTpX+HT068/hkWHksULr/6wYg1FY1kpV1VUbC9gr9XPhE/XoBTjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpUhfJx82Oe5JKxsiqQBFzO4QLK+0xqpIhBiq0nUpi8=;
	b=7j7ABW3kcfWmLKb3qhLQTRa5P4bR45ZAFWzwIYA2oQkWJ0Xt8OdDeXMlXl3jasHq7+f6cb
	Y06EPrDMTrCc1yDg==
Date: Wed, 23 Sep 2026 12:39:30 +0200
Subject: [PATCH net-next v3 3/8] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-3-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add a binding for SoC-e FPGA-based Ethernet switch IP cores.

The compatible identifies a register layout characterized by the core
and feature identification registers at the encoded offsets. The
concrete synthesis-time configuration is then autodetected from these
registers.

Describe the Ethernet ports and the optional integrated MDIO controller
with its generic MMIO mux and child buses.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../devicetree/bindings/net/dsa/soce,swip.yaml     | 162 +++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
new file mode 100644
index 000000000000..d614fb2a29d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/soce,swip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e ethernet switch IP core for FPGAs
+
+maintainers:
+  - Vasilij Strassheim <v.strassheim@linutronix.de>
+
+description:
+  SoC-e Ethernet switch IP cores are FPGA-based switches whose features
+  and number of ports are selected at synthesis time. Ports can connect
+  to CPUs, external PHYs, FPGA logic, or other switch cores. An integrated
+  MDIO controller accesses the per-port external buses through a mux.
+
+$ref: dsa.yaml#
+
+properties:
+  compatible:
+    const: soce,swip-00-04-0c-10
+    description:
+      Register layout with the core version register at offset 0x00 and
+      feature identification registers at offsets 0x04, 0x0c, and 0x10.
+      Switch instances using this register layout are autodetected from
+      these registers and use this compatible regardless of their
+      synthesis-time feature and port configuration.
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+  mdio@204:
+    $ref: /schemas/net/soce,swip-mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Integrated MDIO controller bus on the master side of the mux.
+
+  mdio-mux@202:
+    $ref: /schemas/net/mdio-mux-mmioreg.yaml#
+    unevaluatedProperties: false
+
+  ethernet-ports:
+    type: object
+    patternProperties:
+      '^ethernet-port@[0-9a-f]+$':
+        type: object
+        $ref: dsa-port.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maximum: 30
+            description:
+              Switch port index. Supported switch configurations have
+              up to 31 ports, numbered from 0 through 30.
+
+          phy-mode:
+            enum:
+              - mii
+              - gmii
+              - rmii
+              - rgmii
+              - rgmii-id
+              - rgmii-rxid
+              - rgmii-txid
+
+        required:
+          - reg
+          - phy-mode
+
+required:
+  - compatible
+  - reg
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch@80020000 {
+        compatible = "soce,swip-00-04-0c-10";
+        reg = <0x80020000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x80020000 0x10000>;
+
+        mdio_parent: mdio@204 {
+            compatible = "soce,swip-mdio-23-02";
+            reg = <0x204 0xc>, <0x200 0x4>;
+            reg-names = "data", "control";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        mdio-mux@202 {
+            compatible = "mdio-mux-mmioreg", "mdio-mux";
+            reg = <0x202 0x2>;
+            mux-mask = <0x07ff>;
+            mdio-parent-bus = <&mdio_parent>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mdio@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switchphy0: ethernet-phy@1 {
+                    compatible = "ethernet-phy-ieee802.3-c22";
+                    reg = <1>;
+                };
+            };
+
+            mdio@1 {
+                reg = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                switchphy1: ethernet-phy@1 {
+                    compatible = "ethernet-phy-ieee802.3-c22";
+                    reg = <1>;
+                };
+            };
+        };
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-port@0 {
+                reg = <0>;
+                phy-handle = <&switchphy0>;
+                phy-mode = "rgmii-id";
+            };
+
+            ethernet-port@1 {
+                reg = <1>;
+                phy-handle = <&switchphy1>;
+                phy-mode = "rgmii-id";
+            };
+
+            ethernet-port@2 {
+                reg = <2>;
+                ethernet = <&eth0>;
+                phy-mode = "gmii";
+
+                fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+                };
+            };
+        };
+    };

-- 
2.39.5

