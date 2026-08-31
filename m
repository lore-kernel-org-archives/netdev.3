Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F75293F8;
	Mon, 31 Aug 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188909; cv=fail; b=n35TmDR+pwWU0TtTGdUBPkiay37eLNR0Vno64jdSrL9G6us6gQapkTblwnsrFi+g9AVp8FWm7loxTh/3C+BwmiAT/mh15GGuf219yQNlNvvysARrz+Ic7HypXKIvjqft4WN0xblZ9cUK7oqVchfjM6DdwkIWhwvMohF8QT0rgps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188909; c=relaxed/simple;
	bh=oio0HkZIrL1pznerRGIEqnL6VyWPa0YqhgO+e22CU5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iaL0QJeMLmYSFaZjnMG6ukSKqqCOjRqxLktPM8E01zb41I5Vfnvhn7zdmTsb6upaLokiqk//N3bcToq8joAx/bcVb0QY0mQ6SAjBjxpRp0eZ3KOxSXGEbA/s9pXMU/1EOADpNbsiZy8XWWO5OzPeSQWBaGy+w3t4PMupmaVmRnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ov/NuVxt; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ov/NuVxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFZF4bOsvngRZHlxHsGEq84XLw5KD2XwwAX27+JYQ8k0sLxFBfzPDY7F53hut94WkX3futx2lYFD1Fvu1xP3+8HpST6uCCdFDWpB2wn6PR2uqtkpF2Qa+FvZuuToZ8kaw6mt0oPQeOr2SI0VlrQ4ASXqQoWt5ajY0AKb2YMnzDxD5B4Bz4iTQcHmHIejWN3UEsXj0R9xutbuNQIb44y8v9q64jEuUudA8H/PA8oBfM4uI7nEoz+pslFnLa/8OMNDZfdBRNHVDc1SfgKgQaKuQg8sn/2HWPwFrDS12eFM7gzVlrR9AmHAzP/apDFvCL8iTzojBBR09trruA1NZjww/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrdBpWaXJRHFD0U34k2w9fEW1QU2au7coORiVdz8l1E=;
 b=oARjpBettGUq1HrUZhn43O1eNnArXWW8pBF/gzAq7X+WGoHkvCsDrgf0h7bClvmKP85AANJBx33GCxImoXB9yQMz6Hw4tPhQkBMDcosw6xj8gQOIfRsO4frmm+QNszGcTvD55q6pawov5lLAfGhPcZb0QUhx1Kt/VbG30z0XjPHiY1eRK9CV8a51jkqU+zU3sOzCZ7EyYLkaabth9+3IUuwsSuhScKQ1lufYlSI7eHdpkaMjqMCpiKctEpM4XL0d05izMIWdF8JFkrXpPx4Tb7MZh+3X8tSBz+j8+N7xAU7IjbUYyCerfM8/gzwE0C1MFWEW92Yvfysb8txGjPbCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrdBpWaXJRHFD0U34k2w9fEW1QU2au7coORiVdz8l1E=;
 b=Ov/NuVxtg5TRvNwIlU6of/YK26E9WBGC/QCS50PFvfJ4BZ3Dm0GlU9fT2eikUGd3p0l/tWSYIsU++rK6S/ogxTXaLvYpFenv7V38wVbApo9xTH0UVktVQZZ1aimRfV2FgBROZ8K3FjyyOYXde/5ToHN1ifhKN+EFXy2V+h1iu1Q=
Received: from BLAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:208:335::8)
 by CHBPR12MB497579.namprd12.prod.outlook.com (2603:10b6:610:33d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:08:23 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::22) by BLAPR05CA0026.outlook.office365.com
 (2603:10b6:208:335::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 15:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:08:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:08:21 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 10:08:17 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 0/6] net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
