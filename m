Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C02F7EF4
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012529; cv=fail; b=E9ayMxuULreDdUH0pazbpeq/SQffQaUc3YojLCQl9EkpYS2/QjS4AMKUWJuVHk+uJ+To9JDAkCOhSZcFLBxBwtGUkoj/qOSPnim820OAJM4Kz1cWoLniEqUZW1GyuoZgspUtaAAGhUGqqQS9pP6NBn91zQJsiF4H3yGDwg0jD1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012529; c=relaxed/simple;
	bh=axpU2j9kle8eokVfw/ZJwfWIpkc0XYBs4y/kxQGUbeQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mPXAg9K46NUwh3OwWEsF1LSu+3pBcMphdaox6v/hB1pcxrn8JK6QSbBzCP34j3+qH/K/Qdc/V8kNXWvd4ozoxX8Mvx/AjrKwTno3pb9lhIm5mEjZlAtF1DOEDTdz8iJCCRhHOMSuJ5LpL2b9otZwa9mRBW0hExBqBnKmuT1O8Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hD0hjXNS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hD0hjXNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792012528; x=1823548528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=axpU2j9kle8eokVfw/ZJwfWIpkc0XYBs4y/kxQGUbeQ=;
  b=hD0hjXNSa780lHlJJH9qcNgjra72DndJDljD1E1QKDjWUURttWSB2h8t
   brwz6Qf3H+xvpFcwi5SOVhmtkch63cLrtd+numtxSoGb0EDHdz97YyoQZ
   gbeobBjE+l/buOuknBiizMnnoeAZ8OfDwJvr/KyKAhS6e7b5w1rdf62mx
   7SbCooQci3ahE4Xe/qIiRIr8BwRTLlM7Y9iuj8iL+KoPUjdEbU4L5swYv
   Y1cEHAmUyjc7VXb+dGmrB9cOUf8HQXsF6MNIW0RP8MXVXUvbZR4WJIwe7
   mL0KKvjVxT67uGOcPxwzusvSEHea+2SB4BX9wnbqcN+aYKjEv3TE4gnUY
   w==;
