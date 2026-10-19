Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792454287;
	b=vx0XJT80MJyIUQft42VMocXbHbA0bPzU5iQO2WJKarubHmkSBFZZ8z0sri96tCJ4wdtl
	 R1t2/3NiF8TQNA+F1othAbLEO2hYr0hbYFq92COixQGk9Zl9pIwAQSoNSEW6h5fpj/wU6
	 ZKVnrrc5a3+04zBujPfU8zxxI2QoXmmrKHLAiKLhUcR8PSOyOVBDEJfAxZY5Pe3YsK1Bu
	 Y3HO/g/z/7ma40n3IgWOylMIlIWj2Mt/vodR5yzpgCZuxTsLZbwLsLkXKQsQY/GvGe6ZK
	 grcrSq8v6y4NWNJPa3iqlIv9AKRYLfkt7FQILUk606LayFnw7HaHuSl00HG3FPfUhBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454287;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=O318oQcK0mHyHn+dJLAH8/jlpyql+H6SRnbAqLRKhMM=;
	b=E+opvk8pakNhluxiulwJGbSZ4XnDxqpD/HdTJ2fNubycXyDJtkhfkp3JfPXGhB02Z83M
	 p+4Add+g3dT3/GNsmIpkNy/qLySkYG09/cLsrjrHc+rALzoDHuMge0IeGM2fyIkcKRel8
	 BHyFUUTDRaxmk49Pefcp3tJ1ooQt9AsolEu4KyEuSrgNBUZajQIh75v3Gp0BPAPr0A7Yl
	 Lk8V++kMNXGun7Ehf0CCmcYUrcZuHf5MM/F61Tkyw6bwRw/l6Mg/MDVB+GW/Ix/9wqg1T
	 Jd7K6jJt66EBAOwdfAU6iETB/T8iF9DQ8RfNa0Ly0zWZ5BE11HrxH9eeskuzFFJuzdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WZL1nIvR;
	arc=fail smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0302606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0302606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WZL1nIvR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792454286; x=1823990286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W9g4G/yb3oEyKJaD4arqaZvAEVtJCOA62RLEhILyxsc=;
  b=WZL1nIvRsy6g/SfW6riSpGi5M+Z3VdXJ7m2SOLakQN0w6PtEHmzwY0rL
   P7KSsuF3h2RLkLZewj8bJsugmNWTjEuDIuypLylzRQHlPqkIbX06hZwhS
   Mt6BO3dV3/FB+e03hIq1862ym5IhfICJjEOwo0u5ckpnSHoI8Kru1GB0L
   AGsA3W3rF6Cz/LQcMCRfreTNoYB3DrBOGHzQbMVQy5xgzMwpOkeAcDIqq
   DLoHccQeK5mkZio3SqcPRVwUzpw/iGETVAKTG1MoqqaCYXhh+uVQT3WOo
   LObsexO9tRjBb1+pSS0ivBRflftgC4EMMol6/xI6peuXJqw1Jn2aYtY57
   A==;
X-CSE-ConnectionGUID: sfyTRjY7RSy1JrmwXUIc9g==
X-CSE-MsgGUID: bszQ5VtwT4KfEiut7jJzTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1031633"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1031633"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:58:05 -0700
X-CSE-ConnectionGUID: n0fV/pp4TNakNdaQE3k84w==
X-CSE-MsgGUID: 1dHPFzUuR2Oitu0cz3L67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4424868"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:58:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:58:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:58:04 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:58:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhPa7MWXRMmhGHYhUGuveFz3AN0NqXGWYw2bIt6GqwnJeqnaGvq8TaSlR4sJC0emRUOOdpq+8zx+JVe9e/3t3U8reinaJgH9iJ4/2DCIpAIVsyQYt3boX5d8TryP9iVkZ9Itt38KNysKTIwOMxmcRI3WvLn3BIFiApIyTQWT+pzntHhxi0jT20xBpGraFHGds98f1r8QlOnt+gaTUcpqrGZVfDZu3EUUhieyW2OYE8505JtgbTnytKuX0TD5Qn18sS4HuK8246SMHK8qChmOSPDHKs4aS3qN3VZioyzHo43Inj7lqlFmXskKoYwpo5B6zfQKu7/GXN1XMLc1FKq+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O318oQcK0mHyHn+dJLAH8/jlpyql+H6SRnbAqLRKhMM=;
 b=weuZgK2yXaPADo8Y9mA9XMAT5qGaPXPe4lfrpZxtQpmMkvuaSeO8GNZkGjOreEFZDHn/W1GdqLUHrXUfXzwTa/hMDlh7T2HkNo3qhctGYt9aQ7Zlh2m2eP0FV4RN/9tCdbBT6FO7MekJKJmXUjdY/k9HKn5zl9lGhLzew7djAzFMXXFX6dT5mm1aKGI/q+VZDQ6u1P/bzUZMpZMq8jCY/Efw6vgvdCQlGkRl1qijKIKwchtxMyLTGjfWCmJZ/NoK2cXmPlLJcEICZ/R5iliQPRREwHKq5d48DjaKsVs8sCp8eFg2YRlwH9D6pfGjHPU9IGRCESwNbaN7AwrnR70SEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:57:59 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:57:59 +0000
