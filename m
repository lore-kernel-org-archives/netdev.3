Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B5442B3B;
	Fri, 31 Jul 2026 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513439; cv=fail; b=mIihoew4SxDyQTcmZRIKjmRoKjtG8g6nRjTfAdHjxYtRiR82TPCddotQr8oKDef3Hc1jIIHFby1y5vIaeKtPE6pP4/+1jtPpIZN+UkZ96cj7ejL3qpgMZhsdrjtsPN+6j1XthFDVOZihUjNoi1Rf6DC6Q5K7o5psgTzr24bmzWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513439; c=relaxed/simple;
	bh=H5huBMFCUR0EfCHqCeSvg25hQE2/aKqqjmCkKiMocu0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OOJuNf0uj/lbzmD3QVTUGXmGKwNX0C2NLGUFdk+eVndSwMxyeXqnQJyiaH/aQeRNuJYtrcVpv6x2jptdbo35egh66mdjdehVd6w+Tftn2uM56rHQbLyXlfxDIP+zwPbCs4s6ydLjs+d6lMtTmL5m2+bpFkEwM/lPSzZCE1NsSuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4/p4yf5; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4/p4yf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785513438; x=1817049438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H5huBMFCUR0EfCHqCeSvg25hQE2/aKqqjmCkKiMocu0=;
  b=C4/p4yf5HbwubskP1DO1OQTd2RBZKdw3RPwt7tEk+UxoPhuanCrjNFgF
   WC8sRVcyli6/EINqi/UPVKQanfXaIGo0JTcAA1sILSyu1it1p5JfoPVV+
   JTKUyTlo4GqsfFGI3zYBSYNETcMV1CxKtUT6VUsK4R+WIDmaaeznDASOc
   radmBFYHe+GGDgLAOAHHYy/SuhXNmSWWd5azayPaZxu4g4TRJzvjKoL4G
   HLOEOc2ENynP2kHNMyT0TbcNqisErk6c1S35Ehu1z4a/bo5saI9Bskzbh
   Suy8KtE6CbnPm+f1mj72EK6H7ZNRWqHBllj+a5nrgSIA1ye/O0Zm/xt8m
   g==;
X-CSE-ConnectionGUID: Vtsi7TKaRTmYTuQV9tZ9bg==
X-CSE-MsgGUID: zxKIQ+6LSbu7pfp561ZwSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="108938067"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="108938067"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 08:57:17 -0700
X-CSE-ConnectionGUID: bKn1wvAVSEGRSj1j+N0nXQ==
X-CSE-MsgGUID: xnlQh51DRbWzVJP1FRuJ3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="260666252"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 08:57:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 08:57:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 08:57:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 08:57:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+4Se3QkLjc9jcqp00ZoX3YPYL1dfg4YEIe6ddZbMfEePjrNUnx1U+334musIs929euv0WlRgasc6pgIzj27jUbVWMzLAiOMXS0pzLTOvnWSMmdkq2Xhz6DwYFxnYMecNxEqIgc8JB1R/1coqteeqXgOZFSAvoHMGFLXhp8XEIqxD6P7qSCUvDcEEC4T3l6JHjdmiMl2+Svop6ouYQHFHm7SX8zSV8WzaX9UT67BWz4XiG7e4jKMH51dSzStgOgo4ps1WTyD5a1Tj4MZnd69coJLMwJ5PtIqOTK5YFz7r23Y4WmXjeFJbVXnyOupBD2SKwO42RPQ9cvxhtPoqI+IuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYErPsPi99Em6MMStaY4tbo1IK4bS1ID/rk0Cjcn8IM=;
 b=xPduCQJZEw/mBHz7JWiDQ+scFEUjeQJ8GDd+naU0BwDSR535jmUsgrta2m+9wlCeSpZiNvVmhaYQmCf89lDtRngOtztaKRZYE2JCKAlav4JJ2s+0FuA4O64023KlrzWc+hV2Hmdj7vQVSTfVNYCz2xK1TjbOrEm9umgqXozhUuHWq4P56dYXDrEJ9sI8yNdsv+1muc52Z4n2H3V1E31NEGK17bAErhjLuUnYplaTjsnrlso5D9KfHPufH89cWBHWhS7m8Un967wYVRRfr5RTkvmpT3qedrHs1SuG/TcFjfs9HMkFpLusqvzV6KtJXwkMcNRKCm9cwu5MeKHe089Qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 15:57:12 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:57:12 +0000
