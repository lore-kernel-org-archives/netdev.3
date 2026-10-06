Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BA3BB661;
	Tue,  6 Oct 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284782; cv=fail; b=p6r8WeHoPZ5nYTxk8qsoT5faQkdpktOMqs3IqQTlJ72UtB26B3CvBqaatQ62fOBjHq7BHBasjYA37T56WJRKnpigQ6ytN94w17nqS604tzjIwdkFJ7GG/vaI5MV+QaNqy6TNBHa91ELkKLB0i2OgzwHc2CtRLGKQ6/OzCug5l10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284782; c=relaxed/simple;
	bh=pWKo7iS9fDnGpGqMYW7chodoZxDgOx2mXsm/z8+wHxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7JUx56kLibunj6RSVkng8i1ITWI5qOqC0V3mcPsiu1Ngut9q4w9JINs7FlBXGVh8x3bxX7MmGwH2EAnHnOrmxmLjh7u7PoWheAi+YeZD8sSyzut9xClLVnGgPtgzN+iovQ8Ax+cQkoW4D1mYiTD6fUSzKP9tUxLBJOJiaAEodg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q45nuNSj; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q45nuNSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRYFwJUKkZ2nuwO0uBrDlh9RCV7PqGd5LQw4BdiWli9Fc9iXruReG/PqfyFH5LzC75fwdQMFhzqzXHtoKznO/MXyhGmwplsyFL8Z4rsBb8TaPYetWBvfsYgE/JKmaohWjavHUfmQOTUkFE/Zr4yKuLAuFc3B0234PohFpH3aUSHHqqfOpFOSV4fFFS1dyxHXm5wWOfoeUFU3xMd/xttFOP9S44N0T7eGoYKS+E7zcX2+G4kl0XyVfBqSOXEJ+YWsHD+3hLeag5QZoj+BRqZeFrbQanotARLaveJo9IfWNbwQHsp63/Mpd9UBAXfo536HmgxR948UYKMK5CCi3lW3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vry8G/RfmDKpOGg5FYHV42s0YILQyZW3t+Dxr0Mwtnw=;
 b=Q+HkezSk2bPOvkZEk7Sae9WDHQbJnVZWmEXJNF3y9uEqEbTJ4cKhj09MZ2rkiznqH0r1VL7Tk+YWgTA7dlguJAQP2WnacgygukxOcJgxt9syMSig1KXFvabg2gxwMDA09lJuVGfJIx0xrBP/oG7PWCDiaxFT0nyEGeHn2i/Tp4A+kYhZC/VESCPi8D3NqcjEmi5AotAqNQV4Swz8KXtA7RqFaYeEqcUbeTgiFzCZi/pO9PE37+0JIPZ2XpnOAhc9X2hWGjbN7vbgkk4klqEmQVX+MPsd6Hexu1497vkIwPU07HKHQadTrlRbpF8NemPtS4dJa/uKcHOYfDrl8rbhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vry8G/RfmDKpOGg5FYHV42s0YILQyZW3t+Dxr0Mwtnw=;
 b=Q45nuNSjw4jPZnSjAQ92tkkc58mOAe9oW2Yk+b8/OlDsNWLcwx2miGlcoHHfksXtF7lwUZV5ptyu28JmBdKN8UIYdeCu4kCZcsOeOvMywHwfUq3dlRl2JJ6wzLlvZtwDpsHn2flFEhC/ELLInAmD25Ng6PQWvhxkFUvk0FWFUvc=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 11:06:14 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::f) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:06:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 11:06:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:06:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:06:03 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:05:59 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Michal Simek <michal.simek@amd.com>, Russell King <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet
Date: Tue, 6 Oct 2026 16:35:46 +0530
Message-ID: <20261006110550.1990213-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006110550.1990213-1-suraj.gupta2@amd.com>
References: <20261006110550.1990213-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4f8574-fb51-4f58-a881-08df2399d5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	2lrE/fXhIPJA5VS8KuaPelCF5u7lcJPpcT76u/6BE3a9ZoyYWKUetRCwDO+wFKcNscN5uS3rxdrqteRfiLmSX2a2BmdbPZ4uBsyjaCtbkYbOoU+W8UWEMJlBEqB2vy6q5zOv/UV/Z21T+BfMugjUASKIvJtT5IiQGJh4NqEzxnssywynuIMbFseOH5RPL4Rh8Sve5R1EDR1gupOTjky10GbckOQzXAb+zKPNiYxcthb4JjrTR6fXkMeIimq4ZWK+/GbjOJs1JQ5WxsKqr1R1VAlAE+JCY/ygEBF2UKQdKaWr3M3mnh9QXDRjdEkWhssmHVgeAzn6MhKGDWoSlQ+/nH3j5gj7aw81p5UjMxboIozNzd/SIRC6vZQ49vVH5kxOiSLc0NFwXKgH1vspx9Xn1t6VDDRVo+U34lLycJ9L4KUlvpIcqxo8zzNO3YTg6eOi0oBE6pCPE0Cm54cAeQmtRawcPxUo15QP8kU7oWLbc8SRxulsxup9NUg4ocmhN3orwEHIOHcrUjIcDA0Sbn8P20SZF3Wn26FjUmZhteH4Dt/Bk7Xl6AFBpCTpmFklSMICalbqeyFEpiOY52+/2KqjYj6L1KHwEzFY8/a+frUZw2HyjgWo4JrTQvhkVKrQxt2YD7AuXUWFtGZPsktJt2lxVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uW01jB3t8Ebu0nLiqnbtkzkoCNYMEfanRlpFathLB0/I7i8/dp6I7EemWaxkez+6AxJSJM/Ngx3OkqMOQmDtXztlU2C3JZ78DuzZxmbygbKM/upMKFw0COvrqn1pY/NlZX1VS6azZTN66WaceQtU6kyveMU/q/PmUHBwHqQYecqlFp52vp3Lupv0ABvx6Vir1Sf36J95Lk3wbYX1MZEsULc+PxpvgEKTsozz2g1vdZglN7CY9WU+4r1rtVbD0XcxtKGuGvQLDNeFcpoUzLI9njEG4GhdbpKrwuc6mttAtfgxOUML00lNnSaCEtx1zwemMAaleRIW5fzS2PbeTy6ywC26YtpZoIgCZA75t+1Ca+yCR6vl/RNcOMFXSzaHB6pnylUKvGpB3ObBSlxic/E0ssrzO8lb6I0XPQtnHWNvurfnCL5a8juPbhXxrdpJtkcq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:06:13.4237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4f8574-fb51-4f58-a881-08df2399d5d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96

