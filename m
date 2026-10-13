Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03F4F30F7;
	Tue, 13 Oct 2026 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891931; cv=fail; b=TJPLRNRBzZuqLHT+ccjvs8v/cALOvEdfXf1cYYn86WBTtrb0AV+J0yKZ3IlxdUyby6vpT6IlDgb1Fax8n+21qxh/6ZFo4sMJvN9KbJCqbwOlf7MoNl4ZRgZZ1csC5yV7NsQ/mS8x5b12aKpvv8iNTaa5Wwj2gI0x+JUygpzKETE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891931; c=relaxed/simple;
	bh=OKClhMTLIcLVgS4n+U0qOFGaq1HHA5aS730Kli9+xXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/OMmkpi4aqEVz5qGpdtpwGrjdrzPSzvPt6ZilcCfAbODaKPyNQw8zcsOtMrY7Tx/4noDKD+ZnM3YyhA0C8uAAZZeV9qrK4hMIxeMOPf9JndsapZK/SKczvPpAvDsKt7eS/Qq6erkhR2aQEE7RDb7dbROajK9FEwUXoeE4VL5DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=kUsuUqRF; arc=fail smtp.client-ip=52.101.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="kUsuUqRF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOtaOFL/kB6TdYYNDbZS5mCQva7TGRwlmYtw5n+j3jDQNYitPGOCQtrOvSd2qHdNI5ainw+ygF8hFC7zqUIw42En14ovnhb60QBJaj+ozX+73ihUah1aGAtFnZ//4kjsOGBBboH9o1rOCuhmA6B/b8Cd8V+XAh3mVa8DA65zDf3EYOZ/4R82MkwAiBnw9CITFd9mbzMjdUv70AQtkDTrgc1DvIhH10M6YrqHKmpa1zzjsF6akqFYl+sLWlS4tniEFg8buUY/ON07KQ1WC0sa8PfhXhjEgNb+8D17Nrxz/9EOfYv+9gQV6JJ+5NUnY8GBF8fYjjpPD5MZeyZkfB9Zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXIJ8xkcncFbQkpA/INiogKRasKZvPb0dIiPW9fm01k=;
 b=hOrDUKCm2o6wT9NB7PjMvhUKe5H/UOx3/CEhC5M6yLJ238dsZxcktga9LXLEjRDnJCM7RgA7TNGxbmx5SEFZGvOgipKGwD5djiQTgev4yE5IsCThcfAciZfwSluFCuSZFwGy47XomdDIE9KjMO6wuWGBzscVqRWpibf8iXLVD9OAO+DI3rCx7ee3XMzAzR9xC3Fn7mg5eNAIL4pUV42WJL+yGPIF3emoRjVue2S7Hk7LWGQzlHtb5rMlok5l4InQtShDzGOTIxXdo47sOSViCCgYzgmHE3lsWcD6h9P5Q1ssf1biNS36UrTP/Vo8WEIGmU5sX1WtnRHdFBebUfcbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXIJ8xkcncFbQkpA/INiogKRasKZvPb0dIiPW9fm01k=;
 b=kUsuUqRFNVb7BcwL3haCmB+PllaxqP0vAJkPy3ybLW/GWdG7X9D50YPYXMxSCCE8XGVVKcvTRP51IyI7IwzQvyl5N53CgsM0xDD8HLQ0fdIlUOFFlszzFwmXPYFFoNFL9Qu9rJFj85ZTiGhMqYrRvmsJ1D7dD1xOJ/MtlCIZ1wc=
Received: from OS3PR01CA0075.jpnprd01.prod.outlook.com (2603:1096:604:da::8)
 by TYRPR01MB13740.jpnprd01.prod.outlook.com (2603:1096:405:18e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:45:24 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:da:cafe::d) by OS3PR01CA0075.outlook.office365.com
 (2603:1096:604:da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 11:45:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 11:45:22 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 37880300026D;
	Tue, 13 Oct 2026 20:45:17 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	xiaoliang.yang_1@nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net 2/2] net: stmmac: Report the TX DMA threshold per queue
