Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B223EA942
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361040; cv=fail; b=lA2hQKyNSC6GCho4QUl2FuvJHt+8flkP8AdwGBiTsHS6pN0T8GryBrf8v7sD8fqLwm0gQVcEt8XKkSxFWBpf41xBTYXLz7n8AKv7g4vhwqFRkIyk+/o9TZeLPbzRXpqhthncVYNPbBIaZP69XcyEnqu+/ckdDk/xiDGykv7YuYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361040; c=relaxed/simple;
	bh=goOGg3yf888RnLdv6HWuvWnJGJY9unQ114e0IpiK5T4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CdfFftFRbQO82OWXfHzWiGYW1w8j3IDTo0sHXZL5LMM5kr39MPRj+zXoY+lG/sUskc+mw7YN++o7dC2T64r9TH89jYRmv8p6FdXdBgc8jN0iRDrUZFI17hEqp3OdXbDuf/GefpV5du1c/jVAiHGqTsokNl66f0l0zvwNVx5pESI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub/6S+Sx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub/6S+Sx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785361039; x=1816897039;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=goOGg3yf888RnLdv6HWuvWnJGJY9unQ114e0IpiK5T4=;
  b=Ub/6S+Sx2z0xx8qdYpu+bz6xbANZ8mEXQiGLgQ9n+IWQsCiGopsYcNED
   KhhURCqjVuNL0oKKU5KjE9a3eesCpcU+GTDjFK3QUxKWYxmxTytMpcjy9
   DsVevcDpsMlkRuWSAhVHJMGS2jGwdBsyvL1zqsLqVHRc0FVf6SVf8SdPM
   Z9tYY1x4j55rv8F/op2rCkP7xlNNa5sZS2qLuv8oqfUVDAPYPJNZFZUB2
   Ei1/ra1dyPewveKrL/JwBwG6BmpgTCjx4siPEhHr0mbJ7nykLKdjnG/l6
   k7HFLLqxTmy7qzl16U9BA0IC/+Km+HkhyCesUQt9dNvq50DYLhItTQG/R
   A==;
X-CSE-ConnectionGUID: fJiVibQhRHe3QFBEBYGGmQ==
X-CSE-MsgGUID: x7167v3sQcOH/RYCUfPc3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86168099"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86168099"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 14:37:11 -0700
X-CSE-ConnectionGUID: DhypduZ2SS65NXp+Gu58zA==
X-CSE-MsgGUID: QyYELcrNQ9OmuPjPRLHz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264391267"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 14:37:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 14:37:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 14:37:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 14:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7PeqL7DlZ5dw5ALhSgogtKvdm/XkpN445LnYvb/WSayq+DD7ARp5+/hS6cynhKXffMjIWWAf9ao6KeQcWa+1GWtH3GgvYBisvtKZOn2WseMVWuuSYPiSXf33PyJSnyG7doCf8wYIXgHJLMmhH5f9ViJ3G4AsI9iWRbJr3z6unKvDVwuvPYl4MaMool4bZ4eQAmvPmLpVXjuznnzt8GIECCVx1M+9h/iGjXzOqh7LJAQMYBGdhCRt0kYauZTGlKy/xhiJSOu39xQ9bHxb2ju1e3RXtmiacn5hN0d9TV+icP2JnW61S8cd3ncv/xNWUMP+aVxZkEwAf9hrDHN6Inijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc8v5WO82QWRepIj/yNTn4n61MNax7OrxpnC2a5BWhA=;
 b=li8sycNcoHWpKpMJDeomERQI46CCwhABaB6mwdgawvZw7ZhbV6YqHuexrYc96qQ97d1AM3VovQMxF76MgeyGUs1/2ugtIJSfLgMiqxlopx/umsslN711ijyzajWYeNO87UfhFHM1DAzHBoGMU7jKQCJ/9qQU3l61jVZOIx2sk8dRjKeE3bAr1to9/zY1LYgNGU49fpd9f3SnHM6U3HOWRKcdU8vbjgZ8Th938mkJ21ub8UKSCDdxKK7TzapMoZ/RuJdyc2l/Tr0vnIDHUtIS3PeIrXy+VzWNzk4tAcAfM9rLotkYZ1WT3xYsDM7qPwkoOg/t/r35rpsOiA8r8LZQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 21:37:04 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 21:37:04 +0000
Message-ID: <1c833511-cc85-4fc9-bf8d-0131b347ef6f@intel.com>
Date: Wed, 29 Jul 2026 14:37:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qede: sync udp_tunnel ports outside qede_lock in the
 recovery path
