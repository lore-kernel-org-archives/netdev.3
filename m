Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793050895;
	b=JugDSDP7rbP8Ck2H/muyuKv5J9LbMOOcw7NebHDNtaIfw9EjPU1WleSnBVWfuTtPZfAc
	 1DnGJzThKVGGd59ihsLEbw2s2C6l4t+/WJznECVhZJCex9DAkmRtPYbAl9tsOt9K/txhh
	 ycII2f65RlsS4BEffr8VF2e/S63kGdBZ3JB+avFcoWuo4trGbAMGYNIj47N2TYWusxIOy
	 PcY7R6GXbUIiY9rzrZyIrKubZChRO0GztTawIEWQgy20T128bgMBCVETXxLBN3uz4rS7V
	 beOSHq5hMb4ZDiSZwWDwEgaSPG0SHgttFbSCTop1DqtysGftpA0bkAYEHQRPpqAPr2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050895;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=xdsN57zYufeDS/LuM+S5K7Ku/DH2x4rZpP1WikLDzI4=;
	b=2ZBMxqQS2fBO2nOmDNXpK5NIKDZZ11+v+xkx5gtWNz1PvWCK0jTFpC/vttS8tTNKKuvP
	 IUKsIusbm+GGMvdZ2rUTju81g0R69QAjR4a0jOA8I1N2hHjSBqYu1tm5fhTBmIoz/glf3
	 1qc4jJk3c9ArnkYq/haqq6qyI1TkpfjrP7/hfoI1/h6dvBtLGQrHgnjpGq1yBpu8Z777E
	 amcJ0luqmrRPMR44Zd1TZ66E6Jl9UKbV/VkgYUFyrm5mw4bHaMJDS508mTIeQfeBITFiA
	 IAo6Cb4nyMusB39/QmZMthFEOFj7odk5Lc6K6EOU8wteDxFi9SOSKr4qwy8k2Cm1NQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bMT7Lh3c;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33B606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C33B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bMT7Lh3c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793050894; x=1824586894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XixAMDZChwbADWb7uRt8SYRv2TU2TfubSec64iFkuqY=;
  b=bMT7Lh3c9BzSf3bjov3Go9hINx2gpaXniyRRfpqPtNgbsZRPRr3w48z6
   zY0l5X4eQrgFisNHcQzSpvr9xnhhMIvAvCcSdOHR2yCzbSNg0lDVwPR4b
   l2TGJN+su3UDU4aAepsLZ9sSXODPSQfc40rWdHStygnNtktfEtWDl1g4y
   Tlamg1g3TzoYOcxg6P5dkkpJS2e8D2RPJ6hW7IGnjYhfYsCrUI/ChNPr8
   DUxztxqGnJtdmkuAJw0llSdkrncMaAc27DXx7AaVvP4u/bvknj7Nze0Bw
   qQ/cs65Q1CCeA2lNFMvCGchFXT2ZSjXh5G3GhCi7HmS7rmbK4Z0JseQxn
   g==;
