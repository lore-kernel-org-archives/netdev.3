Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21694E77EF
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562281; cv=none; b=aRNXEDUSVJ40pKN6d6my2Xq0OPhsuCwMaM99qIZKhqpWHOLHAcBeF3OjzLzsI4+wAjMoAtWYZQ5rXOlJ3iE9n/Ot4FQZBvedUOZbTmywnxFRD0gG/gXznDx1wtKeugXAuWwUOrdv1380LLjZ3IV9yxkbATXFf7MmgF7tpDk2b64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562281; c=relaxed/simple;
	bh=pOEzLfSLCr+9oxyGNTSsgNcprEznMU5MGTfyskpEb9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFZM998cTLiiGbmdQetltxT9LdA5SPH633dQ8LuTKuC1A72EK7QN5qPED51lUZCy28y3dbRrOgyQHv2yj2Dy82yk6hMSGJ5PIDHYntB2TlhXMIp2sc2IvzBRIcIKXCbleg7S+IWl8sGSKeGqyEp1dePlYK6DGO40oDUJNWhZRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLY++N8L; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLY++N8L"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afe75f055so5935293f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562277; x=1792167077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e+ciZeljp4XbV+7Ul/HTP2zfMzICzcEEGNyLNPo0cRI=;
        b=DLY++N8LLIr2O3E4RAdgXESErJKTzcXUF364Hebf8YnyKzCEjdKWYQCKExNxKCB0xT
         xFAXSjAbgrYlEO2f6M3zbfZd6HC6vK8lZTfWNZ4GuKM83ZiK4YUXG6TVcX+eBCyiGQ/n
         mxnQFG9Yf/Fut+DdDPkYas8BYUPhZqMB2YAYsWISFuumj1TxRM/lU2X2iryCHJf3NvgT
         sSRr1BjCtEeSEyHnjNPCmhccN3xSKkDZUq6im1ai0bewHS5X4fOVLChR1n/3A4GV3vkr
         TDRL8GUF8FcZOqyQRC51GTdNlJENEyILhcbg3SVpvFM+h36PhZK0TJ1FOuGWeW4n7j3f
         kpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562277; x=1792167077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e+ciZeljp4XbV+7Ul/HTP2zfMzICzcEEGNyLNPo0cRI=;
        b=hCVScNgZDE1Rb9V6ryIlOjFFeAgUfTIUIoRKmVKIWb0vCZU5IBWPCSlxRGcEko7PUe
         jJv0dhLSr7x2EX3B76Tiq7Xd0+u46k34UVSHtTH4SDzz2H0m08YOjww+uwaodh9SCNxN
         itB1lxcY8FCrbCkJvuOiP9vkMA9O3SwRKSUMXGJecF2c22LW2W48AdZysyyKC95KNgy1
         AQ6HoVDXi9mZ0CoWo7X6H6GQPpGjrHMTQGMpMovFcxB9isi2R3T121pRd/hasOHRJw5G
         NwZ8DVOfHJ6ZcPYVERQGF4vHxd797s+VXjvBKYe2ZLZRWTLdvi4zju/er9n/O5w2sAQO
         t6Rw==
X-Forwarded-Encrypted: i=1; AKwUvByVvsQ2weqNQb3cSeiPL06UxzYoQQ8cRuFl2T+tDYpbcWMyxHWK2oAYoRUPjKfGI712WkWdstw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrgwxPt3J3Jy4Hn8+FD58n4C7hCISHvoz+RaM2QlAbtiY1VTRb
	fF+rXr+zfNpNaQvSww/oXdwE/AUlmUuyacL10ba95GGNnytehpcsUZCe
X-Gm-Gg: AYBFou2KFBLOWo34oLzi+s2yQNLYNbdBN0mXh8U5Fqey2Mes9t11cF08Looe6J8mX8h
	+FMIBS1BQtUsrpYPfPaF1lY+J10sOZXLxoSwnBs5+fwgeO39VWvNAZeXapZg33gZ5Le8DSb9v3X
	iQ+CgzvgxCURuHGvouQtLy4HXI5ShnBtecbLxn6f7OiJnbwIHtpWIRzboUPBQ3f3R63wXPd6iFg
	aHmqAtO58YBIqAJt8F8vVOVV1JQOU4nkPFb61ENWzqvP5rNgd3CPacziM+5TLoMkVAYy1+Roc1B
	arcyCrwyZEszd3g1qkRnkDcOQC/6CuGqCG2HFGZiXmDOQra7aEpTtih6h7TyL/F/TdD9sVTZ20q
	j6CT6TS9ZC0f+DhmQMhtDznMKafvKd4r6All4Ni8iIImEC7zVuAABLF7UR9ldiB5SO3okfblSjH
	abSCK/8sa7p7TPfxKp2HlR0TpE2MM6BwzomoplceLmQtyswhIVYhRex8Wr5ETbrg8BceVX98TPk
	iTItE3nVgnn28bpZdicO9cRlioZHBxyDBVeYh3N/6PtjENfGa/a8axAORNK0fbsqLs46BjH953x
	kHd81LfKUzAVvGT+RQ==
