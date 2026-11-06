Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794005005;
	b=pHZKfm0vY2BQzyie5Eaeo5LKAfBdFwEfHbJkWOwY4B1KFdwg4zf5wD1p02b9+oeFp/m1
	 SkjaSwRsX8PFxnp5Si1KFy2Gmnt4TQPSTjf7WxQ+tUevrPeiMKfLykoTazd2+dm0QKA2r
	 lPQp8AERGxprvIVImZuWv7y2kUz0Ysi07Ip1Fh0PvQuZlg7dIBU6D5CyK37mY52LsmO0v
	 QcJIBCbCqa6uat1XgUjrmGoq/IunYPrLc7+k7ekM58GLG5wqbpJBMPnkxpXPHCoXSADkb
	 2+EYL65bGVTCo0fVMwYYF0k3yRU6Fmun/EPjTcLA5ySg5oJbwOslnJMGZETc69vo0tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005005;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=VeMN307duDp2vV1NRhe9BDnoqx5Ue9qh3L7Mmt/FLMY=;
	b=MgwR1k0Xm3/iR5wGOsxfdQClmwfAXBlWi931ncSNlzeGDkqagHFmEDyUsdrqPZX0Y4JI
	 vnHIkMn6D5vPmmbHrRKFNu3Fdta9agVBQK7Y7LtAXJBfKa/c3RUX5nEc1/6msPSH5P1mg
	 +1FDv1k0G+nV7AAZipmUU/kajLAXAGguD+4McVGqwWYKLrtjW7wLJJvXifneMxbr9LGhK
	 cFSeJqU4kvcbVCOo21zQGc1eZMS/gVqyqEllbcPa43o1JQNZ6x980BC+zjkDzGHtp80pu
	 8nRLcxxqHmH7dRwfDRgLQcpCwlZoW6/YyIDrvXiA3CsZOxlkhBRaVcBB1d2tPGnwoHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ghsu1kCz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFC606A334;
	Fri,  6 Nov 2026 22:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AFC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ghsu1kCz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myBJBWbFL/EGDDhZ0fPIqdmi+gHwpgWXY9iAT/7OOnMi2abHFohycIYn37OyhyQb2S0+ETpWGy9+0329pjYQNLp612WZ6DqDnW41wFoKIfHWY6pe1RpLfQfWTmw8DjU5MTAvcPnVg58QLKDW1kZBTnSR5tkt33tDeiIWfMPxEsFktidI120X7pbZPwBcq3KeWPvlzki88kqab+h1JzIz8TlCa66S2gnZYNfQr9nlbbEaq8uga7OUievWs+eik62sDxQV1oui9lJWfX6sFF4uF8FV3XMCwN3zhlBGUmLx7EtTwzsdYHIongSJErqdLREQ0rcwePcjWqNOEDPzTAl2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeMN307duDp2vV1NRhe9BDnoqx5Ue9qh3L7Mmt/FLMY=;
 b=HUsFkPAXjoLPqGbGqrQhgdV3PFFapWko4IkaB2d/rOXAQeJBKxchRwM0M62iSGNXaRsmHLCv8Q3eQb2xENEKFr4CvnJPqYUN2SQnbceqhP+e8K5cP7XOl7ABAlplFKoWel4L9FYom6P1EhnCaWwhb2IvD/9aCwlAo9vmyP/HxKx9giKC8L34J35c0z3d2PMKwdVqR52pZTkPzZSWuoE1spoHfFthSFZRfhYtKPULQxtuH6uHR8z1FoOL+DoiOYIx/S+FhABfsGBmgViBr4/jFhheoJ3+qCi5PKfuWMonJzFWDH/aYI1QTR0cJEHeou5m6vWLkfQSPALu2QRL3mjCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeMN307duDp2vV1NRhe9BDnoqx5Ue9qh3L7Mmt/FLMY=;
 b=ghsu1kCzfSygsd6SNTwbcAaGscgHW/3rDMUGtF3O/3X8X5SbYHc8X21Vf2+a/h5pX+6Djj5U9B8E2gATePkra3OPudgEiuGtqIIHM+m1lHho5eD7biA6QWOE7YNvbZ7gBarJu4YEqP2oNJsEN5TmSyPSngn8aGaX5efib2qqxFEsTaR3TrUadZMwYKzRo+ND5XoyDjF3kHB5XI7WqBVxx/SS3npFNpQcYKr9GYMt008jlvuZsnzDTpCOuJ8yJyAfbIRGWQOjxEBx3fT+Vuzj/2u7UN9tdvgX7Ceve8n9Xik7oc6E/nVBixAdqiQdzgSwoMwzAacPNL3hwth63494+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10731.eurprd04.prod.outlook.com (2603:10a6:150:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:43:22 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 22:43:22 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 06 Nov 2026 17:43:08 -0500
Subject: [PATCH 1/3] dmaengine/rio: rename dmaengine_prep_rio_sg() to
 dmaengine_prep_slave_sg_context()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rio_sg-v1-1-bc54b4bd8c95@nxp.com>
References: <20261106-rio_sg-v1-0-bc54b4bd8c95@nxp.com>
In-Reply-To: <20261106-rio_sg-v1-0-bc54b4bd8c95@nxp.com>
To: Matt Porter <mporter@kernel.crashing.org>, 
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Simek <michal.simek@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794004992; l=2953;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lvKo3ibKIlMhJF89pbcJGVkuc5q91Vd1g4LmA/zMBZg=;
 b=AI3WcHuG1C1Gq4a678fSemN9pX29lzeFAKEcPWxEdC9k+HZN8TKQtIxhqjk2T4v1kqWzy74Vm
 Uy++zU/GYuABGxAVtwGZQkoOOhbww4TaelqPwItgGSK1ORXleBg39kj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10731:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2a57c0-b452-4e6d-28c9-08df3c575ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261028144727099003|261102123227099003|261102130727099003|261022105027099003|10067099003|11063799006|261009223027099003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	62sHGM2Gj2ALS3ZElxJkUZkPqyuOPlvp3bKprmdo2Hxb1/tDPqbVmjGqdJPscrsCR+HwqgVn+zrrxtNqYqif5K4BZsjBdSInHADmpjO2MN3EEp3rnYtVU3tzHYTaJ0aD6T8WzBNaGvyb9ZUgaqIuryU09APvrFVtPApcw/tsea9A5kC+y6hlgmlxEGRFs8WmKC6nmUNFJErMy319JmC27jrv4f81WMzcRwNTCTI3kol3K2lCpsHnIi+V+Z8Mf5uWaa/v4n+Ao30nGCwPIk9AT99ODu94V8eLGDSYtYlr2t3vu5w50O3ES8gzHy6LJUUx2ezKsyu0JtrDNMe0zkyeT1/J2fbex+nJ5CLcptzQH/o8V6D5g4Cjs5NiVvTIBXuJ8VwrRBFIBxNGtrnnL6lri4D7Wh9jaDrL7hDX+dQcMff8WIzsEJSckkFlF16QUqsZOFCeyXK7sE86vt8OzoKCWk7SMGV//hVHq1fiMEAKfgenzCSdUNoO+DvbovJv7jCB9dPslfuMFaSMnGFaYNuTfiQ1zNT1HWhCN5on4A0r9131O3WNK+P5dS+u7WlEiDTixMMeixyeYcyQ5boyiMO+Ltcpc4aC+HSwI/td5ERx2u+0ZO0dfpPm+b6Ti8Ig/DhxLw/crpB/fLnGquyh8YjQ4/vI80prHxsmgPLR7uenPwgMFaB4FcInxs341m6h92SI5PdSfx4hUjfsUU/jeandAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102123227099003)(261102130727099003)(261022105027099003)(10067099003)(11063799006)(261009223027099003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUg2Q2w2NG0yWVVTSmxpRGtkaXFmWUo4Zm1MSUpTc1hXZ2VJNEF4eFZiL2Rz?=
 =?utf-8?B?SXcwd2g5eENVTzNmZmtPQkhRck5SZS96RmNBZjFvUlVPc0tLbnFnUktMank5?=
 =?utf-8?B?ZmVMYStDR0N6Rk1adkczSEFYUUk1UkVLbWZhR3lncE1GQjNSeXlidjZFOFA3?=
 =?utf-8?B?M2dOV29oOWhrWUtFc0ZDSmRhM0Z3cElDRmkvZyt2SFFUZVQvQktubmE3OURR?=
 =?utf-8?B?QjhOSlRwMGplMnNRUGorYUJ4ejNYRFJobzRBczE5RnFtOFdWeWVBZkdyV2NR?=
 =?utf-8?B?OVg3VlIvc0I0bndkY0ZTSnZLMFZ4dXZmYUNSUUdXUVQrR3RiN3VEV3RjNW0v?=
 =?utf-8?B?cmNXdXhKQXBmbitiZEs4QzB4TTVscVpSM1JxQ1hQbVkyMFVJUEg4dGtUV09I?=
 =?utf-8?B?dmQ1aXlpTWhOQUVtZ1ZqODgxc3VrbnEwUW1NOGltak41bmV4VmNoZXd4MUZj?=
 =?utf-8?B?T2gvL051d1hDa3p4eWFKNDJEL2l5T3hDMm5VRXFFc2xEbVU1QitKMnkzVVNp?=
 =?utf-8?B?RVJDVnpqaHN0MEhCYVJRZDM2WTVyK3htbFBCOG43N2IzcWFuMndaNDhmZG5l?=
 =?utf-8?B?b2h4YTZXMUQxY0pVc0g5SnZuVkFvNlJqVC9ud0xJWHJiKzMxbDdqaXZGTSsz?=
 =?utf-8?B?WS9qc1lSVlJVTEZNb1BrdVdkQkpObFdOUklzMHJwUU9POTI2MGNxcENCMmdU?=
 =?utf-8?B?TmN5dGhYUVpyWFZYSjdSWi8rd2xlbC9JZjdmemJvMEVvZzl0eTBKUXpVMUdY?=
 =?utf-8?B?M2lSV1B2NXFpQk9Rak1Nc2N3SnFLL3JnQmhXSkhEcytINmZTcEJDSGpLWXNL?=
 =?utf-8?B?QmROb1FmTFdWdXZtWXZCU25mUzRxUXFyaktkN3FUbXhhN0tzYkU1KzNVRGZX?=
 =?utf-8?B?NHEzQ0IwTWJzOW93akNUQllKNTRMcU9OMFo1UlpzdTcxNkw1aXR6VVVlUS9Y?=
 =?utf-8?B?ZTd2THc0bHlxcmoxZGpKSTdJNU5kT2c5NTljbTR6aDEwYktrTTdadW5PSlE1?=
 =?utf-8?B?THQ3RlRPdUxHSFlYOTNTLzEyNGF0aVprTkRMbTc0QWxGeUUvRW4rdG82cUll?=
 =?utf-8?B?Zm15QnhsclRRamtML3NkeStzZDV0OU5zWmhoL2k5MmNtQ0t6QTJWaEVnQ0RU?=
 =?utf-8?B?YnNTNUZrMWRIMGFpM29jU3o2UFczcEpDVzB6VXNaWDVteEJCZ0xGZlNUWm1W?=
 =?utf-8?B?akd2Z2xKWlkvNWRRaW9zTk4yR3lYT0Q3MFlZcTJYcnhVS2prSis4bzBrMm10?=
 =?utf-8?B?b1ZxSk95SkM2Q09YQ0FCbzd0TmRmcXlraEpIajBVNlc5S1ZESkRGYkxkVXFt?=
 =?utf-8?B?Q3pEOHhCSEwrM1JUbWszd1RnbGdLUkl4TEhTUDJCRTZEbEJvUzZHcGRtV2hU?=
 =?utf-8?B?bUZ5UHJLRHdGdnM3OGRxb1Q1S2JRTlFyK1VzVXRId3RyNUJ3T2duSm1yV2Iy?=
 =?utf-8?B?UGJxbTNBL0pKWFlsMjBqVkFmRzUzbzlkNTc1TU9aVjZpRzhWaDZ4bjc0K28r?=
 =?utf-8?B?ekY1RWxzczVuSXVuT2g1T3FHTWFuNkwrTnFkSmcxNFl2eXZPWlJkUHJ4YlB2?=
 =?utf-8?B?T1o2TCtVY3dKWjVCTEZWNFJLTm5hVkplekU2MnkrRSsyRmRaSStRUHhZQlk4?=
 =?utf-8?B?VW9neGp5LzJobktNRk5kK3Q1VUJpaEs5S08zSnZtYU1yRDFZcVF2d2FaQXA2?=
 =?utf-8?B?OGJRb3cwbGJGN0s0eEMweHFWU1JDT3VzUlZsaU9kVTRmTnZBYzJWZnNzTENS?=
 =?utf-8?B?MHdsYyt6K3RIcmNwUWpMMUNtUmcyQzJTVGxST0dsRXliYXZPdnZDSVVXWWRT?=
 =?utf-8?B?cDE4U1RLVGhFVTRHaGFMaUw2dWJURFNYN1MwWGdFZzJzL052K2Y4dm40OWJ0?=
 =?utf-8?B?M21vWXlWbHJJRU5PbDI1Q0lwNDFMYjJlN2JBa1g4eWx1RDdzaTJnWmJWL1R2?=
 =?utf-8?B?TkpTT1R5ZWhrcXlkUjVsdFhMdk9SbFNqVWZYR3Q3TDJwTE42Y0VzQkpmbUZB?=
 =?utf-8?B?TVBkd3duZkZ0eFF1QTFPS2V6aWlVaXBURmV6K1ovVGhnejJvd3ZmWHRDY3hk?=
 =?utf-8?B?dXpLZ2JpSm55QmVOcWtFTE80T0V6bDg5bEw1eTdxNGErcUlmS1lLdFIzVDhz?=
 =?utf-8?B?K2IrRHpqeFFQN2xiNUgzL3k2UURnN3pTVjZ0UGR2REQzYkJoaDVYQndIUlFt?=
 =?utf-8?B?VzI1TXN6aTNwWGhJUEc5VVpSS2JTT3lhdjRzMERxazlaZ2xVdnZNa0ZLRWpR?=
 =?utf-8?B?UWQ1blN5K1JYbHRSQ0hhVk0xZ2VRb25vRTM5dTRkMjlkdXJTL2pra1VTN3Zv?=
 =?utf-8?B?a2k0R1M4bzgxMUpRcWpUcmQ0V0ZNSU5wS210REdHZzN2M1Z0ejBiZXhPRzk3?=
 =?utf-8?Q?DJ4CuKjxKGrgM6WKidKPen/u8JspM7bGpzcv5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2a57c0-b452-4e6d-28c9-08df3c575ce9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:43:22.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDBa6ogjslwvctT6HsKcBiHXc5HVHs8U3YyG0xj5LtiTJWqqQ/w9VY5ZDXVIdyp3yXONGKdp7lhCGrGgy0RJ1gpVDRbY1jvE1wgz8KcgHxRM6WA0hwr+BH956sUmaPMC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10731

From: Frank Li <Frank.Li@nxp.com>

Generalize dmaengine_prep_rio_sg() by renaming it to
dmaengine_prep_slave_sg_context() and changing the context parameter type
from 'struct rio_dma_ext *' to 'void *', making it suitable for
any DMA engine user that needs to pass context to device_prep_slave_sg().

Remove the CONFIG_RAPIDIO_DMA_ENGINE guard so the helper is
unconditionally available.

Update drivers/rapidio/rio.c to use the new API.

No functional change. Prepare to make struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Need go through DMA engineer tree to avoid build break.
---
 drivers/rapidio/rio.c     | 15 ++++++++-------
 include/linux/dmaengine.h |  9 +++------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index f45e58b0971f5..9bba811f75da7 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -1804,20 +1804,21 @@ struct dma_async_tx_descriptor *rio_dma_prep_xfer(struct dma_chan *dchan,
 	u16 destid, struct rio_dma_data *data,
 	enum dma_transfer_direction direction, unsigned long flags)
 {
+	struct dma_async_tx_descriptor *tx;
 	struct rio_dma_ext rio_ext;
 
-	if (!dchan->device->device_prep_slave_sg) {
-		pr_err("%s: prep_rio_sg == NULL\n", __func__);
-		return NULL;
-	}
-
 	rio_ext.destid = destid;
 	rio_ext.rio_addr_u = data->rio_addr_u;
 	rio_ext.rio_addr = data->rio_addr;
 	rio_ext.wr_type = data->wr_type;
 
-	return dmaengine_prep_rio_sg(dchan, data->sg, data->sg_len,
-				     direction, flags, &rio_ext);
+	tx = dmaengine_prep_slave_sg_context(dchan, data->sg, data->sg_len,
+					     direction, flags, &rio_ext);
+
+	if (!tx)
+		pr_err("%s: prep_rio_sg == NULL\n", __func__);
+
+	return tx;
 }
 EXPORT_SYMBOL_GPL(rio_dma_prep_xfer);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9452bb2c04af7..d0906bcdabd6c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1070,20 +1070,17 @@ dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
 	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);
 }
 
-#ifdef CONFIG_RAPIDIO_DMA_ENGINE
-struct rio_dma_ext;
-static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(
+static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg_context(
 	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
 	enum dma_transfer_direction dir, unsigned long flags,
-	struct rio_dma_ext *rio_ext)
+	void *context)
 {
 	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
-						  dir, flags, rio_ext);
+						  dir, flags, context);
 }
-#endif
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,

-- 
2.43.0

