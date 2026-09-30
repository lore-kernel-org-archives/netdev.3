Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEF4C6535
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769272; cv=fail; b=BnaDjn96QrcgyFxZTGRjRNgVg123McDd1OZ2pIdMvgG+faq7ZA6o4CmVBTutU67HkR5zpNITMxf50KokpgrYvq/IwCG5lMPYAbvgquG1dqVW5BOc8/OgoVp1QHolSx2teHgFHDhKmIi/F0k+5ETA3rqX2WZcxQZZ0Pynz4xAB8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769272; c=relaxed/simple;
	bh=VPinwn3CbJdbR9lS0I41n3jIdiIugQ0JaKCH1iUxvjE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=otviIKKg9dXYewjdOVAZl7EXjU+gpQdeV6LBZlztO24nyCYIksoVNAqGelaSqTlRO3PENp70U7tjchHBmjEbTfCEhAWJweUMOuNZHFLIGYGQaS/aLcHhyAQISnsRym8U2m3TQ0cYMYVpr3G0X4HOCRpZW6uSB/b8ae9yyE237I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/qI9LaS; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/qI9LaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790769269; x=1822305269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VPinwn3CbJdbR9lS0I41n3jIdiIugQ0JaKCH1iUxvjE=;
  b=E/qI9LaS6SpC9AeyylSNRQPTVoykTfnMR23Ez/VABIHoedMOsgsa8Qy8
   prfbL2tVMAypV4h3W0b/FtEEqwieD0+Gv9ujejkwNUDp2Gc4xOYtMP82K
   05Z0vSRiTHMqybuJJnGNblhI95CbMHks4COJBkEO1bfwY032KRdO79Xjh
   vsnxR6br682NIgjy5q9MH5WQcF+gRv2GCFb9wdHANMc+U75rnJN5Yw1Sc
   0CkxrRmo9dpfoH10oAt0eo4Rzk1eY+cOHK5PyJwRQ3w+NoqAsratyRO0I
   qfFI/NKqQA6I3t3zc2KmRI+WC9S/tOSEAGJehRtaTmwOG4diwXukzxOt2
   w==;
X-CSE-ConnectionGUID: A+UGT8E1RWSvaGkDSp30BQ==
X-CSE-MsgGUID: UCtqQ7gEQaOrR99dVWKp/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90364335"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90364335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:54:28 -0700
X-CSE-ConnectionGUID: bbMOCgw/Th2dWD29ctmjYQ==
X-CSE-MsgGUID: W4eYVkrvRBGNslkt9cVmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="279469251"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:54:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:54:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:54:27 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:54:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFrBy0TZ3nt9ixkdw4DpIhqMlwQCvo+tmF3WltkgcZ8MBTiru03wh/r1oQ17m16One9ok2+6hxPXU/y+/gebd32W3nRGBa2ck0H3Y8J9b/R0SRIB0vCHuinO8Vdfc8x/ZD4eALsB+787nnpDApWhowyOeBfNRTibzHoNz+PlGmgSyRZORT6g/axC6ee6mdKuNgwsBiS3XOmIMp6ieZ7YmAGnPOd6WyXSFe3AdMiB/HEfudN1kjNf4j4FixbbzBGqGwtvbIGqXdEn2XmEoV1bCe8u/f5GLgJmHCjE9nyFM1gxLz0ZI9XONB/POFWro/2Y1aLsU9SHLjg1TnCRGAc24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWdXf7FjNd60WIMm3F1l5hatk3iku3Xxh6pUCxA+2XY=;
 b=utD0CwQdFcoWoNpbQN/bOzmcjpPL9pdWAmpotZNbezYqp8TjzFAFPB6Kso3n7kMIBqaP2UU1UH5LwU88XrQzm5RGQ3SUHSu1Pn2NEzY/sLSDO6KeXVmEMyi697kLENbSu4ElGXNA++HAiyKtaz56Uo1LVIApzCEMDnDqOX4GDxF0xoWAJXR7FNMC9iOoCb9YMCKkjYHeg/cpn7h2twu/ZtwCrHDq6djnd3L8YgZLz5xFzycc5XbVS+wnay8Ir+l+limaAJFJsgV64kOiW/KFSBJ65sWw5cCNDuNe9051R0BEI8bgOX9xi3bsXNX9o+JUpbLB6aaXRDbOPJmAPm4fZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:54:18 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 11:54:18 +0000
