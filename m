Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazhn15011020.outbound.protection.outlook.com [52.102.171.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EB46A606;
	Wed, 29 Jul 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.171.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318697; cv=fail; b=Q/9jzPryIxJ8mlDLeFtZdB2iMyF6G2AqaK/cMCq9hfAk6xHd4SCMDit7urNonTFXJOFTnlJr0Zt/yXRdePXZk3KdWeLV63el28EdKxHAYjpNrziJ6W2TgLTzs2/uAGv7+Kr3JOtBQ9jJg5Te17W3s8W3siVv0z7HugW2QqKJGYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318697; c=relaxed/simple;
	bh=I8VOnC8SrfvI/zibCvHY7xG/Cbxt9stcnUHyQ0xlLMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDxbOYAucA+MAP732GSN0It1zYTDW6r/2mznYbq2VQ84UA4fRHnjjwSqdecG3JNbU6txnxvB0TFx2GYz9JtebOGKoKHWlhFUbysjEzRzWT+jlFXsJDKcvunBy3QntA66CRG9AxpJ0+MGPZIXvTbrMLntdSGItm7A0MUBuZLWT6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=eqBqGY8p; arc=fail smtp.client-ip=52.102.171.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="eqBqGY8p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdf9aRcsCUXFweGjKP0RR/ASrNwd3/BcOGIwNh7oRrMrOBW7zVDR2X6g+T8h1ikwJmLzLy0ESGoMNcBVF0OIpPEmVH7tmKMu/HeyGfPQOvHhLomTsQsD+Ulz4dKLBeb4PeeN1lGRSZK3G00gPA35alFnYOGOfyy9Wj97IN5mu/lUWB9TAa3xFTRLzRFPZPGUv+Fm0LGTu0ImjU/RaS50he9Q28MaEnhP1g+6+7pPbcO77EdHhWRsLrLQ1dfKMfz03kPLgz60rpSZPCwyT/Rw2JL8n7YhCBK8fkJZwCahLhCiEfAtRZz8gc5B7OZpmzUY2trOiyzhCT/XVt6rfzeA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Q1Fl2Tzh+zIO7hH8XOIYEJJbbhFXGGM3XyrE9BKtA=;
 b=LhbaVHBciAO5bJJS7ANmo8QPn7no7Pfr3k7C/74/BF9reXmiJ6zbySv6TgqWtMPk87Z8KGCWT/Dm+dU56F65PQDMnjvG+Mgd0YMfnemgAWBasDq5iKn+JsbViMXSedBgIDtb1yvSSCd1eSrU/soPjfr4Ec5iIK4nP1hXDLKn+TvhjPXnPyMv4CuYbfV2FVwq/u/P86oxBmBGjf+KQUULVxoKiLsxnfOBtblvOzpSGtjjQeP02oykSLOGQ85fqucWxCHhmvXua8xWkowx3QN9vJM9MqVWdOx7vsolbQB0lY9GRrLu4LScMR+0wHHVy/PTcfXnNG4t+PaN2FoftubUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=altera.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Q1Fl2Tzh+zIO7hH8XOIYEJJbbhFXGGM3XyrE9BKtA=;
 b=eqBqGY8p5xvyhv5NboZCIpSO/9nxcg1aBRE6/+ExgggD7dqKoF1UHHMDWFa9rQeYd9BkOz6hId8eCe4I+0F1tPuiFSwABoDWa3kAszXyXc5xB2kSKNaTEuVgNWNaLHaix4XvPOpZWfbfhWXD7zlFvADj1u6G6ODyXfg6DKbrcJo=
Received: from OS3P286CA0123.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f7::19)
 by OS3PR01MB8747.jpnprd01.prod.outlook.com (2603:1096:604:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:51:30 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7:cafe::44) by OS3P286CA0123.outlook.office365.com
 (2603:1096:604:1f7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 09:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 09:51:30 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.40])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 4C4BF300041D;
	Wed, 29 Jul 2026 18:51:21 +0900 (JST)
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
Subject: [PATCH net 1/5] net: stmmac: Remove VLAN perfect matching dead code
Date: Wed, 29 Jul 2026 09:51:05 +0000
Message-ID: <20260729095110.164157-2-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|OS3PR01MB8747:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4886929-cb45-4dc2-5268-08deed56f70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|34020700016|1800799024|82310400026|921020|56012099006|11063799006|10067099003|22082099003|18002099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	Gr3a4o0qlXcvBJP4mk2Um3cSyuK1/EzHrxKnj/+DaGyuzXFYeNkR1jYoReXlu90dRTMlWMnownPdDbOgXMbE6esw2pD4pasFjrUwXpKzCl1pT0fjyWXUnR87kVPAs0DFeU5nNaOm5XX9c8wTDsFS4KE8nZjT1pwmifgDI+oH71jiYQDvyp7QCrLbw+mgg/f81PnROOoOZcj8HdXetJJQGCBXScgFEFUOY9zZaFm1xqNg4kR7DGgTg7Zg5Xea1RohFjxh8oDycz2FzfEWMZytKtdfEJofsl0igQJaHbk8ZAW3M957F17sGxAD8IbiP5j9x75CMdMj6p+HG9euD5TiEEcP4yzpotVWyB9QqaKKxIy78qBw1y9NHuXLMQnhZccUU2LkJ6cMtRbP9bAohRQnjB0cYrKZ4zyUHHba6USCaMdgCV0UDtcyr7BJ4XUhadjNiu6A9ABllFjkMwq3ZOsQE5KgpmWNdsN26PNNq1piCsh2HXL5Y0B50yJST/p+KNLGBCwe3yllHfo2/be+zUi5+8xVNq3/Iyo/iLqzs/q7uzqPwzTshyn49X4wwfmCNY0UEiEgKfyjrE0GvugVmeZEJpmhozGi42hDzbzobKaqmaRtJCceUGexQF2r3GYaVhyEVDz0TeMykjT1qkK7jRGhD6X8oSGcjIYbvVCd5uYBFOs4o9FSE/o62DInS7Zrr23PcAAAqvLFf1snRjxqpGSvAqM8Xk04PYpubpWGDflzAJwEBB4XOf0IOWMI6qfhzZHS
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(34020700016)(1800799024)(82310400026)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KFiEDQeZ25yMiTPLDJKhgPM07OMR12NGdZOla0wRkwSy329fhbVtnE1Mr0ycOeYyHLY26qKiHDY2ezfZVsfVbWRHzUeEyto8FxrEM8XaNcYFXL4mvAESvUINoyee1SXt6VZPosFaghRutZVT1s9KZsBpgy9FgTOP17g26A5SVlLAddw9DmQQM28gD6qkSl2zjdCqw5ii4pR384WPATe8HzDUg5J2Lj1G0sYfPKRF2cEoxx5Or3I/AQba2DV9Yluox82uHi8mG3iC8lz7UWw3hXUMWROkYM+T1lLtobrn4axdzXASn15f2fTANKvyfkQzrpWLp9EXwbrdmZcL+hk0EI01+M916eDE5+exM7wffCkgWpiTxMpSRwo2rXc3S9rw9G3RpHatRS+S/aolW/9QRmpG0eD6V7iTsQBxlYMNj+EpDwjcYXtubbM0Qb/W6g2p
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:51:30.0164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4886929-cb45-4dc2-5268-08deed56f70a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8747

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
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +-----
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 41 +------------------
 3 files changed, 4 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 04dafec021b4..6f26dbf95ce1 100644
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
index 0de4bc949913..fc9f1342ea45 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6791,29 +6791,18 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
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

