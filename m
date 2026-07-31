Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26F22D661C
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510954; cv=fail; b=l12t31I+UYT+fvTXlxrZ3rYsCIRZBKMx3vVSZLtnYt0O3w03knNjxe2ZIq/MaoLYt5GgD7qwYK505x1cSim+9bwGyqBLdfWdpcBTZSP59Ehp+nLiAJxyMXqQSaj78BMfuSNKMVADZndri8/CjMbXMEPx/d6yedXh/tze/JG9IQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510954; c=relaxed/simple;
	bh=OrkEPT/wTgZ6E1JafO4vhe1Ozj3Q70bFWKCPJ1hgvJU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R4OPYPADalV96rS3WXeWId4t2LNNdoHW6FN9UxPASYzR2R1yod+lh1xb7dIupa5lDtw9f1IJwpcm0wcCnbFNCHAz8bPUVTntBw421X9QXPfZy60GfcoRXTp9mFCbmW+o4XQ4DY0rNjgAAyV2IA9TY7b5+7nkX1hLagX5NIlaqNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfprV+ov; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfprV+ov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785510952; x=1817046952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OrkEPT/wTgZ6E1JafO4vhe1Ozj3Q70bFWKCPJ1hgvJU=;
  b=WfprV+ovvX4AqqmwnehAMvt3lnt+BGtd91VryfT2T2QSc2oh5i08s8Pw
   7wuVBQj0l+clN+jLJ2F50ZbVrCnYYCNMWbxm3M17J+HWcppfqcNdZckIA
   XRK477qpKJjpENXbfO9nllhPUfRxMPYwLMdzFP5e+Bk9HnTP2trMlN+LU
   g/lh8J7N4qPAbiZ2gU6W7f1EeLG5DSN97jVhOsmuAva5kyMzKQlFI8tLp
   ef1NrdI1jvuqpL/gXmTCqugG+TcA+hMcWQDvwOLDuZiGkzC6Qp39MNG2z
   MvGKv7/QI1ceiHCOXvegYDDhcS45B3GtzkqIkueO09ZsXQywKecMN2RNt
   A==;
X-CSE-ConnectionGUID: viXU1HdxSkmWUkplKK/qkw==
X-CSE-MsgGUID: 4GmJirGpQR+S6YEWHqfagg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="88669832"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="88669832"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 08:15:52 -0700
X-CSE-ConnectionGUID: SzszDrlxRDKDhwWQiZQDSg==
X-CSE-MsgGUID: mnGLXUVcRYSH9Ff13HqEZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="264864198"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 08:15:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 08:15:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 08:15:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 08:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agJ+IneMRY+xUCYZw0Ctv4M4uXSxZMcI3pdaAFWapqNMR1KOUVHXhqM3cwVp0DtaKgb/DwU94hPQIwZny9zZRjzBOXk3451cyP/tl5CVoGuQ8PWMy1r84rsa7XUCznrnPZv46D0vbWxm+HeTB/yk37zLuqFMfhoyjesnOdkLfan3g7utdvjioTbP/uFqHWgf7zOn5Vhp8X6rmFdLCwuL0+jDxuOvHEUK7dn0TeJYxd77oiwd/irJcH2n6d90oMOh0L+GC2HL91FnS55XK2Mp9nk1+DDXK/TrZpxTx69nTwFL6Hu2oLtSCy32PamgjbVOyKLd/O9tmVUIpWS20m3iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnDnD2hYX7mKqRt4nGgZtgeM8H4QMMrs6Jlnuj7RsdI=;
 b=iOm6pYB3i4a481szqxedhNTXDSKHWcQGDPhzcsgFCQnl3wVm3U+Y/Hi8/XuxPoMBoMi2Qfru1EWvWJKNrYl33ZvMMP1UCEXvx/cRVV0kjWbiGjTsB5IE3JdVikP5fhfW9iMCMM5+NwtRIjcfegeb39r4Eha0Mn6tZqvXbF2CTgioWE9jdxB3m5IdYYaIOUPzD3dbQRWsS+zfc6Gp160tqBxz3HN1JAFFq+fmlnPGrqlwtyuxLfhXmpCtBHKzFsuJagE5+18DFcMvptLTFmWPtdiF8pMprTt70nhToHLdLaeTvlSZt/VzQsqOmPPhy/k0NmDu0p3nWefII69gM/PoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 15:15:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 15:15:46 +0000
