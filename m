Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D67387359
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323402; cv=fail; b=Xnl12DravBgsf9AZ2AuxjR44X1Lx1Twkzz3Jdkv4Dd/qP8tCrwnuUBMu0U85cfMqtEIR+StQ0G8SurD1IGg9pqfeDFm+Ykn8BKXVl7KpofEiQ8w/+r8ExnKoCnI12VzP1i3ewCdiWXKPaL0UoO7rPZHJJ0mvGpCoi9jUqkEnDFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323402; c=relaxed/simple;
	bh=cDYT+tFtby2okuyaAg27lACUZHEpcTEuro86BR2GElk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FBX3ZUKxJBw9jG27TQe+TAXzC9znTrTiBWPcBsPmCIwNz35lJvuRSaLPVWDex2dH4c9RXCQjiGdcLumsXUxcAblGmcsOE4ogFRGqgE00GQ5At9/JiCvR/XDWbvnz00kX2ngC+BbxB9y3qKy2IHI84/HdrUTKYeOJ7hDXoQUA34M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWAc5DHN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWAc5DHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791323400; x=1822859400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cDYT+tFtby2okuyaAg27lACUZHEpcTEuro86BR2GElk=;
  b=YWAc5DHNom6OP9R9Eodtvlx9TAaGDo07og5b9pIK3Sq2I7DtllDa4J28
   FgbOEP6WP35UQ+ptxemie/KJiC0Xg4Vl5OqCO9gp4e0W22sQIBJSN5cGp
   ifxovCPN1LXTljuVP/zqs85g9GcrALA10j4McHk/H6GsRpDQwN5dCVZWL
   JTKz95DuEehIAWKMQAbe3oo3S/ZX+U8WkShR9ovpUS7wD4fOph+Gr82It
   XHV7rh7YCq1EwL69zuUBIQk1QcJ/FAaz6e+CokJIRkOKSasRcZrhn1jZ4
   VbHkYkfxw3VYP0qXGmG1NG7pOrfkDYRiraNJ6AOvn6+Bhvh5ZrSDWdk9K
   Q==;
X-CSE-ConnectionGUID: jvxPwVZ8S+GXt/QZNe54wA==
X-CSE-MsgGUID: x9rcXB3nTiWRr5TdQJpNhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="67467"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="67467"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:50:00 -0700
X-CSE-ConnectionGUID: rAT5RmtrSyii1DHiilFT7Q==
X-CSE-MsgGUID: MkS0D8PeTn+2Yf5j2q7Mqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="275056656"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:50:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:49:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:49:44 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDpUstXXO3+PLWLRjAV/8g7p7THaoXJA8ePx6CdhyhJEjSu4qFaospjtbo5kPkNiNBiKW3hG4yxsIKsQ5xsJ8pYfgjyrTLKtuQIbik0qxwdz/j8vUW56Zz9++TqHXKE2Wpd6SatH30ZVG0gl6XNEsbPHPXVM9DkXjL+pYRCVS5Zf2EsV4pjeIYfMNRRtv4QzAxt6DNW8O9Z0Lvl5MP5FHdfdSe74SFjgDfej8eOAVDsb39iRPaellbU05NyvDcuW6XH7XHDeHpF+KZNgAomMTz3wLmhpVSq9aLCKzOdJySVoKFNmxOYOvNH7u5LeRiXV0CKNRcDtWyDa51LrdDTvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8ZMrdgwkayiq6C97l9Rd6Mdp9AFEl1YrYdaOzleJzg=;
 b=C8iKboNiA1TjPsignZQJ8oxEFUeRhdmK7xbB4G7GSRrPtD8Msoih2RH6r5g1kaNj4Di1n78W3tDSGauTkZ0HB7D/QVgTnM2OOngHmdAoNpSXVr+yUgkVtDsFSiLv17GHpwLz2FmqXmeTQsXrCnfEHoH5CS2V6Z7Rg27Ec4A3Gkn0mDwotYAjnEUxNWS21RJAzNZCm8n92P9kTr7b+/MmUMBvFTVMOh2BKrjxE1FyNzKwp2SFlaK9PhnHXb4tGXz6m5aL6TIanBWhd+JtoJI/4XMQ53L+SylYScTKdnpqYngyTARZwQ3T+ybpJVj2cCaSNfKdFqcpC7DiDeGm+1YDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 6 Oct
 2026 21:49:40 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:49:40 +0000
Message-ID: <4be5dec9-9390-4409-b26a-2713031df89e@intel.com>
Date: Tue, 6 Oct 2026 14:49:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_flower: Fix port range register
 leak in tmplt_create()
To: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Wentao Liang <vulab@iscas.ac.cn>,
	<mlxsw@nvidia.com>
