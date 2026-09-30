Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CC4E66AD;
	Wed, 30 Sep 2026 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773127; cv=fail; b=eRkr3GgfUxAJaPcV+bJEg9pmPrb1OiIDyMjpdE0Dpqt1+MmpgpucCUcNOcx/+IdXf0hwPzEsrwtlGMEIPxB5kPIhCPT28ncZ3UpSdNvi51Ek5TCu5D2U07NOrtG3bWnDQM6p/KNfxx2Z2xHiVnx48WC9ttI2ae2EDp0iqfjdl6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773127; c=relaxed/simple;
	bh=v/QmTR6U50CLfqsKKLtqHZrNFV2vUDF5NTBSV+qOgXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8OmkUhVxgd0GADG3hEISBnmWiJHIy4wGXcckSZjgHqXLNC6HYWFWsD6dm8dInMYX3P+6n+VryRYyWOtKWHN90DyuvNdMavJmkaXSqJgJ54zpZkGsLXZIIV7GlkJRDa+kTdatdBJ0bbAs3SjiSIHdbgOtHAK9Y2GZ0BXyK2+N6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cllb6uH/; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cllb6uH/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARnXGMReB8FHA8ItzCWTRS5l2wYg3ouP6MNYhtLy41lC78ewXRA6edILJm1xA0VwtOFEZ4W1XWKyv0g7+ci8opVNlK97y/yu+m1H5jB7Myub6rnBaLGT+uDcmX6eRKQ64X3/x0gkTGdAP3unvWZF1oeunMyl6YJrhZXU/SunRwUaUmvWBXW9q4w9qV7nzC1hDxPjrkkVJSwgAdsb5sQXMOfsO8junUu8OcaXw7o83azm97Z3Vrb3gMWIBSYXDGRd0rvpOr2te6sZ+7bfqSwZtMI4Bs8BwvohV9QiWYq3umvi8pAsKjK/vesTfxzwXua/MjE5h8dkq7iAjsIMaSEAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddJgYy94FY3GpEk3UsBdv1erUIyG/9XMbEW2OtXCtOE=;
 b=qsFkiygGvzA2Ja0LjUON2RCA7+DQUdSZNOPM64vmiQvvTvu5LXNI4UBbMb9upJ939pD2mfMIYz3iZhv1IqBFiYzyzJ2Is3jA8x356hKpKXWrxDfGA7f8nfaLAzKhOGPuCzxVXQadIT93C3CIBc3qNV9ysdyUDymHpbjQBky04hVY8FNFyUZpupJpvhbm4gVb/VC/t0Ez40Kdvz3p41sMSaPrh3XxOz+oR4pSVuR8CVAdimJD7DhaSYfqSr2k/CrJs0w+nJTuUKlKOhEMmPrTv65o+K/j6ekYtIyDZ7/930NEaWIbjKmFyfQ0VPXrOA+HkbSbVBF4TecFeTAU9JSFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddJgYy94FY3GpEk3UsBdv1erUIyG/9XMbEW2OtXCtOE=;
 b=Cllb6uH/r79b9mEe8qaOt1NVmTYEC06nySlnJM5BszPO33u0lnOZxAGJTHyfvKLseAx8f0nlD5UZY/os/KXUBImC9kW7ba+wuMZoaFr4kR06/5fbasvc19kXeTph1efDw1Bf5tsR4VVJTpC9lJFASfQPsTGRxEBD+nMjIXOCO8lLhLOipSsooUL7u57LTeis2SQlvv8ucCsWHrd1ptRp8MPdN2Q1yxy3/nbxCOO+GLAOHdFd2Fqp4Q/f1CSadyJ50r0pY8UYiHbEhxLwWHuwhkZy//AeL2zYAkIA2VWumR1/ArVSkcTJjm2YYtKEtso+EMzs8ZeiFquVKgtqGn0ECA==
Received: from CH0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:610:e5::27)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 12:58:30 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::54) by CH0PR03CA0262.outlook.office365.com
 (2603:10b6:610:e5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 12:58:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 12:58:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 05:58:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 05:58:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 05:58:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, "open
 list" <linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5: nodnic: Add ethtool driver info
Date: Wed, 30 Sep 2026 15:57:07 +0300
Message-ID: <20260930125708.144767-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: d1640a61-c30c-4470-5fcc-08df1ef286f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|10067099003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B5akqZlAkFIfpCGS+s62dFLijB/sgBmNr0gbmeCt1VdA6D4yqhzmuX1EBIHLU8Cf0UzMKH1PXDhmqBQgVLPPbe9AZHJrvN7RD98aGptsoZ2TCRZl1/BZRYc1LYM8Sko06EDcksYmrNuFwlbCBaYoeq9HOVvNorYluXeJIqf/oSaLkcOnNwxOq8uO5/tzggRpKDFOmsFjbz/lx7M4OQmS44FbdC4r3A0caU3amzPoAQAUepznO6YAF2ZBBvhpuZ8EpxDc8KKN/IzCxRlavMBRAO/yYZZe9TyRMS8cM6yJXDi3PUx3g0PB5fN9RnF4IVZ0B8jvvY/OyGBECRXqUnrXVJiUxMOgHhcUi/NhMuN+6KXy5iIoIleZUWzeYAmTN3lexO6Ws12tGD8J7UNEQnOm2JJAeQ2Ujds+SEg5vBUi1Ee+hRP9YS4bU//yzNai+URZK9Mf4Bctrp5uVuUcmbc2tykGK38UQyqA9GJB1cLtslp6YAzzOv4JoPUZLuuc5EZ/S6ea77ZmymixzbMg5jG2+7K4MtVBpQjaUU0sgF6Dgz7IPAbisKJMkGAvDespL+VP3wuW2njjZU8rWbpqkDaLHu9fDDC2gNRsQDERG/a8oq0o2bJBOX6K1dtVGQbMyJaxHnEzo8025b1iePvPan0koHkYKBrouwCcJ6hOBJmPbVZ/K/a2/ct5kynGmCPIZFNuIZTChzuk+FyhI7envw13tw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YzmxE7VDpq3pQZUWkh9jd4RMOrrnaR68vpFIXbSV3ovDI/uePlCmyXNImFd39Y0sL7jIzN5myl53NmGl7JMW0n7lAlSF8QekmFdEAwK5GW9ZJOo5w/9GIdaz36G9yRY2o7iQ5itE6qy0+m+UTU/EM8rK11pGPnasTsUTUF2aN7GJJ8hu2FgxC55HclH0AyEjxrjWYEZRBD3BI54DETWnWozju7KvL+gnpU3lM692yRDESMKFvwoss0P72LK32E9ecJ2k6pVO+++no2NBtFigc4c7psHNeOtlAexKN8wLDQ3WwN5Z4gLUpKGQWuYKcvPpaYLd38DJ7gpCYI73lWYe1VNH6mPopdbwAZ52jqhP7mTYFUNQeCxDd9hWqjVKNPrnDY2xlf3uAYfS2S6SK/EgVuFEGED7xNhPUfOsbLu4/BHXSASCcg0IBm9SX9YMt87m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:58:30.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1640a61-c30c-4470-5fcc-08df1ef286f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

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
index 9f3ec04e7a7b..88a59d7ad7ed 100644
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

