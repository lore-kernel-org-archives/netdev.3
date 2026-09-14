Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235AD36657B;
	Mon, 14 Sep 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379444; cv=fail; b=UFH9amiQ5r0aK3X7fjs70krqPAiGkHXoDnSRlB5pKLqdCNlrDNfTKQylo+wn2e+2AMVgjPOhYT8RTIvbCOoJ1URVichkZDKC2zrqEZCtZVoZCU0QF6b1mxIBGZB1bKg7M7YJe40/8CUCwHK/1sdpyaZBGRYvI2DUUsKMgU2yhOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379444; c=relaxed/simple;
	bh=cKVNOXQl+zi6vhIPk9VYJ8gaRrsjcTSZ+mfeSHt34kU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YE8DqFGu1Xp92ZXtBtqPPvEjg20Grg0DV06WqjxTPZpBrF2jF9Eqd+csrAIYYbM3OHd6pRPXZ9XVjCw3BZbADnXOjxlKjHrbXteHr/CCm7aKab3tqYfpiLircW8pGokh0lnRsgIpPDHMg68gjIZwTzjUsUbdACsmUnnOvpuk2XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgPXofBi; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgPXofBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789379444; x=1820915444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKVNOXQl+zi6vhIPk9VYJ8gaRrsjcTSZ+mfeSHt34kU=;
  b=VgPXofBiU277yxegRB7OmLRSBND3ZTeVSWmoebSx1NBgVoWP6NgwfvPI
   bLTMqmEvF33JHkN/NnYTvhwSP0nPM72JRr6nuHgYz7LCpgcftDQwFRlN3
   /t+JN/aFxBE0dZHBRg5xqiIPki4aaAMC5ll0o7jgid1952jzeE2ue4eZ0
   nP0mprL9CV1eBot/uAFiu1bskP9Gl0zPBve224ju1YLX3/MCUZ6dBIYul
   wA8T1bL4hmIkdMvZAX4bJ1ribuAcqU0+Cseu/pVJtrXeAYxOZQwYcSVCX
   8YqgH83TWtIiJJUrKUOE7WwdX9iMJ1ojlLCUPkgQ9+rPM1daTUC1tY3cD
   Q==;
X-CSE-ConnectionGUID: Aci9pO7YSN2d/FFCyzPmMw==
X-CSE-MsgGUID: L0npmQ9YT161EiiJXawiAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="239551"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="239551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 02:50:43 -0700
X-CSE-ConnectionGUID: pbSkmvXtRFSYkDSxcxYy9w==
X-CSE-MsgGUID: MMlhsyowSBK4lb16FE04bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="268303372"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 02:50:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:50:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:50:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJj2uNTXKW+Zypxp+b3COwfX9h9HS9gFQLhZtbCzYtLoluCHzIj0Brj+LyYVDYaAStKPe2Wj9TtEciABVc+GHVjKttioe1Y8ZX99IoyYnVuToJ2m74aRQsSnB1tjgKJYGAy4sQXymKHniiKXrouUyLMxmkWAAnSS7ivqDa48G/fxMAJbtIUhLDOmjqXMbLv1mI13sBE4z8FIy4+pGeKY5BBml/ABKcJ5ycmNqqRUVS4gulITpIAT9cRjxsgRCJ/Afl47n4Us5iXEwVTb3z+E0/5mc1zRyslztVWnW+aHlpb5UM/GFX7CaEjoIkBZD3tNFfItNyDNhYFOOcCIZv2WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCi43l5//WBbs/pJ2vD5rXmheEvF/dQMUBPohGaRy/s=;
 b=IeqySSeqLgwTBzSr9gYjMWyP7+rlZU92qq4t1KBGh3b/TPLDwXRWH3pWkHTQlaXgNlek1xFddIo7DHuuZkw/QgivksYpsOA3hyVo6qqNu+8ILibYeFk9L3VGZqCfoTk7gJBl5+qpi6e1H6KVPaFlHDAqezVe4KvOHXnUpnWwsJs4eVjCe248zdW4/GTlim+R6NVjsnON9tSjvHc79neIwUnJzD52JAcUav702UiSwsBhBzuLujJX23r5dZ0GtYKqbMem15je+VUGlR4XOzdupN+YGXxq0ME34ISinkv7F2VtRSIjlpEAMjyPu8IH/0biIoRuLq4xC5DmlufC2QU2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 09:50:35 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:50:34 +0000