Message-ID: <b6efc438-20ae-4683-8e15-16845efa9aef@intel.com>
Date: Fri, 31 Jul 2026 08:57:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/15][pull request] Introduce iXD driver
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <larysa.zaremba@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
References: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DS0PR11MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb863fe-25af-4567-afe2-08deef1c620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|5023799004|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aynQq+AhQ5awBnWgUDWr2VP7FIVlPVmuwAuz1L5iMq+UQ3qiDOluu+4mlezwfkh9EpuRhIbEFyYlBa5PTFgq1rUPAyH3r0arvSxmDKXv3HDdFX6OKVzdMuf8ySy9o63P1ERmexmPha4LRnGxg+YyBWxmhSceD6vLR+8Esi5sTccaAgQlcSOyDzo1ga0i/cIM2Ip9uBY1igb9jvxyNKV4CJGgvsotAgxQ32YBoXpvEI8IM5BN+YN3JQWo5aPItSgp3CjYe2+5I3sjWqZqnA9UyTmGuR+ZmyZU5dPXlPwqIWqWPq4lCJXwuKG79MMJNVjRCNHcCz7wRY39HK4QiubQOsC7TilTcxIoRmpHQdkJYUD4G+CDlbTUSibGZWZsvyvRY5qPg08L05dzjTdO0Q18LKuhEbwmkifyGVAO50hdB2rLvZmreptvGBPiaHRJOeRPv0Wm3RLjExpjaIhRuhZZBtP5O6rYCZ0yuXA5BeO7RFOWsvPyLvvU7DqGabJ1BF8IJutOxM5PPrQ6+7HkLwtrzOCMScurcLnAOM0wQWwJvsWA3JRC4Z1OajhcMeTsEdACJY2YIJ5fF8QOmiXECCWjU4yITduiogu2PdTEGhBGPtDrTADlW0a87NA5/JaIMb0JWJ6FR6liiw1/0utIWyv10T73R9vW+tO8hCOsRi2elAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(5023799004)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnlOQXJ4YXdmUWNhVThUZHdWM1FzRFd0K2MvL0JBRFRpNjJJY01rMDFROVAv?=
 =?utf-8?B?ZkxmNTB0bm5vVDQ5ZGdFaW9ycHlMWTdrdS9hbTFYVzBwRlBMaW1UdmJwekpi?=
 =?utf-8?B?SjVQem1aY3haelZhRm4zanlQWk8zU05QODJYWHBsU0Q0bXRiM08vdWZpV2ZQ?=
 =?utf-8?B?Qkh6OS91K1ZWaG53TkpwNzhWVEh5K3o0d2pzQVVuWWRmWmFXNE0zeTczZ0dY?=
 =?utf-8?B?K09rbHUwUkd3TjRmdnllTzUxZlovb3EvbkV0RXc1a2R2YVovdGdrc0NoR0hM?=
 =?utf-8?B?ZEQ0RXF4eGdIbzBka3ZOQnNOOXNjcDlmUGxMWHNJSDkya0RqamVJeExUMFNh?=
 =?utf-8?B?R1BmT2JiQTViZjVQdTk2Sm80WEpuUktzNzM3UkxyZWdBWEdrWHVGeU5wMjJn?=
 =?utf-8?B?N2daREFneXZUS3J1VnIzbTRJb2dQdXRaRlRtaDdrN0dvY3hpb3dPK1g0Vjlv?=
 =?utf-8?B?RU5rT0Y4U1Z4REV0YjlES3dwVjZHdWMzaW5PV2hYY0NnOXNMWGJaak9YUXU5?=
 =?utf-8?B?Q2wyUldZbWxpWTdDV3F6RUpaTmpNdCtLcU13TVo3Qy9DVVpqdnhRTnB6WExO?=
 =?utf-8?B?NkhrWHNuckI2dVpZS2RzTEZYa3ZyaXJwWXJxcFZ5RW9uWWsvWmZWdWxVem1U?=
 =?utf-8?B?TzZQOFVmK1VRaUxEeEt2WWRSOFkvK2Z1a0E2K2NxdFg2TDRjVklkUThITFZz?=
 =?utf-8?B?NUtYVjF1TmhVWUwwd0pIdnVpc3g4R2QrQzhkUkRiMDhERUF4b1MrZEd0cVNH?=
 =?utf-8?B?RlBMUUNjNFBSKzh2M25ubi9hUUVTZE85Y1pja1l0UTNpZXd4UkRyZHRMQ3dL?=
 =?utf-8?B?azZrZjVZMmhGYkV5dXVkS1RoT2NMbmZ0enAraDVpUDhFQVRwRXpJMTdHbjZk?=
 =?utf-8?B?QTNoSFpyUG4reitnRUo2eUJhRFhSNlNGQ0NlUzVlZ01iaXRrZEFVKzRSWFY5?=
 =?utf-8?B?d0tUbzNKVWhGdDZoc2Uwb0VXb1BySjVyd0tySUFYZ3BLMG1USkF6bE1nSzVp?=
 =?utf-8?B?bHBVOWxiY3NwektDK2dLY1dmWFBCR1RtQm1FdlN5VW9kbVM0Qm4ybGYrUmdZ?=
 =?utf-8?B?YWcvb2Y5amQ2dEhveG1Ka0V1Nnl3NVI2dDBGVlk0MlFlWlhVcnJNaGVxRDJi?=
 =?utf-8?B?ZFg1OHVackVmS25UTld6cmJVZnIvU0tGY0xUWURZRUN2cXpOdHZqbkc3dXls?=
 =?utf-8?B?UHRtTUIrSWpZSGd3N25xL3lHQ0Q0V1FLYXdJYXFuYnJVNk9ZOXdIVUxBR0Nj?=
 =?utf-8?B?bElFeGxLeEZWa0ZkR3ZKVmdIbE41THErWEJFWER0L2RzSlNGQWUzN25MTFhS?=
 =?utf-8?B?bzMvbG9Xak1uNStIc3BkZnREelFJbmZNSUUrR2VyZ3daQ01vQWNYTmxSTVE3?=
 =?utf-8?B?TXZsaTZrTTBFc2tHY1dmblRmdTFnMG5iblYxeFU4Q0Z0WDg5TGcybjU0KzZC?=
 =?utf-8?B?VE1YRGd6c0EzbGIxQ0hZVXdoZkQ0TEh6bzFRcWpMTFk1Q3UwdjhKdVFta0w2?=
 =?utf-8?B?VndIL2xCMHRvYk1TdzV3ZDJaamg0UU5xOW94UWdkY1J2U0EvZGJneHpUM2Z1?=
 =?utf-8?B?TFVkS3E3NHpOWHJ2YTQwckdDZWVjbGJWRUVlQlRhWTJpS3NtQ2pIU0lROUd5?=
 =?utf-8?B?S1d4ODY3SzEwbDJ2eWRHaEFZQUxERE4xUFo3NHRIeldNd0RVakJUU1l2WGRB?=
 =?utf-8?B?ZGx4NlZtdTlSZmxRS2hxTkF0MS9DUGVKb1pRQTh6WlJWSHdqc2tpQ3JKQWFU?=
 =?utf-8?B?SGFiaTFMdkJuWUNKSmlacUllZ0hiODhBU2JlV05KRjNZOWROcjEvQjkzYng2?=
 =?utf-8?B?UjZDVnk4TzdRbG8rOEhyaXkzUUtXQ0cwenpBbEk5MmdHRTIzWHlNWmljWEt6?=
 =?utf-8?B?bXAzcGFZTm5qcGVkWE9ROVV0SDBiaDhhOUZFN3ZpemxIOGpVSnY0RndjQXJD?=
 =?utf-8?B?SENDd0F3MVcrZXNBbExhczBTYWFWMWZIL1FnQ0hNZWYwMWk5VlBycmRPaUtq?=
 =?utf-8?B?Z3JsTzROYXN6OEZhczJ0cTV2bmtwa2JWU3A0by82alVrYksrbzZHSjFLNjFU?=
 =?utf-8?B?aEk2NzR1akNhRVUwQUtNL0NJdFI3a05ERWhLbDRUOFNoMUFldUVnUW5rbVBR?=
 =?utf-8?B?My9PUWptZkRRN05aSndPaTh4RktzT0dnTG5BelNvWFY1V1o0N0s4Z1dLakgy?=
 =?utf-8?B?enJDZktQd0lyR3BHMGpUOWljaWR4V1BOQ1dOc3VsQ3orWGZjaG5RczFPYWNt?=
 =?utf-8?B?ZWNaSlAzYkZFSzFreDJ4NXhJbVB5RHEzYjdXOUp2dWI5WEpUc2VoN1A0Tm4r?=
 =?utf-8?B?SURDZTBKaDRDcmhUbXlEKzJDSnNqdVhTR3lBc2ZCNDVlV2Q2VGJXc2hQdFZ2?=
 =?utf-8?Q?tXnKG17pvkeLRiOc=3D?=
