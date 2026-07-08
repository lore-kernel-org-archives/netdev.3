Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7538D6A9;
	Wed,  8 Jul 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505378; cv=fail; b=RQpDPMuOjNzZp++5bgxIpS7Bb6cfeBptil4dW+rMDWU4vAPvyGCyMKX8UMULrMhZ8ggTWTThMbrdEXVGo0JSkGBQxfoOyjAlIHTW+fOPBlgfuGjhJPme28nKp+ptrk+uKxtl1d/yS5ocaFB1LzV4BNN7BSg1my1EVIW6kHKlDoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505378; c=relaxed/simple;
	bh=7UdOb8S86+pcNXQCNWkKNvf+Qs3+rOozhZ89kOj9tKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSePstyzNOtEdkDj5JYp9TuNphus6hZJzyym44QGyZ9pveaNqa1E+G36yC+9wEmKKFERSUB5k3cNYQt0v1px1DlLRe4oxbp5IxBGllkjk9VVFLgwP1SWlxOSfUo8gN3tzVzCZOz5A0GxrwrMNai4KRhSPG6dW6+lV6IpJ3pBSxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ao45/WCC; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ao45/WCC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CE6TdN8M9x2lVOxUsqyrNaj7FIId41uHKkGkfqK82zvC3jPgmpHJ/gbD9mYqK/rCCoM5Xa/bq9vVTEVEoGvhg//8U26qYSy+qlvAolElZIF7DlMaRqI9tlCh8bi0rDmFCYPVGb7cJOp85EypUrQViYvip75vBtDEW+keHA0DuruhvRwDIJQ63/wF8PrFLJYKwB8qbGwZ3vqn1iddUpKAgDXOu4yjSnJGqnpUVbZI1ogzcfhqICHvkKmo/ff/c4BafLHqHJeZbMvuo8crYE/Uu6Q2u3taJ0ycEJLLe98446aq7fg0KdV2hFYZpGRLQVbBrUojM8GyYOsRwg90o+xg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ4yQabVJGSqSUbmRbL1TnwIynL+OVZ7sJ3g8piAx+s=;
 b=E1rl/1j5YW9BKnC7fYBOunyL5pevKGw4Q7cvDaqTZIgrEMLWGy4VxRuuWAy+Umki8rwCW6S0hEmHI9aMM3V3lL8i9T9+8t7G5IDMz24MTAglCacrRk863tn8FjPts5orUqCgIbv6g9leKan0DicqAUf1VhfR1BMSUAdiq3nWePPxsnOU7EjRsqU886IgBeWnvRjtvkn6nM+TTZrGPyAOhyzC/tQRb2EeX6u7CxHrnuNWNGglbxf35wbkMGKdXvi2eSjGIf4aGbJCCTC4OrGHirrn+AxwWkadK4TmZ1NxaMI/6rYJC+GcZgGCZyI9qV2SZwuv6cZ+imuhfmxGDuSj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ4yQabVJGSqSUbmRbL1TnwIynL+OVZ7sJ3g8piAx+s=;
 b=Ao45/WCCXjAHE3Z8Utz7JLfgYtrRup5SHGL2PaUNe7ENIokRxDXKxlpWT9CqEvb3kG/ZWhOZn9HjvBQEHD7uX2ALZkye5jduG6NeS8cJR6N+F2zJPnIwFkME+93PzPQQoMVgGbn4C5MiAdFn8SKajC+0QnMp4Tts5MIbRIO6yso=
