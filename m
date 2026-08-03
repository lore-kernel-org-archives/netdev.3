Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206835C685;
	Mon,  3 Aug 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727462; cv=fail; b=qUuwwfo+99sWAFuFu2Cm3PzeXEY9cpgzeMEYOAd6aASbHNVUMbgHL3JKRyDBcgRgIoS6YWOxQP3SGc3Q/rJPHuxPIqaWq1XmqZ7KpZj5SjhIS9F794rSa+Dt7DDer1xPEeXYM8JuYT6GdEo7WU6dRtzk9NabDKALD6ChsTjFBvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727462; c=relaxed/simple;
	bh=SnkOP0p+ZeWbezbfFRjcEKWGIIbvugsq/O/ex2RNhEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YW2cKtYZE8BdVb1NONkl9o7OjTjI3T2aCWm6+4VJGIFwe2b1IXaEocsZburRDSAISshxrdm6rz3ipFRNdBFpz4M1kqEhB8yMGmXp7c4cex5jUgBV5NrnTeN2MOdQufDyvWKcauZZ8GRe3EGV4b/dhHDYyai0TY78Ifegd14IANs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=KohgnDWb; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="KohgnDWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk+1ZOWf5dGjpwabc3fEWNz7TtUOwEDbMli4RsbETXHZiU/HUIR8qbKqeuJ0ltxUQ/Y8SRqyQHZI9ICggPzSryKF06IqjsrlQe9sTIPOQ2z7r70MQQKmSSi6P08C+qqjobWfxcU9qGC4AwE7s0FRGjjtaqiobLHN7+ygds9pTMMFGCaygomqdZO8+WN4sorO25MHxd8KrNsEeLrKx7QcgUs4Z63K24OmsTLhgBTaVmnlduHQ1Tb0JR3JMCCTuqz53fjz9v5mLMJewsPOYpncIsr2z4p4ZtDVbzqtDGoYC6txk0Xiipve1sj0uEQ58uAPfnsZVWoUqA/oXv9gq9yleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff/cTBS5N7GqKFGMFP8eklIy3i1FhGsuKzXvx2K54Bk=;
 b=SONZZmytfBwpV5FovJ1aXNVD+IlLQkrtNrokwwO4bU60XHjPVueCe5FFB09A/4qh/mGLJw0V6jrA3wHQAahZFr/Mz3XbnhzhD+O56CbzH2PcIxICo4VMO9ja46Qm/zx2moWs+5Mz+NdQ3z1aFxSJ17FgJruV3r5PTrAzJTzwe1o/NwXuf6MAM/M2d4qLVCFukJ08WYzdMjyn/BClCcPNt+ug/nwaqsrHkff1nldpnTGpNeqjbZAjBnDleyeMDSwKiW/FB6+u3nJ89jWPqP8sEVyERyp7QGK7Z9Vxu11LU4yDcqcc6iiWgSo+FhnLf4jVvIQ4DL3uyUsvoEPWqm8EFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff/cTBS5N7GqKFGMFP8eklIy3i1FhGsuKzXvx2K54Bk=;
 b=KohgnDWbkOYPsmMbLdQlmEI4a5/iKTk5n9kikyAtX0Uf49cOTM0bCmTLhYCesm0w0Q87XV38+ELOakUG4vXgJRTH5k+FzQWGAcfcf4aRr7m68s8j/biwqYTKe98fv8EXY/zKv1iz9K1feKkfZULT/10zzrYwAFRMTtMNnoouekCiymEkcrn/sTSuA/4t4ZB6+xWSMlJ1f28aNbTIU3xhrfnkJjhcIP5FQ3fby4L+lsXsMyxCNWrDy5hRaIsslvWAupQyxicJpZ2pGxMWlQkjuV1rfxkZzIpQfa94088kvy0ISICvZJAfKpwEZv3ZAw1aAcZzliNRVZtLRk6VwyDrfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 3 Aug
 2026 03:24:02 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 03:24:02 +0000
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
Subject: [PATCH net-next v2 3/3] net: stmmac: fpe: Move fprq configuration to stmmac_fpe_configure_pmac()
Date: Sun,  2 Aug 2026 20:23:58 -0700
Message-ID: <20260803032358.16282-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260803032358.16282-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH2PR03MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9f3a77-80e3-498a-e7dd-08def10ea9bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|6133799003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JCvZAs64DhkCZAnYCEm3BTtvKbw23x1C0/LgNnRQsQr6TJf6gig9np4Wx45jbgmRmSdVh5Zh1Ly874J2R5U8Mw8OjK3pBNnbVlcQ/DSjFCUqZ5ulvBz+1V3e9OP8oXXT2o5MXvSalZI+KfV5rCySCM7BHa26OjjOCAG2NPCl5xGnv8lNF/7AIotA9Wmz7FgzQY7LZqJXzIAdCZ4zudiIfN8d0H9BzLjPpdBxtGTi0hx8XNBqG4b5QIhNpeWgdn46mIp5Xda/xjkUk1458qRwa5LQ8iMq9GUdY9CA48/ObIi8W/Fd4IcUAV8RdEw0VSYyQwNEq9QGI7ZKdsDfqWHNKUGcz1BQ27ozuMLfbgQ+pr6w39eZoD+MVP2m1SuBhZtzrDidrceOe9rJaeD1DrItXR0R+PFXB8tT2bZYORPpwZN8y98C7lPb7zpTi7qJH1R3ug0RL6Z2R/QIyPAs1VdR6PkYXJOKLNJphOyEteABojoYPym09XxjlKKusd7qZ04/gGHeEoZQtrmB4mIkePZ9TTkqPgWLH2pXp4z6RT+1ezhVVkcXj+1xVB9haL8LfFha7yutZZnp7jZb+1z5IkOoJl+jjf8Wp1/MWkWnZvzw4NS8Y9GbRH7pXjl5/0QjTkjPwwnjw+mW/jbEbVi3pfb95vgiP16eQk+xrnJyYgXO2Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(6133799003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apyt9p3bIkZe9AMaXEIpf6rFJqU1liBvUOg52dFYV7vs1Ff17KxXlp/AiOzX?=
 =?us-ascii?Q?swNt4GpKhChPvJRv3nNvGwCR4/HeNS+ZegaXLZrurjVK1rV7g7htaXW+JleF?=
 =?us-ascii?Q?11ts+cgADIkW8/CbwMx5ojAuwDf7gqIJLlH/pPXTr2ZX0haY9TPwSjLTdPVl?=
 =?us-ascii?Q?uQmSvohLNdbsEuhvOQ2hvPk/BKpTMTsXj2w/m6MxGvNOliLwNNjwhpWN+Z19?=
 =?us-ascii?Q?jbIYEm5tsM6sdfv9BwUQ81AA9fLuHPoi9U9Z3MG0R7kYVToxD+B3HBMVS1ej?=
 =?us-ascii?Q?nBylb84ZAXBS4kIRLTYZqI5GAlWvbzYp2fVrCcA7ye91LZGyw3doJbMwM/QG?=
 =?us-ascii?Q?xUCwZrMsKSIOmcaRnsnYmGlKR6+6bI5Jh7y9ntLGX3POAXNzVS0IRK0PnSFd?=
 =?us-ascii?Q?YHmBUvZuKcHDKS9pnc6Kt04DMdrmdMSF3hSdg17FKcpTUdVjy4yvuJyESM+P?=
 =?us-ascii?Q?pKrTTl//M0NhC8HMwLWGTwy0xFjL4xWuvwo7hcQyiH2Nv/t9R47LguHkifMR?=
 =?us-ascii?Q?8zXWXEMbSLp4tVfXFFGINfdFe0/e4kt3fMAOvj5e/frc4OebsZHVEOMggjEQ?=
 =?us-ascii?Q?xb7kFrXvY5TITUZql18Xc90hwx1W17PCpALeKbICFxmgn8Q581I5CPBiGPSh?=
 =?us-ascii?Q?UIcjLFmGq6EvWCuYyb/Osg3+zyT76D+tm5fHtuB2mvKJlhS2B4S99UaTUCmU?=
 =?us-ascii?Q?YsVuLhFHYSUDReDg0+jiRKlIiWgNF4vgoQNzdOeQ4l3no1P4HE9pv6ZFUINs?=
 =?us-ascii?Q?mtBbq1/rAuqs7zDWx05SAZr7WSNMe9t/Qm+iPaPowOe2JMB+Somisl053cOo?=
 =?us-ascii?Q?lIeyNd3Zcx9ggFcX8E933dcbe6z8EKzvOXicKOJAn+1iL6U4s8/dSvlLi0Xz?=
 =?us-ascii?Q?EnuMFJlKWmy7pg/czYkkKb5cTW/D/04Bl0Ss5gkmDr+DyU3frrpqNYGrIvfg?=
 =?us-ascii?Q?SM6jJ9+Ybh8RfBfLVUf12VnHkd0FZAeRe0Cboduk96jEpe/FbEJov73yFBVr?=
 =?us-ascii?Q?tsuX1eF641wDpv4vOhcB9HJGwq8sm4cwSFHn84TP/Z4XcU1rTgCPMq5FWvx4?=
 =?us-ascii?Q?+damsxiQ7ofUx0KlFt1+9NquCOT0d2wndrVyeK8liiRoNhUK4eN8Oh9HkyRm?=
 =?us-ascii?Q?zaOB3R4y0nL+gsnxZISMBZdtEEWv7MN2ewLol4BEqQX7yyUtjTFmMZ4kMZDr?=
 =?us-ascii?Q?BOIekWwoPlFatGuErtVNvxlbG//rWxSxk0V1PyaawfK2GTCYZusfibuwLT0Y?=
 =?us-ascii?Q?dPKhO34hq65RlsJpmcjF8SDZhxZCqy+YKQYlJepodEoYrBb7DP1QvV57JYtG?=
 =?us-ascii?Q?sh0yTKCWzR1wVHO46GwV6v4OX37inVQgoPC20nzzUjbiWIPgoNIZKf9rxIdQ?=
 =?us-ascii?Q?9/gF4DcCejWHVcJgTlFrKf/X4zkY6mrstlw/HH6st9z6SyAyoMTPAq2TwJgd?=
 =?us-ascii?Q?Qu9WEJJKvDrIPCWBP1ZC5fJ3XFwXQCoinnBh5kXEhqCM827mhyTP3Ngl9ELn?=
 =?us-ascii?Q?Bz8gHCtfZJED9wvTVzfXRhDXUIzFuJSvd4FShtnsbdNQuvV898844Km+ijGB?=
 =?us-ascii?Q?KxI1843HocVX1v/i99NiFtnSAVGoPROshBJUvfaVDR8+nUV0dJ4+vaJzhO86?=
 =?us-ascii?Q?y5VTX8DGyxrRG4YZsUAc4/kJ6pMxTWsSDkLqm7M2X8x2D/exOfZbHeWvzG4L?=
 =?us-ascii?Q?kBe61Jknewng3inrc85DRjMfWCopuHA4Lxn2h0URHqPyou9ZAuRad8gJ3p3m?=
 =?us-ascii?Q?CaCsIfaM9r1ZAP94iBj/WQ+5yHlKoowvS7b26xK4rEtG282pINsenMq6b/B7?=
X-MS-Exchange-AntiSpam-MessageData-1: GcGib2/ncnIqpQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9f3a77-80e3-498a-e7dd-08def10ea9bd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:24:01.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SK77WDNGt1Fy33ydXprCsqtQ0e38INzu9igbpZx1SdBGXWxwqasiKZxOQrKOGFhgO9Q4XNQO4artyVmHOLiBwEeHJ3pzX5eDsAdIUYrFk0q5OTyp5uT5Wr5COZVnXR9bru3n36mlYhfSGf0SFN4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Frame Preemption Residue Queue (fprq) controls which Rx queue
receives residual preemptive mPackets from the pmac. This is a pmac
concern, not a TX concern, so move its configuration from
stmmac_fpe_configure_tx() to stmmac_fpe_configure_pmac() where it
logically belongs.

Keep the open-coded mask/shift update rather than u32_replace_bits(),
since fprq_mask is not a compile-time constant.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v2: Drop u32_replace_bits(); fprq_mask is not a compile-time constant
    and triggered __bad_mask on x86. Keep open-coded mask/shift.
    Collect Reviewed-by from Maxime Chevallier.

 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 3436e962a238..55b4df3c677b 100644
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
-- 
2.43.7

