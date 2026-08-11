Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014E4562BF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468135; cv=fail; b=elLfV4v3LTXR5t7EJotQcBA7/i7YafR5rFub4iUpZpyKL1QA4xDdRhvbK2pXGdZrwzu2L5hZGk3/HSC6S60C+avGvzbiJphQWcOdXThM7K+s1ju3zYsvyFCClQoBYgcAi9sgoO9kAw/mAb97boo/BUsXGU24WUj2XHXOmBl+Fdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468135; c=relaxed/simple;
	bh=kuxn92FqAMBvgSPWqklOKy/Y5Jqtwzq+b7IlAJznOfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8dFiP9johC2gArrNhQy3JsR0EC4o8nUXY/Y03HMfJe7lM+uRHHVh3ukchGlc0Sk6vCh9Uzzrr/E+HGuLQk0zwGILuiFYcJB7AxZHIgcrDVroKU+cMVC+7JI2FcRxK1U7wh/SbLsFc++Hxy4M6n8ukFfasgiUKNvWl6ofs1fVwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvUO8U72; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvUO8U72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786468134; x=1818004134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kuxn92FqAMBvgSPWqklOKy/Y5Jqtwzq+b7IlAJznOfc=;
  b=OvUO8U72S35N75laYfJR6UNGZeUQZKI51+Yh4WczdCdHYx0jgVawncCi
   jjS5+DuHx//b3KtLojun2nCg9oQltlEwxB/0pPNDMeNFxyLWYu7Du5rLI
   WmrjarzgO2E1TJAFmMEjPdEZXCW5ReZ2TWsMFYxl+BKlSDm0bueXIdpZO
   DjGUGql6AMkvncZ1M7x3P6cbWTwya5m/AoIBBJhrz1VsIGemd1jYCp6IB
   NNbuXLCdx1Z0C7JpsuMRKuxL/uPoRuJWj8bBXOOiylJMaDIPzlDLPORKU
   7V8B0Zz1WKD1Q4vON/eBeF9YethVUmmZsVP7Z3YlmQSLPv4tCOtD86C0k
   Q==;
X-CSE-ConnectionGUID: XyFtDYOuSK6T/Ls3Lru0bg==
X-CSE-MsgGUID: l6qhLQrwSw6qAoZrl7acYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87127463"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87127463"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:08:45 -0700
X-CSE-ConnectionGUID: Kd9+5LTAThKD3ADGxlh2aw==
X-CSE-MsgGUID: e/wM0rvVRzWnYuglm9iikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="260772429"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:08:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 10:08:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 10:08:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 10:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE6G0f/PjSDB0R94oGgcJnT0/3hEB6+KfN2EVQudbRvw9IbUrzLVxjaf1F2nYUALB7ZldEXc4IIm6AGwkjGLJsSZvymftka5Lb2V9OiuXh9fvTZ7SD+JymTvoK+AGwq2nLf/rVPyH66PpznUinQ6686/JtaI84n4JyN3LPwaexkHQ8Cq2V9ZQqtbzb7QmqiQu/SfuC/PgkqXLylhaILTJ2dxLd6v3IiBga2S36M9hqOpzP0WgRWgxa5LknzaQqojCLV09dz46+lEwgYTM+zNBxPGuccX/tdadFTT1djH2LbgOgjHUO/7943nL4Z6dQMsB+LMzhQUJSdMTO2unrt++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kjAXW4wo3DiJZaTSSC7XDnCWKO5XkLU3OHU0/t0qeg=;
 b=ujkTFkSec2S9xLZVv6H77F414+YPe9s/rDJn6JU9FSrKCby0GlEt+864sIF0ta+IgWQnNBVQ8LmpsL4cW2BpMUJEuq8JaOnHwMYBtf54eAzTtK/3Y6BQyeK+th3SeDJ/GVIeDisOMWI07ASUvC/TUTwOKApTOK8ejETF+Yd9kzWjCwZaP3tZ0ZJSeP7ptKHjz0hWj4cFv5vy37UUsTBgeMYVbXfbcJvi2+rtoW9cAAfG8sHCvfPNGdH84Tx2uupMXKr0B/yXhw/phDpA++rjrqq0TQeFgEo2Lv0+rPCKsv4Ldp/y8Z3DrzsMTWVIhipemFKRIp6OmM6rwbfd6BrBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 17:08:41 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 17:08:40 +0000
