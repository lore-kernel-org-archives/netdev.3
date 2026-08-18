Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB24D3A7F41;
	Tue, 18 Aug 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075207; cv=fail; b=cPabfymESrbDUXJm11JHIN3z/ufV9JhYvUVk5kF4xC6mbwyrprnnNirD8jTd1QWNTw6OyelXPNs8iAQ8XkZkrC2/a2wzaIXF7UJQ3cX95GTyy2UBez16+R9tc4HyOHKhcXN6tQUXdTw7jsvbM64xyKOkGIH13qUT5HlT12UcZwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075207; c=relaxed/simple;
	bh=xu0eqO2WkRRH//d65jHsioEG+meOnE4FkSw0RVI4eVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhlH8124FKvnct9ZuKwDRFhu0SYBGhRz5JHyWGDjBetHHOtdNd6Ax6lUtFTPixY9X+DmUCudah0S43Ee0OJTbqD0TduvDf1PH7LYwhkbfb2S7JAYgZBItzU0oI14YDTKdbmWw8/AGYupoBu3JgAiqf1WkUaqS466t5yk+wlqzJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m4O9PuYx; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m4O9PuYx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGljKOMs86DEc05f6kSE5j98wkbocVZAzUXzB+dMzKtit8aDEdHIDhaaq33mJYRojyVSzMdCr4Asfsp/Etzge+q76rTE1x6jGUS5xvRsBdp/aq/0qWEW1FlOWCBjFZdE86a8pWetYzFf8qXaVNcCT8+A0l1BlnlQn8Q+wWpvP4t8UT0K9rDdayM/uBE6e5hVaByJYTEvVlTkYWFoPNFhJiG03J6KU20G1H93qGNBtRdW499lFnDSShlCkbixOCfYU2ofWBgGTSBvT4pUCpwRl8Wmio1OopphhaCqU2YACnINcER+ST+raZWuJaEHr4DLGfkXRJ5eYcQvns8LtWHWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mwK0MuvwCiVh7Jq5G3rgYtA0P/2JIQwHfUdCMTPWak=;
 b=JdZEMCSaa11IoXuRocSaltQKEG8snMme2fFGHR46bivijDXtOeNWHO9opZXnItrwndM8QcLcs6gR9YLomGQFVXbwQwZV9yBvHPM1JGy6zS0FZAotUdIJgc+FLlGjgQl23Z2mEyKS1fRzWqdeLMDu3yEmqKQADca1zlfGyJ+lW6yx+Jn8zDPV/Sxd24rg1AnikxadJ8G7kDM47P82AXcmiABYQrCG60lJcU2KpGBETsfoEJqtdmCTXCP+TyO5fps9fSCwAk64FFqY7qcUMQ5T/Yc9me//h37lv8RcPimkEopaYuffyFUPQx6YKn1SVjToBrreDC3Ueom/lhrR7XByXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mwK0MuvwCiVh7Jq5G3rgYtA0P/2JIQwHfUdCMTPWak=;
 b=m4O9PuYxTeqQJej6e6B/fLbunTHSRfgq7ci1rdCp+3iPD2tfX19K5GjUepYbzGO2clYJ/4QNLwFKO9VZAuWW4avYcLbARlKHkIKvRg+CyE8KqD10YTG5d/nbJ+jjovZcej/49CgS7e6LpuXKyv9HCZ0UYB5uwSlk8zuU0VhtncA=
Received: from SA9PR13CA0074.namprd13.prod.outlook.com (2603:10b6:806:23::19)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 17:46:41 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::6d) by SA9PR13CA0074.outlook.office365.com
 (2603:10b6:806:23::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 17:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 17:46:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 12:46:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 12:42:12 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 12:42:08 -0500
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
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH V6 3/4] net: xilinx: axienet: Derive RX frame length from residue in dmaengine path
Date: Tue, 18 Aug 2026 23:11:50 +0530
Message-ID: <20260818174151.1608971-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818174151.1608971-1-srinivas.neeli@amd.com>
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: fa72cd49-9ccb-4bc6-3be8-08defd50a8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|7416014|18002099003|22082099003|6133799003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	hby5yScmNCfzCHWWyRT4FE3TfYLKQDDmL5Lkhdy9i5LDhutCG+YfrTp453me9FM3rxgDFHuB1c2dD7IRy2UZ0SmSudxmQCPtBGuzmN0wnNkm5MtQObkg/lrhMsxibGLbXQWZo+jKqPU45QggoslOrUQzlpguBhJGDM2L4cVMDTQ1HqB0MsTirrKYPFiUIQ/s3vsT+jU319L09xtNd4YJGTOns0PmXyKNcH/DmSPV18DPVC02E1sgoUl2v9dI1kCKbNgDVJCt4d5EP7A2v7Dhb+j8i2tJWLFhwruPA/g7Ro0TBKh8RaIwGz+gnvIkEX6BQFAvgYXulwViZVdagYoRcSe+3XLgvwFkLNwU6ckQzBldVBCuIr+CKcdWeVg0CDPhAVIj8QB76XQ0CGFu9CZwmw39rjPFlq8Ge2weDtTyrmCY81xC9LKa4EU2BDVHW3oDlHaepSqEUj/S+X/Nh1K5YWoJ1wtJ9gOWKFwg7rZzchCboqbNbNIghgC6O4A/yz9p73DhHsG+AMA8pTOTJR3dAKzpSQ8klKRSpzlO6TN5p7wqiblK8tNhihjMZSbJiWiWeiKe72kn4Eg4dV0/n5d2UTqfYos1cio1GI943+jJiFr/M8j10JEaKNZxgZlms2XwEB7usMvL1SeoWQ3yB7eig2mHSHH9w78eqB8MppFrvFaqp9L7b1f5Tks4cstmoa7fK+YkIySkvoeLj3Uzg8LTBg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(7416014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G/t91hHOxPFm30iImY3pKc65VAQoRh7gx0en39LFGX1bmeILhl/SMJPxWJHYkMvXfvwpdaV2K+wfcxERZuU6MEA58hDW/j4ihHQYypJ9ujaVc2cJsvLmg2hO16sAfkjPfmSMye77bWmWvyGd8/5mJsiNvhgevYPjVt2k/xEDvIPffmVloa9MADMpFa7ajyZj5VDi7k5WYaSD+8yv/DSZbsRagHTDyEt8FSpt7GiYRZjWX1RKiDSa0WkS50UHn8ynNXQdAE1je4KxBMWoC3Wwr8EGvlA3vHeSra6aKn3hUZXg6zRBxY6rzztMQdG7In6Cvje/KxJeoMAFICcmS1ZvEUe99dYbsZ7OpWF4xR4qZ6tS9vJhvnSmtRH2+xg0cY9/nT6kfBUQqVdfUHhU6hqJjGHTTxhr7Z1yAed+J9PAVsx9g1yTlagWtkd3AN4+lJvE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:46:40.4811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa72cd49-9ccb-4bc6-3be8-08defd50a8dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

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
Changes in V6:
 - No change.

Changes in V5:
 - No change.

Changes in V4:
 - Renamed subject to "Derive RX frame length from residue in dmaengine
   path".
 - Condensed the commit message.
 - Dropped the Fixes tag.

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
index 1722b7038f34..f9252880f411 100644
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

