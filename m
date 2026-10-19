Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792451678;
	b=O9prV5KhaHizfmA/ouspKN36hzzcqLOY9qGI/t+C+46t/uh79gUVsc6Av++TE2YxS33y
	 GLUi4SUSln98Ecg2r8bDj5tIVRozPNRsA24uZhNUOlS/M9TMn+MfdxLH3DaNKZLSrur7K
	 +c0vdKZl0kvdCkg2gzs/QJQvsV++YbnU7Ovvm5OfW8lGLE5DE9SVn1U26DltfVyZ0NO6c
	 ERKDq1fzvy+H6rXNRWlvdz8N/fJH1D0VOxNqgQlflZnsEfnqZmsH7YhypxNKRdzPvYhgc
	 rR1X4DRQ/vuJS7XPpMxcFKAZOPxRKtijKSzP6pDOdH1NVHqXe2Xz/nfwWvflRr/BLtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451678;
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
	bh=RT+8RoJ2GZO43PEd2BcpuSIjmLjG/JokRPR1+lW+lgQ=;
	b=Z5A6VxF3xdXzlj+t7btwKtv36v1SdPnnTQlfXykyC2OTDuBsdYudGpqiqfS5NQbqt1pp
	 E3T48NsETvfWysacK403JgfCTe8Q89T67XIqSFaNlsVc4IKkSwfxIWlgzXhEE1uV5JJfk
	 Yu/dkC0KcVDuq15mmCflApxXQGYJ0ziH9zm0iVbgKQkJYU8f9XYD6nqwQKp2A92xVnr10
	 yVxYrKcI7/w3mYIrr8tyjkCn+HuxalT+4KeZDr6MCm1kDQykRJk/Cx3tUa4Bdj5HQ2VOo
	 sBQWP5YovxO9y4E//kysEoYeNKQP+Z5G4qQ1LIduOuucdjHKNUYMw0yV1iDB/71iQ4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="hD/83ZUd";
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F3606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 703F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hD/83ZUd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792451678; x=1823987678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6VrJVxnw8RhekZp6gL11kFE7inluibEXcsNGOsWQoOg=;
  b=hD/83ZUdLqVDkwDphB6IXCJ74S4K1BQCcq6fNTpv/BtxFJsmkHQiJBzd
   tF2DwwA7TIOd+8gdqIDs9r2MFEXuwyFCmXjjaP3zNtISJskK3dmRUwtSJ
   YaBLg1vEGCRZT793jfoKE+zAk9bFdwcOdP8a8yfwjSwLB4i2JZiORv2Gk
   GU4ah7cDjReEXzUqvSsGfmd7h9X61k5kOtO/JQBhfhSrJNE6+2p8eKur/
   sd061alQecEcKkkPfBbOCOZ0ed2g2kIe/CgyjBLadtsu+7nOaPv8/X5fC
   FCPRB+FZPUnzvbRL3vdsWchOE7Q2ItVBQiTYZmIDH6IQSb4PvEo76neye
   w==;
X-CSE-ConnectionGUID: 5BnXKI8aShiF7hcnPqkGOA==
X-CSE-MsgGUID: e+tomV2sQYGXpqMxeJoerA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1157789"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1157789"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:14:37 -0700
X-CSE-ConnectionGUID: iYuTVVEvS/q88D1vcVBfig==
X-CSE-MsgGUID: IXkpE35DTw2ribF8BVLuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3066762"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:14:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:14:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:14:16 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzo9wX8KXN/ZuY/aZg/5AsddNz4hYhTrovoTxRPLCGHDPVP3nRc5ByAODHC6PGAN4V26R8XHP95e2+cIjBXyDd9+crd+gLoy8ndOhM28MYbr/qv3p+sU2osDjT/b73a1RO1HFMQjg73LjmcqjfpI9ruakrXY3iw/zGFY7jgncTuCeX6gfVpAoBwYUO50IGCpaldMYuswQ9ipOc+54gWRD1r2EvNx0CBB3c2bFZmgcn1AkvSqoRVmxm6NFxt0FXMOznqLv6rqPeXr/8txZz1MiP2WCAtj3sGZcN+jmp/QtnVCAUeAP0hM/Q+hi8Xo34blttwa8rLVBszJ74gp3SHQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RT+8RoJ2GZO43PEd2BcpuSIjmLjG/JokRPR1+lW+lgQ=;
 b=s0CMDlTUBx6zKc87kF70xZtjFr4jGBNeB+4Yx6uo8pMYMNvB11jPPYecXEAHn30ltgMx74StMxBDQgAxVhOXIFVKPM/xGer3db96laRxZqbTJ9oGYIGWyvQ1KN4XJMPJrkTQX0San8B1YwkLf0F30X7q/kL3caU/JOkf3mQRiwVvic0pLPzKWwTnsvlXBPtJk6IhC/mfaHS6efkhJUgUr3ePOrZbiU0fXpzGj9l3VxNcpFnF7jGWU6FyeNT4NjpDPBLh2v1ssvuBdBEQaCdSlEY7Ee1QD0vAIGJT+ZMphYbb2F2l7bEWFRsB35Btvgbc6MvqroFfd8/62loGrsY17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:14:14 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:14:14 +0000