Message-ID: <3e2771d6-70f5-46d4-8281-341fb3b36f80@intel.com>
Date: Tue, 11 Aug 2026 10:08:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix posted write
 support for sideband queue operations
To: Jakub Ramaseuski <jramaseu@redhat.com>, <przemyslaw.korba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>
References: <20260319111659.551039-1-przemyslaw.korba@intel.com>
 <20260811160140.2161988-1-jramaseu@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260811160140.2161988-1-jramaseu@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfdd3fa-7b03-4e1f-ec2d-08def7cb30bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|4143699003|56012099006|5023799004|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: H1eh8YWJes10nrjLtwbQYDCjNYclq+neGplYyRJYNOtqydS/VtDzk3VaKAwFzBTV0Jchqawt+Rk/IHwNPs5CebS8hwnCxSh7lanWPWipG+brO7XptF4AWZnes+OFImMWkrUzWkXCWdTX6i2s6ShJ9EGjTtN0QQXHu07giO87uaYn0R7TxdWiB1HqmCSsEve6rOIIu73pN3ikCX0H4H+3tuU3ZoYjtW8tzBNux5v57VHcgHCoQtCjX/8Qh9fPp1bhD/iYWPYTwJSkcRkP2rL7Na0bGIL/RjJNQykACNiQqG1JRYtrGE1UVAqcEndncymlH+9675EDcPmSXDF2QdHrsPSL5zDAiW1R4VIykuGTrZ6ukprFMRNOH2B8zVh668gTeij1OJ2znJmAz6hbryALVrQgqOtdfwX1aITpdecdRXXrkxqbw9ahfERE/RJ+Ya1MrEAiOkFV/NHNdHPo4Pn+8BFWQaDSttR8m/XtkjMHH4wAW+pcyTjFIt/b143d+dRwYvKJZQLFeIurXiCiDT8iAcf+w7YtDEGXCFm+QVL8jm5rK0lP6RtQZbI3Xzrl0bRK/eG7kgpNUzwqMg6ZJYLsS4+IURO1QXMnHupefR/x9t9zm4NpgvAHRGOhmJMIKnt7cLRhiS+n9n69VPMUQsvUYLN7qCPXA9oX85nDqAMvfJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FxdmRsY20xWmthTlkxMVYyUTdCVlRpTmVDQUNOazZqSmxzcjZPT3pOSDM2?=
 =?utf-8?B?VTZTS3k0aHN0Q2hxalNNditlMUZEQzQySGpHM2tsbkRheHNBb2I4Rnc5ZGxG?=
 =?utf-8?B?ciszb1NDaG9MR0xxdFF2OU9UaWptbi9xL2hNYldYN21rcHNmUllsV3NNQUhM?=
 =?utf-8?B?Ry9aZjhybG9wR2w4YzdoN0Jub2x3a3B5bUFJckNEQ0RkdDhyTGgrOFNEMGU1?=
 =?utf-8?B?VHZoTnZ4MHl3MnpxRGNLQ1Y4dmw3QThqVXZQYXBTTTZVb3NlRjgxOHdkaERq?=
 =?utf-8?B?SEY1SXZUY1ZReHN4NzRUNGppYXBYTUxTT2NJN1gxamhsTE1JRVM1OGN6TWlF?=
 =?utf-8?B?SGxqMlRnZFlXSklSVmgvZkx2K2MxNXI2QVBDeFllOEQwZFVBcTFxSEdMOWpT?=
 =?utf-8?B?blVPaXk0a1ZGVzJkZkhEY3FQU1RPdGJmSnFCTVJZa0g1Q2ZkMVU5V0hKMi9O?=
 =?utf-8?B?UUlRcUZCQ0h1SXFuTnBJZSs0MTF2VzhlZXVsVjhnVG9Vc3BQMlJ1WTlBY29G?=
 =?utf-8?B?bEZCU2hhOUNVMWl3SWc5MW1ZUmJneHZVS3Fyem1MbklBZVZISkYwL0JQaFVJ?=
 =?utf-8?B?VEsvREw1bjdpcXE0SUNzUThIb3kwaWczemlaT3NwOTg2Q1hIb25jN2YwQWFN?=
 =?utf-8?B?c3NVVTByaUQ1aUp4clBoeXh2UmZ3STd6Rml5bmEvbU5xbXhIQmh2cHRQMVcv?=
 =?utf-8?B?aDBGRHJGVDEwb3M0V1BvM3lwL3BUWnpUWFZZa00rOFpybnV6NmFIU3l2Q0JY?=
 =?utf-8?B?NVp4OVVtRVN4WFNVK1BXNVA3cmk2aG1Gc3BUNmk1VGZRajQ1OWI1ckttb2c1?=
 =?utf-8?B?anZ2cXhPU1orSnJkeXpjTG1QOGJ1RUplL2x6TTN6aXlLZHBiaW92V1lNWVlV?=
 =?utf-8?B?cHZDQS9xTmJZa21tSk8zVDBvd1lEaGRqMHZsUUVjM2lSSGlveVJJZllzSGYz?=
 =?utf-8?B?eUxHeUpmc053UnBMV1J0Ylg0eUpISDNycks0YUlRNGlodGNoZXBKUmRqd1lD?=
 =?utf-8?B?L25hTmRuUS9uc3JSSWZ2OUhpMlg5czRMMlVlS216RFJJclVpcnRxdVAzQnNY?=
 =?utf-8?B?aU81YkF2RTI3Q0NRSUxnbUV1OUYvbUJRdGpUOFhuSzdUZkRJa3ozT3l3TVNT?=
 =?utf-8?B?dmQ1aXMvTWlONW4xTTFLNlNRTm5TQWxTeWoyMU14b290bU1JU0Z6Q0V0N3Z1?=
 =?utf-8?B?dy9pSW5GWmdBUUx0OXlSSEtuZ0kza004ZlZVekJ4VzhZc2xJMUdzK2ptdFAr?=
 =?utf-8?B?eFIyYkpOWCtMcE1QTk9YUEVBNWlyQUpZZDBHbTUwYklKandDSjFYY2hUY1pt?=
 =?utf-8?B?dFU3VFlWNm9xQWNIdFFTMzlUbFc4Z1N1MnUwM0JEVGtkcy9hdksyN3EvRTBa?=
 =?utf-8?B?WXBWQUh4d0hsR3RPWjlHczFoMVZ1b29wZFU5cGpyTzZkWTF5MjNZdENUeU9v?=
 =?utf-8?B?eE1NTzBMZkdaekJCZ1ZvRUc1L2hxc2VUeU5MaFdrbUM3ZlNRV3RPdmtTdG96?=
 =?utf-8?B?cXFwS2RMOWRGdjZzNkxtRUJrdEZWRC9VRWV5ZG16QWRqSVZUYzFBYUdUa2h0?=
 =?utf-8?B?aHQvT3hQa2UwSzVzSGZtTlpSVHNjckZZaUlOR3FjMkhVYVJXeFNmT0ExMUZM?=
 =?utf-8?B?NnVvRnI5OVh5a1V0K2RYMHNDaXZBaFZxTmo2ajcwYXNydUdmcC9od2NiRE4r?=
 =?utf-8?B?UWJqMnA4ZlFHZC9CaVJGOEx6YW1XcnN5WWFYeXdmRm9KdXJUenpBQklWRDB4?=
 =?utf-8?B?SER5RjhkTGJnUEJQb05hR29HWis5TjljclVGZDBSWC8veXBtWUZxa1J2Y0FU?=
 =?utf-8?B?MkgzTmxGY3AzSnduTmhTdzh5b0s1T05wQXVHQ0pXeTdEWm1nTlFjeVhKaUFX?=
 =?utf-8?B?QWJEbzQ4UmF0WExyOTJnaTZuMStxUkFYcEJGTlJGSEM4RE9jZWZoZy9VNGpv?=
 =?utf-8?B?UEd0OGhaN0o2ODZVUjB2ZEg1YUQwSDZ1VithdWdheTNjU2lLUFkvZW9WMktk?=
 =?utf-8?B?TjM2Ri9QWDdTVkdwKzY4eXhiZzd6OVQ4Tk9ra1JQRFZMV3BFelg1dEJnR0Rl?=
 =?utf-8?B?NXY0R1MxL1lQa21PSEZzdUR4WDBNUSs0bGdZY0pHLzZjVkxKOERqQUxHUmx3?=
 =?utf-8?B?bmZIeG4wbm4yVVpHSEh6NFdqS25kYWhsMFpzeUkyWGhScGlkVmJRSG84cVdV?=
 =?utf-8?B?ZnFMM2wvMHhsUTFvMG92Mk84WjN3eDZDdlQrMC9CbHdGbEF5OE5SL1lyaHZr?=
 =?utf-8?B?OThHRmkxSVpWVXVhZ2pqU1VZTDd0Qm5sQXE2TDJXU2luY0REc0pCVjBWakpQ?=
 =?utf-8?B?ODY5c0RaazhUc2VneCtJeGlOUEJRbEljRUk5RFVQL1FPU1JVSy9uMGl2bVgr?=
 =?utf-8?Q?pfMNbhcJr6NG9X1s=3D?=
