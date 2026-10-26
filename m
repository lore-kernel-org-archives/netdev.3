Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793051593;
	b=IseLCT+cu/qhn2oQCmMAMgfBFk0FK05li7jrePqAKhirjGf4qD4rxPr8H0s1+r1q2LHR
	 WmGf0Vhjx44edGmJDtsY5YNUpB7Xdx9s/vubiHpSxd4HPCPsK252yIqDujzvKD6hZhKz9
	 zk1ZAFctTq/cH+Hp3YUFjks7x6oAIACmQ8BOsFctkxRv+FBbg8vGak+lRV/hVsADhKULK
	 YRTtDEmhPRAq9U9AH3Q9Dd+0ufAclHSSZzmiOWmNXfDH+uDzpiUQCqsjlRAzP+we6PiLw
	 sVv9YOK7ddcjZG1eB4YpRxcRsA92CufkLFoSlx+Qzm0E9r5QNL2IMaF1V+wKD2+3rMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051593;
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
	bh=FasTW/nbOeH9rSfAyCcWIXkIERkKbRReZwt/LiSMLoA=;
	b=ZOGHhwqm61sXmby4qtnhVFz+VVCZAyzophfhNWvvbrkzTMZkMXWxuMNS9NLWYMehvayD
	 F3wm9XrJ6O6RFc+FrwxMSCH7+AgFW/M4K2UjowpFXISWyaVmrfGUj4Z4np2IXfkMqLBDF
	 t5Asn1EOWxxhKSgSMHBfl4QWUbpJP4natzq6ARL63XNd7mcTlV4cOGOOpBcei24uikYqb
	 8r5SwIQebnuqKQZZLBxkj20MgKPxX2Iw5bwGm2vky6dzwfvGAQzrPezKWE57Hzltl/Lfq
	 I8pyx0t3L9q5gugmQ0nD6l5D6TNufnBYZx5b5HFU2iTvIUv9YSbCkwgW55p0RkdgqZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZwVkE1Q;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C53606D128
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C53606D128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZwVkE1Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793051592; x=1824587592;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VTEGW93W5ibt9SkYs280IHoGM6MdV7Yyf12K/B+LPm4=;
  b=cZwVkE1QlwyL2ntRAB8Q5O3lIQsRiAWHc0eJ8YOsSlYl4m/V7TSAM1UM
   T/jzVSPORtdfcJPLu2s3gxkS5RODR2Qj0UPeeOM8rkT9do6riJKxBddO9
   ogEm97jhGy6XaqW620yJJJeTydYG165Fbgz4vyTCUsmUfJleE5djql/6O
   elcUso35TgTPyM3xeafHmT9KqDLUXjE33XuVmy+uToojxuGk10mrz5suF
   wY89uOQKjtrv9uTY63pd2HLh328xYry7b2Vv1jEL730nXzjHfEIKfniRU
   RVmiw2qHUI1H9EIINBml5jMWdlWsjXRp7fv1SXEBNWyNFP0IvLjvNauLo
   w==;
X-CSE-ConnectionGUID: CDLqvBQqTtiz0FVn31Jl3w==
X-CSE-MsgGUID: AWYOo5t2TeSt+ScwNE8S9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1631157"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1631157"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:53:12 -0700
X-CSE-ConnectionGUID: 3yixuwtmTTSVW2yjbJzbOQ==
X-CSE-MsgGUID: pshrTPK2RaatxouDjrceWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6239941"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:53:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:53:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:53:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk+XbgdYU3R9AwUa7yMYEl984FG1jT2WTx2ayf7gpjwGPFZLL+84gUJKUtx0VNVSGzeTGyZqzYG5sbBRUDrSPBJvmFhLjwyY6PGSWZIFVgp7JxWAK4fyOj5rSLLv/KpuWFIOFuvr1QjmLz+AtsXPA6PW0MLzL5FHnljqd34ABHvtfY9LqJPBJGL2zSchfZP27YQR/Uee+8+xJ+mq0wJFEJF+zUE+PYvU4jQi3K64uMEPFYxiAoR4mEr3bMHCe7WFFuaaxxcMzNIsSu7cFYzDQS5Bs6hR9ExKyepJcA7TYP0m8GyWuj37pxwX47PEnEw7190f3NHIEn+RWB6cVMVLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FasTW/nbOeH9rSfAyCcWIXkIERkKbRReZwt/LiSMLoA=;
 b=c6r15/eNvmecqZHUuaS2qkgl/tBo4OQNP2KcmIjS/GP7Vi+YJognGLEVbmZaYb/aHcUGYItcR0u46g/0aLFxt53/NEeo7eQAaHqQU4ATeHzuAmnzvC4mzwEg9RHWcHHLJb+mQw5X/yt/nV+/7r/lFw5344+nKWTrTtj93fiJSFoPMjGk5Gixf2N2tkCSEsWHtotZ5dmrkWrEG9A2SATBbw2+q/qr1/wXIAtNyWFunxpY3lg8RMjehF8cWMwgxBtMHkERBggcsKE64JEUdh+xB7jSmKb0m7i9GrZ5v6WS9plhAuBBDsR/OMnWoKvdvuaeyBl5Grvb4f+0qT7rCuzLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Mon, 26 Oct
 2026 21:53:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:53:01 +0000
