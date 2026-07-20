Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8A41A772;
	Mon, 20 Jul 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551850; cv=fail; b=RzCqx3MbLXLDay+/JvTPa1Zk/W9rPxOZEvyBCHlKoCRI924RtOdYqMFgICgr6UK1qZ40AIV0dQPaOPkzf48adiTc4aGBhnu0fF5+oai7WXj8ub+ptVCfiuS8kxlZHwT2KnhgKWDoXLX8f+5KsCLLzve6uQq+mpyXFOpf4syAWRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551850; c=relaxed/simple;
	bh=WLEdHKhhasNjqaAc/4EUOKDBg3aMDDMmKfkKNTiYSMo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMUajIUj+mBsFJ+tvTFCrVjPlvhkbYDCknznqvx/ah2ioFTDWVOGEydDqouZ68+eJSSwQ6QBlGfzHWZM/of0n5yz2BVUXC36tReqkxu8c5b79ZSWXswW51AyHwCP47LyiFkYdzpHGyzRMUdg24938ztsBvphgQz7jdCBud0lfns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxtbwTgF; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxtbwTgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784551848; x=1816087848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLEdHKhhasNjqaAc/4EUOKDBg3aMDDMmKfkKNTiYSMo=;
  b=NxtbwTgFYZQXyb798fTCzu+iifFNWAMFcifnbDRfw/YETqJptokDoQEz
   RukiN7uNG/hbCQC66xk66NtUErjW0JthJuV8Q9TtYKdCmTOcq3IpKWRd0
   9QgwOQIpd5mwhxvjThkGhdsxvhStyR/g8HqYFdmDZISzIVj1x9mBoFQLo
   dwvPvzwaVYy+OPzeYpijEURx7NM61EgdFOC+Wz2XyEtNg4FeeWOJQWwsh
   LhQ7TiunKbv8Lx2AynDCCJEWncC7n75fyUi2MzImcLWCzsutY1rYPf1Fz
   ri+a3XqNRveRjtGNx3kGz68ltEhSHxQTxha8gVtHTX49XGhCFZeQTafuT
   w==;
X-CSE-ConnectionGUID: W6cc8lnzRziAXNQ0sp/MBA==
X-CSE-MsgGUID: HU77SZJ2TsWRTxXmi0CUFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84256995"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84256995"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 05:50:46 -0700
X-CSE-ConnectionGUID: LhyDQzwmTiiT1hGj5a7UOg==
X-CSE-MsgGUID: wQDz9qGgRPG6ydA2s1/tsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="253074726"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 05:50:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 05:50:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 05:50:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 05:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3AB1CPplpPKVf7esmc/ICfJGclL2/jlmhBWCEKe6qjJZZyWlZXpqEWJZz6VGgUrjA0/Dg+4SbS7B/yn7sp8KHO/9WMmGV6jyEJ8v9VNKjs/9QvZWNEnmd6EkzThsf7ApiUtX699AWMAY7ud5RgnJK9jTVC4cvT+6ksKTh/KapXu5sY9yvCfTArfgwcNiLNhhZruXmhqn+Ke0VnYaBAubyq5znM958LhQA1BymugwZ4y8vBbkSoPEDpA0oEhiYtPXnBqAv5zpANVbiJY9K3Lbl8DQsxMt6SYou6PjYjWe2YlwD8sI+FqwrASME6Sh0QoyEFGE86/XRN5wzk1kh/KfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0OwhQEmRsP2XRm0LX3N58pXT23MBqA9cK3c58g0Ics=;
 b=qa5dvo/tD82itL3teFY4Bma+gZe1XNkT1znEGQhaGepvnpugm8wddSsNb35fl1j69AXBm1GPiiAYxQNmGYPe/5TFVilsPxkKXNo8DFARfxHUIBNUEdJqqwhBzg6BuSHYd83RNPv98xu5zaBaQ7uOZObDkq1We84DjFknkJeEcZR++uSunFPEJCteS9z8JR65ZBBYZvz3/9dzBz2hgaqbnF88vUGs1mOH+thz5M2gXmY1zT35RBLl+EZIDITQ8CAHxZhsnoyJWuVo/CTJ6Z4TA9T2h9Tkp4R1JJ0xOKrUwKNU0Fp6SSC70UQZd+frsBk2LGLSJutdcs/sA+my4bLCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH3PPF5D8CD6E8B.namprd11.prod.outlook.com (2603:10b6:518:1::d25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 12:50:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 12:50:41 +0000
Message-ID: <3b1e917d-52df-4b9c-8839-a4b65758b4e6@intel.com>
Date: Mon, 20 Jul 2026 14:48:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] idpf: add flow-based XDP
 fallback for FWs without Tx FIFO support
