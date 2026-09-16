Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666D4156FD
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595208; cv=fail; b=lc/+Dm9+y1vuTa03Uper1kWEVPiekS6Ol2UFLjOh+xKxN2dO53lehll7QAIzJwzg6KA6bBI1ifCw+WsDdHx1pJ+WsGCVfURXniS8BVACrBaS3rnURMdhKmsqT25yy0sXhv00fHrE+tj14hf+jdXb4PfpTQdf4uoIEdgRNMQsmvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595208; c=relaxed/simple;
	bh=a3WzcIvh+dqobD7OX314ymYgnbkRSvzGkZpDVEio7Ug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qG4X+Mb5EM9IjPxOwd23bcpwBz7WRaUeKzB1ts0Myf8LEIv47GQgcFRUIpEuMSsGO4Slvam/870N3vUO7jYLop9tSC5GFXRIihKujelyRDITD5cA/AcQsGhnrrf2M+jIFwbiAEzaZkgY3ddXSDBxTLshqZcBYuseN8NvkkOlGWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1/Y2ywM; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1/Y2ywM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789595194; x=1821131194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a3WzcIvh+dqobD7OX314ymYgnbkRSvzGkZpDVEio7Ug=;
  b=l1/Y2ywMfDsNGO1K/Nxoz6uV7Hpwlm3xS/L95O4bFSswVqpHrCOUdeq8
   q2CWjDFzOngkiP2Ktv7g5M7GWxlqj46YYJMIIwFibXQ62Aombbu9lxIXo
   /OFXRD4KaO0LUf++1bBatHV+iIvkFo/4YPYuECwy1B2BFI4tRUSjJn1jn
   A4RCwk5yZWy13Gp3UhNTFfDkZCm3i/7Qu6+mTxF1Wm6rw1yn/B3vy8xON
   iHc24sow4Ex3gt5dZFjQAxHEvUS6Duy9dTwOZiGEKMS/LT3rKz3YpkYRn
   odgILmP36o48qIee4BN1g/gYd5iIznYr1rBAOnco9sqfMi3DNG64rlUhu
   w==;
X-CSE-ConnectionGUID: W8fXhVc3SpatZw9XgxAURQ==
X-CSE-MsgGUID: aNKbH1h/S3+7BNEEQJgKpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="488697"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="488697"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:46:30 -0700
X-CSE-ConnectionGUID: c1O8RBrPQ/mS0oqBAaIpiQ==
X-CSE-MsgGUID: U1ggF5VhSXas2RD/K629cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298542820"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:46:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:46:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 14:46:29 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 14:46:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNcS9zVQmsM5cF3r/nYms73cE/E/yByREeeVN6++dxa4M8+bP48Rdv1fEc2CEK3Q84uye5iftorlsrAVZxhnHNrd4AoBVLHjVby2aLtTn6imPwKZRjZgillFd6Io+nAUEB7gcCynQ8/ZxBcuWusRJn7kHCD5Lo7cFzzGS+FXqNtavmJT9A+hxXgikyAhPDFavofqlZxIKYrFwzDJplZ8iwzRIyt9166gwPGez7u3RmN2NYNkxKd4hFeXBLUvQJYlHLdXbSwAhTzW8J4YSLvZG4lSTVYBsG4cFnb/hmaOvQlNtqWVSA2BRKT20huKdIAsP1rITdmMRikA0g+ZD7wqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOguE1MTFsduahYKXCRZ6XGN0zBlbi9j4f/i276iHpA=;
 b=hC6rOICh0vNatZOpyaCoN3FTCw1tn5VNUZPk2EUNRAVmWsnKxrEDmk0xZd5wpItW8A0OyY8OT2qylZv94vNAKOsGLOgMhOz69Qq/2NWcUfCEUfadfS917pGJS+sAtAo0baeWhjoQPQgV/7tk0KpxHmXWRN6H7u+lVIhdLXopngTYiMlecV1WSpkQBcfgzCzHu3eUL+A5j7CBVNeI+qIyQA5uggHeec5uvlekk4GJdkZLdK6WYlYx0SRuTv6EhkbiTSLMpo14aKaERAGUq83pT0Akpkthv6dBfZDBumle0IjC/r6WQpRUGMq9fJZGg2wi37olezIEmh5a+PurHNdTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 21:46:24 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 21:46:23 +0000
