Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03526461F;
	Tue, 15 Sep 2026 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516532; cv=fail; b=I2lq1vHoQMwVC1D6rSeRI/BfUgGGXomOR2abwTX6/47z4U4au1o6lNA8MCMywuoUVwwhJrUOHN3X5Sgpbyry1gi8UtTQDKg7P+B513JbNf1JESgkEO8mFrkB/eaI/N68Gdfd7str6ohJqqOvdOCy6v6EKf1+zwOS0R+whsB8vhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516532; c=relaxed/simple;
	bh=tkakpEnaftUJyVDt64/i+36yHusMP3Ln5yjlNZce1n4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hNewu8xLMTNbV2d8zpqkETVG6DM+fK8IzrwM3Ak4/Glpi6SzR/wrVwtiA7Ztqgrw1ktsIsEXW06nRZpns77dXsyUrGDbzaEwDWF4A2YgSva/Ul79fOhlA122IekVk0fiwEC4k8J7n6qsUvPXmNv6bqWtvjVKmsXWfEkJqEiP4Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9HGT6jy; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9HGT6jy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789516531; x=1821052531;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tkakpEnaftUJyVDt64/i+36yHusMP3Ln5yjlNZce1n4=;
  b=A9HGT6jyIy0GIkhwQE1lmYdQzwn1b9QrbgKcWRipCkZKNGAAXNMShZ7n
   c+ssDnEOKZO5gsUkrLWXc4M63INYZomJ5aID7y1fXq6D/s2WWCtH1qW1P
   BXK2Eyy45PN1NvdzwcbNEeqYC6J87om9/ckxRf3ZKNSQHdCDTHtkqGGic
   H862OZc0v10r1akRUtz7AfPJ0FPWkQljjJ0dt6bDwjTmo0HJrCRJWgIjG
   DwU7dGRVmB4X6rxTVtezRL6Z6c9Q0sVy56oV62aF+BtlQtKR8M/BEoCdo
   HpFFZhwH1cnN1ZU6n3TTIzm+X0mMsWT8q+ODDIPwEVNUmDl9hc4qE/BWV
   g==;
X-CSE-ConnectionGUID: QF+DGhz4RtK6mj8/QtBtxg==
X-CSE-MsgGUID: pMWrJWpwROGqTX5ZnuWIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="400667"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="400667"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:55:30 -0700
X-CSE-ConnectionGUID: EHAu0B5KQ6iTiilz/RCYXA==
X-CSE-MsgGUID: MsnGek1ySnCCTiiXFnynBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276689497"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:55:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:55:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 16:55:29 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHATYRXbfLOthXGCLlY0nuVO2K2fN79ZdNjb2YAWzAHBjBILQOLuxw3TDnJufpWvpokg9tyAOiOEsWmJGDA7IvLubXVODqP00I+Hwail5BDfptifiwBld1GBzlVO0GkyhegGY6EZDOiEuzT2uj+4yU8ZSbRSC76vhQsxpfvco6/pgsCZ8LWK4wUrPGl8mwvUgghREr4cuQjkAXqwC6t/NsWDkl4YteU1S3es6db2w5GP+NjYyIeoEeCVCpAFYdz0qKRJeFN25laRVA0RhvNqploZ1Chfu7h+WMhUQaZI4CsfLjLH0Mtr8qnKLI6+RVXwgrS79Q8HpM/b1/GpejIQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI2+ZlU9066dHulHWYt9XreHT9fXU0VelE83UTwFK2Y=;
 b=UkagYv7CY9wUjNfopaw/N9Dd+vLZl+663+p9oAgaidjXuAnZsMbxxn3jcNgXsrqP8J4lib14se+Y8X0J3ldip+tSsjJO3nmJwrOrqHLYQJSEpVphbP8f8EaCnclEHz/GDJ4qHOADq1a+gYXfzxCHJme46d3vHbUcWaLn5uHgtp19gKLydcAGe0KPhEFCKfoTJLEFGn8qIYugb7LEr+3EZvq+1YTf8PAJx26Z48DfZnmd+WFebr3T5klK7AELfVwT6PjSWiy0x1cuL21IkC37TpwgpNtiBkLHlTgYuJ9kGC1rdWqAE7oqV9wq+i1ONm1LZhEx9vX4DjB3vztMvUDa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 23:55:21 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 23:55:21 +0000
