Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793801323;
	b=kqSlidMm8a7Hl2HygEoSAC6GtHlBXAUYQqbTWkOyIojKOVsM0Q3COZaLQlgoOEwkV3St
	 k8jYgsP9XY5iSvIr/WZOk/cJhAdDAhup7PzomrdtoiSCB6iHBsSBKg8HFgD+AF9rp8IxD
	 3snGOgEHK9+HzU8Re0tZMugI9Sq5BNNqf13GcPyVBK+kvnrn2DQiZGaq0bUJ6cvsCWr05
	 /O3hzYEmsSRF9eQUOcEU9jpixfc5yqJhELXWxzshcdMBi7JWpEWOHYlGKh6auCnM26PTN
	 6qNmrW0K6fBkDJhVFE4SlLvtHnGbAfR/a3MhtOJWHQbdWmDKOeUT1ZIHHQIfrqmdNgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801323;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/eDpV+zL0Ody7ZmT+uQGP2/jwgYm+10lfXhu+RvUdtY=;
	b=eQFCffSYZBrhJjtj/jeP7zcSijldab5U9obrY5UiHGpWzGRhKYngLKV2VfgZFTkyUgjj
	 OrY3X3tsf3yeC56+DNqI8lwS5RSS5kIJaP11/RXpk8gw95/P1V/i8+ScpljGsMmG0vS4A
	 KkIehTgJC6lE9vncWnDTt0sJ9rclLd5DqNxBjjZExg4K+x/2kXVvm9LPswWokuZPJIoW8
	 Tp93xC7vuGbCUGHOqtOyOPEg5rXKJoCUtvw2XkM3QWQTTbPJD9BbR8rTZLGJrKdBqmXcc
	 Q+Ybq4oHKp1EMeJzPvgjFqZxuckNKKUF2gUtEdyh4kmBAM4Jd2YDVEuXp8sDURC5NXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YNbuta2N;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pMXGQ6cB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8B606A33D;
	Wed,  4 Nov 2026 14:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A8B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YNbuta2N;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pMXGQ6cB
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bath51442572;
	Wed, 4 Nov 2026 09:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=/eDpV+zL0Ody7ZmT+uQGP2/jwgYm+10lfXhu+RvUdtY=; b=YNbuta2
	NMxoHw5ltrjNlJ+JqvGVrtZQTo/XOOvC5CqEAx2X2gg7K3wUtwaTt8RjIPkmxWqd
	lULpzLhJ2LJn0XmYOa8oriL3cRinQuIs7AFdLbhVrJZVgvavKub2Jsy6sT3kILwy
	vxqog5+9Kt/RBUXBTptdVYxknXugYCCfYaVUzevVmoJ9IvTyanfB5MMj0C445ltl
	zJnzzqWb7NL3hps6VE2b2+sRMH7PCf25yEBpS5jLqXfaxA9kB4tuFpsTgUBiEanJ
	wZvaDaBDt4WnKYJ0DiMEnICq3Jx8uMOGzqcNkyHCLHcj9hrlDe6vo9jb1gViUDGR
	SWWrL//sBBO5OKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/eDpV
	+zL0Ody7ZmT+uQGP2/jwgYm+10lfXhu+RvUdtY=; b=pMXGQ6cBl2O8/mtseWlla
	vFFTPf6XrTyQuhbswM3QAbaHYKZzzGl3aUpIXbGzZW88UfN0qgW1So6iIgEZbxdX
	jVGsh1I/53GeUweaQkVIBmwjdhao9E2WFMyBoDF6tqEGjDwEWOqZsnNNJklpJmYx
	y3QCEJAWmChh7A/R0hJ/HxwDT6A3FjtPNRZDiyHR5jzeObAddD8z4poOzN/muXDP
	vPE1iHDd1HBSSEqNYrpI4BOCP6FrPgrkBiWDBovHxtb3PX1kipl1Il5ROX/neSUq
	mIA1mB5q5ExVf7NbeVLJcZE0/8q5MzWFmVzVnTJ79n7cWIEL4reyKkm8+oyyQRII
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hr3umgvnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:08:30 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syA/1uFuXs417cnTcHGzLq4zE6SyI5zq/65ua2FViuIx6G2nQKSIB85dxtV4HY46uRJ4GtEjxS/aoj29YzqZgJUwYi2Oy/6HsHbFmJJX6vLB4QALdNlQO8NGeFa32vevrYUdaGBY+Ln/M+OsBbK79iS1FTZwdI7Xjk7HuFRQuWU4wDD+igyyE2Uuw8/9cuySzsORxxzPWxEs6skzQff+2WhrNSel4+/wdMiNEePbjzPLWgW+Ow0huxqDAMjY0rgzy0d0LWBap+lXLJIpbv87pWhTpUi1ub09TKtKc7h9L585QYto/Y1fMKUjApO90Xld9s0fBh+PHK0SIwk7kzD0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eDpV+zL0Ody7ZmT+uQGP2/jwgYm+10lfXhu+RvUdtY=;
 b=S82+opYMh9lXTHufd8SnKVUlJoO2XGIf3JyVWUF5qjPR0z+V2yoq6UZNO52etKb6JszbeFnq2jclQl5NF4qV3e4CsO8imUCuRngHpmvU4CdkqE3ZzPUbg/xlBA+NfyQT3cY/Y36RAO3RA1kG4yuHy1BO7qd2+4sA1aUtHc6yuzHQiTTo+bJUkw6Sw4l6k+aSLm+cli+3s1pBPUqoenIVoZk1OaV8vKipmv75vHdDcEAHHPx9zlWa1lQ94+1j2Ar5bkCjT0jmRNIgtNqPRsoJJF7rDZYR6y8MUi3xHup+wtzV7eIFQSVOyhadgyv3mfefv8+PiLMC/VWRuwojbMiHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:08:27 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:08:27 +0000
