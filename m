Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA54C10C4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662754; cv=fail; b=Oio2k0aaGSd1Ppuy6l3trcKzsSvr+7hzQgVoTh/KaLhw1oB1f8Gwy+VoJe9hVisltggJkZ4BUM6mew//smfFghpRuOFxux0kjlVMTyCnjuqHkPYR0QmcvyGVFhTesbLVpQDC/GMVnFEVVVnCAVKk+RNes7/zFJ9AVqK/+/6cwXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662754; c=relaxed/simple;
	bh=Qi/6dKQ5ZYOUZyw55v1jZy+Qz2RbxRJ39qBMSeUKBMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oE8PVm8nKAfzaQPW0OwW0CB5Rn8djgvnkt5QeQH2o5npr1ViyoiDxxBOP8sig9KANUqxDf8d5l9B2rqE/hJ0Om+6XRaOEF1EI6lsuALVKkqrRova7QbYl4gu79gQiOM8DJdzozPCGg4ZjnmCEd9RQUYc8VV6Tr+HeIsm9ow6QRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=map87Zbw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="map87Zbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789662752; x=1821198752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qi/6dKQ5ZYOUZyw55v1jZy+Qz2RbxRJ39qBMSeUKBMQ=;
  b=map87ZbwzLL3O8TbZ8z3zVAlxZj1/aapyXY7TDna0+Px59iq9Afa2lOV
   NE5+fbU4lM7vX8rfigSH67+GEdFtXB8kOalxWo+luNJQLx78zdCcLJuiY
   yL+a/7+8xLl/RcuW5J/C/WMCgN3vTrFXWT5ACKH6ciEEDbacgu2ahdZoa
   cb+XmLdhZ4olq0E23y/ZRrKdioDeRy1TXQoNi+JkdhphOugqkv4N7sClv
   J18UmlHBt3SexP0nnTE8anTwoC9gDArES3vLUlC6YDlrCbjOytLOww1Dl
   iZDNonLu2JjFmUIIniRasRcKFG/fcP+RZL2BzC9y8FJHYjapxWTXWE/UQ
   Q==;
X-CSE-ConnectionGUID: aMA/iBNPR8iQl2bnTSw3nQ==
X-CSE-MsgGUID: PbNUiFDISaexA22mHD4+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93935917"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93935917"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:32:03 -0700
X-CSE-ConnectionGUID: c4ZNXaWFSZKCO/LjQhrSuw==
X-CSE-MsgGUID: XrPYRRKuTKeK5faH0aOF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297385514"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:32:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:32:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:32:02 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xESupYbVmcI8nzDMOcNCp4bbkxZUpmDYsy7uD0lHv/un5lIL3EgnVW4V+ZpHTzRsrG5FleNHMlij/je3tbUc2LScx+kKmhqiZGChkKNGXs0FicCA9u4BcOp65tH6W+vLkQBLSjc9MoFw4VgiDJC7PPoPUC8yn1eNrsRRLiNSjfYOwrCyxhqlGpGySbCv6mSonNsIsbnLDtxkzc2dG9ryd1s3KThJ/dXl72A4OZPmdIqjMU++zP7Of0RYtZDUmsPEySNiDDtncFRDwBkrmhod2V4M0Dl9XKWewFBapLHBeYC1fNnabDzOr2n6i2G6/TmLtXHOFwSWY00RGDcjgH0+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I1G95JniG4pIBmWa1TR2cFjyYLMygFSqK83Y8aQoes=;
 b=TVU1k0Z0GmMuK+uSKiPwgu4KmgavbugRR2oVrfCMUWI215zuuPQlTnKqhvawdYpOAyGkAe7m8DRa5A2CRgne1hVRXziQQ523t9UJ8lkPyVmULRY2q2i++CXhHaAUCjcJ1u4I8B4GcdZoleR4/kjXfblP745Z9N36np5ZKJB8daKJlt4a9cUvcw2kHdwKw+uc0tud060Vp9OZjZFFyxkEnRLwsh2V6OEetOJClhpQUjoNxgD7oglljiuflcsh2qRocc5lwzV7amnfGtvb7WQWqF4GVFwS/XzMIb+ST7J+SENdiKnSX2bDUyB9WlpUcXpwG6dwcEomaaInUH7o44lnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 16:31:58 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:31:58 +0000
