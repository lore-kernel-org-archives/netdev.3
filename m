Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129A1F3B85;
	Mon, 27 Jul 2026 05:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785129189; cv=fail; b=SC8ul8wvV8Qh3JwFIOFoFP01JS4Zm0bBzILtXQeJlGXldeLAeNksInl/18LssEwPylCqwni+yJ/wuwXxb7EDQQMa+rCCW2Bs6sR06WJD4xRYFbQCNZW/MT8OQYektC0PeaVeS9I8PLYg3M0NzF65sRpGsdFtYzXc9VCOg6jo5lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785129189; c=relaxed/simple;
	bh=w9pyjOE6L9iDDH60wZFEuS/eZ7Ec1nACm7oole+6YoE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AwY+oepN0Tj83S3eHiVj/xRjIQ30NPPShk2sOGB5ny9yThVGL7LDoqBYJxhZE9cHxW+GUwJARqGs+BdrIwhq9zKdYFOONtcPoCbAo49DMK2sLoabcFimvOBcfGBgUGEFC/XrExzGJDbMIRwQ03o/gA9lR2NcdurYz1G0yWLWwtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LyoK4Z4o; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LyoK4Z4o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjGy5dFDVJmayT2F9CF89plHbRLf+eWirMEDj60UpOTWXh3Uwys0Jbc7cTxydfvM8SDpfHAmkYv3rD85CxXet/mL/yFUWc3O2QzxM8V2eEJeq87HtBRnkkl5EPvp2y1qc5+gDcVw9MpHuObhAVkc97LhpK8Amt6m1oSc0SrycBRwnmbSGOV0sINvOQibxahQAOEw7ByGoWCGqA7ZfdzqvLXf7Z10eD1GCBwuOee+HE9mpjyi4wIXJUsA5OxeHCj/4vxO1ZHu+1QhrtDAsxN9qMVGLLGRxjfe2rlZ22gwOa5d+rINFI6Zh77GrPb6UTtyaxsqb/vPXhh5Il+ccbNEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fucDZ7dQ+xNQWdMeJ5/RKryZ9DPROkMOi9C/tTZ428Y=;
 b=lxF1D2ojbQT+s7xIh+ywepwC99e5qpW77RQ2OEs24Ne7qlCnZ5wNjxgbGMn1u7jpgdBESX1NAcMZig/SwAx0gdjIiAas180NdH5fCswvY1xtFIisO25BL8/3syGMqCNHMdaJI+y4OAAmgXrFu2Sof8r7sCaJDj3WWrmTjgC0KdO7bn+/txApdriLw7en6obi8hvfvMj6uq+Juwn7YtXAyOqR5PVW2mQ15APQyHGwDYovMLrMuUqNKLu1FuLx8cbDwCOfxHRC2G0VcrJgXn580Cad0SvTzd1snFo8dLtXqV7yt8pAYYV2mDO1FaNoGGHflONeIXxp54BGnMTepH6ESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fucDZ7dQ+xNQWdMeJ5/RKryZ9DPROkMOi9C/tTZ428Y=;
 b=LyoK4Z4ozgw/VPXP2ctPYH1mFkDWzk2RNetAxe/4L/hRWL7hZFgzCQj2l8165V9GN2h9OLGn2fRVcT/oFOPG7lVOmYisyJv44lABnWX6B8VwWua7zAEEdYHaeFPDixouQXMfpfwZlSH2REpjJV9uWSSbOOqAz0Ytd6Mi1NR90l+abxA8KGtVnpv4tWhGD/Tux3SgFZyDc3UeNXt6fucQ4KcLYL0aWHReO391IcIlFiG8J2hruiqQ4cka1IRsTFFACPdrqoq2DLAwkEQ1Jnid92H+WtR2SD+rMTQKldxO5n7wTrO8tQXQk4rZ8X9HT0Wneph6FftQLOQkb0Epf0UhdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MW4PR03MB6665.namprd03.prod.outlook.com (2603:10b6:303:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:13:05 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:13:04 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: stmmac: fpe: Keep pmac always enabled
Date: Sun, 26 Jul 2026 22:13:03 -0700
Message-ID: <20260727051303.14925-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MW4PR03MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3a3dde-ada6-4eee-554e-08deeb9dbcdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZoS1so3Okx/fjITzJqMJGC5/cc0RbYl/nabyc/EasOGKqY8xBOtflhHSXnhfPCLTKC8em2vHB4QoN+XRfM4woVH7tg6+cd+bMFx4wbCHBMXd5pCuI2X2Re3XmcBs8ghFwOug3xqtWHcY5FMnqsyXn7qFa1fFNxFkEE+SerxDlIzshblN6OIhB0Weyc/gPenj8v6PHF0VWqy2sAzrjj4ThLCMG7ZyPtNdJPg56iFqESvhXVRChemYgs+RzfnDsi3Pvj+sC6zAlfduRvEXwf5+3Nxuk5HpdCF+WZ4oRr37w1KaAyNoHgzdT/GWhO0H6ArWlHNW7v9H4BYJgFRe4lM41/6rj27YBtbSYoIL6cPMry7JoRYa9qz0tDyMVHsGpMxvz+vNXdhx98c7+ZJrAKgq7WhkOTcCOmHARMWM3oEiZNBBi9nffIheIGBwAxrjMfQT0OsaNOzAY9rer8FQJH1wWnl/eAV4sMa46W+dyfByC0UH2iK6FSD5uMxFS08vCefuB3AqaqJDiw/EFJPKekAvCdBbr3/TRZQMU88uDaBQNzIyOL5fuUi+js4xffVTRokZ74rDZSTonFLhdUbmlG273NR3S9ut34AH8fTxjnmj3G39z3YzejSG5BX9tQb500WjUPxOrpFZFi72lx6BwDgjZT8yv8Zmu1OvN1IQM9wLFvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Jg5Wuoa8IFbVcQN5wnuQUA+fxXc5ZCicwYa+jhfk7p1RkWUhuhFyFgVDHnq?=
 =?us-ascii?Q?uTt3LKoRSGjTaMnZXRLqXzZ8KIBryEHNWpn2HH85w6VSaUMqsQJ0UlhChLJ3?=
 =?us-ascii?Q?XO5MXQ9T1CnFL9ntNerjSxn/nTNqA2Dq5OPc/IQ18KWZ4p9xyqFo76sAfkY3?=
 =?us-ascii?Q?w/cvwgRPzGP4hYn3TvEOClxuaXcjp+HF0qVZEIu32dauP9fU6YgHEitrqXHG?=
 =?us-ascii?Q?hbIp0fBP+ef9oCzDECEPtERfcuXj2wZ+fbAzSfE1vdEM/tx06jGmP0AxdMMy?=
 =?us-ascii?Q?zoF1aYfcltvAcSsI+IWpuiH7F1rMShY2k/ZPHAvCHNnxI9JbmMCKz4uaJa5w?=
 =?us-ascii?Q?fNhDfqXGYim52plz8reWyGeumutv8uc61QUiV9LCtUejV+jAm+a6QjwyGC4T?=
 =?us-ascii?Q?8DZPqCTVDE8taOzzrx7+0hc84jinYX5x2O9ebcMLEGXmdo5H24d4cCUBcBW8?=
 =?us-ascii?Q?dFbWFgkVjRqzOsZMelvrjcKf5gbIl2BbfKm+WW2MKkNsQx8BZk0EGJWPbD9n?=
 =?us-ascii?Q?yrgACQLJxLNmPzEt1EQUuaOND8ad2mQtrHYOw/c4O8WS29aIdjQtzSyRFqT0?=
 =?us-ascii?Q?x3nVfrRRsVCKHgEYZ544HCPud8OsBOIJiLfviaKfcjk+J/Kfi9JeM4LOhN30?=
 =?us-ascii?Q?okzBes2WZJpKvdKAgZgZhBTiCHey5KBQXCkQPl8rO/ONbKMsNnE0ds15U+Me?=
 =?us-ascii?Q?IVvVosFHrnJmDCS1gg6XXNJAdi20lv6+a8aoq5ZMORDuuZekiyKzlljRVKNP?=
 =?us-ascii?Q?lFu5Hg/cuzWOnfe5DXbaV0uvqUPAEBlZgMxEAzltaAoQSPMfZAP94UX27Rdk?=
 =?us-ascii?Q?3F3dqbohXW/9OxfOEX5b32weDa2MKfbgfv3TynFhXZR44SZadS74xGEmq67N?=
 =?us-ascii?Q?d9QDJfgDCQCplKywb3e8FdXGwx3QiSkLDqxcp3FgKsDXPkz1CnN04OUIdGrD?=
 =?us-ascii?Q?EVVaiR9CGI0VxaK9fcFVdWHdSGS56UtLYZC+t+qEb0NBlOilSRa1qQhlK+q6?=
 =?us-ascii?Q?NM3Gv+shrzKYzEMzwM2fqAVaPLX3QynisH11RY5/hsQorygdlaB18u1ETN8l?=
 =?us-ascii?Q?F79c4Ogf6rxV+sRSuq2Um1u2YVMMoPsxdgwyWKgVUpveRDDKb7Ep+wep2YeB?=
 =?us-ascii?Q?q2xKNpfJEfgPzOWRqzOBj4y9by84lz9wf9yM+a2ih6SI8Iqsv/2do8G0d/K3?=
 =?us-ascii?Q?6l5pSxr4+rRD1kACYyd61xO5dh4EgARn7RPyyK0siDu9mhrYW22rcGDJ5UHp?=
 =?us-ascii?Q?Z4MgJa4brMnAGgZ6XzS3cOvBiZ2RonD2ry9JUMZ4kRhwL/sPoOyd4qvAr/WY?=
 =?us-ascii?Q?CjRIzEsV/wgl6PPqB/9f5LkQEaavLZsTyBkqY/AiM/7f3klyQFus4UfEYCe1?=
 =?us-ascii?Q?s3I+qkFmqtrRfPayvylXCyF5w3TXct+Dq2YR3ICXdizkt5Ylh4CXfJkswTYu?=
 =?us-ascii?Q?LyWhCRK7KMPPvG/nNg6SLrGCXrZ7ujrjK7JVIQXW2HIYLCUmOeIa1idclvnS?=
 =?us-ascii?Q?OrFecSrg5USvfPzpI2bYeSclnpa7T2KLOlaSjgEq0KxH/0gRNc6Fcf8lR1yv?=
 =?us-ascii?Q?yfChuZt1IWZYP3kL0nNATEs0rUIipO/TrMv4rw2kgCAruLm2bMn53wX9TJTh?=
 =?us-ascii?Q?dQ2nHWsyJIDb7cXaz7ZaL4dNEQInCvxFa8pDQwTlKQC7GGf7BnBXYR0TXnSr?=
 =?us-ascii?Q?NgX6S8xqhPZneFpR478zj4BLlalEMwGIDLh/3ohUb9JARZ/vS605TSbyjQIG?=
 =?us-ascii?Q?xhVJlQ8/4Hfk/tfsqzpHyD/Ydm4yUQdfbNAeXkNsbuhqYLf6AJL4eJI2D+VS?=
X-MS-Exchange-AntiSpam-MessageData-1: c1nOF5iDeBse/g==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3a3dde-ada6-4eee-554e-08deeb9dbcdf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:13:04.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb39E4YwFh0C/KB0WrCqlgDvIt5nNEgk5nDIMULOrJj4XEBMiBofO99xxcXTsoEqcDw2UNnG/yzKo9sCdRkhSznU4ilyL6/SghFWEe8zLCTX5FFOHUG0gspz/GS1qFk0gbluNlGSseK9hzaUY+pBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6665

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The preemptive MAC in DWMAC is always enabled, meaning DWMAC is always
ready to receive preemptive mPackets. Keep pmac_enabled true at init
time and reject attempts to disable it via ethtool set_mm.

The FPE residual queue (fprq) controls which Rx queue receives residual
preemptive mPackets from the pmac. Move its configuration from
stmmac_fpe_configure_tx() to stmmac_fpe_configure_pmac() where it
logically belongs.

Also add a missing return in stmmac_fpe_init() so that the pmac_enabled
initialization is not reached on hardware where FPE is not supported by
the driver.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 34 ++++++++++++-------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 92585d27ab88..8ebdd249e5c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1064,6 +1064,13 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
 
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	/* DWMAC always have preemptible MAC enabled */
+	if (!cfg->pmac_enabled)
+		return -EINVAL;
+
 	stmmac_fpe_set_add_frag_size(priv, frag_size);
 	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c54c70224351..2bfa84ad04a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -47,20 +47,13 @@ static void stmmac_fpe_configure_tx(struct ethtool_mmsv *mmsv, bool tx_enable)
 	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
 	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
 	const struct stmmac_fpe_reg *reg = cfg->reg;
-	u32 num_rxq = priv->plat->rx_queues_to_use;
 	void __iomem *ioaddr = priv->ioaddr;
-	u32 value;
 
-	if (tx_enable) {
+	if (tx_enable)
 		cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
-		value = readl(ioaddr + reg->rxq_ctrl1_reg);
-		value &= ~reg->fprq_mask;
-		/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */
-		value |= (num_rxq - 1) << __ffs(reg->fprq_mask);
-		writel(value, ioaddr + reg->rxq_ctrl1_reg);
-	} else {
+	else
 		cfg->fpe_csr = 0;
-	}
+
 	writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
 }
 
