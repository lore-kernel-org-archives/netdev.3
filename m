Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2105.outbound.protection.partner.outlook.cn [139.219.17.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115438F227;
	Wed, 10 Jun 2026 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078327; cv=fail; b=jI87QenZvnQ1pF3Z/6QoFUspDkYl2d/vIpdo6hiULh3qgA0ETp62YfdWm/FIviJpzVntpH41L5ypmfTFpLdHgc4rQefPnhoywFQ/NGQ4PUc/EFsffIGxq0MoESOv1utYlRkREhYxfwPx9CJEE/+HEq6Rvf9AmaH/FyISGftNN70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078327; c=relaxed/simple;
	bh=vy2BjERrMhUrv4OQ4t1wYFr/mylS+dEtYiAuxwhDfV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biydzIswlWNqEp5BwzXs1b4TLBe/2isJPJ2CtnH4CkO4TdB9yTCtT+1MbYw61c/8+zxga7yRwCnBbyLaw8oKenebLOK0GVgE9dvTdq1B25BQSyS+aQ5oe/QRiP34eMH7CgxqUPISpsay4vcStbV5woIYZlARXCitYUCq+U/ikKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAD/92d50mV1OdE4YxhyBke1uc61jMgNeCmdlDyZcpJ3/XcQh1gwT9lvD6LNv3AwuwVygkXo8WuN2NwECZTtpE2e88THme6RD08gW92BiWL4upSeKF/i3r4kv9jM11v5O8RD37D6oSWLWGoK31WGPCG8CTv0d/IaneMfdYT3o/rckDhiCpi4X36dCOZh7nTp9vJtTnWnx2FtquWxpwk5aphiSJI47TJS50WjGaaZBrSNf0MJVAb8ZEs/eDgSbOfU8LQEXkHpd+18vkCWVKdZerRdSTz0LDlCPdAbyrLCxYNK5HFraRgA/xpCQUNO0ksTolrbQR/jnLkWxKcrMJhhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksk7bStHDiq8xnZuf+4ghVRpXLCH0CmS9w4llQPfwPY=;
 b=i9WN02zKnubiNEvaHKYZjBAr4kf4ZpAVS2srMaWmgTkYOA/ku2KkRo0H5W9PRf/QjRpIDDpT8H1TCT3+9Yns8pytjG/7fXrcVuPqNXjOglTUx8IienXAZ6hTGRvysIqZT4/bT62Z+G6wOQ0B7h2dlfRCQtC0vQsy+shzpAyoOKk/Bl3/P3OiHsqh/oo1TYtRi0sfN2vzY7XGvo2rcOCCeRZ0hdVYgzlCIPqp/rhaku1zV37vxnguJlUSNCpIv6V5ouLmYp28/664gKzQgxPSHGs/wUoy0K3+q+X/fnTwkoyTb+oYo/NKWtg5w/aad0OgpxbgMakR2XdFDP1EAXAs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:24:34 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.21.0092.014; Wed, 10 Jun 2026 07:24:34 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 6/6] net: stmmac: ethtool: Do NOT call phylink function in NCSI mode.
