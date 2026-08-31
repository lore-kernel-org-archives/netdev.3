Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74774403E9D;
	Mon, 31 Aug 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179807; cv=none; b=WdPOG9wDUm043EiZbJi6WUsTWH51Mol61xQDtB8QqqSdlkjmP75R4v2HM++7f2UrEunFG9TU+P582TwMMPIPfJqT5UaZuoEoaNR+bRMDe/58lLQy9T5y5wpQnbj0a9hRaieXPCK3ZL1LGZFQAF3S+Ihnc54NuNxlg1CCfaep6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179807; c=relaxed/simple;
	bh=bdJukBhr1M5ZvNC40bvKB9AlhQy3S0CS7qyrVuNKQ/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idcAbQg7T3QKrau5eF97hcIBz6S+05r0juIuhLTJhd4dinJXWHbhGixaLX5WVMgu2JJcjoYhK1G6caw+IQOOXMQuj8oVC6NLesetSMlSA5SFYrZ5ZOR/piw9IRdoTGDL8WeopCHe4koADhHAKjYvgjiP/xW3ItvFvTOIXn72Mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 437662020E6;
	Mon, 31 Aug 2026 14:36:38 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-004G6Y-0U;
	Mon, 31 Aug 2026 14:36:38 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-00000002nOD-0IQP;
	Mon, 31 Aug 2026 14:36:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 1/3] dt-bindings: net: dsa: realtek: add RTL8365MB power supplies
Date: Mon, 31 Aug 2026 14:36:35 +0200
Message-ID: <20260831123637.666457-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831123637.666457-1-o.rempel@pengutronix.de>
References: <20260831123637.666457-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RTL8365MB power rails as optional supplies. They are optional
because the rails are often always-on; some designs break them out for
granular hwmon monitoring and regulator control.

They are scoped to realtek,rtl8365mb: different Realtek switch families use
different power-rail naming schemes, so these rails do not apply to other
families such as realtek,rtl8366rb (VDDA/VDD_CORE/VDDIO/...).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Changes since v2:
- Move the *-supply properties to the top level; if:/then: now only forbids
  them on non-rtl8365mb compatibles (Krzysztof Kozlowski).
---
 .../devicetree/bindings/net/dsa/realtek.yaml  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 473facd87a62..b7bb60af623c 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -8,6 +8,20 @@ title: Realtek switches for unmanaged switches
 
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: realtek,rtl8365mb
+    then:
+      properties:
+        avddh-supply: false
+        avddl-supply: false
+        dvddio-supply: false
+        dvddio1-supply: false
+        dvddl-supply: false
+        pllvddl-supply: false
 
 maintainers:
   - Linus Walleij <linusw@kernel.org>
@@ -62,6 +76,24 @@ properties:
   resets:
     maxItems: 1
 
+  avddh-supply:
+    description: AVDDH high-voltage analog supply.
+
+  avddl-supply:
+    description: AVDDL low-voltage analog supply.
+
+  dvddio-supply:
+    description: DVDDIO digital I/O supply.
+
+  dvddio1-supply:
+    description: DVDDIO_1 secondary digital I/O supply for the RGMII bank.
+
+  dvddl-supply:
+    description: DVDDL digital core supply.
+
+  pllvddl-supply:
+    description: PLLVDDL PLL analog supply.
+
   realtek,disable-leds:
     type: boolean
     description: |
@@ -243,6 +275,7 @@ examples:
     platform {
             ethernet-switch {
                     compatible = "realtek,rtl8365mb";
+                    avddh-supply = <&avddh>;
                     mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
                     mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
                     reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
-- 
2.47.3

