Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BC3BBFBE;
	Thu,  8 Oct 2026 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480111; cv=fail; b=t6lFt1o77rlzrXJWvfOPLqvkumaI0uL9CGvgmKFyactTpGQ+Ry+8ZDViH1aVVKIhrGRfdeAkaKuEcda5pwtiEkaaifp4HA5+8XQgSUEgp804gOWUCRpuTOy3YaLLsvUpuZqNmNXtVyB7kerWQcG+8tIcRXUpDWqgeJmQC2UIApw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480111; c=relaxed/simple;
	bh=8yj3uLowQyjaRH5yQana98RjymjjGrXhYPMtSuGr254=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcEwY+EDnzdVnARFX6KGmKfMMSHcczmkDJ1/RvVKW+bpTSNRyG92kL0l3qksAO353TaPCecPs/FM8/e2LAItK1kjjmDCITvmXJ7iGUtJGeMqbxZdFnHg4+H6ahV8DhsI2mA5J23NYb+awG5qz0/RcqbEPexg5Q0yw1nzzGyg5+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pd6U8kq5; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pd6U8kq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5iW6Ul80u5FphgYZIK2PCFe5j6y8YFv8MQinP82b3h1IqOoYKoFTM7Rq5OP2TUbdJgPEOpKybjjti41Yp7rUCdZpcEd20RiCCJJrlIdotYJCQyfoQ4Ba8HLZSjyG9Aw1NXoRK4RzwuKBOEeiFwRUl3rICOYIcws5W/kxdzuO65RikPd59hju1rClOjCIfMgyrU9VV+yyDb6n5RQxijNffCFmAXY8HFnwyMllKRN4tsYlMgXmCMeQwvqZFjzCtACbhgndeVxirGfgkXEMYTpgyrY+PWIwtriEg5x17amfXO4a4OwUkYCgBCgE7R+Rakqfphc9P0fhL6fpaVLAngXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KIXVnrsETFGJmIOsCj9MigL3Q7tniQDU8xAozlJbFk=;
 b=HSb/muae9kpkTEQO/qqUG+B3phoNZ/SGsU3WN6KoRnxj+ulbkp/wfWXjMHo14gsuec91MSW6g8ZP65oTa5NLZNJiviwdFTma3QUxxi+788Ie3hlsxf3ZIO1xnTTyOfzsinyZR5lP2P3TxwgKGuRf3Jm/ZO2jPYFgCW4BgS9/utHO9u3Svu/+nbxbIQ8RvmYsPt6TvNU9rvugoPvVZF0avHN7jiECIG6rV+AYDOnyElsZEW5S8R5Jwn2YNcTkJny47NFz3hPGrIo0Q0g1eh2lNuwfQYmJirN9/tPC9dsB7DOyowKy/WZb+mUd6k20LPQf8khvo2+6gkb3c3CuJi4G+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KIXVnrsETFGJmIOsCj9MigL3Q7tniQDU8xAozlJbFk=;
 b=Pd6U8kq5qfYzn8MROYPrw0yoNaqHQa3WD+oG21d7moR9X9v1StzUE0YX9BzY+VV8cVEG6vxo/n+q6utOIggr4WddrmXRkXEh9+pqCRagRSVl+TrrSDbbSRGztswkgDtcQd/z8Ie6UsjxL1Ax5GkGQ+WIqzj1DLKWLQfWDq8Ija4Y0CrqM6pLOCiHy9Rs5yHPqP6ErElo83MObZYQHsZ0qdXFZfJkK3noIJCXdi0Q3bppr6E3TewWzp2Cd2EUgXFVJhACwl9RYFejAQiZR4CCMLPr/D2aYiuqmNlsmB5C3o4H9obDghYEfm4YsB1X4Zle7g7RHyqCts0jxPn2z/y4Dg==
