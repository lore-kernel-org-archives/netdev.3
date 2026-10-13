Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC324F55C2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927101; cv=fail; b=c5VzbrANPpNS1Xi+Dy74LDZEoaJgvLZASuENdGrYVpVO9oPONpATgyRdZ+mzXgAKWQokY3Akssb9YW71BCpvsvX5Ny+5nFflm6h9Pdx3aKfJJHAVEStloQ8zpzJr8/7xxE/p8W+RMalHsY3+EG86+XMTT+4GwOTXxuI1SUGEFxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927101; c=relaxed/simple;
	bh=BbFvTVnXGLdzNSXsUrXRcL5KLYwrmDtYND2FUZinYE4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tW6szLhECqD1iZ6Gc7+Dzj1x/RyLcJZyHpC24oFymWUOjWj5qCpLHhHYPiydjXacgw5ihfAx9xKfZJavA7lP3t3HG+gj5Mpq2Cj1Jme1EjozMWFlQpyM67dKteDl3woPHXVBeTh05f3ch+FVqa9iojLMDbhj2oChv6lUefIpiIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJVdOWZz; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJVdOWZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791927100; x=1823463100;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BbFvTVnXGLdzNSXsUrXRcL5KLYwrmDtYND2FUZinYE4=;
  b=FJVdOWZzsEs7LNRxXRFWZH82uSlV69QkTFlJSIJfn/cfqwObDPJRE0jX
   iJrVMSAEcYd/wJLwzs9CnqDZXuh0AVrCCe76k9t43Sj5lWWhDYhsctxMd
   /JsiEcBZq7xZ0qBz6vBl00B5XxQ2LEphIDCXH12LjNdsXMJYOfIAZC1pe
   em6OpieJ8zHoVGjW2TYNg1WMlYdN7ksN1/eukxTt39qj5wH3XGvldu+mi
   WamHlEQ40l7VlLBhTKck4g8SUhuh6UBmruXp5l3AYzVw7woR5n78Jhj9b
   aPOy2qZz/yiu8VrtTNvKX3A+PDCA6aVJG9AHQc2WTG654+LLO8ldPVm97
   w==;
X-CSE-ConnectionGUID: ujuYceSWRP2Pt1PjYRQ5Lg==
X-CSE-MsgGUID: JW8TsbwrS1We9Em/quPeAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="698151"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="698151"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:31:39 -0700
X-CSE-ConnectionGUID: chwxUYzHTD6WjZovpLcOnA==
X-CSE-MsgGUID: 4iX9WXtCTvSMJ/9NE4EWsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1150678"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:31:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:31:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 14:31:37 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO50UfQvJqTs1bovWhkXA5/pWMcpMgc8hFEHOQtn+USK/xqrimUbu4/YEJnQfw6WdzE+Xq7aKWqi92pkgpqRgyBbq8k0r0CyZoJGIduFr3xnvKt84kjVVy6oY6FVTdOPXvGteYHK6twsBeMAdQhky9U5EcZTYe//aNDw/7d/a6aQFyc7s2GeTEsrqz6hagNpQtQzCLcsSNpx/Xma6FEPJyWHFxDxQUt9paz6L8S0TAafKbOqxYrfD/bdhg19Z2j+PWyFy6gCpS8k8hyqb/M97DULSRWE8Zdl++THyHhzWGrpf/2+TszBAmB6dZNxUO3kthR4g05G8debg93fu6tRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C/JSeMhLBUpe+PQtqlq7zxhmxdSm5OIsuTHzdlJXmk=;
 b=LxK/wSzCdh+VloIXXfGj6LQTgBVrZ6fTbVJPMzL5lXDgS11D2PjKxk1G+Ibf47WEcmdmnnglclstdDt0nXi/kXLFUdlRvhfPqs5XPTtsgL4pGzNrV3TF57lL5MuL1hVekmRj1LBx7lt3nhZmbTcupfylpuoUIcSlna4eC1Joojmbb7ZCWrrWyt9bq/oJ2STSlWjDrgmx99KG20f6rZ7+PJA4VkpsSQVd0WNNXfI5WOQ7kWtGEK3AIwKUJKS6wcuVeqInU7ZHsSC+HEE7XknrtjdeVP7+h0uzEJnCNvgLo1Aic79A7h2Q/mbXsvf8b6lcNetuEeklSKUePIzDLyJtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by DS6PR11MB213113.namprd11.prod.outlook.com (2603:10b6:8:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 21:31:34 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 21:31:34 +0000
Message-ID: <50484cfe-7451-4707-8f23-165a6c85f4f0@intel.com>
Date: Tue, 13 Oct 2026 14:31:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 01/15] ice: fix removal of PTP timestamp tracker
 during reset
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-2-anthony.l.nguyen@intel.com>
 <179184691805.434549.1970305171129280416@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184691805.434549.1970305171129280416@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|DS6PR11MB213113:EE_
