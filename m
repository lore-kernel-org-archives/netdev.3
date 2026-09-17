Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878C15172ED
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663125; cv=fail; b=ixtyGh5WcQl+FtYbXSvxE+7bx0n16uSfBI8rWUPGk28iiV8NEz+m16HPsDPvw7ACaprdplNEP2KtqjjHUz2JOxzrU6HHyKSr+5qXHFhtgnF+lxEltmLnKDhvw/XjfN0vdBsKCjIEcN89XkBWMPaVBN0k5zQrxq+SypTlG+XoBQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663125; c=relaxed/simple;
	bh=/5rdsqKnrbgEgavhQoSaNHRE1ygCdGaCSEhtzx1y6mk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sbXdzj+ogxlAuoEGvfP0yyPhO1rX7ZL/26gh/fh/c5TBwRnP6nFfPI9CX9QISC6t/FixHvg4sjKj1Z/S5fKzUbLsnhnieN3MBh8KcFjZbGizavMfKEH/PN8U6w4VWz3xy1puOqHB47moTq71rKPY7afn2IdJQGP/A2kF7leJDiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlMi2WSF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlMi2WSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789663123; x=1821199123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/5rdsqKnrbgEgavhQoSaNHRE1ygCdGaCSEhtzx1y6mk=;
  b=AlMi2WSF4kcv/4W4fpa8DvzwyziuPQ96SARq3jnNluql7EMd0jsxX0+m
   x9PdwacOFbmz0fS2KBn6GVSrWH4ybaangZMdJSwaO8wutqLtl7l3X1zgS
   JOyLXE0tkgN5QWi7+NDHtQ3kvPGWQIZOTa28kh3xYHFrr+4n25k2k725a
   JHkFrq0w0zNtYmeQ1KrcqHHuJFkGMprnJoxev/2gjJUFufhnOYn8pTt5Y
   2Ow0qqGeenU7DlxWjrFe3q8sWI+yFle+s5R4hnQzMRf7oHQQpOF+9LydX
   uO0p3o2vpi41dumzLJd4paifvlboDlou1Vt6I6ikTAZMpQ5/NXxRZLngO
   A==;
X-CSE-ConnectionGUID: gMXqcZlmSoqKNgpWgIT9LA==
X-CSE-MsgGUID: ENpUz9nwSLSyJTRX+NrGFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93937685"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93937685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:38:42 -0700
X-CSE-ConnectionGUID: s4PS7mOlSo2JbKFPY4PEqg==
X-CSE-MsgGUID: oCDQ6/8IRhKiXo+r9ra5uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297388539"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:38:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:38:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:38:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2sw+f7k0CQjFlFI/DJAOQDsa7WddFdX4r207mOIhaaRdYGqrEmxbKD8RDHD9wXfl5OgbSIoJ4Zl2h/qP5oSfK9HfsTVb7gE9Z31X0kw6uA5l0oqYYVWsZaSUreOD2aDER8Pmlxsb3BBrxgYrOZCy7bRaRZ/MeKG6BQvfOp3LOemqMPnPZ1sHi0fm/vIisRVGJn44tMv6VGwMhVmRdc/UP7LkCc0PgMSMloFXUuUGsOqcKHocuFA4MkMNaXJbapnNP/XPD2dUdb+mjzbdCoOIFkzUnW8RfzoIH2g+QYspvz/TmKCGGvLbbI4jCcoYq4WJEQt/cwrNTUUlsEtDZzYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKWySMWPC2i9qhnzC8wFgMaPICkzOgJ/IWIDE+k5ryo=;
 b=hrb5pdRzUe556Ce1VhusemJm8OJxp1lmxldI6+DPIKiTAWtrWAbZovdpAWLbRSWuS0TEzxxojqFRfzf93sVEt+cWrJNCPSj/XLvNON/kxx8B97IEaSmCWGh177rNKM11dlK3e+qNjkc0NnunbiBEpaIwxCi+WkfyVVz/+z2xjwi+Wm1adZg3CHxKyxME5fn+CYyWKkTS+/gr4l4DiDqPyO8oDOdj0/9t5kR/jy61KHE7iXmb62nR9104SZDgmqVkKIU2QI81asuD165o0pnAEwYnsqC9QgJgyJd6ZPSgzO2BvV7OMGYoAjAFNSGWoBtuzQR9TgHmozZlBUja1ABIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:38:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:38:02 +0000