Message-ID: <3d0aae24-4736-46ab-b90e-5647e6ba05c6@intel.com>
Date: Mon, 19 Oct 2026 16:14:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 01/14] ice: fix removal of PTP timestamp tracker
 during reset
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-2-anthony.l.nguyen@intel.com>
 <179244084072.3135.7212710300124211509@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244084072.3135.7212710300124211509@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b96e4f1-cd34-438e-3b98-08df2e36b0aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: SfjXH8W8Od0VLHTM4dL/uNJDDgovl8Zz7rEQN0HE2XpFZGnS197OKVejQzgAExBUoAkN2J3boF9sg5ElZw7bHwzfUXcFza7xqGkdQFTty2iEs4wlQpRzQsMmvSvKfzm3Ut2EU53qiP9oRcl2Sj2YlFV6bhmfo8nr0ROk6rDVqWoHXnxjStHJkXN/odfn6MGDoLDXGpBZLpCXkBYEBKPQ9wCoWoVmwQiigk2AYRlJelRCVmWxzUWM7JMKsWZdMlbVFUmSXwKRZsLBpph2bizLRIt+9iiIKgLTNb3apXFlPIbOemVLo4HKqDObESjsaMnXENUxKB+MPTbY83sJANZFv9Vn57jcXo9Q07yHXIxMGt5sxTLwgo3+XFEUfBBW3Ntf0hZ+77q35LNBGIasvVrPNiqfaPUnOZVL1ccO5+NRPU0dUlQAKdnTwm33EwEZAXGEdsOJ7nFZrVqtNKOADN7lvr9WWa7wgB2C5pmALzxQcvhAvAWZz+TeIFnS8rloI7J02oZNizMb73ABad8sXeO38NYzKxYSmHepm+OEUz9QDf38OwErkiqzdcDK5OZ/KsCev2rC7vM+ixR6FMT9D1th/ecLGolkxvf1q7pyE6dNdig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtIQWFIYi85ZUw0L0xnTDJ5aU1ZemY2Q0syRFZVUDJmMWIvZEtJQm5leUxr?=
 =?utf-8?B?bnpKUHIzcyt2L1dpaFZKRzBWeCtsYnhDOFc1aVdRazBRN1ZYbHk2YU1uSTZl?=
 =?utf-8?B?UkNDSXlabmxzZmtLN0tCWi9BUUZnQnpycmxRQ1JZL0NTZXNtUHZzL1hhUUtQ?=
 =?utf-8?B?cGd1amNER2VyTXhLUDc1RE43VjJzUytyL1Ixci9NQjlEeUFMeG56R0trL2Qv?=
 =?utf-8?B?NWpoOHZteG1NWHVUY2NRcHA0V2ZONlpQRk5NWWtEZURTNms0Q3ZOMjk4T0hX?=
 =?utf-8?B?RmREL0pjZ3ZsQzl1dDdlNzlWNjZOK1BWeEdNUEQ0UE5oOUtYWUlCekpOZDU4?=
 =?utf-8?B?Ly9vUExXNGhhMzdmWVNKbUIwZm5DZ3Ywdit1VmtHaVJ1MHZOZTJNZTJvQ0xj?=
 =?utf-8?B?cnN2cXZyRGdyMmR3RDU4VG1Zb25zRUJsSmtLSlZiWEZyOUVuYnF1djBHcHVu?=
 =?utf-8?B?U0VjTkY1RC94T3ZsUm82MlNyQXV6cGs4SWNlVFJKbERxei9vUXhML2x3K1cx?=
 =?utf-8?B?V0hhRDFnU0l4MFBkemV3NlJHUWhwbW5IQ1FHZWl6Q0dIaWRBbkVIZHlrV1hz?=
 =?utf-8?B?SmY4NG5GT3lZMllqTG0vQUdkTHNlNEZqcFhsaHRvQ2NtQkMwTE94UGNQRkx5?=
 =?utf-8?B?SFE5a0N3aEg5RHEwdkkrNndJejJEVC9STnVFTkxlR0JmNFJzaEFkUm5XQzl0?=
 =?utf-8?B?TGpwcVM5ZUtsRk90OExleW02aWduZC91Um1xeDZUczdTL2gwd3ltbjltZTNW?=
 =?utf-8?B?cTFlU2FuZVI2Y2UxMVBxU0h5SHhmQ002aThtSENFVUl6eXVkNmlWRytybFRH?=
 =?utf-8?B?OHU0MzVxTTNpb3dJOWNsSzRpOFJxREFuOXUwLzdGdHl2NmpUTUxObHpsa2ww?=
 =?utf-8?B?YWtwZWJhREcyVXRmSTNKa2drelpVQzFtcFBtaDZPVE9xTjR6VE4yNFNMUWl2?=
 =?utf-8?B?YXJodk9jNEVLQU9NeXRsbUdjZGxGaTFQcEhWMHRTTS9oVDdmMURVODdkVkZq?=
 =?utf-8?B?M2dvVElyeXVhUENiSGs4UFZxV08xaHozT2xsVTJEdG1XN1RjWUVxREtGQkF0?=
 =?utf-8?B?ZVRGakFUWjBBWTltWlFFYStBWDdQREVkQ2Eyd1oyVHdyK0RBdzdlL3dCSFNR?=
 =?utf-8?B?eWovTlM2N2RBcUd4QnBPVWFJTHZ1M1lpTnZadDZBaEtkdkhwWk1INlZTemhO?=
 =?utf-8?B?S1IvVnhuUWhrRDhGZXh1aDdNcC9zYWNJcVIyNWMxV3gvaWZSUEZkTVl6STNq?=
 =?utf-8?B?Vk1ESS8yUytxQ0dETXVHSk44YUEwOWwvckFYS0txdFh3bU95enVSZFN3RDVX?=
 =?utf-8?B?WjVZUDZpKzBoQlkyaXg2ZGcvQjVpNlorUUZFWkxzb3BJcEltSCtEbG5UZ1RW?=
 =?utf-8?B?bURjK3MwRHlGekdoVUpOeVczUDBMTHlkaG1KUE9JWGd3QTRjUGhhcy91aGI1?=
 =?utf-8?B?RDBrWTN6R3dsUmN2TnUzRGl2c29MZVdWR1RERlU0V0ZhVC9yVGtHaE9IalBp?=
 =?utf-8?B?YVZBQUhqblZ6Rmx3Z1B5N3hxN3pzcjBXNjRxRkd4SnRZbWl6dENGM2ZLcVds?=
 =?utf-8?B?YjRXenJlc1VQV09rdDJKQ2I2Wmk3c01rdTMvZVpUZHJhbGI0dndFNlk5VDVn?=
 =?utf-8?B?M0RSMkQxY2lDeXFkYm90eUsyRzM3c1hGT0c4YXl6ZFVxemEzcnpsSzUxQUQy?=
 =?utf-8?B?UmM4NThPdGR5OVh5eW8yZ2VoVHJWUzBxcVVRWVlRcjJacGttZnpxbXAweVNW?=
 =?utf-8?B?U2x2REtYMXhreWw4TXc4bDNhMVVNQ1NWSzRadVJTQUxaVUlhNGp4WmhpZDZs?=
 =?utf-8?B?aXRRSzBZMHVtM1BxVkRqNHQzNzRScXlIRDlvWVc4d3RZKzJ5RnRGL2VzU3pa?=
 =?utf-8?B?Q3VGbWZiNXM1RzF4eFYxYTdLWXRTbWIvV25pcVV4OEV4cnhFcjdlclRqS3pJ?=
 =?utf-8?B?UmZkRnlVeGpleDBSQ2lEbWtLS2Z5VFRKalRGdGl6Y2pRZW9HeHN3VHNmd0Nu?=
 =?utf-8?B?Y0E3UlFWWE04c2ZjT2w3U1lQWnNIdVhSaXlTbW9zUW1Ha0YvTUd2aGpMT3VC?=
 =?utf-8?B?VEVYSDdnbFA2VURWSjhoeFNUYlBVaDNYTzJTKzV4dmozS2Q1aXV1QTB4WDlk?=
 =?utf-8?B?eGVIdUVnRHdtQ1NoRlJZNTVtTko5UVNUT0I1VUcrMk1JRldLTDg2VFlFQzZQ?=
 =?utf-8?B?VE1UVlBnRlFFbmdYRW9iTEVVN3Zod2NKTGpvUW5EMmM3WjZacGg1VUVBY1Vq?=
 =?utf-8?B?QStZdXRHRy9JU2ZTalpjSVBUYkpWKzVMd0ZhV3JtUDJsUkxIcXZiTWs3cGNr?=
 =?utf-8?B?dFV1UEpFRWczNEU2M1docUZNbGRTb285TDRHbmhwejVEUjRDNWJmdz09?=
