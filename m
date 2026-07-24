Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BC368D4B;
	Fri, 24 Jul 2026 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867606; cv=fail; b=j/VAn/ZWbvEYMIUCWHLA9VMfh4cxVyH9ZmN+jcMx0WcrHKcAjjgjPNfiG2GgGeyukdm3ycq6ztdEJZZx1g7jaAzqP+F9jifYWqQE9vMcSCW6+fJlS4Hm9tJ6MgsULPUcNTBLqDvLzp4YdolDec3Vc0GyvcTEttjo3gVzVReP8tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867606; c=relaxed/simple;
	bh=cmbGG/E/vzgM1G00uzU2ArL18H9E2GNZCXy0eUYg9c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOoIZhklYiCzvj6ADgCqUP19QL71yq7rFsv7+cE3vsrdjx3ogyQp0fpI0lxuCXFgr68HKOndCu6Ev5buoQdSubCUqBvzGg0e7pxz8UH5KYdPd4P+Db2K9K2FQ04ZXydQh1zfCY/MM5BSXk8I5FiKE97UtZFcLGcmTHaw1iZJS3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GETltqa3; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GETltqa3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgo+DFlTdE7J4ZrxykLsrxKl9D7pIZ2H5Vayxqp/PJl4bO5dbFbvAzP0WYMm5qdjb+toyTTRHxrrfx+x/UDIpBqqoP76k4AAs7xlv9Vw/hdWT5gOFiCoK3oFcXu2IppLDJL+1fgRsBKS82e8d6iKpXQV8pHdCfQnIkvmga9JKd3zh/Go9HVYedAM61xI4Ohw/IP2cxHBaat9p0FWneTvYZKMh1scJw/2DfWjPpLgqVGCqlo+4RxBEDIJwQv9Q61wSJIz3F6/jHNsL5/HF1mEBNiWdw2gFnawzsF6PBcYjamxQrJd/+vmymKTIvT/VaVd9uZvHhOd+t+ONKK1eKcjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzHjDUzlemrOktJW8sydxyt+1MzEOlNdercsAz+jJH0=;
 b=KfppL1PSFuXceNYFbURDCOeiefrzEKhGk/cSTrgxw01XwoTzNA0zsgOqNvJr4Wqs/eGfadOhNXgrKJooiS7aXgI5isQGJ0dq4XgbJDDO9sKQUG7XH7EQ6bWI6DvuO2OCGsu46YIkdJoKXYKEUEq0Kss+jOSVqEckWL0bYs5jMb7+bxRsiqu/8/TUAxmEPy9oJ3rL+F6lhC7VqwMoymsl4ZxqAnYRAH0/8abZTBMhyxMtfhDWpUdbt+4s1K3h3iSVXAA0Kkh7I3OGHN6yf7WPqPAkaPS2WidasRnlR1Rgp7yykGmaKzOskgQ7o7Krfqt6vKLWCYH095IZDPJ6pb/wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzHjDUzlemrOktJW8sydxyt+1MzEOlNdercsAz+jJH0=;
 b=GETltqa3UhaRjeciVcxBv15NCgfY8IiqG676wd22HeHb8ujbdC2zw7gJoVKnzdjmLJbvEJxSOiJlio1fgTmGOPBb7OVpRJlwJcWCkyCRs3kb8Ap9wylEWNlzBI2D/0zrKmh0cdL0sKq6x01KLPF/g25Qd5pHi1PtFsPn0kaNero=
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 04:33:19 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::aa) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Fri, 24
 Jul 2026 04:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 04:33:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:33:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:33:13 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 23:33:10 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: macb: configure ENST registers for all queues
