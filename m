Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793374535;
	b=zQV9hslW9BDpwDurmMuVRPBjE0RO9g0wbjQWkm56ZH54xQdN/ik0dcoBXaPh1Z1Gpc4Y
	 50HnIEcVniK/qIh1z9B90BB6RvNzG4VSGFw+WGvYsdXIJFwnvQDsU+xbXsKE6O6PVedTu
	 j73Bw2AcgTH9+bz6Lql+4Rk6KQjO5cy0ZNOJa81U7Ta0W67JCLBGUQdE2vZOhs5NyT2se
	 4sg2YtatAYvvFEoEZdOlfSZx9I0tdFu5g83bPBVBHIHBdffMGTd8L7JRot94Rx0yYzGvP
	 Z5h1onpmIn7qXJI7G5fB5EQGBbDCjNmSX3NfTQ4NpClVelwOvsokbRi+S33vDa3oCcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=ER6YDPP1rBLp1ZGxBM9Am6tMgfb/xmNMpdowZy+wRq4=;
	b=t+WNLSd3YBu6ZPynNSrjLrDHpZx3in6j3R4JR/3cFd4bLndDwHW0xo2wEaQ/RjocZYag
	 OBTU+hcLj6nnI9VoedFN5x84ntMTp4zD10dMkPytLdTDt/F4n9AL8Lgk2fHBJ+Bc/EVio
	 4b6WMjP/eIK3pg4vSLQr6vgq/PSQI2X72lYMxpzOtjpOHMdSNhOPdaMjdio1ikeLLCeDW
	 NeDXvD8g/xwxDlcgSEXpj0wfUzL9eqsOKI5lAgGioYF2i23MSVaHvFsohWRgyB/y7eDTL
	 kUm4qjSzn8YB9AFsmsKPYQiZxMrkDwoYtxwhyhH68dOSYhcVsNbTkubehzmaS5nwh0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GduDMHEd;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B2606A329;
	Fri, 30 Oct 2026 15:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867B2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GduDMHEd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793374535; x=1824910535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+C8yKhR+gRLql8NlBeyf3Ih/xWGsIyHy/dKe2te41Iw=;
  b=GduDMHEdXXr8y/Np7/SXsSmlPGdaWnWwN0imHBDxNl1WT69QttbQlC5q
   zZt5m16X/E1ndITKQ5kHM47uR9tstNKH0h+oHdv2q2Yf64Nc1cBPXQWO6
   trEpzNhZj+mhvpF439s9/sAxcUEv01omZFYMrAN8KludqX7/JVi9bP8Fx
   SB2BvL0WvjjF1Zn3t5i0FuPxC6Pj4yOx/bHlAlX9DDQrBjWOQonpoOhwm
   dLd28d7LOcnSFheejiUcdVtGSVvSIxXLXg3LIwWd9yESp67RCPjDIdcDr
   1VF65oit+UG30e/UI17vEgXnleT7l665zL6qeuvuRfDEWf5T9qZPsTJ1b
   w==;