Message-ID: <acc2fdbe-2070-4f7f-b550-4b4561841e59@intel.com>
Date: Wed, 30 Sep 2026 13:54:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 5/6] ice: rebuild ring stats arrays instead of
 reallocating them in place
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<aleksandr.loktionov@intel.com>, <mschmidt@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20260925132636.123300-6-przemyslaw.kitszel@intel.com>
 <179069064954.434549.8538944205290269009@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <179069064954.434549.8538944205290269009@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0002.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::33) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 3148d2f4-9870-43cf-34fb-08df1ee98eeb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FB1Q/mRRZTmc7EHmyEn59pmlO/4IkmPNi6CSy+3Pqe6EvwgxC4rGLj+XWD177d221P9VC2821GHXfkFwWvlINIsx0dtXXnFEec/QgDOWJu7ofkoZBAhCQQuPqfDOzsIqu2TnaOTPKBpURnoTZSznRaxEVxkyf47rdi+yt1brGNIDT7xhQ9A0uqT7q5YrzdZ/P1vLDY4GxhLimF0AbZh/fHYWe24c2l7ZMkMMBtIcO0iloHy8rFe9R3rB7w7a10ltiEr29Y3Uk8nWvXX7yiLhey3gq797Duhlpo42DVuZW9MZnUf0cC04Po5FDDO9yO/d0wPc+2nGtMM3Q9VliiGDn8Ilgjn/8Gp92WE1gFOZYAY6rbBBbCoKvjXOGggRBOo/qUcDSvQjOMWOANTG4cWog04UULC55ZXFr5nL5c6WNMgIVYTNzrIHe39gmHGaFjte2sUG7pypqrNqaz3wfUtuByjdSJ34egBDMlB0O4B/DaPeiiUqYDgFhRhPebLQ3cfVeVtMSnxcy2jJdkq7ngzKbYVGezm2bKPomhwj8KjF6KiyKFUq38+vxilnH9fSb162m0jT4pzwG/PLzdP+bOHAzfE+g8BvqPaEfQjiXDh1mthL6u3Ci3wL3TKuA+SRg+eV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytkK2lZWnNibVFLRXErK0ttb2F2QThSZEFzZEMxbUVsOGk4VnZ5NWVZY0xQ?=
 =?utf-8?B?ZE9lMlF3UW45N2w4NHhSRDUzRjlMT2UreGdMZ2IyVHpBNTYrSnJvcmZPMFhn?=
 =?utf-8?B?OGJxai9waVI5Sk04YTFpNktJSFpJOE9XdXkyNncvWkhhbCtQNTRDMHFqM0M4?=
 =?utf-8?B?czFDWlNwdDU0aUZCZjh4NnBoaWhKRXZiTjI1bk1DZ3Jna3Q4d01FRjBpSDlv?=
 =?utf-8?B?RStVOFdSOFNIbSt1STZpQ2lyRHdNQlZpM3RmY3l1aTVlM3RyaWF0a0NQVUly?=
 =?utf-8?B?VEdBZnA5aDRiNGNRUmZNNnFqd3U1bVNraWFCQWdkL2pieUFHMkF1bVhtNnBh?=
 =?utf-8?B?b2tPdWdISjlxa3BFOGZ0TmtKczl1c0U1RGtsMDBwM2xYN2Q5alFyUmIxaTNw?=
 =?utf-8?B?VnFMR0pmT3EvSTQxdmhESEtHcGEycTlGZ2JlRG00cXJWbjNnVkg2RjZ1a0lu?=
 =?utf-8?B?R01kbnJQRmJYNXhNVlRYSEoxb3p6eHpVVFVEdmNndHFKQlkrQXZ3bEdkNWcw?=
 =?utf-8?B?ZGtLcE9JeTZxQ3YxN00xTWdhK21ZRnk0c1pxS1J3TlN6VHlkVzBNbkN6NVA3?=
 =?utf-8?B?RVV2WGdQL0cva0tvTVNxQmlNQ0pZZjBxRTQrZ1JzN3RuRGtkZG11Nkp6SVM4?=
 =?utf-8?B?M0dVU3dZb0VuckJzYVpwUE05eGMwMks0Nm9MNXF0cEM0aERER0U3b1d2NHd3?=
 =?utf-8?B?bCs2M2JpbEtwMFdLQjVuR1lOUGVkU3ByS3laV3pONWNmMDRNMGU4KzI2S05j?=
 =?utf-8?B?TVUrUkVOaGhqMG0waDAzNExpbVJVQ3Z4UitSVm5nbUQxa2E0eDdVWlRHT3NB?=
 =?utf-8?B?VHk3UXlyUU5uNlAxWDE1VDdsSGc5U3U4THRZanpsZTlCZnQ4RzJmSGN4R3dR?=
 =?utf-8?B?MFh1WUJadC8zYWgxZFVveHhyTWl1cXY3R1pqT2lmaWV2MC8ydFM3VEZoS3ds?=
 =?utf-8?B?U1JKQld1V1Q4bm1SNzhrMFVpVWsvSUJEdWh1VjdlRzNXNXlSMHAwTndtTDV5?=
 =?utf-8?B?ZEszUGIyZ050cURhaCt3MHdhRXFMYkowQ0pTSk1KOFAvUjRES0tSbCtGK05K?=
 =?utf-8?B?WWpmTG9tRm4zRVlCRk90ajBML3c4b05FU1JFbWo4YVlYY2M1b0NiaGVJZmRJ?=
 =?utf-8?B?TXlTMzB6a2VWK09KMVMzKy9RUXBqbjJXOGlPRkhVbkppYUV3ZGN4eWJ0TTVi?=
 =?utf-8?B?WHU4WG9MeHVGbmx3VXpEZ25BOGFGRFRLMXV6d29kZVZGTmlVYjl5Z1R2dURq?=
 =?utf-8?B?WHBuMWVWQmY4VGNiZjJJSVZEbjdVM0xPQ3VRR3lJNmxGNUhCcjc0Mm1ON1Yy?=
 =?utf-8?B?N2xyVHBsYjE5OHVMMDhCZW5VTi9JVTlJbFU1alVNYWRONDR2RW40NnQxeXRF?=
 =?utf-8?B?UW5ERjJqS05aR2Nab1BidTdYTDVLUG1lRkJPa1FNOFF0RWh5YUhPQlhoZVBW?=
 =?utf-8?B?SXhlV2lyK3ZqVmtWT09uZ25xckxDQ1R3SWpXQ2x1UFJMRE5tamN4dU1zdngx?=
 =?utf-8?B?b3lnSnUyYVZ3SjNKUWRJTlJZaTE1U3lKRk9MeVlOenJSU1M5UDhuTDY0a21N?=
 =?utf-8?B?dDNtTHdJTFIvck1KWmpIN3lnbWR4UmhRVzYrNGo4U1VHK0dzTGhHZXJFM1Y5?=
 =?utf-8?B?VVBRaXlnb001VmZNZWNxTGF3V2p6Y1Y0VmRHRWFXMkhxKzUrem9KNU5xTm5r?=
 =?utf-8?B?UnppRE1NN1RyK0RmMVhjRFltM0NPZnpNMGVaUnpJcUdFR2ZJaFNQSmFVYWEx?=
 =?utf-8?B?N0hlVWEvQnJRSzdMR0k0alBMcGxnV0Rkb1NaWVc1S1ZJK3dHL28zRmZuNlFJ?=
 =?utf-8?B?WnhEVml6U3d6ckVOUWRIV2Q5WEdlcjJPWmIwVmJhZVVsYVJMQjd3R21WRzBs?=
 =?utf-8?B?bWxkUmZoejIrVENoU1pQMEttUDA0MXZGaUVpU20vbVpyUmd6K3NHUjhPNm5j?=
 =?utf-8?B?SGR6N2dac3JDdlg5d1R3dlk5NzhCbEsxMUJHaTZTTGJwdXlEVkNaT0QxYlRs?=
 =?utf-8?B?RkVONmNuRTdoL3RHRmhYZVloWUM0SHFmMlJNai9XM0h0SmpwTU05dTkyTmVU?=
 =?utf-8?B?SmZ4NWQ2WURvYnpqVlc4R2lENEdGLy9VWEVqMVZsOGN0dnlyUllyM1ZnUFU1?=
 =?utf-8?B?bGluYmNDeS9VS3RWZjlDaVF5K3EzYTRmOW9aRVlzSVRmdWEzZ0FIQzV3ckdO?=
 =?utf-8?B?a0p1Q1owK1F0alkzdCt6MXY2Snp6T2pHUzJBY09qeVlibUxqNGdtemdlTnhv?=
 =?utf-8?B?bXV0NE5wS1laTkVJKzQwLy9LQXc0bHU2ajhORmFxbmtYUWk1emZ2OHVNakVV?=
 =?utf-8?B?WDRzVlZjMWZSVWpOSklKNCtFSm5WdGVTbEMzbDRJcVVMR3VGUHYrY0UvQVVW?=
 =?utf-8?Q?PXIXAc7fQflONxH8=3D?=
