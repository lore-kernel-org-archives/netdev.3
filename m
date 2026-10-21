Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594473;
	b=SbGl+9pOJC7gB9qELez0YHMNdfw6JdJjpz4xeGMoIjFcJRrnVvOPf9TCOfZ9M5Ww/Ale
	 0QU6AyOyZVqYfumeWQEOcr2Ss/IMfbc2SXQygd0kGELuDIIKL0WpPCUXqgo9rBeImNEgt
	 aPOwB75tIGWwjsQlwPsYASsHdlmUKIOsl04JUIAV7e+4gMPlm2f75IjFt7r5kkFOuoSfb
	 a1YNm9vt3kfYWAUHClxbYAPlIXw4tTuz5YN+8Ha5TxoTaQ/JuDAk139q5vekTwpos9Gig
	 gK8pqdVWSz/bRBze0PRWUFIinuUjW0tUfdgzghtL2vbJNWU4dyppfOPxv/CG+kBcQjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594473;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
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
	bh=1z6vYAjElxxPBMe8Q4EBZzXt8tlz5Ak1WLr8qKv+oc4=;
	b=OLXczUH0sJc85vng+Hldr30t8NA2GJvoBTwoIpXMZPPzO6NFHlPPM9/FPQAvvZ9u9thq
	 sI/1GpzIHFB2XAaZ0wHkZXD6uY21N+mKmNAWkDMslj1i+EsAHITDrHQQre6eT3XTeTxNw
	 LykPU9arPdM02oEYIcMsRKON/bFPehP9c190XZsxrbZ+mFfOxA/mHjXHD2gaCNl6qmkBI
	 dhaWZH57YkLXaxyaXDHlzU7EiIWEbUDjCDup6SDQjvvMMo29m/Cbu0PWddTE7shwp+mn9
	 aBshTk2Y0qfgeLPSyhpnA5pgYwYakMp5emXYA2I8xtvfAqJ1wGiHTHIsRirlP2yZv8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=i6FFk6ir;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.10
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80860A2606;
	Wed, 21 Oct 2026 14:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F80860A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=i6FFk6ir
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM7dPJTjOoE1mKpc/4yOQouSV9+Wa+viXE6yc/5IUeSKifVlidhDxohK1CAESpfFfH5KdL2uMwgsrxXyKHBsxVhXIq/I1Um2UhgTE6rrDodPYsJsRWsGSDtf7ZqERUSSkvY9gbxZ9x4kIFdKftbsDIcv/QokPrh2QTTLUeS6o3SAPBFsHrhBTgrxzgOYH9JsPrZHGNGTixGulDmq1eFX8wGo0VVxMtUcY+QbM+CaNql5KrvZzXg2SJdIFbst7BykWLGWyG396keoCs7fXuhmF3yhigGSAzPTrHBlfzn9JeMDx+KE5qQbVy+GbpyldQMxM+tbNmnuDQjcadhp3gUtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z6vYAjElxxPBMe8Q4EBZzXt8tlz5Ak1WLr8qKv+oc4=;
 b=J6SrTdknqsdJrJh4QY1SSL6d5jC4IVhHfAsefIDkEzGUH+3wD5tPJ7/rjMi4v3oL1fGfAx6LXlEtLBVhkKQAsSv6oxSew7kfCHaHTBEFmNMRWzmbux44yZfkiwWKow/K+YctWPRtgh8isr7t6t9Nje1kq4bq93d3g2UmgW6g644nNltXHE8CJrdIO7RvrpvgC/k/iaIvcaezRWxdNguShkmiV8rn2kMXIhq/34jVoDlZOha8zVKhs5kyyTuZJarNsPwq40uadfs12/ikkyBqEbReQlpGUz65MLaPVQAXrtd3JUim8yc14J+pgXtZdFSQB4ZE9rKw0LmcruEFyG8YYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z6vYAjElxxPBMe8Q4EBZzXt8tlz5Ak1WLr8qKv+oc4=;
 b=i6FFk6irUvwtdU6TME14jlG3Io/ECq+SfCF4pBwnej7vaD+oICewRZhZPFNdifKmzD8DZHyUJLfjaiDyW3ZMu2ep/f6ZZKM4UQWGCNEG61/uSULOhyY0ZrJcyI4jksCx4CtKDLSqM2fHBcfsczIYsb1urJVMyVCq/P3kGebrq98MH9UOq2BhpKWkeSZuKE5G/XIKO7CcXSJZ/8VZHE6v1/r64WH4jChyIST2nrxFH+FbLxlxMAKOEj5NJoiXQsX5a37iUEW+oSQ+9yUJprGhAqzjUZSdlBsF/+wSAocnIzUzZJePUKLhuoEk2s4HQj5GDPOlZt+PyAn6PHSdSYoMZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:54:29 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:54:29 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net 2/4] net: enetc: do not rely on mEMAC hardware frame padding