Date: Wed, 4 Nov 2026 15:08:21 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 2/5] net: ethernet: oa_tc6: Add support for MDIO
 indirect access
Message-ID: <aus8GQ-Xut5XBNwU@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-3-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103160918.409701-3-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0014.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::8)
 To DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a28e05-8a01-497c-a0df-08df3a7d1771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|261102130727099003|261021135927099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	ODPSaXazO/KWLqBwnQSr1MajL3caDpPxE6SCp7AwSDkbYJkIqkonYniIbdlM/epvN5xdtfaSs9gLVOC0aXDk7y0+iZLVtwAtB7lm1NYknFpvgzXNM5LOwIbbJkj7ngq3uKNI9WfWH5lqBu5HU3zyGErKl42sOW5oecgMCOfP90VkNMb5ST4e1XIiXn2UIwgBxg4uND8qTcK0NEE5bpDQKpCVLr5Ur0KihssUMME8rFxeGTXBpCT2R2z87XcSnlOJO1JFcCqdf6cWXq9SZBV3vkwjAQUKIuOvjE/gq+dNmoN6dCb7YUmYYagKT5BaBIy1y9B0Fsj0UqfsFbFC9pMKGbMWlposYfoipuOMK5aLg68hrbMYNmwk6aSlau01toQCbZo1zNAXptgQx6yLamx/Dh7k5nE9BkVwSHTiNh7IWLW2M3GxvfpNq0VR6IXNmz/1qnknGN1UL+/PFJNEEf9XWtAxaTxOMWyWUPhb/GaLA5dIyGIsS/Lb/qIhmNW90lrMgUMwERivl3ktrYVHUhmDedVZCUEXsLnvVC/zV9Jc47WJFgPkPZgWMloMzufXf+7q4NillYf6TmChixHA7E9EzWxC+nRArQhDPSxSLAZA/Xijoog9MYZpqo9rpNggBY5/iN2V5uNQhxKC5QURVv0h/7hoYNZxrltodEX8SQZJi40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261102130727099003)(261021135927099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTc5UWFqOUlxaEZ4VlA2MWVKVkZyMjNOVDRUeUJhODNhR0lCZHlGSEh4Zm03?=
 =?utf-8?B?MDNOSjNIb3Y2L2J6NU9KNU5FZVR1VTR1c3IrRkkxb3FSbndVNWNZdysrMW5W?=
 =?utf-8?B?clNRaG1FV21seEJoWGt0UlRXeHBjYzZXTUFaeHRBZGp1RlhiZkowbEUzMlM3?=
 =?utf-8?B?eVh2ek1NRHgvc0piMGRRbEpXMFZCNHEvN0YxK3Rieno2UFVadHZoYkpGMTd5?=
 =?utf-8?B?UzlqT09OZnhwTjdialV2RFFOeDd1RVlSd1BpK3JzTnhQR2crM3JYRFlUZTNn?=
 =?utf-8?B?aTl4cVZObVMxREk2d1Y3K2FIZzh0Q24yT3BhZmloU2ZIU3Rqb2kxQm84TnBn?=
 =?utf-8?B?dDZRNmRiQ2tpYWFhNHBPS1Z5ZDF3Ujk1ZHVIMWhVU2VuOUtQS3pnaUlkMWhs?=
 =?utf-8?B?WDRpMk5kVXdiOU9MOU9PYnloWEZPbHNLZFpHYmg4cTZIekE1R1R0TnU3ZnZP?=
 =?utf-8?B?a0dXc0dXcUdPU0xEYXc2T3piV2NZd0hJSkxoNGlkM1JRdkY5bFgvQ0E0Umlr?=
 =?utf-8?B?UTJJelNRMHJyemYwMHM0am5IVnZQc3l5Wmx4VkhJaWF2WU5iVk1meVQraE9p?=
 =?utf-8?B?NjFHNTU2S09QZ2U3T3I0RldxRFMwMFZsdlRCWWtPSEM2ZXFSVkZaNVFUOEpH?=
 =?utf-8?B?bDNaNVBCVWZhM29GenhTem5zNTBpdkpISmkrb3docmorNzBwUGJzc0R5VHBp?=
 =?utf-8?B?UExtbC9NRmV1elZpdWlrZllHK2drc1RLbHZ5WWlnTlBzcUJuR0NTaEhSakJs?=
 =?utf-8?B?SElCRFJnb0RNVFRLbi9BcnlxVUY5eGxXbTJYd3VSZFF2MVZqaFdlWlg4L1VP?=
 =?utf-8?B?TGVkbHo1TEJzRlQrcEJHY05zUmYzWVBnNmpoRTZRdW5DcTZJNzNIcWNGVzFQ?=
 =?utf-8?B?TElzbmRwZDZtVHJIN1ZoR3B6ejZZTWM2THIxVDhFbjlsU2ZLaVR3TVhKendB?=
 =?utf-8?B?RVFkNVlGMlIvRStrcHdPcWM0ZnVSVlRNRU5oWm4xVFpScjduUzRrTHB6WWhP?=
 =?utf-8?B?dGFJK2ZLSHNiaGdGOWNodUhHcDZ5cTlSb0N4SW40dGE2YUZZZnNiSUtMVG90?=
 =?utf-8?B?WWxCL3J6YnhpRnAvdDdTYVlQak9rayt3a1d6NVg4V0NNZ1gwYzY0VUxZOWJ3?=
 =?utf-8?B?emtJa1RjblF6UFlZdmo2MUJmVGdRVm15eXRyNVVzVkN4cXpVeWF3QkZXbUlP?=
 =?utf-8?B?RVNEUzNiYlcxakt6Y3pNbGJHeG9Rcy9uMFp4Wit0TFErTVdOSkNEdHhYc0xK?=
 =?utf-8?B?clNhall6T09ocTVXdmhHbVlHRDVtbkUybFdGQm80SlFiRnZ2NXVjV3h6aUhE?=
 =?utf-8?B?ZllMZndGRTRBUDRUWUpaKytYT0FSWUY0d2tSQ2lGbWpMSEZnNFgwRGs3QlhX?=
 =?utf-8?B?UWFCK01BNS96b0FPKy92a2VTZ3RJUlk2Q2pSaEZLNFRUV2JCYlpGTks0TXVk?=
 =?utf-8?B?Y3U1VkdiRGttMDluL3dWWnFiaVpMeDNxY3RIQ1BYTGVVaS9abmRpSDJLZVBt?=
 =?utf-8?B?QWdOM01lVUVlNjBOUVVuOGM3b0Rad24yK09aZjZRSHhKTXp3LzN5VEFOZGZ2?=
 =?utf-8?B?UGl0NFdGV3g2akFaa1J3ZlZvZ0pHdzdtSDhVTUhFR1VUaDR5eXhGY2NYQWxJ?=
 =?utf-8?B?ZHNuOVdtNjJvWXlhckdqTk9kQ1pna3FDYkpXRHFFQ3pTcmd5N2d4RFNkVVNz?=
 =?utf-8?B?S1lZVnNKMUlDeHBhV01BZWRGL2N3eVkvdUpJck85dy9zUDAzNFhBcjY2MUVE?=
 =?utf-8?B?ZU1KRUlqdGZtd3JYTmFLcGkzMVg4NHQ4dHRyUDVyZFhJS2s4UTArZ245Uktk?=
 =?utf-8?B?VnVSK3lNYnNJb0IwNlFHWFZ0M3d2b3NabU5SaHdSM3M0ZVpxMkowSnljQ0ty?=
 =?utf-8?B?ZVdwNkpOTXFBbGZvNmZxeXRkbzk1QW40U0cyclRCTTZJbU5xUzlTdTJhSFpx?=
 =?utf-8?B?SkhUcnJGR3FvQ2lZZU9uK1VKWjgyZWRzZURDQzlLak5UbVBpRzU3NGZMSi80?=
 =?utf-8?B?V1E1bDlmRjA4M3p1U1hHdUhTMXo4WG1JUVVsMCtiWURLWkhXaVNlYWVBZUR0?=
 =?utf-8?B?dEpBTVZLcHB6SGJNcFdFOVlDVFlkK04wNVBjY3hxZ0d6Z25BNVJBZlZpWUJY?=
 =?utf-8?B?clc0bWFMRDVCSDJLVE84Y1RlQmRna2VUWm1hUVdNQWVyaDc2dUxpaWxUTkZy?=
 =?utf-8?B?NUhwQ2NEbllKZmVBbzN0MHBnMWNGd2plSEJkc2JrSktjRE5qU0J6Y3pOWEcx?=
 =?utf-8?B?Tm9oSTdNd2pFdmFjaUFxemoreFExR3BCQkpobTMzUExhMTNSaXV0ajJSMWJq?=
 =?utf-8?B?R2hCbzZsR05PYnIrVDdibjFWNkR4RnVGZFkyQ1NUMnhkN1R6Yi9GQT09?=
X-Exchange-RoutingPolicyChecked:
	B2btzzSVm5M5jJK/qzFi9KxXdC1DhXDX/sAoteN1Q2nJ3m/cuwAgaER+vOf1Y6VTdBrvxEljBAG1Bp7IyHuByFidE690V+7YZ2I1Kf2ICpaUrG7sXv0jloBgUmfzq8u2J77K0nhrHVCb9eoTam7olBCRoPIXpcj5xfYIpRPAUlp/9fT4MpkPYLk75RBcT7pHN3AXRBuWoQBsorD+0mt7Qz6+Jpgw1oZLtCJwcLazUzsgUedhnRm3mFT8/M+SDnV6XWfIghicHCpGUE/5oxsVc9M2cAnneuDQaDNwQ0/Toc1bz9HYlP8cO42nGQoo7w+WkWnOYzl3AclbaVCFOuirQg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a28e05-8a01-497c-a0df-08df3a7d1771
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:08:27.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYEp0tDoDnIKxXdSmFzYeiUgiONOwtkAjboBWX4pHq5LuOFCAlUTghk+HQIDeNgmI3WWyoGl6ThvirmamWmD87N3vpWMiJ6SAaUSkUFEmRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Proofpoint-ORIG-GUID: JqpE7flrr8O1P-njFdF8qC_CiVfaIWbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX2jdjq/USa9Dd
 T+FhZ7Jri5ELLlF6dVU36jGHMwMkEZBVkpvgM3nUBXTc11WOQCCMZs7smV6vkT8piO49F2xXuao
 FjqGeBQQTLpZrlK6qvtAQVcgUneO1CvV4yXb5TTgdyiAYRp0HBE+7dDRV2JIFZSfdsF2xctgiti
 Fs+bGKH614PQvE68Xni7fhBKgqQSBC9DupQz7TRinbUsu4svRF2jq09HeyDL1BEq+iNlO/nw9nF
 sH9syndDGKuAQDaCRdYy28eMoCFG4cf6gPJZCN7qeK+ORxf+0W6atFGB1GfPWIfr+oVESfbxXnl
 Gp9puQZvKU6H5U6gb5bW56/s9SHh7m/DEmJib/JDjlOdN6S0aS6Nx78l7wtEwmw2etKgl9uAvqm
 QIH5wFSSEfdSu3LFnNe1ZAxxNl2Kkg2tT6kdXMHn+TpEM1jLjrK/JGb+cWLKNQspjwlszUu9my8
 tAKySfcylkclDLJoi+g==
X-Proofpoint-GUID: JqpE7flrr8O1P-njFdF8qC_CiVfaIWbi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX3RFzjSYKNkVB
 IRwsxXigC4LCEhOdS1H0lH47yt/65tFUu0cR6X0DSpRq6y6Rk2XIBvAnTnrAiytJbCQ+VmY0zyQ
 X/AzbgvJBhBg76O+VZC+uOqo88i0HKGo8CKMmyc04v1yWLECkYup
X-Authority-Analysis: v=2.4 cv=J4E/fwnS c=1 sm=1 tr=0 ts=6aeb3c5e cx=c_pps
 a=XSpaKd7YU/jha2kVJ1iHgQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=MWnb5t1yu08AFxBi0kIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040056

On Tue, Nov 03, 2026 at 06:09:15PM +0200, Iustin Stolniceanu wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The OPEN Alliance TC6 specification defines two ways for the SPI host
> to access the registers of the PHY integrated in a MAC-PHY: direct
> access, where the PHY registers are mapped into the MAC-PHY register
> space, and indirect access, through the MDIOACC registers. A MAC-PHY
> reports support for direct access through the DPRAC bit in the STDCAP
> register.
> 
> The framework currently supports only direct access and fails to
> register the MDIO bus when DPRAC is not set.
> 
> Read STDCAP when registering the MDIO bus and, if direct access is not
> supported, implement the Clause 22 and Clause 45 MDIO operations as
> indirect transactions through MDIOACC: for Clause 45, write the
> address command to MDIOACC0 and the read or write command to
> MDIOACC1; for Clause 22, write the command to MDIOACC1. Then poll
> for TRDONE.
> 
> If TAERR (turnaround error) is set, no PHY answered at that address
> and the DATA field must be ignored. Return 0xffff in that case, as
> for an empty address on an MDIO bus, so that the PHY bus scan skips
> the address instead of failing. Return -EIO for a write.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

Just a small comment below.

> ---
>  drivers/net/ethernet/oa_tc6.c | 171 +++++++++++++++++++++++++++++++---
>  include/linux/oa_tc6.h        |  15 +++
>  2 files changed, 171 insertions(+), 15 deletions(-)
> 
[...]

> @@ -534,8 +674,16 @@ EXPORT_SYMBOL_GPL(oa_tc6_mdiobus_write_c45);
>  
>  static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
>  {
> +	u32 regval;
>  	int ret;
>  
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STDCAP, &regval);
> +	if (ret)
> +		return ret;
> +
> +	tc6->mdio_indirect_mode = !(OA_TC6_STDCAP_DIRECT_PHY_REG_ACCESS &
> +				    regval);

Maybe just if (xxx) tc6->mdio_indirect_mode = true?

Kind regards,
Alvin
