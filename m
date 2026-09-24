Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF643B3D8;
	Thu, 24 Sep 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236267; cv=none; b=ufKR40Sqvr9ioBalw73EBy6cHoih1tOTEMHiR15eiqANl5jXV4Twa2FRTrsw6+jUjl6EtKVgjseb0LKRMWiXtozQyhcXLTIKlt+xCVJk0HS2anss4L7d8Q3AXZCrKMwD5fqaCrJdlmZkE3H6o+lTsdcfD5nUXaLgevfyEiCaHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236267; c=relaxed/simple;
	bh=QLjEfsr7PR7u6X/5MtL/X4oP6WsRpLPR1KfJyXZB7Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYNDieqDS0yGUtjxg5gwmgmxZ4o8OwFOzq6eswGHAT9YB0P4scan2Qwz6j6yTgl9SuG/PdyTe6ZffWcwZi9YniFKmS/i0v5D2BdIGLOq7WD1pLiwfHvJFaeVLdOgEgCaJ/SWPu6bud/kc/L7HhHzwGmNt8TvVvsugL3I2gzCeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07249854|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.04611-0.00409288-0.949797;FP=16348516055955080369|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.jM7IE1._1790236254;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jM7IE1._1790236254 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 15:50:54 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Thu, 24 Sep 2026 15:50:46 +0800
Message-Id: <20260924075048.4060414-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 .../bindings/net/motorcomm,yt8824.yaml        | 69 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
new file mode 100644
index 000000000000..fd62b309e7ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MotorComm YT8824 Ethernet PHY
+
+maintainers:
+  - Kyle Switch <kyle.switch@motor-comm.com>
+
+description:
+  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
+
+$ref: ethernet-phy-package.yaml#
+
+properties:
+  compatible:
+    enum:
+      - motorcomm,yt8824-package
+  phy-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ internal, 10g-qxgmii ]
+  reg:
+    description:
+      The absolute MDIO address of the YT8824 shared top extend
+      register block.
+      For internal mode, this is fixed at 9;
+      For external mode it is (base MDIO address of the four
+      member PHYs) + 4.
+      Note that this is NOT the base ID of the first member PHY.
+required:
+  - compatible
+  - phy-mode
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@9 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "motorcomm,yt8824-package";
+            reg = <9>;
+
+            phy-mode = "internal";
+
+            ethernet-phy@4 {
+                reg = <4>;
+            };
+
+            ethernet-phy@5 {
+                reg = <5>;
+            };
+
+            ethernet-phy@6 {
+                reg = <6>;
+            };
+
+            ethernet-phy@7 {
+                reg = <7>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e3ce77c839b0..ed7af1bd9521 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18409,8 +18409,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
 
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
+M:	Kyle Switch <kyle.switch@motor-comm.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
 F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
 F:	drivers/net/phy/motorcomm.c
 
-- 
2.25.1

