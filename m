Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AA48A8C1;
	Thu,  6 Aug 2026 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039966; cv=fail; b=rihK0rOqE87M+SXkkZXJFpiV+CXlSPYKRAI6rWkoRC57bPynPBOiW7yBL5vCVqjYMh55/S733+ANESyorOs7lmBHAHODnn3D+YgDC8lOK6zOmSIky+/c4YlgSYJ/66vdbkApjXZ1LjjgfBveSiLe9j9oNSt1fXFnvSI3B4F2Z4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039966; c=relaxed/simple;
	bh=e/aL97+F7J+eK0HojbSx0xEmxQbxm/ZYrlupoGG0cBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAsUJJ3G3FS2GMeuC/5Uk67rpr9xHefiLSkHPQGi3gix36H+32CmceMYv4ZCdl6TJ+dluCECt5jrfI4K5IHe1bew6JP+fCkwzkswozMCFXC3KjBFNgUYR3OFRSk1hCTZXuX2coJXnDEfXQ0RTWz3QqL1KC844QX+EriboQPVb40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4zRpg954; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4zRpg954"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqODVEw6fkFmRUclXfnMQzJdmafEuf2hCAfcJgJgJwFW+ZJiCb9PZJ0PTmcHvpJrg0mICdW5SN0/8CCp4ObSw6qD6y8QGEfx+67zg+TSou0pgIdDjX11tSVwSmnSUa8P5S6MKsoLXtaN+tNRlkFyqW1+VBYzlWnJsshEgbqaix7ie6DfsPyj4hnsR3AJ3+qKgMnglw9y/PTVRNbGzA4lPQNhunq58IAczSUpowsAVSsuEc/zQhBue4D4p1C0sL1rnr9JFNa8Vl/wdmsih8W4MrKwW62T9m1u5z0GMIpyHqCScpCgQ7VsfvwIoiH4EJDGZnVU7UaJdoSJ/w+cwjB6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhBbMZhUSBavGmKY87Aokbcw6sn558H0rez4WXJpnv8=;
 b=VoZprNnqc2AQ33q6XxP77gE3At5MYYd6X4oHaqkEof56cQlJgKQHWSLVPuuHPV+FHuAZ5IDJGoP+xj4Jf3F+WRoJJAQVifGP0Df9mE0Y7mmYVl26lOZbpDYE1zzcjDh8WOtlUToRqp1EMq9GR4kT3Lt9+31ejdTiNW/C6JIlweapgEpyu83/8GuOnv5cIpYD7uEkXLY1oTvNNep6FFcMFxtqUkriCNaf8YfiJD3Nq1wbxrz119UQcsywHb6jA/DlElWh/24Z/CoAGiKXQww4Osu3kMVgi2ejDFl4nyB4cOh0IZRqyq6lwb5nhVu68RiEKIX8FP65xrH6+RnenlTNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhBbMZhUSBavGmKY87Aokbcw6sn558H0rez4WXJpnv8=;
 b=4zRpg954JzD1akYeOM++pT9HsjUM0mIkSRU6ebaHKnOSI6GzJFBiurNMbooWC6WpN3je+K1bLgbPkU8qLcXsaBt6a3yk6YJWMjywKRR3fsmbo6e0jd7JNh68ATLK05Lv86NuKeF971DREuGQgNeax6Ee7aeG39JopaeHQfMd2aw=
Received: from CH0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:610:e7::29)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:12:34 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::9) by CH0PR03CA0234.outlook.office365.com
 (2603:10b6:610:e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 18:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 11:12:32 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:12:26 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Brian Masney <bmasney@redhat.com>, Stephen Boyd
	<sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, Danilo Krummrich <dakr@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Russell King <linux@armlinux.org.uk>, Shuah Khan
	<skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v2 4/7] net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
