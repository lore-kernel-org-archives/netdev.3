Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793408105;
	b=H3mpk4yqTGscVWKRAp9CPCTG33EzO8KalkGgqPlmuRpotzBgt/VdJcjGd+CUZaam8kHN
	 iNJol9N9mDUROeCBIXMi6CK3et7Dhq/wuCHSakET7UxdMOBhnxArZaaUp0ptBTQ7k1xoE
	 yZoKXkNfuIFzfrZlnSDTRVos+Q73Z4gayDFwiwNwHxEvd71b7Nmo9Jft9Hje8MMtzxDB+
	 tziD/G/+UYBcxWDKb8Wlo/3jJV08pI3bLmLDh1X+GEYotADXXip1cIYixrxRiTteqflP5
	 a7B4qcMF1lMAjQRFzcTeaLx4YI/nF5zgBBoSTWL6VICSBsx2nwY4gb6IUTW6DKnr2fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408105;
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
	bh=YklPiFNk6cku1rmxA+QoU1/RFVmJ3rOZ0+geD04tzxM=;
	b=iSO4ARq3M9y0hFL3MzJDPZexM0JyPZnPFn1mWtpsByF/K5FI184O98TvHZucq72t0CwV
	 J1c5pFG0KzhFImrWQ2sVGIrQCEbrEyuEEdYLWjVTEl+ejnYzt/jKHfPpUtSHQWCxDbUzr
	 MFUIrkD+JzskWcD8vap4mmUDMNPpJYiKfurd39Y8/WDIGOI9nRFE6rxulf50wROon+a6X
	 oUka54UAJwb7tbq0VnkFArFd5G+acN/2tA6/UPIRe6NF9RoOy+r82P35LAtD7i/0M/qio
	 +X7cvv76UAci9Hk2pcZA8BoQ5N7xT3pna3WvjKRsXxqqkMMhdgafHW7cwDjuge1qZ7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dhSNRsE/";
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC7606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 00:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CDC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dhSNRsE/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793408105; x=1824944105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/I24D0TZSQz9sb25B1NGsZrpOtjYBPK6JIlYNFT6vM=;
  b=dhSNRsE/RhwdNuJZG+zeQBf3RRIk4BeCIGuQLkZnTdfCf2onEzcYlKxf
   8Is0tNwnunq4miyFZc/YMIIJCFqRgOYD9LtI0U3aeMU0kHXFT98xJuuXD
   dfOODeB+eW2i4mZvPjBNeRDfFh18JSrK16NIWmmZtMXLetUrWndgvuIoa
   Rw5qXdWJXACs1KAXV/nrq5EfWdocBDxSd0ZgQ9W2p8pQEFhEkjsn3nNQM
   vnYY7RpOOJ+KKqxlC3MVf5eWJ76ewz7e31ppjtcYVk4tBGuV8mGRrD1uk
   9fJ8MXDxqo7SjE3MHwRTP/x4/vYoBKiONYu20rFfJcF/rtZ34ntIhud6k
   A==;
