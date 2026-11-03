Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793723089;
	b=pL+qGVAVx+NWeteM+LTm13bba/IfPa5wajMOC8kHvqS7QowN8Tbq6Yqv+tshck5fPkNN
	 IwwCINZvR+fAmyK0znkC/dBxCDGcHFBCSXcvwXEVsyiMmUDwLRlwzXsX4twnvOwZXN+hf
	 L1EHaD/dXx0ALKRK1BS1xSTFYfV/hpCz+7KfxpnY/ZwNvfhSHeGBvv6b72v7jZRSs/0Kz
	 D0qnhKFScXEA/uu9NsQot7FmtQtZMM5Q1FnG7Z1aK85pYFdz2ILJH78d/96Drcx3AQYqf
	 nP/+TvG0BwQ7V6g7G0Y1xhclu8rSKoEKdDXLBAJif2EVz4QjOI6bW45rAVxa8lLmqcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723089;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=97dfNkT2fWBIJ/m2s3vIV4z1LcnUIeNXvQOJgY/mpzs=;
	b=X4V0yJ9vSU1P/qYWK0Cx3/NSD7pvUIZ+sY7H00Gpc/0ujUq3wW48Wkp5SGJVIlY++MW8
	 hjqVcGbtCV5n7ObI90fsYsXP2T8vovy+EjEwOXoXGVNuYn51/D1w3fgIq1I4jW09PAMM7
	 4af9ZiXeQY0ALriB4GSIvDdj0X0/564UT8OWt37tYVZJe39IttK5rvON/rtrtToA5DUSs
	 dGCUbE26a9Bv2nQmJsIoHR/WIm03Yo1eXSxWvuXb8kfT6X+S3WOQZYVN/ORvS9+4oy34w
	 qbZ2xwD8j4Mj6KG3r1CGABOvVclRs9dpXKLFCEm/hSzXDQXU4vIoqihlfELxIsU7c7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CLDcKg7K;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF4606A336
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91EF4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CLDcKg7K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793723088; x=1825259088;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NR7KCunZBSm1/duhqIKLORe5ttSoSvhumG4tFhe+zIU=;
  b=CLDcKg7KRqUe8fE53YHO2/AAsKpMnwJKXG0pinEI7T/V3HM9/21S42xJ
   ok+KH7DNTPjUYImPe2/ggkDobYVXqC9Uj2qdamo8yzMgbNCKZUHj3ALs0
   WmINAUCqHfU3bdFMYaWqiSglnKoE+9nno+rXXaR2nFZzb465X35uLr5SO
   rb4rp6zjRsjzEkXwsfkP+oNsjqgQxzb8og98TKKH8x4LHYLkjZjQQWPMB
   ohpBKBKXfiPSoz0VxZJN70lFrrua1nLe+/khbKxqYn4AJRjmOf7vxvfjO
   4xjVwXOnYVWQav4Li1AYpBlA/5hUQt66C/zu/04k/nC5NVUIPYbFW2ahi
   A==;
