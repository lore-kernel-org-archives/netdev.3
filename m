Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705274F4CEF
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661641; cv=fail; b=ETrMLwgGWlvjiylTFEXkqPGxFlO+QvOsUdQSS1o5ntf1TmFA1e3fg3W/JBlcuB6oRWTTK8kf4MybwKYOiLDyClOILeisGl01rVPi85zbKHWcYG9/y0LNnso0FyKiry41y3AeCmpOxoJFZe+d4PzOXivGBw9R0suqjxtwGtOGilE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661641; c=relaxed/simple;
	bh=GrKOhBLU9BmxFgkHz/9Y7wOHpJQRV184UrB/a0yjrSw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9fK+Aazd3ZkmmrVX/DRo2Qk2bBnw0+GPCVeH05KDl469gRlbUSJXAXN1GuB4wEdm1NM8NtKeBDQUSs+RKKAJ5dsiAB8yaLsYQLnEbi4Grc5n+2m7awhR99aUnPRJv0+ePeSB5Ohm6Wqw6qNLIU5dz6HcZL3u+RyjODYad71cas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6pO1Hfs; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6pO1Hfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789661638; x=1821197638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GrKOhBLU9BmxFgkHz/9Y7wOHpJQRV184UrB/a0yjrSw=;
  b=a6pO1HfsKCktmmk7VHcTx1R5mUTepdoUV6j/sGOHCZ4xMtiGOXHLOz4s
   VkMOP1hsxiJ8Mde7pIHlkN+Q8y0Wa62ySO3is1sXb/7t0H4aaj+7AARbH
   7FwzpLSRBV3w/P/Z3huG2WgfxidH65kxtYyM39FKi8qQVSLS6dsugMneE
   VGC8fNaN2ZQ04MwXgdWhL4X7WoxCWXDjKF4eQ8ksjxCfnlBvwB475SY/z
   FDKH409uLEddtHdX6Y0UGXfFTYynkDKVMFVkiTbA03Y+3tMOr1BW24D0V
   liCNzBpLjWtgnwbNnc5U3DahlMsumiob1WEKJd3fjof/MABLNzZMQ8vNO
   Q==;
