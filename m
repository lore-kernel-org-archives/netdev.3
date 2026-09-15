Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD3339719
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516300; cv=fail; b=UU1X8kpOMADE5eipMCzpq9SjlUDYm5YCEZmxT6I1w1ZorlorEBk3y9mN0rxcrcTQgFhdvdmKFeviR/YjKbibvEWJDjULX3EEKa6Zg0mT74+aD6kTcGp4Od3qmKB8mzEnyIwFpJ8v0nH8fLm5xb84MjdBk5zFUpk/r0TX4+Ros8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516300; c=relaxed/simple;
	bh=KRtTqB9gb8ug14mvC+jQxSLlSswzJZPQNqHxAbSEq1g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwCQjBpXBdYWZbq7bSv4c1rHZRYSN4F9QtWfR1mtDc2MkUoiuteD1TURuSR099M47aJtCVfXiF4bPlONsXRPvTZvR31rD5jpMQaJzY1F5X1TISNftlm5afkkbkP1ZpKYh7DGEciTeQAIpTUM04QGgGznYRl/aWnwntGen90JtP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIXEAAOo; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIXEAAOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789516297; x=1821052297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KRtTqB9gb8ug14mvC+jQxSLlSswzJZPQNqHxAbSEq1g=;
  b=LIXEAAOoDNKo7e9lSun7uXmA2ahnxr3kEAxYBxTZmtLWkHH4a67kvQ2T
   RuQiHRc19bn9z/CSx9OoRKx7yI2c8vhaNkEXRbWrnY2A2sCa3jaNp5icy
   v85Fp021kEYijaerXaB9fQmnG0g5INODZ25Sr787WsqkbULZ3EWssJXfv
   bZqxsRez5IFZwMCxe1RZaRCBeVWLLhtMUJC1chFxW3CvjcapngNLEoWTx
   a+Kwq2AwM/vDeVUfYKg/eAO+FLd74r9oENxzkxJiR9EcnNF9T1NgBO5Zj
   xFtdzESgv5NxZztjatktx0eKZsuPa/mamcVsgHctQbfjFBBVkj4a9oA9m
   Q==;
X-CSE-ConnectionGUID: 4YmcbcfpQXarZ26b4IoEgw==
X-CSE-MsgGUID: i+yiy6UfSKuEm99b/t7sOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="397033"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="397033"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:51:37 -0700
X-CSE-ConnectionGUID: mIOoN8AcTTmzJQj3vXxHWw==
X-CSE-MsgGUID: QlxAd3o6QYydUr7JlUU6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1395483"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:51:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:51:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 16:51:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DarmYBLKiwXn0Bo8n+yYLmSdfUWtTLjvt9oBsB81UFNp2cBtMHD2JsFt4MfrFAOgnuAXdOrzp6+izUo04PiDYeN6doIwrD5N28hwHJyphAN7VcpHh805HCoIA4v0KTV9+XUVD6l4UhWjSpa1a6ODmZfiJtIDmGMF5W6TzMCoNoAgqSZjCTdCnUrwVk5HvxMj/L1MTjF5w/AKzYsJSI6AhLpxuzgTfBINhKfUCpMMR6HD49cxLAU7RZrm+UzsBRsS1PLTsgKTJqWgZIt7RteuJNeuRBtuefGhBbGKpbTDwmgX7O3HwGaV+THMoUZyQofK1LZajAgF3LGD/98GcsyKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gNTKZhjzp+mAlqieJcJmL+p2ZSuXsmUWFZFwErhKjU=;
 b=WzRaFsU6STLgSosQq5QbAD6y/ywsfk8Ftgc2WSYnMkVSn5tYzSv5kVP9xaqDVPfnh9kliHxgUJcxUX/l0kSH/BWuiP0G3nMMu9o7G+22nRco2YRDQucCw63FbrWWMJaTut9Lzr0B2wd0b7BMggTObie/LBGVZ3NUW5F7bjo+I9jLKERSaaHL5OMb/8CQ4AinXUYKIBJp5KmMnNjDVsBxLRzjZdnbDNmjWOr/sJkA1odIo+LutitKH+UpTf24C+zsIBUa9a+pxweyl7tgi3Cq3idtE8LK16eW67E8ZJ5ZfOLq9lmZU2i0U0tDY3VTnU7VPgZioJiHHWob3o9XOlCqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 23:51:28 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 23:51:28 +0000