Message-ID: <62f08662-e5b9-4b40-b44d-35e156a9f6f0@intel.com>
Date: Wed, 16 Sep 2026 14:46:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/15][pull request] ice: E82x: timestamp processing
 logic fixes
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260911003430.3386340-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e18a3b-3025-45d4-3e7f-08df143bf3a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: HGkDBrivp5HrFWvca/TDGLN20Yr5gcDixCRotFM1mmXJtDtNRaQr+Tkfd1bbtaMlp4oDeC7OHAJ3qvxPHgr5kfTd1XwgVNJRzNp+hySfMC+k5jXF4bqxWVdYPnYvCvc8VtKtBGXtM/pzkIWdUAyxRKYhGiAmBkSj/YVpkab5LrO1J7wEPBi1yqsgiL8eBZpK1vKam/t7bNbZrMsPpmQHIVJLOiHw4KncxbtwprYxe5nv4ROb0ZSF3JBbZpI+yfB8DgWOTr8y8eVlMAnAnB93SpzBjc0U1CBTlkNu6ExBIGrpArtV/6gnriusfp35vG89rI3lvuB+sYVBH8Yu0pQmrNccmFX72T6x068z6MhfeCQqBDU2tuvY+r7EorZW0G4LRUaE81W/qL0IibBjYkP4MnLRLVUn3yBCxP4ts2zcGBI63OzHfzFmzloMwDewzTPPv8UGNrLal6Pt49ohBc/kpG9V6xbI6b4TbIbytV7F5H0ZdfdBLuXPIIYno/f2CD5gy22VerH+RtfMAtbDBAGZL9EZL8CY5R0G+ydBRHXgv8+MTdqJALcM+yP5mrHkGprgtwzjzJC8JkWb4yTQ7zdNmSKxHB7xr0kM2CmbpPeSHnicbLT1i+NXC3D80Cj20IIQUU/A2+EeK6FdPL+k8LmUABHBdai+EoAxymDZ6SvbTQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tSNDNyb3pwci94V3BhM3dpRXdsM0RFeFljZllTNTZFanp1eGhvM00rR2R2?=
 =?utf-8?B?Z2F1cUdLbnFBQ1B6ZGlmaC9BaTB3U2JNZzNWNkZRZWZRVTVYQ1lEa2F6Zkd2?=
 =?utf-8?B?YWZEaFpBWnZwM1dMOGRPeEZKc1JQQUJIcUlQUDFuNkY2QWhFNzJxU0xuL05U?=
 =?utf-8?B?MzRaaCt4QUlDNFZQNDlUcjdtdVE5QW5lSExLbFZFUzFvMHc3ZEg3cSsyL3l4?=
 =?utf-8?B?K2lpY2x5UlJaNTAzVVRhMUlGUWJyU1RXNmtTbmsxS2lYNW1YZ29vSkZnWXJv?=
 =?utf-8?B?dmxnK21RK0k3eUg0OFo1Mzg2WU9FZXNXTWdTYTZ5QSszekdBZU9zbGUwenpR?=
 =?utf-8?B?UGlRU0hBcVJpOVJRVDdHN0NlUStVVTNyTTZLZ1ppSDE3TUpnczJvTWpNOUc0?=
 =?utf-8?B?TEUyeTV1OXNUdXB4N2x3bWpWWGtGM2h5STBaNEFKWCtGZEJwazRIWHk0cnlS?=
 =?utf-8?B?VUk5MFZ2VVJralpycngvYlNaRGtmbklkdTk1WEc5TWpMeklUSW5sT1Y4RUZN?=
 =?utf-8?B?QTBTTnFUOW0zQTdPNStaZGp3eVZNZDhOMUxkTUNYdmxmNXNsQXo0VFRmYzRa?=
 =?utf-8?B?S1VpazV2NFNYR1laOG1DV1Y4bnNxa0RkVXNvUjMxdURwUWZoZElzWHNHMVBt?=
 =?utf-8?B?SW1iTVJ0Z1RtODA2T2NTeWtSd1FkMUdRakZaYnZ6UTZpUWxlMXNjM3RlNU9Q?=
 =?utf-8?B?cEVZemIvTDd6MzErNjFVUS9JamtReXlMSFZCT293alJiejcwUFlONFoxQ2ZH?=
 =?utf-8?B?ak91VFNEU0puVHdmSjdBUHEvRjF5bGF2RzExQy9zemJoaVNQSUk5ZGFsUmkw?=
 =?utf-8?B?eFJvb1czVUdyNGNubGJWckhkN0MxcHJyd09LcHBFVmZaTkRiYWZtd1duczJJ?=
 =?utf-8?B?RkVsQnJLVmx3YUJrUE5Fc3NxUm8zRm8vTktBelFlandkM0xTLzJYaDlZaDhk?=
 =?utf-8?B?WkVLNGdXK3FZZFlleTlGTTlqNzY3RGtNbkpTTVF3MC94NU13eFFWcmROZkxz?=
 =?utf-8?B?TUdCZVBmYlYydVZlYWZqeGVKd21mQ2MvYkxjRVdkNkJ5bUxQN3VSUGo1NGo5?=
 =?utf-8?B?ZVhja2ZDTjVpNTIzNnhiYXFaMHVoQU5nSTkrTW5lbkRWNkxMbG16R3ZOeko3?=
 =?utf-8?B?Wjl6TmlMeHlMMW1pZmJVR3ljdktMNGFCeHF3bmV5NTlxUGNJVlYxRnRac2Jr?=
 =?utf-8?B?eU5XRnV5dDNiQVVQV0ZidXpzYlB4bWl0bGtBeHNDUmF6dkx5cEpGdjVVSjkr?=
 =?utf-8?B?UXpvWVlzOFVMdHliOFBTOHdRYzI1TCs5bFYza1FMUHJoUzBmeXl6NXNmUjhy?=
 =?utf-8?B?eDN1czZ1aXZ4UlVNdndSQnhRb2NscGFXNzI3L0hsZXRkUXE5Rm1ScExwMHZt?=
 =?utf-8?B?ZTAyNjZyM3Vhdmw1b1FTR2pPUk05YXYzejNXSkF0eE16UzVab1RGQnY3SUVz?=
 =?utf-8?B?b2xrdjVWNVExRjI3TERCaVhITEMvTHVRMXhnblVjTy83L1lmajV6eWQxYzVX?=
 =?utf-8?B?dG95U0gxMkFpRGZKTVRrTmdwUEV5WlFNUWlhd1AvRUVWV0VVV0V4cUc4UlNt?=
 =?utf-8?B?TWo3akEvMmEwcEdibzQ3V0pDbFQrckc2OUFIUkl6MnQvYndiOUJaN001UzU3?=
 =?utf-8?B?dnI1WmdiVktvUW4yWk5UZ3FQOXk4NkcxVlNubmlNL0xhSmhKbGY1enhEbjVk?=
 =?utf-8?B?bWE2aGJLOVFSZWMvWkVCeWpkaWFkQzZMTXNCc3BhclkwQWhka0pWZmNJdGFz?=
 =?utf-8?B?TjBYUko3dVF6S245U25ISStPODRYanF5Y25uVDR3a05MY3c2NWEyRE8xUEYy?=
 =?utf-8?B?czMrem9PeWQvS1oreVZRWU14VTM1bVF5U09UWHBTY3dyZkhWYTJqZ0s5dVFy?=
 =?utf-8?B?VTV3bWVTMDZQRis1c1M1bVNoYWlUcDJxY0dvVVZQc1NkbjlYTVFTNXhITGM1?=
 =?utf-8?B?NzNTYW5GMm4zbE1iVW5yM1YzTzJZOWZnTEh4WWJWMjZxWWFqWUF4M2czNDFR?=
 =?utf-8?B?c3ptYnNsOVUyR0lwNnQzbmdMR2hidU41Rkt5dnhnQ3pjN3hiTjZxYlVzaHZY?=
 =?utf-8?B?MHczdDJJTzBMTmdpTS8yM0pJbkRzczJlWEp3QTdBczNxdzA4ZThHM1VrODBv?=
 =?utf-8?B?ekN3bjRhWVExNnI4T3VzMnpJeGo5TktOWnllaytveXZmMGVWRUdLSzFkOU9I?=
 =?utf-8?B?UmJGcytZa0ttY3lKK0tOdTBOS05zS3JrSFRreTBJWkRDZ0JmRlpjYVBSUWRr?=
 =?utf-8?B?MHpnV0pjWCszRWJhODlMNTYxTGFvbGpJTGVjRUJrTzlTS3JPbHZoTEd0U21x?=
 =?utf-8?B?T0puQ1dkUGVLT1dhY1haUkV4ZjdKT1o2S2ZBblI1RGlqYmxQaEpNRGx3ejNM?=
 =?utf-8?Q?747cPZPghLDAe36s=3D?=
