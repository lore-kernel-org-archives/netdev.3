Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792452923;
	b=whL6euV4zInBp4phXdKXQFuA7OkCJVppOt9VWYPERFrwDYYu8UbJHbeMg4u97+bitRRg
	 tfAz58zGEjeE4kPg9qPNG4whhlP6GtK8Ru8qZp/Oz+1UvviHeS8653vWoBCd4r1mjxdXA
	 u+ZTgHTJXCMJDwLmPICjGkQuYg+z+3H8yHCvhTaPXtMc7czmB4cceAEe3xVZ42hOLZ0gj
	 rwhZEzWpKWTOB1dWvB8RZPhimUunddtdE4cSz3/uxCzHbq7cSyV9hzYRMifTiauVdCP0a
	 UbPSKqtszJI4SgHOy5Qd45HP7htEeKlC/RJr2Yu2Mv/tTDlmW3YWqpLVaTocyI5VlWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452923;
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
	bh=brMAgUK38iV49/hi0wR5GfOL153GSjwksppYnxy9fB4=;
	b=GEd4WbiY0+g5VVum56wtv+puYsqCFGPp9WcjbUMTEaQGZ3xM0cMVM++oAudwV9Ide4rR
	 cRq9bBaCvE4vNaRM4Wn1MetxT3he2Exw0hQKBKLzoZC4elodTmKAGpEGpqVtGN/F1PcYj
	 EvxcCqEaS4/2JSsKBTKh6BCGKfWBlQKZOXHPgYy4tmCkigUoa/8/pzm5RrApCqZVNwRh6
	 eqx4Udm8O8Qc1ee2vqwNxDhoI8koURQSw7WHrONWPk2KwTL+LjZu1uzA+pcR/5UKCt+l8
	 5Ny5W5IImPZLwbXDYDMp/XIMDJUhRDqBD8pNeVRTIgBqDDYPGvq7p5ro8k/9rlb8B2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWoJPS8y;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7636606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7636606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LWoJPS8y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792452922; x=1823988922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xW5yVtd9xH+0B+AVfpr7+FSWZt//YFL5jtdfBk+hjws=;
  b=LWoJPS8yHlkUhT09aIE+EqbcoRFxxWt+3mOXiNFGTFejei0FxaCObwpg
   Nrtm4I9E39lFhgiNBrD/LO/6AISCym5mBxtjUcrJn1fbgrr06GLQIwekb
   Kuras9muxMZq/STgMwohiyK1ZUVgaz51iFJ5fOehthua8NhOn+lBq0i6Y
   mRb8wu2K/tu4xn2eElnAVP/hMRZ8enmWQIaU53HgYD/cJVQmwTIfW32fW
   3/3wjYV9eEsIuRbN/SlOKzCZJFIsVm4ujOypZUxyIgmRrDZ1lu6Mpu5/D
   J1HI2EehQCZZi669NOHPdmIktNXyiEa9PPn1iwdXSU+FilaDPBO9NyA+X
   w==;
X-CSE-ConnectionGUID: 6EokPPo8RuCrWx0uHfj/DQ==
X-CSE-MsgGUID: HCWBU/obTpa3LdbfYa7hXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1250927"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1250927"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:35:22 -0700
X-CSE-ConnectionGUID: 9p2hNgOmQ7CnxN8QB/QNxw==
X-CSE-MsgGUID: lXXsaXuTRZGFy1A5mNNz7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2993486"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:35:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:35:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:35:20 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xM9k2xXnKDt9/Ibhz1jZEFleE/EnsQWW0wf+O45CkqwnbGmyJLFadSioAVfSRyyOYY9wPIyNPDoRnEXePYiaL7f0hnZuHDwiZtYxHJlJdRwiWSMC3YzlYxpgdjku+L5uMlmBRqD4pqetPJh+2Kau9vULhpQzRl46rS8AJMSOgc4eMskcJV4DEWAw8rPwhkwNHt6+op04fY4RHlhqLvr34Z24jgBsqI7vas86iD6H3Y438pjr0+K2I+p9zMHt1JsJcZqCswGbgfuSwY8JVM4MsBRJdQqhLq61TbOmeWQTH79UiPmaSGd1MZ6qjQUSOn/GyRtg7H+MTVC86ZZqkTbR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brMAgUK38iV49/hi0wR5GfOL153GSjwksppYnxy9fB4=;
 b=iKC3QeCc6ZHOWP8fJ5tGLpxYwf3jtm7+iQkQSQlabb1mL2P+rKKeqA3Q4G+557Tu2Qb3KvIB234iMj0S2wzDTOBwqGbf1ZAKXJJT0FCV99AXc3M4NznyKQ4VZ9903bYipfh4FAI8BeZsMS312SNq2gDA1K1bDuewPEFcrgAtXwlf3YGSohQ46HS0IOH2lFputxBSTKsRfdYdVwl8UNzEPYxVrraI0kNKTYFjqg2v8t1P9k7Vhe4QPeEcNXdyNcdfbka+k+z5E+sU6JRlOk/WTRM1yawAvJbygY1EARHJdv7iT4+QWH56yyDMK/kG8Jq8SUPQtAfvNEMuXrlx9l8gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:35:17 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:35:17 +0000
