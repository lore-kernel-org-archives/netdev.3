Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58D2BDC0F
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 00:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690954; cv=fail; b=stFoND8O8gV7KKeK7eXeHKiPI4efyGpPgpu2f/6Xfh1wSgRg4hy1YuhfvzL3FLSRKcY5XbDw+QnhuuPo9WwnuYECdzva7jcKFmZEZrWyAHjdNeQToclH/N+H/yMgglw9h+3cHf+gKVNAPPE1Fqx+HO67Bxirb8QAaHmJJXTdEK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690954; c=relaxed/simple;
	bh=8dTeHBR6qirmaTyImVdOL8/ZFFgb2TYq0Y9a/k97eDo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdurnbJ8UXKJeyBsQpg1PyCVoF8KbIna6pMN1ZU1tUUZM5TINXWO1OS30O+z1MdsiY5k0UWBqfFQa1edMHzgwcfv5uu283b+BgRrSPkWlS7JFulMlTdn7pG9+/IsEvuIQrdtoLpQ3vBd7jFGfGSO1ltS1jY4FM1/gJzthQ1mxHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aA6wpeW0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aA6wpeW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789690951; x=1821226951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8dTeHBR6qirmaTyImVdOL8/ZFFgb2TYq0Y9a/k97eDo=;
  b=aA6wpeW0hOylRep52Z0Pgd8bl3A0uVDx5I9+SxmMreSHI1Ud8YJ87FY4
   X1PLjuK8ua1k6KoFKu/kb5twDMMTQMq3brYbuGX4vxsNwJdaWVpFw36b8
   1NEFxV6c8Ga0vKKClwXkd7SJqG2DtYF45Q2OOLy2NFx8vvk8eLDGuyFSY
   F9jYArzYwvnniySTVH/nvEJz0ZjfokawFgIsrDoOSiU07r9sZ2F/Tys9k
   RZSNlBxM4pAXlBORPFHteSueupChiij16JdCxd+tkb59NWzi5zoeqwU/P
   kkLAGTBZWDapdEpvgv6JQG+g9T48CYoOUYcr1QdXX1XafsDEk0BNBNInU
   w==;
X-CSE-ConnectionGUID: GjuZuiyQRhGSVuwSjDvQQA==
X-CSE-MsgGUID: FP9iDvQYTZmCXH3To29n/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90298451"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90298451"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 17:22:28 -0700
X-CSE-ConnectionGUID: eNm9RpsoTKuh6WQlmnLNQw==
X-CSE-MsgGUID: oqIGZ+MdS0e5XLtnZ7g9/A==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 17:22:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:22:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 17:22:25 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMBs/zmXb7kFeuA5SyultqEddTR8HXsOkS+hMEoAB9Vn/olZcja6/L8LZPJdw0S8wofQ4HWUJ7PVhHaXtgauaBahXNx5ekqt83RiLKhMlNStyseICPOL0sCulg8HVzaun8a+sIjh2lMATOddcCVyKeFcCPbKfJ2tYyHhy/Adfub5CM1K/fSw4GU5+SMQmeZtQ1WW0IzMlwWokH7qf+Hb5FB/QR6597jTlz/sL9WvEFNHT+uqPO8ASCtWXNTORVnXq/FnILDGuM96gDmCwOCTBcCWNG86tW2lVYR4/CEKqeTI0GjJWZkdjKbcKLIp425Wp05EPY91KETl+e4Hchffzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExFAhwNJ9pyYkz9g+2nrld6rWhlZM0/AndGMVZ+/JF0=;
 b=kWPaI2tDD4tyYYvdSeuJ8a9E8Ix+x2Fa+2XgtWu+1f2vKg8csjHcx8s+zDOlBER5hdPvHDSoeRy9tIpvh1LozlFZmpdSP5kXegU4YItrM4ozoTcOsnJkRXAO9uwmUTk3j46oFkUA+7KCFbnlqDKftID+pS1ADR7xBS0JWJZj8pUTzDplYe8trlzI8ILbfBMYyBy+EpqirAdoeROzqSS7puFEvGwzonnG/23cn5db/Ur5qEuTbojdB2lXgLEmktmeEZVGgDanJPC78JRi1tzppCxAPLTP8Cbe231tAICNOmdufo3JVVgXFLEdHq1la/ZGH69QoyTlKKKHiY2uaBnUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 00:22:18 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 00:22:17 +0000
