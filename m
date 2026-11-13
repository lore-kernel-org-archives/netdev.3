Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794612363;
	b=q/3MZd+KBR8URRIgX6ITfecw4UnuJ+p4dKWJW4HYpj6n85KrFydV08qDySqq+Av+HnaQ
	 jXpeAVrkJVFLdrqJntYcjfBszKM24lf0w4u6p/YiKbS5EShZiloRegupqXMKUeeeCn8HL
	 hL75HZCzu/c3tSgnBQngYmdcZb52F8XhuZFLlCU4XPYXC0ajsPxf5dJ1VHnBX6aifVYNY
	 +W9vuXHOMcD5RsAL6s6ekdtgXLNsyCN+mnNsyLHO0Tdg2ot45hW5xc9av//ONbytpb4rm
	 XnnxV/A6BrRE+imlscwKycDLbvsHrlycC6oREHEyqWQsuV+LMWkT00LJUKqSMcEOslQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612363;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=x6EuBhKhor/9uImDurzOVcfWYB+wclaJ4gX9G8edRIA=;
	b=kxbet4suD+aoq/RS51BfFKv95ym+gVLMsiYtsTktlpa4GFyBHa7JZW9omgwqW0ziGaaD
	 tjHnRF9fheBjDeY+zslC6JnePb6Ekmh6FHoftmW5RUMvVGSF1lWgZ2eqL5NXSbJ4Cyn4Q
	 eAjA9NyqSRQjFgxWaSAz3HtdNN1yDbJxV1InmdpRmcCIBREE9Bv/gyF8gGv5qNN8NByKm
	 gvI/zu7JI/kbQXEeQsOorgw+v125DH1ghmZAw17GDfcpptDLitFSjj/yU0cAaxvkKlObD
	 9Tb2MEmHt3gsrzRtfyzHC3gqKfBM0BkCDWKB3fa1qT+KTAwW2sKKUTRYHRiDa0G6Qng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kB++KcKI;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=d86+j5Eh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47491606A897
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47491606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kB++KcKI;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=d86+j5Eh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794612362; x=1826148362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ymky+Fbq3A+LUK8fWagEyQOlg4nj33+fV5xY05SfBEg=;
  b=kB++KcKIvEZbfnWDoABOGnDJ4M7UtkQSd5+cPZatI3f2HWd4oveP6yEB
   5NtE7Vf82v4DhmmnsHTXVFW1OeCgBjpKZuN3geIrOTms1a+RrDConFpWw
   9YchWIDOX0nD4lYT8Q7KK8TTlogQ2IfsXbeWvV0U3em3gDqYjtY2l/jc4
   wUMyAWwct2aTpMy62UpHyv6FyjljdY2ZLCNTLvAFX+AMVSbJuq/xFiS/o
   9HUMe0QRA9G3NqkpIE4GQ+v6616sbit9VBp5ZOASZQcuOUIStvWn2qNwG
   ntHdUgToPtRcTVhjh4BMnG1NKGBy900VjVPXaQdv3+CbpbWTBUrAzxJv6
   Q==;
X-CSE-ConnectionGUID: Tx4kVzDNTx+U/GQTFWhuZA==
X-CSE-MsgGUID: wWHL3zubS72N6ZkNGypvhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3465374"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3465374"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:26:00 -0800
X-CSE-ConnectionGUID: vj9m2iI2TIKadXL8cvAD5g==
X-CSE-MsgGUID: AnIehN49RDur5PfYcze4wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9380536"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:25:59 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:25:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 15:25:59 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:25:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmDjo4alUkH0XS7jTyeCsK+9w/ccHwl8ak2B0SzisHa/ZmajzV/fN4HgYKVbgq+ZNAnUeldWD0SmNpyYswcLHm+8VPO7nsNJ1HZWXwSGXfoyDU0l4xQK4Pry3gm2EKk0Av7XWlmihJ1JyrY8BCCFnrDH6eS8ePtBkB6HgYJ5byH2KZd/fTQ+ANgvbybZuDwzON/gxabS+EaaNyowe7z0blwf0tjPbxepTMs7l3dvOmJ5m+R4VOHbh+eA9L/mQLJZ93JOAcnPYl+ILQyxG60sGh/lfK7nRaONPnxJikV7IVaeruRXrvdi+iMhcy7UkT7EwsnUl39ATY6MnjlM4ZiPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6EuBhKhor/9uImDurzOVcfWYB+wclaJ4gX9G8edRIA=;
 b=CJ589rrCeSb/bc9AQHnTG2PMKvbLCxbJVsMdGFRRXFVzFOJt1agPGoNwpkfQw/k3EKff9OmB3FOej1wvLyihIpFO649JlQB0yB143XOcTu13x87okBoSIHM29//H9lg+ZOGYNfzpeqcbVuRkUM29SQe7SDuy3+/EMC6Us7c7uPohrlE1ZZm1BqWK3zh/aMKCbmRKBtmZ+0Ax5xNGDOuMiqX3C5Ltl5QQgkDSTUOwDnCHZcDYkbXx7E8RZ1UdZMXLROqBasx3aFH1AsGK+N+P9LkRC8K0/Khc2UU3xnqCw0KoU8Elv/SgMbiwVaL1BeOC4eePxGyX5kHr3LZZA9eFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6EuBhKhor/9uImDurzOVcfWYB+wclaJ4gX9G8edRIA=;
 b=d86+j5Eht3aUjwYXq8vpE6v7/kS8GtKNw6W196XrD4c7zIV9EqXXa1XhxY4MImFhCL+4qFHhB3sxSkXNmrpQiNFKfTcS+r4zEIUjtVWVQ7c39T0SU1abAFe/L34vBTqWNvOSVkQLmNMbuYwQ/fIC0SjwGFjiAo/BazM4OA+tgFI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) by
 CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.11; Fri, 13 Nov 2026 23:25:51 +0000
