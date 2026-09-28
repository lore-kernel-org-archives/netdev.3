Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010006.outbound.protection.outlook.com [52.101.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6D43FD3F;
	Mon, 28 Sep 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627702; cv=fail; b=qAX9AjKPz48Z6mhmqXjrgU+M8xLpw/DhJjWQ7oDOX/YJfWX/9QP4BO5eqtkGjNad6E1jJrSVr/OQ/aGXxAWcZFEmKIb56TQrzGSvZ1bMa+SdkV5IMMMALKHHKYT3Jxi/MPVpaahKQyL60oaamSnSiA6P+CEevPpbeB3BpIQa2Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627702; c=relaxed/simple;
	bh=wJ3u5Hx53zDl340RGgXfDjbfawr0T0UwCNKkpnCwOrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn/5cL2CuJm5AzBijO7RTStF/+YGOwkjfbnAKdL1hxyig5TF7NrUe6efO5qgQD6DwEfVjhr3+fMg6FiWAUhzw3laWkfazO4W0qEdo6DXMOOxchVqMhwlLii16A02xheL37enh0a+xdvbWcpzz8MMN+wlelgWdF9lsBcGfJi66Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GBJC69n3; arc=fail smtp.client-ip=52.101.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GBJC69n3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBQYJGq7RrvHym43AHZhvGrDZvFTFJFhQ0WWTvVXl7Mz9zsi/9gfZ4QS0psO92asIfhmZnRCJl5eSvGiTRqUYD9GDrUMsUjj8nxx8vToSJY0vXnppGOCV/VUAyqPS1bKDN/K8/44YCeEqakcotIkfplQdyFulSUXh+ZO0lIYXtLdr6FXvkeAQry1uclkrIJpLb21+mn4JtOPzQV4+2KBKf3aLjx8W5ZjXu62eAug/vMKyZdfUd2ZbVHejw0tkWNDJChcRkSoxvjZpogOcMuaxch8lIM9Ww7UMAF41Z/fuldKL4xkhYresmRY9p915TsSIYqAI5WyL1dNmORiZ4f/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMZqfY7M2hcLZrP3CUvA9xr0iCAn0oVyKHjdPucaEzs=;
 b=oq6NrZMteOgrgScZJZIrQeWEDLKWBsQ6a5w8wtwUDiYZzsV+Jx3WlIo2sC96lg59hpe+kdk8q3ELJxf+TGorZ/VLRcXXqSczXp514MxLGUp6DbFYyPoiYMA6yPLYfjQFZyaap8ru2cI1F+Ee7x54m8KDFKhqe1Sajn9mHVfU6WwsS6wCPqV8uGS8LoR1m0PXN6tdPuD7PhxTCUpoOCyIoiVvrJyPdt9qwHVpxGqgjBGOaE6T74CHtzYUgmbevEPu+nnAC9VmfTY1tk8qxkHdvXsPWVm7+2neAuJFHjTlAfCvclJmuL5MXc9uv1txEnrj/13DXxp4riVNMGp+EZ7Ijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMZqfY7M2hcLZrP3CUvA9xr0iCAn0oVyKHjdPucaEzs=;
 b=GBJC69n3/rc76YV2KulOlgsZ7gzJTsxZjq0GEh6hkvqPWqE916UREGd5XgpDhr83oi7Tgrynmqcz5oPC7HE9s2x0qtdYP9BI17sKWsSQdKPP9hQT5LsSFECwLfyqYyjzNNzeDXIEKeI8xYjS7dtRWhiry+LaG46XPo4SKYn/bJk=
Received: from OS7PR01CA0288.jpnprd01.prod.outlook.com (2603:1096:604:25a::20)
 by TYCPR01MB7060.jpnprd01.prod.outlook.com (2603:1096:400:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 20:34:56 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25a:cafe::92) by OS7PR01CA0288.outlook.office365.com
 (2603:1096:604:25a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 20:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 20:34:55 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.32])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D5BCE300027B;
	Tue, 29 Sep 2026 05:34:50 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	recv.jo@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	jun.ann.lai@intel.com,
	yi.fang.gan@intel.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net v6 1/5] net: stmmac: Remove VLAN perfect matching dead code
