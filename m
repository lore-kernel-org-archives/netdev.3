Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E44E235A;
	Wed, 30 Sep 2026 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773132; cv=fail; b=fb7d4GfNYwcutPZ35tMmPNWG9nsr+H/6VjfXw098L5gpncYZFqCfT3hDXO38d00mLt8dExbpM9S86oclqYASwbBt240Z1eEImIm9bejz3+8iu7Ah6VbyGzbIHUXSfJlyIz16vYLg7UksxKZzzVRnsOvqYVVTnUjacqHGvX2Dn0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773132; c=relaxed/simple;
	bh=U/+oKdKXcY2O6OJ6DRy17gEayygAhkEpU0eO4HKdA5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umZx/uMao+6byH9WWjxFLQR0+y4ru3E+Z4s2OWbPTctSo4YpQDfeZmjTRzjm2XQBBQ+LqSADLm/jFoRf1D6iePvJh1ZvMm87izjo/rohjNjn7plr1SCraJTZRpFSyWxzp1L8cfrIlCZ5Xm52ZJmhdlBdkPDIvcI7wT9/4OBOKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlB6kQcL; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlB6kQcL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmEmumhUEtShvp3+MVSLoJb60NnUlBEp1on9SPd/4+HwdrmNIIsdRXILCrhKFGSILNqdw4oXayV0QMMS9KQ994DcVIR0iU9azE83Bp90ylv9V38yzw38zdj4rN2fAsaREdlzUbtxPxX888L8iZhcGMxsK2VDh3+GS+j+AVO1ZY8T/YB/IEtWHS9GvmDo2V+dyuygKoB8MpRjorKdFSbGdilotPHs3bJ+8D9RKyMVfJAoKApn4umOjBLXjRovR5xdlVvRdtwPUFcNITcjzRov7SVlt7Qb+wA6N2V3Bua+x7yu5FEhch0XwBPG9prYkwodaFm6J4X3tys27MJuJgyS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHf2Zwcv7L19Lo10iiA7lt3P+uWZyw77XamLVKpwdNM=;
 b=hzPTy3LOC/7Otd64QJV0hVk9ojFDpmSw4Xkrfbww2s+HPlI25rJPrjrsSFNYLeNF5OUc8NSbPNmtit/u0C5XTZV2xLs3rcTs7yIkzJ/DkwLh0Sv62Kqw9aAHlNoXtFSsyDLKMuKceNH63tUjSFTshyZvvZvH2Y5+ISLdQmbJbO07wtq/9ufWrrS7lQmtgfsq7EfPFEJay7Jw/U24RrgmBSQDIHaTrw8f0qiAVaogQKB32tOWOKmrSyVBJwdu81sK9MLv+EgG6Af4p/IWL97jALNYJlku7bPpx6aVjpWfgyixa+PjMCgRkir6RJqg81xDWby/Yq3V4YN1+M2G8/bLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHf2Zwcv7L19Lo10iiA7lt3P+uWZyw77XamLVKpwdNM=;
 b=rlB6kQcLNlMBKrSuWBNRyE6I3c/uMTy3wb0PY4PbOTBnpV3DLfzXjrvtI9AzGydYlz++WoU9hT+Db8JPUbpIB55m1Z5VVWaRpFujSh+OIeg1RVT+4VUAQcbhEp2yDbYoaJkyxIUa9q6w4JhSqhxLvOQ+p7E6dBZDZhR0vzXEPidMBAHhZ7FGBOVflJZF3y6dXcifJTW+06T794rEfbdXMhEGXyDlJnGNfyDqmLnL7v5MiXjpeqwqAoOiX1jnG3+X4figMzoxmMUpQL1/ov5W52bQ5sCKMMQOvInlOCzHZW62lsCGJ2jN/IUSSDi3uCi78Q5j9zHddlLbujEczw4WUQ==
Received: from BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::12)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 12:58:25 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::41) by BN9P223CA0007.outlook.office365.com
 (2603:10b6:408:10b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 12:58:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Wed, 30 Sep 2026 12:58:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 05:58:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 05:58:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 05:58:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5: nodnic: Implement data path
Date: Wed, 30 Sep 2026 15:57:05 +0300
Message-ID: <20260930125708.144767-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 9065263f-42a9-45d8-396b-08df1ef283d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|3023799007|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zoWmKYFu7X2x9Za/bvJVof9FnGfJUlZ+8psJUFkp9LSMfL54gKlBTEClaE0KUSb4JOBTtfKLYPd5xNkLDtV9ZWox+U/vNWfuvwnHcxCA/kmpTzTC7zCxbWH+QyVbLTEMzo85G1zaqelBAlXgbjw/+aKLbQO8MUINT5MiDmDP1uzP9n+FjivlK57D/MbD8OxJJ23+mY0da+l8b5sNIes+Ytwp6mS99Z1yiPHyu0tLb1k1OjEQfLvHB0Yzkrim4/j/Fj+J5n/B6ds2sHbiM1b/ca3q2kuToegLU5v0vT/SM1Mmwv3fn/36vE6w7g8VeYrYYU0ldAaLblvA8FWYfEvahISPJhMmrMee0fBePnBVRNQvYxtFdLcVyDlnQfnZOvLAUqh1sv5PSBCjBTRigrwEVpRPJwI85lmtPgqBtISEaA0PmGACjznwrMpq9kbchnpG1JdEArVnpYaJTrwUrbrJd49Pz6+iSJkZMXHViyXW9HnBzF3KmWvh+PqdxiHkq/4nIkISUrbCH7rI6lyWIbwwAIFUJiLDH348lbEX1JJu+6zYlqRxn1IUQH+8BNo/IjGEeUUuGAxSi8d34eQA8HivG7nRqG4eRs2yiZoYqdlQ+kV1m5s81BfgLLLFziBpdFrHRu+gvPITXzzNri8T1AcMAtYqW8G88GTGiHVQ7ULS1BqLb/SeFvYqXFjnZsdUF009qkMWRNN2YiAZT+HNPTCd0w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(3023799007)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TIsui9ip3SoWLno6yrrvTyqCREsOfil2c5r4k1EEGjQumqr+j2tsLY9yPG4yQgRIgKCLXPt6reobp21CfXcu5TNkbfDZ9d11dwxdEYFXf3v86z3WCnnfBYY4aRnFuFw99uuzwmdoqsgVKJv9UDBTm8M2ofIzJnNjpEJdlBKf92Bsoi/8Gxl4vWvl5IInGPqNIlq2+H2CmYiiPfZjv6JcZMmMaXpJGGRjuiIfs7V4159qRh88dZAnw6pYLIlmdncFPp/R+jhjzJD3ZkHaeQkM0DrEyPTpfeuSaFziuKc+qLDeuVZTlT0cGzXtvSFZDyayN8/o9bThu01clLOKZygAjfMwfN9VTe4B+E+BuLLOA+YFeFvFApAtGg/cIPCCXFIg4uilbkvz3U2bqheevNrqVmG2wKvsmhTw17T7s12u516u//9Q51+MIxO4f4WfelGk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:58:25.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9065263f-42a9-45d8-396b-08df1ef283d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

From: Shahar Shitrit <shshitrit@nvidia.com>

Implement the TX and RX data paths for the mlx5_nodnic driver.
Add TX handling to build and post WQEs, DMA-map packets, ring the
BlueFlame doorbell, and process send completions. Handle SQ exhaustion
by stopping and waking the TX queue as needed.

Add page pool backed RX handling to allocate and post receive buffers,
process receive completions, build SKBs, and deliver packets through
NAPI/GRO.

Implement NAPI polling and CQE dispatch for TX and RX completions,
including RX WQE reposting and CQ re-arming.
Wire up ndo_start_xmit and ndo_features_check, and enable TX/RX
checksum offload support.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/nodnic/Makefile    |   2 +-
 .../net/ethernet/mellanox/mlx5/nodnic/en.c    | 263 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/en.h    |  35 +++
 .../ethernet/mellanox/mlx5/nodnic/en_cfg.c    | 220 +++++++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/rx.c    | 169 +++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/rx.h    |  25 ++
 .../net/ethernet/mellanox/mlx5/nodnic/tx.c    | 226 +++++++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/tx.h    |  61 ++++
 8 files changed, 1000 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/en.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/rx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/nodnic/tx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
index 4955f0427c79..25865d7244d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_MLX5_NODNIC) += mlx5_nodnic.o
 
