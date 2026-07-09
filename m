Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41F41CB47
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614249; cv=fail; b=jpPLWyFyoDqn8uVonq7ksn3p+39TBPWz09auhYLnfIBZP3m/bi4sQPohwt3vTyv+jsy3629YDQ0e2HIGrf6BANnoLc2pwcszaI0/Ua+pjDNYtUWKH6nbFXRYwhxbA0feUSZ5K7dhM3M0Y/JNoOMs9T1/w0D+sXfEmt72PHH3pZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614249; c=relaxed/simple;
	bh=+9CHQPoVXUL+UL2XXkAcaOHN2JN2U3/zOdUD+W1/cAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HwztPCtumHvbGcMfMqvKGAXANDaqmd6njFkUa3JK3issekHzDJXqzmAlE8LM0fihTp+e7Z2DgUTZw7WYkZT439l1VTOQGatFlFWeCgGyDu2yfu8Qad9N1vLpjWly6UGsq2z6jkZgM9/rWeXXnnPsNGkiJRrw1ZkvaUdgNWupX4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWA8Bdb3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWA8Bdb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783614244; x=1815150244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+9CHQPoVXUL+UL2XXkAcaOHN2JN2U3/zOdUD+W1/cAU=;
  b=RWA8Bdb3x+Rury8yIC/Lm1U1jFuL8KR/jUYj/XrxfU14E7uTMsE2Mz7g
   AELDwZSQYGBEbThfBgCAZcvnNno87/alHgKGanx8w/saygmZSjyZpDff7
   QGdWlN4du37lzxnGyBLXAtc/WIKc6bTITVF9qlokwdeMuqkyY13FuXNjm
   MeUIDH9Bu3PiE1EoNgzCHg/0vVtvXGkD9l+96urcBupxjKPTxr/tbNycB
   4htAdgeJFT02FO0rBSff9FV68FS9HC5TTSoVLwX3BRWPMLRvvhde+uOR7
   SfIpC8WNZVKcxH19a177Ato/Yt8rGNfjZAzltCc1E5+L2Do3Y7ubBrqDa
   A==;
X-CSE-ConnectionGUID: nuDcSFCNTgOmrmGczRStNw==
X-CSE-MsgGUID: YFLWJ58KQzSorKBa69ZrYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86846838"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="86846838"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 09:24:02 -0700
X-CSE-ConnectionGUID: yg+UTzXjQKqjoZoOna0yWg==
X-CSE-MsgGUID: MsB7TcCuReCvYvZRAT8T7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248264997"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 09:24:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 09:24:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 09:24:01 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 09:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANYKm011OhbMueOY1w3FL+FZ6htOEZLeEjVmegiIPAtZRfcfP49kJa0byGg7FynYNKpbQdCtBoD8eIIBOpKSTq6BZ/kShHFWbwrLzV0YQ+A0uzTgEG8DKks+Wnj6+pZ2x8FSsl1FOzI/EznSOql1JUWLSEkAFtG6kFqxGinQlerTB4CxkLBYXVuqhTMdG5qSY8G3ktF1LuPtHxMlunlYdqZPrV8/KfWHr1GdZ4YePJn7phswc+tT7b6XhyXY/NWoD4fC5rwDJHcZVQK6epFDSra0K5dpr0jiQZKhDpMwNBOcaBscweX9dPypwTg+pc7KMOf8Z5ZsjgvLO8p3nL6O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6g1tHKaxRjr3mw0pOfB0bfdu1pWYpud8DOvkj21rus=;
 b=mktOhI0BHsAehkLyFriHrNJgSzgsx15/oCHVkaNqzpmNIxj5BlbrhwbdCzdNXlRR2A3wg/Muy78QybY5obLKv33DVkCxULss4X3lx8thaZebe2vEyigBOwxw5aIZ9W71oJ41+Ffq8QjmYQD+X0VkScs2yoXLdkXaNcYFJhWpdFxkjtC2N7HP+5a26Ol93eCjoZmPviMy8dT20fkSdoN6g9Y0095sWWc3OpzJj9V/c0fbiBP79E7ov4Nd1OaFOQMxVi5mCyPDepfsrrxWAV6sk6bCkzq5ocaIFLPrJfiNaWv578cPF+uDkFvEYuMor2FLTt9h7TvQjc7fdCxyw+D6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 16:23:58 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 16:23:58 +0000
