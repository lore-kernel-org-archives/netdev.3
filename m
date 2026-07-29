Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119343161BA;
	Wed, 29 Jul 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289981; cv=fail; b=jJEHUQb9EMLmTWul1czWYJllQiTRZHxVhslj7/6QA+bYRPR2iYuc95JjTWp6xSoEmadyOH++ET0jtf0Y/5KU6hjSo6nVW9csUAUwDiwGyb+92vyUZkZs9P4rQgw2Zt4jB32nmRZQJ3SehzxdW6T5JNfjaHCjiXFlTYz3A5McW04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289981; c=relaxed/simple;
	bh=L21ej2enU48YCnMOs7dHpHRM2rg5vTH4/Ja8FT7NnTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u1wxNF2buUiKhdecUHOBAIFlbtPn3PoDuLlRWide8ayglj5LHiZJveuxPCDnx9CC8wjGNCV23GALapw1xId1pCn/mV6+KRBRxhD3oEqVjr9KwVG0REYIteAmbW29juMEff5Khke7E4Yjx89ylSjp3UE4lGWoKIJe//NdGqRq/Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qg00ntTd; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qg00ntTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkKsqLG1/OHz7CEz40gDGLg7YmWZ7TFNFVtzQfjeEpRkRWxltmuQwgVqvHwtcybcdqHQNKgFSZGJO0hRe3bw9+8ZLhA4D2PNHWJohWG28BrlvrmM0DdDxL5UkK4vYqeIjJGICUFpNgLXts4LMPJkeufWCi8jRmAJdQVQ32rp6gdTM+gVIEcUKcpj3PUtBbc20TxWTh+WqY2yRW8SAxmo1jBodwT5ZSGNSHuxq3D4lD/YYIl34tX/mslylzsVWtq6WwFuf9Zkbrffpr+kW6V/4QIP6r6R0l44/yFvZ7WpVZpnLRh4OEhtH3OfxKoI7m/YOcpgoCzFERUDAJbONuwKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyEBuCjNN9KxfPKpLypn7hpCFgeb9a4InoxRxgImcYo=;
 b=BJfaIblXxDe8ZscvcQ22j87tH9y67AkcOBlQoMRERotdAkwQtUMjWHV+ron4J9u4iJavsPJOPe76n9E524h85Trr1u+SIFle+8HfhkfplOs/rQxBJAXFP5PgdkgxZua2HG8OfEo3Ms/FCY/RSH2aH1VaRFNIg7Pkd+zetDr5oVosDozVck/VDFjPlYbRcYjNNli3G8IT3YXmZp7GCw+2r/FnYdqcgSMMgC2t9tlFDWBAyGiC1ID7hiTOGUGobBh2hddk/+haBYLxndj9ILDuWyc7BWepwm8YTL4AdSie7YvANyTZNsMCJrx/Otl62yn2rw5DcGsFbIypx1tLz0b9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyEBuCjNN9KxfPKpLypn7hpCFgeb9a4InoxRxgImcYo=;
 b=qg00ntTdVKLcujbKVQCFRFtWAApbqnv5Pj7lITiWCSSRytu3PUK9JxhKMQnUTaqct4NtFwhHt/P184d8MXgJ0gsrFUtGj2TqHcRF+8/iBP1GuHgMcvmo9BdeQwVvbPB6jMnLTkD0Yay4r4gfBZ2lN+uLCAZ+Zk1dgRhda8981DNrEziXlF+QR3Sv8k1+piJifRrvyCiS3m0WFO5BWa/lt6mLK8o4tNz+86TLGgwkSyMbq4zdyq4rdqENxVh9fhJptthRUpS1BVdzG6pazv/YCq3Tl/CSbdAoUxzPxlnt6OMR/0xMa7+YR55mY4nDw4vfzMwICRuvwJ/sVUd4Yt8/lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN6PR03MB7550.namprd03.prod.outlook.com (2603:10b6:208:4f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 01:52:54 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 01:52:53 +0000
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
Subject: [PATCH net-next 3/3] net: stmmac: fpe: Move fprq configuration to stmmac_fpe_configure_pmac()
Date: Tue, 28 Jul 2026 18:52:47 -0700
Message-ID: <20260729015247.25774-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260729015247.25774-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MN6PR03MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: e15379f1-39ac-428b-6817-08deed141a78
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|56012099006|11063799006|55112099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	djdnugov1BuwSUUIRpJinvdbHAyBV6H6dZ8QLSjOPmhOlwzkdnnCIyNrM5+p8nWM7ptGIxlN+zAOMrbUZ5/qAW/Hyy00mXCuWviroXgunKK5vPuyk9vhoONR6rmo2jf0cFL0m4yxxj+auVnekgREm7w3HTv58/6HfKCwtXOSTac2ZlBqI8D2gQHhHlWuJ0S7EpcKnKNQcHTc+oDHtzMr9sNrAwIJMHcxvdPhE6AQlg8JjhaUYRUYjRHZ+k7R0vzMhI1lvja64pa3A1f1C8UpeFjSytDBWcpQCCjVkHAmu5jzLgOVQxtwRsdyduoUujFn3eoKVHvz2cONFQtARkbTVreaQpsyX4EncH2pXzGODzTOfH5SyKpLzksXcDMJtH/lL9Wm4tu5K0f/sETsuWlru5Khxb6zN3AGBchVYVnk6xu3xgUKUt/G8UlQC5ZXUZy+CKDeo9f29F5IX20/WaYFEb/0r4AP7tzDJ3QEns/BLaafRrP+ORRaalScxGeHv2XTjcu++vWWb9QcVcjoWfwfHQImN0K5OJtdtMy9hjnSVmLKqZOa0i4eyOP9ff1+fB/rU0OBvSEGwXadxVNhcdq+7k9Io2ZmUFJ5pptUj6cU4PNz9MzpKIDgwCJ4FvRT5I0VliJwj2kqfDEdxH/C0uQgfswYV4ZZfYUTRi44L279oSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8JT4qdGYsFdQYG97BFI0e2RRHBFPhjCccbHidF1RAsK7nDwrttSWpO/8iYu?=
 =?us-ascii?Q?RG85DlaX9KIH40SnNqGNRKEuI+IsaoBjll1Yl0aFNsWz2lC7jLY/sLZwnoq6?=
 =?us-ascii?Q?EsY84HKAmKGvBb3oFB5aIKyRAPkOsi8OTrIce/c/ORg7zrFlgm+O+VE9p2m5?=
 =?us-ascii?Q?V0CcQvrO2Xr3yIrEHsRtEEh6urkDfKaI61oyUFPxKPVnx7RpQGRl/RVldflV?=
 =?us-ascii?Q?nxG70RMGgNvLyckOllPAyhsM9yL397At7nOgipI7nijcLuKGveH0MoExefkP?=
 =?us-ascii?Q?PqByqZhEXlLVZurZxCbcJvlx+wlPXR3yHp+aSbCAqfVvBUx9c30Ak/wlOyOd?=
 =?us-ascii?Q?HEZSyHDCZTujcxap8H+O7QwzN7igip1B6C5xGQzQUHx1iEO68hoTM+izW3R3?=
 =?us-ascii?Q?i7mF8aqBXi7gpOP7FnIZMZskGYFse1Jqar1dHvSEYsm7oaHzQyilJOn+wG3N?=
 =?us-ascii?Q?2PpMWL5zYFXk5INmCJFk/2Oh4N4p3tIM4m4lopz3KQuypgxOnmlj3sxyNjzn?=
 =?us-ascii?Q?/PHwtKsFY5I97w8Vn0XXa5xV7A/R37UE7WXl0+9EbqIvZyWKzQwIGXia4YCA?=
 =?us-ascii?Q?GE0viA2a4ttNfqPDHKj8nEEoSpu+00KSivtQQNvUxkV0T/oKlwa0sFEraDU1?=
 =?us-ascii?Q?jlv/IxUVM/DWYHyBj6WVGm7CHsbELu8HxrEpNXb3f3pvuXcZ4M3ywle+KlQ4?=
 =?us-ascii?Q?wvcYLvR8V8feJ/9aiPa31KXtpRuwScuoNRtbyWIs6vwEpHFimPrVzk4FN28/?=
 =?us-ascii?Q?gtjQopJKOUCsL3jMglBIo/YBoKJpmzVa1+TPGf8PhE2Yyh2ott6ESUgKO4JX?=
 =?us-ascii?Q?lVxkasXCj1Ra5++ljSSge81YPwUFKlJ//duUZfLLzLtVehnBvzJ3vwCG9KCS?=
 =?us-ascii?Q?El7gCLj5Jvfliyd5969v1kZhld0i0f0XsNgnaI2ILr+CPPRko/ehjvhlGMvC?=
 =?us-ascii?Q?M+RoI5XLlfLXZ3TRsP9wJ+ce+JzVBW5e1ktsuYsBi12O5JIa9w6GyQU084Bg?=
 =?us-ascii?Q?ZxmQB61pH5WFIT2KS/QcycT9WiqErPz6Ura3HlpcUVJzgUC9WteO62gyRfW6?=
 =?us-ascii?Q?1xzCCIc3dNFP6M+RLz3ptISnrpBIXZVSFPDElbH6q4wIZM379JzBy9gFyb2S?=
 =?us-ascii?Q?YMtmdh6VLgtfanTsJck8zTCp+a3PrJ4f6dWGXkE1lHHX/xrvOxZaEafWyHAt?=
 =?us-ascii?Q?hcpWxVziMBY7D0JW5+GPzEYKBT00lsbid6z5Kl25ZSWW5yyVAJgBSY6AB3qi?=
 =?us-ascii?Q?my60vXrxmD2JbQoI520DBbGMz/UyBGY5wGqAZ8N/Pzk5LBbsu2vzxUDCt8G5?=
 =?us-ascii?Q?ZaHRndmTa4OZj5I3R13dtUjzO11s7Lo96OD3CFRncOFU6jZjKHyS7eIVh0U3?=
 =?us-ascii?Q?LyvTYkIzb0ZqtV8cTh0FrFSeTU7T9lj2Oll558kSpk1AjTOYktI0ZaPJjFyd?=
 =?us-ascii?Q?pWWcjUTzsKC0Jfw61PyU4WdXWmY7l3nQ4E2ckrOKK2TOZM4ngMDwvpXY8g20?=
 =?us-ascii?Q?gLZtbjKzXDirLsUchSQpRQCxQCugY+WiJJGwlwI0fj4rM/PHywr4D7UFjwnV?=
 =?us-ascii?Q?ovk9eziAeQ9DyFdO2ldXQ+Sky1h1n7B3KsC3Yf+lLDuLybN9OMRlojqWnaQj?=
 =?us-ascii?Q?DZMuNYmwMcl98tENK4kRrWUv25UIlGvG54K3f+LJZMN3eNXp1Z0z1HktP4Ex?=
 =?us-ascii?Q?b6PO3REjCZCFJ1Apev5gVJQprhzFsuFkm5c8rPoWirkdeoQHCLRbAWBvaxpJ?=
 =?us-ascii?Q?V3VYWwWC5yOLDPzmlOtpiT0+LB+tsGD/PdyytSUb5o3q/U7iLqCxeyCitwVF?=
X-MS-Exchange-AntiSpam-MessageData-1: 4tA512h2Yt2sTw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15379f1-39ac-428b-6817-08deed141a78
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 01:52:53.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIcHxspxoYjYyFMChjyaRCFhPn5kGTsMEW7++GZ+hK2eO5SDGDeyZmhlixJvv0MhqbMLrs94unGTnIgxScY7tBGex9+gAekAVSyEnfU2pdLG8AQdu0EQutS2ea6x45KSdb7eGI7oQEyjWkKy/84Jog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7550

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Frame Preemption Residue Queue (fprq) controls which Rx queue
receives residual preemptive mPackets from the pmac. This is a pmac
concern, not a TX concern, so move its configuration from
stmmac_fpe_configure_tx() to stmmac_fpe_configure_pmac() where it
logically belongs.

Use u32_replace_bits() instead of the open-coded mask/shift sequence.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 3436e962a238..27e500edc8ac 100644
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
 
@@ -68,6 +61,7 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
 {
 	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
 	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
+	u32 num_rxq = priv->plat->rx_queues_to_use;
 	const struct stmmac_fpe_reg *reg = cfg->reg;
 	void __iomem *ioaddr = priv->ioaddr;
 	unsigned long flags;
@@ -83,6 +77,12 @@ static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enabl
 
 			value |= reg->int_en_bit;
 		}
+		/* Frame Preemption Residue Queue is the Rx Queue to which
+		 * residual preemptive mPackets must be forwarded from the pmac.
+		 */
+		writel(u32_replace_bits(readl(ioaddr + reg->rxq_ctrl1_reg),
+					num_rxq - 1, reg->fprq_mask),
+		       ioaddr + reg->rxq_ctrl1_reg);
 	} else {
 		value &= ~reg->int_en_bit;
 	}
-- 
2.43.7