Message-ID: <098b8650-1c43-41d5-b0e5-bc8d73cadfc4@intel.com>
Date: Thu, 17 Sep 2026 09:31:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/15] ice: E822: cancel offset verification work
 during reset preparation
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-6-anthony.l.nguyen@intel.com>
 <20260916011216.1632452-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011216.1632452-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CO1PR11MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 442abe54-0af0-453c-eb65-08df14d931cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: izvqHv2rOHOgInrWeQB+kml66MXo3o0iM2Lx0GZD24RwMVSKFtJRUnFmxFc6kxv9B5Pc/mZf18bts1d/e8JLQLkfNG1h7q6JKcRmH5yXFEb1DNDu8qgvvpl4qBJRJZ++BcWZSgVeLwaM/LESwJlvAoJtkEumWNC+mlhMLqRNe7kjcK0B7zHOwy/vdU4n/2aFYjm2erbkPX+3K+vGVEahD7jbz/E++wDUsnY3LRiihu+fhYB+2PH8+wOgryBtTimZdbxjhjUJU+lIqaAsambVqrWPR0MlV0xCENiUvjD+zzcFERalfG14VIY+FwXHdSXIr0URt7nnwz61IDijsoqEO7GIEb3h11YoScRhGMqCDAe/UlXgrWaHEdeYa/1wwcuNoWfCJS+ROlIzJpXEum7CxXzvwvNXbwAnMqZO8YmnNZkq0IgvBP1kLjAFOH7ODaEV4BLvxn/HK+IjGr+62SiJAQwLBV00VGEAcpkijDooE243mnbe+a2RneP19vKxWLk4oMxBhLM+A072RRCZAvv2ukMPEQlFhwh+jpFXzZugFn3YkuJVYWaD98ZocvRkBzAFLgiYU8CZcZAq93PjiV9svxkUmpGvbsHNi/JCPq82kSagYNGRbURY4KA4QnROctteU6R+ydr+OzKgNbuMmBOSpXtuJAelJeg8d2FtetG2sO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVLYmdvSlMyVUFrNjNmZVlZTHkwYk1qTkZMR0xWQnBvdE5ZMzNkaVRPKzJF?=
 =?utf-8?B?ajlJTXFGWnhLUEZ4azNTaEN1M3VBek9QL2oyL0gxQUlIYzJCNk5peklyUVVK?=
 =?utf-8?B?NjBCbW1OU2Z2VFc1SENlNkdMSy9LTUpPeENjMkhhQlJUZUxpeHRQYUlJN3Vh?=
 =?utf-8?B?NVIyS0NZYlJoRnZpWUt6d0dYOWhPVkh6NXBOMEhKNjBsbElRQ285Y1hPSXc5?=
 =?utf-8?B?cHRWQjUyTHNRRmUyNHYxQ2NZUVZYV0pkNjJMUzlXRkMycDIvemVkcCtnVmh4?=
 =?utf-8?B?eTIzY1BlUkx5UUNWMU1RTG5SZEVNcXQ3c25mSFIvc0FHSFVTS0t1K0NvbG15?=
 =?utf-8?B?blAvZGIyNkhqOERBd3lkOHZJYW5aVkt2SnJwWDdQSklUUWIvVHljcDJCVXVp?=
 =?utf-8?B?WVBHRkxTc2pMeE12MXpoL0JhRUVUNVhyWFYreFFBaXA2YXAxV3lURU9qa2Nz?=
 =?utf-8?B?c0JHdXJSTnVyOVlEdkFpaGxGcHUxNjdyM0tHaHo3QTJMQktlM0ZKQk5sTk5K?=
 =?utf-8?B?ZUJEc09GMzJiYWRxaWRkUXpIeXZWYVcwZ1VTNHltTVFFS1dUOCtQUm5vaURY?=
 =?utf-8?B?MnVXdjFmZE1JUHA1MVA4MzdtZDdkVHptczJNazBZMWVSSkQ2RE1STmRIMU53?=
 =?utf-8?B?QkJxMHhDOE50OFcrb3gwU2ZERXU0QzFyTXlZaW5SemhpMTNNUUlaRUZUTGxO?=
 =?utf-8?B?U25sQXdjVnVxVjZhckxjT2JhZnNLZTJEazlHTk5hdE1weTlTNC9qMmk5K0VF?=
 =?utf-8?B?RncrNU9qcWtZODNLSUdnUE9FRXVPR1Y2QVNDSURnM0czNmgvRGpwUkFLNEcx?=
 =?utf-8?B?ek9CODBQMGtNcXRTWWpQTGJ3UmJYVkE5NEt4ZlRSdkJreWI5WXJpaVROSEhD?=
 =?utf-8?B?ZWRCQnZXR2drbUV0L0V2MW5FTFZhSko4MG1sSzcyd0FNY2NETWNyWDhETW94?=
 =?utf-8?B?N0R4Z0trUHloOGhDNlZ5aWZiK216VkdsbUpxeEtDK1Z2dDZYVDFtOWVQMW9s?=
 =?utf-8?B?QzNpL3UwZjNIYlVBSFFyQUR6R2k5aTZHS1N4OC9pdUE3MnAxeHVFbTNXbVJZ?=
 =?utf-8?B?dUFJemg4WE5KcmMveG80ZWZ3MFRRUUo5dHE2SWZhRlFjMlNiOGNtMzZ6S05j?=
 =?utf-8?B?Z1czKzNyYzhlUkJsZUxvQ3VVbWh5Nk9LenN1TEpYU1VnU1B1TmlxQkJIeHpl?=
 =?utf-8?B?alE5a05tNGFUWUhCSXpWQ0dZdGtvRGtYWWlSMnZRb21WTnkrUHVZR0pnWC9O?=
 =?utf-8?B?MnBwaUZ5SS95V0xFODJsZkM0LzA4WmpwWTRTYjdMTmxqb0c3NUxWUnFCU0Y4?=
 =?utf-8?B?b2x1S1lzekY1QjV2V2FVaHIvZzc2SmRRaGFic3Q5UC8xMXd5Nmx3a1lwNE15?=
 =?utf-8?B?bElXbEkramZxeElJRzVNMEQ4VDVxNHluNHY0Uk1iUklIRzF6ellwb3FEZEdJ?=
 =?utf-8?B?V253dEFmT2xhZXBHa2wwak1FZ2tKNHpxM1krcmJqbi9HTktSdm1FaUxPYmZa?=
 =?utf-8?B?d2tCUjVHQ0R0NlpaQ3VTeXhpS3NmVDN1SC9TRlQyME5reWFrK2hCd2c5ZUMr?=
 =?utf-8?B?QWxDMFVsT0wySFNRU2hCZFV5S09ZVXVncWVNeDVNZFBhRTNYRkJ4MDA4eXNL?=
 =?utf-8?B?Y1prSWhaVDE2Z3FKNFRkSlR0RHc2YlpGb1FVc1RkNzhza3pldlNRVWdiU1hP?=
 =?utf-8?B?MjNOWjQxQm43Y1lTNHA4VlhVMGpBb1BCUmhNejRDbWlzQ3U4OVozZTZOU2k3?=
 =?utf-8?B?SlB1dzJMTVp1OHdsNHhhb1Bkb1RYTjhwYVB5K0tLTTRTWGU5OHVTemlzNXor?=
 =?utf-8?B?dlFrdEJSNlc0TFQ0WUpyY3FSQ3BEN0xLT0xxKy9VaWJxNmhTSFVUS2hYcWYw?=
 =?utf-8?B?UE5yQTU1VUNqVWNES1BjVGtJdkZURFBsYVdyZi9VQWJsSlRxWDJmYUo0aFhF?=
 =?utf-8?B?a29TQWF3U1I2aHVMcWR2YmhwUGtMY28yNjZTaG0xeFBUcmhYeGU5TjFsd2xU?=
 =?utf-8?B?UFgvdFl4MFI2eVRKVmxBdG1FZlBJenptOFFMaUNPd0pLRG9XZTdXUjgyaHNW?=
 =?utf-8?B?K2kvNmtWMndzNGtEMEFRdkt3MHNTVVFOODR0MWtoeG1TeTJsUlcyNDQ4a3Nh?=
 =?utf-8?B?TDViMUhDcVFkNEl6WGpzeStyQUFJZis0VGFjNzhCNTkyL3gyWWtZSUxXZjlt?=
 =?utf-8?B?QXJqUnlmSFBiRnN6WGJpUFBoZWRMMjcxUzdxVnAwK3ZqZlpIeTNJWXZjc01P?=
 =?utf-8?B?aXZtVFczUXhzV0NsLzFHcGVreU9QeW9MRXVQZ1VWdm5iYjNSVUFJWmhqK2VM?=
 =?utf-8?B?T0tvU3RNak9ySmtFYUp0U000L2JrTFpkajBOR0EvU2tiWGcvS2V4bXYxc2I5?=
 =?utf-8?Q?QQEz1nFpbaak1PAk=3D?=
