Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05F36CDF3
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750115; cv=fail; b=XgUUGcubRQNI6uVkhJsjKcBU8IFD2wt0C3ADeCZCM5nnw6Kzv6GwI0V2SH/jpw1k1dHVt5DGMQbZFJptqMKHE4if0k7VSm2Fpoy7TOUuU2iMgbjMx1Vxs9ocAjnMS/ZcwuExVC6Sjq/rbqH+71ms8iDNNebtAnbUpBDrtZRr3Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750115; c=relaxed/simple;
	bh=5xC0O8M06K6srtdjYdI+xuGIk1E5UVMASPqtYTGESqg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DV6zE4UkeGQJwiUiugFQNWXALrU6W///oxRgaOecEmj2O32TfP2GHMehSfrbhKP35ol2bUrpJBCV8dTYhCZJJ2J237t/WNmp9F0AfQ1Yod9a59IKsyXjw0ABUT6ZLR9icjeFQ6L2Igsu3lY1RCqTgXIfCz9SMMY+aUKICOUUsq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjrW4z9C; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjrW4z9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784750114; x=1816286114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5xC0O8M06K6srtdjYdI+xuGIk1E5UVMASPqtYTGESqg=;
  b=VjrW4z9CHccabz5TNzdxblzRoekAz0NMdz4me7Mo0wRYoK6RdgXsR/qI
   oZv3jZWLs2dbvpA7ZT69Uki8YM2zFkvER4o5Jl9iLlOJrwzpIY6RT2Y16
   71woF8rg0NxMtToQ6D1X4OgEOaN4KYTMtdLC6UXTdav+m7ulI26KAncoh
   VcpEt3VIlLDvT6jYP6P8/EyjbaRDnUc7x46vZ33D3A52HQlJhs+FVKGhf
   cl9PoaHTYpIBaU9NrXtDdUZCyd+0voECCpxhq9+CT0P/G+WfnHnn6mbt+
   W8RQ2HnEsViFANVKibbYKZBmZwcM+mDBYS61/1lWJZYByTl2DEruheFDA
   w==;
X-CSE-ConnectionGUID: zUvPa4+VSsCBSUL3SjXXtQ==
X-CSE-MsgGUID: 1zjQ9qadSwCGBU1Iey9ybg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85443554"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85443554"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:55:07 -0700
X-CSE-ConnectionGUID: A1LkMS1DSG+cOssM4uHiAw==
X-CSE-MsgGUID: z7sfxNHXQGixc2XRctaoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="263138610"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:55:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:55:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 12:55:06 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.25)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQqfZb622sVPOUF5/RSWuyz9ou4Rk6ekK/ZXMAfLnykfrZuptHtW5kus0brfflBive6eZKG0s/ps3Rjo+XXj1OyfHEQpW1MDWVqrmaztrPfkB8mlJRS6XXyIqbl4/P0edqJvLY1pu4RsgfdTEjuDjQ18s65ROA/vdsSl5YlNjpHID5063GZXl4YgWSdtD0q+iQ2khZI//oXp9wrocSOUVYNErSQGO+WLlq5EMzyx0mJFR5VPTHLFMgDmLFmuXtfmi7zwtxttApBJaRxLCsikRg5sHV+atbpDOLXFX1yp87H3ckGapzTlJwgWCGyLsZa0i5cl+brG1xikVtIYyya6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eLIeV0e4+JPrlRIzXrorpoKvYCbPs1umfUBsIJfCSY=;
 b=ABE0GuSxvYDEfudXpXMM6Ybaif++KYeztjYsJHSXA36XFrvvqcuYg2blA9rZ+j2bD1c1ZPioruHv/YsnilNlfV5PT0FcGbI2o0LL3ErepxlWBlJXCcqF2iUaJUmhwNiBWL2mUlnbDsic3R61th4Nc0uWIJVEClf5IGSAO2rzq1N59JFDhs6AVptME7nr2kh+CrcWytEnWg1W+dFwRPbC9LYjmQ3Zg5m0DP3wEuqFaty/759JdnHkHIFE6EkEKoNGMauFW70jihYzpfu7uPTwaMwchgq1+0C2NqJHEB4h0e/AQZZTKpLtl5LNczn/J1Vf7Ui8JNoEbAAZw9r2V7gJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 19:55:04 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 19:55:04 +0000