Message-ID: <e1408f22-686c-4cfb-9b75-c23741f0346e@intel.com>
Date: Mon, 19 Oct 2026 16:35:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 05/14] ice: call PTP link change only from link
 events
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-6-anthony.l.nguyen@intel.com>
 <179244084553.3135.12829466635546463271@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244084553.3135.12829466635546463271@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed7cef5-3f81-4fa3-f900-08df2e39a1f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: pDFvccnFbQ0UP9X7VQNcgZVWXceziSQvHgX9gjhH5vR4dTVIRBlPEgST6nXN5F9FC78gUDqY2P9yVowakamFzt3NTfTQGcYFmyPVk+UQUvaUIP/v8lz5TzIBYNEbUd+1GGRR1H2+i7GOE9ZwDggaIeKsfQ1/lAOVDVJtxL/lrE75HHQ81QsF7KjpbXIydiVD6IkYH0ei7mmUUBYxNCJ3QClecCpcrGEkHSq1Q/u/raZkOp4wbfAHoB2oaeecWGm9vA2HaR9nOBGEcCyMRecuLAvRt2a7TCvDr8gF002cekjBL2jQlvKOKY4j3yVgG5jDz9+Jqwc4dwmplgSu5zUguWv/l5pp5Yd3VYfK4TKrVRCah8o+taM7TxlsWp4DgDrz7TanBitKmdGEOUrToHVN3fMVMxDZo9CZRt+yhaduyv7lDy7Ji/M+TfVlvRvzsTbPAvI2DbgjjQOmgECN+AFp7xXp08koPgIGieapuILzDzbj2JtKB+lR0STJF7iOCTzrA80ch4xM47p7BMSlW1t+RrKl2AmObt0kTdCnsgDWyjyTKGzRzOv2s2vVZp+0G6xDWHsGGuYMLBUBOWPGrkr0z33pbs1a9JCQ3L+SpkU8PVbkCxaPU8599/LzLKdggpKBOCCo7UQVKSb7TM/YwTx3pfeWzC+RUeztlc6OaIPnUPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2piV1lTZHl4Uy9lbHFzTDhNYUJsWU5qRUdnQzg4dk5VMzNQa1pyNkp6L0hK?=
 =?utf-8?B?V3RTSmRpOW9nd0VtYzBiM0IwZUF6S0NMSGt3YVJ2UkJyT0w0RTVmcTFSd2hS?=
 =?utf-8?B?aEdJR0l5MGNneVNzTTdVWVFkczM0em5wU2xEOGpHY2RDaklaV2ZHTGdjaWJt?=
 =?utf-8?B?akFtejU5NHpGREh4R3F4U1JYZUNSN1drTnBYZlNWUk01dU1YQVJJeERRWDZX?=
 =?utf-8?B?amJWcVJjS043MTBsd1pxZ1IrNitBOUdpUjNJcUV0OHlRNVVqQ21Jd2k4L0k5?=
 =?utf-8?B?U0RTV0pqTllBanBjOW9WY0d0QXQ3dGNxYVdmSHZRVExURHJwOVBtN0NPY2NY?=
 =?utf-8?B?V1M5bDRkY3hyU0hrcU1BNC8zUGE0S2VrcUU0QjBqd3h1dWw3eGxkamNqcFhU?=
 =?utf-8?B?UnVjekprMzN6QjdUTUMvck5OMlEyMDZpNkxRd2xzZ01vM01qZktKeVZwOXA0?=
 =?utf-8?B?TmY5YWxheER5cGNxT2drNGZlZFpBV3Fyb01NMXhpU3VveGNIR0xNQms4YjZM?=
 =?utf-8?B?dG9iK0Z4dEhYazBFbmZKU28rYkx3LzNHWG8zTzIydTBReGRkQmVSbXBCOFZK?=
 =?utf-8?B?S3FXTzhYMGlrdDdhMWtvdlJTK2lYVlplaGZ6ZnlGODdySzJqRUtrWncxWTV4?=
 =?utf-8?B?S0xDdWMrWm9NVUIyZGp0cEwwaWg2MExoQzBuQ3FyS01uN3crL012SHV4RDdF?=
 =?utf-8?B?ZjZ5b01ZOVoxaGtkUFl5ZTByUTY4NkdUTVUreUgxUUxHUUpDVmxsZkl6RUl6?=
 =?utf-8?B?cFovN0RuOW9lQ3ZTRmFtWGFWNmZtYUgwQ1hYV2JjMjdYZ3BjSXJsaXJRdjZn?=
 =?utf-8?B?N1ZERUJ4ZFg4bWVCRk1JMDJ0OHJjMjhyeGliUEt5RXBqcThIdVIwTGt6RHVE?=
 =?utf-8?B?UE5MRkhpb3JBY1p3QXA0WCtXdVFlZytKSGZVb1gvcXJ2dCtQWVFPcE9lUVEv?=
 =?utf-8?B?RWhyVnVLQ0lJNllNakpvbDdvTytrcDJpaWFtbkNsKzZ4U0hyUS95L2RyM1NQ?=
 =?utf-8?B?M2RrQ0tiWmpYcENuN2J3YWJHODJlZ2tWQlBFVHRROHZ2WUlvUFRyQXE0RTY0?=
 =?utf-8?B?VVY4UFluR3Z1MmV2NXBiNWVXRXBiNG55NkxhN1RiSFpDT1VJVTU1OWZyRWl5?=
 =?utf-8?B?UHhHVG1ienZwZlE1dW9VOFk2TGVTZENNNFFRYUtXdzdYQVgxWWowbVJ0N2lM?=
 =?utf-8?B?MndPaVFRMXJPa3l3TGR2bVBhbGwzZ3VrWXdpNVpjSkNqMXVxSzRpZEpZWmVy?=
 =?utf-8?B?Nm1wbUpoK25ySE1NZGJZZXBsSm1ESUpzYjJNYW5kL1l1eGxZS1hmb3ZEd01U?=
 =?utf-8?B?M1pRU0twWWNqNm1KUlczaENDQmxxZVUzbXltNXVCWEcyY3Zhb2RpY3hJMWJL?=
 =?utf-8?B?VXNPNDBFMHBVVENHbitadlUwdUNreVA3KzFrMU05WDVHTkY0NzBSWFNBL1li?=
 =?utf-8?B?TlhHbGdTelJyNVpaejk5SzZidDQrR0cvZVp6eTdoZXVjcGlMNDMxS1ZrU3ln?=
 =?utf-8?B?elR0WU1lWkJDbjh3dDF1Q0k0bmhFcHRLRFdrdjBPcjFTQW5lbzZZd1JBKyty?=
 =?utf-8?B?ZitNMnNyM2ZnVFhucytBSHp5TGUrWnFNZXY3enExSE5SWWVuMzNWU01wcjBF?=
 =?utf-8?B?dHJBbWxOZmpHQ2ZOTWFtQkV5WitwTE14dzZSMXhLY0k1UENoSENsTitrcEF5?=
 =?utf-8?B?MWhodXNyR3Q0UFdCS0lCT2Q2Q2JqMEU2a1NFcWdRdklWSkRSbzVxZVVVZGtv?=
 =?utf-8?B?Sk90NTNTUDhIU2JPQlFlSnoyOFNIbzlkbEpHenEydCtuVXVGdHlZUTBCWkFC?=
 =?utf-8?B?U2FaaFlscFp2K0N2RUpwbHVTWkJFNVB0dElFcVdVSEhNTlpSU0ozSG93UjY1?=
 =?utf-8?B?WnNsZ2pxWmdyNDlxNEUzbVBqN3UvT1ptOXgyQVg3Nk5FT0kyeWMwc1lLTVN1?=
 =?utf-8?B?SWdDRnVWRnMxZWJrMnFxNmd0Qyt0eVd3a1djWkdzU2NndXkwTWZoNHpQRjJC?=
 =?utf-8?B?SFdxVkJpKy9ySVk0VGxGOEQ0Y1JwaFhwczBKNGpQMTN5NnRRVEs3YU93bytQ?=
 =?utf-8?B?VVFPMWgzU3R2eTVaT1RwYzNyMkZHWUR2OHlJZWtNOWRzNkpOa0QyTnBHYXJk?=
 =?utf-8?B?NzZ4bXdkb1lXRGIwdWorS2NudDdrR2UyMk1nNUtBK2V5Z09lTERkVCtIWm5k?=
 =?utf-8?B?dHk0OU0vNTNsU0VUaVVpVjVOV0dETlkyWFpvdE9remJ5a2RTaXlBODM4TVc4?=
 =?utf-8?B?d3Y5UkpMNGNvVlJnVXg1RmtieDRjcFFzY3ZoVXUvbVhubUJYSmpJZVRyMUc1?=
 =?utf-8?B?cTVvQ2xOa1pNWTdDQ0kvVGZHemRMN01SZHhqUFdBQWFPRXdtNExiZz09?=