To: "Denis V. Lunev" <den@openvz.org>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260726104311.1782900-1-den@openvz.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260726104311.1782900-1-den@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS0PR11MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 78886f18-f543-4f35-ea06-08deedb9882f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L18pSjEDGJMNLA5hyWkmxOSzF5cmNx7f/TUsGVpmG8uraVLqOYJG5pqu/I1t88firilyZWdy7QhJ1bz+bQFvy6owM8xux+69Xl85UA+rxbl+7IgKmdmyeGX9t3qdHdkFK5Gz5oHUEYyLat1/S5ZK7ER2uRFS14KM8vJaqIFzJuFWxcaGMaiALL5XP8cTLaOGuWeX8Ur4jLjr86MxZvoRsa4dR3LcqgIDCLJ2xVHV6dEm4L4Qdj59EFirofYWooLPCebTKHV9Oop3M92TneawUodpQIO53/GMZf6z0xLhiYeJ/P0qBP0dkASU4r9xTcKqBnlewWMz29H2RmcrNZeuiasv/YONIAZi4qS4Rvt163LFcfGa9HIjgMREYf5FCNSkLneJjS9ECL0WWPIOP3M+QYUoe+8dHecxyUu02ZDydLi0EFUtd2Sy2sRDfusLv7V/ombRBsFTlanTrq7TjFioDUaDFf/zo4ZRaBJ99r2hVwhRr6RsiVMigUOreLy7mBDB1gzZ+ob9Hw3Otm7gd6xbqtx4g8Jz4G/gcNoaY48lqFB85HA1VxsBK9eG2XMY6kJRWIiXnHhQtHvTkbitBuIisxwvj8GBdnXq+pLcdxSoXM/92KQUkoEctwvZh+bIst/7niMpk5sWn1XPoxrynM8RTcVJ1j3NBfLgDfEI8ZqNLmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEszeGpEcHhQdVdTb1I5azhXdTFWNi9FbDdxTnBwY2c0a21kamhtbCtCRGRF?=
 =?utf-8?B?S0NBNjl6VGNDOW1FSTVFMUpQcjFyNkxjdjlKS3d3Z2REVUpBSUZQZThBUzVE?=
 =?utf-8?B?SHM2QUMyQWdsM3V4dTdOeTROa1huNjM2UHpZZU9MN3JnQ2VCdk16ODVjTGVn?=
 =?utf-8?B?d0hmUXlZS2gwU3NpQVkyL3hUclRzcEJWYzdFYUZpcnp2MEhhaWRudEkzdXVu?=
 =?utf-8?B?NkVXOEhNbnVGamludXNJYThaSnhPOGM3TXlyKzhhS0NXdnJsR3IzeEQrTWhr?=
 =?utf-8?B?WEVqNlV1UjhzcHE4dkNwMGRWeWN6Y2g5bXhZc1Q3ZDZ5ejNEVll4WmdYTmtm?=
 =?utf-8?B?bEN6Zjh0elQ3c1N3UGRGNS9VMUNpR1ZLdU1nOEEyYkEwTGFDZ0tkdERzWWJH?=
 =?utf-8?B?bkY5bm1kUGN2ZitOb2JPeUFkMmNMcFE4UnlIYXQxZXU5cFVoZUxZZDRhZ0pL?=
 =?utf-8?B?NDRtWDJXQythRlpkckhxbFoyUHhiUklVM055dUF3N01sVW1DckR3YTVCMnlC?=
 =?utf-8?B?QjRIQk4weXZTVm1IWE9sbDg0WDJkUUE4dEtvb0ZZaS9iM3VBS1JoQ01idytn?=
 =?utf-8?B?dy9HWHZMTENZa3lURjVmcThZRjVGOFIzaU1OOXExdUFVY05VSVZaeFhUeTIr?=
 =?utf-8?B?ZzVBM25nMzhEaFhqb09OZW52c0czNi90NjRHRkNtVWYvUW9DWnFvbENRL3NP?=
 =?utf-8?B?VWZ0Tll1a2xrUzBmN2NPMjJBdTZjK094WFNQS0lqcHlWQ3RmbFdzTFdXekNZ?=
 =?utf-8?B?NDZYZG1tckJCQW45ZjdHQ2ZvamlKNjZMeFkwODZUTUVOc202U2piZjA3OFdB?=
 =?utf-8?B?QlZSQUk0UGdTQmF4alpxRWF6UEdpalpDdWlkMzNtL0k2c21hdjZLYlFEaUpi?=
 =?utf-8?B?dkUrZy9uSkFLMmtXL3Y1aHJVMGJ3MW1PTzk4NWIrVTNwTEpKOXRpVldPSGRV?=
 =?utf-8?B?ZG9ySFpURVJORVRBM1BZazkyUnlKUEVQcllBUVpiRzlFWnFYV3FkV0EzTnNF?=
 =?utf-8?B?c2FHYytFaFdiazdvekJvc0RNMnhHL2NWNFVFS1dIZ3EwQXpKUjE3Yzd3TEJ2?=
 =?utf-8?B?bThKVHlwckpIMldubUhvSXdBa1NrTjlwK0tlS01GMjdjQzhzdXZVbzlaRmlw?=
 =?utf-8?B?bnYxU054UUFnUWRVcHJtMU5NcVk4VjgwR0EzNUlIdGNySTZka01GUURKOTJk?=
 =?utf-8?B?dkRSWEY5MVhjTUw2dVZUZnZGWm9YT0prSVpvTVhkbGhJRVhOQzR4R2hUV1hO?=
 =?utf-8?B?cXlFcTVBaVRsWGZFOUdyZnhoUStPbG4zUVlGWld2N1g0U2dkWnA2UFF5TE1L?=
 =?utf-8?B?S3U5ZjNJVGFubWpWbVpWZ0NKWTdocWF2UE0yWllCbkE3b2ZSOU9nVVdTM2pa?=
 =?utf-8?B?UEk0MXJRTWlhaU95TWNYcWF5QnVEYnBDVEJDTGtrWVpkYVJuVHlLWGlMMG9L?=
 =?utf-8?B?Vm9oS1h3US8xYkdEekVJK2psNk93RUVHZkg3VHNWQXhSQ1J4QzVQWlMyendx?=
 =?utf-8?B?aUE4Yi9zTXR2YkNEQnZESTRBL3VtRHJMMnFrM2VOZXNiaW1LZ0pBQzlQQ2VH?=
 =?utf-8?B?M1lBQjh6YjFSZ0lKUk1WcWZwTmVkdExyMGI0VlcvaUM5WGpzUTdYT1ZwY0dR?=
 =?utf-8?B?VStvcHpraWZCWklUS1E1SHVaUmxRSzJBL1hmWFJOamszYmVqYU1zTEVFelFp?=
 =?utf-8?B?cDBhSTRHTmJNSVhBLzJYcEpiU01NeEhudllFT2ZNanNWWVBWMVl5Z1lkMTB2?=
 =?utf-8?B?eGFVaklwM0F2OGNmb1V4V2NqaXZVVmlEejU0alAyQjhnY3hJMm00YWFTK01L?=
 =?utf-8?B?dHpkVmFIRENRNDgrRkxLZEF1YmIxNUdGcjdTTkhJQmVlZWRsazRpZTlRUHBI?=
 =?utf-8?B?bGI4T0o1T0xOUUhSWVVWYUljaHQyVTBvR2pPdGsybGhnMk1mRmoyY1A3cGxN?=
 =?utf-8?B?a2hyN1hPZ3NGMmN5dW84S0p2eTFKdDFVdDBvMjlSWUg3a0lRdVVoL2FGRmN0?=
 =?utf-8?B?cEc5YzV5UmRCNVFFT1hsaklXVDZUZjZrbDBZM1VjZlhwZXRiT1JnN0lRNTg1?=
 =?utf-8?B?WFp3Q3BtbFlRUy9tdjdpbUN0RTNHWWROc0JTc1JLSmtTV1FRWW9uNEtiUUpZ?=
 =?utf-8?B?UUNnOVI2dlR3d0o4dC9WdzUxWUdoeWVhdUU1MXJnMm15SG5ONC9ZYXlYUFda?=
 =?utf-8?B?NWlTV0VWUjBvYU45TzBLNzl0SkFXZmFMSzdaM1MxNkxWdG9UeHhHbmc4dXZ2?=
 =?utf-8?B?TlN6WnB1U3FGYjgwMWFOL2c0Z1loLzI5djZIQ1AyZFJhdnBnNmhHT1cwQVpQ?=
 =?utf-8?B?MEphTFBFTjF1aUtYK3dHcktZS2hPOWVlNnlMQXZyNjZEbFcwb1VyenU4R3Er?=
 =?utf-8?Q?49jjbSyQPLXWnJAs=3D?=
