Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730E39CCF3;
	Mon,  3 Aug 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740728; cv=fail; b=pTlJTxZtSAKDUQ9tvr4on9QjB/8H9MIEQ+tilqg7s/WUiT1RtygBBubwV8iaKX9b5nWnlGUZGqnNf4d9AXFIrjeUHw6ro+Slbn1ryu/f2Ksqdi/EaHiF096HDjDQ58G4v+jIBNxdhnRLycnOkt7oHdW57mcNGsZb3JPHWUpIPXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740728; c=relaxed/simple;
	bh=Rp6ufia8m8y5KcpI9lJdKmORCMrzONYB9kxxFtWxTRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O22W2sA5iqSy87qOizjwHSM4eeFdAlTrgVP95RS5XFfcvhFcNnngFyOQedwnlEUxlGaqR1abVLsoOzlbtwV3Xsy8b1LI7WVzZDTZeEl3BaTEU/AwtHAcjWh89CW//dL+yjmyNvddozQzbk2KNAyoXXF6N3YMxcQmpoc/QRj8RJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=G7+gZH8Q; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="G7+gZH8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxlbpGo7lVWDT2vFRX30c8tw/OMi6RKnJM+jXXUelYLXlip92BDb4XOFLtSFeI8sWTgNVfuYtWiZNtY27+B8wA3vwei9kniSdqcELUrNg9CUta5sZ0k5GCxggKuW5/5HxoWLP6nZXERqaJeaT9ZCCm7xtriv5HSywilgxms0c+7CHq34auZ3PbHtMwcCIlfy7SBbs4lD9ziBfoPWfxLy9Cy26pWiRMe3GWVDt49ovgq9iqbELNzYVXwhTh+tyueHXgFNmFb0R8DYco0Le6xmLlEZfBo9QYUsk/Rhcu3rpdo3fFSEv+vYUtkMAitmiiK3bH+eZeXtSmGOcEfvrO2Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhXPGb5IzFmIFkuZ24btTv/hhmvrZMgr6oALvbVMQA0=;
 b=kHRxDAw8wAuAsDpGQEHacSAgSnACK0JvMKXRLiO/2+QosnI1xODZEQNmwCpe42eHYXnfejZqspNKRB+rKB0a2Iqo/Y+ZBWFbYyQ170UYWeenQNqlcLnvUaO2I0S1t2Y9lTnqkYmpjZdeQRpCGbsGmrJfv6a6nhFDFVQiEkPwWhWMA7x+JI0NmCia2gk1Vf67upqaaIbgyS9cnVJXbfJ7itWn3/6mcLL0YGNntWZDH8wtEx8NPyaguV+qk1oOedAxOscYZtXDrOWo+eFg0Oz0XXTmJMUVcQVtYuKYBuwmHMKxR0fkLj1fa+aR3PyKj6LQknZNxVoCpMjp/Li5vJXozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhXPGb5IzFmIFkuZ24btTv/hhmvrZMgr6oALvbVMQA0=;
 b=G7+gZH8QQIteMCF7C8IqEXo3cPQoHo8+9TeYuuEm3WEaBZ/lCpZV+WT+nSO9PuZC6owVc7EbHiFvuoWHw8l/BC8CQgoImKv1v8c5r/cyS/kdGmtZL31AyVbjYJOU2EZs65p+/YQqGGtySW5epkQUEVOgcJ0O7kyU+ew0xKqAfFwyeFgily2/fZlAZkw6KrIOBk2NsobQ29qV3j3ZbBkDw8U0AG/GqQga7R/CEq96a8KSnbtbFszCoMUpeMvZWJBztJ7o6r8mOHtBd8WqHVbYZoh4lqceuhqqBd23UiHohnXjNfXqN3QMTY/sIs4Qi9eS2jDYnI1PlJEfWipfPMQCyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB989258.namprd03.prod.outlook.com (2603:10b6:510:3bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 07:05:16 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 07:05:16 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: stmmac: Use pagepool instead of streaming buffers for Tx
Date: Mon,  3 Aug 2026 00:05:12 -0700
Message-ID: <20260803070513.4657-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260803070513.4657-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260803070513.4657-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB989258:EE_
X-MS-Office365-Filtering-Correlation-Id: 1155ebbe-69ad-47b4-56d3-08def12d91f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|11063799006|56012099006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lkaCR7oMFxW6u0yyN/gBZtGDPMnuCf7TbdlmYg3I9l94ZQib+jgQbiAnynAIK0fgvhJUUknoUSv0xidnhRah9NVyVXNfXN6mHGSPlstJg3oESTGEwYWHAthiMw2tH4/EMcknAt24OcTunzRRaJ6vEk4Rm7ZXRis9DlhCknxhJ7hYLMkE3oYzzxOrUzN4CleXHG3WPP7B5W9o0lh+1X6OVY/J0hPqi7ovLO/N/epVjCX0IZ4tmlcBTa4JjuWSaOfS4UgAr48SCEUMYdvOskjJMc/q9f2XB2L4bACONgaKt3Uj+5P4SpaNlhHYAyopp87YuLW8y3OjVdOo43z8buJ8PHgqaDOHR1mZYh9KD78IHtrUBqZbGgwjYJLjuD0/81BJR/P3S6ZUVQN9XGdYGGuFavb6rfMvKMWdUaTDqKV+cku04sc5qI7+UFAcjLWILYdQTUPCMMIj6ess58VVDZxgnguOntmgbE/umWaSULE2A6PyKYbfGOOdM42/F3im4D0RJdx4OelXPMG7VoZaFKDkIz2tstMlKgdo78NxK9KDgOvy89dbbhLqJnLa1713VsEZoQQuOYno4Ovs6I1Q9BNa6g+FJMmIr7O9QBORgo4zoXOQQlg8KwZ9/bqPwHx5t52Md9gQslIXxfQEOKYfTYJDqHBd6QHmVGPSLcvdEb4/7rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETuiOSJ3glcdXpggxUBuVHbUWKyba0J3XtF0JwJnhGFBicILfWdNsqLwLiKp?=
 =?us-ascii?Q?FPjXUSqEix5XclwwLc+b5rlEylolgoG+p6oB/sTHx3LrE7nTh18vuoeJwXLi?=
 =?us-ascii?Q?q0CF3NCHU1720SaAxb+JipSnBJmLuEdpfzEdNklPFxVTGfisotWQot7n22Xf?=
 =?us-ascii?Q?HvlgE+/lnZhy4WKvXOxB/c8b6xmL3ViIwx2qTwd4lfGJ/3pXe5ghwBGI/3yQ?=
 =?us-ascii?Q?HY6/2CYPKpO5U+LfyMso9kLcbivUGl3kAv2MuT+ky2iuSMQUSTFlvtAFeNEI?=
 =?us-ascii?Q?TvDOYJ5Y8Lil3aMWFuz+0fi+2q0hBsCY/4/NViZfpnJ8FXLUE1L8q5zmAfXa?=
 =?us-ascii?Q?yQzpZ89XQMSwZ9cvQBCiYmQWpcBITVis6pIZQzDwSe7zUfJQR3WM/27zAlfD?=
 =?us-ascii?Q?fo2nT5WX6MNR7POnBRK6PE/D6aToDV0c7NSOCnkH+jMxLY4QTRF5ueCePHAf?=
 =?us-ascii?Q?HHWqE0w+xBH95+aiinDuvhaSu+ZGhV2a99ifMurcrectT/olG3YO5mqTflbZ?=
 =?us-ascii?Q?fqJOHXe7iexmdfFRy4FFwIzF79A0bad9egpa9VTNQ1kYrhYwsHhq1qm+Xd8+?=
 =?us-ascii?Q?QjX1Ksx++u5ld6a3tyUwAxXVTaeFdMQDi7cPjLbYR7IKbe6k+WcJ/2wwS5zg?=
 =?us-ascii?Q?HXlKCdB//lbUwlp67dTYcsNpF8Jfb8oVmC4MA17OazhvkR+BVV20aWJqYjog?=
 =?us-ascii?Q?hthGm/Eo3FVZmC5+lCXGpE1kWOtkzbPzX+ZZWgJkeO23VEa8fynNitK1gHbN?=
 =?us-ascii?Q?VcY1whQ/NgxkTlDh6LdUb9k+9M6XpZcZxg7TCV8kV5xGeSzJSJj+TcDis79L?=
 =?us-ascii?Q?w2hiU2hl4AevEdkowldvgBCo+ZPP0YpFB35zbKWgW7i4kwBD5eNMVQXyVOSf?=
 =?us-ascii?Q?R3HmruHGfdwT4szBpRa6K6u8CgGxhgnUB1r0o8WGCA/EHOoJfr0V273iENaV?=
 =?us-ascii?Q?KxluRYABQiHj+Nx978BnORUGW9vj1PiGdxr9cNrYnTxtstimAzzwH4vIBNa3?=
 =?us-ascii?Q?3X1BPJq9qBGBAewdjBprGmlz9mGu/u2WZIYCwpEgdvQQa6aTWkA2pLwApHHj?=
 =?us-ascii?Q?6DPMU0r/ru4h5GcKFxpfYpN1IOaFK9AY47BB25v6G/99IBcAt6a3VrDZHzyG?=
 =?us-ascii?Q?TUmOFibG7JunzrvE+FzFMzGWeYBMgo4+vlmUMyjRjAsgeXpB+fB+LPUeSam1?=
 =?us-ascii?Q?4O18BZx+4lMcHzAPnYhIrOrle0l8b6Sztybk5fvVMY4nUDjK1f+BLarM/Pq0?=
 =?us-ascii?Q?VThckYBf7dGlRRBOnfEF12/xpQOMf84MPcuI5/otG53NfPEfDC7MJcu2nCft?=
 =?us-ascii?Q?lWkGLRrEW5XDye9Q5mcMURj1U6EQ2c0hvdzG9tWtpq6oUIt1Z/2EZ5xmzy2B?=
 =?us-ascii?Q?UDD6PpdX4zshNlFcHVyyu0VtpwSASKNVjUpbTCLdimgQ+Yagf8VeNVPtvsIt?=
 =?us-ascii?Q?Vv7UrmGMLZOrYTyFyKPAlyXVgFzquXYPruFhFydlYWQ2QLbzBnswq7jL1Ety?=
 =?us-ascii?Q?n9NPeJR6TtC+qpbZBOf0/+4OVqvx+jnQFkjUVgQp/lw2a06s0+kGsPgblgMi?=
 =?us-ascii?Q?v0yFHgT9AiW27Kaj++ibEN8zSul9dHMTawocl+6d91qlgLJTpfCeazV4TpXq?=
 =?us-ascii?Q?g5L/tdmoGph6XT8NSs2xSIzB2efOdYpcQyLLKJaBdNtNBeuQU2dRKzhD2COp?=
 =?us-ascii?Q?+aYJWZEaSm+uHtwO21BtD+yluX3nvHsCzJyoxVas+1HwFkSgcctLCGAxw7oA?=
 =?us-ascii?Q?haPW0y7RNBZ3TXd5U/ttceFHxifqTKfzdVHj9pivsoAuQiy1XOT5eLizEhMl?=
X-MS-Exchange-AntiSpam-MessageData-1: BjaNlfIsEPX90A==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1155ebbe-69ad-47b4-56d3-08def12d91f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 07:05:15.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6iE2t78j9o8v0WHiXd6mJ9Bq/bUvxtc3J7FbXiUxJgX6GaiSR4svZZ7o87HyF4qpr4LbIPTuFpyxVRFMjIcEtRK/neZxzBPPLbYWoruUuuOX/u7oXox8gmgkse4lMMxGasfuH7cr3gdUXcxGNYeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989258

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Use page pool buffers instead of streaming skb buffers in stmmac_xmit
when snps,pagepool-tx-buf-quirk is enabled. As page pool buffers are
recycled, the overhead of dma map/unmap for each transmit can be
avoided. There is a trade-off of copying from the skb into the page
pool buffer, but this helps where the copy is cheaper than dma
map/unmap (for example with IOMMU invalidate cost).

Currently page pool buffers are only used for single-fragment transmit
in the non-TSO path.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 75 ++++++++++++++++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  2 +
 include/linux/stmmac.h                        |  1 +
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 8ba8f03e1ce0..093c052b4908 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -41,6 +41,7 @@ struct stmmac_resources {
 
 enum stmmac_txbuf_type {
 	STMMAC_TXBUF_T_SKB,
+	STMMAC_TXBUF_T_DMA,
 	STMMAC_TXBUF_T_XDP_TX,
 	STMMAC_TXBUF_T_XDP_NDO,
 	STMMAC_TXBUF_T_XSK_TX,
@@ -49,6 +50,7 @@ enum stmmac_txbuf_type {
 struct stmmac_tx_info {
 	struct xsk_tx_metadata_compl xsk_meta;
 	dma_addr_t buf;
+	struct page *page;
 	unsigned len;
 	enum stmmac_txbuf_type buf_type;
 	bool map_as_page;
@@ -65,6 +67,7 @@ struct stmmac_tx_queue {
 	int tbs;
 	struct hrtimer txtimer;
 	u32 queue_index;
+	struct page_pool *page_pool;
 	struct stmmac_priv *priv_data;
 	struct dma_extended_desc *dma_etx ____cacheline_aligned_in_smp;
 	struct dma_edesc *dma_entx;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ee44bd6f4d48..4aa6b1d1507b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1712,7 +1712,10 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 
 	if (tx_q->tx_skbuff_dma[i].buf &&
 	    tx_q->tx_skbuff_dma[i].buf_type != STMMAC_TXBUF_T_XDP_TX) {
-		if (tx_q->tx_skbuff_dma[i].map_as_page)
+		if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_DMA)
+			page_pool_recycle_direct(tx_q->page_pool,
+						 tx_q->tx_skbuff_dma[i].page);
+		else if (tx_q->tx_skbuff_dma[i].map_as_page)
 			dma_unmap_page(priv->device,
 				       tx_q->tx_skbuff_dma[i].buf,
 				       tx_q->tx_skbuff_dma[i].len,
@@ -1735,7 +1738,8 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 		tx_q->xsk_frames_done++;
 
 	if (tx_q->tx_skbuff[i] &&
-	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
+	    (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB ||
+	     tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_DMA)) {
 		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
 		tx_q->tx_skbuff[i] = NULL;
 	}
@@ -2201,6 +2205,8 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 
 	kfree(tx_q->tx_skbuff_dma);
 	kfree(tx_q->tx_skbuff);
+	if (tx_q->page_pool)
+		page_pool_destroy(tx_q->page_pool);
 }
 
 static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
@@ -2335,12 +2341,32 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
 					 u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[queue];
+	struct page_pool_params pp_params = { 0 };
+	unsigned int num_pages;
 	size_t size;
 	void *addr;
+	int ret;
 
 	tx_q->queue_index = queue;
 	tx_q->priv_data = priv;
 
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.pool_size = dma_conf->dma_tx_size;
+	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
+	pp_params.order = ilog2(num_pages);
+	pp_params.nid = dev_to_node(priv->device);
+	pp_params.dev = priv->device;
+	pp_params.dma_dir = DMA_BIDIRECTIONAL;
+	pp_params.offset = 0;
+	pp_params.max_len = num_pages * PAGE_SIZE;
+
+	tx_q->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(tx_q->page_pool)) {
+		ret = PTR_ERR(tx_q->page_pool);
+		tx_q->page_pool = NULL;
+		return ret;
+	}
+
 	tx_q->tx_skbuff_dma = kzalloc_objs(*tx_q->tx_skbuff_dma,
 					   dma_conf->dma_tx_size);
 	if (!tx_q->tx_skbuff_dma)
@@ -2836,7 +2862,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_NDO) {
 			xdpf = tx_q->xdpf[entry];
 			skb = NULL;
-		} else if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
+		} else if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB ||
+			   tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_DMA) {
 			xdpf = NULL;
 			skb = tx_q->tx_skbuff[entry];
 		} else {
@@ -2884,7 +2911,10 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 
 		if (likely(tx_q->tx_skbuff_dma[entry].buf &&
 			   tx_q->tx_skbuff_dma[entry].buf_type != STMMAC_TXBUF_T_XDP_TX)) {
-			if (tx_q->tx_skbuff_dma[entry].map_as_page)
+			if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_DMA)
+				page_pool_recycle_direct(tx_q->page_pool,
+							 tx_q->tx_skbuff_dma[entry].page);
+			else if (tx_q->tx_skbuff_dma[entry].map_as_page)
 				dma_unmap_page(priv->device,
 					       tx_q->tx_skbuff_dma[entry].buf,
 					       tx_q->tx_skbuff_dma[entry].len,
@@ -2922,7 +2952,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XSK_TX)
 			tx_q->xsk_frames_done++;
 
-		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
+		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB ||
+		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_DMA) {
 			if (likely(skb)) {
 				pkts_compl++;
 				bytes_compl += skb->len;
@@ -4742,12 +4773,14 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool enh_desc, has_vlan, set_ic, is_jumbo = false;
 	struct stmmac_priv *priv = netdev_priv(dev);
 	unsigned int nopaged_len = skb_headlen(skb);
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
 	u32 queue = skb_get_queue_mapping(skb);
 	int nfrags = skb_shinfo(skb)->nr_frags;
 	unsigned int first_entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	struct dma_desc *desc, *first_desc;
 	struct stmmac_tx_queue *tx_q;
+	struct page *tx_buf_page;
 	int i, csum_insertion = 0;
 	int entry, first_tx;
 	dma_addr_t dma_addr;
@@ -4814,13 +4847,33 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		bool last_segment = (nfrags == 0);
 
-		dma_addr = dma_map_single(priv->device, skb->data,
-					  nopaged_len, DMA_TO_DEVICE);
-		if (dma_mapping_error(priv->device, dma_addr))
-			goto dma_map_err;
+		if (!(last_segment && priv->plat->tx_buf_quirk)) {
+			dma_addr = dma_map_single(priv->device, skb->data,
+						  nopaged_len, DMA_TO_DEVICE);
+			if (dma_mapping_error(priv->device, dma_addr))
+				goto dma_map_err;
 
-		stmmac_set_tx_skb_dma_entry(tx_q, first_entry, dma_addr,
-					    nopaged_len, false);
+			stmmac_set_tx_skb_dma_entry(tx_q, first_entry, dma_addr,
+						    nopaged_len, false);
+		} else {
+			tx_buf_page = page_pool_alloc_pages(tx_q->page_pool, gfp);
+			if (!tx_buf_page)
+				goto dma_map_err;
+
+			dma_addr = page_pool_get_dma_addr(tx_buf_page);
+			stmmac_set_tx_dma_entry(tx_q, first_entry,
+						STMMAC_TXBUF_T_DMA, dma_addr,
+						nopaged_len, false);
+			tx_q->tx_skbuff_dma[first_entry].page = tx_buf_page;
+
+			dma_sync_single_for_cpu(priv->device, dma_addr,
+						nopaged_len, DMA_BIDIRECTIONAL);
+			skb_copy_from_linear_data(skb, page_address(tx_buf_page),
+						  nopaged_len);
+			dma_sync_single_for_device(priv->device, dma_addr,
+						   nopaged_len,
+						   DMA_BIDIRECTIONAL);
+		}
 
 		stmmac_set_desc_addr(priv, first_desc, dma_addr);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index dc5f951a311d..0f8d2fc61ce4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -575,6 +575,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
 
+	plat->tx_buf_quirk = of_property_read_bool(np, "snps,pagepool-tx-buf-quirk");
+
 	plat->axi = stmmac_axi_setup(pdev);
 
 	rc = stmmac_mtl_setup(pdev, plat);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..d4c9d77a6f81 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -268,6 +268,7 @@ struct plat_stmmacenet_data {
 	u8 tx_queues_to_use;
 	u8 rx_sched_algorithm;
 	u8 tx_sched_algorithm;
+	bool tx_buf_quirk;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
 	struct stmmac_txq_cfg tx_queues_cfg[MTL_MAX_TX_QUEUES];
 	void (*get_interfaces)(struct stmmac_priv *priv, void *bsp_priv,
-- 
2.43.7