X-CSE-ConnectionGUID: l5Emqg2nTTWyvkk5voKoEw==
X-CSE-MsgGUID: oWG0MTAUR0aeHvE+rl7fEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="610622"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="610622"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:13:57 -0700
X-CSE-ConnectionGUID: udVvj1IHRnKgFEKsuUxp0w==
X-CSE-MsgGUID: vyZvk+YrSnKvZMSS5CurBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2085643"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:13:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:13:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:13:54 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR9MT4Jlh0M/4GwinroeVbw0ALvafkWmotm4b6Z9eZdQArp1bTaEe6UeENSqCn3BsOl96A4rceu+Saj3dd6h9diamHRlBbs8GcZdQy0CRJRcoHZG6uApKH+pDULrJYTmHNftUGJgLxElo/XqxNPRiO2go3fO7dJAM5YP4+7xvYUe7CHQB3/x8nAhIcp4uyfqiTFhS1KzRLr13sq6fu16LbVOQA1EHHvoGRWAzG4ky8i7+GRTlxgB7uRUYzdYhr4eyRr1Xmie8S4RF7iTlL0gXeUjszFkN18oQ2PTUxkm9JlsKmJyTaZiXS0ruSd+uO82NOkcGJ/zILcd+uzWKMrW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDUzzdUgHWhZjgDWE9lDumm5z9lP1rfww/uPJ2HhXx4=;
 b=IHdfbKoVkyZqGYmZ+2+DYcJXiZcnPPZRUjlvqRKKTKn4c4AZ7PIZS0WyBEeMqJxOXvV5dmzqCAOMmRMk7mRHdgBZW1oQrRfT8TfwQcdksyLKpW1Ob3E7YDUhGo52pMtXjo8SNc46SZ9rbRFpDYc4FsD6PI8bdt9xsOdNaU/i/oF6k9tQIPfGY/7x04Y5Al2xdM2JNGntyxXOY2+WZxB/6ygDhjEk1++FXC5Sn6TDT0la+HKoDd70nkND8UpXevO8RR1qVuJ/7LM2FHAHyeMZS11FR62NAcj+C9VXCNwpLG7p4jPpDZqrUl9d97GV5xPooJxT/B3HxI4a6ZK8HLT6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB6882.namprd11.prod.outlook.com (2603:10b6:510:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:13:42 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:13:41 +0000
Message-ID: <5fbaadd4-9da0-4075-9fcd-476ec054e6f1@intel.com>
Date: Thu, 17 Sep 2026 09:13:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 01/15] ice: use reference counting and RCU for PTP
 port access
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-2-anthony.l.nguyen@intel.com>
 <20260916011211.1632220-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011211.1632220-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:303:b6::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH7PR11MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ecf47d-9796-4f2b-d6f2-08df14d6a3a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|56012099006|18002099003|6133799003|22082099003|4143699003|11063799006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: QXnNgPddaTWjwJnmOap+guOuH69DGVBNLCqyJdKlnn29RLnbCLyTI/5kyCu0sGDShj0ixENED2gYqhOMbILn/IAGCmgB07S+eeQ1AsnHY2nj+GGLSkKOa3fePxaAV5TqkWUZzizCN96A4LGVOAXVEwrtL+uiJK91bhuTEj4G2AifuNk8aIlUUFyfYnc21Y3v+DHjjET7We1jC+vKXlFAGZ5Y6Xp0VAaEHm2VATbF7L8tkxVi6TRQIXqLZ2Rxa6jgzCa4jCXD59n+jTC8Tuu9ymQ5ZEJ+7bedZ+FZTbovqC/WvVDAtman0Wbbfib4vQlIvja7hqgdnhBg5pf9a0d2x33cahY0p/Q/jxz8xMlYm6f8bwU8CeW5Agz7UXkiwlAp33WxU3Z3mznxKkRs1VA6AnbvtzZP+wKlWTBz+8r/ruLvjo8OuCAtt+UpuEwKrCsbOky1Z86kayHYHsD88TXWAQmkFYvu4D9efidbPRtjvnI0VxrMXTGuu7Ndoq5oyXwdJTb5wkmtSBW46c7lCyy3BVD/XJxCrzdhxCk5V44Py4zA+QUnhDUKAO9s/f5mxHJAfMamVDn1Tv62bCWMqNE3qRZ/7oXIKlhezfKR2FLglFM0s5fIMZhGn71lRrheWTKcwQM8xXXWl5zGh+rzXd0ktdckr+PMtJqIkS1lvMRkZFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(18002099003)(6133799003)(22082099003)(4143699003)(11063799006)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZobC9DemRUVWxIRzgvdlNkSVFDUHM5K3B1bHRIZ1JwNEVjMmFLMzVEZ3c1?=
 =?utf-8?B?QkxwZjlIc09pODB5WXBxODkrYWJpclg4Sm4vYTdUUVNyT2VkYmdOS2ZsREVu?=
 =?utf-8?B?WW5iMmpKbDlpTldIYUJrUmgxNDNHa2RjdjdSaHJjNXpUL3Q2bHFaWGNrZ29R?=
 =?utf-8?B?V3Bjc05GNzB4SVpqNEJHOFJKMGRBOHdNYUhnSFFrWWs1T0cvb1hKcmFxeWln?=
 =?utf-8?B?QS9GTUREajBGNUJ2Y3Y4aU9IQmU5L0hmRXVKR2kvS0hPMDFLRnZENWZVbFVl?=
 =?utf-8?B?czN4em5yTW1lbWVnR2JkVytmdkpoeFYzdFJNWGlOZVAwQy8yMDYzb2RuaXBl?=
 =?utf-8?B?MkpOWFJHdU5WTmxhWDQzMzBic1ZHbEkvQmlNNUpRV3N2b1NkMDNlRmdmSkcz?=
 =?utf-8?B?VGc4YTdNK01Pd0JTR3kwbFFWL0M0Q0MwS1NHSTB2L3AvWXgvYzdURWN5ZTBo?=
 =?utf-8?B?czQxc2hyMnBIWlo5WlQxNnJRelFkWUs2VzlKcjM3NExhelJmT2R6Qng2QWp5?=
 =?utf-8?B?OVRNT0VuUTVrcFA5dmgwRXlLWG1jNkRmWkdMWExZU2wzYmw1MDJRR245aEVG?=
 =?utf-8?B?YW5UNjNvM2JmUWpvbGtSWWZHbDZKZDQvTHZ3L0pIMWJ3TnJINEFSV0xBaGxk?=
 =?utf-8?B?VFJGNjVTenJWaUh6TXR0Z0hPTXYvVFJkZjM5SGJxRlI2Y1JaQVlmbHltZVNZ?=
 =?utf-8?B?cVdjcnRFNjF0bmphS3FKVlZoT1lkMG9YNzVEMllFVXBVTTZZTlFLL05CeWZj?=
 =?utf-8?B?VkxFVlBvZ0NHYW5sZkNZTk5aU3l0WVRHOEJvcjF5NlZuVnQ2L1A1OXVkQVpC?=
 =?utf-8?B?WlhvL3cyUEc5clNjTkw3WGJ4SS80ZnNRcU9XbWJZcFZTaTJNQlRuRWZPM0w3?=
 =?utf-8?B?OE1NS2RsWUlwRVQ4RGROZjBlVE1ja2dxUjI4T0lwT3lpWUorVTgwbFpZYjhR?=
 =?utf-8?B?SmZmZUkzKzVJaFZ3eEZEejVDZ1YyWTV1OUFsRnBkYlJmODNHUktOZjBvZnBT?=
 =?utf-8?B?bFVXMGMyNExNYkFTQ0xweUhNb2wyQXRCVHZMdTVtaUUwYS9UREdjandnQ2Vj?=
 =?utf-8?B?Qjl2M2sxN01pUTNnT0dLOWdZakovbGFDZGZWZ215eUhCYlhMKzJaZmFxZWJo?=
 =?utf-8?B?REtsWkgyR0tKU3hLdW5XdHROSUpET1ova1EvZVNsTWpwSWZONEZkbnB2Ritz?=
 =?utf-8?B?S044SmdoRXl6TzNlSWVuN2c2NDlRTzlIVkh3Rmx0WGdoeC9WU3F2czR0S3NJ?=
 =?utf-8?B?SkxQQUtYNitlUXROMWxSWDhtcHhqMmx6aVdwLzk3Z3pqMUlNNTdQZ0xlQ3Vm?=
 =?utf-8?B?eGJ3S1U2Mk1WRm9nb1dDMWFuY3pSZndCemhCOWM0L24wWlBDdHc1YmtUdW14?=
 =?utf-8?B?RHFZSzB0UVV2aG5ONCtZY0xNeGxmRFpGaUVKdy8zTkpuL2hTTDc3elUyRURZ?=
 =?utf-8?B?Z3lORjFjS1VvdExXbDhUUlh6SmpNT0IzNkJLSUV5bzJLeDRTcjUrZkxRSUJN?=
 =?utf-8?B?UE4zdE54dFR1NFNCZlFnZWovamtwSHcyMUtqT1ZTSHdHVHBJOWo4MXNOVjdh?=
 =?utf-8?B?MVdpSUtqWlBUVkxhbFJ2QmxReHVIcnMybnBCV1Eydzlzc2ZWbjRIU2o1Y3k2?=
 =?utf-8?B?NGMvbWdIOUIzWi9NMFBIUHlKSEJTMklyWFJOSFpTVU1yVzVCTWR5TEIrRFYx?=
 =?utf-8?B?MWJmUWVROU53ai8zVUt4bUwzbFpyQ0EzWmdUczlxcVQ2MFQxUy9HeldpVHp2?=
 =?utf-8?B?UTdWSkVlU2RtbDkybzhXc2dlcnkvOUl1YkRKOUxmVm5ySlhvVnhROFJmNUNX?=
 =?utf-8?B?V0V4TVZsazcrbk43bkJoWVJUY29yeTdXK3pTeDlObWZMb1piRTEwUlNML29C?=
 =?utf-8?B?WkRDU1pDZUdkcjU5clJROGtDd25Ud1ZteTErMWhXRXRpbEdIQk9XaWZVZElS?=
 =?utf-8?B?OUszbW0vT0ZhUTlnU0kxbmY3SXBZWjRJZHkvNHdLVDZucnhKZmVUL2FVK1dW?=
 =?utf-8?B?anJVNlRCSFR6T0lGUkxyZ2x3ZjA2aVEzeTNWS0N4UE0vVEp4V1d1VDVBQ3BZ?=
 =?utf-8?B?MnVQZXpNWWlBL21JaWc5c040MTZUMFF3eUVpdEtYRWNXV0hkTjdTdEZXS0R6?=
 =?utf-8?B?RjZoeEprSzJpam5YcjZQZjEzM0hZV3N4OVR2cWtWeHRMM1NSWXZib0JBVTFy?=
 =?utf-8?B?SmNCekJGdmxXTUdkdUlQWHhWL2dLYUQxNVpMcXh1NWVrcHpLNkJrVkVoUDRl?=
 =?utf-8?B?OTltQXdKOGNzSE56aW5IR2dzMFNCa0R3TFNFanloRVljRDR1NjFXMm5IckFr?=
 =?utf-8?B?NGtPYnBLWGU0WGNxU1lzaCtHWFVLc0tEVVhRQk5OZHpFdEtSNDFkTGlaRWxF?=
 =?utf-8?Q?MtDjGszPixYa6Oh4=3D?=