Date: Fri, 24 Jul 2026 10:02:57 +0530
Message-ID: <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 338d59d2-ff9d-47f2-e1bb-08dee93caf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|56012099006|10067099003|22082099003|18002099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	zsLXaFpryY4LO9TfUe8XpKUBz22JhdUzvtz5+GPgColcnpcptvdSBn3Y9dr9b5EuK9igjuYNRbYtmq5pOy2BxSkgucBuOTrba4bMQK6uILZQXJIyI+84fb9RshUTMQf6sozcgyfU3Vlsup1QmB6KhEWC81m0QRiWz7b2bVz9qHfYpQC8a2KImcufTEMc6OVEtO6I4GmEVO5/vAhCFGRESqMZttqr9sbS9TzJeJMjdY0KzDg2cHzRWnnfxuBgvRiknMUS+dL7O+VbbqLUaFbOaL6f8yOnSDTNiOxm2KU5eUJupqkm+ZYulFv1YksTwuGeDzg2rv86tZfa7rn30LKde+7zizp3cHNiwFKh4vfoSoRdbmjf7EvrBx9nYBzSGMnMnYuDJMekowpCSCjMNnNrfPUVsY39mHS6djuniLRhyZ2soqTe4OxQ6rTvuYQsrszvb9369XabQJ9W7dzH8fqHJOASmE2m8ADc+Lfu5b70NIja9CzWQvyG/0LTLKocUP0VUPcrJv7WuVArX4yC/JM4WHnyfVgzROoK2H4Pvd1MVWeAh9tkeOU7FUQ29YAgLuX9teqheH4WPx1UZBA9bniLhf/zQql2guHNDAqCY8DR9bjrHSBLWRwpwfabl2NvNBg3Rn3ZOM4oNDyGsrSGT7aNI7JimiAeKu//hgEFTwFv7W67pCrlLeBnoZvZqrZ8ytRxcUCwrgKIibT8bqwunsoa1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6ABojwGj3gQ6GylabUAljhWNiwFp5ZVwPr76V4y1+Tmye5QyY9XItVaJtaB/HOCMMSHfM3V3pBeY0T8ygXDvfTKOMvxMphTmxMfefWgX+j8muxZH1LVRqXPgRhA/POn8DbwBh9rIiXMspTPU+NwiXQbuUOK5PzBZZ1w4V6W4ljk43W4jUDixSPovtrd8Khvws4WfOX716lUMb3vjuKQdY+PDcRCQsOQKRnj3jUpX058SHbw7ZzEcJ43tmkDWwCX8DnrSedtmvbYwTQPDySyUdRvoEyL415B9M5pf0EndmAPbhjUqR6bt8FnbzBiTloBBozW2ZNSsF6HfqQxceSR1z+n1iuzJW4cNfcwlVkG1HeGFeiPjkm8SyVPAKci5cu/tiErPvAQKSJdmVxo6WsHxsRX68Zowt8nPeApANPfQBJDaFRrrBjKlSAdiVzt8nqz3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:33:17.6163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338d59d2-ff9d-47f2-e1bb-08dee93caf06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664

The initial "tc" command was not overwriting the reset value of ENST
registers if only a subset of queues were configured, leading to an
invalid setup. To fix this, configure all queues unconditionally.
Unconfigured queues are zero-initialized via kcalloc(), ensuring a
complete and consistent configuration.

The queue_id field in struct macb_queue_enst_config becomes redundant
once the array is indexed by queue id, so drop it.

Key changes:
- Drop queue_id from struct macb_queue_enst_config
- Allocate enst_queue[] based on bp->num_queues instead of
  conf->num_entries
- Index enst_queue[] directly with the queue number
- Program ENST registers for all queues

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 --
 drivers/net/ethernet/cadence/macb_main.c | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a11052565436..4cc9aa9b2f9e 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1490,7 +1490,6 @@ struct macb_platform_data {
  * @start_time_mask:  Bitmask representing the start time for the queue
  * @on_time_bytes:    "on" time nsec expressed in bytes
  * @off_time_bytes:   "off" time nsec expressed in bytes
- * @queue_id:         Identifier for the queue
  *
  * This structure holds the configuration parameters for an ENST queue,
  * used to control time-based transmission scheduling in the MACB driver.
@@ -1499,7 +1498,6 @@ struct macb_queue_enst_config {
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

