Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8722F01
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939558; cv=fail; b=AjMgpAwN2d2A46Sbex3SsowOvrubkFbSRhSq+Of4cELUv/HSxr1s+Jtm26Bwol3AKrQRy6jL3IyqArv8JbZtzLMC2fp3OIdKy2EDIao1B0GCWtulBJvPpMrY5XW3R/voqw03HJnABdDD0w/iD5KO8r76bAH1Yvn+HTJsuX4HiPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939558; c=relaxed/simple;
	bh=ojWbD+XoM7tyr2E5O/yoT/jkJ2F1SfSzJ3HCGS2EVa0=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SE5gnSscovSSRNAuH9w0TTNYcGYdUTt7FitTCwEZ2/K0vI55MBTECwqSaG5qgoL20ZMZO01E4fpTbwWmXaNr4nnyrtXcot+2gYy3wT+Wrepyq6DJaNzG/vverYLo5s2oBxW4iYu/oP76tpMALprPf2mHOxp95S5arZszxSGb0uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gviCGPBZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gviCGPBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791939555; x=1823475555;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ojWbD+XoM7tyr2E5O/yoT/jkJ2F1SfSzJ3HCGS2EVa0=;
  b=gviCGPBZDzh/0sN3jox4BcFQsJAad8VPzsGu4TkFTYGZe5y9YS3FqYqI
   Gv7vxZk7eTOeFeJbMDq/mxiUkUOml+KcYYfwaEJtxQzfPGo6vAqxZlzUU
   1DhvmiQAHE9pr7SEWit2EceZMdwX2KzoFAqobDFZ0MWFU8te8GqeH2HQK
   vOuFxUenAwkPTmqvDjM1IbCHDmBfum+5DXdfzW8JnZgZnKMJ7Bgp2iF9h
   ZYp5lFqh8FqboFInx6brZ2hPm+SCuonleRSFs3fQnhCiyMYNgt7QzgZ3m
   RUE2eekO2u9Los65ZBuvmyVBEJ/3eg9rHDN8uYs0jPywBcsBTTqz+5uVg
   Q==;
X-CSE-ConnectionGUID: ki7tY/2DSz+htOTPnLcxNQ==
X-CSE-MsgGUID: CF3jQqXHT4Wzp223xQZi9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="564775"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="564775"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 17:59:15 -0700
X-CSE-ConnectionGUID: Q+2x6FL0TjKW0FkeXRKwYg==
X-CSE-MsgGUID: +bkPVoYZSGSdfYIF+vb4mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1733131"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 17:59:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 17:59:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 17:59:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 17:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwyBjXggiqcPKklmNip2bnJ4cMgPrHDEG/sP7NWNf+oj6MxQ05T4etq7GiAw9m5/i22j3lqxPssiZVIUXf1knETIM8gBpJFSuM4hteJYmVU4bCpWi3hz2/+Wp2JCOWgokNTJhhIDnTWlvU23kJKRG7A/EtIyWmtn1/LXIaSXST0MafgNdwxzX7LWkabnJ8EMfm7/cnOlUOjqiY2NbEG51SLJ2GZz9BQXg2GDae69v4RGke/jhg6cOCXDvVs65rP0znwdarn8NxP7GwQcbGZnSgNdVUlcF3veIXo1h4eTX+Z1SY7HC3yn3O2ptjDi0ULG7gXXZxRko4ls6Fcy6/bgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41/nyxve8MBdrCf/5J/yEVFvbukIoZj4Kter5ZD5IPw=;
 b=Py+te6lYtG2Sx8q8J3X71YD37R4SCFDr5e6NiZAKoYSgBLxJ6Nx2nwpIsynGxzwOfxXtfR/75TsCYyyieDu6vKnADEtMFKaF9anOfsK1mlElHKgP9KtQIcm9vp4IVUrpO/MzrpB/vhxKKHqRfcsx1MEITnzYHrn345PZz2+I8be0e2E9WrHjL4TjFWgr7rxeJSULORxJSy2+aqeI2M+1L044+DSOdw8+5Zy7EccxcqfFa0Z4zDW7h1dB319i/UvHs4S3aQUjkE6LVfESKB+GL3QgRbHFzdoLvi4j5GAZJBCAxLwrbXCmjpeE/H+rJIGD0yqzH/UlWfkNC6ZH3tjUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 00:59:11 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Wed, 14 Oct 2026
 00:59:11 +0000
