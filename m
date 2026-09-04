Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701F3CB8FB;
	Fri,  4 Sep 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534549; cv=fail; b=PjIa6z+0kwrUv4njvQGEB8RIP2ax/x1oZfX3ENAhZfPWYYUlB5jPKevSK9inV+ChBAXaIum1EDlVRLNZtKvzKrBx/AyHlIiGOoPiEEOCYpJ9E5BiAQBFg7ebP6ugNKAliRjfivCPHsSM8uOWoQkkm/Yz0jZ/82fk13M+oMG552I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534549; c=relaxed/simple;
	bh=OCbbCJrMuOdoMifRQIDvOuoAAvc7UGP1L2ZBD59YRbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TSAjzVjNdqjWPa38e7o6U0kIs+3XW3gwhWRuO+yzTv9OiKK5pstGmsApSBuHHb5e15BQjsqocwoLrl5NcV3JMA99D5P+rA/N2I9oKO/6o8C1+H5+JczXbPWGOSDFtx0oVo2FLIUa7PZD2mNKHjj8Fg+FHWlNqzT4u6ZhasGEe+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATwKpPtO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATwKpPtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788534546; x=1820070546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OCbbCJrMuOdoMifRQIDvOuoAAvc7UGP1L2ZBD59YRbI=;
  b=ATwKpPtOi+o3WdZGOywgF8oaOU52WXJxhRRPTIXEWa25EaH7tmIbmn6x
   jqzadE+gV35PjI9yMmjgDZ+O98eFSkHRZZ4YfHaLk7AuXRucWiPg68xz/
   X+nCd+belJU99bK73tBhMOHopzqosgZ75tfxRKqIoNVW2m09MzqQQ+X/C
   2OPdiptB3SQgkFEDIlGJI3O/oEWbq2hiBsDSmM7+uAG1yPv+LFODAoRCj
   x548T5L1KAsZKNn5B4jkigFZPUMlirt4aNBm+BpYDnAOHLWgoytm2yvbk
   Gtwmp4WQTJpZwI1PuBXs+aC5sANlDDulhv2VUgqxDjKzm/QW92uXZhaJp
   g==;
X-CSE-ConnectionGUID: xsPyd+hVQluxSs17qmJxEg==
X-CSE-MsgGUID: 8QLr28vKQoOKxwjJRLnuhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87976388"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="87976388"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 08:09:05 -0700
X-CSE-ConnectionGUID: Ninu1/DET02bsc1WVWdVOg==
X-CSE-MsgGUID: y8bYGjSbQty3y0uxii0I/w==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 08:09:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 08:09:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 08:09:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 08:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuFQtN33kn96wGxDxt+3Xjl0wnKtei1kL0NnZXtZczc0GfMIBGyI/drPiHrkb2HiShvGIgxo5DX/M88gsD9gD2VQCJCPk+uWBfwybZTnGzd86f6MImF6ZI4DXKMr8G1E4rkZWbSQqQtfTgHzj3LG/+GbJEwFXGGSK+orI+yXJ0mEn7cisjfhrWrEYuTL2aK0njuWmfIXm8jdDJI9mbMjLQdNr/Ecf0OXuaszbuYuvUaGagB2kpqDLj02AC7ciUZ6NYeNUzpSf++0mEaudH7Dzg9pAz3E2OsM06nlWznwJZJz1XSH0eb5oFYPBxgkwwv8POiecIbiKEbgo/vtkTaQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI6rzbCsWjLR5iFgoJ/K/Y2usf4waDeNias84L6eTlQ=;
 b=QlHy9pm4/7dVKmd3QL43VWhZKTpe2GILHjXJvqoyfojTc2s089Ju0803ocaaD+cLsimBobZ/Hfg1qPqIYn8yeDKJVmRFdxM5yc1YeKr00uOXB/8od9GVSXumfH86688M3+yBrK1AlnqAxirGowbd/qfnW7HjpWtj4t1ADIbVPKv0h12M48Rw1Gz9NOFcxNKfgYmSWT6cTwl9yb6243UalnTGtiWfRT7jB8apmp9j295SBqCiH4wK51tfaO1zmABDwd1Dr6fAu2Y2YdEXUvonDam+wqxtNtWXdaKsL42besyF8UwISQlfLkvGf3axiP0lXcaT8ysFeNsXIF8yktKd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:09:02 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:09:02 +0000
