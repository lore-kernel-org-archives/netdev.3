Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D003CB562;
	Tue,  4 Aug 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858720; cv=fail; b=KjejR+DC9EwitEy39T2th5n75AIr4dRAteznRJwrL5G0G6QVgbmUrEOheq3CVNUFgNkn1y9zx/2GaeM3Y9XwIzNDw2Lnj8PvNJWcBg+xp+ZY1dq3XexMCqIwp0kcPNsqelh9rtGEJd+Q+1eAQV09UFieu8s1BdIO0z5m5OrLmcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858720; c=relaxed/simple;
	bh=AaXVTQ8vOXWEKgHaGQO9JeW5ffObnpmg1jmeXi5zmx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXET0IZtgT7vn5+lvqfRpdU0H3qHT3ETEnMFqFzd+Y2bfKX4kAx2wTbMcPDygUkitkAaHJ6YzWoM6Al6AfSw5qREfC2f+nbbGjdoAIE/p4vtcwlWIRB7J715bt0GPAJP2zWxNJOZsuqzZAwRiTP5tBmfR3dzu9Rt0BAKZegOzT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LYFHXwz0; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LYFHXwz0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRp2M1Z4YBdD5YZBQewYd5WSS+UwQ+uJojeP6b5knFAdTNtRm69QrlTk5I+53AewHcYigEk7mvgRIeH2dBse/s/+clOpEuGgrJOg/G5syVbn1PyOs1s96AZK9NCf0tOAxjOU3KnZ4nL+8QPX9ys03QKwMmTo27eILM/SZXlpGobXBPNu6zX3qVeQSxIYHCGEOqzxBuNxJYyl6u7vcv8nwXfcrBhb4e+CF9Phk3M2rNbj76qpoDcWvDPt7Tc0Ds0xBAJVnodvKTIM1HF8At9U638l4n21oe5q0DbJ4HcAwkCiXtwCm/YZqiJjLoDEIehN0cvhfpHKv64CEqVBEPDlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs8aO6j1BW73j7cfHKOi79fZ/SGw2wDwv3izrHRYMJc=;
 b=jOh+7w7LTFa9RmumlfQANAu+Eo1J9JAMAzn0oIAhB2HdLYss58s0gzDO6UDwoPMBjf27dCJ6C5he6xzOTL0hiDNS0Tz7NtoTvBhRfsrBniw+Nk2xbZocKVIAKIKaF8uzNaR9iVc1WTmrY1W2pR2B4h9ocLHUB0VUGvlQBhSLomJf7x1qd3F35ixnnCKCphvJlSQ8lGbuPU+/2P3JXdk7clsQtrl1f2gBeljGoHxMr/DRueFExRZp1G9U03N1fi2jBYbd1db/bP5B8ZoOjq9oqm6sNjlFj/swCG2PjOcpuFcaQ5tTJZ6vKhR6jk7dKaAWY7L+Ah/2RjzKggOUxVCBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs8aO6j1BW73j7cfHKOi79fZ/SGw2wDwv3izrHRYMJc=;
 b=LYFHXwz07Bsmv1WQ2tzGbM2fgPtCkDdcrnipjmL7ENZxsIQ61OoBfWS9v2+dkXYynXmTje4jtYhDYZuIMbyfjTzadOgGGGFm50K9sXFgATYBpgcVlz3+go9MmuHho6d2WJbISZyq6NQULYFJi2Ici8vuFLwSxfy2PyaveTHW/IG+hm45vR9DUMShNp6qkibWBFqhJpTloRyug2HQZXg1nAeBHAZ6nchNq7VTHyVEZkrl4xP5mGDXXYJ/P9aswytOsEYKXFuAf59GFGw04YtT2QvKndg0LVBk7oBi5UHKw6C1Y6ur9LvbiZl6PjD2TcqOwsM0UF7HFJkK6IL1f8l8Uw==
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:51:47 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::94) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 15:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 15:51:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 08:51:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Aug 2026 08:51:25 -0700
Received: from c-237-113-220-225.mtl.nbulabs.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 4 Aug 2026 08:51:22 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Jacob Keller <jacob.e.keller@intel.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <shshitrit@nvidia.com>,
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: Defer netdev KOBJ_ADD uevent until the device is published
Date: Tue, 4 Aug 2026 18:51:01 +0300
Message-ID: <20260804155103.742898-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3bf16e-2118-434c-4a97-08def24049f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yFzlBdu9ZxU2Rz+zQUyI7tpVWqlLlJdLvY/JmcAWMK4m/XL+Du5rV2jt4xB/2c91T+Rd+XWaFkXBfRuMXIhmaBeRDZTatcBCbdeHDRTeteATCaiQMyqkfV0Epa6I8IRabKhyBD/7In4PG91tMZX1maMEgRagJXqeoB7mCBwMKme27stws/U5SorV8J82wHSCDnfjhVCIZG5LRbHmo5oslS7bgw4VGwm/Hne8zv89Ls+8B4WRqSW/8LBL1zD5rY8TN4JMfGZ2MhkUhQTCAuCHTpzZzcqVymzvGLlFliPkFtIVY201f+fNL1qQAi1x+/GO1sk26H9ANk+9qxxg0uNN8NyfZO3PxgXD4Y5IEqttJre2aC9agU8G3/7XYwUlkOHd0WOw49eVSQvCFJozGC5JHg2E1C3QZnZN7q54pFizhoyBGfcXJnTxkrLvrMqmO/3Pqn8rTmlT0iDurLdz8Pkwo+snJA8ou1HVwqTITJiSL46GmSR/cgNqR4q+DMrMe9sJI4Bn/H4uhvcyNetB4SK3HqNCQc0DcEoVpCwn+3C4Mvs7lLIYbo2uN+byPRxGOejB5Ma7gDxPPLuVNYwaqXLb875ZmmL7ReabhMKoRsDRPGrsgQDE9QKr2X75Yup8hPsDwwDnmZNsh5eSTKC9tw+QccQTA5Qlg8XnFnP+dHYNV2LnQHZElec/zbmnj0fTidwQ6sv/svqhOcrRnllNwbQChw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3oO/u4JX6QQmeoEeonXucOipJpLdTjCOUjXX9pvpeQpq3yksGU0Ug/9zZqRoLYL1s1y0zFfX/+JqJOSxiHRoasXSzpp6V+lmd1khPDnQx3tU3JgTLNB77rxg+djnFGlwXdqWQnkL6uXt2NMTnVsTEqGI9chl0tTPBkgSLwOElszdYbOV/vZe8zpU33eLTbfSh2xhX2lsepYiBezfft9GFckvEq2SRt6qXfURyR7bXUUH5znp1jJjVbxSOa2Jpvk3QVbL8SdkkweDQRScB/2QLsee55vikYVL8WmAZ4Bskm6KED2ROpXpABCZdrdAtgt16J4kqqN3qcVt9k7fDTuamkaUhwALplPp8+qg4UN6JWOuv5Ifiu9X7escvhL/PJeOFJzMiTNZN6fAZWJeLEzKcJ7kG9UX3xkb5UQ9KeIaqpamyxEV/nexlf6uwmXqMNkP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:51:46.4258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3bf16e-2118-434c-4a97-08def24049f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

