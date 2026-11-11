Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794439920;
	b=P3a+5vTSr65OD/h77YFjcAZKGIJIU75WWziPJ81SCb5mcak6I3kGyC0vqKPwK7FHosWy
	 Sg3VKfA7fMR76Dr2tqG6sTtz0UIq6LbeHllGeSdktPFRTAYtZZ8sGkuGgABRp2rHYvWR7
	 XZ9VA3RURcTiw6SUpPqLfgbl8jcoNoGt7WaA33Id+52wjs5dXqpJD+fuf+skmKxRT+CuD
	 Q8e+J5z4QvyCoVD9UPEGB/8lYkph9YH9qcAGiDf5Qjbb0TAhVTjEg6T4Q8xhWBbOtc06h
	 loBglR58KZLXe98LPJ2n0qvG/TC+qVH9/RXei55XEv3eptv9QiWbTgZloQFbTAEVtcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439920;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PUnr6QCBLj1gxkds1ZKvAJ7aZ6JIdbej6XLPSVoW400=;
	b=F0G5ESFkL2alnzsdNPN+Bkl9BvCfAHm3gK4SBlOPnFOV34WMAQBsgzclCRn11SJ3mxhu
	 VmpAAPgGQOcSFyIN1rg52KcxkIp1Pwkk++r8Mc07Pm/Pxwr6GK38OdPYf37P/oGuCUdx/
	 o2/Xtq/4mlS90pAQ1FY/TMsiRPeGNV6b0RrU2Boq+O0lcAwuNwToAau6RCB2xTXe9Am/V
	 MLGHctAOHQ/ys6VIxcUsDRU961p/6s7NS2uFXUbE/nvaN+Nwisu5PpBTL5cAWhPZeExh4
	 JEpUm573cCrHKo/PXo1lPGMFQ86Nd7KE0lQjrtFZAQHD39Zcbv8bD8kk+FDKV7Hc+mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nVAeS5Nn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C531606A327;
	Wed, 11 Nov 2026 23:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C531606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nVAeS5Nn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exjffNlvvimS4thDXPvHwL5eAvSopJgzGcqTNToULxjF8ZCw+wRGy7nX6EQUDgnWys9Uo16hovmvd79Fvn9AWTQGoW0Ano2EXLnVWqcmGiWAUuRQAfKTN7TAYSYxyZLzEN5tqlHKphn2/YQod+Hls1njD6IJZ0ADdm1gYpykXF67KGeBVbQFvnmUAK3IIGM8NuIvSmawDcoJyBmhNZ4uZFZP74gWYSb4i45DXnUpWFbybSzeCe2ybQ9ESgskS3BszoNC2UqZiCEqAuVLeEB/reveQb0MHR8mS/x81aFjZwGWsVaGT+xxhJQDY6AzS5RJn6ZePhcp9dPOLK4Mk7YWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUnr6QCBLj1gxkds1ZKvAJ7aZ6JIdbej6XLPSVoW400=;
 b=qS0/2xTtHbVgkNgS82DDlKcSn5ikCf+qrWDndA1BUy554E2ouxM3iwJiHyeL0kHMxAuOghu0wDgVwRc0twh2Qx/xWHz+wEFTczJbUDAj+sUtPD0NAkjWqJoOTPXDhELqZizPvoGoDNBgR2ogjmuldj6pjt2o4VOQaCUtd7nKg4FutgruhqMobIPIKBnE11WJP4bNSjZOWwCCZhDr4jZfcakw3BmVhwk6eQzXiWYNDvILuDMcLvpnI3ceIjrNJ/1c0bzglzp4bHHK1LbvHrLNDOQ/r/meuRbt6JTRJE049o4OJ7ZlHq3GperIaHPVpw5QEarUc0ySwmFb9BMWicm/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnr6QCBLj1gxkds1ZKvAJ7aZ6JIdbej6XLPSVoW400=;
 b=nVAeS5NnNqwm025euQbDusFkCe3Oitm3NBXiuw/nMCuuBEbCFJ2sSoMuMXXEB9VxuJ+QvGiQzSaN1NG2jm9iypwBxrHpugZZoOIxJIuQ/vhyosEW/9lvx7ZbpI145JEGS1G+f3fLgm8YgHIxO+qmW1g18BKn1ZmOGv2wttEuFgYes6HioaNa1gZLwkTu5e4G8Kdxk/ErrMtT1OMGYTtKRuUjhgaPFyDyFdo2CR1ZCg4uqYzhaEDpOaV91jsndnkPlbpUz9mhWL/0gB7G0OxkmZ1QXqGHJUYDkhDpUS+KBmXqVJLDAmCfZKkqbCP+qIlr16wXvahge1Q2b1GfPfLe5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:31:57 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 23:31:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: enetc: let core segment GSO super-skb when TSO would not fit the TX ring