X-Exchange-RoutingPolicyChecked: c6W6MXbLi6Dlh3D6L0ZeWsJJPzZ7WfgeHRBUXDYKJ9Ac7gSVu5LiEM8NcYdlJL3tWzIBJdEnL4B6IXsC9gCZfq7YX9KxSP/4xoHwYsswew0yTt5HoCzs1AWLfrIPNyxN0MNSBtLDDUdjJSjthB3cLWYVoj1oCRHnLCkSbDcngLiv4jH71YP2KZtbqqti6KTZ8ycBaonm4KWu7yKiQz6dZ6bxEYjq1/gTIuFGI3RbBTCgYfHjPgD9YGOgzTDXnRNwQP1/fiE3Qp3AuP1ApCPhHWPcj/FEK4LEjCikYouzEauFBzgwIgQhzF53aN7z31aMMzG9C8TVjDhHeDPv+wEE2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b96e4f1-cd34-438e-3b98-08df2e36b0aa
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:14:13.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeEsVSe7pKKuBjUlkk2VcogalZJDcwM9Zf+7MkfiiTGkJO9/HMYkGNZxMzBNK0IZ+hTjcd+2q8uNpD6W3tS3uXfbM8YbhaivU4DqC3mfjrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (2) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] On the clock owner, ice_ptp_init_owner() ->
>   ice_ptp_create_clock() registers the PHC (/dev/ptpN) before the…
> - [Medium] Because the E810 tracker is now kept across CORE/GLOBAL/EMP
>   reset, the per-slot tx->tstamps[idx].cached_tstamp values survive the…
> 

