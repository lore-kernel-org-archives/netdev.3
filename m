Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD555C326
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928737; cv=fail; b=TmVovOxDoaxKZT45v/EC0VvoWCrAi75L96lq7dvcCzz0psL/5nHPACkc0p8IfVaU/9vNio/Yab0uC1+7pEEdtt8GhqTJzqte3dhltQ1vpiT19FBqYD3AtvOR5G+000fyEaXwJaoN3vAXvnKxl0O4pn7Tlhcg5U7NFGts7cJ2Ruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928737; c=relaxed/simple;
	bh=c2GJFG83VSYb/Wb4n0Lh2tS9ssmEFzNVrqhNfVsexbw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ehvSPmS6QJZWjsrAaxg9H8dvIa9CLkaJWjPP5lNALTVLDloNCqlNbnbk6ljVLlC2l60VsxjeP9Ulz84R23mMeLR69esRr5k4XP8t2r435SBmNI+dKTWaC3wYiZFTLw/Y+2wYIoOxz0pfBz14E4pDq9P3b3UHctVNM36Z+mVeiDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmSKKsbC; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmSKKsbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791928735; x=1823464735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c2GJFG83VSYb/Wb4n0Lh2tS9ssmEFzNVrqhNfVsexbw=;
  b=kmSKKsbC6z6W8wYVNXGmZunM6Z+HkcNo4zoQo13lXpag2rvgJTFriXRm
   As7JsWiv0+Qkp/IeNKOX1CvIjU2NQGF96B0koOl4HxmOS+bt/+lq6Qo6O
   f3mL6ptN6dMBiwjmyWnPnBqIGi+mI4iuebmtflPr/XRQzRV/Fmb3zXytl
   xjvY9AuDDLm+GIwyfWNEZKgN55zuPoAkAOFN7ZSWA62Y8OWYF0iCNXJRk
   J5N7FJRnM2VQpkVgOpWqF6lk8whGs7bEK10udlyfW0X/Z68iOjWCBuIPe
   Vc5EW6aG2Qq+8shvLeea6lltcmwKW9sorxk6KvON2oXpmGXEmw1R6S1Rw
   g==;
X-CSE-ConnectionGUID: f7VXQQYFTvCw/wcLd5R1pQ==
X-CSE-MsgGUID: ZoUMJ95UTxiFhe0EWoWe+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="771370"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="771370"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:58:55 -0700
X-CSE-ConnectionGUID: 48nx9qnCSrCcjZHz1oL0tg==
X-CSE-MsgGUID: hXKWEO5sS5+p/hHv7JJWQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1591274"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:58:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:58:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 14:58:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgK5VrEZOKcx1KjJz611XqPgL578BWCW9Q9ThCEw+kHWh4RSG+kce/SXHFvZD+EczYDIeGG0smSyxlaNwIHa3cSkWdaChvlngblTvQPqO9wFuFmZFjnH+7LFWX5oTkIBuPGkJVeXS3Qjcj68WaUKVroM2+uzq3RgBh85rlRu/3ovJS9F/ju/EbwHdjMlxkkVhwvK+Pu5k9zmWg2yVK0htG1I+XpbYHGD7S/oz4Ldk2kOcOZTDAFMF2HFzZORPwSiIgzUIBv2+bHh2Pr+WElKsfiWM0FYkUnFBeTphGa4ssMGQUCf+SfBCvHCVViUoNaawqI1Izv4vvpAtTbjycksTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt1wcmKrSBOSU8XBeRmZQhqUFBKuSCCckXVZCX5Xxh0=;
 b=YBZOd7f/qQSkgb/16OCxEzYVQtYQlbfuYanPAoPB2/gOT6097iOMgKbI7nbYR2SgaPEvg9foFIJ3Ergl0m+yVs9UL9ShBUD2IACq3h1f8g28If96o9rrJXyyQyPgKYufzR0uC6V+CaKNZXZFEMlUyquSf49MXfQdaKQKZapDquhrrH8I7neyOk/NFOCS81JXOBvMCzHAt8qQnW4eXLl9TVW5KMcsv6+ItEHEgyTidoAtVJ5sPAORPVduyHReB2TtESRwQfUm68cNGkfFbw+ZvsKnUlm+Zsyu9f6pVmZu9+NsCf5xbXZnZy3guu2ikVX78YR6yfNxXBvOtp8f1UPEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by DS6PR11MB005518.namprd11.prod.outlook.com (2603:10b6:8:52c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 21:58:51 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 21:58:51 +0000
Message-ID: <654f4f92-2889-49cf-9907-8fd253f09542@intel.com>
Date: Tue, 13 Oct 2026 14:58:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 05/15] ice: call PTP link change only from link
 events
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-6-anthony.l.nguyen@intel.com>
 <179184692262.434549.10025168203766414646@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184692262.434549.10025168203766414646@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:303:2b::17) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|DS6PR11MB005518:EE_