X-CSE-ConnectionGUID: 0F3mEPr+RKGuNV4BDN3wKQ==
X-CSE-MsgGUID: fj8b6hXLSJuShiZpSts1gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="672762"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="672762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:15:27 -0700
X-CSE-ConnectionGUID: 0pA3KMqOQFaulD/tJR6TQg==
X-CSE-MsgGUID: k17Rhk4sQe6frBqAKsK/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1988493"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:15:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:15:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:15:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:15:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7btw2ESH5wgc+v0UmOFtlQn+4NWfCpA78EQBBq0f/IIhlOXMYpJMhWGWMtacIxZ7TYd48woaEB5EdtWDc5QARp4MQiereEABJ8iK1ovE8k5LOkQLLLAwP/EZMpuM+yn+AdpM9za6ZSTgG2Mhh620OY5B9aVHvPQXsLHJJLJV7E+w0GkbnEk6LSIF4CPLurNq5TfFGFxMrV1MPNmQk+IHirHgzoBVOWRRmiaaQh1T0FC5ZvTGgYDzZWSewLhOC2zoVH47LlyDBti8P9PFfRcTNrYDvhns3jJGsL3FOoPHketIMkijxAWhXfPke5E5IuLDDK7jKYaNWQAUfDd/6JDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSsKjaLRctkG4Q6ZZXvgA32uQR+YdHENIWv82ao0B3k=;
 b=UJk6u+f641dGE4xniUJzlGMkL5dSeinQOWBWTvxg6T3p3bk+Vl0PsXSvON/4urctC+YZ8Rzn8dSmoq6agaHi2KeUuY8yGjqu5t/bI2pySKx0J7Y7DJibJ1u4nGHlWp6kFdMd3/LDzg7cdtwddfigv0ODry27X0PDgsX3Xxtu4WJD0UktKSZKeTkT/UawbwSjSvjuWpUpwSB3+5g58CS1+wMJkgbzP77Db7VOYe2Ni3IEOAqNIgZZbTHQS9StJS18i3wl0k7E4eKJELzmogkA2geKbMmsaFkS6AW0EYaWVeyxa5NMrDXNsleIFEA65Ho9ZFLxwVDLXR/agBD/7uEpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH9PR11MB810756.namprd11.prod.outlook.com (2603:10b6:510:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 21:15:22 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 21:15:22 +0000
Message-ID: <2f1615ff-6868-45d1-97d0-477d73e0a0c2@intel.com>
Date: Wed, 14 Oct 2026 14:15:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 00/15][pull request] ice: E82x: timestamp
 processing logic fixes
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <jacob.e.keller@intel.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<poros@redhat.com>, <richardcochran@gmail.com>, <horms@kernel.org>
References: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261008215614.1987250-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH9PR11MB810756:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d119ab-84d8-4e59-faf2-08df2a38420b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GsIuZVcOhsgKo2SR1BuMkARoYa0vyGuUmzdCsJ9n7wQ88iRfEAIspuKMl7JG5QXn2VBTDCriH0k3F7FUaigdF0a7dk6w80qKQiY8BIs+pFxDynu2c33RD266QZEoyWgdDNNY3cXNQcaEaZcoExhvIa90bVHHLZ9wAlJeb6AfrBPr+jo5MjuHOY4mPaNPy0wwY9CnLYaYr20wSOYjVXP/Jevx/lKY0LmCGbIEqFc20C5emUrjfQFggOiFMzWuIWw0xIgdJxNCSFu/hKi9ymuhovcssyokZUHDlezc7rkKwXKKvWQRZygEtgZ0QQhVc2FIcJYLbcAOjkbJbEGhVwlN9tEtiRhLpXNLi0wCkmr2w05oSCCMsyu0X9x3QX4ejxOX9vOo8MdV19FlpaN5aR3yyqzGbGUeWsGLyDcmZUoMpmB4PToSaOBfxc7YLtAYY4dFiar8UgNX+IrzFlmf/evpB/tfV+FkW1Yo/h/0VP3dmIc8zgVl8HXT+zkwp8+LBWlvu0dLbAxG3XrIYqDPsbugTaR0SWsnsh9Rv4fH+MgLoCURKV9wUXBzHN1t1CY5kKdD3w5piy/FTEWo1AbMhqSdG5iYpX21pAruGanqXS7TpzD9GJm4dBmVoCe5UozYz41GBn2QP2wJxzz1pgnzpI0kPXV4zvANOPof10NSHAWxwNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFqQXgza0gvTUdXVzM5ZFEvZWUyc2o2clRSZVNNUi9KdWxaRTZzVkZZZk1N?=
 =?utf-8?B?ckRkOTdoZ2FVaGJhc3R5QzZRUFVPRG5ZQkRJTWpaK2E1MzNTbURsUFhIRDBl?=
 =?utf-8?B?eHJzR1RqQitPSGloNVJDNVNRRFgvMW1LZmtDTEZhQjIzMGNwZkhDbjVta2pI?=
 =?utf-8?B?VUZnZk1OaEF3UWZqT1V6OHNKamZpbGw0MFF3WWNtcDVPMkIxVDJRdGhyS2pq?=
 =?utf-8?B?U3hQZUNCL3Q1Tk5raFV4U09peFowUmR0UGVLcEVBb0VSSnFSSDViS3ZKUE1D?=
 =?utf-8?B?enQwTnN2YVh3SjBoSUtLOVZLbCthLzhOZGJJNjUzTnlhbkNORGJ4L2xMUWQw?=
 =?utf-8?B?VXpBaWpkc1dTdGZWNHVDR2FsMWZaelkyUkQyZG5aU1NlY0RRQmJtN2Y5dHAw?=
 =?utf-8?B?aWlIaFk3eG54b2lRdWYvZTJ1YUN3YlZuUVFQUmxjTjRQMzlDVzFaQVZzQ00y?=
 =?utf-8?B?SWhOTnFZNzZ1VWlFYTc1MHRBWHBzR3Z3R0lzc2h3MjlGOXc0cW5pSFYvaUkw?=
 =?utf-8?B?Y3ppWlFqWW1NL3FEZVBtRjJreHVxME8xakdDMmdSb1NPSHJoSllnS3ZIcTNM?=
 =?utf-8?B?U3QvdHdlNHBqYlQzWFA1Y1VvTmg1YWJRK1FXQjhTSXVKc2FxS2NHamZid1Vs?=
 =?utf-8?B?MUdaTUpxYVVrbVNkK201N0tJYzhrUWM5M3RoSkJMOEptY3FFRDcvQXdiczhE?=
 =?utf-8?B?bEhSRDBTMmNLTjd3UExBWWtsUlc0ekE4Nzd4aVNZQUwwQlptcFBqcDFCWHYx?=
 =?utf-8?B?czBYYnREK1dRR09uMDlZbEdJekkxU0lGRFg2ZElObjA5RFh1Z1JuSXRFWksw?=
 =?utf-8?B?MXR0WmUvRW42SGlpT083ZGx1WE1xZ3Zka3IvTWlCSVh3bFlIMjl4TS9zR0tQ?=
 =?utf-8?B?RmFBM1pmRXNxZzdERWpreFhOcEMrQVBjRlZveWNUK1gxc2NoejgrcFJ0alli?=
 =?utf-8?B?bFJHNkgrRzUrVVhMNGxCRzlvbUZadzFyRzBTL3piYWhjUHJ1K0Z6ajFhVWZi?=
 =?utf-8?B?aHhOcnZFVjZLaVJnRU83YUU2UUN5WXEzUENIcjVCL0xjbnRpb1VVcGdtcHNC?=
 =?utf-8?B?N3V0NGgyNHNiZHV0TDlWUUlpZnJILzRVQ3ljYjRXbkdMTmYxdkdKaUNrekZh?=
 =?utf-8?B?U01PcUE0VlQ4bkNNbnpyMFhJOFc4aDRCZGJpNXpLREplaXVqTXlIcDJaNUZq?=
 =?utf-8?B?OExaQXliakRBWVltMy9KdzRTcGZuS1JtbEo5Szc2VUZ0bVBlaVVWeHdwQmtr?=
 =?utf-8?B?VmxWVTNFN0tFK2VTSXhRWUkyeDE1OVc0M29nbEM1UlZsYVF4azR6SEtxUXYx?=
 =?utf-8?B?OGlJdC96VmptbCtTYll2cnFJR1Q3TytRNDcyWThJT25ZcXdIWGo5cEdzbGFY?=
 =?utf-8?B?UW5YMUVCS29SWXQ0U2t1ZTRXY1lQbmVzYW5IeTg5MDJCTVNzZGNlcTRQeTJo?=
 =?utf-8?B?U1NhdlR5S3dkMXF0TTBpakRjclhMRE11T0MzSVplaldnVHFPa3MyK0p1Z3dX?=
 =?utf-8?B?S05oSGdROWlJTy8xQzFkMUFWVkxPWStEei94d0RUSVNMVDkvQjhuMXNWeGJG?=
 =?utf-8?B?MTF3bUR0ZjRXcXhCZFNSSG9VeDNyaTEvVHhxQTduL004bnBGSVJiVzlmWjJp?=
 =?utf-8?B?Mk1qbHdWWjJpSms4b0cvMGJQaGZqaTd1bkdEbk9ZUFZmVk05Y0hsOWJaY0g3?=
 =?utf-8?B?ZzJrUUpXdXYvU0FPS1Iwalk2LzZIWWtRWlFUcDk5aHBSTUxhTytxSEh5L3JK?=
 =?utf-8?B?ZFUvMlNjQVRBWUZ3Q0NFd0ZEb1pTeDNlanI2ZEF3Rk5NVXo0bXBDbjR4TnVK?=
 =?utf-8?B?UCtURGVFVHg0K2d3Um51VlRRV1RQUTB0NUN5SzdnWXBFNUJRQzQydlFDOTlo?=
 =?utf-8?B?S2l0R3ZENnV5aXhNTEozK1VmTHliWUNDS2VBUytROVNsUU9NejQwYXkvNWJU?=
 =?utf-8?B?NUdUanU5ZWIyeDQvUG9rYTJwd201ZU5NWHlPREJPTEJOdE1MeGxnSjU1eUNh?=
 =?utf-8?B?ZitTUm5WbGlnNzBmYWVueS9HOVFmREV2WXNVZTRrSldPbHg2Nk91RmpWUDlS?=
 =?utf-8?B?ZUI5ZU9nMUo1REVYdVBmZ2lVOE5lZWZ3YUhtVFlYb3VmOG5lR0ZPbnoyOW9s?=
 =?utf-8?B?RXRKSjllaDQzUkJ5Q3YydWxlQmVjV3RhLzNsQ04zc2lSRXA0VVZrc0JqbUhz?=
 =?utf-8?B?bTlDenBKaG5kWHBYSGhMcUdoVWErYU5DS3ZNUU5HM2JRMnpGNFkwbnVTSkpQ?=
 =?utf-8?B?SzBoTm9jWFlXZjZyT2VLZms0VHNYQ2RVM0Ivc3hpdWZRWDlKTUtKaUljNko2?=
 =?utf-8?B?QU5NTFlTMU1ZOGpuN3ZUYTdpSHBBaDh2QlV4UWEvOWpNUzhkRFIxYldSZXNY?=
 =?utf-8?Q?vjGc6JmSMS9/AW4Q=3D?=
