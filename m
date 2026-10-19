Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344E3F12CB;
	Mon, 19 Oct 2026 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409148; cv=fail; b=kaXNIBvi4pi/t5Q6szwm5QhtdGbPWZrDpSMSk1gkLX1ppMdX2+m+n02WJKqHOLI1pKvag7AEMb+wklIXZRHIG9NgzNwjRk+OmurRv27cXPcACr1ibpLi2hy8Tx8MKNBNAJJDQpKfGR9m5VhOaKFOO3jALUJ+8I8ARhWzgK1HjBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409148; c=relaxed/simple;
	bh=h2kt3G+pyYm2QIrKIawn+gK8L4eqQfMoT4gShkhiHSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L90dNLFUCkYeheFK3lH4uMtqqceB+yvmiS3pEPfST2Ng1NMokWJtO+abG6/20CO+taXca3UiISjnHEX16GgWd9NJ6Heg/6SQ87yO8dCHJ6UoNCA0wgBR9v4inLPLFqMoVy0PUsC9yr6J9konsTkdrSNHa0+6eLEhZsd9ZfK9YzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOhZ1Ulr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOhZ1Ulr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792409147; x=1823945147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h2kt3G+pyYm2QIrKIawn+gK8L4eqQfMoT4gShkhiHSk=;
  b=cOhZ1Ulrxuq/JWSKyUamu9WGEwirk0m5qzlZD2NitlIKfb66tXt8kIMc
   iFA150p0ZGbNkcBjcKpW2O7EM8AyRLe0Oswv466tFKqKfo7eDyPbwah7L
   dKGwJgLy6+8rCnlufQWSX8Xg7Goq6dyGqj3h7oYyoliiaWQW2YhfHs1eZ
   sEI4H3XnCi6ekp+L6Aco0qv41K07YYzzvULeUZ1d9Z+oIM2zrTrLa8U72
   mpVSpbzgA3tCrSNI6F/w4geDeiGYjUXCw9BVdS/jYkqkb3xMek+B1LxfN
   kOoa2tXe5pCelG/71+z87+sfNJhLrJb0+FkUoTxfEl7h/N5sXH4/lQzsg
   Q==;
X-CSE-ConnectionGUID: y4FLKQFARPOXIgQ0BveNbw==
X-CSE-MsgGUID: q1NKfXP2TB60atLzJtJ+Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1089213"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1089213"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:25:45 -0700
X-CSE-ConnectionGUID: epQ8jejASROFBgRIO2lukg==
X-CSE-MsgGUID: 9UBMr2f8QTO0FneA0WThIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2914685"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:25:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:25:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 04:25:44 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 04:25:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjSuYAR9V5lJFv2rshdJbUd+6CiEGnNYto1shsAq3wStAUIcPY5B15pvrnfhtsHXlidRF/2nyhWhptB0j+rOH1w/6fRKKaEHEih0VmVfwM/jPdMKkwQu2eyyEaxHaX/lHJMVAlrh2dXg9oC2w9cX3siXWf0Ve/HfqmgbNM8Lg0KXfQ2ewFNKx4A6YQAQeBizJ1dg7RulzdBtJ96nQzNGNuPw3SUbTWoqmbR1wmTW9M8V3f2Y+crrWyGry8k4vF2wkudagdFF0br+xGZyWn0gFKEuhhYj2CW7OKoydQvLh/nqHVPRY7XgxTFBz8vwJgq+QMgBf4VC66fVQDLxEOmrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCV4JYtAck9qF0rPtPoCaaS02lD+Y0r23u1simK0tWs=;
 b=jxo3kVLeAdbrDfV3leS3D6heqks7BSr5QpYgZesmjqvJLRbDjHhNu+l3UmYfx24/DCswQHVybcygyN0XspBWCFTWbQqBR4QVwZGJi+AZTu+WYWXfF8LfjgfMSm5CgufqNoKKSbSIbzA7Q2pjsKTV1/1e987gRJQcfu4knmBbDQw0Z4bZsCGNsGbuyejJuFUEuCY5CHAgZ8cGjsDen25Pc+ls/1giwbp3TQ24O0A5+54Ok3+mt2MRhso2avtfN9Uo16FZ9RuJ/21B+AJTppvdjV3lmf6+1EKk758+ykgV8S1hFWaZzFl4LR01+WKq3xlNfc6ZLQYlnCI8t8WI7n3aCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:25:36 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:25:36 +0000
