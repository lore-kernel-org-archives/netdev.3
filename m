Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793779961;
	b=ak+Cj77Q+mUs1+a5j486GPbDHOhwqSlTohTqD4Rj2KsyqVWgreq7Snk+/rfGRirdBjbN
	 Kv14qBJDlct/rT9DAFQyrRqe80vAawx3N70JNz8JfmUZobc6NB7ef0FWpyQ8voX/dGfDk
	 NmcMMQ5ffQPbuKMp5VKFsOhPL8I8PIo/5aFvIrsL3GUsI9qjfnXGd6dzw0AFgtmZ+Ushx
	 hgz8IsZKzjwnI1PrtfG7vWe89Xu+F8DBmTlT+kSP8gcsBquXIJoYKneFANw6g7M3X7S2x
	 kfsodh2FcwuU2aRUryp2MJougMszWrV3LshiCdV2ZZyPRGK/7T9P0gXlY1aUKbQF2EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779961;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	bh=0EHOnjLCsQWwVWb6zolGzjKw9Un/QOXH0dGuxqHYOdw=;
	b=2jXtAaqHHrR6PBA42t1bnsKuVyT3FXK6PpDlawlrm8i2vIV2kOJr4foj9WzDonddC8AJ
	 sz3FZtWduKBm6IISd6zdn8yYDTR7ixHl9TDF+qw3pbO40IVzZMmm9ifuBxbSNj3STKdLQ
	 +RqyVH6JU9vjjkaFw3OwSfuvKjjtwnu/D/t3/tWrFez+IA2Xr1uz2w60ae9hCDKhQkP3R
	 wdk3YsfJmziF0DjQHrdNdXD18+fojUOPgscd8uaVEItNdm4T50wqsew3NXNTjJ74VTtp8
	 6SHOXBCRBtH/NzSl6NFca2THywWaktES7jR6cXVwi80byNExT3B0CbgKiowsmZAE+nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=XwBG6VLW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.8
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DF606A329;
	Wed,  4 Nov 2026 08:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05DF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=XwBG6VLW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXqglcRUuBcUYkLc8ZDVGOFyfuTUqZ9bEVteQY1mOYMuEU2eQ5+bZYhRDQpU2a6bfs6Q56Yl1LJNFF7gCWK+KKgKfFd3FhWCJQCQxu3pysofNhwgVy2tbyqqjzBLLHSsuWHilTlXlXKMSr/b2VVvF5CuWDsxT5l0/SQyVfIEz21ZBAjYr2jxHb6PiZEQNV0aGlEzpVjjpeVJWlCLNuOtYhdF5aXAlmgm9rhML6xWSo0kf5m9MtI9Qnz/chw5MK85sfocbN2phOJfOgmIAtWaB3Meww4zFyO9lWTpZ5RB5eo0ZIhrpRwyXKmIyPXKckSklYT8m4CXTDv92J6IQEy0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EHOnjLCsQWwVWb6zolGzjKw9Un/QOXH0dGuxqHYOdw=;
 b=FCgpEETvQnFOz8UAVag9jrCeNGr+RfW5L6nyX86wru7HlUwtHn51K5x6RJCDKxNWw89sTaDtl1ZJVYjVc7jNT8FdGC0kgy1Yi9hUSIgmFwOdFxIYgjUSsdoyfSbCTjrYEKPHwSR0qGYLEGCJAp3LfyZK/VjjbubP5+sK0MZdIWcQmxRWZt1G3KF2rkV8SbLZOvZayDvIkiZbXFaNy0aDg/bA2zDQrz75qVuVOZ/nczZIuE/Z6po2FTv89GNTb8MrBtw9INNpGliRSWEImzryoLNlwrVPX7MC2MGx2Du4RONLXm+Py/YYABCZeZxwPPw5zbvLon6zuReC9oJd804qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EHOnjLCsQWwVWb6zolGzjKw9Un/QOXH0dGuxqHYOdw=;
 b=XwBG6VLWDFlRHaGar6yUqJCdJCWoGqVT5sMvfGPT0VOJocL2fCB2+5pvQjQfJ9U7QN5v1lj0MBjNzMyiRwktAZ7s8OLQr95vcssLys6q5gZhsNo2P8r6WuPtice75N0uJzKJejzM5X6JMq8MUgT5u3zU/RS+GTxhJ9aX9qXBUvX8F+cgCQDoOGdP62nNrNLukvi5vvIuiJpnXIISGqqoosq4vtflyurwFaYP4CzOA3X2HDawJOIRA2Raq7R9kcULJdNFdwd+F2ZxWD7ajejtiWTzoC9xHgp3ipfQ3dgDdsJfaj/g1tVeWCQn5OqXvCVnALR/POf9hhuFqZTi5i/EGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV1PR03MB989626.namprd03.prod.outlook.com (2603:10b6:408:3f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:12:38 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0569.010; Wed, 4 Nov 2026
 08:12:38 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net: stmmac: fpe: Enforce pmac_enabled in set_mm and keep it on at init
Date: Wed,  4 Nov 2026 00:12:33 -0800
Message-ID: <20261104081234.10153-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261104081234.10153-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20261104081234.10153-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|LV1PR03MB989626:EE_
X-MS-Office365-Filtering-Correlation-Id: 992c8528-4b12-43ff-0ae2-08df3a4b6328
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|10067099003|22082099003|18002099003|55112099003|261009223327099003|56012099006|11063799006|261021123027099003|261102123227099003|261026121527099003|261009220027099003|261021121427099003|261009223027099003|261009221727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	BoonZ8hccs31OgNImEngjFMaVHM3wrc46m9jPgiJFZGqQgQG9pLyTIpkeR3COWqUQKGE65wd6Bx1jU1xqm32TLWf864xDVMZqs3wJRA2XFc6c006jgo6VaiQ54PAxJ3NitozpEJ+8CQl6PTPKKMfYsGwHuXLtq74g+Bd5h4WJnuOM2SmICprgtH+TIBHR8jJy6UXK1DApIGq6hi0Nu4piOmjcQdfeJmJ0vH5bWNeixpQt5u4OlA0QEje3tt9t3p/LLUkymH+Mv1AZ4C5C8Jx/UFwc7cGI5ReJe7uyo5c/wagcOBi1S9Jib/jTbWfcH38Ej6t0Hq287bhOm14LnAYymQxUCwgrREdJz+IfBWN6WkSQPr05ShmFmxaxzL47BRpixzgNEl85X/Ng8NQaLPkCPfJQ/dSPjDEAMJilkicoL05f06T+TrJSmDu60Ww/k+2Sp1Su1mD3E4N8jchz/mv8Y9WG0XSMHPRec9aiN3gNSMs+kgO8Z0m5wN7xSE+zELYnCpBkE9WS9btOAyv+GxytIFhtNnCtoXbQSiWRJiH0/AMjAI296s4c9QkwP3CMPl2lxQqYfJJqv1cvUqcxtuManUFjdi+ZnxOz1HPY4Y14eU1qTn7QcSezuRFGxRKOwGsjLX65b1UXB2OE/F3dI5i+xLGF4RtHhq4dyE/uyJUTvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(10067099003)(22082099003)(18002099003)(55112099003)(261009223327099003)(56012099006)(11063799006)(261021123027099003)(261102123227099003)(261026121527099003)(261009220027099003)(261021121427099003)(261009223027099003)(261009221727099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JruV8RhkTvUysbrRTjg0I+sRmAfEKB43QkMOyNqh9DJ36BiNG8SJpixWhG5t?=
 =?us-ascii?Q?bcUG+EvYWMS2Ew0MDRoBwbpQp3eSiCbxHHRWmE7LRZa8QbiyqSNifo7k+4sM?=
 =?us-ascii?Q?egvPATpV4XK0xWtE71qbTO1fpGNqZ7uTFwZKBXl3Yyv49JOOI0flK34TflWp?=
 =?us-ascii?Q?GLo+omfhqkmOGgACfpPA7JnaeFqQ6qELEQSuYzveDlWQ3iO2XXJhk3o2IxmC?=
 =?us-ascii?Q?HNLM7gPBvQxFRKjFQ+5ik5IaLuup+NoQ+4hqWbqXZfggtcycFF8CuOIenVLG?=
 =?us-ascii?Q?wqdUY+TlSRBz8vExE2ANSCmiVbBdZX1ETWo1jvsM0g2aQrFDvQILaReSFxfN?=
 =?us-ascii?Q?jya8MHi8t8t+Yfz5KVbOxXc/5IrGQoj5YBEhfdbLlWom/+jyRm72Gp/bGyab?=
 =?us-ascii?Q?iF3xwIjn6v8Evk1Apt60XZxqGt5F5cmv19ocWSXWyrNYSx0Y0nGSeTpJOjia?=
 =?us-ascii?Q?svmQvavmXawWeDAqboy3vvRdrOaqYpV3BrfGIfZ6lbXAI8PqwTBSP5DeyYYV?=
 =?us-ascii?Q?HVvck0BbFPMgi4Z4rJDOUEFxoWmtCL8j9PnXioJyp8fAQ5bc/VJ6TBafR9SH?=
 =?us-ascii?Q?/346+rypVKJ2L9SNlndrmq57ZQJ9Y5FBO8w705dVJWQvp0KAiFzv6nLzlcrP?=
 =?us-ascii?Q?FwZCf2Mfj/++1o02UKh1+zwCs4p9b3hi+11XgvDJ7y2rpqmCGAzLi7ejeE7M?=
 =?us-ascii?Q?ZKZugUVfWDXfa5GxTuWPS8NbIE+HsGcdzsGpUmF7RXWWolacnsH9DBGA+ZWQ?=
 =?us-ascii?Q?PiWv4mHBK81gtxe8JaHjrOYSrcodlhY5IemosF7M/vDIM+3SbFUStwZB81Ey?=
 =?us-ascii?Q?T3W0/d2UA2hYDCuKOFC1xwlhmpb8C1c6q4fXuC1imnw9Hq+ulkv1yWC5nrRP?=
 =?us-ascii?Q?5eek4J3BDxjVEbloUWnYXv0QAgye4W8Rso0oZBooK1zPopgEbQdcGrHdU3fx?=
 =?us-ascii?Q?H0xoGw3WbRN2HzFbl61I+1yLwVwx4+lnY4twgsGYQvjXJeLHOSuKgEWSCzLK?=
 =?us-ascii?Q?ROA736JYkQ2Rxkx1JuL44G5zNss2WHek7iN1MtyKz45qVFOAJtKpeF6yi61n?=
 =?us-ascii?Q?bDfHTnYLeb4hFOq566DjMZlcF8EiBsukJLs1zDCwTqzvliKWmUkMbqNgCSBI?=
 =?us-ascii?Q?1S1YJD8zRT234RBPIHM8Jg5tZp1vYPF+oxyFayE4fL+xgPjObDu7ZgFJvTEE?=
 =?us-ascii?Q?TAxYPpbexazS1ydYiqBFel3QvP03hA1LORrVku5SHGxNQNhuzAkOYUkFV3m4?=
 =?us-ascii?Q?5ORslcpbesOX3bNMDBEgsXcCkbSd8AbosHy8KzWtjeS8RApR6tUAF2X1p1/R?=
 =?us-ascii?Q?0puRL/TSuWjJQvutCQq1hByrxJbwPWZ1CQlz5Vlyvmk12M+VgEaLpspNUZCy?=
 =?us-ascii?Q?2aAHWIcUHth6WRy6d9UJLgZc92BZ0+n12xBptOMlLpuiMxE6qoEFGioV2nSm?=
 =?us-ascii?Q?RXLX31SpI1/lAXLS5ASgHqBmfEd/tKuAsYxr0g2CRQaDXe31dS+Ffe2DvmOl?=
 =?us-ascii?Q?KGdlC9K4JpxzhWMsRWjinwP4nsZvkfOCiDckfdZg2fzTk7147Vq48LeEkJMp?=
 =?us-ascii?Q?e0bU+y/BISjiOyUPex2wp4t5ULfbPDZ+iFvqvqnjLYn2zUrNKOflLaDushH8?=
 =?us-ascii?Q?4Y4KPLlPt3CWiX2hrr6GxcQ0w4ckPawCnLVR0EqYzVjxehKJo0W4k3sq5xm4?=
 =?us-ascii?Q?PdVWGIuavD6/DGgOY5oi20H5RvnfctCnKmyGNtaiTEXb7VII9ibF6dRQZLnN?=
 =?us-ascii?Q?1mcEsRGYhsueuNmm6TYXYFbTGz4+WPLhOhOCQzwPocotJLgT35fJaJMf0oYr?=
X-MS-Exchange-AntiSpam-MessageData-1: 7+60LMa6YYZ+pA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992c8528-4b12-43ff-0ae2-08df3a4b6328
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:12:37.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: da49r7cG5oKGgz1XRHgbPhZ5FIIYs5KiXRuiSmpcSpoCIEPAZcpNPfKyo/9/iLTxYWTsow7s+NGAhmgUHdZQD+w+LJ76HQlz8vJO7Sk+ifTh0j64ik2nG1jqTjY8wDRMeg5WYhmtOkFBNVfXwMZnuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR03MB989626

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The preemptive MAC in DWMAC is always enabled, meaning DWMAC is always
ready to receive preemptive mPackets. Initialize pmac_enabled to true
at init time and reject attempts to disable it via ethtool set_mm.

Only initialize pmac_enabled when FPE is actually supported: gate it on
stmmac_fpe_supported() and return early otherwise, so hardware without
FPE (dma_cap.fpesel clear) does not get pmac_enabled set. Keep emitting
the "FPE is not supported by driver" notice for the case where the
hardware advertises FPE but the driver cannot wire it up.

Also add a missing fpesel capability check in stmmac_set_mm() to return
-EOPNOTSUPP early on hardware without FPE support.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v3: Gate the pmac_enabled init on stmmac_fpe_supported() and return
    early, so hardware without FPE no longer gets pmac_enabled set. This
    folds in the previous "Add missing return in stmmac_fpe_init()" patch
    and fixes the condition that did not reach its intended effect, per
    Paolo Abeni / Sashiko.
v2: No changes. Collect Reviewed-by from Maxime Chevallier.

 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c    |  7 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c    | 13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index c616a1c95e5d..0dfb312d72f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1066,6 +1066,13 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
 
+	if (!priv->dma_cap.fpesel)
+		return -EOPNOTSUPP;
+
+	/* DWMAC always have preemptible MAC enabled */
+	if (!cfg->pmac_enabled)
+		return -EINVAL;
+
 	stmmac_fpe_set_add_frag_size(priv, frag_size);
 	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index b6b5ef7c8fc4..2607e29930b7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -173,9 +173,16 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
 	ethtool_mmsv_init(&priv->fpe_cfg.mmsv, priv->dev,
 			  &stmmac_mmsv_ops);
 
-	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
-	    priv->dma_cap.fpesel)
-		dev_info(priv->device, "FPE is not supported by driver.\n");
+	if (!stmmac_fpe_supported(priv)) {
+		if (priv->dma_cap.fpesel)
+			dev_info(priv->device, "FPE is not supported by driver.\n");
+		return;
+	}
+
+	/* The preemptive MAC in DWMAC is always enabled, so initialize
+	 * pmac_enabled to true to reflect the hardware state.
+	 */
+	priv->fpe_cfg.mmsv.pmac_enabled = true;
 }
 
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
-- 
2.43.7