X-Exchange-RoutingPolicyChecked: lfCE8QN+PTA5p0fyFQte69/7TnUKyFVpt+Tu4MFNXrlddRqyUUGewNdjFEAkb+tVdMdRujcxQdyF8gNjSnK/JxRHzT/pljp5mv0UJNbnMJcTs7u82R6q9YVC3f5h45LDXIG2M5yH1m9t6EalHB62ywE7ic9Qmy3M5GJ5AViD3DdNuw1btG2FnMZqYONVdayEFOJfrFvDpNcEYvvNEHbk21dLN0ilHvqUouG97u04t6t8RZm56xbAnunVv4+V7qlaw3jqu5fBBmxgaJRo3rR0t2OZdbhcnXsvdDPn5NIPJNwbgHVvfqB6TeIZb1ZQQkwITEZLVQSzYgRwy08Q07h8Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed7cef5-3f81-4fa3-f900-08df2e39a1f3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:35:17.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+e+6433JJS9LgIy21Njg+lQs/7fmvzrlMrDtswBnDitYnK0PV7lOydIwspFa7EByCAGT123arhXdoYk/7IL/WreDBTKoG7RoJybFrcYdLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 4 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The commit message says the new ice_ptp_link_change() call in
>   ice_rebuild() (ice_main.c:7803-7808) exists 'to reflect the current…
> - [Medium] This patch removes ice_ptp_link_change(pf, true) from
>   ice_up_complete(), which leaves the PTP link state with no resync on…
> - [Medium] The new PTP link_up seed is only in ice_init_link()
>   (ice_main.c:4817).
> - [Medium] ice_ptp_link_change() used to start with `if (pf->ptp.state !=
>   ICE_PTP_READY) return;`.
> - [Medium] ice_ptp_init() now sets `ptp->state = ICE_PTP_READY`
>   (ice_ptp.c:3425) before the PHY restart and before…
> - [Low] The comment above ice_ptp_rebuild() in ice_rebuild() still says
>   'PTP init needs to happen before the VSI rebuild.
> 
> --
> 
> ice: call PTP link change only from link events
> 
> This patch stops calling ice_ptp_link_change() from ice_up_complete() and
> ice_down(). Instead it seeds the PTP link_up field in ice_init_link() and
> resyncs it from ice_rebuild(). ice_ptp_link_change() now records link_up
> even when PTP is not ready, and ice_ptp_init() sets ICE_PTP_READY before
> it restarts the PHY timestamping block.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d88835482d3aa..b4ee2cf7cd704 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -4810,6 +4810,14 @@ static void ice_init_link(struct ice_pf *pf)
>>  
>>  	ice_init_link_dflt_override(pf->hw.port_info);
>>  
>> +	/* Seed PTP link status from current PHY status, since link may
>> +	 * already be up (e.g. after PXE boot) without a link-change edge to
>> +	 * catch it later.
>> +	 */
>> +	WRITE_ONCE(pf->ptp.port.link_up,
>> +		   !!(pf->hw.port_info->phy.link_info.link_info &
>> +		      ICE_AQ_LINK_UP));
>> +
> 
> [Severity: Medium]
> Does the devlink reload path need this seed too?
> 
> ice_init_link() is only reached from ice_init() on probe. The reload path
> skips it:
> 
> ice_devlink_reinit_up()
>   ice_init_hw()
>   ice_init_dev()
>   ice_init_pf()
>   ice_load()
>     ice_init_features()
>       ice_ptp_init()
>         ice_ptp_port_phy_restart()
> 
> ice_ptp_port_phy_restart() then uses whatever pf->ptp.port.link_up was
> left from before the unload, because ice_ptp_release() does not reset it.
> 
> While the reload is in progress, the service task is stopped and the
> control queues are shut down, so link events are lost. ice_init_hw() then
> refreshes the link_info cache with ice_aq_get_link_info(), so no later
> ice_link_event() sees a difference.
> 
> Before this patch, the ice_ptp_link_change(pf, true) call in
> ice_up_complete() fixed a stale value on the next open. That call is now
> gone. Say the link was down before devlink dev reload and came up during
> the reload. Does PTP then stay at link_up == false until the next physical
> link flap or reset? On E82x that means the PHY timer stays stopped and Tx
> timestamps are dropped.
> 
>> @@ -6745,7 +6753,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
>>  		ice_print_link_msg(vsi, true);
>>  		netif_tx_start_all_queues(vsi->netdev);
>>  		netif_carrier_on(vsi->netdev);
>> -		ice_ptp_link_change(pf, true);
>>  	}
> 
> [Severity: Medium]
> With this call removed, can PTP miss a link-up event that is still queued
> when the interface is opened?
> 
> ice_open_internal() refreshes the cached link_info directly from firmware:
> 
> ice_open_internal() {
>     ...
> 	pi = vsi->port_info;
> 	err = ice_update_link_info(pi);
>     ...
> }
> 
> ice_link_event() compares against that same cache. If nothing changed, it
> returns before it reaches ice_ptp_link_change():
> 
> ice_link_event() {
>     ...
> 	if (link_up == old_link && link_speed == old_link_speed)
> 		return 0;
>     ...
> 	ice_ptp_link_change(pf, link_up);
>     ...
> }
> 
> Take an admin-down netdev whose PTP link_up is false from an earlier
> link-down event. A link-up LSE has been posted to the ARQ but the service
> task has not handled it yet:
> 
> ice_open()
>   ice_open_internal()
>     ice_update_link_info()     <- cache now says up
>     ice_up_complete()          <- carrier on, PTP not told
> 
> service task
>   ice_link_event()             <- up == up, returns early
> 
> Wouldn't pf->ptp.port.link_up stay false while the physical link is up?
> 
> On E82x, ice_ptp_port_phy_restart() would keep the PHY timer stopped.
> ice_ptp_process_tx_tstamp() would drop Tx timestamps because link_up is
> false. Later in the series the same link_up value gates Tx timestamp
> requests, so those requests would be refused instead.
> 
> A later ifdown/ifup does not fix this either, because ice_down() and
> ice_up_complete() no longer touch PTP. Only a link flap or a reset does.
> This seems to contradict the commit message statement that "the link
> status will reflect the current state of the physical link". Later
> patches in the series leave ice_up_complete() unchanged.
> 