References: <cover.1791294384.git.petrm@nvidia.com>
 <95339cf970ce78e1a74aa86ffcc104ecf7c7762c.1791294384.git.petrm@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <95339cf970ce78e1a74aa86ffcc104ecf7c7762c.1791294384.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:303:8e::11) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e5a057-57ab-49ad-e736-08df23f3b945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|18002099003|10067099003|4143699003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: dL+zA4L6FN/lp/18RLS7VwxkcO9faUYJNWN90HgMuZZIFBASQls8lwuL8jliFhlajvlE0W2vU+BXzaF3pSYgUdeokn24cgGq+VCQDu1lunWuWU2oeWalA07Ey01SLBrp3yuxl0aKEts8Bhy42pUm98tQnXX3IrEIHr57Ur8x7Z5D1FBOr4l+4FXmenvH9eblfybgWq4lE6llsKYpCZugmQaBsmUm44bXbq7eGIx7hsmZoYM2lS5MGVVetZtLzKLiJOFWlVlc5R8WRvcst6K3jz061MIA08oMrFhNXtN0YQlycX6KAqE427Mcz4JmWD2l4S8WLM73t7/h/13760HTdkd/CSWdntAc57WjJIiix+9JS0juaQI6DxvFS717RoaIVHjmT+vq5PImwqxajIyBeEM7C3fDvMqzcm0s8/uDrJmCC+JMgewDFG9MDAJWfl4G4SifCdQ/DdVNuWSkzxDvKJu1lIrir9KER5tclU4TnnyjEn24y66hyP2nIsKLPIWOOl3PkQC9NRCu+wA11GAZuEeNDUjEf5GSIAnp70f0bRJxPm3MHAHcNKWWN1FhXJN27Vv5md4gVBBuQ6wON8KkY/sFeDAU2DYtCQy3TY/v0Emcw9bI/YA5v0wtE+rm+eQFPGxeQftree8I6eJmOTKv90wHifk3PJxmtfE7glFgmDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1M1ZFFyUk9JTWpmV0NsQm9la0ZjblV0Q0JLNlJlaFVLbGxSVlNKMElnSVZw?=
 =?utf-8?B?bC9nZnBMNm4zV09yRllzWExVcUNsVWd0RHZ3M05QaTNVS1VVaUJ3QU45RHBN?=
 =?utf-8?B?QlpBeG15c3lpMmRvL2lWK244Z2t6U0xleWNObkJDK2o5Y3dKR09UU1Q1SlhH?=
 =?utf-8?B?eEVWNVYzVkhDQ2RHd0trV3ZCVW1IcWwzNUZ6clFKTlZxdHp6eUs1S1REeTUr?=
 =?utf-8?B?TE9BYVNyQld4dC9YR3c2a0tPZUxTSDNqcXlwNXZ2cEVnRjFEZEhzbVFqbmRz?=
 =?utf-8?B?am9FMGw5dk9zaElQeWE5YWIxcEdFVGZCNkY2SjVMYjF1WkZyd2xxZzVHV3dt?=
 =?utf-8?B?WlhrcTlncmluWTZjVW9OSjBETHduaWZZRXRkSEs1RUtzVVFmRWRicXViUVgz?=
 =?utf-8?B?RlB0bGdBbWNZQlJhb0ZGS1BKRzBveVF4Ti9vS2cvVnl2Q3Zjd2tlNHprZTVQ?=
 =?utf-8?B?NFNmL0RSZEdlKzVkSVdsK2t0WVJUb3ZWYlVaaXNmc1RaU2lUTk9UalpDeGV0?=
 =?utf-8?B?K3BzMUpIeHhxVUlGczNUNVpIMXJkTUVGOVNtNi9KQUhJRnE1RHR6N2xWczJt?=
 =?utf-8?B?Z3hjNDhuNWdvdU5VNFh3M1U3Y0Z2Mi9hczNaRVFBWWJHMFBWMEdqUXdvWFFR?=
 =?utf-8?B?RUU5UWwyNGtkOFJkdjdiYks5c3U3UVpKQkJLaWRpeFYzNGEyNFZxbHBNbFNV?=
 =?utf-8?B?TWt6eFlLZk54UDdPdzNGR2s4MkxPKzV1NWRRY2Y4blU5NE15Q3kzZDFxM1Zr?=
 =?utf-8?B?TXlVN1k4dFhtd1QxclpldzdzYzZTMVhVTUNMbXVMT2N4bit4dUllK2hNOURK?=
 =?utf-8?B?c2FQdEJ0MStHUlIrUkQ1NFZjVXdDNURNL0daZ3RnZDJOVmNMT0hIc0VkeHVt?=
 =?utf-8?B?K0NhOG1VSkxNK3pRZUQxTTMzQk4yTkhqOFFHWmJML01xMk5Cbnd4ZkN1N3BP?=
 =?utf-8?B?K0Z4T0NSY2RWTGR5cTVvekUyWk82ODRiUVlIeEZucXR5c2tJNjdOdURyS29L?=
 =?utf-8?B?WVhPY1Q5R2MyVFpZRVVzekdMUW1ZTUgrdjlSczRBT0xvTThNTFM5WFEwbFNF?=
 =?utf-8?B?c2NRMHVBblUvMWg1dDRrajFLdFB3NE1VUTMwRXpNYkl0cGZEZ05xZEowb1RO?=
 =?utf-8?B?L2FYRXphY0dpOERGRVM1YWVUcEUwV21Fazg5UktqRnFjS0RBNkg4b2YwTUx3?=
 =?utf-8?B?aDJrVmNLZVNvZTM4NmVBa25ESTE0VjdtbUJOZEFGN2F6aWhhZG03M0JwampM?=
 =?utf-8?B?TzVjMVB0Qk5YTTVUb0Z0MEtDSW9DcElpTzBrUnZrMGJ4QmIyYjBSUU1uSFRM?=
 =?utf-8?B?M2pMSko5bkh3SElWMVZucEs5bW95WGU4RTNWZWZRNmZrMWd6UWNKaEpMS0Uz?=
 =?utf-8?B?Z2JqQnlvbEN6dEpKWDVxWDY4R3VRaTBFNEN3QlAxZVNzNXJ5ajlHczFCUUNm?=
 =?utf-8?B?MURFdEY2a2hodE5qaUtnYkRIajIzM1RRTWF4QVcva2NXT1VQS1QvQmVVaE4r?=
 =?utf-8?B?N3hoRkdha0dPeXRlcFUzbmJLSE1kck1xalVnekxhSTRGc2NIRndWRmcxTHVW?=
 =?utf-8?B?aldsQWNuRmY5eHA1UGY5czVJTlJvYmdncXdnbkVrb2MwWmREQ3hKd2szS3NB?=
 =?utf-8?B?SVVKYkZDalYxTEZBdUd2N0RGQ3QrNGJpd0h1WkRDWWJjVXp0TVBLT0ROUnA3?=
 =?utf-8?B?YVAwdTU4RW04d04wRDRDVFBER0xvNmdueGFYV29vZzJ0bS9SRkJ6QkF2Njkw?=
 =?utf-8?B?RktSM2ozU1NWbHZ5Z3M2dG93a1c4Smt0RW5ZUWFtTWF5OGk5clpLYlFyZUx4?=
 =?utf-8?B?NFNEbDNJTWI2WTdhT2h4d05tQ1VCY1N2TXFLZEhKMnFzbEhXQ0RtMmRiWG90?=
 =?utf-8?B?dU03Ukx3U1lINXNPZzNPYTlqR0w5S3VpYkVZYzVtVDk5Y2FGNnVrSURoQXRQ?=
 =?utf-8?B?cnZOTDhVY0c4VUFYYXFjZ0lhL3kzWEt6YkJQVmRCeXMrSVhxYWgxQzlEM2lK?=
 =?utf-8?B?TWU1QzNCZkNncXJFc2Jkcm5ENkRjYWFqZTVWVzltb2dKT3pmdXpDc0RmdnRi?=
 =?utf-8?B?TUgrK05OQkU3d29Cd3BrYlpHdUpMY0pOQmlaSUtFaGJyWjlzWUZoNGYzMU1t?=
 =?utf-8?B?RGRORjQ3LzlrSGt0RkUvQ3cya0xCS2djeUVnM2Z3TEc4czVnZGFlSEVvZTUv?=
 =?utf-8?B?dCsvQkFMaGlSWEluWVpJcFYvNUUrb3pOZklJTGtlN0RGUXZWS1N4NkE5ZzZ2?=
 =?utf-8?B?Vzg4SDhCVzZFWWhSZ0RyYzdxTm5oRzArWmVOUkc1TU1lWWtwZ0k2SGFiK2d0?=
 =?utf-8?B?Z3FkOE1WbGUwNmYvY1paWFhIYjdQcWNzQ2puTnJPb0FaMFFYdzBiQ3FqSkor?=
 =?utf-8?Q?bUZu7g6C4rs91SIU=3D?=
