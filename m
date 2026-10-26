Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793050919;
	b=S2R6rhK86Q4KvVXbc8bRtH96njsTXE4U5V3rwbLaYQU2F1ZOenxVtacdqGCeHFbnvhAR
	 TCYwLiVSz2A8exNu7pJE7jTIxo9JM1P1DqFCQsnvDPPJgVeOl3J1nS18WFfT6b2pabPTr
	 vcr1G1GgbA4jKaARBXcmSW4Uw7BSGg5OGfoShN+0eMNiVm+QbbzkX/NhQAiGNEbW1JbUd
	 kvBJD43UjgIaari5u9805TAWvpbh0B0AJj2lK6F8MpiluBryQaHC/215Ofc5i6oh8ci2U
	 wBYtjvirgo3yqDMx1r/ssQi/wEv1yGE9CGSj1OszmxHR9puFpzizBKQTHyo50BY3kLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050919;
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
	bh=osxUZ4iUwA12QmRj/idJ+4yACkzNHNg6l7bAnvtazv8=;
	b=uCBTJjtZYi/NvTwsBBHeJmPGx+HqDZRT9XYtVryueVHVsM+fMV1GdkL8nXFSq6d7jpSQ
	 OdZIYPk/j7bHv8bCs27PfghGbeKDOFGL1aloku5Hn4dKVztU3leFfvCx+XjjBJDFOOTI+
	 2AS9UcMTXZJW1jj/zZpgk6z2XQUivMP2yRNhqkwHa1OhyiZfw1egOTYpErxJco9ZPd0x4
	 ribCeB+SjI/l+DW6MunSZk1mMjkeQxw+bS7COCuUJjWB29CLGHMee3Bzxci/HhF9YKiQ/
	 JFe/OR3IRHqLjIvJql3qtZsJu17xT3s878RT4pUxj3Vd4ldiGi9lm1BodTjLhVt1cUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BaJX5aMn;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9D606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BaJX5aMn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793050918; x=1824586918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tdk6CF+rqZPnrHZ3ndeKBFGke8jgNbX5Qm9VagfStF0=;
  b=BaJX5aMnDSoAOxUvcqfAAinVpLWp+MZXzvI/3sw4YRosEmP4aVFVMyMA
   dtbsbZGdFoNfWnYWt8/Ae4y6hcG2S1qT7NlsFbeCHY8ixycn61Kg6xvZq
   GGibm7AsrKKWrRaxjX2LfisR4yTdlLZjW9O6LaXF6kCT+n8bvg9onHCgd
   wP/fKVF0k7iQqsqChi1320QOz/6mI9Fgo79Ybuzsx4YfE4/lPQYl0SP/j
   nJGe1Q3BVhs0yHT538MNKveAWU40L58AeCyf1olXs4NPnWiSSbJVnUH1K
   MLgmPXdlUEens7MhShXuVWVVFDX4uXE8z+3E2BtpDITpLrIZ0I6+H4PEo
   A==;
X-CSE-ConnectionGUID: Ug1AZemFQZa+stInZQii8w==
X-CSE-MsgGUID: Jr2InfiiQKSMQjLaYRJJbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1738041"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1738041"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:41:58 -0700
X-CSE-ConnectionGUID: s5dsKVAdQcmgba5N53IcUA==
X-CSE-MsgGUID: 9EsGfExMRni3eEfe9baVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4329319"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:41:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:41:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:41:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkSoHiC5xKcXTDDK8HngGQ2kvi6Xzwmu9wXJGxHg0dQcAPbaDtiTohdic1eOMD2WRiVVIPpIBB0yJ5AfZRvVZxtJ1/gVLrUOlFBuHZ5/DfKWnVuVArUx3XUW9L7i9dMmgXKmqxqltsFW1j2pSiR52/l5qjRMgBhFZBRqQr1oRD7RkpiEfq4+8bjkw8duQlqnu34VLD1CPEoDXVjiw74IcgSfJWskZjm2yhZEsA74RcZRCAc4crfMDTJpa+aL+af0+N0oySJmkGOn5cgRb+VmtpU3wVub7f3TkFZE8fYO1LSuIOBFgU7BNt9lXY1UQJlY1a2cPiMBivGQ8/ummfbiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osxUZ4iUwA12QmRj/idJ+4yACkzNHNg6l7bAnvtazv8=;
 b=pwwRpWNRrDuIp5UhOSa95BzRaw3mV36saUv3kA4z9uOeFWFw7bLjpp3CGv5v6i85cNJaucb1tuRdOXNVYUP4DzmIJdY99XNM6SviFDyIXOMIeEX5UekTqY7ireLPhqIJ+nvhRTgNDg5rsaMqanyiyrBOKHs9D/N5S433PImaApedxI/sgWjznJZoaEPGSPL6xOlDVq2hSdWwDmiDG+EyLCGBIWmC7VKWbsqxrmW8TOT8t2g9KWL/w5h9nqAXsm19FHABJb6/BbDUan53gdNOXrdofxKGW7O22CybeLbTAjv6N94DoV+fpthbr1Yl2mSlhfR/02zw8kv/lcwH0uF5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:41:55 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:41:54 +0000
