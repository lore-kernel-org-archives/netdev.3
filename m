Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE1379ED2;
	Sat, 12 Sep 2026 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789196283; cv=none; b=UOJBcXG1VuueJBeZ0F2Lr4+QkmSuetstqH6Nv3AZwkcyoVhd5xS87gte/AJzNx8k7hg/vdQs06uV0dw11MfXX6SrmoYoyLn8fFseS9fnYdCvA5Fssrcwu6+B+Zp112huMS+s5xfpOj6TLWAmG+9vnjwvbUtyDioCtGp+JnHsTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789196283; c=relaxed/simple;
	bh=ESPyGXogLAjQYJ/OVdxVhXdinBONTfeimkvrsMopzZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EamdQz6srC2RISa80fncN8G9bY/CBOfiiiX/k60YwEEvrTDt0qZZdYaacf16clcs0F2AK6Va7mTXDm4S+aJuoS5sHx8HjetfGotL6FOcPNqgn+wwtmsUYb9W8E2GgFbwYKy5CjDy6G5ZOW3oOfZBq0HpvgRg/Pg19G17Mzp1C6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1201357|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0539208-0.0045022-0.941577;FP=16348498472350846131|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jBqAOqu_1789195948;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jBqAOqu_1789195948 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 12 Sep 2026 14:52:29 +0800
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
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v17 1/2] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Sat, 12 Sep 2026 14:52:23 +0800
Message-Id: <20260912065224.2723883-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260912065224.2723883-1-kyle.switch@motor-comm.com>
References: <20260912065224.2723883-1-kyle.switch@motor-comm.com>
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
 .../bindings/net/motorcomm,yt8824.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
new file mode 100644
index 000000000000..93e9f765404a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
@@ -0,0 +1,59 @@
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
+        ethernet-phy-package@0 {
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
-- 
2.25.1

