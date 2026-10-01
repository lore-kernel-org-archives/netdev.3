Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E93DDB0E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898461; cv=fail; b=stUCi5zLT1Eqd6TI8A+3wgUt63+kf+RL4nedaTQhGq9NU+4ZOsOC1YcGluzepFoQsa/ybZ2mpejTjvf4d/FTHdp7TUP1hTDqk4Ek6ylLPHOH/2Lm97QCBUAQMubeJtjmZCKiiW/5CaGMlF/hEkXqoG+swKRtsxUIYlluem2WbyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898461; c=relaxed/simple;
	bh=8fUQ+n6vM4eSLU9uti8uPQ51Q4jmGdVwqdvDVDHYW/w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdPhUXF+TbX4rv6r7fXnK9ZIzcHLaGgqidMTcIXPvogB3bvixbVjO2itmMCEU77X1LbdLT3TIhuYNw2lF20XfnyN9AS19Wa9F7gs/py56UJwE/JjacOF3uQmBOSz34yHtGH2ePKixu7uIEldAJgKF5XTot5fj+KwQIU+iRccMRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYyHHMRy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYyHHMRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790898458; x=1822434458;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8fUQ+n6vM4eSLU9uti8uPQ51Q4jmGdVwqdvDVDHYW/w=;
  b=mYyHHMRypm2pRiKFX0wUlSu9KecXKKOAsUChrHBXC8rcsPy9kxvZafyr
   3wJdv1CMZFu7HMWI90ReD00A6BfO8e5m4SWhx7/CGf8x7pAOtPagR0Vck
   yP+Zchx3JTROrX9BlbHLkR14+AiTSXctahSg/PM0QVk7Jc2oZ/s3gP4d7
   2dodbo21P4Bz3l3HfsyRwLiY5jzPE0Ew5ijH+6iEoRa9JgUgrPnQjJJ5m
   RZQGvXAGc4GJ5EmlCtmHgel7H6lb5jhp2YpOTeqx+DWFDrRHoKRABmnkY
   1hWfL0Tk1qnJAkbhJqs5LRg61nAPCKm1MVfo520Gor0ihYgKNPj/xCbsR
   g==;
X-CSE-ConnectionGUID: 0u1Dg4RSTVONmY5gvR7oGw==
X-CSE-MsgGUID: 3BIDDUD4RDmxxGGFt7V/nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90806239"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90806239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:47:32 -0700
X-CSE-ConnectionGUID: rNMzNY/7T6ip6h7mVeiBmA==
X-CSE-MsgGUID: GeBFzn4sTrm+WNhYkgFByg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="305628787"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:47:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 16:47:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 16:47:30 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.34)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 16:47:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxsqWfdqSJWPC+XTB9Aug45KuZmHYi0i7kZUuHIVYq2fGnoW9/eL5m8M26NAwX5UjkD/X+hVKtEhkGzBTG2zu1+KQGAGTP5f2sUb61DGDvvqxx3Bp6d2loLebzTYgUdA0h/WT6UetAeXoGz3CWVFmVvmytuEqvoaFprojZ7g0vMvTFJ5LV3ZvaKLGnmCJ4DSKFyCnltNjpd8A9dzQ+Z1QcTT4UKTUNBp2iiY6coXHR258gK841bO+1ubjuo1JOzbzcaitwQjzJOl7w8boIlZzcnoBTmH/IonMxBqS8OM6fdlDf07TlAz/mC8zJINwqACs9pQa7ESsU9kWkNd+aVK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOAmSAD3BI+toe3P9h4xZ9XlPbBh4afTIm5jONdWqdI=;
 b=lK5hiWMrCEcSlpS66sf9vX7DQzyhOx5+NaQd8rACgASA5cS8OQpJkl6dmcf+0WHXoSIuq1lwcB8djTzZJq86jPwMz1uORVWPq79KRosvLz7pu1cXFpnbBcaW7vZoz9oduELMFhQsl9aEatvxf0+DVZlu4bUhOknBZ5t9ztf9sSxq3YCLngAdwO28I2oHK9Kv2s1/9z+qyco1HCHefuj77kpVuEYiFxxy+qEhEDuBf7CHAkcSxFNzCH/HW5PwUZqi6/Ibb2L6U23UGyToCe+up7Y9vzkHPbQwmhi0jhzRBTBrG78cGiVp4Oyx8226On3kAP5D/zmzWmSTiAozB7ZA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 23:47:26 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 23:47:25 +0000
