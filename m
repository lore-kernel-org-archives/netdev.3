Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793049616;
	b=tKWb6aIMBK8RvfnCw9721rLfW6xM7FuKIHvx02ntdyXWT+xn8XLa1cNqPwLixF/xqT+y
	 jQfrTUJU4kVxdQCYUePCxp+MIHFl7UbtLcIfCu3IxetHISWXQy16p7L3zAkGPTtbly86O
	 80GxzbhHqr552GKPo/m1XvWHQ94sMp90PNw3oD6ZAYOrH8EuLCX+QSz0yauXO1uTmzrUl
	 mhMMPR2t2GcsnRQsdwUDFzo3qvS8VWk4v2BmF0QtIkSg/+RLfgc3Ec60s1BqhTDlE6DUf
	 DsAAqiX+xn72t2s4it4eiC1iHUDFU4rckZRhXZeojJa9VTZ7EWML+jBQojrwC3lzVNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049616;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=c7zkZZXF/FfDEkKdeODiljhRkQK36oD534qWmNHFQ4M=;
	b=ja6zGDG0H2BCnX6NCQUCRPAieT+K8m5hOx58X/q34rNI0A5/gIyl/ryQr6+COSLHQ2UJ
	 5pCS2FpQ0DoIlH69OSuWeFWlT03Ju03pHNCYy+86hvJ9Z3fV7F0miECh8jhih5I+ZfZyY
	 6TtZ869wxnVYx4iFq4VgffpvxOocgmLhfUbtevfMgS/kkruk4DB8SxMUcV9NvV2EQzPui
	 EHzbms3vrY44z5Z7QNvA0W0lmgEXmv/NVsLIm86VEfsIGH9Xi2T3vnxx3cQLm9z0qTrGD
	 HjfDYc5nIXBPycnfqpulZ8XqSkdwcI3LcTpNtya7ziZMe0VBZ1W7Uf3zhUTg4BKht6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzLkjgCR;
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D269606A31A;
	Mon, 26 Oct 2026 21:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D269606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzLkjgCR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793049616; x=1824585616;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RCqCOYCZcwvaiRq4KrboLO0LNchvJgvK6i4c7hgaGo0=;
  b=hzLkjgCRERIZEXSdkqvk4iCQlXtp0eOqFt5Pf6U1TLZdhTeauIP5eXS/
   c3D/qg726pfeTCSW73b975t/l9M+/leeTvDOCh4zP+EDKDMo7pipPkhk3
   QnJQ8Saag0bHj8Eq0j1OhcAB7+TS3V68dE2G/WrhhYqqT3uWfk1whBt7W
   CkBE9DEz8z+BfY0o2+hzyo21TTmvqWS6acQZEzJHF7jyLwbKcr3lFrunh
   LiNyWa4OMVD9XhpV+ML32uYTpVCNeaTOdnp614AL8i1dhm4c3D678r3sC
   eQBWF5Ast+JqoLK5eECraTMPpxE0BJ3oB32Qh/EFIMbnn1+5I/X4iIQUN
   Q==;
X-CSE-ConnectionGUID: VOnjW1W+R5OaM0C8g7gE1w==
X-CSE-MsgGUID: ocT7rHBFRGKlMYmD/u85uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1616736"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1616736"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:20:15 -0700
X-CSE-ConnectionGUID: LiO+Ez93TeWjVStxECVqBQ==
X-CSE-MsgGUID: WqAmtwH5RZuSF49sdUPgQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4317683"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:20:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:20:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:20:14 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhxhtQ4e3CDu10JK+MKveHh7QMzwJywhVycaR/TVkoZaWpwT0Upp6G7l0uk2jQgg8HHYOwZlIkwSYOU6So1ysFQleHl5FXOS5TqzReiSPTHwkmnspvzvN7JtjYlNiVa4qt7Nf/JhJRdEyiWMP0FPNJdk5MMq3F9Qusws+PTylnThGRIYipeywOOQn6aEm7kc/+quSEDGs/AU1xpbbRS545qJwPpTKa7CEpT9jqsp++mBEWM4SS9sxqjYOEx8tQbr76grTm1nARoe+wpY4lohQck0dQPboTeM0fLdIuH+86AgT1ZM2+fKFDvdCPUpnp9Z9/Bt1ayHZ8sFeNDpMD9pXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7zkZZXF/FfDEkKdeODiljhRkQK36oD534qWmNHFQ4M=;
 b=f0z++a9WjV8uaQhyecWKNJ9qqmO4ot3EeoUWPEs0i4T5jUAvOWf+l6O8/01+IH9xkHUEcr099O+qDD2oI36IrgsR0+v5eu6i9yUeVMNhl0Skvly4q6l+nVBz3ve/+advtpTV280/3g/znzvSeY5r7KEYbzr/C37raHiz4PvGBFiVj0jyMoSxht7wwNj1G+6FA6MAtApVn+N7roObJw9wktJ8ytp+wZIbWe4mk6rQ7ZsBM1zwdrzLZBT03YbXLmwGNBiy+CVm3NhxoIBLq0gm1tHks+vLSGg8sOSW+MxeYD9UNMJfky/a1XfTx93Ibb8+2hli814Dk7Y0v88uxINk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:20:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:20:12 +0000
