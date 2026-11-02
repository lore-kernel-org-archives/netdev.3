Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651649;
	b=PzabUkB51xLreLpbEq9vpidoKMK9/GkYZTdj7qoXZNijf16R67/5TLPLK28du9/+N1q+
	 KTBvmdsse3h0QfbR8kiJIVU/qnSRobNvLDiL9+/2znxnTiFsvkf6pgmbinno4kf80W4GA
	 uoa97qL79CYWTeQbBIU4CkQFCvsAXuHMOt7LN+ba2cix7MDVfQIBNiLOHbyPm5WI0tTaX
	 kTm5pwUmxgEPJScbSOUVDXqDTtWO8BvdZwynEa3VLAn2EtPBgKZnFu01Y0BWs27s0wRCI
	 zuDtOY94jSurPi6GwsXdp83CfI7JgdtNYVPNDNBNMEKx6uB6BNtiSfupzuNzXuLdGzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3PSUijTUw6iX8c0lN+QnpSmSK0z2YWVF8UoIrBp4Y20=;
	b=zWuVAIWggKRNkZ5z64VchFfrC1egJQpEXBt7okZUfHyeIj8idZU1pUJuSu1Z3DckvQgy
	 7lJRosrS7ToCLhKG20zx/l+9gk8bzBMtt2Ui2x7v/0J5yR7NvRDQiJf4KpxWWdS9PvX+R
	 GnKhGzuptspIsHAlZwjt9oiP7mQFYkRYwiDJ2R1VC7PO8K/xIVEtHwbd2VrEL/hyCmJEm
	 f1aC3reqx/6Wd1DpRXzzjJEmsu23cEaq8bxgjDdeG4SeRZRw7f2Mw4zoW83zDE0OFw1yG
	 VhUD2No2jtrcFGBuK2TpB/+vpka4rMeU+cTY5qMtZlWuq3Ow/NnG9yP9nclOv0cKihg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYRKrlJs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B0606A326;
	Mon,  2 Nov 2026 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYRKrlJs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC45C1F00A16;
	Mon,  2 Nov 2026 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651648;
	bh=3PSUijTUw6iX8c0lN+QnpSmSK0z2YWVF8UoIrBp4Y20=;
	h=From:To:Cc:Subject:Date;
	b=GYRKrlJsTvuIm47HV36H5EA1UiUxVdZDBdpFigbXI2c0NGJRt4a4zHX6kr+qN+wxF
	 pROygEnsvcTiYkQ0DlOaoAoZhE2UdPTgOsG2EPVYfhU/AFUa8Lvf8bEAJEQ+2hgfAL
	 IrkQKpWDyIcn2XBuCgOni3f22YxZXszBJsyeugrmWNhX90ltQWMbSgrS9SoBnQ/6Al
	 mi1GKLd/E64d8UJM9kwiBScBFnTDxhmf4U+MPlyEbOHVscex9V+JBRw+VdRLS5QDVo
	 01il3SN1k3C5CPfQE+scU97y09WtgMoUxrMRNCQ2ZJzpff0aXQ+c/jFGAN+4WJ/vSD
	 47UMpdn72Ts2A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: Convert snps,dwc-qos-ethernet to DT schema
Date: Mon,  2 Nov 2026 14:33:50 -0600
Message-ID: <20261102203353.1384705-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the "snps,dwc-qos-ethernet-4.10" binding to DT schema format.
The binding uses several common snps,dwmac properties, so move them to
the snps,dwmac-common.yaml schema.

Drop support for standalone "snps,dwc-qos-ethernet-4.10" compatible
and "axis,artpec6-eqos" as there are no users. Also drop the
"snps,dwc-qos-ethernet-mdio" as it is also unused. Add the interconnects
and iommus properties. Replaced the example with one from Tegra186.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../net/snps,dwc-qos-ethernet-4.10.yaml       | 225 ++++++++++++++++++
 .../bindings/net/snps,dwc-qos-ethernet.txt    | 168 -------------
 .../bindings/net/snps,dwmac-common.yaml       |  20 ++
 .../devicetree/bindings/net/snps,dwmac.yaml   |  20 --
 4 files changed, 245 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet-4.10.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt

diff --git a/Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet-4.10.yaml b/Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet-4.10.yaml
new file mode 100644
index 000000000000..65de926af2a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet-4.10.yaml
@@ -0,0 +1,225 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/snps,dwc-qos-ethernet-4.10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC Ethernet QoS IP version 4.10 (GMAC)
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+description: >
+  The IP supports multiple options for bus type, clocking and reset structure,
+  and feature list. Consequently, a number of properties and list entries in
+  properties are marked as optional, or only required in specific HW
+  configurations.
+
+  This binding is deprecated, but it continues to be supported, but new features
+  should be preferably added to the stmmac binding document.
+
+deprecated: true
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: nvidia,tegra186-eqos
+          - const: snps,dwc-qos-ethernet-4.10
+      - items:
+          - const: nvidia,tegra194-eqos
+          - const: nvidia,tegra186-eqos
+          - const: snps,dwc-qos-ethernet-4.10
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 5
+    items:
+      - description:
+          The master bus interface clock. Only required in configurations that
+          use a separate clock for the master and slave bus interfaces. The HW
+          signal name is hclk_i (AHB) or aclk_i (AXI).
+      - description:
+          The CPU/slave-bus (CSR) interface clock. This applies to any bus type;
+          APB, AHB, AXI, etc. The HW signal name is hclk_i (AHB) or clk_csr_i
+          (other buses).
+      - description: >
+          The EQOS receive path clock. The HW signal name is clk_rx_i. In some
+          configurations (e.g. GMII/RGMII), this clock is derived from the PHY's
+          RX clock output. In other configurations, other clocks (such as
+          rx_125, rmii) may drive the EQOS RX path.
+
+          In cases where the PHY clock is directly fed into the EQOS receive
+          path without intervening logic, the DT need not represent this clock,
+          since it is assumed to be fully under the control of the PHY
+          device/driver. In cases where SoC integration adds additional logic to
+          this path, such as a SW-controlled clock gate, this clock should be
+          represented in DT.
+      - description: >
+          The EQOS transmit path clock. The HW signal name is clk_tx_i.
+
+          In some configurations (e.g. GMII/RGMII), this clock also drives the
+          PHY TX path. In other configurations, other clocks (such as tx_125,
+          rmii) may drive the PHY TX path.
+      - description:
+          The PTP reference clock. The HW signal name is clk_ptp_ref_i.
+    description: >
+      Support for additional IP configurations may require adding the following
+      clocks to this list in the future: clk_rx_125_i, clk_tx_125_i,
+      clk_pmarx_0_i, clk_pmarx1_i, clk_rmii_i, clk_revmii_rx_i, clk_revmii_tx_i.
+      Configurations exist where multiple similar clocks are used at once, e.g.
+      all of clk_rx_125_i, clk_pmarx_0_i, clk_pmarx1_i. For this reason it is
+      best to extend the binding with a separate clock-names entry for each of
+      those RX clocks, rather than repurposing the existing "rx" clock-names
+      entry as a generic/logical clock in a similar fashion to "master_bus" and
+      "slave_bus". This will allow easy support for configurations that support
+      multiple PHY interfaces using a mux, and hence need to have explicit
+      control over specific RX clocks.
+
+  clock-names:
+    items:
+      - const: master_bus
+      - const: slave_bus
+      - const: rx
+      - const: tx
+      - const: ptp_ref
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: common
+      - description: power
+      - description: rx0
+      - description: tx0
+      - description: rx1
+      - description: tx1
+      - description: rx2
+      - description: tx2
+      - description: rx3
+      - description: tx3
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: eqos
+
+  dma-coherent: true
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  iommus:
+    maxItems: 1
+
+  phy-reset-gpios:
+    description: Phandle and specifier for any GPIO used to reset the PHY
+    maxItems: 1
+
+  snps,en-lpi:
+    description: If present it enables use of the AXI low-power interface
+    type: boolean
+
+  snps,write-requests:
+    description: Number of write requests that the AXI port can issue
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  snps,read-requests:
+    description: Number of read requests that the AXI port can issue
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  snps,burst-map:
+    description:
+      Bitmap of allowed AXI burst lengths, with the LSB representing 4, then
+      8 etc.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+  - reset-names
+  - phy-mode
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/net/snps,dwmac-common.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/tegra186-gpio.h>
+    #include <dt-bindings/clock/tegra186-clock.h>
+    #include <dt-bindings/reset/tegra186-reset.h>
+    #include <dt-bindings/memory/tegra186-mc.h>
+
+    ethernet@2490000 {
+        compatible = "nvidia,tegra186-eqos",
+                     "snps,dwc-qos-ethernet-4.10";
+        reg = <0x02490000 0x10000>;
+        interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* common */
+                     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>, /* power */
+                     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>, /* rx0 */
+                     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>, /* tx0 */
+                     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>, /* rx1 */
+                     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>, /* tx1 */
+                     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* rx2 */
+                     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* tx2 */
+                     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* rx3 */
+                     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>; /* tx3 */
+        clocks = <&bpmp TEGRA186_CLK_AXI_CBB>,
+                 <&bpmp TEGRA186_CLK_EQOS_AXI>,
+                 <&bpmp TEGRA186_CLK_EQOS_RX>,
+                 <&bpmp TEGRA186_CLK_EQOS_TX>,
+                 <&bpmp TEGRA186_CLK_EQOS_PTP_REF>;
+        clock-names = "master_bus", "slave_bus", "rx", "tx", "ptp_ref";
+        resets = <&bpmp TEGRA186_RESET_EQOS>;
+        reset-names = "eqos";
+        interconnects = <&mc TEGRA186_MEMORY_CLIENT_EQOSR &emc>,
+                        <&mc TEGRA186_MEMORY_CLIENT_EQOSW &emc>;
+        interconnect-names = "dma-mem", "write";
+        iommus = <&smmu TEGRA186_SID_EQOS>;
+
+        snps,write-requests = <1>;
+        snps,read-requests = <3>;
+        snps,burst-map = <0x7>;
+        snps,txpbl = <32>;
+        snps,rxpbl = <8>;
+
+        phy-reset-gpios = <&gpio_aon TEGRA186_AON_GPIO(AA, 6) GPIO_ACTIVE_LOW>;
+        phy-handle = <&phy>;
+        phy-mode = "rgmii-id";
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy: ethernet-phy@0 {
+                compatible = "ethernet-phy-ieee802.3-c22";
+                reg = <0x0>;
+                interrupt-parent = <&gpio_aon>;
+                interrupts = <TEGRA186_AON_GPIO(AA, 7) IRQ_TYPE_LEVEL_LOW>;
+                #phy-cells = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt b/Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt
deleted file mode 100644
index bb0224a3e826..000000000000
--- a/Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt
+++ /dev/null
@@ -1,168 +0,0 @@
-* Synopsys DWC Ethernet QoS IP version 4.10 driver (GMAC)
-
-This binding is deprecated, but it continues to be supported, but new
-features should be preferably added to the stmmac binding document.
-
-This binding supports the Synopsys Designware Ethernet QoS (Quality Of Service)
-IP block. The IP supports multiple options for bus type, clocking and reset
-structure, and feature list. Consequently, a number of properties and list
-entries in properties are marked as optional, or only required in specific HW
-configurations.
-
-Required properties:
-- compatible: One of:
-  - "axis,artpec6-eqos", "snps,dwc-qos-ethernet-4.10"
-    Represents the IP core when integrated into the Axis ARTPEC-6 SoC.
-  - "nvidia,tegra186-eqos", "snps,dwc-qos-ethernet-4.10"
-    Represents the IP core when integrated into the NVIDIA Tegra186 SoC.
-  - "snps,dwc-qos-ethernet-4.10"
-    This combination is deprecated. It should be treated as equivalent to
-    "axis,artpec6-eqos", "snps,dwc-qos-ethernet-4.10". It is supported to be
-    compatible with earlier revisions of this binding.
-- reg: Address and length of the register set for the device
-- clocks: Phandle and clock specifiers for each entry in clock-names, in the
-  same order. See ../clock/clock-bindings.txt.
-- clock-names: May contain any/all of the following depending on the IP
-  configuration, in any order:
-  - "tx"
-    The EQOS transmit path clock. The HW signal name is clk_tx_i.
-    In some configurations (e.g. GMII/RGMII), this clock also drives the PHY TX
-    path. In other configurations, other clocks (such as tx_125, rmii) may
-    drive the PHY TX path.
-  - "rx"
-    The EQOS receive path clock. The HW signal name is clk_rx_i.
-    In some configurations (e.g. GMII/RGMII), this clock is derived from the
-    PHY's RX clock output. In other configurations, other clocks (such as
-    rx_125, rmii) may drive the EQOS RX path.
-    In cases where the PHY clock is directly fed into the EQOS receive path
-    without intervening logic, the DT need not represent this clock, since it
-    is assumed to be fully under the control of the PHY device/driver. In
-    cases where SoC integration adds additional logic to this path, such as a
-    SW-controlled clock gate, this clock should be represented in DT.
-  - "slave_bus"
-    The CPU/slave-bus (CSR) interface clock. This applies to any bus type;
-    APB, AHB, AXI, etc. The HW signal name is hclk_i (AHB) or clk_csr_i (other
-    buses).
-  - "master_bus"
-    The master bus interface clock. Only required in configurations that use a
-    separate clock for the master and slave bus interfaces. The HW signal name
-    is hclk_i (AHB) or aclk_i (AXI).
-  - "ptp_ref"
-    The PTP reference clock. The HW signal name is clk_ptp_ref_i.
-  - "phy_ref_clk"
-    This clock is deprecated and should not be used by new compatible values.
-    It is equivalent to "tx".
-  - "apb_pclk"
-    This clock is deprecated and should not be used by new compatible values.
-    It is equivalent to "slave_bus".
-
-  Note: Support for additional IP configurations may require adding the
-  following clocks to this list in the future: clk_rx_125_i, clk_tx_125_i,
-  clk_pmarx_0_i, clk_pmarx1_i, clk_rmii_i, clk_revmii_rx_i, clk_revmii_tx_i.
-  Configurations exist where multiple similar clocks are used at once, e.g. all
-  of clk_rx_125_i, clk_pmarx_0_i, clk_pmarx1_i. For this reason it is best to
-  extend the binding with a separate clock-names entry for each of those RX
-  clocks, rather than repurposing the existing "rx" clock-names entry as a
-  generic/logical clock in a similar fashion to "master_bus" and "slave_bus".
-  This will allow easy support for configurations that support multiple PHY
-  interfaces using a mux, and hence need to have explicit control over
-  specific RX clocks.
-
-  The following compatible values require the following set of clocks:
-  - "nvidia,tegra186-eqos", "snps,dwc-qos-ethernet-4.10":
-    - "slave_bus"
-    - "master_bus"
-    - "rx"
-    - "tx"
-    - "ptp_ref"
-  - "axis,artpec6-eqos", "snps,dwc-qos-ethernet-4.10":
-    - "slave_bus"
-    - "master_bus"
-    - "tx"
-    - "ptp_ref"
-  - "snps,dwc-qos-ethernet-4.10" (deprecated):
-    - "phy_ref_clk"
-    - "apb_clk"
-- interrupts: Should contain the core's combined interrupt signal
-- phy-mode: See ethernet.txt file in the same directory
-- resets: Phandle and reset specifiers for each entry in reset-names, in the
-  same order. See ../reset/reset.txt.
-- reset-names: May contain any/all of the following depending on the IP
-  configuration, in any order:
-  - "eqos". The reset to the entire module. The HW signal name is hreset_n
-    (AHB) or aresetn_i (AXI).
-
-  The following compatible values require the following set of resets:
-  (the reset properties may be omitted if empty)
-  - "nvidia,tegra186-eqos", "snps,dwc-qos-ethernet-4.10":
-    - "eqos".
-  - "axis,artpec6-eqos", "snps,dwc-qos-ethernet-4.10":
-    - None.
-  - "snps,dwc-qos-ethernet-4.10" (deprecated):
-    - None.
-
-Optional properties:
-- dma-coherent: Present if dma operations are coherent
-- phy-reset-gpios: Phandle and specifier for any GPIO used to reset the PHY.
-  See ../gpio/gpio.txt.
-- snps,en-lpi: If present it enables use of the AXI low-power interface
-- snps,write-requests: Number of write requests that the AXI port can issue.
-  It depends on the SoC configuration.
-- snps,read-requests: Number of read requests that the AXI port can issue.
-  It depends on the SoC configuration.
-- snps,burst-map: Bitmap of allowed AXI burst lengths, with the LSB
-  representing 4, then 8 etc.
-- snps,txpbl: DMA Programmable burst length for the TX DMA
-- snps,rxpbl: DMA Programmable burst length for the RX DMA
-- snps,en-tx-lpi-clockgating: Enable gating of the MAC TX clock during
-  TX low-power mode.
-- phy-handle: See ethernet.txt file in the same directory
-- mdio device tree subnode: When the GMAC has a phy connected to its local
-    mdio, there must be device tree subnode with the following
-    required properties:
-    - compatible: Must be "snps,dwc-qos-ethernet-mdio".
-    - #address-cells: Must be <1>.
-    - #size-cells: Must be <0>.
-
-    For each phy on the mdio bus, there must be a node with the following
-    fields:
-
-    - reg: phy id used to communicate to phy.
-    - device_type: Must be "ethernet-phy".
-    - fixed-mode device tree subnode: see fixed-link.txt in the same directory
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-Examples:
-ethernet2@40010000 {
-	clock-names = "phy_ref_clk", "apb_pclk";
-	clocks = <&clkc 17>, <&clkc 15>;
-	compatible = "snps,dwc-qos-ethernet-4.10";
-	interrupt-parent = <&intc>;
-	interrupts = <0x0 0x1e 0x4>;
-	reg = <0x40010000 0x4000>;
-	phy-handle = <&phy2>;
-	phy-mode = "gmii";
-	phy-reset-gpios = <&gpioctlr 43 GPIO_ACTIVE_LOW>;
-
-	snps,en-tx-lpi-clockgating;
-	snps,en-lpi;
-	snps,write-requests = <2>;
-	snps,read-requests = <16>;
-	snps,burst-map = <0x7>;
-	snps,txpbl = <8>;
-	snps,rxpbl = <2>;
-
-	dma-coherent;
-
-	mdio {
-		#address-cells = <0x1>;
-		#size-cells = <0x0>;
-		phy2: phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			device_type = "ethernet-phy";
-			reg = <0x1>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac-common.yaml b/Documentation/devicetree/bindings/net/snps,dwmac-common.yaml
index a38ff314b3cd..90e5560b6b68 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac-common.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac-common.yaml
@@ -12,6 +12,26 @@ maintainers:
   - Jose Abreu <joabreu@synopsys.com>
 
 properties:
+  snps,en-tx-lpi-clockgating:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      Enable gating of the MAC TX clock during TX low-power mode
+
+  snps,txpbl:
+    description:
+      Tx Programmable Burst Length. If set, DMA tx will use this
+      value rather than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
+  snps,rxpbl:
+    description:
+      Rx Programmable Burst Length. If set, DMA rx will use this
+      value rather than snps,pbl.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32]
+
   stmmac-axi-config:
     type: object
     unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2c4842404bf6..ddfc32ba29cb 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -460,20 +460,6 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 4, 8, 16, 32]
 
-  snps,txpbl:
-    description:
-      Tx Programmable Burst Length. If set, DMA tx will use this
-      value rather than snps,pbl.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 2, 4, 8, 16, 32]
-
-  snps,rxpbl:
-    description:
-      Rx Programmable Burst Length. If set, DMA rx will use this
-      value rather than snps,pbl.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 2, 4, 8, 16, 32]
-
   snps,no-pbl-x8:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -501,12 +487,6 @@ properties:
       Force DMA to use the Store and Forward mode for both tx and
       rx. This flag is ignored if force_thresh_dma_mode is set.
 
-  snps,en-tx-lpi-clockgating:
-    $ref: /schemas/types.yaml#/definitions/flag
-    deprecated: true
-    description:
-      Enable gating of the MAC TX clock during TX low-power mode
-
   snps,multicast-filter-bins:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.53.0

