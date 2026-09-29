Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0E3EC810;
	Tue, 29 Sep 2026 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708810; cv=fail; b=MB3unA69VF1Ro8ejRvq33ivz9ZU57vUq1Vv0kMoh8FBU2xlydfz1Ta+7cHoGEnBp4VfQI6NtQfr93vUnjaEgIR2TmDtRvvWYc8ZP/ND2GWAdYZerrqcaF/fIaE4aEF7BOdZXDBsLjl/a9uRL0jOC3DgRPmVwiOCboE8g6+UiXXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708810; c=relaxed/simple;
	bh=IP3Gt4np9PcFDuAnZ6bOjT8lPH3LJeu7L6Kj9Htd1E8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZgFGlYmB04vjEaoq6yoMghs+LBiaikZ1ub9VEZ97rlTDVEWEvQm42u7SEacZZ4xU+Uiy88HDesIcaHNwuC6npA8Q7H9DBA+or++VeEwfa9aTUmHlPwtmsAZCkDd02Fnxtl0WwGlg+nut+tqZBMkBMEh6Ksby4IvkNtwERE3y+98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fWXFGd80; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fWXFGd80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBjPF8xjvai8+rk71VMj+ZFJAXmn20eQM/ksWpPhPWlUX+mNehiqgmW3L/u2tAsW++n8mRh3W0z0fr8wwWFw3e/8Kl2VbZ7WWP9un4vcnnaY08oplFB6XvLsamWbUErWyuSwwyFqrzhhF+ZXbnZC2V/iZOuqNOMVZw1tnvVfPlgoIcuw5+HyLGVHLjS+44grhz72GfCv8Y/MqYEhG943MPHoKXn7hCqq+ueUjgx6bDayEDltfqbrFqMsnc15fPyTNjQ8CXywQm4dHHMipUz4uwZ5kKASFl55pVvDO6wwomTD38gf0gbM346uzZPrGOgPIvTffqcxVFMtjkoP/1Dh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeT0xizABDVvfmPND3KOkhjqtTL/Ptu1R9Ha+08a+5Y=;
 b=YXhLt1l2kTIR+Y0Blr9Amrynf+hPNdOkYDPA9wr3DNZYjCxCPXCRannyPfYV7oAxcvSb7mzVtUdFgqxiXIJCtivK9RvTsgODEW9XCb0pseT9dA5KRHeTONWlEF2I6+TGHY1SgFGGlq19ln8STEvTI/kvNEme8GQIS8xFGYDpH/1VIcrjQ2WQrdLd8rlZpeGT6pUbh5lue7WCTLvqcCTLncSI5742OEjMfl7+tSuoTFW/NHKCnPoltjU/Q8yQb1WhKWTgVAIprMJt3U/m8o35yOmX1aG8zgCeYorTJR0mwiMojYghlVls67QePV974OzCApGp3F8rg2mUMjR+gL6DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeT0xizABDVvfmPND3KOkhjqtTL/Ptu1R9Ha+08a+5Y=;
 b=fWXFGd809HS9kequLTYdZXCukNcWuabLcpXtdq28DXz0VvMGMwTloIl4F6/6ffE0ZjxmLhd6k89veMJIEbBGqCymKdtbEZHx8PJDUkFN+DiCoLapTM5Pbr0z++alBr9Wivd8lhLZG5lFIcaP5++7jue9MBftS5RHY2GYLR0ySgq+dgiPZ9iwAyvoHkEK7QCbwFTVcVj98M8ku1IV55aCvbyUhZtKqlt7Z4u/ZZ02XBYXC6YvfxuCJjAqCoRVhiJ/qcQ+EQ8IMJrW+AxCxKXaqqLeDRR1d49JZrMAMW7X2NAFwe7748nK6DIeQKFCy6m11+1Zdk0+TgeQmn1Zxh3GWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB759424.eurprd04.prod.outlook.com (2603:10a6:20b:799::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 29 Sep
 2026 19:06:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:06:46 +0000
From: Frank.Li@oss.nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	Li Youhong <liyouhong@kylinos.cn>,
	Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/1] net: allwinner: remove dmaengine_desc_free()
