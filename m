Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD547F795;
	Mon, 21 Sep 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987992; cv=none; b=FnuUtfbFI8pcgXuZ4VcrF1nhjA+wtrGEECwXckwK1l5RgiCw43Bb3I+KyhAoPy2cfmY1MLoOSTNPln/V867cZbTr5yidahmbrRXgxZmHtgvDSrFhHr3jUprbFT8USfX/pTexCfqqCsG3OJtukgNa48BOlajUzHzuWq8p/L8y35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987992; c=relaxed/simple;
	bh=BJ75lLlSgyzM2wQO3tYd2McRyKiY2W1uYmMLQx7kr9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZ4NhGDycTDozyJyeReWMe01/5ceKxWUKRSrnlCCGEKWT9MBMd/qHqBwFmgwDOKJ5yQirVsvi/NYzy6RoHLaGR6ExFSRYjQ+yCV1zeqOmSikiBCC6X7As47g5/7d4/zQ9DgKb9UPlJdm8R8CbxHB3xP9tN8m1CDpYb1t1S4G2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=dbt1IvLm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="dbt1IvLm"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9324D3E97F;
	Mon, 21 Sep 2026 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789987983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82QfXG8nmblaTFz/6ZibSdV+IL12FMTks3/El8TvZ+o=;
	b=dbt1IvLmyQ6oYvu6CgxIkibEv8XQ69pPNI5bGxXu1dVrIU4UREHey9YvyobM4UXKjBuGTD
	0W12dcYPj+/shXpoO0C28yPVRhpxEPongn1Naw83Zcu3RVGZcwTg4AfantgzMwf6kx+GIW
	PCUEi+0pZpnYgE1/P09ieOTj/P7Dr7JcxLn19cog48mvm+3w9u8GRc/etqDdZ9oxQ/ZhI4
	wm4TjRJ/9dqPLu9o+8v2N4oxwleZNWE5kemRZ+QfYPbfb+OFnUUixZK7K6pn4OVuvcQm1P
	nuH/0WZuHA2Nl71zYW4zhp7GRx6veJD3NPRibuxlw1JmJmP8jRzFnnkiC1XdQA==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Mon, 21 Sep 2026 12:52:49 +0200
Subject: [PATCH net-next v10 1/3] dt-bindings: net: wiznet,w5100: convert
 to DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-wiznet-link-gpio-v10-1-5874a7a147a2@marmottus.net>
References: <20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net>
In-Reply-To: <20260921-wiznet-link-gpio-v10-0-5874a7a147a2@marmottus.net>
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
X-GND-Cause: dmFkZTGAJpSSaGTA23Lngg1tcRHEbmQGfC3Ghn+7BkMDldmKnWfpH3UI9/TOsTCM9NdW7JL0yl/FBFk2mjsZJmeH15QClcg1bSVpkT+whu6LHKWRp82wOJVIgBM30rLrlpkNBfvqjAuSdKwNBT6GdyToqvZPYS8Jkbys2+jMYFcQfA1BUkQauCsj9WFkm4SaihXKTz54p4JydoDtzKVLzXZDR4hqA/QmVHtMrljr2ylwza1is/b58DqPEVUsCPJfwY0rF4bzE0MP9SV18pLqvFZ3huLNwuSF/fiHs2imRfcFeSGlRTTjdkbFSlSTEPs1tsJAcOgFPQgHkN7RO4lIJI2i49H8jDpJHc2JEspjyCRRuJhcOmhbFeNhebbVOKxtF6pw3tY/LDVYxkbeDWf4gmNCo18cK/MjicW5nRYYBxZNLrtgjrHwewjCCZdHCjEl5wdfnV56oArs68jOrKFZINED7EJ3vW0QArAXNfTWdvmpxA3BRfJo9SEVR1Dgy4Q7bOLFHUP0QhWyWC1KiFHEEZIOWt6Vsw3Rs8XPLu9wSoL5B8/PIFGwmKRqiHFISVSDppVYnHp480F/WtcelV2deHhuwB/LE3vScRh9tsDXudf1TJvKG2ggFQpWTs2jcpRPrXzadLXdDJYEFo7ZTIfos/iV8Rcuj5GQ0CW+VuwsXbdjWgnJ4A

Convert the Wiznet w5x00 SPI Ethernet controller binding from
plain text to DT schema.

Change the trigger type from edge-falling to low to match the driver
implementation.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
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
index df8ab9b82402..9f84e4c8163e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29450,6 +29450,12 @@ M:	Miloslav Trmac <mitr@volny.cz>
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

