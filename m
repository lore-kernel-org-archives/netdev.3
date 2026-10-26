Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793051954;
	b=e2msGeN+JzZwQdj5BpKLjDH2kokLXnljfb7yNw8UDykHCiNadlYzUjs5Et/kj7rorPDS
	 PuTtynE1/7JfqNkj024kVoc1o2kbtltju85r1su80MhQ+yr27O3zrU8Km5ymtp7Xlc9i/
	 59JWfpOPgzWGD4+yWdyKZc5GM+rstltQx9d9TIr7DCqUh3YOKJ1n4onNdgqrGLo/LRgDE
	 Y9JUrStGAy6/x42fZsEhYwuO132l565KMo6ntLyiQPxVToveG2nJTHgpvWP12mptUBKg6
	 fi9sLTdOXsH3FLaEYSQKkBHdm97xaHneoS18kcOiVGiy8aYBCa43yXnFUcoY0TUjw0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051954;
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
	bh=UNUga/VaPfAjIfbh/Z0eANtvHRQfusOMBGQYfAstIEg=;
	b=N/IV4PbzwObgiabcvsAF1DyNM0UfUoRPG3X7WYCJzpuQnqCz29novmTL41FvVk0BKV8+
	 Ohp7fPjYMfEB86bQHEIF3sORgJJnemK/LW8HWG+qE1Ty01jfFcLV3PXYLqqLlIa9T4Ieu
	 UjoWnWFfjIyBh+VEzS1SLJBSk5ML5xsyByQXo8NI2u4/At9z3pBN2UVzA7d2pHZBKizJR
	 +bI1prrhWqv04Vbhg7GX2h2iM+2QjyPUzDFAPSKimoYHQpf4NaAEmC0IezZfxMx9Bz7RJ
	 Bwj2VTu+VR/12gv8cI738Cp6n4lcBN54n7iRIY6verb9zN60P0lv4UzVhw534ucfWJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jr+CKf6T;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99554606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99554606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jr+CKf6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793051954; x=1824587954;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fHSfkeFDbA5r5p6ANz5e+cmP0/yqCcsrZJzPwDX4Qbg=;
  b=Jr+CKf6Td+FY4QM9iGk9Rm3HNvqHQX4/vyKKYvNSMU29SUAJmHYtONFV
   JE5pP46LMhYNcgd2gNNUS01I8u4r56i7UoWUx2JZEgl8GsK214Dqi70Hn
   4f2XYC0Mx6/lmn/qvhFk8b/oR0mKUKUb7HLbhBgaJHzDC0OXHo/sBEjNQ
   p0KR/aSWDcFc2rM4miTHhiUAoZIaTMqCeEIeZbplVN8bjfL4Lt9uvI44m
   djlygY09W24W3lD0xUDluXgPDTEAMkan/rAaO6o91DO3hy8oZTxM96/d3
   ZQZN7s9xA4VGCHUvaIW2m7uapY2GO9KJMHD5ivsmCJkyovaYjJJwml+yj
   A==;
