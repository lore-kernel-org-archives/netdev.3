Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC283D75D1
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320395; cv=fail; b=jJrMmoymzhXF0bgsrMCbNmNN+6/9gpDQjQMzMgbWRLIzw/IFC7p4qsQIP/paY5PaOyDqPvPydWeirwJh3/0e2wEUIs1jud0m/t4oLrc7H7BwV9HGFHPyKrMbc83qLJE77zY0q96WBmg1023S5Sw0w4eXqgsH0uDLRTp+UwlCmA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320395; c=relaxed/simple;
	bh=QFQFBEwEnYbwe8769dVAQLEUiRSujj3+uZdMnlU/B28=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0nedoWksPRvjOJ7b41YowqGecnct5zY3dYF6TWNfVGWFijrSl3syqfYQYow9DfTyftfQmv0Pz7T9zOWHleE+j5v64dIjIjnzpxWEd/rYJsujibX3HUa2xZWSkYUZ0UWW1ih0HMSb6pPKfFlRs4Dg6HMy2CN1544n8HBKMLgzZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eI6L7VkI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eI6L7VkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790320394; x=1821856394;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QFQFBEwEnYbwe8769dVAQLEUiRSujj3+uZdMnlU/B28=;
  b=eI6L7VkIgo0t2LCD/xJCDcwkVJYMmft1r0NuJthjiwVCOzcV9dnOz9C3
   f7kgBZyVBl4Ba5MUHIuQfUVK31WNqdyR8vz+0yn41Wc/zAAZ7Dhfbbwbe
   j+BMZ7aZLksm1hLpdJe6qc4qrv9pN5PW1FAIc9DtCzA3goZU7yZAehUWC
   upKuIhL6CX27NLnK6b5h2aj7yCP/JTOK6mfb7EbwWMGy7xMS4wtu2vkAX
   HwlY6fDblD+aoPXQAeFN2Mm0d/SKNzROZ1vimgc4clx1Abv1p6LC4jKKF
   INUOipM6l6XEejh6ncAOOfqnxiO2M69MBXo8pYbXJcUYLKOnwbx9Slpv7
   g==;
X-CSE-ConnectionGUID: r24BhOfpQCSfLEachbYnoQ==
X-CSE-MsgGUID: huztVhF2SOSLem2JVxx9IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90062348"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90062348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 00:13:14 -0700
X-CSE-ConnectionGUID: YGKNHUsmTfKYxDjgnT4+xw==
X-CSE-MsgGUID: zIjEAbhjQiqv26MTQVp4wA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 00:13:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 00:13:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 00:13:12 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 00:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHvaTPv8U7YmWS4FQlVAg1uag+S+f/f5ARqat0WO5DuLYDR+turTrUfTooNvVbADcH/7OebkZBnx5BNZzSOQJCVIUXwnWhLU8d+c9MEBsNhwtl5Ohz6OCy+3j+4Yj3qhcWO8W0KItlYkr3bbsUo/U3TL/3vqGsRCRKwcsx+6HaEqP++fTsnOG9w0qwtn74wbG1a5zqODy+BgB9FFMxwooEyhSSU4TgyROtv19XKQ7oCIPcuwRPRT51BSl2poKokwN430gNFeCgVY4BY7SjDrC+2NCF6qSW2Q+F3rcgifGeiBvZnpxFV+nGJBonFlgJJT0344aCZ3fE2aWZRTKhDg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+/PKC8byCIC1m0ilDHuiYK1c/KAA0SsU//V6Z1a2us=;
 b=GjNfTXnyu/iXIJnG2+cKeuZXUN8+d6o488wJXitzbc5eAAE++EGPmuIpG8jIULC54hkc4PdOHUBQdkUCA+aTqdiLL2Gyev0AokyMwga6w+84qAfQYUzqUgn1onXN3OxX0GbQ+fq1I8yTFA933ou1iUzu0C6k6pyTTXUCZIlXvBsjXlgjNoYiZ2chHh9+gy3XQBVZGYwMFTNebfISn66j+sBO1i5MGjOpco7X8WvcDjJ5Lb4mrWpKPmSi9eHHrk8e3TgfmC6y0qM1exUvejzjcRhmLHHag2hE/FE81v0dw+HIFKvCPXSikhqSmqMuysEcrNiI89EkUDTuWx9pr+w3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 07:13:06 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 07:13:01 +0000