X-Exchange-RoutingPolicyChecked: inDyJvMPMYltKj2KIZXbyrbnnDvRfy7E2A8k4bbY68F0pzh2ZIwDjEV48rO96/ojg4FT2Jgv/Q7J4ZZNbRg7QynezvnjcHDw9He+zbaGHQh0QkAJgDYm4Es/NrOOmtepp0ZZQJFNjSCE0NPDAGIh1bfa1vO5OP5s10fT3pI9Tb3X3By2eFq8usNmrKltv4mp4UtDKSypYANKad9c6897kpNP3LWQa1eqMTxZaT2gfe2lZG8UeM72RB+aPCrxC5ByAttDhgu4P7cIfN70LxqJ/sQHPonGYYnaCl8IWSIuWSSGrT45cwMMaumULV/JxzQfhbifQP7E34g6+Yxf7LZ94Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e18a3b-3025-45d4-3e7f-08df143bf3a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 21:46:23.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA9u74RPJ8O9KW34oh7Ac9DXRDzb3tOBWYddqfx9gYMpPRZoqdV/krZCdirN9QVGBjaB23HLrblfLmCk50lrjt1g+/CCfHtTcSI2LXqnOVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-OriginatorOrg: intel.com

On 9/10/2026 5:34 PM, Tony Nguyen wrote:
> Jake Keller says:
> 
> This series contains several related fixes for the ice driver PTP logic
> relating to timestamp handling and device (re)initialization.
> 
> Of particular note is some changes around the handling of timestamps that
> are requested near device state changes such as administrative up/down
> cycles and link change events.
> 
> The E825 device logic in the PHY has an internal counter which is used as
> part of the "threshold" logic which determines when the device will trigger
> an interrupt signal from a given PHY port to the MAC. This internal counter
> requires some precise handling to ensure that the internal device state
> remains in sync with software expectations. Otherwise, the device can be
> finagled into a state where the PHY stops producing new timestamp interrupt
> notifications to the MAC indefinitely. This in turn degrades the timestamp
> processing latency and results in application failures for common
> timestamping applications such as ptp4l.
> 
> There are four major categories of problem resolved by this series:
> 
>  * Timestamp requests made while the PHY_REG_TX_OFFSET_READY bit is cleared
>    will increment the internal counter, but leave their valid bit set to 0.
>    Upon read, the counter is not decremented. This leads to a desync of the
>    counter and blocks the PHY interrupt.
> 
>  * Software logic for tracking timestamps incorrectly cleared in-use bits
>    without waiting for completion in certain cases. If the timestamp *does*
>    later complete, it leaves an "orphaned" ready bit which is not
>    tracked by software. This results in the internal counter becoming
>    desynced if that index is re-used.
> 
>  * The PHY timestamp memory region lacks pull-down zero-initialization at
>    power on, resulting in uninitialized random data in the memory region.
>    If software reads these values, an entry with its valid bit set to 1 can
>    trigger a counter decrement and cause an underflow which results in the
>    counter becoming desynced.
> 
>  * Timestamp request which complete near the beginning of the PHY losing
>    link can become "stuck" such that the hardware logic triggered by a
>    timestamp read does not activate. The memory status bit and the valid
>    bit in the timestamp index are not cleared. This window where this
>    may occur begins *before* the firmware notifies the driver of link loss.
>    When this occurs, the driver may accidentally re-use a stale timestamp,
>    and the IRQ re-trigger logic triggers a repeated IRQ "storm" that can
>    consume significant excess CPU time.
> 
> The series' primary focus is towards preventing driver flows that can
> trigger the above sequences. It is based on work from Przemyslaw Korba which
> was previously posted at [1]. During that series development, Petr from
> RedHat reported the 3rd issue mentioned above. While attempting to root
> cause that issue, several other issues were uncovered and those fixes have
> also been included in this series.
> 
> First, the locking around the PTP ports list in the adapter structure is
> converted to use RCU primitives and a spinlock, resolving a couple of
> reports from Petr about places where the original list was accessed without
> lock protection. Note that an older version of this fix used an xarray
> instead of the list. The xarray has more overhead and results in an
> increase of ~25 microseconds to the average latency for processing Tx
> timestamps. The list is simpler and avoids this overhead.
> 
> Next, the PTP reset flow is fixed to stop tearing down the Tx tracker
> during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
> permanently after such a reset. This issue was found by Sashiko during
> review of a previous version of this series.
> 
> Next, the ice_ptp_request_ts() function is updated to sequence the marking
> of the in_use bitmap in order to work properly with the lockless reader in
> the IRQ thread. This issue was reported by Sashiko during review of a
> previous version of this series.
> 
> Next, come two fixes for E822 hardware that were originally posted as part
> of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
> work task is properly canceled during device reset, and new timestamp
> requests are kept disabled until the validation task completes.
> 
> Next, Arkadiusz modifies the driver to stop pretending that the link has
> gone down during ice_down(). This removes "virtual" PTP link changes that
> occurred on several flows including MTU change, Eswitch setup, and others.
> Now, the driver only triggers a PTP PHY timer reinitialization when the
> physical PHY link has changed instead of during many other actions.
> 
> Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
> bit. This bits only purpose is to tell hardware to mark any captured
> timestamps as invalid. Since this also disables the necessary side effects
> on read it is problematic to have cleared. According to hardware engineers,
> keeping it enabled should not have any other side effects.
> 
> Next, the driver is modified to clear the PHY_REG_TX_MEMORY_STATUS by
> reading each index *prior* to the PHY soft reset. This ensures that any
> stale or invalid data left in the memory array is cleared, followed by the
> counter being reset via the PHY soft reset procedure.
> 
> Next, the E825 timer start procedure is modified to first include a soft
> reset. This ensures that upon link up the device is reconfigured from a
> known-good state with its internal counter reset and everything cleared.
> 
> Next, Petr modifies the ice_ptp_flush_tx_tracker() function to wait a little
> bit for any outstanding timestamps before flushing.
> 
> Next, Petr modifies the ice_ptp_process_tx_tstamp() function to avoid
> releasing any index from software unless either a) it is actually completed
> by hardware or b) it is timed out waiting for a full two seconds. This
> closes the final gap from the second issue mentioned above. Instead of
> immediately releasing the index, the software now waits until hardware has
> completed it or the driver has waited long enough to be sufficiently sure
> that no such timestamp will be done.
> 
> Next, the driver is modified to no longer mark timestamps as "stale" during
> a clock adjust event. This avoids marking timestamps as stale unnecessarily.
> 
> Next, the ice_ptp_process_tx_tstamp() function is modified to verify
> that hardware actually cleared the ready bitmap. This ensures that we do
> not report false timestamps near a link down event.
> 
> Finally, Maciek adds a needed PHY recalibration for E825-C after large system
> time adjustments. Without recalibration, PHY timestamps do not properly
> converge to the new time, resulting in inaccurate timestamp readings.
> 
> Link: [1] https://lore.kernel.org/intel-wired-lan/20260720120151.2675206-1-przemyslaw.korba@intel.com/
> ---

