Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068730EF97;
	Wed, 14 Oct 2026 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012113; cv=fail; b=arudILrX5FLs70AhwO+b03I+yjQYTRthvngAn4uVskXAqLzHJbZdaR2+Uo8Hrn/tmqQKSP5jy9DEQYPLCWAhy/9n1hj6Zh2+QM259jVqEufB/n3jsTRuxsJjLGefvIyu04o1lnBlx70HjetmIuwqRzw8JdfEbf1FpKi3oZ5NHDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012113; c=relaxed/simple;
	bh=y5B/04zW5KG1jGhJZwQB387FePaJrdI3JCIlwDcE2kA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bG+ihSdaDlUxQ0r9rYb7MInBkReY2P57S3l1MMVsljxCQOlC39Cr7SuDrIu58n4e3vjGVL/Fi7aA4+/Rr2ikuKduofBUevwsoEwkPnK2SBjKPkEBRoeYAJzFfycIMpDEWRXeOjlppQo8Qlc1A3+ZydkEogF6ASLegAoMUy8PcEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DD1j/25v; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DD1j/25v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792012112; x=1823548112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5B/04zW5KG1jGhJZwQB387FePaJrdI3JCIlwDcE2kA=;
  b=DD1j/25vk7sY+EbGwSLgrDXAOEXzpkanQYfoH6Idt33cTM6RsYnU0Xhx
   jFVK1xmo9OBp/i5On7W87QNsbQeml7bdLjVREvG4K8+pr8t8Hv0Zii6Q9
   SEyueC9vYQWSK5Jqq9EIjxqUPu7vfEGplfwGbMlD/Qbwm8nxwtlDS6jNH
   UhrwUsTbUMdsozZIivSI7AHZ68s25P8hQx/PUUEmNp81ImmonDSFI21YU
   vbLVOOr4sG7DhPsReAmikEUs0YqoKPRM29HeC3ZjoaicgS+QzciC18RNW
   JiErB9a7iyvFbs8C+VegJY99QRj9m1Kgll6nApRk9BpxorP/hE6e3Jegv
   w==;