X-CSE-ConnectionGUID: uHnXZ7ZjQiuH/u4gmZXboQ==
X-CSE-MsgGUID: r8Ci5MlpQXKw06Ho6cJUBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1766593"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1766593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:59:07 -0700
X-CSE-ConnectionGUID: pEF9tmfjRJ+QZyEqppHJ8Q==
X-CSE-MsgGUID: VUROuDZySOSTR6YyluPrIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4240636"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:59:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:59:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:59:05 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:59:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7Db4ZDadm/PplH5ysxqwKKdFJbzmaeb/tOt0Xke9kBC/4rkMibCBycTdNEWD7u9UyHU9CK2CFkdciCe/afpkgtFYVk0kq3XqZksmY8e8qSYRWh4VyhCiH712UyvWs/djisofmR75NB5b63ikGWK6iK7vRGQ05+6ofRouflla1uR772LkgpI7a8h2IgWq1KcwGhNWM21LoiYeH5PUfmzUaPfo1SNhzZwppRjxU4swG0+A8O2uPCP2mA9TWYLLogHNy6fwTbMGKNT5MdprQ5qskhIx8ovWAJ49GehML/YcCeutGXK43xmm3sjqbpFTR1R1RgPGBuprcXg1QtZdqNCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNUga/VaPfAjIfbh/Z0eANtvHRQfusOMBGQYfAstIEg=;
 b=CRVWzLMxztgzUTJlWseFwDX3tNQLNAbp/ObpocAQJ0GkT0CSQy6InYIfIFUsp/c0n7RjH/5MGCEXHxtm8xOXu50oTcDgtBcdiOsE4Xu80DQj2+okbzYTwXm2K3+AcqjKcn9PACuWI0kCjlNO4SqGqOHCjCryYs8a9LMlCDdBBRcSp4VVNxc8lVO0fuPLsLdeyY0Nu0TJjUlk9LKl67LxgbIv2L2l4/saKWtIhCcAxCXGTxCq+baK1pn1vcibgbPq+qnSQ3VA/77fwkNCGaHGXKHR6pe4kDqQIL+rtl8l4p69gUIF6OZJyTAv5rs/RBKoBaE35MsyVyJ2Ygl6bKRt7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Mon, 26 Oct
 2026 21:58:57 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:58:56 +0000
