Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583843B3D9;
	Tue, 11 Aug 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448355; cv=none; b=GVA5iCS0UodMiMJQPkySZUOjE1t9ddS+e1ytMM4yjFJ2FqLv1C53BZrm0Yl/OMj8pew4AbENo3mHB9j6l2/EGgLY1q8uXK2d1VUKjIpSbLCwgJWpwMFtd7uve+yUH23Ibiv4TfV3+YrusYUav8yg+gFA/8J+foIN+IRALD3481w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448355; c=relaxed/simple;
	bh=p8QWfHslY7XIMR7yvAPX/HnHz792kp4htHAIpaO8y2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfVmES4BolJNRuhXmsKwjwVBHXJVOzC512GzWLuoBoiLuOrtXqSllmBEDkS91SvgNsYe1ksWamTY/nfOuQlGLymmj7gXWRBWKtJno43nWhG8SnU6vc51xCY4s0OXAzdQKxDXlf4wZMn1NNzVF9wWncfz07DdL9sTbMvi6XYdh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 27E3E201B51;
	Tue, 11 Aug 2026 13:39:03 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wtkox-000wTA-09;
	Tue, 11 Aug 2026 13:39:03 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wtkow-0000000D49K-4185;
	Tue, 11 Aug 2026 13:39:02 +0200
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
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dsa: realtek: add RTL8365MB power supplies
Date: Tue, 11 Aug 2026 13:39:00 +0200
Message-ID: <20260811113901.3114169-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811113901.3114169-1-o.rempel@pengutronix.de>
References: <20260811113901.3114169-1-o.rempel@pengutronix.de>
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
---
 .../devicetree/bindings/net/dsa/realtek.yaml  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 473facd87a62..98ea6072bd96 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -8,6 +8,30 @@ title: Realtek switches for unmanaged switches
 
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: realtek,rtl8365mb
+    then:
+      properties:
+        avddh-supply:
+          description: AVDDH high-voltage analog supply.
+
+        avddl-supply:
+          description: AVDDL low-voltage analog supply.
+
+        dvddio-supply:
+          description: DVDDIO digital I/O supply.
+
+        dvddio1-supply:
+          description: DVDDIO_1 secondary digital I/O supply for the RGMII bank.
+
+        dvddl-supply:
+          description: DVDDL digital core supply.
+
+        pllvddl-supply:
+          description: PLLVDDL PLL analog supply.
 
 maintainers:
   - Linus Walleij <linusw@kernel.org>
@@ -243,6 +267,7 @@ examples:
     platform {
             ethernet-switch {
                     compatible = "realtek,rtl8365mb";
+                    avddh-supply = <&avddh>;
                     mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
                     mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
                     reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
-- 
2.47.3

