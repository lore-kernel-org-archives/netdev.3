Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0943CE7C;
	Thu, 23 Jul 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810341; cv=fail; b=K+mrfL5gq8ydl+J00QLbTutDJHDGQvN2DyUOXJHohsmz3XxsZ9i7K6KtNLWjaKj169c+ytCYeSx/nQ43tZ1DRTvUm2Iffm2QGeVT3uOfYfKfMYoHzkZBITBNi4oVI8x+Eg6+vb6xAaBEb5fiH6U5bs654D8eSEVRVSOtQQ0zIyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810341; c=relaxed/simple;
	bh=qDnWFzJeHAoQA4eAHCorvs1cz7B4KZtbcfqvbMWd7oQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ludh+UMvfe962DyJyai+Gm1/Y1T6NsmljX66DjYzqdZVgX3KZyHoaQ1cPXjDQSA0+c+jjllr11kSdBVmZ+W3qzbXDqoAWfSNESVsI9X/A6QTvIua4bEO4m3ga+P0E2LQ5dYEEQ8dklXiC7Wr8smxJvEwhmH1kv3V7GPYNRixYcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qdA9Edtu; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qdA9Edtu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW3cDziGMOfhY88LATsXN7uIXX9XILUI/lbLdLvbVXB+ddDCiWPLG0ap8zRqr4Zq1bVg5R0PKGpZHHX95s2Yd2ZM+Ghw6eW09E75lrjkgoGwBUUaZDBl+yVJ3xpZg/XsHGM/iMm4fa631dtOQ2w7z1rL4QCZ0s7Fv139mQa69jwHlU93hJMVuZu2HD0/Z9vnF7JqqdSKXqkZUesR8W+ILqJeaQBMlxfW5ehA+mQhTn8Bbb56+oqm16a/SCCH0l/7dN1tyRF19J36tKBhFA8Sf2nY+NHDzd1+jruMJupYMXxGxVT9N5IjPeFSz+RSMdlatSoGsiM4n51ag/m1kB46sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gOoykdbdRrwLrHuBLW6t2Zckyk2+8rm2rIEbLTVsf8=;
 b=WL6gBG6K8b5D6OT6A+QpWN7+9mp8sz1WUxJkcP4bfsiFjmLHVxFdNFNgWrKjkrbOF8ftnKtqY7MVBJ5EqJJ8Tbj8WGpgB4xawRH7LVSXPgGwYTTg8y7YfQRz705Nf9hSusqZTJ0FuN6IrJNoyrJlmyorC7yabUQ1VNhc9LZPL34JklWKmEKBD0PsUvqt5EfmFmSzM4PqJ+meOfJeKsGJsETMuBsFQtS+zULKa0ZT+pTBLblKsDoMoe2gLSmFYKZo0RWmR4IPn725LDhgBB7IGfG4lAYH3KuIvp9OUEn+TOzLvLkukMSVX1aMsQC27sECYl1ZtEKEO5kp+XBPFgq6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gOoykdbdRrwLrHuBLW6t2Zckyk2+8rm2rIEbLTVsf8=;
 b=qdA9Edtu7k4MjgN4YN23fuEZ31+o9jQFnMqezm6YeHnXDRndxpw+LkgTO+T8Arpyq/gyH6rcb0Ieg6Eo179nwAgpJ2KePlNajZWG18Ia8EzgwakTVG/NVJAjo7iESpu80LJsrBgZmyeGLdpFEimzzDfiNLLR/J1JkMo9SqvH81I=
