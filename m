Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792582498;
	b=v44snNJjE2INB467ZCT1PcbGw67vTM9fCP3X33FBP1OAEt44Bq74QkbJegZcI3fSBoQu
	 E+rEx6smu9Z+z04DFPdRcb59TfDTnXjRmIg/muXXbFApJD/gdBCmi9QunIUkXxya7//NK
	 VRytLDfxj+W9O2NUrL4zp8C1xoFvpcCNSc7xklaFPHrgX5G0iJ5W5zIcuHenYTHSDeBmd
	 hD5pIULpZKIYcOoGK8rqUsBW2oWdn1sCI7IiG4KbD1TdQvZD0bIRgSF7xdJ9oBsRdaDCD
	 fD1ay7t0WcScEK0nvGXnTxopJe4IbmpXNV/k8wKDxlAyXk4r0pp50P9iPWOG2V7oIHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582498;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1rVS5lv2lXGwUOC8HcUumutJyKA7KNV6pw8LNsf7nII=;
	b=Nm0elDHNqFhvS0vFx3yBbI4bBG4wCXY+HMChed5Nt6aJwtY+3L7l/GdSJZ0cwtcY9vvT
	 0QMIRZ7qtcg1y8Q7rEYauopfsFoaL9/cnJZI2oFw/SCWlTeIapk3YenVNppYkXllcG312
	 6qahK5iSdIaXUxKpA+bX8ackopSsDYTptIXyvwbxcrYNxpvHGmWH1uFkt+V4ljTy74Kvj
	 enxmQJjqhvnUPA8/6LKKhZ4UwsyUWC0jAYGCHENshlVkbVzP/Mq0/5UyjkGt8PN+QUq0/
	 pzBIUezdbJ5ZTZ0Cl3xlfoTfeWkpKH2PsUwoqce67wtxPZtBNuMdIRaXA5qOPhM5snA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=L749O85Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.17
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC4606A319;
	Wed, 21 Oct 2026 11:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BC4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=L749O85Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/cTBLVBt2g6y1PPHFXODD8O3bARgPRJoXj7NCq8Esbrb5VkVFpyNDduBGmthsGlsBRyDshPTOGftGOGENJjx4MyN6zCqTxXX6znQMom/NYtKwwSltGSOYplXrfrJCsYqnOC8GHFA8JLDockAjZPT6Rx4iobuVFrCagXX6GmZIFBbwKV6NbW4dKJSrKo/qLc4PEdhPjl3b96YXhodx7bNideYA3rERunU3DoktdLlkafdNg71zJcovyo2dx09zSPN6zpOxmP/rWYmJpIsQQFWwGwA+CRnQAEEL8EIUSyJ9Rm++kHmo+rGT9XcqurcXP3wo/8Pv0OV6fa9hwuvrGZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rVS5lv2lXGwUOC8HcUumutJyKA7KNV6pw8LNsf7nII=;
 b=Lmo5knlTZkWqMIZ9uXazjsBG7X1d02jgL7EoswvPm84E5T6eIkfX54SKkgSZoKazwXRix578B67dhGwReWWfkck1PI3hiJKES7iqP55yRHiehEd52HGe/1AquAynvObSgWB1tTRTS/TZ2VFhpqPw88dKEU/7skFAcBxEuhgkGDmitwjCIOqY3npiGWeaXex/snLIp35MPECtFX7hEoRT39Xw8FeAZRjgYymHWXgNn5fVLHQHbPWoTWuTGSh0O0wWsS55I/VoS98TIm6L5fCG0MTx37VuBhCEtSTIusaLjjRTixS+pjuEw0iBqjOdwxj7CoT97EGCA5Q7G4Kflw6qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rVS5lv2lXGwUOC8HcUumutJyKA7KNV6pw8LNsf7nII=;
 b=L749O85Y/7jqnRkUmf5v8Ij4NnjDcGZSuE7L0tH4agdUP7Q8zcp1ZUcVQExZPXpPU4UdVCOrPQeoOXgtU4aXz88EHz75QkO4TafWoPQfDLjzAtffGCWbQ3l7Y9RlJYXvkN8PoCVwRwbiPfwLzXIrvoxOlxd0plKFHKP+fjwCROnMUkCi/lXOUy1/3+2VHONllaBHTjUu/xkOjh59eOSBXpN5yC7T7hH+Z9IXbiy5ZaZCQYH5GHUlNik8a3yroVgkgsUd3vLC3ndBCYsfu2BtBjs5lRrVgUSK5r11vNh/bZNgoxWNYim3CSk0LoxtEQFyTrxiWN+hcf8cw3MFtfoR9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 21 Oct
 2026 11:34:54 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:34:54 +0000
