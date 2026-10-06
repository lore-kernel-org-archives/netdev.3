Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C33B6C16;
	Tue,  6 Oct 2026 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326547; cv=fail; b=H5GG+cZ3FCFq4L3Om2wBDMTIIOhRw3bWBe/09rfQl1BnzmizZ+mk7epPYh9C2ReEhamfflr/MindzPlY+i1tmVQwvVaxFQ+GSBF0DpkgLbShTZzuBZl7NUdTeBn2kD+Vhx7lUbIpVmKJx3uSQOjr98GYA6h4C9ZoPJEg5PZMurY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326547; c=relaxed/simple;
	bh=YOWfV7TO65Ri57wbZhB+aa176zZ6iXOssl+DtJhEL9U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG0Ui71mzc9iS0+RxNq7F9BhdLxobqTQhDfMoDon1Jqd5M1yK20QpQ0dsyGsK4ycG/L1yIsYbgZnGUZlsAS9glnFsntLolRsMxqJvBmqfFF2qfCBnDFlF8DfSWlVAcYziX9ONMk6p4nNDEUW52V/UCBEbY2/oklcZM3XxSjXJhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhCrstd8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhCrstd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791326472; x=1822862472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YOWfV7TO65Ri57wbZhB+aa176zZ6iXOssl+DtJhEL9U=;
  b=DhCrstd82YFtcj9IFByYAxPlj5mWUnl3HYFOH2seSfxUdCFqxC20bhwF
   p60PFZD8Ml7g7byrCnrwoKPlTFWnmMb4xq9wm3MHZj8SVyqmALrqARUEP
   nUnziPynFu/l9XCeAkiL0V4YkaEom6Mz53wRCaHlpJMZx769aIw3EjaRI
   rKWaC9dK8FSjrv1LiCVdySAl6VUt5WaXHKbrLJCk0urzylYeRYm92bnfL
   bqk+pPnK1R5AY9mYAK2DCofWjGx9+BNtvlTDtboEghtJNNgsS0jAwufdD
   uFow+UuVo5QhBau2tpFL8r1wrjH68Ew+z5A7hmUEw5GGVApQLgXr/b6vr
   g==;
X-CSE-ConnectionGUID: n94PLoE1QEWw2P9jawPQ0g==
X-CSE-MsgGUID: ZV6LxE1aS+iqAh+qLjjoCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="109523864"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="109523864"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:41:05 -0700
X-CSE-ConnectionGUID: N/EdwpUuRaeBrgFEZ5j3ew==
X-CSE-MsgGUID: shp/hSZDRXCdi6X1rm+dMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="276387444"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:41:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:41:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 15:41:03 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:41:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkGy4tJzMJr5iDW8kkvoisDuUUwapZVxZvxZ88DbaF8jomfBKHANcQ3F9+XM4qhuBpe0zwBAGNupgRqoyUGDQ5o3FAR/Rr7T5KQzCw3hvTDT5jRfFwWO9+v0i1pM3c7xqJJpIYR9a4Xfh8UfrEcSlHP05fmfe5gpYIfpWVwUlSnifaN+mF1KUd3qJrm9EhyuA8Kvt8HdO96ujDIzPAtEgNIHXjS8Ggaq2ZpJU+Va3peD6u6h9/fDBJBahuQggdCfgh5zUQPh0RMjV57bphNhRxaJ0RfAHycGEgPr/P1TULfqJ9pf8fGcVYMqmv/McvXITMGj8b0f/v4TC7XzIYgP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25CpMwlkkO6VBJMiXQGGnQJVngHuCKoauFpqEBdzUX8=;
 b=YCvTMn9v4jz+LA9No3KLx0TOJ3WiJe/BwAJaWsp3pQaOKlSMw5f3qZoQMJNz1LGhOmZ/L/rzEsxm0hi+tVxZgI/UcMwM15Y0D4U+K8Joo6/6LQ0NNmewU9ihPENJ3DjusrUwXSBPmAeXQoE1m9yJXRUwqWSYDarKyYgwPMthujjhIRTnoR/JQiaZVpfXjhCZhwbgDhsViFGiEs/8iPk/ZSzEDCNIKuaTEv0uyLqXb7wnxg3BTLeZBlLmo5GH3jwW1SQElPlnEfjMwr1jKWRqBZI6akaN7OlSq5DKI0uZZY31yFql14t1B3ZdlrOO2szlo5SW1P9Fw0QgdCgianC8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 22:40:56 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 22:40:55 +0000