Date: Tue, 13 Oct 2026 11:45:03 +0000
Message-ID: <20261013114503.57487-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
References: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|TYRPR01MB13740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7399e220-82d7-42c1-a0df-08df291f76f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|11063799006|56012099006|18002099003|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5ZXZ7VtQVhtPuk/WBdOpowdsViRmDL8NzTjsiDJmLDShSfLQMnhNCSfcAf9lYc5UYdp005S7IpvDu4lPSEOZvN1XK/nTNbk0c3hNKOZZYtYwD2wkwN3OOD8xD6lsBvUMXeh15Lfnx+3JQCeCosDo8BvPiOOr/4k+MhBy+pp+OMPDr6TI6fv1OPQ6lRki+J/WkpHZPoF13I1fVoaYbVg7sIqxuIpURsDRT9zpUBZnRG+xLP7sYVM0zam/XvGHpR56sRnNm50XmvsyKyilUOWr87pEopAErAEtLMfFBOUNnAcHQvIdX2o23YxsxM64yEjODtyWC5NY3pwT/4jEAQ4G6c0ReO0a3oY0fhqYDj6q/99x/+4T2VwAbsQ8R+WnixojfXBGVdpguf/AUqLQMtaUds88rZ6+9/RdwYHvQDT4TA1ngDLHWuRQHTfDbskBSJeaBNSVXztcWxlY2yM4SNabrol4Su1KBNpE2FhPAIr6wc1yhsvvPzoewXzUaD40BcorG94hpK0rx/BFhAvdYBqkfd/ldRki4yPo9LXWx0LNxvTOhLURVDip4gNP0RuTf4ZvU5Jdai0pKQuv3MdRiO8NvCB5739VKs51+nTwdC8Pq+GbFOLssK4PrjrVLRjL6Z7Cdx5PSqY8vLaRm765k+8Tb6+EyLx73WaZ2UQpCbX/9c2DOy3KFqRbv0H+iIchzxcX3LMApxzoxMHAtHahopiWLw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P0ZLqLv4hPngVOlexAgWBFSazTF0mIlny9FlJ+6EE2aoKUEP9xJVwFZf7+EtlJ9F16dK32u6rs9FfTqX2yDIIZJ5htDZX3fcOQqpY1GUMsJDQsj0b5keP4HcxVHJRG1QgL+WoH1PZUlnvt5XZjmKpYY3v+2+9/OplYa5wY9eZ8Ah5csOXx4QGGTTZMlnvIj+nndzetg4V4/jG8N0U0UTzqiYtvadHGrjugw6mY2zgyxdf6jJLLZ37Ix8Xj8duqsq0ZBueGJSd5Bs2J5l/t6snAxR4mz7QzfXQewZ4bXYc+axQ8QoNHCHeSeVY1hj+91KUwp81exxb1gmfqvvq0IaaR66QHS2yLhhK00ZtHncLbEq+RVAAaUW9IH0bkGa+PwHtEe0GsjPsTrM9gYHrnO8ZK0e0SH8KUSotbyLvui+obxWSOxvIpqmQWjn7BjKWhRy
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:45:22.5797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7399e220-82d7-42c1-a0df-08df291f76f5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13740

The "threshold" ethtool statistic reports a single TX DMA threshold for
the whole device. However, since commit d62a107a4f15 ("net: stmmac:
prepare dma interrupt treatment for multiple queues"), a single TX DMA
threshold per device doesn't make sense anymore, as each individual queue
that underflows gets its threshold increased, so the queues are out of
sync.

To make the reporting accurate, remove it and report the threshold of
each TX queue instead, as "qN_tx_threshold".

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h         | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 1729fb29ece3..c74bc7c9750e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -158,7 +158,6 @@ struct stmmac_extra_stats {
 	unsigned long fatal_bus_error_irq;
 	/* Tx/Rx IRQ Events */
 	unsigned long rx_early_irq;
-	unsigned long threshold;
 	unsigned long irq_receive_pmt_irq_n;
 	/* MMC info */
 	unsigned long mmc_tx_irq_n;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 30e0d499326d..c616a1c95e5d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -89,7 +89,6 @@ static const struct stmmac_stats stmmac_gstrings_stats[] = {
 	STMMAC_STAT(fatal_bus_error_irq),
 	/* Tx/Rx IRQ Events */
 	STMMAC_STAT(rx_early_irq),
-	STMMAC_STAT(threshold),
 	STMMAC_STAT(irq_receive_pmt_irq_n),
 	/* MMC info */
 	STMMAC_STAT(mmc_tx_irq_n),
@@ -289,6 +288,7 @@ static const struct stmmac_stats stmmac_mmc[] = {
 static const char stmmac_qstats_tx_string[][ETH_GSTRING_LEN] = {
 	"tx_pkt_n",
 	"tx_irq_n",
+	"tx_threshold",
 #define STMMAC_TXQ_STATS ARRAY_SIZE(stmmac_qstats_tx_string)
 };
 
@@ -496,6 +496,7 @@ static void stmmac_get_per_qstats(struct stmmac_priv *priv, u64 *data)
 
 		*data++ = pkt_n;
 		*data++ = stmmac_get_tx_normal_irq_n(priv, q);
+		*data++ = priv->tx_threshold[q];
 	}
 
 	for (q = 0; q < rx_cnt; q++) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b5ee0f297df6..2fed7713e376 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2633,7 +2633,6 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 		 */
 		txmode = SF_DMA_MODE;
 		rxmode = SF_DMA_MODE;
-		priv->xstats.threshold = SF_DMA_MODE;
 	} else {
 		rxmode = SF_DMA_MODE;
 	}
@@ -2836,7 +2835,6 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
 		stmmac_set_dma_operation_mode(priv, thresh, SF_DMA_MODE, chan);
 
 	priv->tx_threshold[chan] = thresh;
-	priv->xstats.threshold = thresh;
 }
 
 /**
@@ -8135,8 +8133,6 @@ static int __stmmac_dvr_probe(struct device *device,
 #endif
 	priv->msg_enable = netif_msg_init(debug, default_msg_level);
 
-	priv->xstats.threshold = tc;
-
 	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
 		priv->tx_threshold[i] = tc;
 
-- 
2.34.1

