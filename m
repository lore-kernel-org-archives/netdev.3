Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792452096;
	b=Pzm/1SE+SSkS6vPFksQsLIZaldB55vsLfrt1D6Egg+zWbClD039JLAKJbTXQr8jMohFz
	 TJNqv94UZXsKMwZx6cCsed53j0fLJPbguFQXL43spg93dA92xj385OW6PWwMko7Aa6Kcr
	 DTvZ1O6x6DD7yJk4aAFoee9SdUR78k6xF6pQSfwWfooj7AJsvuvs9RtrYpgBLonkhOh9j
	 d0M1ymlE8fzYlDcfjdmZEUk2MOc0Xq3uVcpT7ZmgYNg7gcbOu5VkBTB03ERZ8lymA/Wf4
	 tUOJaIkHokrxR9Eak7ZPDrixixOHfCcr1jFQH/DkbFuvqvs8Vwr5Ved8jU6E/Rzz3nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452096;
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
	bh=YXwNMU1VqMXBWx3tiZJXCZYvOT4bTIpmCYyjLdLPp6o=;
	b=zBIYRlOU4tJl4QmT1l22jxu3lz4+MFSKTydFDeaQXPVOPuJj1nfsIMpbPN+4Bp74noz7
	 EQzHPj+Yv6erlOzjkTBhI2E4EToNtQxGo0Te4Kc+uChAmbcji1pt0/stZZ/xbJIpekxFu
	 08T2GSL4I0rirLCRduUNcLzT9Ro0tgpVsyYlaUtmsbjiZtxTz+oUv1+BbJc2+LcIZeDYE
	 8iLrvskgq+9u/Ta1MMLSWJG1CgxDgh7tYBKz0Xhx6idoLtUiT2yBHDSTta/eWz/UtPIWR
	 F2gEch2q3bo7MZnzHnooIZxXO+tXmwTob0bi5mIt7k3GWwFLEEQQB8ixg5Qc6UrMs5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Czm40ZoF;
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A10606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A10606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Czm40ZoF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792452096; x=1823988096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YaU+NyYmUNaj/4ZBXjT+bwhmOr1DRscI2wc7dxbgECo=;
  b=Czm40ZoF29gpp28Jw48+SNbgu15uzFzYMMiQPlJcJZoA0cnZkNKP11ZG
   +zokRRzEDUiWC31dw5pl2REEXyxb+COhA/134wF1l13XNeKMowVdagx69
   HfXJ5xyo55puoz4EyHgYOCRJZrUR8WkjYL+ky4xiD1mFJ6zvXo28I5P1F
   fSqbce4VCmIhpzMHwY0amgxetHbZ3wgFwcOLcVz+J4KjtqgQg1j0OGyhL
   JES9rzttfQ9zIILwohOsho5ZQFSOslLlrv68oZpjtgswFg5UAs9YDRnZi
   7Kyts0m+HDhmiVI4aVK/8OTtC8N71rtldGRDkmSL2L8INsj5u2JMYpUqr
   g==;
X-CSE-ConnectionGUID: LYK7tR0GRUKVd5D0ndrVPA==
X-CSE-MsgGUID: ZG/Ci3FkROa97KrtCJAenw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1027362"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1027362"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:21:36 -0700
X-CSE-ConnectionGUID: xkj2dgiLQLmVKj0RlhcdGw==
X-CSE-MsgGUID: mQdMT8BbQ+uuBpm4NM+uDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2719300"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:21:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:21:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:21:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqC+FAdzxGrtkbi3zeKB9vPXAlWleIstq/AlgX9RjeAZYDzbX4eZvAnM/Ci9VAfXhzg65RlGFkera2s1d5aXlykCrdhanr0lasyrTBS73O3U3gmrm2rTPlSMmPhUolYl0//G+dBBfxXfk4qg4p4F69L+2AP9pOJlIcEytvVAj+tXAQOufclWyoKOxgVPAsbemafwOm91FmBWnrqyTBajlYnehJJsUyqENV6sgfhcWu2e5uUkNUR3r3NqQJjaqxqSoY9hVVKOjc5TVDNfOdVsgvTaimVtlGf+bddJ5QufbvOxaheUuVv/tt8Y5AxjEL+pVzF8uoTcHOM1wJ7SYghYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXwNMU1VqMXBWx3tiZJXCZYvOT4bTIpmCYyjLdLPp6o=;
 b=eWl6pd9BpaxbGFcxo6DQ7kK40USaINBGVRGx1PGHqgmuYHyfbDVkQn+hV4pugvq3iBEc2KPgQmIPisclB4SKKU2MA5Fu/hWizoaImKItyeOip+wbjp34MGfJoYkRdZObZ+tgBVNYMsrdyEh+zs9Sl3Qqqpupsxb6x+vtNzR0zhLJwR/BjQwS00mq7p8pORpzQNhwQGHtLRR9zjNQsrvU1daRz+S6olEA4HzkG8uyyV+n5CQWO8RbjVyDsCVItx4sQ1WyyrO3MPS4FH12SGS7uAFVGVQZmmeOI71JOQvuEHAvZ5eH4fp12dK1ty65x/2t8S/T+s8JFNDaPe1EXJHk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by EA8PPF15402513B.namprd11.prod.outlook.com (2603:10b6:30f:fff5::791) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:21:25 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:21:25 +0000
