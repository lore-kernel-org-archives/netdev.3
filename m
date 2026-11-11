Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794378196;
	b=xV3zZZZLkDLUnqpQ3JiE4eSyx6KTwBX2C8jsEHPvUZxFnRJK2KgLdziQ9ctprwgkUzSS
	 KnaX7je/Fg/9V0eS4vTN/XdC6jDVWV1dI721tm6eSrrm1ixAbR1dtgeF8IPEUMMQPbWfe
	 SytoMqD9z60GW77Ld6F8cxdjWWxvFwR8VvZV9bfN8/gNBJMU9Ewlk8Jfid8qTVCcrm44l
	 IX52Vac4RmO1wFFJJxSv5TsZY/WZqj2wshDxxorlw16G2sj4Gjpffo+vTGY26y+5NQEP/
	 XpK8l6I9nitwjvxI7j8s4MNaCeLEXSyjtpdaxj0WtCUec7j4wV5MgDGslEvnOh6X3Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378196;
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
	bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
	b=4VwcV2ftj+XN30BjssmsoAYvumJlmMYw7hrFSvA6gLsP0ie0lIpmNFwdkB9xoA6/5iqe
	 X8fbRAq1yIW1+TVfpvIsl2DCxpGpwRHDXNHXlWdNtBfQKVidSROqERlQBppLoOqSBP2LD
	 ULg1yh5tAttUyXtZu8/3Fm6UEyVPXxkZWpvzFkPnRNO4dNkp8Aqdm69I79geG31U5agCC
	 1Y3juM+M8l64fY+m4RFDfHvZ1efZwTZleuVz8LfiRchfYNyAc52tqMqpQDNZA4dws8FtN
	 UojzqH1aqAKmPbM/kezkb8VQzc9u4FW5u7pDnKMGxLCb44MSSWjORGCNhW1mcIe9B8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nGRWTQPY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.22
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247D606A320;
	Wed, 11 Nov 2026 06:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E247D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nGRWTQPY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWx2h4wYVu3B8El4fTijH9IpfYMDag12akANmy2E2JnTMi2YmroJ7e9v/O3fpicYD04z8axj7kHwFIdZt89zqxWwhOwa7Rf19SKvKedAAurett/G16f0CltUWxlsubKMiQ0B7nc5y1tVUFyVSOBfvsc5tIlpfeqc71gFKf6yOU4z9e6tlRC7vZ3uchTwmd9jr6rBxQ+KVM+404tA3BU50VYP7liJgKWjq7xQCRZwA2N13hr3GX+J+/7wLRw+1OHr47aDz1jZXPId4DVrBeeKM2B84nNei8wa9eSTAN7Zgdt4cveEWXBcIxsTwMjaH8qj9NLvYXPlVR+/DA5DBIg0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=ITdU7mM09LgMqhx4nO0Ay85t4AkZmoADNHuL5W6z//MvNBwxOdSeYb6olkmEhE0k652Tl80bpKJdh0LXoWuaW0iAVlviot646HxWfkWGJaGVrL/eMKzVcvVJBRrFaPzBY8GJCPi585JV/g4yLpgU1qJO+I4IcLZXSPWHkKtvS4rpLCNhhOfvA9hnzaGTFQ8IgFgKFRCzQRuIcXbktr3bHVougtyLgS2ICb4a5ID8/ORLSRRIF3N/49XCigJoJf70pCuQIE+gSAzLCPXpgd8Z16Q2quQcs4TmQrEQh0ieWwJzkqO9mpXuNHAmK6Zy3VGVDdhg7PsFnEDnFVOOFp8C4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+s8BkOyNSHuRie2fC01Wy19tDVhaca9HVahGR1s/5k=;
 b=nGRWTQPYBG+YC3YBp3bngVo+Wo++kQ9C5d2QW26ZRqVK6eqROG/YYtPr0FKTE1AMUOBC0XMtkGMiN4VpQD0j6+ioIzHHMqCXzrYvIVsqp6Rdz77k+8p2urpAHO6hu5pPbyXt/1Gcj1GQsmM15mdkcg4H9GKT9AYtAFkkKGIj/DaWLmMAx78x/EqW9HE2u1gJ/hWCbSguHMUhN8yRAoEiBOV595gFNWq9qv0B31CpKEmreHEwUrIRE99jUKigvgsJPCNe22yMBJwkuAORraow+2cuIo73fdfr2lihoKSXY6Z7gVZPfribdfoDRnGEkdwbnNHBs1aVoelJWB97f0OGTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:13 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:13 +0000
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
Subject: [PATCH v7 net-next 2/9] ptp: netc: remove unnecessary pcie_flr() call in probe
Date: Wed, 11 Nov 2026 14:27:46 +0800
Message-Id: <20261111062753.1397582-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e7455019-fd19-42b6-dccb-08df3fbc4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|11063799006|261026140227099003|261021123027099003|261022105027099003|261028144727099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V5XEkgX+nQMIAxqqlOjz4klgnTvouI7yPmKkX+z0YqHGFiY8T2cBOsxC0XTwUjLedW5p8Pe6yZlGtXvdXZqrv+75f4xfYYHCJlHA88xxjxr3joU+lZHmuJcaBa8e5WPnB6EbCsG0AAXE6KpYay5BLzpmYoNdz4KK521b666AlOox5aaSvJ6i4OIXam7RgXs+uNsYxCSm1GHNcKH+seqdgymR4W3vTCAOIB0EM7SsUCmsT+ld9fzC6R4PP4XAgkYvBBAD5KKfKGz4uhP5HaUmJ5CG9DEo7yTCLGgjXzGxicsw6nwuFi7RTe8tfSrHDEOApZwNxtlIJjJROxF+8n0MvZAV0emxnGGJ+mMs2CXpZWKRJuikq49Ld7mS3l8yPXt3cAmJ5O2bUHfk+bFVFr9nJLoIMKWj/7fjA9ebhZuLQpplnf2mtTMg9MLqOBOOLZ0cuaL9b5AoBFy3tvFRNvmEsl0ZrZVJ8hJhu6YP86gQYsiJDwbvPkkDacSkKQ9SmQ/nxxUjHL8ZscsSY/x7uowgk6wF3nWkHKNIo148QKf4zyZbxN2ZhAGi6GtKEYl0aJbrqNRH7SXsFjsF3RM5aePlnSqDZ0ThtsZ+kGM4gvfQxzwXsdINnLEfw52xqLFPaZQ4HFNBUCzXyGMXW7twnNJHs/PbJ2WsEmQ06g4VZwcYPfzEzuYYaKpMaqQjaROmTMKshW4Tc6509Rd25uRLriBvuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(11063799006)(261026140227099003)(261021123027099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yv5bprZygjOYUhRW+7oCFkJ5AxtJUHiSZCVMjZTS2hbQV5GDzQQCghA1UCbS?=
 =?us-ascii?Q?Diz1kgVRYt/w5PtnHzYC2+/LSLQGMeDgVboS+rz3EUZtsgqlYBs2f8xPjIEV?=
 =?us-ascii?Q?T5wkNZ0IIHjhWJonNYOFyERWeBwSBsqzcj7iTs8JVEiFAmjRYswF6F0HfMZt?=
 =?us-ascii?Q?Bb0ckJ15G1POEveKv1BrLp7d1p+NIVShH0cbM17E0NQkWZyfPzaF9rXYJNzB?=
 =?us-ascii?Q?4JLQ8C9Q2Sas0q360MUp/jlTbu/1MSIfGWcZWLeb/MuaZ0Z2qxzkigaXsMBq?=
 =?us-ascii?Q?4D6Lj45zRvvvNlI2n1Tt+hvqdH5hZv8vHMU4CGmWQcVoSbzlCUtkHNtlgWBg?=
 =?us-ascii?Q?c5EXxzdPPPzUqyFK5S+iNIkKD0KEw10o7FqhNCQMtX1NnTff7AzsYhKc06jP?=
 =?us-ascii?Q?345V+/+oTFfLMoDdUAMp3wLGCsDwLDnxSDEH3vrHHDWyQXyTwTruGyT3NKS/?=
 =?us-ascii?Q?tdq2XeWvBI2TkAPyGpOrzVp2Jv6z/kJgImvjzwBPxVt82u+NmaPlKJRZMgcs?=
 =?us-ascii?Q?hGizJ5hPb0O+dO1tjfnzrTAyO+NEfM7waJUp1xk1ivjj+Pni4xsHSxA4M6VS?=
 =?us-ascii?Q?LymmHj9RklpjiNuGNZJ92uG7Fl40vopAy6GCVhtPwi9FP4Hk0s8FMHzQQ5eC?=
 =?us-ascii?Q?0e5GSs5xCzO3k5xMPdqqmVK24kaYsHgYKzZjEiP6fbatydHMGlWzu8QOrgOY?=
 =?us-ascii?Q?mVjlo5nYjxnY1pqWvfaOw0MpdlqHv8ng+dgFnWtNO+unxcor3nXKM7uXxh7F?=
 =?us-ascii?Q?b44SK+TAOGMLT74MQJE/Tjb1niGHJTxzvMq5X++A4xyy9JMwHqSLY4oeqt0N?=
 =?us-ascii?Q?P9JUiwOGBezSHjc1rrRswmpGo/XJWlifJOPlvyGEaZ026D/wwGc+M2Ecc2ib?=
 =?us-ascii?Q?700lJ3lD/CLWLpe3VBh1fL7LID8EWvB+lF3BUvOGFaTsCWU+RgxnetuR8RUa?=
 =?us-ascii?Q?oPbMX7Ir3fKF6GJRO+0H8Mn/3PDAUkCv0Q1kUzuEyAaMfUnI4czC6R4Rcb5e?=
 =?us-ascii?Q?k9a5DOl1SsMFaOCYKT7lgnrzoNXDPhfZOTzh3+nupDIQ27NJCr4rmJq2QpBq?=
 =?us-ascii?Q?FdZGXFcm947j1mGcabwvwsWGt+PTV2H+k0xqI6WHcfMi57v/cx3ZNeD7QjyH?=
 =?us-ascii?Q?DAD62pPHa51QZD1rALgrifBjInJE4SRLbG+1yMS7c4bRKLt3BdnZGg40H20F?=
 =?us-ascii?Q?1H/XBAqmGhBxA5zwstU1/9imaKNjfycW9LoaZDDUHsenx+p1HVXolTfnDUvH?=
 =?us-ascii?Q?80n7IgDP/H8qA//9Hu0OPJBaZ6vTkwIOnWbjZ5MVmNt88AE9EtE1W3o/fJ11?=
 =?us-ascii?Q?grrgfYsGsjhZOcGQCQjI+1R52O0oBxodnfoZ2Ee5F0vgwfRpZeI9MWDU80fh?=
 =?us-ascii?Q?rh+Wsc+Rd+3LGpKpRnG+Nw9mSLOaXmk+m7oJST2e1102q/fopnzTYAZdITkG?=
 =?us-ascii?Q?WvmVE3ZVjh9tQEnhJS+RqocZoxTnGZgfAt9cpPoPV4ezTlhhQjxlE3WockHY?=
 =?us-ascii?Q?i+YrLfz2+Z3Hy1f9AtQMBYehGA2Hv/56Ia58xWLmmCXo8/bZrKnwYtgDTMGq?=
 =?us-ascii?Q?ztU0U2fqqfhsBEEtmZmbsO7hKjY4/mpJHesLKHRDNSMRO4BJaVPaqg8W8yZU?=
 =?us-ascii?Q?uchoAbRictM5GIlFLWn4zHQ43ljmmWUCL+57vA2NfCyvU4+cUF5K2Nn9mErB?=
 =?us-ascii?Q?NU+Mbf7gqBdLXrYu05iG1jyRC7yFirrapWuNnZjTAzEJDqKi2fuS5PT1TzuX?=
 =?us-ascii?Q?FW1kt27vf2hLiThc96QdG0yLXfKChmYgjz8jGJF8i0Ex+vipM/qM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7455019-fd19-42b6-dccb-08df3fbc4391
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:13.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbn1F/OGFfbHEIbBEuPS7k1Q5V6oe4cFjdT/hs7ppvTs0BFu1Zp/M4vA2grmrJ7N331wcD7voqysM9Qnw7tg2vCfZFKWFurHDnkqP9NqWetjChddwaz1a7ugj1YIINui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543

From: Wei Fang <wei.fang@nxp.com>

According to the NETC reference manual, function level reset is not
applicable to the timer as a supporting function. Remove the pcie_flr()
call from netc_timer_pci_probe() as it has no effect.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 376b3b0d1a38..aa9be8e2a630 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -777,7 +777,6 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
-- 
2.34.1