Message-ID: <e942fc27-3179-42cc-83ca-d05393530136@intel.com>
Date: Tue, 15 Sep 2026 16:55:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: prestera: return error on hash table init failure
To: Elad Nachman <enachman@marvell.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yevhen.orlov@plvision.eu>, <taras.chornyi@plvision.eu>,
	<oleksandr.mazur@plvision.eu>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Dan Carpenter <error27@gmail.com>
References: <20260914112026.2822222-1-enachman@marvell.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260914112026.2822222-1-enachman@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3881f393-a0c4-42fd-8f5d-08df1384cd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: rmpUV9fyMyoxGN3vBeekTJmvS2B3AzLbH+l53frvdooJDauZEPaR2/AfcYZAkPlZcg/kcEbcM2AoaYpn5hYCp2lMpUZen87keUUPQYp9Nw0AgpCiYwuuSUvDl1l9nhp9DP10nHXTss+x17FCazWSlhXvnPDxNeq85ejyQ/s80hyovI+Wx+Em0TSeeUD/yNm3iaKqf5IDTj4r9ZP/J6/IM16+SmZIARvhp5drKW4h29SPkFp/FDZwrRPSgGr8VFxOl0xpR1zN+CRjKI1sB1YvvUfFT9pTLciwpxj7nqhlgcxNOcaeufjW99hDnHPMGKC3XuppySBopPcBas/50n4PihMTn4V2ASE1mTfLojPqI8lOJZx6CQhu6JZH5rM6pqaNGA0Metd7xxsnQO8MgyF6YaCdckgQzHcO2bbBg7A3nkLkzDAguCgKDj+rpFtBmp8Jsc2znv/nEPpJ0dINRE/TDjqNFlwLdHPdX8kqr1Uv7W5XmZ7ACO8uZngLGRO5EPAhQPyvcDGQaNUVwfIWJmrpIzRXDZjAAZ+TBCKGoBMnESjCdUsIro9QqRbDcb6o6SWoV0hObiRnyYKO3qxchSEDfhT9tTfqlMQFMJCQwdJxmvvVSsmQJvgwNSRX6ID76CoHxsLCugiJ0PrVK95jV/RL5h5l330Rb6X6pLvapNqMyL/D362Lk0VrSYRB/XvSuLf5eaSlPTjZFC12fifuad9Ylw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZlVWtOSVBVclJWTVJVNmxxWGd2YitSZUYwTzBldUF0VEplZElkeUUvWG9j?=
 =?utf-8?B?VmwyeU5hb3Q0U3I0bFBsTkRUd01YV05wV3dZTE5GQStqc3BqcTNzMmY1ZjJQ?=
 =?utf-8?B?Y2hndmhhNTVQN1BYTGhMMHdNOUtoakRhY204RnhnL3M5c1R2ejZHOU5mck1o?=
 =?utf-8?B?WWhqblZYeDhLQmY1a3MzSzVXSE1aWlNacm15bXMwVnJyM3dKZ24vMEVUbmF5?=
 =?utf-8?B?L1NCV2tQVjI3UU9JajJxMmJNbkx0WEdCdGQzeE10UnFPZ1NMSTRCeTVBd2ZE?=
 =?utf-8?B?TVhMWnlOZFR4YnU5ZFdSMWpPM2hoK3lwR0tRbkxQb1N4S2VMZ0R4WFR6cmxE?=
 =?utf-8?B?Yi9TUmRqN3Q0NkpMMkorQXZ5aytOclFNbVk0LzVnNWF3RHFiaVRpaXZwV0g2?=
 =?utf-8?B?Q1M5STNpNFhRRkNab3BVamZqY29NNVJLTVZuU090ZDQ2a0FGQm9pYmdSZjZP?=
 =?utf-8?B?WnM2a2JUWk9kUkh1Qm1XZ1pDSkJKSWJOWXZ6YmpaMkZMYzdmbWFXZzVjdlk5?=
 =?utf-8?B?NWxUV0xOSUJ1ZUplazk1MXJ1UFZwRHdwVTlVVUJPbkpUMkVweVE0M2U4THJH?=
 =?utf-8?B?emhuQVRhaUJWSDVGWTg2aHVEbStqM3d6L1YwUEVzRHoyLzVKaDBNNE00aUpV?=
 =?utf-8?B?QUZ0ZXpySTIzbWdST04rNVdhS09NZ045TmdpOUFCZXdjSU9QWlFTYjd2WUI2?=
 =?utf-8?B?QmFVVWlTeUZjeFRvVFlIMGZBd1V0RUZyVWt0Qlh5dDZvRjAwNjFxT29kb2l6?=
 =?utf-8?B?anBTRm54USs5V1pQQkx5b2xiVGc4aGdUQTk5NlI1RWcxdExFQUdYeW0yQ1ZN?=
 =?utf-8?B?clNsWUxvUnp3ZGZSY0dkZkpjL2crbFFRMmV1UXB3Q3c2NmFJd2ZTa3FuRUts?=
 =?utf-8?B?bTZ0WUpwVjg4MjQycXo2QWpHcWtxaGpnYytXdWRBYkw2NGNXNjVSdWJGZ0dF?=
 =?utf-8?B?V05WenhvQUREcU9DZUd4YlVoZUFqYmNKYXYvWU4vdzZCU0QzRlB0ejZ6aVM2?=
 =?utf-8?B?UC9mK0JqZlFya0R2OTVzajE3NEVGY1diRTJMSXFWc1FvVVVxMWZzeU9CMmNs?=
 =?utf-8?B?RVZpSXgrZExKaGY3bXROcVNQVFNUN0o3dFhVS0VCM2N2a2k1THpicjExSmZp?=
 =?utf-8?B?aWg2V0VrVXZvM3dMSnVhR2JScm93NG82QlBRYW1oSlhTeThDc1ZJdGxuK1dF?=
 =?utf-8?B?R1BvZmVBNnp3ZzNFOGYzMjRIR2svdnZ4bEEwazBjWDFGanpFbWc0Z2tEc2sx?=
 =?utf-8?B?WHBVOEtrblZzSmRwYzFrUFc2eWpXbFBtMSs5TWovTjV3QzhHZXJQUVp6WE1P?=
 =?utf-8?B?dzBQQzViVW14KzNidlhjS0U2NUcvU2hDKytnRGsxOGdoQmRGQkxGTjFsVmxk?=
 =?utf-8?B?bWl4Tm9CRjhYSlBORCs1Mm5aMjFBRldId0xNdVF2cE10UnN6SWxweHJCNzZx?=
 =?utf-8?B?OFc4YlU3MHNpaHR4R2QrTTRLdDZZd3ozTVJIZEdQVC82WkpYWThxZ0RXZWZY?=
 =?utf-8?B?N0V1YU5TcEM2RGV0UzYwY2k4elZnYmRDZ2FLV2NWWEtpRmZDZmhJYzVCU2Vj?=
 =?utf-8?B?WHZtRTVtRW05N2FQWnMxV3g5OTQrRjBEZ0RTU25qUkJzc3JVUFZoa24wRVBx?=
 =?utf-8?B?NXNZVmZPYUR6Y3ZnQ3Z1UnpnaXNDZlBiZ1gzQ2FacncwNjFYb3ZaL3pWTmJV?=
 =?utf-8?B?cHhHS0pobENCL1VTa3I1anpFOU9EcGlMVEhFS2g5U2E4ZCsxYnJkcEtvWkV1?=
 =?utf-8?B?ZHdBTzJrTU16Z0l1bFdMVEZEOGtVR3VaMkhqMTVNVzJCZEhHL1VJZVpTMThO?=
 =?utf-8?B?aWJwRWwyN0t1R1pxVUJ0R3BJc1c4T1RGME5Yazg5T0o3bVhKcG9Nb0NDSEp3?=
 =?utf-8?B?R0FIbnlGL2RNOCtYL1MzZUNON25FNlRPNEk2ZEhHNGxJOEhVa25KSUdYV2lG?=
 =?utf-8?B?b1dYSHh3Y1AyOGVRTzcwblZCb1hlN0tJbmpzSm5TejBOZFE3UDR0VHRuK0NQ?=
 =?utf-8?B?ZlZuNFFpN2gybU1ZL29ISFlsSGNtQnIwSGF2N2RDSXIwV1hhVUtTaXFma3Q3?=
 =?utf-8?B?WDBXNExxaForRjhXTXBFdFVPanoyZFdsemZqcHV5eklET3NDeDg2b2dwNWxk?=
 =?utf-8?B?VTZqTSt4NzlwUDAxV0xZaWExdlMwcU51bGJnUzFaVy9CaXUxVHVocTBpOUFV?=
 =?utf-8?B?QXpGaUFKdTlIOHNuQUFYSkZuUHc5WjQvYkwwNkFsSmRZL1k0cWdtUGFnR0Ra?=
 =?utf-8?B?Z0pwN0s0cnJGQ05RUXNSbkozRVFNMFBCYlFZcE9MblIzMkdzSlpDbzFHcUFH?=
 =?utf-8?B?S0pxYlhqei8xWGhrY1dUZzk0TS9OUjJjV1M3UzE3WVRwdzVmbmhlQT09?=
