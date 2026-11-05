Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793870756;
	b=UGojR91VMfXY5boQHNMcTcEd6bMFzPEoJLfrHEu8eZfXXq2scsGaHUIN91XBdVpjrKnO
	 PrFvsk+x+gZA30xJqbYrpCoHsI6bw16BnB+DudzFAx3rQaRfusVmSmhbdtpLRqo+PY8/1
	 Y1DFBtifCuhwZSZ4csZMlks3UQbbxCWj3KHV0ElcHAkfjroomPygof0l2YoTXhesk7iez
	 419Bi1QsohlCD1ARwyilN+lFf35SvAMKK+XgU7LarhXasE7uNtp9CTiXCDuQpR+Dqmmx2
	 KtbQRFSXSSPWF/AgRaQcyrSDrztIILX1FtOfFZa94u0cwJcyw+CxEHQQ3jlYBaS035g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870756;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=39dHq7M6rP5KhpElG8mD/VigXg2RbD1RkfmNatjqJJE=;
	b=5hf2MaxjsvTNgBUCSu3WU+3Zu+aa0tm2l9d0oI6NMjv0mdPoKAeICAw9wyMTvx9VBHgu
	 xqVA0Coiffc21F0j1ZHsn54Imh/S3DE8EAW74KEnpKQ7MqoLS/SlCYA0UTbftPyx3lsV8
	 Xds4M6cSuqggSip4sI6O7S+33YMKT1+1AmoU78CJRZ7a46z14FsH0UhjR2HlmKzHrz8Rm
	 UR7sc+rBaogjzRuInZF7WT8pUsfittyLjjjE67vLwNw5DqRWHO/njerp6x7LQHHqenKib
	 ZS75eePoncVMeWnwyZycyaWOOSs2FhkAhef7Jbix8toPQAm0Px5TZvTkCRapaiVZCQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gf3otGYT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.67
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547B606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E547B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gf3otGYT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EImUQrk9xQfjLO1L5J4BkypQHh0Mp7YdniaZxOAESdAicADZYhw3mv4ria2V/brXDfPpmFyYUySE+eKAlMsWzN19eF9PYdt0mcI0WWWoO4YOM2Lq3v2yy98LeSeMM2QZYcSUMiiX0jW8JM+i10VgT8yx+JDHw7rDLzsYJdnbiWLxG6mS01K1tVQRucCqM2z6pfX1EWtGW4OuBZw/pmeuF2Vmxjwc7LZq+ed8YLvLP8XC8nMNsQIxMr+S73BK2qA+AP+uUhc3oOmyJm6k2GuWDhoTulkfEI0ZviYqUZA1MkALKbREDqhQX9+02xgZWa5MINuncicJARhQ4rm5HJ9bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39dHq7M6rP5KhpElG8mD/VigXg2RbD1RkfmNatjqJJE=;
 b=UxecqLBxukSX71DX3r7jnranH0Mlx1+JJpDyDjya9sBGZBEP5FoFWvEec+a2bN0fUoO6Yh4bSgz6cyYCMcF0Y0qrw97RFG9MsCtz3S1yrcEJ+Qj5yOb3zMeAosEAtFdNKq+Jrd1VX9K8fB/2aoRkMU86eWR3qxTcIbgNEHinZP5StC1Di/OJ8El/3MlQjeNZIgo9qiIqrp742WvdKahjuUuVwayW9AUX5x3Xk5tVeZ5Cn3XqEWLfW2GIvQMhF7X7Z2oCvrjQOCBVafUFwSlNjLKkNW1b12hGugPXwKSinHf0sEfNn6EgToqjmeZubFowO937LCxNbYg/7P3m2z3qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39dHq7M6rP5KhpElG8mD/VigXg2RbD1RkfmNatjqJJE=;
 b=gf3otGYTr6+3fypeJYEy7Yf3N02U5cMLiwW3m4Kcb03LGjm3kz439iJJBnsBVWnx8yr0IXVZW1mRqayvLVieTU0nkLRjdWF65BBWIYVqcT32NeZMLAhi9VXuahjcvW8sccl/vrVpFqg5MVYb7f9g62IwgXhV/TOiHjhCI67ixzb/D29AFyUvqZGXjNoltQj7qIGF4PU8JTlQg9H2pz8YbrfQOltkXCqa03cLWBSVgJFZPQMvTtpktXUzRROai8v+QIIv4qBvhT0l99+Z4x6Cgxd7hse2FQ6gJOBfLn1u2vq+VDspchJ/WQidTXJa6Z1nzdPRpHkmEEbMWqfsVnTy1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by PH0PR12MB7864.namprd12.prod.outlook.com
 (2603:10b6:510:26c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 09:25:52 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:25:52 +0000
Message-ID: <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com>
Date: Thu, 5 Nov 2026 11:25:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261022181751.1349984-1-rjethwani@purestorage.com>
 <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com>
 <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c63dd2-30bf-40a4-4f2d-08df3b1ec965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|56012099006|5023799004|261026121527099003|261022075727099003|261102123227099003|261022105027099003|261028144727099003|261021123027099003|261009223027099003|261021121427099003|261026140227099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	m4ZThsnZytayhx9g8eM8nvaW4CVpLiFhyMDqiBrhpdrQJ6pc4kaJj2TMORRSz2lZv/HCW6d+MxlOf8PodzgTg4indxEdMkgswnWCDh5r95A7DFKOGcYPUtDwY8EwYteV2Ia9mfP1Ulik91UKTN7D6X/t3oIAvQLmo733+TmacheMORD+hfD8g3oR8YOuqWtgkiaVAa2bGVn2ufEGAAt4ICp+HXWqOxuxEoFbONs4OEzp9P+tlTNoDu1B1qvEgedhhb/u/LupTCpI72eqC7KgXE3uFuJpLT+zoiRShzb1GqrWeyx/nZvT+vxQgPL3iA1a6Cs53g984oZ76Vby3cVnC8nPLbNXKzQigUH8YtZrl6RLrYk0KM3CcJHhhC9TzXmvPF6ZUQtvRsmM0YSaaUOdXihnnEmU6C130XPt0U0OSSEIVJExbX/GjQRfb4mebuBJA65WmwAg4S5uxj4pwpI+CwS3UHXTG3ZDy7wissdFu9zd7P0RNaHiIkvTxzGflFSYzzY66H7T+s1V/q/qX8gUSUfpPd51YlXpiohIhJQYEl5Fx9Xcz4Q+BOgUM2Fm0vt4IoVHXvsoyuROV3gGCI28XarPFlbgvOl8CLuKkkCpxkoGB7qfD64QLWcdH5VAsWxECv1n+ZOLxrKIcYxorYeyHQDKY7BT33ShUjepM8hz7OQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(5023799004)(261026121527099003)(261022075727099003)(261102123227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261009223027099003)(261021121427099003)(261026140227099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXV3T0g1N0xoRklYYjMxRGFwemxoOVdKb2NqSDd2ZENSNVpJdEdpTVFCRXFl?=
 =?utf-8?B?Nm9acHNqVFNaUk5hdzlvZ3NXdjR0dXpyKzErQko0QzcreGVpRDUrbEpaN05m?=
 =?utf-8?B?a0Q1SHUvMDFnTXdsM3plMzlDY0hDOEVwb2ZnWG80MjZDYWNYV3FoTkM3Lzlu?=
 =?utf-8?B?YzNIZ0xUVmhqcENjQ085MFR1WG92N3g1VGd1YTdnMjdOODJTZUl6ZWlWazc0?=
 =?utf-8?B?NVRXZDVxT2F2QjkzL1ZTckx3cEFXM2FGUjRBQ2xPQXNkSGQwWHdyaisrZWY2?=
 =?utf-8?B?VkV2ZVdHUUtqcFRtZVNWTE9TRFNnSkZqWjBuY00vMlE4N1orMDY5M2VFbVJ1?=
 =?utf-8?B?RE9PdHdlaDMxSWRMaTVGdlI2YkkxY2VNa2FnVEF3WXpsdXZDdGFyTmFqMmhQ?=
 =?utf-8?B?K2NRbEFWVHJQNkJydG9YY08zSmQwNjF4VVNISWROek1RTDI3VFBvYzl2Yys1?=
 =?utf-8?B?NHJiY1dmV1l4ZDFBdTRaaUFrNDlJWUJkSFlxVk43d2NqdmdEQ2s5MUxzbWVm?=
 =?utf-8?B?Z3p2blZsTGVBK0NuTG5pSGJYUDhNRjhCbUlnUDVaYll6K3l6YWZqL0J5dUp6?=
 =?utf-8?B?SE13cWJFSTdxdHN0U1R0MFY2K3gzOVM4SkFUSzRHeWVZSmwyTHViN2wxcGI0?=
 =?utf-8?B?dE96NzZGckp2bEp5MEY3WWdTd3U3K3RPblNYTCsvZlV1OFpvaDRNcXRjOGhE?=
 =?utf-8?B?YStkMFo3eE80TkN3UVRKeVZEWEZPNGw4bVJYUzlmQzJXZWFzV05PL3pFQktx?=
 =?utf-8?B?Y3FrVURoYTZ0cHVhUTg1eGFSeUovUmRDc1lzOS9wc1FhMDB0L3Q3ZkFObFFa?=
 =?utf-8?B?Titvek1ZZVdndWI1QmQydWxPOG40UEtsYi9xZzFHeE5Hd3FjU2V3YXR0bURZ?=
 =?utf-8?B?OTF6VW9jeElLYzV0ZTMvZm01Ni9zTmFCVGxiLzRsZDRBb044OWw0RldYenRi?=
 =?utf-8?B?YUJWam9GMTIySUJBekErMzE5VTNRcHNiY1dUbEF3NmxtaVNHRmxSQVlpN2Q1?=
 =?utf-8?B?eDVzZU9ZcFNvUXR4ejVmV3dvR2lXRFB4ZlFaNEMyTFlSLy9yTEp1REZJbUYz?=
 =?utf-8?B?WXdVUHhxNjEyVXZBbXlJQXJSVC9vQlJCaHBhaGo1VnF3b21Yc3RFcVJ2bFEy?=
 =?utf-8?B?aVVSTlZ3S2RRVGs2ajM2Sy9PMDVmK1J1dS9oS3F0MURMTE1zQ1B1VVNwenRF?=
 =?utf-8?B?WnF4S1BIZ0NFcWhvUnVwckpaNEJHNkVMTXFUejRCeW9rSEF1T3J5dVVVSlMv?=
 =?utf-8?B?MFBkUVF5OUZwTWJKNGZvLzA3NGJoVG82ZXJ2Wmt6aG9BSHdMN25vZjVRSUEr?=
 =?utf-8?B?WjAzdHFJZ09Oc3BLSWdkeCs4OFBabzJxa3ZMQk1TRm8xcjgvL1R0V05pVFdW?=
 =?utf-8?B?OWFWMlZZT2U4dkVNMGY1YkxwZnRKS1ZOTTFVK1U2R0lHTTRURUNaVFRuU3ds?=
 =?utf-8?B?dnRDMHR3NDNXY0F6RXBuaExiU1BYYjBIb0RWZ2craW1UYzl4U1hWd0U1ampk?=
 =?utf-8?B?Q1dpMTdSWjBHTTlmZkxiQzRvckxRRDVBa1V4N3Fxai9YMXBKNGNVRFF2by93?=
 =?utf-8?B?RXUrM0FjMFdvSm1wOTBIbktiUnpqSmFqOEhyVUsrTmczaWUzTCt1S0puMGs2?=
 =?utf-8?B?dzM1TmRPZHkxOGtCNFlhWkpuWUgrTzZUMjJZVVF3bFhFYzJJYzYyaUVLVk1n?=
 =?utf-8?B?Y1BVME8zdDh1d0poWkM4VTdVVnR2YVVnVS9KMWFTZVBFTnBiTS9nWG1MdEVT?=
 =?utf-8?B?UTNpM1BraEFRSnZTUXFuRXozajBrVHFnckpXYWV2NmJTeUpaWDhoK2VqbTdO?=
 =?utf-8?B?N2tkQWN3dEdsVFZWWXM2QXpzZ3ZRSCtGb3VwOVMzUHY0Rm9vSGZZZE9ldGxZ?=
 =?utf-8?B?VTFnbkxnU0RSTUFUWFFQZzZ4NkNmZ0FQN214UGtVcGtRRkhWUXhPaXMydWN3?=
 =?utf-8?B?YkE1NThkMmoxZkk2d3NVdWIwNlN1MUJRTGNFcVFZc2tEa3BGdVJ4T3dSRFha?=
 =?utf-8?B?RVd6cG5qOS9ySFQzKzdON2UzajZoQlk4SWlzak95R2dqcE93YThXWXJmK2Zt?=
 =?utf-8?B?Q3d3UjV3RVVxQWszVlJXS0xOeEFSeGpvWE1ubk5tMGUzalQxcG4zUXNqbjlC?=
 =?utf-8?B?cnEzekROV2tYSmFBZjdCc3BOS28wZGtrbjEyNEVNZSsyMlNoNE13MDBrK0NG?=
 =?utf-8?B?RVg5TXArVGFFelNKM0h2VkkwKzkwR0pSNHY1VG00U21CYmMrdVkrREpsV0Vk?=
 =?utf-8?B?UFcwSzZPWjNkR09GUndEZGxaeHJxVU1pa2F0REI0MkphRHV3cm1QQTE4TFJO?=
 =?utf-8?B?WU9yaGtHM29iR25kQ2Fxd0VFRy9YYUVGOWErTUVRUDB5VEtNMlBYQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c63dd2-30bf-40a4-4f2d-08df3b1ec965
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:25:52.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBfajRJap25wavYYwDx6lqZxrSCQ8vgZFDbmjk1fp1bM30KngjVsY1AzN3Vxf7BevoFXcxK9C5VyzkUdNwMk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864


On 04/11/2026 7:01, Rishikesh Jethwani wrote:
 > Thanks, this answers the cross-SQ ordering question. Short version:
 > I agree with (1), and (3a) fits the series; I prefer it. For (2), I
 > agree with the goal, but wmem-gated reselection alone does not keep a
 > connection's work on one SQ in mlx5e; the holes are listed below,
 > with two ways to close them, and I'd like your preference.

Hi Rishikesh,

Thanks, very thorough again. Short version from my side: I'd go with
(i), closing the holes, rather than (ii), and with (3a) along the lines
of your contract. As the queue moves corrupt records today, regardless
of rekey, I'd send (2) and the mlx5e side of (i) to net as fixes; I
could reproduce the corruption on ConnectX-6 Dx. Details inline.
Feedback is welcome, especially where it touches your series.

 > Two hardware questions here, and a third on initial setup under (1):
 >
 >  - Does a completed DESTROY_SQ, or finding an SQ in ERR, guarantee
 >    that none of its WQEs can still access a TIS or DEK? And can
 >    DESTROY_SQ fail while the function is healthy?
[...]
 >  - DEK release in mlx5_crypto_dek_destroy() has two paths. Without
[...]
 >    After all WQEs referencing a DEK have retired, is either path,
 >    including reuse of a pooled id by another connection, safe while
 >    an idle TIS still names that DEK, before replacement static
 >    parameters are posted? Or is today's release only safe because
 >    of the destruct-time ordering?

Good questions. I'll take them to our HW/FW folks, and get back to you
once I have answers I can back up. Meanwhile, what I propose below
relies only on what the close path already relies on today: a CQE
retires all earlier WQEs of its SQ, and once an SQ is destroyed, none
of its WQEs executes.

 >> 1. Pre-existing, independent of rekey: the stranded WQEs above.
[...]
 > Agreed. Three spots for it: on SEND DMA failure, mlx5e_sq_xmit_wqe() and
 > mlx5e_sq_xmit_mpwqe() already post a NOP through mlx5e_tx_flush() but
 > free the skb first, so the skb should be held instead; that NOP asks for
 > a completion because mlx5e_notify_hw() sets MLX5_WQE_CTRL_CQ_UPDATE, not
 > mlx5e_post_nop(). mlx5e_ktls_handle_tx_skb()'s err_out needs the same
 > hold-NOP and a doorbell, since it can leave parameter/DUMP WQEs posted
 > without one. The MPWQE case is reachable too: when TX MPWQE is enabled,
 > mlx5e_sq_xmit_mpwqe() takes any linear, untagged, non-GSO skb with
 > inline mode NONE, which includes a pass-through skb that posted pending
 > parameters and took SKIP_NO_DATA, since it leaves with no TISN.

Right, the patch covers the same three spots: mlx5e_tx_flush() takes
the skb and attaches it to its NOP, which requests a completion through
mlx5e_notify_hw(), and both SEND error paths hand it the skbs of kTLS
sockets, MPWQE included.

 > One correction to "SQ error/reset is covered": error-CQE recovery never
 > runs mlx5e_free_txqsq_descs(). mlx5e_tx_reporter_err_cqe_recover()
 > waits in mlx5e_wait_for_sq_flush() for cc to reach pc, then zeroes both
 > counters, so on success every WQE has been retired by an error CQE and
 > the held skb is released normally.
[...]

Correct, thanks.

 > A related recovery gap exists today without rekey: if a connection's
 > initial static parameters are flushed without executing, recovery does
 > not re-arm ctx_post_pending. A retransmit of the same record can also
 > skip static parameters, so software does not guarantee that the new
 > context gets installed. What does the hardware do with a SEND naming a
 > TIS whose static parameters never executed, recycled or freshly created?
 > The rekey contract below handles the corresponding replacement case;
 > initial setup may need the same treatment.

Agreed, and it is wider than the static params: any lost WQE leaves the
TIS state off from what the driver tracks. WQEs are lost when an skb is
dropped after its kTLS WQEs were posted (or after expected_seq advanced
past it), when an SQ error flushes them, and when an SQ is closed with
WQEs pending. The driver holds the skb in each of these, so I'd mark
its connection right there, and have the next skb of a marked
connection resync fully: static params regardless of rec_seq, progress
params, and a DUMP of the record prefix. That covers initial setup, and
the replacement case of your contract, with no rekey-specific code. I'd
send it to net together with (1).

 > When do you expect to post (1)? I'll base the series on it and can
 > test on ConnectX-6 Dx before you post.

After internal review and testing; I can share the patches as RFCs in
the meantime. (1) goes to net together with the resync fix above and
the fixes for (2) below: the stack part, the mlx5e queue pin, the
channel replacement overlap, and the pass-through skbs. I tested them
on ConnectX-6 Dx, and testing on your side is very welcome, especially
with your series on top.

 >> 2. Pre-existing, and a dependency of rekey: TX queue stability. I'd
[...]
 > Gating ooo_okay, the dst-reset queue clear and txq_reselection_ms
 > on wmem covers every path through sk_tx_queue_mapping. In mlx5e the
 > SQ can still change while that mapping stays put, or bypass it:
 >
 >  - Channel replacement with tis_tir_td_order destroys the old
 >    channels only after the new ones are active (3b88a535a8e1).
 >    mlx5e_deactivate_txqsq() posts a final NOP, but nothing waits for
 >    its CQE, and mlx5e_poll_tx_cq() returns early once ENABLED is
 >    cleared. The deactivated SQ can still hold old-key WQEs (e.g.
 >    under PFC pause) while the same txq index already names the new
 >    SQ, so (3a)'s "same SQ as all old-key WQEs" holds only once the
 >    old SQ is destroyed, which is the DESTROY_SQ question above.

Right, and that overlap is a bug of 3b88a535a8e1 on its own. I'd fix it
by draining the old SQs before activating the new channels: their NAPI
is already disabled, so the switch reaps their completions directly,
and the old channels are still closed after the activation, which keeps
the downtime saving. If they don't drain in time (e.g. under a long
pause), it warns and falls back to closing them first. No kTLS-specific
count is needed.

 >  - With num_tcs > 1, mlx5e_select_queue() adds a priority offset
 >    after netdev_pick_tx() (DSCP under MLX5_QPTS_TRUST_DSCP, else VLAN
 >    prio; HTB by skb->priority), so IP_TOS/IPV6_TCLASS or SO_PRIORITY
 >    changes move the SQ.

mlx5e_select_queue() can keep the final queue of such sockets: cache it
in sk_tx_queue_mapping, and reuse it as long as ooo_okay is clear. A
priority change then takes effect once the connection has nothing in
flight, which for a busy bulk flow can take a while; that's the price
of keeping the order.

 >  - Egress skbedit queue_mapping bypasses ndo_select_queue(), and
 >    SKBEDIT_F_TXQ_SKBHASH can move a flow after a txhash rethink.

I'd document it as not supported with this kind of offload, and have
the driver count it (see below).

 >  - A queue-count change: netdev_pick_tx() ignores a cached index
 >    >= real_num_tx_queues whatever wmem says.

In mlx5e that comes only with a channel replacement, which the drain
covers, or with an HTB leaf deletion, which closes the leaf SQ before
its queue is removed.

 > Separately, "a drained wmem means that no work referencing the
 > connection state is pending on any SQ" has a pre-existing hole:
 > netem with delay, jitter or rate calls skb_orphan_partial(), which
 > keeps skb->sk but swaps tcp_wfree for sock_efree, releasing the wmem
 > charge while the skb is parked.
[...]
 > Both kinds of skb above can be handled in the driver alone: mlx5e can
 > skip the context WQEs for an skb with skb->destructor != tcp_wfree (the
 > test tcp_gso_segment() already uses), which covers the pre-install
 > plaintext, whose orphan decision netem_enqueue() made before the socket
 > was offloaded, and the parked rekey ciphertext alike.
[...]

Agreed that it belongs in the driver. Rather than keying on the
destructor, I wrote it so that nothing is posted for an skb that
doesn't use the context: the pending params are posted only once the
skb is known to need them (in order, or resynced, where they fold into
the full resync), and stay pending on SKIP_NO_DATA. A pass-through skb
then touches nothing, wherever it was parked. Does that cover both of
your cases?

 > So (2) as proposed is a good stability hint, but not proof. I see
 > two ways to get correctness:
 >
 >  i. Close the holes individually, without a new per-packet lock: the
[...]
 > ii. A driver-side owner check where WQEs are posted: priv_tx
[...]
 > I lean towards (ii) for robustness, with (2) as the hint that keeps
 > it off the slow path, but I'd rather hear your view on the hot-path
 > cost first.

I'd prefer (i). With the drain, it no longer needs to close channels
first or to count connections, and the rest is small and local. (ii)
adds a lock and a SW encryption fallback to the mlx5e xmit path, for a
case that shouldn't happen once the holes are closed; a fallback that
hardly ever runs is also hard to keep correct.

And as these moves corrupt records today, without rekey, I'd send (2)
and the mlx5e queue pin to net as fixes. On ConnectX-6 Dx with many
channels, kTLS TX records already fail decryption at the receiver with
the default txq_reselection_ms, and forcing moves breaks most
connections; with the net fixes, the same runs are clean.

As for a future path silently breaking the invariant, the driver can
catch that cheaply: it remembers the SQ that a connection last posted
on, and when the next skb arrives on another SQ while ooo_okay is clear
and the old SQ is still live, it bumps a counter and warns once. That
is a pointer compare per skb, and it turns a silent corruption into a
visible one.

 > (3a) fits, and I prefer it. sendmsg keeps sending SW ciphertext during
 > rekey, which holds wmem, so (3b) can wait indefinitely unless the
 > sender stalls. With this series, mlx5e is the only in-tree driver
 > accepting TLS 1.3 crypto_info, so the core can require the new op for
 > TX rekey and leave other devices in SW.
 >
 > Proposed contract:
 >
 >   int (*tls_dev_rekey)(struct net_device *netdev, struct sock *sk,
 >                        enum tls_offload_ctx_dir direction,
 >                        struct tls_crypto_info *crypto_info,
 >                        u32 start_offload_tcp_sn);

Looks good to me.

 >  - The old DEK is freed from process context once a successful
 >    CQE covers the fenced replacement, subject to your answer to the
 >    second question above.

Agreed, and it's simpler than I first thought: the driver doesn't need
to track completions per connection. When it posts the fenced
replacement, it can hand the old DEK to that WQE's descriptor, the way
DUMP WQEs hold their page refs today, and release it once the SQ
retires that WQE. Completions being in order, that covers every old-key
WQE posted before it on the SQ. A flush or an SQ close retires it too;
the TIS may then still name the old DEK until the resync installs the
new one, which is your second question again, and the same as an idle
TIS in the pool today. The release runs from NAPI, so the destroy
itself would be deferred to a work item.

 >  - Retirement of the SQ only proves the old work stopped, not that
 >    the replacement took effect. If the SQ errors or closes before
 >    a successful CQE covers the replacement, the driver forces a
 >    resync on the next offloaded skb regardless of expected_seq:
[...]

That's the resync fix above, which isn't specific to rekey.

One question on the core side: once the HW validator is restored, can
a decrypted old-key skb still be queued, e.g. a spurious retransmit
parked in a qdisc, and reach the driver? It would end before the new
marker, so mlx5e would take SKIP_NO_DATA with a decrypted skb, which
today hits WARN_ON_ONCE() and drops it.

 > If this direction works for you, I'll write mlx5e_ktls_rekey_tx()
 > and whichever (2) option you prefer on top of your fix, and test
 > them on the same hardware.

Sounds good. (2) is covered by the net fixes, so please go ahead with
the op and mlx5e_ktls_rekey_tx() on top of them, and I'll review. The
RFCs mentioned above should let you start before the fixes land.

Thanks,
Tariq