X-MS-Office365-Filtering-Correlation-Id: d128498a-70a2-4094-0726-08df29715ad4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|6133799003|18002099003|10067099003|22082099003|3023799007|4143699003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: Glvi4VCqtJFAVRQ6M3aYxlC9dZZC08Kliktk+PFavelNi1h+ieaS2seKW3MZNWKjmgsLVgrcuASBFhnwDJWUPynzMv+UhL38IyXAc5ZkjgsDKmEvlg0fme+2eTeD90Qp/pOxPAbD2rvgU1L7CJ/v/3KAnVRs94OBZ2ht0ZjhFHJf+EkM9eAh8iLMJO/ycq4Ea8wcdwIL9HxK+LaxQCzk9dUWzY6I609ceWc8ESkmvGyiOCJpVsSSVDuRl1bp+l5G/nrYzZqaFjg6+KZGAEnukXXFylzcmzEnGO65duUjnLFcjWvj6k1dEjEcbo/9bE/CQDZ+T1Y69WpuStTtK2SJSggLwegwGJSC8TOU1dWZaSHM1M6oodzb18lEkULR6Y9myUuhLp75yQy/ngqY9R9Dr4sX4Pi/qsOYUkVAl+z4wOp9OyvAXbthY/MMyKNvyIwb6TDJx4QbdEpUfNjaumBFZYACZNE0/U1G10mvxJbl9EECod2gNRL+JrqgbJQmSNzJYK5d+fo6FRMX4E7xX2Y8QF92c+SeMNs2ZrS+rwxFffTtLiQGxFWLlEKgOTKR9UxbE61jrFjFjR0AgH+o9YfXUwvsamEf8nr+jys2vxlJTmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dOM21SR1JOaEdUSHFNeFhsalQwOXdYeGl1YWxwRE9LZ1lkMzB2RTc1UnRX?=
 =?utf-8?B?YmlESU94bUlyWXVNMTV3ZFp6a1pZVzdKWjE1a0loS3JtVkFIeFkycHdEamJs?=
 =?utf-8?B?Vmk5dmptNHpYWmdMRVJhS29QQzRJMWFabVJLZDNoNk96NjVwOGtGWHZiQ2hl?=
 =?utf-8?B?bFlPWWVCbWNobFpBRDVnOStCSGFQZDBoSFAvK0hkRVpaaDhtQm16T2tpYml4?=
 =?utf-8?B?WG5lVnNaZzY3UHhuS2pNNUFsdlMyMUlQWUwvTjlUMGlYd0FmUXh2K0J6VHVP?=
 =?utf-8?B?VW1sQ2FqUlZuRU1yemhveU5wUUtzd3B2enlDbFVVRnkrZVRwNklqMDF2U04v?=
 =?utf-8?B?Zm90ZnFmbjA5ODl4Q0VoODFIR0VKTUhONG9GWHpsVmhWby9Ib0xkdWFXaXdl?=
 =?utf-8?B?cThpeHl5Z3FGUVJ6MGwzUmdSZzZTcFJXYzIvSVRXb0ZlM01CZlFkSEhRRWh5?=
 =?utf-8?B?azNSVnhpK1Z1cTVPRlc1c2lqeFJlSUhaV3lWa2FlUzF3N05EbXNpMzZEbHpi?=
 =?utf-8?B?QUFaN1FlWEJLcFNNbkZWVUluTERXK1BZc015SjVZeFlJaUFJMjd2d2xlUUpC?=
 =?utf-8?B?QTdUM0pFUFY2NWNYdlJIRUJvdXFiUjRjeWdaa08vWHM5TXhFemZLaThONVhz?=
 =?utf-8?B?TTQ0RGJsai9KNmRmYktGZ01RcVBXT2RiRTZNWVE2YU9PMklySkZJYllTblc5?=
 =?utf-8?B?V1UxeE9JMStRZUFGVlEzU084RjZoNkRyampFSS9CRlZBYzlxcnFyOWdtTm1o?=
 =?utf-8?B?cjdMY3VobFZPWHNkQUZwVWJUaVJEaHVuWUV2STN1MUlrME14SW1rYThlUmlO?=
 =?utf-8?B?eHA1WmpUVE92KzhONFNadERTUHNBanoxR2lYd0V3THZPbGtjYWZ0c1JmcDVx?=
 =?utf-8?B?L1FTNDJ0dGVKMHRFYWdBbGRMVUVoRDFXbE9uOSt0WUE0MFBmNmk0dU1DMG1B?=
 =?utf-8?B?L2hCU21pTHh4azBYR0ozWkdlWTZUcnZabk9sM1JicU9RQkg4NU95Z3NESzVw?=
 =?utf-8?B?Y2hpbjNtbzlDWUROb3JoQkRXY1RWczlWbFlWWnA2bk1vczRoYzh4RjEwL0ZC?=
 =?utf-8?B?b2J2NDBLS1YzN2lFdHl1ZVorSTN1cDFsTUQ2SWZZeWpVNi9nTVI1cGFHaHB6?=
 =?utf-8?B?K2FFVFBjVi9ydVo4ZWhzM2hNNFZzcHkrWU8yak9tbGFtYnJTMFRycm0vSGNi?=
 =?utf-8?B?Rzl3K0NSOGpISWYzaFl1QTNNWFhFbVZnRlA2b0FtK3hZRzkyL2FxVUNoeVoz?=
 =?utf-8?B?YUQzWndzV0wrM1NKcXJXdVUvdHd6VnIzYlhla0RCUHZlcFJTekVCdVBablRC?=
 =?utf-8?B?QmxPeWFjWWRVb0FLcjloMW1SRlNBYUZTZkRXbTNabERpdzUwSGtYNGVlbDRj?=
 =?utf-8?B?RG1JYjhYNnpoM284c2YwVW5zZjlhVzBnRkZCVGtSelpmVjNER1pkSit5MW1D?=
 =?utf-8?B?SjNEeFMrbDF5NEVjTktBTWE5Yk9CTXArTkYyZ21XMkhjOHlRelZpak5BbDJt?=
 =?utf-8?B?N2d1Y083cFo4VHBtcW4vRjllMklaaHpWV1ZQUVNjOTM0VUhwc01KRkd4dnZM?=
 =?utf-8?B?QVY4WVluUkVkSWFMZTdyUE5UeEVrQjZCYnhWaU44MTh3TUptSzZYemFpbDdJ?=
 =?utf-8?B?eWdIL2RyYytoZ3BPYXl2S3pKT2VlNmJqclU3TkNKOUdHRzE0K1ZZNmdmUXBH?=
 =?utf-8?B?V3VsZDNDSGlFNkJ1MW5TQndRMGtQQ1Q3TEY0bUVtY1ZjY3pWV21SNnJhTnpv?=
 =?utf-8?B?ZzVXK1J1ODl1WW9XVDg1Y245cUVOaFR0ZkRkdFZCeHFGMEw1dCtOd2JWaVRM?=
 =?utf-8?B?RkU4Z3RiaWVaWkduMWdNRTRmSWZDbGNBMUVEUHYrM2xIb2VrVGpMMFNxb21s?=
 =?utf-8?B?S2xpeTMvY0o0eEFJa3NHeFhQenZ3QmN2MUowYVB0Y2VqMmlBK09hODJxc0tU?=
 =?utf-8?B?b0ZkZHY0RjQycStkM0FSd21XRFBYT25ZQUJ6VEROU2NoK29NcWVHTEtqV3pL?=
 =?utf-8?B?T08yWnlLQXRwblQvK2RCYXFCaDRmRk9qY051WjZRVnE5OWlZdk5vSUQzbHlH?=
 =?utf-8?B?eWtHNnFCM0dXb1B2ZG1zdnU3RWtoT01TR1RFNUo0YTIrRHFjZ0oxSGlWTDVZ?=
 =?utf-8?B?Tmk2TFV6Vy84ejNhYnVYa21zZlhLbTduYWhFLzRzVjlVL3dWTExzOFhzeDBo?=
 =?utf-8?B?VWJTMTRZL2UvUU5nQkIzRzhLRjlFMFlHOXp1TnlnNFg3VEhPY1d4YnpDend2?=
 =?utf-8?B?TThSeG5ZMEtONzM0aWhGQ2VYSFdNQU9TNVZCVkxQTWUvQU9ibFo2OENmbi9i?=
 =?utf-8?B?T0VFN3hpU3FDMEVNd2lYNHFWTUtjNG8vY1JPOXNHOVdnMndYNC91eWtKWStK?=
 =?utf-8?Q?FgB3UHk3uyf/mIRk=3D?=
