Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007137;
	b=YTg9EDo4PCcOi//AMHzvVcVqbGwUtOQVEEI7VK5XDpoLExbUQR7oPijGLD1nvXGbyo1Q
	 ZENHdpSyf5mcb7431BPJ1aFZd+jRjbAC/tXhWPG8ErgyYm4sJIMYtcHBSOo93kYYqoM9O
	 uUVPx4by/lKkAxZND0W7emvB6UVYwO793gi7fP8qrSNfXuevi9txM6KONm5De7/dZYZXk
	 z/0eT6HI/m1AMlGNIEgUz6+ny3ZuKzUA4hqRUIQvAFIyrBUh3047vffKgrnUbtegZRI5L
	 fXDXSiixNbaDiAGnAu+wz+6jlpSB2x0v2HiciuMlXoUvkqYsrKP0Go41BePzD/iTQrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007137;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R324iPA1nVnX6XySYR0RG10HRqpn4NvGFx/Uev8VlXg=;
	b=Rh262s0rCdcTJjAUpFZ0vND/zBhTA+34rFiwH/AXwztqeg5sRhW4ozQme5CIZEnOnYLr
	 ZTzsXrsLQHlNpx4YGvBQaTdNvPnU1qm+svaZdh7JrruH4YZqgKXuPwkNFlwk+rhPB73d4
	 mQGSM+yRwF2qEdV+S07doha/sG+BkcYJdzwQNMRDAP74i6T9Bl57Wz0hEBdg7y7aEERw+
	 0HK58h5Ca7hqbHhUmzED6AwzPpIRnKZwcXA5bSHQ6T6kGzX/8Psgkvvaii8B0VqCE340a
	 51WBEezIfFGFlrUVJBqmv64rsavYQt+EHoYcEIUw1b1DsvYt7h4nTOVXe/zZ5Sw76Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H2t/+RRv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C98606A32D;
	Fri,  6 Nov 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2t/+RRv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007136;
	b=ptK3xFO6oa3+4hXmpTbMg68kVr42cz8VDb2uO0KCG9LUY2JOUBJAXT9U5Uvbhf6f39ZO
	 6RJx53dStCvOhycp83a/1UCplXwLF16NbZcwdVRoGtma0ObAfjvvs7BFsaXLunb7CuAuj
	 pQcaSBCuzJH36VGaT3nodMuiSfDK5qJ0QIuvODk0EXq2Skph8eYBPvEVBq3tPk2W9gnvD
	 SEnf2IubtXeprogRnHNYcdSD1gYEXlfMEptG9Tnz3gQNt0YqEtM4qGjyovopicExLCNTN
	 aIXk+N2IKSCAPGSJDqT2GpRVcNmuqneh7tQpOojgr5+ofFdL5PZvHOBzBq8cS9elluQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007136;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R324iPA1nVnX6XySYR0RG10HRqpn4NvGFx/Uev8VlXg=;
	b=J/D2rK1lwJAgLHJX3Tn0NxijN1m+mcnOfkATBdH5bOHXnvk3bfV3Fkhlrf2R2M8Y9jOV
	 LqqikA3SifrphrSCf2EweFUjOY4ztKvP712kIiUQcr2KhxOVk5RTUeLAsay2i+aTOFmrc
	 zDNC3/CYdGbzIz2XcODhT39x2XLfxUYvVfCuLVflRbYd22df8EmGECGn3chlR93iYYDN7
	 SQKNGichqaQDzv9xc1EfoTTcncM3HTo6ba2oAVv7OmwRoJiskxssXcSiClAdTN5toF3p3
	 SuewFPXabvC1Z3Sqx+DfrBnI5efZEjSN8wQSbrGizJ6IV3RQ4JQpCeQw/UHHvOk0Zwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F5A21F008A3;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007136;
	bh=R324iPA1nVnX6XySYR0RG10HRqpn4NvGFx/Uev8VlXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=H2t/+RRvrPiMiZCRoRdSTldjoBErTzDSi2c7hWtMZYZp4WQfiwjPt0MMl6JQIscXI
	 LtVm7047U4NDe4yuGeAvwl3mPDkmt56vlVjXgUDROTxBMO58D1C6/xYqLr1hazFrZ8
	 PbYtbWKKtB5HSLnYdH4NbmuFZ/XxDBZtEYxvIMOv2iL8s/MyP9ms6HZmcgOhv4Ey2A
	 UQNGH1GqKC3bKaqWGzpKab3twe6ad/si1y/65RGs4VlbgNeWXJarrwFKLtZCqnpB9j
	 kz9OnnUssd99+AJRd9YnbB7rp74by+K87NQ1EDRh7zi6oh2mlAYznnJqGp6HgF8JfX
	 A6hMM+BxlpMvQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D73B3478C0;
	Fri,  6 Nov 2026 23:18:54 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:47 -0800
Subject: [PATCH net-next v10 01/11] dt-bindings: net: add onsemi's S2500
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
Message-Id: <20261106-s2500-mac-phy-support-v10-1-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=4285;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=hdOOixoEOyjlodDhMqEkzNZDkNngr5knmgPzc+o/5Uo=;
 b=gU0ZoLCli6m8aUX0OnrCBb+e0AIq0lMiVls9heMe/s1eRscUDok5EELELjtZs/p8DI73TTOL7
 +HhMa4Y/OrtAMuAkfDKbiSSIP+89KzM+C/Ckyj93jPclESPJ6H1w3/v
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 8bit

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
changes in v10
  - No change
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
index fe23913b1e43..92053fd89bb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20999,6 +20999,12 @@ S:	Supported
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


