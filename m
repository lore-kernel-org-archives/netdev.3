Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68918C008
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791500645; cv=fail; b=ZHtqCmgqknZ+O2I1gO/2ekd2qu9N7dvrJee6SeUZYc08OIvN+aqeB3IRWRgjDgITxAQVycJzPeaOUYsoj/ZyJ0d2PLG1gG4cyDn1bHrC9Soj2MqWygZlSUbmZdoI/XLzsiF074OIgAXGn25sMUrCyV5dlrLhm1fxdUD/5XK+jyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791500645; c=relaxed/simple;
	bh=b8F218h4K55RwFBFtkCE1+SbubWeNu8Qdl0ACWHfYA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKgQgJf7UIkrDMolNRIXIZK/n3ZpVlvrsr01Qlc/NBFE3XN4ekHwQMfpDJe/SPL5yZBQHfbQx1U0Lc0hnKfPXbIaC0EVf4y2yYSL8w2Lbxen+TO3hpDMI32w4PGeycu9FP4veuoLmVxbqGmI/l7EncEIMfelYZxf14h0bjvbEbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcaiqrJ1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcaiqrJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791500643; x=1823036643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b8F218h4K55RwFBFtkCE1+SbubWeNu8Qdl0ACWHfYA0=;
  b=DcaiqrJ1EBFvvqNt1ubGAsIdg0cNXJO3bSlqZqj+FnJQ7+AAiedDDoio
   DQbdyS0+jUdEQKie6CwjguyDBI9aJveZMXofrr91oPvkmEY7+qsQjZ/hu
   OlPRxnu9OSWTrd3Qnk1LUjHU3J9s9IoKZyy3h+Vy16IZ6NLUACAsOQL1B
   QcRnkS6jeiC1Y6piMECLXpTGA4hh1kr0XwzvS+oaTD5gRzVHa9flj8mQd
   8Mda7ZCuXZ8NAEYfsHiokaWPxcqwB8TqWOVkd6x/FugQvNkta7JAUKksu
   oF5NsaLFEuOezOymvWaMgq8cQ9v4mPB/fZbIl+G5NKWRpb06TGIIQO9Vd
   w==;