Message-ID: <3c736ba6-d2b5-450d-bf9a-c104cb818f1b@intel.com>
Date: Thu, 1 Oct 2026 16:47:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <emil.s.tantilov@intel.com>, <luoxuanqiang@kylinos.cn>,
	<bryan.fraschetti@canonical.com>, <tristan@talencesecurity.com>,
	<tomasz.lichwala@linux.intel.com>, <david.butler@appgate.com>,
	<horms@kernel.org>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|PH7PR11MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1119d75a-6fa1-4e1b-0092-08df20165880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: LAYVu58cKoRK7p0x9KEaW6POhvp2MEF7qD3nd0+7TnKNAsZI7ASHTQda4gopVgK4BkPadV3gBj7IAUOoQF2szuOx6Ta02esTghXPKUii6FyAxkhOaNnsxWBCq8/NEq0qD3RYgu6TU6kpK3b/lNiLO3ccXuNS5EoyxouVyRp4+qEpjYgHa9UMq8T4uI4tLAQ17VG1OLrQJNxL+7LkTKERpcYFjbEkzh3cJtdOMT+JciX/Wa20vngm8P2+Cgt2jYE4wUbg5VEZkj1XlToyprfe6qTk6k1kirG/Tlot4NBQseSvPoFzdHeghwv/z3w7SeV1tqU/O8/ZuOMd4KguupcPxNT3PcUVZNsMn+VnyPLRhqMpyK+z32uff1j6Wie3hPNaJKZhHtWhoSdlXxRvoB5fyhlAtgHqFQGI8PM6C5kJHodygfs4sjWZsmbuTUiGNfnLryDlj2Pj6LR8P0JOWc0w9RLC6pSIr2Ug5B4SfigTBz/zNySAEHpkROq676hIYx0bbTOEFD5nZZB2OATLaGGVJJ1vd3Ft7V0TVvS+AXXIqBc6oIsbiHoVXyqLg8CyPUJRghpOuJLb4CwE8PIbdeGTIXRIHCMauyXvuR2va/RHQIEtaVQQ4tjyFGsKUGiGa8xUeWHCFdpRNvG61RLDPNhho1euLmbfiI/Jxq/NGqFiZh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OERJUWRzTmlCY0JJak1Dczc0cnFPNnhCVVpUQnEraitiR3JqeFhKRy90Y01X?=
 =?utf-8?B?R0QydU5Zak9HU1JNbEt6bndUTDB0eUlTamU0NG1GTHc3VXU5UWtqaCs4YTBH?=
 =?utf-8?B?SXFNLy9LK1U5SVBsTXVFaDE2dTBHZDZCY1FBTE9oY0NxUUtONThPL21KZmFh?=
 =?utf-8?B?ckUwTVJXbkFyZnJodE9RMXBBcXZmNkVmYWJJbHRnWEI2Rlg3SEZSNjZPSVY5?=
 =?utf-8?B?VllLZjEwS1ZEOSttd1FVRXRrL0xpZXNFdFM4L05WWWFaTzlwUVpTaUVwbGZE?=
 =?utf-8?B?OGc4ZjI0MUk2dW9YWnEvbTdEYXVCMkFnWWV4aHZJMVhHN3BRa2xpY2lkczdZ?=
 =?utf-8?B?VSs3ZzdJd1NPU1ZacWxLNUoxdjlEWlNZRjBmTjFSR0MzN2Q0NE14WDBWKyt4?=
 =?utf-8?B?MFVoZ0xsY0pTWE1vbEdVcHNOWUxXMGpCSnZrUmVQTDFxa0REVDJxWUw2NTdp?=
 =?utf-8?B?SEZ3b0N0dU9IMUdrVVdkQ3JJRTVXOGxMcWRobmFTOHloS0xRdUl0ZzF2bVBK?=
 =?utf-8?B?QUZISzV2MzBCaE5JQkwvVkp6ak44SGZSK1NVeXJQTjNrSjhJOUFjRTh3YTcz?=
 =?utf-8?B?dmZXcFVoRlkraVp5WWUvU1ZzOTlPNVhBSG03dDJCMEFpWnZxKzFMdGVSdnlo?=
 =?utf-8?B?YUhLQVZRZW5tMHVDVG92ajQ3U2VQZkJhUUZjVmpyKzdPanJzUUZ4WU15TnZJ?=
 =?utf-8?B?QWkwMzd6UHFKS3VIdmVNaUoyODJ2dUZ5VjhqYmk5T2FxOHZpZkdmZ09DMklW?=
 =?utf-8?B?Qy9vdzFBcURQaE41WXlGWUtRZGQvMmNHS2ZOYitnd3Q2QXkzYkdVWlk3RXV1?=
 =?utf-8?B?QWZzcHRpb2VMdkJZdGlUT2hMM2FiK2R0MzlKaUhnazd6ZEl3K1Q1Tm5GNitJ?=
 =?utf-8?B?TEpzV3JwUWZaSjlNQitNRnRzbnNHZ1IxMXZua1dicmxtOGpoejFBNFZSaG9q?=
 =?utf-8?B?ZXBQNW53bC92d3BpUFM4bmhCcmdMVS93SjRRdnJ1TG1aTGs2bTBJdXNnSkcr?=
 =?utf-8?B?a1ZTcVBSS2RMZG1WV1lzMXl6V21Qa2lYbENXRDZuaTl5Y2pldHJsZEFzam5T?=
 =?utf-8?B?cUhqN3BuVm1iMXV5WXZpamoyZlBXejIvaEo3NGNNRWhnQmNNNkh4K1pmTUNF?=
 =?utf-8?B?bS94ZjVNclk2Vkxhb2hpTERFN1NWY0c2cUdDS3AwdEpaYWZzRWNWNVl1MkVi?=
 =?utf-8?B?S3AvVXY5MGVkZlpORzFEZFFyNUVHdS9lNEk4YUFwS0RxWDdtMjBseDEreUps?=
 =?utf-8?B?V3JHcE9tQld1cUQ3Y3MvRVQydUN6RjcrU0k3OElOUllLWVJ4c2VvS3hua1k5?=
 =?utf-8?B?WmlvZTBvcGcvOVJVSDJHcmI5bHVsL05YNlh3eVN6R3VTNWlyUUlCL1JUQWRU?=
 =?utf-8?B?VkEwL0VOY2NzRURWVGF5RjJycVQxSzkwdVkxNEY4bzdKRHo5cThPcUJqLzJZ?=
 =?utf-8?B?bkwrRUlqUDlsb3VsZm0vVVJsRlFBaEhTT1IvYkRGblRqR2REQ2tnVVBBcnhK?=
 =?utf-8?B?OUtHcCtPWXZOcUk0UlR3TVNYVlZhYUJwYmtqNFZmcnhqRjFvWkZyQzRBMmhN?=
 =?utf-8?B?NmtqT2FmWDdkWjZvOVlKU1MwcElIalp4NkwwbWNNVVBmK09NaEFrRDhmOVJ3?=
 =?utf-8?B?Q0x0WUZPVTVxRCt4VTZmZ1JFR0xScS9WQ25SQ0pYR2ZGazgzdkFKVko5eEw2?=
 =?utf-8?B?SUw1SWwweU5XZ3A2SFc1MnFFVEFkdjBsRUZmV1hQa09wLzc3dDJWbWdrcFVS?=
 =?utf-8?B?MzFKNUNwc0N4L0Q0KytqZFE1SzF6bWZSUktSSEoxWXBaUmpvV1BiR2xpL2FI?=
 =?utf-8?B?Vjl4Z3NwZFFkN0RrNnVXKzRTRUgwNVZIbUgzSzVrc2xic1NuVExHZ01hdytK?=
 =?utf-8?B?am1UK0dOb09zbmFNaFFXbmY0UUhEZFBtcEt1L3F6S3p3ZXJjWXZSMWhNZFB3?=
 =?utf-8?B?T1ZWOVp5UUk1cWtEVStIdzF5SDVKWkJJbWR4b0RnNzhyODJXa28xYnpSYmhK?=
 =?utf-8?B?YmZrSkxMam94bHBQL29BRmpJQUhFR0h3MjBXUFUvSk41b3JKcFVBY09ST25N?=
 =?utf-8?B?bTk5MGp1aThzTVdveFdaRitRUzJzRkwweC9hVW9wc2k2VVZJeEFkU3lWZ0lq?=
 =?utf-8?B?eFNjQVlVU3FUVzJhS3pSSmRZN2JXVUthRWVBSTR3MWtOc1poVDdTY1M3ZklO?=
 =?utf-8?B?Tnd0cjNzckNrdVdJMEswVkJKMm43OHBvNUxESVBneHNiSTV6VWdwbU1mQ3Mw?=
 =?utf-8?B?WG9YaGNLTURVSlgyWm5jS0NrNHJHVGcxQlF1N1ZDcWVZdU5pei9ERDQwWm95?=
 =?utf-8?B?RGphTGFqWEd0c21xMVdVTjVjUXJWNkdiNDAzUFZzWmFnUGtCcjBVTjl1a29Q?=
 =?utf-8?Q?KF0+kMPim7HZLA6Y=3D?=
