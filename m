Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC444E50C7;
	Mon,  5 Oct 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232170; cv=none; b=A/uBYIka4XFQBAPtVfUgTpKYNJ22o62O9RRwCs/UVVBQJcEJHaaQjRTM/poH8nqRawgE2yOmTm0w+SsAN6hMfmuzSi9lVQWqNlR/jSgTOv+5rw6UUZE00XMoKz5QsbUIYVvfLLc/Bxnz0oosdOAQJ7VbLsoakH4P1RJd6+zpPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232170; c=relaxed/simple;
	bh=o0D8pbbn/kyVlqxRb8CcuxR/o3BHaIgIdiXzlWC6sHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACy+U2gr2h8YQ7Bkk3nPCX2kylyO2aP9S3l5n63peq56DTZcMCczylYsuZtcFbD1/hmV6FuT59dfKIWFuTtUY9h1SWl+HWRbK50eiZY+PxcbqYSjV+6Z5waNYh8nGkiHfLEEjG79Vwe988I8xbspb8v6a0MsXoHC7iRQwC0M564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP5ynW/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP5ynW/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C571F000FF;
	Mon,  5 Oct 2026 20:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791232158;
	bh=TRGfGq9Szoti9y54aNwyfNn/t4OPuYp21Qrq9BCxdDg=;
	h=From:To:Cc:Subject:Date;
	b=PP5ynW/OeaJfi/j1moETKkydlGFWYuadCnXJLD3QidDdawOFlZTzWhtuab37P3OHR
	 AhqPqo087xYhWW30CbkEtAkD/KB4w+L57p1AtglROBTqCmi4E+KJG0MhACrdbN1z2F
	 38WqxPkGGPGF1xFcWoIYCuTRGaM/PIpJP8PeWPzzmPW4mhLHSVPDDp4WZZFUSpaeVJ
	 D3IsswBrYORRaUMDQMzaH17YIHpR9xPwfqhUJeH1XZCOMRQKVzvNDBXIbpOIFAo7JG
	 GIOJrGX2QBV9OkFXjG7+EXUJEOANjAKto1wKVBNZPC84zG2wUokMweKETSNs1P27qq
	 U2fC/E9dGv7yQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] dt-bindings: net: Convert HiSilicon hns-dsaf to DT schema
Date: Mon,  5 Oct 2026 15:28:08 -0500
Message-ID: <20261005202808.1982164-2-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the HiSilicon hns-dsaf binding to DT schema format.

Drop 'phy-handle' at top level as there are no users. Add undocumented
'media-type' property.

Support for 4 'reg' regions is dropped as that has long been deprecated
and there are no known users of it.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Make subctrl-syscon, buf-size and desc-num required

v2:
 - Add constraints for buf-size and desc-num
 - Drop erroneous 1st 2 'reg' entries
 - Fix example 'reg' cell sizes
 - Add 'backplane' to 'media-type' property
---
 .../bindings/net/hisilicon,hns-dsaf-v1.yaml   | 170 ++++++++++++++++++
 .../bindings/net/hisilicon-hns-dsaf.txt       |  90 ----------
 2 files changed, 170 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
