Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144ED40F74A;
	Fri, 21 Aug 2026 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294292; cv=fail; b=ZFPF2EZYayxGLwx1nFkXbbkv5JfIy6iG4cDz7v13/kuUrVwswlXnXiVSFqCpzmC+940nQnH4D5yTwaBKUUimf9reGBlJ04fVNIaycpi3/PoUqlleO22gB9HP0lhRJRrIykszd5xJy7KUI69KPpcDkG3rxJOcjwda09wb7HJk5kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294292; c=relaxed/simple;
	bh=TwN0wem3QOmI6gjJ+1FvBFEgY7z1X3/gd+jgtwneAf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KVwlDY2Qw/OCGRf/dTAp+uqYxEs4JYLuW7XYRmhIE5mPPKDqaiHfMKF3PIIZGu49SSQGrpPve5jhSwk65n/aXhkL0E+ODYpmEYZt1rv+6Ca0fNNmYdIeE3yyLJ/w4b1TH1oosthYdbWUWXstWD+L9gIYydmbgFbnOY5yt1m9S60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TqTr6eQN; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TqTr6eQN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQG3yPvsBI7I1Wjby6grokbCj+3XDEzGT6bJIELsyUzEGYGWRyE75hvW9ts5uEYIN2/yLTqKacIerXSHfP7TtbLrBcH1pjSxWHcCiJYGDt1f+2V4imYP8KozmoHNzJVOiuiM52RnKIJWzIsqaM3JYeAzldXI/amnrUxuaWanA8gLdj8U92WWxn98Bta21osTij2ts+oAT81CHOYcPSuQJ4C1McQM6keVnqmmVXcphNQtRcZ6UTPPEBHGNFax/D72yTRLQM0i+2gBtSoDfR3sSTVyjTFCbg50oAl27AJS5aWAGBexbe4prScMdaasaw7PxmSrky0H0ffWY/d2ASXlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3ua1uGqdvypeAC3jvK8IjjGImaVafhDbV09G3Fli7E=;
 b=nLP3XWCyM/icBAursYAMXT25zcFaSTGt7K9yGiPe9gFBttseHkSv1wQlN0TiBSKPweUGMl9FDKuKhDB7qbQqiQUGxQCPh/KZN3LOpo3NbS+wbeRh7jFEuyyHoyRXlzdQoK1231sDwjDwm8wvgmDKiwkL8vbdhkCFXDdCCW79U2pkPn4Is/NzXj37wpib5qLD+OCJ1YkKONLVZVq4STA2/e3k7yAnQ3v03qbR2u9sQgImi8P6dgnChiCh2235j0Huns0e6VRAEIXEi+qK8qzIlCwNeQVovzgFdkSo60+qcF7DgmdUB77YT38EsXqzlIUUXp4UjPMSR4zZcBOWSWRDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3ua1uGqdvypeAC3jvK8IjjGImaVafhDbV09G3Fli7E=;
 b=TqTr6eQNkKHbphRpgxNuW0LLnNLZ38OFPgvgfqtz/9S1Xl0tAykz+nRInjfenbcX1cuy8rnlcclTaZQqp16Em3RS4vAus/mZNPZDbwIdZP82x5L2lLfETCQ2IWBULnnrwAIRGGa1WCif1U4oHFR1M/+bhV0W/aNyAzzKndKcxUIKWQpsSO2jUlylD9TfGL9k10l90gcRO+j6IVelcdpDF8m0CSR/eaJ/mjuhYn2VIOLYFpUcQrpQN3jTzkPnLJmiSSiEI2M2Q5xlwu2A3ePFj68N2aNuH9uVIrNhOfPbLsz+Ch/1GyvZdDK7mR9pzniIqd6XAnwFb3lMvPkygG04Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 06:38:08 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 06:38:08 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 1/2] net: enetc: restore RX ring congestion mode after ring reconfiguration