X-Exchange-RoutingPolicyChecked: zd0l8U0VBrXDVivcxGOSDzGd4qayQV6f3J8SQmK0EPIhMwp94dwZOi/VlJ1yR5i/M8+89JOL7EMFAkN7cQvXThoaNjmGw4RuVEs+JIBLGY0NbXuYmdW9oV6T7/lcV1VGXjT6Ja/u4msTIBGMLDAjzgKSlhzoSRVVXqPzzSl6NQtie7X+xjPxBYdPK0l9otgQy7lh1xYbYImo+vJH8rJxUM28zIukKj3O2uPbW20Appn3xaeNERKwlkhyVgipvRjE4OVdyOS+ijhNH+vUCh0xsscHnyKqc/FxZUeppq3ikAF0ZA72jygMZjsQvpaE1xI+PqXQ8p5if2xNOjwNyMl3TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ecf47d-9796-4f2b-d6f2-08df14d6a3a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:13:41.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mTANt2vY8ibdh0/ZzlDOYliqsZtnaGNSW9to2gcOvS8oFVU1/xp323Zsa0fAoLU2515xqi63q6P3RwRvjK0katpvf2BWSE6G8I+r8cViwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6882
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: use reference counting and RCU for PTP port access
> 
> The adapter-wide PTP port list is converted from a mutex-protected list to
> an RCU list plus a kref on each struct ice_ptp_port. Iterators either stay
> inside a single RCU read section, or take a reference and drop RCU across
> the per-port work. PF teardown unlinks the port, drops the primary
> reference, waits (with a 15 second timeout) for the remaining references,
> and then calls synchronize_rcu().
> 
> A couple of questions below about the new iteration pattern and about a
> few lifetime claims in the commit message.
> 
>> The kref reference counter ensures that we can
>> safely acquire pointers with a guarantee of their lifetime, ensuring the
>> associated PF will not be removed until the reference is released.
> 
> [Severity: High]
> 
> This isn't a bug introduced by this patch, but does that sentence read
> wider than the change actually is?  The new kref covers the port list
> only; the other cross-PF pointer on the adapter is still unprotected:
> > drivers/net/ethernet/intel/ice/ice_ptp.c:
> static void ice_ptp_setup_adapter(struct ice_pf *pf)
> {
> 	pf->adapter->ctrl_pf = pf;
> }
> 
> drivers/net/ethernet/intel/ice/ice.h:
> static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
> {
> 	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
> }
> 
> grep over drivers/net/ethernet/intel/ice/ finds exactly one assignment of
> ctrl_pf and no site that ever clears it.
> 
> If the clock owner PF is unbound while a sibling PF of the same adapter
> stays bound, the ice_adapter survives on the sibling's refcount, but
> ctrl_pf still points at the freed struct ice_pf.  Can a later tx-clk
> change then dereference it?
> 
> drivers/net/ethernet/intel/ice/ice_txclk.c:ice_txclk_set_clk()
> 	mutex_lock(&ctrl_pf->dplls.lock);
> 	clk_in_use = ice_txclk_any_port_uses(ctrl_pf, phy, clk);
> 
> The IS_ERR_OR_NULL(ctrl_pf) checks in that file cannot detect a stale
> non-NULL pointer.  Would it be worth stating in the commit message that
> the new reference counting is scoped to the port list, so that ctrl_pf
> isn't assumed to be covered?
> 