Received: from DM6PR02CA0136.namprd02.prod.outlook.com (2603:10b6:5:1b4::38)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:21:41 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::a) by DM6PR02CA0136.outlook.office365.com
 (2603:10b6:5:1b4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 17:21:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY5PEPF00000E76.mail.protection.outlook.com (10.167.247.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:21:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:21:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:21:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 10:21:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 5/5] net/mlx5: nodnic: Add health monitoring
Date: Thu, 8 Oct 2026 20:18:20 +0300
Message-ID: <20261008171821.660739-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20261008171821.660739-1-tariqt@nvidia.com>
References: <20261008171821.660739-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 53259123-946c-4054-d154-08df25609dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7BHff2Ch6ClHh7fmMWGkTq6v9fpjr+xp3hUdtVoUUD8cez6lBsPZQGyWxNtiTljDQpBRabrri/XqWMlRkFBOEBxnYV83IDu7QYFcVbMAXT6DNzDD9JeICQwNy59Bq6qgbkHPQUr5NQOJJzT+VcOOqxD0UzNbscE+forBvZFpVvLzgfYwvcEkiyLhjkOpP3MZzuDjaY9MCZxjjsNuMdFG+wJFkv1dLHv2xB7PuPCpZTaEHEpFdaNDlftNxGTw3mUAp4h1ZJZPrCaUQZEGUa3QTOO9cNkJ8oQ99LTQjtlRQ12mgU0NBNe3IPwiV9GxBpgIs944jH5ojI0N4RJHzRdX79MZqiKVBUrPHH7zDnYC1XO/B46reDIwhkBUCJOPa0ltEd34bSUhSoTogCngBvHo+muUHXaozDTkixUuuE9DdTcavQLH8JHYdpfFKtMM4+I1j54eqsxGsfA4iDuRTT01CxYECFAQgalWR9DfsXEcEem6Ef1cyOzk8JOiyGqIuvCPjF6jOtIYLjNpbiGVEURWDWZBfHqv4KalhDE9IvTXl5rqEbWx3pFTtjCP77BNdkASGgLRRXFprOmlroK5LGH0JqrkcQfA2JKgaLcBGo31Ea8JCY9OPKat2v3F4GeEf323gpcmQS3+wpVt/L9m9iMhTjbqVf45YIrFdLeN1kfQaBwpV3yiKiQWTDKywZbY5V0IMHJYoA8D4buY3nMHQZS+7w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d7MLwLWAooZFwIwCQzhcqnM+9drRkB88cDnvf1We9H6Xi1qys7/g2zEmJ9BGsaF+VBsxH0TGLzEgKy9zi55ydUdOmw9oRRkEikLjzbTTtby6d8fFRJpZe1He0Lga0zosCMvk7r8fcrWzwniVnT4m76SuvsbGH8YIZlsfF2aJaOTlcd8KkbzbeuVYPjN5NXCjRkxmFNtI4E4Cd2gDqIzPUe7CbhGImLC9/eKmCRnqX+mTNk7gfGm22hYSeuMyQy05R/B87jetx7usFNBTei/7iEaLzrTiC6u2tiKe7HRBXik1f0rfuorJ9KQ+9Mn8LnD07E7ogH/FVUeuc5PdpLmcysqKDOM+yKeqk44xCiRqj0/klLnwa/Lqcj2AuMFHj7HaNcfdJoGdG1OHF7uFyJPieCyKlkpl9a0uI9pRYSYfmogKqNsMZmy+tWMqTj/LKXiF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:21:40.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53259123-946c-4054-d154-08df25609dcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583

From: Shahar Shitrit <shshitrit@nvidia.com>

Monitor firmware health by periodically polling the health buffer from
the initialization segment.

Detect fatal device conditions, firmware health counter stalls, and
syndrome changes. Report health errors together with their severity
and mark the device as unhealthy on fatal conditions.

Start and stop health polling as part of the device probe and remove
flows.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/nodnic/Makefile    |   2 +-
 .../net/ethernet/mellanox/mlx5/nodnic/en.h    |  12 +
 .../ethernet/mellanox/mlx5/nodnic/health.c    | 315 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/main.c  |   2 +
 4 files changed, 330 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/health.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
index 25865d7244d8..1d09edeaf3af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_MLX5_NODNIC) += mlx5_nodnic.o
 
-mlx5_nodnic-y := main.o en.o en_cfg.o tx.o rx.o nodnic_pci_vsc.o
+mlx5_nodnic-y := main.o en.o en_cfg.o tx.o rx.o nodnic_pci_vsc.o health.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
index d811bfe242ac..90e9f273d454 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
@@ -113,6 +113,16 @@ struct mlx5_nodnic_working_buffer {
 	u32 alloc_size;
 };
 
