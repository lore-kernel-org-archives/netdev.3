Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A412777F3;
	Thu,  6 Aug 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003728; cv=fail; b=uivF9w+mlRFp5Yrc7KlzX16qnrJ+X6BSgCxb87SdvASaFqS69QxN7/sSAbxZ5TtHj72WEccDxtJ6Bytj/UFok7iNOXxlEJijzUv+vizuK3cuKbNcF5yd5TD1IqpfxMgBiQYLtqA2Mlau2w7QlhEtvUzJ5Cy2EpQPZ6vFCg4WJM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003728; c=relaxed/simple;
	bh=WDxba/13qoa8My/M0UGCG3isWGB3S6hh4gNABVy9PTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWGDAZ5cdtRavc3YvfU8ebUHL3TN3b6KP7yQKzVdo63YR1+YAt1025Jr6rz/w4BoG+qx8vFd+GNgwzhbg7c5uLk3ETs7iCDmL26xsW6QZIcojTCru+QwShMrL0Fl35SARZA3yjPriDewJ3Akj43uacBCjiKyq6A53uK8Xe1Z+LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rkoigl3H; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rkoigl3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhge4uI+BWeN2kJhCHA4wcJQ256nFMSRg4YDJJk4fVTFQsnfkkqRqAmiq21TOc8jtcLae4qt3diS7jdy+sieMMkqkoqDBsVPTFR2TbYiL2013BzFUwtwumXHrmdsCbqF9nm42NWREaJvPJz5jZ8ALqI5q/FcG4/gLichH0E98sqeMIOuoghBaF66TCxGK7FxB0ckXmmvVElaEC+JZAqOIznyZvxeirxmeA+pOqlw7h7AkaR7Jwf+005XeD7G6mET42q+0eLfRGq30mys1lhs+gmmehCHsw6SuM738PQIDLQLklVyhpdCDxTwhUd4AMqCDaJ8MCxOi7YnXdFn+VOrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrRKT1ugaVbpxryMt4ywK1x603aOHQ9RTxKeur8UO20=;
 b=HNKfdWGUgjgOtuAcm+jxWWadqtH0J9zjxOonPwse+qmglNRJJoFBXEQcWFxlfBmHBlX9o3bk+itJbV9S2AO0rk2wrHUWE62jjkT296M5z0W8Fj+VprKI8aKGALdZVEg19QjHrzZL8vI7242WxFjblN0QLgdevzrMbz2S4dbwDCgr9Pc1latuW99FWidTj0KQOgF3PhbwlwBm1YiIp8iI1O3Bx6c3kWJ6+YO1RxFLozimsDxs/d3v946PAyAfmU49a8yWoWpl0Y2wgkA6rmGJiITn9iQTF8fr8VVKAtttWUq9VMQnId2BnFd+yBhU5OGuDPJ6DhDsHd2lnEl6w8yi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrRKT1ugaVbpxryMt4ywK1x603aOHQ9RTxKeur8UO20=;
 b=Rkoigl3HWhupkxlQ1s7jmQqFQqM1NyCKfab8JrV4aIovMzx6Ago2UmvhUVOmnoNUc1aWN2giW+fhzepXZ6IAxKeSbxSU4dROXny6o+JdmlXzN8YaOUsKZ2w1ST7FM4lj96hPtg3bgYe1ByO2ToQ9XD1sSkzqRj/MUK9yiNQAjPLr9lEmwbnHE1NXCbHS61R3YdqxteHk5DsnA52eplDJK8R8hKC3qus2JCHJvdSU2FPjGY5QgEIzqEhX+6ceEWVqubj0y4d+KCRr3QYYktOd1ibQEhIAyKl6Yn1R1ClKU7bzoq2a8D1/xSXS91QUo4h/MzHraMh5XnmlXP6Iwx78/g==
