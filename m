Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1D3955D7;
	Tue, 29 Sep 2026 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669608; cv=fail; b=EzaqLVxTnhqz2Clnz1SoFA0oLbnuC+53bw9//3P5ct9THbolfGq7p93fhhAzn4zl3+5ScTSVfjeW0VawSB5hIIsW/kjECxqKcHjniR6JNVx8uOncnjJuEmhrlidHAZ/wENhhxjzZBMVlPvEk6RvmrMSi6dIF+ofkbvT01OiCrAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669608; c=relaxed/simple;
	bh=cBdHmnDtA5m1ChfCaicHEpgiS7Jokcs0Gu5+LDni/PY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqcAahT2utJ8HrI75GrNmT5N1i3gGXcC4uDWPvtcODR39ps+BYdBAvjuPkEv6tgZr1ViZvcsszsuBI3ONAJcSnApCDhqOKcVsdN2ER9epMA+8OMCEPYrMbTGFWaZLrIZfGiWITRQjiCIk5KQBxQz+lI9Zg7puvQxryfr/H0HlPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fYgfhoRD; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fYgfhoRD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp3skyNJdsZ6dfMMdw+SnOcmBrqPaQ/AYL4y5rydoUG2m5NtkJOqxCQLhNbfEQ1PMQuiqgdMWNc0ng78z2Ib9EEDt6UDfGkYCqfdg6BMnbZYw4Lksj+UiyoF6+MVI88KrxTAioS/FWthOZuTKFXxqYxTVY1DOWtDGrFyPW6w7iGCiMpCN8L/ytapJ4UWMqONdUd5982mLtDm5t4re4mbqO9Ti0cBzUtBRZSIPseyhLR3HyQJGnnlOPvLNvs0cXdYimM9UKEQrU/KKwJDRToN4U0qESXQpEAmXlk2SNgh82sxj9zFDz6yxGGtrcK20qQv6k3LA7tXzLi4ZozBac4y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxC2GKeQC6U3jF3oIqszM7CViaUnydRZfQeizQRYoeM=;
 b=N80cxLkiQRxQFkCM3SbxXGdnXc8oSnbwIIq8xBG9VFPYVmMDTOVilwxP0yYRqXriZCZ8udCFmXI1ez66UgPb/NGsoxGIp9HJZ3kSmVJLIFfmsrYEksxmiucMkXGElDPexxMqpcY3bzAWoaf3zitZWcmB+pmhxPAB1xv8qA0RtOIrMH5Ay9xxF5WFxKcX6QPUjkvn4cvtHyeW/MvP8VfAUmKpQ9ImMUZw8EQqgKRIMhJae24o3ins73XBObXDrCZC2Sz/oRhVrVfQLfS7+WsAJZUt0GP6YqM/RzpZwRlqtjmXi8i8mG4lBRWhIsKrB9lU/aQkOI49nDzvJMP9v/mUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxC2GKeQC6U3jF3oIqszM7CViaUnydRZfQeizQRYoeM=;
 b=fYgfhoRDEUo6JlGATSPT8QyPlZSD/Xyh66cM1Sxn0Kvrj3Ecavt4rqOB/RGRX4euPo1uUQ/3vpDbCVjhtFFeoNfqi2JSxAAcEea6HQl7faAWcM1iEF049a9YOGd7777+8fxZPNQjD4NmV/UW49/FmCGyE0Qsp0E6CnCG17PkTxY=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:13:22 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::69) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 08:13:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 08:13:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 03:13:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 03:13:20 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 03:13:17 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next] net: xilinx: axienet: Derive RX frame length from residue in dmaengine path