X-Exchange-RoutingPolicyChecked: W6xl+wrfgBbXy07KTzxBc4Aod0csmABKTjg84I3uRwJiDUCtqEAtV2TvpeBMBgrx+HNihwYnflgZYMax6htU2Vy1vBaxKO95I0M+1hhUzirRnTeeafZX9jirOF1mPNyeG44lld/Mmhcf5S60hh12TME4YUjhESro33uS5gQDd/wCkco1nW6F0zL9dMbaA2FH5QOaEqWxCY0pRhWrQeoG9dlONvEz+CttofCXlLpTEI+K+XmLjDfyoD8cKMM3w5N+KxngiVaYseXjhelZ1SHADVPCoBE8zc93r9AQL3WPzRLui6w69QAYG07oqxINg8aULUBZ9ut/G9+iZ48j0uT1RQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d128498a-70a2-4094-0726-08df29715ad4
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:31:34.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCrxPW4cDA0D1YuPcrL9eBRySA392JmXH3hdF3J5hXLS8WeGshHSZVcHcL1HpyZ/mNGoOY7f9nHyw3D564iTYdy+/+zRIdRrk0/p3RFcqk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB213113
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 3 (4) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new non-READY (ERROR/RESETTING) branch of ice_ptp_release()
>   destroys the worker too early.
> - [Medium] The patch removes ice_ptp_release_tx_tracker() from
>   ice_ptp_prepare_for_reset() and puts nothing in its place.
> - [Medium] At this commit, when ice_ptp_init_work() fails, the code now
>   jumps to err_clean_pf.
> - [Medium] Now that the Tx tracker survives CORE/GLOBAL/EMP resets, its
>   per-index tstamps[idx].cached_tstamp and last_ll_ts_idx_read are never…
> 
> Pre-existing issues:
> - [Medium] The non-READY branch of ice_ptp_release() tears everything
>   down: kworker, clock, list_del via ice_ptp_cleanup_pf(), the Tx…
> - [Medium] At this commit, ice_ptp_flush_all_tx_tracker(),
>   ice_ptp_restart_all_phy() and ice_ptp_prepare_rebuild_sec() walk…
> - [Medium] On E825, ice_ptp_setup_pf() sets this port's bit in the
>   control PF's shared tx_refclks[phy][tx_clk] map.
> - [Medium] Neither the ice_ptp_init() error unwind (after
>   ice_ptp_reset_phy_timestamping() and ice_ptp_cfg_tx_interrupt()) nor…
> 
> --
> 
> ice: fix removal of PTP timestamp tracker during reset
> 
> This commit stops releasing the PTP Tx timestamp tracker in
> ice_ptp_prepare_for_reset(), so timestamping can resume after CORE, GLOBAL
> or EMP resets. It reorders ice_ptp_init() so the tracker is allocated
> before the port is added to the port list, and the tracker is released on
> error. ice_ptp_release() now cancels the kworker and releases the tracker
> when PTP is not in the READY state.
> 
> Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
> Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index eaec36ab6ae3f..fe21cee4f9dee 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2939,8 +2939,6 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>>  
>> -	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>> -
> 
> [Severity: Medium]
> 
> With this call removed, nothing clears tx->init or calls synchronize_irq()
> before a CORE, GLOBAL or EMP reset. Is that intended?
> 

