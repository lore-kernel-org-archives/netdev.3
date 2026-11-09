Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251838;
	b=YvA9yCfKy+AJTeqDvWqgscpbrZkH2d6Hh0xc8HQmIk+EIPICIAmR4FeVAArm7QRCdux9
	 YlbIOVmSWE9F/IhkNuzKonoG/tgMj9G+Y/yv4GAVx5y/32pHX+/Jr01ZTczVUG8wYbNND
	 4GRL/1lEZdGQo6O6LsZGmZdYsjpMRL7OZBHWdEBQn+tu/2cyOjdy2ChKnD2PY64WLSF7z
	 EUZWAvAeBXXguumSjOEz3tGA5kLYi8YeOOpC2yo892+JuXKzYIFzeXqTmIEow9IcZV01c
	 9MMno9/516/v1RbUL2rk9/J7H2bUJgJ1eMFYKgx2q1+iFzHq6x2D2ak74lKk84ForQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251838;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GAVNy5aPv0qj5WR137agzHi11vLYU2rhbuq8I3ycGFU=;
	b=qS1sxcb7CJBQiQuF4d03A6DXap/0chgqUG1IqzdR8xdrUOWo4pFMKT+opMR/IW5NdBwO
	 QV+VQa9qlVSmR/NSVfjw4Ti5oFLD1dKmCTBcE0bVEoup1IXDY8zalewr9OQqw8XtVWMVU
	 EkDyqoolTae9BqlufXLIbUiq0jQm9jpZkV+BSgLLA2IXCbThVdKB6qFSw1xHd/R12BCz2
	 cRRshhHMZjwEp0Q2AtLve0HWWRN3Cs/ar1JtUcz7gYZ1TNGtHXLZ6GhWgVE7B7nUX08zP
	 h5rC3L/dgo0wJDOvxD+YxXUSQ4I1AjdEGoC9m1NWQqkLzJAP0IHrFxJ5RasoKv8iV1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cz9zFbj3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7D606A326;
	Mon,  9 Nov 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cz9zFbj3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA251F0089F;
	Mon,  9 Nov 2026 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251838;
	bh=GAVNy5aPv0qj5WR137agzHi11vLYU2rhbuq8I3ycGFU=;
	h=From:To:Cc:Subject:Date;
	b=cz9zFbj3W7ETd7p2fdFHj1QKUVCI2VLuMwBDQ/tbS/qPXLo06KUTnuOZTh3sMwD1f
	 q7DZ4HqxesLJqdjVuLP7rJxfJy3bflpGq5OIZsfIhfr6zBXLperAYsl34RcUDrDmBW
	 dt10tbcSe+MIkBzv9+ijoFEB8oOnIvJ5gybwYd3yooTgcX/2DFKFXLlpW1xYl8QV2S
	 2ZyoE1p2sOGb1wkY4qHxAvvjyH9XdLcBujhs/1oizQysCyJrv+2cNrcu7MX/FK7Rkt
	 49fyncRQiXdCTy0SXQVKY/d2azAIde/z9p6ibdF4POxJbRTxz7PTnKH9Izf30qlagr
	 TZhvuEFNcdDbQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: Convert HiSilicon GMAC v1/2 to DT schema
Date: Mon,  9 Nov 2026 13:16:41 -0600
Message-ID: <20261109191641.653847-3-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Convert the HiSilicon GMAC v1/2 binding to DT schema format.

As this binding also contains the MDIO bus directly rather than in an
'mdio' child node, the MDIO node name schema needs to be relaxed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/hisilicon,hisi-gmac-v1.yaml  | 96 +++++++++++++++++++
 .../bindings/net/hisilicon-hix5hd2-gmac.txt   | 60 ------------
 .../devicetree/bindings/net/mdio.yaml         |  7 +-
 3 files changed, 102 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hisi-gmac-v1.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hix5hd2-gmac.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon,hisi-gmac-v1.yaml b/Documentation/devicetree/bindings/net/hisilicon,hisi-gmac-v1.yaml
