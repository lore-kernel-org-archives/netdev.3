Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794378202;
	b=0knnHA2SLXhYMuNb8DsiQ/Z4LCCAl53XeE0tupj038IB1kOIFOgWL2Z9T2Z7lrBjATBZ
	 fQX09ENTW97t0TSevlJ29tXvwqTo3V5Wy4U6h6Xb89a8V2cDu9AlvXejQ3B/Dj0mGM6W9
	 f9y0sA+YZCALV8PPPAiMjgOYxdrd3lYUR/+SUsf9tinmD/B4Cfmnsw/QMP3Q4pmjWCTTa
	 1efvVMr+iB09+skxORustOY/6MqX89CR0t7NNO0omDfk5cmsPIiLpaS0j2coGqGGDS5eu
	 wUii+ZmcbhNqg6U+S3CJLezJXfwzahyTYZS3IZcwpB8Z+gmpgFZHdg4pG3LAfe+m4aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378202;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
	b=r5BNJLcHUZ/S0cxGJT99/plJ9316MuM3QjcZlM2Dil5ML262rtpbSv1LJu6DYxzCvaiy
	 3j9MPEMMy5afjrFLmsst6kS9/oJqPHiitqCMZc2KdrUlpa0PfhP0HDR/qJgsmlNk2jBSZ
	 AGGKVO2alG5DIitLzGg0JaaYPsRGV4YJDnxsukxODSuwDwThr2ixgoDeEm6sy9Yp0rPcm
	 uIz7oR7XvRXKHuH4qfsQ5z14vG6ty9rcTnLpT+TPwXssX35kBaVVWcw4CGqgz080U59to
	 x5mnem0HXclzTBeaClVh+8gQMMNoWPlp+bCTNqBoSaGX2tHTi6BC+mVXOc8NoOfI/pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YM0HzXk8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.52
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645B606A33D;
	Wed, 11 Nov 2026 06:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B645B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YM0HzXk8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKP8XfuROnmbhGkhDRax5EbIiM0/5d6nWBzMpMmbx+YSlz79ZSpjq4xnXMd9C+zcR+moOk0q+S1T84e1QP3gy4O+RYkoZUT7Uw55LoodvQqhclxULNMQlIM81arSpN08cVDDmgx1w9f5weLnTzG2fzUmSJkEuBrHvKZfOIijP01beEi9sysh/3zW8EVUWhmGJSUIdxC5b+7R3v1Naar2wWKmkNdWzywEPatOs/dnDQcC6Xw8O9Hx/yOO1rMIAncB4XlrLL9ZeLe/84vISVsVQYk1IJVNxu2ZSnOBTYRtri9rMVzAPJPM3N/0/GVSAw7KcIrwG70rfoYVahixk3heig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
 b=VRfXv01qKfrdEWqf1QOrgOOH7/Dbt4JhB1lGbSrtx92dWv0N4RJVzJzwIiI328W8BQegtgO0+Lol+GbifPVy0H8+bCFKXvezM0TBWopmJZC6dJZp/OM970LZW1Yngkp/zaEx7CSB6cwe0E2zbhJmMFSLowwEurEu48ipW+83j+ZM+SA+wyW8/qANdYO/35/nESXWus6Gmx36yHpI0GEeZB7muN+FcBbT1TJstsBD/Oi06B0NaFwOXHIWOl/VWmd75OrNz+a4wDw7lsssXqD8L6sVjw1dTH5J9kONZDRuI9EUXociLy7+zzoTb+vrOcgjNA1ROMgujZP84M9pgJ3+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DSbFvEk11tMLyZk3FGVVc3Hsf+9ATadUWbFN90YQro=;
 b=YM0HzXk8qPiZerWFPRpj+DCi64G68o5bftyGDYxV5Mw19xndvicsv5R23KhV1PwMEPWuBFfV6Vk194XAKyjLR6Qs2GPXGjPklLozhh4GUW9DJ/XdjHp5L8AeyGH6WnYEuho44Cso9JBIIz4uSeKxpHBb+laSBkL162O2bOeq1Yb976wljTPJVkq2tl2BApqsINIQcLqXuytlplrdBpT0Ya6p+HWgSZ6aLQL0NWgzsdj22mt0HBuVRYbXK2EEsdOZ2jyyhQJCxH7DpZdtVDmihOlBfaVtVDYavTeIcC4MVUICLHT1ZvvNTBGGz6ZuS3RpaxeqNSx9XMepPMfEz2bftA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:18 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:18 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 net-next 3/9] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Wed, 11 Nov 2026 14:27:47 +0800