X-CSE-ConnectionGUID: ud3YAfmTRaylksqceW3qEg==
X-CSE-MsgGUID: Y1udHF8nQjKwV7Xlic6Dlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="307022"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="307022"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 16:04:01 -0700
X-CSE-ConnectionGUID: jBaBgDJwT+Gt5Jkcn/lHNg==
X-CSE-MsgGUID: uskPi5QAR3OcyeNJoYgK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="111264"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 16:03:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:03:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:03:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:03:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujpdpxqOV1+GMCu8zzGK1IxV9jK1eymixzW+duI2mE6+qSQRWLb+X7F85E80JJgjmtx9yZFsrwUmqqUlCuOZey1YlWPmi6fccgTGXVjfSe44W7PBb9EepoAJHZ4xGOjbdn+jcxMBrjNUlqdIcv/KaEYSMl009A5flggKYzh0sapXCmbKF8/bCEwbsi9lzFwfpk9WCEcS8og8ce+EFALOrLO6Fd7k7cL8DSQgCQI2HnCIyMx212GggiQIYSYXR9l4sn2IbTFZfT0FNBhLKtmfqvMbV6mN4ZGHjRIYuKUKGlmvBzvVmGgl8reVzgkwJJA+bA9kkRgGyMS4hj7V9zJPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y36uyAO36zqT3Z/lpg0viYkQ2x7lSrRdQqp8R8a0YqE=;
 b=Z0x4Nh40uFkOn5XqdPL5FeOvfEkcRb3j76G44xc7AWZtcdwPsTXncRocSi+cwxAvjKVN9Z3qeYbpED47em/Iur+Laktu+/BeEneKIaa4VIDNta/6akGZjWULsmKCRAqPG0eOumMrYts9aC1iGk92ORn9t+Aq2ZcU8Lh92LmuVc9LwS1mKPSprZWYK8qjw1mC1WDRTEoJ74sWWw/ACr3xjRDFndgXCZ2NeQK189vY2L5vlZcsChHbwdH3TH8Ok340bqY1FWiPBy8NurT7fCCbqX844h3xVRwLFfpGZMWsVjJ5j8Giift2OhUysTROuD27FN1IVklJDUsVtkZBwFo9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by PH7PR11MB8035.namprd11.prod.outlook.com
 (2603:10b6:510:245::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 23:03:35 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 23:03:35 +0000
Message-ID: <2bba3179-a471-4fce-8252-d9833d3024b5@intel.com>
Date: Thu, 8 Oct 2026 16:03:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down
 vports on shutdown
To: Tian Xun Ng <luckilystar08@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <aleksandr.loktionov@intel.com>,
	<decot@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
	<tianxun.ng@bytedance.com>
References: <20261007055741.30629-1-luckilystar08@gmail.com>
 <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
 <20261008065426.86267-1-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261008065426.86267-1-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|PH7PR11MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ae5298-a785-43da-c719-08df2590615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9JhrzuLglKf5ZHZQOUO7M4oScEaNeOYyb/ftyiaSAO8GvgIs6bHW0ZIIWGdHBVj7DBusLDTEJS4uA6IUfhs/p7SvPd1IPmfPJpH+mj2HDGpqqNfKNnqefcQkGzQ+e3NoOlqerq0+07fx6WFVJMC1lQqrWkRHu/ji1rL6RKwIBVus5ns7IhTiWUk96/IkZz9zOPa5keUpbP1ZuUrPGfQDk+WieLDiYSTrmO0bvQGVAYkVQKExUcpATOcGZlY5aacvfmWGoHjw5pTJvXPIfGAPMM6jPJATZuEfOVQEkNeZ4cU/3HBWdPSRJcG9HzNfXUSrUahDa6CvhgouEBSqoIryFamu2HkU98xoAiOc5vnEJPC8OwWccwBM7oGsoRACs5f/Zz1Eacwp+phSgVRrxIG0MU3VTuYl3H6yDlP872Vur7ZcrXkJxy8Bjj8x0ldutFnRyl232sbTFaSf/SlF1YivWCME4aRY5Y/aJHUnRG7K+0QhDR1t8hDAUiekCecRBBdclXLbu1G8EuDgDBXIu/3B36sqWYEmxP0PttPsb6STetjazjNKSgCKC/Mrzg7Pj6vVS8a3+7WPWhQ+S65V8HyHoYVYyOjiKni2VqJi/HjLA4wMhNN0jXzIqeFtr+B38vhM+nDjCZDPczG+v7JqSys3WNaE/2tqyQEyHEnKAhcRO1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBtZGZPb1lvV3pzNmtRTlY1d1VUdUhMU3lDWDRSbitSZ1ZBcWx4N251K2Y2?=
 =?utf-8?B?dzRaOW4zTE4xWlFIelJab05wdnFVK20zcmsyZWZwUnI3clQvOXlad284QUNC?=
 =?utf-8?B?bXJtZ25zZEZHSzk3WWtaLzcxUVdrS3J2anYyV25uNkpRSi9ZZkFTUWtHZDNF?=
 =?utf-8?B?Q29rQS96K3kwbXQ4djlEdjU3Rmk1UzFmZ3BGNE9TQkZqL250OFVlUTR3Tk1x?=
 =?utf-8?B?Zk90cUlOZmJtNXh2MHpMdHBuTCtCR2hBdGt6Vzk4Z21NbVlna3J4VmQ0Yzlt?=
 =?utf-8?B?bFpFOGlOYThuOGkyT1JBcEF3NHVNaVhNTzFJayt3aHRmM1FqcWx0VE9Ddmg2?=
 =?utf-8?B?L0prTXl6UDYyTElZUm5GSjBlYXZJbWFBZXdDNERaY3BRZW1tcHNMODZXVmNj?=
 =?utf-8?B?eEF2N2E5TTBLRU1SK1VXd3dkV014aXdRaWZ5RDZpOUZCUlJ6elA4MUpWZUVj?=
 =?utf-8?B?L2c5OWluQS8yWDhWNUZxemNtRmFuZ0NicDlSMGh2VlpnU2w3SVI3SnRmeEZs?=
 =?utf-8?B?RGUwREUvRzdGcHBQOWVQYUFoMHREN2tMZVd2WTE5VzVIclVLOE02cUJOWkJX?=
 =?utf-8?B?UkJ2UXBUSjIxMkNQZlF3dXRqdWVKVW1zOUMrQVYrNWcxaU5lQU9IT0cxMFYr?=
 =?utf-8?B?OXJQbm9xSUZzSTVRckttUVhQMFBZaHFsdThXTTFZaThyaGw2YXRCamNwU1Bl?=
 =?utf-8?B?MWliOFNQSGRUZEVqbHRzTCs2OHAybnFUU3h1T2g1NWI2ZE9RMlhZWjVaaHo1?=
 =?utf-8?B?YzdzVkQrN2hZOG12TWg5aEtFWDlwUU9QVEx1ZGkwSzY0ZHJvdCsyVk9rQ2h6?=
 =?utf-8?B?RVE2R3RFdW5NNjQwZmdYZURMdDhSWlRoN2NzQW9BclZJZ1ZCMEFiRlRWNXg5?=
 =?utf-8?B?bWp2VExMZW1IMEk5KzlUOWZNcmc2R2tEblB4WldhWnIvbzdkU2pxZ2RwcUYx?=
 =?utf-8?B?N1c4eXBSYmNubzZ0VlJUeWUrVFcvQXJYK0E2aHZ0SjNRQ3N5VkVKRHM2Um9i?=
 =?utf-8?B?THo2N0FBYkdObmxUYkxYMUFFYTJpQTNWWkNYSHNHY3RCMllKK0owLy9GWk9G?=
 =?utf-8?B?Z0ErSEhrcjlFRkZJYnZaVnhHbUZDdTFKQnFselFCN0ltNExMMldITFo4bmlz?=
 =?utf-8?B?djN4dzJVY2NIQ1BMVHhTUXF5VytjOWE4ZDNlMEhyc3FvNEV6Q1p1TkJPOUpa?=
 =?utf-8?B?S2ZjY0tjUmhUTEdWeldRM05ZcVU0ZlFZVWNtc3FFZ1JsdE12VzRseEtDNFRI?=
 =?utf-8?B?M1cvQ0JManpsTVZycVpDTXlreDJjclREUzlDMjVka3RWVzJXRTUwa1RYN0dq?=
 =?utf-8?B?Q0Vzd2gzYTI5YlBtR05aTzk4NjF5V2ZpLzZLMWwyZmZEaHY0QUVHeTJ0SHcx?=
 =?utf-8?B?U1JVcVZwclJRUW9rYWVnSk1pdmUvQTUrZU1IeUx5UHBsdldXMFRhV2JSVHB4?=
 =?utf-8?B?UkJvZlpkaTI5SHZkYWZ6N0Y0YmQwMEdYbVRocnFZaHc4UThyb05PSDB2anF6?=
 =?utf-8?B?d256Vmh2eDJOS1Y5QURvbVcxZDNGN1FZTkRwaC9iVThmajI2UlU1UVA0dWZK?=
 =?utf-8?B?MVNwQXFVVVpqejhQNjRxZWpKdmhBUlI0Q3I3SzEzajB4dE90RUs0OTJoZHBM?=
 =?utf-8?B?Q1RBMG05ZTdvZm8xeE44K0hLdk9uWm5NTTdQYko0Uk5EUkxySDUrdXpVZVdz?=
 =?utf-8?B?MnlhZ1FuSEQvZkpXVjBPY3BjZDFRalFGZlRPZWVzNyswL0M0dG9kN1JvNVlH?=
 =?utf-8?B?V2xBNHhLOUpmSmRvWTZLQ1JpQk1ad3UyRWlBR255d2o4RnNsRlFXZmkrU0NO?=
 =?utf-8?B?dlJxRVlvUnFWL0FPdEF4N3lGMXBuQklTc0JubXlWcWVNR0RpMDJPa1o0Y2Js?=
 =?utf-8?B?aXdsNDZ5R1B0bUx4Y2xJL21GRk92eU80aFUyOFJJbUh3czQyY2VOeUtSRHl5?=
 =?utf-8?B?QzR2NXo0YUk0ZENMQ1gyWWM0RWtjWnBNWXVQVzExSVpBNTRDL3dtdDRmaklq?=
 =?utf-8?B?eXNkMm1GSjBldUtrTURrVk5VRFF5eTc3bng4VGpmYUlKTlNiSng0Vit5Yktw?=
 =?utf-8?B?L2lZM1JCTkIyUm1nYTZmcWpkeTRqalVLekk5Qkk1MjVGRjRvRi9EdWZoMC85?=
 =?utf-8?B?Qlk1cHpQcmpLV01rUDdVUGY1Z1lBRVh2ei82TmVKa0hBWHdFaWgrOHlmcVNB?=
 =?utf-8?B?SVlvYlQzcW9Dd3dYQUFETENXS2pMZGlHSHdrYUpxeHlIMkk4ZDh4WVZKMWND?=
 =?utf-8?B?M00rMkZRaHRsVVA0bENOOThYWTVDWnhOeFdPbXdBVG1CV285ZlNTTXFaL0ly?=
 =?utf-8?B?Z1lqMTYxZXg5WldyK210VHhWRldHOHhoRzRYcWhxWUhVUk5TbitEK1hJalNB?=
 =?utf-8?Q?Fx7n+Xou99H7KVMw=3D?=
X-Exchange-RoutingPolicyChecked: bkI/PW79miSzWpqNgM4L5oI/nNDUjLtA5UYZ2Uzjypf+WSyCwfgAX3qjkVwuyM5fzCGjNWSqZ3fTQaIIJP6qaghNwuajmmPZSS/j9vFYDHSxK+yLp4ukw9lh4NKeGAIqJ8f4XyatnIbBcR0H0r9OcPV9xtrIH4U7XrmwZXPWKnG2oO1KLyVIzMRx3GBjGMWDzJ5gcdAMP2cABC3nuoKOTamWQxrgrSOtY8lUx3kEvugo2fkGMBI4Z8lhI3d2a4c4gx2pqc9XvOsjhYnqAZm5iQ6VjQ9QgXZ61nxIGTUQ3LYSIeJPOkR4qSwLNjRwPcQ3BfsVqIZisZtE3NdZ2DzupA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae5298-a785-43da-c719-08df2590615d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 23:03:35.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIjQgVlxXodkPhHI4znsrUn24usQbAI3OxKe4hJKQPSKYK1Je71u5lLdCLmOoOO6m1nfwXP9EMwtcGgY0C8wzoGwuBmveL5nbWIsB+WxX9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com



On 10/7/2026 11:54 PM, Tian Xun Ng wrote:
> On 10/7/2026 10:07 AM, Tantilov, Emil S wrote:
>> I did a rough draft, keeping your logic and I think we
>> should be able to avoid the new flags by introducing a global variable
>> adapter->vc_xn_timeout_ms and set it based on the flow we're in
> 
> Thanks, that works well. v3 is ready along those lines: no new flags,
> adapter->vc_xn_timeout_ms set to the default at probe and to 500 ms in
> idpf_shutdown() right before IDPF_REMOVE_IN_PROG, and idpf_send_mb_msg()
> caps each transaction with it and sets it to 0 after the first
> shortened transaction times out, so the rest fail at once.
> 
> Backported to our 6.17 kernel (two arm64 servers, two PFs each, IOMMU
> translating): no faults in 30 warm reboots. The slowest teardown
> message is still DEALLOC_VECTORS at ~300 ms, sent after DESTROY_VPORT;
> the queue-related ones took at most 158 ms. With the driver made to
> skip sending the teardown messages, the first one timed out at ~500 ms,
> the rest failed immediately, and every reboot faulted again.
> 
> Before I post it, two things it exposes that I would like your view on:
> 
> 1. Setting IDPF_REMOVE_IN_PROG on shutdown also moves
>     libie_ctlq_xn_shutdown() after idpf_ptp_release() and
>     idpf_deinit_task(), as on remove. mbx_task keeps running in that
>     window, so an async PTP Tx timestamp reply can reach
>     idpf_ptp_get_tx_tstamp_async_handler() after
>     idpf_ptp_release_vport_tstamp() has freed tx_tstamp_caps. Remove has
>     the same window today; shutdown would now have it too. An unmatched

If I understand correctly, this is referring to possible UAF in the ptp 
release logic ... I can't say for sure, since I don't have your patch, 
but I think it is a valid concern. Your previous patch would have the 
same effect, so I don't believe this to be new (as result of the 
refactor) and would be an existing bug in idpf_remove().