Date: Fri, 21 Aug 2026 14:41:39 +0800
Message-Id: <20260821064140.1315611-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
References: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3930b539-6e1b-452a-ec69-08deff4ec324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FZw3uhfQoFQNmpBLkitWWbHBu5sAX5k66dTRrg/vFnZPyciGc4ufmPRMiKZtwDzsTeBOOp6VJdAvv6gHTCZ70z/1cjqiXVK/W6iSZv8HrIzjpu9n0uShyWdMBMeizGXgBTHjA9RWyPFHX6UaZWTKrCenhimDRLMYR3twK/0rTmK3jmDU0m/nF+oGy4BvqfFqFkp+UeCoXAW9W2DGMGU4FNyUt5lG+CYTgFwz65QQQdOOZC/F0eg3l6j5Xo4UB1xg8KpVld54SayDr/UBQDCyKwJZE6K0d4K1ZyX7SdGKlS46OubXi9XuBMD/0j8fYmHOOC1/kIFW6BF7UyDShqpMzFMBdKAuAXSYszUE2EQK6HAUFn7lZvMg2kYsVOPjL9ScmDAlm8YYuLKQxEG2c2qfYTYQvWPTCUV6RYPOua+eHb/tq4cStcZji0AgYEyF0u7tSbcoJUiM8qMTew6XVeARiMeNdOrSVx7hF45L/GPuKp4cE20N4IG/SpmAMOuYC57Dlcy5LPZIDxHWXwnvXuDy546aeaWPlZrAEIbfNU63kRnnUMwQDVp5U5t5WPYmTb9PTxfjOyA6fvU9vkUHewESXIZuf5ziEr0wTiu/583mgtNn1UXGfyNvmApu+8EwyDv7iHOrB0Drk1YqO2r49ghHzQBRZouNGxuG76zuKioktnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3a2/6qdx+pnKtNvJazIv8xImI0dsbrsCCtHvy1bBPJVYexpig+ZcNvTtU43a?=
 =?us-ascii?Q?oFlVKkruI0oyaBCLa2sNz8vWo35Zxj6Fr/TEZEtD+LKHj9LoJdUu1V35Vq8j?=
 =?us-ascii?Q?Blyt1TRYd9hFF5RkfhAgA/KwYhS5AqR4ZNoXL2HuCJuwOqPNmi2xkH9eq+nE?=
 =?us-ascii?Q?x8nI5TKluqYdH0LvKTkY6mQXsE3FXunzU2YyxSPScK9xAL8VvQZcYhO81YYs?=
 =?us-ascii?Q?RqMsV9UsLdlBwNFq9O7sdncl0TO9RXUtFlg8jTOPJ3Lfo/UmYpBqosCxMeVk?=
 =?us-ascii?Q?E0G0aQTDL8I9HJVWUFpmHUWgwydOl2ys1WlibXzenlVgUBYpl081DM80Y21/?=
 =?us-ascii?Q?fhOGdps4k2CDaC0sMkpzwHZWGXaDr66+jdqY/o8lvvJwrAa3GSaZ3VtG8CNi?=
 =?us-ascii?Q?1tJbw/w8U4Dpgf6cj9mMEzT21oiF+IiYkYXjKVVp6MvdArCac5gVqEyjqO4v?=
 =?us-ascii?Q?+pf4bI6ieTzbDigd5+O40XlhwTEyPFwMR4Lain20eaWuUmK9cs+lW0yn/dBe?=
 =?us-ascii?Q?ZpK6hQfKTtt9t5rBjL4MQvjNFjN/PJOjvFvVQMGGY9mm1hYwBsyNKPsh9lAA?=
 =?us-ascii?Q?BgeQrdyZiOF5/o49elvMRHf/d5cV4wATnrJhpRTWTKaNKZCO2aaF5nDzXAte?=
 =?us-ascii?Q?0RJyjEJxzY9/olj/flgsnLu/BjPmvZ6UcuLnPY8lGmhi40KU75ncsLMv2BHh?=
 =?us-ascii?Q?fGmR7DYLqPE1HnlNPfZgXE/RQXv1P7/pAaybe6ohL2YYgld05Rd8VvyDYnd3?=
 =?us-ascii?Q?Xm0qkN3AKZwh2u6Fnd4GThey+LDh8CAe+qnjNXpxyQZKOY/32NgPAUQZbA2/?=
 =?us-ascii?Q?R8K//aifg/uypouodlSWg+PK5wv5RrClFazBWg7ABAvV0bCwM9/3d6luZHdg?=
 =?us-ascii?Q?SBFDoonIEkW8be0dspZHRzSG8BZPaVj/DPm6tl/ki0mNh4dzh0xNuKOFqP+1?=
 =?us-ascii?Q?pdb95lO0AoQm+zwpNrcposjLYANkbVCfl1rgLvxBp3pyQWNM5DPkYK5MshgQ?=
 =?us-ascii?Q?WDCWdJr7+9dL2EQ7nFCtdWK9pbWv0F69GaX7kKNeL7xJ05wjDPxqJib0fKaP?=
 =?us-ascii?Q?lKIiOwti2KOG2d6q1Ft4Xj3X2P5fFn7ZxKcKqd1yw3xP7hYPQvnQbH0/fyxi?=
 =?us-ascii?Q?ldJGi6EeZD+tNKMSdQl/fs8y3e+CJL3hBedaSw4NuIvoMGitIMvPjxACRgNB?=
 =?us-ascii?Q?1g8AMHxVO4GghP7RnHwYALty5IB49cWOQkfgrIdvpcVmscCU9bb/pnSgDbso?=
 =?us-ascii?Q?f606uwXeImmWe16vDROnMvcX6awWtmbsha1ox0ECqcKVFLIG+zg4MVEDRc/Q?=
 =?us-ascii?Q?3pkTGrDuei+4X5cPIMGOckiPkh50yQUoea1ZORBQ3d/OAWo5vPZaaBps63MQ?=
 =?us-ascii?Q?5wY3ZCQRN87nOffUVP7oNhhe31+1kNanEJeDgIzTdNGGAfElxsg1OrdErBQV?=
 =?us-ascii?Q?eqWg5qE99zM1ldSAfmwDiaI+jbpBL1eczogseo5VbyptxSEgf2eGTNLI0lQx?=
 =?us-ascii?Q?R/YS2Th+GZXiwX4SmIPRFN32YW/JL7kPEwuC//MMNDXG4eQT5j28U4iCBB9A?=
 =?us-ascii?Q?kCAC1kkJjuoAmqdVvDhh7niF3IyZG6GWem+sPsrde1tPxwhgfLYllqNzDl3P?=
 =?us-ascii?Q?zuJrFnuEyxGtfv8XjtTQZOTSH4ZLT8mSAV8Iix0k6clOSnbTu35FxNnmhLdK?=
 =?us-ascii?Q?U4rK2ocQwnGohAs8PHDihD/UY7rzuSwYRZ08sNnV4XSQZUeajuGOyTnKcf0N?=
 =?us-ascii?Q?SCXYVmRfdeAepkL2jQiNsf3/dfBWlX5w+s0At8OuRKAK6wKn8GjB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3930b539-6e1b-452a-ec69-08deff4ec324
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:38:08.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSooRZhHDm+G0LHmXrGUZ8bxzDiHplg3IU1KzF2tKrCGV+LQE4w0zS5e13DeWzVbbhhC1QQlFBmObg8rrdBCi74zoldg8IChwuvjptckJpNNS1BBqNgB550ffhve2YI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718