netdev_register_kobject() calls device_add(), which emits KOBJ_ADD and
wakes udev, but register_netdevice() only makes the device findable by
name later, in list_netdevice().  A udev worker that reacts to the uevent
can therefore run against a device that no lookup can find yet.

This used to be harmless because the ethtool ioctl took the rtnl_lock
when looking the device up, and register_netdevice() runs under rtnl, so
the worker simply blocked until registration finished. The commit in the
fixes tag moved the lookup out from under rtnl for ops-locked drivers.
Now there is a short window in register_netdevice() between
netdev_register_kobject() until list_netdevice() when the device is not
findable by name.

This was reproduced with the mlx5 driver on a kernel with KASAN enabled
during devlink reload: systemd-udevd's net_driver builtin gets -ENODEV
from ETHTOOL_GDRVINFO, which was preventing interface renaming.

Suppress the uevent in netdev_register_kobject() and emit it from
register_netdevice() next to rtmsg_ifinfo(). This is the last point in
register_netdevice() where no error can happen, so only fully registered
devices are announced: the registration error paths never reach it, and
the device_del() that unwinds them stays silent as well, leaving
userspace with neither an add nor a remove.

Fixes: f994752b1127 ("net: ethtool: optionally skip rtnl_lock on IOCTL path")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 net/core/dev.c       |  1 +
 net/core/net-sysfs.c | 16 ++++++++++++++++
 net/core/net-sysfs.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index c1c1be1a6962..32cc092d5d11 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11499,6 +11499,7 @@ int register_netdevice(struct net_device *dev)
 	 *	Prevent userspace races by waiting until the network
 	 *	device is fully setup before sending notifications.
 	 */
+	netdev_uevent_add(dev);
 	if (!(dev->rtnl_link_ops && dev->rtnl_link_initializing))
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e71c9ed41e8..9a403259a3d0 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2334,6 +2334,11 @@ int netdev_register_kobject(struct net_device *ndev)
 		*groups++ = &wireless_group;
 #endif /* CONFIG_SYSFS */
 
+	/* Hold back the KOBJ_ADD uevent until the device is discoverable
+	 * by name.
+	 */
+	dev_set_uevent_suppress(dev, 1);
+
 	error = device_add(dev);
 	if (error)
 		return error;
@@ -2349,6 +2354,17 @@ int netdev_register_kobject(struct net_device *ndev)
 	return error;
 }
 
+/* Announce a fully registered device to userspace. This pairs with the uevent
+ * suppression from netdev_register_kobject();
+ */
+void netdev_uevent_add(struct net_device *ndev)
+{
+	struct device *dev = &ndev->dev;
+
+	dev_set_uevent_suppress(dev, 0);
+	kobject_uevent(&dev->kobj, KOBJ_ADD);
+}
+
 /* Change owner for sysfs entries when moving network devices across network
  * namespaces owned by different user namespaces.
  */
diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
index 38e2e3ffd0bd..2f41a4dee866 100644
--- a/net/core/net-sysfs.h
+++ b/net/core/net-sysfs.h
@@ -4,6 +4,7 @@
 
 int __init netdev_kobject_init(void);
 int netdev_register_kobject(struct net_device *);
+void netdev_uevent_add(struct net_device *dev);
 void netdev_unregister_kobject(struct net_device *);
 int net_rx_queue_update_kobjects(struct net_device *, int old_num, int new_num);
 int netdev_queue_update_kobjects(struct net_device *net,
-- 
2.55.0

