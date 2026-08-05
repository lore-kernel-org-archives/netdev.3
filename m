Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AB3CFF7F;
	Wed,  5 Aug 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951020; cv=fail; b=JvpNLmaqIHaz87ZZIXICw2GbPpGgXlBlaons80Kzg1iWMnXFVAZDiK/jM1hyOwNeSQahN3K9DutM9lYqs86Ago7uf4N8kj5Xim7gbLywNQQ5Ms2AihJlsTDZq6h3cyzKKXa3jmn5cPfBnL15NIy/JyHmjVjHunCmcpgucABnkJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951020; c=relaxed/simple;
	bh=H9dvtfVuR+LwqEAsO3tAdVkfr5EcXfqan7SrvRb+rq0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnqTBf1/R51tJg7FIzGl0oRGb6BOu/QL7RC8JOK8hDW+PgUNNXXywD7d08tV0KMVI53J+Qu2zxIYFKNZ92EKuuO4JGh9yq2ddLRctt7FiXrVgrV+a16nkkCkiVhiFp8ZTv2F+IVvYwl6jY4HNEDhMGceCpU1IVQTZctebKjrKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDsyNzyO; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDsyNzyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785951019; x=1817487019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H9dvtfVuR+LwqEAsO3tAdVkfr5EcXfqan7SrvRb+rq0=;
  b=VDsyNzyOzBbPF9CsvagJgJvv2N/jpv6/WyAByFTdwsGno9bcyLjU2W5I
   J9ZIUT5AOq/2nFWmo8BCnBF/yXp6A9+WCu8kDoMlM5T09cuYKxykbYRoN
   mDHOGxv94Htw3v9dZdaKQorBBkoqSOScQp8f1C8I6tTqwrxox5p4G+duK
   tZUAfg8qbkd2rwrKyE/03T8dkR1x7iuKz022xD7+gtmJnL+RQelpoPwiQ
   raOXs+qPzAAAamr4QxrXG5mXi37bhq+xnyq1dvqrY4aJtwy3buvE+EcSg
   qhUhbCgClY7piUuw1oxRadiNlb1DFzZHwydopijLi5YehWf6xOcisoxN6
   A==;
