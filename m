Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793049845;
	b=P43VEa435GwCZhh8DJIHOKCyhG4RUbnosHb0yuV/DI7Kf03S/A5Iqyu052Zt8mUREh56
	 pxIFrlQruHr88Htf01jUsP/JQydcc9UJxPcQ2nfuVKAjs8p/27sao9LhIRr6byXD9BNTh
	 OZfnaDS0V5p9PU5wXnIgMHLgsrjlOB6qQEpCg01JYNmfQZaL2jlmEV2Zy2vWExXiTRhI1
	 oAHUDoU3V9mJnx1WFTdxSoqmL6YVcduQCf5MvxTNJCPNL0GfvWILROQLoL6WvE9AMsUp7
	 fG67dX9ABa4j3CoEo1IkA5EsdlK6fX8EDNY8PipuSmGi/HbB9nhblBWw3H0nF+sVi5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049845;
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
	bh=145Cpd+EjKgoRdODLURu4tqUiox4XzORMqn4TciUdDk=;
	b=D9d8K74MjSM3w8TcYW8/7Gsp9OG7eRiAg4xw2nj9Y+0V6NKIZELy3YC7TBCmjzv6CTo9
	 ksrJ9XWAly87X+SbFdTiSjOCVRvXd0wiwhG4P3XHECCvfriKz2Z6CwEhVQhPtzU2iQdaA
	 eE0cwjai+Fq6qvxEvXEGfyn5+3UGc7CkcO6eMJ1VZernu0eNkOAjCR7n3ybVoKYbT2jtD
	 Rxld0ruFhrRFaBN8rWe+QbURY/T6J+aUo+e/zJYFpEsBxWGp8gDRsBkOgT6e09YHDVrba
	 NTI7fsrOC2X6iXhZNDZEDyDRQoauD7N4K26eSGr83BVWokvA+xC7ZUEqiY9qGYryVig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EPIgX0Ay;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45172606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45172606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EPIgX0Ay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793049844; x=1824585844;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=glQ3jojHnLBMzdF2VNwaqHD7XRKc75eUrjWN9JZ7O/c=;
  b=EPIgX0Ayuv6QmIqac4U2ZzSLTvRuJ27wkMjjtESFr2ue5TdZIIyfN89L
   ZSRl7A8ihcp3XBjY+zHXvDxyWreB0zsKlnYifGNOF/niLvO7JcPepPGF3
   Q2Z028s4RXtToE264AoZq7LT9/fXjfY5854Gy9rBys+eK66mTeSINWVHj
   L+iRU5DZCoaxgXH3IBEAIlJV0n7rQTQX+U/Oq023SYNe8V/NnwQadNSuO
   U0pewZEpAdsWwZsZzYGuceHoJiZQif43lwMMwgMk6cC3KSuds2VcIhLtt
   rOGWtHqMFVZPYr31afkND+Pf8cPxEk3yzubENcLMcrfJebIE0Hugs0S1u
   g==;
