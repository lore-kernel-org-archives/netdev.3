Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011058.outbound.protection.outlook.com [40.107.74.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFF250BF2;
	Sun, 20 Sep 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789918569; cv=fail; b=HkD3wZP7qYSJSXkvGIXjYc7TVddxfx6z1qopwgrYHKahvAaKtFtSa71SHMDQ1MymkpSRPuw31XCt8mxOrTA6mEDm67Avl7EGpTeYlKWJ0iVQGXHr7QozEO+YceO5Ya1wpINuZaKcwU84gKBYgeOCo0yxKMKUHDHzmBG7UXVhk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789918569; c=relaxed/simple;
	bh=YW36rY8hjJG9/mPilof0JlxUScefoMrpl8wnHEBN9yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It/IlMMmS5wYjVUI7fuupJqL/49g005KQTSmi/UXoVS5SMLvNIFSDfGu67Gtb8KbT0UJ7axJIIiZWR0T4b4sShE262J9vZU+7pIYaPV4ctiHc431YzDa+btfTCRb8r1ki8ewm9kX459+apXwBEX8Drj2rENPVDtuA4IFlvJ79bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=IFnukrm+; arc=fail smtp.client-ip=40.107.74.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="IFnukrm+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIuU3KXIPyCG09X8+SdBKIvttR/WgT6j3s9kfK9CtTn7wefs+0KWQEcvfGKaz3XXSrpwE7dNhjy1es7cQs4MjsRNdRm2CiF1FcinXbC2EPvRYMBq4bvGdziJlegngCNENXzfdXwWkI+Dfv2K34HAir8k9KE3OeSEj1jmdvgJax5N1mrdVJv8TAhcEOpsk7g2uvchFdB2zhnXqxHtWQmWh6Q+QBIMniTT+IMZcxy9lkpX2/jDDFRqaacTqIGWj1hjwbWbysyo0ty+TCUA3swvY9hCsi7k4XpjFVRv+snygk7aKouYyHFVXz1YP6yBJyQsHu6JrIjyRWZ2jLoJfX3mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjSBc61ls892xjlJAmJCeJivDhKrntumx+3Kzfv534o=;
 b=Vf0ZqpqfOy1w3kZg9nSiqw9mC1Hz8p6bL14sHF+HlIzeI6J0SSKYfXVp5/XLZvcUNcdnMIIcMio4UGwqMyQvxTvK+B0Q+6wloHnIUrvOdGsRu3apw16cEAM6rr0psNoN3geffiB5VILvzeTjBzXY6+zFHZN6R9+MCrZTq99vaUtbj1hdenO0j0J1rtQc709TIXZTVqh+13DUpQDC2Xk3lfsyeHdGeo0xM8mm7tgZLMP0ySLj6/Zt2wJ1hFWtKJMooRmuRqmOC8SbSSxmYxhtP5wu0Jzh6JIu+nZr0HEV3TLD6tnfG/Sds1RMhayVhvRGa6wrEhMTQvtzw9DKrJbPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjSBc61ls892xjlJAmJCeJivDhKrntumx+3Kzfv534o=;
 b=IFnukrm+a2ONn5USpTJRs8AEEUMonzzjv6sRs0xOnJz4yIgZDAcLmhlzbmmx5sBFV0pDZvr/u7VD6DTV912PqSjQeNvdH4s8uJf3abYRTQXZVgazfFaBqYxmEPIdWvVPcjcLSL+qCwVQKMxd3ATVarKbkynUf4rbVhp1eNYMXk8=
Received: from TYCP301CA0030.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:381::20)
 by OS7PR01MB14446.jpnprd01.prod.outlook.com (2603:1096:604:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:36:00 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:381:cafe::1b) by TYCP301CA0030.outlook.office365.com
 (2603:1096:400:381::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Sun,
 20 Sep 2026 15:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Sun, 20 Sep 2026 15:35:59 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.22])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 41B9C30000BC;
	Mon, 21 Sep 2026 00:35:53 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	recv.jo@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH net v5 1/5] net: stmmac: Remove VLAN perfect matching dead code
Date: Sun, 20 Sep 2026 15:35:12 +0000
Message-ID: <20260920153516.103461-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920153516.103461-1-ovidiu.panait.rb@renesas.com>
References: <20260920153516.103461-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS7PR01MB14446:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bdf12c6a-6db9-4d9f-fa22-08df172cdef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|10067099003|11063799006|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	2vqGUfL3qr7wW7NhEarWsuwMQbeyJVNdglnDLo4PIijNxfVJlksjsvajVkcRAAyEqoOSq72uvNEIXR3Povq0pq9/yTR8kQP9O+9732vHrb/CWRoNGgGavFg2QgBNxRHH2IXjgH4NEOyWYslECC+nPccfiQZFnwjaiAmP/pYlrNdniePbUehftVJFG5FVutXl6WTHfcbBtYpmrX2aF4Fs2mysPekhGSMMEjgGCGC3m2LovZ5yrcZ5mAvynDRdP2mbV2cuye2EABLQ1yqx0qRy3GjTOqo6uBw3QADv9vMKHZjdPzUNBg3YgShJZbeEzauk/6tue3Km/RL6eTqor4RSuXp9FfbaLf2B1YBymIX+GNnhVIiZ+b8tNOjl6KkPW01q5I1nRznxzqzNPhRI5eybfry6sk4c6GIP8R9d3Zfu/vgbAWIlGkEN1JXiWfN8HLaDWYosIppFMHEUcvNGUDybXC3rrnaR1bnF8lA/RUwzSu/PnAoDt+Rbc+kwzABXbxK19aGlYoBrjC1n/mLqw+1GJ8g5/CQWl/D0LOSxkPWy0xFVVxmGeDvVnE7RMr6BgIy8Nm2tzomdCdVSIhb1YSsJI3QOjWbQ6UlTVOdou105lEjUKFcSTtbfLtvCqsdleEKUTGUPNEsJtWZMAYhdk2iABJ/ZWV/ivNFm3/LxJH3CMmqqcd3FgKaCngX29XhJWx/PYARc4u7PUw5CK72IAen4vFrzNA9r1HDhaSWCoDhrit20nJ0x+w80xRmWgxHSiIOk
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gRQpP7cBi2NVOIHsSiAdblQxIZRCMHGBkERFjB+S8cKQyIL5zkyUXl0DXEzhjNAJ+dDPvZEVt3oHby3IFT2nOqtGlYjCub1zO2Gf83CiNjqwHr3hFLJZzXs9HOk2n0QvE36UBJyRYS+5B5fpykYmIaQcS8HfMZJYWhRzSv3u8E0mu6WMlIKL0++H2EQFF+kxu4EaQytzhnloZ5vK9RxkYHLGtr+DQ3lI4Ur10l7kGNlMCclVEqx1XCRYpMk5znu3hzdw0GQJopGGOJJKPezAZMyWPvc/7nMw8e2y8rxUvgK79QU++N9veZnpmFbDHzfxf9BJm5Avm1C8ybB0ORcALvUKRoJ5HipzBc5UFBwncoBwjVvhPMwdVguDEHswX7ZtlJSffi3wphk8R1UyfiDzufP8juKJi89NJRq4fRnnbDTnMEJ37qaPUDRPiZUXQ7JZ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:35:59.5745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf12c6a-6db9-4d9f-fa22-08df172cdef0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14446

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
v5 changes: None

v4 changes: None.

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +-----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 41 +------------------
 3 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 9314bcb85c22..734e30caea81 100644
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
index 1fb5f804ea23..d0643a30db1c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6835,29 +6835,18 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
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