Message-ID: <713f5c88-5714-4f77-92eb-fae598155908@intel.com>
Date: Fri, 4 Sep 2026 17:08:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ice: clear Flow Director entries before reset cleanup
To: Aaron Ma <aaron.ma@canonical.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
 <20260903074706.602087-2-aaron.ma@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260903074706.602087-2-aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0301.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::6) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ba5427-4220-4863-4192-08df0a967431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|22082099003|4143699003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: T4I+YD7AeW6Cfzu8yhWWd1hWI8QN8yqCx1/kQNIU/ODC0rhhEmxNTM0nn1zj1Qr6o7mbyvMUk3jmXkKazsYfvdI21dI4k30k7HyLGH7BX0rRDf59se3tTU/PElbcq8AZaFsrHVVdO0U1+uUb/460+ydZRewIy+byMHV4Vdang+3DORwhVNQVefZBNmIeqC7BQDbuxa64Z8hMgk2B2hCazhort6+hzTICsC82X/uaPfNlffAor71wXTK3BmzXaX1yQm/0t58711sdVDe3TEw5yxVx+NcvqpeiOxtYBwOIvO0RNIF+VI/ycWRHDtKc2F8iMCvl5TMDtRloSwgVB4ODtzk5b/C5BW7maQBxCa/8oMbYE1rwKmRECgaXSOKnsRI74uHxU+G5RAmxxjy8COcOJCQjFZ483ot1DunAtPifbRzamcKU3pXHgmIYDbIT//g0y8x1xmlGO5J4Tzy3JZeEU+XwkbFdPd0/xjOpBRFc2XcYn6MUi/zY8i/elbClie09bYIkaK3Gw4vJwhFL1Zn0Ec2t5BYOYu8FJe7gfByx4v4wuBjxcfhx364DYQioFrjN8HCTKBtyGCfFWnLItzvQr307y+WDSReoxwUmMKm4fXAg+b+PmnPHox7+YY6vlPr8wntzk/YGtHI+2gIllyQl/n7jZfK92d8scxGBlz2ad4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2E4TlNXajFuWElWMitCTzZzeUg4RjBPVEVnbHU0djVOV2NWY3Zzb0ZBYUM5?=
 =?utf-8?B?MGtuRHQ1bWxjVmR0UWdFVzNESjRhUC94clpmTVJXQ2MxWEFzWUxvRDNxTUs2?=
 =?utf-8?B?eEd3c1ZRRi8vVlREejJGWFJXcnIwc1hoeGZGR0xJNkFDeWVHclQvYjNVQWZ4?=
 =?utf-8?B?ZjcxWUVRbjhIZzJ3anV4elMvVEVDUm1SbTBPSURodHZZb0FlR3JKYWFOSXV4?=
 =?utf-8?B?dXBiUUZBdGFlVFdpam4yblZXS3ZFZC9abFJFSkF3K1dvSEp1dFpqOWp4RktK?=
 =?utf-8?B?ZTFLam5wbFordXNBS2F4Q2J0SEdzK0hZM1RHcHZNYkV5MzNoWTQ5VXJ6aDRF?=
 =?utf-8?B?L0xhR0kxVTVsdzhELzZidVRVdzAySStRaHlITTkrNEVCT1hBd2NFZSsrcjly?=
 =?utf-8?B?ZmxVQU1GQ01JcTY5QkJmaW9PenNFTzJKRjRqZk02dnBvbHFtOVd0NDFQUElP?=
 =?utf-8?B?VWtEZGVYbjVXWEh3RmVLdFNaS1FER3NqM3Q5VURlUUp3amtuVEdIbmJqOXFv?=
 =?utf-8?B?NkkvNnNSZXFtdndKNFZIbEdRR3FpNnQyd2s3REd6akg4TmVsNWtncmtYZmN1?=
 =?utf-8?B?Um1ENTZHL0xNOEZrWnpYdjREamZ1Y1laQ2Yrc1l2WUNSQ2ttdDh1L2xlOHRS?=
 =?utf-8?B?akVyNkljWk5DR2pNNGI4VVNkSUEydkxhaVRqcHBWcFhtUVk0R3hBK1VjY2tp?=
 =?utf-8?B?OGJ2SUlLdldES3J2T09sd3V6SXlyMmwzQ3hhbHdvOFpVK3BsWmRNbXVEeEpq?=
 =?utf-8?B?aTdLZ0ZYeHdDeG51OTZyR083Yi9GS1h2dDlMcTF0ZThWVXMybGNkZVYzMGNL?=
 =?utf-8?B?ZWpQUzkvZ2ZOZklIVXE4VFBnbWt4Vjl0Z09IbldWdlpZR0xoV2U4bXBrTmNR?=
 =?utf-8?B?dnA4aWJ5eDRFZzIrZVF6eDhiZzZCbk9WNy92UEkwOGQ3VXpEKzVMQjRUOHJh?=
 =?utf-8?B?SnE3MmRXSkllZGRQK2U5Y0drenk5NGI4ckpBQmZ6NUtobCtOU3NIV3R2R0lH?=
 =?utf-8?B?RDNuMmtvcTF1Z2lVd0xnSXUvam9jSG5VaHBqVFFmcm5LalgrVVFGYTczTW1j?=
 =?utf-8?B?RFI0bk9ENW9ZVE5MdHNKaFdodzRZNFc5N3NoazNBMEQvaUY4djBmWitSWmJ3?=
 =?utf-8?B?ZUNYNFZhbnlWZjhhZXlJSllNdnAxRnNORURjMFVVKzhwUmdVZW05WGpNeGZp?=
 =?utf-8?B?VFpDN25Cdm1COStrRkJpNlp6c2lGdnQrSmNRVDROWWJwNGJPenRFbXhuUGR2?=
 =?utf-8?B?K0NQaDllaGkrR1lDdFY0bDdFK1VMcmg5MXhWbW5zODdpT0o2MXBsRTFyKy9V?=
 =?utf-8?B?bERiK0trWDl2bjNnZ0dDTEUzK2JjVzJrTjdMYWxUNHF5S3hxOVRUeUdZTUV5?=
 =?utf-8?B?Ym5rTXJSNjRGT01YZlVhemVKSERIcEFpTVppN2JzVXNnYUJGU055a21BYmw4?=
 =?utf-8?B?ZkVWcVRsaVFvdXdWb1JqN0FXWkZ3Zmo0TDl4SVdaY2dYTURaQmdYTFcrUmlp?=
 =?utf-8?B?UHVydzJ4dkxQQzJLTi9OSFBXYlUrakFieUZ0L1RWdVQ3cklKZFJRcVhLVUVw?=
 =?utf-8?B?RG1CQ2oyZHV1UWU4em9TdFlaMGdpYjhGWm5SN0pPVTYxUWl3YXMyYXh3TkZJ?=
 =?utf-8?B?VmJ3WEtTeUJFd3A1TmZ4VEE0N3FsK1Zha2k4Rk9za3NZUnp3Mlp3ODVtNHNZ?=
 =?utf-8?B?UVdvNDdSaXk5RFVKVk9NSFZYYVhwRzd3am1qUWpHRmNFWTFkUnJLZDRyaG1y?=
 =?utf-8?B?dTBUQURYMDhiVStrd0JORDdxWW8xTmQ4d0w4M0UyWFp6cnp3KythSDg5cnZO?=
 =?utf-8?B?SEwrS3pva1NtWXpzMWlnMGF6akNyMjNyMTltaVljRUt5TkwrMkw1TE54TjdX?=
 =?utf-8?B?NUd4OTVIZVZZSEtjK1hYaENoTUZNdEtCVGFqUFhuYUUzZFJPTEhieitucTk3?=
 =?utf-8?B?SlZOMkNUWXZtY0x5Z3dLZWNuMGQvK0Y3WlZiOGVQVXNDMGM2ZWd5d2x3NVho?=
 =?utf-8?B?aFF1a0RTL1hORWhHR0VSSGY0RWptUVl5c2hvc2JPVGRGTG1rUVlLOGUzWGQ5?=
 =?utf-8?B?R293Y0RKZzcxL2tSd243QytwK0tPOXZTVUlSc2dla05oNTRtQWNVa1JkS3pN?=
 =?utf-8?B?S3ZvUmE5ZWQyMGRWK052V3J4TS9RQW9tc1lFNnM0OCtCNXZTOUdBK1BJbXlo?=
 =?utf-8?B?aXJuVlF3U0RjekN3eVFVMUtRT1pZT0dOOVNaSTlKdmNmTDNlZ3M0bHlyZ3g2?=
 =?utf-8?B?RGtDZXNSU2hRMTN5NWRDOWJwTE0rb0NmVjN3dEpYV3AzOEFId0tXWFZERHFk?=
 =?utf-8?B?d2JNS0ZCeVZMQUdaOVE3TGtYTlZ2WFRUU2lhZ0JEZlVaZVFjRjB3VWtpbnFN?=
 =?utf-8?Q?e6vGufuuDqqDyW/M=3D?=