X-CSE-ConnectionGUID: g6cJlxOWQMaL4swvadEYZQ==
X-CSE-MsgGUID: s8ZNSwVETDOGMik5++yb/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2453933"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2453933"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:24:47 -0800
X-CSE-ConnectionGUID: yf4Dcx3URXyUmbS71q+OmA==
X-CSE-MsgGUID: 7Nsa3207ToqhP5xr0HT99w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6621958"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:24:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 08:24:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 08:24:45 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 08:24:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC51/XwAtup+2Vg7t76ONmK12uJ/StMNldB0fAN9aE9pOOtlKubQAEPY0vuKf8PoB2zD+6lTin76CGOrIVYbjBZW9NIEjGaZS+OCR6uQWFGZ/OiTg/x1v+JHlHoT8qUwQGfVVlLQNdFRMaT6jrA+NdE9Sow7HbLNCoMH1wTe5k505h9xhnrFLc+O2WWyVDDkooLM3mkQdYKYcTGLl4eLxRZZ4nafmSQv4xfl0hLDezDS3+z5kPUqAUMBkEkuHpavuoqpPmIQ/8iLyJ9VVYOtFNvMFPxsj2MNn3sTPWz9E2QUsLzwZUlk/ThATv8BvWjm0cGeyYp8n1xLt1GALt/JFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97dfNkT2fWBIJ/m2s3vIV4z1LcnUIeNXvQOJgY/mpzs=;
 b=nyIuly3N1TsQRIZ917VH8a4aoQB0xjm7ShO2XsOS1uhQhZcnfNNiAI+Mn+VB4if6gAVGTbW27mjIHiynJrrjWQzcD4tNN1X7C1SGbOM3TaCgGP+U1znhXjF8kfq/Ke7bQ86MX74Y4mPIL4BoJ8ydBO/C12GngXC9uP/60TO4xlv5VJU/IXWC79DRdmZHZBc8/kvexGbbPv6FnsIkTdcAsuzpuCrb+qoMlX5LlkgsMj2AD9EdUWmLmZY5uzLiOHpqTQCVBACgYRXIVg0T/+GCPtxcmShxbsmyOrEtKHpQuyk/Ka7YUyvCfSe/iBjTy3sIHh650sQP/+hzn83pSKgdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by MW3PR11MB4522.namprd11.prod.outlook.com
 (2603:10b6:303:2d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 16:24:35 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 16:24:34 +0000
Date: Tue, 3 Nov 2026 17:24:28 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <zuomao338@gmail.com>
Subject: Re: [PATCH net 1/9] xsk: fix list corruption in xsk_buff_add_frag()
Message-ID: <auoKvG01wDpW8uQJ@boxer>
References: <20261102124950.958345-2-maciej.fijalkowski@intel.com>
 <179371274919.488856.4452814542770594161@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179371274919.488856.4452814542770594161@kernel.org>
X-ClientProxiedBy: DU7P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::18) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 863d4b69-58c6-4fa6-ad40-08df39c6f22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: j9es6+a4ImAK2p9j7XG+CLvzF8NdlIjbUuluDwhXktsbG+R+Ul2wF/+SYPOl2F/UR+LuBgrCOYa3O6XrIpXypOB4LUYvYCRZlT6mPjQ3GLNXXYCBne4QIW8HPz7noUxiXr7kM26llzGR+XOl6g+6681yyRG3ilDxqdHeyI7/5N6vcciCvSzEl34MIYBB+OjXrAsefTACZNTvdIWQK1vFRJ1/1SJ1WPqj74NGT4iej2g02dlxH6e4tCC41fmsFx/ZI4WBuXTYHaiWN2k0138FGv1y7zxJRNdadQpExJ0yRd56ZYTeCpjLNF/s2fLkoUG+KTKL2rutZU3db4QO1h4FXNdEGJaay8vUl3kPqyB26oQJ/sy/l8o0e93ZbEpbD/aH4c2AaxwfWn4o7C83gWL+om0MtUHphK60o0jSpa3wXXAFmDB/gtv1VqBfpVMxLpZoUWMNQf0qSiT9CXUyBvZ5ttcSYF4+ZbGFQyT7yW7+srXgQF7a5XSxPgk0HKHSTGD9t7hwNbzBfByGvCTGRJVbEqzhL8dXVzlC/JwVcCyJ0ajFE7Y1nCXZ5gmJjPrdU7+7HaWAe23g+3iJIK84sLUhHQ1js1Yz4Tff28kRCPxvH+3X2fZwk4KAi68nO+V/rVzL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ROV1RuOE55aGV2T2tNRzM4M2N4clE3aUEvOEsyMSticnhxM3J2VkxySS80?=
 =?utf-8?B?dUU1UnNIUzdRQTJ2TnUrU0JoSWEvbXZKK2x5bi9PME9wTVY4Y0k4dTduRzNI?=
 =?utf-8?B?ZTN5RkpWd3pKZjRMWlZIOGtjeFBEYU5qd0NVcGVmN3Zoa1FSdyt6akdPTWRK?=
 =?utf-8?B?d0tza1NDSGpFMGw0b1lzRVpSY09xRVJnbmtiWGFLWFZEZ1B5ZElOaXQ3dVZs?=
 =?utf-8?B?L3E5SVNQQm8rdTl5RFNHcWlpUDd3Sjl5cURUUEhScy8wV2JyZmM1Q3RjaWZv?=
 =?utf-8?B?YlQ1VnFMVEZxWnBZQlhkWWVWYzdSQ08vMTJmTHNPSGF4cThCNCtwU0xQVG9v?=
 =?utf-8?B?T3IyZXVoNXQ4SUluODlxUm9Ld05VU0M4U1ZWMkFtd21YZ3Mzc3U4QmNmZUdz?=
 =?utf-8?B?Z3E3TkJ4VGowdGlNbmIvais4NGFXWlc0WUF4T0pKL052YzA5QktwSkUxZWVy?=
 =?utf-8?B?VjhOUVRsL3BpNTI1OUpVRDhUeVVwMERWQ25wK1hEUTh3ODAxdmVoV3AyUnpr?=
 =?utf-8?B?K2lCb2daU1Jkb2NiTXUzTVUwdlRGamJYbDB3VnJHcmM5Z0RGeUxmclBpbHFu?=
 =?utf-8?B?UmNhYjh5QldWbUNLN1JycU04Q3hLdGlEYXhBN3B5ZXpkZjlwenRnZTUrcHd2?=
 =?utf-8?B?QVpLSGhza2psMjAwTy9paUdYaEcvZFlpYzhCaXpaTGdqTVppL25xMjBtNFVq?=
 =?utf-8?B?VWhNczA0YWszUTNzcnFGaHFsQkdPbXVHcWN0bGNCZnNTVFJYeTI4cUZwQnpv?=
 =?utf-8?B?TzB1dVpjbFc3MnViZUt5Sm9tNXZwU0MzR0RTYU9YWXZyaC85dUg1aDNUUVBM?=
 =?utf-8?B?eHYvT3MveitFSlFMZFZWR0xtckZ5NHVVT1k0c2lYWi9HRXhBbWZTNmlmWlBr?=
 =?utf-8?B?Yy9td2NKSUdteER2cVRNU1YxT0oySnFNMlZmTnF0OWR6L2wwT3lhdzRkbVJI?=
 =?utf-8?B?WEl6OFhQT1ZrN2UrekgwOGN3MXNxS0R5SVdTMTJkc1ZUdEFIbGVZV24vU0dM?=
 =?utf-8?B?T2k3MmlmSEVDUDNrcWoxcDUyRmE5cjVkY2hHNUtzS3RjbDQ0MU4vTXVsQ3Zk?=
 =?utf-8?B?c29qRWxrYkpac3JKZ0xVWXBjam0yWW5MY2pmRTNGbEc4UDJDL0sxQXUwQW9F?=
 =?utf-8?B?TGlKaUNhb3dLNXNJR05TWldSdEJmTEo1ZG90WXZ4SW9UME9jekp6ODAwVDNP?=
 =?utf-8?B?NElHMzh3NTNIQjNxT2JiR1NJM0JUQkJpTStLcHBUaFlzeldESlYrcGZBbmNT?=
 =?utf-8?B?T3hSZm93YVJ4T1VsM2E2RGgzaWdJak81RmY3S0tDR3ovdGY3ZTduaFZOazBp?=
 =?utf-8?B?MVlBWmtSMDZOS2JMSzNrQWZOY2VnVUxmcEJKaVJFY1Y4dFczZkFsTlhpNnRL?=
 =?utf-8?B?bHoxWXpIS0tHYmMvMTZLRU9hSHZSS1JPYkl3SFRhbm1VcVZYZVNWTGV6Kytu?=
 =?utf-8?B?cndBcmJYRXB6eEl2OSt3QmJzaDBZTlM5c1l6YlBmeGF0cUM1cmlYN2tYU2F5?=
 =?utf-8?B?MjF2L0hqUUxXbWwzTDZ3Ky8vY2gzR29nTDZUYzZtSTNkOFFXaTJKMERLNktW?=
 =?utf-8?B?eEowYjk5TjluZDBoRi9PQlF0cjlLNlQ1RXYwMTVpd0tsL2tuZncwU0pvZzZs?=
 =?utf-8?B?MzJiV2xvamRCMDVNSkdReTdaQ254b3Nva2IxVDFkOWQ4UGFOTUpNUWNPMUMv?=
 =?utf-8?B?a1NYUG9LcGp0Q1pEbU5Wd3habyt6MEluQkxNTVRVa2FMZjBWN1A1QmZicGt0?=
 =?utf-8?B?VEtIeEk2YTRrUm9RdWpMeHk4UEQ3VHVjV3RCM0kzaUVJc1FSaVVCbzhsMnQ1?=
 =?utf-8?B?eFlueVZrRjE4dWU1MWI5UmE3MzdIRjRTVk5Ob0Myc2tNZGxNV2dSNkl5WnFO?=
 =?utf-8?B?d3g0WlNGMVljU1R4K2UyQXU3WVV3RExiNytRVVBOaEhOWkdaN2dtRkpkTTN1?=
 =?utf-8?B?VzRTdzhFaW9LTlBDU1ZPWWtxdDhMR3ZJM25LT1NXbnNMRHMydURsZ2ZaNUpl?=
 =?utf-8?B?a0FjOHlpZVVMeEMvV2JZZXcyVnd0NnlneFU1bFBGdGdJM3BCbXVSNVY2dmF6?=
 =?utf-8?B?dnZWc0Y1QythaEN2eUlRU1J1VEo0OFF6cU5FT1Y5SHlxZ2FaSFdhdUZIaWtU?=
 =?utf-8?B?eVpmR2JxNUlQL0MyT2cvSzYzZU95eWU5d3kvOXRjZTJOTUx4dm14ZmFwdWlN?=
 =?utf-8?B?SFhpYzRUd3o4dDNCQ3oxWnRvemNTZTVFWExmN3RFdVlxcEpodHFYOG5mM1Yv?=
 =?utf-8?B?OUNuY052UmFwSnBZL0cyNEZ4NElkZFVGaUVGWnZCRjJhNDcvaitUZ2dlcTF5?=
 =?utf-8?B?SFlUeGlkQnZKVkhCK3RWYXZXWWYrL29JZ0JCVXNDeGYydnlZdVQ4NzZUVllk?=
 =?utf-8?Q?cIArtOoLIRmRSXQM=3D?=