Message-ID: <fd64b519-9e3b-4eb7-b9ff-3feb4d169ab2@intel.com>
Date: Mon, 19 Oct 2026 16:21:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 03/14] ice: fix PHY port restart serialization
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-4-anthony.l.nguyen@intel.com>
 <179244084394.3135.13607937299434468009@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244084394.3135.13607937299434468009@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|EA8PPF15402513B:EE_
X-MS-Office365-Filtering-Correlation-Id: b94c8be1-8c3e-411e-e59b-08df2e37b1a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4P6Xw4zkfv0s7VzVIuj6B5TNXibX4rOGwyzeQLZK2DsBzWpe8Z4QTv0Nkol1SdHLjwrVqiv5+sEZjPvcTYs8WJy522uCX1gGj6qkl8hieQkCTdTtFlXpcdwsD0voSPk9t5MPhpY2PmYxsszfsYbCCBGMeXyBiT/9c5IANtILnLTOUn3u+Cv8Vx7JRqqCxFTGb1LWcg5AuvKNGKwH0yGjnymsTkuqmeid5Sdsaqmx2/Xlp8iKEfKxS1QIdTsJXBSTqAH1dK6ul8PfBFK6v0nhvTQ1SkrkuPBuwXzizEOHc3NM9cjNqtT4mFiCeJQWzTa2RQnEG6gTAEbgJ0B+0PGzpcSZabnNrh4RZnPvHHIq4XX/BgfIiZnqLV7VUTyqybSz5c00RFur4TE86oa9Q9u24xFtUTwRKBA1G1inUEMLkGKRQ/jxrPvf8NUnEQelGOhBCeHEkwAs17rw0czDOSWTlCW4JNPnwseYYsEjns9n3KIluQ5EQbM/R/xwpgTwbAG1ZQW8BEyzQBArzk9tY+MkDxD4QtM2+IgBG8nrVLiMy/V4ghmA9oXhGaP+t5zoXSzAxWrGwVeBKfNgqHzynY3J2JuhYKFtRGmPEatkPSOptyFSi1pCgTijG1tzyl5bb1mc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk01R2Y3bmI3VW5GdkRiWmM5SjdQek9qVFovQzFXclFhaDRyL2JtWUFtTW5U?=
 =?utf-8?B?TkdMbDQ1OEx3bUd0NllVZ3pkOTdaVHIrUDBQVyt2RVdmN1gvM2pyeDRmVmhQ?=
 =?utf-8?B?MjBXbGhVTWhLV3ZKSm1MZHZmNis5QVNqSTFXNkFSQnp0Z2VWZWZ0TkxPTjcx?=
 =?utf-8?B?alhUaFdLTjdSQnhYanNNdlFvU09OeFlqWjhkU0xFSHYvMzE0aU8rRXhpeUlL?=
 =?utf-8?B?SWRnTnJRNFJldU9OU1dJKzBtaFVqZElRR2x6bm5FS2sySTlPaEhraGdPSUM3?=
 =?utf-8?B?VUk2R0JvYWgrZTdZcVMvbWpNVlkzSmc4Y0dYZk1RQlJ3eFAzcmdWZ3MwUWtq?=
 =?utf-8?B?dnZuakFFM0c1RUNFUXAwQWhPWmVLQ2Y0a0ljTUxNejlSc09hdnk4dk5TR0JJ?=
 =?utf-8?B?OERUSU5wZDBWeDR2c29MSUFTUzFYTFV6K29UNG1uRXNVaEJmM0k5cHd1SGJP?=
 =?utf-8?B?N28wbHlhdkJQamRmd3MzTnZYa3QvRUhBdWRlM1JJT0ttb3lNb1pnTHU4ZFow?=
 =?utf-8?B?MGN6SUI1NEI4NE94WHU0eEZIRGs4NDhJdXlQdFJlSjlUZFZHK2VxdTE2UU1w?=
 =?utf-8?B?MmZZZGJHM0pJSG80eFhHeUYvTmtDUE1NQVZYNUpYMXU4aGRUTlBXaDVOYjJw?=
 =?utf-8?B?TmJDTHJvYmVtVnE0L0N0NUJiVlVPeTV5c1pKdERMODlpdGIzSmYxa1pXR21j?=
 =?utf-8?B?TllWYnJFeVNGMm9zU1ZGZGphWHJTNlcwSTVRRXZSZDRMc0s5UWEySEZGNGZU?=
 =?utf-8?B?Z1ErVWgweG5McXF4aDdBZmpNWC9CT3o2RTh1KzRvM2RiMmdKY2JXRndrcmRW?=
 =?utf-8?B?T0RnNnNMbDIzZUZyTURWbWFUWXVLRTVWR28wdklTZ0U0eTl2R0NGczJXSld3?=
 =?utf-8?B?UGlhakNNR01Rbld2SVVxY09ldi9LdktOTmR1d1Vjb3VsY0lvbU9xYUJGVlp1?=
 =?utf-8?B?WU9BQjR0Sk5QZmphaW42UC9PbFNKZjBIbU1odkVOOVhXR3dTOXFoZEYxTy84?=
 =?utf-8?B?UmsvWEJMNWRsbkI2Y1EwdWhPU1UyUGkzQ0xLTUJBcHFKWXBmTEVTLzZVMzU1?=
 =?utf-8?B?c2RZdEdiWmVaWUUwVS8valZnODJ5MU9NL1MrT2RCQTBIemV5cUYwaU5VY25B?=
 =?utf-8?B?RDZEamt0U2NZNmxDQXA4aTlETTl4ZlQ4a2l6cjlxZkVDNVk5VW9tZ3dCMERH?=
 =?utf-8?B?TFNIc0dNVG9iaFVSc0h6TXhvcFBTd0d4VHpPaWMwR21kcEdOUnIzclRDZjF3?=
 =?utf-8?B?ZG5FWUgzNXJ5cFhsQ1V0YTVEOS9INnhZdWQ0KzhSTVIrK0gxSHVqaktYak4y?=
 =?utf-8?B?SVM5L0hCSUdQU0R6Z0lldmM4VVFvbDFRU2JveFFlQkVmTlJWdnQwckZlS1JU?=
 =?utf-8?B?MjIrOVF4R3NLczhUVW5lczlYdjlndVVMb2lqWkpuYlNSbFpNWFVac2lKRGxN?=
 =?utf-8?B?d2RSZStwc1RDT0swTG94WVhlMjlTdWhaTDAxYnhMSmZxblpYQWFQclQ5QS96?=
 =?utf-8?B?dzZib0haeTNEUlhhbllheWFrQ1MrUmRWUWk5TFl6aFVTSkhMZ0t4b0Z4U0Nz?=
 =?utf-8?B?VEV0TTcxR0ZDSlNmMUdoZTBud1kvUnJNWlhvcVl4R2NxNjNwaUJ5RXpEdEdp?=
 =?utf-8?B?VVlva28yY2tBTVl6ejNuZUp4N05BdjUvN0lEZDE2cGhOd1R1VisxTTdJYkEv?=
 =?utf-8?B?TE9PRkJ2SkJnUzMrNG9pK21qYWlaeGtNYjk3L0t5ck9DVFprOWlNM29lNXJZ?=
 =?utf-8?B?NUg4bUxoRUE1TDF4QUVZYjFTdTdMbUJqUnlTcHo5a3BRTWJhNEZ0MlQ1dlNy?=
 =?utf-8?B?UWZzNnhUTHVFSDlwOW1rejdqa2VFZVhvMWtPc2xlZ3NxSTRWZC9vS1RlZURH?=
 =?utf-8?B?SUFjVVA1UnhGdDNwMjl2RWh4ZklRWi80MHFmc3BOT05halR3anB0azRNSXph?=
 =?utf-8?B?R3FIdko4cTExeWpVMEhoTGR6aklaeWhRZ1BBZnNsQ3pyWjBjbUo5Wm1wR1F5?=
 =?utf-8?B?SHh1NnkyUC8zZHc3bE94WGlweE5hN2lvbVVreHZqY1ZYeTNoMEFXQ2x5aE5i?=
 =?utf-8?B?T1cxR3RXb0o0eVE2eVZwT0dOdisrTW9WcDRyQXlET09oYkt4MzlFY0dSWWsx?=
 =?utf-8?B?dDNsZnBIMzhLZU5SNlVMTTU0ZmErODVtMEtTQ3ZvaTR2SXNwa0I3b1NwU2tK?=
 =?utf-8?B?bWZGK0tmdHZCWVZxeXdKSkEza3ZUTU5LVGdpSTdNVFlrK2xvcjRKM0J0ZDRD?=
 =?utf-8?B?aTlNUjVsclRPMUxUci9ROEdVL3ZjNFZ6czhWbkx6bUZ3ZThJWHNzSnA0UkxD?=
 =?utf-8?B?Y21qOVVnNkZYK004blh1UnJBZG0wS2hyc0ZEN2JmVXN6QUJlN0JSZz09?=