Sashiko had comments for this series, primarily around the RCU list
iteration. After some digging, it seems like the pattern I tried to use
won't work. I had tried a battery of LOCKDEP and spam rmmod but still
didn't manage to trigger any issue.

However, it seems like a simple solution will be to switch to sleepable
RCU so that the RCU read sections can safely sleep instead of trying to
be complicated.

I'm working on that change now to update to submit a v2.

The other feedback is as follows:

1. Regarding the choice of waiting only up to 15 seconds:

> 
> Can this timeout lead to a guaranteed use-after-free during PF teardown?
> If any thread holds a reference to a port for longer than 15 seconds,
> wait_var_event_timeout() returns and the memory teardown continues despite
> the outstanding kref. When the delayed or stuck thread eventually resumes
> and finishes using the reference, it will operate on freed memory.

We could change this to wait indefinitely. In the result of a driver bug
failing to release a reference results in the driver simply never
unloading. With this solution we wait up to 15 seconds and warn. I
suppose there could be some convoluted sequence that allows a reference
to be maintained for greater than 15 seconds and result in
use-after-free. But it does require creating this stuck condition, and
in either case its a driver bug. We felt that it was better to not block
indefinitely in the obvious and most likely case that some flow forgot
to kref_put vs the much more unlikely sequencing requiring somehow
delaying one of the iterations for an entire 15 seconds.