Message-ID: <4ad84736-f0cc-4ac6-aee2-8b21a5b8b8d1@intel.com>
Date: Mon, 14 Sep 2026 11:52:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe: fix incomplete ACI command buffer backup on retry
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>
References: <20260912013403.2818191-1-xiaolinkui@126.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260912013403.2818191-1-xiaolinkui@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::14) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 9981f3d8-c6b9-456d-30d1-08df12459f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|56012099006|11063799006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 8RwZXICT5kSSWhnUbtJzEf+uTlKMQGi5y+R6NFZ9fJ7B5WA2raVfzysktEk4hRbTP2CkO5z+SVNTHWz7v/WSXiy5/s7YQKwkKTVWtH+aL38wrcW7kadBKIKR/8H6PURCuUIwknaQ8Qt9G0gFzrMNcJEPfnnETtlsnNglMRsEZOv0m5oZ0TmKCBoadpUXvjfdUq8QsEIQBgv+SpWophEdLvnZFLBzMNJUtS+T2K+S2AKxNdC04Tma0c+HuvuIRgJ1GAO28jTugKDRtH7svfqJY1KN+s9edmyhYNhJW0Y5NSAOWqaucHVnCkUEgyi7PhAAHqmR/gHpNPDtuEfedavyioWABJSkvpwGunfvoR88zo21wj1F4HNJhD8W/WsqBa6jvzbJdWk54pbULAZQwPZnhE9FAAI/i6pBljkn90a6JYTjgjLMMNNlHunAYxt4E1Lz4JZkinShfyI0l48o0QUe0HSvY7HzJtF0R3WczOlBE8U4jmOy7zxohuJmy6pwEqRahDE+uZyKt+YU3X3yanGqeXLKyzuvrQKEQjNtFOoNvfOMzz1KhoeI8re3748ILA9q7pqfavxBoY6LPP01QP8YRPi0MaBw5mMXL97k+0jFdAoRekppMRjR1s3YWaNQPbCiJwp9y5Iv8dvGx15glUupMAC/xqpm8YPb9jfpEiqffHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVpVR2JvaEhqOWVyQ2JtU21nTDJmQVlNVEFrZDg0ZXluNXZ5OFphd2xudEhW?=
 =?utf-8?B?a0VhWGhvSkx0NWpCOEpTREhwK1Y4aUxpdnBQQStyU01GVm1xQkZJZkJhZnk3?=
 =?utf-8?B?SnFhMzRvaUtMbWQwbVh4VWRKajFHVnpNR05HejM0NDdBTmxOMG5jaWJUU2Jj?=
 =?utf-8?B?STB1SW94ek5JTXVOL2RsQXJ1Z1JCKzEwTjdkenRZMUNXcldSaGRFMDBTRUVN?=
 =?utf-8?B?S3UxN0RrWDZtdFpSVU1SbFFrOW1jbXkwTFMxUHhpdm9VMy9OTzVWOTBReEtT?=
 =?utf-8?B?UDY3QTB6bXlqQm1hd1hVcTZEdVVYQUZzSUVEanpCeVEvOUFUcHVwTTNHTWdk?=
 =?utf-8?B?ZTlVRHNhdkpHVjdzZjRuaFVucnpZS3JjM0RwMytHQkh6a1hpeTlSdEwrQk1G?=
 =?utf-8?B?cEF2cFFiakNVUXp5ODBrMUQzYVRDbVJGVlB3NllVOFhxL1lWS281Qm16T0wv?=
 =?utf-8?B?clZlYk1vakNNV2FOU2JJME9CK1hvUXcvZVVpODl4U0w0RUlDUDZ5aXloOVEw?=
 =?utf-8?B?QS9uTlJVYUROaVRGT3RLeURKeU1ZZG5sa1FkblNML3FHYVd1Wm5YWDVzYzNs?=
 =?utf-8?B?ZXBUWHVlZ0hRUTc5YmRQT0d4bVRIL0NuVkd2bzJSTEJxSURoZmRIZzRLUHNB?=
 =?utf-8?B?N1ozdFVZZk1PbGJjZ1VaNjhNenNFN3FxU0pnejg4eC9VdStrUU54Y2N2Vjkx?=
 =?utf-8?B?NU5vVjloVkd4UmZFQlk2TEpId205Y3lLWlNtRkgyNm9ROHNhVTQrMFVyaG1u?=
 =?utf-8?B?RmNPV1VKZmdGMkp5S2FQWVRqQ1lvMkp0VnZXTzB6TE92S1N0M1IzblE5MEtD?=
 =?utf-8?B?SFBuZmd3YTU3MmtKK0FwRFE2Q05sdml3SXhacGYvUExYcVR3eWhMSEdxbVk5?=
 =?utf-8?B?MTREd0psaklHWlhZQkh3YWkvRUZLL1YzMnZiUU40WldLbHJDVzMwS3VCNmll?=
 =?utf-8?B?Ly9sNzRBS25CdmZYT3VIanZGWE1sY2czVmwrTXJLVG5mT0VMZUJpdU1US3U1?=
 =?utf-8?B?cUU4K2tGaEZSTlBkUGVKb29kR0tOc3g4aXQyaHRtam1VdC9VZVR5VUZLZTlh?=
 =?utf-8?B?SG81L1U0eHVaUlVqS0Eva0UyL25hOXNFMWh1dm1lem1vRzVZRUJtTDAwYjNt?=
 =?utf-8?B?dk1jVDBlZlZwRXFWd2t2aGVacVV5eVN5bWRKUjVTOUkwMiswQ2x5VlY4L1Bt?=
 =?utf-8?B?WnhLU2xWa1BOSjRLYzBvVWRZMnZZekY1aE1lMWgzb1lqcWNjK0pWa3BLbTkz?=
 =?utf-8?B?TnBOSlFiWXZzUnc3RUY2VHNza1hrRWtPM2J3bE9JU0IyT2RuRHZ4Nk9aUUJl?=
 =?utf-8?B?NmFjN3lid1Z4NFVvT3Rzb2QrV3lCU0t6WjJhdVRneU1mQzJ6ZlBmVkVsK0pw?=
 =?utf-8?B?VFRNc2hLU3pNdlNPZlVXckNtLzJGc0xYa2ZsN1F3S3hMZ1NuSkUvVmdhM2dJ?=
 =?utf-8?B?SE9wVTU2TU1ER1VhNk92THd0QVl4Wll4Yytnd3ZFSVpYL3E0RFpPbjViQnRk?=
 =?utf-8?B?d1hhZHJNNHBiYjkydUJyMldreVVTZGFUN0VSeWFUd3RjQTVqL3loYmhkY1Nk?=
 =?utf-8?B?TDhCL2Vta2lIeldEZWpRYkJKd2xadWlkemdWWmdWdDVQdXpwQnVJTlBrVzZT?=
 =?utf-8?B?R2F6Z1hzc3FjMXFXdFZFZmdaL2ZYSXFtREY0LytiZE9sVGFPTnBRRk0rVFN5?=
 =?utf-8?B?VUdKUEZ3R2FLaWlPRDZoaE5RMUtUVFlldUhQanJlQU5zZTRYeWFWSmJLZVZ4?=
 =?utf-8?B?WGQwUDBkclNVWG0yaUpqZUdBeUlCV2ErMW1nUitQdkJVZVRhL256enQvcWdl?=
 =?utf-8?B?YStocmtlVHJYSzk5U01tcUt2eVVUcUdTOXErdG1iekE1UlFVamJmMHA3TjZI?=
 =?utf-8?B?MUZmSy9zODZFOEFaQkpZTXUxZHYvK2xkOE1tcDdVMnhNcThiUm9JWFc5SWpK?=
 =?utf-8?B?T25sLzQ1TjJjZDVvMmZxNzZ5ZlIwMVRtM3A0WmtTNG13eG1mQVI4QVV6U3Fq?=
 =?utf-8?B?RlpXbDZacjBlbndLL20zR1dodlNPaW9kRVQ1WTVaa0p1MzhYbm9SMy9GWk9x?=
 =?utf-8?B?ajV5WFYxZG9BeXFqMCtoajhXS2wySDkvcmlhOWpyWENjODF1b2hlRlpwSkNy?=
 =?utf-8?B?YUpBU25vZHU0RDdwUWJTZkFpMGYzMEJjVUdpZkkzTGtJTHJqVmJ2NTJEakxR?=
 =?utf-8?B?ODNuZUcwaGRGeEw3UlNsdGNYSkNYUldONmFpWGxnelB6VjFWbDNHNUlNUWZE?=
 =?utf-8?B?aWNhUzNnMC9XeDdDU09lcEY5alhubytGUjdpdThYL1VUczQyTlRNVWY2THNS?=
 =?utf-8?B?MTQrWjAyWHNhNTVVUHQ2bEs2VTM3c0xYSEw0MDhReEVyYkJqenhsbEdzWnla?=
 =?utf-8?Q?VSNw619UuTFwIRpw=3D?=
