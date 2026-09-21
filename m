Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF572EEE96
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024840; cv=fail; b=h5shzXfcgL52VAKw5F/dQW2D5/NdOOPuqRQYqfHj+XOF+0pV+anGko5fvb1gujH1J+avRJeG08pA1plVElPBV/KXF1kZgCjVlIphTbqYAgbAjHuzdVwZFKandh7+o/Z6txIld+dF1lEF8gA0GDTfUe4HAvgkdckqXAOfhmm3QHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024840; c=relaxed/simple;
	bh=GqzUuu5VedDCkUh7dSfMzdvGQcrkv5z5YiSEhC1igEY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qYrMLt1GCjBZDFj0AyXTRV9xAgkZW+dIFOpBYF9stfR/7yPBxmm+PLUnhyyzniHvpZyPWSm1Cp4+PDm5xhz+OlEdueohzabl1EaLend3TkPwTyzDD7hRXjF/Tn+L04oz77/UQj5KKBva8dab1oUw4UZJn/k75SKdxAb6o5LkDE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRRpWNI5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRRpWNI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790024838; x=1821560838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GqzUuu5VedDCkUh7dSfMzdvGQcrkv5z5YiSEhC1igEY=;
  b=KRRpWNI5A5d8cxcieLJj6QTSpYbb0Okd/JeE16VUu8/z9RJx1VFnWkvS
   KfC1nbcrdbmoc7GhY86uz8cyAauK+56xXCBe+5TgiW9Lfi3Lk7xjx7iqI
   z71JY2BafaQMNd3ZDDS1ifl7MlByE9m+n/mObzUMsAoC8FZGhU2wDCd3i
   ifkpZUuvchoFh5XoA5vr9ARaWS+CVv92h8DBEHm9CaAsfV7y3sp0QaVb7
   L/jy/HcC3as6fkPBi1fDUscCsNPQNS30ph9MswnpJsrS14ThUKnkfHDEO
   OFaRP6pTm3Zj8F5VBH8zV1uuJKNbpnnQUqO+zFpuznLJjJZwqcCXHFR7+
   g==;
X-CSE-ConnectionGUID: ThfFMHy2S7eNXETfRYexuw==
X-CSE-MsgGUID: 62F56d5MS8yjE8lcvSnZ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89501424"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="89501424"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 14:07:17 -0700
X-CSE-ConnectionGUID: CIAoNCxHQUOIEqZ5pjzwEg==
X-CSE-MsgGUID: sEyGE0T0SViVK86Ahlha5g==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 14:07:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 14:07:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 14:07:16 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 14:06:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7pzqvoq+1mi+ESq/iSVkU3Qn79XtiMZ7TEJStm/v2WHfAy9DA9bXUrGVgsX1Hmxqge67DeoFTCw49z8RiErtV8adquwhIvgcGf7z4vDyMZkAoe85LvsSTyo7A9pm1Na9FowUiven8aZ8RAlS7zF0rp1hBABv9Pmk58lT/ypw7BXS/EEIr9ilsMgxdxhbkAFtDMlhFpX+bl1UBs+XVizthM8g3MQDkvO6RcL6YFPn74ZuCOxqZkqqDlVrhLApn/4xMqc+9XV0v9mZTG/cfEa3nxxKofcvocXyZaLp9QnjSX7nvCygnhm0kb0GYeZp5Hh/LGLiO4Y40EzKzyKAlvvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu5M/fvMp/lTkr695sZ531x+6BJFI8527yfHWaZMUQ4=;
 b=oIXzcZbuJC+/b6LB91CCrXn5faZ3cFeLiC1+FcE/OxfDzqSZNqXY6uiYfrNBVTLZRLvK5nANSuMlTOWk6kph9WQgACUELPAijEJCjOjmnWtQPVF1iDuTYiV0+n2opVzvlh1580qUSAZW0hSurFb5FTVoke0dKN3pbw7bWD6O/yZ9i8HP5JPoZiFid5eyRLxVQ2XBWBDyn1HR5F+08bnQHRflxCnaPhCaAwgtwi7p5byvrqTNFZpWesF76qLKyUfbGv6vrqlvkYVRiXXnU89GsfcB0hbXqzOB312XtVlUr9VTlz75XfzzsIvRQnRSLYTRzgo0lN3Z2gU+0dXKNvRYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by DS4PR11MB789483.namprd11.prod.outlook.com
 (2603:10b6:8:514::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 21:06:22 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 21:06:22 +0000
Message-ID: <008a657f-f914-4191-b5c6-0fcc062bf73e@intel.com>
Date: Mon, 21 Sep 2026 14:06:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <aleksandr.loktionov@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
	<tianxun.ng@bytedance.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-2-luckilystar08@gmail.com>
 <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com>
 <20260921032827.32485-2-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260921032827.32485-2-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:303:b7::27) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|DS4PR11MB789483:EE_
