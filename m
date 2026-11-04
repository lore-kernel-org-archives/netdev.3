Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793826390;
	b=fmgfxJO3PE9SvPLf9c/FjCgJ4E9HxNcA7IkEU4Zi85U2ltZyXA/VIF+v3IQJflWRsE3c
	 WoGMcX+WPD0zyptPbXb8JUL7M6FXEy1qFAb0995X6Nl5JxazX+cn4Xzo4MxykZRtv1m5W
	 +1J6EfoH1jMh1g+C7qQ8n5T9wOaN1wrZWG3wIorT9YX5kt5r+bl3C32UGshi1fC/pp7JV
	 fGqOCQacsJP6sP5x1hJwBP0pXV6vyfWuFrjmzOhYibT1f7Gk/ghKxufNz3tiAT8wsaV9J
	 rmFCZv2paqg461e9McDHHT+CDiJk4vH5ZgLhh4xxqw8TBQXLcwaKNvFB4t2NS2H46Pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826390;
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
	bh=LSjKY31tsrEx/xvNgHps80TQuzQuFShL6uM3F3XKL7E=;
	b=1ZAI4r1RwXcnKv2OTNRbatcwL9J/wFDV+uVydsFUf+5pyRpB6Y5KDzqQMYOSSWcXx2ns
	 21IZvBlLjBGwEomxJkIxMgz9KT/AsAQ3RZrhMO92CM4BXQKyC4aYhQMHq3huaIrM9DFnH
	 aH2XRFJQYoHL2y6bB8LJAr8PqDgXk+oAXE+C4AbnBYXQ6jSpj+pdhKdKVgJR/5HrQOu2B
	 c0qMsjq982QskwT7s/SX1HjG5VjwM5MzAIUWXqlc0vBBT4joYHFaW5RxT1qFX/xPOXNbr
	 PYHUAYhb8LrWCdIlhGdslfQSs/VZBwj671h9t5hsMW0Ve51gQc9vHr6TcrvJ7H6BOVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mgBUxyo6;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7E606D81C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBE7E606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mgBUxyo6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793826389; x=1825362389;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pxUWyDuFhGX6rtI5Y0keXOAsyHFBxAnHEcLIzaMDSRY=;
  b=mgBUxyo6NV9Q5OE6xmhdthI8UiTw8EiTuYzvG9NbRBHhCPEkau1W9+EF
   mu0Z2gnORe5aQsarF/W8q1rqpzhrhgDAyKgxol3z71iVv0bMcttHNgF/8
   MbBoIV3MZFJ5Ei51//hcLzJqBUHazx3k9Pg+Ej69jKi9cddl2rH+PGO24
   hMwhgmQ10P4rRAt/BO9AQgOgJk+kJMuipp6l12lxYA5HMD22gyrZP1QE7
   y37aFo8V7290YSvayd9ZwjDop/AO6YXMQDWYo76F7xWEX7C5ItkhHPx0a
   DLwnHK1ToPZlTlM7myh36XPxuFPwGYYf1/iKg51tMXZMksiW0kRGi3zdB
   g==;
