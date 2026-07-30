Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C7471272;
	Thu, 30 Jul 2026 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453304; cv=fail; b=ASYStL6Vg5wO0w1nVjM9arJSfh9RqNPAT1TUaguLpt5DrsYYsZDMJEmGofQAdMdoHbNXm0os+XlWHq9OIgBlTjTRoF0NCVjbjEo0VtEC7dynKGIccJq9vz4lmcPORxQEmk56xdWia3kpaHtLEE6hMxC4+OpqKXzwRUZaiYhye+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453304; c=relaxed/simple;
	bh=AvL/a26M1HdqLWMvQUSAqoFq2MBWFu3vZIx+Q5rLpvE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NcrL5O4df6SfTqyVXU/MXDKJkr48BnLMXXvsZEqS/LQXN9v/UVdJXLCcDWpVnJbZKHwGQ9ClLASyKHGwdrSXe4dzgsfQ7uw663Ngqz9sD4Y2TaLHlaOO+1VN2SQKRHEkeeZBSJDOEaEUNRObF2gzGOPtru6JRijpButIoPrtsS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAVDz8xR; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAVDz8xR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785453301; x=1816989301;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AvL/a26M1HdqLWMvQUSAqoFq2MBWFu3vZIx+Q5rLpvE=;
  b=HAVDz8xRbUaIjNREviqC8uWg6TBV4iiGAnH+7HPkYzyokkPdIwgFNO/O
   GNgRWE69+6+Ra16jvN1ZXhxjU9tn8Yh6fSLRO9Rww3hbnDGISH9fSogdy
   qlywZBMzKuiTuUv/etFDcS9fCGmdYDMafQBMyr6DQH4b3dajRRPI6lXJi
   aAX+lTGFRO7K0D8GfxzoMK4pjrt2qr7cmmtLtI+E3RKUiPzIXegHCgsPz
   9g75Zw4KsaqBZeiBKqvMdbmFQCtMh6CYVT7CDzH8iXwFnpH3BGM1Sehd4
   1UJBkBDnGbITW7A6kMw0zswTHW/7XAltR8/AxbD0MhL5wq9SH2Fs9mT/E
   g==;
X-CSE-ConnectionGUID: IW7MY1ZVTaK6IoHIPQ35xQ==
X-CSE-MsgGUID: WFdVn4/4SSO3WkX+dtnEEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89971498"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89971498"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:14:58 -0700
X-CSE-ConnectionGUID: AQVRtjWeRr6xAxgyMDY5og==
X-CSE-MsgGUID: pkN20TNIQC68EDUbWQh7bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="264710197"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:14:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 16:14:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 16:14:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 16:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTLFAGcPorfZzcYIq2KUsaaNXsLpIzmtN3Apy2ZmFKpN0B0uuoDIckvHz5FnROKVPp7v52IFptFUH+TBTixEhMI0UVXoaPEKBTABmX+ks3hhtFAtH7yM5ypOe+oxnLbsYiMFYy3Hc+uOAtfNJxVBx9Nv3Plk8ho/TU/gmhOqeo+F1gtimgFdXsj84aljwK78bp1Cus7sXBrjsRhkHyflZjNHAuK6bH7PiUqBLmJwUeYDRtaCGVe5aoBcupgObKX2bPqm18AItDeHf9ERIvu+pMgKa7AhfrHDa4zTZFce7jyZaV917CkNyvp0G1OKg99KSo8zqi8n3r9hLV8WytBNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkeUcls0LOfMJLU0y8IDny0kJ3HmCGGuEGR6ftLmLWw=;
 b=PnEH4kEVSXkSDMcjFYOnq+vga5l1FoqM8tUS4vAglM4UVdlqH8BJcyHuqmjkHTI1FSLunkirFQo8g0snHvEuWgvNvNtURJu9SLE1ht9TWIZqCJKxufvP8KJ+wNIVR/3ktHQFkWdM6wWKZhWVF6Cfu1qDcPFUO1xjnOfTxRJD7to9lspSv5Oo0yQCaKJKshX1J4kyDRSSNAuS+A+zf6DHCtzMxqkVNXmrLEh76rbodrGSQqXCCPvWVYpR2pp2m6SZ34fd0qMo15rjeHyIzf2nJAOJqp7V+WqX5h7inpiag1zc7BuDs8SdVOACTFVeb81z9qLCD+aZQmChD7CgaWhxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV4PR11MB9467.namprd11.prod.outlook.com (2603:10b6:408:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 23:14:49 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 23:14:48 +0000
Message-ID: <67e5ddca-43a0-428d-9dae-eddff828a26c@intel.com>
Date: Thu, 30 Jul 2026 16:14:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] rtnetlink: cap IFLA_VFINFO_LIST at a
 documented number of VFs