X-CSE-ConnectionGUID: iB2cXPG0Sx6MQilcQ4vdfg==
X-CSE-MsgGUID: wBmLUeboQ5KIV4xtc1kRCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767096"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767096"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:08:32 -0700
X-CSE-ConnectionGUID: ptSWGm1XR2+yZ0jV7RuJ/g==
X-CSE-MsgGUID: VtQZwT64SvCdHNsCzyqX5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1880244"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:08:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:08:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:08:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQDm3c5iOKZ5eK7ddOIrHNDi9/wLmcvNe5zYyrGRZvm7LpdVoCKTUidyNR9L955ux9TgiQVcI4CxSH5eatxT8+S9uLC+fBZhGc0Y3dmiglsyeqbJLmD4MCI1lky7hS1H/VbrAX58RpNiMm5uQbXemmkKE+7/JzClbyxrRnfT29R7CdF7f5aqP8gpxnbkYA87q22xnJ37BKkiXLJnpwUhiuqDnKNqMNh90ts2KyeX4fq5+rZvaNUudlkQALnPU16lVMEHU/6n0KzhdDH7Xk+VCkYdHtUXryMCcfykEOVXbXfMw2isLnaJS6QxUYBv7jYRBE2dc7G00n/MJVFAc38o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjx+qEyCK6zdoMDnL8rY2I3Y6NyD9IYAYvMuWzbE2uI=;
 b=lnPQvp6FxtHBoav5Jefq70Yk2RVHsnOz0K8a6YvA2pG5wMuiw9p6zjQHBs1nj9gopwvKmVBoUyEFiLst+fT3nI+w32BKQQG4SwrRGIkJf8kJEWRggsAHO5/O3lNaPgozwh7uZe9V8t/BO97+Fs4nQlvWsU/zqJ27hOaCbBr9nci/nMiMcvAE5bt4tGdisnVQfPDE3svojHxrJGAe5SYZBqefgYmXFRisd84QgllruqIkalPct76ZPXPB4+JfNnZYYeWPNlZN2Orwrxsj1zJPzq24DTcwHvLutyJGAR7Fs5a88t0CSJgaRqR8TqA+qvW3EEEn+aK5mioBX2qS4aasQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH8PR11MB9770.namprd11.prod.outlook.com (2603:10b6:510:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 14 Oct
 2026 21:08:27 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 21:08:27 +0000
Message-ID: <9086c9d4-d2d4-4ea0-91ce-5eb047dd931d@intel.com>
Date: Wed, 14 Oct 2026 14:08:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] e1000e: incorrect modified flag check in
 e1000_read_nvm_spt() (Bugzilla #221729)
To: Ruan Bahia <ruanmed@live.com>, <przemyslaw.kitszel@intel.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <CPDP284MB39374BC5A0CD11C9253CABF7C79D2@CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CPDP284MB39374BC5A0CD11C9253CABF7C79D2@CPDP284MB3937.BRAP284.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0307.namprd04.prod.outlook.com
 (2603:10b6:303:82::12) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH8PR11MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 0465c601-f33e-4120-4acc-08df2a374a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VPUKA+QpjW/zx3H3aBup3xcq84swrg7R5743jKGjIFXWBuMiqlKWNkm3Bdyt1FEM4vcbCg1WJN4XJ6cGjY0a0JZqDMjJ3NF6Cag3748cyP2lYBDmHg4X8nUtQBLhpU2MPLSRY3j2/jrSsInzhFQ2STuWlbbo3b1D/ERm0NDGFVSC3aal3x2mkcLXoFvmKMubhIKxluWcHD7RGiPmDdpxdX9Pf3Sa0P+qJeq5U1HK0v+Dh93/PkntbLQzNdubIC7IjhbbCiNqY9dHErug2lW+mrRwRGkbUaVdxvWJfz5W8pXIzYLXOF+zmCGdbiW6rVcTg2f8FQtX50Lu7Segf+esQazbu/hYGFznmV3eGADogLlBh5CJ3syw7USdPylA3z+LyY0dMczObBvPgYhWgvwCgaxQskqUmYydus1LFwu37vUb76UcCZWaZTB8VOe0FaQtQGJ4n153kJOG7LC+1ET8i73MvlLoe4Ky8Z4+ZnnUuQN/rsMXUVGjxRyrsDoOPiWNWhMBD7Spygjeitf5VAC5092z4btDmk3eGO6Kot7GKSFeP/ukduiHpro6ANfMT6HhWeQQYnuI9/lgsBX0N/kL9qjNy/fYyChHDZeO1xSRp7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFXdDdQcGlTUGd0WldwM0RHWTVhckFmQWRtb2wwdk1yaS9ERllrZ0Q3VFRW?=
 =?utf-8?B?K1BYNS9wd25lUEZaa1dzRldZVlVpZEMwZGk4c3RRNXlCMFp1UWpUZHY1b2RH?=
 =?utf-8?B?bHc2RmdoQlJhK0kwVVJGMkRYaFdtay92bUd3NUxTNDdHOFlWbldhVldrNFNG?=
 =?utf-8?B?WHJuVm8wUEdabXM0KzRVOVFXbGQ3YnhlVk5Vb1c3QWIreDl1REdhRVIzazdC?=
 =?utf-8?B?NjN2ZVBzc3F6UkZxc0NUUDM2ZzFwVlZwWW9TcHRYdXBSMEI1UjlKTkxYcjcr?=
 =?utf-8?B?VmUzWlR5SDdZWkdrRDArZVFSMjQ3U25PckUxZ1dScm1lcVhoYkFNYTVYNm96?=
 =?utf-8?B?OFUzamFsdXI0NUE1RTR2YlM0cjNqWk5rLy9yQ2Z2NHRld2VWemRpaTNCandB?=
 =?utf-8?B?YUlrdzFCOU81Y092dFB5MXNNRTliL2FCUUxKU2tIa09jZkduR2pGTWltZHFJ?=
 =?utf-8?B?SktGdjVWWU1BN250NW5MYUJVakg0WWl4eW9mYjNiUGp3UVV4MzVnODdXemVP?=
 =?utf-8?B?OVpKeExqaWdIOVdMSlFTY1poSVk2OGZyNzNSTHRjeHFSZEVxN3BZRkxwcHcz?=
 =?utf-8?B?SzRCaHVwYWtuQUp4MkdtU3RzdTAwNzkxU2hwQXMxZHNMVzlmWUg4TUJMVFls?=
 =?utf-8?B?UW5mazZhTHQ0ZDVjQUpISGVNSlBHTTJYMU9kQVJvTjlJT3RzcW9NUzZRNTdD?=
 =?utf-8?B?akdqaHJ4ZUhWM1NBREhTQlVML3NMdkF3ajdmUGR0d3RFRFlleGRJYUp2THcr?=
 =?utf-8?B?SzFPd0ZuTllYdWE5N3hNeU5wcldOOXY0Q0dpUllLMVpCYzVEWUwwemUyOW1k?=
 =?utf-8?B?MmZMdWJENlMwamhkUzAyYmFsZlBaeWZMWDdZZUEwTVlkZTBLRkc1RTU5Z2FH?=
 =?utf-8?B?dDJNRGhRQ0QybE54ZGd4YVpVMlpFVVVtUW9KYStCOUhzKzYvZlpKN25pTmk0?=
 =?utf-8?B?SUtJeWh5RFVhWHpVMSs5ZzRmZWdYMmk4WVVHZWo1aXB3aUxweThMSlZ2WGc0?=
 =?utf-8?B?eEl4ekYyalIvTUdzb1VmTFpZbkptWklMVjBTTGhRODR5ZVhKbkFUQTl4WmxO?=
 =?utf-8?B?Y1FNLzdRVmpIZzhWVktidzRFdDRjVStCV09NM3BGZVliU01lZHA3R3dyWDJD?=
 =?utf-8?B?UlpmL0NLSVUzcmNvZUY4VWtyQm9VVWtmSnNJczVrVmdsK0xFWmFLMXh1UW5u?=
 =?utf-8?B?RVAxY29SWjNPdE5Xb1pYS1dQNVZFY25XSHZreDNFVWtGRUJxZDRHcHh4dFlD?=
 =?utf-8?B?bUQxUzVRbGF3UHUxTlNadWhkUjJKeDRSbVhyaUQwT0kydDZoMStJeE0wN3Qr?=
 =?utf-8?B?djJuVzFrK1NCSUhNUkI4Q3g4ekRqZHVMNGlZVjVuQkx6d1pFdzREV3l5aTh6?=
 =?utf-8?B?ajNzYkg1T2xnenRROU5jbENRUkVvbXRUSTc2L1NnMzdHamFDQmF4QkU2anpJ?=
 =?utf-8?B?VTM0ZU1ZREUwZFlNZFJiYmpSV0p3YkZBNkFGY1hCUVZTVlhnM1ZiOFlCVXg1?=
 =?utf-8?B?OW91bEI5UXZWODRtR2NpUDVqVHgzVEJTT2xONDRKK3JZM3RpTy9WNXptODdk?=
 =?utf-8?B?eHEyZGMxZjdvamNPR2tvdzFMWE1rdzJBdlF4cUo1ZGlyZDZQSGJLYlRtWXNm?=
 =?utf-8?B?YVVZeENEVGMvRStKcWpneHE0YjFhY0RPQmwwQU9WQzA2UDltMnlabkwxWExK?=
 =?utf-8?B?MERBQ28xOFpoZlFxU0JnSVkrQjFSYktrYlRNRFFGUWRkb0toWkhyVVNOMW9v?=
 =?utf-8?B?dnM3WUMwaitUMjVzNWJxNm5nQTE5MEJZbXpwcG9ZaWVBSHR0aENLUXVZRlB2?=
 =?utf-8?B?K0RIakV1bk5laE5YZGw1bGVsNVJGSmR6T3ZLUDl3K2VtOERtcVo0M0pZbkRS?=
 =?utf-8?B?YXNXWkppNC9meEtNZWtKNitSUURPSWcwbk5MOU91NzRCTnJKK3NDeThuc0ZD?=
 =?utf-8?B?VDE5V1hjRUk2dlJ4cHY2bEY4NmNYZ0dEQzczeVYzM2dSMmlYOUNCRGNmY0Fu?=
 =?utf-8?B?NUNSeGdFdVJXbUpzNldUMDlmWnV4SnFlQ29BS3lMY2h5UFAyTFRlR3ZVWU1o?=
 =?utf-8?B?Zlo5UVFxVWo0OVZGMWFGYkIvRWh5SWw3RFYrT1crQ2w1eFNxR2gxM2s2RU1m?=
 =?utf-8?B?Z2NBUk5jdmRXRU5iakNTZEt4WVd1OXp6Zkp1TGJTa0dla1dIc1d2OHlrVk51?=
 =?utf-8?B?U3pPSDRWc01wN1VrY3lPck55UFgvc0dNbFJNeXF0R2Fyc1JvR2J4ZGpPbEZr?=
 =?utf-8?B?QTZ6dHBibkF6akMyZnB4aCtRaGY1K0Nsd2pCYlNLQjVJN0N6RG1FZGsyR3lN?=
 =?utf-8?B?SXpGU2s0K1RJa0RaMUN5N2JMMEpFU0thMmtFS1FzSG5nY3o1UFlQU042S283?=
 =?utf-8?Q?LP5W4wdS67xneQk8=3D?=
X-Exchange-RoutingPolicyChecked: nfgg8e+/WYKMwcPDTlgMmvNhre7jPg9kozo6vh7CPFga1+PQmNp2V7gyYhtlJ0KjIg0vWbirhFzDgpZv+Qnjwt3dwbVilHcVrAULYswW4vk6pldwIjk2giiOolK1MGGuoMYOfScebjHPpZ0c+vMcUi3mK2N2CsjBcSY4TwDIwPEBSZVO7qetKIf14/cUUQG1Kbdp6gyJ1wyO5+fpxlw8tCXVphADzGdle5TDA6CgT7keoDbercElY4xZFf71QF+vfhu81+m8SGLlPbKWV8SWrxpYq3QEXghPcG2Dd7Uma8WaO7Zdqp3TxQIBOaQysoNcjer24v3VSVDExYvRSLLtmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0465c601-f33e-4120-4acc-08df2a374a0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:08:26.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPlIPRL1+gTBmhSUHcuF6mXsKsqTsY3qsC5nIKFvwyaaHbGY2mHOoIRPJh5XL7PiDyrWGzdgnI4je5HVxFniogO56n28MYJT1Htku64kFos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9770
X-OriginatorOrg: intel.com



On 10/14/2026 10:47 AM, Ruan Bahia wrote:
> Hi Tony and Przemek,
> 
> I am writing to bring Bugzilla #221729 to your attention (reported there 
> in 2026-07-06 19:39), as it describes a logic bug in 
> e1000_read_nvm_spt() that can cause silent shadow RAM corruption on SPT+ 
> PCH chips.
> 
> A fix for this was recently submitted to the intel-wired-lan list by Ivy 
> Lopez. I wanted to ensure the Bugzilla ticket is linked to this 
> discussion for tracking purposes.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221729
> 
> Please let me know if any further information is needed from me.

Hi Ruan,

Thanks for the information. I've have it queued up; I'm waiting for room 
to send it. I'll let you know if anything else is needed.

Thanks,
Tony

> Thanks,
> 
> -- 
> Ruan Bahia