Date: Tue, 29 Sep 2026 15:06:36 -0400
Message-ID: <20260929190640.3516766-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:930:ce::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB759424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5d9efe-2c0b-4c8e-ae96-08df1e5cceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|7416014|921020|5023799004|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kYoHH08lNuxdHP/cQCIyXLxFnRb+AgBsFtZaP9X88JsO7NFhY9xgRKVn3XteWxjHaO6YABrFajF+Pke1XHAdWAnZjxoMw1QIQRIzItaoM3OnOgK6lJ35BXlktKv3uklgXfPTViTp+qA30y+3YJ06xXHDi2RV6tbq9I5uBeutlxmBqr0YgsvDgYu7kk3AQyUzpQG18CVXZvccTdcHxEX7/Pp5qAwnnoQPDfukbDz6NUPPXvaVaa0SqLzSL+B2T/ct6OG3yIwPuqrKDUJNoIBPF0qyW4kIvjfP+lYoSKc3ip6nUywT7BHpiib1FPHRhbLRiLJqIq2cZasPdX1wBlqqYmoEbwv06AtGmm1MbmVGWNrdYFS4kwEKG5uQBAtLUXxHRse1u+wVHm4P4PQI9LxyGxKZs+agA11exVP+UpB9tBvnfA7ww3Zx1xo04NP7baASGmJgZzM2Kqf51HFmm+HxqWuMzASnAL4IUm4lKhKVs921P4XogYEDcabNi+K21gJrT1/sSu3F5aQS3k+yhY4uEnmmeYPhxDN6BGctlEI8BGdaGwYvVkvBKPkShZgWcjfRvsf/icm1/k23v3yrkd737EegxgxAA0MSC6YjP9nkUHwHlUaJzHok1Kk14wn/qNDPRZKgdsCS3XdwBX9XNsmOPtPOMJMnwt1obKT8LcvsYO8H7Kaea/cbzZW2xLWZ2movZGQifYINYpxEP3uvB3IdYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(7416014)(921020)(5023799004)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0x08VXYqpyU/WDK+992EPn2g86BrM83qXZp0hocK95/CSrhkUFg/RAKBhrZk?=
 =?us-ascii?Q?KV2o3smfbGPAiICxyyW4WIOP9hlyzNkggC02SO0SA1QfAfXolU06TRFJ2u6a?=
 =?us-ascii?Q?B2hFAX7P8nHCLADWeAZLV+dLCnkbIdiNRbo09AypvqF60HD768ZMSsQlDU96?=
 =?us-ascii?Q?gCB4RFFSFlu/rh4iIuhbOvAeAHysjn0L9B45zwzvMjW0UjkvefWWIQ8ZMJTz?=
 =?us-ascii?Q?8NvM4mx+kVV/9/05Lkkn3UvuzDdcozglEh1BOF06iCIyNfzZMcbIbas/eVCw?=
 =?us-ascii?Q?lndPpkgy2+PzOx3s+KCxR6syDmGbN3XK/8Zi/wrSXDOU8W3c51q27m7RVTDn?=
 =?us-ascii?Q?x/cK9nY2In1bRq8JpBbUf3bI30P/WxKY/5SYydfgRADWb5afAVUNyiVJGdr3?=
 =?us-ascii?Q?5+iL4NDOei9s81brpGVzg9dSPh4clqikYTnHh6YEnul7s/B8p5tiFMTcT77V?=
 =?us-ascii?Q?8uCk9zvJD4H+WSWt6B2UgKbtteh23HlDybQTYceexEiovXBslmalGktmeLf1?=
 =?us-ascii?Q?t5gHIaIvBFX/8xeVWaPHBcpLU4xsbYSnx7RBLMD6Jbb2SKKKdVCkHhXw1Wc4?=
 =?us-ascii?Q?gnPEt4Ed46gS45D8kKn0J+u8uE1XawglusLHvFlVNn21hewkTjYY1bF1p6qw?=
 =?us-ascii?Q?msPJwIxAN9kJju5IOQizpp2i7EBxsSwPeqq2dMUMEGN4CE/Z7ePbHZnTLKCu?=
 =?us-ascii?Q?GiORCHXsls/xGS7WVJ9RJHC1k6koVECxYy8GEM4EBND9D76rwVBzK1r48GOh?=
 =?us-ascii?Q?CQQ6LNyFsX1Hht/HlfxolBlgAB5UBarb9Tz+0umO80XicE12OoMHVsT9Frft?=
 =?us-ascii?Q?94G//hP2+tFoYw4T6z2SlVdC3Z5NwqAnwScgVScwlXciPDk80F7BUEI8TyxI?=
 =?us-ascii?Q?+LIHuSCw8tQeOmfMR7jnT/WZicJcZWHIgtCI0Xwlu3xm2pdVp2ih23uJpK/J?=
 =?us-ascii?Q?PQASbUSgl0OUZDXiNPUDnuj64fW05I1s1RaEwWDKFh+Sn2Rdbf6+18P1NswD?=
 =?us-ascii?Q?4qtKHyWnmyLTN/9rrp+xEl91eT6Fr9OBna2R4GG/qdJNYPE74Pa7nbOv3mI9?=
 =?us-ascii?Q?/s1L+Yx79f1zRvEnMDIZZYErIpTQFgUGHADFjEJBfQ2BMpjyaBy/91CXC0rr?=
 =?us-ascii?Q?enbUjzdHM34EVh32Oe3N2PM+6g+UPlLdqnrQEZecYv3z42l3sKx7yWRGwG4c?=
 =?us-ascii?Q?sPiHDRpr2yfox4SOvTGNstZitOUkob7ux1X14vPHHGzO6XfA3tJCuxnuxiaZ?=
 =?us-ascii?Q?iUSmbs7B9ZeXcWSX6LHv+/gWTs570C+LHbglmDCft2Qdx8vN6CKLa42bQ0ZM?=
 =?us-ascii?Q?Nk5DtUz+RFe63B0Hpq+pR3bSNDM/WbaKHPXb6yVa9mw58afs5u628A/lI6TF?=
 =?us-ascii?Q?O0qBrVPwFYbnFCmVY8Wvh8a4yhc5eE9jtPr/vxeDKnYsYS4CHoMl7uMPJ+F2?=
 =?us-ascii?Q?ltJAcuQpwiBxYvp89aar1IzszwxIxe2q3xtPeGIP76CJAd1B6snQdtBukh7N?=
 =?us-ascii?Q?HNNhPzE/NXNcgmCipRH4RgCvUcCSUtyqg8Df7QeDqD169yGq6kjyXn5NXJiH?=
 =?us-ascii?Q?+7EMfVBbS6oYB1AmEbL6iJ+Jfm0zaFEYbQ9Wfg40XRuVNasML32iE2ymMeMZ?=
 =?us-ascii?Q?er096qoKGaTmFFcSLVv0G+ElLut10Tom972MC09327f6wE/ewZZ1+LICrJJv?=
 =?us-ascii?Q?VeaiwG2nk8fdVJaDZ66xb9+m9ScXK4ybfTyvz1WHwrZYoWKljjS+P88v+AUf?=
 =?us-ascii?Q?CNYSB59tURnF7lubLbQLfF+KUSX56BFxIQZ4uSVEJ6/lcJWhjkDE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5d9efe-2c0b-4c8e-ae96-08df1e5cceb2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:06:46.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoQV21bz4VITnyDUTn7hVf6kR6kc+ngHo5NlhiVuqKmsvgcIX2bpg1TKxQ7k1Yq2RzvgBHih3ss3lEjT6c8nWfVzqG2ZuQFTGpNVu/5GqdB593rlrLOThoy4LcbYmFAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB759424

From: Frank Li <Frank.Li@nxp.com>

dmaengine_desc_free() is designed for DMA_CTRL_REUSE. If DMA_CTRL_REUSE
is not set, dmaengine_desc_free() will return -EPERM.

	if (!dmaengine_desc_test_reuse(desc))
		return -EPERM;

So calling dmaengine_desc_free() does nothing.
dmaengine_terminate_(a)sync() will free all already allocated descriptors.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 0ba67a55705d6..09b2abdfc9e84 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -300,7 +300,7 @@ static int emac_dma_inblk_32bit(struct emac_board_info *db,
 	if (!req) {
 		dev_err(db->dev, "alloc emac dma req error.\n");
 		ret = -ENOMEM;
-		goto alloc_req_err;
+		goto prepare_err;
 	}
 
 	desc->callback_param = req;
@@ -319,9 +319,6 @@ static int emac_dma_inblk_32bit(struct emac_board_info *db,
 submit_err:
 	emac_free_dma_req(req);
 
-alloc_req_err:
-	dmaengine_desc_free(desc);
-
 prepare_err:
 	dma_unmap_single(db->dev, rxbuf, count, DMA_FROM_DEVICE);
 	return ret;
-- 
2.43.0

