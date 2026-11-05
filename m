Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793902104;
	b=EXs2i0VhMG7LvxP7NoXl4dM7O83w1dEvLuint9Jba8um3EQ9nR05fQPnG5boPqLQldru
	 j1RCGveUAPZeS6kqCoVGd7FKCh4j7GPzIMnDRiwhb4J+6ggFJEyydshWiYINATqdxs0W1
	 qNhsTwS0YhNo7aK9NEB4AzMDYEHfJwwfPtUp6ZANHDnRdPTIff+GUvAhQA9SDW7nzDvsT
	 ThyqEsUMt2KIiFqS7o/CxbOTVIiH+HGiNiyj+zup16a1gt87vcnFRiyLJML0es7OriAbk
	 wexI2ey7Ko6gD7IIoNJXyMJad2wvMqeYM0nUV1cKrIhIU3gkIs9BG+VS0IXvaTVB53g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902104;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=oNeezkSjKwYCFqYLgDz+6bO63KxWRGqGLCbLGHkdtAo=;
	b=AJ9el7T6UzFpcEd9EAHmBls8rFwKB3poXzMJ6A57/bAf0xqOcoQxxUHjfwQ8mrumIYD3
	 05kaKTFRSMY80Xqp8QtkC2cGgKIMxCTQn4HZ9+SsCcQW30R2YZh+2286MukFWmhynePpc
	 Ym5bFym9MW92Fwb7IYl3BMZyaMU3A6aHmrbo09MxCU3VnlvK/OW5N5265wtQQlgyuiu35
	 frzra4Cn9wGoZW2Rxn3pjhiRvcKhG/au+tAnBhF/XzyCZ8W93Ie5bZgUTz2mS3UmO1CRQ
	 g80UxYY3Q4vGvY97m4v3r6dMFkDuREyef1qcOf2UVlw1Jme8pcezov1/4uTjw4yPoiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJy+9vT0;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16028606A31B;
	Thu,  5 Nov 2026 18:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16028606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJy+9vT0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793902105; x=1825438105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PTFUWWT+qs45hZQk7gKmXViVRWNiXf6dfpWeEN/WOZ4=;
  b=oJy+9vT0OhyLVHg6C1zjbiR6sSxLcC3Z4wID2ubobLhZkg0iEe3xXWki
   1ljKt9be0r+KqI5ohT/5yv8N3W2UaTDTyKAnk2wl9+Ugjsk7a0qjdoIdg
   UFlXbNdxKg9V3VJQZhVmSMNCG0b9yygjpt2XrIpfrI/9NI+ni+foIMpVk
   98YQrYvfEixmgzSSy8YQYETAxa9CjRqkdmOu2XXvfGWOL4WZoKIUGZIEl
   Tx/YubI8vKq95sRx7Esn/kcTaT3FbL46gCuSZ+2cee56PbhKQ3xeNTgeR
   7nf3R0qchrgn10zdmjrSSzxfkQkyBlkxOpAzQUcuXvBcbNBHlYlZAwjVU
   g==;
X-CSE-ConnectionGUID: 8nzCsXacSV6jPlYvGWZsbQ==
X-CSE-MsgGUID: WUKJC5HVRMWMBVgb7oAPPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2735773"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2735773"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:08:24 -0800
X-CSE-ConnectionGUID: XKjnxUCfQee4QURUvVS5vg==
X-CSE-MsgGUID: kv8aYLauR3qcB4wpQzPFqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7103320"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:08:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:08:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:08:22 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:08:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGy+ny1IoofeTtOvQ2M2eb1R5FWOVSzXVEy0X+IZEq+E2LxoKXPmaS1nZ6oGmx5yxsfzH01zSVrq3MZyEDnz7ZLloSZBuroZCMNGKJ27vB+XF+SzoWWay6O4g5bew8qQg6K1dnNJOXUnQp19XKJEVo6D55Ytj77One1ru0f/i9Y6UbMi/WK6Ol79OSpRpt/Rwb4vanBQ20ibE0MiZ5AChgDOAyVld5MHL/JLFF7S7bcSLKqeXUqbZPkNPP+yq80lbAStIubdoC/gwoRy5wGQlgg1M1KuXDbUZvUxP+fmHDFBwv46f/RyXcDNsxh5LDht3nd1Ep3hScKmlS8PFctDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNeezkSjKwYCFqYLgDz+6bO63KxWRGqGLCbLGHkdtAo=;
 b=yr6feaRYao7GfiAzF5/bzuGIAY2xKPK+K5UmLpesrdsxGEmI3k/GDImBAbI+zm5k++T+5pOfndTBbe+Wj4mKQtLTpzRFEOJm4phqwztvTyupqtKLwejQEZTNwu+PHRbzfd2Q1aJT2DBYBRH7O1ibiLMG2/8n0l6IVmka8BXzCFNgXJlwvmv+h8yQL7ss2ctqH+Xzd+WHbnIDGzTp/Sr+ppGX7Vnh+0SdalpgxIjuoUCJWyc916TwLJTFYjHpP+E8WBK807z3oYfBkCITHyIaSrvVJ5hV67BGKdp2UfoRs4UmX0hHcrEmN0EZ4U6TCbFBFQ5VJ1uwt7R4i1RcMsgddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 18:08:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:08:18 +0000
