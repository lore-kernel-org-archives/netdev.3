Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A683CB2E0;
	Wed,  5 Aug 2026 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904937; cv=fail; b=Cfjhn3HM6viu/7I3nWh8FcC2jH2nGhjE2swOVbdKpC5VwM0H0+fDppuGQHf8KfQibGIdBGqC9v2Hv3eKhfbDog/CrzykjqZDCik3AJqoi4DKxQwB2wmuzxE1qGhZP/8Mp+7BGMo0XD1p5Og/thxfadA/GYQe54vpxi/fQ/ta06o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904937; c=relaxed/simple;
	bh=jPmiNlc74RPA1iGT0VDnGGq1VJ2Fxls0TP/fASM1cGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxLkrf8L6Gq8dcTO+wDpgWCTBGydl78bwgZInfc7zzUgnW2raAYcTaaHngyb69C4Ybpl4mkW2IDP2SI/9kSJ6Z3hqiugFgIOHqpjHpcm3hlEbrBisb7+oTSrOouC/QzRW5gQvNxIU7PzptEI3Ax+M2owpcgZBs31Er7ya1YY49s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4xRPLWOX; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4xRPLWOX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KglRcojc5lYvI2rtYfVU8FMcofUhp4/01YS2L5wOf4yObnA/V5uO3N1Ej84cRcfq5Mor22ty5x4u+GfjoD9RlrNpTRrX3a7IMCq+kUkDouxd5h7wYcB7XO0upy2HgevZPDZNDXnZHRuybXr8CH6aDJHAViDiJEXi8f+6CL0CpQ0AG1fX1ZzNpZEsNJ8nJ4V21oZLGx8dF6jwOUM9Lhg1CxK/wBXE27QuucrX0e8nVP5Sxaim+qXj5eVTDQfQemwUhwue7hBcxKCZABCuu34wnh9yXEFiLPSFrAaEi0DwMzYoYmRX/6P+RanjMt+VgAwQwbHlWX40C9yq1qtorUK6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWwQJ6a71jcxKhjd/RO0XfDaYwuqBFPHYWdZnWWryR0=;
 b=UVD/eY2TOBE9mmIWn5B6v2ItDnMFxZ51t+i3OoMDrEe3WCKpdY64d5MCPJbI21iIM6zIDupnXWT7NPk3ruvGwB01/LxIjTJ8wfYuaDvn5fHUBoc5jAYX3+Dfa3hAD7qHf5oZbuuVj7SuzMKy5SUkmzwJZREy2WQe5zRu4JnS6EoDZg6CEMfb3WTZIjFg2Uo7s3ToLgFxK5wRZCWFciBOGtEGzY8Gt2gezFnu1QuIX89aS8M/GMCVpMP68r4iysGfxkbwLosQ1P5jB6BPsUrEBFcbzQeWBqc7+1NwiGGaSJq2qPtkxSi4qTttzPrz8ZBP/hofo0qHAZEHRIYQ2v9qfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWwQJ6a71jcxKhjd/RO0XfDaYwuqBFPHYWdZnWWryR0=;
 b=4xRPLWOXClq+msgqugbfsgRYYlQsmMVcyGWLNZFH2HwcXKpERIeyMI+DsSb6A7yOcFZmWxad0rPkkWASW1wqc+7kmmb7Mq3aV0DdhgWXkR00Ry1+SFL7BJItCFJoLUTGSR8PJ4BjwBhaTkyFI/QWW2UAyiWKx83NHWsXn4Qc6jo=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by IA5PR12MB999277.namprd12.prod.outlook.com (2603:10b6:208:608::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 04:42:11 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::89) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Wed, 5
 Aug 2026 04:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Wed, 5 Aug 2026 04:42:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 23:42:08 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 4 Aug 2026 23:42:05 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: macb: configure ENST registers for all queues
