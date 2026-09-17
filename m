Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869F3B6BE3
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662357; cv=fail; b=O/9C0WUTqFWrPw2I4tiYd0kLL65ghO79Pz5bM6xrvJxSIvMjB+YHmgvlCStqjP5ZcSOK1I7rB+m17lJHIZiUVhNqvGsVS4jF3QitRCPOOZbo/fcQHesRer2CyVvEqagQpWgVohmliHlvwE9Gb0oAb19vW3SPokIar7X7wb0snsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662357; c=relaxed/simple;
	bh=9NVlRe0sxev9UTW1FSUihg/l5PsA/NEB9qT0AEoTQ2c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K6ytKcFsZL/xsKyBmFRFVmaZwDw4R8MMvOYskapJb5RMj75/uGhju+u/yRTCmQtUKO9qTkkLNgviXBkL1Zwgteg43P5SR4t5Sb+l3C/EYwWT+v1JfOyPyMTAPc7XrOAjdOcYmHCfiJ68fUCtuYxb74VMkMYhzpDwcIylgitdWxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gab0ostN; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gab0ostN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789662354; x=1821198354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9NVlRe0sxev9UTW1FSUihg/l5PsA/NEB9qT0AEoTQ2c=;
  b=Gab0ostNafKff6CQjB3bIrY8bBv1L+0gwNy8AOjMlLSli3HYS2oUbNRI
   XBYw99LIgmp/lxugFE9HaM4RCqsEznjQFqEFMhkTLaKdULWb/+lte+yww
   pQHKFnGrc/wYolePT8Z2wHhxrWXzp1sxZyAQoZMcqA44Z2zDDxIIvesAr
   acr0iC+PzSxIYk4FUuL5aCAS5jkpDrovcNx9Ah7vkpFS0ItGAfH0XRwlY
   BqgfExVYYS8LkH+4WoAYoZ4dnhw6zxejDsduZWySPw71xLQ85w7E+UU9v
   jk2Z8h8IhsxKyazgkMfFvMTQOuknja/DSlyLLtEsvd8oK7r8ON1rkyM61
   A==;
