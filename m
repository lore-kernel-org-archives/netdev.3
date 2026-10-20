Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792523425;
	b=Mqt0XbJecf2Bg/6GvvUIxWXFxr7XFWFtiokUZIGsHyerZJtund+kNyblwaadAVYfRW9r
	 Y0bspSwYVKaMFsR1B1275qLVKYJ13nlhKWptup63oJaTFAFp/IDvjkGjLTPaQKwvVOymC
	 6LPvIl4zyAND+1iucaOYbWrcHxvGkgcVxynE78BJqE/qAKRrCibX13FH6Gs3veppmpaGC
	 7fJMoYxxoiamjTnX029wAG+N5vcoN3xMz4P6uoa38vrayWk14ZoTX5MYkN7kqf9+oGnc8
	 6MArk9mC6YXoulZYskI63Srm62r4+a4W57/jQi8l37HxOxsojhXefmRvF9P07GDIAEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523425;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=lK7GIHyw9mO7vsM0MkZ7i0ifumt/rGCYN8BEgixfSW4=;
	b=WiZ38Hec6D+mJkp5Xq1fGK13CzbUrFEDa8TMfoz8iYDvrEcLLtFOATy++FawSIMwfqIX
	 tsIz6IUxTO3lntlO32B8BdgT4JGY2kTttVE9V4s72peIK0OVber0ctgNlPKkyXo77HC4z
	 BzVsy0z5MwgJv9CdkwnYxZMxgbVQi8XfbmoPT8it4ujNUneiFxoFqDjKAJ/kWW/r1Zef4
	 oXLNKzZgTkKZD9v8pTT9kOLnso7biI2FvJMb3yHQeOO3ia45OSoKgNDGeMVrOpNrUO5tm
	 nYThJo6ZuZrywmB8EaL4Va1hhJ1YdGRxYyMnevXesCJMYaRW+3v9cEDhDyi+AdVq81w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Oh/Vi8oo";
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56353606A31E;
	Tue, 20 Oct 2026 19:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56353606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oh/Vi8oo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792523424; x=1824059424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uu/lLhBvyFPLcP0GhTKgRLtznt5aQsucVOatbQ9SSCs=;
  b=Oh/Vi8oow0T210y2j1kyqClq8h2D+QcWAIi6jZEn0FBYeozwli4gU2ob
   agDuPWBtJfGlO2DCcmg37T23nVI4Qinceki/l4nZ7YWqpt8t28FYtGfjk
   dke0/5WqGpSF8YwTAxK7nYVnnkAJZmeMx4YZEHfBE7weyG0qK513HnsR/
   J6tKql/jGPWgz1bTzv+MRnfscChltrg4xhyHsdGnYPd4l/e1ZEonyLrCO
   2F39AVDJEv2PFA/6lITrcXezVgp8oHtunCUfC3Ebua+xlUS78kHmZKNUF
   a3AtC8ZBQgdvMxMSwlGXnaDPhd6/Opmtry+UobewEkk9vdOplh/A7V6wN
   w==;
X-CSE-ConnectionGUID: WU1X1V/gR3W7mVeyUK/8Rg==
X-CSE-MsgGUID: XIgHINGDT6qD+806QtkN5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1249251"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1249251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 12:10:23 -0700
X-CSE-ConnectionGUID: xU58TWxDQ/yBawDuYmnpOw==
X-CSE-MsgGUID: /WrVGzIARDWSpBNpG+ev2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2881301"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 12:10:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 12:10:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 12:10:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 12:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECXuOByPWc8hfN5o0YbwNe4t0dmSBvhSVYkR7PK4xXZtKe5ti5yd8jGLGv3zK/KnmhnWvcd61XKYr8PksWRyn61bov3Yo9yNLJ3X2MpH05uC2M33pQ/qlNGSHc7chLjntue4FtYoDsVFJb6wJE9v/G8oeX3v31cShtqJOL+Qv0qzj67/76BvuqE6EnpYOxFwCS1TfRnJ3uHdSOkHtq4D/BMiVKnBXR0Tc1NPZcm8hQcVZ3+n5q55cm7G03eiS5GF+AgAOJ6J9yBHScHrrLdSN7eUXFTucsFO6MPpOZCioYD++VJMyGMyQ1Ib7vcP56pD+6O1mcoOjZMugvQfLZZnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK7GIHyw9mO7vsM0MkZ7i0ifumt/rGCYN8BEgixfSW4=;
 b=o8IaDhaFa4cTkhuE7Z7AzkhdOveRq6tfBjZAVvNqusxakQo+7hX3WzFjQ5kDa3q8Frlp/T1g9FfA3B9JtnqAmcweR0MRr0lyFDzzW05H3OaPaXicFEGiJGI7PKNcO6tlbmyVwmMJlUO+uixb35gs8+9pQ4yMSmIixMdS9ALYfUw7FAs+SnVwAvOrzM4wwi06ZH8P50vETUzqD9b+eMb+v888VIL/HZ24BWx8Pofl1HbqE1x/rrWbwWP5FNRMID3LNFBGLCT0kas2t5n8Iq7U+BYnW/s1LWFXcE+SnUIq4g3pEVfYXlMIzryynK6VcMiATRvWww4iPR/7EPKMrObGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 19:10:19 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 19:10:19 +0000
