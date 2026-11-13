Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529985;
	b=M/4UWWq1K01nk1QKJbfHaYDzBvMMGCLtCECYE2YokH+4bY2QKQviu8M6//scErU1vgAQ
	 mOspM31IbjdHEPynakx0kgOCaUoLXuilmScjDBjCmZ3v8Py5f4UXqrtG8JKkDaB7uH8Iw
	 s83SBPfV0Rl7m7bbI4iTqSRknNAsWm0+/LxS9C1gUdrqEcmvLSmLIOn38RQTZ0aJi+XuS
	 v0b8HPktK59TaAMMkXlgxjwHUEl83/3/gFLLRSK/IEWzOaGcikvOq+DbSOrsbCi3+iHA7
	 fkDBjgM8SaLPpnyh3ZXD/iwglfr+E8JlaOZC/3JZJKYlmjEL/lMiVKkdGJ/Icp9XaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZuODRaJ5G8FoGrxxTCkHxBbk35bvVff0bzp5O328+D0=;
	b=solCfIbQPXiRU3qOswGRfyJ7V74U3APjxjXSiAv4h7IiCozF5vHy8Z8/rXtBk2Tb0ARg
	 U5QjwF+656erwhyv7k6IR8sTMW8RGqnv71A32m8neJ76VgBS6CjXsYRrEkhRZVxMxCvYe
	 /cCyS+9rvkLPz9jmL3gcfuFKRwZpH+Kp89eadm+PjnB+YaIgLFjEk4Sr2wXvwliye1gt6
	 lKry1vQfZ99/PzjsISJtD8vGd82uyNmMl+EoVoRYCb5ghOb5MbOVhhmhW1NW3agPFBOTl
	 1peAgN3PhtUtQtmKFtutjY0Y33Qzb32rLgXk8P0ng13g2wLAP1DAdomf3govso8hMDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQBaXJwB;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49922606DE84
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49922606DE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQBaXJwB
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4918c2d727fso145516f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529983; x=1795134783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZuODRaJ5G8FoGrxxTCkHxBbk35bvVff0bzp5O328+D0=;
        b=AQBaXJwBIJ6fiHdt66fNrJIirwSCH29JoLbNJRhi2TUDAe+nuMwdc4ottEyFZt+vXH
         uYPVhqTq5iY3Hjoi3RL4J1wIidAzSJDVfoKJxSekDAW85pWnt9Iwcb2fFy0KKx+4l6+w
         cXu30FOXbstWPWuu24kUPsfFUWtzKE+21WN5dOhG93m3MobJJxpf2Ut/2SDivV50a/xG
         /0x0kl2fyJHa6OtNk6vkeSm9n2sm37o39GSo+2vruvEJKKt96zRSF7EZLOIrtjt3FTcE
         zuOjzPti/wOhToqWDRggnxgJeHc0+BB/ptE9M8Qr9vdNGbZQSoh5nJgDxP5e9/OA48Jv
         323Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529983; x=1795134783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZuODRaJ5G8FoGrxxTCkHxBbk35bvVff0bzp5O328+D0=;
        b=HA8O7RaLpizO8V8pHOw0KExhbrkVE/91GVhFK/wULNrKK16+9yEOC/wt+qHLB+H+Ju
         JZJpwQY6je8l7InLjdtYCgI8bHU30sxRS1pRAxcZ5RVVJSoI7shmNDrgrsCBgUk47EcM
         NOh6D2M8RlXf1wirJh2t6S+A/+gY98iZI7Vi7r4UyU6DOwxutqeam6KmOiEeD3CDFenO
         dmF+nMmiH9yekSSWReW+9xTbznYtEk0x3W6rNpDzuSQ6BWTqnHBKdwxjrIARGMl1E25h
         pkZ4OoFO88QcTEKHJtY6tGn0nyZ+jlf9RS6OadJX9luVQZPGEOEGKmbr/+v0Bl0XETPX
         IP9w==
X-Forwarded-Encrypted: i=1; AL+hErE5sSPJw7sBQTunK8/TzBwVe2Vh336IFUTMJD8Yj78UzrOqUqbpVVKH6O7W8xgv4XG9IgW6DOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b+BH2dGBGsuQJm5d8nbBB/W/rsovChxuND7UW+qKHf6BGymgl
	fjuxWh1hcRBrVzb+O3U0MYAHiB5keWEA/ceds9YjpA2XmbjQ63yCfbzr