X-Exchange-RoutingPolicyChecked: vAMR+r3p1J9XHKnd6tr2TPmEUlg7pXeQk+/U2HlHiwlj3XG61FQnPrOBjA4/FDhu5tsozUBLBUyi0ZtOOVk99m/kgW6bwOlnJQX9DOyGfokr66YWNR8BL+eLrqInQy8WxWFVfQxDFeJbBoiZzouXtOGt3WshMxaL16AyK/frn4yjNVWAv5IAwGvrrCcBkkiyRpTwTWEw5k7uxXyxWHkKh1pfZdA6JVYxiVpxAobrIFayXa+pSRcSavV0qF/7pb7hj6YLuR3I1jvX8Dqz+9XEpMuw3yrJtzeHRrGSRoDiM92aodArRskCTLSG5KTIkKpo3eXwGiQQbcJHLtAFlvB0DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3881f393-a0c4-42fd-8f5d-08df1384cd65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 23:55:21.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VveZprl0luQNZ6VYDhMeWsK7ry3x/bxtTUFxepvvcUaZAU6kVOtdEEkNVW1NrJ8ckfBY1KxcvgZyTgcV6vpYWtNCZduQf9YMdngNfvgQ8IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

On 9/14/2026 4:20 AM, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> prestera_router_hw_init() calls rhashtable_destroy() on error but then
> still returns success. This causes prestera_router_init() to continue
> without error, going through line 1623, and call
> prestera_router_hw_fini(sw), which will cause dereferencing of freed memory
> 'sw->router->nexthop_group_ht.tbl' at line 1560.
> 
> Fixes: 0a23ae237171 ("net: marvell: prestera: Add router nexthops ABI")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/kernel-janitors/aqT9h61WBcslE0gJ@stanley.mountain
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_router_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> index ccf6cf98920f..4785fcb62735 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
> @@ -93,7 +93,7 @@ int prestera_router_hw_init(struct prestera_switch *sw)
>  err_nexthop_grp_ht_init:
>  	rhashtable_destroy(&sw->router->nh_neigh_ht);
>  err_nh_neigh_ht_init:
> -	return 0;
> +	return err;
>  }
>  

It looks like this snuck in because the original
prestera_router_hw_init() implementation didn't have any failure path
and always returned 0. Then commit 0a23ae237171 ("net: marvell:
prestera: Add router nexthops ABI") added some errors with handling but
did not report the error. Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  void prestera_router_hw_fini(struct prestera_switch *sw)