Message-ID: <71ff4ab4-b282-4cff-8cc2-47f3e920d86d@intel.com>
Date: Thu, 17 Sep 2026 17:22:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 02/15] ice: fix removal of PTP timestamp tracker
 during reset
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-3-anthony.l.nguyen@intel.com>
 <20260916011213.1632286-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011213.1632286-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6def14f4-4826-4fde-711e-08df151ae5ab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|4143699003|10067099003|56012099006|18002099003|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: m0SKSsmV3u08cwxD+VOubi2TR9nQWkb1YrH5pZuBQmNocAV1ft26osKVsvuU8yLrHAUc7XH5i7dHcC04+CwxajflAyefDQUrGZrzHPVIGCvhEJJeWGNZkgQU5NI/sxZDchgJoNMENBplhVqrXJGSqizDs75r39Pg0NYo8eEaE707IdLwzHd3QG05Jk7KEfzuBugVtdXaDPzwqF0XPsXpdlV4JSD+y6jmVId9RJE6y2KoyDsEGcf//8vbnLzPF+BnX++58ccWUJNj5krGB/eNzgGeYTee+K/v0MRWgPMUSUZChUOohwIQ065Y0PjB9OwJJ1Q7VY/fofb9pu0wqmeFf4QM4NbI9I7iBJS7cyjq4AkZddQSnH0QWKh071Qn+Z/chCiFXVbqSt1oNzrQXryxDpFp+kf4SpG8CROh6nLKiiEgw9Tl9J792M9RifEjd6rNGJ9W9u3B6y37TGCRmhHMZlJKrV6CMGAc8M2xUowNP7WCW+Zs7bc+3Cc7PnFQ3UqXcH1Yc1Hd7b61kYlr9aAxiakmudbE8TJt51QgU5XIQo3q+2LSdRVFBhu9YBo5Uup8Ff71PxRqpDTaXRh27wLa1dNj8oWqfcxTtvJqKGCU5LvZYZMNL+Np4r6XFlCLy4mw7vGJ2AIkPSV6kMXZzk2fTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC82UlVtNktBRys4YjlQeXAzV0ZSa0c2QzFVU0o3UzRGcm9mMEFNUVhvRmd4?=
 =?utf-8?B?RjNCeGpIVVpaVzV4WDFsVUVxYmFHSEliaE9adXl6WkVkcm9tMEZvZGI0WW1T?=
 =?utf-8?B?VTRUWWVkYy9lMTFZUHhhWTIvU1NNNFVhclF1Q1Z5aC9DaEdqQzAzQmd3V3VZ?=
 =?utf-8?B?MVJGK0s4Z1QwdVcxT2VlS01NZ0Y4b01kQTAwdmQxQ1I1V1V5MGE5WDNYamRh?=
 =?utf-8?B?dWU0Qlo5azRTbGRCdVp1eUpZNWZLc0ZwSzZOMnlKMDVVbnBXS2hnOHFEby93?=
 =?utf-8?B?NkdqKzFzNDU2L2R1ZXhNSlZET1M0bnZsOW1IcE1pRkxiRG1rRzZXbVZIOXQ1?=
 =?utf-8?B?N2p1OUE3MnptYUtEQ2hzRkVBY2t4Y1MyU3JMYnliU3FvbC9Qcjk4c2kvZExh?=
 =?utf-8?B?Sk5MV2JNYjFKTDRnUi9ZYWlzU1cxUXpzZ2lzdDVuZzFpTkxXd05kaTFjYS9U?=
 =?utf-8?B?ZkRmbHRSWWc5Q3g2ZWtXNkQrZTdRTm1IMkVudS9iV00yVUZ2YitFa1k0VHYx?=
 =?utf-8?B?VnR0N2UyRU90Q1FnYjNVYzk0WkY1cnpuVC9PWFNZYkN4OEhQZ2piaVYyaUEw?=
 =?utf-8?B?UWE1WmFoRCtaSWZCZUp5aDY4REFxVGlWbkVGRGJodnJGZFg5cUpESWZEYzg0?=
 =?utf-8?B?U2ZmUHVBaTY1OGdkdy9iUyt5eDI4WWZONWlYbGtrZzhUa2I4djhmR256K3N2?=
 =?utf-8?B?Z1RPVEx5Nm5sRTV6dHEyUXY5TGgwQStlcFVYS3pOQ3FUMzZUWlp1NTE5SWU1?=
 =?utf-8?B?NlJYQnBKSnB4UXoweXRPWUU5S3VzZDBJbGtjak9MeU5lcWRqMlgxV1d6S1JM?=
 =?utf-8?B?R0tmanFEaVNYa0hxeFdDMVRCMnZwYmFDRHlhTDJNNzN0ZGJMaHhGbTVZY3pQ?=
 =?utf-8?B?WVlmaE5BUEZtUEw2SlJ3SEVVL3ZJa3FoUDY0S0tRbkxaSVQ2SnJKZmR1Yy85?=
 =?utf-8?B?M0tzSTZoaGthVDlmdHF5RWRmK1hjdjl6TmJRUEtOUUlPck84RHZBMnJjQ09u?=
 =?utf-8?B?RnNjTGhzZnNiV3MvT0lvVm8yU29ySGEvMXIyazJ0Zi9VTTg1UERvTVhqOXRX?=
 =?utf-8?B?enh3VE13K05DTVFqNmUybmhQODJhQ1FxRXFwdmY5MU1sWTRSNDNGUDdVYmVK?=
 =?utf-8?B?Ums5VlNudGJkQVVtOFdOVUtWckdGNC9qaElxZXU1aEJVZ2p4dlJVd05SSW0v?=
 =?utf-8?B?ZFJDWDlFM2Nhc0hyaHY5ZHZKQ3l1Ym1USEo0RkpkbVEyMmU4ZDRZaG4xK3cr?=
 =?utf-8?B?a2IrRE9CeGpZWW1rWHBaRkRmMzJwQlhndU4zQlh6S2ZwcldBeko1R01veXZF?=
 =?utf-8?B?Mjg0cUl6cEc4R3kxbTZnd1dHVXl1ejRJU2NUN0VFRHdNZ291U1RPR0dZWkhr?=
 =?utf-8?B?dVM4Y21NMnJQZ1hUbWlQTUVTYXFWQm9lRjhVRXJpbkpYTnp4Q1g1REdkVVpK?=
 =?utf-8?B?aHJRRDhIdUpXdjlRQklRR2hLNWxsTUJEMDFuaC81djlYRXpTUnRsaWRMQzlJ?=
 =?utf-8?B?RFZSN1RUVldJVE9PeDF4cTBOYUVaSlY0WFU1MUFHL1hWZnFmQUxTQlV4R3FO?=
 =?utf-8?B?RGNBQ1dOY3F3NTRaOGJ0d2orZmJHSWhQVC9WOGlVVzVsenppUXBvMm9lSy9Y?=
 =?utf-8?B?cGZUeGx4SVFBVmhtTldqMUc2bnF0V2tob3l6Q3AvWUNaT2JsRlZpcXVPRHdH?=
 =?utf-8?B?VUZBeTZVNXdPb3hvZVZnN0NWM05CcEFHdHgzRW9RU1hIdVFLRVQyTDVHVDdQ?=
 =?utf-8?B?MGNyS1hpYmtLTlp6ak56Zld2V1N3ZzBEalVLajlVb3B2RWtZMTNjU0dVOVIr?=
 =?utf-8?B?V1o2TENFekMyNy9hYUVuMGVvSWI2SFlHVTBzeGRkUmtHYTFkeGwrMkd2WFJV?=
 =?utf-8?B?emdScXlobXZHV0ovN1Ztc1lPSWlLTkgyVnArR2RUeWtrWUFyV2kvb0M4RVpm?=
 =?utf-8?B?N2NaTDkxWVg0b0wrOE16K1lFUzl5ZHJmK2xHNnRINUVMalZjOEdvcGl5czNN?=
 =?utf-8?B?TytUYVJtS2kvRW85SmZiR0FXR0djWWxsOVVrWkNIN3pVOCt4OFY1UzVZU2hF?=
 =?utf-8?B?dE8xcXFTblZOd0sxbTVaQWpJa2ZPTjVDTUtCUFhCbCtQNHJQdVM3c0NzYVVS?=
 =?utf-8?B?NlJCdG1FREhmZUVHQ2YreDFNbHhvVlVVNVl4Wk5KWm1xT0xZWU9xRG82ZTFB?=
 =?utf-8?B?ZE1EVmNuNkVRbXN1S1ZGTC9VM1o3UGdMOEhobXRCRUlyN2pzbnplaThBbG5q?=
 =?utf-8?B?ZGNHZkNhaVFNQ2hqaWFwOGR0MW5qcjMyR2pOemNTMzlVUFZqeS9kVm9jM093?=
 =?utf-8?B?dHA0elJKRkduaW1hQmpaZ3NHRExkcFp0am5HekR4RFZibXhQanZQdz09?=
