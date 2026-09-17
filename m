Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881A3D9DAA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678067; cv=none; b=foRzNwRxvlEH4Z4qInRKhfCkxCCUNAC4PBdS1q0giRu5ln2MMGHqFeQBjruAPq9+rcniou7zMi01UsBQIvxFGHp9qniPkQJ76JKGBtQ7yo65r1b8O8cmja9HejijUg4PYQl1TcVseg8TFs9TgeK7gjioLBS0X0ATgVAha56oFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678067; c=relaxed/simple;
	bh=uIxFaIx1maUJPzb10cLtB0jKa27JO2f3e4ujLzs23xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZC26QP/idIPH24ykl47CD+C58md0K6zYCj2nKxz9+UHa0BS8aBy1UbGfkWIr9ZkvKNVIQDW//yQlVagyG1dYsNt7MZu3cHhE557mMWhob4CwQu5l6jucwQX0kwaXNW4iyDsTFOA01jvuG6hiL+IJnjsABa5ULbP71HsCB61t+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIQLw9zG; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIQLw9zG"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e4b1e7d12so128669a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678063; x=1790282863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzUxf96lJcOF3iW8gS5QIxqqy13/2PJtTrFNEXc29ug=;
        b=RIQLw9zGVsnFAHI7h8DYnEJ1bbaDqkuaEfMObx2/uWPj1JwvbwfDtEu5gUCA/Z2khT
         x4CdutdbiT9ljel9GXfarQIz29JQHsGY2fHOEtLWZ/OVn6hTw8GzusjayeAcSSmZIfSL
         Jz4JxsvTfpWNd7jaAseojIcambakYsNk1amzKPqrzU9KGmMepBx9GO/IsQVSchj9nTdg
         sO7Sprd8x7+waK2e2SVyaCseaMaK1zfAa1KpYyHYcCS++vY5sgzfxwqo6qhYOtTyZwzC
         xZnaOTVSKOPeaAtIuv8JvGFliZ1S7NzXCwGZ0OdgXF9/UNt3/mPCt7UUU9J99/JTw8fY
         0b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678063; x=1790282863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzUxf96lJcOF3iW8gS5QIxqqy13/2PJtTrFNEXc29ug=;
        b=b/+rfvaGqIc/bcoFNqSzyPpCdDfuv1UKiQYy3MzuyVhSb0PFHGUnLwVHfZg2vrThx/
         t7k2sS7I3Zr9DEetmgJ65BUncPBWEzYm/L6zp7BOFzr7Irfa0tvzllfB3nLJJk5UQLG+
         D4Umj4ut+w7VrQ0HjbYbuQz1ht+8LhHcoCofm+VN7fPa/oXW6xKJH6iM0J0gGjb5IWNZ
         4xclpoa2VFdbqLI2UmwCulh6kY5y0snfx57kWwy2cPs3qHqKkixfQGMAEwxe+XbKV907
         a32x3a+uw5RPyOG93and9VK4zJmdDVMjiYR4qFLoG6qgTeD/dHHXhD/qhhR6GTPbe9eM
         IJmw==
X-Forwarded-Encrypted: i=1; AKwUvByxBNR7CtOtS54mOD3sXVhXqiPkDGfe5PjwUolbfptWc/qrWXAB83j8QRb0hj1DU8C8JJSiOXk=@vger.kernel.org
X-Gm-Message-State: AFuF++kcsi3wv8T0rdpvHfGrhoGSH4VxdSQQ8wTZGfNMEmaLfdDNX7cv
	pDfrCOCTHaON7mFyRegUKd+of4j0bPDdxjVQ5+FNxgCPnOBF7sjfGpCx
