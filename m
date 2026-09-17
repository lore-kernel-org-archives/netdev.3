Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72472547054
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668212; cv=fail; b=uELKkS172d+zUIJ1WZReunqXnJ84BjBcpgAq7t9QIHenxht1oJQp7hFMfjlBFOjXrfIKw6+1PT17hMg0JEOx0OoXzjo0jhZakpLLMfJZ3uJCU50kPAXvUf5WEro8UwIfWM+gUHL/O7dqVZpHzpXq/43NLeKH+o0kCwiRR61X0Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668212; c=relaxed/simple;
	bh=4bUXebbVBfj3WocymwKRCZGHcwtZaLbgU4zDzVjsVZw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ttviAsES9BeiGMRQVUduQolgXBADXKGjIKnXsbZKZUDZ5feWBum4K1ZntF9DVaRN0KkoZcyJogCAoKAynuK7MotpDtAx6E2gRicx0ueXmmiA7xYT1c/p3cq0e/d+rc7zuuQpiGtlbfT3MdFyTvAkvtHkDW12p5L/i6M2321ZqA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDwXzs/C; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDwXzs/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789668211; x=1821204211;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4bUXebbVBfj3WocymwKRCZGHcwtZaLbgU4zDzVjsVZw=;
  b=nDwXzs/Cx9NLtZVxoX/OD/LIJuDGkWbU/8IoOH7rmc6TK05ayfuNAZhS
   CYD/Ot3m92w74H88bwYUnt769EIiltCvxShcdcHWV3GflquTboM71b3c8
   GON5U0FjqJWdWQ2C1hkfe8dW7Zcz7gcyNwE2PsTLrA7GC6RTwcfJUf/ol
   SyMctZmQBNmz5tz6ICjF0mgGmvoxbbjpracVJbA/TyGo0HHblIdHnQQ4H
   9lLD50VbBaOU+0ybUpK+52v/ZtuRDdkA/qvGpruw+plwpb7jp3cXJOYNH
   yGwOtixo5K0aB0B6wrLFcGimiDask+uZb1piANp5spv511KVXd9N+w2Jx
   w==;
X-CSE-ConnectionGUID: 5mZ8CYZqSkGawj2Ku5x76g==
X-CSE-MsgGUID: C3w7sqmPQTug+JHzQx4xJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="629267"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="629267"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:02:50 -0700
X-CSE-ConnectionGUID: hLLUh430QnSm9wT8fbI2tw==
X-CSE-MsgGUID: co5ADwRzTJOZZeheQYMJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297429301"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:02:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:02:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:02:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru5xpckoZ/hT+SMHsqLspV1fTH3dDYsTLMo7GOJx8yEtk3Y5Nu9/pNF3iJ37+tRMeEPvZVue9JDQ3A9yYeYK0lEsrWmbKvUCdpXBUu0u3CbGxG5CAkntgr796HVRFvN/pfJS/GxTwvWBBAXlExY7hZrca4wZxxOAdOavPheqY1t4N3MhzUeSnXhCi+Q+wUaR4HeMDqcELKD404bfBqRwPAKHxYNlD77f3eggv2wS9fUVcc4f54VGdO1gqlC+Pubu94dzvB/LS3Va2AisRzTNP5GIsLlW4mEtysXvH77QqMbuWqyvKVg5EC7EeRw1C++cmjPlcBvCDaB81A4/MkDwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsE72jWQG3IW4bzN6IBcpt/wHt2yGRz3ISSikey+mrU=;
 b=rakr715CalBvY565unHrK8X76YArh1fLagjdWRxvykzDXaBLIIcj+SpjF4Z7/bMvAzB+m1yDc0JYz6Amo4G2+U+qYPCzyD6cLuFsNFjWduB7m7NY3oRYnyFLF15gGGQpl1q1q8dVZ3cZfeyN7gcySXF0QN2GA6nuWQqvvZ+NwSOvlxVhOEpKnpmhJDAb0OjW2nC31j7HV8JSU8zdodR/CCHCtjf4qOS55TSZlL9J13uoTf0fk3Olyd8fzEjA3glKLJ8FZZ9scnmeDAvYcfl+EKLdDSJtcyVG3F+ltA6Ozy+7vsIdqeRygFgVr4q2jM3RLO02wpTl0MhKzsmL7WpFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 18:02:43 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 18:02:43 +0000
