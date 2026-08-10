Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239C30E0EE;
	Mon, 10 Aug 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369811; cv=fail; b=NE4u/3t4XlTGPoIJ5Wr9KSk2RuSvbupshB0F51bgntyE4H04hUAIoOvVn401+V8iySqwVlN4FrM3aLI4UaYmhhhHopXwLkm7Mct5eCwyw3ZZjsXs1jU67R7PxieHbvHvylJ2c5MALzjQ8tZvXIN+MK6XQNEDKwR11Rt++6qe+qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369811; c=relaxed/simple;
	bh=SrK+CZrQzM/Liib5Ux8ygrz8FZtertCS0/zRC/7Sk/o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=glPXh3YK51e/eKpLNI8A64Klb9vG7/kRYTHgP1VzoZWCS/vLMwJqX7clHDvcuP8ziBqOkvTMXoKh0G8Al7kD8DYDJjyd2vMaAsuYoIHt6327tiayUp7BAYP5aFdmPTsyk16uBBqn7ERCUdC/oED4/XhmdP9Z4uqDh7PjNJXSljo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+TRaQeH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+TRaQeH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786369809; x=1817905809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SrK+CZrQzM/Liib5Ux8ygrz8FZtertCS0/zRC/7Sk/o=;
  b=G+TRaQeHMSlRX0T1c4CjhyFC6ce85B9QgpYPQwg9Aeo2+nKyIWUhNrwD
   9IQvFROnAiGkYUbSIo9K/VlQRfSBiEdEcHsbyqGRA2unE2dvmNbjoQXxN
   EcAoXH7AO5zVDAJGvFOdtiz1KL1/Crn3HbsFw3kfA+P1UVpzRcZvOafaQ
   ZLadarUPvmk7LGwaj6B+o8YJR1qMI4BMvrFaDM02KmAapD0fIgFkclbFN
   pOsPU9VmfaJo12NbYwhRPqn+PSDmh21VLBYJqX5EuKAV+htL3KwmDOV2q
   QhHDbtnCnpHt8mkqWlGV+15ItpXv6Ypk6dRO3fzQ0mDp+UMbq62yvWirD
   w==;
X-CSE-ConnectionGUID: 8fyBwj+5S6e1DlP26KNmjg==
X-CSE-MsgGUID: C6ADJyqQRPqEZUAqseRfNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85850832"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85850832"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 06:50:09 -0700
X-CSE-ConnectionGUID: MV3vhA7XRmybRiVy+tn7jQ==
X-CSE-MsgGUID: lG2wl086RRyv9Mgx54f6kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266537889"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 06:50:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 06:50:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 06:50:07 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 06:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yee2kq8PnT8Qji0LF2WFacxQXVvSIXtHK883YihF+OZBEVEUi/535zBBGWgiQNltaMosH/6+82ooGNErBk/4fdAEHG795kwuUz+Si0eln54V40FumF5BiNWoRIlb7NxzVve2WbBLRrOzl4Y2+0uAspIOdPXSxSkD3YPr4btokJGkSLQcBjTJDIaBTvxIwMmYfy3Ym4e0Uqk9Npq3MRzy/IKv7F7hMNuCF43t1plttwo2MNOdSxPrDPkq7YwrO5OVmibnqoQa7ypcd1Si7rAasgTwGc1M2b6/EbW2MDhCMmwMWY0WVhHpBeoCB2sySO0aDLq7weOi2UcO+FrGB09lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvjoNuKTMjuF6VD192qbtuoOFxOHkQfmSWemnkKA8nE=;
 b=BJC/xLitFpA4giXMLOvHmSu+WhIOfiYKttoVLSTPRClPqBugrJVq0vFVm1eAsXQQtRl7EYO6QVojnRpaU6XtBjYuLvzW7WsszwZEjR7lLk/wC4eWLoGUSna5e77g92+F2kyJ+5QA1wn2R1049cYULrfg/USbXXAi0uGbF5wDHquLLZqxCes57LQAd3uQqEhqCv7B/RqR8CPVlryrQneBgAKuvX3UvOdgi03/g3tqzq1QAAuzxBejcD4ZzhIL3jE6lFcXOvVH/IH0vhOJKcsEnD9mkZlrJkJuLUKrvuyw9WSmZMQCneqa7S5jmQXYYmyVVT+glQ0zOaFe1qq3JfUHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:50:03 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:50:03 +0000
