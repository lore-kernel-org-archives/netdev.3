Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B6306B3D;
	Wed, 15 Jul 2026 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133172; cv=fail; b=TZw3FPjADXOJMLLaduKB09Q7Tpgn3/6OxHPS3F4h1UqYxV+14Q0VLvyFp/n2IxG/jPwoSKYiz9XNPWITh/gR9IoYETwoY13PFGmxoJZk/joq5Z6MNUZAtSneZG2BVyarse7ahI82+3RWd5tmU0EJ6zbCVOqfWjFG2/FPsSnMQ2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133172; c=relaxed/simple;
	bh=yJLkJSa+4N2p2VIb7pwa7KzKRwCNRcJvYVbyPiph3ys=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LPGRx/XSpGn26/E5KjdJ3hrQuATh1pdSKRLTDZYT4x2qazxaC5QI6LJ8rkCrKFK6BYIni67kv7jr0NYbLfWR+SiZMAbQZ8SHsNk2TKIZdGsetbWj6vG7Rhm4sOpU/GwFIdIDY100syGMa0I9AWtbeB3lrrL9t+J0qZUR4a292I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLs78uby; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLs78uby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784133170; x=1815669170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yJLkJSa+4N2p2VIb7pwa7KzKRwCNRcJvYVbyPiph3ys=;
  b=OLs78ubyF4WY7MwtxXCZbluz1Ma9lwbTYVv0ayd2FP+EyXgPQsVD1pfs
   x+geh9h+zh14XwGcIYydMkRs56hnklppyD95EB1cw89cqE1N7kgqL2rJ2
   8kF9O70YKSRR1ugCArD+zZtucqN26EHdVWBbRKM8061BcDGPIAS7rMvgH
   m+JR1c72jVGapJX6RwyB9wBhbX6Qxg7zJ6NulzHhgd59krqHolFNswsyT
   ndgM5rZLobsG93akdwhDLweETCMPiIyqSep1q0wSrLeZi+k/4SAUWv1/4
   oc/EIWW+qW8bklTZI7zQpte0DUJZufhegmDiMCJoMlYlCCDwqS9YRXWOA
   g==;
X-CSE-ConnectionGUID: EhmFydHnRF+rtZupxXFwOA==
X-CSE-MsgGUID: BfuDMbPlQKGgPcrjYidylA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88604952"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88604952"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:32:49 -0700
X-CSE-ConnectionGUID: BmKCw/PfTHeJGZzJ8m+FNw==
X-CSE-MsgGUID: 2HmM0M3LTuivXIlrHxszpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="253625890"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:32:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:32:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 09:32:48 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhdUb56Xi03ks38uvSf+3tF1EoCgQKbxz7oaXnSQwCRh3Qt8EGIrgDqL1iPqZpxUQZcnKno9rJ8jWDV69WRsCXkD3Nu0m2yqbhNSsrUcwdqlvBtGSLC+QyZVXuVThSMyCEgj8fASYHRG6EuuYxy3FueQsv5gS15CR6ro2NURhU261NZSSU3lCQso0SY5iQ2x4BzDzzqkz3zDzPPLpZI88KKbbssNdAIJPkTOW5xmo30KcS+rAmgQY2vmRuPZcAN0SvpfQ3fyxbZ1HkikojFR3vqWB2HT2m2HITmksAKAao1yW+S0rDIoiQnyAakkyuWf+fzc+6DVewXOmIEYxw32UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNQiSBCHGI+RvgAnaCwwerHXIe2r/r/2hGp5KjRSBdQ=;
 b=Fllg8VgR8rJFkv8Eg+cKwvo3/8a8bn4zgH01Dht+Zu5lhnCGzEWxVA9Fl7qfGFr+mK5DeJY/wd5mb5e7gP7wmxSqXmnTcjzZiJ6wmMqMCrenSNFklg5jmgb0HvIkRpq/4GPRe2mcMtSVsD7CKQqmYmjv2lkT2p4sa8Yyqw1bN8ambqkWJmPJv7W5JoqwBEy/9H2Q4cCjubz0KH2LStB/aOg7GX8rtw23cK8etpd6ndDSnp/BeVOLTDt9yzU1tB6QksBP4G2mRfuqjzv7P7mj3+cTynPjBLJTwsLJevYBP41gqbP1+Q20E62Hlhq48qdyfsqgZZ5UdSf3Mg1kQSG/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 16:32:44 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 16:32:44 +0000
