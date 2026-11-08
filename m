Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794167149;
	b=ozDfXSYeTE/4k7z8vDwuV3Z0JBnwqWlRUgLbJcj3uDzjAWdNFmY2u3kLjSfkprwm3bVE
	 UTlesGqu8kXMFh5oiqseL8n25h44ifKQJVfb4n1/40A5QUD+RY6kDKRXeyIxXNJG3bIbP
	 Z5nB1zCP8CJK2NUehjdlYnctZn0zI8GvRX0kP4zCKhhYITxwA9wtNv97ADjJWWXXbQ2fB
	 X35nSv1HHUQVfEtJ7RUcxIYso/RAHjMiuyvJRGdwSaE/NKp4T4d0TdUNkSOqss24w3PI5
	 XAsBGbci+3do+W+mK3NZGGcot8sWK+IVB7/eZoB9pINu0VDNoJgxTZUzTnli1zQJTLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167149;
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
	bh=mU/CEuwwNvuUHGDOA5yZN4w9o9/T1GJqF2OzKRNpbwM=;
	b=Yuzxoy73TSIbRNXflJ2YlB3o/dmTQ3LPs+siFhYGNbXgpW7Tz9vOeeACr2+5De6d0p+2
	 ev4V+lRl+ewqQ4lrZrwZ57iWikOwfHgRmrcb0OgbdIEOOAyElX0U7WinPyGtad2RjRXkA
	 kVDjNlFN9OGRVwaTKS6Nx/0+ju92B42TC2J0zkVisD8rbamUFJWEhAjKnXFgo40h9C/0r
	 GqF80XrqbwhRGIpikOsC47p1gZ9x6NVauu1CcpDreqLWXy5EYTulmevNXXd+QCZKeUH0S
	 zJUiroN5JpyAs4DxOb1lTKDi6rO7qsQI0/t5co1Yc1QLCR8OnQBd21U9DO4yMskTWZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kwV67pd+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C3606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 19:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kwV67pd+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR0iIzkQTUe69gkyILoEhbdeqaKgzJV2shsirNAZUqxoIx1HPLQHBVwRIKCYUUThboyEIDnsQKNO+iY6yfkaof4Cf7qF1oAUMHqRz6a3qMVq5kMAQuw3sV+P1x80UKHCIZzHB1FQ3Pxc0rmvbCx+m84uM1huPLQxCZP55xhfT4l12720ZZsvZZNBvTLxC7laVvgrbFqpYVYH1A45E2sP/iCcz7SKFG2PEmjtSVH4ZV4x2cqIf6wLk4WYHVSIunz6Ne19a4r+9WJWAeu8CsMJCZVBHjfDdPIR+Fs9jp4QBOgOjtigkY3YRvx3kcMAcAQiU78EeORpSOcVT+DMPlHsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU/CEuwwNvuUHGDOA5yZN4w9o9/T1GJqF2OzKRNpbwM=;
 b=WEQl0h07zImAHuaA1j0C4PyG48Vw3hsPkYrAPVy1c+v31aigocuhBJkD2DlBihIkl1axAa2mHxUpLA/Gu8m+B9rM3RVBoMFRWtPE/5D0OS1xcLGmmknl/cCVFL+DJw3yC9YIGANqbKP8q+nD9XOia/P5SzjTC8qhPQBVYV5KmM24HjHweRouvIwFMPbfSL5R0b++BfgfNKCsfObJD88GGGDVlKvN0A3s8EIlqiNtbNWF3QUyPNYfVdAYQGPSXzUPrbDr3rwdK6+Wr/rynWW39p6hGRFrJwfJi6qy4+AzWG5M7oa+kUQ96Mwgofvyd4jqpjdbdzvSINYJ82Bsv1tO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU/CEuwwNvuUHGDOA5yZN4w9o9/T1GJqF2OzKRNpbwM=;
 b=kwV67pd+WO6SEvobUr6nHtxfKTj6ammUh53GDvz+3decNziP4MhOXeMzkNcsKqbdtA/m6zPqaGQG8f+W7Y29x9oSJkzEUp67PBMCMasRPs1MS5TfIieW6ycHZE43xMr9E/BHkQ/b0uZ4tBsOiXuU+QujvWx8IyUXzyJnjOlTSwkGiyMLn6P2k7calyUJ5Kmbm/YR5EdEhyj/q50dQoSF8MsAT8Z8lRPGELytkqdmLq0qYCQPGC6qnmid/xUYJ5+dt4r0ULS35euECbPJoMr08xsSDotzDbIVa80mZqD8SBOYc5mbkshOWk7j7GIrfwbt969XIEk2Mlrlt6OXsZtKkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by MW5PR12MB5624.namprd12.prod.outlook.com
 (2603:10b6:303:19d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:45:44 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 19:45:43 +0000
Message-ID: <9a8e3e1a-977a-4e48-ba9a-2b71700f6924@nvidia.com>
Date: Sun, 8 Nov 2026 21:45:42 +0200
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
 <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com>
 <CAKaoeS3hDE5q7XGtPy4XKmGL54-+7Y-H9JyMcdz94FiQW2_ffw@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <CAKaoeS3hDE5q7XGtPy4XKmGL54-+7Y-H9JyMcdz94FiQW2_ffw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To IA4PR12MB932075.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 345024b4-f0df-440e-a111-08df3dd0e034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|3023799007|4143699003|5023799004|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dTADMNrfMz2QFTH9ZhvEvPqKaTWYSqBBGekqK7okRt6hMgl7PMax9s7okfHNii2BXq2B27mkrA7IiKt2xdcjwZnLlKLqKj0UJHCaaktdt+IAEthUjO4XZujD1B9QCgyUnDF9fN2/Nk/mlwYM+sU+qpdsAZBdIA5mZZJFbNTa4wG2PLQgpvh6TdGT/jMCE+UFbqrK40bk/Jm70et7FP8TITFNTgfoOFKarOifi0z1M3K/QfHuvtwrUHLEvKgfZ6MbBKuECXhlpGazk7vmawEIQ3dBSIQwwxzXTik+sPHaPcH5t78kTSE985fApZxrlwtOJiXIjume6OSxxXmb2eCqS14o0y5yi4joULOVr7A7Z4s8AnW/htLBGXv3Erf8klw2QctmmYim+HCbjOxAuri6Ev7ZldZrW7zSiOq1bnKAXPKAYKjdAFiypzQDTIMp9sfRtammG5ABpn4IRuqewBUxeD6zrPSgjHjbiWBZH5e+3Lb2OiPnugH9tEiNadXgoQLds505lqYfyDZvla41478WJo24UW+LTJj2R+/L+qF69X+tJxMWULRMPr14p1Z0rStbQdAshIWV1dxquKuUzlkUwCPCrPabRmKBV7e89nCcXLTUOCg6ESX/C3R3QoPS8wp3GOIb/O16URyDhLtKsX73sSLuG1ennhRLoHDN0N1gYK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M291YlhwVXNyMUZGYjkyRlhtcVl6TEFhUUVBUy9KOEtIN2hLeTR0VFVqVWlR?=
 =?utf-8?B?aEdaWEdRMmF0aS94S2xiUmZuZ2JKZ0d5bW1Yc2NsdXRKNFFqZ0xYM2Ivb0Mv?=
 =?utf-8?B?cW91N0I3SDJkakt3M2NMNUE0Z1FUUnZ1U0VXNUEzRExQNXZrRVRhQ1Fnak8v?=
 =?utf-8?B?SndZcTFoVGdjWTFrb0x5STJNbzhuTjJFdzFDY2RrakZnY2tucnkxRXk1cFRY?=
 =?utf-8?B?WjNTTS9hRm5VdW9acjJqR2FwRmNYNUNwMmhRei9EL3M0ZWMzcmcxTCtzK2ZN?=
 =?utf-8?B?STgvTUlFMG5Bb3MrSlo3T1c0T3JaRmVZU3VkWFRYRVJMWXdSbHJNOGN0R0tt?=
 =?utf-8?B?ZXQvQzc4VGkxVFI5T0UzZndsc2xWYk9yYUowQzkzYy96UjhTS0dYYTFkU0ZI?=
 =?utf-8?B?NEZnQ2hjaDJjWTJ1a2FtOE1XaERVZGJtS1kzbHNSbk05b1JieWY0ZG81UDZ1?=
 =?utf-8?B?ZlZqWDBRTFpMTFJINDBiYzNuQ3hwcEVSNnVOVGpraDRSQ2hhcDRETTJpZ1Yx?=
 =?utf-8?B?dEt2SFlBNE11OXcrMU5KMVgxNVhoclM4RStDNWd6aFF0ZEhOdVVvV2owbTdI?=
 =?utf-8?B?UXJCQ3IrVGMyU3ByWnlNeVc2SDBSa25VN24vc0Nhcmhnb1htVmtHYjVzU3Jr?=
 =?utf-8?B?UVI1TitzMDhLMXRuTmpHSTJ1dFM5R1lnQnBXZERBMmhjQWlCR01jdjl0ZnZr?=
 =?utf-8?B?cjlhMnRIb0hoSVE4K1VVUW9Dc0xacUhqenpMc2tlZWgvWUhsRDFiRXBvTnlD?=
 =?utf-8?B?ZCtSOTdOSzhLWUR2SnBTWllLYTlkMmxqWFdMcmovdjdiRVltdUFOVEJocmg2?=
 =?utf-8?B?aFBqK2R1dWpMdnYzM0FJNlliNkNwOE1QQnNsUzQxUTZ6SnpFMXNEeXpnd1Z1?=
 =?utf-8?B?OXg0LzZmVm80R2Z1NFRkVW5sWkZNcWJNcGJFckJrQ1g0UUpXUFdpQzRYRm0v?=
 =?utf-8?B?Ymp6VzB0WFhjaDhSTzF1UDE1WEd4Z2xLdi9oc1lUZlBGNnJpZ3JnWmgxWnVO?=
 =?utf-8?B?UzZGREJCdGpjenBUWi9ybEd3eHR4SEdXd3dDZlVsZWxuQmpLaWFISWZKclg0?=
 =?utf-8?B?L0c0UTZtbnJMT2JJTkxySlIrczlMT3R4WXNtTlMvQ1ZMekFkVURXek03Z201?=
 =?utf-8?B?anlQNzE0QnV4RFNVS21abEdTN3FGUUsyeVJzeWdoaThjb2gxVGVLVDRjOWh1?=
 =?utf-8?B?VkF6UmFkdnUxTVpMaXFPaXFScFlNS29FN1BwSUpid0puL0htd3VMMUtOeDA0?=
 =?utf-8?B?TVRwZVVnR0JLUlMxdVBRR0ZwVUo1REdHbjZ4enNUckZIZDFVbzd5RHRyT2Vj?=
 =?utf-8?B?bXgvcnhHa0tXc2FyOGhWR2FVZXdlL3Y3REZ2WEhlcFhZV2lCNHJCN2dpUDYr?=
 =?utf-8?B?ZXNOMmtkbUR5TGVZekdkdmwxdEJTSm9QQXNacXNoYUxjWm9sSHQvL2pUd2pn?=
 =?utf-8?B?ZnBXZ0U1REIyMmM2RlJOdE1wUmpmQjZxcjNJUTJYNkNCYW9reFU3S3lYaUVm?=
 =?utf-8?B?R1gwY0hkSnh3WXBQSUh4MXR4cWthSFNUVzl5anpiNG9YdUxaR1lWQUN1T0R6?=
 =?utf-8?B?NDVuS3EyRWRXd1JlVXBHdHZmeE9WeC9CbU9HR1hUbENIZDJpOEhrazFhNTFG?=
 =?utf-8?B?RFN4UlI5Skp5UWxvODRMeEIrQTczU0FWZ0FaeHY0VkdsbWNQOFNNalkwZkRY?=
 =?utf-8?B?TVFOcEVnUGhQR0pzTHlPdXZ1dUJ4c0F3VEdBK3BOalh3M1JwQ2daWUJGMDgr?=
 =?utf-8?B?NzkxVHptSmlVajc4Z1JYZ2ZqQjdJSXhrdkY0WTJ4MzRZamw0YTFKUDIzaTZC?=
 =?utf-8?B?ZTFSS3VZb3VWZkN0YnoxNU5IY0ZsOXUvRVl1ZzNYSlVlSDgxeTdyNjhCZkVI?=
 =?utf-8?B?T0wwdjZ6aEdBQlllcEluN2t6WHFxdUh0UmtSeFdTaWc3b2pJdDYyY01BYVpj?=
 =?utf-8?B?UDQ2dHlTVDhYS0crMFFxNmhkZlZENUNvdi9jbWlkNXBiSFYrdGU3czJUSlN2?=
 =?utf-8?B?N0ExYjJHSG5ZYmk0MW1sQjJTTGxDeTIyWVJpZXU3SkVTcEJJeGREQWRpalFS?=
 =?utf-8?B?anpzRE81aDRFVUQvSUZia0pEK1dnTTRrcm1NbTBUU1oxc1EzeFN5dTA1K2dK?=
 =?utf-8?B?RzY4Z1pDclhkZFZLOU02ZlZvbzRYMnJRTDZibS9JZTNiNVhpWEFrUmRwTlJM?=
 =?utf-8?B?cjE1RU9EN3BCbis1NlNjMWxzTmZnUUV0cFlPazE0Z0RqTWRBMllPNU1sL2pX?=
 =?utf-8?B?dFhFakNhRU5YOVg5QzU5ZjFWSW0wRTQ5NG9rVHloV1pRVFI5cTVVU1VFZlcz?=
 =?utf-8?B?YkEvd2NtNVJTVU9tSUpBYndjd2s3MmVMZklmM2xKUFdRWkdOVEtUUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345024b4-f0df-440e-a111-08df3dd0e034
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:45:43.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJixvfjFfyeno0zNbV8MTEpX966SCCLfx8Cd1/dK3A723/OGeBYNWqMHYRhYO8xDwNeMWVPM0Y5mUA9/1ntyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624


On 06/11/2026 21:58, Rishikesh Jethwani wrote:
 > Thanks. Agreed on (3a), (i) and the net fixes, with one condition on
 > (i) below.

Hi Rishikesh,

Thanks. I took your points into the patches, details inline. I'm
re-running the ConnectX-6 Dx tests with the changes, and will share the
RFCs once they pass.

 > Thanks. Until then, the two hardware questions remain open, including
 > whether DESTROY_SQ can fail; the destroy wrapper discards the status.

DESTROY_SQ doesn't fail while the function is healthy. If it does,
something went badly wrong in the firmware.

 > One correction to my last mail: recovery clears RECOVERING even on a
 > flush timeout, so the queue can wake once stop_room frees.

Thanks. WQEs posted to that SQ then complete with error CQEs, which mark
their connections for a full resync, as in the first error.

 > Agreed. What rekey needs from that resync fix: a lost initialization
 > or replacement always triggers a full resync on the next skb that
 > needs the TLS context, and a connection marked again while the driver
 > is consuming an earlier mark stays marked (test-and-clear, not
 > clear-after).

Both hold now. The mark stays until an skb that uses the context
consumes it, and it is taken with a test-and-clear before the resync is
posted, so a loss reported meanwhile marks the connection again.

 > An explicit bypass right after the
 > datalen check in mlx5e_ktls_handle_tx_skb() closes that without a
 > sequence comparison:
 >
 >         if (!skb_is_decrypted(skb))
 >                 return true;

Agreed, it's in the pass-through patch, with credit.

 > I'm happy to use (i), but warning/counting alone does not cover the
 > forced-queue case: a detected conflict has to prevent the conflicting
 > hardware access, since old TIS accesses must have retired before
 > another SQ can modify the context. Dropping before any TLS WQE or
 > context-state change would preserve safety without SW crypto.

Agreed, the counter is now a drop. Each connection records the TX queue
that it posts on. An skb on another TX queue moves the connection only
if no other skb of its socket is in flight: an skb is freed only once
the WQEs posted for it completed, or were destroyed with their SQ, so
nothing of the connection is then pending on any SQ. Otherwise the skb
is dropped before anything is posted, and counted, and TCP retransmits
it.

The move is made under the old TX queue's lock, taken with a trylock,
under which the connection posts there. That serializes the check and
the publication with that path, and leaves the connection's datapath
with a compare of the queue index.

This covers your points 1 and 2 where the WQEs are posted, wherever the
queue came from. For 2, the mlx5e pin now also re-checks wmem at
selection as you suggest, so a stale ooo_okay doesn't lead to drops in
the first place. Does that match what you had in mind?

 > 3. The drain has to cover the QoS/HTB SQs too, and reap deactivated
 >    SQs although mlx5e_poll_tx_cq() returns early once ENABLED is
 >    clear; a missing or replaced txq2sq entry isn't evidence of
 >    retirement. On a drain timeout, the fallback must close the old
 >    SQs first (which keeps the guarantee, modulo DESTROY_SQ), never
 >    activate with them alive.

That's how the drain works: it covers the QoS SQs, reaps the deactivated
SQs directly, and on a timeout closes the old channels before activating
the new ones. The drop above doesn't rely on txq2sq either: an SQ that
is deactivated alone, e.g. on an HTB leaf delete, keeps its skbs until
it is destroyed, so their socket keeps its wmem until then.

 > On the price you mention for priority changes, agreed. Please
 > document in Documentation/networking/tls-offload.rst that pinning
 > delays priority/DSCP/HTB-driven TX queue changes until migration is
 > safe, potentially indefinitely under sustained traffic.

Done.

 > Nice, that's simpler. On the core side, the op's contract: the
 > callback prepares the new key and pending parameters but posts no TLS
 > WQEs for this connection.

[...]

 > Callbacks are serialized per connection, but another may arrive
 > before the previous replacement is posted. On success, the driver
 > must clean up any superseded, never-posted key.

Agreed on the contract.

 > Record lookup also uses 32-bit TCP sequence numbers
 > today without rekey, so a sufficiently delayed clone can alias a live
 > record there too. The floor catches old-key clones within its
 > comparison window, but does not remove that ambiguity. I'll look at
 > closing this in the core separately.

Thanks. On the driver side, the bypass above keeps plaintext skbs out of
the record lookup, so it's down to the decrypted clones.

 > Please Cc me on the RFCs, and let me know which fixes the rekey
 > patches should depend on.

Will do. The rekey patches should go on top of these net fixes:

   net/mlx5e: kTLS, Hold a dropped skb until its posted WQEs complete
   net/mlx5e: kTLS, Resync TX fully after its WQEs were lost
   net/mlx5e: kTLS, Post TX context params only for skbs that use them
   net/mlx5e: Drain old TX SQs before activating new channels
   net: tls: keep the TX queue of a device-offloaded socket stable
   net/mlx5e: kTLS, Keep the TX queue of an offloaded socket stable

The drop goes to net-next separately, as "net/mlx5e: kTLS, Keep a TX
connection on one SQ at a time"; the rekey patches don't depend on it.

Thanks,
Tariq
