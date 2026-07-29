Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazhn15011021.outbound.protection.outlook.com [52.102.171.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6C4457B0;
	Wed, 29 Jul 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.171.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318714; cv=fail; b=qxOoO/Zt5YE/NaPYEnMiR2WoZkeE9AjwX9GocrFeSn9h7IFzujYOwDrt/cyHJOSDTxTLYJZynia28qmtm8l1jpAnrfZFozjr8b/E51WNmfamaauoneWLZRXVBbHUYS1yL14RGgmiXPj3RYuU+W57eZcz7G8pcgmXHYpC772SPrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318714; c=relaxed/simple;
	bh=uaRADZSrwn4qPXpQhlFpTbPmUYM0cz5cpEB/J9wKmDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgcXKG/s2r6dywPekM2v8/Gf4VpkBTs4eho3VQlRIFKQLb2XdpWrYzBxaWhq0Jzuy7QQYYCz997dnk970Mc4wIrjYSnjDX7/4+h5gxD9C+DFpJqZJXKnu+T2tbvuH8i+BNyO0YkyL5CHaYJrVJaM9oiFZpgu8rWhyRtFuWchSFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mtY6vDK8; arc=fail smtp.client-ip=52.102.171.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mtY6vDK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rej9ipiM+WveUiryy3m0/vP6XRtnAhPe+rjec+T1Lsy2n1EzLnC70lbpehOYygW+/YNpAg6yxH74BwSx8EbjTf+zO+hrrqkce/A1biqv4CvQJJdinQ+5dclssLyvmcBKKopBg5oXvQYFUwQFTeoJwk1RKUu8GGoZJfKhl5mT0IMTDqqEHNi1xgXG6f4tcWTv1n3vZ4cht0Is8c9F2JJBdn8qVOHYl27nP890QROAV0X89Zl3sxqM7jZigkJ7xzQy1CmKw0CKGXP60Vy1jj9U4aBGBadzpKfLc3o8HahudIOyyz//bPr0IaRxDNwpSv5O1F/XUocuOJRSODgHBKyc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7o2sR7IM10DB9Y49zaLn9s64bdT2PsDtPHCmSuQupc=;
 b=Y+9+gYlv7kXAO3xyqTc2SpvWxzGi4FKWFqOhkERKAjagf2aNwdAMHvPHeQg7B5JYr+r2KYKcZKPGoMYpNXaBZOfVlghipXzazfcbhoeVSgrHIO611OzGm4DEjb2rtkivIkbsJL/ESREfi8elne7B1FZYn7i5GGXikuxeDnPYy3dcvecgkHtRWfdphEbM5JIZnSQroRTx8wNagFmSjTy9Hw6SDcoYFavbo1SeEkNCJOx7OzhEIMtewHfO+nO17mTeeyx4TgJsb6xGQUjI3/ExKHZqT3v7HYNHi1xQdo09xD9Vgnxf87giiU3kQUjXNIU9VEX/TaUOFldaZHuNeB6FxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=altera.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7o2sR7IM10DB9Y49zaLn9s64bdT2PsDtPHCmSuQupc=;
 b=mtY6vDK8ylG//Z3A1hJVIv4zG/cEdRMbE4pIc9OrFJPIQsBzBGwHN+d0H6WQ1yDb9bTaKh+yXN0r6LGnAIaiAB0HhO2mdxFAGWhumfmjuhiQ6GxV/8GH/AkUlVMxATscCXiw4OkZW4NAnAlqaUTsJpksTNoMlhczJAgfuyG4mD4=
Received: from OS0PR01CA0033.jpnprd01.prod.outlook.com (2603:1096:604:25::20)
 by TY7PR01MB13604.jpnprd01.prod.outlook.com (2603:1096:405:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:51:46 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25:cafe::39) by OS0PR01CA0033.outlook.office365.com
 (2603:1096:604:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 09:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 09:51:46 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.40])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id EF523300027F;
	Wed, 29 Jul 2026 18:51:38 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	jun.ann.lai@intel.com,
	yi.fang.gan@intel.com,
	boon.khai.ng@altera.com,
	matthew.gerlach@altera.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net 3/5] net: stmmac: Move double VLAN handling to a dedicated op
