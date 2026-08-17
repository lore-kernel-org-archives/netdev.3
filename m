Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAF3B52EF;
	Mon, 17 Aug 2026 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952550; cv=fail; b=BoE88O51dR4neX+74prqB9Y4jmfaB/T9ZLBlkwFbPb+7/DG6bdJBI9cReMhVrnEemHVixUlNYgoA3Of+u+KcOPlVQp2MDl/A6Z0qVdPhm5ibSg2vQEYVCz+oP9YjJ7Tq4exxDmVKN9423+QAJQb//cRfsMsEy2VmHdX/+78Ocbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952550; c=relaxed/simple;
	bh=rjM79nY0IgJKrWQ0h2TJLhByYJuqkr0WO0F76gagV/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEZKcxHXw8l0J+dSmW7uKa03unJYexN0aWSb/2i1LNuiEKnTxUpwIxnPN5mwgpOd9+lliTvoTNwz/sEhEaxNsKTruXDqVSN/6ZaEE6aK27adkc8Vy7RXSvOmdt2OIYQsdllkbYVOR7cEDIf0fLJlW8diw936umlBKFUgNb50/js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vXF5kAnL; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vXF5kAnL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeEhONq0ys4VaR7ESyWOhKDQ+hSR4C5/6lYxSuU9MZlGv33yYc6V7yO6OXOHdp+4zGjLpZlzUnRa4VG9bFOaFPM9P7xIPQtZDTu07Z6OSFmvOP3D5LQrHYsvPwq1ULY+idcCcuuudwmCIHTP8LlSPiA/vTd6vtWPNfp1BrO2iq/HNdTkXNheK/AsTHtNKWf5SIyzLxtS197VZqn5OFmfoF2j2wdiahi7JSMAUDaqig5Iyub3o6JCYYZmCL/BYXOkRDoGM+q/xmm+7c42RuRptU/2xJd3FSla5Fk+unkraVta2t6e/atqhtjLasV6dEdsaRo4iPGk4jrO2pdT8NZnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nB8JyW9WMcJlPLpLO0GshNG7B0XKbvA25OUZF7CBVE=;
 b=Whr6g3lD+6lntpnTgO+fTcpu8lwviNZwoXTKBZTTlU+2QqEE2UlFcuQ3QQ4ebIg1MJ1ErBFSzcKEQIXwJOzgN0zkfR8cXhottX3ocd2byteKPvCKRKSPb7hn8Wz1OVAL8Mo3vJ0u8342tjZLyQFLUaAQbMniKBmmANSUa0dkz4XJElXiPvrqRMh1vQSzIrkT14AzEJcr/3JA0lucKEzdWfYOHQlXiJVXLGqop4ccxMs/yB3FBWM3XbVbUBuz0wL6efWkYby7XIpM0iMMx3yuKIB+xRr+ulqpjBL10u7GXUWJSee+0J6hV50lNBEByA+6Qwd4tKKc2g9u8pxsTGlNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nB8JyW9WMcJlPLpLO0GshNG7B0XKbvA25OUZF7CBVE=;
 b=vXF5kAnLQVaxnpauce8b4OgN5g5/UJJO8L/Nl9ZLeKrvkgujQ+YafAAoDpQS+AiEj/Zqm3MkIJKlnzSPHia0kMiC7xfJh7jkN8gwCBRQW3DL+Sm5m81rIe/QuwVm93EvQEuw6VVV69+WxnkrGlDEFep2TbJ0mcrwH5F2WpCTT0V3yWucOAHOSw1R03vdhZO53VoEvg+fNYXd54FNDZ9iMx1uBwz37gfqtW1Bme11hhGh9RHK8znLe463ZFFLvHoT4Z4f1WMAqgWiSWTP9Enkb1k3XvaPJqSWiLyPXp/KiOv5Tg7uyVtuKEu+gXyKtTAFhoUh4uu7dmSzzsHg6Keelw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB5502.namprd03.prod.outlook.com (2603:10b6:a03:279::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:42:24 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:42:24 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: stmmac: dwmac-socfpga: Enable multi-IRQ when per-queue IRQs present
Date: Mon, 17 Aug 2026 00:42:20 -0700
Message-ID: <20260817074221.27459-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817074221.27459-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817074221.27459-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: d6385de2-cc72-4444-9f07-08defc33140e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	fZinbX85aL0NxS4rAQRpkIiEczI8ee7Di2ifkBLO+nvzxb+7eeo7eKq6IlCVSFyTVzyrtm1pQ2GPM3GLgmS6jyl5xNG0JtPU2hb/nY1RcbAXmoB3O4b/6evjagJG7Q4/4DWoCrpXXSgrY8T2bwQa+549mI3SeWeB3lU/myTEiF5P3QNHrDg1bOnnBqwSw6a4i82PO+9IflWdze6fHlPWnK18eY0s7z2OzRGrrg9hLXpYyVFI5tRauzqZYvuOVv5wj4BnlMyd1MkplMc9UR3xTv97y3AEw/SSBzkwAGjsHwQAxFr1pw1Y6puNiXHrPlh9qlGjcg+hjInwptTLA7y5C5JQqCbLBn+G27DE95MJkBweuhVTURqwHrYyGnLjL3hO4BzX0lDRdkZdytt7GcVKCIeUi4tGp86t46YFiXwvOhlsVj0KiEniMHiYbUjRNS8WBCrT3MAA88W4JA7ktwN3a61gMUEwbHoZzL0A2+gEELeCXQi3UqpA5NnCXSbQ5829HUAplv66MI9ftWNkIyxIYXoOeiAAx6rKOtTHA4p7BqntVzl+Srw/SMIiFDVKD30Zw0OeG98qopHdwLGx8cOZrtjBiaV5TdyNDkL66VpLBIxcWQYCQ+5J3iaTuHjiIDyFw/N2OoASQMhC0N/Y4kRGmnf64RlTHGCm+i/dZe+akq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3n0b/i0sIJlljJlgX0h4HyB1BwD1FSZYxEA964IE5fHfurBSzIqm98OUqZgu?=
 =?us-ascii?Q?CQHFpbAS2dniRlzMfpBDXjBrdduSBAoUCNHkFbkCLJMMqM5D1jp3aLcX/wfA?=
 =?us-ascii?Q?+vZlpoz8Cf8AS16uam06iR42oZtwSa0xBa8SQYZSJxIE+YjVhxhfWH/izeBx?=
 =?us-ascii?Q?QEtxLgtiWxmX+OjVaSBCHVdKz8UalzNKmS53IW+nnDggwwIj0N6TUms8/VBF?=
 =?us-ascii?Q?hl7CLaJy65++0otzmxHpOgGOlaX3PfBd6AbOSv35RHK4yj4mPc58XHvjRWHS?=
 =?us-ascii?Q?ivQFvOSNzA6IjXz6bj97D6/vPKBGJOB+qrW5cUBffBh3IfbGE3sb8CiDd5cO?=
 =?us-ascii?Q?gRcGaDea27KqHAj/vrg8vdOIj/zDfFva7Q5f/C459bvSqDgbZ0fV/eQrQW/Y?=
 =?us-ascii?Q?yRdiltcJYokYTvzUXhfj5ZduzhC08UuyQTdvejum6ugKgomTpxJPVld9CRvH?=
 =?us-ascii?Q?kTxYIXLQoS+lWCsM6sKNTX3rETdpEdsjp9uf6KsRuM0y5yV2vjftOmMVQVaB?=
 =?us-ascii?Q?B55+9INfZx/ycGbHDUmYzNqZJvP9mM4AfnNXcefblPdiXRAbMQOhsN+TvsVd?=
 =?us-ascii?Q?lXd1VCN2YSDo4b1PqeWRzlwCaAfFegh65A8Mrp7gN6gUn6/MqXiS9DnLDTqu?=
 =?us-ascii?Q?pA8A8/v+AxY1jI9GN6u13MZnYqk390UwxuMU6jG5iXn3TvDGzI2gN5Nlcubs?=
 =?us-ascii?Q?8Yy4rXQLQUijzD6u+Ec7tLL7xx1bYm2ytcPWlAPKxrcSLFeM3fEka7L1qpz3?=
 =?us-ascii?Q?cSVvLuPPijl4ZKPzxcLrN24riKcwac9tT5gyFYz2AJXeh7fkDHS0nzucA/xJ?=
 =?us-ascii?Q?zK6O1dERtc5k+M8KBee8i/b2MDQwUQv9xSWKAQb+/txqExekRJzWsbRiyhE9?=
 =?us-ascii?Q?0QjVCTFgMTZW4+QKIfoQ6djX35EDjyc1Z8r+2Xpe8GN6I8xbkTOKXZfeQCJe?=
 =?us-ascii?Q?R6Cw2Vpy2ZUgM2LJokv1AMxVNbtizd6lNs5vXPL42GOPhKOarUhwXzgkCJdE?=
 =?us-ascii?Q?sksqk8BxRwywNa/i7MixxtCAqr7k560gAadXx+Zp4V+i1PPn3oJN0JR9aPAn?=
 =?us-ascii?Q?m/UDsrxfWz6pxhlFCkJ3kNtt4gas4KMl0KQwNw6CL38M9VHKyPA5mrWX91Y3?=
 =?us-ascii?Q?mx1zaBvbDAgL5RpotOu/YlPT7mMNc3DnswmJY6FemrU8caWSZf11eMYBbiBt?=
 =?us-ascii?Q?vdPnOS806yBMyT2OOo0MaM6+oDsOkLuUdvi7UpzHbxPfDtmEzzPBUFeJoBzL?=
 =?us-ascii?Q?GwM9k4ZIFGFDkyne/Igeg1DyVxFGc/U0BNsfCQD2jB40tRM58bIK7nfpG/1+?=
 =?us-ascii?Q?emU1wq7eKQoe1r2aYCo12/9Sp7d+TDWqyYzBUvzH4G56Y+cVDXCZPROD6T6h?=
 =?us-ascii?Q?zoyfXfNGSKx54QId6t4pP0enOm/Z5uuikVs7h4+HbmlPCbkpvYsaBjEzdyJA?=
 =?us-ascii?Q?cy9pDAEqo8FRoJ8CYbZG3wC6XbW46IwJ1upelWuktZxaLRO9JIiJkPv9bhdC?=
 =?us-ascii?Q?uWA4NWpf4HyOM8fpp0OEN2k7KZCai5q3X5WAv8NcB4M4xH3z+ay1o0M4tqN+?=
 =?us-ascii?Q?JOCq1pxckq2W5Vi02SVX5V5fSTblgmvqKj0tGzoTYk8N9aqOgh1vmqru2kG0?=
 =?us-ascii?Q?XFWrrUn+/uuzNyDd9uGHW6wQK0nSlnpmAVrHc9gtqhVpN9Ob1d+UAmPYLeqx?=
 =?us-ascii?Q?MTCQEI/vXnqmgScqyqr2BW1lunYHsl027x2du9QUhXOTSdqt0O2Ed9ODntmw?=
 =?us-ascii?Q?uqtro8+ho9kx0tnKjemKJjm2fUGZgDefKj9uiceNXZchkO8Q4S2nxLm9UIDL?=
X-MS-Exchange-AntiSpam-MessageData-1: FMX2rYDW3fnu1w==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6385de2-cc72-4444-9f07-08defc33140e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:42:24.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acxkta889L3M1uQSRs4uD6o5SAZ84NrgaR/98iqIDgfoBy4cTVqV2Sl/gvhoqm6TWntJ3JjvkQxtEsAjpp12A5fworuZkBScHwIefe4VZC5oua+XR6L/oVrOYeO4Ln8pHNfer55s2qM+SOaeY6yu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5502

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Agilex5 and other SoCFPGA platforms can wire per-DMA-channel TX/RX
completion interrupts through the GIC as named platform IRQs. The common
stmmac platform code already parses "tx-queue-N" / "rx-queue-N".

Follow the same approach as dwmac-s32: if all configured TX and RX queue
IRQs are present, set STMMAC_FLAG_MULTI_MSI_EN so the existing multi-IRQ
request path and INTM=1 programming are used. Otherwise keep the single
macirq path.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..0e02f80aafee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -593,6 +593,35 @@ static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
 	plat_dat->crosststamp = smtg_crosststamp;
 }
 
+static void socfpga_dwmac_setup_multi_irq(struct device *dev,
+					  struct plat_stmmacenet_data *plat,
+					  struct stmmac_resources *res)
+{
+	int i;
+
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		if (res->rx_irq[i] <= 0) {
+			dev_dbg(dev, "Missing RX queue %d interrupt\n", i);
+			goto mac_irq_mode;
+		}
+	}
+
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		if (res->tx_irq[i] <= 0) {
+			dev_dbg(dev, "Missing TX queue %d interrupt\n", i);
+			goto mac_irq_mode;
+		}
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
+	return;
+
+mac_irq_mode:
+	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	dev_dbg(dev, "MAC IRQ mode selected\n");
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -652,6 +681,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	ops->setup_plat_dat(dwmac);
 
+	socfpga_dwmac_setup_multi_irq(dev, plat_dat, &stmmac_res);
+
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
-- 
2.43.7

