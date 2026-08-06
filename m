Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78646448B8D;
	Thu,  6 Aug 2026 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028429; cv=none; b=Biew9inmkjpknWudef8Xpc6VFeDcU9eRtmlfr2zcIKH756tYCgpUtimGm8+7BO7Mt61Bc4+4a9PA+wLt9gY1oQXmJ+hVDbe/LbcAAOADQMjsGLlxDglKeHt3Ibd3A+NnYywldsUjtYzir27staNXVbESySqEFRpfSHQMzU2A2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028429; c=relaxed/simple;
	bh=IXst3cKVKDLmRagRovNr0FfjZ5GeFMvyoHKbudg/r+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XULmNuOnmjcHwFQKFYQ8RbosXLIaKl+lfuYC2hAvsDa7YZq+W9Fv9iWwnt8ShxHV85HW9kcyL97xmTR33fc/YSCmwPk5D0936iOCgoHPMjPg/CHFXo2fxUIyX50MYlL/4k01htNVFKEDbQzUjGa5EowkKJ7I/LrV7rEtko9JYak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=G3faqlTw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="G3faqlTw"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23EEE3ECEF;
	Thu,  6 Aug 2026 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786028419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90d8dWirxmfwgGLydAAfx1QUlMewXIwlua8Bh1xHfUQ=;
	b=G3faqlTw60IROFngy8xL1NKoSXxRn5d5KMhArqf0YlMDgAs1ZpyCj4kLVxNKujTP1CKAU/
	bK3f1QyBTenk8A+RNCjgHb5C6WqFSzqZBxOUhW+xhv/jogj51BVZgOUE+CjBYPmYJdlz7i
	AARyGyj6RQ5jzFnh0ZriDhtvtTJK20FWPw+ON4gTlUKfcbz0l/pewuIFN4jCVobcHm8zSK
	rs3rVlzdo4yBWd5cM3sLX0LarnpwKEnIIxojjbGZf1+kgTcVYEblbuOb86ZfYYlKZkPMwd
	LMOPMTJj4EZiONblDDv9scqALQ2MX5wtQfa3ungO+aIuczs/Vgm39mVno8Vg+w==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Thu, 06 Aug 2026 17:00:00 +0200
Subject: [PATCH net-next v3 1/3] dt-bindings: net: wiznet,w5100: convert to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260806-wiznet-link-gpio-v3-1-532d4a143805@marmottus.net>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
In-Reply-To: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTFXr9okfw4jPp/xxHAYs0x2o65yfSeJ6OzsqMvfrcKdZlYJHhikgqkTHnpp9BuF6PyeukxCAV7NH6qy8B9s4O/nQ7yV//yxCRVt6v6NGYnE2P+4xp8KWCEuMeI9DxVEvkF+X9KHK5ZpKzL9Z5hvsh3taI30YBjeQFUg39YH8Az6mcm23c2w/2F5PGzSq1S4l8TrXYA9k9EVVMBf9heLWuaw8GVelVwN6sjsMP7z+Md5EHmE5sh40R2H4iN+R0jcCPz5uYVZ89LnY6VFF3Hkt4Vabr0qrWdhS6H0l0EPSyCdC6d+Gu1DRy1Ju4nPcMGtVFDK57bOFPybzv/U2hZoEW88HwM++OwpHuQpatp/aVPXHyfPaI0sS9OR8eNrLPvatYtwxaghoBU5RTDl8SvvIDYVa4NL6yu//xXiLg0rmwFUFCvHZkStYELVAMMkDzYM0gaFM0aSsF4g5meLzrYCso3it4od2HrlOUowbdeIEWr50bI40c/RMtODowBnzeHYgqfvoK5qvywsi74NKPb4e/yxCLhjBfyy4TstcR+h/lOIGK4L62/J/DxcdZdKItT0HesxhE6o9WEHE2eiVJlgHrOI7Z0QbtZ8Cl3TKQv+B8UEbwrd29Hm2WN1J54ELGWuB3AkpCiV6pyZcJNZe4p+8isGza2wrqUIwRgIfGg67zO9ww
X-GND-State: clean

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
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

