Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732303B0AE2;
	Mon, 31 Aug 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146591; cv=fail; b=r8Y5j+392mm4Pp8GWSHZkJQkQu5eWz4SWHJGeOtHV0O151Jsj89rqbJJiDmL5Ubi5GJlFAN+JG0w0UeXrm5bcfFKGm6i37vmDQs9M4LcT5GCmTLIHdqh4YQdi4H/ouPtQXT3nLOD6Jyrco1sRix4fryQgt/Z5FKBeuPnIIvSJHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146591; c=relaxed/simple;
	bh=U3l1HqIqokopGHxLqigK1/CvcEnnEHjJd+0oKp5A9Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eod4SKW4Wwe85UhyK8JIhhIQd1zAqVYFHcsC5ONm+6twcLDBER60aLIuvlIY2blk+oKV30tN6Kc93Ek22BdvI69ey9s6+6Ka6wI5T4j0P7gegHMW/rMFJjU8HFU64e/qh2Tnlu8+3zFqU0+2+1WkTcgd7BQmZCho5AQ12aJq+Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uGqNZiSR; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uGqNZiSR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPKRbLIx7ZiNvq2QsxtIGvJ9o/NCzIvN4ked9lrlQh9+fGq0vQcTIsvr5KzhM2xjOWC0Q5DPPFO96f8bHsOzFqcJepHGIDMi1B+8G1V9HbVWyvOPr1Sq9xoeBKWrxm5fgggBzGnfNiJOi4a7DNfMhtSBEqam/3O1thfsg4glXqLM8xI+goKA89EUAuVkxqgKJp0IYhXVcLZzMvisORAB5OtbfhXjn/u8q/dVDV5r4Ig5yjUj4erSDpWHKOcqts6FB9mXpa8jET1KDNeOREtV6jd20TtqoeTtzRzDWn7nkigzMgDku489eK4IOWZnOyR++WVxEb+LptgF3okfI+NB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AE1lFma4s/MOtjLpoYXGCBIX2x5VD57l+4/bW04q6A=;
 b=CwhwGg9q8sdVsCpX1jfhjx9JvQ2gngfVpzwQZVOfpSV4g0GRTrFmj6zl+5/4vq/PQRAJyK2V//T1OJO9Mslm09rz1Gtz0h15W2WlvggRjRq8m84Yu88p+fGKKnKk0wNU3GL5nGZEBrl/vf+cOJLjp3rch1AQsTK8Npm2UldBZ6cBDIz/nEcG8rv80bCcpmp96bIPO7cM/k7nr3ehks5gFpeF6AGvIk9oBDjoWKRZPpo9NGC6zTlmv+wR3qXQXYkoa9ZP0N2nXSR93/2+aYHtwtWB2QifLbn397H8xBIjjOrKoOxqyUF06Bej2HGApQxqz1/V5AtBy//q4oRDw5gvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AE1lFma4s/MOtjLpoYXGCBIX2x5VD57l+4/bW04q6A=;
 b=uGqNZiSRk78Oxd3QzwKQeIxp3KU2S49ByTLSiXeQxhMxfEs2Ugf9EaJvXrWzLXxkMmEqcYFIR/zQIRUgAF542K7fnJ0onxiOGP2BAlC3sBNDNUJ7JdEOZ8f2s2Seplba+pyIOh+0hFMwxX1C39UVINln8ImhMBeCPe6D3ToskDNfjf23znSImsBNQhQlQRrCvGYTTV8l96iRMVY1bkMi5JkyRkjnj6WIlTBdkaDPITacQkXqkTy5VW45k61ySG53GntITc1B5GCHqJe47PS3Yp0PkKrqg98Q6cpyCkOcoxLdwbe76bwAdrjym1rnKUSOQM20qn7wR9aXnJTzSR++Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:06 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:06 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 08/15] net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