X-CSE-ConnectionGUID: vbzBVBXbTmiDA/6dCJhh/Q==
X-CSE-MsgGUID: Qx4n9hefTYGSfBwNeDkbMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2592862"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2592862"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:06:29 -0800
X-CSE-ConnectionGUID: RHqQx1hiTL+0UQKu+ye6EA==
X-CSE-MsgGUID: qi4TLjaMSmyR2sVHgyE74A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7143955"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:06:28 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:06:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:06:27 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:06:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReJQSGRAAALxChWaKxzZhFMB2tiz3x329BN1yPYIX46cbzKk49kjQQ6Q+9WD0ejfPC4ffs0tubuB9fruBpQgZ6kAnnot778+aneI7Azn2aabnQA0Pun1GIbEgZg5e4WBgj4EMiabVvgGySukmpLrHv+xExa8Hn8I4szW73veSxP2z9e6me+i6xT5PmtliGoHP8RaEaVfqT2Dvpv1RR+XVGdL+LbUA3DgnpbodWf1mxFA4DyJhZ3fVdEfge+sjG1TJ37gWg3VPnvTrICN5vHdYT+Fyey16gvlg/bM+p46Nkbkxd/5bGRd9TpV5KahEZaGAcHIPc1WdtX5XSzf5wvx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSjKY31tsrEx/xvNgHps80TQuzQuFShL6uM3F3XKL7E=;
 b=dFpeWn4CnKLmqVOAaaEOp+Q54Ft1t0Am73AnFUnHs4EFpxexmHCNlLk1HrU1hy7AHfc2VgCtNCLJ3XFCvkISTRHGsIivsOL+utRZrlgq0tuniwhOjC3KLk0zIAluQHi3/U/jAZcZTUEEPMg6cvom3EGhmUHxKcIcMN61podTQlIWNSQtbfbp84tOKh8k8N8xBNQqlbIWtMj4m0ebhkjM1Rd6r5B1buRgLBxT4TSKkI/bd0tYe03WCUAO6WQL58gbxOUTJ5KOdR492+Nt3IAPvCfbHl7bQUceAuiET5fuEHIazQ+cUaPN36YNOSX5i26bfRnG6aQqGHw6WskvTpVgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CC6PR11MB058488.namprd11.prod.outlook.com (2603:10b6:170:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:05:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 21:05:54 +0000
Message-ID: <701e6e51-8815-4002-94e3-c81958b8c1c3@intel.com>
Date: Wed, 4 Nov 2026 13:05:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ice: E825: perform a soft reset when starting the
 PHY timer
To: Paolo Abeni <pabeni@redhat.com>, <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<poros@redhat.com>, <netdev@vger.kernel.org>, <grzegorz.nitka@intel.com>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>,
	<anthony.l.nguyen@intel.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-3-72128d1dd928@intel.com>
 <179339643889.3131.9026864983755179552@kernel.org>
 <b0f30a78-4f23-47c4-9ea1-dedc45abf2c5@intel.com>
 <5178b7f6-6b2f-4dde-8ed4-d6912024f23e@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <5178b7f6-6b2f-4dde-8ed4-d6912024f23e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:303:16d::24) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CC6PR11MB058488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a10054f-8e30-4ff0-737c-08df3ab769f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261028144727099003|261026140227099003|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 3c33snsOEVOzqGQlJPMleZeYhTclMyHtiFQ/wx6+PAYL6WDUDcNqG15QBJ8KAOViJYcwRNa6G/nqCyXjwQ7NQkN7edjkYXt71kTxVAtTInC7JCRUud6BqqlfwPaPjz4eZGPOfCByXIIO+SVvYeGWeIBmzG7zIPnWbLvEZ7R/wsAIQg2VT9gDi0T+pp3slXW27Rk0zZTdnG5iNWRblyFyXrmtrzv9Csor+qm3TKkfJDuo8RFch5nUZ8gDd4Hp6VCUtGNMffhQEJtnm0TSSKZg2N3ZO81h+/IWRG0rWvo6SrUhVyait8p3MA9YklxLT87DDQDSTE9S6bzDoKc98xOzgHisFnyN2OkfX8tW8OaCBRIOkFXUDMFJ9lBkMXTj+tSm5n22Fl+pXU5lx4xXYMH25QJA5cVCODO5PKfia9/Rv0FGl3jbAYYKMCVeEBeR4TGIUV4ruKFGlHwVBoSmTx2CogfTU3OEOgtUeiEGPLJVIfPGXOUwPdtIXyonh3bNMknPHxHaSkTcTmdFX8booPzcC06+Sis4z5JmrO66XbFEKKQwl4v95ptSP6eTBL2/dOdvI+uzkYKkrnJ5ku7j/x+bBqmjsZG+ODp3w7tmeVEuOjuetQVNjQeecCQ/VeIxf8of/9Ec78BL77GLyoDIEC3Su8MzLNRwIRVygymFx51K1eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pvWGZkVWppRHlqMHc2S3VyNDlvYTBQL0RCeU1XMHYrc1pwMEc5KzBJOU9y?=
 =?utf-8?B?RW5FSnFkQkcxNGNCRnJJbDZFbGNLc3Q1WHo5VzZHZ2RpTGRCaGwxb1B1SnI0?=
 =?utf-8?B?bE00QVNqNGNaTkRJUzNoQjNTQjFkN2gxM0JMUGlQQjFseGhtNENZZTdGN2ZQ?=
 =?utf-8?B?M1lIankwcTkxdkNMRUVpQVIzK1pqcTNKVTl1em45STREY0JIRU1iVGdnUTc4?=
 =?utf-8?B?QlRPOVh5VDU3VkNLa1RIdjV4SEhaSk5WSzdEdXVzU2tzTXpGUHZndUZnNU9r?=
 =?utf-8?B?K2xxRTZRTGV6MVZOQWZNVkNGNlJtZDN0MUlKTVA4M1NlUFFKQTdLeXRmMWxy?=
 =?utf-8?B?NVdVRnhZaDdHYmJrRXBPTE9ML3VBL2hubk1IeU1DRUo3UkVock9PVGlwL2xm?=
 =?utf-8?B?YnYzTStqT0x0Q2NoTVNYeVRpaGQxdE5Kd3E2dWFzSkE0eFRlOCsvencycUYx?=
 =?utf-8?B?S2V3UzJlS1pjRHQ5STkyQWxSWVRlNHpiUGRBUENyamV2SEFMMDl6Z2txa3l2?=
 =?utf-8?B?SjVTZ3RyUVQ2c205VFBweXFHdkgzaVprM1JSR0pQaEdIRURJRXIzSDFlb2Iy?=
 =?utf-8?B?RVl2ODVOcDNVTTIwdGIrZnNyTkJrS0NZSk8zcGIzamJLa0dMWFF5cERLVTR4?=
 =?utf-8?B?eXA0WDUyYVoydmlsT1NzbkdyTUtYcFpnM0tSOCtITUFySHFNSkN6bUszTGpH?=
 =?utf-8?B?NDBnVVRTUElKYXFha3dYenV5Z2FmZ3hOOE1LZ0xWcVY3ZEYrRkxwUXBxam90?=
 =?utf-8?B?ZHdjWTdSNWVIeVk0K1JTeVgwVlJFVUhNemJOL2s4VVRTZmJnSjNJMk81RWcx?=
 =?utf-8?B?a3loUVgxUHEvVzRBbFFnUzFEZDNhZ2VDUHFFL3lEeHhoZjluT3luTmRreUVh?=
 =?utf-8?B?eWx6Wm84NGNza2t0WlVlam1ERFFSM3cvQ0txdk9KZ09qQzJnSUVVRkZjY1dx?=
 =?utf-8?B?NkRhVjFkZko4Z0s0RVdaWEN4clBtdEtRZnlqcW8xQnRxZzFOVjJwUldPbnZx?=
 =?utf-8?B?bVhFV2IvU0ZjNEV6aUhjWDgvRlVXSm1Ob2NTVVg1S3p4WlNyZkZieU9vZWF3?=
 =?utf-8?B?Q05kREhkc2RIMGdJd3R2bGMxTG1BVlFwWVdFenhzcmhsK0JGS0ZSK1VBcDZ5?=
 =?utf-8?B?bHUvTnhjV1laQzYyRXlaaERReW5HcXVubzEzZTRNL1dTTmJ0SzUwZXVCU2g5?=
 =?utf-8?B?NjVRUno0WCsyaC9HTytsVldDaEFJTzhaL1pUOGdOUmxranp2NU5HTzlHRTlL?=
 =?utf-8?B?bkhpRjBDbzNCWVBDOGZhM0tyU3llVTRGZS92NndBcVhiRmJWOFcwaWsrQ3Uy?=
 =?utf-8?B?dmxheG1ZcGhhK0lWZDRxd0lRVGl5aStrbkswRGZDU1pmcEYyUVpvNXEwb0wz?=
 =?utf-8?B?Sjh6WXpQK3pJK243QzNudG9CcktRWXh0Q3hKVlpmRExnL0J2akpDUUVYQWFa?=
 =?utf-8?B?aU1Mc1l0Y2ZqMHhUNmplck83bWpzeUg5N3ByY01TZ0w3ZFIyZE9NbDlFNFNF?=
 =?utf-8?B?N1htUmYxcWxSVGRGMGRkSldjQkFzYW9XSHB3MG81WDNLS2M1M1dSVSs5UE81?=
 =?utf-8?B?R25VTGRiWXVhQ0RjRGttWjF2YXBwUTE5UXdKNGErQ09IUnYwajNFaWRydnFQ?=
 =?utf-8?B?Q1JxSnJuNGVJZDBaR3ZKMVFwYnhKSS94UFhiMlpjZldYL1gzMDZEdmlrNHZm?=
 =?utf-8?B?TXhaTFltN0xaMm0zU2FrRE9VYXZZcncya3hPUVVIUU5JYUQ0bllqS24rSWFE?=
 =?utf-8?B?OEZCSDZ1Zm02NFU0RWk3WTRSUENhVHl0d3JlQ2tIbXlMTEt5SkYzOEM5aVR4?=
 =?utf-8?B?VC9OdDRvWS84ZDM2Z2hBa0xhYXJHRDEwTE5vMk1LNFJoN3NYQ2V3blhYRUZB?=
 =?utf-8?B?UWJjQXNRVy9GY1RmdGRWbTFkdHRqNytsMXNHeTl4bW9meG9uNmMzU3cxcjd2?=
 =?utf-8?B?QndiK2QwRXgrSENVUFdSTDBhNXZFc0xrME8yeGp5bGJqZ0cyMWhaWUZvLzZN?=
 =?utf-8?B?YmdmSUVTNURGR2J5K1d2cXRONS9ranlrL29TdEtYT0h1ZHFJZUhJMDJRMHlF?=
 =?utf-8?B?VGg1WGxwbE5wSjFHaDRJbCs5aEx4Si9MY0pyc0NQZ2tZSGFobUF6UjlPN1RZ?=
 =?utf-8?B?MUNuV2w4MzlFZ0kyZW9mM2VlVUpyM1hZLytYTmxWR3kyb0RITngrRVZwSlNz?=
 =?utf-8?B?SXFlSkFscEkzSXMyS0FYbTFFMng3cHRDMkhWTjVSWG1YMGY1R1cram5DTG5T?=
 =?utf-8?B?dEVMbXcrZ01CUUdRa1ZMSkhqWnlPQk9EQjBxQS96MG1uOXN1QU5Hd3AvWkJK?=
 =?utf-8?B?ZEhGaHcvM2IxekJuRzBWTUJ6VVRTYkJCYXdZMnJmTEYrbElNdGI5OHJraXpM?=
 =?utf-8?Q?2kcsFqd/s/168Oio=3D?=
