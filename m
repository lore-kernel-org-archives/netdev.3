Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2AA424D64
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136635; cv=fail; b=IyW3MyDY4RImHkj5qjRCO+Fo5Mtf9RJ25frrXWYrbZ5dQIQroJ+vMKc34jTAAg4eEYvekeAF+FkYLB5+vYW0RIarOF/uQRGH2EqI13QCTsymiV6VgjsObb50jAlvm36IshuASnbZQfIqMlH1ezDEJUF4o2/l7U1EHxSSOxFlmTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136635; c=relaxed/simple;
	bh=O99AhAEpy9jSuUbjToK7EaEm/FD2lgbipjjA4xczexE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vib+9RgmaI/MRWHcUNs6HJRRXy80br1DAyfXS3E5l2g5siGLVGR10DWkxJxY1uGw3UNEeTLq6WcUW+2e43MCerZRB6LGNrMpS9dftI57pmrM7T49wMtT/l8VQkJduy9l6AL/ldOfz/ceuy57P570THO83NGjy9/l+nwspB4UXAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LteOdd2m; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LteOdd2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787136633; x=1818672633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O99AhAEpy9jSuUbjToK7EaEm/FD2lgbipjjA4xczexE=;
  b=LteOdd2mvKNC1qJBHmvOxJPLLg9CSjmBju+iZEJzd6LLyX3WmkLP+KkB
   fz4KFzWZ6Yr+ERQU1pClJClt5J6OnA7qlMHPg5qaiSqopg8gi7wbMkpL+
   uQWxQ1vF5+mJXG01d0GoxSlfF8RIadIPEWDmdfJPtMQhnW1Y7GnpaR5Nk
   tnCXWe5t4yJQffLClIhep0TyiXSB+Q2+u07p0NaXrCE9by6w8iEoCsmFW
   vSFB8/apv/7nHKroMvJFFx34LB0P4Sf9CrFf4ZgxREDrSF0ZgB/TA8GIC
   WGy9IKUDK+yS9h4A6YoTIrGxc5V9uVVfdvm3mBOiP5wUYGb28wqJncVoJ
   Q==;
X-CSE-ConnectionGUID: 3F2jzGQSR76SdX9nCp2oDQ==
X-CSE-MsgGUID: 5zEVTqeGRG+CCzmbQdeEdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105030678"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105030678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:50:32 -0700
X-CSE-ConnectionGUID: 5HyZzF8WQFmORmwLNznkSw==
X-CSE-MsgGUID: Tt2X7Z0FSk2l4Vt4GUbwyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="270731050"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:50:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:50:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 03:50:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 03:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0Y/Msuci4F1xIifxINsHilsxnqyG3Zzlr6pBOskodhqVC6nGOJ9GdTdSmZ36bpuahVqdU+PwcKclPd6YdM9Fg2lHmNKgbxOJdnk5e1vbFRyWhGDzG+DLCa+HBbDds3UAHja/us+VRwi2yG3NmpNVTQPn+p6wwRBkaQLZdvGZTzrXO9In4zOZpQphMJDT5UR3VufPxkjR5N4XyJbthSHs7HhF08PgIQlP3Gyu53I1MxcRoycwz0NCp9b8vBq2/XuNXy5PEqmqA9jjTQApbVT/RJ8nm4t4rZwUZn+AoUD7ynl8S0TBPYLf7E9FNA/miWfxjjpm5zT4XHSDPvsMwu9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qV55bF3P3Fr8BsJj9KhuhnlvYHJS193dqX9AwCgx10=;
 b=k3rtZersNI/U4s9WBo3oW4K1msAQF5IIhsCSX/PUph0UQCYDNCO0kEZBHsDS7xstThPIxydUzXQMn/8NOo3Xk4TqiXZzL4ezhiwFOae9ghF66xnM9rElcXMuXw8Vwh/g4LZkkTR3tdT3s/T3aPtFwf/2/esSIpUeknp/Q/FG1sBtH2G/uCGqmZiDZnj6pKSlNZAdY+K1kao9Z/gQPNyEklnuEoYSdQpZTbhjX00ej0H4cncEwRkRCe9L0a1HLdrS8DllzAGZ8tt0kakpXl1HvyTTUbzyPAiLuaRZAdEiqmLnA9chk92gALntNlAysI/ke2HCPRGe5pdgH3yDAxX6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 10:50:27 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:50:26 +0000
