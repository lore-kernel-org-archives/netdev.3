Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792451806;
	b=eWJPcodVo469zyW5DHCfk5HHEb4GgurbS3HeSWx18uVX9S01Q9okCbA4GyXQGht7/UKV
	 iRSWiWjGJXpiNC5jeDmyaMOn0EedxMUQAsF3rI5Yx4WXpSt01vsABVEh9tFCbsTgSErpK
	 dfML17fCQMZhiNv4RefpQosvYPiVUZ+L/Y2dEIv8TSV2WK3/FuEKK5CTf5lJo05wl8SNW
	 vvwVwuSnkoRWrrynAPrPSW367PAHaHoYOCsdETH9Msjwc4tNCS4ucWGGP5nBczbps/uQP
	 +rMmMwN1waRrqK8k/ka8md1cymTudwBikm558TmbZ979zU71JvTsF2koMmxLgwS71QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451806;
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
	bh=h+aojrvulFdOjW7DAQIRs915KSBqRMdCXuYbQfrmaEk=;
	b=eSBBl4hv2jn8Yfr46/ZsYjvErCoatt0+UUSr/cn45BJP9aO18JOZ5KYuxrthUXxcmF4J
	 jHU/FwZtWNVYfdDKn0WaCNNZhXIHk/XDWDRxkQYyG40TCM3TOdq9Xqmk7FuMK+aVBbQ0p
	 yTWhEor8vfgiD8RhMaFjih3VKkucFm/tGwqscwW48W9q6TyfRot5HP1548yjh9kTh+BEu
	 2FYB9PqpePxx+sRwaD97m4116h6ZWQ9Fd+QdWhuNXeVcTKSlraqLZeaUyJCJIlFAnRXS8
	 N0qwCULRIBNPwLUqMOQmYiLR+5xpeKnb0kNKxSz81st2INqfXtcd9ZXkIjC4zojst3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAiKQV3C;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF1606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BAF1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAiKQV3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792451805; x=1823987805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PngKseVCBHpG93FafoBlUv9BxCMjwuJaBEV9Qv/0BnE=;
  b=cAiKQV3Ck+pbdUmoc33/92aS4V5wAt5IGOlUAfpwytq1VsZifD6zZsu9
   nVkJUlLCGILiHJ2YoB3RKay9Ude34d8vDfENx99f9oe7r4kYGi/EkH/zT
   1l6nBJzFSpJz2xz/EMKZOh3RkMyroW+5gkWBgfCugDbrkXwkCP6OhhIad
   uSfovRz3nQCH7y8iITxBwR2nKmqhBtHwE6+B5AHMUwvCxjvFx/MspmM/0
   9VEhFK05Ykz5DxuvKg1wbabGYdnsEOItC1BrcnYE1LB1xpEujPDwAbf0P
   ldbKTQcUmiWHWKwnrXEjTvrYdBBsaIzEkPvzJKYi+a857CmXQjakdCYJ/
   A==;
X-CSE-ConnectionGUID: czezxfyBQ4eE1nzFNPAJwg==
X-CSE-MsgGUID: wbVhw76hRAW6WxWllBl/4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1249613"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1249613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:16:44 -0700
X-CSE-ConnectionGUID: 5LYIu3CmQKiqEI3LAdm3nw==
X-CSE-MsgGUID: XMI9upRITdmxrPcW9FDzBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2990952"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:16:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:16:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:16:43 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO2qLJqhF7iSbHRP22Yz7zzkxBdn+Qm4w/U2XUici9o8DMrSeogmZvert/SGuNmAkwbyX6p6gY5PfKTRKJGWUGyLv+nNY1IHGRa4z7H/cLDfitd0y30aoxxUzY+ls5X+Ifej9dtnSnNwIyXJEtu4BSIY6xK4HrhnXXl7DfDz+n6brvzwAHYcRxtR1ZMA6RWmIKJL32GS9pv2fr+EjGbzJxGjhz0IHRHP6Duj8+LGedkWGPYEQ6QoCmF5TVZN/nw62z6xCqstTQspkVv4oLAd4WXZJaVXlNCyIuqCYCuQCSMowEqK8zJ9y8eedoagrJPFytKsACEpwNeP1EFyxe3s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+aojrvulFdOjW7DAQIRs915KSBqRMdCXuYbQfrmaEk=;
 b=WTEDI0dAJbhbzovbWDPv0aO9lJHNRaVbwtYo4CIyPJ7MUeAVTPKDGOtjaIi8VWUev/ElZxzgWhabpdSrjC9lubSzGRqMVBECFOWjtwUMLNqEFxQm6fkrQBMDD91wUh1qtVfmZc3bg64PA96Qnq3gXkkD5zsXZSYlzaFMDod3N+ugb/PdUELOS1CEEM7K05d0zZMruyjCVaxE/V6t0ommacqv+PI6eozC6KxlFzSTzbQ8vFk6oz2S21yZzEsl5t1jK7b2HWZFSD+QoVo/atUunoWtIv1aC8JhpMpj28aHxyTS4T0o+vnFViNwHoHMbR7yISHtkdiaj3Qu5BpaC5xfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:16:40 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:16:39 +0000