X-MS-Office365-Filtering-Correlation-Id: 72505b98-5b25-4c32-3f26-08df29752a70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|22082099003|10067099003|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pwC+ID8g1sHHPIWiRJq3xADrCD45CXIz93ih+sya6qJcGUVNL6Q6wXG3XXtNaGJmHthVxNJ5ymdDctPkZXpg6nqWMVbVvrNi2C5jfPdhYcfKAYgTXLfihHPrqm1TtYAC3/LLu0quSwCtWUQi+392LP8XE9pFJJuMp7bjBYRyyCkJxlmGodVllCQLZRzwj5JVYIZWFtqg8msiuspWAqToU9mbjtLdFGIqNngRBLvDyISRgZjF9qK8s50B3Ugwp2q3V0ORb/Uzqdmsb2f4sOe+xMy5WRG8zOUgDP2cC2IICZ5eP/Uq6fDtjjg3jiK/AcpmPONbpl0B6GSARaBqjgYHjoBJZajCfO2Tjq20bfY0pT6GLG0C6VC7ONQ8miUYHn7UikxbqiPuY7OexB09POsWDvIk0MWMYljuexb8wpMaE8JkknAWYn0vFAlN/vgAQEXtXyj+kg97xRtU9dcVE5/lo+Abr+HKhcG267uXI9M9pD9MDM/X9DUdZjXhA4tzbnTwHm6sLb1emGdXXashFouqAJRbtHaO6J0NQ3Xrkjok2/y7j083tqw/hrorZREV4ZWeqJ6WbhADpcATUIDRRPlcyNIsFD0q+ZaovBYx6m/dCJLNxfJwTBw1o/rCjMK3X4DB+DALzcOCMpSMFClWa734+Xj3CJOQGvYucMKsdCRFUM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU8zaEJmM2F4M2lYUy9mVWpOZGg2dFptaXM3cXdXMjF4VmN6dnh3bk9tYTNx?=
 =?utf-8?B?VEoyQkVxbUFsNUhLUUc2ZmJxenoxWm10L2ozc3ZKUnAwQXRubzgvakhHV1V5?=
 =?utf-8?B?M0hMcjJhczV3TXlmRHJLV0F2V2xvYlIzMnhPVDZHU2taOFdab0NTeW9XNjF1?=
 =?utf-8?B?c0ZqNFJZVndhMThMZ1VxLzFEQW94cngyRVJENnBYenUwZWFMSVBNV0pNai96?=
 =?utf-8?B?Zk0yYlZWNnExWWlDd01hTkJMTDlmUmJxMWIwQkVFazMvNVFKNWsvbzdEOTJB?=
 =?utf-8?B?Z2ttQnh1MTVHQjUwTzlQYTFhZjFWekRBSzV5OGJnMGJJS256NEl0L3B2ZVRD?=
 =?utf-8?B?OU1WVnB0SzYvZ0JLRHpLaFByWVZIK2FpYktidDVrakNRWW4zcGt6RU5mNUxh?=
 =?utf-8?B?NTR4VnVTZnZ1bHFHdEs1ZmdXeDNodzBpUlFTRHl5Z1M4dkxTeTduTlRCeTJk?=
 =?utf-8?B?ZW9PYnRZK1pQR2dqeW0wZm53bmFPNG5yamtHSE94bis3UlV5L0FFTEJWcHdx?=
 =?utf-8?B?SzcydjJRcTQ5NVBnZEtOYnMyOG8wajc4ZWNBcGlNRUFYd0g5ajlYNHdBb0hL?=
 =?utf-8?B?a2UrY050L1BrOVVCMVRyVXBkOUJXaSs3MjA2NGIyNUtDWEVhQjQxM0dieGtE?=
 =?utf-8?B?aEFnZ3o3VkV5YWtjWlpPZVMxUEl3MVdZUmxlZjVSUDNQSlVYTUJveFRuSnN4?=
 =?utf-8?B?S2hkM3dYRnkxcjRDRFIrUUJYdWVLc2xURGJWM0x1VjR0WXdKeDlESmY1N09a?=
 =?utf-8?B?amgzUHdPbXNDRWhjUURoMU0yZmpYVXhDbzkvT0ZFaXVLMy9zSmhvaERFSFQy?=
 =?utf-8?B?NXNIQnpGZ245S1hLNWppMGFud1lKdnE4WEJyWmNDMUpOVzJrUFJCajltT3dq?=
 =?utf-8?B?SXN0eHc4YXdZM3l5cnJ6cFlDQi9SbUtOWHlkY0Njd2JEWkNyQ0k5SG9jZFJB?=
 =?utf-8?B?dUtoRzJvWWk5dmhDN0RCekg5U1g3dCtybHpNN2lKR0ZmWTZBbTNjekxsWTBw?=
 =?utf-8?B?WmNVRjA2OEd5Y04zQU5pTmc5d2prSy90aEYvb0hNOExuS2srUk0vYXZoK2Nu?=
 =?utf-8?B?M3FqYlhmaGdyZTdiMUhqT0RBQTBSZFBSYk5mZzJKU3NLQkJZNk1jclRwZW1i?=
 =?utf-8?B?M0pBZ0M4SjJJTGE1UCs5cGFLREtHbWcydFN5ZnpqM0Nkc2dqZmVkd2doME92?=
 =?utf-8?B?anVkdVdkbDFoNGUvK29yOGp6bWNDT0pNL2V3L1lheWxWSXlITjQvWXRPTFRv?=
 =?utf-8?B?dFBldDN0d3dOSmtWUVQrM0xpZ01peUhYNWJBVWNQcm5GSi9jbzE5dlZ6MHV3?=
 =?utf-8?B?d3duM1AzbnJyd2NkZW04cmFzcGcycjF6ekdXTkpRV3hOOWRuTzhDTVAzVFRl?=
 =?utf-8?B?dFZwZGdVUmZJQmQ1eWE5OGQxVnA0WjdZWjdHb2hBVS8xL3pUbXNRcDFlbTBF?=
 =?utf-8?B?dkNVZVVpSGJSY0c5Lzg0bVlOcFdWaEF1c1hYMXZCVmd1azM1OG1WT09JTFZR?=
 =?utf-8?B?SjNVMDF6cy9LYXdidlU0TFJXZms3YVhlQ1BieG5lbFhjZzB5MUhQT3N2TjZa?=
 =?utf-8?B?WjBGR2pVbFZhK1V6WlMzbWhDcXUrRTJNSE1EZG1tOFVMWkozdDU1bS9GQ2pp?=
 =?utf-8?B?V2hiVy8yemxtUXpoVHBuWjdKclk4VW80eGNWbXlOTzcvMEtLUmtkcUhHV2FZ?=
 =?utf-8?B?YVBJbVdYSXdxelM1dzVNdnNycDYyRWwraEdEMVhIb01uRzNMamhPbmkzY21o?=
 =?utf-8?B?SmtpYUtQUU1KOHNRMXVTNmR2M2txS1BZbzZEbkVVdGUwZDhxQ1VKdk4yRlcv?=
 =?utf-8?B?MWhsMTJ1YXRWVG9oREhrTGFXV09aL09LTFdVY1B0UE01R0E2KzZPZVk4U2NT?=
 =?utf-8?B?Znd6ZDhlcFZwc3UvMktQZ3VJbTFQbk9IOUpmRHJhZ1pCMXY1RkNvUlI3L0dm?=
 =?utf-8?B?c29VbG0rM1RmVS91TlJIcjV1TXMxOUNBVnYxYmNzL2wxS0l5NUE4UFQ3SVJO?=
 =?utf-8?B?UElqMzNZU0dwRTRRanROb25ka3ZMaDROSWdhYXdpa0J4UzRPdnRCNDRtMGJw?=
 =?utf-8?B?OGw3aUNRNFlDNFlmUnl3YjA5Snc3ekx1bkNDVzU3YW0xKzN4Tndqd05lK1Nx?=
 =?utf-8?B?ZkdUY1hZZ1NXa3d6T082TjExR3AxRUZ4T3ZCaEtJU2V6K1hzNU44UjVjL1NX?=
 =?utf-8?B?SGQxaUNSWithdXJ3QjhXWDJXU1NjVlh5UjAvSGVhSUp5d1FrNTIxY01zSWxZ?=
 =?utf-8?B?N0VURG12Qkg5ZStQc25yajI4d3ozZ2t0ZWdyR3lQcmVjcmFvMkd0TCtJekN4?=
 =?utf-8?B?RWRKaHFxWHdGYnAxblIwOW5aQXNlQW1uNWExc3dIaWxCeGw0RUd5eDVZMUFY?=
 =?utf-8?Q?JVOI03ftNd4rtzsI=3D?=