X-Exchange-RoutingPolicyChecked: VtcX6X7iakXCMrPAx5cQx3uW7K5KtTjuEidyBTuuxZW2TcL5HAF4nLdWjq6HggdLDYi/8v+apuuwCcQw4Pj7ixr621rRSfx3iIfJwsPClCDOBBD2h/bZlc+cDYnMRjGSWRnZynthTLM/0r53Xeg26ZixRmXB42FB/3+81tIpr+X87Q7BBFPln2qlrXbo+sh1AGLX7tiyf5Q2MlSclt4rFC7RcnOGKXiH4aLR1/6uiESQFin77ObG1dKxXiwa1E2qe8INqho82Q3Jy/F2VekopIwlYSFgMhR4A1Bjk2L5wfVS5PojgmbGbyctF/4QThhV07jTSrhlL6Pb90LqqqAnPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb863fe-25af-4567-afe2-08deef1c620c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:57:11.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzbBVh9EF0iXpCPdawL0CPt1mTNtOWo/pPqC2zg8FK4Oi2TdDQ3XWVpJgXSkiTtAD9NsNldokQmf7MT2fwc2l1zros4WLqrCoNtLxhNCAjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com



On 7/29/2026 1:44 PM, Tony Nguyen wrote:
> Larysa Zaremba says:
> 
> This patch series adds the iXD driver, which supports the Intel(R)
> Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> exposed by the same card. The reason for the separation is to be able
> to offload the control plane to the host different from where the data
> plane is running.
> 
> This is the first phase in the release of this driver where we implement the
> initialization of the core PCI driver. Subsequent phases will implement
> advanced features like usage of idpf ethernet aux device, link management,
> NVM update via devlink, switchdev port representors, data and exception path,
> flow rule programming, etc.

