Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CB5372E5
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927818; cv=fail; b=PD8/pTeWSfE4MWjHkpMkGTPvmUupVZxBISc7T3aYTuuP1wPYVrkk84soGH0bMfTPkWj3LNqh1DjoOmMKZ8NKdSshC1JseGggbgIcKAxtDIBtAN4ChtUlOD+mFKfwAvE8QZuYyeUNexpxZe67ZdIUQirKjTpUkj3UHlZ/7SitpeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927818; c=relaxed/simple;
	bh=jRokwnEqZtfzBR0mlixs24J6naPz9GCPP3ncE2z71IM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZGdey+2iHGMJ556jK2o7CuDpTHZYPe1L1nEOligHvypdsaKck2z+ZCVBwEEwiT+7nfLmsYi31icIZ45vVG0wT8BSTzejnu6VXwbvGRh1lCrek0echqGMyiig7CXegtSfEIsE399fOETC+S4UCPe8mlMyNvBF5KKKvUiZzgoti4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=armLulLs; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="armLulLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791927816; x=1823463816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jRokwnEqZtfzBR0mlixs24J6naPz9GCPP3ncE2z71IM=;
  b=armLulLsj5SF7EuRK5ShN3W9oq1bAu2I7r1QbKDerCz3ZrZEsgmi+Zb6
   U2RPsVB9dC8S9vmB4+4iS4fvvD8yXZyrYVMD4NvoYaEU4GuAs5gne2LPG
   /gjlw72wd2k2tpJvZ65y9ck/AhGKdBpH+OkBFrvSpS9lfMJYLc3YcdhMA
   +bwvrRGxk7FhyTTuW5Ai+LUWIY5mLCo5iukzCWj98kVuvAmaYiV+lih3T
   koYzSqk4XOZbqV/5sH0+nS5J7HhRAsOMsUKTDcgDkEV/oU4eDGgFv33hy
   kO6WEsLYgwKfqZ9fcY8dk3a3qaFERCZPWT2FiUgSlzKA23uEVLuDb8HTM
   g==;
X-CSE-ConnectionGUID: XoD0hPlBSButwY7AHr+KdQ==
X-CSE-MsgGUID: 69DJpaUaTUaXZeL4ZZVFTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="674879"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="674879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:43:35 -0700
X-CSE-ConnectionGUID: EBgj+9RwSe2SefKdWWNZAg==
X-CSE-MsgGUID: XkWS0yLDRpSBVObnxkRaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1342439"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:43:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:43:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 14:43:34 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we2ojp8upbJn5Y2lh6ZY/JFyQPBV28yNvVP/YpmPC36w62AgCrGV3nJyaeSu08JtUEzaXjAHaL3U2V23Ie5B0PbmRShbY+KPRav2VjmHv1NAP96Q9gxKAQXcFUzdRl3jLa9JRQ5Xe8F7HslSj/JS2JfAX9zjaqf4PxEXYgi558ZVs1GLZEru9KzEWhBnz7b8z0e5pUBgx3/kIuCtoYr25uCI1MLDV5LXpxtC3J8ztl+UgC2ICVSD7+3PcMFQ75zqZtlbCu3sWMZBIRsayQIH3fKchZ5OXYuOFayszjG5YdY1BwOj2Dr2T1hK+bPVehz19U3mpdxxNK97T8Ul1vjn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FthMCatG4XRx96yJIXcReq6p0VqptSS8go7Uw95kzxA=;
 b=ZQe7cVTd1Y647OpIsUlk60ixSBz6++Q+DaVqQbBz0o4tWtCzzWNoTRAoTS1dsWHfslOaiZ/LGhkEG3EVx16rB3ran0NfJu2BbAcITaLKVUbdadmdrGxpQ+evo3bvdGWxsVXOqZ+utTvZ8Qvk5ldKpZUyYbhREpbMW4dtAM22PYHOxT4SdKFYBS3XdWoXLhfcRmseEDujdEcRdHN3KXMYwF6YfaPCk8AbrGOCXp6sF44lrB53N+YTF3Tocp9p3zEODPtVLmQe59NawQ7ZjiS47ePRGD525PX34tLKEpMF2bczP779rlAiotJBy3Umv0Ku3i0YD2NlSqYiZB5yD3Pljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 21:43:22 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 21:43:22 +0000