Date: Wed, 29 Jul 2026 09:51:07 +0000
Message-ID: <20260729095110.164157-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TY7PR01MB13604:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab30c106-91bc-4f34-6878-08deed5700fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|7416014|34020700016|56012099006|11063799006|10067099003|921020|18002099003|22082099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	+dDMOkkcckJsYGyI2ZdbGnF6UMYf4o0XjdY3oCeTn4lhDh14dX0rPBM9XyE2xagbRzzDHgwF+oLgywLZQGhSz7AZPaoTVymPpS7WE3Ao5rJKccKRvC0gJzkikRt3KtnUiMTJZE4D7eLP4Q2Nkuwge9+I9s3wXFuFze8AK9BFp65CUrUwefbxf6wV6CPllBY2N/hywygT1bL99ZW3sbBDDtlit0XPAvXdLCmtiCGWY8cdWAf2/tD0+zcJ5zcFEiaoupBrX7Wy0HijtQ+iD4xAyswhJsp/qF954vriWhFV9k6ZEo0EHjwmDtBCR1nmq5DQMegI//AVHY8zbHCpCmAiW9kvCio02d0IcgANP2MpoLOeVaJNOx/8RZ25phv8op9DVzNsdKNJGdL9P1R7Cvx+vP2Qpgn+nJNzSb4Kp1WotoPMy6k6SgNypYHewQVuKEZJcBFCnRvzeRqqucMIlvwsZfq78cKPrAOv/pN23bDHB3TZ28VBI5qlDhEVdc3M3OCVSD09WBCdpXzku+BtcQAVtF6GOtlf02uMaQnruABfC5OSVDU8fxND+AanbgDXMeC3IlRiueMRKHGBZSwOOdd34WOzQ+e9n67oeq7ZR3S7QDctXDGZm4eDe7eniHyDpZdNAs6qsBwvtNIuEmaLuuuY/6mlL5J2YLW/Mk8xBV9EFqoaFzDVaSNY9hVOznK1zwL6F+MpDIDwBEGbJ8inyB12y5unpEPKUpFkyeOpKaT2ruvxeJId4qOaTMF2MPQGDac3
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(7416014)(34020700016)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tuPZMVkp7CXLpw+yC3MLSdXEcYoJKVyTM6EWWllGAWkJ2018dTRT+RcKaO9ACWWtTpEFy4LuCDIssOw+46eIEdV7C0cmO6Vou7mFrjniJykMvn8UByI9yHDuqZO9jotj4BF/6es7iUVY0WPBYz77ST4NY4x6sEMIpuJWIYZQmmk3XjsA+rIv21pIqLrXVp7d/wFelywRhu07KCkCelS5pKv94xMjLsrVsZHzlXweCv4P0iQy6/0icdr1PSOsoQO3JG6K2oF+7S7Odo32teF+skOYvSJGAWkDzimjVI5Ic5mocFD57Ril3TRK0mX0jhigL59aFUc7W7JU7vX7+EGUP/jVlTjRLYVHn9Kg6xmTO1CuodeNZmwZyRzgstnG5i5MxJ45cF0YEs/PSdIUUBgEzetcDvp1hJ4JByv5LEYSkLkK/9YjI+CTXOYCZi9C66W2
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:51:46.6845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab30c106-91bc-4f34-6878-08deed5700fb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13604

The double VLAN bits (EDVLP, ESVL, DOVLTC) are currently handled inside
update_vlan_hash(). This ties the double VLAN state to the hash filter
update, even though the two features are independent: hash filtering is
controlled by dma_cap.vlhash and double vlan by dma_cap.dvlan.

In preparation for removing double vlan support from dwmac4, move the
double vlan logic into a separate update_dvlan_state() VLAN operation.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  6 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +--
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 45 ++++++++-----------
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 6f26dbf95ce1..66837caafa84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -632,8 +632,8 @@ struct stmmac_est_ops {
 
 struct stmmac_vlan_ops {
 	/* VLAN */
-	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 bool is_double);
+	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash);
+	void (*update_dvlan_state)(struct mac_device_info *hw, bool enable);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
 			   struct sk_buff *skb);
