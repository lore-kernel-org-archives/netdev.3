Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793129559;
	b=Oydmx26ATWfawQxWGdzelZwAtC21AEBPDgmNWqdMM92B3/V4m1hO1qMctl0SqSTTbkhW
	 nmqVaApUL9hrhoIrAc4N+raB//qPb1QBtwVKEVXnsZCZN9N0TfqPJH7r0O3Pw+9XQhv1V
	 oG1QuAwjZoXzMBXDzWxKT4Xjptsm8fWxCHO7qgYX7rDnnIWOS3FHHTULy5QZNm6Odo0TT
	 IwG0SCH8LM2+NoZ7VLUG5Y9etW5kNWCj+NFfJz0l0ggjbwNUGlP/yyLiT7mX9P236t/DQ
	 GHoHieYPOgc6bSxrym+WBXu+p72wevr1WPVFD2YLlojYXPux/BXnyPKtUEihYULeQ8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129559;
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
	bh=J8zaQMn72W189bTxeC9dTj6qMpCvwsJsPuV2nO5GkRA=;
	b=DH90g2uZFl05H9sfdJnJE3Rux5aoyBKd83uZ5oY9fLSgiVISCIsJtApMiGWEWaODqiPi
	 JAMDMQWOYyBMlGNFo92LdptlKYPYOlrQOJd0QzbZnxJY5Gkgks5SOezzIFtwFFbDjgRux
	 Hr63Eu1nwtB/5eqCnqzLNIxa7fcd8FFS+7xo89cnTyuVc+Ngu0C1HHiyOvlkqFChMhzW+
	 83azz8KCOYDU7T0MENL99oO7wyBxcip+fXuVYvBC0y6Xg8IBb8K7VimuvRvD+cy366VN+
	 HNKlMzzzSdocwFyxiQn7sRPb5m6mJHBCAEizI7JrPoJfOhWlpcgJu8Hfk0iweI9TgJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bUHPy9of;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9130606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9130606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bUHPy9of
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793129559; x=1824665559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G4mdUntIRJVsRkcpJCQ2jbvSQKRRRHGO+4H+MoeD0UU=;
  b=bUHPy9ofoCRKcskasSbfM9CknyiqyEldR4y2YrD9bwUwsESoJ69yMN8s
   u/pk4RbiyMqWII1EFm5d8BUcDk0hYGRcmuU0IA9rBvptGg2VM23hIa4aY
   KM0ZSAboilfLmKzft1bSFwY2db00DkORE48UzKuZINBNY/jNzgAvXKOcx
   q41dc0sZi31ys47nSGv6wCrQfZC3peh3ZVkDN0DI5rdqePwqF6z6N7RpW
   C41/W2twp6Yza4saa2gIdY7pj8kGsee4aQb9RXjUEyGSIuvvaU8umIQDQ
   q8Dl3twzf5OQWe+2Ow+QH775jdAc8i82VFQ95xA9nIuKKmvDqomK9khk2
   w==;
X-CSE-ConnectionGUID: HyeZVZCaRsKj5YWNz+fWQw==
X-CSE-MsgGUID: QDfUgAFvQKGRVi17xq50WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1932683"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1932683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 12:32:39 -0700
X-CSE-ConnectionGUID: jDsPG72HQyKwWjyZhMHrWA==
X-CSE-MsgGUID: q5hKbw4XQQa2U83opbldPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4718499"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 12:32:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:32:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 12:32:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 12:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtTnflsFBa4eAgUCis4ZCRVyFBrSqGJkaDKO4+1T+uZiQ8qIzTlCTjB3Iq8YJRlrrOzpt/DHTGWHUOZ+p3v8t8ujgBHvs4GiqmL3V5lMyeHrtLU//M4eBCosTOF55ubsmcmCtsZqW/PdvwJTAq6pt/vvzRLkFPerN6wuIBWGs0Leb5sxSR90v4kEOevXQtAeWkOFHG9vtQ43+z0e1tElTzHQy3o6lU5bHIDW/hEfH3UahQYOLpyTqJB9MIMsqoDPSxbOiKGP7oHJpK16kD/G94jLyTFTLHCI78MC+oqkS9x/3KhMgveEB6xVNIXOwFvW41XYRJC09BV4IyXS1ZbNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8zaQMn72W189bTxeC9dTj6qMpCvwsJsPuV2nO5GkRA=;
 b=B4H/0kt4+tJbDQNmlr11yzPUktf1zdjJp5UUxa3G2tAfMUqmbe/y3/CcWbjxhjPuLDyoXRmXhs6zMdpNWgKbfvOdaDAkAMKqlEBC9rf3FFmlduK9etR3rO79s62xh5THcKR/7ds5rgqTTlAKPB98jS1+h9jmPQU1puR08p3EvJ8chKPS1Na83xBbq2iqxc6jDsd6djWS3k3QBuU+vRBKjGAVE2rOfeOioI/xWKtLK+i6HWGOf6ADfbZr9Oc1A8TRWN0QpHhbwaC4SQbanuOmcxu8G3YF5yJf02RiyZFZ2NG5uZfTBuYpVB6EIJLd5/GStT/WQWZH16eCieweYHB0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by FT1PR11MB755572.namprd11.prod.outlook.com (2603:10b6:170:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:32:33 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:32:33 +0000
Message-ID: <0f0a865a-cefd-4896-949a-2b4d72121b4a@intel.com>
Date: Tue, 27 Oct 2026 12:32:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 00/13] ice: E82x: timestamp processing logic fixes
To: Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Petr Oros <poros@redhat.com>,
	<netdev@vger.kernel.org>
