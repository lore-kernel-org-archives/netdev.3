Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792453031;
	b=j7D1eU2I6qaw/yyLmOFCkmYDWeiVYTjuo3OeUqtAzLA7ByuimgIsCW4WqiQJRffjVD4W
	 3QlNXH86TaSz/UmLAts0tgk89B6Q4pw5szJCWySR0XYOuGpEbo3g/UIGa6Bfe/IpnfsSV
	 pJnHMAtPTByOJ/8iR9tGUym0GCwgPFpG+93c8XgA4RT3f56JSC4dA5cO+Mz8dmtwO/Vtf
	 5d9CHd1/cu/k94U3U2BrCI1qYkFVv2MUx92Jue9aIkYJCtDzYo/nX4csE5QVYNqAHQvEB
	 xkd64ApODlz9nZqV2rV7A8ncg9Q+P87QEG1zwV2acz0+FlP+mWAWra2CDj3lqz6Pxmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453031;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=5404WjSGOUOp83DkJR16/Ba5BDOVu99UFp3q+O5TwMo=;
	b=Qb7wTknXv/i7Cm41a7gl079W+3vi/pzQK6BiaPiUE2GyiydJGKh7T8ceWaaTahAfcdSN
	 aDZ/4K8Pm1aOFaxa8otH9RrYVtPBbp41B2cliHWlVEzmX3NhViB9h1TdjisKwEXcdkFsm
	 CINj4ZM2J0Sq5x2+SbBtfNKN5tGkKiI2xiQBoq/e4My5s0MoxehYvLfzh3OE4IuS7zwFH
	 MHqjFfN+uBFKykywJ9OyY1tKfVf7WrlyRWA8RpJiOXxweyvqCby7anKGmpEXB5YAFXd+H
	 YYgVQEtuSKpesrMIqNihmEa0gfLEal8G13dLDq0yO2ewwhwIJOsYIReU4F44gqPeEZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F8ixxvFf;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1933606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1933606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F8ixxvFf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792453030; x=1823989030;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZfIXldZRPpRK0d/bzXp6KiI1vCjT2fr0v10Vdy+Qsqc=;
  b=F8ixxvFfTxTnOTRUPNB99sR6UORy6oB3tL0GqGmNkhttciJ04M2WrxK+
   bxpoNa++v2I1P+mUPS8CZo/WLyEpZIzw5G0x5BcfApd+s/TuarqX4wVru
   eR/BD48vsJKPe66jsm9ekMgb2316K1q0rdUhghfqQ4HW5H+f73aGmDfZr
   03b+c3pyCQNWSOMDnz3nbblFIwGfAJ4ALVip5PjiecTW08A4U5U0o0Wpz
   jevJ6gl8ZRD8A7Fy56jPGpy8vOglcAE0JN19SCLm4bGp+mqNYAcsOwWmG
   z+Ot9BG34hlsFJO7R2OVONPN+/ahodaCK+VPP+pWhKWK7TjE5yHCD7r++
   g==;
X-CSE-ConnectionGUID: qPwp1YbBSbC1gZi9zRN+uQ==
X-CSE-MsgGUID: RAcZgSs7Q36t3J4ZrobBxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1052506"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1052506"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:37:09 -0700
X-CSE-ConnectionGUID: SnsipluKTpmDVW55p+0K9Q==
X-CSE-MsgGUID: iwHgLwSgS4Snp1GCRAP1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2675639"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:37:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:37:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:37:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rursEZWLFWsibPrxH20bq1HZVF5yFW8cCEpfajZ6q1E+hR7AWFTuIDBJUI8yeNDPjcfSVqSk4HFkdWWlaAYmrchtrYHaxtUedXRHSv7EbNUqRpX3vJVfzAADkH9lKpljZUXYmjcrEEIyXl4FnwFPeEmzXaCXf9OA+9r9+62nNwvGFJtVRk17ij+QdSgYUpt9D5sx+SDjAd/BfvkMyZttCo1+By4exOLabIf5UK3zNGpOA16W/Yx/Q+lzUbq4Fk/3v3nMrHcocAGSXrUqVR7tGfSEozmQrGQdj8MRIE0Wygxxi7eC+6kVB0NsLpdgHXVah/iZLzZa3dhYWcJ5Tk5BXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5404WjSGOUOp83DkJR16/Ba5BDOVu99UFp3q+O5TwMo=;
 b=gbnwknIGYlj9p1+jvHm1MQ89QpMQwyyTbLmJBwzI/lCYcW+XPLPFwYNvQfkj4bbMoZ7/HvQLquWTFAQbMdALoeGdv8UZ8VIgdOl9CRMtq3Z9BJjzakGWwqwd2DRYGduJM9HCWwebtUevs/jiClewDosWrZH9C2YsJrdux7H40QUzndsH4k1xKlmxM5utNB3PE6j6FrZnhG6vc1vHImA7+a64spBtL4j6s56uB6kH6qBbTmTlsvUaRt/rlJJFpNkq+MYsTrIUzBkf/0Q126cawxvtwwtSyqxKKAI+gzxUV4dVVxea68BbVD6W02KwWrglSrwdmFJFnwWjlKvXeG5Bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:37:06 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:37:06 +0000