...

It seems like there is just no way to get Sashiko to be happy with any
of this mess and we need a completely different model for handling these
link events...

This is a very theoretical case which we haven't observed that would be
blocking legitimate issues we have with customers (the fact that certain
configuration changes like MTU were causing outage on startup of PTP).

I have tried now ~5 different ways to make Sashiko happy and each time
it spits out some pathway that looks like a link event is lost. As far
as I can tell there isn't any ordering that works properly without going
in and re-writing a bunch of other stuff that is even more problematic
as a fix :\

> [ ... ]
> 
>> @@ -7794,6 +7800,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
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
> 
> [Severity: High]
> When the netdev is administratively down, is link_info re-read from
> firmware anywhere before this read?
> 
> The commit message says this call is there "to reflect the current link
> status in case it changed and an edge was missed during a reset". However,
> ice_ena_vsi() only calls ice_open_internal(), and through it
> ice_update_link_info(), when netif_running(vsi->netdev) is true.
> 
> ice_update_pf_netdev_link() -> ice_get_link_status() only queries firmware
> when pi->phy.get_link_info is set. Only the ethtool set_link_ksettings path
> sets that flag. Nothing else in ice_rebuild() issues Get Link Status.
> 
> If so, for an admin-down interface this call just replays the pre-reset
> state:
> 
> - the link is down before the reset (PTP link_up == false, PHY stopped)
> - the link comes up during the reset, and the LSE is lost while the
>   control queues are down
> - the cache still says down, so this calls ice_ptp_link_change(pf, false)
> - a later ice_open() refreshes the cache to up and turns the carrier on,
>   but ice_up_complete() no longer notifies PTP
> 
> Wouldn't PTP then stay at link_up == false while the carrier is up, until
> another link flap or reset?
> 
> The reverse case also looks possible. A stale "up" value makes
> ice_ptp_link_change(pf, true) start the PHY timer before the link has
> retrained. The real link-up LSE is then suppressed by the unchanged-cache
> check in ice_link_event().
> 
> The end of the series does not change this code. Would calling
> ice_update_link_info(pf->hw.port_info) before computing link_up fix this?
> 

