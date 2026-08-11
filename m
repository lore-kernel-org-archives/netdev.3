Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12B3F9F3B;
	Tue, 11 Aug 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453005; cv=none; b=slwaHwQ9jmd6Gv2wnHuvOo8U/bh807apY9eyt4EzsGekkAfZsmlh/p2ckB63XMg1UhsPBw1XNOzglDACLVfv9ukmvGAPKsn93H+SoEdRJ7bDpYA8Mrk44K20auLGiTd8mJ0dmFiz3V+aSQZP6qAMSeqOAtJV9ebjSrTRok7Xf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453005; c=relaxed/simple;
	bh=uyQQOVi15S3c7D8BnBr8x/fxEUVOFGeXSCb45HNclGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nd1MIRpoKn9cjxBE3iy4hd4gqlC/BHJxI8YgMhkMd5HH1Dzc4irM+auslvIBZw7CjpIthHtvIMBzjm4EcVKIWmIOs5o3qoP5FN320PiuaM92cRKnjKm2ZBvbXzKD3m683mzA+KQVp2m3bfi3tAM95uER3/XiLRKCU5w7AVfY8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=BTry9cTZ; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="BTry9cTZ"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id CC85B5822EA;
	Tue, 11 Aug 2026 12:34:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 357183EC69;
	Tue, 11 Aug 2026 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786451684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jd3dhPZnS4zprNyA8sY9GAb7F0q5LlHLaqGujzjZ9I=;
	b=BTry9cTZRbO4UwtPOycRD91xmAPd8kLo/4Cml54M32gjyDghPYcJP8PJ4wXFKX6O27gPxD
	dipOQdG4fjps1Zed16D6/Btd85n2544ZLFF9z9ThGfT33KhIPdt8RJ2Y965Pm1Y44VuJY9
	zh1axniVcjQkWItJOEzq7XvYaaDB++ew2jZ3IV/07wqR2OyCMybc/Zon3ZWoUqoCu9I/eA
	LVxP3VvyYMfHfjExAozPoTL5D20wudb/Eoj+9RAk9KMN2Rn4/RbZXAieUmOl/Smawz2bE2
	6ynpPrQLJIUeNViT5UrtG6qCk+1DtkND5kPFPXGO2nlyuYT6SuHA5uURITS0Tg==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Tue, 11 Aug 2026 14:34:33 +0200
Subject: [PATCH net-next v4 1/3] dt-bindings: net: wiznet,w5100: convert to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-wiznet-link-gpio-v4-1-4d5f7da885a8@marmottus.net>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
In-Reply-To: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTGhTFAuWjMd8OOyH8xCxArOr4Ca0SOgRQXayWbVK6z6ocC7oIynP/SDwtlrIKZ1s3hldENkadogrUsfLhVi11Vyzekp27qDxqk6P87IjTLrVUdD1+YO+8VCbcmQkb4uQ10D6RwZU4IuTN767NYRcMBmqqVZ7QhRKuqsk+tjTaFTrHwKCTfIkMER+BcT14NmHwsHfSl0iNvat/fQtHCDjFbr1o7MSq7JIUJ0Ckbs3sDx8reyzBpa6rwZ4wgTIiBkjOytPOwuJXL5YWHEOm68vILoAmXmIyBBbjmvS3+PXFnGyAHWDlGD6UUCprls0YSwJJLLTDe/No8Q2Z51hTEGne4NOLflLhXv/7gb6Ck4TiCJpQb02mZaWdMnYHPVLqrSNcAY0w5Hy77PvGyAr3bSXUk/WU/D9oBQwRH2EixPjXql/mg/z7MM9vjsA4Z0eztB94HmwqSOpDK7prWPYcyOPTqeh8Zpsre6FjmZ+U8HSWe72ObskNuLgFQnuaNCYtwJXWmD1xIdvAVwIzBX2LayoWNLbHfG/CgWlUBx/HqgHacUM0Ps9IBaTVPMCxBKICgeJfdg+pU5T5wUfNIqtTz9FJuBWv7LNO/IdWsQHpaIa5MA/7nWHgglcj1TY4Wu6iul+YCCDno72vHWAe+d/+yDiYIFnhJMM1X33A8cuvFGfNCmVw
X-GND-State: clean
X-GND-Score: -100

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wiznet,w5100.yaml      | 67 ++++++++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ----------------
 2 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
new file mode 100644
index 000000000000..641c9ddbde9e
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
+    #include <dt-bindings/gpio/gpio.h>
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