X-CSE-ConnectionGUID: ivSnVAbGTEyJZoLl/Dkccw==
X-CSE-MsgGUID: 9uOIzK5wTUalt+HmGNoFyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2134458"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2134458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:35:34 -0700
X-CSE-ConnectionGUID: 7c8P7VKXSaK/RnatDG7hCA==
X-CSE-MsgGUID: mqO1ZYLbQXiFDKMdpi5mPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5366949"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:35:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 08:35:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 08:35:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 08:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVD7Sh143MWMdDWWH/m6FUnKcgcfWqoNqmKtIVruxFJxQ8BT31ZSByLQ9hCC3auUzRw5Dj2lZ284ZddsNu7kxJccrZ7Ql3CHz545tL30v9mP/i87DRk9wfyGnlS7fyaVfgDU4rWIHENtR4bxOYokCVoZfX8ckYC8hgenS6QqNJRK/mHlbLtL7qaAFa7PynBCsKeHH4ZoOOezNjCQomQAS+GY1c9ffDgX8Qd/3gXOC4sSP9P76YihH5SvZkF7gD87DFSuF3nAs1+P37es/43zAWD/Po9R5wsmIpMOPFQRJTuqFQR8bwX5VPFDAuKF08zVmzWjpn0rboVij8T/IPzqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER6YDPP1rBLp1ZGxBM9Am6tMgfb/xmNMpdowZy+wRq4=;
 b=q7AMCuiit4WuLusF+YA7V2llWAi7sTTFjAzA5WwwvJRMNKa9Pg8RYmKLDfBb907BQJtFOj160V7fF9zEcNS1QyeMGS3NLZBX6GqUJUf54V2J6gHdz63GW1i55w/FqA0b1ttudjJnYLPdSHjLjoEaQJ+8w/9eQRFCUHnZfrgIBDGrpfRQ/g57Xk0HcnbytXg+atEFWjepZkEk9XEAvoEDDMbmsEMmqwpgjq2TedD4TeRn2xulBoQhpJXoa473M/S9jNhgtyLWXAbq9xs7IHV/S+XSiMz3Y4vrJQ7vKJ1pmm1hzbkk8RvYEFembQIwEgjTPHJu798DkbMVZg5TM3vF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4928.namprd11.prod.outlook.com (2603:10b6:a03:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:35:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:35:29 +0000
Message-ID: <03c17d6b-452a-463d-8b33-2a2aa1819ef4@intel.com>
Date: Fri, 30 Oct 2026 16:35:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: free the skb on TX DMA mapping errors
To: Mina Almasry <almasrymina@google.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Naman Gulati <namangulati@google.com>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261024030401.852598-1-almasrymina@google.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20261024030401.852598-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e69ab9-8f77-4ca5-5819-08df369b6d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261009223027099003|261021121427099003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 58BFAh4It0y7CcMQxDUjcN3NE0v4Ry7an3T2KIYYHRPM4nr+MUAA9vy4EXpnX3Gwjq8KWOsQb3gbzr6dOrIIe6lSU8b1Rjh5gvmV9EMT6vOuo49pZY/A3uC2yeJUrGFVUn6/FDIBdBsG7VNI78dmxtkJeb2u7CGwkuHnjxyNP2JZTrGzTQTA0hOze3GEcyLRN8FRn1UkwZAOYiYIc3ggo8jBeyGkIG7ID/+LKdiOV0pAteTfp6memZ+KMm5HcWcpKoFxNRxfv8Ath8BTGhH02q9YIX8Yi5YoP4q3g3Sq/bZkj23DE+aUHr084RYEA+wy8ZixH1BpuYBEyJAiFL0aTzCqCNt43mSgtTCi5ywGLyL0IAxGBaeZ9AwdIDsHKsPvNeV2yhY1ceP4dSyscrsrJfPAa3QuHmqILHuHkonUnr/1RDr7VC8dkcA74YVHZkoVNYrKlO2WnCFocRoN95S0wOsdKMIzLVdHRLvhj7xbJjV17gClkT1Opz5aukZhrFc5yYXzVziJ5W/x02w7FHZq7dE3Ftm6t6uGP0gyil2KuvJxCE/M/ba7gWZzSozdrVJHi6eGkH+3hCeWth7aeF/Z8WQ4I1oBA8/YQpEkNgjKbbKP4HgeMQRKQjdDDn6YIZu7N9QTf+4BftWaHtv2Zwzn5jJXvBhJ1G5YvT7yZWJVvRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261009223027099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L255OXdCYjBIWWtKOWg0SlJYSlZWeDNTUjF1Tnd0RVd2eUNtYlZIcExYTzR1?=
 =?utf-8?B?Ty9KSDFnQ0t4Y0dpb0gzSEZqaWFoU1ZleGJYKzNQZHdvWnp1aExpMUEwekZR?=
 =?utf-8?B?aktTVDkvRFNHa0pnY291d2tlSDF0ZGozdDVZdVJvVUdLYUtoTHVPV3JYRW5a?=
 =?utf-8?B?aDAwd2NETzJ0R1FtL05oNUE2NmEzdUVadTFtR25FdzlBd3dPc1BtQ0h5TlNT?=
 =?utf-8?B?Qm5KUnMvNzdSd2srckdvT2lWWjd5SDRFbUdYUWt2bkY1VXNVV3J5R1pLQTkr?=
 =?utf-8?B?N3dzU2J4RHBLcFFRMzVhV3l3QWhON2RDejg3SEtQUjJxOCtqZ1ZVdUFiRHZJ?=
 =?utf-8?B?UEtTZmtwa3lRY0pRemlPeWRidXhQdU1PVFdDaW9lU3A4S0ZBSjdJSW9ZdmpO?=
 =?utf-8?B?eTNuM1hrK2FUWG5ZVS9wNkErdFpITkQvOWg4RDMzVHJ5UUlpdFpvWWZ6elky?=
 =?utf-8?B?RkZzMGdIclRBUmNQSTBWMUgycE9hdzZ2Zkh3dHh6SDd4MWR1NXJQSG5yZWtE?=
 =?utf-8?B?WWhkcTVTRFg4NEpTUXNzTCszQ1dCRHlSaGJDemNTZFZsZWhCak9OczFkcHh2?=
 =?utf-8?B?VEwvN1hCSE5XWHpxQkVFMXVWNlNhU0VzWmxWaXhUVlBwem0raEZWZ0ZKMmVp?=
 =?utf-8?B?RmNSeVJsWjBxdERNd3NCMlYwSXJaT2FVVkNMRWdyaEJZdmRXSjcveWxSdk03?=
 =?utf-8?B?VnRqNXpNTVgxTHNWWWMyU2ZTRGVGZExoMGZuYUxwQWs5Tm1JQ3gwbi9QSGlE?=
 =?utf-8?B?YTMyd3pQdDRlMHVNSWZpalI5TDAxSWE2T0xUWC9SdlQrc08wV1VpMUk2U2hn?=
 =?utf-8?B?UVBPV1FjLy9Zc0tOWEM1dGVQSU91ODhrTDA2d1IzUVpod0lHbWRGSjU1VjNw?=
 =?utf-8?B?Y2wzUzBZenoyc3I5bndEZmowVUtNMWR1Uk1OOXZOcllNOVNIQzFHUVVpUFhG?=
 =?utf-8?B?TWlUUm5KWEhNWmZ2b1NLY2hrMUFZQ0JuOHY5blBZY0w1elNFOVlqNzJpTkhG?=
 =?utf-8?B?Y3dOZlNjeFZNdEcvZXN5RW45aUxNVVd6OUphcEpPQzFtVkFsQjJyOFkvQklm?=
 =?utf-8?B?cE5jWHIyZjc3bFd1NC9idzR6dEhIOFNGWTdkZ1pxVndJYW9sNjdCaDZiWXVO?=
 =?utf-8?B?QzlQcCs1M1ZxUnRhRldBMFIxQ3RTUTdTbjFhN3FKSUFzODdSVWVSME9tNlNv?=
 =?utf-8?B?S2p6RWtqSHpLZDVHQmhlUzhteWM1N3pUb1l3YkJqNWZiRk8xQVlQaElwMU96?=
 =?utf-8?B?RExOSXlhTGhqSm9rY3RXYlNVanRncVR6aHlxa0g5d25MdGx4dUQ2UEJKeGdk?=
 =?utf-8?B?Y3J4Q0YwV2FmNEp3WjA4bEhHenQ5ZXJrcDdwT29oUE1jOThWYVVOaXpabmhM?=
 =?utf-8?B?K3hpVVFIQmtoSGJ2Ujh4ZjUvU0JndG5kQm1ZL2JEekxIUk10UXdlcVkwaStw?=
 =?utf-8?B?aGtaeFlxMUxhOE5oQVBxVWxzblY4eDhxQzFPZzFBVzdrbmF0dkxCSmF5Vksy?=
 =?utf-8?B?OTMzdi91L245bmhlT2E0U3Q0TnNUeTU2VUFwRHQ4aGF4Q2ZveDVsMHovNnVu?=
 =?utf-8?B?OEV1ZHhYVi9FUnNSOHBOMXRqR25OMklwQ3NveEhEdDZqT3RqWERBQUMyZXdv?=
 =?utf-8?B?b0FoeTB2WGhDakQyN01QMkROc1RFVGh3bkFaUGN2bkRmTTBaM2NURnZ5SGdh?=
 =?utf-8?B?KzNXZnlPU01nRHlRNmdIc0FIenhxUWZZaEV3T2wwYWJLNUMyWm16RDBKTVRY?=
 =?utf-8?B?RmhSTFhQREo2ZEhZZWJZR2hzSkdVVTlXeUJCalNqRHJNWnpyL04yZ1BtR09G?=
 =?utf-8?B?UEFZMXRidnUrZFQxdThhdEdMeEsxYlFYVTJ6ckNRMGVaMjlQWXJjWUwrY28y?=
 =?utf-8?B?aG5JM0tvbkJvbWhkU0V6aGpmMStMRHNaTCtsK3ZBbXJQbk1wbjYxOW4rOGpP?=
 =?utf-8?B?WmRxR1RoRkhNN0RZVThGSldvYkRJQ3NzRVhzMXF6VTA4QmJjaUdhOVdqcUJy?=
 =?utf-8?B?TEMwc1JtdVVlZ2hHbm96cnJlUUovUG52L2R1UGNITnEwbmx5a1Y5U0NwNWpH?=
 =?utf-8?B?ZTJ2ZVk4UTJoTVNVTXpkcU5wd2lKbjNXWjBxbithYkNqTGJqUE43NHJGWGRN?=
 =?utf-8?B?QjFXd3RwZllKRHdSeFRQSVVwL0Ezd1U1RVREbStyWEFnRGZxVVpIRldaQ1Ir?=
 =?utf-8?B?WjJrYnlRRnhZeWVNbHlOaDlzZGxiMFM1K1dlNkdoOHhYcnh1aU1nZVI2VElW?=
 =?utf-8?B?c2hwRG50bFJuUnR6TjhTaFJqdHJDWlNMZlRzbjhzcTB4K2hWVWp1S1NaT1Zy?=
 =?utf-8?B?NHBCcXg1eWM5bUhyWjdld1RvVXZsYVhRc04waktGcW1MdE5iYjl5YzBTeVpw?=
 =?utf-8?Q?1saC1g/qC8OG6EH8=3D?=
X-Exchange-RoutingPolicyChecked: 0uAaDD/L4QeIR1mK+yGjkXTK45ZwahBcmw5U8xTwTjfJlOZhbMK6aAwpk7APBClIWC2C2n+m0dWduFIgmNJaB4J02q3j/SI8OOn98UzAccS1F5oehL4VqgP6R5S2gxSET/R7qUXZoXXjz5U2wcVp98oIT6ItuAx44coxwdz3Sa2Rjrukr0pUM3nrbA2h1yTi2XOhnC7BHbc4DM+nUg4Q0f25N6tB6l4NWX1DPIRLTj5lG8XV9htcuUQrYo8B/EFIL17DRxl7NIpGRcQsZicLPNgd1LfWLgf9quRlRbUKiyKahYD8StlXCXhco2pdNwwmPCWwNB1Z2qYLLupJBrgETA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e69ab9-8f77-4ca5-5819-08df369b6d4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:35:29.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyvJczO+hz5JbTTObCL+4+cO6EN+ibu7y4Mker2Kvf+X3dMX+HHvkdSiZstTQj4JTVTodt5YhCRg5p6lo+ZIt6p2GGo2xsJECE9t66hTvFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Sat, 24 Oct 2026 03:04:01 +0000

> From: Naman Gulati <namangulati@google.com>
> 
> When a DMA mapping fails in idpf_tx_splitq_map() or
> idpf_tx_singleq_map(), the unwind walks the buffers with
> libeth_tx_complete(). The first buffer is still typed LIBETH_SQE_FRAG
> (or LIBETH_SQE_EMPTY if the linear data mapping itself failed) at that
> point, so it is only unmapped and the skb is never freed. The callers
> return NETDEV_TX_OK and do not touch the skb either, so it leaks.
> 
> Free the skb at the end of the unwind.
> 
> Fixes: d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
> Signed-off-by: Naman Gulati <namangulati@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 2 ++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> index e3ddf18dcbf51..010903260ff6f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> @@ -228,6 +228,8 @@ static void idpf_tx_singleq_dma_map_error(struct idpf_tx_queue *txq,
>  
>  	/* Update tail in case netdev_xmit_more was previously true */
>  	idpf_tx_buf_hw_update(txq, idx, false);
> +
> +	dev_kfree_skb_any(skb);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 885df6294ad94..a92e2457781e6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2606,6 +2606,7 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
>  	struct idpf_sw_queue *refillq = txq->refillq;
>  	struct libeth_sq_napi_stats ss = { };
>  	struct idpf_tx_buf *tx_buf = first;
> +	struct sk_buff *skb = first->skb;
>  	struct libeth_cq_pp cp = {
>  		.dev    = txq->dev,
>  		.ss     = &ss,
> @@ -2621,6 +2622,8 @@ static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
>  		libeth_tx_complete(tx_buf, &cp);
>  	}
>  
> +	dev_kfree_skb_any(skb);

libeth_tx_complete() frees the skb.
Before this loop, it's called on @first.

> +
>  	/* Update tail in case netdev_xmit_more was previously true. */
>  	idpf_tx_buf_hw_update(txq, params->prev_ntu, false);
>  
> 
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5

Thanks,
Olek
