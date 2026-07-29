Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE584D2EC9;
	Wed, 29 Jul 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343072; cv=none; b=gaMRXpe9QgEMYSLB9agfFER+JtMpAPayg3T6YcVEvF8lCo090qAQGtiAn7zvcPPTpI/9wI/hlYi9mCrSvSHtZeMGdjBt2xeGcffBP4eA6Xy7lQCkjtS3vjU44mCy0at0ONtZlagotj7Hx9kO1AeNViS9xM7BhFrxYSYQSAzUmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343072; c=relaxed/simple;
	bh=534tJYDJ6QFErCbnbOlokOI++N4yLUf8EyQ2ORsrCBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rA/pOhrppGvU/WMRKChkTFAthecacpUmtkx3TMOdzMCpU4SRWgr4Th2GdBRj1vZ4y0nhFAtP3nAzy7nbN1F2O/k82faTyc4G1+vjT6kosCG1oTKxp8c6xFZ9aehR/x8uRZmRs6A3+kB0CMj9hq1Em/gzyJtHgK3z3YYDldz3Ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmPGgmBJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9GxIEGh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmPGgmBJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9GxIEGh"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785343065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXED0YOymkUY93IzzbVvzXMgCr/sUTwfuoww0CG9rHI=;
	b=NmPGgmBJFQj8GTkH1Qbiqyagt0PTYsGug/SkmdhhzI2YlkPPKgboX6ai/BsrRyA7LUous4
	QwzfFs2wo8ImGXOW46lzehXaUEpbjSKDjopYFsoQdTRrfqLTxJwZr1ALFlrTLjnNUDyf6+
	FLi74xKMy4GGV6wlpJ2pivwzJRvyXvtN+TWF3rbdpqSfebFwK5gqJoeAmnW1s4agP3bKo0
	OxeIy4Z7uD6Vm6ebz/QAp0fFlZJPe17+QG+BFTSvxaJCeoGFksBXkINSzoQtZNbwrvM34G
	Sc5BH73SdrmZ6jPriWPv6Q5my4+X+1R6EcnbsTichFPKC5TnS+LoNBZdh785Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785343065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXED0YOymkUY93IzzbVvzXMgCr/sUTwfuoww0CG9rHI=;
	b=e9GxIEGhHlNW9hdIk0UkGlzaSV9NJMyPCm5mXCytf1RhDKDUtBYTxHJ5ZdiQKgoVUCIH/5
	m4dIuyDu77F1D0Cw==
Date: Wed, 29 Jul 2026 18:36:55 +0200
Subject: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add DT schema documentation for SoC-e FPGA switch devices.
The binding is split into:
 - a switch IP node describing the MMIO register block
 - a DSA MDIO node describing the DSA-facing switch instance
Both nodes are linked through the soce,switch-ip phandle.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++++++++++++
 .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
 2 files changed, 249 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
