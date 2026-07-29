Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021138.outbound.protection.outlook.com [52.101.57.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255339EF0A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353306; cv=fail; b=dBlR3W1jNUd71xy0Fqi464kgiSgh4WaeHQjh+tlGDd905TaFhu44jGQtu8JydrrQ1pOxsiQqVEbBpPCrus9iwQUHz0+HqbGNKHTYaEmqg/5RN5/FP92WYGekewCqaVwCda5Ib3+Vhv8jhLk8j7jt1ii+5PD4tFQOeaRHXukNZF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353306; c=relaxed/simple;
	bh=7vkRYdUj4U/je68ZUomcfRTnDQFtKLr80AJj0n5k4qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sseLuimU2pu+nz7TpsV+UgSVVBN08SBCT/dqreQKZivZh9TGdnbpXBN/j2NXmgX9kwbcjkwkolJD2gQpsvykmAvhIsq/90bwKhmMME9eiAwU/8ObjFmiXevjBvGbEGbeSOr3l6jsFX0fGk2M+yZs+/ZXP1lswm9SoPT9SJZQ8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=Tjs2ejPC; arc=fail smtp.client-ip=52.101.57.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="Tjs2ejPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQz9n4mbOBwdIl90secy5rMV4yINEWMOJYGuqSTiNzYeY/5s+8IiBVcsDal/D0q8t9QCkYwnbLxSdXrGaAdZ1BFuzIEFWvERgFFPo1s4eDiQptlExGyXNbZ2FM9Ty552pvB7mJ2LbCEomvTyVXoQz3tnvwjz7aL+kRF3LVlaXP2XWINALLCtyJCJQJmwol2c9s8or6fv8bMtt95/+5lZejXwhY181CQVF2ckFqX4Vn9Ti8VJ8HhfX35N12FL63O+b31Xr/rDpKy4cB0+cmr4aOh+ih6zbbr3SVVa/27vCz8NDN/GJ9sPGmX8JqNigF+vA+e8b+9psE/KBoc9s1ab6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V+PZbY88jaNwrR7qCCyMff4C+ULTA/B4cBuxd0eEsk=;
 b=oh4H3jCsX76iI2qieSYeKg5bfyO2oO6Wxzjxl+FsQFgTkqkKih79ouc8Zkwg5RF7OQGivmysnpJgVXHpf3n712sHouDgtvWrmrq4cxVLdqXpiNlcDN1PX6Gv+M6n5D300bARwFKjc6cCZTJSb9UY9P71yy1C0Iob129moWQlxvyUTychFZ/FFOo5dDWxqxmRQ6HH4mLop4gpnu+xAARVhOzf45CUaRyric4IpNik4dAfAnJbMnxN+b/AdTHf8p735v5NYYem1PxwYiMDOLsKkdu6Yy0qM2Xz2LZNL1AxFhBiVKnrsEwh3AZLYbx3m4UJiVtzDTrH2w2j0yw3UIoypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V+PZbY88jaNwrR7qCCyMff4C+ULTA/B4cBuxd0eEsk=;
 b=Tjs2ejPC+O13EyHqb00gYv7ouFw9IrJmRYvnow6QC6EtDj6o2nAS4UkGvx4qyT4lcj36y6hPXBucgxAu8+jT71+kjABADDLUJs/n9UrO/Nnc8xdi8KoYsisOIxfaE2KpVEdsC7BjP9Pt4e3XJo4I0ymWd18plXvucXIu3N404QG/tSYCFDBM33mGpXPKyp1DU8rQHp9cTH8nDBSt2oti8DRr++iK1Is0nOMNCL2wPWceDEbfbNDHVF8xBXdwGDPbVsy0YSMyRRDxpsZ66aAIzvDs79tPzaYGXYIqWv1G2MnorfOg9r5KtD2CaJjSAPQ0w64kCvncItehYH4bW24EOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 19:28:15 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 19:28:14 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v3 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Wed, 29 Jul 2026 15:21:27 -0400
Message-ID: <20260729192748.6928-3-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
References: <20260729192748.6928-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:610:b0::35) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: f909c524-e8e6-4263-8aa3-08deeda788d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|786006|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kGwrLR0NsFTn7BoyU7yboUcHHK3bRTZeUz5fkK5ZMRctNUDXh1efK060sAqxoPPd/f9fkVivTLppjl+bv8FHltIXpCtQ+pgTWsKZhmRJawZbqHTrcQezsNSuHcVlk/G/AySt5FNB3wkj/9/gKMDjP1XebTpDOmOmg7UOwUd32r9KdhyA2blngfRW86B/UcRa7uhcE8E2+oC72SzpBglSmzVhm8yrvqMKigG8PHBBmE1WGq2T1LM1CEtWhhaZ9yJZrBFQMdRNNd2cqoQ4P1Di/o+hy2syiT58DN8nziwB2anqxesyLkw1UnE3iWPVk92OCojweZZi8riaNbAVH0mhcXyHOg23J+Q/48LPArJ+OCilQl+p/yyrA2OujNivNsJ2YY/91SoUdIc/JNwhNvHgF95ezVcclBh660SEWioNSQoz4wNdaVYYuOjk+lSOh3W5xWYvtUQqozvu69+rIIMPtd4TGI/1Eq3B1z7deAijHnvyIhIWijop9fenUnmS+pZCkJWr7yBVC91q/SQRteS2O5KOHaXJBEfUgGmfUo1eA+JKM2o+xqqTQPQLvjnXveMpimNAFy6BiKPzbGR00+E+cZ6TNAteVgR9q4X3JXVvjBrHqLv4vaDzrrZbLOZ+QE5KuPIA45YLQsH7C078KshVovz365lTAJ0Gyb6N7D/xCTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(786006)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqWh+xL6vBLWRN0V8bpSQBjfWPd/jwV0+djFWqFMbEyEle/Yzk0u1ET+7WJl?=
 =?us-ascii?Q?Llon99WeFxc5RZLE6CJwdHaPKqHoIPHYdq/GFmGL/ppLNQsLsY1ekZTOXRhc?=
 =?us-ascii?Q?Nbk+oaeRFPG5QqQ6r1c5qiUdyt9ZcZyOcscky/YHcz1hnZ/9Kx81Ya57sh9P?=
 =?us-ascii?Q?F0mX3eD+C/9GzWheAIib/egElA7hckPaHuN3bAV0XQXwbyOPC/y6WcQefv/l?=
 =?us-ascii?Q?R0up3vXQzENo1hWbWWK2VkfGjkFDXrNlN40ZSPYzWiNmjQkH6jAfTIoTr94b?=
 =?us-ascii?Q?I0qxaGjiHkyzYbC6JL1SudcCakiCbjMsoj0F6nlX6ShSlcOmHM7JNFxnS5M/?=
 =?us-ascii?Q?JNrn51LIi7hXIthBn+UPUbsw3Lq2j/pxwqoW+YTeoIP/QDvq3OBY4zEq41Ti?=
 =?us-ascii?Q?t3ieI/3hNOdmXsDDGwITZ4YLloZVzKc4xbbtC3Gxh6Tq36vva+i3rQGqUclV?=
 =?us-ascii?Q?qdaX8tQ1V6Vp9t0n2+huwsG/n3rvxdCi+h75DrsZ6VdQhWDyH6okJhj9GwpV?=
 =?us-ascii?Q?+iaDLhH5GxdlD8rLmuAX8hvr7+TCioQHur+fCNX8SxRq31T2pCOyZlQcA6O+?=
 =?us-ascii?Q?334PHCX6IIiXPd5wSoIVZUeD660E+q8acGjelTtJQ1w5P9YU+mgOTnCUjaLU?=
 =?us-ascii?Q?ldh6kX9cSXgEdo9Qvs1qQ3Qfk7KaIzMj9ELneNhTXt2xQSBULXxrWG4CK6pb?=
 =?us-ascii?Q?N2tNwkxc3oKa7U9U/qSXoa5EyEaXmVw5ERwordwfB/iUyj6utXWA96wKmZzc?=
 =?us-ascii?Q?w+OT9i+38p11CB7BXEAffoSUkDBERA40Nc4OSi7W3f6VfAt96kuveNItYlw/?=
 =?us-ascii?Q?Ed2PKE2zaXI1+dYxAHBsHTHHdY2JZlIE+kthfSJy5J710I5/gtSK7uQqohwd?=
 =?us-ascii?Q?JlN7N77t4Ii5oUz1sSgraFSVUbjXTYrgSQ6FeDxbp3OPNKOTURJf04/lnv+E?=
 =?us-ascii?Q?BbN3GglKPb+gro2wJ33D05NGfUuT9diVPoodIfRXGUdV1LKptvtdGYwgDRY9?=
 =?us-ascii?Q?PI1uyD8tofCoD3lPoEguGkwAAhl0wF3eahzJk2O1B/DPj3GJXQec1Z+cz61J?=
 =?us-ascii?Q?hbouhP2yV3elfsAoseAm4aa7vSJsbgcs468ekYrFfVZ0bbgSSXrD0NGFuqyx?=
 =?us-ascii?Q?saAsKWitQCjOzWOSzF3vIPcd2SatDi8yKSt8NgnAleUcK90SNZIYgdaAQYeZ?=
 =?us-ascii?Q?qAkQqDTegpLRXtWrt37X6apx9gN6jN3Z0YvHKMAwATLlgTAYaVXYeJVK6lvO?=
 =?us-ascii?Q?KKcMiHgqcN1Jcx/H3PJUqSwW9FCvrd0pBoqOR+Qg7lJLv/EwM8+E7kQJVdKo?=
 =?us-ascii?Q?ukSh4sPoJVSzkEDHvVUDLgrFHBuf9DPSChzODntewaGUlpullhnMYkWY5iOW?=
 =?us-ascii?Q?wWv5QI1NrhFEYuHwk+fh0URmcSqpyR+RPQdeGC6CHf7bEuRK27KDwvOn4g7b?=
 =?us-ascii?Q?R/mqUyFvR77Y5Sm/hCbeCZJF6bHQBuzx/YwxbwQk+YqP/xZbQtIkcNR0Oj+q?=
 =?us-ascii?Q?JyocEgmTGs/RJIZZCbkiQAGCYLw3Juk+lqbTfEUXlOwlqzv2WrKJ86/7PVKZ?=
 =?us-ascii?Q?dbJCOSpgELdQZXNnsYvzAi2G7Omb4qq6vyoTBseW/ya4j4gCM2qxSVKoDOcv?=
 =?us-ascii?Q?sr8HcFFxOaLm1U3iENW8/SG/Jyzb+02lx3rmLELS0yI1WVqSzKz7p+aDtORB?=
 =?us-ascii?Q?PSSQV/IG6lj8rGtdT8K66tllzET20GNXeTC9uFzcNfooMw2jWRyGNI+kO2Rd?=
 =?us-ascii?Q?pZ/irXjUog=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f909c524-e8e6-4263-8aa3-08deeda788d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:28:14.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHsgt06W3eZA65C/Kt6XRjOO5+ZwSSwkvj65QNzVS3H1h1kMGX1P2Dq/9lNsj2Yc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