Message-ID: <2de6ca96-f9ff-472a-9e86-0feb69876514@intel.com>
Date: Mon, 26 Oct 2026 14:52:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 10/13] ice: E825: perform a soft reset when
 starting the PHY timer
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-10-72289a4ac8eb@intel.com>
 <179297184384.3134.3372650759308982003@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179297184384.3134.3372650759308982003@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc28262-a23b-4dc6-dd83-08df33ab8140
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|6133799003|18002099003|261026140227099003|56012099006|261021121427099003|11063799006|4143699003|10067099003|5023799004|261009223027099003|261022105027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: OvEfa7YtdQkaoXxNyHgyfKNrA7+7+zMb0c8fpwhd+IeAeBsRpwo41+bm8sfyCThsTNKQUpq7Y3QOAySalahDv5zKnA4k/HUz2h/rPVzfcuJn9C4450uNa1IaCysiDzOg+8Z19kkdYh9c5o0D8mHXZN7MM37YqgOpfKReKMd3qM/KaiH9XVhBXz+4MDo99BcwdOj+kACMstIOmw86bpQHRX+vKzPT02AcrjdniTB63oYjP99umXil3HC2GTwlddDOuHsB025jT8N9o0N7MStyqAq/04AgcLxHOKQG4dgzyMOP7z8kyJ6Zya7lyf+HXQWGfxz6cmiFZO3EUrJbo4hDelNXK3xsCPrBzRyzg/w5SEL4aEw/Jj40hCYXKAVI4dPkSCGS2QbZSmakcQmFBj0kMD1YLDXFqWgrzoFSb9Yct/4vChWVN+P/bcPnQeOaAV/XARqATL5u/Ofwlc2SmmPDBj39nVMeWfDDO/SiUZJ7Q+GCr2UfWgVj7C36/+46KPSZT2Qe2px2kDMJkFcTXQTNM3uvGVd66Vgpe8lngiCrxh1VaYyzwoXQQS4CNwa5i+mnQJtpJThTEgqCPPv1qjpR0FWKBrZ5+ZO4UpzS6my4AsclAvfRbJSd5KseCyEA7kX4DEIF6BLnJxJuMMTMrDPkRIz3m6pjOAcGCqGDvCeAd6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(6133799003)(18002099003)(261026140227099003)(56012099006)(261021121427099003)(11063799006)(4143699003)(10067099003)(5023799004)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFCOWVQajRJVjJwWlppNGtLL3NObWlwdFRpUnZITkZidDBqZkxZcGYwNXhB?=
 =?utf-8?B?b0hyZXF4dnlwaGJXTDU4RStGbktVd1pLTFNkc2dneHlDa0R6NHROZ3c5RjZp?=
 =?utf-8?B?UU5xZGhGMXdqSThUcEN6YzkydGxsVVl3eHJtOWZTWUtjQWlaRVNXNmMrUXJ6?=
 =?utf-8?B?aXRHQjJHUTVINkpSUm9zT21xa0JDWnJJYWpjZVY4cW40Yzg5Q3U4OFMwSERD?=
 =?utf-8?B?djFEWGlUNjZsMDNBUDF3dUY0UlRUZkNNazJQR04vWDk2Y1l2OGFCeUxJS3B1?=
 =?utf-8?B?QVUyQmRUelZKR2FsSHZUWkR2bkF6S0dOZE9ib3hSVm5JT0czclpteEllWkkv?=
 =?utf-8?B?alRwcUJCMWgxaDZCSVJXRkhVT1BzdW9kSzh0ci95b3dRck5vSVhWZEo4cFNl?=
 =?utf-8?B?WDZEYnJBeWFTZ0Q1eThtTVV5dnVTdVZYenVKakNvQ213VWNPZUEyRXhLb0pP?=
 =?utf-8?B?cU5wQmpPenR1VHBVczRodTdZZ0pacHlRQjg1M3FTbnFjT3NzOWFSZnRkZkVp?=
 =?utf-8?B?dzFpdFVPV1NwSjBBWjg2OFJ0czRMekIwWGRINUIyMVc0bERKUWdpZTNMTnpx?=
 =?utf-8?B?UVowVEhqbnN5b3VxTnFDNS9USkgyTm83WGxKV3pnREpMQnRuQXR2ckR5NjUr?=
 =?utf-8?B?UW1aMnQ2Wkc4Wk14ZGpxbnFZSjRUUlAwNDgvTzc2a3BQQ2ZjT1NqTUVaUVZ2?=
 =?utf-8?B?cDNBWk93NXUwVnpCc0kwSXc4OG5Dcldad2NoN0RMSTlQTGorR1lpTWxJVlBM?=
 =?utf-8?B?YXpYOG5WdGI3Nys2c284RmdocFowV3gvWjRUd1BsN1dtMHR6Z2ZHZkNTREFC?=
 =?utf-8?B?MU44b0dURiszdEJ5YWRqK0pyUHRyZmV3YVRBandBU1NuL3NlSmxScmF4RUlt?=
 =?utf-8?B?a3ZGaGwzMmJLZ1k0Zk8xMWFYN0dneFR0QTBwWFdvWFBjVGlHMlZWSlJ3eExX?=
 =?utf-8?B?MVdKUnlFcG9qR2ZyVkVwT2VkdEFIeFpVWUgwYlpDNXpMa2IwVVdvdFlGZisx?=
 =?utf-8?B?VDVMUFVtSElxYnovSmNQdGZjdmxST2pWdnAyVHdxbFhGeFdxbEpRKy9yRnBV?=
 =?utf-8?B?UzdHVWYvU0dXVDA4VStQdk1FK3B4dUdhWmNTUloxMndkT1B0MStwWEtkUzNs?=
 =?utf-8?B?ZkZVVk94SUUvdVVzREp5SGM5RkcrdzU1OTEreEZTMmpPUEJMTHNTVWkvdXVq?=
 =?utf-8?B?YnBTNmhSL2ZPdVlGQ2ExdWtRNy9BMGliOVRDWVVSVXYrSFFJWFJsYTByQUVK?=
 =?utf-8?B?dGNDNjBYY2pucHZEN3BYeGxsQXk2M2NoMUFDcU1HL0UzT042OEJEeVJXL2RD?=
 =?utf-8?B?Y1NZWXNVK2x3VVJPb2RsUFFrSzlCSDNlNEszbE5RcVRwMXNvUlM1Sno3cTJa?=
 =?utf-8?B?aDlvNjArQkF2b0pJNU1BbDZ5aUN3TlVsOGdrRlpQL2poYTYyOUJPMmFFbHRL?=
 =?utf-8?B?ZE9JQkVhdDRBbDY1RzN1T01JeVRQWm1ZYWxCclVuNnlza2lTeU5MeCtsUXIz?=
 =?utf-8?B?WE5hbS9zRk1hblBqYXllaFNlRlErd3VKOFBYbzNzQW5YUWRPUHQwWW1uWFM0?=
 =?utf-8?B?RncrNHlHSWkwT0Zic1pTUkZYbVVURTd0T1hOcDF1R01XeVNOQm83Ti9sNTZo?=
 =?utf-8?B?R2szbUg4ZUdiVGxveUgrMmZSRzNMN0lvWll1ZytZTlJoREI0K2plekZMWlZk?=
 =?utf-8?B?dHVGWk0ySnN0Q3VzUnp1Wml6Y0lWYWs1ZHBDY2lQeWZWSnNvMlRPS2hoT3ph?=
 =?utf-8?B?bGhkZlUxRlpRNVhRRFd2d04zTnBqRHBBbEptZ0xUdlJOUENKaHhxUkExWXNB?=
 =?utf-8?B?OTZrVEl0d1FiOUpKSCtmWFRlcEFlOHlBVGwrSGZQeENJVFZvdk9GKyt4V2VK?=
 =?utf-8?B?akdydlNzQzhtUWFHdDg3Z2RIZ1BBNEtuSDdXZ0JySnNEQ0RyRmI4WE1RYkpy?=
 =?utf-8?B?SmpQcmtOQ2ZFMXFGKzBVVmU5QWxnL2RpRnFtblFlTUhWV0VlQUNFSHVKcTRI?=
 =?utf-8?B?T05JSDdNazJjTW5QbXVXWVRUNDVQU0pxa2RXMjJmemdUZ09kczViU2h1d3cx?=
 =?utf-8?B?V3U5bEREUGMrUWpzMUQ3WnZKSDBtSkhtRUVZUmtBMStNTFV5OU1mVXlIUU5a?=
 =?utf-8?B?WmtQaE5VaHk3RXpVTk5tSm5VanRQUnlhRWdDZnZHRmgyL1J0TDdVNitCTG9m?=
 =?utf-8?B?TFhWdkRqL2l6c01VOTZORjdRTUh1SWpmK0F6SEF2L2ZIZHVnMjQwOWZCSm11?=
 =?utf-8?B?YTgyOWNrMFFjb2xkMEk3TW4ybll4RU9tZjNHTzliQ3JnT1Z0bmQ5aXFrQWVr?=
 =?utf-8?B?WGQ4Um1YNEY2ZEsxQjdrdFJKQmJqekJEa1hWUXFqTHBscW9ESFkzZz09?=