new file mode 100644
index 000000000000..a04e2838d14e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
@@ -0,0 +1,195 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/soce,switch-dsa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e DSA switch MDIO device
+
+maintainers:
+  - SoC-e <info@soc-e.com>
+
+description: |
+  This node is the MDIO-bus device entry for the SoC-e DSA switch driver.
+  It is a lightweight configuration node that lives on the MDIO bus of the
+  SoC Ethernet controller acting as the DSA conduit (CPU port).
+
+  The switch hardware itself (MMIO register interface) is a separate IP core
+  described by a companion node with one of the SoC-e compatible strings,
+  for example:
+    - soce,mrs-<version>
+  See the consolidated IP-core binding:
+    - Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
+  The two nodes are linked via the "soce,switch-ip" phandle property.
+
+  Port sub-nodes follow the DSA port binding documented in dsa-port.yaml.
+  User ports should reference PHY nodes through "phy-handle". These PHY nodes
+  live under the optional "mdio" child node of the switch and are exposed on
+  the switch's synthetic DSA user MDIO bus.
+
+  The PHY-specific properties "soce,mdio-output" and "soce,phy-addr" describe
+  the MDIO bus index and hardware PHY address used by the on-chip MDIO master
+  of the switch IP core.
+
+properties:
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  compatible:
+    const: soce,switch-dsa
+
+  reg:
+    description: MDIO address of this device on the parent MDIO bus.
+    maxItems: 1
+
+  soce,switch-ip:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the SoC-e switch IP core node that provides the MMIO register
+      window for this switch instance. The referenced node must carry a
+      compatible string documented in
+      Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml.
+
+  dsa,member:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    description:
+      DSA cluster membership; see Documentation/devicetree/bindings/net/dsa/dsa.yaml.
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    description: |
+      Optional child MDIO bus exposing PHY devices attached to switch user
+      ports. PHY nodes referenced by port "phy-handle" properties should be
+      placed here. The PHY address seen by Linux on this bus is the switch port
+      index, not necessarily the hardware PHY address selected internally by
+      the switch IP.
+    unevaluatedProperties: false
+
+    patternProperties:
+      "^ethernet-phy@[0-9a-f]+$":
+        type: object
+        $ref: /schemas/net/ethernet-phy.yaml#
+        unevaluatedProperties: false
+        description:
+          PHY attached to a switch user port through the synthetic switch MDIO
+          bus.
+        properties:
+          soce,mdio-output:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Zero-based index of the MDIO bus output of the switch IP core to
+              which this PHY is connected.
+
+          soce,phy-addr:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Hardware PHY address on the MDIO bus selected by
+              "soce,mdio-output".
+
+        required:
+          - soce,mdio-output
+          - soce,phy-addr
+
+  ports:
+    type: object
+    description: Container node for the switch port sub-nodes.
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^port@[0-9a-f]+$":
+        $ref: dsa-port.yaml#
+        unevaluatedProperties: false
+        description: |
+          Switch port. In addition to the standard DSA port properties
+          (label, phy-mode, ethernet, fixed-link) the following
+          vendor-specific properties are used for data ports connected to
+          external PHYs.
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - soce,switch-ip
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    /* Excerpt from a Xilinx ZynqMP design (ARM64) */
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        soce_switch: switch@10 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "soce,switch-dsa";
+            reg = <0x10>;
+            soce,switch-ip = <&soce_switch_ip>;
+            dsa,member = <0 0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0x0>;
+                    label = "PORT_0";
+                    phy-handle = <&switchphy0>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@1 {
+                    reg = <0x1>;
+                    label = "PORT_1";
+                    phy-handle = <&switchphy1>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@2 {
+                    reg = <0x2>;
+                    label = "INTERNAL_PORT";
+                    ethernet = <&gem3>;
+                    phy-mode = "gmii";
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+            };
+
+            mdio {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+                switchphy0: ethernet-phy@0 {
+                    compatible = "ethernet-phy-ieee802.3-c22";
+                    reg = <0x0>;
+                    soce,mdio-output = <0x00000000>;
+                    soce,phy-addr = <1>;
+                };
+
+                switchphy1: ethernet-phy@1 {
+                    compatible = "ethernet-phy-ieee802.3-c22";
+                    reg = <0x1>;
+                    soce,mdio-output = <0x00000001>;
+                    soce,phy-addr = <1>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
new file mode 100644
index 000000000000..ba9bb396235f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/soce,switch-ip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC-e Ethernet Switch IP core
+
+maintainers:
+  - SoC-e <info@soc-e.com>
+
+description: |
+  SoC-e Ethernet switch IP cores are configurable FPGA switch fabrics with
+  Layer-2 bridging features (including STP/MSTP state control and FDB
+  fast-age support). Some variants also provide TSN functionality.
+
+  This binding describes only the MMIO switch IP core node. The Linux DSA
+  driver is bound via a companion MDIO node described in:
+    Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml.
+
+properties:
+  compatible:
+    enum:
+      - soce,mrs-21-01
+      - soce,mrs-23-02
+      - soce,mrs-24-01
+
+  reg:
+    description: |
+      MMIO base address and size of the switch register window.
+      On 64-bit platforms (ARM64), this is typically encoded as two-cell
+      address and two-cell size values.
+    maxItems: 1
+
+  soce,num-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Total number of switch ports (external/user ports plus the CPU uplink
+      port). Must be greater than zero and not exceed the selected IP variant.
+
+required:
+  - compatible
+  - reg
+  - soce,num-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    switch_ip: switch@80020000 {
+        compatible = "soce,mrs-24-01";
+        reg = <0x0 0x80020000 0x0 0x10000>;
+        soce,num-ports = <3>;
+    };

-- 
2.39.5