I do believe both of these are "real" issues that need to be addressed
but it does not make sense to address them in this series, and I have
them on a list of follow up fixes. The clock owner issue is truely a
pre-existing issue (we should not be registering the PTP clock device so
early) and the E810 issue in a sense is pre-existing even if this
particular pathway to it is new.

> Pre-existing issues:
> - [High] ice_ptp_setup_adapter() sets `pf->adapter->ctrl_pf = pf` for the
>   clock-owner PF, and nothing ever clears it: not in the ice_ptp_init()…
> - [High] At this commit the clock owner walks pf->adapter->ports.ports
>   without adapter->ports.lock in ice_ptp_flush_all_tx_tracker(),…
> 
> --
> 
> ice: fix removal of PTP timestamp tracker during reset
> 
> This patch stops ice_ptp_prepare_for_reset() from releasing the Tx
> timestamp tracker, so timestamping can resume after a CORE, GLOBAL or EMP
> reset. It also reorders ice_ptp_init() so the kworker and tracker are
> created before the port is added to the adapter port list. Finally, it
> makes ice_ptp_release() do a full cleanup when PTP is not in the READY
> state.
> 
> Closes: https://sashiko.dev/#/patchset/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858%40intel.com?part=8
> Closes: https://lore.kernel.org/netdev/20260916011213.1632286-1-kuba@kernel.org/
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index eaec36ab6ae3f..e1c66cd0f94ff 100644
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
> The tracker is now kept across CORE/GLOBAL/EMP reset. On E810, does that
> leave the per-slot tx->tstamps[idx].cached_tstamp values out of sync with
> the hardware?
> 
> During rebuild, the call chain is
> ice_ptp_rebuild_owner()->ice_ptp_flush_all_tx_tracker()->
> ice_ptp_flush_tx_tracker(). E810 reports every slot ready and
> hw->reset_ongoing has already been cleared, so every in_use slot is
> cleared in hardware:
> 
> 	if (!hw->reset_ongoing && (tstamp_ready & BIT_ULL(phy_idx)))
> 		ice_clear_phy_tstamp(hw, tx->block, phy_idx);
> 
> ice_clear_phy_tstamp_e810() writes 0 to both halves of the slot. The
> flush only clears skb, in_use and stale, so cached_tstamp keeps its old
> non-zero value.
> 
> E810 has no ready bitmap. It detects a new capture by comparing the
> register with cached_tstamp. If the slot is reused and read before the
> new capture lands, the register reads 0, which does not match the cache.
> 
> In ice_ptp_process_tx_tstamp() the "not yet captured" check is then
> skipped:
> 
> 		if (!drop_ts && !tx->has_ready_bitmap &&
> 		    raw_tstamp == tx->tstamps[idx].cached_tstamp)
> 			continue;
> 
> 		/* Discard any timestamp value without the valid bit set */
> 		if (!(raw_tstamp & ICE_PTP_TS_VALID))
> 			drop_ts = true;
> 
> so the request is dropped without a timestamp.
> 
> ice_ptp_complete_tx_single_tstamp() has no valid bit check:
> 
> 	if (raw_tstamp == tx->tstamps[idx].cached_tstamp)
> 		return;
> 
> 	tx->tstamps[idx].cached_tstamp = raw_tstamp;
> 
> Is 0 then taken as a fresh capture, extended through
> ice_ptp_extend_40b_ts(), and delivered to the socket as a bogus Tx
> timestamp?
> 
> Before this patch, and before 7a25fe5cd5fb, the tracker was either
> freed or reallocated zeroed, so the cache and the hardware matched.
> Should the flush also reset cached_tstamp?
> 