X-Exchange-RoutingPolicyChecked: lrZSLrMys46f0LSS7iGBN3UeRFnEdbQTIup8lojOxLPiAlquNaCI1VzuLINbgnDhBukEKlnO2dEvrir6MM6EAZzQGlKQKAxC05HW7qUu7FnP5gRkp1K+/XBcyyVnSeB2EB0rrzEubYYtNpqGtxtJJKWQqiiQ/e0A11pPDGV67XxTXSeMOXERrOFbQutwLPVzTK5aTp8YPKa9TdVqh+zj164lq+GIV1ZvKd6tplWV592JvO9hwQ3eOcYDQMXMRoh4NewHArKY/O8hSl+XWG7DVp5g24wdixA3po2DWQcgnRy3hDIo+7NUrkSseP9U7Bi2eX14Ix18Vjekv0w5y/YvNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc28262-a23b-4dc6-dd83-08df33ab8140
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:53:01.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpPCn5mVux2fThRa3U1uKoTZxi7h+vuhVIeYXg/rYJOT0Z8PeUeA6ia9ucb4E5kIfFjp/478wZGBjDjcv4O1rcCXQrToxmimtdnfw741lBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com

On 10/25/2026 4:44 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] ice_start_phy_timer_eth56g()
>   (drivers/net/ethernet/intel/ice/ice_ptp_hw.c) now calls…
> - [Medium] With this patch, the destructive E825 PHY soft-reset sequence
>   runs at runtime from ice_start_phy_timer_eth56g(), mainly on E825…
> 
> --
> 
> ice: E825: perform a soft reset when starting the PHY timer
> 
> This patch makes ice_start_phy_timer_eth56g() call
> ice_ptp_phy_soft_reset_eth56g() before it programs the E825 PHY. The goal
> is to clear any outstanding Tx timestamp memory and the PHY timestamp
> counter. Only the timer block of the PHY is reset.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 5637925c0e68..2d000251b185 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>>  	if (err)
>>  		return err;
>>  
>> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>> +	if (err)
>> +		return err;
>> +
> 
> [Severity: Medium]
> Should the software Tx timestamp tracker be flushed before this reset
> wipes the hardware timestamp memory?
> 

