Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0B320A04
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253748; cv=none; b=iR1QXE4TYEsCqpSsBBct96MQ6jNsKrWgv7KTjLDN1ikeHv1Qk4gW/8XTKTKY5AThzC+nazMajO30mtZ5+dzKZpOE+UpCSZMYfraq7Zjftc7IDsiYsIdnn4k9vc8cAGDHb5zIzad+bvDjm9bRghKYTJO0rBNikyjkwqsJ9CyNADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253748; c=relaxed/simple;
	bh=5Sm6KIJfhjcCGEhvCw+IXc43CVf5mJrLFBXr/fZhCvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc4hM4lma+MjuwMZVzUw/ujEP9DetTYQG8RvcqJyZ4y4ghG75JFghdkRp7o/ykQLGI67xfKNSd612t/TvBzY8bELbKp2XjpX6KMQncFACO+3VjoWDA54Xn9ttRGXvzgV7/3A5mf3gT2yVebJE3CB2HyDGqxeI0DhEySlRsh2YIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMxme+aW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMxme+aW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f904e80eeso17309f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253745; x=1785858545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PFKmpoYj/DOWR15QwgbvHgBV41qd6U9IB+q4KUeTZyY=;
        b=aMxme+aW4i0oCQaZ1Ay8rbKgSRkMBC6y44L4F9FMHETpdd26g1WynW0q6iASzzqk77
         q80Jc4Mb1D9Jsg4Opd1sXRiz9D41sH5/njsMVw75pXO3QUAgDCBXAgyLCw+fVzD53RTW
         laUdR/TXAXEmP2HmlBni9OLdyS0Me/QV1VXkEzCjk48mRFJSwuTNsICkcLcfv1X0y/L9
         SVbXt1Et9oJwsDWtRYEA5bSebMO4Y9VohXJpJ+xrD/BJ1ekSKsk+Bk3MG/VpIu35aGh/
         ArK+c9Y/xL/uVLr+79RoygcCrQKbOf2XxSZkorpM7lpixTC4442n/BKCVsCX4Y4KGrUJ
         3zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253745; x=1785858545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PFKmpoYj/DOWR15QwgbvHgBV41qd6U9IB+q4KUeTZyY=;
        b=TkTlEvZmasFXrPyWYVb5YBxrJG61nJzohtRBsY4GREv1qmxh6gcLH2Aer7sn2dhYHv
         i5sSVnBRRVuL1fi2l/6hBL5mnrJgJRBbXZ/xZae0smEc5amq/dh//lozCi9isUtP9/yj
         OOPumjFh/roXE1OVDxW3lUd/7XrLylmk3mAXsG32lmgx4cOPpvZnCd99TdT5SMyJkMj5
         Gom3rokiDKcCIc8ri9EzZEKrRPFm9BGEbQ5G1m0tHeWtjEHds6aNECy+BhCeX4aNFSaW
         9fsmYIJRFHsJQDUlhe5xHSE6o/2epSCLw3hEuy0MDWbiQr8xqRRXosZ92F/HX3sm6MD1
         VD6A==
X-Forwarded-Encrypted: i=1; AHgh+RoKMIAU/30zxnzpDhfpMyGwr76pNTW56yWn6zYr9YhO0Bb2Y/4yQBnJf2OU1hFex5H3t83QaDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJXRJ9HTzU+D9tAdRaIxa6uZrYnunU79dnm8cVaXQEZ1gcutS
	2+tQ2Vd1sdG8uQFfMpvRwidMdmZYq0iVY1wwDaUL9ex0vK9sdNnuriUU
X-Gm-Gg: AR+sD13YDCnFgBaIrE7fTdD2Fdy9PTQ2EMcb3RSQTF9Aq0G0IHbEDU3GdwdWuuhp77L
	LvxicdVNwO9TgaQoWC+oU2TACKrRZhnp+h3tEcZ/QK0uuuIhMQ0YuIAXVKrrgVtI8uY9JUfi+Ks
	s3l2TVwb3qU5o9OL3MdvRBq5czsCi0xlZcbxC7eqvI458xk3swV4eVlM71oBsQteXdaFq0JBnWl
	yNftKA7GyV6vZsh/AWqrq44bJG3N16QbSwgaqcDeLIdJKWgrPpU/clShHiN4NfIwgGYFkpzzM4A
	kASyEotjrDwG+LY4a+z3aRFNnJ4F4NPL8KRAVW5NP7R4qKYeTto4148QJ07riT4skBwLJlV+/eP
	k6gjDLFKnADhm9OPpgGnpLb04PvNwhF3wOQIJL7Cn82QpJIThI+UNQ2edMKSBluxBaVfDuuMxIL
	PoUANQALAbVjelyvLvTw==
X-Received: by 2002:a05:600c:3b85:b0:495:6936:120e with SMTP id 5b1f17b1804b1-496c65a5f06mr34662995e9.39.1785253744771;
        Tue, 28 Jul 2026 08:49:04 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([37.161.95.51])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm94912035e9.15.2026.07.28.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:49:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v19 01/10] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Tue, 28 Jul 2026 17:48:28 +0200
Message-ID: <20260728154846.1828945-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 5-port Gigabit Switch.

It does expose the 5 Internal PHYs on the MDIO bus and each port
can access the Switch register space by configuring the PHY page.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
new file mode 100644
index 000000000000..5ad9b9e13983
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Gigabit Switch
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch.
+
+  It does expose the 5 Internal PHYs on the MDIO bus and each port
+  can access the Switch register space by configuring the PHY page.
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: airoha,an8855-switch
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch {
+        compatible = "airoha,an8855-switch";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                label = "lan1";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy1>;
+            };
+
+            port@1 {
+                reg = <1>;
+                label = "lan2";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy2>;
+            };
+
+            port@2 {
+                reg = <2>;
+                label = "lan3";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy3>;
+            };
+
+            port@3 {
+                reg = <3>;
+                label = "lan4";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy4>;
+            };
+
+            port@4 {
+                reg = <4>;
+                label = "wan";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy5>;
+            };
+
+            port@5 {
+                reg = <5>;
+                label = "cpu";
+                ethernet = <&gmac0>;
+                phy-mode = "2500base-x";
+
+                fixed-link {
+                    speed = <2500>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
-- 
2.53.0

