Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506B4A441D;
	Wed, 30 Sep 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773141; cv=fail; b=bsj06q1qZUeXLDj99qokaGQjMsE7rhm2wm+AqT0V6Kg2tY7UdnBL7Uoi62AXvR0Xu0opw5aTCmR5OmRsSt7Gl+1KmVTnNM1p8kzx2q1gBztNBcmwvaeO3EgZWiOwAx0WaReG1xTt7ZDVLsZne7qYRqiLMcZjNkka5gWvrkyZERE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773141; c=relaxed/simple;
	bh=0r1v82OL1HdLKbF1DgSmkRpQThTXlzWiGEv3w4vbDk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3v23lPyXHrH8YbEgxu4vIuHRPtdxSo+byMOK/lgEDUjarSyAKEH5uYII7zqa1VcVzVnJz8WXqYXD9M70yovg9h2PMF5Na6XHlTVEooGFPx7vtvPo2kGZA4wzC5yb+dZHQmDaqw4b6SUOHG9BcIw3stNn7JVtf5Kao8VsVQJ6uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e/OzY+d1; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e/OzY+d1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxarQ6os6W+i7Fu145iorpJWib78VOKr2VsszvNYu4oVaHfC7JKh44rOYoMdWfoxnLx/iHFcFdazLWvht74KqWWuUYF2SXbVGYDJ5faE1LcGY/h0aAReKhsUuM4CZHQcvPyoumI+bkdImrvnkOT4favAZp8KzMLKzFKKb4qdkZ9bC2rNuRqsroQFxZLHvppVg28tcZK57DbLVGW4gBVpQpnqxl/ghUYpQYPMEFdayEM25bvirffNEJn8weMey+DxHw01Lot1/z0htP/Lr+TixTyCi61VeKkP1pID1Ogyga5X0Cb7c9IWOHWmBJnrvAHiKONgKlev/j+28qwuhH/hPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSf06rcctFdDzKG5WHMDjZjT3KuZCxll7vm2FykWpMg=;
 b=QAHw7lzBDbSxGoHbRqfYrWgUrnNvHQuaxg3FMt4cceBoMGPdjr3lXuXTF0bI8y0e1cZB8xVWJ+vTkEHo5CftRU3RtBSGXhaspgCOL9kfxG59NlkOr/a1TiPYVZS6CpiWGkXnoQr2rvfcZajOBH9GKFi/2n2uCTLJtBgCLbsghBSnVystjdKYI5YpHO5o8E4DImdPFmATOaYNwr/imt0QpXk5w+UmbZMX+HoAY6l+64yorO23+y2xwnvp4keBvGvnnLGcc0IAcjSMiDFQrC7eB8zSRpqxCBa6jctEaX1tUpJIt+jqqSZedYr+2vy9GwrnmRsl/SORjCHeaG3fNUhEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSf06rcctFdDzKG5WHMDjZjT3KuZCxll7vm2FykWpMg=;
 b=e/OzY+d1+tU/FR2e8QaAY4lserNhZrQFqNxCzI/wry36K/LDNTIR7rjlx0/Lndm8ENakWfKFCPrPlEGfcJU3w5TqI+P3co2Hhkufjwv9qm3EY8tx3aKh3G2w7xdJkArfEKLjPjMThm1mKdoyfp1OXI563oPVJFRrhQvFhF8a9VECUsazbLs31JyAlN/J1Jp4RwgU9q4zofKMXIY+s/zshugWGGlJKjVoaPHMTTE8Xt5sZXVOjlLTHMJGYFZedjbjoqQmEg6O33jivr/An9FJUDPH30qiMUYmmLDv6QLV4Y6V94oxxSQKP+mEqgrRetgchyZNyVzLdzier1GPmI/DWw==
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 12:58:23 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::47) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 12:58:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 12:58:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 05:58:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 05:58:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 05:57:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5: nodnic: Introduce the mlx5_nodnic driver
Date: Wed, 30 Sep 2026 15:57:04 +0300
Message-ID: <20260930125708.144767-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260930125708.144767-1-tariqt@nvidia.com>
References: <20260930125708.144767-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 530ac474-fd6a-44bc-32d5-08df1ef281ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|11063799006|10067099003|56012099006|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5/YiSquqal9WAody46RjbM0UEM0jnSyxjQPIN9hsDXKT7qYhwcnONqfCOY5SxFNRnjXJb3WlRVCdcwXX/qY5oNlxCTD/vFNpGDRBCs3d7p1BRhhZZYVVGufi0x8v1ewSUqyXocQ//7FLLkx1g9Vf6BUa12HNxW/BcDyxbHS3JH3rHl2aN5nZZDWibxKMIcOEnuf37vvxjOsqr4peBgIaRy9In5tlEC0/u7VqzkAZaAO2kiPCcYy6K/Z+40gnOOeD2dKLZOFImlfbYBL5ktO9qKXg8lGrNrXvSI5CgRYCE99qdK4T8tjb5mVDxcmnpREittZMw+Ee+O1S0gufHBB7a8/r7GdY1qZviZDN8P9vIuQxDMiweVh9NaxRm2lfdWivLIJYmS1Tik9XE04fWNTy75HtKi4QQzhxnoimolkHnfyDRVN3xeoi9vSa7C39I/HCSBsd3pQNoH+rV5b9zRUXXVVKQk2NnzVfHgT/soytbEEDh4hublloS/IWmWhqO9OGnRFihAfEpHp7PyW2KiWMEYMKPFmW7VsnUkz3/gzO6NLTZfh7G4ZgM6H3M6qE13vkOj93UGCerm39qNCA1cnF9dy7IYfq/yJYkTrqFMKJ5rYqSdOjnnw812aOZj0+jQD9BUjWxm0vxUG28aO80IeDNtHmIRUQnz6mvUcih7dfZIlHJyoRPLENH12YbR++awF9+eAaIot03Xo/1wELBCnyPg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rfCRxZjkkiIBJxDbaWX6fTE3d+AYF0gMi4EYdSAOPhMruz+zjRY3JNvMmdIjla3lb0qE0O+37cZheTIY9wVYuVLZJbpnXnMaOkxaCsrIIRgRzoLcfFjU8bPdc7doAVxjYGx2G2y2+7Ic1u/QWu3p+6QLQ6lcgvaXydGVR/Sogt0ABoGucEL2Ia3+4LmwmDLYWaJt4WnIBqR57VO74P6PZjdJHp/6j7e7xH/7N7wykdwzDlbEhViTJ1WiK5CTTtYP+0C04X6mBbiiv5cfHvafS3+/zt+Pl6Hxtw6vH+bQ2r6W0gRuknSEgSjVnvzPQtp3mLviEoy1rHEVAfuDsZqQiQ7yGjU1XEus2ZcBnC0mEC7lGvTu04G5qIaHkn0zG/0U/y32e5RcvSlOwoPtwQ9TU11fP4zrg6MPLMHvyi/YkKJLFZRAfFzUAbkM9kQCQIuh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:58:21.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530ac474-fd6a-44bc-32d5-08df1ef281ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

From: Shahar Shitrit <shshitrit@nvidia.com>

Introduce mlx5_nodnic, a driver for DRAM-less NVIDIA Mellanox NIC
functions.

It defines a lightweight NIC function intended for contexts where local
DRAM is unavailable or too costly: embedded controllers, management
planes, pre-boot environments, or any resource-constrained instantiation
of a ConnectX NIC. The hardware sends and receives ordinary Ethernet
frames via SQs, RQs and CQs. There is no encapsulation, no private
protocol, and no FW interposition: packets are forwarded as standard
Ethernet between whatever peers are connected to the function. The
interface is documented in the HW spec and has been in production in
non-Linux OS drivers for over a decade.

This patch implements the PCI probe and remove flows, including FLR,
firmware readiness, interface negotiation and capability discovery,
followed by port and ring configuration.

It also adds the VSC access layer for PCI configuration-space accesses
to the initialization segment and to the NODNIC configuration registers.
Set up the event IRQ for link-state notifications, retrieve the port MAC
address, and implement the netdev lifecycle, including ndo_open and
ndo_stop.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/Kconfig         |   1 +
 drivers/net/ethernet/mellanox/Makefile        |   1 +
 .../net/ethernet/mellanox/mlx5/nodnic/Kconfig |  18 +
 .../ethernet/mellanox/mlx5/nodnic/Makefile    |   8 +
 .../net/ethernet/mellanox/mlx5/nodnic/en.h    |  97 ++
 .../ethernet/mellanox/mlx5/nodnic/en_cfg.c    | 828 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/main.c  | 874 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/nodnic/nodnic.h    | 105 +++
 .../mellanox/mlx5/nodnic/nodnic_ifc.h         | 318 +++++++
 .../mellanox/mlx5/nodnic/nodnic_pci_vsc.c     | 418 +++++++++
 .../mellanox/mlx5/nodnic/nodnic_pci_vsc.h     |  45 +
 11 files changed, 2713 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/Kconfig
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_ifc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.h

diff --git a/drivers/net/ethernet/mellanox/Kconfig b/drivers/net/ethernet/mellanox/Kconfig
index b4f66eb9ddb9..979a029c0171 100644
--- a/drivers/net/ethernet/mellanox/Kconfig
+++ b/drivers/net/ethernet/mellanox/Kconfig
@@ -23,5 +23,6 @@ source "drivers/net/ethernet/mellanox/mlx5/core/Kconfig"
 source "drivers/net/ethernet/mellanox/mlxsw/Kconfig"
 source "drivers/net/ethernet/mellanox/mlxfw/Kconfig"
 source "drivers/net/ethernet/mellanox/mlxbf_gige/Kconfig"
+source "drivers/net/ethernet/mellanox/mlx5/nodnic/Kconfig"
 
 endif # NET_VENDOR_MELLANOX
diff --git a/drivers/net/ethernet/mellanox/Makefile b/drivers/net/ethernet/mellanox/Makefile
index d4b5f547a727..ec46837fa729 100644
--- a/drivers/net/ethernet/mellanox/Makefile
+++ b/drivers/net/ethernet/mellanox/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MLX5_CORE) += mlx5/core/
 obj-$(CONFIG_MLXSW_CORE) += mlxsw/
 obj-$(CONFIG_MLXFW) += mlxfw/
 obj-$(CONFIG_MLXBF_GIGE) += mlxbf_gige/
