Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9B373C1D
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780085; cv=fail; b=YTur4pwT+73IGpn5hAmIx8wxXGv75EgLMOgMckhMo3HYGLwD61ichxbMHvLTJqGrR8rOUES5wnymWHtnNwPlA+oM+bKIl31Vf3boC0GWgMuTWuB5E+7j76Dj1+G9SRd7DVN89FnOG5RPKjmWQdhknPH4ZTVe1RxHFTGM0Gyxw9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780085; c=relaxed/simple;
	bh=RHNJXS8WFQ/xGVOT3qsoCzGal9E8sYZzt4ip0XiOFSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQ2sAGFDJFtidPE5vjh+Kzu8x4PoW3yuBNaI7fx5lyp/wdsKv2yAdCsMAFGeoCRvkjbORoossW06FrLqBg6C84bC5RyAvW/ujhD3eQnhKSrqa+5UARdyEShMJGN+FAJ4kS840garnbjdlrI/y9azXTD9OmgvI11wzW+iddKMMjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLjcPFlL; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLjcPFlL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfFfCPeH0YyrDPwGg3p6NXjwB3lmQZEYubNrw7iBkZjyt69BwYQPbN1dHUy9W9KZdim3dnz2qazX1Qc5rcTydr3otgK7VwOQ94k/Ld/4qTDUjPWc+ef5+CzlXHy5po5AZBfXb8nKeOFkdXRhnV/SKxLKe5No8qSOMekGQ2yJXu7HVe3lehVOW89rNpEfoqw3bs0B8+XIdzcNQGy/wFk1+M78xRquBhj991vMXCs8b7xTeLZ8UxGblrrjScOd+HcyDG0gE5UANBob2ckFxnq0kAdrdj/DRiFuiODzrLwL9awy4XddN16pVdFg1RilRUJ2co/SHYiU29ZQa8Uydaa9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgr2AOONixejEcm+p4DPub8eW+TxbjOE1/HS5r7AwKw=;
 b=ryYRQTqSgEYqRoo+iooGTviQC/fVzvjEp29r8HJTiXyhGq0DO4mtOrOqT7OEt4Vcnfv4Pz2u4vW1joIQh5t6W7Uis25iBnpWXQ7XbvMVSkv3Lfx8RU1vODwz91X4m+EgG19a5d9dYZ4bYi2Z89jAnz4Dodpl8BepSx2aF6r3hvGrVzPIT7C9Edz1kQdh8qWhaRmm8MM7fwK1yeImElra5yII+ItrNIInfHyE04FIhYZEdBpqDdvaTYS8Zf2ePtK+mujUH2jMIq6B05WN6TNSOFEvXfT/gvqlLI7xQ3Phcvkj1Wko7rNmNx1vegklRzMZWfiC7NvK42JGgIDjBMwp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgr2AOONixejEcm+p4DPub8eW+TxbjOE1/HS5r7AwKw=;
 b=SLjcPFlLN6AbLfjgX6mnW3gD58oykf2Bm/PHWp6r1VdrAYecLR2XwX+Rg6AcgDNFXlo9pOWUsqERFNT7qu6drSJl8H/yhlGjQAkhfi3x5I5+6AhVHBWhM9CosJY3JORm91KaCUF8pZkbbZyTRiMJOZxyHGi0gChJRxn3ssTx3JA=
Received: from PH7PR13CA0001.namprd13.prod.outlook.com (2603:10b6:510:174::7)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 04:13:56 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:174::4) by PH7PR13CA0001.outlook.office365.com
 (2603:10b6:510:174::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 04:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 04:13:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 23:13:54 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Simon Horman
	<horms@kernel.org>, Eric Joyner <eric.joyner@amd.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Brett Creeley <brett.creeley@amd.com>,
	"Breno Leitao" <leitao@debian.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2] ethtool: Embed FEC hist ranges as buffer in struct
