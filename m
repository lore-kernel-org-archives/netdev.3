Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792454765;
	b=ovEz3IgkyIirc6vy32ozbgfuZAD1PHzpOnaFFNGepKcmYQvy4naC4dqJjnXbB+biP/lH
	 LWfXWvj6e5tuA3/ZW7q0XMkKcnqNUmoXd5hIm21K5C/uq6V6HvCQCXTH5gkDqs4voGgNG
	 UPQ/37msUq7/WCzr3YtQu9ardw/yMMAbUXbEA0+rElnugLTHOKUctyoGkHJxcrodz+7rq
	 U6PNVPi8t6vjp2ugVkp1cfInkqPi5v4ZhxV/0tCQZYCWlzpKwevuXDvROCyzWfyCefQAK
	 XIgTMmfbtjukBEP1Fp2EtbFKwLyTkxACiE6qMdyHtZMYDBX5um0c+NBIqNXW4w+ijZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454765;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=VQeXwLeQg6ZYwx8d20UDlEc/v5DwCx7t12A78mAJ1qg=;
	b=3zoNNNp2P8YZ/XnvLqtEVZCs7k8qQKyacLMywJGd/QiUYl9Go3q7RJ5VNwhL3XhK6xxg
	 pH4vwB3kzD43/VQLSADX0DHidTppMhwi9ECzqL+sUME/tYh83uV068muMZw4VKqldY34+
	 brt6irAZS0w9d1LPxzqOH7pH3XMT7lGVGTU9obdk9vIWTADYtnK5JijEEpzpbvPenvlwY
	 GoU0HckrKkN59LnDLEap7eJVlJsDF3Ywc2yw0Mbjesey5iRXThyScIoN94WtRL3qphArf
	 CpE/s1ttsZMWPcsUXjvSDnkHpucA22OVGCEIKiJKtPNL38+ODQYsiiRJ23k+vqZ6fOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dr4K7nhZ;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A488606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A488606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dr4K7nhZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792454763; x=1823990763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bI2RYlfMBAoEicfJLyzI+pBwvgFrXPU3w7Y07BLDBXU=;
  b=dr4K7nhZ0nu74JSEfdKgH3Lypkhy4UyBUpcOj9ud/jvrunNplh1d1s39
   6G1QFKQiwHF4RnfWnduE4I4DV4lBJmrRYM3rVv4cYeDc+z3yvCHDHobcY
   x/5RrJuQCHffTA/qKbHBicvXalwEscpYHc6vupApS/r9G9fIoUfEZ6ff2
   a8FxyadbMos0rfhJqlaSJvBxf2FDhw/cJYa6xidOgHZLZbh8F2x3hujHX
   rgQRrKT/JhPNLhR1wujTcE9sVGNahdIo2Wuo7kp1g766rPmebj9Amq5Tb
   JFRFj2VL3k34vy7OSLItwiHr1ZhFmTgo9VVVaE5v++fDNYmpUQ0VuE/jh
   A==;