Message-ID: <39020bf3-80f0-44d3-b2e8-0e71dfcbe88b@intel.com>
Date: Mon, 19 Oct 2026 16:57:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 10/14] ice: E825: perform a soft reset when
 starting the PHY timer
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-11-anthony.l.nguyen@intel.com>
 <179244085327.3135.14633467597687530953@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244085327.3135.14633467597687530953@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|SJ1PR11MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1604bc-3c38-47ef-91dc-08df2e3ccd71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|18002099003|3023799007|4143699003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2iPYs7REzmCbUmXu13Rke4Uir6/dWqRIXpLW6qi0pNwUvOtI499iZrkM9qH9z0I8wJ/F+JDOeF156r558HAu+7tZh5iI5nzHndfEgKhcBzUQ4AyMiLoECic+P2/VVO2kLZGekRXaAVwXAOwKb+f6KUQAoUjradGBd3fCsRtpJ4++Las9ePUNjjMe0sBKZtGHawod1DSid3ChvMLu3RR6PpskJTv5pVe3C+4zUn02Ro09sY1+VOk78wrTKnUe4BaZXZpwv3Y9vy+9xFPxo6UfPN3T7TvTSX7Url0qm8pckRccVCRnBrP2+m6WlZEtgc9qKiWTuHcfFMZ0GD+HiIG0ZXlpNtGVqQw9uvME66bkrJHV57fPiEKptMLtmm5nQCMKdZktAW90RbOC2xQi86rewXKgj3nqYdhS9lX+ThMkIjW1cJHbSEpsLEM1z7ZUN/H18Q6hLUaBawpdDHBTmDLRQo+1Wko22+l1a9suPMcvLAHgtlCeMHHZH3JDzl+a1olgk/gvfOF1KQqaA2Bb9hIbgNMPa7RtV1SbyHNgceED1z6at8qUeIL+Bl1GH1hAy7AB6MNHSF2cE8cXvJTHyD54RqMaMJtiPKrUha8Rxe3e+HCcEQMmNe4TuNmKAsF469AvZP1WwdSl1lI9UN6CUxXEklDEr12ex16xOw1Bs3KUDLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU5KK2x2WHdlREx5MGxHbVBNZUVQL3RxRW9rZm1hOEN0T1cyWkZVMjY1YzdL?=
 =?utf-8?B?VVNObnFHVEhIRWtuQXRmdFpzREVSZE1rUTJFTGJCbEUyWXg2VGR0QlpGQ0wy?=
 =?utf-8?B?NVJjMXVaR0IvTTQ1dmliSmRNeHloaGRTcUNybGdHSUQxYVliR3VPMHVxRHda?=
 =?utf-8?B?UmZSbDVSR0Z5Y24vOUFMVVoxZ1FDcjIzUmVuNE15Zk4rRTEyQ1JuOXQ5c1Ur?=
 =?utf-8?B?cXZGWFN1RVFhMDhuZlJadnlsMlc4cmJYaEpzMGx1SmF3Nmhib0ZpQTRiMWh1?=
 =?utf-8?B?a1czcnJRYnFlcytLNmRXWVVwZmEvQ1d5TFRVNk1PSUVtV1N6T0FKVXh5Q1oy?=
 =?utf-8?B?aHo5azdmTmIwSU1vTThzVHJpZkc5eGVOcm8zTzVMU3NIdTBrc1JKV0xWMWFF?=
 =?utf-8?B?WU5MUk12R3FQSFhCUkhKb3pJdENvcU1TS3VadmQ0YXpWVml3ODBFOUxSV1p6?=
 =?utf-8?B?Q2F6bENFMHNaV1B0ZHYvaW4xWFBsTGZveGo2aFJrcElZQnJ2bThLL0Y0TjB6?=
 =?utf-8?B?dkhpNTRHMjBxcStIS1I3L0RqcmpjQkVnRTRmM2VSNzdIK2xxeGk1czBzcFEz?=
 =?utf-8?B?ZzIzYTNYR1IrY1BCRVZaSVJSelltR0owVi84bWJqWUgwVzRkbTlUVUhRZjhh?=
 =?utf-8?B?UG51bGQ1cXNGc2FhTnRNbjJ0aHR3Rk4wNzMyWlllUlVOSktPcDBIUzM1OXpz?=
 =?utf-8?B?LzRRRm1rK2REZWRqT0tBVVRxNnIzVFE2bTVVQXBkQTMrSlVCMmlmbm85Wmlp?=
 =?utf-8?B?UE9TNjRGd29jVUloZC9nemx6eUNsYW5xQXVQbG9Ra3Zta1JmNEdOZ2dXZUh5?=
 =?utf-8?B?NUtqK0lzaitYeVNiS1NCN2tjTC8yazFXZzNIZ29wRmYwNkRkNkJab1hNUHNs?=
 =?utf-8?B?c2lWUHcwWUVzd3BZZ3Rjd2JxOXhRTjFrRDhYNEQ2NjY3T1dkR0gwd0VXVlFz?=
 =?utf-8?B?NUVKNnc3RW0zS1ozeXZJeXpWMWFwbmliK3Frc3pmUVN5UUREUUpaQjZBZ25a?=
 =?utf-8?B?UFNKT1I4MERSaWRnZkF0WmQxdzl4NlRzOW5HVHpUdzhBZXBlZWJvUWNKdFB1?=
 =?utf-8?B?TVhsTWJxbmZpOHhuQXkrQmVMMmdMNzVRMTV1bmJ2T3VsWUppd3VIVzRGRHVX?=
 =?utf-8?B?dS8zaG1aQkpIeEJLK3hkdXZrRlFRV2hobko3Mi84V08yMTNJaVRtaHYvTmlF?=
 =?utf-8?B?UEdSNHk5MlR0WmtKcldrYXUrMEpGbkszRWlxb3FpcWhlQTNsV2M5ZHk2OEw2?=
 =?utf-8?B?eDBSRkhDeXIrd25SRHNKUDV0cndLYjUybTBNZVUwS0pzS3pMYjFmZ0VEbmp3?=
 =?utf-8?B?ZVdtcThHSHgvYnJXRjJsdEwza3k0OE40UVhQcmNKcjVoN2dVdWREM01sOGxu?=
 =?utf-8?B?RXQ3YlVzVjVpbStJMWtzbmVLcWF5Z0VCKy9YS2tVdEt1R3RDVGRXUTVpeFN2?=
 =?utf-8?B?Y2JSQ3J6WDErTlU0dHkwUE0vbGpoNE5hV2NJblloU0pFTjlXVVlrTTQ5OHJ1?=
 =?utf-8?B?dWR2N3BVME9oOVJjN1BabzZZYzUrSXExdGxXRndDdHhBQTNJYVdTamp3azVl?=
 =?utf-8?B?aGVYdTBRTVpndDBxMVV4MFJGWHJLeGRKUndGMHJMalRVS0E4eGNibXJQNENL?=
 =?utf-8?B?dUVyMjNzUHBRK3diSjRnQTdtdjhVNnVDTlV2L3hEWmxaNSs1QytERmdaY1M4?=
 =?utf-8?B?bG5jOWlCWEZ3TDYwUVQ3UmwzSXlwaFlEV0pJRW5IVVNWSUlKc2xVbXU4dEIz?=
 =?utf-8?B?Ky8rTlV1aU1TdnNGSjZEcjlyeHJ4QVFnZWtDTDZlU1BwV2UwOVpGZWRoa0FN?=
 =?utf-8?B?dXlxcUxZazZmSVNzV0JoNnZNd2tsbDBhY0ZCVlRFS011Tm9GOFg4RS9aVkp2?=
 =?utf-8?B?NmFLdHZQUkZSd1RkSWcrLytRaHNxcFdRd0lpaEhmekRuTmZrY3UydUFJYmN0?=
 =?utf-8?B?VkxrMFNkTHNoWEorQ1dvRVNMN2pzK3NUc3hyNWpiQUVOSTBub2NtbEZIbVNG?=
 =?utf-8?B?WjU0OWtzRlJhN3dVRVJyVU9BSDhCUUFKUmlLSVBtOGdORklVeHNqYXRzSVVu?=
 =?utf-8?B?bW9Hc1V6d2lwYlVNeWhWL3JxckZLbjluWkI0YW94SUwrbnJXY000MXBYUE5v?=
 =?utf-8?B?ejM0M1RwSGUxQTFaZVcybnptMFI2KzFrR1ZMaVR6ZWl6K2Q0TVN5Sk5hL1Uv?=
 =?utf-8?B?NEVjWXR3VmdaMUU0VEVoSWU0SGExblpRck9MaDM3cHJFSUNZc1FxQ3RaaFQv?=
 =?utf-8?B?YjlEa3ZHTksrMzgvSFE1NTk2aUNVZnBUaDFvM2ZLM0RDOXZhU29mWHFFdEVF?=
 =?utf-8?B?Q2dQMlJTUDduKzlwcWVyTGl6SGZ2Vk45MlVqY05DaWkrT0x3UVFRdz09?=
