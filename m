Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE14B7A4B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107478; cv=none; b=hroeahjfKGtXduDDiayXddE60p0L1ITvGytSw1++gGAtIH5mDM9q5nJ3TguepD+e+3h7ZJLpo/jmAYZBh2VG+Ah5INzMDYHvKrz4XKttF9ovzVwMxZw64438Eff5Mf+0NwtN3askeFnUtw7qy+khsRT08QrxPMxvhLHDkYKzIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107478; c=relaxed/simple;
	bh=uIxFaIx1maUJPzb10cLtB0jKa27JO2f3e4ujLzs23xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYz3B/ffEZYLnMzLALTHvbu1B+gbNYC6v59ht8iCAeJwJftehg3+BaJiUlE2Ue9clx8e6MpTzJhMUqISfxhe9H6gGUGFEhsHMBNUm1ZrYAx/146E7h31QYGkH1y9RPzG75hMYtAPyGBsKI9owUNfgaRK3T3SmZ83e37HtJk1Ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIr2APoD; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIr2APoD"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso498445ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107458; x=1790712258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzUxf96lJcOF3iW8gS5QIxqqy13/2PJtTrFNEXc29ug=;
        b=fIr2APoD/SvW9DLLtjKRuU1LziuuOor5RdzvIBWMKI4VwSbUlfXQuZk/ETywoUGXqu
         IhkSWZe6rfKdwRlrSWj7xUlXHn07E3LgLx6I9nzA6mKaJa83jxwOOMVyquXoHrAl7i9G
         tHwaPMIZVgaXDzvWyvA1SxFgvubjK2J5Oqvu0oigGYlnqBFsUBr/7W36py8tfjH6SuEp
         Ebu7os+bxbr/4Kv1z7XfViFqWBN0VrCAz7TCyK1RlUH0odSXC0QcL3Bc7NaU84/TP76I
         Yzn/RGt8ZoEO0jWTrtynNltc3MQOkaxv60Hkb6lJnpp0FhC0NdUw+CPfSn9O47JVF3Bt
         EaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107458; x=1790712258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzUxf96lJcOF3iW8gS5QIxqqy13/2PJtTrFNEXc29ug=;
        b=pYm0D+DphwrDcenR/eG02QsGVtb2CSdI1o9GX4Y3vNFFvPFqfYsQbUcztHNXjmunUz
         ZeSNqluBo1B4kQ1kxQh94s90bxLhiNVNz3XoJ+zrc5yZow66FrsnLci+5N+cv2PMCqFw
         68++rhX8BB2HPbWm2ZC5/5u6oyUDhb1Ilhvm0SFHk9O4i3iZumFpNgYKCcaYkwoMdofD
         Z84UcL0QZpGaD9zWqKz9o2nnNdjFkmGeOm3NN6VkNaYLYqxJun/CmgvBHXri5NP1Wdca
         +Azqa5zB1qy8VGjWy2w63pfyTQGG0n2PmqYBeWcBbY30UAcNtPmEWDm3zv2liN0ZQR/7
         52Wg==
X-Forwarded-Encrypted: i=1; AKwUvBywBL10VEboBLVZS1g8eCtrPMDd8fKf/w8pAIBCZDaLjGvKo6Sx0HXRxlZtYN2jtKwP7/oh7K8=@vger.kernel.org
X-Gm-Message-State: AFuF++kJlQSicw4h1+cHerY79yAd/sz0sN2d/fCdWpYSlHqnBfo/199+
	2TC0GfCSeh8QNV35TuINKXELQENJckB72VXRAxN6ABEaYesko/v7Jrjx
X-Gm-Gg: AYBFou0I1GMD/EtVgEQNLjJOL27r+paO0H7fcdvrvpxHft1xRv5mvhcLCwzA6vNOiMg
	AO6DTk7Wu+FuHfsfGn52yYskg7EaWjaOsCvdbMN+iPfElTx6XcWOc1sjOFpuHYs7WucGTfSPXD4
	wv69iobtdu7Z1IdSv9+gyFBpOehcZG1LzLqa1B3eEzMj4oSIMJLvNABftBcFAtr6+x0M+1jvWXU
	tB59GvzXU7pVZcdyWbGcklHKSVpGJ99HjzxnDTmGQPXMq/OhBZ+aMbSlihdTRPJ/BL0ZpqXhwNC
	pVEbMfaP5zmS2UDEJ9mVvHGnon6rltjH7Vw1jtRjH5A3RUV4yf7LdCTVVtZny48wNMjZa3UuTR2
	5TZboVdLt61vPVeVaMzjGE8L9tGtXYSGoKRmK3MDjgQW4RMs0QceKYAsHuO4Y1C+nBO0HkdmB0+
	ZeY/6sWBudNTdFbYX8DxA4n2v3LHT6f7UHIM7d8y4Z6KNJ80KrkAQgoFX/gAzAeeaMCv3Z
X-Received: by 2002:a17:903:2350:b0:2db:31d5:1448 with SMTP id d9443c01a7336-2df69d689a1mr3760135ad.22.1790107458354;
        Tue, 22 Sep 2026 13:04:18 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:04:17 -0700 (PDT)
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
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v10 04/11] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
Date: Wed, 23 Sep 2026 04:03:28 +0800
Message-ID: <20260922200336.2201212-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
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

