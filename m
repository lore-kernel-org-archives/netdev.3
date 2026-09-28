Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010059.outbound.protection.outlook.com [52.101.228.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC15383C86;
	Mon, 28 Sep 2026 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627714; cv=fail; b=RHU4YXYPQ/xTURsewYZVpGrzY//blk9S8lUBDo+IVCN+6diLcLsE0WJ7zDAavbMtdugIh/kQjOPu1F/ZUP76k4mOuTJf9JbWu6x28aDNSfkCEHq9QSSH3QAqk/cbFsnLrTXZKOMADep1RLVNWqRTocrqkSDeVrdcaIz5K284LUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627714; c=relaxed/simple;
	bh=FhINTibjNBy8OVffXr2QnghM0AP38xwdv592b1CVl5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kduSnowco5QIkLcJmwVqe+obKrD9QMa6tjP3Gkdoj9Ry/n8JRc430TtbiImxoomFWXvmRJy3I+KhdmMIjvWCrZc6A/PkBmUtaF4DRxGhjayx8IGh7Ax8hkgDBmrkpQCZQgpJiyrsxGLf0VVHb66tkFPTHFaWJt7iBsDlVq/NBf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WsYsPY4C; arc=fail smtp.client-ip=52.101.228.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WsYsPY4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcLQciCQsuovJQzWFXLdChcWdnlkWwJOrJKuhpJy1Yv53pyXnECTqcvAevzBaUKMI2HdzpuCcd5Ju/dWrfcIIFQ9B5xe60Ucp9y1AV+l/OWQkGr3SyOdBBISgk92l3qwxy68GQcjoz2ajEu8kmceNh1EVQkfXbFe1YqeU5efpenJyW2NR83wy5fEq9jm/+5ASehLFJmdhR2fdHgWy60Q8CbDoEXg4ytLyI2QuKyq/DMA3nV0vd3S8BnYsSwI/sbDQYFvw8RLlcjsUibdKs8iwbCoTAoWB2w6XYUcjiweQThug8CmaWvG4CGm6Z5J9NfYCfCuWJmBIIBoBTfnOw6+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nFT0DBLJDhHQCmfPlmiF+vI9RR+0QbQW5j3iyFECK0=;
 b=e54RvCvZw/08A1lI7VhDIfvO6qKQu3JDd2sn4fWIiiZP+P8eL8+Z1ASQcLLvRvNK76+S+snM79lUUlbZ8gF+0vGhtr/G1cGDRm+HZ+lZ3n2bZZ1wpVVuGQReFe10nICVdjOd/9vHt1vtiX5+y4Mr+CDlMaikfnS8bq1CRFVRMFcc6Y6/iZ6L9WtzXDP///fseXFgLiGp2Xe0/AjMx7058VJrAwbRNxWdZsEZB+N8W2G8sv54VEWCCrze2gAwZfRXg2UHqVkVIq0Nl7rSZ4RwLnIuGpmBB9a6KTTGEdaNqePUOfpL09mzFa5tXOFzIDnTOn8l32nKMXsvxjBquHp7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nFT0DBLJDhHQCmfPlmiF+vI9RR+0QbQW5j3iyFECK0=;
 b=WsYsPY4C1YKpxdPJkSXncC94EfllqqtvTjtViADrQ50wBfg+mDIFB3ZVwfEk58ZZi/Ng9ZP5nQAKrngqoLFlubjLs8xqr+VsxVIe9ar5TVdpk6b+OcQ9bpCMxpx+mhOUnkwVjtK96eOH6o4CsDVAYKokWfXCoV/LP8YK9PvbflE=
Received: from TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:7c::13)
 by OS7PR01MB12081.jpnprd01.prod.outlook.com (2603:1096:604:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 20:35:07 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c:cafe::f) by TYCP286CA0359.outlook.office365.com
 (2603:1096:405:7c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 20:35:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 20:35:06 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.32])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DF5263000283;
	Tue, 29 Sep 2026 05:35:01 +0900 (JST)
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
Subject: [PATCH net v6 3/5] net: stmmac: Rename double VLAN references to svlan
Date: Mon, 28 Sep 2026 20:34:39 +0000
Message-ID: <20260928203441.34876-4-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|OS7PR01MB12081:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4cf13e90-2ba5-469b-5ad6-08df1d9ffbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|23010399003|376014|82310400026|1800799024|10067099003|5023799004|11063799006|3023799007|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	rpxivvEYADjPJ6n6p/5xzaeFyAfl1qWPdJiwC3Z6nMzLpyHvN6DNl+J+KMTPRII8ejwJtDVGNHRuUEftTLt5pPlxuxwcQbg5S7voX0FPjGufUe0Fk0iKWDv34+Wbn2HAaCPdCwB5IiJfIEDk+MMUq0EIH+m2P488yEEuZoWoMFsB5mrDdMj2fEpHUly5wuTAWMvZOd8KYIrL5aeBLyRB9LeKcWQX2O8bOUrvaxTdML6uuLbW4cy/ciXJu24HuiWHZlpOmK8qSfGL+qglofORolEnh9X5CdvEp+qTtcXO/oJaZwV0x87RyL+Q31PGTbI9PQRPOk9JhqMS15aRfCk+Y+747C/uxqB1fQ6A3qlEsp/mnoWBYARsGCpw/1RtBVkSdgZlrtKuWK+8RDEIYgSrcQRLUlpVou7oFwDCJLWBeOfle7S0FX0vRkKfcjiMEJUVl5jbgFsjO8abtRkhW48X5lqa2bAvm0O+YZnuQw5TT2uJlsLmEO1awKgjf/uLL1PGBZctEPGLDSMZBvh9OlHOFPLFKiff0iBMBLjvpwM1U2NcQ283cO3KUls70RwIBpe6tdR9zfotFKtth9QElOoc+th3Kp3iHHbyZRkuEcKXASl78sTa+GzKSCcZEO1VIobxwDB5qBc08o6bORrOJgiA/P1/O3VQN7kuNSmMBHfxLCxY53R2wXzm4mdhBi3g8rHj74qYLBJxLhLpBwvmFtUI8hiqJMm/0zVFX3z+bXN3vBYqICWYf6Mt6BYLxJeNbbbM
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(5023799004)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3NEZhZp5snIQ1Emb1+9MLLoBdO7fF6o52U6a+2EY/ckYey3os8XPrs+cq9cD2YLFaVFORyShpxi0FjSGHSFDqk9aw19WfvJPygKNebUU8bcYxn93gVLzGddOYcdJCUtcNs/uNBJJprhMnhIHHzMCAo4n+XprkXELTLymAd64J0/ugpZos/SUWjgCjD2DavsMvhKoJ1txFwo1bxJgcidjPQWODwovF3z0AbgTIO++KAHXvnLEC/QKpNdLpr4nVKAuq33fEzYpqlV1szBZCnd5EAm16JBVA9CcOgIEj7KNK+0jeNUcOI+47EZq3yK5BxQujA8k9o+4b+32VWz7/klIua9kif6YCE/htrNqe9jGDXuJTlaewlkfp8TSS0AkYIaXIIT9WE5Pbp8ewxNWfcWfMcdX8akkSDCPdqJmIlnq2VfIz5TJkDRVopUby/ltiZmO
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:35:06.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf13e90-2ba5-469b-5ad6-08df1d9ffbba
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12081