Date: Wed, 22 Jul 2026 21:13:42 -0700
Message-ID: <20260723041342.39238-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe2176c-3a3a-47c4-df0d-08dee870d02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|82310400026|23010399003|376014|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HTpRzGpYsfCwBK0xydwY5wj7PYsiqs0/D0oalYY4Yiy0SGrHKD+TgZ36LmkpBDFjcNfmRhtYrflZR4apnAtPxVG6o99BEOIrn3SF9idT6NSFmG+Hh0mLpcGuH7+jg2FHQL2p7uOVCkTpGEXvE10FSdPC41rbQeBR5RAr9554PTY8C8PI/XjJpE3yrhqHIwFzKF6/7qoR1kQMtKS+hJJb+y3IrAOcSUvGzol1SbYHMvnIFm+7LxPJb73xx/1Q1wUywTdSgOUGtW2UbsbtgN5IjIuZXyyzwCSJpVL+eWRUD+elFETB2UN323LfXoNGLs1RpjiC3rg+rz6JvK4L6/BUuWy2dJeLUvsK6kcMKVv4EIo1BjFh6NVFustL8VdW6T44pf4q+QS8ihsMz/j7Yg3MKMCP1oDpu/E6qP7aMw/B6oalFpugyofhd2E3BtroYjBMi8FogNjt34aMQRUalhjt8EoJi9pKvBtmy9qyqkR+4F8VvdBoo/z8rXM79wA1K7SfAsRuVDE3CTdn4NNL0Da29qE9EirB1DZCEuN7chQBHSmVMEbCZkEj41uzTMREWa9QDFLzi3MiDLD1Ex9/3Iv0Xn5tFh84oQVRjapDKsBydFjpmcBnoADjZNcls83aSUJaG0z7Vh/76cC6TZbGi1Ol7aHxrheQQ7dJXjKout8ONxKaxVsW+hMJ5IvOcS9S19mf201rf/PnQSKmSHdIoB1vLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(82310400026)(23010399003)(376014)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pwn1DKC9qLZFV2j3tPV8VkDRFOvQ+3kfpFKqrNQKkwNiBixLhnRjgFAmKsDkThHPlLmLnYykDxmCA6ynpst9o0ggcwdLw4vb0Jymb98OW38EEPDB4wjBysFgKwlAB/cAuEzRg4wxC8muBz8yFn84pZOWXI147OkkHC0cymF0iZ4t3DY/LVX2AVhJOBir/a5VDK3lpVf+yOqv4fJ3c4fj26G8Yfe+bToJACKJgTiDp2OxB0nxN8A+hCsFPmGyXLGcn66RBZtCm7sHuMn+4SPsuuByV2BWfpcOqUSkPHh7RzkvDfFcuR4YSJqrhH/umpKqs/R7rkHa/4ISInMXeymVa+JEJF3apHxzSinwvE30tuc3/z8VKYRKzDGGHjA269L4JgiobiHCWFUwJc45AR0om1qSs3X+OgwzYq1SWG3FfAQBXOCX+xX7V/rJlGNRrWoV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 04:13:55.8963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe2176c-3a3a-47c4-df0d-08dee870d02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

When a driver's .get_fec_stats() handler is called and the driver
supports FEC histogram stats, the driver supplies the histogram bin
ranges via a pointer.  This pointer is assigned while under the netdev
ops lock in fec_prepare_data(), but the actual data is only read after
the lock is released; so this allows the driver to change the ranges
(e.g. from another .get_fec_stats() call) while the current call chain
is reading them in fec_fill_reply().