Date: Wed, 5 Aug 2026 10:12:04 +0530
Message-ID: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|IA5PR12MB999277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eca46c9-a1bf-4552-9ef2-08def2abe9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|11063799006|3023799007|13003099007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CbgNEubbLxrzKJtPjFQcn8XK13aRwPjptPmT6x3CVbUuLqSG5ZXCBo8nRWFqtU9WStpOXabz9l2f/+6WHyiZLJgr5rAfpDzodmAY7S2+JEMLj0qENLC/wHjeJr1UvQVkJsGstRKrPgjxeh07vlLtXNeUpp0RQKjIMV1d33EkLn02AQ4DIkRg+dQ/XO0kKWk5hpp+ZxOivh0rog6MvvgTqBq3z/8t1j7FuFb9mYoePAryMQgKXJd5ZJwgOGV3vFvua4klh+l+Cre+31AfijS1tv8aDF0krXt+34BlOJ7ZKHnlznsCsyQp3p4ARu5NgpzVm5CRbmGMgypnPcXpFxqadLr8tcoOkkDaW1RdNdhc7qmILnAnYnu9qzTHaE87K5mG+iZzWQgaCIbWF96jlajgMwqSxa4uEZsDiN8TQ9cIB3xEyPb62U+tv5Nw6I7Xj+RqbLvOR0AfWS+H8UW0szjieLSiKDxJkgt6ql6Rw2gz4Ao7AE6dnJKZxcWjo5f936/OrHfo/VE2F4jOEJtchWSLe4QDuBzaU0I9C05jurkHpr7phlm/PDK/Q1UMavzcRDyFx4UjXzj/t7AXVE3EOfQXrhQmBL5PebCiRphddiwK3kZueqsFkQI3spxvF3ep0XZBUx4Z23JBuJZZKFYkEjxD6Egb5i783fVxMafnLakc5T/Kr/vhYhJe/1l9P/ZAGlEWvX/xeB1RbcO+Yrj6tsq5OQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(11063799006)(3023799007)(13003099007)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Y07oSipLZVcUTFnCAEM6JCt+RJN7z6KMZYlJIGszN2vQ+f06bKWbDoNUpUmpcga3uPCQ7pREVArS5EnJOiLBDRMEa4vp6Tlj3PT91YmWYyadcdqh9u8i27Ca0J2jU7HAPhhNAI4u2OmZP6kGuU0tXeQO4XVePglCeyzExW92ir3jbqjy2Ht2GjZVmw5bXldRXeYUnJb7ey60DZRGR+h2Em7bQHy32bFnCNeFTfJqczArgDQtqXMQAM+kNWZD81MPvP+YOGbw6m6nIxj7mxJG+wBNQQloeeqx4kJPnD3nCxt48X7ktBUa1ldsSrcODK4Oxw2E4yI3Yxz5h9tSrLeA6t4NfqHxVwc0UCscyX5IKuDKrNBUBfqdEYLEWd9qnIhDAtseR7RxIiaYgdiWXsD3hoWmFVz6IKo6RSSmjbpSB45SyX+fs9GURTvpTP+Yt4j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 04:42:10.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eca46c9-a1bf-4552-9ef2-08def2abe9a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999277

When a taprio config only covered a subset of queues, the driver
programmed the ENST registers only for the queues named in the config
and left the remaining queues holding stale register values. This
produced an inconsistent hardware setup that affected the scheduling
of the configured queues.

This was observed on a GEM instance with four hardware queues, all
enabled:

Initial configuration:
- All four queues are enabled.
- enst_on_time_qX registers are left at their reset value (0x0001FFFF).
- Only q0 and q1 are configured with valid, non-overlapping ENST
  schedules (T0 and T1 respectively).
- Traffic streams p0 and p1 are bound to q0 and q1.
- ENST is enabled only on q0 and q1.

Observed behavior:
- During T0 on-time, both p0 and p1 packets are transmitted.
- During T1 on-time, both p0 and p1 packets are transmitted.