The ESVL and DOVLTC bits control S-VLAN tag processing and have
nothing to do with the double VLAN feature, which only provides a way
to process an additional inner VLAN tag. However, the driver code
that handles them always refers to "double VLAN", which is unrelated
and makes the implementation confusing. The driver does not use any
of the inner VLAN tag features, and the networking core does not
support offloads for the inner tag anyway.

To reduce the confusion regarding S-Tag vs double VLAN handling,
rename double -> svlan.

No functional change intended.

Suggested-by: Joseph Steel <recv.jo@gmail.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v6 changes:
- Rebased on top of latest net.

v5 changes: New patch.

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++----------
 .../stmicro/stmmac/stmmac_selftests.c         | 30 ++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c |  8 ++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index df2126d71c2f..5e2654c91b41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -633,7 +633,7 @@ struct stmmac_est_ops {
 struct stmmac_vlan_ops {
 	/* VLAN */
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 bool is_double);
+				 bool is_svlan);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
 			   struct sk_buff *skb);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..d2d387f45c10 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -344,7 +344,7 @@ struct stmmac_priv {
 	void __iomem *ptpaddr;
 	void __iomem *estaddr;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
-	unsigned int num_double_vlans;
+	unsigned int num_svlans;
 	int sfty_irq;
 	struct stmmac_msi *msi;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 14183f92663a..0d70eb452af7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6835,7 +6835,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 	return crc;
 }
 