X-CSE-ConnectionGUID: wDUPYV1tS36P3Y5amjF4Ag==
X-CSE-MsgGUID: 09vIWV3IQ1GxSgRt/aAJYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1742306"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1742306"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:24:02 -0700
X-CSE-ConnectionGUID: grgru7ONTtWEIOJ+V5kTqg==
X-CSE-MsgGUID: Dx6aZp+JRE6+Uz3sD32BDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4481202"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:24:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:24:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:24:01 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxb2KDC4cH4P2vWlpuLyZhRGW9LmVll5Yqp2yNyAY0ZJf5pOstrhmEhH5eHOdT8+oHfali5mGluSUzOt5qym93rPQDHbCXaLglfT6czW+PpHBSq89UwT9OfvXZk4bMGYeXwubRuEz9Jts307ss37VhXqdiLITRslspI038ux6Tqk/aKpmyh+Ta87VOb5oC/mNwaiPMLxe60Qg0nxDzFENrd1m8j7qcr6UdubOJ6/PH+fjJaLsIP0d8Fa83OH5pdRd7Yqv0VKQD985jukqv4ISsdWLcPA5QGKGKH+YZDy41dVKtPNlklr39sZJA1HFFII7YzLkxy1lxaAeBxZsKpzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=145Cpd+EjKgoRdODLURu4tqUiox4XzORMqn4TciUdDk=;
 b=DS+3DYGMBZbBL3c5Lh6XljJEdp56OjF1vTkN25OkfYI6mdVzbBgYg5Ww3QhkjusXbGJdngilG58iEyese+m7w3Kc2OSybPrODnYSaylrlO5aAy+E2U2+43k+R+m/9gDPrm9Kt6SWWIq6y1e7h0+1KPdiPx32ZCMbJzxm9M5FBaYQdEwN7YGVih784CpZvomk9Vw0Jy+oDpa8lFcCmJLefftS0xqthKPZEVrflhhMDBn9vyLvsmXa6GCcDk6VpO9Dpc6WCJXGsftaeqVfPUAwhXHAW1MUl/kjpYxo4EcWWUWwMKBgBpdmzE0VTLJU9DROjMdjjAemSe5zpM07wMNLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:23:58 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:23:58 +0000
