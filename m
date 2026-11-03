Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793726576;
	b=mN/+JcrWqSh4rbno+J3SRN+IaLltAeZVZ3X2cZi7grtvF68q5RHfr9XzokLGTaMoAkpv
	 R2PWdwMpCsOYn0a/3mI7uUxbtamxIH/Fu/u2PFGF9016DNMcf6KEPK8mt/sdG7o+dyWPY
	 hnWsPu6rH+rUHiQlmwswqqLL/lpNCjfYlPKbdA/RIlyh/N+TCo0cfpMQEZYvHF4EC/nvz
	 +o2W9lDrCmnaepXVAnpegnlV7CxNfRB5DUdwbtqQs9WdacFYBOyYPvmyyOXoatpjMSAip
	 JrIU0MZpWIuXirENjz6TDTnbQiIBJC4ETFQaGMDj17wfXYXp5p5n/aNiTfMyeqO5+aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726576;
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
	bh=ne60wfq5San8S4IdIoxy/R+t/7loZhaiwgQUUUeffhQ=;
	b=kia6EB/tmQGDqrdtdjnO+FbtAVo/b2Ye1dwHFck3A4bgIPhBwzTCCTIcdMs5Qhe+jSIL
	 uNjaaO9cWCjyRLWzAhTKiyXbzxRpWMAux8JUQKTn2MMG5ObCE7oxvpdrDfapFwItLI/Z8
	 0yjA1pXOzh0XS7drV55fMp0qduKGNlZ4OjltQvu+EpzbtdfJ6tJ3qNserL7d98XCHbMOg
	 sQxSjZpEK18CsDJo+2glJEDedk5BlVrYGU5bQxGLFh6q4cTILudY+qfTZVbRHD3OnAiwx
	 9b3fD3GWbj2Xw93YEg1YJ558SxhuunS4FC/Zh1wKl9mDmrFZgKXcIH+pyj05RZSVlnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIYxfmEy;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3FD606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC3FD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KIYxfmEy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793726575; x=1825262575;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=A6V2EJo5HqID8YhYvMLEhxHm5bIxoG7Et702xcuFA1k=;
  b=KIYxfmEyf3VLF5MKzbeIij2sW+1EEslzmSy+RPaKHVwlaMKvDsTaATd+
   rlw4pkch9CJcGgc5wwidhOusNSR2WRyUkwKUPk1ManF7A8fEgABM8YwLV
   WPx3gy6JOP616EdOiTzCJJlLSw2Zh+b0X8SxNOOOArcvzNRNXfLBOJlEe
   w6VhTBLrU90mpARFAJAyutCVhj7+ranT3ok7sSOe2LqV+jmou+5bppU0F
   vswjoXYadglbhdeda0+KJNIsVn3LO33AgtoyjgBmRqy/0CDraAc4Iz5Ey
   sRVodxkKmBPvj2LHSRnExitVuNMHsEtFRcgPmztM4YpYkqIB8zX5QTaW2
   A==;
