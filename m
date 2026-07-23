Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603644963B3;
	Thu, 23 Jul 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810365; cv=fail; b=IgNG15BokmTc7F1v200AmxcdjSmRWsOj/SHQMM4Auxx6jydeitjQcKfr3yicBVTKd55fPhNw1YZsvkNK+46YzVNj3Ebp4FtYfD4yklwQhFFgFdPBg2C1PRJFyfU088+C0Yes0+mqLq7/D7YR2JOhDHOfqSkHcr1vvNdzOw3NNmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810365; c=relaxed/simple;
	bh=y5GStdkzroy7gOOG5M0QUwrhP3qX2IJSRRKtZ2WBBP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYSY3DXCNEjPOMFEwNiaYre67WfjOrlxJ6DAj9UVxeVpMjkCgrNlRGgY63uneuE5B0eR1O+dGqY0/noRhhXw3ZgNG9imfKWQpLvtD5w8RSt3k8+9O48uvOsxdP5oSwBl7XiU6q70HNOyG2Rn0POlQy5Qvinb2qT0z81cK/7f+Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4iTyfjiH; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4iTyfjiH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYeIIAQLL+T7BES6dWcqa3gqtOcacdV9cYiLzV85WYxIGlm4MQqHljb0j5woBD8QHeJF46Spyt8717eJJBNq8uuGfKpLw3WIWxmyfQb1JcSYT/nkkuVXF0yD+M+BPllEUNcPylkMuy9lK/fKQhnjdIlruNcT+DZo19qL/WsKyElDPIj3Stkxr5xyf/iDaLdtiNHS3pj7OwAxFEMSce1prANCdep0HzzK0V2Ai4DRd+fhGo66j9RoWvXfWCfpyMoFcOeA/JQvmXk+v5PsBRphGb0R9+CILpiCRWuCcjDVWLWuDRSN2pYY0g3LdahG7KzYLuBbU9nKHTlKgbKyYrK0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/BYQEtQsjb6+WL1CElUeN1pQH5WgEP9ovBKrauqsJU=;
 b=Hhoz0R90O+Q31g3cNTs7F4JrqolMSxlUdKvTUH6THsH60pGts9cU3/zJw706JTIeXdBPx33fVDEbciS0mdYCAvU3BcszPjlzFyz3ujFXamvX5Qs0lts8P9T21ecvQlI+UbDSWcYFFs27UKCyoe5Cn9Rd4fAf2cKynoylQYUKbgrMyFKnguWfiZtPPEILxlhmNtNttBn5p30pkXE/hiMGfFnMqt49yc5blMuoVlKuIU0Xb3zy71HTAT4EPQe2PU4pq0+rP5YQJ4og2b/Repk/FFYEBsYFf1IffyWEF6aWwiND3QuyJWn9dS32rl43XUkakyJXNwMOduZjJJAsqMa8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/BYQEtQsjb6+WL1CElUeN1pQH5WgEP9ovBKrauqsJU=;
 b=4iTyfjiHzzfO+es9w/rGc/6Wl+FBDvsFpck0SA+S0qELIp+BQddFNkbH6731O4EhDE07v5CWlArJL9SrKxdCZM4jhc9bFtVv9P11t8L8JSG/XFi3AFvPRz6uH99ydC9hzZJNNN9TtYvsYbJBcbPaFm7jJ85HJBb/HAmR0SFmJg8=
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:39:16 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::5b) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 12:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 12:39:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:39:13 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 07:39:06 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>, Russell King <linux@armlinux.org.uk>
CC: Shyam Pandey <radhey.shyam.pandey@xilinx.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH net-next 3/7] dt-bindings: net: xlnx,axi-ethernet: Add 10G/25G (XXV) ethernet
Date: Thu, 23 Jul 2026 18:08:34 +0530
Message-ID: <20260723123838.125145-4-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723123838.125145-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: ea58e0a2-2aac-49e2-56c4-08dee8b7685d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|82310400026|36860700016|1800799024|13003099007|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QWL2S5Zb6R8YrmiVh216aRIA8JxB0OMEg+KbAeQs1okkK1z84H1Gj0aNWIcF8dxVS2pHdEP3r9b88jkGfwNX91cT27Z2kXY7tV3U6SZgrhbMnQ60S6U8DhMhyKmj+hRj3GZfx066/FEYZxIQ0PoPkt2ARdFbanH9R1mMo0WeNRktHEarbpQtH+Uvvrd0FtrtG2KOaPcrpmqscPYGQ2VX4fRQhbepXy18N36B79Ap4gs44nQxUABGyL3O58+DdIlMZiURhEqyRV6TEDVk/z7gM1zdNss69j7zcrfUNVFSZ4oCDr6f7S4Rv/9oOYJWDfcELjkSa9ConX+zgtXWgBraBCur1xWDvA4IOGVSIxrOG0ME9Q9UFIIilPU/lbfu7KKlUtBmYXZO673Ut1yIJxEr2EpFFu3Y8LLK2Qb562IfMyC1LOMGsG6B2rjE7Z3lXejN0NVT8Og6TciunAkAxvo9rt8AV42oVI5A2yUeVOr+aBN+SJA0OCbqaeoDzxYa29o27HLHXRnvs688pjE37iDsOK0Ym4tqWDqim9NLfeHM/poIRjptRbeNjCS43+8wiM+O+KULwlGDpR9k27ro0pz2KsTx8jy27rwLBWlJrxwPUOHrTtIJcC/GZrMhqP5ZvpZBUSFMAsL9ThwjGlPO/jQUKGQ2u+9UO05eDqfmhW7Yg5zhkTxahPFSqCcjooWkagq007Fw8BkNQLx0QZIIRt+fmQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ewlO11Ur6+/uXKfBxAi0AA7qerwybI6UjWpXw/lA08aomjVf46ZjiCJt5IXpD9yh6H3SvbIBIdpaqsIcTxr8tLl/W0BeiVp15lPRsPRYuL8zZPv2bC4ojabIwgj40qoLp/N/wnYsFDmj4Cdgr4kOdiiy8351fqDaUmVxWXl1GmbpymXTJ6iyOKghlr8s4fEqvP2xossySds40GtBvyKQOxOOlYQtMhQLZet9dAaw/Cxs5zlYbBqtleYnK9be86V9bgZ024iXtsHVgKuv6gKvN0l8GZarGantNmpDGgRW21K/kyvEzsJsXxH7/NO99Xf1jjuGYXKkEhG5b9fPKFegSq3yVERcrw4d83KR5CnxLyYg/CzCDONr1ZrP216Ex/aZd86dXHsCJuHAVvbXSmZN+NOMGNyl02Ayvu9ur1zR7LCNCszJ5nQMr3kthmkoIYG1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:39:15.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea58e0a2-2aac-49e2-56c4-08dee8b7685d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