Message-ID: <6dab0fa8-46da-4655-a96e-9f3d8c83e604@intel.com>
Date: Thu, 17 Sep 2026 09:37:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/15] ice: call PTP link change only from link events
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-7-anthony.l.nguyen@intel.com>
 <20260916011218.1632528-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011218.1632528-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:303:dc::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f782f42-d309-48da-c6ff-08df14da0a25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|10067099003|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: im4BPkZoGQQV4CxEmPpgkyvonR+Jg9K9BfsBfGxRCctQwR6QXWB8fADPBMYgK11PU6GbAVF5YyLXRxAmzORvxLMqXvsZWRvJDQ9AQjS+ExN5bKGhjHLfuF0fI+3gCNQQUfvsedhQUWpStf10dLfHpLumQsTfcyxgf2NRgsgxh7wZqlCpauqsFlOJ4ORBWxEGO7H951om/e87/6QlhcG3mS3U9mXnNr+Fj7gdtkqM5/1njfx6sx4Rm0R5wngXJVJ4CLdaChuh/GHKJSJW+5i9iV/7JqFITMtgNKFGcctclxlJnMxyWKtoezw5MjzOEoT0UIckImOoIk4v67k0hoRK7f+P53+riigrxhUFK0yC3pO6v8znUuL6hEApfC2zhfRkrL4aON4kypCE8ef8ZzAO8NuVGo9oDM5ckoEMKrzgIs5HPrSxKlerUaWfPDUyDxRuzHnefUtCLdCU+MPlmX0rYj9a+B7h2dAXKqQ3vTlL/ARcAMPxerm6bnsnvNi/npUvjSvvIN/oDoOxBMCUTl3dUsskFR+BE4PjYdKJxspJDgTHDfpZ2egvEWTMvWgUsoDzGKr5ow3KDGpyxFqFN4OsVFoHTv05otneqtkeipLfPBzSy1SZGNcYSRj+wB8ScGg1A7SLthz0kBXc6OnM+oBZEIRbRZRQvt7O5fJqaAcEUb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWtlYTA3eFo2dFNzOVhkVTR5bmRFVGVKdFVVVmdhVHcwYjFjTTdoZmNBVk51?=
 =?utf-8?B?NFZRSmcwb1NJRDlKb2k3N2ZKNVZGMEFSNWhrTEFlK2FpUmIvYmI1V2Q2OGIy?=
 =?utf-8?B?dkVFZ0ZUTm8xaTc3dHltWEEwWTAwZ0U0TFNySXdVcXprdzZkZGZqTVdLRUty?=
 =?utf-8?B?WG11ZitpUlJQSGx1ZzkxY2YxOW1NNDFBa1ljeDJ0bFRYR1htV3FZdUsvRFpp?=
 =?utf-8?B?dTlvMXZtVXp6OHY4bDZpSi9GOU4wQzhRVmd3TFFMelByZnM5SnhvRGNzUzNo?=
 =?utf-8?B?cW5RYkcxOXlTZXB4NjJDaW1VdEYwYVdyMDUzZnVUQzgzZWpTcTFVRlVLMmVV?=
 =?utf-8?B?R2FyOW95YllncU9sbzlWY3ljZkN6QzRRV3ZMYVJoODB0emhxb1cxTkx3YlAr?=
 =?utf-8?B?ZDcxV25KQVhCQ1czM2Q4YjFJS2FWTFhFNmVoait3NFNtQVI0eU9KMm95N2Zv?=
 =?utf-8?B?K1VxUDk1S25EQVc3RmZidzVSUlpFMXFlc1h5Z0dTRE5qcDRkNjBLTUp4TzdW?=
 =?utf-8?B?V2ZxWGdRbU1DK3FLVFVIVG4rOE1FamtxWTM2TmVxNXhmWjloSTZZMlpwcTV1?=
 =?utf-8?B?Z2g5SXpqenI1T1VKaDd3d1pmZTYzM3Z2bjBFU0t2bDdkSXdEbVlEaVNLOEJB?=
 =?utf-8?B?VTlCaDI4TFNZTXh6eEt2UVJSNlpEK1Q0K3JmRS9uRXJGWE1lOEFUN2hNTkZl?=
 =?utf-8?B?U2pRMDNpZWk2VWhGUnZHVzV5VHFxaEY5SzlhYjhCREt2NXRSaHgvVjNpcTZ2?=
 =?utf-8?B?d3ROQ0dFQ0xhRWhlOXUrOStkU1dDQkoxSFNyUkE1VzdHUnQ5YkV4NWx3TzFn?=
 =?utf-8?B?U2NLZXpXL2N4b0wwd1JnVGFJQjhoNkNjNEcvcXJuaVE0WE9QYVRqa1l4SlB1?=
 =?utf-8?B?TDNXMFdWU2dSUVF5cFhPNEVPamxtOGhicXBuOXFQbnN5Rm5URGlGb3c5ZjdI?=
 =?utf-8?B?dm42M3FOYndOQnlDeExNTjB6V3BJWUloNFFIakdOdlNtRWx5UUY3alhiSUtM?=
 =?utf-8?B?SGV4NmZyRVh4YzlEdEVzRVNmZlY0SUJWVkcwbUgrOXRaVlB0WEloVm5PL3Fx?=
 =?utf-8?B?OWUzb1Zmc3FUR1NzSnczWVJPdG94V0JEV1ZselczS3M5akM3RkcwUURUZzI3?=
 =?utf-8?B?WEdHUkJsWG40NWM4QTZnN2xSMkZvZlAyZ0kxMllPVndSMmZJQzMyM0t0b0tr?=
 =?utf-8?B?ZFF4dlJrTW9uVFBmV2RxaVFnZGZmRFBmdnJtbWptclAycWlWOWtYZEViaWFJ?=
 =?utf-8?B?M0Y2dlJIR1FWK2RSSGFZczNIWHNsRUFEZkhtaTR3bWN0eFNvOFJLVE94OE1S?=
 =?utf-8?B?Z1ZwcGhzQjRMcmN0QkRubDNyUDFsQTNTU3dXNWhyOGk1ZmtEdWE3Z3FJK3g4?=
 =?utf-8?B?bTFRZWJGeXVxa3Z1M2VPNy9CTkRYWVJ4TkU5RXZsYWFobmtZc3RIUndJUHFJ?=
 =?utf-8?B?Z3dGSjVjWmtyNjV4TnZSUGtxN3QrNXJaSUJXWS9qVDNaVFpZVzJKbmplakMw?=
 =?utf-8?B?OEFXWGRsK1YwVTZiZW9LU3pSamV5ak1mNlpvWjgwdVVHMVVwV0tWQjU0bm16?=
 =?utf-8?B?VFZLVExtd1hmOVIwcFJmNlVkaS9ZZTZ2VElXZytKZHhmcTFBZnBPNzlGN2xW?=
 =?utf-8?B?ZG5lR3pPaDNmTG1YTEFJajRyblBVMzI5eGdnNjBwckNYc1c4VGRYaEl0ZzNZ?=
 =?utf-8?B?dVFHVUNIUXo0aHoyTWZQM3RKR0Ixa1dndHhxMXR2K3g4QXhoUFVGR0k1Qy92?=
 =?utf-8?B?R3pHSDROUGNzN1V1WXdWU2ZRZzNnTERqOEM0eXowakl5VnVYZmo0S2t3Kyta?=
 =?utf-8?B?QmtBS0l2aWRZR1RqWUhPbXQ3MTlVQnN3cVBub1E3WHVoTUZManJOUHJXa0hV?=
 =?utf-8?B?Y0dSbW04VVBSOEh4ZkJJUmJab0R3ZVFSam9FU3VYYXY5VmVaSEN6WCtkNVlR?=
 =?utf-8?B?aTJHSGdBUjcyUE0ydW1McGxZZVlEejdGd3hsUnFFVmhGMzZCaER3eWZ3djlO?=
 =?utf-8?B?LzlpT1c4WFBOVUdrS2U4QXZnYW1oOGQyTUNDVHN3NnA5WE44ak5BKzBTTnpq?=
 =?utf-8?B?S1hrVHJqMERTUWtkRVdPNmYvcGlmSTRXTDFxc1JXRWF5dm1nWlRXZ0tWRGxs?=
 =?utf-8?B?d05EVlBHdGlLQW1wQ1hrc2ZtMm9nWXN2d3RkejZic1JHS1FYZllaTXEvMDFQ?=
 =?utf-8?B?RGoyQjUxWGlFK3UrSnVSd0pYbHNFRmh3THo1KzJrK0pwalMyWUM1LytvOU0z?=
 =?utf-8?B?Q0FROVJxdFY1MW1iemJwTkxkUHgzZFpVazZacWhCWENjVmp1TlRNM2FoL0Fz?=
 =?utf-8?B?V09wRGU3YjZUT0ozN0c3WDh3MkJldWhJMUdDUWhsZHl3WGJFTVIwL2NOQXkv?=
 =?utf-8?Q?b6Ma8xBeT7PdbkFE=3D?=