Date: Wed, 21 Oct 2026 17:53:12 +0300
Message-ID: <20261021145314.1435049-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::31) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: a0020264-b830-46e3-b4f9-08df2f83355c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	a7RjfP0vHUo3XjHV7UlA9uEP02++lrygNVWREuTkKl9kfWfRagZhGqzFsoPgAwWatGq8SDGQLlHLZPDKm/xSgGO8hQmmreveUlnJUFlPCWFT2lesLkKDNxLzU/E1zAAysMj0dd8QxOjTR/vaM4ki9xcpeb5+pITWNgnMD07MipYZ8VdUXx1x/r3CRj6Mr9cSvELFw8HJ8/4IRJb1kUx1MgzDCchDZyS3qi5ZvNP0sYquAM2CBTzI5TLSUD8CcTLVo8YK7TPgd8LaOERRV4tLqYsKTD7CLKLskrIGWztsS6Lr7AliUuV3TJ1TTkz/VInNoenQ658ADysB1shNaD7xAOJk5beN/tvojnhFrhX0uDVF+umqaKCmhtF6Tpyc5DQBJ/m72ktlqDbAD5x9sh1KWpp6ODaNbn6CG4UOmih6C7YBCmIRx6HLV/9EJaLY7hvF8GRFbemqlyIBcBX8ACxJz4T3TksIeLU6MDwsV5yKUzhpQvOJpWYIRC3vJ3kb5a9LPlJo2H/STn1pM5DFY+qGh06khHb65JXhEllfwYujdcVTqssMbNpqGTRTR4kyCmhFQjQE5NsoDazvVkV5LmvODrv7eqjM49mQqtBYPiLqqdfzGifFjMEkLAHsczqIyjJA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ny7EPZfO/kKRbkgqzWeXkgTNz2s5hNnj18auCqeyNTmE/E5rieMQorc/gGVp?=
 =?us-ascii?Q?D+MaMDU8Xstfi7QTasqKrgYD70BGF7dK/R5/apnzEQqUZqbumMQIzcXFdX6/?=
 =?us-ascii?Q?G5R+/E9MlL0diUKyqexUBdUcnx+HZSzz9S2uhv1lwKfCN2XqS9mlil9DQjil?=
 =?us-ascii?Q?CqaRAQgdiVJpdUJC7aNrzl1M5/A/vpesaUh4992zDVI/gE2UMzpI1b0Fz01B?=
 =?us-ascii?Q?zyjDBdb7V92s2InnKxOy+Lw/SLMyk56bokrcqoiY97k7Pf2HbjiqiyDie/tM?=
 =?us-ascii?Q?PUkpD7sOMWAwQNYl6jPaBDMR2WpbvoO4A3BIM4yNHHREsOMvBdngsHXCZPmW?=
 =?us-ascii?Q?gQQ2+RtIIYJO+7kIfm2QWWfagohRcHqOULPUneqDhJ0UHmwUnYf8WU0+DMCo?=
 =?us-ascii?Q?alImzILuYlWN6xpsbG3ZY3eHFihA3xw3nrVRnFceAqX95cJt15giJ5dEHHeU?=
 =?us-ascii?Q?a+7826BakuwNMOXhbnVkedbBQkYv1ysA2GL/pwJWHKiSaVoTuu+Sh4mquSP4?=
 =?us-ascii?Q?4TRoTXwLAh9AyPrkI1Cb2EUfjZB9N/HaaHOSA49wTbo+5f70TW586s+/ZcXp?=
 =?us-ascii?Q?MjfEUO1u+PCSh1ume2jY0pVjPJHpPoZrihpjfuuQPlPJacQ2ky+5Z59jRBLj?=
 =?us-ascii?Q?ONpitHoTYMZ/aZ/Hdjmn/FyknhkvO9M4iETIATgx9xxXdnXbGk1edxBO2iQe?=
 =?us-ascii?Q?PxVjCgFRLVKGOmwtKpWwNcM6weAHnieBSIxEunX6AV5Nav6/KdwUWmo3g5NN?=
 =?us-ascii?Q?k5iT53DW/5uNoxJbcRTZp85E+FvtcmiyGsLtx67m/cBx8xptF0VeaasaKSNr?=
 =?us-ascii?Q?VecndMm4f59dsuPK3g+td3y0DAkcYqBpSDwkNttkyaWzjDVCYOqvOXzavAUz?=
 =?us-ascii?Q?J+Oz9opQtygsEijOFu2PUDSx22zlTj+HDfsamwTvGtxwp2AL8ShyjmfHrCkM?=
 =?us-ascii?Q?bBDShSzcs6O7w7CNUFGxpctK98KDQsJgZR6Gnr9S3oFvkkXeL/cu9TaNjgKj?=
 =?us-ascii?Q?OzMgGd8dSUgdfolK8klLWt33yA/Hkbt+GByu7BFtNyxEWZMlBtCHGFE04EML?=
 =?us-ascii?Q?TwOSrHk2A22gO7VOBnwKg6gufMyXH9rnVvBiNsgPgtlRn9j8rIyLbO++cdMC?=
 =?us-ascii?Q?PUmTbSWCMNhoQqwrdbnNTod4hMQowlusayA9z7xOn5nrHpcGnnSYijnr3Mbv?=
 =?us-ascii?Q?1hoFifxlQxTopjh/vQrzSBZNbSAG0dIhFYmBYL0uMIo28yu3kMVxUlfYQKsw?=
 =?us-ascii?Q?8CmjlX+2Jg5n98+O7pNWRdJvMOer/v2/1ImJP06LGTnpIMvEnnVInYBg2dF/?=
 =?us-ascii?Q?ZdoVosQRQ1+OObPvzgyHaZhF8Z6n477g25yGci32aGeaoit0RPYdZ0WcyclV?=
 =?us-ascii?Q?60SNieW9LEJLql9o0sqBiLh8gG4OoiiTdTUa6kE/gZ+NqXnK2W/h+q4P9Grp?=
 =?us-ascii?Q?E/G3D9j6Km169gQdX8bdnvX4QzJ0ySaDp3QmvFiDJMmqeUG676ajti1UPM79?=
 =?us-ascii?Q?bZg8RrS/oosk3y2a+lsn7lTUhxDcxc1Zq2WS0iJAQxYnEesgz+/x9l6ZUmXz?=
 =?us-ascii?Q?tA4oWphz9hW3G8q5wERDmPpKB0cTPZF4w9HQyR5gkitOGeQML9euCFFwARDI?=
 =?us-ascii?Q?O7uhX+hS2p4w5zHk/5enKI3E67x0PH+cjSPLXqV+eWPlGhgO2MVitbDLppAT?=
 =?us-ascii?Q?6vD8W5TXGFg/XiFSf6zaBMQQdufIU3ys27PSI6WKKrGhWNwzAFowsUtKLUj8?=
 =?us-ascii?Q?8Pl2JNvVww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0020264-b830-46e3-b4f9-08df2f83355c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:54:29.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0kytCw+30BW10Yqh03aucS8gSvB2lE3Qb/1m9BjVqxfugjLGD42hyUumxCBlLKVEdSaq0Fd8ZMT6SOHSeHpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912