Message-ID: <1c312251-d320-4de9-9466-a196de91985e@intel.com>
Date: Tue, 6 Oct 2026 15:40:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: freescale: fix PTP_EXTTS_REQUEST2 for QorIQ
 1588
To: <vjardin@free.fr>, Yangbo Lu <yangbo.lu@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang
	<wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261006-for-upstream-qoriq-ptp-extts-flags-v1-0-b4a161b92832@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA1PR11MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7c3880-6782-407f-6816-08df23fae23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003|921020|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info: Ry64apGeeSlsicv1ExNpkpdxn4hsd42kJiABy0sMNBx2shT794p0SNHg3VhfQnh8ypmsTLcjN9z6NPkWXEWFAeopQsX9gwlDpKE7sZU1wf9BJIDCN858Ynfvg9ReaqzoDwHMpb7VapAcEM5XNWBrMOMm2nKqvyFtlVsQ72SHJabqzTYXg9bl+evUlqOZsyaq5/5OhwOerWv84R6/ksrwdiY4WcL7X8ZprDWkLTvip6tQmz3BtrqXRbb/A0qg7L4vM0xBjxBDcnTjtnKtaD+2K1n1TAYUfXSqnFJTpwxoWGC5VotexmzOn42kPzhX1C2Nb0KrJPHne0Zk+hA99RjJPyRxqoBsWZyJcWqrD34kiTEoytgwM4UsqBJtSnbANy3AVD/i1HFfYxWd2lzsns5ktT7pUt1vv5NMIe6YURPkzX55c750IgahaTDTLGeYU2US8roCEa9/rws5sny+3CSy8D6UMI1g7IRH/7vFbbWyooSi6uGEXmPs97ODMdZRpaEDYEu12Pnp40IP/mGbRKDUGf9XaXlLcQQNxZMCA0fAry1aFzGUOIOpHSrjJOz5s7pFetbHRW0gaW7LpfXDS6k9jOUViOXtSgxOzRLqKgxPTQA6EvA0/JBYfqmPd44dQM7NrH4xDUlforcOCoTFTs31QzI/s204IGykXuoW3SSnLnjzpr+YYB7MEOm3tkcU1EzUbalYyt1b++xbMwAUycvfx81McMF6cNalZdPoff86RSohJWZO55sosXrDJSgmnDImd413hLz+LYlErKpB56TqWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(921020)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJ6Mmo1Zi9KTXhIRHN6Y3JqRnpwOTFvNTlWTnF5OUszSlZWMkZBelRUVzdu?=
 =?utf-8?B?RUhsUjZ2NDViNjZNMG1iRTc3bUpXWWMvTmZ2eDhiQjN0TXo2c3owRFhLdng0?=
 =?utf-8?B?SEhMd25neVJCVHFVYkNuNTd3cGFqeklYN1U3M3FYWFliLzdUYmJta3JYdTFY?=
 =?utf-8?B?cDhpVXBQWWQvdEJBbGxhZGkzaTdYQUNUV0FDNFhWMk9GWFB1RnpWc1grWGly?=
 =?utf-8?B?bjhGK0ZDUGQrT0ovU05WYVFtMzZ4YkVlQUNKSU9UbitMM1RuUm9LWUNKVWRm?=
 =?utf-8?B?aVRia1FiRVQ2TkJKNjNTby9UMDZCZHZxT2swTUFGK0MyV3VYRTdpYUQrQU1z?=
 =?utf-8?B?aGVSNkpzQUZMUjdrRjJXc0Fsd3dWRU05K0YzM3NzaHVaSTk0ZHdQTFcyTEVr?=
 =?utf-8?B?N3JHRENPSlpOazBEQytuZmxoV1hEUWxoa2ZMZUFVSmVHMzZGeWVOMWtFZnFh?=
 =?utf-8?B?ZVFIazBISTB5SFhYTEpZUXAyUjFiN2FXdG9nTVJqZkpac0c1N2ZxTThwR3dK?=
 =?utf-8?B?YllWMG9RL2tvODA2NWd5cGFENUNmVW9aeTBJTmhOMEZONHp5SFM2cWc4ZlU2?=
 =?utf-8?B?QTZ4N2xKU3NpcytOaUtaVEh1K0duSEFyZjhLV3U5QnRvMnM4M0JSSjFTeFZD?=
 =?utf-8?B?dXFaNEMwTHRRakp6SXp3cXdRSmdHT0lWTzlOODgwYXNLdjVqM04weUVnajhK?=
 =?utf-8?B?cHpGQ29aZThYU0dXWHlkdHFKN3NtLzNvVm5tYTVXdGlPYkljdTN4Z3Nzbm83?=
 =?utf-8?B?NnNXOC9KV0p6eHJ0QlpQT1RMU1J4OE1HM0tTZjNyUUU2Z0dFeXlhcGF3SXRi?=
 =?utf-8?B?YnhuTzE4cEhIZ1UyN25SSEgyWVVnTHBXenRUSS9DQTJYRWhoYmNuYVBsNmNo?=
 =?utf-8?B?TWZhaUtiaE9FakFjZ1o2bXpENmhXQ0NPYTVwZnVjTzJ2WE1tMmpDZlZSd256?=
 =?utf-8?B?YzF1dFk5RGNtTXdQUW1ac2lzQ1gzZUVVdVB2ZEVTL1BNS04rdVJrMEJxNzhG?=
 =?utf-8?B?cmY2aHc3S3BheEp4MEtYSllnWmdhWDR4TGhMTTJaSHBPaDZQdTZhOXJYZldC?=
 =?utf-8?B?WkFRWndaRllRc2JsK3pBRENWTjR1aHFKcDM5U3FKS1NUTVRXTk90bUdGS1h0?=
 =?utf-8?B?aExPY3dmSVNxUG11OEo1Ym5qYmJUYStBMFpySTM0VlBZNXo4SU9SQmNtakF5?=
 =?utf-8?B?MWpLb1I0QUtNQURpN2daQ2RNTkErZXFzTW9DNE0yanA4Tnlrcm8ydG1TRS9Z?=
 =?utf-8?B?M0dxTTAwWnVqOHl1ZGNOQlg2WVYvT1dZaFpKK3hIbExRSTBoTm5YL1FnMk1U?=
 =?utf-8?B?TFZUUVJLNDJib1NKQkhTYWtqS2pjQ3N6YTZmWnJGQ0JRZmJYQmJnbkNTWHpY?=
 =?utf-8?B?S2VGVmU3RXlOdFJtM0dOWE5Sa0hUc1gyUm5vbC9Od1laUEZlVlhDQUQ0ZWR2?=
 =?utf-8?B?MGREWHZXTFZYREQzN2ZUOWRiY1BhQW9rK3ZjMm9TT0lBaXdqaEJLM2RERWZI?=
 =?utf-8?B?dG5kMFFqbXRVVVZmQWV4U3JvR1NmTUFBRG1YT2MxeENBQWZOYzZlM2NqMnYx?=
 =?utf-8?B?V3UxQmcyTXhBbC9lcFRnb3hiWmtyWUdQYS8xWEtmUG9UWndiWmtvdXJSMlcy?=
 =?utf-8?B?T1NYcDQrYkR4andrSjZQNmNqM0hzRE9sd3pocm0xS0RnaDQ2bG1tU1ZrV0gr?=
 =?utf-8?B?ck11eU1ZUDF4NllwMU1wU1p3THExYk53clBrZGttcHhuL1dOZGhsZ2szR1pQ?=
 =?utf-8?B?OEhQT0k3YXZDcUNVTytNcUhlTHk5VERSNkhFNngvRUpORHRyZzZtTXN3bTRm?=
 =?utf-8?B?UkRDQU10Yy8xQmFPUGtaU0FjV3pyWjI1K1hqcXRCR1FzSUhZOUNrWExBMkhp?=
 =?utf-8?B?dFBJdnVXM1V4ejdtdm9GaERPRTNNK0FTeDlSWFJZZkVWRGlKenJuZ3NhZWNu?=
 =?utf-8?B?T2RxWVMvRFZBb2o3K3pEUWV0d1prY2x0eFRpNzNja3JTdmlCZkdCdlRBbWZ2?=
 =?utf-8?B?dlZVd1ZsV3NnWFZuUDdhUitpM2xyeUZtbStqbWhQQmFjdDVaUFRHb3ZOeWVr?=
 =?utf-8?B?ZFBaaXVIV3htdXZadDlXbHpFNFpZMTc5a1QwWFBEVURVL0w1Lzk5K2lWblNw?=
 =?utf-8?B?Y1FoM1BTd3JYdHg2MUtDN01rZ3VvMWxNQi9VRG9QRDFHYm41WmtCYml6eFM1?=
 =?utf-8?B?bnVUaExmb3ZLc3I1bkZNZXYzRHRBcExXSU1EQXh2Zk14dG96VXNuVnJGQVBO?=
 =?utf-8?B?SitibHVldVJrQU5yWTlvVUhOY0dqUFBKUWFKZmtHTDdMS2IzODdqT2Z0eTBP?=
 =?utf-8?B?NmRQbk9MSGw5SjIwSTRMSjVhbVJibHZTN0IvVllqMlBtSGF4aml2NXdDWjNv?=
 =?utf-8?Q?2IcKkz7cPo9EIZI4=3D?=