2. Regarding removal of the ice_ptp_release_tx_tracker()

> Does removing this call introduce an SKB leak and tracker memory leak if the
> PTP rebuild fails after reset?
> Without this call, the tracker is not flushed and tx->init remains 1 during
> the reset. If the PTP rebuild subsequently fails (e.g., due to a hardware
> timeout), ptp->state becomes ICE_PTP_ERROR and the PTP interrupt remains
> permanently disabled.
> Because tx->init is still 1 and the link is up, ice_ptp_request_ts() passes
> its tracker check and continues to accept new SKBs for timestamping:
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_request_ts() {
>     ...
>     if (!ice_ptp_is_tx_tracker_up(tx)) {
>         spin_unlock_irqrestore(&tx->lock, flags);
>         return -1;
>     }
>     ...
> }
> Since the PTP interrupt is disabled, ice_ptp_process_tx_tstamp() never
> executes, so these SKBs are never processed or evaluated for timeouts,
> piling up indefinitely.
> Furthermore, when the driver is eventually unloaded, ice_ptp_release() sees
> the error state and takes an early return:
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_release() {
>     ...
>     if (pf->ptp.state != ICE_PTP_READY) {
>         mutex_destroy(&pf->ptp.port.ps_lock);
>         ice_ptp_cleanup_pf(pf);
>         if (pf->ptp.clock) {
>             ptp_clock_unregister(pf->ptp.clock);
>             pf->ptp.clock = NULL;
>         }
>         return;
>     }
>     ...
> }
> This early return completely skips ice_ptp_release_tx_tracker(), permanently
> leaking the tracker arrays and all stranded SKBs.