X-Exchange-RoutingPolicyChecked: x49c81+Z+R3BdasPv0DEmBuB7LNZ2ex2tqhkP3cnyqEDi1uzHtgLb9hQRmtoYhwEAZ584+3LF1SmKK0UC9sCNpf93dr9fTbS9m3TgsAINnVhW2cGiQOzhd8/VXSZtKGHrrzQb0/VBtAMXACSF1AJ/Kjy34k064SknFxJ7m7ex3DHfXP5R50vhytYe2e4OLK11UP/mhPKBbPjepdsNLuRYKWk6q88EEVvyoy3hjFCQGoTNACNxOD/kRyQw9UnTJ8npZWy9wMXl7pNn2LF9koqNbWfw+CiDjkvptgsL/UQvtRnkQN3DdwtOlVMEBB7YyeOG0K4qvYhhzWaLmw+pVQDoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 442abe54-0af0-453c-eb65-08df14d931cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:31:58.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nacEiEEvNYbw+iMeLWv3Osz2/y8sdzDrotQe9CffbMYcfaPRNmrfc3wDEQMK8vz7eX8EIkzdwvt1eyH2an8vhV/IAsxZGV2Tdiqyn43qTUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: E822: cancel offset verification work during reset preparation
> 
> This adds a kthread_cancel_delayed_work_sync() of the E82x offset
> verification work (ov_work) to ice_ptp_prepare_for_reset(), so that the
> work does not run while the PTP reset sequence executes.  A few questions
> about the changelog and about the placement of the new cancel.
> 
> First, on the described failure mechanism:
> 
>> Without this, ice_ptp_wait_for_offsets() can execute during a reset,
>> find that ice_is_reset_in_progress() is true, and re-queue itself in a
>> tight loop. Meanwhile, the reset path in ice_ptp_rebuild_owner() calls
>> ice_ptp_port_phy_restart(), which starts a new ov_work. This results in
>> two ov_work instances running simultaneously, racing over the PHY offset
>> registers and the calibrating flag.
> 
> [Severity: Medium]
> Can this sequence happen as described?  ov_work is a single
> struct kthread_delayed_work per port (ice_ptp.h, struct ice_ptp_port) run
> by one per-PF kworker, so the same work item cannot execute twice at once.
> 
> The re-queue in ice_ptp_wait_for_offsets() also does not look like a tight
> loop, and it returns before touching the PHY offset registers or
> port->tx.calibrating:
> 
> 	if (ice_is_reset_in_progress(pf->state)) {
> 		/* wait for device driver to complete reset */
> 		kthread_queue_delayed_work(pf->ptp.kworker,
> 					   &port->ov_work,
> 					   msecs_to_jiffies(100));
> 		return;
> 	}
> 
> And ice_ptp_port_phy_restart(), the only site that arms ov_work, already
> cancel-syncs it under ps_lock before queueing again:
> 
> 	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 	...
> 	kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0);
> 
> Could the changelog describe the actual window instead, for example a
> worker instance that already passed the reset-in-progress check and is
> mid-PHY-access when the reset starts, or one that gets re-armed after the
> new cancel?
> 

