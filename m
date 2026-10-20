Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792455118;
	b=fLCVLN+qKQhEC3mAVYDXC7lPGkWCDoHEDIiYOm1dtpKNBeSwix65aK7TwhhSiyO0uS3T
	 R9qwRjyEXt/oYU2tCD9ppQjpfpgo6QMUVzIBcA3BfzLl6YaxvSn1GaPnC/Oe+4Hs8wmze
	 xta4gNgXjOrpO+2FPMcHzDaEh6n3jCSC4SgkL1qn5W+ybfkHbQAuHeGEXRhaUbtK8WPWM
	 11x4L2y3pgbMB69jnisTIVqkttJl488U2rwHInm3rt4L+hqYS4meB6h4OCwCvGK/NOC1g
	 w6b/p2xHRQYJ4+64UQSEDerlfYJExXwDoJIASE5gCcKWcwI5zKYldReBDcGZ+D9Ov2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455118;
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
	bh=JY0w5S7dGEM2q2L3J2dHIbSrxWaT81sFtZ/ll7XOdRQ=;
	b=NntWQfzjhpK/W0SK/M/U5eCuBMQwciiE+GS5Z7IcIVuCpDzsWg0JIg2NKsDhq9bxl8qr
	 by8iOhFb5GE23+vDNL9XT7o/X1uuGB6Rn3tRgTu6T5ZyIyl2dAOFYnmof+8OgT9vap5Vd
	 Dg6baJDsBAT/h5zD1d4J1DjB0tUBeGnKv+Mrpo6On6VWPX/Cs5y5iq3Z4geU0HfnZbViQ
	 3cf4Pgr6NL34E0VFPLSWYVQzlZ/T+J9lwcGAZdcboAWPD6Jw9UQ9i1KvnWhL4hnEnJK16
	 baX6Sb9kWuYx87XXtTDiYl8wMUXLsSqHZ9GjD9pbNU1AdH9zLADL35FwtxhtYol0beA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xt4hLJkj;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3188606A32E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3188606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xt4hLJkj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792455117; x=1823991117;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bzmQ8Bt29w1TCbEcMFsZHubv0948iQc32dVFqWbY8qI=;
  b=Xt4hLJkj8uTcqZcicuj73iY4qg7sbFth2lL9XV0NW/nns04so3DXomtW
   CYRG4kiCLEGmKL/8Ty9ZhbDwTFOECKv5wDaOg7jctO9MnBT3d1L9FJb/D
   /Ft/3GBt0oBthC2nZ3+VLyUcDIvcskJQ/brQ5EsllzV0fgaA1y+wB3B5a
   bRwymYkl8RyjtRLBjRYzMJjzmz99yM2My4XIzDEMy8RNBGMx2v+5lyh0R
   44beDQiwQ6LTJExDWA5yMcVdH+O09r6NZ0nG64ZCIzOhUc/8ZvuLy0mD/
   ZFlLvWbKXKRRZVX5pxUQd5/ngbn9xnVn3csZUARQpiPX0b02bmblwM1Lw
   Q==;