Yes, this was intended.

> The Tx timestamp paths check only tx->init and tx->calibrating. They never
> check ptp->state. Suppose ice_ptp_rebuild() fails:
> 
> ice_ptp_rebuild()
>     err:
>         ptp->state = ICE_PTP_ERROR;
> 
> ice_rebuild() still calls ice_ptp_restore_timestamp_mode()
> unconditionally, and that re-enables the Tx timestamp interrupt. After
> that, ice_tstamp()->ice_ptp_request_ts() only checks:
> 
>     if (!ice_ptp_is_tx_tracker_up(tx)) {
> 
> So slots are still handed out (skb_get() plus SKBTX_IN_PROGRESS) against a
> PHC that isn't running. In the ERROR state cached_phc_jiffies is never
> refreshed, so ice_ptp_extend_40b_ts() would discard the result. Before
> this patch, these requests were refused and counted in
> tx_hwtstamp_skipped.
> 
> During the reset window itself, ice_ll_ts_intr() only checks tx->init:
> 
>     if (tx->init) {
>         ice_ptp_complete_tx_single_tstamp(tx);
> 
> The E810 path in ice_ptp_ts_irq() also checks ice_pf_state_is_nominal().
> Can the LL proxy registers now be accessed in the middle of a reset?
> 

I am not certain any of this actually results in a real issue. We could
add a check to prevent new timestamp requests while the state is
non-ready I suppose.. But I don't know if anything here actually fails.
The messaging could be improved. In practice I am unsure if the driver
actually *can* timestamp here since it would have stopped the traffic
queues during queisce before reset.

> The commit message doesn't mention this change in behaviour. Later patches
> in the series only add link_up and calibrating gating, so tx->init still
> stays set across the reset.
> 

Yes, tx->init stays valid, because we need to keep the tracker and
removing it was problematic. Checking the reset state may make sense but
I am not convinced this is a real visible problem.

> [Severity: Medium]
> 
> The tracker now survives the reset, so tstamps[idx].cached_tstamp and
> last_ll_ts_idx_read are no longer reset. The E810 PHY timestamp memory is
> still reset. Can the two get out of sync?
> 
> On rebuild, ice_ptp_rebuild_owner()->ice_ptp_flush_all_tx_tracker()->
> ice_ptp_flush_tx_tracker() calls ice_clear_phy_tstamp() for every in_use
> index, because tstamp_ready is all ones on E810.
> ice_clear_phy_tstamp_e810() then writes 0 to both halves:
> 
>     err = ice_write_phy_reg_e810(hw, lo_addr, 0);
>     ...
>     err = ice_write_phy_reg_e810(hw, hi_addr, 0);
> 
> E810 has no ready bitmap. It detects a new capture by checking raw_tstamp
> != cached_tstamp. After the reset, a reused index that hasn't captured yet
> reads 0, and 0 differs from the stale cached value.
> 
> In ice_ptp_process_tx_tstamp(), the missing VALID bit makes it drop the
> timestamp and release the slot. Because raw is 0, cached_tstamp isn't
> updated, so the later real capture could be credited to the next request
> that uses that index.
> 

This looks like a preexisting issue that we should clear the cached
value when writing the PHY registers for E810. This should be fixed, but
IMO should not block this series.

> ice_ptp_complete_tx_single_tstamp() has no VALID check:
> 
>     if (raw_tstamp == tx->tstamps[idx].cached_tstamp)
>         return;
> 
>     tx->tstamps[idx].cached_tstamp = raw_tstamp;
>     clear_bit(idx, tx->in_use);
> 
> It would then pass ice_ptp_extend_40b_ts(pf, 0) to skb_tstamp_tx().
> 

This also looks like a preexisting issue in the low latency path that
should have been checking valid bits.

> Before 7a25fe5cd5fb the tracker was reallocated with zeroed cached values,
> so software and hardware stayed in sync. This is still present at the end
> of the series.


Before this series, timestamping stopped permanently after a device reset.

> 
>>  	/* Disable periodic outputs */
>>  	ice_ptp_disable_all_perout(pf);
>>  
>> @@ -3347,13 +3345,13 @@ void ice_ptp_init(struct ice_pf *pf)
>>  		}
>>  	}
>>  
>> -	err = ice_ptp_setup_pf(pf);
>> +	err = ice_ptp_init_port(pf, &ptp->port);
>>  	if (err)
>> -		goto err_exit;
>> +		goto err_destroy_ps_lock;
>>  
>> -	err = ice_ptp_init_port(pf, &ptp->port);
>> +	err = ice_ptp_setup_pf(pf);
>>  	if (err)
>> -		goto err_clean_pf;
>> +		goto err_release_tx_tracker;
>>  
>>  	/* Start the PHY timestamping block */
>>  	ice_ptp_reset_phy_timestamping(pf);
> 
> [Severity: Medium]
> 
> This isn't a bug introduced by this patch, but neither the ice_ptp_init()
> error unwind nor the non-READY branch of ice_ptp_release() puts the
> hardware back into a quiet state.
> 