@@ -68,10 +61,11 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
 {
 	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
 	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
+	u32 num_rxq = priv->plat->rx_queues_to_use;
 	const struct stmmac_fpe_reg *reg = cfg->reg;
 	void __iomem *ioaddr = priv->ioaddr;
 	unsigned long flags;
-	u32 value;
+	u32 value, value_2;
 
 	spin_lock_irqsave(&priv->hw->irq_ctrl_lock, flags);
 	value = readl(ioaddr + reg->int_en_reg);
@@ -83,6 +77,14 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
 
 			value |= reg->int_en_bit;
 		}
+		/* Frame Preemption Residue Queue is the Rx Queue to which
+		 * residual preemptive mPackets must be forwarded from the pmac.
+		 */
+		value_2 = readl(ioaddr + reg->rxq_ctrl1_reg);
+		value_2 &= ~reg->fprq_mask;
+		/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */
+		value_2 |= (num_rxq - 1) << __ffs(reg->fprq_mask);
+		writel(value_2, ioaddr + reg->rxq_ctrl1_reg);
 	} else {
 		value &= ~reg->int_en_bit;
 	}
@@ -174,8 +176,16 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
 			  &stmmac_mmsv_ops);
 
 	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
-	    priv->dma_cap.fpesel)
+	    priv->dma_cap.fpesel) {
 		dev_info(priv->device, "FPE is not supported by driver.\n");
+		return;
+	}
+
+	/* The preemptive mac in DWMAC is always enabled, that means DWMAC is
+	 * ready to receive preemptive mPackets always. So keep pmac_enabled
+	 * true. pmac_enabled = false is not valid.
+	 */
+	priv->fpe_cfg.mmsv.pmac_enabled = true;
 }
 
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
-- 
2.43.7