X-Exchange-RoutingPolicyChecked: jFcAZAQ5OxANe0Bfq3M8lqjedv8xjCvmWLUGZaavNaQb/vOXuNgwfqxk6M9HbLEjXlysPkgyekI0BeQb+UYTgjeVqDr88PfRyBOUfE+6z7rJOJ4YboYQ0eO6cisj4MSgXTvfIUHYT7+OfI8kk+eZfGIgkSXxeCXRcN4pITlLuOzzmwdBPYecuKp93Y5f8ri8HaYt+JOOlJBmjmtu6//IARd3iQ0KR7YpCJDdNZbR5gMVq0GaaIimBSdLFOJSAA1D1dZ6qNu0MrPvjuq1vLm/VojIrbYahAZLZkWMtn/h8qhGc76BeuK/c/20+ePUP75/UqMDSfWCuKbe6g5BLAiA8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72505b98-5b25-4c32-3f26-08df29752a70
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:58:51.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cknlsbT9JrXaQ7cfsP7N3UKt9x9FzF/BriRxsLxveLa47f4zoJ8SoyqHOFTPUihDVqosDgOJKg/x37Yu8GrgcKpnkZMwFB8lsrLlN5bH5+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB005518
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 4 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] In the non-READY branch of ice_ptp_release() (state ERROR after
>   a failed ice_ptp_rebuild_owner(), or RESETTING after a rebuild that…
> - [Medium] On E82x, every non-PFR reset (CORER/GLOBR/EMPR) now restarts
>   the PHY timestamp block twice.
> - [Medium] A link event that arrives during the INITIALIZING window of
>   ice_ptp_init() is now lost for good.
> - [Medium] Now that the ice_up_complete() call is gone, edge detection in
>   ice_link_event() is the only thing that updates PTP link state at…
> - [Medium] The new block at the end of ice_rebuild() programs the PTP PHY
>   from pf->hw.port_info->phy.link_info.link_info without asking firmware…
> 
> Pre-existing issues:
> - [High] ice_ptp_init() publishes the port on adapter->ports.list
>   (ice_ptp_setup_pf() -> list_add_rcu) before ice_ptp_init_work()…
> 
> --
> 
> ice: call PTP link change only from link events
> 
> This patch removes the ice_ptp_link_change() calls from ice_up_complete()
> and ice_down(), so the link event handler is the only runtime source of
> PTP link state. It seeds ptp->port.link_up in ice_ptp_init() and adds an
> ice_ptp_link_change() call at the end of ice_rebuild(). It also creates
> the kworker before the first PHY restart in ice_ptp_init().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d88835482d3aa..f32041dd8b274 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -6745,7 +6745,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
>>  		ice_print_link_msg(vsi, true);
>>  		netif_tx_start_all_queues(vsi->netdev);
>>  		netif_carrier_on(vsi->netdev);
>> -		ice_ptp_link_change(pf, true);
>>  	}
> 
> [Severity: Medium]
> With this call gone, can PTP miss a link-up that some code other than the
> LSE handler notices first?
> 
> ice_link_event() only notifies PTP on an edge, and it compares against the
> cached pi->phy.link_info:
> 
> ice_link_event() {
>     ...
> 	if (link_up == old_link && link_speed == old_link_speed)
> 		return 0;
>     ...
> 	ice_ptp_link_change(pf, link_up);
> }
> 
> Other paths refresh that cache with Get Link Status:
> ice_open_internal() -> ice_update_link_info(), ice_check_media_subtask()
> while ICE_FLAG_NO_MEDIA is set, and ethtool ice_set_link_ksettings().
> 
> Here is one sequence:
> 
> - The netdev is down and the cable is pulled. PTP link_up becomes false,
>   and on E82x ice_ptp_port_phy_stop() stops the PHY timer.
> - The cable is plugged back in.
> - 'ip link set up' runs before the service task drains the ARQ.
> 
> ice_open_internal() then refreshes the cache to up, and ice_up_complete()
> turns the carrier on without telling PTP. When the queued LSE is handled,
> it sees old == new and returns early.
> 
> Would ptp_port->link_up then stay false while carrier is on, until the next
> physical link transition? The E82x PHY timer would stay stopped, and
> ice_ptp_process_tx_tstamp() would drop every Tx timestamp. Later in the
> series, ice_ptp_is_tx_tracker_up() rejects new requests instead. Before
> this patch, the open path handled this case.
> 
>> @@ -7273,7 +7272,6 @@ int ice_down(struct ice_vsi *vsi)
>>  
>>  	if (vsi->netdev) {
>>  		vlan_err = ice_vsi_del_vlan_zero(vsi);
>> -		ice_ptp_link_change(vsi->back, false);
>>  		netif_carrier_off(vsi->netdev);
>>  		netif_tx_disable(vsi->netdev);
>>  	}
> 
> [Severity: High]
> ice_down() no longer clears link_up during reset preparation, so it stays
> true through a failed reset. Can ice_ptp_restart_all_phy() then reach a
> port whose kworker has already been destroyed?
> 
> ice_ptp_release() has a non-READY branch. It runs in state ERROR after a
> failed ice_ptp_rebuild_owner(), or in state RESETTING after a rebuild that
> failed early. That branch destroys the worker before it removes the port
> from adapter->ports.list:
> 
> ice_ptp_release() {
>     ...
> 	kthread_destroy_worker(pf->ptp.kworker);
> 	pf->ptp.kworker = NULL;
>     ...
> 	ice_ptp_cleanup_pf(pf);
> }
> 
> ice_ptp_settime64() does not check the PTP state, and on E82x it calls
> ice_ptp_restart_all_phy(). If that runs during this window, it takes a
> reference on the port, which is still on the list. With link_up true it
> then goes down this path:
> 
> ice_ptp_settime64()
>   ice_ptp_restart_all_phy()
>     ice_ptp_port_phy_restart()
>       kthread_cancel_delayed_work_sync(&ptp_port->ov_work)
>       kthread_queue_delayed_work(pf->ptp.kworker, ...)
> 
> The cancel goes through work->worker, which can point at the freed worker.
> The queue call passes a NULL worker.
> 
> Before this patch, ice_down() cleared link_up from ice_prepare_for_reset(),
> so ice_ptp_restart_all_phy() skipped the port.
> 
> The order of destroying the worker before removing the port comes from the
> earlier patch in this series, "ice: fix removal of PTP timestamp tracker
> during reset". This change makes it reachable for ports that had a running
> netdev. Can this end in a use-after-free or a NULL dereference in
> kthread_queue_delayed_work()?
>