Message-ID: <f9b3766f-9d31-4a96-8d4a-2c52a161e0f7@intel.com>
Date: Mon, 26 Oct 2026 14:23:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 01/13] ice: fix removal of PTP timestamp tracker
 during reset
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-1-72289a4ac8eb@intel.com>
 <179297183411.3134.15060779235779250719@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179297183411.3134.15060779235779250719@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CO1PR11MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5910e8ad-3127-42f6-514b-08df33a77249
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|261026140227099003|22082099003|18002099003|261026121527099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: wsqeH1rnNhVFX7ZW24pHf848lgi2c4K+dU2MluiNsJbqrfkNxJ+MU+v1fL0B1szNfzusv+qDnQQJvfwEBHL+uiE5l+7QTEUO824I+oaqVJv0VX5+SgzPM4WSvAk7ZpRVFMk0ttL77eau9/SugNTNsI/sNcmMZoj0iGq4NyhnyhIlKmZn6KCe1LPW5v6T2jI4wi28BiRXANmvdMuvZvyUhqYGqU7wCTmyeszw60XzsmQbVByYolrOPYg5DrRaD3ej1TSOd7712s+I+q8aQSs1aQmhpDp8ID5Om666Knjja+VHDpb1C50PeYussdt2zKR25yyXy+rB7nlRNAuqCBUHa03cdGcvMCZ4PaigPO5VNpS5oOIp+GX7AzFiHhnOdn++k5jEcKos8IGC9o60QTI+PuTC8K31w3wJCfgINE4UiVCWNd7p8EceESgQlYsBbh+q6TwbODm8WqYj7/t0RFNhVaLiuti5k30tpxipHNauIQJvE0ZQuXu9HvqK72Kpnl3CRLqmAv6544ry69OjXinxDCEEw6doJEovnfpqYBk7HGpSMU5hox4Uc9QTTvgMmHXmQUji8sHpL8fBqbnj++7FvAHiJJ/+B+A8pwJQivl2T6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlJ2QjNLVHZaRDlYMnZxY21OS1QreVMvNFR6RGdPQUl1UURLSmNRaXBvMTJp?=
 =?utf-8?B?ZHkvTnB5UlFuczRCVVlyNnBxcmozMnZ3Y2FuS2pVQ1FXUW96UmllL1EzenVU?=
 =?utf-8?B?cW8vUUJlRHF6UG82bjJtcjlwYzRwdkI0ZlVjSlFtcGJNRi8xaVJsOVduTTlk?=
 =?utf-8?B?cnBOektDT1AzYUI4eEs4emQzQnhmbkFxRjQvbjNteG5UV01xd1cydWRRVExF?=
 =?utf-8?B?ZGxCc1V5Smg4d2FlNTBRZ3Q5d2wzazRydG1RYVYzYlVWNUc2TWFJRjBrb1JC?=
 =?utf-8?B?cGdJTDM1RVNUV0krKzNGNERHTVZ2ZEdtSUNWZHhXK0FDeStpR1U0ZVVVYnZ2?=
 =?utf-8?B?WGJMcFAzNzQvSkNsZjRENGNQL0ZoZVZDQVc4bUkwUnR4T1hXZ3FLKzdkY3ow?=
 =?utf-8?B?ejZvVG14QktNaThCdk00THNrZGlmb0NMc0hKYTlZbnN0UTVtNHd1SnpzY0Yv?=
 =?utf-8?B?bmRlNDdjTmNxUkhwbzlLd3FJQXoybVVOK3ZrMnpXWDR1MTlEczVvOWNGUk9s?=
 =?utf-8?B?VTR4eGdSZ2JqSVc3TFBkT2V1R3FnVEhkSVc0UjI2TXpIRHp3OHVpRnlWR3RI?=
 =?utf-8?B?QkMxalJLd21zTklnNHhndWQyc0pwK1VrT1UwLzJtTGlDdUhWazdGRGZrRDdN?=
 =?utf-8?B?TmFHL09HM0tKOWdyNnJHZ1h5Tmh5MGFUQm4vTitmaXR6RTdLeGpacEZrYTNY?=
 =?utf-8?B?MWNPaVlPeTk2Z1M4UnVFcWl4L2JWUnp5cW4zSXA0OWdEaldKVi8vZTFqS3Vy?=
 =?utf-8?B?TC92aGd2NTdKQ0UyOTZrelM1S05idkdrdzFYakNvdHFJZ2xuclBWRU5hL2lR?=
 =?utf-8?B?eENBOUhQZG5GNWFVWlBuejdkcmR0dkg0ODczOUdJdVA5RHBHRVFSN1hUWG90?=
 =?utf-8?B?Y1M3Z2dQOGwxZzNVdnpma3ZVeGM1bVF3Nk9YL09GZEdqUlNITTBPZno4QzBO?=
 =?utf-8?B?UTJTcVVWcE9CVnFHcXVrZXRuRWJHL2FUN2V2dXduRlZvOGRPOWpEaG5ZQnp6?=
 =?utf-8?B?OGd3RXczU0o0Yk5LL0N4TUMya3ZzT1h5d3BDQVRpZEVId3dPTGZFaytWVGdj?=
 =?utf-8?B?WFdWcFY2d2piRzd6cGVHc01pZ3c2V2lOQWdHRzhSYlAvOW5BcCtVZ2I5VVQr?=
 =?utf-8?B?L1dCOElyb2Z4eGpPeEs4VnA2Z2V5bVRqaW9xVGV2VkpwcGU0RGtuTkFJNDZi?=
 =?utf-8?B?QXYyOG1samtXWTVjSzVrcmpZSEIxcDByUDUvOVZaWkpKREwyck8zbUxqWTUx?=
 =?utf-8?B?bldEYTh5eDJubjViMEtCQ3RzYSt0dFpTeit3c0VjSjFRc1k5NDcwRVArVXZi?=
 =?utf-8?B?ZE1tY0t2QjliRlMrZ2NCenkyUzduYVYyY3RmSm8zZ2dUNmdkRk9pZVlLc2Nx?=
 =?utf-8?B?c2Q0STJCL0p1amVSRkFuK0xKYUYxeVJaenVmZC8ybW5DNjE1ZE9CRElWS0xu?=
 =?utf-8?B?TURhV1Q0M3J5S2NRR3VTaDZFVm5WU2NUY2VLb3RIYVk4WFJ4K3EvZTVZMTA3?=
 =?utf-8?B?TXYxZ3RUc0NlUitLUUhzUHdwTU5BTEhTeXZ1cm9hMlhONlVoelZyYUZOSlQx?=
 =?utf-8?B?Z3B4QWQvb0ZRL200dEN0WWFuOVlzUHU1QU55MUtSYW1kcnVVS21JMmFaelgx?=
 =?utf-8?B?bG53NnZDMWFQbzFHRkhoWnl4Um5maDNPUXltMWpTUi9RaDg1TDBHQWdoZUNt?=
 =?utf-8?B?eHVkZTdkYUFNREowc0FkVTZKU3dFa213SEtJeUtrTlR5NkJ5cmxvLzAvb2U1?=
 =?utf-8?B?VWU3ZEdJWUZzNFFDWE9OOFZZbzlSRFBrcUdjdjdtbFMwR0RtUmFDMzBIV2E5?=
 =?utf-8?B?bVY3SG5ITnEyNDQvSThtVklTRHlPSVY3cDBGTi8zeklaT3JIL25ON25WYUlZ?=
 =?utf-8?B?OUdtemlpb3BkZkUzZXpCMWFTNUQ2LzBxcnJLM3FEQ0s4WkRESXl4ZW03UXFj?=
 =?utf-8?B?bG5VSnF5Y2dDUmhBS2R5M2dEbWRyL2V5RlRPaTcweHRld3l3azcyZlpYRDNR?=
 =?utf-8?B?dHA2cGlqUW5FTlcyQmY1UjdRN2ttUytneG5hck9HRVdQWFhaQnhQRmwxTWxq?=
 =?utf-8?B?Q3QwNkN2VS8ySlZlYUdLK2NnTDdnV2lJY1NkVzBBTmxyUDNmRmMxbStHeitY?=
 =?utf-8?B?TnEwVlZBTTBmdnEyQlFNeWh5d1ZJNDI2WHZ5NUdvTFRUWFNkeFhmM254Tk5l?=
 =?utf-8?B?cTBQVUROVU0vdzdLWTIxUXNNQlhpMnA3NHhoVmFtbFNTUHZwUlllK1h6N0xq?=
 =?utf-8?B?bXBuZ0lOWGlNa3ZOTlZBcTNzMXRGV1QrclNNUWdjT0VFREdhc2dEOU5hcTVM?=
 =?utf-8?B?ckRUWTFZdWtBTjZBQ2lvRlRwbXpGU3hlbm84bGsxd2hJbndxV3ZkUT09?=
