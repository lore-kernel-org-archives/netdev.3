Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9885351C04
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534045; cv=fail; b=mWpKBXsYL6nHMcg+Jhd2OR8pMxahVGOdsEiLUwg7YTg+Yq1aRKyF67DBPS37PXqKZoH+Et9RKzRCm7SBqUh4QtdVIDea+Hbaf2KO0EXWnoDOx6LayAln3ImHApsweFK7QWxWRnwb8mXorLEnwwZBkHi0N3puWzw/YYrLfAZ2ACQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534045; c=relaxed/simple;
	bh=hGMMHPrwmNSsmU/Kv5BSJTblmmcnpQ5aoWmUYUvP1T4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1Biv+STTxRPl5TuHJ0zGXj2zYn9d1/8SxEczhDWBnFiL9IHBJRejMPfEKWK2w/kUsn6gBRg1qBEb2cZlxJ1zxyQ52wZlpRuQQ2GYuyK/MhTKoYtqpA18jatIkUouJ58s/mml88nWYeGGUN1pMnf2X0OE5AMTqVf/GPYU+qdhMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ac4iALBX; arc=fail smtp.client-ip=40.107.209.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ac4iALBX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb3lLEj6TWru1S0Z9xG9IB5eGPgmspj6yqR7CYoqJMUMmywyl1yBKiVyCTpAwpQSx/kaLNlzulMBDc6MgL3fuR2PHbsCdFa2fUQH2xSVXwrWgeSR+nBgUXIrOygVaGWfaSslIapGrdRZXarTmJzuMPetJIXvdGVtwTm0fRV7o7VxigrBEqov0PZ89y7PgOUlwjsR5qb+hrUl0xgjH5hjT0G2zJqZ4S+rAGF8jdOFnU0DhxMfS6QyT57WXBTSd3dA9VkIRmOFb0aQMvxGjsfhARZaSfNWgrgsEYVc43yat/65bwhXwpO1sT3QRJ7NzNz2KItORzetmLk43C/Hzge2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Avq2uROJLB8/sjxIBBnT1LU35Kfd1N3cItmYGvho+g=;
 b=puQbcjsUHArMegSpnCn8b55wrsI7JgvA8pfNwITo3MIti3J7mS53f6CaELBQCXI761r6sq2NyABK8GxdJKTbsYpiQxTuo1uGWuD1GLtWwp71t0M2QoMi0xn3mIR6mSzei/U8PE8U71HxgM1d0U9LgJZSzJrp6biH3XwpU0yBBDrqbd5Fv9hKqIUxACwX9laaEFKWEcj/Kc9l8UZhvb/5+e6sKmBmcAqCLN8zc05I4lc1M5P22g9k3A049fnBUXkDsIPLpqJUivCXZErrsOSgXhHw6w0JKHFCvjeZK2I1FLAJAESTegB6h0eFMR9av0PP7UBnFVKyGqTJnK/uFvOkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Avq2uROJLB8/sjxIBBnT1LU35Kfd1N3cItmYGvho+g=;
 b=Ac4iALBXC0K10JJExxuP0DCTZEHOghJLdJB5+/X3h34DjJFcK9ja4dOorcAVzf6s+plusnI4ZLPJD3kYRjzetk9pqYl5RoNe+UdNFhnGmWpt8YuSwPQKytEuXVpQltV+nPP1IGRLQFk/s81DJEDFnqqg9EaUjgGP5yqhrjqFMIY=
Received: from SJ0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:a03:3a0::6)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:40:40 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::33) by SJ0PR03CA0241.outlook.office365.com
 (2603:10b6:a03:3a0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:40:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:40:37 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Nikhil P . Rao" <nikhil.rao@amd.com>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH net-next] ionic: Add .get_fec_stats ethtool handler
Date: Fri, 31 Jul 2026 14:40:21 -0700
Message-ID: <20260731214021.15279-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: f40c256f-85ec-43d2-7db9-08deef4c5d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3zDeaixUwSORqXkHJhDR5aROWcwdUdewibKZaNhmkpZ6oFm8tlscesHfJDQJPjU3CSiL3tDeaEGHxRY4lvRI52AFmMjMqwfiSehF6xYq8rIrqn+bGp3Lj84O8ycBWcQA1eSA7NnH9/MgGbj6ZS+84ruuJYIXvWvuSmS8JuLcLJayKqqiZIXFeDZr21YiywZ6mbBaYOr9guU/sqhFio7FYj3JY3GQdqgrdaUxWc/vHg6pZnYVZM/MWL7v6N5bbXL0gMi4XNkPJjmxKDMQFJaVefueR42pTPZHA8AtUAgYackdPueToeJRX4WU7LPitz7JnaWoRjJPD3Rm4/JgSKzsNc9bOcENAUj7qkWnAg5U4rW7i4gZvMjcU7jfWJSG/mwKDcepoGF9VkQOZDF9B32uSPovSmxv4hV5HShutFHqmvNwgRm0ci10EQI4vx13MlEVs3/zLuSS11s2vM6ZnBwoEOHypeQqWiif70aSKAdRhGaeRcS5vGGdKcSe14NtYnmEQbE8F4wuUFlCtjJduSkgc9r9vBb2/EV2jpIXsKgv5Fo1j9wGBEPJgHiDrQaWFVSN/D9jBvp8vrbXIoeqIpCc9W+hkZLOEfwpG5/tfIGLC5TxM5Qxe2kHkZTHlz1KRTCF/sLYx2rJG+OfqbTAByMPg0i3IwIw1HUrywPb71uZrTU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HnRZHhS2ZajIhIeA4vcWW8eQWCBaoWSwBLcomMs8M4v/Llp3TIuGKLurUbK67ScObEBgH30rhfjH67UuhO1giiFDOMXou8v1nVf/W61jj8Qz3muxx6AEuq9awlhz6SY3zHQ9NT5XNG1viMq0vvbuy1YBxnZvlHWkd7YlsAD5yu1tcN7k7KCMP1uFoZxacw3n0lxYQKts+GwGrN6D+fKUg76NdVZArlKI8jGtQWfywtHsVJwnkchi6S9GcuPPwgauXGdnZsEkNGd67LOUjLq6sQ/MvBsDcHzci3J5czv4jy93pOCtoUUIl27iGKWHVRhraAlCue6AG5YahbxR9IERGkI6zkZmBpZO6sSj1HAnI6JAVgciWGtgJFlur+1URUJU8k3lDd0hqSAsvA1swDSlvp7+FXnlh1+8nKCuMnSt8BagG9WituWWyrTC6e4emDNW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:40:39.8803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40c256f-85ec-43d2-7db9-08deef4c5d99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane counts
currently aren't supported, and the only expected histogram format from
firmware is the one with 16 bins from RS(544,514) FEC.

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
---
v1: This is an updated version of the last patch that was not applied in
the series "ionic: Add .get_fec_stats ethtool handler", see:
https://lore.kernel.org/netdev/20260615182732.7d28e31a@kernel.org/

 .../ethernet/pensando/ionic/ionic_ethtool.c   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index c4ab4b5caa0a..0d4bd49cf935 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -441,6 +441,90 @@ static int ionic_get_fecparam(struct net_device *netdev,
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
+		if (port_extra_stats->fec_codeword_error_bin[i] == IONIC_STAT_INVALID)
+			return;
+
+		hist->values[i].sum =
+			le64_to_cpu(port_extra_stats->fec_codeword_error_bin[i]);
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
@@ -1177,6 +1261,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,

base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
-- 
2.17.1