Message-ID: <d060e196-2b05-433b-8d36-ef91aa3c0704@intel.com>
Date: Mon, 19 Oct 2026 16:37:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 06/14] ice: E822: keep Tx timestamps disabled
 during offset calibration
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-7-anthony.l.nguyen@intel.com>
 <179244084713.3135.15270894261694265167@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244084713.3135.15270894261694265167@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae2b227-1cce-4144-0ed4-08df2e39e282
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|4143699003|5023799004|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: tAR4DKmIM37BEnw1kBVOIN39b2kbsW1Q74DmhJYCUdfu8ZwYPVUQWf2MaJ5/A1GMA/sIQ8Ou1vVSTeaREj8GfGYwpmk1++7dN+RcecqMCMssyqOuqC95JXqP2AKdzlxOSbFtfihKPfevJqZzqrekfxXl7gpe1XgeV4FMXxOQdpUgxbgicvTmyVnT/HQktRJ2VyuzQZ0/+aFWURWGkbN9YCBOymby5weNSvJT0Es39B8UGRAczEg5mt239Lq8zRwvnIgk7K2VBOjPEeYcY2y8UuOjAt5r6PLZLHL+X5hoyf9QxqN+X3HDauGeXU0wY9QfqcTycftPmo0HLvr9jf1HXrkUwms+MbeYlP4QRCtjG2/VRsLCSs3PoZ27xOgbUOVGV64Oi0SoliCffaZB5FcNEX2YHBVQ3i65ifYaJRBc7XvbiDyQvFi0L0bWWjSJPT8mLDqX4hFvMiS/LELQ3aC5f0FPEeqRxkKaHXsdns+5KwPJWnmbuEY3f8hFhuySCxBb+NncT1pB48BxhP0KYOcxgvwekyn7nzDFVloge/wVO1U5sKgJiCDzidUG9BXTWU4QUGv4RvZpUPUDDsFuheSZHpAODR363nYg4xWhrUiB+WOX+E/fbupcivWpyct/jEVpFM0ESk6wjlih41l7doMquuK2FY5CiIrg/D8F8aZZwaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkh1ZmhQQ2syL0k3T0ZaLzJTS1RMV3gzSkdHUU1rTXlhUVR6cXVkd0JtazRu?=
 =?utf-8?B?Ni9RaWsvZm5ySnZueEJLaG16dlBiNFp3clRvSVlFdHZuRHB5RWlqcTNMQXhG?=
 =?utf-8?B?MlErWklWUjNEUzBOVkxyREZZM1VBUlIwWkRUbWNOSXBLSmlpVlBqSDZUSURL?=
 =?utf-8?B?RGJ3T1VPV0JzUmVlcnljVzdRRDBmcDJtaXNjbFo5emNHUEFkaG9xYlcvQURm?=
 =?utf-8?B?VHAxdDVwNEpsY0VIb1FPSlgwTUtrSVNhWXc3ZW5jZzJCN3BBeEZtamZNUjhZ?=
 =?utf-8?B?ZlJiZCs1R2RmWEIzU2MrZlVCYzBsQlp1bVg0NmtaMTl3MXE0WUtGM2FuVGh6?=
 =?utf-8?B?RlBNblZ5MVpha2FVd0dBcmdjMVd6WDRUd2JRdEo4Tm43UG1qcTVsUFpHZk1O?=
 =?utf-8?B?VmhKdFhDMlBuVFd4U3VzdllKS0NtcUYzU01GUjdpc2lMZ3lxOEdVQzZ4eGpl?=
 =?utf-8?B?ak9uRUVVMURIY0FjcmlmdSttZ1FLY2JuOUFLWkJPdWluRTF3alZ0ZFM0Nlow?=
 =?utf-8?B?YlY2d2dDYnVIYldGZ29ta2M0RytXdDJCQjNLMWc0eTRqc2swd0p0eTVvVDhp?=
 =?utf-8?B?aUM0ZTgxdGZoVmFpcnE0WnpYVW00OUFsUnYyVnpzWVFjbFZrMFp5eThFbTN1?=
 =?utf-8?B?eE9DRlhqKzFlY0lYK04zYThkajlLMXZPZG5DNWFidlBKdENEQy9jZmdrWk00?=
 =?utf-8?B?M1gvRnEwcnA4R2JnK2VNL09HcjBNckJRcU5VZ2drb1lManRnVUhpaWZmWi9x?=
 =?utf-8?B?SkxENE51YTEyTTVlUjBHNTk5aWhpSjRrM1lRVEZIMXFEVlRRb25DNDcvWjlW?=
 =?utf-8?B?Wk1xYkxaWTlPdFMrazhpMWt4cEtsano5MFJBcGdYZ3FYWHNLc3lKRllGUHdQ?=
 =?utf-8?B?S3g4Rm5JOU5qektoNjdQS0phL1N4eUNSYVNuMm9HbEdSM2lFcUx4dW1xNFVL?=
 =?utf-8?B?NmNiSjZVbVZNbzVBOEdBaFJ6L2dUWWxVeGp0TnZvYUg2ZE1OUUF2UEE2SlBK?=
 =?utf-8?B?dzlFTHgybHRpNUFkSEM3NUsreCt5a3FCZ2dKaE1ybVVrMnlrankwSmZRaGpE?=
 =?utf-8?B?ZitNVGhneUFUcS95M1BTVDRmMGxEUmtNcm9ISWZKdFR3MUxFUUtkaFJWRXhG?=
 =?utf-8?B?QXRuY0NwbnlEdHI2dVJwaDNwUEpwWDg2MWJLSXlISjlDMUpQamoyK3NvejdC?=
 =?utf-8?B?RXQvNUUyMVNSS3hSTjk2T0loeWxGbitScG02TWZwK2ZVTytqRldvaGd6clJj?=
 =?utf-8?B?ckxTajlycWtlYVF2WnN3M2tGZC92U1dBMkJuN1Zqd1BRUE5uRm96WUpJakw4?=
 =?utf-8?B?Q0hFYm1NUmVRZVROSXVZRnNGdzluaUZTeTFUZ1VKQlM1SVRQaDhhbUJxUkov?=
 =?utf-8?B?bjJ2ZExtQ3c3Z2FWZkZ5UkQ2WEN3NGcxMWdsSURjUzFEdFhpNU5ZQkhVOGdZ?=
 =?utf-8?B?VU9CMXJTYkNRd1BlUUxjOWpBQU03cU5Ycy9JQjBuQUpOc2JZRWFtcDNJMExJ?=
 =?utf-8?B?MWMxVnFvK3J2aWllYlgzS3lKeEJYOElaWi9zZmtXVTdNb3NsT0wrcHphbG1U?=
 =?utf-8?B?d2NlTDBLWVNIUENDOElzNUw2TXJ4V3NSQnJ5TTcvK1NaL1lyLzArdE9NU0xu?=
 =?utf-8?B?anZ5WGp2ejJ5SkpManNTY3pGRHplR1d2bmZOSXVOYXVOV045VlFrdFphbFJZ?=
 =?utf-8?B?TThydDVqZEtSMUxWbXBLM1g0Wjd3N2xETENyNEVEc3pESzV0S0dIMkgrRjVB?=
 =?utf-8?B?ZlE2aUhZRUl6WVk2c2xSdWVTN0pIeTZPMHM1cmtYakI1KytUT1hvNlRrTWUw?=
 =?utf-8?B?bXZndlR6Q1FHVTBvK2RWNE9xVWh2YjdlSGVIQ1haZGkzbGZQZUxINnJmSFFM?=
 =?utf-8?B?aFZNcWxrVHZaYVFsdGdMd2VhVHJQcjR6ZkRNRGxwRCsxUGV6bGdFMm40NGZI?=
 =?utf-8?B?VlhtVzdMWFphMCtEaWJWdWVTYVVZR1V5cGZrYWw0Nk0zVG9tYUNDSmdYV3do?=
 =?utf-8?B?V1hqcDljYldPZDgwa0c4YjA3YVp4VUNwY2pGTWlxUHJXVXA4K2kyUjRKYVpS?=
 =?utf-8?B?SUYwdEZQTG9UVmdaejJyeTM4SWp5SkE3N3F2elhYQTFqWnJabWF4Sk1teTUz?=
 =?utf-8?B?amNzeUk1d3ZTUkMyY2RHU3ZUK0krTFE5aTh4UzVRZHRxVmpmdy9TTm1Qb2pN?=
 =?utf-8?B?ZVFubXBIS1BjUTNyU1VlNmY4d0ZXQUVRb1FRcFFMdWllcnBlZVR4YXF6eGlO?=
 =?utf-8?B?d0p0ZDl4Y25STHRQWkJlZHBSMHVWZjhHRWtzbGg5NDVmNjFGMkJkNkNVcHpn?=
 =?utf-8?B?QVI5Zkpseng3VXd5SzRybGlDU0tnRGs5Q3g2cGE0NEZSc214VGlFdz09?=
