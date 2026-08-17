Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA23C3449
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954852; cv=none; b=sptxY24OslFDUPDrZn+v6enqSuDZVk3pef6XdaZb+8OivkWZzP4fGJrk+LVJ3RpL95y1Ca8laP/AsEsBbj6uqcpvnLFfM1I+zeYOkLgKRNRtUvjNIladtoO0MOhQyn3ziB8vnVTmomNlPyfNNb9f8xF0ojN1joVEzAohHj5aPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954852; c=relaxed/simple;
	bh=kKX+clwqIG7nHKL+eNab6AZ63bLiuD95dpGcT66/2/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0KgEFQc5UnXi37hDV7f8OREmGbu1ZJcvcmM3WIv67j5raqFz+qL/RmMHmD6aotLc8hHkUM+jjAo8qFlQK+mvfqUS71v712odaQTr+mDXGYkpzt7G7K558816nRx4GWPGXqCC6dxdSfROFbMgVLC5IGpZRswS0PaztfTbbNaam8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzF9yMUC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzF9yMUC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so29441335e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954848; x=1787559648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MN0cvyBLl/Yf0HEK0e3keV9BG5lWd3AQZRn2j6pmwM4=;
        b=WzF9yMUCe0LXFwvolZOCz3Hkqo1+paFGjBNgnMoKFgQr+IEKRg6yf6zIMxjDByjDNi
         2F0Q7pANE87O6FUtbIeeG233ssp0ZdALFpwXXReIzUBLOF0psn1v1/bN20YmSellX308
         3qejhRg27baov5XJTKDVj+UxKXWi3GuPdAuMlTxjmJbn8wLRvrsZ950/UasjGRxGs2Yb
         5AZ33r01U/uvoK3kG3khuw+/elfc+9tiOpSC79UfSZ2TPFQ+j0il75Fcv49Bfgx3LheB
         nM4JW2BdL4+7tUnpO3v99hMmKGnBqfiAedO+2np+JxE9v6ghWmnkzctRJUg3i0FL3Irc
         C4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954848; x=1787559648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MN0cvyBLl/Yf0HEK0e3keV9BG5lWd3AQZRn2j6pmwM4=;
        b=CgWD3ZFX4GXx62eFIlBhTxwIjvtBP47cXtVMJYpRS6SHtoNOyXGMgkfYHcsdN60cFP
         tNuMqvStUirEGv1ptYF1v0cIDi4JmN59t7oZR8nHqHBIz3tguKO41php03D//wbgXkj8
         rII+1RUP8KYGLvEFSznbGd1QAjt2wLwILDbELgywJmQZwn2Lv8dHCepUMR1Y6ldLaVbj
         sysuAkY/JuNaN0wGs3ZgFspbrCn8N0h3vTx7OHwHGBBn6Jvu3DsTUfPMDKkcwx7VRr8/
         EZA8Y9I5ylXMpZruv04WfWpyxvrI6Z2vCG//aclmMZtPeUhiaAaYQU88RyP/WBKnScFT
         nBuA==
X-Forwarded-Encrypted: i=1; AHgh+Rqn5UGo/gjbQ8YazzGnRKqZuGH5bJQeBDAJFSSQ78ArVRGTMxCKBOuwyP0RyMxywTRzz+T1JQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAMLuiMhbsAHPgjLvJnMPkTGnkzMDvz96sm95W0qnzA5YJn8o
	O819Rd0eQkRbaPkfTAThomYgaLTVxsCbEDUBBR83ObXe8M36EWF/pRB0
X-Gm-Gg: AR+sD105ZI/t9M8CqLoorIE308f+64o0728sOr88bRPXkWS4df5iCIoVagNJsMHVSFO
	DomlnpcK8EBDiGAYkEmw+fBkdPnz7oyanJQ4POM02daIOjYoZFjDffzC6JiEgfKG+v0pSVr9pQU
	RPiPMTraJJM7GW4zv68viCAsw1RjygEHI1f0tU0aPu9MxzFgMD1AN1ZafmzDtjkTteBm1UMsR4e
	q/8qhD8iH/zPVTfTOXnvG3tiulgbncA61luDeq2r4fKvPS+soqUGZ0h+H3Q96yy8nvrt876GmQV
	OOOWLA8rjn6rqMW4id286Go3IEZLtfLWkntWKUCBKWqsq+x5C4nZncpctyWikQqA3ycUZD8b1Ys
	O1vVt4USWhb0WHPDv4yNo8vx3EiDq1WG0kjBy/mB7ENWOFwvv61x3b1Hs8UmHWiuDTxkvHE/fI9
	UGRQLmNY9R/BOZBtiOIpyc6O6LyYIL5yqD+HTm3OefDQsYxhgVGR8yneq7KADJp1Lk5rEXQyM/A
	R66pLsxqFxseG4B4l2l6U9IrDdIDFlWLPEH+mOgA5vdF4PjBhq7E+CL
X-Received: by 2002:a05:600c:1c22:b0:499:9a29:583b with SMTP id 5b1f17b1804b1-4999a29588bmr67529265e9.19.1786954848286;
        Mon, 17 Aug 2026 01:20:48 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-40-190-175.business.telecomitalia.it. [79.40.190.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm19684195e9.5.2026.08.17.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:20:47 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v20 03/10] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Mon, 17 Aug 2026 10:20:24 +0200
Message-ID: <20260817082034.20326-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817082034.20326-1-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com>
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
---
 .../bindings/mfd/airoha,an8855.yaml           | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..472da8384a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,175 @@
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
+  reset-gpios: true
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
+    unevaluatedProperties: true
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
2.53.0