X-MS-Office365-Filtering-Correlation-Id: 36de5bc0-4483-48d1-5dcf-08df182430b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|5023799004|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SEKTHPNcaeE682eMXQz0R5+NA4/2Q3ERjB7YrmxXQ1imCDvoPIJg+mVwVrvdIOxHoKIKzyUaPugXXfVwzvZ2yW4vqck4WRopC5752WyEQvnhbFDDEcYymV5BfdW0q0P+sSw8ZFjhFrRWhfOp4GeIPjZUgPrSE39sr4muVTL9TGZCFn5Jv48jHJ6fX94wer9Vr5rdAjouJntqxynL8u0EpzcN0SwtOlZ/fPeS3ReILrOBAbe2F4gJle6hJ2V00jKcqAub5tsvqPS9dN1rP5jouAuaBeV5tg/amtE1pVl5YkDBzz/HzIksGtCWeElYGQfwedJOHubTqWt4AtY36RR3ZqszEM1JriqXkLOKUdkBtqXILlXN49hfiPYZwMPEUA56bdI4rKiJBu3aau/p6HaRbWgqzyel8L71x5aZFS5mfEwtKtssd+QwW2aEru+4ZMhG6ua7viTCQj16/rrxrqq0AuKgpV9pavNjcAMl5wyAPokb+fUCjR7wnEpjUDM7D/lsdnJBUlla/jKDfLfDOHymhmWwXYh1Ydj7RFlwpV0NHdahlF4a7l2htsr7j1ah6pYVbYVidBVMe1oz19vJZXYRsRRudJs3m+FgHM1rnSiECLEBSYAxkKjpTdhrfw8N6sLLP9aGTZJJnyN1yZ10dPGYovL1+S7KsJZBxFrILHlI6tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckE4YVM2U0VTUlltSk1QckFFT1F0ZlBXUmtHLzdkdjZycTVuN2RYWmExMHdB?=
 =?utf-8?B?T0lDd2s1L2xvSGF1OFdFL1VmM2FhNWVXcyt5Nkpqa2s0dzU4Z2tCeDludHVZ?=
 =?utf-8?B?U0ZRWkg0eG9maHRMV2hIK1l6bWNmTmp2UVRVNFI1eFh3Si9RYU53eFpUeEl0?=
 =?utf-8?B?ZDYyQ2tLd0RQazF5VHlhNUdhZ0VFWURLVGRVQVIxZHZnc0Z6aGdSWnpaRCtm?=
 =?utf-8?B?SkJEakkydGNhcTR0SlhiQUVVZ1BqNEp2N3BhelJpNFN1VUd5dTVlMTAxNm55?=
 =?utf-8?B?NExYbXlXNnFsNkdhWmNUc21kRXFmTVhuSWQrRWx3TXk1NEFlRlBZYkZObG11?=
 =?utf-8?B?MUdmaS9id0FvUlNhcjZLZlhNelFqK3pGY1ZpOUNncWJDOGVZaWxjZVc4UnRs?=
 =?utf-8?B?YXZqUnpDeU1EVmJKWU96NTNnL1hXaUVQV01qSkhPREQ3ejJXcTgrem5KVjNu?=
 =?utf-8?B?Z09UMmU4MUtwUEYvOEZvbzlDd29mTGdTdDNJSVBtMlNSSWxvU1ZubjZWOC9a?=
 =?utf-8?B?MGIremlNRHFUS24yWEo5MEJ1eWhyY3R2c3pGQzQxOGRQNnhGWUFodWVLNFpr?=
 =?utf-8?B?dkp0VjdWY3BTK3NpSzJkb3RXZlhpdDR4dzZBd1FiVkl0eHFDRm9oYTNpeW9r?=
 =?utf-8?B?Z2dGWW5obndBcTVKRnlKNHlVaVdPNlFZNTQvaWxXV2owTjJmM3lVTUNTdmMy?=
 =?utf-8?B?bmdwMDNIKzBqZENUTnE4SmR4amw0VDVWNDBQZnIvb1JtNU1ndFB2eUIvSVZq?=
 =?utf-8?B?ZjNNcU4rMGgrbXVwbWRCek0zdWYzeHF0OXc0RG1WZEdIM2Nqam5qU0R3ZEhZ?=
 =?utf-8?B?c2k4Z0E2bk1QejczRGh0TnVKZjZpUVVIR0wzaEQ4K2NYa3N5Mnc3RE8zUHFh?=
 =?utf-8?B?LzBwQk8ySGYvKzFrWk5PZ2g4Y2ZMT2dZS3cxVHU3em9TRDN5cy8zNDlyMHVa?=
 =?utf-8?B?OTdiRndhV3NYNjFVa2tnVUVaNWZoUHJzYXY3V3BHZjZiaUxEOVdDdzZIYjQr?=
 =?utf-8?B?b1pyR3RxdUhKZTRub2V0enoyUW1ycGU2bEI1cys2MHdrdXI1d2E0NEppYWRj?=
 =?utf-8?B?NDFxOVA1QzQxMU9KalpmNnJOTEduS2M2cS9vZ3FVQnRPKzlaLzNvYmFqeDNK?=
 =?utf-8?B?WTdnOEFpa0d4eS9mWWg0SGtMSnZSd2R4cEh5ZEp3S04vZDhSN2Y0aGFZb3dT?=
 =?utf-8?B?RXRac0ZQZzhNRGJ0ek9RSXcvV2VNa2pJL1dZVFRHNTlzOTlGanpkWkY3UzMy?=
 =?utf-8?B?Wk9aNHM1akREalZvQTFqamI2THhYMEQ3SHFRS3hFeis2ejZKcUt3RlpxbjFv?=
 =?utf-8?B?YWdrZi9mQTB0K291RzJXY2pVQzNaMVM2aEVXMXVsRUpOMjg0aktYNnlqRlhh?=
 =?utf-8?B?QjAzWW5Ja1RPU1c1VGRrRjV6WDljbjJXTUVpNVB5K0V6cS81WWI0ZExaUjJD?=
 =?utf-8?B?UmR0bFF0MDJMR2xIMW1tcGZyWTVpUjJNZEY2SXpTZUdRNXJycXpNYmhCZldi?=
 =?utf-8?B?bzdnZ2hpbUl0RUw3c3pGaWtpNU4zaHFYaUwyTW9TSlB2OEhNdnNqWGVRK3Ez?=
 =?utf-8?B?UzBZdDRuSVlTU0VIWmxqUjJLejcxcmNxNkpaRDBXcm9scGxzUDA2SkJqSmNV?=
 =?utf-8?B?N2lXenRhUDd2cmZ1VlpVaVdGamgrcjRIWnprQjEwYlJVanlJQTNsVSszVFNx?=
 =?utf-8?B?MEswY3Z4WURnQy9aR1hiM0RJT1U3ckwwdTFZN1ZZbEJ6MFpnMkpaQVlGamEy?=
 =?utf-8?B?ZVpKenBnZUpIdUVDMldzMXovQVAxVWNvTVhoOHZaeC8wTzZHS3hrMXRqaVhn?=
 =?utf-8?B?T0dwNjJLV25CS2JUSThZRHR1TWcrTFVIZ1ZJNzZQTFA5ajBmVUQ5WnpSR2hs?=
 =?utf-8?B?R29SOWw3YTBEdEM0Q3dlN2VyS3dkdnhaMk8zWGNUMHgrVE9iZ0o3dE5pN3RU?=
 =?utf-8?B?eTM1T0FCbnR4MG44RGV1TmZBRTVpQzFPS0l3bkFBM0pMRlVUdk9lU0g5cXdF?=
 =?utf-8?B?WGpqYjh2d1hheWVoQ1dPcnpFZHZNS3RTaERYb0VDa3JYbHFZZTlVTmM2akx0?=
 =?utf-8?B?U1NOdG52dSswNUMwNzZOR3gwZDVST3hSQmg2K1RiRzRZcTlrbUtVekNxUGhU?=
 =?utf-8?B?eTBhbnhUY0svSHRKUDJIbU11Q0RDYWtYY2NvaWpWaHR1dUU3cjVNblA5YzQ4?=
 =?utf-8?B?OUEzaHFkT2VYT2Z3YUxyUUJOZzU2cDJsWk5EbHR1MEdSSHpFWHBSRnUvTnJS?=
 =?utf-8?B?bGNjSjVYeDVDVUhqU1ZRcHA5OTVOV0xqNTI2U0FvREtKd1dkbjJKYjVyMnpT?=
 =?utf-8?B?dTVwaEJIN29xeTVZWGNka1hWdFFVelFFaTBWcmprSHZoU0dsbGhQeEJBNHI1?=
 =?utf-8?Q?S4KOpfQTrYkjUH8s=3D?=