X-Exchange-RoutingPolicyChecked: x/mxTwLhV1gSTBO6TsQ8b6Q84d/YRZJl7jfQPqplRtJp3I/htoIyJTd3p2oYfoS+DTDHqTB6zDqCkCaj2Mp9UKnAku/CjR9fBu3iYdwJU2maRWwvIcU9Ym+B9M0Mw3aMqtoSwj7UzVJmsbRWhjcTvd3MSzy7cG+z/+Wgd9sQXgo95T95tJ2QqNDjuJ4h1TzuK9v3RkVOHaI5qlT9TgEhbgK782u7cpQ+tSMdwxznIQvRqsvVgt5R+7e1s38GGbzWFiAPgfr0YkUCdrl1KsCIruW0Vt9Tv8xowecwnc32+zpwVeJ82MgAyGSxljILPTEOcAVXxKsjfY8jYCaHKQ6aFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae2b227-1cce-4144-0ed4-08df2e39e282
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:37:05.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6ATtn2XFG9Im6yOiGD6Gp42Li8TnPuDuHpm4IF3O8vOQoVW9XvRj6K6jKiebyA92tUe+zydXvs3iCxqIJgJkYheMsf8aXa9LIFPNGukGwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The kernel-doc for ice_ptp_tx::calibrating (ice_ptp.h:109-110)
>   still says "if true, the PHY is calibrating the Tx offset".
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   ice_ptp_settime64() leaves the E82x PHY offset-ready bits cleared with…
> 
> --
> 
> ice: E822: keep Tx timestamps disabled during offset calibration
> 
> ice_ptp_port_phy_restart() no longer clears tx.calibrating right after
> ice_start_phy_timer_e82x() succeeds. The flag is now cleared in
> ice_ptp_wait_for_offsets(), once ice_phy_cfg_tx_offset_e82x() has
> succeeded. The patch also adds debug messages for pending and completed
> offset calibration.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 776f211290eca..828d46a73f292 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -1283,11 +1301,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>>  		if (err)
>>  			break;
>>  
>> -		/* Enable Tx timestamps right away */
>> -		spin_lock_irqsave(&ptp_port->tx.lock, flags);
>> -		ptp_port->tx.calibrating = false;
>> -		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>> -
>> +		/* Do not clear calibrating flag here. Tx timestamp requests
>> +		 * remain disabled until ice_ptp_wait_for_offsets() has
>> +		 * verified that the Tx offset calibration has completed.
>> +		 */
>>  		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>>  					   0);
>>  		break;
> 
> [Severity: Medium]
> This is a pre-existing issue, and this patch did not introduce it. ov_work
> is the only thing that re-arms the E82x PHY offsets. Can
> ice_ptp_settime64() leave Tx and Rx timestamps invalid on every port if
> ice_ptp_lock() fails?
> 
> ice_ptp_settime64() clears the offset-ready bits first. It can then bail
> out before the PHYs are restarted:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_settime64() {
>     ...
> 	if (hw->mac_type == ICE_MAC_GENERIC) {
> 		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
> 		...
> 	}
> 
> 	if (!ice_ptp_lock(hw)) {
> 		err = -EBUSY;
> 		goto exit;
> 	}
>     ...
> 	if (hw->mac_type == ICE_MAC_GENERIC)
> 		ice_ptp_restart_all_phy(pf);
> exit:
>     ...
> }
> 
> ice_ptp_clear_phy_offset_ready_e82x() writes 0 to P_REG_TX_OR and
> P_REG_RX_OR on every port. ice_ptp_lock() polls the shared PFTSYN_SEM up
> to MAX_TRIES times, with usleep_range(5000, 6000) between polls, and then
> gives up. So this path can be hit if another function holds the semaphore
> for that long.
> 
> The goto skips ice_ptp_restart_all_phy(). That is the only route to
> ice_ptp_port_phy_restart(), and so the only way ov_work gets queued. If
> ov_work had already finished, nothing calls
> ice_phy_cfg_tx_offset_e82x() or ice_phy_cfg_rx_offset_e82x() again.
> 
> Would every Tx and Rx timestamp then be marked invalid and dropped by the
> ICE_PTP_TS_VALID checks? That would last until a link flap, a reset, or a
> later successful settime. tx.calibrating stays false the whole time, so
> Tx timestamp requests are still accepted.
> 
> Could the offset-ready clear move after the lock is taken, or could the
> error path still restart the PHYs? This still looks present at the end of
> the series.
> 

