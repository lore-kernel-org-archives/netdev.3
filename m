Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBD502D4A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667619; cv=fail; b=ijCHYSM+LMi4YypX6CoAE1/u/NQyZXOVDNDlVAtyu1wKX96zW3cWiTqREOJWTHMIJIA7oQy3Qa8BBCuyFbsyoYPbbH/dy+8mW/ydOU2SEbpnyqUFmZiRRz+gD5Ef6k2PCfcsd8hg8YY7r8HI0J3h25Ut5QLlyb0rOhV1Ddm34As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667619; c=relaxed/simple;
	bh=CAhlEgEZK20Lr7/zErJ9kzIrFDiDIg2120k3fjCyxRc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fUw1gIrQaaj9PnLjoWqZYqxanHrb6fCYMG1isrN2ZwqHREA4mGPN4Vok+Nvj+3yfLi+SZ2HRmBUGP4V8y4DRt96xLedkZCKQtR7M3fUA0+dhM4xypwPN5/ERFrrSAAfr+CNjzIiNZPFivpys8evj7j6KWw7MepVu1jZSrGIvSIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUYD3y4z; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUYD3y4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789667616; x=1821203616;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CAhlEgEZK20Lr7/zErJ9kzIrFDiDIg2120k3fjCyxRc=;
  b=DUYD3y4zYxVJe2vvObiViwcI3bZFkYFNa59Znw40FwkuG3MMv9ygRBIa
   t/ldS5nJ/xttAd7VunLOvoh2y6P68Sm4H6RM3mYy7dB9/lmr1pWK6r2Dm
   4eXBJfrgXJ5QXRq0Ah+5wzZJFjNJpjrh+xof4R3L7ykdIxb7I192AEfaq
   eJ/xmCK1MTMVfALJDVT26t2WyIgsRz1BfM+NQEWlP+4YUMcbzCreeU5f4
   KaCnB0lMbJ95y5bls3GmoSCj9PVau6JjE6IAzhQOLHFojggjNUm5KMDs4
   dC0beYIlrYUXvpEhACwdnda1hUAg4TMpxVGXDnHW9Mw1JUMZz9Tihy57e
   A==;
