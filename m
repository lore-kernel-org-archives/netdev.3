Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E313E02A
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587022; cv=fail; b=OpK1+jizfcK3wkht+g1cYVQOmq2Sz1I6X5PKMwURrAHKSW8LrQFbkVlXnfYhfL6TxNdZsECjR6b8pDFcDdIxBGwFEqHoYtsv8afKX2gfNxfLK8kE1QYW16XlU/eN/A5ge/KMI2WTT0dMTWga5iL9olZb6tvi4z1Q8SleHIlc3zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587022; c=relaxed/simple;
	bh=60ZSZJkW3QE2gidBxOpTMQdzQYojFJRPzgBhwdaj5fM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/V5MMt3ddgmdjPYr6t9AcQiwLunxWTC84IRpn9cOP4P/BC1G5r/ABeNJOMbf/3WQrB4UTymI3pfk+eZ1cNnWtWO0I+w5btNZbkOOYPv68PntQIQuhAtstfT4Oxk4fRXhe1YB46paq3P6MI0ff8tueZiF5tUG4Ahuto2HUUeFdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIAQWGLu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIAQWGLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784587020; x=1816123020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=60ZSZJkW3QE2gidBxOpTMQdzQYojFJRPzgBhwdaj5fM=;
  b=MIAQWGLuQMRvQoVlpjesETAs5g7+Xt+c9sBILLmcAIiRLIuGOtHflUjD
   PARbw8K8rpSRPtR9AcHp3Y+TOulk7/2B1wkzfxCwUgfbb/Y4NnYgsmThA
   RfkfTmi3CGtUCmDPcEebBHnmnUQX76LV7J3d9wKWxpwxil8oxcISeiDPf
   7nk9b8P0dElTajlwglt9y6i7Nfn3oq8YcHhk8GoUgr5j/ZK6wQiJS135T
   Y01L+CyY++qkCxjq1lLV8efyl5DlMkT+gIRlLPWCLHxIiiraMXDprFjTd
   XTJeAffde9lR2Pl7zaaMgk/qSCf0+Apus9dDJY9z4d587UnqO1FWSsBCD
   w==;
X-CSE-ConnectionGUID: googaEE2Swerbm0Z+f0LrA==
X-CSE-MsgGUID: dBEQZM33QKSsSEUPI21xhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87718850"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87718850"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:36:59 -0700
X-CSE-ConnectionGUID: RVge/hU+QaKlBx8eWVNWTA==
X-CSE-MsgGUID: LEzzPmQMRqmLA3sNmsscCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254174027"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:36:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:36:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 15:36:58 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKOGTCZn9lUON1bC3w77I+YNDRSJeJCSrtEMMY+kdJYNNqKz+3GRd+39T9v/Wpj4V1KaBNkRqKzRenlkW+O6v9mqCwzEgLzDwb0fSj7cskk2NW+2XBsp9KnVXKV1oJE4L6Y6a/0kaFm8XCD+HQEtW0eWp3bt6/4zZ1MOCPj5tEn3addI2R38LZHf03hiWJQ5k+aqQKs4f0s12AVaG23KwiAMHkJ3v3Vdpn+zt4K0iBwzMRB+Zws3Z7YyhhiKfT1ZXT6sLBpBRSxnsX2WHwy0PKoCbRfS+P7fqLtx3v5PRjP4aZx+GN/h/2JwAWkK4k5RRE4aXSEEYtke8oAQvfeq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj0qWvfkiB4HLOIsza3MrXXMxpbqNvbVQLOWgQKAwx0=;
 b=FjthkDGLHsLC7OKcOS35doYTsDZc8rnDpVLGFKzE65nRMOo3XHZo0A/eqzwcAdnNfEM/ojaWn88dx0ntc5bTXIqEPzBRhVz7XtP226Lo0xFHu+OAKZ2X+Z8AB/aldBLRZlfsY/fJoNIwdDxRf0ku+1aqHb5iFMQmjm6G6AY/y6yjega7hRXaGtoZlG8uyxf3t6PQtFQCVF0gPjRnGxmKUysyK2Zslt1jdzXfgTnlUB+/wgDEkSo+ka976zJN9kDUuGRWWugZhL/CSsFVR6TNZKZ/MYCYWqrrh7R8nVLarc1RP2Y73PJG7ZyklaZYAYnmcSWsFPkA0PEiYrYnk0jU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:36:55 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:36:55 +0000
