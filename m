Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454213BBFBE;
	Thu,  8 Oct 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482366; cv=fail; b=m/dba+cUhDDNXotaG6fcrEAMdfjNLH42yPpjx9Z8blDz9mw1W3lB5FyT+QH/xoz7T/2GBBDMq5XpBeOFNPskCGDRnNREoYaSO3B7/EcOVW/YZuTuRRVo9bwNIKiOt7/V1A3R5U79Oow2d9/5YTABDAosZHXvpt2HpBEbu7+nPAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482366; c=relaxed/simple;
	bh=L6orN6J9oSdgLBW0GDw6Cv89TlEqGmUD1FN7dxuYlJI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsHRn4+G4nar6fv32g5TDdOT10tyYaYDFVjtT9KqShKOuVTfsdz//pVFtHCa+xFOn7kVOg7trsWiliJGJewJ/a3U2eOGUMUT8jSHJduCC4iqpQXxxfurJe0f8LwaTqTBzo/Hqb6EyOo6Zv0uvQubh0pepNMaKfQAqipCPBUY7qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRzD1de0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRzD1de0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791482365; x=1823018365;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L6orN6J9oSdgLBW0GDw6Cv89TlEqGmUD1FN7dxuYlJI=;
  b=NRzD1de0xErxVmmsE0QNNM4Rh4Izaeji86Ahny4F95oLCbYvexyOmraC
   vjDT/a3FpQ4ZwEhW9+A5eRfdQtl67iwUg8oygvz8u2mxboljphqLaeDKR
   R6MOdUalJHIMcAcRmIlCdxdN9jHJo+3eA4BkF8v52sRkqBeehqdsBGnoz
   i6R82AURV8fAIG0qMMWWPwUXwm3LjfwYJe+AEfknLPqb0MEf239bmPYUY
   cDYoOvp90DHAMJO3qPJ+C5WdJGnyYWf5kmE0iUuK3EAm8viCw/mmps5j/
   bYUoBTI7oTJmF8Efq66PBvS/1s7xjqwE2jz71vysWVSzLAWENE4+ZAMiW
   g==;
X-CSE-ConnectionGUID: ry6UGG5vSLijIsR/Wojafg==
X-CSE-MsgGUID: IJmYIrbFTQmy5XUVGyhxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="172664"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="172664"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:59:24 -0700
X-CSE-ConnectionGUID: SkM3dRgeTtuYPaeKCQgpRw==
X-CSE-MsgGUID: IP9lYO2BSOqwEEDaTKRn6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1865635"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:59:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:59:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 10:59:22 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1FYIzzwr+N8AFYrdzQrtIPeWntYrul/xwEaPGPeE4UD4sXIgj5LYfi133AN/dEDPveHxxuKJJulT8ZSoLk2J/tv9evcW1WCfjFbVa5e/gd1TPAinZYcbgnGKttJdLnqZG/yFKfHzfUQQ625RdF0RjnBRfqjUmAn/GxHgp6wJABfCCrh7XoP2qtyZ8gY9sGuhgA0zDQXo61Grj2Gbs9DjRWSwfvEkEgFDRjvMybq+exp4WBidtWazG2Eo4bgZXPQdJhFCglNr4VPDQ/jmQPF7rtt+2hnh8KtacmjECQe5GIBftmNldYR6u3wu19ObJGzn/9UgrJLOS64lJZ8ZB3Pfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dxQI2+aiqHPucjs28HFlSbFXEPyvMUGZOtTExEXhlo=;
 b=drk8cD1bEZwOmHWgP8WyMnXLK10Fu/93RBna9f0XYV16IupPizRtbSIsTeiuQsVIzzdbJ9zaaAyTKyUogluSrDe76IUb8k768AzpX8jF3lkRBZyuJA5JP49Gmt5VxcNv5OGFjpv2sX3oJzcuoKjbxJgrk7U60F2+3sO7EL8aK8QOzc5zyAshO81XXqgxW1GwOjV6OkD0zkD9IwdlXKFlDxilCzxAaq6GXk0+pFt3qhCoVIAQisHyZMvtuEBAyOAGUkx7b43wL/XUwKgd9fjrkidUz/vV658L9wf9KFYHB62pY5HW71bCGPgftnNHSW7iig7obMQlKNfNAVyc/PAgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by CHAPR11MB9653.namprd11.prod.outlook.com
 (2603:10b6:610:301::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 8 Oct
 2026 17:59:14 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 17:59:14 +0000
Message-ID: <666d51cb-e88a-4587-b17a-ae2a041844ef@intel.com>
Date: Thu, 8 Oct 2026 10:59:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net PATCH] idpf: wait for the reset completed state in
 idpf_check_reset_complete()