Message-ID: <53c50cd8-edfa-4fe3-aec7-a6d66194e635@intel.com>
Date: Wed, 19 Aug 2026 12:52:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ice: fix stats array
 overflow via proper realloc
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <rafal.romanowski@intel.com>,
	<aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<edumazet@google.com>, <marcin.szycik@linux.intel.com>,
	<anthony.l.nguyen@intel.com>, <horms@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20260812204619.32253-3-przemyslaw.kitszel@intel.com>
 <20260817205047.3612990-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260817205047.3612990-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: d61d794a-ac8f-4f97-e8b8-08defddfad53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cxFjwEigmXL/Lo/BEM9fQ9mP5jnOLeCfHAiWuINM8wrAhIxlcpCZunzBaLo/TsPL4NUv/+H2mWhjs0I+/mussbxpUuU3j3pqlp4C5ZUynRs/t2daYvakNuSL6rPNevf1Q4E8v2e6koEUY5DrcrHc7VY0fK/54oRTcu5jlKZDCx8N5IS/Aj+oMpHVbUf+gWyumZX/+nrN6K5kJ5lx91AUMCdfE1XrHJ2YdKd+BFR2szN8JqemzwJA97ufZn8pYrOYq4RrURwCnUKIBrjEn9wBpeQvhpwl1gIuHZf+nfZ2NQaEFmq3SsNJWI3x7mywAeMR3b4fQqsYQkInkyu/SI3yOpXqwgMfaaJR/8W3J9KLsxrAtcn2tS4BF+9uMlCcgQ3E7b07fslZzvtuOUZ21r7icWqBjATV390drZR9K8mwvaC5hLzGaG+6JSGGEj0jWQE7o7a0gZVP1Tn1NsW6XYQGEOlI8D+oolunJbDZrsNuRPxe6FzmIMT6bh0z8YGNrJjotoRSJiSZrJjw92Zw2ou0OHb504S4KcimRINo9YAwF7U0PmGKRQMSMWmD6PKcQxxfbf/TYd0dW7ADUpEGrKdM24C1rucaYoZkE6FHBg8TGdd7I3t9OzQTUuOa/4nsKaMqakAfeHleqaEQegUAhIbRWxXfMZGF8wy3dHQJS7rLxtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU5xU0RHc2tpbjRWRnF4NVZ6ZHVXOGV1RVZmVmZtMy9rWDZRUnZFOFBOSzFM?=
 =?utf-8?B?NHJmLy83dXl2aWgrLzlWa2lyZUcvVHU1ckJXUVlhYXV5NTJrSGhvRVNmYVBY?=
 =?utf-8?B?K2VXN1Zhd3RtdnIzamk1bXAyK0VNL1pBRHlLWG84NDVXaDd1YlVPamQxY3FZ?=
 =?utf-8?B?VlZtd09Gd3ZaUldFNEFxZmNCVVROMXNONTNyWXQvU24ydnRROUZSSmdIeEJI?=
 =?utf-8?B?c0xtSm9FMmtBV0dRWUFybktIN1doSGdPQ2gwZXBHdkNBY0dTSHhONzlrWVJJ?=
 =?utf-8?B?YTgvZllaY2d1UEN5ZFZyZGVPUWRjMWxQQzhvVXBhQ1k1UmpGaEw1dk9PZDg3?=
 =?utf-8?B?d2licVdoYUdYT2RmQUF5NE5OOXlRTFFIamFMTHBCcWRTMG9LbzRuWFhzWUt2?=
 =?utf-8?B?QlZFTUlPalo2aEg0TGdWL2VSOVdpTkdmOXYwWkEzdHA5T0NHRlBtczRwZUZ4?=
 =?utf-8?B?cmhoQ1hPK3ZZV1BRVzFHd3hYTTJLZ1dsVDA5WmNEeGhIMm9XWWxtRnhPMk1q?=
 =?utf-8?B?eWpBNXFteUFJOVNLUG5OMlZ5ZnpWMkVIM0lmRmM4a0QvK3d6SHJ6djY2WEpZ?=
 =?utf-8?B?MXFWclEvWGJ1OFhLN2VNS1FBYXVWRnRtaDlKcXkxejdaYUtKRUxLRTRYcGtp?=
 =?utf-8?B?T0MxaXFoLzNRSDBXNnU4M2ZGZzV4em0wQ00rS2svYXVXUmxWTHVVOFlrM0J3?=
 =?utf-8?B?ZmlIZkRITHR0aXpabzhuanZ4UEpFdG5zQW5UK2dZRTVsTkx5Mm9XSjd6akt4?=
 =?utf-8?B?YnFpaU44cUVNYmNGVmltR1dJNGE4WHFGczN2a0FhMGtsM0dGNWtLMzc3ZUw5?=
 =?utf-8?B?V0lVZU10YmtZOGRZRmlmNHUzZXo1OEprS3lwODNQUU0yZEZXS0gvY1NXYWt0?=
 =?utf-8?B?RHdrbzZuaVNjTnFibmZHNWRpYWxjM2RRSUlES1JZY1NZK0ptYzk3TWt3bU56?=
 =?utf-8?B?czB3RzFUNnZhRGt6ZjhZS1FndTFENUlod1F0S1FIc1ppcngyV3ZDK0F3S1Vj?=
 =?utf-8?B?ZEg0MlNoaC9sWm5KYUxneHdGdW50c3IwazlZUUFRV2UraTlwZHJHRk5GWWZE?=
 =?utf-8?B?ckRIWlpwRkE1SlBGdWJUR0k5REthVGlMSklmWWV3UDN0MGEwSmVWZno5eXpW?=
 =?utf-8?B?d2FJK3h2MS9hYzlZNStlMjMyVkltTitWNmwvcm5LREFROUo3aGhrTGVWUENr?=
 =?utf-8?B?Y1pEczFzdnA2QzNSQzlCS3ZYMHRKSWxlRVV4SmpadVZtenJNb2tCZmxNdDRO?=
 =?utf-8?B?SUdMdi9tZ0djM3NyMzZTdzRzSnJLU2k0UjREaFBMelRrWURsSHNmM3RNbm5Y?=
 =?utf-8?B?UkJtTFdPSzA2ZmYzK1BNMWpVOWU4aU5KOXpqaVBGaSsvV2RuY3oxdGNaL3R4?=
 =?utf-8?B?aW13enZ0Z2JvZUJ3bzVQbjRZcFdBZjRnNStKK1FTZXlQSVFZYzF2a2s4UUxE?=
 =?utf-8?B?YVByR1UzVndUUnkzNC9xcDN5Mk96eWtNSkpSUFNQdTFwTzdtVVVWcVNKcWlS?=
 =?utf-8?B?VWRVemo1VndjRjZVZUlaVlBTSU9UU3BqbjUwV1hrdllqcnpkUGxrRzMrcDhT?=
 =?utf-8?B?WTUwSzFuQXUyMWdaNytMeDVBdEVYZnl2VTFRWWxKWmpVekhBc2pEV0dJVytM?=
 =?utf-8?B?c0Z3akp5YjhRZ2x1Z3VsZ2p3NWRZYmRaSDlpL0lnRWl5ZitPczYyTzN1SCta?=
 =?utf-8?B?eVBaVzFpNnZMdzVISnZidDV0Y215TXp1VmNTTTF0NlpZUHFBNEJ5cDBHVVJE?=
 =?utf-8?B?TUtBMXpQcTJuYXFtZDNOT2M4UC9tTlB5V05HVTRjTHBJdTBJS2duZE9uaGo3?=
 =?utf-8?B?MVQxYW00OXlDdmZzOXhTTERUSVl5bnZCbW9qeU5LaGw1NU5rTys0eGRMOElC?=
 =?utf-8?B?OXhZM1N3TEpXQzJrY0pCd1FsQjdnbVl4Y1MvTE9Va3VFMVdWTVcxY0ZNQ3hE?=
 =?utf-8?B?Wm0vNDdERXQrZTkxclpmcHAyOWJ1OGc5QVpvbEpCNkQrMi9QbEJRNnNiMU1h?=
 =?utf-8?B?YTl1VFNDWjBRQ2hqQkRqSExrd2VIYk51Qm13SFN2S1JuRTVKRlBTRUV2dVBw?=
 =?utf-8?B?cU90aTVDVjdYb2hmcVVJQXdTM1FqUFN3eU1sMWFVMmZQSTk5dGc5Nnd0OUgy?=
 =?utf-8?B?ekZxb3lVSzR1djRnL3U0WTJLTnVJZVo1RE45NXp6TnpVcnpQV0h5dmp6L09k?=
 =?utf-8?B?WHF4eDY5Mjl1dmpieExTQ0dNdllpcmZqQmdlNzFGV1Fkb29BNVhJM2NXMjRn?=
 =?utf-8?B?L3RIcjFXelhlaXMwTkRqTXYzVWh3Ryt5eXFjMjBkOGl5TThmYlo0alF6UWs3?=
 =?utf-8?B?M1d5cmJSNUNMclVDMVlwTGVJeHJLNGZ5dTNXaHc4MnIwOEZMbEtMdjg0ekFK?=
 =?utf-8?Q?SJIA0pdDQIweykyU=3D?=
