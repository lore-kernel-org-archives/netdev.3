Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143355D882
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929354; cv=fail; b=jUDqc6KgYUgoexfHqe6qElDSuVr/58xnCmlIwjQXz0wv8t66dJDbze/ua7+3Kn6Wbvv+6J3F8EedwFJFHZuMLjFCzoe8445wHsGVY060VEiSFRIecRhFASrasQSTyQN78Vfwtx2maQdn1ICBcHQpDnorH2Xx0uH3RMi/vUWZRiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929354; c=relaxed/simple;
	bh=ZLG0IgfOlz7lomOFyQtcSYFVF/ryATzvKTFNJkQ/SM8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=exZzNzQYkeaGiW9s9JLAAjbRxK//3ha5uFj2KAq6kjNS5vra1bjAIS9tUNqQOxsmWVbN1vadmQpQQR67Bc+OQ1xAN7uSlWkbD86cVaY/2S3aoi67Rbr0u1pM5Ggfdt7qqznoODxjyZNQLpSQb/Cn4nV1GtLxoxBIpa8Ox0kJgs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKusOUf0; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKusOUf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791929352; x=1823465352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZLG0IgfOlz7lomOFyQtcSYFVF/ryATzvKTFNJkQ/SM8=;
  b=gKusOUf0VFFXBC+gQwABb1FEskPycUwlnPfmwvyG7ErR5A2ljrRkSkYo
   Yj2eaJHo3fszmv45XhmjchrBsBxlDfS2kLohekCfAwgcw2HgqLMEZfkgc
   yk3msMRHFAXt8EDMVqIXEkHzUmVdKEa+kr54qKJY6RMA5hhUzx8homoqx
   6MCiwhEsqxT9ZwlnArZziBUz+H7cRMSb2mzii5L26svWUbMjc5jCgXNbq
   xATcs/JPhtlTmmG3rtn4YA0D2BkyciBldKmAS5271cihTvTGEofjpLV5X
   3DVgH8nxzCSfI23/w2O9HJKtisXVa5ZYUMuUMnDRSXAtA9Kgi8ENvXM3W
   Q==;
X-CSE-ConnectionGUID: BLMEiX7FRqaYctkJb720fg==
X-CSE-MsgGUID: 93zgjKDeQJ+ZbEYsnuKA1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="546187"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="546187"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:09:11 -0700
X-CSE-ConnectionGUID: yvkbPIfjTRSYu9Rkx2DWLg==
X-CSE-MsgGUID: NDbBn8BVSLyf/bxUqYSdxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="3042835"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:09:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:09:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 15:09:10 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:09:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFX0Y7UC1jFRviK80qW25Ml4SNpMEnpAKZpyQSqUgLqpzcVFzvQHRHPE4V3/eWabfqY6qT6WDDlSgh36VYXJX73cZ0wqEK7ntND7BCcjScqljAhzuOGRr+rlwCmUM9MP5BWihH5PBzWKcI+D3ISmQLaWlqBU5hE4hKd/rbzIFDdVhz/LvnSRJdT68egk8GYJjHOwHXGrs7AIEbMLjqQmxRX0ACvC45Jcp02vEtLUHHKLbmcWP/+srV5fGR4G5ip5Xx1xT5HQFCHQvb4yNyBYDjGzdrF7gS83t6FFVTQg9Ys2Ekhr3z3Ch8jCZGZQt5OEykUlIU6YrlGzOY0Bdw69bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgMOm5hDnHI1M4kxPJXHSF2IXLtA7o3GVN6VzN6hXaw=;
 b=USLB9af8NcM/erP8OULdsMnMNCP/0trBWwqj6Rflntm9F4wJGZ8DV16x7DT6PXZmtkubecUQ64zKBxzeRvZY5MTD73P+pAP/MGsoUFIU11XYCRyyWipo/QqRwRANGg6CNAr6U8gQlXh0DDyZN9ca77XYB9CpwN4wpgz3hlQNSI0AtetZtk8hy1Lx6ENciafst/Iv/Y90zESD+B7S4OLAtXZPyIEk+yJFEUoNMjnee71gKbOxVYZv8yuiyqWLbkCZHGWv1GDjJpwOwPhUvybsxOnhzrV0GVd99kCQyP1HfQ5oIN740UMr1QLvOaH2+L0DZ8aX4xjNUbncvJZs6OTwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:08:57 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:08:57 +0000