From: Wei Fang <wei.fang@nxp.com>

The RX ring congestion mode (CM) is only configured in the phylink
.mac_link_up() callback enetc_pl_mac_link_up(), which sets the
ENETC_RBMR_CM bit when tx_pause is enabled. This callback runs only when
the link status changes.

However, enetc_reconfigure() tears down and re-creates the RX BD rings at
runtime without any link status change, for example when attaching or
detaching an XDP program, or when enabling/disabling PTP RX hardware
timestamping. The rings are rebuilt from a cleared RBMR, so the CM bit is
lost. Since the link status does not change, enetc_pl_mac_link_up() is
not called again and the CM bit is never restored.

As a result, the ENETC MAC can no longer generate PAUSE frames on ingress
congestion, and flow control stops working after such a reconfiguration.

Track the desired CM state in a software flag ENETC_RXBDR_CM. Set or clear
this flag in enetc_pl_mac_link_up() according to tx_pause. When the RX BD
rings are (re)enabled, enetc_enable_rxbdr() consults this flag and restores
the ENETC_RBMR_CM bit accordingly, so flow control survives ring
reconfiguration even when the link status does not change.

RBMR is now written as a whole word from enetc_enable_rxbdr() rather than
by read-modify-write from several call sites. Serialize the remaining RBMR
read-modify-write paths, the congestion mode update and the RX VLAN offload
update, with the new si->gen_lock so they cannot race each other.