Message-ID: <ba2163b7-2b65-48cc-b637-3aee46d2bf19@intel.com>
Date: Mon, 26 Oct 2026 14:58:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 11/13] ice: keep Tx timestamp slots tracked until
 completion or timeout
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-11-72289a4ac8eb@intel.com>
 <179297184533.3134.5564062752798799751@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179297184533.3134.5564062752798799751@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5ab5eb9f-eec3-4f5c-3497-08df33ac5513
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|6133799003|18002099003|261026140227099003|56012099006|261021121427099003|11063799006|4143699003|261021123027099003|10067099003|261009223027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: hLe1ULShMWlBgcy08F6Yjw3/tw3wFVwOUVUuy7g/pR/ayGETK5D2asxc6C5Hia/Spywd5WifMbTialwtnW5T34gft9c8eMATiMgrAHCFhqP/zmI9bO/qnj1KauIlU+3QMR5ljF3EwaYutSObeJUuAFt12wysst8TArnvmxv+O2OEy1DBNGTc63o3VwMV1e5WDyR8XLkcBti/TYpzDSQXejnjr7JkLleIu7unxr/hGtzfsAkjoNfV5BLAEriLVmSxaBAKipVI04pCO1pZJdjkNrUirAFfZCV5QsZinurq+49ESlzBVFgk8CV9vVB8BXc0UR3hk/DrRq3BowTqvuGrXXOA7wBhH/qRp4ywDOT+CaKf26mfqm5NCdjnc5jV/Y2uq3SJciL4VjNnjPfhABkxEXLqBLh7B/AFt/LsAQ22i908XeOxMGAaatoSMf/fQBCOdd5Dj08rQBdDuVnC/6tloxM2WuGp/xalnh4V8WTYxQIxkSnnzIh9Lcd0WVA1Ce2qPnGveMDCddeuNM5DT5+Zfn5QTEckxr3Ws0D4njdCmCQ49kXbT2/woUftxugsfdgBec4cwlXJVOR7G5qPXiroiRPtfVsuqoXihGPHPcY0y7kyY6eCzfHx71PaF/KlMcbaT0c3LB7D+7183dbYLihh6SvfmBXy543MBuB4uMrOvuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(6133799003)(18002099003)(261026140227099003)(56012099006)(261021121427099003)(11063799006)(4143699003)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXIxZDV3dmNTQmFvWi9QajJqSE9DUTVvOFQ5RlhHbmZQUDNBZ2xhN1cwazI5?=
 =?utf-8?B?OFl6NnY1VXp6Q05jVVlUcjJwd2dwRDRxMzlCT2xPUjB4L3Mxbm5NTWR4Z01y?=
 =?utf-8?B?NGRGb05kVEVHN2FvaFF1Y1dFbHRFUTYwNXlLRy8vb1drRzF5ZkcwZ0FRajVz?=
 =?utf-8?B?RWR2eUI2RjhWaTJLNWIzMU5iSHlSZVIrTWtCa1FCWjREWmU0TWNHTXV0c215?=
 =?utf-8?B?K3AvV1VKclFHTUJMODRiUFpYTEZKNDEwMXpCTG00SSsxT2hTVVBhNG1SZW9J?=
 =?utf-8?B?RTBSQURnc3lnZWdUb0plcTZVdTk0bXFiUlZVZVVnTWhQQjlxZEM1bFN3M1R2?=
 =?utf-8?B?cjNoQ3dWWmptZUNiL29VM1lNbGR2ZmJ5OWsrbGd5Nk9PTVY2WnB4YnZtek95?=
 =?utf-8?B?VVJYOUNhZ2QyWW9zcmNFc1NBUHdpNjBBRFRPbVhrQy95MmtpTC9RL0lZOEts?=
 =?utf-8?B?YVNCbmQ5bWxuWFpIL2M4TG5hOXlCQ280REJNb1lXZE9qUXpjWVowM3BuNlNB?=
 =?utf-8?B?UW9xVkxXNCtmU3ZrRm9jczNiTC9QMHhtMHV4dUpGV2pQekdNZEZVNERiUEJL?=
 =?utf-8?B?ZHFxWnRDRWh4b3VqUXd0Y2RrTjdMZlNpREtaK0RWTVZqN3FUVU9abmlOY3Ir?=
 =?utf-8?B?M3lZTTVaYzZuMzV6WjJCZGVMTW81NWovY28yMC9LUHRiN2hESnRxbGVFV2My?=
 =?utf-8?B?SEhYN0tCdlFEaENwQndrd3BNazNoT3JjdEViVTd1a2pGUExzTzh1eTd5amMx?=
 =?utf-8?B?b2x0bnBTWmk3OEN6RDVqL1lVa0pCSjdHVFZJZFQrUGdXY3diWG9QaElEUzg2?=
 =?utf-8?B?eXluR05JUXNLZE9VRkc0Y2JnREJGeWtISXpxT1BqNGdlUjVnSGxRazhhMzl3?=
 =?utf-8?B?M21OSmZDcXQ5RElUS2tWanBaNDhpZTFSK28wK2dQNVlhaDdqdFg5RnYvT2Qw?=
 =?utf-8?B?ejQ3UWJySWxUUkFwbnIwTXprKy9LU1NlL3lKOVNDaGJwSklLcDRUNm1yanpn?=
 =?utf-8?B?NW93OFZqV1ZoZnpkRU0vMEN0ajZQNFBnZ3JMY3dqeWZJZEo5MEtTTjBFN2VZ?=
 =?utf-8?B?ZW1kaHNSZTU2eEJqQk9rR0hiTk1yS1kvc2tGb3RPb29TZWxmeU9SVXJ6WE9S?=
 =?utf-8?B?R3RNcnJlMUR3Mi95OExxVkNHNWxDQlRrbHBIQXROQy9qQnppQWs3b0ZZVTdo?=
 =?utf-8?B?TUlyUnFKdlNQbXNmUjh4R1ZkcVJQNUFDQVU5dmRTbUhab2w5WmFpTVpKU1Jl?=
 =?utf-8?B?dWpnV3llam9NTkhZbllKQXpGVlR5ZG9UYyttMFVSQzUrNG9oTWJnT00xeU41?=
 =?utf-8?B?RkcydG5kZndha0RZTVBXa21aMEVPQUdVdTVUOXNRTy9jNlJTRlZmS3V5R0cz?=
 =?utf-8?B?bHRXSjRZemlKdktTY0ErK2xxeXdkNERjUStuR2Z6MmpweEM2NWFEYWU5cHhF?=
 =?utf-8?B?bjRiSE5uYXNJLytYUGRCZW1teXlKczBUNEF2eVdIRWFsRjE1RURZaFBaSFB4?=
 =?utf-8?B?WStRMmIyVFNXbENpL2N4bWVWamxMK2Z5ZTRyZzVrbndETk1RNy9PRWVCZmZp?=
 =?utf-8?B?Q1JWdlNHQVZRazFRMFg1NVpQMEVkaDQxSVpqRWNoeHU4QVBGelpLUjBDZnI3?=
 =?utf-8?B?aXRTc003WEVkNndZZnFSaldkbDBBS1IrNUJzYXpUcWZYYWtGSzlRdDdKOFFm?=
 =?utf-8?B?Y0lGRE5ZOVBXMHJTbmNzUlFSTGdML1FiR1JLSzZhNGJjUFZHSmMrNXZvYm1x?=
 =?utf-8?B?TjEvMTh4amhhVlF1UC9GandCak15cDFXUjZ5TVpxaHJLZDV3Rm83ZW92Rkpy?=
 =?utf-8?B?NWplRFY1VWFXeWxhWDJKVTZXcXloaGJkejFLeTRzeklXbUxDSWQvbTdMOEdu?=
 =?utf-8?B?WjFJQk5NdzZkMHhuN3dCK0JnbHU0dlE3Uk1SRUs0QnIycDI3dENjbnU4NU1u?=
 =?utf-8?B?Zm1aY2I0TlV5UjlpRXh1a09FT3RnSlRiemdJckIrUjZUY0pCYXRIbWtabi9B?=
 =?utf-8?B?MllkWjNJUnZMMzFhZTJlYXlSUDdDanNmZVBtaXdVNEMxcXNkcXhzdlFyZEx4?=
 =?utf-8?B?M2l0Q2JJTjZVL0VFQ21NRGpPcFBjRWk4OHNGMlZpQVpQMnhBbnU5endqWG5l?=
 =?utf-8?B?V1h1bEYyMVJvaXhoQ0tRbm5DOERMZVc0dkdBbGdONkJ6WG9LZnVQRjNoQk1t?=
 =?utf-8?B?SDZuaWhOV0NhclhZd0M3V3owNER2TWdEU0d4ajJPV0ozcU9ZU3pwb2xVSGtm?=
 =?utf-8?B?MTIvTjBRRGVPZ1JTRitmZ1c4UEJDMStXbFRCT2ZMWlNwWTJUMkxRMkt2NW11?=
 =?utf-8?B?REEyNDBBZWxsTkhVaU5rbnA3N1VRVW5YZ3FYVXIxZmxEcTRhb3hxUT09?=