X-Exchange-RoutingPolicyChecked: FpUqDL8MhcFZjYrPYH6Q46nYoVZM7xhiOxhW0eyim1i4b2tYMIdVS9T3a1Fhh3AqNMaEjKLq9ATzi1t6D6kIOpn6eZW9ETvQy7pGblpsXukrInlvQqYtuTJwxtAbGITyqvMq++d3b52hTVwGQWS+cOn2XgWiEb3B8y6m4QJiRIjAeVYFcuVlVWqUR9RtZdLXaw4WHiARtPNT0cyu5pteVznrMHFNBklyivktuBJJNZqqkVy/wupJaQRLuglZW+Hdh+EyPBr1Q/JnLBCdUN5jbS8561BPvHTJ1UUy1sdSygjgcU9nqqUc54dVafFQDNy4czJdbOrbuakLtxoSKd82dA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a10054f-8e30-4ff0-737c-08df3ab769f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:05:54.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9uwM3h8S10Ob+LyMVrikeb1SGr9o5v0gZuZXZ0gvfQQtB6ulZJtiR2JJOH1mWNMZ4K2bMxe37PLy/1Rh6pqcFQFYpQzdaaRxj2KWGVEszI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB058488
X-OriginatorOrg: intel.com

On 11/4/2026 12:17 AM, Paolo Abeni wrote:
> On 10/31/26 02:01, Jacob Keller wrote:
>> On 10/30/2026 2:40 PM, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential
>>> issue(s) to consider.
>>>
>>> Critical: 0 · High: 0 · Medium: 2 · Low: 0
>>>
>>> If you believe none of the issues are legitimate, please reply to each
>>> issue of Medium severity or higher and explain why the AI is wrong.
>>> If any of them are legitimate and you plan to respin, please let
>>> patchwork
>>> know by including "pw-bot: cr" as a separate line at the end of your
>>> reply
>>> (one such reply per series is enough).
>>>
>>> - [Medium] In the E825 link-change restart path, the software Tx
>>>    timestamp tracker is not flushed, yet the PHY timestamp memory it…
>>> - [Medium] ice_ptp_phy_soft_reset_eth56g() now runs on every E825 PHY
>>>    restart, including while Tx traffic is live, but in-flight timestamp…
>>>
>>> -- 
>>>
>>
>> I believe these remaining issues are not realistic, or minor and not
>> something that should be holding us up from getting these fixes landed.
>> I had originally tried to mitigate some of these but have gotten so many
>> complaints and run in circles by Sashiko here. I do not know how to
>> modify this so that it won't complain....
>>
>> Trying to break things into smaller pieces seems to get complaints about
>> the things that we had planned to fix with the full series. :\
>>
>>> ice: E825: perform a soft reset when starting the PHY timer
>>>
>>> This commit adds a call to ice_ptp_phy_soft_reset_eth56g() in
>>> ice_start_phy_timer_eth56g(), so the E825 PHY timer block starts in a
>>> clean state. The soft reset sweeps the Tx timestamp memory and resets
>>> the
>>> PHY timestamp counter before the PHY is programmed.
>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/
>>>> net/ethernet/intel/ice/ice_ptp_hw.c
>>>> index ef59b34ba52dc..ee945ce08eb72 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>
>>> [ ... ]
>>>
>>>> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw
>>>> *hw, u8 port)
>>>>       if (err)
>>>>           return err;
>>>>   +    err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>>>> +    if (err)
>>>> +        return err;
>>>> +
>>>
>>> [Severity: Medium]
>>>
>>> On the link change path, should the software Tx timestamp tracker be
>>> flushed before this runs?
>>>
>>
>> I tried that in a previous version and the AI pointed out all kinds of
>> possible races that might occur then.
>>
>>> ice_start_phy_timer_eth56g() is also called at runtime. The chain is
>>> ice_link_event() or ice_up_complete() -> ice_ptp_link_change() ->
>>> ice_ptp_port_phy_restart(). For E825, that path only marks the
>>> outstanding entries as stale:
>>>
>>> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
>>>      ...
>>>     case ICE_MAC_GENERIC_3K_E825:
>>>         ...
>>>         ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>>>
>>>         err = ice_start_phy_timer_eth56g(hw, port);
>>>      ...
>>> }
>>>
>>> ice_ptp_mark_tx_tracker_stale() only ORs in_use into stale. Both in_use
>>> and tstamps[idx].skb stay set.
>>>
>>> With this patch, ice_ptp_phy_soft_reset_eth56g() then calls
>>> ice_ptp_clear_tx_memory_status_eth56g(). That function reads all 64
>>> entries of the port, which clears their valid and ready bits. The soft
>>> reset then clears the ready bitmap and the counter.
>>>
>>> Take an in_use index whose timestamp the PHY has already captured but
>>> the
>>> IRQ thread has not yet read. Its ready bit is now gone, so
>>> ice_ptp_process_tx_tstamp() skips that index on every pass:
>>>
>>>     if (tx->has_ready_bitmap &&
>>>         !(tstamp_ready & BIT_ULL(phy_idx))) {
>>>         if (drop_ts)
>>>             goto skip_ts_read;
>>>
>>>         continue;
>>>     }
>>>
>>> This continues until the 2 second timeout fires, and the timeout also
>>> increments pf->ptp.tx_hwtstamp_timeouts.
>>>
>>
>> Yes. This is the expected path in the current logic.
>>
>>> Until then, ice_misc_intr_thread_fn() keeps re-arming the interrupt,
>>> because ice_ptp_tx_tstamps_pending() sees a non-empty in_use. Each pass
>>> does a sideband read of the ready bitmap. The skb reference taken in
>>> ice_ptp_request_ts() is also held for that whole time.
>>>
>>> Before this patch, those entries stayed ready in hardware. They were
>>> read
>>> and dropped right away through the stale bit, and were not counted as
>>> timeouts.
>>>
>>> ice_ptp_rebuild_owner() already flushes the tracker before
>>> ice_ptp_restart_all_phy():
>>>
>>>     /* Flush software tracking of any outstanding timestamps since we're
>>>      * about to flush the PHY timestamp block.
>>>      */
>>>     ice_ptp_flush_all_tx_tracker(pf);
>>>
>>
>> Yes, but I am now certain that if we added this today it would get
>> rejected because the flushing appears to be problematic at run time. In
>> fact part of the other areas of the previous series was done to help
>> prevent this, but was undergoing its own challenges.
>>
>>> Does the link change path need the same flush? The timeout does
>>> eventually release these entries, so the slots are not lost for good.
>>>
>>> [Severity: Medium]
>>>
>>> Could a timestamp captured during the soft reset window leave the PHY
>>> counter and the timestamp memory out of sync?
>>>
>>
>> I do not believe that the hardware will actually perform timestamps
>> while the soft reset is active.
>>
>>> On E825, the Tx queues can be live when this runs. ice_up_complete()
>>> starts the queues before it restarts the PHY:
>>>
>>>     netif_tx_start_all_queues(vsi->netdev);
>>>     netif_carrier_on(vsi->netdev);
>>>     ice_ptp_link_change(pf, true);
>>>
>>> ice_link_event() also restarts on a speed change while the link stays
>>> up.
>>>
>>> ice_ptp_port_phy_restart() sets tx.disabled, but descriptors already
>>> posted with ICE_TX_FLAGS_TSYN can still be sent.
>>> ice_stop_phy_timer_eth56g() also leaves PHY_REG_TX_OFFSET_READY set, so
>>> such a packet is captured as valid.
>>>
>>> Inside ice_ptp_phy_soft_reset_eth56g(), the memory sweep runs about 5 ms
>>> before the reset is asserted, and the reset is deasserted about 5 ms
>>> after that:
>>>
>>>     ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>>>     ...
>>>     usleep_range(5000, 6000);
>>>
>>>     global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
>>>
>>> Suppose a packet is captured after the sweep but before the reset is
>>> deasserted. The kernel-doc of ice_ptp_clear_tx_memory_status_eth56g()
>>> says "the soft reset does not clear the timestamp memory", so that valid
>>> entry stays in memory. Meanwhile the reset zeroes the counter and the
>>> ready bitmap.
>>>
>>
>> Again, this is working on the assumption that hardware will actually
>> perform a timestamp while the soft reset is asserted.
>>
>>> Only the 2 second timeout would free that software entry. The entry
>>> could
>>> still be read, for example by a concurrent reader, or depending on
>>> how the
>>> hardware handles reuse of an index that is already valid. Would that
>>> read
>>> underflow the counter and stop Tx timestamp interrupts, as that
>>> kernel-doc
>>> warns?
>>>
>>> Should in-flight timestamp requests be quiesced before the soft reset?
>>> Packets captured after the reset but before ice_sync_phy_timer_eth56g()
>>> look like they are dropped safely through the stale bitmap.
>>>
>>
>> We did have changes in the rest of the full series to address this by
>> having the driver stop new requests while the timer was stopped, and
>> marking things as stale ensures that the indexes won't get released. I
>> had also tried to make sure that stale packets didn't increase the
>> timeout counter unexpectedly, and to change so that the skb was freed
>> earlier. Those were all delayed because of other issues on the full
>> series.
> I think this series can be merged as-is. I also think it's more suitable
> for net-next that for net. Unless you disagree strongly I'll apply it
> there.
> 
> /P
> 

At this point I'm happy regardless of where this merges, I've been
working on getting these fixes in since late July at least.

Thanks,
Jake
