Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E554655;
	Fri, 25 Sep 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373561; cv=none; b=K0kZtZWVlOYVFaPY2R5XCSwyCwPXMuKJ2GYmQAsACnLgizejVXEacm/4lc+M3uTPWW4RcKjMZsjllJ3rXju7QU8eF3sqbXQBBcuGz0tUO6SLHKQL2UtIzckrkoXAxNhINYHirJ7+uuv4AqI2zNWj9PrMaQ/8BnY8KGUxc3pGlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373561; c=relaxed/simple;
	bh=bMVKKRI60tG6JPeU6IUVrsBtPVyQfzgqCicGA1Jh4qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cj8j0cPOFOn4z0LSvrTUm9Jz6s73C20XGPHB5OzbIeSR533935K6QgbiWUVUT11N6HbEtDXkNjmWovHKuC/Dh6Tddx5kCNJ7CQHc8Ne8im753p0m1vRXuzZ6mZTjiFNWDbRAEZOjJYE7s8ndNAfFHdEZwSyDgquWEoNza2Nec6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl+IDraE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl+IDraE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B4F1F000FF;
	Fri, 25 Sep 2026 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373559;
	bh=bkJckBQv+VcaGj1fhmLnEcJZbux+lPgoDTwjPDTctwI=;
	h=From:To:Cc:Subject:Date;
	b=Wl+IDraECgO51pBcLVA3hALZ9hzcvAb5gLaSBQjXxH5bVn1ZW/+hDy5N0n66a/5NZ
	 1hLwhM3us2iDMyH60F+Ct5n3g69slGXTYM6BeSUj8EeAe9wvqqu7l/+ZQvpxMu/aiC
	 LdFK92NYNkcCvwx/1MXgAQDgU/escT8k90vBxlEVX5DX6aS9DppDZyW1/64nmLr8BO
	 nRhdd2ByIzp5mA1CU00ote1rkTLB3EUwLA0mFDsY69j4NhTyDyOkJe/1GXfM2FzCYr
	 UbhHDTJkG979sPyWK1VGaVp3NHSzOykGhgwt3aZAFnPyrT3BwDrhtcJDtcqmlzlBcI
	 /oYC3e+SA26cw==
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
Subject: [PATCH net-next] dt-bindings: net: Convert hisilicon,hns-mdio to DT schema
Date: Fri, 25 Sep 2026 16:59:10 -0500
Message-ID: <20260925215911.2950356-1-robh@kernel.org>
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
 .../bindings/net/hisilicon,hns-mdio.yaml      | 59 +++++++++++++++++++
 .../bindings/net/hisilicon-hns-mdio.txt       | 27 ---------
 2 files changed, 59 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
new file mode 100644
index 000000000000..b8350794650d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
@@ -0,0 +1,59 @@
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
+          - description: MDIO reset done register offset
+          - description: MDIO reset deassert register offset
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
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

