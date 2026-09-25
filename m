Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CEA480DC8;
	Fri, 25 Sep 2026 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373572; cv=none; b=f7rkBrV64Vr6JGEet9YDk/VVDwZpIVBYDJTSELcejxToX7BiTDtRlz2TrhWbNYN9XnaKGXMvK4zEAJjqjJLynvrk7argKvj3GzE/BYSUQDzgYoFT847feyzO5b8HRnAhT8XxgWlqHlmfYsGyUdlbiUidgRz5bLBjBTa8KBO1C40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373572; c=relaxed/simple;
	bh=kCBagfc6vZXcM3WO7daDE2vkfjzQw3XQqPUIf1Cks1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ey9SQ0zYu/PVMFLZoTIdwHjFyvBSLJf3+2ZGtUMLtZJCaydfh7uO2T5L65Kqs2W0kW37JiXwsrPFHs3UACtOn786m9pGZpM/hqfxWKV8svysXzoXtKsK3tgdTNkG8CQQbp5uSU0G9g3eGItKaj1l4CwewOfHZjzJOtTTle8zRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1vb59v6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1vb59v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844BE1F000FF;
	Fri, 25 Sep 2026 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373571;
	bh=jIthKFXcHdLdemQzLqVijaDxfZmaZkVpCwS06mScTsY=;
	h=From:To:Cc:Subject:Date;
	b=F1vb59v6yxaW6XGa1w550XUUM5beQWqNTyVc9pJA0LSQgkTIToUrwyPX8+kxqAQaH
	 7sefTLjBwMS+ithgzAzxF0GrOcagExXu/pB34SFoOqBP/n3Gtbb9P8BtnB4XTEX6Mu
	 H+jWMsVAzgHwXqfJHSx0Z+CD4DwJumpFSIKtspiqk6hw2bLtqRMSgueFh2n52wG4C3
	 aWV3jGFaneO2c60kjna5NqszWhheZwpH0wWMuk50LdOMFxePWuDhOEVCF+OTfOeqF8
	 S3CP6YtPvBN58g3edB1lhcNcD5x81XJCvi6x3TSPlkTAHciYoX8r1CsqROcBI70VKi
	 2N+bAX1xkIhDw==
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
Subject: [PATCH net-next] dt-bindings: net: Convert hisilicon,hns-nic to DT schema
Date: Fri, 25 Sep 2026 16:59:22 -0500
Message-ID: <20260925215923.2950950-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the hisilicon,hns-nic binding to DT schema format. It's a
straight forward conversion.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/hisilicon,hns-nic.yaml       | 107 ++++++++++++++++++
 .../bindings/net/hisilicon-hns-nic.txt        |  76 -------------
 2 files changed, 107 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-nic.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hns-nic.yaml b/Documentation/devicetree/bindings/net/hisilicon,hns-nic.yaml
