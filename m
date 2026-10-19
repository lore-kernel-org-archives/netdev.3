Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792453359;
	b=u2se8KoXnsrsaqpnNxDy6Y87Bhuz3sELUiFUpwNoG7Dq5yXXbWKmt3GrEtOQG5ZJJF68
	 g4rQoTYzK1ci0uAsD1rM0wTl1u6LoSE5S6/UOZHDRiBpyz7yq1I1uMfVHRWBL3uotXaTJ
	 3rj9ovwvt44pxdvlylDzwIEu7NrSBup5RxUnFNEsx0realr79GalBbuLdL/zCTWzxr75H
	 KAyRXajl7AUhmZH4Ha+VknWwNUz5UUBtWjfcgc+DOcL7UXjbark5OPY463pYv+NmQvC1w
	 nAjD3Gje2fA0Lg2VC140fXdalei4Pa8GrG7JBH/ILmUWTMEs9b3V9lcELhAp7lehesQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453359;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=8BbcC6ZsY4iMClUbxvCKVCFebECuX3bbxioXeCSm8jQ=;
	b=GrjQUdLUgCxzqoo6jvBuz1L9+KQF6aZZ8MpYPDdXqW12KIDTBL96pKr0PUjxg7G/lflZ
	 J6Gu57kHvD6Mic9ZFuTDU2jQYJ8ZoQHM5XlRhvBjlZSBHC7GtNnft8D0bPju0F32cwt72
	 pJbKsR/DXrMoTm52+ZOY7KcovqCc6PdLXlxZThz8stasq7fnZTAUVehhLXZZWzxHbKO7m
	 8QV72d1xjP+g0cMzm1PZ0uC/03s7fbYZkC9ZQhvC2j509r4Lj2vrB3Q53Om6IyGYTvJmR
	 QUf4Jcr7NRwQT5YvCpBxzRnnhEIF+LMio97r4Bc0RAwyQy/ZrEagwbdmCLF96ReeWGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MQjpClCC;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D0606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC7D0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MQjpClCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792453358; x=1823989358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t/Rzirgp9Y76OqbcfvgFbCirRXzZchbKeVlsW/liLRs=;
  b=MQjpClCCM9Fv35zyDf+x/Ci4K9wLAv+jSv2S4k9XJXyFYYTJgKKR0k5h
   Y8Haf9tqrehYfrUPIOCTeBHoEtZ2lhYP9LXBaP6ZaX0ow/yXYpPnSa+Kq
   FU4GzGMkdWQiKa9q2KcnZ2LqLSx0vInYuOTly/vaDDDWOzB2IjajH/5tX
   dNTuoczyoC7XvxOiLU1R6GJM6DRsNtCF7zHDc6kU0iE2IfHpLKluPjk6p
   EblGHok9F4Hoo1csUQcbDKUXmsAon/OOkwv+T37wCyce6OmWILk06p8aG
   cSrRoUgJzB/Yyizw+uy0lU9k64ZN2iZvcxc6vMxzkPXnx74gDJ+Zpc0aJ
   g==;