Message-ID: <2b9f2117-1bc0-4d83-a30d-1c8f7b295ab2@intel.com>
Date: Tue, 20 Oct 2026 12:10:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261012082910.283229-1-xiaolinkui@126.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261012082910.283229-1-xiaolinkui@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|BY1PR11MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ca76ad-5a4e-4ab3-87b0-08df2eddc827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: cPDQomb3XiMQU8jBc4Wqiynh/uhH8aRriLKTdRoJLip5lEh2XCCe/YaD6J0SMKxM38RkRzi4eBZnUUiOY0JQt5mqCuB9HGYnIZ9eYtOnmj7HqBs4VsDn8h7ZAykuIwKT/GoDkBMW6CirVwPODxgpIeIni4GsPuEkdyX9BDATaB8KKGg0ER87oA5qGB7T9htR1ePAUkYnen5nZNutUZ77cHCeoLDotq++5t/lTV0gLUV6T8ZaL1mYILp/GO8GJnqEwGKiHZOFHU5O2PbvMy5NQa28CNbS6XcTqbRvOCOIXJZgu9/ySsodDxJC4F6si5Ad/YwA7Jp/J164jYsSKHVIN3SjpF0v6+tgPWX2iF8jrrYTQzr8iylXI7HL1PcxtAenSTRuRZqMrpNF5TLBt3yi43NwueL8hPDglbKBKZxjEsW3XPM2gvOHqyYYdbRDWM8jJsEc01yXL9LqQpfY8YHycZfRT226yGocL4qfMRuWgHa8FqG6jSQ8EucF2vTIqEFk8hlNU6x0OM45NEFJT5+lKF7iMCqXwatCdRcG/ZAVnih9eJ/tA7mYT7FZ0pYNttjBbvvl0RqvsjlPNZgaUAgyAS2xRBBBcxmwiQcgiWrxoICPWR/7/C0QcLfdvYbN2OqGNd8vXNRzoyH4T3BLGfma6/9DVFFMxYU4XSEDsZ+bJwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzgyU1NqRXMrODVWRW1RYXJTTnA4Q0FZaHRqQ0Niem5OSjlnK1d6R0luTUF4?=
 =?utf-8?B?S0JVSDRTbU1rT2hhdnd4dXF6NDRPTWt4dWxEYVhLN1dWa3RxR3ZEeGFkS1ZQ?=
 =?utf-8?B?YjRKNmhJeWtieDI4TWZmWGJuTldFcWhxeEJoZFljb0JLdXZBWHordW1odnh2?=
 =?utf-8?B?OVk3NFBxQ1M1aHhzZDFUTnJEV1RmMnN4dFlhQWw1cnN2d1NqRGpGajVTOHZE?=
 =?utf-8?B?ZThnMDZuZjIzc0RjeWpJcVZadHArSWduaVlJWnU4RkxiY1pNSTRwZGxKTHJo?=
 =?utf-8?B?MWg2ak5hcSsweEI2ZTI5MkhFc08wU0c0ZXZLNUlRbjRaeGVlaE9FZDRQQ3Yw?=
 =?utf-8?B?Y0RoUWJnVERrVlFUNXY4c3F5NEV5SXFlL1AwM1AxelA0MmFyR2dZSG9iZ0VS?=
 =?utf-8?B?aUlQSVIzYTg0Umx0UjEyVjlnVEdRMGJSc0ttZ0dyQmo0OFh2UitQaVNSRzR5?=
 =?utf-8?B?NUNaazBUQTdjUWRVTDcrei9BTXA4bnhoYUhROEVWdDJPeFB4eGhnMlNkL1BE?=
 =?utf-8?B?Zjgxbkp0bHZEY1Y1Yy84Smx3QlpIY0pnaGtrV1NqNHZPeU5sRlFiaDJtSTdt?=
 =?utf-8?B?dmdZK0ZtTHR5Vm53T3pXa21oODRzUUoyU21kWmUyUTdxdlBmaFVBUWtFYy9M?=
 =?utf-8?B?bjg5bE8wcWx3U1FwalZpT2srdTRiVVlGQ1l1TW1wRVdMMm13VVZXa1NvbEV2?=
 =?utf-8?B?UEN0R1FXaTE4UjRNRVJyYVFHY2tkc3hkd0hsRU90K053cHkxSEpWVXlyc1Fi?=
 =?utf-8?B?TzNaSk5XSElpUjE5ZExWbW5JWVdvdUdDRHh3blJZU1VveW1GVEpVcTFxZm9E?=
 =?utf-8?B?T2hQQnFhcEkzR1Yvc1NtVFdYWFpBTFU4ZnVsQ1VvUlplZi9rRlhVaFgveXVJ?=
 =?utf-8?B?Y0EvRzFxUHNXRDE0ekRObDAwYklSb0R4cVZrT3J3QkNvMHJTY1hmbkhhOXdY?=
 =?utf-8?B?UER6VlgvY0w0YkYvdVZyNm1CQmJLWTB1K3Z3S1BFeURjc2owc0pzY2ZQcENI?=
 =?utf-8?B?ODdReTUvT0tQZXlpNGRQRzROOWUyQ3VnUlh3NTNIRUtjK05saVQvdWsrbEpr?=
 =?utf-8?B?Ym9Ua1lJM2JESVUzMzE3V3U0WVFWZDNLZnFVNzJWcUJrbENzYzV3a21kRWx3?=
 =?utf-8?B?N2RZb3dPTldGa3NmaUxCWTV2dlAvOWJOL3hkMTFsS0VnQjlTKzhydWovRjF6?=
 =?utf-8?B?YjhCc0wrZU9Pb1NkcDFDeW9HYmxmdlMzcDcrQk56YjB5REFrSVhEOVlQTVdp?=
 =?utf-8?B?SHNrUGdrM3pYR0RRWFc1SUljSVRhNXNnRmtOS25uWEhnT0FycjYxTm5IZWJX?=
 =?utf-8?B?Q1JLdkdpaXhUT1FFcUhHK24rTU1mSzNVR1FQQTZhL1pmcUlUWklocnp1dW5x?=
 =?utf-8?B?cEt5bXR6QmZ3dC9ZdkdMSlZ6UituSlh2M0cyZ3RFSHUvMlRWOUEyK1FDcWtQ?=
 =?utf-8?B?aG04c2REZG5OVmNXVU1iL2wzMitiT1Q4N3NTaFE3cUd0ZjJSNDhmaXdiOHJJ?=
 =?utf-8?B?NmVCMGh3RlRVL0E3V0hiSDMxYkI2VEtEZXErQ3p4Z2hDVTM3K05KL1ByN08w?=
 =?utf-8?B?MUJQRzJiK285SkYxaW0wZFB2MmtWMHRHR3BNV3pkWS9EeFJRTEgzeHpqNXBZ?=
 =?utf-8?B?Rlo0eC9BZGlCNUpCMXVFdjQ0Z25SUEs1eVQxemJtNjF2cUFJclc3cTVCZWNl?=
 =?utf-8?B?WldPTzBMcjlPNDB3ekcwcE5tcmZ0Z2FEc2tNUVlpQ1psbnZNRXRYSzMyY05w?=
 =?utf-8?B?VERaN0hyNk5DVTE2b0F2QmM4UDhMSWZyYjdEbUpOTUIydUF6RHhlckhTLzA2?=
 =?utf-8?B?NDRpYjFNdnV6cE5SUlBZUkw4ZitMTUhURW50a0ZEY1QyM2NyWGxMbjZBNWJZ?=
 =?utf-8?B?NlpTMGVHYnI1K0Y1UFBTSDNwTXZQSC93Y3Rrd2RpUHFUMGx2emxmeWtNZ3dX?=
 =?utf-8?B?U3AzdmQwNUdKRG1ncVE4WVlIdU5vcVgwNUlGTHB3WGs0bU5ZUFlnOGltY2JW?=
 =?utf-8?B?ZnpNOVJ4MitxVENvZ3hSbzcrSE1IUThLeitaVUpoQ1oxUUxaQnJiMmRBUHFW?=
 =?utf-8?B?NE00TFlEWnVmNUJwRmoyNDYwTStES3orNEhIVi9GV28rVjl1YTNpeEFuNUlK?=
 =?utf-8?B?VnFYRVIvTjR3VUpKbTFIOUlyQWpNaklIenAvQXd4WU85ZU1Gb0NCUldOV0Ft?=
 =?utf-8?B?NVIxYnZ1MW16TFlRcmc0My94QzYvWWpyRGFPeE4xUTJRb2FDSmR3bXI1dkJ4?=
 =?utf-8?B?dkFMTGRybncvL2ZBOW9MTDdrM3kyVStXbUpoSWJnWGRZOEc2TjJnZmFJcU5R?=
 =?utf-8?B?dm9hck0zUWdBOFRzWGxPQ3UzVC9VbGMydno2bitHRmN2UjNxdUJnd1lKQWZy?=
 =?utf-8?Q?lJlonHEw2wlb9AJk=3D?=