Yes, I'll update it. We have another developer working on fixing ctrl_pf.

>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> index 4f695f32da3d8..39923dedd534e 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -19,13 +19,13 @@ struct ice_pf;
>>   *
>>   * This structure contains data used to maintain a list of adapter ports
>>   *
>> - * @ports: list of ports
>> + * @list: list of ports
>>   * @lock: protect access to the ports list
>>   */
>>  struct ice_port_list {
>> -	struct list_head ports;
>> +	struct list_head list;
>>  	/* To synchronize the ports list operations */
>> -	struct mutex lock;
>> +	spinlock_t lock;
>>  };
> 
> [Severity: Low]
> 
> This isn't a bug, but should the kernel-doc be updated along with the
> locking model?  After this patch, ports.lock is taken only around
> list_add_rcu() in ice_ptp_setup_pf() and list_del_rcu() in
> ice_ptp_cleanup_pf(); all five traversal sites in ice_ptp.c use
> rcu_read_lock() plus list_for_each_entry_rcu() and never take the lock.
> 
> The comments still say "@lock: protect access to the ports list" and "To
> synchronize the ports list operations", which reads as if holding the lock
> were required (or sufficient) for iteration.  Would it help to note that
> the list is RCU-protected for readers, and that readers which leave the
> RCU section must hold a port reference?
> 

