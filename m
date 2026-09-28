Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1702383C86;
	Mon, 28 Sep 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627708; cv=fail; b=ni7/UCIArWQLq6m7pmp4J7870uhDGXQqM8Ic++nnHO4+BYq2fc4JkwrRIXzRFfS0J4ULAfSAT6Q4F9Asy/xNyxFTsrIHhl8J+a6srtj1i2sHS8osdqwz/y5BFtY+0aOPKDuW1bEU5SQXls5Y4gNfoh1TKgzB3rrFDMNpR52k5Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627708; c=relaxed/simple;
	bh=tXwux0TLjUfe1Nz+Bd6LV79X1LQG0Qda3JBU1SIMTUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G92FyvDW4PmA00TJhEvzoWzH1CnetIiKjX3IyE4P6P6MFBsgG0qu1fprfnvHEKX0Ewj12gnMNWUoLsR8DHVDCcEHRiR3AKqyHBOW/VN1o+hK1OnQMxQfbm8hx8Pi5x3046dAxVToVAtoVPHz46JBbMrtuJDgWSgL5ZuUkzT0LLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ffYmWk/P; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ffYmWk/P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXtb7mIGT79WrM8r/OPdq15imOa5clwuWMD6L31wLgSbrz5lrGGs5FtTiDYLjh9j6y8GdpC3qdo91TJ0rz/cXVu88xba2ZbD4SAhJ0DANu22nBZ74rZNMa1Ybxg2XikTrc77NJkmBKLjOY4Q3u+DAPstnG/ijrEzyMxz4whn36Vv3rLslo9ilpVU8GiFZjzZLufX0qr14Q2/8pJsD+KZnUz7B9JU4osqZqxsqZnSzlGJTJ/176sRY/aaoP0ExcWrlyO1hlGiVT1tHsNz5x8+5dTUkIqBvaG7E+8At0Q7P58ONZyI8d5JWojN62BIhydI2LUsVYJBiWpt3H00k3+ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ytYgiWgHE3z1T5efokgqdDZk5bsTjqsju+xVV+zdM4=;
 b=BZspbCtqttFS352aIzS4Gq0oi+WcjFSj4qTcJwXTMVOsgMzOSNvxUU6R96LKsBvzuZzjFvaIM1O1+tKPPey62B83D+L52xkOGSvidxxqd7nEofOGeeu7CVcbQyEx7Is/ocj3OwL/+YKGV379mvRrjsKCM+JxHULhkvnUNLlrGvfj/Z3ZILOiU6RBOYms94fofyJgoZhBJ8qfpM+aOwjWM6tsXeda6qYaVLo34OVW6pvb2TTekGfcWgX6hhjTHQPExwc53uVdiySRMIZ0O+SVjGo/GgvQbaLZXS8bJmp3cu61rz6aQI75pquphYe9StWI5OGeUGGXnPKG1bfeAIuI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ytYgiWgHE3z1T5efokgqdDZk5bsTjqsju+xVV+zdM4=;
 b=ffYmWk/PK2jyCnTcFdrloRq4cJ/qaKsT551+dM5vRjo2ZPceIZL9k0wNwGk1sg3vP0ubSlCdgR5Z90AXvXdiS/OlERwGSJjwZb1rEZBR2n51+gBjfRHfXNbGDdoxPIqrQOOyJSxlKj8LqgXfA0eKHewh8VbQlqCMbggoaseWyKU=
Received: from TYCP286CA0355.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:7c::12)
 by TYRPR01MB14274.jpnprd01.prod.outlook.com (2603:1096:405:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 20:35:02 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c:cafe::75) by TYCP286CA0355.outlook.office365.com
 (2603:1096:405:7c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 20:35:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 20:35:01 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.32])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 59BB4300026E;
	Tue, 29 Sep 2026 05:34:56 +0900 (JST)
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
Subject: [PATCH net v6 2/5] net: stmmac: Stop toggling the EDVLP bit
Date: Mon, 28 Sep 2026 20:34:38 +0000
Message-ID: <20260928203441.34876-3-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TYRPR01MB14274:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e51c638c-b228-44ad-28f1-08df1d9ff86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|23010399003|1800799024|10067099003|921020|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vNCvxuC8YjfObrjJJtx1vMMirD5nmJHWJ8PG9iE5l7T06KEgl5hYoH+kJ1Pyvd7cDW1vSTdG8j4K3NVzTqISC4cCWrLptvgqCswmYqPzNgkRlFR/hPOpnWPYApiLyhIn8opSTEIv80B5ffI6di0xA95jouuwhyA2B7WYWtQNqRLvnyeMg4E3Jj/pDrcZUbQL03lRbELEiExQw3VOe6NyDFDdplXiP2TXbCTMmiBsWEVA43KVsl0yWEWFzrdoCraJLSBubQ5DPbI/M+Appyi1BHBwISK2V+o+/t0Yz9GxAG2zjEnnr5KwK0qWxKNR4JavMrwakeGYPzfllf/ID1FZIxfsROJuHtfCgCO9xKX8/Da45XkIIGj5JpfCYAXSuHbo/jSxxgLyIBNvw6PjiQ8o74/Sr2/l4LMig3HdGybwxJwvN2scw0ez6toTCINPf9BGWyf4YjLE0PennmhD1DDMhbmD3kkazQ0OjK84KURAxe0oz/1Ndt70ZihYxpoMbXBQSkOChkgzlH3QSLfhQA2Uqs44FOhzk6Piso8T5nqTQIiTn6zNJS6aJbcHjFD84lQ0npvsupNkzKKH17jZG8PErkBrFB5h7QORVpJFsefVvHci71Q0xLLYiQEgmoPGp/fYBIdSNF6XvLtNeOMZ1r90FZlpCv00OIqp+xTvPkh+Oo27IhZyDcRWMRf9qdt0Tlb7nrPkYjr7Xb0QPoWvNumr9VBa73H8VgNR3DA/XWNJPHHPCjdM0YdU694nGWi83704
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(921020)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NHPt0nEF+KK1KqwIrA6W/Uqqsw5wGkSxcCuRF/1QYWDn0ICdD23iwL4qBoHlC6ZPfDfZSMJE81X//yqzWDaTCoV9fNQiRqX+iM0f2hNNh95g1DD0keyza9pDDA/xCA29nNlEqBLZSnWZr/nU0w8b6nDBbU22nx974PMK+rD+d2cnaO5lMiTTxhowRjkI47gr+ZgPxge76z2wzzSTVti93cMFonmMduigfojkhdoa0LDziG5wlca/qjWnSNifWUDWWIL3nzK7xcIIUIBmVakNeYSsuQOxfddIB9VssI9A1TD3txM+Kiv5DMScVbzYBSKPjilQBWMZCVcda/yOCdLQKc7EA1qmEECmkz8B4tUjx4TPJ6uM17uO6lSWfHgGbEIwABbKSAPat/MJDButtaMYOVaTcAgXsurcARqSXHKuqQvwcLA3UuvWs2dAlBsixyqJ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:35:01.4251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51c638c-b228-44ad-28f1-08df1d9ff86c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14274

