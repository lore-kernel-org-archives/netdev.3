Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1804A139D;
	Thu, 23 Jul 2026 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810388; cv=fail; b=q93cqcXNSqW51dHEMLNwgZpJTEc33nroEsWGgqvmozr27AX7AjSvO+3zyUvTmGArU8UZk4qyzw02oanxa/o1YOzzVxUt7do1b7JDTZtxxjgNiOxEuDLwsfH371m1zr1yp/Te8YIj3oHW6Iaw8ThokhJVp56iczX7/0Rwlu72IQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810388; c=relaxed/simple;
	bh=UmcKNJjcpQo04U88CulqXHN5wLnBfMmTce8MmY16LN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOyjIzXGCVRg/pv1aQSMJC8zNpcYwIvyE3BB+JeoBqyw1Eyg+vvSLszeWeri/OMS3XPA+fMqxCCcfXBCwVUFYAD29jPuomsJ82bfuOwkYx2UKDiWRQ//2gSPaKE+vmoRL+rjgV+TrVGgY/wYUSEp2KNIWIzoIhwvQ3nniUD4AUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQ80zCWL; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQ80zCWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2q+cZQ7i4nkewQDCaBGImmrWalCy7Y73ZP/fmrkN1oWoalHUvT7jtl5IwIFpEzMfMArQUoFgqVWMC62jL210S/nWsCEipRsV56bomJnTtxlMk2OkQuGshg+PZgnC2m4WH2D9dOY0QMuhol5KX7AIjUwBXKl+qNUBzpT+BaWaoohiSe3ZMVTjDmSZCD18xPZzs/I+3cfBgqdQ40HQbDd1RTd92pAg5sGfMOuAJsgkJYWZP2TVSxh2Pcm1QoVDycVfLNg5h9UxF2EDFSdkdn9y+UAkP+qApgs9lYDOmeYKK7iIRHBCEW05PIVXo1gRHlW3F6fP4xdcJ1SjnnRJ/DGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmcDYc7H0S6bH9oEkvwHBJoAArjFlGnTjn1pOTdkzQg=;
 b=K4HWOna5JmQP0fYMnt2sbiPig60LNhhO6gDFXaemmNnVezvPNUxkOdQ8bhjI3sOMQb3gU7sPd6KC7nJ1wZ6V9/NTyWVHgZHviCV21lY8aMADDBeoWSlE4nwQURTzUZP6dc88/3x5BK6odtsbJDLpBMqG5t2L1dr8TGO+CQNRufWKzQIaSUxv5bOq6pYUMhTB5vrkkV4JXhhPBU5cWRMtVvX6bXR/9N03MF1EEIpZre1q2BCdoUZFRXdEIbD+tpgovGTcWIzTJsLdw3YGTzon7lWQsAjJRtUSgp0hpDygIKZ7MXJtbiP/rbIshHaZfXEW4kWrSnoCTmAQOrnIBgEdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmcDYc7H0S6bH9oEkvwHBJoAArjFlGnTjn1pOTdkzQg=;
 b=wQ80zCWLuNjGMfZFNsVpmiXmxqKh1Ianq4G6JOnaOpxDOoe6ihcTUM8CDZDV0I/j+C/YES6lmGgZ2dbf1ztexdB9h5lrpM3CAU+dR8VcRmKRS69VnMNu/B/5Zr/a/P94sUn1fid/WOlTsBPRs8zH2gGdKrzxI7eZjG3J7c2vAac=
Received: from SJ2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:a03:505::16)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:39:40 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::aa) by SJ2PR07CA0016.outlook.office365.com
 (2603:10b6:a03:505::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 12:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 12:39:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:39:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:39:34 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 07:39:28 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>, Russell King <linux@armlinux.org.uk>
CC: Shyam Pandey <radhey.shyam.pandey@xilinx.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH net-next 6/7] net: xilinx: axienet: Dispatch statistics through axienet_config ops
Date: Thu, 23 Jul 2026 18:08:37 +0530
Message-ID: <20260723123838.125145-7-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723123838.125145-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ea0aed-e3d0-4440-5dd0-08dee8b776ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|23010399003|10067099003|11063799006|6133799003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	qeRZV1BbSZuoy3aAhS5vJ4OZkLntXN96N6eqGEBHfytmiM9ue31XDm87Z/rGhJ5Q6CuZ45Q/qz1IoIEmHZd5TAzT5TifQaxI5WHkj+BCXgwL76HldhGzNXsfmjvqwqHtTmSzWJlWM4BKgXUe1aA0aT/7q85m2vBSFUbBPJl398ERrBY9HP7awew4oMn7m+DGp55iYaFPn5ceXCO+kJNdBlcwg1ZC3MISze6uOx8OAVQqvoqQLfL6Y14qrJqTYrVmjwyo30uJPNTAcdVssayOc4ctsShP0IcvFCmp3F8a8YZ7QeGgI4UpOTrj+JtUhai9jHPNWRYBX/TIXbqaC9sQngPgmOr6CSn4nR24Kpo9O55rPeXtJIubVPXOPwnKm6jBprmI6+98oeCmEI57mNoTaHnqONG6qIYGXrjaO0B8miEM6GWbwMhLyivjyGAoI2GNSVnsNob7z9R9GR8yJfkzt8Ivvc4ZY4PHePKwvvA9J+ukdM4B8JETsCfbw6XzKu5cjTKEzuNq4l5o/XeePSHCjt4ZBTGLodKfUpTzzp7nc2BlTFIria9Xf9YiRhbVKrKeeClq2AZ7JzYdhQ0RGdFbxarc8RXBPkDI+Z+54ohzCCquOW9w5oCaDJQUgVGhTN42/MHX50zs1MzxiLv1jn1zJL6HKGCxm5i2bkw5rBS9z4WMXxr955JOPowX1bxF79mh+R2kHMbArOd0Gmx3QCXSqAM+57U3znxzLN4G+RbHdfzq5AwgjK+EfC60vtcy5EC3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vL+hfczPcKGLnMEjfped9bmLJ6+432QhAIen9Fnemtpf2mZLn9FvfNDjnOW0vJLCvUJPZ8X9/V7nxkJyfH01jSH/qPCil2eiYWZLIn8nh/aqxBNo0AMOWXglvPvjZ15YH6DBtIz/vrFLB4LLvaYKMsdfjXS8uRTCd4HOiKxROehm1uh5x1wPa+poRoEMzUkcbYSGaaS7nHTGbgj3Bxxtg4YQubAV38nGr5oaGHxLCfK9MxELTBoaM2eHCojVs4RzswufXEK8+w3JEJwn2sVFks8MHHWLsFXOss3TKrFnuxA8xv0punWDaX4v+KIEO7WHLgljIRczUbSXZaDvBMsKzW608+EIfY4JX+J4k/w2fqfHZpXfB1vudIY14Y9XTmZHhZ4VoND3cYnwBBlKfMYXE5Zk7HAZcI6/Hdx5aBHsaEDipjqPFtOOmWULLhqxaByk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:39:39.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ea0aed-e3d0-4440-5dd0-08dee8b776ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483

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