Received: from CH0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:610:e7::7)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::992) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:08:39 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::a) by CH0PR03CA0212.outlook.office365.com
 (2603:10b6:610:e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 08:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 08:08:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 01:08:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 6 Aug 2026 01:08:25 -0700
Received: from c-237-113-220-225.mtl.nbulabs.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 6 Aug 2026 01:08:22 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@fomichev.me>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <tariqt@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: Defer netdev KOBJ_ADD uevent until the device is published
Date: Thu, 6 Aug 2026 11:07:58 +0300
Message-ID: <20260806080758.2039586-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e2c69e-dec4-4fcf-659c-08def391ea7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tm8+0jligAY64i4I4Hnn+xgPKo5X1oB6rQhotqPTTW+391btP1B27tsdRVBoDR+lRV5LgmocUlSGfCkIfbVIzx6/mlzhgnQVWJ0HPvTQsKBdaVnedZxgpKdYFmSRaLh0Z6Man2QzszFqGX4lwzyiEPQCWchrIl9bH9m4dZ+kUYc4FnOCgmTq67Dm1I9Lok0ufnMWG+Gp9Z7AmQSonG630gcsmae0N+Xe6qlWtmI6/ybOWzf5cCn4byaDvacuiM+HFffNZFqATmkGrGcEmtgoPrTuhy6t0pRlPFNWKCSC5bnM4JPzfPxtKOLxD0ah0qcL4mACkwLkU9GdysQOtJ8z3Tg+AVjB5CFoo322VmAz7BiZ3hVvN2Emb1BqAnXUZCiwh3iJRcsefFXN2mfsvswtgVwFoCgTAZwey/ktvs1oGkb4C6KCBZSoZpPLoxcuV5mBhjRM2YX1yvB7k7LXGwQGzHIkm2FhvNH87+bROQD3Ax670xPdC4yilc9nu7GwBwRIs4KYc+ZakuQrd6LSE0qSSjMx+Ur13TRlznwyQAqOgMs1bFHzLXX8ztHgDBzSzUOder/LP9qSVRjDdw81N4M8fVc93piwAHDVc56CvKOkN0IId3LoMxQL/NM7F2AcTP0R8ysolVP8yG5VmMvGAZQQXZMjaEE2+6NaazoWYshwfgbZv8AXtR/9pYx8BfPpgLTrLwQ8Y6hRYuTXz0/FS1cuqw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yqn1h1v4MiarwrqZoMhpANWkkVt+8UItBPOplt5nft4Kwqz6RKFg0uiTpgsiVy156l76ZMO1On/4g0ECCl+MRj3m0MuD68W8eqWouKIadoFVp9pjkfVAOVBwUTRjneygSWv9sWweFYcCXjgZdxpBYwc8aqU3wMiWOqGGLBAK6qzUjpeeT81eqdgGcvd35+bhqWXuIPzQZlaIs8UG5MsifVaz+rN+YDIKYsFzclj7Pgmrc4ip4eo1m2WOrzjYhp6cpO6+qRsCuGK2sO014S4bohM9QbFqm3e8cQYoy07GfTgz2yk3xmFJl8epwC+ptq3igXjKjmZPcDqYNQL1wrFYfmV4Kr4kVrW13hHomgpzF0zYF7n14UYjbgRitVF/Nd9Nw8cAOVCTPHQWgoBkBs778B62tQ9nLhwd6GxmDjYTFokC85RNLsbf8nAOGlc5G42B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:08:36.1712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e2c69e-dec4-4fcf-659c-08def391ea7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9

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
Changes in v2:
- Addressed Jakub's comments on code comments.
- Link to v1: https://lore.kernel.org/all/20260804155103.742898-1-dtatulea@nvidia.com/
---
 net/core/dev.c       |  1 +
 net/core/net-sysfs.c | 14 ++++++++++++++
 net/core/net-sysfs.h |  1 +
 3 files changed, 16 insertions(+)

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
index 0e71c9ed41e8..25546deacec8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2334,6 +2334,9 @@ int netdev_register_kobject(struct net_device *ndev)
 		*groups++ = &wireless_group;
 #endif /* CONFIG_SYSFS */
 
+	/* Hold back the KOBJ_ADD uevent until the device is listed. */
+	dev_set_uevent_suppress(dev, 1);
+
 	error = device_add(dev);
 	if (error)
 		return error;
@@ -2349,6 +2352,17 @@ int netdev_register_kobject(struct net_device *ndev)
 	return error;
 }
 
+/* Announce a fully registered device to userspace. This pairs with the uevent
+ * suppression from netdev_register_kobject().
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