Perhaps we should tear down if we fail when going into the error state.
I will need to investigate. This may best be served as a follow up fix.


3. Regarding the in_use bit cleanups with memory barriers

> 
> This is a pre-existing issue, but does the fix appear to be incomplete? While
> this adds the necessary writer-side memory barrier, does the lockless reader
> side also need a paired read memory barrier?
> In ice_ptp_process_tx_tstamp(), the reader iterates over the in_use bits:
> 	for_each_set_bit(idx, tx->in_use, tx->len) {
> 		...
> 		/* Drop packets which have waited for more than 2 seconds */
> 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
> 			drop_ts = true;
> 			...
> 		}
> Without an smp_rmb() after discovering the set in_use bit, couldn't a weakly
> ordered architecture (like ARM64) speculatively load tx->tstamps[idx].start
> before verifying the in_use bit?
> If the reader loads a stale start time and sees it as older than 2 seconds,
> would it mark drop_ts = true and incorrectly free the newly queued SKB?
> A similar lockless read of tx->tstamps[idx].skb happens shortly after:
> 		ice_trace(tx_tstamp_fw_req, tx->tstamps[idx].skb, idx);
> Could this also lead to dereferencing a stale or NULL SKB pointer?


I think strictly we would an additional memory barrier when reading the
in_use bit. Will fix.


4. Regarding removal of ice_ptp_link_change

> Does removing this call expose a race condition during initialization?
> In ice_ptp_init(), if a physical link-up interrupt fires after 
> ice_ptp_reset_phy_timestamping() completes but before ptp->state is set 
> to ICE_PTP_READY, the interrupt handler will call ice_ptp_link_change():
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_link_change() {
>     ...
>     ptp_port->link_up = linkup;
>     if (pf->ptp.state != ICE_PTP_READY)
>         goto exit_kref_put;
>     ...
> }
> Because ptp->state is not yet ICE_PTP_READY, it aborts early without
> configuring the PHY. Previously, the call here in ice_up_complete() acted as a 
> failsafe that would configure the PHY once the interface was brought up.
> With it removed, if this race occurs, can the PTP hardware timestamping fail 
> completely and silently until the next physical link toggle?

