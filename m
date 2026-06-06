Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77630EF82;
	Sat,  6 Jun 2026 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724570; cv=none; b=bPyhyH5vVBf1FXBoCrPBYl6dE8oapQWbFLPipQJ0ZtfD6BDhJrbr8oDWCqax8rDTy3IyHy06+4f2yKT97CWCF6Rpet+4X5yVfCsbsuZsokZhzMp84416BJAfDuET9+mFMMwZMTXcDZ4HzhCuuPa9vUweRBy8TFkZkD/A0Iud3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724570; c=relaxed/simple;
	bh=heABrdCbeBYoZYV9Q+tn/OM7kZ998Emxjxc9jLrmfUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8EldadaofMlL6ggpeXwITubUnNoDKtecTA6/COTzpOa1chEJ8S4O9MoKCWi8hqprVQ5eVe06J3jSVu1DiZuFp3h+XSiBllEJyYvXgxVkfnTgG4rZBi+mSOsx3RZNwKLj72fq+W4sBUdFrEd2yTa5PGRFzi1xQFMyolG/SWuCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI+VARfj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI+VARfj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F83EC2BCB0;
	Sat,  6 Jun 2026 05:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724570;
	bh=heABrdCbeBYoZYV9Q+tn/OM7kZ998Emxjxc9jLrmfUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qI+VARfji0b1kZI72S5x3kAIMcGjq5wxVZX6oBJjCPTKuCbmdy5/gUAYD2l7zXk7O
	 wuX7NUBtHnlhVVuVIRrdSUw4ThvdW7H0Jwt/LIoHz72pvmksaR8/VYb/0W647pqtn6
	 hK1lW2wzOmQ795xh/XGA7ljzF3Ty95FRVo/eAclU2IAYzdF3V60m3IALXw9zgKMdva
	 nJG3G34PB+fvfXcDQ9msLiyRZwS4Lw9q4mJNmFmKBzM/3jYsgd1yoT8aJ2DBhFirXy
	 pC8RpcTyRt7/mOdRyqX59MD+trYTLAlgg2u9bf2FfIgnVGhXDDf2RwKX401f0YYLme
	 V3EOG60aFx6cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B11CD8C85;
	Sat,  6 Jun 2026 05:42:50 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:46 -0700
Subject: [PATCH net-next v4 15/16] dt-bindings: net: add onsemi's S2500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-s2500-mac-phy-support-v4-15-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=2795;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=HUXIze6RdB6ERxDfpaDuHws8RvRgXJ4TnBjjVkgB2pc=;
 b=aDrRaIi0388pStuo00JchezrNyo+dUok5/9yDCvmHd8t+I/CLsVWxLoD8eykZxPWt76fJrJCb
 B0p7gJWjcqJAefgMFEU+hs7Ibl1+aGhEfUIMm8+27ltYmUh4U5EIEwB
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add YAML device tree binding for the onsemi S2500 IEEE 802.3cg
compliant Ethernet transceiver device.

We use IRQF_TRIGGER_FALLING, though OPEN Alliance 10BASE-T1x
Serial Interface specification calls for IRQF_TRIGGER_LOW.

This is to match IRQF_TRIGGER_FALLING used by OA TC6 framework code.
This bug fix requires changes to the stable branch. At that time,
this will be changed to IRQF_TRIGGER_LOW.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 .../devicetree/bindings/net/onnn,s2500.yaml        | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/onnn,s2500.yaml b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
new file mode 100644
index 000000000000..11edf10508d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
@@ -0,0 +1,67 @@
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
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        spi-max-frequency = <15000000>;
+      };
+    };

-- 
2.43.0