X-Exchange-RoutingPolicyChecked: PVcDuyNn9w7LNWWMGRynnekOnTSArYZeFhHllHP2HCJysZuC/KcpS72Yux2uge9dHW4xqUxWc6naxRpcwxfmL91sqvxmQNBabwgvmBzljAdeL7v8bG7zSFNwqqozu64ufbxdyziPfIOKc9ITgIul2HTAKodtD0p/m2AHTvmpHGaLBe79sVduB402JrMwSPIhgZ3PsnTI3TqSxwPpzQLhx7tsbSVAA7m3Yypl9SU/76QSIqjks7FulLn3Ofl1rvuUM7KEQF087ydzbxF/6D0tEUrcWHABUzS5Xp4LOr7bPu0N6MGnk+bP7oycLabNkbv228el3qt7uuCN7x4vDF7ukQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1604bc-3c38-47ef-91dc-08df2e3ccd71
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:57:59.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjKsnsvnV+vXCuBVAsECTK+ayGGBSuHy2ZUmfPg22BpnlOCSOIZM4eInn+4VpwfsKR6z/41kcPR9/9/r2xE7fmfn7yFsaa88bD/tVTNHp7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] This patch makes the E825 PHY restart path in
>   ice_ptp_port_phy_restart()…
> - [Medium] On E825, ice_ptp_port_phy_restart() now calls
>   ice_ptp_flush_tx_tracker() on a live tracker without synchronizing…
> - [Medium] ice_ptp_port_phy_restart() on E825 now flushes, i.e. releases
>   in software, every outstanding Tx timestamp index right away.
> - [Low] The kernel-doc for struct ice_ptp
>   (drivers/net/ethernet/intel/ice/ice_ptp.h:250) still says…
> 
> --
> 
> ice: E825: perform a soft reset when starting the PHY timer
> 
> This commit adds a PHY soft reset to ice_start_phy_timer_eth56g() so the
> E825 PHY timer starts in a clean state. Because the restart path now
> performs a soft reset, ice_ptp_port_phy_restart() flushes outstanding Tx
> timestamps instead of marking them stale.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 365cff9c10173..32be908373c30 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -756,7 +756,8 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
>>   * @pf: Board private structure
>>   * @tx: the tracker to flush
>>   *
>> - * Called during teardown when a Tx tracker is being removed.
>> + * Called to immediately discard any outstanding Tx timestamps, including when
>> + * tearing down the Tx tracker, and on E825 when restarting the PHY.
>>   */
> 
> [Severity: Low]
> This isn't a functional bug, but should the kernel-doc for
> tx_hwtstamp_flushed in struct ice_ptp also be updated? ice_ptp.h still
> says:
> 
>  * @tx_hwtstamp_flushed: number of Tx skbs flushed due to interface closed
> 
> On E825, the flush is now called from ice_ptp_port_phy_restart(). Every
> PHY restart that has outstanding timestamps now increments this counter.
> That covers link-up via ice_ptp_link_change(), the initial restart in
> ice_ptp_init(), and ice_ptp_restart_all_phy() during owner rebuild. None
> of these is an interface close.
> 