X-Exchange-RoutingPolicyChecked: AoPd/DmdJIm2fJPbMWKuZvxDPdnbHSDjdPoVoo7dj7RuFHICzv5zpv16ylS+eZU3ZxjseHE3snqY2+Aqfkz5Z9rgzuHImEoKFakv/keesEDSmm6KD68FaWylGZVtIChk2SemmSrQvww5/y23eMir2mkS+wRU/Xq4xOolNLtIEV2l0YAZuE5mdAur8WkdDvG167fva35MPAEUJXKNMMHsS24iKGE0/T7vPLxudP3AtTgjstbTda9MMzhsAFRxiotRaLHxB3vMTuPnTWD2hzcfYlmi/Hl7ZqmlThRjJJ9q+IELfxkwpP5hKE5+TjTKjOZ0Rlqtv+yL8Z4l7CqWYl/QEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab5eb9f-eec3-4f5c-3497-08df33ac5513
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:58:56.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP8YUwncXgtlyQJWdo9Sve2vtc87cL5cYCialgqtpgKdkt3vKzKDprV3EgBw6BqfC9SsddbIC7C21Hig+MOP1cXshvfTDgD3ICA+kezCgfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com

On 10/25/2026 4:44 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says link-down requests are marked stale,
>   but the patch never marks them stale on E810, E830 or E82x.
> 
> --
> 
> ice: keep Tx timestamp slots tracked until completion or timeout
> 
> This patch stops dropping outstanding Tx timestamp requests on link down
> and rejects new requests while the link is down. Slots that are not ready
> yet are now released by the existing 2 second timeout. It also makes the
> interrupt re-arm checks ignore stale slots, and lets
> ice_ptp_maybe_trigger_tx_interrupt() run for PFs that handle their own Tx
> timestamp interrupt.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index b7c539f98276..309fa2877cc3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  			return;
>>  	}
>>  
>> -	/* Drop packets if the link went down */
>> -	link_up = READ_ONCE(ptp_port->link_up);
>> -
>>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>>  		struct skb_shared_hwtstamps shhwtstamps = {};
>>  		u8 phy_idx = idx + tx->offset;
>>  		u64 raw_tstamp = 0, tstamp;
>> -		bool drop_ts = !link_up;
>> +		bool drop_ts = false;
>>  		struct sk_buff *skb;
> 
> [Severity: Medium]
> The commit message says:
> 
>     Mark the outstanding requests stale so their completions are read
>     and discarded
> 
> Where does this stale marking happen for E810, E830 and E82x? The patch
> removes the link-down drop here, but it doesn't add any new calls to
> ice_ptp_mark_tx_tracker_stale().
> 