Yep, I'll update this.

>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index eaec36ab6ae3f..b12181b8c8434 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -673,20 +675,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  	pf->ptp.tx_hwtstamp_good += tstamp_good;
>>  }
>>  
>> +static void ice_ptp_release_port_rcu(struct kref *ref)
>> +{
>> +	wake_up_var(ref);
>> +}
>> +
>>  static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
>>  {
>>  	struct ice_ptp_port *port;
>>  
>> -	mutex_lock(&pf->adapter->ports.lock);
>> -	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>>  		struct ice_ptp_tx *tx = &port->tx;
>>  
>> -		if (!tx || !tx->init)
>> +		if (!tx->init)
>>  			continue;
>>  
>> +		if (!kref_get_unless_zero(&port->ref))
>> +			continue;
>> +
>> +		rcu_read_unlock();
>> +
>>  		ice_ptp_process_tx_tstamp(tx);
>> +
>> +		rcu_read_lock();
>> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
>>  	}
>> -	mutex_unlock(&pf->adapter->ports.lock);
>> +	rcu_read_unlock();
>>  }
> 
> [Severity: High]
> 
> Is the loop advance still safe here?  The kref is held on the current port
> only, and the for-loop advance reads port->list_node.next after the RCU
> read section has been reopened.  list_del_rcu() only updates the
> neighbours, so the removed entry's next pointer keeps pointing at its old
> successor, and ice_ptp_cleanup_pf() unlinks before it drains references:
> 
> 	spin_lock(&pf->adapter->ports.lock);
> 	list_del_rcu(&ptp->port.list_node);
> 	spin_unlock(&pf->adapter->ports.lock);
> 
> 	ref = &ptp->port.ref;
> 	kref_put(ref, ice_ptp_release_port_rcu);
> 
> Can this sequence happen with two functions of the same adapter, where
> port B follows port A in the list?
> 
> CPU0 (clock owner, ice_ptp_tx_tstamp_owner())
> 	kref_get_unless_zero(&portA->ref);
> 	rcu_read_unlock();
> 	ice_ptp_process_tx_tstamp(&portA->tx);   /* long PHY access */
> 
> CPU1 (unbind of the PF owning port B)
> 	ice_ptp_cleanup_pf()
> 	  list_del_rcu(&portB->list_node);
> 	  kref_put(&portB->ref, ...);            /* refcount reaches 0 */
> 	  wait_var_event_timeout(...)            /* returns immediately */
> 	  synchronize_rcu();                     /* CPU0 holds no RCU lock */
> 	... struct ice_pf of B (which embeds portB) is freed
> 
> CPU0
> 	rcu_read_lock();
> 	kref_put(&portA->ref, ice_ptp_release_port_rcu);
> 	/* loop advance: */
> 	pos = list_entry_rcu(portA->list_node.next, ...);  /* freed portB */
> 	if (!tx->init)                        /* read of freed memory */
> 	kref_get_unless_zero(&portB->ref)     /* cmpxchg on freed memory */
> 
> The same drop-RCU-inside-the-loop pattern appears in
> ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy() and
> ice_ptp_prepare_rebuild_sec() below, and the windows there are wide
> (ice_ptp_port_phy_restart() takes ps_lock and reprograms the PHY).
> 
> Note that ice_ptp_tx_tstamp_owner() previously held ports.lock across the
> entire iteration, so this particular hazard is new for that function.
> Would taking a reference on the next entry before dropping RCU, or keeping
> the whole iteration inside one RCU read section, close this?
> 