+struct mlx5_nodnic_health {
+	struct health_buffer __iomem   *health;
+	__be32 __iomem		       *health_counter;
+	struct timer_list		timer;
+	u32				prev_counter;
+	int				miss_counter;
+	u8				synd;
+	u32				fatal_error;
+};
+
 struct mlx5_nodnic_priv {
 	struct mlx5_nodnic_core_dev *core_dev;
 	struct net_device *netdev;
@@ -128,6 +138,8 @@ struct mlx5_nodnic_priv {
 	struct mlx5_nodnic_dbr	dbr; /* one shared dbr for TX and RX */
 	struct mlx5_nodnic_cq	cq;
 	struct mlx5_nodnic_ring	working_buffer;
+
+	struct mlx5_nodnic_health health;
 };
 
 void mlx5_nodnic_build_netdev(struct net_device *netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/health.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/health.c
new file mode 100644
index 000000000000..a981a5195c7e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/health.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/random.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+
+#include "en.h"
+#include "nodnic_ifc.h"
+#include "nodnic.h"
+
+#define MLX5_NODNIC_HEALTH_POLL_INTERVAL_MS 2000
+#define MLX5_NODNIC_MAX_MISSES	3
+
+enum nodnic_rfr_severity_bit_offsets {
+	NODNIC_CRR_BIT_OFFSET = 0x6,
+	NODNIC_RFR_BIT_OFFSET = 0x7,
+};
+
+enum {
+	MLX5_NODNIC_SEVERITY_MASK	= 0x7,
+	MLX5_NODNIC_SEVERITY_VALID_MASK	= 0x8,
+};
+
+enum  {
+	MLX5_NODNIC_SENSOR_NO_ERR,
+	MLX5_NODNIC_SENSOR_PCI_COMM_ERR,
+	MLX5_NODNIC_SENSOR_PCI_ERR,
+	MLX5_NODNIC_SENSOR_NIC_DISABLED,
+	MLX5_NODNIC_SENSOR_NIC_SW_RESET,
+	MLX5_NODNIC_SENSOR_FW_SYND_RFR,
+};
+
+static unsigned long get_next_poll_jiffies(void)
+{
+	return jiffies + msecs_to_jiffies(MLX5_NODNIC_HEALTH_POLL_INTERVAL_MS) +
+	       get_random_u32_below(HZ);
+}
+
+static bool sensor_pci_not_working(struct mlx5_nodnic_health *health)
+{
+	struct health_buffer __iomem *h = health->health;
+
+	return (ioread32be(&h->fw_ver) == 0xffffffff);
+}
+
+static u8 mlx5_nodnic_get_nic_state(struct mlx5_nodnic_core_dev *dev)
+{
+	return (ioread32be(&dev->iseg->cmdq_addr_l_sz) >> 8) & 7;
+}
+
+static int mlx5_nodnic_health_get_rfr(u8 rfr_severity)
+{
+	return rfr_severity >> NODNIC_RFR_BIT_OFFSET;
+}
+
+static bool sensor_fw_synd_rfr(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_health *health = &dev->priv->health;
+	struct health_buffer __iomem *h = health->health;
+	u8 synd = ioread8(&h->synd);
+	u8 rfr;
+
+	rfr = mlx5_nodnic_health_get_rfr(ioread8(&h->rfr_severity));
+
+	if (rfr && synd)
+		mlx5_nodnic_core_dbg(dev, "FW requests reset, synd: %d\n",
+				     synd);
+
+	return rfr && synd;
+}
+
+static
+u32 mlx5_nodnic_health_check_fatal_sensors(struct mlx5_nodnic_core_dev *dev)
+{
+	u32 nic_state;
+
+	if (pci_channel_offline(dev->pdev))
+		return MLX5_NODNIC_SENSOR_PCI_ERR;
+	if (sensor_pci_not_working(&dev->priv->health))
+		return MLX5_NODNIC_SENSOR_PCI_COMM_ERR;
+
+	nic_state = mlx5_nodnic_get_nic_state(dev);
+	if (nic_state == MLX5_NODNIC_ISEG_NIC_INTERFACE_DISABLED)
+		return MLX5_NODNIC_SENSOR_NIC_DISABLED;
+	if (nic_state == MLX5_NODNIC_ISEG_NIC_INTERFACE_SW_RESET)
+		return MLX5_NODNIC_SENSOR_NIC_SW_RESET;
+
+	if (sensor_fw_synd_rfr(dev))
+		return MLX5_NODNIC_SENSOR_FW_SYND_RFR;
+
+	return MLX5_NODNIC_SENSOR_NO_ERR;
+}
+
+static const char *mlx5_nodnic_fatal_error_str(u32 err)
+{
+	switch (err) {
+	case MLX5_NODNIC_SENSOR_PCI_COMM_ERR: return "PCI communication error";
+	case MLX5_NODNIC_SENSOR_PCI_ERR:      return "PCI error";
+	case MLX5_NODNIC_SENSOR_NIC_DISABLED: return "NIC disabled";
+	case MLX5_NODNIC_SENSOR_NIC_SW_RESET: return "NIC SW reset";
+	case MLX5_NODNIC_SENSOR_FW_SYND_RFR:  return "FW synd RFR";
+	default:                       return "unknown";
+	}
+}
+
+static int mlx5_nodnic_health_get_crr(u8 rfr_severity)
+{
+	return (rfr_severity >> NODNIC_CRR_BIT_OFFSET) & 0x01;
+}
+
+static int mlx5_nodnic_health_get_severity(u8 rfr_severity)
+{
+	return rfr_severity & MLX5_NODNIC_SEVERITY_VALID_MASK ?
+	       rfr_severity & MLX5_NODNIC_SEVERITY_MASK : LOGLEVEL_ERR;
+}
+
+/* Syndrome values from health buffer (same as mlx5_ifc.h) */
+static const char *mlx5_nodnic_hsynd_str(u8 synd)
+{
+	switch (synd) {
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_FW_INTERNAL_ERR:
+		return "firmware internal error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_DEAD_IRISC:
+		return "irisc not responding";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_HW_FATAL_ERR:
+		return "unrecoverable hardware error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_FW_CRC_ERR:
+		return "firmware CRC error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ICM_FETCH_PCI_ERR:
+		return "ICM fetch PCI error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ICM_PAGE_ERR:
+		return "HW fatal error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ASYNCHRONOUS_EQ_BUF_OVERRUN:
+		return "async EQ buffer overrun";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_EQ_IN_ERR:
+		return "EQ error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_EQ_INV:
+		return "Invalid EQ referenced";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_FFSER_ERR:
+		return "FFSER error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_HIGH_TEMP_ERR:
+		return "High temperature";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_ICM_PCI_POISONED_ERR:
+		return "ICM fetch PCI data poisoned error";
+	case MLX5_NODNIC_ISEG_HEALTH_SYNDROME_TRUST_LOCKDOWN_ERR:
+		return "Trust lockdown error";
+	default:
+		return "unrecognized error";
+	}
+}
+
+static const char *mlx5_nodnic_loglevel_str(int level)
+{
+	switch (level) {
+	case LOGLEVEL_EMERG:
+		return "EMERGENCY";
+	case LOGLEVEL_ALERT:
+		return "ALERT";
+	case LOGLEVEL_CRIT:
+		return "CRITICAL";
+	case LOGLEVEL_ERR:
+		return "ERROR";
+	case LOGLEVEL_WARNING:
+		return "WARNING";
+	case LOGLEVEL_NOTICE:
+		return "NOTICE";
+	case LOGLEVEL_INFO:
+		return "INFO";
+	case LOGLEVEL_DEBUG:
+		return "DEBUG";
+	}
+	return "Unknown log level";
+}
+
+static const char *mlx5_nodnic_severity_to_kern(int severity)
+{
+	if (severity <= LOGLEVEL_ERR)
+		return KERN_ERR;
+
+	if (severity <= LOGLEVEL_WARNING)
+		return KERN_WARNING;
+
+	return KERN_INFO;
+}
+
+static void mlx5_nodnic_print_health_info(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_health *health = &dev->priv->health;
+	struct health_buffer __iomem *h = health->health;
+	struct device *device = dev->device;
+	u8 synd = ioread8(&h->synd);
+	const char *kern_severity;
+	u8 rfr_severity;
+	int severity;
+	int i;
+
+	if (!synd)
+		return;
+
+	if (sensor_pci_not_working(&dev->priv->health)) {
+		mlx5_nodnic_core_err(dev, "PCI slot is unavailable\n");
+		return;
+	}
+
+	rfr_severity = ioread8(&h->rfr_severity);
+	severity = mlx5_nodnic_health_get_severity(rfr_severity);
+	kern_severity = mlx5_nodnic_severity_to_kern(severity);
+
+	dev_printk(kern_severity, device,
+		   "Health issue observed, %s, severity(%d) %s:\n",
+		   mlx5_nodnic_hsynd_str(synd), severity,
+		   mlx5_nodnic_loglevel_str(severity));
+
+	for (i = 0; i < ARRAY_SIZE(h->assert_var); i++)
+		dev_printk(kern_severity, device, "assert_var[%d] 0x%08x\n", i,
+			   ioread32be(h->assert_var + i));
+
+	dev_printk(kern_severity, device, "assert_exit_ptr 0x%08x\n",
+		   ioread32be(&h->assert_exit_ptr));
+	dev_printk(kern_severity, device, "assert_callra 0x%08x\n",
+		   ioread32be(&h->assert_callra));
+	dev_printk(kern_severity, device, "raw fw_ver 0x%08x\n",
+		   ioread32be(&h->fw_ver));
+	dev_printk(kern_severity, device, "time %u\n", ioread32be(&h->time));
+	dev_printk(kern_severity, device, "hw_id 0x%08x\n",
+		   ioread32be(&h->hw_id));
+	dev_printk(kern_severity, device, "rfr %d\n",
+		   mlx5_nodnic_health_get_rfr(rfr_severity));
+	dev_printk(kern_severity, device, "crr %d\n",
+		   mlx5_nodnic_health_get_crr(rfr_severity));
+	dev_printk(kern_severity, device, "severity %d (%s)\n", severity,
+		   mlx5_nodnic_loglevel_str(severity));
+	dev_printk(kern_severity, device, "irisc_index %d\n",
+		   ioread8(&h->irisc_index));
+	dev_printk(kern_severity, device, "synd 0x%x: %s\n", synd,
+		   mlx5_nodnic_hsynd_str(synd));
+	dev_printk(kern_severity, device, "ext_synd 0x%04x\n",
+		   ioread16be(&h->ext_synd));
+
+	if (mlx5_nodnic_health_get_crr(rfr_severity))
+		mlx5_nodnic_core_warn(dev, "Cold reset is required\n");
+}
+
+static void mlx5_nodnic_poll_health(struct timer_list *t)
+{
+	struct mlx5_nodnic_priv *priv = timer_container_of(priv, t,
+							   health.timer);
+	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
+	struct mlx5_nodnic_health *health = &priv->health;
+	struct health_buffer __iomem *h = health->health;
+	u32 fatal_error, count;
+	u8 prev_synd;
+
+	if (dev->state == NODNIC_DEVICE_STATE_INTERNAL_ERROR)
+		return;
+
+	fatal_error = mlx5_nodnic_health_check_fatal_sensors(dev);
+
+	if (fatal_error && !health->fatal_error) {
+		mlx5_nodnic_core_err(dev, "fatal error detected: %s (%u)\n",
+				     mlx5_nodnic_fatal_error_str(fatal_error),
+				     fatal_error);
+		priv->health.fatal_error = fatal_error;
+		dev->state = NODNIC_DEVICE_STATE_INTERNAL_ERROR;
+		mlx5_nodnic_print_health_info(dev);
+		return;
+	}
+
+	count = ioread32be(health->health_counter);
+	if (count == health->prev_counter)
+		++health->miss_counter;
+	else
+		health->miss_counter = 0;
+
+	health->prev_counter = count;
+	if (health->miss_counter == MLX5_NODNIC_MAX_MISSES) {
+		mlx5_nodnic_core_err(dev,
+				     "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
+		mlx5_nodnic_print_health_info(dev);
+	}
+
+	prev_synd = health->synd;
+	health->synd = ioread8(&h->synd);
+	if (health->synd && health->synd != prev_synd)
+		mlx5_nodnic_print_health_info(dev);
+
+	mod_timer(&health->timer, get_next_poll_jiffies());
+}
+
+void mlx5_nodnic_start_health_poll(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_health *health = &dev->priv->health;
+
+	timer_setup(&health->timer, mlx5_nodnic_poll_health, 0);
+	health->fatal_error = MLX5_NODNIC_SENSOR_NO_ERR;
+	health->miss_counter = 0;
+	health->prev_counter = 0;
+	health->synd = 0;
+	health->health = &dev->iseg->health;
+	health->health_counter = &dev->iseg->health_counter;
+
+	health->timer.expires = jiffies +
+			msecs_to_jiffies(MLX5_NODNIC_HEALTH_POLL_INTERVAL_MS);
+	add_timer(&health->timer);
+}
+
+void mlx5_nodnic_stop_health_poll(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_health *health = &dev->priv->health;
+
+	timer_delete_sync(&health->timer);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
index a533232bf6ef..7194f7438527 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
@@ -804,6 +804,7 @@ static int mlx5_nodnic_probe_one(struct pci_dev *pdev,
 	dev->netdev_registered = true;
 
 	dev->state = NODNIC_DEVICE_STATE_UP;
+	mlx5_nodnic_start_health_poll(dev);
 
 	pci_save_state(pdev);
 
@@ -829,6 +830,7 @@ static void mlx5_nodnic_remove_one(struct pci_dev *pdev)
 	if (!dev)
 		return;
 
+	mlx5_nodnic_stop_health_poll(dev);
 	mlx5_nodnic_event_irq_cleanup(dev);
 	mlx5_nodnic_cleanup_netdev(dev);
 	mlx5_nodnic_dev_cleanup(dev);
-- 
2.44.0