new file mode 100644
index 000000000000..89ed6ab1905e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon,hisi-gmac-v1.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hisilicon,hisi-gmac-v1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon GMAC controller
+
+maintainers:
+  - Jian Shen <shenjian15@huawei.com>
+  - Jijie Shao <shaojijie@huawei.com>
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/net/mdio.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: hisilicon,hix5hd2-gmac
+          - const: hisilicon,hisi-gmac-v1
+      - items:
+          - const: hisilicon,hi3798cv200-gmac
+          - const: hisilicon,hisi-gmac-v2
+
+  reg:
+    items:
+      - description: MAC registers
+      - description: External interface control register
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: mac_core
+      - const: mac_ifc
+
+  resets:
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: mac_core
+      - const: mac_ifc
+      - const: phy
+
+  hisilicon,phy-reset-delays-us:
+    description: Triplet of PHY reset delays in microseconds.
+    items:
+      - description: Pre-reset delay.
+      - description: Reset pulse duration.
+      - description: Post-reset delay.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phy-mode
+  - phy-handle
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+
+    ethernet@f9840000 {
+        compatible = "hisilicon,hi3798cv200-gmac", "hisilicon,hisi-gmac-v2";
+        reg = <0xf9840000 0x1000>, <0xf984300c 0x4>;
+        interrupts = <0 71 4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        phy-mode = "rgmii";
+        phy-handle = <&phy2>;
+        mac-address = [00 00 00 00 00 00];
+        clocks = <&crg HISTB_ETH0_MAC_CLK>, <&crg HISTB_ETH0_MACIF_CLK>;
+        clock-names = "mac_core", "mac_ifc";
+        resets = <&crg 0xcc 8>, <&crg 0xcc 10>, <&crg 0xcc 12>;
+        reset-names = "mac_core", "mac_ifc", "phy";
+        hisilicon,phy-reset-delays-us = <10000 10000 30000>;
+
+        phy2: ethernet-phy@2 {
+            reg = <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/hisilicon-hix5hd2-gmac.txt b/Documentation/devicetree/bindings/net/hisilicon-hix5hd2-gmac.txt
deleted file mode 100644
index cddf46bf6b63..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-hix5hd2-gmac.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-Hisilicon hix5hd2 gmac controller
-
-Required properties:
-- compatible: should contain one of the following SoC strings:
-	* "hisilicon,hix5hd2-gmac"
-	* "hisilicon,hi3798cv200-gmac"
-	* "hisilicon,hi3516a-gmac"
-	and one of the following version string:
-	* "hisilicon,hisi-gmac-v1"
-	* "hisilicon,hisi-gmac-v2"
-  The version v1 includes SoCs hix5hd2.
-  The version v2 includes SoCs hi3798cv200, hi3516a.
-- reg: specifies base physical address(s) and size of the device registers.
-  The first region is the MAC register base and size.
-  The second region is external interface control register.
-- interrupts: should contain the MAC interrupt.
-- #address-cells: must be <1>.
-- #size-cells: must be <0>.
-- phy-mode: see ethernet.txt [1].
-- phy-handle: see ethernet.txt [1].
-- clocks: clock phandle and specifier pair.
-- clock-names: contain the clock name "mac_core"(required) and "mac_ifc"(optional).
-- resets: should contain the phandle to the MAC core reset signal(optional),
-	the MAC interface reset signal(optional)
-	and the PHY reset signal(optional).
-- reset-names: contain the reset signal name "mac_core"(optional),
-	"mac_ifc"(optional) and "phy"(optional).
-- hisilicon,phy-reset-delays-us: triplet of delays if PHY reset signal given.
-	The 1st cell is reset pre-delay in micro seconds.
-	The 2nd cell is reset pulse in micro seconds.
-	The 3rd cell is reset post-delay in micro seconds.
-
-The MAC address will be determined using the properties defined in
-ethernet.txt[1].
-
-- PHY subnode: inherits from phy binding [2]
-
-[1] Documentation/devicetree/bindings/net/ethernet.txt
-[2] Documentation/devicetree/bindings/net/phy.txt
-
-Example:
-	gmac0: ethernet@f9840000 {
-		compatible = "hisilicon,hi3798cv200-gmac", "hisilicon,hisi-gmac-v2";
-		reg = <0xf9840000 0x1000>,<0xf984300c 0x4>;
-		interrupts = <0 71 4>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		phy-mode = "rgmii";
-		phy-handle = <&phy2>;
-		mac-address = [00 00 00 00 00 00];
-		clocks = <&crg HISTB_ETH0_MAC_CLK>, <&crg HISTB_ETH0_MACIF_CLK>;
-		clock-names = "mac_core", "mac_ifc";
-		resets = <&crg 0xcc 8>, <&crg 0xcc 10>, <&crg 0xcc 12>;
-		reset-names = "mac_core", "mac_ifc", "phy";
-		hisilicon,phy-reset-delays-us = <10000 10000 30000>;
-
-		phy2: ethernet-phy@2 {
-			reg = <2>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index bed3987a8fbf..1f812753dbd1 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -17,9 +17,14 @@ description:
   bus. These should follow the generic ethernet-phy.yaml document, or
   a device specific binding document.
 
+select:
+  properties:
+    $nodename:
+      pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
+
 properties:
   $nodename:
-    pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
+    pattern: '^(ethernet|mdio(-(bus|external))?)(@.+|-([0-9]+))?$'
 
   "#address-cells":
     const: 1
-- 
2.53.0

