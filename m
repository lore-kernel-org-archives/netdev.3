Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAA4FDE6C;
	Wed,  9 Sep 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963701; cv=fail; b=pjfdUldbf/C6kgY2RMkU4LD2S5lXuztgw5k2yxNEoXovX6Y81rJjqubCBXHzAQggeDQUiSgLKhKQnbORmsHtjIrMSq4vnV3QSdcB/81pG8/Y9OHZ1GV+AkbwWVYPgXLijZ65S9BIBmml0NTJ53kfFZB4ZLOa5TBnCwab0zVK/Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963701; c=relaxed/simple;
	bh=0WmLsdwcaxue37QYZyE+IXGr0RVVK4X0Sf1TF0nbCzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lp299lV+JU50c6Bg5OtIz4hm3rTkapT821aBmjgJ9HEzG1HxAkztuzlXfEPopDnOoAmuXzJhHtCppO0W70CeH7TWDQxYv9Y9R83YZZou13Nkw5Q9S5SukQsz/fN74J/86WbMzElvZldG6q0t3JPLRiXADdW6hNO4WuhCkuKUgbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2EUX5tD; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2EUX5tD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivw7R/MKala4J+B2SsXx6s9tRHOChoGX9MwUHVylIb9eowohsAosKbwXjLV5ko5cD4ZP5xKlQXp4QQkKT3aeuZDwGYa1+WILVEUlc8ca936Ysi7tMvf4RUunkL/810XZpCSlGXasKHzWg6nHgJsUMMqoz/18aY/2lwVfysgQqnrDGtHlAPOttyAmdrzcMZ5tW2qWlQpHFkMcDF9xZ6lu8MGJ7Xh8VvLIJRs8j9cCP4dydO9pwB+xb5PTbNO5YytWKizq2Q5Q1T2qolOg0ReKB3lmNwTh8PG9isF2u2PiN5A0kUA9SNr4aPii2u/xKpFqTgMtGeZHesqRg2QJXDGc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NigIkL758h7pcAEQtuknZ30I0V3RSsgMxXUGB3nzik=;
 b=CzQbcIUCazNYh/Du6tFH8TTnwNxcRvbcR2C35fD6F5mW8chEYT1IFuIY+LOEagktVym40eyAWP40HsXn9gTsWCuKqVI/ckpiC3CNlqdx9IV+vuWJDdc6kj5cJNkW5AK+z8ZKY7g3xylttvU994NWUlEH6PE8T56RHOvo4bu+CYju8hU3xi7z9SJ5I6qHvEO02/bJamrfNfpzJoXVJ2lbNOPJ04vQEY9UnpU1mn/Wcu0aAmCoQ9VGIdNeeMvDKe9WzcX8j5I353RdFm7bLP6klZxv7tkndezfW5hOMN2Ji3Sg6DFkCNRY5+S/TGIB0zjt81i7N3fhyebEpQ+qq0J49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NigIkL758h7pcAEQtuknZ30I0V3RSsgMxXUGB3nzik=;
 b=h2EUX5tDjOutm4Q9H9s1PfA21To4ZHzIT6apcWeGMiYFgszgHZrXyfidJh7pTHB6sAi/Chkf0/gAUUNd9cVXz1rYzEkU0Xiu9/1ii5Lo5qsiFpAb5oXxNxAuE5RFrFPH+b7ctTT2ii6Ek9JDLbTPBmTMox4+7fAkOeaKrkeIkY0=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:21:37 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::61) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Wed, 9
 Sep 2026 14:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 14:21:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 09:21:13 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 09:21:10 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload support