X-Exchange-RoutingPolicyChecked: QWZP0vawfBt+pgpWOad0Lx6mSSKXpfNVWe90CTkQ7aAxD9v59Laumm6UQPbID3rgPlCBRgN6xrN69itwbIz5bsqdFya59mR8JaDwzu9IwXYrMKW/TBEum5xatbGiKd0X49yywSCh/yXMa8u1/MkuS2athF0UygCCFIyIghwxZKusco8PZjBhjlcoUwtIhWhIyvcmpRSzhdrGvCOZoCoiYM0puAr9+O8hGREqJD2t3HKssN080WqRs0ROzkMrx+FYL77IcbiIqinA5tvX4Xs+ZjDXyNv68+BB39+fUMRuawSYceb+ZFkRQRaZX/PY+/Zejp76AzemxI1+jQ/4dS6a9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: d61d794a-ac8f-4f97-e8b8-08defddfad53
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:50:26.3114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5mOuP2ipyppEspkrdGvDahKQUTBSiKLwRaSupSt4dpMnDTB8VxDBTo3fuFQBzueb+J4qwVOgAXFoFvbNKXP2/34H7a5VHvaHnGPRxFpSS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
X-OriginatorOrg: intel.com


> [Severity: Low]
> Does moving the ice_vsi_realloc_stat_arrays() call change what happens when
> the stat array allocation fails during a rebuild?
> 
> Before this patch, ice_vsi_rebuild() did the realloc before
> ice_vsi_decfg(), so a krealloc_array() failure returned -ENOMEM with the VSI
> still fully configured:
> 
> 	ret = ice_vsi_realloc_stat_arrays(vsi);
> 	if (ret)
> 		goto unlock;
> 
> 	ice_vsi_decfg(vsi);
> 
> Now the only call site is inside ice_vsi_cfg_def(), which runs after
> ice_vsi_decfg(), so an -ENOMEM there unwinds via unroll_vsi_alloc and is
> propagated out of ice_vsi_rebuild() with the queues, vectors and rings
> already released.
> 
> For the ethtool -L path that leaves ice_vsi_recfg_qs() in ice_main.c with
> only this recovery:
> 
> 	rebuild_err:
> 		dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n",
> 			err);
> 
> The same outcome was already reachable pre-patch through the other
> allocations in ice_vsi_cfg_def() (ice_vsi_alloc_def(),
> ice_vsi_alloc_q_vectors(), ice_vsi_alloc_rings(),
> ice_vsi_alloc_ring_stats()), so this adds one more allocation to an
> already-destructive region rather than a new failure mode.
> 
> The commit message describes the move only as:
> 
>      Also drop one callsite to avoid some duplication.
> 
> Could it also mention that the previously non-destructive failure path for
> this allocation is gone?

I see no point documenting such minor details in commit message.

As a whole, this patch trades a real bug - memory overwrite -  for
a slightly different order of operations and slightly different
failure point when there is no memory

 > --
 > pw-bot: cr

I would still like to apply as-is, it would be better to spent
"refactor time" on different things in this driver.
