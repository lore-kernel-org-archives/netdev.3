Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4C2F745D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242225; cv=fail; b=pyLBsrhmaHzPXde2mLsL+jdRvi2cvWQxn3EWw/7chFx+guhTG1Ndy/UZnZ2fs4cJk6qU4rRFKMd6tyb3fNAzZYvUT3ZnFmq036vJimeJuIw70WHwtlfdaB5PrxpKcDJbMY28rQ+Fm0ntVowsUpghAAHMayMyAZHm3dy6xBc/iXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242225; c=relaxed/simple;
	bh=++uKU8AZdM0C8HhWr1WvD8XEA18F4s4c1CjPHCJimgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rtNDWZuuDnuU1wvQvIInWa/SS0ss1wHI6VPi6azpy83AnCytSoIdDxYGlk4LnrgHta7l5v8OXxNlZAs3SIsY0x15JNPUGjIP2mKHzT5KdiQ6WC+9/ijUoH7JfHfE+c48lmv9OCie8TwcruNdyehfaQx0oASMRB/BHFWpLj+6mlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G25Re6Di; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G25Re6Di"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZFo9lNKdOc3QRQI2R0OJcnKrPmga5EswiGNje77GKS3VJSusPUhkanXf7GCeuSwFt35tSvTCrAcKJy1VgROlL+c9cuB4KCRR82xyQkRoEYTvngzIzHSEmVEu38BX5HjPpGFEo6GSyUmvzLJDwqQq4wAUkHha/le+iQgekscnM/aQYV/3iSB59i0EO0qDvJPaAu/kH8DP2+Gga+hvBbH9kJ/cul46v3xa06ZiChzRRa4ZGrw00bnE0pa9GVLYIl1ilbcdrqX+N6C429oepc6jCIrHqpNf02jZWsaES8GHtLfdgcxtGbW5DPMhCpci1khw59q62z23URfxBRjN6gO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhDujLNxaRIgyp55FSc8ArqZAzZkjY/D3LDug35pkpk=;
 b=fLnNuTRUeYn0RA7X8sSqzUFMo97EYRdhqhX2sOlHI2nuSYjoZOc8wzl2iQxRsAxT2kjH/GV3gia4UDTOmaupTLyr8F1G5wgchBINoWoaqm9Qc7KdRsQvE8Dk3cFx9ozq1Aikv02mAE8JqxhijedJF1AEN940xW+vBHQmtM4TJJgkK/JR6HhzRPm/cXjbqUTWRh0XtsLvTdwZYDXa7fV+HUIGtr6IsFj5jCh/lT7AMr/ZmU9MSeVZX2K6MdMgcDV+VxvLaACVuZkfEhETINT/G0AQ49MtPxIHyfTx/1CQPL3fJzgAHilujOftOsoSk0Ak8K+/4yCSpmsySTSb9faPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhDujLNxaRIgyp55FSc8ArqZAzZkjY/D3LDug35pkpk=;
 b=G25Re6DiWqzbZQ86WgRTEkOlMG+TZUOvP3/GMcLMhkQW6szvIG2qKBDBHAghjS/guDv64UdAMsBYc61HCpITrwxybGWdxOpBGCpy0o589OH7ft7Q02TEJG+FlVIj8Z4IYCCvnli/lZYHo6v7nhPOGE1y2D+ZiVjC7pwIBGKOC7Q=