X-CSE-ConnectionGUID: WFrXm/T5QHiN8j2Ypq4pqQ==
X-CSE-MsgGUID: uH67WBWVQ2i0eK3LB8eoSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90415740"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="90415740"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:30:18 -0700
X-CSE-ConnectionGUID: iXgsbzn/QOqxJjQ2upQe8w==
X-CSE-MsgGUID: S4PajeSMRDy/QP0IPY5QsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="263849205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:30:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:30:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 10:30:17 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 10:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiaphtQ9KIKdqOLlIfIpwX8Roo9Fg1XcMmxyc8ZqsQsICpTuG8nh2saZjHhGYpHo9pr8VkHh/3WfLrqeEZI3duzvL/lrcfO1LGsTqfW8CD2dhaVv4X+D7ZgnzHJHXDfRbuzfC7b7LjM1tKPxD3kjuVCPG8v1EOz8r6Ur3lh4bPrWbJjcNiwnZYsJTo51SNUz/tKN0yMwK35FsEDn/qbDhAYlXDHuG9dBCpuRZDZ651W2l04585qh+E7/kT3TmC7TrgeTF59Lz3BHrmQZ+tktWjx26p0bVwiypUpjnr7wJhJBoOJCDuFrTDhAERBxoSW6NwezNg5bRfqcwpf1SGV3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WgyVWWW6w/EklP8v4zGF3J01LIz2gnhBMtvxiCWSHY=;
 b=fIyu08huumSwedGDk8HGn0OpewBD0mJHPTPvWFOmDPq7BXmDe0EbMTQTLtLs4iLYxth3Xh/Tr70ARL0BQX8b1QB+OPzxNaIFu2i6OaTifPYIf77v5d+uEv3RyKYu84IR5dIZCVjLW2uAGyUHS4IFE/Nr1bJLaZM888k2KfPTR4ZEbCXJwz6irN8oCNstiAapBFi/aemkpvFmAebKbjx/T9KYoxjAjTVH4BmCECoTIrOdcTnvYtC0Xp5vFB3nYegx9EA0SvN51Jx2VZaC+2uJZnulYplLR9HhipZCp4znBy787moZJwupSmNnRSjE+ET5ILrIUUFSf1qKFh9Ek2vbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB5198.namprd11.prod.outlook.com (2603:10b6:a03:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 17:30:13 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 17:30:13 +0000
Message-ID: <936c428d-9a6c-46d9-999a-08fc36d4177f@intel.com>
Date: Wed, 5 Aug 2026 10:30:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/15][pull request] Introduce iXD driver
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <larysa.zaremba@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
References: <20260804031638.1531994-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260804031638.1531994-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: e3de449a-db67-4321-88fc-08def3173508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|11063799006|5023799004|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mYy5qIgu0lzMAnb5nNjTylda7rjW4OWZEBdXjIOpgrGgriAnnJIjyW6gCATkM+Xkn1VhXchzgFKcbH4g/184OZrLENb97a9pwg6Sq1Bz+JKewLsc5yNjsPya5w7o3ltURYY+uakV9oTfMZ9ShXPJ9ul0OwxBKdzRdUnaOa33npGXOYNiA7cHfJEPn4qJPsK/+AE2ZsB9K4WQkFLmnJX46O2GeutsJW0irSsGjuMnW+rHkS6VzdaH4D/dDKaMzraiSqCCsQIDFamHsL6FhDwOjjGwzmiHHtpNTm3I3sQXnCVuh+BH4pd7eSJe3XVG/0f/6bDsTr9tmorEqmk7pq6I4sWEBFG/GQbR2iTYRuWesjzsOeEC8i7hqfZaWXWEEYArfVbYvDXZWwMo42jtcLeF3Y6F5VyoizUZKoKiJZR/LoMs5HB71Xrg/Hk3hIw6JWfCDEwAr/fYDNQYmrdT6GwMUbvk00QjTY5ZV1ghuobJW+J+er8WJTVCF/ZoFf80LckckFYSP6+aRFGWqhILE4xSvb4d2nvH7yG0aDSVHP0lXzuL8qh6ad4ej3iw8ht5SbZEZj1JXI246N5WtGeMHmT1HnL0f3I2fDxyjRuhXTvEY0nQAxDQd/ShoPYTghYJ1SrLCeQeFGOAX5mP9RGGfKbha8GU4zU5Bofnwh/t4CMmd/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZiSVVPYXFyZ2FSNzV1WVpycXNNNEltOWxnTVpwWW9kWDc5VkVxNjMvY29W?=
 =?utf-8?B?OXhFQVVGVDVPc0M0ZDB4S0NJSG1XaW9wSXpyZEhmcFJ0ZXBvTVI1VjFHTElH?=
 =?utf-8?B?YXdiQTBNK1hLQnhEbnBSOEN0aVJ6VGtCbXB2TUdPaXp0aTc0VEt5U0EwT1Er?=
 =?utf-8?B?SlVORlNVM3F5RnQwb3M3bFNmeFZweUxCN010Z0ExclR4MjJWUmo3L3RCaWxT?=
 =?utf-8?B?cnBvMkJZWWhGUVpGdG5DRXM5Y29NZ1pUbDNzNExnQ1ZJWlBCb3JoNlJrU0I0?=
 =?utf-8?B?bEVHYkFjWCtpUi90WVRET2RBZ0tRci8yZmVrb29ic1Y1dE9VMzFjYlFDblRZ?=
 =?utf-8?B?WkQwdVkydTJNM3hNZTRrMGRzNzNpTFljWkE0MjlvWm00S2VBQzlUdEtDNjgw?=
 =?utf-8?B?Y3g5Z2hpQXh0L3dza2hmbk5NcHlqSTBqcENEbW8xcnZ0KzVXNklvQi9NcWNk?=
 =?utf-8?B?N2hhclM4Zk1ydTJHK0Z6dEExOFdoa0YyNmpSc3IwNkVrV2tKdWlVcy9iUVk4?=
 =?utf-8?B?ekNtWFFkazVwZVJuUVJOY2ltY3IvTUFzd29pcEk4Rk5pVmNnQUQ0czdGWFVw?=
 =?utf-8?B?SXM1dHlKM0RyMjRHNzlieFhBaUFoNFRoL2YyODNGVUVKL2VLVVFIc0dDMXYr?=
 =?utf-8?B?Qk91V05hZGR0MVE0SzVkMlNKZVFXK2tZRE14RE96SXJXMmVPdkEwczI5UkRB?=
 =?utf-8?B?Z21yV3lBTTUxaXV0d0NVZVBLVDZNSVhDRkJOUEpuSXZTT0NESktzNjRoWXhD?=
 =?utf-8?B?SmtOZUV1di85cmlKNHRGOW43RzF4eVlzcStFRzFlUUxUOE9ldGNNaThoTTM5?=
 =?utf-8?B?YkF3cDdxYnpERVVVT0w0Z3JqeXIxSHVJbng1Yk44Q1JjUkhGejYrcnFlSU5M?=
 =?utf-8?B?MGxEb0V6a0JMSkxnMU5jNjhiUUJvWklIVDZ1NTlrVitRcVRvc2tvcWgrUWxJ?=
 =?utf-8?B?L0hEWWlEd2d4dFUxOXYvaWVnTHd6QWpJd0d4NFJIUDlWU0M4YlozMlordCtK?=
 =?utf-8?B?Um9sUGFGSzlwb2RxQkwvVGFtWmwyT2RnMmh0bXNMOURSZzVDUk5pK1hQT2pi?=
 =?utf-8?B?b0pNOGhGMDd3YmFERVpMR1NkSzc1MzRkQ2FwRVN4dVNKUXdmNGZuMjM2cWZV?=
 =?utf-8?B?Y2gyWU1ZVmVNNlQwOWFYZEFnSVhGMEczdHdWUE1JRit6SmhodC9BU29Pb1VM?=
 =?utf-8?B?eGU2c2JZV0VWNGo0djBTdSs0T1E5Z0p5cXVDVUdCaVNRLzltOG5haXh1d0lY?=
 =?utf-8?B?aHpTZWpmZFNJTFl4RUJwMzFrTDNmN2JndnVCVVEyVVJhMmpnNHdrcVlydFVx?=
 =?utf-8?B?eUJrVW05KzhxU0w0NklJM3pEZXlCci9FZFhkRHZDRTFORVpyYXEvdS9NbGpG?=
 =?utf-8?B?anZUdk10R0ltN1c1U2p3ZmdtblBoU3Ywcytvcm5NUVpkQnlGaHU3WkZUOFE4?=
 =?utf-8?B?ckVBVVBoQlZVaXR4R0tnTlEzM1hjTEgzeUZ3aGJoUkpRY1JOZktXNTIwUmc5?=
 =?utf-8?B?VTFMR0ZPb3lRaDNrOHgrT0JlZjhOQzU1YlU3c3M2VTVaWnhFQUJrNGZIZTBm?=
 =?utf-8?B?Y1dRazUrOXJlMkJpSFl2SUhiSU00VlFNYmVOSUdWclFMY2dXVTRDL2xoVjhY?=
 =?utf-8?B?ei8xWWxrYlJzQWV5QlBtREJBQm8vckRXSVRXbXpFN1VlRmU4WjVwTXpLeVJz?=
 =?utf-8?B?VUI1aXpWUENPbXM1N0E4Tk0yaEdHZWNJWnVzUE9jZG9yVHZ6NUYwaEdkanJZ?=
 =?utf-8?B?MlQ3Z2QzNGFQSC9XdXhibnRYMXNNTlZUNXh2ZngyZzZMcVg5K0RPNnlzYWFW?=
 =?utf-8?B?UTBRblBvUXVUQStObTdITUhzb2pIdzdhUUhsd2hOaXo5Vks0OWZSeDhDaVpI?=
 =?utf-8?B?M2xwOW9TTHl6UTdvMGc0ZWtGWGkrUElQdm1kRGJaR0dCSmdYMU1YaEhmaXRn?=
 =?utf-8?B?WnRZbUpXaks2NUgydnNwU1RLdkFvUUJvU29rVmVYQVFWVncxbWFWd05NRWN0?=
 =?utf-8?B?S2xldWcxa21ZaGw0Y25vRUFVUDFyN0pBRDFLV3VQZGVhMkc1akx2RndhV2RD?=
 =?utf-8?B?QWNSYzIyem1LRlhqMGNuQkZla3FEeTJvSHNEcHlmOTU1Z1ovazlvd1Y1ZlR5?=
 =?utf-8?B?V3lVQnQ1YkdvRXBJcXZ5QnlNTTRSQzRpZFJuQWR5N2RqMXlsQ2R0anVQYTFI?=
 =?utf-8?B?NHVnL3RiU3JDR0doYUQ0UGxpbDNYQm42UytmMGp1WS8zd2drTC8vYk1FYzJK?=
 =?utf-8?B?ei9iWXVGaS9mZExUR0JPWEV1WDFLRzZKdGl3R05UcERRbXhORmVhN0F3N3Fv?=
 =?utf-8?B?d3NwZ2tjeWRoSFE4c09Ecys2cWtSSmp2dHRkb2Z2TWMyN0IwSkhDcWEvMkFn?=
 =?utf-8?Q?9hhfXDT3UmsqGWNk=3D?=
