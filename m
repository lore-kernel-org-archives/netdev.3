Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B34CCDD7;
	Wed, 16 Sep 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789556130; cv=none; b=FHhDh5KWYddanp0Sb8IwK3X2nWox5p9+H6LLJ2yNiUvrdp+3xaVbFakqBd/JOK6AeGlaepa6V6chE6mCtOWbjwnLSO++rQKqEgzTLYpnTME3GfMxgG4kAgwv6U7oEZy9gwK6Zj/in/oamSwFokJRCtsEXakHAvhQc79E5OycxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789556130; c=relaxed/simple;
	bh=ESPyGXogLAjQYJ/OVdxVhXdinBONTfeimkvrsMopzZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HShSs3dLTKCd6bQQxOzpyzFtwTJXJ0k5gNel+eIQYogW7dzr9SmTTEtBJ2Ip8HlH5iDNko5optzmimS9HOTCQv5ODukFwQ4uVPk1Qy7YTml7Vc4sZcJxVoyOmaKGtOGGWZqF9Uohh+uygbJ7Ccq7GdHo7C3UvNzdsAong/DGn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1314901|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0539208-0.0045022-0.941577;FP=16348516064536890547|15|2|17|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.jExZdXU_1789556110;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jExZdXU_1789556110 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 18:55:11 +0800
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
Subject: [PATCH net-next v19 1/3] dt-bindings: net: Document Motorcomm YT8824 PHY package
Date: Wed, 16 Sep 2026 18:55:02 +0800
Message-Id: <20260916105504.3262767-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916105504.3262767-1-kyle.switch@motor-comm.com>
References: <20260916105504.3262767-1-kyle.switch@motor-comm.com>
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