X-Exchange-RoutingPolicyChecked: LTiivhPgdgnTJyQfQzTDgcWotWJBSa4D9GzaoqDjwWyhoKQcdikJVh+Zh+qIzkMkfss5ESTi2HeMFpl/poydo4uNS/ljEI6pD6wj4Ggo10sZUZYWiS3hcDFCSJ2XVrQOLbXatnO93Xd40giN2C//tnMqexq/Vk7X2rKFcw5oeUlZKe+QCYb4vW2o8eKBTqcgXH5FufRFLpd92CEXrwRftBfMtPGyrbN8qxquG4vIsYxZU5gt1w97gzaPqdKOUAmImEkelBDB/0cxoDKPW32TolSL3nhrNypw5Di+0d8hTH41nuc6242dCZACtdew+cVasbWvoELGtp6Wsl3aUA/RqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78886f18-f543-4f35-ea06-08deedb9882f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:37:04.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yErsOgv8iJC2HDjGY6LRRjM09kLuD456sbKLryo5E1wXxJECnoci2RJbwN/urQ5vugUZsp9eLzcc4HpTYie+kPpWnR1KG7DyLqqR2CsTRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com

On 7/26/2026 3:43 AM, Denis V. Lunev wrote:
> A TX timeout on a qede NIC that has VXLAN/GENEVE tunnel ports
> configured wedges the rtnetlink control plane of the whole machine:
> 
>   NETDEV WATCHDOG: ens6f1 (qede): transmit queue 2 timed out 10226 ms
>   [qede_tx_timeout:586(ens6f1)]TX timeout on queue 2!
>   [qede_recovery_handler:2665(ens6f0)]Starting a recovery process
> 
> The recovery path deadlocks on the driver's own mutex:
> 
>   qede_sp_task
>    rtnl_lock()
>    mutex_lock(&edev->qede_lock)        <- taken
>    qede_recovery_handler
>     qede_load
>     udp_tunnel_nic_reset_ntf
>      __udp_tunnel_nic_device_sync
>       info->sync_table == qede_udp_tunnel_sync
>        mutex_lock(&edev->qede_lock)    <- same task: deadlock
> 
> The mutex is not recursive, so the kworker blocks on itself with
> rtnl_lock held, and neither lock is ever released. Every task that
> calls rtnl_lock() afterwards (ip, ovs-vswitchd, lldpad, IPv6
> addrconf, sshd) blocks forever while the node still answers ping.
> In a vmcore from an affected production node rtnl_mutex.owner
> decodes to the very kworker blocked at the innermost mutex_lock()
> above.
> 
> Re-sync the tunnel ports from qede_sp_task() after the internal lock
> is dropped, still under rtnl_lock as the udp_tunnel API requires.
> This mirrors qede_open(), which calls udp_tunnel_nic_reset_ntf()
> under rtnl without the internal lock.
> 
> qede_recovery_handler() now returns whether it has successfully
> reloaded an open device, and the caller re-syncs the ports only in
> that case. This keeps the old gating exactly: a device that was down
> or a failed recovery returns false, as those paths never reached the
> udp_tunnel_nic_reset_ntf() call before either.
> 
> This was the only user of the qede_lock()/qede_unlock() helpers, so
> remove them.
> 
> Fixes: 8cd160a29415 ("qede: convert to new udp_tunnel_nic infra")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/qlogic/qede/qede_main.c | 44 ++++++++++----------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
> index cb0ae0650905..7ed17faced54 100644
> --- a/drivers/net/ethernet/qlogic/qede/qede_main.c
> +++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
> @@ -1094,6 +1079,8 @@ static void qede_sp_task(struct work_struct *work)
>  	 */
>  
>  	if (test_and_clear_bit(QEDE_SP_RECOVERY, &edev->sp_flags)) {
> +		bool reloaded;
> +
>  		cancel_delayed_work_sync(&edev->periodic_task);
>  #ifdef CONFIG_QED_SRIOV
>  		/* SRIOV must be disabled outside the lock to avoid a deadlock.
> @@ -1102,9 +1089,17 @@ static void qede_sp_task(struct work_struct *work)
>  		if (pci_num_vf(edev->pdev))
>  			qede_sriov_configure(edev->pdev, 0);
>  #endif
> -		qede_lock(edev);
> -		qede_recovery_handler(edev);
> -		qede_unlock(edev);
> +		rtnl_lock();
> +		__qede_lock(edev);
> +		reloaded = qede_recovery_handler(edev);
> +		__qede_unlock(edev);
> +

This still has rtnl_lock -> __qede_lock(), but since you unlock it
earlier than doing the udp_tunnel_nic_reset_ntf, you don't want to use
the helper anymore. Makes sense.
