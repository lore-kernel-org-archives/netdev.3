Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793901924;
	b=YQNAEWal+N8IR8ofkgbk0HhjHNGrSypyeLx6WmP/N7+/9eJGLIyhYViXnDhlHegx6LmL
	 onjQSHWU3YCXanFAm7MHctCrr3a5+Hc+6ldMvqRxRR0GWfP3MWOMbTjEeQ12grcFMRszY
	 SZLqkoJPciVtArFJxU6RMcsds8tJcr9W9N/05lyvN88ukuxioVM0oHc6v+itUFmbYfiXL
	 WsIWQi7Kuh53cjX9YESOnjiGwPxMcDouHV0jcuIKT8ky7okvN7AUbHOFKIVsGU79cGtWe
	 thkwd7Vc+XqMJtusVHrDt44N/4PrhjtDRGannHCbGZ+oD1PRovS/FEXTeuAe5tMNuhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901924;
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
	bh=XGab+rBkXzkbDJkL9kuwz/HEn3A/aF8SkUG+Fqu8C1w=;
	b=OhSwiCouMTfT+YeeD3M5RgAG77fjRxHJcbGmHdzzmPXQDYQ6A3NxAaZKLagoRkHoiUTa
	 prgnAV8JG+TAGy/nP2ZJtXzPQyMQmYF91FsT3WXfaTykV49pZEhtsoWDmdygwlbZLRn48
	 LtOQvsKWABfNXCEfaTaUNQhnmwLG3AqGP7V9bVPHgWauTLXX5Q8hsDdF2daq8ajlejRjb
	 80jCpPSih1tEPvxyKryol269jTrxwt3/eVuIdiAD8eID1NYeXGbTy+wNSL03nOKc//WHQ
	 X56CLjFPttUBHXIbWdwf/6fttw91h3pJlPVq7QWTYJdUcHIen5DDqSuOaYREgFY8c5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hnq6lRvX;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E4606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 18:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E45E4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hnq6lRvX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793901924; x=1825437924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MzYXChckHPktzNiNcvgQF5jo8Joxpwdwfz0xGBvOP7s=;
  b=Hnq6lRvXacixpYEXNotnuLMet1n37a5Tzd+rFbww7u8yvbjba7lv/xI4
   GIfmz3c38Y0Hq3QOzU62OctxZgQFulRBhbH6kdxXBKTQVSD70M3jafggm
   rWA4UGzNoZ2uCpA/d3C5KsR3IjnCYn17z/ttJMuwv8zCQPLRWl+1yE3JC
   iZ9KPp+fWtxJaVlaAVC5Ywf63tZAyxxQZ3yqLpr3/ha6oHzdGboVMR+sD
   ACOMUFY5KYFabMzyUEWX5Ax3+f5512E70NoJtMjmFb1kV2fQvXIj56XaS
   pSkrJba7eZtiHBoGbUBxnkMBBwFx1Ghs6VPnS5o1nTZ9ITZ5WshM0xEOK
   Q==;
X-CSE-ConnectionGUID: +B16gBRWSPmOHms0rUHIPQ==
X-CSE-MsgGUID: o83CRJ7ISZ2U2ZLejlbmjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2605894"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2605894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:05:23 -0800
X-CSE-ConnectionGUID: ltJfbAcST/a/5+mZRqYqxA==
X-CSE-MsgGUID: s1S95ByOTRGdeOO5GWlHjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7405865"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:05:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:05:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:05:21 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:05:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDLw/aD8mLxAHsOnGNe14oEzXSjzXUkJlYGm3GQ5tkP8FeVxNML8Lheund+bZBz+MwjVKIRndL6Q8oAoPtpJSMWKDJs3A8nwV/FkrUqUmG6n/DvMVLsoY/Dmczu4UDjEL8MxHKd+4MmNYltgTCt0YeotgtBm1FASX3LWrk8Ky/rb9J4dnfbPp2vKQVvYndZp2fLZkP97Cy3jb8KWDTgiihiqODy0UPZNFB0cZziNJj4gKu6OAUgKaL9wED9Qpikm72v+YrMZ+ddDuvlDHSNGZwn5mq9ssyZRx3t7mvsN0qYY4NhPtj5/3YeW6SuigWN1Le3+KzerqCY94MZ/Oxqelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGab+rBkXzkbDJkL9kuwz/HEn3A/aF8SkUG+Fqu8C1w=;
 b=sFTX3gtM+6vrjAsTJAF2naRDTrr2B3DbuMw9jBkqeAS06xxw8xBuiTrDE3z8PQYd6NLqZDhskpXM4unBYhLXmGc3x4BwEUS2ub4S16LExWOqEs5F6hxvOwuj8y4oG4ASSY1h3ktnOntQRmRhY2QZsA7JY/LQKB4ZjmwF7HoIzebg55zg+Pz8VXAmEKgTrqwqLiJXTKpZr70Ss3IXYSDnIRYDf/7l9GvjxvezHRsZxF/T04vyD5lyzGA7n+ghOA+nwFCUjhQZu9WE9Q62zczyJCSYfmDNGEYRgfgkh9FQGNxGurNzx2Uv4nwZWFozz/Z7WT3pINkGQWfISClpSheAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 18:05:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:05:15 +0000
