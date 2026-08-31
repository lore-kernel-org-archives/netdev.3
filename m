Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C407424D75;
	Mon, 31 Aug 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188936; cv=fail; b=otGme2tPFLPTVS0HZoTCgXUTtRj/m3j9rXqf9cpeD9mJNpYz7m0ImITfsMMk4Tqr1+ZnGPSkkQhgIiM4iK555r/KNm+fGJ6bdAT8EY8xGs8+PCl1+nwIu9qAgNqW1F0VU50dKnpvr0i56VysT6Ti65Af1ok/pUda6tclhqlJYek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188936; c=relaxed/simple;
	bh=VIX5ew6TeXbgJcm1xrlvnyFqXq7JOdeokaoToY1bFBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euREgL+NLO4JTWP87Zg9FGWido+oF9r2H726xMK1PQhdvyIXq6QdIDUGErWldwkpJVnhOotWmN806eMmQaSYHFuPzPTpiLr6G6RR4WZ/umSB4rQxdgrXyY8aBzrIJmJ7kysSlyh4dk/FOflfOqfJPjLBY2CQYNi1l3NgPWu1RWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2KpdFQJc; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2KpdFQJc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axzU6w+mWPNx2ZJYLZmjXGvqnirp4+5cCfBWssW1C2n44MLJoucj+n1/ixIdNpvbfwynD4/VY02ilDNkXH2GIiykyd6hYZZBC4fgNzBZCu5F8pkcGEzibJt9bduANXhDKtbeJp+4Wk3VACqPLkjpyKjn1nXryWjrVd5Ozp4YXe/a7iRUXJ8iNv0f/OnjcK6BejqnCYo7N9Xls2E87bjGuY9qMvvj9OuNjuqGEbQpmPZ7ItrsmhWxtZzH6fo1RIQfj+asiFtYysl3lFfydfzmSCdpquaJyuNaVUAuLR2ow+xx1dKpwiQebvFElvoYlbnlIfi0KkmwXDEFaKVQVWaBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT4nkNMlS/dPWW+UPepkc4Yl+dRYGFrp3zHyokX2lQQ=;
 b=hsSq5fM6R3RAhNp9qUmXu/Zr4lzMXCmhxDPuYjUAd96RKs9ChiAQKLWjirViejHOu5T9ctvc/MH3b/PCx8q22wXcKjV1Y8M5kEgqGU9SmyVKxZXbGcE9OId1bsaKgMGoho186Zhg6jA3H7PpQPJ9TrwREASkvVCt3g4bv9bJGH8xk5j1FB15uDd6I6EeYGi2C61nPt/Ru+hN1GVD8o3tCRO1egUkEq4Q0r0tEZGSG31nA+A/3t++3WSGQqyRnlir0Es1Dt7FnVsvLtkA4Jf7/ZnABiPhwS217DFZa2OvDgF1/IMniVdiQUzxKsX9waRAnwjdoXIEncR6x6u5+B8s0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT4nkNMlS/dPWW+UPepkc4Yl+dRYGFrp3zHyokX2lQQ=;
 b=2KpdFQJcLe3JWkC5AdQu+sWCs8pPkw9hcZCzXPAaqVcN2+OFU8AJasmlm8zcoxwYR6phOxdNCt2rnBd+lpkM7zckKT4/QCk2d7V7vhYT0vpyeEnIGcNe999tuHunYtLF2UVr4DqoGu+7NxjBboDyRw2dUYEPxnGWB0Jp/W9C3PY=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:08:49 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::77) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 15:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:08:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:08:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:08:31 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 10:08:26 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet
Date: Mon, 31 Aug 2026 20:38:12 +0530
Message-ID: <20260831150816.1020883-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831150816.1020883-1-suraj.gupta2@amd.com>
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c895dcc-b62f-4778-370a-08df0771c2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|13003099007|921020|3023799007|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	alebvt4q02tvjRjNMUoLOBk1hwdRdhg71bteeCb1UMOtaSGgUPfkKfGLhq/UmbgDae8S4iuIAwld2kpjoQDcvG9WDQJyAvFj7EQ7insNo7N1fz/50xbxHOS97iqkDi/stC6gPFaOw+EWe9tS2z/RcLPvuti8leaYLKz1ZTkft/NVRzuXagFRuF8KKeYin71kjXIMTkLNy+ICG65uet25/XeYoJDRiSnPHhx7dV5rGceqY0bUbPfUViCtJ5da8ODHb7zggj8d/zJWz3AuyH/zFEi9VNKCSteGxeRBvHX6jggJoKYKuQfzgq38jF1vFVuGvVjMlekk58NZq/law9DMUwo4LIgEQl0U/WVx5zscU9Ov4xF9WI1fHKcxbMNM6aP5AqAyuk/YPpVph5U4UG6PqCxqadqn1RuMVtZJD4q9EtFKCd6YX/XAxR0a1BduGzjumFPSWyuZKaoMrtb1WRa4vjHSJIHjNJEh5N8FOqmcjoMlQmdu3kekflO7pKntocPX56aWlaL7HxBVEn1RwtDI7a5UAf3nZLd+Cjeqo6a5CSDbsN/ma0oxagTds8qLjcAZwZcKbPoxlXrGn9XKoRZfYyyyb1QKudad28ByQy6XJ3NhZIiqCpFg2+3mBKu8OuiRCEVExrNSCVeMtiqFLy4up0GFzWFdr+KjsQDunJ23vCIYQ6NTV3b8dCvOiPne2+DWto/cPqQ7Absw0w9X0m6q6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(13003099007)(921020)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wETLs0F1nPKEH4vTJIz68h8msWCPRjtdgkwH5oXHF4/anp//6ZOFoK9Jf1Ilfow5jaq+hKhrlC4eEGqSZ56g6HZPJ8s1YjEyZH/Ch3rrsaGHniykLsSG8TMO4hIeGCF4dqQhqRvEQAx4QqFtAyiK+E+uylJbu4UmWW7LgZQSorKJVMPgQyNXvWY8YCuCQaSwN7xlQX7KvEWmWR6szexg6e7g4BNeXUndkLuNpemfcXv7MH0kb6OiVzPGBnDcb2SOs4lOXjczkOzTEpGNES7k8EeC+YOS4z6wpyn4ibuTK/0/l7HiTh2NWU1It6j4/fMw2GT0UUiQaoJ5ofWyv+ipu6f72EUvb6mlxYLhwcTJaAJ76zVXgsBgGCsyY58/FCPpZeA1QAMZr+PdrMrYUrpn1G09/mJZ02/vU154kM+CGKQ5QR6yTTssKQmKwKBuFXic
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:08:49.2357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c895dcc-b62f-4778-370a-08df0771c2f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40

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
 .../bindings/net/xlnx,xxv-ethernet.yaml       | 107 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml

diff --git a/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
new file mode 100644
index 000000000000..2be3ade11d46
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
@@ -0,0 +1,107 @@
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
+  Ethernet Consortium specification. It has no external MDIO PHY, and its
+  payload is moved by an external AXI DMA (or multichannel DMA) controller
+  referenced through the "dmas" property.
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
+    description: TX and RX DMA channel phandle.
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
index 2d420d40782e..8160a8ddec65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29557,6 +29557,7 @@ XILINX AXI ETHERNET DRIVER
 M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+F:	Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
-- 
2.25.1

