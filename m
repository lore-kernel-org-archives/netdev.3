Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793141891;
	b=UhZtc+M1qRF+hHrw5uz3f4Q8garWjRYhVW137gA7qwuXktD5ApQMTTTLyZRyrk+U5z/c
	 TD6xFw5+dC59OXWn1zgpIkoZPbzPTMBI4XR6b3CgT7wRlB+dR11JLVwFkbE3N3TUT6rZg
	 tfIV7AAB87detqBhfUPMqMMewTCYOPXMeYR+o+TgLoNk+Vv4Lx1l0RPUd8Jd9yOtRsT8a
	 ekNCGgZ3LDZiuco7aHQjB2/CwXVL8JWvgoRQ/VIPlo9MISRjVMaRQq5SXHou8WUj8xgkL
	 QebLcftJuczGzV5sYPmn4WbF7TC840JcJ2V/KR5nj0t7cQPmg28QU8MOxudj80vnGHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141891;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=/567Fj2aH9AFTaeO8W6R+cC5PFBCC4Y2MWi1P3ZCeIw=;
	b=CA5nfM7A/GtexsKORCY15yjxUrugbPHJ0gJDw2tYrEFVCScJNsxVYz7CUJM7LP/AHzoS
	 uxAYoDyAuSXHgTBGGK6Py3t4xnlmRy8IDNQ+nrs1fISXmdsbMjKwAPhfMS4OnmHsv9zmK
	 AdzD61Cv4qPUbUVnc40IAa02s/L4Rw/M3ghhKBeDY8bRY4IgQ1HserZZilrMlUkLdnEV9
	 cT5Fje+VobbDQFIAAczERoBgJzU0RaCBXyx7ouBbHnEP+tKye8CqSAbUPHYX/GVyVuemY
	 Xnq/uycbeiBQUkSrk0vP0N2+/kD1nFTEw/5UogetqYNRSupWRFJZAyoLHiXAtFMyJ1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Q4u/PIqs";
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43686606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43686606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q4u/PIqs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793141890; x=1824677890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I18DJ4YOmVecqjCuyFYydlTy/2oIdAqxzYCo6I7/O9o=;
  b=Q4u/PIqslEqnrcYm2KhFhDD7IqOrNE/9s902ysjxUZXKE8+n1E1O0rB2
   FLE3cAVQdXQCxTMmtJz7PsRM1o9rkk4Das15k7IUSXhN0lK10Ifm+G80N
   tcAirAsNEZTS6bRxb1Z/K0zyxtWpQ+c3vEm6XHl3O2msfXoYB+FkEQFeM
   WKPTCz4qfJAK+Q4iPw+G7izL+NdCgLqEuLo6flznxtQ8/s3AnmkiBDqM7
   EzozbZNiMtFFB2AXX8q3A65tq9zw0Q4gYNTOdoyKGuAmgRz7kpAVbns9s
   1e5oVxqPauYm/5Sxmfy0c3EeBmr6/98Bu+7+3hG8hfDvFYXL6MbQxArAH
   Q==;
