Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794005017;
	b=yyNeHvJbvw0n/r2Eis9lftQYx97NHQcRiJeQdpNoRi+2W+Ldv/4BXn8FJKsE80hS3y3A
	 0WF5TRMgz2H6Myo5e5jQPCqLag3sKL/RUEh1ZjTX6MRhJTvobzoLUm3oOEfFZwceWZLEz
	 mxwFmfZyaQCcbUwhGlOQjyDqEyt3tee99T65opckeuChlo6uZ9Y+yQKKFN+Siu0lDhd6E
	 zDZIXPSJNcBQwTT8CohnMAcoEMifuaOM1Fd0VSHw8k0vqvmXNJikLrIsJv3ypwrECTr6u
	 Ky2z38q07LA2zXcRm6WNYSeH4IL7kw6aBRO1MFaukx0WkhdFmLkX2Ey64rqYOMVyFDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005017;
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
	bh=/Q/rCF92m508nk5gaTXH9f/CQfix/ip0H59nQeNG4mI=;
	b=lzL8Ao5cXlTfoAP8wENN1AIDKMgneSGLqREICaI63strBzJA8STMWdn9uIFRujfXrLA7
	 ik3WiVWi7tL2hcjuoS4YM+B+kGdMjD56Lt6Q6ZZLIPLe0mOadi+Wt/9MMoZJf85k7Gg/o
	 /jflHe6+2DvpoWLGulqRlVQvJdMTSjOWrNAu0HOqSZp06eljlo7Jp1espdTLge8RINNLw
	 8e3xB+EdtqLbX0FwKftumviPcBqwwf8jVtf+qQ2WSJ10zV+eMVbiVNCkjVJ3vMeuX9WYN
	 tsLadVxo5Y5WLm3e0A5HFCBoJlZEWKRk58ffbzZpI6hX0GRDo8HmPJcgDzcnUHPKb3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QsJgNAOr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.57
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBA606D808;
	Fri,  6 Nov 2026 22:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DBA606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QsJgNAOr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6EOa3y2Ccp6qAjZzjkmAo9l0uZs68th3erWZEAQGBrTrEhO6xIyjE/3tWnHH5WxgxmKLbrf/PS7zPs8rOXV1ypGwY247o4IZTxCNnmXgjqWjepLDFT4qF8SQmfdsijOoNjF1HDmYtUBd535jvwQ0GiW3pHD2Pmz+ONNrH2lQzxK39i08CvGNnkVKwPBMATL6CnZE4ezjEjU3mcfGYX8Z+LTohxyGX0z40KqePk+O2ogO7BRrsLrWNWGQOZYUQaEzKj8kUhXmBXJPZAJPK71XT5ZgOgsMfOSku2VT4B23v67MqIN5vif9JYk9L99U/0UTATfEx0UziJWxmy1r92SvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q/rCF92m508nk5gaTXH9f/CQfix/ip0H59nQeNG4mI=;
 b=dbARXH4BxursUptobOuKCEEQtKlUGxHJ7GTZe22Iz2mqz3EAd+HMHcGZOKIFHUehJvD1T95WpHX3Yc4iQUZQBgnL+1gF45uZL8ZSeDYG83hZjVPVJZzKTgwfw49/wWEeAhe//zdmJrHOxD7NM7GDahweqUwUP21x0NN+hvkJbnbZ63+4frpKOyviRaQk2sdtaBOoEJlwLBQgqaZ10xphfhpTD6YLka8j9YuNWQa8h3YXfIESoJHPHHO13TUoQVjjIJc8WP0pSJh6cfiJ/2CFX74G1mEYxoqu6zVWXiFE85g/vDh4P2DMOk34opJQDwxABi5uyPH6L6QADQTbMUic9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q/rCF92m508nk5gaTXH9f/CQfix/ip0H59nQeNG4mI=;
 b=QsJgNAOri7w38nqS5qfaLwgxsbN/0u2nJiSvXtjjIePNJd50q+IloNP8jgn2TuRSWypka+rRU5qoDMkbECkeA591Duej8PxTQJ9+ASFppJO9YBu+uc+oqyKObDHX75SO2cGAx12KjPzanTKqqUJDqH1u8uj02wSLlC5BbExmHVe1w11qGe0Yqvct5+/1BVzjshbpBJDuDbBhEkEjc6WIb3MjvBBG3iXtTSPkfOOy2BfyYH4yug+WLE95IESJXn/khS2zX54QEC3yj7HNy/j8nQAYZMDSY/s5om5q7toiYiavgTxdiC+kMxWBpmonpD+Rq3dVmMLDJ8QW0Fkxu0WHOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10731.eurprd04.prod.outlook.com (2603:10a6:150:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:43:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 22:43:28 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 06 Nov 2026 17:43:09 -0500
Subject: [PATCH 2/3] net: xilinx: axienet: use
 dmaengine_prep_slave_sg_context()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rio_sg-v1-2-bc54b4bd8c95@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794004992; l=1388;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=C+MA2XVOOi6jw/pW8RZWf3UdSDozl4Xumdy5mk1y5Uk=;
 b=TnQx7LSJRPw1g/g2k9j/rTRtYRCawXQzsNBYiVlwMmGbPyLUNtFbt6yjPCPw8a0jtlVzoj6El
 Mm/S4iXMgwTATJKS8nk0ecj7ro48eQcLz7tDPQA+Acy/Fzf0bLt/x4j
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 00ea5dda-4729-4663-e36e-08df3c57601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|19092799006|1800799024|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261102123227099003|261022105027099003|10067099003|11063799006|261009223027099003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	sGQ1I3ieiGvK1/D3S7jAartmGmypNEOngRzXYg7FYVQVRlLNcKIjnHF/6vUWJbveqbzSUWN3iRRKlk7G7E6LqueXWS0oy/W+fH42V3reb+DU6NFgtiCFCRtnK950Tiymhiitk8jobKB0DlO4JhfKHIUHo9m4DJd3j33cm0qKUEgWGuQlIPeLARPbM+QknQBwoZ1hToSZZPl6Hn61O3D1BCrGhgNG2q+EdNcE9ejOEVl79+6NgfZGQkxzX1AIao40P83QSh3UKihwK2LFs/2dR+XW2yYzfH/XBeiVdqvD6X2gLG4JdYTQ7sioyyCLIXyGiUAqJRbcGHTk6Y6Yb292amxKBgxH1AyLlsaH1p4HrXO3fNCWDOe62OU/o6xiyHWWLQuBOOR8Op14puuDkibqU+3bsvELXowx0qhOuuPtZriUBRY+tzzqfZuFvE9tM0Hn0PPQNpie2hKZeBah9oJ0rVisCiuHdTSC0YnvW7KfklEL7VUMyB0uIAeKi1SPlEZpVV7cJ25TKhsLCZqYfmTdu4bFD7QUdEF7hdRrHw2Ynj6TMlWjTAgHbtXDJKUuBhiTvpz4tpf60uSYhIASq2BykzcUz7XFHyvXR/DjUpEf2rmbjFWCEwKQ2rh33SlnZPrBgf6X0MtCW2IBJzUnLfwXiL3/1G+/eLXOaiL//591HKeKR83fwkvnjoqqrO9ZoYaWuom/Zl1dJ3PWWmm+mPaTsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(19092799006)(1800799024)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102123227099003)(261022105027099003)(10067099003)(11063799006)(261009223027099003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjBtQkdWMlV1Ymt2ZGtpOXF4WVU2TE0raml3UCs3ZTErNFdwMHo0UDAvZzRz?=
 =?utf-8?B?VDB2dnYvNEo1MmFtUjhiQzZmUXRSWjVXTTFWQWNLU3pDMjIwZzZaK0dKM0lK?=
 =?utf-8?B?RWk5QmZwVFdBa2VVc082aHdvUkJkMjc5cjBnZ3FsTGlQVDJCMnNTekZlamFH?=
 =?utf-8?B?ekswVENpYUxWR3drTDhzNm53MWpSR3dqWFZlaDJFeVBSU0JhZ0lZU2thd0pQ?=
 =?utf-8?B?SktkMDBWbktEYXBCUlBPcXR5elk2WUtQOU5WTzgxY3BUTCtxM3I1L3ZRSDk0?=
 =?utf-8?B?WlZNVmJzTjV0MHhUODh2Y012aEV2K3paWllVVjFTaU96R0plM2ZwemR0czlX?=
 =?utf-8?B?ZldTL043Y1BkdGlWZ3hkN3p3TitUMU5VSzhxYWU5R2JBQmZ3b0ZLdDVmZ2ZT?=
 =?utf-8?B?M1J1Wjl4a1ZJUDU4T0NvNzdnQktxTjBHSTNvWXhXWnk1RTQ3eFMvMTBqZHA1?=
 =?utf-8?B?OUNMYWp4TkJXREQxY0lhNUMwUk5YSE1tMldaK3R6Q2pnUWJ2M21HSkk4cG1i?=
 =?utf-8?B?RTl1MDZwVWFZNXd4cWVJWFp1bHJRN0F2R2VzT2h4UjlCcTVPVVYvUU1EeWlr?=
 =?utf-8?B?TlhiLzZYMHdIMmtTNGFmYU5EREtqY1pLbGl4aUp3TlVmdlhwN05OY2RsM1Qy?=
 =?utf-8?B?VENVaGNUZCsvVktmczRTSHF1Mk9jMU9LWXYxano0by9udEQ2QmJIejNFMVZM?=
 =?utf-8?B?eHlocC9wWGZXd1lhN0hKZlRQbUY1QTdwSVExZHd5ZnM0TzdHUmpkTTRkd1A3?=
 =?utf-8?B?cHN4WWIyVlRQOCtTRHpPbUZhQkJhY3M4cTE3MVJIdFpOL2psbkN0eTU1RjZT?=
 =?utf-8?B?UVBjWWxVRmcxTDAxaGpubklqVndmcVNLZnV6dWZQSHE3bzZOZlR5VVFoRk1y?=
 =?utf-8?B?UjE5am8yVUo4cWZ0N2lGU0hzUjJMNlNWbHc0MjhMZUNIaFlyL3J6OVpHcWFs?=
 =?utf-8?B?M1FvWVJKdVBXV3ZvbmlaNXZMTG1YVFIwa0s4SDNZTytMampZaGVVR2NVWWQv?=
 =?utf-8?B?QmZnQnoyTFkwZTNwR1htYTF5TjJidlFpbnYzakVlRVhoRnpua1MwV3VwQnFG?=
 =?utf-8?B?aG5nN3hGUmpCT1pJdVZORnBWTE11T1hVcW9haXZ1SE9iVTRjYW9PU2h1bVZi?=
 =?utf-8?B?UFJQcWZxSXNjNVFqeVg4Lzgyb1BBczNEVFVQb0hkVkxSbG5KU3RqLzNNNit1?=
 =?utf-8?B?bGtoSnl5bC9TRjFmR2NPazF4RmRtdU5qdlY0cmptZGpIYnlDRDNrZHhaOWJa?=
 =?utf-8?B?NHQxbVZKOCt3Szk4V3FQc0IxZTJCTFk0T09FMk1PZUhrcHYxMStLQjVqN25T?=
 =?utf-8?B?Mkl5YjFCQTVWcDNYUmpTbnluR1pab3Q3WUYvOWlROHNmNmRBdG5tRnpqV2ZO?=
 =?utf-8?B?S09xNUJKeWFPVXBUUlU4eTU1ZVFyNCtKbU5YUWpmM3FNams5M2NqS0ZwNHJJ?=
 =?utf-8?B?WlNhbmdjd3lPU1ZYRGp1K0ZUZm9CTDJxUnRZQU1VU2NoaFBZRUFBNU51VVlU?=
 =?utf-8?B?VkdzaDVGMVBjdStXNDUzVE9kd0p6a09tMldaWHpIRmJPRFB2VkJHSTRzamxP?=
 =?utf-8?B?SlNZdVBtUm16SGh4djBwKzNxSXhPT2F2Q044TE1FTFdpRkxlOHN5dStFQzBr?=
 =?utf-8?B?cENibjdzbTVkcHdIa0FwVDJjM3VlWlA2ekhBdDdabHkzQWRJV1AzcDNIUGpG?=
 =?utf-8?B?WDFSTkUvblRkamF1YjZVZmc0K3FOazlmbmdvYnEzRWc0K2VNY1JoeXdDdzBG?=
 =?utf-8?B?THpzRFBvWWFCenE5dU5jVnlTc3dLbTdtY3FQUXMzVjlXQlFSdyt6NjFjYnpU?=
 =?utf-8?B?QlFaZkxnYWsyNjJyWnNjUnZoU1JNTzZnSk4rOElmUG1HS2FZT3NTOXJ1YzVy?=
 =?utf-8?B?T1RjZkRuanZsZGlDbk53WVEwUHlNd3BYVzgvQzlyaHY0UmcrcmdZcUs0RUlm?=
 =?utf-8?B?aTZWRjNRVEF1WFcvZWNId2FGUlR1ZkoxenVlSXJIeVRWckRqbkd6dEpJeEtD?=
 =?utf-8?B?aWxzcHNVaUxHa1F3M2JmR1lkZS9ua1RVMFY1YXVBOCtVRllQRUdDYnJrVG40?=
 =?utf-8?B?TUhkNjBuOTl3SEwwUVllbkpQbGI5Q2hIRDFtWFZJM3U4UzRQSndxeWk1VmQ5?=
 =?utf-8?B?NEVBNS9ZYXNna2c2RDB0VjNNM2F6VFJHNTk5THdDVHh5OUVWaXRuRTRZUmtS?=
 =?utf-8?B?MXVuNVF3YlhOL3d4UVU0c05DLzhha3FOaXlaaWwrbzU4QTFQdFBaR2xTVk9u?=
 =?utf-8?B?c2UwNWZXT2xUYncyVEZlOWwrV3Jtb0E2WDJhWWlyeUJYNWNLYzBHeVBXUlJF?=
 =?utf-8?B?TGp1cnBZdC9mVGt5L3FOclhTNlIzVDlSMjhhVFNxZTE2L3BUaWltLzB1dzJz?=
 =?utf-8?Q?rlcmu236+XHt1h+bFs2koOt+0DVSGX685KFrF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ea5dda-4729-4663-e36e-08df3c57601d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:43:28.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8deAKtb8dCgvzBrTUYXGMOMOFfIcb1/hoTcp2PX6ZCK71kPfDiasmzSNvniQJWanWel7dl9iH9Rf+v4oIpBjFfKpVoWi/5jOSBo0uohSgr0cXeKzM89FyrgL7L6t56y0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10731

From: Frank Li <Frank.Li@nxp.com>

Replace the direct call to dma_dev->device_prep_slave_sg() with the
dmaengine_prep_slave_sg_context() helper, which handles NULL checks and
passes the context pointer cleanly.

No functional change. Prepare to make struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Suggest go through DMA engine tree. this is only one of 3 user, which
use context at prep sg.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 7e83c4b5f1931..55d1b39caf7ed 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1006,9 +1006,10 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 		app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
 	}
 
-	dma_tx_desc = dma_dev->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,
-			sg_len, DMA_MEM_TO_DEV,
-			DMA_PREP_INTERRUPT, (void *)app_metadata);
+	dma_tx_desc = dmaengine_prep_slave_sg_context(lp->tx_chan, skbuf_dma->sgl,
+						      sg_len, DMA_MEM_TO_DEV,
+						      DMA_PREP_INTERRUPT,
+						      (void *)app_metadata);
 	if (!dma_tx_desc)
 		goto xmit_error_unmap_sg;
 

-- 
2.43.0

