Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8153655FA;
	Tue, 15 Sep 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459587; cv=none; b=tjdOFw7LoasiYAqApUaeTVkaF2Zi4EYMl4AKyEK1r3hLZJlEEt2WA/dD+cKDFImOdVR+ZstSlT+TTHv3K4itvqQvEhN2a2dGEFuSb//BfLIkf7RSoZyQyJSk2YL9YcxlDJm13ofyQDsO4aEY8CEGPhkGRFURZYJClQ0S5/4RiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459587; c=relaxed/simple;
	bh=huJlGR1UrTSOSfs2sEbA6FJRf7N+rGl+NuBO9dz2gcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdUu0MY0Ynvse8VglgACRZFsFXOa4ioCElEqYgiNDk9ekFfz6VL+GYInWe8dh+amINcMMoNQZcaE7NNI131WrnmfJo98YVSLs9J2lj9eCz6EEHdECCrFRrN5+uzX/0jIHIdfRVQRWYf02vHfLSLO7wBzqu/WOLHW//R2OX2QAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=FZmF0iWd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="FZmF0iWd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12A003EDB9;
	Tue, 15 Sep 2026 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789459577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQOlmpJvNxnVNPdsPSoEc1kTm76NavIIw7R+fCDLpuc=;
	b=FZmF0iWdFbz93h6n6HP5I8oXXVAAtrowhc/UZWwxgGbR8Qp49F7QZ8sPl0zEstv8ykluvy
	9znEwO5mPF0gj1TQN845kA/EwuZJ7nawjgSrGU0pAKRIvMvltg8fnhOtMcTJD/J1Nu/GaZ
	QBhcRv3Lb1EsIWCty49UfeVpYZcftgnVTLyxe5t43btMnVRXpMDjXrBNKADjkZFGP1xIGj
	k4wQ8ktnlhwehQyo2sZTSSTD8RO0m60sYHTX0IKC0lB6yo/7e9uXMQp9auIK9UAUFhmbhi
	j5puTIC0n3Zd4rbJc+lw8l1MI4uis4R077uyq9YbPO7hpIq5NxabcjVLSVACHw==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Tue, 15 Sep 2026 10:06:02 +0200
Subject: [PATCH net-next v8 1/3] dt-bindings: net: wiznet,w5100: convert to
 DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260915-wiznet-link-gpio-v8-1-d173622474cc@marmottus.net>
References: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
In-Reply-To: <20260915-wiznet-link-gpio-v8-0-d173622474cc@marmottus.net>
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
X-GND-Cause: dmFkZTFnpE47byBS4rdGAgGi/KwVFJ4qnxfS+YMMkmf4ICKnnqaChMKgNZqONsmcW7seYZvnvzlktfYPsJWTBtQWd0M9YOGjgsNBByDMrfRuEsyOkhmKidw/4yAAkqS66N3H47W4MLATGbl9DduNFRfhsinJhgU7dH1+VUOYAZP0BYjrjfPpW4Vl/sTxyGuJ9AXMioXkPFLU/onSQc1VwkZBgD7f8xg1DqGxu1U5QyMyWudahuBdRpdo8pcJykJ4hFLtvj4RaXKaLDAcneQPWdBMY9KRg/Z79n9HXAUC9OGo3p2J7hVG8jUzb50ApuS2DGXtdwnfW8D4wMpmqTR2rIX9KsshP9TLXxiC8fGwBoeKq9yRvTLxsUkHH8TY2dFZW/7frL+EYVm9cSp00HaLpjgYVgRMHbwMuKI0xP3Z4isosqhQ3wz1k64C1P7eUmuoE+9hxiDQ+VjIipBdhNn+l0Jz6j/FO0n+V78Stprwv1Lg9x7sFWvqyKKBN+5dErt/SB5Lbvtx54nnpQ0XlTQUv041gQrfWo4ca2tUQ7ydG3NyBTeOcMo8C50veuAYNoPTM61MecwBD96Tzash7cwvkd1RZTDGHlsm8LdYb200yXftLpwP89Hur85cMRA2X5alF7WnGnMJ4PmfHuKOgsuSNe4ppU5Kdh2+CEBp/8lYw8YgCTk/nw

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
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
index 000000000000..25098308eb6e
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
+            pinctrl-names = "default";
+            pinctrl-0 = <&eth1_pins>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e04d92d1b09..624beed96f32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29440,6 +29440,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
 S:	Maintained
 F:	drivers/input/misc/wistron_btns.c
 
+WIZNET W5100 ETHERNET DRIVER
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