Message-Id: <20261111062753.1397582-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f564883-54c0-4c9c-267a-08df3fbc4702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026121527099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261102130727099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	W6j5s3IyzGpqMF6JMf+WpLXbcl8VUt0khNTwH5+CVD7sZrBYE/njJd2VFY86bI5T0a5zYrDbpxHXxBIRbmfGSO3WTK9VYn8Gf127e2igRn9rotsmT6EdG0U8sMlnckwrUc/h6kNpHLO4EICvRlXHYusFqAjYQSX34H6YtYmNeW38MDWa4fx4wQPbfxNZ/AcsMtyfN4JYkFgXvgpGbQ8L0N+lP/ZxT8DQ9S7MmSr8NIavpDkZrTrQsvbup+/zDtuksMivpWZrJeafljhrmrOWdrtKvHsyz8ev6ZHXTckU723Z2NlIArMvFbhacAq9uZY5Xqla8RQHMvXWbRa2nYpTzapBwT7sfAPCHhs41qMCQ6Qn9KpAghMKQlTa7egvuPp2JJEG6sONpGlR/aYOHjGuaRLewY3/MWMDejvl1zazYeMsenBKOgShvpaiigkg4ZjRxeIyvAWWMTgYPjgr/M6tGPz9u5wo6CS9nJNkUizGqYUPWaBhZgU7dpKk8JswVocgUaHjjjdQ9Zy0r3NiQooTt2o3gYdwrvJwqDtw+TFdQ9VUueKCzqoU0GhV/jLe3jrV9mgDlNwDVvz/V0jY4dsOJXOLuqQqqpJbf4pbMoZh6xKO5DcIA5YLSBiuNr1zP3aoBhWMi5r4Lgn2fCMjfsvmaJ4uCUs6X6rdviQPcZBIvrG05GMg4o8B4srIU6QuS/V00K5fDDJw+S6PvgDUF5IPEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026121527099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102130727099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4MVK7IoBnZbJBDQYCWnjjgwvFQk8PJp+Ug/lSLi7yGYncq91W+KyupL380cy?=
 =?us-ascii?Q?sZlR73EsJdhA80M6u13w3ZSN3Y93U0PlHR6Nfx/31nFV49E/cs4hxH6I6Kca?=
 =?us-ascii?Q?35pa31UugfEV3IrYDA6RWCVPpqyaZg3E/nUz/kQdPAQ8WXSSCzOzLoiV79pR?=
 =?us-ascii?Q?Hhiwt2IF0wgHPFqkYDmV5APKes9MYafKy7n7h0wL6fK+EX10SUYV9H06frb4?=
 =?us-ascii?Q?dilhYevLSH7nPypBLOxHG9rLO5cNfNSTSBb3aBDDDMdjilHSoOJJhJW66OyB?=
 =?us-ascii?Q?GwPVRj5LrZn1SNIPrr3nMaPNW3n7yRlYqBQAyw7tDHg8ARt4qP3uU+TgSprZ?=
 =?us-ascii?Q?1q5UYg3wozvMjRace2ntdyTNd1fQVVqbsRRFsaNIu5q3OuczHrnj38TZNmbw?=
 =?us-ascii?Q?2OE8F7npAVhqnmxEopJEe8qVNkQ305+bocT81PgBYj1d/piv77hl3eEGwBT3?=
 =?us-ascii?Q?BY3WvJbpnlZ9H1x63DeEE0O2G/Vhg8YaGftPOIY1kPcc8D5KZS7LWG5xiNV6?=
 =?us-ascii?Q?efvZMOkxwP1ceapAxePj49Kz7RhuMYcr2djzYPAlYVbIDRpwFB7DKmTciuTr?=
 =?us-ascii?Q?YtEGi5r00NPO2Mk3gU4j0MFZHcTru+J0N9PuakHGRe9ZiAvO0Gfo12nc78wh?=
 =?us-ascii?Q?faFhUwdGP3UFoNIcTsT6qbf8SpMZOKv89iGvv6jxvxcoc9l0wToECUn5KJMc?=
 =?us-ascii?Q?TeXwyfA00xKt3jtjK5GvB2GltDSCJDOnf9THgu8+/xSwvWnJ1JlWrgGjjb3u?=
 =?us-ascii?Q?ogudPKYFWQ6XGp/Ry0Qaq8/lNgDOKbPn4nuM+KOyD4aCdVyihN3qsv7HtO7b?=
 =?us-ascii?Q?B7grzgfBIELpRWjur1Hdbl/iD4efXqoTpEFZrQSN3psN2xSDy/dpW8yX7Rv9?=
 =?us-ascii?Q?jn0nSwHuOstX0T7S8UrYQqARWl7CpQRlXyAYxJ9x4suPhNieIBbPlRxVL0vE?=
 =?us-ascii?Q?uKa6zVV16v9b+M/JdrhlgWUeGTnl07NnllcZhtjf9I7ZszZvRwl1mdIcloqJ?=
 =?us-ascii?Q?CkadjuFihE3xaTaKxWkSJJXCRqwUi3CO1KcGOo74puh/4TCi8aOMbMTAbz9G?=
 =?us-ascii?Q?qwWsLNwARzGV3DKLteVq/AOrAS43Pb6oRNcHJlcDUZv3wdoBiFiQangXLPES?=
 =?us-ascii?Q?Ntuh4zznueuG9uTxjmzyh44QPji+IYcC5Yevz/iRrR/WZR52eTbRHXKsSLJ7?=
 =?us-ascii?Q?630v+F//MeBfDpsRk1oDECrR6nglwJ/UQRA2nvjxh+BMmE8j4vW71D0Q256P?=
 =?us-ascii?Q?U1d26vfc/ub+oC+Ig+scDgJWytbNSB9PfpU2YVqdhlLW8kwYFRJT2T5FhToi?=
 =?us-ascii?Q?5VBwFKGGAHi6g2OxNhsDOlOAlU1uZku62vnb+l5eLO0u/KXNnBbM+TSJ3t7V?=
 =?us-ascii?Q?TaliuZ6mwJhCY5u/WvcSOHrrZzhgMggx5D1L7COid3KHewdXtp2qqb+O4BNn?=
 =?us-ascii?Q?WMHSZn6n3hrzihCG7ud3z3U5CRVCNlN463DeOU2GbzKM1gvy4tyO8FIMFfC4?=
 =?us-ascii?Q?UFD9AbvDv1OrdBwRP3Ppe/uKhAvIVaPb1yOZ8HHkx1jMMBzDxIggXBsj/G9c?=
 =?us-ascii?Q?p1yyrLfzUFMXz8ulfhKmZ2p8t01dLQvfvBofY2ZXmkzKaDVCdydfkOb1sT2H?=
 =?us-ascii?Q?55Q/hZG2F5V2evxbdfEwwpTpFtWyo6IH+2hnuJ/xeCADKhvSeWgPpedgkUUE?=
 =?us-ascii?Q?1fGbR7SxfbW7xHN0+cx9qBN2jPPaaH2k7YUDr9nYivDoivpnYgAuFOi2+sgl?=
 =?us-ascii?Q?9hxIFjAPg+1jd7lhRYgYpSEPn7bc/hqHUBXJi1h+VPj5f6rTTsYc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f564883-54c0-4c9c-267a-08df3fbc4702
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:18.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvJjEJLYCjOu1YhnkaYxL1AR7e/LRuWNE5hSxPO2kAFHaglESUBpi73bX7gQ538nb5CyjKrZRJ3zv7NKxl7yiF7J1xcIxjS7DrMOIyMwfJoztct8R2cBmXh4/i0vU+ht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

