Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627C48C3F2;
	Thu,  6 Aug 2026 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039988; cv=fail; b=A8B8nIsK5artSIyEuVavDCd88Oxnarwm7hfmsH+X4bkRmRkGrZ21veQqqO9tyDvwWDhBUMo4RRQhU+75Z/hjaWSss91oX+pM0IKTWUJs4KjFBCnKTiWo7Z3KbTxfdIUn88sONfxdNFdAiMc7yNfyrAVaXp4PrljgHB3BAHiReZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039988; c=relaxed/simple;
	bh=9HQbGCzqCEH8zZJwsZjRiVlgQl4G1ILPceUZ6TkfOSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcSQal3N/fLj8ibix5yHSphzTEPx/yLYlOwAer9pamPkDoUiiFtItk/9tA02BDVoyPiy32O4Eeovgba5bhqVMYmHEqDGVm+/pIMc7rjaDoDd13qQBfsoNOZr3sxvqeQpS4tugwW0TX0tOR/sIork4lGJ+uiApv428IcmBdiGWJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tn2keIoN; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tn2keIoN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOKWYWdnbDf8rBq2+CUnDcbrmim5BdJm83LMuWr+Pttzx1fp+OqGnQBviQDep/yX9+HGrjjbYw4uQ2iYExCny1euXWf8XJNlfyLpe9GZ+f7muRXy811EuB4lSc6NV3hlfdTOxrEHgrOEw/cwiWmgDmayfeigpK4xMdj9b+jSMbgJYwks1+4dVgddLfdYeCWJkncEKwmkhpDGjng0mhWpyJ71M2628iDkHRM2a9uBEMjHmxnuzNqayr78sbU7S2w+dL9JxTFl47/NGhH9ktwbXVAGgDXV61ruajvQa9R08Jf3AAdahSLCQJzBwrxbmgORUAvOUaHNCpzG7Qtl1u12BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47qshhibRdpFrge1emmnrmtk1pk2XpWdHCDeUMxCOdo=;
 b=pAT5l0H/dl8PsCVvtbGoQYuO8gGcUteKw5q4WLNEXzU+brLzjVIsgb81kEKITcS4+aCpl6ahU8P/N022AIX2vdbReUIzoeEf3lm39LlXue2WWa0jr4GoFVAtN06Z+yRh1/O6HNGeGLirr8sq/GmnAWiT/O2h8XhmE46GUaXYFllNLGZcJcqucrWlT+f/dUPbhRTtA3npcYyE3W+zx7eLOzZpuEMqwevaL8PwQO0rDhxX4BTeIPfG9zqnxu1r8ZHyN/VZgmM3pgpk6QQczbgfYhq5lzK5oeB6BkW+RfmufuL2aibQaVUAbDfueiDZEaw8q1u0dw8UQEbfN+5VhHYG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47qshhibRdpFrge1emmnrmtk1pk2XpWdHCDeUMxCOdo=;
 b=Tn2keIoNrkEP2KwS7rkRi72gF4O2ACYEE8YSg3zIr9hhlklxFt/C2bcH39TnV0tCc2BijWwQVm1lekEZlHk8Kgfokr7NpVvt7fflKVi26o6/nfS1LN40oeWxYGPzOKhk0gTBehnTQgQoJJlqYew35fQ/fAi79Px14rYTziH4+M4=
