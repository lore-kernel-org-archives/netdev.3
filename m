Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC83E639B;
	Tue,  6 Oct 2026 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284785; cv=fail; b=kbWXwnvskHN4whp2e3wCpdkHllJVoLY29SyWyqwHgY2blSFf3yuqcKgQAeWNXdtQo9K0QJ2Lyu7Z6lGjFlYFQqQmyJpiHLCn7EmHnnAXE6Fw/w8R8xEyRHA0mfXyLL1IGof3JAVxqc8uwLxYKf4WxsefocnuWzcf5vk1Y+3Fx3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284785; c=relaxed/simple;
	bh=5aBsPh1GMGSfO/3UaC8Gy38jUl6LFfbOJJpSr6aQSZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpNZBwxzq2Ix2q2Ml15qKpw50snjG2JDCfTOPz8p1JM+kksCHrqTXZiq5zJfFOV+Bktv8J/A+P64MgT2yR3I5QIJBDZwTGWOuXq7ni4kSrQ0ksT/LJpBqO3TCJciq1R9xf2TKxML7X2DDMY5RqVuJtaBLDbfECEKmRoSFZC6Kzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JO6YtDK7; arc=fail smtp.client-ip=52.101.193.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JO6YtDK7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYraRqUSHNHQWae0LqOC61j20jzgcPPX0v+kZRSGTP+VyXV6guv+HD1duMA1jkKhTvVeAISXoJKuEShRisHyEVfsXs2xt9CEfe6u65iDLHvIe6JmXW/JcrNGmbBvuH6sQAKiatzXjNlyXY70/5zfdXlnzhhJ7nILmLwbRTKPV4KXoQjRgm1sVMXIk5TpNUHqxDA5txV4BUuaO3SY9M4Z9DrKHtkfi4gb3/q3odQ/IVBbW6XJpqVAaLSM4DC8iyGMV+DTG+/g353sfX94CXXKFt361TaS3ta7r9uJNtAz3GDSty6+OWb09gtbz7WF/bFMZd8qws7ddo05tEKEfyLJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JswQ2k67aCKgoGBVOQ68cnRJRElZkpZFJELivGH+wuo=;
 b=kvA8QkTgifYdh+y53iSEByoZ9Mj8sOi24H7WlQoRlq9YCmfe0i0DavifnbL85bvJJzFuucymCc85CtPUhQdVw/z5sjOajp9RuTRCdF8+i/I7Op4qqvrVpFOE9gJXwBvNHONejg9faPD5a8DKq1E6CdzffrekO3R5pbfcrhLjp2vcp4vVx9dJpefaEMjqGZxwzjU8JEuc/pH/54ZgtGJ1o+d/iakV6u2sI9DpF69ah26gqaIFRUsw1hrc4Gop7+6cePiv/VvpjS51/d3nfeFN3sTEAyHu34Eebnm7dZJPkEwiPAyxOZOXkrmDejPev/DmgYTMFojA30YrKK723cuK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JswQ2k67aCKgoGBVOQ68cnRJRElZkpZFJELivGH+wuo=;
 b=JO6YtDK7hMLIiUYpdkbg2rXMsXCQPNEnG6POH1GKRFG+3dGMKhAwJpY2jmi/UzMqPcU/Pq4z9uWv1ds18mhhtR/stbZjdz89oneqYME/VH982zKy/UPIWtYnP8cVW0Gs6LZcODhffgGkfGyeB4ed0FSRO5cwMPugwDHy3Wux6hI=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by DSAPR12MB820198.namprd12.prod.outlook.com (2603:10b6:8:51d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 11:06:16 +0000
Received: from IA0PEPF00000040.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::64) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 11:06:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000040.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 11:06:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:06:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 06:06:07 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 06:06:03 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Michal Simek <michal.simek@amd.com>, Russell King <linux@armlinux.org.uk>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 3/6] net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
Date: Tue, 6 Oct 2026 16:35:47 +0530
Message-ID: <20261006110550.1990213-4-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006110550.1990213-1-suraj.gupta2@amd.com>
References: <20261006110550.1990213-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000040:EE_|DSAPR12MB820198:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c625ec-d32a-4101-2093-08df2399d71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|11063799006|10067099003|6133799003|56012099006|18002099003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info:
	4KdfKWjo80hOA8n8G3pzxRxIy5jj4NixD9olem2XSUW7fF0LfzJbrjBCutIbZiJv3z9Jmbl4zEk2UJGItMk+yt1tr1RM1810qLTSomdl//yUZYZNZu4O45DMJKALOZdeeWJ7d1EIpIGxEqRR0Uedj4oBtNrYhqurn84E0aJJNhOgpCok5hoZNEU8ct67bv9w+BKIT8siQZgBP4c/gsf5VP2k9wMoz68tHp9pa1dHSr58vEMEE94ErAXID+6fAnaoqX0vqGeC385TjdIw4H7l4zoMWdQBiz4wSvWydxMI5xoK7UQRNLj127mI1prWnfJittaHhgew7mJ6G36dPGYaPSc9l69EDCzc+kFZSFLiinFURlq3TJjPgh0Fy1CAQlP1d33vTs5px09jsrr8TaQxiBS6j7p6qeNs63I6bLfEHRoW8A+ppW/5ar19fsrSWNOSPz9S8gc/+u5YWTq+faTc6GY/aEBZcP+f9CmsN/Wd2JXMt9PORpcnATc/KTd7L5CbJJ9hRE+tb9Tf3bb5deE9GgoaXztmWbkzyAqcu0RE7yDrjccfZIaINNsXHyQ1ZnrPIWY6Cx2XNhy7mjtQUth4///QqFNCufswjdzAvnVtY2UFNvGhaZsvDQTTy5FdyNHyz0GNCvApQqPAGreovEWC84Vw9hGP7XH3E3pORUOg+JixaEbHxvnlQWmVtk5Wz73ciCC7XWHEx64opXuMO/TzVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(13003099007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Utd0A72+COFVr0y5+xmCcra2Vd14WnFhbM+747jLvWZ172JBLLJ9frA0bNLsJFsF6MpwVImqW/WnVDLjWKSH3RsDH1i7dDRzSnjVrjuwp8NDGIbonY/TLBD7wSiDVEAR/OMrEdQsp+zFiBHw1MsS8rLQOGbTLHp/sba2+ob5gjfNzWv2L/9qCethNULi/lEZm2LKuTurfiV2UfEYUD21WP6NRXpnI7+AdRX+JdCxtoCLFDXlamiMw/rvJIHpyuFUbFyL7AEmnI1X79xu/Q6XQfCe7Slt/e5VqSo5D+5OFL+Ul3jzkBe8u5fFTffW+62AOMJRBIc40+W+Kiio2DnD/FI/hG/mIF1ytvq34ntwtsn41UK9FgrCY19qgmUYlilFvvFiB47wuKjQeaLP8fCgXr0qh8OVeWOrcAXcA1Me8XMREKsp2NAkdE2dfFPJxSAw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 11:06:15.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c625ec-d32a-4101-2093-08df2399d71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB820198

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
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 323 ++++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  |  86 +++++
 5 files changed, 431 insertions(+), 7 deletions(-)
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
index 591eb57fad25..c4edf2c36b06 100644
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
index 43a3f8dedbbd..5c9cf61e6855 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1706,6 +1706,10 @@ static int axienet_open(struct net_device *ndev)
 	axienet_lock_mii(lp);
 	ret = axienet_device_reset(ndev);
 	axienet_unlock_mii(lp);