Message-ID: <b531b910-defd-465e-bc15-f4eb6720496d@intel.com>
Date: Thu, 9 Jul 2026 09:23:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates 2026-07-01 (igc, igb)
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <horms@kernel.org>
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
 <c9ccb69f-43a4-4462-9dc8-d08aec7ca433@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <c9ccb69f-43a4-4462-9dc8-d08aec7ca433@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DM4PR11MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: df9616b2-0f04-464f-c882-08deddd67ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xpDsNa6T6Jr3UOZWF20yFROQK9wFL5NSClRyEEpr6ed+MrJFPrCHgJPy09I53SHciwlWHKZvQKhvS1idNMGqRHieezKFLIkjqAbZWq2Rf3swbjiG/klfgRNta5ya8MDeJ62HL9fUQ1ZA1/ex8n0yctPgRTVB8hO2oI68zFdnF/pZ1GSgPpTLsgHilOfeiWrdVa+TSXfO69lU8w26sZWOruXwfPowzvpVsAL4Ms8pWqRV2m0HgWHOIPonaRkvw8zNchXyU5ef+JyWwPufRdq22GNPeuOPZDTcedKan6LlAXR0bdTePX62kScWyZ3BbGfAsNCQl5yp0P8DBO8cHQdELBsZpBoq3R/Lg/GZfohrkThr4ZBFRdRnDqTa3PjW1GX19sne2Ss1cUkxKKY0xRWUDBWPfIzywbl+FeW19AAnipVkV6AH46g7h+zxFFygEerbG78izg14jdHg65WTZddC1VX2wQnOqzSCyx8gT3lSw/+alrhnuUXsVLZx47Msrsc5pESy4zSVJqigT26LDiLUZZdas/W3TULub0pmD8IZn7JXLxuZsP8VmfI1YZuypwVFFM6AwkbC5hvdx6SkhWkLnPocMq7kcurXMXF7xqxK5is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3AvYnExNlVMOEd5WEVYOWtISEVWbkFRQkFnbC9NMWg1K25rMzhzVEpEK1Jj?=
 =?utf-8?B?a3NadStSQnVjTjg1OCtFR1RkZVBUNlNwYVc3d0tNb2FPRndMOS9MNWZwTWl4?=
 =?utf-8?B?QXNVM1hraVJPMit0U1ZSMk9RVklzcHhPbFNITzlBaTBSZGg3eEk0OFQwM3ZL?=
 =?utf-8?B?SkllMzZNaVAvR1FLUVhycGxiK21ocnI0QTFpYzFmNUxrbVRVZmRsQjVqc1Fn?=
 =?utf-8?B?Q1dDM2s0ZE5OZkhZSjRCU1kxT1V3M1h4VVNxOFVseDlINE53NzJ4dTkwWDM1?=
 =?utf-8?B?YXpjMDNlMVp4ZlRBVElDL256Vjg1eTNZYUVZbndsRTNRdGhmNjZIdis5bjFt?=
 =?utf-8?B?aDRMWnZJY2k0eFVpcTJlWHhoV0t1TzJaZ3EzN2RMckovUnp6cXRCQ1c1a0FP?=
 =?utf-8?B?amhwK3NGTVdFSGJEcXZ3bmFQbG9XcWYrME9QSVFsVjdoVXdLY0QvZ0plRnRT?=
 =?utf-8?B?NnVqbGFZVk5BMDFHWnMxdnllVEwxTUhSaG1hNTNmUXJZdTkxaGNnMWhtRUYr?=
 =?utf-8?B?ZzZkbUFBTzZoUjNmVzFLdCtIQ1h2ODZYMndrMVd3MHBRYkhXSy9RVmIrU2xI?=
 =?utf-8?B?aTZacEE0MkRLaUhzYjF6bDRZTFlzdjE3a1Q2Y2puWFVtczhGRkN4RDdtZXVi?=
 =?utf-8?B?bGZWcDgrT0ErS3VlSStCV0s0MmFaSGZ3Ky85ZXpZdGQ4QXIyYWxJK1UvZ3Yy?=
 =?utf-8?B?RlkwZzFSby9Za09PR01tcHhPNm0vSU1Oa0hHNVM1TGg1eGg1MFo0NVdXWjkv?=
 =?utf-8?B?WkM4eHBOSXI2aTYyZUUzamZpQVJYc3d0WE1uSUZHemJ0ZGxZSHB1ZTFhT1Z2?=
 =?utf-8?B?ejBqUVArb2VielN2QTJiemFVWXJYWlR0RlF3V3hiU21uNm5JcTViNkJSeGl3?=
 =?utf-8?B?WW81YXZISDlGWHcrSXAvN0s2YXVOK3dYVFFQZTVkRnNQRFFkd0MwQ3BtUmNS?=
 =?utf-8?B?dGIyMll5U0Zyam5hbUFsSThuQ2VpbmpEWEl3SE5Ed05oUDh4Ty9MZjZVbS84?=
 =?utf-8?B?U0FvcGtGTHdHN3pHQitjMkF1ejlSY2w2TUh1cWJjYWIzN25INTFqREhjTXBW?=
 =?utf-8?B?Qy9ZWDNEVE1mSm8wUTBtNzJtMWczNzh6aHJCUitCcjdiTjFxNHZSMjBoYVZ6?=
 =?utf-8?B?VzJubXdmcEhlQ0RvcnA3R1BPYnN3eGhzdUlkOWR3WG15MHg1L2dEVXNZTTBx?=
 =?utf-8?B?aXNuK2ZKeDl4TUZBWFZXNm9ucGYzaG96U1V2ZHkvUkM0SVB5Y0luTmhITmYv?=
 =?utf-8?B?ZC9SVUxPdkJFMzg5SGVvZWkxOHZGbjhCMGx3RkNla0l2QlArbUREWm82bG1H?=
 =?utf-8?B?WTdSWXhLYzlBRVF1K255cE03VFNPM3dyb25QZE9yRjZBOGQwZ2VyVzBDNW10?=
 =?utf-8?B?UjdpN0JLeXlQbEMyZFhyQUVlb0thbFp0dmhpR1p1NFhtczJ3QVJhLzhmOGtv?=
 =?utf-8?B?NWEyL080WThWM0F5WEgxVDR0SHcxV0pCTEJSSmpjSS9aQ0g0eEYxSVVNRkRz?=
 =?utf-8?B?RkpyWDdDL0VkSzVKNmtuY1d2bTY4cFhpMXRNN2Z1dC9ydEtadzZ3WU4rSXNi?=
 =?utf-8?B?T1Qvd3JiYkEzWmkxMHZYUEwydnpzQ1lZZGpsN2x6Z3A4TlpmSGhJSml1U3o5?=
 =?utf-8?B?WENZUHhoZitNRE9CNVhLR1ZxVlR4dnJSZ3J0bml4VFdyai9nWVBnaitqUmtQ?=
 =?utf-8?B?U25ZbkhtZmhtOFpLUmlpTFJKcnVURnk1Vzl0WkZCZnd3Y0lKSUZDZTNhdkpO?=
 =?utf-8?B?dmxnaXppN3BIdytIbW4yUkFlajMzUTBydFVFY2tMTVRhL3VkWlFpZTliaTJH?=
 =?utf-8?B?OFhhU1JqVHlYeXZsV09NZnozSEFlMHFQUVErZ1hEZHcrcWdmYzBQdUJSb281?=
 =?utf-8?B?bGpJRzZjbGUwem4rQVlDZ2dYdlBYZUxCMklMcW9vaCs0ZnVTTEhvRzE2aFNJ?=
 =?utf-8?B?WTJJdDZReVZPdEg1SXo0ejhIYzlpZFE3Uzg0MWlEZkdDSHFheGRZWjl0YVJs?=
 =?utf-8?B?TGl5Ly9tWVgxMitIZmptT0JjcFhIRi9KT1V6cmQ3RTBOZEFrSHBnSXpwQmlS?=
 =?utf-8?B?WFdURnZOUVVlYXc5TVI1N2xrNDEyNFlWUjhNNUdxajB6akJFRGZZa0dnYlJX?=
 =?utf-8?B?anZRQUYzWU9ueWV1WjYyc2VZQWhlK2o2TStwellqTjQwRUdGcVBLQWNMVHli?=
 =?utf-8?B?RERROU5meVNqZEhCQldOOWdRV3daRnV0clhxNDd4RFpqbzNYa0xmT2twSVRX?=
 =?utf-8?B?ck1FVlVyVkVzSEZqMTBEalR1aENpeElMN0ozSTVhN2JCZWQzNEExU1dZdzhC?=
 =?utf-8?B?Q29MR05ySjZKSk9uY2dlQnZJUm5MQTc3cFBQcStFaGtscUZmNEZyQT09?=