X-CSE-ConnectionGUID: IkKgNVQkRDqASIVQVdTOmw==
X-CSE-MsgGUID: vgPFc0WzRwWg2AQMWiGm5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1053284"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1053284"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:42:37 -0700
X-CSE-ConnectionGUID: acgQfY4gRLam+2T8kPCTmQ==
X-CSE-MsgGUID: C8246dReS42T+wd3/EJnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3022625"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:42:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:42:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:42:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnLyfcixZxYhgUnf1bB3zOw3hDJIqk8PNbNBpt0/76GWW60FBYAq8YFQl2cW/N4SgkysE4UQuFkJ9oOl1OOvCVWF6XJ1mz8DU63ehknny7AwMXmEsHBGd/4CMBUkIlmWd6dhcvxhsWBLrIusPHX904mZt9X8ln5+rl++2G8PdJ5hjn5U15dHfcFtIsTeoyygK4rs8uDCjeB1qfeY6DEv74fcuN0s/uZUJQygjdHzO0KJ3f3syiV+MN3XRAMrZtU+qa77SjDTgBhetLlEqqPkEvApF7bCNSL1e78Onh212yg3mQNLFpV4GEfHRLtj3Ou0EIzezVKG+NUw0cUherHgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BbcC6ZsY4iMClUbxvCKVCFebECuX3bbxioXeCSm8jQ=;
 b=URs+aGqP1VSFgDUDIewTDbM7zkXDtuENOy5Q5I4JVDSh+xwlZaR00JL3giyb/BqBN346TEN7aEEudQPpmj42+SV+D9/+wmWU+RjAUpCzHa4g2kxBSNfDEu/DUn9pCOIalonpM5TG0VQIPvyv5GBamaBbOWFg7Paiyvkd/0IIeUk23z/cpho+3p4SuPdY+Wub0fbNAH4AX16+yX95LAow62/cOPQNul4L/16qw3a8emfjdIK9DBOOPaMGlXgorQnv+AWbKloMt0Orr/QN9ZPFcAFyEg2cHJclJtWpiB5btdo+gy8jiLQxJZ1spT4ESYVyi1giqOTs5hKYTnL66a4sgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:42:31 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:42:31 +0000