Message-ID: <cc8ab06b-ed9b-4ad6-a775-ace31e4e4545@intel.com>
Date: Thu, 17 Sep 2026 11:02:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 15/15] ice: Recalibrate PHY after settime64 on E825-C
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-16-anthony.l.nguyen@intel.com>
 <20260916011228.1632848-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011228.1632848-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2b110e-2f14-43a6-835d-08df14e5debe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|6133799003|3023799007|18002099003|22082099003|4143699003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: uX/UuslAaub6eO3xw6lIsVZL9FR5xirf7aazbQ0MK2+Cp55I0ryO4ElBfagbQ+lubSkkg0U9KHi8I4j8XWIh669V10JWW4fxcYwGG9b6q/LSezgDpHLwYRBqK7H+Egoru+Uu9on7GchB8o9Tlfup01zL6eJLgjaY0288isOqDwAXawsWAXfui14Gva4KjjrnEHirkwZm04HnryNU6GzgG2cJkbxq62tey1kA4sCtVgwtTshM5LZ9aVRGfI4FHhvt0Tr+F3EK0Orjx8YXSMi4b2veUndC+XmfV1Uy/WeSnxj3xKBrS0QmQXARyNj9M0NAuLoEVnh5U2J4Rvtm0li0lPf9ySOazkX5nFxAtacawlWJzCJjspeNGBGhrpVNssiYwu73nVHDUG8buReUqxIYEv/dpuJyNzxTeA1i1ZwkC9eRjseFh2YpIajDgVWWBHv1zaSlqMsv9K3HTPQtJYiQhU3xDCMeonqleJK8i7btxSVD0xg8vwaYNCP/2WxF+0xIIRgx566uPJ2xsN0G1D7PRnHygQWm6kQB47V0miAJyLGGVsWAAgvlbcxihu8L4JSsdz5ak96k9S/Z7lGHyZEypAXhZs8muhn5LaPpwV2sIWZhZWu3LHdXwoib6PexdbP40zQsi+x5lJRpATsBylaSRyjm26Ikiqf2Q49NAKhEQGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRnVFkrUnB4VTJ6V3VZZXhEaFk3N0VrazJwQmdIUk02a2RtMTZSYnRjcjhO?=
 =?utf-8?B?RjBLa055dC9qMEFvcHRYSElSYi9DRWVNKy82R2E0U0w0R00wZnpsUWpWbGNx?=
 =?utf-8?B?MTNUaVhtc0xnd3hvV2pqdDdLZjN2RFRENjR6Q2JnVXlMdkNXM1hpQTNnR1pm?=
 =?utf-8?B?cCsxMWdXeTg1dmQwekt5MnVpTmVZMHp2aE5ldVlFM2NHVG1VOTVtZEdNMzhG?=
 =?utf-8?B?VXh0KzUvTm1KUGhqV1BndmlqaUx1YXhzVDJIelkwN2FzT0l2ZVM4ZmZodXdM?=
 =?utf-8?B?REJsalRRci9wVy9BRmJMajZibFJLMnlKL1dDdEZudUl5VnVwaDRqOVpiNzlQ?=
 =?utf-8?B?TE1yWHlwUEpTRWgvWEdQTGJON05aRjNMTVQ5bExFanZNZFh0UzFqRExDUkxa?=
 =?utf-8?B?VlkzR3FrQmVtWkc1eDdXd1ZrOXVIOGNOdGVHWmhCaGdpdjUzdWw0aWcxSkx5?=
 =?utf-8?B?bml5Mm5VUVc4VTM0QmgzNkV3VHRlNWZrc3FEbnIxd2FHUG5LVU1KMVNVN3d3?=
 =?utf-8?B?bU9Wc3R0MVdkODZwTXJCaklNb3pwSG8zYzdNeVREc21KclEwUlBOTHhZNmxM?=
 =?utf-8?B?WGFxNEZIZzZ1S1NrZDBKd1BDRTUwUGlKRVkySU5nUFkxb0RHWms3ZC9jLzZN?=
 =?utf-8?B?UUJQNDlrMmRZcnhkUXFXd2ZSa2wxSjVWaGI1d2FoUGgyQURkY3p6WnJvUUIw?=
 =?utf-8?B?ZzhSc3JYbmljSVQ5cndYTndqbHhYcXV0Q3VDVDBzZEVzNXp1QzVnTTVXVnZB?=
 =?utf-8?B?QWFTWXdqa1RnM0RzUDFLK0tpbzFINXIrNkpGZlFZcEVDTUErRTlZOEN5LzBl?=
 =?utf-8?B?aWlhay9ON2ozYTliZVZsTUxWTy96U25WeWNyeXoxdzZKRERONmJCS2xHY3Mz?=
 =?utf-8?B?bXA4dEZtdGY3SzRLVDU3WTA4Z0h0N3BSRWJWdjFXSmlKS09GYmE4NWpTaVgx?=
 =?utf-8?B?bUloTXZVaUlCdHUxdklFanBoWjZKbDlmMjRYcy9sVjJZSVJocFdZVnJUVU0z?=
 =?utf-8?B?cWZsTFIyZWh6UHpsbjhBdVM5QW1Xd2xJNlJLdHlmZW9zTS9CQUJJWlF0THNj?=
 =?utf-8?B?UCtZVFZPa3V5ajhEZlozRktxUXhPTFdkQ0tadjBWZGRNQVRDdFB1bC9GS3c3?=
 =?utf-8?B?czlzcmpGRkc0SHc3Q2p4WDlwYTc2K3JKYXBlMEhHY2tiUWhZTWJYamVHMXZ1?=
 =?utf-8?B?TjczTUpwSGJWKzZwNG1OWm5BS3FEZFBYQ01OeDcwRmhTR2tzc3I0V0tiR0xV?=
 =?utf-8?B?a1RPYVpBRWlPbnFpWWxtcnZQTjFaaWFtYTVmeGhPL0trZUpUaWhVdDlRNFhO?=
 =?utf-8?B?YzZ1d0N2VVNqWjFvSGkvSEpPTis4SktFRU40dGF3V1U3M09NR0cxRjhhWHpU?=
 =?utf-8?B?M3MvTWllc2llVEZDekhaNlJVRktIZ3VqcGZIS2FGV2hOKzdYUXJvVkJURnZh?=
 =?utf-8?B?STZ2WFVRQmpoWnBzVFlNVUhrejRIaFRUbldrNFREYWtMbXFyeUdOdStYbHZD?=
 =?utf-8?B?NHZTRjBNWWZPaXJhL3gwN1AxZ3o1aWhHcjg5UWVEZjJWUHFlSWVhRWFzd3cy?=
 =?utf-8?B?UWowVW5SMHpwOEFLclloQkRwMnpuYlRGblYzaHo3OUYvT2JHMkhkVG8vUHZU?=
 =?utf-8?B?cThrOS91SG5YTG92Umc2b29kUU5XZG1JdW9ZUWNpM0RETklLVXBnYW9EZnBm?=
 =?utf-8?B?QU43TUFwRVJBajZ2RlljdWx3ZUE3WmNvQ3ZDT1liRmowNkFPTFZoUVowL1pQ?=
 =?utf-8?B?am82aElKZGh6UWtHUExyUlA2MVdSOVJSTjNVZVl3blk3RWZXUXFFVU1xa0dn?=
 =?utf-8?B?TVlCajF0dW82R2NFOWdlVFJvTFRzcEt0cCt6akNISlVwRzRSUWFaOG5mWEJZ?=
 =?utf-8?B?SkY2cFozM3pXTXR3VkRKVFlZOUtKc21Ib0xQNkxLUVVUdkgvU2laaEUzYUN1?=
 =?utf-8?B?RUtvSVRzTGlQM3Zyek15eWUvdFkxNi9uQ2JSY1NoRG5lOWlWaVVORXQrQTk5?=
 =?utf-8?B?QjVrb0g5SUJxUUpHYnhhNEtPVmdGOGg5WjZMNFZNWmxsZ1dyRHltaXFLdFht?=
 =?utf-8?B?WWwyOVVtQkRnTzhmeTV6ZHRFVXhzT0VnU1ZrY2RFb1ROSkROVVdRd1REV1c2?=
 =?utf-8?B?TnV6UjNZY0djakF6V3Z2RnJUSUp3WW5QR1JHN1N4VEFZTzBTdEdDSmVmYWVU?=
 =?utf-8?B?TFhPTElwWVBNR05yUEQ1TTIzZE5FbE5ZTHJNRG1zeW5VUHRGMERvUzF4MjRF?=
 =?utf-8?B?dHlScmFoR3Y1KythenZwekI4K1hnRnVva08rQ2RTMGtqdnQ5WU1DN2tTV2pE?=
 =?utf-8?B?YU5WNExqU0paMndreE1zVTdUanBuNkI2NHpqVCtnd3Z5QndZSWs1MHlCc3Ji?=
 =?utf-8?Q?GNB8EsDsehuj6BIQ=3D?=