X-Exchange-RoutingPolicyChecked: kzJeXj9bJIEc1m9ndPhxz5hj09p+VZdEvJ1faYY5RjjRfizZ4j0g6x1KpGkZM2JAgz0++9B/vdSyANOTP1wzOt5yfG3foGnVK4x7OeRfY7L24dOClxBPFIOs4Y5UfkE749eC+EVf3H7PtvRGGbforX1p8ZXob7pL7Z2lMJrQql8lYqH9bp6T/hJ3X5TZ8LTnyd+aShm8KIOcL2ULz1Gc2Rh0TkgyXHyEr3L2p0fzE7rjVHFrV+nXWZGgt5BNdFBJbgylnrmjMlHLEaB4Z0dfUxuWCl85RALHtIxYEsVyf2AkoIHserfDkwqhNkVEhfyoPrK7bxzE92BTqAScZsVDCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36de5bc0-4483-48d1-5dcf-08df182430b0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 21:06:22.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGHo4Hn6+PKQAp/iDu0wRG0nlcM8fUYchoWM0u6LfjeGCRq7xF91U4Tea1CX2M5qqanmeQRE8BVnLmNvw5R3UNqK5HfhGqujmIoSa+KBrgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB789483
X-OriginatorOrg: intel.com



On 9/20/2026 8:27 PM, Tian Xun Ng wrote:
> On 9/18/2026, Tantilov, Emil S wrote:
>> Actually we can't wait on shutdown. If the MBX is defunct, like CP is
>> down or unresponsive, the shutdown will hang for a very long time. This
>> is the reason why we wanted to avoid communication on shutdown. Have you
>> tested the shutdown after stopping the control plane?
> 
> No, I have not, and I cannot on this platform: the control plane sits
> behind the device and I have no way to stop it from the host. So I have
> to take your point as given, and as written the patch is not acceptable:
> each teardown transaction uses IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC (60 s),
> and the teardown per vport is disable_vport, disable_queues (which also
> waits for the SW marker) and destroy_vport. With a dead CP and two vports
> that is minutes of hang on every reboot, to remove a fault that only
> shows up on warm reboots. That trade is wrong.
> 
> What I would like to propose for v2 is to keep the teardown but bound it:
> a shutdown-specific timeout, on the order of a second or two, used for
> those three transactions when the driver is shutting down. If the CP
> answers, the device is told to stop its queues and the stray writes go
> away; if it does not, shutdown loses a bounded couple of seconds instead
> of minutes. Does that direction look acceptable to you, and is there a
> timeout value you would consider safe? If you would rather not have any
> mailbox traffic on shutdown at all, then I think the fix has to come from
> the device side instead, and I would rather know that before sending v2.