-static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
+static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_svlan)
 {
 	u32 crc, hash = 0;
 	u16 vid = 0;
@@ -6849,7 +6849,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 	if (!netif_running(priv->dev))
 		return 0;
 
-	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_double);
+	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_svlan);
 }
 
 /* FIXME: This may need RXC to be running, but it may be called with BH
@@ -6858,8 +6858,8 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned int num_double_vlans;
-	bool is_double = false;
+	unsigned int num_svlans;
+	bool is_svlan = false;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -6867,11 +6867,11 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 		return ret;
 
 	if (be16_to_cpu(proto) == ETH_P_8021AD)
-		is_double = true;
+		is_svlan = true;
 
 	set_bit(vid, priv->active_vlans);
-	num_double_vlans = priv->num_double_vlans + is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans);
+	num_svlans = priv->num_svlans + is_svlan;
+	ret = stmmac_vlan_update(priv, num_svlans);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
 		goto err_pm_put;
@@ -6881,12 +6881,12 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret) {
 			clear_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, priv->num_double_vlans);
+			stmmac_vlan_update(priv, priv->num_svlans);
 			goto err_pm_put;
 		}
 	}
 
-	priv->num_double_vlans = num_double_vlans;
+	priv->num_svlans = num_svlans;
 
 err_pm_put:
 	pm_runtime_put(priv->device);
@@ -6900,8 +6900,8 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned int num_double_vlans;
-	bool is_double = false;
+	unsigned int num_svlans;
+	bool is_svlan = false;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -6909,11 +6909,11 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		return ret;
 
 	if (be16_to_cpu(proto) == ETH_P_8021AD)
-		is_double = true;
+		is_svlan = true;
 
 	clear_bit(vid, priv->active_vlans);
-	num_double_vlans = priv->num_double_vlans - is_double;
-	ret = stmmac_vlan_update(priv, num_double_vlans);
+	num_svlans = priv->num_svlans - is_svlan;
+	ret = stmmac_vlan_update(priv, num_svlans);
 	if (ret) {
 		set_bit(vid, priv->active_vlans);
 		goto del_vlan_error;
@@ -6923,12 +6923,12 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret) {
 			set_bit(vid, priv->active_vlans);
-			stmmac_vlan_update(priv, priv->num_double_vlans);
+			stmmac_vlan_update(priv, priv->num_svlans);
 			goto del_vlan_error;
 		}
 	}
 
-	priv->num_double_vlans = num_double_vlans;
+	priv->num_svlans = num_svlans;
 
 del_vlan_error:
 	pm_runtime_put(priv->device);
@@ -6944,7 +6944,7 @@ static void stmmac_vlan_restore(struct stmmac_priv *priv)
 	if (priv->hw->num_vlan)
 		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
 
-	stmmac_vlan_update(priv, priv->num_double_vlans);
+	stmmac_vlan_update(priv, priv->num_svlans);
 }
 
 static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index c25dc9f89270..c485217ba880 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -243,7 +243,7 @@ struct stmmac_test_priv {
 	int (*func)(struct sk_buff *skb, struct net_device *ndev,
 		    struct packet_type *pt, struct net_device *orig_ndev);
 	bool capture_all;
-	int double_vlan;
+	int svlan;
 	int vlan_id;
 	int ok;
 };
@@ -285,7 +285,7 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
 	}
 
 	ihdr = ip_hdr(skb);
-	if (tpriv->double_vlan)
+	if (tpriv->svlan)
 		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
 
 	if (tpriv->packet->tcp) {
@@ -936,7 +936,7 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 	struct iphdr *ihdr;
 	u16 proto;
 
-	proto = tpriv->double_vlan ? ETH_P_8021AD : ETH_P_8021Q;
+	proto = tpriv->svlan ? ETH_P_8021AD : ETH_P_8021Q;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
@@ -963,7 +963,7 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 	}
 
 	ihdr = ip_hdr(skb);
-	if (tpriv->double_vlan)
+	if (tpriv->svlan)
 		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
 	if (ihdr->protocol != IPPROTO_UDP)
 		goto out;
@@ -1080,7 +1080,7 @@ static int stmmac_test_vlanfilt_perfect(struct stmmac_priv *priv)
 	return ret;
 }
 
-static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
+static int __stmmac_test_svlanfilt(struct stmmac_priv *priv)
 {
 	struct stmmac_packet_attrs attr = { };
 	struct stmmac_test_priv *tpriv;
@@ -1092,7 +1092,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 		return -ENOMEM;
 
 	tpriv->ok = false;
-	tpriv->double_vlan = true;
+	tpriv->svlan = true;
 	init_completion(&tpriv->comp);
 
 	tpriv->pt.type = htons(ETH_P_8021Q);
@@ -1155,15 +1155,15 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	return ret;
 }
 
-static int stmmac_test_dvlanfilt(struct stmmac_priv *priv)
+static int stmmac_test_svlanfilt(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.vlhash)
 		return -EOPNOTSUPP;
 
-	return __stmmac_test_dvlanfilt(priv);
+	return __stmmac_test_svlanfilt(priv);
 }
 
-static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
+static int stmmac_test_svlanfilt_perfect(struct stmmac_priv *priv)
 {
 	int ret, prev_cap = priv->dma_cap.vlhash;
 
@@ -1171,7 +1171,7 @@ static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
 		return -EOPNOTSUPP;
 
 	priv->dma_cap.vlhash = 0;
-	ret = __stmmac_test_dvlanfilt(priv);
+	ret = __stmmac_test_svlanfilt(priv);
 	priv->dma_cap.vlhash = prev_cap;
 
 	return ret;
@@ -1372,7 +1372,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	proto = svlan ? ETH_P_8021AD : ETH_P_8021Q;
 
 	tpriv->ok = false;
-	tpriv->double_vlan = svlan;
+	tpriv->svlan = svlan;
 	init_completion(&tpriv->comp);
 
 	tpriv->pt.type = svlan ? htons(ETH_P_8021Q) : htons(ETH_P_IP);
@@ -1960,11 +1960,11 @@ static const struct stmmac_test {
 		.name = "VLAN Filtering (perf)      ",
 		.fn = stmmac_test_vlanfilt_perfect,
 	}, {
-		.name = "Double VLAN Filter         ",
-		.fn = stmmac_test_dvlanfilt,
+		.name = "SVLAN Filtering            ",
+		.fn = stmmac_test_svlanfilt,
 	}, {
-		.name = "Double VLAN Filter (perf)  ",
-		.fn = stmmac_test_dvlanfilt_perfect,
+		.name = "SVLAN Filtering (perf)     ",
+		.fn = stmmac_test_svlanfilt_perfect,
 	}, {
 		.name = "Flexible RX Parser         ",
 		.fn = stmmac_test_rxp,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index 200b34588c7f..fb9aad748cb3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -162,7 +162,7 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
 }
 
 static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
-			     bool is_double)
+			     bool is_svlan)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
@@ -173,7 +173,7 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 
 	if (hash) {
 		value |= VLAN_VTHM | VLAN_ETV;
-		if (is_double) {
+		if (is_svlan) {
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
 		} else {
@@ -235,7 +235,7 @@ static void vlan_set_hw_mode(struct mac_device_info *hw)
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      bool is_double)
+				      bool is_svlan)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
@@ -251,7 +251,7 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 		value = readl(ioaddr + VLAN_TAG);
 
 		value |= VLAN_VTHM | VLAN_ETV;
-		if (is_double) {
+		if (is_svlan) {
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
 		} else {
-- 
2.34.1