Sashiko reported a couple of issues that will need addressing and some 
reasonable low suggestions that we will incorporate so

pw-bot: changes-requested

Thanks,
Tony

> The first phase entails the following aspects:
> 
> 1. Additional libie functionalities:
> Patches 1-5 introduce additional common library API for drivers to
> communicate with the control plane through mailbox communication.
> A control queue is a hardware interface which is used by the driver
> to interact with other subsystems (like firmware). The library APIs
> allow the driver to setup and configure the control queues to send and
> receive virtchnl messages. The library has an internal bookkeeping
> (XN API) mechanism to keep track of the send messages. It supports both
> synchronous as well as asynchronous way of handling the messages. The
> library also handles the timeout internally for synchronous messages
> using events. This reduces the driver's overhead in handling the timeout
> error cases.
> 
> The current patch series supports only APIs that are needed for device
> initialization. These include APIs in the libie_pci module:
> * Allocating/freeing the DMA memory and mapping the MMIO regions for
>    BAR0, read/write APIs for drivers to access the MMIO memory
> 
> and libie_cp module:
> * Control queue initialization and configuration
> * Transport initialization for bookkeeping
> * Blocking and asynchronous mailbox transactions
> 
> Once the mailbox is initialized, the drivers can send and receive virtchnl
> messages to/from the control plane.
> 
> The modules above are not supposed to be linked with the main libie library,
> but do share the folder with it.
> 
> 2. idpf:
> Patches 6-11 refactor the idpf driver to use the libie APIs for control
> queue configuration, virtchnl transaction, device initialization
> and reset and adjust related code accordingly.
> 
> 3. ixd:
> Patches 12-15 add the ixd driver and implement multiple pieces of the
> initialization flow as follows:
> * Add the ability to load
> * A reset is issued to ensure a clean device state, followed by
>    initialization of the mailbox
> * Device capabilities:
>    As part of initialization, the driver has to determine what the device is
>    capable of (ex. max queues, vports, etc). This information is obtained from
>    the firmware and stored by the driver.
> * Enable initial support for the devlink interface


