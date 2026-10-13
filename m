Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC790538D6B;
	Tue, 13 Oct 2026 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917815; cv=none; b=RTdIvddSaghtuvplXNfXQcn2K9htvqztPd510E00bxiL4HowyBHHfOd9gwXb51YxdYBYf/L2XS7RxzJCKYdULixfbZz7LmABnNxM+gKn0kuZWL0ppJG/pztFXvkFQBTcTtmUOuqTc6HAh4hbYruOUFw/7L26hhmNqXDJnKqCCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917815; c=relaxed/simple;
	bh=AUD8AXSJjw7u4Kb6OwQ06qvNcPYnDqJAs0Vw5RcXecI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLR+RronfkkJFdPbp3m+zWTAeumfZkjVrmiNCh6gDiDQzEp3etkdYa9Is3PvYH6mLUTRwD4hGuTPOjH+7kmv78M0BrWXuzYBxKwxUe3N6rlUrsLrTzPyGJ5ZSl3KcniJbhyebzFBmI9uEw5IbpH7Fs8gmBDWQRx9eB1+7pQMOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id 265912067B;
	Tue, 13 Oct 2026 18:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id bS8njainDC7u; Tue, 13 Oct 2026 18:56:42 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id 272BA2040A;
	Tue, 13 Oct 2026 18:56:41 +0000 (UTC)
From: Oskari Lemmela <oskari@lemmela.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Javen Xu <javen_xu@realsil.com.cn>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Issam Hamdi <ih@simonwunderlich.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jan Hoffmann <jan@3e8.eu>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manuel Stocker <mensi@mensi.ch>,
	Oskari Lemmela <oskari@lemmela.net>,
	dam.dejean@gmail.com
Subject: [PATCH net-next v3 1/2] dt-bindings: net: realtek: add RTL8224 package binding
Date: Tue, 13 Oct 2026 21:56:34 +0300
Message-ID: <20261013185635.1412452-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013185635.1412452-1-oskari@lemmela.net>
References: <20261013185635.1412452-1-oskari@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL8224 packages contain four PHYs at consecutive MDIO addresses and
share configuration registers. Unaligned packages need an explicit base
address to select the correct package registers and per-port MDI fields.

Introduce realtek,rtl8224-package so the package example selects a
dedicated schema while child PHYs retain their Clause 45 discovery
compatible. Validate package and child properties, document that
unaligned layouts require a package node, and preserve support for
existing aligned descriptions without package nodes.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../bindings/net/realtek,rtl8224-package.yaml | 332 ++++++++++++++++++
 1 file changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml b/Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml
new file mode 100644
index 000000000000..8e6500958ed1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml
@@ -0,0 +1,332 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/realtek,rtl8224-package.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL8224 Ethernet PHY package
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+description:
+  The RTL8224 is a four-port 2.5Gbps Ethernet PHY. Its PHYs occupy four
+  consecutive MDIO addresses and share package-wide configuration registers.
+
+  A package node is required when the first PHY's MDIO address is not a
+  multiple of four. Existing aligned layouts without a package node remain
+  supported.
+
+  The package reg must identify the first physical PHY's MDIO address,
+  even if that PHY has no child node. Each child PHY reg is its absolute
+  MDIO address, not an offset from the package base. Unused PHY ports may
+  be omitted. The base address must not exceed 28, so that all four PHY
+  addresses fit within the MDIO address space.
+
+  The enet-phy-pair-order and enet-phy-pair-polarity properties belong
+  to the individual PHY nodes and describe each port's MDI wiring.
+
+$ref: ethernet-phy-package.yaml#
+
+properties:
+  compatible:
+    const: realtek,rtl8224-package
+
+  reg:
+    maximum: 28
+
+patternProperties:
+  "^ethernet-phy@[a-f0-9]+$":
+    $ref: ethernet-phy.yaml#
+
+    properties:
+      compatible:
+        const: ethernet-phy-ieee802.3-c45
+
+      leds: false
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+# Enumerate the ranges because child addresses depend on the package base.
+allOf:
+  - if:
+      properties:
+        reg: { const: 0 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 0, maximum: 3 }
+  - if:
+      properties:
+        reg: { const: 1 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 1, maximum: 4 }
+  - if:
+      properties:
+        reg: { const: 2 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 2, maximum: 5 }
+  - if:
+      properties:
+        reg: { const: 3 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 3, maximum: 6 }
+  - if:
+      properties:
+        reg: { const: 4 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 4, maximum: 7 }
+  - if:
+      properties:
+        reg: { const: 5 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 5, maximum: 8 }
+  - if:
+      properties:
+        reg: { const: 6 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 6, maximum: 9 }
+  - if:
+      properties:
+        reg: { const: 7 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 7, maximum: 10 }
+  - if:
+      properties:
+        reg: { const: 8 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 8, maximum: 11 }
+  - if:
+      properties:
+        reg: { const: 9 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 9, maximum: 12 }
+  - if:
+      properties:
+        reg: { const: 10 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 10, maximum: 13 }
+  - if:
+      properties:
+        reg: { const: 11 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 11, maximum: 14 }
+  - if:
+      properties:
+        reg: { const: 12 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 12, maximum: 15 }
+  - if:
+      properties:
+        reg: { const: 13 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 13, maximum: 16 }
+  - if:
+      properties:
+        reg: { const: 14 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 14, maximum: 17 }
+  - if:
+      properties:
+        reg: { const: 15 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 15, maximum: 18 }
+  - if:
+      properties:
+        reg: { const: 16 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 16, maximum: 19 }
+  - if:
+      properties:
+        reg: { const: 17 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 17, maximum: 20 }
+  - if:
+      properties:
+        reg: { const: 18 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 18, maximum: 21 }
+  - if:
+      properties:
+        reg: { const: 19 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 19, maximum: 22 }
+  - if:
+      properties:
+        reg: { const: 20 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 20, maximum: 23 }
+  - if:
+      properties:
+        reg: { const: 21 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 21, maximum: 24 }
+  - if:
+      properties:
+        reg: { const: 22 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 22, maximum: 25 }
+  - if:
+      properties:
+        reg: { const: 23 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 23, maximum: 26 }
+  - if:
+      properties:
+        reg: { const: 24 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 24, maximum: 27 }
+  - if:
+      properties:
+        reg: { const: 25 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 25, maximum: 28 }
+  - if:
+      properties:
+        reg: { const: 26 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 26, maximum: 29 }
+  - if:
+      properties:
+        reg: { const: 27 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 27, maximum: 30 }
+  - if:
+      properties:
+        reg: { const: 28 }
+    then:
+      patternProperties:
+        "^ethernet-phy@[a-f0-9]+$":
+          properties:
+            reg: { minimum: 28, maximum: 31 }
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@1 {
+            compatible = "realtek,rtl8224-package";
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@1 {
+                compatible = "ethernet-phy-ieee802.3-c45";
+                reg = <1>;
+                enet-phy-pair-order = <0>;
+            };
+
+            ethernet-phy@2 {
+                compatible = "ethernet-phy-ieee802.3-c45";
+                reg = <2>;
+                enet-phy-pair-order = <0>;
+            };
+
+            ethernet-phy@3 {
+                compatible = "ethernet-phy-ieee802.3-c45";
+                reg = <3>;
+                enet-phy-pair-order = <1>;
+            };
+
+            ethernet-phy@4 {
+                compatible = "ethernet-phy-ieee802.3-c45";
+                reg = <4>;
+                enet-phy-pair-order = <1>;
+                enet-phy-pair-polarity = <0x1>;
+            };
+        };
+    };
-- 
2.55.0