Message-ID: <37ddac74-f30b-4143-966f-3c26cc9db323@intel.com>
Date: Tue, 15 Sep 2026 16:51:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: libwx: fix races in Tx timestamp handling
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Kees Cook
	<kees@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	"Vadim Fedorenko" <vadim.fedorenko@linux.dev>, Sashiko
	<sashiko-bot@kernel.org>
References: <73D0D3F5D96A6928+20260914080020.211580-1-jiawenwu@trustnetic.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <73D0D3F5D96A6928+20260914080020.211580-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 07932871-ccbd-49e8-806d-08df1384425a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5YTeNf6BdGt9d6rEm5R6Ssu0JfFpw2i+//ob/zylbCDcOR0Y4bq1Khad4VZiESc53ZS3EP4KsQjdhjre3VQp2jysmZ+W/g+hk4EodZdzNDcmbu1KMMqpEUgIpFsFNzjANuMOoqEWUfeQfWCo1SSa6cBW8H0W23ZkQRy9ZPUbqp+5snjDZWgObLSKrUWRcMjHiWmvhkEK6hmhNWKrCaItacW1omN9GppXntMFyOHemoMwLdfZFw6r+6f/z2eBIqHur2sopiW68vuzmlVDDYZXww/wlNxsnD12ztp56/xVLKjCVBbMUJcSTZYWTy/tv3sljyRC4RoDXGtfLWiz0OhhRPpL6grk/mb+8fWh1/tTlnT54NHGdFC9LyMGsD0D8BTjx6Ln5JW2ETx1LX5Pj36RyWHNKI+6dZVFnVnti3aGBihVJ2ieADn3uP0KrM6rgt2rcG/Uf76YCr9OkSQ4OCNtxn0SJF/i2XdEjW+WVre49akvrQxUl289YdWNu2iw08krBWytii087IVJtYyBPwThzMJGQ+JOFGwdq3IRw4f6zXivU/wF5Iepu86H9B6TFpS+5gT6cisSYvTsQJFdaRzzemseRY/C+O/emuIRLJpLWKXKkZsXhUyZPUwtiK0sSGv8EOh6IndNeM/DkGovztcArUhZ263AdSZ8bSDaOJcuwhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pJNFFaMFlnQUsxZ1BDM0dicmQ2VUtRUU9hQ3UzM0NqUlNVMmxSa0NaeC92?=
 =?utf-8?B?NC9xZ2UydWFRWlRqYWxyeDlOVE1sdjg0MGRvZS9VcVZrSmx3a0c0dXNiTGsy?=
 =?utf-8?B?R0krK1lMYTlPMFBod0c5Njhpc0ZtaFMvUThYTlZ0OWFuZkE1RW9MdURkVjcx?=
 =?utf-8?B?bnZ5VmVVM3RTNjByRVJPRDRCd2llUUJVLy9ucU1HSXFqYVFVc2xDcWs5eGIv?=
 =?utf-8?B?YmJNNTJ1U1EzU2JSQ1I0cDRoQjRsT1BuQ0tjYlM0TVUrR2pYaFdHV083S1Fu?=
 =?utf-8?B?VTNrdkd6K3J0VFBxRkhIWlRlM20zaHlkRit1NzA4SlpJbE05bGlkS29ncjMy?=
 =?utf-8?B?SXd3R25UZUZCK1R4M3pXdEd4TGplQk11bHhVamVMYjQ5T0pkKzFISjA0eGlQ?=
 =?utf-8?B?MlpWcU5hR0ZNTElKZzh3NHhqaUlOT05UMTRXZUJxOVhzaFlGT01MK3Z5Zzh0?=
 =?utf-8?B?VmRLbVhOWUpuUTdzTGg1MlF6YkcvNGNHUU1PSUxvZEJJR0h1aGNIa2VvMENt?=
 =?utf-8?B?SlVGVUkzSXhVcVgvamRGWVZCaVZzNmIvcElVaDJJMlVRVlJiREpnZXlKZElo?=
 =?utf-8?B?NUQxWXRGUHRQd0pwcXhLN1orMFcwNUY5L01ZRXlPUXFGMFZ1UEM3NXVHNUF3?=
 =?utf-8?B?WFl0b3BrOVFPdjlGTmZuNys4bHRrR3l3YWJ4WWlIYUNwcHVnM1ZqTGd5dSt4?=
 =?utf-8?B?SHMya2dyMzVkbzFDdGhCYjhUalQxc09VMktrQmU4RmluTUhSUnpUY3BqZ2U4?=
 =?utf-8?B?cGNHS1N1NFBwMVNtczBIcmlnQlZDMmtiSE5pUStoTTF2bUdEZFl1Q1BkdHhx?=
 =?utf-8?B?K3RxUFVPMjJIMFdjOHM0VEpoazJFZzRjMXM0c0RTUnJiMVkzb0FaK3BjWDZF?=
 =?utf-8?B?NDJtSGJjV01mUVJBeERtSGw0WGNEWTBZNHNMREplVDVWYnB4UHNodW93RjBV?=
 =?utf-8?B?eEUvMExndzE2UmhXSEJjdFo2QmxYN3M0NSsvZDV0TEdnRGdOMjJDRENaZGJ1?=
 =?utf-8?B?NnVPMUlTdlNtUGVUcTg1Ly93WE8rd3lqeXZSWUxaRitSYUMzR1VyZGFQMFRX?=
 =?utf-8?B?T0MrOUJBcU5lM0J5ZnBGazA1REYwWlVXQ053bFFJL0JldXF4dHFRWmcyTUxJ?=
 =?utf-8?B?ODdZWXYwSlRpYnpSYVI4MWphZ2d4T25NNDljVXA1NUJOcFJ4VjRGdjhpV0hi?=
 =?utf-8?B?UmpSeWFrSkJseU15UjdkbDNaYkNGVkdScThJeGE1MlBHZlkvcy9JQUgrOXEw?=
 =?utf-8?B?NnFvZW81Zk1vU2phcHNtNzkzOVo1bGUyTXYwaTBmZWg4VkNSRGlqd2FSZU5F?=
 =?utf-8?B?NmhhL0tHWkZCbXFQeSswY2ErT1ZqYjZCSDg0SUFnSlJubkptSXN5TWpDWGsr?=
 =?utf-8?B?ZFZuZUgxdEZaYUtnd2dhbnNtZmZDakpYaXB2aDdua0lDZjVsMmovS2FQcTdp?=
 =?utf-8?B?Z09EKzcrSmJvdzRSUG53SEdKTEM5VzhtbjhFL2FNTDRCeTRBTDM3aWtjVEdD?=
 =?utf-8?B?VU93T3Z6dkhyTVJmcU5IbEMwVGp0WllkZUJiZ2lTRnhXZFFvZm1XYnVPWlBW?=
 =?utf-8?B?MzZzRXZhVmVLOXNVSTJaNm00Q0VhVThoQnFVRFU1YmhSdklyZVhrNGM2MmE4?=
 =?utf-8?B?MVNPayswL01oZVhhYVdCc3oxUlNSMnB1NzBwZWJISHRQQ0d1M1JQWEFLaVdB?=
 =?utf-8?B?c05nZXlBYkFwT0hEVUdYbDJ0RDZ0NGJTWjg0K2U0OFZBZWZ0eUZuVDdYaEtD?=
 =?utf-8?B?Yjdqcm55cXYySXlGbG5aN0lCVVZ3T0xDRGNkeEQ2Nm1oeHp5d2x2VmhmU0pB?=
 =?utf-8?B?U2cyUkZVT0ZoVk5aZ3hRYVBIVTFsUEEwN2tyR0hmTjUvZTQvLzZITDVxQzhm?=
 =?utf-8?B?S05zdXM0MDc5bjRkWEZiekZSVDFvaGlGTnJncGhBWWo0VWN0UjNlQS8rN0t4?=
 =?utf-8?B?cjh5VXhjNW45SGgwcG84WW8vYTMrSjNHcTV2NktKMzVFNzdsMUkvdjBUaTBq?=
 =?utf-8?B?Mnl2U1lvcG5yU3Npd0FEMGRxWE5QdmpjL2h2SkJkWXpxVEdWQnc4VSs5WGpt?=
 =?utf-8?B?SFpmYUJVdmJDYnM1amdDbWZmYTVaZFBOSFFMejFjOG1tdUQ1a2NpNGdjcWg1?=
 =?utf-8?B?L3ZEdzJmNlB3R2tNSXV3R1Y3eEpkYk1kRy90Qnp0TEZRcmkzTVhjc210ZHFt?=
 =?utf-8?B?ejQ5QU1ZVTFDUUhZUEd4aEYvbmlKeDMxMGRWVVlzVXNickVxRXl0bnpUb2cz?=
 =?utf-8?B?RXF6cktKMDY2TGVScTVKeWtVY01CL1JaeTNTc09vaHFjTTRMYmcrMjd1MldU?=
 =?utf-8?B?R3FaZVhvcnp5a3pyVHNCckdleTJqaHlrMUxpR3FISnBBdmJQakxodz09?=