Date: Mon, 31 Aug 2026 10:54:34 +0800
Message-Id: <20260831025441.635045-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b78df3-09f8-4500-c535-08df070f2c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	nVyILOjR+9DX02PDG6j5PTHzJEHWbrSudwRX8smMxbEPKx2iAybuIl4TBVlEk4jUBPgA/l6abiy5nmaIRa6ifAZ0GysGq5PNu8R1iCIyh/uAikTsmWAg5W3EbeB6p9cInLpBRhsQeiC6u71i9jqpAlB/nOXwGBLwxRgGFrcfFvq9D1eFALi0FDIFhz/Lks7hMN3OMvx1mr6IMySCo0n7YUmrSEHPv5ul7eBGNlTjCdwoJw7usjrQ1XAdSmwypA9T6aKeeIaNrZhqBPWhLQUWuiP5bq1b0+h4c9JGW26I65Rsck9MSBvG6JNGPWMHv+bBIAncOH80PzV4RDzfGlnYgAKEQvbkjtrBDYXt6RAcG17T84KnSku664jjMe9NmEPSMLqpyvCT6ZmpDjLjM57irnbyhQCFDqWMHqtwI5q5OiM/mgRKO9eXLS38AhNOWFxRZ6CW9ZCJfySG9AJM3sJlCjKdwDqsWeJnE4DHPpCq98mMve/H+uveNjdsTfgS2T4Il3/yGT750i9q6UZN6qsoLhFitG81j4cnp/oeYHbt1wirvwF8B6Ak/TJUKFL62ofbzbPHeixHnG8yR5CPH2xAb3bIAWr5N9yeD390WYzB50C5BwF2EVr+x4U1i/hC7Vq1hZ7HN3+DH/FTaL8/ubm1mZU+rf/mIhHhrkHTlS9xhLBfzR70NJy+Z+uU0ew+35SIH/s85bGfVfYtGOjPfWpaTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ibUQtwhL3dTxU9iEA6cGbTSCZ6erALeUxJ7HHxK5y8xWGyMCsOWQW40j/kBk?=
 =?us-ascii?Q?WIqDNdLtgu1c+bMj/Cv7JdRVBc2KTqFUwrcIFz2/y0c3e2mqSycHjoojimvC?=
 =?us-ascii?Q?FWxxGD76d0RF/t5Ocwlx10VaM3c6jfFQdVK/htJaC+XWVltHBoEJicW75PYq?=
 =?us-ascii?Q?XP1hwaUsbl3ITzHwt6YdQBGXlCXNYsFACZLSBGCTiRt3wA/vyqAl9aI2CWpQ?=
 =?us-ascii?Q?iMxUe82lvbIl+oCYdFMsT/M87DdiFXYLtp2Mh585W4qdmHYScaU9ICJNAaO3?=
 =?us-ascii?Q?r5JoOXvrKpStSbtfvkKtuW+8tkS2mu758Ah+FeNmbWsX2xIFdNtCbfkKaeRn?=
 =?us-ascii?Q?gqW8Pl02Prrbe3qVx6mQSN5+LBTRsgY4c1/SLT7rdDIDox8elJZO66oYXKcU?=
 =?us-ascii?Q?O4l3LVl7CBiFg6OguJMFyDGvDr/sRxTjieCOuIwLcwbPk+ToVbzt3BUpXwxt?=
 =?us-ascii?Q?ORQcUqaa6253euyzg5XeYwqjOIbLUO90pTCAQclyRSjZ2s/q+WiyvPvVgVsC?=
 =?us-ascii?Q?pQrzYXHejjZgfQg8QKRb/dm2jShMiPKRkSbRVyTXjPHrHkUNkBRNXcsvTHtC?=
 =?us-ascii?Q?ezG2bFooKueRV+gkaYCDvZRcYKq7pP5e2vZ/XhOh3vVKAGXuc1jSThVTa9cI?=
 =?us-ascii?Q?kV6gDhCHaMj3Bn4lrTDfN1xXENLct5cOVCg86Bgs6uH/z2TeRTkP2ep9r0Sk?=
 =?us-ascii?Q?CjT7Qz1dEfi8XnEEI8Rxtdrr8RSUcsh9A5Up3tRdRUJ+6e6MC3q64ckhU1Zb?=
 =?us-ascii?Q?dvlBtH8jGyDJHUDQZ5EPrSNGbabTtf9WfHA5vsV1t3mRlO8td+WdmhUT1/Lq?=
 =?us-ascii?Q?0JqRsqt9uInFgIojl8TDZs5UF0JdvmEp1FVh+g6Masoejp5zrFfhANiCy1Of?=
 =?us-ascii?Q?Tfq7GvHXEMD9uVxTzPtnKnVX1J9pDSvZbUCPdzyUp4iTE3lVaYtCHpQtZq+H?=
 =?us-ascii?Q?Z9dEDYXqTEXtqn+1QiphrD+3yfvzU6YJagBEfOHNDbkz/pEG2f84nNSknU7x?=
 =?us-ascii?Q?a4/Ge224zjCK6gomhS/w10jBDt1R4KrR+OGC9hUePT8CvaCnm3I2UeJO/2kg?=
 =?us-ascii?Q?BpKATyH3OONuwpzoXJc1+0Ozh67z9bSHSKqQlbus22xz6HroLfVMdaH0ll/c?=
 =?us-ascii?Q?Lbs0DWZqs5WO4a5GNg2ZMMXSKvEGmzMfNW2/Pnzg6L7YDCJIXZwWY49x8X3p?=
 =?us-ascii?Q?QS8zQWFmMb6Pb1NBZjaaMrbw2Nh+ZIJhb70DtwSxCUg6XemyEnwTOZiKBFKn?=
 =?us-ascii?Q?o5DzOC4I2L6D+G0nmvIBJqlQOaS3W4tUC5iEb7t0fQuQUSVUdnJuAhN2w/ZB?=
 =?us-ascii?Q?Wl6yqIVhFWVnjdkIYZsvUEgx+EiwyIhn6/SsRHyDvwi6OANYPjpsG4jy3sVa?=
 =?us-ascii?Q?lQOuUvLp+nfBK3n4yGrUlD/zlEYqR6sjAY6YfeLCsgQBF/DV/JQeIuekO6Q4?=
 =?us-ascii?Q?9eHsohA7vuHsfqXy7giBOWxR+cIsO+M9HalfVJKButn5mSObHFIeISCzSLYh?=
 =?us-ascii?Q?bA/890QnHx//YCvAH4RFI28npCgGDoxBqYmjrkNrTM1pT46US8jl8lMteenW?=
 =?us-ascii?Q?VAEdC0rxPRknS0pH1dJiohea6jR26P2Y1yBaGJmr6lvHl3kh/wBIgAeoBbWs?=
 =?us-ascii?Q?5nutHFFm/IEzqwW8lgBWryTe2xpbPvd97T5vNAyY6Ge3IxwBQpDdDmpiDFDG?=
 =?us-ascii?Q?yf6rSUz14TGJlNuxYu04o2hu5kIV6lzLhzxn+Ds8c0Fo8qXl1rTtP4nSZmKQ?=
 =?us-ascii?Q?C7RJ+Ll2ffLldofR4QARIkCngOKM71KYHWjxtt39CfIXw7atbiqk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b78df3-09f8-4500-c535-08df070f2c89
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:06.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcIZBzPtGGcnN/Sw6nEa+lOy9zaB7TqEW/2KB3jWoOQR53KX+jL1fmCQRJMOzTuGqaYj7FLDEbRQIaEgdxzSq/PcRbtez/wThDzQxbfIlM5KprJcApOJSukuPdVkDPpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Wei Fang <wei.fang@nxp.com>

