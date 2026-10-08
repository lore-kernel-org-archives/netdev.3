Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132383AE184;
	Thu,  8 Oct 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480107; cv=fail; b=FiURsPHUKUug5mT/aL167vWnJ3RUeK4yMYMsJTO07fAIZLLou9zeHSaeBPLBsMfXS6INHiD9rOC9thOgvIDkvp21W+Bzn+gHXXeLP6Xw1bFgAg6PZFgvilDDwBGPIcV2FZL7Vctvxdez3xMxSfMw0+HgB1qYnrYIzBqMe03sBn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480107; c=relaxed/simple;
	bh=/hJ+07SKk+J8EPh1LNreWucGLo9Os5zMIICNXKCavc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2BMojjp+ZsNiGgK3+Qw6dJR3okqCjqaRsoWloEW067wSZlT1PrvOKGuPlqabT+VFnaQ1NLbcltxFOVPA7a47G+8zHz1fjskdxmyXmRBsGemyUNmloW402eHp+r4urzXXRjl7aClYu6EaFEedmfZ+I1My9ANNCQv8HUAQpSqGL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWqMtlrZ; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWqMtlrZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgJzQSuHlwfD7YZS5GtT5QE447mzaQm7ujBZ6e/9diPV+4R3/Xx3bSP2O8lPZ/kQFg3/vJbaj9rgMkwz5LtKbMsMPrlfZyD5tIX4qtoBGCk6342ZiQLk9ChKPONbDSORVX233CySjAawUasxZSOat2pJJohxUqBcfquotvVkaer+cCb9H2T3vqiDpkO/YJeASzq6nd1p0RO0IQ3RlLwPh0YiuepM2NqQCpkI+XFJZtSWShbHFkvBTkkl1l+8Xvf9a4AeQbOaz+C7JpU4Mz5KzG1n9OcV7eS/BzyCtt3UBsbXV8mt0aYhMv/0eCG3tcamqAce/OL/Ooi0pRfHzjZhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIHgU1rqO6UT0w85XFb8EOdOZYQDHZ9qh7O1C8gxbCY=;
 b=wBHb6FWq0KC5fNNmdwkTWQcalSBueyGAVJ3a8PSHCIs+iG4CkmBtGqyG7JXyZns7b44gyHozPJzcLJtMaLW7b/wEcBb/QdSGgDSRavJ7xTJanS/hz4S8gxGd8ZtmKEy/oBLARbvc9UpQIjYRNjod2eCHhhfw9C9AMlOi9/aq9TgFL6H8fpeJA2MJ5uVC44F2GIYnr9y8qqgVEdC/k+PHi5Tox9/N/bkZoffrNrhPmTyErr7K8YPs0Y5dL6mRJxlG6nhSO2XCcMyxN450x1TTwm414ssPb3BFVh9IYspCJidNGFGFr3IR0GCewW2myHUY0crOj04r4x780yyunpObMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIHgU1rqO6UT0w85XFb8EOdOZYQDHZ9qh7O1C8gxbCY=;
 b=AWqMtlrZog019Pn23b58ikE6bOfYvDDmjN0FOQ5gSBOfwWSMe2juj5ve1EFwGBa5Mu8aJV7JNsp3zxbQUNmwsbbe8l3NlekfvO/TFVayOxMx6Co6gRHfkavmDjJ26it1nefxeKSuvTeUIlagfWGggUhCBK4D/JR6C0KcxroDJu9Co9RoyedJKZI/B7wODwIBKR1/rIXSyijh/cWT5lqMCP2emVzRaG47RZLA2Upbl1ukISaPv0R9yh1JfBNzMkZfhcWFgyA0KlMes452tHSlGRGTFLPLsw4Ke/YkZl9bMONd27z89kw0EJXRGhRcH8FJ8RJzOPL9yDngZJv8XnJc7g==
