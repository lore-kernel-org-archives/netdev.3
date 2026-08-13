Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020095.outbound.protection.outlook.com [52.101.201.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C748CD64
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635466; cv=fail; b=Qda7dJiFqmHRoOl5A8Ntgz275BlSwU5W607Wx1zyC1AlRXb6pLE4QjqncY+QwqSh0jyHgAOgMnyG+OWdlVsnfOi8e37vZnshQj0OXYzMBeKaztodVAI0/aZQcgHbZflehKULKUDImaJ+6xHEvUPbeTD0PvO3maulo+V9IbSNOc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635466; c=relaxed/simple;
	bh=pxZe1MEgfw9DdWpQTDqUwOu0t9shLI6OgXbcMP5g1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWuDvKjf6ejCL6SItrvq/gUloo2wjnt075BEkaB1TBHnebeWL8AztaFN2zV2cn9OId6kGicB92oY2p6iOIdjHLhePqxHVG6GPNBguyqfSrZhTvSD73ifFlqyL5Ny0K1YslkXDG0FMLy2XbvoT+1y8Q7bEFYyyJZWjL4bfCcUk3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=AAqF+z2w; arc=fail smtp.client-ip=52.101.201.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="AAqF+z2w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdLfR9Jb/8pgWwIB0qm9xx55k+6zj0W36OUm7IRBVrRuZxVd43y3bJ3vCVcsth1YwMbONdp/dCQ44NtmlUuu+hXju4CmDNC14iWukvjTT9lcA8x5H7F40JQwxcWR44v2AoPycK/krx+VB8MwJ1OyqM02QE0CJIY69FZoC1AP+hvQjJI60/5bgA64hc6lkRV/N4eP6ZR7N+hoOIoBOr7Jei+VmzbmJ0ULwnBk2TQKg3XO2dl5nbbuen0zkGvOGoEU1FSsQgnDLN2Ltgn7PcyXXYT0bzDfrW9oKyU0pAHJck6Jf6YGlutcPFU+8e4uVsytXFHttpIcE6pZ4ZzGzY/Xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEsANyc+XB/U0gmLscK3r7+hG/aKe8/SVwP4mau6by8=;
 b=RwCNhiFnCFV+UhDQHqXD8SZkB9F566xpRNL70qGETIjgXhBT8DAuPA3fhScrkeiGmHd3/chMbXaigWCk2uk1lNiDNCqVKwKLeQ2XCXk1Ii3ozg5AGY+UGzKii1x+nXAPl/ua8JUiZMtKINoFHGPw5pWzC7Vm9SRynk12bsXYRcv0Nu8jMVLpCmaMJIsZgTCKBdypoo5LBimdexObixS9NVy8gcrwtxoWXPw7kASpjRggw+lcqze0RBLGABrBvLGzI0scShdpTZcDrWDTOIJK+s5j0eGb0KpeZWNO4QzWhQgBSZEjmJVUXEB7W4koTthL8Wj5HfI0+bTnc6uwNiUHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEsANyc+XB/U0gmLscK3r7+hG/aKe8/SVwP4mau6by8=;
 b=AAqF+z2wwBSerX0msRal/WRAHPsLx6ZUx6FFdzxqxA1EhOut1Xxh5BbcxHq8F5S1jv50Ltho0V6q5MG0Bg1Bk6jnb7d9X8fytn1XcX3YfhtSxP41vJrm6ytwzVu3fmitBAibzRF0QpWJUNI75VEl0ZWkoJYOyDAJya961dVhEZuTzuIxC4b4tpKj2b9LFg/W4m39unUew/yYtp2Ctz85L6jnFsuJn1dTkJn5APPr/K261ijl0+AtzR5/MsKekHv4CvO5VTA05UK2YiL6rXwHuhF2Kx0M/3+Ogu69IvJzb3A1xlQK6QWkfdomJ7WgqQRLxskcvYhwCsrqnjx7K4GDmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 15:37:19 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 15:37:19 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v5 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Thu, 13 Aug 2026 11:26:10 -0400
Message-ID: <20260813153705.23407-3-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813153705.23407-1-nwhitehorn@pa.msu.edu>
References: <20260813153705.23407-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:610:cc::12) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d73820-9f21-426f-797d-08def950c2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|786006|10070799003|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CABNJosLu/VuUrLIQIAhORm5+24ifDwCTc8LXWMoVogARvdjHREpt7fmYCcQSmrmftXseC37iK4cx4xCFtoar5Ss9VYHNfSqQIO+eU/h1xZN3Pv4bCoYBaxdqkuEAfEy+yHu6KJLThsNe94GFj0T4tzmqjHXCsdC2DO4nhxkioVCIaGjrt5QM9KuiVDEPq8AzcNnquVxGAS17YwsPua1EvQ7zx8FL1FWfnx1rGUN/OHO3KSJDTZvFZOA14FBSqnq4OnuiJAcPitCoyfqb4czH4iq/4zwNx+F7vg3WEQ8sxFLdbXqnCoL8wt5bqr6E7SmKeuEu49LCoDCBBoVqKAaHsyeTMqYbQSEhlZl9Lf+5LASQkmYuSUxuzmf1HjAt/zPLE8c+U4AXzwnKHYnMrSJjRNQgRFrkPZVn13bU5LK6Vh/vpabdvlfFYFrmoL8FaIcy3yO6knZsc/1us7OVAgBntXLWu5+THtJWrtWG1sigMxTFHmY9OROxnxpdff8KBbkM+U2U3AX5aiWcf2gUXLc9kLYwfn3ZV+F/QMe/EJguSJggNy7VEhILwTYSicUGiqAa3wQlw8yMviutiAbdRtVuxFVCRZTwT64UFMuZWnMNWZ0MMCR/ipwU5oTCSWcyTcMcai4JTpNbjrKWvH3jHhaCTaWRWUj6DV4piyRNUWaWdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(786006)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8BZdr7fLlXXh2WZ38dSk0FVNXPuGBYENFa37rXWeSBquagtFCzoFIjnnYYnF?=
 =?us-ascii?Q?vhfIKk4FKckLNvH1pLyuRtjjJud45lrQa1flwThkFxQ2gNyllt0XbwLo4uP3?=
 =?us-ascii?Q?2mDcLu4UNJYuxiDNr5PsZwPKgBBoOHEJR/Roq7TIzWqoqaw4UGqdXUKpphxN?=
 =?us-ascii?Q?AOxytml2Uyn1bqH+94YrGGV923BiyZR7irpSCCBdI8W3UjvPbZWXLRfrpcL6?=
 =?us-ascii?Q?wVMSrZ7NbjMgA06fchPgompjaU6o+/hc675EYtK1+MHjg8Fs0/9Cmp+1BKUE?=
 =?us-ascii?Q?W7mBwsB2r+8rkoILGufNdwm6oNLbslb9/1vFQFugvEk5X2Dp5cz3YMhbR5+e?=
 =?us-ascii?Q?2q+DGgAr489hAXboO5+yzPKjduH7Mn7ifYkTDLyLwWukdX7N/mEpvv45+2qV?=
 =?us-ascii?Q?5WS5eA1bEp75GTjxHOxTJbRaXd/eTCgmXSs5OvV/MVKHjpf+8UcNTIZvzQ8T?=
 =?us-ascii?Q?aAa4GE09b5brFuVz7jek+NlZvNHs7qUnP+bV2mM/717vhmVod3lNF51RFQ/u?=
 =?us-ascii?Q?yWJ9pfAeFS3mI0ZgTJ5vQK1cbUov2hHnBPB2plJhZyJU7c5osiUpl2pzubmO?=
 =?us-ascii?Q?/J69lEj/1lJZclpeE8woY2qMmV05Q629Xd0xcQg+0gBwXuCbj5nI21FSHb89?=
 =?us-ascii?Q?Tq1364jiZkiPLpsyNHK/rDxAUpvcdli30TNpoWNsLyls5MMYMIquYi4GxLQ/?=
 =?us-ascii?Q?jQ+VfIz0/jRovE3oMPh2y/FowZAm9X5k3uD6M0rhWIwEMfbslWXfQbZv5k9d?=
 =?us-ascii?Q?x7UDN7zTcth+1KmoiJfjvYCC1W3ALig9PTWmwWItjGHoW5gancDmWMOWo75I?=
 =?us-ascii?Q?65JOXH14ER+TkgN04C/UZtFH848peRH1mJ7dg/LsLaXnMbe0cVF+NgaT1lCZ?=
 =?us-ascii?Q?BHwA1phMlGDnHIU7KVeJm6nEYNOOmDQjsDixH6HnwrfKNbSNgNRH9uaCxRUc?=
 =?us-ascii?Q?9E0KLyHL4etpgD0a4pyLZWaw4pZ1YQ3W3aWO+/GHC3htOs2GHk1Lyo+ddamO?=
 =?us-ascii?Q?Jr484ebdUQPs0Rbk5jxz4By/3HsCbYuESDzfdzew7JeRf+xgKTRcN0eLryEc?=
 =?us-ascii?Q?yTZlcOUtbOiphj1Bt6Q+3A3EWJY0YnUFpoY1eyojbzjddWvDXf8JEqVcPSpC?=
 =?us-ascii?Q?WwpEEKYZZK1t31V9fssb0kPnDFtuGVnnKC+T/hWSSX4fyLHrg/DqKEUwodFo?=
 =?us-ascii?Q?SYFuwS6iGllcLrRiqAc72xnYQir6/JVC/e2uJ4GzjBT00C05LF0yYV/tppCg?=
 =?us-ascii?Q?tSaoEoTDOybjOy84HlD5AMFHEcn5y4hyfCDGGgV+tXSrDaX3VvpJ1VsSnhld?=
 =?us-ascii?Q?eRVjXe2k2AHCOT7VgyAsjFqUnIeie3x+Pkb1WmoyP1O+vxu5UflASUDKAt1m?=
 =?us-ascii?Q?V+kOaU2QZNUU2Kxfb2ADbBsDNOOWCAm7OqVSJJnGDXBBQ8nSwjJltjryRDdI?=
 =?us-ascii?Q?8mmsWiFJECBxzFn8t5Co/SThPEZKOOJm+/yqLPQPuTZ1DuWCWsTy+PXsqEgE?=
 =?us-ascii?Q?kCPwu9rHOa9KP8t2AexUXAAgKrL37RHthaHtjLYCb4DLpX72J1hTZRkcS5Hd?=
 =?us-ascii?Q?EEEusr3QHSMjz6KuV3t1ZKhZhWcPDdjltvlaFENRLR8C89g6I4bA8c7XeOcg?=
 =?us-ascii?Q?gmDkWXBiMohjcfdb9qfrYC0Hy5gDqAt0qE3cAn08m9An4h4ul9s72ekbM6QX?=
 =?us-ascii?Q?hpdFja7URWCnIU8yfs/b85ufCinuWZUUAar1Gea+jEjOzhg0lgtG+PI0uYTe?=
 =?us-ascii?Q?M5UekQBMbg=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d73820-9f21-426f-797d-08def950c2c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:37:19.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S79phsmRbjs+us71FJBqqqoBhfGuQioXAp5fo5dnS0Ql39jCsmXqoQbdYvpl/XQg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

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
index c15a9c7e69d3..9097ccb14c13 100644
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
@@ -1032,7 +1045,8 @@ static int macb_mii_probe(struct net_device *dev)
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+			bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
 		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
@@ -1061,9 +1075,12 @@ static int macb_mii_probe(struct net_device *dev)
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
@@ -4932,7 +4949,9 @@ static int macb_init_dflt(struct platform_device *pdev)
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