Message-ID: <b16237b9-170a-4763-828c-1be8fb4e8091@intel.com>
Date: Mon, 19 Oct 2026 13:30:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ice: check the full PF reset polling limit
To: Aaron Ma <aaron.ma@canonical.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Nowlin <dan.nowlin@intel.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-2-aaron.ma@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261019105155.3793063-2-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: d70d77e8-75e7-4a23-6152-08df2dd3b248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KorMDER2iX0tdx5Q5z2kMST83CE8o9jUBMBDszmHI1nBUvPZI9lxvorQ07GkR1+SW/NVsEb/algjj3UuivL5nXmoZBOfBx1KP+7fICSxruafXm4PopeXP5qKSYS31MHHhp3SwGLY+FzLV/PBRGfVVCMjon+NGpqgIdDEvZ2yME5QJD7EAlcSqPcSNv8sWepOErPX1nXyOfmhIaCMv+AXmJJ/2ED6PwvWYr1wyVC5ea6TofIkhkleUjnV1i7GlhDWDAdsmQKbXfFwN5M3PuZaJf1v6JbAjlZRQvO7gZYNZlQgUY/bvRAmNAVn9lvSw29ksPnh1qjcNOMobhW9JdjxFhbhloU/p61SPduUtb8Mc0N/IF9wfXbKsImaP2CoYl2QX54uhYANeTl8lMCd00Xf/F6X/gNkEvng21LcKkXHUfQFWKu5jvQTFm5iIaT+h7vHgvbo/Bf48cHKsZpiT1Z7R7NXz3D0jbDNWklruMMB6yWTf6ms8Fg7y8Od2vRfLR3cou28HPaN9nuEFZXyKluFdhobgOxkkJ8HYLHyy/SdZ9FXVDAYmjAO7k2cEDgpjOKXiTfQJXqZns+l0ILL6LWLXmhg6NFSu8N+fQGmVoU4yrp3+XdliCeE3lyhowhfmVX+L9T92vCWdG9vKzsRIxWcQt2mtuKD1p76FF4S4sv+DyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRhakZoQkcrVUdTUGJnZ0htZTNBRHNQWnFlYnJFOVc3RkpoNXNzcTR3NWxu?=
 =?utf-8?B?Zi9UdFhLTkxzOEwrU3M3WFQrVzQ4R0l5djRhNnhxc3BrRVp5WkFZSWlNNk5Q?=
 =?utf-8?B?WFBmbDZSVFN0bHJkOHJtUVdxajRSb2ZQYkdwbUQ1MHFWeWExenM3a2RlV0xo?=
 =?utf-8?B?eStyWkZzQlQ3TVVQcUF2TC9LNE5ZSDdMZzcxcEdjZXM1bHlEcE5xSG5ES0h5?=
 =?utf-8?B?TWkvZzZVQng3VHc3K1N2dzJONjFrRGh3N0Z1K25PTXlIempRUGppb1dMTnRX?=
 =?utf-8?B?SlJaVHBxUnMxREhWQk05REdHenZkaUU3MGFJSzFkaGRQaEVJbzk5d0I3MjlF?=
 =?utf-8?B?VTF3Zk9WZUdNR0ZjTFdVdmRKeEJyajgvcEpPZ2pZSUszZU52cUdQZG9IRzFa?=
 =?utf-8?B?TE5hQkYrWktvbkF6MkwxdzNsZW5TWUF1dmljTERzRW9tM1dTSkt3Tzk4WHR5?=
 =?utf-8?B?eWdGYWJsK1AvVFdORi9SelBZL3Z3ejhuVHNhWVppeTYwSlloMGFmTlZVQmZP?=
 =?utf-8?B?ZG10eHRtME5LbmFYN3VDWmlKZERnUVc3VWxENlEyN2oyV3ljR2VVM0p5b2tJ?=
 =?utf-8?B?SDh0YnJlQ0ExSzlMOGlUOGhLaWtKS2FFVGVrVE1uRkg3R2kybC9Nclpia0VK?=
 =?utf-8?B?SWdRZFdEZTYweENtRlo0V2x2RUM0a1hFWXdWR0N3UWI0NFM5dkhSdExkekZI?=
 =?utf-8?B?Ukt2a3lXcktIVVgzRVdoMW9HK3VPRWZyL2F3RDc4L0xPeHEwNXFaN0RXYXky?=
 =?utf-8?B?S1RLcE52aWk2dmZaTFVpbzNpa1V0UUhETzBaald5TnlaZUNjMUJwR1JXbDFE?=
 =?utf-8?B?N0Z4ek5TT1o3YVl0ZUFCZVpWczBDUWVzU2hPMW5jZ1VMaGI3bjFVZEp6aUhL?=
 =?utf-8?B?OXpwcUlGMS94dUtKeEI4ZFpab1VPQ1QyLzVaTS9xaTc2Wlo1NkxlWW1SVnRB?=
 =?utf-8?B?blkxNnJJN2NvZUx4aXBVbWlyYVNoS09ML3M5bWpxRDdRQzhIZDZVMDZ3MnV0?=
 =?utf-8?B?ZDFwS2I3eFBScnNvL1BEZGM2QkJwRmY1clZxRlp0dmxZSis5N0NNTFlFRWpW?=
 =?utf-8?B?aHhUbkhGL3poSENPWW9yY1Zwanptak9kZWlTeGpDblhicUVJQk9qRzJubTE0?=
 =?utf-8?B?bEN2Zk9YdzZNUWxRZW5tcEZkYllERURZSkFSeEExTzRQTjJmMFFFYnZUTlFj?=
 =?utf-8?B?MS9ZYzl4MDZCZEVzQnh1QW95dzA2bnpFc29USHlyNkliTENnanpqeWRhUWFB?=
 =?utf-8?B?NXhvWU90MXd3K29LTDVnSWNiL3NHUXl5TzZ3Tlp6UzE0SzNCamw2RERveGww?=
 =?utf-8?B?TnZmL29nM05OK0V5K2liK1hvQkhMcXBNOG4ybU5XcTVOSzR6NlhjR2ZISUEx?=
 =?utf-8?B?VHRCMVJLNGRKT29XL2c1YVI1UndOSllwUnFMWTNSc1d2d2FaNDZuRlVNMExR?=
 =?utf-8?B?SWpyRCtkaDdsMHFrTVcxdG45SkUycGJ1clp1bzhXWGNJb3lsVGNjbXBGUmRo?=
 =?utf-8?B?Tnk0cmt2Q1RlTWJQZkRCUzRDZ2xZUndFVkY1NDBvWFdNdGk4ZUwzbmhYc1ZD?=
 =?utf-8?B?N05NL3pRUnBDMjRVSjBoR0dSRE0zQUdSeHpmaXlEaFllNUErSGhDUDNHU3NS?=
 =?utf-8?B?djYyKzRxOTVKNGt3UmlsSnN2TnVCdjRuS29hR1lremlmYWJOWVJUbjV2YlBx?=
 =?utf-8?B?TGlvQW1Vd29TOHJ6VlRZd1d3dmh6dVJheXE2d0xQcEVoWldpbUc0YmdBbzlY?=
 =?utf-8?B?aFVxV1VlbytyOThkN3FiRjU3TVZ2YmppSUhOc0Jza0NSYS81Nkk3ZHk4VE9q?=
 =?utf-8?B?K0VRaVp6ZHJiWnB4Ukw4MTUyWml6MGtTdmF4dkRTcGlxb3lkQU1icEhadkhO?=
 =?utf-8?B?bW9rbVZ6bTJYeE5VcnJ1eWNBTEk1OERVNU5NUDhiZytVMUNnSUZJQUJXbHV5?=
 =?utf-8?B?ZGRaMTBxNWFVV0FQTVZSdGU3TDN2QmdGMXhLWHVFdTQ3cHg0Um5vb3JqUi80?=
 =?utf-8?B?SWlQSXZIbFZ0dVhBN1liSitaTDNZaHpWYnFPeUthcDEwQXFPUUR2ZUVicnFy?=
 =?utf-8?B?ajdHOXJBS1RaaTVEUHRVM2ViZk1rV0U3QnljUTJ2cTc2cUtpLzkreTdtd3FL?=
 =?utf-8?B?d2JienpXSS80VlZwYkViclRaQ005OUlSSWtmZkN0bmgxUm5UTU9iT2JIRVg0?=
 =?utf-8?B?Z3RUSGMzMGlNSHZINUJ6dWt0cUVQU0ZFd0YxYy9GUlBBTkdzWVZBdngydnJh?=
 =?utf-8?B?L2RoWGFzcHVoaXY0WitLZGphbitMeGNKREMrTHB6YmZPWHFtRHFZMFpFSkdX?=
 =?utf-8?B?bGtwV1RtVCtORytoTFgzZ2NUbUZtWGRmSnpuMVQ0SVZyTG9GMUtCYzZnbjk1?=
 =?utf-8?Q?Hqlq0PYF47WjLZQo=3D?=