Received: from DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0]) by DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0%3]) with mapi id 15.21.0592.010; Fri, 13 Nov 2026
 23:25:51 +0000
Message-ID: <a67050e0-ba9e-41a8-acc9-2acb0b713ebd@intel.com>
Date: Fri, 13 Nov 2026 15:25:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2026-11-12 (e1000e, igb, igbvf, e1000)
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <skunkolee@gmail.com>, <luoxuanqiang@kylinos.cn>,
	<nsvatoslav515@gmail.com>
References: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To DS0PR11MB6469.namprd11.prod.outlook.com
 (2603:10b6:8:c3::19)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB6469:EE_|CY8PR11MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: d69aa750-41d7-4983-f669-08df41dd74b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|10067099003|261028144727099003|11063799006|56012099006|261022075727099003|261026121527099003|261009223027099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: +4RRftRqlV0Bo2JUIe3pSQriq8UF/5OiZD63Uw7kyofFb0bZE2ZAom1rjJ+LsU6pickzNpNaUkrQM6yfDWydvUh/ch7tHh8yijssFY2J2bDuGI3Ru4vo1B5m22iW4Edpx/ODqdjql1pURDXma6lmBF1rgjVQrjjlY6GQaBC5oww5MgPyUCjA4dloINxxDNtWmnB2q5mhjQKNLJgaK/XIxw9g4NoY5SoStTRMz5vSmPXvp0xirteN3eOdilPx56JcyXFyvUsFIBeTQlJ0uadKMi87XfFLdH2vQSaA0T1vnvT+vPTtG5le7DG3OgbcLvQXtqeiLa9cRdvifnK3iLodiPjI3U7wahx7ZuBzlhKJY//3wqRleLP0eFrErWLayBM1794JsKGXmoLbs6Dur9xFOwustbBudNSEWNTz4sQi9UVH+2zC1jxduock4OzJNXhrL1f3nT/MWcSXknMm9MEoPpHP17x4jTGYBXBwN3TyuuvbmcpLfK30WN3vdWEeEVvu29zJoK5J0bcFTHqHppT/8xQTrNIti2c8dNlSqLVhKrNCPj1BUisolQlgFZJ+d3/Nnz4J2QC2M8yElFf+JoOazcBvJQihl+LsflgONxwvwgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(261028144727099003)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261009223027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dllSS3JQcnhXeWxDRUVKRzRkampRZ015by9DakpWWTNOQWtmSnNmeWh0YmxX?=
 =?utf-8?B?NnZGUHJhUUpPWUhYS3NTaU5USmxFdnIwSnRNdHBWbDhWV2p2ZTlMcUZSY2or?=
 =?utf-8?B?ZE92d2J5dTZGazlnYldSdmwxdGlGU3FVaDhrNFIwbGw2cm1INktlcmVOTy8y?=
 =?utf-8?B?YldxWW9zRGFKRU56Q3hkcE04ZWZua21hUE4reWNJSms1anFCNWZnNk1Iam15?=
 =?utf-8?B?Y3JiY29LUWdTSjdpS05PdEEvbGRwYk5tZkJVNXVySmE1cTNlRHU4SHI0bTd3?=
 =?utf-8?B?QkwwMXNYU1hzY2oxbjFIQk5HZ2E5d3ppdEdKZmZJNkVrNHVGalE4ekt5MGts?=
 =?utf-8?B?THJLeXJ6QitHSTREdVBpS2V0QzNZL25GUDFxbVNFS2VtckI3Q2orcFoxME43?=
 =?utf-8?B?eDMzek56QndJamkvRlQzK0E4Q0daNEI3bmJtTU1tWU9FaHVISVhybFlQUEd2?=
 =?utf-8?B?LzVFZGsyb1JWemNpcXR0TDYxbEphaTQwb0JscHlaRVVSNG16Z0FQME55MmRp?=
 =?utf-8?B?c0xIZXlvZzEzUDFOcnhZU1gwejgzT0ZhazhYMVU2L0kxR0JrV0h5dEVkRU56?=
 =?utf-8?B?dDBib0NGT0dBT2RZanQrdzdSaFRuZW9iNmFHYjdsd0V5a243aEtSdmY5eGhN?=
 =?utf-8?B?VEJGSWJIY0V1SnBYajdFeU4xOFBuUS9oU0xGWUwyYXhjcFczcGswL2s0bU1w?=
 =?utf-8?B?c29vOFZCOHNJTkIwR3RmVFJacUNnVGlvVzBUcFZVTGhHcXEvNjcra24yZ05i?=
 =?utf-8?B?Q09ZTkt6QzFxNmVvUHc0R0c3Q3pDSkVlMGtiTjhob2p1RkhyTlFRVGNoWGtL?=
 =?utf-8?B?NGJ3TjRpNS9HYUs0bnBTc1JBZTY2dTE3aklxdS96ZnYvZ3VCWml5Qlh1WWRl?=
 =?utf-8?B?MkJWVEdzTzlQS2tKdHdicWFIZHNCSHdZellWdCt4QkhDOHZsZDN5eWJPakk2?=
 =?utf-8?B?WlIycjZTa2Z2Vk1lQm9VR05Vc3hveTVkOWU5L3k2R1FQTVlpNGFEVkErOHJQ?=
 =?utf-8?B?ZE5GdEhLYUJpY3YvbWVIb2NSTXJaM0Fldm8rS05EVm1zL3hGUlJ4c3N4RHE5?=
 =?utf-8?B?cXVEMXVkZ3FmZjdFaVlpaTJDUjZoMWp5L3ZMZnpETnRPZnFoa2NsRTAzclc0?=
 =?utf-8?B?RTlPM29iRCtpN2o2WFlqaU5vYU9ZVzlvUTdJNUw2dkgxU09HajhBcklpbnNa?=
 =?utf-8?B?dkNkdEkwSTM0cDlIZjV0d25CdEZPTWhVOXNNVTRaeVg5R1lMajdUaDIrVDJX?=
 =?utf-8?B?VXlzVWxqWXhTVmJpOElHT1gvN0MzaHN5Y251UFV5c1pTTnJwY2c1S2VEVVNR?=
 =?utf-8?B?VjF3d29lS3dibmtWZzcyQVlnMEw3Z245VUpyNnBiQzJBQm1LdWNEYXRLdWZx?=
 =?utf-8?B?UlAyTGZseEk5d2p4ZnFIUWNGNXkzVytHZnNGNHVRRXZOUStFZ3JtQXVPRkt3?=
 =?utf-8?B?VXVwNzFUT1JFRVdyTmhob1RVT2VNeEY5WSsrbFhTQTVIRXRLQ1ZScU50Qjls?=
 =?utf-8?B?aUpieVdrd0NIWWJPUURxZ1dERU1kbnZiRFpJdTg2RmFSbGN5eEx0NEVESWJs?=
 =?utf-8?B?ekVFVW9HcjlDRDBSOEFFSmFDMkE3Wmt3TlBlejVhbk5YamJ6dlVpZW1LeGha?=
 =?utf-8?B?c0srUDIzZFJxQ3d2UjFPbm03QmJlbjB2TDVRNk1neW9NVWZUdmlnZXFsanRF?=
 =?utf-8?B?WFhvenA0bWJhSlV4ZEQ4YlFrOFlZZjg2N2JzZGpBdGRBQ0plQUVoNVhXdWhz?=
 =?utf-8?B?NVNyWFNBaGo4VTVpemk5RW5RczJoNHdxMG8xWGNteVpsZ1BnL1E4NjZ4V1lH?=
 =?utf-8?B?ZVRXUUZCT2tqZmYvWTBNVTF2MXY1YjNWUm50Sm1iZ3dXRVA4WlF3SVlsM3pV?=
 =?utf-8?B?Sy9sRlUwYnk1dVFaSHo5L2RLSW4zT2QzM0dGbFBoZkFnKzY0Mm42bVBYMlEx?=
 =?utf-8?B?OS9TVWhrVFdsSU1vWVNGKzJsSlhyM25iMXZFUllaTDlsbzliZi8zMStPRXFl?=
 =?utf-8?B?T1FxdHBVSXJ1OUk5UW1WTW9OS2I1RVBmNDlXOFdXR0dXWG5jc3p6NmVKS3Rn?=
 =?utf-8?B?VE5hWlFkeGlUc2w3N3BIeWZ1dVZoMDVLeGMwZEZwck9YemN5UmIrZFdJRlRW?=
 =?utf-8?B?aU9MTzVMUXhPd3Y0OFdvTFU0YXJCNDBFdk9XVWRoU0xzZGIxSTZmSzNzTVRZ?=
 =?utf-8?B?NU1GVjZUK0lVSkN1ajVkOUFtUGw1aGRmVC9uNnUrcmU1cFZsR3daaVpON3VP?=
 =?utf-8?B?Y2hRSVNYZ054aHUzeWFkOTd2dUJOMmNXTHFSclozOUh2eHB1Rm8yNms4Q050?=
 =?utf-8?B?RHVpaUxsaHEzWGhWeFFLNm92WWdPUHpzY3kyNmJlVjlHb28vcTRVVWVpRHVH?=
 =?utf-8?Q?EPbM7ctTOj0hbxcg=3D?=
