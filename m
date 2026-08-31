Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761613EB0EF;
	Mon, 31 Aug 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180865; cv=none; b=Ux2v9PemKCapLmOghUzWptrXQGY3/gh4Zdx52G0jtZNanWUEB/QSpXhUWvGdYvemIqgkXhUxVzI9NlGMa1Vj9iNTOdGS5QRbQJCPK8Aus35Legycsjs/QQqhRNM4Na0+BlM/G79tHnFlQqr8v38UV8kveCP+wAv16wmUbNwides=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180865; c=relaxed/simple;
	bh=0El5XylhT0A8Zgb3BngoVFSvYJ3S9pojFoc/NSo7D10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQXeYCJJPwf19VwbXBFHOoZSwoPgthBpZm4nQjPwkrg+Ub3/rucBrc+e4Z+cPgC0GKvv1QYwKCGRbQcp6GNIqOZ6/NK3hDVYe1QZGJgdEzR4aEmeC1gGgoboOth/5IjqxXKZU994g7MxbY5QHPkOhckxezIC6agifywHxwZta5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=JdHP7R3v; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="JdHP7R3v"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60D033EE29;
	Mon, 31 Aug 2026 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788180855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BliuPYaZRf54U29M6fMfqX3GleAX8i4yO741/uY2E44=;
	b=JdHP7R3vBJ0agD1zD1iGNjAzdRYxICieCBR0JlyFLIMibN7V8bsWKfRRmf602vD7Cln8E/
	B1+6nC3fzzQ1gewAX/5lywpDb5kLNUcQQqz72HmzyzePC5dmfv0m3FzDwPBZ7CvfGMDOx3
	iBTWBE2g6gb7xZARlrx2u6kOoHFCW8B1P96dywMFiuJvWv6UQN0Gk9fEYfgdDdTQR5xtWs
	ze39JO5EviIbDn0v5n++YkKIUUPRaEbJz1/LYP8Z2AGa0UgrMZor2gE34/ALunEMXTRQif
	JnGOy9O3WP+akWsXPmuH99+4LfKl93MEbYqG4TsY1GVKgdG3Qj7UJ6hozUV2Jw==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Mon, 31 Aug 2026 14:53:34 +0200
Subject: [PATCH net-next v6 1/3] dt-bindings: net: wiznet,w5100: convert to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-wiznet-link-gpio-v6-1-abee6c5c966e@marmottus.net>
References: <20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net>
In-Reply-To: <20260831-wiznet-link-gpio-v6-0-abee6c5c966e@marmottus.net>
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
X-GND-Cause: dmFkZTGHg4yYEBQC3aqwwM9nF14K19hKJoQkcZn5/uSKILhdj5Z0nU/TEjxCeRxnx2TxxAMbRXw1k/ZOgKdLh2fY5EOXrESFRJZWX/Zs11Xhup2i06e8UFIH4S1o4ter4xXtTPS+L2TzrH1bunsSHdFkNQjqwbp3mYOHSEpvATAu3vQsxxYzPlJ6kWus+83MV6HmkryAc+aaQbRph6ocB659cH/voKG9TdVuMRSEoIWUNz+BEgqa3L36rltYjX/Do2Q9ryMY/kMXxXP/nWQM6L63W8DbvWMRQ8UGRtm2B9ccIsE0T0BnF83dE1v3/Shz0vclSiA/MjHNP5A7humrTtcfWLrrkZeuEv9oNiFK2eTq9mNKgyiFxypbCSlFg74uNOHKfY9hyfeVo6jRdobVrmCNPXqnIyWLG5Vu4b6TyGppFc6+vQOHY8HN3lXppDIKHc+nPyEjW//YELgRxyaj9Htq+/GTmbO4CwT9q2cYcePOuKRRXHrt5LBRxnBKgtmQsK7VJPUD1cBXtjK364DEWcDgMb6k5/zhBbrHBnUaQ/7cU2SvCwwFdMVz3Clu82/YPddVGPPf9EhYp6Hs28dMdYzThLhMCGrpAlVU2bhyQ11r7nlcLbQLhckt0u/80C+uLlgYG6DDSKsi6wRlvluekIgu9AJFTeDS9TlSx4aVjdhsRr9OGA
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

