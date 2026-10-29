Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793292761;
	b=fXZBQFQVcQjRwIhQ81yOzSE4UQ73quEw8b6UcdwGjyF62re0wczoZd/qrEh27JfhIN04
	 huyRuRFm7nE3gcfHXUua2V5lU1FIEr1NMqGKIIxxoOwVxOhQp7Wc7yV5JJfiopVCGkrIW
	 uTD9RFngZ5/OgMLbZZaknZdCEPNYkxfTJCii/tWpYWV6OIpSPQRBSHLLtIYwFsS8c5TKn
	 uzzhsf9FnhmJKLdQCtirfTX9Apjr5RT7q73emQpC0paU9CXjfXFf79EPbzFPdpoBDp+dj
	 VOw6QI/OzinuLhG3Kq5DyyRAg6dqavfHjy/xYZ97QDkf+N/gIk9WYdeOaek3/0OOv2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292761;
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
	bh=avr8e5x2VMtss0DuDPFwQbvfFeTj6nDZ5Rt+WtLsBuU=;
	b=2UBekuqbIbym/TQQMQmpm/46R42NVt1FYahJ7xQWAIgy9zIDtTxnnXrnjfuXMquXoujr
	 ZqvnS0QVlHf37SN2r2LBccAiAjN4KhGI7PBvJp36EHjkvY26yxHfTZRq6jrD/9TPguwn+
	 c17nsWK0b3bZNRXi0f6UnKA/yxPgq/mEcNtSmZgUnpD5BizvQXGAzMyqwK66uLiySA5eg
	 8ROHfVfzEIBbei76Xmk/8VC5I5XNGdMEtwrmkaTWyb8A7CsF7Df9KuFYO9EU8meTWDzXP
	 iUU9fLgnvOYw3czmvNudmdwFA2wIHHJ8O/CeNMbdOvXhvDTxDVl2/RTdT21NBLLiKrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aLNqEpAX;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BF606A322
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C2BF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aLNqEpAX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793292760; x=1824828760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+puL2fktOyTpKNLyX8Av3YhU59fdFq9ifMjklKb6HJ0=;
  b=aLNqEpAXhzhSB3eYOB7UYmtyA3+1YA/3RJ6Vgo27iqTqK3fKBsGNiFhz
   NcEppS6CY4eMD/n0V3vY6VoSikgt3bLirBjfH9v+msvozI4K/NyKq05hP
   CJadkZRumEMEt8lqMP5yJyCJn9FLV7q+2v+qbYPuYMka1ysEcSmQh0aF0
   ls/fV8ZkrD/TzEwix+HfwsOWB5rzxx/h2sQVt8T6FjD8jwgNMTXvCNp4n
   n2PVz3Z2iFyq7pr5ql6Y/yvBp9vBHkJkefoAZLtN2zgMuyYlZeNggop5L
   5VwDBESHLitxRbzd6JPpHUgcXAKv81ygojFBLfoh/PYV+JcGbwsrK2JC2
   w==;
