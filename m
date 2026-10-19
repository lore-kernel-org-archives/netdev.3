Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435822;
	b=D15Hfa77Pgs8jD4Z852QPJNnLJAfZaWDcF0Mir7vbrUIPUykWOEOyvUXNJuTQUs0oQqS
	 KEEWz2lFjHPHYmUg6RgMN9wcRrEkwf5d3S+N26eGDrkY4bKyvUqjgl1A7oDytRD0rxq9d
	 XM9hvdtH3GWcP0fwfnPiFYLuRoOBZCC4CGQcrt5CConPeHfqBZA+ETKFkEIkQb9O0ZSlQ
	 8MfjwZLYZMu/OhdyJ9OGtveH91IPQAJ77DVkzO6ykHcciBmmhgKHmUA2Id39pF1HRKQQW
	 eAskfarfhX9+tHackq3Ej1cjnbCcfz/o2fInW1WVGdpYXfCa9exlALwPUB0BIJS6akw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435822;
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
	bh=hneDynt5tkfg3Mqlu9ep7rj2g5VdYQwOGPLyJioUYjU=;
	b=wQtmwn28KXpRmowOvQbFKurs10BZoBecttgaCYkgJ3X7/OvmkI6TtFLoQ1OhNnSIk7Hm
	 j+S5Bca8oO2hty9JloTf+xZfvwZOGYMcSzGy88/HFiGdl3gQIjxHFaO0GGlReSwwH3vJp
	 yhviUFMF6zcDFV44KSDrKiv+08WUepOEWEb2f/aAd3OGGSPz12Ee4Ui2FXlUcXbn25HVR
	 dAVRLgxgcmGSWB3fOJn02vcO6wIAjYsg7CIcSk3zX5L71r4/sScwQuFOBVJkdZJAKb7Br
	 fzDE0vzcg2eLL1Ccor1KX3TfBvyqXHc5rpz7UlPB4m3/1qQ+E2VUb0wrPzP61HL9DbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aWrJjaKU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.12
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1744606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1744606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aWrJjaKU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds0Ig/dehiwjNWW9tQz8zYCyigqX2sHy4BZYYbXGMUk34BYIu4qyP3dSE9fhZAL3NZg5ulmt4PrToVQEJhqcWZKVWKgyTFJxwE+WOWjGF1butU33I/K+Sq0JcOe2tIL+7+0JG4PuzNss1RgX5ZjCWTwGrHvXO4BhL9+lSfyEbeoRvxrkaKV3GC8cqrs9KUfHcakJTkT4HvR/8w3l3/8neIteD+WEgB25bWEY/BePsb/ZsrNLCwn1PTJXYaIbU1ilrWPutuveYu4cNRpy3I444mretTtizIFHYgZAjeAdo+s+cJ7DpZ9vvJ6AlOpk5uCpl6U/c8me4IBRJctlp2YH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hneDynt5tkfg3Mqlu9ep7rj2g5VdYQwOGPLyJioUYjU=;
 b=CB8PwgXKLvfy3T+4YMBYW2PEX8SbX/Bx9TVcL2aMD8E5NK7Lw9LimcZSW0FLUK9J47Ym9XZ+ZM2hk+oyNC4n+RbgcuB054x5LAylxvgWMANSzEhwPBIgLKqdWHc69YvhQHY1LVZg9TogWWlG2vMd3eJE8nFut7dUuuG+GJ5+Odw2rD6Ed3nhiCY/jE0RjMRpE/ltdBMDPSNIjp7dnkWuFednEivahQyTc3Ajf58W+Crv+++dnJLwzFFUxAPDQJYb0YbwZ+FAMBqm/bfAF58dBubclzPsMWhmvJuwwe3Kd5DcbCM0wY85LlSdBtIiwebCYBsoHegz8DjV8bxBor/gBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hneDynt5tkfg3Mqlu9ep7rj2g5VdYQwOGPLyJioUYjU=;
 b=aWrJjaKU+go6RQXQ/9ruw1n+lOslGUJf+lQZ4SWNRfcaSSAKB5CSGIWhF7ovcGmmgt9ZcTSVveQMhzEDRr8ZngqmInvgeFXYJ6YT4Ol1ouPFEun2/8DkHO+Eo/x9xlrPCz+xJ+NEyZUq8HfrlQVhyYKrDok7o5geimdQ1DiClv4g+YAvlZig8HC9P8F1DDcVAu2OaEAmIBt7P+TDMxi332D/pT7ra3H+Yx8wjeOUy41FsZpTPQIeUS6L6lHMJPy+L5FdCUfKx8s0pkzvhzAYHcrLfkaGXvg5OQfxanQzSTiv4LTY5YyQbbFvflY+nC8+8MRwxMEhxmIc11koSwJovg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by DM6PR12MB4353.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 18:50:15 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 18:50:15 +0000
Message-ID: <8c9c8a05-46fb-4ef4-aafe-f65c4765cd6d@nvidia.com>
Date: Mon, 19 Oct 2026 21:50:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/15] devlink, mlx5: add init/fini ops for
 shared devlink
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
 rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com