Message-ID: <4d573295-979d-4634-818d-08d04a2572bf@intel.com>
Date: Tue, 13 Oct 2026 15:08:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-9-anthony.l.nguyen@intel.com>
 <179184692566.434549.13285577131769636984@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184692566.434549.13285577131769636984@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|MW4PR11MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee40793-2508-4bf5-9e03-08df297693e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: /HIbyWknWoLyq2BkPmdR3iFzwDssKNm+9IjMIHGJds8EqeihjHJEavRfLeY0wW1bJ4lCDvxJZIIWjAVXK1F1L7cCEzh5+T50WEy8f7QYAzDtioGpAQvfQIV/bIN6zguUh9G52E/0F0V9Xdmk/cLKlMo11OQsz8o9aQA3xSPj9TXBC5YOL7kT+QynjNHitLF9zR2hUrahEwvN5uF1LYbsSQKGF6BPQwD9lq9fFs98u4dRVzt05Pnga26/8al9yClN33fgmfD2fho9WooMyVrsE01Xp8V5WKjKqRqNCMQq4yBXVFH7ZCGjpJTQaK0DLdhJcejiTpsUaS36/ecGodvnOn8PF/dvfBY9RAkr99xeu4ePxcjSbDVtntYfbSQYUkjSZdqLYI0FoQG8+c34poYYfFovnfYr87Qor2LdPbfmc1DACahzmZnj8ciFCtkUeF7Hrzoyyytj3EnLXDoUiYeRpB1iiwl6KkFIEh9r4Tac3JJ3MJCScIxsTv7HMp8/8htDzeKSjXivKYXKIPdUYX2qZJU6dpX/lHUz8A+SdHzaF4yMpq79Jn/OqctKCmVOhdSD6cLa0f73aXd+nEyK9yq40r9QRmQP1TZiYzvAcV4KZYAibakBy9sQHtEmcahsFcyD0DNDyYTmbPyDWeQ3yMC4erUBnBVpKOuspjxS32uofLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FhODVDdG52eG5sbDU4RS9YdktIa3pTYVRtSlFEdUl6QkZGd1A0QzhMZVp6?=
 =?utf-8?B?YzBySVJkWDlIUjhUTFNXSnNBQTFKaXprUE9TM2pQd3JKN2pTWXFXZElZTFk3?=
 =?utf-8?B?NVcwYVdqYWprTUVKVGtqdU5DWFBGNmp3OGlLSUZMK1puSnN4YzlOdTdQSHhq?=
 =?utf-8?B?aEM4N3ZQVnQ1dWNQWXBiYlM0N3kvVW1aU0hTYm9DdEJqb2xNaUEvUjRFZVds?=
 =?utf-8?B?NTRqTytXdHE4dkwwcElPdzBwSklLbmdSQVVzRWlZbGJXOERtc2tWNnc5aDZx?=
 =?utf-8?B?TmtKSjJuRW8yUG52MlYrZ0dLSk03eDdjMllVOVI3ZkFrN3NQY2ZBWkd6VUhH?=
 =?utf-8?B?UGhRYytYVWlNYnZrd0Nsb0JRSUhtZFQzL0ZUZmpVVjZ6RWhuVTJaY2JWS3dT?=
 =?utf-8?B?WDRIMk9hMGFCalEwa2w0UWFaZllYV2wrV2xZeXRrTFEybWYzRGwvcU8zOU9o?=
 =?utf-8?B?Ui83RFArZ2FmVE0xMFBTTE5vNFo1MWFlMGwyeHZ1czF6UkxyeTNvcDhac3Zl?=
 =?utf-8?B?YU14blgwNU1rZ0xISWZBbVMzS1NhUnVhajZ6R2dybnFBbFBQcTRyOUM1YjhN?=
 =?utf-8?B?YXY3Syt4Q3UxenJRdk9ueFZlNWprSFE4a1QxUWFCNU5uaWxEWDZVaC80bm8v?=
 =?utf-8?B?d3hTaGxieUFjSEFFd1l2QnYxc3ptVlVlb1ZqNkhiYTdZckpDVUlmQWJSWmdv?=
 =?utf-8?B?bVZ0cjhrWGs3VHhHL3ZzYnZFbmxXVkRpSUtPd1BqZHRnRi8vZmZyS1A2djlC?=
 =?utf-8?B?aG9LQ3dFSyszMzJvZ1lXa1dPUExJd1VZWTRLcWI0TXNIS0d6MzBaYUhKVVhW?=
 =?utf-8?B?VlE2dk0vL0hIWFhCZTJoMzhmUUUzUGQrZjN2V0hPa2Z3dDBNU1orS1ZTTzZT?=
 =?utf-8?B?dml6QTZ5ZlhwY3lUQVJXRndJOHd0OVgydnlvYkdtLzNYN3Z0d3pidFNMbW1G?=
 =?utf-8?B?YTgvTFdZRVNvTXVNdHI1a29wdG9adG4wdXh5WllQUUVhMnU2OGVDVWNUeWJF?=
 =?utf-8?B?WG9RVFpkd1p6Vzg5ekNkbzRaV2xjRi8yck04ZkY1ckliWjFSeXVpOTJwRGVy?=
 =?utf-8?B?bjAyYTRnL3UyclpIZ0lUcVRad2htYTZSOGMxZWtTZG90Ymw2U0MvYWs5OUN0?=
 =?utf-8?B?VDdUZVN3cmpUb2prSExFVlV1V2QrNElGMXpBbzFmaHVodW51NXFXaUpCTnBx?=
 =?utf-8?B?TzFRcTg0RnJkaEM4eG5Zbk12VlBrOWZXdjFaVjRqaUI1TjlqMW9UTlFOc3Jn?=
 =?utf-8?B?bjAybE04SDB0M3Q5bEVxTzRTeWFwRFloL0tSTDJhUGExTkNsb04xQ2hsS2M2?=
 =?utf-8?B?VmRSWXRnTUNEZVVNbkQzTVhqM3hQQWtaWmlGM2JVU2dIb3hXOVEvaHdObVE0?=
 =?utf-8?B?cWR3VmlJbWhLSHlzeVBuQm91ZFF5S2xrRHQ4L3pEOCs3UzRiT1N1Um00WmdS?=
 =?utf-8?B?TnAvajlzNzcyOEVmYkJXVkMzbTFsMTgvaXJRY0VQcDdjWVJzbnpsb280WkJT?=
 =?utf-8?B?cEZHYm1wK2E0c3dkMXQyUFRCamdrdXMxczdBZFJOYm9TM2xXT0JqeEIvWjBY?=
 =?utf-8?B?ZFBYd0V5eno2aEpXNEViTzlJOHFVRkZ6QUpJeUpFU2d3REhMcTRCNTgvV0o2?=
 =?utf-8?B?UElDVWV2c1pnWDI4bEF5azRnSjNuOEd6YkpoTitNTGlFUU5jK0p3N3c2RXYz?=
 =?utf-8?B?Mzhjd25PVUF6NDFpUGtxM3ptZi9WUFp4cWNYUjVQZGl2UmdOUHFHdURVRG9s?=
 =?utf-8?B?WVRNeG9aNmhNa3A1TWFyNmczSXBWSDE0V3dyWTJQMVZicmFaMUtheFp2UE1j?=
 =?utf-8?B?L1VEVm9uRGYwNGo2NjhZWmJuc1NPRUE4OWlPWm5aMTlEOG42bXdORDZvRU0z?=
 =?utf-8?B?TVgzZDl1L1Y2dW02OFByN1RUbFlRdUpuOHRJWmJTd0hoS0lIRWJIRFRhY0Vu?=
 =?utf-8?B?OWJSemdMYjNGL1BaUXBIU3lpYTh3cFNsRnRjQWIxZTVReGlmT2M1Lzg3bSt3?=
 =?utf-8?B?S3E4NUNTVFhRK28xbVhJWDEzUlQzUlVsTEppZlJreFJ1L3ptb2s1d0pzS3lZ?=
 =?utf-8?B?RmJXa252bWMySU9POTAwVUFIaGpSaitPaUpIRjFPOWVZZzl1dHNTV0RUQTQ5?=
 =?utf-8?B?WDFHbTk0enlYSWhMM2EvOUtRRFBDOTQ4bkxZNmxUU1RSTGtYOGhjSW0xc1RR?=
 =?utf-8?B?VG94THN3VXpoaVZZYnFUZ0ZWWmFnbXNzb0FBRXVoMWRnaS93QkVzSG5LOHVZ?=
 =?utf-8?B?VXpNc3VIUlErQUVMa2RXV25kVG9HUVRJY3BJNGtsZXpSRVhuU1J4d3hHVDBi?=
 =?utf-8?B?WmRIeTRHZVI4TGMxd0xYOTFwY01vaEZKNkdUdUhvMm41NXVZcnRtQ2xSV3N4?=
 =?utf-8?Q?mrQUg5nPC+UInkxs=3D?=
