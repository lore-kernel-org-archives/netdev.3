Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88957409632;
	Wed,  8 Jul 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502331; cv=none; b=g7zYNbrRGmYFn5lX7NIWw4OcIRgERiJWcCs4CiaILE0lEhLRScyn1BV5sq1Do92+2Ai4dVibLRW26WLrZWoWIS+FzIShPzHIEk/CNg2Rn439/lK3NGmnHB1bk16YZCXEWx/1ICUHF1xxcxgJSm/DjG32xXopA0EDEgKbUek092U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502331; c=relaxed/simple;
	bh=ufp1lS6pxtZ9XdxO7KaFz0KpYqv1ad4/N2+2EvTjmE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JRltdUKfBAPg6C8WOat1taIolBpfEweUreaEc7zEagAjOAIJwm/eXzkyfJBUFflBizDT5SpW+maqbN01Kv66y3SpA0f7N3qxwHW5n6lUA0lUmJQiAhzFG2GIjh5ryeRANhO45COQZQbB9jSvb4E21Iu4lUKAQEarou7HkxDJnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fq7U9H9y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fq7U9H9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1783502331; x=1815038331;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ufp1lS6pxtZ9XdxO7KaFz0KpYqv1ad4/N2+2EvTjmE8=;
  b=Fq7U9H9y2KhN045vPRhE+bnMAm490Y10h1YkRArmoaopsyRPD6EDmUm3
   Jo/P9mFQktCbZYhGvUWXHIIdzMOxy/W5mxcNb6N2gDkDPwBDfJDLrAXrH
   EfbXs8du30VUwARf1Y66cJtF7SGe3hICAR65h0Fkh+QlPo3zsP+BeKMZd
   wAoCaTCr0GJRCKAv1jq9zbLr9+Oh+AOiK5eKcOLkMtvaToPVi0KSEkNBU
   m8TVxQ78pdmS7Ppq25soawSmjmN1Tp4GXzQZ/+brG5hAdbgunaCj6s+fw
   n2g4l6Vjq3Bh6j93Xjhy5BZlcV45ZWuKHqOKdHpWU/OhVKTedpYwjydP8
   g==;
X-CSE-ConnectionGUID: M45luJsEQUWg9gPNmvoV5A==
X-CSE-MsgGUID: 3GRDzvBrSqGA/wLPugqoew==
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="69588816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:18:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 8 Jul 2026 02:18:48 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 8 Jul 2026 02:18:44 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Wed, 8 Jul 2026 11:18:17 +0200
Subject: [PATCH net-next v9 2/9] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260708-dsa_lan9645x_switch_driver_base-v9-2-0d1512a326d7@microchip.com>
References: <20260708-dsa_lan9645x_switch_driver_base-v9-0-0d1512a326d7@microchip.com>
In-Reply-To: <20260708-dsa_lan9645x_switch_driver_base-v9-0-0d1512a326d7@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Add bindings for LAN9645X switch. We use a fallback compatible for the
smallest SKU microchip,lan96455s-switch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
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
 .../net/dsa/microchip,lan96455s-switch.yaml        | 111 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
new file mode 100644
index 000000000000..043fb48922b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
@@ -0,0 +1,111 @@
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
+description:
+  The LAN9645x switch is a multi-port Gigabit AVB/TSN Ethernet switch with
+  five integrated 10/100/1000Base-T PHYs. In addition to the integrated PHYs,
+  it supports up to 2 RGMII/RMII, up to 2 BASE-X/SERDES/2.5GBASE-X and one
+  Quad-SGMII interfaces.
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
+    maxItems: 1
+
+  ethernet-ports:
+    type: object
+    patternProperties:
+      "^ethernet-port@[0-8]$":
+        type: object
+        description: Ethernet switch ports
+
+        $ref: dsa-port.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          rx-internal-delay-ps:
+            const: 2000
+
+          tx-internal-delay-ps:
+            const: 2000
+
+$ref: dsa.yaml#/$defs/ethernet-ports
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
+    ethernet-switch@4000 {
+        compatible = "microchip,lan96459f-switch", "microchip,lan96455s-switch";
+        reg = <0x4000 0x244>;
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-port@0 {
+                reg = <0>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy0>;
+            };
+
+            ethernet-port@1 {
+                reg = <1>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy1>;
+            };
+
+            ethernet-port@2 {
+                reg = <2>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy2>;
+            };
+
+            ethernet-port@3 {
+                reg = <3>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy3>;
+            };
+
+            ethernet-port@7 {
+                reg = <7>;
+                phy-mode = "rgmii";
+                ethernet = <&cpu_host_port>;
+                rx-internal-delay-ps = <2000>;
+                tx-internal-delay-ps = <2000>;
+
+                fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
+...
+
diff --git a/MAINTAINERS b/MAINTAINERS
index f261c378eff3..8e507eaf7393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17626,6 +17626,7 @@ M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
 F:	include/linux/dsa/lan9645x.h
 F:	net/dsa/tag_lan9645x.c
 

-- 
2.52.0

