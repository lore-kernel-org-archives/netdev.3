Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793723375;
	b=LqEpxgi5YtQVT/IuqP43gkYorMX1X+0q77tspREH0eXzWKd9Vn7jbXWRidgGMsfs2VFt
	 /RCCWJfECJuo7rskHgjB5JadG600QOtR/4tnPiUyGqiucChd8nEE7CjiD8zaMMIZgy5Zt
	 49ZhtFfccaQX6Lts8lQgfO5zHqKUhk6o2DR9uOfBXVlRcr6dYSanjZOhuSWhvyYbFFRcd
	 RxPmKuOqA2kllGc/IBFGULpiCSuGvdBtZrrc6KNycMqxHOzYw3QeOqld2jUwDT+0UdAvv
	 GTqsTqZz9G2pfQzJ7IJjI/1X/clTjZd9z1r+QwS4X+PbYRDRtOueoHQ/cpQftBUFu+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723375;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=mv0zlYkb/p6qsr5EtcSQRYDrvMEyMhBfSG7lRll9Hts=;
	b=kLZsQgPcLajoKnIbgNCgvyJoo/hj9ILezGcSf7lbeZF3XQBqCSSp+X8ZN6cPw4pRdC9E
	 9CUdKXvMMYuTTmSU4kIHoVrM7Gf1MxNFoWejD42229PVdMWyOhLaso/EPgWL9AsplZt2g
	 zFADrCcZjgMfeALMutjle93rtrwxXKoLeuevL32RUHOgwyikezuDvhNuQ0PCSC1r/he9z
	 rLLQp63YlPLEK/0BQwwWT/yzvZW1JqQGaPcu+TDZbBI0WaAVGvCWPH6O/jOXb6FzTTPrY
	 POhn9PG9UZOakhcBrnU0a8eMj6e3mU/jupb2GfgEr9lohl/eO02VLe3QJESCod1I6dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tzi9CQQl;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CD606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D83CD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tzi9CQQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793723374; x=1825259374;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FX4uKefeoUytKMdJ1Kcf/6rb2IU++pPvOlYVbxU1gIo=;
  b=Tzi9CQQlV2lMx4D9g8XWtpHCnl//9mJcA31hJvdbLr3fUq0nq1OmkuTC
   IM4+gyaW2awn+A8242j+hi2/fdXV2Ec1Z6o5pthXcsynO7zN5GR7bpIl3
   7/aNRw1Ebd6FRLWSioKVXGaEPMH6vVKLOTqhjIZbfMNfJL7/7LyS24Elg
   KwwnmBEy8Gi1tnm2AQgpJ5W3Tg4fHq5p9VSjKo1Ok+sak9AgNd+NHwOjg
   y+nEjdQQIH9fGgkflnrChUF881vDdcmOGWAsXxTAuC7BC72NDqpvxT75x
   mvHkM49UGBiXylHeLs3vBSR9U7TL/udGbbE0RCKTvKmZK+CN8DN75aFI1
   g==;
X-CSE-ConnectionGUID: jXC+dMOAQSeK8//GZjM3Dg==
X-CSE-MsgGUID: XuFQKcuCQh+Hh4Pc/VhnwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2452410"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2452410"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:29:33 -0800
X-CSE-ConnectionGUID: jPo3VzrSQFCht+2bGFRP4A==
X-CSE-MsgGUID: jJNw/ALiToC9rsj6ve8A9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6583137"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:29:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 08:29:32 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 08:29:32 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 08:29:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0sJXP2bWR+0fEAzJFHy4BsSFyWM4xdIskO74qwfivSIusv60EoWznsxldhSLSO2XuwNIjXtQm5/Z/AqIAJMFoELdGeo8BdBPZHgfjMPmhxPSNd26U/IPXlJ1E3pfhLvBDmILM7i5cD4Rp8QQlb8KNgAVSsmkwVmdUPsI10Sv9ZAtBPbhrw2kpdN0XYuK35Ruz+sZjtfDWT8dTuqPcSIoO+MDxFUhA1GEhCRfTCmR+h6xjuWI3G6te6e90zxJG2/u3A7BsiLZ01wPmWGAUiaB1trYZtA5S1KEXQCq7Jvoj+NcNTpNp8SUDo2Gmm/CRHNZEeWRjGtTkAPuYjqJo19vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv0zlYkb/p6qsr5EtcSQRYDrvMEyMhBfSG7lRll9Hts=;
 b=ppDKWRUnM8dIQNz/5oJieXqILGqw2HMokUUT0rATTFauxK6IKBnDQOFZVKY/eiA1dpm5ru6mU25gLJiZ61U4c7rR3BOHwkHjyLYbHWochaZvXxdzsdY71KCNBmvGSGBjAnSi6VCWyjD7TY8xlZmcgX9fRI9V1VoSstqqDxA6KWOs/Wb2gRSejbDpRE8vLJSInNN0b024U1OhZCpN4jzckDMRBbT05P91FOfJd6BRpq4FAmLS01axfi+MRsi/ULx/o9DZTRR4e9pvsKDRLm7s7VRkRRFutt93SPQyv8G6ebCpPOsn8FSDDVm0TQJQZJkMmf7rDG0J/PsSSlfiKPmtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA1PR11MB8448.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 16:29:27 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 16:29:26 +0000