+	if (ret) {
+		dev_err(lp->dev, "axienet_device_reset() failed: %d\n", ret);
+		return ret;
+	}
 
 	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
 	if (ret) {
@@ -2605,11 +2609,6 @@ static const struct ethtool_ops axienet_ethtool_dmaengine_ops = {
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
@@ -2669,7 +2668,9 @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
-	    interface ==  PHY_INTERFACE_MODE_SGMII)
+	    interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_10GBASER ||
+	    interface == PHY_INTERFACE_MODE_25GBASER)
 		return &lp->pcs;
 
 	return NULL;
@@ -2815,6 +2816,9 @@ static void axienet_dma_err_handler(struct work_struct *work)
 
 	axienet_dma_start(lp);
 
+	/* This error handler runs only for the non-dmaengine flow (1G MAC),
+	 * whose mac_init() cannot fail, so its return value is not checked.
+	 */
 	lp->axienet_config->mac_init(ndev);
 
 	/* Sync default options with HW but leave receiver and
@@ -2918,6 +2922,7 @@ static const struct of_device_id axienet_of_match[] = {
 	{ .compatible = "xlnx,axi-ethernet-1.00.a", .data = &axienet_1g_config },
 	{ .compatible = "xlnx,axi-ethernet-1.01.a", .data = &axienet_1g_config },
 	{ .compatible = "xlnx,axi-ethernet-2.01.a", .data = &axienet_1g_config },
+	{ .compatible = "xlnx,xxv-ethernet-1.0", .data = &axienet_10g25g_config },
 	{},
 };
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
new file mode 100644
index 000000000000..9f7efab84f82
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
@@ -0,0 +1,323 @@
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
+
+	core_speed = axienet_ior(lp, XXV_STAT_CORE_SPEED_OFFSET);
+	/* Bit[1:0]: 00=25G, 01=10G, 10=runtime-switchable 25G,
+	 * 11=runtime-switchable 10G. Bit 0 is the active rate. Advertise
+	 * only that rate.
+	 */
+	if (core_speed & XXV_STAT_CORE_SPEED_10G_MASK) {
+		cfg->mac_capabilities |= MAC_10000FD;
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  cfg->supported_interfaces);
+	} else {
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

