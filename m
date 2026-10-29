Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793289475;
	b=0iH4bISdiKaYdxz//c5wWpycTJ+/L79R8Qwuke2EiwL202Ggu4DI3PUm1B/ZudBm2UCj
	 pkQc+DmqbUQnGy0DuUAldJ/A3VfvEFsZR8OUxz2Hs9zN9KxXicPMMkbgZJFiN4ug4II2s
	 qjSCaSot08UW1BZtbcDmo1MqYmgQdA0d/We7Mj68iacWXx2/W9UE/Yipmyhe0GpXZ5Trb
	 KgkEKS5wwO4TXbpgJ+20JOdSVTWTyNAqTkBgmGOBzAASPgA/6him6BpkBC/zN7xPr5CRK
	 auACu5lZSnZllS52oikQjWGlJW07HhfhDsC/VDlq9HaVdO3qioepwd9e+Rqow27jWNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289475;
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
	bh=rJReVyGM44pz7UogTaZmfutljXc5KJktEpKe44DvSC4=;
	b=E+6z2NC7h7zV+80MqauEsZ/9M+4kmw0Lfh9ZHxVek9RrGhfhGF/bjoJT5pwigeSF+n2D
	 7nsKK7F/oAP9PIbh4FgS524Ee/UNyXrNUAqmPBS0vFO8Wta2md610eRhHm2Fnc/ZysF3w
	 2MdTKsxlK3rcOUxf8LFN/j9N//cnGEX/KTTv/n+LPOanBq0E9JZA02Xyp+Mh5NmCLb+Q1
	 folPcgCJQkKmrAZwVhdGkXL8EfcDq/90VE+yVaRCwQdQlUOhlbQmtyUG3qO/OvNTiLjZw
	 hQp9nEPAfciPyFN+RwIDq8zmEMNF5u/VgN7p9pbaOxrkgKONWpK0tPfIz94grG8nE5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YBVlJna3;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E7606A31A;
	Thu, 29 Oct 2026 15:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3E7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YBVlJna3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793289473; x=1824825473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZwV/30nVU3X7PyK3L2uoVkInfJd0qbVLFN3qTgfMF3o=;
  b=YBVlJna3CBW2c9qBt7BZwyXvrnScuYVFYVAy8aBWaFikcN9QdizZ2Hp0
   iiR2c4F/D3cjvF9CzOFtYl9QHz7kuRfsB8/V9PbaniAMmplAdDczwffyD
   aOSOrnrMPkBUQJamul/CYP/eDDjAwrADKS89wmx2N27ju9Ovh8duLuC/3
   o+j+PaamrbUHScaZG9hbfpc6O8J7AHS9UOaaAcPnIJEpwUBOFBRpTZGga
   L7kjWvfv8NrCfGoN2G2Ip+e2owZVApG5yBy3cFpX9DNFzzPReNe0VKXjr
   2UhRF7xi8LhBzgGFCwxcJwME7BrsDf+iQQ9nwN2wKA6aWhAsYAEEMmSw3
   Q==;
X-CSE-ConnectionGUID: rpxatfJRRUKFgNVjP7HLRw==
X-CSE-MsgGUID: O99S8F/YTDeKADv4wBf/pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2052102"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2052102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 08:57:52 -0700
X-CSE-ConnectionGUID: oqBty/0lSfaFbe3tf2c3OQ==
X-CSE-MsgGUID: ZqDHfN06Qgex7oCY589BNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5285586"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 08:57:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 08:57:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 08:57:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 08:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E48DWD6ZxSLeO1NOGqpoKTC5kFDeQKW1Zi5Mv6YnImNBqZU9zsBPPLo48PClkIv5MqOmuKwiYRK/KRVg3RFDGDDcANLEHVMCQ7YeyvtLHjPOB0Fzy9+VLMBUTfqbftZi9FM4CW9/QUyYgRuzgPnaQKekjYo1KMTOFnFcFBMSOe/kM4oGaoQ5ndk5V/MAxRjjn+HEjddCFR5ofHQItyoi+xC24DEnVovAbTCBTBj5kQt18MIeU9Rl53d9mcxNhv3FZvntLT87RNFzxglK6wd8Rk3NUwsLP3wz7iu2AoVDenphsYLAhNACqUBtNpOuf30B81oQrZY22AUpErDXIa9a+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJReVyGM44pz7UogTaZmfutljXc5KJktEpKe44DvSC4=;
 b=JXcWjLtjDsRod3/4333ljBFxGar8yx5a8S9uj3evfmNPYDcg+pb6CZtYuQAa0Gn1tL9hg+b3GMQL3MuNImb5XPNCQcsPKhiOOExA0T1/JCr9SZD+IBb/SAVrs8ByilCCVPI74wMspCLS1vw8ezttu5peyZhI2Qzct6r3JGXfGDIfuW3wuow0GIx5s/kXIGhuYEMQ8q9qVZ15gpCmurTUe+3/O8t9JFuWtnNxlc+cBl12oFIGVbOldVxil7xQJ+Ze4SYiNhWv+k/kOObN6WsJkb+Dr5+Zq26MuFjrRxNEVoH1YAC+9UNnlkRL6XdBvKJAh3meavkH/afKuycW109hDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 15:57:47 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 15:57:47 +0000
