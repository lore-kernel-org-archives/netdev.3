Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A74381EA3;
	Wed, 29 Jul 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366386; cv=fail; b=d+I3kzCQtIJcPEtmPiubmZsLKv/sy8OrzIFOiHGebPix8DfhZkmUbHZ1tq7HF8hozUjLz6XoyxcK+0od+UJXMytu0uPYWoeHofQcZvalV2WBJAESUyIDYelZgXNlkbUhiuVi6XdDTf3X7uSZpfsWLcy5fzvzBe0Om8ev4tA54y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366386; c=relaxed/simple;
	bh=iUC1qMuTeGhA3p+Zq7XOpS3dZWr+t2UcDWJ+eYWFYvk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EmgGLjxInFv9G3QD2wYZxsU2AgYTwm8F62TZIzFxKLJEQWEXluP/zRwpoTrX1gajx9ByKeiEuQ99lBfK5Yp696CsSnP1YUngiANsRJ1gMTS6Z3zh9LyA9v3Nt28mI9X4xLerjCTJJJPLIbvWwhVc/xrg+q1dKaZZSWAUIw2Fhgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUaj+C8X; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUaj+C8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785366384; x=1816902384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iUC1qMuTeGhA3p+Zq7XOpS3dZWr+t2UcDWJ+eYWFYvk=;
  b=eUaj+C8XEwnurKZ87aQ/ZEvhyCwYKIGck+mkAh7BDqq935LWS13jtEaU
   YgNgIHwTY18YAXUT5g/go5/4DG0OTjVNTUvXHGiaZQW/ZjBjBVQJZ5tJd
   Eat3nsxT01MngzAo459cj72SIj+CxjnWIbdd14WY4qPTN0IZY8mAkb5GQ
   uwVB6bXieGhuWu/awQ4ygNFtN20DoZ/nrQ+ghc3ewrrx+WYb4IejPEn5o
   LTcvhjGFnNJtWf5osbHT+OzJawP7TA8WxP0rOMGIzXBksU785490vuxgx
   3/WKq5cyW3End6Rc9I/Ne2JSxRD9IBXQtisSYnLSbAiNaZWl++WgYl9Xg
   Q==;
X-CSE-ConnectionGUID: iO5FPpEtTXyTtlObYXWsZA==
X-CSE-MsgGUID: iLXarmVrTHSwbr1+958VQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85856897"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85856897"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 16:06:23 -0700
X-CSE-ConnectionGUID: w9noEg09ScaCVIQY59YSoA==
X-CSE-MsgGUID: mrSulIkyT2+EK9aoi+nzjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="259557295"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 16:06:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 16:06:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 16:06:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 16:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaJsuyMQ+vII31T9sJSvb2pBK4JuW1Tkl9gnyScJcohvGVzBn9WP3isoWu6AO/PXjkpNMC8hl7BN6MpjhLdf1iRYy8C73bFe8znIRa9tguoaXuFwZ3qMjWSs40Gt3LYv6Pdd2zhD1DzG28aSDcBNpZDgR/9bK5wTr5SWypz25d07fym1kDaHGNYzOv7HlzTKtcftPH2thvFPccq7E7UCdS7dQxVKFsrcpTnSm1Nqjukh+5mjlFTYMcANfFscH7XnQajafJARIy/18T2b8SNNyLdj9aDbLAZKXds5yoI9fdiIoiaYDejE8fK4VCZHNXKnB+KMmv1Rh03slndeplOV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFQBpxdLold27fGeGkIO4WZGTItfHUmCquUkbjLaRyM=;
 b=q+csE0HIuA0EQ+66twLS2M0YQ4FNg1vqkOGgCAuvznYiD6nFSuDDRgsf1yYQ9f1VahOL8Zc183QdOZezyCyd8EwzSNtI3JauhGDPQL4P1aOJPYKlLwRCCXx4CkHNRecoTuBlBXbOsf0MrRInLrQy5RT2UC/pQ+iWpoZovcKANzeJx1GkmRZtCNfXrYpCaknioPEn+FPBioGD+X2qUhtU7/TVogrZ3QkrZhV1xcytTxamrzYl1IuRC2iHGaJL+WT3X4k3MsypknkR1CGFjmdVAP+MCV2T4D9SanaEU01ydsUv/FJI1qK7Rrw0tFKnFlPXtWeqkYP+cjV67hqgJsBbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 23:06:20 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 23:06:20 +0000