This is an issue in the E810 flush pathway, and I don't think it should
be considered as a new issue that blocks this series.

> [ ... ]
> 
>> @@ -3347,13 +3346,17 @@ void ice_ptp_init(struct ice_pf *pf)
>>  		}
>>  	}
>>  
>> -	err = ice_ptp_setup_pf(pf);
>> +	err = ice_ptp_init_work(pf, ptp);
>>  	if (err)
>>  		goto err_exit;
>>  
>>  	err = ice_ptp_init_port(pf, &ptp->port);
>>  	if (err)
>> -		goto err_clean_pf;
>> +		goto err_release_kworker;
>> +
>> +	err = ice_ptp_setup_pf(pf);
>> +	if (err)
>> +		goto err_release_tx_tracker;
> 
> [ ... ]
> 
>> -err_clean_pf:
>> +err_release_tx_tracker:
>> +	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
>> +err_release_kworker:
>> +	kthread_cancel_delayed_work_sync(&ptp->work);
>> +	kthread_destroy_worker(ptp->kworker);
>> +	ptp->kworker = NULL;
>>  	mutex_destroy(&ptp->port.ps_lock);
>> -	ice_ptp_cleanup_pf(pf);
>>  err_exit:
>>  	/* If we registered a PTP clock, release it */
>>  	if (pf->ptp.clock) {
> 
> [Severity: High]
> On the clock owner, ice_ptp_init_owner()->ice_ptp_create_clock() has
> already registered the PHC before ice_ptp_init_work() and
> ice_ptp_init_port() run. If ice_ptp_init_port() fails (for example with
> -ENOMEM from ice_ptp_alloc_tx_tracker()), this unwind destroys the worker
> and sets ptp->kworker to NULL. Only after that does err_exit call
> ptp_clock_unregister().
> 
> Can a concurrent clock_settime() or clock_adjtime() on /dev/ptpN reach
> the driver in that window? ice_ptp_settime64() and ice_ptp_adjtime() call
> ice_ptp_reset_cached_phctime() without any state check:
> 
> ice_ptp_reset_cached_phctime() {
>     ...
> 	err = ice_ptp_update_cached_phctime(pf);
> 	if (err) {
> 		...
> 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
> 					   msecs_to_jiffies(10));
> 	}
>     ...
> }
> 
> That branch runs whenever ICE_CFG_BUSY is already held, for example by a
> second concurrent settime or adjtime.
> 
> If this lands after ptp->kworker = NULL, is it a NULL pointer
> dereference?
> 
> If it lands between kthread_cancel_delayed_work_sync() and
> kthread_destroy_worker(), does it re-arm the delayed work timer on a
> worker that is then freed? The timer callback would later touch the
> freed worker.
> 
> ice_ptp_mark_tx_tracker_stale() also runs bitmap_or() on tx->stale
> without checking tx->init. Could it race with
> ice_ptp_release_tx_tracker() freeing the bitmaps when coming from
> err_release_tx_tracker?
> 
> The new non-READY branch of ice_ptp_release() unregisters the clock
> first. Should this error path use the same order?
> 
> The same ordering is still present in two other places. On the success
> path the PHC is registered before ice_ptp_init_work() creates the
> kworker. The READY branch of ice_ptp_release() still destroys the kworker
> before ptp_clock_unregister().
> 
> The later patch "ice: use reference counting and SRCU for PTP port
> access" adds a tx->init check to ice_ptp_mark_tx_tracker_stale(). It
> does not change the kworker vs. unregister ordering.
> 