Message-ID: <0a3ceda1-a29b-4784-975b-d8c89f145d10@intel.com>
Date: Wed, 15 Jul 2026 09:32:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/15][pull request] Introduce iXD driver
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <alUuiqh_VkGhQp7T@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <alUuiqh_VkGhQp7T@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adbe94c-8b1d-48a2-2f7c-08dee28eb2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KmHoI3ABgykmIhRy+KDHe1PjtTSse442uyT8JLMTUq65dMmCFuAxJkQc8SgGC9tufYez60afDhH7wpNKy+TE7Ado4tXETSr65KJiaEP72ABAPnUdcXOiXtvZiLFdEwSv9qMePZmTIF0N6CP03xCJ7VjhfOu5RGAE2Q3HdNXDCk8cU0mVA3I+PZxp6szdvsBL9G50i641s76uNxhGgOMGvPMuEGJd/yJmw8v/Rrnf21KhL3yG6M1AbO0TbpkNqPvbcZ8TaIvvU2nPHmgFq8MSub3hXmK68NL6/bUcWo2+vxgRK7HVADbAsqauKHBJZmlNckxmtV3XhfScjGaYan6CauXXoUCBdAQ9fJAd4vshBRLw66G0yvf1zz7vDTSMFDUbFTrE7nCeN61g9cXE2jIBQGkoCnuGgrPl1mq8MZDaqWASZrgQH2kt8AhstsNryKpKbNgd/snVOxDppJm3cchq2265h1aNI4ploVw6SYNGZB/Jo/RHVCiVd2yGCWkR+UlapPDzoyCsQOWNQ4UALlfO1222FVd+hyP8gISkgoFAvarhiESVEVPyfP9i7IBmYreMrwlvWJEZaqnnM+Sl43P2/arjVFvgA4N6z25AkTFpOpetxxELiGEYtzni0MLNeVhw2X0ojKTuDK13F+iff2f0VLmsOCu8xlth1vWfZIEqDIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1huTnEvM3J4aXg5VGEvN1RuaERwMFpyUEFGNmJsR0M1ZWJtR1lSd1lsY3Fs?=
 =?utf-8?B?V0Y1M1BOaE9UK09xZ2YzbWwrWWVtR2ZZS1IxeVVLbG9wS3h5eW04aWR3UzEy?=
 =?utf-8?B?NmgzZ2VhVEZJNTZBMWVuU3Y5YXBtdGVGelp3Q2JtaDlRSlFQckV6Z0kzS2Mw?=
 =?utf-8?B?VmpPbHhvTmp4YUxkVmsyMlorVjNoSHNmWWptcDcwS1VHWkwrSjd6bEZLY3A5?=
 =?utf-8?B?VnlwcWdkWTFzZnVMZ0RIUDZMWEZvUS8zWFovamtPYVFZUjRpQmo5dC9FOTJM?=
 =?utf-8?B?ZFcxUFZxRnN5czE3WENrL3ZmTktMbUF4cGVFOWVYV0MwakhIcXE2SnJVYWtW?=
 =?utf-8?B?dHVOTWtJeHVPV25JbThBNW1CWlNjNTJaeFB5QllmTzluZmZ2U2E2aDZtaTJZ?=
 =?utf-8?B?N3diNjdHUnNuRlY3Q1A3ZzY5SlFtSjc5dTFPenc0M3ZNYXB0WThrbG43MXM3?=
 =?utf-8?B?MDhnMk93OGRHWm1tOVpBTEFuZ2pGOFZKTVFYSzhvUkEydW5JN2JSRFN4dDRZ?=
 =?utf-8?B?a2VRblhuSWxiZzNRRDJCdzkxZFllSEhPSWwweExkZnpnemhVUVdDY21HbUFM?=
 =?utf-8?B?NGVzWVZKTTdUdjNsaDVTUFJaUXZ4dmhvTXV1cENlVkttbStraGVmTXlLb3VS?=
 =?utf-8?B?N1NiNnd1NU9PSDh3WmVxTFFsK29neUVBcDZiVU5yTTMwRlZ4ZnlzZDV3cm1E?=
 =?utf-8?B?dXNYc3EvQXAxb3pnRFNucUZaZ0szbFBSMVVtVG5hSzZOb3RyeExwS09WRmRT?=
 =?utf-8?B?OVY3OWtZS01rVkRDWU9aaWdxSVpOSGtPRUpOQ3lHMTBlaFJNZ1hGMzFOdHdC?=
 =?utf-8?B?QmVFMVN1T1ZLanA1cGlFMjEyTTN2QlFhV1d6c01pN0doNHFVNjJiYlNLMm9j?=
 =?utf-8?B?MUpUalpRMTNLTVd5UDhhV2k0MkROTlg2dE1GY1hTdnVhYkV2Zy9VNExrZUJ3?=
 =?utf-8?B?V3lYQ0VQZFI4NlFUWXhpWEREb3dFZjNwMERYRTl2a2dWVHRCRDg1eVo4dHNw?=
 =?utf-8?B?YkxmcFVFNlcrWDdlR2xKRUZBZ2dBN1lQQmt0STVVOXFLU3ZaYUIyWUZUQ2dp?=
 =?utf-8?B?ZTNjY1ZzWmZ5MGV4eWdVK1VaNHZPNTBGWkw0Zk1lakRneHBpdkJEbmpzejkv?=
 =?utf-8?B?c09neUovaFhtYXRaMmRqdnpRdEVOWHBINW9PM2F3cUVGN0E2b0t6dWlxL2hC?=
 =?utf-8?B?a1V0cW95ei9Ea3NaNExxdWh2a0ZtcWhtbncxazBJNEhPdEVsMW13Z1Vrayts?=
 =?utf-8?B?M0dERmM5bFRDZUJLN3NRUWtjK2RjMGFUSVdvUmJFOGdtRUNXMytrTXFOcm9U?=
 =?utf-8?B?NFpHc2JTaVdDa1hLbUQ5clVYVTRBd1VLUmZFck43U1RNN1YxQXl0cUwyZkdx?=
 =?utf-8?B?WE9TT0R6M0NVU2NiWkV0bXNmMXd4ZDJoeE5iSUs2WXM3ZGtOYU9qd2xDb1BY?=
 =?utf-8?B?V2p4cW9IeS81TjBRbGdRMlhSSVNwU1dMOU1SVVowbzd5eENqcVVrcm9SMEox?=
 =?utf-8?B?RjNOVE9aaVlhY2hlTzBuSVhzUXJTSjlqTHh1ZjZCcS8wTzUxbWZZWFc2WE1T?=
 =?utf-8?B?QzVVZjNUQjZxTnIvWFcrQjhMeHdySGlvNjY2ejg4NFJORmQwWlF6LzdaWTJs?=
 =?utf-8?B?bStwajlYWUxvRTBCa2xQd0RVbjRmMS9XUHlUMmV1TmtlVkxCV0djT0dWaDR2?=
 =?utf-8?B?UEYzVCtybUlVY01YV0RLOHpVNVV5a1o4VmdQT2V3OG1oSjhSeHRIM1RuM2F2?=
 =?utf-8?B?bEg1N2NRbUdDNjN6eGVOekdHU1doQk5tZC82UGx3Q1gzRUlDTG5KbTNWYmFr?=
 =?utf-8?B?dndWOWttVkN3Z01HTWxTUkg0L1dYTmFYdzB0Si90RjVLVUFXb0FUQ2xPUUR0?=
 =?utf-8?B?NVlybHZWSEVTdWVXMmpZTXhGaitpTjFHWUQ1NVg0Z0YwZTFhT1doczdaOGtF?=
 =?utf-8?B?bmlLMVJ3T0tFcGsxM0FnajduUXlnYStZMTkySUtJT2FZWFVFM0t2RmhWWFEr?=
 =?utf-8?B?VU1Qa0s5bDY4Z2Zualk3OUVMTEptK1lrTHpzYmZ5bWJqUW9qM2ZjYzhUUFFh?=
 =?utf-8?B?ODZtbHpLTVU3V0h5eTBpNWVhTGVWSm1sSGJLLzluOHFKTEdKdDRsT29TaHoz?=
 =?utf-8?B?VlBIZnFGanB5dGluZ2xrcTMveFhiellPVGpGUDdxV1FsRVVjL1VmRHpnR2dl?=
 =?utf-8?B?SEhPc1ZkRm53dVBzZnVIdExFY2VpTXNxMzFBQndIRUlCRFdYeUNZVFZZa1l2?=
 =?utf-8?B?cGlXSHdXQ1NxbjFlMDhmUjBnd09pbi9TV2dVbUJSM1JnZk9udjJER0M0cXFl?=
 =?utf-8?B?ZEFjaURjdk9EYm4xeFRvNTcxTkEvV3ZmaWRoQ2F5YW9EVzVJVXBpUjgzRXVG?=
 =?utf-8?Q?sLBT5TUATIiq9xWY=3D?=