Message-ID: <5089c30e-b9a0-4fc1-abec-e3dcb6157f4c@intel.com>
Date: Tue, 13 Oct 2026 14:43:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 03/15] ice: fix PHY port restart serialization
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-4-anthony.l.nguyen@intel.com>
 <179184692111.434549.8926605466860924920@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184692111.434549.8926605466860924920@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5847346c-abd1-4c5a-8e6a-08df297300bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|18002099003|10067099003|11063799006|261009223027099003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 3QRJ2h0GyILGDa24sqyx51VVqxPFJRfaepsWSvmkL4I93ZLvI8wIkKp59qKXPZkf4jTvkPvwT1cf123+zPvTF9Ric+AeVmLZQPTS1cANlvUlOp4Vz37MBbQkwwnyiS7yOOZykNMpYOJDSU5z2iSVULjbrw2t/M6/ccZBStH5/ZSOpfvi9UMrObkoQXgB/3I1kxdrxFSTgWemggxdADAqUY4PkOj38kiBydNLWEhJ/V2okpPqoAulSPUIE81PHOfaOD16P7E8ephK9lDPeDI4d60qPwm5ALJW3OBHGd7OjzJdS764YhUfC+IeVMZnbT5jvq6nSYVYnl3bcH9dMcFBCGMIEZxrOzIPRB5sOJ3rtXNA0923uN+d0ZZbMqyw3AVNhYqBw2wkPPhsnZNUJdiPDgQ6jSUCKowDYudu7jh1mrpBb5g2UZH8dtzT3xkMIpaBoZLD+nYcJYXfCZyOKPOYhUWbeuTsVtQD2icZSbZAUuVa3ocJ2Eeg3q2ZbLV3Q/ZpuufQFLC+JJ+P7l/naDlLubpAggtOV7guNC9SqhZNCsikQNU2wps9r2D6d9EOAd86V2kLdHg8E0q/8Xbuj3v6q0UJuwYBwvHhtq3CLxd43hkw7GEK/6xoNcLDkQeK/BO5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xhK1dPSE1oRnR5amx3V0tWUTJoclNLMVN1eFZ1cmp6T2pIbS9JZVNLQkxa?=
 =?utf-8?B?dUJaam5LVGhUMjRzODR0M3B5Yitnby9VNlRXOHRKZ1AwdytrRS9DQUZ5dTI1?=
 =?utf-8?B?YU94UHNPMUJYTFpqSVZCeVRYdDUwMHFicjZDU0c0c0t3ajBLZis0VkdkVHJM?=
 =?utf-8?B?azB3Wnd6ZlpqcXpZL2VZdXNBKy9kc2RyQUc1dHh1NjNJNUZ1L3V1REJFQmRh?=
 =?utf-8?B?dFhFVnMrTFZLR3hGMEM1eGNVbVRSNUtleFgvRWhyMmJQdzZ4Q1dCMVVncG5X?=
 =?utf-8?B?MHJWWENmWWlhUHpWWmpwSjlxS2NqaXpHSmltM2tjRVZZOWJRazYxNk9TelBU?=
 =?utf-8?B?QlRTeDJSakU0NHptZWJVaG0rSHc3bjBhRWYyWlhpcFNpMURQakFYY2FPSGMz?=
 =?utf-8?B?YWlRc1JEbDVYa1RRWTlpOHpWYXIzaTBmOWxaSWxTeWFUTXZKdGhuaUJpVXRD?=
 =?utf-8?B?UEc2R3F2eWhlKy81aWZxbXFMd0xxeTZqdy9hUHJlVHJtbjM5MzlpWlpFMStZ?=
 =?utf-8?B?UG5CR2hwaHRuNmxoMHF0ZGswUFZpeVI2NXBjREpMS2E3RFlIZWF3SEZ5ZFI2?=
 =?utf-8?B?L2NOMTZRMG83VUoxdkozV21oMFBBTkFDUU1jNTFpY2hiRElPVXl2ZTMyemFn?=
 =?utf-8?B?MjBFaDg5VDBQSkRuVk00VWRZbCtUK2dFQ0xMZE44aUt6UUUzTXg1Uy9GeS91?=
 =?utf-8?B?UkVEWXlkdURCSUVOYzdERjNyd3gzT1FRNzdLK2F4M2RSSXpNVnZBSEVZM1Z3?=
 =?utf-8?B?UXBwY3hLWmd3emJaRmc5bVlqTHFQOXRiSTBmNDFTRDV2aEd3MU56enVWMUJz?=
 =?utf-8?B?R1d3dUJVZ3R1QXhEVWVPVE13bVQxUFBCd0dlK0dVV2pBVUIvbkEyYkg3WThK?=
 =?utf-8?B?d1pvVDB4eklxKzkyWHd1cW5IenhlNm9XNnZhSWdkTk8yVENjT24wQ243dHdB?=
 =?utf-8?B?R2ErZEIrcWFYNGEvZSs0RzQ2ejBSN0tObmJCSWZsOURrNHVVSHJDR1dlU3Fw?=
 =?utf-8?B?VDBGWDZXc2tNNmljSnNJOHd3V1RJUXlWNm5TbVFkWStnT3V1TWE2bWRDanFX?=
 =?utf-8?B?TEY3QURiMjhOWHpQY25KUXBaWU5lQTE3MUMyYUNOa2F0bDJhSVBvVi9qeXh6?=
 =?utf-8?B?RGdjWThaRW51RXdOVTBVbTE4Z3hjUW1Jd1Q5cTFIdkdkYUh5YTIzT2o5ZnZ5?=
 =?utf-8?B?QTVaZkcvZ0ZpTExYUEkvSFo2SVh6T2JVTXJHVkthbzhJUWlUWWlyVlI2VDYr?=
 =?utf-8?B?TDlkYzZyU2VlNDdZODVrZlp2SHJUcEovL0c1Z2RBSjRuZGFWOU5GR2hMQ0gx?=
 =?utf-8?B?NDNTMWRGa2tpMDBvSWhRTVVKMk5uVW00NjRTUFBKQktWTlJJMHpxc3A0RE54?=
 =?utf-8?B?bjFBSDZDVHU3M1VpUmpFRHJ3NjBBTElwSjdzTEFlN3hrN2MzTXkreEZQcWtK?=
 =?utf-8?B?ZW9ESjRhbXdiV2pOVy9HSmEzd0Q3Wm5nMFNWSitFRWJxS0hPY3RFVWZjbVhU?=
 =?utf-8?B?WExxY0Z6VTByN3lPRkRkeHl3Nm92T05yZlJLU3FUcGIySUUrbTlQV0t5MGhU?=
 =?utf-8?B?VDhWdTAxK3ZRSkorZkRKWFluMlRnQVRZQmhDWElUQkxONFBEMkhsdndMbWo0?=
 =?utf-8?B?Q2FMcm5EeTR6Y3lzamdMVmI1MkM4TjJqZXdvMzNYL1AzMS9QKzdJVDdZaExP?=
 =?utf-8?B?bVVNNDJST0J0cEpCaFlJMzN3ZkRpTVlBSUtnM0dIS0FoNXZaK3lUbnN1SnF5?=
 =?utf-8?B?VTVJU1RpSjJjSW9XcE0xUTJHTXdpODdpSkszbUJVbjd1eGdrSE5iOXBJNmpM?=
 =?utf-8?B?cHlhWThBNmtaZEYyVmJ3TTQ5ZitidFl0enE4N0RxbjN5ZjlhMFlDY0lNUnFn?=
 =?utf-8?B?RFdLdXZFK3Vva2xIRlo0RENPK0tyMDl6ZHV4Q3VRRHpCMkt1VmQ5MlFLRkJa?=
 =?utf-8?B?N0tMdXg5eGs0L0JNQ0NhM1pxMXZjN3FFSk03UlNzNE9iVEdIZlg1U1hsWXVI?=
 =?utf-8?B?RC9qNUNVTGtuOGIyTEE5WU5yWC9FVm1PVk1TRkVMN0dad3c1YXF2Zk5OSmN6?=
 =?utf-8?B?T1RqYUduVG9qUTlTNWJWcDA0SGcvZkJLdnNwVVVlcFFwR2kvc3NlUElkQmFK?=
 =?utf-8?B?dW9jVVlNaXdTT0dwYjlocytKWGNSV1R5aG1hSEJuWVpXRVozbGg5eUtKY1FZ?=
 =?utf-8?B?WENkU0RrZitpY21DNDlsdnpwS0pZR00rYzJ6elFmbUtBU0Z4YlRBYjQvaCts?=
 =?utf-8?B?cDlxTGw0aXIzVElTNE1lUnpCRlpnNjB6WTM3MG1JZTh6bjlPdTM5dUNKcTNu?=
 =?utf-8?B?S1hacmxHcGU2aC9jQnJoOGhZZDNFMTZGRkpmOUZQcGxHTk9QZWZqaWoyZ3hu?=
 =?utf-8?Q?tfwjKHnzhB4szvsQ=3D?=