Hm. I'll update the commit message.

> Second, on the Fixes tag:
> 
>> Fixes: 4809671015a1 ("ice: Fix E810 PTP reset flow")
> 
> [Severity: Medium]
> Is this the right commit to reference?  git grep ov_work at 4809671015a1
> under drivers/net/ethernet/intel/ice/ returns no matches, so the E82x
> offset verification work did not exist yet at that commit, and the code
> being changed here is the ICE_MAC_GENERIC branch of the PTP reset flow
> rather than the E810 reset flow.  Stable tooling will use this tag to pick
> backport targets.
> 

I'll check. I'm not sure how the original author landed on this commit.

> Third, on the reference to an existing cancellation:
> 
>> Cancel ov_work in ice_ptp_prepare_for_reset() alongside the existing
>> cancellation of the Tx tracker. The comment in the existing code already
>> documents that ov_work interference during reset is a concern but only
>> cancels it during ice_ptp_release().
> 
> [Severity: Medium]
> Does ice_ptp_prepare_for_reset() still release the Tx tracker in this
> tree?  The ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx) call that used
> to be there was removed by the earlier patch in this series, "ice: fix
> removal of PTP timestamp tracker during reset", so there is nothing left
> in that function to cancel ov_work "alongside".
> 
> Which existing comment documents ov_work interference during reset?  At the
> series baseline the only ov_work-adjacent comments are "Start the PHY timer
> in Vernier mode" and "temporarily disable Tx timestamps while calibrating
> PHY offset", and neither mentions reset.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index d018f02f700d7..9bf3bac552f11 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2998,6 +2998,14 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  	if (reset_type == ICE_RESET_PFR)
>>  		return;
>>  
>> +	/* Cancel the offset verification work for E82x before releasing the
>> +	 * Tx tracker. If ov_work is running during reset, it may issue
>> +	 * sideband queue commands that will fail or timeout, and may
>> +	 * reference state that is being torn down.
>> +	 */
> 
> [Severity: Medium]
> Same point as above for the comment text itself: ice_ptp_prepare_for_reset()
> does not release the Tx tracker anymore, so "before releasing the Tx
> tracker" describes an ordering that does not exist here.  The only
> remaining ice_ptp_release_tx_tracker() call is in ice_ptp_release(), and
> there it runs before the ICE_MAC_GENERIC ov_work cancel reached via
> ice_ptp_port_phy_stop(), i.e. the reverse order.  Would it be clearer to
> drop that clause?
> 

