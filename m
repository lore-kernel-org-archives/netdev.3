Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020084.outbound.protection.outlook.com [52.101.56.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC83BE643
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059761; cv=fail; b=SJRTaMMvbf2B9LkzpUeMWEY4neb3TDh2YhZ4th2cz64mmguUgkDQUX34dOWmfoHpuyzzimU4vkZnvcj2MIDyS1xKop27334Wm4RUoPWyogCbFfR2PV4WiPD21YTcZ3mmle4c97QyRidvv7CLkduIBlKAA5YDhgnzEpng6G8vl3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059761; c=relaxed/simple;
	bh=xWTnEkQuRLgE0bq1M86Pm+M1BgVHDVf2XpF6PgeaGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AuyIHUgq129fBM0femsSxMD4Z4MgwCkNDlZD8gz4HzL4alkv8LD1x/xD7gOL77JcTJ/xC7ZYrgOskOtUTA4HP69qqKalqS2M7NaPgg/7O/JsnU7hE9MjJ7VG7VmY6zoH57C3w2O++V3dbe4+xSK2IolidWwbSK8RJYLX69pFEE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=1/vOw+O/; arc=fail smtp.client-ip=52.101.56.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="1/vOw+O/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Djk3p+k6hfl7TtdKrR8ZroiDJpLV0jP3Zawk9VeAXUDJDcjw8Dx86NNv+QXGljhq1mFSlI9jjnj272GMaTGD/wwSwCbL6G+HKRxFd/AdghJ5wure3+F2X/C2Lsxxa53ssFFoc7QL9gBkyxgSEXNAJ4QSxcWlIo89s0gQKwdIYOQ/6sY971jcBUrTmt44/f/+vwQw5R8p/UaqYavW/epQ2PpZpYZNvdU0PkU06Y5225uWTwc/YAkr0ao2fwJXILPkAmgcv6qOS/+oBaeVtSLXfJyBBv8sYPECD/BRlhZBig9KoolaHcD+SfxcwfSN/2SgHrxYQayye1cy/nKJd5vGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN6lpfymRvZYEvKyet1IURp2peyt34gCP+KTQ87cUS0=;
 b=vGoz4NnoWnjYwmk7R9HLfhu7SZg91C55MQFWpNyuragY+xrcpWLNjvUddkoN89GkZOwEkV6Rr3MX0b1WzTGLY4CeNXiGh1jZBmldBPngfd63+Nx31mEFDQ9mxWxdvS4iDq1cKyV585XJU5NnOHh/EY5HH6nIsmTly15w2axejqrPmhGTFJMIKjWE9vBJgkzr3u+XEHANvF7MCl2XC5ukhEks9QMxmQtTpYrhHlacUsdUIs4m2hzvWnw9yBpii//2wR+IKdvZ/+L//R7osW15YdU3iw1MMQUssoRauSJiuVdwMrO1ZpmUkpB3WUxHQzxRJDfi8L9Xoa/oCsTRuf3lng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN6lpfymRvZYEvKyet1IURp2peyt34gCP+KTQ87cUS0=;
 b=1/vOw+O/9RNACGM3YoSv5+4Ra7reFSzHgC/kSE3puG4KS9YK8lObeBGdxEUH2l18Yim4yU6CVbQUUvxwnj/cvTwwfs5hQKlzCeM0fQ1EjFe8hpVlIg1M37a8ffTc8++WGEp9jSGwX3kdaj1nDEOrNnqXnmE9jiof0cktlGdmNp4oWevYlbpI06nfighciUKzQv1LJ2aNkdLxL95MjM7aAWVcoVx1uFP14g4B/KzbDhWyfkUYdAyfrkxNZZqE0gu28myPIagBQ0AHJ+rlbUky1TUaDXAzT8IRVPaFPgSWwQIylTHxDgo38PSRHrTxNsCFNmawTmXNs0VgJkh/sJWhSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 20:09:16 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0181.012; Tue, 14 Jul 2026
 20:09:16 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Tue, 14 Jul 2026 16:09:04 -0400
Message-ID: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::19) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c47c466-2389-4e5c-f809-08dee1e3c7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|1800799024|366016|10070799003|376014|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	0H1eUqjLwuulzEtfN7XK6FMWMo2UCXmZG+gyqEc0q42bY81vhWkluuPaiQBhfvlCB7/W3rclT8oSfB96Jig1HEh798SJZUjkGkxpXOatu2uSOPKnQki9iiYI91kL4qRcJQGJGXYp3FuWt0g7qR3J9SiApJatbEIkQieOV05JBf9VCdoXbhdsY8dKLVsgqC9nhI7tsodoAEl2NoUo7EM9C0eodlxNokGJWYqjF2UJlaINx7jQgyVUAoCma6HPmIh21Cs6LhNpUudfOI4Ow8h+9l6gROnq645sF/6yDtSxZLhhL8Kt+Hke3sarkytoRWSbJfHyix9obYxIajeoNfm8qv4G/V8KAgeo0KgEN7gXmqKyfrv6UtVphuBxn5NEOToTvfaV+t7sojEgoPIKt5q0Pclcw1hstNwmyXOOQuDCXMRMFXjV/r8DCZjTEsxkuY3D8i9/D8E+yoS69xiwlJbS8SvFyEb+3slBHKmPVL2xTmgU1L6JwEn8moopwNFB4LzupJkYt70CtH/73XUnL1nyleJrrq8TvX2brgSFMP5pNRCpdaYkFukXU3Fq6kU3h8Y5crzsxcpLbvBehoewoMv293RixGQRurnaLaod/bE9/DOU88/alHAnlo4YI3+IFPYiI7xJjzkVbqS68k4i0FKL0cV7tuuacsUzfOxnYNzjh80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(1800799024)(366016)(10070799003)(376014)(23010399003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIYrotVUGI+dNBqW/0WZHxPKnRShk0UKeTVfDQRRMSPmw962OWjDQGxn/ze/?=
 =?us-ascii?Q?doXIM6OXmJxBDbFkyq5d3CzepHWtJMbsAHASeqwuTlL3LN9QyzlNiC/XQx8e?=
 =?us-ascii?Q?p8ctk+b1qey9uB2Ic/JEW39q/i3crPo5ssbnmjFUBKb39qyqeZaphmFxfkHY?=
 =?us-ascii?Q?0NycOCLNhVSljwPYN4sLjmLFlFA24tD4MSdqvJ8EN8wxP5nk1jmWSd5gj72X?=
 =?us-ascii?Q?A3EpOhT18BdNU7A1OOhhA0L8r6KuuGfdRR/EHII0/iYtIKCBMd7nhWM8PnhM?=
 =?us-ascii?Q?zp+78e8JBjEVjq4E8WdUt3LBVSGlKTkiyxJG6ax6PUaSf97175B+6B65duXi?=
 =?us-ascii?Q?5SW+gjLTv3rprQcE51fqGtN7h26K8QLJxM+SlsrCkCq464O1USwcfJdmaYJ9?=
 =?us-ascii?Q?xiVuYezLfihpo8kqp2km3ns+CWeUTgrZ9NuFMWoTkOKNVay3laFJxjJYaOTz?=
 =?us-ascii?Q?3AiJGOMv5K10kEfKFHIcOUzPMKO4AmaTCdAqW3p7Kb1bVLCRl7qP//kvxKX4?=
 =?us-ascii?Q?+7wsi+kOThGeeSuyA3DkowhlUorAMfHNslUFnoCEmmHydEZ9M1gblTvhfTF7?=
 =?us-ascii?Q?1NZvVS4dLd+lY/Cg8Ucn52uNUZ+vBGyBBni6oZ2f94jmWybD6zRLTNTD4vJM?=
 =?us-ascii?Q?8gK2xHCXqGjT99f5xDtjjJPMc/LyCCk5GJKXfKaO/jC+C3aCAbhAxqOmBd67?=
 =?us-ascii?Q?Iur0EgMym/zFWBmbZ3PxUA3tBY0ZYU9eobwOTyQLFTrX0SNTjkffWUlmfVn/?=
 =?us-ascii?Q?9LDV5JmJ5GjrbOz3+rQMt7jQ3VbnL/GrrIiVwcNU/SdXX3DaxC39rH9sUbM4?=
 =?us-ascii?Q?2QxPEQ6/DUE8Ign4mYOGx7xRDPsW0utWTHFa9rPFoGD18KYcMIITsV5+1AA5?=
 =?us-ascii?Q?+tDIYt/Km6epIlO/jfJyibPE2H3lfSq200SaN81ncatRa+v7gXZeshkENoLt?=
 =?us-ascii?Q?dkO8NPViAuUiCeyi8R9mFN7mCfBavBOP4vGkAzqc5ci8Lzco5tUteDhve701?=
 =?us-ascii?Q?Y2LMVJb+ZZTXvsUI05x/Vw4ZLxic6/BkbkYsrtI5286dv+6y4Rk3izbGpxf8?=
 =?us-ascii?Q?caBx32XLwhfPng2anGmcQgiLD0chlxYJrN4fm4lsbAoMa+zMd+WFEwiFOy1r?=
 =?us-ascii?Q?5Zo9b+6ysFk7R4lmQsyrbfEykfFFO1F07JaNmmR6fXJl9aymYibirO3RWvmc?=
 =?us-ascii?Q?Le7+2H1+6tbwOKpEjfdWTuSwRssAGQm/+HbIDkKZ2PgK94OYD7bDxjgFOdEq?=
 =?us-ascii?Q?Wh+NUKLKd0Ro6PEk86oBK5eQWsBeiwQtVfd5pXZG0KVnTf4RCpWDAQkdKy8+?=
 =?us-ascii?Q?ksJiOvMpMGWyBxAfTzAVWJmmDRo7YL6LuLy6PgxOiu3Cw2ktpo7mOeWtRuuU?=
 =?us-ascii?Q?G0wmIl6Q2G/dWTRlWtUvT1eQzixOvvD/jsh74waVODTCWCU30Sgt9+isifVD?=
 =?us-ascii?Q?Q58N7wVwPUUGfg15948VH3UpMmIvlTyzvg2U4lXhtWhtNSydIzLPZaRMw6hQ?=
 =?us-ascii?Q?1J/gmuPW0H4GQd2PyvH/RJOMaRwwRdORF58K6rr7rQ2OygjCMXFU6lKrjLiD?=
 =?us-ascii?Q?YX1ZawrNxiElQqHTzHK0On/emcliRqbMF6gLq7Tj8I//sMl8Ux1moBeRU4dc?=
 =?us-ascii?Q?o8bDR7+Zh+gcsw28AIJKJdRWhXa1b7YUN32Z4s17kk1s9lrdNtr8LrGNTs31?=
 =?us-ascii?Q?FROS2SkWZsDnikkVfiUHTI7SC6MBmlsBTkVf2FE1Dltm6aOEqSZWtdoFgAjJ?=
 =?us-ascii?Q?QLIiUfXG8Q=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c47c466-2389-4e5c-f809-08dee1e3c7fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:09:16.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx/7FDX/7ntaGlxTGBqt0D+C0qk9v8eV4lpaRppegssNhpZM4DCSMh9hCIZUWLHi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

The current PCS code unconditionally uses SGMII autonegotiation, though
the hardware supports both SGMII and 1000BASE-X modes. Decouple the
choice of PCS enablement from use of the SGMII mode when running at
gigabit rates and announce to phylink that 1000BASE-X is a supported
operating mode. This enables direct attachment of the PCS to e.g. an
SFP.

Tested and developed on Microchip Polarfire SoC hardware.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
---
 drivers/net/ethernet/cadence/macb_main.c | 31 ++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d394f1f43b68..284a3b03f8c7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -583,7 +583,13 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 static void macb_pcs_an_restart(struct phylink_pcs *pcs)
 {
-	/* Not supported */
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u32 old, new;
+
+	old = gem_readl(bp, PCSCNTRL);
+	new = old | BMCR_ANRESTART;
+	if (old != new)
+		gem_writel(bp, PCSCNTRL, new);
 }
 
 static int macb_pcs_config(struct phylink_pcs *pcs,
@@ -750,7 +756,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
-		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
+		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+			ctrl |= GEM_BIT(PCSSEL);
+		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
 			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
 			ctrl |= GEM_BIT(PCSSEL);
@@ -957,7 +965,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &bp->phylink_usx_pcs;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
+	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	         interface == PHY_INTERFACE_MODE_SGMII)
 		return &bp->phylink_sgmii_pcs;
 	else
 		return NULL;
@@ -1025,13 +1034,15 @@ static int macb_mii_probe(struct net_device *dev)
 	struct macb *bp = netdev_priv(dev);
 
 	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
+	bp->phylink_sgmii_pcs.poll = true;
 	bp->phylink_usx_pcs.ops = &macb_phylink_usx_pcs_ops;
 
 	bp->phylink_config.dev = &dev->dev;
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
 		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
@@ -1060,9 +1071,12 @@ static int macb_mii_probe(struct net_device *dev)
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
@@ -4931,7 +4945,9 @@ static int macb_init_dflt(struct platform_device *pdev)
 	/* Set MII management clock divider */
 	val = macb_mdc_clk_div(bp);
 	val |= macb_dbw(bp);
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
+		val |= GEM_BIT(PCSSEL);
+	else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
 		val |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 	macb_writel(bp, NCFGR, val);
 
@@ -5456,7 +5472,8 @@ static int init_reset_optional(struct platform_device *pdev)
 	struct macb *bp = netdev_priv(dev);
 	int ret;
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		/* Ensure PHY device used in SGMII mode is ready */
 		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
 
-- 
2.54.0