X-Exchange-RoutingPolicyChecked: XyuoADqaxIyXf6nb9gF+Ihs4MagM8FlXQa3DihqrdXtKxP+VXzzZ9hVbMhiGDB/dztnylfrJWBr/ep9dn60hinv7JDO7KfA99sSMA3n2mgc/eqkhfh5NcaLxyb12jxnb2XxOyG43xRhqbLG3Zzaq0AaA6Nret0IAD6KV4FSRXNZZJ/bNMpE78N3p6HheCHdi9cY+7r71EVxV/WlND18Ask9tgjgvUcA0cZpWQkQlSVVW6ga1L2EDW8zBMtG0g7SvyWhV4k7xyErAmFVl4u4zmoi3ZuQCjXlqo5+D3+DQP4QfaKhQ8pN1MxY3onVX7IhJ2UQHt5W6OlxXDkupQYUDPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5910e8ad-3127-42f6-514b-08df33a77249
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:23:58.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuwmEXkhg0KkvSBAJ8KlP3DpvFOrzh8O1Z5gmdF+MndEXqENA83hsurOqFqVH1+mrvr1zVNEJWgL8x3IcdytZC3pBFV3GFQYs2E5XX0x2p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com

On 10/25/2026 4:43 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new error unwind in ice_ptp_init() destroys the PTP
>   kworker while the owner's PTP clock is still registered.
> - [Medium] On E810 (has_ready_bitmap == 0), the Tx tracker now survives
>   CORE/GLOBAL/EMP resets.
> 
> Pre-existing issues:
> - [Medium] Concern: ice_ptp_flush_all_tx_tracker(),
>   ice_ptp_restart_all_phy() and ice_ptp_prepare_rebuild_sec() walk…
> 
> --
> 
> ice: fix removal of PTP timestamp tracker during reset
> 
> This patch stops ice_ptp_prepare_for_reset() from releasing the Tx
> timestamp tracker, so timestamping works again after CORE, GLOBAL or EMP
> resets. It also reorders ice_ptp_init() so the kworker and tracker are set
> up before the port is added to the port list, with a matching error
> unwind. The non-READY branch of ice_ptp_release() now frees the tracker
> and kworker.
> 
> Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
> Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index eaec36ab6ae3..e1c66cd0f94f 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>>  
>> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>> -
>>  	/* Disable periodic outputs */
>>  	ice_ptp_disable_all_perout(pf);
> 
> [Severity: Medium]
> The tracker now survives CORE/GLOBAL/EMP resets. On E810, can the
> cached_tstamp values then drift from the PHY state after the post-reset
> flush?
> 