Message-ID: <502ba7ae-459f-4c2c-9b86-680b9b079dc2@intel.com>
Date: Fri, 25 Sep 2026 09:12:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 5/5] ice: fix stats array overflow when VF requests
 more queues
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<mschmidt@redhat.com>, <poros@redhat.com>, <aleksandr.loktionov@intel.com>,
	<horms@kernel.org>
References: <20260921182106.1015019-6-anthony.l.nguyen@intel.com>
 <179025260231.2160803.16852325862949481208@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <179025260231.2160803.16852325862949481208@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::31) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CH0PR11MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fd6ec5-c606-4e60-57ca-08df1ad46f31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: t8yrLar9lemwXhqL57opMvrHeqqQIdr8jJpzSFiDikWvoptVEgEWJBusRxJ/0p962A0xriQaOGPnixkrTKB3k9OQmTV1J+iKGc++DzjQ8magnTFyVCeG1g7TZl6BrQFgzADurMHP2NqtKgLG1Qv3m0BEIpDJ8/rZTm9SMhotA5kN9yzEbctfoeb3l6do+oduDC2ivrRDsS5f9aFhQIeg3HsfrW60YDnwgr3Na8ZU+wuYnugXfcDje1pm5CUl/aZlaiuYzxsgLnAqCYymEOhP5EzXd4KOdBoQm8UefN74pssFGv3DAA1IW5PaozqF2hSWsiUp/go01kVFrfVetyQt+Z+NusPFq6u8Ys57EsRsqq74T4aS6FokGpn5a0Yp8W4Ro9dcIEPduWnLHpk4cxpGa+xK8RjyLrnC+JL1Eg5ctSZtT4FvskNf/lXgU0C/2pP7sTbkFuBSpL8YxKDh5kFawThCnQkXbMPsgVaq/NDhvAxMTVq4o3c6Y9+fAa5ZK+qCVmcKEPJuoVq7S8R3PudYuhdQlPK0iH3ArtkpKjVEKXSD8jTZBIh5DPOYu97+ItM7GNU2soAzzo5pDrSlndvxttpJ6tNJR/+zgonsczrUEUtzb+lxUIsej5kG2LB6PB6o+Bh4IqdBZm2BNd+hozTx72/mJ8h2XMy/jhGL7xzJ+EI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQyZTBBZlJYWnRhYXpRVElaVmdjaHUydVlFM1JEQUo4VmFpVkIwbG9KTFpF?=
 =?utf-8?B?NXIzUlRPVnJ5NURNN0JWMjdLUnNkL3h3QWh5bEVKS3FPaC8xdDVmM3c0dDFM?=
 =?utf-8?B?SGlxNVlWUWhhRFQ3TFdZMTE0V3RPUDZZWmRjL2pXTGdLZ2lzbzhRMU5CM1Yr?=
 =?utf-8?B?NkRwcWxKY1dTOENxdUIzSDk4aWc3MWk3NmFxNFQ3d21PMG82dTlYZU41a0Fy?=
 =?utf-8?B?cHhZOGYyMnpQSU93SE94aHJER1NsdzJqKzhEVUNXNDRndVZHclo2KzlHcXVr?=
 =?utf-8?B?bDVpaDBETTZYdDY4N3B0WGtuQnNBVHZoL2pEQy9ENzdxcjQ0VE9adlJrNnVM?=
 =?utf-8?B?cFRpTFBmd1ROSWNsYTVQUFBTZklnSG5IcERLWGk3QTQ1cktTdldIK1hXQ0Zw?=
 =?utf-8?B?c0FOaXpCZDgyd2JQV25TVnNnSTMxclJzOG5sSmk5QW1tZ3lxVkxMcW9GRHcw?=
 =?utf-8?B?d0FBcXRLcXc1WlRWajNlR3VGcVpXYW1oMzd5K1ZmSlQxbTNXZFdMWGlhRURj?=
 =?utf-8?B?amlXODBNamRpKzAyaFpTTU8rMi9CRWtkNDZZQVFneUV4QUoxV21EWW5FOC9s?=
 =?utf-8?B?TVR1ZVZ1RnR5R01UUGpsRUdZK0ZVOWlVL3B1T1hmdmtCVmNTTlhqRmhsV2Ju?=
 =?utf-8?B?d0xja1pYalI1UVh2akxMT3JKTjFXeGw1ckQzREpSKy9PeXE0UmdEVUdSS3BE?=
 =?utf-8?B?VklWVWVlbkhMSXNRbUxmbitpY0JybTJmczdsRit0U3ZLbEdrN3EvNUxha1hj?=
 =?utf-8?B?OVZzcGtZcFAvOHkwcDBvSmtSaklTNzVUOW1ESk9UMmhWdFdodlZJU2lFdW5m?=
 =?utf-8?B?emNOK2xKTTJCVnVsemxJSEhWYW9KT1lzaGR4WkF2ZEJqam1QYXJoUHBOS0xo?=
 =?utf-8?B?cWE2NEZ1YkhWL0JHSlcyMHFpd21xRnpHMWwrQ01wTnluNm9CdU5hUS8rQVBo?=
 =?utf-8?B?S2ZBTGE0emxLUnNGbmQxVTh3NFBlQTY2TU9YQ0ordVpRVGhjS1RObEEweVNi?=
 =?utf-8?B?dlA4QUI0VDc4NDhkNlRtOUhiaWtMeTZyYlMyRGhnVWkvMlJZMTVUQWd1QnRP?=
 =?utf-8?B?TGN3NGJDb1IybkZSck02d2E1ZTRYeTF3c2xNQjBkbXZyUGE1QURHZFJtK2lC?=
 =?utf-8?B?N3RPWE9SM2V0OWNXK08zaGl2bFpZczFxUi9DZE9yOGd5eEJsejdyQUF3VzZu?=
 =?utf-8?B?ZnFvdStoYjNnY1dHdGV4UkZDbXlhZEs0RkJUYUZYNjR0N0xrdUxyd28yOXRE?=
 =?utf-8?B?WUo4VEdvMTg5clhGQWw2QXVyUnJpTVlON1pUVm1taWhKeTlTbzJEamVpdWdv?=
 =?utf-8?B?TTVmMEgxcjdIekFuYW11VVRxRUN0WmRIMzB1KzlWUGhsYlhTSHVKWjJpM2NN?=
 =?utf-8?B?UEN5NE9LRElvRlNmaS9tQ2JvUWtkTnR6R2pTWE9heUgzREoxdTlMTUJlY25p?=
 =?utf-8?B?RFdkVTNJUkd5ZTU4bTZtOEFwQm9pSnZzZEU0c1MxaFEreXdyZWdhTmZTQjBX?=
 =?utf-8?B?S0Nrb0F6TkF4UjFCZTdqcXlyNERWYTczMythVEVLOFRwbUJ2YnJlY0tXTmpG?=
 =?utf-8?B?SzZTdjl0TGlYVjEzblZMZlYreEVZS1I1SDhVQUh0UUwyYVJqbTh4QlluNUN3?=
 =?utf-8?B?Rm5jaUdJYk9rN1RBTTV3TGRNOC9teFhxVE4vTis5M0JaaW5pL3dFcjhnc1Bi?=
 =?utf-8?B?MXhYRFFKRUo4aW02R1JVZWZRQ2xGbmYxQzFSQndPeTJjVmsvUVdEVVNQTkM5?=
 =?utf-8?B?TG1IYWRZT1JSN0c3ZGJWeW8vYUhNQXpnYVJoUHQxb2VReTVwWCtxU21FYXhu?=
 =?utf-8?B?WXhTa1UwczlXS3dFMkgwRG9HUlZMeWlFMi9GRmZkOXRlYmhacUUrckxPSXBT?=
 =?utf-8?B?M1UxWnZSZDFKZ2xaZmQxSnVKcGNvRjFKdFpPUG9aaWl4NTZzSjhRaUhaM25i?=
 =?utf-8?B?MVp6b3plWmFEdTltTUl0UGNYTi9YQ2l1VDZJMGlZRS9zU3dnVEYwMlpXVnZY?=
 =?utf-8?B?K0V3cmFYUW5kOEZzRFNJcVo4YVFCeUtSRzA3ODNpK2NQMzcreFhCK003Q1hZ?=
 =?utf-8?B?Y1BwUFovSEMwZXBURWdqcGJYeEVzb0h0eWpXUVdOUlpuRTFTbFpOMEJWNmFN?=
 =?utf-8?B?VXUrb0kyYVBYQXFYWk9ORlUrZEc4bDBDR1o2RHhxNlFnSVRWRGJWYVMyQnpm?=
 =?utf-8?B?VUYxeWJpek1na2N3QlVNcHQwcVBrYmJuQVVSZE4zRGFYdE1rOStkS2ZlK09Y?=
 =?utf-8?B?Um9vTGtCN285RHl2UFhXOGdOQmxxMzdpQUJ4eWxTM0NzZnJqZE9uWjZyMVp3?=
 =?utf-8?B?b2tGYVlPRFJ5QjdpL3pvd3hCUTJoVTJZS2tXOFExeXFkK0VKN2NMTmtMQkJO?=
 =?utf-8?Q?slqyP4VIjW+MQQG8=3D?=
