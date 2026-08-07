Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1B41E6A0;
	Fri,  7 Aug 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099492; cv=fail; b=XGwmxwUkTROHk0Gk8sKdqwXUVswd3Z7KCOQhvwr/dyFP5ypZE7dbSEcoD1xCxKNM2eHsrTlDNe0qTDHYsy2MbQRVFeRORlh226wxgEQnxllNSnlH29b63loKDbd3XukMvs1KfACa6IdKQiZO0EfcXu3j92vtNEoQ6YFSO0ZXegw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099492; c=relaxed/simple;
	bh=JHdwCUAsoDUIqTaEuV7SzoPyZ7KKBXdOv3Rzukpuaj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ3jesbcSl6I/bHfvZox/bEo8gcJivQ7thLW9NFbFc0fUI9KqYDeFpCwpwry0iTnAehxIYnk5slgLB3jxVIkIbonQLw18bXwAPtrB9L2bs0rZSas+36PrYL9EaPOb5RjZbdIn52BBw4hOESME4l+3YxYVQDLreC4h177EZQPDzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bTK9NAII; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bTK9NAII"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I25w3L4xf0mQTztydqwhkPemPuUndRB/AP3YKk9t8p6CJHyH1y4WHMboRQ22o8SyWCBAa53y64Jh7NH9ljEkmsxXhbW32AtwWM5sHioa0gWEQbz0MGIN42yDTYbl5LyUKVfKlZBpWIrfzdqYDhpwiKyXVh4rntmmnykzoTWChYaurNhXj5RdLACPtPnk1B+U9GPBsh0vlkKxei5T9dC4OTUeZ7pd//z7kSrsPcIaJ4+6qWQ9zvo4aiocLqq3z7wr1PztRxpl1jk3GdZGMNTPDKBtPXWUITWE/y8+bluNN3iEXTGRxPib8CGjQ6wy5+P70Wf1InidTDdBMi7DWZut3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwDFAAwhDGamXidQKlPRtNz5yEQ4iJrIf04JdEwzaG0=;
 b=pDZ0QKEdBHExrcD8IzST9yw16fkfqByOYaHRFQs4aRCC0QghCEDbdS+9mg2pScMj8vkVv7mLNa66GNagVlLz+rF5n/NKTtH7rrFMsb9htYHjl91tFoskyeMPTeuuJXHqsCK95lgS1lYlP/pmWIqT8mLoi6KfAH6g4sgV77reOKCOEoRCx3GFu8+oblFWMx+ON9gNyQ+LCqgMxP2hGC7vKgk1Hmn/61MaSHo7KqpMzg4iew4rSEvR5sqMpUnhKMgSbHccy0XW+D7K4lffmBoUdsHcromd7M84g0AASqFoeahLQTfDy43xTTdcqpn5sTXKUk8KwllMSLL06Hk1DHfWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwDFAAwhDGamXidQKlPRtNz5yEQ4iJrIf04JdEwzaG0=;
 b=bTK9NAIIqSzyA6qPlFuQmRi+mtnph27a5E1h15VSvkuTAOXfGNQvRa6HcuW4g1xkd/r3JD/0LdheApPNu3hJyUcTZDVPiDDlc4Xuk8nzrvmL5rcy2DjRoJQd9xkjqRmUY32RxDCNmoHLJ9YyfHQuFV11ZXYafmDF5N4XF3h0NfM=