References: <20261015185454.6332-1-przemyslaw.kitszel@intel.com>
 <20261015185454.6332-2-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20261015185454.6332-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To IA4PR12MB932075.namprd12.prod.outlook.com (2603:10b6:207:12d::15)
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: acf18da4-0730-4788-7988-08df2e11d08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|10067099003|18002099003|22082099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	B3t1EGJj9Hh/BKdeg5jtwSjK62igHC4PNvb/pZwHotQQhyefJXaUhhFZqdP+Cz5TtHpv4dK5cWiVtix5AM92G2gR9cg8UFlbX+dgLTB3grhkbp80qS+DTfYrwmUWtUreAliaoBcVHW/f9laNr/gEpGPNdoThYXR1i95rMDHvrC3NtvJHxL/Zw92OdAk99XmawpzoLpMlamHw8SjoX0PIyU8dlVRIt2WNazWRYRml4mtBuVpJbR9PxRYMM6LyQRKIHbrGn1b7VsMIsddwK9ymveMbBawljan2b6jZ6V2103e4y9E4JV6wTqACRo6h8km51Kkg5PglhkmIhmWIcZcNjoTL7TTO0PFCdBvi4sxeTWENxfaYPjqUU3Y4VIrxql7wauXenHFTFLi5De9bVGdgA+UOL1C6pWozhzXGaMoV12f8EjVyIG8HXY5pVa1rSn8TXmV4JrEYMB//590bGJfpXPuJDHGBtrxFi+Jbv6xT/imxcnzGGZzKmsJepjJ7hXpp0RlKjGXKi91c9F9F+/4bubUSj7Uc65K+ZOuVPv/a4U/EdWfx9PcjG5t9CLPqxeg7bhGvEIUVWq2QUzgaXsUkPLSCpTS3gJutZiRtRdy9QSy454unRRBx7+VGQxa3I3wXkS/CSFMr+UB13qGBxJ0iNUNBeO7sUR96yxfyq6xD+Fc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnlSSVFOVjhJWU1LZFlwcjlzYytnY1J5UHQrRWFXclhmcWVmcmdKWHJ0bnNQ?=
 =?utf-8?B?aDU3d1kwZXdzbTRZY25Qbk90SktDNkJhdGI5WjNBb1hrQndKQnNBa0w1NEpD?=
 =?utf-8?B?bmJkTFhuYngrOU01RUtMblJrOVRwSzF1TDRTOWRNcEhZMWZkSmFYbjdJZnlH?=
 =?utf-8?B?UVVwbVVmVnczaktBdE1IR2Q1UktraXh1S29Ic0t5dHdOTThiMGdDT1pFeGtU?=
 =?utf-8?B?cXdXdlhxNzhRckI5N1lVaDRqWnFzWHMvclAvemYxT1luaGlYSEttOE5qMXlj?=
 =?utf-8?B?K01LVXlzSFpsUk83MjhNRHVhc09CQ1EwNUJORFdkaTU3SkFqdGM1OGQ5cHRs?=
 =?utf-8?B?YzVJbXhEaDROODFrenB6aUl5Z1NWWFhSb2FoMGxqa0MrR1pESFBGeERCNm44?=
 =?utf-8?B?ajBBdy8vSllGbnVwcVdrMGZjRnRCR0NFNnAvNGJ1WDIvbUxFU1djVUdXUkhD?=
 =?utf-8?B?RytMMVBtb2ZsMTV6NlhRdlpCMUV1bHR6M1FsbUgrb3Q5eWdCamFvSFRxaUJj?=
 =?utf-8?B?bWdnVzdsQkNJRkpHd3UzVzRlcjd1RWwzeTFETUwzMDk0Znlta0M4NkNIV3gv?=
 =?utf-8?B?cXFhSThSMlZXNkN5OWRscFJsSkkvRXBNeWpiVnRiZkJoNkk1d01UbVV6clZE?=
 =?utf-8?B?NC9NU2xGcHVmaVgydWlaaVdoc0w0OENubEdobVN1NjVmZmJJRUdDR3Y1NE40?=
 =?utf-8?B?c1ArNjVIcTdRUmpiWGRKWWtjaTJ5WVYvVG84cER1eGZVK1ZZaEVjeWJGT0Ev?=
 =?utf-8?B?ZUltREtjOHVQWkV4emhxTjB1UTV5b240QjhkREUvTEpENllaNkhacFF3Y0dG?=
 =?utf-8?B?N21sWG84dnJrRG1CM0h2N0VHa3IyUHZGY3VieXJmWW1CRS80bENhRDFMMG43?=
 =?utf-8?B?WFBJdXRTaVhEMDZ4REx6YVNwcFZTTFJnVzVvcklDb1dYN0M0TzNpZm0yWGxr?=
 =?utf-8?B?bDU5czMwL2hQa0Y5ZDl2QTZGREwzeFd2bVVlSVFmcHlRRWVtUVQ0M08xeWxr?=
 =?utf-8?B?QTkvNGhCSFhYVEdNY3lmWlBWL3AyelRCRll0L2RvaDZ4Nm83YmhHT2hjZ1hp?=
 =?utf-8?B?WDZhK3J0dFYvNkMrdXFNZkIrbEcySXVWbzRPSVNvdjRmMEtkTlcvbE5taGp6?=
 =?utf-8?B?dWFScE92cDN4aXlzOC9IeWljTHpWd2F6KzJoZDlGOUxvL1Q4TWIxRTUyVHNJ?=
 =?utf-8?B?bll6QmpyaUhNTnRzSk91ZE9OdTNqVmRjK3JxWFRPaVFVbm84YS93N0NuclFY?=
 =?utf-8?B?V1Z1VVdhS00vRVZQUEtTZFg3aE5uZ29EYWFVb1I5WE9WdkE4N3FMWjFQM0Vi?=
 =?utf-8?B?OGF0YUI0a21JZGdqdU9QRUcrU1NTaWMxamVOK2JQUjZXNG81UEkyQlppSEp4?=
 =?utf-8?B?UU1iQkx3RlhBcU9NYlBhSkFOQmlsOEh3MjYzaXBCalcwbktLUnJxN1ozbGNz?=
 =?utf-8?B?OTNoSzdKT0JRR0RTVmFtWmdCUThYRll6WUFka0t0VWhBMmdoZWlaTTYwR2M3?=
 =?utf-8?B?bW9VTkJramJnY2d5czlGaE0vQ2JBdDdPS1JYWFFlbXNNelBFbDFqdjJTOFJR?=
 =?utf-8?B?cUxzYjhxZUROSDYyZmJKdlc1U1R0QzgwS3h1WjF1b1lrRVFPVTJYdmxNRlNj?=
 =?utf-8?B?N3pkMkpUekdtN0V4aGlMM3gwa1J2amRrRHJJZW1BN1duL01mUjRjMWlvZm54?=
 =?utf-8?B?a2ltOGF2aEl4bzhxYk9ibXhKb0pRR2pvd3Q1M2hTTmQwVUpXUDJDU0tDU2Nt?=
 =?utf-8?B?N1VJWTZCd29iTEpkRUZOaXRzV2NIZlVVRzZJWmU0UFZpUXFUMFhCM2lkSFZp?=
 =?utf-8?B?bVdkdHRtbkplcW5BbUhMbFhFU0oreXFwMFpDZ3RKOEFNWnNrQWVvY0c2a0Fv?=
 =?utf-8?B?QUk0Q3NxQ2Uzbk9BNlova0tGQWJzVEUvZERVNmg5VmdQQ3FTQlBPZnZTMEor?=
 =?utf-8?B?SUJvSTRkcUJSWVJHVFRiU09uOG42RVF3QkxZQ3lJOWNlUzdZbHpFS2UxR2hU?=
 =?utf-8?B?L1JkNng5K0taOFg0Sis5Y0pPZjBUZUc3Q1hmVTE1K2pMakYzdjFoU25Rb1FD?=
 =?utf-8?B?M1JTUmF3eWc4eStVOWhzQ0FVQm1yN2xiRmkza04xUE1GU29SVHlmM2NMWEJR?=
 =?utf-8?B?UlN6OEV5emZiS2lQZTB2cXVYb2RrOVFBUThzWXhxVTBmY0VnM2c1emluTGJP?=
 =?utf-8?B?Wk1hUEQ3RnM1MW9qYStGaDVraUxqZ0ZEOVZ5aHJyZGt5TFMyazdndS9zVWtJ?=
 =?utf-8?B?Yk96NmdTU1JEK25ZMzRXb2J5a25pZ2FYcFY2bDBmZHNYSGVUT2NRenVQNER0?=
 =?utf-8?B?d0lvMTE2MTJIcEtoUWkvVmoybnQ4Rk1Ld1p5U2dJaUVOc0xDaFh0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf18da4-0730-4788-7988-08df2e11d08c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 18:50:15.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7f4prS+oj2V++AXIxrm+ukKD2R/NjUzVDcTgHH2+JidXtn+rodl8lJC+eCmQBIeHWUVxfcwUVW9LO+LZzZ71w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353



On 15/10/2026 21:51, Przemek Kitszel wrote:
> Add .shd_init() and .shd_fini() ops, that will be called for the first
> devlink_shd_get() (to initialize driver's priv data) and on the last
> devlink_shd_put() (to allow for the cleanup). Both ops are optional.
> 
> .shd_init() could return an error, which will stop creation of shd
> instance. The initializer also gets an additional, optional param,
> that driver could use for any needs.
> 
> devlink_shd_get() now returns ERR_PTR() on failure instead of NULL, so
> the error from .shd_init() reaches the caller. Adjust mlx5, the only
> user, to that and to the new param.
> 
> If any of the callbacks will need to get devlink instance, it could
> be accessed by shd_priv_to_devlink().
> 
> Both callbacks are called with devl_lock held, .shd_init() before
> devlink is registered, .shd_fini() after it is unregistered.
> 
> Next commit will make use of the callbacks, a later one will make use
> also of the additional param.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> (v0) first discussed at:
> https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com
> 

Acked-by: Tariq Toukan <tariqt@nvidia.com>

For the mlx5 part.