X-Received: by 2002:a05:6000:4313:b0:48c:5358:f999 with SMTP id ffacd0b85a97d-48dbaaf07d4mr4638604f8f.37.1791562276952;
        Fri, 09 Oct 2026 09:11:16 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:16 -0700 (PDT)
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
Subject: [PATCH net-next v25 03/10] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Fri,  9 Oct 2026 18:10:48 +0200
Message-ID: <20261009161102.38961-4-ansuelsmth@gmail.com>
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

Document support for Airoha AN8855 Switch SoC. This SoC expose various
peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.

It does also support i2c and timers but those are not currently
supported/used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mfd/airoha,an8855.yaml           | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..48127e956c96
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch SoC
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 Switch is a SoC that expose various peripherals like an
+  Ethernet Switch, a NVMEM provider and Ethernet PHYs.
+
+  It does also support i2c and timers but those are not currently
+  supported/used.
+
+properties:
+  compatible:
+    const: airoha,an8855
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  efuse:
+    type: object
+    $ref: /schemas/nvmem/airoha,an8855-efuse.yaml
+    description: EFUSE exposed by the Airoha AN8855 SoC
+
+  ethernet-switch:
+    type: object
+    $ref: /schemas/net/dsa/airoha,an8855-switch.yaml
+    description: Switch exposed by the Airoha AN8855 SoC
+
+  mdio:
+    type: object
+    $ref: /schemas/net/mdio.yaml#
+    description: MDIO exposed by the Airoha AN8855 SoC
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - mdio
+  - ethernet-switch
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        soc@1 {
+            compatible = "airoha,an8855";
+            reg = <1>;
+
+            reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>;
+
+            efuse {
+                compatible = "airoha,an8855-efuse";
+
+                #nvmem-cell-cells = <0>;
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+                       reg = <0xc 0x4>;
+                    };
+
+                    shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                        reg = <0x10 0x4>;
+                    };
+
+                    shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                        reg = <0x14 0x4>;
+                    };
+
+                    shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+                       reg = <0x18 0x4>;
+                    };
+
+                    shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+                        reg = <0x1c 0x4>;
+                    };
+
+                    shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+                        reg = <0x20 0x4>;
+                    };
+
+                    shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+                       reg = <0x24 0x4>;
+                    };
+
+                    shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+                        reg = <0x28 0x4>;
+                    };
+                };
+            };
+
+            ethernet-switch {
+                compatible = "airoha,an8855-switch";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        label = "lan1";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy1>;
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        label = "lan2";
+                        phy-mode = "internal";
+                        phy-handle = <&internal_phy2>;
+                    };
+
+                    port@5 {
+                        reg = <5>;
+                        label = "cpu";
+                        ethernet = <&gmac0>;
+                        phy-mode = "2500base-x";
+
+                        fixed-link {
+                            speed = <2500>;
+                            full-duplex;
+                            pause;
+                        };
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                internal_phy1: ethernet-phy@1 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <1>;
+
+                  nvmem-cells = <&shift_sel_port0_tx_a>,
+                      <&shift_sel_port0_tx_b>,
+                      <&shift_sel_port0_tx_c>,
+                      <&shift_sel_port0_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+
+                internal_phy2: ethernet-phy@2 {
+                  compatible = "ethernet-phy-idc0ff.0410",
+                               "ethernet-phy-ieee802.3-c22";
+                  reg = <2>;
+
+                  nvmem-cells = <&shift_sel_port1_tx_a>,
+                      <&shift_sel_port1_tx_b>,
+                      <&shift_sel_port1_tx_c>,
+                      <&shift_sel_port1_tx_d>;
+                  nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+                };
+            };
+        };
+    };
-- 
2.55.0