Date: Mon, 28 Sep 2026 20:34:37 +0000
Message-ID: <20260928203441.34876-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
References: <20260928203441.34876-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TYCPR01MB7060:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0383bfce-41af-4afd-e4b9-08df1d9ff52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|22082099003|921020|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	yETSBadjaLH0iSwCNqldOMakTb0lzYvh+3bbmyoehIh5/Am+pMSQRbepmvsdyDW1ljEFNhkJiOwRugeEbywi9WxcbqlDkiCgdYEt+ISNlPa0h4sZo+qpuF5zClXud8n0d7snvuFYwVPVAB/IRTnncpvTrg1fannCCNa2vQUZfk93JCpNpYsIGlw/R/HSU+7jbXovecZUSNKtz/1uJVy/wy2vu8Fw9vXBwM7NiANvJ8MXCN8eS/I+1a3Rie+O2JOCEJllta0AsVOIAkCh1bbJ7VgNyb0mcZb/S3OR9TsklCj84RgAAZJeKhYRmY4yAgoWvZllyytG/J04vODq0RDHV9r0ss5Iqi+uHDTifLfjAKnrFmrmpjUFg78b3FrRQYDO2qff+HdsqqI/kkmeTDjV6JZzGJKHAcvVp+/Xh+HzBvQcUgBHzOo/3nzg2LzAjF9urtCMaHD+YAWGl+rOJKOBix/tiMZEmCvmDmI4Ck2rE8N6GjwlW7CFUf9L//kmSUipKMogldnU504utuNUUoV09LTikePw0KPkdWbkgM41vM4VAwIgdQrREXjIh+ar+sGFl3Zk8mzOGdBG1LrmPKDFzQfryrmFvXhMrRcJpdzn0UataiOyTok6mrhkgFiSPi53yV7BTL1DHW1wbGcSp9us7wJjr5UL3wXwde0SUIIl2v3LEWwQxmTzp6dFqu2OclgvIrhSrndhlpSTG4N2W64LW1aH7WhcykRlPRSMzS6P7+mNuNuh5Ne8GisLegcx+wyu
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(921020)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r9+h4HwBXrEyOWyUALpK1/NdeOBK7YfqG+Z/tpOQMbP6TKXMrIfBHv10eB39reDmS3g3RL0wUtZclLfzc901cA0WpLc6gji+gWdEaLs7a48OL3OJ8M1gdhnDnFk37twTT+VgEtCgWN2hSwAp+gI4pQizOE+e0idrHK6rkWYfrXoPBlzZAAD67jORUl5XuLHQ9bM3AeqjEgEOcTvn214UvW6wpuZoafs+qGElVT1cws7/upYtQNgl7GX9gMslMddqGSUQbOoQFrqzPKaSrjiWeTqR1jqlrotm+rG8WH+abdmJWPy7b0zZkk2LTgFzh2Mtz9HczMFsM/qX87QNKJferhO2ie0grFqYleABKUis4NjFYa1lVgWiqOgV7mPdkWjzxLAi5+BrZpNkluDUZVDyGwJsCFepyz6viqSDhtOxL45ay429g2ynjkMx2tbkRlYY
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:34:55.9591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0383bfce-41af-4afd-e4b9-08df1d9ff52b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7060

stmmac_vlan_update() falls back to "perfect matching" when the VLAN hash
filter is unavailable (!priv->dma_cap.vlhash). This fallback has been
unreachable in normal operation since its introduction in
commit c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if
HASH is not available") because the NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER
features are advertised only when priv->dma_cap.vlhash is true.

The fallback is also duplicating the code in vlan_add_hw_rx_fltr(), which
is always available since stmmac_get_num_vlan() returns at least 1.

Therefore, remove it.

Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v6 changes: None.

v5 changes: None

v4 changes: None.

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +-----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 41 +------------------
 3 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 857f7562c6c6..df2126d71c2f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -633,7 +633,7 @@ struct stmmac_est_ops {
 struct stmmac_vlan_ops {
 	/* VLAN */
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 u16 perfect_match, bool is_double);
+				 bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
 			   struct sk_buff *skb);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f34d491c959..14183f92663a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6838,29 +6838,18 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 {
 	u32 crc, hash = 0;
-	u16 pmatch = 0;
-	int count = 0;
 	u16 vid = 0;
 
 	for_each_set_bit(vid, priv->active_vlans, VLAN_N_VID) {
 		__le16 vid_le = cpu_to_le16(vid);
 		crc = bitrev32(~stmmac_vid_crc32_le(vid_le)) >> 28;
 		hash |= (1 << crc);
-		count++;
-	}
-
-	if (!priv->dma_cap.vlhash) {
-		if (count > 2) /* VID = 0 always passes filter */
-			return -EOPNOTSUPP;
-
-		pmatch = vid;
-		hash = 0;
 	}
 
 	if (!netif_running(priv->dev))
 		return 0;
 
-	return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch, is_double);
+	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_double);
 }
 
 /* FIXME: This may need RXC to be running, but it may be called with BH
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index e24efe3bfedb..983a90cb9767 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -162,7 +162,7 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 }
 
 static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
-			     u16 perfect_match, bool is_double)
+			     bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
@@ -184,20 +184,6 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 		}
 
 		writel(value, ioaddr + VLAN_TAG);
-	} else if (perfect_match) {
-		u32 value = VLAN_ETV;
-
-		if (is_double) {
-			value |= VLAN_EDVLP;
-			value |= VLAN_ESVL;
-			value |= VLAN_DOVLTC;
-		} else {
-			value &= ~VLAN_EDVLP;
-			value &= ~VLAN_ESVL;
-			value &= ~VLAN_DOVLTC;
-		}
-
-		writel(value | perfect_match, ioaddr + VLAN_TAG);
 	} else {
 		value &= ~(VLAN_VTHM | VLAN_ETV);
 		value &= ~(VLAN_EDVLP | VLAN_ESVL);
@@ -251,7 +237,7 @@ static void vlan_set_hw_mode(struct mac_device_info *hw)
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      u16 perfect_match, bool is_double)
+				      bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
@@ -279,29 +265,6 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		value &= ~VLAN_VID;
 		writel(value, ioaddr + VLAN_TAG);
-	} else if (perfect_match) {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value |= XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + VLAN_TAG);
-
-		value &= ~VLAN_VTHM;
-		value |= VLAN_ETV;
-		if (is_double) {
-			value |= VLAN_EDVLP;
-			value |= VLAN_ESVL;
-			value |= VLAN_DOVLTC;
-		} else {
-			value &= ~VLAN_EDVLP;
-			value &= ~VLAN_ESVL;
-			value &= ~VLAN_DOVLTC;
-		}
-
-		value &= ~VLAN_VID;
-		writel(value | perfect_match, ioaddr + VLAN_TAG);
 	} else {
 		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
 
-- 
2.34.1

