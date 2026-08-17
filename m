Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD182D877A;
	Mon, 17 Aug 2026 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935750; cv=fail; b=IHMGnjf55hWnUhqdJZtqW1ixD787LFjhsoh99o13/kMdrZrwHZLXYascePBJSlvZpGqxAssaB8FzjKyzVG8j+ZJUXAyi85DcorfAocbujiP7drf3c8qfRKYAycEHkoF9ykVdAPt+qfgo8H9EWTxFWvtRCytsuP4OYlA5fYTJ7qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935750; c=relaxed/simple;
	bh=ioT0gj55fgsXEvFC0snVy7r69Ft0T/p4V07yfOjcS64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIxCoYy2nzrTSUrRMl/8tjfhgFD4wBU13RCk9tI+9lCdIk002usmAG8aUQmvpDtumHvo6dxEHWb92bOyq7AfF3ZF198CyheffnU60/9jhyt1Y+wkGl9usOrHyQU0CVcbHAffQFjIHFFz92w3uMh3qY17c9fiDfwWRtCApgXu9BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LOJSbgAR; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LOJSbgAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fODGOcXHR6DiSu6mwN+J7iMvAg+AmQo2H1bMFBJglHVQCH5FYcIiCippGeVOHNwXZZMVmVCIL34ckQ1UKxZhfOQe5EgAIeCCOzxABJTvwcusU+HVsMOOqn1u6Ekn0T1aNTWmlH7g/xH6bmLBi2c/r+/g9LV3AABDckx4tqn0Bn2Ucfx4o6p1K1tdrUozYtcOZzrqoJhWzSy9ifj1p6KgXM7XyXZQ3qtiTwm7xzc/ilQK+7FzY6zkw36lnU1gFyaAiJ6lsOH0x1r3PAlDeqh3j7XYm88eAuT7LGQKzctwH+S4tSpiZJ7OQnudNKUXJBWPGuqJrUK3b+/zmWUzIK/pHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g24xrXsC/6pRpzRSSoePmPgP0uW6NhAVAeK/MXatACM=;
 b=tT2j7GIFvU/SD8+63w0LEC/e13tccdHHapLW3aHLhWH2ppi+Z07JBGg4kLsbRvMt/gokHaRCWNHhBaWB7zFQZFbTO5O0QsLH+rSBgv7eMtwcEg5sFu/jYuJSxes9USynCzVrpOJ2iMyDIBK4IcMAG5J4emjJB8lT92RZs5+cpa8jA/SMaksUt/SC8wWwlgMfaqQvrMa4ACWrkmb9X5vToUcUei/n9W+XM+KP2tZnW2ksI0+SA+SbRkz5SSwffnELHSt5geo/o1TBqDr5S5LbUiOl/rx46477lTeen8iZWrgzhp3o2vMOxmS6fxQGyKk9m5mP48eO+Ht2fxFRnBEq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g24xrXsC/6pRpzRSSoePmPgP0uW6NhAVAeK/MXatACM=;
 b=LOJSbgARgXsMA9n6zIiI6+R7nt2PRvT7dASZUknwIVumYkygB3kQXykknmQRtrdinygENkVla8csiuU3k7UKmmlUnnkibM0OKQqwrFnZURK5Ii3xzYP+eEU9jX23kf5jojMBB1a4EjjwpB6GuQEOCej+lpFJalaPacHlsJjHuJKlEMuXl2b0B0Vm/CzxuHeoPGJUBbchuptEtaGh/pLA4Mftip7/2xg+0I29i0dbvGa2ZeA9UykjGQ8mmtXMQVPmYEQvwLwFVQKJ7tFIsSpPHTnHgz/Ov3cNDOvBkrHGtE8mjOqW5LvMjBvnPqd1tBQR0ZQhB5XdpOSwDyYKUC5WWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:02:19 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:02:19 +0000
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
Subject: [PATCH net-next v5 4/4] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Sun, 16 Aug 2026 20:02:13 -0700
Message-ID: <20260817030213.6769-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4129409f-2e67-4be6-756a-08defc0bf324
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	8b7VepZoo/zdYp84QEMIOkZilyPfJJq/GzOYv9bMhuR2lOsSQExuKU83nxwtAXHkx0NLWzfVEqyLpP/4U7cMev0VcaLZkHN5a7Na06I4mgrKNVxFcvHYoDiZlWLcv80mc6JkmCFgyoMRZG/Lk8qGtwpehw/xXHg/rypb5xy6mrLCXO/K0Eiaau4TjO4vwTf8ZvTMiXOOvM/bfJyGhNuNmzwW/zEXTk5yXn9zXR6Pac3Z/YV1vYsHF7ZEbq1mOAoBELdO3GidPt0EWq/nuKwA/0FZ0Y7s9aNRXa6gzX8Lf7pr80EGn+vHMaW/6lEYcxTGPWbcCKUmutMLldVi4mcTPIYinPlWhw5vHHSzHQbNhEB3NCzus9ORbAmrLIISVNS9c9udjOmonw+E/BATEWxwyEOS88ojx7lvAYUDELeF5kxbtGx1pQ6U+TfLwzHOW/Y2k+w6TMqJwvAGgJthIdD5s0kmOpUva+zfx5563O/AUbNPnrHdrTRdmL8CNN+oZDkhOfL8E9xuZk+xNQPoMKpkjYojz3FzO05rwo6spzdOFB1fMmgDuJspOGgJ9cPlCf7srAmA59QU1av5AvFz3MRCkpWwCKzbqlYgmhGwOgV/WMw5YkVWoUl1ClGeZm5NRt7TL0ZVUobW4x2A7rpnwj7OySGy4ApRpCeQnTIAtZ5XSPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmASV/Ot+Ca5jvaimPPi4FXNFAzJdTbdS7ctysXBJnwXBoK31ACJ+lLvAjYF?=
 =?us-ascii?Q?hqKovuAwri7iWHJxIjTuXIql3fGII6wM8OSMIcADWSnGbab+ilEzMfImpy4G?=
 =?us-ascii?Q?40sQqwZMx6EgVUHff2GtLGrdp1Pwf4NPODVm7thOqdCZqBm3WoX6KU/4a0I0?=
 =?us-ascii?Q?lAonaRMrjvZrVPWeera9rVLlksHU4yO0s+Y2JRuW998jyyekBVcW4Z8anG6t?=
 =?us-ascii?Q?+sxQN/fHrRo0cH+l1gci/nUExBWNRFU17Lx259UFfBWKMq8k53Og1BIYvflZ?=
 =?us-ascii?Q?s3SFzVZadip05i3MKxHWTSAocHcBqav3VsCDzZAZEFk6olE6jjB5+jNzo5Mg?=
 =?us-ascii?Q?5FPeTlaKSrhTbKmFyCIF7WV9gGOUSHbquD4x9Wa5lBmPdFo60m3mc9i41AAO?=
 =?us-ascii?Q?LJ/ZICTwnNWslGHrbYZqlJIygnhENvgThv+6NmP3bfMYzdIazXawxjWdG77+?=
 =?us-ascii?Q?2ugMJwA6EfeWpWUV+D+ZjfggEc08i303iBRIM4Z0d1pGZ2+7YESLvCOd4sju?=
 =?us-ascii?Q?85qotsC467yR9Fw0YBlfFflLW/QpzwrMhBgLlxHlWZuqUKf6qW1bmLAnMH8y?=
 =?us-ascii?Q?dn0buS5pEf8O7Sd03KBGeoxozlQbi9DcSQWgLz/B1IMg90S89SmNYp9lcb4g?=
 =?us-ascii?Q?RG/T6wxfGw45vWlo7xTMV8jQ/ii4TST+DWKWHjTBPl78HvqIV2qZwNZVZG7l?=
 =?us-ascii?Q?mxNCckMGdKTKUoN02HGp7OQU1CSNiZ1YzYnMifZ+TbJdWtFKyvZzvhkQHOUP?=
 =?us-ascii?Q?+FbESAFg2UrPvlTZ0wSwJtkAfAM1rZ5PTjUFIvJUUzXM3/Hpdgt4l2z5/9rY?=
 =?us-ascii?Q?00urKwZ361Gfs6sbAyH8zUwnnHnB1JAMxRyXVrfHOwd19QAPPWl9DiKpZ7Xu?=
 =?us-ascii?Q?Cnbv+xSkEJTvkakOQRf1vE2pB2I5i1vWL/IKyP2AwCsN7+PMkHXBSsvbBYQj?=
 =?us-ascii?Q?zPIeLzdATHA953qlmZEel0bxl1ePreJGMmI0QI5HkSOgF2zCfmTluhnj/R/H?=
 =?us-ascii?Q?p4k3hLx1MtOt1hHBZaPZqMMy/2kbzSuuae19E1KG6gZU5XgDZptAMsIa7BhT?=
 =?us-ascii?Q?mmYEMrhGWNXawFTlGk1HaArKsy/A5kYB2W5A3Bkn2Vs59E4CqyDcx+x0Wdby?=
 =?us-ascii?Q?zywzSWvYsryeAT96yNGi2VqQjBwT93UwhxR9GzHG1gCRXKOpmbCAF2TmjmCf?=
 =?us-ascii?Q?UyvqSdLVAQRcDIWVY4deNq8GtXl74I2n72iL265iRdbv9zFdZGYKFg64hf4M?=
 =?us-ascii?Q?h8R2CSdOA6vYJWit/4lGE1bj2v9sLUJo7xiBs2ZPyJqyFqk7HTo8wfJwyRZr?=
 =?us-ascii?Q?LPa5Y1YzL2Mp/j9CLfVxJySf/oiU51tpmAp2zajEyU/y8h9EcEiheO7Yk9La?=
 =?us-ascii?Q?lT44zpXp8oO2nqPORM+hW0jyRO323MHcsrzxkoFXpZs1k2hfsBplxWP9/jhr?=
 =?us-ascii?Q?iHaQL2xQKBE5fm03EqflQ0fDSFGbUu4CavGOQBTjHUPseMHixZdZFnX0PHkK?=
 =?us-ascii?Q?A3EgqxscB9FPAcUQZNL//5Ku7Q94E5ecz2vwCPQLZDRSMbRd8XMGUXaOhZU1?=
 =?us-ascii?Q?Evo+5Ek9AnHW20yjDfnyHSSZiKK0lGoSCTy+k08T4Gjx3NECJv53wiD9eepR?=
 =?us-ascii?Q?mGVrQiCgmXA/A1snrexhrxo1/sI+6iXFN9GyAYTN1on8QxHCbCSNwQ3CExkD?=
 =?us-ascii?Q?0/tGYn1n+EfREuVy4ypUqueXuaqknKR6F4NujJ4/+DskS4nUaLVtaBOTtV6G?=
 =?us-ascii?Q?9wEXz3uXCznMFKoFnElckZzmaP6hAWDHOzQftnAHE+btOvuWnBhMrnI7nNLH?=
X-MS-Exchange-AntiSpam-MessageData-1: OBpCMHqpSNvadQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4129409f-2e67-4be6-756a-08defc0bf324
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:02:18.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wg8mtm7CeTehl1X98c0KdwjAaIuw0ZsWAxeEkrRS4mHEYp4Yfab3ZwdLYZzzDrUSUXXfsZ6y51Bk4gBfDHJg4gsNY7SxrCtPveiMXG+Wlsn2ztWD89413M4dUNkRtZHQOJn+tQngst0GTGxPal+HXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355

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
---
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

