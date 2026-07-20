Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C453B993A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556298; cv=fail; b=nEDQ7jXqW2oe5QddRLgJWY8ennHTYFQLRieEC7t+syQxCG0HXzIT05qTk8S3l6G4Y7LDE+d4K6cefMTZ/GVK13a6SpHpcRIX0JZdUfbEMUwNTfoiaVCqO85ZamaojLjtvNkuQcy7PJvzsxo6foJugDg2XVIzBKGgtkeOde7xVIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556298; c=relaxed/simple;
	bh=iC6tpwkf9kCnup6NbDXZUhg8V/juG3I9NOOUY6RU28U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U36e3cs0CUOfmmN/reucAYwBwmrvlFj2S+k8IkiXGydOdXutEB+Ny2tGMQeVfVr51R0uiryRrseFyKOMtVS9f2h5970nVl9/ifGuOQJbqBJ9LsJ28H2zzUuN1fTpFfxqZKHsNWMi9oSBQlp7sel0Q3zMU8hUy0UWT/LcDVprgN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn9Nmr/O; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn9Nmr/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784556296; x=1816092296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iC6tpwkf9kCnup6NbDXZUhg8V/juG3I9NOOUY6RU28U=;
  b=bn9Nmr/O2Wl6nqWeCYkL0baK/EI4PBcHBj9OO2KtF9rSSFYlsp8A7p8i
   pR4+Wo+AU3m1deUBdYhsmSZRqwqWB13yr82b6UP6c6SjCAABBrpRPj7Sp
   P0vkCKjNI/3pNXEg4B4esPZffU/8dpgh4AjXQH9h+f7Eb12Z/b6DJouhP
   QzK2zOF+Qe0P1op0hFvlPVbB/fb26IDM5IZb7FPwrdP4W+VUX+TJZzHV4
   /fZyJ20CKeYFvk7RNz4Pv9nrbgGYsvzRKwiA4GTliS7dai6zwKaJyOdAK
   JLTdV0tz+o36bcfcVHwbjRV99Xzt6fwIjwKGVP+FTCeS+mNXJMAT7DZn3
   g==;
