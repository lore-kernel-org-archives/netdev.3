Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010015.outbound.protection.outlook.com [52.101.229.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653C417D99;
	Mon, 28 Sep 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627718; cv=fail; b=r+awJUf8TS8+ySHRAhduPK9LY3Ou73Ei44edsWAO5ziM+PKhMM4NgKryFQFyifCJ1GuBO9YYi7RCs3OXzobe1oPd3SVjTgxBa/DiMq2/uLeRNOaJI4YbylpVD238aIxLjwFJBQiPXBVHFkjmNK9pIKjOL+IdsPwZ9yEO/7YRqQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627718; c=relaxed/simple;
	bh=jEi7RJsnVlljjdBIM5adYNMTjTvhFQlafPfRMLol/yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQTh3vxEHRVu2+WLPREihldPTlKPHsfSeXVugohDs400i5y4wNKId8/IDVAkmgBKIRNaWWupuuHOTAMueYbPBsHkssS7YtFACtpbzTx7M1uLWFMIIada2dOsb0lwieZ0PLpdkRkEPqSG+tM35wEDIm31OPY+0vpN3SHFAUGDUAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SoV9Dlap; arc=fail smtp.client-ip=52.101.229.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SoV9Dlap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY6xm1UHR1sSuaL4gCcbnh6rnuCTS8YD7pn342bI1uQrInhXU5RhK0yOxAjfOG9nhD58DM/ykUDt6d/0oW21eeR89aRmliTWeHXT1C5akb75CoUrIuAS/EVHPDU6SXG3CRhneuW8H8e0Y+zgGsRlPWfaVithmTxFWWDDH+LIcFtjhPNhODmHQVumhuQ8M3I9snvfJrkrtyKIfNnFXZHT+0DX5pqrMZqeKSaYU5t54ycNMvWU0bZdP8Ni5Q4u5INEYvXNj1+vYYDslPZJ6a0xpGFza4qyURWlicrlYicmTLkho5qbOUsy31OFBkOE0lKeK+MO0iusrM3JVenVsmkGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eC7mYWZR3kjcDafaY8YbjVAqmNKeoYmXMjreD23fT8=;
 b=jeYBjoC5QESd5pt4c78u7HWDPKyFFyJf7JcqqCVCkfJ1AtSmh05cPTdFAUxJTQHemQih/2GsvVxz+pcivH5S5wr4UPuIR/QPrn/GWG3sjlxcfMArmOAvfsynwX//16Vx8AWKAc3klE6tBL9gh4G5zaRoe/3mRZ/hkknVrmznHzf5QEk4U0njbKcbCxI936VAY/AJztct3adb5eBIL6hCE+pM2ZkRAgc0W3kpRglWInMpLKwDP9EHdGcgqalZAl2x31MSr9iIMezJdVNMcURh8hSRA32arr1MNf9IY7skKuVL3G82PmS11v5Wesgo8n6UpA4l+cMZgH91sGCSq9WxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eC7mYWZR3kjcDafaY8YbjVAqmNKeoYmXMjreD23fT8=;
 b=SoV9Dlap0fDJH4KE4G65op2yMWWhmWB+Bp4mTJxgH7xuB7QTIRYsqG7PCwv5eGcaHevDe4/Ah5u6ZPwOhmCRZPzRyySZV4FlLO6uNRgnekk9iEjnKtutFpK+OznYtCh8RvSyYKtbg/xhfRyVNcsVjNp90qypKC0tG6M0EJQII9I=
Received: from OS3P286CA0121.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f7::16)
 by OSCPR01MB15940.jpnprd01.prod.outlook.com (2603:1096:604:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 20:35:13 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7:cafe::64) by OS3P286CA0121.outlook.office365.com
 (2603:1096:604:1f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 20:35:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 28 Sep 2026 20:35:12 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.32])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6EE8A300027B;
	Tue, 29 Sep 2026 05:35:07 +0900 (JST)
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
Subject: [PATCH net v6 4/5] net: stmmac: Do not advertise S-VLAN stripping when it is disabled
Date: Mon, 28 Sep 2026 20:34:40 +0000
Message-ID: <20260928203441.34876-5-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|OSCPR01MB15940:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 33c81fe6-1852-4e9c-f10a-08df1d9fff0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	HBq+VIoa9t3rNHb92pf+fRRSF36KtXySV2J3iCwJtll6QijPMnD7YHETLsQUUKGa7h1vnLsP1V75cYjuD6QBwkK5tqrV/XOzakmu5bNbD+PNvLNQd3E9k6jnvg+eOuHJyvdQIx7IT2lR4IEdMlYK4Pcm7jE9819ZWrpZGF/83N1jDPmVWtewW5Gv4FWOrKI9MIq6+XL423mPkrh8sK9Nc74rP8wC+nHPdPI63fz5sSlIvGVUndrk1kRj+6zBcPQ6Zg5lBJBLyBP4rdegdAzgWyHHmDH5+WH05HWF2TNC3Hla1rOmyTL7mCzmVUwrowAbRqWlGYh5eyRK1r6skC0d8+FjoOVGBxwEIsri/JUk3A4QYCj431DraU+vOYod9GtOGJDTqsN6SEZNl415e3qK89p7YzG0jBoyhtgSOkdNRc0K1E5I3OsNamn6PNnuQbceZNNA3LwXdv3VNfi5fOg1vpm+vsRswQezg3fZ67bNpEd7tL7ufoa9AVX9jgVE75LGZiutODyzbAGUm1Bij2F2ExUY+OwDHHflKFmNnq95D5ECAkIUimhgaMOy40c4NDJImWZExXCl1C2qzfOJXpRJtGv9/UgkeYGP0q4c4yzSVXab4kKQsu6ti53FAycPc/g+BFohIJ5F0UuBMuNL2hyPVjXRAFJBNv0Ikfmngm9ets+Jugwob+67tc1MRGeY8BEone6Y+kEQC0sUstPlgu+EbQE5HujXNqTbHJX6vmL2cl70Ajq4pz4oofF6hrIU1mZ5
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LTo+BR/j8j5VQVihyiBJp/q1eOcCk5MJTAgC93D1/5RnrvONAclHuzXs9rA7xPjFcYUMiCJt3GmEa58ODqeJ0GKkL3cWMcSxjH5VEZhqf9uWDDY3B35Vjvknnie7CtoboY0McsQ6iwMg5AYhhDCuHj3YcVkl0uujucFlF6b9FQRf00SIrDyXaKMyXOQt6jMYphmg0iPLqTCqQSOQnAgq4Q6uFWuaS/Otfn8QPNOKtBVMoMvMTsfpSInCuozAHMzrg3vtanJW4xLb3WGutJ78gD5Ne05krbKoD/bIcizgy8e+QZoitlCdVBehmRMHe4mtcWGqdHYkWSz8dwk8jdDSIYfqz1OhtUhjevc0gmNmQUW8MgnWKy65sGjQo6xgyzdbIXjygYEKEdaBmKC2+v6tjSurZuI79+i6vSfzbRP9gM1NMRTWQ1nooKSAh+1QqgiL
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:35:12.5498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c81fe6-1852-4e9c-f10a-08df1d9fff0f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15940

C-VLAN and S-VLAN tag stripping are both controlled by the EVLS bit,
so disabling rx-vlan-offload also disables S-VLAN tag stripping.
However, rx-vlan-stag-hw-parse keeps being advertised as enabled:

root@rzv2h-evk:~# ethtool -K end1 rx-vlan-offload off
root@rzv2h-evk:~# ethtool -k end1 | grep -i vlan
rx-vlan-offload: off
tx-vlan-offload: off [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: on [fixed]
rx-vlan-stag-filter: on [fixed]

Fix this inconsistency by making NETIF_F_HW_VLAN_STAG_RX follow
NETIF_F_HW_VLAN_CTAG_RX.

Fixes: 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN stripping")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
v6 changes: None.

v5 changes:
- Rebased on top of the rename patch: used dwmac_is_xmac() instead of
  the dropped hw_svlan_en flag.

v4 changes:
- New patch.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0d70eb452af7..b007ff120471 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6211,6 +6211,13 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
 		features &= ~NETIF_F_CSUM_MASK;
 
+	if (dwmac_is_xmac(priv->plat->core_type)) {
+		if (features & NETIF_F_HW_VLAN_CTAG_RX)
+			features |= NETIF_F_HW_VLAN_STAG_RX;
+		else
+			features &= ~NETIF_F_HW_VLAN_STAG_RX;
+	}
+
 	return features;
 }
 
-- 
2.34.1

