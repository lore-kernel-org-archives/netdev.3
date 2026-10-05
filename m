Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DF2DCBE3;
	Mon,  5 Oct 2026 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198550; cv=fail; b=CesHUyNemkFUW67A0i6WLbD2au1xCILwSAPSZRwlRyKngTcwgPlfPqtfWnD0gmK9lBwOMrAciEXlaTveqlzp/haKT4yJLiZ18Zl+eGWAu+8hVsaCQYlJnxmi+cUq1kXTt6/npyv4lx1u6E5hsY+Wy87uaj28NeCqqEAwWqkmwpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198550; c=relaxed/simple;
	bh=DY79IhOatM3K3uwGvUEBp3By+cvEP0P29GQNqQ+OK8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M5EYfo2HouobnjR1mzT6J319lBzyjnjTIy4w2TvGDipH3fEmqArw4xCAgPN1sX+3OmVRmFFat9FuPOuM4HfALpEuMeCh6sNKbfS/YrvIbNa2ipkasJOTP9iiDoS4uYCwnkJ32vkIinhq3AZZpZ6S5KZkrQKWHcjFnbGgfZ3jLBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IB5Tf3TF; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IB5Tf3TF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0PeANT3DpAmUy13pMgiIhJq7U7ojyllT0FhpVBlPVoavbSRFM3EMfnNSi0qKk/vTHyTAaP0khsTIM12mZGwhYlba7+0DF0DV77Ym9uKEGaNrmmNOc7HQcbux0ZDt/EF24cfcX1jGnL/2lK7u8CgOyVPYxT145rwezYKUyHUObzDOR2c7lDO9NCNJupbUoVl42u3KGXPD/LTDAI6TaIfMZtcynTCChbZ9owW0hFl7hhHuaIegKtbMRBI1ve8KNuQKGZHqFF6x354SeZnsjJD58jmoWoMt5gHQojHNa2irNCUCnuFDlroVBzk8kMSaryJFl638+WG2j84mTO9JdtLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GiFymEgid7p7UeywcJGSJ2hol94KNU1xsXbw7dAi14=;
 b=I6LkvE3X3wh4CmgThckDefsf7blkiS/9SDdeIesUXZ1Fb8NaKFW9FHTr+PetWGfcHztaNKcl0m5Xjm3kx4uKh4Pipk8gIKcTxlleukTfyYUchnKgE73EHSZ9Q+/xERoyuPwnXtP0bj5oUax3KyDyzlqqZV2vKNryetDaRdm4Ndkz8R+UM39fj7C0D3UsheXP9gk4N9/VagQYZCxC18TU6N+fCxO17dCBZcp2rY4tNSJ/pR5Pf6HTElJGzdZvhLvH37Yuf91vw22fk0bM1uE7g3iBbueC7gByvIa2fJCpUd4o1jQIbI7xmOBx96jQ3LowvYCmi34K5eQDcrmfqMZfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GiFymEgid7p7UeywcJGSJ2hol94KNU1xsXbw7dAi14=;
 b=IB5Tf3TF2snufv5l5SOQvKCIvFcGTRd7ekjafdeELwbAaiBH7MFekhFkNo6BwhtI43xu0P51pjzIIUsFHLgQdjrzRHfGjs3K83f9IEp0mb8zy0+JUQr2wNdCCqGpVZhyUsFhh8PTjkitZiLYJwF03qC8NMYvDyqrw6YBq4Q0iiE=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 11:09:02 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::6d) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 11:09:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Mon, 5 Oct 2026 11:09:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 06:08:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 06:08:58 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 06:08:55 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vineeth.karumanchi@amd.com>