Date: Wed, 9 Sep 2026 19:50:56 +0530
Message-ID: <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 8768f9df-2848-4e80-acff-08df0e7da8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SLrQ/EVPmzyMW61BeAncZwI+5ffWm0AnpAV09uicewcb0YZ4q03xjQkQfB1UCov6I4jxkfX5zeCuuD37ylJhjeAPHOgRlAzRHlIMG9wONjwJgI2pVgUgNNVLquxhLLtRJ/cl5kLnblAfsDPqMdsupcw/qC3RiiKNjewcv7kxipOtOcvkZ2K2Vo7VLGZEffcds463tnnDxPytm4wrAGlWG8CprbRADaIedQhmHVpAaNoI3SCLSyscmdd7vl22QCtf9YzCa2DxTAt26xQg9cS1srln/eFgXlAb9qYX6ZD2xoWUf5G9SbawYoxb+TDCyfU1y072a6eiPNUvtf+4HamXXqnEbOV9J7qK0hGsqSDh8FcnYHAu4IqcZEzEmZf+ML1yFdIVxivDpX4/jR97PYxu+w/yeeL2lsLV+vtSWyOE8kNu+JT5r8TNEY5FrR40RiNwIyffuNqIY6IlNujDeakmn7I8FtwOGdelpVLXOpVvk1pyR3fomdWE8gG2HKA9rlihdy/lOP655ZG3HVdp3Sv/PaY0yqILOfApypIEDmnq6Fifn5szvAn6dCkiImQP3DwKuI9473mE/e9qX1lcEf1RvA4GMssN2j+ZvvVjO99m4d8GJQ2cN0nR2eJkM1XSNIyvqtXlUxM2vEtBfC86aS+AXjzuDFouynlhfJHr9QAwNxRvdEh86mevf2rvB87EoCe6ZhOZlf14NU5nBkVnD2VcTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jao0KbNRI5t7Zs6ZGKTscWyV99yKecJlnmgb5k1IzAEAaWM992MwN/v7TTIvlbZe9soNEsGfbm2vUwh1HAFeMgw0f43cnUEU1iq/9pBwbaqWpdPNz+W6TltNR+Sz5506BGz71TBqZkGNpP7cvXbsWBODb9mqG75az3bLbxiMaJ3hkjvROnm4loYHvZgQKpKHFFpgAWyb78QzdX+BvdRDTO4ZhCNYDpYf29zGIBmbxUoHZLdmXdtCWH4Zc8P6fgSYyhWk1EJAJKfBLwmDQRK2wPk20pSfrOhWLLC3SVDpfQIzw3BvWTfBlrQvujtdTneLw+J8wPMwz/Z5gBIE8IrfAaCH6Bem3b0E4Nk3/rOe54SKk86+w8Nm67d+fWZmIBnwuz0Ku2CLV+jmViHCxjb/dKN/nb1cowKjx0BnH0ayvMALkh5u7O5Rv5j/Rr2Vb8/H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:21:37.2299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8768f9df-2848-4e80-acff-08df0e7da8ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609

Add Credit-Based Shaper (CBS/IEEE 802.1Qav) TC offload support for
time-sensitive networking on GEM hardware. CBS is restricted to the
two highest-priority queues: Queue A (num_queues - 1) and Queue B
(num_queues - 2), matching hardware capability.

Validate that idleslope is positive and does not exceed the link
speed, preventing negative values from bypassing the bounds check
due to signed-to-unsigned promotion.

The idle slope register value is computed differently based on hardware
variant:

  High-speed GEM: scale idleslope linearly to the full 32-bit register
  range relative to link speed.

  Standard MACB: convert the kbps idleslope into the register's native
  unit, which depends on the interface width:
    - 1G (8-bit GMII):    bytes/sec,   scale kbps by 1000/8 (125)
    - 10/100M (4-bit MII): nibbles/sec, scale kbps by 1000/4 (250)

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v2:
- macb_cbs_get_queue_params() now returns the idleslope register offset
  (u32 *idleslope_reg) instead of a bool flag, and the idleslope is
  programmed via bp->macb_reg_writel(), dropping the per-queue if/else
  that open-coded gem_writel(CBS_IDLESLOPE_Q_A/Q_B).