Message-ID: <225f6e96-1bef-4df0-9e56-ba9027243f84@intel.com>
Date: Mon, 20 Jul 2026 15:36:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/3] net: airoha: rename airoha_priv_flags to
 airoha_dev_flags
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-1-9c15d8b71a56@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-1-9c15d8b71a56@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|BL3PR11MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: a7964f53-df46-44d9-feb1-08dee6af66e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AYD1y4lERh6Uj2xnvM13ggmT8OfR1wYzDR/zNrUeqEVnJzGhKUGI1C8y7PdayKT53YfTdVnh3Wl6AAO91rHJDRyzLQDNJe9ViEuXBNazxKt06FIH0qE3eF4uZ/ua/dTfmQyL73J+fCc8iI3HAuCxda1deunZIW2cEzG+V1wrNFoxLPWp57l0pH1PbYzKhrdAcnEG87Mkq8X7pvXDxHdFT9KzE3OV9X3bygp57lGdDmYvQgKF6ab3bdkLKYEaEtkTJFN39RplOGn/npmGAK/d8hUU8tLzUv5xISBWF1USevoLlXN1zYk0SnXcGObZfBZUVoRkU6qRY7C6x2+jpNk+RmAiHngQ2S3LH0T27WtRLSad9gzoznxwfK6WLs56zCNSqperW3PueiwkvsevN758BykhTogZagrTNRi9ycw7biKdMpEslZMkkEGNOF1Qc5/+VIbVx/mySs2p6DkXg6QLaXldKJz27fNhok+aV5mCTFOUxMd6TfCyskquI1O0hTRfi/xh4DZpOg/A3SXpYGkIYKMR9eL2JkHpML/RN2m6SfkbBPY7mkhDbpu/QscV5On2TNBHqdWlHGpYB1tJyin5vlOJsumq2CYV8Xl+uU+KtZgutqAxy798iTLJGvQ29USY8FKFS0AUsasGL7yMIhuANv1H6T1oBfB2ogRYo+DJnOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lwTGV4dXROVW5VSG1tVGFLNVUwbm1MczkrZ2VnNlFLNDVhUEdvcFEwYTZX?=
 =?utf-8?B?NEM3SnMxYlFRY05xWWN3aVY4Qyt5UGZrNkJXa3k4VVRKb1owWnlHazVSSWM2?=
 =?utf-8?B?YnhHaEJOZjV4R2VlTlFJOTFSeEZzcVd3Wjl4cWNVUXhXMWtBa0JBV0RaZjQy?=
 =?utf-8?B?MkRYNVhDbzN3YVVzZ1VzREVINVdzTDd2SEo0bmMwc3VsdnpGY0IvVUU1MGh6?=
 =?utf-8?B?ZG1tWWZMRndxb2xPa3BnRElGMm1ZSmUyYXdCaXBFRXd3TjAzclBoYlp6L3Y3?=
 =?utf-8?B?WUFSN0FsdDJiaWlONzJIQ3Y0S0gzL3Z1eTliSHNPZmhOOG5SQ0gxRDFDbWhI?=
 =?utf-8?B?eVl4WGRsZDBkVHpJdlozTlh1T1B5ajBpaUloaHRibUlVNzZmMFVGTTd6bTVO?=
 =?utf-8?B?ZHlJTk8xUytjT0dpT2l2ZlNObHVzcUFIbzkyUmd2bHVSU3NObWVWNitodGpZ?=
 =?utf-8?B?Y1ZINlE0UGliSGlHWE9MOEZLNjJILzV1aW9rcVhuMGl6ekt5ZjJaYTQvc3Bk?=
 =?utf-8?B?eWtweXlyVk9QMmpSTUxXL0FZcGZ1dytGcDByaENRMnBzLzdhVlpMWkN0b0pB?=
 =?utf-8?B?YXl4amRLN2NaY043aXlMTndXTSs1cDlVZm8vUnQrNHd2Y3krRmRSYVQ0Nml1?=
 =?utf-8?B?cUExN3VodlgxZlMyejZjeVdEenFRSGtIWjdDWTZIKzFyMUQ5SVNPMmZsMjVp?=
 =?utf-8?B?bmJ5aUYzcUxER3M2RjZBaVh6UDBnTmY5dlVUakpndnRSQ0Rrd0NQMnh4dkxC?=
 =?utf-8?B?RkZQMlloR041ZnZTTDBSNkhHUTBtSlJmUldMTHdKaWRIZUUxaWZYT2Y5UFBS?=
 =?utf-8?B?R0dmbFVoWlp2cndycUc0dWFRM1JlTGpOalBIeHpMQmxDa3NXcnZFR0s5RWsz?=
 =?utf-8?B?SUEyeEU3YlFqaTVFSGV3RFA3OVRRam9FeXdvV3Z3OEZYbzJCQVJVRjF0b2VY?=
 =?utf-8?B?NmZVRm1qRjNXMDFINkE5Z3hVNlRYd2VlODYxNEtkeGQ4N1lnTXIva0IyOFhK?=
 =?utf-8?B?MU9xSVhwbnNBK0V3S2lOaUkzaFhnbmM4QjNQdFoycGN0bGdjZ3BNMWFxMXQ3?=
 =?utf-8?B?Z09penRvSE5HTFpnYjQxdStpYTRaQ2c5ZDJaaHlWU1dMWjliUlR4Z0hlMGJx?=
 =?utf-8?B?OXczWUhPeHRSRlZtNTJnbTdxWFhpVVRWOXo1N3dMR0VqcmlRZEp1NHBZVE9L?=
 =?utf-8?B?YmFrQ2dCUkpsYXRnZGNvU0xUSUNvdkR4NGJmU3J6Q3YrZ012UkN3bUQzQm94?=
 =?utf-8?B?bWVLZHpoYmQyZ3JGcVhqR2dQZUpJWVA5TE5ja2NyT2ZzTDJrSEF3dGh2U2ps?=
 =?utf-8?B?YzBRWmlXQ3JsYVgrRWplVmZNSDZRYURDNnhQYXFpS3JDa0NKUXB5RkV2Wndt?=
 =?utf-8?B?TjFEd0d3aDFld0RFbFByV1FqcnlEZDAxbmxLZVhyV3h2cENCSXppOUxEU0lu?=
 =?utf-8?B?enJCR0VnaXNNWFd5NkdrcCtVNi9RVms3N3BIaHllUklVb2g3ck9MZ0dPeUdu?=
 =?utf-8?B?TGs0QVc0WkNOQnNBc2RCNkFXTTNmZ29taDI0eVhkOUhSZWxKWmpLZHVSRGhl?=
 =?utf-8?B?Q2FvWFZaajdjYmpkZURwSlE1RUdqUzNOeStKOEFVRldXVE1xdUVqa1FZbVNq?=
 =?utf-8?B?OHVGRHJkcEdva2VOUjN4WTR0R0Y4TldIQnJ3RVczYnZoY3dQUnhLZTRVYlF5?=
 =?utf-8?B?NHprTVMyM1B0emNFREd4NGxZeHgyM05rbWJWb2ZwNUp4S2lFT1R6N0ZBS1gw?=
 =?utf-8?B?cXZFeWpPSHMxTVNXYXFlTENtN2taVlViZ2R6OGQrOE8xaHlaWnh1V0REL0d2?=
 =?utf-8?B?UXM0cENjL2E0UCtYWGExNUpTUnNaWnF1V3ROOVNyV1V2S0E0dkdSZ29nTlZU?=
 =?utf-8?B?U3lwUm1oRTdCNGdQMzdNSEEzZWNLYU8xN1F5dGRqMXEvTXF1UmRTNEprektF?=
 =?utf-8?B?bm1tbGF6MDZDdzJZcmx3Q3ZFRGpocS9wbGhnaHpiUDNZSXR0VTIycnl5OFFt?=
 =?utf-8?B?K0ZBcUFzY3ZlRHltbHlVTlBYS1JpK05Id29jMmpKN2NjOUFHR1VuOFR0TVlR?=
 =?utf-8?B?bGFET0RaUENyU2syQk41aW5tbXc4Z09iZUlETEJpUUJEaHhMSFBPcTQ1RWwy?=
 =?utf-8?B?UzJqWXZRazFLWmtTVU5IVVNOQ2hPVFl2TnNMNjhFV2RMR01SSE14M0UzM1dw?=
 =?utf-8?B?MnptZjZPazhhZVBhNDhONHZ5dWFtSTVsckdOWHhpaVpBOTlkdHZIRUhrM0dK?=
 =?utf-8?B?N29KVVBUZ2xwRm9nN2Jvb2p6cjJNMzlaQ1QrK2N1WXJXb3JJSXZ6azQwQmU4?=
 =?utf-8?B?RmR0TkliY0QrSjVRQ2RsMHN1TkQwNGE1ZXJwaHF5V3hBaVhXY0tsZz09?=