To: Jakub Kicinski <kuba@kernel.org>, Artem Lytkin <iprintercanon@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<linux-kernel@vger.kernel.org>
References: <20260729185513.52564971@kernel.org>
 <20260730090700.65867-1-iprintercanon@gmail.com>
 <20260730140931.14d5bf4b@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260730140931.14d5bf4b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:303:87::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV4PR11MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: b05b187c-e306-485d-c560-08deee9059ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mXptzy/p6t9pZjZz0ikQsfGg1isKwi4xDJTZYVy5/6arQSgfipwejP6ITO//TIF+ls4nBcyx1VN3IFw5aEF9xPal6aVb4rZQjRSkaZG6mkOluH6T0ZFhwHDvHlI6wf2Cko8e8ocE4cVmu3iWvivocXziHSQD9snSx0dG6UXXdP/9VZzUqHW4pTcAg4VqLfEFDHL3l/Q2u5f5V/NKrlz/fpNzhyXJnMxgvQrrFSbKd2ueFxJVScmV/s1qlwv2/sVkj7VDwTsJg0VXxPvCKMhKRVD31YqA0rGeNDoZtuS75lHLUQbfPRSo2eH+Ec3lEb+0t4lKFuakAvVb+fe91SZZNCdviM19Q0A3qFySNWRVvVH8Ljqqym+2eDiS99gpEYmP9hE8Q0d17DAW2IEX7yi45dY4aqbNh69t3RRlCB9vYKcICE9mtPd1KTFB4b7ttC12PVJPeuQdkYTDppOHLoC/YW6MFqnAXDzHEN92oCFEnbjzZNOtozV4Q4LPM+qDlgKhdR93Ir52zW2N223ZA5wyknr/SZ/791iwqyyJNg1WF3qMa6UpLuRN1ia0bQRdYdu1rzLBJ1EL2iUZgqDpmwFHZbcRqAi0YE4EM9TnI5JHfix6IO6VUquZUrOky5TBqF46FjkHntxPgJbIcKOOQ7tXUwpamhKsx5+6Vbpw5anfMCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0Jxc1c2U2ZUdTl5eHlUSkloNy9xcldScEYyNEZBQUREdytZYmMxY0haaWxM?=
 =?utf-8?B?aXpQbWVVRkJ5bVAwamx6d21HZGJlWm8zNmlhWGJaTTBieEpRTlkvakU0ZkVY?=
 =?utf-8?B?WWwwdlg0TzFVTTluWVFVYjJBaTJvekJ0Sk5DSlFTblZxaXJzalVTWWV4VS9E?=
 =?utf-8?B?WERHU29qcUhIT1B3VHcwdE1Kc3pjNEZUUm5pVUY0VDJIU1pGUXZSazlDY2ZO?=
 =?utf-8?B?RURZWmZrMDZPVFhjdnVmUkREL3NqQmVSQmQvNmNjWWhvemFVZitHbHdEZURI?=
 =?utf-8?B?a0lKOVlmRDNiVGw3NWhFTThWb0cyQzFRK05STC96R3k1VEtKSXJpUWcvSmtY?=
 =?utf-8?B?Uyt3VEVjVGpxdGR3K2pHdUdGWXlwOGM3Zmk5d1hwb2wyMTRXRmljNUdVejlS?=
 =?utf-8?B?bEVyQVRhMXZ6a1pKU0l6aGNzNzdwbHYveWJJa29FQ2dYanN5L3FIamxwKzdK?=
 =?utf-8?B?eU8wWXZoMHp1TW9qMzc2eEVxcXZOWHBEUjA4RzBNTjJObmtQaHl2SWhkQ1Fm?=
 =?utf-8?B?U2VIZm5uY2hLSjdSTFgxUmZxY0N1N3ZzOGpUamlmcndsNDZYay8zanlUQkF5?=
 =?utf-8?B?bFNBbGNUcitsdi9XZERVeE5meEtNV3NQNWdUZHZwakwrUzdQZlBJMm11bDJZ?=
 =?utf-8?B?TkphMHNGdEFaUVQ4L3NxcWRicGNWcWx6ZmVrY2JiZTdsS1dkS1ZnY2JUWkdU?=
 =?utf-8?B?NGZvSlV2RVhBUGk0WmNqck5vSjVUbHh0T3h4VW9aOW9IaW5YOERYM0VDUGxC?=
 =?utf-8?B?MmtBMEN3WVdQcUx5NXZUdnNHZXJLbU5UT0o1S2NRZU1tKytSZkw0MU83N3JC?=
 =?utf-8?B?ZzFLMitBcktjRjZON2puRzdsaW00YXNwRVRlYjl2NS9zZG1VWHlQaXQrOVBk?=
 =?utf-8?B?V285dXhaaXRiaG9nSHBhQUx6ZkJNT0JhajF2RmR1Mis0bzJJdjBKbFRoZm1n?=
 =?utf-8?B?WnBNNEFOQ2p3ck1JVFBjZGNwWitzRDU0SS82VVI3dTEyVXFkS0VmRm4raDdQ?=
 =?utf-8?B?NE5mRnZTNkVRczdjNEpxZkcveHY5MTI1emd4Q1k5Nzc2bi96OGlKbjNyOHZJ?=
 =?utf-8?B?VldCbFVDOTdaRmxNQTlRZ1JBam5zL0JaY0QzV0FjdlMvdW45b3EzV01aRlFK?=
 =?utf-8?B?L214cTc4OTVvNmo3TjFGcjVvYXpkS3g1MTI4djNrL1QxSTNxMWVNY2VsM0FM?=
 =?utf-8?B?M3JXdUNEVGRTYzU4TWwrdnZKckljSzJuWVlNL2xUVEZYcHZYMEg0TTBxL2Nn?=
 =?utf-8?B?ckg5ODNRUkVna0lDN0VLQjZrM05ySC9ZNy9ja25RNmZsd3RaNXozRWRGR0ho?=
 =?utf-8?B?QVM0TUtXQmlyUVcxbEUxVi9nZlRVVVdoZGhBL3Yyek1odUQ3QzlSSzN1VzRh?=
 =?utf-8?B?OTBnZWFRS1FjTU91a0dOSHBBZUFqc2RkZHdzWXVJSjg2TTkwdkFmOUhxUzBx?=
 =?utf-8?B?UFBBMC95VkNsVm8rU3JqWThCVVVFb2syWmlWbGlPc0MzWURiQmlUWkluKzhj?=
 =?utf-8?B?RFJlRnpmWmYzNWIwdkU0VTFTRlppWXQ5L01wWlBHQnpoaUpsNzFselhSdFVW?=
 =?utf-8?B?NTR1Rm9TODFuK2lFYlVaRWJOM3I0NFExUXRzOFg2V2dja1lNZHhNc1VKRG0y?=
 =?utf-8?B?TTZxM0FpZGRLNHJBdFcrd09iQ1JZL0krdUhCM1Y5MTFqbmhzZjVwYU1nYzVS?=
 =?utf-8?B?ZG44NEhHbDNrOUxSTytZQ0hzUldCUU5wK3dQam4yT2dWNGwzY1U5MHpaVmVh?=
 =?utf-8?B?UzJ3WHB5VkNpblBCTmsxajQxUTNBaDBWOFUyYTBWSE5kSDhnT2RjWVFZN044?=
 =?utf-8?B?VDJUa0E4ZU5yTkJwdEJ5cmswVzk0ZjhJZmorOHhEcXBLa1BTODBJUGFWMjlN?=
 =?utf-8?B?d0M2a1kzWnQyQ1NVN0JGR01PYVJ4YlNaaHJianNNZFFGNzJHc1lhc2lhaTho?=
 =?utf-8?B?OHM3QjE2MHN4eHpTWm13K2VIcy9NbnVJU0txYnhucGJSWU5sajFtdjRtZWtv?=
 =?utf-8?B?UlRJMm5oczk3aVNBanB4L3hML1V4RjA0YjBhdy9IZXNjRE9TRmhpVS9POEJN?=
 =?utf-8?B?WmhrZUs3dUdheklpQ2ZVeVcvSXp1YnZGRThRZUNINURrN0Fxb0k4eTZObTVp?=
 =?utf-8?B?M01TaERxOEd4RWh0Uko5clNiNFZscmkrb1A2bjMrUVNNaFIxSjFtZXVtYzJX?=
 =?utf-8?B?ZjlwNFNmbGNudmV6MEc1Q0JibzVHczBRaG5aVEZZajNlKzlEUStVUFdWRDFr?=
 =?utf-8?B?YlRzZi9qRUFqZ2RDT3NwYnR2K0tXZkV5QXhYeDU0VW9McVlqTmRHTVlSMlVU?=
 =?utf-8?B?aUlFdDhGVFFWMGNXaVJHeDA2a1Z5OXFsaDNzTzhRY3dDZk5TUFJsdz09?=