X-Exchange-RoutingPolicyChecked: 3dMxoSL8CgtW1JKWougKFmQGKr87qwrzphdPwfOYAN1NynZoqIKltOJJRNiv8SteKWxeeLJtH2SvO4/q8X5LmiPORh4edSXqO6/cpd8v9xxgTlpecvIG7vqphmKFbg0PDmWszmUa1FYzyQJ/wnQTnmmYidaAH7z1SzGfQPQMISDkao7OMdq0wPVldrE9KN9ELfEH2WOub2EZKTM1bvdQcYItWHYfwWlW/qYe9lwy8EeHUYyYk1nQqgy5ypWVsXs1BBFI7pxACeWJz7t25xWX1Ysdi3TKJs2VGFEsQrqtlXtw91NIGFPyll7uxKGw+tUF4lDcyxq0eHEH3v7mSLmk3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07932871-ccbd-49e8-806d-08df1384425a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 23:51:28.1237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydQtljTvYyHnouxmefB72e6NfeUzK6rMeEO9vBRLoSYQEtLJixrUSd6OSJSepIbePgCKZgpN/ITrd08aztwLqc928SqgaXf3nBJPkO5LxIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

On 9/14/2026 1:00 AM, Jiawen Wu wrote:
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd..940ba2c6150f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1677,19 +1682,34 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>  		wx->atr(tx_ring, first, ptype);
>  
>  	if (wx_tx_map(tx_ring, first, hdr_len))
> -		goto cleanup_tx_tstamp;
> +		goto out_drop;
>  
>  	return NETDEV_TX_OK;
>  out_drop:
> -	dev_kfree_skb_any(first->skb);
> -	first->skb = NULL;
> -cleanup_tx_tstamp:
> +	/* The hardware will never report a timestamp for a frame it did not
> +	 * transmit, so drop the request. Only do so if it is still ours: the
> +	 * PTP worker may already have completed it and a concurrent transmit
> +	 * may have submitted a new one.
> +	 */

Could you explain this a bit more? The hardware doesn't report a
timestamp if the frame didn't transmit.. but you say here the PTP worker
may have already cleaned this up? How goes that work here? I guess
clean_tx_tstamp label may execute even if the timestamp has actually
happened and already completed? I'm not quite following this logic.

>  	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
> -		dev_kfree_skb_any(wx->ptp_tx_skb);
> -		wx->ptp_tx_skb = NULL;
> -		wx->tx_hwtstamp_errors++;
> -		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +		struct sk_buff *ptp_tx_skb = NULL;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&wx->ptp_tx_lock, flags);
> +		if (wx->ptp_tx_skb == skb) {
> +			ptp_tx_skb = wx->ptp_tx_skb;
> +			wx->ptp_tx_skb = NULL;
> +			clear_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
> +		}
> +		spin_unlock_irqrestore(&wx->ptp_tx_lock, flags);
> +
> +		if (ptp_tx_skb) {
> +			dev_kfree_skb_any(ptp_tx_skb);
> +			wx->tx_hwtstamp_errors++;
> +		}
>  	}
> +	dev_kfree_skb_any(first->skb);
> +	first->skb = NULL;
>  
>  	return NETDEV_TX_OK;
>  }
