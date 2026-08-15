Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEB2AE8D
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786754006; cv=fail; b=K4epuBm88GGw3H69yvWEzQDw4AllG59flXKiVn+PSujjPzCMjY+LscpVXqpsFdd1NHXTFLbP1L4P9L6NiB9pzn03yUHVdll3uEQlsb8obBtn6coh6lTsMKutRmklyM5KosYnqcp8i+Z3lOfJTmiKIfi8vLJqtwzDTph+OWe9axg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786754006; c=relaxed/simple;
	bh=gZab2FCKlDSSgyeZA5wCUcjquOl1An0DuW8JxxZ0S7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=R4ydJeQv05YYlZiLF117PV8r1BBH1oYLicD++gl1JQyDMF/HqLkEIAE8QIspeAq7S0V92BDC7Qs8bzOXBSTnxXNNtRwbVySq5Iry/G/uMxtuZRGZiZpP4u1vReU2HbJe9c60TEeoVJlvXw/LSsuqZ1FA0t8l3EdBghlSEf5TS2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oyxpG57u; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oyxpG57u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKH9MfuTXv9V5HCV32CH98FFfi7RRjYs5ImJzlOClQ/EXjuk8VB6Ji+49g+w8gUsqoHdP6Y5Rw2OWSOK8ZHx27YvWHb3sHOu8vr0GFUfJJppZIcW9kw5O3IcHOp2b7RyF9j9NllORhNiewitGHDJi+WmNX9zFpBZOvuS1i6NHNg2vk8x4nCu1nuolub4U3tYKgnrv4m5/IKkn1y+6eMGi6kHv39hz/kIKfairAnp+SZtLQG/3DmDspxrZTPVJK9Qb1NUmcDFfpAR6ZJIBc69RfAy4mj2h/j21dCPzGCpbVQSlAPMYb9ccgyK7of9JbnK8h1ojp0zg8sWmOF7a9/L7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CngcnyCp8xiIEKjXUGOBk5n8/lrv0a273ynwzwaCvhg=;
 b=L6XPaHQBkMwzlgQiJVUA4mynZublxG2QstVxCBaAwyyow8cLnRRkx94CwHnTM+IsiHBrIX7zq9GmIxxdtKVN9rXh5era+N2PPKjUPJhRyJr8LyV6kicUxC0ClXo23+AAzfQbNJjTLvs0dLRlPQr3iYNUaGSsFdqPfS1BZ0W1shPZW95qRF0OOxzKhZZ6D+VwaaxPDeuRURNvvV+c2zTbsUCGZN6rchxuLnlXOfsr4fvL4Vq2CZykdvOW67oAWS/cHjzlq6vTIA8uNgIHgh1oS76uL/sFpUfadCH3qsJeEmx5i+DeyQQDenxErJWtlcRBc7gN+YIdS4ue0wDcMafkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CngcnyCp8xiIEKjXUGOBk5n8/lrv0a273ynwzwaCvhg=;
 b=oyxpG57uOy+gkN2B8pOWWEvPbawuboiGIla0Baa4ItBw44s9vwyszSDPcqYn8qdYIIpaJT/JhMpJWlikSzWySdUSG8tNI1RAVPR+C2vSbbJtR01QN19di1lmHibTMCWOj7QieqYvpn70ypQ/EBCNbVGC8495tdmulnRQ7Xg71zU=