The current PCS code unconditionally uses SGMII autonegotiation, though
the hardware supports both SGMII and 1000BASE-X modes. Decouple the
choice of PCS enablement from use of the SGMII mode when running at
gigabit rates and announce to phylink that 1000BASE-X is a supported
operating mode. This enables direct attachment of the PCS to e.g. an
SFP.

The 1000BASE-X code in phylink also sometimes calls the autonegotiation
restart method, so add an implementation of autonegotiation restart.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/cadence/macb_main.c | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c15a9c7e69d3..310ad8eac21f 100644
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
@@ -750,7 +755,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
-		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
+		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+			ctrl |= GEM_BIT(PCSSEL);
+		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
 			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
 			ctrl |= GEM_BIT(PCSSEL);
@@ -957,7 +964,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &bp->phylink_usx_pcs;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
+	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	         interface == PHY_INTERFACE_MODE_SGMII)
 		return &bp->phylink_sgmii_pcs;
 	else
 		return NULL;
@@ -1032,7 +1040,8 @@ static int macb_mii_probe(struct net_device *dev)
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
 		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
@@ -1061,9 +1070,12 @@ static int macb_mii_probe(struct net_device *dev)
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
@@ -4932,7 +4944,9 @@ static int macb_init_dflt(struct platform_device *pdev)
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
2.34.1

