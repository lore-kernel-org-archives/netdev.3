Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6DC45FFD1;
	Tue,  4 Aug 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865271; cv=none; b=a9ehCfqwUwNfOVS9RAcni/QN+nEV/449U2/vEj5o6sAcVLc0Azoyn5SAi/YzawxA3V1lLW2GQxF4YPR4CNHXl5yF+wAlM0zwtq0R6rlstGkD+7v5vv9FEd2tD8tLZKkJpjQ1yVwrArum/lDcHFgOM/G8yGpfmrN6YhKzwYs4t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865271; c=relaxed/simple;
	bh=D4iu8z/1wTFxUPh5aLA6tIukfDjp76lrHcNSPoHUR8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=la/qA1w38Ni6LnPyAlipRMXnHf0opt7a6+GqpJLeCIlbJMMg8g8xNKqSpRI+15ZBasbx0VggdWhG4/pqO0CJ/+MXcxZZRbwV2NL+W9Z57IxF0/2SXxvRGciGX52yZP/KtgOJUU5pbf8b1cvA+J7t/jO3whTjQwdFUSyhk70UWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=eGlkPYrZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="eGlkPYrZ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBBC23F56F;
	Tue,  4 Aug 2026 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785865266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYaBEcmudDSQMptlRYgCj8DzymKeVyUmLu+y8k95L0I=;
	b=eGlkPYrZ6giq0VaZdwy7ACUoPiXGQ1tRTO5/8v00159QrFjNywK9HlcVqIfU/wu5u4nUkW
	9qQ1c8dlzqRwD14WYygdjwIvF0r01ZMR1Y9LDOdn+rADIONl1mTLFJMwy9vCQLeuniYUmv
	0Byt7ZAhlR/3oEreT7lSq1x+so1lGQbJ1P0QZJtCoxF0BfHK7SoaQe9zWJ/xzyGPt3/97S
	re7b+aZwVWspA9rsqiikE3JguZOsGeoofgRb6XInztXCIMPqwX/nkPF/h2yxNBC5FDUDkB
	PbagSY8nPpEVtnYp4Lq9bL4pc7l+TItaNNeZNQhAHDv6WB+6881A/HlnyVgawQ==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Tue, 04 Aug 2026 19:40:57 +0200
Subject: [PATCH v2 2/2] dt-bindings: net: convert wiznet,w5x00 to YAML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net>
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
In-Reply-To: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTGgfXg9pj62RwQVEzA9qR84zG2ZMqPLVqXstNGgjnunfsg6LJn88s/9ga9W6thqUQd5T/k4mna/ZewwyLV5Mw+xiT9P7RMygkHHNESr9H1v3+VqyP5I47nVbU3XP6CJ0mV24wbCks+M9D+YJ6EPTEylc8j86HS5QglCvJwcTa7DAKUMlPb9ADORMmp23OidBY622+pFLCM9TOSui+kMT7NYbqC9DaAyDAyREjPK/jCTwC82ucDL0KrLYGgP4FItmFTJRhpSIJ9zaW8ujzcRBMyO9OxnLkrxewnZ5GVzFeV74dnQtyRVc+rXNcXQGkewy1UlmHZoN1YC/GF2e1hvrJm6nwz/GGphYBosurRUDAstnzXU2mQWMGnO9YNFIsPpyQ1W2EevFA/a6HG9Z2TnGFwSM1evJo2IS7iFFgwmf1qT3Gsxdv+nG5AaDqNda6nH4k1n5rG7/BH3SGaP4qx8NzAEfRKnfu8moa6rVgypTZXv6PEHCeWiydm4MN7DKl9ulYvxvU3X2L4zCQc88HLMCB/JymdTEq12cWcFlTYwKYTlSwtleS9ZnYh7PMmmpaotQNP8MqRd20s+W5hAsfIoMkbYyG1DKYmcGJ3bgd4wAgziByR3uqDjwRUKLFd0CfEM/93uEJv6bpBpkKx2P/PSwR1UcrXzWDzqIDUERXn4iXGD+Q
X-GND-State: clean
X-GND-Score: -100

Convert the Wiznet w5x00 SPI Ethernet controller binding from
text to DT schema format.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ----------
 .../devicetree/bindings/net/wiznet,w5x00.yaml      | 103 +++++++++++++++++++++
 2 files changed, 103 insertions(+), 50 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml b/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml
new file mode 100644
index 000000000000..8f45a5d773fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wiznet,w5x00.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiznet w5x00 SPI Ethernet Controller
+
+description: |
+  This is a standalone 10/100 MBit Ethernet controller with SPI interface.
+
+  For each device connected to a SPI bus, define a child node within the SPI master node.
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
+  reg:
+    description: Specify the SPI chip select the chip is wired to.
+    maxItems: 1
+    minItems: 1
+
+  interrupts:
+    description:
+      Specify the interrupt index within the interrupt controller (referred to
+      above in interrupt-parent) and interrupt type. w5x00 natively generates
+      falling edge interrupts, however, additional board logic might invert the
+      signal.
+    maxItems: 1
+    minItems: 1
+
+  pinctrl-names:
+    description:
+      List of assigned state names, see pinctrl binding documentation.
+    enum:
+      - default
+    minItems: 1
+
+  pinctrl-0:
+    description:
+      List of phandles to configure the GPIO pin used as interrupt line, see
+      also generic and your platform specific pinctrl binding documentation.
+    minItems: 1
+
+  local-mac-address: true
+
+  spi-max-frequency:
+    description:
+      Maximum frequency of the SPI bus when accessing the w5500. According to
+      the w5500 datasheet, the chip allows a maximum of 80 MHz, however, board
+      designs may need to limit this value.
+    maximum: 80000000
+
+  link-gpios:
+    description: A GPIO line used for the link detection interrupt.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - pinctrl-names
+  - pinctrl-0
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
+        ethernet@0: w5500@0 {
+          compatible = "wiznet,w5500";
+            reg = <0>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&eth1_pins>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            spi-max-frequency = <30000000>;
+            link-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+        };
+    };
+
+    &gpio {
+      eth1_pins: eth1_pins {
+        brcm,pins = <25 4>;
+        brcm,function = <0 0>; /* in */
+        brcm,pull = <0 0>; /* none */
+    };

-- 
2.55.0

