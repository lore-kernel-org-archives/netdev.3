Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588B41E6CE
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274961; cv=none; b=V7zDDoPbhGiy8Wb2ngk6iFIT/tiTRsHJEfdlVBbfvZzHgTrJ78q0pqp1P+JvG115jJ/H9Za+A7XeoUaghg8alVuodzYS3lRplyyM/514hJe2+bonw/H3Wi9FPAYjzvEAQXi7lzk922zE5YRmZP0W2ZkoFsbx6lF6o+xCNs5YD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274961; c=relaxed/simple;
	bh=oHYaNtlraUhl8j1v5uSplHKtyNUdHyxN7c+7WMfLpnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLdrRQrF+SvYIRmxgIoQ8ujnaU0Dc91h9D58u6ToNM1b10BeD2rGJ5TDrtU4izSnxQcqFxJmQICgHVptrb7NB6eb9IUh7ndhrZJt91T/n556npg/BdBTSrz9F2bWsvRHeDKevS7sz6xze28BALKTloHv0beWRO/3STpSzUpgtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE1tn0FK; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE1tn0FK"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so1695333a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274959; x=1788879759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6aB1UFx2dxtuDUMhshejketJxUphgoMFv4AnQI5Bfw=;
        b=UE1tn0FKQJZ97opEKCUhNoaAK9irazidnyzUJpdl9uAjj8XEqbQYeotwYhcvsE5Wmc
         //czlsaiuO9FJPl8M/cj7rfDbhqaSa/Hh4OBRmYRcMUk97AdYE0B67fzD4FFdKBo2Y1n
         wvV+LfBcgJOrGQCDIYzNJbdv2CZbE8H4NduitZ1TxuKQJrWb0o7DhzGHLVD/5PxrMubx
         aqPImzDlsZ6gpT/zaNENi+PXa+jh5uGQyaaC3jHUwpzXAzyP6mcwO3QabguNv+vtHT3r
         v9SyL7DYRtuAhftOniVfUnQ09VR9imuR//M1yW3Hkj33rQSghUG5f3AqyHhmFEONSEqW
         388Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274959; x=1788879759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z6aB1UFx2dxtuDUMhshejketJxUphgoMFv4AnQI5Bfw=;
        b=Wp7OpELehCr3n9wllie49vwRmdB4fIPzMtHsGB03hPoXimlhJs563IPY7IJ6P3vSu/
         UYZfGEwmFRRE6ulF+VogWjfMkaeKdZgUfgr3XyJAqQMQHlaR4b8/uSwmzX/rSpmci49U
         HnAFG2eQ2jGfmmQgkZGpLdXQ/yzUA6E8TWYm98jXx3pctjwSH2fPOEkBVuKkaxZLmnyA
         YIO71+ekwZAZu0jRvDTmpjJLnpbtIyn0D/sZwyhfY/sx1KhZShTr4e8dcE2Dzw3uS9jV
         MhFWtAxHltB8p1ijFWGB42boaNRoDg77UY08TwQgx4Fx6iKiw2MSn8d0L8HWYq175h9f
         +PWw==
X-Forwarded-Encrypted: i=1; AHgh+RqtipmyF+kvUGk6LBs0UDmJ6H6/hMKRRu+Sdasp1+IB9AQcTfwQuEwcBjgBV8+yBLNXZ0RYxAw=@vger.kernel.org
X-Gm-Message-State: AFuF++mL1rwUId11eLuupe9GYcre0pmeXwvffCb4CshRQEIzXEydN1eQ
	CqM+nADnr2HR/TatOs30Ch2a5Vq62PJd6R0fyk2tnXqU+QQv0RA0NzJB
X-Gm-Gg: AR+sD13b+XCStFJq8ehdP91ZVXa9hINRSLzj+mDIWypXtfc+dAg8l7UjHCimvQ6Bj3e
	1TcCfx32rC8Cd9EbKwDAPYYSi5U6AU7QaFHpwYQccAkdBkpCpjMRCVmFS2geaswZoUGpvOhpdKE
	qKMyVhdocj8A1Jcf8aHmikaM8vYmpOfx/f2n0LXs86MmzyFvdFoGriMbbwuFB+FyfCfirGBc4b5
	eiUHzPpInFx6Uf61/SWzMknjXZgU8B/1k9yqbZJJmz4TY5mdye6jZU5s9Z+sMIISkTEIBbrNWjc
	C2hypJmg2mr57dW2fsT7BQ57H25fSHtXNIhtdFn0OyxQkzgn4+hV7SLT7hOfBQAoIcyVfBgNXr7
	Udhuqhrb7CY6RznZEg3isKxlEqH3P4b6WmyorLWzOYNFEGoKaHSEhLvvuDrlRlaBjIoNYLt5osv
	mSnVh+WyHbKoIyXKJw60aLnAW2DWgw7IYiWLo8qfp0CJEIWgoB/loBAx7SuWmx
X-Received: by 2002:a05:6a00:3ccd:b0:847:770f:da4c with SMTP id d2e1a72fcca58-8562bf5a609mr51668111b3a.16.1788274959110;
        Tue, 01 Sep 2026 08:02:39 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:02:37 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
Date: Tue,  1 Sep 2026 23:01:04 +0800
Message-ID: <20260901150111.141037-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901150111.141037-1-coiaprant@gmail.com>
References: <20260901150111.141037-1-coiaprant@gmail.com>
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