The mac_filter array currently resides in struct enetc_pf and is used to
track unicast and multicast MAC address filters for the PF. Since struct
enetc_si is the common structure shared between the PF and VF drivers,
move mac_filter into struct enetc_si to prepare for MAC filter support
in the VF driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c    |  6 +++---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 17 ++++++++---------
 drivers/net/ethernet/freescale/enetc/enetc_pf.h |  2 --
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index bc713a7c3aa1..8d7c1790b672 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -336,6 +336,8 @@ struct enetc_si {
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
+
+	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index eeb70feeb773..363ec562934e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -137,7 +137,7 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *uc)
 {
-	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
+	struct enetc_mac_filter *mac_filter = &pf->si->mac_filter[UC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
@@ -172,7 +172,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 
 	err = enetc4_pf_add_maft_entries(pf, uc);
 	if (!err) {
-		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
+		enetc_reset_mac_addr_filter(&si->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 	}
 
@@ -182,7 +182,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
+	struct enetc_mac_filter *mac_filter = &pf->si->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index c467dc05510e..523c71324780 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -60,10 +60,9 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_sync_mac_filters(struct enetc_pf *pf)
+static void enetc_sync_mac_filters(struct enetc_si *si)
 {
-	struct enetc_mac_filter *f = pf->mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *f = si->mac_filter;
 	int i, pos;
 
 	pos = EMETC_MAC_ADDR_FILT_RES;
@@ -115,9 +114,9 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
+	struct enetc_si *si = priv->si;
 	struct netdev_hw_addr *ha;
 	bool em;
 
@@ -133,7 +132,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 	/* first 2 filter entries belong to PF */
 	if (!uprom) {
 		/* Update unicast filters */
-		filter = &pf->mac_filter[UC];
+		filter = &si->mac_filter[UC];
 		enetc_reset_mac_addr_filter(filter);
 
 		em = (netdev_uc_count(ndev) == 1);
@@ -149,7 +148,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!mprom) {
 		/* Update multicast filters */
-		filter = &pf->mac_filter[MC];
+		filter = &si->mac_filter[MC];
 		enetc_reset_mac_addr_filter(filter);
 
 		netdev_for_each_mc_addr(ha, ndev) {
@@ -162,10 +161,10 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!uprom || !mprom)
 		/* update PF entries */
-		enetc_sync_mac_filters(pf);
+		enetc_sync_mac_filters(si);
 
-	enetc_set_si_uc_promisc(priv->si, 0, uprom);
-	enetc_set_si_mc_promisc(priv->si, 0, mprom);
+	enetc_set_si_uc_promisc(si, 0, uprom);
+	enetc_set_si_mc_promisc(si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index fb48a06e6c42..06dc47164dc5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -38,8 +38,6 @@ struct enetc_pf {
 	int num_vfs; /* number of active VFs, after sriov_init */
 	int total_vfs; /* max number of VFs, set for PF at probe */
 	struct enetc_vf_state *vf_state;
-
-	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 	struct enetc_msg_swbd *rxmsg;
 
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-- 
2.34.1