Message-ID: <0678a4a6-c3d8-4dca-a935-4ce5da10dae3@intel.com>
Date: Wed, 22 Jul 2026 12:55:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtase: fix double free of multi-frag skb on DMA map
 failure
To: Yun Lu <luyun_611@163.com>, <justinlai0215@realtek.com>,
	<larry.chiu@realtek.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20260721023836.6691-1-luyun_611@163.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260721023836.6691-1-luyun_611@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:303:b5::26) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c6cc4e-f11a-4471-7900-08dee82b1f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xCidohHahmAfnWd70ZCQuhgnZ2iGtVIPsTmxzuWEgY4P6iFqKzTTvNl1Zr8CZxhKMCgb70hJ/EFUyDeAX0/ja/cJ9NnHmkmN+X0gG7KV4nq6fZxlKuQ+fNQR1XhGM9MVR1aJXrhsK6EMeT4imD9fodvtVuB+Tw0aIYnd6/ASOBHG7eYkpK25oosQGMrnOO5fYxc7lWDmDtvxOJFtysUXJAetjTaLzVEN7J5W6tdw23WwhBiAOFn22UIUyysD71B3RWTerlCDZ40Hf/p0p65TPnqV+XiasePUGgCHSqGPXiXRUpBIPUXLxUPVjQ1PxxRkhjJ7Ave/Bm/9zXPl4m7UGJqcnwZFLq6N/Cd4/bde8FuGejfWX8uv4jCtiYSYBRrxQARqf/K677r1/mwZp27B54wRWrAfG3XVeFePdMc5Sc713urmnlVmArMIR2tf4uKx8mvtfH/gQvbh5cG8MFTdAlmJH+EhmVr2mBG8Xun/fqBUsr39rgTzUEGtt3WycFkJMiwMp80xjJC988pPmi57GR41h43nJaSmM69Wul/v2x/SUlvWYmCfSNk0ntrOUtMsZMe0aQCkqDIe0BuA7CvrkPVeI5xfG/mkVIrsds+Jpec+Hd0KaFWkkKhpUEhS3qPzOVW3Zk+8/kyMYhbRzKLiKy4w/BbqEzpZyxP9zY171s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tzaFpLVjgzOU52NWhScSs3MXg3SGM0YVVZRUJBeitaakJ2NkZFV0NxSHAw?=
 =?utf-8?B?TVVaZWl0c3JYTlVKWWNCWmpVRVIreUhlUGg4NjhaU3BGSHNDbFljdjFiNVVk?=
 =?utf-8?B?Y2VkTDRNWlllZ1o2RVJTTE1FU2RWMHlTZForbUFDcFhkVkRMZmZuVGhWODNM?=
 =?utf-8?B?UUJPdlZFeFZrM1NaOUEvcnZLNGlsY0ZzRi9qZ2xzOEtyek1tZmdZMHRrT0RU?=
 =?utf-8?B?WFFZNVM5REg5N1M2U29SOHFEckJUK21lc3Q0ODNXd29nUGZYMlF2QlByVjNy?=
 =?utf-8?B?ekRtYnBXRCtKdkFDcVNwTnhsVVBRNnVMbXlMWXFTWURNbWwrMHBWMmpubjI4?=
 =?utf-8?B?WSszeExCRjYwcUZMc2svbmdxK1ZGRFVaSnNoY0x2SEJlRzZONU9JclNDVDh6?=
 =?utf-8?B?eS8zbUVtdWhFMDlUUE1KMmpyWkRuanQxZVRiRTR2bVFNVDNDT2xsVzFzUWtU?=
 =?utf-8?B?KzEydTZZNVd6WjYyN0pJL2xnRDJlNVNkeEd3ZENDbG9lWTlZMVNzd1RJaURT?=
 =?utf-8?B?Q1FGSUNrUHdGVXorbnlpZHcxTHRhRGhKRGRZQVQrdXRaMlE5dTdCaXdpa0Mr?=
 =?utf-8?B?TkJoUzA2aklpSHQ4aWs2NlZPd2JCdzdnK1R4RlVOek5NVzhyZTd6WHRLRUdG?=
 =?utf-8?B?d3ppNlVoZjN4TitMeFl6WHVPV1JwUmQyWE5nUFFUNUNNZHhlRlBYV2VzbDdS?=
 =?utf-8?B?QU0zUCtPQ1lGZk1KMFM0UERFWUtScHdSUnVVekJSUDBWYmdMSUc3alg0cG1I?=
 =?utf-8?B?c295UDB4Uk4wQU9NTUxmN1lCY3FKdWNOd3ViSzFqZzVvUm1jTzc2MElHalVm?=
 =?utf-8?B?RTZ6bDlsZU5PeXJhOTliRkFHMDU0eVBBbnNsTHA4emVqVURoTE9yRDNuY0xo?=
 =?utf-8?B?Q1RWQm8xUkVBcThhMjRCajNvS0drUjczU2RhN2Flc1A5U2tEeHh2d2hzSGp5?=
 =?utf-8?B?KzFVcWR6K1loc0pCRy9sZld2UGh5UEpmMWZDSWdUczh1SXZCblhQbDRpSzQ4?=
 =?utf-8?B?OGhzWithM3hXUWxnaVRPNHRpSUxCcnNndDM5d1FNRHVYZ1BYNkU3Y2lKMXRL?=
 =?utf-8?B?UmJWaU9mMU9yQlAyV0trZFRGUk04UGZIc2dsKzFtQlpZL1kxU0dvSkxMb2Iz?=
 =?utf-8?B?OHB4Q0c0L0RMOEhtUjYzcTQvemJyOUEvN1YvM2NTQVZDem5pM1lYSnl6RnJL?=
 =?utf-8?B?MmZ5TVV2Z3M0L085L2JYTU1WeGl4S0FaMHYzTDBtUTN0cGxpTldwSFBveFh1?=
 =?utf-8?B?OHhaeXpva0h6NFYzNHBETUUwZTBWNlJPSVlpUDFPeHlOUFprTXlnTTJOY1dv?=
 =?utf-8?B?OUg3ZkVXcFVrNElrcDdQckJHK3haSTR4YStOcXVwT1RPblkyYmFnT0RoNmNn?=
 =?utf-8?B?cFdwNXZqMEtMZm1LU3R6ODkvOWI2a3YwS3RKdWZUWDErUDJqMStDTUVnQVVD?=
 =?utf-8?B?VmgySG5ha25iTGtHWVEwdHNrNmFoSkZSTklnL2M3VFpnNWRBYXpQRG45VlM1?=
 =?utf-8?B?Q0I2bSsyb3pQU0NOMFhlYmVzb0IwNW5HZ3JlY1RiR080VVJlTTdCSmZzR20r?=
 =?utf-8?B?WVhkdlo2MTN4VGVVS2tTWFdoRE9vREx6NklHcldoODVRVWJHZmt3enJMTXpq?=
 =?utf-8?B?c0Y0dWc4TjBReGticFFJaEZqWmErQ1Q0anRGdmtPNjVvVjE5dGVwR01sdFJw?=
 =?utf-8?B?Z2owdG5BS2tGOHpmWGRBcHpPbHl3K2g4cnFVbThzdGNPSUNRM1hOV21ZdTNW?=
 =?utf-8?B?ajR1SnBvRko3V1M5RzBRc1o3NkJTSDZqemdRVE5veHZQajVOYTd1emRRMjdK?=
 =?utf-8?B?TFVkVGM0bTZXNFcxSGhhYkVpNTN0ZWhvNk51MHBJaXQ0dk9tSFJCQ2UvdDRM?=
 =?utf-8?B?Q25zYk5KajJ6QTc5cHpJYTJ6VzBKd3EzMVBJR3J4ZllZY1NmdnhwN0dVZGwv?=
 =?utf-8?B?THFNOTRzeDl2a0FLNmcvY3BuT085QzJXSWxJWlJINnpqWEl6UmxaN05iVlU1?=
 =?utf-8?B?dE03cUVZTWViRkVBZjA3Mjc5aWkyZDc4enk4aVllWHBBSlBIU3lJdEJyVWVn?=
 =?utf-8?B?VDZvSDBQVTd3Q0NTaTUvVldLUXNxUEh5NUJxOWJYNng5aGE1aXhLUlBpMTQw?=
 =?utf-8?B?ZE41ZUd4VWRWMEo3dGczMUJrdUk1ZzU3cmlIUUI4bG8yei9OcFArYUlZVll0?=
 =?utf-8?B?N2ZRRkdoTk0vbTh5RG0yM1BSSFRvMVErK2FYd0lNYW91MlNqVWVEOTA3a1NU?=
 =?utf-8?B?NHBXcERIRDRUd0Fkc2NVdjlqb1FzMGVRbUszTXBYek1rNkFyQ0VwMVZ0T0tJ?=
 =?utf-8?B?ejgrbzlmbCtJVU83Sm5WTUI5SHAwTXl0c2tKWHpUWVk4bE1vazBNNERJd1RY?=
 =?utf-8?Q?zRHH/RBcJb2Tz27U=3D?=