@@ -650,6 +650,8 @@ struct stmmac_vlan_ops {
 
 #define stmmac_update_vlan_hash(__priv, __args...) \
 	stmmac_do_void_callback(__priv, vlan, update_vlan_hash, __args)
+#define stmmac_update_dvlan_state(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, update_dvlan_state, __args)
 #define stmmac_enable_vlan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, vlan, enable_vlan, __args)
 #define stmmac_rx_hw_vlan(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ecb8eb7e29ab..ee75cbf6e935 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6802,10 +6802,10 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 	if (!netif_running(priv->dev))
 		return 0;
 
-	if (!priv->dma_cap.dvlan)
-		is_double = false;
+	if (priv->dma_cap.dvlan)
+		stmmac_update_dvlan_state(priv, priv->hw, is_double);
 
-	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_double);
+	return stmmac_update_vlan_hash(priv, priv->hw, hash);
 }
 
 /* FIXME: This may need RXC to be running, but it may be called with BH
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index 983a90cb9767..1e47ae62093e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -161,8 +161,20 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 		vlan_write_filter(dev, hw, i, hw->vlan_filter[i]);
 }
 
-static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
-			     bool is_double)
+static void vlan_update_dvlan_state(struct mac_device_info *hw, bool enable)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	value = readl(ioaddr + VLAN_TAG);
+	if (enable)
+		value |= VLAN_EDVLP | VLAN_ESVL | VLAN_DOVLTC;
+	else
+		value &= ~(VLAN_EDVLP | VLAN_ESVL | VLAN_DOVLTC);
+	writel(value, ioaddr + VLAN_TAG);
+}
+
+static void vlan_update_hash(struct mac_device_info *hw, u32 hash)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
@@ -173,21 +185,9 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 
 	if (hash) {
 		value |= VLAN_VTHM | VLAN_ETV;
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
 		writel(value, ioaddr + VLAN_TAG);
 	} else {
 		value &= ~(VLAN_VTHM | VLAN_ETV);
-		value &= ~(VLAN_EDVLP | VLAN_ESVL);
-		value &= ~VLAN_DOVLTC;
 		value &= ~VLAN_VID;
 
 		writel(value, ioaddr + VLAN_TAG);
@@ -236,8 +236,7 @@ static void vlan_set_hw_mode(struct mac_device_info *hw)
 	writel(value, ioaddr + VLAN_TAG);
 }
 
-static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      bool is_double)
+static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
@@ -253,15 +252,6 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 		value = readl(ioaddr + VLAN_TAG);
 
 		value |= VLAN_VTHM | VLAN_ETV;
-		if (is_double) {
-			value |= VLAN_EDVLP;
-			value |= VLAN_ESVL;
-			value |= VLAN_DOVLTC;
-		} else {
-			value &= ~VLAN_EDVLP;
-			value &= ~VLAN_ESVL;
-			value &= ~VLAN_DOVLTC;
-		}
 
 		value &= ~VLAN_VID;
 		writel(value, ioaddr + VLAN_TAG);
@@ -275,8 +265,6 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 		value = readl(ioaddr + VLAN_TAG);
 
 		value &= ~(VLAN_VTHM | VLAN_ETV);
-		value &= ~(VLAN_EDVLP | VLAN_ESVL);
-		value &= ~VLAN_DOVLTC;
 		value &= ~VLAN_VID;
 
 		writel(value, ioaddr + VLAN_TAG);
@@ -285,6 +273,7 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 const struct stmmac_vlan_ops dwmac_vlan_ops = {
 	.update_vlan_hash = vlan_update_hash,
+	.update_dvlan_state = vlan_update_dvlan_state,
 	.enable_vlan = vlan_enable,
 	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
 	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
@@ -295,11 +284,13 @@ const struct stmmac_vlan_ops dwmac_vlan_ops = {
 
 const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
 	.update_vlan_hash = dwxgmac2_update_vlan_hash,
+	.update_dvlan_state = vlan_update_dvlan_state,
 	.enable_vlan = vlan_enable,
 };
 
 const struct stmmac_vlan_ops dwxgmac210_vlan_ops = {
 	.update_vlan_hash = dwxgmac2_update_vlan_hash,
+	.update_dvlan_state = vlan_update_dvlan_state,
 	.enable_vlan = vlan_enable,
 	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
 	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
-- 
2.34.1