Message-ID: <8bae4150-4c4a-408d-93a4-ba3208680f10@intel.com>
Date: Mon, 26 Oct 2026 14:20:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] devlink: region trigger leaks a permanent snapshot id slot
 on every successful auto-id capture
To: Fernando Fernandez Mancera <fmancera@suse.de>, Guikun Yang
	<yangguikun19@qq.com>, Jiri Pirko <jiri@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <tencent_BE912BA710539F285F9FCF28E854ABEFCD07@qq.com>
 <b24c7e91-7fba-428f-b76b-ba19b07ad1d1@suse.de>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <b24c7e91-7fba-428f-b76b-ba19b07ad1d1@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:303:b5::33) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: b04dd715-7694-4622-24c4-08df33a6ebb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|261026140227099003|6133799003|22082099003|18002099003|261026121527099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Zs8KpWNyDNItK/rwJ2Kz4q2N9ZALs7Ilo8ewZip3m890HUFJePSI7ygA6Xw3OFXn6jL5lRNo39bJt3cZLa9JvvSPHOs/tSA+aec4gttehzwDswKV6h9YNN/sjdXgox9b8tfmQ2JAb99gA15WU+KVhyj5I097Cy2mxcreiQ2HXKUr6DLTurQ/uzucpNdg21OOxrO7e9mVSdpH3ld4LwwwzhnDj0ymf4kJ/+/YT94WFAm6A9D3gV2gg8aZCQ4bdJa5zaIiM4WGhAI0K27lB5RuHiZNfOuw1EFXEKodTQ5K6cvwDoi7G05cEQ57+H8BHPQNVwkD6b2ISrzv0SI2jVYnuX4+37LKPqoGzj2FywOoL+iisGMk3lzXLC524VOZRufAozjZaW9EUW9ZtsTs2bviBYt+e8ZG2lIdVU24VoSOZGjBo2dG1mzhgn3oGrxoHQaGXe/u+So5kZ0smckMYf9T4d7MpWOreCXDYCCnG3bpir0le2YMG0R4ZU+r/MpG0GzD2kAMjNgwpK3WasSkY3RTDbwAgNV2Yj9hM/gwHNwQ/ZZYQMiMyTTPv5/EI3iA0ZRvBfzgG9tNjJc0Rhi1Uwtys+wKE9EOam7BEmt7jklebMcnsaPcsA1Q4onfLKPS9VlHjBNBFqPbzqhvhNGYBcSuiYMO4+mljsmQvflOy5XUJic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(22082099003)(18002099003)(261026121527099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JuclQrYU9VekZUb1ltNWRyM0lsMFlnVjh2dFRINVFOVlJneFoyMkIvUThD?=
 =?utf-8?B?RzR0S01vcnRUUFR2MHpjMEFNRHVOZEJxYU5zRDAzY1NGRTR3V05PQnBUYjdx?=
 =?utf-8?B?ZzhnS3dlOHR3SlI3KzYzVEcxMXlzMlQ0WE1pTmVhNThxUFgrSHNNWDBieTk0?=
 =?utf-8?B?VXE0T0ZYMGh3SmVYWFIvZVdhOVdkWmFObUgxQjU5VVZQb3IzekFtb2RBaFhW?=
 =?utf-8?B?UlF5UmtqMnR3SDRkb2FWL1ZxSTNyYXpsZmEvMDJxdlYvbUlzSG8ydzV4Ylpl?=
 =?utf-8?B?ZkxTUzNlSCtQeVpQa1RWL0psN051SSszYzZZR3JXTkhqWjF4RFdXSDQwT3Zy?=
 =?utf-8?B?V2lmZVNHQ1I3L0RhZXpaWWdybHdVUUQxQklEM25ONDZEVVpnNkdXUnR4OXdv?=
 =?utf-8?B?aC8yd0RwKzBpclpMUzI5VEowUUEzUGNoUENDZWpvVjBkc3ZqRlZPczJYYjZu?=
 =?utf-8?B?MEYrM25kR2pENFFvWlpSMlJEUHZIQ01xd0ozVWU1NnhPNGw0aHNTaXJCWFZC?=
 =?utf-8?B?UFNHWk1KanFUbEhVT3hQV09OR0VhOURCMGc0U0Y3cE50ZmczYlE5ZEtUUU9z?=
 =?utf-8?B?elB2dFRKeFJheS9wVVlkdHFqaWdTc0hlRTFWU0kzTmF6VEViMnF4bnNmbk9K?=
 =?utf-8?B?dndwL3A4azVBdkxDUzZ2Mk1uNHhUSEFPeGkxNjdnaGpDT2ZnMlpJb0RYelg3?=
 =?utf-8?B?ckNDZjRYeEdFb1UvVzl2Z2IvTXFRVm1kOUR2SEUrN01FYmJYQWRudGl0VnlL?=
 =?utf-8?B?UjNCbiszRjFrTFpVRlh6N3diSmFuQ2RSV0ZIZk50djR0WUFsVm9KUG9LWWM0?=
 =?utf-8?B?MzhzY0Q3VjU0c2E4WEgveU9SYmNUNFBBOFh1c2xKMU1SNHppck83Ly8vY0dO?=
 =?utf-8?B?aEZGLzlTbTRRK3R6MVBXVGExbXlXNG5pVWdWWjlRNWFZZS80c0dmcitxMUtH?=
 =?utf-8?B?bWYxSHRIakp5R1JtaUhsaDR5Y2thSTd4NFJ1ekorRnZCTFNUM3hOemFXWWFi?=
 =?utf-8?B?WFhjTi9mM2RheW5BbkxsZ1hmWm53YTJMOVV6dWw2TksrRnVaZ2hKcjZEMGxJ?=
 =?utf-8?B?UDc1NFYvdGk4K01FMGN0V3RqaDh0cVA5dXpuKytLcjVPdHZEYlVtTG5kaVNa?=
 =?utf-8?B?eEZrSnVkU204bGtaMWRmTWNzNEFFbmhodFR3TFRhS2tpcXc1d1ZHbmdPeWpD?=
 =?utf-8?B?Z096YWF5WEFYU1VuU3lUOEkzbVVIR0s3M2tkUURTcVpYSWFqSER4R2VhVy84?=
 =?utf-8?B?NUJ3S1dVMVhTMW01UzdYb2pSVkN2Rld3dnlPU3NkSVQyOTdLSXc5dkJOVDBv?=
 =?utf-8?B?NGFkUTM1SEVZbTBaU0c0Mk0rVm4vOXMrb0tCdm50Z2x0bVhJbldPb09qZytD?=
 =?utf-8?B?YjdNdHRwNFhXUkJwUjA1T20zZVYvMW96WHFhUVFVLys5L1VkUFVkcm1PN0V0?=
 =?utf-8?B?cEtiTDk3SFBnOEN0SDRnQkpjYms5SE1qQ0xKRjNkQ2VuR1k2RUZtOW9qVnBX?=
 =?utf-8?B?MUtMd21UcEtrYkRIRGVyN1pXUUZLZTZCR3BzSzlkdzNxU2N6Z2QxUnA1Vyta?=
 =?utf-8?B?TnpXMTBRYWpaVERYd3pEUFBrL0ZNYyttTG5uOC8xdXkwL2ZUVzFBS0Z2d0x4?=
 =?utf-8?B?TUdSMkI2RHN4QUdxRmpZNTl4WXJEcUZRaUZiVE1zOFBvUTljaGs5Q2NCMHNW?=
 =?utf-8?B?SWtRRWFTSEJ2RnNFWDU5aGpNSTQvUzRBdnBlZW4vU25RMFpvaEs5UE8ybWpJ?=
 =?utf-8?B?MHJQbWtrMUM4ZWZsTWVnbUFOQzRNTWdONGRCd2c5Y0hYd1dlNkpoWVBVNS9m?=
 =?utf-8?B?eS9LMVE1ZHo5UCtTMlFFb2NCVHNoT3E0dUtDY1BlbnBpaHp5ZVN2ai9UdzNW?=
 =?utf-8?B?L3AySHhGbk0vbVl3V2RGTkFPTk5Ha3RjTkJENmJWeUNSRENHWmVMSDd2UDJ6?=
 =?utf-8?B?ZFE2M2svUnhRcWFqU0hzVEQ5c1h3VWhJSEZ3ZHhQSk1YWFZOZlRTaFgzc3Ni?=
 =?utf-8?B?N1VKeGJmQlg4c3BNa01ZSlg2bHhhY0p2STE1bUViNWE1S2dPcmxEZHVVcjht?=
 =?utf-8?B?dXEzNWdzbWhGeVFaUGl4eS8wZUxQdVlBdllsbURmU0lWWlBzNzlFWGlBNHlD?=
 =?utf-8?B?dXN6dm1pYVREK0FwWjZLUXF6YTBhRDU0Y0hrV3luQ1VRMzhXY2xyVU8yeC9o?=
 =?utf-8?B?MitzNXVBQTVwcE04MDRHcTFseWFPOTZZclhPRGZZZWZ0ZU1mM1VESFZRUEJD?=
 =?utf-8?B?VjBnZGQyNU1uOEUra09HdTkvb0hhR2VrZnR1ZnE1c09CTTZWd2hnamk2YVNw?=
 =?utf-8?B?SCtPTm1ESHNPZEpMaWNEKzhGWEUvM0M2OHJrQ25vVUszcVNHRkVKUT09?=
X-Exchange-RoutingPolicyChecked: vslrw6yg5FbpVIZ6lqnZwqE2mpsgdnWA0nJEEOVKBge0tYWsY+BVUVHi80kZK7O/dx4eCrfXmzgUjyT6RXYw99qxVpqEWs5Bs7Em03h/TLTXrg2YCuLXqvXLQhVgVouh6oFxnglgQochuFzbk4hURx+Be0jkxm5AZHPzwyDc/VDlHAWa2c2oft0r4BFxtm0IV1BQPboiI3Wftfet9MInez3xcHWtMoC3fJIKlzvgtkC6TnvcGOlP1SSvwPnblK23/jL2fRzGcb4jjafrscofwIpqM0pwvE29gyfpGoX+4h8oBuDQ+Rt0BoS+qqKyP069mHmPsu6oR3hlTM4fALH9gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b04dd715-7694-4622-24c4-08df33a6ebb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:20:12.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j+aOeMykFnLpwjcPB2LyYeP7Axt0yYrr7rADE5hpXk8g7hi5MF5LLeE+xVNc4MFtZCUf1lMcUOjz9zg21l7PK9mdJsCQd7eGUq9iy1r2ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com

On 10/26/2026 9:29 AM, Fernando Fernandez Mancera wrote:
> On 10/25/26 5:27 AM, Guikun Yang wrote:
>> Hi Jiri, Jacob,
>>
>> devlink_nl_cmd_region_trigger() (net/devlink/region.c) allocates a
>> snapshot id via __devlink_region_snapshot_id_get() when the request
>> does not carry DEVLINK_ATTR_REGION_SNAPSHOT_ID, then creates the
>> snapshot.  On the success path it returns without ever releasing the
>> caller's reference, so the id's refcount stays at 2 instead of dropping
>> to the snapshot-only 1.
>>
>> __devlink_region_snapshot_id_get() is documented as:
>>
>>   *    Note that the caller of this function counts as a 'user', in
>> order to
>>   *    avoid race conditions.  The caller must release its hold on the
>>   *    snapshot by using devlink_region_snapshot_id_put.
>>
>> The netlink trigger is its own caller, and nothing in the kernel holds
>> the id after the command returns, so the hold is never released.
>>
>> Consequences, per successful auto-id trigger:
>>
>>    xa_alloc(&devlink->snapshot_ids, id, xa_mk_value(1))   /* count = 1 */
>>    __devlink_region_snapshot_create()                     /* count = 2 */
>>    ... success, no put ...
>>
>> Later, when the snapshot is deleted, devlink_region_snapshot_del()
>> calls __devlink_snapshot_id_decrement(), bringing the count to 1.
>> Since it is not zero, the id is NOT erased from the xarray:
>>
>>   *    If the count reaches zero, erase this id from the xarray,
>> freeing it
>>   *    up for future re-use by devlink_region_snapshot_id_get().
>>
>> The slot stays occupied forever.  Every subsequent attempt to use that
>> particular id fails:
>>
>>    - __devlink_snapshot_id_insert() rejects it with -EEXIST (xa_load()
>>      finds the stale entry), so a user can never explicitly re-create a
>>      snapshot with that id;
>>    - reading or deleting "the snapshot with that id" returns -ENOENT,
>>      so there is also no way to clean the stale entry up.
>>

Oof. Good find.

> 
> Yes, this is right. I am sending a patch. I reproduced it on netdevsim
> and Intel E825-C with ice driver.
> 
> Not sure if it is worth writing a selftest, might consider it as a
> follow-up.
> 
> Thanks,
> Fernando.
> 
Thanks for working on a fix.

-Jake