I can try to clean that messaging up.

> The counter is exported as tx_hwtstamp_flushed in ethtool -S. It is also
> added into the standard timestamping err stat in ice_get_ts_stats():
> 
> 	ts_stats->err = ptp->tx_hwtstamp_skipped +
> 			ptp->tx_hwtstamp_flushed +
> 			ptp->tx_hwtstamp_discarded;
> 
> As a result, link-up flushes now show up as timestamp errors. Before this
> patch, stale-marked requests were dropped without being counted in err.
> 

I need to test how common/likely a flushed error actually is in
practice. If they happen reliably then I am not sure they should be
reported as errors.

> [ ... ]
> 
>> @@ -1327,7 +1328,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>>  		ptp_port->tx.calibrating = true;
>>  		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>>  
>> -		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>> +		ice_ptp_flush_tx_tracker(pf, &ptp_port->tx);
> 
> [Severity: High]
> Does this drop the tx->init protection that this call site had before?
> 
> ice_ptp_mark_tx_tracker_stale() only touches the bitmaps under tx->lock,
> and only when tx->init is set:
> 
> 	spin_lock_irqsave(&tx->lock, flags);
> 	if (tx->init)
> 		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
> 	spin_unlock_irqrestore(&tx->lock, flags);
> 
> An earlier commit in this series, "ice: E825: stop clearing
> PHY_REG_TX_OFFSET_READY", added that guard here to prevent a possible
> use-after-free on the bitmap.
> 
> ice_ptp_flush_tx_tracker() never checks tx->init. It walks tx->in_use
> without tx->lock and dereferences tx->tstamps[idx]. It also makes
> sleeping sideband calls (ice_get_phy_tx_tstamp_ready(),
> ice_clear_phy_tstamp()) while it does so.
> 
> Can this race with ice_ptp_release() during driver unload or devlink
> reload? The service task path:
> 
> ice_link_event()
>   ice_ptp_link_change()
>     mutex_lock(&pf->adapter->ps_lock)
>     pf->ptp.state == ICE_PTP_READY check passes
>     ice_ptp_port_phy_restart()
>       ice_ptp_flush_tx_tracker()
> 
> can run at the same time as:
> 
> ice_unload()
>   ice_deinit_features()
>     ice_ptp_release()
>       pf->ptp.state = ICE_PTP_UNINIT    (ps_lock not held)
>       ice_ptp_cleanup_pf()
>       ice_ptp_release_tx_tracker()
>         tx->init = 0
>         synchronize_irq(pf->oicr_irq.virq)
>         ice_ptp_flush_tx_tracker()
>         kfree(tx->tstamps); tx->tstamps = NULL;
>         bitmap_free(tx->in_use); tx->in_use = NULL;
> 
> synchronize_irq() waits only for the interrupt, not for the service
> task. ice_service_task_stop() runs later, in ice_deinit_dev().
> 
> If an E825 link-up or speed change is processed during unload, could the
> restart's flush read and write tx->in_use and tx->tstamps after they
> have been freed or set to NULL?
> 
> The commit message doesn't mention losing this guard. The unguarded
> flush in ice_ptp_port_phy_restart() is still there at the end of the
> series.
> 

