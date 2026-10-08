Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A63BBFB3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481985; cv=none; b=p1HBfaf9YzQ7iq4GLNOP6Tah8MPRN2cNcVfB6RZHgaXkN8WYpfCWyAbIc8dj3PzbeLrRc1DOPkAKOw93QnPIqtYMRXhZRJ0diousCYoVBodtOruN/CkHn+PXbupC6gEYRaaZPZzEvbybtxWlZKNKWpjN6y+C65SoVQc5gPqpB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481985; c=relaxed/simple;
	bh=wxtOCo1J6xK1gXQQEVh3Vjrp9sJuOVndjXZA+LJ04PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aeaim9jtk9qFhw9Q3O3hEh1IAlmGnmUZvZ6V8GIOZnZ22TX/m1w6/FJ8P93gU/HkY+wXdMYlmCbBfpJFYB5AiDyyJf7bihve8R6FXsEU6ce/2e15kVuQsz+WXW5rK1XYy0wzJnbvyGww2K4uBVVqkbcTKpBE0qlC5T6Q6iDq3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+GZMEPu; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+GZMEPu"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3a51696a650so3068371a91.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481983; x=1792086783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QbQK6NgiCotND3PJt+n3FsbZUv6wfc19zH2Mf9/gmJ0=;
        b=h+GZMEPu4ZOUqFmyxDkrVjYPvpUuIr30bYkKhhJIsKUmBtWchy4zi292SnPePCwbKk
         2rwmaG6gkVKnsRSaoFH05uCpcq4H5Gj8faABP+ri9zYUV6uhAb25ldfY8OAHE9TIIMFc
         RRQvHLcxdeFtlV/aVa4W7eTPppoP8CFBTcmUSNA6IJBwGtQA+tPr8o4tgk1QOmhR3bd+
         uV2PB5HX3SPqjQyEIEwqslUlwHO/6lFGJIxJV8ZqNymiUlYF0lsZdkUYRYGX2u5wVcdo
         r45ps+ncpUj7k2BR24vixdAwEHs9OBwCwOs0SLY7hph7e4ik+13JqTk9N5DxW4o4hrnT
         HW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481983; x=1792086783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbQK6NgiCotND3PJt+n3FsbZUv6wfc19zH2Mf9/gmJ0=;
        b=pj3NSadC9Rki71URrSAeramxWMYOp2CYx19v4XKp40Cx96bXvpm1fWIh6SCP5BOQ34
         zCOiXXHiMRLhEGfb7kpfAdsiIyo0uAoVucRUyTY5rGwdesHnpb7tFmBzFc8L7v5DyqUi
         SCoIrb+wgcO9iXB3iC96BG6toHO22r8bJVkNaNMzpXMhat3Q6QiTdSvNyGH/szqOnTXx
         WRRCdIQDhjr4uy1n2CSXOTKGreHXc9dQ2Rp36g9RfY7rvcowyRVbb6UZIb7sI4E8Ft+0
         EqsHq+BTBzo9V76bteYISlRbCGvOVjbyWsGx6H7mZq72dXCJlzBrkWQgLr3onDf8KYIX
         DZbg==
X-Forwarded-Encrypted: i=1; AKwUvBzvW5qfvHSbXlrYYMIxw/jY/SEG5QKKKQCJt3UvX5kmKCN7+OLSBgV1UF09DPWRRUUSaSMiY1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXywvFpOIkSxhTZX7vWMD+AW7Ze6NEOxSbIgIUAxXmKwfJCMtt
	ETbWjE/Z3NrmpTWAP34OVRhHHLlHwy66hnIsDIHg1SoHyVr065iFpvOA
X-Gm-Gg: AYBFou0YWByUMB9YaKi8C3/PutJe8xmT/kS9zIRvN5vBfQJpIg1NbD9UlF+lNc5J22b
	lIjg/z6S9/t5Du4kupkLYv1zPFZVtHZSpX6tTAVUxm0ratfib52tMcl313mdu2JG4OrbO7w1xtk
	te4F0CmrZEfCCI0A8n4Jlg4qUKSuLAYJr9AY7Qyk8Jo2Boz7qF+HZeK8M/pWvZVE4EdgFK6mrqQ
	mvP4FFJfEpcr+FfM//g7dqH1Be3YHyJw492aUYuSQvc57eIVSxJ/V+FIsS3qv5Eb9quGkpsXe6Y
	tvNU2NTNtHranH5G1OO/sRofiNXBv00QReUcQKVjFNqunIh3xngwsQgXsgkOSpFyTNmCXfn6fYF
	bYsTNidGMnyPLIvVfpaRNEnS28YHiF6KrNoqoKMOKJAvWNqwoF2/ekNHpQ6kCK5SqotuoHIFfSW
	0AxP2HK4omIHLyashlwmVxm1dUmhKxUvPj4l3bCXT3971XzVjwRkp1O6R+citLqZZgeP9MvtFQo
	5ZKkNw=
X-Received: by 2002:a17:90b:2c86:b0:3ab:2737:3393 with SMTP id 98e67ed59e1d1-3ab273737d4mr811350a91.40.1791481983181;
        Thu, 08 Oct 2026 10:53:03 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3277c459sm144332a91.16.2026.10.08.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:53:02 -0700 (PDT)
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
Subject: [PATCH net-next v11 2/6] dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
Date: Fri,  9 Oct 2026 01:51:56 +0800
Message-ID: <20261008175225.3375274-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008175225.3375274-1-coiaprant@gmail.com>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
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