Message-ID: <caea17a6-9a07-4aea-933e-afa9754fbee4@intel.com>
Date: Mon, 19 Oct 2026 16:42:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 08/14] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-9-anthony.l.nguyen@intel.com>
 <179244085024.3135.15051854897545383662@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179244085024.3135.15051854897545383662@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:303:b9::35) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: c39977c4-dd27-4863-e98d-08df2e3aa460
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: kNxBz3pjnriiC0iR1UsM/72NVrMx3ulA/hc46sgqWNmdrKx/LdcsanngFb5VskBPZizxLTS1rC6uipvPE8z7tGrCzPj+NWBWBcTL8vJf9uYgqk81/AttOSTwl3mqCiQMmk5h6WExM7IFMeBiZuq0jXYUfdpM6znijUV5l4NYdJQ2Do7v2t2ryOz7OKKCBm+6h1F/yp76jw2pcbq+qhEftJYaejHnayzMPVmDkjfIVwVyWj0vcxGdD0+/rCBvo/3qMX6Yp1AyYMXyLT0+J1FlVXbJKAgmXCQhVKwZ/p/eM9zFPLYi2W98WuZxjdSpN8nsQhW2SGcUlS9mi+I/zyMHcuRhDly0h4fIyY12Icaf4I0Z8rcb8qlC1kmrf45HiXmy5N0mQaC4D3yvRTxvn/JIpGhHsctMNUkl9xVS8mEZOrJPys8hFgRmYXMmG1qvTX1ezZgh99TN4TUzn1jjj6qpvt0UvA9DbvlcvXlAGEqlSp1F5O+drrAqqqekGdaVfH4Ntk4uhvfGs2S93EpgCeIT83detcPKlVd+AF/wF3oZTG6loK1a7xwcNbzoyxntPBO0+29dEY5qlqC8RVQjfASiKNocoZUJsRMhFbU3N5vig8rJEt1EpOkJb86df8TPtlM5igAFjWxP+XsKGcpbzD51wSq7jlJD2diwL/HLg9JtVOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9UT3lTU3FtdG9yS09ubDM5ekxVL01qZWtlRUxReEJmMzVlZmlzRktNUnBT?=
 =?utf-8?B?Vk0zcGMwdWpmaHNOdXpzRVBYQ2dHYWpndW5pRVplVHBWQk1lY3BsTXE3eW1L?=
 =?utf-8?B?SG1EVmtxbmR1K2hFbDFuTWhJVFo0MXRNMi9jSlJZZFVzU0dFZ1FISGNkYmtr?=
 =?utf-8?B?WFBQMUxkS05OUDJ1RktCUytUQXV3N2J1M3pZMkc0S0lJOWdheW1tdXRXeWFr?=
 =?utf-8?B?clBORFhjM3kvMVFoMjByWXNOQ3daWEEzSTZWWWNZZkJGYkwxV1k1STh2QlpN?=
 =?utf-8?B?MFVPRHVra3ZWSHJzamVWZktOSGlFS0hqcHF2UkpqSVU3QUpENmVnRVVacU5l?=
 =?utf-8?B?RHUyL1hEbkZmZnJqL3VpV2U0b21QS2N0R085eVF0MDZ0ZzBNWjJFcFJjQnJD?=
 =?utf-8?B?ZXlIbUYyRnZ6L2hVUG9icFVzWG5SbW0rbFdzMERCdFpFV1RTUXRiQ0svcFNs?=
 =?utf-8?B?dll3bHNjbkpRN2J4dk1QYnFmMXBDdnBEb3hJSGwxN3lubzJ5bThKckhUVnNO?=
 =?utf-8?B?ZFczSlAxbVhwNndVZXp1d1ZURDlHRmlJM0ZkbkcwY3JzMEE0Rmpxd3E4VmpE?=
 =?utf-8?B?Z05tN2E1MEE3N2pyWEZxTFhydHMrd3JMaTNCeTFvRW1LM21rV1VyaTk2OWYz?=
 =?utf-8?B?QmhCeS9zQjhzdmI4OXRkamJIeWp4SmlacytFVXVLeWE1Z01kbVhhSGNQRVBz?=
 =?utf-8?B?ZW5DdmVqZkFURkVZU1UvT1U5UFRPTlJvUmxveFp1UXZWbG1JNkF6ZkJvTWJq?=
 =?utf-8?B?UThVSXVFYWNCN2ZWdHZWcEpXeEJYSUJwamR2ZEJVTkN1N2lyUndCMEtSdWUr?=
 =?utf-8?B?UkMyT0pROWZBWlltbnQ4SHhRK2w4aFkzSWFKMkMra3pGYWtrcVRzY0JNSVBF?=
 =?utf-8?B?TEFzd2NPY05RUWVCNkxwTlpJRGNSblExbndsYzc5Q215K1JDZk0vY2xGNktn?=
 =?utf-8?B?MHAwcllKRG9zeGVNODQ5dDdVU0ZRRDlXN21pTVExQTlsa3ZiR0pSc1pqR0xP?=
 =?utf-8?B?VHloc3RKdjR2YmJvalB6VkE1QmJ3Syt6Vm1RQ050clZJTXFYb3JkRFRNQ0Nv?=
 =?utf-8?B?YWhMZkZlVVBvRk1jQ3BnZjg0anJNb3kvN3ZRMGtqd280cnJQUkVPQmRUNDZs?=
 =?utf-8?B?WXRkVC9XV2pTN0Q3YnFjcGtLRUplOUVYZ2Y3V0RIa2wyN1czZjU3aTgybHhG?=
 =?utf-8?B?dXdFd2prNUR5VUZER2JtYnVqSm81M1dUbnRxbFhxMTlmSUpMVmw3S1VWREJR?=
 =?utf-8?B?QmMxNWlYVzViaDVOajBvUmdKZHhTYU15RTZITnpSanhKL1VRMFI2V2FkZVlV?=
 =?utf-8?B?VHhuYW5pdCtUUkxKb1FOQkZpaitHamhEbmJJQ29tOVNMV0pkS1Q3YzIwcGVI?=
 =?utf-8?B?QzVPMlFoTXN1aUlueERJNzlMQk9NL3czdEwxS1Rndk5iSUdQckRyc20zRlNa?=
 =?utf-8?B?Skx2OTlFc1J6cStOREJ6R1djTEIyeDN4YzBlMHNldUR4MjdGSFJqdGN0aFhG?=
 =?utf-8?B?NkJOWDd3MGQ5RCtwTzMwK2MwSjBQVE5TTCtiblowZUN2a1MxTHlVaDN1Njhk?=
 =?utf-8?B?RzhXQWYyVFI3bDJaZHVzQTliWHlYTENKYnhkbEdFb1VSaTlUbzRLRk53M0h3?=
 =?utf-8?B?SmRyMTExMzdRSDllK3JLOEJGWFFXSWJaRXFpZDZpcmJxdlBSSkczd1pjQXls?=
 =?utf-8?B?YXlFRkRLT3R3bkVhb2NGVEZTSzFTa3Y2U2Z6bWF0VUVuZUhyRnF3SEpsdkRj?=
 =?utf-8?B?ZnBZYitqMzBCUWIzS1pITUk1RGRJZHFYZmk1UHFKd3VRblA1UTFqd2UvS0Vz?=
 =?utf-8?B?VUh5My8vSXEvL2svL0grbXNYUDExWmZSZVFNQjRraHVYTkxLTEhBZEZBY3V6?=
 =?utf-8?B?dmxTTzRBSU13RFpDeUEybkhNdHk3RlBVKzZhVldXL1Q0d014eDMxQjNHMldV?=
 =?utf-8?B?K3I4TE40R0tFbWZsYUdnYjc1MjdLRVB1bGR1alZxV1B1ZGlaZjlRRlk1ZlZV?=
 =?utf-8?B?cXFBbDFWWE5hdnpPa09lbmE4UUZGZVpoUVVpaUN1Nm5ZU1dOUGNaTitSdG96?=
 =?utf-8?B?RHhrZVdoZ2pCYlYrYVphVTJXWkVTRGhzTXFKbng2eXhRcit5QjNXdlFSN0ZH?=
 =?utf-8?B?RmwyZUVGemtXVTRVcUdaaUNCOFdmeGczWUhvdGlaS3ZQZ1hKcWdlVHVsUVU2?=
 =?utf-8?B?cjU4SE9oZ1JrU1NDQlJkQitZalVSc1NXVGJnNFdFZ0wvRmw2VGo1VEdCZlo3?=
 =?utf-8?B?b0tNMTBEZ0ZJOFcwa1JBcG5QMXB0K1RocHlHSnBVT21PZE0ySERRZmFWeW9w?=
 =?utf-8?B?ZnNuWUFETlB1WjdXR2RYWFgzMnRsNkZHdWZ4ejd5ZVQzM0prSG9SZz09?=