X-CSE-ConnectionGUID: hYXOOtFuQDOlW8Y8OhMwUg==
X-CSE-MsgGUID: SSioRIW2SNifPLXN9WbIfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2148381"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2148381"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 09:52:39 -0700
X-CSE-ConnectionGUID: TEWUdBnXRAq9dyvS2j+vZw==
X-CSE-MsgGUID: S32EeWFESFa848JKpx4jyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5334967"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 09:52:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 09:52:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 09:52:38 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.52)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 09:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjvs9zf/HhxBmcN06+nB6B+/sio6S2srBr8CA29QzcjB+BW+7+1Y4ANjgCasWUzfoZX6QeWxbCa5M1iywMG2RCMFcCDBjzIyEe/INh6pyuTjf+N+lXx9+JhvE4+gQ+tRCu4q/88teJ6Y/+VRyedDxoGyN6GGENw39QQ0EajO4pKeopPqMTEyi4D3jqeQjPBR5fQBRzXvqWRTZd9c34MYb1uAPAKPqdJ1GL+YbM6cejBhpcpmNTR2CznmzbGAY8rC/cogsnOZnLkzqPN3qPPkcTTklqt8pQhJJn6MpalUGtpY0mbE8MMBA+FuKvhbCAYulD3l9Qs4Rc9kpcl0m8XjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avr8e5x2VMtss0DuDPFwQbvfFeTj6nDZ5Rt+WtLsBuU=;
 b=MBSMURpPjW6oXLd0b1HAudzf8EMPfXGlbjvO9Bk3VzA0v0Y2wmEysZD1BzvdReFD9fHe1nygP8OZZ3qsM9tCZHmktM4BIGShWbZ0P12vbJ4S7FXV4oOIBhJp2mutn2h4MjvffNuPr4Xfbl66zddzvOs6htIfsl2xSTS/LD8kzpCb8OghkqzXGkVMX+P0Z0Qpc8aXW1tV0S1sHuJ2qI0VZpBqHe3vB09ykVoHLei5ZOxvxp/XOoVPvBoOGym1FdhsB/57u6D8/nFJDa7jZ1LyxLaniVJOCAfbR0RXdozFoU/nqQ8kkJJHoYyGokHnC3/p1rfRqeS05iabyrzP107PUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by DS0PR11MB8181.namprd11.prod.outlook.com (2603:10b6:8:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 16:52:35 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:52:35 +0000
Message-ID: <8d3111d7-e309-4d0e-b783-c41340881f07@intel.com>
Date: Thu, 29 Oct 2026 09:52:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/6] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
To: Jakub Kicinski <kuba@kernel.org>, <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
	<poros@redhat.com>, <netdev@vger.kernel.org>, <grzegorz.nitka@intel.com>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>,
	<anthony.l.nguyen@intel.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>