The XXV Ethernet IP integrates a 10G/25G Ethernet MAC with an in-core
PCS/PMA driving a high-speed serial transceiver. Its payload is moved by
an external AXI DMA (or multichannel DMA) controller referenced through
the dmas/dma-names properties. Document the IP in a dedicated schema
file.

Add the "xlnx,xxv-ethernet-1.0" compatible with the 10gbase-r and
25gbase-r phy-modes, the rx_core/drp/s_axi clocks and the AXI DMA
channel properties.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/xlnx,xxv-ethernet.yaml       | 110 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml

diff --git a/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
new file mode 100644
index 000000000000..cf31ab677a4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/xlnx,xxv-ethernet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XXV 10G/25G Ethernet Subsystem
+
+maintainers:
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
+  - Suraj Gupta <suraj.gupta2@amd.com>
+
+description:
+  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet MAC with an
+  in-core PCS/PMA driving a high-speed serial transceiver. It supports the
+  10GBASE-R and 25GBASE-R line rates, with 25G operation following the 25G
+  Ethernet Consortium specification. Because the PCS/PMA is integrated into
+  the IP, the subsystem has no MDIO bus master and is not managed through an
+  external MDIO PHY; link state is read from the MAC's own status registers.
+  Any SFP module management (e.g. I2C) is handled by separate IP outside this
+  binding. Its payload is moved by an external AXI DMA (or multichannel DMA)
+  controller referenced through the "dmas" property.
+
+properties:
+  compatible:
+    const: xlnx,xxv-ethernet-1.0
+
+  reg:
+    maxItems: 1
+    description: MAC control and status register space.
+
+  clocks:
+    items:
+      - description: RX AXI4-Stream clock.
+      - description: GT DRP clock.
+      - description: AXI4-Lite register clock.
+
+  clock-names:
+    items:
+      - const: rx_core
+      - const: drp
+      - const: s_axi
+
+  phy-mode:
+    enum:
+      - 10gbase-r
+      - 25gbase-r
+
+  xlnx,rxmem:
+    description:
+      Size in bytes of the Rx/Tx packet buffer memory built into the IP. It is
+      fixed by the hardware design and bounds the largest frame (jumbo MTU) the
+      device can accept.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  dmas:
+    minItems: 2
+    maxItems: 32
+    description: TX and RX DMA channel phandles.
+
+  dma-names:
+    items:
+      pattern: "^[tr]x_chan([0-9]|1[0-5])$"
+    description:
+      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel and
+      "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel.
+    minItems: 2
+    maxItems: 32
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - phy-mode
+  - xlnx,rxmem
+  - dmas
+  - dma-names
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  # Single AXI DMA channel pair
+  - |
+    ethernet@80000000 {
+        compatible = "xlnx,xxv-ethernet-1.0";
+        reg = <0x80000000 0x10000>;
+        clock-names = "rx_core", "drp", "s_axi";
+        clocks = <&rx_clk>, <&drp_clk>, <&axi_clk>;
+        dma-names = "tx_chan0", "rx_chan0";
+        dmas = <&axi_dma 0>, <&axi_dma 1>;
+        phy-mode = "25gbase-r";
+        xlnx,rxmem = <0x8000>;
+    };
+  # Multichannel DMA (MCDMA) with multiple Tx/Rx channels
+  - |
+    ethernet@80010000 {
+        compatible = "xlnx,xxv-ethernet-1.0";
+        reg = <0x80010000 0x10000>;
+        clock-names = "rx_core", "drp", "s_axi";
+        clocks = <&rx_clk>, <&drp_clk>, <&axi_clk>;
+        dma-names = "tx_chan0", "tx_chan1", "rx_chan0", "rx_chan1";
+        dmas = <&axi_mcdma 0>, <&axi_mcdma 1>,
+               <&axi_mcdma 16>, <&axi_mcdma 17>;
+        phy-mode = "10gbase-r";
+        xlnx,rxmem = <0x8000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 72ca3aab2106..c7fecdb50cac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29904,6 +29904,7 @@ XILINX AXI ETHERNET DRIVER
 M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+F:	Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
-- 
2.25.1