X-CSE-ConnectionGUID: NifKW48JTTK3433XaYeJ3A==
X-CSE-MsgGUID: 1agarL5YQW+ecvfEopWT9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1054343"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1054343"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 17:11:57 -0700
X-CSE-ConnectionGUID: /j9gapZaTM6YXnMmM+wdtw==
X-CSE-MsgGUID: YHq4+PMjQCKYPw/utHepSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4454404"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 17:11:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 17:11:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 17:11:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 17:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrwE12Zv2zi8NV+YwZFL/qZGBNK6mBWaHzboJ9zZdAr3D4kl8nNcGiWcmp6SZ+xIWJmWD0xGgmgk5XLIwhU0UBYRLRP1nxkmRL3VOK5xh0psQXpLRb8GYGG41RR1ODu9ttpZof2obQKR8w5PeKQiGrtfyoaIAJaEdoZfJ+22hGKDlPGoeWxV2wwy0wQV+iCij64lxH6zkL3d1jmz7VF93kULJX5CBI7/6FpaI+D/tkraNnD2AYhsaZd1zLW/fA8nL4c2JYVnPS4dDi62ap/ibo4QOLs62ZQt9dXRp4KxQPYldGFnMszUtco+c9qoSKMCWZyFxQkNClzJvBMzxt5pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY0w5S7dGEM2q2L3J2dHIbSrxWaT81sFtZ/ll7XOdRQ=;
 b=TlKOWGsY+PSWA4cX5eC0LFlWEGf7xwJO6/mEg24pG3VPg2Oyh9/McoP5iqIy1j3a8qDTKKENSaN6uEzSuUJxn7s2F/46ynRPd8mD12tYIfL+d2zXO4sg2G/27s/GZLgFsz7LUZZK2pW6nC3Qpamx1UyvonfHbfJcmZvR7N4YgrvfBYZn+nNdl4nuFTstDXCmC0E04Xv6lfvp15q53yUguYB20z/HNLQWv77tQkrwcZfaDKdmub6cZ+c3OLFzMlFPb2LfQBlKR7PAW5aMjNN+BceKcrqAzOJKlt8Fe1f3Ye+w7gXFTgLRsQ6dbDo6GSqVBIky0cjym4SYFYd5JWHUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by IA1PR11MB7343.namprd11.prod.outlook.com (2603:10b6:208:424::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:11:47 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:11:47 +0000
Message-ID: <8902e581-02b1-4cbd-8a52-ad6f938230c4@intel.com>
Date: Mon, 19 Oct 2026 17:11:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 12/14] ice: keep Tx timestamp slots tracked until
 completion or timeout
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-13-anthony.l.nguyen@intel.com>
 <179244085652.3135.218744406584842048@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244085652.3135.218744406584842048@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To CY8PR11MB7364.namprd11.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 449a470f-e71b-4637-d357-08df2e3ebb06
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|4143699003|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ZBt9xROSjo5MQcyfyBCjiuNozH9+Xl6yA/gS+MW4N7mKy6TpWsvAp164Hq6gT9uXP5kSJ3Ex81Thgtog958znm4RdD6vjO8W32ufA6kQ7OsQGPSFYzVkE7vpXZrJl2cgmCitc8w/CnVK6HE10b+qzlCebQ98qAqEROq6UdXqK+aSpMLOH9CkjtYdnCOT2sVsenwRROva2buwkeIDNwVC4I0dBV8UlMhzFFoEzi4Cf4OWUUFZpYMUQcdRNSQR+RXW1lNB2L8sKqsuXL89yrNBwGEAkfwwKYRQYGUgQuexPhPfcOCv7DUbkfouwB6AS9EpZLUIzZzvgQmtn9/FXYC1/Bz9K9Hj3t3hfJ9HbnOeqgjeQk58R7X5WB6nWiV2lqt4aJd1ZLHfa1Lpn4Q7D79h2XCborMznDV2Klsx5JBjEi1pM3aBw/o7ARSpr5Z5BezTwqNNUKwAyyPlydTUVDknLOE07xHz1wBC9iUvCOSApCj7fUtJ/AN7o+ZE/3XtBtiMQvogsi86pkYUnW7mYYi61m182MvpuTU2qPjyZl9Vpi9mg4mGDfaWQTc4bWcHeQm2kSMx9ui6pnfeyzH/Ca3EN55lw7BUTE1Td9dOgKVBwJvNOcAXE4L5e1eBAGfNnx9V5DwEALDCWW04/yIxaVwcgvhtIQ5z8e6etJEWoFVjx9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHp3VmMvbXpyMEpzWGRSZ0xjanE3WWZjZHc2TFVmajY3bFlJcmwzZ2hERFc4?=
 =?utf-8?B?Nmo5Vm0xMys2ZURlVGVIYjV2ejZIQVN0emVqSU9xQS9VRk9GREJWUHFHS3pD?=
 =?utf-8?B?TUNKRExvY0xEaWQyZzczVEI5cEdRWjJSQUpaV1BBYUpIejZtMEdlOGs0VnQv?=
 =?utf-8?B?UjVUT2tDUTVQZFU0b2JWTHdIRllhWVpmSHdmM3AwNHdIQU9IM3BOQzloYVFM?=
 =?utf-8?B?anhtN2ttZW9QTU1aclhydlpBVjlMRk53YlIzdjdBdjhqbGVtc1I2WDdrVm5z?=
 =?utf-8?B?NnEwVUkzeElJL1d4WlpzZnovN1c4eVRLQW85eVBQSTBsbVVjOXNSRmY0QUpO?=
 =?utf-8?B?eWFTTG9pdmVJL3BMMmMvNUZyQmNQNmpYUFkrQnFKK0RMSEJvLzZhb1FBcjY4?=
 =?utf-8?B?M1BTZC9Gd1dqQ0lsYlpjanRSTW1PUFF3V1R2L0pDQ3ZzcnRwZnI1a1RQM2Ur?=
 =?utf-8?B?U3BTeGN0c1p3bkliUFVFdW5QR1MrcnpQTnZYZTR3Zzl5S3RwTHZENDNCSHk1?=
 =?utf-8?B?TnBIRWpHQjdMMldUNzZONGdDM0tseUgvc3RTemhHU3g0bHcvSVFRR3BHekJ1?=
 =?utf-8?B?SWViSWdoNjFQWXpsL1JlcGhJdHpmTURza2NXTTRNVWdOUCtHU3RaYmNqTzBV?=
 =?utf-8?B?TFJaM2lwR3AvcStzay8xTjNra0VwanlBREtsT25SdGorbnZ4VGZicHEvdko5?=
 =?utf-8?B?K3NvcXVhc2RnOU1kRnFVM1lDWmJuRDBKN1dhcXN4WU9NcUlNN25Sb2UySkZY?=
 =?utf-8?B?Rk4zUkQyb3lHOWlBVkF3M2JMU2VKU1ZOWUVIbkVjcFZFVkhHT3JDZ2tXZTU2?=
 =?utf-8?B?Mk92SEtLRU13QkR3OTJLMGRaaDhnUHZzTkFac0d0L0pXTzRLbTh1ck1qdjVp?=
 =?utf-8?B?VWtFeG1qSVNsb2dYSjVwWm5iaGRaZUVobFlqY0hUY1gzYU1GdmVrdXVhQUxi?=
 =?utf-8?B?Zk5ZRDV5UENncXJqaUl5bW9hcE9EeitRSm9Fakp5ZWRxdW1ybGZiYmc1WWlV?=
 =?utf-8?B?aDE2di9xS1Q5TEJGQVBHYTl5ak1vZGJYUUJjTjNXdElHT1BVV1RwUjV0QlN3?=
 =?utf-8?B?MmRyS2pMUWkwcGlLZURFTkVGZVRUb3pnYjZNa1VOeEFYSEF0d0IrdE5lc1o4?=
 =?utf-8?B?TTFYalVSZDQ3TDg2QkY3b21FT1RkbWNUUlE4aytscUlKMkN0TDlyWXBZQjlp?=
 =?utf-8?B?N2ZHNDNXVWVNN3lOdXRSd2tPUDZqVnZWM2V3c2dRSytmWGNMd25DVFNnT0lI?=
 =?utf-8?B?VFhVYWtxS0habXVTL2FMbXB5MTlXSXZQQVRkWmQzcm1GeFFJR01DR3hjYktZ?=
 =?utf-8?B?VDJBZkhRS1UvMHdsLzJ4eTNLMTc0NTVyNUpqc3BnN25tSDFOelFZRWF3Q0lL?=
 =?utf-8?B?MFU5dHYvaThoUjd0OGFxOXRnRXFmckpkaktnZ25wRGhkQ25FUEhJWHU0S1FK?=
 =?utf-8?B?eDlCbXBKNXhnU3JQblZMSnVXNXJMbVBIM3VLM05NMGtOQ2MzRmNWRERZQXlz?=
 =?utf-8?B?R3RxWFFYNkFXZndRNEhNaEUyczEzT2xNVUNWVmNLanFpLzhqTmJ2VUtWWU1E?=
 =?utf-8?B?M21laElrRVdNUm02MGluMUl1c25QY0hiVEw1K0Nxcm13MFhtUndjWU4yUUNp?=
 =?utf-8?B?M0xGN3RUc2pyR2RBc1BKN0M0ZERCNnZJWGRuNEdaRHpxS0R0dUJJQldVWU9v?=
 =?utf-8?B?WTh2cFAzT2gwVkRwY1pwR0xHV0dicjRya0cxVE1lcWU2WEFKYXNwNGtkK3Fi?=
 =?utf-8?B?Vmp2TkhMZTdYOUJVZGZMZ0lYb2ZjWXJ1NlVkUHFVcXNLV0hWWFZGbXdGdTFr?=
 =?utf-8?B?OHJPV0I1T0RaRXo2aU1KYkw5V2RwWUd3WFprZGNNSDA5NWU4TDZaai91dnpp?=
 =?utf-8?B?cGc5aEgzQXN0bkVRNzlIVWtjU2tmVWR4Vys4clQ5RFdOSXNEVXdHR2R6ZEEz?=
 =?utf-8?B?QVZyN0tEU3UxMmZ4Z0o5RkpKaGRHdnBNejlKWHBzVE05UE1FRUlDcHowWjA3?=
 =?utf-8?B?cUtObjk2UDlmL0o2dWVXUUF2bW1yd1lOanB1dU80eUFSRjFQN3B6clpqb3JT?=
 =?utf-8?B?Smp1dGQxRXp4TWl4UW9FcENsSHNHdVRoVmRnZEk4VnBjUktYUWxhcVBBQmVF?=
 =?utf-8?B?dm1aVThRNjRidEVpWDBLNlpvaTNxdGxpb014Mlc1c24vS3A0V2dGNDRib0U0?=
 =?utf-8?B?YlE0M1A5K1MwanBpTFY0TS9nallaQjRRbEc1Qjhka2k1a2NSdm1ZSmU5NU4z?=
 =?utf-8?B?cTZtTXFweGRMNjF6T2VyWnl4M2g4Q1VpbGY0TU95WGE1YllvdThBWHh1S3dx?=
 =?utf-8?B?ajVtM3NSKzRUbCtRR1lWTjkrZDQ2MU9TblVTUGhaQ0VBK2RhbXJKdz09?=
