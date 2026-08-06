Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C937D133;
	Thu,  6 Aug 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039981; cv=fail; b=r7WYscm2pHlTob8jzjfUFcJgKKLK5hgmP9rCVcYCZqsHCGGOfLBHJYdc49tjTDgv3RBfH6qqMHTpZ7ZaTYvQuus27CeuMVK12RhLBSD6RvwDdzNSX3AjgEH1TZwQcFsSaqdUskYGcLfuqvcqkDUDYi/qvIMUZig0zSBxPTmygRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039981; c=relaxed/simple;
	bh=UmcKNJjcpQo04U88CulqXHN5wLnBfMmTce8MmY16LN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCfk7WTC9GpdIJmEuV8WZ+aqsSg7kKEhqv/DCkkvREsYWJ+JiLm+jj27V0UazvoqvBNOrGgM8Mf5Orgp0E6qX/oQgH3PArrjL8E1QKBivOuVVHNBhbigctuxNYZpnTgKm9mKF9RBiJRKiNABCP30DxdS0Po48DCQrQ3hwPfsbs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RUmqjZNI; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RUmqjZNI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wocl7IBP+PLOCB2aEa/SV4EO9Nm6aQ/NKPrAHmal5HCg3gqsk3rFSQY0/5pEfw98GFdzxiiHv97RwYKYaD+T9mU2317z5Ho095zCx9V2D/KKTolblnrlPTpBL5xG5JoWjY6b5pSWD6NV488sclS+9Hl8vmIpI03cWHsnMnZuElOBpp8Gljqa/VDzgGwSSZpiNq6rOr99+R90UOTxtzZ7WlA3sjREgQa7X/kHj0SP8ryOFmUbrrgL9zna5f7xOd8Jv/g8eftjl2QWZzaHqCwA1MsNmRCGcbZx64fvKFvtB4ZswbNnzb1g1KKIfBlXi7GBy8luPiX6RfXLVp6Z8WpMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmcDYc7H0S6bH9oEkvwHBJoAArjFlGnTjn1pOTdkzQg=;
 b=oxwzXukNu/iBXTy09I+XkHB2/Q9kE8uNjHHmjtPTmVZxuPU88h1td5mVeVS3LyestkiAgMNy5wG/x6s0CiWLOPDqcSSvPcmqn+LZ5q2KogsixO0ibbixtSBq4XcyOZMP+3WhyfLHeoZqFAGqgKe59b1rXEpDtJ37qH5eYnKfuER5oG01vwfzZecv16n7Bls/P65qgw+1sXizZLzXW4TNVG5UIAjS5UXIokOj+Z9LjSe06YZL4X/uxaPKAP4QD1ftbZdGcodJxk001p3DOyKrvblQwRbt7OxUZAaCG8s6lntHyLfn6fQ7Q8IFSPUQ/+rs6y+2xIRAOvxN87HBLtN9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmcDYc7H0S6bH9oEkvwHBJoAArjFlGnTjn1pOTdkzQg=;
 b=RUmqjZNI1r2qqUedTUxGlEZpyILbt4bD8XpSzFNba03GMml7bJbNsA7FjeHAXImAPx4cC6YnajANjhdjurJkJhPKRZNhZwJ06DHqFQE1z08Jughg8486AXJAFXKTbCXSJ73X/E6BpIWJHR5mk6ZS1RwxTFVNDVPHfP9pP74bW08=