Message-ID: <7e9a5228-d257-4adb-b472-b110f60e3618@intel.com>
Date: Fri, 31 Jul 2026 17:13:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 0/3] iavf: defer loading netmem_desc
To: Matt Vollrath <tactii@gmail.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
References: <20260731124109.99065-1-tactii@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260731124109.99065-1-tactii@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:803:14::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA3PR11MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: f64645f8-bb74-4a46-1720-08deef1698a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1fT2Unhec4sbpI/p0406ype3Vhi41Jbrfb5WkCbkSpD1/EvfCDakOLz3lifEeyrv60pYLPWgGRa95+5JyeCH/Mf38ObQFvNT009tVOpHWBVwHE2MT7mh3wnK4cNuZCS8VO3b93rVOYy1Hx2TpfLm1/JQE2+7t3yMBpTgr2EilE7ls21z2qYwetAhF3W/T18spEKYF3Sz+/tgvmXZdMhYuwioL2zzpfl8AxFwj39j2JwAR6uB6gbs4E1iWuDT6fmgzyH5uYhHlBEtvEH/wUJSeu9BK//hc814SVE2vfUkqVIFbQFz1e+rIHdj9uoW+ZXohTEcdBzRChiRHSLbjca3OZef+WVr9BwPwBuPdXMh1sNNflOwexNuQaR9JFby3zg0i+dfP0gKVzYaqjrNIwqCch4VqVIp/SfdiRJ1D4dVz32unchkfsFKwDywMv3n+s8t+CQ9BgcRDfqxlw7zuuuVZDC3sY9Ul/Sj9aCEoGmYQYncHsqiMkR1Pad/oFhBsdBqTNBdWikRlVB8p9P7/43TQFZsgktlKs2qCRNWm23+zZXU/ThyYG19nR/txEe/LqE/Q7tRrr4dpsGwRzxh9XC7pWDpBv/cq2AW/Eu4R4Nd9O/zljqU6NYnNGdHcG2TzUohRwIKa6NvkCcWWd/t1f1OnNejESyKXXxdmYfC5yvo2e4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFwN0FJREs1clZCdkwyd2NuTDFDdUJLTjdZOFRJSzhKTzUwd3REVmYyY3dF?=
 =?utf-8?B?RVhWVnhMZDdtekJXaXVhU29RV2dNeDNlTTBMd05XMi9PbkF1MWY0bnZjdlZr?=
 =?utf-8?B?L1pkc0N5T3VYQTc4bTlyRW10VXFVZm1TMTQrRVZINzVEanZaLzBObjBXYkdS?=
 =?utf-8?B?K0p2WnNiS09NWFA2QldWN2JSajVQd3k4K0xRMlByYmpZdTh3c3VDNElCY0Jm?=
 =?utf-8?B?ZTlpc1NRaVFqUnhtaEJBL0dOMWpSQ0pVTEFrZFRWdHNGYW50TDBsc0hmaXM2?=
 =?utf-8?B?Q3ZHZ3FLWGZLby9oOCs5cXpoRlVGaXFjaDVVb042UnpQVjJ1ZjN6U0ZXdXA5?=
 =?utf-8?B?L1hrb05RSmJIMldUbHpZeFlqamoxRmhMSWdUVHh1cUQxTDl2U2hJbFRheFp2?=
 =?utf-8?B?WGN1TS9WS2NnaHdhWmdxNFZhRHRScDRCWkd3UGJXczdoUmZWdWRBYjhtOGE2?=
 =?utf-8?B?dUkxMlB4Ty9wK3RGL296Q1VKLy9rcHk3WjdQOHVCMUhnM3VUai9SQnFaOUlI?=
 =?utf-8?B?em9ELzBXSHpyMXpTelVaWlJMaUw3TnFqMFNkYjVmRXNNQUptd29NeFl5OWdV?=
 =?utf-8?B?UkJROXB6VzZnUGw2dHo2c29vYzRIQWtPQ1J5M3dLOW1RcU5jUHl0ek1IbjlW?=
 =?utf-8?B?WDJxb213aVl6UDVOUFVRWWJrNXBYTUFQNjdWbXBsSWZ1SGJRSGQ0TGxKNGEx?=
 =?utf-8?B?Ukc1aWtGWUphKzBTZHp6NDJXdnZzdXMrRWFzZmNTQXpLMEVJa3dkSzc3bXJW?=
 =?utf-8?B?U0RtSUV5UmVjdlFYVWtJdjFBTWF2Y01EVUNBemVqNXRaQkZoS1dQTjhEeVUr?=
 =?utf-8?B?dXovRkMvVWRsR3BsWFd5UmYwK0VrYTZuSGdHZHByT0VJWmY0eURSQWFLUnlj?=
 =?utf-8?B?UkFXMWxvbjJFdlFPcjhiOTd0a0s0UEcrVGxMRG0xaUlnQlI5NjdyRW9FbFdQ?=
 =?utf-8?B?VEhtNGZRTW1xaTcreUpFZnFiKzdvMEsrenNMMlk2NnJubmlBT0gvZERBUTVN?=
 =?utf-8?B?V1ZxY1F6SXFzNFZuS2VrUlh1NXZFa1NhTmFNSW14MEFHcFdBSE1tdHAzL3B1?=
 =?utf-8?B?ZmRmVnR2MDZIWnJ3QUQ0OElMN1lRQ28zQzQ1c2plelJCYzhIc0dHelZwcG50?=
 =?utf-8?B?blhoUlY0SXJVMEl2dU1VWjc4aFVsWVU4T3FURWNYdW45SmMyc2s5YkxpMno4?=
 =?utf-8?B?Mndzczg4MFF5MXRrV09pemxRaUNRZG1tZy82WHl6aDhOOFQ0aUZkckZRcWxV?=
 =?utf-8?B?dkxvOHNtaHJobE05V2tiOEZUUlV0SER0OWVTdnNmQ0pBcmJSd3lDdXhSR3dy?=
 =?utf-8?B?QjVreURaVkRGVGFUbEVaaCt5RzdmcWVRMDFwc0VVN2NoZWFwb1hzbzVmWmpv?=
 =?utf-8?B?Z2pBdm90Y3RwRDBiTm5Qdkc4RXZGb1Q0UFZ5Si9wNThrcGZ1c2ZWR0FjMis4?=
 =?utf-8?B?SXdmanJQdDgrODhWcWp6RWRlL2doODdNZk9ONFVrZVo3bzdIWlgvNE5yc0J5?=
 =?utf-8?B?ektEVjZENSszMkxFR0dVVzlTTzUxREJ3Tkdsc3hRSkpSNWE2N043L2d4Tno4?=
 =?utf-8?B?TG5kOXIxVDBOWkZwWHZXNldTUExQbVp0NWgvYm9ocEd5bkdFWTlHdnRLUVJp?=
 =?utf-8?B?UDk1ckJmSGN5bG4yckhKYUZsNURsSXlsV0syc2UyZTNMU3VCd3gybzdXYlBI?=
 =?utf-8?B?WUpFSEViTUI0NmYyeERMR2MwTi96ejJLODhrTTRtSGtram9vY2R0WDNmYUF4?=
 =?utf-8?B?T0NkMUljZHVsWVY0aE9rb3VpUFc3OXprejN1WUZVcTNldFRPZGRJL3pRSXR4?=
 =?utf-8?B?cjE4ZzlMeXE2RkRvaEc5K0NBQ0JzM004SExpK3MyY1ZiUGRIMzZHa21SSktB?=
 =?utf-8?B?dDNZQmQyaXB1enN4aTJ4eEdBSE9PYXNJWXhuOTVzUndYK3RkY25rWVd5d0Ni?=
 =?utf-8?B?S2p2SG9DaU1rWGsxY0llQXVNTEprei9iSmxKM0huTWFSdExpKytQSTFMbnlB?=
 =?utf-8?B?TExzQ1U5MHpHclN0Tm1aYjFjR0FnVTdBTWpDcGdzb0FKRUt5T1dKVWlCV00r?=
 =?utf-8?B?MkhoQ2d4UzMyNzZuNWxTUHo5bmdiUUsrcVhqOUE0TStjUDZhUmwwaHl1TmZH?=
 =?utf-8?B?TWdFSjdSQmNuK0NZTE52SVQ3SkF1cVBWOVNsbnVKTGdwSmNpeTdhYnNuUmQ0?=
 =?utf-8?B?NS9hTEdnMHFBRUhmWnB3U3Y0RWRDY293T2pZRjk2WTlneFUrVHlVeEJ3SGVF?=
 =?utf-8?B?Q0dsSTUwZ3ptWmpqZGZURVhRbUkwUHFxa2JzNkJ1UE5RVTROTVNXd2IyVkIy?=
 =?utf-8?B?MEhrTTZiSmdIMk92c0hoaWdoUW04UEVRZUpNSVl1UVFCMjhnNHlXUEE5Vm1M?=
 =?utf-8?Q?huyHA7QGWVybO7TQ=3D?=
