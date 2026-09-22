Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023137.outbound.protection.outlook.com [40.93.201.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F6541E48
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090126; cv=fail; b=JFUc7A/6U//2KaMLG7Nfcnj6Ff6aLLD9HM347+hiC6Rxn8EmWQG+poC/uLbVUUTVSt+8JAy8EGAbbCb4JkJ9GWx0L1TMZJaUbWKjrpFohjBKkqEKV2Quh6Xobo/72T7KI/DwwyfY17P7fNwinRY1uQieiW7k+Fzc/KchvXhmwd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090126; c=relaxed/simple;
	bh=3pSEFc0G9gDg/lwU+OQ+5m0tjXSPT+XfJabkB1AT00E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLziNbTUvKA2wcp6j+jGQluB2vo94z8m3y9f1qn/ETpemljw0GMyJyRoEhbR3DTwilrnrfeaTaHLLT8IkRXQLNVkUfPK/T5KvY3zh2HgSg2dXqroIfqOlMa4IMI2X3kMw3vL8UMt/fgUgOaS65ZsAaBLT/VTtsqNxjLIgcqUoWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=m1EzecEr; arc=fail smtp.client-ip=40.93.201.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="m1EzecEr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFHGBLrwSONTiL+ja3wZQ981e230x+lIcuX3jMhGbZh4E4BlJNcT3s2segYcRdy45U8o8gfUdP+rMCc4uj81OVLOrAY6qPhkGTM+mWzS2Y13Jwiza0RkDKoIuPF9FozvErX7mPm9S++2daYOenQxFHKqbHJyLj81rG3RuvlRhkgygOVI51NV8R1tEkVK7o6HG0f9V1V7/BK00YR2AXspACsfm7u8r04tEpTY3fAqfzRTcDXcOqynfQPfTZA1bDwJQ3vJvUMaajB0kYkV/CWyzPjrhz7t/ncJPucN0Y5p+ImhTrAoleALtnWHpCZzx7HFvaKv+gnP8CLo9idDlkNHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvrnDRGd5Cx3WByxnqCsKexpwx3DLCdoONxMN87y/vY=;
 b=KvFL1/SOTpHmP+1C92u0qqbuRdcSaIjh9SOhRD09CiMc4bqJ4WzlQKupUdyBdHm5VtOTEKHt5lXPCu7ngYoCc2r57f8J+faCE9gprBu1OxYQEZl3bQsEkJ1xm0slHOvBm3zcPtf7i148HkCEC6sWTdLDswYIluYRWPOajuIOje7rhFlJvrelTGtlAh4fDsA/YKQxOxffPUed0Jng0wnLOqcTyptaDba3FHVEJN/wxljrVHYc87LXYvj1sLZslrTPV/CZrsEBnEMxCBNCM33/xYfK0HxM55MKamMaT5UqMiNrj1XOXhABGe5VMaj628kHXEo+lWUHaGn/8xQv8bUdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvrnDRGd5Cx3WByxnqCsKexpwx3DLCdoONxMN87y/vY=;
 b=m1EzecErqoiK+YbtNAflOBVR7Bjc8O9Y/6jAX8NHH15EuIFrFM68GWuBvHPUrcBYB7w2J1ITlVAKdRx6ECgz4zG7xGcdngSkk71yFf67JxZIUjmufZgkNwp9jNJXFyiDyqUpfrOh1sLGy2WE2m4cgQo4v9WLoVAUKvqBTrd2gZShFIy5+w/19gUYkYbYA6Mp9felpmiYRgwBZqg+1Pvef7POfskpFCnWvR3+YCdn4TPsNUF6VCwICgITh0B97fEpLf5XDyI4UuZgA5ZC9yt09ojF3gMO2IMfhaObLLs9kdxUEFrfFPAF653QFyCqXR9OLB3Lpgyfi75xhZY3xb4oNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:14:45 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 15:14:45 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH v6 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Tue, 22 Sep 2026 11:09:25 -0400
Message-ID: <20260922151429.23272-3-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
References: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: ee031c75-0a86-4bb3-1180-08df18bc3bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|1800799024|376014|10070799003|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mE1WM5DyiJI/cWlgZcccrDUZjyb2PUSYNNkdIVify1LgcWkRPg4CyNCOWCUp2cgsxHAkGk7y5QOW1Efei2o1smtNCiJiNXWAfAE8+8DzM3kQvnA7YB2Tk6wX/XQFqR91xFRz36FKPIW8w5h6Sl/Dv+Qw5Lj9zQfex0ta4OmEj1yO1GRZFv3zaaz0OS1TsQbO4Id6zQBM4l6TtsPPX2BbdNXNzWyyn0qtIpMNwxc5v/fNxWClGslF6mEIsEZl5EMzmBAYPZd0N95EU2C7p6pctzRx6V1WdjoleHFPUDfeHTQ7DDsQKmIcsr9ujwxArImxcZttIykmRo/vP75ak2+qQsEXlhe+LVHGmdpYcz/thni1fzfoAMPDgTh0IW0bRFQjttvfH1pzucZR6ttDDkIYC7gGu0zrb8wjgsA2Qiwi969AS7rJjOcxpShMwA0UElYpd7ym6LQhUdoJ4zpkAgH3BJPWZ+9M5PgBb54+pW1hHRNJiZbbrXIDoYE8DTDAY+sdL5Z2UgA9PLYSS22p+ylsqyqgHZmBwM3nbI+Do1edJANFxs6XsiF6mSihRPCjZKmVDEmffm/nHLjtjdb+NJ+aFhbJ7wtTKB1cU4JI287byXLHp/PBZrCND3zF5mFooksatGENYx3wTI1xNboDmeS635yRUPH+2UXSMQ2bJ+r29QM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(1800799024)(376014)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S5Ze3AufKbZ8zqWDOOBW/Yy5o9oNHln8RjqNXnTDdQQAHCBEE8XiQSi65lsm?=
 =?us-ascii?Q?Hi62lCQcGtB9+1U7wWt5/+5Mvd8zIw4MJP0Q7cnWau7lCTUN+fR/LMTrA8jr?=
 =?us-ascii?Q?S5zUn4jSJ1IOmXvt8Dk667uMgu65S96vtBBun4loiNoA0HV+ib7EdwG7oxDe?=
 =?us-ascii?Q?2Jm3irILMJn+s+GWMLOtGNHYKP1dAJ8mvvlTiPVCK5LkWfqD9dxWfAsdqwlU?=
 =?us-ascii?Q?SjHu8hpuXsPJewK3WQFR6Tp7olbbuzq8UOPGd9zUOMntSNIBLpJDYNxgnP7b?=
 =?us-ascii?Q?LWqJgWR7H8THcOWjTUeaHiu8X9uJo4dAvlbyF16VpEtVgbqRLierZmygYH6K?=
 =?us-ascii?Q?dpLn8gVhH8OgSeZ1sG8Gv4tvCbW84NNzPnv6QZJkGtU4XMyhkCjGfFDw19ik?=
 =?us-ascii?Q?uqQpXqRzmND4rh2Jy/MSLWLPUpHGeJUL4m/rKIw1RiiZ9oUeBfhaC465fkAL?=
 =?us-ascii?Q?1ijfqBQjynFUYbu/gJwe3mmtwaKVVd3Cjf5R8ElITKQdZ6SJO6fpZKN29g0y?=
 =?us-ascii?Q?oh/uRbqlT+P+wD2vpJtmxJEWBCq+1rxGZwhDQgVuszZ/4pUhaRbq4OrOkcP4?=
 =?us-ascii?Q?c/J7qIcL+EwAlI3ONpzaDCBXF4X3TmRPsixL29yCoa4Uar/6bzvEy0tohyIn?=
 =?us-ascii?Q?KJ1C9rBrGBd/RRmX/9meVV4pFpQGMAzi0wCIEva/p4VTtlq8Dj22Min/F4wY?=
 =?us-ascii?Q?2+6cTAETUTngJI/tnTztaH4r2nHafyw9MPVHjGfKXIZV2QTVu/MVzNQOU2u3?=
 =?us-ascii?Q?Z5Vi6sefCFM5oyJOKmVIraRNE8wjSsojInbrV9BeuHTVk3M67Q/juwPZB7G3?=
 =?us-ascii?Q?E39RCAFHobqYJNTQSTxUx+4S4tKSiqDtTWiqGuCOZxKMW8xTmDerMfGfngwP?=
 =?us-ascii?Q?pyStf2othlDUDpOy+DdMWD63xuVmXVi2FD2QmiZZeCWkZyuOz78Npr16qyOo?=
 =?us-ascii?Q?GCsvhbgt6q2G3ozC4wOQcbdPlM9CKUt/1jHzjKQdKfEKL8MQBexVxc5tlGeC?=
 =?us-ascii?Q?xntPdO2Hj1YnEBt6Nf3Igg1W/HdH7WLMFL8JnZH9DvZnp3vv80shgY0EMe78?=
 =?us-ascii?Q?0/n2uwv+x7G/4ezTLRdXRhVzywZfsDKTatuvbuoUSnckKKR71vM4pUI24lED?=
 =?us-ascii?Q?4kRWjG8P+0Pb0eN2yGWFKz9hm3eHvpEFs88q66aqRdxGTdnevQeeRHnw3kgM?=
 =?us-ascii?Q?OMJcw7McVZa+GyCzzIgUy6l3RkbnfBN40XJlAoLSC4Xlur1GysXPhU7ZfFTD?=
 =?us-ascii?Q?SxYGTLj18dID5CGAj0WFnVdrZHzPeSmf+ER8Y1lQIN49iNxvFopA1qI98YBf?=
 =?us-ascii?Q?bNj1niwhq3CZnNQpuRFw5pRgINoufUbWL2484kdCsmT1fqO+GfppwwhEZll8?=
 =?us-ascii?Q?zYGeCT+fMJREF7bQf0dFuhf1H8zsiFT01OcygVQGkbuqDpFEuN9hZqcWUzJe?=
 =?us-ascii?Q?N/G4oMX5NLgMFL6s38ShDJ7OsnGQMt+2KGqKWeztuii/ORoTidfQQaO88TjY?=
 =?us-ascii?Q?93l40c7Ufa2WgvKkBlJTA2JW5AF1DhkjaYVERE3AYgLmoPEqu6eekcj+ZaNo?=
 =?us-ascii?Q?i8jC6jA93M3mKj6tDjks8b5P65jrR6WlemOGcY8CnsKqV4s53Cp3p1p01fRV?=
 =?us-ascii?Q?ZoDygMPnnU21QMPjYQ559B0xHF/+dnv4rWZYMX2lhWjGvJnVKltLWnF/1TNN?=
 =?us-ascii?Q?24DR5QnUKcp0iO9MlimIWBoCBumuCAn+q7RNNCBhfJrs9D+WEMhiWm6onXyW?=
 =?us-ascii?Q?7Fe/64Hctg=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee031c75-0a86-4bb3-1180-08df18bc3bf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:14:45.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifyJyeliHoZ1SGWlc3js59q9GbhU7fqQ9ESmf9WOPBgC+Qo4ST37h/IkPMydi1YD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

The current PCS code unconditionally uses SGMII autonegotiation, though
the hardware supports both SGMII and 1000BASE-X modes. Decouple the
choice of PCS enablement from use of the SGMII mode when running at
gigabit rates and announce to phylink that 1000BASE-X is a supported
operating mode. This enables direct attachment of the PCS to e.g. an
SFP.

The 1000BASE-X code in phylink also sometimes calls the autonegotiation
restart method, so add an implementation of autonegotiation restart and
make sure that pcs_config() signals to phylink when the AN advertisement
has changed.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/cadence/macb_main.c | 35 ++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 99e40b0ce804..a2bf9f3778e2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -583,7 +583,12 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 static void macb_pcs_an_restart(struct phylink_pcs *pcs)
 {
-	/* Not supported */
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u32 old, new;
+
+	old = gem_readl(bp, PCSCNTRL);
+	new = old | BMCR_ANRESTART;
+	gem_writel(bp, PCSCNTRL, new);
 }
 
 static int macb_pcs_config(struct phylink_pcs *pcs,
@@ -594,11 +599,16 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
 {
 	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
 	u32 old, new;
+	int ret = 0;
 
 	old = gem_readl(bp, PCSANADV);
 	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
-	if (new != -EINVAL && old != new)
+	if (new != -EINVAL && old != new) {
+		/* pcs_config() is supposed to return 1 if AN advertisement
+		 * has changed */
+		ret = 1;
 		gem_writel(bp, PCSANADV, new);
+	}
 
 	/* Disable AN if it's not to be used, enable otherwise.
 	 * Must be written after PCSSEL is set in NCFGR which is done in
@@ -612,7 +622,7 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
 	if (old != new)
 		gem_writel(bp, PCSCNTRL, new);
 
-	return 0;
+	return ret;
 }
 
 static const struct phylink_pcs_ops macb_phylink_usx_pcs_ops = {
@@ -750,7 +760,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
-		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
+		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+			ctrl |= GEM_BIT(PCSSEL);
+		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
 			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
 			ctrl |= GEM_BIT(PCSSEL);
@@ -957,7 +969,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &bp->phylink_usx_pcs;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
+	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+			interface == PHY_INTERFACE_MODE_SGMII)
 		return &bp->phylink_sgmii_pcs;
 	else
 		return NULL;
@@ -1032,7 +1045,8 @@ static int macb_mii_probe(struct net_device *netdev)
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+			bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
 		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
@@ -1061,9 +1075,12 @@ static int macb_mii_probe(struct net_device *netdev)
 			  bp->phylink_config.supported_interfaces);
 		phy_interface_set_rgmii(bp->phylink_config.supported_interfaces);
 
-		if (bp->caps & MACB_CAPS_PCS)
+		if (bp->caps & MACB_CAPS_PCS) {
+			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+				  bp->phylink_config.supported_interfaces);
 			__set_bit(PHY_INTERFACE_MODE_SGMII,
 				  bp->phylink_config.supported_interfaces);
+		}
 
 		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
 			__set_bit(PHY_INTERFACE_MODE_10GBASER,
@@ -4911,7 +4928,9 @@ static int macb_init_dflt(struct platform_device *pdev)
 	/* Set MII management clock divider */
 	val = macb_mdc_clk_div(bp);
 	val |= macb_dbw(bp);
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+		val |= GEM_BIT(PCSSEL);
+	else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
 		val |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 	macb_writel(bp, NCFGR, val);
 
-- 
2.43.0