X-Exchange-RoutingPolicyChecked: K8vPJW9DDJ4PD3Powr+pQO5Ug2DD1KzKtyCdy1OywEJs1a+xyrBzzt8sv7l0bOszkdErSk1OELS6af78gNAiAtqsQpsledV6h+usNY2at7N/ivsaZKIGpnR9BVNrnN3YHDAS/MleVjP6XvaWp3TtMmmZCuJERwr/ORJ6oKVPLSGDPrBmSZ1vZBsU8+RDc27AcBp2E7Qs0S+II22e5h9YWRVf+lfVA84NAZwDBNESlsm88frWwmj/il2/NkqPOglFUE+sU2HivZx/P39/pDOGJcnEK3Lqy/KNA8kyZ89FjtRUgAvQIOZsi1W36GKMu97gIohfCf+86j5FsWtRFP8vPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1119d75a-6fa1-4e1b-0092-08df20165880
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:47:25.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1arCKz6hHyKvtzNFISxv09RjPBKZZO1GEFYTkwWmlM2kpBVrHFMscdzIuGcay9BZP2JZFi6SPKJkqlukJ7v1fA8ProYryjVyC6M12/vRvP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com



On 9/28/2026 4:04 PM, Tony Nguyen wrote:
> For idpf:
> Emil fixes a remove/reset race by always stopping the vport during
> idpf_stop() so NAPI is properly torn down.
> 
> For ice:
> Xuanqiang Luo resolves a use-after-free issue by changing order of
> operations so index is used before being freed.
> 
> Bryan Fraschetti restores ordered MMIO writes for ice Tx doorbells
> by replacing writel_relaxed() call with writel().
> 
> Tristan Madani fixes representor use-after-free by releasing
> metadata_dst through dst_release() to ensure it is not freed until
> all references are dropped.
> 
> For iavf:
> Tomasz fixes reporting of statistics by always requesting statistics
> while the adapter is running as PTP commands can interfere with the
> previous fallback stats update mechanism.
> 
> Dave Butler caps the advertised maximum packet size to the hardware's
> single-buffer limit, preventing PF queue-configuration failures caused
> by oversized multi-buffer frame limits.

