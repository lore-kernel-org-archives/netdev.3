Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69F4D7D4B;
	Wed, 30 Sep 2026 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773124; cv=fail; b=CIyUeyCuxS3Eaj3PVYZlHWW647ZXdoXj5p9E5eheXs+j9BW9pAKf7Wm1sJKxMj1Y5FolrRz1Ehd8B1aIXflnRppUD1Pw3KSe27j1DcDyDG5I451bGBn7Lu4yGAoMPM9Un+kJppTBmBdBthshMt7WE0dvxWN1mPgAZSINLwhZGsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773124; c=relaxed/simple;
	bh=YnYbTW5ZI8zm0AEQemKa+l5FubpE/Zq2HSHyUKpTbuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0fsdg+43iwQgvkKO0wAAueec5MiZOiv3pvq1uO2Hk0kLHOVBUwc/kX/dAJLlVPFIxH5wWjA8i6/+xBULiJWPIF0V4tqktHI12J6sIP8UzmGhmwEvqC9ywacx1ZiDy+VIbTltOaWsl76HrFd25mjcoabeRx6PutwMRAQoXZRaPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gbv3gGpM; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gbv3gGpM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tjbhh/bgS5Sm9d6FG8Cd18Wj1bIDm+z2ENXJJIgiN7XFUvvF9BO1w2iINim2SD71G4qsPsiVXMvd09Q8gm+DTGoJrhGjYrM++zYLl2+PXgeVC77pnmyUDe5CVJAjOmMehpv8Wmp6IUbjUFAUjLxUOgJJuXyuK1CxdGV20AYaKRXEYPv4nQb5xUBE0OF0voVWORW5vt9PbCb8yAwQRy+s5rNCbrU5a/ZixIHaO0VFgTt1+uMLr9XbpmHkI8h/Tb+ndcNOrkuPg9w1iKG2VRXBNH/E3cJUzEzigiPYQDGPVLAAaD6Z4kFS7RQsQVm5ItG6yoXoM7o7ABU/mqORWGiBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEYmRoTe3HrHBOESmTsSc7fC3olG9RU1KfzvUog3y8I=;
 b=lirtnkZkf8xgxatkIMm6Pw+ZFrrlSmY1Q8XIjCPzEhpUQ9ZOsJvLzTEXmjjH+Gm3YLPMxT35/93B4mzIq+HVJW93AeD+b0NuGXZQzmI+6R2Es9OLaTRvsJjELiOWjeESmD2rhzV2ApaSnoZlWP3g0f64jyfrX1Rbz03X2xPWVawH8oBUTxVrc9syGEnJVUEHdy5Qn6ZTkw6ohTEpAh9terYCpSH91vjTtcdOfAKshQOpWdyzktiT8APw9dCSxiz510ZxFnmVaMswtnOl70w9+9i2d15A6LRspLl0/vQf0W76Y564kcwVX6GtakHMGvLAvV71HDSD3B537jP/ThyJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEYmRoTe3HrHBOESmTsSc7fC3olG9RU1KfzvUog3y8I=;
 b=Gbv3gGpMYfsNHdZ0+JBADXZqwiW3rULZTb6EIXXJ3PPKTIO8d8pZOQAt3BBKhfIqm0BlaQKoKM5kPrDWexQvK0xu32X+T4lw/9dD4ocX39oI6oZ+cIOyic3UwPrMiWwCDthSytwjYNcRppxd6pz22wPgHMyg6X7v+Tt2ZjwF10oGJ4FKiRTz1hIeBknbJEfAraiynMR1QAvEB90/uvIxZ5PlkP987IjWXGASW8SVzRDZD3c68bquj7pqv3g6dyoWPchyphci8VZxRyRjUnNRRlCVg1Pyhzr0bMrICrt1h/S5pEr9ZYZH3Zm0dk/NEgS9tp7yC44qE0Ib4MMwvcz3qg==
Received: from CH0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:610:e5::9)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 12:58:24 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::7c) by CH0PR03CA0244.outlook.office365.com
 (2603:10b6:610:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 12:58:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 12:58:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 05:58:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 05:58:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 05:58:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5: nodnic: Add TX/RX statistics
Date: Wed, 30 Sep 2026 15:57:06 +0300
Message-ID: <20260930125708.144767-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a0ed9a-fecc-474b-b520-08df1ef2835c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|11063799006|6133799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	whKRMCzlWkqGIjAJicj+6Kq6htvrgrMKP/GonAUBihymVWHvGOuwrcJjzPcSbpLypRN/w4YWMhtUzA4VdDts0uKW7INdtnyZ/QUyGKnqUd0sj+1JtLd639fDm/52ulqnUIi95fLvKYkZgZHV8roSUa9PThH/NBBRtSvM3R2ISsTfnB8VorPY2wRwkTorv8gMY+FDP92DDAlEP3/o/T78dbX8sKdH9jbO8m/25lEeXqFpyzCdmFEx7GWjZvVA8N0Gli3zIJUXquT4TrSXotKT/0KMiRvHc8wQCDJN3fJsKsxwQHnFUcjDx6w5Bm9tmrO7MKcxRTUxhd9uAf4Ma/DCq3SNCprcWs9a9gWhWHGVF7I/wSC+aAvmrFmIviiADzAgPhwEz4xtoCJo4aahr5OIHrKZFcX8RBoLJQ01OQli1Pkad1vC23TBW3Hl5var3kupMaxhBzmIyIKsZ59nuLH0N4zNmJ0VOk41jE93EbKgI3EdCOT5xBRNFZSQc7QBUuKr12EkwaOarvzF60gxqrdvUnF2oBZAi+6DwgWnSM4C9Qk3HBfJWxoeBbGBb9Ry2PbcmTbq4c7vwEWajfdlFA5nS/oL9GViMHzBXvvZAEBXBvoi/vVtj95dUN+6z4itty87/X4YWWqseKbT2Atd3Z0SUXLTPrI6rkyzduAc6rTbYqmVxkvU+x/tTZYWJfkztGhSBD3M1cPYEyht+5LdqFVSjA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B1BKvUCnwl7jw+8Ah/pjvvNMR7PLmp8eRwIIscp3KuZmJq1pXLnLp8iSqA5tr6wnb9jOkj0d/jpCe8d2Tz9idzJ94goZDcQ/U67uolroKx6ewiop06FxNGIXBHvebinFYkiaM4Q7WnreopuDf8puyWmma8W2D3xj/NfqO8QW9XKQpc8o8vELIWoJjam4Bm8gE8paQwlhN3DbWJ7LZ6puhAcEQe6JmgCCeiePRSo5PirkU5EYWNoQe62RZlraBeyELbFzN7aVhwxy1Dis7Rcb6/Ff205ZQFf4mOYIXDVUBidwKBvBoUuVq7sQ+CqXf9UqCQmiLJs6xX/3OvRdJa+hGv4E9ur83f1keui+HeDMecD/OP3iYo3J4DDvOZqC+xzR6W64gVdRRKXfgKDDCJWrYPmA5GtV766gGTBRbeXDYgUJ55ZhJPzlyvDEjswdguAd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:58:24.2913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a0ed9a-fecc-474b-b520-08df1ef2835c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

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
index d73e2ec1662b..9f3ec04e7a7b 100644
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
index fcde1a9086f7..b6f2368155ce 100644
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