X-Exchange-RoutingPolicyChecked: Oc9vLVFOWhGWuHWXOVZMgLOb+fDZymMMr8IvKvQBap54RbUpYH+8HpYMGR6kgWQYqeyrGRYxbyyJwponW7hkacTrwi0mhpQ+iEv+DAwVzdfebhqbKoD+ZR+ESajEH1P0Xq0lZikCXxUP4azKgt7KOo5nM5Yp2bMitkjNMfMloTiBggnGXdqV0UyKV3zNeMFVvrjb/zCKcaynNeGdLtctrUGVoJpH5QPUBwoKYQu94qtEwXZgk+TdCR1Ewg6IJAxoRRA1UOky1u4a4l3zPDcwBUY4aMuuEL1SYUgpiaCqQq8UyBaRbNYxjX33t8SyyQmkGEKKaM7sbJ/RWcd+v0WwzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adbe94c-8b1d-48a2-2f7c-08dee28eb2a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:32:44.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ynxc1f90VdHVQ3trSjJS/gGCJMIvCeN0hJa7LZzom3fuO0NzKSVzGi1sHHLhs8ITsdOD8HIKZY5CWRb7iJQDUxmGPkwMSQcw/+C42X0HDQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com



On 7/13/2026 11:29 AM, Larysa Zaremba wrote:
> I have addressed Sashiko's feedback for each patch.
> 
> Those are the only 2 important changes that came out of that.
> Please, notice that the first one is not a functional regression, but a memory
> usage issue and I tested the change.

...
> Other changes are of much lesser importance. Look at particular patches for
> details on nice-to-haves and false positives.

I'll be submitting a v5 with these changes squashed in.

Thanks,
Tony

pw-bot: changes-requested