- Expanded the idleslope kbps-to-hardware-unit conversion comment.
- Zero-initialize kset in macb_cbs_add() so an unpopulated link speed
  reads as 0 and is rejected; reorder locals to keep the declarations
  in reverse-christmas-tree order.
- Rebased on net-next, which renamed the struct net_device pointer to
  "netdev" (was "dev"/"ndev").

 drivers/net/ethernet/cadence/macb.h      |   9 ++
 drivers/net/ethernet/cadence/macb_main.c | 116 +++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index f5359549f3d4..20faeba77d6d 100644
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
index 67150ff03066..00c1c619dea8 100644
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
@@ -4492,6 +4496,116 @@ static int macb_setup_taprio(struct net_device *netdev,
 	return err;
 }
 
+static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
+				     u32 *enable_bit, u32 *idleslope_reg)
+{
+	/* Queue A is highest priority (num_queues - 1) */
+	if (queue_num == bp->num_queues - 1) {
+		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_A);
+		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_A;
+		return 0;
+	}
+
+	/* Queue B is second highest priority (num_queues - 2) */
+	if (queue_num == bp->num_queues - 2) {
+		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_B);
+		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_B;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int macb_cbs_add(struct net_device *netdev,
+			struct tc_cbs_qopt_offload *qopt)
+{
+	u32 enable_bit, idleslope, speed_kbps, ctrl, idleslope_reg;
+	struct ethtool_link_ksettings kset = {};
+	struct macb *bp = netdev_priv(netdev);
+	int err;
+
+	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &idleslope_reg);
+	if (err) {
+		netdev_err(netdev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
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
+		netdev_err(netdev, "CBS: Invalid link speed\n");
+		return -EINVAL;
+	}
+
+	speed_kbps = kset.base.speed * 1000;
+
+	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
+		netdev_err(netdev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
+			   qopt->idleslope, speed_kbps);
+		return -EINVAL;
+	}
+
+	/* qopt->idleslope is in kbps; convert to the units the hardware
+	 * register expects:
+	 * - High-speed GEM: fraction of port bandwidth, scaled to the full
+	 *   32-bit register range
+	 * - Standard MACB: the register counts bytes/sec in 1G (8-bit GMII)
+	 *   mode and nibbles/sec in 10/100 (4-bit MII) mode, so scale kbps
+	 *   by 1000/8 (125) or 1000/4 (250) respectively
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
+		bp->macb_reg_writel(bp, idleslope_reg, idleslope);
+		/* Re-enable CBS for the queue with new idleslope */
+		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
+	}
+
+	netdev_dbg(netdev, "CBS: Configured queue %d with idleslope 0x%x\n",
+		   qopt->queue, idleslope);
+
+	return 0;
+}
+
+static void macb_cbs_destroy(struct net_device *netdev, u8 queue_num)
+{
+	struct macb *bp = netdev_priv(netdev);
+	u32 enable_bit, idleslope_reg;
+
+	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &idleslope_reg))
+		return;
+
+	scoped_guard(spinlock_irqsave, &bp->lock) {
+		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
+		bp->macb_reg_writel(bp, idleslope_reg, 0);
+	}
+
+	netdev_dbg(netdev, "CBS: Disabled queue %d\n", queue_num);
+}
+
+static int macb_setup_cbs(struct net_device *netdev,
+			  struct tc_cbs_qopt_offload *qopt)
+{
+	if (qopt->enable)
+		return macb_cbs_add(netdev, qopt);
+
+	macb_cbs_destroy(netdev, qopt->queue);
+	return 0;
+}
+
 static int macb_setup_mqprio(struct net_device *netdev,
 			     struct tc_mqprio_qopt_offload *mqprio)
 {
@@ -4571,6 +4685,8 @@ static int macb_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	switch (type) {
 	case TC_SETUP_QDISC_MQPRIO:
 		return macb_setup_mqprio(netdev, type_data);
+	case TC_SETUP_QDISC_CBS:
+		return macb_setup_cbs(netdev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return macb_setup_taprio(netdev, type_data);
 	default:
-- 
2.43.0