X-CSE-ConnectionGUID: BozR1YebTrWySZT0IdNeoQ==
X-CSE-MsgGUID: Z1THNVawQ2SnkMh1amnwHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2212012"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2212012"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 17:55:04 -0700
X-CSE-ConnectionGUID: VMp/EvXrT1O+7mccbN9olA==
X-CSE-MsgGUID: aqdM3UG5Sjau/qUPrpH4Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5655133"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 17:55:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 17:55:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 17:55:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 17:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQxDA7+kx0LyHCV768go7BUv2k3LCSCm+EFaPHLCVYk1/SVXO5/M5PjzFI1GdrBB9Q0L+cMDbmmrFa5ndMGi+s4KjmGEXeAZCCu7TQz6ZOAMRFhSRp09QxlObFZR8A1OthkmUVD2DgiIa0IxAVhq/Hi/Lcj011n44KoeQjYK/WF6hRB5JJRE9jjyJN4aci1/cK9bPvDF7pDITbwqlKA5oQrVNO4ux0gUj1RmDGhOR321wUJr1UqGHLmtI7X8yAgpu/vR6wZ8vJVR+8Te4j5zGjRsp5C2Tj8WgVY13EZe5o2TfHwje3DdY5N0zceFrXBFMt/XxC/NITZwDcJUI+0IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YklPiFNk6cku1rmxA+QoU1/RFVmJ3rOZ0+geD04tzxM=;
 b=vdGweovlF4XZeKdVQ89l0cUT1cYjpilreUt3VK0AwJyvxcfqlzx2O7QpCi7Sw3JL4MtJ5Vq9U2UwnPAONCd0JQgxw9KlT9VYAc7TiJxhyT9YppBpkqNGPy0EnKCj/9bgHxwiEVEi9/3eBHXuGGfoG763T+ayTlOxeM9eXl+rRw//3owRVHhiPILUPLgJJYLntm2fMwo2UcC1b1DUpohRYVwZO+ncs+SUQVo1knoCX574sawSagegaqcHztdc2lkUlYMoED233SrhD93hrSJFKVnhvmal1LlJ9iIJsv7JxbxhCZUUnF3spe7lg7Cyk4862fC4uo2HBRHDzTONVnry9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 00:54:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 00:54:53 +0000