new file mode 100644
index 000000000000..4629acbba810
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Hisilicon Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hns-dsaf-v1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon DSA Fabric device controller
+
+maintainers:
+  - Jian Shen <shenjian15@huawei.com>
+  - Jijie Shao <shaojijie@huawei.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hisilicon,hns-dsaf-v1
+          - hisilicon,hns-dsaf-v2
+
+  reg:
+    minItems: 1
+    items:
+      - description:
+          PPE register base and size
+      - description:
+          DSA Fabric base register and size (not required for single-port mode)
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: ppe-base
+      - const: dsaf-base
+
+  interrupts:
+    minItems: 1
+    maxItems: 409
+
+  dma-coherent: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  mode:
+    description: DSA Fabric mode string
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - 2port-64vf
+      - 6port-16rss
+      - 6port-16vf
+      - single-port
+
+  subctrl-syscon:
+    description: syscon handle for external interface control register
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  reset-field-offset:
+    description: offset of reset field in the control register
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  buf-size:
+    description: RX buffer size (bytes)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [512, 1024, 2048, 4096]
+
+  desc-num:
+    description: number of descriptors in TX and RX queue
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 16
+    maximum: 1024
+
+patternProperties:
+  "^port@[0-5]$":
+    description: DSA Fabric port node
+    $ref: ethernet-switch-port.yaml#
+    additionalProperties: false
+
+    properties:
+      reg:
+        maximum: 5
+
+      phy-handle: true
+
+      serdes-syscon:
+        description: syscon handle for SerDes register
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      cpld-syscon:
+        description: syscon handle plus register offset for CPLD register
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          - items:
+              - description: CPLD phandle
+              - description: offset
+
+      port-rst-offset:
+        description: reset field offset for this port
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      port-mode-offset:
+        description: port mode field offset for this port
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      mc-mac-mask:
+        description: multicast MAC address mask
+        $ref: /schemas/types.yaml#/definitions/uint8-array
+        maxItems: 6
+
+      media-type:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - backplane
+          - copper
+          - fiber
+
+    required:
+      - reg
+      - serdes-syscon
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - subctrl-syscon
+  - mode
+  - buf-size
+  - desc-num
+
+additionalProperties: false
+
+examples:
+  - |
+    dsa@c5000000 {
+        compatible = "hisilicon,hns-dsaf-v1";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        mode = "6port-16rss";
+        reg = <0xc5000000 0x890000
+               0xc7000000 0x60000>;
+        reg-names = "ppe-base", "dsaf-base";
+        subctrl-syscon = <&subctrl>;
+        reset-field-offset = <0>;
+        interrupts = <131 4>, <132 4>, <133 4>, <134 4>,
+                     <135 4>, <136 4>, <137 4>, <138 4>,
+                     <139 4>, <140 4>, <141 4>, <142 4>,
+                     <143 4>, <144 4>, <145 4>, <146 4>,
+                     <147 4>, <148 4>, <384 1>, <385 1>,
+                     <386 1>, <387 1>, <388 1>, <389 1>,
+                     <390 1>, <391 1>;
+        buf-size = <4096>;
+        desc-num = <1024>;
+        dma-coherent;
+
+        port@0 {
+            reg = <0>;
+            phy-handle = <&phy0>;
+            serdes-syscon = <&serdes>;
+            mc-mac-mask = [ff f0 00 00 00 00];
+        };
+
+        port@1 {
+            reg = <1>;
+            serdes-syscon = <&serdes>;
+            mc-mac-mask = [ff f0 00 00 00 00];
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
deleted file mode 100644
index 8ee4b1cedae8..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
+++ /dev/null
@@ -1,90 +0,0 @@
-Hisilicon DSA Fabric device controller
-
-Required properties:
-- compatible: should be "hisilicon,hns-dsaf-v1" or "hisilicon,hns-dsaf-v2".
-  "hisilicon,hns-dsaf-v1" is for hip05.
-  "hisilicon,hns-dsaf-v2" is for Hi1610 and Hi1612.
-- mode: dsa fabric mode string. only support one of dsaf modes like these:
-		"2port-64vf",
-		"6port-16rss",
-		"6port-16vf",
-		"single-port".
-- interrupts: should contain the DSA Fabric and rcb interrupt.
-- reg: specifies base physical address(es) and size of the device registers.
-  The first region is external interface control register base and size(optional,
-  only used when subctrl-syscon does not exist). It is recommended using
-  subctrl-syscon rather than this address.
-  The second region is SerDes base register and size(optional, only used when
-  serdes-syscon in port node does not exist). It is recommended using
-  serdes-syscon rather than this address.
-  The third region is the PPE register base and size.
-  The fourth region is dsa fabric base register and size. It is not required for
-  single-port mode.
-- reg-names: may be ppe-base and(or) dsaf-base. It is used to find the
-  corresponding reg's index.
-
-- phy-handle: phy handle of physical port, 0 if not any phy device. It is optional
-  attribute. If port node exists, phy-handle in each port node will be used.
-  see ethernet.txt [1].
-- subctrl-syscon: is syscon handle for external interface control register.
-- reset-field-offset: is offset of reset field. Its value depends on the hardware
-  user manual.
-- buf-size: rx buffer size, should be 16-1024.
-- desc-num: number of description in TX and RX queue, should be 512, 1024, 2048 or 4096.
-
-- port: subnodes of dsaf. A dsaf node may contain several port nodes(Depending
-  on mode of dsaf). Port node contain some attributes listed below:
-- reg: is physical port index in one dsaf.
-- phy-handle: phy handle of physical port. It is not required if there isn't
-  phy device. see ethernet.txt [1].
-- serdes-syscon: is syscon handle for SerDes register.
-- cpld-syscon: is syscon handle + register offset pair for cpld register. It is
-  not required if there isn't cpld device.
-- port-rst-offset: is offset of reset field for each port in dsaf. Its value
-  depends on the hardware user manual.
-- port-mode-offset: is offset of port mode field for each port in dsaf. Its
-  value depends on the hardware user manual.
-- mc-mac-mask: mask of multicast address, determines bit in multicast address
-  to set:
-  1 stands for this bit will be precisely matched, TCAM will check this bit of
-    MAC address.
-  0 stands for this bit will be fuzzy matched, TCAM won't care about this bit
-    of MAC address.
-
-[1] Documentation/devicetree/bindings/net/phy.txt
-
-Example:
-
-dsaf0: dsa@c7000000 {
-	compatible = "hisilicon,hns-dsaf-v1";
-	mode = "6port-16rss";
-	interrupt-parent = <&mbigen_dsa>;
-	reg = <0x0 0xc5000000 0x0 0x890000
-	       0x0 0xc7000000 0x0 0x60000>;
-	reg-names = "ppe-base", "dsaf-base";
-	subctrl-syscon = <&subctrl>;
-	reset-field-offset = 0;
-	interrupts = <131 4>,<132 4>, <133 4>,<134 4>,
-		     <135 4>,<136 4>, <137 4>,<138 4>,
-		     <139 4>,<140 4>, <141 4>,<142 4>,
-		     <143 4>,<144 4>, <145 4>,<146 4>,
-		     <147 4>,<148 4>, <384 1>,<385 1>,
-		     <386 1>,<387 1>, <388 1>,<389 1>,
-		     <390 1>,<391 1>,
-	buf-size = <4096>;
-	desc-num = <1024>;
-	dma-coherent;
-
-	port@0 {
-		reg = 0;
-		phy-handle = <&phy0>;
-		serdes-syscon = <&serdes>;
-		mc-mac-mask = [ff f0 00 00 00 00];
-	};
-
-	port@1 {
-                reg = 1;
-                serdes-syscon = <&serdes>;
-		mc-mac-mask = [ff f0 00 00 00 00];
-        };
-};
-- 
2.53.0