X-Exchange-RoutingPolicyChecked: P4QMubXGgjJIc9FSta+gHd7Ird0rHBktzUKUyM3PvaJa1oMsirgxSsjl4HQyz9xRqpJKwpiTH8MVIkK2jaLpO7VF9YLEYQoHek+eh7Tn1PReicuofRcSalh6DLTuQgmKdwAsxw6VvLNTr52cqtbkZ90UARMZ1scz6L3plToctA8Gmoa2ZrthzbbBOdpkFpKHpBTcCOJ1oPPjCMss36AaXbMWbPpqXgQXaBAUJoAAnWlKNKRAmvu/bLRe1Bs/PLB+DtrgddY5vgH29Eeeu0j0tAICnWcNruPoMTR8SMZJijakEK6sI1kqIq0C+Bi+jc3nFx2wgKSdqb4DblRKUoLEsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f64645f8-bb74-4a46-1720-08deef1698a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:15:46.6040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXGmdEWQ/91NpHkdWm6KDVNpkTL88hOlhdAqubmK1jwXVMbfiYoYHLdDF5G2M8N3xMKMDuuK6xyWT+PNAZazJybuJrcYfRt2KzXj3P4xg/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8986
X-OriginatorOrg: intel.com

From: Matt Vollrath <tactii@gmail.com>
Date: Fri, 31 Jul 2026 08:41:06 -0400

> In a few places libeth and the iavf driver inspect which page pool is
> attached to a netmem_ref. This forces an immediate load of the
> netmem_desc struct for each buffer in the Rx loop.
> 
> Defer or eliminate these loads of netmem_desc from the driver fast path
> by using the page_pool ref in the first cache line of iavf_ring instead.

I was thinking of this when implementing the current design, but:

Do you have any data to prove this actually helps performance?

> 
> There are only two paths out of the Rx loop where netmem_desc needs to
> be consumed:
> * The "very rare" case of libeth_rx_sync_for_cpu calling
>   libeth_rx_recycle_slow and indicating that there was no data. This
>   could be similarly factored out, but not by this series.
> * GRO merging a frame into an existing aggregate stream. In this case,
>   the cold load of netmem_desc may overlap the payload prefetch started
>   by iavf_build_skb, which is now no longer dependent on netmem_desc to
>   start.

Thanks,
Olek
