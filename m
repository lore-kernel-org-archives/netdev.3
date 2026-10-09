Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB04E1404
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562279; cv=none; b=mP9JnLpQhXXsfVMqzU5z5sqgMi2NefAIQzGBgxfVBfFJLIq1WD2G7Y1tDLaxn1a5q1LvA/ArbHO3J6WvZF6uCAUXhsVWPelSkNt+uK3DfzO2Lapp/9CcqvhRRDN5qP0O9t260f6lUfFn51IfU2DThJ9u4gsn2f4lSytZGx2XaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562279; c=relaxed/simple;
	bh=/IYRt7m1hBhlgCk4AnhppCirk0sLdTYFTGd86B/RQ+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlWuHT8dvI4Zi/Jp3gWcnKuzT+0kDA84MB2x2MaXRSB7ww82IEf3CylojF551GsxpTKSVFTX7Hvk13i2b5q+7LN6SOy9IXVEUPb6C+KXPR2LpR/SQEDD6W31Fp36HnX2znVSgVF498GRaGxDmAPDOZXwaJdBwkoECnBTV9Gxa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVFMsxLY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVFMsxLY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so5686476f8f.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562275; x=1792167075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZXcrD1S7/I6W/aF1UhtK1+p0qebXOrwfnsiC5xoqRI=;
        b=LVFMsxLYM0PzWSpOwy6JNiv0PMz05vk7m++G+/r3XMJKABJkzrNG4uEvk9ad9ajwK4
         FLTkpARMIkCXw7e4i1rvqWYo3GQKfjLMGPEB1mo6qeyvQ+LTJGRfOxcdCLNG1eW06cnO
         TjLlDx4NDAmbjqqHAfaz+zG8u0SM0ZQVdPVWoGfs6mvJH53ueVdhwVQeVbHLCWiAIa87
         DpGqEJ8JBc96S2my+s6DE6paz/Q/PEUrxYm6RPxnTElzVMjkQRYXbQlfjqZfHrUFY2o0
         zYxvQTt8KnxGFSkxi6wMmdcsB2DdFKCXKbB+f2A1lY8xd2E6I4oU829G3BD8wNbaj2Yg
         WnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562275; x=1792167075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RZXcrD1S7/I6W/aF1UhtK1+p0qebXOrwfnsiC5xoqRI=;
        b=iLo7RAr0wzJ78k0F+99fQPiJoD0Vlrt9xjXSpIzo1dwL3g8bVAr90LU83RDRbl7MZG
         avtWLutoVARiIJ2NP7wQVfxjCPgSCNtjaFTfFRDRU6a4mXNZlCXZxh07T46p1UrmMtUo
         M+PiLmtQ6lVBb59PFbtg+trfd/iOZu+1T2qyFln9YynD2Ft40Lec3eyV5xaSiqVf6IHD
         vQ/S+X0uQIO5X6gA8NkY+eaFAB3dyT9rcv13Dri5TzzabON7mJH3Zv6z/D0aFj+bo9nt
         havTRdEiSTrlEK6laCItRhoc6EZPVbtYnb9DMKwWWbrRwArQ1+0XbEdbDaITzO9mBjuq
         XNWw==
X-Forwarded-Encrypted: i=1; AKwUvBy8X2AiVomrufSs6Da5d3nE++JlCHLaQBcO/wZsI81PH2zejA17RyIOuPyV+wYwgIwnjCbFPSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k7y3Op2rpcapBc0nFiOrx5G9T7+r5BNWmokoe4wSi3Xumz05Zh
	i5JDuDGBn8/mNQqyTS0i63iGEWM35tFN2nBUmuHdgNjIwa5Dw1HVDuP3
X-Gm-Gg: AYBFou0I8t2/5D+FmGqujftuqdJQRbCx0zABngcIpj9H1dQMUIH3iYM9smnAWOKoWPO
	qWZ22oqCwqD7JZbP2bf7ZQ8osTI0tjT28MyqjElLVM2arYKS6LJO6r0rrT/N2Fq6/dWJHlScBGM
	j2cssk3fbpzagHFoLiCYSfZTZdJT4hC1T2KpHaKWsHHYAAwub8PzVEiuWsjz05GvB6bWjvD27Ew
	mSmrcCC6BtJP/F3UsI94nAAPMr+irqqUgQZquAaA5pfz7tt4H1wm6OOy2lCh2fTxTErjBQuhPgC
	UzwTZTVh22ABIRwoHqPOgWv6VAXu9QVqv5Ss+EASSkoW1HFGuwBImZZCnsOU6hzMtj9Z5VomF3Q
	HYQjtlDtM4hH01+WfJ8KcziHDQH9rSz1KGtzfje55HJ2mkC/S5sTOL6IJh/tEIL5ZmUe13DoWzS
	eX9uecH0xwB1OKnvY5NgzonxtcYSBCGReso0yot4gLAxjjJgHKRURFT/KsQdmKsuY3DB4O3/q2h
	5i6RjO1ELndcPQv0t1T7bnuPe+uUzjUZNPHOII8qJH99Vv4A4CelLvLPwYtxl+gi8Y8bYE18PYx
	6iaeBwpjEbyYjWcHUA==
X-Received: by 2002:a05:600c:37cc:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a18e44396cmr51955465e9.2.1791562274820;
        Fri, 09 Oct 2026 09:11:14 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
Subject: [PATCH net-next v25 02/10] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Fri,  9 Oct 2026 18:10:47 +0200
Message-ID: <20261009161102.38961-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161102.38961-1-ansuelsmth@gmail.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
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