This is the same issue as reported on the first patch, and should be
fixed by re-ordering the teardown properly.

>> @@ -7794,6 +7792,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  
>>  	ice_update_pf_netdev_link(pf);
>>  
>> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
>> +		bool link_up;
>> +
>> +		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
>> +			     ICE_AQ_LINK_UP);
>> +		ice_ptp_link_change(pf, link_up);
>> +	}
>> +
> 
> [Severity: Medium]
> Does this restart the E82x PHY timestamp block a second time on every
> CORER, GLOBR or EMPR?
> 
> Before this patch, ice_prepare_for_reset() -> ice_pf_dis_all_vsi() ->
> ice_vsi_close() -> ice_down() cleared ptp_port->link_up while the state was
> still READY. ice_ptp_restart_all_phy() then skipped the port, and the one
> restart came later, from ice_up_complete().
> 
> Now link_up keeps its pre-reset value, so the earlier ice_ptp_rebuild()
> call already restarts the port:
> 
> ice_rebuild()
>   ice_ptp_rebuild()
>     ice_ptp_rebuild_owner()
>       ice_ptp_restart_all_phy()
>         if (READ_ONCE(port->link_up))
>             ice_ptp_port_phy_restart(port);
> 
> That cancels ov_work, sets calibrating, starts the PHY timer and queues
> ov_work. Then this new block calls ice_ptp_link_change().
> 
> hw.reset_ongoing was already cleared in ice_reset_subtask() before
> ice_rebuild() ran, so the HW writes go ahead. On ICE_MAC_GENERIC this calls
> ice_ptp_port_phy_restart() again every time. On E825 it does so when
> linkup is true:
> 
> ice_ptp_link_change() {
>     ...
> 	case ICE_MAC_GENERIC:
> 		ice_ptp_port_phy_restart(ptp_port);
> 		break;
>     ...
> }
> 
> So the calibration that was just started is thrown away and started again.
> The owner's ice_ptp_restart_all_phy() also restarts the ports of other PFs.
> Each of those PFs then restarts its own port again at the end of its own
> rebuild.
> 
> The commit message names this as the first problem being fixed:
> 
>     1. Double initialization on link-up: ice_handle_link_event() calls
>        ice_ptp_link_change(true), then ice_up_complete() calls it again.
> 
> Does the reset path now get the same kind of double restart?
> 