To: <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260708151327.1091570-1-aleksander.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260708151327.1091570-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::31) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH3PPF5D8CD6E8B:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f2f83a-0b37-47f8-17d4-08dee65d812d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: ghnpAAit2qo9EZl4zVG7CAj+1VEu2YXo/c7Uenxhbs1FXrPJiqaLe+PWvEFCpLyrOj+ac3xSmKZBhMuG/aWXrn12QRH8MYJhcS0h7tX19xyxyfdKvuYN+2+Pt/JferVe5flpkFSsVTnaQyWr+q0g4wvAz41TJ2taahykDGY+qi97hKTOXqMRlVTphS/RY6mS3n6qCQfSqaTcg+gRkNHDvwT95+ctjUTIfmq+bD8wXnTSY6NqxWRgtZNfjIC3aKYmptGiGfp6nTO/GUEpQoGxJH2tjYOllQzMxrL3RudjE1sqLQ/hCiBr2/ihy+5zwPd+VeOZDoTPj5013l/dMQGmTE5AQDBynX/JZAXuJq5mdqYEXWWHuTA/F9xDpOwb/hsed1HBniWCngpj4VAP/+CCAn+8aM4CkOuiy6dDGbAW5gX4bL/uKGWVzl8NNaxzD5RQfPx+Vrvd2H9+HzS1cVkMy9KG7vPb0sHZHLD95Ms70n6L2pmPZYo10xipGUkprY9zgRVpMvpTrmlj3vFyUW/nAWT4fJYy/EyfRZPJHl0DqXLJWd4QHFNdIxYwhvx6rXmK2ps8qw+9yryxAEUttf2S999nPM7MG7s+23HdadCQH7cWNiUnlA93aMuGNaWrM1O7MhHrmWSOTy7VCVw5DEeMAIlnsLaGw9fHr7Zc9vs6CCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJXYm5odVRKNGdDVVlpY3NqOFdPRFl5bzA1NzZIS0Q5TWZuMGNTMEdJVkFs?=
 =?utf-8?B?WG5MZEdMYkFrcU9zRldEUnRFQk1OV2hIaVlpMllxblVtaFRoOFkxQUlGZGlY?=
 =?utf-8?B?b2ZwWkU4R01PYjBKZ0tlRFdWYloyQVhNbzczaThZanZwZXBzaXlyS3hkYXVz?=
 =?utf-8?B?cTk5ejk2Y1JCL1BRcDBGeTV0TGtNcUxieEpuMTgya0Q0MmVSMXJDN1dpZG5N?=
 =?utf-8?B?bTF4YWZmOUtSRmVTdW1sZ3ZrVzc2WHRkaHAxTE1Cd0tDS1ZjUG9MRVQrdmI2?=
 =?utf-8?B?SEltYlRsY0ZmN3lNMzlqamtMT3NwbW1LWEtLbW9LcENtRXhvcmV6RHRCeVgx?=
 =?utf-8?B?VVBkeDZXd25DenRtTkdodVFSVlNQNUJtTHJGelNhQ3p4V3BiakJKWCtHVVRJ?=
 =?utf-8?B?YzVZeXJQbEJ5Z0FUN0tLUFJSbVZrc3FvREh6b0VseEtFY3VubllQdHBBMnR1?=
 =?utf-8?B?OUFrSHk4U1V3dzBybVE5WE1GVjJ4YU50aVNLSXlrSUdEaGV5WEQ0b3pmMG5v?=
 =?utf-8?B?WHFvWSt5SXJ6aFZpRGQzZ0xwYTdkUVRzaVRONlpVSVFMbGJyOXM0azZDMTZW?=
 =?utf-8?B?RXNYT1R5RWsvWDNHNjcxY1FCRW1wNGxHUk4yQU1BdjFFMy9Za0dQTGJ2M2JE?=
 =?utf-8?B?Z0w4K2o1RDVUTVplOXY0K002a1E0YnZvQkdyNDBUYk8reTVTSVRyWm00bkhV?=
 =?utf-8?B?ZE1PV2hUQTBhT0EyTnJ5VkwrTGkxWFN5SFpGd055RVJ0NmVrc0VhUllUSWZF?=
 =?utf-8?B?bVNhaDdReS9MZWE0dTBqYnZKMk5oZ3VUdEwrL1VURWZWUWRGVTlTMWdxZXpY?=
 =?utf-8?B?VEgzSzNweFJ1WXErNVFqT2toeEVhK1A2YnRlVUZpcEY0VjlTZHFZcVVjekxw?=
 =?utf-8?B?MHpzMFczUHMzZGI5K3RZYnpvajVCTVFIdmNWNG1QdGM4TXRzRUdYbVU4WVlh?=
 =?utf-8?B?TjAza2V2bmtDUlREZUxRbXNIVG5wLzhWenZQYytpTTVKd3pCUnJ1emVCb0po?=
 =?utf-8?B?ZGtKSVVqUlRwTHVvRUxSdXE3Mm4zdVo1cGNrNlVQSXhzTGtOSkRuc1lkaXhr?=
 =?utf-8?B?WXVhamlzRzNFYTJ5cVdUeXFQVk0vNUxxekIwRDRlU0xsM0lHa1JKR0NNdHlW?=
 =?utf-8?B?WVFhMzBBTnBHMjJCU3Qwb1hoRkE5ZlRrTmdLRHhLQW45NnpIOUlReXNNblEr?=
 =?utf-8?B?T1lOS0NGSDV4Wkk4WUxRRmVwY1kwOU83bHgvYm1QSUE2NEZ0VTNCWkxVcEt0?=
 =?utf-8?B?OE82bnc2S2I5ZldDcXhIb1BwNzhlV0NlZ3VKalpESFUxOXVHS3V1YVBkZFFN?=
 =?utf-8?B?eHIwWm9aM0NRNktDWE9aV1MwQVQ3d3BFd0VkU0JwVnJ4ZDA5d25jZXRKY3pP?=
 =?utf-8?B?a3R0SCtFazNYT2dhajBXQ2FXS1dzY0Y4UXRWaHNPRUJpMTlsTlE0YjVkUTJX?=
 =?utf-8?B?ZHh4VkpveG9NUWhFMFczT0txT3VmM0lSN3czQzROQXRiRzNsTytKeEZCbDhQ?=
 =?utf-8?B?S0ZWcVRhS2Q0b21TZFBSYXpTcnZ5Mm5DSzVuSmZlTjdnWTJUQnJqZDVXVlVS?=
 =?utf-8?B?RWJEV0hpR3laeFZnejhZSWNEb1ljdGpoYURVaWVhVEd2RzFLb1NPOGxoaU1l?=
 =?utf-8?B?Z0xKYnBkeTJSd0lZMkJWU1FvSWNpSjA5NXdzSVhsdTZwM0pvbGRGcnFKNDh0?=
 =?utf-8?B?a3dDeXFETExyL3BPNWo3MFhnblhXVDJmUDY4ZUZhQTV1V1pCdVF2dkJnOXJZ?=
 =?utf-8?B?NUwxK0NaV0lJdW8vTGdmdTU4MmNsblVjSXZ5WFBRellhRzBYNk1PQmQrQzY2?=
 =?utf-8?B?RHJOdVBCR2hXcmVBTEZlcTJRaEdTUzA3RXNhQXBDd2cvMzkyWmlSVm9Qc1hm?=
 =?utf-8?B?MnZob2wrL21aVTgyWm1pc3JiYm1qR1JRWndoTzRmeW9qb2ovVEdMYVNyL09m?=
 =?utf-8?B?NlRwWFZ0MVBsUXBVQlBqQWl6TkdTaGQ1VlI2aG5mMDh6aTgrNGlGcTRBanBa?=
 =?utf-8?B?dmQ3T2Q5NURvNDhjRFhsdFl5N2QxeUVobUdVVHhocGZvdmpmeGFzTTJkc0Nv?=
 =?utf-8?B?eDZEQVVnUDY5WnYyZmJ6OUlqeERHZmtxV0x5elRDdWhKeTc2RjVmc3JCVzVl?=
 =?utf-8?B?N3ZOcExtSE5FSDdHanZSb2hESnMvdnZNNHQ1WHRkSFBxQ1hqNnIrYzh2NXNV?=
 =?utf-8?B?MFBVOElib3JtR1pCVkl0NTQ1UVRrRmNCRGdDQndLRVNQWXZQYVY4UHdVUmIr?=
 =?utf-8?B?akl5UWNobG9kRjZ2ZG5lN2xiaVBEVEZZT0NTcWNmUXcxdEpPaDMrUE1zUWh3?=
 =?utf-8?B?TWxERTBNQ0dTRGxvYlJGUk9vT05aTzZKam9CVXc0YkxDYTZQRFRsYkFOUGhl?=
 =?utf-8?Q?gZnWagz8V6KohHj4=3D?=
