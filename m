Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B12E2663;
	Tue,  6 Oct 2026 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284763; cv=fail; b=TPu43uDVF6uoNs2OV8b73wlx1Z475lmfQfZusU/wV9kyxTAzbDfp8ZcNFgTeBbH4t06zAmOFNKWFMPuPvxbH73qJFf+/nn73hfV/ugG2b6OkHzUAmVYVfx1o6EasRbawmVBLsZMt6rxkXWXDT5Rkmx2YmGT7i67oShurdKTTKzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284763; c=relaxed/simple;
	bh=1TsRowHq7R6ioYJHSzRsQ9fI1nAp6b7feKjhp62wgF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mDMN4f9B+7oIFc8W7aeE4PJeCdf4h4vj8kdf4wRzmLsm5hJzM+YP15gMstk9ljKiZd4w+qB2whX2oD8oHZM3EL4j+5mvExF6eUrumhDzz0egGsFwsc5PXpInZN+BJLi5SFw5541EHE0ae6SSyxobYYILaP1calb5qGwU2rjTfgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=06uifbl0; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="06uifbl0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oflkZc/SoZwsFI28ILjUKT8/MTBniv1ah0oaUlXfXdbab5Fq+vgT+ar8Rxf/d3lQQMkJmlom2ItDvO6Avcup2qinxOnAixGwOeOCrVNO8mqhXOeD1kkyFqfgi1koWorDiU/ucvsA7Suv1Oy8nZkVqFZn799XA9X17VF+KJJfxedZKUHIzjyfbr9PHBfbDEqEOwSFhF+vLu/aWocYNKIjR8EJXmsV4m8S1myI9E6qk1QxKatbaZK/9iJQYZieLQIxU/EaPt50yIvD7IrtzfRzHMONtFsNXs0jZVour1QsGPjcedTJomHwJt0stj3Fg3th1w0uP4qNuF68rCecfJcIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFXgUPmo00dJPpVBV0dkMD/ThJbqus93JmA6JjuYsDE=;
 b=dAfdzM4013HwPk8ojD4UfEfZfBMfiRms9WuRj0QV25u9yNYTlsW0AIRt4m+DnwA1lljCK2TtofzDaU7RX7EIbZgUNwrHZcJpDKsVePMzEK13ZnCRkeFgw3/CvafaZ7DIRzThrqD3CnxIphiQgMDbjuKtKP+6AvcRPBgRDkp83M2pyKcgpt+fj0lVaAzHd2vMAA6e/uEw0gCXy4I5n/ZbgQAydZPGCgWKO7q7/S0/qndggExELHCiPyvrRdFwJXa32+2+Q6jUa0lwDP9lW9GR0H81N0pHyLsOikQSXRZ2/FnFJEUC79ugEKghjqZr8XuqRsj34OD58ncLFAH0xyEyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFXgUPmo00dJPpVBV0dkMD/ThJbqus93JmA6JjuYsDE=;
 b=06uifbl0toYdMmlZ+6DMMucRN3PNPTlbpkCv47MBHmLResUr+wQz7Qrf8IdUEWZkuykfj62ExZEhjHdvncbhj4raCL9IG7NXRMI2xRLNRkUBT1mRWNjhg/JuJncn5WlByFcFxJOF3Eu+z4bwyoN9Vk+6hkoJlJ3Bb6MAXLbP1y0=
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Tue, 6 Oct
 2026 11:05:56 +0000
