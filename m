Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2273783B0
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704945; cv=fail; b=Zlhh/d4VhezuSHAOKA/yvuAVLJoCWq4v4MFdaatBJ/Tkk4kpU1y8oySbmmhAdlbWIF+eY2EE101tZtJOFzKjpyK1b3cfWOIGRsUFsHihqsAYqtuDDWFfM8fBL/5We2cs8xy2U5Ekbi0BTtyD8S0IcA123IdVXfCryRtmUwgmdug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704945; c=relaxed/simple;
	bh=wH9F7veBakvU3unaY3KoCohDNdQPHrosLMqHv4BJH3A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TA1zERZ5+1aurEK//QDFpMR59b59MFPABZTGcrMTM98qMVwAdJlJW8wsw2FlGT8BSrpdTivFZhT1M5YfKgvRDzFnY85S9cDJxjtDqgnzfDS0VXEJgA5lHLOJQMNrWLiU7Sow2dvUUwIrHmbgoZrg2O8aPAV0Und9G8bobz0Hbp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqA2BnaM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqA2BnaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790704944; x=1822240944;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wH9F7veBakvU3unaY3KoCohDNdQPHrosLMqHv4BJH3A=;
  b=bqA2BnaMvy9I3Zand5YsFiuBC+Ai6Uwpu40M6U67HM+0PK++J+GrxOYZ
   DOnzlTyh0QZvzmV/HePDxmeaCf3DMiCxtGhuJ647lmW/wh1i9wMJ8wTnZ
   qjv9Oi6M4OW1bmi8DD/Gzo8lwuvxRSRdAEkdSrhUA2yDYk9h2De6mZ6E7
   iFiaFyq8uBqJsPbU2QrAI3EIpw/we+pEzL5z24aBkSEn1dghfKmFN3495
   M7Z2tj8JmvSqc57LnK4Rpg2c99CUCby5Re1Zc/qqJaM3v+e4cSmaUEZ3p
   V4Lgq8woorahwQHIW+SxOG7WVt87vkbyBJ7WfntzrhDVs6evcI/9a3yto
   Q==;
X-CSE-ConnectionGUID: o0g9ONXWTHmAIt/k9xqAkg==
X-CSE-MsgGUID: f1Qp1QgZS6O1vddchrxxdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91453730"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91453730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:02:23 -0700
X-CSE-ConnectionGUID: Ul9ZuEKuQ6O7S2p9DDZL9A==
X-CSE-MsgGUID: Q2CsY5JqRneOWCrDku5wng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="283530677"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:02:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 11:02:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 11:02:20 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 11:02:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN9mnRKomWiHgpDBxYwcRnt8ZfH60y0NpMw9WZaXdfjK0Qg7I5qmtBkJDXlj8Yyi/S947yMYfge9339LIWNlXebTgLxz0zyW70Pmzmftp33Ypi7HY3HJubUW1hN/35CYwAhVpKqLQb37s6xa/Frn5MdaApZZXl9crRIuSgBz20yZFymWjFgpiulcP++xPANEcB0tABr7dl7eSp4MGQvi+IDr+/xwAXjw6cgNG91+bSFzAeIxXf5Z95GFIkYsgnm+QMF6IHTkECc2YnYBLW87jYtGUctQ0ZL+Yt4nhkRLOFLEdZMuioeAn4euG9nfEUV/TBbYpTr/tjhVlhmziHI9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH9F7veBakvU3unaY3KoCohDNdQPHrosLMqHv4BJH3A=;
 b=JdUQ7HPCKld8fMCnyoCIq3SI2LV//mVWBnSyqfohvs+Gfak3+8r9eeA9NXOhAUKWEDFwnYYG+EXssybT8od6rO8pgeoBLGOhl9gQuw5YODmLSGsXmAWtYPGUmrJj07u3TnxxaemBWtJHGHd4cRm6yIlVxyypvPo6wbiIBvY0lsiTIDoRAnwzT2v8pm267s0WSho1//CzaPsg2r3oToYeGwmm4RwEhjhsxF+r9w22hffR7964Sz/IHoAtfTTJ2VPPa8jud5VYM4KiQASWc7qUa0uK08wbdu9wRmOtlgSApFJzWXoZ5pFhESBQVLCRYJnvfhh12FM++zXOfAHu3OQ+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA3PR11MB106965.namprd11.prod.outlook.com (2603:10b6:208:620::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:02:16 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:02:16 +0000