X-Exchange-RoutingPolicyChecked: i5S0fUMQypoi3kFNbWjS3mJjhsELE/y0ef/QEwn8X/wv2DA4nkqDnQhpBrbOtnobURxoOF1p95txUhpxiXca8ibeLdMboevAJHB8PYxmJAjwL5He1E+QQJ1aCQWDg51zi47n+NDX1ZeOhQqfclkA2nbaaujRFygdoeTMAh1uG/2TB3G0OOfBGUR9O7TW6kCIeDMsyyltHnuG0oB3YT6US2Edm3czdFSCjsan8XaYs+49n2GfbgWxZdi0GPMOoxwfV910evv5Epq3YTtxDQoD4mwj9YNroFGjkFfzr1pwybnFLQ2sNM0bl8dAfD+NoD9BBavLkYBRzvIpk+9DzmHH2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d70d77e8-75e7-4a23-6152-08df2dd3b248
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:25:36.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuOGeN8GKlF+kzvi6aBn/H+1wWHRaSUJ8BIvM3Fwdz13WOmflqFrtiGkvEPip4wCOFhEwWs0LkhWNrI+qhayqxXZSEK9NXj3vXp8Ca2/vnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-OriginatorOrg: intel.com

On 10/19/26 12:51, Aaron Ma wrote:
> The PF reset polling loop includes the Global Configuration Lock timeout
> in addition to the normal PF reset wait. Its timeout check still compares
> the iteration count against only the normal PF reset wait.
> 
> Consequently, exhausting the extended loop reports success while PFSWR
> is still set. A reset completing exactly at the old limit can instead
> report a false failure. Subsequent initialization must not proceed on
> the assumption that an unfinished reset succeeded.
> 
> Compare the count against the same bound used by the polling loop.
> 
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e61..82b803e74aac0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
>   		mdelay(1);
>   	}
>   
> -	if (cnt == ICE_PF_RESET_WAIT_COUNT) {
> +	if (cnt == ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT) {
>   		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n");
>   		return -EIO;
>   	}

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
