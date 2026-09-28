Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B32EEE9E;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634324; cv=none; b=OI+usIg9rClQni8i2dwwttQUEh0NFv2ZQwfhIv4O9bA2MTyaLtnvnpNMcCzfgsg3IkoJNICnKjibwcpMq/09SAqjlK/lYlIjyyp2OJrU1Gc+juzsI6kLqJRaiDsNHEZJ65ky9V4BIiq9NbPxLl+LQjmf2YVplGD6+VDfNyxius4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634324; c=relaxed/simple;
	bh=DVyAQwStdnAA8wt7EZ3G0p2h/oJI4G4x5mNTYXiKaLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTEDawvKbDhI7YH2wYRvzqZTC5HLUSNZswkBfTLf2UwHQhbcmmZ9hdE53FFO4pZBNzuOMMlkSSmcfB5yeDwCYrgUKzJ2PdKaXsit3vE08EIpVJEDuja60HxZio2K0CBfYSVDJPaCkF/lKzFf7IcxAzknGszBuPU6NrT+o5DFowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgW8vWK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgW8vWK6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41281C2BCF6;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790634324;
	bh=DVyAQwStdnAA8wt7EZ3G0p2h/oJI4G4x5mNTYXiKaLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FgW8vWK6aMYS3iYlROVf+ShxdI9Eb49CzqLYL/GGpVj8+h59xQ/IpJeD9MTa1LDQZ
	 wgHtLSnzxLsN1e3in1xR2KEZjILc8MbmhGZVcBxb7EQdWRBaKv8jP1kOsNOaYvjU4c
	 b7AyTFQPiODdTT/YgJ+2FT3il6Ir/sDkBHUgET5qjHWLPhXYd06+KuaHkQ42cOt2gS
	 72vb/0mVlOV2xsynauRdAQjIlNJTJmIRFGTqdJBMtK5vsZ8K9g3uXHXJJ+hMKaXJoU
	 7TBXbJFVyalY93mZPwEPuZH/pdMRJbnStwd4YDH2W/mdFZ6i5UDsqSYhJWFFExSiME
	 ajV1Cj6X5sHbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD1CCA5FA1;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 28 Sep 2026 15:25:08 -0700
Subject: [PATCH net-next v8 01/11] dt-bindings: net: add onsemi's S2500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-s2500-mac-phy-support-v8-1-7e011aacc309@onsemi.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790634319; l=4321;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=05+p4ZjJ3/dsSG0TTWxQGWcY5intwKJo0N0w11PE4Zc=;
 b=3a2CUNPyJDWy45bTIdndf77CshbOObsb66BFDkNstIT6vOi8YDLZr0JD1poEHjGRJLuUqr+9G
 l47NrYjUcUtAqHEObVCwpvzGJAbIrK+PVzJWlzNhUH7iiCcMjzmZW5y
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add device tree binding for the onsemi S2500 IEEE 802.3cg
compliant Ethernet transceiver device.

S2500 has both Media Access Controller (MAC) and 10Base-T1S
Ethernet PHY. MAC implements 10 Mbps half duplex Ethernet
MAC. Communication between the host and MAC-PHY is defined in
OPEN Alliance 10BASE-T1x MACPHY Serial Interface document

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v8
  - Changed the interrupt type to level triggered
  - Added reset-gpio entry that was recently supported.
changes in v7
  - Added the missing review tag
  - Removed the word YAML from the commit message
changes in v6
  - Moved the signed off information to the right place.
changes in v5
  - no changes
changes in v4:
  - added spi-max-frequency as suggested by AI review
  - changed interrupt to IRQ_TYPE_EDGE_FALLING as it is
    being taken care in net (stable) branch
changes in v3
  - Removed URL link that failed verification
changes in v2
  - removed spi-max-frequency entry
  - changed the compatible string to s2500
changes in v1
  - Added the first version of YAML file for onsemi MAC-PHY
---
 .../devicetree/bindings/net/onnn,s2500.yaml        | 72 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/onnn,s2500.yaml b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
new file mode 100644
index 000000000000..97d1cda36683
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/onnn,s2500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: onsemi S2500 10BASE-T1S MACPHY Ethernet Controllers
+
+maintainers:
+  - Piergiorgio Beruto <pier.beruto@onsemi.com>
+  - Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>
+
+description:
+  The S2500 combines a Media Access Controller (MAC) and an
+  Ethernet PHY to enable 10BASE‑T1S networks. The Ethernet Media Access
+  Controller (MAC) module implements a 10 Mbps half duplex Ethernet MAC,
+  compatible with the IEEE 802.3 standard and a 10BASE-T1S physical layer
+  transceiver integrated into the S2500. The communication between
+  the host and the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x
+  MACPHY Serial Interface (TC6).
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: onnn,s2500
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt from MAC-PHY asserted in the event of Receive Chunks
+      Available, Transmit Chunk Credits Available and Extended Status
+      Event.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO connected to the active-low RST_N pin of the MAC-PHY.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
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
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@0 {
+        compatible = "onnn,s2500";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&eth0_pins>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        spi-max-frequency = <15000000>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6de1ff058db6..64da809e4602 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20426,6 +20426,13 @@ S:	Supported
 W:	http://www.onsemi.com
 F:	drivers/net/phy/ncn*
 
+ONSEMI S2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/onnn,s2500.yaml
+F:	drivers/net/ethernet/onsemi/s2500/s2500_*
+
 OP-TEE DRIVER
 M:	Jens Wiklander <jenswi@kernel.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)

-- 
2.43.0