X-Exchange-RoutingPolicyChecked: rLKo4ruYEMbsR2Yl+eQND6z3o9+CkRe1TUoOcaiMGwAwg7fsrJgMdQ5WhboudoXUVbBEYR7KUpqnSJNcivh6mI85UXteqq9345Ym/LOdiM5wUQUaCDMyS1T61noHmbmtNBN50E/zNo9nV7oHd6BJiFNqrGYRV6gt96VtoUhT1dlC071jGDsEyzcgC3MdyH4gZnY23dh7e5grXzR8uKzJbIt+c/zjDMnjIG0pxTE4acCu3SqMXdlHVVeVQ3t/BzDCiHPhx1MbnT0s39yYmRqANEwdhYbkMpcuKJ0v+Q9pUHNzG0cQhI9+jL8RO5C91RuaYoIZCbJx9FQWEaBQxKDfCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5847346c-abd1-4c5a-8e6a-08df297300bc
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:43:22.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHSRuFjNIINTDQngMuETWcdqEhZxHbeW4leZNjpos4FA/QUOYychcA2E6yssblxmOrDSi/xmxWT852f28GOnApZwmFDAeUANryU5Fxb0emg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] net: ice: UAF/NULL deref of PTP kworker on error path during PHY
>   restart
> 
> Pre-existing issues:
> - [High] On E822 (ICE_MAC_GENERIC), ice_ptp_port_phy_restart() can call
>   kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0)…
> - [High] ice_ptp_link_change() checks `pf->ptp.state != ICE_PTP_READY`
>   (line 1308) before it takes adapter->ps_lock (line 1313), and does not…
> 
> --
> 
> ice: fix PHY port restart serialization
> 
> This commit replaces the per-port ps_lock with one mutex for the whole
> adapter. The mutex is taken in ice_ptp_restart_all_phy(),
> ice_ptp_link_change(), ice_ptp_init() and ice_ptp_release(), and the
> stop/restart helpers now assert that it is held. The cached link_up field
> is now written in the same critical section as the PHY restart.
> 
> Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 94a66e9d8c05d..adc5308baefce 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -1310,12 +1310,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  
>>  	ptp_port = &pf->ptp.port;
>>  
>> -	/* Update cached link status for this port immediately */
>> +	mutex_lock(&pf->adapter->ps_lock);
>> +
>>  	ptp_port->link_up = linkup;
> 
> [Severity: High]
> This is a pre-existing issue, but now that ps_lock is taken here, should
> ice_ptp_link_change() check ICE_PTP_READY again after mutex_lock()?
> 
> Right now the state is only checked before the lock is taken:
> 
>     if (pf->ptp.state != ICE_PTP_READY)
>         return;
> 
>     ptp_port = &pf->ptp.port;
> 
>     mutex_lock(&pf->adapter->ps_lock);
> 
> ice_ptp_release() does three things in order. It sets the state to
> ICE_PTP_UNINIT, it takes and drops ps_lock around ice_ptp_port_phy_stop(),
> and then it destroys the worker:
> 
>     mutex_lock(&pf->adapter->ps_lock);
>     ice_ptp_port_phy_stop(&pf->ptp.port);
>     mutex_unlock(&pf->adapter->ps_lock);
> 
>     if (pf->ptp.kworker) {
>         kthread_destroy_worker(pf->ptp.kworker);
>         pf->ptp.kworker = NULL;
>     }
> 
> Suppose a link change passes the READY check and then blocks on ps_lock,
> for example behind a sibling PF's restart holding the adapter-wide mutex.
> If release takes the lock first, the link change then runs against the
> torn-down port:
> 
>   - E82x with linkup == false: ice_ptp_port_phy_stop() calls
>     kthread_cancel_delayed_work_sync(&ptp_port->ov_work), but
>     ov_work.work->worker still points at the freed kthread_worker.
> 
>   - linkup == true: ice_ptp_port_phy_restart() calls
>     kthread_queue_delayed_work() with pf->ptp.kworker == NULL.
> 
> Two callers can race with ice_unload()->ice_deinit_features()->
> ice_ptp_release(). One is ice_down() (ndo_stop under rtnl). The other is
> ice_link_event(), called from the service task.
> 
> The service task keeps running through ice_unload(), because
> ice_service_task_stop() is only called later, from ice_deinit_dev().
> 
> Later in the series the ice_down() caller goes away. ice_link_event() and
> ice_rebuild() still call ice_ptp_link_change() from the service task,
> though, and the state check is still outside the lock at the end of the
> series. The same window existed with the old per-port lock.
> 
> [ ... ]
> 
>> @@ -3404,14 +3403,16 @@ void ice_ptp_init(struct ice_pf *pf)
>>  
>>  	err = ice_ptp_init_port(pf, &ptp->port);
>>  	if (err)
>> -		goto err_destroy_ps_lock;
>> +		goto err_exit;
>>  
>>  	err = ice_ptp_setup_pf(pf);
>>  	if (err)
>>  		goto err_release_tx_tracker;
>>  
>>  	/* Start the PHY timestamping block */
>> -	ice_ptp_reset_phy_timestamping(pf);
>> +	mutex_lock(&pf->adapter->ps_lock);
>> +	ice_ptp_port_phy_restart(&ptp->port);
>> +	mutex_unlock(&pf->adapter->ps_lock);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but on E822, can the
> ice_ptp_port_phy_restart() call here dereference a NULL pf->ptp.kworker?
> 
> On the ICE_MAC_GENERIC success path, the restart queues work without
> checking the worker:
> 
>     kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>                                0);
> 
> ice_ptp_init_work() only runs later in ice_ptp_init(). That is after this
> restart, and after ptp->state is set to ICE_PTP_READY.
> 
> ice_ptp_release() destroys the worker and sets pf->ptp.kworker = NULL, but
> it never clears ptp.port.link_up. Link events after release return early
> because the state is not READY.
> 
> So take a devlink reload (ice_unload() -> ice_load()) while the link is
> up. link_up is still true when this restart runs, and
> kthread_queue_delayed_work() then takes worker->lock on a NULL worker
> while ps_lock is held.
> 
> Two other paths reach the same call:
> 
>   - A sibling PF's ice_ptp_restart_all_phy() (from owner settime64 or
>     rebuild) can find this port as soon as ice_ptp_setup_pf() has added it
>     to the adapter ports list with list_add_rcu().
> 
>   - A link-up event can see ICE_PTP_READY before the worker exists.
> 
> The later patch "ice: call PTP link change only from link events" moves
> ice_ptp_init_work() ahead of the restart and the READY transition, and
> seeds link_up. That covers this init-path restart and the link-up event.
> 
> The sibling PF path still looks open at the end of the series.
> ice_ptp_setup_pf() still publishes the port on the list before the worker
> is created and before link_up is reseeded. ice_ptp_restart_all_phy() also
> does not check ptp.state.
> 
> Would creating the worker, or clearing link_up, before the port is added
> to the ports list close this window?
> 
> [ ... ]
> 
>> @@ -3470,7 +3469,6 @@ void ice_ptp_release(struct ice_pf *pf)
>>  		}
>>  		ice_ptp_cleanup_pf(pf);
>>  		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>> -		mutex_destroy(&pf->ptp.port.ps_lock);
>>  		return;
>>  	}
>>  
> 
> [Severity: High]
> This hunk only drops the mutex_destroy(). Looking at the rest of this
> branch, though, can a sibling PF still reach this port after its
> kworker has been destroyed?
> 
> In the ice_ptp_release() branch for a PF whose state is not
> ICE_PTP_READY, the order is:
> 
>   - kthread_destroy_worker() is called and pf->ptp.kworker is set to
>     NULL.
>   - ice_ptp_cleanup_pf() is called after that.
> 
> ice_ptp_cleanup_pf() is what removes the port from adapter->ports.list.
> Until it runs, the port is still published on the list.
> 
> During that window, another PF can call ice_ptp_restart_all_phy(), for
> example from ice_ptp_settime64() on the clock owner or from rebuild.
> That function:
> 
>   - walks the list under SRCU,
>   - takes a port->ref,
>   - calls ice_ptp_port_phy_restart() without looking at ptp.state.
> 
> Nothing in release clears ptp_port->link_up, so it can still be true.
> On ICE_MAC_GENERIC the restart then ends in:
> 
>     kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>                                0);
> 
> Depending on timing, pf->ptp.kworker is either already freed or NULL.
> If link_up is false, the walker goes through ice_ptp_port_phy_stop()
> instead. Its kthread_cancel_delayed_work_sync(&ptp_port->ov_work) may
> also end up taking the lock of the freed worker that
> ov_work.work.worker still points to.
> 
> This matters for this patch because ice_ptp_restart_all_phy() now
> holds adapter->ps_lock across the walk, and ps_lock is meant to be
> what serializes PHY start/stop. This branch of ice_ptp_release() never
> takes ps_lock, so the new lock does not order the teardown against a
> concurrent restart from a sibling PF. As I read it, the READY branch
> unpublishes the port before the worker goes away, so it does not have
> this window.
> 
> Should ice_ptp_cleanup_pf() run before the worker is destroyed here,
> as in the READY path? The idea is that the port is unpublished, and
> any SRCU walker that already found it has finished, before
> pf->ptp.kworker is freed. Or would you rather take ps_lock around this
> teardown?
> 

This is the same problem outlined in the first patch. Will fix in v3 :\
