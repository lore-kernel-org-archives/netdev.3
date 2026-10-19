Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDC3955FD
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378899; cv=none; b=jNvd5bJRxCKwiAGI45dg4kKIf6nG/6tsO2F9LEgjlkhBGjfr99BwHfzo0UhrDDgDE5KLYvF42ZoOD1vVK5ubCbzaRJtPm8YI9YiWQirOozd6m/JWFtcTtHVRd5DYH/xaT/L+wsSbwFDgsNMaacIq8/36n8ciGgfjNgUYy44G7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378899; c=relaxed/simple;
	bh=gsMbfD7Oz7AXyUBm/3hHxEyeYa4XS0HrtVmKM0TiRuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8lsFFszztTpMBHrFJrQboA9/zRQ7dl/pDJAPINZmHifWVwJrJ0qzNmO8OiebFlv74Sh6ATBIYdUh+1/4oqfvqc9vPnuA65XvHOC2kixUXqVNJLvrVS/N3tpvXgJISrlTolh9OUyP4Cz2F8UUDjYfngMM8K0hg5HIyXBiDMnkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=FeLnDBGL; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="FeLnDBGL"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917bab38b14so17682736d6.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792378895; x=1792983695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZXMPOwO5URaUWXudb6WIYNl+wUSYFfStSEDQV6YfRwU=;
        b=FeLnDBGLOz+G3ZR6iW/2ypFEZnF01Q/zRV1u8Dhb807xhGUcv+/OUnd1cqH0dOsLEJ
         aEWbhnnWO7JlWnwxtFbM+pHlXYjmxPMcQWCpIU12/1vufKQG2DIC17EOGB+5EaMEJcyy
         f0REb5l+3ihethjjx7MDvvcDzesUTuNyW5EOfesfvM5jEcNvWkRrcR1tQrhoiIGAmrpj
         3tMyUOCarkEqAEC/OqOAziKe0Dn2aWKbUWScpZmSRjF/7VT32UNMHo0vob2JyKcIKNxM
         RPtp0OFLP/8zU6kg8mjOA0Bsi4CkwNttMp6QHfIu/LiUEklFavIyl6yDToPpPghxj5yM
         nLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378895; x=1792983695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZXMPOwO5URaUWXudb6WIYNl+wUSYFfStSEDQV6YfRwU=;
        b=kOb8XTC3hspk/mLuZzzugklAdi7yEFK/4CiAHBqUTxNv4V50irTWl3zzat6SyR1+5C
         kpyMh4/CMDmv359b5qwFA9Ilc+1VWRKRfz6Xm4tsOAuzFcAOpXQxsASzjnEs6yKIfEf7
         Jneq8+I/M1VwD3sfFRHjnXHX6q2XtzBGNCTQh3Qz4wInnv8CZcMBtlnxm+UDTGtL95bj
         qet1hkg4ZCm/FOPFblFcTvFHveRBe94TcH8D4XqIn025RSLWzDT2ZJBYtvWZN5twxkqK
         RnOXpvsSpdyoRktGZKHQKgC0G6PMPJP+9EAXsWhmGIuCyGMo+ie95ouVcbIUYDmzhW92
         IaIQ==
X-Forwarded-Encrypted: i=1; AKwUvByeCFG05MEt75JeQF9wkqjUFlJhiOwHVIBmY9EoxF50CbL8UL32GjiGj4kBxo2GBkGwskL4rLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHNwC8PmvBNZvkuGNRrUbC2jwIXYeaYObHW2tQgpCnSINi4Lqd
	bILy0kFwBrR07+sKGnygy7OZF6f5EufRkHxsVBwzkHz9j3PdHprEp3LcnF46OXLtINk=
X-Gm-Gg: AYBFou3k3Voe04MCuU+55j6rXHff7Nsvvg4nLxhWp/GzDQreZz2pU+TFA6DCUBwkSDm
	kFjwM2nefjZxwApOMrlgYSyRxbaFH5W7zisooT2Vv2rzYhfTdhpaWxTsRee/tda2TfMxay0GE5s
	+PbxpREfVjBLGexC4hqmZ3H5zd/dHqmZh5WtvV0HndfaAtmsC+ESXYHXCmOpBxbRbjoE2Kabvk/
	n/etn4n9rEvQWHlOoUMlSQ+dfaTpWSr3RSWtuXO45V895ErE1f6fN2LkwN1ePb2vdw02l+9uIXe
	MsRChoB8FVvGG4Ec0Rew8kekpjqS+/JlpG5ktRWr0GAGDQ0Au2cXtnCFyeS0hIfYjjZck+MXh15
	LItaefNdTdhIf+IwaJQGNZO9qUFhVAW55kWcvzQz/1ldACMl6v+cTU0uhh5Ch3x3fGUplvDCnvT
	r4ozPfrW2bvax09fKZe3iSQIVe4DUOJuMeFUEmEAMFQWxrx6dKYs6ra6JSPcum2q40S4ckg37RK
	pU=