X-Gm-Gg: AYBFou1+DWGFeHXzJzRO6m1EXRWtq7m+2GsqmyHHehnklFEWZdP/xHgu56DZZLu7Mv8
	Y7n8YdrAZlZ8IgtGLKr3CzD3kWjsV7pzV+M6KipJ0TXSSwGrDY+Gi5JMj89ITM2GyPwU5vVJadf
	E03J19l6viEQbcx2W8vssnAP/xTVVQjmjyAE/tGlhQsuD0zTF6bRhDfMmp6PeQHjvgosgE+44G8
	e2qXzP9pi3MqGasRIbefjhdjQf/jRvSHeum9JCc1kF6/iRq1DBV9dhIRbhK1Xf2W/03Y3lS3aSJ
	3dFVf1uAK5/L7n1Bnoc+ambn+rYLtqnUMazHeYtfK6z0C713llW+zgEFxclSGPvmP39pe3RCETN
	HZ/QDtjtHo5KIu2uo80uHxQzalnzi8v1ecTtrYatneoewb2io66KEnxZrfOti3BSNnw6pDLCvpU
	2lKTjLAYt1uavk7myjrCQ5jA2tYzHSeUjQNMOL/DffkZpEHKA84n4PHC7gj5XkAXX3uYchH+Pj0
	gJowuIsJ7iACUDw8o2DACgS/A/PN3xBFMlNK8AY2LcCCRUHbaMAmphz23mApmiJDmMRVPQqzYgW
	lEdQm+dBL/SX26iiP3oLdSlbm+ZvKm6Cslx9pyLw54K5yTMEwFYmtyNS4rWQvI92ebGdoL8abtT
	i+5X+iojV7rSJvgEHbK6LbtfpMMltN9HSDNfHQmZUlPwiU6xzKO4lfQ==
X-Received: by 2002:a05:6000:2386:b0:48e:5071:420 with SMTP id ffacd0b85a97d-49c6e4a38e3mr2558590f8f.2.1794529982576;
        Thu, 12 Nov 2026 16:33:02 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:33:01 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v19 13/15] dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