CC: Grzegorz Nitka <grzegorz.nitka@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
 <5abb5015-eee0-41a6-a4b6-5ca9ed0a9f0f@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <5abb5015-eee0-41a6-a4b6-5ca9ed0a9f0f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|FT1PR11MB755572:EE_
X-MS-Office365-Filtering-Correlation-Id: 336c1754-6b2b-4786-b1ac-08df34610bf5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|56012099006|261026121527099003|6133799003|18002099003|22082099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: /bPguwM+Wzd3FAlNkfHWQ6POOmaNXsygULxJ6BLIbh0e626TpuNbF5RPa5LQO+cbjSeM93H+h49S78a8NWCvi2jTxJ1hmYDAs/qXnzLROt/lxkJkO9RppolkznaPh7VVWNQ1bltehcvp3kQaZGWdBtRsiHqRx65HfjhLeoXkmem/OPDo6xoQu1y/+xDZkSrcuP2vnNqHuEda9OCzT08+nirkXx6+J2URniYcJ3wE0eLtmawIXwnujWJtzFiRnPVegX50HuDPDFkQMr6cuEW8X580DHuygLnVOYs1OFnAFudISALoQ4zXuTP0E6ngVBl/ogEA9xdAMwuU1J3VZnnCIoGt/jJonBl27vNbzL8oLYiLsE1WrDsX9XhRsuuUdpqZJcgE1DSfAwKRK9cuMuOplcER7hqVy0kz+TVVxmcqZ34GCyI4FMWo8Jf1JZ3SzsPVBOhwV605S7VBI7jqmfgspNG47zp0Q70LzVKcSJkN4tMSacAQNpWCtfLbtnSFSizU1YeC0UxIX0zihs1rrYwsuMmgk3LHKRckxMnWJSd/3+sRe1nAG2shqkFogmHp+AvG9GLk+Bt0C6ktOvWlqrBqlmbOj9RsYJrUPoUc4foCHVLa0ldge0JZNXOL7rfFBWjaFQm1MJ7NPjI7ivQXdIn8QoD2I70VIz8+7vCJnsp10U4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0d2TEhsTHN6cllHYjdmY25JeDhTQWtCRlY2dXFYanR1Z3Z4RlhtZEY1c053?=
 =?utf-8?B?Y2cxK05SQkgzWFVFNEZQRWRvQVQzRkR3bU93Q1VCUHYyZUdjNUR6RUlUQWhS?=
 =?utf-8?B?WUVxd1BtUDBEbHA4b0FuaVlFTm5vVDdERXRSMmJqeWpBYm9PZ2tXbVl4ZFJC?=
 =?utf-8?B?N0Vmb21qTUpxMnVoR0V2L2hReU5WV2dhaWJZa3FPL201S2dQWnR4RTZ4OFZX?=
 =?utf-8?B?SW85elhwMEE2Z1ViWlFTdnRIL3BwVHdqdzFoWDdmU2Z5bGRkeXRnSWk1djBM?=
 =?utf-8?B?QU9DRkdKcTUvN1VVM3pFMG1JMjczYUhZT0tacFkyR1E5OGxJclN6UVB4RE1V?=
 =?utf-8?B?dTZwR1VBVEhpclZZdXBLVEhUZVlxaXRVUEphRTQ1NkV6ZExZdjFxRnk0NzZk?=
 =?utf-8?B?OGtpQzFKWTRpWldIRi9aYU1NUlVmd20ydkFVeCsvNVBIcWYrSnlkS3RCMlJr?=
 =?utf-8?B?OHJtbTBicWlVK1N0aW9KdG1XT1ZHaUNSQWo5OHhLQjZSYWRLUlZsWHpoQTJa?=
 =?utf-8?B?UzJGVElLWTIwM1V0MHB4STdhckZONGI5ZXBtdlIwQzZnaXE3cU1HbGlURDJ6?=
 =?utf-8?B?ckVJQUNJTG1aNzZFaHJmYmdJVjdCczlpaXRMV09uMDdyTGwxc2NzUzZCcXZE?=
 =?utf-8?B?aDExZnVYL0YwdkZxdzU3V2ROeW10MlVObDFiYVlCVmc5OUpDK3BmdjdxYjBV?=
 =?utf-8?B?VE80SzdTQ21QVFk2WVJDdmQ0bnFWM3dCNktIK3krcjRNU1I0L2RaKzNjUTFV?=
 =?utf-8?B?VTNrUW5MOWZCY3YzQXhLL2JDVkN5VE8zOHpFVHIrR3RwVEZZeVR6R2RtYmNB?=
 =?utf-8?B?R29FUmU0MGFRc0oyUHkyeDZxaUt6NUp4TW5JYlFEazdYTDVSYnJFNGN6OHky?=
 =?utf-8?B?cmhLNnVjZ2N0WWR6TUxnLzBicmFlb2VibEdOTzhIZkdrOEZwVDVGd05ZMkg0?=
 =?utf-8?B?bklxZzJ4SlJzcEovb0Jwc2R1c25wTnp5SlZOR2dHdElqdWljbHROdHlTQ01Y?=
 =?utf-8?B?aFRId2ZjdDBLblZTYitrSEdDVTBOenlwdktjcnB2ZHdQUG1USjAyZWNkVUcy?=
 =?utf-8?B?MWtFeE1DSjFIZ3pkMlRjMDRGV2tpYWljc00zNmEzbFJ2SkUxVjNNd3lVMS80?=
 =?utf-8?B?bTZ4UFFEZGFpbkhnYVdxZkZlN3JOb0RiSXEwaThRUWJ0Q0hldjZYL3FyQjhJ?=
 =?utf-8?B?VkdKZG1MNTU1ZEZ0YXkyUEFpY1VVbjUyMGlGSGEyWXhPTHdoa2lpajRad0xN?=
 =?utf-8?B?MkZNZngwVm1iYUJlMk90b0xoOUpibkNURnh5NWFBS2l6ejkrU1Z5REk4cUJX?=
 =?utf-8?B?QkpiUFZ6MEtaZkNoUW9GckQzTnRURU45VTJITE5tRkh1WFdaM0lOcy9CTXBF?=
 =?utf-8?B?Z3dIWEg1NEpQZ2RBaFI2bGZLcWVTMmNSOFVGVGRMcVMvNXRIM1YvNkRId0JZ?=
 =?utf-8?B?RmdkTHpXTWdCWEZZbEZVUVE0TWJ4aXIybzhXSWhsNXZXamRuMXVON1k4NXFJ?=
 =?utf-8?B?ZlZzSXY1amJ2YldTRXp6VDdKenpxQ2NwMDg0NnBQTW16cDdiZGJVYzJ2eWJ5?=
 =?utf-8?B?czNtY2xyMG5TbVhLSUVXcDB1WU93cU1EOFR0RjVPbGFwUjVmSXA5bzQvYm1w?=
 =?utf-8?B?RTFHVC93dEUxMXQzak1FL3BFc016RkFGbk9zM1FjdnR6RGFiNVRVbkk1ZDZB?=
 =?utf-8?B?R1czZEhsbm0wVDgvSEZ0VXdlWERDS1RzTDJJYVFIY0tCd1dtalRCM1FudXQ0?=
 =?utf-8?B?Y2M4NDdGczNjeU5GeWZwOUNDdDA1aTlSQWVwWURJYno4RDZ5bGdZcTMvSkNH?=
 =?utf-8?B?M2lxK0xqYVdNMFdRaTN1R3MzcFViV2cvdHRxY0hEZWpwUkFvUjgwdG1ZZUg1?=
 =?utf-8?B?Mk5sTkVrVFJBMytxd3JNWlRDTzFDSzNWSms4S09Fdmg1dll4MU4wRUFvcU03?=
 =?utf-8?B?YzU1S2thRE53WXdkcWpubVBxcy85R3hGUGszQUE3dFluVzdpMUZMNnRnUDZ3?=
 =?utf-8?B?NnY1YVVOWnRIZ1FoL1h1NGlQZUh0SlhUYTgwV3JETHpFSWNOMmNySW9kSmsx?=
 =?utf-8?B?MVJZZnNZNlhmY0V5ZDUxQXUvQkc1MXRZVWxEdFEwb0tTN0ZSSG8zYno3ZzdG?=
 =?utf-8?B?cWoxRmQxNzJJeEl1NWRQbU1mSEFSb1ViaURIdzVXZGtaL0wranUrV0VJT3Bm?=
 =?utf-8?B?SitMT0o3L3dyWWZBbXRYZmxKdzJTOTdabUczRkNVRmZKa3FCRkdRQSs1Q2ha?=
 =?utf-8?B?TXNyVUpNYkpjQzgrNys2VlBIT1d5MjBwS0xPYlJYWW5wcDhKa2ZjdGF2Q1Vh?=
 =?utf-8?B?d25BM3R4MU1GMTJ6WFhxeDEwRDRzUVlmYi9IazQzbTV2SlNOWDgxTnJ3Q1VO?=
 =?utf-8?Q?08V1xSsZXJZsIpw4=3D?=