With the unused queues (q2 and q3) explicitly programmed with
enst_on_time = 0x0:
- During T0 on-time, only p0 packets are transmitted.
- During T1 on-time, only p1 packets are transmitted.

Leaving the ENST on-time registers of unused queues at their reset
value (0x0001FFFF) disrupts the scheduling of the configured queues,
whereas programming them with 0x0 yields the expected ENST operation.

Program the ENST registers for every queue unconditionally. The
per-queue configuration array is now allocated for bp->num_queues and
indexed directly by queue_id; unconfigured queues are left
zero-initialized by kcalloc(), so their registers are cleared.
Indexing the array by queue_id also makes the queue_id field in
struct macb_queue_enst_config redundant, so drop it.

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v2:
- Split the patches for net and net-next.
- Updated commit message
- Link to v1 : https://lore.kernel.org/netdev/20260724043257.2221030-1-vineeth.karumanchi@amd.com/
---
 drivers/net/ethernet/cadence/macb.h      |  2 --
 drivers/net/ethernet/cadence/macb_main.c | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2de56017ee0d..0ee857c985fa 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1496,7 +1496,6 @@ struct macb_platform_data {
  * @start_time_mask:  Bitmask representing the start time for the queue
  * @on_time_bytes:    "on" time nsec expressed in bytes
  * @off_time_bytes:   "off" time nsec expressed in bytes
- * @queue_id:         Identifier for the queue
  *
  * This structure holds the configuration parameters for an ENST queue,
  * used to control time-based transmission scheduling in the MACB driver.
@@ -1505,7 +1504,6 @@ struct macb_queue_enst_config {
 	u32 start_time_mask;
 	u32 on_time_bytes;
 	u32 off_time_bytes;
-	u8 queue_id;
 };
 
 #endif /* _MACB_H */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d394f1f43b68..d58430fe9c41 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4329,7 +4329,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 	struct macb_queue *queue;
 	u32 queue_mask;
 	u8 queue_id;
-	size_t i;
+	size_t i, q;
 	int err;
 
 	if (conf->num_entries > bp->num_queues) {
@@ -4357,7 +4357,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		return -EINVAL;
 	}
 
-	enst_queue = kcalloc(conf->num_entries, sizeof(*enst_queue), GFP_KERNEL);
+	enst_queue = kcalloc(bp->num_queues, sizeof(*enst_queue), GFP_KERNEL);
 	if (unlikely(!enst_queue))
 		return -ENOMEM;
 
@@ -4416,13 +4416,12 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 			goto cleanup;
 		}
 
-		enst_queue[i].queue_id = queue_id;
-		enst_queue[i].start_time_mask =
+		enst_queue[queue_id].start_time_mask =
 			(start_time_sec << GEM_START_TIME_SEC_OFFSET) |
 			start_time_nsec;
-		enst_queue[i].on_time_bytes =
+		enst_queue[queue_id].on_time_bytes =
 			enst_ns_to_hw_units(entry->interval, speed);
-		enst_queue[i].off_time_bytes =
+		enst_queue[queue_id].off_time_bytes =
 			enst_ns_to_hw_units(conf->cycle_time - entry->interval, speed);
 
 		configured_queues |= entry->gate_mask;
@@ -4448,15 +4447,14 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
 		gem_writel(bp, ENST_CONTROL,
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
-		for (i = 0; i < conf->num_entries; i++) {
-			queue = &bp->queues[enst_queue[i].queue_id];
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			/* Configure queue timing registers */
 			queue_writel(queue, ENST_START_TIME,
-				     enst_queue[i].start_time_mask);
+				     enst_queue[q].start_time_mask);
 			queue_writel(queue, ENST_ON_TIME,
-				     enst_queue[i].on_time_bytes);
+				     enst_queue[q].on_time_bytes);
 			queue_writel(queue, ENST_OFF_TIME,
-				     enst_queue[i].off_time_bytes);
+				     enst_queue[q].off_time_bytes);
 		}
 
 		/* Enable ENST for all configured queues in one write */
-- 
2.44.4