Same frustration from above. I need to be able to stop the
ice_down/ice_up flow from causing an unnecessary PTP restart, but so far
every solution has had some complaint and we've iterated the series
multiple times now :\

> [Severity: Low]
> This isn't a bug, but the comment above ice_ptp_rebuild() earlier in
> ice_rebuild() still reads:
> 
> 	/* If the PF previously had enabled PTP, PTP init needs to happen before
> 	 * the VSI rebuild. If not, this causes the PTP link status events to
> 	 * fail.
> 	 */
> 
> After this patch the VSI rebuild no longer sends PTP link status updates,
> because ice_ptp_link_change() was removed from ice_up_complete() and
> ice_down(). The ordering that matters now is that this new
> ice_ptp_link_change() call runs after ice_ptp_rebuild() has set
> ICE_PTP_READY. Should the comment say that instead?
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 11416e23dadeb..776f211290eca 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -1315,17 +1315,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	struct ice_ptp_port *ptp_port;
>>  	struct ice_hw *hw = &pf->hw;
>>  
>> -	if (pf->ptp.state != ICE_PTP_READY)
>> -		return;
>> -
>>  	ptp_port = &pf->ptp.port;
>>  
>>  	mutex_lock(&pf->adapter->ps_lock);
> 
> [Severity: Medium]
> The state check now comes after mutex_lock(), so every call dereferences
> pf->adapter, even after ice_ptp_release() has set ICE_PTP_UNINIT. Can
> this touch a freed ice_adapter during removal?
> 
> In ice_remove(), the adapter reference is dropped before the service task
> is drained:
> 
> ice_remove() {
>     ...
> 	ice_adapter_put(pdev);
> 	ice_deinit_hw(&pf->hw);
> 
> 	ice_deinit_dev(pf);    <- ice_service_task_stop() happens here

This really should be done in a different order and only remove the
adapter once we have finished removing stuff :\ I think this is a
pre-existing issue.

>     ...
> }
> 
> ice_deinit() only sets ICE_SERVICE_DIS. It does not wait for a service
> task that is already running. For the last PF on an adapter,
> ice_adapter_put() can free the adapter. A service task already inside
> ice_link_event() past the ice_get_main_vsi() check could then reach
> ice_ptp_link_change() and lock the freed adapter's ps_lock. For example,
> the task could be stalled in ice_set_link() AQ traffic.
> 
> Before this patch, the early state check made this a no-op once
> ice_ptp_release() had run.
> 
> The race itself is older: the same window already has a pre-existing use
> of the freed VSI from the concurrent service task. What this change adds
> is the adapter access. At the end of the series the lock is still taken
> unconditionally.
> 

