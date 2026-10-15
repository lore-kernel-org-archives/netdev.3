Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315637C926;
	Thu, 15 Oct 2026 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075843; cv=none; b=QvvfN1zLnoBUTVgmSIXB4v3OLT52EiS79ASW9J3e7+R24Tu2/P6ORxoq0X4B+p/Aen1ds5FhWDN2/nsh6zjHdAQFIRn4kBd091zxTMtBdYIo9uoRrVCl+SVmj/H1C14co1hzQvtR5oEHtnBtYElkcuYhdYmWVTYlej4sxEch0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075843; c=relaxed/simple;
	bh=I2DMrmyL8hpMdcOCuget3c2bHKZbarHbTu2GJp6GTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Orx8gU9a3N6tMnJw5lIp+DZPZ6br1MFkwddLrJqShxxTe7hFEDXy5Jl3GfVIeRDrhng4smSCnKwbFgvShk2waF0QzLPawD55+t9mwZZ0LsjkHdelzNWpx8wnefjY1MOPSDzRArdBw3ExJUi2eiFuDczMse8BCJauRrpNcqW2lD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07497911|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.04611-0.00409288-0.949797;FP=16348516055682450675|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jexT-Ef_1792075828;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jexT-Ef_1792075828 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 22:50:28 +0800
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
	jianmin.wang@motor-comm.com
Subject: [PATCH net-next v25 1/3] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Thu, 15 Oct 2026 22:50:19 +0800
Message-Id: <20261015145021.2216003-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015145021.2216003-1-kyle.switch@motor-comm.com>
References: <20261015145021.2216003-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 .../bindings/net/motorcomm,yt8824.yaml        | 78 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
new file mode 100644
index 000000000000..4c67f8afcf27
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
@@ -0,0 +1,78 @@
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
+
+  motorcomm,package-mode:
+    description: |
+      PHY package can be configured in 2 modes:
+      - internal: YT8824 is embedded in the switch, using
+        an internal interface to the MAC.
+      - 10g-qxgmii: YT8824 is a standalone external PHY,
+        connected via 10G QXGMII.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ internal, 10g-qxgmii ]
+
+  reg:
+    description:
+      The absolute MDIO address of the YT8824 shared top extend
+      register block.
+      For internal mode, this is fixed at 9;
+      For external mode, it is the base MDIO address of the four
+      member PHYs plus 4, where base is typically 0x0.
+      Note that this is NOT the reg of the first member PHY.
+
+required:
+  - compatible
+  - motorcomm,package-mode
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
+            motorcomm,package-mode = "internal";
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
index 509b35b5a0e7..572f6b26ae6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18427,8 +18427,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
 
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

