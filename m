Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589170;
	b=UYsyZ+CtKnhi9xbYcGeQ6P5OxO/KEkkNlNKMCGusvOVtNz72HlDeSwW9E0jM+qCi4kSI
	 f8kzS/aatDBN/slp97T+v7ytG7sEPVsll8qAEg4iCDAWyOrZ6crgEoGlQ2mEMqIH7OPxt
	 q9eiYZZLEx998SJLLY3XRQtTy8BpqPxN8p/1bYSNy1SkXJ3HtS+4NmYl5UcSQjfm6JY+r
	 Yy318ZbyMSCgKowkug97xyddxsBWdfDnGC45WIibnXGbJqnGE603sM7qPpKAj7tKEH0zx
	 gShodCBoerJDH4+vLpgxo8IHA1Wcr44OXrUc4VGZu26+vFW2cKhocKMo2FZ9BdUDmJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589170;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KnWkvUMYFp0pJ5aAC9Vy89LT8XicYuU9hu1yqcU4TSM=;
	b=JbePtu9KH2g16Jlr/aPP+BKOIxxneyOS7Lc9NHDOk2EzY/oZXjQpwS+yzDA9P6/EhWyF
	 yj82UCAkItj7Qq8e6jutpsc9PzFOeQgkDe1iOrB5IWs11inmRqkPlIfDUiaBEldisNFyU
	 BihbZd082Pr0ig/ktKlMTDh1/1LXcixvZWqV9bjDs5mSwVLfi6jeslaP6Zi6Q6b8J4Hqz
	 u/SPQ1/gvkj5iXlViyLovMyjQypyA8LnvOwZJQkv0jxtw5Gi0bNuykDEGJuwqnykctTMv
	 Or+5cFrCtc5BDettEG/MwIdh7rRmlODqp3FkVhBk//97VGobDzyJrO5de4TdsyHSPKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxDV2m0Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB468606A327;
	Fri, 13 Nov 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxDV2m0Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589170;
	b=MW9FxhfkZwlkVPHg90tipohUQuTYmDCZ/xbG4afdQ20T5yX5brl5PRlyl9GvmT3/Tg6i
	 fierMNZMNwN9cRL28GSVRiYflQThyBAKhOWYZmaDuJ6srXYyTg3gFFT14auS3nXCbiawe
	 7obXRyqYyzGpg6YfCb91X9Jtl00t5wZgOUvc4nPlWlS94z9BozFFPV3gBFm1Z4zMR4ZvL
	 3JLwZrPnwISdkY4f50enNc+czczvrdihdoyYbTRRT2cS0q77MHsvlT2w5CI7NNYJjTQSr
	 hl565x3WlkxeS86sN4gidlkTIIYHtKFutkJFK4fyp4hPJPpWuCRtwzjEARSkZN357xg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589170;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KnWkvUMYFp0pJ5aAC9Vy89LT8XicYuU9hu1yqcU4TSM=;
	b=3ViBD9DjgMde3tNyvats/TA0OaSQ+ExMWa2hpEVNejjvtfcoX37dWQMF7FWbLz+RLx90
	 e+3nC5UCdontrGz3987M3JJTb8Y4ebGmztUka5T5ret4SxRLlRoQOotS5Mc3qTGfgVj/t
	 rHt3OQXRuh2DGYRYJa3ciJYtT4+ARpro13f0jFyxC+4n7JVEdU15LRvuIJSCOwCulCc2o
	 C0XZLEcd6c+C9Y1KhGUrFfsOqcefGed0UTLb1dNfgo/Bt67lh76mM5dvVGcZsBqMmv3i2
	 M9eC4dD2kiXeJRRxqKpiLJ/YBHl9lCCpfeH/rGTS7RVaXHtIJUSOa6UlF+yc0hlgftg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 91B771F000C6;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589170;
	bh=KnWkvUMYFp0pJ5aAC9Vy89LT8XicYuU9hu1yqcU4TSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZxDV2m0ZlCEp5n4MdUqpn4tHeA/vHv5uA9uCrdbv3F7BIbhyckh/HQ1xGeFp5WiMF
	 bxswqNHeN7htGPRSC1gr8Ul7+3k4fCfEDQqeNWMLKMg5BbJBzAMco/+qHUlju9RVwk
	 7STQ0D77E1OWQs+1MPy2Kt+U0YoPwKZwHEQ5oUrvbAn2x4/1LvNX7jspG9ZTf8Iwk3
	 x8+PITSXfLT1IP4o8pmdOj6MMYhyEWDWOKzT1mZT5KOOeQUWSHocbmPKI34y/jVMQh
	 KoQoXck0+zRjd14mrZtcC8GzeYb+qJNs2dWKXKempPKgikX/JHV4Cpw8iQE920wnON
	 ZJdptFPxVbQ3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 05DB649A0E;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:20 -0800
Subject: [PATCH net-next v11 01/14] dt-bindings: net: add onsemi's S2500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-s2500-mac-phy-support-v11-1-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=4324;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=ydl5QiaaznD+gOcse6AuYZUijr3nYJb8olhfZemEaIw=;
 b=85QxYvRD1NilPv+Yuy8gY7rhiXRvHCPbUnzuUez98NgyJkHBE8JEiAct/AtmRWDDRo2/q1nlg
 n/Dv02mm+MCAd1JxpA7sZWr+D2FlAlxs18A4ObU2glymP6WqXS+74jS
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add device tree binding for the onsemi S2500 IEEE 802.3cg
compliant Ethernet transceiver device.

S2500 has both Media Access Controller (MAC) and 10BASE-T1S
Ethernet PHY. MAC implements 10 Mbps half duplex Ethernet
MAC. Communication between the host and MAC-PHY is defined in
OPEN Alliance 10BASE-T1x MACPHY Serial Interface document.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - No change
changes in v10
  - No change
changes in v9
  - No changes
changes in v8
  - Changed the interrupt type to level triggered
  - Added reset-gpios entry that was recently supported.
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
index 000000000000..e1df674c0f1e
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
+  - Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
+
+description:
+  The S2500 combines a Media Access Controller (MAC) and an
+  Ethernet PHY to enable 10BASE-T1S networks. The Ethernet Media Access
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
index c583367c88bc..4a4c26694ba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21013,6 +21013,12 @@ S:	Supported
 W:	http://www.onsemi.com
 F:	drivers/net/phy/ncn*
 
+ONSEMI S2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Selvamani Rajagopal <selvamani.rajagopal@onsemi.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/onnn,s2500.yaml
+
 OP-TEE DRIVER
 M:	Jens Wiklander <jenswi@kernel.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)

-- 
2.43.0