Message-ID: <fc0fc5af-9ee8-46be-b60c-e237dffda456@intel.com>
Date: Mon, 26 Oct 2026 14:41:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 08/13] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-8-72289a4ac8eb@intel.com>
 <179297184040.3134.16872406836500329599@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179297184040.3134.16872406836500329599@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3e528dce-4c8d-46bf-e316-08df33a9f3f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261009223027099003|261022105027099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: k706OhCEeYnVNn1Js7ZZW/ZB1XAPSBfxQK5miaUCTnKuzmZ7aIFqq/i3Pe8wVi1M9FQs9ZQFxaY+rl1ZIbrIkYGJl7aY/kuirsEvz11GuwaSTf9yz3dNOVD6Ivvq9IaZUsDGxF9Vh2sHKFZ/uwVR0Qiwl8OheYD//oFEisX5iKDFlQX5c088mOzIgeQzatIUfhASkoSNRuB66Gi144//JllfUgVb1earM4dp0zCwfXZZp2E4c/BRE9jB2QvXD8YYVCf2DwMOnDc6NXIvVmYTB1JPeKDCRPJu3ZPbKJl8LeAvA/W4C0oumuO5UM2NxkGeSnTPANqehCepO9Q8jq1hnZVynD65EQcdP8dZsLBzjlo8BGErqyIZkig1MemcWBnVtYyiM5DF4ieVgomTmEn/EfSnd3xGuX+Eno/TBbgodZUGo8SRSZQTdo7utkI692u3nNI92XkR833R3YQGN4ZH5djbkmm15oW45wANj7mf7Qf994+g0jMh01/zWY10Kb6W06gqf1jKlVYyRp07sjF9Cwgv9cb7ttfOISSdV4wNnIiRMwIqefM8/GGMUKjMqOdTeXLrNkt4F08C32QMbdD9SCn2Qz4BS84D5YhPFPHVFs92fad7ecUALT0d3DUFOgUC2bf1CMkpWjK3hpx2FfJWNOrtBtIA9VPYDRkn1k6u8bs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261009223027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXFrb2tTTU1WUWVpUDVQOUZjOUs3cVBlejdMa1NrZVBrYmc0cktXTG96OGhj?=
 =?utf-8?B?UjFUNWt3T0s4NzZ3VFZ0M0ltUFM3aWFvdlNDVWhzbjNlS0JGVlBicE02ZG84?=
 =?utf-8?B?ZWcyQmRCU0h4Nm81b1pyamxiclNiY1dlYmhyVG5UaVltV3BqNXk4dGthdWpT?=
 =?utf-8?B?RG4zWjZXZUhKa2ZIT0RXaElCQ3p3MnZCQ0RLalpyY1E1ZXBmT1JUS3pGTzNn?=
 =?utf-8?B?ZjZFb2Z1SS9La1A1UEludmdwQ243NElqaTVHNFVJMC9KWGNuRWlMSWRWMEZB?=
 =?utf-8?B?bU90clEvT1YzSzBDQTZIWXk1STk3MnlVUEhtSWFwdTJDZ0ZVS2hVUTZ3MTdB?=
 =?utf-8?B?RC80VXZRWFpUaDZUcjJhV1lyUmhnd2UzUFNJaHdyR0Z3dDlDR2ZkUU4vWXBD?=
 =?utf-8?B?WmJCMy9Ud2ttTzV4TGowZm9LUVhIR1JtRlhxUnM3WlVYeE9JeFBQL2hzWExZ?=
 =?utf-8?B?TDE5YkJ6N3hndStiS2ZETU13OUpIdVR2aXFjNjI0UTdnOWI2anpTcVJqNnhs?=
 =?utf-8?B?M2VUTHdWVS9BSTh1SEdWU2djWVdvbnNRZThwY1dHUnFGMzNVTzBMU0ZzcHEw?=
 =?utf-8?B?Tks3SEJNN1dtWUZpUjdFdUlmM0lxcVVZMlYxcEwwMVIrT0M2TitJRWdEeHNH?=
 =?utf-8?B?ZlFKWXJBVzhwaE5LMmJNNi80cEtQOXBJNXBCblp3MjdpOFZQMEhDc2dVd0xs?=
 =?utf-8?B?WEFQajVpSENlb1JnWmNEZk5WMHFHRGgydVhrc2h3bGQzcVlKbUU1L05MM05R?=
 =?utf-8?B?eDlDakhUR1IxTlh6cHU4NEtIQ2JJdU9DNVVXQnJlNE1PMXVLTHpmenNGTERy?=
 =?utf-8?B?aXdjVlZ2NEZqcXM0UTMzY0NHcnRRdndFMURGb21lOEdmRDMxY2RjdHdwc3dQ?=
 =?utf-8?B?Y0o4dGtLVzhOT0kzV3gyYWNldll0VTI1MkJuMk91ZVZlMStYTGdpMVU4MzF2?=
 =?utf-8?B?cUNWZkhtaUpabDE1dEFxZGRvVlRHYVVScXp4MFFySnM1T2VqM3JwKytTNWpO?=
 =?utf-8?B?cEVrN3h6aVdZOWZJRTJvb3JCa05hTEVrU2hPcTJydUJFd0gwK2VmTlZpQVUy?=
 =?utf-8?B?YTEwMDFmTlB3RmN0N3RYY0ZheGx1bVB3OUxTZ01kM0phSzdFdDhhUlVKNmNV?=
 =?utf-8?B?clNyRkJsMFFva1RpRnAya0tzWXlBQTJxSW9TZzBzdStaajNHSnIzTW5SVDBZ?=
 =?utf-8?B?WGpmWlBNNE51dGh0RE1KcnlIalJNaUZ1UmtXa2Y5VFI1aUF4UzJoQnEyTVNo?=
 =?utf-8?B?c0FvTi9Qbm42d2FrY1d6dDN3eC9qUW5JVk02aUJlSHcxbVpOSWQ5Ym1pbTJN?=
 =?utf-8?B?QmlFeWNsaXZ2RDBFcnhLam1Sd2Qwakczdzc3ak83Y29xU3BmMCtjdWErN1F0?=
 =?utf-8?B?UUI5VHpUVFFZWHZvQTlYS3gwZzh6RGV6TjFKUUxWYmRFa09NSzVNVTcyelVa?=
 =?utf-8?B?MlBZangzaDE3S1JTSGF5NWl2YzBYRTEwc3lPTjQwNTEzM1NYcmhadW1LZy9M?=
 =?utf-8?B?dFo0T1BEMU5YclVuQlE3aWJXdnY3YzE2MUN3WTZqWVFGM1ByM1c2dmlkelUx?=
 =?utf-8?B?NXJCK3pzT0hOWHdnK0JwekRLdXMyemsrU2VrSGdEUnJKaFVnS29EdXZYdlhZ?=
 =?utf-8?B?d3U2bUh5RndicGM0dWx2WnJUVnQ5cURQQVh3Q0hjYUFWYXB4NkllMVM3QVB6?=
 =?utf-8?B?MCsrYXRHRUlJaVVkODJacXdMRy9rZHJVSElKbVh3Y0hWZkkreThtaFVvS1Q4?=
 =?utf-8?B?MXRVUHlWNkNlOHk3Rlh4cVB0ZjhpaDZPSFIveE1nSmNoZ0Y2UEo1MnVpa3F0?=
 =?utf-8?B?MzVubmU2VzI5SWFib1pIaVhJY2libmliaFNzekNJR243b2tkKzkwaG5KL3dS?=
 =?utf-8?B?NmpBV05BcTV4UjVCRVpxU3dSMlNKM2dMNFZaZFp5SDdtZS9sRWszNTFUTXEx?=
 =?utf-8?B?VmtrRk9kNWhzSTR5UENhdGFmdzJFdUxGQkZXalVlUE84WG9YVFRJTldoV1FR?=
 =?utf-8?B?cFI4QUtoMjBvNHhibVlsYy9lT0g0alZ3QitHV25LR29PNHpyek9iOWR3TTdY?=
 =?utf-8?B?K1RPUmJEMEprclk1dlB1ejg5cFVrdk12TU42Z1podk91dlJpZi9KcTJVOXUv?=
 =?utf-8?B?blFmUlMzTExZZVNlZzIxdExIR1AwT2dLZWVjTXVyUklBeksvdTRPYTh5Q29D?=
 =?utf-8?B?ZWpPV0l2dzArVXo2YzJpd2FNU3JBMWUyR1RGRjdmb2krTXZPRkhmWEpoeUJF?=
 =?utf-8?B?WkJjOWJrV1RPWTd6bnJucVozR2cxMFprWVQ0Y2lSemlQRjdhaHVvMTVrYnox?=
 =?utf-8?B?bFdYWERPS1hsMWhDLy9lMHE0a3RGVUxjdzlZbm9kaGQwV2JvT0lpUT09?=