X-CSE-ConnectionGUID: Js3Xd6RLRna8Y0LTg9pipQ==
X-CSE-MsgGUID: vRKBJi0RQp+RM8kZ00WARg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1618700"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1618700"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:41:33 -0700
X-CSE-ConnectionGUID: LuAN6+nyTb2l8I02UEp2zw==
X-CSE-MsgGUID: B12RQy0vT/i59zhLT206Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4522427"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:41:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:41:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:41:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:41:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdC/Ym4/XnrajymXh3+M8P4Eam+T3lqQAWx7eVxt7iQadCW1gZVxd6wUSaJg4d6VCZK7hwlNvgmHbjiXJkOY0fsWVU/UQIYNQ3qurhPSRhsq7+S+DaiEsM9s1n/wF3JB3quNAXTFkv0QmORBgUkNlidKVVRrYLLv4R3+S5mW73xdGaG0Yy2+gMYR032PZ1qRMKNg4Fs910aj/kwhWLQsUo78vLqoeV2sYEJT8y9YJ8CfmnVjfYutbPnvKikiLJUajrKyWG+ww0HkzjEXgky9HkdlbjIZ0WaKEsXw+eQW1C5qZXgWpnKcyaI0NsR218nUzZXz2NF6vm5qOW14e+bhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdsN57zYufeDS/LuM+S5K7Ku/DH2x4rZpP1WikLDzI4=;
 b=glNSuCW+q9QBJ7Ma3gu/j4N1C69aS8ef31SUzsG+iWe77xRKX5XyIzKO8jISJ10zCYXXsz0Nqt1Y0H2VXeGz8IwOFwJ267H5NRm7cJ5XbdgrNFJ3CpS8AOwTn8G5wdqoVCXpyRAjWEzcBKP236x3Nmk+yULltppWmX/91BqvL4vl1mst2LTTc9GBC6Ah5lE9xCsyQYsuFOcKQjKlEmniLZEow64pWbXZaHiJSw363B35ZtbZDiC9jwM/CJ8tzO5qgzHwMkiPYo1lgCv0+Guz92zMvx33yRQxLdIVTVghjHP80BoI2snR2W/WDk6RmIdoaBxXtwid7JJddKc0kfzDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:41:28 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:41:28 +0000