Received: from PH8P220CA0062.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::33)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:38:55 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::5) by PH8P220CA0062.outlook.office365.com
 (2603:10b6:510:2d9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 12:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 12:38:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:38:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:38:51 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 07:38:44 -0500
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
Subject: [PATCH net-next 0/7] net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
Date: Thu, 23 Jul 2026 18:08:31 +0530
Message-ID: <20260723123838.125145-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5de098-1f36-4f2b-0d64-08dee8b75b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|56012099006|11063799006|10067099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	p1b1+nqU7pvoAMUdfwXKqpO9QZ3M2DA8aNU8dUP0+7fiAQ89WHfbY0YtrINOnjkj4yw7TpxSNRPrnc2/F7OH9KIf5795jxRYoF48PIh04Fr4NutazEIVtcBvKe4ccfKson5kpN2ffJj6O+UnP2tIpoR368vGrgt6S3pnH+eeVGMJBDWG5/HxB0bGPilXWnVHdoNUao13Mj50+dvcrxkXkfW+tnkkxjWqc50peFCkX24iJWwpei0WNjxr4N4q/8duDpDcnkfoxP3dVGxVceIqqSF0vz8jrw1biXAFvNA4k7Z1SpWz3eWGk1BrwW8rG0uSDMKD26BtJrX7vMGVSfANnIw+m5xh/rPO9QVLv7k2lnNyVODlgDOFIuK+NJ9CqlVx2dNE3Mbx/DtarVkLb6aUbn5Z0SdvV6aNd5vG54cm3Xao3alzu1iPmZwuaEwESC7ClsQXuS+Y+VUF+JHWrz12JynF9Y+t7VB4iEVHT392c/iBYZ8lQ+nLJhSzIoYuAOUjkhz01Ozi0fPM5oJkDfLG6RVJGNSNzSDICjWMY3QIpaRqNvpcQ2lcxU8a1wvxGbM6+YqR6Bm3P1OcVR6FM75L1PmzRYDVb11aKEC8BvtIE6I/+DEdxEcjz65oMqGTqS0iTiZiXnFfkRL5DVwUxU3BLOMJI1sJMqXKmbeLGD6z59daloETpRu7ZMYx994n2KzDmO6221TeTWfj1ZdRf8YqmZJkfqKt55HjPck4Y7k1/46IkaaM7/Heqgv2RDFyf8Ox
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LIGnfmrFFCgWUC84e8nZAqyl8WOOtlX/iOgW9zt+SFlLavu6nEo9esGls3vXOJ1eL4XJ8xToEwlVY4WozBrh4hzUQdvCrKgWmjF5LbaR/KucCycf15lnYS18ZrCAWdUE8juhavU8u7RBAomdldhDAvgN79Cd3uHmuMzrPkzQjAEj1ol2yFN4xJIacN5Y/2F2iakbYmDBb1WEeT5Ob5LWK+GLXN1faLYutzdk5PWLLExuOm3rZDUwuXF53zibDB41CfirGHG+kWMO2uG9EWLk7JlXmWxfD4NUhDtP91ex+rabVypIIPXrFfBVrYxV8DAzIQV9soZtB/7Ev2KMdRL737kJcBFoeQxr3Nbu0Mo+8YRMJPgtU9J0sPVxZ01bXgR7DQVtdL3O/pEu28Xre8IXXClQjrvHmJrPnS3Ay5GbW6wRUd06SjPjrAO351LvrOEV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:38:53.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5de098-1f36-4f2b-0d64-08dee8b75b33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

This patch series extends the AXI Ethernet driver to support the
XXV Ethernet subsystem

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
- Due to phylink limitations, we aren't able to advertise both 10G and
  25G base-r interfaces and switch between them using ethtool.
  We are open to suggestions on how to handle this.

[1]: https://lore.kernel.org/all/20260717090824.2364230-1-srinivas.neeli@amd.com/

Suraj Gupta (7):
  clk: Add devm_clk_bulk_get_enable()
  net: xilinx: axienet: Introduce axienet_config for MAC-specific ops
  dt-bindings: net: xlnx,axi-ethernet: Add 10G/25G (XXV) ethernet
  net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
  net: xilinx: axienet: Make axienet_rmon_ranges non-static for reuse
  net: xilinx: axienet: Dispatch statistics through axienet_config ops
  net: xilinx: axienet: Add statistics support for XXV ethernet

 .../bindings/net/xlnx,axi-ethernet.yaml       | 144 ++++-
 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/clk/clk-devres.c                      |   7 +
 drivers/net/ethernet/xilinx/Makefile          |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  90 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 603 ++++++++++++------
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 594 +++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  | 141 ++++
 include/linux/clk.h                           |  23 +
 9 files changed, 1397 insertions(+), 209 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h


base-commit: 67ce33d8d0d166bc9e445d6e42a75b131ed23a7b
-- 
2.25.1