X-Exchange-RoutingPolicyChecked: BDuJQUUAmaU+wsCZ+e1gJwzQqz8koRZ/+Zd6Q8UdlcBrww0FxFnHjKWOIMzzass2YYLVtoXP8pTlC4LvT/5VN0PpqRp7BmZUlOSrobMlUtAnRQKyxX2BjoT0nUZBSbZ5oVgWq7UQzLbCJyMvlZrn9G2Ipi+Um73o6LaVJ0gpaFTejCsBGPXVUHEX28TVVgqeYjpLOcgCsgkxMpm4TzZjgF5uqvq6tcES/gomcxZVKPGETWKXNAqurKIR0BlQ3ypRZx6iS2U3z6PfZA9Kj28HLCesqolFgmfIAHUX19P5cSaHHMu3xnNtk1Gf1zFZxMhmLYQYj23EINAPEs7lUN31vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d119ab-84d8-4e59-faf2-08df2a38420b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:15:22.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsTouQY5DQXXC758FppxsyIj0m4CvzTMaPyMR4hH/0U7swi84EDh15hy0hbOwv7Ysmi0yiEaBTV44Nw6fpM20MTnAxKPAkeW5HuTiB+CBks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB810756
X-OriginatorOrg: intel.com



On 10/8/2026 2:55 PM, Tony Nguyen wrote:
> Jake Keller says:
> 
> This series contains several related fixes for the ice driver PTP logic
> relating to timestamp handling and device (re)initialization.

Jake responded the clashiko feedback and will be making changes. Marking 
this accordingly.

pw-bot: changes-requested

Thanks,
Tony