X-Exchange-RoutingPolicyChecked: PGftMESUED8izuRZR6j2wJGnRYdgztf88j+X605AGt7xQ0TFePJYlwGcLUdOT7l2TwivyWkLOkvwXV3OQcTyCsfqwcoDS18Wm28cF5l5UhAW+N1wI8UDm3XWsbVjpfE8e9cwmqgr+YcH/fHjIQwKM2/AgohdazqU8EPALgD00jFNTqdv8xHJQDUQLzgOJU5jDrTmGJ/nW9VRX5FG6MLLPcPs0BjWo8bYV0/E0A2EMltfxESMD5FRZlGj5/XggL6XrhrN5rrBRjs4gHiSRHB/85CiEdWMAG9izuxaQ5Jkc92+KxmBYHouM9T7jnMDkNkclNWuUvqfun+BVdl6L12T+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f782f42-d309-48da-c6ff-08df14da0a25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:38:01.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYR2uATZ1y2g4hWZVDyiJdF5FTl1ceINw7/ZJ3ACcvcPRd8Dc+GADVN6Gsa1tn0w+es/xfNdJdwOIP5noiwls2MQGUkSUlXFD3DFCVnDg84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: call PTP link change only from link events
> 
> The patch drops the ice_ptp_link_change() calls from ice_up_complete() and
> ice_down() so that only the admin queue link event handler drives PTP link
> state, seeds ptp_port->link_up during ice_ptp_init(), and re-checks the link
> state at the end of ice_rebuild(). The PTP kworker creation is also moved
> earlier in ice_ptp_init(), with the periodic work queued only once the state
> is ICE_PTP_READY.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d88835482d3aa..f32041dd8b274 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> 
> [ ... ]
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
> [ ... ]
> 
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
> [Severity: High]
> Does this re-create, in the reset path, the same double PHY
> re-initialization that the changelog describes as problem 1?
> 
> With the ice_ptp_link_change(vsi->back, false) call gone from ice_down(),
> nothing clears ptp_port->link_up during reset preparation.  The only
> remaining writers of that field are the store in ice_ptp_link_change() and
> the new seed in ice_ptp_init().
> 
> ice_prepare_for_reset() calls ice_pf_dis_all_vsi() -> ice_down() before
> ice_ptp_prepare_for_reset(), so previously link_up was cleared while the
> state was still ICE_PTP_READY and the local port was skipped here:
> 
> ice_ptp_restart_all_phy()
> 	if (port->link_up)
> 		ice_ptp_port_phy_restart(port);
> 
> Now link_up survives the reset, so ice_rebuild() -> ice_ptp_rebuild() ->
> ice_ptp_rebuild_owner() -> ice_ptp_restart_all_phy() does a real restart of
> the local port, and then the block added above calls
> ice_ptp_link_change(pf, true), which re-enters ice_ptp_port_phy_restart() a
> second time within the same ice_rebuild().
> 
> For ICE_MAC_GENERIC that second entry does:
> 
> ice_ptp_port_phy_restart()
> 	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 	...
> 	ptp_port->tx.calibrating = true;
> 	...
> 	err = ice_start_phy_timer_e82x(hw, port);
> 
> which cancels the offset verification work queued milliseconds earlier by
> the first restart, re-asserts calibrating and restarts the timer.  On
> ICE_MAC_GENERIC_3K_E825 it re-runs ice_start_phy_timer_eth56g(), i.e. a PHY
> soft reset, timer stop, incval reprogram, PHC resync and clearing/setting of
> the offset-ready bits.
> 
> Neither guard in ice_ptp_link_change() short-circuits this call:
> ice_reset_subtask() clears pf->hw.reset_ongoing right before ice_rebuild(),
> and ice_ptp_rebuild() has already set the state to ICE_PTP_READY earlier in
> ice_rebuild().
> 
> One more question on the same block: ice_ptp_link_change() discards the
> return value of ice_ptp_port_phy_restart(), and the E825 restart begins by
> stopping the timer.  If the redundant second attempt fails, can it leave a
> previously working PHY timer stopped, at a point where
> ice_update_pf_netdev_link() has already turned the carrier on and woken the
> Tx queues?
> 
> Would it be cleaner to have exactly one driver of the post-reset PHY
> restart, either ice_ptp_restart_all_phy() or this new block, rather than
> both?
> 