Date: Wed, 21 Oct 2026 14:34:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Zefir Kurtisi <zefir.kurtisi@westermo.com>, Zefir Kurtisi <zefir.kurtisi@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net 0/8] Fix short frame transmission in enetc
Message-ID: <hnpdglhqlyaxp62tdqtr6bht7ltbawwinrfisrhfd5ncgfgter@ngf35z7rubch>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VE1PR04MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: b96f1267-ca7f-4342-9ac8-08df2f67537a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|7416014|6133799003|10067099003|18002099003|22082099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	1IHtCUGHsGyMH08kjx8DhCC27zVz3JiIiJxngb2im9Pt7jZB4d0z4wKipYVd8Y0JAvem3L64Vtj1sdzJYFHeW8dpw0inqd9FqkIEYQlHg9HfQZcGocM8iHwGfmWcQWg+s2C/jSykDvzfBPdEeG6u4SuuixEt0Xcdt1+f0idYL0Ii2RzQV7NTz/tVuhntGXaCGYh9wB6RbrIFM9SyVux2nZcpNbrG4vfVJZHzueB49QIURqSmVQkCYs/FIAEns2GJI7Q2Lh0U0gHjhi8cne0BE5zDu68Wjf6XvA83LJA1mbCQawM5Nh02R26PrAJtNTC071kojOJ21rrKLtW0GEOVlCHmI3k4kN9TmVbjahRcuK7D1wIMzJSUUwJZyMzzbI2IMdu5TSBNJ6vMZ7eVzntTprt7zqPV/HDAWIQRKyC2IHS+Jx/nGIVGBl8Hl1vIYmq4WNKE7D5IW+bB7WfIDPYo5gogmi3z6pBF5IaLcBMkpOeHpBzzbu0zomflIrO5ti6/27RXBfvm9r5rLJrQijGzbafLlPWYyRFLGnLQs+0MAKjXTz7feHq+0zliqPHRo5BQNlxHnj971Tc0Qe0q5zldTaCrsap+ZieCP1jA3x5PBjxEIfE9P8dMkeBQrwO/Y57y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(7416014)(6133799003)(10067099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fXKaYoSUvc1kbzhhxS7EvWZrO30l2WcCp/lggfV3KOBvI5fU3AYFdJKtdcjS?=
 =?us-ascii?Q?KF1QCL9IT9j5KuE5lmqutQfMjzLePIKY8+sNboKvDNxVgwDoIchD1DfIYURF?=
 =?us-ascii?Q?4cMELBNnbA1vDsRpblIZ22yF1aK6TjK4dMwewqa2kEQcvyBNmDM/i4k8w5Kv?=
 =?us-ascii?Q?jcpqMvDbr/F9RDF3Bw2cY/roH9tp7KEKVSP+4AZuvUpG8DCpKGCITXX6dzOo?=
 =?us-ascii?Q?RkPggHTyMBnGJD4JxOCiLeo9PGLDK+bJ9lHV//oEqz1fr+YEA7W1ZFZfwQaM?=
 =?us-ascii?Q?BfMt2h1IPjzYq7YHw/tc1+MXDqMWoH9wGtdH/m18dt2IunaRgxVB/Fi8tZcf?=
 =?us-ascii?Q?2WxxHTAEXJGFgBYoO3cYnU16YezGUNte2HFQoO/bl/2Xd+01kr+UpF3xzS04?=
 =?us-ascii?Q?zyjey7I3D5a7SrrdjRjhMpASkv5vlylojkDxxhS48a98w6r/boxi707HPzEC?=
 =?us-ascii?Q?yI9MQJhdzh3yWkSb7TDGrYbMkG2+hmlVzwr9qpg2BjlfdlUtAI+pARpGLFm7?=
 =?us-ascii?Q?fplXaMg7UySc75y3WTQFAWYnh2WDgKrGqrnuV+//Jt7Ut2cgRd/SW7ZP02DA?=
 =?us-ascii?Q?0wPSv0CcxTwXhWejdaQfkYP4J4pLdLalBruP9R9Hm0ptf2O3xTv4SuRYReix?=
 =?us-ascii?Q?AazAAQLzWAb3EPaKfnAfbY3uD+QBRE9DVsCZWCFhdEXSQo7Y3qSAgeLpXB3Q?=
 =?us-ascii?Q?FWoO/1UWo+hkNgU+SFV2xeW86HyN6Nsq4saP7jtMqP3LOBIcpPUpx/a1AiBQ?=
 =?us-ascii?Q?b6l5+YzCRYY3kjRIJaGe7ZdwoazoPn8iLuvVYGNGIH51QF3VNo/z3zGGt1I6?=
 =?us-ascii?Q?iB2k/JZmfrDM/6kLW2yLVQIp5W5cYPoCf+L2QqsOFIqqgLfBYMkE0sQ9g1mT?=
 =?us-ascii?Q?Lhg7vM6viZvccrsJjxR22VToZmOyUZcBRxrGtvpJ/Uytw6kWT2YdoQZhapt/?=
 =?us-ascii?Q?KdFVTAIHaRJEyeEloKGmDKkhvHusE596z7UZIFUf3WGQmaHioqV7Z93BhDKF?=
 =?us-ascii?Q?OTMSUTZs2aabLSa7x7fXjtmsis8RUeLAiBUIJrquwLBDJgQuVPC6LueAJFUv?=
 =?us-ascii?Q?wvLHR1zu0kisHSwnnDAnDySJFfwBhHxxiUiDtA0HWDuqwGgXB+oPpzaAC4m8?=
 =?us-ascii?Q?BvwotcLlkJeopSPeJDTcNtV+pEf/jNdiOPSNjLAGauyQRy01P5OEMNpFPN+1?=
 =?us-ascii?Q?y7YhB8beBJn7Yh02rP+Ocqpsh1HI/ipm9mnbR5rtSVHiRW5cFg1p3MhAHK08?=
 =?us-ascii?Q?IZ0fQLNmFw6EIMVYppXU+CfjfpwJqyqp6WcmHauk6lh2EdSEf0zejHm6SsUj?=
 =?us-ascii?Q?+4MGMwE1TaEPSlNBCnZxAqcTMAzn5H65NmbJ3EVqKgiM+ITMboSjONRsHwcz?=
 =?us-ascii?Q?dtfspjSlxDa6T3RKTShB4jBqrgVsjgTKEj0u95CccwfUrS/E2dkqMHn70d2N?=
 =?us-ascii?Q?M5S8NS9rV/Qthb8Pu1unXK2BT/BtuBE60rOUZW3jo2aDX/dFCohHQseBCMXd?=
 =?us-ascii?Q?Zt4Aour6dO8sOuKrHlutRf+lHG73MvcFdMnTVl1EjbwvVT/wdQ20KJynNUbZ?=
 =?us-ascii?Q?IzTanlaMzHeGyC98C4SehEpp6Lk059et2Asc98PPs3cRwy2tgfNwEBchqvQd?=
 =?us-ascii?Q?fl+YD4SSOh5MJ8y2YLO/47jQB2rShkFiC5DqsPYYajFSsLZLiUv918dlJ4c7?=
 =?us-ascii?Q?NIf5nUpvurX4Ce6+HtB1/ML+Ana1FJcsf/HAr4xhOleeGEiTHbmLlpa5+eUI?=
 =?us-ascii?Q?YerYBD57Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f1267-ca7f-4342-9ac8-08df2f67537a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:34:54.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 714lpFNrNfF0pdQXTShclWRAimGcxSw+dUylDdcthQVJl1zEESX20JO9p3abOwzaLsYTO3Bkp0K1pCXqyEZqUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310

On Thu, Oct 15, 2026 at 01:55:28PM +0300, vladimir.oltean@nxp.com wrote:
> This is a belated follow-up to Zefir Kurtisi's report:
> https://lore.kernel.org/netdev/20260220132930.2521155-1-zefir.kurtisi@gmail.com/
> 
> which is that the ENETC misbehaves when transmitting packets smaller
> than 16 octets sans FCS: it sends them but does not update the completed
> index in the transmit BD ring. I did find a sentence in the reference
> manual explicitly stating these short frames are not supported.
> 
> The original series was focused on handling the invalid frame
> geometries (now patches 4, 5 and 6). However, review pointed out further
> issues in annex code. The other patches handle those.
> 
> v1 at:
> https://lore.kernel.org/netdev/20260401172246.1075883-1-vladimir.oltean@nxp.com/
> 
> v2 at:
> https://lore.kernel.org/netdev/20260406204122.167237-1-vladimir.oltean@nxp.com/
> 
> v3 at:
> https://lore.kernel.org/netdev/20260915222735.1016937-5-vladimir.oltean@nxp.com/
> 
> Change log in individual patches. At a high level:
> - applied feedback from Wei Fang, David Laight and Sashiko
> - dropped "[PATCH v3 net 7/7] net: enetc: drain and cancel one-step TX
>   tstamp queue when going down" because addressing Sashiko's feedback
>   would grow this series to a point where it would become impossible to
>   make any progress; plus it becomes more and more unrelated to the main
>   objective. Will address that part separately.
> - dropped "[PATCH v3 net 6/7] net: enetc: linearize PTP event packets
>   with one-step TX timestamping"; also unrelated to short frames, will
>   resubmit separately.
> - split v3's "pad short frames in software" into patch 4 (do not rely on
>   mEMAC hardware frame padding) and patch 5 (ensure head buffer has at
>   least 16 octets).
> - reworked v3's "pad short XDP frames coming from devmap": instead of
>   padding the xdp_frame in place through a new generic xdp_frame_pad()
>   helper (which only covered ndo_xdp_xmit()), patch 6 now pads in the
>   driver using the shared tx_pad buffer, covering the XDP_TX path too.
>   Consequently, there is no longer a change to include/net/xdp.h, so the
>   BPF/XDP folks are no longer CCed.
> - new patches:
>   - 2/8: serialize access to the same TX ring from NAPI XDP_TX and
>     ndo_xdp_xmit()
>   - 7/8: fix leak of pending XDP_TX frames when going down
> 
> Vladimir Oltean (8):
>   net: enetc: consistently track dropped frames in enetc_xdp_xmit()
>   net: enetc: serialize access to the same TX ring from NAPI XDP_TX and
>     ndo_xdp_xmit()
>   net: enetc: fix bogus TX ring consumer index after reinitialization
>   net: enetc: do not rely on mEMAC hardware frame padding
>   net: enetc: ensure head buffer has at least 16 octets
>   net: enetc: pad short XDP frames in software
>   net: enetc: fix leak of pending XDP_TX frames when going down
>   net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
> 
>  drivers/net/ethernet/freescale/enetc/enetc.c | 160 ++++++++++++++++---
>  drivers/net/ethernet/freescale/enetc/enetc.h |  12 ++
>  2 files changed, 148 insertions(+), 24 deletions(-)
> 
> -- 
> 2.43.0
>

In short:

pw-bot: cr

I've received a rainfall of AI review from the Sashiko bot, on some
emails netdev was copied, on some it was not. Some of the feedback is
valid (a lot is duplicated, and that makes up a lot of the noise), and
that valid feedback falls into one of 2 categories:
- in scope for this patch set
- out of scope for this patch set

I can't humanly respond to all that verbiage, sorry.

Because I want to get this issue resolved ASAP, I will trim v5 to just 4
patches, which touch only what is strictly in scope, and will defer the
rest of the feedback to other patch sets to follow.
