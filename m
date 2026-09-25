Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745444D7D3E
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360715; cv=none; b=m4uX/DSAWrU1iYZEFma081EYJ4t3ePbvZovyE0SYJRclYSn8vd6eIu9NZ6AqoTrm5/WEsqBra1tGefpUFfsOizMHEcr2yNuqlVrdQ8687R6TTlS12Ssf8PTMmvvlm5pYS7pt0f17xI/beY3cBrgIKhvetkyVsWWc1BRbbZwBhCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360715; c=relaxed/simple;
	bh=pOEzLfSLCr+9oxyGNTSsgNcprEznMU5MGTfyskpEb9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJOZkDRMP94cThnXSnY45isyPgHKdvuwH1nRN5DgTyPNh2ikZr1HbArs2lunIdTMOxqf5I8MIXy29CzJFjFOknirqL95+WB0AEMy2iNoBQW7AJakl07U8GEXi5+E0pA0sUHtY5aitmlExuGbvk1hazxnyvHdwKE2yqVj8/EBcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqJEYciF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqJEYciF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so7385935e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360699; x=1790965499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e+ciZeljp4XbV+7Ul/HTP2zfMzICzcEEGNyLNPo0cRI=;
        b=WqJEYciFIE42bW++TuvV9qcIUwlFSCQPmTPUyPjrvNWbrl7wnkK9gPID0kmnQqRom/
         zFgJYXkiM+OGhd7lGiJrWyr4QOvNBAk177LyBEfXIEmp9NDpjwJKM0RJIw+wDKMTcO5y
         Pm9vmN6kfMU/96Vo9jBpezoD9+GXjm9QHN0j/TnRi0O4rAYSe+ED0ZZhCRyDD9DZ2wxY
         enluWSDDeGYzdVy0zljT52bOdwgPKWaw2EhyGj9ATwYsspK7OF+R/tOpbNsbHx+2X6d8
         ZNzeTJ3OUaAlfvzCiryUMNpFvVI7qI6IomRx6Zu3/9xG6ntwDMO5VYu9LNchfUe2KSOg
         ZMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360699; x=1790965499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e+ciZeljp4XbV+7Ul/HTP2zfMzICzcEEGNyLNPo0cRI=;
        b=VlsxOEwHLl4GMAcI5e8Ph9kGyGzxS40vMaTaLH3Fq9aihHOPbIR4Dsbrly/JUjGCbN
         keSeRBC92i6EvNhb4YgqpFXiZnB+PfB1SbwL3V1TnFjn+NPYTpT7FBJbKOssRGKaioOj
         /gLb6+VnwT26X2FiEmb58lVthILDLTvWUWfcRp/i4Q8d79btixyRmvvP025bEWdWYGRZ
         1fJ34G67MzeZxMxz/KxgHLklmYZwUaOW4tMBZzBIJgdLxBoH+b4KpOYxswfBmiq65yU5
         6sZU8ZlwJKVjYxVQNBMV2bV58Ha+E7B8nmf+1MUQHZZiSVk2IjyhcHCERiM8N4U2hnrw
         bRMw==
X-Forwarded-Encrypted: i=1; AKwUvBxHH4K7MNrF0EUSTplVDGrQdrKuoB/xkweBO8LhPxZ24l8ppCnD+Ye/xzl4rVmP98UiMt//4Mg=@vger.kernel.org
X-Gm-Message-State: AFuF++n/hyL+fKhuwO3gPxHAJXnAqIbBp6Jhbf7nKhwkawBjA+LC5CJu
	yhX6grsRm3vS71H4HIiq+y8UL6HEhldY2yCcN8SXepEjHOxQg4VaD35E
X-Gm-Gg: AYBFou1OKPReShFgpPj1c6iVxDCoSRPusFWXK6XIaDNgHf7NToc63co6CHqrSMHOkg+
	ph4xcAVFdy1uPuZOvJUs4nka5W8+8QI1+5YFb61gzv7TUEcWz9z9f6hMOG/CXeHWq8Q01KyELMz
	blKVB1mToqRy2nnRzXOVHQYMuw/5xJvamsifGfXWRAVSKIHJYqG58WTZcD/1nsiKss4Ccs3Fd8w
	S7GNejenF8S4Y1xvOaEBu6ehF3jDAiuFO15z2RhB7B2H+Dj5BemCbpsDx652VF+gi1GL2Uaw97A
	Nfj/GsRpYOroIVTe9AyFaizBmjGL++llmB/UiDbFlnTdTIcJ3CrleccmjnM49ACgYntUZoYW+wZ
	oHE1tjqe8fZavtxYVRy43R9yy8FcutGqZJDCd57reE5hP8is3uAiVP2FG12b0msNOHPkTK7HxSq
	xZB2tJs0ZgFEtg8SmeWcJpexYsEomvNpbQoJiWv8z2me7oWbjvJxFc1QRcnJmaN0gwIr0/QUdUD
	DwbE3FMr9ihI2KQcUlZFm2hivmn9a3PJ2Cx6sQ+y09OA6EQR/x9MfTS/ZeRoYPcj9psFnVn6Us=
X-Received: by 2002:a05:600c:3494:b0:49d:870:7a69 with SMTP id 5b1f17b1804b1-49fe66d0768mr111652235e9.12.1790360698492;
        Fri, 25 Sep 2026 11:24:58 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm266231245e9.12.2026.09.25.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:24:57 -0700 (PDT)
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
Subject: [PATCH net-next v23 3/9] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Fri, 25 Sep 2026 20:24:25 +0200
Message-ID: <20260925182435.21207-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925182435.21207-1-ansuelsmth@gmail.com>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
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