X-Exchange-RoutingPolicyChecked: eNtovtHA0y5OzywymKSylOtbnNHzVKR/hTM+vqQWvP1fDn4MszPZYHm8D4UY8u3Bbnr7TZgn8ZEW/iKEZyo6fiHbyxrSf4dmbIadDt6uQQjGM/iFvTF5szGZ9e/QsoeENsYjjuHcB+rEAThRfeW4LFo28NQdSnNnohSTgbHkiOADAb8dZo2GO3ovLvWdlsfDSJjPwclJdk79WvzTdIkH0/aylZcfnYpNIui1/UBDZbTyNzzijzf6FcktetWHQGJ9S5L2EAfi68SQ6c2Ac//N549ltTr73wJ9zheUthd7KuwyTNwCXDJhdDU3z7b6JlOKRx4eIbFkY594L1BR/XcpPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: df9616b2-0f04-464f-c882-08deddd67ac5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 16:23:58.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyvwsAulAVK8+Cau3MbHcSpxZmgDbisI72er9Ky96SpwszgSx1LoULuWEb/kOtoVQRMc+2TVgxO/LYFx93n3m6VNXcX58cKYFcLXrzlM3N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159
X-OriginatorOrg: intel.com



On 7/8/2026 5:41 AM, Paolo Abeni wrote:
> On 7/1/26 11:02 PM, Tony Nguyen wrote:
>> Kohei Enju adds ethtool support for get/set hash key on igc and adds
>> setting of skb hash type based on values from Rx descriptor on igb.
>>
>> Takashi Kozu adds ethtool support for get/set hash key on igb.
>>
>> Faizal adds support for forcing link speed via ethtool when
>> autonegotiation is disabled on the igc driver.
>>
>> The following are changes since commit d6e81529749190123aa0040626c7e5dbc20fdc9a:
>>    Merge branch 'net-fib_rules-rtnl-less-rtm_newrule-and-rtm_delrule'
>> and are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE
> 
> Sashiko gemini has some comments, please follow-up with them as needed:
> 
> https://sashiko.dev/#/patchset/20260701210303.1745310-1-anthony.l.nguyen%40intel.com

Hi Paolo,

Will do.

Thanks,
Tony

> /P
> 

