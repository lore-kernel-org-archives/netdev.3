Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FF346E44;
	Thu, 16 Jul 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168441; cv=fail; b=Yo6CkoQtoVww2xdNC/KvHJKFs41k4kqrViKRsbUYoLuyTctyMFeW1P17i8+PQhheJ20N+4bzt9eLNguySClq+yp+d2aj0dzBzM49y2a4+walSL1B6kMXBmGx9/+09zxO5ZKX7mVggKME3MhbFH0MqKGvmdifVyw6gKE33vNvW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168441; c=relaxed/simple;
	bh=Mwc9x5HWW6oT2OrX7R6MYcDS2Xb+WWxtU5kvhWYGjls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLLpbyomagrqfbO2p/3UZTXwvKhQeAzxAPIhw8cDawmNji09NpzBJSr1mTm1R4LnsKbvj7WSQlR1MmgvVkowzpiEZeA9ZjW9dnlM1nkIJnkTnBuXEHu+WdbsZiyLOQL8L34WYFCtQiEROSFgetxFjz7DMo1Pq1uTg10PvH6IH5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=G1+BBcNw; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="G1+BBcNw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+bNrStS4tqZSVIBtppG9f2QE8gonpJ+d2KkXAvhn8S2KbCcQD+npop8jY2fKqLA3KKHNG8nF9p2zWQlSf0bZYgfTDl3xYwipNH113lnBmyemNWhl7gjEsmv5jsjZDMCdTspY6AiBfuw05kJF1lkMwosrvVo4ND6knT3JcRVMPtILq3lG9NAczoojR2OGaOk6XHRJhtrAgkPt+WGLCy2XzNFJtNZ+d2e11jMDjaRAC9YJS+Ynx91Weu8/vwh3A/sghtEAlHm15DRds+yZR2BNpiePDFAB8y6E3SKVTsygW9mEUr5OCrip9LtcbOuM/FLzweeTlWqEboipG2QeUHgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/lgRofFXz9lknhkvMqDO+mqU6WkNUT38SiZNtJbtE8=;
 b=l8OXiM2bakU7It4TX433i9/ubHCbiME1O9+WVSVck+YRQ6yQLF3OvY5dy+do/v3g+mbup16AxAjgHBbn4qY0d40xP6xhFHjyT5K3pHVbXkHR3AAdMzLeqF6qs77wGnrF8uBPDnL2mlv20WUhbJyJ78tmTH+rSp/PVnlY2bh/eT1z4Wiv0q6shsnmJl2rtoa63dG66vftjtYlNZFhbS71FnDcbFcteXF3XJK6G6sbEpQ27HB5COE38hEZx/+uovTY+/XpWPEupGMvsIXCylMmw/IqsJwvQDSJ+sG1JgZS9+e7EtBq+v3tC+zUu/DF+0ccdeENi2yToOIXPpCti23tbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/lgRofFXz9lknhkvMqDO+mqU6WkNUT38SiZNtJbtE8=;
 b=G1+BBcNwQHVUNN6WYeUwuwahdiDxscJTKYxaEQcGh5MPIkttuugi+loxQgDtcXE/55BrhCokRvka03dMEea4otABXLmD39M3njO8djIzVVBJViRbKsjTFPjxidxr1IgwnXLxPtCTlCqtMunbFs28DqIbckJ2vwIJm3UnLIn54OV64/Xu55hLi1irBO9RIHsMQZr0OQxBgnfXF2gLvVkRPVTIoKausdvXV+OoY4KFSK6gf3lXnjd56bgX6I9a9pHM6wm6rhRVdCrfTA00vg8Uxk7HVzhmAMfnU8sLPT0R5Z8yyCBIfF3igBMcQ9VvfMJYbPZyGmL/kkJ+wuggC/sCoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH7PR03MB7884.namprd03.prod.outlook.com (2603:10b6:610:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:20:33 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:20:33 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 4/4] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Wed, 15 Jul 2026 19:19:32 -0700
