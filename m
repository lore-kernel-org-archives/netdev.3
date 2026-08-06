Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224A239E60;
	Thu,  6 Aug 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039960; cv=fail; b=TGyiBlROhOIhgTXDV1FGbYAboEnPEA8fLOV08FSVnrEXjclkdVPzGtAFCIzQ2CmXplSzWK+N7l98sNyruIpw+ohSgMasaf5bYf2A+gif2xpD33OWO4goWrSR+SGWRVu6DKV0uoDg0nTPnMoZZXbFCXV/x5Lx6piMQCPXOdnTdOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039960; c=relaxed/simple;
	bh=WcFZ3Nd3iiNHYzMuii4yW9T1Xs+BAwzvRdxN5+t+Fbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snUuqdT2pmxIHv3WYlDaSKm1DMtrMaAcPpC/1U8bBJnfPWmMJD2zH8SAV101A88oPzqK5QyxeW/m3wOXxFOMLwp/QOA0jcJeC854YkKHmeZxLno3dui2nBN6W57X45PHEjLPU41p0DzuEF1uJ/X/UsYlE4sYfXrdI45m7PoUDo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXBmsjBS; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXBmsjBS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2qq1REgZPmUsY20LhyTbORSu4If1zy5Q2wl/T4i9YVNf3s/r8BB83ZnbSGL3pO+nkJRF+ew5EnVmMy9lcxoRU9OwpDdEuvjfvNi12bDsf+30sscC04KBJ4pMqMxrYtdWeydw1l2cY2QVf58HIS7oeriIsLY2NweJTJJSJDhC1UuYfLWkXj3O9AhH6w54oNv2e+rCN4hZWveGDk/XyZfvAW+0B9g7LMUevjdTc1IsIXUt/J5hhf/K0gQ/gwnt3BbY1OCFFx3w5empTaWfnMDbOda26aZRKnvS8r/ftQbvdS/wjThMP1FMaeuV1yAf7co10B6sBK8oK2rywAVGM30jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcTpqzBlIXTP9JAEEYtU+o3yT41WptoxcbiGlA2VzwI=;
 b=Olx9L5LMm0V3CyDfAkUCukOn3mA5ISzD6/oS6mWy9eQPATbQgibRzOnl4sOS/AChD5C87wlpfuPWx/q6yvJWaio0QhD9/0QJfisR26ewZhLADOp8w81YO8QpPRkcgWQDvzO/uYW8EqJcwICnbOkSV9mSZqH9napgNYHYc6UGTXfP8Wjeojx76cjpU6sHJOt7K8lYxSMXvy2tl6bRg2XRL2v0PI9R8vX2F7CcfR80wpVXamRpm+PAwgMvraK4WC03RzEJ1W431E/ERS9mHiU5+g4DdYvz0D4KKmTOWmdtrmxvs1hlIC5MtErpiIThFIEdzcsNjrfanAGblBQl9RDXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcTpqzBlIXTP9JAEEYtU+o3yT41WptoxcbiGlA2VzwI=;
 b=FXBmsjBSobRptW4SdUxclKQCxZw4xiluPp4Fl1Xxkx64p9PRxKIGlyr5yAZ10jOXfF3jAtGRylbP0xzGW/BHrxI+hL8pV8+/z0zIBi4HZZDOPkdyBSSqqgBDurH57asKoyxO6SBSp2trsqsXjJRkMseiHlFsDtyLWzsiCd6a5jw=
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by EAYPR12MB999134.namprd12.prod.outlook.com (2603:10b6:303:2c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:12:29 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::9e) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 18:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:26 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:12:19 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Brian Masney <bmasney@redhat.com>, Stephen Boyd
	<sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, Danilo Krummrich <dakr@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Russell King <linux@armlinux.org.uk>, Shuah Khan
	<skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v2 3/7] dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet
Date: Thu, 6 Aug 2026 23:41:49 +0530
Message-ID: <20260806181153.1213996-4-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806181153.1213996-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260806181153.1213996-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|EAYPR12MB999134:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d984f0a-fa41-4da3-039b-08def3e646da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|22082099003|18002099003|11063799006|4143699003|3023799007|13003099007|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	pK6Pb6Ka3ey9v/+tKdQsrvh2bUw7ROE9/HaA09migXJYhZxZXojh0nGSsiJcX/5nzffgnBYMS5xAIwk1clJRtpyY1jsOnUpm7E1+9aXNW2NDpk9emmzJVr3w3GuHMq1cnOjcMYV7NhsGO4HQg5ECEJrfUzZjLRPtZHs0UR8SDlKtBpN2L6jnh3v3VCJHzYDku7UtFxHBGZllhZOC7qn6qhnMQwC+lzNW86Xlg07CDM3fDwirtTSEkIB+Qnlp5d7/agGewloOIFL4+KreySyavJLAhig+dENZ5MfnkddDIIRzD6m7QxDiRtNpo9mARdlLr5HXmB8uStqt8DgMbYueahGVFNEZ1mheGDJdz/wDv2PslfRwBsPOg/VF51HK8Wx8x98hfvei5KRywPsfhEtFgiLqovD/CT6HMPRAUok1TYvPQoDq+OI+egwcyu88H9KMg+p8ZcFobc5RZA/a4aEtjKbaeZuaGsL0yxB48XSh3Vbw87E8n3r2X5/3fh7TWHGj8mtI7418fJdNcwY9pJlLYzdccp5+pn1qy7QOwEb2vR94GFUhBJDzcJL0FP9uM739a5YRK+cOm5Ln3sIV+PmCJq6Oc49iEfCi3fXs7541A0sHeA2PXbjkNhtAqrTlLMlLQuYyDywQP4leURVMSLOMZJAH38xfh4SKUognPk7rjp31fcChF9TkebcLlhIwzfko2aQQL1TVoKjLCZD0Rj+ak3R30TxLVZs85Exh+PPjkwUdbo8sgbY9CBUNlQmIfXzN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(13003099007)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kUtF92D6rfwvVnxSnViU6IYutn9DrFo4ofoSuZChGybEUFrzWDGzBGNQTE3ZYl4tKCMi3wMB2TCs18sCPL1fowYfWg58DiZfTbGpQagiIfHL01QKwoWsk0kyRpqjMRcdjXvkfHyX3jHktO5nnUUD+Vz0MiUBc3paAMTkfBlwhVi33bqenXb5bl0DD8KLfRilcTiR6RUO5eGFQUnzqZsD1jhoXSSYTrZlTx71T1JKLaXlJ0N61RZBnZWju8zf9z8REL8ag2yNwvVIKAyXIi6r2tjA62yvaK7qw8yqKeWL7fhj7cI0iglEDB/MVI/DXWsG75Z9Z20Uj14W7jOiluM45++NpPw3LRx2aT7xpq2Sq9DBio50rIK7P0k028a4R1fZM0slYRr7RhXinKMHCcOwZ4O2cKnYA+87bfms+RSPhT1I1ORa5poxZQhUIeHorXmM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:28.9502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d984f0a-fa41-4da3-039b-08def3e646da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999134

The XXV Ethernet IP integrates a 10G/25G Ethernet MAC with an in-core
PCS/PMA driving a high-speed serial transceiver. Its payload is moved by
an external AXI DMA (or multichannel DMA) controller referenced through
the dmas/dma-names properties. Document the IP in a dedicated schema
file.

Add the "xlnx,xxv-ethernet-1.0" compatible with the 10gbase-r and
25gbase-r phy-modes, the rx_core/drp/s_axi clocks and the AXI DMA
channel properties.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
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