X-Exchange-RoutingPolicyChecked: Cy5wpoR4mi4Dd+mPZnN5rIT2sXA1Zj4ByKa/5+GVanuor2xGDiKrjNTDatDCIRLYBbiptYFIxgexyk+L4OUnaHiqZSSh31T967JxntLCMv9wW0qvK93ummoF+9LuN3kGcQnFOM46WdwwhY8vP+hjZqfr8DEODqGgvsHgXmt6R2kdMBOS83xpe5L0TCCPSKuseI2m3WDbh+4FWyJQhu3mg0IgzUM8xvoEamFynggRnsPknzAH2LT6BNkArPTHNHlmpIunqAtjmNEdI2BNEzJhfE3f6pIsGGbN9HktL5jO9eQgtLNTTEyfk6lr368zLYn22KusejNwPSx71+kOhcWNfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b94c8be1-8c3e-411e-e59b-08df2e37b1a2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:21:25.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS1yFYum/up1IGnVK1AFdaprDYJb15vybZyVuN7rG4v69B16gml+Eh+Mkad0/bjtdjBHk4Z1aQCW/U6ZJcLWzEHXDpGjtQAXMpGIJCh6OlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF15402513B
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] At this commit, ice_ptp_link_change() still returns early on
>   `pf->ptp.state != ICE_PTP_READY` (ice_ptp.c:1312).
> 
> Pre-existing issues:
> - [High] ice_ptp_release() runs its teardown without ps_lock and without
>   serializing against ice_ptp_link_change().
> - [Low] At this commit ptp_port->link_up is written with a plain store
>   under ps_lock in ice_ptp_link_change() (ice_ptp.c:1319).
> 
> --
> 
> ice: fix PHY port restart serialization
> 
> This commit replaces the per-port ps_lock with a single ps_lock mutex in
> struct ice_adapter. ice_ptp_link_change() now takes that lock to write
> link_up and run the PHY restart. ice_ptp_restart_all_phy(), ice_ptp_init()
> and ice_ptp_release() also take it around the PHY start/stop calls.
> 
> Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 55241802d17ae..d1cdd38ea27c8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -1314,12 +1314,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  
>>  	ptp_port = &pf->ptp.port;
>>  
>> -	/* Update cached link status for this port immediately */
>> +	mutex_lock(&pf->adapter->ps_lock);
> 
> [Severity: Medium]
> Can a link edge still be lost here? Just above this hunk,
> ice_ptp_link_change() still returns before it takes ps_lock and before it
> writes link_up:
> 
> 	if (pf->ptp.state != ICE_PTP_READY)
> 		return;
> 
> 	ptp_port = &pf->ptp.port;
> 
> 	mutex_lock(&pf->adapter->ps_lock);
> 
> ice_ptp_init() does its locked restart while the state is still
> ICE_PTP_INITIALIZING, and sets READY only after that:
> 
> 	mutex_lock(&pf->adapter->ps_lock);
> 	ice_ptp_port_phy_restart(&ptp->port);
> 	mutex_unlock(&pf->adapter->ps_lock);
> 	...
> 	ptp->state = ICE_PTP_READY;
> 
> A link event that arrives during init, or while the state is RESETTING,
> is dropped without updating link_up. It does not wait on ps_lock. After
> that, the init restart or ice_ptp_restart_all_phy() during rebuild
> programs the PHY from a stale link_up value:
> 
> 		if (port->link_up)
> 			ice_ptp_port_phy_restart(port);
> 
> ice_link_event() does not replay the edge once old_link has been updated:
> 
> 	if (link_up == old_link && link_speed == old_link_speed)
> 
> So on E82x/E825 the PHY timer could stay stopped, or be restarted from
> stale state, until the next link toggle.
> 
> Doesn't this undercut the commit message's goal of setting link_up in the
> same critical section as the restart?
> 
> The later patch in this series, "ice: call PTP link change only from link
> events", appears to fix this. It writes link_up under ps_lock
> unconditionally, checks the READY state inside the lock, and sets READY
> before the init restart. Could that ordering be folded into this patch so
> the fix stands on its own?
> 