Message-ID: <20260716021932.20037-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH7PR03MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 333cc1e8-ee11-4264-1d97-08dee2e0d001
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	N1JbAwS8dBVeyImkoAZF+9jTQBT7vjYFecX5yYM8xpv/xHKyJBqTvNvFmhLp96+vjHqgZNrmtzQ+pYhSt4D9KLKaVNSiY+Agt1z2rQOz9uyoRHcUTjF1MpSAunM3R8ZEAoe/SiLSz1qwPJzVeBXFi2Thv20OpThfOBSt6BsgV7s0PJdCW/VTmdz0cs4+o04LQSzk3XLfRtzlriG6h0klDw9YlZr6d2ZHfdKtR1fQpnaL5zEfZpWq4RVzzF2PgsT3a0dDm8XtQouKWkNP0iouTG+blioxwnI4NQpw6XhmNF7nN4wGMDd7HYlvIkVKic2AlORCnfD2y7FyHr5PktqAyNiPMEOKIeombczNMJCQJhWoBdbobrB6/mFZ7GwFtx1pVxM2vswn675SZYrUCe1/hMvSQG/GHXofACCTPEJJAy/nZiKoQoQlnKmJFUrsCWq6dZmgZbx0IJmoUqZpWL+FxJBgCkzzrIaDLnGALrbPitOpl7In6LOeB9VER37kQWnf9cG8/f7QIPlx2TQh2H6ThGIL2xJN3LAfND7vQdYEwFWETrVOWWLySfZrii9LIDaHVPHyVzul1sf1op80Ntm4YMmE8Fx5eAJNtkmq0i7+YCV2EK1lu4axerb95cy7dfYgliFgBW5cm2z9FmL/fg65C1HjTBLuQFwNYx5SFiJLXzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9F6DAIvA7sscNCcshFoQRhUz0cRwnjGaq3GjPr9z4BKwcZBamCN9kHMi/Gp?=
 =?us-ascii?Q?nOGHRzJJiZFsmArcvcDPGGoeBehIEt1YNOUM1b3QbXHSu29y+CFWrD4j3Nm8?=
 =?us-ascii?Q?OhU7txuirbG5Yp3lg/QJJXiiOkT5lgqHRz/pU/jDd3lL7IOnwuH2ZbZkC91x?=
 =?us-ascii?Q?x0nlHTvUbY53U3FcCRpzVhsxtZbiwY8jxyxVgzYDt3/nODE65QJEJgzH9oQz?=
 =?us-ascii?Q?kVdwIZKKy8wfg8O4+HlaYPil7OZbevgTiPDNUQqOuRNRAKo8rFNsY01grqD4?=
 =?us-ascii?Q?BJIzqk+QFoSMHM5S0XbpHpJrB/06+ZP/E3BjSB78qmGFwyyOzSukK7qMONTs?=
 =?us-ascii?Q?fHd9d5SL24WNP99xBzKFwg+XsoKYlmL3x6/cwKVzLQOkY67VuYaWwuhDF4nr?=
 =?us-ascii?Q?hrzdO0TNcY9KyXv71bMX++Fdifpohu6PsXg/8fUPM5fC4nwehHEszbCBBiFF?=
 =?us-ascii?Q?kqL4mDJWFKHbn0558LeZywX3fW7O7+I1Fd7z2YrVMcW6gKw2t4+WRVeoD3jA?=
 =?us-ascii?Q?PPbtO4ZCAZGmtOn5L4RMjrBD7vTu38yM30gwUL/+FeX5L3i6yWo5Js7sEh1B?=
 =?us-ascii?Q?HVNAJ5YsipgOYqUvp7x8ZVHoJBt4xITIzDFeTDQBN3m2hKZ2fRhVeQob+g23?=
 =?us-ascii?Q?Muy0E+xzqxB/mQwlr5bWO0SPwELkPniZzfkwMd3p005RaPYH4MEMQmlUwvlL?=
 =?us-ascii?Q?K8/Lbw7d327Ey6CZUt5wkjJSHfGU88MlZD6hNHxCQPJ7dDRNtYjL1DabFjB+?=
 =?us-ascii?Q?dinyq8EI2YWh/mlcH5UIkuF9tIMFJglxOfp4hGL7XNRIN2bmdC/V7FGxNxtH?=
 =?us-ascii?Q?yjfL/CInt/1B1uAfvSM0+X3PBHMgaC64c90S/86Qx9NEFEor1pHXp69XsMrh?=
 =?us-ascii?Q?wVXVmd5mb+bdNpgHsGvnxEzMauN//bBqZtmuBT/yy2OGXmQYpwqPjzzmfcCI?=
 =?us-ascii?Q?aBcWy221HpR0zd8gur9DXpqXOkVfGhyA/+rvfnqO9aY5ElHIAZh9Bw82FaUj?=
 =?us-ascii?Q?0E5tinHmHMczH4dQn+t1NNlQCCRQgckFwDLKMVJuDiVxG75YysHQyVWgeUjh?=
 =?us-ascii?Q?PtMWwrQpbaGmAOGE3d8WJYRqKjtzk9jKMNVV5L8Q9O2XdlPBknHvtMgoBiRN?=
 =?us-ascii?Q?E45SuYURtno8q5oM5S+zT33zjBW3/CY0RLHWsnSKawtbAB040rEhynqCgoWl?=
 =?us-ascii?Q?WD8ioW8vPBNm2d9JVt0tYZASDIfeEiTID27PY9qjqnL+5O/8ZUQuuS0VKL3M?=
 =?us-ascii?Q?ANlKRlSjkW2jpGlqYPF2mod6F6IUfv5a0DdbVWtvH+dVlYdUe06YDr6FfC8f?=
 =?us-ascii?Q?OiEBId7LTmr1abHE5vZdGQXQRASZjouZref/zfzCIywjGsFIR903pALRgjx7?=
 =?us-ascii?Q?JN4dpAX4BVzOELWvuN2tTk1OfzB52Nko2Rt+EnwPt1TmHBk3r0HPFPkCTrJx?=
 =?us-ascii?Q?JCQsKaKlk0VPYcU/CJEzTrXWxHrnPRWvJRe+4m9d4b9fhxigJ6pX4IVNIA9V?=
 =?us-ascii?Q?YhJjkZ5EO968hQDjcKYOCqIUGP3CK8Yy+gk0uYHXFndqSyN6Bb3w0tK+eYu5?=
 =?us-ascii?Q?QfOJuBKHoCbLoNcAO64dlfBdfs9/hitMaHCKue4ab3PjSA6LcPqSFZsLkMib?=
 =?us-ascii?Q?9IAyShgY0ImPc2usBhlgN5LCokqn2NzTFXuwRHlPpvNDtES3qZrB2YG2r8T3?=
 =?us-ascii?Q?byoy9J5TuKB7lV6RRPxRVZaLgxQ3aiLXbGhSVBdn5pJdYlsidma3jUGe6DMS?=
 =?us-ascii?Q?mmV/TZVQmhOky/BP2Oh4G9ZLqo7TMR8frslAta40KxRNe3Gqjtr1Vc4xpcve?=