X-Exchange-RoutingPolicyChecked: rF1jp0vLFQ7IAiKEL+OE5lnCY/FIXOBfgOBf8Hu+07P81nGHcvqoQHbdg5paiMDToCMPVEPOBzj9qasw7vaW6DFr2+S9GlZNBZbu1HsuwSflx0VCwN9t204kJ5axG3f72xdejacnc/g2qfPmJedc+6FJR6836AuXLphaqLEm9qfh9T8oV9HqVOnHRQhp/La8svI68+NltBttk/OJG/iFml1vhQf7U6ISa4JDNTtCiBlOJsIHf8C1Rgyui8MyJXScws3SNvxrk3fnE6qZEAkpyulbowcPI6d6iZPtJoaekjvWLyz4GUdjEi5wlCpDaAL2xYjposLN9YTNZ4gkX4D0Jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfdd3fa-7b03-4e1f-ec2d-08def7cb30bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:08:40.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfMbhQqwcqEOK7MUbOon6JXa2l/2YpM++XcQwI71CK8vlBC3LufvaYZj1f3V2nPITWtbTgziOL3Juh8uclOkqvagrYCuxCayk70CW1MOiSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com



On 8/11/2026 9:01 AM, Jakub Ramaseuski wrote:
> On Thu, Mar 19, 2026 at 12:15 PM Przemyslaw Korba <przemyslaw.korba@intel.com> wrote:
>>
>> On E830, PTP time adjustment commands sent via
>> SBQ don't generate completion responses, causing the driver to
>> timeout waiting and return -EIO, when trying:
>>
>> phc_ctl eth8 get adj 2 get
>> dmesg: ice 0000:1a:00.0: PTP failed to adjust time, err -5
>>
>> Add support for posted mode not to wait for completion response.
>>
>> Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
>> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
>> ---

...

>>
> This is actually a valid fix to a,
> 885c5e57924dc0 ("ice: fix 'adjust' timer programming for E830 devices"),
> which allows the E830 HW to continue in the function
> and then invoke the following: (with some ice_debug() messages enabled)
> 
> [ 2946.907728] ice 0000:6c:00.0: Failed to send message to PHY, err -5
> [ 2946.907731] ice 0000:6c:00.0: Failed to prepare PHY ports for timer command 2, err -5
> [ 2946.907733] ice 0000:6c:00.0: PTP failed to adjust time, err -5
> 
> But the patchwork lists it as Changes Requested. Any idea what happened with it?

I believed it turned into this patch [1] which last received Sashiko 
feedback [2] on the netdev send.

[1] 
https://lore.kernel.org/intel-wired-lan/20260520105311.5336-1-przemyslaw.korba@intel.com/#t
[2] https://lore.kernel.org/netdev/20260723155750.717839-1-kuba@kernel.org/

Thanks,
Tony

> Tested-by: Jakub Ramaseuski <jramaseu@redhat.com>
> 