Date: Thu, 12 Nov 2026 01:31:47 +0200
Message-ID: <20261111233149.479596-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111233149.479596-1-vladimir.oltean@nxp.com>
References: <20261111233149.479596-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: dd939dc5-f941-4492-3ddb-08df404bf9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|19092799006|11063799006|261028144727099003|10067099003|5023799004|56012099006|261021123027099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261102123227099003|261102130727099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jNKWkYZGPTXGgd+amIXWI45xoghOpn0V6UKPM9TjCZhzMx/2r2rTxwJdvc0DfsJ9DdZ3tInW444OxNQoXqSO3XFUla8aMEz9rWl3banQd11Es9kKgYEiD3q0FRXP2q52wOnQGt5+ptFyMj2X+ilerekR1ILlKvBj91kmsoOa7+InlkEwsm58xauctiFus+dc1Kcm81zv7/EuRgkGAmnyE/OsincBMFveWFo4xDKbhYsI5qWk6NdXDLp9wYW89DSTUPzBMuKD+hGBG5EnMV8OOlGdRPyKPhMyf0A3Ni4I8ouHZPyapXrMktJALcWHEWGJR2RhNVVp6+8eGb2CXsqk/87ePYyI0v/mbGpF8EWWpecuSl/h08OdOKPGFefbLoGfSXseHhzupx/J/BS/Fy8kzf3eBViROLfnOmF81VI4qmUuhTtbZwuFwMfjXJid2IFUatnrouC0DwT0vkPOTprbnztkIswJDXgDfu3bC2mbkpqwRa7EEvs+LeahdyP3zBUW+wcwdh2k69/iIy9zHBxdBfYnfHv4P+c92xQWSFo/g1Oy5vXeaYtyPU0EIvWmavsiPEMn8HLom+mcEFKlaR6AhgdYYaqyy2z5yrC0oiZPHv9kPFZUZy/65SUxLZ4JSNYgJunLbsS3kfixZdhDPgElXo04jFALlRtF+J2zrBsp4Z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(19092799006)(11063799006)(261028144727099003)(10067099003)(5023799004)(56012099006)(261021123027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261102123227099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/GOi9EwZim3JgpX/CyZ5nKQ7rUp3rmnI2TRq+HzrwkyTTPKh0QxmyeV1njh?=
 =?us-ascii?Q?+TRxGe+zkp2J5dDCUUYCKsWeqwJsvz494AbLCiBvqfsDDya5LZSGnCh1gme5?=
 =?us-ascii?Q?psgd97P+4b546VMPxDupGLe//IwZe/9JV4Mo1yEzsl96Y2N5O8NV/CTH4Vck?=
 =?us-ascii?Q?lSlkqUzD/FCZb39nYMTVVSMf0vdE2UTfzw/97aPPGIJ7gGw6LnwsredDYr0n?=
 =?us-ascii?Q?iBiRGooZyH8CbzPuQzwNfiIjvVudDPTXLDf1Kitkrr/evXvJ/liskLgbQEr/?=
 =?us-ascii?Q?WAWwtbDCsnAC6F3lfYz5LqEiBhu155GwuQVxOmPnSoSVIdqGddVgjVxGxG6U?=
 =?us-ascii?Q?eKQHsonnJRGdqxfuiey2cTIGRp/zHZN6EkyFn2th+u+TMitvSSjze/sybi22?=
 =?us-ascii?Q?fM3kSG1fD8yKtWIHgA70zEbL8gkVz+oh8i2sgSgzCk+z6D8kwX0gfS8bHp71?=
 =?us-ascii?Q?DyvtFtgnfGk0nGAgYfzmIAThttwsAo4qasigg6EpqCn3hmJT041d2Ltj4XOI?=
 =?us-ascii?Q?EqF0WysPSPe/MBOtNBPndAzaAKLKmSEaIUP5RpjQWisaWuV2UoenV96Gg/yt?=
 =?us-ascii?Q?8xDnxgzR0IYf7EhRXK5kKdnegOZuiIKkbZtKhqMqbr/5jqY9/qIScMReU7ut?=
 =?us-ascii?Q?qOVYqfxVyOCfbx213zZGV33EvyNqAbiSQsgt1PDcCACwkII+TPAegNieomd9?=
 =?us-ascii?Q?TtZXgdhxclcF7xNEL56OAghi8YgVDB7zPp6iwPI1mc7IrGrRggKgIPFHKXS0?=
 =?us-ascii?Q?mTd9MMiGX1KggMG7p619y0+oTD9iWLJHtzqnuv7LJNuX3IVEn6ehbf+LP6k9?=
 =?us-ascii?Q?qmRcrAf8Z5aL1Wo+GV0evRAFOqfas5aK/IAKsLLkiIweddfdUR9d/+FAUQ01?=
 =?us-ascii?Q?Qqy0x8p2dpeK21o5jn8EBvlYfNlCvFql6vp+B9IFCvkVkPUbxrCL8hEa4fPZ?=
 =?us-ascii?Q?LFgfHoqwRpXiXeu3du1q/RcN6YPHCwf2KPl0NP6SuUEGRK0sydCzMvWmKPzO?=
 =?us-ascii?Q?rYip4Aya9DDeu/U0J04dNnHjpRTzfhzz+5yfcPhUOT4DYrY7mGpVnkoWxkIU?=
 =?us-ascii?Q?cVtCR+Cqk+MCPssZyqxQp+NJMb4El3jxLc8iNB1W1jlFHbPbFg6hqJmYz68k?=
 =?us-ascii?Q?cBZQwU6o8yRKAnCPXWsUmhNerazO3P0By9JzuGXgGR6G9fQmOdO9sD0LfBOn?=
 =?us-ascii?Q?xQwlwkScWIpzkj9/rmTFOyV8gFh1A5S8y8zEYWo3LSfEP4uf/uBl1+9ZUVYt?=
 =?us-ascii?Q?bsHfgmXelDN8gtrZm3dDUy6+ovEi9jVUQKROMVVGTzGSHauOkEgdAdBsapJM?=
 =?us-ascii?Q?FTiV9rnbCgDRU63MhRBeVxqSPm5CuqaCicrtMwFFe8/3VWSI6V8VU6W8UCNU?=
 =?us-ascii?Q?aOzFe7o+8COMWEO8bhTvYyjuaQ0Tzv73b+o3D093VYFKLa1HOiPw40H2RCMk?=
 =?us-ascii?Q?lnbbHqnVHZhjt2mCnf70045IwUpJAeIFT37q1Bc0JLwxCG+b6ypXGJGE9ZUW?=
 =?us-ascii?Q?iru5KfwGsDvxFi3mrL8ZOXyLgP7NGi/9yuoxsw0f4Hk8GdoNbunk2NygWdC4?=
 =?us-ascii?Q?hXLST790IEpi7rFHrGWeVCeOCWmn634ZtgVHVIHdm16SiGDikSrdaayXAp5x?=
 =?us-ascii?Q?vqJmpD6WI5hMs7zx0i6O14zlDAbn2t8yw0Fjr1qEyWX/Xt9WVjQ/7ULikoih?=
 =?us-ascii?Q?IgOt5fV0w79KrhTMjYd5Wwa5T1OsV/fbdD8E0+5utMY4kiFDnULsfyaJb4FC?=
 =?us-ascii?Q?zUIEjFeV42x8k1wKyI1R2gaGFCCeEImqjQWbYAQbYRLqwZ6qeIWRnBa1ZxeZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 8kTXhaAgNZ9OWw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd939dc5-f941-4492-3ddb-08df404bf9d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 23:31:56.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aqs0H/dFgi/5owf2By/2IiE7Qo952t1IYabkxAy6y+gVl0WqhhceyKSGIXubvpmf4mw9sruoQ74AU6rfoV497w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

For simplicity reasons, the enetc software GSO implementation waits for
the TX ring to free up sufficiently that all BDs that would be generated
by driver-level segmentation can be enqueued in one go. To pass the time,
it stops the queue and returns NETDEV_TX_BUSY for the core to requeue.

The problem is that without any limits on gso_segs, some GSO super-skbs
can never be sent, and the aforementioned behaviour results in the queue
stalling (there is also no ndo_tx_timeout implementation).

This was reported by Sashiko, but is a valid issue which can be easily
triggered from any source that can craft gso_segs in a way that
tso_count_descs() can exceed 2047 (the ring size minus the obligatory
free entry). Valid reproduction methods include TCP peers whose MSS is
close to tcp_min_snd_mss plus large (64KB) TSO super-skbs; UDP GSO using
setsockopt(UDP_SEGMENT); maybe others.

Add an ndo_features_check() that clears the GSO features for skbs that
take the software TSO path and whose descriptor estimate is larger than
the ring could ever provide. The core then segments these skbs itself
before calling ndo_start_xmit().

Capping the segment count with netif_set_tso_max_segs() would be
simpler, but its drawback is that it's static, so it would have to
assume the worst case for every skb (MAX_SKB_FRAGS, and later the
per-segment VLAN and padding BDs). This would reduce TSO sizes even for
skbs that fit.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 31 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  3 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  1 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  2 ++
 5 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c6571b5cc842..1606ac57016f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -695,6 +695,14 @@ static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
 	return hdr_len;
 }
 