True. These are *error cleanup* flows which are just trying to do their
best to cleanup and avoid leaks.

> ice_ptp_reset_phy_timestamping() and ice_ptp_cfg_tx_interrupt() run before
> ice_ptp_init_work(). If ice_ptp_init_work() then fails, the unwind never
> calls ice_ptp_disable_timestamp_mode(), ice_ptp_port_phy_stop() or the
> perout/extts disables.
> 
> Can OICR TSYN_TX, PHY timestamping and the SDP outputs stay armed after the
> software state has been torn down?

Presumably yes if you fail at exactly the right way. But the software
really has no way to know which parts would need to be torn down, and
whether it even has access. Should we balloon the error handling logic
to try and detect and cleanup every possible state here? I don't think
thats helpful.

> 
> [ ... ]
> 
>> @@ -3365,14 +3363,17 @@ void ice_ptp_init(struct ice_pf *pf)
>>  
>>  	err = ice_ptp_init_work(pf, ptp);
>>  	if (err)
>> -		goto err_exit;
>> +		goto err_clean_pf;
> 
> [Severity: Medium]
> 
> When ice_ptp_init_work() fails, this path now frees the Tx tracker and
> destroys ps_lock. However, ptp->state was set just above:
> 
>     ptp->state = ICE_PTP_READY;
> 
>     err = ice_ptp_init_work(pf, ptp);
>     if (err)
>         goto err_clean_pf;
> 
> The PHC is also still registered at this point. Could ice_ptp_link_change(),
> ice_ptp_queue_work() or the PHC callbacks touch the freed tracker or the
> destroyed mutex in this window? One example is
> ice_ptp_reset_cached_phctime()->ice_ptp_mark_tx_tracker_stale().
> 
> The NULL kworker exposure while READY was already there before. Later in
> the series, ice_ptp_init() creates the kworker earlier and sets
> ICE_PTP_READY only after ice_ptp_init_work() succeeds, which appears to
> close this. At this commit the window is still open.
> 