This is a pre-existing issue that should be resolved separately, as
discussed on previous versions of this series.

> [Severity: Medium]
> Is the PTP clock still registered while the kworker is torn down here?
> 
> On the clock owner, ice_ptp_init_owner() has already registered the
> clock. /dev/ptpN stays live until err_exit calls ptp_clock_unregister().
> 
> The settime64 and adjtime ops do not check ptp->state, and they call
> ice_ptp_reset_cached_phctime(). Suppose ice_ptp_update_cached_phctime()
> returns -EAGAIN because ICE_CFG_BUSY is held, for example by a concurrent
> adjtime on the same PHC. That function then does:
> 
> 	kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
> 				   msecs_to_jiffies(10));
> 
> If this runs after kthread_cancel_delayed_work_sync() but before or during
> kthread_destroy_worker(), a timer is left pending. Could
> kthread_delayed_work_timer_fn() later touch the freed worker?
> 
> If it runs after ptp->kworker = NULL, would it dereference NULL?
> 
> One way to reach this window: ice_ptp_init_port() fails with -ENOMEM from
> ice_ptp_alloc_tx_tracker() while a process with /dev/ptpN open calls
> clock_settime() or clock_adjtime().
> 
> In this same patch, the non-READY branch of ice_ptp_release() unregisters
> the clock before tearing down the worker. Should the init error path use
> the same order? This ordering is still present at the end of the series.
> 

This is actually a problem that I think needs to be addressed
separately, and work from other developers around the lifetime of
adapter->ctrl_pf. I've tried multiple different ordering schemes while
trying to get this series to pass Sashiko review, and every time I get
something else as a problem.

The current behavior is a problem, and the ways I've tried to fix it are
less bad problems, (but still problems). I am getting extremely
frustrated by this entire process.

>> @@ -3399,12 +3405,22 @@ void ice_ptp_release(struct ice_pf *pf)
>>  		return;
>>  
>>  	if (pf->ptp.state != ICE_PTP_READY) {
>> -		mutex_destroy(&pf->ptp.port.ps_lock);
>> -		ice_ptp_cleanup_pf(pf);
>>  		if (pf->ptp.clock) {
>>  			ptp_clock_unregister(pf->ptp.clock);
>>  			pf->ptp.clock = NULL;
>>  		}
>> +		ice_ptp_cleanup_pf(pf);
>> +		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> 
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch.
> ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy() and
> ice_ptp_prepare_rebuild_sec() walk the adapter port list without holding
> ports.lock:
> 
> 	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
> 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
> 
> At the same time, a peer PF's ice_ptp_release() can remove its port from
> the list and free the tracker, kworker and ps_lock. Since trackers are now
> kept across resets, the owner's flush walks memory that belongs to live
> peers.
> 
> The next patch in the series, "ice: use reference counting and SRCU for
> PTP port access", fixes this. It converts these walkers to
> srcu_read_lock() with list_for_each_entry_srcu() and
> kref_get_unless_zero(). It also makes ice_ptp_cleanup_pf() wait for the
> references and SRCU readers to finish before the tracker and worker are
> freed. The race is gone by the end of the series.
> 

Yes. I tried different orderings of the series, but putting the RCU
fixes first  seemed to have it complain about problems fixed by this
series. etc. etc.