X-Exchange-RoutingPolicyChecked: F+nilo4kaHxFlVCO/qwlHzsvdbwkSmmeIHtOHVqWpY07CNGZEzO3PMjGBTWVChshvOc8R+DUGX5464QnxjCKrASID7/j7p64Asv4McfTiSpdfGzOnJgojiDfhQkhajyTGhG6rDXxoVBipweXCQsw7kACpxGB9bclQ2QTM55070ocELl72Co2nOVHx0i/CG9JVuFhr9x8tMTYL2G/edNnboED/OR6nO8HES/CEJHMiqwWjmU29hHYH+ja7rpXnnwKUW9zwEVxpVWp8j5/03ts3wUTjovBM1EaNtT3gVjiEQ00JM3bElqdgS8KXzEwVc+oDfck62JHccw+B3nom0VwUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e528dce-4c8d-46bf-e316-08df33a9f3f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:41:54.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX/JNe5qbSjurZC+HyAvG1D418Z/7vSKZFPpnqZJ4NNjZVntTo9gWEZksFOoP3kcjYYpji2PhPYg4zZjCDFJxFNjK4A39GHxYRkrDOnaRmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

On 10/25/2026 4:44 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message for "ice: E825: stop clearing
>   PHY_REG_TX_OFFSET_READY" names a Tx tracker field that does not exist.
> 
> --
> 
> ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
> 
> On E825, ice_stop_phy_timer_eth56g() no longer clears
> PHY_REG_TX_OFFSET_READY. Clearing it left the hardware's outstanding Tx
> timestamp counter out of sync. Instead, new Tx timestamp requests are
> blocked in software while the PHY is stopped or restarting, and
> ice_ptp_mark_tx_tracker_stale() now checks tx->init.
> 
>> Now that we do not clear the PHY_REG_TX_OFFSET_READY, new timestamp
>> requests could happen while the PHY is calibrating. To avoid this, set the
>> tx.calibrating field of the Tx timestamp tracker when stopping the timer
>> and clear it when finishing the restart.
> 
> [ ... ]
> 
>> Unlike E822 devices, set the calibrating flag when "stopping" the PHY and
>> clear it immediately after the start procedure.
> 
> [ ... ]
> 
>> In the event that the PHY timer start procedure fails, the device is in an
>> unknown state and timestamps will not behave properly. As such, and similar
>> to E822 devices, the calibrating field is not cleared on failure.
> 
> [Severity: Low]
> Should these references to tx.calibrating say tx.disabled instead?
> 
> struct ice_ptp_tx in ice_ptp.h has no calibrating member. Its bitfields
> are:
> 
> 	u8 init : 1;
> 	u8 disabled : 1;
> 	u8 has_ready_bitmap : 1;
> 
> The new E825 code in ice_ptp_port_phy_stop() and
> ice_ptp_port_phy_restart() sets and clears ptp_port->tx.disabled:
> 
> 	spin_lock_irqsave(&ptp_port->tx.lock, flags);
> 	ptp_port->tx.disabled = true;
> 	spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> 
> ice_ptp_wait_for_offsets() uses the same field for E82x, and the
> kernel-doc update in this patch is for @disabled.
> 
> The behaviour the commit message describes matches the code. Only the
> field name is wrong.
> 

Yes, these doc changes should have been fixed but I missed them while
renaming the field.