If there is some clean way to shortcut the MBX on shutdown then I guess 
it would be acceptable, but I don't know what a "safe" timeout would be. 
As you can see the timeouts are already quite long, so you could 
potentially still bail out on a working CP that just so happens to be 
busy on the replies.

Also, consider the case where a reset on the PF will kill the MBX for 
the VFs associated with it, so a shutdown on such a VF will always end 
up timing out, since the VF reset is a message to the FW.

> 
>> This logic already exists in the reset handling, there should be no need
>> to replicate it here. Do you have a trace and/or exact scenario that
>> leads to remove being called while in a reset, but MBX is still alive?
> 
> No, I do not have such a trace. I added idpf_is_reset_detected() defensively
> rather than from an observed case, and I will drop it in v2.

OK, that makes more sense. I was curious if you are actually seeing an 
issue in your testing.

> 
> For the record, what we do see without any of this, on arm64 with two idpf
> functions: after a warm reboot the device still has its queues enabled with
> the previous kernel's ring addresses, and the first queue reconfiguration in
> the next boot makes it write SW_MARKER completions into memory that kernel
> has already reused. 20 of 20 warm reboots on an unpatched control node, none
> in 151 with the teardown messages delivered.

In that case wouldn't just the reset on shutdown be sufficient? The FW 
should clear the resources on reset, which should take care of the stale 
vports.

> 
> Thanks for the review.
> 

Thanks,
Emil