I'm switching to SRCU to allow holding the RCU critical section over the
entire sequences instead. We can't use regular rcu_read_lock() for that
because operations sleep.
>>  /**
>> @@ -808,8 +823,16 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
>>  {
>>  	struct ice_ptp_port *port;
>>  
>> -	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>> +		if (!kref_get_unless_zero(&port->ref))
>> +			continue;
>> +		rcu_read_unlock();
>>  		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
>> +		rcu_read_lock();
>> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
>> +	}
>> +	rcu_read_unlock();
>>  }
> 
> [Severity: Medium]
> 
> This is a pre-existing issue, not something this patch introduces, but
> does the new port reference also cover the Tx tracker allocations reached
> through the port?  At this commit a peer reset frees them while the port
> stays linked in the list:
> 
> ice_ptp_prepare_for_reset()
> 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> 

Thats actually a bug that is fixed in this series, as we modified the
reset flow to avoid needing to release the tracker but accidentally
forgot to remove this cleanup.

> ice_ptp_release_tx_tracker()
> 	synchronize_irq(pf->oicr_irq.virq);
> 	ice_ptp_flush_tx_tracker(pf, tx);
> 	kfree(tx->tstamps);
> 
> The synchronize_irq() is on the peer's own OICR vector, which does not
> exclude the clock owner's IRQ thread in ICE_PTP_TX_INTERRUPT_ALL mode, and
> the owner samples port->tx.init without tx->lock before calling
> ice_ptp_process_tx_tstamp() or ice_ptp_flush_tx_tracker() on that peer
> port.  Since the port is never unlinked in this path, the kref drain in
> ice_ptp_cleanup_pf() does not apply.
> 
> The triggering call is removed later in the series by "ice: fix removal of
> PTP timestamp tracker during reset", after which
> ice_ptp_release_tx_tracker() only runs from ice_ptp_release() once
> ice_ptp_cleanup_pf() has unlinked the port and drained references.
> 

Yep this is correct. We could re-order the series I suppose but I think
its ok as-is.

>>  /**
> 
> [ ... ]
> 
>> @@ -1424,16 +1453,21 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
>>   */
>>  static void ice_ptp_restart_all_phy(struct ice_pf *pf)
>>  {
>> -	struct list_head *entry;
>> +	struct ice_ptp_port *port;
>>  
>> -	list_for_each(entry, &pf->adapter->ports.ports) {
>> -		struct ice_ptp_port *port = list_entry(entry,
>> -						       struct ice_ptp_port,
>> -						       list_node);
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>> +		if (!kref_get_unless_zero(&port->ref))
>> +			continue;
>> +		rcu_read_unlock();
>>  
>>  		if (port->link_up)
>>  			ice_ptp_port_phy_restart(port);
>> +
>> +		rcu_read_lock();
>> +		kref_put(&port->ref, ice_ptp_release_port_rcu);
>>  	}
>> +	rcu_read_unlock();
>>  }
> 
> [ ... ]
> 
>> @@ -2890,14 +2924,16 @@ void ice_ptp_queue_work(struct ice_pf *pf)
>>  static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>>  					enum ice_reset_req reset_type)
>>  {
>> -	struct list_head *entry;
>> +	struct ice_ptp_port *port;
>>  
>> -	list_for_each(entry, &pf->adapter->ports.ports) {
>> -		struct ice_ptp_port *port = list_entry(entry,
>> -						       struct ice_ptp_port,
>> -						       list_node);
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
>>  		struct ice_pf *peer_pf = ptp_port_to_pf(port);
>>  
>> +		if (!kref_get_unless_zero(&port->ref))
>> +			continue;
>> +		rcu_read_unlock();
>> +
> 
> [ ... ]
> 
>> @@ -3086,11 +3126,11 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>>  		return -ENODEV;
>>  
>>  	INIT_LIST_HEAD(&ptp->port.list_node);
>> -	mutex_lock(&pf->adapter->ports.lock);
>> +	kref_init(&ptp->port.ref);
>>  
>> -	list_add(&ptp->port.list_node,
>> -		 &pf->adapter->ports.ports);
>> -	mutex_unlock(&pf->adapter->ports.lock);
>> +	spin_lock(&pf->adapter->ports.lock);
>> +	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
>> +	spin_unlock(&pf->adapter->ports.lock);
> 
> [Severity: Medium]
> 
> This isn't introduced by this patch, but is every successful
> ice_ptp_setup_pf() matched by an ice_ptp_cleanup_pf() at this commit?  In
> ice_ptp_init():
> 
> 	ptp->state = ICE_PTP_READY;
> 
> 	err = ice_ptp_init_work(pf, ptp);
> 	if (err)
> 		goto err_exit;
> 	...
> err_clean_pf:
> 	mutex_destroy(&ptp->port.ps_lock);
> 	ice_ptp_cleanup_pf(pf);
> err_exit:
> 	...
> 	ptp->state = ICE_PTP_UNINIT;
> 
> The err_exit path skips ice_ptp_cleanup_pf() and leaves the state at
> ICE_PTP_UNINIT, and ice_ptp_release() then does:
> 
> 	if (pf->ptp.state == ICE_PTP_UNINIT)
> 		return;
> 
> So if kthread_run_worker() in ice_ptp_init_work() fails, does the port stay
> linked on adapter->ports.list with its primary reference held, inside
> memory that is freed at PF removal?  That would also leave
> kref_get_unless_zero() succeeding on freed memory for every peer iterating
> the list, and should trip WARN_ON(!list_empty(&adapter->ports.list)) in
> ice_adapter_free().
> 
> This is fixed later in the series by "ice: call PTP link change only from
> link events", which moves ice_ptp_init_work() before the state assignment
> and sends its failure path to err_clean_pf.
> 
>>  
>>  	/* Seed the per-PHY Tx reference clock usage map for this port.
>>  	 * Only meaningful on E825 (other MAC types don't expose tx-clk
>> @@ -3113,12 +3153,32 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>>  static void ice_ptp_cleanup_pf(struct ice_pf *pf)
>>  {
>>  	struct ice_ptp *ptp = &pf->ptp;
>> +	struct kref *ref;
>>  
>> -	if (pf->hw.mac_type != ICE_MAC_UNKNOWN) {
>> -		mutex_lock(&pf->adapter->ports.lock);
>> -		list_del(&ptp->port.list_node);
>> -		mutex_unlock(&pf->adapter->ports.lock);
>> -	}
>> +	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
>> +		return;
>> +
>> +	/* The PF cannot be removed until there are no more remaining
>> +	 * outstanding references to the PTP port. To make sure this is true,
>> +	 * first remove the port from the list, then drop the primary
>> +	 * reference this PF holds on the port. Once done, wait until all
>> +	 * existing references are dropped. Finally, synchronize_rcu() to
>> +	 * ensure that all RCU critical sections that might attempt to
>> +	 * dereference the port are finished.
>> +	 */
> 
> [Severity: Low]
> 
> The commit message describes the 15 second timeout and the tradeoff it
> accepts, but this comment says the PF "cannot be removed until there are no
> more remaining outstanding references" and that the code will "wait until
> all existing references are dropped".  Should the comment mention the
> timeout, since teardown continues after the dev_WARN_ONCE() with a nonzero
> reference count?
> 

I can update the comment.

>> +
>> +	spin_lock(&pf->adapter->ports.lock);
>> +	list_del_rcu(&ptp->port.list_node);
>> +	spin_unlock(&pf->adapter->ports.lock);
>> +
>> +	ref = &ptp->port.ref;
>> +	kref_put(ref, ice_ptp_release_port_rcu);
>> +
>> +	dev_WARN_ONCE(ice_pf_to_dev(pf),
>> +		      !wait_var_event_timeout(ref, !kref_read(ref), 15 * HZ),
>> +		      "Timed out waiting for port references to release. Continuing to unload anyways.");
>> +
>> +	synchronize_rcu();
>>  }
> 
> [Severity: Low]
> 
> This is a pre-existing ordering issue, not something this patch changes,
> but now that ice_ptp_cleanup_pf() is the reference/RCU barrier, would it
> make sense to call it before destroying port members?  Both teardown paths
> currently do the opposite:
> 
> ice_ptp_init():
> err_clean_pf:
> 	mutex_destroy(&ptp->port.ps_lock);
> 	ice_ptp_cleanup_pf(pf);
> 
> ice_ptp_release():
> 	if (pf->ptp.state != ICE_PTP_READY) {
> 		mutex_destroy(&pf->ptp.port.ps_lock);
> 		ice_ptp_cleanup_pf(pf);
> 
> In that window the port is still published on adapter->ports.list with its
> primary reference held, so a peer in ice_ptp_restart_all_phy() or
> ice_ptp_prepare_rebuild_sec() can take a reference and reach
> mutex_lock(&ptp_port->ps_lock) on the destroyed mutex.  With
> CONFIG_DEBUG_MUTEXES that is a DEBUG_LOCKS_WARN_ON splat rather than
> corruption, since mutex_destroy() only clears lock->magic, but swapping the
> two calls would keep cleanup_pf() as the single teardown point.
> 
> [ ... ]

Yes that makes sense. Will fix.
