Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51B30AAA9
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621287; cv=none; b=gsk1DUMLAFiCdJUYxkFhT36PX335jOFrV97Na8BDRCA6I14u9UWxQFkyYm0pFumpiDQ2/GfLUJQTJFG9XZROQlX5rvPeCQNKpYJQBBCniT92w/RWckFY/qiAD8HxkEDGXLr1v9I9lPgC+rEupdlXSijmY0LZh2TiQK45DL6VRmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621287; c=relaxed/simple;
	bh=Q/ZNVyWH5+7aUXeLq9mlW50Vwgq0fqg1xk8VkFefUX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEn9Wcb5iI3ZI3C1w7VTxzuUKoSpXFLwMEU22R6tRDClF9VcQEn5vef21qHWeDUtCgA6obsZbb4SDN/tguGIqrLbPG3JErMSj/+aDcSYYdY2Kf1pWAuqIDsju79iEfpbAxzTXDmdEvJZ/6Ft2fLewQMf84ifG0ZqNYoBDpJdVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=VBA0oiYL; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="VBA0oiYL"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-486118ecd5dso877146b6e.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780621260; x=1781226060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZIGHz/o3y+3ogj7r6nfssUl4myckUIIzkFFbrT9qoc=;
        b=VBA0oiYLEp5RT1MN3a1hVsJ8aRjH4SnEjm8N5ALMhxnEZFGvXRgXW34Zan/sKl+2x5
         deTqZHtZXgnm2dOSmEAm+PTuNrLpnF1OsuLx6ixjUnOyTcyesBZe5KEwogK+OY9HEu66
         rVMgEtkStXsK3Pj5d3ODn57cpdsvFOgeritiO7eAdpEbwCcRelRrDh38Av2IqceiEWlf
         594CitBmTaWgZU0eG+zjXP9rq9k++r7nyvZo3wJMZ3VfKBGJr/8Yn5uksoGqC/0LZcun
         PeQsD6SW9F3FTfxRr2T7e/Bo6u7mP9nOo1jfT+QxRPIk6VL7pqNDdqEVS5yk7//ZAhMQ
         9g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621260; x=1781226060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZIGHz/o3y+3ogj7r6nfssUl4myckUIIzkFFbrT9qoc=;
        b=YzEyXC9OM7eVxc4OcdLNVXm4YEzWRyE597nW5EILzkYSCYVB6YiMqlD+Y11hFm5B0H
         WweHp9XssJQCgHdndumIPpOl3qWYkkzVN22bCS216yMNMB+hQnpZRl9jkUxdCqOhUDLU
         plI9jeCwJZ1hhM7jvGXSxx625RDKMfeQJniq3DsOeTICcw1hV1iYdh8NhcdhXM8+9ykH
         7bVXFxpw1ZjV9fctTEA+RYZCrmiX5craD/X2/7KwVC5VcTLlZu5C8YAN71Mh/ScPvXge
         w1ElZrU2Aj3/DshF1RtgX69KQ40Cqpq6bbh4rqzY2KlLnaqxLFg0Bwil6H37MKrg7liH
         WQbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jIC+CpeTKR15V6PtboMUFd8p02AryflvZGI/mFHmu8aO2NPGBziHKoLoTip3WI9ilYCwvaW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylO0ZeWku0S/I6OUZ48gfexP4M4QPh1gt2zkeQbCR79GoVrF+6
	xUoC4V0eBFPRieS/35b8zDbTNviv/n6AcU3qgtHJU3QvwXuQoGxCG/MTAWDK6vRhJgI=
X-Gm-Gg: Acq92OHJCWH2GQEDbAQDcY3swQkkdCUX5eLdvErk68uH24d24B/soCUNFg7xQfgm8FR
	i8BpY9EDXkU+tsyid3qQKD0y769jE+RuGCuE4UWyeTIdSjW+pmiSY77qXM0ENBj34jK/rXrFEkw
	ZEGm3YwvYwvheuawUeDInejysApUMUbkSC+hAFnnvdMkSNrl4rSRbXpxhgu/rwCEmCQvIPwmbWI
	BWlhfzOZv2HBlXOXpjugRo4FhaBhj6GNeakEVUB8666pPFenVOl6ZLMXpbMXNa5VjEhzvMh8seR
	h977BgaOAdxNn8B3Lw3G41gSDP0RhjwoYQO84uAVHLmtvlujDVIlqrK1bAdu8T3NbR6Wq/rAnoV
	NPyyZJCS73NW9zV9dP7uLcJNkEv5Oyz1yMsLLlE8kaM5DCbrkgUwXTkgb+E2okodhChlgMPJQE6
	iaqx7Z9W1+RlHv8BvYczjcX0vaE1bIUfin1V99Vw==
X-Received: by 2002:a05:6808:11cb:b0:467:de0e:feb6 with SMTP id 5614622812f47-4868dc583f1mr883548b6e.11.1780621259486;
        Thu, 04 Jun 2026 18:00:59 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b6ec694sm5544631b6e.5.2026.06.04.18.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:00:59 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 10/14] dt-bindings: net: toshiba,tc9654-dwmac: add TC9564 Ethernet bridge