X-CSE-ConnectionGUID: oRxcZKpAT4qlqQfNFc9pWw==
X-CSE-MsgGUID: AOzLKSt4T82RCykwHK71+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77683441"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77683441"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:53:34 -0700
X-CSE-ConnectionGUID: ME3f5fNIShGhBsuGDzgTcQ==
X-CSE-MsgGUID: YjxjQA0HTu6L78jpM+ZAvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269658915"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:53:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:53:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 10:53:33 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/P5bpKfuBXTdMM7TQLyWVSCU1xogC47WVsSaP6aUwf1PNaB6FF2d40JLPHWin+UA2stOZwJZD7pj1r5o2e48T3DJNsoOefqoroSy5tC1LSTI97v2yxEXZiSBUvEcCFnVmzF9sd+tnwSIpjBPQRUEpg0lj9nHcPXrdioGmEZSvyVDfj5Ri+1WB+cznp6P21I7RxPgIZeggTR+hPhcqRm9IKklIOW2CxvFjvlEpmJL93Fj6lvieoxgfo6hrNMmi8niBWjpht9f9AqrKqXU09yx9xrdquilYKbHjGBcVbwOWl57O+8XqfuQo/E1lRHsOjq1dh6F9fyKE4e767WkAE4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10/Mei6HXcE/QnSS1qM/ppS++oFODKVqqappVV2YypQ=;
 b=lLDdr+VyoqxHprsF6j8qRogl0+7M5vh7s8Vvn00PbiVSSYy2623x8lNWOppdTRjtdapgVfLQNr/2a7WKhQ/W7PHc/D84/iFDrvTCZS6MLAJW2dQT3ZO+yfsTlTRmsbAjVC3vXOFx7/mHWekGJWbXpvFzKiKAsXcEshGOp7NjFtwZQBTuvHYxEqcN05wRgB+9fo9DdNWmpLtM88c0E/C2OCH32Fe8xmGysGsI9pvPG8JNkJsGYU2fuEeZ4TMRCRRbManm/+afH0BlXaKTvjjvgW/lcsqGyvHS7LRHsfar2J2lV6oBgeFgYcGFuMDcZIlaXvyfh0A55V5MSQChauZJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH3PPF37F43E35D.namprd11.prod.outlook.com (2603:10b6:518:1::d16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 17:53:29 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 17:53:29 +0000
Message-ID: <31a84ab2-a48a-430f-9322-78fdd35297f5@intel.com>
Date: Thu, 17 Sep 2026 10:53:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 12/15] ice: remove unnecessary discarding of
 timestamps after clock adjust
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-13-anthony.l.nguyen@intel.com>
 <20260916011225.1632772-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011225.1632772-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH3PPF37F43E35D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d838e4e-5fb4-47e6-478e-08df14e494a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|56012099006|5023799004|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: cwqbTZwhz81Cvszu7tetgZkjAL9XgMeagogsHgR30SC1XPhUOgiML3zAFtF0IeNVsUWqAzphv/RrKrGL+zHYh/QTGwJWbB9cdsZwABAg1U2S+1L779Kv6hpARHxGL0FzQ58kvJQWef1goS9N+zZcW98wceWXOWheoYq/H/hH682Jb4x2cc18F6qEFUaQEl4u3VZ85XnnVSYongXs8S3HdVEkWDK2oDKJTva3yrByhwQ05j7oMdybGF/tViRz3R1gj1JH6L++p8GASbx2PU/5p8YHmgH8hkK2lERm+GURTfNTZdNHaV9lhmvEqH8Uff+chPG5kqKQTlsc4ZepBVMHg3qRCgt3/MAUM7Q3/yYiJ5i3ZOgeMSnHIiDVLTLDLCrrglPKx7Qq/O+YUEkHRnfddpmyq18nla/BGqAvSZ8+Vjlxo73dL8mpuJjt9OJBCVjW7D9hsJczKfOsL35gCelMJ4wDw4myIDZa6DIfAZfSZ+KQuusTgcKYSGq/8USmP0F9UekcR2PKYihUe9f32cgjy2BvQCJL29UswKXDRAGhRm5zpD039uksDd3GEjudwK+Y7l5R3fi7iKGTK5nwbal18veMD3T22HSVop0LDkYRhyLDMcrZGyOZ+UBHPs880PBzLNafq8SZJy3Jj7VHRTsZ4QVZgligQOyztzxHe9bKAfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCtjajczTzVYYXAyWFNwd2JRNmJBSlFpQzk3N0FUREptMW9hZ2s2MVhmYTln?=
 =?utf-8?B?WlVvRGtpYTJjL1BoYnJWbWpKWHF2ZmdvZXRhcWZoMWZhN2VVeVUwY2dIV005?=
 =?utf-8?B?Z3VHZGVrbDNxWHc5TUswcDdJQmwzK1FNam5Na210azl1WWZQcGdWcnJaUDJ5?=
 =?utf-8?B?YUV4NjFjaUxtZUVoOVZvS0x4Ykk3bVR6UWt2MHI2WDNkSmloZGNmeUJEMVFD?=
 =?utf-8?B?Tkkvb3ZUdmN5S0tJWnBDL1E5Zm96ZVhsRWw3aUxDRVJyTFVEUE9WMlQ4N3lU?=
 =?utf-8?B?VnR6U3o0SHpsRDhMU3I3T3BYUGQvdkJLdXNoTEhqTG5CaGhzM002Uk1DTkti?=
 =?utf-8?B?M21OUE9lS3hOUC81Qko3VGdtcS9mK2U4Uzd0ZDhoTENNa2E1MXdQQ09qV3Yy?=
 =?utf-8?B?ZUhkak4yRkFPYTBZQWdXYmZ3K011aUNRbytLU3pDUFBhVE5Gd2RaNU9Db0tJ?=
 =?utf-8?B?VWxDcW85R0FPUVVMM0RMSjYyQ2xsNkx4ejBjZnRUQ1FqSGtEN294cjhVTGRP?=
 =?utf-8?B?a3ZaQnN6S05ZSzcxSjk0Unl4djU3cDRzeEF1RUNycXI0T2JXYnNjQXlTWng4?=
 =?utf-8?B?bGdYZ2lBN3BZa05QckpNY1VYYnRSZWIwSm9OU1pnb2VIMERVaCsxa09sb3Qz?=
 =?utf-8?B?UFpMUnpNZUt2SVdYN3gvOGVEbG1jZXJ5cjdwQXpIYldHMDkzeU9BdlpOV25Z?=
 =?utf-8?B?bWY2ZlQxZXdmWXJlekZSU1REaVJRSkJIRTFjUTkwTXpnMG41MmhNNXRBU3Nj?=
 =?utf-8?B?N3VFUEpkQXNOS0lSQVVUQVQwK0tFYXExMWUvSG01NmFVRGs5T3Fmcmh1Z2Ew?=
 =?utf-8?B?THRzNnhMN0MyUmQ1cDJrNUJIRUIxeWJxMEV0RlI2aTJIU3M2QWpzc1JOdWFP?=
 =?utf-8?B?dEU1MVlSRE5XVDVpUThxS0FNUXZvMjIrS2x2U09ybDNTeno5VTQ3bUE0aUFE?=
 =?utf-8?B?Q1dkUWxTWHo2YzU2d2tTTnBHRkJIOUNOOXN2amxLMEVxaVJqK1RWK0I5YkF0?=
 =?utf-8?B?UlZDbWdVYkR6VEJkQk5MNnNTdklPZXJieTd3eWdHTHBuNEwzOEMyVEJuTlYv?=
 =?utf-8?B?Y1gyYUtIK25QUDhoOHZOZzF0QjlncjNHVyswcGRPWUFqRGdVT2hzaHVPbEpw?=
 =?utf-8?B?SFp4VXdua1NPYjJsTlNzeENQaGEwWFp6R3pyaHoxTngwZXBJTHFxQ21CSzNn?=
 =?utf-8?B?K0lBbWg1UHRYQjloV2NqdHpiQ2R4Ky9rYnFIUkJRa0JKL1JOS3B3a2tCZUwz?=
 =?utf-8?B?UEI4V1k3MFZMdnVmdGp4RnBwZHhQRUZyNldld1FsVkRha3dxZ3o4ZEdMRFlo?=
 =?utf-8?B?Y3VXMC8xbWRjS080V0EvRk16cXZnUThLWmxvQWQ4TEoxZGd3YVNRcy9qcDRl?=
 =?utf-8?B?ZWs3RmVBeHhWdTlMQXZWTmJWdGdMSzZJYWpVNHN5ZTZOSlB1Q08rZkE3aWFN?=
 =?utf-8?B?M1BPaGJHSzBVWnJOY282b2pFaGtkWFFGaVA2TlM1RzByRTJPVUVkOVRJWmZD?=
 =?utf-8?B?MkYxekdTdnlUV2JpODg0V2dDclpqTUl0SVdMTnhkS2xKdk0wVXFKSEtHMHU5?=
 =?utf-8?B?NmhTaTJ1RG9qWk5CUG5yM3pvYlpTbXUwV1lJSHYyV0ZmRU9NbnFnSmNkRHpC?=
 =?utf-8?B?cDl3ZmkyM0MzMmdIYllzMWphMVhsRk1aSGtpbFYzaWQ3KzRjbUtkSzNGTzd1?=
 =?utf-8?B?WkxvNkR1bE41S0ZMc3VHSWxqdlZFaVlOSGdkK2JtRCsyL2t3ZjBqM3VqRGRH?=
 =?utf-8?B?Y1Fab2grT29DVjlzUlZ4SzRXa3NhMVluQW00VzBqNWFLVE84VGpaVHp6SlhX?=
 =?utf-8?B?TWFzYTlJMXdaNVhGUnVOUCtKeUJJNVhMa0F1b25HNHVuckI0bzVyQ2FSdUY0?=
 =?utf-8?B?UWNsVTJaYm45R09xQ3ExTmZYSC9iSjFMRDlobEt0OEZISDZmK0F6a3R3ekJk?=
 =?utf-8?B?OWh5YllOclVCaHpzanlDaEdYV244UFdvdFJJWnNWTng0a1hUT2ZxQTVxSkd5?=
 =?utf-8?B?WXNMYjREclU1aTZvUUVRSnd2R2JyOEFqN3RwUmdQSi9YSS9kaFpwL3JtOHFs?=
 =?utf-8?B?dzlhLyt1OXYvYVdWY2FYeGF4VDNYSml1WGdIOWZPYmdKcldvRGcrMi90d3VE?=
 =?utf-8?B?U002cmk3cWZoVUkvQlZUU2FSMDFMbHJJdUtWUEY1bEI4VldWYldFUWluZzFT?=
 =?utf-8?B?MzNRR3dwZmhtSk11Ukt3KzZaM0w0cTlZRVE5RUltZ0RwYWErWGRQRnFDcGtv?=
 =?utf-8?B?V1Z4NjUxRFBDK2ZnVnQvS3ltRlNHVm5UdXp2YW1EaEtaemJYdHJ5MndGQlF2?=
 =?utf-8?B?Z0F0TWMxa09GNnU1c1krR1BBT2xZbWxreHdlbmFRUnFEUzlhZFdGWWxyR2dH?=
 =?utf-8?Q?U/l2NjZ+urM4jiLQ=3D?=
