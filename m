Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF3239E60;
	Thu,  6 Aug 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039939; cv=fail; b=D5t277f3v6DvK0sQW87+2WIh4UBUdcZ5MQuPPE/jOdoF6HRSkI5WnnR0AVCkXU2BjgePiaVqAUaOnWu4bP+7bz5D4OQRbnEopwXgSmSaCHSYJ3yDHytCULIVQuA4THIn03icrL6/UioDDrDBTYXforXwKQFReoTtdju+4QMBj1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039939; c=relaxed/simple;
	bh=myDxO/HqlSZCV/YQOVW06t9qj8ZFEzkW5Szo91Bi/Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqpJ1gD3j9EDG0ajX8JFCP3ZjJ+4RcGEBTnmcZQWvnV7YtXAkSoZBxOk6JPAICDik5nvRoEBsNkhWgzSQMI51Pfun0C1x2zcgiPJ03YLSAsZ586OaTNnLZIYmXb+hAMMjCvQFaBdEGf7DpZiQNm6mrFghiSwb1m5OCsKlGxQbf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W+4wy311; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W+4wy311"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0DqtPeXBDqS5pOGM9VCrTuQk7q4F5+f1HXp1fnHRh5GAUNnSej94dMUd+Gemj4gnaBNgDJnMxcemCtdLEMevQnpnKPFGBnnhGTqdjxnd3fcioq23+K0o4knADmaj4soGCTLuaUM1gpc1kkTX7oENvdaXjF+6EA0OQ4Y7mJrbrNMyIAUTzaqkTfLb+hPIZFcWCAAP2+L+kEHu7dPkHig1g7erW13w6nSzdEhUuvoDRz8aOBblXOII5ZVLYgOxpJ6SkLVC6ymxHI6KG0bSaJdhXGaY4ywROy4/Wz70z4kTLpUiUZ4prDvec8WCMHDPY8N6/6YNiKUbW1/nC629EoD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kCFpQh+EQJQ0LCC3WIaX1KslN0Dp6DhUszXmPhw3Ds=;
 b=Zs1QVdS/LLIQPErbOWky3jDQzqMwDnkt48AfHaQnf0NUz0E3TM2ocWw1JYLetiuAimLxfsBsjzFWNWsoFAjveT5/yLrLYjN+Ut2PdUcYcfBOTLyiXYyY82OfseygjEN4DOb5f1zoSfu0t8FHXj7t6V86sik0JWdtRm7HuKq6cBVoH0yNp0zXDZecZ4eEEyIy8fgYpSheP1W5q82kGlhToY4XOIGB6O6yV/IyfF0Yu9o8+cbbGZtJAeFJPILhUPP9MrE1sm4Mrie6vgIgZ5hoJbretCFraNWNaSsLx2IVnRzENLkRdtuIsDVwjwx3+b3FqDRGzujj+b9xGoeYLaqXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kCFpQh+EQJQ0LCC3WIaX1KslN0Dp6DhUszXmPhw3Ds=;
 b=W+4wy311ez03W4O2nHpHfsRzcT49WWCqFn0vUgYKsEkjCfn9qIGUqBt5wlUqEVcTkffz884642qFuxoagODU7yEtXE7WLcexOHLsKCySqZ5I3LiAzLPq7XcPYH2kz8I7d1k8f2cArin4eTGA12tgqYcRq2ZQxPj+BUCI9S08HAY=