X-MS-Exchange-AntiSpam-MessageData-1: UaW5A2DsspcPEw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333cc1e8-ee11-4264-1d97-08dee2e0d001
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:20:32.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOgCYkpMulPdkvX2h53eqrwGkvrzPH/11Wgyu6ZhTgzdqrkQ9I8n5NnZv5odpgVa9x1VQlETUa0LzHpr5TvdiSkJktqy6f5oAoLgZPDBFpErChXnIouMpgFNHm0FTiTDen+XOAG3VEhS/Y6ZxxRwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7884

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays, so the MAC interface selector
must be configured for GMII while the PHY is configured without delays.

Add the "altr,socfpga-stmmac-agilex5-tsn" compatible to the match table
and detect it in probe to force GMII for the MAC interface selector and
strip the delay bits from phy_interface so the PHY is not configured to
add delays already provided by the FPGA converter.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4: Add Reviewed-by from Andrew Lunn.

 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..bf591a68502f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -69,12 +69,13 @@ struct socfpga_dwmac {
 	void __iomem *tse_pcs_base;
 	void __iomem *sgmii_adapter_base;
 	bool f2h_ptp_ref_clk;
+	phy_interface_t mac_interface;
 	const struct socfpga_dwmac_ops *ops;
 };
 
 static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
-	return dwmac->plat_dat->phy_interface;
+	return dwmac->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
@@ -650,6 +651,15 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
+	dwmac->mac_interface = plat_dat->phy_interface;
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "altr,socfpga-stmmac-agilex5-tsn")) {
+		dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
+		if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
+			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+	}
+
 	ops->setup_plat_dat(dwmac);
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
@@ -674,6 +684,7 @@ static const struct of_device_id socfpga_dwmac_match[] = {
 	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
 	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
 	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
+	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
-- 
2.43.7