new file mode 100644
index 000000000000..1b14348e74d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hns-nic.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hns-nic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon Network Subsystem NIC controller
+
+maintainers:
+  - Jian Shen <shenjian15@huawei.com>
+  - Jijie Shao <shaojijie@huawei.com>
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,hns-nic-v1
+      - hisilicon,hns-nic-v2
+
+  ae-handle:
+    description:
+      accelerator engine handle for hns, specifies a reference to the
+      associating hardware driver node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  port-id:
+    description: |
+      is the index of port provided by DSAF (the accelerator). DSAF can connect to 8 PHYs.
+      Port 0 to 1 are both used for administration purpose.
+      They are called debug ports.
+
+      The remaining 6 PHYs are taken according to the mode of DSAF.
+
+      In NIC mode of DSAF, all 6 PHYs are taken as ethernet ports to the CPU.
+      The port-id can be 2 to 7. Here is the diagram:
+            +-----+---------------+
+            |            CPU      |
+            +-+-+-+---+-+-+-+-+-+-+
+              | |     | | | | | |
+             debug       service
+             port         port
+             (0,1)       (2-7)
+
+      In Switch mode of DSAF, all 6 PHYs are taken as physical ports connect to a LAN Switch,
+      while the CPU side assume itself have one single NIC connect to this switch.
+      In this case, the port-id will be 2 only.
+            +-----+---------------+
+            |            CPU      |
+            +-+-+-+---+-+-+-+-+-+-+
+              | |   service| port(2)
+             debug   +------------+
+             port    |   switch   |
+             (0,1)   +-+-+-+-+-+-++
+                       | | | | | |
+                      external port
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+
+  port-idx-in-ae:
+    description: |
+      is the index of port provided by AE.
+      In NIC mode of DSAF, all 6 PHYs of service DSAF are taken as ethernet ports to the CPU.
+      The port-idx-in-ae can be 0 to 5. Here is the diagram:
+            +-----+---------------+
+            |            CPU      |
+            +-+-+-+---+-+-+-+-+-+-+
+              |    |   | | | | | |
+           debug debug   service
+           port  port     port
+           (0)   (0)     (0-5)
+
+      In Switch mode of DSAF, all 6 PHYs of service DSAF are taken as physical ports connected to
+      a LAN Switch,
+      while the CPU side assume itself have one single NIC connected to this switch.
+      In this case, the port-idx-in-ae will be 0 only.
+            +-----+-----+------+------+
+            |                CPU      |
+            +-+-+-+-+-+-+-+-+-+-+-+-+-+
+              |    |     service| port(0)
+            debug debug  +------------+
+            port  port   |   switch   |
+            (0)   (0)    +-+-+-+-+-+-++
+                          | | | | | |
+                         external port
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 5
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - ae-handle
+  - port-idx-in-ae
+  - local-mac-address
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet {
+        compatible = "hisilicon,hns-nic-v1";
+        ae-handle = <&dsaf0>;
+        port-idx-in-ae = <0>;
+        local-mac-address = [a2 14 e4 4b 56 76];
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
deleted file mode 100644
index f0421ee3c714..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-Hisilicon Network Subsystem NIC controller
-
-Required properties:
-- compatible: "hisilicon,hns-nic-v1" or "hisilicon,hns-nic-v2".
-  "hisilicon,hns-nic-v1" is for hip05.
-  "hisilicon,hns-nic-v2" is for Hi1610 and Hi1612.
-- ae-handle: accelerator engine handle for hns,
-  specifies a reference to the associating hardware driver node.
-  see Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
-- port-id: is the index of port provided by DSAF (the accelerator). DSAF can
-  connect to 8 PHYs. Port 0 to 1 are both used for administration purpose. They
-  are called debug ports.
-
-  The remaining 6 PHYs are taken according to the mode of DSAF.
-
-  In NIC mode of DSAF, all 6 PHYs are taken as ethernet ports to the CPU. The
-  port-id can be 2 to 7. Here is the diagram:
-            +-----+---------------+
-            |            CPU      |
-            +-+-+-+---+-+-+-+-+-+-+
-              | |     | | | | | |
-             debug       service
-             port         port
-             (0,1)       (2-7)
-
-  In Switch mode of DSAF, all 6 PHYs are taken as physical ports connect to a
-  LAN Switch while the CPU side assume itself have one single NIC connect to
-  this switch. In this case, the port-id will be 2 only.
-            +-----+---------------+
-            |            CPU      |
-            +-+-+-+---+-+-+-+-+-+-+
-              | |   service| port(2)
-             debug   +------------+
-             port    |   switch   |
-             (0,1)   +-+-+-+-+-+-++
-                       | | | | | |
-                      external port
-
-  This attribute is remained for compatible purpose. It is not recommended to
-  use it in new code.
-
-- port-idx-in-ae: is the index of port provided by AE.
-  In NIC mode of DSAF, all 6 PHYs of service DSAF are taken as ethernet ports
-  to the CPU. The port-idx-in-ae can be 0 to 5. Here is the diagram:
-            +-----+---------------+
-            |            CPU      |
-            +-+-+-+---+-+-+-+-+-+-+
-              |    |   | | | | | |
-           debug debug   service
-           port  port     port
-           (0)   (0)     (0-5)
-
-  In Switch mode of DSAF, all 6 PHYs of service DSAF are taken as physical
-  ports connected to a LAN Switch while the CPU side assume itself have one
-  single NIC connected to this switch. In this case, the port-idx-in-ae
-  will be 0 only.
-            +-----+-----+------+------+
-            |                CPU      |
-            +-+-+-+-+-+-+-+-+-+-+-+-+-+
-              |    |     service| port(0)
-            debug debug  +------------+
-            port  port   |   switch   |
-            (0)   (0)    +-+-+-+-+-+-++
-                          | | | | | |
-                         external port
-
-- local-mac-address: mac addr of the ethernet interface
-
-Example:
-
-	ethernet@0{
-		compatible = "hisilicon,hns-nic-v1";
-		ae-handle = <&dsaf0>;
-		port-idx-in-ae = <0>;
-		local-mac-address = [a2 14 e4 4b 56 76];
-	};
-- 
2.53.0

