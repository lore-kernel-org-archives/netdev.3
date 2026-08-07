Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A13F823E;
	Fri,  7 Aug 2026 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096250; cv=fail; b=Jbn373UFy8XDPjE826LUb/u+FhC/DxripJ2BVPo9LDEVP0jQ5FKC1cpfsaGhPNgR+vsOkGNPNwKmPzGZjaaW+TzwXkI7Zr5AQGg/eGD/Xja8XquF52nIs2W2sVSmREHhVN0FTAAdP4Cz0L2n0ITzs9THYyvt5TzS9mNwjV8uKRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096250; c=relaxed/simple;
	bh=czV+8XHY1SSDsW/dccm+8gGpjjV213OxYW7C4MXoXRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9PrBv3TUMx0vhX5AQhnIjyTbOZ2V2qhf+LW+/QaYYan8nBplikDCkF8iqoIEcRucjE038zqWROCAeIv9dY2iU8T9sRSL/xVDutEweELq6YcrWSyNrZC2sacjzbQ++QbfTFFrUtWUivmj0YnNj93PL/W675/7cyqfalho7asx24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZgYP+KH; arc=fail smtp.client-ip=52.101.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZgYP+KH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ldk/as/YQa/O636keEc44LhIBeFvJpKN3163tAiBBlpchqf5v34v8m4AwtdCKSu64Ea6gJLIQ6keOeDAxu23nzAJt28jfmB5YsSgXoHrDE6ba27s9VeIbmy5qhjLsv1p4UkGWbZ6RyiNUw0bntfrsusCspLGVjA9NIQEcIaVFggG8O1w2MXXJ468oy77jt8K3VgJ+5wDxUwTrc9Eox0d/s7KtO34ieevTnXbMjyrDH7EiDLJvjnC/IG8mmXqtU0DRn99nidiZeBWU7R6gFtBFw8v3fa7kVRxi0m+pgANl+EPlFUI7h2frgkYlEh2jYBxyVlPNjtluIliWTRWN3hd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SSuR5LNJj9qtvA5V2Ns+rN+mL1X8mHZzc40O5Ak2fA=;
 b=ebb5Lt7NJfKSpuPdEXrnTiCUnzz5Vsy3UG10qasuAKCC0tTvnLEfwtOA1AzpCK9HikwY4SjCza/FE/kM0YA5zfRPZA0gzlpqiH73ThJXQ9//CYbuHKmb5WdMLcs1/N3xsk2ES+Snb4BN6nbFVwGQ0X7q8u2F/vTguREawu0UVoGq3d0Mf6NfIf5wivRcCiOgEvch1wAK7Usq2VbpXpjdS4NbrG+Db1KRk+KJUatlc4W/ITto45qcHlWFSW16vtx7WvyXG6mE9NDlwyCiouMGoS7ZqnDVEbcTsEklTn/bEVc89L2B3WenQe2omp3CS2fFeSSl4Ly5KCy96HZYOBPOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SSuR5LNJj9qtvA5V2Ns+rN+mL1X8mHZzc40O5Ak2fA=;
 b=lZgYP+KHYNwfniudjTiGY4AXII8nlaZpL5prG2YirPDv/FOo/4k3y9/ekjQOG9DY2e/rl6aQ8Q1G9asIxSbzaIm90f1iDBpeE5upMOLqqEExp0T1nV9fnXeFCILv+Ksbm5DHeCDldY3YgiSPbsU7395fqHaknlAZPbZ+VBXoLA8=
Received: from MN2PR06CA0030.namprd06.prod.outlook.com (2603:10b6:208:23d::35)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 09:50:43 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::aa) by MN2PR06CA0030.outlook.office365.com
 (2603:10b6:208:23d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 09:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 09:50:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:29 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 04:50:26 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 4/4] net: macb: Add TSN CBS TC offload support