X-Exchange-RoutingPolicyChecked: OltpmTpWvh5kGyLy11kVX3ZqTxorAr9JfFqHn3jQ93i8bH87epdWE+FHSImZgA0TLJHqfOtbKvP1FWb6e3A5zc7SUBbslzQsQvUNYlmqqyGUVNAVNGeoQ2RIo0tvHp9WNxB3EnhEo1OPOFglT8Pv1PFq97dz9HgUVz2QsrYt90/sGwowXRFAdtIJBwD44n6J0+hPdyHDJfbDn2jFI9I310koqB0vNAZa9rmlMaU6U6ea7tbqSIuhYRc7QDnEXad/zbLGZX803a4deCL+bOBauFpW2oYp3fsJDvak9gHBjhb4xoW+iCtCs6hiJDUOK9vCELVkZ6mFWyuyIB2tiHHm5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c6cc4e-f11a-4471-7900-08dee82b1f59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 19:55:04.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2X+W2UMDBAMHujM+sK+s9NqBa8awjLB2UoLNaozuiruMog8d+7WE2erfdZXSrAf4qOXrL/S3pNiIFixxAUi8ZLF03I6YCPeimPX8CO88zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com

On 7/20/2026 7:38 PM, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> In rtase_start_xmit(), when the head buffer DMA mapping fails after
> rtase_xmit_frags() has mapped all fragments, the error path clears
> the fragment descriptors with rtase_tx_clear_range(), which frees
> the skb through the last-frag slot and accounts tx_dropped. Control
> then falls through to the common error label, which frees the same
> skb a second time and counts it again.
> 
> Return right after clearing the fragments when the skb owns frags;
> the no-frag case still drops through and frees the head skb once.
> 
> Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 255667775f0e..67f7fdada119 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1426,6 +1426,9 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
>  err_dma_1:
>  	ring->skbuff[entry] = NULL;
>  	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> +	if (frags)
> +		/* the frags were cleared above, along with the skb */
> +		return NETDEV_TX_OK;
>  

This feels a bit strange, but it matches the code in
rtase_tx_clear_range. I do find it a bit odd we're checking frags here
even though they got freed.. but it does seem to check out with how the
rtase_tx_clear_range() works.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  err_dma_0:
>  	tp->stats.tx_dropped++;