Message-ID: <f690dca6-ed1d-494c-8f51-8dfdbe7ad37d@intel.com>
Date: Tue, 13 Oct 2026 17:59:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 15/15] ice: Recalibrate PHY after settime64 on
 E825-C
From: Jacob Keller <jacob.e.keller@intel.com>
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-16-anthony.l.nguyen@intel.com>
 <179184693471.434549.9184447106002765149@kernel.org>
 <443513c6-b979-423f-81bc-0a3c94c5934f@intel.com>
Content-Language: en-US
In-Reply-To: <443513c6-b979-423f-81bc-0a3c94c5934f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CY5PR11MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4ebba1-b353-441e-9337-08df298e5bbb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: AjvpexYpx5O84qHwX+XSKiB9CzZXGedS2QlfE1D0KxBTGrkgrSkU9raJx7TWt9EYEBz6vCcOhLXeuQoFlvCAeqgXDzyFhIg5NJqt/Fb/Qx6o4d3Cnj7Kp7ZNhp0jd5ZlhaoRuxAq480zl08Iqz440TDfH/0qE9Hk3dB10s96iHObj/wt98/NuTfv/Va90IgVLMXKKMAy6l39OTbX90nnkX5KNaCqotUXESljacAzI8t8hptRwBi45R1UUn/bHqduVfOjo88CGGy3A94LFim8TkcyYfY9R3i2U89bzNZetDh+NmsxK/3IfVxkuwZbDOVXvMUXL6Y4dIpk+sg7nsVCo7YDdqLg9lU3lGimH6feXcglLD/zfspn4e3dzkF6Afnn8YlZXH1ayNG++1mf+MiW9S5W5LEa8CyQPXereiQLZBb3hrVePo5Ve2hsUge4lYemdFNf5pOjOMB9YY650lhwOuFtEDhtyclJYOh/MifFvkEQWBBff1jsroGmKshxjZqgFrzpY9g6qQ22f4LS+BpV5C3i43QhsIya8ra+PSwOJcXr1krVK1s3GGAUBZFGn7m3NFbBpjBqzN9OOB/UNQEYxNKeI1lkD6G0eoY0I+EzS75CtKwJaG/0Rl73T/V89d7DjqJPAQeeEiDLKd7wpexqH2ClT2zm9kpqcWJ66PypwC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDlBYzM5WCtwL25NbEQzbGtDcm9BNjVkTlBscE9XQlYzRTdNZ29YVmx3QmtQ?=
 =?utf-8?B?dnVnNXVXOTRoMkNHRWJ0RnFzR0JNK25DVFFITWNVTkJqN01kTmVTK3hqdHVM?=
 =?utf-8?B?SWFYMUQyeml3NEtOSzRvdVVhT3dJREZEb3Nwb0FadDRjM3NJdE5teCtwaG03?=
 =?utf-8?B?K0lIbU16RUZGOG1FNlQ4MndrTERxZmNTNTVwY2FXMEpSM1V4blUxTktHVXE0?=
 =?utf-8?B?L0dUV1MrWGJad0pmek85NWtzb0txeTV2WmhaRSt1blloZTQ3ZktvZERCNm02?=
 =?utf-8?B?blhBd1BUR05UMmU1M2gwVW5BWk5ka2ZBT3ZuVDFpS1cyVWtUZGJhVEtJdEZn?=
 =?utf-8?B?WmpaNWNuenMyci9SOFdWcEJtZzFmSTJNREp5WE9tK3haSVdGajdGRjVNSllt?=
 =?utf-8?B?aVJNQ0dLVUVkeS8zbVFwUnMxOFJqbnBsUGUzT050cWx6RjFqdE9SQXpxOGtX?=
 =?utf-8?B?TDBkQzNHb05BZGdiUEFwUXlTL213ZW1nOXpGS3pEK2FaK3VsS3hwbE0xR2h3?=
 =?utf-8?B?Y0hWa0pwYkZPZXIxV2VPVzdDRUtRMnRCaWVmdS8wTHl6emdzYmNRcnVWQTNt?=
 =?utf-8?B?dGJ1S1JLVENQaXo2VUhDZ1V5RFU4dkRMSkMyZWlrWW9xWW1RUkVBSWxjUzRI?=
 =?utf-8?B?V3pveE4yMUM5UmxXM1lYY2hGZUQxSDdCM3FZdWNsMXRJemt5bjJrVVFXeHdF?=
 =?utf-8?B?YVVjWHo1QzV5cmErUVVXYjVkOUhLRXBTdjNiclNaamd3YzM2RHV6ekhIcWhm?=
 =?utf-8?B?cGZ3R3ZkRU5GVXRiM0xSc053a0NkcEZXQlFQK01nMUtmNzh4eHp6L1dGSkRa?=
 =?utf-8?B?QUNGR0tEYWQ1N1pEdG4wQUFhamNPUFQxZEcyUkRVLzJndDNxTXI5bGY5cVlv?=
 =?utf-8?B?VzA2Y0VWSklJUnJ0QjNXNWFzTUR5MGNoK0k5ZjFEWDNzbFVxMzV6Um9QVTNO?=
 =?utf-8?B?S3Y1bll0QjdZYVl2V1VvS0hDeDN1dVkwb2VwcHg0NkFlRWN2eWV6TWwxY3A3?=
 =?utf-8?B?cGJVUHFUQUdBdmZoeW45eE9sN1U2RnZzOWlyZit0MTBSYjF3a3lweHZzTkZ5?=
 =?utf-8?B?QmRFcFZxblVBM20rTXRwenF5Y3JIeXhTL05PVHp5bDFuMjFCRXlwQitTZkpy?=
 =?utf-8?B?OHpqQkxJaVQxQldSYTFzaFpTTFJPcitKRFdRR0E4SnA0ZUV6S2xkR3VDNlJi?=
 =?utf-8?B?Zjk3MVJkRE9lcjBCZXlnTVF4aHJMaTdZOGo4VFdNQmdqcVdFSkx5NCtXNERs?=
 =?utf-8?B?blRtQ08xY0xtbk8xd3JWMTZ4ZEIxWGFYWlhLakxpYkNCYWZhOTN2emUwL3M2?=
 =?utf-8?B?VkNsV0x6QlRsN2NtNnowcmlqY2pWck9YWGZudXNnWWp6b3h1MzZOdW5MMTdz?=
 =?utf-8?B?SkxPd0NhSXhBMVhVOHdxbnE2V2FZZEp4UkpkTkJEdU9YYUhPV3NFK09HVU13?=
 =?utf-8?B?QmxWUW5xaVBldVZMM2VaSmlBVlBjZENRZmxOeEpGYWY3ZGJMaitrWE9NZ2Fp?=
 =?utf-8?B?NE1VeVRWa1BEck9xTnhwNWhGZmJvRUdqb29tRld2VHdTamhTQlNCMXlpcXdN?=
 =?utf-8?B?NkI2THdvYnhNUG9ia3o2bWNNU0tjMllhdllDeURlNWphNDJzVG5Qc3I3YnFk?=
 =?utf-8?B?NkNyb3hSSXE0eEJFMTY5Sk45UWJ3bmZPdCtSNi9yMVNCYW9pdjNLcHNpMkFm?=
 =?utf-8?B?VzJSVGVnNHY5emYyQlFIQnY3dmUwYjB1QTcxUzJVSG9UVXpQc0s5Q3Y4YWVy?=
 =?utf-8?B?b29xbXFZeWViVTdId01ZL2VNVWNNYk1uMlJkS0dhUTNtU3dZbXdUR3I3a05M?=
 =?utf-8?B?a2IwaFdJQU5JTXJyTU1ONFRRNHBUY3ZSQVVFTFZ4L2ZIcHZERi9rKzFJbVhF?=
 =?utf-8?B?RHJUbTc4U1NmeDFYaStOb0F2WVlTK1RHdmNVYmlJWjZJMG5uQnFYU0Z3eTgy?=
 =?utf-8?B?T1cxYk5YeEZCQVlFZEgxMm1pblE5VlZxZER6amRWMEVvSTNiQm1uUFZZUFpX?=
 =?utf-8?B?dnhzWnh0dDJTVitlYjZNU1M3WE5XY25aeWxITnQvZC8rcDMwbkZVYXpWQllu?=
 =?utf-8?B?RWNxNXI2RWpmTTlxMitJa0doN2ZaZGkrd2o3NDdNZm85N2NDKzhWYUgvbDRY?=
 =?utf-8?B?aG4zUC9la1UrWUplRERaSFNNNFBiRlJlQTR3RlBramZJQzBZMmdlVHM5anA0?=
 =?utf-8?B?MU9acEZuckN4Qjhwb2dUK1ZGUkwwdWdYb01PTVVPbTBFcmZYMTBBZFZUVUQ4?=
 =?utf-8?B?b0haZG5LVzdxeWZHdFhWOVRISHI3dExYS3Nza0ZqWGxzUUtnTTFycmtyeS9u?=
 =?utf-8?B?OTJYOXdqRGNtTG1mYUpUZFRaaVdlQWtqbnR5cXVwZm02YjFWbjFIQ09HWGg4?=
 =?utf-8?Q?On/Asu0//NXBHgj8=3D?=
