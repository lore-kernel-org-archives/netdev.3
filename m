Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8C3D410C
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008711; cv=fail; b=VzD3XVHrZQ53JZjCPl4ZDxv977eHVYd7zGEnBrglv3FqC+YZhNphakAqQGPJV7xKdXcgIQV7NSaWa/lLLj6BR5ER422QAbgJI7NyHt3Wqb46NzW8sZ2JsEIMuhtpoQPGzJ43FMmIxey3Xh13Wy6OeuWlBKCvcDya7CmgsSHut5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008711; c=relaxed/simple;
	bh=ipBm8CT/16owhF5mXhYnTUsxdHh4cQvLnTuRtkXRoAo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qqfp+SgHnQ/hTdJBZ7rmxcLGHpnMdOW8i0B+Tl2EzYPuGElGOsN8conNRV6C/S9gH7dFxX4TUQzy2hh7Ls6E8G0GjcG6ouq3eRdb0UGpwxpmTg3X7gT+nCGo4R9dCkGLgCAZYPmCJ37ZlCQBuTWePJ9famCRVwnNH9qiOGq3rBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gp3mtuI9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gp3mtuI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786008710; x=1817544710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ipBm8CT/16owhF5mXhYnTUsxdHh4cQvLnTuRtkXRoAo=;
  b=Gp3mtuI96ZxEkVq3tzQbTXY4yTG+b5QfMcp6ZFTkjOApfNBZ/BS8rKvF
   NPGcVyoo9QW/BrQFgT6DkWOWBFU86GiiZEaH6oaF+YMmvtnuKJUmarYwJ
   8u44wVUUpaJTG6yE4+A1XeH5t6g3PAEwZ8O48UflGlS6RYOK5KNfXwREn
   Xq01neIDDcMgCHduSSW5L06TwBPJeWplP2sG14yOEEZDLlKucno4Lk/oF
   XqBS3FxVqLXecgPl3KFB4sPd5Gp366J1+5Wc5Ow2KY/xdbj+r4FBV2HUX
   9hKdasPA4jm62nkEkRmOzypuyhj/XMi+okhtzLMnfwZbEh88zgMtzwC9V
   w==;