X-Exchange-RoutingPolicyChecked: pN/ZEPSu63v7TEGSaD2Evx02QUazoegcLSbAgO0oQ6ZFDgQXgqO64Euzen2HVxWXBNffacs66AJcGTEP9PDla2DUC0rsVL2xRmAmN3Ax5uYAm8SWMjUn6GF1BNsABRYSAfBfMLO7adIjQcPkMbZuztvB3GjG+AVNVdcgsqFoBFjT3KsKeqygu3gUOXdzTdLNFKV90UuHhBbdabKpCjLeP3VjR64goBT6zg1uU6yW51yZIftRrt/TPuchZbDWtMMVorn/k7QHFVruWL/NXoT90Bu/6VX9MXwYPYQoGW0r95UlG3trXHRMgeV63t9d+GL275LRCDwz8KvqBVtu1u5AjA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9981f3d8-c6b9-456d-30d1-08df12459f1c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:50:34.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xnFAq1/NmmRVYCnm/rgdmRnD7SFEq5jxInJGYNNx8kJ7Je5FFPMHdrKqOJIiebiNRHxRevwv4HWPtQk7oN1kqr4WFxI6MKqiDf24oHBEWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com

On 9/12/26 03:34, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ixgbe_aci_send_cmd() backs up the indirect command buffer so that it can
> be restored before an EBUSY retry, but the backup only copies the very
> first byte of it:
> 
>      buf_cpy = kmalloc(buf_size, GFP_KERNEL);
>      ...
>      *buf_cpy = *(u8 *)buf;
> 
> while the restore path copies the full buffer back out of it:
> 
>      if (buf)
>          memcpy(buf, buf_cpy, buf_size);
> 
> So every retry hands the firmware a buffer whose content, apart from the
> first byte, is uninitialized slab memory, and on a read command the
> caller's buffer is overwritten with that garbage when the retry finally
> gives up. The buffer of a read command is an output buffer, so the caller
> does not initialize it either.
> 
> Use kmemdup() to copy the whole buffer, exactly like the equivalent
> ice_sq_send_cmd() already does.
> 
> Also skip the backup when buf_size is 0. kmalloc(0) returns
> ZERO_SIZE_PTR and the single byte store above would write to it, and
> restore based on buf_cpy instead of buf so that this case never passes
> ZERO_SIZE_PTR to memcpy().
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 4d8ae5b56145..5dd88ee7ea58 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -214,11 +214,10 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
>   
>   	is_cmd_for_retry = ixgbe_should_retry_aci_send_cmd_execute(opcode);
>   	if (is_cmd_for_retry) {
> -		if (buf) {
> -			buf_cpy = kmalloc(buf_size, GFP_KERNEL);
> +		if (buf && buf_size) {
> +			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
>   			if (!buf_cpy)
>   				return -ENOMEM;
> -			*buf_cpy = *(u8 *)buf;
>   		}
>   		desc_cpy = *desc;
>   	}
> @@ -234,7 +233,7 @@ int ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct libie_aq_desc *desc,
>   		    last_status != LIBIE_AQ_RC_EBUSY)
>   			break;
>   
> -		if (buf)
> +		if (buf_cpy)

ough ;F, thank your for the cleanup
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   			memcpy(buf, buf_cpy, buf_size);
>   		*desc = desc_cpy;
>   

