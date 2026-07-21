Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020112.outbound.protection.outlook.com [40.93.198.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2C46D0B2
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656940; cv=fail; b=dDZ9OtBEgnIH1obcMr4GK9EFbncNl+IgssSDpYOZtmCBPbhVrp4sHbcloswFMVKiwRQszilb7f/GEIeU+DxB1wnCEinSln+KpCOWoukMNZfpJYgVKwH7BEolefsHJXYSrSAzdEdmcg0LPuVyYFkDCLauXnlI4a34df05SyOPv7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656940; c=relaxed/simple;
	bh=4PhoWrHDJS2v0tJa5VhnJiUCdJsTMAZySgOsTDys6BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNLC2jn8SNOCSv8gLCi5L7qDga7jfdOlYXuwo41hkBGkI4Vfg0Z1STSiN60XmFQMPgjWRmhbwnIdyCzAQGFPF2Wwy1kvquKv/4ICGRD+lQbhBq3sCiJIXCSZo4+dL1z2nMFBSsCNLOL9xoi+LGj3Arkh6iTzCRh+gKlLm20wFJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=jo6wP42C; arc=fail smtp.client-ip=40.93.198.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="jo6wP42C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3m5TdWVyRS3f15pf5N/2bdx/ElzOEtDFa17HESwczZtpexQR3GOyDOLiiK1Y6pr7hD+pEipJ1ormuTx/FLYQ0bQk8lEUrFlrBEVE68QGh4el8knbac51PAKyNm1gFRgdzWFANIJlDfaDjXvw5AWnbZ6VUX7gdOPkDvhm7hfRCtpjWcocTKShoEvyuBKjqoW8jklFMRbp27ysLoZdiWpjOlcuz8JkpzrVoCvMbtRrY10jqA4LYaEJgf6rm7WAWvjsZSaFMyrZdAjLDT0l3X5jF3cTda0J4ogsWPAa5vvJGHzLSklTi5NF4QGY96ZSdSz9ypZdsCaPnduUhgO1F/FyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhAv//qxfpj0KHitK/w/5/t+Td1ryPCOX3m76T8hITk=;
 b=J9EXhvZTbDoY0W4pTro6fgH2CES6XjcOTVKDDRo7EwkS8fSvntS7ulDqN/kuQ+qrc6J/sE/wA5Rji8RyAQ9iduvsewncFOpQrJkXdq3I9Fv+Jl5UwF+LaIADkvMlKog3wz6UCLqvdIF+oHhFOQD999IKy2WaFrU6YTSJGMxyxP0SWh5t5JpMxYaVLzBt+k/eKh14m0KxobM2byXmGEd0VmhUoeO1WI0Se36x6HaXby2LW8Cmt0zG/uJZxApBcxNyMbYAEv835IanbDenEHp6T6TVvlMjczGV65pv8HktW44Xt/W8x0ct868S96N0AF1KrHmBV59wEQqZpOfbP/vVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhAv//qxfpj0KHitK/w/5/t+Td1ryPCOX3m76T8hITk=;
 b=jo6wP42CJZuLpkKH8ilBTaKkIZ78GGz+McGniUYaeDXN/8bXmDWmYv9Ef0jE2qQXrjguL3KzjIDon1M25Q5HuC4oqYRjg5jwLAoyv5c9j6GoT6eYl3jO+5Pt8UKuh5GT6C7PTz0fvz/lQuCb+kXwAqJiizTT1qRhrX9CCunc/cQFn+nDL62VUcmWRSbJnn6y49XbYKb9hVW1X6YG+JUNXrLj39xiQ6W9ZJrkpKeaiNZrSpF7Tu1tOYmgpz7t762RYgsPRpPJ/+twL7FsF0axZuSnnD4CXyADENXKh8RcGRLbqQKufFuL3oQYlGATL39JCVFeuArwxsLZkRhNvwIweg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 18:02:17 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 18:02:16 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v2 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Tue, 21 Jul 2026 13:56:02 -0400
Message-ID: <20260721180158.13014-3-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:610:11a::31) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 19648174-89f3-4174-65a1-08dee7523346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|786006|376014|1800799024|10070799003|366016|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WSSdSEw8Bh6NHS6GfKpnUY5moZK7cGlq6CYEFJ4IYVQTu/7dFPdynM345PXEtaLfoIZH+14FyI7E/acyqdJ9qfHEJJwzVycN8nU+72/QlsCi4LdbkoHsNm4ObYt8HK0Iieffq1AEedyzvbhOX61Uj76n/ojS4lvPjsDPcTcsyO8fNjGTgi9AiJg/e+cyh3w0C5jL44ulQmI9L9VxdoiV4C4qZgoZXfiOxArFU+FotRQTh5JzGeEDmhai2t7E76lw/nytQdbc2OgZQhep1haDhN6Be/4DAXz+zDMTz+EwpYOZY/flgRpuXTUpqbvh00Mk3cLLu9Dy7773LmOojmmQJ02dVUgsdwvbvVVpHMJtPq9yTDkSK19J8uJZWuCZF/Xto45cIOpr5bFzs4vSMd0FAGz79BVZVF8vMErrUahpMgsP1UY3EunEG4iYhJEC/+/SXUbnlmuUcjPgDv4OBciA33nPjHzrnTI6a2HRHTbyrCMOQW8B9SlImVycn9pu3NwItl89QqSmVj1svkfMiMzd6wlnxDfNQeCr1JcSkP899koZVx5uAhHmvgCnZLnw345BlpSC8GKRUSHoakXwmFG1fFQQzlB84wGlih7AnWj22WcUe/OpQ7n4vfs35/19fLx5N20tcZQTd95FhOpxPKgVcgyhGIk+ymzO/7mcD1coAZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(376014)(1800799024)(10070799003)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AC/UTjHXGM2DSY2NChJYZREVBb9KZs4mGiounoTVre9ENH2Nn2l7pga+REdN?=
 =?us-ascii?Q?jqyadyJTmFKLu0O1WxbmpnabxaPqC0wTGYb5CyGXdpXswiLHouNQWGq2u0jZ?=
 =?us-ascii?Q?mPdYIYgKjX7OgPbv9as0gXa7TwdrwYjCm/uQOb+SEOumroE6EOzahb6kiFRG?=
 =?us-ascii?Q?M2VhA3KZzAxXg9ExKj+YHbxJX++v7TjQruC4A6+16xJ6CfN3W10CER4U/u8L?=
 =?us-ascii?Q?3Rm9TgUpfn0TKoXOhSdq+2eOwcB8CX97MHRn6OnAHI+4bhBxZWoXtiCRhIcb?=
 =?us-ascii?Q?XxmmHV6znK3wpmZ+j8XWO6TzoNvXoTPJJ5eIQv0b5W/Oa5w/C1Kre0ZrB8x6?=
 =?us-ascii?Q?871CRh3/pzRTo31VpPGbveKFC5fVGuodrdrDGklm9Pe9ZjpinH+tbycsxcTw?=
 =?us-ascii?Q?2eYmAsgZ1UFenhmcvNuwUfwkgOvn2fYZvIFO4ABqdj84fNreRPbI24GbGwEx?=
 =?us-ascii?Q?/bBeBeYcR6pHXOOxn5r7kMlIcU6nc5qYdZ6LnRSvoAtM1PyIJZ/wHzX1+IeO?=
 =?us-ascii?Q?jNAQjEi38UXck+YfI9ghncPYw/OU7gLFuHkLjdyCFtAN7+deVgWVscsLqLzS?=
 =?us-ascii?Q?xaxbXD1dn5SOtzu9XRjZnJReE82DD3GgyFtso3991UDLjKpJ8a3qJ6ai63xZ?=
 =?us-ascii?Q?8gwE1ztHeFuPmH6sZHT8NaGcibtru3PhBh/JdXTZVv1lKe4FMLFaH8RlHMgE?=
 =?us-ascii?Q?7e43Fqr9/i2E5A30Z+9YV1sUZV2J0nZ28Z074fJHxK76MQQUMnwJC0oQA+nj?=
 =?us-ascii?Q?9sve2jcDVOoQi8DTpYumYsvfube+7Kne2Mhp2BthRIgKuoHHbiVEP27ajsoY?=
 =?us-ascii?Q?C/KujFDHYiqcoy6RhWBOTlqosD0kh5v1715Heemms5ob4ZoKjHV6aqmWsMGW?=
 =?us-ascii?Q?PIICOR4wF+a821QWhVf+Mvg9GK/Iiroiv6z/XJfihhc5p5DUtCnRWugQ1Pio?=
 =?us-ascii?Q?utnOcz8RNI1EonlzqMzeLk7mfdsVHHF4X4NvUBxaFv1u7QoVckHOrUBrizvN?=
 =?us-ascii?Q?p3MLlEq+Mc3MHr37E7dlzzWfIDLdONswk4OaclVWVBIgaNAGNIHFRhofG2L7?=
 =?us-ascii?Q?UVFFJnFH/EDpQKgv/lxKTauYGPi8xazIfzTCohHbNIysNgZOVweR9a0jMXoW?=
 =?us-ascii?Q?/GK6f1fpmwyFjvXRp0C+JINghONgLTOabyJ8F96gnXFMVcFuba2RVSRiH5mK?=
 =?us-ascii?Q?y6YFSaLR2BCOemkQddfun/D0K0YwYiC5N6lUb6OdxdtnN5x99l1OzqM3HWLC?=
 =?us-ascii?Q?GipjNUKpAiN4pz94C6wMtdo/+BLN4ktN099y0dMk/Mf9C0/hSOj9J3mlngb9?=
 =?us-ascii?Q?hjh4ACefAYb/e4fvE3NTg9ZedtDcw7jCBDU9iXmgGaZAQ6Ye8uW8oEt6mFy9?=
 =?us-ascii?Q?I/0UHxClQkjRVRLEiULttbqmjX4kIv2x85C+YoQixdLbzJJw/2Ne4aKdTSni?=
 =?us-ascii?Q?d/BeLDzsl2m5HI0p6VBtyFiHCPDUk5Bid1p6g01Sti9yWRFhygMFvjAv0Pkh?=
 =?us-ascii?Q?B7YZnWNE4qofat/+D4jdH2RxkxALLs5zknpnUurzZ9VfIs5qqHxyJxAsnnrr?=
 =?us-ascii?Q?gjXQQKpEUOffF/1rUaquiGg0KeHVikD5OaKDPXYeMZ1a5HBRPS8Sk+4Lt2c9?=
 =?us-ascii?Q?3olvKoHxG8uX0CElrxKTMdhYOPOYewNks7EFUCgQi8NOirEYedJyteRfj9Qq?=
 =?us-ascii?Q?L64sE5UAh1ybdVLKzX5i9QmvuLFMTn6YMaJDIghqvDjyTB3oJcOarAwpF6QG?=
 =?us-ascii?Q?9riSpQcINQ=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 19648174-89f3-4174-65a1-08dee7523346
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:02:16.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59RDWPIiSGzt3jVD37S3a0aTYCTaxcyEmmvL6b4Wssb57hreOof9G7ydLC7dPuf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

The current PCS code unconditionally uses SGMII autonegotiation, though
the hardware supports both SGMII and 1000BASE-X modes. Decouple the
choice of PCS enablement from use of the SGMII mode when running at
gigabit rates and announce to phylink that 1000BASE-X is a supported
operating mode. This enables direct attachment of the PCS to e.g. an
SFP.

The 1000BASE-X code in phylink also sometimes calls the autonegotiation
restart method, so add an implementation of autonegotiation restart.

Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
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
2.54.0