X-Exchange-RoutingPolicyChecked: eOQ82IDpgfZnfYfDDwQDjkiZG+G5fA3cyhXb/zZNnsPrXhHYPn50GnIwSJXW5Pw4G2dZ8Dvtm1Yq8RSNk6KNDLh0UNhpkv5iKf5MF36xi523zELAGWvDmVqlJIZCenEpRs+xJbVdEzOUj+cRw5ZWbUtG9sZ6YziLqjzisfAQYeOv6mkj0vRAdTm7ND0FVHRumLY5otUSYdy8MDMNsiEI+ve6z6dwLWbckYlya6uEqzbNLTfUhSshvra2AjfS4r98Tgv7OnJZEOZUJmuSrsU5M8+/alId4imGgb8afEBmVNL1UT5mAMo8j+2/A0VP16Gw0uGH7o2Z7hREPkFgJlfaFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b05b187c-e306-485d-c560-08deee9059ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 23:14:48.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsBGpPf7Gmzso5KsT3AZUYsLwABvcBFjsSssQJs6lHV3Mf/JhAyK1jte8S0EIf40FQf3rYvM+D3YD0iW/EXjIzcjxI9YPe9wqAmPrvwD1Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9467
X-OriginatorOrg: intel.com

On 7/30/2026 2:09 PM, Jakub Kicinski wrote:
> And FWIW (sorry, Im going to reply here to avoid splintering) I maintain
> that net-next is better :) We are capping, who knows is someone
> complains. So I _don't_ want this in LTS.
> 

Fair enough, no objections here. I'd appreciate something in the commit
message mentioning the commit this originated in, since that may still
be helpful to future readers for context, but I won't hold an objection
regardless of what ends up in v3.

Thanks,
Jake
