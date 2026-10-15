Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921814B203E;
	Thu, 15 Oct 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051577; cv=none; b=u3uSJGH3qq1Jilgy4vdJ+jY0Ee0PtJIpJz41usPM3+RagYFUYVFRS00W6EA84dZjzAjndMV6k5tswa36wsy+beOglnjhAgUMsLVd2cEqJeAf1dx2nepzBb5zky3+BtzEuY/f9gbT2PgNMYXnhzfoaaI/D3P+M18FwvwHmNPEq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051577; c=relaxed/simple;
	bh=3uZu4CPCotD+0cNMwp7Dg/mpnyo0yBKDqTDh2UwuPUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GQjkff9MJ9ofV7yiZJVr0YrBXGEbIE60WFJf8tB4H5FUgUmTE+VkNx0+3ZWj60BSU+XTtbAoIeI3/6e/RL3A8OGszap31fTKzgJMXseM1AjZtnRt9GOWd1ibNrXNYFAIiIBCMVbqlOICP0xXMkNqMv3id/h7U1LM/ThpXLzdQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fr2kimhi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fr2kimhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051575; x=1823587575;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3uZu4CPCotD+0cNMwp7Dg/mpnyo0yBKDqTDh2UwuPUc=;
  b=fr2kimhib1Y4QgqOno931RBw5iBWDPj3h5CxkddiTEJ0Xj3T1SyVa84p
   QRsClOcHQJQtUU9YzXWE6JX/kkwxKao24Rwlz89X4058akWMavI+N+S7Y
   SOO4M/V8ZwUT2ITQP9ew6pTtop30BcgNbG3km2u0k2UwpjSKhOat2wEzd
   Z2YwivjSsbLvTFljb2nixXMKg4lRuXGXJPtoH/tg/obIIH8E5DKPLp+QA
   kpv8COiGHocuf+Kkk/3y11Gku9Z4jZHXNpqjr7+q55Txilf7XWCkHUXjF
   akxKNcKEtU3/BSZJy0R50x4u6WaePusDy7yvs1p/KG8xLiuAULXti06GV
   g==;
X-CSE-ConnectionGUID: DEZ+gd3jTAe7LLWlEdvqxQ==
X-CSE-MsgGUID: dadPnMjNQ92aSIPJaDAjxg==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="65077872"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 01:06:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 15 Oct 2026 01:06:14 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:06:10 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 15 Oct 2026 10:05:56 +0200
Subject: [PATCH net-next v15 2/9] dt-bindings: net: dsa: add Microchip
 LAN9645x switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261015-dsa_lan9645x_switch_driver_base-v15-2-562f316f78b9@microchip.com>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
In-Reply-To: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Add bindings for LAN9645X switch. We use a fallback compatible for the
smallest SKU microchip,lan96455s-switch. The last digit of the part number
is the number of usable front ports and the letter is the feature set.

The switch is a child of an externally controlled parent that hands out
one regmap per register target, so reg and reg-names describe the target
layout the way mscc,vsc7514-switch.yaml does for the equivalent
mscc,vsc7512-switch node. That binding, and the mfd parent it hangs off
in mscc,ocelot.yaml, is the model this driver and its parent follow.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v14:
- Use the dt-bindings: net: dsa: subject prefix and do not repeat
  "bindings" in the subject.
- Describe all switch register targets in reg, and the analyzer and
  PTP interrupts.

Changes in v13:
- Remove section quoting Documentation/networking/phy.rst from commit
  message.
- Remove rx/tx-internal-delay-ps from example.

Changes in v12:
- Remove Rob's Reviewed-by
- Match both the port@ and ethernet-port@ spellings, so the per port
  constraints apply. dsa.yaml accepts either, and the local pattern only
  matched the long form.
- Allow 0 as well as 2000 for rx/tx-internal-delay-ps, matching what the
  driver accepts, and restrict them to those two values on RGMII ports.
- Constrain the ethernet-ports node the way renesas,rzn1-a5psw.yaml does,
  with additionalProperties instead of a local dsa-port.yaml $ref.
- Put the example properties in canonical order, so dt-check-style
  --mode=strict is clean.
- Describe the switch register targets in reg, with a matching reg-names,
  following mscc,vsc7514-switch.yaml.
- Document the default of rx/tx-internal-delay-ps, as
  microchip,lan937x.yaml does.
- Describe the SKU naming in the binding description.

Changes in v5:
- No changes.

Changes in v4:
- No changes.

Changes in v3:
- remove additionalProperties: true
- remove unnecessary | from description
- change top level $ref to dsa.yaml#/$defs/ethernet-ports
- use ethernet-ports and ethernet-port
- move ethernet-ports under properties instead of patternProperties
- move unevaluatedProperties: false after $ref
- update example to use ethernet-ports and ethernet-port

Changes in v2:
- rename file to microchip,lan96455s-switch.yaml
- remove led vendor property
- add {rx,tx}-internal-delay-ps for rgmii delay
- remove labels from example
- remove container node from example
---
 .../net/dsa/microchip,lan96455s-switch.yaml        | 208 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 209 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
