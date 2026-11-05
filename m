Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793845978;
	b=0btziPlti7scuO3K/ftWegy2IUI+ZMEgFiJs5DfwTHWt055Pd4yiOfeAeVPKv0UwcV1g
	 LhED8T/jPvaDIS/genWDdMaOWhAZHbv0MkH74U6pfaIOgN3nllcbYTXtgUD2QGeB6S6Yy
	 DAQmXltczmszRilM3sU3eQ0rHhddnA9t0vf990BJqvtPjzHFS2jSEf7sf9mduwv5/V6YY
	 eE/Q3p+rGRZeEU37ZwAHPgaHLNSlHNUSvrSxlQedK659nC2Lpr0H9gE1aatPLSgxkaLOD
	 FxfPwZZ6DqVSJwCypVf04VPND1vPBLwKnfvKzvgrmOsny/uO9BadWQXEZwPs68pcZOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845978;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=L6jNYr3+I2TRbJ6lO8eF3ELPRVGF41ECwcb9ijXpjdA=;
	b=Zx5chhuUB+ciKDbdz40LdniIgKzbbxITlfbfjYtQFbJzf+ZDBcBUqtZfDL8f2XIOvGs0
	 ztTyeRdcMO5QGFykfJdKFFD718Ojj3VvYzqOBBz5Q//4Ev1VbIOfPv/4OJ7l4Iugb7/7h
	 kzmCS5M7sEVyyW8mP2gXE9FUE8sbA+GsPtA+URkR68nounT1ztDiKne3VJp5TdxTTgyu3
	 defncEn0JQrRo+tUfd7H4aD5pgYxs3UQhMOpudhTqHzJk2F21EqeA5zqqFsv6vGudokXX
	 CWvsXPEQCPiWOdMB39upFY/OuYVCF/OLkJSNeRBK2RAhLoGOYPrFJOdtuo+zV/f4mfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=NKgsFCog;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.8
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AD606A326;
	Thu,  5 Nov 2026 02:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 927AD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=NKgsFCog
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNA7S37PImboqzhqWXvcOEA8owOWS46LyYCZxmkqfi3eEfl+T0oyUlpmGSrJVvejX3yEIwE7jmEeVLFX9JQ+O4yU4h5vo/cTHljYWP/XSaV0w6wCfXycB4nNioHTwiVIrBqjDGpjrzlKsrI3BcDNVQ4mMmLwpzB6UYLboF7vmLGIpcj2PXavkw96Siaf21WcAoKaSdYtxhfaZsHCYZn5ebxnlo6oBXy2mWkMC5Q1xCm0KiN6+lrZXkCPtw73tkqL402yOKv9KzifyhWxJ8LnCVERTQAKGf720piQ86AfLuGhxVSaakritY5YGJe4+MF2YcRfHeaBX9vnUhCiH4oGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6jNYr3+I2TRbJ6lO8eF3ELPRVGF41ECwcb9ijXpjdA=;
 b=K7cZhjk1xwlGeLbmAbJuoQSmTLvWsKvbkvJHUCPrpaokvfuLRkvtSOBxBuPJELbNFJAo7ca1qnrjeocV8ZLUpidJWgXhyToFSiObI4w7lLZbhuCgvrif4BvUxu/YIGlYwLQNGm1Cx461oa3ShkzqllBJM5bnnKrIhYGrEpkudwZkEEA5RsoRZbiV54M3r/d1kuyCZXITQKV3BTz6UpjNIg0vAM/3GJqZfKGSScHS++cxQDC1pOPxuJLuTVPkCMvzxB1zrkkLSGxW9ZCElVQ5iY2alyBg8npVOwO97TyqvMsUECwrmEyIYs8eF/r5TzrOSzxI66uOwefrE8lHFfEd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6jNYr3+I2TRbJ6lO8eF3ELPRVGF41ECwcb9ijXpjdA=;
 b=NKgsFCogYCLsDKacAIyL4mcqDbk8tjFJwEAEW7ug4V0gj/2HCuLXiKKEDnG1q3JV9W4gg5HI9AX33FQBjUMkq8zyi5B8ei7H4FroF1ps/2mtgki7tVCSawww6YsLXjqNesKAJ0iFwjdnm0LE4lZ/8MEOxTJUKGOBkB85cXbhvQkZ8luo13FjJdZyIXROJeGhXdRrapvxtqGQ9tqimjfaAYLMBIZ8H0RyCeG1Jo6+bPjbqNoE50ApD1BGkBJ1TqgZRRkCyfHyGDX7s4YwF10RoP7FzjZGfG3y5cvz4ET5np9+NQ7QaVD+rqVOHMruHN1myxLMm4jLF5q9NH5PW1Jomg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SN7PR03MB7274.namprd03.prod.outlook.com (2603:10b6:806:2de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 02:32:54 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0569.010; Thu, 5 Nov 2026
 02:32:47 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: stmmac: dwmac-socfpga: Enable multi-IRQ when per-queue IRQs present
Date: Wed,  4 Nov 2026 18:32:45 -0800
Message-ID: <20261105023245.4683-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SN7PR03MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: cc290210-3732-4bd2-43c2-08df3ae5141e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|18002099003|55112099003|261009223027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|11063799006|56012099006|10067099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	DjxHl8NuFTl/jKretbUrjFXZZygYn2SX/XQ97fwqD+2RuZtgvcQQTCXfsBAuAIfnV887Vz7HHf1cUY9X410LoCAL9md3+SlGiCIm0IamAs0Yr0KEEM9IYxAq7nZ1UKfZf5h3JjXTFKujj7ph2QfpHnbxPqJB833ageslvwvsKhXKRyuJ29TKl0NymiINcfF6ecx5CzOr1aSLOVOAHzqpGw7fYvJvSo/dhEqSnpdnQj5zFUNOy3LtgpCwWdrDx6A3o5Dg8jdFA1LzRKpC9vuxblRylUDkgtWG6lDjH8x/zikLNE6Wfs6AyVCR29PDF1WfYb10kGmu+b7in53L2STvpIwIx1Y0bWMPvwV8kslLSL0daiRTwzVXj85MdOLh8PuhTYB9/wV5tijA7C0XQHQy+qZdNbBEWaPXbKYqPBdPxmPTKHPkZwX7PzzM0tuPGE9jCAHD0qRBV9d1NH2Yq1oZv0dq6HwcJqHRttTyEqdbJw4uyolI9XbA3uCyGKzuNt1uk8BDh7ttQy/128Ed2JBb1LMulY2ZjP6cWrSYmkSsFp88m1LQu6KmswjNux9dPs/YtPgwrDVicEPjWj1R5Y1gQndBmS6Oe7cDgeX1hmDh6c6KsOPGZETC4Uy0L4mQCtSb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(18002099003)(55112099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdAEVzen6R8FIcY1EDcei2WYmonyAHOA1GYRa8ecyrEz3F8tb4pETS7g/e3V?=
 =?us-ascii?Q?Dx5DuHsp9EC51YYqkxKDZ64352VtOSxw44fXh34VqS1aeSYyoMub4qOGL9Wi?=
 =?us-ascii?Q?glhvQv04ja4KVMQ/V80P71Z5sofCrWwYMmm1BMHfRfQqlF5WLNGZOVnh/Dxo?=
 =?us-ascii?Q?ozMedlq+C78y/xax1bgPWS1vIjLaczvB5SMPpkx1i+bPli976wW/W1ehrVOY?=
 =?us-ascii?Q?aSq7mTCjZVA1H0JxfmanAuaXzykXoBYwv8avUelDKZC5D8MmdKl4OfNk8Dp8?=
 =?us-ascii?Q?oer89iJjRhAG9/gpIM1x0FDKbYVz2+1j219cxZrgupAa37nrfkPMGSAH/JUJ?=
 =?us-ascii?Q?1j1QQAEm1gLcvtWf9g1iOP3Lyww/2uRYZn1H28qFFyTSoWk5NB2zghxHR2uG?=
 =?us-ascii?Q?AjE2O8tzSbEuutqaR22yx7F4B3cd/lgDKmj/0V7L1j9qDIWPS3bLa3CNVduf?=
 =?us-ascii?Q?0sUnSLzQ0IDTNx9UqN97KeU5weL2jxYeh1Q/xg8z2dCehXiNaOqvobtXw8VB?=
 =?us-ascii?Q?K2u2Lg/0T8G6PBBtaIV4p21mSiUREpWAO9mKbkhAVOi4s0fdmzP6TW5yBZ+B?=
 =?us-ascii?Q?dsuJMPqgmt3PrHxVtIVwMFOx7MHqfk1tnqgfdsG2UH99sBLsT3dTWZe5/4w8?=
 =?us-ascii?Q?fkOYRa3H9amzkyEAFmHerNSEtuRK993dqrv6qY9Wp6aNrWKbSLZVUdXuVJRs?=
 =?us-ascii?Q?FkkMAHqxUkRnbjd+eBKtCwbiIAVMbwYPWLlKnpGok6atl+mxMqLMXQpkjiBc?=
 =?us-ascii?Q?nk6jDGf3dQe7uCj6JYJI7QiXiBdQGyHUOHUHQgMQyfJGE5WpBpyggNdOKq8o?=
 =?us-ascii?Q?CvXBVs+fD5+wv39yStaKQ9kjOrBpb/vgaMGi9CRX31nQSa6+yWwlRRpXmZfI?=
 =?us-ascii?Q?AMaIclrI7FHwHBIwR6UoJ4xfq6XUnRgNKuj9h+xzp5kBPVDNKE9+m+3G7WBO?=
 =?us-ascii?Q?z2tqM3SPie+B9NUu+JZLXwywyTGQVRWae/OnrmChzgfFFaldsczk3zfIbFP8?=
 =?us-ascii?Q?mypibrpa8YWdsvn8QHeDFCjAqttQFkGwZ8IdLqBWtqE18ByX9pxhsKT3m5YC?=
 =?us-ascii?Q?zcHnOtYpK4PHGZGWzG0t7EtGs+FuKRHbCifsqSZvJeCPGrVq4y+3sEOqsqfD?=
 =?us-ascii?Q?Xkbic9jko4+dd7sEhcvm/HaicpQJzaSu2iJCu1jfBEUwmQ7ljU94yrHUW0vZ?=
 =?us-ascii?Q?lDbeakERZHsESVYOmfrcOMuWlnH8lPrhppjPKlGh8IExaa/5dwl6jRuIX+6L?=
 =?us-ascii?Q?d15TBby3ZuFoIGN66MjlGUNRnXPZwRcM/F51lZBrQ37J5mlW0abEk41PjLmJ?=
 =?us-ascii?Q?V0QzwcQHyHv9VmtM5OdhZSiT8t/HlER/AeQcE7zlOQYobTI6llEZbcJDxQ/A?=
 =?us-ascii?Q?4vlqNIXMg41LMetOjYslEP01YdokBRJlM0LxOQFuUMW7RwNJQSRXw7cYtJFN?=
 =?us-ascii?Q?j8/5nh5ruN43s0tSiFe7aGG6SR4sUrAxWpahsEj0iZSmTMm01YCXK7ZKi4Nv?=
 =?us-ascii?Q?HYCwuD4LlbjtkRQQoL6syuCARm6kfFytEXSmX+2dxL4HnH07G4tUeaI4cSpJ?=
 =?us-ascii?Q?6C6YdHLqJtMB/WGEGq5/94Zp7P8uiFvZbB1NKwlgx1ibDvlK+DrOpuy4pKIb?=
 =?us-ascii?Q?ArrNr4YIB2OJF6mPOyNVmJ2kE2Q5u9382Yq7yhOKw7KC3wlJYIM594A9QysF?=
 =?us-ascii?Q?uC4aATBmmoMjmzivL+HxIkQravfUIA3k78tpG7trdlnZz0bYspGDs/pm+fTj?=
 =?us-ascii?Q?nHFBABkSebfHKpkK9Zuxb7SLj0/qFY7/L1n/VO1ReN8dtny5+bWBfeCSObK3?=
X-MS-Exchange-AntiSpam-MessageData-1: IcokuLT3z498Yg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc290210-3732-4bd2-43c2-08df3ae5141e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:32:47.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpkm/bZnmGaCw2K+KZyQAYgFU+7rQwPnxf9BbJzHySVVSsAA9P8pxwZI3Fd49WsEG2Vd2lIbwLdLbrZ9ngx4jG/VdR36GkRLVNZwTWyPsuhVcDnTvBwo6wBJpBh8ywiSBr9VSi9PuOTNBsV64ZjGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7274

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Agilex5 and other SoCFPGA platforms can wire per-DMA-channel TX/RX
completion interrupts through the GIC as named platform IRQs. The common
stmmac platform code already parses "tx-queue-N" / "rx-queue-N".

Follow the same approach as dwmac-s32: if all configured TX and RX queue
IRQs are present, set STMMAC_FLAG_MULTI_MSI_EN so the existing multi-IRQ
request path and INTM=1 programming are used. Otherwise keep the single
macirq path.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Background:

Per DMA channel interrupt support was first merged in 2024 as part of
Leong Ching Swee's series [1], and then reverted in commit e9ee910218ff
because the devicetree binding had not been reviewed yet [2].

Since then, the remaining pieces have landed upstream separately: the
binding allows the "tx-queue-N"/"rx-queue-N" interrupts, the platform
code parses them, and the DWMAC4 and XGMAC DMA code programs INTM for
multi-MSI. The Agilex5 DTS also describes the per-queue interrupts.

The only missing part is enabling STMMAC_FLAG_MULTI_MSI_EN in
dwmac-socfpga, which this patch adds. It was posted before [3], but was
deferred because net-next was closed for the merge window.

[1] https://lore.kernel.org/all/20240105070925.2948871-1-leong.ching.swee@intel.com/
[2] https://lore.kernel.org/all/2df9fe3e-7971-4aa2-89a9-0e085b3b00d7@linaro.org/
[3] https://lore.kernel.org/all/20260817074221.27459-2-muhammad.nazim.amirul.nazle.asmade@altera.com/

 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6d4bc1fe8f75..2ca45b3dfa90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -596,6 +596,35 @@ static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
 	plat_dat->crosststamp = smtg_crosststamp;
 }
 
+static void socfpga_dwmac_setup_multi_irq(struct device *dev,
+					  struct plat_stmmacenet_data *plat,
+					  struct stmmac_resources *res)
+{
+	int i;
+
+	for (i = 0; i < plat->rx_queues_to_use; i++) {
+		if (res->rx_irq[i] <= 0) {
+			dev_dbg(dev, "Missing RX queue %d interrupt\n", i);
+			goto mac_irq_mode;
+		}
+	}
+
+	for (i = 0; i < plat->tx_queues_to_use; i++) {
+		if (res->tx_irq[i] <= 0) {
+			dev_dbg(dev, "Missing TX queue %d interrupt\n", i);
+			goto mac_irq_mode;
+		}
+	}
+
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
+	dev_info(dev, "Multi-IRQ mode (per queue IRQs) selected\n");
+	return;
+
+mac_irq_mode:
+	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
+	dev_dbg(dev, "MAC IRQ mode selected\n");
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -655,6 +684,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	ops->setup_plat_dat(dwmac);
 
+	socfpga_dwmac_setup_multi_irq(dev, plat_dat, &stmmac_res);
+
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
-- 
2.43.7