Message-ID: <def6f18b-66dc-49dc-b07b-4d34b9924ca1@intel.com>
Date: Tue, 29 Sep 2026 11:02:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/6] ice: skip stats handling for channel VSIs on
 rebuild
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Michal Schmidt <mschmidt@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260925132636.123300-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::32) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA3PR11MB106965:EE_
X-MS-Office365-Filtering-Correlation-Id: 71670d3e-305f-4c6c-b0fb-08df1e53cbb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H1EgO47cQqIZu/rbrKK4AG5u7hPgRvmOzUlrjuMYi3Pd7f2St+Zs34UAYWlBg/aDE7bTBZLyosLkxxMKxWDKPN3LHxvjy7w+NhXT5eBCJef9aex4/67DQvbxoepwiq/QWtGUQDuoR8aVfKTy40B2q8oxY20wjXPjUGr7ZQTquw01dvN4cPTyjkRzUIXrSVTsJ1UCSCKXPPi/GcaEf81lApo5vCHOu3L14wxW0KGboPBUuZ2A5bB3YhE0G9zIknIWk8Kwqgvk9MwLcIFwFYGgVxnSy9gNnpG9vNC6PDwtUViVwHT8SCvoZE0ZPwHl3QoakL1Rmu/cwRcwcSYy7RMNrQg8z0NVzl0n1rOG0WsmDiKtc0mAKPhwgzxiuT5tlCfrGxsLNEORD0NdQupS2cQGLDBsFidmvIv+aoyrxIyviiFHjticij8DKA3aZ7GWdKqZ1vWCw5Bfrd8A7TAA5iERRBhhdqpnD5yOVbDPWaJLyZu2lND1BmdWdVt6eg+77ROe1ftRRcwQJHZ3YHUA32WU7+AHqCu44NLfkF42KIZO9oXpmKGWKh6yiwE+1K9Hsqit1rxax/svelMpWx7YZGQk4St/J0/CiZEGzqcFUFrIXVRrB1AH61otU285l87GUn1kKxszV0vp0Lb/KcUj70KuxJMfwBQwx+dajFg68xUVrSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFBPNXM5N1R0eW9Id0ZEc1F6dURmamMyRWc1SWdybmFMOEhGTjg5QXg1NWxO?=
 =?utf-8?B?Q0RUV1RMZVVheHE2VDNjdmxiODN6VjVYdkplV3RwTVJPSmttVUcwbXVQbjg4?=
 =?utf-8?B?WUNBclVPMndDSENQTWMyQTM1MVhsUUJPSmx4Ylo5NEl2VC9wcVc2WHNsWWJR?=
 =?utf-8?B?b2hYR2FjREtrcmg3ODdjVDg0VDF5M3RyTTlRdFRPSFB0RUxodk1mek5CQWR6?=
 =?utf-8?B?d0FzY2RyOVBuU3F6U2hXWERNakh2aitxdTdIYnFTRUdTRHhiV0pDMHBqY0ky?=
 =?utf-8?B?MXYvV2wzK2JQUzAyTFlMQ1MwVE5vWGZaY1Fsa05wSGN1ek1uMVRiY291ZWNh?=
 =?utf-8?B?bC9vY01OY3gzWDRLQlBuNllGZllPb0NNbjh0NjRPZytRdFJubkcvYS9NMms0?=
 =?utf-8?B?WmpZUmRPUk1DNk9KdTJ2QUlqcEhsRmlsY2FyMThaT2toTVMyOXpHamJlZktT?=
 =?utf-8?B?ZjFzd2pRaFJXUDByVSt5TFRCSnd1UHI0czNVb0JqaEp1UnI0bm1FbzBhNlcy?=
 =?utf-8?B?RHBqdHFnajhUcHU1dTBxakozNHNvUmNDZy8xcFhaSEkwdmJLUlRpK2pYYjQ5?=
 =?utf-8?B?TVZBOFVhSWxOYzBydnozaTVVMlo2dFlROGw5bTVtekVxeXl2WkNhQVQrQUtO?=
 =?utf-8?B?aVc0clJyUHd6T1NpLzV4bDUrUDhTaGRsV2ZmUS96dWl4YTdIZytUOGNpMzBs?=
 =?utf-8?B?dE8vMmppbU44WGdScmVYM2M0R2QrWUlodkZkYVovVWNHdTUweC9iK005bGRr?=
 =?utf-8?B?OEEwNWM0MldhSVRZREpLWWtTb2xoYXhvVk42aEpYcC8wTzBBWGdlTXJ2MUtG?=
 =?utf-8?B?QmFNcHRVRXVkR0JrMStxU2hwcUZNbXZpVG5OTC8xejVIRmxiTllGMVJjNDdl?=
 =?utf-8?B?MDB1cy9tS3lBV1k4TkZTUVhuOHJ0U0xYaTYyMWVVRlIxRE4vMUNoWlNJK2Nw?=
 =?utf-8?B?NDNOcVlXUDFDbTVGaW9GZ25QVkpmVWxUSkI4d1F1YXM1NFcrVXRWZ1J3aGVm?=
 =?utf-8?B?dmlGRDRnaGlHTzVCMW52U1hDVCs5NWpVNFRBNWVEbytDVnZSOUowNnRjWi9P?=
 =?utf-8?B?VS9DeG16UUpPbjZmb3F4T0M0Y0lDbmx3V3hpOWdsTFVjM0FuSjMzRGRPR0oy?=
 =?utf-8?B?TzV0SlNaVzhsUHZ6TEE3L1VDN0pSMloveE1qcitQaXVxZW53Z20rbHNRM0xs?=
 =?utf-8?B?aGsyc1krbWR6UmlJTStqSGNNRTVkcUJ4K1ZLWHluaXdlZHpDbm0rU0w2Q0FB?=
 =?utf-8?B?eEFDa3ZYOHEyenpsa0pIQWtKR1A2eGFQM05JV05NS3k5WlppampYWWFQaXdW?=
 =?utf-8?B?azF4TGtQREFqZWQ5UFh2WDBIcE92ZGs4VWd3c3VaUENOeEVvcVNFeFdSN2U2?=
 =?utf-8?B?Z0ZUQjRqUnEvcEVhWEhpTUNsaDVXZmdJSjQyQUJjSmxDN3plcUp5TC95MTlM?=
 =?utf-8?B?U1pMSWZUS2pzMDMxYlA3cFpBcU5RN3dXYmswYUUvK3l0Z3pmeDlsSU80blRy?=
 =?utf-8?B?RTd3V2JtN3YyUnBuejMxM0pkcytwWWNtU0RuVERxQjMyM2YzZmZPTWI2Tldk?=
 =?utf-8?B?WW1pZC9TczdOSlova3pIMGxLYVF2NkFnY3V5NlZkOFhrK2QyejlYVlBYTXFE?=
 =?utf-8?B?V0lvcGlJRTlLak5kQ2tlUlF0YjVWTTF5c3MyRmdpMTJ4R0FUaEZCV2R1bFEx?=
 =?utf-8?B?OE00RDFHNEVrb01meDBZQmxnMVoyV3VZZGhKTEs1bXg4M2t4MllzZS93ejZs?=
 =?utf-8?B?eVBHdHYvUTI0UTlRbzVIREljaldrcmJLWE9QSTFDVFBVYjd0VFZ2YVJHZU15?=
 =?utf-8?B?QnpUcm1yWXdhS3dpWXNFY3F1UlVqUW42T3FtVmxyTDlMMUY5VXZGbWo2NTFy?=
 =?utf-8?B?MUZHT1E2R2R4cSs3V2J3L0dHdzlmWXUxdjdVZ28zZ09Ra3NmRndGT3M3ZUw5?=
 =?utf-8?B?VVgvSUp5NkxsSXFwU0tRMjhkL1FMaGdMb3JxTUNUdmVLOC94NFJjdE0yd1ho?=
 =?utf-8?B?L3djTTRLb3F4UjhrOURtWVRxQU80SzQ2cjRocUJWbmNWOHp4NzBiL0pBY1Za?=
 =?utf-8?B?NEdQRExndW4yVjdJS3JBUytVVDZ2MW5rRzNUNVBqS1FuZnBPeDhtZGFsT2JW?=
 =?utf-8?B?b2tWZFllMElFQjMxLzk3MnNXWEIvNXVNV1h1U09QT3VtWlNGTGZnQnRnTTRk?=
 =?utf-8?B?bEZPODF2eEtOd0hhS2FBQkZkbVZpR24vcHdYakErZ2pOUU0zMjArdU5xRGxR?=
 =?utf-8?B?bDYra1VVTTFTa25FK1Jvd2NTNGZ6TWd1c0VoR3czSWd2WW9kMkREYTR0QzRu?=
 =?utf-8?B?d2c2dnJ5QVQzNnVlRmxKSi9uOVJjZkFSSExHVUNseVo3Y1ZmM0xacEl0U0Jm?=
 =?utf-8?Q?ompmlvQ+kbhoiPfw=3D?=
