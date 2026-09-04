Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BD476CC0;
	Fri,  4 Sep 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525386; cv=none; b=LKrEFR7+qDM7w6BUYsHpdpiP+btxqkTKerRIQ0DnP9PkexwzX9JMM6oooM0Ku4kPvYSyzc3ODb9fEZxI8tynqy51/gTo96/tOyq20VRSifS4wmv0FBda5m8dVRRaYV6pFJlpOUPB6V48t7uuB6BNpuYCBG5W8+PLPIPP1dl8RIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525386; c=relaxed/simple;
	bh=jWa62zLpy08rskinsZHo7z2D8S8QE5BuplaCNauhzgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmOWF4arsczULvGyMBUn6BWFxWIcr88H1h9ji/G5JWU3SdZPrVtK8pm71UpcpLhURvWxd0gQA8pxhXLEGvtNYMsq+C3pSrtePp4Vdzmj036co3bOelyyNHFclRxSE94Wxy52kNnyhMYZxQz0wXHjmEGQBwtOLAWNbTOA0E7kFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=RExf1SzG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="RExf1SzG"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 741283EC79;
	Fri,  4 Sep 2026 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788525376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYMSUckHhLQjqV8pm5rCkhEzTT9IEGOLgIijWF1A7cQ=;
	b=RExf1SzGF862ygKTfd4XAQ8S0RYLwTwKQghm7g91KQJGkXeX+NY4wQB/hnia+LO6q54B/z
	G9BSi4UVB80b+e4cdWjhnOZUb5Rl5Tgiq9RtyMepXu99kp2wZu7grjeHDtpkE85jEIlayf
	nfkwkxXCQh5iXrdx7W1uGdLomNyEy3EUej1J6kUgtd+dTP1nn8u6HTppOXfppOu+u6GUjq
	AV3piIAIUtgxxHYKeOlavuF8fA1PGwrfVDn8ckAeGVpGBaMBVB84PVX4W5TbdrQG+xtQTl
	VzXKVqGlII+2KAQSE+FDrD2TfdjNNB9GpW7lJkWsTj9zKb2IoDFr2uLdww3mVQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Fri, 04 Sep 2026 14:35:58 +0200
Subject: [PATCH net-next v7 1/3] dt-bindings: net: wiznet,w5100: convert to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-wiznet-link-gpio-v7-1-69f01b70c96f@marmottus.net>
References: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
In-Reply-To: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTFXVvGsnHbtESJ25bhQLeddbeFrEjKvb8Y7CeBBI8UT0YnNCcpPrNaLHGo7shEmYyZxlUNU3O99ue0pnk1eH2vGswuaWmMqCzRaZgo1jrs6W/c3dNJcHZt0Qvk+q23zr4Ei4CTpk+CTPnLD5gW3svufOWFVAfz18VyXl4fhplXg+1IncgaSrBY2PEcu19HW5LoIDfhzVBTOL2NP8DKNOtijqXiWe51clFtvdtdvsHvWkvWIcUonpvg+3Do64SWuWfJ9vmEQ4U36Ttcnf8zpwYYOFmdhhjASGjDFTLgAEQKxt4vK6gsrTwLX4XiBT64UxRgHGybX9C+YrUDilcRWS7uQPrKgl2gXclGHc76PNKX5jvnHQiwcziLqLmckehR+XYUsttBMQElkKh1reIO2jrpfdpEML4pKgHBSJH75L69+zemeaLeZn+/oH75CcsdfiUhQTWjFjer42miFecEMaY5xxiDFVUyVZF90wQ8yDqJv2lPXKzS7Nl7COht/gwZDwmXY7fj41TDEioMkyN/u4LnNVdxlN2s/UrG6DS9hRSvnjuER1glsVH4WnsJjh04o+hsWfd9YGmY9d9/epjfC11cVV+o56uSNry9kc//qx6u4vXScb8soY/7XKXzFft6nw9iWBhDVf2PHnsV0tJRBRr/EBFoLROFUANWgfIaXuw+emA
X-GND-State: clean

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---
v6:
 - Put back the reviewed by tag from Krzysztof Kozlowski from v4

v5:
 - Remove gpio/gpio.h include from DT example
 - Make the DT interrupts property dynamic from the compatible one
 - Fix DT bindings errors

v4:
 - Update interrupts in DT bindings

v3:
 - Fix DT binding errors

v2:
 - Convert device tree binding to YAML
---
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 66 ++++++++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ----------------
 2 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
new file mode 100644
index 000000000000..601d828bae92
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wiznet,w5100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiznet w5100/w5200/w5500 SPI Ethernet Controller
+
+maintainers:
+  - Arthur Crepin Leblond <arthur@marmottus.net>
+
+description: |
+  This is a standalone 10/100 MBit Ethernet controller with SPI interface.
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - wiznet,w5100
+      - wiznet,w5200
+      - wiznet,w5500
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    description:
+      According to the w5500 datasheet, the chip allows a maximum of 80 MHz,
+      however, board designs may need to limit this value.
+    maximum: 80000000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /* Example (for Raspberry Pi with pin control stuff for GPIO irq) */
+
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@0 {
+            compatible = "wiznet,w5500";
+            reg = <0>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&eth1_pins>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            spi-max-frequency = <30000000>;
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
deleted file mode 100644
index e9665798c4be..000000000000
--- a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Wiznet w5x00
-
-This is a standalone 10/100 MBit Ethernet controller with SPI interface.
-
-For each device connected to a SPI bus, define a child node within
-the SPI master node.
-
-Required properties:
-- compatible: Should be one of the following strings:
-	      "wiznet,w5100"
-	      "wiznet,w5200"
-	      "wiznet,w5500"
-- reg: Specify the SPI chip select the chip is wired to.
-- interrupts: Specify the interrupt index within the interrupt controller (referred
-              to above in interrupt-parent) and interrupt type. w5x00 natively
-              generates falling edge interrupts, however, additional board logic
-              might invert the signal.
-- pinctrl-names: List of assigned state names, see pinctrl binding documentation.
-- pinctrl-0: List of phandles to configure the GPIO pin used as interrupt line,
-             see also generic and your platform specific pinctrl binding
-             documentation.
-
-Optional properties:
-- spi-max-frequency: Maximum frequency of the SPI bus when accessing the w5500.
-  According to the w5500 datasheet, the chip allows a maximum of 80 MHz, however,
-  board designs may need to limit this value.
-- local-mac-address: See ethernet.txt in the same directory.
-
-
-Example (for Raspberry Pi with pin control stuff for GPIO irq):
-
-&spi {
-	ethernet@0: w5500@0 {
-		compatible = "wiznet,w5500";
-		reg = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&eth1_pins>;
-		interrupt-parent = <&gpio>;
-		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-		spi-max-frequency = <30000000>;
-	};
-};
-
-&gpio {
-	eth1_pins: eth1_pins {
-		brcm,pins = <25>;
-		brcm,function = <0>; /* in */
-		brcm,pull = <0>; /* none */
-	};
-};

-- 
2.55.0