Message-ID: <cadf7730-3d9e-4d45-acf3-ee235fa64fd4@intel.com>
Date: Mon, 19 Oct 2026 16:16:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 02/14] ice: use reference counting and SRCU for PTP
 port access
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-3-anthony.l.nguyen@intel.com>
 <179244084232.3135.1622859924790214166@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <179244084232.3135.1622859924790214166@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3597bf64-ce64-4b2e-ebc3-08df2e370782
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 2DSzOXkmcDsuqoNwZM+GkQk1Js1YWJuLEi0n7MPqt5ucPUp6QWmd3jpktw4+U/dsyT3ZXM2LeVl0Es4A+toctKlC9LfSe8A1tfWi5Pbnq/LOSNqtYyqpSb8QHkt/duEfuTADN8phG/n1J9NmJ9SbaS7tCpURJTBeSPfOk+h21gswoxp546R5fKplxgc0M7j1ZT1mRtaW9tJeGyQY0fO0ORsUY5s6teI27mFqxTNcxndiSzu5nelvqITTek+kQJM3lTUWFDPNOpy60hptS0o0UjkjuMx2eaTya7AcMHcFRQkjdHWJhlf7SzaM09gOODX3MN+hC+IOqoXcanyBLMrqL3sDYi7XoMaF16TcB0YT5PgSiefscxf6Rrd7fTUEarcVsy0Yxn1Xn7DIsByVyAw5AYp96wRAXAYQRzJx7SEca5uyUPKi5ulAh2hGnnXt/X0/Y69igO5J2aX9/teUMBrIG+FTo3MEBYnghK14idVF5FDRWBe+J3/NOcbjzPbQzUNq6EdVeP6SQTsqOsqvd5Jf7iVen4Skq4HY0atVSzdqYhQAlFXynTH/Cakd9AgCW7cTRtM3IwcqiQxsjyPG2lcJXC0z4ETtE3GImoyAn2tclPd+bIHuHOMI9lkq46bhOsO3Xcb8YaLzXHWAPFrrQkoBSWWUkEC5HKvKSpYzMRqsicA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjFUS0ZsKzdINVAvY2ljak5UdDFNZzBoempzcWVDc3U1TElvakhtbVJ0WkZy?=
 =?utf-8?B?R2lFSjZLQ24ybGFsb1lhazREOGRXVDltK3NMZVJKOStGWk1wbzhUVVRBQ3Zu?=
 =?utf-8?B?dVJrSDBUYk9GUGI2Qm9Na1RBZFAwNDZXb0tsYk1ZNXljc2svWWpnMFNTT1pE?=
 =?utf-8?B?RVAweUVGa2JBb2RkOUY0RmZ3NmloUjlVVUtsMTdUMWEwdmZ5SzlLNFY4V1pZ?=
 =?utf-8?B?aEN3T3hjRUNXdXloOHRPaUk4QjUxZ3pqM1pxcytNSEIvdGhrSnRNMytwc04w?=
 =?utf-8?B?TlJudmpmT21zS2ZBeXAxZmNqSEczay9mWlZKR0QvWlh5WFliUUw0eVNRbjlB?=
 =?utf-8?B?c25qNU5UYTA3QnNOdW1NQ2dKVVVVNTk4d3E5bndkRW9qcWplOEZUaXZxWXFT?=
 =?utf-8?B?T3ViUERZbEg5ejc2YmtPb3IzdVozVTdnekFremtENGdqeUluNzVkNW42MjlE?=
 =?utf-8?B?NTJDM29lVGwrcC9hU1dwKzhJRlhZMTBvRk1UbStRbWRkM0xVZHVRRmFWbzFy?=
 =?utf-8?B?NVVSV0dCc1pkbnBMU0pUYTNUM0w0N25RT29jejVESlpkaXFyaFJLTlJoSEdl?=
 =?utf-8?B?OHh5MFRmd1c0VmZYNkRYVjZxV1VBdkVJMXJXRWcvWTN1WTdqMzdNZjRyZUUv?=
 =?utf-8?B?cy85YWVHZWxYNkt1dGdPY3NTZGlsOHBEYVFVZEorQ0hzNkNnSWEvb0xQYWlS?=
 =?utf-8?B?UVRBYnlUdHNKMS9aUTg5dm5PNDZDNyszK3BWZTR2aW1YMlM2T2dpd0lqVTl6?=
 =?utf-8?B?QlFWRHMybEIwcExWVnVIeC9hcDc1c1doSTA1d2NQWU5Md2xwR3Qyb0ZjS0lD?=
 =?utf-8?B?eXl4TnJoaTk2N0xlWWVUazA5cEVzL3hUcGNqSHp6VEtwOFBFMzlnS1hGT2pl?=
 =?utf-8?B?ZlVhcWlOQ1MvYTJEVFJOMit1Q05Ud3llZlRSalVML0pVcG5GckdNRnV2SHNW?=
 =?utf-8?B?b0NCSDF2dm1tYTY5RnBPQTZVUFhKR0c2NHJ6SitmcWprQmhiOXVXZkNoYWZO?=
 =?utf-8?B?S0I0bVV2VXhrdWhRSjJoZ0kxOWJVVXp1NUhvUk9obG83NWlCOHdmYmNFS0Q2?=
 =?utf-8?B?MUxoRDl1azVxL014Tnh6cE5kZmJuK21xa09Kb3lteDl2YjJLb3RPK2hKT1Ix?=
 =?utf-8?B?YUthUmttdWx4N0FLTy9kMUZrYnVtMHpRYkJUTFJhalV1ZkE5YUJUa1FTQXk5?=
 =?utf-8?B?ZXU4b1lnSGZjTHl2SGhvT1JKRHJJenlLSVZ4NWxLcy9OZmZvQXNYUStIVlFM?=
 =?utf-8?B?NngwdVR1WnhtVDg0VHQ2NHQyS1VuSUZZSEZPRC82UWJqN0ptNi9OTEdPSlo5?=
 =?utf-8?B?Y0pqd0J3aklyQWE4ZUdhM1hSeEgxTUJncXdtYWU3ai9tV1VRdHV0R3dqRFRT?=
 =?utf-8?B?ZVE5aWIyZG53Y3B1TDdhUlVKcGhYaVBTS0RNYjEraUNOU2s5dVFMM0hzbldE?=
 =?utf-8?B?cWhYOGwyWi85YnQ1TnF6SWxRNlBEUDhHdklQNE1zWHZoSlVJV21KUmk0aFpi?=
 =?utf-8?B?MWFrZHkzWUtmN3BYcExwR0dvbGE0Wnl3R0VLc1dzVTZDdUpNdFg3bFVWZmxm?=
 =?utf-8?B?M0ptSk5PTlN2anZVUURJLzIyeDRtSUMzZ2pHeHdvbUtxdTE1ZUx0ZnhaUGpC?=
 =?utf-8?B?UzhrbGN0WlIrK1BLUXpGRGJvOXQzRmRLZUF2citISDlNT20yM2t4VWR5SStk?=
 =?utf-8?B?a09ucG1EVk9ZSkVxMWY5M3pQQ1B1em9RRm4xSHM3ajRuV0c5S0dRbkIzKzVa?=
 =?utf-8?B?WTlPZVFETUV0cXRRSFNGcTB2bElhWHRUUldiR2k4bGZYTlhIbllNd1dvNnh3?=
 =?utf-8?B?bXFiWElCU3pmMHV1RDdYczg3TmE1cHBlMmhMZWw4WWtINUMzUlJzUTZ0bnlC?=
 =?utf-8?B?ZnNXVFcxaGhiWDVYQ1dMVFFUbnlhbGU5d2w3emJJTFdVMEZxZjlQYVB1Vndo?=
 =?utf-8?B?cDl5bll1RTVWS3BvUXJSazQ1SUtnVm1IOTMrM2dVUkMxZXdOb3ZDUWRYbTM0?=
 =?utf-8?B?NG1uUlQ1V0g5cTZ2dlpqcVY1MXZTQWJvNGxBZHVSdFFkbUo3MjlPaDlJZnVx?=
 =?utf-8?B?dG9YelI4MXhjbDZ2VUg1SDc5djBUNjl0SzBzSUZRMnlJbklWb2o2dUZheGtQ?=
 =?utf-8?B?aFZVNFMwUnBhZDZDa0l4WCtJTXhqWTE4NW5uZy9ZcE0xTitrcXNBQVBWQko1?=
 =?utf-8?B?Q00vemRoNVFJOXQyRFVJd1FORUZnTDUzc2VlVHh1TmUrT2YzTzg1Zzl4VGhm?=
 =?utf-8?B?RGlabTgraXpBNXlMcVJVeG1LZHlXalBvaU1YQ2lUVnFwdWdUdmVPNUU2Qkpw?=
 =?utf-8?B?TnBZZ1JxWFF6ZGFiZGl3aWRkSVhjNGRYTitLRm81SDA5RURWT0JGdz09?=