X-Exchange-RoutingPolicyChecked: wiA9xQ4BHVq+S0Qi7Degdtg+p6mT11LInl3nwrAmtKwb1sSpOHfkUv7aQi1z4H2lpDOlE4BPBTMOPNNQ/eSJj6Bth3pPKSMgoM2lqCO9uITLSaL3RntgAJfV5ro7PapT4Id6+AXVneBrSSbRckEQUU/KsnLbZTl+0P2NPfoCMTmAatRCQ4t98xyanjR0thnxeht3wJovOpeC0w4xQNDnsc/cXubjq4w8CHBLl5SGdDRGTnTh/YJ/mw9kgMQBG/kbRXdkFp++ZeLsB0usM5DZvw4idbI0aq8pXG2RPP5HmisX+rqrwco/efZ1hh+LbJ2PWc9diGWRDiSuWA9G8SP0bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 863d4b69-58c6-4fa6-ad40-08df39c6f22c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:24:34.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G12TUe0EYqgAZDWLTI/rLaD7Dr2Oy6xx2MrHNVTseNma994dRfuz6cPneVYulQuVdSm8FXO7reEgGLslxEFPo2NUim3wE+PBMiB9S5jrWdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 01:32:29PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 0 · Low: 1 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] At the reviewed commit, the new `xdp == head` rejection in
>   xsk_buff_add_frag() (include/net/xdp_sock_drv.h:166-168) runs after…
> - [High] At the reviewed commit, the new rejection in xsk_buff_add_frag()
>   fails the same way every time it sees the same input.
> - [Low] The kernel-doc for libeth_xsk_buff_add_frag()
>   (drivers/net/ethernet/intel/libeth/xsk.c:50-51) says it returns '%NULL…
> 
> Pre-existing issues:
> - [Low] When xsk_buff_add_frag() fails, ice_clean_rx_irq_zc() frees the
>   partial frame and sets first = NULL but does not skip ahead to EOP.
> 