Received: from BN0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:141::21)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Thu, 6 Aug
 2026 18:12:54 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::2) by BN0PR07CA0016.outlook.office365.com
 (2603:10b6:408:141::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 18:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:53 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:12:47 -0500
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
Subject: [PATCH net-next v2 7/7] net: xilinx: axienet: Add statistics support for XXV ethernet
Date: Thu, 6 Aug 2026 23:41:53 +0530
Message-ID: <20260806181153.1213996-8-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: bad58ba8-80ed-4f04-8118-08def3e655dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|22082099003|18002099003|11063799006|4143699003|3023799007|6133799003|10067099003|10063799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	5cuTeRaL9EkxCy7O/Az/cYM47cKZycyCkvBWhuRjcvJyFrJANu0N/CcREA7hYafht0oaYywsoaF6GABnEna2eh9+Khp1eOUJmz4RJehhBf9Tccyf4Ax7UZydQv06YBPc2fgp00QcmrxQrzPY6rtDxiyiCYRQonk9D3JQLfonc0+4cpdorvKgRGS/a7o4PFZEI053UaAUpJL4oAiQ8r9YeSRC5BWKAWu72pgL6hPuCyf9pPFCkfoOSJl2keMfrTQUDD9emrIpXrvEJZg5ANqxtNUx7rd+hHJPEIYXCDLh1epbLgP46OMp2PAy71l3GltKPRq+fft0AMj/woau6M2VD9GDOae5P58Y9BDgxJy0q87YLks2lW8mHbnL3XancZI9ZI5ZwB9HOFXIrzs3Z35xpN2AOpq4xgtfYpy6DnnHNHgAFZDg88BE6kzO5ZDBcTnfSlfbQpmcdGX83GRaDxeZliyB3k7U79cldWqx+bJvDg2p2aDYHsmJA1lFHs5T4xKGeKLiwmKgUx0gcn1s1pC2RUJ2ANfTmAMRReB0ZvC0va/XosXWZ8gclovjWX9ImETPn9K/AOBabIw/otkCYife5kEKNUmxObCDoz9GpC/j2TpVZQ69s9kfa9+IEqf/02Ak03EE6ZlNueKIac/KuVxqB1asiMThWjvDkjkXnEgSiDEpzvP69C5GqjRs4q5ICmbevJogcOnoAl1ENi9aEqJvQhSnGorBZed/cUaEWnRskGTB+VFI3Z/ErfKZvvYxY23G
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(6133799003)(10067099003)(10063799003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZas51XTc3H0pJXTnm9eJ/hycuzgrLbc+Sj6s2id9Y0kooLwfYkFPdxQZo+KaCge0FP558GHs/HtTqqz1QcqwI1PHKNBfUTozF+pQOtuLRfod62mNC1rBoD1axxJUmQplZTycb1yZ/MVSSV5w4bCog9DlmDB4vKyi1IYnCefa36UihKSfc+KxCQEysIx7bERvNpIXUTOL16jiyMK3TfbqsTm5+uSqNta80SmYwekJ3al+Em+5zQR1m/Wn1pZRMoiRxT+NREPNLuALqsRNNZHsfkZKhhP6AVvJFNTJa3KGuQugnT8nMvICIXVuULRGhEZMhuWDwxL7qCeQ5+43+QKaKDwGrCwEMKlk4Ov1mpKccnyiYQ73CWsdY1V1BSQXTP7H4BbNhquWUOiNUkr2F7n94lt3OpbgwlR+nha7iFCfSZMjHtfrvv3V+5QV86qvo7T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:54.1285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad58ba8-80ed-4f04-8118-08def3e655dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

The XXV ethernet exposes a dedicated statistics block whose counters are
clear-on-tick (PG210): writing TICK_REG latches the internal accumulators
into the readable registers and clears them, so each post-TICK read yields
the count for the interval since the previous TICK. Software accumulates
those intervals, so no last-counter delta (as used by the 1G MAC) is
needed.

Feed both ndo_get_stats64() and the ethtool statistics (-S, pause, MAC and
RMON) from this accumulator path through the axienet_config statistics ops.
MAC control statistics stay unsupported as the hardware exposes no matching
counters.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   2 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c |  22 +-
 .../net/ethernet/xilinx/xilinx_axienet_xxv.c  | 266 ++++++++++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_xxv.h  |  55 ++++
 4 files changed, 343 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index f286c428343f..2ea086fc4dc3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -549,6 +549,7 @@ struct skbuf_dma_descriptor {
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
  * @xxv_ip_version: XXV IP version.
+ * @xxv_stat_base: Software accumulators for the XXV clear-on-tick counters.
  * @axienet_config: MAC-type specific configuration and operations.
  */
 struct axienet_local {
@@ -603,6 +604,7 @@ struct axienet_local {
 
 	u64 hw_stat_base[STAT_COUNT];
 	u32 hw_last_counter[STAT_COUNT];
+	u64 xxv_stat_base[XXV_STAT_COUNT];
 	seqcount_mutex_t hw_stats_seqcount;
 	struct mutex stats_lock;
 	struct delayed_work stats_work;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 198de353372a..e693f4a49f20 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -592,7 +592,11 @@ static void axienet_refresh_stats(struct work_struct *work)
 		mutex_unlock(&lp->stats_lock);
 	}
 
-	/* Just less than 2^32 bytes at 2.5 GBit/s */
+	/* Re-arm the poll before any counter can overflow between updates: the
+	 * 1G byte counter reaches just under 2^32 in this interval at 2.5 Gbit/s,
+	 * and the XXV internal accumulators must be latched (via TICK in
+	 * axienet_xxv_stats_update()) before they saturate at line rate.
+	 */
 	schedule_delayed_work(&lp->stats_work, 13 * HZ);
 }
 
@@ -601,7 +605,16 @@ static int __axienet_device_reset(struct axienet_local *lp)
 	u32 value;
 	int ret;
 
-	/* Save statistics counters in case they will be reset */
+	/* Save statistics counters in case they will be reset.
+	 *
+	 * The XAE_FEATURE_STATS blocks in this function read the TEMAC
+	 * statistics registers at XAE_STATS_OFFSET, i.e. they assume the 1G
+	 * counter layout. This is safe because __axienet_device_reset() is
+	 * only reached on the legacy (non-dmaengine) DMA path, which the
+	 * legacy_dma capability restricts to the 1G MAC. MACs that use their
+	 * own statistics mechanism (e.g. XXV, which is dmaengine-only) never
+	 * execute this path.
+	 */
 	mutex_lock(&lp->stats_lock);
 	if (lp->features & XAE_FEATURE_STATS)
 		axienet_stats_update(lp, true);
@@ -1777,6 +1790,11 @@ static int axienet_stop(struct net_device *ndev)
 
 	cancel_work_sync(&lp->rx_dim.work);
 	cancel_delayed_work_sync(&lp->stats_work);
+	if (lp->axienet_config->stats_update) {
+		mutex_lock(&lp->stats_lock);
+		lp->axienet_config->stats_update(lp);
+		mutex_unlock(&lp->stats_lock);
+	}
 
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
index 46b48a773c15..dbc9c21b104a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
@@ -8,9 +8,11 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <linux/iopoll.h>
 #include <linux/netdevice.h>
 #include <linux/phylink.h>
+#include <linux/string.h>
 
 #include "xilinx_axienet.h"
 #include "xilinx_axienet_xxv.h"
@@ -95,6 +97,69 @@ static struct axienet_option xxvenet_options[] = {
 	{}
 };
 
+/* PG210 statistics-block offsets indexed by enum xxv_stat. Each entry is
+ * the 32-bit LSB register address; the corresponding MSB is at +4.
+ */
+static const u32 axienet_xxv_stat_offsets[XXV_STAT_COUNT] = {
+	[XXV_STAT_RX_TOTAL_PACKETS]	 = XXV_STAT_RX_TOTAL_PACKETS_OFFSET,
+	[XXV_STAT_RX_TOTAL_GOOD_PACKETS] = XXV_STAT_RX_TOTAL_GOOD_PACKETS_OFFSET,
+	[XXV_STAT_RX_TOTAL_BYTES]	 = XXV_STAT_RX_TOTAL_BYTES_OFFSET,
+	[XXV_STAT_RX_TOTAL_GOOD_BYTES]	 = XXV_STAT_RX_TOTAL_GOOD_BYTES_OFFSET,
+	[XXV_STAT_RX_BAD_FCS]		 = XXV_STAT_RX_BAD_FCS_OFFSET,
+	[XXV_STAT_RX_INRANGEERR]	 = XXV_STAT_RX_INRANGEERR_OFFSET,
+	[XXV_STAT_RX_MULTICAST]		 = XXV_STAT_RX_MULTICAST_OFFSET,
+	[XXV_STAT_RX_BROADCAST]		 = XXV_STAT_RX_BROADCAST_OFFSET,
+	[XXV_STAT_RX_UNDERSIZE]		 = XXV_STAT_RX_UNDERSIZE_OFFSET,
+	[XXV_STAT_RX_FRAGMENT]		 = XXV_STAT_RX_FRAGMENT_OFFSET,
+	[XXV_STAT_RX_JABBER]		 = XXV_STAT_RX_JABBER_OFFSET,
+	[XXV_STAT_RX_OVERSIZE]		 = XXV_STAT_RX_OVERSIZE_OFFSET,
+	[XXV_STAT_RX_PAUSE]		 = XXV_STAT_RX_PAUSE_OFFSET,
+	[XXV_STAT_TX_TOTAL_PACKETS]	 = XXV_STAT_TX_TOTAL_PACKETS_OFFSET,
+	[XXV_STAT_TX_TOTAL_GOOD_PACKETS] = XXV_STAT_TX_TOTAL_GOOD_PACKETS_OFFSET,
+	[XXV_STAT_TX_TOTAL_BYTES]	 = XXV_STAT_TX_TOTAL_BYTES_OFFSET,
+	[XXV_STAT_TX_TOTAL_GOOD_BYTES]	 = XXV_STAT_TX_TOTAL_GOOD_BYTES_OFFSET,
+	[XXV_STAT_TX_BAD_FCS]		 = XXV_STAT_TX_BAD_FCS_OFFSET,
+	[XXV_STAT_TX_FRAME_ERROR]	 = XXV_STAT_TX_FRAME_ERROR_OFFSET,
+	[XXV_STAT_TX_MULTICAST]		 = XXV_STAT_TX_MULTICAST_OFFSET,
+	[XXV_STAT_TX_BROADCAST]		 = XXV_STAT_TX_BROADCAST_OFFSET,
+	[XXV_STAT_TX_PAUSE]		 = XXV_STAT_TX_PAUSE_OFFSET,
+};
+
+/* XXV (PG210) counters exposed via ethtool -S. Only counters that have no
+ * standard uAPI are listed here; the totals include errored frames, so they
+ * are distinct from the good-frame counts in rtnl_link_stats64 and the
+ * IEEE MAC statistics. Every other XXV counter is reported through the
+ * dedicated stats64, pause, MAC and RMON callbacks instead.
+ */
+static const enum xxv_stat axienet_xxv_priv_stats[] = {
+	XXV_STAT_RX_TOTAL_PACKETS,
+	XXV_STAT_RX_TOTAL_BYTES,
+	XXV_STAT_TX_TOTAL_PACKETS,
+	XXV_STAT_TX_TOTAL_BYTES,
+	XXV_STAT_TX_BAD_FCS,
+	XXV_STAT_TX_FRAME_ERROR,
+};
+
+static const char axienet_xxv_ethtool_stats_strings[][ETH_GSTRING_LEN] = {
+	"RX Total Packets",
+	"RX Total Bytes",
+	"TX Total Packets",
+	"TX Total Bytes",
+	"TX Bad FCS",
+	"TX Frame Error",
+};
+
+static u64 axienet_xxv_read_counter(struct axienet_local *lp, enum xxv_stat stat)
+{
+	u32 off = axienet_xxv_stat_offsets[stat];
+	u32 lsb, msb;
+
+	lsb = axienet_ior(lp, off);
+	msb = axienet_ior(lp, off + XXV_STAT_MSB_OFFSET);
+
+	return ((u64)msb << 32) | lsb;
+}
+
 static bool axienet_xxv_ip_has_gtwiz_status(u32 ip_version)
 {
 	u8 minor = FIELD_GET(XXV_MIN_MASK, ip_version);
@@ -134,6 +199,7 @@ static void axienet_xxv_setoptions(struct net_device *ndev, u32 options)
 static void axienet_xxv_probe_init(struct axienet_local *lp)
 {
 	lp->xxv_ip_version = axienet_ior(lp, XXV_CONFIG_REVISION);
+	lp->features |= XAE_FEATURE_STATS;
 }
 
 /**
@@ -314,6 +380,198 @@ static int axienet_10g25g_clk_init(struct axienet_local *lp)
 	return 0;
 }
 
+/**
+ * axienet_xxv_stats_update - Latch and accumulate XXV hardware counters
+ * @lp: Pointer to the axienet_local structure
+ *
+ * The XXV statistics counters are clear-on-tick (PG210): writing TICK_REG
+ * latches the internal accumulators into the readable STAT_*_LSB/MSB registers
+ * and clears the internal accumulators. Each post-TICK read therefore returns
+ * the count for the interval since the previous TICK, so software accumulates
+ * those intervals into lp->xxv_stat_base. A last-counter delta (as used by the
+ * free-running 1G MAC path) is not needed.
+ */
+static void axienet_xxv_stats_update(struct axienet_local *lp)
+{
+	u64 counter[XXV_STAT_COUNT];
+	enum xxv_stat stat;
+
+	/* Latch the clear-on-tick snapshot and read the counters outside the
+	 * seqcount write section, so only the accumulator updates run inside it
+	 * and the reader retry window stays short.
+	 */
+	axienet_iow(lp, XXV_TICKREG_OFFSET, XXV_TICKREG_STATEN_MASK);
+	for (stat = 0; stat < XXV_STAT_COUNT; stat++)
+		counter[stat] = axienet_xxv_read_counter(lp, stat);
+
+	write_seqcount_begin(&lp->hw_stats_seqcount);
+	for (stat = 0; stat < XXV_STAT_COUNT; stat++)
+		lp->xxv_stat_base[stat] += counter[stat];
+	write_seqcount_end(&lp->hw_stats_seqcount);
+}
+
+/**
+ * axienet_xxv_get_stats64 - Fill rtnl_link_stats64 from XXV counters
+ * @lp: Pointer to the axienet_local structure
+ * @stats: Output rtnl_link_stats64 structure to populate
+ */
+static void axienet_xxv_get_stats64(struct axienet_local *lp,
+				    struct rtnl_link_stats64 *stats)
+{
+	unsigned int start;
+	u64 tx_hw_errors;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		stats->rx_crc_errors = lp->xxv_stat_base[XXV_STAT_RX_BAD_FCS];
+		/* Both in-range length errors and frame-too-long (oversize)
+		 * frames are IEEE 802.3 length errors, so fold them together
+		 * into rx_length_errors; rx_over_errors is reserved for receiver
+		 * FIFO/ring overflow, which the XXV MAC does not expose.
+		 */
+		stats->rx_length_errors =
+			lp->xxv_stat_base[XXV_STAT_RX_INRANGEERR] +
+			lp->xxv_stat_base[XXV_STAT_RX_OVERSIZE];
+		stats->rx_errors = lp->xxv_stat_base[XXV_STAT_RX_UNDERSIZE] +
+				   lp->xxv_stat_base[XXV_STAT_RX_FRAGMENT] +
+				   lp->xxv_stat_base[XXV_STAT_RX_JABBER] +
+				   stats->rx_crc_errors +
+				   stats->rx_length_errors;
+		stats->multicast = lp->xxv_stat_base[XXV_STAT_RX_MULTICAST];
+		tx_hw_errors = lp->xxv_stat_base[XXV_STAT_TX_BAD_FCS] +
+			       lp->xxv_stat_base[XXV_STAT_TX_FRAME_ERROR];
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+
+	/* Fold the HW TX error count into the software tx_errors seeded from
+	 * dev->stats by the caller. The XXV xmit path bumps dev->stats.tx_errors
+	 * for frames dropped on pad failure before they reach the MAC, while the
+	 * HW counters only cover frames the MAC actually transmitted; the two are
+	 * disjoint. This runs once, outside the seqcount retry loop, so a racing
+	 * stats update cannot make the accumulation re-add on retry.
+	 */
+	stats->tx_errors += tx_hw_errors;
+}
+
+/**
+ * axienet_xxv_get_ethtool_stats - Copy XXV counters for ethtool -S
+ * @lp: Pointer to the axienet_local structure
+ * @data: Output buffer sized for ARRAY_SIZE(axienet_xxv_priv_stats) u64 values
+ */
+static void axienet_xxv_get_ethtool_stats(struct axienet_local *lp, u64 *data)
+{
+	unsigned int i, start;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		for (i = 0; i < ARRAY_SIZE(axienet_xxv_priv_stats); i++)
+			data[i] = lp->xxv_stat_base[axienet_xxv_priv_stats[i]];
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+}
+
+/**
+ * axienet_xxv_get_strings - Copy XXV ethtool statistics name strings
+ * @data: Output buffer for the statistics name strings
+ */
+static void axienet_xxv_get_strings(u8 *data)
+{
+	memcpy(data, axienet_xxv_ethtool_stats_strings,
+	       sizeof(axienet_xxv_ethtool_stats_strings));
+}
+
+/**
+ * axienet_xxv_get_sset_count - Number of XXV ethtool statistics
+ *
+ * Return: Count of XXV hardware statistics reported via ethtool -S.
+ */
+static int axienet_xxv_get_sset_count(void)
+{
+	return ARRAY_SIZE(axienet_xxv_ethtool_stats_strings);
+}
+
+/**
+ * axienet_xxv_get_pause_stats - Fill ethtool pause frame statistics
+ * @lp: Pointer to the axienet_local structure
+ * @pause_stats: Output ethtool_pause_stats structure to populate
+ */
+static void axienet_xxv_get_pause_stats(struct axienet_local *lp,
+					struct ethtool_pause_stats *pause_stats)
+{
+	unsigned int start;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		pause_stats->tx_pause_frames =
+			lp->xxv_stat_base[XXV_STAT_TX_PAUSE];
+		pause_stats->rx_pause_frames =
+			lp->xxv_stat_base[XXV_STAT_RX_PAUSE];
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+}
+
+/**
+ * axienet_xxv_get_eth_mac_stats - Fill IEEE 802.3 MAC statistics
+ * @lp: Pointer to the axienet_local structure
+ * @mac_stats: Output ethtool_eth_mac_stats structure to populate
+ */
+static void axienet_xxv_get_eth_mac_stats(struct axienet_local *lp,
+					  struct ethtool_eth_mac_stats *mac_stats)
+{
+	unsigned int start;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		mac_stats->FramesTransmittedOK =
+			lp->xxv_stat_base[XXV_STAT_TX_TOTAL_GOOD_PACKETS];
+		mac_stats->FramesReceivedOK =
+			lp->xxv_stat_base[XXV_STAT_RX_TOTAL_GOOD_PACKETS];
+		mac_stats->OctetsTransmittedOK =
+			lp->xxv_stat_base[XXV_STAT_TX_TOTAL_GOOD_BYTES];
+		mac_stats->OctetsReceivedOK =
+			lp->xxv_stat_base[XXV_STAT_RX_TOTAL_GOOD_BYTES];
+		mac_stats->FrameCheckSequenceErrors =
+			lp->xxv_stat_base[XXV_STAT_RX_BAD_FCS];
+		mac_stats->MulticastFramesXmittedOK =
+			lp->xxv_stat_base[XXV_STAT_TX_MULTICAST];
+		mac_stats->BroadcastFramesXmittedOK =
+			lp->xxv_stat_base[XXV_STAT_TX_BROADCAST];
+		mac_stats->MulticastFramesReceivedOK =
+			lp->xxv_stat_base[XXV_STAT_RX_MULTICAST];
+		mac_stats->BroadcastFramesReceivedOK =
+			lp->xxv_stat_base[XXV_STAT_RX_BROADCAST];
+		mac_stats->InRangeLengthErrors =
+			lp->xxv_stat_base[XXV_STAT_RX_INRANGEERR];
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+}
+
+/**
+ * axienet_xxv_get_rmon_stats - Fill RMON statistics and histogram ranges
+ * @lp: Pointer to the axienet_local structure
+ * @rmon_stats: Output ethtool_rmon_stats structure to populate
+ * @ranges: Set to the RMON histogram range table
+ */
+static void axienet_xxv_get_rmon_stats(struct axienet_local *lp,
+				       struct ethtool_rmon_stats *rmon_stats,
+				       const struct ethtool_rmon_hist_range **ranges)
+{
+	unsigned int start;
+
+	do {
+		start = read_seqcount_begin(&lp->hw_stats_seqcount);
+		rmon_stats->undersize_pkts =
+			lp->xxv_stat_base[XXV_STAT_RX_UNDERSIZE];
+		rmon_stats->oversize_pkts =
+			lp->xxv_stat_base[XXV_STAT_RX_OVERSIZE];
+		rmon_stats->fragments =
+			lp->xxv_stat_base[XXV_STAT_RX_FRAGMENT];
+		rmon_stats->jabbers =
+			lp->xxv_stat_base[XXV_STAT_RX_JABBER];
+	} while (read_seqcount_retry(&lp->hw_stats_seqcount, start));
+
+	/* XXV currently exposes only aggregate RMON counters, not per-bin
+	 * histogram buckets. Keep ranges NULL until histogram bins are wired.
+	 */
+	*ranges = NULL;
+}
+
 const struct axienet_config axienet_10g25g_config = {
 	.sw_padding = true,
 	.internal_pcs = true,
@@ -326,4 +584,12 @@ const struct axienet_config axienet_10g25g_config = {
 	.get_regs = axienet_xxv_get_regs,
 	.phylink_set_caps = axienet_xxv_phylink_set_capabilities,
 	.pcs_ops = &axienet_xxv_pcs_ops,
+	.stats_update = axienet_xxv_stats_update,
+	.get_stats64 = axienet_xxv_get_stats64,
+	.get_ethtool_stats = axienet_xxv_get_ethtool_stats,
+	.get_strings = axienet_xxv_get_strings,
+	.get_sset_count = axienet_xxv_get_sset_count,
+	.get_pause_stats = axienet_xxv_get_pause_stats,
+	.get_eth_mac_stats = axienet_xxv_get_eth_mac_stats,
+	.get_rmon_stats = axienet_xxv_get_rmon_stats,
 };
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h
index 15a323ee05b2..ebfa7d57a859 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.h
@@ -63,6 +63,33 @@ struct axienet_config;
 #define XXV_STAT_GTWIZ_OFFSET		0x000004A0
 #define XXV_STAT_AN_LINK_CTL2_OFFSET	0x000009F0
 
+/* XXV statistics counter registers (PG210). Each counter is a pair of 32-bit
+ * registers; the MSB register is XXV_STAT_MSB_OFFSET bytes above the LSB.
+ */
+#define XXV_STAT_MSB_OFFSET			4
+#define XXV_STAT_TX_FRAME_ERROR_OFFSET		0x000006A0
+#define XXV_STAT_TX_TOTAL_PACKETS_OFFSET	0x00000700
+#define XXV_STAT_TX_TOTAL_GOOD_PACKETS_OFFSET	0x00000708
+#define XXV_STAT_TX_TOTAL_BYTES_OFFSET		0x00000710
+#define XXV_STAT_TX_TOTAL_GOOD_BYTES_OFFSET	0x00000718
+#define XXV_STAT_TX_BAD_FCS_OFFSET		0x000007B8
+#define XXV_STAT_TX_MULTICAST_OFFSET		0x000007D8
+#define XXV_STAT_TX_BROADCAST_OFFSET		0x000007E0
+#define XXV_STAT_TX_PAUSE_OFFSET		0x000007F0
+#define XXV_STAT_RX_TOTAL_PACKETS_OFFSET	0x00000808
+#define XXV_STAT_RX_TOTAL_GOOD_PACKETS_OFFSET	0x00000810
+#define XXV_STAT_RX_TOTAL_BYTES_OFFSET		0x00000818
+#define XXV_STAT_RX_TOTAL_GOOD_BYTES_OFFSET	0x00000820
+#define XXV_STAT_RX_UNDERSIZE_OFFSET		0x00000898
+#define XXV_STAT_RX_FRAGMENT_OFFSET		0x000008A0
+#define XXV_STAT_RX_OVERSIZE_OFFSET		0x000008A8
+#define XXV_STAT_RX_JABBER_OFFSET		0x000008B8
+#define XXV_STAT_RX_BAD_FCS_OFFSET		0x000008C0
+#define XXV_STAT_RX_MULTICAST_OFFSET		0x000008E0
+#define XXV_STAT_RX_BROADCAST_OFFSET		0x000008E8
+#define XXV_STAT_RX_PAUSE_OFFSET		0x000008F8
+#define XXV_STAT_RX_INRANGEERR_OFFSET		0x00000908
+
 /* XXV MAC Register Mask Definitions */
 #define XXV_GT_RESET_MASK		BIT(0)
 #define XXV_TC_TX_MASK			BIT(0)
@@ -70,6 +97,7 @@ struct axienet_config;
 #define XXV_RCW1_FCS_MASK		BIT(1)
 #define XXV_TC_FCS_MASK			BIT(1)
 #define XXV_RX_BLKLCK_MASK		BIT(0)
+#define XXV_TICKREG_STATEN_MASK		BIT(0)
 #define XXV_GTWIZ_RESET_DONE		(BIT(0) | BIT(1))
 #define XXV_MAJ_MASK			GENMASK(7, 0)
 #define XXV_MIN_MASK			GENMASK(15, 8)
@@ -81,6 +109,33 @@ struct axienet_config;
 #define XXV_STAT_CORE_SPEED_10G_MASK	BIT(0)
 #define XXV_RX_STATUS_MASK		BIT(0)
 
+/* XXV (10G/25G) MAC statistics counters, used to index xxv_stat_base[]. */
+enum xxv_stat {
+	XXV_STAT_RX_TOTAL_PACKETS = 0,
+	XXV_STAT_RX_TOTAL_GOOD_PACKETS,
+	XXV_STAT_RX_TOTAL_BYTES,
+	XXV_STAT_RX_TOTAL_GOOD_BYTES,
+	XXV_STAT_RX_BAD_FCS,
+	XXV_STAT_RX_INRANGEERR,
+	XXV_STAT_RX_MULTICAST,
+	XXV_STAT_RX_BROADCAST,
+	XXV_STAT_RX_UNDERSIZE,
+	XXV_STAT_RX_FRAGMENT,
+	XXV_STAT_RX_JABBER,
+	XXV_STAT_RX_OVERSIZE,
+	XXV_STAT_RX_PAUSE,
+	XXV_STAT_TX_TOTAL_PACKETS,
+	XXV_STAT_TX_TOTAL_GOOD_PACKETS,
+	XXV_STAT_TX_TOTAL_BYTES,
+	XXV_STAT_TX_TOTAL_GOOD_BYTES,
+	XXV_STAT_TX_BAD_FCS,
+	XXV_STAT_TX_FRAME_ERROR,
+	XXV_STAT_TX_MULTICAST,
+	XXV_STAT_TX_BROADCAST,
+	XXV_STAT_TX_PAUSE,
+	XXV_STAT_COUNT,
+};
+
 extern const struct axienet_config axienet_10g25g_config;
 
 #endif /* XILINX_AXIENET_XXV_H */
-- 
2.25.1