Yes.

> The second sentence also mentions sideband queue commands, but
> ice_ptp_wait_for_offsets() returns as soon as ice_is_reset_in_progress() is
> true, before any sideband access.  Which state that is being torn down does
> the work reference?
> 
>> +	if (hw->mac_type == ICE_MAC_GENERIC)
>> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
> 
> [Severity: High]
> Should this cancel be taken under ptp->port.ps_lock?  Both existing
> ov_work cancel sites hold it, and ice_ptp_port_phy_restart() holds it
> across cancel, PHY start and re-queue:
> 
> 	mutex_lock(&ptp_port->ps_lock);
> 	...
> 	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 	...
> 	err = ice_start_phy_timer_e82x(hw, port);
> 	...
> 	kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0);
> 
> Without ps_lock here, can ov_work be armed again right after the sync
> cancel returns, so the reset sequence still runs with ov_work queued?
> 
> Two arming paths look reachable during the reset window.  One is the
> PTP_CLOCK_SETTIME ioctl, which has no ptp->state or reset-in-progress
> check:
> 
> ice_ptp_settime64()
> 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> 	if (hw->mac_type == ICE_MAC_GENERIC)
> 		ice_ptp_restart_all_phy(pf);
> 
> The other is the clock-owner PF on a multi-PF E82x adapter, where
> ice_ptp_rebuild_owner() -> ice_ptp_restart_all_phy() walks the adapter port
> list and arms a peer PF's ov_work:
> 
> 	list_for_each_entry_rcu(port, &pf->adapter->ports.list, list_node) {
> 		...
> 		if (port->link_up)
> 			ice_ptp_port_phy_restart(port);
> 
> while that peer PF's own service task is inside
> ice_ptp_prepare_for_reset() on another CPU.  There is no cross-PF reset
> serialization for E82x, since ice_ptp_prepare_rebuild_sec() is gated on
> ICE_MAC_GENERIC_3K_E825 in the following hunk.
> 
> Would doing the cancel inside the ps_lock critical section, or simply
> reusing ice_ptp_port_phy_stop(), close that window?  The ov_work callback
> ice_ptp_wait_for_offsets() only takes port->tx.lock with
> spin_lock_irqsave(), never ps_lock, so taking ps_lock around the sync
> cancel should not deadlock.
> 

Makes sense.

> [Severity: Low]
> Separately, who re-arms ov_work for a non-owner PF after this cancel?
> ice_ptp_wait_for_offsets() is the only place that programs the vernier
> offsets and clears the calibrating flag:
> 
> 	port->tx.calibrating = false;
> 
> and ice_ptp_is_tx_tracker_up() gates every Tx timestamp on it:
> 
> 	return tx->init && !tx->calibrating;
> 
> At this commit the only re-arm during reset is ice_ptp_restart_all_phy()
> from ice_ptp_rebuild_owner(), which runs on the clock-owner PF only, for
> non-PFR only, for link-up ports only, and can arm a peer PF's ov_work just
> before that peer cancels it here.  Note this appears to be resolved by the
> next patch in the series, "ice: call PTP link change only from link
> events", which adds an unconditional per-PF ice_ptp_link_change() call at
> the end of ice_rebuild(); with that in place every PF re-arms its own
> ov_work after its own rebuild.  Worth mentioning in the changelog that this
> patch depends on that follow-up?
> 

Yes at a minimum we'll have to reference that, possibly re-ordering the
commits.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the state that
> ice_ptp_prepare_for_reset() leaves behind interacts with an incomplete
> teardown path.  ice_ptp_release() early-returns whenever
> pf->ptp.state is neither ICE_PTP_UNINIT nor ICE_PTP_READY:
> 
> 	if (pf->ptp.state != ICE_PTP_READY) {
> 		mutex_destroy(&pf->ptp.port.ps_lock);
> 		ice_ptp_cleanup_pf(pf);
> 		if (pf->ptp.clock) {
> 			ptp_clock_unregister(pf->ptp.clock);
> 			pf->ptp.clock = NULL;
> 		}
> 		return;
> 	}
> 
> ice_ptp_cleanup_pf() only removes the port from the adapter list and drops
> the kref, so unloading the driver while the state is ICE_PTP_RESETTING
> (set here) or ICE_PTP_ERROR (set on the ice_ptp_rebuild() failure path)
> leaks the kthread worker created by kthread_run_worker() in
> ice_ptp_init_work() and the tx->tstamps allocation from
> ice_ptp_alloc_tx_tracker(), and does not sync-cancel ptp->work or
> port.ov_work before the devm-allocated ice_pf embedding them goes away.
> That branch also leaves state non-UNINIT, unlike the invariant the comment
> above ice_ptp_release() describes.
> 

I believe this will be addressed by other changes in the series.

>>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>>  
> 
> [ ... ]