From: Wei Fang <wei.fang@nxp.com>

The NETC Switch does not have its own time registers and must obtain
the current PTP time from the NETC Timer bound to it. As they are
separate PCIe functions with independent drivers, add
netc_timer_get_current_time() to the Timer driver and export it so the
Switch driver can call it. There is only one switch in the NETC IP,
and it is the sole caller of this function. ENETC driver will not
use this function as it has its own time registers.

The Timer may be unbound while the Switch is calling this function,
which would free priv and unmap the MMIO region under an in-flight
read. To keep priv valid for the whole read, track each probed Timer
in a module-private list keyed by its pci_dev, and protect the lookup
and the register read with a global spinlock. A list hit proves the
pci_dev is bound to this driver, so priv is valid. remove() deletes
the entry under the same lock before tearing the device down, so no
read can observe a stale priv.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c          | 63 ++++++++++++++++++++++++++++++++-
 include/linux/fsl/netc_global.h | 10 ++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index aa9be8e2a630..c6170f407090 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NXP NETC V4 Timer driver
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/bitfield.h>
@@ -123,8 +123,12 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct list_head node;
 };
 
+static LIST_HEAD(netc_timer_list);
+static DEFINE_SPINLOCK(netc_timer_list_lock);
+
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
 
@@ -985,6 +989,10 @@ static int netc_timer_probe(struct pci_dev *pdev,
 
 	enable_irq(priv->irq);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_add(&priv->node, &netc_timer_list);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	return 0;
 
 free_msix_irq:
@@ -999,6 +1007,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_del(&priv->node);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	disable_irq(priv->irq);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
@@ -1021,5 +1033,54 @@ static struct pci_driver netc_timer_driver = {
 };
 module_pci_driver(netc_timer_driver);
 
+/**
+ * netc_timer_get_current_time - read the current PTP time from the NETC Timer
+ * @pdev: PCI device of the NETC Timer
+ * @ns: Output, the current PTP clock time in nanoseconds
+ *
+ * Read TMR_CUR_TIME from the NETC Timer bound to @pdev. The lookup and read
+ * run under netc_timer_list_lock, so the Timer cannot be unbound and its priv
+ * freed during the read. The caller must hold a reference on @pdev.
+ *
+ * Context: Process or softirq context. Must not be called from hardirq.
+ *
+ * Return: 0 on success, -ENODEV if the Timer is not present (not yet probed
+ *         or already removed).
+ */
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	struct netc_timer *priv = NULL;
+	struct netc_timer *tmp;
+	unsigned long flags;
+	int err = 0;
+
+	/* Serialize against driver unbind, so holding it here ensures that
+	 * priv remains valid for the entire duration of the register read.
+	 */
+	spin_lock_bh(&netc_timer_list_lock);
+
+	list_for_each_entry(tmp, &netc_timer_list, node) {
+		if (tmp->pdev == pdev) {
+			priv = tmp;
+			break;
+		}
+	}
+
+	if (!priv) {
+		err = -ENODEV;
+		goto netc_timer_list_unlock;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*ns = netc_timer_cur_time_read(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+netc_timer_list_unlock:
+	spin_unlock_bh(&netc_timer_list_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
+
 MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index 5b8ff528d369..d4a26c17f99a 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -6,6 +6,7 @@
 
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -22,4 +23,13 @@ static inline u64 netc_read64(void __iomem *reg)
 	return ioread64(reg);
 }
 
+#if IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER)
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns);
+#else
+static inline int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1