Message-ID: <c139c5e2-c791-46a2-8e60-556aa6402e12@intel.com>
Date: Thu, 29 Oct 2026 08:57:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: adjust perout genf
 following ptp changes
To: James Clark <jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Kory Maincent <kory.maincent@bootlin.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Martin Kaistra
	<martin.kaistra@linutronix.de>, Grygorii Strashko <grygorii.strashko@ti.com>,
	Aksh Garg <a-garg7@ti.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261029135556.2508688-1-jjc@jclark.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261029135556.2508688-1-jjc@jclark.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MW4PR11MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: b62e02d5-d36f-4073-c8ea-08df35d56035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|11063799006|261028144727099003|260925021311599003|260925022911599003|260925021911599003|56012099006|261022105027099003|261009223027099003|261026140227099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: bHlvp7bxb/BIF9Kl7Q+1TzCs75W1mN5RBE1tmqHQ5zUoU8Gr6iAfZNvWjfkYZrAEkXtpqvtcincOub7fFMkLXMpHrZjNhVAmvyYUB0f3fELxeUdfbakEgOXMAJDsxnq0cBqkyHRYRW/3YHr3dVKSbbd6DpjJnSyPNqJE9qVkJKaR+lOcUhkvXaMZXckIAhZPgCKVRKpFudyL+1r6zOcRLvI1z1JElyu+AFOzgT6XO7oPKWFTueI6Oxe+gWLZG/kqb0AFI3GcQZNY6CDXMJUU25FmALlk68TYO7yVgRlsOd6nWpEqpGfIk8ZUQH+9Eh53dOPvm4GzwAD1haS7KYCX2lNMvFxr9OMU4el6G1pBZERebfp0Y5569K4JWUjrnkdK3We3GMj4661WJHzh38IHFHITkEFz49lkdUi2JtENyWyRrNW0bOZRnN53Ftg4JXqJ8zM8Sc0IRbAGlNNFF1ZXjy/1q/lBdzyMbomvm8a6MwMhZPNgsy6ub3WiY/yJriFrOl3oKpqcLhDCouQtV/DO7ak5wjKPwT2KtGfoAWfAaWZqCO4mEj0pZLRaW4bdoA/TAPwUFNac20GuE+k0gm4p+0v8Gi6F9slj/B+nUeLiLX2PwGrkvCViCDgmD6VYxo86casZ3Xye6aKhWKuYDEjWbqmJWjcqhyvSNwo70mGV/8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(11063799006)(261028144727099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJZSHdPWXl0N2pVenorSGFNb1QrMERjYVhZRVZ0Y01PUUFUVjlWdGVoaXpG?=
 =?utf-8?B?OG1jRDNBMGJRdnNEZFY0NGpzQ0hOYXZrckVFbTM3U1Z2aHcwVUJLNWVzSEIw?=
 =?utf-8?B?WHNJWXdHc1RNWTJMU0FsNnpSNnpOZTd0UXNHOEMzRVJLa0FRTGFDSUlBeG9y?=
 =?utf-8?B?bzVZNVVucmRQWGUwbzVVN1Z6RlAxcHIrRi9YNTUvMmpiclVxRER1dTVhMExK?=
 =?utf-8?B?NmdZRFlWUFQ2am91anVMK01uVHNaajh3WE5tbkhFUzk5eXNvY0FnVGViS3Br?=
 =?utf-8?B?c3VxT0VSOGV6R2UvUE5DckdRbXdDdDJxY0FVbHlOZmFGWmoxbS9OWlFhR3Ba?=
 =?utf-8?B?ZHY2YWdtRGdBQ09rMU9KU0toRHlRSFdaSXFVcmJvR2t4Wk1nVDF0SDVYQTZE?=
 =?utf-8?B?STl5aHdlTWpnTHFYcEx3bjVydkFQSjFyOUl1K0pHZDgxUG5DTUl5emRHR3dM?=
 =?utf-8?B?d0JPQWZEWWROWUk3Z0JVYkxIU3hTUVJxc0NSSW9kYWRKa2Z2eDdDa2U5WmtD?=
 =?utf-8?B?aWRIVHorc1M1Vlk0NFViTHpuWnlkNm1od3BEbitwUHdqM2MwYnFSQ1FwQ2g2?=
 =?utf-8?B?MWM4TnQrNGdQUGlPT1p0U2dCaEhiOGd1RHpHWkpDNUlESGkrOTZRVmFXeE9O?=
 =?utf-8?B?b3FSZkFaWWlzcGNiSkpKakFvbGxzVkduTjVISUQrQUxqQmlUK0xRWno0QzNW?=
 =?utf-8?B?YnRSS1NTZEhSTHJmcElXUEtYSVpyOFNHOVM2c0RTMUVGWGpjSEFCbDNXQUtI?=
 =?utf-8?B?SldGTlJFL3BMbmI5SFFlenpFV2tOMlhKYmpBSXo0OXFXK1FLR216elRoeDQy?=
 =?utf-8?B?R1dkZ1JUd3JGSTNLRjAwV3BKZjhDZW03bDltWkwyZDVNZWM3U2l6NWc5LzJJ?=
 =?utf-8?B?UFhES0QyOVJMc2pkdzVieC9nOXVDTm95d2huZTFBMEdXditUMUE5YUZlbkl4?=
 =?utf-8?B?eC81S1k5Y1JoeE1TN215OGVySUdSMGJyZGFtTUJaUWxZN3Y0NTFKb0tMTjFG?=
 =?utf-8?B?TDBFQ1pJVDhBUGJaeHFOd0dNODZrSjN2ZzZtb1U0aTJNS1l4VDBTN1ArV0ZQ?=
 =?utf-8?B?Y3Ura1ZVaU9NQVlCZTBpeGhKQWdpalVyQks1MVJzc1hweWdqMFo5b0Izd3dw?=
 =?utf-8?B?RkIxZzFCZm84RnpQWDhIUnBHYU52QWJCNHRveEZGMzFMdFR6NS9DK3RRM05L?=
 =?utf-8?B?K2ZMb0ozQnYxZmVvZzg3UFltbGhQanZvRU9GTVdpRnFobFROSUxUbU9uTlAw?=
 =?utf-8?B?R01QNlhMc0pIZ2h1MVZCZHNQVDRSbFYxeUJscG9PZi93UEtDdmZ0SjFnNDYw?=
 =?utf-8?B?b3diWU1KSXAwZEViSFowOGk1c3lLbEgreHhCei9EMFhBMHNHcTlEdkFWQmRM?=
 =?utf-8?B?TXpoS1JSNlQvbU5PZmRSSUY0RjJVR2kvOGVLVU9ONzQ5M1UyTGVxeXRmWHc5?=
 =?utf-8?B?bGFKN09laHhSTVlRcEZRTUNUN1lLK1lpc1c5UENZNDVLYnN6aWdVc1puSGZi?=
 =?utf-8?B?cG15K3JZL1dtZm5WWnd1TXVrMmRLbkhEaDQ4NmFKY2xIbXVhdWllNVJlRi9L?=
 =?utf-8?B?YWdSQm1LdXhRWEh0b1UyT084eXlFbTVOWEVxL3hZT2VoWXpLbjEwakhOZUxV?=
 =?utf-8?B?NVZUSkJ3WGFjWTl1eFh0cVNWOHRhSFZKMXRkZU11MVhzM1RVREhQLzVNVm9h?=
 =?utf-8?B?S1BFVWdiUkNVSG9aWkF2RHRNSHd0QW4xSDBqN2hRVzFsam5TWHVkN05QYWZT?=
 =?utf-8?B?ZXpHU3UvTC96R21EeTRvTjIyMFVYc0pXWmNUd3lhcXRLRzIrM0Nmcys2Uzhj?=
 =?utf-8?B?eFJaRjFrbERIY01xd0pLbkd6U1BISUJtRk1nYWhuMWlzZXlwcmdtTFBnNEkx?=
 =?utf-8?B?a0l4U2FKVDgraDk3bk15bDVQSlNZZkVBOUJ6Zy9YQ0NWRFBaNTQ5MWx5eVkz?=
 =?utf-8?B?RzBkVWNBZlJkQlRJaWJNMStOVG1tQ29aeWtDYkpxWWxhVzBYaU9sYUJhaVlk?=
 =?utf-8?B?LzBLZFVUdzh5L1ZQU2dhOWcwNWM1dkN4dGI1bngzWjk5SzJhbnVJMkV3clJW?=
 =?utf-8?B?NTh1WXVCVi9LRzhWbzd3dUFpSm1jLzlvRlFBa24vbUpxZi9HWSs0OFdRRWFx?=
 =?utf-8?B?Y1JiM3orVjNUWGU5dm5UWHY1cG9jMWJQTCtaRS9yOTNsNmhzUkxaOFlJOS9Q?=
 =?utf-8?B?TzVLZlpIK016TnpUSTg3UGxZWWJ6ZTFIRUptTWVtUnNHeWZuMTE0bGkzblVz?=
 =?utf-8?B?QjArWjZnNW4ydWdrcXl4Wjk3dUVBa08waTN0dG9BejRuM1lLUzBkK2NUTmdR?=
 =?utf-8?B?ZnNYNlN5ZnQyRjRQdGliZFZxN2Y1dzV2WUQvcEYzSUJ3R21RMEFYTlRMbUZL?=
 =?utf-8?Q?SBYeJnr1SOTOtScc=3D?=
X-Exchange-RoutingPolicyChecked: ttZ8Ud/AF9AYnABtWeyn3ewaTKAKYCslOGTBlGRFeu7vmpmbdn7J+z2iOpv0top/nScYsT+sazU0C+L3DuTFrlgEIICF1eAJ7hI6vk2zCaRtgXWt3Z7K4uM/7tmTofVqFlOv0QejaIQKMDFoVONWZgw2KZfoy4Ik6xJYg47uP65+vStrf0M5K8OuXkpuzoTf459VRXNFIXifBrNqH1cxO86No7LyVqQJKCbwVpbNMe1ESLDBloPFee0s8VMMPHVC0ZPaSfTmOpHfJMaCAaCkK+y2tTRnmvobNEG8JrMFmU2eqmklZhUfr1C7hYoB4s9nyIijAB/qXDkecSBeDdvAqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b62e02d5-d36f-4073-c8ea-08df35d56035
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:57:46.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jInBBEddHfMFYS2F+ZrKpyIJMCoaPxc1iJ6NIQmaK5FLhLtk5QSgKUgbQ341N3xMs2D7GpvURXyqb6akSpbfYXCcB2OJBnzAWISiw4jVy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6739
X-OriginatorOrg: intel.com

On 10/29/2026 6:55 AM, James Clark wrote:
> A periodic output requested by PTP_PEROUT_REQUEST2 drifts away from
> the PHC as soon as the PHC frequency is adjusted, for example by ptp4l
> or ts2phc: at +10 ppm each edge is 10 us later than the one before.
> 
> The GenF that generates the output counts its period in ref_clk
> cycles, which the PPM correction of the CPTS clock does not reach;
> each GenF has its own PPM registers. am65_cpts_ptp_adjfine() programs
> them only for the GenF used for PPS, and am65_cpts_perout_enable_hw()
> starts every GenF with them cleared, so a GenF used for a periodic
> output is never corrected.
> 
> Commit eb9233ce6751 ("net: ethernet: ti: am65-cpts: adjust pps following
> ptp changes") added the correction for the PPS GenF, and
> commit 7849c42da2ca ("net: ethernet: ti: am65-cpts: adjust estf following
> ptp changes") passed the same values to the ESTFs.
> 
> In am65_cpts_ptp_adjfine(), update every enabled GenF the way the PPS
> GenF was updated: read its control register, set or clear the PPM
> direction bit and write it back with the PPM value. The PPS GenF and the
> ESTFs get exactly the values they got before. In
> am65_cpts_perout_enable_hw(), start a GenF with the current correction
> instead of none; this applies to the PPS GenF too.
> 
> Tested on a BeagleY-AI (J722S) with the GENF0 output looped back to
> the HW1_TS_PUSH input (EXTTS 0). With the PHC frequency adjusted by
> +10 ppm before the periodic output is started, the edges drift 10 us
> per second against the PHC without this patch (290 us after 29 s);
> with it, they stay 20 to 23 ns after the PHC second. This also works
> if the frequency is adjusted after the periodic output has started.
> 

Makes sense. My only concern is how long does it take to finish the
adjustment to fix the PPS? Could that impact the rate at which you can
perform frequency adjustments? In typical deployments, frequency
adjustments happen at every PTP sync event, which could be many times
per second.


Also, is there any loss inbetween when the correction comes to each GenF
that could still create (a much smaller) inaccuracy between them that
compounds over time with each frequency adjustment? Or does this updated
correction keep everything aligned by the next pulse?

Obviously this is still better than what was happening before where the
corrections weren't even applied.

> Fixes: f6bd59526ca5 ("net: ethernet: ti: introduce am654 common platform time sync driver")
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> Test details: testptp from tools/testing/selftests/ptp. Before is the
> stock BeagleBoard 7.2.9 kernel; after is this patch on net/main.
> 
>   testptp -d /dev/ptp0 -f 10000
>   testptp -d /dev/ptp0 -i 0 -p 1000000000
>   testptp -d /dev/ptp0 -i 0 -e 30
> 
> Before:
>   event index 0 at 32.000000023
>   event index 0 at 33.000010023
>   event index 0 at 34.000020023
>   ...
>   event index 0 at 61.000290023
> 
> After:
>   event index 0 at 33.000000023
>   event index 0 at 34.000000021
>   event index 0 at 35.000000020
>   ...
>   event index 0 at 62.000000022
> 
>  drivers/net/ethernet/ti/am65-cpts.c | 67 +++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index df5659ead72f..0d71147f3c29 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -176,6 +176,9 @@ struct am65_cpts {
>  	struct mutex ptp_clk_lock; /* PHC access sync */
>  	u64 timestamp;
>  	u32 genf_enable;
> +	bool genf_neg_adj;
> +	u32 genf_ppm_hi;
> +	u32 genf_ppm_low;
>  	u32 hw_ts_enable;
>  	u32 estf_enable;
>  	struct sk_buff_head txq;
> @@ -436,9 +439,11 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>  {
>  	struct am65_cpts *cpts = container_of(ptp, struct am65_cpts, ptp_info);
>  	u32 estf_ctrl_val = 0, estf_ppm_hi = 0, estf_ppm_low = 0;
> +	u32 genf_ctrl_val[AM65_CPTS_GENF_MAX_NUM];
> +	u32 genf_ppm_hi, genf_ppm_low;
>  	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
>  	int pps_index = cpts->pps_genf_idx;
> -	u64 adj_period, pps_adj_period;
> +	u64 adj_period, genf_adj_period;
>  	u32 ctrl_val, ppm_hi, ppm_low;
>  	unsigned long flags;
>  	int neg_adj = 0, i;
> @@ -470,20 +475,33 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>  	ppm_hi = upper_32_bits(adj_period) & 0x3FF;
>  	ppm_low = lower_32_bits(adj_period);
>  
> +	/* GenF PPM will do correction using cpts refclk tick which is
> +	 * (cpts->ts_add_val + 1) ns, so GenF length PPM adj period
> +	 * need to be corrected.
> +	 */
> +	genf_adj_period = adj_period * (cpts->ts_add_val + 1);
> +	genf_ppm_hi = upper_32_bits(genf_adj_period) & 0x3FF;
> +	genf_ppm_low = lower_32_bits(genf_adj_period);
> +	cpts->genf_neg_adj = neg_adj;
> +	cpts->genf_ppm_hi = genf_ppm_hi;
> +	cpts->genf_ppm_low = genf_ppm_low;
> +
> +	for (i = 0; i < AM65_CPTS_GENF_MAX_NUM; i++) {
> +		if (cpts->genf_enable & BIT(i)) {
> +			genf_ctrl_val[i] = am65_cpts_read32(cpts,
> +							    genf[i].control);
> +			if (neg_adj)
> +				genf_ctrl_val[i] &= ~BIT(1);
> +			else
> +				genf_ctrl_val[i] |= BIT(1);
> +		}
> +	}
> +
>  	if (cpts->pps_enabled) {
> -		estf_ctrl_val = am65_cpts_read32(cpts, genf[pps_index].control);
> -		if (neg_adj)
> -			estf_ctrl_val &= ~BIT(1);
> -		else
> -			estf_ctrl_val |= BIT(1);
> -
> -		/* GenF PPM will do correction using cpts refclk tick which is
> -		 * (cpts->ts_add_val + 1) ns, so GenF length PPM adj period
> -		 * need to be corrected.
> -		 */
> -		pps_adj_period = adj_period * (cpts->ts_add_val + 1);
> -		estf_ppm_hi = upper_32_bits(pps_adj_period) & 0x3FF;
> -		estf_ppm_low = lower_32_bits(pps_adj_period);
> +		/* am65_cpts_perout_enable_hw() sets pps_index in genf_enable */
> +		estf_ctrl_val = genf_ctrl_val[pps_index];
> +		estf_ppm_hi = genf_ppm_hi;
> +		estf_ppm_low = genf_ppm_low;
>  	}
>  
>  	spin_lock_irqsave(&cpts->lock, flags);
> @@ -500,10 +518,13 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>  	am65_cpts_write32(cpts, ppm_hi, ts_ppm_hi);
>  	am65_cpts_write32(cpts, ppm_low, ts_ppm_low);
>  
> -	if (cpts->pps_enabled) {
> -		am65_cpts_write32(cpts, estf_ctrl_val, genf[pps_index].control);
> -		am65_cpts_write32(cpts, estf_ppm_hi, genf[pps_index].ppm_hi);
> -		am65_cpts_write32(cpts, estf_ppm_low, genf[pps_index].ppm_low);
> +	for (i = 0; i < AM65_CPTS_GENF_MAX_NUM; i++) {
> +		if (cpts->genf_enable & BIT(i)) {
> +			am65_cpts_write32(cpts, genf_ctrl_val[i],
> +					  genf[i].control);
> +			am65_cpts_write32(cpts, genf_ppm_hi, genf[i].ppm_hi);
> +			am65_cpts_write32(cpts, genf_ppm_low, genf[i].ppm_low);
> +		}
>  	}
>  
>  	for (i = 0; i < AM65_CPTS_ESTF_MAX_NUM; i++) {
> @@ -513,7 +534,6 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>  			am65_cpts_write32(cpts, estf_ppm_low, estf[i].ppm_low);
>  		}
>  	}
> -	/* All GenF/EstF can be updated here the same way */
>  	spin_unlock_irqrestore(&cpts->lock, flags);
>  
>  	mutex_unlock(&cpts->ptp_clk_lock);
> @@ -679,9 +699,12 @@ static void am65_cpts_perout_enable_hw(struct am65_cpts *cpts,
>  		val = lower_32_bits(cycles);
>  		am65_cpts_write32(cpts, val, genf[req->index].length);
>  
> -		am65_cpts_write32(cpts, 0, genf[req->index].control);
> -		am65_cpts_write32(cpts, 0, genf[req->index].ppm_hi);
> -		am65_cpts_write32(cpts, 0, genf[req->index].ppm_low);
> +		am65_cpts_write32(cpts, cpts->genf_neg_adj ? 0 : BIT(1),
> +				  genf[req->index].control);
> +		am65_cpts_write32(cpts, cpts->genf_ppm_hi,
> +				  genf[req->index].ppm_hi);
> +		am65_cpts_write32(cpts, cpts->genf_ppm_low,
> +				  genf[req->index].ppm_low);
>  
>  		cpts->genf_enable |= BIT(req->index);
>  	} else {