flush_tx_tracker should only be modifying the bitmap under lock and the
reads are intended to be safe, but I'll look into this. Of course I made
this change at the reqest of AI last time because it was saying why not
just flush the tracker instead of marking packets as stale.. Maybe I'll
go back to that and defend that approach...

> [Severity: Medium]
> Is this flush synchronized with the clock owner's Tx timestamp
> processing?
> 
> ice_ptp_process_tx_tstamp() runs from
> ice_misc_intr_thread_fn()->ice_ptp_process_ts()->ice_ptp_tx_tstamp_owner()
> without adapter->ps_lock. It reads tstamp_ready, the in_use bit and
> raw_tstamp without tx->lock. It takes the lock only at skip_ts_read,
> where it claims whatever skb is in the slot at that moment:
> 
> skip_ts_read:
> 		spin_lock_irqsave(&tx->lock, flags);
> 		...
> 		clear_bit(idx, tx->in_use);
> 		skb = tx->tstamps[idx].skb;
> 		tx->tstamps[idx].skb = NULL;
> 		if (test_and_clear_bit(idx, tx->stale))
> 			drop_ts = true;
> 		spin_unlock_irqrestore(&tx->lock, flags);
> 
> Could the following sequence deliver a pre-reset timestamp to a
> different packet?
> 
> owner IRQ thread:
>   ice_ptp_process_tx_tstamp() reads raw_tstamp for skb A at idx,
>   then is delayed
> 
> restart path:
>   ice_ptp_flush_tx_tracker() frees A, clears in_use[idx] and stale[idx]
>   ice_start_phy_timer_eth56g() soft reset (at least 10ms of sleeps)
>   ptp_port->tx.calibrating = false
> 
> xmit path:
>   ice_ptp_request_ts() reuses idx (lowest free index) for skb B
> 
> owner IRQ thread resumes:
>   takes tx->lock, claims B, finds no stale bit,
>   extends A's pre-reset value and calls skb_tstamp_tx() on B
> 
> There is also a variant. The thread uses a tstamp_ready snapshot taken
> before the reset and reads the now-cleared register for B's index. It
> then drops B for missing the valid bit. B's real capture stays ready
> with no in_use owner. The comment in ice_ptp_process_tx_tstamp() warns
> that this kind of state can leave interrupt generation stuck.
> 
> Before this patch, the restart only marked indices stale. The processing
> thread then kept ownership of each index until it cleared in_use under
> tx->lock. The other live-tracker flush, in ice_ptp_release_tx_tracker(),
> first sets tx->init = 0 and calls synchronize_irq().
> 
> The flush also increments tx_hwtstamp_flushed for indices whose skb the
> processing thread has already taken, when skb is NULL.
> 

