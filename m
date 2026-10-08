Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53B3B19D0;
	Thu,  8 Oct 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480100; cv=fail; b=a2wYXspKmuvSkCDM1XQ4J+dYVcampTxl8sBw78N3kYRHD70r82wd63nLfAnWhc1iSXKTsXS4Rymn7r/rJ3EcH8fOLODeyGVla5z/+M5sjIIdLS3l4vBENgdNE6NPtEGCNhFZ53hoQahnUdrozVjXakrXkxBZK7ocnzrKsBohjFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480100; c=relaxed/simple;
	bh=cIpETAjEPZIuJrjcXg+7a+JunZxeihGblJmFN0olXl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9TsYgUD83XGDHLnViPAfUifXUu01daYGbJzIZ6fSQ0URNuAqqKPp+JXO6JSp3tGMUn4meIEADTYqj2m5pWEY0DedjZupBIx3hxiBe3sPcVOZjL2GDKmgJgN+Mrww7TjuXeUx3xpAUPsW5+h/eTQZ5TE+oktJk/pDcVAtSiv9yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tp3GPESd; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tp3GPESd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCoK1wHgQUqcE957ZJ52O9aK3+r162dew1RG87Kb2NndWg/UHaWgAF8FZAjtfCZno5S4puiHvvjG3w1akD2ZagFqCOYeMAXnLOYS8C9HvWY61KrY3jd6vVmyyHAjPApb/4qlrkFF+7+We+9q5A+1dV9kLVTneK1pj/nrcbu/Rms4CE/kiXjswF6C1meaqPIa1U9MXALDfUmNi5E0ZXZyitSGyZJsJp67yjI0OsbruM28EkzDRpUrCkJazBP0jgh5PFPgaaWM15zkm3hTGUVFP2UYZzSrVG+iyrqdjKLzo2tlzdsXJoAUWedvRzk6WX58VK1V5qBKAfKBqQEIgv8sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBcEwU3wQBjMpXdt/7KnuRip2/UnEMT1ZeQ6oINIgx4=;
 b=Y5y72zG1qruN++6CeDRDmkqsmp+GrYGcFp0H4nFUBogFilavdYux+TghE4D5m7Vb0+pWzR4JEMk3kLmwWYHxRA1GXjd8oUg7ba+kEY8d3rWjjPoxFOhFt24ql8PnmolLEGSeydY3TTJsBLJOBXhIjRn93hVwaY4ZYfM2tJoLqL03KtYSTTw97Kx1VEnXe9vnlB0YYUSbB4XJ2se+EtrCnWoOmFCPtJbqnAiLSCrM1lIfDlfqJ5m9nfjUOvWbgTslaqgapqlOwOXDoHZr8qqFvEPUatKgs1U1VMyj8A7uM4dqA/q/vRA+AZYKxfha/+nXExcOQoi3mIzSYaWN3JlPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBcEwU3wQBjMpXdt/7KnuRip2/UnEMT1ZeQ6oINIgx4=;
 b=Tp3GPESdbNzgPyN4Mu50+Qz5eDjabaB4h4RUVEHjZHdgOOFkRWvLMSAxXt1uWWWs3YG85Vh6mi7gf+lirvgvjuaw1LhZl953/8s0g845jC8TJ+J7eN3U7hzGypzkCOpOKNqAX7ct9QpqJPNQWXmlBwguZ3CB8MlEntoJ2fdqkJfSMGHbOiygyYPlFCYuvRWVQRNM6IGCUcds615TqEH+KPYWPC0H6bckYSQO2zq5tFvsPXwEQZhbvtEJu+flYzyhTZvj4RqrHdj+AEFP26RsOfeQ3sHz9qORFcuIXn7jElhHs7MFaJnmgnfqmiTMr/KOCul+f5LniSBORgih++Ik9w==
