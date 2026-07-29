Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F0372EF5;
	Wed, 29 Jul 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312388; cv=fail; b=GwugEe0sxL35Ji6urrxuY74EH+FOwNarU4cHO2gk6nO8eNb4oKlZYAWiIjsHk3tj43mb5GeP2Zeh6YIdDq+N1kutTZsN1ZvJFs9UJe+7jbyZUwLclzJS+W/qwOiXP7e0XFwjUmDUZKTpCKFy2SxjXFU/pfe/LueD0+toQS1wcfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312388; c=relaxed/simple;
	bh=sY4vAUGG11J5BvJAD61XMYPORLgC2BFTcbzX0gffMQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V24ig/8TACa5++te/qZaF997xJ1xuO5FV7Qk3SIAldDEo9yfFqsFNTmCLn08qNZi48jbgA01Nv65QC14h4FUnMM8rtv9nWi2b6Hoq6vqaBs2tfX+XUQBc/Po6Okc4fJnievSkQQWhRyV7IREg5zVVKVG3PQi/2VmpL8YhgLXyLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C+09D+ps; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C+09D+ps"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlXq1eOK7pSdAUrVGU7u/nNhTQcWBF/hZts5AReTC2vOlDhAe/B29gZMACsi4vOuEcDH+KRb7Q+Dw4lQedLmcebsevwCSe1zKZy8X8b0Bq1WZFlxD+OEgh91ZwqfNSlgCKnMiBVBsBETdqmn/CvNMtY118xkcxXIICR7OhCUS435mYoys3Ut9c1awnTr6E9bkmjvzcSDG8e54dC4I9n9TsxKRlExgzE8f8XHtPhaIgUh9VXF406n0gsZXGJ43JSeIJYOGV3jVtITthONmf3uBpF6bmT0plMsmpFLLhxSWZe1ymLE1ZImgIyT1vDqq/OTK+QACqyHnfRwvAyFKmWirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prvmNTimcYX1N2K/PIQKngJwtI/T+I4OrzMsTj0FzB0=;
 b=gVbZipVD/TJrI0sWf42dGXw1liJbJXb7OTXA4/pPk4zzEPlOpxCirVlsvwGOzhJ3Sm0iTvsrojhMjq2HPtN3YdLAEn2Em/qL6IaohVC89sLu8FfvA8JBAQzk2VhF4rwtDmbk/MV4aySuyoCgKYtkH2+eASxFM7wwFrZOez8Y8l3PM3tf54PdUPVa/SKUeboe3USPnwrE3CT0h9GQ3hC8O2DZ+gn6K0ByCfI73yCQDyDsrzKR6jlAzVvxELduOg958+PqC/y4BG+pfuBhJi2Fu39UTuTZpEyPI/r4/GEhiUFF57m/rS2FqjQQTWpe1LZT0y+pi2YLq475mlCYJHjL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prvmNTimcYX1N2K/PIQKngJwtI/T+I4OrzMsTj0FzB0=;
 b=C+09D+ps1lUHMYFzzvq2tMoo7GN3KsaDJRnqM4EQ/aMgE3sanLXBN5VJAypQdftTOLWJTgOYR+bPRq4PUCTZnFf/je6v0V6wlNEt9Sk7zQXU4Jncs5BiB+6LTtuLqiZm9pWLpE3SXCUiUXdl7fU4ybh4Nl3ncnJQug2YgtHz1nYgy4yYo/RX9AIdE/LJgI/8bWGpNw57YyMTCwJUcntXo4PyKoXl4n4c7wHf5ccOsWUBDxyPawkfx6UR0BNfg19lL8dRtZwKjQmBaF8ZrZV7iWN+v0O8bObst+R00PsmQXCgzBOcwyYcwJVjL1EiUnZ/WPzS7DrmwRpeRH0X+xoBHA==
Received: from BLAPR03CA0166.namprd03.prod.outlook.com (2603:10b6:208:32f::18)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:06:23 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:32f:cafe::ad) by BLAPR03CA0166.outlook.office365.com
 (2603:10b6:208:32f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Wed, 29 Jul 2026 08:06:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 29 Jul
 2026 01:06:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Jul 2026 01:06:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Jul 2026 01:06:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, <linux-kernel@vger.kernel.org>, Or Har-Toov
	<ohartoov@nvidia.com>, Simon Horman <horms@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net] devlink: fix net namespace reference leak in reload
