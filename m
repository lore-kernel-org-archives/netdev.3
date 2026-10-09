Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF313B19D8;
	Fri,  9 Oct 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565946; cv=none; b=kffBHdyD9sSxQ2NBsg/kt+6ASAD3oy1NWAMyb0a/eapYVYck1lanpZMtpJvxzlUJKlBW7Qw9zCmbQV/MIvhyV3amEWT2zL9xEw1U6YifQqSRoZtfRi7YSoctaCudr/PhD2SYM+DbnaSLXJBzTkb7xMwKjn0X2TMUU7e8hMlieaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565946; c=relaxed/simple;
	bh=eoMsT2kCEP4o4UL9QMr5FxOgSuR6AD6RXds8ExxdYzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sh5tWfzSfPdBO0OXy/u379ea94M0Dv/7qgl26dBjrw5pVNx5FQuTiNFLkWH+LxBbDJl3HvWcAZaLvjbCJGyDk7mQKvZRi0frX54DgRWRHOZQgPRJptsO03DYc1hgmWJbNnp4b+18E48NtfluxGEl4XZqeAtXr3LmSI7GnZG+Jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArEgJb1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArEgJb1n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01C07C2BCFB;
	Fri,  9 Oct 2026 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565946;
	bh=eoMsT2kCEP4o4UL9QMr5FxOgSuR6AD6RXds8ExxdYzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ArEgJb1n5HkOQxdpblcoiOMQP0KSaPubSN0xKxpbO8FbTXXmwIxhry2/pwWcNqyzK
	 n6KVixQJXi3j0wZ321qQmdDDwypr4wqWF37bgESOfYl4GYxhZq6FUxgxKzKkq57XBA
	 woqf12/RBIyyYDQitm6vJhX9x/nNvXo+AWPQLX27SYHLzkyxB32X2n97BoRcuoONHR
	 Z2/rMbreDQU9R2BuZrE3WpiOqmmSxpQb/+IUxPTJwzzy9CZORP1jM+nKjjKObGULJg
	 2E57hqiNbQMqM/IK7lvcNMdhNLZmUqT5kxdRwwrZu0jqayFMGcED8xnkLEPkBQ5SP7
	 1AAGJ45vBkYJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7ABCA601E;
	Fri,  9 Oct 2026 17:12:25 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 09 Oct 2026 10:12:21 -0700
Subject: [PATCH net-next v9 01/11] dt-bindings: net: add onsemi's S2500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-s2500-mac-phy-support-v9-1-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791565943; l=4254;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=s24W9rfrSnDGEraYMyIz+8oVGuuQME40cNuCCXkoi2I=;
 b=PVLto1/digtMJugP/RSsOAXlyCygY97EyxW06D3C302SvYr/5+PDuk8zAGyl+zEjiEMcppElJ
 doTUOPM3+d+DHb42IttwIZZz2UcRYJzBtoUPJOngylCyZPs5JnMLRvB
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
changes in v9
  - No changes
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
 .../devicetree/bindings/net/onnn,s2500.yaml        | 71 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/onnn,s2500.yaml b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
new file mode 100644
index 000000000000..fadd656629f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/onnn,s2500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: onsemi S2500 10BASE-T1S MACPHY Ethernet Controllers
+
+maintainers:
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
index 509b35b5a0e7..abf9a8f7ee53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20440,6 +20440,12 @@ S:	Supported
 W:	http://www.onsemi.com
 F:	drivers/net/phy/ncn*
 
+ONSEMI S2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/onnn,s2500.yaml
+
 OP-TEE DRIVER
 M:	Jens Wiklander <jenswi@kernel.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)

-- 
2.43.0