Date: Tue, 3 Nov 2026 17:29:20 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <zuomao338@gmail.com>
Subject: Re: [PATCH net 2/9] i40e: xsk: fix xsk_buff_add_frag() error
 handling in Rx
Message-ID: <auoL4CpJvKge6lwS@boxer>
References: <20261102124950.958345-3-maciej.fijalkowski@intel.com>
 <179371275039.488856.8029321276858150483@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179371275039.488856.8029321276858150483@kernel.org>
X-ClientProxiedBy: DUZPR01CA0124.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::7) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9be972-67aa-4f20-4ca1-08df39c7a073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|261021121427099003|261102123227099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: UBdIMFlntU5cdbKsqbQVAhaTZ7yuYlbutwnCBs0Ko2YPMj9N4memP/k5xNpPG/DUEZWsuq33kwixXnJS6zlOfokNWjq6nETjhEBxPI/Vt43foBuv1AcTErRiEZatXrz2LwfovhQ2O/u9UDNFGvp1GiqTxT8o6HmwEZWNBrrm/prnrvkN4rd4g7Gq716XVH6alfqIBMvDM6EY6ChYP4Dgk0+E1ZJaTvd5oR3LBpO4hEJVDhsqjzwyPJIag96BeG8Jstch3jdfCHeGOGn6ywFhvzikYv5bMth9LpxUGCkcYZrU1pGHT+an75p8/aJGQuT9DTJgQ6KfoIoMuJwKH5cEyHDJ8tDG1vtQzNH6kXDkrPya53BsdQxI9EbEZ/TzUFnwonFu3CJ3nnxxQtW6z8Wv4LQN3ptEV0VctLvoW3LE60fhPx4O/Lf0vYg0Q3W6izyH0u5v30b3Kaq+om5wTyn5Z8gK2JINXhVP2XAGFHFQPDUD/yclEgiGCJpFnxrMbc7haEfXptg29KY6IwKHI3THQ92G7F6exFw3AXPOFC5fWzmzivp4fbHFhWPMSoxxWKSygtupljEKM7D0vMEtCqE7QQkWlyweRgY0qzWDtkhxGD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZYYkR1ODFrUnlrc1JyWDczQmdnR2FPM1NlWU4vWXoyUWxxWHpyV2duSEFS?=
 =?utf-8?B?emV6S3dEbnMvMjNiMlBKQ3BKMHBWTEZxcm50UE43OExvVkJkK1oySTBjN3gr?=
 =?utf-8?B?MkpydldiV1dMTWd0Y1puTWpRam1xczJ6WUZ3NG43NG5QUUZja2tmSjM0cU1y?=
 =?utf-8?B?NStOaWZnM2txVVpDR1JlaDFCdVZDNWV0RDBVZzhZVnZsTGswdXRnTUFVOXJ6?=
 =?utf-8?B?YUtqQlFUaExPQ3k2c2RvUXgrelRIV01ZUytPWHpRNG1Sc21LZ2dIOUkrWXNE?=
 =?utf-8?B?U0ViYnlZeHViR3M0RFJpZEg1U2Npdm5abnYvQ2VmOWhFTXNRRW1IS0hvZzk0?=
 =?utf-8?B?Zy84U0RUQ2Y4REJGZjJVN1AxbldCN0NMZ25Bdmx0ckFDTHpGQ0k1QzJTeXhv?=
 =?utf-8?B?NmltbmhGMWd0WVdpRHdwSlFjT0FZUkpwVGNrL0E4UkxyZGo5TFFid0xreHBW?=
 =?utf-8?B?RFBNUE5YdnZWWE9DTmszNmJDQjNPcmN2ajZ0NHpTVytSMzVWK2IxYW83WTBa?=
 =?utf-8?B?WjFWdUZNK2RXTHBJYytaTEFZVld5Zk9KQXVVMDR3d0g5dEJKNmo3MWZ2dkZP?=
 =?utf-8?B?V0x4UFd3NjRwREJyWjZvcUw5KzFCVjMxOC9mMkFOYWZDVDd1a0M0QVNpMWsz?=
 =?utf-8?B?TlJ2d2NjNVMrbDJGU2ppRmsraGZweUk5NElrd0d6Wk5qNkNhK2ZXRXJrUGhr?=
 =?utf-8?B?clhLaEJGYUhNY2dRcGJRKzQvUmV2UjRrK2lRNnA4dDFoRUVCK0NJVEovTko5?=
 =?utf-8?B?RzdjWGhLd2hyTVZobkQ3Tlpvb2NUc0tZNDZ6eVZYcEpZOEN6MlNzMWlIUU14?=
 =?utf-8?B?S2I4TmdESXJYL25YQzF2elhLT1o3cURjNmNseDBtTENROEJkVjdibDFBSFVs?=
 =?utf-8?B?alRiVnVVTFFiRDhCZjFzdEtaVnF6TGxLb1ZPWkl6SkNRVTQvelJ0RjN2Y1Q1?=
 =?utf-8?B?aFAwOTdnVWhXMWkycXhTNEg0aVZRbG5vWk9xbm05VWplWElwTmR0bVNNWWxl?=
 =?utf-8?B?aGtaNjZGWld6WkdveTZDaGkxUW91RFFJRzhiRXh1aC96dnJIRE5YTDg5RlNP?=
 =?utf-8?B?ejZURG5weWtRVTZmZWl4Y3hBSW02NmdHdFp2aCs2dHBKb09QcmVGZzF1M1Fz?=
 =?utf-8?B?U2lzR1hCbExlSDlKZW9URXQ3N0tkeitDQmRMb3lLSVk2RmFTSmhYTldJcTg2?=
 =?utf-8?B?NkNXUlJZNHFkbEhsZVhpelNhamNpKy9LWE40cG1xRHdCeGYya3JDNSs0ak1y?=
 =?utf-8?B?ZlNPSVgxeTJCOCs1SWUwaklaVjVseUpNa3VnYXZneGlzMHZDZEdzcTFVWVJy?=
 =?utf-8?B?UGhub0dhWHRqdE52WEtNbEd2NnJnWG9sbVIzVWwvemE3cWg1b1orZjRVblV5?=
 =?utf-8?B?enUxRTV1T1R1Wm5BVFdoUjArb0tyaDJLK3pGUzJ5aXV3SUl2NG5MRWtsZ2ha?=
 =?utf-8?B?OStDOFFBSnJMazdXVjRCazFPZFFLK0pFZkVUN2tWTFgwaXcrZjRZbWFnRnpC?=
 =?utf-8?B?TVEwVDhMemdjT1BrUHlLeENrOW1raWQyalZyR1UxeHBORm5NQ3k4Vi85aUNq?=
 =?utf-8?B?NGdhY1NxZS8ycmI3T29Td09PU285RGR3WmZINzlEM0NYOTByMlpOc0FxT0d5?=
 =?utf-8?B?T0FVbTg4cU0xTnAvcXdhK2M1SHE1dlVzS2pObWdaeTFMT2J2ZGd0VnNDeG1v?=
 =?utf-8?B?UnBwNWd3dERwYlQ3dWtzM1dqN3BrcUwyeVBGTzJaYThNbU9mMTBaTHNwZXcy?=
 =?utf-8?B?Q2dnZjVQMHFWUzhTYTZ3SjNtSlNtd0EzNk5NQUJBVzBnaDVIWC9oSTdhWlBI?=
 =?utf-8?B?ZW5hcGhSU0JObHk1bTZkQXkrczByei8wYW44NE1hNjNxVGhQeUdibURsRHN4?=
 =?utf-8?B?NTZ3ckgzNWRlTFN5aXNpb0F3emh4dDBadEhpdXdEcVBNcVBwSkY1SGNYMElN?=
 =?utf-8?B?NHZZY2FOTHZxWFhlV2Q3K2twR01BQWRnQlBSVnk5SWs2VzAzNlhYSlFBeEY4?=
 =?utf-8?B?cG1SREw5OTZ3QlJzWnJHYThMSkdYdGJ6eWpRb3psajBzVzRwV05HWk13M1Bm?=
 =?utf-8?B?MGozcE5FMkhkVXc3MUpQUUZqZVhjUEhhdlZCakJvTzlnS0dDWGluYS83ZjY1?=
 =?utf-8?B?dHkwRWt4NDBjdCtDVTdHNUpYajRIYUwybWRJS3dHZUVwR2FMblRiUkJ2ckV0?=
 =?utf-8?B?UlBKL3A4dVVSQ0MvQndGREdQVDVDZjlMOXh0dnFjYVI0WXhmbWtLeGdUTy93?=
 =?utf-8?B?MDV5aElPZU1RLzhUZHIxMkhKbzZTV2Qwd0pxTVhtTjF3TjBvTmcvMzdZTUNx?=
 =?utf-8?B?T3lYc1VuN3p4TTFNVC9SK3g3cTAzLzAxeTB5MmlrcFNVeEFPMThjSTh1anhO?=
 =?utf-8?Q?CwhuIVJz+hJEo+gA=3D?=
