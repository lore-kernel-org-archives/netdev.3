Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010038.outbound.protection.outlook.com [52.101.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851B4F0540;
	Tue, 13 Oct 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891924; cv=fail; b=IZfBCbgb4riahzNEqRQZu2gNSXkg6JvAklNst6gsS6kzUwhULYoUwJvPy1OR3ORKZEq9Wph5bHbEuLrr0VOG+PfPrmeq5Fk8XtI5vNdrslsMnM+wakL1Wt3gXLFZuXVZq4FitegYAjwF0WyWpHwpUX3ktMbF8K6STOBdUG7QyOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891924; c=relaxed/simple;
	bh=CiPxseaqfxteMBFxJmi87Y0NXeWiCPPk8bLSeh8GJzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZK22/cDhm7LrrVr/Lnw/o3g6CF9XRpcP/0VuGeOkFSSQT8QLddcAk/R30TMZ7kyvV/69kTIHpJ8CFbqJnBESafRChSag2WL3EnJCW4BMWNXKBItw7D1OSxxFLPxK2RZrzKGI3WcDoaj6iB6I+LwxGEvGdI9dOuABnc4hjk1xx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=CB7Qn0bU; arc=fail smtp.client-ip=52.101.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="CB7Qn0bU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZ318c6DpyfDZcIpCSn1sgKwXTVbDES7J7dV+hWpFZ3C53+HUhw6IjEh1mn/0p1YgdahxtNJ/6O+nLMfjFCFUA8jU6oWpDuvnjhz0hdmo8Xg/iCOkk6lfAXo7Ffc9LxwDdaY7+MlSXA37Zf/nFqKT6Jf4PgkR271Y1tisZzjHd72gS8lZgUt9pG+EqDxNVKQcQeVXU387DKTO3l4evHc5bL966QfguBYEE1BXT96T+9OROJWioznIZP+/ZZUD8eBNgqLRt8wwN4KRuxsuvn4TN+SSY68knnp6uyUccJmSpNVPKpDQ071at7CmF9KBSwQf4M+26p9xSKgxREQGKVbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeVOGv1pBU4HdinlNlwV2FGb6Mlj6OrDn55dT7s/dU4=;
 b=CN2ocwFWZQyxXx8ahmvH3y9km/UebaLsuFzXaDRaUVyxZO3QexreyneMDVS7ERT97MGX7INW/DUrDsqx3Vpe2ERIHQGCT06FPZ3XohWrUIr1evu1Dx6+fzTIFMFGejcqK6pos7Q7iTIKNBrj7KdETn1z6hcbr70PHcVfc0JpfjaBaOAuqdKjWzk6s6lQfrC5Iy15E7Emp8XvveUfQz8VWDXTgMqzwykf5FE2UQbWOf2OvGsbVqKWfBR+b+y/qDFGEjcYGLBV6A+dE2H7wpQJ8cbm49HRhjaZLplsl45GtLEvC5aJRkbj4Sox8vu3/nHxq5jioh9CRHee0QeNavLGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeVOGv1pBU4HdinlNlwV2FGb6Mlj6OrDn55dT7s/dU4=;
 b=CB7Qn0bUh9SBGSA6CvRKJdjEzqunavnu9ork9Py4aoVGKmz6C4mmBmMKZDSp8jxXNzm784tTf11x2VN/9ALs4AakEwp+My+6HNA27f0VxMmM4M2iaC43ZdjRR+9QGLeK7e4SafY8p2BrxAhYZb+rGD77l7aMVrSff5xtoCfM6pk=
Received: from OS7PR01CA0008.jpnprd01.prod.outlook.com (2603:1096:604:251::16)
 by OS9PR01MB16322.jpnprd01.prod.outlook.com (2603:1096:604:405::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:45:19 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:251:cafe::51) by OS7PR01CA0008.outlook.office365.com
 (2603:1096:604:251::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 11:45:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 11:45:17 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7113F300024F;
	Tue, 13 Oct 2026 20:45:13 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	xiaoliang.yang_1@nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net 1/2] net: stmmac: Track the TX DMA threshold per queue
Date: Tue, 13 Oct 2026 11:45:02 +0000
Message-ID: <20261013114503.57487-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
References: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|OS9PR01MB16322:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5378de64-872c-4d8f-5192-08df291f741e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|22082099003|18002099003|260925022911599003|260925021911599003|10067099003|260925021311599003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vSadW/oG1Pu3XRGDYT4xkG6qMX/Ert/r10Z0naFM8oXEL6J8Fa5e8Zd9X4JC+hf6FAdRkC2bz8kC9bFu01c0OE/xbDHsOpKvy5fZFCUw4fHfTt++KTagxWdg+YOqNejCkjPsQpJ1DwGofJg4Mg8+BpaTLEyao7TNAnj94T7HtYmr+qteczAGRI9rfHUXTH9L071AYhMJbPdn7nl8DhsmIZFhhNgn93Do5aSByKyZgOID6svsq+iiKFBF6z61YiuzFYYvTzPzMNgoO3A/5ST/3Cy+OdPh923tGunaAcwwNTBq6/5An2UnnlbaXmxmu7jPIESMGWhVQF+C3IWEfNt6voyceo0FpkNEU+T9RjWeaP2GAmVphOxKe9DjUsu0Af44vbJroGVOp5zXZoHCx13AbwodeMguf24hvbHttSkgOxHNgqlCpBo5h4akrSS85csLiO6mvIbU2NqMurKW40stN1FoejWB9hTrTEMtZix3eGNI+2fIG+kmKiP6LNDwTfPSy7P7tMESBBQZyJTr4DQ2JZRgA1uwQDDt/IzOGcNRkUb9GCrayJ095cPCvXeSIUpBtGUX/ek5CFGY+J4ssZwN3xQ9G+pcbl0YXCvqLD7gzV1EjxN292eL6mYTyKUKLntQJD0eSr6SDEbSqO3PTOszyShMebA7n4RgMbpRw7ul5XMYn1cKxr5LCqVfWIyJpVnru3RI5n//eRgk96LEmIoiNQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(260925022911599003)(260925021911599003)(10067099003)(260925021311599003)(11063799006)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pbiTmHeyggjI+LSyqg6RhC+s0w3KCPgOKlpCkKrJptIriclU2xLTplPMNIcwhyke+87MqtE1uvzoMa+AFFu6s+h+yn4bqRiZ/Oz1T6Dxgc34/Z1C0toeG1epuzUbgcuD/GV0LXWC5boWdDhePyncBFpm2lRBYFyKtJ4x7UlkDQ/SxJrmpGRdAH5D6S+i7eIO0H7hhrA3XGGrMOl2dZkK162AwWdft+cVATlUbDTKauR/zzFZeVfC8ky3xYNaGe7ogXmZtQ0XeFwgccaDh+FENqoQcw9rUQiZOAa+SXfNAMyhAdH/T0WuK4RxRNGOFLjtcdg6hIbsHQLuVFNMkzTbcUZFitu2CkUFMBAzsAO6QeisjVAqwd4ag+WdmAD+9BOdtXWrjXw+5o70ydmb6ih57MsKz+gOsNYPiwv0+y59lUmNHOKVkJ3l+XSwL1+9F/n/
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:45:17.8161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5378de64-872c-4d8f-5192-08df291f741e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16322

Commit 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from
DMA descriptor") made dwmac4 raise the DMA threshold of the queues that
report TX underflows. This is done by incrementing a module global
parameter 'tc' by 64 on each underflow.

This leads to inconsistent TX DMA thresholds between queues and causes
issues on platforms with multiple stmmac controllers, as 'tc' is shared
by all of them. Once 'tc' goes over 256 the bumping stops, and queues
that did not underflow before are left at the initial threshold.

On the Renesas RZ/V2H platform, which has two dwmac4 controllers, we
observed sporadic iperf3 TCP TX failures:

  iperf3 -c <server> -t5 --bind-dev end1
  ...
  [  5]   0.00-5.00   sec  1.00 MBytes  1.68 Mbits/sec   87       sender
  [  5]   0.00-5.00   sec   768 KBytes  1.26 Mbits/sec            receiver

This happens because the TX queues of end1 were underflowing on a large
fraction of the packets, but the DMA TX threshold was never raised from
the default of 64 bytes. The threshold was not raised because end0
had underflowed first and had already pushed 'tc' past 256. Which
controller is affected depends on which one underflows first.

To fix this, make the TX DMA threshold per queue instead of global.
Each time an underflow happens on a queue, its TX DMA threshold gets
incremented, without affecting other queues or controllers. With this
change, 'tc' is only used as the initial value, and the RX threshold
is no longer bumped together with the TX one, as TX underflows have
nothing to do with the RX side.

Fixes: 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from DMA descriptor")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 +++++++++++--------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 9278378407e8..85d63450693e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -270,6 +270,7 @@ struct stmmac_priv {
 	bool sph_capable;
 	u32 sarc_type;
 	u32 rx_riwt[MTL_MAX_RX_QUEUES];
+	u32 tx_threshold[MTL_MAX_TX_QUEUES];
 	int hwts_rx_en;
 	bool tsfupdt_coarse;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b8b4de4c5b1a..b5ee0f297df6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2622,7 +2622,6 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	}
 
 	if (priv->plat->force_thresh_dma_mode) {
-		txmode = tc;
 		rxmode = tc;
 	} else if (priv->plat->force_sf_dma_mode || priv->plat->tx_coe) {
 		/*
@@ -2636,7 +2635,6 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 		rxmode = SF_DMA_MODE;
 		priv->xstats.threshold = SF_DMA_MODE;
 	} else {
-		txmode = tc;
 		rxmode = SF_DMA_MODE;
 	}
 
@@ -2655,8 +2653,11 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 	for (chan = 0; chan < tx_channels_count; chan++) {
 		qmode = priv->plat->tx_queues_cfg[chan].mode_to_use;
 
-		stmmac_dma_tx_mode(priv, priv->ioaddr, txmode, chan,
-				txfifosz, qmode);
+		if (txmode == SF_DMA_MODE)
+			priv->tx_threshold[chan] = SF_DMA_MODE;
+
+		stmmac_dma_tx_mode(priv, priv->ioaddr, priv->tx_threshold[chan],
+				   chan, txfifosz, qmode);
 	}
 }
 
@@ -2822,17 +2823,20 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
 {
-	if (unlikely(priv->xstats.threshold != SF_DMA_MODE) && tc <= 256) {
-		tc += 64;
+	u32 thresh = priv->tx_threshold[chan];
 
-		if (priv->plat->force_thresh_dma_mode)
-			stmmac_set_dma_operation_mode(priv, tc, tc, chan);
-		else
-			stmmac_set_dma_operation_mode(priv, tc, SF_DMA_MODE,
-						      chan);
+	if (unlikely(thresh == SF_DMA_MODE) || thresh > 256)
+		return;
 
-		priv->xstats.threshold = tc;
-	}
+	thresh += 64;
+
+	if (priv->plat->force_thresh_dma_mode)
+		stmmac_set_dma_operation_mode(priv, thresh, tc, chan);
+	else
+		stmmac_set_dma_operation_mode(priv, thresh, SF_DMA_MODE, chan);
+
+	priv->tx_threshold[chan] = thresh;
+	priv->xstats.threshold = thresh;
 }
 
 /**
@@ -8133,6 +8137,9 @@ static int __stmmac_dvr_probe(struct device *device,
 
 	priv->xstats.threshold = tc;
 
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
+		priv->tx_threshold[i] = tc;
+
 	/* Initialize RSS */
 	rxq = priv->plat->rx_queues_to_use;
 	netdev_rss_key_fill(priv->rss.key, sizeof(priv->rss.key));
-- 
2.34.1