Date: Wed, 10 Jun 2026 15:24:20 +0800
Message-Id: <20260610072420.64699-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610072420.64699-1-minda.chen@starfivetech.com>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0512:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d854180-664e-4d72-6d4f-08dec6c15226
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|38350700014|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
 ylQpXBJfA6dTbEe91BFp+UV1i36B/rIk7Rh9G7uycru+nYm4vDltPgrqu0+IPDFGqitpMkNnKS24ngrIEctyttrCcxu+/iHe/5msKR5yj4n8uAaIf/3l92mahd11YO7t1RL4q2/AHy4DlSpJzj0rMJjUQd/3Rh4Qk0nrzdMeZN6zaQ4TUL5oZN9Fqy2Gk0O9erZ3qbrtCZ/L4baTOtt/lAhaTeCsuojjP6Xg7cc+8rj2qwfixX8wcSgSqga5+n7LlX8zzT/Waer/gn1K76toBRhl0ZHJhNrlkGwCV9tzgUN2PYQuE3yudPXaEMeY3Rm42JCIF4L1pQM/8JfnD2QfL6rYPurqs6J6OjV05Ur37yoFju40mA7b7G26kY0zpj2hl1GeT3l+LsdzjNhgI86M1zPMwV5VuyBhNeGFKNUlMJXqVT7QJvpuKaO52TB8phNa9nz9vsJwoVEEcch7J4TB+iautHy6HYkzqc+XcxWURn/miviNHWBFtxAN/d6mYouNCq/fzZvs/yizPbKlKTgTge3CQ3254zVTKCB6h4swmYWo2SGN4SxHOoceke0ok/Ys5MKTkMx1as0PznLmrhyOLA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?irR4uNGnTyo+d2RV8snzIUga6j00ZuJXgUTu4Yz+i3WjOz32pHQWL09iT4UT?=
 =?us-ascii?Q?YwKLdFcnkAmZ6hXdj0LU+RUGX4EmMJK9KZqzKutS0d3Qp9t8f2hLvssbTbCA?=
 =?us-ascii?Q?7wI5DOioq29roIF5puO+juD5Uz2UpUz3Y8bMhzuzZ1EhidCc8CUN7RfGrRWp?=
 =?us-ascii?Q?9nD3hu7YBZITLK5qOl+DoGtMsoVwdpHdZpTaWeCYSgbZd0l5jwYQBMQUrhWK?=
 =?us-ascii?Q?Qt5JCnqpEUEad/I5SZtfuS0cmdx8EGMU6Swo3S0E6XXo2+HEuuYPni4ngG+N?=
 =?us-ascii?Q?8jD37fAKLYzzs0Lh6e27yIQlMpoU4escFVf9Ed+vJdHkbITmcwwFc1CO8VY5?=
 =?us-ascii?Q?8j3RiASW34lJiS90O6Xrgrm5hHQS7fjirKU6R+2X0bn2YDBkUckMd2lR0cP6?=
 =?us-ascii?Q?h3PmjlHX+Y9imqJsSqU1uGOR1bP4e2lFxIFciCM84rNxZTsIMcjukDVktcvJ?=
 =?us-ascii?Q?ZmOulnrz/o7MpKvqRXD31WMxqLEaWQorzzVwYNCX9g/TSB5DjIzTt1s/3RqC?=
 =?us-ascii?Q?kmF/It2RDf9/OfwL735MQHqMpvrPtz/HVZq08jO4cyxlYQ509GfpPpGL9kyC?=
 =?us-ascii?Q?DlP4YeFoBJLQI9I7K8REjejm7qIvpxf2BsH6a5RKdYAt9icNcyqMIWAMkfXg?=
 =?us-ascii?Q?L/0vc/B5HrVArsrfAVYT7qnySz4Rb+Ral9Wj39IYBGYJoqy0wi1TudhGwOEV?=
 =?us-ascii?Q?81lZKaQNEL2q/+rlEqxOiWDxRYhzJ6zhEiK9En4/C1FZ90CQa50pcuVyGg1g?=
 =?us-ascii?Q?Bkkvm0CCXzJJykb1gi1VVojtcngV3o4WJmfwTQjXeh6e2ykitVLdNPqCzPRX?=
 =?us-ascii?Q?yNiQSOKe71BBVewZG/mqIYmZSVqyi6ZAG7fmCcCrOlXmUhx4EK9RHpOnlzEH?=
 =?us-ascii?Q?YFvdv/O6P+UqmAxY5mGUMvWXNKO3YkvVn7geiBBDjaSb1Ww92tJRfMiN4ZG6?=
 =?us-ascii?Q?pSHtoYLneDg1mA0DWzisVJCQ5/huhagH6GwBjuUFEpEKXpugsThn+uk18xXh?=
 =?us-ascii?Q?si+Kkd6jo+yzu/fTL7zLZnEXKGrNkYT0tY0RqrAA2o0Zt1pS7LN62UQ+dSEb?=
 =?us-ascii?Q?mkxBv0YKrPmF5h0J7FUhCQtMgSpZOm3P1CwL8jQSC2Ebv8gtw0J4GgI8q3/0?=
 =?us-ascii?Q?ym+HL92FwOjEOIPITYFRPQBG/cVT27VuSD8JgyBExeWvagzBKdfrUF+8Azhf?=
 =?us-ascii?Q?OV0RzCM/qprOLeB/F4L8ZxBYGELucYlf8+9tPYcR92jNvAdC21819/7hbcz4?=
 =?us-ascii?Q?Oly/z4A7J+XMR27cHv3jH6SXD2llcYpEUzk/Fd5SOxlnQk73B4sq0rhLZ6c8?=
 =?us-ascii?Q?byClBIB+OIM0+5azXVGmlcrX10FShR+ltT3mp3ZJ2zpfNefQcQeAWtQxTrlL?=
 =?us-ascii?Q?x4bIeppgsAxK8fGK5jj8JOCOHKR4Z8vvSZTCXnj1ujkQx1VcO+uEY4K02slU?=
 =?us-ascii?Q?idY4nIIHCTG99Dh9MNwWkqlSm2pRvZ1BUaTkBEvlWlTkqPmjHZTb/8jPr3LW?=
 =?us-ascii?Q?PHhzLem4DHuK8d7MmX5ZBd0uUB4Iu68FDdo4MSLu/ynC+ludvoTQs5t+gsHs?=
 =?us-ascii?Q?GeEAwPaCLGljaFR5FF5q92DOALoe10QRxqqGcCVNe3Y0WkD36niNnGL0SCYu?=
 =?us-ascii?Q?CIFksOA9vq7oclF2YPuvmMgSkfA49bOoEQSQyqbb/YleGJa3SvRcCsnuKsJZ?=
 =?us-ascii?Q?TEATpzCaLyVkEykgbE/j73sTXzOfe6NsGzpoh0yCD9VmgJ8BN37Hffmr5lh2?=
 =?us-ascii?Q?kJfXCZobaiH7EN/18mVqjnXgYkk98E8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d854180-664e-4d72-6d4f-08dec6c15226
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:24:34.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypyiRQ5wwGQQnXm2iMW5XfNK5GJicr+FTF28KP6NZTBB88A/fZHfeYrIPsXTBJA/EPIX6r2NmDSv3xhXhqwkSbJ+gGwrV/xBsJsHDxzkpZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512