I am getting very tired with this... I tried flushing in a previous
version and that got a ton of complaints.

> On E825 link-up the path is ice_ptp_link_change() ->
> ice_ptp_port_phy_restart() -> ice_start_phy_timer_eth56g(). The E825 case
> in ice_ptp_port_phy_restart() only marks the outstanding entries stale:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
>     ...
> 		ptp_port->tx.disabled = true;
> 		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> 
> 		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> 
> 		err = ice_start_phy_timer_eth56g(hw, port);
>     ...
> }
> 
> The in_use bits and tstamps[idx].skb stay in place. After that,
> ice_ptp_phy_soft_reset_eth56g() calls
> ice_ptp_clear_tx_memory_status_eth56g() and pulses the soft reset, which
> clears every ready bit on the port.
> 
> Take an entry whose timestamp was captured but not read yet. Before this
> patch it would have been read through the ready bit path and quietly
> dropped as stale. Now its ready bit never comes back, so
> ice_ptp_process_tx_tstamp() can only release it through the timeout:
> 
> 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
> 			drop_ts = true;
> 
> 			/* Count the number of Tx timestamps that timed out */
> 			pf->ptp.tx_hwtstamp_timeouts++;
> 		}
> 
> Does this hold the slot and the skb from ice_ptp_request_ts() for about
> 2 seconds? Does it also count a timestamp the driver threw away itself in
> tx_hwtstamp_timeouts, which ethtool -S reports?
> 
> At this commit there is also no time bound on the hold. The periodic
> fallback in ice_ptp_maybe_trigger_tx_interrupt() fires only when the
> hardware ready bits are set, and the reset has just cleared them.
> 
> The later commit "ice: keep Tx timestamp slots tracked until completion
> or timeout" changes that trigger to check the software in_use bitmap.
> That bounds the reclaim to about 2.5 seconds. The miscounted timeouts and
> the temporary slot and skb hold are still there at the end of the series.
> 
> ice_ptp_rebuild_owner() already flushes the software state before it
> restarts the PHYs:
> 
> 	/* Flush software tracking of any outstanding timestamps since we're
> 	 * about to flush the PHY timestamp block.
> 	 */
> 	ice_ptp_flush_all_tx_tracker(pf);
> 