Received: from IA0PEPF00000045.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::8f) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:05:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000045.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 11:05:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:05:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:05:54 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:05:50 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Michal Simek <michal.simek@amd.com>, Russell King <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 0/6] net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
Date: Tue, 6 Oct 2026 16:35:44 +0530
Message-ID: <20261006110550.1990213-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000045:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf9950c-21b1-407b-8d6e-08df2399cb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|13003099007|11063799006|10067099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	SlQiRBxRAm2daIOc6gJM/Cj0ZdsgpXsKWUdsNvEvCdEd8wLbEVRrPOFaTGdKYHQMyc1NR+IwRX1YntSS0mr5TyV6D5b1Cg6QKLY5hzHk4lH1a34kW8Xd3Xgp8n/xQpNBh8HaEwPrBlsMZWBIgUdc7TCY7x3hWdrFmGGPlkdOL5e61M7XT8MMN0aKDWOq8XiB4UkEZhRrnsktVTXZKAVya1GHhsalisslPtj76R5G8lDHt8YWom6lc154yDULsNPtO/JXbEpnhd7t21e8jWc3VQq9Mx3LWymhpVHjAix9LcGq0TPyDLZ2/Y73yrLD/dt43BX2jZiGmDYIGgjj+ES6K3HZV1mb6RdPBKGFkDIbsiTVDEyGGTbzF2mgHHw16M1ChSyl2yLOGUYku2YyHyGK6YA3rL1RvaV85Zg7QGgc7kwt6YxaJK2RQ3BmAfm6qhh8RE8n4Lp6e59Y2kE/QDixF0Ytj0IFn+cfjwpzDBi9G7V7b59TkgN1xlh58ldJa3rrcel7+NWhGh1QB7LCFe/cRRURx4FJWa39Al4f6WsHZh1Uftv3g53bMTNXVYNtLfPHW9bFTG9pbEPkECgJN/h0RttERMnr/KqoweNK86suQCNQyvpEIJSfi56FUfrovwrg6XvV6EwqPuWx7emUlfcJCzZk7IuJpZ65ieAdQBKCgscwsh5O3tml9Ya3KTP8XHQ97+uY3Yx4MtZa7u0LZoEbiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(11063799006)(10067099003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	egyumX6JKD4gppYnBz5dyt1AMJXTLjR9AfHtuz+ZnZNNFq8Vpyq7+fx87TQJZt8lCWJ7Y+bviWIZoaoj44r78vKpM9HEeWSO/mOWQbmqfKFqNU9XeJjgkUi27jWajW0L2wA8D+e59yDV8oQ8j25gFawI4rsEbSHXsyhu0B/PoI4a4FXK0WOL9QjRxirGdXdNc8LUEq2Xuc/UtJM06DMtgrs7MkHn05nGwXKISiEJyi6ca/9Kra+hnChAZzhodLhCLIM4Frv1sRcDXqAtMsr2wyfeg/eIDN/3T+r69yLdQ8LUrJ5TMUvgtGCMsHZQ4o/pdpv5wQxLXq/ksviol+eliPchL7jSCekkMbi7JnLuPoG8bt2ip4A7QrekfjrpZcXRPNibVihypBikHfWAFqaPNexT49p3wspavpcJlw0YHmDvr3HF4uTb+lCiOAStVNCy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:05:56.0325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf9950c-21b1-407b-8d6e-08df2399cb7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000045.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

This patch series extends the AXI Ethernet driver to support the
XXV Ethernet subsystem.

- Refactor through struct axienet_config so per-MAC behaviour is
  expressed as capability flags and callbacks instead of runtime
  MAC-type checks in the shared code.

- Document the XXV IP in Devicetree.

- Add support for the XXV Ethernet subsystem.

- Add a preparatory RMON cleanup, a statistics-ops refactor of
  struct axienet_config, and ethtool / ndo_get_stats64 counter reporting
  for XXV.
---
Notes:
- This series depends on [1], which is a pre-requisite.
  That change is required for this series to compile and is not included
  here to avoid duplication.
- The series advertises the core's active 10G or 25G rate only. Runtime
  switching between 10GBASE-R and 25GBASE-R is not supported and can be
  added later.

[1]: https://lore.kernel.org/all/20260929081316.803997-1-srinivas.neeli@amd.com/

Changes in v4:
- Drop the "legacy" nomenclature and use dmaengine / non-dmaengine terminology
 as it might confuse with MAC instead of driver flow (Andrew Lunn).
- Patch 1/6: Gate the "xlnx,txcsum" DT property behind the MAC's tx_csum
  capability, so TX checksum offload is not advertised for a MAC whose
  hardware cannot complete checksums (Sashiko bot).
- Patch 2/6: Reword the binding description to state that the
  PCS/PMA is integrated into the IP, and that MDIO bus unavailability and
  SFP module (I2C) management are detailed in the IP (Andrew Lunn).
- Patch 3/6: Reword the dma_err_handler comment from "legacy embedded-DMA
  (1G) path" to "non-dmaengine flow (1G MAC)" (Andrew Lunn).
- Advertise only the core's active line rate.

V3: https://lore.kernel.org/all/20260831150816.1020883-1-suraj.gupta2@amd.com/

Changes in v3:
- Dropped patch 1/7 ("clk: Add devm_clk_bulk_get_enable()"); it has been
  applied to mainline as commit b698927accb1.
- Patch 2/6 (dt-bindings):
  * Added Reviewed-by from Rob Herring. Thanks Rob!
V2: https://lore.kernel.org/all/20260806181153.1213996-1-suraj.gupta2@amd.com/

Changes in v2:
- Patch 1/7:
  * Add Reviewed-by: Brian Masney <bmasney@redhat.com>. Thanks Brian!
- Patch 3/7:
  * Split the XXV binding into its own schema file
    (xlnx,xxv-ethernet.yaml) instead of extending xlnx,axi-ethernet.yaml
    with if/then branches, per Rob Herring's review.
  * Add a multichannel (MCDMA) example.
- Patch 4/7:
  * Require both GT Wizard reset-done bits in axienet_xxv_poll_link_ready()
    so polling does not exit before both the TX and RX resets complete.
V1: https://lore.kernel.org/all/20260723123838.125145-1-suraj.gupta2@amd.com/

Suraj Gupta (6):
  net: xilinx: axienet: Introduce axienet_config for MAC-specific ops
  dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet
  net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
  net: xilinx: axienet: Make axienet_rmon_ranges non-static for reuse
  net: xilinx: axienet: Dispatch statistics through axienet_config ops
  net: xilinx: axienet: Add statistics support for XXV ethernet

 .../bindings/net/xlnx,xxv-ethernet.yaml       | 110 ++++
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/xilinx/Makefile          |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  90 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 610 ++++++++++++------
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 592 +++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  | 141 ++++
 7 files changed, 1364 insertions(+), 183 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h

-- 
2.25.1