-mlx5_nodnic-y := main.o en_cfg.o nodnic_pci_vsc.o
+mlx5_nodnic-y := main.o en.o en_cfg.o tx.o rx.o nodnic_pci_vsc.o
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.c
new file mode 100644
index 000000000000..3572aff50194
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/interrupt.h>
+#include <linux/mlx5/cq.h>
+
+#include "en.h"
+#include "nodnic.h"
+#include "rx.h"
+#include "tx.h"
+
+#define MLX5_NODNIC_TX_CQ_POLL_BUDGET        128
+
+enum mlx5_nodnic_cqe_result {
+	MLX5_NODNIC_CQE_TX,
+	MLX5_NODNIC_CQE_RX,
+	MLX5_NODNIC_CQE_IGNORED,
+};
+
+static const char *mlx5_nodnic_cqe_err_syndrome_str(u8 syndrome)
+{
+	switch (syndrome) {
+	case MLX5_CQE_SYNDROME_LOCAL_LENGTH_ERR:
+		return "LOCAL_LENGTH_ERR";
+	case MLX5_CQE_SYNDROME_LOCAL_QP_OP_ERR:
+		return "LOCAL_QP_OP_ERR";
+	case MLX5_CQE_SYNDROME_LOCAL_PROT_ERR:
+		return "LOCAL_PROT_ERR";
+	case MLX5_CQE_SYNDROME_WR_FLUSH_ERR:
+		return "WR_FLUSH_ERR";
+	case MLX5_CQE_SYNDROME_MW_BIND_ERR:
+		return "MW_BIND_ERR";
+	case MLX5_CQE_SYNDROME_BAD_RESP_ERR:
+		return "BAD_RESP_ERR";
+	case MLX5_CQE_SYNDROME_LOCAL_ACCESS_ERR:
+		return "LOCAL_ACCESS_ERR";
+	case MLX5_CQE_SYNDROME_REMOTE_INVAL_REQ_ERR:
+		return "REMOTE_INVAL_REQ_ERR";
+	case MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR:
+		return "REMOTE_ACCESS_ERR";
+	case MLX5_CQE_SYNDROME_REMOTE_OP_ERR:
+		return "REMOTE_OP_ERR";
+	case MLX5_CQE_SYNDROME_TRANSPORT_RETRY_EXC_ERR:
+		return "TRANSPORT_RETRY_EXC_ERR";
+	case MLX5_CQE_SYNDROME_RNR_RETRY_EXC_ERR:
+		return "RNR_RETRY_EXC_ERR";
+	case MLX5_CQE_SYNDROME_REMOTE_ABORTED_ERR:
+		return "REMOTE_ABORTED_ERR";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static void mlx5_nodnic_handle_err_cqe(struct mlx5_nodnic_cq *cq,
+				       struct mlx5_cqe64 *cqe64,
+				       int napi_budget)
+{
+	struct mlx5_nodnic_priv *priv = container_of(cq,
+						     struct mlx5_nodnic_priv,
+						     cq);
+	struct mlx5_err_cqe *err_cqe = (struct mlx5_err_cqe *)cqe64;
+	u8 vendor_syndrome, syndrome;
+	const char *queue_type;
+	u16 wqe_counter;
+	u8 opcode;
+
+	opcode = err_cqe->op_own >> 4;
+	syndrome = err_cqe->syndrome;
+	vendor_syndrome = err_cqe->vendor_err_synd;
+	wqe_counter = be16_to_cpu(err_cqe->wqe_counter);
+
+	queue_type = (opcode == OPCODE_CQ_SEND_ERR) ? "SQ" : "RQ";
+
+	netdev_err(priv->netdev,
+		   "%s CQE error: syndrome=0x%02x (%s), vendor_syndrome=0x%02x, wqe_counter=%u, cq_ci=%d\n",
+		   queue_type,
+		   syndrome, mlx5_nodnic_cqe_err_syndrome_str(syndrome),
+		   vendor_syndrome, wqe_counter, cq->cc);
+
+	print_hex_dump(KERN_ERR, "mlx5_nodnic err CQE: ", DUMP_PREFIX_OFFSET,
+		       16, 1, err_cqe, sizeof(*err_cqe), false);
+
+	if (opcode == OPCODE_CQ_SEND_ERR) {
+		struct mlx5_nodnic_sq *sq = &priv->sq;
+		u16 sq_pi = mlx5_nodnic_sq_get_pi(sq, wqe_counter);
+
+		mlx5_nodnic_complete_send_wqe(sq, &sq->wqe_info[sq_pi],
+					      napi_budget);
+	} else {
+		struct mlx5_nodnic_rq *rq = &priv->rq;
+		u16 ci = wqe_counter & (rq->ring.num_entries - 1);
+
+		mlx5_nodnic_release_rx_wqe(rq, ci);
+	}
+}
+
+static u32 mlx5_nodnic_cq_get_ci(struct mlx5_nodnic_cq *cq)
+{
+	return cq->cc & (cq->num_entries - 1);
+}
+
+static u8 mlx5_nodnic_cq_get_sw_ownership_val(struct mlx5_nodnic_cq *cq)
+{
+	return (cq->cc >> cq->log_num_entries) & 1;
+}
+
+static struct mlx5_cqe64 *mlx5_nodnic_cq_get_cqe(struct mlx5_nodnic_cq *cq)
+{
+	u8 cqe_ownership_bit, sw_ownership_val;
+	struct mlx5_cqe64 *cqe;
+	u32 ci;
+
+	ci = mlx5_nodnic_cq_get_ci(cq);
+	cqe = (struct mlx5_cqe64 *)cq->ring.wq + ci;
+
+	cqe_ownership_bit = cqe->op_own & MLX5_NODNIC_CQE_OWNER_MASK;
+	sw_ownership_val = mlx5_nodnic_cq_get_sw_ownership_val(cq);
+	if (cqe_ownership_bit != sw_ownership_val)
+		return NULL;
+
+	/* ensure cqe content is read after cqe ownership bit */
+	dma_rmb();
+
+	return cqe;
+}
+
+static u8 mlx5_nodnic_cq_get_opcode(struct mlx5_cqe64 *cqe)
+{
+	return cqe->op_own >> 4;
+}
+
+static enum mlx5_nodnic_cqe_result
+mlx5_nodnic_handle_cqe(struct mlx5_nodnic_cq *cq, struct mlx5_cqe64 *cqe,
+		       int budget)
+{
+	struct net_device *netdev =
+		container_of(cq, struct mlx5_nodnic_priv, cq)->netdev;
+	u8 opcode = mlx5_nodnic_cq_get_opcode(cqe);
+	enum mlx5_nodnic_cqe_result result;
+
+	switch (opcode) {
+	case OPCODE_CQ_SEND:
+		mlx5_nodnic_handle_send_cqe(cq, cqe, budget);
+		result = MLX5_NODNIC_CQE_TX;
+		break;
+
+	case OPCODE_CQ_RECV:
+		mlx5_nodnic_handle_recv_cqe(cq, cqe);
+		result = MLX5_NODNIC_CQE_RX;
+		break;
+
+	case OPCODE_CQ_SEND_ERR:
+		mlx5_nodnic_handle_err_cqe(cq, cqe, budget);
+		result = MLX5_NODNIC_CQE_TX;
+		break;
+
+	case OPCODE_CQ_RECV_ERR:
+		mlx5_nodnic_handle_err_cqe(cq, cqe, budget);
+		result = MLX5_NODNIC_CQE_RX;
+		break;
+
+	case OPCODE_CQ_INVALID:
+		/* Invalid/stale CQE - silently consume it.
+		 * This can occur after device restart when stale CQEs
+		 * from the previous session are still in the hardware CQ.
+		 */
+		result = MLX5_NODNIC_CQE_IGNORED;
+		break;
+
+	default:
+		netdev_err(netdev,
+			   "unexpected CQE opcode 0x%02x at cq_ci=%d\n",
+			   opcode, cq->cc);
+		result = MLX5_NODNIC_CQE_IGNORED;
+		break;
+	}
+
+	cq->cc++;
+	return result;
+}
+
+void mlx5_nodnic_arm_cq(struct mlx5_nodnic_cq *cq)
+{
+	struct mlx5_nodnic_core_dev *dev =
+		container_of(cq, struct mlx5_nodnic_priv, cq)->core_dev;
+	__be32 doorbell[2];
+	u32 sn, ci, val;
+
+	sn = cq->arm_sn & 3;
+	ci = cq->cc & 0xffffff;
+	val = sn << 28 | MLX5_CQ_DB_REQ_NOT | ci;
+
+	cq->dbr.db[0] = cpu_to_be32(ci);
+	/* arm_db is the second dword of the CQ doorbell record */
+	cq->dbr.db[1] = cpu_to_be32(val);
+
+	/* Make sure that the doorbell record in host memory is
+	 * written before ringing the doorbell via PCI MMIO.
+	 */
+	wmb();
+
+	doorbell[0] = cpu_to_be32(val);
+	doorbell[1] = cpu_to_be32(cq->cqn);
+
+	mlx5_write64(doorbell, dev->uar_base + MLX5_CQ_DOORBELL);
+}
+
+int mlx5_nodnic_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct mlx5_nodnic_cq *cq = container_of(napi,
+						 struct mlx5_nodnic_cq, napi);
+	struct mlx5_nodnic_priv *priv = container_of(cq,
+						     struct mlx5_nodnic_priv,
+						     cq);
+	int tx_work_done = 0, rx_work_done = 0;
+	enum mlx5_nodnic_cqe_result result;
+	struct mlx5_cqe64 *cqe;
+
+	while (true) {
+		cqe = mlx5_nodnic_cq_get_cqe(cq);
+		if (!cqe)
+			break;
+
+		result = mlx5_nodnic_handle_cqe(cq, cqe, budget);
+		switch (result) {
+		case MLX5_NODNIC_CQE_TX:
+			if (++tx_work_done >= MLX5_NODNIC_TX_CQ_POLL_BUDGET)
+				goto poll_done;
+			break;
+		case MLX5_NODNIC_CQE_RX:
+			if (++rx_work_done >= budget)
+				goto poll_done;
+			break;
+		case MLX5_NODNIC_CQE_IGNORED:
+			break;
+		}
+	}
+
+poll_done:
+	if (!mlx5_nodnic_rq_post_wqes(priv))
+		return budget;
+
+	if (rx_work_done >= budget)
+		return budget;
+
+	if (napi_complete_done(napi, rx_work_done))
+		mlx5_nodnic_arm_cq(cq);
+
+	return rx_work_done;
+}
+
+netdev_features_t
+mlx5_nodnic_check_features(struct sk_buff *skb, struct net_device *netdev,
+			   netdev_features_t features)
+{
+	features = vlan_features_check(skb, features);
+
+	/* Validate if the tunneled packet is being offloaded by HW */
+	if (skb->encapsulation && (features & NETIF_F_CSUM_MASK))
+		return features & ~NETIF_F_CSUM_MASK;
+
+	return features;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
index 90dc57695e1b..19858e9da064 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
@@ -4,10 +4,12 @@
 #ifndef __MLX5_NODNIC_EN_H__
 #define __MLX5_NODNIC_EN_H__
 
+#include <net/page_pool/helpers.h>
 #include <linux/if_vlan.h>
 #include <linux/mlx5/device.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/skbuff.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 
@@ -16,16 +18,32 @@
 #define MLX5_NODNIC_SQ_WQEBB_B		64
 #define MLX5_NODNIC_RQ_STRIDE_BYTES	16
 
+#define MLX5_NODNIC_ETH_HARD_MTU    (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
+#define MLX5_NODNIC_HW_MTU          (ETH_DATA_LEN + MLX5_NODNIC_ETH_HARD_MTU)
+#define MLX5_NODNIC_SKB_HEADROOM_BYTES  NET_SKB_PAD
+
 enum {
 	MLX5_NODNIC_STATE_OPENED,
 };
 
+enum {
+	MLX5_NODNIC_CQE_OWNER_MASK = 1,
+};
+
 enum {
 	MLX5_NODNIC_RCV_DBR,
 	MLX5_NODNIC_SND_DBR,
 	MLX5_NODNIC_DBR_WORDS,
 };
 
+enum mlx5_nodnic_cqe_opcode {
+	OPCODE_CQ_SEND,
+	OPCODE_CQ_RECV     = 0x2,
+	OPCODE_CQ_SEND_ERR = 0xD,
+	OPCODE_CQ_RECV_ERR,
+	OPCODE_CQ_INVALID,
+};
+
 struct mlx5_nodnic_ring {
 	void *wq;
 	dma_addr_t dma_handle;
@@ -35,17 +53,24 @@ struct mlx5_nodnic_ring {
 	u32 lkey;
 };
 
+struct mlx5_nodnic_tx_wqe_info;
+
 struct mlx5_nodnic_sq {
 	struct device		*device;
 	struct net_device	*netdev;
+	struct netdev_queue	*txq;
 	struct mlx5_nodnic_ring ring;
 
+	struct mlx5_nodnic_tx_wqe_info  *wqe_info;
+
 	u16 pc;
 	u16 cc;
 };
 
 struct mlx5_nodnic_rq {
+	struct page_pool	*page_pool;
 	struct mlx5_nodnic_ring ring;
+	struct page		**pages;
 	u16 pc;
 	u16 cc;
 };
@@ -62,9 +87,13 @@ struct mlx5_nodnic_cq {
 	int			num_entries;
 	int			log_num_entries;
 
+	int			irqn;
 	struct mlx5_nodnic_dbr	dbr;
+	unsigned int		arm_sn;
 
 	int cc;
+
+	struct napi_struct	napi;
 };
 
 /* for FW use only */
@@ -94,4 +123,10 @@ void mlx5_nodnic_cleanup_netdev(struct mlx5_nodnic_core_dev *dev);
 int mlx5_nodnic_open(struct net_device *netdev);
 int mlx5_nodnic_close(struct net_device *netdev);
 
+void mlx5_nodnic_arm_cq(struct mlx5_nodnic_cq *cq);
+int mlx5_nodnic_napi_poll(struct napi_struct *napi, int budget);
+netdev_features_t mlx5_nodnic_check_features(struct sk_buff *skb,
+					     struct net_device *netdev,
+					     netdev_features_t features);
+
 #endif /* __MLX5_NODNIC_EN_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
index 75dbd2071110..d73e2ec1662b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
@@ -15,6 +15,8 @@
 #include "nodnic_ifc.h"
 #include "nodnic.h"
 #include "nodnic_pci_vsc.h"
+#include "rx.h"
+#include "tx.h"
 
 #define MLX5_NODNIC_CQ_INIT_CMD_SN cpu_to_be32(2 << 28)
 
@@ -347,6 +349,46 @@ static int mlx5_nodnic_read_cq_n(struct mlx5_nodnic_core_dev *dev)
 	return 0;
 }
 
+static irqreturn_t mlx5_nodnic_cq_irq_handler(int irq, void *data)
+{
+	struct mlx5_nodnic_cq *cq = data;
+
+	cq->arm_sn++;
+	napi_schedule_irqoff(&cq->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int mlx5_nodnic_setup_data_irq(struct mlx5_nodnic_cq *cq)
+{
+	struct mlx5_nodnic_priv *priv = container_of(cq,
+						     struct mlx5_nodnic_priv,
+						     cq);
+	struct net_device *netdev = priv->netdev;
+	int irqn, err;
+
+	irqn = pci_irq_vector(priv->core_dev->pdev, MLX5_NODNIC_DATA_MSIX);
+	if (irqn < 0) {
+		netdev_err(netdev, "pci_irq_vector failed: %d\n", irqn);
+		return irqn;
+	}
+
+	err = request_irq(irqn, mlx5_nodnic_cq_irq_handler, 0,
+			  "mlx5_nodnic-cq", cq);
+	if (err) {
+		netdev_err(netdev, "request_irq failed\n");
+		return err;
+	}
+	cq->irqn = irqn;
+
+	return 0;
+}
+
+static void mlx5_nodnic_cleanup_data_irq(struct mlx5_nodnic_cq *cq)
+{
+	free_irq(cq->irqn, cq);
+}
+
 int mlx5_nodnic_init_working_buffer(struct mlx5_nodnic_core_dev *dev)
 {
 	struct mlx5_nodnic_ring *work_buf = &dev->priv->working_buffer;
@@ -377,6 +419,7 @@ int mlx5_nodnic_open_cq(struct mlx5_nodnic_core_dev *dev)
 	int err;
 
 	cq->cc = 0;
+	cq->arm_sn = 0;
 
 	err = mlx5_nodnic_init_cq_ring(dev);
 	if (err)
@@ -390,8 +433,19 @@ int mlx5_nodnic_open_cq(struct mlx5_nodnic_core_dev *dev)
 	if (err)
 		goto err_cleanup_dbr;
 
+	netif_napi_add_config_locked(dev->priv->netdev, &cq->napi,
+				     mlx5_nodnic_napi_poll, 0);
+
+	err = mlx5_nodnic_setup_data_irq(cq);
+	if (err)
+		goto err_napi_del;
+
+	netif_napi_set_irq_locked(&cq->napi, cq->irqn);
+
 	return 0;
 
+err_napi_del:
+	netif_napi_del_locked(&cq->napi);
 err_cleanup_dbr:
 	mlx5_nodnic_cleanup_cq_dbr(dev);
 err_cleanup_ring:
@@ -404,6 +458,8 @@ static void mlx5_nodnic_close_cq(struct mlx5_nodnic_cq *cq)
 	struct mlx5_nodnic_core_dev *dev =
 		container_of(cq, struct mlx5_nodnic_priv, cq)->core_dev;
 
+	mlx5_nodnic_cleanup_data_irq(cq);
+	netif_napi_del_locked(&cq->napi);
 	mlx5_nodnic_cleanup_cq_dbr(dev);
 	mlx5_nodnic_cleanup_cq_ring(dev);
 }
@@ -428,14 +484,28 @@ int mlx5_nodnic_open_sq(struct mlx5_nodnic_core_dev *dev)
 
 	ring->lkey = dev->lkey;
 
+	sq->wqe_info = kvcalloc(ring->num_entries,
+				sizeof(struct mlx5_nodnic_tx_wqe_info),
+				GFP_KERNEL);
+	if (!sq->wqe_info) {
+		err = -ENOMEM;
+		goto err_free_ring;
+	}
+
 	return 0;
+
+err_free_ring:
+	mlx5_nodnic_free_ring(dev, ring);
+	return err;
 }
 
 static void mlx5_nodnic_close_sq(struct mlx5_nodnic_core_dev *dev)
 {
 	struct mlx5_nodnic_sq *sq = &dev->priv->sq;
 
+	mlx5_nodnic_sq_free_pending(sq);
 	mlx5_nodnic_free_ring(dev, &sq->ring);
+	kvfree(sq->wqe_info);
 }
 
 int mlx5_nodnic_open_rq(struct mlx5_nodnic_core_dev *dev)
@@ -573,6 +643,143 @@ void mlx5_nodnic_refresh_carrier(struct mlx5_nodnic_priv *priv)
 	mutex_unlock(&priv->state_lock);
 }
 
+static int mlx5_nodnic_activate_rq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_priv *priv = dev->priv;
+	struct net_device *netdev = priv->netdev;
+	struct mlx5_nodnic_rq *rq = &priv->rq;
+	struct page_pool_params pp_params = {
+		.flags    = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order    = 0,
+		.pool_size = rq->ring.num_entries,
+		.nid      = dev_to_node(dev->device),
+		.dev      = dev->device,
+		.napi     = &priv->cq.napi,
+		.netdev   = netdev,
+		.dma_dir  = DMA_FROM_DEVICE,
+		.offset   = MLX5_NODNIC_SKB_HEADROOM_BYTES,
+		.max_len  = MLX5_NODNIC_HW_MTU,
+	};
+	int err;
+
+	rq->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(rq->page_pool)) {
+		err = PTR_ERR(rq->page_pool);
+		return err;
+	}
+
+	err = mlx5_nodnic_rq_alloc_pages(rq);
+	if (err) {
+		netdev_err(netdev, "failed to alloc RX pages, err=%d\n", err);
+		goto err_destroy_page_pool;
+	}
+
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &priv->cq.napi);
+
+	return 0;
+
+err_destroy_page_pool:
+	page_pool_destroy(rq->page_pool);
+
+	return err;
+}
+
+static void mlx5_nodnic_deactivate_rq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct net_device *netdev = dev->priv->netdev;
+	struct mlx5_nodnic_rq *rq = &dev->priv->rq;
+
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+
+	mlx5_nodnic_rq_free_pages(rq);
+	page_pool_destroy(rq->page_pool);
+}
+
+static void mlx5_nodnic_tx_disable_queue(struct netdev_queue *txq)
+{
+	__netif_tx_lock_bh(txq);
+	netif_tx_stop_queue(txq);
+	__netif_tx_unlock_bh(txq);
+}
+
+static void mlx5_nodnic_activate_sq(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_priv *priv = dev->priv;
+	struct mlx5_nodnic_sq *sq = &priv->sq;
+
+	sq->txq = netdev_get_tx_queue(priv->netdev, 0);
+	netdev_tx_reset_queue(sq->txq);
+	netif_tx_start_queue(sq->txq);
+	netif_queue_set_napi(sq->netdev, 0, NETDEV_QUEUE_TYPE_TX,
+			     &priv->cq.napi);
+}
+
+static void mlx5_nodnic_deactivate_sq(struct mlx5_nodnic_sq *sq)
+{
+	netif_queue_set_napi(sq->netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
+	mlx5_nodnic_tx_disable_queue(sq->txq);
+}
+
+static void mlx5_nodnic_init_cqes_ownership(struct mlx5_nodnic_cq *cq)
+{
+	struct mlx5_cqe64 *cqe;
+
+	for (int i = 0; i < cq->num_entries; i++) {
+		cqe = (struct mlx5_cqe64 *)
+		      ((u8 *)cq->ring.wq + i * MLX5_NODNIC_CQE_SIZE_B);
+		cqe->op_own = 0xf1;
+	}
+}
+
+static int mlx5_nodnic_activate_queues(struct mlx5_nodnic_core_dev *dev)
+{
+	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
+	int err;
+
+	napi_enable_locked(&cq->napi);
+
+	mlx5_nodnic_init_cqes_ownership(cq);
+
+	err = mlx5_nodnic_activate_rq(dev);
+	if (err)
+		goto err_napi;
+
+	err = mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx);
+	if (err)
+		goto err_rq;
+
+	err = mlx5_nodnic_enable_port(dev);
+	mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
+	if (err)
+		goto err_rq;
+
+	mlx5_nodnic_arm_cq(cq);
+	napi_schedule(&cq->napi);
+
+	mlx5_nodnic_activate_sq(dev);
+
+	return 0;
+
+err_rq:
+	mlx5_nodnic_deactivate_rq(dev);
+err_napi:
+	napi_disable_locked(&cq->napi);
+
+	return err;
+}
+
+static void mlx5_nodnic_deactivate_queues(struct mlx5_nodnic_core_dev *dev)
+{
+	if (!mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx)) {
+		mlx5_nodnic_disable_port(dev);
+		mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
+	}
+
+	mlx5_nodnic_deactivate_sq(&dev->priv->sq);
+	napi_disable_locked(&dev->priv->cq.napi);
+	mlx5_nodnic_deactivate_rq(dev);
+}
+
 int mlx5_nodnic_enable_port(struct mlx5_nodnic_core_dev *dev)
 {
 	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
@@ -692,6 +899,10 @@ static int mlx5_nodnic_open_locked(struct net_device *netdev)
 
 	set_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
 
+	err = mlx5_nodnic_activate_queues(dev);
+	if (err)
+		goto err_close;
+
 	err = mlx5_nodnic_refresh_carrier_locked(dev->priv);
 	if (err)
 		netdev_err(dev->priv->netdev,
@@ -699,6 +910,9 @@ static int mlx5_nodnic_open_locked(struct net_device *netdev)
 
 	return 0;
 
+err_close:
+	clear_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
+	mlx5_nodnic_close_queues(dev);
 err_uar:
 	mlx5_nodnic_cleanup_uar_map(dev);
 	return err;
@@ -721,6 +935,7 @@ static int mlx5_nodnic_close_locked(struct net_device *netdev)
 	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
 	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
 
+	mlx5_nodnic_deactivate_queues(dev);
 	clear_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
 	netif_carrier_off(priv->netdev);
 	netdev_info(priv->netdev, "Link down\n");
@@ -751,6 +966,8 @@ int mlx5_nodnic_close(struct net_device *netdev)
 static const struct net_device_ops mlx5_nodnic_netdev_ops = {
 	.ndo_open		= mlx5_nodnic_open,
 	.ndo_stop		= mlx5_nodnic_close,
+	.ndo_start_xmit		= mlx5_nodnic_xmit,
+	.ndo_features_check	= mlx5_nodnic_check_features,
 };
 
 void mlx5_nodnic_build_netdev(struct net_device *netdev)
@@ -765,6 +982,9 @@ void mlx5_nodnic_build_netdev(struct net_device *netdev)
 	netdev->netdev_ops = &mlx5_nodnic_netdev_ops;
 	netdev->request_ops_lock = true;
 
+	netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+	netdev->features = netdev->hw_features;
+
 	eth_hw_addr_set(netdev, core_dev->mac_address);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
new file mode 100644
index 000000000000..7736a1f24ea5
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/errno.h>
+#include <linux/if_vlan.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "en.h"
+#include "nodnic.h"
+#include "rx.h"
+
+int mlx5_nodnic_rq_alloc_pages(struct mlx5_nodnic_rq *rq)
+{
+	int entries = rq->ring.num_entries;
+	struct page *page;
+
+	rq->pages = kvcalloc(rq->ring.num_entries, sizeof(*rq->pages),
+			     GFP_KERNEL);
+	if (!rq->pages)
+		return -ENOMEM;
+
+	for (int i = 0; i < entries; i++) {
+		page = page_pool_dev_alloc_pages(rq->page_pool);
+		if (unlikely(!page))
+			goto err_free_pages;
+
+		rq->pages[i] = page;
+	}
+
+	return 0;
+
+err_free_pages:
+	mlx5_nodnic_rq_free_pages(rq);
+	return -ENOMEM;
+}
+
+void mlx5_nodnic_rq_free_pages(struct mlx5_nodnic_rq *rq)
+{
+	u32 i;
+
+	for (i = 0; i < rq->ring.num_entries; i++) {
+		if (!rq->pages[i])
+			continue;
+
+		page_pool_put_full_page(rq->page_pool,
+					rq->pages[i], false);
+	}
+
+	kvfree(rq->pages);
+}
+
+static void mlx5_nodnic_rq_push_db(struct mlx5_nodnic_priv *priv)
+{
+	struct mlx5_nodnic_rq *rq = &priv->rq;
+
+	/* ensure wqes are visible to device before updating dbr */
+	dma_wmb();
+
+	/* update local DB record */
+	priv->dbr.db[MLX5_NODNIC_RCV_DBR] = cpu_to_be32(rq->pc & 0xffff);
+}
+
+static u16 mlx5_nodnic_rq_get_pi(struct mlx5_nodnic_rq *rq)
+{
+	return rq->pc & (rq->ring.num_entries - 1);
+}
+
+static int mlx5_nodnic_rq_post_one(struct mlx5_nodnic_rq *rq)
+{
+	u16 pi = mlx5_nodnic_rq_get_pi(rq);
+	struct mlx5_nodnic_rx_wqe *wqe;
+
+	if (!rq->pages[pi]) {
+		rq->pages[pi] = page_pool_dev_alloc_pages(rq->page_pool);
+		if (unlikely(!rq->pages[pi]))
+			return -ENOMEM;
+	}
+
+	wqe = (struct mlx5_nodnic_rx_wqe *)
+	      ((u8 *)rq->ring.wq + pi * MLX5_NODNIC_RQ_STRIDE_BYTES);
+	wqe->byte_count = cpu_to_be32(MLX5_NODNIC_HW_MTU);
+	wqe->lkey = cpu_to_be32(rq->ring.lkey);
+	wqe->addr = cpu_to_be64(page_pool_get_dma_addr(rq->pages[pi]) +
+				MLX5_NODNIC_SKB_HEADROOM_BYTES);
+	rq->pc++;
+
+	return 0;
+}
+
+bool mlx5_nodnic_rq_post_wqes(struct mlx5_nodnic_priv *priv)
+{
+	struct mlx5_nodnic_rq *rq = &priv->rq;
+	u32 avail;
+	int i;
+
+	avail = rq->ring.num_entries - (u16)(rq->pc - rq->cc);
+	for (i = 0; i < avail; i++) {
+		if (mlx5_nodnic_rq_post_one(rq))
+			break;
+	}
+
+	if (i)
+		mlx5_nodnic_rq_push_db(priv);
+
+	return i == avail;
+}
+
+static void nodnic_handle_rx_csum(struct net_device *netdev,
+				  const struct mlx5_cqe64 *cqe,
+				  struct sk_buff *skb)
+{
+	skb->ip_summed = CHECKSUM_NONE;
+
+	if (unlikely(!(netdev->features & NETIF_F_RXCSUM)))
+		return;
+
+	if (likely((cqe->hds_ip_ext & CQE_L3_OK) &&
+		   (cqe->hds_ip_ext & CQE_L4_OK)))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+}
+
+void mlx5_nodnic_handle_recv_cqe(struct mlx5_nodnic_cq *cq,
+				 struct mlx5_cqe64 *cqe)
+{
+	struct mlx5_nodnic_priv *priv = container_of(cq,
+						     struct mlx5_nodnic_priv,
+						     cq);
+	u32 byte_count = be32_to_cpu(cqe->byte_cnt);
+	struct mlx5_nodnic_rq *rq = &priv->rq;
+	u16 wqe_counter, ci;
+	struct sk_buff *skb;
+	struct page *page;
+
+	wqe_counter = be16_to_cpu(cqe->wqe_counter);
+	ci = wqe_counter & (rq->ring.num_entries - 1);
+	page = rq->pages[ci];
+
+	page_pool_dma_sync_for_cpu(rq->page_pool, page, 0, byte_count);
+
+	skb = napi_build_skb(page_address(page), PAGE_SIZE);
+	if (unlikely(!skb))
+		goto err_recycle;
+
+	skb_mark_for_recycle(skb);
+	rq->pages[ci] = NULL;
+
+	skb_reserve(skb, MLX5_NODNIC_SKB_HEADROOM_BYTES);
+	skb_put(skb, byte_count);
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	nodnic_handle_rx_csum(priv->netdev, cqe, skb);
+
+	napi_gro_receive(&cq->napi, skb);
+	rq->cc++;
+
+	return;
+
+err_recycle:
+	mlx5_nodnic_release_rx_wqe(rq, ci);
+}
+
+void mlx5_nodnic_release_rx_wqe(struct mlx5_nodnic_rq *rq, u16 ci)
+{
+	page_pool_put_full_page(rq->page_pool, rq->pages[ci], true);
+	rq->pages[ci] = NULL;
+	rq->cc++;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.h
new file mode 100644
index 000000000000..ccdfa3e69824
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#ifndef __MLX5_NODNIC_RX_H__
+#define __MLX5_NODNIC_RX_H__
+
+struct mlx5_nodnic_priv;
+struct mlx5_nodnic_cq;
+struct mlx5_nodnic_rq;
+struct mlx5_cqe64;
+
+struct mlx5_nodnic_rx_wqe {
+	__be32 byte_count;
+	__be32 lkey;
+	__be64 addr;
+};
+
+int mlx5_nodnic_rq_alloc_pages(struct mlx5_nodnic_rq *rq);
+void mlx5_nodnic_rq_free_pages(struct mlx5_nodnic_rq *rq);
+bool mlx5_nodnic_rq_post_wqes(struct mlx5_nodnic_priv *priv);
+void mlx5_nodnic_handle_recv_cqe(struct mlx5_nodnic_cq *cq,
+				 struct mlx5_cqe64 *cqe);
+void mlx5_nodnic_release_rx_wqe(struct mlx5_nodnic_rq *rq, u16 ci);
+
+#endif /* __MLX5_NODNIC_RX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
new file mode 100644
index 000000000000..fcde1a9086f7
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/mlx5/doorbell.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "en.h"
+#include "nodnic.h"
+#include "tx.h"
+
+#define MLX5_NODNIC_OPCODE_SEND		0x0a
+#define MLX5_NODNIC_DS_COUNT		3
+#define MLX5_NODNIC_CE_ALWAYS		0x2
+#define MLX5_NODNIC_SQ_STOP_ROOM	1
+
+static void mlx5_nodnic_tx_build_wqe_eseg(struct sk_buff *skb,
+					  struct mlx5_nodnic_wqe_eth_seg *eseg)
+{
+	u8 flags = 0;
+
+	if (likely(skb->ip_summed == CHECKSUM_PARTIAL))
+		flags |= MLX5_NODNIC_ETH_WQE_L3_CSUM |
+			 MLX5_NODNIC_ETH_WQE_L4_CSUM;
+
+	eseg->cs_flags_mss = cpu_to_be32((u32)flags << 24);
+	eseg->inline_hdr_sz = 0;
+}
+
+static inline void
+mlx5_nodnic_tx_build_wqe_ctrl(struct mlx5_nodnic_sq *sq,
+			      struct mlx5_nodnic_wqe_ctrl_seg *ctrl)
+{
+	ctrl->opmod_idx_opcode = cpu_to_be32((sq->pc << 8) |
+				 MLX5_NODNIC_OPCODE_SEND);
+	ctrl->qpn_ds = cpu_to_be32((sq->ring.qn << 8) | MLX5_NODNIC_DS_COUNT);
+	ctrl->fm_ce_se = cpu_to_be32(MLX5_NODNIC_CE_ALWAYS << 2);
+	ctrl->general_id = 0;
+}
+
+static void mlx5_nodnic_tx_fill_wqe_info(struct mlx5_nodnic_sq *sq,
+					 struct sk_buff *skb,
+					 dma_addr_t dma_addr)
+{
+	u16 pi = mlx5_nodnic_sq_get_pi(sq, sq->pc);
+
+	sq->wqe_info[pi].skb = skb;
+	sq->wqe_info[pi].num_bytes = skb->len;
+	sq->wqe_info[pi].dma = dma_addr;
+}
+
+static int
+mlx5_nodnic_tx_build_wqe_ds(struct mlx5_nodnic_sq *sq, struct sk_buff *skb,
+			    struct mlx5_nodnic_wqe_data_seg *dseg)
+{
+	dma_addr_t dma_addr = 0;
+
+	dseg->byte_count = cpu_to_be32(skb->len & 0x7FFFFFFF);
+	dseg->lkey = cpu_to_be32(sq->ring.lkey);
+	dma_addr = dma_map_single(sq->device, skb->data, skb->len,
+				  DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(sq->device, dma_addr)))
+		return -ENOMEM;
+
+	dseg->addr = cpu_to_be64(dma_addr);
+
+	mlx5_nodnic_tx_fill_wqe_info(sq, skb, dma_addr);
+
+	return 0;
+}
+
+static __always_inline int
+mlx5_nodnic_tx_write_wqe(struct mlx5_nodnic_sq *sq, struct sk_buff *skb,
+			 struct mlx5_nodnic_tx_wqe *wqe)
+{
+	int err;
+
+	memset(wqe, 0, MLX5_NODNIC_SQ_WQEBB_B);
+	mlx5_nodnic_tx_build_wqe_ctrl(sq, &wqe->ctrl);
+	mlx5_nodnic_tx_build_wqe_eseg(skb, &wqe->eth);
+	err = mlx5_nodnic_tx_build_wqe_ds(sq, skb, &wqe->data);
+	if (err)
+		return err;
+
+	/* Ensure WQE stores are visible to the device before ringing the db */
+	dma_wmb();
+
+	return 0;
+}
+
+static int mlx5_nodnic_tx_is_sq_full(struct mlx5_nodnic_sq *sq)
+{
+	u16 pending = (u16)(sq->pc - sq->cc);
+
+	return pending == sq->ring.num_entries - MLX5_NODNIC_SQ_STOP_ROOM;
+}
+
+static int mlx5_nodnic_tx_get_next_sq_offset(struct mlx5_nodnic_sq *sq)
+{
+	u16 pi;
+
+	pi = mlx5_nodnic_sq_get_pi(sq, sq->pc);
+	return pi * MLX5_NODNIC_SQ_WQEBB_B;
+}
+
+static void mlx5_nodnic_tx_notify_hw(struct mlx5_nodnic_priv *priv,
+				     void __iomem *uar_base, u16 pc,
+				     struct mlx5_nodnic_wqe_ctrl_seg *ctrl)
+{
+	/* ensure wqe is visible to device before updating doorbell record */
+	dma_wmb();
+
+	priv->dbr.db[MLX5_NODNIC_SND_DBR] = cpu_to_be32(pc);
+
+	/* ensure doorbell record is visible to device before ringing the
+	 * doorbell
+	 */
+	wmb();
+
+	mlx5_write64((__be32 *)ctrl, uar_base + MLX5_BF_OFFSET);
+}
+
+netdev_tx_t mlx5_nodnic_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
+	struct mlx5_nodnic_sq *sq = &priv->sq;
+	struct mlx5_nodnic_tx_wqe *wqe;
+	u16 next_offset;
+	int err;
+
+	if (unlikely(mlx5_nodnic_tx_is_sq_full(sq)))
+		netif_tx_stop_queue(sq->txq);
+
+	next_offset = mlx5_nodnic_tx_get_next_sq_offset(sq);
+
+	wqe = (struct mlx5_nodnic_tx_wqe *)((u8 *)sq->ring.wq + next_offset);
+
+	err = mlx5_nodnic_tx_write_wqe(sq, skb, wqe);
+	if (err) {
+		dev_kfree_skb_any(skb);
+
+		return NETDEV_TX_OK;
+	}
+
+	sq->pc += 1;
+
+	netdev_tx_sent_queue(sq->txq, skb->len);
+
+	mlx5_nodnic_tx_notify_hw(priv, dev->uar_base, sq->pc, &wqe->ctrl);
+
+	return NETDEV_TX_OK;
+}
+
+u16 mlx5_nodnic_sq_get_pi(struct mlx5_nodnic_sq *sq, u16 pc)
+{
+	return pc & (sq->ring.num_entries - 1);
+}
+
+void mlx5_nodnic_handle_send_cqe(struct mlx5_nodnic_cq *cq,
+				 struct mlx5_cqe64 *cqe, int napi_budget)
+{
+	struct mlx5_nodnic_priv *priv = container_of(cq,
+						     struct mlx5_nodnic_priv,
+						     cq);
+	struct mlx5_nodnic_sq *sq = &priv->sq;
+	struct mlx5_nodnic_tx_wqe_info *wi;
+	u16 pi;
+
+	pi = mlx5_nodnic_sq_get_pi(sq, be16_to_cpu(cqe->wqe_counter));
+	wi = &sq->wqe_info[pi];
+
+	mlx5_nodnic_complete_send_wqe(sq, wi, napi_budget);
+}
+
+void mlx5_nodnic_complete_send_wqe(struct mlx5_nodnic_sq *sq,
+				   struct mlx5_nodnic_tx_wqe_info *wi,
+				   int napi_budget)
+{
+	struct netdev_queue *txq = sq->txq;
+
+	dma_unmap_single(sq->device, wi->dma, wi->num_bytes,
+			 DMA_TO_DEVICE);
+	napi_consume_skb(wi->skb, napi_budget);
+
+	netdev_tx_completed_queue(txq, 1, wi->num_bytes);
+
+	sq->cc++;
+
+	if (netif_tx_queue_stopped(txq))
+		netif_tx_wake_queue(txq);
+}
+
+void mlx5_nodnic_sq_free_pending(struct mlx5_nodnic_sq *sq)
+{
+	struct mlx5_nodnic_tx_wqe_info *wi;
+	unsigned int completed_bytes = 0;
+	unsigned int completed_pkts = 0;
+	u16 sqcc = sq->cc;
+	u16 ci;
+
+	while (sqcc != sq->pc) {
+		ci = mlx5_nodnic_sq_get_pi(sq, sqcc);
+		wi = &sq->wqe_info[ci];
+
+		dma_unmap_single(sq->device, wi->dma,
+				 wi->num_bytes, DMA_TO_DEVICE);
+
+		completed_pkts++;
+		completed_bytes += wi->num_bytes;
+
+		dev_kfree_skb_any(wi->skb);
+
+		sqcc++;
+	}
+
+	if (completed_pkts)
+		netdev_tx_completed_queue(sq->txq, completed_pkts,
+					  completed_bytes);
+	sq->cc = sqcc;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.h
new file mode 100644
index 000000000000..b93a27dffb92
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#ifndef __MLX5_NODNIC_TX_H__
+#define __MLX5_NODNIC_TX_H__
+
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/skbuff.h>
+
+struct mlx5_nodnic_sq;
+struct mlx5_nodnic_cq;
+struct mlx5_cqe64;
+
+struct mlx5_nodnic_tx_wqe_info {
+	struct sk_buff *skb;
+	u32 num_bytes;
+	dma_addr_t dma;
+};
+
+enum {
+	MLX5_NODNIC_ETH_WQE_L3_CSUM            = 1 << 6,
+	MLX5_NODNIC_ETH_WQE_L4_CSUM            = 1 << 7,
+};
+
+struct mlx5_nodnic_wqe_ctrl_seg {
+	__be32  opmod_idx_opcode;
+	__be32  qpn_ds;
+	__be32  fm_ce_se;
+	__be32  general_id;
+} __packed;
+
+struct mlx5_nodnic_wqe_eth_seg {
+	__be32 swp_offsets;
+	__be32 cs_flags_mss;
+	__be32 flow_metadata;
+	__be32 inline_hdr_sz;
+} __packed;
+
+struct mlx5_nodnic_wqe_data_seg {
+	__be32 byte_count;
+	__be32 lkey;
+	__be64 addr;
+} __packed;
+
+struct mlx5_nodnic_tx_wqe {
+	struct mlx5_nodnic_wqe_ctrl_seg ctrl;
+	struct mlx5_nodnic_wqe_eth_seg eth;
+	struct mlx5_nodnic_wqe_data_seg data;
+} __packed;
+
+netdev_tx_t mlx5_nodnic_xmit(struct sk_buff *skb, struct net_device *dev);
+u16 mlx5_nodnic_sq_get_pi(struct mlx5_nodnic_sq *sq, u16 pc);
+void mlx5_nodnic_handle_send_cqe(struct mlx5_nodnic_cq *cq,
+				 struct mlx5_cqe64 *cqe, int napi_budget);
+void mlx5_nodnic_complete_send_wqe(struct mlx5_nodnic_sq *sq,
+				   struct mlx5_nodnic_tx_wqe_info *wi,
+				   int napi_budget);
+void mlx5_nodnic_sq_free_pending(struct mlx5_nodnic_sq *sq);
+
+#endif  /* __MLX5_NODNIC_TX_H__ */
-- 
2.44.0