Received: from SA1PR05CA0020.namprd05.prod.outlook.com (2603:10b6:806:2d2::22)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 05:56:58 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::64) by SA1PR05CA0020.outlook.office365.com
 (2603:10b6:806:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 05:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 05:56:57 +0000
Received: from lab223.rund-run.pensando.io (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 00:56:56 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <eric.joyner@amd.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net] ionic: use netif_txq_maybe_stop() in ionic_tx()
Date: Tue, 1 Sep 2026 05:56:27 +0000
Message-ID: <20260901055627.1373129-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: ef75d1f8-bed7-4733-5330-08df07edd562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	WdKNAicjRtXRWbU2ftyK8vXvz62S3BMjYGG1TnDWnUfs2qO9ltFJeH2wm0MLGeuQWmRt2MBpmtQT57+4U0yml/3O0FUAGmI+L64j6Pj5WNvttiMOU2rnolUnXiYozIoCLOM24TviTjvL3icWkG91uNuzR7PHST54w/k2cEufP7quNrZn0x2z0kcK+uUnRY1QRXdngj/scyyOsOYlrPVrpIpOLnxmAJ5LodUhV89QWesM1iL4uIaWAHPsb91B5qUD8/zqq6/I/z9OQxeYu+JJMtkb+0R9btgk6u7hFthP3WY5lixW0mC8ymz0ltJ8UdyAVZXoFpFkjYF+IHvMuda2+qC8J8TrTrNI+Qyk/p/ZzmR9Gi31jfL2tCBhzAz7gYfiG3oGO0N57dO0rn447BeawRUU/5fyk7HX9dEYKsZ7tycSnjtXIe9QYuNuIj5cl2HSd7+kiatuCVkfTXZwZ3BCsQ1xwPYrMQy+PNTaPQ57zeWAxs3PQZ0lKReQDMWoiRzGGmKnyZkyxVDRxokqQocua4AZ64YWrhEXYhDAKI8pKhQHPf+S//KoUwxBBxdIXnpiZqO6INloT4EvgRR0ef1xfe/R6MX6KcH92ASNz7Fi+46bEzdLKCPU+4BEuEJxuO83MGLxEwSL2JIvTAC3do0NO442apyLINCKoFFahDJR0uBBmy6aFec6osXyRWbHBpCAzGPtXIjyii2+WIOZ9aJpUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yDEgYDH+ibs1skZarmfxnx6H3YDKs3E8/p1MmA3E1DUJakWn+kNwPfqoaLw1opJTfXwXXiNiJZWDmttyE+6ibLubs7LduLDOsTgL2DHWZ7xYszGNv1ikRK54vt3Oz83OlDFg3p6s2PG2YVqmBKIo1BLe+tfX5ryiEyDwyC1Ml8ItePb1cKnNBuXPihf7p1SSbSI8RxdGTwEhUql+9o0A/j8vFISzI0DjToV3CDeCoMYxyMGixJqDoMP6PYlsIvCbCBcdM1xOsNT7HYoLMJZwlR0juT9/9CZ0cyfRFiI13pOTGCA6moMxmC+l0f9fkJIWYeIa9mIz7upp/Zq6/xu7Vgl/SSHOT7XiimwPP5x1T1FYJPTKqTAhxSQASF5U0P5jCrrgqXqVzW6An3qbH5fL3Tl3o+AOwnSN21cFz+UU/hf7nCWQYkjNbit/rwBsWI5L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:56:57.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef75d1f8-bed7-4733-5330-08df07edd562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

Commit 061b9bedbef1 ("ionic: Rework Tx start/stop flow") replaced
ionic_maybe_stop_tx() with netif_txq_maybe_stop() to get the memory
barriers around the stop/start bits right, but did not cover the stop
in ionic_tx() added by commit 138506ab249b ("ionic: Check stop no
restart"). Convert the remaining site.

netif_txq_maybe_stop() requires the ring indexes to be updated before
it is invoked, so the post has to come first. But ring_dbell comes
from __netdev_tx_sent_queue(), which runs after that and reads the
stop bit, so it is not known in time to pass to ionic_txq_post(). Post
without the doorbell and ring it separately.

The stop condition is unchanged. The re-check only clears the stop bit
when space has become available, so the doorbell starvation fixed by
commit 138506ab249b ("ionic: Check stop no restart") cannot recur.

Fixes: 138506ab249b ("ionic: Check stop no restart")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index e436e3231e86..2543a8ff8547 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1672,15 +1672,22 @@ static int ionic_tx(struct net_device *netdev, struct ionic_queue *q,
 	stats->pkts++;
 	stats->bytes += skb->len;
 
+	ionic_txq_post(q, false);
+
 	if (likely(!ionic_txq_hwstamp_enabled(q))) {
 		struct netdev_queue *ndq = q_to_ndq(netdev, q);
 
-		if (unlikely(!ionic_q_has_space(q, MAX_SKB_FRAGS + 1)))
-			netif_tx_stop_queue(ndq);
+		netif_txq_maybe_stop(ndq, ionic_q_space_avail(q),
+				     MAX_SKB_FRAGS + 1, MAX_SKB_FRAGS + 1);
 		ring_dbell = __netdev_tx_sent_queue(ndq, skb->len,
 						    netdev_xmit_more());
 	}
-	ionic_txq_post(q, ring_dbell);
+
+	if (ring_dbell) {
+		ionic_dbell_ring(q->lif->kern_dbpage, q->hw_type,
+				 q->dbval | q->head_idx);
+		q->dbell_jiffies = jiffies;
+	}
 
 	return 0;
 }
-- 
2.43.0

