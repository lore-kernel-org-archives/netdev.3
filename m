Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5323AEB35
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479106; cv=fail; b=nQ086LumzdxOJj6UcFQ9Hc92C6xLcyiOfladUiCqZmpCy2yQfE/50c9n4cpgVP+R/O85gFPEXKg75uMpzkzoQTJ5fCJH0TLTXWuKJNYDkOiktoOtV8QvdRq+oih2gyVFbeBaYHHbk/fw3OFqL+QNyOri3T8NsRQNFPlot7coexA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479106; c=relaxed/simple;
	bh=2khHLJyai72EksuM6MMhtd699ngH1Q5rC1v410Q7oDE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pYN9RAmxtZxop+gik/f+SWJce1WkKMScH13N/bQIHm9qdLyYM/7+Z1BMvkk9tixk696g8nOS2FJbjHY3B75rJWGcZepqOz2Lx2YCJjnli56M68fyZiggflvuegLNJK6nxHJb5HgUypyGmfU8XEK+g4yhAw28SKkcwp3V3+UYHYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9EXmsUj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9EXmsUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791479105; x=1823015105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2khHLJyai72EksuM6MMhtd699ngH1Q5rC1v410Q7oDE=;
  b=O9EXmsUjIbxFmSY6RmBFh+9KU6EtKd2hrOXHUqGogbgY+FylhveSOELU
   ydhP/HZ5cR3U+HoHkhFunybhfWti2iMZ7+8n/+m0pHFgviUGGVMJNw/6O
   VVHI+E6+y0RwTOYxIdIG//ldGeRS2S0qlHgIqkWmc9BiiM1tKP8Bccn2J
   KpBEINoeVBh8HakjjTGvrSyhioGUIww9MsP1KOJM79SUXN24Wx/p/XDUb
   gQa4fPzjIDcWka7z+oUD0+TwZ58BdT3d/NLDuxoBHsYp1SSv6WAcSku7X
   HIFezyY2yru7ELS3zUSFveD4NzQ5ZurmvuGMeHihyryvkLLOD92VRWNw6
   w==;