X-Exchange-RoutingPolicyChecked: 3iAz6FZ6OSXx0Pl4FSRmA2UWWFK6ZKWUY/wQVh7kuLEgKbGCr0J2Qw9WxBJ7gCH8tIkxwQDbdHNzrGR0gP4KL59JiidzQKbiDph/jB4Ijf4+znNPkPMRIlJTS2apPKUCFSgH6Ybd8HO/9Je1EJlClI0nGrVJD2OCdPZ3EgYypFY5aiKD0RnkDshAFnMD8X0DsXShNs279Y7xAI+pYqadbPVgvd9+7ZUfhteNohYiVG+sxhRN6zH3UDWzpUvHrQYZkT3NhiztGL/m/wdFfDudmfYf0Rjzca/IHuZGKBQoNfby3/npyP0jFt6wvb2oEOhAz7Pj5H09lblWN6h+sE27nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c3880-6782-407f-6816-08df23fae23d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:40:55.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpZOUK7QTKsEFjlXA5D3KV9HzvPrPzrZskSUH9WMgGzAajisijeCwMyd+G4wSWlfP1/88Ek4n83neMMs5/kQREIUYxk5HhjBG2jtnClTd9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

On 10/6/2026 6:34 AM, Vincent Jardin via B4 Relay wrote:
> Since commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags
> to ptp_clock_info"), the PTP core rejects every PTP_EXTTS_REQUEST2
> request for a driver that does not set .supported_extts_flags. The three
> users of the QorIQ 1588 (dpaa2-ptp, enetc, ptp_qoriq),
> so linuxptp ts2phc cannot arm their external timestamp inputs.
> 
> The timer timestamps the rising edge only, since ptp_qoriq_init() clears
> ETEP1 and ETEP2. Each patch declares PTP_RISING_EDGE | PTP_STRICT_FLAGS
> for one driver.
> 
> Patch 1 fixes the failure seen on an LX2160A board.
> Patches 2 and 3 are build-tested/code review only.
> 

Yep. This change was intentional so that PTP_EXTTS_REQUEST2 would be
rejected until the drivers were updated to specifically indicated which
set of flags they actually supported.

Thanks for verifying which edge these drivers timestamp.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
> Vincent Jardin (3):
>       dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
>       net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
>       ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl
> 
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 1 +
>  drivers/net/ethernet/freescale/enetc/enetc_ptp.c | 1 +
>  drivers/ptp/ptp_qoriq.c                          | 1 +
>  3 files changed, 3 insertions(+)
> ---
> base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
> change-id: 20261006-for-upstream-qoriq-ptp-extts-flags-1c6fd731d66f
> 
> Best regards,