Date: Fri, 7 Aug 2026 15:20:12 +0530
Message-ID: <20260807095012.640223-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e575ec-0d70-402e-ecdb-08def46958b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3f4z/oDqg49G1kjr32ZMDMBmcdXcfKeFFw8CE9x4pteakDd2wpiAd5zMiVo5Oz/0H98JI65OuUqbvKjhboWvNAdtzqtOtdcJHpdxLyuV+MeUZLDQE0K5hMZnhTZ3h+xttR2EDenaOaRuVzoNeo8qxFMx3TH+MdqgBMxw5uHFmsra1dHHbV57OQWX6l3SH2BARE/NxVwdT8++G5VvU/bswYT9Zu6z3p9UhD/fV8ifbMd3fEQEMOt/kdy0uKzupHslDo7XnI1jrRCA5xZ3a+FBXDtK4fN40Zp0hrsSndltlxKIiAtp1CElLSW85ByGYH3LcV1TKXXONso6dVBM6uqO7Gq/BrYjOcKalzGjiJeCFteWgNgf8xgIjbJpaFBf35gFmb2m0RFkLPkoniKT3uemkRur214EQ2R2v8Lu4zzob+olnKxjhCMNG9RX6WUys/SyQUjgC+/3cJDGRDgcIM1OYLI6yNXVRRMsCtCHn0xYNc2667wk+QCtikIOt+MybIqnRQ3SXsWq1ad48rLUTg68u/UM1DQ3eOZB+as8Q8rkSukLlB8UY0UUImr5w4jLLMUr5dUfR5PiBOdoF3IAiUVfWmxPaTPxpVNa4b5oalchKtS5ZMDgTIv/c0dZbKLalGn9CblnHryQzeLR8OX9dwmBoqNLQkW6kbnKg6on1a+fGaEkqKw8MM1sBLeqn8GXzZP7B2c0rZYNGMzyVW6cwmah3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b1RVWCsWLoCwWB06ELrew9TjgLK+XLUsKDshGZgdyK/wUYlnZ46zR3BM9rHBugMn6//sH7W16NkFbhfbWqaMmm39Nf0IiXsRXhpMhodqlKl2V/hgB04LDoqN1Z1vo9kpwzDsAB0nUD753j+XrDgVxD8Ay+ssfoJipTFccYw4zmDsHXOA/VIEKmnNPB1hiHe7OuuVXo0Jy4EfarQj/ey0qwsfAba54d4Piz+PJOYzwjScDDHMqeZdLR/dp6Q/gC8qd+r/sQb5pIjKxG2dA/AGLHuH2pkeV8SFEngBYlC8Ulns+mK88mPNUvKPD6vDooqj8GJeZolKK1WTC+fR+SNVXtuilduoCmlj3P4/Z+x5xvV/EFFK2FPu4UDIC0wMUpgZzgdqW2XwXz+Td9YI08uPhh0cgj+qWqpRtXYigrrPfDPbgjDbB4USHvHeDqU4QM5I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 09:50:42.9886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e575ec-0d70-402e-ecdb-08def46958b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639

Add Credit-Based Shaper (CBS/IEEE 802.1Qav) TC offload support for
time-sensitive networking on GEM hardware. CBS is restricted to the
two highest-priority queues: Queue A (num_queues - 1) and Queue B
(num_queues - 2), matching hardware capability.

The idle slope register value is computed differently based on hardware
variant: high-speed GEM scales idleslope linearly to the full 32-bit
register range relative to link speed, while standard GEM multiplies
by a port rate factor derived from the interface width (125 for 1G
GMII, 250 for 10/100M MII).

Validate that idleslope is positive and does not exceed the link
speed, preventing negative values from bypassing the bounds check
due to signed-to-unsigned promotion.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |   9 ++
 drivers/net/ethernet/cadence/macb_main.c | 121 +++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index f24df25923d7..d5b28459fd75 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -184,6 +184,9 @@
 #define GEM_DCFG8		0x029C /* Design Config 8 */
 #define GEM_DCFG10		0x02A4 /* Design Config 10 */
 #define GEM_DCFG12		0x02AC /* Design Config 12 */
+#define GEM_CBS_CONTROL		0x04BC /* CBS Control Register */
+#define GEM_CBS_IDLESLOPE_Q_A	0x04C0 /* CBS IdleSlope Queue A */
+#define GEM_CBS_IDLESLOPE_Q_B	0x04C4 /* CBS IdleSlope Queue B */
 #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
 #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
 #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
@@ -224,6 +227,12 @@
 #define GEM_ENST_ON_TIME(hw_q)		(0x0820 + ((hw_q) << 2))
 #define GEM_ENST_OFF_TIME(hw_q)		(0x0840 + ((hw_q) << 2))
 
