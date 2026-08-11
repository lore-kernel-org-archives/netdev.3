Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DB402BAB
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465157; cv=fail; b=WUjurTh7ExID3awFDMmyN6Axa4lYD3TvKINIcfGXzLsdoumTUFXgXlWb2bhjXWv1x+oSV6ut0Ns+9rOgCuV9aeQJ8qlZeyanVV/jiQeyp02PCQ3e7L/ErninF3W2qtktIOxB3oFPS5hpNTO2wL7eMAEzcf7B0hvmxuYwolQcsxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465157; c=relaxed/simple;
	bh=iHHQXSBFRi3/c5Dg2xRGDW33MjcUSgKQYa8N3TizJSk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VeLkBfXHjBqWRymQeq16MLD9C7CNicw6H2SHOHS+pcKTptAFX6Z0FAnI6Gs0tPHIZEs2CfXorG8d5KH28OFpzBrNEYu1Ry7a3VqKOT1TN8wMDyP3/JQK366N9uHq5Ovn5MG6qHNWVh6zzzI5/fHIpswvR2SsHZnWIjMOAascGeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gS4/XmnE; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gS4/XmnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786465156; x=1818001156;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iHHQXSBFRi3/c5Dg2xRGDW33MjcUSgKQYa8N3TizJSk=;
  b=gS4/XmnEReuKN36ae2sSzCt/k1vNtUvkrUs93S4FffLNP/nJsnxWLZoM
   5ibgKHeXe12aU2KALYPdhPFaYyocVUBKgEJ5xcWjwf6u42C4hf5whsGrm
   zNIEYmYcDSK4Rmggs/uI5VSe3N+bichsNVI+HbvfGWHE5Y9AcicXsaSze
   q5/t/iB8WLvhv/U7OjiwfTo2Hp5M/3gKAmw+VLFvOkvH94gMJyzEpxtJf
   m52uo4COBkZzx09ebGWPyJASCZh5Wmd9gs/yDPS9aUtsQGKK9VIgZ1nEx
   WRvo0h4Xy/9fd3xiHhqT1LknPQEuo2Zctd6aWMMJfXC8qThbpGgk/NlZJ
   g==;