+static bool enetc_skb_uses_lso(const struct enetc_ndev_priv *priv,
+			       const struct sk_buff *skb)
+{
+	/* LSO data unit lengths of up to 256KB are supported */
+	return priv->active_offloads & ENETC_F_LSO &&
+	       (skb->len - enetc_lso_get_hdr_len(skb)) <= ENETC_LSO_MAX_DATA_LEN;
+}
+
 static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
 {
 	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
@@ -1018,10 +1026,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		/* LSO data unit lengths of up to 256KB are supported */
-		if (priv->active_offloads & ENETC_F_LSO &&
-		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
-		    ENETC_LSO_MAX_DATA_LEN) {
+		if (enetc_skb_uses_lso(priv, skb)) {
 			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
 				netif_stop_subqueue(ndev, tx_ring->index);
 				return NETDEV_TX_BUSY;
@@ -1098,6 +1103,24 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(enetc_xmit);
 
+netdev_features_t enetc_features_check(struct sk_buff *skb,
+				       struct net_device *ndev,
+				       netdev_features_t features)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	features = vlan_features_check(skb, features);
+
+	if (!skb_is_gso(skb) || enetc_skb_uses_lso(priv, skb))
+		return features;
+
+	if (tso_count_descs(skb) >= priv->tx_bd_count)
+		features &= ~NETIF_F_GSO_MASK;
+
+	return features;
+}
+EXPORT_SYMBOL_GPL(enetc_features_check);
+
 static irqreturn_t enetc_msix(int irq, void *data)
 {
 	struct enetc_int_vector	*v = data;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d9e91832a9c1..1e3290d1a388 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -529,6 +529,9 @@ int enetc_close(struct net_device *ndev);
 void enetc_start(struct net_device *ndev);
 void enetc_stop(struct net_device *ndev);
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev);
+netdev_features_t enetc_features_check(struct sk_buff *skb,
+				       struct net_device *ndev,
+				       netdev_features_t features);
 struct net_device_stats *enetc_get_stats(struct net_device *ndev);
 void enetc_set_features(struct net_device *ndev, netdev_features_t features);
 int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 71c971618388..bfe0eaf50975 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -586,6 +586,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
 	.ndo_start_xmit		= enetc_xmit,
+	.ndo_features_check	= enetc_features_check,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
 	.ndo_set_rx_mode_async	= enetc4_pf_set_rx_mode,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index d77a07cece28..86ca88196a4b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -483,6 +483,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
 	.ndo_start_xmit		= enetc_xmit,
+	.ndo_features_check	= enetc_features_check,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
 	.ndo_set_rx_mode	= enetc_pf_set_rx_mode,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index f70b6d4290f2..223f974727bc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -440,6 +440,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
 	.ndo_start_xmit		= enetc_xmit,
+	.ndo_features_check	= enetc_features_check,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_vf_set_mac_addr,
 	.ndo_set_features	= enetc_vf_set_features,
@@ -453,6 +454,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
 	.ndo_start_xmit		= enetc_xmit,
+	.ndo_features_check	= enetc_features_check,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_vf_set_mac_addr,
 	.ndo_set_features	= enetc_vf_set_features,
-- 
2.53.0