I don't believe this is correct. We now initialize the link state to the
current link status when initializing PTP. Additionally, the
ice_ptp_link_change call that triggers on an interrupt handler also sets
the link state before checking the PTP state, so we will then be correct.

5. Regarding the soft reset in ice_start_phy_timer_eth56g

> 
> Does this initiate a 10ms PHY soft reset without mutual exclusion against
> concurrent Tx timestamp polling?
> A link flap triggers ice_ptp_port_phy_restart(), which takes ps_lock and
> initiates a PHY soft reset via ice_ptp_phy_soft_reset_eth56g().
> Concurrently, the PTP Tx interrupt or periodic watchdog executes
> ice_ptp_tx_tstamp_owner() -> ice_ptp_process_tx_tstamp(), which bypasses
> ps_lock and issues PHY reads (e.g., ice_get_phy_tx_tstamp_ready()) via the SBQ.
> Note that tx->calibrating is not set for E825 devices during this process to
> temporarily halt polling.
> Accessing PHY registers over the SBQ while the PHY is actively held in soft
> reset (between the assert and clear of PHY_REG_GLOBAL_SOFT_RESET_M) causes I/O
> timeouts. This can lead to SBQ timeouts, firmware lockups, and internal
> timestamp counter corruption.

This is hallucinating behavior that doesn't exist.

> Furthermore, ice_ptp_phy_soft_reset_eth56g() manually clears timestamp indices
> without locking out the polling thread, creating a race on the read-to-clear HW
> mechanism:
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_ptp_phy_soft_reset_eth56g() {
>     ...
> 	err = ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> 	if (err) {
>     ...
> }
> Does this PHY soft reset wipe the Tx timestamp interrupt configuration without
> restoring it?
> The soft reset restores PHY registers to their default state, which would clear
> PHY_REG_TS_INT_CONFIG.

The soft reset doesn't reset PHY_REG_TS_INT_CONFIG.

> While ice_start_phy_timer_eth56g() manually restores MAC, PARPCS, and 1-step
> configurations, it omits a call to ice_phy_cfg_intr_eth56g() to restore the
> interrupt enablement and threshold.
> This can result in the loss of Tx timestamp interrupts on the affected port,
> causing timestamp polling to fall back to the slow periodic watchdog or hang
> entirely.

This entire block seems to be hallucinating PHY behavior, so I do not
believe it is relevant.


TL;DR; I am working updating this to use a sleepable RCU context which
should address the majority of the complaints from Sahisko, and I
believe the remaining complaints are not valid.

Thanks,
Jake

> IWL: https://lore.kernel.org/intel-wired-lan/20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com/
> 
> The following are changes since commit 78445023439506ebd83b86d40b1e428a3b309d4a:
>   Merge tag 'net-7.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE
> 
> Arkadiusz Kubalewski (1):
>   ice: call PTP link change only from link events
> 
> Jacob Keller (9):
>   ice: use reference counting and RCU for PTP port access
>   ice: fix removal of PTP timestamp tracker during reset
>   ice: set in_use only after preparing Tx timestamp index
>   ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
>   ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
>   ice: E825: perform a soft reset when starting the PHY timer
>   ice: remove unnecessary discarding of timestamps after clock adjust
>   ice: skip reading Tx ready bitmap on ports with no timestamps
>   ice: don't clear in_use until HW clears ready bitmap
> 
> Karol Kolacinski (2):
>   ice: E822: keep Tx timestamps disabled during offset calibration
>   ice: E822: cancel offset verification work during reset preparation
> 
> Maciek Machnikowski (1):
>   ice: Recalibrate PHY after settime64 on E825-C
> 
> Petr Oros (2):
>   ice: wait for in-flight Tx timestamps before flushing the tracker
>   ice: keep Tx timestamp slots tracked until completion or timeout
> 
>  drivers/net/ethernet/intel/ice/ice_adapter.c |   7 +-
>  drivers/net/ethernet/intel/ice/ice_adapter.h |   6 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    |  12 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 358 +++++++++++++------
>  drivers/net/ethernet/intel/ice/ice_ptp.h     |  12 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 104 +++---
>  6 files changed, 326 insertions(+), 173 deletions(-)
> 