To: Brian Vazquez <brianvv@google.com>, Brian Vazquez
	<brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Madhu Chittim <madhu.chittim@intel.com>, Pavan Kumar Linga
	<pavan.kumar.linga@intel.com>, Joshua Hay <joshua.a.hay@intel.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, <linux-kernel@vger.kernel.org>, "David
 Decotigny" <decot@google.com>, Li Li <boolli@google.com>
References: <20261008173334.2881475-1-brianvv@google.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261008173334.2881475-1-brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|CHAPR11MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cf2af7-3360-401a-7b34-08df2565dcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|56012099006|11063799006|921020|18002099003|6133799003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: C07itlq3guF6hBTpX8x8fQcFcHuYS5/IbEHJ21ugqOxaXn7viuqovhyUz3DTQSdNISJgbmy1P5wPSxm1PAeogog/NvIy7eH79VNc2Hdc5TGWDgB0feyTRqpD3q4LNrs2UZ6qMqyDeeNIMWkQapoMYYRWNQQRDBRWSOzCjgUQWkLNoCZ/7iePYHBYrSDEo4z36efFRrG/ObYHZ3rPEVQywuKfse65EW60CcSGTfY69kz5LO96rrff5kdT/fvavJj+HeneMduIHiyQtOO35Swr/+7EwauNFkLRRKIeC2aVcMZT6L0L8rbN7D9lsgKhP/xER37OAcgtDpUhd6USrco6fOvo1PvxI/vZO/cI1+OcGUm3x3rBGTXiR1YzCDyh5tlwSP3NGhhgWolnZ4tlk2fbWuhZArzqBAx34h/ZCs752H263fFhFPi2ZxJAnxrrB+DRDXN6UZKcG4XQvuYp4L2il88NwUpftzWvi9SwbpS1ion2yfGPaUfEdwDqOOBQ5Kcl+1OqLKpXNiyiC+9wWlkLChagG+oi1gxLkc0j+Mg+DP1JkniBMwsgxTsZXFEMhO7rG8JOAbRmMYzMYb9LOdNcA+pg5aACx+9RWDfWgFcNyVNAgF07zRNMc/22nxC9OdJsTxd7xjPj4daLLzCKgPCdIo9lkyLyAw5AxkWQtXFzkB7aeYHIRdx+XljmVs2Yxs8BeOIrYW+2Pw60LiPQI3w5yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(56012099006)(11063799006)(921020)(18002099003)(6133799003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0krdUd6SFZVODZCRmY1bUovWFVvaEhQNTR3QTdMbVNrZFdlKzlRYlBkZ3NO?=
 =?utf-8?B?Qzc3N2NkMGcrMDgxcVpodnRtRzFDUGVFaGxPcFJrMXFCUXd2bUpBQmR3L0I3?=
 =?utf-8?B?eUhITWNhY2JTR2JVVk84WkowRXdKSUFLOXRKOHllYTVYWTlZVGlyL09DYTJo?=
 =?utf-8?B?ckQvS25jZ0lXNWhqMzNwNTNzam5jK1R6MDNCcVpnckpIT2U3UGlaNlRYeDUx?=
 =?utf-8?B?TEE0cGQ1NEpMaWhwNHJuTXZXbXMyUEVYUERtdFBBdThIUnR6MUNjZk10bnkx?=
 =?utf-8?B?Nk5NRFJKRmVZbEZkc1VzTVRHT2JWOTEzckhSOWlYcitJSStiMEFjQWRYcW5I?=
 =?utf-8?B?RmFROHYvNUlSbUtOSGltZkdTY2hyUjBiM3ZBa0JFMTByRzVLdG9UdldoNm9X?=
 =?utf-8?B?WGRCWk9aTCtudEZoNnlDM3UzN0pmVWprcXRxaHhqSjN6QTZGdGJkSEFOWEt5?=
 =?utf-8?B?MnZuNCtmYmJlVThnV0tObXJKRlYzSjdiTHVRd2g4cHVZcUc1aGlxcmp3UHFB?=
 =?utf-8?B?VFI2SndBc1JkUFRIcHh1YWVTV1dpeFI2bmNucDlqbGlqWVRwdk8xT0ozQW9y?=
 =?utf-8?B?eWFlV0sveVlremFSOFBYWi8wNTJXc05TQjd6UU9UOUpRYUtpakxFNndJU0U2?=
 =?utf-8?B?N1pOc082OEwvRy9CZ3d3dXg5NkdtRzRZdnRFNXBtcFZpa1BCUEF2WmtvY3pU?=
 =?utf-8?B?TzU2N2FGVmwzOWlOOVh4ZTAzeXIvTmdjZkxXOXFTQVVTamRsRFRmSnJoQ3ZS?=
 =?utf-8?B?TDMzZVJZQ0dqZjJwU0VlZTRPZzlMSmx6dmI4R2FSaFZqTzdSYkhLL1Fmalhm?=
 =?utf-8?B?cFRaVGJicFJ0bHBQVEVJM1Y3NW1BakU2Y1RlWmpRT2dFOFU4TFAvdWVFODFk?=
 =?utf-8?B?UnhCbkdMQjg5cUV6cVdZa21YTFc2aE9WTFFPQnNXU3NkVlNZV2daN0hSMnBq?=
 =?utf-8?B?ZFp1YlNML25zVU9ZVGxYei9KRE9NSzZqYzdqVzNTcW5qWis5V01IZ3gyRjI5?=
 =?utf-8?B?M0tkSEg0VlJvVmJjVE9LV2pLZnFTNG5pV3I5VldaNVpoYXhieXJINGttVFRt?=
 =?utf-8?B?aGZyblRYN3h5UmxDakttak1aNXJlT0l6UG84ODc0Mk13Vlgvd2pObXdCRzl2?=
 =?utf-8?B?VWVqK2EwWnRUcTMzQWloekM5ZUFSNjhDOTFYdnAySzN2Z1ZlWDdVY084TWQ3?=
 =?utf-8?B?MHFRK0Y4WWlqRlJ6bzBNOXhibmdsM3FHSUNzdmpKZGNOU0V1TE9oL1NGNXVJ?=
 =?utf-8?B?SXdSN0dBaU1VYm1hU1hNaVp5ZEJXUmpOZzZwc01MSTl0SE1TREV5WkxBTU5r?=
 =?utf-8?B?RjFBVUp4OGUrS2lsZFpqRlR2ZnR4bTNTM2Iwam5HalJhS1RzSVJyYkZwaStm?=
 =?utf-8?B?bHJpcENsbjVrbzRXMXR6TjIySEh5bW1xQnF6Znlvb21tTTVpQ2x1bkZFUGdl?=
 =?utf-8?B?QzJxU1BLNytxVlBucHREWkNzOTJaMzNKcHhzN05qcWY3V3lyN2p3aGR6WTlz?=
 =?utf-8?B?N2p1WCtBRWdGbUVmb1ZxbDRiTXVWUE95NzdmY3IwdWgxTGZIZUlVWXladllL?=
 =?utf-8?B?Qjg3SjNkd1N1UFNMUlFCV1M1YzZpTURlTTludDNxVThEc1oxZHBVOHRrVFhF?=
 =?utf-8?B?RG11UmlxQ2ZZNit4OFhBRHBtc3puZjZkYWQzV1B1MWI3V2d0Qnl2ODlvcEhn?=
 =?utf-8?B?cTZibTlxUjczUWV4cnlpOU1CRmF6OWlrb2NDTzljN2lPRTlNNWZiYmpxVE1P?=
 =?utf-8?B?YjFuNGszZktpcHl0cFBXcithaE92emNZeHV3YWhldDdyUFNUK0hOVzJuZmpt?=
 =?utf-8?B?UGpoODhTd3Q2dkh5Rzg4czlpeWZYcXJkbHZnMWxDTHBNdFQwMlhOZmlMUUdp?=
 =?utf-8?B?UURhako1VGJpZmFJdzIwTnErUnR4bUtuSENKcEZUVk10MFpaWmdHS004RWI4?=
 =?utf-8?B?Q1dPdXJYdm9pNy9xWTFpaUNUTzIzWUgremZkaHVmMXpmTGpQR2psT092YmpE?=
 =?utf-8?B?Q0hFSGpSaDZvYnRabFZNN0Q2ZUNCTVdPTkluaDVxU2dob3JTTDNYbDU2SGo0?=
 =?utf-8?B?YmZqU3kzRmczZmFOUDBPREUyRXR1VlptdDVERnVJUEhBZk1Ud1pTTkNFQjZD?=
 =?utf-8?B?Z0NueXlsbzdyTDE2WGg0b2VIa2RnZ0FUZWlSTEVOQmNBUTlYeW0zUG9NMW1Q?=
 =?utf-8?B?RW5PY1FEbGkydTV1YTVIMVFGd3BBOU5VMlBYZ21VOVlickVrQ20rd3pmMzQ0?=
 =?utf-8?B?K0l0c1BiaWVBSEgzRXFqbDcxZENQRjBhL2xkWUtQbXVpUWk2Nm9PSjkzSXE0?=
 =?utf-8?B?aCtQNnJoNVdwTzJiZ1NORWlPSVNtZ2N3Y2lEZnJWazdLUU1tZlJVTmpkRERl?=
 =?utf-8?Q?QBg5RW12OEuoN8Go=3D?=
X-Exchange-RoutingPolicyChecked: OK6Q7fzKYNRuIf8mp4tCc/pXjJ+ZCC3x/tVoSreD3sS8lFaoCx31rkztqbP21Akxp+5D23HCNeO9kqbWvMHphNlLVael4B31hEp4NOvDYW6+D2I9pCI4go8dL9660e5CGkU3uUcks80vnfeFeUqgendetO9b88hU/PiXhjMUeURLtg3jwh4D38m23MJkNlfoYNIHM8YJlS+xqaFd7f+03wrffa9hTEYG/pBRZ6AemUJ7d9B8ak/GGs3xZV6IlAIv8Cl2kHpAIWP09fzBb5Kt8m/RMZ6dAGbeUiMDcW9HfgDw+OoHERhz9cFGvL41Eq/IQGRiwIPNJYTs2fF6zA4aow==
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cf2af7-3360-401a-7b34-08df2565dcf3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:59:14.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdoV9z67ON7VfRqMNZDq1r/eT23wRiO9Vs/0lWAP0HdXtIClEmAhPfx1Vug1Uu5EjK+d1L2b+7jJUpp2wO/h3OzvF5RTLygT/TlaRLskCQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9653
X-OriginatorOrg: intel.com



On 10/8/2026 10:33 AM, Brian Vazquez wrote:
> PFGEN_RSTAT[1:0] / VFGEN_RSTAT[1:0] (PFR_STATE / VFR_STATE) encode the
> function reset progress as a 2-bit state, not a flag:
> 
>    00b - reset in progress
>    01b - reset completed, written by the control plane
>    10b - function active, written by the control plane once the function
>          has completed VIRTCHNL2_OP_VERSION
>    11b - reserved
> 
> idpf_check_reset_complete() tests (reg_val & rstat_m) as a boolean, with
> rstat_m = GENMASK(1, 0), so any non-zero state is taken as "completed",
> although only 01b carries that meaning.
> 
> That only works if hardware moves the field to 00b as soon as the reset
> is triggered. On the devices tested it does not: PFSWR transitions
> PFR_STATE to 00b only when the field currently reads 01b. When the
> function is active (10b) the field keeps its value until the control
> plane finishes the reset and writes 01b, which takes a few hundred
> milliseconds.
> 
> Consequently, on a hard reset of an active function
> (IDPF_HR_FUNC_RESET) the first poll sees 10b, returns immediately, the
> driver re-creates the mailbox and sends VIRTCHNL2_OP_VERSION while the
> reset is still being processed. The control plane tears the mailbox
> down underneath it, VERSION is never answered, and the driver sits in a
> 60 second virtchnl timeout (-ETIME) before going through a second hard
> reset which then succeeds.
> 
> Make idpf_check_reset_complete() wait for the state to be exactly 01b.
> This is the stricter reading of the register definition and it does not
> depend on how the field got to its current value: functions that are
> still in progress (00b) or active (10b) keep polling until the control
> plane reports completion.
> 
> Fixes: 8077c727561a ("idpf: add controlq init and reset checks")
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h     | 2 ++
>   drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 470bc23c844c..ce8a1bd0ec8b 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -166,6 +166,8 @@ struct idpf_netdev_priv {
>   	spinlock_t stats_lock;
>   };
>   
> +#define IDPF_RSTAT_COMPLETE		0x01
> +
>   /**
>    * struct idpf_reset_reg - Reset register offsets/masks
>    * @rstat: Reset status register
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2c148377540c..a827e0fa67c8 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1870,7 +1870,8 @@ static int idpf_check_reset_complete(struct idpf_adapter *adapter,
>   		 * register for us yet and 0xFFFFFFFF is not a valid value for
>   		 * the register, so treat that as invalid.
>   		 */
> -		if (reg_val != 0xFFFFFFFF && (reg_val & reset_reg->rstat_m))
> +		if (reg_val != 0xFFFFFFFF &&
> +		    (reg_val & reset_reg->rstat_m) == IDPF_RSTAT_COMPLETE)
>   			return 0;
>   
>   		usleep_range(5000, 10000)

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