X-Exchange-RoutingPolicyChecked: aLL7HIQE/gCYNLk2KOX7jHcVM1PE3CC4KZrNDvRyE9MV+jGC3SVbDuascr8pgak+HqGrRLnZmDZ2DDRy87JaliNi8AxtHBA6cWemFTc0r9FH6qzYAvpRY4038+X+KZu12qHglsMALOLo1t8ocdRJvJsWFctzG1XHep7hOlFQuPG6iDEHhlOMB+zXCWcVv6xvTRHF5QrR5oePYx8wL9ItETA+Ih4wx1zMIFOwdHlJ7iklemsk9inlaKJYEB9+eRwccmdCOOmjmRwOJX9sCrCBq1nIzh/UJDpbLBnUb9WcJvMIxVO9MtnYoZ2oum3Q0ZQJY8mrxRxtqXwvWQbLtkJdGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee40793-2508-4bf5-9e03-08df297693e4
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:08:57.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJYMTi088iBmTuR+VXgcnYZSlSKQ3zspQQJntmCg3LW2K5cifRHqc6Ao7Qev7/Qy6CuDcVNmUsCQHBoRD1o693fcd2ZsNH+oTUa/YIGTI8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Concern: the new ice_ptp_mark_tx_tracker_stale() calls in the
>   E825 branches of ice_ptp_port_phy_restart() (line 1322) and…
> - [Low] The new error message in ice_ptp_port_phy_restart()
>   (drivers/net/ethernet/intel/ice/ice_ptp.c:1340) blames a link-up…
> 
> --
> 
> ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
> 
> On E825, ice_stop_phy_timer_eth56g() no longer clears
> PHY_REG_TX_OFFSET_READY, because clearing it leaves the hardware Tx
> timestamp counter out of sync. The E825 stop and restart paths now set
> tx.calibrating and mark outstanding Tx timestamps stale, then clear
> tx.calibrating once the PHY start succeeds. The patch also drops the
> unused soft_reset argument and rewords the restart failure message.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 7cc151b01a13e..818e2e265a7e5 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -1302,15 +1310,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>>  					   0);
>>  		break;
>>  	case ICE_MAC_GENERIC_3K_E825:
>> +		/* ice_ptp_port_phy_stop() may have already disabled
>> +		 * timestamps, but some restarts occur without first stopping
>> +		 * the timer, so we ensure that new requests are disabled
>> +		 * here.
>> +		 */
>> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
>> +		ptp_port->tx.calibrating = true;
>> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>> +
>> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> 
> [Severity: High]
> Can this call race with ice_ptp_release() freeing the Tx tracker bitmaps?
> 
> At this commit, ice_ptp_mark_tx_tracker_stale() does not check tx->init:
> 
> ice_ptp_mark_tx_tracker_stale() {
> 	spin_lock_irqsave(&tx->lock, flags);
> 	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
> 	spin_unlock_irqrestore(&tx->lock, flags);
> }
> 
> ice_ptp_release_tx_tracker() clears tx->init under tx->lock. It then
> frees the bitmaps without holding tx->lock or ps_lock:
> 
> 	bitmap_free(tx->in_use);
> 	tx->in_use = NULL;
> 
> 	bitmap_free(tx->stale);
> 	tx->stale = NULL;
> 
> 	tx->len = 0;
> 
> ice_ptp_link_change() checks pf->ptp.state against ICE_PTP_READY without
> a lock, before it takes ps_lock. ice_ptp_release() sets ICE_PTP_UNINIT
> without holding ps_lock.
> 
> So on E825, the service task could handle a link-up event during driver
> removal and reach this path:
> 
> ice_ptp_link_change()
>   ice_ptp_port_phy_restart()
>     ice_ptp_mark_tx_tracker_stale()
>       bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len)
> 
> If that happens while ice_ptp_release_tx_tracker() is freeing or clearing
> tx->stale and tx->in_use, this would touch freed or NULL bitmaps. The new
> call in the E825 branch of ice_ptp_port_phy_stop() has the same
> exposure.
> 
> The direct call ice_ptp_release() -> ice_ptp_port_phy_stop() is safe,
> because it runs after tx->len has already been set to 0.
> 
> A later patch in the series, "ice: keep Tx timestamp slots tracked until
> completion or timeout", appears to fix this. It wraps the bitmap_or() in
> ice_ptp_mark_tx_tracker_stale() with an if (tx->init) check under
> tx->lock.
> 
> Could that check be added here, or could that patch be ordered before
> this one, so the tree stays safe at every commit for bisection?
> 

