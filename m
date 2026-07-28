Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92F33DEE6
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253755; cv=none; b=lI9+zN29t2RwT0VR2QxNRSHVcaEwNm9EM2JdIvgqycaylchXTwVXREpECVT9WoY97X7qCXu+PsyyB3ubA6C0TxHuJ0ty6hXfueu3nKFO7wyBTx/TORddFlO6MfLM8q08hPU3Stc7OK47c/LsXmtJg991bYqnDWoenZq8NuKqnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253755; c=relaxed/simple;
	bh=D0rHVc7iBpZXkfS4z83mpuZH1Go8dorICWjn3SYQb7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juVaEDfun577nquX6QvAdkqDw+/J38bLhZ49NUQ0+GxvAsx5CpKkhf/K1Vc8Ct0FSWFxBhLINNmBD2Rng+Wlg4M3kU2mHBkOVXX5WsVkOu4wj9qVVe8eSd6sLqeWBF6HmM2nYbw7wPvLbW+s70VB5th814dp51kc5xnSIb93EEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwOrtmRa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwOrtmRa"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so16505f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253752; x=1785858552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iZ5Ahml9vc0Lc4cZvlseqL+CGWwYxJKEQ105WcAHSfg=;
        b=KwOrtmRadEtGJJFrC6g7+SgBy4rz/rfTKLJpascVZrXHO6I+GUUcdTl7iMyYy9Hyg+
         2ky9NmeoQ2LoaCT6bcN0bwCLHSsu1lH6coedfvcrGD4LGMHEZ0GRgjE/bEmv88isYSmW
         rE4FkvLhYM7odpKWDrF7KzgULHjqEndcAx9QRI2MW5RXaWyWPNRXhO9L1Slua+Y0Y4g/
         ugtt12OKaMaBk5E7PzPSDKIBSE6ZlO95yHgjqZ2bPyAftmU6uJJhE0j//bqda8GLaGN4
         3cPDfyY1/hgGsISW/PI1PTvnpUxPx5dkNU+PrM3Eb1r2AEQ3KjkazoPjPUmy1ctpkyo2
         BoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253752; x=1785858552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iZ5Ahml9vc0Lc4cZvlseqL+CGWwYxJKEQ105WcAHSfg=;
        b=JU2EWvQPy5nFQIV+h85XkEQlWMQdicnyzsolWGPNUi9Cg/9tKiDysPwmmjEh2MqLhw
         RqaTReUBrakIGBb6EAqwHYq+Zg9++0HRicHT3kSAE2hBxOpY6hbCcrzIarKRmEqABmAD
         e6HqCP5b13oD4mIvrEzspC29PIRIGv3eY28TdDtTmKJScy1oTYT0xAHBI01mPxlipfDJ
         qY08HZ7v8VxwuVG+vg5UlShlaGTjKgWZesTjt/WR5L0lvcxVNpQvrK0000tkPTZf/LoG
         sLFZxY8chR/6C/ZXMfwT+4aSqXF/2vmVfG7Z2SrUMKMsH+Nx8DpuJoA5XcapYt/D6zfp
         jzvA==
X-Forwarded-Encrypted: i=1; AHgh+Rqfjwg8IN+lu7g8X1AnOZSQxHsBFUx4ETOH0hnR8T3liUqErOO8yYKPk5R/k4phXg649IiEo24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzaxBofRNR7WZTVdA61HCpaqTn7DN2GF5T2a7PcsDsftE739b
	cJIMsfiilZ3ygForAD5y2Gj5Zz0+kv4pwMpPKX2nLw//U+qrleI8vers
X-Gm-Gg: AR+sD12ia+m9h1uXhKBvyB2qQ7h6uLvE1SaScn8P9UIoxjhBdmVyXspy6q0yCnPD5kW
	WjCPq5v00u5+phQyn6fTXxMYbI+WISXRZBNsHZp4gTwhsJvPrroYzR+b+w3gALRvtkvjnGJSZGH
	aiF85WUh8QxExwW7JK01VLLIooRI2uueWdHTYvqO1lDbVlAOIViqvOKLUV0KgggZyWO+RAG6Yeg
	CisEYH60YvEXvqQtWBBT3UZs0UCKEuZL+Wz9SNI951t/SeNjQ9If+/Hf9uI4Jger0cVkkr4rO8W
	yxDqxwdQloam1gQd0nOGkpwL30GEZjoYs/2Sg3eQuKwyfLL2d2IkTcLEX/VXhOUEr1GE+CTt5+X
	T/HNJtkZi0ji5B0bC+lAqWY/7SMm3cS9dr5lyAoeMlqiFdLfQwVhi/CJzIcpqsE/pEkP8FicY5l
	20p+UBtjZQDqujFQyJnQSQmlvPncCT
X-Received: by 2002:a05:600c:5486:b0:495:7040:c7e9 with SMTP id 5b1f17b1804b1-496c6414bddmr31261065e9.6.1785253751459;
        Tue, 28 Jul 2026 08:49:11 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([37.161.95.51])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm94912035e9.15.2026.07.28.08.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:49:10 -0700 (PDT)
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
Subject: [PATCH net-next v19 03/10] dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
Date: Tue, 28 Jul 2026 17:48:30 +0200
Message-ID: <20260728154846.1828945-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
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
 .../bindings/mfd/airoha,an8855.yaml           | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
new file mode 100644
index 000000000000..647d6d4c4c6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
@@ -0,0 +1,173 @@
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
+    $ref: /schemas/net/mdio.yaml#
+    description: MDIO exposed by the Airoha AN8855 SoC
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
+            reset-gpios = <&pio 39 0>;
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

