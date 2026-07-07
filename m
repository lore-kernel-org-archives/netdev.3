Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248231ED81;
	Tue,  7 Jul 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463681; cv=none; b=tSwK5J6MTGK4jFuSKy16cx4M5tCC+4llWtZabFwd7Q9dg+JHvbwmOsWr8QpKB3ykOvtPOxq6tgF9/vnEN0gu8q8ses+Q1hKihyEd2EWsM4R3O4veePb1C+tUSXKnEDHtN3RpBQqSXOoL0Xsh2BX/QZoYX2is+YRYK4JeJjDNYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463681; c=relaxed/simple;
	bh=adMG01v2qvXecmUQkfue1NV9jZPUXRkYSOz6db37F6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPcP8R5vlwuQ3nvrH20yvJyf6K1vwrHMPBw5G4Yma3wx2TRPu7JZuWeM2qQd8kLuTrd60as2F9hj8WJKOPxCCCmiEmvUZ6Uxg1VKkj8acFKsg018RXoQo8XbTTCH+N9TVAZyD/v+CCUazCD401yHhVWMZecWenuhQsL1KLEzuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Lt4um/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Lt4um/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB31AC2BCF5;
	Tue,  7 Jul 2026 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783463680;
	bh=adMG01v2qvXecmUQkfue1NV9jZPUXRkYSOz6db37F6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L4Lt4um/vsXGfrytutz4vlHiulyxj1K3PBzfzNERWMeC/iEpeoRPiGTsoi4JpN3Bt
	 44/l7NkyiXY/8XhBni34Uz+X0wsJTT7AyTVvUnCp58wq/iCRuLnao+NrDk8XvbdwVg
	 6ZzWXq/BhjzbLqrDVz0gmEKCxRv/elitNbXqxg1e+cw7gso2XbVOCn4iKuAKdoe4yj
	 MEUhQrFAO+XjTyGTZz25UTXsLHoHKgS0dYLxbAskdCmkjBbGsjQuPXjDxviZykHv1B
	 rWja+CXw8I5GpRiOjUGyjHFbH2Q9Lp9nfq7lyQL3iCcur9xRZrl5WjjK2CQ/YWlah0
	 jRIEuEl7PZrdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB41C43602;
	Tue,  7 Jul 2026 22:34:40 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 08 Jul 2026 01:33:29 +0300
Subject: [PATCH net-next v5 01/13] dt-bindings: net: Add ADIN1140
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-adin1140-driver-v5-1-4aca7b51a58b@analog.com>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783463678; l=3201;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=95m6fTW1DAX7v78Dumj0MQADqBD5odOL6MXFKYDg4Mc=;
 b=fpnY5gnRUPQt55KEg+5hI4r4PsqR6JY3gvjzLcU9ldYGzeB+nWpN1h1rKQEQHlXwEkAKCtsl2
 sKHJt5cIkwCCxNErOtscdN0aoPyMf5ZygC0HPXWZyJZ/ZxIuB+9mo5y
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

The ADIN1140 is a single port 10BASE-T1S Ethernet controller that
includes both the MAC and a PHY in the same package.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v5:
 - no change
v4 changelog:
 - renamed the dt bindings file after the fallback compatible device
   (adi,ad3306).
v3 changelog:
 - set adi,ad3306 as a fallback compatible.
v2 changelog:
 - Reorder the compatible entries in the dt schema (ad3306, adin1140).
 - Removed "dt-bindings" from the commit title and message.
 - Updated the DT example to use IRQ_TYPE_LEVEL_LOW instead of
   IRQ_TYPE_EDGE_FALLING for the interrupt trigger condition.
 - "implements" -> "tries to implement" in the description.
 - Removed the MAINTAINERS entry, as it will be added in a later patch
   in the series.
 - Reordered as the first patch of the series
---
 .../devicetree/bindings/net/adi,ad3306.yaml        | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,ad3306.yaml b/Documentation/devicetree/bindings/net/adi,ad3306.yaml
new file mode 100644
index 000000000000..785d05c995db
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/adi,ad3306.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/adi,ad3306.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADI ADIN1140 10BASE-T1S MAC-PHY
+
+maintainers:
+  - Ciprian Regus <ciprian.regus@analog.com>
+
+description: |
+  The ADIN1140 (also called AD3306) is a low power single port
+  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
+  and all the associated analog circuitry.
+  The device tries to implement the Open Alliance TC6 10BASE-T1x MAC-PHY
+  Serial Interface specification and is compliant with the
+  IEEE 802.3cg-2019 Ethernet standard for 10 Mbps single pair
+  Ethernet (SPE). The device has a 4-wire SPI interface for
+  communication between the MAC and host processor.
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: adi,adin1140
+          - const: adi,ad3306
+      - const: adi,ad3306
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt from the MAC-PHY for receive data available
+      and error conditions
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-max-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@0 {
+            compatible = "adi,ad3306";
+            reg = <0>;
+            spi-max-frequency = <23000000>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+
+            local-mac-address = [ 00 11 22 33 44 55 ];
+        };
+    };

-- 
2.43.0


