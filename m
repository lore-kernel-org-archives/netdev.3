Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42B3659FD
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594226; cv=none; b=Cqmhl1AcW4YOy7rGc7uWDrHmAPdLlTBQ4Lv0Fqmd6kpbynCuFSgd5ODp+wMhAGLElAiCaInwCspQwOTyek6rDCDfp7cCkzSC/ZGOyHPoIX/dVLIXQVA1LvDNfKOwkWB7nfcQMeIMiC11HyN3JfFeSV5IiJ2utfOquqVzs/Jr/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594226; c=relaxed/simple;
	bh=Qf6lD7R5NcosmxH5O74aDkfmgApGwnB6RgvjxZWBUQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a33jkhzAo0xR1h5LxQRBWH5jPSCk4UDxrhNPXmfZcc1PYdhewMccEq4ER00rY2ENbmZeXZeZwq8qnS3Lrf8ul2VMzqD4TQ+RmD/w481UN+0OZmyZhs11BHh/dUaeZusMJYLUV9DYWSCRzAZAToLDs2TfUyaKCt3w5oGD+EltVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeW/b/Q0; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeW/b/Q0"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so11250945ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785594221; x=1786199021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApDMeM/bjE3TDpuc1mM/C2VeZt90bzUPQWagsmJ3H2c=;
        b=jeW/b/Q0vtKIJhUhT3WzA6pmZBxZeYi2azWqBsS+A/rN6oOc8S1RlFnxecijWEPqBO
         OclZnvuWQrM5UDk+hfpxyimMj55ccx3vBfAF+1mCmZWKKRvLvo15W7CZTQXT6FA5bvBk
         I3bETis531QAAkXr8LphyJEyDUSYcMw/cVftim/9YMe+3MUH9myTaDGLGeHVFbQ7DC7t
         rM/5ajDdQJ1sy6BPYAogwX7aY5FPtGefPdUPRiFQw09Azk3Uza8J0SSKyTx/uR4Bqsfa
         mYF56v6aQnAUrSKBkE8k+Bu3n4IiTNbgodduVP1+s/PaMBwy+SlEbqjcHKBR3pZVXM5F
         vD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785594221; x=1786199021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ApDMeM/bjE3TDpuc1mM/C2VeZt90bzUPQWagsmJ3H2c=;
        b=YaSMKiAGMImYii40mQwxx5ziS2LpXXs5HP0Y//zt5uxeWGPRKiMOQkpfZJnQj2CCd2
         5UDOz/m0fke+r7/Am5IU0VhHeUl/6fTZd9LPMhEiXnIQu4FSSUXpK6or/a1NPWIIFHfa
         YdgW+/W2drMEkIoBp8eFKLP/A6ZayZ8v4BgYnO2z7nbpvGwBBJmVVqgXzXHcdmJDc+IO
         pS50ByGEJg/S/RK5L/NwZQ6VCNDbBlFWX+6KMgiEKgAZ0/NkLhvDQKAeoo/NgxhD0nzD
         uPPnGB3Ro/P/Ut2zSEVNP82tJw39Z8lvkprXOX6WB2kE+qk/Qztsv0k01HyoilrjuKSH
         dO1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqkWfOHparEB4oc47FulG2Oiy5MRJKU3YwXP34qRcGGMPewLleGRQMwwxCv+tNypMtdFwCm/ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrvAFt+fUv+wLOpBRtyaFtQp9A2VgQZJxNdwi+rdb395dvzzZ
	Csf9+a0ehahyQDYRjlxORwQrfmPwYZ4rYt1zsSDWTZ+PAN0lPJehYvrOb0Tq94yUExIrIQrd
X-Gm-Gg: AR+sD10mOZlrVvaLRSiIQFqZ+1KBe5XYCq8fdA83QtjxgI95DbtFt/QiIXHmD1Ue4tc
	MzxSFBXu3v2xtTonUiVUG1wyR1eILoyH7bQd9mjWExpMe/cjIzvVbUtMexg6yMnAV1yh3ucn+IT
	bE/MSbv7iRkW6j5W+DqcDqkFfkSfV8r66rUWc7Mmz3TQb3+aCxTgCYexvv/dwLItxqBfLou2eWq
	IrxKg1t1FoUMYxJ6zSP7XMzyY7msWyYsvjuySkELV6c7uKLt8D010q8M+l6vS5yufDBtd+VmZ4U
	Kpn9hDcHcGq2B9aXeO/iirTXCRPXKNzP6ESImxvLIdCqIcF1biaXNfjsR4VbWpF6jRlVy53aP70
	HC0nwl+s8FNUc5Az5qS5SD9dAKbj3DpecVdlNen+af0w1kg9W9rbOOmo4Sn0Py3CKUQGNHKCYZY
	5zAEM5Ia1pMIdznrtPsUUMTFdtlqyu2S7tTxJc6XdgcHWKzqXix1KZKY0=
X-Received: by 2002:a17:902:f54e:b0:2cc:6329:b7ba with SMTP id d9443c01a7336-2d05224fa51mr37049725ad.16.1785594220516;
        Sat, 01 Aug 2026 07:23:40 -0700 (PDT)
Received: from server.lan ([103.213.4.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5ac3dsm18043845ad.23.2026.08.01.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 07:23:39 -0700 (PDT)
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
Subject: [PATCH v2 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs binding
Date: Sat,  1 Aug 2026 22:22:28 +0800
Message-ID: <20260801142244.679437-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801142244.679437-2-coiaprant@gmail.com>
References: <20260801142244.679437-2-coiaprant@gmail.com>
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

The binding describes:
- Required properties: compatible, reg, clocks, clock-names
- Optional properties: phys, phy-names, power-domains
- pcs-mii sub-nodes for each MII port (reg 0..3)

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
new file mode 100644
index 0000000000000..3e3f3a388d822
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
@@ -0,0 +1,127 @@
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
+  The block contains four MII ports (pcs-mii@0..3) that can be
+  individually enabled and routed to one of the Ethernet GMAC controllers
+  via the pcs-handle property in the MAC device tree node.
+
+properties:
+  compatible:
+    const: rockchip,rk3568-xpcs
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  reg:
+    description: |
+      Base address and size of the XPCS register space mapped over the
+      APB3 bus.
+    maxItems: 1
+
+  clocks:
+    description: |
+      Clock sources for the XPCS:
+      - csr: APB3 bus interface clock (clk_csr_i), required for register
+        access.
+      - eee: EEE clock (clk_eee_i), required for Energy Efficient
+        Ethernet (EEE) operation.
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: csr
+      - const: eee
+
+  phys:
+    description: |
+      The phandle of SerDes PHY (Naneng Combo PHY) that provides
+      the serial lanes for 1000BASE-X / SGMII / QSGMII.
+      The SerDes must be powered on and initialised before any XPCS
+      register access.
+    maxItems: 1
+
+  phy-names:
+    const: serdes
+
+  power-domains:
+    description: |
+      Power domain for the XPCS.
+      On RK3568 this is typically the PD_PIPE power domain, which also
+      supplies the SerDes PHY.
+    maxItems: 1
+
+patternProperties:
+  "^pcs-mii@[0-3]$":
+    type: object
+    description: |
+      One of the four MII ports of the XPCS.
+      The port number is specified by the reg property (0..3).
+      The port is linked to an Ethernet MAC controller via the
+      pcs-handle property in the MAC's device tree node.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+        description: |
+          MII port number of PCS.
+
+      status: true
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0xfda00000 0x200000>;
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