Message-ID: <1cfe950e-50af-4120-87c8-375f67eb3e01@intel.com>
Date: Thu, 5 Nov 2026 19:08:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 0/2] libeth, idpf: use GFP_KERNEL for the
 initial Rx ring fill
To: Luigi Rizzo <lrizzo@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Luigi Rizzo
	<rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, Joshua Hay
	<joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261103162326.3615979-1-lrizzo@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261103162326.3615979-1-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 657e6624-dddf-4230-b133-08df3b67c4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|261021121427099003|261022075727099003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|10067099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: U1a6Dl2rYeXLUll87xbKzCeuu19KWaZF17mxAk78OF0ehcmm5NX4eS0JWZXYyA13dLX7VsoRuPrFds8qSZTdJvyTlfUjEBTwmkGZfbdyQcZDVFxjHhM+4B+fBrr8ZWPw1TORsU0sHvY5luTjO1I8Ed9kZaokuuOY6qgIixWh0NNEipvrXyUbiBzcBIE+kIgf2EvLRuEJSH3sGW5GaTKjhtkkOxqhppLesnhl5I8BzAUebo8IlPY7pAdGuizsc70UUUZw7L0sa4T6SGC/Qw8BY89y9BOeGdPPEAiM/1vE8wHhbTaZDKWlKViFcr61ztia0Gzx8Esw2BTNci8qGtomJBrdIOJZ+P2jXzdPPcdyZcR7XbjfEp83Mf6kJYQSC2Aa3NYeT/6DspAGnVvfkYuP3L7fBZ1fZuCZofzf5gYQxZ3JesdNHjSRapPYL4RkYM2prgd/ugLNgqXVxisRKAyaYJlvV9IOAtqGkDHfVgUcQE21l9b7MS0cZFR4fZmW21w1Rhb/nYDQgMVPHxq8sVuFMXXd0YHwDkdz6dSFL82jb/8Fo8r2oTz8qCCDfuphKY/7PspscbcaNUgJorGEuMms4dTmBKf9oNDDuDjX43zkH6g+kxrebf0v7sA7CMxeEglk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(261021121427099003)(261022075727099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlNQjBIdFh2aXNvUVVVYjBiL1ZKUERYSkg2d2o1MnhPMDlkdWJqWWY0SGUz?=
 =?utf-8?B?THpSZzV3R0FhVE9PczFSK1AxK1o0cS9OOTVPVUREREE3MFU1QjJKaWJ3cXlR?=
 =?utf-8?B?MGZ6WlJrd3dDWWZOVis5WHZVTFJzVGV2a21selp6cjdjbnBWd1F0dHdsUU5P?=
 =?utf-8?B?SWNKZURPVkM1dlBGeVd2Z3RyUGlPYUw5TEU0elgwQkxUZEZobjJLRFlBK1A0?=
 =?utf-8?B?TEc2Q1JscjdOMDNUZnErYTVvZSt1K0xuOHUwbndwYnBneXR6Y3JvbVcrdE55?=
 =?utf-8?B?Z095VzRLTlpsMVp1R1ozM2JVMEZqSVNjK2kybnVCcnFEaWRIQUQ1RFJqRDBy?=
 =?utf-8?B?MUhNL0ZXUzBCMm1uSUpSakVnUEFpUkFnVkNCbzVXWEFFd0tFa1U4NFZqdks1?=
 =?utf-8?B?Wmcxa1ZTRTVMVG5BY2s4eXh3Qmp6dE8xaW1DWDNtdVU5QVpjaUxIWkxleGlq?=
 =?utf-8?B?MVZMNlNMTlVYNnUxNVFST05ubnRXTmoxbXNrVXhCSnd5RFFxZk9WbW93SS91?=
 =?utf-8?B?eDlTY0REVjVrNGpad3hNZGNHMnRLbERZMXUyMFVYZjVuTy8xQWhJUHhXQzQ1?=
 =?utf-8?B?dTd0UHltVU5MYk9QcTg5K1ZmRXhWVGx4WkpyRlMwbDdkRHF1T0o2cVF4QTFO?=
 =?utf-8?B?WVlPZzA4Z0dnSHJER3FKUXo2NHNDK3A1YXROZ3kwd3lWMVVmWFdGV0tFUTFE?=
 =?utf-8?B?SnpBQnpRaUZITzdEVWZXSzB2SGR1M3NCMmE5cXBYOFNFU0tlQ2kxNGxOZDlw?=
 =?utf-8?B?OVFaVjlmbGpwMk5SSHVsbHNlSkpGaDBEVVZQWGJYaDI4SXdhNkcvK3BwUlFU?=
 =?utf-8?B?RHFZWVpYWmRmY1NMK0l6dGh4T3lDaUcwYjBUU0hHaFUwRmhEZlZxWUUzdSt1?=
 =?utf-8?B?UlN4dUNGaklVTGY0bUlsR1REMDNGWjRicnBWTitsN05wRFVPbWRtTUhrREtN?=
 =?utf-8?B?NFFzL1hxS2piNWRBVktNQ1hGbENGOW9YU2UyRkxzbXU0M2YrQ1FRM2JYbGt5?=
 =?utf-8?B?ajg3M3VDQ25rQlM3S3k3dDN6K3hGRC9tYXk2REZCcWJTWlFhYkQyTENoUUhz?=
 =?utf-8?B?M3QzWURqRWN2MlZNaDdSc2tNTlovWFlWOE5NWExoR1FzUHp2MmZGMC90QlFs?=
 =?utf-8?B?WUNkaXYvZzBRSVJkTXpGR3ZxR1JJTVdVSFcvMFhmcmFnZHNhaUF5WXovTzVG?=
 =?utf-8?B?ekdzeEM2Rk0wMTcxcHpUcC9TcmY3VTJaL3QzQ04ycW5yY1NaZVJSU1h3VUNK?=
 =?utf-8?B?THg1RktNRlpPR2UrSlNNdnNCZzNJekNlSFh5MEVLL2FITk9tYXU1dG5qNjd4?=
 =?utf-8?B?R01EanFBcWFROFRaeVl3eGs2TFhPVzh2RTFmSVZZMXByUWtCSlViZ1BtbmxQ?=
 =?utf-8?B?MkRqcXJTNkFlcFcrZjljMjZwSVJlWUhKbDkxMDFOL1I1U0JJYW54ZTFKN1RC?=
 =?utf-8?B?SGVDeHZjTjNjS2JWRERhcnRXajNtM2ZDS3ZRaEpTMXdZYXZIOCtuYnRXZGdo?=
 =?utf-8?B?VWI3L3BCMjZCV245VUhIcnY1UjYwZVUrcnBUMTE2Q0ljOENIbnE1S0FpYi9T?=
 =?utf-8?B?NDFLMy9RZ3FJWkNpeDFmc3FzR1daWk14WGNEUTZCTGh6T29GbVpuYzdrQVZk?=
 =?utf-8?B?OU13L2RFbFNZSGtRQm9LbndkUnRuS1NpSEpxWE1teVphT3gvSDZiVG5TNzRo?=
 =?utf-8?B?SzB5MVBMSFJ3TFVsN0JvVVUxeCtFcjlnKzVnYy9SWG1FZE1zUmN2R1JvL0Rx?=
 =?utf-8?B?bzRmTWh3VzRwZlV6VUhMWUlWMDJlaVZZRVZCMURVUExmWHQ2RFByZlZRRnhV?=
 =?utf-8?B?eHd2MUw5ZTVoM2V5TEpwN1Rmak9xU2ZtSC9FQTkyUTlFVHhITTNyKzUwSEJ4?=
 =?utf-8?B?NkszODFFTU4zU0ZWaTBXdkVuQ0pQY0JSLzEvQVRBRGNkUDVQRWJVUnliQjZ0?=
 =?utf-8?B?bE9lL1Mwc3B1aEhBeUdhRXhCR2pzME9sWTBHaXJtc1FrNVphTkdMRGI1YnZG?=
 =?utf-8?B?QnA2Nkdxc2VrT2ZESFdaVHZvNHhaam1waGszRXV4M1Zwd2FwWG1BTnVSWGZQ?=
 =?utf-8?B?UGhxV1R0SVJDQmNaR09qZ0NwNjFZZTlFUHZPRUI3Uk5ncjJSeVB1b3k3Q0Y2?=
 =?utf-8?B?SGxPYnMrSlVhTWtMWXNoTFdKbkxUVXU3TVROMngweXhjUnlzUktYTTVHUHZq?=
 =?utf-8?B?U0lsWmNuU2FSK1oxYnB4SysxdVl6WnNXbzhjOFBvWFZuZTRVUUV2Ty9WYjZw?=
 =?utf-8?B?RWNRZkJzL0tqWHFSZEVtK2ZpemxpWTFQVFlYVFk2QUVsNHhrQWlDR0xxaXVO?=
 =?utf-8?B?cERxMnRkRzZkNUVYQ2s4WTYyeFl3ZWJYaDRKQWowaWR4L25VQm9jWjlpTkh0?=
 =?utf-8?Q?28OSfjJ1e6euzZyc=3D?=
X-Exchange-RoutingPolicyChecked: 2RQH6NkcpNGuBLYBrsy6a4KZCsdBnwtrh9dXKyT3tu0UbclUY1nWg+6o4Ng9Ycmp8K+KeOuFhr9uy3CBSbkTxUEgfTEVn+xaGhgCxgL0o0aKep+YV17ZKZuxP2/uJxismOpG7ENnm5aD5xqE4PrhVJphWnL8u966ZvXOK1RMT4zWmqtCzduNdehjqHpr+ozBzjcRIhZ+MNSHtzY2AuyfrDNwOcte+7s+D7ZYQgvTeObNapap9LErApywQ1iU0BHx99TI2Se/IpQQpDlirbqthk2BX8+7NYcMpxiDZSR6jm3Tf4JZ+BowcqjDuVdMAm8GY23RmIsFei1cdo4SGIT6eA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e6624-dddf-4230-b133-08df3b67c4ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:08:18.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZWqgjBK0K/Vwa+/xVrjHEJHhJ9zWd8gnvbXPbK1a+upBJLYkCBocaxYna6byyaOTELQXfunbTV4O9SOBLKVR6Hnt44IOxeP0JascbcjOp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com

From: Luigi Rizzo <lrizzo@google.com>
Date: Tue,  3 Nov 2026 16:23:23 +0000

> libeth_rx_alloc() always allocates with GFP_ATOMIC, including when a
> driver fills its Rx rings at open or on queue reconfiguration. That
> fill runs in process context, right after page_pool_create() and before
> the queues' NAPI is enabled, so it may sleep, and GFP_ATOMIC is
> needlessly restrictive there: it can neither reclaim nor compact, while
> the initial fill can allocate tens of thousands of buffers across all
> queues.
> 
> Patch 1 adds __libeth_rx_alloc() taking a gfp_t parameter and turns
> libeth_rx_alloc() into its GFP_ATOMIC wrapper.
> Patch 2 switches idpf's initial Rx ring fill (both splitq and singleq)
> to GFP_KERNEL.
> 
> v3:
>   - rename libeth_rx_alloc_gfp() to __libeth_rx_alloc() and put the gfp
>     argument on its own line in page_pool_alloc_netmem() (Alexander Lobakin)
> v2: https://lore.kernel.org/r/20261019210604.2433620-1-lrizzo@google.com/
>   - split into two patches (libeth helper and idpf consumer)
> v1: https://lore.kernel.org/r/20261016151835.2500807-1-lrizzo@google.com/
> 
> Luigi Rizzo (2):
>   libeth: add __libeth_rx_alloc() to specify allocation flags
>   idpf: use GFP_KERNEL for the initial Rx ring fill

For the series:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks!
Olek