Subject: [PATCH net RESEND v2] net: macb: configure ENST registers for all queues
Date: Mon, 5 Oct 2026 16:38:55 +0530
Message-ID: <20261005110855.1669249-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b87852-08ca-493d-6d3b-08df22d10f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	gcVJ4tUffGNqXmV//qbadx/APSNtYZmRnwY7UhNmDYW3i4Wfw73vyKwn2XOB9z/FqbapJQ6RGSHFNqNJfmRKmGpwiM75i2pWIdUuR2hGt3eLuYTM3GiduaRb+NUF/Q+RAuK7khcp5e3Tmc4JkUxDET+KJ/U8ifzBlazz2uLl6KMAVBO8eZQmPu6b9P1bMDdGOBejCvS+Fk57I2e7HSD5dx0eq2QT8h9HxLRlbmCvYRMrgc9WT5zkQW1yW6CSgnPcqkMPgWpMRj7WQDatRf7fn4vvmrKfnkSWJF0D1t7fV9/fWFNVhKP/T9GxacU2aWRaomh++F6n241uDL3+U01LdKT+YSgyVZILRi6i1RuLHgWFevxh8yd9dA5mnczO6Ga9ISChGtHnrLHxd/Cj5rQYa5Uy2GOA5cgW9QvgMk1OLKrxt1QF6HItRuuzMw6Ybd1uu4WcmsUXOdZ1famEBt/mfRnf0cTmhFtgLUm3vVwhhYGPrHKJBxGGREe6rr8waHDl/uX99Ee3C32XYnHRea9EVfoFEumEmKTqQIualsdpP3KOSUzfUyFXWCycDqscJV3EHmlfwNpwIXAWtR3eQEgVfWsf+0cY8I8X7+onsKBaqYLAWHh12ppuow4rCxQt6GiEv5lIuW9V3RywC2D0i+71cvSplZ3IXXbS9SR3CfkMFKwoFIVvII27r0fqzTezWqmQjshs61edaAmIWFtqQJMlFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1xsBEGce0L5fRdKAfwDiiYLRPPMlqmMgmaWLnTmBlUaiMK6EO2EFGpuySdQNwoWXl6dDVVYfV6QcfYs6aHaw3Or29EFPg77E/WVavck9J8lJqwmdBfn7cCEVHwCTRQc7NcylzwIuhKdYHJYmaEsuvOGxL1bTWqt6p+Vok4E2jRJ4IaH9vmgZ4u2hPx3EHDjKZfY1lHd8miAB9d374ni9SZ10gWSWtA2srzaGE9nGtJF1dq8gMbyiRxRqPhCsYiPlg2hmK8j+iNlUQ1vxlHEZldSYu7kdS04zX5c3TiSGWs/qvnqf2i6uPJ5A61zdFcQ6yIxXMyj10EXOwcQRiGx1UzX/WzyWw5m2b9xforX4TIKTbhmSj2MWDc8fEm9h18ld48emZaMf2a04xIFuHMOwt7fi4EVgW3X1NXLX1UOyWR2+BL/fGTjSIf/snkPx77KV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 11:09:01.4734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b87852-08ca-493d-6d3b-08df22d10f9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

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
zero-initialized by kzalloc_objs(), so their registers are cleared.
Indexing the array by queue_id also makes the queue_id field in
struct macb_queue_enst_config redundant, so drop it.

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v2:
- Rebased on latest net.
- Updated the allocation to use the kzalloc_objs() API.

Previous submission:
https://lore.kernel.org/netdev/20260805044204.272989-1-vineeth.karumanchi@amd.com/

 drivers/net/ethernet/cadence/macb.h      |  2 --
 drivers/net/ethernet/cadence/macb_main.c | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index d6931c41f39d..c23fd4082987 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1493,7 +1493,6 @@ struct macb_platform_data {
  * @start_time_mask:  Bitmask representing the start time for the queue
  * @on_time_bytes:    "on" time nsec expressed in bytes
  * @off_time_bytes:   "off" time nsec expressed in bytes
- * @queue_id:         Identifier for the queue
  *
  * This structure holds the configuration parameters for an ENST queue,
  * used to control time-based transmission scheduling in the MACB driver.
@@ -1502,7 +1501,6 @@ struct macb_queue_enst_config {
 	u32 start_time_mask;
 	u32 on_time_bytes;
 	u32 off_time_bytes;
-	u8 queue_id;
 };
 
 #endif /* _MACB_H */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8e5c034dc3a4..826b9259507e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4318,7 +4318,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	struct macb_queue *queue;
 	u32 queue_mask;
 	u8 queue_id;
-	size_t i;
+	size_t i, q;
 	int err;
 
 	if (conf->num_entries > bp->num_queues) {
@@ -4346,7 +4346,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	enst_queue = kzalloc_objs(*enst_queue, conf->num_entries);
+	enst_queue = kzalloc_objs(*enst_queue, bp->num_queues);
 	if (unlikely(!enst_queue))
 		return -ENOMEM;
 
@@ -4405,13 +4405,12 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
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
@@ -4437,15 +4436,14 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
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
2.43.0