X-CSE-ConnectionGUID: c4jEdtblQaOAwRkVh2F80w==
X-CSE-MsgGUID: A3Iey66STzqc9IaQt7/jyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90267857"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="90267857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:31:49 -0700
X-CSE-ConnectionGUID: DYR1qWQHTriFei6r/bd3Sw==
X-CSE-MsgGUID: tRS75UULQMamp6Nf0Cga6Q==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:31:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:31:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 02:31:48 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 02:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHW2WrLJ3bdP/GFEKDogJTdWE+sKI9NPceVzmc4B9VuBnMUD2/QHnjNGePHrJmjetgcYOv21Xahpi838dU5m5qrq5lM+Dz+JuclYY4tlERxldXQ+kbipcpmyqE3WkWw8L5PM2Yz8UtWBWi9ulnOSoqbJTOv2eVZarpgsyXKvhb9kf5Jx8uvS02Q/rVh1zFVpGs+WOMkOj/hp9b20wf2l75RtEDEfx3n6b5I9z47SbfH30llabnr8sQZlqWoIU84cYiGbNbsnif8ddfsdfBgxOvCI51SdBbNR7MzG8SPmYj+Hjtz4jDrgx1mGyG2a9etNVRMtqjNwj+tedXlAO0FGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJQ3I2p8SbdpgOhQqZCGS04MI/aSJA0KpKmYEqVTfX4=;
 b=HkYdjuNvt3goptgARTCrJ3KA4eEHZgzIWFNzOrgBKoB2wAI57n/cfi4vUSbPlOYlbB7I1jKMlyROTUCYRVyfpZNDcnry7M+lrAPtX6OVhRcUkFxk2axaJiwVUXhsC3L3OC3Ekl/0ye26ZXi6LV2gWg/zr8OyRDF9pflCFFNZy1Yqdq+XD7XbEQEf7yiJaZpfHN45KkADSOpxU0/Y47ekIIe2rmI4RaXZtVyGszJJun+Y2utVTnS8TeLrQhFbz8V3EKO1qi0orbI8M1S134KURa1Ya7NAZWdb2idGu5lTS7gLq3bPbiwkSPMEIjFGODkKMtx9DyLjszlxu3hv7iNR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA0PR11MB7158.namprd11.prod.outlook.com (2603:10b6:806:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 09:31:42 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Thu, 6 Aug 2026
 09:31:42 +0000
Message-ID: <7aa71389-9d43-4c9f-8b6e-6d1c0663d80e@intel.com>
Date: Thu, 6 Aug 2026 11:31:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gve: use gve_schedule_reset() on AdminQ flow rule
 timeout
To: =?UTF-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?= <renich@evalinux.com>,
	<netdev@vger.kernel.org>
CC: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	=?UTF-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?= <renich@woralelandia.com>
References: <20260806085112.385934-1-renich@woralelandia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260806085112.385934-1-renich@woralelandia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0048.eurprd06.prod.outlook.com
 (2603:10a6:10:120::22) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA0PR11MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 86166355-0510-45fe-5015-08def39d865e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|11063799006|5023799004|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: QUdrl/0BU43wf90Md7XVqoITBmof5AgCK6EvPXJyhWomtT90c1RWcQot19UJT54ru4bJNYSH7Y+Ut7isSOJlTgJUa8pGCxN/KdBHpd9F5h9lsO6pqtcCIa5i6DLTtMT97lkfVJlXuxsnNSWc3ENDKU2MKf9mZdY4Wz72QUvrmTsLxS1yAcVdHEPJ9ZjwtdgIEbCJ78YR+iFGz/TndktCVRfV6w3xD+rLlLUjQNX5DF/+n8TmOJ+x/wqYqKc9suX3XiyIZH2ceHLF4yS0ILOZp36RGdvSNrryWVplQ61wdjNTEU7Yy49WaQ4K+ZKozsgDNBHWPLbFuoM9zuGphUnpIXRwU/Jpj+SDFlAFalAe7oo2D1z7OLsnx97EDer7K5wtozRYsXjsqEL+5jF38aiB6hRvKdjQyBJBElHsC+B1dR1AoEv6p2m4QOyKnJo+G3sXXK5rrwxN2t5zfECPSJcG1SrKGN1K34Wytnvx49MLRd5vuGaywoDtPqSzSCx8w+7nhSJwNRKgpn3W5ETr7TonYk7QuQh5mNmja5GrKknR2Dinw0IWQtRAJSEUPYL//Z6bk/MAmWBCbJ3l9qLPQC8/rD9jSkUmGcXqx7/nXZnQ061FOWzNm0xezjnDrDshVXwOxHWlfOR+aynsE/ZiT3eV/UzqQl/MARP2Sxi0efnh9FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkRSK0JkWnQ1N05uTE5qbnhQamkyQTJSYmkrWG9IZnErcUNjbThwZWNQUW9j?=
 =?utf-8?B?VzRJTlY3TTMwNVgzbEtrZVdmMmwxaHR0Nzd6L21GSnRFYXIvZGdod0pBTU13?=
 =?utf-8?B?SjdjdUFBelZVKzZLU0NuZDh3RG5MWCt1RE1zNDJOTk9HMFkvdlQ2OUxENkZO?=
 =?utf-8?B?SUZuMEgyaFFUZUlrT2tEQ2Z0cDd5TXMvNkIvN1VYcTNnRzZBTnFEaFIwV0ha?=
 =?utf-8?B?R0JEMVRyUFRVckJQQzUxcTY0YmtjeUdzaHJJdWtTbnBCMzdGaFFNSy9hVFJr?=
 =?utf-8?B?NDRNVHNWTjdSc3hMV1lLeVB6eXFwQkNLSlQrZ01yTXBPNURwRnZTSDBTOFV1?=
 =?utf-8?B?SEQxNGkvdWRqbVUwbTcrYnp2ZG5sZnQ3YmREN293T1VxdHBkaXl6VSswUFJz?=
 =?utf-8?B?ODN6MzhCOGRNV3ZyQjBYSDNtTzdsZTJtSzFvZ2UzVkFIWWFyT3JpbHhoZmFS?=
 =?utf-8?B?REpzSUlVdTZLWE1UZ0krdXlKTGMwTDNYWUU0Tm1UN0J2U0JTOTJsMGVVWjdW?=
 =?utf-8?B?SCtRWGRuam1iampnakZuV2Z6Y1FlWnU2OGlKeVk4NGI2VEo5NmU4eGtrbUdl?=
 =?utf-8?B?dHExZ0VFQTZhL2EvSGlIWUgveHhEdUl3d3pzeWFnR05wdUFXTTZZVjE3RzRJ?=
 =?utf-8?B?REVWR2xWQWVBQ0pYNlVtanc0NnhDSkwybFViVUxIT0FpbDlvTFJINGpQVEFS?=
 =?utf-8?B?U1VFc1NweUNaK0p6YVJEQWpQTkk2djQ5UWhoRkg0RE5DWXFWaElnT0NlQURv?=
 =?utf-8?B?cjJTZXFwQW5xK1cvNDE5dlc4dnZ5WmFnanNaM0pqZWpTTnBGYjdZNWMyT2c2?=
 =?utf-8?B?T2QrNUJLY0RvakpvWmNzN1Nvckh3UkRWSFc4ZllKdndVbUdieFM4clF3cktx?=
 =?utf-8?B?UDhSVmV6bjltakFDd3BrSHduaUVMMUFXcmRqMURtTWoyL1cwZ3NoRG5HOWIx?=
 =?utf-8?B?Sjk3RFo1TlB2MFpLcU5xVkhlU3JsV2N3VUpsYjJ2QVpIaVpzVlFmZk1jbnlq?=
 =?utf-8?B?bzBLSGdWSXg0SlZHemFIRDZVWnQwNkFwQW1kYzN4ZlJvWjU1RjhZam8rSXpt?=
 =?utf-8?B?S3AwTFFaS1U3T0VZQ29CbFFFSlAxS1N3NWNidTF2Nmx2RThNNHR0TVFnNG13?=
 =?utf-8?B?cXBHYkxGSXBVWEFiSTdUaWJOM3I4czF2SEVjYWppcStCckxrTVdhTm1VSUt1?=
 =?utf-8?B?S1BYYVRSOFVGQTNjRGpSTytxeDd3QWlsY1oxVitKR004d1laaktTb1doWSsy?=
 =?utf-8?B?UHAxcHd1bEJGWEJoc2g4V0N4dmltdEIzRVJWT2hrZEg5VTdHSWlOOGVWTExN?=
 =?utf-8?B?cis5MTNkcW1qWEg4czJ2QklhVnZlb1ZWZGV1ZDYzWE1vVlVaRVpHTUErN0RG?=
 =?utf-8?B?NFJiUUZJNjJYRFNBUm9HclFyak9pZnFERjNTb2VYRUtWSTZabnNiZ2xKaVRH?=
 =?utf-8?B?QVNyTUZtdG1xSWMxTVk2Rlgyck95cTJEMTkwcFFFQ0Z0aldvZGpBM1l1YS84?=
 =?utf-8?B?YzFkNGlmSkhoM1UwMWovNTF6MXZGSEhTQ2EzVzJEMG8wdU9FdGQzYTZ4WWE4?=
 =?utf-8?B?VFpDN3B4M29lVHlpTFdTWUF0QmVYeFlEZG5NanZUT1kwTUp3d0p0Unp5eE0v?=
 =?utf-8?B?NC9NWFNnUnhaY2YwQllCWE4zNlpDcDRjQ3pYZDBnTW1SdGNKdjVHdGhRdTFX?=
 =?utf-8?B?YnZmaFh4ajg5RHRHeHZzTlNIUVB0dkREcVhjZjQ1cmhNL2FlekdLNS85SjMx?=
 =?utf-8?B?Qk8xUjBPOTVPL3FqMm16dzZsS3cxZ29sQU5HSjV6V3UrZHFOYUIxNG14dHNC?=
 =?utf-8?B?VlZucWF0aWVQRFNUSkRYcmVCcWltS0FkUDdRTGp1TEZGY2FCNis1V1BHd3Bh?=
 =?utf-8?B?RUk0allPd3kzWmRVMFRQU0hiVXF6VytRdnBtOVNJVjdSdjU2NjhXQitTOFpW?=
 =?utf-8?B?QjNXd24yTjhnYXM0T2FVdXZhK1IzSld3UHhIbWswQnhlNkhmY1EzQ2lIR1Zt?=
 =?utf-8?B?MExaWDJXRFNQMndXVDNDclYrYnVyY3UydmlBMFphTFlnSmkyMXh0V3cxQXNj?=
 =?utf-8?B?NzAzM3h2eUpnUGdhWGl3Y1dDMFpXbE85RksvRUx0Z3ROOWdkZjd4STJrd1Q2?=
 =?utf-8?B?emlPdW50QkdGOXVMY3hQOG1mZkhBWFJxcWsxcFpPZE9YVVk0VTdRTlBldy85?=
 =?utf-8?B?VnZ4R3laVEk1Z3ZVY0ZzRWlTanFudldrakZUK0FSRHcvZEhZamtOckhUbFVM?=
 =?utf-8?B?VS85NFUvUTdMRGhQN1hGVG5aV0NuTzF3T0JUbWJJT1ErUHk0SXQ4MVIxWVZn?=
 =?utf-8?B?emRCV3dIaVY5YUJtd1owbnhrMDF5WXIwRHZKYlBBTWh1STVYWUtGNmY2Vzcv?=
 =?utf-8?Q?9IBpMzjAOBVwtskI=3D?=
X-Exchange-RoutingPolicyChecked: Npi0UFkQIKbjc3wLRRL1O+HDoANE0ixfAEbAVPXKPsTqvMcprWy8807QsmWR7CI0Ey/Dvyw+p4lszk3G7bxR2BYCr//5tkD+y9Dbnzt6L7o63G0bvkpBWJJJMZmsYg+R7JWWCPLER1S7pNpXxE4iY+NJTLoAvP0elefZHWGC0hqCQKuXCWA4g3b1X+Qgfatr6s5RhR7x3mNRvj+qQo01Vd98/sYMaPe7aPO1iWpn+/ZNHSC5Par5x50sMiLArZm8lVbKfi9oiESqx60OaRFFL/6s3WeJSaFcwRCD7xwDXFsNvoJ9BKHlSgmK35VHLYH0l538zq2b54SOiApZJBzZhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86166355-0510-45fe-5015-08def39d865e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 09:31:42.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIYuPnjTQ8la2vr/UnxYQ6tv8R6rfa3gxJAOCRZle8YMZRtTVoFHU4ME6i6AoplNM/sIXxERCVbPrXwpLWdxIH63pzmuaMGqAlosLFXTjyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7158
X-OriginatorOrg: intel.com

On 8/6/26 10:51, Rénich Bon Ćirić wrote:
> When an AdminQ command to configure a flow rule times out in
> gve_adminq_configure_flow_rule(), the driver currently calls
> gve_reset(priv, true) synchronously.
> 
> When flow rule configuration is invoked under netlink or ethtool
> callbacks, gve_reset() attempts to acquire rtnl_lock while already
> executing within an inner driver lock context. This violates the driver's
> lock hierarchy and causes an AB-BA circular lock inversion deadlock.
> 
> Resolve this lock inversion by replacing synchronous gve_reset() with
> gve_schedule_reset(). This defers reset execution safely to
> gve_service_task out-of-band under the proper lock ordering.
> 
> Fixes: 8ffade77b633 ("gve: Flow steering trigger reset only for timeout error")

this is not the commit that introduced the bug

initial implementation was in commit 57718b60df9b ("gve: Add flow 
steering adminq commands"), so this could be used as "wrong code intro",
but likely it was the addition of netdev_lock() around ethtool call,
that exposed the issue, and should be the actual Fixes tag

> Link: https://github.com/GoogleCloudPlatform/compute-virtual-ethernet-linux/issues/93
> Signed-off-by: Rénich Bon Ćirić <renich@woralelandia.com>
> ---
>   drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 08587bf12345..2037b1767890 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1322,7 +1322,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
>   
>   	if (err == -ETIME) {
>   		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
> -		gve_reset(priv, true);
> +		gve_schedule_reset(priv);
>   	} else if (!err) {
>   		priv->flow_rules_cache.rules_cache_synced = false;
>   	}

code looks good, after updating Fixes tag, feel free to add my:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
