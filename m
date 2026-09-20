Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873F424D5A;
	Sun, 20 Sep 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789918580; cv=fail; b=UwLomXlXHiFwjMZlatE74qq49le1/Y+95PKVwFA9fRApVpI43EXljeLc0pNKJ/m6KGcQDworbg+0x2ETdSwbB/lvBd/2+CZ+b5KmXzQXmldJhs85P/sGIiNQHENIq1d3wFlj0sIvBL2JKU4MjLTMJOEUHuKvXQKcbm8HNx1y8jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789918580; c=relaxed/simple;
	bh=JkCaPXjNyiU/vBWY6yYEi1fiFA1F6uUgX+GvnZDvVZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbfpoIOZNkCRohM1h3xy+PXofRBzwcOG6ugVw0EoBJ9gam8rMcU6uJ30k17TjWnKyvxXRZTDys4K7KzaLKkO/O7Zn3XRNCTy8aZJd/AR/xykJalES70Hlsm4NkJW3nArNPm9mFwA8QjzFcVoKjiHA+M0jHfP4EIB1EHzWoHeqE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=o0QNLRNu; arc=fail smtp.client-ip=52.101.125.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="o0QNLRNu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnJbH3kvR5foPqnOvhqEBXd78QBUvGtHNrMCXFNvzHFkDKDJMEwHmTr0uWTcqUguGJilHDzy6hj/ojZAmPWGqqjlbhC8dBNQ8prFI7u6Ci09FoN6ftPManzp6NBdnx2YyjD33EPt7ncLvUe9pLuiDxzhFtyZbujXA0TzwOcCI6UX/VgPyXAWg7zEHcNEjvTsoqY07TQifGictURn0SY4bAn5BTbP203RlQR+tvtqqythnymE9xkp+HIgyaSulINpm0eTTRp46i9rfoLbRK8P4SNMCGvxvDFEWmBd7SwLubXn6fMNCDocganW00qGCmZu4345JpURIS8gA99IixxF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b70k04A9dwNfyhrzLu7MGL7XNkk9LD4ScoyZx01gnbo=;
 b=MpLQk60k9DNmrhf8FT8dT5eAeOD284BHrO3gM7VHnZXPzKY+AfSg6w8GHzKKgE4A1NJPqtzoPVSNJBXSAhn/DAXH62IKuyf45BSYXEzFiCFE4mQVPjmE3Hg7Itg0mb6oDdMubVAIV4AAmR4fbc0pAuUO6W/XiosDkwp3eyqXqjQgdLlqZzAOdTnDWN+CGXvCairreeqUbmdO31kVQsAQ7eQngM4P5+b/Y1JpQkVwXL/iSuv3jazQ0lBo1BdNM0LTmIG18q0HucyuXcJxcSTL5p6tR3U1BzXkS669EFfWkUdBh0aehnZJuPGhL1tYvA+9BWMDShF7SRIIhqCBg6o/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b70k04A9dwNfyhrzLu7MGL7XNkk9LD4ScoyZx01gnbo=;
 b=o0QNLRNuXNZawsSUPQWFSu1+UZXHDjKd2GNy5rB93RLWrUaSmQ4uVDWjpmHCLLiUFIuJgxuIsVrHisao+APrWKkZG7RSag8fHxR4luY10LbKO7g5n903j2y4LM29Vb/0/vXpFCpaQC4l8FnAkkcMkrygJf2T1gNkoSjKFqJguNo=
Received: from TY4P286CA0111.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::6)
 by TY4PR01MB13839.jpnprd01.prod.outlook.com (2603:1096:405:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:36:12 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::2c) by TY4P286CA0111.outlook.office365.com
 (2603:1096:405:380::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Sun,
 20 Sep 2026 15:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Sun, 20 Sep 2026 15:36:11 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.22])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C9D8730000BA;
	Mon, 21 Sep 2026 00:36:05 +0900 (JST)
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
Subject: [PATCH net v5 3/5] net: stmmac: Rename double VLAN references to svlan
Date: Sun, 20 Sep 2026 15:35:14 +0000
Message-ID: <20260920153516.103461-4-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TY4PR01MB13839:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2890d21a-99d1-480d-8a2e-08df172ce5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|5023799004|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	S+L3ZHRK4dToiXXvXZHDGc9bhbPDWxzMNyJOEy5Vf1Nbhk1agNBWuJ9MYhDHZ850MZSFXe7BQNvekSK2S+VYYHyklGuoBLK7dzhqa5/2HGxERj9xQbt+2N4X7rIZvuD/NF347pV3HVmU1USp/7ZJ6vyDJTWfD+JDYTFQ6sfgcYbvTUqOTnKAX3nzFIOhHtg3xbNsIsj4IvQdyZPrdyQL+PJDhpe1X9u2kdfmMP0OA06e4Cq4+0M49AkBnEVSva6PYEaI3kOLlJWhN18w9cmXU3GwQCwg6dcN9owHV2bNIbScXT++8vaICC5zHooesPqN+AkIvcRab0dqol4PoM1MJ81B7GwQ5euBC2Ilqy8niCaTwceHrCW/mU/vULvUSuG2V8gayBIsPWQuBdQ4ICs6gyDu9nZH41helYehGy5DWAo5vQQ2WYaJA6LW/lMl+x7IhoUN78wlfdfbjXMOCs8FtMfd5Cn7edCMqGLMy5onu9BW2SMn7bXf/uPp9cDo5OWXj/91D1ozf1OAblizKs6WF4TYm/qaNGl8IIKdF4JK2w8MIsfgzqYoEJwN1v+a5B2HoeIPExMinr62T58LnWJppsZBJ8uAZ/1tPgPTrwAhMHSq4KPyLuqh6Snj7OPMpY8H00lkyvG684Jx5UgCYWF89DjKh4Zap4OI6XZGFHTrSwC8Vcy5ChGWlvcMByazIVfgGx2des0FQWWDADsbsu1urz7qIWUgwF0GYAoWqYrJOZvd3r8zKdHv0LYHRLp2VNZV
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A7M4ZTr+DmvywDVEfo/1RZJUth0apUrWo0BurVfyMJr8cYDZa1QTVkBfEYwMgwctgVEy5+yTh/URywravLJfoRVNG+MQmVBDZAu3/EyUcNAXv0naXUrBZYKJFUxicH5cTYPiFrfmPDE2pHNRpg9IxOBRk6ne2zIbDPlwwBu/YouY8gSbz45WpmM94RlFKJ8xLxHphsnzUN+zvI6m9/Ri7ip5999SPvTkAnwyUrsgQQ6mzr8CKWKtXoAy/zGFgwXmhn0VN4oQUKvyNLIG46mkRlZa+a5FZA0EOKokWpGp2h8Q0AQuEd8qpKrAlURn/aYqZRkHpyqRiLcTOLgEdmNRlLaZtc2Sgf82mv6jlC2mgkt7BL/Ep4RZu9kbSWmwR7qXGZDDchTlb4wXmlNvmU8/ACXNY5B+FzthHwe6O+ZjEX7W9EKTZNIA4Wjd1AA9lfhP
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:36:11.0726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2890d21a-99d1-480d-8a2e-08df172ce5cb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13839

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
v5 changes: New patch.

 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++----------
 .../stmicro/stmmac/stmmac_selftests.c         | 30 ++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c |  8 ++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 734e30caea81..a8ddbedec9ca 100644
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
index d0643a30db1c..77a8bcf5bf14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6832,7 +6832,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 	return crc;
 }
 