X-CSE-ConnectionGUID: By11U7xPQ9GCrkVkTkkU6w==
X-CSE-MsgGUID: 4yIoTL67Q1C1J7gYZFMwrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95789104"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="95789104"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 07:04:56 -0700
X-CSE-ConnectionGUID: bt5DS3RUQQ60CS+RKcNV7A==
X-CSE-MsgGUID: TD4yYddZRfW4gLedhENyQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261030034"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 07:04:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 07:04:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 07:04:54 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 07:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN2poNKo1xqZUIceq0km38ayBAyYMHIaAJwR548vEWNW6FtwiAc2zQbV1Lwh6tctSbaABIdJV9DNppSK5qP9NXljHYPlxQigmjLrK5wJtfJXh5mDeP5YMNPRkkPg5HuDkk6x7xRmHlzPETOxQTn/swQ/m6thScEQpa7cy4n3sg9BEMphKi1V3RimZAZHh4rMIBP6rpKG7nmOqQ0sWNVHVrKRu5BA2W6GkiT4h2aA3m1KB5t7tEdv3azKYd0PO8jeUL4gv2TnvwWklaggyTZyIut1YVMKBI7/oRXcJ+3NqanFPwGi2bp9l25quXeI4PlggpVW8fQ2f9Yk+J+EDONhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x6VrXXEL8vf5BXNlUTcljyF8ee+FROxUOa6Bvp03a8=;
 b=clXQNAuHn6K5T1wrNoVF8fCaK4FMafb6gCB2WAMrdk+FjWZZfdOrZ6t6ckKX//FyMANULdPF2/227P2/SqalzgXqNShzXtMX6ZwsaWnHlDlWluL7GiCy7MCcywWK4/g8ekPlRw1mGcJS19mCCb8PMNkUIomWeoAZHU38qunzdRUSb3Gc+eSqwr3GsaQ6p6kHGQ7Y6ahXayeMFubyWyLaBxQTdZg7qz+ECYLetcRGhhi7fs1i9VDMS4G+GXSWIyq5EJwx5m5U607/8xJfQMePTZs7Ha23of1djwCAd4l0ap6xhDYEEwpy2KV9mE6edWba4bBNomXLiQUtbo2lhcIaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6)
 by IA0PR11MB7751.namprd11.prod.outlook.com (2603:10b6:208:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:03:42 +0000
Received: from CH3PR11MB7323.namprd11.prod.outlook.com
 ([fe80::abb8:c470:36ca:e556]) by CH3PR11MB7323.namprd11.prod.outlook.com
 ([fe80::abb8:c470:36ca:e556%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 14:03:42 +0000
Message-ID: <f5f60ac5-c0bf-48b3-87a9-1ca353388c6c@intel.com>
Date: Mon, 20 Jul 2026 16:03:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [ANN] E830 NIC join intel's netdev-ci
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <kuba@kernel.org>, <netdev@vger.kernel.org>, Przemyslaw Kitszel
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>, "Anthony
 L Nguyen" <anthony.l.nguyen@intel.com>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
References: <2c5c3c03-7a4d-4020-84eb-825bd6ed1e78@intel.com>
 <b4d17a58-f6e5-48c4-9bf0-230ca710ea2d@molgen.mpg.de>
Content-Language: pl
From: "Pielech, Adrian" <adrian.pielech@intel.com>
In-Reply-To: <b4d17a58-f6e5-48c4-9bf0-230ca710ea2d@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::17) To CH3PR11MB7323.namprd11.prod.outlook.com
 (2603:10b6:610:152::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7323:EE_|IA0PR11MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9c49e6-fbb1-40bb-da91-08dee667b47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 3wC6SXRcze/uzi3wB7J9rpNPrCtzQvdQxdwj/UdJyyqbeVtZipY7bOYikh9JAMEjoypTO2WEHjV6HaM6roNerFBGNS6qcOM1Ei9fGaRP7XNGM4DBJxdDPyT+ORHo6q671XDNipavDAwXXIxMGtfeVdG3mBvg5yuMEduDLSSbpEWjAUSe90g+JmtPYWh85NGOm7kCM2wNEnLg48ZUEaCx53jtFBArKO0MAWPMzY9dcpy+g6rZxQSMFsKYP6MFPRdGcBSRINcS9aZsUCvz+IaWhVB+AT/JwKew64OQKvcWfI5pGzGzrUUW9UzEbjra35QnpulX+3NqC4vXJjk7bsOdEoEJa8WISDHxhOw/Ra21SXGafBDFzE/FMH1y/fveNEYvyii39NVLBce0YTiQu5HIodTP8FzYff5V4ztN8U6ezHijsuC8//UXDKG7sXOU989wMASnBnX2RzrR/5f5VcLdsjDuLFUlx5wa5Ijy5gVmGyTXhdgndkSqWJN5ppFSihtB2GyyqTL3klxJSmavRBiVIH0eCu+ULYHd10vTqucorER75cGgZe0Zew0UOJA0efISQgeAMx5ngDDJSruA3iZOZD2ltdEaUGs10Tad9FSUhWhEvLHtcDPaledxFXkWTrI/z3KGKws1W0EPojDaSdMuAM7UfKaz9Pz7Z8T5dqiZviU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7323.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9hTEtYUEpMbU01RU5tL0hGakxzRFQ5K05ETkp2Wjl6OWlsaCs5RUpUaFd6?=
 =?utf-8?B?amZRa25WSjFYQ0VVKy9FU0RXVUpBSmR3M3VVTmFVUjQzWnFxWngxYVo0ZHBL?=
 =?utf-8?B?UEVWeHF1QzZhZlFUS0tlbmhGbVJwaGJjTHRha3o0S1FhUm42NkY4ZVNWUklR?=
 =?utf-8?B?Wm5PdzdZcmJWTjh2NlVOOFdRQ2RrMUFETnVUVWFMc1piVWlBbjM0Y0xkRXFi?=
 =?utf-8?B?NWd5Wm9RSkVIOHJLRkFOaXI2SDlyc0RXQXh6VERKRThDUGJZNUVtUjFwQ3po?=
 =?utf-8?B?cEVUdzJlY3dtN3JmcTdkdFN3cHRKTkY2WXUvVkp6UjlFRWN1TDJ2bDFYWUs2?=
 =?utf-8?B?M3JEYS91N0tYQWF1S3ZiVjJTOGZhQng2TytIbXpnRVhEOHZNY3BuR3JONjM0?=
 =?utf-8?B?QmEycVBNcXhTbS9BRnplNmNRSVBzTGRXcXFlZzNmWUFmOE4xR00xaFZySlV3?=
 =?utf-8?B?eWI2NlI3VktkVGIxT1llSWVYSldybkxYQjd3UTRwOWNvaHpuamMwcFp4MGhU?=
 =?utf-8?B?VmhOdlpSVTVKUEQ4VTlwNVRWdVhBYi9iSzd1SXdZRHVySWpsOUdpaEFqaXpH?=
 =?utf-8?B?a0RvTGZPVytoWGtvS0QzbWZQY29MOS9mcEIrZU5jMW41cUE4WmtNQkFrWWtB?=
 =?utf-8?B?bkNSSmFheGh5SkNOdHdEQ2p6L1ZTaDhEQ1A3bUw4N2lWYy93YTFITC9ibVB4?=
 =?utf-8?B?U3hkMFE2d3NIVEFjSXg3VmJEeSt1dVhRT1pBRHJmTmxiSkIrYWNxMUNFSGZq?=
 =?utf-8?B?UEhDN3hWMlBvYXcyR1FpN2xHclNFRkErcWU2NGxzeHhLbFBsZkVYVENReXBh?=
 =?utf-8?B?Mk1YSFdpUDVpWHB1SGt1VVpkRW1QaHFURGN0bmRad05FZm5uUnNnY3NhUThH?=
 =?utf-8?B?RlM0dFYzYzRvNE9OSk5RcWNicnZ5eXFYbjg2aEwzWGc4cFpkaWZ1K2NVYkNh?=
 =?utf-8?B?T0pMRHowSzI1U1lqbVpQSnVnOWp4Z29DSjJiVmV3UjNsSHVPQ2xCaHhkQW83?=
 =?utf-8?B?elQ5TXhVbUM5aG10bGZCOHYra2dhRll2Wkp6RmNURWNXd2lEbDAvbUxOM3lw?=
 =?utf-8?B?SkNtRjh5cFh1N0k1M3ozSlZ6alMzVnU3ZG91VVhYRG15eHVVcVF4ZHhJSDBw?=
 =?utf-8?B?M2JSV0VnNkQ2VHdhbXc0b2RkTW40bFBZWSsvYTJpcEsxQy8vRUlVMFhneGg5?=
 =?utf-8?B?WDdPNzNyTlV4L1JnaUJYdGlla052MC8yTEIrWjRwaFBFbXY4MzNHd3REYlBX?=
 =?utf-8?B?dkgwbGRaVzZJQlQ0aVkyMVR2NVhHYVpIMjNxQjA4UnM0MmFiUitRYUNmQkt0?=
 =?utf-8?B?Mll4Z0xaMi9kUzgwK2JmdnNmMFZadko3TzgrRm9mS3owZXh4czRlaUI3Vm1B?=
 =?utf-8?B?UnhNVFRRdGp1YXhYbGhVOFFGS3BQUXBwdXNmRkJGYTJvZXI0UGwxNjZTclVq?=
 =?utf-8?B?QjRLWnFiRlk5bkY5QmFkUTRXbjlncGRXUWxhQThmR3BJWWpPenBkQWNyWlVT?=
 =?utf-8?B?Rk4xVFRCNEFRTXg1Z3d3RTVwVHFiUTNEOUdNUkdoWmxiUXhoanUxb3VBUVhy?=
 =?utf-8?B?MG5FRkE3TDYyeThkM0lOYkR5dnV0K0FVVHFOUGVqWVduWG10MzZwbkNTOEp0?=
 =?utf-8?B?cDRpeWlGaEhjY0lTRVhXWmJuN01jdTk2TzA3WW5RdEJ4NzRENysyWFlYR1Nl?=
 =?utf-8?B?NHljQ2dLbEx5NUg4K3F1ams3Y0ZPa1N3K2dhYWlldUV3RUgxSklCR0luNjVo?=
 =?utf-8?B?b1hYdXhWWjU3SzlLenJpalhWWWM5YnJOMmtETFRlRnFaRkJxNUFqUEtraEE1?=
 =?utf-8?B?V3ZtZ0ZqakVnVG9YMjQ5TDVVQWsydG9OTmlTenE5cmhqeFdIancvQzhVOHVH?=
 =?utf-8?B?TmI5eXVLUHBHM3FjanE0MFJseWFVVFNsV010WkY1RGNDU09PQ3lIS0VVZ1hK?=
 =?utf-8?B?YzlURnR5d2lLN0lwVkgyL2VDTWtrVTQ0ZzdGM1oxTCsxVWNYN1ZZSWUwWnVh?=
 =?utf-8?B?RHQ1RGtlSGxDNUtUNEJ4NnJhT20wMWJxbVgvZHQ1QjdvTWlwOHNhQjA4U0xS?=
 =?utf-8?B?dSt0VXJNbWVvMHlJeHYrTm04NTBqaGc3NTRoQklRV2pqa0Fjb2lkV1NoLzNG?=
 =?utf-8?B?QkEyNm5NQlB6OE9OT1o2NkJyUnRuSzlVRHR4SjVFTVVHaFV2SmhHVVF5V3dZ?=
 =?utf-8?B?RVh0OHlIblloQ2E2NGIvdWZNL1RVekhXVmpzbEZkMEFwb09ROUFkL1licEIz?=
 =?utf-8?B?WkU3c0NrNXFrUUJSQzduOTI3Qm1mdllJV1NjcnpxbGRyV1d3ODFzVTcyUXJ3?=
 =?utf-8?B?UTZtTVVxZXFvMHBhWXc5OVdJb2JlMTRDeFZxRlZNeXRITnE0SFVIUT09?=
X-Exchange-RoutingPolicyChecked: AecrJegvIWBHuEUxgSYt2KZGeb07IavNWcfCNexda2ElW72ODWp7Ra7t76EymRLTFt65zwgvoY/RltopCJrFKuF286PJu7WTrjClgjEPz8wJSSfyhaVCvTa6qv3PgA4JV1v9WlI/WUk8x4mRxsnus4JsUM2Ej+dCSZghKiISGF0aDGGUH2ZIoHFSu8fBj0M/bfhCK2Eg08AHdmkVT5bQ4tO3LyYEboZ2l8LGGgFHg7gtM48i+hUM9rR5AHdUFpBrkN7fCbIfYq6Z+Mky1wkobmOVHo4cyvytm2u5+8XnDjC3hwAVlmNt8aJEdkCx4sMMoUKDc2J48TB67hNPnLj05A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9c49e6-fbb1-40bb-da91-08dee667b47c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7323.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:03:42.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4DLZEXbWCf1VFnA8rdy5qxV/72FJidC27ji0IQXrliCOnNtPSu0wnWAv/Y2Q6AcCwIqx9LIxP6SKmX6JUoJVyv1JGzsKJPHMtVkRtz9rYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7751
X-OriginatorOrg: intel.com

On 7/10/2026 2:06 PM, Paul Menzel wrote:
> Dear Adrian,
> 
> 
> Am 10.07.26 um 13:20 schrieb Pielech, Adrian:
> 
>> I'm pleased to announce that E830-XXVDA2 NIC from Intel Ethernet
>> E830 product line joins the suite that tests ice driver against net-
>> next-hw branch.
> 
> Great news! Thank you for sharing this on the list.
> 
> I am curious: Is there an overview of the test lab?
> 
> 
> Kind regards,
> 
> Paul
Hi Paul,

Long time to reply but...

Tested NICs provide metadata with exact card identification including FW 
details.

All NICs are running on PCI-Express 4.0 controller, powered by Intel 
Xeon 2nd generation CPU.

Regards,
Adrian