X-Exchange-RoutingPolicyChecked: ifmeo0FiTAWMAgoCFXc008JanGo+IHhH6gdx09npi5AHH2T85DfUhoPSZqDQjA0jXvXSqwTkfPLKsdsyADxEGJqzoOtuKdqikg7SB2gd2z5UofUgWnmLFVJNO5Xb4gwJa/MsgiBnmP4Aiesg8xBed42CqUwrP4J0zjKpTsXgrYn6FOnak4XgcAOeU77Grdv5OAaqV9Dx/iXPB15AvdciZrziku2TJuIed5Hcpw/VqD0q3t03JeKLx5TMFskeCC3o7BaME6a+Nno9d68CY11Cn+szTyOLQAW0TlHHrVeW8ozsOOlsy2VqM3wvcsHeBwuCN1gMRPRy3dRsJKn8D67vYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2b110e-2f14-43a6-835d-08df14e5debe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:02:42.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCmynxMSjjZ54QLk03STI1Jp5Yv8V6QFDRcc7Bx6c2LND3eA5HAC16X5UVDuT1vWjR2GjN2Q9p2TQpI/woNmX9dFc0y8TGqXbmDvpvQgckI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: Recalibrate PHY after settime64 on E825-C
> 
> The patch extends the post-settime PHY recalibration path in
> ice_ptp_settime64() so that it also runs for ICE_MAC_GENERIC_3K_E825,
> not only for ICE_MAC_GENERIC (E822/E823). The stated motivation is that
> the E825-C PHY needs recalibration after large system time jumps,
> otherwise PHY timestamps read back incorrectly.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 832cc6ad2f90c..a5efb0a95941e 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2020,8 +2020,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>>  	/* Reenable periodic outputs */
>>  	ice_ptp_enable_all_perout(pf);
>>  
>> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
>> -	if (hw->mac_type == ICE_MAC_GENERIC)
>> +	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
>> +	if (hw->mac_type == ICE_MAC_GENERIC ||
>> +	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_restart_all_phy(pf);
> 
> [Severity: High]
> 
> The E82X sequence has two halves: timestamps are invalidated before the
> time is written, and the PHY is recalibrated afterwards.  Only the second
> half is being extended to E825-C here.  Earlier in ice_ptp_settime64() the
> invalidation is still E82X only:
> 
> 	if (hw->mac_type == ICE_MAC_GENERIC) {
> 		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
> 		if (err)
> 			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
> 	}
> 
> Should something equivalent run for ICE_MAC_GENERIC_3K_E825?  There is no
> eth56g counterpart of ice_ptp_clear_phy_offset_ready_e82x() in the tree, and
> ice_stop_phy_timer_eth56g() clears only PHY_REG_RX_OFFSET_READY, so
> PHY_REG_TX_OFFSET_READY stays at 1 for the whole restart window while the
> PHY timer is being re-initialised.
> 

Even if we call ice_ptp_clear_phy_offset_ready_e825/eth56g or whatever,
we actually found that to be problematic. We can't clear the offset
ready bit without causing other issues.

> Related to that, the ICE_MAC_GENERIC_3K_E825 branch of
> ice_ptp_port_phy_restart() does not quiesce the Tx tracker at all:
> 
> 	case ICE_MAC_GENERIC_3K_E825:
> 		err = ice_start_phy_timer_eth56g(hw, port);
> 		break;
> 
> whereas the ICE_MAC_GENERIC branch does:
> 
> 		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> 		ptp_port->tx.calibrating = true;
> 		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> 
> tx.calibrating is only ever set in that E82X branch and only ever cleared in
> ice_ptp_wait_for_offsets(), so on E825-C ice_ptp_is_tx_tracker_up() keeps
> returning true (link_up is true, which is why the port was picked in
> ice_ptp_restart_all_phy()):

Right. I believe we do actually need to hold calibrating over this path,
and we should do the same for settime.

> 
> 	return tx->init && !tx->calibrating && ptp_port->link_up;
> 
> Does that mean Tx timestamp requests keep being armed and reported while
> ice_start_phy_timer_eth56g() is soft-resetting the PTP block, reprogramming
> PHY_REG_TIMETUS/INCVAL and re-running ice_sync_phy_timer_eth56g()?  The
> comment in the ICE_MAC_GENERIC branch describes that state as producing bad
> values:
> 
> 		/* Do not clear calibrating flag here. Tx timestamps remain
> 		 * disabled until ice_ptp_wait_for_offsets() has verified
> 		 * that the Tx and Rx offset calibration has completed.
> 		 * Clearing it here would allow Tx timestamps to be reported
> 		 * before the PHY offset registers are configured, leading
> 		 * to incorrect timestamp values.
> 		 */
> 
> One more effect of the same window: the call chain
> ice_start_phy_timer_eth56g() -> ice_ptp_phy_soft_reset_eth56g() ->
> ice_ptp_clear_tx_memory_status_eth56g() clears every hardware Tx timestamp
> entry:
> 
> 	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
> 		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
> 
> but the software tracker keeps its in_use bits and skbs, since nothing calls
> ice_ptp_mark_tx_tracker_stale() on this path.  Can those already-outstanding
> requests then only complete via the 2 second timeout?
> 

Effectively, yes. I think we can address this.

> [Severity: Medium]
> 
> This is also the first E825-C path that can reach ice_ptp_port_phy_stop(),
> because ice_ptp_link_change() only calls ice_ptp_port_phy_restart() on a
> link-up transition for this MAC type:
> 
> 	case ICE_MAC_GENERIC_3K_E825:
> 		if (linkup)
> 			ice_ptp_port_phy_restart(ptp_port);
> 		goto exit_kref_put;
> 
> ice_ptp_port_phy_restart() tests link_up outside ps_lock:
> 
> 	if (!ptp_port->link_up)
> 		return ice_ptp_port_phy_stop(ptp_port);
> 
> 	mutex_lock(&ptp_port->ps_lock);
> 
> and ice_ptp_link_change() stores that field with no lock held:
> 
> 	/* Update cached link status for this port immediately */
> 	ptp_port->link_up = linkup;
> 
> Can a link bounce concurrent with a settime invert the decision here?
> 
> CPU0 (ice_ptp_settime64 -> ice_ptp_restart_all_phy)
> 	if (port->link_up)                /* true */
> 		ice_ptp_port_phy_restart(port);
> 	   -> !ptp_port->link_up          /* link just went down */
> 	   -> ice_ptp_port_phy_stop()     /* waits on ps_lock */
> 
> CPU1 (link comes back up)
> 	ice_ptp_link_change()
> 	   ptp_port->link_up = true;
> 	   ice_ptp_port_phy_restart()
> 	      -> ice_start_phy_timer_eth56g()   /* holds ps_lock, takes ms */
> 
> CPU0 then acquires ps_lock and issues ice_stop_phy_timer_eth56g(hw, port,
> true), which does:
> 
> 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
> 
> Since the E825-C link handler only restarts on link-up, would this leave the
> port with the link up but Rx offsets marked not ready, with no recovery until
> the next link flap?
> 
> The unlocked check itself predates this change on the E82x path, but the
> E825-C path that can now hit it is new here.

Right. I think we need to address this sequencing by holding the
ps_lock. For simplicity, I think we need to reduce to a single lock for
all ports as opposed to one per-port. You can't actually concurrently
execute port restarts anyways since a port re-sync requires the source
timer command register (which requires the PTP semaphore), and that
would overall simplify the locking to allow us to take the lock, do the
settime and then reset all ports. We might even be able to amortize the
restart procedure by restarting all ports concurrently that way (as a
future improvement).

I'll look into this and see how complicated a cleanup will be.