Fixes: 5093406c784f ("net: enetc: implement ring reconfiguration procedure for PTP RX timestamping")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 72 +++++++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  9 +++
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 14 +---
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 8e3f345dd9aa..80f0082f6c63 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -81,6 +81,33 @@ void enetc_reset_mac_addr_filter(struct enetc_mac_filter *filter)
 }
 EXPORT_SYMBOL_GPL(enetc_reset_mac_addr_filter);
 
+void enetc_set_congestion_mode(struct enetc_ndev_priv *priv, bool enable)
+{
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+
+	spin_lock(&si->gen_lock);
+
+	if (enable)
+		set_bit(ENETC_RXBDR_CM, &priv->flags);
+	else
+		clear_bit(ENETC_RXBDR_CM, &priv->flags);
+
+	for (int i = 0; i < priv->num_rx_rings; i++) {
+		u32 old_rbmr = enetc_rxbdr_rd(hw, i, ENETC_RBMR);
+		u32 rbmr;
+
+		rbmr = u32_replace_bits(old_rbmr, enable, ENETC_RBMR_CM);
+		if (rbmr == old_rbmr)
+			continue;
+
+		enetc_rxbdr_wr(hw, i, ENETC_RBMR, rbmr);
+	}
+
+	spin_unlock(&si->gen_lock);
+}
+EXPORT_SYMBOL_GPL(enetc_set_congestion_mode);
+
 static int enetc_num_stack_tx_queues(struct enetc_ndev_priv *priv)
 {
 	int num_tx_rings = priv->num_tx_rings;
@@ -2632,7 +2659,6 @@ static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 			      bool extended)
 {
 	int idx = rx_ring->index;
-	u32 rbmr = 0;
 
 	enetc_rxbdr_wr(hw, idx, ENETC_RBBAR0,
 		       lower_32_bits(rx_ring->bd_dma_base));
@@ -2660,12 +2686,6 @@ static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 	enetc_rxbdr_wr(hw, idx, ENETC_RBICR0, ENETC_RBICR0_ICEN | 0x1);
 
 	rx_ring->ext_en = extended;
-	if (rx_ring->ext_en)
-		rbmr |= ENETC_RBMR_BDS;
-
-	if (rx_ring->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
-		rbmr |= ENETC_RBMR_VTE;
-
 	rx_ring->rcir = hw->reg + ENETC_BDR(RX, idx, ENETC_RBCIR);
 	rx_ring->idr = hw->reg + ENETC_SIRXIDR;
 
@@ -2676,8 +2696,6 @@ static void enetc_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 	enetc_lock_mdio();
 	enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring));
 	enetc_unlock_mdio();
-
-	enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
 }
 
 static void enetc_setup_bdrs(struct enetc_ndev_priv *priv, bool extended)
@@ -2704,21 +2722,34 @@ static void enetc_enable_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 
 static void enetc_enable_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(rx_ring->ndev);
 	int idx = rx_ring->index;
-	u32 rbmr;
+	u32 rbmr = ENETC_RBMR_EN;
+
+	if (rx_ring->ext_en)
+		rbmr |= ENETC_RBMR_BDS;
+
+	if (rx_ring->ndev->features & NETIF_F_HW_VLAN_CTAG_RX)
+		rbmr |= ENETC_RBMR_VTE;
+
+	if (test_bit(ENETC_RXBDR_CM, &priv->flags))
+		rbmr |= ENETC_RBMR_CM;
 
-	rbmr = enetc_rxbdr_rd(hw, idx, ENETC_RBMR);
-	rbmr |= ENETC_RBMR_EN;
 	enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
 }
 
 static void enetc_enable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int i;
 