I'm actually not entirely convinced that is safe either :/ I suspect
that if we did not have that and tried to add it now there would be
similar complaints to what I got with trying to use it during link change...

> Would the link change restart path need a matching flush? The commit
> message says only that the reset will "clear any outstanding Tx timestamp
> memory". It doesn't mention what happens to the software tracker.
> 

The current intention of the series that that those indexes remain
blocked until they time out. I could try to adjust the counting logic so
that stale packets don't count as a timeout. But the way the current
logic works is entirely built around a flow where the only thread that
clears in_use is the IRQ thread. Flushing the tracker breaks that and
caused a lot of complaints.

> [Severity: Medium]
> What keeps the Tx timestamp interrupt thread and in-flight hardware
> captures away from this port while the soft reset sequence runs?
> 
> Before this patch, the only caller of ice_ptp_phy_soft_reset_eth56g() was
> ice_ptp_init_phc_e825c(), at PHC init. Now it also runs on every E825
> link-up restart. The sequence sweeps all slots and sleeps before the
> reset is asserted:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_ptp_phy_soft_reset_eth56g() {
> 	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>     ...
> 	usleep_range(5000, 6000);
> 
> 	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
>     ...
> 	usleep_range(5000, 6000);
>     ...
> }
> 
> ice_stop_phy_timer_eth56g() leaves PHY_REG_TX_OFFSET_READY set, so the
> PHY keeps capturing timestamps for descriptors that were posted before
> tx.disabled was set. A capture can land on an index the sweep has already
> passed, during the 5 ms gap before the reset is asserted.
> 
> The consumer path is ice_misc_intr_thread_fn() -> ice_ptp_process_ts() ->
> ice_ptp_tx_tstamp_owner() -> ice_ptp_process_tx_tstamp(). It never takes
> ps_lock. Its ice_is_reset_in_progress() check doesn't cover a link
> triggered PHY restart. It snapshots the ready bitmap and then calls
> ice_read_phy_tstamp() based on that snapshot.
> 
> Suppose the thread snapshots that new ready bit and then reads the slot
> after the soft reset. It would read a slot whose valid bit is still set,
> against a counter that was just reset to zero. The kdoc for
> ice_ptp_clear_tx_memory_status_eth56g() says the soft reset does not clear
> the timestamp memory.

Since the previous sweep cleared the bit, this read should do nothing
because the timestamp is not marked valid. A new timestamp shouldn't be
possible to land on this index because the index is still locked by
software. The existing timestamp that was on that index should be
cleared by the sweep and soft reset, so this should not trigger a faulty
flow.
> 
> The earlier commit "ice: E825: clear PHY_TSTAMP memory prior to soft
> reset" says an unbalanced read "underflows the counter, and prevents new
> timestamp interrupts from being triggered".
> 

Yes, *if* the valid bit is set which the sweep before the soft reset is
supposed to clear.

> Could this stall Tx timestamp interrupts on the port until the next soft
> reset? That is the failure this patch is meant to prevent. Whether it
> happens depends on PHY behavior described only in this series and on a
> narrow timing window. Even so, nothing in the code seems to prevent the
> interleaving.

I don't believe this could stall. I am also not entirely certain what
the best mechanism to safely stop the IRQ from triggering is.
Theoretically I guess we could disable interrupts, do this work, then
re-enable interrupts? But at least currently soft reset can take a while
(we're under investigation as to whether those waits are necessary but
intended to change that as a followup).

> 
> Does this path need to synchronize with the misc IRQ thread, or wait for
> in-flight captures, before it runs the sweep and the reset?
> 

Waiting for in-flight captures is problematic as we saw with the older
series and its complaints. I suspect that synchronizing to stop the IRQ
is ok, but I am worried about something trying to disable the HW
register and getting in such a state that we actually never re-enable
interrupts...

>>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>>  
>>  	err = ice_phy_cfg_parpcs_eth56g(hw, port);
> 