Date: Thu, 6 Aug 2026 23:41:50 +0530
Message-ID: <20260806181153.1213996-5-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806181153.1213996-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260806181153.1213996-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 925851c7-1147-457d-46ee-08def3e649da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|7416014|1800799024|13003099007|921020|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	v/D+oELLs0/MsfYUQ7fcpzx9l35CzWsIJFS1F/XRr9BhOVD9XnhHX3jwDCMnIlJSh9NGCXybmDtcYotknCuj7ctcwy/te9Tw7beeYJygRyAPDrCrurI3kcI3oqcuZQ5Lybdusr16rYnbWSZkC5kRDRryTPAJ6HsgTefMPhxdqXXtYHpxil9nzF5WsESYqdnRi1nLvc1VTYa7dPrNwaILbv/OaPhcuFPhgn3lF5wP88ZJGR41KGP0WYDMuuekFh6FiUtdlkzQdjEjNeIwQ+SOmI4gfVZ97f+2Qu+MWUN7l74awuG75G7OkWWZwjldyXzuwUPlSmnRLTp3hauyN3feQjop886wMxZzgfaagrjAeJWVjDt7QrsimbhPKH91FTq1IelrgldE6e5N2Ti2qH8Qu1YUhQGUgZok+FDU/lr7+jZPeJAXq3nfZoemyoj8F/Snj0xHn+APvj34yp4DnwYFvGvT9O3zvM38Hu5BLa33lmwEIFKbTw9wK/dyZvE+n/OYwFo4fW71T8zs130KWD4nAyRrEjR83nm3Vku/H1BQPPwH1RU8xMTznNnESl27cVRCWrCq3bLY+HdWOAte8gAOC2R3gR50zhvUbnykE2BQhH0mFtAzuxO9a3rTcszIz341SrCKZYlYcWdlfI60mbAl7PP5E8LppM3KTpCBMF4UgE/jSqeZBB/b+qNRVr2poN88wIod6wnh9MLSr7e4p2YzHJ1QP2aT77LGGkF2jhSDx1Pqiltn0sjxvtXBIPJtXarz
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(7416014)(1800799024)(13003099007)(921020)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5SdtO57tFxpxuNd3sq1QyaZrN0Xmo9Br4Gqp+IGnEzxuCyyeZICWn+IvTjIlZw9IQTPSn+hZUGJmI67oZMeX0Roh4S3xuYr+0n2CZsvOxVQokzIFgykrcRVC6D+4IJj4pI9/tW4sE0QhxWZjOkIAEssSwAyU9nHYzefe9lbEOjgVDqhRiVT7OMvecvqmfYaA8+hiH0HsEUtRChoTLjb4oI7vYrqSUT3d9jAjTFUkKwt75UAWO/TZYZlchJW1yHAX4Ubb+/KaPuuZ5SLtwG285f67kGBeuKdeDV0ttvAX352j7x5/g8dOYNAmUk14f1Brk8pMV+wmMpsQVkUdv5m4q9deH0ytzTtDrxJwjQFfzEQD4+RX4tueOoNepmiSScb7TpTOCVn2ktwPf9+3p3aHL49IRLnnr3tnjxejBw8rEqAgSeMZkx4JSInv9tDcHDWh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:33.9526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925851c7-1147-457d-46ee-08def3e649da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

The AXI Ethernet driver currently supports only the AXI 1G Ethernet IP.
Add support for the Xilinx XXV Ethernet IP[1], which implements a 10G/25G
Ethernet MAC with PCS/PMA driving a high-speed serial transceiver, as
specified by the 25G Ethernet Consortium.

Add the XXV-specific logic in new xilinx_axienet_xxv.c/.h files and
describe the MAC through an axienet_10g25g_config that provides the
capability flags and callbacks (GT reset, link-ready polling, options
programming, phylink caps, PCS ops, register dump and probe-time init).
No MAC-specific conditionals are added to the shared paths.

Also propagate the axienet_device_reset() failure in axienet_open(),
which was previously overwritten by phylink_of_phy_connect() before being
checked. This matters for XXV, whose mac_init() can fail on a GT
reset-done timeout.

