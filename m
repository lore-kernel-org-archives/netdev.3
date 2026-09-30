Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D484DE70B;
	Wed, 30 Sep 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799552; cv=none; b=EsnAlDnKLp1/suQC7Jzx9hiDDD30/mIbbKEnWnZKQ8//DvUIbaz0Wj99VKi5pFBj2QzrzyQSp06HbOJy8aJHoCZXMHMpzAlAlWOsghog2K61NNTEuuzCzCxfLVRgDa9LhEnmU4XlR9X7mn2gHUx5MikAIKzNLNo49GSTtknLb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799552; c=relaxed/simple;
	bh=/P80oLdzT3MqhUsijCt/NSoUFpynVYFCzz3SO+yf98s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLJWY6O6AztTodJeZbduuoDtFCkyKn9CWnGWjelontAMDw1xYSxCZDUWJjvP8wgQqyxdxLqnPcpTLfNQ49k6a5X5xFl0nPnDV8DnD7/u4AIiXLO8MFFK3CkXbFKWVka+Y+qXovquzzCvrZwAS7gpXCeIdFkwrB7NuF3Mpc6T8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWT5fVb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWT5fVb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EBC1F000FF;
	Wed, 30 Sep 2026 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799550;
	bh=WO5VwyVU3tfmHe7oDLPSrsrphAmaRpvLxzIfqn76wj0=;
	h=From:To:Cc:Subject:Date;
	b=nWT5fVb8zOs+z4LB6wSClfgu4JwR1zRcgVyAaRaQN4+1EyJpPfSRSPnxHlDVNoZl6
	 3K1GSzELKWZNhpAA0jfwu83HqvhfpSRQ3IcxPW2DxWcrCALpHdSPj2Hma5GZbMywBI
	 dCLE63JFAOOVHOVEpkVO10CGQhNUI1hqvnJSggfq+lbaFe8w+lv1LSrgB2P8btrl7G
	 gB/lo6WkrmonUyLq0VOw5+jaGcME4pezbM4tmC9QWgi25Q+jtRApltEZC40kvs0Ume
	 srTJN9R1Hr21chfHh+OB3VV9Cjaa/NamOFWc83nb7DHorAkg5db+rkbObJjV99oqxN
	 Znb+SEfzYZ89w==
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
Subject: [PATCH net-next v2] dt-bindings: net: Convert hisilicon,hns-mdio to DT schema
Date: Wed, 30 Sep 2026 15:19:04 -0500
Message-ID: <20260930201906.74125-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the hisilicon,hns-mdio binding to DT schema format. Add the
missing 'subctrl-vbase' property which is already in use.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Make subctrl-vbase required and fix the register offset descriptions
---
 .../bindings/net/hisilicon,hns-mdio.yaml      | 61 +++++++++++++++++++
 .../bindings/net/hisilicon-hns-mdio.txt       | 27 --------
 2 files changed, 61 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
new file mode 100644
index 000000000000..6904f9b351f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hns-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon HNS MDIO bus controller
+
+maintainers:
+  - Jian Shen <shenjian15@huawei.com>
+  - Jijie Shao <shaojijie@huawei.com>
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hns-mdio
+      - hisilicon,mdio
+
+  reg:
+    maxItems: 1
+
+  subctrl-vbase:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: syscon phandle
+          - description: MDIO clock enable register offset
+          - description: MDIO reset request register offset
+          - description: MDIO clock state register offset
+          - description: MDIO reset state register offset
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - subctrl-vbase
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mdio@803c0000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "hisilicon,hns-mdio";
+            reg = <0x0 0x803c0000 0x0 0x10000>;
+            subctrl-vbase = <&peri_c_subctrl 0x338 0xa38 0x531c 0x5a1c>;
+
+            ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
deleted file mode 100644
index 4a7ede9657b0..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Hisilicon MDIO bus controller
-
-Properties:
-- compatible: can be one of:
-	"hisilicon,hns-mdio"
-	"hisilicon,mdio"
-  "hisilicon,hns-mdio" is recommended to be used for hip05 and later SOCs,
-  while "hisilicon,mdio" is optional for backwards compatibility only on
-  hip04 Soc.
-- reg: The base address of the MDIO bus controller register bank.
-- #address-cells: Must be <1>.
-- #size-cells: Must be <0>.  MDIO addresses have no size component.
-
-Typically an MDIO bus might have several children.
-
-Example:
-         mdio@803c0000 {
-                   #address-cells = <1>;
-                   #size-cells = <0>;
-                   compatible = "hisilicon,hns-mdio","hisilicon,mdio";
-                   reg = <0x0 0x803c0000 0x0 0x10000>;
-
-                   ethernet-phy@0 {
-                            ...
-                            reg = <0>;
-                   };
-         };
-- 
2.53.0

