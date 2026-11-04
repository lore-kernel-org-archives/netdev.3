Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772410;
	b=NfcBEAJALk4Bzz1wtWpxElIjB2T+PbFpk7YPkYf+sn5/bY0ziCR07gLfmVJ4vvOS99GP
	 eMmgnU3RfGwAc7KfmYq0Gq8DkufTmx/fvXJ+DobD3GxYkQIH+4Q50FlFvYqTRyjshyl+A
	 Kb9A4TJse2EOIKw+w5+bl7i4Ny8lCD8pO/pRa6bSun1JNWXl5KXZLi4NDnzlN5FsMcW7P
	 O5/eZIZL6eVloujMcyzUtSy7TbhZBWz9jejU5HNYCVLPNx2ZR9WLOLT3RE46IGjdo5GnJ
	 ejCRqo4o17kQqb2ZciSwFabF/Y6GY87Gma2ZzyXJhuyvDWkK+x3h8GtQWPiN5YkIMNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772410;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0PBEB2iCcaK9RR4gQpZgC/ytOZ8XK6rK6IykUhc9wLc=;
	b=VJbVjevsDccaiNP+SUKE5hyX8iV4ziQ97FHUdpe1Nr2cUqeJN82ZgqGGpam2z3bjwHQm
	 zERhB2aE+ErtcKTHT1foVi5VbxBlPqVMyj0Hf3uYRH2ocGoFKPtT0rdrUaKtw9Gqhy/Vb
	 Hv5DJEbNyk2Sosfb94hhDYMNDbb+Q91LWhJhTDImLJ1tACc3/WtgYYRGnR1oDZ8af1L7G
	 GNCO96C1QLvNqwY4MpelqMEFsdI55OtioZ+JAyjh7WsErHTnwncccfbeC/KilXTsYoueN
	 +N5Q9MQdqQw76sfEzd7QjtdiC8UmqQnxGrd2PJXrOkMnFc9HECaSVFIPKfjwegCcuGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.125
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70F606A335;
	Wed,  4 Nov 2026 06:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E70F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07414123|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.04611-0.00409288-0.949797;FP=16348517155194078385|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jwJZ9M5_1793772402;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jwJZ9M5_1793772402 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 14:06:42 +0800
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
Subject: [PATCH net-next v28 1/3] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Wed,  4 Nov 2026 14:06:34 +0800
Message-Id: <20261104060636.3901918-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104060636.3901918-1-kyle.switch@motor-comm.com>
References: <20261104060636.3901918-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
index 09713dc4c6a7..88cf721a1c7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18810,8 +18810,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
 
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