Received: from PH7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::12)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 10:44:44 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::81) by PH7P220CA0077.outlook.office365.com
 (2603:10b6:510:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:44:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:44:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:44:42 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:44:37 -0500
From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git-dev@amd.com>, <nagadheeraj.rottela@amd.com>
Subject: [PATCH 01/20] dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
Date: Fri, 7 Aug 2026 16:14:12 +0530
Message-ID: <20260807104431.157230-2-nagadheeraj.rottela@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e6013d-703f-4460-3ae8-08def470e4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|22082099003|11063799006|56012099006|18002099003|3023799007|13003099007|921020|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	UoPiA84y4htBAi3Z5aiDdZii9w6V7DOQKqP5jel+4er/KSkAiNUHGWx4HNjjBBAkf0zScRKPoIvRhddchykFtOViWHf3bs26BsAWzVoAAu/JU1I3Rbmp5P3YdELqNWgef8mWjOTvyvCUflvGFD2R948mzpgn8cgY6FTc0vfuPsfO4V5Y8VCgn8PI7m6c5UeukPqbtlTKIrrCQ/LZ42bbg70IOz+WB3P+aNpUAmz9OO5uO2FQDzYpPd1i3sj9k3I//2ofV2jvu4ZJHMmogc8mLYkJfnLJVGb+x/TqRXcgtNLlAY+WQANb5NwRpoS1D0PSaGCp6yR28Oq400Hm4VJzshDBAkFFje00vIF/OBGIC98vEaQWoKXEx6vOGXwEZzuW2Nwv6V7L8IU21cTalnzENjKTUs2n2ZE/TbaS11RULac/ubNJvYuSVGp4C8Z1P1VKub+n/APnfqH3iULeIVe/QNgs3PEtwCz4NGJUiLtdVzyiJ8aBGSwPb9czI3ttFP2tpDuZYioOlFgkiPyB/ZQqp52kX5DKnj4ww4Z/CWq4V+r53eNW636MRvkKNMu4HS5STW0NplN9j5tqBECIvDfrUjs4Lm9JMPLH6BhErAonOG7UxeIfMbt1/Hxtsz+pVzX1BHJw2Hiw10WymWqmvXBW9++zcEU/mHQ7zTo+fSbbTZgJGMJhobdzaH26fcGuckmpXzzyHTu+vdIjV9LZffWWBK53UJxfTvhaR078O8d3kxV/ghfuoVb6BIZ3oi8wSIMu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(22082099003)(11063799006)(56012099006)(18002099003)(3023799007)(13003099007)(921020)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	skmnr10Qh/lyEOgUxEA7FFROJCj8uPlzOscRn3/he4OCiGePiWUswEUoQw9GPdL1CU4VaA3MifyeSWrmRccNBPk0QKxg7y9/qlFmVcPtX6MCXITQcJhXKvkS/tY+dXvAmQUCh8r4Fx3RPVGixTXR1XSWbbokvYWD3OdGHRiQz32Pi9mypdRupTSpeU6VugoTsP//E+HbUjzNqoc9Ka3IfsZ7mlAIYbfuT7S3lOwdbp1E2v4/yX47Yd0vLHcTrNXEVXsq2Y9MT5dg2iHD5M9No5veAp3J4RckcalmZEYKPJX47zE+3ex8zyp24ii/DzgH8A+gVMm/w6CZSY02q2eTjcDLOC2CHAHLMaq4r+YLVYx3YAieiRUQ90IR2nwpbSW6h90bAfoT3BIPetKs9KFd2j+cI1t3/hiSYUkiS2/ACRubOKiCE0IQw9GN32BlPAtl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:44:44.3241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e6013d-703f-4460-3ae8-08def470e4c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195

From: Srinivas Neeli <srinivas.neeli@amd.com>

Add a binding for the Xilinx TSN Endpoint Ethernet MAC IP. The
top-level node describes the IP wrapper, which owns the six shared
IP clocks and the xlnx,num-priorities parameter, and has two
children:

  - xlnx,tsn-ep-mac: the endpoint MAC, owning the host-side DMA
    channels (dmas / dma-names / tx-queues-config).

  - xlnx,tsn-switch: the three-port Ethernet switch covering the
    switch fabric and the two per-MAC register windows. The MDIO
    controllers and PTP register blocks sit at fixed offsets inside
    the per-MAC windows, accessed through the mdio-mac1 / mdio-mac2
    children and per-MAC interrupt-names entries. Each external
    port@N references its PHY through a phy-handle in the matching
    mdio-mac<N> child.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml   | 343 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml

diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
new file mode 100644
index 000000000000..00f52b7b623c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
@@ -0,0 +1,343 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/xlnx,tsn-endpoint-ethernet-mac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx TSN Endpoint Ethernet MAC
+
+description:
+  TSN Endpoint Ethernet MAC IP implements IEEE 802.1 Time-Sensitive
+  Networking (TSN) standards and provides low-latency network connectivity
+  in either Endpoint-only or Bridged Endpoint configurations. In the
+  Bridged Endpoint mode, the IP integrates a three-port switch, with two
+  ports connected to the external network and one port connected to an
+  internal endpoint. It also supports GMII/RGMII interfaces for connection
+  to an external PHY, enabling full-duplex operation at 100 Mb/s and
+  1 Gb/s speeds.
+
+maintainers:
+  - Srinivas Neeli <srinivas.neeli@amd.com>
+  - Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
+
+properties:
+  compatible:
+    const: xlnx,tsn-endpoint-ethernet-mac-3.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: GTX clock for transmitter logic and RTC
+      - description: GTX 90-degree phase shifted clock for RGMII
+      - description: Host RX FIFO clock
+      - description: Host TX FIFO clock
+      - description: Reference clock for IDELAY control
+      - description: AXI-Lite register interface clock
+
+  clock-names:
+    items:
+      - const: gtx
+      - const: gtx90
+      - const: host_rxfifo
+      - const: host_txfifo
+      - const: ref
+      - const: s_axi
+
+  ranges: true
+
+  xlnx,num-priorities:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 8
+    description:
+      Number of traffic classes (priorities) configured in the IP.
+      This is an IP configuration parameter that determines the number of
+      priority queues available for QoS scheduling. Traffic classes map to
+      IEEE 802.1Q priority levels (0-7).
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^ep-mac@":
+    type: object
+    $ref: /schemas/net/ethernet-controller.yaml#
+    description:
+      Endpoint MAC sub-node. Provides the host-side data path through the
+      DMA channels described by its dmas / dma-names.
+    properties:
+      compatible:
+        const: xlnx,tsn-ep-mac
+
+      reg:
+        maxItems: 1
+
+      dmas:
+        minItems: 2
+        maxItems: 32
+
+      dma-names:
+        minItems: 2
+        maxItems: 32
+        items:
+          pattern: "^(tx|rx)_chan(1[0-5]|[0-9])$"
+        description: |
+          Names matching the entries in 'dmas', one per DMA channel and in
+          the same order. TX channel names use "tx_chan<N>" and RX channel
+          names use "rx_chan<N>", where N is 0..15. Example: "tx_chan0",
+          "tx_chan1", ..., "rx_chan0", "rx_chan1", ....
+
+      tx-queues-config:
+        type: object
+        description:
+          TX queue configuration node that maps IP priority queues to
+          DMA TX channels. The TSN IP supports multiple priority queues for
+          QoS scheduling, and each queue can be connected to a specific DMA
+          channel. This mapping defines which DMA TX channel is used to
+          transmit packets for each priority queue. For example, queue0
+          with xlnx,dma-channel-num set to 5 means priority queue 0 uses
+          tx_chan5 for data transfer.
+
+        patternProperties:
+          "^queue[0-7]$":
+            description:
+              Each subnode represents a priority queue. The
+              xlnx,dma-channel-num property specifies which DMA TX channel
+              (tx_chan0 to tx_chan15) is connected to this queue for
+              transmitting packets.
+            type: object
+            properties:
+              xlnx,dma-channel-num:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                description:
+                  DMA TX channel number connected to this priority queue.
+                minimum: 0
+                maximum: 15
+
+            required:
+              - xlnx,dma-channel-num
+
+            additionalProperties: false
+
+        additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - dmas
+      - dma-names
+      - tx-queues-config
+
+    unevaluatedProperties: false
+
+  "^switch@":
+    type: object
+    $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports
+    description:
+      Three-port Ethernet switch sub-node. Contains the switch fabric
+      register window and the two per-MAC register windows; each per-MAC
+      window houses an MDIO controller and a PTP register block at fixed
+      offsets. The IP's per-MAC and PTP-timer interrupts are exposed here.
+
+    properties:
+      compatible:
+        const: xlnx,tsn-switch
+
+      reg:
+        items:
+          - description: Switch fabric register window
+          - description: MAC1 register window (includes MDIO and PTP)
+          - description: MAC2 register window (includes MDIO and PTP)
+
+      reg-names:
+        items:
+          - const: switch
+          - const: mac1
+          - const: mac2
+
+      interrupts:
+        maxItems: 7
+
+      interrupt-names:
+        items:
+          - const: ptp_rx_mac1
+          - const: ptp_tx_mac1
+          - const: mac_irq_mac1
+          - const: ptp_timer
+          - const: ptp_rx_mac2
+          - const: ptp_tx_mac2
+          - const: mac_irq_mac2
+
+      mdio-mac1:
+        $ref: /schemas/net/mdio.yaml#
+        description:
+          MDIO bus controller for MAC1. Registers reside inside the mac1
+          reg-names window.
+        unevaluatedProperties: false
+
+      mdio-mac2:
+        $ref: /schemas/net/mdio.yaml#
+        description:
+          MDIO bus controller for MAC2. Registers reside inside the mac2
+          reg-names window.
+        unevaluatedProperties: false
+
+      ethernet-ports:
+        type: object
+        additionalProperties: true
+
+        properties:
+          port@0:
+            type: object
+            additionalProperties: true
+            description:
+              CPU port. Wired internally to the ep-mac sibling.
+
+            properties:
+              reg:
+                const: 0
+
+              phy-mode:
+                const: internal
+
+        patternProperties:
+          "^port@[1-2]$":
+            type: object
+            additionalProperties: true
+            description:
+              External Ethernet port (port@1 is wired to MAC1, port@2 to
+              MAC2). Its PHY is reached through the corresponding
+              mdio-mac<N> bus.
+
+            properties:
+              phy-mode:
+                enum:
+                  - gmii
+                  - rgmii
+                  - rgmii-id
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - interrupts
+      - interrupt-names
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - xlnx,num-priorities
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    tsn_ip: tsn@80040000 {
+        compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0";
+        reg = <0x80040000 0x40000>;
+        clocks = <&misc_clk_2>, <&misc_clk_2>, <&misc_clk_1>, <&misc_clk_1>,
+                 <&misc_clk_3>, <&misc_clk_0>;
+        clock-names = "gtx", "gtx90", "host_rxfifo", "host_txfifo",
+                      "ref", "s_axi";
+        xlnx,num-priorities = <8>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x80040000 0x40000>;
+
+        ep_mac: ep-mac@16000 {
+            compatible = "xlnx,tsn-ep-mac";
+            reg = <0x16000 0xa000>;
+            dmas = <&axi_mcdma_0 0>, <&axi_mcdma_0 1>, <&axi_mcdma_0 2>,
+                   <&axi_mcdma_0 3>, <&axi_mcdma_0 4>, <&axi_mcdma_0 5>,
+                   <&axi_mcdma_0 6>, <&axi_mcdma_0 7>, <&axi_mcdma_0 16>,
+                   <&axi_mcdma_0 17>, <&axi_mcdma_0 18>, <&axi_mcdma_0 19>,
+                   <&axi_mcdma_0 20>, <&axi_mcdma_0 21>, <&axi_mcdma_0 22>,
+                   <&axi_mcdma_0 23>;
+            dma-names = "tx_chan0", "tx_chan1", "tx_chan2", "tx_chan3",
+                        "tx_chan4", "tx_chan5", "tx_chan6", "tx_chan7",
+                        "rx_chan0", "rx_chan1", "rx_chan2", "rx_chan3",
+                        "rx_chan4", "rx_chan5", "rx_chan6", "rx_chan7";
+            tx-queues-config {
+                queue0 { xlnx,dma-channel-num = <0x7>; };
+                queue1 { xlnx,dma-channel-num = <0x6>; };
+                queue2 { xlnx,dma-channel-num = <0x5>; };
+                queue3 { xlnx,dma-channel-num = <0x4>; };
+                queue4 { xlnx,dma-channel-num = <0x3>; };
+                queue5 { xlnx,dma-channel-num = <0x2>; };
+                queue6 { xlnx,dma-channel-num = <0x1>; };
+                queue7 { xlnx,dma-channel-num = <0x0>; };
+            };
+        };
+
+        tsn_switch: switch@38000 {
+            compatible = "xlnx,tsn-switch";
+            reg = <0x38000 0x8000>,
+                  <0x00000 0x14000>,
+                  <0x20000 0x14000>;
+            reg-names = "switch", "mac1", "mac2";
+
+            interrupt-parent = <&intc>;
+            interrupts = <0 2>, <2 2>, <4 2>, <6 2>,
+                         <1 2>, <3 2>, <5 2>;
+            interrupt-names = "ptp_rx_mac1", "ptp_tx_mac1",
+                              "mac_irq_mac1", "ptp_timer",
+                              "ptp_rx_mac2", "ptp_tx_mac2",
+                              "mac_irq_mac2";
+
+            mdio-mac1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                phy0: ethernet-phy@0 {
+                    reg = <0>;
+                };
+            };
+
+            mdio-mac2 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                phy1: ethernet-phy@1 {
+                    reg = <1>;
+                };
+            };
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    ethernet = <&ep_mac>;
+                    phy-mode = "internal";
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    phy-handle = <&phy0>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    phy-handle = <&phy1>;
+                    phy-mode = "rgmii-id";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 08e43bc09735..ba41c224dd02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29607,6 +29607,13 @@ M:	Harsh Jain <h.jain@amd.com>
 S:	Maintained
 F:	drivers/char/hw_random/xilinx-trng.c
 
+XILINX TSN ENDPOINT ETHERNET MAC DRIVER
+M:	Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
+M:	Srinivas Neeli <srinivas.neeli@amd.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
-- 
2.34.1