X-Exchange-RoutingPolicyChecked: dTTaoVnwQehy1P2FO4JvqcLxvRTOWOi6evgdbQX/+awgcuvrhsLQN5zGrB3I6fv1GfkNswo0QdlKNHkPQ6cf5gKzsKi4TjoMEiJ4Nw4sguxDX6izVp+zRY0D2nb+TB/tG9oj1xXNLcradHfrZu6VBdQ/kvDSUVg+s+gRey2B976SvSQIm67Hnyui86Bt56OV1bKmZRoiA+vNeoRLHxcqE996+I2qoLBfxenBKr+65zpoRVQEKcn4TTy9WaA6MlYdiYT60dmDiYcr5BmJmQJovZCg02umPqddyBb/QeHqavURtzerkFXA4JE7kZtlsG/fXacsIxtLx/J6NxnK97RRiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3597bf64-ce64-4b2e-ebc3-08df2e370782
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:16:39.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKw8suh346Md6ePS4rP3CeyUvaUS9oyCZXa5qZnSFLCGAc/j+j9/gcSULAv8KOzoiBJuHoRMVGKboag5rKQwxTxvkYJjlGRcsLXzZdOQSNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] drivers/net/ethernet/intel/ice/ice_adapter.h now embeds `struct
>   srcu_struct srcu` by value in `struct ice_port_list` (line 32).
> 
> Pre-existing issues:
> - [Medium] ice_ptp_prepare_rebuild_sec() (E825C owner reset path) holds
>   only an SRCU read section and a kref on the peer port when it calls…
> 
> --
> 
> ice: use reference counting and SRCU for PTP port access
> 
> This commit replaces the mutex-protected adapter port list with an SRCU
> protected list plus a spinlock for writers. It also adds a kref to each
> ice_ptp_port. Readers take the kref with kref_get_unless_zero(), and
> ice_ptp_cleanup_pf() waits for the last reference to drop before it calls
> synchronize_srcu().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> index 4f695f32da3d8..0b01c7f5cf0da 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -17,15 +17,19 @@ struct ice_pf;
> 
> [ ... ]
> 
>>  struct ice_port_list {
>> -	struct list_head ports;
>> -	/* To synchronize the ports list operations */
>> -	struct mutex lock;
>> +	struct list_head list;
>> +	/* To synchronize write operations on the port list */
>> +	spinlock_t lock;
>> +	struct srcu_struct srcu;
> 
> [Severity: Low]
> Should ice_adapter.h include <linux/srcu.h> itself? struct ice_port_list
> now embeds struct srcu_struct by value, so it needs the complete type. The
> header only pulls in:
> 
> #include <linux/types.h>
> #include <linux/mutex.h>
> #include <linux/spinlock_types.h>
> #include <linux/refcount_types.h>
> 
> #include "ice_type.h"
> 
> The patch adds <linux/srcu.h> to ice_adapter.c and ice_ptp.c instead. The
> header seems to build today only through a transitive chain:
> 
> ice_type.h -> ice_osdep.h -> <net/udp_tunnel.h> -> ... -> <linux/notifier.h>
> 
> and notifier.h is what includes <linux/srcu.h>.
> 
> In the same patch, ice_ptp.h does get <linux/kref.h> for its new struct
> kref member.
> 

If we need a respin I can fix this, otherwise I would prefer to follow
up with a cleanup, as this series has already taken a long time :/

>>  };
>>  
>>  /**
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index e1c66cd0f94ff..55241802d17ae 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -2890,14 +2934,18 @@ void ice_ptp_queue_work(struct ice_pf *pf)
>>  static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>>  					enum ice_reset_req reset_type)
>>  {
> 
> [ ... ]
> 
>> +	srcu_idx = srcu_read_lock(&ports->srcu);
>> +	list_for_each_entry_srcu(port, &ports->list, list_node,
>> +				 srcu_read_lock_held(&ports->srcu)) {
>>  		struct ice_pf *peer_pf = ptp_port_to_pf(port);
>>  
>> +		if (!kref_get_unless_zero(&port->ref))
>> +			continue;
>> +
>>  		if (!ice_is_primary(&peer_pf->hw)) {
>>  			if (rebuild) {
>>  				/* TODO: When implementing rebuild=true:
>> @@ -2909,7 +2957,10 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
>>  				ice_ptp_prepare_for_reset(peer_pf, reset_type);
> 
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. Can this
> call to ice_ptp_prepare_for_reset(peer_pf) race with the peer PF's own
> ice_ptp_release()?
> 
> Here the owner holds only an SRCU read section and a kref on the peer
> port. ice_ptp_prepare_for_reset() then reads and writes peer_pf->ptp.state
> with no lock held:
> 
> 	if (ptp->state != ICE_PTP_READY)
> 		return;
> 
> 	ptp->state = ICE_PTP_RESETTING;
> 
> 	/* Disable timestamping for both Tx and Rx */
> 	ice_ptp_disable_timestamp_mode(pf);
> 
> 	kthread_cancel_delayed_work_sync(&ptp->work);
> 
> At the same time, the peer can be in the READY path of ice_ptp_release().
> That path does the following before it reaches ice_ptp_cleanup_pf():
> 
> 	pf->ptp.state = ICE_PTP_UNINIT;
> 
> 	/* Disable timestamping for both Tx and Rx */
> 	ice_ptp_disable_timestamp_mode(pf);
> 
> 	ice_ptp_cleanup_pf(pf);
> 
> One possible interleaving:
> 
> owner (E825C reset)                    peer PF (unbind/remove)
> ice_ptp_prepare_rebuild_sec()
>   kref_get_unless_zero() succeeds
>   ice_ptp_prepare_for_reset(peer_pf)
>     sees state == ICE_PTP_READY
>                                        ice_ptp_release()
>                                          state = ICE_PTP_UNINIT
>                                          ice_ptp_disable_timestamp_mode()
>     state = ICE_PTP_RESETTING
>     ice_ptp_disable_timestamp_mode()
> 
> Could the peer then be torn down with ptp.state left at ICE_PTP_RESETTING
> instead of ICE_PTP_UNINIT? Both sides would also run
> ice_ptp_disable_timestamp_mode() with nothing ordering them.
> 
> The new kref wait in ice_ptp_cleanup_pf() keeps the peer's kworker and Tx
> tracker alive until the owner drops its reference, so the earlier
> use-after-free window looks closed.
> 
> Before this patch, the same call ran with no locking at all. The commit
> message also limits its scope to the port list.
> 

This whole peer_pf stuff needs some investigation. I think its partly
being addressed by the work on ctrl_ptp/ctrl_pf being done, but I'm not
sure. Either way I don't believe it makes sense to address it in this
series.

> ^ permalink raw reply
> 