X-Exchange-RoutingPolicyChecked: 2VAM9D1txtS33gHUhlYjjr8wOP6GTgNvfCcseWxfm9fsI3npi7O7qBa9uwCNTLUtTceL3OMvlr8+qgu6/77jEiGUrhbyECt9ntJzaf+G/8r0AaWQn/wpGMSnDG05SeOKSpjHQZ9IMlsVi8ZczUOww76TZi//0f4khyBFkXlmvM9JioF29GQt+MFhuQMwdV2QnQnHjsFCeiK9YNE5/DybrYjHoHd2ZSAnwKUDm0ZuoQopmQ65ATsGOU7Y2HEGsTfevFLDjVJZLPROzjU1+oq7q/ewrpDjnI+3WcvuENcbfRlrqKVQUDIaiJNgPHaNQm0KooTHp4dVDf/BKUl9zEyeug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 449a470f-e71b-4637-d357-08df2e3ebb06
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 00:11:47.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfrpjDQogq8OtlUE4KuOOD/Q0jHuidFJn/RrCR2oBdW16IG9tCqynWa7E0mtLOJ+bgAS+DBnLx/QQIUFTu6l+5V56v4MA0XiFWqXN12S2MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7343
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says this patch adds the tracker-init
>   check: "Since we're adding a new call to ice_ptp_mark_tx_tracker,…
> - [Medium] ice_ptp_link_change() now calls
>   ice_ptp_mark_tx_tracker_stale() on every link-down, before the…
> - [Low] The concern says the kernel-doc of
>   ice_ptp_mark_tx_tracker_stale() ('should be called when the PTP clock…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but in the
>   ICE_PTP_READY branch ice_ptp_release() calls…
> - [Medium] The concern: the 2 s timeout in ice_ptp_process_tx_tstamp()
>   releases a not-ready index without reading it.
> 
> --
> 
> ice: keep Tx timestamp slots tracked until completion or timeout
> 
> This commit stops dropping outstanding Tx timestamp requests when the
> link goes down. Instead it marks them stale, rejects new requests while
> the link is down, and frees a slot that is not ready only after the 2
> second timeout. It also changes the pending-timestamp check used when
> re-arming the IRQ and in ice_ptp_maybe_trigger_tx_interrupt().
> 
>> Since we're adding a new call to ice_ptp_mark_tx_tracker, notice that the
>> function previously did not check the tracker initialization state. Fix
>> this by only accessing the bitmaps if the init field is set.
> 
> [Severity: Medium]
> Is this paragraph accurate for this patch? The diff does not modify
> ice_ptp_mark_tx_tracker_stale(). The if (tx->init) guard in it comes
> from the earlier commit "ice: E825: stop clearing
> PHY_REG_TX_OFFSET_READY".
> 
> The message also names the function ice_ptp_mark_tx_tracker instead of
> ice_ptp_mark_tx_tracker_stale.
> 
> This patch has Fixes: fcc2cef37fed, so it is likely to be picked for
> stable. A backport of this patch alone would add the new
> ice_ptp_link_change() caller without the guard. Then a link-down after a
> failed tracker allocation would call bitmap_or() on NULL in_use and
> stale bitmaps.
> 
> Could the message say that the guard is a prerequisite from the other
> commit, so the two get backported together?
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index ca581490f3edb..57141e94c5708 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  			return;
>>  	}
>>  
>> -	/* Drop packets if the link went down */
>> -	link_up = READ_ONCE(ptp_port->link_up);
>> -
>>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>>  		struct skb_shared_hwtstamps shhwtstamps = {};
>>  		u8 phy_idx = idx + tx->offset;
>>  		u64 raw_tstamp = 0, tstamp;
>> -		bool drop_ts = !link_up;
>> +		bool drop_ts = false;
>>  		struct sk_buff *skb;
>>  
>>  		/* Paired with smp_mb__before_atomic() in ice_ptp_request_ts()
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the 2 second timeout
> later in ice_ptp_process_tx_tstamp() still releases an index that is not
> ready, without reading it:
> 
> 		if (tx->has_ready_bitmap &&
> 		    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 			if (drop_ts)
> 				goto skip_ts_read;
> 
> Suppose the hardware holds a timestamp-requested frame for more than 2
> seconds, for example during a long pause or PFC stall. Could the capture
> then land in an index that a new request has reused, or leave a ready
> bit with no in_use owner?
> 

We have to pick some cutoff. We believe that 2 seconds is a safe amount
of time to wait before we assume the timestamp will never happen.

> That seems to conflict with this statement in the commit message: "This
> way an index is never reused while the hardware can still write it".
>

I can try to rephrase the commit message, but ultimately we have to
decide at what point we assume the hardware will never complete an
index. There is no mechanism for the ring to tell that the index will
never be completed. I could increase this timeout even longer but then
we run the risk of many such stuck packets becoming locked for so long
that we can't handle timestamps. We *know* there are cases where the
index is never completed so we can't lock the index indefinitely either.


> For the link-down case itself, the device counts frames dropped while
> the link is down (GLPRT_TDOLD), so that case looks less likely to hit
> this.
> 
> [ ... ]
> 
>> @@ -1432,6 +1431,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  
>>  	WRITE_ONCE(ptp_port->link_up, linkup);
>>  
>> +	if (!linkup)
>> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>> +
>>  	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
>>  		goto out_unlock;
>>  
> 
> [Severity: Medium]
> Can this take an uninitialized spinlock on link down?
> 
> ice_ptp_mark_tx_tracker_stale() takes tx->lock before it checks
> tx->init:
> 
> 	spin_lock_irqsave(&tx->lock, flags);
> 	if (tx->init)
> 		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
> 	spin_unlock_irqrestore(&tx->lock, flags);
> 
> The only spin_lock_init() of tx->lock is in ice_ptp_alloc_tx_tracker().
> That is reached only through ice_ptp_init() -> ice_ptp_init_port(), and
> ice_init_features() calls ice_ptp_init() only when
> ICE_FLAG_PTP_SUPPORTED is set and the driver is not in safe mode.
> 
> ice_link_event() calls ice_ptp_link_change() without checking
> ICE_FLAG_PTP_SUPPORTED, and the new call comes before the ICE_PTP_READY
> check. Consider a PF without 1588 support, a PF in safe mode, or a PF
> where ice_ptp_init() failed before reaching ice_ptp_init_port(). Every
> link-down there would do:
> 
> ice_link_event()
>   ice_ptp_link_change(pf, false)
>     ice_ptp_mark_tx_tracker_stale()
>       spin_lock_irqsave(&tx->lock, flags)
> 
> on a lock that was never initialized. With CONFIG_DEBUG_SPINLOCK this
> gives "spinlock bad magic". With lockdep it gives "trying to register
> non-static key" and lockdep turns itself off.
> 
> Also, ice_ptp_alloc_tx_tracker() sets tx->init = 1 before it calls
> spin_lock_init(&tx->lock).
> 
> Should this new call depend on PTP having been initialized, for example
> by moving it after the ICE_PTP_READY check?
> 

We can try adding a state check. Of course there are also complaints if
we try to check tx->init outside of lock too :\

> [Severity: Low]
> This isn't a bug, but the kernel-doc for ice_ptp_mark_tx_tracker_stale()
> still says:
> 
>  * This should be called when the PTP clock is modified such as after a set
>  * time request.
> 
> Now that ice_ptp_link_change() also calls it on link down, should the
> comment mention that use as well?
> 

Sure I can fix this.

> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch.
> 
> ice_ptp_release() destroys the PTP kworker before it unregisters the
> PHC:
> 
> 	if (pf->ptp.kworker) {
> 		kthread_destroy_worker(pf->ptp.kworker);
> 		pf->ptp.kworker = NULL;
> 	}
> 
> 	if (!pf->ptp.clock)
> 		return;
> 
> 	/* Disable periodic outputs */
> 	ice_ptp_disable_all_perout(pf);
> 
> 	ptp_clock_unregister(pf->ptp.clock);
> 
> Neither ice_ptp_settime64() nor ice_ptp_adjtime() checks ptp.state, and
> on success they call ice_ptp_reset_cached_phctime(). If
> ice_ptp_update_cached_phctime() returns -EAGAIN because ICE_CFG_BUSY is
> held, that function then does:
> 
> 		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
> 					   msecs_to_jiffies(10));
> 
> ICE_CFG_BUSY can be held by a concurrent settime or adjtime on the same
> clock, or by ethtool set_link_ksettings or set_ringparam.
> 
> Could a clock_settime() on /dev/ptpX that races with PF removal queue
> delayed work on a worker that kthread_destroy_worker() is about to free?
> Could it instead call kthread_queue_delayed_work() with a NULL kworker?
> 
> The ethtool paths can still run at this point, because ice_unload()
> tears down PTP before it unregisters the netdev:
> 
> ice_unload()
>   ice_deinit_features()
>     ice_ptp_release()
>       kthread_destroy_worker()
>       ...
>       ptp_clock_unregister()
>   ...
>   ice_unregister_netdev()
> 
> Would unregistering the clock before destroying the worker close this
> window?
> 

Yes, this is part of the entire issue that we register the PTP clock too
early and we unregister it too late. That should be fixed but its a
pre-existing issue that should be fixed in a follow up.

> [ ... ]
> 

