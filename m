Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D54F30DB;
	Thu,  3 Sep 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459111; cv=none; b=TopqM38J10bxki/TsyY2anEObf38m8j7SmKGl7U9YMWLiMcr+S8EIk25SLijkgJXKlrt/7/+DR+dlaVe43WFWbiKFasyrT5KJ1k/1u6gr3y233TmdL7hnvlA6Wduh0SVxkmodDiPU824JqCvkZQEqrRb2pdkvNKMfK6zwHu2hAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459111; c=relaxed/simple;
	bh=7FNsE5hcmXuh8cncWSUzASxF4qar/Wb9kp6VEMi534M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfZNriuyLkrmcilzDqXBLmfeonBv0TgeTBA+yUwsDqHptN9e/K8VhTpXO0w6BYNtT8GKswfs8Hg7dIjZF31C8RM/XiZXNpUuRYHucevv505xffwOlY2btOAJt3horcisfYSohZnfr/XD4pck2itxjFxvh9FiBNGN/DRf1JsjZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WE3at6xK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GhTKBeBS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WE3at6xK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhTKBeBS"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788459104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkHy7NSqEWamgXkltGyNSAtC+2Gpn9ky7tURJQV0C88=;
	b=WE3at6xKVji4YDbuhFWAsRtoBNE0tYHTev3gDQFQEeid6HREYCBaGIKDAhNanqRdxoiv+l
	UQxQoWlPz+jG5WIPlmAlNYr4FNq0DIiXIpT6+0UowHO7+Mxw7fVuKZRKYjSgHM1AiZg3n7
	R8WwZDhvvoFpdbyG25mdvcjGPco2yrU1pGblFgkycI5cFOAMWcJejg/jEXTSNinPEvvTGD
	zi4SobX4+pEC+cbXWNDPe3n5b/kB9lQmSxSWs5ALTvZ17v3oe4FUxyy6nTuK4jI77GHhVP
	9GjIOlp5ntPbIrbbuSAhVXfVOP8bLLEtTTnAVt0Yp9oIGZIEE5teQH+DOZcNGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788459104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkHy7NSqEWamgXkltGyNSAtC+2Gpn9ky7tURJQV0C88=;
	b=GhTKBeBSjgnEHdUGHveVvAM6p2ZuWHHxjCs+urTspvzkQg5BLwQFKPGEDZ/fRVXVohpepn
	EOgylgg1OxYT8bDQ==
Date: Thu, 03 Sep 2026 20:10:59 +0200
Subject: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add a binding for SoC-e FPGA-based Ethernet switch IP cores.

The compatible identifies a register layout characterized by the core
and feature identification registers at the encoded offsets. The
concrete synthesis-time configuration is then autodetected from these
registers.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 .../devicetree/bindings/net/dsa/soce,swip.yaml     | 161 +++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
new file mode 100644
index 000000000000..508e444e10da
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/soce,swip.yaml
@@ -0,0 +1,161 @@
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
+  to CPUs, external PHYs, FPGA logic, or other switch cores. The
+  integrated MDIO controller provides multiple independently selectable
+  external outputs.
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
+  mdios:
+    type: object
+    additionalProperties: false
+    description:
+      External MDIO buses provided by the integrated MDIO controller.
+      Each child bus selects one controller output.
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^mdio@[0-9a-f]+$':
+        $ref: /schemas/net/mdio.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maximum: 30
+            description:
+              MDIO controller output index, which must be lower than the
+              number of implemented switch ports.
+
+        required:
+          - reg
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+patternProperties:
+  '^(ethernet-)?ports$':
+    patternProperties:
+      '^(ethernet-)?port@[0-9a-f]+$':
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
+          - phy-mode
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch@80020000 {
+        compatible = "soce,swip-00-04-0c-10";
+        reg = <0x80020000 0x10000>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                label = "lan0";
+                phy-handle = <&switchphy0>;
+                phy-mode = "rgmii-id";
+            };
+
+            port@1 {
+                reg = <1>;
+                label = "lan1";
+                phy-handle = <&switchphy1>;
+                phy-mode = "rgmii-id";
+            };
+
+            port@2 {
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
+
+        mdios {
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
+    };

-- 
2.39.5