new file mode 100644
index 000000000000..517bc4c00de3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/microchip,lan96455s-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN9645x Ethernet switch
+
+maintainers:
+  - Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
+
+description: |
+  The LAN9645x switch is a multi-port Gigabit AVB/TSN Ethernet switch with
+  five integrated 10/100/1000Base-T PHYs. In addition to the integrated PHYs,
+  it supports up to 2 RGMII/RMII, up to 2 BASE-X/SERDES/2.5GBASE-X and one
+  Quad-SGMII interfaces.
+
+  The part number encodes the SKU. The last digit is the number of usable
+  front ports, 5, 7 or 9. The letter is the feature set, f for full and s for
+  standard, where full adds HSR, PRP, TAS, frame preemption and PSFP.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - microchip,lan96455s-switch
+      - items:
+          - enum:
+              - microchip,lan96455f-switch
+              - microchip,lan96457f-switch
+              - microchip,lan96459f-switch
+              - microchip,lan96457s-switch
+              - microchip,lan96459s-switch
+          - const: microchip,lan96455s-switch
+
+  reg:
+    items:
+      - description: General configuration block target
+      - description:
+          CPU device queue system target, the register based frame injection
+          and extraction interface
+      - description: Precision Time Protocol target
+      - description: Chip top level target
+      - description: Time aware shaper target
+      - description: Rewriter target
+      - description: VCAP ES0 target, egress stage 0 classification
+      - description: OAM MEP target
+      - description: VCAP S1 target, ingress stage 1 classification
+      - description: VCAP S2 target, ingress stage 2 classification
+      - description: Switching engine target
+      - description: HSIO target
+      - description: Port 0 device target
+      - description: Port 1 device target
+      - description: Port 2 device target
+      - description: Port 3 device target
+      - description: Port 4 device target
+      - description: Port 5 device target
+      - description: Port 6 device target
+      - description: Port 7 device target
+      - description: Port 8 device target
+      - description: Queue system target
+      - description: Automatic frame injector target
+      - description: Analyzer target
+
+  reg-names:
+    items:
+      - const: gcb
+      - const: qs
+      - const: ptp
+      - const: chip_top
+      - const: tas
+      - const: rew
+      - const: vcap0
+      - const: mep
+      - const: vcap1
+      - const: vcap2
+      - const: sys
+      - const: hsio
+      - const: dev0
+      - const: dev1
+      - const: dev2
+      - const: dev3
+      - const: dev4
+      - const: dev5
+      - const: dev6
+      - const: dev7
+      - const: dev8
+      - const: qsys
+      - const: afi
+      - const: ana
+
+  interrupts:
+    items:
+      - description: PTP timestamp ready interrupt
+      - description: PTP synchronization interrupt from the PTP pins
+      - description: Analyzer interrupt
+
+  interrupt-names:
+    items:
+      - const: ptp
+      - const: ptp-ext
+      - const: ana
+
+  ethernet-ports:
+    type: object
+    additionalProperties: true
+    patternProperties:
+      "^(ethernet-)?port@[0-8]$":
+        type: object
+        description: Ethernet switch ports
+        additionalProperties: true
+
+        allOf:
+          - if:
+              properties:
+                phy-mode:
+                  contains:
+                    enum:
+                      - rgmii
+                      - rgmii-rxid
+                      - rgmii-txid
+                      - rgmii-id
+            then:
+              properties:
+                rx-internal-delay-ps:
+                  $ref: "#/$defs/internal-delay-ps"
+                tx-internal-delay-ps:
+                  $ref: "#/$defs/internal-delay-ps"
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+$defs:
+  internal-delay-ps:
+    description:
+      Disable the delay line using 0 ps, or enable the 2000 ps delay. The
+      delay line is not tunable, so no other phase can be selected.
+    enum: [0, 2000]
+    default: 0
+
+examples:
+  - |
+    ethernet-switch@4000 {
+        compatible = "microchip,lan96459f-switch", "microchip,lan96455s-switch";
+        reg = <0x4000 0x244>, <0x8000 0x4c>, <0xc000 0x1f0>,
+              <0x10000 0x134>, <0x14000 0x2c8>, <0x18000 0x1910>,
+              <0x1c000 0x468>, <0x20000 0x1480>, <0x24000 0x468>,
+              <0x28000 0x468>, <0x2c000 0x12d4>, <0x30000 0xe4>,
+              <0x38000 0xb8>, <0x3c000 0xb8>, <0x40000 0xb8>,
+              <0x44000 0xb8>, <0x48000 0xb8>, <0x4c000 0xb8>,
+              <0x50000 0xb8>, <0x54000 0xb8>, <0x58000 0xb8>,
+              <0x100000 0xa000>, <0x120000 0x1998>, <0x140000 0x7468>;
+        reg-names = "gcb", "qs", "ptp", "chip_top", "tas", "rew", "vcap0",
+                    "mep", "vcap1", "vcap2", "sys", "hsio", "dev0", "dev1",
+                    "dev2", "dev3", "dev4", "dev5", "dev6", "dev7", "dev8",
+                    "qsys", "afi", "ana";
+        interrupts = <27>, <26>, <17>;
+        interrupt-names = "ptp", "ptp-ext", "ana";
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-port@0 {
+                reg = <0>;
+                phy-handle = <&cuphy0>;
+                phy-mode = "gmii";
+            };
+
+            ethernet-port@1 {
+                reg = <1>;
+                phy-handle = <&cuphy1>;
+                phy-mode = "gmii";
+            };
+
+            ethernet-port@2 {
+                reg = <2>;
+                phy-handle = <&cuphy2>;
+                phy-mode = "gmii";
+            };
+
+            ethernet-port@3 {
+                reg = <3>;
+                phy-handle = <&cuphy3>;
+                phy-mode = "gmii";
+            };
+
+            ethernet-port@7 {
+                reg = <7>;
+                ethernet = <&cpu_host_port>;
+                phy-mode = "rgmii";
+
+                fixed-link {
+                    full-duplex;
+                    pause;
+                    speed = <1000>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ef705ac0cc60..4406c428ac0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17819,6 +17819,7 @@ M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
 F:	include/linux/dsa/lan9645x.h
 F:	net/dsa/tag_lan9645x.c
 

-- 
2.52.0

