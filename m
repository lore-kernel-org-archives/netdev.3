Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020115.outbound.protection.outlook.com [52.101.85.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1418CBE1
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769661; cv=fail; b=XlwQzdCd/weS67agFrLD50Om36LrAfrIZjxnlgD8spcaEHtmkNkFd6ywJeughZ3LRhGzcNLzoot4PouNod1wO0zU3eU37b61JWSrhxZ0rBAusEF/7aP/keOxFs8nsEsu22nInW222/znwZnjtGdE+Envrs5yeMOG/ie300a2QJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769661; c=relaxed/simple;
	bh=TlK3cibtd4/uYQxkyNuq7Ns5i+YYxD6GZqGzM8Cxtuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XnthNs1QGaxilKmTJVUUWxnzkzQoQPKsgxfB40UjcF7JuQkrYdx1drtZ5bmOtJYSZrBFid9Zv9ClllwJ7jfRNEOJfz4W0xc+i6kRJzcL04aNFj7P4i/HSFlPZcNMezJ/si8PetZd4ZZnJImBvmUAWFctEQlomK4qS0xnsjFmTDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=LU6cVRp+; arc=fail smtp.client-ip=52.101.85.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="LU6cVRp+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6+fQNy+RLx6sGtAi7oZ6+Rohn1ruXE5KhkLlqDsfSgXS6Kzd4cytrnw+9wLxBGgoM527ZUbUZWXLsxmKmmFjYQwwxEQh1oVSz2ikfiigZm8LYcKQZ4bK9HBti5GcpjwvXTM2cPxuh3ddnGllU/+l0cSK20y7dHR/9EZQSEePK/+IbsyvbkGUrN0ziqv3M97FX74UWQX3rJHf8pZpwOb5RcfhHUCQbgWLYWbh0O9LaVkudx05UapSven8dJ6GbimE13LSmO707Z5d7nduxjX3Qu+DzfK/R1cwtMwh8qdw97L3D2k1uiq/ufh/+Y1GEgNXOPqZNCA0RsuzVlxQOuqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j36PFqFgs0rnk1NbNise6N52ev+D4IokDFM+IRS8DgE=;
 b=FrM0lYu7GuJo6T3q9AXSkHqFQCzAUH0zhUqNOR0Ivr0GZhTjQAufZaiGoeZ8YSP8iYVDTaSxeiQEfeGDw7rQy57gPzQjHPPjmKdE7tpTqt3d6ye26CPf+qN2hnwvusGw9n4NgQUqTdvV6wgnBSRf91vVAmc04ygqMCR1ZvvcKGRhpl1hUklTbYg/NUDotZSBX46WtGmMHtdZIe5Ggv94RZVyP4BvnEWtxcuIE8O70Z+Fzti+y62e1D+u/DWS6qApILU4ycIVFeat485saxgS7b8gXxWHrlwLWigsGOukTgCXTHqBvF9jdpcvljVyXEHUYKF57XvTVNBkg6IXl2Hfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36PFqFgs0rnk1NbNise6N52ev+D4IokDFM+IRS8DgE=;
 b=LU6cVRp+/iQwhmLMKF6PUt1dVe/wwB8K4o3CwvSqtpQrJxOg5wUCTXPgPdFG5kZ5b69qVNyN3J22XNZz60o8+a8fTlOvFRC6YH7eOgn+ENKcuDSD/OCG6JlkIIccL1L8lwjJ6muuBYkP1Q/61yKnbxDUipkCpzmS+mEaTsG+lMRxytrIQIPNCFFPG1/0BoNjyKjnJb/OKjW3o3GGrFnFCjwpjqCpUPeTbUEFD1YYM555o9psaoYCc6gpmagxDeBQKPovQeT9+E7J+1uOBWc+8glg8Me0bPwJ3X2M8ZjBDzKf+D1Fw5Lu9uap5jWnGVIR7LsVZ/mOJePlEkzXw8bmnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 01:20:56 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 01:20:56 +0000
Message-ID: <6abf7cd9-d06c-41aa-bb6b-3a37112143b5@pa.msu.edu>
Date: Wed, 22 Jul 2026 21:20:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-1-nwhitehorn@pa.msu.edu>
 <20260721180158.13014-2-nwhitehorn@pa.msu.edu>
 <2d4f87ae-f1d1-46b8-9b51-047b1b8661ff@lunn.ch>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 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
In-Reply-To: <2d4f87ae-f1d1-46b8-9b51-047b1b8661ff@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::23) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b90b24-959e-4d17-e3ac-08dee858a558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|786006|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5wZYvZtf+vaNT1BpLyZTb43w+SGlTWxjYA0WDg4SOMZD7oTO3X7HpO0ShXQUAuzJ7dwYDV77HppEIkaG3dEirwA3fhd5wKTyGnbHYI5rEMXkjsdEcdmn0/VGo20cC+5ZG20sDwA1tXAgx5DMKyD6Er/QsS4upqIfmmIe8o4GWFC4ku4ReWEVFG2NqaUvfY/UhfraYykacAlwKQzIV0qmdktvib3f3pguxw3WQlXoEfq0EEz+2RKG7cNOf0EXEZGLSoOGGPzxzTAwZjiyBf6jjoYh40r9L7ARd3btOytXd8UfbvcuZ8+3EuJoK+6LCNRyZ56Pw5jFr7Zl41xbFfejR1Zt+RU4jS9MkH98S5zI9O+Yw2HJgewDcJ1jxGNrYPhCkx4ntb9+93fUV/NYOqN0RB8o6ftp1n4HNqfJ8l+EWipynNWONToR3lSh8/CsaR2SLgG7hbVnYq6/t35qsCengVKxeDSlA37eqCv3SEis4s/RyKebkZMf9747DpmUGFf2LzvSLm8hfgC+gvJunwUcqIw/2NQUMsAp47C5y13RT6oPN2xv8g472RpbmdmTbJmDhA0ULPK+g7LY2ZV/P0rBiU4e6AtZQB3iqNxSaFQyKtV+Yvf5/hGhY5xPLT5gaMZeABCRoUAj1Rm3sf5RMDXFbnRB00krYdDk7ZVvXTrYVhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(786006)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hOUVRSUGNlcUE5bGtSVmtHc0xqa0ZJM2t3MUd3b2pydWVEOElMMVB2YTN0?=
 =?utf-8?B?ZTYxZ0RTMFpXTWEyMXNqdUZKN05xZk9yNllTUldzMVZ3dnJOc1lQZXRWL0dQ?=
 =?utf-8?B?eGZGMmNoTEVpcUs5emdxMk9iTDR2NVlJMW5sRWZTbStYdjNYWkdYU3BEc1Ix?=
 =?utf-8?B?a0U0a2VnS2RuM3dzei9wem1MblIvUE9peVRSSG91cnFHNlhTZjhRblNGRGxn?=
 =?utf-8?B?SGNqOTVtLzh1Z1RrQjcwd2NGblVjeEJ5emsvZFgxNUNtWmJyMnNsVVhxUitN?=
 =?utf-8?B?aElvMWFtTjFJZ0hBVjl6N3FHVTNkbjNaNmJzOTFrSExKY0pST2hNSUdDcXlL?=
 =?utf-8?B?UFBDVk5tWnRCbmlDeDAvSVQ1VzZVak8rWEN1ckxvM1ZmeDZidnJNSXdYWU92?=
 =?utf-8?B?RnZmYUVlZEU1U21yc3FXTkVObW1Xbnp4OFFVdXR3TXkrK3RJeEdWWjEyN3JV?=
 =?utf-8?B?YW1nRW5xOEpONGdyUUhpcU5VNmlNRkRkMG1OMzZFcGhsdnJ2SnphVUEzSlpi?=
 =?utf-8?B?dTRlZ2M5am5iVDFQeFdKYmdiWlVzaEdsRlJOa2RlTE9LcFJXS3N2MCtUcnda?=
 =?utf-8?B?K0NOb0FCRWJaVlJJbm00OEtWaE9lQzRpRVNNNXRqYmNnMndhVm0rM2VKRlRU?=
 =?utf-8?B?czcrM0E5WjFrMnFsMkV3SGRJUlFJMkFvNlFoTG1ndWc2OHFqUTE1TTJqeUJt?=
 =?utf-8?B?a0pLWW51YUNNSVJ2dlY2aEZpMTJXRmNrNG50TytkWU5FZnZJMWxoQU9sT0Fl?=
 =?utf-8?B?SE1NeWxNZUdTSzR2ZXpTOFl6OG5Tc1Rvcm41bVoxK2RZT1R2M0doaFhCQ2JD?=
 =?utf-8?B?bjVYMnVPZ011YW1MUldxSEQwUFFzWUx6NXlxWE1zNHZJMEV0dUIyb2VsUmJa?=
 =?utf-8?B?bzc5WFRrRjdYMGZQWVNsT0JXQWhrVzROVU9iR1U2Tk9xUEtZSExkTjJhdFkw?=
 =?utf-8?B?U0JQN0YxajhVUVhzLy9QNkhXWDZHcTFXMmcyMll4THRSazdITjgrWVNsbEZx?=
 =?utf-8?B?NWpKZml3MTZ4YUFaMFJEWUpscjFseWFNU1pYZjZQT1Y2TnV0L3hGNGQ4OEQ5?=
 =?utf-8?B?MCswT0V6bFdpeXVERHFjdHZQdGtsQWVPSVlpN25wSlpaSjMvN0ZudVNQYjha?=
 =?utf-8?B?N1h5c0orVjBjanZZSGJKbUIxc3dJc25DcE1laG02UHh4ZVdZVWpJK2hVZ3VU?=
 =?utf-8?B?SkhCVUNMa0VsbXdhWGRPcWlOaVZ2UWpBZjlrNVJiVDJIazlKMHlQR09kSUp1?=
 =?utf-8?B?U0JsZFBUTTl0T0dHOGw3cElCaEVPeDNpcFFOQ3RlTXk0a1Nld2MyNDNYbkh4?=
 =?utf-8?B?NE1KY2JZNDd6dktucjYrZytUOVJPajQxN0hRa1F6d2d4K2JCM1NnSzNvYmdN?=
 =?utf-8?B?NW9icW5ZUURYZTFVZ2huNHgzQ1BpRy8rcHhLckkxdzNtaHpSeHc1clV3dUlB?=
 =?utf-8?B?NWwyb2tHNWI2VlZvVjVWWkx6U1dsK09iWjNVRytoZ2lVMWtPOGpFamdUS2Ev?=
 =?utf-8?B?dUtrdkdKeWFSUkZZVThjVnczWXdjWDRzempOYzBRNUNNWUdnWTlXRVJ5RU1w?=
 =?utf-8?B?MlpvblIvdUtGajZ4U2VMc2dGM3lMRXVGT2RjR0x2bEVYZVNqa3VMUTVGWmc3?=
 =?utf-8?B?SGtFMFk5NVA5V3RVK2xPK1RjR25JMkJvdDgwZFprTmhkL0xxNjRjSitrbmVy?=
 =?utf-8?B?SDlGL3hESmFkK1h0RzhxOXIrYlVVZy8wQ1dEMkl0NnI5eHo1K0xqbmc1eHUv?=
 =?utf-8?B?KzBSUlFQWWF3RENYQTNnVE5pcDNzTmpMcktFZm8zK244Ny96OEVPVGI3L3JL?=
 =?utf-8?B?NVpyT29VR0ViMnA4NGpTZzdQUTYvY2pWeFllR1pWbkZCK2p0UWVXTGRJSC84?=
 =?utf-8?B?eklKUUYvYzlkWkg2VWJxeUdEUFR3bXNGVWxBY3ZCbXBleitiNDdXM0VqeWJ1?=
 =?utf-8?B?SUFSTnRYaVBQdC84S1ZMRGJLTWNRWC80ZnpKb0piTkhULzduMDVMcGdJbG5n?=
 =?utf-8?B?VHh5Vko1Z01wcHdwenZIVmJZdXhSWll6T0xzU2ZsN2pjWEZYZEFQTC9nQ2dv?=
 =?utf-8?B?ZStBNjlLTnkyNW5nSVhTOHBDUG9JY0pmbFplNzFuYnFSeDNjZTVvV3BFUm9s?=
 =?utf-8?B?NjJnV043YkdjQjl2NlRncjFXTDVPUyszM1RBeHFwa09MUHlaTnl3ZmJzbVA0?=
 =?utf-8?B?aDQxZWUxa3lZRE5jY0NIckhZVkJpeUc1MkJ2Zi9GUVF4VGp3OE1NRjZuaUdC?=
 =?utf-8?B?YzJtcXdkRmFZTXFZUkp4Rk50Q0tKRjQ1UUlYaTMrY2xvUUtSOXJPQTREUy9U?=
 =?utf-8?B?ajdzRXYyN2MzaFljL2JwNnJFZFJOZ1hHOWl5blVac0ZXQVRGUEU4dU5FMGpZ?=
 =?utf-8?Q?wgckE3f1u8XtAQonktX+RNfkj12qK3fTZT83mbbCUG5SF?=
X-MS-Exchange-AntiSpam-MessageData-1: +/ZNUecU5bHHDw==
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b90b24-959e-4d17-e3ac-08dee858a558
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 01:20:56.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYXgP9yRMPire0jyFu8kIIp5TffHs+BoKtMtefNKFKBgLfEmh1aYdHFf7L4RP6Hn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365



On 7/22/26 21:19, Andrew Lunn wrote:
> On Tue, Jul 21, 2026 at 01:56:01PM -0400, Nathan Whitehorn wrote:
>> There is current support for signalling to software when this changes
>> via an interrupt etc.
> I _think_ there is a missing "no" in that sentence. Maybe the whole
> sentence needs a rethink?

Ack, indeed there is. Thank you for catching that. I'll wait another day 
or two for any other comments on the patches and then submit a v3 with a 
revised commit message.
-Nathan

>
> Otherwise the patch looks O.K.
>
>      Andrew
>
> ---
> pw-bot: cr

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


