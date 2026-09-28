Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15294F405C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624758; cv=none; b=icalcCZIaeIh1ytBkTJNSjmamKfgXg/PFgP1Uo9zDhSAUXymJk/2mxvG0knxYe/p3cZyrpNKpOXDm34YGS9Ryozy63eK3dyJBZtKF1D2YEdzJYdMu8mWdlp9buNpKAzXl/WCX5eyek9bofkG04vU7I1AN98wJWD8jUdR3H8zdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624758; c=relaxed/simple;
	bh=eGGtJucMub/H5IDPYhp85xFBOadbNNPXVb/tk0RokT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h228Ii35cZzLXTKTPStQwbaSkB3SztOfs40bHTpTK2Zo79VpwXtEwXX4dsfr1HVMGCytetQB+3HGZmvz/pdVeKliXQZ/GYdumXziX191oG772XT1fvoXvvmb1ohE86v25Fwpepiym7IOCSUs6i6Crix24da4qSeJYVA56Bu/RUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUSodHcn; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUSodHcn"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so2588380f8f.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790624755; x=1791229555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sGFrWQujhzJh9uPF6notnBiKMTrdwWirz/MP50Av2KE=;
        b=VUSodHcncvOyo+vSbAMjoM4QCFS7HWvTAQhxBtD06zZTCiGmjML3GiWJTuQKHkLATM
         8GTD0fwxUXAo5S5py1FogWBFah9RT4fVa3VlzwCedtn3o/ycZTAXgpxT5rBhhR5hH93q
         GHG2YytaUBxEsyW/UticOkpr/2FU9mf6yIXsGbqH1QPSNLKEjKkkNtFsvUNzAkPdAupm
         gTEffTMTeKMlG8NSHRcH6Wshue6GOCPduQResboF0Bk3m4zYru8OfG5ueio9y68kl9jr
         sMA+4OQdr02xWNiR6QtuyAsPIywwkyIgl1WnYJqoU0kjr0wLFU0xH97W/RDwnVGUWeDf
         QHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624755; x=1791229555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sGFrWQujhzJh9uPF6notnBiKMTrdwWirz/MP50Av2KE=;
        b=w+FT9owvFfNDSygg8HBUAWlXupzWjiRFSQI7ffeI+butaTu17l4IgDDp4JvZuXbaY5
         /cj/pdfVp3RBUEjQY07nwODGS5JqoJzQ4VHKZAyJPuXSbUIE0XSrniIvzDIdgYhWVgl/
         9iqQaxvsDP+4xLj4xdc0M90U22QzXLrFGklsgvWGq5D18Pl2/+duTLCvMcla3c0H6EXz
         uFkYHHOCi58rm4xv8n624MXGesZCsg7RPjPsa7GacZn5G3AFgpUD1NEWt/wh5iBOpHHN
         l35Vvu0lzHwguE9NguUyN0+EmOaVQaLKS2Qx9+oiStn5L4tzf0QsvtRj/vV3wiGcRceE
         Cemw==
X-Forwarded-Encrypted: i=1; AKwUvBxB0TTGujSbX+1Asu7t4P6o+ibJrZM6hbYNU9+IA5fMI9AVKDLOaUgMk4HN0VZR5Pu5RHMJ7o8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5WhFIsRyU8oTWaMPpJzhlZDFRpu1+BeaDWQXagwaW/yanh23S
	AUM9PV+vje5vfB95jJRVXzoiSym/inAWkFuw5TpAwyt7bafrQOsnIHmZ
X-Gm-Gg: AYBFou3OHkW0ltVBscLtY5WllxwaUQbft7OnHVmu7GUin4jYRd48Sh5jpswS1m+FN3Y
	LkZ3vSGEGqSN0bj6NYa9TEJ+mNhNfvBXLLzY1+WQDyvjCmik4+jEhVyF4+jLecvgeW2fgF/KrG6
	SfKfbuSYnF5hgEn8s/CmMmxsn8lqbzuhOnolMj8pd0tTPLigM/KqHQaRQhogvzv+86geqBHAcaV
	FzASOjVBPS6nqStKX5IpVELxbvvvmafIhzaA5NF2KFcfModjPKbvChyhboMNpxFg991fj1eg7Yg
	z13duEQTKFDfT5Tb9gePxAvGzQHeP00ORL+8YxubZZofh3XDsFW+CRu6mrqQm+ZCFVXu6J1eYN6
	KqRgZeGAaIprSRc5SeogGFeXym4LtV3HCFwpUgnuWXAZh4vXC56G8xna/5RDclxVav0ocO7CCFG
	93QXzeLf1EBSl6GIisynxm9ZtU8x14pQM7wljy12iQzq6Nq/q7YWl3nDHn4yV2h+dMqwdpWCk2j
	eEqtVX2mZqIWGfmujyIPt2R8fdm8yL8n4dMNljPvB9OiIqEJUFOjpIyl640GA3a
X-Received: by 2002:a5d:5f49:0:b0:48a:f1fb:e165 with SMTP id ffacd0b85a97d-48af1fbe9demr313504f8f.21.1790624754940;
        Mon, 28 Sep 2026 12:45:54 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48af071532dsm1527706f8f.20.2026.09.28.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:45:54 -0700 (PDT)
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
	Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v24 01/10] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Mon, 28 Sep 2026 21:45:00 +0200
Message-ID: <20260928194511.41878-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928194511.41878-1-ansuelsmth@gmail.com>
References: <20260928194511.41878-1-ansuelsmth@gmail.com>
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
2.55.0