X-Exchange-RoutingPolicyChecked: SVThoJRKEQSxrM1aYLPiwWRPEo2UVEJYRehRTLLzodr71HRodqX72CjkFB9QROoARW/ORHFbGV+9h5WkR+ytYVKbCxez3GipETR+MInN9K3ZJlls2m1guQG32yigWbtep5xP8qVEywetrnHlMVRc3OspjO9DgvjC6waxZVLEwPgz4oF+SS+PdoQ7KS5IEOroQpLrBwS2HBo4v0gzcEy6spCuJAhzS47xzYXA6TrzWc2mKw7k6UflbX/RDIGobGVaqMWQseetLsSVpCQz1lz6odjCvnwlmxbwRtUWTr5PFQUnake7wAiGg7LCTlje0an9GvqUl2i+9C+HtxphH7fvUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c39977c4-dd27-4863-e98d-08df2e3aa460
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:42:31.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCtLpxARFBw+Y65ZvDqUQ9o4yv75ev5kCAxYbzi31PgEtDKzoLdjsX2FccQU/r7OZVsi4t4oSOH5d/Z2u4QUXX693PSHnQ6eMlpUzoeucWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The kernel-doc no longer matches how the code uses `struct
>   ice_ptp_tx::calibrating` and `ice_ptp_mark_tx_tracker_stale()`.
> - [Low] The new dev_err in `ice_ptp_port_phy_restart()`
>   (ice_ptp.c:1347-1349) says "Timestamping remains disabled", which is…
> 
> --
> 
> ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
> 
> On E825, ice_stop_phy_timer_eth56g() no longer clears
> PHY_REG_TX_OFFSET_READY, because clearing it puts the hardware Tx timestamp
> counter out of sync. Instead, the PHY stop and restart paths set
> tx.calibrating to block new Tx timestamp requests, and mark outstanding
> timestamps stale. The unused soft_reset parameter is removed and the
> restart failure message is reworded.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 6297773806949..365cff9c10173 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -818,7 +818,8 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&tx->lock, flags);
>> -	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
>> +	if (tx->init)
>> +		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
>>  	spin_unlock_irqrestore(&tx->lock, flags);
>>  }
>>  
> 
> [ ... ]
> 
>> @@ -1243,7 +1245,14 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
>>  		err = ice_stop_phy_timer_e82x(hw, port, true);
>>  		break;
>>  	case ICE_MAC_GENERIC_3K_E825:
>> -		err = ice_stop_phy_timer_eth56g(hw, port, true);
>> +		/* Disable new Tx timestamp requests */
>> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
>> +		ptp_port->tx.calibrating = true;
>> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>> +
>> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> 
> [Severity: Low]
> This isn't a bug, but should the kernel-doc for the calibrating field be
> updated to match how E825 now uses it? In ice_ptp.h, struct ice_ptp_tx
> still says:
> 
>  * @calibrating: if true, the PHY is calibrating the Tx offset. During this
>  *               window, timestamp requests are disabled.
> 
> After this patch, E825 sets the bit in ice_ptp_port_phy_stop() on link
> down, where no calibration runs. The commit message also says E825 "does
> not perform vernier calibration".
> 
> ice_ptp_port_phy_restart() leaves the bit set on failure, so it acts as a
> "timestamping disabled until link toggle" state. ice_ptp_release() also
> leaves the bit set after teardown.
> 
> The kernel-doc for ice_ptp_mark_tx_tracker_stale() has the same problem. It
> still says:
> 
>  * This should be called when the PTP clock is modified such as after a set
>  * time request.
> 
> It doesn't mention the new PHY stop and restart callers. It also doesn't say
> that the helper now does nothing when tx->init is clear. The teardown order
> in ice_ptp_release() depends on that check, because the tracker bitmaps have
> already been freed:
> 
> ice_ptp_release()
>     ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>     ...
>     ice_ptp_port_phy_stop(&pf->ptp.port);
>         ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> 
> Could both comments be updated to describe the new behavior?
> 