Received: from CH2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:52::31)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:21:38 +0000
Received: from DS8PEPF000000E2.namprd05.prod.outlook.com
 (2603:10b6:610:52:cafe::2a) by CH2PR04CA0021.outlook.office365.com
 (2603:10b6:610:52::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 17:21:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS8PEPF000000E2.mail.protection.outlook.com (10.167.23.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:21:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:21:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:21:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 10:21:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 4/5] net/mlx5: nodnic: Add ethtool driver info
Date: Thu, 8 Oct 2026 20:18:19 +0300
Message-ID: <20261008171821.660739-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E2:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5242d6e6-6820-44b8-f7d3-08df25609c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kAD9Oe2IBf1GZEgVmgwzeLbxrWhjHnErzfvIag52jq2Ka4kdDNMyLERj5eiL/UZdrfU1VOhKaM+1I8hUomrWlOWzk6UGHzsonejbhAEo/I0ohOujnhVw6COoQ4BzOVfDRImziHGKSYL/0QOYOURYfRcREEGCi1gcygoBnhU4SyLxe1VXC4F04jlPLb+AbAGs7IrUtLcgoRJ5ytSACN/ZLVW1Kn0CxaI3enTtfUVSOnX/t6AoZgTTShQ/LR+EU4pfMkZRpjRtNdlbD5/yfSgFp/Vsrs6BtjXtG2Aqoe9Ns5Rt2+MR02TnzY4443EF+q8Z216jjxZ9OxM9LQlMc/2l/D4hUXbvp1pSRMPG6CEjQT/w8mnevRveJbBlQaYunyOTecPQlvkPAP4/5aQ6MmDNl9gse69PxmSUl2+lEg3cB0niqE0by4q2rUc0Famr86SkSVvLqwCZG5rJiOo7JIsa79NnG/mXammZ70MlG1gw5sOCZD6fonNTSutuG/q5gTOpAP6JvDml5Zdu1W0Eg+FwBUsP4G0wOwIHryhPt2E7Qd5WBlAQ+CajF6v5ar7TKeggfdUrKRPbw5OW3lqHh1ndwl3BZYSleYvEXzeVzO9Py/w2kOx/qd63l/CttgcXsAweWSY0yblYIqSx5S6bcL4jrdhwjTstUiRI1dtYnHdnfGnYsXD0i6VUxcS5HH6EM+8kuzfbaGtRqlWEyXiSbYwkKw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sQnu0o5UUwqApbB08DZn1oWbUzGIXIFGop8VQJSsFbXnODYKwEJnaar5sju/Rx1U1TLTna6EUfZ2/bjaybYzyf2HRpL0aCG6YMxFC3C3QbnLRO+wOmPmnL3KEKjpaV2ozBabI+e6/gRO9eur6AbopgU6XXB13WmHJCLjqsPkMybnFdCsDXKDTlYw59K6G6ZwMJB8rNRVc6nEUEkyT7pDaLeYOKJAByIa4tCywMDYuJY1lLWDXqmfWDgOUZ4fc61zY/zvXAesSyqnnoaCf4DQZhGf3Sf/+3+zCNBvYLqfUAuWP40JkJC2KvONsH7DbbIHTL0Rl7MTb2rQC/Mwk5+PF+aYpTAdUbH/huCKuwEu3Rf9XPQNG5qatBGkZvGaR6WRLY9o3fJD4pgrXDrAfaobw2hyd24i0BB6I8gmjRHkGJhezsQzC/Up9CcbyaHYubd5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:21:37.8506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5242d6e6-6820-44b8-f7d3-08df25609c58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

From: Shahar Shitrit <shshitrit@nvidia.com>

Implement the get_drvinfo ethtool operation to report the driver name,
firmware version, and PCI bus information.
Read the firmware revision from the initialization segment and expose
it together with the driver information through ethtool.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/nodnic/en_cfg.c    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
index cc8b3d3fb0c6..033db1999c74 100644
--- a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
@@ -987,6 +987,39 @@ static void mlx5_nodnic_get_stats64(struct net_device *netdev,
 	mlx5_nodnic_update_rq_stats(&priv->rq_stats, stats);
 }
 
+static u16 mlx5_nodnic_fw_rev_maj(struct mlx5_nodnic_core_dev *dev)
+{
+	return ioread32be(&dev->iseg->fw_rev) & 0xffff;
+}
+
+static u16 mlx5_nodnic_fw_rev_min(struct mlx5_nodnic_core_dev *dev)
+{
+	return ioread32be(&dev->iseg->fw_rev) >> 16;
+}
+
+static u16 mlx5_nodnic_fw_rev_sub(struct mlx5_nodnic_core_dev *dev)
+{
+	return ioread32be(&dev->iseg->cmdif_rev_fw_sub) & 0xffff;
+}
+
+static void mlx5_nodnic_get_drvinfo(struct net_device *netdev,
+				    struct ethtool_drvinfo *drvinfo)
+{
+	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
+	struct mlx5_nodnic_core_dev *mdev = priv->core_dev;
+
+	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+		 "%d.%d.%04d", mlx5_nodnic_fw_rev_maj(mdev),
+		 mlx5_nodnic_fw_rev_min(mdev), mlx5_nodnic_fw_rev_sub(mdev));
+	strscpy(drvinfo->bus_info, dev_name(mdev->device),
+		sizeof(drvinfo->bus_info));
+}
+
+static const struct ethtool_ops mlx5_nodnic_ethtool_ops = {
+	.get_drvinfo	= mlx5_nodnic_get_drvinfo,
+};
+
 static const struct net_device_ops mlx5_nodnic_netdev_ops = {
 	.ndo_open		= mlx5_nodnic_open,
 	.ndo_stop		= mlx5_nodnic_close,
@@ -1005,6 +1038,7 @@ void mlx5_nodnic_build_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, core_dev->device);
 
 	netdev->netdev_ops = &mlx5_nodnic_netdev_ops;
+	netdev->ethtool_ops = &mlx5_nodnic_ethtool_ops;
 	netdev->request_ops_lock = true;
 
 	netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
-- 
2.44.0