Date: Thu,  4 Jun 2026 20:00:17 -0500
Message-ID: <20260605010022.968612-11-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605010022.968612-1-elder@riscstar.com>
References: <20260605010022.968612-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
bridges.

The TC9564 contains a PCIe switch with one upstream and three downstream
PCIe ports.  The third PCIe downstream port has an attached embedded PCIe
endpoint, and that endpoint implements two PCIe functions.  Each internal
PCIe function has a Synopsys XGMAC Ethernet interface capable of 10 Gbps
operation.

The TC9564 also implements an embedded GPIO controller, which exposes
10 lines externally.  Some platforms use these GPIO lines, so this
GPIO controller is managed by a separate driver.  Other embedded
peripherals (like a microcontroller, SRAM, and UART) are currently
unused.

The GPIO controller is managed by registers accessed via MMIO on an
internal PCIe function's registers.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/net/toshiba,tc9564-dwmac.yaml    | 120 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
new file mode 100644
index 0000000000000..6e7a63dfcf86a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/toshiba,tc9564-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC956x Ethernet-AVB/TSN Controller
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+  - Daniel Thompson <daniel@riscstar.com>
+
+description: |
+  The Toshiba TC9564 (and more generally, TC956x) incorporates a PCIe
+  gen 3 switch with one upstream and three downstream ports.  The first
+  two downstream ports are exposed externally, while the third is used
+  by an internal PCIe endpoint.  The PCIe endpoint implements two PCIe
+  functions, and attached to each of these is a 10 Gbps capable Synopsys
+  Ethernet controller.
+
+  The TC956x additionally implements other internal IP blocks, and in
+  particular it implements a GPIO controller.  Ten of the 35 GPIO lines
+  implemented are exposed externally and are usable by the platform.
+  It is platform-dependent whether the GPIO function must be exposed,
+  and if it is, PCIe function 0 supplies it.
+
+              ----------------------------------
+              |              Host              |
+              ------+...+----------+........+---
+                    |i2c|          |  PCIe  |
+    ----------------+...+----------+........+------
+    | TC956x        |I2C|          |upstream|     |
+    |               -----        --+--------+---  |
+    |  -----  ------  -------    | PCIe switch |  |
+    |  |SPI|  |GPIO|  |reset|    |             |  |
+    |  -----  ------  |clock|    | DS3 DS2 DS1 |  |
+    |                 -------    ---++--++--++--  |
+    |  -----  ------     downstream//    \\  \\   |  downstream
+    |  |MCU|  |SRAM|    /==========/      \\  \===== PCIe port 1
+    |  -----  ------   //PCIe port 3       \\     |
+    |                  ||                   \======= downstream
+    |  ----+-----------++-----------+----         |  PCIe port 2
+    |  | M | internal PCIe endpoint | M |         |
+    |  | S |------------------------| S |  ------ |
+    |  | I |   PCIe   |  |   PCIe   | I |  |UART| |
+    |  | G |function 0|  |function 1| G |  ------ |
+    |  | E |----++----|  |----++----| E |         |
+    |  | N |  eMAC 0  |  |  eMAC 1  | N |         |
+    --------+.......+------+.....+-----------------
+            |USXGMII|      |SGMII|
+          --+.......+--  --+.....+--
+          |  ARQ113C  |  | QEP8121 |
+          |    PHY    |  |   PHY   |
+          -------------  -----------
+
+properties:
+  compatible:
+    enum:
+      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
+
+  gpio:
+    type: object
+    description: Embedded GPIO controller
+    $ref: /schemas/gpio/gpio.yaml#
+
+  ethernet:
+    type: object
+    description: XGMAC Ethernet controller
+    $ref: /schemas/net/ethernet-controller.yaml#
+    properties:
+      mdio:
+        $ref: snps,dwmac.yaml#/properties/mdio
+    required:
+      - mdio
+
+required:
+  - compatible
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml#
+  - $ref: /schemas/pci/pci-bus-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pci@0,0 {
+            compatible = "pci1179,0220";
+            reg = <0x50000 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges;
+
+            gpio {
+                  gpio-controller;
+                  #gpio-cells = <2>;
+            };
+
+            ethernet {
+                phy-mode = "10gbase-r";
+                phy-handle = <&tc9564_emac0_phy>;
+
+                mdio {
+                  compatible = "snps,dwmac-mdio";
+                  #address-cells = <1>;
+                  #size-cells = <0>;
+
+                  tc9564_emac0_phy: ethernet-phy@1c {
+                      compatible = "ethernet-phy-id311c.1c12";
+                      reg = <0x1c>;
+                  };
+              };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2aa6ea012c848..f976c9fa9d9c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27052,6 +27052,12 @@ F:	Documentation/devicetree/bindings/media/i2c/toshiba,tc358743.txt
 F:	drivers/media/i2c/tc358743*
 F:	include/media/i2c/tc358743.h
 
+TOSHIBA TC956X/QUALCOMM QPS615 DWMAC ETHERNET DRIVER
+M:	Alex Elder <elder@kernel.org>
+M:	Daniel Thompson <danielt@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
+
 TOSHIBA WMI HOTKEYS DRIVER
 M:	Azael Avalos <coproscefalo@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.51.0