This has been incredibly frustrating, as every time I change the order
here I end up with some other complaint about teardown order :\

We should be cleaning up the PTP clock first, but this is complicated by
the fact that each PF unloads independently and only the clock owner PF
actually has a clock. This outline does imply that the paths could
access the kworker while the port is still in the list, so ya I guess
this really should be afterwards.

The worker thread does appear to check the PTP state so I guess
reordering it would be safe.

>>  
>>  	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
>>  	return;
>>  
>>  err_clean_pf:
>> -	mutex_destroy(&ptp->port.ps_lock);
>>  	ice_ptp_cleanup_pf(pf);
> 
> [Severity: Medium]
> 
> This is a pre-existing issue, but on E825 ice_ptp_setup_pf() sets this
> port's bit in the control PF's shared map:
> 
>     set_bit(port_num,
>             &ctrl_ptp->tx_refclks[phy][pf->ptp.port.tx_clk]);
> 
> ice_ptp_cleanup_pf() only does list_del() and never clears that bit. After
> this error path, or after an unbind, would ice_txclk_any_port_uses() still
> count this port as a user of the reference clock?
> 

This looks like an issue for the developer of the refclk code to fix.

>> +err_release_tx_tracker:
>> +	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>> +err_destroy_ps_lock:
>> +	mutex_destroy(&ptp->port.ps_lock);
>>  err_exit:
> 
> [ ... ]
> 
>> @@ -3399,12 +3400,20 @@ void ice_ptp_release(struct ice_pf *pf)
>>  		return;
>>  
>>  	if (pf->ptp.state != ICE_PTP_READY) {
>> -		mutex_destroy(&pf->ptp.port.ps_lock);
>> -		ice_ptp_cleanup_pf(pf);
>> +		if (pf->ptp.kworker) {
>> +			kthread_cancel_delayed_work_sync(&pf->ptp.work);
>> +			if (pf->hw.mac_type == ICE_MAC_GENERIC)
>> +				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
>> +			kthread_destroy_worker(pf->ptp.kworker);
>> +			pf->ptp.kworker = NULL;
>> +		}
> 
> [Severity: High]
> 
> The worker is destroyed here and pf->ptp.kworker is set to NULL. The PHC is
> only unregistered further down, and the port stays on
> adapter->ports.ports until ice_ptp_cleanup_pf() runs. Can anything still
> reach this worker in between?
> 
> On ICE_MAC_GENERIC, ice_ptp_settime64() calls ice_ptp_restart_all_phy()
> without checking ptp->state. ice_ptp_adjtime() does the same through its
> non-atomic path. ice_ptp_restart_all_phy() walks the list without
> ports.lock:
> 
>     list_for_each(entry, &pf->adapter->ports.ports) {
>         ...
>         if (port->link_up)
>             ice_ptp_port_phy_restart(port);
>     }
> 
> ice_ptp_port_phy_restart() then does:
> 
>     case ICE_MAC_GENERIC:
>         kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
>         ...
>         kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>                                    0);
> 
> Here pf is the releasing PF. That covers the releasing PF's own port, and
> also its port when it is a peer and the owner PF is the one calling
> settime.
> 
> ice_ptp_reset_cached_phctime() also queues on pf->ptp.kworker when
> ICE_CFG_BUSY is set, with no NULL or state check.
> 
> Before this patch the non-READY branch leaked the worker rather than
> freeing it, so this NULL dereference or use-after-free of the
> kthread_worker looks new. It can be hit if a PF in ERROR or RESETTING
> state is unbound while userspace calls clock_settime() on the owner PHC.
> 
> Could the clock be unregistered and the port removed from the list before
> the worker is destroyed? The commit message already describes that
> ordering for ps_lock. The ordering here is unchanged at the end of the
> series.

