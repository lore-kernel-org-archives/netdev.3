Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3E3A6EEC;
	Thu, 10 Sep 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026418; cv=none; b=Z0hvZhl4BC2yjbHnrN+p7XDSddDQvV6XTTTjXqPOG+LgtI6bUVQxwARAl8awrwmhwCWOf1nFthmb81YIjX0Mp+28riHefP9K1f2GshOe3Zs7evBZhCUAyxhzcAnl2MjRdzo+LdtC43Me/KV1FQT7TkOQ99oQQxpohs/RIU2296E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026418; c=relaxed/simple;
	bh=goJTZWc3/Z6RtJ73HCKX+/B+S7fXYAJtedHBxpIsePQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqX4HhVH/JsfaL6qg3aD8b7bek9cmowGupd2y/BNw+h99/NGAtiRHSr9wI9Cm/WvM/JE8zTl7K64tL+ZJ6qvlvVJ+STj77HkOT8yl4lf1w8Q3tWkcdwsFmcSi7Newn5NQkYmpjbjvYEQMoBO7Li6wJGcTXrbBqW4xsOuAKshe4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08438314|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0565204-0.00345749-0.940022;FP=16780861628771732659|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jAJ7K70_1789026394;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jAJ7K70_1789026394 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 15:46:34 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH v16 2/2] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Thu, 10 Sep 2026 15:46:24 +0800
Message-Id: <20260910074624.2426899-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
References: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Motorcomm YT8824 PHY package.

Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.

Document the required property to make the PHY package correctly
configure and work.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 .../bindings/net/motorcomm,yt8824.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
new file mode 100644
index 000000000000..9907a4a7e63e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
@@ -0,0 +1,63 @@
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
+description: |
+  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
+
+$ref: ethernet-phy-package.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id4f51.e8b8
+
+  motorcomm,interface-mode:
+    description: |
+      PHY package interface mode.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - internal
+      - usxgmii
+    default: internal
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "ethernet-phy-id4f51.e8b8";
+            reg = <9>;
+
+            motorcomm,interface-mode = "usxgmii";
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
-- 
2.25.1