X-Exchange-RoutingPolicyChecked: xktBeDGP/aUG9y8ZISD/dIR6N9R5bPgLI1Qam7ihI2t9K+bFAYImp7T7r+dAa5JrmXKBVBFl3rKfp8YtfG09AV+t6LYZWtgjW/YkSOc9yBMruoViiajhyx/aGxPY5cUDft0azYF9IPSjxzqsY/T48mWuj+Ejbr6fvC7vlYxrAp0YOwEiTr1fWFgQFsVZUZ1pSI427DHlbJbB8jyVG3x/WLEzmK8K4M+GxWQzIklv4Jh8wm/U73rQTNmt9pv2uEtvSQTtyElJfDxdgSe1z7RrNLrvBZMpslpfpc7MqsPMJg/iz3pckhlYDSDHiBVtSCcGc6rv9he0Rgi7WsTx4QYfoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9be972-67aa-4f20-4ca1-08df39c7a073
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:29:26.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3DqtFCkuek6Q/NcQJwWMbSaPh7c7NVyUGxOiJxBvyvA2Qlv8cY0BfeUmTVIxtm5/otAqlufvT9amkzA91R8/rUaAisKI1UPCujFop//Isk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 01:32:30PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] In i40e_clean_rx_irq_zc()
>   (drivers/net/ethernet/intel/i40e/i40e_xsk.c), the new error path for a…
> - [Medium] When xsk_buff_add_frag() fails on a non-EOP descriptor, the
>   new drop path in i40e_clean_rx_irq_zc() frees the frame, sets `first =…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is a high-
>   severity issue in the same ntc/ntp bookkeeping.
> - [Low] Claim: the struct i40e_ring comment 'next_to_clean is updated
>   only on processing EOP descriptor' (i40e_txrx.h:354-356) is now stale,…
> 
> --
> 
> i40e: xsk: fix xsk_buff_add_frag() error handling in Rx
> 
> When xsk_buff_add_frag() fails, i40e_clean_rx_irq_zc() used to free the
> frame but stay on the current descriptor, which could lead to retrying a
> broken frame or stalling the queue. This patch frees the current buffer
> along with the frame, advances next_to_clean past the failing descriptor
> and treats the remaining buffers as a new frame, as ice does.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 51a05ce4c7ce8..e6ae4c7a5cb39 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -469,16 +469,24 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >  		xsk_buff_set_size(bi, size);
> >  		xsk_buff_dma_sync_for_cpu(bi);
> >  
> > -		if (!first)
> > +		if (++next_to_process == count)
> > +			next_to_process = 0;
> > +
> > +		if (!first) {
> >  			first = bi;
> > -		else if (!xsk_buff_add_frag(first, bi)) {
> > +		} else if (!xsk_buff_add_frag(first, bi)) {
> > +			/* Drop what has been gathered so far. xp_free() skips
> > +			 * @bi if it duplicates a buffer that is already on a
> > +			 * pool list. Remaining buffers of this packet, if any,
> > +			 * will be processed as a new packet.
> > +			 */
> >  			xsk_buff_free(first);
> > -			break;
> > +			xsk_buff_free(bi);
> > +			next_to_clean = next_to_process;
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but the struct i40e_ring
> comment in i40e_txrx.h says:
> 
> 	/* Next descriptor to be processed; next_to_clean is updated only on
> 	 * processing EOP descriptor
> 	 */
> 
> This assignment now moves next_to_clean forward on a descriptor that may
> not be EOP. The comment was already inaccurate before this patch, because
> the non-ZC i40e_clean_rx_irq() also moves next_to_clean forward on
> programming-status descriptors. Should the comment be updated?
> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. It is
> in the same next_to_clean/next_to_process bookkeeping. The
> programming-status branch earlier in i40e_clean_rx_irq_zc() frees the
> buffer but only advances next_to_process:
> 
> 		if (i40e_rx_is_programming_status(qword)) {
> 			...
> 			bi = *i40e_rx_bi(rx_ring, next_to_process);
> 			xsk_buff_free(bi);
> 			if (++next_to_process == count)
> 				next_to_process = 0;
> 			continue;
> 		}
> 
> Suppose no frame is in progress, and the loop then exits through the
> !size break. The ring is left with next_to_clean == X and
> next_to_process == X + 1. On the next poll, the entry code treats this as
> a partial frame:
> 
> 	if (next_to_process != next_to_clean)
> 		first = *i40e_rx_bi(rx_ring, next_to_clean);
> 
> Can this make the freed programming-status buffer the head of the next
> frame?
> 
> In the meantime, I40E_DESC_UNUSED() is based on next_to_clean, so slot X
> is not refilled. The freed xskb sits on pool->free_list, though, and the
> refill at the end of the poll can post it to hardware in another slot
> through xp_alloc_batch()->xp_alloc_reused().
> 
> On XDP_REDIRECT, that UMEM address would go to user space while hardware
> can still DMA into it. On XDP_DROP, it would be freed again while hardware
> still owns it.
> 
> The non-ZC i40e_clean_rx_irq() handles this case:
> 
> 			if (rx_ring->next_to_clean == ntp) {
> 				rx_ring->next_to_clean =
> 					rx_ring->next_to_process;
> 				cleaned_count++;
> 			}
> 
> Should the ZC path do the same?
> 
> > +			first = NULL;
> > +			continue;
> >  		}
> 
> [Severity: Medium]
> What happens to the rest of the hardware frame when the failing
> descriptor is not EOP?
> 
> After first = NULL and continue, the next descriptor of the same frame
> becomes the head of a new packet. i40e only marks the last descriptor
> (EOF), so this new packet starts in the middle of the original payload.
> 
> The hardware limits a frame to I40E_MAX_CHAINED_RX_BUFFERS, so a full
> frags array cannot happen. The remaining trigger is a duplicate fill ring
> address in a non-final slot, for example A, A, C with jumbo frames.
> 
> At the original frame's EOP, that descriptor goes to
> i40e_handle_xdp_result_zc(). On XDP_PASS, that calls:
> 
> 	i40e_process_skb_fields(rx_ring, rx_desc, skb);
> 
> This applies the original frame's ptype, checksum verdict, RSS hash and
> VLAN to bytes the hardware never parsed as headers. On XDP_TX or
> XDP_REDIRECT, a tail fragment would be sent out, or delivered to the
> AF_XDP socket as a complete packet.
> 
> Documentation/networking/af_xdp.rst says:
> 
>   AF_XDP guarantees that only a complete packet (all frames in the
>   packet) is sent to the application.
> 
> The non-ZC path in i40e_clean_rx_irq() keeps the hardware frame boundary:
> 
> 		} else if (i40e_add_xdp_frag(xdp, &nfrags, rx_buffer, size) &&
> 			   !neop) {
> 			/* Overflowing packet: Drop all frags on EOP */
> 
> The commit message says this matches ice, and ice does behave the same
> way. Even so, could the ZC drop path consume descriptors up to EOP before
> starting a new frame?

This is the same issue reported as on previous patch and I will address
this. I removed one issue which is fixed later, rest are pre-existing ones
and I don't count it, so now the score is even.

> 
> >  
> > -		if (++next_to_process == count)
> > -			next_to_process = 0;
> > -
> >  		if (i40e_is_non_eop(rx_ring, rx_desc))
> >  			continue;
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