X-Exchange-RoutingPolicyChecked: q3JSYWkETATbwDjAiSZBAabQ7DmUr2IMfiLL943k8OGnzTjckwi2gK9RGxEfd45v6++gm9aoV3VNXkPxKV5NTtiGCwQ/A9zCc6zj2GCf4Fy1WZMylJG+NWZtfmv7MsjbKdP8o0PJukiuL3pgNJjCqC/YWsvdoCxD/EXql8nt5RqgB2no5977+q4uXjsXNb3exAQ0WR6wDXD+7h1exESclnvwxf7CDxGX6zjCAC94YnBuACMmmf+rekmGVEu89iCwS+DMtH7b5/63Vaf2hm/VIca4RJEjKjkzWiRwZLIpbV2uQPtIQUa48LiwveN+lNTxWsQIai6OYxkEOjV06ocJLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f2f83a-0b37-47f8-17d4-08dee65d812d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:50:40.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPQj4SBiK7PcR5J6b07ahlGXACjSFRT7vPxP2XzGKvaxH3yx+9SvbBPQ4vpe5blvSZXkyBB2+yYRUai7PY+s9E1ARLxRlDAerQfg8ES2Ku8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5D8CD6E8B
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Wed,  8 Jul 2026 17:13:27 +0200

> From the first days of XDP implementation in idpf, it relied and
> worked solely on top of the queue-based scheduling Tx mode, which
> basically means simple FIFO. However, turned out not every firmware
> supports this mode and XDP doesn't work there at all.
Ok I'm back from the conferences.

I need to take a look at Sashiko's feedback, some pieces seem to make sense.

Thanks,
Olek