Message-ID: <9787e665-e34b-4d7f-a059-50a6c50b5144@intel.com>
Date: Mon, 26 Oct 2026 14:41:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 07/13] ice: E822: cancel offset verification work
 during reset preparation
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-7-72289a4ac8eb@intel.com>
 <179297183889.3134.7235166603160633075@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179297183889.3134.7235166603160633075@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b5de2e-5235-4be4-9950-08df33a9e401
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261026140227099003|5023799004|4143699003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HnZQGYnTgvqJjjt0NFhD5VeXvTVWz6E06Lt7KTOQlMEbVatBVy91MqZqnP7VJ5xcHRl4Ce/imcK80fqDpnlAZHYVPWmsXqhONxEwD/SOpR5KY4Tno/0SuA9BzExLh3W3CVKwjkLKRe09ts6DcS120zmKUxZqJxUBj2Y+W7aCgDnFe6fnqS8dbxnPOHo/lwiwS9mkHKA16kOk5gpMXYRaxBkgzzYDB12twKzEyqL3sQPl6YBdbuFhuqYCziJUDyAV7x3wwXJ6Ocj+ln4uKxdH/FBHtSMFsVksl5nYT9hkdFGLZOBm5kntFxD6zTicu9+jnUc/JTntnU4lGfQ+Q+eiQT8dao5EBBwURjkwxMAoS0S6FBU47dwSDArO4GKfdGYlA8FU4BoylkMQhSWb/bB5EvY3Dm3ZWe7Rih2P7uxTFpiMVqM3gtLVzYm4/HIMTXTiUnAvBGGlCwZWIWnOeU+Tiq0QjMgTStUECRyj9iUdCpn2/dss3sVfLP9td+nh7jO95K1S08yEp7bqdVliQSiW0dMn6hxR7SEEirHh4kOH+wtBlAHXqFTROtFSypwL2skHnSKZ1COYiZnVRdiSQk6Qa3vVmB6OJDXYJfXzcqMr9ni7wqwBUK6/2jC32m2yJKrvKo+Y86M+uH0cCgn4mY+cwGMYdBzNpbvDJUyPYdMnFwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261026140227099003)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRFUHRFNjJ3dHNHZWdGYTFaSCtKNkE1aU93QjBWQ0p5SXB0cW9SZWhOckQ0?=
 =?utf-8?B?UWxFaFgxTEJNRnVvM215OUZpQ0pwOVcyTEFVSXBsd1hWL1B0cGNZMUR5YzI1?=
 =?utf-8?B?S3ViWWxTcGdIQUxJU2xCcldzemRUUlFrOXZkL0Rjd0RLK0dadzdWeFhUQkUx?=
 =?utf-8?B?eUtLamxYMk5lSkpsMWp6M2h6QXRHMEJlN1QzcjdKTlFYRE93d1Vmclg0Yk1P?=
 =?utf-8?B?alZuSEVXMWpjeTBMWHdITlNDVXhaQjBSTHltc0VabituZjNRL29aNlNyNmpR?=
 =?utf-8?B?Ty9ySUJVM3RiY1kwa0JWZWROQndCRG10MlBpNTU3VVVIcDkvUVNxb3RReURp?=
 =?utf-8?B?YlJvQWY4VnR2aVhjcW81c0tvejVKdDhHNFZudEdiNVBFOThJUFAvYTc5SWFM?=
 =?utf-8?B?N0RJQkVFMGNQd0V0elhITnpDTDFsbURkM0FGZ1lSN1IyS3pDR0R0aWk4MjV0?=
 =?utf-8?B?V0RjeVRZTC9sV0hzMk44S1BuWVQ1TjF0dDI2RWVsalhPQ3dkOXc0ZE9oWUhS?=
 =?utf-8?B?OTFuZkJIOU1INUF0cGVPdzBzYVU1eStvOG5DNFdUNjlMdHByMnMyTTgyUTlW?=
 =?utf-8?B?b3BXVi9idWNkVVBWK1VZaFA2Q3QwZVVkdmM0d20zekN0VmxyOE9nTlNPTTZ0?=
 =?utf-8?B?cHlxVEJFV2NVSTlpOG9CZDRZMEFyNXRkZFNmTHJNUmVHSTVBMzlyR0FPRDBF?=
 =?utf-8?B?endLUkhKb3pRc0hZTHMzcTI0Y216eWR6bm9nQmFNcFM1RHc4WHFlTGFOWDQw?=
 =?utf-8?B?dkV0WHltU1dPcmxHcXUyZTUzcEFJT2c3OW1CK0NGVEFwRzFaWnFrNldkZHRB?=
 =?utf-8?B?bFQvQTkwcWFSL1hVTkdkUEhKR05UL05HbCs3MThTaXdhdkpwcm9ZTFdmd0M3?=
 =?utf-8?B?cytyUUZnMjU0NnRWWS9BaXZiS2lTUnViR3dMeFhEYS9ZRkdHdXc1SWI3dEhh?=
 =?utf-8?B?ZGJ6b1VMQUloWWtJYkhvL3NVWVcxL0lNdTkvT2Z6OTBGcm0xd0hxS1c4MHU0?=
 =?utf-8?B?QmZGUVZjdStOM1poS3g5Nm0wa0lmM0tvYUVKbC9tQlZjM1U0R3ZxRlZrbzVY?=
 =?utf-8?B?dzRvMTV2ZVlRWnkvaGNoOGRoYXVZb1dSRWUrQWZzdDFYSFBXejFtc3hmT2o4?=
 =?utf-8?B?OWxjTGpJc1cvbjhQaVZXQnZoQXdTL1FmQWRnQ3lVdndvMXBHeTByeVNIUTgz?=
 =?utf-8?B?SGl2bFUwbW1WVFZ1ajFvdEpadUdzSFpIcW14SHBuOFUrYmU1YmNlM3MwNG4v?=
 =?utf-8?B?YW5VRnBzdnNCUEtrT1NyVjRsc1g3UlJOK1djaU9tdk5leEpsU3hBS2tmdlB3?=
 =?utf-8?B?SjZIbWEyUDBVQUM2eGVzcFhFQnk2dTJlR0ttc0MyM2xOcTNlaWpFVjBFVU1I?=
 =?utf-8?B?eWQzUG1nSjNHbWxGdHZxb0F5dFVYTFMvcW1PcXNqN0dEVm9BN2JIZEsra3k2?=
 =?utf-8?B?RXR5OUJsbCtmQi9QQ04yUnFjSlJsaW93dVlld3ZQMlVISXpDUDgralBWejdj?=
 =?utf-8?B?RGVKL0NDaXFZMWVKMUtVTmFvVWpkb0V1R3l1TkRNZzJpN3F2ZEoxR3FJRjBr?=
 =?utf-8?B?TXdWRlpwUkVVSVZScW42RklZSmY5WGgxY0tmTnhDYmk3QXk0elFWaEJLQUJk?=
 =?utf-8?B?NXZabUJIQ3hTMGc5cUtNek1tR0NWdFBnUTY1eURnaDJlbWttOHJFNjhWdlNW?=
 =?utf-8?B?Rjg3ZWFGaVhIWWsrc21wRDRzTkNlYndveUlMQmV1TWhGak14UTV3ZTFsVnQw?=
 =?utf-8?B?NDZIdUVCY2JIeVVjZ3hMZ3c3aUJmbXlwSVZ4R1l3aHZSQXRscjdIc0dwMm0w?=
 =?utf-8?B?bnNLZDl1VmRyRnprSWpxZFNsVFF5bnlQSll5UE1VMzdGdHJKbW1jY3ZCcytQ?=
 =?utf-8?B?WHczTEZUQXErUDlFaFpNMXFiU0VlSk1BTHN2bGhuaHVablZsR2VFYkVBdUZH?=
 =?utf-8?B?aDF6djFZZ1AvQVBpaFVTZ0t4WkZoWkVpU2VzMmFwNnFRUFMzN2RPRDA3K3Nu?=
 =?utf-8?B?WEh4eUkyTWFDNHoxNXZiejVVcHIyRno5b3NkenZORnB2VHJOMWN5OWdFVDVa?=
 =?utf-8?B?S25zZkRtalpHT3YvTTFsWFRBWEVPekZuRjhOY2srMXhwMkFKWU1MUmhHbWd0?=
 =?utf-8?B?VzBDaFAxaWcrZmUyMDdwZkNGaXpVbHpHLzBXQy9QQzN4WTJJdU9nT29mWndZ?=
 =?utf-8?B?MW5WKzVDaitPTU5ESWFrY3k5NVVYbU5wT0dWa3FiY3UvSTBaVjRleklMUWhx?=
 =?utf-8?B?bUNqcjBiSisxS244M09VY0ZaZm9BOEEwalZSRTgyTk54VFFMUXk1amZpbU5D?=
 =?utf-8?B?NmRaMEFhWFprd1Z5ZW9zVHlncWl2YjZvUXRvcjVqcnREYlFnZXpXQT09?=