References: <20261027-reduction-v1-4-81237c67a361@intel.com>
 <179323521502.3134.1640101944514020934@kernel.org>
 <20261028180818.72e882f8@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261028180818.72e882f8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|DS0PR11MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7b9db1-9b47-49df-abe3-08df35dd0814
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|11063799006|4143699003|56012099006|261009223027099003|261026140227099003|261022105027099003|261028144727099003|10067099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k+aWKLDJCXGHPcHBN6GUoMlyAt6Vew7e9dezexD7cuDS8LCjmGDBgXJSumo1Uyh0pcSjmHEI+Kw7XFVXntEyT0kPTJPZOACrZwKBUcF4ub//cj9GLP+LtsO3zlXBy5mezLqhAvmFYoiEm17dQfMd5tqOD5vYWHOp7JNulTtxwDqP+e5OViU3i4r5paHWHx3bZ8pCkbTp8/SoKfoMqkCrZTFKj8cTb1bzH+KauaMh6RDiZZqXxuD7oyToceMDGdz43Lk3yv4qIlpq3tTVqi4B34y7Pgw/oWoqzDv+gON65q2FGwpzilQsuPFa5a6A0L/OmCaDZc3Kw12RdHrmvKO+e51blkIsBcmxfzhtK8UtYeQJTu9b9pGi6MGvs0UV4ZFg1lzigYzhQekU7j/BZrSVXATsJiJ2D8aKIj6+JB0Uijit1Ea6+z/mg3Ud2SZ1oyhd2WYHPzRgV4QFRne1SVzDUMF3HLIT8LIiErB0NdKEW30ZbkcQgW3345wIfz1RSg9SSa4wghv6/VM1SzPEbXvvq6pTb6ayyLOkBKhyV939KagKrv9F+SAwLjEB7Aoh6t0Pl+Y5qlNiNvjN/1G+ccDrXYHXijljYJFNOuMWgghmo5Ww0Qx2jMjxEBsuwz5nOv5eyt1FDGFPNQS7H7U8dRJgVaaw8JvvebLruUCW8tApYRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(261028144727099003)(10067099003)(261021121427099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGYxUkdGSDEwelFHRjU3RHd3dUZOUHM4UzhNdmNKZ2svRTJMMTYzbkcwalJo?=
 =?utf-8?B?UnpWYzZ5NDBQNVJlWC9WYnp6TVVMeGFwVFl6SWZWeTBSbUo5eVo1SEYwNGVr?=
 =?utf-8?B?cmxoNHhQTTh2NGN5NzIyR2hHcWhaZW9sNy85NFdzcnpxRi80MHQrUzZPVEZB?=
 =?utf-8?B?MUR5Y0gyeGtYN0dHVUQrbUdza3NueEJrMm1TbW4vMTBIOWlkMklzYkY4NCsz?=
 =?utf-8?B?bEgySnc5d2VWZE9NUGF0S3VtQzlseDVGS2l1aEZYcDhuS05CSXplMWxxRnNQ?=
 =?utf-8?B?UXo3NHNPcXNlaWxvbytIaTE4MEdyS05tY0VTaVJ3eXp4UzhWQk1nNGtoMnpL?=
 =?utf-8?B?dkdCQkVhaVBZcUt4MTRTczRlRisxR09QbjFaVlhjYlZCRmIwbm1jTnF2ZldF?=
 =?utf-8?B?M3NkVUQ3U2hKWjV2TWNpekg5LytBYVUrKzU5VjlVK1dMZXdkVDEvZVhramFE?=
 =?utf-8?B?TmdSS0V0U1AxUzhMYTl3QkZzdWJoWVRoY0JYOFBra0Jsc2pqWEVtR21zY3pL?=
 =?utf-8?B?cGRsVmZXeXVKMUc0ZWxEVCtpRHFpdXFrSFk5d2MwNW1nYVlEeHB4elc3TVRn?=
 =?utf-8?B?SXc2R1FTeVFWRVhnR0VBNlEzQVR2L1JVTUJOem1nVjBuUmZlNVllbFVxNmlL?=
 =?utf-8?B?RVNFcUlqbEEwT245ckErQmxMZ3FEWkMyWDFjbllROWFmSWdMOXcyOW9kU09a?=
 =?utf-8?B?ZU9ma2hGZkF4eU5jajRIVFhUaHlNNk11VGhYcldhQ2ZrR1pVUGl6RE02dDRh?=
 =?utf-8?B?RVovVDBpRHF5L1NFYmRGNUF2RkZKS0h4dk5EcHprOVcyeVRNdnJrdHk0TUJY?=
 =?utf-8?B?aGJySmRDZEtwWjdkNTI4U2c4Q3ovVW1VU2dpMUVOblcvZy9lWTVEdDBzd095?=
 =?utf-8?B?eTVrVW1hbDhRdkdQRjBGUDY2UUFSVVZlSG4xaStaSkVhTStsZVY5MkJYOGl1?=
 =?utf-8?B?eGh6b2xIaDR4NEVaWWZpRnJyaWU5R3J4UUZZeGZKYm8wRG1xWWVWdnM5Q2hv?=
 =?utf-8?B?M0d2ZUtMY1ZGUWNURnM3dHY1VDBuWnd2SkVvU0FKc0dIU0J1KzNBYzdacTRr?=
 =?utf-8?B?VGQ3V2oxL1E1MFduRnhGaUhicVc1VDZ6bmRmVVlzazFGYzIvaWZQZ294aHV0?=
 =?utf-8?B?cU1yYUk3U0hMdldKQ1duTnNjeGFRdWl0OW8zbk5UU2Z5MW1hZGEzenVjWC9u?=
 =?utf-8?B?VS9FRDRwU2NMQmJwdUwwdFJZUzZoZmMvSytJbmJyeHFXTWsxeHVTSUV6d09H?=
 =?utf-8?B?d0VKN2J1MW1rZTcxWFMzRmVyY29jbWdIUVZCMFIzWGtkdG9ERk9rZTBsVit4?=
 =?utf-8?B?RUJwNWU5eDJ2SVZxMXdKQWdCZUg4ZE1Bc09lWWcxYUJNSEVoN092WEVFa0pY?=
 =?utf-8?B?cDByNGVxck5EVktEY1pMdDM3NHo3dUZka1hmUVRHaWJVZFhEY3VDYXliZmVl?=
 =?utf-8?B?UWsySDcrNlhLdm02N0JsWG5hOFRhMlhBYzlUVXh6QnJFcXMzRHZ3cU05aUdt?=
 =?utf-8?B?WDFHN1hLN2IwOVhmVkJlcDNPelJ2UGdzSk9wb2xmNEM5REpLQ05xZE1CZVlO?=
 =?utf-8?B?RWN3ZnhLWk8wS2FQT29lNThVR21zTndLVXJsaUlwUWZyV2pHNjFvcVBVWExu?=
 =?utf-8?B?OXo1RG9PWWFxdVU0Y09GQkdWVXIxbjV0eEVaSGhBQWJ5RlpqR2h3Mk5yR2hY?=
 =?utf-8?B?V0NlYmZjRGJWTDJ6YmE3MVNvR1hGclpUdjlJS29CM01HTXoyOHJvVjBienRh?=
 =?utf-8?B?bFJTbEpvM2RLTHlTdUhrNENnVk0rR3NMSWJVOVlvaWxIaStGZGExb2plZW84?=
 =?utf-8?B?V25LbkUzL2NhQjNKWUlJNlA3aVpkaVBYNmJjNE1oODZVRUVKZHpEUVZSTGd1?=
 =?utf-8?B?QTdlQzZyWTRMQVJEeTNDRHRtbUxFK3I4bzZOK0JxRkdBcDZJbG1WSGR1UU84?=
 =?utf-8?B?cmlmVEtWMGdjZVdkRHdZdXRrY1Uvb0JiMW9sd3hJMnNFMU04UVBYZnl5eVFZ?=
 =?utf-8?B?UittVEJaVk9YM09WVTVYMFZYMXVXa2ZMMnBjTVF6QVBHS2p6WWtjd0hlcmVr?=
 =?utf-8?B?aGxGQTZlUjREK0JRb0ZmVXJSaWlFUEptRU5KMEZMc3VjK2JSdTRDWWZ6U2tr?=
 =?utf-8?B?eXNWYklhb1NmOERJaHg3by9hUk5TNStFMWZJNWNtc2l4RHVSdTZhd242cGFN?=
 =?utf-8?B?cUp2KytYeFE3ZlFjNFhhWlpRT0xYZStleTBYb3RBbllhdnV4djZXcldVSGpC?=
 =?utf-8?B?UkhvUjdqUit1RVdnRWdhSjVYaGpGWWxRbndPWjdia05PNGdIZTRtRUVDdVFm?=
 =?utf-8?B?c2czRC9qYWMrUHhORWFZdHNrUmhTL0g3VTVEbWI4a1ZiYmVNWk1xeE11ODl4?=
 =?utf-8?Q?34MFpQrmA6oklnt0=3D?=