Yea.. Ok.. So this makes me think its better to just go back to the
stale flag despite it potentially blocking an index for 2 seconds.

>>  
>>  		err = ice_start_phy_timer_eth56g(hw, port);
>>  		if (err)
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 38d0ded1d0cc0..51442b26516ee 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>>  	if (err)
>>  		return err;
>>  
>> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>> +	if (err)
>> +		return err;
>> +
> 
> [Severity: Medium]
> Can Tx captures land after the memory sweep, into slots that software
> has already released in ice_ptp_port_phy_restart()?
> 
> The restart flushes every in_use index immediately. Packets that already
> hold those indices may still be in the hardware Tx ring with
> ICE_TX_CTX_DESC_TSYN set and the index encoded by ice_tstamp().
> 
> Setting tx.calibrating only blocks new ice_ptp_request_ts() calls. Also,
> ice_stop_phy_timer_eth56g() leaves PHY_REG_TX_OFFSET_READY set:
> 
>  * Note this does *not* clear PHY_REG_TX_OFFSET_READY. Clearing it would
>  * cause the Tx timestamps to be captured with their valid bit clear.
>  * Unfortunately the captured timestamps still increment the internal counter
>  * and result in off-by-one accounting. Instead, Tx timestamp requests should
>  * be disabled by other means.
> 
> ice_ptp_phy_soft_reset_eth56g() runs the sweep first and sleeps before
> it asserts the reset:
> 
> 	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> 	...
> 	usleep_range(5000, 6000);
> 
> 	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
> 
> If a capture lands before the reset is asserted, the counter and status
> are zeroed while the memory still holds a valid entry. If it lands
> after, there is a ready bit with no in_use owner.
> 
> ice_ptp_process_tx_tstamp() only walks tx->in_use, so that slot is never
> read. At this commit, ice_ptp_tx_tstamps_pending() also checks the
> hardware ready bitmap, so it would keep re-arming the interrupt.
> 
> Later, ice_ptp_request_ts() hands that index to a new skb C. Wouldn't
> the processing loop then trust the old ready bit and deliver packet A's
> capture to C? C's own capture would then be orphaned, and this would
> repeat for each later user of the index until the next restart.
> 

I'm not entirely sure this is possible, but I am also not entirely sure
this is impossible. It would need to also somehow end up with a valid
bit *and* a ready bit in the bitmap, which should have been cleared.

> The commit message says:
> 
>     This is safe because the soft reset procedure will restore the
>     timestamp state and clear any desync.
> 
> That seems to hold only for captures that land before the sweep. The
> previous stale-marking approach kept these indices in_use until the late
> capture was read and discarded, or until the 2 second timeout.
> 
> This patch also applies the soft reset to live ports: link-up, up to up
> speed changes via ice_link_event(), and ice_ptp_restart_all_phy() on
> other PFs' ports during owner rebuild.
> 
> A later commit in this series, "ice: keep Tx timestamp slots tracked
> until completion or timeout", describes hardware completing captures
> after software released the slot around a link bounce. The flush in
> ice_ptp_port_phy_restart() is unchanged at the end of the series.
> 

Yep. I'm going to go back to marking stale and defending the fact that
it locks indexes for 2 seconds. Possibly we can have marking stale also
clear the skb immediately to avoid blocking a socket for 2 seconds, but
otherwise I don't think we can safely flush like this.

>>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>>  
>>  	err = ice_phy_cfg_parpcs_eth56g(hw, port);
> 