Message-ID: <8f6d577a-659a-4cea-ac0e-554cdd36c076@intel.com>
Date: Mon, 10 Aug 2026 15:52:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] devlink: prevent function configuration when
 port is active
To: Tariq Toukan <tariqt@nvidia.com>, Oren Sidi <osidi@nvidia.com>
CC: Aya Levin <ayal@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260810103245.3162004-1-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260810103245.3162004-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::14) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bea9ed5-ebfd-4223-5a8c-08def6e6472d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|6133799003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: Ovjb0JgjGkAh/8+ahZN1b59/Ihkg8dwrICsTKRWpvyTtEUpf1VgOTZ4KkvTa5/jsBTW+v7liRIsyrI6mkZk4vM/X3paG2NN9f0JYFHtEoy6wRU38bwsCDoWM+G61fXMIqOJ7yTu4UMVduykj6ZnSA/TuzS/alqyZD2nTRasq424yswCWmN8EE9C4fGoWAynGiPyuCKF+mVv9fpxJ+rUuNHwUDW6PBAgrofMQctiR0GMdeh8NYBqnH2awV9vUx9wdf7QgllFlmCcicf1JWH4vSh10niHIXMflmqQmqYXxNnYCq4BLrd49Aq+AvUjBbK1/jDxB8X+MLBNsSh7PRqr5y5hA7gz/FRORn8SKvg1DQdvnuhH09wRIjHyHRvZDuWZhoBgrm//gjLURrSvanhLRieourywm/ozn0Bt2nQlHWok/dSco4bOEgYeQiq6wNqrSkJOb0xilinDOMrEg0v1DcVmqrR2tVjTkPY/1EJgAKdgU6Qbc3dIR2tqP0dbYgTiCMT6YIVSKvmZLcBUz//rrOFOHIeUU1Mn/CF230lN87zisq5zyyRMu/QV4e+zar1YblrcCptqe2hlhNsC38OFJvXX31dkZtsm19/XpdpcYYMiJ7lAVEnM6oAs1HGjp4nGrLP2aNR0ysXAHR1Fc6VY312FuAicRncxuZ1C5GjxubwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3FtM2g1RGlmK0NGRkhpMGRQR2VrNGZXT3E2T1ZxMEpBbkpwMitNVUpUZVBq?=
 =?utf-8?B?ekJ2bzBKV1lDaHBLckl2RUV3aVI3am5JcW1yMHFzYys0OURFTmY0T2Q3dnpK?=
 =?utf-8?B?Q3BORm1icVdmNUdwaXlNQkludkI4Nlo3QUdmOEZlTVBBaEthUXVQLzEzQzNP?=
 =?utf-8?B?QXV1ZlNUa1JFNTNuZFdkU29aRHBtTmxhdm4vWE9JUjl3MlA5aXIrMEYzVFFV?=
 =?utf-8?B?VExxVzBZVjJJb0xNS3YyTE1kb2IzRG9CejQxcjJ5L0tGUFFNVDhrZlB6MjNs?=
 =?utf-8?B?ZjcwbEdlNU8xT3Q3YTFDSUFxcVQ1bkM0eUFxN0lpaXMxUm9SRGh3MmRVOVd1?=
 =?utf-8?B?MWozVTJvTXNmS1BZa1UyVDBEaHkxZ0ROM0tpM1NSMzRnOUJwZHU2V1B2ZHBL?=
 =?utf-8?B?d1RWMmE0NXV3VzEyV1BqQXBESGVuelZ5VHJySXVnSHBoRy9za3g3bWJLRkVB?=
 =?utf-8?B?bFJpL0l4V3lGYzgzeE9BSmx6N0EyS2poanZmYkhBd0pWRFNyZ2V0VENlcngr?=
 =?utf-8?B?MmJDUmwyU3YyY29NTFpSbXBrL3l1SEljTWp4QUZNd1FodW5tMXVrQmF1dGNn?=
 =?utf-8?B?SGRES1lpVUx5eVhpSm5NdEJGU0M2WEV1VUNVRUszbjlRYXdDS2JyeWNSTXNG?=
 =?utf-8?B?VEZxNTVEMXZHMVVpbWx1aXllRkgyQmZPaElCZ3p3SzV4Y3JCK0FraktDVFBw?=
 =?utf-8?B?cUl0NFhWdlI0MElxdTgrSDIwOTFWaXNrbTg2ZDJ2Q1pTY0FnbnhwK0tIdVhO?=
 =?utf-8?B?eG9ZOGFWUHptbVgvWFZxeEF3M0NITG1BcUY5U1hCenJyMWkrOGJuUTJNdk5q?=
 =?utf-8?B?MlA1RktQNVlFM1FQeFBaRnR5c0d6MTAxSjJrcWkzMzUyMnNUMjlvZWFxRnZj?=
 =?utf-8?B?MmNDVGtsWWdqZWNnT3NSTmdmWjM2dmhGS21qdzhKcjU1T0ZBcUcxUlNuNUNv?=
 =?utf-8?B?QXpPQnhqWEFIV0MxcDY3SWs2R2dTZWZLcmFzVzBSRFpUMmllYzJ1YmM0M1pI?=
 =?utf-8?B?NXlPTHJEenU4a3IxaUJtYzlkWTFYRGJMWU9zYTFKWG9kUE1ja25BUUUyQU0r?=
 =?utf-8?B?aHVTb1hBVHdiRGQ2MDZlQXF4Vm1Jckh1RE9DUVNDMTFwV1hKdzlwb2tDdUVF?=
 =?utf-8?B?bmx5NVp6Uysxd2lQRkduU0R3bWNYUlFBWTEvU2dCOEh5WnFIRFdtdmM2bTF3?=
 =?utf-8?B?YUtNbTYycGZNdlp6TzNJSkpLT08xV2ZMcjZkQjhYc01lWnBnRWVBSnpSMUgy?=
 =?utf-8?B?ZXRPZFhSS29jYUlrSmJhT1B2bzlzei83RDBGbjR4ZHBFWU1McGpFQWIwU1VI?=
 =?utf-8?B?bG9JWFh0dktLR3BEN2plZzU3V2FWaFJQLzVTVDBOWlZOZ1RoTjdPNmV5WVhr?=
 =?utf-8?B?OU14QmhmcTFhVmlvdkE1REczOEtRbkpUcmhMdkRzM2lKSUIvbW5YNFBvdU9D?=
 =?utf-8?B?SENlTmI2RElIUDlIRXZTMHd2c3hxMTFIbDRBckRaanI1SkxIejYxdVNkY0hC?=
 =?utf-8?B?Rkl0UmVtM1c1MHNqTDhJdnhHK2Myb2lRd09iWS9YRDEzT3hPR01UQXhjNjQ2?=
 =?utf-8?B?eXlaM0RNdkpacTdXeXg2a3V5dkl2U2NwN3NhZ2pNMStVTHZqVHZTdUl3UjFY?=
 =?utf-8?B?SW9pblBNZ2E5L2FucTdackxnQ3dVbVBxcHVWMVZaSkVlZ1dicGZobGNYV0dy?=
 =?utf-8?B?d1dYUisyN3BvbHpCQlYwTXRnZkxVTHN4R0lBYlFJK2JUaFVQVDdMRXNhNVB4?=
 =?utf-8?B?Z0krUTZiQ0RtLy80a1ErdW5VUEdiZFJYSkYwdEY5MFQwSlJPK21iY0pvSE5N?=
 =?utf-8?B?VkVxcjcvU21oOWFaNzB4dlBkWGpnZHFLY1NJcnRyVnZiNWVheitIVmR6QTZB?=
 =?utf-8?B?bzBaZk9TQTl6MzE0M2FTRmZPcWRHaSt5MVFHM0VKWmp6RTl1OE1HeTYrYms3?=
 =?utf-8?B?S2F4ZTVUR1g5RWMwUVBJTVFtTXhoWDV6WUVnOHU4Y2dWQWcxODZWQkZoNGZy?=
 =?utf-8?B?SEpUMkZ3UjhoOG92NFVWQTk1cGppVVR4cC9KQTFHQjdEMFBFQXZFNnk1Qjh1?=
 =?utf-8?B?SS9CQjRra1BxQlJMMmwwY1JSdkZGRER1VTVPQjBTTGVPQ1NmQk5zb3ZsSnJ6?=
 =?utf-8?B?ZTRmUkNyZjIvaUNHdk90UW50c3NWSHAvb3NMRUNHNnpIMWRFSmtOWWlZcS83?=
 =?utf-8?B?WWFwZHFxVStNbEUzaFNlL240UkxuU0pWanpMQ3BHcnBaSnVxNFczQkRja3NJ?=
 =?utf-8?B?cHNMWkkzWmprR2tCQlVLR0sxVzZHU1RsSURzVjFvMDRNcW16VGdPbmFtc1Bv?=
 =?utf-8?B?aE1qdVZhT01CMFRtY1dBVTMyNHA5M3dIaDBoVFpYT2hTc1krZjczQmtMREJZ?=
 =?utf-8?Q?K7SzSD67uz8Hv20U=3D?=