X-Exchange-RoutingPolicyChecked: Tbs0MMtOj5CQznMyH7VO/DVbBYBZyGfzNnFWeHTlvqxjUQs4ORqfBuCAlIrYhs7FCL2chLpgpoEOjTwVNEzXuDZE0RSKbabbwrTkqimeiDhXrRHEkUumG+vsCkB8PJwukPSALVBvf/ktTa9iFhSVwr3rzrzSBDVeQ8OH9YqlqAYErAgWb0S0xM2m1yp2n0Q+aFf+zm5ZQMgOksNdC88fDdPuHDwJtP7f0WsSrttbGtq9ryNFSb6DhJBnnirVw6ObpZn8gaPP/uizfk2eimN+1gY/P/3cRIe4JkjwAiYG/+QCifxw8c/eeH54DeEa+YSqX+tpBITb3QGh2QtUxa5VTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7b9db1-9b47-49df-abe3-08df35dd0814
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:52:35.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G1EZ5JOfOeU9LjGn3hxkfWqAdjXs5ZLZ7tDP6Sp2L5A/1THVQ/GvfzA9vq/QnMDbJMt0o20R/IzPuQNv7rquooDlNnpwfcYR75DSR+aL08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8181
X-OriginatorOrg: intel.com

On 10/28/2026 6:08 PM, Jakub Kicinski wrote:
> On Thu, 29 Oct 2026 00:53:35 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [High] ice_ptp_port_phy_restart()
>>   (drivers/net/ethernet/intel/ice/ice_ptp.c) now returns from the…
> 
> Looks like this is because of the patch droppage.
> Let me take the first 3.

Ahh.. ya. At least it caught it. That's how the original series grew so
big :\ Little bits I kept digging at that created dependencies like this.

Thanks for pulling the first 3. I'm going to rework the remaining bits
and try to get another smaller batch that includes the ones some
stakeholders are most requesting ready.

Thanks,
Jake