Currently, the double VLAN EDVLP bit is toggled whenever an 802.1ad VLAN
is registered. This bit enables processing of the inner VLAN tag, which
is completely unrelated to S-Tag VLAN handling.

Move EDVLP handling into vlan_set_hw_mode() instead, and keep it always
enabled, so that COE can work for packets with an inner VLAN header.
Add a dedicated callback for dwxlgmac2, as it doesn't implement the
set_hw_vlan_mode callback, like the other cores.

Suggested-by: Joseph Steel <recv.jo@gmail.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v6 changes: None.

v5 changes: None.

v4 changes:
- New patch.

 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index 983a90cb9767..200b34588c7f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -174,19 +174,16 @@ static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
 	if (hash) {
 		value |= VLAN_VTHM | VLAN_ETV;
 		if (is_double) {
-			value |= VLAN_EDVLP;
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
 		} else {
-			value &= ~VLAN_EDVLP;
 			value &= ~VLAN_ESVL;
 			value &= ~VLAN_DOVLTC;
 		}
 
 		writel(value, ioaddr + VLAN_TAG);
 	} else {
-		value &= ~(VLAN_VTHM | VLAN_ETV);
-		value &= ~(VLAN_EDVLP | VLAN_ESVL);
+		value &= ~(VLAN_VTHM | VLAN_ETV | VLAN_ESVL);
 		value &= ~VLAN_DOVLTC;
 		value &= ~VLAN_VID;
 
@@ -222,6 +219,7 @@ static void vlan_set_hw_mode(struct mac_device_info *hw)
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + VLAN_TAG);
 
+	value |= VLAN_EDVLP;
 	value &= ~VLAN_TAG_CTRL_EVLS_MASK;
 
 	if (hw->hw_vlan_en)
@@ -254,11 +252,9 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		value |= VLAN_VTHM | VLAN_ETV;
 		if (is_double) {
-			value |= VLAN_EDVLP;
 			value |= VLAN_ESVL;
 			value |= VLAN_DOVLTC;
 		} else {
-			value &= ~VLAN_EDVLP;
 			value &= ~VLAN_ESVL;
 			value &= ~VLAN_DOVLTC;
 		}
@@ -274,8 +270,7 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 
 		value = readl(ioaddr + VLAN_TAG);
 
-		value &= ~(VLAN_VTHM | VLAN_ETV);
-		value &= ~(VLAN_EDVLP | VLAN_ESVL);
+		value &= ~(VLAN_VTHM | VLAN_ETV | VLAN_ESVL);
 		value &= ~VLAN_DOVLTC;
 		value &= ~VLAN_VID;
 
@@ -283,6 +278,14 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
 	}
 }
 
+static void dwxlgmac2_set_hw_vlan_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + VLAN_TAG);
+
+	writel(value | VLAN_EDVLP, ioaddr + VLAN_TAG);
+}
+
 const struct stmmac_vlan_ops dwmac_vlan_ops = {
 	.update_vlan_hash = vlan_update_hash,
 	.enable_vlan = vlan_enable,
@@ -296,6 +299,7 @@ const struct stmmac_vlan_ops dwmac_vlan_ops = {
 const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
 	.update_vlan_hash = dwxgmac2_update_vlan_hash,
 	.enable_vlan = vlan_enable,
+	.set_hw_vlan_mode = dwxlgmac2_set_hw_vlan_mode,
 };
 
 const struct stmmac_vlan_ops dwxgmac210_vlan_ops = {
-- 
2.34.1