X-Exchange-RoutingPolicyChecked: Xnze7pXyJdMU+PAGo4Me0OqujhOogRCrm4scNW8jqZdrHBF778WiRT+svduFaYmr0vuLwhx+iTmsTVnIUkrur5EstUKFfDvk59ns0uZmnwZeJMj4ngbHVCqN0e88osdG5SD6H39HwS1h/eMPjHZltqts4xsxAJQlrXxWBBFtW82k89v1XukA3L8vl8NNZByG0zTx2tRf5YJmJjm3pfKQullWy9tVwppu68l1byQxepqPYgXb8wU3ypiBbxm3tGD++UWPd9Fiz7PcMoXMmOSeoBY4yfPL9wMo+h3srKj/vF74UBObxhcGZMS0D10cqqK1MJrrVL1l9W0o6XVDnfVffA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7964f53-df46-44d9-feb1-08dee6af66e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 22:36:55.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMfIwK0oe5m1YjGQ2Q8bmvzUoRi5KMaV0ymtCJHyX6KsL5K3KHlD5bWDlQg27Wdm84+TEAUUa9OI4ytm02tiH/XNBehSLPKz0YC/0VZAlN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

On 7/20/2026 3:03 PM, Lorenzo Bianconi wrote:
> Rename the airoha_priv_flags enum to airoha_dev_flags and the
> AIROHA_PRIV_F_WAN flag to AIROHA_DEV_F_WAN. The "priv_flags" naming
> dates back to an earlier design that used ethtool private flags; since
> this series switched to tc qdisc offload for LAN/WAN configuration,
> align the naming to reflect that these are per-device flags rather than
> ethtool private flags. No functional change.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