X-Received: by 2002:a05:620a:27d0:b0:93f:1936:b229 with SMTP id af79cd13be357-93f29dbec24mr972782385a.77.1792378895343;
        Sun, 18 Oct 2026 20:01:35 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3c61c440sm216840185a.10.2026.10.18.20.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:01:34 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	peppe.cavallaro@st.com,
	joabreu@synopsys.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	daniel@riscstar.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dt-bindings: net: add support for Toshiba TC9564
Date: Sun, 18 Oct 2026 22:01:24 -0500
Message-ID: <20261019030129.1470307-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019030129.1470307-1-elder@riscstar.com>
References: <20261019030129.1470307-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Toshiba TC9564 is an SoC that exposes two XGMAC 10 Gbps Ethernet
interfaces, each of which is attached to an embedded PCIe function.

These XGMAC interfaces have three resets, for the MAC, PMA, and XPCS
layers.  These resets differ from the standard two resets defined
in "snps,dwmac.yaml".

To permit these other resets to be used, modify the way resets are
defined in "snps,dwmac.yaml" to be similar to the way interrupts and
their names are defined earlier in the file.  That is, rather than
adding descriptions with the resets property values, just specify the
maximum number of items.  Then, in the reset-names property, provide
a list of description/constant value pairs, indicating which renames
may be used among the (three) reset items specified.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  26 +-
 .../bindings/net/toshiba,tc9564-xgmac.yaml    | 327 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 3 files changed, 351 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2218a492817fd..ace827ee4eb6c 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -120,6 +120,7 @@ properties:
         - starfive,jh7110-dwmac
         - tesla,fsd-ethqos
         - thead,th1520-gmac
+        - toshiba,tc9564-xgmac
         - ultrarisc,dp1000-gmac
 
   reg:
@@ -174,17 +175,24 @@ properties:
 
   resets:
     minItems: 1
-    items:
-      - description: GMAC stmmaceth reset
-      - description: AHB or OCP reset
+    maxItems: 3
 
   reset-names:
-    oneOf:
-      - items:
-          - enum: [stmmaceth, ahb]
-      - items:
-          - const: stmmaceth
-          - enum: [ahb, stmmaceth-ocp]
+    maxItems: 3
+    items:
+      - oneOf:
+          - description: GMAC stmmaceth reset
+            const: stmmaceth
+          - description: AHB reset
+            const: ahb
+          - description: MAC reset
+            const: mac-reset
+          - description: PMA (Physical Medium Attachment) reset
+            const: pma-reset
+          - description: XPCS reset
+            const: xpcs-reset
+          - description: OCP reset (deprecated)
+            const: stmmaceth-ocp
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.yaml
new file mode 100644
index 0000000000000..9c494d216c3a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/toshiba,tc9564-xgmac.yaml
@@ -0,0 +1,327 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/toshiba,tc9564-xgmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9564 XGMAC Ethernet Controller
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
+  - Alex Elder <elder@riscstar.com>
+  - Daniel Thompson <daniel@riscstar.com>
+
+description:
+  This binding describes the Toshiba TC9564 SoC implementation of the
+  Synopsys XGMAC Ethernet controller.
+
+  The Toshiba TC9564 incorporates a PCIe gen 3 switch with one upstream
+  and three downstream ports.  The first two downstream ports are exposed
+  externally, while the third is used by an internal PCIe endpoint.  The
+  PCIe endpoint implements two PCIe functions, and attached to each of
+  these is a 10 Gbps capable Synopsys XGMAC Ethernet controller.  Access
+  to management registers for each controller is via BAR 4 of its
+  respective PCI function.
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: toshiba,tc9564-xgmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    const: toshiba,tc9564-xgmac
+
+  reg:
+    maxItems: 1
+
+  toshiba,config-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The phandle and offset for a syscon that provides access to a
+      register containing a bit that indicates that PMA initialization
+      is done.
+    maxItems: 1
+
+  clocks:
+    minItems: 5
+    items:
+      - description: MAC main clock (125 MHz)
+      - description: PTP reference clock (250 MHz)
+      - description: MAC TX clock
+      - description: MAC RX clock
+      - description: MAC all clock gate
+      - description: MAC RMII clock (function 1 only)
+
+  clock-names:
+    minItems: 5
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+      - const: mac-tx-clock
+      - const: mac-rx-clock
+      - const: mac-all-clock
+      - const: mac-rmii-clock
+
+  resets:
+    items:
+      - description: MAC reset
+      - description: PMA (Physical Medium Attachment) reset
+      - description: XPCS reset
+
+  reset-names:
+    items:
+      - const: mac-reset
+      - const: pma-reset
+      - const: xpcs-reset
+
+  interrupts:
+    minItems: 17
+    maxItems: 17
+
+  interrupt-names:
+    minItems: 17
+    maxItems: 17
+
+  snps,tso:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable TCP segmentation offload.
+
+  snps,pbl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Set the programmable burst length.
+
+  snps,force_sf_dma_mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Force store-and-forward mode for both TX and RX DMA.
+
+  snps,perfect-filter-entries:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Set the number of perfect filter entries supported.
+
+  snps,mtl-rx-config:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a rx-queues-config node that describes the RX queues
+      managed by the stmmac memory transfer layer.
+
+  snps,mtl-tx-config:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a tx-queues-config node that describes the TX queues
+      managed by the stmmac memory transfer layer.
+
+  rx-fifo-depth:
+    $ref: /schemas/net/ethernet-controller.yaml#/properties/rx-fifo-depth
+    maximum: 47104
+    description:
+      RX FIFO size in bytes.  This must be set explicitly because
+      the size (46KB) differs from the power-of-2 indicated by the
+      HW_FEATURE0 register, so the size is not accurately detected.
+
+  tx-fifo-depth:
+    $ref: /schemas/net/ethernet-controller.yaml#/properties/tx-fifo-depth
+    maximum: 47104
+    description:
+      TX FIFO size in bytes.  This must be set explicitly because
+      the size (46KB) differs from the power-of-2 indicated by the
+      HW_FEATURE0 register, so the size is not accurately detected.
+
+  snps,axi-config:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a node describing AXI burst configuration.
+
+  iommus:
+    maxItems: 1
+
+  phy-mode:
+    const: sgmii
+
+  phy-handle: true
+
+  tx-queues-config:
+    $ref: /schemas/net/snps,dwmac.yaml#/properties/tx-queues-config
+
+  rx-queues-config:
+    $ref: /schemas/net/snps,dwmac.yaml#/properties/rx-queues-config
+
+  stmmac-axi-config:
+    $ref: /schemas/net/snps,dwmac-common.yaml#/properties/stmmac-axi-config
+
+  mdio:
+    $ref: /schemas/net/snps,dwmac.yaml#/properties/mdio
+
+required:
+  - toshiba,config-syscon
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - rx-fifo-depth
+  - tx-fifo-depth
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet@48000 {
+        compatible = "toshiba,tc9564-xgmac";
+        reg = <0x48000 0x8000>;
+        toshiba,config-syscon = <&tc9564_config_syscon0 0x1074>;
+
+        clocks = <&tc9564_ref_125mhz_clk>,
+                 <&tc9564_ref_250mhz_clk>,
+                 <&tc9564_clock0 13>,
+                 <&tc9564_clock0 14>,
+                 <&tc9564_clock0 18>,
+                 <&tc9564_clock0 15>;
+        clock-names = "stmmaceth",
+                      "ptp_ref",
+                      "mac-tx-clock",
+                      "mac-rx-clock",
+                      "mac-all-clock",
+                      "mac-rmii-clock";
+
+        resets = <&tc9564_reset0 8>,
+                 <&tc9564_reset0 9>,
+                 <&tc9564_reset0 10>;
+        reset-names = "mac-reset",
+                      "pma-reset",
+                      "xpcs-reset";
+
+        interrupts-extended = <&tc9564_msigen1 2>,
+                              <&tc9564_msigen1 3>,
+                              <&tc9564_msigen1 4>,
+                              <&tc9564_msigen1 5>,
+                              <&tc9564_msigen1 6>,
+                              <&tc9564_msigen1 7>,
+                              <&tc9564_msigen1 8>,
+                              <&tc9564_msigen1 9>,
+                              <&tc9564_msigen1 10>,
+                              <&tc9564_msigen1 11>,
+                              <&tc9564_msigen1 12>,
+                              <&tc9564_msigen1 13>,
+                              <&tc9564_msigen1 14>,
+                              <&tc9564_msigen1 15>,
+                              <&tc9564_msigen1 16>,
+                              <&tc9564_msigen1 17>,
+                              <&tc9564_msigen1 18>;
+        interrupt-names = "macirq",
+                          "tx-queue-0",
+                          "tx-queue-1",
+                          "tx-queue-2",
+                          "tx-queue-3",
+                          "tx-queue-4",
+                          "tx-queue-5",
+                          "tx-queue-6",
+                          "tx-queue-7",
+                          "rx-queue-0",
+                          "rx-queue-1",
+                          "rx-queue-2",
+                          "rx-queue-3",
+                          "rx-queue-4",
+                          "rx-queue-5",
+                          "rx-queue-6",
+                          "rx-queue-7";
+
+        snps,tso;
+        snps,pbl = <32>;
+        snps,force_sf_dma_mode;
+        snps,perfect-filter-entries = <32>;
+
+        snps,mtl-rx-config = <&tc9564_mtl_rx_emac1_setup>;
+        snps,mtl-tx-config = <&tc9564_mtl_tx_emac1_setup>;
+        rx-fifo-depth = <32768>;
+        tx-fifo-depth = <32768>;
+
+        snps,axi-config = <&tc9564_axi_emac1_setup>;
+
+        /* SID comes from the iommu-map for &pcie1 */
+        iommus = <&apps_smmu 0x1c90 0x0>;
+
+        phy-mode = "sgmii";
+        phy-handle = <&tc9564_emac1_phy>;
+
+        tc9564_mtl_rx_emac1_setup: rx-queues-config {
+            snps,rx-queues-to-use = <4>;
+            snps,rx-sched-sp;
+            queue0 {
+                snps,dcb-algorithm;
+                snps,map-to-dma-channel = <0x0>;
+            };
+            queue1 {
+                snps,dcb-algorithm;
+                snps,map-to-dma-channel = <0x1>;
+            };
+            queue2 {
+                snps,dcb-algorithm;
+                snps,map-to-dma-channel = <0x2>;
+            };
+            queue3 {
+                snps,dcb-algorithm;
+                snps,map-to-dma-channel = <0x3>;
+            };
+        };
+
+        tc9564_mtl_tx_emac1_setup: tx-queues-config {
+            snps,tx-queues-to-use = <4>;
+            snps,tx-sched-wrr;
+            queue0 {
+                snps,weight = <0x0c>;
+                snps,dcb-algorithm;
+            };
+            queue1 {
+                snps,weight = <0x0c>;
+                snps,dcb-algorithm;
+            };
+            queue2 {
+                snps,weight = <0x0c>;
+                snps,dcb-algorithm;
+            };
+            queue3 {
+                snps,weight = <0x0c>;
+                snps,dcb-algorithm;
+            };
+        };
+
+        tc9564_axi_emac1_setup: stmmac-axi-config {
+            snps,lpi_en;
+            snps,wr_osr_lmt = <31>;
+            snps,rd_osr_lmt = <31>;
+            snps,blen = <256 128 64 32 16 8 4>;
+        };
+
+        mdio {
+            compatible = "snps,dwmac-mdio";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            tc9564_emac1_phy: ethernet-phy@1c {
+                compatible = "ethernet-phy-id004d.d101";
+                reg = <0x1c>;
+
+                reset-assert-us = <11000>;
+                reset-deassert-us = <70000>;
+
+                vdd18-supply = <&qep_1p8>;
+
+                pinctrl-names = "default";
+                pinctrl-0 = <&qep_irq_pin>;
+                interrupts-extended = <&tlmm 101 IRQ_TYPE_LEVEL_LOW>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 149bc44003bda..55ead3d1007a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28305,6 +28305,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/misc/pci1179,0220.yaml
 F:	drivers/misc/tc9564-pci.c
 
+TOSHIBA TC9564 DWMAC ETHERNET DRIVER
+M:	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
+M:	Alex Elder <elder@kernel.org>
+M:	Daniel Thompson <danielt@kernel.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
+
 TOSHIBA WMI HOTKEYS DRIVER
 M:	Azael Avalos <coproscefalo@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.53.0