X-Exchange-RoutingPolicyChecked: CKIRPG+JKUKrjq27ExM9ZrSgaJ7OQWTEWWHkZtAcFomx+g2Sdtzqop+50JOzi5hVx5CQFS1u5PdogIyrugYVCrZzcgsSxEh37D/3Q336eJIVaV5rtfKkL1uqW+2UxuJsr0qkz527AQmk6pJB07h811GgclGyIh1AEKlQhOZVNDw89fmjFINBhuXs9cHYjmKVJs+Cu3GmgjzsdIIHMWzw/uJZAhyQTnx5eqY4C7vZVPH+PtWDyISBM6JnYFYi1c83pJDZ9Lm7IBhB9UUrk13yCXYehRm7TZLGzmas25SPMr7PsEohIcJB5kShYGXorkO6qR54UJn70UbKRZIHda67RQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d838e4e-5fb4-47e6-478e-08df14e494a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:53:29.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptOZfrGalGAbK6paM22BCNamVHRX8yDyN+r8GAakxWejU27QqKZuCXfO9AwEQgLCpmYpOVEV85B8YQ9948ugiqHxwPae7Nx8mclbdlksFsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37F43E35D
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: remove unnecessary discarding of timestamps after clock adjust
> 
> This drops the ice_ptp_mark_tx_tracker_stale() call from
> ice_ptp_reset_cached_phctime(), so outstanding Tx timestamps are no longer
> discarded when the PHC is adjusted or set.  The stale bit itself is kept and
> is now only used by the link-down path.  The kernel-doc of
> ice_ptp_mark_tx_tracker_stale() is updated to describe the new meaning.
> 
> A couple of questions below.
> 
>>     The original motivation for discarding timestamps was that extending an old
>>     timestamp using the new cached value of PHC was a problem, as it could
>>     produce incorrect results. The change did not describe what such "incorrect
>>     results" were.
>>
>>     There are no such incorrect results. Extending the 32 bit timestamp with
>>     the new time value just means that the timestamp is reported in terms of
>>     the newly updated and adjusted system clock.
> 
> [Severity: High]
> Does this hold for the .settime path too, or only for the atomic .adjtime
> path?
> 
> ice_ptp_adjtime() only uses the atomic ice_ptp_write_adj() path for
> |delta| <= S32_MAX:
> 
> 	if (delta > S32_MAX || delta < S32_MIN) {
> 		dev_dbg(dev, "delta = %lld, adjtime non-atomic\n", delta);
> 
> Larger deltas, and every clock_settime() on /dev/ptpN, take
> ice_ptp_adjtime_nonatomic() -> ice_ptp_settime64() -> ice_ptp_write_init()
> -> ice_ptp_init_time(), which replaces the 64-bit source timer with an
> arbitrary new value rather than shifting it by a bounded amount.
> 
> The PHY Tx timestamp memory keeps only the captured low 32 bits of nominal
> nanoseconds, and ice_ptp_settime64() only restarts the PHY blocks on E82X:
> 
> 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> 	if (hw->mac_type == ICE_MAC_GENERIC)
> 		ice_ptp_restart_all_phy(pf);
> 
> So on ICE_MAC_E810 / ICE_MAC_E830 a capture taken just before the step is
> still in the PHY bank with its ready bit set when
> ice_ptp_process_tx_tstamp() runs after the cache was replaced.  With the
> stale bit no longer set, that slot passes the drop checks and
> ice_ptp_extend_40b_ts() extends the pre-step low 32 bits with the post-step
> READ_ONCE(pf->ptp.cached_phc_time).
> 
> Isn't the value produced by ice_ptp_extend_32b_ts() then the alias of the
> real event time nearest the new clock, i.e. off by (step mod 2^32), which is
> up to about +/- 2.147 s and can even be dated after the new PHC value?  The
> same function documents that this is outside its stated assumption:
> 
>  * 2) assume that the in_tstamp was captured 2^31 nanoseconds (~2.1
>  *    seconds) before or after the PHC time was captured.
> 
> Separately, is the reverse branch safe when the clock is set to a small
> absolute value (for example phc_ctl set 0)?
> 
> 	if (delta > (U32_MAX / 2)) {
> 		/* reverse the delta calculation here */
> 		delta = (phc_time_lo - in_tstamp);
> 		ns = cached_phc_time - delta;
> 
> With cached_phc_time smaller than delta this u64 subtraction wraps, and
> ns_to_ktime() then reports a negative hardware timestamp.  Previously the
> stale bit hid this case; now it is reachable.
> 
> In both cases the result is counted in pf->ptp.tx_hwtstamp_good and handed
> to skb_tstamp_tx() rather than dropped.  Would it make sense to keep
> discarding outstanding captures for the settime and large-adjtime paths, or
> alternatively to restrict the claim in the commit message to the atomic
> adjustment case and note the trade-off (a wrong timestamp delivered instead
> of no timestamp)?
> 

Ugh. Yea, I think that analysis is right. We still need this for larger
adjustments and I think since we haven't had too many reports of missed
timestamps that it makes more sense to just drop this change from the
series.