X-Exchange-RoutingPolicyChecked: JHcfDcsjckJ85k+MjdvA88NJF+fBuWIOfwo80XpimbeZy21UCRyZEBNH9LopaTZ1pgNk/uHE8mz0VWYvLOQmRUeEY+ilXjLFjfOT1VoScUYU45AnOdj85F/L76ywCsH9hwm3QB6ZiWL437sO320pMXcIAZLkPzlHJv10jqMe5P2THKpuYGQAIExWamPVOcsq37ss9D9RzZDwYvwNzjTt83yS/frXxhony9X0F3Dh0QY+aepRII3f8hfdMpGOcsfosenbia6XXKPNI4kwh7haDjkgDZDsM3tiliDZLKiGpXY8OJRJLhhnV+Anf8NEhWTifqw0kFEge9rXc41y09c3cQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ba5427-4220-4863-4192-08df0a967431
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:09:02.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gT9fdcFKGhQu95dsI3DZcBYyknDcDoFwYeLsa5XiqI2M0GJWySanNdF7gUWjmjLWRx7t3aAMZ+S2bxi4fVPnnijdosGvSq7LtYeZ0X0w2kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com

On 9/3/26 9:47 AM, Aaron Ma wrote:
> Flow Director profiles retain handles to generic flow entries. Reset calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
> handles unchanged until replay replaces them.
> 
> If rebuild fails before replay completes, later driver removal follows a
> stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
> 
> The failure is reported as:
> 
>    KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>    RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>    ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
> 
> Clear the Flow Director handles before the hardware tables free their
> entries. A successful replay installs new handles, while a failed rebuild
> leaves them invalid for later cleanup.
> 
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

makes sense, thank you!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