The ordering of PTP clock registration pre-exists these changes and is a
problem regardless of this series. I think this should not be considered
something that blocks this series, and is on my list of things to follow
up fixes for.

>> @@ -3399,12 +3405,22 @@ void ice_ptp_release(struct ice_pf *pf)
>>  		return;
>>  
>>  	if (pf->ptp.state != ICE_PTP_READY) {
>> -		mutex_destroy(&pf->ptp.port.ps_lock);
>> -		ice_ptp_cleanup_pf(pf);
>>  		if (pf->ptp.clock) {
>>  			ptp_clock_unregister(pf->ptp.clock);
>>  			pf->ptp.clock = NULL;
>>  		}
>> +		ice_ptp_cleanup_pf(pf);
>> +		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> 
> [Severity: High]
> This is a pre-existing issue, but at this commit the clock owner walks
> pf->adapter->ports.ports without adapter->ports.lock in
> ice_ptp_flush_all_tx_tracker(), ice_ptp_restart_all_phy() and
> ice_ptp_prepare_rebuild_sec():
> 
> 	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
> 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
> 
> A peer PF's ice_ptp_cleanup_pf() removes its node under ports.lock. This
> path then frees that peer's Tx tracker, kworker and ps_lock. Nothing
> waits for the unlocked walkers, so can the owner still be using the
> peer's port memory after it is freed?
> 
> The later patch in this series, "ice: use reference counting and SRCU
> for PTP port access", seems to fix this. It converts these walkers to
> SRCU with kref_get_unless_zero(), and ice_ptp_cleanup_pf() waits for
> readers to drain before the tracker and kworker are freed.
> 

We have an independent patch series with a developer investigating
ctrl_pf so this should not block this series.

>> +		if (pf->ptp.kworker) {
>> +			kthread_cancel_delayed_work_sync(&pf->ptp.work);
>> +			if (pf->hw.mac_type == ICE_MAC_GENERIC)
>> +				kthread_cancel_delayed_work_sync(&pf->ptp.port.ov_work);
>> +			kthread_destroy_worker(pf->ptp.kworker);
>> +			pf->ptp.kworker = NULL;
>> +		}
>> +		mutex_destroy(&pf->ptp.port.ps_lock);
>> +
>> +		pf->ptp.state = ICE_PTP_UNINIT;
>> +		return;
>>  	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but adapter->ctrl_pf is never
> cleared. ice_ptp_setup_adapter() sets it for the clock owner:
> 
> static void ice_ptp_setup_adapter(struct ice_pf *pf)
> {
> 	pf->adapter->ctrl_pf = pf;
> }
> 
> Neither branch of ice_ptp_release() resets it, and neither does the
> ice_ptp_init() error path.
> 
> The ice_adapter is shared and refcounted across all PFs of the device.
> The owner's ice_pf is freed when that PF unbinds. If only the owner PF is
> unbound (for example through sysfs for VFIO passthrough) and the other
> PFs stay bound, is adapter->ctrl_pf left pointing at freed memory?
> 
> Any user could then reach it by running ethtool -T on a remaining PF:
> 
> ice_get_ts_info()
>   ice_ptp_clock_index()
>     ice_get_ctrl_ptp()        <- &freed_pf->ptp
>     ptp_clock_index(ctrl_ptp->clock)
> 
> Other users of the pointer are ice_ptp_setup_pf() on re-init and the
> ice_txclk.c paths, which take ctrl_pf->dplls.lock and touch
> ctrl_pf->ptp.tx_refclks. This is still unchanged at the end of the
> series.
> 

Similarly, this should not block this series as it is independent and
pre-existing, and we have a developer working on a solution.