X-Exchange-RoutingPolicyChecked: RRUnIRWYZDhbfw5xXGfaakv8KY6HbN+oP0lbvnBxmMufeD3k+wSjej/Cfn/vCWcO1xB7Jpi9+HqssVSjA/KPgMspTdi9FzcCHtF22eY60ZQb4copWqy0UCCgLiZHwRyrAfHy6gKgd2fyXPm09gwtGPSoMOcDgVW3QiSk4ciVnYpYaaxuTh7A4NBOYFAp7QFHNB/dWDFKmkAi6KU6E3ZSPkKLhzRrSDLGKy9K/A7q/GVx4rZj4AQtKwj0b1uZ7N8xfr59caj9N8/EEaXqgfe3vL1VYQ+E0YDGiMDd4CvXTUkrrMoB4NBAwNUkg7f0PQX6C6nsUqC3+Wb/aO9lhmhVeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b5de2e-5235-4be4-9950-08df33a9e401
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:41:27.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRPGdR1UfmwhNJZKaAxyGpriISkFRbKrI2xnY6i7wdDAH0s7ALO9pi5i8K1YFxsZeStKijAMcpfjxi/ALoBVuFe97G+WLFnOCULZPUsGnKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

On 10/25/2026 4:43 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] On E822 (ICE_MAC_GENERIC), a PF reset (PFR) during Vernier
>   calibration leaves Tx timestamping disabled on that port until the…
> 
> --
> 
> ice: E822: cancel offset verification work during reset preparation
> 
> This commit cancels the E822 offset verification work (ov_work) in
> ice_ptp_prepare_for_reset(). According to the commit message, the PHY is
> reconfigured after any reset, either by the clock owner rebuild or by
> ice_ptp_link_change() at the end of the rebuild. On that basis the work is
> not needed while the reset runs.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 57e2606655c4..6e1f60d7eef7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -3004,6 +3004,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  
>>  	kthread_cancel_delayed_work_sync(&ptp->work);
>>  
>> +	if (hw->mac_type == ICE_MAC_GENERIC)
>> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
>> +
>>  	if (reset_type == ICE_RESET_PFR)
>>  		return;
> 
> [Severity: High]
> Can a PF reset during vernier calibration leave Tx timestamps disabled on
> this port?
> 
> The new cancel sits before the ICE_RESET_PFR early return, so it also runs
> for PFR. ice_ptp_wait_for_offsets() is the only code that programs the
> offsets and sets P_REG_TX_OR/P_REG_RX_OR. It is also the only place that
> clears port->tx.disabled:
> 
> ice_ptp_wait_for_offsets() {
>     ...
> 		spin_lock_irqsave(&port->tx.lock, flags);
> 		if (port->tx.disabled) {
> 			port->tx.disabled = false;
>     ...
> }
> 
> After a PFR, nothing seems to queue ov_work again. For PFR,
> ice_ptp_rebuild() skips the owner rebuild, and ice_ptp_restart_all_phy()
> along with it:
> 
> ice_ptp_rebuild() {
>     ...
> 	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
> 		err = ice_ptp_rebuild_owner(pf);
>     ...
> }
> 
> If the link was up both before and after the reset, the
> ice_ptp_link_change() call at the end of ice_rebuild() returns early:
> 
> ice_ptp_link_change() {
>     ...
> 	if (READ_ONCE(ptp_port->link_up) == linkup)
> 		goto out_unlock;
>     ...
> }
> 

Yea. This was intended to work if ice_ptp_link_change was unconditional,
but the change to make it conditional makes this problematic. Will try
to fix...

> The only other path that queues ov_work is ice_ptp_port_phy_restart(). It
> is reached only from ice_ptp_init() at probe time and from
> ice_ptp_restart_all_phy(), via settime or the owner rebuild.
> 
> Calibration needs at least one Tx packet, so after link up ov_work can keep
> requeuing itself every 100ms. A PFR in that window would cancel it.
> Examples are an ethtool reset, Tx timeout recovery, a VSI rebuild failure
> that schedules ICE_RESET_PFR, or an IIDC function reset.
> 
> After that, TX_OR/RX_OR stay at the 0 that ice_stop_phy_timer_e82x()
> wrote, and tx.disabled stays true. ice_ptp_request_ts() then rejects every
> Tx timestamp request until the link flaps or the PHC is set.
> 
> Before this patch, the in-flight work saw ice_is_reset_in_progress(),
> requeued itself, and finished calibration after the reset. Later patches in
> the series don't appear to change any of these paths.
> 
> This also seems to contradict this part of the commit message:
> 
>     However, a device reset will result in the PHY being reconfigured either as
>     part of the clock owner resetting or due to the ice_ptp_link_change() call
>     at the end of the rebuild.
> 
> Neither of those paths runs on a PFR when the link state doesn't change.
> 
> Is there also a timing-dependent variant on CORER/GLOBR? The clock owner's
> ice_ptp_restart_all_phy() could restart a non-owner E822 peer's PHY and
> queue its ov_work before the peer's own ice_ptp_prepare_for_reset() runs.
> The peer's new cancel would then drop that work, and the peer's rebuild
> does not restart its PHY.
> 
> Would it work to cancel only for non-PFR resets where the PHY is known to
> be restarted? Another option is to requeue ov_work, or call
> ice_ptp_port_phy_restart(), during the E822 rebuild when the link is up.
> 