Message-ID: <ffaae559-3a40-46d4-b9fd-3b292c737c4c@intel.com>
Date: Thu, 5 Nov 2026 19:05:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
To: Naman Gulati <namangulati@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261104013606.1527767-1-namangulati@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261104013606.1527767-1-namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) To DS0PR11MB8718.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f0093fe3-4c8a-402d-8c43-08df3b6757ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261009223027099003|261021123027099003|261021121427099003|11063799006|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|10067099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LzfoK2AY5edmdPDbuKayD1RXeNbQecBTxLOFkuJbQOx0HVKs75oBZH5VrrQ9yQCe9/eTWFu/n/2xs5j8gBJf1D/7h+bYY5NZ16ZCIpM2xg+gvkIa2LfKV2hsTmdU3Y/VKOgvVCQgQ5KiSpiOJn7KKb0DStmfSXd41fvvSIXLtuxLPk0IOJVBT5ziXCtf4hAtT6Y4bzCqrwth1lWOfjT2us71CfUUo8HfF0UhkBUd+kOdowFsxG9w+jOVM2wvno8pCQqpvAQLwmtJeja+djvdwj9b5cZLb/w32dwVYoEz4QSDml6qG5ua2uvZ7o7imAfyKAt0d7r15k/9/3b0ATmsDvFtj7aWTdxCCy6Upg0bZyDBZcf2VD2gcB4umcp4KryKrI33+VCSoJee4TWfurf8rcYLfK60iXwwNWPVRaShWceA2kCh08hLtXS7lAsI8IFPkGAIOtRNexx6faKfDhBDhx4DJEtcYkzyOEXCYND4OXDw5GwxMJTL/yeTXCuCu0g2lyPXIco3Nqh/e8sybQj74aN6g9ZMJ7qG8t3Cmue3EzRjMqrsvrYE0WEzuSndc2AYjPtCdVpFd/npfu/GaSb9nCdlmaXOW7Orj9MMR45I5BlmoB64TLmqLQVPDXRpPr5ptLVwE9OXwWwrgyjxOr8e6R4/xz/96ntmhNGTehaz4tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRQYWZETlFYVjdQK3NqUndzb0x2eTYraGFJNkZWZnZ5MlNyMWtqZ3RCSGZX?=
 =?utf-8?B?TG9ldG53ei9NczFrRGxwOVh0eWs4L21oY3J1cGtiR2dwYk5ucy9aTStPL0h5?=
 =?utf-8?B?eGtLd2JnUkRsMzdVa29kWm5OSHc0bEhmYzgyV213Q2RCVW5ONG5EOFhidFRq?=
 =?utf-8?B?RzdLNGl0NWFKSUx2aUQ2SStobTd1SVByMUN6SW9vSlRKdnZVSjhuTkZROVor?=
 =?utf-8?B?RUVCeWNEWUlBSFk0Z296Y1EvWW5jeGQ3UWRYMHI2TjR2VVVnWGRkUHZqTlNX?=
 =?utf-8?B?VlAvajJOaWJOUkdIUkhjL2ZNUGZlU1kva0hhZEFTMExYSFNOTVM2NG5kS3pX?=
 =?utf-8?B?RlBiMXVNYXJSZGlUNU9LQ3R0ZTV4MnJXcXQ2RUhIc3NIOVFLQnpWekc0Yzhp?=
 =?utf-8?B?UGtORDFPUDRBazhPYXcwUXdXRWlZK3d6QWxONVR2UndIUWNrYi9zOVZjU1V3?=
 =?utf-8?B?azdnYnovSFVrcHdyTzAyVkJUNUUvN3UwREZSNURydmJJdGVmdnNKdDArS3hZ?=
 =?utf-8?B?Rk5hQ2k3UWVRZ25DWkMvNUFEUTNKeDZ0MTNLQkR5RlkyUzZObmkxTEpmTWxC?=
 =?utf-8?B?em9DYzBjVXk3ZmdMZU5IV2FicUE1SStSUEFENnpSWkJvSm43VlpsN2xsR2d1?=
 =?utf-8?B?NWtLLzhyaGJTVVpzeGhjaTZmTUFjT3MyQnVXK1plWHZaanM5cW5kVEZ1M1pu?=
 =?utf-8?B?Y1FOOE1HMkRyWXpXelQwa05ZSmp6b0lEUi9IV0xkVEVpbzliUVlDOU9teU83?=
 =?utf-8?B?R2RNaWtDTHM2Rmc5SXF2dWlrUlVWMmh4c25NRVd1b0d4dzBNelpKeDBwVm1T?=
 =?utf-8?B?cWN0SjhkYU0rUThKNEFpWW80ZWgybW5RajU4K1V0cnpwbGJONXF2NnJucXdJ?=
 =?utf-8?B?ODdVZmFYUnpvWFlFdkpMWWFYQXUrUUgybWpXbWl4RTJnQmN5QWd3YkVEMmxI?=
 =?utf-8?B?MC9Ib25Ebm5FOUZNaGRWbHJxOUxxc1NyUDZrSWZFY0J5ZjV5RVc1NjBqeC9m?=
 =?utf-8?B?QVo5KzI1Y1VSc1hVYnFnZmRMSE16NUI3VmxUUXEwWXVLSm1nSzlkNzdNaE5L?=
 =?utf-8?B?OTdtMTZRTW8xc0dHVjM2ejJCTTB1SWtrVE9WNHk5eW9KVkxDUk5HcWtuM2lj?=
 =?utf-8?B?ckNGVU1oVDVtS0RORm1sZUI5amN6ZU1iNGZ1STNTUXVmU2JtM1prS25FTWoy?=
 =?utf-8?B?RkkzbUpQZkNqTDFvTmVIZ2Mxa0QrakNUWmlSRnJib1Y4Q2p0aUVWc21zWW5T?=
 =?utf-8?B?YjgzVjNXUzVESlRDaTdHYVJLZkJEWnBIK0pOejB0RE5tN3dlR25kMzVmY0Y5?=
 =?utf-8?B?TTI2RkNsQXdBR3AzSWFZNDUzQVFkQi9OcjhINFpETXlYSGNhbXlMdVFvZXh6?=
 =?utf-8?B?ZXJibUFyKzlQK1FoRVJIcXhHQTB5elRrUUJtQ2l3YjRQR3NFbi9idHh0MDVY?=
 =?utf-8?B?OE9acUVHNkVRSHlSL1RlM01PSHY3d0FhZEF6NVRMQ1FWRXpZY1hxRmdnelA4?=
 =?utf-8?B?RUtSQ3dSMkRWcVZnd1ZPOGMwSXRvdjZkeUJCUTh0K3hmS1V3TzhBMVFET1Y5?=
 =?utf-8?B?UDM0eENJcERTTDRTcDBGQks2T0FaTG5SQXc2dVlGdGU0eXVVU25hT3ZGSWha?=
 =?utf-8?B?bkpDMjljQW1pVzBzTmdiejh6R2hxVnBlK2NTQU9ocDkzTlFJVFlsY3ZQSUlR?=
 =?utf-8?B?V1c0bi9UdlVDSWEzM2pKVHdDc2tmSzFuYnlXSzBndXNsMVpJN3JxUlpBVmxx?=
 =?utf-8?B?TnhJa0ppRmtBb1U5ZU9NTE1UNlZaaktCeHQ1UGxEUFU0ZVg0RWlnakw5NFNM?=
 =?utf-8?B?TlhKNnR3SUZTeVFmVmxGYldvR0VrRUcrSWZlWWhQdDZBeTJSd2VrNTlpMkJN?=
 =?utf-8?B?cVNYRTJTRWlMb0Voem5mb2JrZEc2cE02STl1QVFZUkVIaWRUcjlFWURpanRv?=
 =?utf-8?B?ZEFEaDkvTUxmUVZrbHkwUWJhUUxBaDFFNFdoMUIxdFJEbzQrNm11UjdUS2tv?=
 =?utf-8?B?TktjNlNaeG0rOHVjanV4MGFIVGpRUjUxdzlqU1ZpRlRxZGVYSnc4SjNYNjcw?=
 =?utf-8?B?OFJhdy9SNlNLWWtsNGlmbmlKV0FXVEo5VHNTdTZISkp5MVRHVE92Zk4vWkxN?=
 =?utf-8?B?b1o2aHY3LzJRdllpT0VsYjFSM3ZsditWV2hpUFJqYlRWMS9lL202VVE5Mm9S?=
 =?utf-8?B?eTYwVjR6c2xwV2tPRWZtRXdLRHFTWFgzWDVoL2pRYnpMRGErUitObDJKdnY0?=
 =?utf-8?B?SE5lK1h0NHQ4Z1l1cGY5OHEwYTc3cDhqL0hkbmRva0NXRkV0U2R6VVIxeGZ0?=
 =?utf-8?B?cXFLb0FlZjMrS3ZsbDdWZ3RmRFdVcWtqUE16M3FmV3I3UTlaeEZOVS9OdlV1?=
 =?utf-8?Q?NDXr2LDc5hNduFbY=3D?=