X-CSE-ConnectionGUID: puxDmqzrR1iwkg7mFJUq+A==
X-CSE-MsgGUID: Ufd4FzISSneZp7nB7qptbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1879662"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1879662"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:58:10 -0700
X-CSE-ConnectionGUID: 7a6w1zvLSNq/4x2zmdzltQ==
X-CSE-MsgGUID: LYjTTHPyR022vpRwVuChNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4713116"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:58:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 15:58:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 15:58:09 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 15:58:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUTRYYc/j4xfA9/RNVlg6FNBuSkGcvw41GVJ1AnQ+fpYluEZka2vKJuLYyWWZP1RJm7UEkFXDwF6958dtJeGNlQLJk84I51L54aTnD0PFrpg+wV6V5P3IznIiA2zTNJsPOwtQIwzBO4PdHOVDClHcGjXxzqHwNsfnOFMM8qK6k4L6Drh3yeyW2QUWJt3ZYQ01omMhio1ZXpH5J5+YZVGKnV1URCMQf9sq/VUG963OYHylHXrrldL2Oth27WUDQV0bQaDbDvWutF64z1vDKWm5o8rdJYMKLTF/CF5hRKCAAX47YJw0SQ2o7GUsBzSCdSa3ag+1kHb0Q3PvOJrijr1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/567Fj2aH9AFTaeO8W6R+cC5PFBCC4Y2MWi1P3ZCeIw=;
 b=krKNM2Mb8Xdsj1SyociPrF7epy5D3F2lwuodKpLhqSMTpnXhPY7TZlg9oWLZtC590aQeRHFO4E8FdrXy4AS3HfJP21DawuuNXSgfiWzFTeZod2QbxSB1p4CY9FF1UlImAuK2/72CyWW2DFF7xubxOaA8bCMPmpLQpxebyDzF29BRzVlAYeKSAa43aLc6TwmgAxGdpKO8xht0nC2JAi3a6GoYW2zXyrdR7oj+rpsrAuZ5GVANmsGA867m8/I4xnt/RbVcBeA6mysQy5ExtqcZTey3Q9JjwQyuKwe38JCf7Re9SRs74NFyIie0FL2GwPGq5VzWIkN9qzrUf+n8qPtb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS3PR11MB9622.namprd11.prod.outlook.com (2603:10b6:8:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 22:58:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 22:58:02 +0000
Message-ID: <710677e5-3668-4588-bd36-2d8f7fb692a9@intel.com>
Date: Tue, 27 Oct 2026 15:57:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 00/13] ice: E82x: timestamp processing logic fixes
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Petr
 Oros" <poros@redhat.com>, <netdev@vger.kernel.org>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
 <5abb5015-eee0-41a6-a4b6-5ca9ed0a9f0f@redhat.com>
 <0f0a865a-cefd-4896-949a-2b4d72121b4a@intel.com>
 <20261027151557.6365ef68@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261027151557.6365ef68@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS3PR11MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f03415-4ca7-4448-e470-08df347dc0e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 8Bh8qUbyHGNw7IIVhK99n6J+jlgscnbkriSnDwA8uRslGhwPbI2+XpfqmOQRso1Yj2KN/VeRwL9gLQrZ1C4kQeonlbeKIN3zmOczcu93RVmbCvuKam4AA5aWIsc40U6fDmQxlR57qfup6HZiI81CcncklROGwkpULeN+I4QoiqLXGtgfaEXdZInr0wR+9umdN7rGUHPi/R2/G4+XqHO1GKFWX48/65aArgpKVvI6jhUF9hHPs4sRiAMR6aGCylxId0gLaq1476l3GBjH/JpN7F6MBis5aHKD4nPn/QHWpkFrg+82nALCocq6OjIpBtP2hnzHVtmDueh4KEZD8Zdqwz0R+koyBu+w2RPgWsTYt0dJ5xdblvkNVlN7OCLNk3c2RyYTQBJkOnQ18ZO9aMjWEPbpZGVRUfrNTtWV+zOZV/h9uWZuDiQkd39eRqbz9Qw6Y5ddMP5jSb4OZgi3RvfYU1A9vPqbzVkXyIMDUXFZlmC3mO/xEw33MgewNrSCUU58PBlww/Zgq4eZurYNW4oRUzaCyQ5GBRSUmUKEJOgaamOjcCPFkc68NkxMnc6HguKFNPqzx8MJxSB0GgHe9bpLgc3ueYaxushLeJoqr+KIS/K3JUexhIlFbV98fftxDfGeHwZenHEdAddRnJlc+WaEcnkxe0CbOdAPrXVUJ2Cr6m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejExMEk5RG1Oa1ZOd0lGa1Q0MTkzcG1MUENWNWRQVkdKTWoxUTJDdlhyVXVL?=
 =?utf-8?B?Z2prVHFWK29jekNyTXhacmJqa0poT0gwcGg5bWdVTks4RWtiV0RWTUhQRjRm?=
 =?utf-8?B?R1VIUXJleEhNNnFseWhLUjIvaDhlUy91QzJheXpGTFBKVHZGaFBHRVk4UHIy?=
 =?utf-8?B?Y3Y0ZktiNzh3QnpkNGg3dzJnSmVwaHcrbHppc1liNlNkM3dvcDNXU3lTT0Er?=
 =?utf-8?B?T0ZOOWh6TkNaOFpZbXRhTU4ycHFXSC9LOG0vK3BTNUlESjFteXNLcjRCa3Vo?=
 =?utf-8?B?dGtkV0ZUSjdENlEzOVMzM25sRG1Mc2xOMlUyb1dVVnJoSmxzc3FjbFpscm9i?=
 =?utf-8?B?emxIWlBjQWFvU0pmcEsrcTdUdGhiL3M1UG5scUlYUjhNVmJaNWVsT2c5RzFD?=
 =?utf-8?B?ZWwvQndJUkRiai9NZXF0WkpYT0RtZmMvQ3U0L0F1V0ZLQXNMdVU5ZzhLZHFo?=
 =?utf-8?B?ZUFIdWFubGtJcjQxRjVBZ1JzYlVHWks0OEUyS1ozemttd1pVYWhUcU45eWo5?=
 =?utf-8?B?M2VqUFQveEl0RGQybDdGU0FtTU9EaHU2N1N6b3hDaGFIWW81SXlORDdhckdN?=
 =?utf-8?B?TkNHbkFBWFNmaitSc2hMcjRPeC84d3V5bW1Ga0tRSU05NHRrTXRxSlRVMnVE?=
 =?utf-8?B?eVRiWlJGd0tRRTNSa2grNkI5dy9kaUNrLzN5U1E4bXZRem9tYWJqZ211dUxo?=
 =?utf-8?B?Q0pjclRWeEdwN01SUy9YcnplcE1iaEwrdnpxL0ZkZGVzckZoYmZ2RU1iVXdj?=
 =?utf-8?B?WUFIQ2UzYndxQzBkNWhhcnpKcGphcnQwZ0N2RmkrdzhabVlBcWNnbTBVOGZ0?=
 =?utf-8?B?azdzUXVlTUhMS2JCOHFOUkorWDVXcmhpWjlrdmxpRGVOamxIVmNNT2Y0MXI1?=
 =?utf-8?B?cWZ4L2xHOU96d0s1S2tYNm1idU0yL0tZY0FNY3pPM2htakhwTE03cjA4anNM?=
 =?utf-8?B?SzZzdlMvR1FKUHFsTmpUTnIzc0FGbFZwbDBES0dQT0ZXejRta1N1N2lHMG0x?=
 =?utf-8?B?bFhGMFE4MmFYelJhVmh6YytNQUJBU21UM3lqYk50T3R4L25SSmtIaUM5aXFk?=
 =?utf-8?B?NFNvZnBFeEp0b2FIY2c3bi9JQ0VDaGp4ZEM1L3BCKzJITm4vVG00R2dycWlo?=
 =?utf-8?B?WGFHWlE4Unh5cUZHTlMzV0hPZnFXM2ZoTkJGNkVlNXJsY1dncklXQzVJWHgw?=
 =?utf-8?B?dWRRNTRobWRJck9ZUXFlTlVmVElwK0J1Y2MzSXh4eUJtSitUWG1XN2J5eG1B?=
 =?utf-8?B?YkhzK2VHNWdJSWxBSHVSb1FBSFdxKzU2am8ya3dFaXBlTTJaZnord3JCdStQ?=
 =?utf-8?B?UVBWRXFuRVlUTkJOejZzMFltQWhqTCtHMU1YaUN6Vk55QXhmK0RkNTJYYXE1?=
 =?utf-8?B?aWtmWXBqbEl1NzZUUmNzTW9IaVduZ0xwYUZFcUI1eWwvVFc4c3ZveXlPZGI5?=
 =?utf-8?B?dDBqOE1ib1NQY2x3SXlhQUk4SzF2Zm9VYzN6ZVllZ09jQm1xZUZvcjhqMk14?=
 =?utf-8?B?cjBVK21MOXEwaytSbk11cVdLYUxYbDJoSTcyRjYwWjZVT01UcmJDMzkzdmZy?=
 =?utf-8?B?dGYrWmtscjZ5MmZOV2ovSVpRei9JUkNFWEdCb3BsYWRVOGgwYWlTZWh5Tkda?=
 =?utf-8?B?ZEl1ZzNUYzllNGFzVUNJTTl4VXQvdmF3bjh3M01GQVoxeEtYOWpLM2M5b3h0?=
 =?utf-8?B?NjUxVFA5SGlsaXVUOUdwdXIyeFVvWU9vN2NBUHFneXN1MzRqZ2N6dTg1cDFT?=
 =?utf-8?B?MHRlRXlYOEtPRUdBMjVSRHh4SExvTmZXREN0a3Y4ajljMWRYM28xa1pHYlZu?=
 =?utf-8?B?SjEwaHNjdG1leGQ4TWpEaHlSZXlwYno3c2ZJUko4allkTmVBTEV3dVY3NXll?=
 =?utf-8?B?eW84b1Z2UEdEeFlCelFVdEtId1hCazZTejlGQmNnMVRZWlozU0ZwSTdnK0pN?=
 =?utf-8?B?Ym52VmxmSlhQS3VNYTBwSjlMb3NPaHRBNzdOemFaQ1FZSHg5cTJ1QWgwbC9O?=
 =?utf-8?B?VmRzaDBJN3VtVUxNSjJwYzM4WGxWSnhTVWg4cDdzT05VQWJIV3U4N28xUXk5?=
 =?utf-8?B?UGxwVC94VThPNUhWNVI2ZjV3aFBtZkE0K3ZLRTJDeWg3Sld3dzhicDdlZ000?=
 =?utf-8?B?QjFPclhRM3ZnY3MvWUF0bWd6em4zM0M1UmFQQ0tQRGR6Q1M4cVcxdXlhcm8v?=
 =?utf-8?B?dkxobExPNDNIUTZraUh2WmlCdWIvNitDNFQ0cUNWNGlNWTFlWXE2UDhTSG4v?=
 =?utf-8?B?S2JZb1c5MjhYRHpxV0JSbTZxRUFSVHRPVkhFd0dld0N5ZXkxNkFpN2MxcHh2?=
 =?utf-8?B?cDRjeDhQbXFnRyszNWtxdDh6ZVNQU3dpaFczUGE2RUFMVWVqZkJsdVoxS2sz?=
 =?utf-8?Q?AoN4fzeYRhSLPpkI=3D?=