:\ This whole flow is incredibly tricky. The old flow had a double
re-init on every up, while this only results in a double init on a reset.

Perhaps we could delay the restart in the earlier part of rebuild, but
there is fundamentally a problem of ordering here: We need to restart
after the PF clock owner finishes rebuilding, but devices reset
independently and link changes independently so we may need to restart
after a PF rebuild. These two conflicting requirements are what
ultimately drive this collision. Since each PF is mostly independent it
tries to reset it self, but the clock owner must also reset everyone and
cannot necessarily rely on the PFs having already reset or not.

I'm not certain there is a safe way to remove all these double re-init
flows with the current driver design. I can update the commit message
for clarity.

> [Severity: Medium]
> Is link_info current at this point after the reset?
> 
> ice_update_pf_netdev_link(), just above, uses ice_get_link_status(). That
> only sends Get Link Status when phy.get_link_info is set, and in the driver
> only ethtool sets that flag:
> 
> ice_get_link_status() {
>     ...
> 	if (phy_info->get_link_info) {
>     ...
> }
> 
> During rebuild, the cache is refreshed only when the netdev is running
> (ice_ena_vsi() -> ice_open_internal() -> ice_update_link_info()).
> ice_init_all_ctrlq() also drops any LSE that was queued before the reset.
> 
> So for a netdev that is down, this seeds PTP from the pre-reset snapshot.
> If the reset changed the real link state, the E82x/E825 PHY timer can be
> set up for the wrong state.
> 
> ice_up_complete() no longer notifies PTP. A later open refreshes the cache
> without telling PTP, and the next LSE may then match the cache and be
> ignored.
> 
> The commit message says:
> 
>     Initialize the link_up in ice_ptp_init() and ensure that we check and
>     restore the link status at the end of the rebuild flow, ensuring that we
>     initialize the PHY timer appropriately after a reset.
> 
> Should this re-read link_info from firmware before using it? As written, it
> restores a cached software value rather than the hardware link status.
> 

Yes this probably does need to check the firmware state.

>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index bbb57edcec0f5..220d174397bab 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -3414,8 +3415,23 @@ void ice_ptp_init(struct ice_pf *pf)
>>  	if (err)
>>  		goto err_release_tx_tracker;
>>  
>> -	/* Start the PHY timestamping block */
>> +	/* Create the kworker before restarting the PHY, which queues work on
>> +	 * it in the E82x restart path.
>> +	 */
>> +	err = ice_ptp_init_work(pf, ptp);
>> +	if (err)
>> +		goto err_clean_pf;
>> +
> 
> [Severity: High]
> This is a pre-existing issue, but this reorder doesn't fully close the
> window it is aimed at. Can another PF still restart this port before
> ptp->kworker is assigned?
> 
> ice_ptp_setup_pf() adds the port to adapter->ports.list with
> list_add_rcu() before ice_ptp_init_work() runs. The kworker is then
> assigned without ps_lock.
> 
> ice_ptp_release() sets pf->ptp.kworker = NULL but never clears
> pf->ptp.port.link_up. ice_unload() also runs ice_deinit_features() before
> ice_unregister_netdev(), so ice_down() never clears it either. After a
> devlink reload, the PF therefore re-enters ice_ptp_init() with link_up
> still true.
> 
> The window includes kthread_run_worker() creating a thread. If the E82x
> clock owner handles clock_settime during it:
> 
> ice_ptp_settime64()
>   ice_ptp_restart_all_phy()
>     kref_get_unless_zero(&port->ref)   /* succeeds, port is listed */
>     if (READ_ONCE(port->link_up))      /* stale true */
>         ice_ptp_port_phy_restart(port)
>           kthread_queue_delayed_work(pf->ptp.kworker /* NULL */, ...)
> 
> then kthread_queue_delayed_work() dereferences a NULL worker. The window
> was larger before this patch.
> 
> Would creating the kworker before ice_ptp_setup_pf(), or clearing link_up
> in ice_ptp_release(), close it?
> 

This appears to be related (but not equivalent) to the issue in the
first patch. We need to make sure that the kworker exists before we're
in the list and we need to make sure it is not removed until we're
removed from the list. Additionally, it may make sense for some portions
of the code to check PTP state.

>> +	/* Seed link_up from current PHY status, since link may already be up
>> +	 * (e.g. after PXE boot) with no link-change edge to catch it later.
>> +	 */
>>  	mutex_lock(&pf->adapter->ps_lock);
>> +	if (pf->hw.port_info)
>> +		WRITE_ONCE(ptp->port.link_up,
>> +			   !!(pf->hw.port_info->phy.link_info.link_info &
>> +			      ICE_AQ_LINK_UP));
>> +
>> +	/* Start the PHY timestamping block */
>>  	ice_ptp_port_phy_restart(&ptp->port);
>>  	mutex_unlock(&pf->adapter->ps_lock);
>>  
>> @@ -3424,9 +3440,10 @@ void ice_ptp_init(struct ice_pf *pf)
>>  
>>  	ptp->state = ICE_PTP_READY;
>>  
> 
> [Severity: Medium]
> What happens to a link event that is handled after link_up is seeded above
> but before ptp->state is set to ICE_PTP_READY here?
> 
> The service task is already running at this point. ice_init() clears
> ICE_SERVICE_DIS and arms serv_tmr, and ice_init_link() has already called
> ice_phy_cfg(). The window covers ice_ptp_port_phy_restart() and
> ice_ptp_cfg_tx_interrupt().
> 
> If an LSE is handled in that window, ice_link_event() updates the cached
> link_info and calls ice_ptp_link_change(pf, true). That call returns
> before it records the new state:
> 
> ice_ptp_link_change() {
> 	if (pf->ptp.state != ICE_PTP_READY)
> 		return;
>     ...
> 	WRITE_ONCE(ptp_port->link_up, linkup);
>     ...
> }
> 
> Later LSEs then see link_up == old_link in ice_link_event() and return
> early. Before this patch, the ice_up_complete() call fixed this on the next
> open, but that call is now removed.
> 
> Would ptp_port->link_up stay false while the link is up, until the link
> flaps or a reset runs? The E82x/E825 PHY timer would never be started, and
> Tx timestamps would be dropped at this commit. Later in the series,
> ice_ptp_is_tx_tracker_up() rejects new requests instead.
> 

Seems like there is a gap here. But the big challenge is that just
calling ptp_link_change or setting ptp_port->link_up inside of ice_open
is that we *don't* want to be toggling the link state for events which
aren't a true open/close of the device, (for example ice_down_up used
for certain internal reconfigurations).

Several other iterations of this series have had other complaints
outlined by changing order, such as link state not reflecting the port
start state, or issues with sequencing. :\ I guess I'll see what I can
figure out for v3...