X-Exchange-RoutingPolicyChecked: BE5ICJLwcYHUMq47Vi3K+CvWbktWGrutV6l7VFekGZVnqwlRA639lHKfrCPF80RT1VZ3WjsqI2JS04JQNGUA9NbNxZfDanAhANzJ8kGZbk7iOTw4QMQ5RYztqYl95+d3lPyTRQ0ioHoT21pnzJrK8kqZDVV3CXEq1/aTy5sy/NhrERBoVq6soxiAKGjJm6Wlzj8KV0PoAA/VwQ8fHC7Owg6ONk3ATLEKrmZ2hGX+stNxpnT3KKsPp/blibiUL5zhz2uVa6ZsLfAKFCTH2siYiPdm/BHmigz0ZQqsY6lauZplx70PQ9uFj/GIdbN5QIFZGFyjUmWLx4sy2Ym4bsJeKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0093fe3-4c8a-402d-8c43-08df3b6757ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:05:15.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDUFuGg+GuO8yxeqLGpeg3TXNtTvT6b1rzICTZFJIbjxqhP9FEuNUBklOp8J/SbvUolpWjwT7T0ot6F+k2oQE7xHzkTvtBkUcC4btG/+Kf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com

From: Naman Gulati <namangulati@google.com>
Date: Wed,  4 Nov 2026 01:36:06 +0000