Yes, but I think there is some question of ordering that is tricky. For
a single port PFR, we have to restart the PHY timer for that port. But
for a larger reset we have to make sure we restart the timers after the
clock owner finishes.

Perhaps we can guard so that on a PFR the port is responsible but on any
higher reset (where the clock owner must reset the whole MAC timer) then
the clock owner is responsible.

>>  	/* tell the firmware we are up */
>>  	err = ice_send_version(pf);
>>  	if (err) {
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 9bf3bac552f11..4dec728e219d8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1323,9 +1323,6 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	struct ice_ptp_port *ptp_port;
>>  	struct ice_hw *hw = &pf->hw;
>>  
>> -	if (pf->ptp.state != ICE_PTP_READY)
>> -		return;
>> -
>>  	ptp_port = &pf->ptp.port;
>>  
>>  	if (!kref_get_unless_zero(&ptp_port->ref))
>> @@ -1334,6 +1331,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	/* Update cached link status for this port immediately */
>>  	ptp_port->link_up = linkup;
>>  
>> +	if (pf->ptp.state != ICE_PTP_READY)
>> +		goto exit_kref_put;
>> +
> 
> [Severity: High]
> Can moving the state check below the store make a half-initialized port
> visible to ice_ptp_restart_all_phy()?
> 
> ice_ptp_setup_pf() publishes the port before the rest of PTP init runs:
> 
> 	kref_init(&ptp->port.ref);
> 
> 	spin_lock(&pf->adapter->ports.lock);
> 	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
> 	spin_unlock(&pf->adapter->ports.lock);
> 
> After that, and while pf->ptp.state is still ICE_PTP_INITIALIZING, a link
> event reaching ice_ptp_link_change() now sets ptp_port->link_up = true
> before returning.  At that point ice_ptp_init_port() may not yet have run
> mutex_init(&ptp_port->ps_lock) or spin_lock_init(&tx->lock), and
> pf->ptp.kworker is still NULL.
> 
> ice_ptp_restart_all_phy() gates only on the kref and the cached flag:
> 
> 		if (!kref_get_unless_zero(&port->ref))
> 			continue;
> 		rcu_read_unlock();
> 
> 		if (port->link_up)
> 			ice_ptp_port_phy_restart(port);
> 
> and it is reachable from ice_ptp_settime64(), which does no ptp->state check
> and ends with:
> 
> 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> 	if (hw->mac_type == ICE_MAC_GENERIC)
> 		ice_ptp_restart_all_phy(pf);
> 
> The PHC character device already exists at that point, because
> ice_ptp_init_owner() -> ice_ptp_create_clock() runs earlier in
> ice_ptp_init(), so a clock_settime() on the owner PF, or a reset of the
> owner PF concurrent with the probe of a peer PF, can reach it.
> 
> On ICE_MAC_GENERIC the restart then does:
> 
> 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
> 					   0);
> 
> with pf->ptp.kworker == NULL, and kthread_queue_delayed_work() starts with
> raw_spin_lock_irqsave(&worker->lock, flags).
> 
> Before this patch link_up stayed false for the whole of ice_ptp_init()
> because ice_ptp_link_change() returned before the store while the state was
> not READY, so the port->link_up guard skipped the initializing port.  Should
> link_up only be published after the kworker exists and after the port locks
> are initialized?