Received: from BN0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:408:e5::26)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 18:12:10 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::23) by BN0PR02CA0051.outlook.office365.com
 (2603:10b6:408:e5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 18:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:05 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:11:59 -0500
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
Subject: [PATCH net-next v2 0/7] net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
Date: Thu, 6 Aug 2026 23:41:46 +0530
Message-ID: <20260806181153.1213996-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd23e06-f0f1-4671-b845-08def3e63b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	L6U1TGZpDPTqiLDDhWz06IC5lKCxcFnwO7Rsc0Y4f/PGKrU25SfYMCN4eIP0zQxa1L0qWnuQm/ZaH2lBily2PQpEavGnknBW9QUkG8H5FXVqG5VJ4uOoiBbAkP2JPSSsulwCWRHfWI39uVw351QprQlBP/eWT7Sje39hdvoI8+lyxIOdVZIHV3eA4n9wEKLlcfHxyR+CXTXBYm3Ylw8J3Vn6636kxz9dc3078hws4nKoXebHuvMen+Kwu2BMicAHd3vZefoOQkEhu/bTIt/1TYXsAlZT8Eh5Uy90AC+D7gJGcEaRSgfSXiF7NEoYLfQawopN5cv3BaA9WJh3GkhREuZwHDxqqqyJJpx0Rr1SWpexEtIkXoRdasTkuNJFdXyyetevCoUyPuuhF30SVakW6l/M9UeNSBEDQsjy0jvmfE0LjImiipMdtnlR7OVee00D59PgLQdiIbmoeUJGfqky44b6beJB6kUfZhK+1OgzUd/3IRl8YDlAmp4xUX+DkLuZSKp2ZG0fQzr/lcKwtbZAZegLl81Ra/O/lks5Gxp9pGDAv+9YJBD/s7/wtkTTBnuIG3/sz/SelOjNoqy5Xqy7qNKDI8UD9WZlBqCMZRp8CZTTTbzY6CZ7pg9ua1sJgh9H6LvQZsJSHo9jH+d1OnmPkF1cKrWaAipC6Gk2PJ+TX4cJCLenF3PuUmbjoOy/LwJg4W39KQ18bqyZTfncvpxXKt+zCv8rqPfcOgyEs/5x7pS1TJebbtRbw4XIYMYPxyz1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+xCmanH4r7ALOH2SOwx1E1dDg97ZuAO19gHopnetoX/JQxW+czoBkxcrkeGj2+wcPiZORQEsyMU015ey4qqB5eb1QKKULdPirzmrprQXde1Lkn5C1PUeVGueHO8zXTiGbWT0Vmcoob7qb0xyX+ctp93kYkgib7LpWlIbVYtwdEEa1jUA3wEjWFQijlZfqiLEvmpAJHLv+YBnWenv14BAzQT8APBU/PxjLFt72RFhSuwoHbFQ2hnr26G3+Gl2bNOc9DCCQ9gWiRxHiCnWtTG9h/5iC6HIkBDZWQn1XyWMgtuoPGCx+5ARbVo+GUHxw+9aBqe+NiybMnIrFsoClmAVM+Ffa3aLMMwPSkc3CyZRwidl/nGaeU5dCPmozspmjcbnF6B5xI7Czh9uBmDom+7dG0avaSyTSlM6IlSsq26Z64RqdpeWkX6tng50tojYX5gx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:09.3737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd23e06-f0f1-4671-b845-08def3e63b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

This patch series extends the AXI Ethernet driver to support the
XXV Ethernet subsystem.

- Add a devm_clk_bulk_get_enable() helper for consumers that need a set
  of mandatory clocks enabled with device-managed cleanup.

- Refactor through struct axienet_config so per-MAC behaviour is
  expressed as capability flags and callbacks instead of runtime
  MAC-type checks in the shared code.

- Document the XXV IP in Devicetree.

- Add support for the XXV Ethernet subsystem.

- Add a preparatory RMON cleanup, a statistics-ops refactor of
  struct axienet_config, and ethtool / ndo_get_stats64 counter reporting
  for XXV.

Notes:
- This series depends on [1], which is sent as part of another series.
  That change is required for this series to compile and is not included
  here to avoid duplication.
- "xlnx,rxmem" is a required property; driver changes for that are
  handled in a separate patch series[2].
- Due to phylink limitations, we aren't able to advertise both 10G and
  25G base-r interfaces and switch between them using ethtool.
  We are open to suggestions on how to handle this.

[1]: https://lore.kernel.org/all/20260717090824.2364230-1-srinivas.neeli@amd.com/
[2]: https://lore.kernel.org/all/20260806170253.1199749-1-suraj.gupta2@amd.com/

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

Suraj Gupta (7):
  clk: Add devm_clk_bulk_get_enable()
  net: xilinx: axienet: Introduce axienet_config for MAC-specific ops
  dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet
  net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
  net: xilinx: axienet: Make axienet_rmon_ranges non-static for reuse
  net: xilinx: axienet: Dispatch statistics through axienet_config ops
  net: xilinx: axienet: Add statistics support for XXV ethernet

 .../bindings/net/xlnx,xxv-ethernet.yaml       | 107 ++++
 .../driver-api/driver-model/devres.rst        |   1 +
 MAINTAINERS                                   |   1 +
 drivers/clk/clk-devres.c                      |   7 +
 drivers/net/ethernet/xilinx/Makefile          |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  90 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 603 ++++++++++++------
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 595 +++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  | 141 ++++
 include/linux/clk.h                           |  23 +
 10 files changed, 1389 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h


base-commit: 67ce33d8d0d166bc9e445d6e42a75b131ed23a7b
-- 
2.25.1