X-Exchange-RoutingPolicyChecked: f+XPaftYLRt2y0wbbD/oJrP7qP6WJ20pcULnmBPNdR4ci2TwFHVpwcYR3MZthRQrUc7wVTzMUzATDwd1s2Ny2KWh4PKPO814+V3rghGcIZYKsmlclH+livCTPM0AUdPqAaEpVUS0pujtRyaWy6gfxjgEwKr9lhdncYz5gQ4JAl/VYiCLm9MaJETiQV0djG89RKMvJZCBr5XV3xw5m998aepSju+QuvBPVvVCcEEopsr3t8JMmp4dZaTR4xsiFJETZwxqwxv+/cHGxc/vCOwiGN/RAYSN603pN7FmBrVINhc+qoKwaTaUBgCh2xk/yiwFjQs++UClVRuOWVNUSl1zig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71670d3e-305f-4c6c-b0fb-08df1e53cbb2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:02:16.0671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrn87UdkIHvXnLcESyHDweVU1ztlPCqfB8k+VIMTyGpYwASbx03jOgKJNU3y360lIEsml2gGNbTastgNtjOaqUlw0OjLlGhv3OP22mpH00s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB106965
X-OriginatorOrg: intel.com

On 9/25/2026 6:15 AM, Przemek Kitszel wrote:
> I'm leaning towards removing our limited (compared to OOT ADQ) support,
> but it's outside of this series.
+1. I support removing it, but it is out of scope for this kind of series.