X-Exchange-RoutingPolicyChecked: SW9sgJdQXPz8iWDJSZKE+quPjpbnpxzEbszFwziGZKMc6sBUo2GSygQvcz2SlQY6Y1FsSo3zqPGqhBePaeI736b/+GOJ4Mbr5YO0D37Okt3/49zrBS7S05qD1WGW/KXDLK73HVgxhoA3BVijS+/PTH5d53qZgbYJkRwSTCkBjTdqV0fGMgjff6woupxBnRCbxr1+vP8d48HgySDJqmDgPcoYwYgqFF3XGlTV+hcG4xdqpd2NOc9daasdDdCH4M4utdcJbeFawy8BEAn17WzEd9ubZywJVixE35Cn6cc3gmgeQUnqMdXz1rA/oNtCNBaE5PbUUT4V7Ka4jSwTD7mVGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fd6ec5-c606-4e60-57ca-08df1ad46f31
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 07:13:01.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F7Azsx2Jvw4Z6QHTYmrU9xLATnHrVIhJFlf1d1hW3jQE6FC0LbTGKong+acvTNgjubiuCdswcgd3nyJ4X/W5W5ctOgwYGiiRpsq7ylN+GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8215
X-OriginatorOrg: intel.com

On 9/24/26 2:23 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 (2) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Incomplete fix: the identical stats-array out-of-bounds write
>    remains reachable through the PF devlink `driver_reinit` reload path.

Confirmed. The issue is pre-existing though (reproduces w/o the series).
This series was targeted at fixing issue for VF, and it does.

I will send another commit to fix PF case - normally I would argue to
leave it for followup, but will check if a simple fix is enough
(compare to this commit - a oneliner that changed into 5 patches and few
months...)

> - [Medium] The patch introduces a new abort point in the middle of an
>    already-started hardware VF reset.

this warrants a respin, I will have a look at pre-existing issues, but
will rather try to avoid touching more than needed
pw-bot: cr