[1]: https://docs.amd.com/r/en-US/pg210-25g-ethernet

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/Makefile          |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   9 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c |  17 +-
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 329 ++++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  |  86 +++++
 5 files changed, 437 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h

diff --git a/drivers/net/ethernet/xilinx/Makefile b/drivers/net/ethernet/xilinx/Makefile
index 7d7dc1771423..db90e691fec5 100644
--- a/drivers/net/ethernet/xilinx/Makefile
+++ b/drivers/net/ethernet/xilinx/Makefile
@@ -6,5 +6,6 @@
 ll_temac-objs := ll_temac_main.o ll_temac_mdio.o
 obj-$(CONFIG_XILINX_LL_TEMAC) += ll_temac.o
 obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
-xilinx_emac-objs := xilinx_axienet_main.o xilinx_axienet_mdio.o
+xilinx_emac-objs := xilinx_axienet_main.o xilinx_axienet_mdio.o \
+		    xilinx_axienet_xxv.o
 obj-$(CONFIG_XILINX_AXI_EMAC) += xilinx_emac.o
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 40f03c9eb382..295a1b835165 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -17,6 +17,8 @@
 #include <linux/phylink.h>
 #include <linux/skbuff.h>
 
+#include "xilinx_axienet_xxv.h"
+
 /* Packet size info */
 #define XAE_HDR_SIZE			14 /* Size of Ethernet header */
 #define XAE_TRL_SIZE			 4 /* Size of Ethernet trailer (FCS) */