X-Exchange-RoutingPolicyChecked: U2o3YkD3pn1GVCuUMkDy3aj0Jpy5kYcRS/Wo7UOV5gc1OANuBoWgtaNOLwl6XZTs4Qi7sIe63PI1rMLNpKtdxYtPQEIYtx5tfjPQWuJpxrrTO35AmMkgy2/maiczOKdd57i6odJTi4ZpBXdhvJKeYYasqs3Nnb1wo3iGjyA3J/GVT+ski6DjJpzH5n6WKn0BaNMzOPNqQXYVYKCVC3ILSsRApV5zLZTbAQzkOcBdlT/RE1eOA2POzTVpgP88YwAqFoyWO3Zy7whhtJc7RM3xPhsgSAKbBA1MAT+sahgrRqgaXCMdEdHbgFZLW2/8PB0DCmElo7l5YNXOLIbCglmhBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6def14f4-4826-4fde-711e-08df151ae5ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 00:22:17.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuASH2DhWa/FP3IbQIU+Mft9DyJfAQC4xF1CQBnP39wfO4dM+GowGwL4xnt9Y681RrmIeEKYvpGJE8Zszd6CQI94pD4KNKTNHNXTswJ8Qq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> [Severity: Medium]
> Since peer PFs' trackers now survive CORER/GLOBR, can the clock owner's
> rebuild flush race the peers?
> 
> ice_ptp_rebuild_owner() -> ice_ptp_flush_all_tx_tracker() walks every port of
> the adapter:
> 
> 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
> 
> and ice_ptp_flush_tx_tracker() does its PHY register work outside tx->lock:
> 
> 	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> 	...
> 		if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
> 			ice_clear_phy_tstamp(hw, tx->block, phy_idx);
> 
> On E810/E830 each PF uses ICE_PTP_TX_INTERRUPT_SELF, so a peer PF that has
> already finished its own ice_rebuild() (and therefore
> ice_ptp_restore_timestamp_mode()) can be inside ice_ptp_process_tx_tstamp()
> reading the same block:
> 
> 	if (tx->has_ready_bitmap) {
> 		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> 	...
> 		err = ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);
> 
> Before this patch the peers' trackers had been released (tx->len = 0, in_use
> NULL, tx->init = 0), so the owner's flush iterated nothing and the peers could
> not process.  Can a timestamp be cleared between the peer's ready-bitmap read
> and its register read here, which the comment in ice_ptp_process_tx_tstamp()
> warns can wedge the interrupt generation logic?  Note the teardown path
> (ice_ptp_release_tx_tracker()) clears tx->init and calls synchronize_irq()
> before flushing, but the rebuild flush has no equivalent quiesce for peer
> PFs.

I am not 100% sure what we should do in this case. I think we either
need to make ICE_PTP_INTERRUPT_SELF handle flushings its own reset, or
we need to change something about how flushing works (maybe mark things
as stale instead and let the main thread handle erasure..)

For now, I have made a note of this and will address the feedback in a
followup after I can consider the behavior with the full series applied.