X-Exchange-RoutingPolicyChecked: GpT6BEXeenWIUpF/jmxrDnDzJ2hv3g2rPV0JilOQN5gtx/KelA7IRupsSXoofz6Uo013/tVMkXWnjImiHOmP+FN7hgu0bedzV5km+UwkmifOZ3efYxm+ZE4uJ3br8sNy20Px6nkGWvL2y9ug82LKth7XxYVV0tUplZK//lo9AjHm7u42KCWrP7yJkWQm7yT933pOqfHMtXpw7NTBrx2hl4tjxAs/UI0bAVT/tMSktbGjHW9BDCch3EchTY4gOqlGc5GraL6o/d4EBFL0LhzwXK3kWsw7hLSl4sG+KIbrGxa16fehme9I2+W6WiV3hD/RzrsPkso3+XRWY2TKPtIS/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3148d2f4-9870-43cf-34fb-08df1ee98eeb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:54:18.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwuAm9PJJRDmDKLc60wZ17wzBqOgWY0YKA6TSLjHR6ejWsl+1qZKYvOzBOroZZ/SilaDyAzpS3ti/cirbXqy0q327J8OiZDiOoWsGZsNOXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com

On 9/29/26 4:04 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.

Summary: Ignore, please merge.

> 
> Critical: 1 · High: 0 (1) · Medium: 1 (1) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Critical] ice_vsi_resize_stat_arrays() sizes the arrays from a
>    snapshot taken before ice_vsi_decfg(): the PF pool,…

