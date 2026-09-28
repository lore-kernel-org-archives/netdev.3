Received: from mail-wr2-f22.google.com (mail-wr2-f22.google.com [74.125.225.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCD4F6474
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624761; cv=none; b=f6KeGe5DlJ6IGjUzonMkG3UxfqANdmrfiug3xT05Anuu/nvhBQUCICmmJPmDme9KUIY4L7NErQ5yAD6mhkHKAtU0QZBuSCHHkG4G0NDVgZKRKWL9p9Qrbt5YmestELDN/wU94bwBixW7vUZoYDkp0wCcSTKzwZmIwnsTkuMhTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624761; c=relaxed/simple;
	bh=/IYRt7m1hBhlgCk4AnhppCirk0sLdTYFTGd86B/RQ+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFDgAKNJHBQ3nxZvE1Qu2RySeQacNp3Of1gcJQ9O1NqNhbPMJNP3GN39IvR3IDeDCg4BdKrZAArycPWf/aQwaG61oGvIrvNPUepO3D6iX/6IDJsQ/FKY0MTKYyvguYq3ROoKgNuGXV4SM2ljzfbl6OsTsZkEQP/knKFoZHmX4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seYqIv6T; arc=none smtp.client-ip=74.125.225.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seYqIv6T"
Received: by mail-wr2-f22.google.com with SMTP id ffacd0b85a97d-4887d06c669so2653777f8f.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790624757; x=1791229557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZXcrD1S7/I6W/aF1UhtK1+p0qebXOrwfnsiC5xoqRI=;
        b=seYqIv6T85/OaRPHYw+SaLhFK9aad2/4460S2d44hD/igO+JHWU7Pvk6aaZegAeHlC
         G62W/fq4N1wJPkzLR3i2aF8gp8mPz2kDmB2m6J3PHc3d/AcB1bPzvRsh9Ci0yU6ziB8/
         FTaXejwpqNT6wR1Wx8IMHgY3mczuZUnQ5OTMUPe8USupKjE0WypsP+F04aCemPcqgj/m
         yAGpA+wubclQjI8+O+fUvg46EvjRMaUrYsAzVhQos/+6thYHZdcoKGtw1V23APwFGTOn
         0eFgrt4oZ1J+dLKzTEuaIBX2m9q7Aq10XelOmk3P1AFqAkkwiuEszAihwMMIWeAwhwn1
         MBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624757; x=1791229557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RZXcrD1S7/I6W/aF1UhtK1+p0qebXOrwfnsiC5xoqRI=;
        b=aFaGjDin1yspCF0pcR8nL+Sfjb37dMF5V/hS3YLvTBfIhkSr3zoozt6MBxcWI0opQu
         sCzmQkvSt2RBtAzJcH+uGGOWZYu7F+1thp25sPnqGE1VRpzS1HLSKd8NbciGDzyDvGAw
         R0Z2y4KyhOUK/H8OYMSb25Yi8J2q0bCTc3X+ajzIqNz02yhro12E7lU0uqa9QgXS4Uwc
         ToJrP8nfZ3+DkXktv9f5ETyljm+afpY9S3ChGH8wXlTRzU/5yyXgmirmszJOReM1cwVC
         tyjVqs5S7im7wR1FcrKR1CNNHbXgZpGu0MDp1EPMCaNmWEGb8iSFgxIL4H02rZrxaEpD
         4Vnw==
X-Forwarded-Encrypted: i=1; AKwUvBwGKIWed5Cc4Za1U7gLSOmmMkwudjPlx6eRZaZq850oN9DHYrDny+Kor3y9PbbeD8RhObeD+54=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW7B1fZFHP7MakZN+yRJVUZoMFbv/N0vPoqhXasPvdpB2O5KJN
	zEVoWRiE45BSGr2PefEkW3pUjL5nolGpU2V+/WVr2DgiEuO/HrH93etO
X-Gm-Gg: AYBFou0pUUq76zM30qc7xc60eoagIz1bwIdcKR6TsIeTNOpoDBPA7fWZgZwVDEZO6D6
	B3r7NanGTMw++1KpgOpnOIWZVE2tC7EoBISaN7GaKQyDCj35McjW6/9pGfaxUTOPGYxPkqDdiWn
	/l9QgHcSzTBr91lRroTItvY7F1pLIOD8RVYV6wAGC32E2zUrIBuRhWXWvfyOt/p4aaiXGetmaAP
	gpW8/AfOlA1jgaa1SxxvKzEX3Y2wmJltB5subQem+12F914NG1aoGK+uyBm0TMih/Q40oveBBxK
	XI8LLk/cDSRYbfBxTNJZ2pf4oz7y53tC58aCDkjvFNpStF0wVMP6nP3Ez5gVWrNw+rm3AsStz/f
	K2lPp+uQMie33th/n35m+FTvxL1SgmU4dpVy9qG2jYGBYbXnbe0l8t5qNRPSIy0OwKY1WcuPkB3
	sT7zSCx9C1rfJwDrrPl441FdmP5/YChKnS55OI0vIUWt5EXOBjczxcwNAP/HdR/DBP8oFP9NPch
	L9vacvPu/eWBOoPKp/As1yZCSHbuf0MjNJQFgsHXsBD1jI9eIGgDv5CelTlxb+a
X-Received: by 2002:adf:e188:0:b0:486:f980:2361 with SMTP id ffacd0b85a97d-48872ac750cmr24124073f8f.45.1790624757303;
        Mon, 28 Sep 2026 12:45:57 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-82-57-191-234.retail.telecomitalia.it. [82.57.191.234])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48af071532dsm1527706f8f.20.2026.09.28.12.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:45:56 -0700 (PDT)
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
Subject: [PATCH net-next v24 02/10] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Mon, 28 Sep 2026 21:45:01 +0200
Message-ID: <20260928194511.41878-3-ansuelsmth@gmail.com>
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

Document support for AN8855 Switch Internal PHY.

Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
PHYs on the MDIO bus.

Each PHY might need to be calibrated to correctly work with the
use of the eFUSE provided by the Switch SoC. This can be enabled by
defining in the PHY node the NVMEM cell properties.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
new file mode 100644
index 000000000000..d2f86116badf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch Internal PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
+  PHYs on the MDIO bus.
+
+  Each PHY might need to be calibrated to correctly work with the
+  use of the eFUSE provided by the Switch SoC.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-idc0ff.0410
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: phandle to SoC eFUSE tx_a
+      - description: phandle to SoC eFUSE tx_b
+      - description: phandle to SoC eFUSE tx_c
+      - description: phandle to SoC eFUSE tx_d
+
+  nvmem-cell-names:
+    items:
+      - const: tx_a
+      - const: tx_b
+      - const: tx_c
+      - const: tx_d
+
+required:
+  - compatible
+  - reg
+
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
+        };
+
+        ethernet-phy@2 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <2>;
+
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                          <&shift_sel_port0_tx_b>,
+                          <&shift_sel_port0_tx_c>,
+                          <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
-- 
2.55.0