This needs to be fixed via a combination of flushing the service work,
and then removing the adapter I think.

>>  
>> -	ptp_port->link_up = linkup;
>> +	WRITE_ONCE(ptp_port->link_up, linkup);
>>  
>> -	/* Skip HW writes if reset is in progress */
>> -	if (pf->hw.reset_ongoing)
>> +	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
>>  		goto out_unlock;
> 
> [ ... ]
> 
>> @@ -3426,7 +3422,9 @@ void ice_ptp_init(struct ice_pf *pf)
>>  	if (err)
>>  		goto err_release_tx_tracker;
>>  
>> -	/* Start the PHY timestamping block */
>> +	ptp->state = ICE_PTP_READY;
>> +
>> +	/* (Re)start the PHY timestamping block */
>>  	mutex_lock(&pf->adapter->ps_lock);
>>  	ice_ptp_port_phy_restart(&ptp->port);
>>  	mutex_unlock(&pf->adapter->ps_lock);
>> @@ -3434,8 +3432,6 @@ void ice_ptp_init(struct ice_pf *pf)
>>  	/* Configure initial Tx interrupt settings */
>>  	ice_ptp_cfg_tx_interrupt(pf);
>>  
>> -	ptp->state = ICE_PTP_READY;
>> -
> 
> [Severity: Medium]
> Setting ICE_PTP_READY before ice_ptp_cfg_tx_interrupt() runs: can
> ndo_hwtstamp_set now race with that call?
> 
> ice_ptp_init() runs from ice_load() -> ice_init_features() after
> ice_register_netdev(), so the netdev is already visible. The only check in
> ice_ptp_hwtstamp_set() is:
> 
> 	if (pf->ptp.state != ICE_PTP_READY)
> 		return -EAGAIN;
> 
> Both paths end up in ice_ptp_cfg_tx_interrupt(). The user path gets there
> through ice_ptp_set_timestamp_mode() -> ice_ptp_restore_timestamp_mode().
> The function computes enable from pf->ptp.tstamp_config.tx_type and then
> does an unlocked read-modify-write:
> 
> 	val = rd32(hw, PFINT_OICR_ENA);
> 	if (enable)
> 		val |= PFINT_OICR_TSYN_TX_M;
> 	else
> 		val &= ~PFINT_OICR_TSYN_TX_M;
> 	wr32(hw, PFINT_OICR_ENA, val);
> 
> ice_ptp_init() runs under devl_lock and the ndo runs under rtnl/netdev
> locking, so nothing keeps the two apart. In ICE_PTP_TX_INTERRUPT_SELF
> mode:
> 
> ice_ptp_init()                        ice_ptp_hwtstamp_set()
>   enable = false (tx_type OFF)
>                                         tx_type = HWTSTAMP_TX_ON
>                                         sets PFINT_OICR_TSYN_TX_M
>   rd32(PFINT_OICR_ENA)
>   clears PFINT_OICR_TSYN_TX_M
>   wr32(PFINT_OICR_ENA)
> 
> Wouldn't the config then report HWTSTAMP_TX_ON while the Tx timestamp
> interrupt is masked? Tx timestamps would then time out until the next
> hwtstamp_set or reset.
> 
> Before this patch, hwtstamp_set returned -EAGAIN until init had finished
> ice_ptp_cfg_tx_interrupt(). The end of the series keeps the new ordering.
> 

It is becoming increasingly frustrating that I cannot replicate a lot of
these reports from the netdev sashiko on my own runs, (despite numerous
re-runs of Sashiko). I don't know if this is because of different
prompting or lack of model access.

This particular issue partly falls under the situation that we shouldn't
be registering the access methods before we've finished initialization...

It might be safe to just move the ptp_cfg_tx_interrupt earlier... I
can't remember exactly why I did this order. I guess the function got
lumped in with starting the kthread that needs to go after marking the
PTP as ready.
