Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462790;
	b=tc5zEo7xtBTr99KXqQdG1+zULdKhs4Z7mOSNbHOWxDaYHfXMSNgPEBw2db5N4zFsFIXN
	 9Ihcx4zHxuZqAuR/XjYmFtP4sDneRVMlHfDI+8KQn/7Fai01IbV8w/t6LSREC1ikI5viL
	 C0sF/gFmfzHokhPMxzB8DEVEu7ZvXmsbMQZTicKyEgtygLisXvcOt6pCKj7j9Q3shznNt
	 bfplqZIfI//yvP62rLwFP8FkdOnQSf3Oi/9w8iu7+IjcB8XbTqo0Vq90oyHZhngEZEzKh
	 aKfMvI8UAUKLGb51gu9U5ltjK8DwG4UkqTYoPs8NolWwtIXy84M/6OfP/8H+u6muMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462790;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tOWqvx8Woy+LjEMc10+JDnPfWEgPryv4jjUFViIsT6A=;
	b=0UFU4/SE7rzliY42ZkeUMiLqfQOqX234WMFonJXjAv0y0M9yg1HpjFu8FDAzGrThq7qE
	 DfgPn/hbuRaQgByyjG02riEG+PO3lTYLQgh/NlsLhjYsGK0G9Oqe6h0eQOHIs5MTeYTeL
	 dV8JOS8xwQiZFcbufCxWrM9aIwCwu7Uw31QRCUALYLfntPyHO/fQ1zt4H7dThZNnWptNz
	 4+gBEp7K4lX8SRmkWeKL6aKUQJnUiigLrDOUHJ4vNjvCcLiDMG0VvXIuWDo5DBIUCDIiw
	 k6kxlJe8t0BftwPKJcraWu87UuO0Ad29LLCOs45XYK5WHS2iimFKoSlZrm+5eKvf0Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35490606A31A;
	Tue, 20 Oct 2026 02:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35490606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07425008|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.04611-0.00409288-0.949797;FP=16348516055681926321|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jlJBm5M_1792462776;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlJBm5M_1792462776 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 10:19:37 +0800
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
Subject: [PATCH net-next v27 1/3] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Tue, 20 Oct 2026 10:19:27 +0800
Message-Id: <20261020021929.3028490-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
References: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
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
index 23e9194483d9..ac8e12e7b839 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18424,8 +18424,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
 
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