Message-ID: <1bb991a9-cf32-48ef-b009-ce9ed8e8a4de@intel.com>
Date: Wed, 29 Jul 2026 16:06:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] netxen: unregister notifiers if PCI registration
 fails
To: Can Peng <pengcan@kylinos.cn>, <manishc@marvell.com>,
	<rahulv@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260728032046.121631-1-pengcan@kylinos.cn>
 <20260728032046.121631-2-pengcan@kylinos.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260728032046.121631-2-pengcan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a39e0b-4b31-464f-a167-08deedc6006e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: HBuFeJ8GXt9QqOHNjyb8fBOXknKvZK5uuWh7V9Ohzv9DDjUvtQICLJXQbT7lexaKDtBFgYtb0zz5gkmjLZKfApoeFzjQQRdZqLrhQ/1oeWY1K+bQ57uER+Ob3SWMo1OFyLTpNPIckYLkCK3gzFUwO0V8jl0jI9iNW6r7JtinrBcqDI5+SevXnfN7j3+yEla/1tWSUcEetDiXOMau0on9qCBfu7V4APnHnBLZP7ge1CTWz7KdCziAvLywqWkr93duZbKhb31rIv5MRXV+3mcIAyLzVu8LlSpu9o0R1lIN7RIwGZui8D4gLPnOsc1Fv6umx1Ukk/5q7ZmnKPfBLO8ec8SnzrZY9TFrl2/2wju5YdAy9N8A9UXpmU9UCLM1XIE9tsOobPzxXgyVFBvm3+FEnqrdGXjZt2kjxWHben6zYkWaFSBp7LERjJQnf8lWuttayU2zQpev4QhWvSy16ZjNl+5KPt+WVqus+pRoWs/h+pLYvsoUIxwaGRv5ol5TxCcdXEbNxWS3hVy3I0lksGtUxC0mj6Tc6FTGGIgRAdySOOCYPBQ86qZ0RbF8LTS65WyN3eoA0AYaesqcU52fynuxkTfc2DdSvw/hUGU36j72ROCNlO0iGyCR73ln6yTqWgCPvfcoxf5EDEHnDQlOmE4uDDPvPie2y36D/UXBXorUlsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk8xWmkwME8rdzNRejdZSDVsbk1lMmtLdmtiS2xKUEZ3b1NYR3BiSFMzeVhX?=
 =?utf-8?B?d0c4SlVxcktvdDQwdnpKK3dBRmNyOWxBbEp0cTlEYmZNZGVCQW1sRVoxVTJL?=
 =?utf-8?B?MDd5QzdSemI2Y2E4M3NaTjVSdXJ4VE9tVUNZREx2RVRVaUg4c3VaYmt3MXRw?=
 =?utf-8?B?eTExelZoRDd5ME5nUUlVWFpNR0w5TjVQSVFYMmlOSVlveWdaNTlBVmlTbXk2?=
 =?utf-8?B?M2VWRFZmR05vVWJkYVhFcGl2QlRTek9YZllES2dWb0xVNTFRMVJTeFdLRkVF?=
 =?utf-8?B?Sm9lMjkzcXhHODQrSnROVGVQSzgyYnZRRCtXd05FTGN5c1RZQjBkS3hRaUc0?=
 =?utf-8?B?V2tvWkhjcER0bjNycWU0ZUhyaDVTcnMydzFaL1hURW9NdmVQY1FMZ2pibHdU?=
 =?utf-8?B?NjBSZzB3L2xZa2xCNGFuN2gybWZvRUU1OFRBNW9hNTRIM2dPT2MxTWVpbXVP?=
 =?utf-8?B?eStDejNWT0Rvb3pmWGZ6RkRHYlVka3BpVzZJQ283emlmaWNxNmdPdU1MNDNK?=
 =?utf-8?B?enNuYWp3SDBHUEhZMVFnYU13c05BckR6N2hsSDlOckdNaTRSS2p6NU0xMEti?=
 =?utf-8?B?MzNqUTV0TVRiN1czODhyRllTLytlaW9lTmlWbUVJMHdzTnRrSHpGa2FUQVlu?=
 =?utf-8?B?SU1HVFZ2eDViVzM5enJYajZZUDlzeC9mME5ZSlZ4Vk51TEd2YWJWb09jMHNZ?=
 =?utf-8?B?RVczQ04wUHlTQjRQalZBRGFjL1duYzNxM2dTMzNzbWNHT0xNUERwWDIwSllD?=
 =?utf-8?B?NDI2eGNrNTQrdWh4c3BXUG1Yb0NKNDRWSVdoKzh6SjNhZEN6Z2lzN3ltRkdR?=
 =?utf-8?B?Vnl1TWNFVUxOSlVUNUgxaGdma245Sjl6SmtUeWR4cFBBRnU4R1NoYys5Zy9R?=
 =?utf-8?B?RW9LTUF5RUZkNENYOWlJdnVjR0NmY1gxWFhwTkREU2NaM3Judy9IcUkyWUJz?=
 =?utf-8?B?MUo3R21icnNwdkg1bDUxUWEyaFlQWkZveldpZEh2ZmpvT0FBM2paRW16dEFU?=
 =?utf-8?B?WUduUWdnc1Y4RnFVcVBsVFlkZTBKK25iYzJMV0VoN1grbWRGM1ZQQ2NtNlRl?=
 =?utf-8?B?R0EzZzg2YnZBY3JFUWJXMzRZZUlVaWgyN1RwVndGc21QVEx5YWY5dXgrQzNx?=
 =?utf-8?B?REV3ME1PZHF0MVZWNm1jVDFPVytKaVgxVG5TQUlJRC84ejBHdDBrbEE2eTdi?=
 =?utf-8?B?M3d5Qkd6b0F1bnllaFhiR1RpdlcybDBGamRmQlh4VGVNUDRPSjRrNUFwWEdP?=
 =?utf-8?B?OEM1bGZ0RmJGanhOR09ReERCa2tXQXdpNmZuMU5NZkhwQXM0Mi9rVkNiS3RY?=
 =?utf-8?B?Q0hqdUVnSGNyOStQd2UzVE9mVkZGUXl3RmtjZ3gvcXQxa2FjS0w4YzIzMG5z?=
 =?utf-8?B?M0hpbmY2WEwwZkEwZkFnNFhIWGRNMHl0TElqT2ZwMzcxMm5DV2RFOTRQTEtT?=
 =?utf-8?B?QzlQanFaWmtYdVAvSmg2dTUrelBOUGU0Qzk2eFlPa0QzTzQ2eTFSTVg0OEJj?=
 =?utf-8?B?K3U5ODAvR2ZqaUZIRi9KRlVab2JrL1l3REpkbE1hZyttdmd4Y0p0QUtUejJn?=
 =?utf-8?B?N0tqVHJRL3pTU3RzKzRiNmpWNFJRc1ZmKzQxcExYcjlwNXR1ZEpRMS9BNUdX?=
 =?utf-8?B?UWZrRC83MktXdkZpQlN1NzdLdXNlNHBoSVBpL3orbGl1RHpBL0pVdE91STZx?=
 =?utf-8?B?cFg1WnRaS3JPQzM2U2dkcmczUWZLcUFFMitLeWJ2cUZYTjR3MkhDTWpIRTJR?=
 =?utf-8?B?VjRrM2s2Qzc3aVBXeGlhazJjQnhFakFBL3NvK0RoclFWbEYrZnordDR2THRT?=
 =?utf-8?B?R0gvYjZSSzVuQXVKTEtIY3F3T3lLSXlCKzhpSVZKc0ZqYnNXVVBaeDFFVG9O?=
 =?utf-8?B?bjZZMUNJanFvbFRMbEpiQ21GNnI4T1pTK2NXQjBwQUduV2Q2SEJ5MTRCbFZX?=
 =?utf-8?B?SFc5cjU4bXY5WlhNUEJib3VCS2hTNk1RU3lJU1pjZWFEQnIxbHFrYWRudVMv?=
 =?utf-8?B?M2lXK05WVnBYOGlXdnlnVzNqVk9tUVZEU2pJWUkxVXhCVkxXQTZpM0szcDJM?=
 =?utf-8?B?a0dyQVpZRGxsdkxTK1IzUzlhS3dRYU1XZkExSnJKbzFGdGYrbWdUV2k4Ykd6?=
 =?utf-8?B?MUdlVXQ3YmZISitaUnk1S293bldQRjJ2STFhbUJCanpZNmE1OWtoTVBSUzVt?=
 =?utf-8?B?dnpxbzM1M0YwZGwveHpJc0lPMHVkc0d6VkE2Sy9SRmZ6NXZyWHNGL0FncUMx?=
 =?utf-8?B?Q0Z0SkJXVW0wNlpGNmk3aXVJYi96UjlsMEdDWUVWWW1icDVRcE1IV25FWWQz?=
 =?utf-8?B?R2dHTVVINTF0UEFYZ2dRK0RvTDgzRzhIcHpKLzdUaTdJWVJWUjZlMnhiSU9j?=
 =?utf-8?Q?jXemkDnpxEQ9QgTo=3D?=