That change could likely be merged here.

>> +
>>  		err = ice_start_phy_timer_eth56g(hw, port);
>> +		if (err)
>> +			break;
>> +
>> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
>> +		ptp_port->tx.calibrating = false;
>> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
>> +
>>  		break;
>>  	default:
>> -		err = -ENODEV;
>> +		dev_dbg(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with unknown MAC type %d\n",
>> +			port, hw->mac_type);
>> +		return -ENODEV;
>>  	}
>>  
>>  	if (err)
>> -		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
>> -			port, err);
>> +		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u on link-up with err %pe; Timestamping remains disabled; A link-toggle may recover.\n",
>> +			port, ERR_PTR(err));
> 
> [Severity: Low]
> Is "on link-up" accurate for every caller of ice_ptp_port_phy_restart()?
> 
> ice_ptp_link_change() calls it, but so does ice_ptp_restart_all_phy(),
> which runs from the reset rebuild path and from ice_ptp_settime64():
> 
> ice_ptp_restart_all_phy() {
> 	...
> 		if (READ_ONCE(port->link_up))
> 			ice_ptp_port_phy_restart(port);
> 	...
> }
> 
> ice_ptp_init() also calls it directly:
> 
> 	/* Start the PHY timestamping block */
> 	ice_ptp_port_phy_restart(&ptp->port);
> 
> At this commit, the settime64 path only applies to E822. Later in the
> series, "ice: Recalibrate PHY after settime64 on E825-C" extends it to
> E825 as well.
> 
> If the PHY start fails during rebuild, init or settime, this message
> says a link-up event caused it. The wording is still the same at the end
> of the series.
> 
> Would something like "PTP failed to restart PHY port %u" without the "on
> link-up" part be more accurate?
> 

I'll drop that phrasing in v3.