X-CSE-ConnectionGUID: BBhj9YlrSVGOoaF6OmdTpw==
X-CSE-MsgGUID: 4w9JueQxQ7Sm70vM6UhB2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2490375"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2490375"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:22:55 -0800
X-CSE-ConnectionGUID: xd+GheXWS/+guXDSyROrvQ==
X-CSE-MsgGUID: /D7/GPxNRv2ZvUHJT5WOCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6594153"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:22:54 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:22:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 09:22:53 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:22:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN+k7Yga+8701TYUiDYmem9WOLFtRg3tjO09cPiAsiBNzsiZn19cUnbv2qRs3B9jRjzJ6UCjXEaPsMCEyg532fjLjf1lKPbp2MDscZf6MZlaGRKh1SFKMLSD8GEa/qS0MH15SndA/ZkBkyAVgP198V+3HdS30ZTlL09DjgCLs0/XlkXA8q5iHaxmYd9yxU6LobVvPJSaftIhIwStXzpoxlMBw7cqiP9bmwgpw/0eo0dnbe3QnKjb7X6ji1UlMaMIrE8UF1r5r+SVs4Neb/Bx+R6bATsf2EQrQ54GrbgR43kpwdXoXaugyLiNDLTGBc3a5KWxGP/w/wZ67Dou++Ktzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne60wfq5San8S4IdIoxy/R+t/7loZhaiwgQUUUeffhQ=;
 b=x527JxzdOy0udV1/mV+R7oiGWCq3vNSptCA7GVER1tFXKh5q4K1PJ/vqme8Tfgfn/5un9O6JTGfCQPyp0NqO8QYqRR0pYiFfg8glPIhkO50uAqa6a/RiScLF7eDPsIuIR530qrgruU9Vzwx5zsn3mwW0o74RyXWYsKa3AHm7usUokA1XMxWB24jaWzkLdbdOjOMyb22MDodyiR6pdFzE1jVdlrbrilntPbev6U28FoO2TPrZZyZ/d1fnV6AQO3PqL0bDW6aKXI+LRwkWaEI/LRdIhERGUxFT7GcrCe3O2d9qiMfi33bEQIFs+dmhjzPwq33XFgS/UnxGCvRk8cXh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DM4PR11MB7398.namprd11.prod.outlook.com
 (2603:10b6:8:102::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 17:22:51 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 17:22:49 +0000
Date: Tue, 3 Nov 2026 18:22:37 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <zuomao338@gmail.com>
Subject: Re: [PATCH net 3/9] ice: xsk: fix leaking Rx buffers in multi-buffer
 path
Message-ID: <auoYXdrYPCEjvwx5@boxer>
References: <20261102124950.958345-4-maciej.fijalkowski@intel.com>
 <179371275153.488856.16170220434241626063@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179371275153.488856.16170220434241626063@kernel.org>
X-ClientProxiedBy: DUZP191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::7) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfd4001-b59d-4cb7-a409-08df39cf158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|260925022911599003|260925021911599003|18002099003|260925021311599003|22082099003|56012099006|10067099003|261009223027099003|261022113327099003|261022105027099003|261021123027099003|261021135927099003|261022075727099003|4143699003|11063799006|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: vxdBYeTcfOPJ1t8x53iNKEtGV6nXJ9L6gexAN0ZGGA0INW0DJBNEHuvq8ZfetE/T/+3UBzd/AwftEymFv/Vi1KxXTtbcSlG11XEpgDByU1QsJ16Rdv1dLSD9uwoWJ+yzZTAXz7M5t/eYqg5NIxZQvDU2txZE4BMJV8s1yPG1m8AMP5P5CQuNyLbzkGvHWeQwnzNhgFi13gJYO8sT/fgiz11seTfgW88Q9pu3HoTgFqJd37scU++HZQ/M7rNpe4Vz1hDHATv6uopKl9d88trVLI76j0XBQrtQocPQXpUYF6aTEWnbD1hf45ZHaCZG9z+xa10OvO1tlBUL6neplLzBym30HnBTNWqwaW+Jqnx7F8TfjP4VaXuh4sYH/ZoqGmFMOkVXdhjNtsDoRbAWiNnnjghddnf2EWQbr6FpkbMUiZV6oQyai6fbWC7j27HUDfZXzTW1rQ0KqeMfuvSSfdh8Kiu8kWNq2BC+Dgi3BtFAKnrM5xS8spv1ZBQexdw7q3Kt8qvUMLRboZg+02JRm8N2FrULTXjmPNdGFoPrqmKhh7kUV4l5NgmBmL6kvHb3P+ha2AXkLo9wYhskxm5XUQNq8QXq6FXHUPzg+FU272V2RVdijQ+EEKG2YFuQoq+6uY7p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(260925022911599003)(260925021911599003)(18002099003)(260925021311599003)(22082099003)(56012099006)(10067099003)(261009223027099003)(261022113327099003)(261022105027099003)(261021123027099003)(261021135927099003)(261022075727099003)(4143699003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzBISFJEV1JnaFBIYUJZbkpwQzZzTHR3UlpoQVF6ajFrWUc5TlYzNW5DK0dO?=
 =?utf-8?B?akc1a0JPVnliSWRTbHZuMWVLZTFpUm1VUnN0N0g1RkNOM1hBR2dsdG1FZVk4?=
 =?utf-8?B?SmJMQ1RXYWxGcnRodnljaUs3UEJRU1o5SlIyWUJSRlNqSFBvenJNeUwwYlBS?=
 =?utf-8?B?OTFkS2h5L01OUUtFOFJkVExSMlIvcUEvQ3RZSWg1Yi9OY0tGMDFQZE5XVE9P?=
 =?utf-8?B?a3NNVmQ2Y3gxWXB4NXRzYTIza09Ra21wT29mRVVVZ3RyVkxlVWtUbnZObUJ3?=
 =?utf-8?B?aVVMTDA4QzFPTS9MZkhOZGcyTHBHRVE1VmRKRTZKRG5kSU5KRXAwYVhWNXhB?=
 =?utf-8?B?Q1FWYjhFK2dwRUFtUHVsekRNalduZ1FmNDVsU3BUZGs3VUx3cjd3MXlHVi9H?=
 =?utf-8?B?U2NOR3pYakV0ZS9ZUnJPeXVDWjNxSXNuWFd1ZnhBN3Vtb21XVDhySEVRSmQ1?=
 =?utf-8?B?dENGUExSeSt5Vm9mR1FqVjJGYjZBUzIvbzF4T2gzUjNZdkhlMTdFNjlsV0la?=
 =?utf-8?B?NDNQbGI1NWFDMkRKK1VYYkQzZW9kNnR3U0d0d28zWmhiTXJiejJjd2VnZzdx?=
 =?utf-8?B?czFla3hmejNRSDlsZEdnOHVhUDR2S3pGU3cwM1kvSGxxYjFVamVhak92a0Jk?=
 =?utf-8?B?SHd5YWZ4WGV3bktyK3JqMkRVNnhYc3JET3NwRjJ1T2JsbzNkdEtLVG9xUTI1?=
 =?utf-8?B?SlF4QlhuNWI1M01YWTYyYUpQWmJYNVdyejRRSmFFaGNON0hyOHVOVUhvUWl2?=
 =?utf-8?B?Y1lMQ1hzODBRS2RpZk5GMjM3L3dxMTV5TEVxR05uQnpNUjY0SXFTWVc4VFpC?=
 =?utf-8?B?M05GRDFGaVd1MS9LQkJUbkozRUNTT1l1eXozRmdFd3EwNzZSZE9zZVh6Z0JC?=
 =?utf-8?B?eFYyeUVwaXJGQzV2UUR3YTlDZk43VjVyQXVZVUF5UWpXTk5uMDFWRzFFVzln?=
 =?utf-8?B?MENIdDNONjhYbUo1UG5scStwaTVQUHBJTXY0b0ZDWlYxUEJMWEVsTkh2Nytu?=
 =?utf-8?B?aC92TTFmRmVKWHd3WU1HL0N3T05ocHNmK3ViSFM0UnY3cHB3WDlvODVROWQ3?=
 =?utf-8?B?aFJsN1RtVUo2QmJ0OFJNcjNQaUVXU0RlSFBTSVNrcGZtcTBHKzRGcE5hTlZ5?=
 =?utf-8?B?TlFSbmhYS2Iyb1NUaFpMbjJvUzU0dVpTZDlUUkVsNFBoMGtXSS9QV0tqOS9r?=
 =?utf-8?B?bEZFRkswYkVhSDNFZStuMGF5azJnaGtZQjU0ZG91R0I1RW1ZZFYwbzhYU1Yx?=
 =?utf-8?B?NVBDdXNyMXpuSFVVSXp3OWJxaGp6NXFsNmxTamdzSnljVXFkaG1PYkRORkhV?=
 =?utf-8?B?QVAzc1N0SWJCNFZDU2JLTVJ5eDlSTzV0WlJkNDMwTnNKYU5weG9RTG5jbExq?=
 =?utf-8?B?YjBLTXZSZzBiN3hDWkwwYy9GRndvRndQNVNlS0ltV3VOSWlhMXNlcElEVHU5?=
 =?utf-8?B?N0xCRzMreEhSRjhwbkxjWEJtd0o2bVFFbnJpc2x1Vk14RGk4cXlYS2oxVHN2?=
 =?utf-8?B?QkF6cXFmTUNLa2FDdzV4OG84NzhKbTAxNk15RXR0WjdSc1ZmMFBIZEpwZnpt?=
 =?utf-8?B?aCt6UTlyckE0bGRiaGhzbWlvdUZmSlhjY2RUOEIzYzdudWV4L0xUTUI0eEcx?=
 =?utf-8?B?cjdDNmc0bHN3cjNxMGNma1pSKzIxcWJEems1Sm12NzMvZFJZTkJMMkZVWUdW?=
 =?utf-8?B?V0xIbExnN1pRcjlJb2t6MzdHek5uTmhGOWxjeVRaSExLb2tnY3lFdm1YZ29L?=
 =?utf-8?B?bG5hSndUOGN1REdtK09YVEFjNnlUMEd1Y1hSMDhWSElTQURacy9lRTlZUFlH?=
 =?utf-8?B?UXBYalNWWlQ4Z3VSQkZVZkszdnBXT2tZOFVpak1aZXEzYy9QL1M3RmRUZW90?=
 =?utf-8?B?Yi9jK21EN1lKa29EQ3N3Z3NCNnB1dGh5RG5CMk1TWVFCQ1FkN01WY25uQ253?=
 =?utf-8?B?a2I5eTBtZjZQNUlaYms4Mk1maVArZy9RcGI2NGFDYTlZbVFPWjBTOGZyYmQw?=
 =?utf-8?B?RjNYM3VwUWIwdmhFZkQyMVk1bnk2dzl2NDNVRDJQRGtlQ0NoRGFEV2VIRE83?=
 =?utf-8?B?dVNmZmJ3a1ZtbjhkKzFWNUhiMHN2bm9KOEJ4VlBJNmx3TnBSeExhb3hjRE05?=
 =?utf-8?B?NVhRQm8rZ0pMMmF3bDJCeEwwanpvaU5WbUE3TlZmV0ZQWUVFZDNCU2V4QWxl?=
 =?utf-8?B?blRpR1RiQ3ZuTGNDM1F5bGlKZXR5ZEVSL2V4Z1daZmF5Zm0rQ2FOa0cyeGFB?=
 =?utf-8?B?OGFCcVFHM1ozNG5SV2FUOUtFdkFJcUxHaFlOSWhseEF3eUkzZmtCdDA4Mmps?=
 =?utf-8?B?QkdtbEpGMWoxT2J5bDlJNEdPSVB4dlhxY25qR1VCMzNnWVFhWDJWWFVQVWJ2?=
 =?utf-8?Q?GMTQKv18sQD9QHl4=3D?=
X-Exchange-RoutingPolicyChecked: pRouXWrJEsiPmL60BziJCzoaLlxZdyL0UetOHBrpt5X+jaBzOXDV1G+Spt80Q++YCt+rNxnrix4VLFVNGp47qFmueb2Nx2/ZPss0fJFnGanJYqvw1OtBwqf4kZ+jMT215ZiNQOJzby+8t1VTbhRit7iKrCBdBIGg3zkrjcMtzJ8ZclmqaVQTtomYMJLyi6HuHy3N6oa5CQGExX31LbmYBOrPMg/ZaJq7cUr9y5UiesUxNrkZxCg81GfoVnDaW5irUxgooziB6Y7zUjTKTsZ/8L9tdXbuIzJ+EVYw5KjmF/QSqZm1kdeJLjaGZHHDfprpdKVOc5qqHMb27FZdgOiAyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfd4001-b59d-4cb7-a409-08df39cf158f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:22:49.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMpXUoVzg9l3jU0j7Ccx7caNUoSAO9odURBqYo8FQaf/49hL+tRn30wIBSiRTqzZQbkR+X2kLSKCLWkti1k6KLQU5fWGnazlrLV57Cy0F2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 01:32:31PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 2 · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new zero-length branch in ice_clean_rx_irq_zc()
>   (drivers/net/ethernet/intel/ice/ice_xsk.c) is `else if…
> - [High] ice: xsk: 0-length buffer assigned to first in
>   ice_clean_rx_irq_zc()
> - [Medium] As of this commit, if xsk_buff_add_frag() fails in
>   ice_clean_rx_irq_zc() because `xdp == first` (aligned-mode duplicate…
> 
> Pre-existing issues:
> - [Low] When xsk_buff_add_frag() fails on a non-EOP descriptor in
>   ice_clean_rx_irq_zc(), `first` is set to NULL and the loop continues.
> 
> --
> 
> ice: xsk: fix leaking Rx buffers in multi-buffer path
> 
> This commit changes ice_clean_rx_irq_zc() to free the xsk buffer of a
> zero-length frag. When xsk_buff_add_frag() fails, it now also frees the
> current descriptor's buffer in addition to the frame head. It relies on
> xp_free() skipping a duplicate buffer that was already freed with the
> frame.
> 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 0643017541c35..ea8ac0fcdf6ef 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -618,8 +618,11 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> >  
> >  		if (!first) {
> >  			first = xdp;
> > -		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
> > +		} else if (unlikely(!size)) {
> > +			xsk_buff_free(xdp);
> 
> [Severity: High]
> Does the zero-length check need to come before the !first check?

That can not ever happen on this HW. 0 len descriptors are rare but
possible at the end of fragmented frame containing only FCS.

So this behavior is correct: while we are in frag gathering process and
get 0 len desc, release *current* buffer and continue.

> 
> With the current ordering, a descriptor with pkt_len 0 is only freed
> when a frame is already in progress. If first is NULL, the zero-length
> buffer becomes the head of a new frame. If that descriptor is also EOP,
> the unlikely(!first) test further down no longer skips it.
> 
> One way to get there is the xsk_buff_add_frag() failure path just
> below. When xsk_buff_add_frag() fails on a non-EOP descriptor, first is
> reset to NULL and the loop moves on. Suppose the next descriptor is the
> EOP of the same packet and carries no data. That can happen when the
> hardware strips the FCS and the last buffer held only FCS bytes. The
> empty buffer is then assigned to first with data_end == data, and
> ice_run_xdp_zc() runs on an empty frame.

This will be addressed with draining up to EOP logic.

> 
> What happens next depends on the verdict:
> 
> - XDP_TX: ice_xmit_xdp_tx_zc() would post a Tx descriptor with a zero
>   buffer size and the EOP bit set. E810 may treat that as a malicious
>   driver event and stop the queue.
> 
> - XDP_PASS: xdp_build_skb_from_zc() builds an skb with len 0, so
>   eth_type_trans() has no header to work with. When
>   ICE_RX_FLAGS_MULTIDEV is set, ice_process_skb_fields() may also
>   __skb_push() ETH_HLEN, which moves skb->data in front of the frame.
> 
> - XDP_REDIRECT: the user socket gets a spurious empty descriptor.
> 
> libeth_xsk_process_buff() checks the length before anything else:
> 
>     if (unlikely(!len)) {
>         libeth_xsk_buff_free_slow(xdp);
>         return head;
>     }
> 
> This ordering predates this patch. Since this hunk already adds a
> dedicated zero-length branch, would it make sense to test size before
> first here?
> 
> Then a zero-length buffer would be freed when no frame is in progress,
> and first would stay NULL so the descriptor is skipped. There is also
> the duplicate fill ring case where xdp aliases first. Given that, the
> zero-length branch would presumably still need to avoid freeing the
> buffer when it is the current head.
> 
> [Severity: High]
> Can this free the live head of the frame when xdp == first?
> 
> In aligned mode, a duplicate fill ring address maps to the same
> pool->heads[] xskb. xsk_buff_add_frag() guards against this explicitly:
> 
>     /* Duplicate fill ring entries map to the same xskb in aligned mode */
>     if (unlikely(xdp == head || !list_empty(&frag->list_node)))
>         return false;
> 
> The new zero-size branch has no such check. Suppose the descriptor after
> the head comes back with pkt_len 0 and aliases first. Then
> xsk_buff_set_size() resets the head's flags, and xsk_buff_free() goes
> straight to xp_free(). The head is not on any list, so this:

This can not happen either. This implies an impossible scenario where
non-fragmented frame is followed by 0 len desc.

> 
>     void xp_free(struct xdp_buff_xsk *xskb)
>     {
>         if (!list_empty(&xskb->list_node))
>             return;
> 
>         xskb->pool->free_list_cnt++;
>         list_add(&xskb->list_node, &xskb->pool->free_list);
>     }
> 
> puts it on pool->free_list while first still points at it.
> 
> The frame then either goes on to ice_run_xdp_zc() (TX, REDIRECT or PASS)
> or is stashed in rx_ring->xsk. In the same poll,
> ice_alloc_rx_bufs_zc()->xp_alloc_batch()->xp_alloc_reused() can take the
> buffer off free_list with list_del_init() and post it to the hardware Rx
> ring again.
> 
> Could the NIC then DMA a later packet into a buffer that is still in use?
> That buffer could be the head of the frame being built, sit on the XDP_TX
> ring, or be on the user Rx ring.
> 
> Also, list_del_init() leaves list_node empty again. A later
> xsk_buff_free(first) or XDP_TX completion would then put the buffer back
> on free_list while it is still posted to hardware.
> 
> The commit message says "xp_free() skips a duplicate already freed with
> the frame". Here, though, the duplicate is the live head and has not been
> freed yet. Before this patch, the zero-length case did not touch the
> buffer.
> 
> Would skipping the free when xdp == first avoid this? That would match the
> guard in xsk_buff_add_frag(). For comparison, i40e_clean_rx_irq_zc() in
> this series does not free a zero-length buffer by itself.
> 
> > +		} else if (!xsk_buff_add_frag(first, xdp)) {
> >  			xsk_buff_free(first);
> > +			xsk_buff_free(xdp);
> 

Two issues not possible to happen and one later fixed.
Clashiko 2:5 Maciej

> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but there is a related
> behavior. When xsk_buff_add_frag() fails on a non-EOP descriptor, first is
> set to NULL and the loop continues. The next descriptor of the dropped
> packet then starts a new frame through:
> 
>     if (!first) {
>         first = xdp;
> 
> So the rest of the dropped frame is assembled and run through XDP as a
> standalone packet that starts mid-frame.
> 
> The i40e companion patch in this series says this is intended ("Remaining
> buffers of this packet, if any, will be processed as a new packet.").
> 
> Is that also the intended behavior for ice, rather than discarding
> descriptors until EOP?
> 
> >
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
