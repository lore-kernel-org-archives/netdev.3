Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335D37F012;
	Wed, 23 Sep 2026 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129918; cv=fail; b=RwhSsoJ7f+/jx06G0ZhnK1F6RTdFVvfQETlSEbk5utgtOAUbdPdlyqF7V5JiuUEVgX2/JvOSm2KY2rF+Nb3axtYYIyb2bw4JP/tc6fc3ujMh8FfU/3isdvjp6ZfD6XOEXEpz2HI1nVWScuH/y0frPhwK4Xqv8eOHWe8U+RBlbmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129918; c=relaxed/simple;
	bh=my4R+2G9KggugKL156I/WQFVs1L5+4gV5S3JBSP9xuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeZJ0sEpShJjqA9GeVy/cv2ooI/zYTmpR5PuHiy40z4PN99qCOfSnCosZpkhGuyCkbO6Wb84PLDiv250AY5khauEleBeGutyDzoizd+MXlb6hkNOrI0lvN8RwPYc2RzW42Q6FF0R0GTkzwRFwhtEtI9w/eNyC0OUFzDSi7lBm+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fzHdqssF; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fzHdqssF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbqFpYJZR6SooJf7C2EvZJnibXe+Hx8RwNNfboONiva82itlFa4RYD4Zbur8tPSCMk+kot16uffRJ3UCrZf9g0xhrFAL1gfwy4/GvU6Xf1PIjmiqrfQytfQ/ZXDl3cqB5K6is/+MLfS3yCNB9qvV4mmJOz0UIpyEl38ONBBXFjCeQzRRFpOUy9zmj1cGpYhNq2o92XTQc/6rflORBarkcP72NaFspQo4E9+ji/YY8bS+w0vlh7cfO7L8Qf6j2jKV44VYPt8I7lSmK6Ie21SiM3idWxStTRB5JzMGaHutKuPxD4oZCPAi6745iDW/YtYgleBr6XLeltLtk/Mdq1sFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFqfgBOVv7aw4nPguFBah5aW1GNEjr9UNtf+zXUFQ6I=;
 b=Fv1TCaq85JflUYzOIgTVhH5NtFZLYVk1LQWFTbEKzKqTISvF2vIulh75oykzu5WicMToJJzBfc3Ab21brgPnEzyWNNTMRWOwO1/RgamTrreB14xOcYo+3YL9Eg39iO2MjxGicel/UxBrizaiJorkJ/zy80/k2ypz0bp+iuzDXlI1OQbEIweBeBTS3SzF7DsuYa/OeBwaUDIrCwpuAvkST/YxTWnWIhf5NINM+gEODNydDyHKZTMQD5WGAdaSvDtWjEgh43yKOcNY99eAUx94njSFHXNnC3wvgVZcb9ZQDIyxapvvGl5EG/l6dsL1pMFDovJWfE+ax4qYmZoO2Hh/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFqfgBOVv7aw4nPguFBah5aW1GNEjr9UNtf+zXUFQ6I=;
 b=fzHdqssF7fnAZ5v+CD7YF2hyULA/aBHOLhJ2wG06bgYIh5kIb+Nfqah1Ufv0HjTE5YNFehtcuUZw4Q3ujBpdARKISNxWZFxce+yeAmlr6yP/VBcjL0OBE0e6A/AoaYp9RaDvhb1Ty3JWty5G4drTrcP/IXUPyelJp+Q0pGqnQI9oA9G/xC/vfv7fHgkyT2Ta19agef7hf0ySj/0K/LPoJ558ipOv5G97LHrBRt2pVNfWo+TcOWO/R975yFlNw6o0xUaPoDtXnB0976fVU9XmRmwGSiLYXZ5milJtlx4BkABCPEcVxC+m1AP+h4nsHZEO/GGycrU0fM2kiKL9AX8ZMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by IA3PR03MB8024.namprd03.prod.outlook.com (2603:10b6:208:50c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 02:18:29 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 02:18:29 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Tue, 22 Sep 2026 19:18:23 -0700
Message-ID: <20260923021823.46649-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|IA3PR03MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: f521240b-19e4-4450-2a5e-08df1918f441
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TyXQ0pSqLdBux12Ihal9T6MNfPvg7b83qOgigY02uGhxbOQ84bzf49EtKtYf1fB4qxRfdMa5zQta0ty2oqMEn3SvmuJXGLKKfESYQBRi9NCYGa+cHlhWgNpkIrarH6OfttQIPLdTZBgDe4Piw1eSkd+7Cyris6Fs5vUZUQ1Ric8J0Npc6/gHrmU+gPPmLuVTk13bNxnLsuJc5CyNord1lraU0qCiJItPuoUqZ4mhL43W3KktlYQzlCBTWmmwpUhAasL66R9ORAKYVsnEs6fNs3fQSgwByudlNdN7i/puuiHoV9mMwM3EaBQqItodyVI811/iDBNTkyg8tvI07jM6N964WiRxrja/umd3voOpg+CF0wMIK2L6kMP2WhdzhuevHJ7TZHOcL+hKa7ggQHEv+UqpSHXeHiohvFUV94ZateMQjlAodXdfNPvG6cYG/4M1HICtrSKNrA1nWJTRMQ933m8TQfChVUV+jlvSb7jM1Ko3BU+eQhdz2KzGweiul2Zi0SFVFayv4ZxQm1GRjLb+ZJO9+FzpWDEiV8JkSJV86hfo8zjaghBaYxyglCag8oOrhfE0u+0rkPorwLQL3kHYgHvzhMX85WbjMKqxAg576djC9gZfEfud2fAfYU1b8suAvgvKCRbKvzP4Uy5KyzfhKVqX3s7Ss8dORz7QSd9nhNc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gnx+JuCswo7hwZpJXC2JYh3im30P+SOZwZZzA4i7b6q0xiKfAkJxLvZTC0u7?=
 =?us-ascii?Q?eAxLxwHpCS//mVOZ9kuuVpOs0oOXHi6ieb/3SVrRrQ0EjXx4Cuy30IlHn/6n?=
 =?us-ascii?Q?9ykLRB8BVyyoo1pTceZ0tMouSL8kCf+CzU1VxWJ43JCGxCaLcV679yZeP3KI?=
 =?us-ascii?Q?DHzu+cHFJd8wbR0BrA0lIbaR/x+Nv+Dg9J8oTO0VuqJkaHCJcuN2POwcwqSh?=
 =?us-ascii?Q?zDsgbcC3eIg2M9Xh3M0nHb5HV7gCf7DyD8dpetwX8N4lmVs5cRQJrlAbY19C?=
 =?us-ascii?Q?2g3MlqnIqZO1faYdLk2TQuLVxffOZ1ts3KgHvAfQ10cKqOlYelRTiGVPEOCd?=
 =?us-ascii?Q?fl1lJNSATeG+8sRKTmofJz0nTnD2uMfYrFLB2X3WpVqBKwBThhV2bxCvdGY4?=
 =?us-ascii?Q?xJseYeSkaGWgLQrmc8PsTPGhEI5TMQiYjt6MRBTyAlbo9HQAm0ZsuXJA3KI5?=
 =?us-ascii?Q?AhYHborSbEc7KytlNW3124ELtgmWTNRTcbYr6c5+7BHOXx/L893bNSd6rHC6?=
 =?us-ascii?Q?jAzRdpxPMQBc1+dmfvhHwD7DSB7c2faxCzgelCjK41bGeYdcf9zrmNO8R6Gb?=
 =?us-ascii?Q?HR3TaNRULfsq7b9Txrnm2LSM0+B/D59/ots24XA9UPTW8QKDPHf6kdB/ey0k?=
 =?us-ascii?Q?/eIcl2pkRgGArqda1TRyux9TeokeGFsUo1SvxxgkJAyNRTFazK5ap3I4ml/z?=
 =?us-ascii?Q?djMoN0JGuY9FieVc5xDW64clgtcukrk2zJwYKLK+tnAovbQL482XEoA+NZwq?=
 =?us-ascii?Q?yKUGm7BjmyYt5/Cp2Wf/KLY4eMqbwWCc2HBr9/nxxIAChLkc6FNFg+Br68Ox?=
 =?us-ascii?Q?6pdcyqVHu+B35c1+1DWPS1PdvAW1+EypegFdD9Zuc8E/FPqn7cr0tdjzTQRm?=
 =?us-ascii?Q?SDza0S+vJjJxCxfPmvRHKRXaHBsOw5U8eS/jFi9aMJbwPIwL56Xo++3iO1Ya?=
 =?us-ascii?Q?Iue9ojwd8aqu+oWwxCGdpsNv4vkH6gp46SAXsdwiZqp+44nVAJq5UB3Nsmov?=
 =?us-ascii?Q?JIsODk/m8X7rVhxtgZiCId1/S5dKjBNtTYVBJd9SIpth6xWLkrk/J0fkVqTy?=
 =?us-ascii?Q?+J1pJwDbUyihR6Oqq8Rm1jfb93gcSllkggoNGoTr5BqyxpdFWA4+DbEsELdE?=
 =?us-ascii?Q?sA7Gxq/fcfrv7gzNIC9ghQeukuZY3Jd+ytNVNGajsPtjnmHnd3gf0s9O43ty?=
 =?us-ascii?Q?0MJRdtiJjHPsCDtcxNSt6OZSu0MdQmfXdYrsjkxHpNOrwTmkF1Dwi1VAue3+?=
 =?us-ascii?Q?XoJzKKKsLYTU7wxqxBUGJDM4D3OkH3JHgysvAupSnBbHlC6+S0+c1Vb7Y7DG?=
 =?us-ascii?Q?G5rGDurbzPgNRXAYcwSZ45LkMW51FOqX90nGWz3qujrY5+SKJcx7DX63dwEm?=
 =?us-ascii?Q?S3DlsgQ60oeRGxeT12wAM99jfrjyFDzR1D0g8/hedrgeVZHl6ubJkUT16Dci?=
 =?us-ascii?Q?qN0tCvswFsDQVYp+erd8RFf5p+zKT9ZfRRcDCJnJ+BYt/RtIQ3E1VzFjtkT4?=
 =?us-ascii?Q?Om9eJ3mci1A88jlcvWpGRNDR9UhcTSmMXMikbvPmWYU13zruBppAEEEc123e?=
 =?us-ascii?Q?4SDaTbShaKpE8445WddwsBF9H/fgnQh8Q8KHaz0t2ksxEahsjNfC3ro0oEnD?=
 =?us-ascii?Q?+CcFSwOrYL9ENoMpfSVBur4sVmjvqEPzJ5QCjo+94MQKiUyxlWgQ7vCSX+rb?=
 =?us-ascii?Q?K5VxvYcry7iMMe0gvbXR0HfaeY6VvOwux29CBHs2HG+7h51VHllKqKgpG0PM?=
 =?us-ascii?Q?5v704FymS1KpTRKmCBrLVupYZhZCcDUAP2E2Ii43PSC6OQZzh58Z/bgS4ENK?=
X-MS-Exchange-AntiSpam-MessageData-1: cFPy2BO7w8clkw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f521240b-19e4-4450-2a5e-08df1918f441
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 02:18:28.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBIQpAttTVSVm/smclpWsxAd0dzlrwSNO3766XTwFxbRfnXH79E7EA5PRfYnwk3hYrYEdS+STngpbEMNiWj0SWCViJQdY5bPXHPVTTCN5dC7d96rspLEJwmuUAflHNQo6nPZ5YBABHUeTQdGBzjbuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8024

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays, so the MAC interface selector
must be configured for GMII while the PHY is configured without delays.

Add the "altr,socfpga-stmmac-agilex5-tsn" compatible with dedicated
match .data ops that extend the standard Agilex5 setup: force GMII for
the MAC interface selector and strip delay bits from phy_interface so
the PHY is not configured to add delays already provided by the FPGA
converter.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Previously patch 4 of the v6 board series; split out for net-next.
Add Reviewed-by from Maxime Chevallier.

v6: No changes from v5.
v5: Replace of_device_is_compatible() probe check with dedicated
    socfpga_agilex5_tsn_gmac_ops via match .data, per Krzysztof
    Kozlowski and Dinh Nguyen.
v4: Add Reviewed-by from Andrew Lunn.

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..0632105b420f 100644
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
@@ -650,6 +651,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
+	dwmac->mac_interface = plat_dat->phy_interface;
+
 	ops->setup_plat_dat(dwmac);
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
@@ -670,10 +673,28 @@ static const struct socfpga_dwmac_ops socfpga_agilex5_ops = {
 	.setup_plat_dat = socfpga_agilex5_setup_plat_dat,
 };
 
+static void socfpga_agilex5_tsn_gmac_setup_plat_dat(struct socfpga_dwmac *dwmac)
+{
+	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
+
+	socfpga_agilex5_setup_plat_dat(dwmac);
+
+	/* FPGA converter supplies RGMII delays; MAC uses GMII, PHY gets plain RGMII */
+	dwmac->mac_interface = PHY_INTERFACE_MODE_GMII;
+	if (phy_interface_mode_is_rgmii(plat_dat->phy_interface))
+		plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
+}
+
+static const struct socfpga_dwmac_ops socfpga_agilex5_tsn_gmac_ops = {
+	.set_phy_mode = socfpga_gen10_set_phy_mode,
+	.setup_plat_dat = socfpga_agilex5_tsn_gmac_setup_plat_dat,
+};
+
 static const struct of_device_id socfpga_dwmac_match[] = {
 	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
 	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
 	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_agilex5_ops },
+	{ .compatible = "altr,socfpga-stmmac-agilex5-tsn", .data = &socfpga_agilex5_tsn_gmac_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
-- 
2.43.7