If we need a respin I can fold the fix into this patch.

>> +
>>  	ptp_port->link_up = linkup;
> 
> [Severity: Low]
> This is a pre-existing issue, but link_up is written here with a plain
> store. ice_ptp_process_tx_tstamp() reads it without a lock from the misc
> IRQ thread:
> 
> 	/* Drop packets if the link went down */
> 	link_up = ptp_port->link_up;
> 
> Should these accesses use WRITE_ONCE()/READ_ONCE()? KCSAN would report
> this as a data race. The only effect is a stale bool deciding whether a
> batch of timestamps is dropped around a link edge.
> 
> The later patch "ice: keep Tx timestamp slots tracked until completion or
> timeout" removes this read from ice_ptp_process_tx_tstamp(). In the final
> series, all remaining accesses use READ_ONCE()/WRITE_ONCE().
> 

I don't think this is a significant issue even on a respin as patch
ordering of this series is quite difficult (different orderings seem to
get different complaints from Sashiko...)

> [ ... ]
> 
>> @@ -3498,8 +3497,10 @@ void ice_ptp_release(struct ice_pf *pf)
>>  
>>  	kthread_cancel_delayed_work_sync(&pf->ptp.work);
>>  
>> +	mutex_lock(&pf->adapter->ps_lock);
>>  	ice_ptp_port_phy_stop(&pf->ptp.port);
>> -	mutex_destroy(&pf->ptp.port.ps_lock);
>> +	mutex_unlock(&pf->adapter->ps_lock);
>> +
>>  	if (pf->ptp.kworker) {
>>  		kthread_destroy_worker(pf->ptp.kworker);
>>  		pf->ptp.kworker = NULL;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but here only phy_stop is
> serialized against ice_ptp_link_change(). Can a concurrent link change
> restart the PHY after release has torn things down?
> 
> ice_ptp_release() does three things outside ps_lock:
> 
> - sets pf->ptp.state = ICE_PTP_UNINIT with a plain store
> - calls ice_ptp_release_tx_tracker() before taking the lock
> - destroys pf->ptp.kworker after dropping the lock
> 
> ice_unload() calls ice_deinit_features()->ice_ptp_release() while the
> netdev is still registered. The service task is only stopped later, in
> ice_deinit_dev(). So ice_link_event(), ice_down() and ice_up_complete()
> can still call ice_ptp_link_change() at this point.
> 
> The READY check in ice_ptp_link_change() runs before mutex_lock(), so a
> caller that already passed it can block on ps_lock while release runs
> phy_stop:
> 
> CPU1 (link event)                  CPU2 (ice_ptp_release)
> ice_ptp_link_change()
>   state == ICE_PTP_READY
>                                    state = ICE_PTP_UNINIT
>                                    mutex_lock(ps_lock)
>   mutex_lock(ps_lock) blocks
>                                    ice_ptp_port_phy_stop()
>                                    mutex_unlock(ps_lock)
>   ice_ptp_port_phy_restart()       kthread_destroy_worker(kworker)
>                                    pf->ptp.kworker = NULL
>     kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0)
> 
> On E82x, wouldn't this use the worker after it was destroyed, or
> dereference NULL once kworker has been cleared?
> 
> "ice: call PTP link change only from link events" later in the series
> moves the READY check under ps_lock, which closes the kworker case.
> 
> An E825 variant seems to remain in the final series, though:
> 
> - ice_ptp_link_change() can take ps_lock and see READY before release's
>   unlocked UNINIT store.
> - Its restart path then calls ice_ptp_flush_tx_tracker(pf, &ptp_port->tx),
>   which walks tx->in_use and tx->tstamps without checking tx->init.
> - At the same time, ice_ptp_release_tx_tracker() runs outside ps_lock and
>   does kfree(tx->tstamps) and bitmap_free(tx->in_use).
> 
> Should the state change and the tracker and kworker teardown in
> ice_ptp_release() also happen under ps_lock?
> 
Or something like a flush on the service task work to ensure it is only
executing on a thread that already sees the state change. This is
pre-existing and is something on my list of things to follow up.