The driver sets the ENETC_PM0_CMD_TXP bit to pad short buffers.
This works, however sending short frames from user space and looking at
the padding bytes inserted by the MAC at the link partner, we notice on
LS1028A that the first octet of padding is sometimes not 0.

This is fine per 802.3, which does not require that the padding is zero.

However, there is an unproven suspicion that the padding bytes may
come from internal memories, and unfortunately I couldn't get sufficient
priority for this octet's origin to be investigated by hardware
engineers.

To be defensive and not leak any sensitive information from the SoC,
let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
have to do anything.

There are 2 distinct cases to handle, for GSO and non-GSO. For non-GSO
things are trivial; we need to call eth_skb_pad(). For GSO, things are
not simple, because user space may set gso_size to a very small value,
which could make the GSO super-skb smaller than ETH_ZLEN; padding that
would produce more segments than originally intended. What needs to be
done is to pad individual segments instead.

When a GSO segment's hdr_len + data_len is below ETH_ZLEN, append a
zero-padding data BD and advertise the padded length in the header BD's
frm_len.

The padding bytes are always the same zeros, so a single read-only
DMA-coherent buffer (tx_pad, ETH_ZLEN bytes, zero-initialized by
dma_alloc_coherent() and never written) is shared by all padding BDs of
the ring. Like the header BD, a padding BD carries no per-BD DMA address,
so cleanup does not unmap it. The pad BD becomes the segment's last BD,
so the F flag and the skb pointer move onto it. Segment checksums are
unaffected as they are computed over data_len only, before padding.