Date: Tue, 29 Sep 2026 13:43:16 +0530
Message-ID: <20260929081316.803997-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SAWPR12MB999165:EE_
X-MS-Office365-Filtering-Correlation-Id: b51f4659-7920-4d8e-1d1d-08df1e0186eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|13003099007|6133799003|3023799007|10067099003|260925021311599003|260925021911599003|260925022911599003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	jpXcVaeISPjXHoXQ0OMaxyWQfR1gzQOXdLhD5knQTSriV+ePo223dGFkgczrrJzS20+8VfSd9HJGDdBNKjgxngQm1AXtXHmgWFPurnnzzOpl1GTiJ/o3KlSsfoly2qd3jO4VBZsWEsmEJCtXhE9kgBJQzcnP407gjg+Eoyo0Ipa2hVD0bmYJCdIhYk8d4GQDX1O7VsjF4sGwNpok4Arv7D2qOgfm+JjT5lqoQOmN2msP6OZOAwPx6yxIpNZquuG5KA+gV2CmCh8RUsEVCQSG8ymFKHs5S0qTNxD9ShCSSl70YYaYGqMgzS8PcgWnQ5i2b3ZcVbM0ZRug17Mrmj8T5bPSkbABzw1gYxcQNJiwBTJSyuVPv5RJKYeUX92X8Wd7F8JnY8rHSoPobKZyZAGOpj5A3wXvKr9AXgWCKpK8WXT3iPIn+OJAbO8tsizFXLbbRFz1etaxAbS+F9kFKrKiL69VMVFJfjbaALh0SKHU7cUch8O9V0jnJqCL+ss4pKsnu4tDL2KvbSK8xunh81Svq8GTNX+36lC4Z6QdVkI7dF+8qmaY7INKZ1uNODEivJ4LqCcsl6RvfmVTkSAjekZ350bpWP7f5ASH3NChfK+Fi1MxNGMqlp5fi4z8yuHXysEywXO/71OQ/SFzvHRb7vg/3ZqvGQT76l4dn2kiY0ovEud6fhMaattxtpTDOqqkvls3G1ZnT+4DCRp6m3AOnVPwug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(6133799003)(3023799007)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cKPG7k79INzTs5xKKcFpgYXSwWxa8PzAmWZZ5UoET45yyt65FVBntFczT1xPwLF+jW6H3ULomJYh5aoYrwNM9qIHsNOkZzZredk4Y9G2rKQ61q9EZBQvxSuMlgF7hVoh9la+oP+sDS96eRHoyRKowDTDtUBqFbaqSZDq5wWir4DMLUMOF2zGpM6WNnc1uqWWR4Y22/poG67wMZOIQvmCvyjXOmQrAGmHiUdZwLJW7I6WDqKTTY/j6AywqtkC8dcYqFBvb0/FocuFyucScfWV5+1+A+0qtIAsO1mzdV9g25qdATNVQnQQ8AK02+ikZwsPPPRIBZF5Kf6G6m9cx/ynp2pT2Kv05ulwwt9fT2/Qz65lOJPcsuy8cLOU174mc7Yir4IsoOyoODMp/N3jcaiBIfwj71K0xxTzQ5SDbDM2NKTBf9f0CxhMgF7M6oXe2vES
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:13:21.5995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51f4659-7920-4d8e-1d1d-08df1e0186eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165

The dmaengine RX path derived the received frame length from the descriptor
APP metadata. That only works when the optional AXI4-Stream status/control
interface is present, because the hardware populates the APP fields solely
when that interface is enabled. On designs without it the length read back
is invalid.

The AXI DMA engine already reports how many bytes it wrote into the buffer
through the standard dmaengine residue mechanism. Compute the RX frame
length as the posted buffer length minus result->residue, which is
independent of the status/control interface and correct across all designs,
including multi-descriptor frames where the residue is summed over the
chain.

Drop the descriptor metadata lookup, which was only used for this purpose.
Detect a failed transfer from dmaengine_result.result instead of the
metadata pointer return value, and remove the now unused LEN_APP macro.

The transmit path is unaffected. It still passes APP metadata for checksum
offload and derives its length from the skb.

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
This patch was originally posted as part of the MCDMA series.
Since the required MCDMA changes have already been merged into the
Linux branch, this patch no longer has any unresolved dependencies.
As it only modifies the AXI Ethernet driver, it is being submitted
separately to net-next.

https://lore.kernel.org/lkml/20260818174151.1608971-4-srinivas.neeli@amd.com
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 782f903d318f..e7490650482b 100644
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
2.43.0