X-CSE-ConnectionGUID: HomGrSnYR6+krRcKkvPsBQ==
X-CSE-MsgGUID: 1SfCa22PRZuREKwxAKzGsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="607119"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="607119"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:25:53 -0700
X-CSE-ConnectionGUID: pwQaX3cfQ1iL6pPKy7UFPg==
X-CSE-MsgGUID: 85TucmbsREyJJlpq6o8wKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270213192"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:25:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:25:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:25:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1v0llUFla+JHkeKUIQ8tz9YM861FayO96u4kxmktncoEjRRk+/vP/DSAJU8V/0ZKpONdEekHHsMg4tNgS0Kj3C0s7+wgJVYeLh5FJwnCdxyNxoyxG/NWqh5Fe0zZJUqC3aVp2bB3WCbzeYnATZAVscoJAK8wfU9uloEXBRmtEh7Gek4/+grIkjzMvMDsLN37us2sUtrhvuevNmiC1gr+czhKGZo3FLT4ugtfZymAURecJMXR4pEyrAX1xGkTlJnUImXQo8NDmF9Y5AHziYgmr7U+MLhfy2/oHXwunx/rfbA+vHvcjhyh1y1Qwr4Fz1nRQXJN6+ZLURrjsnDVdzlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yndF+tW7W8V2CiLmm5Zn370kX/Xon3d8YUs05Fmqdk4=;
 b=nSm3mzeuodOkMsXMr3NKbOlqnTj5Lg7ftIVcyIiaKL6GOf3hCoFEadskca2zgA1ueNo59MmEdr5uPZBdJRZmypFMZxEhsJRzm3bhJ0p/3febXIyIu7ZwvYA6P1ZSge6vCxz7I0+Jj0xyxzZN9cMj0W9pHAEftAi7GoSJVtpp4twmjis3ffFR8bpvj+gaKnZbiNg19FkmgRbfA2hf04JvVMjCsUvG1K842yuaKLN/55Hr/gBh7CUoQc8OF/si5r1GP5bap/bo1zhU3nU1GdOr0+1ZrKSMuhzPGkc4FODXN9NK4Tv1uQn8TxUnAmON11r8cCAuQszPHOUjYcjmTfxEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DSWPR11MB9740.namprd11.prod.outlook.com (2603:10b6:8:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:25:48 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:25:48 +0000
Message-ID: <ad6bffd3-c4dd-48ef-8f23-a521af7d0707@intel.com>
Date: Thu, 17 Sep 2026 09:25:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/15] ice: E822: keep Tx timestamps disabled during
 offset calibration
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-5-anthony.l.nguyen@intel.com>
 <20260916011215.1632391-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011215.1632391-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DSWPR11MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c41546-40cd-4e0b-fe1f-08df14d854e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: q60Xx6ZFFiicqypXRTd8cGVjl/MlDMl/xho5yZxoXRGoqwkroDmVxi3U1OXy2Pti8UkNn+jMFsKnDTWxd8j8IWw4Cqllhm2VxTDBpNy8xmDBIVw8NvWYKzBFnrTfDVkmRNs33h7Gmy6Y8KzQ28PzWTh5uahx62Fj1Gl7QUbFhHXeFXs+5add2CEps3moCddFDaiCZnly0HriitYn3vAjM+HdFf6pq7vR+WxJ68QF5/baTA+bYAgFFa7sx1CnFjwgKTnWLiyE2diLEMKosWFYYcvxjUYDtyb/uJPh1G88ns7n3TgraMnqG5u3xen8qhEdNQ7KpmIu9bmm8Gsec9PmoNFgp1Zlrcd7H3WQ+6UI7kql26vNuNaChW+woDrqK2M7CJArI9WJ3NeytAMgZxUc1AHE/NEofqlyDApMdU3HTIM6O549GYrzQ4eSIhfz8bDdo2691hKOSNoeRw+S5uxjAudptRs/hdyATcjxGCXK+THubu6fMcFvM74zyR0mRgHbnQixUtVXWEaVigBBl7wAumO8Hb7rfFIn31KQSFb9ScCI+7v50TL6Ypq/tJo4MBAZng44Mmo9vcimPe4SA3X7+XTPwjfnTQTn7EJi0+bKULp9V8maN/iCMOJDOl6BizJ6mJ8yHkAxJXAV4H9gFGV1r0AdxJOG7SBmMK0qdYjfdjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FGa0dMMGo2dXdVaW9CZlhWQVNYcEw5bGdELzd5N2UzWEhWaVZlU0RIMDlq?=
 =?utf-8?B?a0xUam91WEx3ZERCTGdxV2Rpc0VKWnVOZ2xlQ1pXZzU2Z1RHcFA3all4b1RN?=
 =?utf-8?B?Z2t3dld4Z3RUWGNQY2ZJV0hEL05kSTVVK2lSVDNBQ1RROFJHTUhnVDR3WWVN?=
 =?utf-8?B?bTB0Y1FmeTJwS1plaE53N2ZWNU16TFBaM3pIbk9FV3AxQ3RHMk8wNXJlN1Fh?=
 =?utf-8?B?TDBLbEswOHlRVHplYnh4Q05jYXB4dzN3Z2l5aGovVlhnODFnazd5dUtFbmI3?=
 =?utf-8?B?dHUrY3U4akRPTUNSZzR2UTZWWE9HWU5pU0VKeWw4OWxRdHJMVnQvRGR4aHBi?=
 =?utf-8?B?MXc1c3pTUGE1YXY2Umtjd2lqTGVXZWhYcFExenBqSHc1aDExdExxZnMyWVJs?=
 =?utf-8?B?RG1McVdHc0RDUytLcTRjTWR0ek91WHBKWkt2MG9jNXpmeHZyWUQ4RUkxWld4?=
 =?utf-8?B?YkVPVjJsRzM0djloVG9EbDgyMHRhcTBvMmFjRncwbVUzWkVzU2FUaXBiVGkw?=
 =?utf-8?B?MFpWSkFQeGt2Z0xGZWNRRHRIVU1tQ1pOMDkwK3pwRk5ZZVdkL3pXWnhrL3Z0?=
 =?utf-8?B?bXhscm1qMC8weWIrMS9YQ0ZvWGZQaml6aUlkRCtpNHl6UklGQURqSis1d2JP?=
 =?utf-8?B?Z0lqVXRCeC9JUFNBdXhsNVRNdE9tdlJHd0pyTzkvRzNONFNUTElLcGFKSHJw?=
 =?utf-8?B?UUU0aGFSWTd0V2s1RzUxOTNjUzBLTUh4UVFUSnBUaTgycGZIWWFWSlBXZGly?=
 =?utf-8?B?VHhMYzNweER3MUpTODI2UVVFV2R1Q3BhaHRvZ3I3UnM3eWRwRDJqeThqMEQw?=
 =?utf-8?B?MUNNS2JHWCtwcVlJd3FqSGFya0poeGNsMkxXYkk5YzUyQTR2MmRaUG5DeWdu?=
 =?utf-8?B?Zmo4a01VT28zWnpFdXNzWWxFdjhLK04yVGJkU1NFVEplbUdFdUN5akdVUkpE?=
 =?utf-8?B?d3pNU1M4cStDektMbTU1bnQvYmZRc2MxemlGMkUvSzF0WWlsVU9uL0MyUTFZ?=
 =?utf-8?B?NXRvZUJJTy8ycGtVQktwUGNuQ0xjRGxJZHVFTUl1UkVoYm9yZzUxSkRyVkVq?=
 =?utf-8?B?MHBoeThsejVqQWwxUTd3UkdtSXBzWitMZnZOQ2ltOFZqdUYyaEljS0RJQ0t3?=
 =?utf-8?B?UndIUmZ3N0FqdkZkaG5idXdqdFcyOWZsaEhUNUFKY2JEVmlWWHdtUExsdlRz?=
 =?utf-8?B?dTBEUjZqZXBFbVg0OGtLZ0ZsYStDSUpJcU1TdzU5WVVwd1FRYkk1M3pWM2J0?=
 =?utf-8?B?SmdEMk41SVZpWWtGMXBuaE5VYkpwTWZMTGU4NFF4ZTdUZkl5RXI4NGxxNlVT?=
 =?utf-8?B?dHNGR3NEbzBtMzFIdWZTQUhob2lnWVFWUjQxaHBLUWlXUkJWNXJFQUJvZnVy?=
 =?utf-8?B?V0NyV2p4Vk9qSDlrZzY2SGEvMjlxdTl0U0JZM09IUEMrU082ODluRUQ4UEZy?=
 =?utf-8?B?NGkxTVkyUWZZYTVSRmlDL0JjMnZqTmRCYVEyYmZ2MFVMRm9rcmEzc1M4bUFC?=
 =?utf-8?B?TTRZVG5wK0JJNzVQQTFXUE0xWitkUGJTSUlEMUsreWlrUGdINUlGRWNTd00z?=
 =?utf-8?B?a1lBMDJHbVpzLzNqbHdzSk4ybEZSU2N1d0hnaHdOd0NweitheTRXZEpLTjNW?=
 =?utf-8?B?czY2S0pTZ3VUTm5nQ2s1NiswM1EvQ1BvMzdjeDVOUVMwN3RQc05IU29ZTlow?=
 =?utf-8?B?M3NqYlNxM05ZSVcvcTY0dVRQcGh0TlVzSXMzZ3MxMmswdnRHRnpZNzNvNFp5?=
 =?utf-8?B?aEk0dk40SFBDdDlrczNIdXpzYmxldkxtT0Jobm1VYW9XOCszZHNaekxRTysx?=
 =?utf-8?B?N2V0czhucTRsUUk2OGJuZjFHQ013Mzc1Vk9xMWhLV0NFQTZjalA4aEs2S2pB?=
 =?utf-8?B?c003NmZXUTB4Z3pPSGZIamNDS1NIWVJsVVZoR0xLRG1FRGpaYm1xd3dnOGVo?=
 =?utf-8?B?K0xuTGluYzNhSm5ET0RoSDhhZmhWWkVOODlDRDk0U2JtWlpORlFIRGYxZnpP?=
 =?utf-8?B?TXBVc0RSUjdlWXlyWDBxUXROQzFVYWxxblF4WmZyK0FieU9QU1YrRzRDK2NZ?=
 =?utf-8?B?aHZXRk9FR3c5WFJsMS92ZFB5Q04wZ2lkZGFBbzhwRG9wSGZvendsV01TMTU5?=
 =?utf-8?B?OEZab0pWSEZSNW9QcDBIeWxNK2lEcUJpRnBwRVNLWWdwYlBXQkNWeEg5SlhH?=
 =?utf-8?B?R2JvZ2s2ZVFFbmZ4VmJXdit3UGlNODdQUm1mZjBPajViclJmcC90ZG1yVk9X?=
 =?utf-8?B?UnI4ZnVwRVBReHpXOWF4UXRhb2FtOGw2VVkvaUUvZzl0NCtTK1owNUk0QWNW?=
 =?utf-8?B?SVRoalBqZmVXSHhnNmtVa3dTUnNuOVRwVnJGMkliNUJ2eGlpWEgrN3FPQkdX?=
 =?utf-8?Q?CA3vHpItWxRhAC90=3D?=