X-Exchange-RoutingPolicyChecked: WXbiRu1su64OZAiezWceh6JyIkK8tO3PCmgQp+WaVksC5v1JPDtpQsOi4xiV7vhJc9YjZAydnHmz8f5M/OQ0fXoCoslbZsb+gwQ2XNXk3nIjGNBTNOKo7Iq/KNLzHRl3GkOMDektbrpO5g69yt1XFJMCZyn0gzqHMW3pD45MdYNzqD23ccRiULtrd0msFDhuznV6yti6M/J3LCHNDJ8Kc9O3OsleUYMNBT5E3iVVTbYCwuneyOi2DxOmaWOCL5TGYFs88CNcOwDS7ISdN0pPKQc+1gNz/Rgdz2Wi82txJPoVKAkbFry5c5+CcAPeOIE1F+GA5iJG8jVhjVG6W2dwyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a39e0b-4b31-464f-a167-08deedc6006e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 23:06:20.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vdAaIHVX2/CifbwRuAgFx16A1lgVMclYFJfEtKiYBtDCtdYSFt+P9cRsE72sj8Qib/6ym7dk4j+9wZr7tFUqZSsgRO1mcSnEULpkRp2fvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

On 7/27/2026 8:20 PM, Can Peng wrote:
> netxen_init_module() registers the netdevice and inetaddr notifiers before
> registering the PCI driver.  If pci_register_driver() fails, the function
> returns the error directly and leaves both notifiers registered.
> 