Date: Wed, 29 Jul 2026 11:06:00 +0300
Message-ID: <20260729080600.2427721-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 27498208-b69d-4bea-512f-08deed4847f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CjlWrA+Xo0S7IzsyYhFA7Y0Bg6GbK8il36kuUxVXSBDq/H3dfvAhXg6m7Rlro0DabV3aH8/xLIk43xeyS4/R3JgxSjsMcAPwkBUaV1d/PDypnmjLCOkTavPleCxJdi6j8j/ceA7yN3B3FZ3XoHzPX6oybrGc8NtbUEJeIPXiPr69ycMgMKRMkA0s4dFbvOkonPTsUcqcAIm76N4Lq0NTU+vdwRwQDfzXfl6nSO8z/nWb3fxhgzYFJeAbpqBa9u9KOeUnszHs5XAr6u528xsg3G05B0njIBnDD1Rh8twSBDYmU0sxql5YgAsrFpL36bWVxSsIA95wz/agmHBOY8tVqXte3xFTcP/QJVbpz8CYz4ODxUOer8/U+/ZzIA2ek9jjAkLotLpS5Pbr+uwa2d+tY/LC9J/9IppTlS9E7/PvaiSxhVIougl4N6aXXBIgHKCzNYpeOgaVhQZmiXSpPLGwkNM5qcxkBRDsm2QmhVN5ppxoTYgSCajKTSWgOKgfQXontAuue8nCZ/1LNODwVZAl0ibKSLcEpmHPv3ACI37/pQx+qruVz6N7p5BXZu2t+5d1UBe26kTEBxUqwv+YMIgRUEZuE1RAwMh0Z2npvVd2/LAK8ac5tKEnOzdr5l6ey5q92WeGYDECVBBf6w3xP4YbQFqRdt1pbP+zqAG1OsJU76TgZU7CW5SItO0qf+ZrP6qb
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I+4GdyW8rdbG20J9pDtgv8q+nUiYgUc0jLY3MCs2tOlVt2jWz07cboZxvib/VgmroijUAEMPy2Etg+RLnVRYA1C1tPSsomclWGbbvNl37alJ4vq+wPILmIUFba43CDRLeooCQoPi13HricLgkPEbpb73MmfxptBKOujovceOiFeHxi3GA4K0/KJXW3enjCpLiTAR2uVq+kiGtuHWIdKvL0xCZvfvG+I8L9+m+qzs/RNzb+d8D58PIcTSZrpOyPpfRwp/AUdrsJizrbPBiPl+PlVSS2iVtNgeNNfNVD/Z++GEkeUI8vqbvttJJPqOeHNNxAMFt/lFpK5Ug1LiRzgkpaioDLt0r+W1Mb5jbTA0X95oRsltTrbG/zeydUmNU1Y0zTq+8045x6iLxe8yooNiegJ2UEdE/hWYRDRP36FLBhiYDx0a/3cRkANQjHie/Mo0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:06:23.1815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27498208-b69d-4bea-512f-08deed4847f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

From: Or Har-Toov <ohartoov@nvidia.com>

devlink_nl_reload_doit() calls devlink_netns_get(), which returns a net
with a held reference. When the requested namespace differs from the
current one and the reload action is not DRIVER_REINIT, the function
returns -EOPNOTSUPP without releasing the reference. Add the missing
put_net() on this error path.

Fixes: 2edd92570441 ("devlink: don't allow to change net namespace for FW_ACTIVATE reload action")
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..fd5633fa88ec 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -578,6 +578,7 @@ int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
 		    action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
 			NL_SET_ERR_MSG_MOD(info->extack,
 					   "Changing namespace is only supported for reinit action");
+			put_net(dest_net);
 			return -EOPNOTSUPP;
 		}
 	}

base-commit: 3bd438a58e910db5dc369aa25dfed1fc95f1b596
-- 
2.44.0

