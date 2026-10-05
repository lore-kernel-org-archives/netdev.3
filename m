Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E837DEA9;
	Mon,  5 Oct 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231824; cv=none; b=JltxU/SnODZVi5BN40yvESJyMZyjycsNxEYmcJoO7VH0cshaF6axUzKRxDosNOLQU4mpoOrSzgM5jhws2u1YJ7icpPInsREwtNJmru5NfzXtIw2q9L7vW6aB2A8s7EXY/NpmT5jnOZ8ofFImgT/ByBi7JiyaLsUlPFpUUvCpSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231824; c=relaxed/simple;
	bh=BfLp03nu9ct8jrcUbvmUBEEEJBQTVX2odIjNc3zNLHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjG7Qqap0NOnrXFw8UTPK7eu9ba8yNRKqK8u1mkWC/3vk0LQkSnQYzXgW+cGZ47x+//5oULRNUASTPNr5v8ZQJeoYSPVbmx290mLgZ1OjGVub3FD569VZGQG1B+A5MaTT9hKVYrr4HU0bhTamCs+YX+vZXmaPh5LKtFeXaAnpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id C94EE20F09;
	Mon,  5 Oct 2026 20:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id wv8O2vxUrYQe; Mon,  5 Oct 2026 20:17:23 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id 864BA1FD40;
	Mon,  5 Oct 2026 20:17:22 +0000 (UTC)
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
	Javen Xu <javen_xu@realsil.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
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
	Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: realtek,rtl82xx: document RTL8224 packages
Date: Mon,  5 Oct 2026 23:15:39 +0300
Message-ID: <20261005201540.913977-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005201540.913977-1-oskari@lemmela.net>
References: <20261005201540.913977-1-oskari@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL8224 packages contain four PHYs at consecutive MDIO addresses,
but the first address need not be a multiple of four. Document how
to describe these packages using the existing ethernet-phy-package
binding so their base address is explicit.

Clarify that child PHY addresses are absolute and that MDI pair
order and polarity properties describe the individual ports. Add
an example with a package starting at address 1.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../bindings/net/realtek,rtl82xx.yaml         | 52 +++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 07b39ef1fc62..ca52c3ae19f7 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -12,7 +12,17 @@ maintainers:
   - Heiner Kallweit <hkallweit1@gmail.com>
 
 description:
-  Bindings for Realtek RTL82xx PHYs
+  Bindings for Realtek RTL82xx PHYs.
+
+  The RTL8224 contains four PHYs at consecutive MDIO addresses. Its PHY
+  nodes may be grouped under an ethernet-phy-package node as described
+  in ethernet-phy-package.yaml. The package reg must identify the first
+  PHY's MDIO address, even if that PHY has no child node. This address
+  need not be a multiple of four. Each child PHY reg is its absolute
+  MDIO address, not an offset from the package base.
+
+  The enet-phy-pair-order and enet-phy-pair-polarity properties belong
+  to the individual PHY nodes and describe each port's MDI wiring.
 
 properties:
   compatible:
@@ -90,9 +100,45 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        ethphy1: ethernet-phy@1 {
+        ethernet-phy@1 {
             reg = <1>;
-            realtek,clkout-disable;
             realtek,aldps-enable;
+            realtek,clkout-disable;
+        };
+    };
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@1 {
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
         };
     };
-- 
2.55.0

