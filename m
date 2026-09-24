Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18641169B;
	Thu, 24 Sep 2026 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243323; cv=none; b=sDYngwmlySCJCSBOyLeTqN+J5nRLYBAMefX2Wyu3BbOYWVBayMtT6YmbobDTAIGDS2namziq7GtsfxF69T7umrtSTY3sTsarip8LjtMHGUepxD6G+07vku0c9RD7EIi9e86wDnJCibAUA7aTqUUoTUkbe1jC2xEqDg3WP/7F+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243323; c=relaxed/simple;
	bh=S7oFeT+YUdKkug5ypub7txpMfPfFwCVaLOl/7hcvY6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwGlQhmumxy1HAHtkM3eFgsTPAXZhREjRPXyCcBgCI487+XimocUDAAftEcU2pk1QIOWOg8a0+LaQDGMUieqhaPSxxDrV3h68OsMrxTiA8RB/hSSjs9ncwvHrTHG2Xo4jqDbWeVWd1iwwsFhzNTCnxiSLO1C/18cv5a0rRuqL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=ArscTyP/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="ArscTyP/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74CA23EBD5;
	Thu, 24 Sep 2026 09:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790243305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncwg9ho5lG/UbOhbZIbh2sgQ6cGDbkfpndg6EYig4o4=;
	b=ArscTyP/JmGx5gmQ8BHaGdZmJq59xwGh1cWOLA4Pr1L/T8LNXQF+6mz6lJpmguExKRCdiZ
	8Bkf3kuNWl6ns5Dr/vRvpiexsA7dJGAmysguudvlH5mZ+b7okM2y+ZsTfgyfYS2C1Xds1h
	nd9csNAVLR0X5KcVQuE7L5kxFSx1V0cd0xEeHdSkjGNMh+rZL6gtdreANrjJmVQhqK6uln
	OnfkpgZSG28ef69xvz8BWvsd7nsZDSLnqCLFnN9dtea6VUqUEsouPJIi13I3HrOhdLFLf0
	QhrK0nAzkTcUqPjTK/YLVX5Pq2u1uCD9gnK9Cud1TDl7IaKRNmJMWnRFPOj4mA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Thu, 24 Sep 2026 11:48:11 +0200
Subject: [PATCH net-next v11 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-wiznet-link-gpio-v11-1-42a332517b30@marmottus.net>
References: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
In-Reply-To: <20260924-wiznet-link-gpio-v11-0-42a332517b30@marmottus.net>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFhyvBWwSdlAprHnmharjSBeSvU3LFLSd1AHsenPfaek+TmvMr1VWRdnZitSYAXqGtk3f6nbIt+JNQEAVoFPl+F4887JkdxJxPFq0WMNHrEhI6qtv2aqmTgFF26ousMuHCdaTPHu8o06bseeX8ScEsX4OpVViOaeRoOp93JPCLEOIrBbi7o1zpAOJnmQnDM1GaZopYGkm9fVMvH8c2Mf03v4WyPZcZgyEVJxGd57wKE5LsECf1MpcrcJERyp2iUKsE4mvATJF9BihIgI1ogW3qNTPBhm25vRvdDueveiL7MeuoN1gk4uE+lLIN1NHkX1XweizpSNv7wq8LIvJ/MWZFWF00JpC9sm28Mq0rD+RXW5TLAD/AzzfigqqZ7cExnKr3yeoYMZs4AVLKTtX99eJTgD7Y+4v2RKr275SuXRnJU2vuvx+RNRNke31gxgFydewby0IHStJZSwkXhoy+TgW+Dfe32SNo2GMyiAdWZQRXZ2anWUL9z0+C8W/C6XEii1PZf+dg3kQldipkkZmZ6lRX1za/jVUM0GWPyEfX/iygtycamCbPDyt2COCtDQa4WiSNkbV52xyif/4tZ6Y7LT+eH49KmW8+7xZDbmeFeyj1O6HjHo1Eiv/DjT/2SqNn0qAIgecctUjY+gO1lUvsbhCYmpX9Le10qrrda+v+AtfgLFw

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Change the trigger type from edge-falling to low to match the driver
implementation.

Add wiznet,w5100.yaml entry in MAINTAINERS.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v11:
 - Add a line about MAINTAINERS changes in commit message
 - Describe the entry in MAINTAINERS as BINDINGS
 - Reorder example properties to pass dt-check-style in strict mode

v10:
 - No changes

v9:
 - Add edge-falling->low in commit message

v8:
 - Add a myself in MAINTAINERS
 - Address Sashiko reviews
  - Change edge-falling to level-low
  - Clarify the spi max frequency for all devices
  - Add main interrupt description

v7:
 - No changes

v6:
 - Put back the reviewed by tag from Krzysztof Kozlowski from v4

v5:
 - Remove gpio/gpio.h include from DT example
 - Fix DT bindings errors

v4:
 - Update interrupts in DT bindings

v3:
 - Fix DT binding errors

v2:
 - Convert device tree binding to YAML
---
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 68 ++++++++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ----------------
 MAINTAINERS                                        |  6 ++
 3 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
new file mode 100644
index 000000000000..df83f90b3919
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -0,0 +1,68 @@
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
+    description: Main interrupt (INT pin on the device).
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    description:
+      According to the datasheets, w5500 and w5200 allow a maximum of 80 MHz
+      while w5100 is reported by users to allow a maximum of 14 MHz. However,
+      board designs may need to limit this value.
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
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+            pinctrl-0 = <&eth1_pins>;
+            pinctrl-names = "default";
+            spi-max-frequency = <30000000>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index e3ce77c839b0..42acc7bb7bfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29451,6 +29451,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
 S:	Maintained
 F:	drivers/input/misc/wistron_btns.c
 
+WIZNET W5100 ETHERNET BINDINGS
+M:	Arthur Crepin Leblond <arthur@marmottus.net>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+
 WMI BINARY MOF DRIVER
 M:	Armin Wolf <W_Armin@gmx.de>
 R:	Thomas Weißschuh <linux@weissschuh.net>

-- 
2.55.0