@@ -545,6 +547,7 @@ struct skbuf_dma_descriptor {
  * @tx_ring_tail: TX skb ring buffer tail index.
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
+ * @xxv_ip_version: XXV IP version.
  * @axienet_config: MAC-type specific configuration and operations.
  */
 struct axienet_local {
@@ -627,6 +630,7 @@ struct axienet_local {
 	int tx_ring_tail;
 	int rx_ring_head;
 	int rx_ring_tail;
+	u32 xxv_ip_version;
 	const struct axienet_config *axienet_config;
 };
 
@@ -680,6 +684,11 @@ struct axienet_config {
 	void (*stats_update)(struct axienet_local *lp);
 };
 
+static inline struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct axienet_local, pcs);
+}
+
 /**
  * struct axienet_option - Used to set axi ethernet hardware options
  * @opt:	Option to be set.
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 5c59423bd778..5bffa5b9d0b4 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1705,6 +1705,10 @@ static int axienet_open(struct net_device *ndev)
 	axienet_lock_mii(lp);
 	ret = axienet_device_reset(ndev);
 	axienet_unlock_mii(lp);
+	if (ret) {
+		dev_err(lp->dev, "axienet_device_reset() failed: %d\n", ret);
+		return ret;
+	}
 
 	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
 	if (ret) {
@@ -2604,11 +2608,6 @@ static const struct ethtool_ops axienet_ethtool_dmaengine_ops = {
 	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
 };
 
-static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
-{
-	return container_of(pcs, struct axienet_local, pcs);
-}
-
 static void axienet_pcs_get_state(struct phylink_pcs *pcs,
 				  unsigned int neg_mode,
 				  struct phylink_link_state *state)
@@ -2668,7 +2667,9 @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
-	    interface ==  PHY_INTERFACE_MODE_SGMII)
+	    interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_10GBASER ||
+	    interface == PHY_INTERFACE_MODE_25GBASER)
 		return &lp->pcs;
 
 	return NULL;
@@ -2814,6 +2815,9 @@ static void axienet_dma_err_handler(struct work_struct *work)
 
 	axienet_dma_start(lp);
 
+	/* This error handler runs only for the legacy embedded-DMA (1G) path,
+	 * whose mac_init() cannot fail, so its return value is not checked.
+	 */
 	lp->axienet_config->mac_init(ndev);
 
 	/* Sync default options with HW but leave receiver and
@@ -2917,6 +2921,7 @@ static const struct of_device_id axienet_of_match[] = {
 	{ .compatible = "xlnx,axi-ethernet-1.00.a", .data = &axienet_1g_config },
 	{ .compatible = "xlnx,axi-ethernet-1.01.a", .data = &axienet_1g_config },
 	{ .compatible = "xlnx,axi-ethernet-2.01.a", .data = &axienet_1g_config },
+	{ .compatible = "xlnx,xxv-ethernet-1.0", .data = &axienet_10g25g_config },
 	{},
 };
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
new file mode 100644
index 000000000000..46b48a773c15
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * XXV (10G/25G) support
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/netdevice.h>
+#include <linux/phylink.h>
+
+#include "xilinx_axienet.h"
+#include "xilinx_axienet_xxv.h"
+
+/* readl_poll_timeout() sleep interval (us) and 1 ms total timeout for GT
+ * reset-done and PCS block-lock polls. Values from ZynqMP/Versal bring-up;
+ * PG210 does not specify these bounds.
+ */
+#define XXV_LINK_POLL_INTERVAL_US	10
+
+/* Number of XXV (10G/25G) MAC registers exposed via ethtool -d.
+ * Covers configuration and status registers per Xilinx PG210.
+ */
+static const u32 axienet_xxv_reg_dump_offsets[XXV_REGS_N] = {
+	XXV_GT_RESET_OFFSET,
+	XXV_RESET_OFFSET,
+	XXV_MODE_OFFSET,
+	XXV_TC_OFFSET,
+	XXV_RCW1_OFFSET,
+	XXV_JUM_OFFSET,
+	XXV_VL_LENGTH_OFFSET,
+	XXV_TICKREG_OFFSET,
+	XXV_CONFIG_REVISION,
+	XXV_CONFIG_1588_OFFSET,
+	XXV_CONFIG_TX_FLOW_CTRL1_OFFSET,
+	XXV_CONFIG_RX_FLOW_CTRL1_OFFSET,
+	XXV_CONFIG_RX_FLOW_CTRL2_OFFSET,
+	XXV_CONFIG_RSFEC_OFFSET,
+	XXV_CONFIG_FEC_OFFSET,
+	XXV_AN_CTL1_OFFSET,
+	XXV_AN_CTL2_OFFSET,
+	XXV_AN_ABILITY_OFFSET,
+	XXV_LT_CTL1_OFFSET,
+	XXV_SWITCH_CORE_SPEED_OFFSET,
+	XXV_CONFIG_1588_32BIT_OFFSET,
+	XXV_TX_CONFIG_1588_OFFSET,
+	XXV_RX_CONFIG_1588_OFFSET,
+	XXV_GTWIZ_CTRL_OFFSET,
+	XXV_STATRX_STATUS0_OFFSET,
+	XXV_RX_STATUS_REG1,
+	XXV_STATRX_STATUS2_OFFSET,
+	XXV_STATRX_BLKLCK_OFFSET,
+	XXV_STAT_RX_RSFEC_STATUS_OFFSET,
+	XXV_STAT_RX_FEC_STATUS_OFFSET,
+	XXV_STAT_TX_RSFEC_STATUS_OFFSET,
+	XXV_STAT_TX_FLOW_CTRL1_OFFSET,
+	XXV_STAT_RX_FLOW_CTRL1_OFFSET,
+	XXV_STAT_AN_STS_OFFSET,
+	XXV_STAT_AN_LP_STATUS_OFFSET,
+	XXV_STAT_AN_LINK_CTL_OFFSET,
+	XXV_STAT_LT_STATUS1_OFFSET,
+	XXV_STAT_LT_STATUS2_OFFSET,
+	XXV_STAT_LT_STATUS3_OFFSET,
+	XXV_STAT_LT_STATUS4_OFFSET,
+	XXV_STAT_LT_COEFF0_OFFSET,
+	XXV_STAT_RX_VALID_CTRL_CODE_OFFSET,
+	XXV_STAT_CORE_SPEED_OFFSET,
+	XXV_STAT_TSN_OFFSET,
+	XXV_STAT_GTWIZ_OFFSET,
+	XXV_STAT_AN_LINK_CTL2_OFFSET,
+};
+
+/* Option table for setting up XXV Ethernet hardware options */
+static struct axienet_option xxvenet_options[] = {
+	{ /* Turn on FCS stripping on receive packets */
+		.opt = XAE_OPTION_FCS_STRIP,
+		.reg = XXV_RCW1_OFFSET,
+		.m_or = XXV_RCW1_FCS_MASK,
+	}, { /* Turn on FCS insertion on transmit packets */
+		.opt = XAE_OPTION_FCS_INSERT,
+		.reg = XXV_TC_OFFSET,
+		.m_or = XXV_TC_FCS_MASK,
+	}, { /* Enable transmitter */
+		.opt = XAE_OPTION_TXEN,
+		.reg = XXV_TC_OFFSET,
+		.m_or = XXV_TC_TX_MASK,
+	}, { /* Enable receiver */
+		.opt = XAE_OPTION_RXEN,
+		.reg = XXV_RCW1_OFFSET,
+		.m_or = XXV_RCW1_RX_MASK,
+	},
+	{}
+};
+
+static bool axienet_xxv_ip_has_gtwiz_status(u32 ip_version)
+{
+	u8 minor = FIELD_GET(XXV_MIN_MASK, ip_version);
+	u8 maj = FIELD_GET(XXV_MAJ_MASK, ip_version);
+
+	if (maj == XXV_IP_VER_GTWIZ_MAJ_MIN)
+		return minor >= XXV_IP_VER_GTWIZ_MIN_MIN;
+	return maj > XXV_IP_VER_GTWIZ_MAJ_MIN;
+}
+
+/**
+ * axienet_xxv_setoptions - Set XXV MAC options from the option table
+ * @ndev: Pointer to the net_device structure
+ * @options: Option flags to apply
+ */
+static void axienet_xxv_setoptions(struct net_device *ndev, u32 options)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct axienet_option *tp = xxvenet_options;
+	u32 reg;
+
+	while (tp->opt) {
+		reg = axienet_ior(lp, tp->reg) & ~tp->m_or;
+		if (options & tp->opt)
+			reg |= tp->m_or;
+		axienet_iow(lp, tp->reg, reg);
+		tp++;
+	}
+
+	lp->options |= options;
+}
+
+/**
+ * axienet_xxv_probe_init - Initialize XXV-specific state at probe time
+ * @lp: Pointer to the axienet_local structure
+ */
+static void axienet_xxv_probe_init(struct axienet_local *lp)
+{
+	lp->xxv_ip_version = axienet_ior(lp, XXV_CONFIG_REVISION);
+}
+
+/**
+ * axienet_xxv_gt_reset - Pulse the XXV GT reset line
+ * @lp: Pointer to the axienet_local structure
+ */
+static void axienet_xxv_gt_reset(struct axienet_local *lp)
+{
+	u32 val;
+
+	/* Reset GT */
+	val = axienet_ior(lp, XXV_GT_RESET_OFFSET);
+	val |= XXV_GT_RESET_MASK;
+	axienet_iow(lp, XXV_GT_RESET_OFFSET, val);
+	/* Allow 1 ms for the GT reset to settle (see timeout note above) */
+	usleep_range(1000, 2000);
+	val = axienet_ior(lp, XXV_GT_RESET_OFFSET);
+	val &= ~XXV_GT_RESET_MASK;
+	axienet_iow(lp, XXV_GT_RESET_OFFSET, val);
+}
+
+/**
+ * axienet_xxv_poll_link_ready - Wait for XXV GT and PCS block lock
+ * @ndev: Pointer to the net_device structure
+ *
+ * Poll GT wizard reset-done on IP v3.2+, then RX PCS block lock. Block-lock
+ * failure is logged but not propagated: it depends on a live link partner and
+ * reference clock, so an unplugged cable must not fail device bring-up.
+ *
+ * Return: 0 on success, or a negative error if GT reset-done times out.
+ */
+static int axienet_xxv_poll_link_ready(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 val;
+	int ret;
+
+	/* Confirm XXV Ethernet is up: on IP v3.2+, wait for GT
+	 * reset-done before further register access, then poll until
+	 * RX PCS block lock is asserted.
+	 */
+	if (axienet_xxv_ip_has_gtwiz_status(lp->xxv_ip_version)) {
+		ret = readl_poll_timeout(lp->regs + XXV_STAT_GTWIZ_OFFSET,
+					 val,
+					 (val & XXV_GTWIZ_RESET_DONE) == XXV_GTWIZ_RESET_DONE,
+					 XXV_LINK_POLL_INTERVAL_US,
+					 DELAY_OF_ONE_MILLISEC);
+		if (ret) {
+			netdev_err(ndev, "XXV MAC GT reset not complete! Cross-check the MAC ref clock configuration\n");
+			return ret;
+		}
+	}
+
+	ret = readl_poll_timeout(lp->regs + XXV_STATRX_BLKLCK_OFFSET,
+				 val, (val & XXV_RX_BLKLCK_MASK),
+				 XXV_LINK_POLL_INTERVAL_US,
+				 DELAY_OF_ONE_MILLISEC);
+	if (ret)
+		netdev_err(ndev, "XXV MAC block lock not complete! Cross-check the MAC ref clock configuration\n");
+
+	return 0;
+}
+
+/**
+ * axienet_xxv_mac_init - XXV MAC-specific bring-up after the DMA reset
+ * @ndev: Pointer to the net_device structure
+ *
+ * Return: 0 on success or a negative error number otherwise.
+ */
+static int axienet_xxv_mac_init(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	int ret;
+
+	ret = axienet_xxv_poll_link_ready(ndev);
+	if (ret)
+		return ret;
+
+	lp->options |= XAE_OPTION_FCS_STRIP;
+	lp->options |= XAE_OPTION_FCS_INSERT;
+
+	return 0;
+}
+
+static void axienet_xxv_phylink_set_capabilities(struct axienet_local *lp,
+						 struct phylink_config *cfg)
+{
+	u32 core_speed;
+	bool rtsw;
+
+	core_speed = axienet_ior(lp, XXV_STAT_CORE_SPEED_OFFSET);
+	/* Bit[1:0]: 00=25G, 01=10G, 10=runtime-switchable 25G,
+	 * 11=runtime-switchable 10G. A runtime-switchable core can operate at
+	 * either speed, so advertise both; a fixed core advertises only its
+	 * configured speed.
+	 */
+	rtsw = core_speed & XXV_STAT_CORE_SPEED_RTSW_MASK;
+
+	if (rtsw || (core_speed & XXV_STAT_CORE_SPEED_10G_MASK)) {
+		cfg->mac_capabilities |= MAC_10000FD;
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  cfg->supported_interfaces);
+	}
+
+	if (rtsw || !(core_speed & XXV_STAT_CORE_SPEED_10G_MASK)) {
+		cfg->mac_capabilities |= MAC_25000FD;
+		__set_bit(PHY_INTERFACE_MODE_25GBASER,
+			  cfg->supported_interfaces);
+	}
+}
+
+static void axienet_xxv_pcs_get_state(struct phylink_pcs *pcs,
+				      unsigned int neg_mode,
+				      struct phylink_link_state *state)
+{
+	struct axienet_local *lp = pcs_to_axienet_local(pcs);
+
+	state->duplex = DUPLEX_FULL;
+	state->an_complete = !!(axienet_ior(lp, XXV_STAT_AN_STS_OFFSET) &
+				XXV_AN_COMPLETE_MASK);
+	state->link = axienet_ior(lp, XXV_RX_STATUS_REG1) &
+		      XXV_RX_STATUS_MASK;
+
+	if (axienet_ior(lp, XXV_STAT_CORE_SPEED_OFFSET) &
+	    XXV_STAT_CORE_SPEED_10G_MASK)
+		state->speed = SPEED_10000;
+	else
+		state->speed = SPEED_25000;
+}
+
+static int axienet_xxv_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+				  phy_interface_t interface,
+				  const unsigned long *advertising,
+				  bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static const struct phylink_pcs_ops axienet_xxv_pcs_ops = {
+	.pcs_get_state = axienet_xxv_pcs_get_state,
+	.pcs_config = axienet_xxv_pcs_config,
+};
+
+/**
+ * axienet_xxv_get_regs - Dump XXV MAC registers for ethtool
+ * @lp: Pointer to the axienet_local structure
+ * @data: Buffer for register values (zeroed and sized by the caller)
+ */
+static void axienet_xxv_get_regs(struct axienet_local *lp, u32 *data)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(axienet_xxv_reg_dump_offsets); i++)
+		data[i] = axienet_ior(lp, axienet_xxv_reg_dump_offsets[i]);
+}
+
+static int axienet_10g25g_clk_init(struct axienet_local *lp)
+{
+	struct device *dev = lp->dev;
+	int ret;
+
+	/* The register, RX and GT DRP clocks are mandatory for MAC+PCS
+	 * operation, so fetch them as required.
+	 */
+	lp->axi_clk = devm_clk_get_enabled(dev, "s_axi");
+	if (IS_ERR(lp->axi_clk))
+		return dev_err_probe(dev, PTR_ERR(lp->axi_clk),
+				     "could not get AXI clock\n");
+
+	lp->misc_clks[0].id = "rx_core";
+	lp->misc_clks[1].id = "drp";
+
+	ret = devm_clk_bulk_get_enable(dev, 2, lp->misc_clks);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "could not get/enable XXV clocks\n");
+
+	return 0;
+}
+
+const struct axienet_config axienet_10g25g_config = {
+	.sw_padding = true,
+	.internal_pcs = true,
+	.regs_n = XXV_REGS_N,
+	.clk_init = axienet_10g25g_clk_init,
+	.setoptions = axienet_xxv_setoptions,
+	.probe_init = axienet_xxv_probe_init,
+	.gt_reset = axienet_xxv_gt_reset,
+	.mac_init = axienet_xxv_mac_init,
+	.get_regs = axienet_xxv_get_regs,
+	.phylink_set_caps = axienet_xxv_phylink_set_capabilities,
+	.pcs_ops = &axienet_xxv_pcs_ops,
+};
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h
new file mode 100644
index 000000000000..15a323ee05b2
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * XXV (10G/25G) support
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef XILINX_AXIENET_XXV_H
+#define XILINX_AXIENET_XXV_H
+
+#include <linux/bits.h>
+
+struct axienet_local;
+struct axienet_config;
+
+#define XXV_REGS_N		46
+
+/* XXV MAC Register Definitions */
+#define XXV_GT_RESET_OFFSET		0x00000000
+#define XXV_RESET_OFFSET		0x00000004
+#define XXV_MODE_OFFSET			0x00000008
+#define XXV_TC_OFFSET			0x0000000C
+#define XXV_RCW1_OFFSET			0x00000014
+#define XXV_JUM_OFFSET			0x00000018
+#define XXV_VL_LENGTH_OFFSET		0x0000001C
+#define XXV_TICKREG_OFFSET		0x00000020
+#define XXV_CONFIG_REVISION		0x00000024
+#define XXV_CONFIG_1588_OFFSET		0x00000038
+#define XXV_CONFIG_TX_FLOW_CTRL1_OFFSET	0x00000040
+#define XXV_CONFIG_RX_FLOW_CTRL1_OFFSET	0x00000094
+#define XXV_CONFIG_RX_FLOW_CTRL2_OFFSET	0x00000098
+#define XXV_CONFIG_RSFEC_OFFSET		0x000000D0
+#define XXV_CONFIG_FEC_OFFSET		0x000000D4
+#define XXV_AN_CTL1_OFFSET		0x000000E0
+#define XXV_AN_CTL2_OFFSET		0x000000E4
+#define XXV_AN_ABILITY_OFFSET		0x000000F8
+#define XXV_LT_CTL1_OFFSET		0x00000100
+#define XXV_SWITCH_CORE_SPEED_OFFSET	0x00000138
+#define XXV_CONFIG_1588_32BIT_OFFSET	0x0000013C
+#define XXV_TX_CONFIG_1588_OFFSET	0x00000140
+#define XXV_RX_CONFIG_1588_OFFSET	0x00000144
+#define XXV_GTWIZ_CTRL_OFFSET		0x00000154
+#define XXV_STATRX_STATUS0_OFFSET	0x00000400
+#define XXV_RX_STATUS_REG1		0x00000404
+#define XXV_STATRX_STATUS2_OFFSET	0x00000408
+#define XXV_STATRX_BLKLCK_OFFSET	0x0000040C
+#define XXV_STAT_RX_RSFEC_STATUS_OFFSET	0x0000043C
+#define XXV_STAT_RX_FEC_STATUS_OFFSET	0x00000448
+#define XXV_STAT_TX_RSFEC_STATUS_OFFSET	0x0000044C
+#define XXV_STAT_TX_FLOW_CTRL1_OFFSET	0x00000450
+#define XXV_STAT_RX_FLOW_CTRL1_OFFSET	0x00000454
+#define XXV_STAT_AN_STS_OFFSET		0x00000458
+#define XXV_STAT_AN_LP_STATUS_OFFSET	0x0000045C
+#define XXV_STAT_AN_LINK_CTL_OFFSET	0x00000460
+#define XXV_STAT_LT_STATUS1_OFFSET	0x00000464
+#define XXV_STAT_LT_STATUS2_OFFSET	0x00000468
+#define XXV_STAT_LT_STATUS3_OFFSET	0x0000046C
+#define XXV_STAT_LT_STATUS4_OFFSET	0x00000470
+#define XXV_STAT_LT_COEFF0_OFFSET	0x00000474
+#define XXV_STAT_RX_VALID_CTRL_CODE_OFFSET	0x00000494
+#define XXV_STAT_CORE_SPEED_OFFSET	0x00000498
+#define XXV_STAT_TSN_OFFSET		0x0000049C
+#define XXV_STAT_GTWIZ_OFFSET		0x000004A0
+#define XXV_STAT_AN_LINK_CTL2_OFFSET	0x000009F0
+
+/* XXV MAC Register Mask Definitions */
+#define XXV_GT_RESET_MASK		BIT(0)
+#define XXV_TC_TX_MASK			BIT(0)
+#define XXV_RCW1_RX_MASK		BIT(0)
+#define XXV_RCW1_FCS_MASK		BIT(1)
+#define XXV_TC_FCS_MASK			BIT(1)
+#define XXV_RX_BLKLCK_MASK		BIT(0)
+#define XXV_GTWIZ_RESET_DONE		(BIT(0) | BIT(1))
+#define XXV_MAJ_MASK			GENMASK(7, 0)
+#define XXV_MIN_MASK			GENMASK(15, 8)
+/* IP v3.2+ exposes GT wizard status before other register access (PG210). */
+#define XXV_IP_VER_GTWIZ_MAJ_MIN	3
+#define XXV_IP_VER_GTWIZ_MIN_MIN	2
+#define XXV_AN_COMPLETE_MASK		BIT(2)
+#define XXV_STAT_CORE_SPEED_RTSW_MASK	BIT(1)
+#define XXV_STAT_CORE_SPEED_10G_MASK	BIT(0)
+#define XXV_RX_STATUS_MASK		BIT(0)
+
+extern const struct axienet_config axienet_10g25g_config;
+
+#endif /* XILINX_AXIENET_XXV_H */
-- 
2.25.1