I'm curious why it registers the netdevice and inetaddr notifiers first
before the PCI driver? I guess it doesn't really matter which order but
you'd want to change the teardown order in remove if you switched it.
> That leaves notifier callbacks installed for a module that failed to load.
> Mirror the module exit path on this failure and unregister the notifiers
> before returning the error.
> 
> Fixes: 6598b169b856 ("netxen: enable ip addr hashing")
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/qlogic/netxen/netxen_nic_main.c    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> index 5ee2bd9d6886..67d9bf69f8f2 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
> @@ -3447,13 +3447,24 @@ static struct pci_driver netxen_driver = {
>  
>  static int __init netxen_init_module(void)
>  {
> +	int ret;
> +
>  	printk(KERN_INFO "%s\n", netxen_nic_driver_string);
>  
>  #ifdef CONFIG_INET
>  	register_netdevice_notifier(&netxen_netdev_cb);
>  	register_inetaddr_notifier(&netxen_inetaddr_cb);
>  #endif
> -	return pci_register_driver(&netxen_driver);
> +
> +	ret = pci_register_driver(&netxen_driver);
> +#ifdef CONFIG_INET
> +	if (ret) {
> +		unregister_inetaddr_notifier(&netxen_inetaddr_cb);
> +		unregister_netdevice_notifier(&netxen_netdev_cb);
> +	}
> +#endif

Normally i'd suggest a goto cleanup error pattern, but this is a small
function without much worth to do that.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> +
> +	return ret;
>  }
>  
>  module_init(netxen_init_module);