Fix this by adding an ethtool core-owned buffer, ranges_buf, to struct
ethtool_fec_hist. Drivers whose ranges are built dynamically (currently
just mlx5) fill ranges_buf and then point the existing ranges pointer at
it, giving ethtool a consistent copy that stays valid after the netdev
ops lock is dropped and later in fec_fill_reply(). Drivers whose ranges
are compile-time constants (bnxt, netdevsim) are unaffected by the
potential race and keep setting the existing ranges pointer to their
constant array, without making copies.

Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
v2: Take Vadim Fedorenko's suggestion
(https://lore.kernel.org/netdev/f136bfb9-1756-4668-acc3-68962cdc6069@linux.dev/)
and keep the ranges pointer for drivers that use constant ranges arrays;
only use the new memory for dynamically constructed ranges.
This makes this patch mostly an mlx5 change.

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  7 -------
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 19 +++++++++----------
 include/linux/ethtool.h                       |  1 +
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index d507289096c2..6867a5aed42c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -984,7 +984,6 @@ struct mlx5e_priv {
 	struct mlx5e_mqprio_rl    *mqprio_rl;
 	struct dentry             *dfs_root;
 	struct mlx5_devcom_comp_dev *devcom;
-	struct ethtool_fec_hist_range *fec_ranges;
 };
 
 static inline u16 mlx5e_stats_nch_read(const struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c1acb9012d3f..7d47a1da8b6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6415,14 +6415,8 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
 	if (!priv->channel_stats)
 		goto err_free_tx_rates;
 
-	priv->fec_ranges = kzalloc_objs(*priv->fec_ranges, ETHTOOL_FEC_HIST_MAX);
-	if (!priv->fec_ranges)
-		goto err_free_channel_stats;
-
 	return 0;
 
-err_free_channel_stats:
-	kfree(priv->channel_stats);
 err_free_tx_rates:
 	kfree(priv->tx_rates);
 err_free_txq2sq_stats:
@@ -6447,7 +6441,6 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	if (!priv->mdev)
 		return;
 
-	kfree(priv->fec_ranges);
 	for (i = 0; i < priv->stats_nch; i++)
 		kvfree(priv->channel_stats[i]);
 	kfree(priv->channel_stats);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index de38b60806c2..e7e6db7f6bf1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1550,7 +1550,7 @@ static bool fec_rs_validate_hist_type(int mode, int hist_type)
 
 static u8
 fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
-			     const struct ethtool_fec_hist_range **ranges)
+			     struct ethtool_fec_hist_range *ranges)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 out[MLX5_ST_SZ_DW(pphcr_reg)] = {0};
@@ -1558,8 +1558,6 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
 	int sz = MLX5_ST_SZ_BYTES(pphcr_reg);
 	u8 hist_type, num_of_bins;
 
-	memset(priv->fec_ranges, 0,
-	       ETHTOOL_FEC_HIST_MAX * sizeof(*priv->fec_ranges));
 	MLX5_SET(pphcr_reg, in, local_port, 1);
 	if (mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPHCR, 0, 0))
 		return 0;
@@ -1575,12 +1573,11 @@ fec_rs_histogram_fill_ranges(struct mlx5e_priv *priv, int mode,
 	for (int i = 0; i < num_of_bins; i++) {
 		void *bin_range = MLX5_ADDR_OF(pphcr_reg, out, bin_range[i]);
 
-		priv->fec_ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
-						    high_val);
-		priv->fec_ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
-						   low_val);
+		ranges[i].high = MLX5_GET(bin_range_layout, bin_range,
+					  high_val);
+		ranges[i].low = MLX5_GET(bin_range_layout, bin_range,
+					 low_val);
 	}
-	*ranges = priv->fec_ranges;
 
 	return num_of_bins;
 }
@@ -1622,10 +1619,12 @@ static void fec_set_histograms_stats(struct mlx5e_priv *priv, int mode,
 	case MLX5E_FEC_LLRS_272_257_1:
 	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
 		num_of_bins =
-			fec_rs_histogram_fill_ranges(priv, mode, &hist->ranges);
-		if (num_of_bins)
+			fec_rs_histogram_fill_ranges(priv, mode, hist->ranges_buf);
+		if (num_of_bins) {
+			hist->ranges = hist->ranges_buf;
 			return fec_rs_histogram_fill_stats(priv, num_of_bins,
 							   hist);
+		}
 		break;
 	default:
 		return;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5d491a98265e..12683b5d125e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -562,6 +562,7 @@ struct ethtool_fec_hist {
 		u64 per_lane[ETHTOOL_MAX_LANES];
 	} values[ETHTOOL_FEC_HIST_MAX];
 	const struct ethtool_fec_hist_range *ranges;
+	struct ethtool_fec_hist_range ranges_buf[ETHTOOL_FEC_HIST_MAX];
 };
 /**
  * struct ethtool_fec_stats - statistics for IEEE 802.3 FEC

base-commit: fca68249b6f5e84859b200b54cb5e0aef98f2b3a
-- 
2.17.1