Yea, I guess we need to do the cleanup first and then teardown the
kworkers.. This has been quite frustrating because I believe I got other
complaints about order when trying to do that way before :\ Hopefully we
can find something that works...

> 
>>  		if (pf->ptp.clock) {
>>  			ptp_clock_unregister(pf->ptp.clock);
>>  			pf->ptp.clock = NULL;
>>  		}
>> +		ice_ptp_cleanup_pf(pf);
>> +		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> 
> [Severity: Medium]
> 
> This is a pre-existing issue, but three functions walk
> adapter->ports.ports without ports.lock: ice_ptp_flush_all_tx_tracker(),
> ice_ptp_restart_all_phy() and ice_ptp_prepare_rebuild_sec(). For example:
> 
>     list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
>         ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
> 
> Meanwhile ice_ptp_cleanup_pf() unlinks the port under the lock, and
> ice_ptp_release_tx_tracker() then frees the tracker. Trackers now stay
> allocated across CORE/GLOBAL resets, so the owner's rebuild-time flush
> works on live peer trackers. Can one of these walkers race with this
> teardown?
> 
> A later patch in this series, "ice: use reference counting and SRCU for
> PTP port access", converts these walkers to SRCU with kref and appears to
> close this race.

Yes. I tried to have that patch first but it got far too many complaints
about *this* issue, so I re-ordered the series.

> 
>> +		mutex_destroy(&pf->ptp.port.ps_lock);
>>  		return;
>>  	}
> 
> [Severity: Medium]
> 
> This isn't a bug introduced by this patch, but this branch tears
> everything down and returns without setting pf->ptp.state to
> ICE_PTP_UNINIT. If ice_ptp_release() runs again before ice_ptp_init()
> resets the state, would ice_ptp_cleanup_pf() call list_del() on a node
> that already holds LIST_POISON pointers?
> 

Another on the pile of possible pre-existing issues... :D

> One possible sequence:
> 
> 1. devlink reinit_down runs while PTP is in ERROR or RESETTING, which goes
>    through ice_unload()->ice_ptp_release().
> 2. reinit_up fails before ice_load().
> 3. ice_remove()->ice_unload()->ice_deinit_features()->ice_ptp_release()
>    runs again.
> 
> The old branch had the same list_del() without a state change, and the end
> of the series still doesn't set ICE_PTP_UNINIT here.
> 

Problem is that I am not sure if setting to UNINIT is totally correct
here :\ Of course the original design/logic here was that this is part
of driver remove and not something that would be re-triggered such as
via devlink.