Patches 1 & 5 will need to be reworked and resubmitted; responses to 
Sashiko are on 3 & 6. I'm hoping would be willing take the acceptable 
ones and I will resubmit the reworked ones later.

Thanks,
Tony

> The following are changes since commit a7bfaba4823e3c165bb2004c74eff7c096672bc7:
>    ipv6: fix prefix route expiry in modify_prefix_route()
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE
> 
> Bryan Fraschetti (1):
>    ice: Restore Ordered MMIO Writes for Tx Doorbells
> 
> Dave Butler (1):
>    iavf: cap advertised max_pkt_size at the single-buffer HW limit
> 
> Emil Tantilov (1):
>    idpf: fix possible race on remove during a reset
> 
> Tomasz Lichwala (1):
>    iavf: fix VF stats not updating due to PTP command preemption
> 
> Tristan Madani (1):
>    ice: fix metadata_dst refcount handling on representor teardown
> 
> Xuanqiang Luo (1):
>    ice: fix use-after-free in dynamic port cleanup
> 
>   drivers/net/ethernet/intel/iavf/iavf_main.c     | 14 ++++----------
>   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  8 ++++++++
>   drivers/net/ethernet/intel/ice/devlink/port.c   |  2 +-
>   drivers/net/ethernet/intel/ice/ice_eswitch.c    |  2 +-
>   drivers/net/ethernet/intel/ice/ice_txrx.c       |  4 ++--
>   drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 ----
>   6 files changed, 16 insertions(+), 18 deletions(-)
> 