stmmac ethtool module do not call phylink function
while GMAC NCSI mode.
stmmac_ethtool_get_link_ksettings() return NCSI defaut
speed and duplex setting, except that most cases return
-EOPNOTSUPP error code.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 92585d27ab88..149d3b9536ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -322,6 +322,12 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi) {
+		cmd->base.speed = SPEED_100;
+		cmd->base.duplex = DUPLEX_FULL;
+		return 0;
+	}
+
 	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
 }
 
@@ -331,6 +337,9 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
@@ -384,6 +393,9 @@ static int stmmac_nway_reset(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_nway_reset(priv->phylink);
 }
 
@@ -424,6 +436,9 @@ stmmac_get_pauseparam(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
+	if (priv->plat->use_ncsi)
+		return;
+
 	phylink_ethtool_get_pauseparam(priv->phylink, pause);
 }
 
@@ -433,6 +448,9 @@ stmmac_set_pauseparam(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
+	if (priv->plat->use_ncsi)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_set_pauseparam(priv->phylink, pause);
 }
 
@@ -547,7 +565,7 @@ static void stmmac_get_ethtool_stats(struct net_device *dev,
 					     (*(u32 *)p);
 			}
 		}
-		if (priv->dma_cap.eee) {
+		if (priv->dma_cap.eee && !priv->plat->use_ncsi) {
 			int val = phylink_get_eee_err(priv->phylink);
 			if (val)
 				priv->xstats.phy_eee_wakeup_error_n = val;
@@ -723,6 +741,9 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi)
+		return;
+
 	return phylink_ethtool_get_wol(priv->phylink, wol);
 }
 
@@ -730,6 +751,9 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_set_wol(priv->phylink, wol);
 }
 
@@ -738,6 +762,9 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_get_eee(priv->phylink, edata);
 }
 
@@ -746,6 +773,9 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (priv->plat->use_ncsi)
+		return -EOPNOTSUPP;
+
 	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
-- 
2.17.1