Received: from DS1PR05CA0006.namprd05.prod.outlook.com (2603:10b6:8:457::15)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sat, 15 Aug
 2026 00:33:19 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:8:457:cafe::3e) by DS1PR05CA0006.outlook.office365.com
 (2603:10b6:8:457::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Sat, 15
 Aug 2026 00:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sat, 15 Aug 2026 00:33:18 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 19:33:17 -0500
From: Eric Joyner <eric.joyner@amd.com>
Date: Fri, 14 Aug 2026 17:33:12 -0700
Subject: [PATCH net-next v2] ionic: Add .get_fec_stats ethtool handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260814-ionic-get-fec-stats-v2-1-13f0e7d2e702@amd.com>
X-B4-Tracking: v=1; b=H4sIAMezf2oC/x2OTQqDMBCFryKz7kgSrZqueo/iIsRRp2BSkiCKe
 PeGLB/f+7sgUmCK8KouCLRzZO+yUI8K7GrcQshT1qCE6sQgW8ycLS6UcCaLMZkUUWvRN53uWi0
 GyMlfoJmP0voBl62OjgRjJivH5MNZ5nZZeGnuG6lkK5Ss5VP1GiXmW7b++tNReJttqq3fYLzv+
 w/Ki+tKsgAAAA==
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Eric Joyner
	<eric.joyner@amd.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 956f9566-308b-4899-dd6e-08defa64cd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|13003099007|10067099003|6133799003|11063799006|5023799004|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KXw5MEwMxr2Isc/5OAQ1ni1GYdFm8D2NL+4LVx7ISfS6rE+aHSX3adgpvBLF1HVh4xm4CywQ8WN+HhQICbbEuW8abGoIWRxdNCbnfQn8Y4YUQH7TozL3AXIEYwLalSQBqLK1F3kIunb1J0tfX3xaU/syRNhp+NhlEDkWU9IZnSs4e3HEfn9ZPgUbSEekw20VXU/mbX75ajjVhNDnzM+vaMTQdtSaIseKnpzulbIciLUmQcMP36RMYC7plofsnY6vCL4BL2XrY+GJLFGEaU32yk3YuCWiify30eymAif1F6+mhPE8i1awib9Zvta4tT0hPccQiSLE6SnGS7XRXK/FXm0XP1nV8Vxsr8JuGNz9qp/2ycnCxxGUNtmJx3Kxc1WhLHqfRdZQiwBf5GU//iz+Mn4iOpbo7ys+L2LGsaBTnYreEc41Cj+pVF+9BhHyILulDWu4UftwK7Qd7fA9BnAGR3oqdOwMga19aROti1Qi92B34pQqyBiutaS4BNvZ/+y1JPC3aPHWh+M0z5SPxm3qkWUE8R1Os9T06hpcExQ0p5CmvvSfSPTbKdxLPfilGuKf6boOuzg83fEYFa2T7wE3X47VARcuydIpRGlgyssYgrpIr93RWZN2BUA2nIGXP890D1i68Ccon22Pb1hEJXdoBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(13003099007)(10067099003)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JNvp1Hq6qOJTA0WBtinbVPzMKnmDcaT1GMIJWIlBJoHiLABK+UgxtU60BUebbGUG6TKD8rJs32/0ndYeZB54OAqpKW1GUmd7qEFEFqBGUswKAJyazZlq55GkExSlOgDqgvEzSuoU0xJqrer08r/C7watU+8c027LeWck/T7yg0xVyqiQfRRaHcsQU4ZtlfoXe9cfYtpAQC+CSgvVI87OIGSgXtEf/eMSI2ykzO0xdx6Xqz4tkZZhZUDXq6zxoPI2k4qGIRZH76N4R+rVH55aZXRCGC87z2WIFFhCIwwMqAbBNzhQlpOa7mNKmAYK+0SYXXUAGyd8dUv8x6hfFS/wmpI3BjBWWr6QHgHagcBdYFzlafKAnTFo+ll7AqvdyLDTgSIVYF/ZyS0K+Aq2SAJuAu3/G+8WMrRwmQAxAKyukybqc+YBAhutRcwuABYkeWGl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 00:33:18.3907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956f9566-308b-4899-dd6e-08defa64cd7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane
counts currently aren't supported. Every counter reported here comes
from the RS decoder, including fec_corrected_bits_total despite its
name, and the only histogram format firmware produces is the 16-bin one
from RS(544,514), so nothing is reported unless RS is the active FEC
mode.

These are physical port counters, so virtual functions are skipped the
same way ionic_get_link_ext_stats() skips them, rather than reporting the
port's counters as if they belonged to the VF.

The reporting of these statistics is gated by DEV_CAP_EXTRA_STATS and
checks for IONIC_STAT_INVALID, since only the newest devices support
reporting all of these stats. Older devices can only report some of the
statistics or not at all, and so the output will properly exclude those
unsupported statistics.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
Reposting since v1 was too old to apply. This also addresses the netdev
AI review comments left on v1:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731214021.15279-1-eric.joyner@amd.com

That review also flagged a NULL dereference in ionic_get_fecparam().
It predates this patch, so it is fixed separately in the net tree
rather than here:
  [PATCH net 0/3] ionic: fix port_info lifetime problems around device reset
  https://lore.kernel.org/netdev/20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com/T/#t

Vadim's Reviewed-by from v1 is retained. The only change to the code
since he reviewed it is the histogram bin latch listed below.
---
Changes in v2:
- Latch each histogram bin into a local before testing it against
  IONIC_STAT_INVALID, so the sentinel check and the store cannot be
  folded into two separate reads of the firmware-updated DMA buffer.
- Explain in the commit message why the RS FEC check gates every
  reported counter rather than just the histogram: they all come from
  the RS decoder, including fec_corrected_bits_total despite its name.
- Rebased onto current net-next.
- Link to v1: https://lore.kernel.org/r/20260731214021.15279-1-eric.joyner@amd.com
---
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index c4ab4b5caa0a..2f2b5076dcf4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -441,6 +441,91 @@ static int ionic_get_fecparam(struct net_device *netdev,
 	return 0;
 }
 
+#define IONIC_FEC_STAT(dst, src)			\
+	do {						\
+		__le64 __val = (src);			\
+							\
+		if (__val != IONIC_STAT_INVALID)	\
+			(dst) = le64_to_cpu(__val);	\
+	} while (0)
+
+static const struct ethtool_fec_hist_range ionic_fec_hist_ranges[] = {
+	{ 0, 0},
+	{ 1, 1},
+	{ 2, 2},
+	{ 3, 3},
+	{ 4, 4},
+	{ 5, 5},
+	{ 6, 6},
+	{ 7, 7},
+	{ 8, 8},
+	{ 9, 9},
+	{ 10, 10},
+	{ 11, 11},
+	{ 12, 12},
+	{ 13, 13},
+	{ 14, 14},
+	{ 15, 15},
+	{ 0, 0},
+};
+
+static void
+ionic_fill_fec_hist(const struct ionic_port_extra_stats *port_extra_stats,
+		    struct ethtool_fec_hist *hist)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port_extra_stats->fec_codeword_error_bin); i++) {
+		__le64 val = port_extra_stats->fec_codeword_error_bin[i];
+
+		if (val == IONIC_STAT_INVALID)
+			return;
+
+		hist->values[i].sum = le64_to_cpu(val);
+	}
+
+	hist->ranges = ionic_fec_hist_ranges;
+}
+
+static void ionic_get_fec_stats(struct net_device *netdev,
+				struct ethtool_fec_stats *fec_stats,
+				struct ethtool_fec_hist *hist)
+{
+	struct ionic_port_extra_stats port_extra_stats;
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_port_info *port_info;
+
+	if (lif->ionic->pdev->is_virtfn)
+		return;
+
+	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		return;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	port_info = lif->ionic->idev.port_info;
+	if (!port_info) {
+		netdev_err_once(netdev, "port_info not initialized\n");
+		return;
+	}
+
+	if (port_info->config.fec_type != IONIC_PORT_FEC_TYPE_RS)
+		return;
+
+	port_extra_stats = port_info->extra_stats;
+
+	IONIC_FEC_STAT(fec_stats->corrected_blocks.total,
+		       port_extra_stats.rsfec_correctable_blocks);
+	IONIC_FEC_STAT(fec_stats->uncorrectable_blocks.total,
+		       port_extra_stats.rsfec_uncorrectable_blocks);
+	IONIC_FEC_STAT(fec_stats->corrected_bits.total,
+		       port_extra_stats.fec_corrected_bits_total);
+
+	ionic_fill_fec_hist(&port_extra_stats, hist);
+}
+
 static int ionic_set_fecparam(struct net_device *netdev,
 			      struct ethtool_fecparam *fec)
 {
@@ -1177,6 +1262,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,

---
base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
change-id: 20260814-ionic-get-fec-stats-990736964908

Best regards,
-- 
Eric Joyner <eric.joyner@amd.com>