BTW, I should mention here, you need to set IDPF_REMOVE_IN_PROG before 
cancelling the tasks in idpf_shutdown() to make sure the event task is 
not re-queued.

>     VIRTCHNL2_OP_EVENT (link change) has a similar window against the
>     vport being freed, which exists on shutdown already.
> 
>     One way to close it without new flags: once IDPF_REMOVE_IN_PROG is
>     set, cancel_delayed_work_sync() and requeue mbx_task, and have the
>     PTP callback and idpf_recv_event_msg() return early when the bit is
>     set; matched replies are still consumed, so the teardown is not
>     affected. I can send that as a prerequisite patch, but I cannot
>     exercise the PTP part here (PTP init returns -EOPNOTSUPP on our
>     parts). Would you prefer that, or to handle it separately?
> 
> 2. A transaction that is already waiting when shutdown starts keeps its
>     own timeout. For example a GET_STATS from stats_task, which is only
>     cancelled in idpf_deinit_task(), can still hold shutdown for up to
>     60 s with a dead control plane, where the early xn shutdown used to
>     wake it. Fixing that would need a way in libie to expire waiting
>     transactions, so I would note it in the commit message rather than
>     claim a hard bound. Does that sound right?

Yea, I think solving this issue in general would probably require 
changes in controlq. For the purpose of this patch limiting the delay 
within reason for the more practical cases is good enough.

Another thing to note, in your previous patch you had a comment:
+	/* Destroy the vports while the mailbox is still up, so that the
+	 * device stops its queues before the next kernel reuses their memory.
+	 * A reset does not clear them on every device.
+	 */

The last sentence is incorrect - a reset must clear the vport(s) state. 
This patch is still warranted as we would like the driver to gracefully 
signal the destruction of vports, however documenting FW bug as a fact 
is not OK.

Thanks,
Emil

> 
> Thanks,
> Tian Xun