X-CSE-ConnectionGUID: BNw2aXR5S16hvva69qo4TA==
X-CSE-MsgGUID: nOtJLtzOSFSqFL3PbGbHXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87014759"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87014759"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 09:19:15 -0700
X-CSE-ConnectionGUID: qLtt25NwT4qIKcHafP6mRA==
X-CSE-MsgGUID: 8X90MDzhSbmGiCLCxbJ3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262882070"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 09:19:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 09:19:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 09:19:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 09:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2PEHZmL+ppMsBNxn43khuEwptdfcaJ/IvBxpCzA0jKfIJ0bWL1mtuIW9Q/q0ymf6h60B23o1ui32P119d78N8pakBoqjt5gBRKzLWYVQRmug4d7QkERzQaqv7mRkRcHH+h/WCGD7Tflj9TH6RIcv4gLfp8ZFa0TzMmGMVJakFyfbTKTiBo0RwedQbSbJLVNaouvgyeLec3YDe+H4gB5HC7GgW0F4CpqZ3lc4nWkQzyrrbVsAWhfVqBFiaiyy1gDGPyZok9zLcDlYA3SEredkljP63m41BKYFyxsuHYZ0osXMwTVG0VBg1PO0kHzUCCSeVvi8LSc93/l2b0eRTVMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8VAD3eUj6dPX2iqERlMTA9VHeNsweja48XdSgpIxmk=;
 b=R9vozIgFhkNejpxlyMvv1B1gWxYJBAVjM2nUxFF+Wrq/UcTYioliMbPskECoQTelEdf/Xfh3MGimLchZu9daDIGgidEhO2PSYupcCnUg84O4nF2nCW67Q4UcnNdbni9Ucj2uZdbkBdJTfx8XygvcIxs128whCVXH+BoDb+JUXBpnP9qEFwgM9FpSSocFrZw+7jtwlXL5vk5133fSybX5dIFafl1DF0Oo+uIObGf/h84ppI5v4/eRhL12RwndX0XXVd/yMhi7wXOBCq+cjTLQWTRRpTke6aTh2HgHnOiD82aHLnwgzS3F3HqSn8HUPrtof0Z7hkJHFjMQwR9XFrlYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by EAYPR11MB9586.namprd11.prod.outlook.com (2603:10b6:303:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Tue, 11 Aug
 2026 16:19:12 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 16:19:12 +0000
Message-ID: <1df906d3-7cd5-41b7-b23f-6601451ba5aa@intel.com>
Date: Tue, 11 Aug 2026 09:19:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver
 Updates 2026-08-05 (ice, i40e, igc, e1000e)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
 <20260810173508.4bec8799@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260810173508.4bec8799@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|EAYPR11MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: c4383e02-a47d-4ee4-9627-08def7c447ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a0WwUgGPLFvhhXq0WqbctJAPVCw+pK5z9WtUk8Jbmxc2OxuW3g42rBkMSBvPWSxtDJjaWPxoee6AgBZhPzNi/C4J2Q+Uh8HPzr5XlMIE8ubacI6aWGPuZ261M7m9DWvFZ5xdwbNK1pFSLDE/ejcQ3qX41DP2vCUZeu2uT/x6RS+vYBuMCYXkSd9yWAU2LNBovvR/XhgKbafNMTy366v15D86pNZJCB8wfatRPGMn1xxffbik/U6p1SRF8iQn9uXSVWrT7bY33qXtiMDlKDS95vcO78aW+bNJ4DMgiIqbpz14wyihMpFKVSiCLCsmSNvFogOhrSOT9mp/TAXvoSHMg4dY8ZLadgxMjGk6o16lrRCaE5WD72uBv7qvsDn++MrL1nxJ5inNOJyGO/KNhTPjl6siveKqvkPEphP3pKMgy0wAEbTuT0EsvSEbQzfuTG37kjxODEKW0bXWRQRnxhR8G9lA8mC7yjo8ZyoBGGklsVnX8xfxavlaEsNny1MaH7Rmf/oMbjvGXhdW708QWekBqsirymDij8tdCAq65MWh16bvvu8/qMZNWyvVO/3jmCONRptg2GU6utUOiAQXM8yJ/16O09/1M1UlCnDJHgY1AvLWklDXLWawjXpSQ+bjW6bDHidfuYcdcD5vp0eg646tPeEdLxFb/ppO0b7j3LxDaAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZBbU1iUFQyY0c4RUF1TE9INzMwYjFMeHB5eEVLV2dhQlBMaHJWYUJyejQz?=
 =?utf-8?B?U3BZQUpnVjJGK2kySTQrT1VuNUc0Tktma2R4VG42ZlFDOFQvMUsrc3hJcHpY?=
 =?utf-8?B?bTVKNzdvRVM2VGFleDJzazFmbzV1U1AxazJZQnphUEl4T2VSQkM0MXEvQ3Ux?=
 =?utf-8?B?MlBiejlWV2E2S0ROUjRjM3ZjL0tEZ0h3blNPZUEzbDJLdEJKRGFydlU5VmVL?=
 =?utf-8?B?SHM4VXBrUlRLbnp5TGxRQ3J2TTcrcFBrYlhiVFJTelNBd3M0RElIcUx4bFRC?=
 =?utf-8?B?bTlRTi9VRXRVb055RjE5Uis4K056UGFyYUpESVdWRU9xRWpuQkZVVEJvT20v?=
 =?utf-8?B?dk5QT3NvMEJhVG1Uc0h2TVgyelRCWjhPWDIyVzRIRjU0UWEyNEpyWFdNUk5H?=
 =?utf-8?B?akpZbmNYMDV4Z2dOaFRkcFNLS3lyNmFYdDBuVGV2OGx2L0liY0NneFlqY2ZE?=
 =?utf-8?B?RjhRMGk2elVEWldRelZXVFR0Q24zb1NGMlF5bUdXYWZ4cFZObk02MC9IMWlS?=
 =?utf-8?B?VFdib0lQOFpLQjF0SUF1TVhSSnE2MGVXUSsxNkxEM3VmVDVhYWJIemVxZS8v?=
 =?utf-8?B?TDZwak5iMUgyck01K0I2cVRLbGo4MVc1SHhuNEo0N3JZM29qZEZOYVZtR0FN?=
 =?utf-8?B?MkVoVTJYWWduUm1pbENnK3dIdlp2ZkFNNlZLekNjOHk5WFBhWWpMcmJ6aEtV?=
 =?utf-8?B?Y2RsRE15VDdCb292YWdZNWYrWm1KSXJnalIrL1IwT3lDdnViekRwL3VoanU5?=
 =?utf-8?B?dExTZ0RZaFhObHVRbmszangwUlR0WGswN1V5cHcrNjR3N3NhMU9JdW9ZMTMx?=
 =?utf-8?B?V2xwWXpsaU5IQk9QdmlRdUg1a2RnZjkxUVJ1VVFvNEZpa2tiU3Bha3IwU3Jp?=
 =?utf-8?B?S1IySlVua3U3SDA2N210M1lFMnVQSHNzYTluU2ZiTXhPOTNZa0RQK0JYUi8r?=
 =?utf-8?B?ZHh5LzgveGJDTkRFeFRDQXBLWTVEczRrb3ZHcG1qUGdvMVFMZlBadUEvaDJv?=
 =?utf-8?B?Nmg5V2wvUUFkbmlWUXpEYjVkWXUxY1VIMDBSR0R5VC9PbWM5Q0VHMlVrTTNz?=
 =?utf-8?B?ZTE5cnVkQ1VmWFhrRkh3WVlSdnZ4S29pa3ozZkJ1WVlsNEU3NHdDMGpGLy9Q?=
 =?utf-8?B?R1NXdjNPNjMzY2J1c1J5aWI5ckluMWFwZDhhT1BhTVNvSlJ2ampxTDZ4UTNS?=
 =?utf-8?B?aE5JdndLVjlEeWJjNk1RUG9STlZaaEg3cC93L3N5RnphVGJJaEwvVTYrTng2?=
 =?utf-8?B?VEp2K010WVVJaDVzbDdnR1ZNQWswR1FwRk54Q1JXVWc3cjB2SE91WmFHc09I?=
 =?utf-8?B?TU1jTDdhc3ZoYktsY1JDRXkyWll0R2pibU04cnRodlc2WHhWOVFxRzB1MVJZ?=
 =?utf-8?B?Uk0yT3ljaTZVTGN6ZWRoYXZUL1c4czUvL2lkSk1odzByZWtQSGNFWDkrVXpZ?=
 =?utf-8?B?MFp2WWNBa0FOUU5kRHRIdU1UbmFFQTNOVkJEVlkrdzhXQVY5RWxFaHRNQWNn?=
 =?utf-8?B?cTlsbHlCUkZ3bWVvcW51NXRXaG9TdWRIUzdlTGN0RzRvay9xZVY3QVpKalV5?=
 =?utf-8?B?YmJVcWpBTjFnWDh3cXI2MlplZkJLSGlQTmRpUE1seWw4T2lhRmdraVlackZS?=
 =?utf-8?B?aGU5bUlzaXhWSTYrQjZyK0NzTGtFYWdzY1JhWngxaHVJcUF3dkQ0c2ZiL0Vm?=
 =?utf-8?B?V2N6ZlliS05LZkN6SnVIR0NUSlgzaGtjeTU3S0VaNG1zdzNuRk5XelNjL3NG?=
 =?utf-8?B?YzNXRGRPSm5pZGYwR2w3b2YwdzVSanZHN3NWWjg5L2hjN1RPYk1Xd3M1TFYx?=
 =?utf-8?B?N3lDRXdZbXJRYk9VL3NPdUlCV1pZYTdYanAwbFpHbTNpWlJLbmo1ZUsybkNj?=
 =?utf-8?B?eEMyYUhuRExTMmg2M29PR0lmY0dNTVF2WWQzdVRKZy9jOTkrNkd1aGpML2Ez?=
 =?utf-8?B?QlNUbzd5cGR4N3lqTjdVamQyd1RPYnFSaTFsMGFhWDE5ZHhFeGdPeXNjZGwy?=
 =?utf-8?B?VHgwMTJSNmhuNml6b29UeUJicjRxemE4VWhBbmVWdzdsVldJY2h3bW1jS3FS?=
 =?utf-8?B?SVRRSFV4Z1ZiRGYzUXpLTDhETWxuSDJ0K2xJdi8zOXQzMkFGZklhT2ZFMEtR?=
 =?utf-8?B?eUdKRmNUMDUrMlFwOWIxaXhDWW9hcktXcUIwRXJKdVZRTlBaeTQyKzVIRUJ6?=
 =?utf-8?B?SzI0dW5PMGUzSWd6ZVhFV0VpTlBOVkN5L3k2OFloOS9xVWN3ejI1amRuTHc2?=
 =?utf-8?B?RVNjMTJaT2lTV3R3SVhFcUNRQ29GQ2FNUS9rbDhxY0ZTeFg0NkFTTTExV1dh?=
 =?utf-8?B?M1g0QUxJbWJNcldZNHJPb01LMWd1WEZJbklESk5STUd2OFdWVlRRalpGSWYy?=
 =?utf-8?Q?zYhV8TIHUZ36ibzw=3D?=
X-Exchange-RoutingPolicyChecked: Vu0u7KW7ev6nsguI+9LCdn4IJbDtmaoxBicLDv2FYxPdtMZ+4eIVwS6zCmmowBeBIG3jEmkQI9/JL6zM663NbztdsbbbANpRp1kz/PM+9AjZIVNZOhqM8x8DDDWS8xAkDhb0fi5j4Jmi2o+GCvtg5xgMpcS0oSQfMw6Qg6iFWe+xqibk9RYMslq5mwF4eVBvsmzq6iLSZJSJFcOwu8wPVddRU8RIwl94p6QH2e6a9NReDEGYDni9dQ7QSr6PkhG63iPy6FRYR/h5HfrZGhy5HvI8V17c/0/tiorHKasqRQ821LUhI484tbpi4kyuNC1T1eLbzyVvJdF+F9M7zdMEUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4383e02-a47d-4ee4-9627-08def7c447ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:19:12.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGFbWRC7ycOy+q+64qcveiaMzl7fWr4HkXpU3VQ8gQzv6ECbUjA4jY9wgmhPmcvNzIbWR8wR0qFWKWwAGz85TiyLgZMm5YdY9vo8p5vIF84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9586
X-OriginatorOrg: intel.com



On 8/10/2026 5:35 PM, Jakub Kicinski wrote:
> On Wed,  5 Aug 2026 14:35:25 -0700 Tony Nguyen wrote:
>> Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2026-08-05 (ice, i40e, igc, e1000e)
> 
> I only looked at the High severity sashiko reports, they look legit.
> Please consider splitting your PRs by driver, the i40e patches are
> likely okay. You can have multiple PRs pending for net-next, as long
> as sum of all their patches isn't >15.

Ok, I will look to break future PRs into smaller chunks as they make sense.

If I have a handful of single, different driver patches, would you 
prefer to get them in a small bundled PR or individually?

Thanks,
Tony