Received: from CH5P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::7)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.20; Thu, 6 Aug 2026 18:12:47 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::21) by CH5P223CA0009.outlook.office365.com
 (2603:10b6:610:1f3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 18:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:46 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:12:40 -0500
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
Subject: [PATCH net-next v2 6/7] net: xilinx: axienet: Dispatch statistics through axienet_config ops
Date: Thu, 6 Aug 2026 23:41:52 +0530
Message-ID: <20260806181153.1213996-7-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0bd34c-7e60-4cc1-75c1-08def3e651fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	eOfy4Vf5dgOP658xO3S7uZmgk0KGGT4uLYJYgc6EK0AWfsFW4rCnl0LtJe2s47rUKXUR2APONHimtOS3GUwLj2ewoSdNoxE4hXlLTxykflBcwKebGIiu+YDEmHm+D1TH3/32qEI2Ew62egPBWpAIhWAvYHqx4oZmQ0mFBM1O05WN9EWbDHId49nJOoVxsDTfxJFeiK3brgALi1nJgbDpzv/kWLr8M+DFICsryeBN95s6gZzPoqTS1gBo51KTqUKxmidLD5/28C05L9+u3qmkTcablZRKWNGwumAjW0KTxXLufPAyXe1ale1EoDMOEMzAm3e6tq8YvN/Fsg/rm3fPfSH8xFqOweWsXdIGEEJMPMk3koVkpGd9T+4t/nF3eJ6ToDJUwPP9+8SNOnz0vlb7Vl12I3mc9TuytqRv1bi1c2biQ77aaKE+1CFwk/BkCxgjEfRFR1/TrCSFu6ly67oPP/hhtQXpjtp9ZQY8pa+15TfJ7lg7Xmkup6n1vX2Fp4GfMUUla84SheD/4qW63LsErKTbDRT79PdSP/ucaqwqJNCRXUPRivgyMdqXiOsNuvoCoianfmIapmC76f98KhhjSvgn+cNNIM7xTRhLOvFXwHrOD/DwjiIZJdXvwOcK8U+slyI0LUlPQCGKjekpxwAqs6XawulOkMsP0CYE6BBP3mrw77asJu5FDs1NxVjH79idMj+tTX4sdhXWMIpSiUk2WnImrCM4ck5ewyvtqp9f6yDF1LqnwPnYsaIWmGekQh9v
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hJ51MPoQwQqzaxjrpsnosgxg9WqhwG87rGCGd7GOeJbzRgexDiAlNFJFvInA25kd9tA8u8Jyyw/n+0yvyR3/t2ZcJposYwHUj8dPH6Oj4uYjKsT1CDJ3uXqAZxKwK/oMtAk+tDidwUOQs0+tVyNJhH9hvHRTx/LRkx8nicMIIxKVso0GPalmP1KiPZ/K3EkQfvLkVh+B9DP5IsLnfpUjYk605oQT1L8lw0p3aD0IOpaxPhclY+AHoB7AEH3SWWdWP7Se0rAdQM6FSUrgW85mmgsWigoRX6NVuU5m7uQf/GEUatq+lE+xx2opTqVFz4S2ITuOgM0ZBqlTyAdDlfKwY4xWbxwY5g55sewoRY6kgt9E0Lf11AQ6TsnAX/JaEp1DGgUFNE7q9NGuQMKB7Oi3VXvhpByvBN0phsVVoyKte0zFD5U4656MKZDN7ISUbYAt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:47.6149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0bd34c-7e60-4cc1-75c1-08def3e651fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

The ndo_get_stats64() and ethtool statistics callbacks read the 1G MAC
hardware counters directly. Supporting a second MAC type this way would
require an "if (mactype == ...)" dispatch branch in each of the eight
statistics callbacks.

Add statistics operation function pointers to struct axienet_config and
route get_stats64, get_ethtool_stats, get_strings, get_sset_count,
get_pause_stats, get_eth_mac_stats, get_eth_ctrl_stats and
get_rmon_stats through them. Factor the existing 1G counter reads into
axienet_1g_*() helpers and populate axienet_1g_config with them.

A NULL op means the MAC does not expose that statistics group, so a MAC
without control-frame counters simply leaves get_eth_ctrl_stats unset
instead of open-coding the special case in the callback.

No functional change intended.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  23 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 171 +++++++++++++-----
 2 files changed, 146 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index a1d15b4797ce..f286c428343f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -658,6 +658,15 @@ struct axienet_local {
  * @phylink_set_caps: Callback to set phylink MAC capabilities
  * @pcs_ops: phylink PCS operations for this MAC, or NULL if unused
  * @stats_update: Callback to latch/accumulate the periodic MAC counters
+ * @get_stats64: Callback to read MAC counters into rtnl_link_stats64
+ * @get_ethtool_stats: Callback to read MAC counters for ethtool -S
+ * @get_strings: Callback to fill the ethtool -S statistic name strings
+ * @get_sset_count: Callback returning the number of ethtool -S statistics
+ * @get_pause_stats: Callback to read MAC pause-frame counters
+ * @get_eth_mac_stats: Callback to read IEEE 802.3 MAC counters
+ * @get_eth_ctrl_stats: Callback to read MAC-control frame counters, or NULL
+ *			if the MAC exposes no control-frame counters
+ * @get_rmon_stats: Callback to read RMON counters and histogram ranges
  */
 struct axienet_config {
 	bool mdio;
@@ -683,6 +692,20 @@ struct axienet_config {
 				 struct phylink_config *config);
 	const struct phylink_pcs_ops *pcs_ops;
 	void (*stats_update)(struct axienet_local *lp);
+	void (*get_stats64)(struct axienet_local *lp,
+			    struct rtnl_link_stats64 *stats);
+	void (*get_ethtool_stats)(struct axienet_local *lp, u64 *data);
+	void (*get_strings)(u8 *data);
+	int (*get_sset_count)(void);
+	void (*get_pause_stats)(struct axienet_local *lp,
+				struct ethtool_pause_stats *pause_stats);
+	void (*get_eth_mac_stats)(struct axienet_local *lp,
+				  struct ethtool_eth_mac_stats *mac_stats);
+	void (*get_eth_ctrl_stats)(struct axienet_local *lp,
+				   struct ethtool_eth_ctrl_stats *ctrl_stats);
+	void (*get_rmon_stats)(struct axienet_local *lp,
+			       struct ethtool_rmon_stats *rmon_stats,
+			       const struct ethtool_rmon_hist_range **ranges);
 };
 
 static inline struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 19fe2fd81f3a..198de353372a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1874,29 +1874,11 @@ static int axienet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	return phylink_mii_ioctl(lp->phylink, rq, cmd);
 }
 
-static void
-axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+static void axienet_1g_get_stats64(struct axienet_local *lp,
+				   struct rtnl_link_stats64 *stats)
 {
-	struct axienet_local *lp = netdev_priv(dev);
 	unsigned int start;
 
-	netdev_stats_to_stats64(stats, &dev->stats);
-
-	do {
-		start = u64_stats_fetch_begin(&lp->rx_stat_sync);
-		stats->rx_packets = u64_stats_read(&lp->rx_packets);
-		stats->rx_bytes = u64_stats_read(&lp->rx_bytes);
-	} while (u64_stats_fetch_retry(&lp->rx_stat_sync, start));
-
-	do {
-		start = u64_stats_fetch_begin(&lp->tx_stat_sync);
-		stats->tx_packets = u64_stats_read(&lp->tx_packets);
-		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
-	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
-
-	if (!(lp->features & XAE_FEATURE_STATS))
-		return;
-
 	do {
 		start = read_seqcount_begin(&lp->hw_stats_seqcount);
 		stats->rx_length_errors =
@@ -1924,6 +1906,33 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
 }
 
+static void
+axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+	unsigned int start;
+
+	netdev_stats_to_stats64(stats, &dev->stats);
+
+	do {
+		start = u64_stats_fetch_begin(&lp->rx_stat_sync);
+		stats->rx_packets = u64_stats_read(&lp->rx_packets);
+		stats->rx_bytes = u64_stats_read(&lp->rx_bytes);
+	} while (u64_stats_fetch_retry(&lp->rx_stat_sync, start));
+
+	do {
+		start = u64_stats_fetch_begin(&lp->tx_stat_sync);
+		stats->tx_packets = u64_stats_read(&lp->tx_packets);
+		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
+	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	if (lp->axienet_config->get_stats64)
+		lp->axienet_config->get_stats64(lp, stats);
+}
+
 static const struct net_device_ops axienet_netdev_ops = {
 	.ndo_open = axienet_open,
 	.ndo_stop = axienet_stop,
@@ -2356,11 +2365,8 @@ static int axienet_ethtools_nway_reset(struct net_device *dev)
 	return phylink_ethtool_nway_reset(lp->phylink);
 }
 
-static void axienet_ethtools_get_ethtool_stats(struct net_device *dev,
-					       struct ethtool_stats *stats,
-					       u64 *data)
+static void axienet_1g_get_ethtool_stats(struct axienet_local *lp, u64 *data)
 {
-	struct axienet_local *lp = netdev_priv(dev);
 	unsigned int start;
 
 	do {
@@ -2377,6 +2383,17 @@ static void axienet_ethtools_get_ethtool_stats(struct net_device *dev,
 	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
 }
 
+static void axienet_ethtools_get_ethtool_stats(struct net_device *dev,
+					       struct ethtool_stats *stats,
+					       u64 *data)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+
+	if (lp->features & XAE_FEATURE_STATS &&
+	    lp->axienet_config->get_ethtool_stats)
+		lp->axienet_config->get_ethtool_stats(lp, data);
+}
+
 static const char axienet_ethtool_stats_strings[][ETH_GSTRING_LEN] = {
 	"Received bytes",
 	"Transmitted bytes",
@@ -2389,12 +2406,26 @@ static const char axienet_ethtool_stats_strings[][ETH_GSTRING_LEN] = {
 	"User Defined Counter 2",
 };
 
+static void axienet_1g_get_strings(u8 *data)
+{
+	memcpy(data, axienet_ethtool_stats_strings,
+	       sizeof(axienet_ethtool_stats_strings));
+}
+
+static int axienet_1g_get_sset_count(void)
+{
+	return ARRAY_SIZE(axienet_ethtool_stats_strings);
+}
+
 static void axienet_ethtools_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
+	struct axienet_local *lp = netdev_priv(dev);
+
 	switch (stringset) {
 	case ETH_SS_STATS:
-		memcpy(data, axienet_ethtool_stats_strings,
-		       sizeof(axienet_ethtool_stats_strings));
+		if (lp->features & XAE_FEATURE_STATS &&
+		    lp->axienet_config->get_strings)
+			lp->axienet_config->get_strings(data);
 		break;
 	}
 }
@@ -2405,24 +2436,20 @@ static int axienet_ethtools_get_sset_count(struct net_device *dev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		if (lp->features & XAE_FEATURE_STATS)
-			return ARRAY_SIZE(axienet_ethtool_stats_strings);
+		if (lp->features & XAE_FEATURE_STATS &&
+		    lp->axienet_config->get_sset_count)
+			return lp->axienet_config->get_sset_count();
 		fallthrough;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-static void
-axienet_ethtools_get_pause_stats(struct net_device *dev,
-				 struct ethtool_pause_stats *pause_stats)
+static void axienet_1g_get_pause_stats(struct axienet_local *lp,
+				       struct ethtool_pause_stats *pause_stats)
 {
-	struct axienet_local *lp = netdev_priv(dev);
 	unsigned int start;
 
-	if (!(lp->features & XAE_FEATURE_STATS))
-		return;
-
 	do {
 		start = read_seqcount_begin(&lp->hw_stats_seqcount);
 		pause_stats->tx_pause_frames =
@@ -2433,15 +2460,23 @@ axienet_ethtools_get_pause_stats(struct net_device *dev,
 }
 
 static void
-axienet_ethtool_get_eth_mac_stats(struct net_device *dev,
-				  struct ethtool_eth_mac_stats *mac_stats)
+axienet_ethtools_get_pause_stats(struct net_device *dev,
+				 struct ethtool_pause_stats *pause_stats)
 {
 	struct axienet_local *lp = netdev_priv(dev);
-	unsigned int start;
 
 	if (!(lp->features & XAE_FEATURE_STATS))
 		return;
 
+	if (lp->axienet_config->get_pause_stats)
+		lp->axienet_config->get_pause_stats(lp, pause_stats);
+}
+
+static void axienet_1g_get_eth_mac_stats(struct axienet_local *lp,
+					 struct ethtool_eth_mac_stats *mac_stats)
+{
+	unsigned int start;
+
 	do {
 		start = read_seqcount_begin(&lp->hw_stats_seqcount);
 		mac_stats->FramesTransmittedOK =
@@ -2478,15 +2513,24 @@ axienet_ethtool_get_eth_mac_stats(struct net_device *dev,
 }
 
 static void
-axienet_ethtool_get_eth_ctrl_stats(struct net_device *dev,
-				   struct ethtool_eth_ctrl_stats *ctrl_stats)
+axienet_ethtool_get_eth_mac_stats(struct net_device *dev,
+				  struct ethtool_eth_mac_stats *mac_stats)
 {
 	struct axienet_local *lp = netdev_priv(dev);
-	unsigned int start;
 
 	if (!(lp->features & XAE_FEATURE_STATS))
 		return;
 
+	if (lp->axienet_config->get_eth_mac_stats)
+		lp->axienet_config->get_eth_mac_stats(lp, mac_stats);
+}
+
+static void
+axienet_1g_get_eth_ctrl_stats(struct axienet_local *lp,
+			      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	unsigned int start;
+
 	do {
 		start = read_seqcount_begin(&lp->hw_stats_seqcount);
 		ctrl_stats->MACControlFramesTransmitted =
@@ -2498,6 +2542,19 @@ axienet_ethtool_get_eth_ctrl_stats(struct net_device *dev,
 	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
 }
 
+static void
+axienet_ethtool_get_eth_ctrl_stats(struct net_device *dev,
+				   struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	if (lp->axienet_config->get_eth_ctrl_stats)
+		lp->axienet_config->get_eth_ctrl_stats(lp, ctrl_stats);
+}
+
 const struct ethtool_rmon_hist_range axienet_rmon_ranges[] = {
 	{   64,    64 },
 	{   65,   127 },
@@ -2510,16 +2567,12 @@ const struct ethtool_rmon_hist_range axienet_rmon_ranges[] = {
 };
 
 static void
-axienet_ethtool_get_rmon_stats(struct net_device *dev,
-			       struct ethtool_rmon_stats *rmon_stats,
-			       const struct ethtool_rmon_hist_range **ranges)
+axienet_1g_get_rmon_stats(struct axienet_local *lp,
+			  struct ethtool_rmon_stats *rmon_stats,
+			  const struct ethtool_rmon_hist_range **ranges)
 {
-	struct axienet_local *lp = netdev_priv(dev);
 	unsigned int start;
 
-	if (!(lp->features & XAE_FEATURE_STATS))
-		return;
-
 	do {
 		start = read_seqcount_begin(&lp->hw_stats_seqcount);
 		rmon_stats->undersize_pkts =
@@ -2563,6 +2616,20 @@ axienet_ethtool_get_rmon_stats(struct net_device *dev,
 	*ranges = axienet_rmon_ranges;
 }
 
+static void
+axienet_ethtool_get_rmon_stats(struct net_device *dev,
+			       struct ethtool_rmon_stats *rmon_stats,
+			       const struct ethtool_rmon_hist_range **ranges)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+
+	if (!(lp->features & XAE_FEATURE_STATS))
+		return;
+
+	if (lp->axienet_config->get_rmon_stats)
+		lp->axienet_config->get_rmon_stats(lp, rmon_stats, ranges);
+}
+
 static const struct ethtool_ops axienet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS |
@@ -2914,6 +2981,14 @@ static const struct axienet_config axienet_1g_config = {
 	.phylink_set_caps = axienet_1g_phylink_set_caps,
 	.pcs_ops = &axienet_pcs_ops,
 	.stats_update = axienet_1g_stats_update,
+	.get_stats64 = axienet_1g_get_stats64,
+	.get_ethtool_stats = axienet_1g_get_ethtool_stats,
+	.get_strings = axienet_1g_get_strings,
+	.get_sset_count = axienet_1g_get_sset_count,
+	.get_pause_stats = axienet_1g_get_pause_stats,
+	.get_eth_mac_stats = axienet_1g_get_eth_mac_stats,
+	.get_eth_ctrl_stats = axienet_1g_get_eth_ctrl_stats,
+	.get_rmon_stats = axienet_1g_get_rmon_stats,
 };
 
 /* Match table for of_platform binding */
-- 
2.25.1

