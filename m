Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020124.outbound.protection.outlook.com [52.101.85.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C9440A13
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133889; cv=fail; b=QZbYxt4jxPfRDz8wEOBX7PCsLm294mhg9kN6kVkh5kMJDS3oAIaPcUUywXciVxC7GBzgRMBW0JQY+CiZjofNr1JqmLRrppWiM2FnHaKUVk39wFXUj6txggDPUiXnLj9z4+9GjlEGSBoRGBVEJ8eS+FpIEyUNguiu9ddpYy+FtXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133889; c=relaxed/simple;
	bh=r5tpCmkK0Us8eY/pFGLj/j7dyoMAcFTOQJlhUtWh4Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ju14Z1NNmntjJriRkc9ZYgXXmF7mYwo++w7JsC8z+qrzgDnivP700+VNXYa/QetG3ai4gzcWyvz049+YTwEK7ruKUd7ax+VwwysaH3M1Wx5XZ8gtzMTGQPIfi73Sm5USYhygfp8amz+7DIL3e39VTBH7GQsR0tJEDUVc4EOoZvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=vdXjS4Ga; arc=fail smtp.client-ip=52.101.85.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="vdXjS4Ga"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAzDQ2wdJPkUWPx/Nw7IUMphBqyTyolv+h/AizFf8OqhbtZC38CnQanI2+2uKHmyKzchilIT7FFAFcF200xrTzC85n8eu5XagnVjGnJDy4Da5h5QAWVhzIyej9P5jykP7ugzPUQ5RlT9/a4h+sfYaWhIbVaLZ1gkprvHMkaLo6pKd0f3IBM+9/hReu5L4DIogjefNGjLfWDVNznrz1uza+lx0z28CFE+PpKc1l13zpkoVLvl1T5H1q8WvTesNsQahdTN+yE7RenHITzMgnpN1ff8tdyQQDm20nacF1bMqNjXs+n9WJ+8U6bryQY1Dczc2KjXENuJNKJHcFZnufizcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4MdWBYtUWYIHJcIRGyWZw2cSIbSB1elTdxU2nJNitw=;
 b=DWq79W3hM9t6wOzV1LShrwfyE1XZP50EKqQfO4aRjX+uiANuHBTQ3A4kwlq0+ZBOuUMYdlHg2w5sfChXNksoc2HjJ4T7Ye7bX5vMSIMz4W+ojFlw3k1xdaJfnX8EXANn1IJPoSQdYiIeV+IN7GFnIZpscghKu+yBTKhL5f3Thu+zhiQnrsMgnmV55KxAH+sAen7BElRvNp22Rav5PkNITQnCvYFZIBbr8LrGHWukp3yFxJ70ycYbUMhMbar3K+EoCUqXU5JFhp0NpFpFReYjGQaIZBAOoKsXtyHZj7dfETNWEX4E760BbT45vvv9GGkhTSDC+M/9Dmmd4gmCm/xEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4MdWBYtUWYIHJcIRGyWZw2cSIbSB1elTdxU2nJNitw=;
 b=vdXjS4GaR036RKrqZUpZrybZlsnQ15faBVt3Z4018/lj4CbiSYUQYQ4j47eqJsn78amgeZyBmCpuFHkzvBF18u7cwJU6YyeClxT2LtuGZy2d7fU5QHbJAV9WbHtY7yAx3wfElRlIsiDEuiLJrWGJXMu8UgPlQRrsp6b9AvGk9zTGywiwpWB42O+5apxsWRJQX+pCMS3czcQVDKHliWCaX1eivGamqYrgpaHtZduS2s5/gGFVASaBZeTmGDp9A64CvA8cr3Rz43HV7v1LWkukWu3q5N7SqBzvquCRnroqIQC1DVJbYXWLfbikepRGQjk7zXkdgkiIvYUdZASBh3OyZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 20:18:03 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 20:17:59 +0000
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
To: netdev@vger.kernel.org
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Subject: [PATCH net-next v4 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Fri,  7 Aug 2026 16:07:47 -0400
Message-ID: <20260807201741.3275-3-nwhitehorn@pa.msu.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807201741.3275-1-nwhitehorn@pa.msu.edu>
References: <20260807201741.3275-1-nwhitehorn@pa.msu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:b0::15) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4e15f8-e256-4df1-cc31-08def4c0f963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|786006|10070799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yAmiMWE88rINkBJXea3lKbRQJ5BDsJjSk+sJ1ZUn4M1eWh2mO5KohXSUD/53Fyw4zb8fTA3HDD72/RIJleXDSisYxoKRgRINF5Kbp4MI7GGbEtWZPIrhuGOkdpX5jHo4eu8VWViDHt/un7UT1mWTGf0jY++qUfwrRlZV8e08miFjh7XsbHQFTuKqbDDvxkGkkv0Iq50TS/pJQT7Btu/SDCI6hWd/ZyJhua2e/Q2oSuBbqVFumzr9KherUjpwbwVRg6Yf43uKUMWjoq4pqyiVH55bnNGimTR1pxhIOOrcjk6ju+KVy7QBhBSU+6teLEM6qqJFzxovtqaStKfmDVg6nMoQipUXMyVL7CeMj67rQpv0IqVawiXtpD30wgKQhZB6Z9Hr3DD0WQh87hYDVzwVWggATymG4+RS110bXxOYNeMR16lS0DvKFb68STVG6wKneCRR9UTB0VhFhIIWjAUTmjByrj6OTLAQHT/DvNvgT4mtuz0n8HQNtbL9dh/cTlT/SpZCFmYOfOATSmpLnwPRQPHCpE+q91+WYdZKLSdr7Qht687iWSLuMIg7J3zV+hrNmhdqroCHWg0rOKvOsRu08S+AolIueJNCZSgaHTvFJn9xZkWtZpiLuwKvnxlm1qZKL+1tet95LZBfMBC9Qr3Ab8Tw6VPWXiuprcmRtU2UsC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(786006)(10070799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J+ovJ37YjPZTO059nk66KvXmtd0n494fLxCHSErFfoj5ryR8jkEnkaH26EP0?=
 =?us-ascii?Q?29SsL5q/QmVsFNIjbc4U7FFZKoceePyeZBOgstW1Kiputr9ZTrJVpqj3zNeA?=
 =?us-ascii?Q?yjqdX+rU/XQzMPDdlWdIBS8OVpVffgHQQ/w9y+HNiZbbcURel/q03nwFZPK7?=
 =?us-ascii?Q?FMw5+Rp2KH6d3jl8ksoAbcrYJ+ntCSFl/7XSdl48CiTMygTbrP2MdljTu8Jh?=
 =?us-ascii?Q?6QnXZMVixUnCEuFDYfF+tcrzyqQtEHBefcyFEys1U4AkaIRg9sx9rfst670m?=
 =?us-ascii?Q?A0QdIPpirtWLmhqZ23Xypnpn2FW9kaAGBAOBxfqDGSah6Zj2jcGoNODJJa6b?=
 =?us-ascii?Q?pZ4j6AmtIwzZJNtDJrdR4K1Jm0ONt/dI4yaQoEc51LvKw4XaoGW4uMMtTvsl?=
 =?us-ascii?Q?zcLH6gnW07DEeAyWhpN1i6XavrcjOaZUE8zXJyxWxlp7t1eFwa9fr6tq3aSt?=
 =?us-ascii?Q?KMln0gzhr4A53uT/tQ/CTdlVckOtmsoCHPDAi8b0RZAjxgJ8cA8pTqpsDdQs?=
 =?us-ascii?Q?iZO6V3gdZw1CDeYbwCycUS6n0p/gH3gFTNOLCorIc0A1Yx3OJYVRCyUIV0SP?=
 =?us-ascii?Q?lpjzxkUsD1ikGOF+eC5JT7IFVmpXvI9LUyym8wwCGK/hJTCAT/fD1eV7r2yI?=
 =?us-ascii?Q?trf8HNGFZ0wG2qLBbeBa5988t7BvkQhTMgGc16oi9JQ2Q0wHs4P0xSofXuo/?=
 =?us-ascii?Q?kuwDbEY/+Mqdr89jJwqgTuIl9QCplhvbPyXuc6ytDDOYtDKSZbTPtkxxW66h?=
 =?us-ascii?Q?xooxVcpjrc6LUcgOTUnpCqOpzvI+Hg74v4jQviDplVnu/8jAAj8olcRyOFgP?=
 =?us-ascii?Q?oMyvzvg46/qMnRHXx3WhrkOdwIzuZCLw1t0nDIRe0JmtI9IsAgGS2nyJyMf0?=
 =?us-ascii?Q?oJNbOkWm75xPy0H4Siha3m+iIKnIUcuLg36LrXqWbKkfflvo16H4YmR2qBcH?=
 =?us-ascii?Q?ouYgt5HI40y5g26af45PPQkz01Of5aAOc6xE/6DLI/GJJ/vqldzLaNbPmhGV?=
 =?us-ascii?Q?GmZfc9oXj66kYy0fedk7fNE1Fa4kIhmRjLsoJ9wX4JR+H+tT3Uj2wUa1+8nT?=
 =?us-ascii?Q?XeQneUIjqkCJCVWPIYQFayArgJBg4RUn5SN/XKV01TG/wD54lY50q/IC2Kne?=
 =?us-ascii?Q?nr/hMcvc1rFow7+5OmJzom3YW5VGdCCV7R/42CVMPXLoeaPNYfD2QCOrTmjw?=
 =?us-ascii?Q?NIC9L/mAPI5jVD4QQ8yyfoeXAOyLhgsZsXiL8hFO/yXiySwzRvSwtiAWZnSr?=
 =?us-ascii?Q?lQTj1H9JwTBkijf2x6h0m0KbHBL6cyrxBRaIL9QZrBwKzyUIIR3nSQS0Dllt?=
 =?us-ascii?Q?3SB9Y1I/ZETw1eCr7fJHL4jStjxFIR1WxVor152Xw3d26l3mWoo8qtk4e44V?=
 =?us-ascii?Q?fM22v7JqsA8F1tlgOfTaJPiB/6rGnCpOXr+q21ljz9AioeLbU32V0xNtiwG+?=
 =?us-ascii?Q?Iod5F+mwlMJpxU2GD5Eja25wz+TXY11AmuNiReoM2gmivT6CLX5+yCeUHhXR?=
 =?us-ascii?Q?NO5v4LSMUK3wmiyv+skSzUR0D9Oc/ITAy0A/s46am/dV82xXyL4WSdQjxBZB?=
 =?us-ascii?Q?RmY/1WBy9QH7zFsiH25Brm2nvZHqD8rDeve+ydU37lYv5RLF5Cd12jZSUiVF?=
 =?us-ascii?Q?gk/SOYzZdOhml9h36WMxKuIIzfZA0abGPT5/HDxSntHGZnS5B46wxOwlUirX?=
 =?us-ascii?Q?/dd/UmXgeGwe0UWfwl1odYp7SRzDnKxsZ7Jj5Ap/8BAxVbUV72xzyCxTarCH?=
 =?us-ascii?Q?6iZoy6mOxw=3D=3D?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e15f8-e256-4df1-cc31-08def4c0f963
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 20:17:58.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+oTbMMTY0jB9aiSMILTrsxPZ3FnemGankAQvabfpC15IwE+bd5YJF69jI5Qt9Z/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

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
 drivers/net/ethernet/cadence/macb_main.c | 30 ++++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c15a9c7e69d3..2252e6a55072 100644
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
@@ -609,8 +614,10 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
 		new = old | BMCR_ANENABLE;
 	else
 		new = old & ~BMCR_ANENABLE;
-	if (old != new)
+	if (old != new) {
 		gem_writel(bp, PCSCNTRL, new);
+		return 1;
+	}
 
 	return 0;
 }
@@ -750,7 +757,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
-		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
+		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
+			ctrl |= GEM_BIT(PCSSEL);
+		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
 			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
 			ctrl |= GEM_BIT(PCSSEL);
@@ -957,7 +966,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &bp->phylink_usx_pcs;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
+	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	         interface == PHY_INTERFACE_MODE_SGMII)
 		return &bp->phylink_sgmii_pcs;
 	else
 		return NULL;
@@ -1032,7 +1042,8 @@ static int macb_mii_probe(struct net_device *dev)
 	bp->phylink_config.type = PHYLINK_NETDEV;
 	bp->phylink_config.mac_managed_pm = true;
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
 		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
@@ -1061,9 +1072,12 @@ static int macb_mii_probe(struct net_device *dev)
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
@@ -4932,7 +4946,9 @@ static int macb_init_dflt(struct platform_device *pdev)
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

