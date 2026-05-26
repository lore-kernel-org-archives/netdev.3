Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041022609E3;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832340; cv=none; b=o7i9fpmXLeRD0ZcuOTKgbnFtxY6Enegh3wlGp4ALhP9AJEJQyC3Xj+gtrRv2GjukxORSbmsiHPpC5fw6hK0gqTEXGOOOvT7eAMRf3agcfWNg4uwRsXZIIbcOplF3eTDmmXl6EfAQxFAFrAcpbZrwVnVSolR9yl8Ha0Qph32FlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832340; c=relaxed/simple;
	bh=hBpZJqzIKkIMa0o5/UN2VhueexgYznTR0lfWQhW6fHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKzuI7/7J4pmHD7lbOqK/0RExmpv3OMS3fN8QiUOcnv+H6xpA1C4OvEdBwgfLoNZYOxZEqwAn0Onj6N5wZ8wn6XyBOkiy0hnrZA2fWN1QQVgGoZ43qBnvK5s7QhdpOVUbIfylTWE0AVlgutuZfIzq5wkwrzjdrcHfJKZPB2FSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avnk7d6w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avnk7d6w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2C48C2BCB3;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779832339;
	bh=hBpZJqzIKkIMa0o5/UN2VhueexgYznTR0lfWQhW6fHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=avnk7d6wa6M32zelIYNiUxwi7u7v+79xnz4BXpZT5ERYXZC4Ev/ywAqXxR5xdrcYp
	 7S3oCuC6QNP39H6P0Pmqp3pKsCDAYWnh3IAPkTcPexgJ57vzarmfYiNOgfuTQ8bhSm
	 7OtkdDpwWWsr8UhyMrv9mWCHoOCcdDFG3g/OcsEATJy33gIqKvE9pxvSfM2Xc/0YRP
	 ePSo5sMnljyngXK0WPNkkkRdH5jUNnjw+Y1RN2WQ1KGHKtS6GPWrDkquEPCVMLqnnr
	 GWRUZjNXqSdSRej1JCz38kee8cIQXiqWIQQCa2QKBvWGUcTgkIa2pDUDJvWFXzGmhz
	 RD6hbkdT4sD9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB4ACD5BD2;
	Tue, 26 May 2026 21:52:19 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Wed, 27 May 2026 00:51:46 +0300
Subject: [PATCH net-next v2 01/10] dt-bindings: net: Add ADIN1140
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-adin1140-driver-v2-1-37e5c8d4e0a0@analog.com>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
In-Reply-To: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
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
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779832338; l=2907;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=JlftDcHzI6Sedemvx0vq0rArN9pb+7G+DJh0bC/HRsA=;
 b=ldO/ufoMM8dwCDnfygQsluxwJlSHRKcej8SZQMzJkaSJFQetIuxEybBYdFbWggX2ZA6sIp08T
 4hnzSsSI8ZnDm8mfL9PjfJ4qecIT+qgUcjsBQZdX7BPB+2Vatz/W5K7
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com

From: Ciprian Regus <ciprian.regus@analog.com>

The ADIN1140 is a single port 10BASE-T1S Ethernet controller that
includes both the MAC and a PHY in the same package.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

---
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
 .../devicetree/bindings/net/adi,adin1140.yaml      | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin1140.yaml b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
new file mode 100644
index 000000000000..518ff6b36c46
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/adi,adin1140.yaml#
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
+    enum:
+      - adi,ad3306
+      - adi,adin1140
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
+            compatible = "adi,adin1140";
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