Message-ID: <4239c9d0-734a-4a58-82b3-6663ba90123a@intel.com>
Date: Fri, 30 Oct 2026 17:54:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ice: E825: clear PHY_TSTAMP memory prior to soft
 reset
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-2-72128d1dd928@intel.com>
 <179339643733.3131.11053424586570802270@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179339643733.3131.11053424586570802270@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:303:16d::12) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6425c1-b300-4a29-d14a-08df36e99306
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xg7cMPX5f1hfaVcTETO+YjQKrtpyr3htGalSwxMiol98IHRDPm9NgzTuEjNp1fz+Ailxm3IokURYWwxPhgqX7+Bi1GtXuWjtLAuBFlrgfBq/WgCEj0vNXX0nvlOpwY8fwj7+YGUHpNWxtO2QRczeM9jypTeDZxuDsb3BiBXv2eBz0f/cB6Y/d+8wifypBqmTJr2YpKCDyDRP90O182sYRBkUSY0aaiI+WFBaczhWal9WOzrsu2dD5jggI1zimMhDV2773SnYUY710WcmWeyNDC/om5fwKKo2vBXFq6bwreYEJyGwgAsY+w5U7sMgVZZIwx+NV9HEAOotnJ7dlze7FuKEgOUA5LPEFKw8ihYuidOOtNtHnHWgQn2+JEOEHoI+9EfkHv3fzN/DRvnhIDgHIhxdo+3MwsnLY6dKz+eKTwGtyMybd21DZgk4iOf9mQ5X+uDv+XJSCCyCUPyF5vtipQ/8f8RtJcNS8+KMMg0XwSAY8YNrVEN/CvNn3jnuoJwAISFS8xeB2/uUHuUCrQs8p9EE/oGx0w4rdFvxg+DNaY6cYL5AyphPLdXtEnRWXGVMgY+yGhEpvkQppdvzzME89Vfr+Q67u0iV8kWWmzC+PuH+5ge0ZXIaInMRMzv99smKo81CBUE6ULAXVsXdBP0widVhM0b7C0p0G7VH+Q2j128=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJsK1B6dlY3U1c2RXFDRXpscS83NlJ3OWF0YkRvcURJdG9jOXZLcjdXVW5k?=
 =?utf-8?B?cUI1Ry8yWHhwYk5QcWplMVdhRXVtS3NmN1RVbEVYUGc5Q3BYdUxHSGRIOStj?=
 =?utf-8?B?a1ZOTVdaRVM5UGhNc3h2Yk93bDNuQ0FKejAzWE9VbzRKRU4yQkJmbW1kdE1J?=
 =?utf-8?B?WE9oVTVUdWx6M004bGFCSjNiQjM4Yk5MUWUra3RGMnhXemRoRDhPY1JuS2c1?=
 =?utf-8?B?VEdOQ2ZBVjBHK05Xd1lKRWdOMkRscEpJeU0zNzliOXBscHI4NFdvcWFUZnBK?=
 =?utf-8?B?WGVGZUd0Q0V1a0g5US9ETU44NFRWd3RmaTU5UXFCTnZ0dTVQSmJkSmJIYjN3?=
 =?utf-8?B?Z05vWVBVcEdxRVF0SXFmbmxMZXlvaUJQUmRGZWpUbmtGY0p6Qk54cGplQ2N1?=
 =?utf-8?B?M1QrMTRVeHBIZDF3b3FKc1BPOXN2cnlZVGZkd0wyRlFsVUJqYUs3dy9jVFBU?=
 =?utf-8?B?N09HZDhmQTAxUmdtSWFJTXIvVldESmRYelZTUmVNcjYzY0xUTkZwWTdkVGQx?=
 =?utf-8?B?UnJzNzc5VC9uNlB3bG1SdHh5S0FVWVV5MUZoMU9paHBpQkFBbTFRTGo5ZXBl?=
 =?utf-8?B?OFRMeWZCQkZ0UnBsUStCTEpKRml0c0U3NWk4T3VhWEQvZVFuZGUxRGxOMVB6?=
 =?utf-8?B?ZXljeURVTVYzQlRML2U4dTR4TWtIWlh5WURnZTZVenM4MkJUMEhJazIxZEp0?=
 =?utf-8?B?ODBGL2xlejVnQVVFOFdGeHVPY0NIT3FpVDdDUjRValZldW90WmNNTHB4UWpk?=
 =?utf-8?B?Z1RaNDRhV3EzcUNtMVlGUndEV2NLV09PU3FWWWM4U1FBQmV3dlBzVDZCdzRR?=
 =?utf-8?B?R0JidTB0ZDRpQnR4NlVzV0JKYkxZTEV6c2VzenVwRUJjaVhxY0xnNGpBNVdl?=
 =?utf-8?B?anhURWlWSWdJaHNzYmxyNTE5NEhqckNCTS8rTDQ2dFR3T1BqNk1neHdvOVFk?=
 =?utf-8?B?NEhUQ29Sbm5tdnlFMGlpWkExZEZPd1Jsc1l4a1ZCSlBHby9VMGUzZEZXWGJS?=
 =?utf-8?B?OENRQllDaWM1MnlxVStob1YyMWFpLzlONUE5SU1YWHY0RWlTMVRxK0hCNkdP?=
 =?utf-8?B?N21haGFyOE1nWFE1NGI2cHdaaWRPelBVbXl3cFBpUG1ZWGR0YURPdm5qZXU5?=
 =?utf-8?B?UDdOUVhOdjZUYnFJck81cm9DVFFHU1pVSHRKVmFrUG1FMDRIbDUrNjJRMjhs?=
 =?utf-8?B?Y0dOcm0wTUIvMW9CbmRrbzJGcDJRRzlUOFI1TCsxMWJ5bWZURnZFN0YxWDcx?=
 =?utf-8?B?aDlTbDhLaExIQlNPeXNNQ2lyTDNCbDJaS3JwQ2xUQ0FNVWZzdHdsbkZVMWpz?=
 =?utf-8?B?aXBDWE1YOWF0VlNmMktCbElTUXpucmY2YldpWDh2MzMweFFwSEUybkpYREly?=
 =?utf-8?B?bTdLSHg0VDk5Ti9DVkd5MzBmN3hWT1dUWGJ2N1k0c1ZnRHpuY3lpUCtwT0ts?=
 =?utf-8?B?dUdIY3RBSDBRb1BsbDlVWDZKQjNTU3gyODRndElkcXFtMzNJaHJaaHhhVWJB?=
 =?utf-8?B?YTZqU0hMRldhQ2IxSUd1YmFXR0dkcjNEYnQyS1A3ZFJXVlBDT1E4OXUweGFy?=
 =?utf-8?B?U3hOYlpKODd6UUZ3VzdjTHg5eGgvVDFjSi90b1JOejd4SWZwOWJlVk9sZmVR?=
 =?utf-8?B?VGg0cEZwRXcwaXFKc2ZtUGNSYUQ3UTN0MTgrL0RwNE9jR0I3NVVPdjlBczI0?=
 =?utf-8?B?STN0dG93Z0p5bENKUTNiOEZ1Qmh4a25kNCt5N0hPb0FPaHpvTjdqYmY3Q3RV?=
 =?utf-8?B?ZUQ0aGt0Vi80elA0emxFMHViMUFVZEttNHhrWmF0WkVRM1BXeFNGbXJsQW43?=
 =?utf-8?B?QnVYOFJSWDFvM0R2dWlUeXdVNk9ETHNZbStSRGpld2g0ckFIMnpwbUt1ZElz?=
 =?utf-8?B?TUVuU1pkWWdxSjVENUF3VUR1U1dIZkRiQU9SSWxtY2JVVjV3bmF6Zng1U3Ay?=
 =?utf-8?B?QmJ2NzNqY0duQTB3dk5OMGhXM2JUN0lTRkhCV1BFWFlMTmVHOXh3ZjdOdGpR?=
 =?utf-8?B?eDNTZUVaT2VQVnR5Q2xNb0tZb280MWJTMEVjK0szVzFtRHB5NnN0Zng0N1Nh?=
 =?utf-8?B?UVFKOXV5ZDUwRFpVVlZSU01UQjlubFVtc3JqUkU4K2R4K3hLREpQRWxJSE91?=
 =?utf-8?B?OXF1WDdRWUwyRjV5TTJwSFFPbitGR3h2aWFpcjROc015SndoUFN4eGwzOWFM?=
 =?utf-8?B?SWl2TlZ5c2k2Y1BtNUVjNHJ6UFhJQ0NwZ05aWXcvWVh2dFFudzRQckd1SWNx?=
 =?utf-8?B?SWhEZ2FvVlU0MnNnQzJDTHJoSkY2Z05BeTJQLzRQNXcvZ3k4VmY4Z1ZxQUo1?=
 =?utf-8?B?aDZaMkVRS3FLRXdCL0dMdzMwUEliMzg0R3gwQ3Nld1AxYjl5aU96QT09?=