X-Exchange-RoutingPolicyChecked: 4mA2NCwEiq6RyEAddKaQCHqvfxGyJ8OtJ2jPV+RgJ3YAJe2byPrstCW8KfW+PM77RiNrpIC0qxnu8zcAgnIRM1edRBqEHbUW0QCLZgKtISGbcTxkA9M5qQK7U14T9j55DgjQeMLeDwneunYxCosmFe79X8K76ry3h/d4ny5++Mjqd7Niw5iwLJlQv1mFjyv0F/UHGluC5klyql5Sfp+Q8IeUKqwQ/gNyvGRSJcMb+aMwluv3O7NIewPnP73LWle8yVm2B7vaMNkQvhA2Y8e6zFkSuu2B+OWMrAVWT07RCjkS2lP+J8TeFcLFV5HQUQZe80dq4tpViq3RecGl7KDHAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ca76ad-5a4e-4ab3-87b0-08df2eddc827
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:10:19.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az8XRb22UwsqB3fr9AtoCQYSAu/lyl6+lcHik0yZv3pSjAAdlNj4DchwIqw8PfAwOLWTUkuQGEphkReTrTqAL5Jy4+CpdQ5lWD6+TT5cihs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com

On 10/12/2026 1:29 AM, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() all
> check that the VF is ready for configuration, take vf->cfg_lock and then
> call ice_reset_vf() to push the new setting into hardware. The result of
> ice_reset_vf() is not looked at, and it could not be: it returns 0 both
> when the reset ran and when it bailed out because the VF is disabled.
> 
> The check runs before the lock is taken, so a reset can disable the VF
> in between. ice_reset_all_vfs() raises ICE_VF_DIS in pf->state before it
> walks the VF table, rebuilds every VSI and clears the bit again. An
> ndo_set_vf_mac() that passed ice_check_vf_ready_for_cfg() just before
> that then waits for cfg_lock, stores the new address in vf->dev_lan_addr
> and vf->hw_lan_addr and calls ice_reset_vf(), which sees the VF
> disabled, stops its queues and returns 0 without reprogramming anything.
> __ice_set_vf_mac() reports success, so ip link and the devlink port
> function now show a MAC address the hardware never got, and the switch
> keeps enforcing the previous one until something else resets the VF.
> 
> ice_set_vf_trust() and ice_set_vf_port_vlan() have the same shape: the
> port VLAN lands in vf->port_vlan_info and the trust flag in vf->trusted
> before the reset is skipped.
> 
> Re-check ice_is_vf_disabled() once cfg_lock is held and fail with
> -EINVAL, the same code ice_check_vf_ready_for_cfg() returns for a
> disabled VF. The VF is being reset or removed at that point, so the
> caller should retry rather than be told the setting is in place.
> Changing what ice_reset_vf() returns on that path is not an option, too
> many callers rely on it meaning "nothing to do".
> 
> The race was found by code inspection of the ndo VF handlers, it was not
> reproduced at runtime and no error message was observed.
> 
Hm. My recollection is that we should set something on the PF side that
stores the new address so that the VF would get that value when next
configured.. But I guess that isn't how ice works.

Why not just move ice_check_vf_ready_for_cfg() inside the mutex though?