X-Exchange-RoutingPolicyChecked: Lya3tbNCTNr98LxP2MQf+uKkNAtY27APcr4cu+AgJEL1C3NSVZi5Hvu/I3vNiY2axobggFlSa68Bkh7K47S7r0m2ZZ9/tuMp4KeElzKfhcGkS8sokvMcFqlVdKINztw+2lBUh09wlAUXnNALCJ9l3a9Sy/o96YFfOkmBiK1KEaMXEjfvzgumDDrNFI1ZznSijiZQ+FYhAMpmbn0gTAgLUO9OUwgD6AGELiIHDSb3rnbsc5cHAAQ36r2bWU+nXyJYnqHdeKpoISAsGbxL+QC9kIARsM5WEdfyhMGPHOVOfXIb6uSWHiaUiWQxDw/ndxng2bXSWROB5VMbw5TjES/XGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f03415-4ca7-4448-e470-08df347dc0e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 22:58:02.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFhjYLDH1HNsCSvlAtcULp7IffM6Q9Ohh4QjL51wPKM+zTr+GZ5McLQA+82IXOS3be36qOFsqIvsZtUmam+oVR8zT2aRNXCV3XjIGhJpfns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9622
X-OriginatorOrg: intel.com

On 10/27/2026 3:15 PM, Jakub Kicinski wrote:
> On Tue, 27 Oct 2026 12:32:30 -0700 Jacob Keller wrote:
>> Would you like me to make a respin with just that subset, or can you
>> apply them? I just checked and that subset successfully cherry-picked
>> easily with no merge conflicts net, and appears to build fine.
> 
> That's too much of a cherry-pick for me TBH.
> Could you please respin what you think is ready to go in?
> 

Will do.

Thanks,
Jake