Received: from CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::26)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:21:33 +0000
Received: from DS8PEPF000000E4.namprd05.prod.outlook.com
 (2603:10b6:610:1f3:cafe::70) by CH5P223CA0012.outlook.office365.com
 (2603:10b6:610:1f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 17:21:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS8PEPF000000E4.mail.protection.outlook.com (10.167.23.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:21:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:21:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:21:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 10:21:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 3/5] net/mlx5: nodnic: Add TX/RX statistics
Date: Thu, 8 Oct 2026 20:18:18 +0300
Message-ID: <20261008171821.660739-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E4:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a685757-26e3-40aa-5512-08df25609920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2EUEG1b+n7GtGsF/0X0BaUFij+UPmXKRbilcTSmYmBvX2s2VH0VxkKEzvP3q1uFdOky4s8xPWWkH2dPM1ApCtsffAW64EF5GramRJ6txTY2TT54bSN1zuITy5OdgX0Gl/Qnm3hK6KYiToXCbixA9Q7HKyYHMalI6ZLNJyjmZNOg0ow+KOQMBBjMkB8tg5GSe5VULRQv548IwOJYFobLvD3EPtR4frlwHOZX6AXO+HDwSdyU1jEmH5P8n2aO/oCaHqmnB7vmxcJQtPJ4gl7K0A/U0FFiWd79F7AkBFLXArP4JvenWC/y4QJHYv5fCApZHipabLcObfqX6A3s+pQu2PBAKcCOzi9Bnp4U/0h6FBv1ROfg7+o8Q1cBbdJqalpMFeA8mpsk7th97kavoUCpXdFo7Go1iCfHmPeIgTbmKF2lIXFrL9/tZMuk4DUpA0TN7TPq55r9CXs7VunryWhnd7OgEkIYmECXBcguIcvhNBIZ3p8FcPph35ah/WGrjamvy3wp5isQ+eQWDVZO2x50U+l982CmbkMSSrxmzaBOZJNfSqKJMM5GfiCmfPHGQJC9YzY0Ak9qzzP9bfgTYgM3lKTWhJH13VYLcCRYP1s3S+HoT8Lg8KWd9WIfHlaxxUDWOnYvakG2N85cIbBI56x98/Vmq9ZwikAZMKvQSop6GQnkfQa37mUDgQkfSUEeANT/HNSyRBnDh9UQUvC6E0Sg9rQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e1NHdhdZ8KqalLg5G/XFhAjuJF8/uMmjiyPtsLFmnXce4vbdv7QluVk0tAx1fNSBD+WarI9oKCQPMGC3NizgH57yCG4mcFnfLF8j7rZ/wP1NwAERs11BBMIAZmirH72ZAh9M6CA+fblS+YH5modkGFZv1s0V3EwkVaFkurY5IpfFb8s5d4jl99zqlyqk3KUho72wVFAHQrVWLuqJL2MrfIUmoYcs2Di/v+58oVm63vM7sACppI0GUQTmoRKhk7Otn9zT0apO92qLfbiJLv0wZWJuofxDcDzq5U1Mtfxv0b5fBqb9jcjxzZvdd8877lMZRUxkrniDodD9GeYK4XxFMSRIDRWN04QYbDixP2bjI5xHc2/LUlgcEa4cd3lKb3eyus/ghk1/wlWJT7AL4/7pYfqundY3NnISbFw3t77NVeXhw/FvA3+mMtJpFULF6fbm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:21:32.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a685757-26e3-40aa-5512-08df25609920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

From: Shahar Shitrit <shshitrit@nvidia.com>

Add TX and RX packet and byte statistics, as well as TX drop
accounting.
Update the counters from the data path and expose them through
ndo_get_stats64.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/nodnic/en.h    | 14 +++++++++++
 .../ethernet/mellanox/mlx5/nodnic/en_cfg.c    | 25 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/nodnic/rx.c    |  3 +++
 .../net/ethernet/mellanox/mlx5/nodnic/tx.c    |  4 +++
 4 files changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
index 19858e9da064..d811bfe242ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en.h
@@ -44,6 +44,17 @@ enum mlx5_nodnic_cqe_opcode {
 	OPCODE_CQ_INVALID,
 };
 
+struct mlx5_nodnic_sq_stats {
+	u64 packets;
+	u64 bytes;
+	u64 dropped;
+};
+
+struct mlx5_nodnic_rq_stats {
+	u64 packets;
+	u64 bytes;
+};
+
 struct mlx5_nodnic_ring {
 	void *wq;
 	dma_addr_t dma_handle;
@@ -109,6 +120,9 @@ struct mlx5_nodnic_priv {
 	struct mutex state_lock; /* protects Interface state */
 	unsigned long state;
 
+	struct mlx5_nodnic_sq_stats sq_stats;
+	struct mlx5_nodnic_rq_stats rq_stats;
+
 	struct mlx5_nodnic_sq	sq;
 	struct mlx5_nodnic_rq	rq;
 	struct mlx5_nodnic_dbr	dbr; /* one shared dbr for TX and RX */
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
index 9657c43e9958..cc8b3d3fb0c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
@@ -963,10 +963,35 @@ int mlx5_nodnic_close(struct net_device *netdev)
 	return err;
 }
 
+static void mlx5_nodnic_update_sq_stats(const struct mlx5_nodnic_sq_stats *sq,
+					struct rtnl_link_stats64 *s)
+{
+	s->tx_packets = sq->packets;
+	s->tx_bytes = sq->bytes;
+	s->tx_dropped = sq->dropped;
+}
+
+static void mlx5_nodnic_update_rq_stats(const struct mlx5_nodnic_rq_stats *rq,
+					struct rtnl_link_stats64 *s)
+{
+	s->rx_packets = rq->packets;
+	s->rx_bytes = rq->bytes;
+}
+
+static void mlx5_nodnic_get_stats64(struct net_device *netdev,
+				    struct rtnl_link_stats64 *stats)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+
+	mlx5_nodnic_update_sq_stats(&priv->sq_stats, stats);
+	mlx5_nodnic_update_rq_stats(&priv->rq_stats, stats);
+}
+
 static const struct net_device_ops mlx5_nodnic_netdev_ops = {
 	.ndo_open		= mlx5_nodnic_open,
 	.ndo_stop		= mlx5_nodnic_close,
 	.ndo_start_xmit		= mlx5_nodnic_xmit,
+	.ndo_get_stats64	= mlx5_nodnic_get_stats64,
 	.ndo_features_check	= mlx5_nodnic_check_features,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
index 7736a1f24ea5..808740ec3910 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/rx.c
@@ -152,6 +152,9 @@ void mlx5_nodnic_handle_recv_cqe(struct mlx5_nodnic_cq *cq,
 	skb->protocol = eth_type_trans(skb, priv->netdev);
 	nodnic_handle_rx_csum(priv->netdev, cqe, skb);
 
+	priv->rq_stats.packets++;
+	priv->rq_stats.bytes += byte_count;
+
 	napi_gro_receive(&cq->napi, skb);
 	rq->cc++;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
index f2efc8d3f5b8..6958c8a51231 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/tx.c
@@ -143,6 +143,7 @@ netdev_tx_t mlx5_nodnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	err = mlx5_nodnic_tx_write_wqe(sq, skb, wqe);
 	if (err) {
+		priv->sq_stats.dropped++;
 		dev_kfree_skb_any(skb);
 
 		return NETDEV_TX_OK;
@@ -176,6 +177,9 @@ void mlx5_nodnic_handle_send_cqe(struct mlx5_nodnic_cq *cq,
 	wi = &sq->wqe_info[pi];
 
 	mlx5_nodnic_complete_send_wqe(sq, wi, napi_budget);
+
+	priv->sq_stats.packets++;
+	priv->sq_stats.bytes += wi->num_bytes;
 }
 
 void mlx5_nodnic_complete_send_wqe(struct mlx5_nodnic_sq *sq,
-- 
2.44.0