The worst-case descriptor reservation grows by one BD per segment.
The pad BD also counts towards the per-frame chained BD limit (15 on
LS1028A, including the head and extension BD), so a padded segment may
use one data BD less.

Only LS1028A (NETCv1) needs this. On i.MX95 (NETC v4.1), it was observed
that padding bytes are always zero, and the reference manual also
documents in "106.3.5.1.2.1.3.7 FCS generation and append on transmit"
that HTA Transmit pads short frames (including LSO segment frames) with
zeros before appending the FCS. On LS1028A it does not say this (padding
seems an exclusively mEMAC task).

Nonetheless, for simplicity's sake, we keep the unconditional eth_skb_pad()
call in the common transmit path, but we leave the hardware LSO transmit
path unpadded in software. The latter is only present on NETC v4.1 and
later (thus already contains zeroes).

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5:
- account for the pad BD in the new enetc_tso_count_descs() helper
  from "net: enetc: reserve VLAN extension BDs for software TSO",
  instead of open-coding it in enetc_start_xmit()
- count the pad BD towards the per-frame chained BD limit, so a padded
  segment may use one data BD less
- explain in the commit message why hardware LSO is not affected
v3->v4:
- split from "net: enetc: pad short frames in software", bring its own
  justification:
  https://lore.kernel.org/netdev/20260921112946.edo5uw6cl7jx6oez@skbuf/
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 61 ++++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h |  6 ++
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index f6b352a3a49c..a9ea124f7835 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -524,7 +524,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 				struct enetc_tx_swbd *tx_swbd,
 				union enetc_tx_bd *txbd, int *i, int hdr_len,
-				int data_len)
+				int data_len, int frm_len)
 {
 	union enetc_tx_bd txbd_tmp;
 	u8 flags = 0, e_flags = 0;
@@ -541,7 +541,7 @@ static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 	txbd_tmp.buf_len = cpu_to_le16(hdr_len);
 
 	/* first BD needs frm_len and offload flags set */
-	txbd_tmp.frm_len = cpu_to_le16(hdr_len + data_len);
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
 	txbd_tmp.flags = flags;
 
 	/* For the TSO header we do not set the dma address since we do not
@@ -613,6 +613,22 @@ static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 	return 0;
 }
 
+static void enetc_append_tx_pad(struct enetc_bdr *tx_ring, int i, int pad_len)
+{
+	struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+	union enetc_tx_bd *txbd = ENETC_TXBD(*tx_ring, i);
+
+	enetc_clear_tx_bd(txbd);
+	txbd->addr = cpu_to_le64(tx_ring->tx_pad_dma);
+	txbd->buf_len = cpu_to_le16(pad_len);
+	txbd->flags = ENETC_TXBD_FLAGS_F;
+
+	tx_swbd->len = pad_len;
+	tx_swbd->is_eof = true;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+}
+
 static __wsum enetc_tso_hdr_csum(struct tso_t *tso, struct sk_buff *skb,
 				 char *hdr, int hdr_len, int *l4_hdr_len)
 {
@@ -687,7 +703,8 @@ static int enetc_lso_count_descs(const struct sk_buff *skb)
 
 static int enetc_tso_count_descs(const struct sk_buff *skb)
 {
-	int count = tso_count_descs(skb);
+	/* +gso_segs to cover one pad BD per segment */
+	int count = tso_count_descs(skb) + skb_shinfo(skb)->gso_segs;
 
 	/* Each segment also needs an extension BD for VLAN insertion */
 	if (skb_vlan_tag_present(skb))
@@ -926,6 +943,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 	i = tx_ring->next_to_use;
 
 	while (total_len > 0) {
+		int max_data_bds;
+		int frm_len;
+		int pad_len;
 		char *hdr;
 
 		/* Get the BD */
@@ -937,6 +957,12 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 		data_len = min_t(int, skb_shinfo(skb)->gso_size, total_len);
 		total_len -= data_len;
 
+		/* Pad segments below ETH_ZLEN so the mEMAC does not pad them. */
+		frm_len = max_t(int, hdr_len + data_len, ETH_ZLEN);
+		pad_len = frm_len - (hdr_len + data_len);
+		/* The pad BD counts towards the max chained BD limit */
+		max_data_bds = priv->max_frags - !!pad_len;
+
 		/* prepare packet headers: MAC + IP + TCP */
 		hdr = tx_ring->tso_headers + i * TSO_HEADER_SIZE;
 		tso_build_hdr(skb, hdr, &tso, data_len, total_len == 0);
@@ -944,7 +970,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 		/* compute the csum over the L4 header */
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
 		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd,
-					      &i, hdr_len, data_len);
+					      &i, hdr_len, data_len, frm_len);
 		bd_data_num = 0;
 
 		while (data_len > 0) {
@@ -966,8 +992,10 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			csum = csum_block_add(csum, csum2, pos);
 			pos += size;
 
+			/* When padding, the pad BD is the last one, not this */
 			err = enetc_map_tx_tso_data(tx_ring, skb, tx_swbd, txbd,
 						    tso.data, size,
+						    !pad_len &&
 						    size == data_len);
 			if (err) {
 				if (i == 0)
@@ -982,12 +1010,19 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= priv->max_frags && data_len))
+			if (unlikely(bd_data_num >= max_data_bds && data_len))
 				goto err_chained_bd;
 		}
 
 		enetc_tso_complete_csum(tx_ring, &tso, skb, hdr, pos, csum);
 
