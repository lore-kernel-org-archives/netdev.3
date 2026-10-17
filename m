Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4153914FA
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215897; cv=none; b=ueIHdrbZi70eyUd8vbCknEDuE7gbhnWm3GYcrPx5SJtN/L3NAH1PO2cZS8fsZZC5f8dZKHeWCJ4uxqTzzwDix4Z9vX4NcRVntJ5+HkKr92YIKDYZy2bnsQbph9PaiPxDAlB1mSLlqUOegd2Ut6fz9dHV6+c8kRi98elFLS7ux6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215897; c=relaxed/simple;
	bh=+ojFAngay73d5/WyAyhtk7ad9QvimhvdpmPfb6gztdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaC0O50ZMjPP3xFBOVhee04w1oL2EG+6UC1cdhhZGO6N9TvABEzKKlG+AQfQkcM7kSJq5ycam5TsqeggtuV3PgxYpoLRwE+TT/lQo9g+mPNa/Nw6NrfASIYZ6EPwjJ73ZRgEQzWg51UmJIiDdJ3tr/GTiuJgLZuv5/gBLE695D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNMXi5kk; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNMXi5kk"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc75f2924abso447184a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215895; x=1792820695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oT/1KwqbtpFXM8iCK2NrIcWEMqWijDvNOiD3geX4Tok=;
        b=HNMXi5kkF7KjZJs6XBi5hcja4K6dT/WUgYU0Z6r2rKhUa3kaimOTShnNtxcLqyypwZ
         jzpLR76Goi1nDRIGgnbHaDLepsbqf06T+L36SpYza4cdvT69BE7KaiEeGVlu1Dw499nN
         AcTgq9X29Q7G8rEBnPTtYtSWGuVs0/GnlFq0WDg/ulU4qNteuPF29AE8vEaE+sbCVmxm
         alb7JjJdbvgqmBw3I3qwBpZRUG/2qqggfK8tVAo8WmwoUymqqPTmq4erhZT6IS7BG+O+
         IBPoDde1bnisKjCCOTwQZy/V+LsrIb4s1AUGNzorXskfNFZJuDQCTZ/ptArV/SsOOHXi
         ls1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215895; x=1792820695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oT/1KwqbtpFXM8iCK2NrIcWEMqWijDvNOiD3geX4Tok=;
        b=YL5hcEYz1uKD8DaibB5KNpx/NpwG4dgJUH55rhH4CB4MIV08HN+Hm5/T4+LaJmDCLd
         AYX/XZ526HTCcrG7vz6Z0ANKmX9U0BXtkWVM20KcuDAhjTTqo2tulg5677miZ3n3OwBS
         6Fk4luVkaKtcjFdqFD4StPeZ8jHZx6p24V7ucU9cQzw6MVZJH+1/VUT0Jt+hfI41XYxC
         EExjGbVC+sepk2xSckgVVnK0Lu7cUP1fYx6HE9TlqFJ75/nm1QKEgTc+fBwk38o2L+zL
         pB6PlYu0P6tJqyhTe8NzzS9k+zaH3MRrKyLhy37j2ZI2/6M5iFvjpxa2ubNCY3K6xkgg
         W0dg==
X-Forwarded-Encrypted: i=1; AKwUvBxlDRFRXSBjgPwJjRtV5R2x9Ksp2fABca3l+ujvmF46msO73VBlYUd7ZoC8BUnEiJVetrjlBwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA0kMPDzaPKdX2ZmU6XTtGsyJ1QgrmYiIBESXlmHmA8mFvze0s
	9PwBs9ujLniFoc3RKGYtAv0kka5Dzlh7FrEc/Lbes3Hr+/pdepWc9h2s
X-Gm-Gg: AYBFou2FipHmzjI7Pc6LzM7UduJVZEJ0hxM0ev4l5FYH1NAprNi8DpQ6by7/hBnqgEH
	T6bIcMaUtyY89nXtdsBTgVxkg1NZK6OEL1mK3gBjBTAoGDar1o+qubq4vTUqKacVcaQxcvz1SPo
	tb9ySFe35PqRuM48Xv91SLVQhxx1PhkK1bDLCjtlNAaSN9DHn23yVv806otrr4+qDdxseI3v+Ci
	HHPztfBdgUx9ex89rXR/vgGShi3T8+b0WLDEavTyjAiO1+JLsfefClDsoJqrPB/Hm+HPUJj0mKC
	bTtiEzwRXmrQKaeWjCn19IvechZyikHpHazcjj+eXtbIPZiVt0h6eT+BR5t2N+Te0eBWlQqhvU9
	0mKoIwC7uUM1kEU3g+0YQFagY3auK4gktzUXg/ZsbqYgeMICfHbwIHUNAt9Y+QuZOnkgaG7tvVU
	pnLNeJdmH4ZCApiwTRLlkBGF9wg6TRUg6T5dwOM8qUDMyOeAJVxRyCkxT1GV3QyyZ4DVZ9QLJxY
	fDy44c=
X-Received: by 2002:a05:6a00:408d:b0:89f:b166:bde6 with SMTP id d2e1a72fcca58-8a04c43805cmr1583712b3a.54.1792215894837;
        Fri, 16 Oct 2026 22:44:54 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm1958225b3a.23.2026.10.16.22.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:44:53 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v12 2/6] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
Date: Sat, 17 Oct 2026 13:44:00 +0800
Message-ID: <20261017054406.1828061-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017054406.1828061-1-coiaprant@gmail.com>
References: <20261017054406.1828061-1-coiaprant@gmail.com>
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

The MII port used by the SGMII link is derived from the MAC it is
routed to: GMAC0 uses port 0, GMAC1 uses port 1.  The port index is
not an independent board-level configuration, so the binding does
not describe the ports.  If a future SoC needs per-port configuration
that cannot be derived, pcs-handle argument cells can be added then.

The CRU reset lines (SRST_XPCS*) are intentionally not described: no
in-tree user requests them, and bring-up relies on the PD_PIPE power
domain, the SerDes PHY and the in-IP soft reset. They can be added
later as optional without breaking ABI.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../net/pcs/rockchip,rk3568-xpcs.yaml         | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
new file mode 100644
index 0000000000000..a331880eb11c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
@@ -0,0 +1,69 @@
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
+properties:
+  compatible:
+    const: rockchip,rk3568-xpcs
+
+  reg:
+    maxItems: 1
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
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - phys
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
+      clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
+      clock-names = "csr", "eee";
+      phys = <&combphy2 PHY_TYPE_SGMII>;
+      power-domains = <&power RK3568_PD_PIPE>;
+    };
-- 
2.47.3