Note: I will be trimming away all the issues where beloved bot says 'a
later patch in the series seems to fix this'. This is really annoying :<

> --
> 
> xsk: fix list corruption in xsk_buff_add_frag()
> 
> This patch changes xsk_buff_add_frag() to reject a frag buffer that is the
> frame head or that is already linked on pool->xskb_list or
> pool->free_list. In aligned mode this happens when user space posts the
> same fill ring address twice. The goal is to prevent list corruption and
> the resulting NULL pointer dereference in xp_free().
> 
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index d94aeb506379c..29965e3695983 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -160,15 +160,18 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
> >  static inline bool xsk_buff_add_frag(struct xdp_buff *head,
> >  				     struct xdp_buff *xdp)
> >  {
> > +	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
> >  	const void *data = xdp->data;
> > -	struct xdp_buff_xsk *frag;
> > +
> > +	/* Duplicate fill ring entries map to the same xskb in aligned mode */
> > +	if (unlikely(xdp == head || !list_empty(&frag->list_node)))
> > +		return false;
> 
> [Severity: Low]
> This is a pre-existing issue and was not introduced by this patch, but
> this check makes the caller failure paths reachable through duplicate fill
> ring entries.
> 
> In ice_clean_rx_irq_zc(), a failed xsk_buff_add_frag() frees the partial
> frame and sets first to NULL, but the remaining descriptors up to EOP are
> not skipped:
> 
>     } else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
>         xsk_buff_free(first);
>         first = NULL;
>     }
> 
> Won't the rest of the hardware frame then be assembled and delivered as a
> new frame? idpf_xskrq_poll() does the same when libeth_xsk_process_buff()
> returns NULL.
> 
> The i40e patch later in this series calls this intended ("The rest of the
> dropped frame is received as a new frame"). It also does not appear to
> corrupt kernel memory, so it may be acceptable as is.

Hm, yeah seems like frame should be drained up to EOP...it's best to do on
driver side.

Clashiko 1:2 Maciej

as two issues were just bonkers, they are fixed later.

> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc for libeth_xsk_buff_add_frag() in
> drivers/net/ethernet/intel/libeth/xsk.c still lists running out of frag
> space as the only failure reason:
> 
>  * Return: main buffer with attached frag on success, %NULL on error (no space
>  * for a new frag).
> 
> With these new checks, it also returns NULL when the frag is the head, or
> when it is already on pool->xskb_list or pool->free_list. Should that
> comment be updated too? The text is unchanged at the end of the series.
> 
> >  
> >  	if (!__xdp_buff_add_frag(head, virt_to_netmem(data),
> >  				 offset_in_page(data), xdp->data_end - data,
> >  				 xdp->frame_sz, false))
> >  		return false;
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