The XXV Ethernet IP integrates a 10G/25G Ethernet MAC with an in-core
PCS/PMA driving a high-speed serial transceiver. Extend the existing
xlnx,axi-ethernet binding to describe it.

Add the "xlnx,xxv-ethernet-1.0" compatible and make the resource
requirements conditional based on the XXV compatible string:

  - "dmas", "dma-names", and "phy-mode" are required.
  - Interrupt properties are not required as it does not have a dedicated
    Ethernet core interrupt.
  - "phy-handle" is not required as it has internal PCS and PMA.
  - Add the 10gbase-r and 25gbase-r phy-mode values used by XXV.
Annotate the existing compatibles, generalise the title to cover both
variants, and add an example node for XXV.

Define properties at top level per binding style and use if/then to
constrain requirements and phy-mode per compatible. Forbid 1G-only and
unused ethernet-controller properties on XXV nodes.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 .../bindings/net/xlnx,axi-ethernet.yaml       | 144 ++++++++++++++----
 1 file changed, 117 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index fb02e579463c..23b1a27c04e5 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -4,36 +4,46 @@
 $id: http://devicetree.org/schemas/net/xlnx,axi-ethernet.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AXI 1G/2.5G Ethernet Subsystem
+title: Xilinx AXI Ethernet Subsystem
 
 description: |
-  Also called  AXI 1G/2.5G Ethernet Subsystem, the xilinx axi ethernet IP core
-  provides connectivity to an external ethernet PHY supporting different
-  interfaces: MII, GMII, RGMII, SGMII, 1000BaseX. It also includes two
-  segments of memory for buffering TX and RX, as well as the capability of
-  offloading TX/RX checksum calculation off the processor.
+  This binding describes Xilinx AXI Ethernet subsystem IPs, including the
+  AXI 1G/2.5G Ethernet Subsystem and the 10G/25G (XXV) Ethernet Subsystem.
+
+  The AXI 1G/2.5G Ethernet Subsystem provides connectivity to an external
+  ethernet PHY supporting different interfaces: MII, GMII, RGMII, SGMII,
+  1000BaseX. It also includes two segments of memory for buffering TX and RX,
+  as well as the capability of offloading TX/RX checksum calculation off the
+  processor.
 
   Management configuration is done through the AXI interface, while payload is
   sent and received through means of an AXI DMA controller. This driver
   includes the DMA driver code, so this driver is incompatible with AXI DMA
   driver.
 
+  The XXV Ethernet Subsystem integrates a 10G/25G Ethernet MAC and PCS/PMA
+  connected to a high-speed serial transceiver. It supports the 10GBASE-R and
+  25GBASE-R line rates, with 25G operation following the 25G Ethernet
+  Consortium specification. Its payload is moved by an external AXI DMA
+  controller rather than a DMA engine integrated into the MAC.
+
 maintainers:
   - Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
 
 properties:
   compatible:
     enum:
-      - xlnx,axi-ethernet-1.00.a
-      - xlnx,axi-ethernet-1.01.a
-      - xlnx,axi-ethernet-2.01.a
+      - xlnx,axi-ethernet-1.00.a # AXI 1G/2.5G Ethernet Subsystem
+      - xlnx,axi-ethernet-1.01.a # AXI 1G/2.5G Ethernet Subsystem
+      - xlnx,axi-ethernet-2.01.a # AXI 1G/2.5G Ethernet Subsystem
+      - xlnx,xxv-ethernet-1.0 # 10G/25G Ethernet Subsystem
 
   reg:
     description:
-      Address and length of the IO space, as well as the address
-      and length of the AXI DMA controller IO space, unless
-      axistream-connected is specified, in which case the reg
-      attribute of the node referenced by it is used.
+      Address and length of the IO space. For AXI 1G/2.5G using the legacy
+      embedded DMA, this also covers the AXI DMA controller IO space, unless
+      axistream-connected is specified, in which case the reg attribute of
+      the node referenced by it is used.
     minItems: 1
     maxItems: 2
 
@@ -62,6 +72,8 @@ properties:
       - rgmii
       - sgmii
       - 1000base-x
+      - 10gbase-r
+      - 25gbase-r
 
   xlnx,phy-type:
     description:
@@ -93,19 +105,12 @@ properties:
       selected on core reset (i.e. by the basex_or_sgmii core input line).
 
   clocks:
-    items:
-      - description: Clock for AXI register slave interface.
-      - description: AXI4-Stream clock for TXD RXD TXC and RXS interfaces.
-      - description: Ethernet reference clock, used by signal delay primitives
-                     and transceivers.
-      - description: MGT reference clock (used by optional internal PCS/PMA PHY)
+    minItems: 3
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: s_axi_lite_clk
-      - const: axis_clk
-      - const: ref_clk
-      - const: mgt_clk
+    minItems: 3
+    maxItems: 4
 
   axistream-connected:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -139,15 +144,88 @@ properties:
 
 required:
   - compatible
-  - interrupts
   - reg
   - xlnx,rxmem
-  - phy-handle
 
 allOf:
   - $ref: /schemas/net/ethernet-controller.yaml#
 
-additionalProperties: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,axi-ethernet-1.00.a
+              - xlnx,axi-ethernet-1.01.a
+              - xlnx,axi-ethernet-2.01.a
+    then:
+      required:
+        - interrupts
+        - phy-handle
+      properties:
+        phy-mode:
+          enum:
+            - mii
+            - gmii
+            - rgmii
+            - sgmii
+            - 1000base-x
+        clocks:
+          items:
+            - description: Clock for AXI register slave interface.
+            - description: AXI4-Stream clock for TXD RXD TXC and RXS
+                           interfaces.
+            - description: Ethernet reference clock, used by signal delay
+                           primitives and transceivers.
+            - description: MGT reference clock (used by optional internal
+                           PCS/PMA PHY)
+        clock-names:
+          items:
+            - const: s_axi_lite_clk
+            - const: axis_clk
+            - const: ref_clk
+            - const: mgt_clk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,xxv-ethernet-1.0
+    then:
+      required:
+        - dmas
+        - dma-names
+        - phy-mode
+        - clocks
+        - clock-names
+      properties:
+        phy-mode:
+          enum:
+            - 10gbase-r
+            - 25gbase-r
+        interrupts: false
+        phy-handle: false
+        pcs-handle: false
+        axistream-connected: false
+        xlnx,phy-type: false
+        xlnx,txcsum: false
+        xlnx,rxcsum: false
+        xlnx,switch-x-sgmii: false
+        mdio: false
+        clocks:
+          maxItems: 3
+          items:
+            - description: RX AXI4-Stream clock (rx_core_clk).
+            - description: GT DRP clock (dclk).
+            - description: AXI4-Lite register clock (s_axi_aclk).
+        clock-names:
+          maxItems: 3
+          items:
+            - const: rx_core_clk
+            - const: dclk
+            - const: s_axi_aclk
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -198,3 +276,15 @@ examples:
             };
         };
     };
+
+  - |
+    ethernet@80000000 {
+        compatible = "xlnx,xxv-ethernet-1.0";
+        reg = <0x80000000 0x10000>;
+        clock-names = "rx_core_clk", "dclk", "s_axi_aclk";
+        clocks = <&rx_clk>, <&drp_clk>, <&axi_clk>;
+        dma-names = "tx_chan0", "rx_chan0";
+        dmas = <&axi_dma 0>, <&axi_dma 1>;
+        phy-mode = "25gbase-r";
+        xlnx,rxmem = <0x8000>;
+    };
-- 
2.25.1