+		if (pad_len) {
+			enetc_bdr_idx_inc(tx_ring, &i);
+			enetc_append_tx_pad(tx_ring, i, pad_len);
+			tx_swbd = &tx_ring->tx_swbd[i];
+			count++;
+		}
+
 		if (total_len == 0)
 			tx_swbd->skb = skb;
 
@@ -1050,6 +1085,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			enetc_unlock_mdio();
 		}
 	} else {
+		if (eth_skb_pad(skb))
+			return NETDEV_TX_OK;
+
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
@@ -2285,8 +2323,18 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
 		goto err_alloc_tso;
 	}
 
+	res->tx_pad = dma_alloc_coherent(dev, ETH_ZLEN, &res->tx_pad_dma,
+					 GFP_KERNEL);
+	if (!res->tx_pad) {
+		err = -ENOMEM;
+		goto err_alloc_pad;
+	}
+
 	return 0;
 
+err_alloc_pad:
+	dma_free_coherent(dev, bd_count * TSO_HEADER_SIZE, res->tso_headers,
+			  res->tso_headers_dma);
 err_alloc_tso:
 	enetc_dma_free_bdr(res);
 err_alloc_bdr:
@@ -2298,6 +2346,7 @@ static int enetc_alloc_tx_resource(struct enetc_bdr_resource *res,
 
 static void enetc_free_tx_resource(const struct enetc_bdr_resource *res)
 {
+	dma_free_coherent(res->dev, ETH_ZLEN, res->tx_pad, res->tx_pad_dma);
 	dma_free_coherent(res->dev, res->bd_count * TSO_HEADER_SIZE,
 			  res->tso_headers, res->tso_headers_dma);
 	enetc_dma_free_bdr(res);
@@ -2425,6 +2474,8 @@ static void enetc_assign_tx_resource(struct enetc_bdr *tx_ring,
 	tx_ring->tx_swbd = res ? res->tx_swbd : NULL;
 	tx_ring->tso_headers = res ? res->tso_headers : NULL;
 	tx_ring->tso_headers_dma = res ? res->tso_headers_dma : 0;
+	tx_ring->tx_pad = res ? res->tx_pad : NULL;
+	tx_ring->tx_pad_dma = res ? res->tx_pad_dma : 0;
 }
 
 static void enetc_assign_rx_resource(struct enetc_bdr *rx_ring,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d9e91832a9c1..db3b3bad0f59 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -145,6 +145,8 @@ struct enetc_bdr_resource {
 	};
 	char *tso_headers;
 	dma_addr_t tso_headers_dma;
+	void *tx_pad;
+	dma_addr_t tx_pad_dma;
 };
 
 struct enetc_bdr {
@@ -182,6 +184,10 @@ struct enetc_bdr {
 	/* DMA buffer for TSO headers */
 	char *tso_headers;
 	dma_addr_t tso_headers_dma;
+
+	/* Shared read-only zero buffer to pad short frames to ETH_ZLEN */
+	void *tx_pad;
+	dma_addr_t tx_pad_dma;
 } ____cacheline_aligned_in_smp;
 
 static inline void enetc_bdr_idx_inc(struct enetc_bdr *bdr, int *i)
-- 
2.43.0