At present it doesn't. I think this was needed for E825 because of the
complexity of what the reset flow required. I am not sure its actually
necessary on the other devices. We can improve the commit message for
clarity.

> On link down, the only caller that can be reached is the
> ICE_MAC_GENERIC_3K_E825 branch of ice_ptp_port_phy_stop() (and the same
> branch of ice_ptp_port_phy_restart()):
> 
> ice_ptp_port_phy_stop() {
>     ...
> 	case ICE_MAC_E810:
> 	case ICE_MAC_E830:
> 		err = 0;
> 		break;
> 	case ICE_MAC_GENERIC:
> 		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 
> 		err = ice_stop_phy_timer_e82x(hw, port, true);
> 		break;
> 	case ICE_MAC_GENERIC_3K_E825:
> 		...
> 		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>     ...
> }
> 
> Also, ice_ptp_link_change() skips E810 and E830 entirely:
> 
> 	case ICE_MAC_E810:
> 	case ICE_MAC_E830:
> 		/* Do not reconfigure E810 or E830 PHY */
> 		break;
> 
> The new in_irq check in ice_port_has_timestamps() only excludes stale
> slots:
> 
> 	if (in_irq)
> 		return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
> 
> Given that, can a link down with a request still outstanding on E810
> (non-LL), E830 or E82x cause a back-to-back interrupt loop? The sequence
> would be:
> 
>   link goes down while a not-ready slot is set in in_use
>   ice_ptp_maybe_trigger_tx_interrupt()
>     ice_ptp_tx_tstamps_pending(pf, false) -> true
>     wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M)
>   ice_ptp_process_tx_tstamp()
>     slot not ready and not timed out -> continue
>   ice_misc_intr_thread_fn() (E810/E82x) or ice_ptp_ts_irq() (E830)
>     ice_ptp_tx_tstamps_pending(pf, true) -> true, slot is not stale
>     wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M)
>   ... repeats until the 2 second timeout frees the slot
> 

This ultimately depends on whether a given index actually gets stuck or
completes, which may depend on each device type. We don't really have a
good mechanism to rate limit how often the IRQ re-tries, (and at this
point I am heavily considering just trying to switch to a polling
implementation given how much trouble we've had with the IRQ to begin
with...)

> On E830 the re-arm happens in hardirq context in ice_ptp_ts_irq(). On E82x
> every pass does sideband PHY reads. Before this patch, the first pass after
> link down dropped every slot, so this loop could not happen.
> 
> A later patch in this series, "ice: don't clear in_use until HW clears
> ready bitmap", adds an ice_ptp_is_tx_tracker_up() check to the in_irq
> branch. Combined with the link_up check added here, that seems to close
> the loop.
> 
> Even after that patch, though, E810, E830 and E82x still don't get any
> stale marking on link down. So this commit isn't bisect-safe on its own,
> and the commit message describes a mechanism the code doesn't implement.
> 
> Should the commit message be corrected, or should the stale marking be
> added for the other MAC types?
> 

I can certainly try to reword the commit message...