AI says that weird stuff, like CPU hotplug, must happen to trigger
a problem, then, that the last patch fixes the problem.
I will simply ignore (driver is not ready for such stuff in general).

> - [Medium] ice_vsi_set_stat_arrays() publishes the new container with a
>    plain store (`pf->vsi_stats[vsi->idx] = new_vsi_stat;`, ice_lib.c:592)…

In the body of the comment AI says that the ETF-vs-reset issue is
pre-existing, reading more, the old code was doining the same level of
changes prior to the series/patch, but due to "being new code" its not
marked. Also, issue "seems plausible", but all works, perhaps due to
other locks.

I would like to leave it out of the series.

> - [Low] This patch fixes a real heap out-of-bounds access but has no
>    Fixes: tag, and the Fixes-tagged fix later in the series cannot be…

same comment as in patch 2, I'm against Fixes tags for "first half" of
the fix, when for the same target commit and in the same series.

> 
> Pre-existing issues:

I simply want to merge code instead of endless growth of fixed area.

> - [High] This problem wasn't introduced by this patch, but a fallback
>    rebuild dereferences NULL queue maps.
> - [Medium] ice_vsi_free_unused_stat_arrays() calls kfree_rcu() on surplus
>    ice_ring_stats entries while vsi->tx_rings[i]->ring_stats and…
> 

 > Sashiko AI review · 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