X-Exchange-RoutingPolicyChecked: hrme4EkWhunsTz0uK9M5YoWx9Fn9O0wjS4CUqIy1jxVgxO0idoALkQyJSX0Xs1JSBXfxV4W6H95a6kCQgagd/ceIZFhc5goZaatzZ1ncsE8gFfDPBtlj1pfz0saipie+ubw15DyBVJcT/+H+bFRiRY2vpt5vKYyIuVEwPPeeTJR8mpVH76PpzJfuTWnIMgvWadBDqjBm4hUyQ21lZ0raHLIAA+g0Nra8mx7TW7hu5yQ4MNYT1wCygqqIMSW5HRAgpVvd7A5a6mnutoRYop8rR7s5CmfjH09+u88CBsRfeJ4UfxN/7ppLUMJAvU/40+5VPwLdzrLS0P+nIxZJw+D1ZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bea9ed5-ebfd-4223-5a8c-08def6e6472d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:50:03.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Kx9yUmJ9JFYi6hi48loEt0luhk4q8UexkLO69aKyt1KI1tO5P78hI+PvvrVmhCYxqqjgo0o9wbCN/eSHIcAZ+EH8c5Y9S4tHGzeoLeC4CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

On 8/10/26 12:32, Tariq Toukan wrote:
> From: Oren Sidi <osidi@nvidia.com>
> 
> Reject port function parameter changes when the port is active.
> Enforcing this insures configuration integrity and consistency.
> 
> Signed-off-by: Oren Sidi <osidi@nvidia.com>
> Reviewed-by: Aya Levin <ayal@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   net/devlink/port.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 1528f2d148df..6a9857bf79da 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -708,7 +708,10 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
>   					  struct netlink_ext_ack *extack)
>   {
>   	const struct devlink_port_ops *ops = devlink_port->ops;
> +	enum devlink_port_fn_opstate opstate;
> +	enum devlink_port_fn_state state;
>   	struct nlattr *attr;
> +	int err;
>   
>   	if (tb[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] &&
>   	    !ops->port_fn_hw_addr_set) {
> @@ -721,6 +724,20 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
>   				    "Function does not support state setting");
>   		return -EOPNOTSUPP;
>   	}
> +	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_SF &&

nit: this is the only place that marks the logic only for SUBFUNCTION,
would be good to amend commit message/subject line:
s/function/subfunction/ # for the subject

with or without the above:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> +	    ops->port_fn_state_get && !tb[DEVLINK_PORT_FN_ATTR_STATE]) {
> +		err = ops->port_fn_state_get(devlink_port, &state,
> +					     &opstate, extack);
> +		if (err)
> +			return err;
> +
> +		if (state == DEVLINK_PORT_FN_STATE_ACTIVE) {
> +			NL_SET_ERR_MSG(extack,
> +				       "port function parameters can't be configured when port is up");
> +			return -EINVAL;
> +		}
> +	}
> +
>   	attr = tb[DEVLINK_PORT_FN_ATTR_CAPS];
>   	if (attr) {
>   		struct nla_bitfield32 caps;
> 
> base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe

