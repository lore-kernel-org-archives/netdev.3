Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66154AA401
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795548; cv=none; b=lBTAyQ5jTQpBeoM3BTt6EPOXnLcTm9KvFF/be5HlznUkcCSeVYiwRfV54Cb3UmuYdOSWhQEFaS8rHDO4RUOt6H4s23fTY8Z/zKJV5clZGRhVbT/HbZedpbEfhCUNu+X6erc7Y3z7cfhwYCUqd9I26HJ2ffq47KMkQekttsf+WKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795548; c=relaxed/simple;
	bh=oHYaNtlraUhl8j1v5uSplHKtyNUdHyxN7c+7WMfLpnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnZXIkgn9VpBCkC7nj/vttrbTqklQOg+AfOvOwf0hcoRcQSMLq72hoDH82zyiah8vHJV3QjS3FXXV31T+/HG/yfiZ/nWiwM5vmcAnSf+BijRaHOqR6eYitYV1X2m/i2FI0vf4DwViL5dr4sD7eUJMJEtKjsm1Un8HqRYBwpg8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kncc1AMP; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kncc1AMP"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so1463948a91.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795546; x=1789400346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6aB1UFx2dxtuDUMhshejketJxUphgoMFv4AnQI5Bfw=;
        b=kncc1AMPckBK2wC/EFxqB9keSVfJrlb1S4qWK2o3eyKbTQ4JOgFJdyEWaZIeDcCPJ2
         kuaa467DGAiuPW/Hz+txbTTAm0ga5x2KB8wIhwJc9iskEj5AaCYyhA4wBjYnRYrvEusZ
         Pkk7r66F1vKR3DpIW6EbWGRzD4kXxH0WlJUr4oSk8/nTqtfRalXqENcnDrEv8fAmQaYO
         /MJt0xkma3JMXp6T1cDfuPsX/LEO3rPtzVUkf/OWLkN6nav1LO0T/pjUDniS5zSImxbX
         klKYCfSJX2gR/hIZT0noAz3laDPo6leIFu7We/qyKp/S/zZjlsHudMjPphBwSufMo3Is
         jGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795546; x=1789400346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z6aB1UFx2dxtuDUMhshejketJxUphgoMFv4AnQI5Bfw=;
        b=baARqcYNnWxcH+oCF7PQY9yOKbUow6EwyPmpoSLqIoldTAl84i0yMOLBpQ3CX79qxO
         JwvhrisPs8em07F4Vu2+qq2KnpwIw6xWR+zZ3XqR/P4XNJH9I8hHhgIedb0NytSJnINe
         gk9S2tX6onQun3j72pRIcqhQjcQfYh/no0NWkEUdweQ1rF1P/5Yh+1ygIjPqe5QZEByf
         JkAhgcfVxSMPqM81YB4q8b5rlI+2O4S74FMrsWyaK+rClqTh5Mfshsxwz4DIlFm4eAha
         aA+2+6QWXG9BdsNlwR9WZ8HseKf1dfFZ1FcDPE1MfrApvqTu9zBRYikMaR2ek29inUzr
         tj0A==
X-Forwarded-Encrypted: i=1; AKwUvBwL344bTCnIZT1WUZkZP4iJAQHF1Tp9LK9hX6baCmo344TwjngctPS8R8L3U3g9JgSfHFZWSr0=@vger.kernel.org
X-Gm-Message-State: AFuF++m7lG0XRl5eeb7R2TUuJZCxNnObyYR18aFdx8oms5ZfD7idd7f9
	s+amw0q6Hktd62iHImsOp3Gy7UZWheAdDigcYrEgbGfzmL2+zdRGGxeY
X-Gm-Gg: AYBFou2RecmbjCEJBkfdbNJIb94LrVuc1W+TbbjgEiQ/lGRN8ZbAFyJAhQ5oEMm9+VD
	v6Gs7tuj/tC85gBbVA+okVV0+O7QbBO3AAoJz77il5r1GyU45K8u+t1yEbUWEPeQA1i6ne8m0Fb
	muHJL7QkUo+sSWWXtxKOcuRIZS5bi2nRuajbvNMvb9kDBi4tbAWw6SmgzQPMr1uKq4xAaZerew4
	Dq5CBRxes3PoDN9nZBu4rJx/Tw6a7NZYpqAoZRVVkVu1xLQzqyljtdM2Ib7OEse5IpP+I1WJsqQ
	lLieFP4OyhVDAHShhW/+Im3oaf6mjQ5vBMN/IiM/SzX3FInxS4lbldNjl3TzyB3yJLbZts5aWtB
	7joW/98TCicfEI/qVCYXE4lS9tz1bxleIjEzOqi5TrEaM+VFFtvSESSajN7hG8waVZWV8CgOdIQ
	r4nDEnxIvHUlS7J49rLWz1K+Mg7CFSm8KmDzXSsr3qBUN3D/00o9dGRVZ256w=
X-Received: by 2002:a17:90b:3149:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39b2618060cmr36557328a91.10.1788795545874;
        Mon, 07 Sep 2026 08:39:05 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm21690121a91.9.2026.09.07.08.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:39:05 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
Date: Mon,  7 Sep 2026 23:37:07 +0800
Message-ID: <20260907153713.2572547-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907153713.2572547-2-coiaprant@gmail.com>
References: <20260907153713.2572547-2-coiaprant@gmail.com>
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

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
new file mode 100644
index 0000000000000..0852d0bcb66a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/rockchip-dwxpcs.yaml#
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
+  "^pcs-mii@[0-3]$":
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
+    pcs@fda00000 {
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
+      pcs-mii@0 {
+        reg = <0>;
+      };
+    };
-- 
2.47.3