This is a pre-existing issue that I think should be addressed in a
different series, specifically we have some planned work around the
settime/adjtime flows that this would make sense to handle in.

>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
>> index 27ea502b75768..029ee4612d765 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
>> @@ -107,7 +107,7 @@ enum ice_tx_tstamp_work {
>>   * @len: length of the tstamps and in_use fields.
>>   * @init: if true, the tracker is initialized;
>>   * @calibrating: if true, the PHY is calibrating the Tx offset. During this
>> - *               window, timestamps are temporarily disabled.
>> + *               window, timestamp requests are disabled.
> 
> [Severity: Low]
> This isn't a bug, but is the first half of this kernel-doc still accurate
> after this patch?
> 
> On E822, ice_ptp_wait_for_offsets() is now the only place that clears the
> flag, so it can stay true while nothing is calibrating. Say link goes down
> before ice_phy_cfg_tx_offset_e82x() has succeeded. ice_ptp_port_phy_stop()
> then cancels ov_work and stops the PHY timer without touching the flag:
> 
> 	case ICE_MAC_GENERIC:
> 		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 
> 		err = ice_stop_phy_timer_e82x(hw, port, true);
> 		break;
> 
> Before this patch that could not happen, because the flag was cleared
> right after a successful start. The same is true when
> ice_start_phy_timer_e82x() fails: ice_ptp_port_phy_restart() breaks out
> with calibrating still set and no ov_work queued.
> 
> Later in the series, the E825 ice_ptp_port_phy_stop() path also sets
> calibrating to true on link-down. That moves the meaning further from
> this description.
> 
> This has no functional effect. The next ice_ptp_port_phy_restart() sets
> the flag again and requeues ov_work.
> 
> The flag now reads more like "Tx timestamp requests are blocked until the
> Tx offset has been configured" than "the PHY is calibrating". The
> "temporarily disable Tx timestamps while calibrating PHY offset" comment
> in ice_ptp_port_phy_restart() has the same mismatch.
> 
> Could both comments be updated to match the new behaviour?
> 

I can fix this if we need a respin.

>>   * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
>>   *                    bitmap register. If false, fall back to verifying new
>>   *                    timestamp values against previously cached copy.
> 