X-CSE-ConnectionGUID: nCskeQPqTYG6z5P/s20Img==
X-CSE-MsgGUID: oPsygLf9S0KHk46TFaMSZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1053828"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1053828"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 17:05:56 -0700
X-CSE-ConnectionGUID: f0/qQYNJQhuS1tNF720NMg==
X-CSE-MsgGUID: 4hZHE6hOTjG29tGSFSxuPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2640843"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 17:05:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 17:05:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 17:05:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 17:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECb1IVUUioSZN/tupJUmSWCe44Bx0OqmhnpYfz+jyWT1zxhWL5FiB636nvI8VTRxwQw+EW1yiMGex/cecLRKon4EawiS2ifYAy09lZ8iY4RzAJqOsoFgeJp14Qv2HBSV30ZHCfLg3NX0HvdqjzGOyMFX64+KqIhQDAlgWTBrFBHeF8sTf49ZRcyq4dZTaIu/b+dOUPsLbyk0rshUc8X8D+s1NuuDa6+thpHoTSjoC2zBT4+3vnSp43N8Lf51lXf4q5k7cMUwxdbel6cIk+sRjFVvDR944GhXonkscQL4/+jO2GGpfbsUOJG15dfARU9jjTNAcieQ8BK9k0tPCEiBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQeXwLeQg6ZYwx8d20UDlEc/v5DwCx7t12A78mAJ1qg=;
 b=EpnU2MMlBc1GXD9khz6LIBdjJHeOyu+yHJ5JrzpRzB+3Pn81zPTEXI1gZrlsK6quRGcw34IwA2UA18Au7uom43uVV+0LwP6kCJ6bnbzL71Yvt4EFcmfQD65pdQwQCKkl69kHtrGc1fF6MwdtKA0tWdBagCLWFLG6qJpkJzOYskHu5uKCN86Cej7KvmJWOszawOPMqHH36Z0MZU8mRaJJRHRoGHEcr42andeVzjHQwOyxP5eyVOBPPG3W5Vngody48iBS0SwOk9YNiqGnRhl9w7FcPiQ6xcY+kOP4AtYhh1L4b+NeAv1oV3OFY9/Nfgff5uZ14q/yGE2N6kvMa3Et1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by IA1PR11MB7343.namprd11.prod.outlook.com (2603:10b6:208:424::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:05:44 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:05:44 +0000
Message-ID: <879b8b42-403b-4f07-8fb0-d4c599d55435@intel.com>
Date: Mon, 19 Oct 2026 17:05:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 11/14] ice: wait for in-flight Tx timestamps before
 removing the tracker
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-12-anthony.l.nguyen@intel.com>
 <179244085491.3135.8474994286741014334@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179244085491.3135.8474994286741014334@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|IA1PR11MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bfda3e-80cd-4bbf-5e5c-08df2e3de2a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|4143699003|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mg9jS7ASLvkIeEyh7yfbTlY2S9GnwYRYgITCLyj7pfqf0BQjVYM5PwadGLC5ggZtBx/jq+7MgcZLwpky8feGnt4fo5hE7EmSRHyj4tyWpyBACq7PWgnY7Tu0wzcpLhr1IeiaxiCJxcjAHgkOnqAFw7+VxUpoSroAU8An4ucLktncFS4Fwbdf5naHv1cVCKcrnc8xiWrGG+ZylIsf3q8dNxmU88XnINj2cRr7RLgK6+Vx9PJfs1Wz6fh7/+bXVK9p64RqfCoZ8TTguZfZlKBDajJ+pe0BPsdDHGS28BC8WEdrBtfeGuyjHoDC8ZJ+EKMmWVaZmCi19KmsaCTxtwZS9dhnruVnxnF2qYyqmyZDGDbI66vkV2ZWk1p70ZjA4g4tf9m2OfhM1nJ7WzCrC5sEo7HJD/j2bfk3sOuxqT2QAMa4Ds2A4E6hLn59xF6s2k/gayg9m+7nxOglptvlBbAnLrwwggconsDuHLVq6+TK0Qot13A6/elLnilu/+rpSWJ88X66tGRGxB9Stoqys9KmCnI/pZfeRC9JOkD8mwLx3Vbxh+IKJnA2iqZ5qNyxO4277Lp5JFKrKHBwACh+WYOo6/oTUqvxnBinpIqrZI9RG9J7RRec7eJEp1K4UagS+d3Xh6vBkUc+jhkUiBuyH/8g+ez+MbyeTPOKXoV/TRyCWbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZEdXZ2T1FBUzFVeDMwbHI0Q3RvUTNKVkU2ZE4rcWpzUTlWV1VTRDV2ZlBW?=
 =?utf-8?B?R0VFU0JqajNQbGFUUzVLd0Qya2VVcHhiekdYbzJJenNsYTZFUUFsTVhFdm0y?=
 =?utf-8?B?Y3RBdHRjZUtoZEw2RDRNYnYzamVyMVQ4UzhEckFKbWVaVTdhL0c2bG9pQzBx?=
 =?utf-8?B?TFhkcEo2SEFvQXZZM0lSOElybjRhcWpBdjQ0elZOR2tMM1NnUk00cjMzNVdp?=
 =?utf-8?B?NVFJaVdPN0J1QnM2Rlp1akp1MVFIejM0eWx1MTdTL2lZV0xQcUhWZkVCdkVi?=
 =?utf-8?B?blRFekNUVjJzOCt2RWxXUWVoaTJyUXUrTWVnaXpKVGx5OXVTWC8vSzRlZzNj?=
 =?utf-8?B?RTFObndWNWlQRGZUQ1c3bWtVYzRPc0dRS0ZWTEpydEk3cWZDYVQrTnhiODh3?=
 =?utf-8?B?OE84eENOY3VVYUdRUDVLMjNSZXhLOXhiOUhYRENWTzBvZjVzV1dyM3EvaVF0?=
 =?utf-8?B?R2JkRHZqWVYxdFZsOW5YaHg3QWlJelRWeU5YV0h6QmRxVVh3YXhGSXlaM3RO?=
 =?utf-8?B?Q3JjcWw3a1h3OHpGSEI3dm5FcGFVUU5vZWtqUCtVL09ySGtmd0Yzczdvci9S?=
 =?utf-8?B?dm5MMEtYbVFXUC9rOEhHMEc5NU9rWko0eDFFVW9MZ0lXMjhZUmtvajBVL2Jy?=
 =?utf-8?B?Y09iTlNZMkRCQ0p3cG1oTDgxSTlSM3FKeGtDYzQxOXBKNGgvVG5RbW12UDUw?=
 =?utf-8?B?ckVGbWVqamF4d1hnUnZoNXpPbWh3Wkk4SkMwOHdIbSt1NVhLY3pLc2lSNnlK?=
 =?utf-8?B?b2NyWmMzbytyQlFwWXRVSlRTUE5WaStHZzFuL2UvU1Mvc0N4WUdHMXlxRTlQ?=
 =?utf-8?B?MWlkbDJvYVVKanNtZXVwSmw3cHY1SzJTc09iZVI1OUtaWUVFTnMwb01LT1h0?=
 =?utf-8?B?NlMwZHRhaWhPdktLeXgvVUJMaStBSjd2ajBXMlN5dlYzdlNCQXAwSE5xbThh?=
 =?utf-8?B?VWdORzdOSCtCTzNjRmlLZnVEc2RDS0gyUlBFdkI2MzAwMlI2LzdzQVJodGtF?=
 =?utf-8?B?WUovTjg5Q3FOWDl3OGxzQlhRUmI1eFgrS0ZaSDBHdjRqQzc0VERsbVpYSTRl?=
 =?utf-8?B?S3c1QWhUczlUUlJJRW5aR1JzRVYya3lTUFVacmc5OHFtenFCSnlwVHpSWWRo?=
 =?utf-8?B?OFh6Y3JjbnRVOVBacnR3aVp2bTJwN0xVYmV6QUFZN3lGVW5KTXVGS2p3WjV3?=
 =?utf-8?B?M3JOQ3NuK2gyeTJhUW43UjlUWjRHQjkyRVBBa0tuNGFXUmE5dW4wdG5pSWg2?=
 =?utf-8?B?UTRCT1JyQm12aWtyenpTS3pMV3lDZmxZZ2VqOXNLT3BFYlNCaHEzaHJFbkN0?=
 =?utf-8?B?Y253b1dOWSs0Wm1YUkJ2VUdEbEQ0KytCOVJQWFFzRmNCQzFxdXNMcWZnUm5O?=
 =?utf-8?B?ejJnc0YxazdKNTkxUGpMY2hoUVRTbW1nSFhPaWdMNW0wLzkzcjd3Y2dsMktH?=
 =?utf-8?B?RnVlTy9qb3FOOWpGMHFySEs5WVN6M2hlL2RmdjNGQk1ZSklOWnlnNXhERGxH?=
 =?utf-8?B?RmMrZG9xWFgyVWxMV2hkcFFzMk8zbG53Mk5LaFZRTXF4czUwek5aSXlxQThC?=
 =?utf-8?B?SDU1ckdWY0FXMFU5YWlHbjYyZTJBU1NJd29iK0hWMDRDcVBRVitDNzYzaGpF?=
 =?utf-8?B?aGpiL3k0TC9valliaGJkYU5ZOXBHcU1NcGNuSGdEVkh3OFNvaXVKRzZpRkdK?=
 =?utf-8?B?VEh2LzY1SGsyVTJaMEVrSnlZWk13N1pkUW1tem5IVU5oSmVGL1Zrd0lVUFYv?=
 =?utf-8?B?VkJSREdETStDOFdadXQra2xEeDc0cUs2M2hHdWZvTGxRcTF3MWZFbGNBYSti?=
 =?utf-8?B?VGFuWUVXZFM4TVYvakw4V0RDeWhlSjZ2a251a3JKT2U5dit2dGZDVmQrY0Ni?=
 =?utf-8?B?bm1lZE1HdU5iWDRyZHpmbDZ0MExVMzc0SGl6L1l3aXhtL1lmZzVPM3k2Q1RK?=
 =?utf-8?B?TG91cjRya3VIOVkwUk1yN2tRbDIvUk14QVFzc2N6dG53S0tPdWFxQldjb0ZC?=
 =?utf-8?B?WThydklud3doNlZ5dnNBdVFQZTdZT25TL1VEN1l5cXExV1YxV2NvSlpFdFZP?=
 =?utf-8?B?OUw0WEZNazJsZWJwdjRPVkE2NlBnNWhwVUpVQ3Fzb3ZQR3FaU2ZQblBLTjRw?=
 =?utf-8?B?ang1RHRMdWpWR21qbEJ4bGRvelJvY3cvUVB5bUxhYVJ1eHBJMUFmUWNtUDVL?=
 =?utf-8?B?K2JMMFdNYmFxRTNXaEd2UEdJQU1ad0hSaHJEY3FHNldIVjlkaWFNNmR6ODRj?=
 =?utf-8?B?Njg3bVRyK0FISisyeXFPdEVKV1FUNUdyTTI2cVFWNFJCL0Ivc05CY0pNeVJD?=
 =?utf-8?B?bFpQZWRkQzZpSE8xSVM3QzRKcEp1Sjl6WU1tMXRJV28xK0FkTDJBUT09?=