Received: from BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 10:09:30 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::11) by BY3PR05CA0005.outlook.office365.com
 (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 8
 Jul 2026 10:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 10:09:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 05:09:28 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 05:09:23 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Suraj Gupta
	<suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Alex Bereza <alex@bereza.email>, "Folker
 Schwesinger" <dev@folker-schwesinger.de>, <dmaengine@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH V3 3/4] net: xilinx: axienet: Derive RX frame length from DMA residue
Date: Wed, 8 Jul 2026 15:36:51 +0530
Message-ID: <20260708100652.603074-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260708100652.603074-1-srinivas.neeli@amd.com>
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d1f14b-6cdb-48f3-d6d9-08dedcd8fffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|3023799007|22082099003|6133799003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gtfjqiPgaEA1x271K4VqmZXRwW7Juvq+EUCaHvEhjnEp0l6ib0TvdJTeOqmFnIYcNQELF86e/EAMgRFTqmCYvGI2Nfy3OGaACRJmoNYeHPbnNOMepGLhVgF8qAw7ktmH35fZrZI6wuKb3fOJDdkcgWSJDHW17oIPomL8TaiegKWYCwgdH4c65cXEZUnRUw1mCpkD/pxxuPxsEBmWvU1xovH4bo4T1bXRcIPiVk/pjJDR2bmAYcVPtWg4YMKM6dnTt5+DlcbNiNOZen6hxElvw1fEwio8lcC0xExVgZvl2zGPhAf84yXBn/X4Znm5DFOzf7CbB1Lc0HEbmB9xlrUitN810MFRhyfSXC73iSQhS2/BOcbUkS2px0psjgjOUmlxhh1kA3p6lba2pVZiwpY0mK8JQUWtZIxMb6ogVr2x2UVlrcvnDTeYHUuALh548DrIHCQK/RgUTuNFzQbHCE/giCDTCXVFqaEMskjOEp6/MEqUWElpmsyYtlm33NgOkq+8cmj+Ui39ujvF7l9LC/Tf5Q7o126Qs52IyBsvxmq5E/8KYRUU8hWIvKGvvjfoeUNRclbIair/A5PUayqmWDYsKiRGRpjjdgL8lTMgk7BvIcu1YaEmIrmTORtNtl6duO94VsANiQL9NggIX5QjxDdU+X1uxYLCjgQXpxYKTBZGgQMNOMtOtDlpAyCmasecIVCrzpt3aSjm79P77lcWApomcg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(3023799007)(22082099003)(6133799003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g45bjL/+SHklg/OWV6uug+WxVS0D22GxQ/v6QO9eSi+pfUpvjr1tExc8MTYmTexPdGaay+1H2Dax/z9GDw/g6fzkoK2BANhufKG63nJNjbTSz18B2n1HUi70yNGXURGJuOvvK2foBoC4AdmSFxKokvJLUTzMsSQuMhKhcZ9pg4Dih/TEa407yk6AKtRDwQJlVsG4lX4Iovge5JK8E/X7MB4WDUT70ytRrHaqnurWgA1FYU6xltrBXyYUKNwwvKEXo/Xo/WNfcZbO3vPHmolwP162O7M36tn/etgCMc2CHJf8pNhPHCNJNHfRWIV5zBgQW612P2gBX0ekKcE79/3YWl4tM/h1U4oj+3SvSuq8q8OtMhumZ+WrjeifEKC4Vbgq/hKt/M4gujalCeOrN8h73KuQt9/dvELCqvs9Jec3876jEyABozd7Y4vbbWyCfC73
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:09:29.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d1f14b-6cdb-48f3-d6d9-08dedcd8fffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219

The dmaengine RX path determined the received frame length by reading APP
word 4 of the DMA descriptor metadata, masking the lower 16 bits of
app_metadata[LEN_APP].

This relies on the optional AXI4-Stream status/control interface being
present in the design. The descriptor APP fields are only populated by the
hardware when that interface is enabled. On designs without it the APP
fields are not updated, so the length read back is invalid.

The AXI DMA engine already reports how many bytes it wrote into the buffer
through the standard dmaengine residue mechanism
(dmaengine_result.residue). The received frame length is therefore the
posted buffer length minus the residue, which is independent of the
status/control interface and correct across all designs, including
multi-descriptor frames where the residue is summed over the chain.

Use result->residue to compute the RX frame length and drop the descriptor
metadata lookup, which was only used for this purpose. The error path now
uses the standard dmaengine_result.result status instead of the metadata
pointer return value, and the now-unused LEN_APP macro is removed.

The transmit path is unaffected. It still passes APP metadata for checksum
offload and derives its length from the skb.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V3:
 - New patch in this series.
 - This patch enables axienet to work on designs where the AXI4-Stream
   status/control interface is not present. By using the standard
   dmaengine residue mechanism, the driver no longer depends on APP
   fields being populated by hardware.
 - This approach replaces the V2 xferred_bytes mechanism (V2 patch 5/5),
   making the dt-bindings patch (V2 patch 4/5) for xlnx,include-stscntrl-strm
   also unnecessary. Both V2 patches are dropped in this series.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..67d1b8e91d68 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -53,7 +53,6 @@
 #define TX_BD_NUM_MAX			4096
 #define RX_BD_NUM_MAX			4096
 #define DMA_NUM_APP_WORDS		5
-#define LEN_APP				4
 #define RX_BUF_NUM_DEFAULT		128
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
@@ -1159,29 +1158,26 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 {
 	struct skbuf_dma_descriptor *skbuf_dma;
-	size_t meta_len, meta_max_len, rx_len;
 	struct axienet_local *lp = data;
 	struct sk_buff *skb;
-	u32 *app_metadata;
+	size_t rx_len;
 	int i;
 
 	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
 	skb = skbuf_dma->skb;
-	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
-						       &meta_max_len);
 	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
 			 DMA_FROM_DEVICE);
 
-	if (IS_ERR(app_metadata)) {
+	if (result->result != DMA_TRANS_NOERROR) {
 		if (net_ratelimit())
-			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
+			netdev_err(lp->ndev, "RX DMA transfer failed\n");
 		dev_kfree_skb_any(skb);
 		lp->ndev->stats.rx_dropped++;
 		goto rx_submit;
 	}
 
-	/* TODO: Derive app word index programmatically */
-	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
+	/* Actual length = posted buffer length - residue. */
+	rx_len = lp->max_frm_size - result->residue;
 	skb_put(skb, rx_len);
 	skb->protocol = eth_type_trans(skb, lp->ndev);
 	skb->ip_summed = CHECKSUM_NONE;
-- 
2.25.1