+	spin_lock(&si->gen_lock);
+
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_enable_rxbdr(hw, priv->rx_ring[i]);
+
+	spin_unlock(&si->gen_lock);
 }
 
 static void enetc_enable_tx_bdrs(struct enetc_ndev_priv *priv)
@@ -2748,11 +2779,16 @@ static void enetc_disable_txbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring)
 
 static void enetc_disable_rx_bdrs(struct enetc_ndev_priv *priv)
 {
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int i;
 
+	spin_lock(&si->gen_lock);
+
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_disable_rxbdr(hw, priv->rx_ring[i]);
+
+	spin_unlock(&si->gen_lock);
 }
 
 static void enetc_disable_tx_bdrs(struct enetc_ndev_priv *priv)
@@ -3344,11 +3380,16 @@ EXPORT_SYMBOL_GPL(enetc_get_stats);
 static void enetc_enable_rxvlan(struct net_device *ndev, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int i;
 
+	spin_lock(&si->gen_lock);
+
 	for (i = 0; i < priv->num_rx_rings; i++)
 		enetc_bdr_enable_rxvlan(hw, i, en);
+
+	spin_unlock(&si->gen_lock);
 }
 
 static void enetc_enable_txvlan(struct net_device *ndev, bool en)
@@ -3679,6 +3720,7 @@ int enetc_pci_probe(struct pci_dev *pdev, const char *name, int sizeof_priv)
 
 	si = PTR_ALIGN(p, ENETC_SI_ALIGN);
 	si->pad = (char *)si - (char *)p;
+	spin_lock_init(&si->gen_lock);
 
 	pci_set_drvdata(pdev, si);
 	si->pdev = pdev;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 8839cfb49bcf..d1e9d9130057 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -309,6 +309,13 @@ struct enetc_si {
 
 	struct net_device *ndev; /* back ref. */
 
+	/* General-purpose lock serializing updates that must not race,
+	 * e.g. read-modify-write of shared hardware registers and of
+	 * selected priv->flags bits between the phylink link callbacks
+	 * and the ring (re)configuration path.
+	 */
+	spinlock_t gen_lock;
+
 	union {
 		struct enetc_cbdr cbd_ring; /* Only ENETC 1.0 */
 		struct ntmp_user ntmp_user; /* ENETC 4.1 and later */
@@ -417,6 +424,7 @@ enum enetc_active_offloads {
 enum enetc_flags_bit {
 	ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS = 0,
 	ENETC_TX_DOWN,
+	ENETC_RXBDR_CM,
 };
 
 /* interrupt coalescing modes */
@@ -505,6 +513,7 @@ int enetc_get_driver_data(struct enetc_si *si);
 void enetc_add_mac_addr_ht_filter(struct enetc_mac_filter *filter,
 				  const unsigned char *addr);
 void enetc_reset_mac_addr_filter(struct enetc_mac_filter *filter);
+void enetc_set_congestion_mode(struct enetc_ndev_priv *priv, bool enable);
 
 int enetc_open(struct net_device *ndev);
 int enetc_close(struct net_device *ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a509929f89f2..55c07c528f22 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -556,8 +556,7 @@ static void enetc_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_hw *hw = &pf->si->hw;
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	u32 rbmr, cmd_cfg;
-	int idx;
+	u32 cmd_cfg;
 
 	priv = netdev_priv(pf->si->ndev);
 
@@ -569,16 +568,7 @@ static void enetc_pl_mac_link_up(struct phylink_config *config,
 		enetc_force_rgmii_mac(si, speed, duplex);
 
 	/* Flow control */
-	for (idx = 0; idx < priv->num_rx_rings; idx++) {
-		rbmr = enetc_rxbdr_rd(hw, idx, ENETC_RBMR);
-
-		if (tx_pause)
-			rbmr |= ENETC_RBMR_CM;
-		else
-			rbmr &= ~ENETC_RBMR_CM;
-
-		enetc_rxbdr_wr(hw, idx, ENETC_RBMR, rbmr);
-	}
+	enetc_set_congestion_mode(priv, tx_pause);
 
 	if (tx_pause) {
 		/* When the port first enters congestion, send a PAUSE request
-- 
2.34.1