X-Exchange-RoutingPolicyChecked: v1jeqP52mEQkPaSdwcDDRGSVWrBnGYBCAxgAEtqm0xt+Syq/LSnmhWXjQoTz+duJgygfWscrGK6ZVMGpSmtddZZ/PzhZI6MnhpRJdCr5mOJfTqCBi/VgsL5MJ+LrdHROXnv2Q8mKEQ4/OUZ3R9VR88rhmgsndQplGpBGmZyTVJ9VG/llD3m70Rm+AvRDNWMd64CuYwrlHgODqMtLr2I8ARzq4allFwhgEfWlgGBCmjGVRtDmAoWBQsmZx92y6VkOaePz+7qpfqPXuKhfgMtrShLcOzAlVe1oc4mFIhK5OdHdpiSidYV7kXmd7n78jdXE2MgGMDhoAlcLHSWXmrc9cA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6425c1-b300-4a29-d14a-08df36e99306
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 00:54:53.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcyJU4RMOPaLiC6MTfzIr6tM2zUANWtcDZp+Y+swdV7C2VO6i0WvSBzZXqv3HCkPxiNAl/KyGwb4sLbmGxvCYahvt0znK1ZKXSe3kwjzRew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

On 10/30/2026 2:40 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The loop in ice_ptp_clear_tx_memory_status_eth56g() (`for (idx =
>   0; idx < INDEX_PER_PORT; idx++)`, INDEX_PER_PORT = 64) only counts…
> 
> --
> 
> ice: E825: clear PHY_TSTAMP memory prior to soft reset
> 
> This commit replaces the E825 timestamp memory reset with a sweep. The old
> code wrote zeros to PHY_REG_TX_MEMORY_STATUS. The new code reads every
> PHY_TSTAMP index on the port, and the sweep only runs from within
> ice_ptp_phy_soft_reset_eth56g(), so the soft reset puts the internal counter
> and ready bitmap back in a consistent state. Read failures during the sweep
> are counted and reported with a warning but are not treated as fatal.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 07b55fbb88dde..ef59b34ba52dc 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> +static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
>> +{
>> +	int err, failed = 0;
>> +	u8 idx;
>> +
>> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
>> +		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
>> +		if (err)
>> +			failed++;
>>  	}
>> +
>> +	if (failed)
>> +		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
>> +			 failed, port);
>>  }
> 
> [ ... ]
> 
>> @@ -2311,6 +2320,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>>  	u32 global_val;
>>  	int err;
>>  
>> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>> +
>>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>>  	if (err) {
> 
> [Severity: Low]
> What happens here if the sideband queue fails persistently instead of
> transiently?
> 

On a previous version I got asked to change to this method because of
possible transient failures. I think this is best since these reads and
side effects aren't entirely critical to functional device.

I would rather leave this as-is and not waffle back and forth about such
read/write failures that are entirely unexpected in practice.

> The loop in ice_ptp_clear_tx_memory_status_eth56g() runs for all 64
> INDEX_PER_PORT entries. It counts failures and never stops early. It also
> runs before the PHY_REG_GLOBAL read, and that read is the first access in
> ice_ptp_phy_soft_reset_eth56g() that would catch an unreachable PHY.
> 
> Each index takes this path:
> 
> ice_clear_ptp_tstamp_eth56g()
>   ice_read_ptp_tstamp_eth56g()
>     ice_read_port_mem_eth56g()
>       ice_read_phy_eth56g()
>         ice_sbq_rw_reg()
>           ice_sq_send_cmd()
>             ice_sq_done()
> 
> ice_sq_done() polls with ICE_CTL_Q_SQ_CMD_TIMEOUT, which is USEC_PER_SEC.
> 
> If the sideband queue head stops advancing, each low read waits the full
> 1 second and then returns an error. A failed low read skips the high read,
> so this costs one timeout per index. Fast -ENOSPC failures only start once
> the 64 entry ring (ICE_SBQ_LEN) fills up.
> 
> That could mean about a minute of stall in the sweep before the
> PHY_REG_GLOBAL read fails and the error is returned. Before this patch, the
> same condition was caught after a single timeout on PHY_REG_GLOBAL.
> 
> ice_ptp_init_phc_e825c() calls ice_ptp_phy_soft_reset_eth56g(). That makes
> this reachable from both ice_ptp_init_owner() during probe and
> ice_ptp_rebuild_owner() during reset rebuild.
> 
> After the later commit in this series, "ice: E825: perform a soft reset
> when starting the PHY timer", it is also reachable from
> ice_start_phy_timer_eth56g() via ice_ptp_port_phy_restart(), which holds
> ptp_port->ps_lock.
> 
> Because the sweep runs before PHY_REG_GLOBAL is checked, its read side
> effects can also land on a port whose soft reset then fails. The new kdoc
> does tell callers to treat a soft reset failure as a non-functional
> timestamp block.
> 
> Would it make sense to stop the sweep after consecutive failures, or on a
> timeout class error? Another option is to read PHY_REG_GLOBAL before
> starting the sweep.

I will change this if the maintainers demand, but otherwise I would much
rather see my actual issues fixed than continue to be stalled endlessly
by this AI looping me between different versions.

> 
>>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
> 
> [ ... ]
> 

