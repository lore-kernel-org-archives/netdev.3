Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B733A1E81;
	Tue,  8 Sep 2026 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851222; cv=fail; b=h1QJRejDc3z90AoTxfhjUMLtidSyZHtkfAG2JDQVZJSmbaJetrdWgPmdgch0YmJtPDpwCZI4vAb52EG/ntJ9wT/+09hHse3ujFT77ybs/LUQZaw2cVqqq9zhRbOSwSMjzDGcUpOLB0UJcskx1sRq3dXBibT19ct7RSNh8XYpWjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851222; c=relaxed/simple;
	bh=ysRHlQiFm9AEvhhcc/kRGn61O1KqzgnvPaPwaleMVGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JEOcNwov57V1htawG7wFPU3+7+eqvREvQv7dkrYEaQrbCUllUuE7Bjbyn0mw1KrZ399uAC8AYLoov+zSWoTYIbiJRxGefdw3inRw8PIBp+8fvgLhVGQ1Ow8CitBIitJHEoZTJ7c9PpuSLJQZXGz4zF8JCpOg8rwLlkquZNB/NBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dc1/1Pie; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dc1/1Pie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPgg/BPkCpF//11vCwv3C/e2iDYabu23n98dpz+6X/tBZoIMcl3Y41IR3k6Y+CBKcmEoEvMRtbTXehORS9IIo3bmDdtxRtBzE2uxrfwpHV6JnQ2FMkNt3nRz8yd+htFgdsF/Zz1kCO9x5nkwPnh5fu+2t7oQkwJ3w87c9LnB/elZfOVyeCsXo5iOO392CfWejIi+cTFd3TDacHWhkaGgtNErByjmM/X3Ov2vXIStnVNiDxfpw+pQO3ax/+Q9UYB4WnL8X2DDlWNNjuFTmBJcRYgVMGi6+Dm2EvUw2qF0coJzmXGDGtHRhITHCbOXOzisw/bSGOhCEghUm6ksH8Rwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDVPp9EaY4cvm1vODgHTxHMD89QBX1qhYtrWZWyUMf0=;
 b=CV7zijep1T/zR8dt4QoGhHGMDXfyyWpStfJ7jN9qn0oB3+5pW+nR5Q6Y+/5GjiVgp6Z+TSRDUImT2GiGiJTV8acNYxWNa6Dt4oygzHx6Etvv0lr7H/BOqKoq/dUKSVHWzqzPgNFBS4iwK3TR+/HlxLWMZQt/7tqFX4sTwPWTqauSvuvd4XsOVp2RCuo/rMTJQHwkJQ4JKTK1M8vhylQeCDV1MKZfY/rH4ShvxDlqwOVMTz4PYpqwc6fPSzKQKyDupsxUZWrAJ8uAnq5X/ES+9oaYOVXFhLMq6xg7h1pZqY7Wkgg8v1IL0NLAecuGVE8TQLxRxFROV+Arl0npcxhvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDVPp9EaY4cvm1vODgHTxHMD89QBX1qhYtrWZWyUMf0=;
 b=dc1/1PienijET16RA0SSn2nnU7WsW1yEXRm15H2WH5fFza+02Rm1upy1pN2hw5zjD7mHetASIQ4M8JJzG/kutNj5EOlCdCX676ZdATLi7qBwvFG+KHCJ8ciGrKtURfnHqaJ0qQ6DenAKUxZE2e1rtCUuDAWNAs+N4gIa8p7YH5CTLna68VFvXwpFxrNeV0AhM06Zbeq0k1yMd8BGSjuRwEUoFAy568ifogc9KQkYBjKmyTTOkE8XiCskxSQGbUeAZFKfF/jV4ykIg/Vwdh6H3PNBdifNKqUbHb8CDfAPbV4/hYe+9j6OFERsY0IB8nG8dqa0Bgogi+HTYvJI+JHDGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CY1PR03MB8123.namprd03.prod.outlook.com (2603:10b6:930:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:06:55 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:06:55 +0000
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
Subject: [PATCH net-next v6 4/4] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter
Date: Tue,  8 Sep 2026 00:05:57 -0700
Message-ID: <20260908070557.3585-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CY1PR03MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6004fdc9-b8db-4ede-0ad5-08df0d77c3ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|3023799007|22082099003|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	K/9cyhrake0kTnrXtnsE++wwqfE0ufo8fVJZzDsKZlPjXMoKzr02c3Yq4h2FseW8mJ1LU3jK6AjjhQLFAuaHZjgGAIBUZLk+P7PKruhUN5o9XseQU0i7OQ2OpYl6OtCokxFK6WtBU9BFT8lj2qu6x6Bt21oFzIGcmeNj2IfL2a47+/jQXsE+74vjCA/7MHxpxrglkaZI0ukfThHKFHkVkKy0W3BPANTo1tZqyMWJOVqD7oIxrpozuwFReARoQfJmLA6weAw3Zg0DvXVEH5HjIPELONbnf7buwzVKUFbWVAvkSn2M9T+EQJsdPcD2t8bFXuJFLNrjSJsj5xUly58C+dQKa2KIVonrKZ0PYOmRxJl4UKL1Lfne5lFpHNn+FxgwBLrKEozn9OziCp1J6pN4UJEEtnyj9mFjOwctK8jfuAZAVcXt1OyatwHkComoyqnYHqdIbCVWIyBlolybX/2U7eftvdBvr3L6Za6+sxZlmB7pam55nGJ7bANzFoUEImO9YyfPF6H8Xm6YIQn1GCVid0hHz2s6j9XyABNaTFfa5J2jULat51UsctZC0rc+V78p2vvjQqT2NBROYBuq4wTqHG3NJ860V2Q1wLzxB84O+g+5aSoKP6CyJSY0as3aELLnaJH6uVj57yyhcVpO0dP9EYMFofbDJ4ndXe0LiS/WiJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(3023799007)(22082099003)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrOTFditU9rhSc0MIQHXgHhy1jW97BeCibMmyrQarKPVP1SRgzw7x26rWQee?=
 =?us-ascii?Q?EBwBWEQE/+stUeUZB9AYZIiWYp95I+jUbsIPNEWUGkVtEdcdopQaAyFJN0YQ?=
 =?us-ascii?Q?RGKkQcTc1gilaM/1Ko3OCU5n5UpulLcOsvih5jYDXOYJzbe2p84+yZ46plDp?=
 =?us-ascii?Q?22Jy0nWZB+3yF4vFoH9BSBhsTz9JkhrSm2rXerCVNMQDb4ysFApD8hiE/+Cr?=
 =?us-ascii?Q?TXCto2QFZrAzs2+x/75R0MBqNY+gcnrHdelqdXZ7OGKCyzQ8KXXzL38ArG+a?=
 =?us-ascii?Q?IbV4cH1W2rZFkfKS93tUlT9o3nzJN5bJCofF84ZlLcvhQH9f8tHqVnuu88Bj?=
 =?us-ascii?Q?HvYAEkW5Gsilbl4ie4gTckfUjvKjS5xn5UuctWrHcx4MwuF3xn1lpIOz2Lpt?=
 =?us-ascii?Q?t6TELcjXA4q8b4XJXnVr4Q3byFkHU1GPOn6841n2J+cQlJnUwgtKTBuEaDSb?=
 =?us-ascii?Q?e8Ns7eaqjUZHvhIivzQkXb2VLLPViuf5gzg0uNxm1jpUN4FD0R1kI7WBnvqo?=
 =?us-ascii?Q?6DSyKlzbyZWfWm3IUBzhBjZnLrAREjEM7mjY89/0v6QZGS3ho8q8Uu24PGZt?=
 =?us-ascii?Q?/l8cX1ev1wv5hrE8tiHMVMjg8m90NEcQiIOGY3SobqntnCf+ZcZ4j4b8hqOp?=
 =?us-ascii?Q?zB690eQQ4uZdXNlAAooYlwVj/ofYrZiUZ86dLPI2o31cZLRBZkgQxTD0lihB?=
 =?us-ascii?Q?Mdah0ZfA2P1khwUfvVZMKjFtaY/nOcXoI5XddYpWyzUaUlJ27yAPuYJXKjTy?=
 =?us-ascii?Q?CyHz6hILV3ytfOL8qG1NSjafpoK7GI2TfBcEcQgnjuX4ofRoCQ5awzQ24FfD?=
 =?us-ascii?Q?JdcmRZQIg+WhwgxsiCllzIQCTxL9Ngh49yoiMusBKM+waopXrrXH2Cab0ngH?=
 =?us-ascii?Q?AgYaptYn8BKcSQKM3lLGpLf+VcdtVfMYxGB61m1V7krIlKeAdpVLiHy6BALj?=
 =?us-ascii?Q?XslGtdtilwAda77w/IjLvOyWeiPG/2KsTafeuGwmo2FevjIn7GFov/9feSCu?=
 =?us-ascii?Q?nxk06yxwDgRrmP5KUSehW7YXz/qaMSoOKrFO7NKgwqJka6WYR4xP+FB4LRsY?=
 =?us-ascii?Q?yVFxvelxohVFvCrsO0O03d1ledJbgiYrttAtfCyLVezo4W2KT9OT4j6tiHzC?=
 =?us-ascii?Q?3OosBl0/pRP/Fa8YPJ7e1g0+OvQXfh4tuLEAum50dFSM7UuxT4EWRa8q89y0?=
 =?us-ascii?Q?0pAj4i3+JUNe6MlCUiwfwwVBC8Xx+Mo6264CzsrB5Gg2NNVzotf8h1YNKSHY?=
 =?us-ascii?Q?qtmFpYnm0b3IobvZNTapBU7t6ZwQVkG05pRJq4HeCDrihwZMPFtC8nVRDio5?=
 =?us-ascii?Q?gVmV62DbTzNWO3LXkDg3x6uCSUFXPgJnZXIbeAuwaIJ7tcBsNwXRnqFG06o6?=
 =?us-ascii?Q?OWz48rGp+65/2/2U8JVbbBZdz7qRppAokN0fs6XY/ZQKgilzAk70GetzFTHP?=
 =?us-ascii?Q?ljlBLcbDEd6v9Qa8R1538O87n87E1s5BXBczNVRYoDr+5KkfPMFbdO5rE34C?=
 =?us-ascii?Q?+avWgc7iipEBrZxeiKxeX2R2O1NKb4G8sVLtrLUx8BR+KRC6n5zTo4qFUYeA?=
 =?us-ascii?Q?wt2Rq/v+iKXSEqn+U9yOFStigo1+vvOYnna5wBsPNy/suat/eeJN7m10txfy?=
 =?us-ascii?Q?MOSqFdZ8lTklRO1DRf9tDuKqYDC4ceE7PNK1yx3XX0acRK8MUImYRhH+j1D7?=
 =?us-ascii?Q?DAX8Hbg3o9epeIErmzTcl1/6B31c7TCr9PDbC1Buq+gQjYurHWcIR8M90ieE?=
 =?us-ascii?Q?DPXcrVHSxhDH76uSAukF9lkCH9z5koiJph9Mtx4zWQIS70juBkSZ738xIJiP?=
X-MS-Exchange-AntiSpam-MessageData-1: Uz7oBthAEdbDQA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6004fdc9-b8db-4ede-0ad5-08df0d77c3ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:06:54.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDXte/Bz3dT48o1Uo3GebldUMpiKpj2GuruK6WqKAP+uSZJz87Zvog3CsnSO94nBd3Tv9JxtA+O8JtBx6hLNt0qqskNmDtZFJfXcDI3OMSxMWwM3FNuWAs1TjFKEHdC6+BAh/3EyePzu9aLy/wKe6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8123

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