Hmm.. Need to investigate :\

> 
>>  	/* Skip HW writes if reset is in progress */
>>  	if (pf->hw.reset_ongoing)
>>  		goto exit_kref_put;
> 
> [ ... ]
> 
>> @@ -3443,6 +3444,22 @@ void ice_ptp_init(struct ice_pf *pf)
>>  	if (err)
>>  		goto err_clean_pf;
>>  
>> +	/* Seed link_up from current PHY status, since link may already be up
>> +	 * (e.g. after PXE boot) with no link-change edge to catch it later.
>> +	 */
>> +	if (pf->hw.port_info)
>> +		ptp->port.link_up =
>> +			!!(pf->hw.port_info->phy.link_info.link_info &
>> +			ICE_AQ_LINK_UP);
> 
> [Severity: Medium]
> Is ptp_port->link_up now written from two contexts without any
> synchronization?
> 
> This seed runs on the probe thread, while ice_ptp_link_change() writes the
> same plain bool from the service task via the admin queue link event
> handler, and after this patch that store happens before the ICE_PTP_READY
> bail-out.  ice_init() clears ICE_SERVICE_DIS and arms pf->serv_tmr before
> ice_init_features() calls ice_ptp_init(), so both writers can run
> concurrently.
> 
> There is no lock, and no WRITE_ONCE/READ_ONCE pairing, between the probe
> thread's read of phy.link_info and its store to link_up, so a link
> transition processed inside that window is silently dropped.
> 
> Link events are edge triggered:
> 
> ice_link_event()
> 	if (link_up == old_link && link_speed == old_link_speed)
> 		return 0;
> 
> so if the surviving value is false while the link is physically up,
> ice_ptp_reset_phy_timestamping() -> ice_ptp_port_phy_restart() takes:
> 
> 	if (!ptp_port->link_up)
> 		return ice_ptp_port_phy_stop(ptp_port);
> 
> and nothing later corrects it.  On E82x the vernier timer would then never
> be started and timestamping would stay off until the link physically
> toggles.  Note also that ice_ptp_port_phy_restart() reads link_up before
> taking ptp_port->ps_lock, so ps_lock does not cover this field.
> 