X-Exchange-RoutingPolicyChecked: HAO+R4FTreEAJver1yDQDhR67E/bIIXAnvJ0O/tzwvVzqxSrJp4AOw50TOc4FPZuY21IbM6/cy4PFmYFKbFp7uiE1daBnQ7z4UuayfX1E0ObZIIpaco7V1dpEsEhHVMugi4y16h5ngn8b/Pl9JBfoNNjQQTXAr33DvWpWzreUzMAWSbC13h1PEx9FfI2HZGGFw52HTY/ojauRFmZsUOvsk8T8va0MH9a/vLeFLzy0ishPELF/FR1v7ug2p+nTzv2U9TfzPso1eVlCxzQG2qH5UcDXfq+QJmncV646NiONYxitTuqJ69srmKpRhvNtRzDU397uH0vX5UOqnTb9Q+UFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d69aa750-41d7-4983-f669-08df41dd74b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:25:51.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avt2zBTneo0Yz90mVyGWYYEw/JzuT0Muih5s15JPimoyH9sDjVi2nf+x7UGSp7spIIDrvyIUBHkr9a9pw/opbVswtPh4CJsE5rTvDfenDnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com



On 11/12/2026 4:58 PM, Tony Nguyen wrote:
> Ivy Lopez corrects NVM read on e1000e which was not properly checking
> the high word's modified flag.
> 
> Xuanqiang Luo fixes igb and igbvf device removal by disabling watchdog and
> reset work to prevent work from being queued after cancellation.
> 
> Svyatoslav Nikolenko resolves an e1000 probe failure warning by checking
> that the CE4100 MDIO mapping is non-NULL before calling iounmap().

It looks like the cover didn't make it to the list [1], presumably, due 
to the Outlook outage. Did you want me to resend the series?

Thanks,
Tony

[1] 
https://lore.kernel.org/netdev/20261113005823.130021-2-anthony.l.nguyen@intel.com/

> The following are changes since commit bbcd02741c4cfbf9e1c59b1906f21ef772bd15eb:
>    net: mana: report RX checksum offload for IPv6
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE
> 
> Ivy Lopez (1):
>    e1000e: fix incorrect modified flag check in e1000_read_nvm_spt()
> 
> Svyatoslav Nikolenko (1):
>    net: e1000: fix warning in iounmap on probe failure
> 
> Xuanqiang Luo (1):
>    igb/igbvf: disable work items before device removal
> 
>   drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
>   drivers/net/ethernet/intel/e1000e/ich8lan.c   | 2 +-
>   drivers/net/ethernet/intel/igb/igb_main.c     | 4 ++--
>   drivers/net/ethernet/intel/igbvf/netdev.c     | 4 ++--
>   4 files changed, 7 insertions(+), 6 deletions(-)
> 