X-Exchange-RoutingPolicyChecked: DO1uY+KsiVoHIa5NvfgypdfVWRPBinlfj4rS4BH+cx+I72jVGfQg9bgMr5BCCgAO6VQhjjLjKsjJ0z5l00JWOO8jkcFLF/jR3VkAc9iPea0P5ZA8g2ViNYeb3ez9bPFRnOdKTitxKtMYGEglB4FGhJ7Z1awgeVAse56Ux4olFAxDO2N5IMes/BNHPxqpkF6ph+V8lkNcy6khgXW2jkv1YgWq5/S3CGbjxQPxMcH6VKfk2K4vKBUwCe49GMvNY3yNzfV3Qsq1MFYK89dpxdBeprC/vP2sxKJhT8ukouGs+0+PvQN9B+/RkMlmuB68oOpfYjy/yqF4QD3KbW5r6rkY9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 336c1754-6b2b-4786-b1ac-08df34610bf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:32:33.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EW6jmH2dRFcrBUoj878VDsgr0ndzQ522ytYDqx/E2a21hPpFM2OTqzO+N9U9NyCDX3RDpAeOMjVd1VEgs6LYUV/t3+hgjAdsj47NOrhn6Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB755572
X-OriginatorOrg: intel.com

On 10/27/2026 7:40 AM, Paolo Abeni wrote:
> On 10/22/26 00:12, Jacob Keller wrote:
>> Jake Keller says:
>>
>> This series contains several related fixes for the ice driver PTP logic
>> relating to timestamp handling and device (re)initialization.
>>
>> Of particular note is some changes around the handling of timestamps that
>> are requested near device state changes such as administrative up/down
>> cycles and link change events.
>>
>> The E825 device logic in the PHY has an internal counter which is used as
>> part of the "threshold" logic which determines when the device will
>> trigger
>> an interrupt signal from a given PHY port to the MAC. This internal
>> counter
>> requires some precise handling to ensure that the internal device state
>> remains in sync with software expectations. Otherwise, the device can be
>> finagled into a state where the PHY stops producing new timestamp
>> interrupt
>> notifications to the MAC indefinitely. This in turn degrades the
>> timestamp
>> processing latency and results in application failures for common
>> timestamping applications such as ptp4l.
>>
>> There are four major categories of problem resolved by this series:
>>
>>   * Timestamp requests made while the PHY_REG_TX_OFFSET_READY bit is
>> cleared
>>     will increment the internal counter, but leave their valid bit set
>> to 0.
>>     Upon read, the counter is not decremented. This leads to a desync
>> of the
>>     counter and blocks the PHY interrupt.
>>
>>   * Software logic for tracking timestamps incorrectly cleared in-use
>> bits
>>     without waiting for completion in certain cases. If the timestamp
>> *does*
>>     later complete, it leaves an "orphaned" ready bit which is not
>>     tracked by software. This results in the internal counter becoming
>>     desynced if that index is re-used.
>>
>>   * The PHY timestamp memory region lacks pull-down zero-
>> initialization at
>>     power on, resulting in uninitialized random data in the memory
>> region.
>>     If software reads these values, an entry with its valid bit set to
>> 1 can
>>     trigger a counter decrement and cause an underflow which results
>> in the
>>     counter becoming desynced.
>>
>>   * Timestamp request which complete near the beginning of the PHY losing
>>     link can become "stuck" such that the hardware logic triggered by a
>>     timestamp read does not activate. The memory status bit and the valid
>>     bit in the timestamp index are not cleared. This window where this
>>     may occur begins *before* the firmware notifies the driver of link
>> loss.
>>     When this occurs, the driver may accidentally re-use a stale
>> timestamp,
>>     and the IRQ re-trigger logic triggers a repeated IRQ "storm" that can
>>     consume significant excess CPU time.
>>
>> The series' primary focus is towards preventing driver flows that can
>> trigger the above sequences. It is based on work from Przemyslaw Korba
>> which
>> was previously posted at [1]. During that series development, Petr from
>> RedHat reported the 3rd issue mentioned above. While attempting to root
>> cause that issue, several other issues were uncovered and those fixes
>> have
>> also been included in this series.
>>
>> First, the PTP reset flow is fixed to stop tearing down the Tx tracker
>> during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
>> permanently after such a reset. The fix also ensures that all teardown
>> paths properly release the tracker and kworker in a safe order. This
>> issue
>> was found by Sashiko during review of a previous version of this series.
>>
>> Next, the locking around the PTP ports list in the adapter structure is
>> converted to use RCU primitives and a spinlock, resolving a couple of
>> reports from Petr about places where the original list was accessed
>> without
>> lock protection. Note that an older version of this fix used an xarray
>> instead of the list. The xarray has more overhead and results in an
>> increase of ~25 microseconds to the average latency for processing Tx
>> timestamps. The list is simpler and avoids this overhead.
>>
>> Next, the PHY restart locking is fixed to avoid an issue with a
>> concurrent
>> execution of ice_ptp_restart_all_phy() and a link change on a given port.
>> Additionally, the PHY port locks are merged into a single per-adapter
>> lock
>> to reduce locking complexity.
>>
>> Next, the ice_ptp_request_ts() function is updated to sequence the
>> marking
>> of the in_use bitmap in order to work properly with the lockless
>> reader in
>> the IRQ thread. This issue was reported by Sashiko during review of a
>> previous version of this series.
>>
>> Next, Arkadiusz and Jake modify the driver to stop pretending that the
>> link
>> has changed at administrative ice_down() and ice_up(). This removes
>> "virtual" PTP link changes that occurred on several flows including MTU
>> change, Eswitch setup, and others. Now, the driver only triggers a PTP
>> PHY
>> timer reinitialization when the physical PHY link has changed instead of
>> during many other actions.
>>
>> Next, come two fixes for E822 hardware that were originally posted as
>> part
>> of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
>> work task is properly canceled during device reset, and new timestamp
>> requests are kept disabled until the validation task completes.
>>
>> Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
>> bit. This bits only purpose is to tell hardware to mark any captured
>> timestamps as invalid. Since this also disables the necessary side
>> effects
>> on read it is problematic to have cleared. According to hardware
>> engineers,
>> keeping it enabled should not have any other side effects. Instead, the
>> tx.calibrating field is used to disable new timestamps from software in a
>> similar manner to the older E822 devices.
>>
>> Next, the driver is modified to clear the PHY_REG_TX_MEMORY_STATUS by
>> reading each index *prior* to the PHY soft reset. This ensures that any
>> stale or invalid data left in the memory array is cleared, followed by
>> the
>> counter being reset via the PHY soft reset procedure.
>>
>> Next, the E825 timer start procedure is modified to first include a soft
>> reset. This ensures that upon link up the device is reconfigured from a
>> known-good state with its internal counter reset and everything cleared.
>>
>> Next, Petr modifies the ice_ptp_flush_tx_tracker() function to wait a
>> little
>> bit for any outstanding timestamps before flushing.
>>
>> Next, Petr modifies the ice_ptp_process_tx_tstamp() function to avoid
>> releasing any index from software unless either a) it is actually
>> completed
>> by hardware or b) it is timed out waiting for a full two seconds. This
>> closes the final gap from the second issue mentioned above. Instead of
>> immediately releasing the index, the software now waits until hardware
>> has
>> completed it or the driver has waited long enough to be sufficiently sure
>> that no such timestamp will be done.
>>
>> Finally, the ice_ptp_process_tx_tstamp() function is modified to verify
>> that hardware actually cleared the ready bitmap. This ensures that we do
>> not report false timestamps near a link down event.
> It's not trivially clear to me if the patches 2,4,6,8,9 and 12 are
> functionally independent from the other ones. Are they? If so, we
> could apply them, keep the remaining series smaller and hopefully
> move this forward.
> 
> /P
> 

Reviewing the patches, I do believe that subset can apply safely without
a high risk of regression. I would certainly be happier to have some of
this work move forward and potentially open some slots for other driver
fixes while we figure out how to fully resolve the remaining Sashiko
reports for the link issues.

Would you like me to make a respin with just that subset, or can you
apply them? I just checked and that subset successfully cherry-picked
easily with no merge conflicts net, and appears to build fine.

Thanks,
Jake