Would READ_ONCE/WRITE_ONCE be sufficient here?

>> +
>> +	/* Create the kworker before restarting the PHY, which queues work on
>> +	 * it in the E82x restart path. This prevents concurrent link events
>> +	 * from reaching ice_ptp_port_phy_restart() while kworker is still NULL
>> +	 */
>> +	err = ice_ptp_init_work(pf, ptp);
>> +	if (err)
>> +		goto err_clean_pf;
>> +
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but since the unwind path is
> being reshuffled here, should err_clean_pf also release the Tx timestamp
> tracker?
> 
> By the time this new goto err_clean_pf can be taken, ice_ptp_init_port() ->
> ice_ptp_init_tx()/ice_ptp_init_tx_e82x() -> ice_ptp_alloc_tx_tracker() has
> already allocated:
> 
> 	tstamps = kzalloc_objs(*tstamps, tx->len);
> 	in_use = bitmap_zalloc(tx->len, GFP_KERNEL);
> 	stale = bitmap_zalloc(tx->len, GFP_KERNEL);
> 
> but the unwind only does:
> 
> err_clean_pf:
> 	mutex_destroy(&ptp->port.ps_lock);
> 	ice_ptp_cleanup_pf(pf);
> 
> ice_ptp_cleanup_pf() only unlinks the port from the adapter list and drops
> the kref, and err_exit then sets ptp->state = ICE_PTP_UNINIT, which makes
> ice_ptp_release() return at its first check, so
> ice_ptp_release_tx_tracker() never runs.  The same leak existed on the old
> err_exit path when ice_ptp_init_work() failed, so this predates the patch;
> the trigger is a kthread_run_worker() failure in ice_ptp_init_work().
> 

Yes, I think this is the same fix to several of the problems mentioned
in the other patches in this series.

>>  	/* Start the PHY timestamping block */
>>  	ice_ptp_reset_phy_timestamping(pf);
>>  
>> @@ -3451,9 +3468,10 @@ void ice_ptp_init(struct ice_pf *pf)
>>  
>>  	ptp->state = ICE_PTP_READY;
>>  
>> -	err = ice_ptp_init_work(pf, ptp);
>> -	if (err)
>> -		goto err_exit;
>> +	/* Start periodic work only after the state is READY; the worker
>> +	 * returns without rescheduling while the state is not READY.
>> +	 */
>> +	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
>>  
>>  	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
>>  	return;