X-CSE-ConnectionGUID: lN5p9L/9S4WFKdzzUdtGDA==
X-CSE-MsgGUID: jYjcHvToQnOOOM92OAKzEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="163425"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="163425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:05:04 -0700
X-CSE-ConnectionGUID: sFhib1QaR56YbjLxNUtCHw==
X-CSE-MsgGUID: G7C9zvr0RGC6IA6xJSqsuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="183334"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:05:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:05:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 10:05:03 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 10:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikg1D1P0mRgAj6kvisVqdrvt3O+JKnrOS7KJd4ZDRbld3L5KPfDEnyMEN1uyhyKNWAF56r7nCr/qo3SmwPgumoa98jWowSDCS+65cs2b4vbLCcoPzrnapAm1uGKWUHlrhDS2PWHlZTJWLFb6P0+ND0qUmgY1abD1OKq1ZL0NzvB1wGDjGl3Xrx3wnhfAXbqC7dmTFPySqi7itAXFTTNFVKdVYHmZvjgAplcxafvI+OfULg+sOsQBA5q1nia4jwDgLJhCt7z3G/XKtvEo7ewGNhuJjPYXUBXWmDrHbsw3t03nLL9kDSa4Ko+4ji5dlMsRPyNI1ya376bXkz0Gde7zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sUAHIh2KFdae/urD8eeBHgIRX6UA7HJSEsY/4IQlEI=;
 b=e88+vySEu0MELX2aeDxJttGD2mcXjoTbngMcXGN+b4x2wRJmJvvb/ERBi55uW9zQvTLhDoOPCJtI3z06rEwhRr7Zy5B4s6D9mKEacWaaC0l1Gm/J1RgQBR1kXrzWt7JtOX4UY+6cvLcU+a2AXUFlDPXMpCAx31XCLQ8Q68XqWM/ICc68/3T6kg0GBZRO17+V0s22PY5oHf8Uc8TMKJGZcAuO0MeBw+OgbyrEIPyfuaVrdTmsHXJs/mofBnxWuAXRlq8qjdJEMHGtH5En3Og2uBLUg7FqZyqfGyr6JttqOtItRzMqVybEr5tKpqql1ATPxd/pA4vDIDvlGFsGOo6p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by CYYPR11MB8406.namprd11.prod.outlook.com (2603:10b6:930:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 17:04:59 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 17:04:59 +0000
Message-ID: <793c66e0-e672-4ca1-9757-069958f3084c@intel.com>
Date: Thu, 8 Oct 2026 10:04:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-10-01 (igc, igb, e1000e)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@kernel.org>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<florian.bezdeka@siemens.com>, <meng.ding@siemens.com>, <p@1g4.org>,
	<tkusters@aweta.nl>, <jiayuan.chen@linux.dev>, <pulehui@huawei.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
 <20261007190210.388650bf@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261007190210.388650bf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|CYYPR11MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a436b6-874a-4d2e-d6df-08df255e48e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sZ7yTetszqaAG+7sef0T9fpEYE5Otgqs3/UqYTPxRMSyKAuhpEEw6Kf0Z1COGC3+L9FdPtIzpO1O/A2Xb1ijqxIyW0+NN1FYrMmaMSdgCrCcxCXqAEU3MjiUiEpfk/gUg792VGCs/bqBHRgqI/x5IeN1dUmW5+8P7uTP2gyQIKrt+pXMvBB2566VvIVdkgmVzMNQGZYRJQZOyl0QpCc1VKIoH9icstUtkhlk2K3BkUnzC7esl4y9QmLI5vX3YZ2lhu4Fpr0IcU6xnzCYllmjVnh4YL3fsL9rnIYmPfty/j42Nlwzua47t2x7jeL4JvuHY9xYQ8EFxRDDlbjfVHUbF5nzy3md+lagGlkDktE5c6T/G9tNCglY4FtkhSVM0IwwL6Zg45pJbJorAGHZWhL4OhosH4dSVfxOer75Ez9qBPfguG+Gc4vS2TiHmMPGZF8mKx8QqgnF7Z2omakueRiGaSBkd4z1wmPMIZNYJIxCuoFJ1vd3GiJz2gNQqha8cWSObk28zdcldLONLx2F5TAqHXo2nbUrU57YRLG4DhPPRriMjm4dCFK4+3XWDpwE9sxkQsGTaPlmxgkvTaYP7MYZU68dTYB+eDrI3IwNsSKgbxLMi+TWBpkwRPxZzWcKAkUv0dXwUkrmUX29vCFanMyPELPhDCOBTj1YKYypq6H8OUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFlVDNUbm53cXdUZGVBeExpL0greUlyc29RVkRLV0laRkRKaUM5cy9OeFZn?=
 =?utf-8?B?QnZuWmRVQnNzYm9pQW1XdmhtY1p4Mk9vQmp2Qk15aktZRi9VNEtPLzdQaXVG?=
 =?utf-8?B?SnpHY1FyTTJOTUp4dUtyUVFWNEZXejhGMDUzN1lYdVI3QkZHZjVoc2Zvcm5H?=
 =?utf-8?B?QnRVdEJOcm1ub2NpcGVYTnVEN2ZUTVZvdG4yc1pUVk5lcENqQzBKdVByZFBK?=
 =?utf-8?B?c1I2dDlWNW5MN2FXYmEvS0tHSEZEbFptd2RFeFVVc05hTmxoODduNkxqLzkx?=
 =?utf-8?B?NmZWY0s3N1lHUkhxbnZxbUl2UzBjaFg0Q01QQyt5UmVwaENJcWJZMzFKV2tC?=
 =?utf-8?B?MDNteDdnL05wbWxFR3BldGdHczdpZFF1Q0hUdW5NQ01OamgwY2Y4Mi9tN2kw?=
 =?utf-8?B?OTN6dVJldHVRclVpUUY1Nm5nWStYZnlpL04zU3hUaFVJNUVHY1lBMFplYVhC?=
 =?utf-8?B?Vk5FYTNMMXJjNWZWenRnT3kvV2g2VTdyZmFIbERTZjg0WnRoVHZpbzlDLytj?=
 =?utf-8?B?aUpkVGRQTXE1WFVMRmM5amREdnBPakJmMnczb25XZmxFenNFdnR6dEZiMURD?=
 =?utf-8?B?amRBR2xZNlRXaENnb1RYREpyK0ZhK2ZUbjVCNHBybkc0MjB2OWFqVnp2THM5?=
 =?utf-8?B?U3g3QkVEMmVuaWpiTFQ4ZGFWSEhWdngvYTA1NmN6ZDdzSEduY09McU1Tc0gv?=
 =?utf-8?B?am9kVEtMVUkrbWFwT0lzeWpyOE52VDJwcGEwQVJpVmtuMyswNU81V0daaFlR?=
 =?utf-8?B?SWV2c0Jtcld3WUs5dDNsN3V0S3BPbkhqNTFtMURsbDNGSzdzanUvUlZKME9S?=
 =?utf-8?B?UERHak9KN2pYWFd2dThvV3U1R25uZGtlQ04yTFUxcXU2N3JqWmZhUlI4V04w?=
 =?utf-8?B?UFYvYWUzSXl3dVo5eTRvcVY3Ym1kOHl0UDJTaU5rbDNBWW5odDZwOGhlTHJ3?=
 =?utf-8?B?N3AweE1qdFdnNVNIdGM4Qk8wSFoyZTNWNzgrT1Z1bXVaaVdzVzVsYUtNNnpN?=
 =?utf-8?B?RFR4dHArREhMSGJsYzA0N3kweEp6LzV4bTZyam40RmdjeHVLd2Evb1dWNktP?=
 =?utf-8?B?em5WYldMNXp4ZUNHbTFpWFA0TkNPb1FTZUdQamJrUWhCVUVGUUVzRjZpZlJo?=
 =?utf-8?B?T3hhTk81bThHY0xXdzQ4S3JDRVpKNmRJdVU1WGZUdklwcUJwaVFmVjNKZldp?=
 =?utf-8?B?eDR0cmllNkNNRm9XM3luRHZ1Z3BFeUdDa3o0aWdYakVFQm9OR3FxTXMvRTk3?=
 =?utf-8?B?bVhEcHBvR09mMU9wc1NuRjR1bStkbU1WWXltZWhFeXg5elJpNk1IVE5nWGtk?=
 =?utf-8?B?ZWdxRWFIRWFmL3dSVkY5WlBZZ1RuUFIwbU5HT1ljWDRnQ3FsS0g0UlFuZi9u?=
 =?utf-8?B?TFBVQXNpbE1pQzg2Y2Zqenk5WlBFSzBkS2pxbVhqNGlaVTRSQXlEajFkeWxD?=
 =?utf-8?B?Qm9DOTRUVTR5eXNKMUdOMWdtcWJHRWFGRGVGYnJKS2ZGNFRSb3FBQlVzeVR4?=
 =?utf-8?B?Mk1jbUtXV2laT2JyNjY1SWxuM2QrZGZNM1BFUHdEWDRpTzZRSnhTb1Jxc0pa?=
 =?utf-8?B?NDdsTFpueFBDSHBaWkxueHhObS94UXlqcEdvWFFZY2orSnBQdUcvbjc0NDRv?=
 =?utf-8?B?bTV5RmR0WFV2N21UYjc4eTJ2bkkyWXp3VE5qcWxlV2wzbXRhejVNMjcxVlpl?=
 =?utf-8?B?WWIvaUtUUnVWOWJzRW1KMVBNaGM1SWxFMnQyRDZpSGFzWUdvNWVaYnRRZFVX?=
 =?utf-8?B?Q2FyWW80NEJqMzdNU3RjMU9zL0tlTlFOTkZLTWphaWJLYWc4VUM5cUMvdmUx?=
 =?utf-8?B?N2Y1WnNoekFmVmJUcU1wVm9YMXJPcXMwQ1pZODdVTFh4ZlZJcFdDWEdqSC9a?=
 =?utf-8?B?U3hMWFlLVGtaNnhiNzB5b21TMTArR1hBZHpha2VoY3ZzOG51N0pRdGRJcjRa?=
 =?utf-8?B?Wis2QVhIVEZnUUFFbm5HUUJ3cklmOTVBVCs1Z0RVUHpaM3JpV2swVWtOSm9T?=
 =?utf-8?B?d0RWcmZIV2FxVHQ0NGduWmFQZDA4VnNjc0tUTGZ4RVRadWdVc0xCQnYyYVBP?=
 =?utf-8?B?MnRSeExTZEFZRnhoM0tRSDNrdFJXVG40RTZ0a29WL3lGN2pOZFd5anVSZEFa?=
 =?utf-8?B?R1oxN1dzYzVLNTFjdHROUndPSU0rWWlvR1BCTjBrU1RtM1J2dy9jZVJHMmJq?=
 =?utf-8?B?VUxqclhoc0FrNGRydHViSWhXL1BUbk05YU11UklqVXJoeXNhbFFqajBvb1VB?=
 =?utf-8?B?K1RmVWQ2dTZDSTJBazBOZ0s2Y3VYWTg4QXp3cnA3Ri83SFpGWlBQNC93MnlT?=
 =?utf-8?B?SU90N21PNE95ZTVHbEdUcUlMODBDeS9hb2p4cWtVUy9pcytLWnF4Z085cW5S?=
 =?utf-8?Q?R//D9J84hvdScVyQ=3D?=
X-Exchange-RoutingPolicyChecked: xbhp1bmQkswdgyJojVMViSvIAz6Ra9fjOf3vSgVtiyKYN11Qh9VRVSV6JryWPhUQN7FaIb6+etUFDTEv89z8gC1XEQHUyDjbjlSScMQc60KbOUWDPBr/VrYwdbBatotXlP+FVIXPJJf4GTZxgNGtwUYzOLF4H1D+fUGYBhF9a1NjT3SIiquWkA+pE5Plpe+aJi+wlPcfl3J2X8HiCE9fT/L7gvcN0989FvfLOzwi+vw9bc7yA2Juu5rcUQi9v3MhDohO+isuksOsijAPP37QXDDDlfjOY2iDVoNDpLft565AS65pawDJ+AVD+Kq5oji7put9LhF1DCRDEnTKT6usTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a436b6-874a-4d2e-d6df-08df255e48e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:04:59.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41oJ4WpKSmja0fNayPUHGdLA7mhEvC2ZchgYCjw6Opj5tm7xtK9SAVfmeBLJS9ximzSHBnzJ3kRujeSiD1eo2cVKsYbMUmypcyBkBZ+9LUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8406
X-OriginatorOrg: intel.com



On 10/7/2026 7:02 PM, Jakub Kicinski wrote:
> On Thu,  1 Oct 2026 15:24:33 -0700 Tony Nguyen wrote:
>> For igc:
>> Ding Meng fixes Rx hardware timestamp when NET_RX_BUSY_POLL is disabled
>> by populating the skb hardware timestamp from the NIC's Rx timestamp.
>>
>> Paul Moses limits timestamp-header stripping to the first buffer of
>> each packet, preventing continuation-buffer data from being truncated.
>>
>> For igb:
>> Tjerk Kusters does the same limiting of timestamp-header stripping for
>> the igb driver.
> 
> these 3 need to be reworked
> 
>> For e1000e:
>> Jiayuan Chen prevents MSI-X IRQ leaks in IRQ error path.
>>
>> Pu Lehui prevents out-of-bounds MMIO access by rejecting devices whose
>> BAR0 is smaller than 64 KB.
> 
> applied to net-next
> 
>> Tony adds Lenovo ThinkPad P14s to disable list for K1 to avoid reported
>> issues with K1 re-enablement.
> 
> applied to net

Ok thanks Jakub.

- Tony