X-Gm-Gg: AYBFou1l9UWrYeMWYuokKjH+i9YtTLlhfG6LctR4z0Fh3n2Czc2ziSWlRmWIdoVPGi4
	akRe/PuKi1iEpKoMXNdi59y53yrzy/DgHRRGTkJovYC+UP8oCBvSKQJKc1S1he7fQc8NuU2kq+J
	8TV+9Unb+N2i1A0NGD6T1+1Q9Jee8Dp/s+5Jm/midjwEwlY+SYUuO6vRI/Kvc2y7R7US6WTaWOA
	M+8ywx9adNnjdkCxxytOSHdotaBEmlMtOADELOO5qJmZJIIVlNBfp3dhudE697VEDIe4uXR6qR/
	zcIkppZLqbriMGjB8R4K79WVv7bm8WC3CZS8FLnFyywizRou9iip/5iFs4LKeR/VWcQ2ooboQBg
	YOIcN55fMMzeHklcth700eB8JINQDY4XO15FBew8cpKdVpQndrzortO3Bf9hFyzk9UhyBp77RjV
	aqO3OhHe8/U9pS54CKmoUjkD3X3v7UfjLg5s27eu+715/PPM/Iat9Z/ilJFWDKIuyiS5G1ofU=
X-Received: by 2002:a17:90b:224a:b0:39e:4c81:6c99 with SMTP id 98e67ed59e1d1-39e54fa5deamr672836a91.31.1789678062912;
        Thu, 17 Sep 2026 13:47:42 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1232196a91.17.2026.09.17.13.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:47:41 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v7 04/11] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
Date: Fri, 18 Sep 2026 04:46:15 +0800
Message-ID: <20260917204624.2427486-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917204624.2427486-1-coiaprant@gmail.com>
References: <20260917204624.2427486-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the Synopsys DesignWare
XPCS integrated on the Rockchip RK3568 SoC.

The XPCS is accessed over the APB3 bus and internally connected to
a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
QSGMII modes, with four MII ports.

The four MII ports are described as ethernet-pcs-mii@N child nodes,
consumed by the Rockchip XPCS glue driver later in this series.

phys and phy-names are required because dtbs_check only validates
required properties for enabled nodes. The SerDes link is a board-level
design choice (combphy1 on some boards, combphy2 on others), so these
properties must be provided by the board device tree, not the SoC dtsi.

The CRU reset lines (SRST_XPCS*) are intentionally not described: no
in-tree user requests them, and bring-up relies on the PD_PIPE power
domain, the SerDes PHY and the in-IP soft reset. They can be added
later as optional without breaking ABI.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../net/pcs/rockchip,rk3568-xpcs.yaml         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
new file mode 100644
index 0000000000000..703fcff0e3f70
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/rockchip,rk3568-xpcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
+
+maintainers:
+  - Coia Prant <coiaprant@gmail.com>
+
+description: |
+  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Physical
+  Coding Sublayer (XPCS).
+  The PCS provides an interface between the Media Access Control (MAC)
+  and the Physical Medium Attachment (PMA) sublayer through a Media
+  Independent Interface (GMII).
+
+  The XPCS is accessed over the APB3 bus and internally connected to a
+  Naneng Combo SerDes PHY.
+  It supports 1000BASE-X, SGMII and QSGMII modes.
+
+  The block contains four MII ports that can be individually enabled and
+  routed to one of the Ethernet GMAC controllers via the pcs-handle
+  property in the MAC device tree node.
+
+properties:
+  compatible:
+    const: rockchip,rk3568-xpcs
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: APB3 bus interface clock (clk_csr_i), required for register access
+      - description: EEE clock (clk_eee_i), required for Energy Efficient Ethernet operation
+
+  clock-names:
+    items:
+      - const: csr
+      - const: eee
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: serdes
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  "^ethernet-pcs-mii@[0-3]$":
+    type: object
+    description:
+      One of the four MII ports of the XPCS. The port is linked to an
+      Ethernet MAC controller via the pcs-handle property in the MAC's
+      device tree node.
+
+    properties:
+      reg:
+        description: MII port number.
+        enum: [0, 1, 2, 3]
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/power/rk3568-power.h>
+    #include <dt-bindings/phy/phy.h>
+
+    ethernet-pcs@fda00000 {
+      compatible = "rockchip,rk3568-xpcs";
+      reg = <0xfda00000 0x200000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
+      clock-names = "csr", "eee";
+      phys = <&combphy2 PHY_TYPE_SGMII>;
+      phy-names = "serdes";
+      power-domains = <&power RK3568_PD_PIPE>;
+
+      ethernet-pcs-mii@0 {
+        reg = <0>;
+      };
+    };
-- 
2.47.3