X-Exchange-RoutingPolicyChecked: XgHj3OM+6O7S6KRSo+kAAKv/IXKL7jvbNpi3fGannKvOfOfDBdGv/+KglCKoGPng2Xgtfw+eWpR7mFXmaz/r7iVdcNl6jwlYNjd6ycqAR9S2GYqAlx3E50O5afE0CQKV3lkXuRWogz0S1oswz6aO8YgHQKg2jjP6nbK6Uo/XOPoA/IXzzyXLQKwAKTYc8ysuxkh63jH7UdDGo+M6G5JlwmiqNTLSfSgvn+ZaDSOd7okdBnwULzUCuvRjdXKlxh8A9DPN5bovXYz85tNj0zDgNW5a4OmRvPLbBKDfwB/6zrqcyjuwxMefPd7hVzq784WOS7j79XfxSRb5CiOEJ8ralg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3de449a-db67-4321-88fc-08def3173508
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 17:30:13.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TC0X0iKEQgzhMb273mzkvxgDcPFyBFKHPuM5DjPc11Y1cbs+nGchQDUMwb3MPSiz8nCzK580HOZ0xE60c44qEP250yzscfst0DdDaJ0dLrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5198
X-OriginatorOrg: intel.com



On 8/3/2026 8:16 PM, Tony Nguyen wrote:
> Larysa Zaremba says:
> 
> This patch series adds the iXD driver, which supports the Intel(R)
> Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> exposed by the same card. The reason for the separation is to be able
> to offload the control plane to the host different from where the data
> plane is running.
> 
> This is the first phase in the release of this driver where we implement the
> initialization of the core PCI driver. Subsequent phases will implement
> advanced features like usage of idpf ethernet aux device, link management,
> NVM update via devlink, switchdev port representors, data and exception path,
> flow rule programming, etc.