X-Exchange-RoutingPolicyChecked: P1Og3LYnmHltzK2J6kHQGJrcjxDnkCwldZ5ZF1mMeE/ek5VtmYbt1Pqp6NTy8JzcjOTaN32vNLWrcx9nd5Mq8QmSTP8U1MFq/2CJsJi9KuOi0P74ZOX65GsJ0R6AUz8b4pfqGykvhSpOepnccGXB4LgP4D+nJpLdeAVtL5t2HN9ZBSQATm4MBSblvuvlvANN77naJPRuJHC1u7tUVB721tkkLOddH6GSqhpeB5yTNg3xljhzx/Nb+wAVQZ8UWG2Vnp81aS9sEb/WGreWmFW5ol2KOztkSOkU5wbjZmLdHTfnY13WMxzCWqlkb+L4jtZ4W9A1BqdN/sIQwWFwRhvhQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bfda3e-80cd-4bbf-5e5c-08df2e3de2a8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 00:05:44.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmURsBY3DtKmvAoEla6z/TBMB2aEq7XCCE7jXFAABKrQYenPXhhr0GfIq2Fc8IxKrMH6Xf2na4PwQQZWi/8EQG7KhJ2j9BdV6BPhUfYGEQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7343
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] On E830, the new drain wait runs, but the flush that follows
>   cannot clear the ready entries it waited for.
> - [Medium] The tracker is released while the PF's Tx path is still live,
>   and the new drain wait gives up after 10 ms.
> 
> --
> 
> ice: wait for in-flight Tx timestamps before removing the tracker
> 
> This patch adds ice_ptp_wait_for_tracker_drain(). It polls the PHY Tx
> timestamp ready bitmap for up to 10 ms, until every in-use tracker index
> reports ready. ice_ptp_release_tx_tracker() now calls it before
> ice_ptp_flush_tx_tracker(), so in-flight captures get cleared instead of
> being left as orphaned ready bits, and E810 is skipped via
> tx->has_ready_bitmap.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 32be908373c30..ca581490f3edb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -751,6 +751,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
> 
> [ ... ]
> 
>> +static void
>> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
>> +{
>> +	bool drained;
>> +	int err;
>> +
>> +	if (!tx->has_ready_bitmap)
>> +		return;
> 
> [Severity: Medium]
> Does this wait do anything useful on E830? ice_ptp_init_tx() sets:
> 

E830 should be doing something to clear timestamps, and its an oversight
and pre-existing issue that it doesn't. This should be an issue
addressed by a follow up patch and not this series.

> 	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;
> 
> E830 passes this check. ice_ptp_is_tracker_drained() then polls the
> E830 valid bits through ice_get_phy_tx_tstamp_ready_e830() for up to
> 10 ms.
> 
> The flush that follows calls ice_clear_phy_tstamp() for each ready
> index, and that function has no E830 case:
> 
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_clear_phy_tstamp() {
> 	switch (hw->mac_type) {
> 	case ICE_MAC_E810:
> 		return ice_clear_phy_tstamp_e810(hw, block, idx);
> 	case ICE_MAC_GENERIC:
> 		return ice_clear_phy_tstamp_e82x(hw, block, idx);
> 	case ICE_MAC_GENERIC_3K_E825:
> 		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
> 	default:
> 		return -EOPNOTSUPP;
> 	}
> }
> 
> ice_ptp_flush_tx_tracker() ignores the return value, so the failure is
> silent.
> 
> The commit message says:
> 
>   Only later devices (E822, E825, E830) have the bitmap and potential
>   issues with internal tracking.
> 
> On E830, won't the valid bits this wait collected still be set after
> the flush? If so, the patch adds up to 10 ms of latency there without
> fixing the desync.
> 
> ice_read_phy_tstamp() already has an E830 case that reads
> E830_PRTTSYN_TXTIME_H/L, but the clear path never uses it. Should
> ice_clear_phy_tstamp() get an E830 case, or should E830 skip the wait?
> The E830 case is still missing at the end of the series.
> 
>> +
>> +	err = read_poll_timeout(ice_ptp_is_tracker_drained,
>> +				drained, drained, 500, 10 * USEC_PER_MSEC, false,
>> +				pf, tx);
>> +	if (err) {
>> +		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
>> +			tx->block);
>> +	}
>> +}
> 
> [ ... ]
> 
>> @@ -868,6 +930,8 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>>  	/* wait for potentially outstanding interrupt to complete */
>>  	synchronize_irq(pf->oicr_irq.virq);
>>  
>> +	ice_ptp_wait_for_tracker_drain(pf, tx);
>> +
>>  	ice_ptp_flush_tx_tracker(pf, tx);
> 
> [Severity: Medium]
> Is the Tx path still live when this runs? On the remove and devlink
> reload paths the order is:
> 
> ice_unload()
>   ice_deinit_features()
>     ice_ptp_release()
>       ice_ptp_release_tx_tracker()
>         ice_ptp_wait_for_tracker_drain()
>         ice_ptp_flush_tx_tracker()
>   ...
>   ice_unregister_netdev()
> 
> Nothing quiesces the Tx queues before the tracker is released.
> ice_ptp_release() masks PFINT_OICR_TSYN_TX and turns off Rx
> timestamping. Clearing tx->init only stops ice_ptp_request_ts() from
> handing out new indexes.
> 
> Two cases seem to slip past the 10 ms wait:
> 
>   ice_tstamp() has already reserved an index through
>   ice_ptp_request_ts(), but the TSYN context descriptor has not been
>   posted yet.
> 
>   A TSYN descriptor stays in the hardware Tx ring for more than 10 ms,
>   for example at low link speed, under PFC/pause backpressure, or with
>   rate limiting.
> 
> In either case read_poll_timeout() times out with only a dev_dbg().
> ice_ptp_flush_tx_tracker() then sees the index as not ready, skips
> ice_clear_phy_tstamp(), and frees the entry. When the frame finally
> goes out, the PHY sets a ready bit (Q_REG_TX_MEMORY_STATUS on E82x)
> that no tracker owns.
> 
> On E82x that quad memory is shared with the other ports of the quad,
> possibly including ports owned by other PFs. ice_ptp_process_tx_tstamp()
> only walks in_use, so nothing ever reads the orphaned entry.
> 
> Isn't that the same "delivery for the whole quad degrades to the
> periodic work" situation the commit message describes? Would it be more
> robust to flush after Tx has been stopped, instead of relying on a fixed
> timeout? The ordering is the same at the end of the series.
> 

I'm not sure how we could safely re-arrange this ordering to do it after
stopping the queues. I think we ultimately fix any issues by performing
a soft reset on initializing PTP which would prevent any long term issue
here (especially as we are changing the logic to avoid flushing anywhere
else).

Maybe that means the waiting is pointless to begin with...

>>  
>>  	kfree(tx->tstamps);
> 