This should be updated and was pointed out in an earlier patch. I can
try to clean this up.

>> +
>> +		err = ice_stop_phy_timer_eth56g(hw, port);
>>  		break;
> 
> [ ... ]
> 
>> @@ -1309,15 +1318,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
> 
> [ ... ]
> 
>>  		err = ice_start_phy_timer_eth56g(hw, port);
>> +		if (err)
>> +			break;
>> +
>> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
>> +		ptp_port->tx.calibrating = false;
>> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>> +
>>  		break;
>>  	default:
> 
> [ ... ]
> 
>>  	if (err)
>> -		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
>> -			port, err);
>> +		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with err %pe; Timestamping remains disabled; A link-toggle may recover.\n",
>> +			port, ERR_PTR(err));
> 
> [Severity: Low]
> Is "Timestamping remains disabled" accurate for Rx on E825 in every
> failure case?
> 
> Tx is now blocked only in software, through tx.calibrating. Rx is blocked
> only in hardware, through PHY_REG_RX_OFFSET_READY.
> 
> Suppose the first register write in ice_start_phy_timer_eth56g() fails:
> 
> ice_start_phy_timer_eth56g()
>     err = ice_stop_phy_timer_eth56g(hw, port);
>     if (err)
>         return err;
> 
> PHY_REG_RX_OFFSET_READY then keeps its previous value, for example 1 from
> an earlier successful start. The hardware may keep marking Rx descriptor
> timestamps valid, even though ice_sync_phy_timer_eth56g() never ran.
> 
> If any later step fails, RX_OFFSET_READY has already been cleared and the
> message is accurate. The early return is not new; only the message's
> absolute claim is.
> 
> Could the message be more precise here, for example by saying that Tx
> timestamping remains disabled?
> 

I can fix this.