Date: Fri, 13 Nov 2026 01:32:03 +0100
Message-ID: <20261113003217.197757-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha Ethernet PCS for AN7581 SoC.

Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
the various Serdes port supporting different Media Independent Interface
(10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

This follow the new PCS provider with the use of #pcs-cells property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/pcs/airoha,pcs.yaml          | 261 ++++++++++++++++++
 1 file changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
new file mode 100644
index 000000000000..9c1d116c1b01
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
@@ -0,0 +1,261 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Ethernet PCS and Serdes
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
+  the various Serdes port supporting different Media Independent Interface
+  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
+
+properties:
+  compatible:
+    enum:
+      - airoha,an7581-pcs-eth
+      - airoha,an7581-pcs-pon
+      - airoha,an7581-pcs-pcie
+      - airoha,an7581-pcs-usb
+
+  reg:
+    minItems: 6
+    maxItems: 15
+
+  reg-names:
+    minItems: 6
+    maxItems: 15
+
+  airoha,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the SCU node required to configure
+      the serdes line to the correct interface mode.
+
+  phys:
+    maxItems: 1
+
+  "#pcs-cells": true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#pcs-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - airoha,an7581-pcs-eth
+              - airoha,an7581-pcs-pon
+
+    then:
+      properties:
+        reg:
+          items:
+            - description: PCS MAC reg
+            - description: HSGMII AN reg
+            - description: HSGMII PCS reg
+            - description: MULTI SGMII reg
+            - description: USXGMII reg
+            - description: HSGMII rate adaption reg
+            - description: PCS Analog register
+            - description: PCS PMA (Physical Medium Attachment) register
+
+        reg-names:
+          items:
+            - const: pcs_mac
+            - const: hsgmii_an
+            - const: hsgmii_pcs
+            - const: multi_sgmii
+            - const: usxgmii
+            - const: hsgmii_rate_adp
+            - const: pcs_ana
+            - const: pcs_pma
+
+        phys: false
+
+        "#pcs-cells":
+          const: 0
+
+      required:
+        - airoha,scu
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7581-pcs-pcie
+
+    then:
+      properties:
+        reg:
+          items:
+            - description: PCS MAC 0 reg
+            - description: HSGMII AN 0 reg
+            - description: HSGMII PCS 0 reg
+            - description: MULTI SGMII 0 reg
+            - description: USXGMII 0 reg
+            - description: HSGMII rate adaption 0 reg
+            - description: PCS MAC 1 reg
+            - description: HSGMII AN 1 reg
+            - description: HSGMII PCS 1 reg
+            - description: MULTI SGMII 1 reg
+            - description: USXGMII 1 reg
+            - description: HSGMII rate adaption 1 reg
+            - description: PCS Analog register
+            - description: PCS PMA (Physical Medium Attachment) 0 register
+            - description: PCS PMA (Physical Medium Attachment) 1 register
+
+        reg-names:
+          items:
+            - const: pcs_mac0
+            - const: hsgmii_an0
+            - const: hsgmii_pcs0
+            - const: multi_sgmii0
+            - const: usxgmii0
+            - const: hsgmii_rate_adp0
+            - const: pcs_mac1
+            - const: hsgmii_an1
+            - const: hsgmii_pcs1
+            - const: multi_sgmii1
+            - const: usxgmii1
+            - const: hsgmii_rate_adp1
+            - const: pcs_ana
+            - const: pcs_pma0
+            - const: pcs_pma1
+
+        phys: false
+
+        "#pcs-cells":
+          const: 1
+
+      required:
+        - airoha,scu
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7581-pcs-usb
+
+    then:
+      properties:
+        reg:
+          items:
+            - description: PCS MAC reg
+            - description: HSGMII AN reg
+            - description: HSGMII PCS reg
+            - description: MULTI SGMII reg
+            - description: HSGMII rate adaption reg
+            - description: PCS Analog register
+
+        reg-names:
+          items:
+            - const: pcs_mac
+            - const: hsgmii_an
+            - const: hsgmii_pcs
+            - const: multi_sgmii
+            - const: hsgmii_rate_adp
+            - const: pcs_ana
+
+        airoha,scu: false
+
+        "#pcs-cells":
+          const: 0
+
+      required:
+        - phys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+
+    pcs@1fa08000 {
+      compatible = "airoha,an7581-pcs-pon";
+      reg = <0x1fa08000 0x1000>,
+            <0x1fa80000 0x60>,
+            <0x1fa80a00 0x164>,
+            <0x1fa84000 0x450>,
+            <0x1fa85900 0x338>,
+            <0x1fa86000 0x300>,
+            <0x1fa8a000 0x1000>,
+            <0x1fa8b000 0x1000>;
+      reg-names = "pcs_mac", "hsgmii_an", "hsgmii_pcs",
+                  "multi_sgmii", "usxgmii",
+                  "hsgmii_rate_adp", "pcs_ana", "pcs_pma";
+
+      airoha,scu = <&scuclk>;
+      #pcs-cells = <0>;
+    };
+
+    pcs@1fa09000 {
+      compatible = "airoha,an7581-pcs-eth";
+      reg = <0x1fa09000 0x1000>,
+            <0x1fa70000 0x60>,
+            <0x1fa70a00 0x164>,
+            <0x1fa74000 0x450>,
+            <0x1fa75900 0x338>,
+            <0x1fa76000 0x300>,
+            <0x1fa7a000 0x1000>,
+            <0x1fa7b000 0x1000>;
+      reg-names = "pcs_mac", "hsgmii_an", "hsgmii_pcs",
+                  "multi_sgmii", "usxgmii",
+                  "hsgmii_rate_adp", "pcs_ana", "pcs_pma";
+
+      airoha,scu = <&scuclk>;
+      #pcs-cells = <0>;
+    };
+
+    pcs@1fa04000 {
+      compatible = "airoha,an7581-pcs-pcie";
+      reg = <0x1fa04000 0x1000>,
+            <0x1fa50000 0x60>,
+            <0x1fa50a00 0x164>,
+            <0x1fa54000 0x450>,
+            <0x1fa55900 0x338>,
+            <0x1fa56000 0x300>,
+            <0x1fa05000 0x1000>,
+            <0x1fa60000 0x60>,
+            <0x1fa60a00 0x164>,
+            <0x1fa64000 0x450>,
+            <0x1fa65900 0x338>,
+            <0x1fa66000 0x300>,
+            <0x1fa5a000 0x1000>,
+            <0x1fa5b000 0x1000>,
+            <0x1fa5c000 0x1000>;
+      reg-names = "pcs_mac0", "hsgmii_an0", "hsgmii_pcs0",
+                  "multi_sgmii0", "usxgmii0",
+                  "hsgmii_rate_adp0",
+                  "pcs_mac1", "hsgmii_an1", "hsgmii_pcs1",
+                  "multi_sgmii1", "usxgmii1",
+                  "hsgmii_rate_adp1",
+                  "pcs_ana", "pcs_pma0", "pcs_pma1";
+
+      airoha,scu = <&scuclk>;
+      #pcs-cells = <1>;
+    };
+
+    pcs@1fa07000 {
+      compatible = "airoha,an7581-pcs-usb";
+      reg = <0x1fa07000 0x1000>,
+            <0x1fa90000 0x60>,
+            <0x1fa90a00 0x164>,
+            <0x1fa94000 0x450>,
+            <0x1fa96000 0x300>,
+            <0x1fa9a000 0x600>;
+      reg-names = "pcs_mac", "hsgmii_an", "hsgmii_pcs",
+                  "multi_sgmii", "hsgmii_rate_adp","pcs_ana";
+
+      phys = <&usb0_phy PHY_TYPE_USB3>;
+
+      #pcs-cells = <0>;
+    };
-- 
2.55.0