+/* Bitfields in CBS_CONTROL */
+#define GEM_CBS_ENABLE_QUEUE_A_OFFSET	0
+#define GEM_CBS_ENABLE_QUEUE_A_SIZE	1
+#define GEM_CBS_ENABLE_QUEUE_B_OFFSET	1
+#define GEM_CBS_ENABLE_QUEUE_B_SIZE	1
+
 /* Bitfields in ENST_CONTROL */
 #define GEM_ENST_DISABLE_QUEUE_OFFSET	16
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 00355cc4b434..a0a68490519e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -99,6 +99,10 @@ struct sifive_fu540_macb_mgmt {
 
 #define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
 
+/* CBS port transmit rate factors: 1000/interface_width */
+#define MACB_CBS_PORT_RATE_1G		125	/* 1000/8 for GMII (8-bit) */
+#define MACB_CBS_PORT_RATE_10_100M	250	/* 1000/4 for MII (4-bit) */
+
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
  *
@@ -4515,6 +4519,121 @@ static int macb_setup_taprio(struct net_device *ndev,
 	return err;
 }
 
+static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
+				     u32 *enable_bit, bool *is_queue_a)
+{
+	/* Queue A is highest priority (num_queues - 1) */
+	if (queue_num == bp->num_queues - 1) {
+		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_A);
+		*is_queue_a = true;
+		return 0;
+	}
+
+	/* Queue B is second highest priority (num_queues - 2) */
+	if (queue_num == bp->num_queues - 2) {
+		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_B);
+		*is_queue_a = false;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int macb_cbs_add(struct net_device *ndev,
+			struct tc_cbs_qopt_offload *qopt)
+{
+	u32 enable_bit, idleslope, speed_kbps, ctrl;
+	struct macb *bp = netdev_priv(ndev);
+	struct ethtool_link_ksettings kset;
+	bool is_queue_a;
+	int err;
+
+	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &is_queue_a);
+	if (err) {
+		netdev_err(ndev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
+			   qopt->queue);
+		return -EINVAL;
+	}
+
+	/* idleslope is calibrated for the current link speed; CBS is not
+	 * reprogrammed on link-speed changes, so it must be reconfigured
+	 * if the link speed changes.
+	 */
+	phylink_ethtool_ksettings_get(bp->phylink, &kset);
+
+	if (!kset.base.speed || kset.base.speed == SPEED_UNKNOWN) {
+		netdev_err(ndev, "CBS: Invalid link speed\n");
+		return -EINVAL;
+	}
+
+	speed_kbps = kset.base.speed * 1000;
+
+	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
+		netdev_err(ndev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
+			   qopt->idleslope, speed_kbps);
+		return -EINVAL;
+	}
+
+	/* Calculate idleslope for hardware register:
+	 * - High-speed GEM: scale to full 32-bit register range
+	 * - Standard MACB: multiply by port transmit rate factor
+	 */
+	if (bp->caps & MACB_CAPS_HIGH_SPEED)
+		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
+	else
+		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
+					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
+
+	scoped_guard(spinlock_irqsave, &bp->lock) {
+		/* Disable CBS for the queue before updating idleslope */
+		ctrl = gem_readl(bp, CBS_CONTROL) & ~enable_bit;
+		gem_writel(bp, CBS_CONTROL, ctrl);
+		/* Update idleslope for the queue */
+		if (is_queue_a)
+			gem_writel(bp, CBS_IDLESLOPE_Q_A, idleslope);
+		else
+			gem_writel(bp, CBS_IDLESLOPE_Q_B, idleslope);
+
+		/* Re-enable CBS for the queue with new idleslope */
+		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
+	}
+
+	netdev_dbg(ndev, "CBS: Configured queue %d with idleslope 0x%x\n",
+		   qopt->queue, idleslope);
+
+	return 0;
+}
+
+static void macb_cbs_destroy(struct net_device *ndev, u8 queue_num)
+{
+	struct macb *bp = netdev_priv(ndev);
+	bool is_queue_a;
+	u32 enable_bit;
+
+	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &is_queue_a))
+		return;
+
+	scoped_guard(spinlock_irqsave, &bp->lock) {
+		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
+		if (is_queue_a)
+			gem_writel(bp, CBS_IDLESLOPE_Q_A, 0);
+		else
+			gem_writel(bp, CBS_IDLESLOPE_Q_B, 0);
+	}
+
+	netdev_dbg(ndev, "CBS: Disabled queue %d\n", queue_num);
+}
+
+static int macb_setup_cbs(struct net_device *ndev,
+			  struct tc_cbs_qopt_offload *qopt)
+{
+	if (qopt->enable)
+		return macb_cbs_add(ndev, qopt);
+
+	macb_cbs_destroy(ndev, qopt->queue);
+	return 0;
+}
+
 static int macb_setup_mqprio(struct net_device *ndev,
 			     struct tc_mqprio_qopt_offload *mqprio)
 {
@@ -4594,6 +4713,8 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	switch (type) {
 	case TC_SETUP_QDISC_MQPRIO:
 		return macb_setup_mqprio(dev, type_data);
+	case TC_SETUP_QDISC_CBS:
+		return macb_setup_cbs(dev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return macb_setup_taprio(dev, type_data);
 	default:
-- 
2.44.4