There's one new report from Sashiko that's a possible issue and, since 
we have to do a new version, a bunch of nice to-dos so we'll be doing a 
new version.

Thanks,
Tony

pw-bot: changes-requested

> The first phase entails the following aspects:
> 
> 1. Additional libie functionalities:
> Patches 1-5 introduce additional common library API for drivers to
> communicate with the control plane through mailbox communication.
> A control queue is a hardware interface which is used by the driver
> to interact with other subsystems (like firmware). The library APIs
> allow the driver to setup and configure the control queues to send and
> receive virtchnl messages. The library has an internal bookkeeping
> (XN API) mechanism to keep track of the send messages. It supports both
> synchronous as well as asynchronous way of handling the messages. The
> library also handles the timeout internally for synchronous messages
> using events. This reduces the driver's overhead in handling the timeout
> error cases.
> 
> The current patch series supports only APIs that are needed for device
> initialization. These include APIs in the libie_pci module:
> * Allocating/freeing the DMA memory and mapping the MMIO regions for
>    BAR0, read/write APIs for drivers to access the MMIO memory
> 
> and libie_cp module:
> * Control queue initialization and configuration
> * Transport initialization for bookkeeping
> * Blocking and asynchronous mailbox transactions
> 
> Once the mailbox is initialized, the drivers can send and receive virtchnl
> messages to/from the control plane.
> 
> The modules above are not supposed to be linked with the main libie library,
> but do share the folder with it.
> 
> 2. idpf:
> Patches 6-11 refactor the idpf driver to use the libie APIs for control
> queue configuration, virtchnl transaction, device initialization
> and reset and adjust related code accordingly.
> 
> 3. ixd:
> Patches 12-15 add the ixd driver and implement multiple pieces of the
> initialization flow as follows:
> * Add the ability to load
> * A reset is issued to ensure a clean device state, followed by
>    initialization of the mailbox
> * Device capabilities:
>    As part of initialization, the driver has to determine what the device is
>    capable of (ex. max queues, vports, etc). This information is obtained from
>    the firmware and stored by the driver.
> * Enable initial support for the devlink interface