X-Exchange-RoutingPolicyChecked: M/HVb9Xd8K6VbNh5Pr/O8lA2K4nTi2GsLfYxQVttmU7MvjFGsfULgmGfL87NtOV71dj3l4pt54GzxRRdXR7f4Pu4q1di7/zImMkSyYtluZ1wSc3dQdJPS+7+NBSCMnuhFyyvEYCZ/5Xy4RttC+KrY+TCKdRXbVcfk42zjwqPsCahsG8lmxENyIt2XKr2Tcaf2itAVsvY8mOv+ElJvoOp3tMyMH61S8tuRhCUd/eq1HYLmWQbxcNQsR+SDeUWU72zrPSlDwe7KlulZSisLCLmHH8bwWf9VVKSjPtSBANVfDdzJDAu8ZozUYnck1vNqjJm7yZ/KIaVra8a/V39Kcck8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e5a057-57ab-49ad-e736-08df23f3b945
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:49:40.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk+wh+4ojX43CEMQLixmQQqIUieMAXEmH9ll5cIwxkXAZ2kptCa1GuEye6gOpwQZTRqaWAFZ3LLZjr2vz1ohuAIw6JDryFJM2ZeuD1dyZJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com

On 10/6/2026 7:21 AM, Petr Machata wrote:
> mlxsw_sp_flower_tmplt_create() parses a flow_cls_offload template
> into a stack-local struct mlxsw_sp_acl_rule_info purely to compute
> rulei.values.elusage. Parsing can acquire port range registers via
> mlxsw_sp_flower_parse_ports_range(), but since this rulei never goes
> through mlxsw_sp_acl_rulei_destroy(), those registers were never
> released, including through chain template deletion.
> 
> Factor out of mlxsw_sp_acl_rulei_destroy() the code to actually
> release the necessary resources and call from
> mlxsw_sp_flower_tmplt_create() to plug the leak.
> 