X-Exchange-RoutingPolicyChecked: aK56m/fd54cOlUSyYLDWPBQ87zDvYls3p4fMaBNs5xhAcEaSjkbssQIUPqhsy43OYdDkCm7UptvnZ6sPaagfNWmn0jOfPYMXa7F3zqEyvZmZ8uSBfPt1QTCwmn+wfO+B4yttfRL9GJxPl4cj4QQp57t3hg0sOlUNsx5ICXO+YG5ugc7NqzZbhzgZQmcIF6h+ofoJTJMWvjdnYYcp+aeSr4NOAKgLUckFIRT2H6WzSHHS+tPtnWprgeZcfbrOJRNm8eD/xBdj9+PRgajF2aYwaxRtSx4JJmFDc2VIkTTi+rObvwcmDKcpjQcu/3mJc2eqCElW8QvxK03SFenVVbuplA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4ebba1-b353-441e-9337-08df298e5bbb
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 00:59:11.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NTura8k+ovOxQqe9nQgvgcxPjobZ+mH7hKBM8vhuYZghrGk4IguxnozQkY6+7HwZ1vGrbx9bW2sllHF13E+uV69MWcXWBukH5BjedvpEOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-OriginatorOrg: intel.com

On 10/13/2026 4:04 PM, Jacob Keller wrote:
>> [Severity: Medium]
>> Can the new E825-C restart from settime race with a concurrent clock
>> update on the shared source timer command register?
>>
>> ice_ptp_restart_all_phy() runs after ice_ptp_unlock(), and
>> ice_start_phy_timer_eth56g() writes GLTSYN_CMD before it takes the PTP
>> semaphore. On secondary PFs that write goes to the primary hw:
>>
> 
> I believe this is a preexisting issue I pointed out in the cover letter,
> slightly exacerbated by the new call to restart. We should fix it, but
> this series is already quite full. I guess I could try to break the
> series into parts? :\
> 

It may make the most sense to push this patch out of the series and
address it along with the semaphore issues. I'll work with Tony to
figure out the best plan of action.