+obj-$(CONFIG_MLX5_NODNIC) += mlx5/nodnic/
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/Kconfig b/drivers/net/ethernet/mellanox/mlx5/nodnic/Kconfig
new file mode 100644
index 000000000000..461750a9c97c
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config MLX5_NODNIC
+	tristate "Mellanox NODNIC core driver"
+	depends on PCI
+	depends on NETDEVICES && ETHERNET
+	help
+	  This driver provides core support for Mellanox NODNIC (NO DRAM NIC)
+	  devices. NODNIC is a lightweight network
+	  interface driver that uses Vendor Specific Capability (VSC) for
+	  PCI communication with Mellanox network adapters.
+
+	  This driver enables basic Ethernet networking functionality for
+	  supported Mellanox NODNIC hardware.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mlx5_nodnic.
+
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
new file mode 100644
index 000000000000..4955f0427c79
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Mellanox NODNIC driver
+#
+
+obj-$(CONFIG_MLX5_NODNIC) += mlx5_nodnic.o
+
+mlx5_nodnic-y := main.o en_cfg.o nodnic_pci_vsc.o
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
new file mode 100644
index 000000000000..90dc57695e1b
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#ifndef __MLX5_NODNIC_EN_H__
+#define __MLX5_NODNIC_EN_H__
+
+#include <linux/if_vlan.h>
+#include <linux/mlx5/device.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+
+#define MLX5_NODNIC_RING_ENTRIES	1024
+#define MLX5_NODNIC_CQE_SIZE_B		64
+#define MLX5_NODNIC_SQ_WQEBB_B		64
+#define MLX5_NODNIC_RQ_STRIDE_BYTES	16
+
+enum {
+	MLX5_NODNIC_STATE_OPENED,
+};
+
+enum {
+	MLX5_NODNIC_RCV_DBR,
+	MLX5_NODNIC_SND_DBR,
+	MLX5_NODNIC_DBR_WORDS,
+};
+
+struct mlx5_nodnic_ring {
+	void *wq;
+	dma_addr_t dma_handle;
+	u32 size;
+	u32 num_entries;
+	u32 qn;
+	u32 lkey;
+};
+
+struct mlx5_nodnic_sq {
+	struct device		*device;
+	struct net_device	*netdev;
+	struct mlx5_nodnic_ring ring;
+
+	u16 pc;
+	u16 cc;
+};
+
+struct mlx5_nodnic_rq {
+	struct mlx5_nodnic_ring ring;
+	u16 pc;
+	u16 cc;
+};
+
+struct mlx5_nodnic_dbr {
+	__be32 *db;
+	dma_addr_t dma_handle;
+	u32 alloc_size;
+};
+
+struct mlx5_nodnic_cq {
+	struct mlx5_nodnic_ring ring;
+	int			cqn;
+	int			num_entries;
+	int			log_num_entries;
+
+	struct mlx5_nodnic_dbr	dbr;
+
+	int cc;
+};
+
+/* for FW use only */
+struct mlx5_nodnic_working_buffer {
+	dma_addr_t dma_handle;
+	u32 alloc_size;
+};
+
+struct mlx5_nodnic_priv {
+	struct mlx5_nodnic_core_dev *core_dev;
+	struct net_device *netdev;
+
+	struct mutex state_lock; /* protects Interface state */
+	unsigned long state;
+
+	struct mlx5_nodnic_sq	sq;
+	struct mlx5_nodnic_rq	rq;
+	struct mlx5_nodnic_dbr	dbr; /* one shared dbr for TX and RX */
+	struct mlx5_nodnic_cq	cq;
+	struct mlx5_nodnic_ring	working_buffer;
+};
+
+void mlx5_nodnic_build_netdev(struct net_device *netdev);
+struct net_device *mlx5_nodnic_create_netdev(struct mlx5_nodnic_core_dev *dev);
+void mlx5_nodnic_refresh_carrier(struct mlx5_nodnic_priv *priv);
+void mlx5_nodnic_cleanup_netdev(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_open(struct net_device *netdev);
+int mlx5_nodnic_close(struct net_device *netdev);
+
+#endif /* __MLX5_NODNIC_EN_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
new file mode 100644
index 000000000000..75dbd2071110
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/interrupt.h>
+#include <linux/log2.h>
+#include <linux/pci.h>
+#include <net/netdev_lock.h>
+#include <net/net_namespace.h>
+
+#include "en.h"
+#include "nodnic_ifc.h"
+#include "nodnic.h"
+#include "nodnic_pci_vsc.h"
+
+#define MLX5_NODNIC_CQ_INIT_CMD_SN cpu_to_be32(2 << 28)
+
+static int mlx5_nodnic_write_ring_addr(struct mlx5_nodnic_core_dev *dev,
+				       dma_addr_t dma_handle, u32 offset_h,
+				       u32 offset_l)
+{
+	u32 addr_h, addr_l;
+	int err;
+
+	addr_h = cpu_to_be32(upper_32_bits(dma_handle));
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, offset_h, addr_h);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write ring addr high: %d\n",
+				     err);
+		return err;
+	}
+
+	addr_l = 0;
+	MLX5_SET(nodnic_q_addr_l, &addr_l, q_addr_l,
+		 lower_32_bits(dma_handle) >> 12);
+
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, offset_l, addr_l);
+	if (err)
+		mlx5_nodnic_core_err(dev, "failed to write ring addr low: %d\n",
+				     err);
+	return err;
+}
+
+static u32 mlx5_nodnic_calc_ring_size(struct mlx5_nodnic_core_dev *dev,
+				      int stride)
+{
+	u32 ring_size = MLX5_NODNIC_RING_ENTRIES * stride;
+	u32 max_supported = 1U << dev->log_max_ring_size;
+
+	return min(ring_size, max_supported);
+}
+
+static int mlx5_nodnic_write_ring_size(struct mlx5_nodnic_core_dev *dev,
+				       int offset, int size)
+{
+	u32 addr_l;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx, offset, &addr_l);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read ring size: %d\n",
+				     err);
+		return err;
+	}
+
+	MLX5_SET(nodnic_q_addr_l, &addr_l, log_size, ilog2(size));
+
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, offset, addr_l);
+	if (err)
+		mlx5_nodnic_core_err(dev, "failed to write ring size: %d\n",
+				     err);
+	return err;
+}
+
+static int mlx5_nodnic_read_qn(struct mlx5_nodnic_core_dev *dev,
+			       struct mlx5_nodnic_ring *ring, u32 offset)
+{
+	u32 qn_dword;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx, offset, &qn_dword);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read queue number: %d\n",
+				     err);
+		return err;
+	}
+
+	ring->qn = MLX5_GET(nodnic_ring_q_number, &qn_dword, queue_number);
+
+	return 0;
+}
+
+static int mlx5_nodnic_write_ring_dbr_addr(struct mlx5_nodnic_core_dev *dev,
+					   u32 ring_offset)
+{
+	int off_h = ring_offset + MLX5_NODNIC_RING_DBR_ADDR_H;
+	int off_l = ring_offset + MLX5_NODNIC_RING_DBR_ADDR_L;
+	struct mlx5_nodnic_dbr *dbr = &dev->priv->dbr;
+	u32 dbr_h, dbr_l;
+	int err;
+
+	dbr_l = 0;
+	MLX5_SET(nodnic_ring_dbr_addr_l, &dbr_l, db_record_addr_l,
+		 (u32)(dbr->dma_handle >> 2));
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, off_l, dbr_l);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write ring DBR addr low: %d\n",
+				     err);
+		return err;
+	}
+
+	dbr_h = cpu_to_be32(upper_32_bits(dbr->dma_handle));
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, off_h, dbr_h);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write ring DBR addr high: %d\n",
+				     err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int mlx5_nodnic_alloc_ring(struct mlx5_nodnic_core_dev *dev,
+				  struct mlx5_nodnic_ring *ring, int size)
+{
+	dma_addr_t dma_handle;
+	void *buf;
+
+	buf = dma_alloc_coherent(dev->device, size, &dma_handle, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	*ring = (struct mlx5_nodnic_ring) {
+		.wq		= buf,
+		.dma_handle	= dma_handle,
+		.size		= size,
+	};
+
+	return 0;
+}
+
+static void mlx5_nodnic_free_ring(struct mlx5_nodnic_core_dev *dev,
+				  struct mlx5_nodnic_ring *ring)
+{
+	dma_free_coherent(dev->device, ring->size, ring->wq,
+			  ring->dma_handle);
+	memset(ring, 0, sizeof(*ring));
+}
+
+static int mlx5_nodnic_init_ring(struct mlx5_nodnic_core_dev *dev,
+				 struct mlx5_nodnic_ring *ring, u32 ring_offset,
+				 int stride)
+{
+	int ring_addr_h = ring_offset + MLX5_NODNIC_RING_ADDR_H;
+	int ring_addr_l = ring_offset + MLX5_NODNIC_RING_ADDR_L;
+	int size, err;
+
+	size = mlx5_nodnic_calc_ring_size(dev, stride);
+
+	err = mlx5_nodnic_alloc_ring(dev, ring, size);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_write_ring_addr(dev, ring->dma_handle, ring_addr_h,
+					  ring_addr_l);
+	if (err)
+		goto err_ring_free;
+
+	err = mlx5_nodnic_write_ring_size(dev, ring_addr_l, size);
+	if (err)
+		goto err_ring_free;
+
+	ring->num_entries = size / stride;
+
+	err = mlx5_nodnic_read_qn(dev, ring,
+				  ring_offset + MLX5_NODNIC_RING_QUEUE_NUMBER);
+	if (err)
+		goto err_ring_free;
+
+	err = mlx5_nodnic_write_ring_dbr_addr(dev, ring_offset);
+	if (err)
+		goto err_ring_free;
+
+	return 0;
+
+err_ring_free:
+	mlx5_nodnic_free_ring(dev, ring);
+	return err;
+}
+
+static int mlx5_nodnic_alloc_dbr(struct mlx5_nodnic_core_dev *dev,
+				 struct mlx5_nodnic_dbr *dbr)
+{
+	const u32 bytes = MLX5_NODNIC_DBR_WORDS * sizeof(__be32);
+	dma_addr_t dma_handle;
+	void *buf;
+
+	buf = dma_alloc_coherent(dev->device, bytes, &dma_handle, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	*dbr = (struct mlx5_nodnic_dbr) {
+		.db		= (__be32 *)buf,
+		.alloc_size	= bytes,
+		.dma_handle	= dma_handle,
+	};
+
+	return 0;
+}
+
+static void mlx5_nodnic_free_dbr(struct mlx5_nodnic_core_dev *dev,
+				 struct mlx5_nodnic_dbr *dbr)
+{
+	if (!dbr->db)
+		return;
+
+	dma_free_coherent(dev->device, dbr->alloc_size, dbr->db,
+			  dbr->dma_handle);
+}
+
+static int mlx5_nodnic_init_cq_dbr(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_dbr *dbr = &dev->priv->cq.dbr;
+	u32 dbr_h, dbr_l;
+	int err;
+
+	err = mlx5_nodnic_alloc_dbr(dev, dbr);
+	if (err)
+		return err;
+
+	dbr_l = cpu_to_be32(lower_32_bits(dbr->dma_handle));
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx,
+					     MLX5_NODNIC_CQ_DBR_ADDR_L,
+					     dbr_l);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write CQ DBR addr low: %d\n",
+				     err);
+		goto err_free_dbr;
+	}
+
+	dbr_h = cpu_to_be32(upper_32_bits(dbr->dma_handle));
+	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx,
+					     MLX5_NODNIC_CQ_DBR_ADDR_H,
+					     dbr_h);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write CQ DBR addr high: %d\n",
+				     err);
+		goto err_free_dbr;
+	}
+
+	dev->priv->cq.dbr.db[1] = MLX5_NODNIC_CQ_INIT_CMD_SN;
+
+	return 0;
+
+err_free_dbr:
+	mlx5_nodnic_free_dbr(dev, &dev->priv->cq.dbr);
+	return err;
+}
+
+static void mlx5_nodnic_cleanup_cq_dbr(struct mlx5_nodnic_core_dev *dev)
+{
+	mlx5_nodnic_free_dbr(dev,  &dev->priv->cq.dbr);
+}
+
+/* log_cq_size should be read after rq and sq ring sizes were set. */
+static int mlx5_nodnic_read_cq_ring_size(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
+	u32 log_cq_size;
+	u32 cq_addr_l;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx,
+					    MLX5_NODNIC_PORT_CQ_ADDR_L,
+					    &cq_addr_l);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read CQ ring size: %d\n",
+				     err);
+		return err;
+	}
+
+	log_cq_size = MLX5_GET(nodnic_q_addr_l, &cq_addr_l, log_size);
+	cq->num_entries = 1ULL << log_cq_size;
+	cq->log_num_entries = log_cq_size;
+
+	return 0;
+}
+
+static int mlx5_nodnic_init_cq_ring(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
+	struct mlx5_nodnic_ring *ring;
+	int err;
+
+	ring = &cq->ring;
+
+	err = mlx5_nodnic_read_cq_ring_size(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_alloc_ring(dev, ring,
+				     cq->num_entries * MLX5_NODNIC_CQE_SIZE_B);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_write_ring_addr(dev, ring->dma_handle,
+					  MLX5_NODNIC_PORT_CQ_ADDR_H,
+					  MLX5_NODNIC_PORT_CQ_ADDR_L);
+	if (err)
+		goto err_free_cq;
+
+	return 0;
+
+err_free_cq:
+	mlx5_nodnic_free_ring(dev, &cq->ring);
+	return err;
+}
+
+static void mlx5_nodnic_cleanup_cq_ring(struct mlx5_nodnic_core_dev *dev)
+{
+	return mlx5_nodnic_free_ring(dev, &dev->priv->cq.ring);
+}
+
+static int mlx5_nodnic_read_cq_n(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 cq_n;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx, MLX5_NODNIC_CQ_N,
+					    &cq_n);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read CQ number: %d\n",
+				     err);
+		return err;
+	}
+
+	dev->priv->cq.cqn = MLX5_GET(nodnic_cqn, &cq_n, cq_n);
+
+	return 0;
+}
+
+int mlx5_nodnic_init_working_buffer(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_ring *work_buf = &dev->priv->working_buffer;
+	u32 size = 1U << dev->log_working_buffer_size;
+	int err;
+
+	err = mlx5_nodnic_alloc_ring(dev, work_buf, size);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_write_ring_addr(
+		dev, work_buf->dma_handle,
+		MLX5_NODNIC_PORT_WORKING_BUFFER_ADDR_H,
+		MLX5_NODNIC_PORT_WORKING_BUFFER_ADDR_L);
+	if (err)
+		goto err_free_working_buffer;
+
+	return 0;
+
+err_free_working_buffer:
+	mlx5_nodnic_free_ring(dev, work_buf);
+	return err;
+}
+
+int mlx5_nodnic_open_cq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
+	int err;
+
+	cq->cc = 0;
+
+	err = mlx5_nodnic_init_cq_ring(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_init_cq_dbr(dev);
+	if (err)
+		goto err_cleanup_ring;
+
+	err = mlx5_nodnic_read_cq_n(dev);
+	if (err)
+		goto err_cleanup_dbr;
+
+	return 0;
+
+err_cleanup_dbr:
+	mlx5_nodnic_cleanup_cq_dbr(dev);
+err_cleanup_ring:
+	mlx5_nodnic_cleanup_cq_ring(dev);
+	return err;
+}
+
+static void mlx5_nodnic_close_cq(struct mlx5_nodnic_cq *cq)
+{
+	struct mlx5_nodnic_core_dev *dev =
+		container_of(cq, struct mlx5_nodnic_priv, cq)->core_dev;
+
+	mlx5_nodnic_cleanup_cq_dbr(dev);
+	mlx5_nodnic_cleanup_cq_ring(dev);
+}
+
+int mlx5_nodnic_open_sq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_priv *priv = dev->priv;
+	struct mlx5_nodnic_sq *sq = &priv->sq;
+	struct mlx5_nodnic_ring *ring;
+	int err;
+
+	sq->netdev = priv->netdev;
+	sq->device = dev->device;
+	sq->pc = 0;
+	sq->cc = 0;
+	ring = &sq->ring;
+
+	err = mlx5_nodnic_init_ring(dev, ring, MLX5_NODNIC_SEND_RING_OFFSET,
+				    MLX5_NODNIC_SQ_WQEBB_B);
+	if (err)
+		return err;
+
+	ring->lkey = dev->lkey;
+
+	return 0;
+}
+
+static void mlx5_nodnic_close_sq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_sq *sq = &dev->priv->sq;
+
+	mlx5_nodnic_free_ring(dev, &sq->ring);
+}
+
+int mlx5_nodnic_open_rq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_rq *rq = &dev->priv->rq;
+	struct mlx5_nodnic_ring *ring;
+	int err;
+
+	rq->pc = 0;
+	rq->cc = 0;
+	ring = &rq->ring;
+
+	err = mlx5_nodnic_init_ring(dev, ring, MLX5_NODNIC_RECEIVE_RING_OFFSET,
+				    MLX5_NODNIC_RQ_STRIDE_BYTES);
+	if (err)
+		return err;
+
+	ring->lkey = dev->lkey;
+
+	return 0;
+}
+
+static void mlx5_nodnic_close_rq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_rq *rq = &dev->priv->rq;
+
+	mlx5_nodnic_free_ring(dev, &rq->ring);
+}
+
+static int mlx5_nodnic_open_queues(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
+	int err;
+
+	/* one doorbell record shared by both SQ and RQ */
+	err = mlx5_nodnic_alloc_dbr(dev, &dev->priv->dbr);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_vsc_context_acquire(vsc_ctx);
+	if (err)
+		goto err_free_dbr;
+
+	err = mlx5_nodnic_open_sq(dev);
+	if (err)
+		goto err_release_vsc;
+
+	err = mlx5_nodnic_open_rq(dev);
+	if (err)
+		goto err_close_sq;
+
+	err = mlx5_nodnic_open_cq(dev);
+	if (err)
+		goto err_close_rq;
+
+	err = mlx5_nodnic_init_working_buffer(dev);
+	if (err)
+		goto err_close_cq;
+
+	mlx5_nodnic_vsc_context_release(vsc_ctx);
+
+	return 0;
+
+err_close_cq:
+	mlx5_nodnic_close_cq(&dev->priv->cq);
+err_close_rq:
+	mlx5_nodnic_close_rq(dev);
+err_close_sq:
+	mlx5_nodnic_close_sq(dev);
+err_release_vsc:
+	mlx5_nodnic_vsc_context_release(vsc_ctx);
+err_free_dbr:
+	mlx5_nodnic_free_dbr(dev, &dev->priv->dbr);
+
+	return err;
+}
+
+static void mlx5_nodnic_close_queues(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_priv *priv = dev->priv;
+
+	mlx5_nodnic_free_ring(dev, &priv->working_buffer);
+	mlx5_nodnic_close_cq(&priv->cq);
+	mlx5_nodnic_close_rq(dev);
+	mlx5_nodnic_close_sq(dev);
+	mlx5_nodnic_free_dbr(dev, &priv->dbr);
+}
+
+static void mlx5_nodnic_update_carrier(struct mlx5_nodnic_priv *priv, u32 event)
+{
+	u32 port_state = MLX5_GET(nodnic_port_event, &event, port_state);
+	bool up = port_state == MLX5_NODNIC_PORT_STATE_ACTIVE;
+
+	/* Force re-notification if state is unchanged */
+	if (up == netif_carrier_ok(priv->netdev)) {
+		netif_carrier_event(priv->netdev);
+		return;
+	}
+	if (up) {
+		netif_carrier_on(priv->netdev);
+		netdev_info(priv->netdev, "Link up\n");
+	} else {
+		netif_carrier_off(priv->netdev);
+		netdev_info(priv->netdev, "Link down\n");
+	}
+}
+
+static int mlx5_nodnic_refresh_carrier_locked(struct mlx5_nodnic_priv *priv)
+{
+	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
+	struct mlx5_nodnic_vsc_ctx *vsc_ctx;
+	u32 event;
+	int err;
+
+	vsc_ctx = dev->vsc_ctx;
+	err = mlx5_nodnic_vsc_context_acquire(vsc_ctx);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(vsc_ctx, MLX5_NODNIC_PORT_EVENT,
+					    &event);
+	mlx5_nodnic_vsc_context_release(vsc_ctx);
+
+	if (!err)
+		mlx5_nodnic_update_carrier(priv, event);
+
+	return err;
+}
+
+void mlx5_nodnic_refresh_carrier(struct mlx5_nodnic_priv *priv)
+{
+	mutex_lock(&priv->state_lock);
+	if (test_bit(MLX5_NODNIC_STATE_OPENED, &priv->state))
+		mlx5_nodnic_refresh_carrier_locked(priv);
+	mutex_unlock(&priv->state_lock);
+}
+
+int mlx5_nodnic_enable_port(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
+	u32 val = 0;
+	int err;
+
+	/* data_msix_en, event_msix_en must be set before activating port */
+	MLX5_SET(nodnic_port_network, &val, data_msix_en, 1);
+	MLX5_SET(nodnic_port_network, &val, event_msix_en, 1);
+	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
+					     val);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write port network (msix): %d\n",
+				     err);
+		return err;
+	}
+
+	MLX5_SET(nodnic_port_network, &val, network_en, 1);
+	MLX5_SET(nodnic_port_network, &val, receive_filter_en, BIT(0));
+
+	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
+					     val);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to write port network (enable): %d\n",
+				     err);
+		return err;
+	}
+
+	/* dma enabling requires a separate write */
+	MLX5_SET(nodnic_port_network, &val, dma_en, 1);
+
+	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
+					     val);
+	if (err)
+		mlx5_nodnic_core_err(dev,
+				     "failed to write port network (dma): %d\n",
+				     err);
+	return err;
+}
+
+void mlx5_nodnic_disable_port(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
+	int err;
+	u32 val;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
+					    &val);
+	if (err)
+		goto out;
+
+	MLX5_SET(nodnic_port_network, &val, dma_en, 0);
+	MLX5_SET(nodnic_port_network, &val, network_en, 0);
+	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
+					     val);
+	if (err)
+		goto out;
+
+	/* data_msix_en, event_msix_en can't be modified while port is active */
+	MLX5_SET(nodnic_port_network, &val, data_msix_en, 0);
+	MLX5_SET(nodnic_port_network, &val, event_msix_en, 0);
+	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
+					     val);
+
+out:
+	if (err)
+		mlx5_nodnic_core_warn(dev,
+				      "failed to read/write to vsc err %d\n",
+				      err);
+}
+
+static int mlx5_nodnic_init_uar_map(struct mlx5_nodnic_core_dev *dev)
+{
+	void __iomem *base;
+	phys_addr_t paddr;
+	u32 uar_page_size;
+
+	uar_page_size = 1 << dev->log_uar_page_size;
+
+	paddr = dev->bar_addr + (dev->send_ring0_uar_index * uar_page_size);
+
+	base = ioremap(paddr, uar_page_size);
+	if (!base) {
+		mlx5_nodnic_core_err(dev, "failed to map UAR\n");
+		return -ENOMEM;
+	}
+
+	dev->uar_base = base;
+
+	return 0;
+}
+
+static void mlx5_nodnic_cleanup_uar_map(struct mlx5_nodnic_core_dev *dev)
+{
+	if (!dev->uar_base)
+		return;
+
+	iounmap(dev->uar_base);
+	dev->uar_base = NULL;
+}
+
+static int mlx5_nodnic_open_locked(struct net_device *netdev)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
+	int err;
+
+	err = mlx5_nodnic_init_uar_map(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_open_queues(dev);
+	if (err)
+		goto err_uar;
+
+	set_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
+
+	err = mlx5_nodnic_refresh_carrier_locked(dev->priv);
+	if (err)
+		netdev_err(dev->priv->netdev,
+			   "failed to query carrier, err=%d\n", err);
+
+	return 0;
+
+err_uar:
+	mlx5_nodnic_cleanup_uar_map(dev);
+	return err;
+}
+
+int mlx5_nodnic_open(struct net_device *netdev)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	int err;
+
+	mutex_lock(&priv->state_lock);
+	err = mlx5_nodnic_open_locked(netdev);
+	mutex_unlock(&priv->state_lock);
+
+	return err;
+}
+
+static int mlx5_nodnic_close_locked(struct net_device *netdev)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
+
+	clear_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
+	netif_carrier_off(priv->netdev);
+	netdev_info(priv->netdev, "Link down\n");
+	mlx5_nodnic_close_queues(dev);
+
+	return 0;
+}
+
+int mlx5_nodnic_close(struct net_device *netdev)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	int err = 0;
+
+	mutex_lock(&priv->state_lock);
+	if (!test_bit(MLX5_NODNIC_STATE_OPENED, &priv->state)) {
+		mutex_unlock(&priv->state_lock);
+		return 0;
+	}
+
+	err = mlx5_nodnic_close_locked(netdev);
+	mutex_unlock(&priv->state_lock);
+
+	mlx5_nodnic_cleanup_uar_map(priv->core_dev);
+
+	return err;
+}
+
+static const struct net_device_ops mlx5_nodnic_netdev_ops = {
+	.ndo_open		= mlx5_nodnic_open,
+	.ndo_stop		= mlx5_nodnic_close,
+};
+
+void mlx5_nodnic_build_netdev(struct net_device *netdev)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	struct mlx5_nodnic_core_dev *core_dev;
+
+	core_dev = priv->core_dev;
+
+	SET_NETDEV_DEV(netdev, core_dev->device);
+
+	netdev->netdev_ops = &mlx5_nodnic_netdev_ops;
+	netdev->request_ops_lock = true;
+
+	eth_hw_addr_set(netdev, core_dev->mac_address);
+}
+
+static void mlx5_nodnic_init_priv(struct mlx5_nodnic_priv *priv,
+				  struct net_device *netdev,
+				  struct mlx5_nodnic_core_dev *core_dev)
+{
+	priv->netdev = netdev;
+	priv->core_dev = core_dev;
+	mutex_init(&priv->state_lock);
+}
+
+static void mlx5_nodnic_cleanup_priv(struct mlx5_nodnic_priv *priv)
+{
+	mutex_destroy(&priv->state_lock);
+}
+
+struct net_device *mlx5_nodnic_create_netdev(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_priv *priv;
+	struct net_device *netdev;
+
+	netdev = alloc_etherdev_mqs(sizeof(struct mlx5_nodnic_priv), 1, 1);
+	if (!netdev)
+		return NULL;
+
+	priv = netdev_priv(netdev);
+	mlx5_nodnic_init_priv(priv, netdev, dev);
+	dev->priv = priv;
+
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+	dev_net_set(netdev, &init_net);
+
+	return netdev;
+}
+
+void mlx5_nodnic_cleanup_netdev(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_priv *priv;
+	struct net_device *netdev;
+
+	if (!dev->priv)
+		return;
+
+	priv = dev->priv;
+	netdev = priv->netdev;
+	if (!netdev)
+		return;
+
+	if (dev->netdev_registered) {
+		netif_device_detach(netdev);
+		unregister_netdev(netdev);
+		dev->netdev_registered = false;
+	}
+
+	mlx5_nodnic_cleanup_priv(priv);
+	dev->priv = NULL;
+
+	free_netdev(netdev);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
new file mode 100644
index 000000000000..d77d9dbe3c89
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
@@ -0,0 +1,874 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "en.h"
+#include "nodnic_ifc.h"
+#include "nodnic.h"
+#include "nodnic_pci_vsc.h"
+
+MODULE_DESCRIPTION("Nvidia Mellanox MLX5_NODNIC core driver");
+MODULE_LICENSE("Dual BSD/GPL");
+
+#define MLX5_NODNIC_FW_INIT_TIMEOUT_MS 120000
+#define MLX5_NODNIC_FW_INIT_WARN_MS 20000
+#define MLX5_NODNIC_FW_PRE_INIT_WAIT_MS 2
+
+static int mlx5_nodnic_pci_enable_device(struct mlx5_nodnic_core_dev *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+	int err = 0;
+
+	mutex_lock(&dev->pci_status_mutex);
+	if (dev->pci_status == MLX5_NODNIC_PCI_STATUS_DISABLED) {
+		err = pci_enable_device(pdev);
+		if (!err)
+			dev->pci_status = MLX5_NODNIC_PCI_STATUS_ENABLED;
+	}
+	mutex_unlock(&dev->pci_status_mutex);
+
+	return err;
+}
+
+static void mlx5_nodnic_pci_disable_device(struct mlx5_nodnic_core_dev *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+
+	mutex_lock(&dev->pci_status_mutex);
+	if (dev->pci_status == MLX5_NODNIC_PCI_STATUS_ENABLED) {
+		pci_disable_device(pdev);
+		dev->pci_status = MLX5_NODNIC_PCI_STATUS_DISABLED;
+	}
+	mutex_unlock(&dev->pci_status_mutex);
+}
+
+static int request_bar(struct pci_dev *pdev)
+{
+	int err;
+
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
+		dev_err(&pdev->dev, "Missing registers BAR, aborting\n");
+		return -ENODEV;
+	}
+
+	err = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (err)
+		dev_err(&pdev->dev, "Couldn't get PCI resources, aborting\n");
+
+	return err;
+}
+
+static void release_bar(struct pci_dev *pdev)
+{
+	pci_release_regions(pdev);
+}
+
+static int set_dma_caps(struct pci_dev *pdev)
+{
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		int err;
+
+		dev_warn(&pdev->dev,
+			 "couldn't set 64-bit PCI DMA mask\n");
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(&pdev->dev,
+				"can't set PCI DMA mask, aborting\n");
+			return err;
+		}
+	}
+
+	dma_set_max_seg_size(&pdev->dev, 2u * 1024 * 1024 * 1024);
+
+	return 0;
+}
+
+static void mlx5_nodnic_pci_close(struct mlx5_nodnic_core_dev *dev)
+{
+	pci_free_irq_vectors(dev->pdev);
+	iounmap(dev->iseg);
+	release_bar(dev->pdev);
+	mlx5_nodnic_pci_disable_device(dev);
+	mlx5_nodnic_vsc_cleanup(dev->vsc_ctx);
+}
+
+static int
+mlx5_nodnic_pci_init(struct mlx5_nodnic_core_dev *dev, struct pci_dev *pdev)
+{
+	int err;
+
+	mutex_init(&dev->pci_status_mutex);
+	pci_set_drvdata(dev->pdev, dev);
+
+	dev->bar_addr = pci_resource_start(pdev, 0);
+
+	err = mlx5_nodnic_pci_enable_device(dev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "cannot enable PCI device, aborting\n");
+		return err;
+	}
+
+	err = request_bar(pdev);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "error requesting BARs, aborting\n");
+		goto err_disable;
+	}
+
+	err = set_dma_caps(pdev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed setting DMA capabilities mask, aborting\n");
+		goto err_release_bar;
+	}
+
+	dev->iseg = ioremap(dev->bar_addr, sizeof(*dev->iseg));
+	if (!dev->iseg) {
+		err = -ENOMEM;
+		mlx5_nodnic_core_err(dev,
+				     "failed mapping initialization segment, aborting\n");
+		goto err_release_bar;
+	}
+
+	dev->vsc_ctx = mlx5_nodnic_vsc_init(dev->pdev);
+	if (!dev->vsc_ctx) {
+		err = -EINVAL;
+		goto err_unmap;
+	}
+
+	if (!pci_find_capability(dev->pdev, PCI_CAP_ID_MSIX)) {
+		mlx5_nodnic_core_err(dev,
+				     "msi-x support is not supported in pci, aborting\n");
+		err = -EOPNOTSUPP;
+		goto err_vsc_cleanup;
+	}
+
+	err = pci_alloc_irq_vectors(pdev,
+				    MLX5_NODNIC_NUM_MSIX, MLX5_NODNIC_NUM_MSIX,
+				    PCI_IRQ_MSIX);
+	if (err < 0) {
+		mlx5_nodnic_core_err(dev, "pci_alloc_irq_vectors failed: %d\n",
+				     err);
+		goto err_vsc_cleanup;
+	}
+
+	return 0;
+
+err_vsc_cleanup:
+	mlx5_nodnic_vsc_cleanup(dev->vsc_ctx);
+err_unmap:
+	iounmap(dev->iseg);
+err_release_bar:
+	release_bar(dev->pdev);
+err_disable:
+	mlx5_nodnic_pci_disable_device(dev);
+	return err;
+}
+
+int mlx5_nodnic_get_fw_initializing(struct mlx5_nodnic_core_dev *dev,
+				    u8 *initializing)
+{
+	u32 data;
+	int err;
+
+	err = mlx5_nodnic_vsc_read_be32(dev->vsc_ctx,
+					MLX5_NODNIC_ISEG_INITIALIZING,
+					&data);
+	if (err)
+		return err;
+
+	*initializing = MLX5_GET(nodnic_iseg_initializing_word, &data,
+				 initializing);
+
+	return 0;
+}
+
+static int mlx5_nodnic_wait_fw_init(struct mlx5_nodnic_core_dev *dev,
+				    const char *init_state)
+{
+	unsigned long timeout =
+		msecs_to_jiffies(MLX5_NODNIC_FW_INIT_TIMEOUT_MS);
+	unsigned long warn_interval =
+		msecs_to_jiffies(MLX5_NODNIC_FW_INIT_WARN_MS);
+	unsigned long warn = jiffies + warn_interval;
+	unsigned long end = jiffies + timeout;
+	u8 fw_initializing;
+	int err;
+
+	do {
+		err = mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx);
+		if (err)
+			return err;
+
+		err = mlx5_nodnic_get_fw_initializing(dev, &fw_initializing);
+		mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
+		if (err) {
+			mlx5_nodnic_core_err(dev,
+					     "failed to read FW initializing state: %d\n",
+					     err);
+			return err;
+		}
+
+		if (!fw_initializing)
+			break;
+
+		if (time_after(jiffies, end)) {
+			mlx5_nodnic_core_err(dev,
+					     "timeout waiting for FW to exit %s state (%u ms)\n",
+					     init_state,
+					     MLX5_NODNIC_FW_INIT_TIMEOUT_MS);
+			return -ETIMEDOUT;
+		}
+		if (time_after(jiffies, warn)) {
+			mlx5_nodnic_core_warn(dev,
+					      "FW still in %s state, %u ms remaining (state=0x%x)\n",
+					      init_state,
+					      jiffies_to_msecs(end - jiffies),
+					      fw_initializing);
+
+			warn = jiffies + warn_interval;
+		}
+		msleep(MLX5_NODNIC_FW_PRE_INIT_WAIT_MS);
+	} while (true);
+
+	return 0;
+}
+
+int mlx5_nodnic_check_supported(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 initializing_word;
+	int err;
+
+	err = mlx5_nodnic_vsc_read_be32(dev->vsc_ctx,
+					MLX5_NODNIC_ISEG_INITIALIZING,
+					&initializing_word);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed reading NODNIC initializing word: %d\n",
+				     err);
+		return err;
+	}
+
+	if (!(MLX5_GET(nodnic_iseg_initializing_word, &initializing_word,
+		       nic_interface_supported) &
+		       BIT(MLX5_NODNIC_ISEG_NIC_INTERFACE_NO_DRAM_NIC))) {
+		mlx5_nodnic_core_err(dev,
+				     "NODNIC is not supported, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int mlx5_nodnic_write_nic_interface(struct mlx5_nodnic_core_dev *dev,
+				    int interface)
+{
+	u32 dword;
+	int err;
+
+	err = mlx5_nodnic_vsc_read_be32(dev->vsc_ctx,
+					MLX5_NODNIC_ISEG_NIC_INTERFACE,
+					&dword);
+	if (err)
+		return err;
+
+	MLX5_SET(nodnic_iseg_cmdq_addr_l, &dword, nic_interface, interface);
+
+	err = mlx5_nodnic_vsc_write_be32(dev->vsc_ctx,
+					 MLX5_NODNIC_ISEG_NIC_INTERFACE,
+					 dword);
+
+	return err;
+}
+
+int mlx5_nodnic_set_nic_interface(struct mlx5_nodnic_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_nodnic_check_supported(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_write_nic_interface(
+		dev, MLX5_NODNIC_ISEG_NIC_INTERFACE_NO_DRAM_NIC);
+	if (err)
+		mlx5_nodnic_core_err(dev,
+				     "failed to write nic_interface err %d\n",
+				     err);
+
+	return err;
+}
+
+static int mlx5_nodnic_read_general_caps(struct mlx5_nodnic_core_dev *dev)
+{
+	u8 hardware_format, revision;
+	bool support_receive_filters;
+	u32 caps;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx,
+					    MLX5_NODNIC_GENERAL_CONFIG_CAPS,
+					    &caps);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read general caps: %d\n",
+				     err);
+		return err;
+	}
+
+	revision = MLX5_GET(nodnic_gen_cfg_caps, &caps, revision);
+	hardware_format = MLX5_GET(nodnic_gen_cfg_caps, &caps, hardware_format);
+	if (revision != 1) {
+		mlx5_nodnic_core_err(dev, "revision is not 1, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (hardware_format != 1) {
+		mlx5_nodnic_core_err(dev,
+				     "hardware format is not 1, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	dev->log_working_buffer_size = MLX5_GET(nodnic_gen_cfg_caps, &caps,
+						log_working_buffer_size);
+	support_receive_filters = MLX5_GET(nodnic_gen_cfg_caps, &caps,
+					   support_receive_filter);
+	if (!support_receive_filters) {
+		mlx5_nodnic_core_err(dev,
+				     "receive filters are not supported, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int mlx5_nodnic_read_ring_config(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 data;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(
+		dev->vsc_ctx,
+		MLX5_NODNIC_GENERAL_CONFIG_LOG_MAX_RING_SIZE,
+		&data);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read ring config: %d\n",
+				     err);
+		return err;
+	}
+
+	dev->log_max_ring_size = MLX5_GET(nodnic_gen_cfg_log_max_ring_size,
+					  &data, log_max_ring_size);
+
+	return 0;
+}
+
+static int mlx5_nodnic_read_lkey(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 lkey;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_cpu32(dev->vsc_ctx,
+					     MLX5_NODNIC_GENERAL_CONFIG_LKEY,
+					     &lkey);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read lkey: %d\n", err);
+		return err;
+	}
+
+	dev->lkey = lkey;
+
+	return 0;
+}
+
+static int mlx5_nodnic_read_cqe_format(struct mlx5_nodnic_core_dev *dev)
+{
+	u8 cqe_format;
+	u32 data;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(
+		dev->vsc_ctx,
+		MLX5_NODNIC_GENERAL_CONFIG_CQE_FORMAT,
+		&data);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read CQE format: %d\n",
+				     err);
+		return err;
+	}
+
+	cqe_format = MLX5_GET(nodnic_gen_cfg_cqe_format, &data, cqe_format);
+	if (cqe_format != 0) {
+		mlx5_nodnic_core_err(dev,
+				     "cqe format is not legacy (0x0), aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int mlx5_nodnic_read_uar_index(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 uar_index;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_cpu32(
+		dev->vsc_ctx,
+		MLX5_NODNIC_PORT_SEND_RING0_UAR_INDEX,
+		&uar_index);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read UAR index: %d\n",
+				     err);
+		return err;
+	}
+
+	dev->send_ring0_uar_index = uar_index;
+
+	return 0;
+}
+
+static int mlx5_nodnic_read_uar_size(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 uar_size;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(
+		dev->vsc_ctx,
+		MLX5_NODNIC_GENERAL_CONFIG_LOG_UAR_PAGE_SIZE,
+		&uar_size);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read UAR size: %d\n", err);
+		return err;
+	}
+
+	dev->log_uar_page_size = MLX5_GET(nodnic_gen_cfg_log_uar_page_size,
+					  &uar_size, log_uar_page_size);
+
+	return 0;
+}
+
+static int mlx5_nodnic_validate_feature_caps(struct mlx5_nodnic_core_dev *dev)
+{
+	u8 support_uar_tx_doorbell, support_bar_cq_ctrl;
+	u8 data_msix_support, event_msix_support;
+	u32 data;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(
+		dev->vsc_ctx,
+		MLX5_NODNIC_GENERAL_CONFIG_FEATURE_CAPS,
+		&data);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read feature caps: %d\n",
+				     err);
+		return err;
+	}
+
+	support_uar_tx_doorbell = MLX5_GET(nodnic_gen_cfg_feature_caps, &data,
+					   support_uar_tx_doorbell);
+	if (!support_uar_tx_doorbell) {
+		mlx5_nodnic_core_err(dev,
+				     "UAR tx doorbell is not supported, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	support_bar_cq_ctrl = MLX5_GET(nodnic_gen_cfg_feature_caps, &data,
+				       support_bar_cq_ctrl);
+	if (!support_bar_cq_ctrl) {
+		mlx5_nodnic_core_err(dev,
+				     "UAR cq arming is not supported, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	data_msix_support = MLX5_GET(nodnic_gen_cfg_feature_caps, &data,
+				     data_msix_support);
+	if (!data_msix_support) {
+		mlx5_nodnic_core_err(dev,
+				     "data MSI-X is not supported, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	event_msix_support = MLX5_GET(nodnic_gen_cfg_feature_caps, &data,
+				      event_msix_support);
+	if (!event_msix_support) {
+		mlx5_nodnic_core_err(dev,
+				     "event MSI-X is not supported, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int mlx5_nodnic_read_config(struct mlx5_nodnic_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_read_offset(dev->vsc_ctx);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to read VSC offset, err=%d\n",
+				     err);
+		return err;
+	}
+
+	err = mlx5_nodnic_read_general_caps(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_read_ring_config(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_read_lkey(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_read_cqe_format(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_validate_feature_caps(dev);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_read_uar_size(dev);
+	if (err)
+		return err;
+
+	return mlx5_nodnic_read_uar_index(dev);
+}
+
+static void mlx5_nodnic_dev_cleanup(struct mlx5_nodnic_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx);
+	if (err)
+		return;
+
+	err = mlx5_nodnic_write_nic_interface(
+		dev, MLX5_NODNIC_ISEG_NIC_INTERFACE_DISABLED);
+	mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
+	if (err)
+		return;
+
+	mlx5_nodnic_wait_fw_init(dev, "teardown");
+}
+
+static int mlx5_nodnic_dev_init(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
+	int err;
+
+	err = mlx5_nodnic_wait_fw_init(dev, "pre-FLR");
+	if (err)
+		return err;
+
+	pci_save_state(dev->pdev);
+	err = pcie_flr(dev->pdev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "pcie_flr failed with error code %d\n",
+				     err);
+		return err;
+	}
+	pci_restore_state(dev->pdev);
+
+	err = mlx5_nodnic_wait_fw_init(dev, "post-FLR");
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_vsc_context_acquire(vsc_ctx);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_set_nic_interface(dev);
+	mlx5_nodnic_vsc_context_release(vsc_ctx);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_set_nic_interface failed with error code %d\n",
+				     err);
+		return err;
+	}
+
+	err = mlx5_nodnic_wait_fw_init(dev, "post-MLX5_NODNIC setup");
+	if (err)
+		goto disable_nic;
+
+	pci_set_master(dev->pdev);
+
+	err = mlx5_nodnic_vsc_context_acquire(vsc_ctx);
+	if (err)
+		goto disable_nic;
+
+	err = mlx5_nodnic_read_config(dev);
+	if (err)
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_read_config failed with error code %d\n",
+				     err);
+
+	mlx5_nodnic_vsc_context_release(vsc_ctx);
+	if (err)
+		goto disable_nic;
+
+	return 0;
+
+disable_nic:
+	mlx5_nodnic_dev_cleanup(dev);
+	return err;
+}
+
+int mlx5_nodnic_validate_port_link_type(struct mlx5_nodnic_core_dev *dev)
+{
+	u8 link_type;
+	u32 event;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx,
+					    MLX5_NODNIC_PORT_EVENT,
+					    &event);
+	if (err) {
+		mlx5_nodnic_core_err(dev, "failed to read port event: %d\n",
+				     err);
+		return err;
+	}
+
+	link_type = MLX5_GET(nodnic_port_event, &event, link_type);
+	if (!link_type) {
+		mlx5_nodnic_core_err(dev, "port is not Ethernet, aborting\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int mlx5_nodnic_read_mac_address(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 mac_h, mac_l;
+	u64 mac;
+	int err;
+
+	err = mlx5_nodnic_vsc_cfg_read_cpu32(dev->vsc_ctx,
+					     MLX5_NODNIC_PORT_MAC_ADDR_H,
+					     &mac_h);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to read MAC address high: %d\n",
+				     err);
+		return err;
+	}
+
+	err = mlx5_nodnic_vsc_cfg_read_cpu32(dev->vsc_ctx,
+					     MLX5_NODNIC_PORT_MAC_ADDR_L,
+					     &mac_l);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "failed to read MAC address low: %d\n",
+				     err);
+		return err;
+	}
+
+	mac = ((u64)mac_h << 32) | mac_l;
+
+	u64_to_ether_addr(mac, dev->mac_address);
+
+	return 0;
+}
+
+static int mlx5_nodnic_port_init(struct mlx5_nodnic_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_validate_port_link_type(dev);
+	if (err)
+		goto release;
+
+	err = mlx5_nodnic_read_mac_address(dev);
+	if (err)
+		goto release;
+
+release:
+	mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
+	return err;
+}
+
+static irqreturn_t mlx5_nodnic_event_irq_thread(int irq, void *data)
+{
+	struct mlx5_nodnic_priv *priv = data;
+
+	if (!netif_device_present(priv->netdev))
+		return IRQ_HANDLED;
+
+	mlx5_nodnic_refresh_carrier(priv);
+
+	return IRQ_HANDLED;
+}
+
+static int mlx5_nodnic_event_irq_setup(struct mlx5_nodnic_core_dev *dev)
+{
+	int irqn, err;
+
+	irqn = pci_irq_vector(dev->pdev, MLX5_NODNIC_EVENT_MSIX);
+	if (irqn < 0) {
+		mlx5_nodnic_core_err(dev,
+				     "pci_irq_vector for event failed: %d\n",
+				     irqn);
+		return irqn;
+	}
+
+	err = request_threaded_irq(irqn, NULL, mlx5_nodnic_event_irq_thread,
+				   IRQF_ONESHOT, "mlx5_nodnic-event",
+				   dev->priv);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "request_threaded_irq for event failed\n");
+		return err;
+	}
+
+	dev->event_irqn = irqn;
+
+	return 0;
+}
+
+static void mlx5_nodnic_event_irq_cleanup(struct mlx5_nodnic_core_dev *dev)
+{
+	if (dev->event_irqn < 0)
+		return;
+	free_irq(dev->event_irqn, dev->priv);
+	dev->event_irqn = -1;
+}
+
+static int mlx5_nodnic_probe_one(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
+{
+	struct mlx5_nodnic_core_dev *dev;
+	struct net_device *netdev;
+	int err;
+
+	dev = kzalloc_obj(struct mlx5_nodnic_core_dev, GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->device = &pdev->dev;
+	dev->pdev = pdev;
+	dev->event_irqn = -1;
+
+	err = mlx5_nodnic_pci_init(dev, pdev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_pci_init failed with error code %d\n",
+				     err);
+		goto err;
+	}
+
+	err = mlx5_nodnic_dev_init(dev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_dev_init failed with error code %d\n",
+				     err);
+		goto err_pci_cleanup;
+	}
+
+	err = mlx5_nodnic_port_init(dev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_port_init failed with error code %d\n",
+				     err);
+		goto err_dev_cleanup;
+	}
+
+	netdev = mlx5_nodnic_create_netdev(dev);
+	if (!netdev) {
+		err = -ENOMEM;
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_create_netdev failed with error code %d\n",
+				     err);
+		goto err_dev_cleanup;
+	}
+
+	mlx5_nodnic_build_netdev(netdev);
+
+	err = mlx5_nodnic_event_irq_setup(dev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "mlx5_nodnic_event_irq_setup failed with error code %d\n",
+				     err);
+		goto err_netdev_cleanup;
+	}
+
+	err = register_netdev(netdev);
+	if (err) {
+		mlx5_nodnic_core_err(dev,
+				     "register_netdev failed with error code %d\n",
+				     err);
+		goto err_irq_cleanup;
+	}
+	dev->netdev_registered = true;
+
+	dev->state = NODNIC_DEVICE_STATE_UP;
+
+	pci_save_state(pdev);
+
+	return 0;
+
+err_irq_cleanup:
+	mlx5_nodnic_event_irq_cleanup(dev);
+err_netdev_cleanup:
+	mlx5_nodnic_cleanup_netdev(dev);
+err_dev_cleanup:
+	mlx5_nodnic_dev_cleanup(dev);
+err_pci_cleanup:
+	mlx5_nodnic_pci_close(dev);
+err:
+	kfree(dev);
+	return err;
+}
+
+static void mlx5_nodnic_remove_one(struct pci_dev *pdev)
+{
+	struct mlx5_nodnic_core_dev *dev = pci_get_drvdata(pdev);
+
+	if (!dev)
+		return;
+
+	mlx5_nodnic_event_irq_cleanup(dev);
+	mlx5_nodnic_cleanup_netdev(dev);
+	mlx5_nodnic_dev_cleanup(dev);
+	mlx5_nodnic_pci_close(dev);
+	kfree(dev);
+}
+
+static const struct pci_device_id mlx5_nodnic_core_pci_table[] = {
+	{ PCI_VDEVICE(MELLANOX, 0xc2d6) }, /* BlueField-4 nodnic rshim PF */
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, mlx5_nodnic_core_pci_table);
+
+static struct pci_driver mlx5_nodnic_core_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = mlx5_nodnic_core_pci_table,
+	.probe = mlx5_nodnic_probe_one,
+	.remove = mlx5_nodnic_remove_one,
+};
+
+static int __init mlx5_nodnic_init(void)
+{
+	return pci_register_driver(&mlx5_nodnic_core_driver);
+}
+
+static void __exit mlx5_nodnic_cleanup(void)
+{
+	pci_unregister_driver(&mlx5_nodnic_core_driver);
+}
+
+module_init(mlx5_nodnic_init);
+module_exit(mlx5_nodnic_cleanup);
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic.h
new file mode 100644
index 000000000000..2fcae95988d8
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#ifndef __MLX5_NODNIC_H__
+#define __MLX5_NODNIC_H__
+
+#include <linux/mlx5/device.h>
+#include <linux/pci.h>
+#include <linux/sched.h>
+
+struct mlx5_nodnic_priv;
+
+#define mlx5_nodnic_core_dbg(__dev, format, ...)		\
+	dev_dbg((__dev)->device, "%s:%d:(pid %d): " format,	\
+		 __func__, __LINE__, current->pid,		\
+		 ##__VA_ARGS__)
+
+#define mlx5_nodnic_core_err(__dev, format, ...)		\
+	dev_err((__dev)->device, "%s:%d:(pid %d): " format,	\
+		__func__, __LINE__, current->pid,		\
+	       ##__VA_ARGS__)
+
+#define mlx5_nodnic_core_warn(__dev, format, ...)		\
+	dev_warn((__dev)->device, "%s:%d:(pid %d): " format,	\
+		__func__, __LINE__, current->pid,		\
+		##__VA_ARGS__)
+
+enum {
+	MLX5_NODNIC_PORT_STATE_DOWN,
+	MLX5_NODNIC_PORT_STATE_INITIALIZE,
+	MLX5_NODNIC_PORT_STATE_ARMED,
+	MLX5_NODNIC_PORT_STATE_ACTIVE,
+};
+
+enum mlx5_nodnic_pci_status {
+	MLX5_NODNIC_PCI_STATUS_DISABLED,
+	MLX5_NODNIC_PCI_STATUS_ENABLED,
+};
+
+enum mlx5_nodnic_device_state {
+	NODNIC_DEVICE_STATE_UP = 1,
+	NODNIC_DEVICE_STATE_INTERNAL_ERROR,
+};
+
+enum mlx5_nodnic_msix {
+	MLX5_NODNIC_DATA_MSIX,
+	MLX5_NODNIC_EVENT_MSIX,
+	MLX5_NODNIC_NUM_MSIX,
+};
+
+struct mlx5_nodnic_vsc_ctx;
+
+struct mlx5_nodnic_core_dev {
+	struct mlx5_nodnic_priv		*priv;
+	struct device			*device;
+	struct pci_dev			*pdev;
+	bool				netdev_registered;
+
+	/* sync pci state */
+	struct mutex			pci_status_mutex;
+	enum mlx5_nodnic_pci_status	pci_status;
+
+	struct mlx5_init_seg __iomem	*iseg;
+	phys_addr_t			bar_addr;
+	struct mlx5_nodnic_vsc_ctx	*vsc_ctx;
+	void __iomem			*uar_base;
+
+	u8				log_working_buffer_size;
+	u8				log_max_ring_size;
+	u8				log_uar_page_size;
+	u32				send_ring0_uar_index;
+
+	u8				mac_address[6];
+	u32				lkey;
+
+	int				event_irqn;
+
+	enum mlx5_nodnic_device_state	state;
+};
+
+void mlx5_nodnic_start_health_poll(struct mlx5_nodnic_core_dev *dev);
+void mlx5_nodnic_stop_health_poll(struct mlx5_nodnic_core_dev *dev);
+
+/*
+ * VSC-gated helpers: the caller must hold the VSC context across these calls.
+ */
+int mlx5_nodnic_open_rq(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_open_sq(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_open_cq(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_init_working_buffer(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_enable_port(struct mlx5_nodnic_core_dev *dev);
+void mlx5_nodnic_disable_port(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_get_fw_initializing(struct mlx5_nodnic_core_dev *dev,
+				    u8 *initializing);
+int mlx5_nodnic_set_nic_interface(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_check_supported(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_write_nic_interface(struct mlx5_nodnic_core_dev *dev,
+				    int interface);
+int mlx5_nodnic_read_config(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_validate_port_link_type(struct mlx5_nodnic_core_dev *dev);
+int mlx5_nodnic_read_mac_address(struct mlx5_nodnic_core_dev *dev);
+
+/* end of VSC-gated helpers */
+
+#endif /* __MLX5_NODNIC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_ifc.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_ifc.h
new file mode 100644
index 000000000000..59de0644ea89
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_ifc.h
@@ -0,0 +1,318 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+#ifndef __MLX5_IFC_NODNIC_H__
+#define __MLX5_IFC_NODNIC_H__
+
+#include <linux/mlx5/device.h>
+#include <linux/types.h>
+
+enum {
+	MLX5_NODNIC_ISEG_NIC_INTERFACE_FULL_DRIVER,
+	MLX5_NODNIC_ISEG_NIC_INTERFACE_DISABLED,
+	MLX5_NODNIC_ISEG_NIC_INTERFACE_NO_DRAM_NIC,
+	MLX5_NODNIC_ISEG_NIC_INTERFACE_SW_RESET = 0x7,
+};
+
+enum {
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_FW_INTERNAL_ERR	= 0x1,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_DEAD_IRISC		= 0x7,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_HW_FATAL_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_FW_CRC_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ICM_FETCH_PCI_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ICM_PAGE_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ASYNCHRONOUS_EQ_BUF_OVERRUN,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_EQ_IN_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_EQ_INV,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_FFSER_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_HIGH_TEMP_ERR,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ICM_PCI_POISONED_ERR = 0x12,
+	MLX5_NODNIC_ISEG_HEALTH_SYNDROME_TRUST_LOCKDOWN_ERR,
+};
+
+/* ISEG */
+#define MLX5_NODNIC_ISEG_NIC_INTERFACE MLX5_BYTE_OFF(nodnic_iseg, cmdq_addr_l)
+#define MLX5_NODNIC_ISEG_INITIALIZING \
+	MLX5_BYTE_OFF(nodnic_iseg, initializing_word)
+#define MLX5_NODNIC_ISEG_NO_DRAM_NIC_OFFSET \
+	MLX5_BYTE_OFF(nodnic_iseg, no_dram_nic_offset)
+#define MLX5_NODNIC_ISEG_CMD_ADDR_L \
+	MLX5_BYTE_OFF(nodnic_iseg_cmdq_addr_l, cmdq_addr_l)
+#define MLX5_NODNIC_ISEG_CLEAR_INT MLX5_BYTE_OFF(nodnic_iseg, clear_int)
+
+/* General configuration */
+#define MLX5_NODNIC_GENERAL_CONFIG_CAPS MLX5_BYTE_OFF(nodnic_gen_cfg, caps)
+#define MLX5_NODNIC_GENERAL_CONFIG_LOG_MAX_RING_SIZE \
+	MLX5_BYTE_OFF(nodnic_gen_cfg, log_max_ring_size)
+#define MLX5_NODNIC_GENERAL_CONFIG_LKEY MLX5_BYTE_OFF(nodnic_gen_cfg, lkey)
+#define MLX5_NODNIC_GENERAL_CONFIG_CQE_FORMAT \
+	MLX5_BYTE_OFF(nodnic_gen_cfg, cqe_format)
+#define MLX5_NODNIC_GENERAL_CONFIG_FEATURE_CAPS \
+	MLX5_BYTE_OFF(nodnic_gen_cfg, feature_caps)
+#define MLX5_NODNIC_GENERAL_CONFIG_LOG_UAR_PAGE_SIZE \
+	MLX5_BYTE_OFF(nodnic_gen_cfg, log_uar_page_size)
+
+/* Port */
+#define MLX5_NODNIC_PORT_OFFSET \
+	MLX5_BYTE_OFF(nodnic_config_seg, port)
+#define MLX5_NODNIC_PORT_FIELD_OFFSET(field) \
+	(MLX5_NODNIC_PORT_OFFSET + MLX5_BYTE_OFF(nodnic_port_settings, field))
+
+#define MLX5_NODNIC_PORT_EVENT		MLX5_NODNIC_PORT_FIELD_OFFSET(event)
+#define MLX5_NODNIC_RECEIVE_RING_OFFSET	\
+	MLX5_NODNIC_PORT_FIELD_OFFSET(receive_ring0)
+#define MLX5_NODNIC_SEND_RING_OFFSET MLX5_NODNIC_PORT_FIELD_OFFSET(send_ring0)
+#define MLX5_NODNIC_PORT_NETWORK	MLX5_NODNIC_PORT_FIELD_OFFSET(network)
+#define MLX5_NODNIC_PORT_MAC_ADDR_H	MLX5_NODNIC_PORT_FIELD_OFFSET(mac_h)
+#define MLX5_NODNIC_PORT_MAC_ADDR_L	MLX5_NODNIC_PORT_FIELD_OFFSET(mac_l)
+#define MLX5_NODNIC_PORT_CQ_ADDR_H	MLX5_NODNIC_PORT_FIELD_OFFSET(cq_addr_h)
+#define MLX5_NODNIC_PORT_CQ_ADDR_L	MLX5_NODNIC_PORT_FIELD_OFFSET(cq_addr_l)
+#define MLX5_NODNIC_PORT_WORKING_BUFFER_ADDR_H \
+	MLX5_NODNIC_PORT_FIELD_OFFSET(working_buffer_addr_h)
+#define MLX5_NODNIC_PORT_WORKING_BUFFER_ADDR_L \
+	MLX5_NODNIC_PORT_FIELD_OFFSET(working_buffer_addr_l)
+#define MLX5_NODNIC_PORT_ARM_CQ		MLX5_NODNIC_PORT_FIELD_OFFSET(arm_cq)
+#define MLX5_NODNIC_PORT_SEND_RING0_UAR_INDEX \
+	MLX5_NODNIC_PORT_FIELD_OFFSET(send_ring0_uar_index)
+#define MLX5_NODNIC_CQ_DBR_ADDR_H	\
+	MLX5_NODNIC_PORT_FIELD_OFFSET(cq_dbr_addr_h)
+#define MLX5_NODNIC_CQ_DBR_ADDR_L	\
+	MLX5_NODNIC_PORT_FIELD_OFFSET(cq_dbr_addr_l)
+#define MLX5_NODNIC_CQ_N		\
+	MLX5_NODNIC_PORT_FIELD_OFFSET(cqn)
+
+/* Port ring */
+#define MLX5_NODNIC_RING_ADDR_H MLX5_BYTE_OFF(nodnic_ring_config, q_addr_h)
+#define MLX5_NODNIC_RING_ADDR_L MLX5_BYTE_OFF(nodnic_ring_config, q_addr_l)
+#define MLX5_NODNIC_RING_QUEUE_NUMBER \
+	MLX5_BYTE_OFF(nodnic_ring_config, q_number)
+#define MLX5_NODNIC_RING_DBR_ADDR_H \
+	MLX5_BYTE_OFF(nodnic_ring_config, dbr_addr_h)
+#define MLX5_NODNIC_RING_DBR_ADDR_L \
+	MLX5_BYTE_OFF(nodnic_ring_config, dbr_addr_l)
+
+/* mlx5_nodnic configurations are read and written from VSC
+ * in a dword granularity
+ */
+
+struct mlx5_ifc_nodnic_iseg_cmdq_addr_l_bits {
+	u8 cmdq_addr_l[0x14];
+	u8 reserved_at_14[0x1];
+	u8 nic_interface[0x3];
+	u8 log_cmdq_size[0x4];
+	u8 log_cmdq_stride[0x4];
+};
+
+struct mlx5_ifc_nodnic_iseg_initializing_word_bits {
+	u8 initializing[0x1];
+	u8 nic_interface_supported[0x7];
+	u8 embedded_cpu[0x1];
+	u8 driver_reset_ack[0x1];
+	u8 recovery[0x1];
+	u8 pre_boot_bios_hold[0x1];
+	u8 initializing_state[0x4];
+	u8 reset_state_machine[0x4];
+	u8 reserved_at_14[0x1];
+	u8 pre_boot_action[0x3];
+	u8 reserved_at_17[0x8];
+};
+
+struct mlx5_ifc_nodnic_iseg_health_buffer_bits {
+	u8 reserved_at_0[0x100];
+	u8 assert_existptr[0x20];
+	u8 assert_callra[0x20];
+	u8 reserved_at_28[0x20];
+	u8 time[0x20];
+	u8 fw_version[0x20];
+	u8 hw_id[0x20];
+	u8 rfr[0x1];
+	u8 crr[0x1];
+	u8 reserved_at_e2[0x2];
+	u8 valid[0x1];
+	u8 severity[0x3];
+	u8 reserved_at_e8[0x18];
+	u8 irisc_index[0x8];
+	u8 synd[0x8];
+	u8 ext_synd[0x10];
+};
+
+struct mlx5_ifc_nodnic_clear_int_bits {
+	u8 reserved_at_0[0x1f];
+	u8 clear_int[0x1];
+};
+
+struct mlx5_ifc_nodnic_iseg_bits {
+	u8 fw_rev[0x20];
+	u8 cmdif_rev[0x20];
+	u8 rsvd0[0x40];
+	u8 cmdq_addr_h[0x20];
+	struct mlx5_ifc_nodnic_iseg_cmdq_addr_l_bits cmdq_addr_l;
+	u8 command_doorbell_vector[0x20];
+	u8 rsvd1[0xee0];
+	u8 traffic_state_rsvd[0x1e];
+	u8 traffic_state[0x2];
+	struct mlx5_ifc_nodnic_iseg_initializing_word_bits initializing_word;
+	struct mlx5_ifc_nodnic_iseg_health_buffer_bits health_buffer;
+	u8 no_dram_nic_offset[0x20];
+	u8 rsvd2[0x6e40];
+	struct mlx5_ifc_nodnic_clear_int_bits clear_int;
+};
+
+struct mlx5_ifc_nodnic_q_addr_l_bits {
+	u8 q_addr_l[0x14];
+	u8 reserved_at_14[0x6];
+	u8 log_size[0x6];
+};
+
+struct mlx5_ifc_nodnic_ring_db_reg_bits {
+	u8 reserved_at_0[0x8];
+	u8 ring_pi[0x10];
+	u8 reserved_at_18[0x8];
+};
+
+struct mlx5_ifc_nodnic_ring_q_number_bits {
+	u8 reserved_at_0[0x8];
+	u8 queue_number[0x18];
+};
+
+struct mlx5_ifc_nodnic_ring_dbr_addr_l_bits {
+	u8 db_record_addr_l[0x1e];
+	u8 reserved_at_1e[0x2];
+};
+
+struct mlx5_ifc_nodnic_ring_config_bits {
+	u8 q_addr_h[0x20];
+	struct mlx5_ifc_nodnic_q_addr_l_bits q_addr_l;
+	struct mlx5_ifc_nodnic_ring_db_reg_bits	db_reg;
+	struct mlx5_ifc_nodnic_ring_q_number_bits q_number;
+	u8 q_key[0x20];
+	u8 pkey[0x20];
+	u8 dbr_addr_h[0x20];
+	u8 dbr_addr_l[0x20];
+};
+
+struct mlx5_ifc_nodnic_port_event_bits {
+	u8 driver_reset_needed[0x1];
+	u8 port_management_change[0x1];
+	u8 reserved_at_2[0x19];
+	u8 link_type[0x1];
+	u8 port_state[0x4];
+};
+
+struct mlx5_ifc_nodnic_port_network_bits {
+	u8 network_en[0x1];
+	u8 dma_en[0x1];
+	u8 promisc_en[0x1];
+	u8 promisc_multicast_en[0x1];
+	u8 vlan_stripping_en[0x1];
+	u8 protocol_filter_ip_ver[0x1];
+	u8 data_msix_en[0x1];
+	u8 event_msix_en[0x1];
+	u8 reserved_at_8[0x8];
+	u8 protocol_filter_en[0x8];
+	u8 reserved_at_18[0x3];
+	u8 receive_filter_en[0x5];
+};
+
+struct mlx5_ifc_nodnic_port_mac_h_bits {
+	u8 reserved_at_0[0x10];
+	u8 mac_h[0x10];
+};
+
+struct mlx5_ifc_nodnic_port_arm_cq_bits {
+	u8 cq_ci[0x18];
+	u8 reserved_at_18[0x8];
+};
+
+struct  mlx5_ifc_nodnic_cqn_bits {
+	u8 reserved[0x8];
+	u8 cq_n[0x18];
+};
+
+struct mlx5_ifc_nodnic_port_settings_bits {
+	struct mlx5_ifc_nodnic_port_event_bits event;
+	struct mlx5_ifc_nodnic_port_network_bits network;
+	struct mlx5_ifc_nodnic_port_mac_h_bits mac_h;
+	u8 mac_l[0x20];
+	u8 mac_filters[0x200];
+	u8 gid[0x80];
+	u8 reserved_at_300[0x20];
+	u8 sm_sl_lid[0x20];
+	u8 cq_addr_h[0x20];
+	struct mlx5_ifc_nodnic_q_addr_l_bits cq_addr_l;
+	u8 working_buffer_addr_h[0x20];
+	u8 working_buffer_addr_l[0x20];
+	struct mlx5_ifc_nodnic_port_arm_cq_bits arm_cq;
+	u8 pkey[0x20];
+	struct mlx5_ifc_nodnic_ring_config_bits send_ring0;
+	u8 rsvd_send_ring1[0x100];
+	struct mlx5_ifc_nodnic_ring_config_bits receive_ring0;
+	u8 rsvd_receive_ring1[0x100];
+	u8 protocol_filter_tftp_port[0x20];
+	u8 reserved_at_104[0x20];
+	u8 send_ring0_uar_index[0x20];
+	u8 send_ring1_uar_index[0x20];
+	u8 cq_dbr_addr_h[0x20];
+	u8 cq_dbr_addr_l[0x20];
+	struct mlx5_ifc_nodnic_cqn_bits cqn;
+	u8 padding[0x320];
+};
+
+struct mlx5_ifc_nodnic_gen_cfg_caps_bits  {
+	u8 revision[0x8];
+	u8 hardware_format[0x8];
+	u8 support_receive_filter[0x1];
+	u8 support_promisc_filter[0x1];
+	u8 support_promisc_multicast[0x1];
+	u8 support_protocol_filter[0x1];
+	u8 reserved_at_13[0x1];
+	u8 log_working_buffer_size[0x3];
+	u8 log_pkey_table_size[0x4]; /* IB */
+	u8 reserved_at_1a[0x3];
+	u8 num_ports[0x1];
+};
+
+struct mlx5_ifc_nodnic_gen_cfg_log_max_ring_size_bits {
+	u8 reserved_at_0[0x2];
+	u8 log_max_ring_size[0x6];
+	u8 reserved_at_8[0x18];
+};
+
+struct mlx5_ifc_nodnic_gen_cfg_cqe_format_bits {
+	u8 cqe_format[0x4];
+	u8 reserved_at_4[0x1c];
+};
+
+struct mlx5_ifc_nodnic_gen_cfg_feature_caps_bits {
+	u8 support_db_record_rx[0x1];
+	u8 reserved_at_1[0x1];
+	u8 support_uar_tx_doorbell[0x1];
+	u8 support_bar_dma_en[0x1];
+	u8 support_bar_cq_ctrl[0x1];
+	u8 vlan_stripping_supported[0x1];
+	u8 data_msix_support[0x1];
+	u8 event_msix_support[0x1];
+	u8 reserved_at_8[0x18];
+};
+
+struct mlx5_ifc_nodnic_gen_cfg_log_uar_page_size_bits {
+	u8 reserved_at_0[0x18];
+	u8 log_uar_page_size[0x8];
+};
+
+struct mlx5_ifc_nodnic_gen_cfg_bits {
+	struct mlx5_ifc_nodnic_gen_cfg_caps_bits caps;
+	struct mlx5_ifc_nodnic_gen_cfg_log_max_ring_size_bits log_max_ring_size;
+	u8 lkey[0x20];
+	struct mlx5_ifc_nodnic_gen_cfg_cqe_format_bits cqe_format;
+	u8 reserved_at_80[3][0x20];
+	struct mlx5_ifc_nodnic_gen_cfg_feature_caps_bits feature_caps;
+	struct mlx5_ifc_nodnic_gen_cfg_log_uar_page_size_bits log_uar_page_size;
+};
+
+struct mlx5_ifc_nodnic_config_seg_bits {
+	struct mlx5_ifc_nodnic_gen_cfg_bits general;
+	u8 reserved_at_24[55][0x20];
+	struct mlx5_ifc_nodnic_port_settings_bits port;
+};
+
+#endif /* __MLX5_IFC_NODNIC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c
new file mode 100644
index 000000000000..9e9cdf375c8e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "nodnic_ifc.h"
+#include "nodnic_pci_vsc.h"
+
+struct mlx5_nodnic_vsc_ctx {
+	struct pci_dev		*pdev;
+	u32			 addr;   /* VSC init segment address */
+	u32			 offset; /* NODNIC config offset */
+};
+
+#define MLX5_NODNIC_ONES32(size)			\
+	((size) ? (0xffffffff >> (32 - (size))) : 0)
+#define MLX5_NODNIC_MASK32(offset, size)		\
+	(MLX5_NODNIC_ONES32(size) << (offset))
+#define MLX5_NODNIC_EXTRACT_C(source, offset, size)	\
+	((((u32)(source)) >> (offset)) & MLX5_NODNIC_ONES32(size))
+#define MLX5_NODNIC_EXTRACT(src, start, len)		\
+	(((len) == 32) ? (src) : MLX5_NODNIC_EXTRACT_C(src, start, len))
+#define MLX5_NODNIC_MERGE_C(rsrc1, rsrc2, start, len)  \
+	((((rsrc2) << (start)) & (MLX5_NODNIC_MASK32((start), (len)))) | \
+	((rsrc1) & (~MLX5_NODNIC_MASK32((start), (len)))))
+#define MLX5_NODNIC_MERGE(rsrc1, rsrc2, start, len)	\
+	(((len) == 32) ? (rsrc2) : \
+			 MLX5_NODNIC_MERGE_C(rsrc1, rsrc2, start, len))
+#define mlx5_nodnic_vsc_pci_read(ctx, offset, val) \
+	pci_read_config_dword((ctx)->pdev, (ctx)->addr + (offset), (val))
+#define mlx5_nodnic_vsc_pci_write(ctx, offset, val) \
+	pci_write_config_dword((ctx)->pdev, (ctx)->addr + (offset), (val))
+#define VSC_MAX_RETRIES 2048
+
+enum {
+	MLX5_NODNIC_VSC_CTRL_OFFSET = 0x4,
+	MLX5_NODNIC_VSC_COUNTER_OFFSET = 0x8,
+	MLX5_NODNIC_VSC_SEMAPHORE_OFFSET = 0xc,
+	MLX5_NODNIC_VSC_ADDR_OFFSET = 0x10,
+	MLX5_NODNIC_VSC_DATA_OFFSET = 0x14,
+
+	MLX5_NODNIC_VSC_FLAG_BIT_OFFS = 31,
+	MLX5_NODNIC_VSC_FLAG_BIT_LEN = 1,
+
+	MLX5_NODNIC_VSC_SYND_BIT_OFFS = 30,
+	MLX5_NODNIC_VSC_SYND_BIT_LEN = 1,
+
+	MLX5_NODNIC_VSC_ADDR_BIT_OFFS = 0,
+	MLX5_NODNIC_VSC_ADDR_BIT_LEN = 30,
+
+	MLX5_NODNIC_VSC_SPACE_BIT_OFFS = 0,
+	MLX5_NODNIC_VSC_SPACE_BIT_LEN = 16,
+
+	MLX5_NODNIC_VSC_SIZE_VLD_BIT_OFFS = 28,
+	MLX5_NODNIC_VSC_SIZE_VLD_BIT_LEN = 1,
+
+	MLX5_NODNIC_VSC_STATUS_BIT_OFFS = 29,
+	MLX5_NODNIC_VSC_STATUS_BIT_LEN = 3,
+};
+
+struct mlx5_nodnic_vsc_ctx *mlx5_nodnic_vsc_init(struct pci_dev *pdev)
+{
+	struct mlx5_nodnic_vsc_ctx *ctx;
+
+	ctx = kzalloc_obj(struct mlx5_nodnic_vsc_ctx, GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->pdev = pdev;
+	ctx->addr = pci_find_capability(ctx->pdev, PCI_CAP_ID_VNDR);
+	if (!ctx->addr) {
+		dev_err(&ctx->pdev->dev,
+			"failed to get valid vendor specific ID\n");
+		kfree(ctx);
+		return NULL;
+	}
+
+	return ctx;
+}
+
+void mlx5_nodnic_vsc_cleanup(struct mlx5_nodnic_vsc_ctx *ctx)
+{
+	kfree(ctx);
+}
+
+int mlx5_nodnic_vsc_read_offset(struct mlx5_nodnic_vsc_ctx *ctx)
+{
+	u32 offset;
+	int err;
+
+	err = mlx5_nodnic_vsc_read_cpu32(ctx,
+					 MLX5_NODNIC_ISEG_NO_DRAM_NIC_OFFSET,
+					 &offset);
+	if (err) {
+		dev_warn(&ctx->pdev->dev,
+			 "failed to read no_dram_nic_offset err %d\n", err);
+		return err;
+	}
+
+	ctx->offset = offset;
+	return 0;
+}
+
+static int mlx5_nodnic_vsc_gw_lock(struct mlx5_nodnic_vsc_ctx *ctx)
+{
+	struct pci_dev *pdev = ctx->pdev;
+	u32 lock_val, counter = 0;
+	int err, retries = 0;
+
+	pci_cfg_access_lock(pdev);
+
+	do {
+		if (retries > VSC_MAX_RETRIES) {
+			err = -EBUSY;
+			goto pci_unlock;
+		}
+		if (pci_channel_offline(pdev)) {
+			err = -EACCES;
+			goto pci_unlock;
+		}
+
+		/* Check if semaphore is already locked */
+		err = mlx5_nodnic_vsc_pci_read(ctx,
+					       MLX5_NODNIC_VSC_SEMAPHORE_OFFSET,
+					       &lock_val);
+		if (err)
+			goto pci_unlock;
+
+		if (lock_val) {
+			retries++;
+			usleep_range(1000, 2000);
+			continue;
+		}
+
+		/* Read and write counter value, if written value is
+		 * the same, semaphore was acquired successfully.
+		 */
+		err = mlx5_nodnic_vsc_pci_read(ctx,
+					       MLX5_NODNIC_VSC_COUNTER_OFFSET,
+					       &counter);
+		if (err)
+			goto pci_unlock;
+
+		err = mlx5_nodnic_vsc_pci_write(
+			ctx, MLX5_NODNIC_VSC_SEMAPHORE_OFFSET, counter);
+		if (err)
+			goto pci_unlock;
+
+		err = mlx5_nodnic_vsc_pci_read(
+			ctx, MLX5_NODNIC_VSC_SEMAPHORE_OFFSET, &lock_val);
+		if (err)
+			goto pci_unlock;
+
+		retries++;
+	} while (counter != lock_val);
+
+	return 0;
+
+pci_unlock:
+	pci_cfg_access_unlock(pdev);
+	return err;
+}
+
+static int mlx5_nodnic_vsc_gw_unlock(struct mlx5_nodnic_vsc_ctx *ctx)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_pci_write(
+		ctx, MLX5_NODNIC_VSC_SEMAPHORE_OFFSET, MLX5_NODNIC_VSC_UNLOCK);
+	pci_cfg_access_unlock(ctx->pdev);
+
+	return err;
+}
+
+static int
+mlx5_nodnic_vsc_gw_set_space(struct mlx5_nodnic_vsc_ctx *ctx, u16 space)
+{
+	u32 val;
+	int err;
+
+	err = mlx5_nodnic_vsc_pci_read(ctx, MLX5_NODNIC_VSC_CTRL_OFFSET, &val);
+	if (err)
+		return err;
+
+	val = MLX5_NODNIC_MERGE(
+		val, space, MLX5_NODNIC_VSC_SPACE_BIT_OFFS,
+		MLX5_NODNIC_VSC_SPACE_BIT_LEN);
+	err = mlx5_nodnic_vsc_pci_write(ctx, MLX5_NODNIC_VSC_CTRL_OFFSET, val);
+	if (err)
+		return err;
+
+	err = mlx5_nodnic_vsc_pci_read(ctx, MLX5_NODNIC_VSC_CTRL_OFFSET, &val);
+	if (err)
+		return err;
+
+	if (MLX5_NODNIC_EXTRACT(
+		val, MLX5_NODNIC_VSC_STATUS_BIT_OFFS,
+		MLX5_NODNIC_VSC_STATUS_BIT_LEN) == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int mlx5_nodnic_vsc_context_acquire(struct mlx5_nodnic_vsc_ctx *ctx)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_gw_lock(ctx);
+	if (err) {
+		dev_warn(&ctx->pdev->dev, "failed to lock vsc, err %d\n", err);
+		return err;
+	}
+
+	err = mlx5_nodnic_vsc_gw_set_space(ctx, MLX5_NODNIC_VSC_SPACE_NODNIC);
+	if (err) {
+		dev_warn(&ctx->pdev->dev,
+			 "failed to set vsc space, err %d\n", err);
+		mlx5_nodnic_vsc_gw_unlock(ctx);
+		return err;
+	}
+
+	return err;
+}
+
+void mlx5_nodnic_vsc_context_release(struct mlx5_nodnic_vsc_ctx *ctx)
+{
+	mlx5_nodnic_vsc_gw_unlock(ctx);
+}
+
+static int mlx5_nodnic_vsc_wait_on_flag(struct mlx5_nodnic_vsc_ctx *ctx,
+					u8 expected_val)
+{
+	int err, retries = 0;
+	u32 flag;
+
+	do {
+		if (retries > VSC_MAX_RETRIES)
+			return -EBUSY;
+
+		err = mlx5_nodnic_vsc_pci_read(ctx,
+					       MLX5_NODNIC_VSC_ADDR_OFFSET,
+					       &flag);
+		if (err)
+			return err;
+		flag = MLX5_NODNIC_EXTRACT(flag,
+					   MLX5_NODNIC_VSC_FLAG_BIT_OFFS,
+					   MLX5_NODNIC_VSC_FLAG_BIT_LEN);
+		retries++;
+
+		if ((retries & 0xf) == 0)
+			usleep_range(1000, 2000);
+
+	} while (flag != expected_val);
+
+	return 0;
+}
+
+static int mlx5_nodnic_vsc_read(struct mlx5_nodnic_vsc_ctx *ctx,
+				unsigned int address, u32 *data)
+{
+	int err;
+
+	/*  Write address and CLEAR flag and syndrome.
+	 *  We mask the real_address to ensure the Flag and Syndrome bit
+	 *  positions are 0x0. Assuming MLX5_NODNIC_VSC_SYND_BIT_OFFS is
+	 *  the start of the flag/syndrome field.
+	 */
+	u32 mask = ~(((1U << MLX5_NODNIC_VSC_FLAG_BIT_LEN) - 1) <<
+		     MLX5_NODNIC_VSC_SYND_BIT_OFFS) &
+		   ~(((1U << MLX5_NODNIC_VSC_SYND_BIT_LEN) - 1) <<
+		     (MLX5_NODNIC_VSC_SYND_BIT_OFFS +
+		      MLX5_NODNIC_VSC_FLAG_BIT_LEN));
+
+	/* Apply the mask to clear the bits */
+	address &= mask;
+
+	err = mlx5_nodnic_vsc_pci_write(ctx,
+					MLX5_NODNIC_VSC_ADDR_OFFSET,
+					address);
+	if (err)
+		goto out;
+
+	err = mlx5_nodnic_vsc_wait_on_flag(ctx, 1);
+	if (err)
+		goto out;
+
+	err = mlx5_nodnic_vsc_pci_read(ctx, MLX5_NODNIC_VSC_DATA_OFFSET, data);
+out:
+	return err;
+}
+
+static int mlx5_nodnic_vsc_write(struct mlx5_nodnic_vsc_ctx *ctx,
+				 unsigned int address, u32 data)
+{
+	u32 clear_mask;
+	int err;
+
+	err = mlx5_nodnic_vsc_pci_write(ctx, MLX5_NODNIC_VSC_DATA_OFFSET, data);
+	if (err)
+		goto out;
+
+	/* Prepare the address register.
+	 * We must:
+	 * 1. Set the Address bits.
+	 * 2. Set the Flag bit to 0x1.
+	 * 3. Clear the Syndrome bits to 0x0.
+	 */
+
+	clear_mask = ~(((1U << MLX5_NODNIC_VSC_FLAG_BIT_LEN) - 1) <<
+		       MLX5_NODNIC_VSC_FLAG_BIT_OFFS) &
+		     ~(((1U << MLX5_NODNIC_VSC_SYND_BIT_LEN) - 1) <<
+		       MLX5_NODNIC_VSC_SYND_BIT_OFFS);
+
+	address &= clear_mask;
+	address |= (1U << MLX5_NODNIC_VSC_FLAG_BIT_OFFS);
+
+	err = mlx5_nodnic_vsc_pci_write(ctx,
+					MLX5_NODNIC_VSC_ADDR_OFFSET,
+					address);
+	if (err)
+		return err;
+
+	/* Wait for the hardware to clear the flag to 0x0,
+	 * indicating the write operation has completed.
+	 */
+	err = mlx5_nodnic_vsc_wait_on_flag(ctx, 0);
+
+out:
+	return err;
+}
+
+static u32 mlx5_nodnic_le32_to_be32(u32 data)
+{
+	return cpu_to_be32(le32_to_cpu(data));
+}
+
+static u32 mlx5_nodnic_be32_to_le32(u32 data)
+{
+	return cpu_to_le32(be32_to_cpu(data));
+}
+
+int mlx5_nodnic_vsc_read_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+			      unsigned int address, u32 *data)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_read(ctx, address, data);
+	if (!err)
+		*data = mlx5_nodnic_le32_to_be32(*data);
+
+	return err;
+}
+
+int mlx5_nodnic_vsc_read_cpu32(struct mlx5_nodnic_vsc_ctx *ctx,
+			       unsigned int address, u32 *data)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_read(ctx, address, data);
+	if (!err)
+		*data = le32_to_cpu(*data);
+
+	return err;
+}
+
+int mlx5_nodnic_vsc_write_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+			       unsigned int address, u32 data)
+{
+	data = mlx5_nodnic_be32_to_le32(data);
+
+	return mlx5_nodnic_vsc_write(ctx, address, data);
+}
+
+int mlx5_nodnic_vsc_cfg_read_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+				  unsigned int address, u32 *data)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_read(ctx, ctx->offset + address, data);
+	if (err)
+		return err;
+
+	*data = mlx5_nodnic_le32_to_be32(*data);
+
+	return 0;
+}
+
+int mlx5_nodnic_vsc_cfg_write_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+				   unsigned int address, u32 data)
+{
+	data = mlx5_nodnic_be32_to_le32(data);
+
+	return mlx5_nodnic_vsc_write(ctx, ctx->offset + address, data);
+}
+
+int mlx5_nodnic_vsc_cfg_read_cpu32(struct mlx5_nodnic_vsc_ctx *ctx,
+				   unsigned int address, u32 *data)
+{
+	int err;
+
+	err = mlx5_nodnic_vsc_read(ctx, ctx->offset + address, data);
+	if (err)
+		return err;
+
+	*data = le32_to_cpu(*data);
+
+	return 0;
+}
+
+int mlx5_nodnic_vsc_cfg_write_cpu32(struct mlx5_nodnic_vsc_ctx *ctx,
+				    unsigned int address, u32 data)
+{
+	data = cpu_to_le32(data);
+
+	return mlx5_nodnic_vsc_write(ctx, ctx->offset + address, data);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.h
new file mode 100644
index 000000000000..b48ee7abf83f
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#ifndef __MLX5_NODNIC_PCI_VSC_H__
+#define __MLX5_NODNIC_PCI_VSC_H__
+
+#include <linux/pci.h>
+#include <linux/types.h>
+
+struct mlx5_nodnic_vsc_ctx;
+
+enum mlx5_nodnic_vsc_state {
+	MLX5_NODNIC_VSC_UNLOCK,
+	MLX5_NODNIC_VSC_LOCK,
+};
+
+enum {
+	MLX5_NODNIC_VSC_SPACE_NODNIC = 0x4,
+};
+
+struct mlx5_nodnic_vsc_ctx *mlx5_nodnic_vsc_init(struct pci_dev *pdev);
+void mlx5_nodnic_vsc_cleanup(struct mlx5_nodnic_vsc_ctx *ctx);
+int mlx5_nodnic_vsc_read_offset(struct mlx5_nodnic_vsc_ctx *ctx);
+int mlx5_nodnic_vsc_context_acquire(struct mlx5_nodnic_vsc_ctx *ctx);
+void mlx5_nodnic_vsc_context_release(struct mlx5_nodnic_vsc_ctx *ctx);
+
+/* base address - init segment copy in VSC */
+int mlx5_nodnic_vsc_read_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+			      unsigned int address, u32 *data);
+int mlx5_nodnic_vsc_write_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+			       unsigned int address, u32 data);
+int mlx5_nodnic_vsc_read_cpu32(struct mlx5_nodnic_vsc_ctx *ctx,
+			       unsigned int address, u32 *data);
+
+/* base address - nodnic configuration registers in VSC */
+int mlx5_nodnic_vsc_cfg_read_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+				  unsigned int address, u32 *data);
+int mlx5_nodnic_vsc_cfg_write_be32(struct mlx5_nodnic_vsc_ctx *ctx,
+				   unsigned int address, u32 data);
+int mlx5_nodnic_vsc_cfg_read_cpu32(struct mlx5_nodnic_vsc_ctx *ctx,
+				   unsigned int address, u32 *data);
+int mlx5_nodnic_vsc_cfg_write_cpu32(struct mlx5_nodnic_vsc_ctx *ctx,
+				    unsigned int address, u32 data);
+
+#endif /* __MLX5_NODNIC_PCI_VSC_H__ */
-- 
2.44.0

