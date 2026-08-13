Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF3443E44;
	Thu, 13 Aug 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611517; cv=none; b=ELdMRWEkLK1fJb+WAV72zTqbliOnmqwQ2gA/yqhii23Tn9vmvxSYwfwtTyzmCsi8TVz7GPmhtm7PMAnnxNOnOdHOAgC402Y6QXNrx0VbBB4qHERH0VZ80WhLt67ffFqOByUJaggohr3pRw4D8FFuKGjjOJEkQNl8hmPb1r+55n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611517; c=relaxed/simple;
	bh=Mq7IuXzUETIgFtlTdiW2LMSeidORN8jn24X7MCilsWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bd45CAvW6XlPvqYC8Yino89+9pScBtp7DAM+h5wTRThhtF0Ovn/8Q6jqf8feNkvRjG6gOfx2HBhQtX1PCnH9j8EfNnHalsAHlakABawqznFaMgu+7iOlnlgYZK1RqDtgi4YojbTkEykv5VCgIb6ZGwiYmwaFiqVgFuLosObYhO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=lgE9JhYf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="lgE9JhYf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B3D01F416;
	Thu, 13 Aug 2026 08:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786611506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dsJLxD6ymGjk//iy+rCgruznZq24h6b7dxmWfHzV7U=;
	b=lgE9JhYffV24LnzDPHJedt4wIWPBxjA+GjOtKji/YGeT2LrfilLCaYXkupM0vMXIFfqj70
	wU6jer2Fr0XzryYMGasjEGwhUtMFsek34N3ThNBg7mibwLmeqyII0HXpDcTHskJUp42U3O
	0vYI92czYmVI5nAIF4Vm+GsH22gAuaxonG7qasdsiefyiQoyFoDhH3lOJaZqPWL98Yomnd
	IZd4BfeFfb/ay9M0ogoeYqePvbVyxVDGNv7/FKE0IZFqzMHFJiGpNdwHq5D/9JYwCfm9Ox
	vIWgcpUj2OsMjO2++uBe1WZWD9DSf8ol2x8bhJucLLp1iw2rN6ZQ1eCO7y4JWQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Thu, 13 Aug 2026 10:58:14 +0200
Subject: [PATCH net-next v5 1/3] dt-bindings: net: wiznet,w5100: convert to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-wiznet-link-gpio-v5-1-ac8046f24413@marmottus.net>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
In-Reply-To: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTGOKF1OE0DoXxrQQYUcRrf3MbbM9Qm2ZcibCBH7iOVlqO0bFpnBa9RZm6cKwJOQOT8ztxpEkrS0IZ/oNS09zl+Aj+saIP+obNoL1OV5xbq3rN6NLfv0wo1JVbkzV5HCBZU/7UTmOoi/JKGgKhDk8CNOxlAyETAMiXYE5fKvme77hHGhJ6M3GjCn2zo7wdiB13qZB+0Dsy1zw0VRcsnD7lGhKv3sEToDIzzwmI/ut9wjTWTC5oRbOI3gURMCqKDtcBExkQ9FfQC5zuZMGrqBBuFv41h5EKNP/9hlVfATi/35VIFS1Cj1lAHRb3n3mveS3oJ4kaSYILVekivu/CYUR1OFnYSKAfWcktTMSfKm1jrLgpmlPJL5udYNTbzM95xsx4rKpJTHd7mipbVyijy4LeOTU7zCQDBzYO3plsqWjag2y/FDB/0Fm7EokxzxbxY4ILPQgXnLeIHMBbXis8Yi5d/9K8BxiwO/ywgZEA30o+dzGlCTYVdKX8rBoaPEk2aaT+qdr5opxoSwTjE40t0COji7lGHiYuz1fQOgDQpO7Lc97u8Hdh/lwHThrisfIj68x7e/GI21pmv3mylA3PBTAPAab2ODAdZTd+O+knXTUWdLzaNx6qk60f1bOcXr2qCR5FPiHnTc10mB8MBN3s69wq9tHktwd7kN89TjN9zxBlXSvw
X-GND-State: clean

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 67 ++++++++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ----------------
 2 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
new file mode 100644
index 000000000000..217f301db182
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wiznet,w5100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiznet w5100/w5200/w5500 SPI Ethernet Controller
+
+maintainers:
+  - Arthur Crépin Leblond <arthur@marmottus.net>
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
+    items:
+      - description: Main interrupt (INT pin on the device).
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