-static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
+static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_svlan)
 {
 	u32 crc, hash = 0;
 	u16 vid = 0;
@@ -6846,7 +6846,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 	if (!netif_running(priv->dev))
 		return 0;
 
-	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_double);
+	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_svlan);
 }
 
 /* FIXME: This may need RXC to be running, but it may be called with BH
@@ -6855,8 +6855,8 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned int num_double_vlans;
-	bool is_double = false;
+	unsigned int num_svlans;
+	bool is_svlan = false;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -6864,11 +6864,11 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
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
@@ -6878,12 +6878,12 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
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
@@ -6897,8 +6897,8 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned int num_double_vlans;
-	bool is_double = false;
+	unsigned int num_svlans;
+	bool is_svlan = false;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -6906,11 +6906,11 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
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
@@ -6920,12 +6920,12 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
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
@@ -6941,7 +6941,7 @@ static void stmmac_vlan_restore(struct stmmac_priv *priv)
 	if (priv->hw->num_vlan)
 		stmmac_restore_hw_vlan_rx_fltr(priv, priv->dev, priv->hw);
 
-	stmmac_vlan_update(priv, priv->num_double_vlans);
+	stmmac_vlan_update(priv, priv->num_svlans);
 }
 
 static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6372ec7c3f31..b710eb99b1e7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -237,7 +237,7 @@ struct stmmac_test_priv {
 	struct stmmac_packet_attrs *packet;
 	struct packet_type pt;
 	struct completion comp;
-	int double_vlan;
+	int svlan;
 	int vlan_id;
 	int ok;
 };
@@ -279,7 +279,7 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
 	}
 
 	ihdr = ip_hdr(skb);
-	if (tpriv->double_vlan)
+	if (tpriv->svlan)
 		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
 
 	if (tpriv->packet->tcp) {
@@ -855,7 +855,7 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 	struct iphdr *ihdr;
 	u16 proto;
 
-	proto = tpriv->double_vlan ? ETH_P_8021AD : ETH_P_8021Q;
+	proto = tpriv->svlan ? ETH_P_8021AD : ETH_P_8021Q;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
@@ -881,7 +881,7 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 		goto out;
 
 	ihdr = ip_hdr(skb);
-	if (tpriv->double_vlan)
+	if (tpriv->svlan)
 		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
 	if (ihdr->protocol != IPPROTO_UDP)
 		goto out;
@@ -995,7 +995,7 @@ static int stmmac_test_vlanfilt_perfect(struct stmmac_priv *priv)
 	return ret;
 }
 
-static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
+static int __stmmac_test_svlanfilt(struct stmmac_priv *priv)
 {
 	struct stmmac_packet_attrs attr = { };
 	struct stmmac_test_priv *tpriv;
@@ -1007,7 +1007,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 		return -ENOMEM;
 
 	tpriv->ok = false;
-	tpriv->double_vlan = true;
+	tpriv->svlan = true;
 	init_completion(&tpriv->comp);
 
 	tpriv->pt.type = htons(ETH_P_8021Q);
@@ -1067,15 +1067,15 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
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
 
@@ -1083,7 +1083,7 @@ static int stmmac_test_dvlanfilt_perfect(struct stmmac_priv *priv)
 		return -EOPNOTSUPP;
 
 	priv->dma_cap.vlhash = 0;
-	ret = __stmmac_test_dvlanfilt(priv);
+	ret = __stmmac_test_svlanfilt(priv);
 	priv->dma_cap.vlhash = prev_cap;
 
 	return ret;
@@ -1284,7 +1284,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	proto = svlan ? ETH_P_8021AD : ETH_P_8021Q;
 
 	tpriv->ok = false;
-	tpriv->double_vlan = svlan;
+	tpriv->svlan = svlan;
 	init_completion(&tpriv->comp);
 
 	tpriv->pt.type = svlan ? htons(ETH_P_8021Q) : htons(ETH_P_IP);
@@ -1867,11 +1867,11 @@ static const struct stmmac_test {
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