Date: Mon, 31 Aug 2026 20:38:10 +0530
Message-ID: <20260831150816.1020883-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|CHBPR12MB497579:EE_
X-MS-Office365-Filtering-Correlation-Id: 133ddd02-7589-4ca2-d5ea-08df0771b326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|921020|10067099003|11063799006|56012099006|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	+2ys7HKcvjEE4j+aYQEgdQbi7knMhhFgTIZFGJbOKLniZOSvF8fWJjZOMoSpAyvGqJ6JhP1Y6DdxefVipSeKSVtxSWCBCxxApFYEBZ+VezV+K6yeW3NN9MskDuGrxDcuB4XjpKXCPMAdDGkDPwcpNaoB7OV0803Xqide5aTVOGeFWiUu82QgzewObymyQl7aZl1P1AryO/0zDsg9BOsXDJ4dYvmmaBj4ikffvbVAx3n+joOK7p3/wnz0ER+TkGoPwiMyI6beu43E6cg6mE90Dwc24pYQbMeXkqauYTeW5HVaYY3ptUB/i7A8taT4ZTXgIayk1gilpaydoWl5Ng0QHDEJTwMoU0WPYthjT/2XV8kM5/B0D7ItCvja/ZoITTvHyDSmQ4egkop5jbmV/G2V4FsA+wTaPk7xyEr48nMWvc3G7/FhQJsorRtT7hVx+t7XoR7pevaZ0LwiS4nSzOfAeMNZIF5Z+g8CZp7zwpg4a9YyiepPVsfoDLiLM9f38b24hrCR/RttPbU2Y2JRtRJRRHGDIvKgydV2n9YfWzQPLEgsXQSAJiRznF/lvStmF6r53awHzup3d7tD3jPTpvIUMOlz+oZin0FjAfRBFx2U5hqHHYBRJi9xTiRS2lIuT3v3dQ+7wRhbj05jNGGNv75svhfRAeV4jBtRd8WFIvF88VL6v1np5HTwQwXmxBRiA7CkeTAIEUoh+Eo3R0k222z9kVH4PS1BnXkRzkyGjwOg61zrgSf7qHzuihtn8g+YYu2N
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JcTe+o83vkLAmS+rcTOSdY70MZIjibdcIk6Z3Hps0RoX9P88Y9ew2gAikBkt1eHU9nVs9vQQBLoV6FTw0hELDF5IpJnTE/VIFORLCIg+Wwi5CA+j5GbveTT3oN2XgxHbho5j/0evbNyr+Vjhj5iQJ4R4QF4p3AmMm+jGsSxUEY+/akclHA7l9FX4BKuve85+/rbB1EQkgPhs2qikRGf/Z/A5hROEJM5J4/TXC34fwIaebsZHrL4VE5PN0s8bRRbvyucD2a8E61YdYnT46/OvDWBs4BpGzQT5YwKlYw5jFIg5LToUml2BpbpheCYBlrP1jsOFzY1UFTJIA/muEFW+XutODYu1GmfUPejK509n+CViHhDanWe7/OUVfIfGgDSbhJGIoAHCS6pKiNpv6snW9I2VyBpfeKMkLiq9M4xiZcMm5nbUKdRnW0sY8jUwAvPd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:08:22.7839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133ddd02-7589-4ca2-d5ea-08df0771b326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB497579

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

Notes:
- The devm_clk_bulk_get_enable() helper posted as patch 1/7 in v2 is now
  in mainline as commit b698927accb1 ("clk: Add
  devm_clk_bulk_get_enable()"), so it is dropped from this series.
- This series depends on [1], which is sent as part of another series.
  That change is required for this series to compile and is not included
  here to avoid duplication.
- Due to phylink limitations, we aren't able to advertise both 10G and
  25G base-r interfaces and switch between them using ethtool.
  We are open to suggestions on how to handle this.

[1]: https://lore.kernel.org/all/20260717090824.2364230-1-srinivas.neeli@amd.com/

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

 .../bindings/net/xlnx,xxv-ethernet.yaml       | 107 ++++
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/xilinx/Makefile          |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  90 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 603 ++++++++++++------
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 595 +++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  | 141 ++++
 7 files changed, 1358 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h


base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
-- 
2.25.1