Since mlxsw_sp_acl_rulei_destroy() now just calls free + a kfree, it
would also be reasonable to just convert to heap allocated structure
instead of keeping it on the stack since you have to call a function
either way.

No strong objection to this implementation though, and it leaves more of
the other code unchanged. The stack use has already been accepted anyways.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> The issue was found during a review of Wentao Liang's patch referenced
> below.
> 
> Fixes: fe22f7410527 ("mlxsw: spectrum_flower: Add ability to match on port ranges")
> Reported-by: Wentao Liang <vulab@iscas.ac.cn>
> Closes: https://lore.kernel.org/netdev/20260917113236.2149095-1-vulab@iscas.ac.cn/
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.h        |  2 ++
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c    | 10 ++++++++--
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c |  9 +++++++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> index b03ff9e044f9..10af08ce72ef 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> @@ -989,6 +989,8 @@ void mlxsw_sp_acl_ruleset_prio_get(struct mlxsw_sp_acl_ruleset *ruleset,
>  struct mlxsw_sp_acl_rule_info *
>  mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
>  			  struct mlxsw_afa_block *afa_block);
> +void mlxsw_sp_acl_rulei_free(struct mlxsw_sp *mlxsw_sp,
> +			     const struct mlxsw_sp_acl_rule_info *rulei);
>  void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
>  				struct mlxsw_sp_acl_rule_info *rulei);
>  int mlxsw_sp_acl_rulei_commit(struct mlxsw_sp_acl_rule_info *rulei);
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
> index cb232accb296..f7be4f3a1518 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
> @@ -340,8 +340,8 @@ mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
>  	return ERR_PTR(err);
>  }
>  
> -void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
> -				struct mlxsw_sp_acl_rule_info *rulei)
> +void mlxsw_sp_acl_rulei_free(struct mlxsw_sp *mlxsw_sp,
> +			     const struct mlxsw_sp_acl_rule_info *rulei)
>  {
>  	if (rulei->action_created)
>  		mlxsw_afa_block_destroy(rulei->act_block);
> @@ -351,6 +351,12 @@ void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
>  	if (rulei->dst_port_range_reg_valid)
>  		mlxsw_sp_port_range_reg_put(mlxsw_sp,
>  					    rulei->dst_port_range_reg_index);
> +}
> +
> +void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
> +				struct mlxsw_sp_acl_rule_info *rulei)
> +{
> +	mlxsw_sp_acl_rulei_free(mlxsw_sp, rulei);
>  	kfree(rulei);
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index 353fd9ca89a6..5e4632cb792d 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -862,14 +862,19 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
>  	memset(&rulei, 0, sizeof(rulei));
>  	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
>  	if (err)
> -		return err;
> +		goto out;
> +
>  	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
>  					   f->common.chain_index,
>  					   MLXSW_SP_ACL_PROFILE_FLOWER,
>  					   &rulei.values.elusage);
> +	err = PTR_ERR_OR_ZERO(ruleset);
> +
> +out:
> +	mlxsw_sp_acl_rulei_free(mlxsw_sp, &rulei);
>  
>  	/* keep the reference to the ruleset */
> -	return PTR_ERR_OR_ZERO(ruleset);
> +	return err;
>  }
>  
>  void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,

