Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6A356A37;
	Mon,  3 Aug 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727449; cv=fail; b=GAuPeAKE3eHSrsihpgnWILEyNOxn0SBOeOAtTyyK95oEigIz+Fy633XzYH30y+qoNFGj2TLodPYOChQp0fLoAM3AbHj0+xZJlfwbb4RwOiGx2Mvyu2qWH2ftw0dk5CV50n+1lUv3qxDibcIfagoTPgKUPQ3lyxcRkWobTtexYd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727449; c=relaxed/simple;
	bh=Cz9+aQ7A3R4TquBkt1iVba3/QJm3iFEgVaiLznNloX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlFRH4ZK4bB7L2+jZACOa/F78QfYsFUcj7dtuL8EHXY/zkgS273mAWh4AT5j1pxtTY6QPI3myFPEL+fw+NqxwyXA7P+h4kHaUJIhEX/SvNEDUH8aTB180ZmIfgomid45Isn3JT5gRC7Ho5pGZdRtvFn5fDNJjp1o+cqVtyaFr10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iEmBY+XF; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iEmBY+XF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAdmh2tzX4u3lNBHRv8TvFI0AbnQIPDD//s+idNq4oeigMld856NwqFUUzc2Hxcoubg1J2Iu0+aa0n+YqEkg+65K1MUUvt3MoiBwKrlPTV88eYPPPxRnzdWvXYq8poVgKHf2k1VmSAe5HmvNspuDQknRarJVV8RlADmM7oDwdaXICiqvkYFt5JSPNOg/Kus16psCClLh+WrzGtbh6hIn1lVBVeGJa1tRDQr49ABxfWLUKTZPGXi45s9o+2MtDliiS8cWQ7iIkIMZKb/GmM5n0tLJc8bcWLkDpqWIC6T+uxGm9Sk8rNZyELbJT1gnoVbOWDyNmxAQPGIEDlH6pJERng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Dnt0NQ9BvOA/iGDesYO2OsRJRWihUzCGWbUvuTy5U0=;
 b=iUAujmgtJUOw9VqpfPcLMuqeq9ydMDfsUbm9G2xLJYnz8FPQQCzhkyWRXiNI/MdbPQKKsk844G/wbQgFJlc/8AlQNXiCc8ERCcj0+8+CiYT1WHvYyaW5oabZuwaoBEt+aKAdeCs9zJ6U4t7Fbpvr9sDS6abFl+XAEBtLuD5EMNQIoENX9UJtbfHK1rG16WBGBWWIzo22XvbW6QQu9SkokLD7K35ogJDllP/csQ7GR+WUcejb6QmOi49QC+EBRNPPsuVuQnKCyJhdgKr+9cin38okhbTNxCCtYQSDliu47mP5QWSZeAuk32LsGiSjM4vP2s4m226DLDpw9I1xHSmfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Dnt0NQ9BvOA/iGDesYO2OsRJRWihUzCGWbUvuTy5U0=;
 b=iEmBY+XFuMnDRclLoOxJ/cxmmnqmG2yBL7Ve2uvlMkDFwHV9aQy8W+jnlU7k87Wf8OJ3zbXav4gcN/8bAW/uwzAQ2eze35baF64xeLVk1XaObmQDtd3Ga6zo8aHxry67oH5KZl84BF6JQqFqrw1uggOaV3BYdfsRuB+K3+iSfwowZvFWSiAoR/k/3pxhKgtUIOnxg8VMZ0bimzzpQvynJACw7Z1upowFeMzzx4tqn1DWVKAdktoKOhS4URRlL2kubhxOQgFfqU4IEJyO21afH5Usb9bU9U5U+hkXPiIcICVQoNEL8b8YCdadBoYQ6s48TLaYJ9j/1+XmnpY4BxFrKg==
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
Subject: [PATCH net-next v2 2/3] net: stmmac: fpe: Add missing return in stmmac_fpe_init()
Date: Sun,  2 Aug 2026 20:23:57 -0700
Message-ID: <20260803032358.16282-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 89a6c18b-708d-490b-ff84-08def10ea982
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|11063799006|56012099006|6133799003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ML+JwpmWg8FhJ8BvH3ZDLXUmexXFwvIpk+w/7QJzT9X5vyedLbZqaiP+KCJzDv8cAvgrB5TcySuaO+AzGTmna7Kt8PZXKlGzzn4r3U2sKw812uDO2qoMTnCj5yNLdFPHIpv7PNPnP729tVBiZncbNpKEcrVN3fmU2tldTEW6TxAb/YKfbN5F3zJ7xkMR7WXmoIqbN6VaHP2JzUpUa26mK8OKIHOFkUkeQxh6rrt756LESqJJQGXZAbb8cNkPZwksUH9tv3+OApF3Omd+GSeo2ULNNVIWF2kedx4Xx83nGa10XonDKtJ45i42rMpbPhF3iPtv70pStFma6W2UnvCQ21SkznkGYWMv8+G95G+Us3gWaM8+UdlbvXHPyD+vxuMNnwRMX1Pl3GaU5ffrRiZjt5QoIfcsU83J6r4gAqGv3vsC4GhlxGnXGscOG2HGTWDjC9mx084OHEMMjWoMu8thYy04Y6Pa7tSGl8k4zhAuC290Y6lPFqcSZkCC+P159ExtKcQ456fCopxAlDAJs8t9lyYMjKQayBKfJTTYiLFCKJ60rKMiS+ZRGv4SuHWCr4L59hxLfLTCjZdtRp/kYSlsWOT2GXRizVJBtk8Pti6biOixUsIeHwvm6MYiKDF3BOsJld4/2l2CesCK8ZmK6e5gAR4TJGP7k4ifN0JnDdY7d1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(6133799003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uke3t3ETQmuwX+wY4zr8Lyy+wo51+WV/f2AcFLRvcBcmWKcZPwJVTzQc8GdX?=
 =?us-ascii?Q?iIGEWcSdwJIt0vu9rtP8Na566FwELU3ybPdYYzgiPL0K4aF2zWGoFq2a4uSk?=
 =?us-ascii?Q?/74Ls5EErMCWpr+uh21VwcUDxTVc398GqidkDqQ/lKdw/q2wyVVDcEOX7XEP?=
 =?us-ascii?Q?Qgz19fLO/sUHIGJekFCLxV8cvlfbsgEGnzRexxziccVR2doriSsZl5Hu6RJ5?=
 =?us-ascii?Q?aifO1lcdn89Ju6IPeOgW0VVSbdcXwdFEHXvpy8mTFr9BjJnyoN4Weu4lTHdW?=
 =?us-ascii?Q?q7dgYnS2X0+MeNXwzVb7rYiKw+EMeLXvc5RwryS1r8dk+cQd4XMNg5VeQz44?=
 =?us-ascii?Q?9rF5aPHJsDS27jKdTZ4cSVyZLf3nF/5ue1dZQ4MYKNtobgQf3U5S+aKjoNY2?=
 =?us-ascii?Q?iSpkyWihl1GMrXme0CCqpqA9/kyTPME2En3LU68b4Dct8BVIlmwswAwK4YcY?=
 =?us-ascii?Q?+EzB9SHwVb3ECInKdpHy1J4EORYfyWvF+RKTyooiXU8yQ0bqr1jnYraDSBdp?=
 =?us-ascii?Q?RLKHlSbR1/NPTHQ8b/1/ZPtkvSF5NbUFvcvwOGP/mo6qoFSt/SzUVOljYABu?=
 =?us-ascii?Q?NS5tzrtFx1c/G+bBRWIPM647cavW/zKdDjxNrojXEX/sXK6KnVtYTP2yVpNH?=
 =?us-ascii?Q?EBwi5w/L5w2dqDdcks0Kt2u/P9gtKaDmW8FxuQw76AInJNsU7JDoT2t8arF3?=
 =?us-ascii?Q?HWLzAat6kRlpYiCW3UoTxVpEx5y+xitYzFxBf6oKjMZjj987amG4l8F9fmzr?=
 =?us-ascii?Q?zsm6dT2cjyz4iJG8csaDQufXJktbEW49s41LMoD8NN09O/JcThv7GfSpGvas?=
 =?us-ascii?Q?xLocO92u/VJ69FaoDlLQxThbWzyrN85OxBP5whFUhVytUCW92Vfue0I4q536?=
 =?us-ascii?Q?vEPo8k6YPYUFmDgWSz+hbjwUNy547VYF79nqZnACDJUD4bY7AXhvE/JZ5M5D?=
 =?us-ascii?Q?KDs/muwwlH9ClErF6b61rRLLq5nN5Xv023HsBrwmJubrU5Xws1UUP+4TGm4b?=
 =?us-ascii?Q?7N5N5M0N5GaV+RZS+1o1v/PhhbQjLPA3PV0EfoHvl/DzFLVBcMbkYP49Fi6E?=
 =?us-ascii?Q?4Gf/GAKbEBLLDeUTmUcEWVkz/X0TWf5KLO+fCaA4xkvpWxDE96tqrfjjWQKK?=
 =?us-ascii?Q?qATgVE7OTw4tSXfnC7Nf6U9INIDsoYIcUTtp+TeprgejJqS/LH3IgJ93zGvB?=
 =?us-ascii?Q?4i1Chzsr5nkMAffvt52G/eRkA0eAAmrDNkR1g1AsTLGFuOlp4EmlGH2muEY7?=
 =?us-ascii?Q?QPygs9+5TgPTay2a1SSSdbZooR8BMFizkAe1bl3zviYeSTwkG5+4JadxAhZj?=
 =?us-ascii?Q?R9BVTvD/QXGiO331UqAIthqUdtuuBkeo7pvzVyIWVs5dp9mGEFf0PoIwrrmg?=
 =?us-ascii?Q?/t12gOHtGAi4Xp0/9SErMSvmwCn/rrAEos/2O0X38oepRyVs/oxrePVlsEhP?=
 =?us-ascii?Q?DNx9oZtypuPCXRcPdqWJABqdIDZFwJ6wGt26//CM1icxrxx9/QqFXnMRFeI9?=
 =?us-ascii?Q?Efb4+zIwtigBPoinNmVU4k0pentpnGOH5ae1RdI8AxSObKfYoUPOSF3JuVBE?=
 =?us-ascii?Q?UzLx/zhdZBeEQURFvGiocQbImffTvRegS512bEm8ncEyJVjJclexSCTrgixc?=
 =?us-ascii?Q?Nllzl2br5mG0wRdrcUlDM//ke0WBuvolR4d51/N1OTFnTrClUXg+TMJsMsMi?=
 =?us-ascii?Q?fugLX/RRw70arVVKoLU0UcLzHRDypoFSH68MZlto+w0vnXxB6vsVTFe5p/HH?=
 =?us-ascii?Q?Auuj4yvFjHsWOUpapeLhRY6VARMwNYv1N21EQb6f8qnmm5iuyORFWRln6qpp?=
X-MS-Exchange-AntiSpam-MessageData-1: Z1B/BOZtyy7xnQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a6c18b-708d-490b-ff84-08def10ea982
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:24:00.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wG5MNiSrGWyf4mPBGy7Pn4c8fIhhDBz7b90A4i3bxztzIF2MTkESC9faOO2xy1jxiKS8M9mBmc8DmivbRSqUKJJdhY77oqqFfRV2f2DuSOb/m3BHmJEpUCNAnRAYmhUrc8Juctt/42D+eW5Vb927iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When FPE is not supported by the driver, stmmac_fpe_init() prints a
warning but falls through into the pmac_enabled initialization, which
should only be reached on supported hardware. Add the missing return
to prevent this.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v2: No changes. Collect Reviewed-by from Maxime Chevallier.

 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 2f880c5e35b0..3436e962a238 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -174,8 +174,10 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
 			  &stmmac_mmsv_ops);
 
 	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
-	    priv->dma_cap.fpesel)
+	    priv->dma_cap.fpesel) {
 		dev_info(priv->device, "FPE is not supported by driver.\n");
+		return;
+	}
 
 	/* The preemptive MAC in DWMAC is always enabled, so initialize
 	 * pmac_enabled to true to reflect the hardware state.
-- 
2.43.7