> With header split, idpf_rx_update_bufq_desc() allocates the payload
> buffer for a buffer ID first and its header buffer second. If the header
> buffer allocation fails, it returns -ENOMEM and leaves the new payload
> buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
> consuming the refill queue entry, and the next NAPI poll retries the
> same buffer ID, again starting with the payload buffer.
> libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
> buffer is never returned to its page_pool.
> 
> Each such failure leaks one payload buffer. The pool's inflight count
> never drops to zero, so when the queues are re-created or the device
> goes away, the pool never finishes shutting down and
> page_pool_release_retry() keeps warning about a stalled pool shutdown.
> 
> This happens when the header buffer pool runs dry while the payload pool
> still has pages, for example under memory pressure: a header page holds
> several header buffers and only goes back to its pool once the skbs
> using all of them have been freed.
> 
> Release the payload buffer when the header buffer cannot be allocated,
> as ice_alloc_rx_bufs() already does, so that the retry starts from an
> empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
> teardown cannot release the buffer a second time.
> 
> Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")

Please add `Cc: stable@vger.kernel.org #` with the minimum affected
version so that it will be picked up for backporting automatically.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> Signed-off-by: Naman Gulati <namangulati@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 885df6294ad94..7383d8241ead5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
>  	fq.truesize = bufq->hdr_truesize;
>  
>  	addr = libeth_rx_alloc(&fq, buf_id);
> -	if (addr == DMA_MAPPING_ERROR)
> +	if (addr == DMA_MAPPING_ERROR) {
> +		idpf_rx_page_rel(&bufq->buf[buf_id]);
>  		return -ENOMEM;
> +	}
>  
>  	buf_desc->hdr_addr = cpu_to_le64(addr);

Thanks,
Olek