X-Exchange-RoutingPolicyChecked: aI4wPRkNxcDkquYb123GOUMdrhKgmOwkbYRS1kwmRsTIMlu+sbsDsBxmx8v9zR4up3aHfN/Y5Doc4mykE9TtYfyrfqZgka/0tprD7J5zjAE0kQsDi6wP3yNue6Pv2IzsANP2+1gnBvTHQD44K9Z9Mkra3wRhI/eJ1bxEMC5ceU3DLURMUJpwl1sITXdKtOPkHfuYO1HaVZGBr0m4fQ0yteJ/c/h2HJvLHv6GaRKCoi53D9NC+R+sZTzGw3RSceYO9V7g7lGllErpPv296PNE/fVwlXr6GR/4+eDAoKmRPgCwqpLPSeKDX5mdd5LvBMIhf3OB7IBrHXRUUuqU1rInmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c41546-40cd-4e0b-fe1f-08df14d854e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:25:48.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCe3ZEqmnXd/dpQbT5cUiPwYtUN9WUV7IaPP+UTvnwtHDxf8qiqAwn/vyEyNK1Xa0TEb2jGk0PTNszO3bfhwPuXk1QI9l5KzDsC8FmCv11U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9740
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: E822: keep Tx timestamps disabled during offset calibration
> 
> This moves the clearing of port->tx.calibrating out of
> ice_ptp_port_phy_restart() and into ice_ptp_wait_for_offsets(), so that Tx
> timestamps stay disabled until the Tx and Rx PHY offsets have been
> configured.  It also adds two dev_dbg() messages covering the pending and
> the completed calibration cases.
> 
> No Link: tags present in the commit header.
> 
> A few questions below.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 68537705e8399..d018f02f700d7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1156,6 +1156,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
>>  static void ice_ptp_wait_for_offsets(struct kthread_work *work)
>>  {
>>  	struct ice_ptp_port *port;
>> +	unsigned long flags;
>>  	struct ice_pf *pf;
>>  	struct ice_hw *hw;
>>  	int tx_err;
>> @@ -1178,12 +1179,28 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
>>  		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
>>  	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
>>  	if (tx_err || rx_err) {
>> -		/* Tx and/or Rx offset not yet configured, try again later */
>> +		/* Tx and/or Rx offset not yet configured, try again later.
>> +		 * This is expected during normal link-up: the vernier offset
>> +		 * calibration cannot complete until at least one packet has
>> +		 * been transmitted, so the first retries routinely land here.
>> +		 */
>> +		dev_dbg(ice_pf_to_dev(pf),
>> +			"PTP offset not yet valid for port %u (tx_err=%d rx_err=%d)\n",
>> +			port->port_num, tx_err, rx_err);
>>  		kthread_queue_delayed_work(pf->ptp.kworker,
>>  					   &port->ov_work,
>>  					   msecs_to_jiffies(100));
>>  		return;
>>  	}
>> +
>> +	/* Tx and Rx offsets are now configured, enable Tx timestamps */
>> +	spin_lock_irqsave(&port->tx.lock, flags);
>> +	port->tx.calibrating = false;
>> +	spin_unlock_irqrestore(&port->tx.lock, flags);
> 
> [Severity: High]
> Does placing the only clear of port->tx.calibrating after the combined
> "if (tx_err || rx_err)" gate make the Tx timestamp gate depend on Rx
> calibration?
> 
> The two directions have independent offset-ready registers.  On the Tx side,
> ice_phy_cfg_tx_offset_e82x() programs the total Tx offset and sets:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_phy_cfg_tx_offset_e82x() {
> 	...
> 	err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 1);
> 	...
> }
> 
> and thereafter returns 0 immediately ("Nothing to do if we've already
> programmed the offset").  Meanwhile the Rx side keeps failing until a packet
> has actually been received:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_phy_cfg_rx_offset_e82x() {
> 	...
> 	if (!(reg & P_REG_RX_OV_STATUS_OV_M))
> 		return -EBUSY;
> 	...
> }
> 
> So in the Tx-done/Rx-pending state, ice_ptp_wait_for_offsets() loops on the
> 100 ms retry branch with tx_err == 0 and rx_err == -EBUSY and never reaches
> the new "port->tx.calibrating = false".
> 
> Since calibrating is written in only two places after this patch (set true
> in ice_ptp_port_phy_restart(), cleared here), is there anything left that
> can reopen the Tx gate?  ice_ptp_is_tx_tracker_up() stays false:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_is_tx_tracker_up() {
> 	return tx->init && !tx->calibrating;
> }
> 
> and every request is refused, with ice_tstamp() only bumping the skipped
> counter:
> 
> drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tstamp() {
> 	idx = ice_ptp_request_ts(tx_ring->tx_tstamps, skb);
> 	if (idx < 0) {
> 		tx_ring->vsi->back->ptp.tx_hwtstamp_skipped++;
> 		return;
> 	}
> 	...
> }
> 
> This is reachable on an ordinary link-up when the link partner is silent or
> passive, or in one-way/tap topologies, and it persists until the next link
> transition.  Before this patch the Tx gate did not depend on the Rx side.
> 
> Would gating the clear on tx_err == 0 only, and letting the Rx offset
> configuration continue to retry independently, be the intended behaviour?
> 

Yea, thats is the intended behavior. Will investigate and fix.

> [Severity: Low]
> Should the surrounding documentation be updated along with the new
> semantics?  The kernel-doc directly above ice_ptp_wait_for_offsets() still
> says:
> 
>  * Once the offset in either direction is measured, configure the associated
>  * registers with the calibrated offset values and enable timestamping. The Tx
>  * and Rx directions are configured independently as soon as their associated
>  * offsets are known.
> 
> and the member doc in ice_ptp.h for struct ice_ptp_tx still says:
> 
>  * @calibrating: if true, the PHY is calibrating the Tx offset. During this
>  *               window, timestamps are temporarily disabled.
> 
> After the patch the flag is cleared only when ice_ptp_check_tx_fifo(),
> ice_phy_cfg_tx_offset_e82x() and ice_phy_cfg_rx_offset_e82x() all succeed,
> so the Tx gate now also encodes Rx state and Tx FIFO state.  The window is
> also no longer temporary in all cases: on the ice_start_phy_timer_e82x()
> error path ice_ptp_port_phy_restart() breaks before queueing ov_work, and
> ice_ptp_port_phy_stop() cancels ov_work without restoring the flag.
> 

I'll make sure to update the comment after resolving the other report
above to match.

>> +
>> +	dev_dbg(ice_pf_to_dev(pf),
>> +		"PTP offset valid for port %u, Tx timestamps enabled\n",
>> +		port->port_num);
>>  }
>>  
>>  /**
>> @@ -1269,10 +1286,13 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>>  		if (err)
>>  			break;
>>  
>> -		/* Enable Tx timestamps right away */
>> -		spin_lock_irqsave(&ptp_port->tx.lock, flags);
>> -		ptp_port->tx.calibrating = false;
>> -		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>> +		/* Do not clear calibrating flag here. Tx timestamps remain
>> +		 * disabled until ice_ptp_wait_for_offsets() has verified
>> +		 * that the Tx and Rx offset calibration has completed.
>> +		 * Clearing it here would allow Tx timestamps to be reported
>> +		 * before the PHY offset registers are configured, leading
>> +		 * to incorrect timestamp values.
>> +		 */
> 
> [Severity: Medium]
> Is the "leading to incorrect timestamp values" description in this comment,
> and the matching commit message text, accurate for this window?
> 
> The commit message says:
> 
>     Timestamps produced during this window use uncalibrated PHY offsets and
>     can produce incorrect values.
> 
>     When ptp4l receives incorrect timestamps, it may reject them and wait
>     for the next sync interval (typically 1-2 seconds), compounding delays
>     during link cycling.
> 
> During that window P_REG_TX_OR is 0.  ice_start_phy_timer_e82x() begins by
> calling ice_stop_phy_timer_e82x(), whose first action is:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_stop_phy_timer_e82x() {
> 	err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 0);
> 	...
> }
> 
> and TX_OR is only set back to 1 by ice_phy_cfg_tx_offset_e82x() once the
> total Tx offset has been programmed.  The driver documents that write as
> invalidating timestamps:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_ptp_clear_phy_offset_ready_e82x() {
>  * Clear PHY TX_/RX_OFFSET_READY registers, effectively marking all transmitted
>  * and received timestamps as invalid.
> 	...
> }
> 
> And timestamps captured without the valid bit are dropped rather than
> reported:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_process_tx_tstamp() {
> 	...
> 	/* Discard any timestamp value without the valid bit set */
> 	if (!(raw_tstamp & ICE_PTP_TS_VALID))
> 		drop_ts = true;
> 	...
> }
> 
> Is the pre-patch symptom then a missing Tx timestamp (slot held until read
> or timeout, counted in tx_hwtstamp_timeouts) rather than a wrong value
> delivered to ptp4l?  The sibling patch in this series ("ice: E825: stop
> clearing PHY_REG_TX_OFFSET_READY") states that with the offset-ready bit
> clear "the hardware still captures Tx timestamps, but it no longer sets the
> valid bit", which seems to point the same way.
> 

This should be reworded. One note is that any comments or changes
regarding E825 do not necessarily apply accurately to E822, because the
E825 doesn't do vernier calibration. I believe this analysis is correct,
though, and will fix the commit message.

> Could the commit message and this new comment be reworded to describe the
> actual failure mode, so that anyone matching user reports against the
> Fixes: tag is not misled?
> 

I will try to improve the message.

>>  
>>  		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>>  					   0);

