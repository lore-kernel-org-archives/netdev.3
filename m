Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792692420;
	b=F54+WkyitHTVfpLyiq1+h/ITK5oEo026AXqEXgZBKQAL4koOpC/H7TxopPjW7Lwxqf2P
	 hw2xV+ZhCIigwome7u16u4sexKAtzhQ6PjZvi/ncbIk6ZCS7q8SnaHzrjeUTJNJ1RJXk8
	 KmJ9Z5gyvHHjuuRTxsqwi9qtyYqqhdNbHqAMX20Prk+1Zm4HkA65xzJqE1SahhwKrYc32
	 fe9EsXs8vp0+wj0wtRQVpUPHHKEsGaEpLpe292p2ZIz4SC8f5zZfkwUP+52OFU+k58xYk
	 ZIuJxDGUEuwj36uJRCfzI0Q/oXT6G/W6HjNNZZ1YH+AqyR1W59beu1qRye7WMmnYOmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692420;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=PN925PIb8HwUiaZ70+rwWvpeaZYT2MN1T/ac32GHJmk=;
	b=terSlWcjKWDAdVlGjsCSbuojnliCpEyzofaFDNr/nXRCc4kMdhhGQE7+y5dPkcwsHEki
	 gHOUIDZ95HSi2mECW1wjfKN4RPdfbwE9HLvoZlOq4pSIqOjgWPxAIyOFRkHCeX2ipDTd+
	 oQv9AKdcCW6L59bmdOPWlhKIqcuVPWLwdH2NFVWi3jvZ0fN+6+rN1QMsgBcTrHTSA7z4I
	 NkloA5gfx0dKIb/6qaRNt835pYaIV3kI1Iav+oaWFU1eFzGbwXbW3Ay55i8wK7Fb7wE70
	 R20MBcmQXLdHjsuosbfIrNM71tLPEdDp1h2IqcCxKU5YjGj8RdhjT2uSol6fmDD0JMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LaqAXi3E;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B69606A31E;
	Thu, 22 Oct 2026 18:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LaqAXi3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792692420; x=1824228420;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wy+QOgHGwDKRz7fLGSk8bUkCG88kRFpuPbVpqitSP4A=;
  b=LaqAXi3EBZkIEjY/S99SxwmOFplMpORBXcElKA0yfv8p893dqG99eVcF
   jpL58L9MSq79vjV0pE5rx2pWslIdrgtD5W4L29acpdlXFU2jFBKY2U7O/
   8+m4fC3UWyAzKf4+cMr+E83mouf5POL1+k2kEQJzJ23Y0mtg+9TEQ7aHY
   D2kZ6FGhmXWmeWY0ujfbKF+woKHmboQGYh20muJuJsriu6R0jLOun6z6+
   rkqyPpi9RhJ17pk7RFjsLg1FclVPaVXwCCM2gwwcL6Nj6d/6ks//pTxy8
   H+4jwfvz+5BT390KWll1z+7j00LgcR4YbXVO3D5xuelg4MQ1SX8qgb/Ro
   g==;
X-CSE-ConnectionGUID: 53UYZStxT52vO5QXMz6wyA==
X-CSE-MsgGUID: KD4eBUz8TgOfooZpN0VhEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1352333"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1352333"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:06:59 -0700
X-CSE-ConnectionGUID: QNvvcklESD2XVvQzjT7ySA==
X-CSE-MsgGUID: IKEkcBLATiW58NU6v0X4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3411725"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 11:06:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:06:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 11:06:57 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 11:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5J/wUe5KtFeEBI037qkjV66qcvp9Db9Hi3Q1tqqTz177PIFACJobBtzNMhfKwmVljK8OzuLy4gusUEJ90to046180HR3ihLCSPGwQYNY7KHCKZsOk5yZ64r9881HpyPy3KA0fvOkw5EjN/qou6UrdKm7HPZ2z/2ZowKXFrzGsDASSQ0T36bEyZavmgOvskbgEjFxjuSUbg9qHNXYYMQpcDdVShtYDNE8Tf8XcFfGY/v9p61dZmsazIpIdFXU5GFj5H5MZdFDzqm7sCQ9mEzLTs619XTrb6Eu+kdqi/yx+wnMje+Kzbbphw039HjGrXbOupeOAo+kvZGGvdpKiXkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN925PIb8HwUiaZ70+rwWvpeaZYT2MN1T/ac32GHJmk=;
 b=oQw62o82AaavBf7CNw6gxFX+dv10FSVisrCqQWlLeqHLiHEVbOI4v3vLwrNrpgwIXm91znb8Semo5pTrtf0gOMeOy8i5FGlclknLDYSwvM61MlaqVVcYSpwKvoRAcFGTCjJwAbS13iTdghnqzExIbf2gdrOreRq+WPEURTJgznByaL6Xmz+3igr1mc7GUszkoW+0bVxqbwMSNXb1fAMk3GCDYxNHMtq7IWaFnnXB9clLr9stAwo14AXzMcwUNxFiCA/7QP/1fW3mhSycwvVuxjwNkbuGyMLMHktTbnkI59FPXXJvng0TEd2SXXtIr7OBwR0XjedBWGiA+yWCTtFSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 18:06:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:06:54 +0000
Message-ID: <f41b71c9-c9c5-46ea-ab4d-a847bcc1b0a2@intel.com>
Date: Thu, 22 Oct 2026 11:06:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ice: retain the adapter throughout hardware
 initialization and teardown
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Aaron Ma
	<aaron.ma@canonical.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-3-aaron.ma@canonical.com>
 <62a43d55-f114-45a5-824f-c09f87bea537@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <62a43d55-f114-45a5-824f-c09f87bea537@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW5PR11MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: eef0e285-cc56-4834-4737-08df30674128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|261022105027099003|261022075727099003|56012099006|11063799006|4143699003|261021121427099003|261021135927099003|261021123027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6at5xYJdamAkuRMf7xmYHAOfaerkbEgu0AKUqk/Q46wmKcP0L17AFNNAZKy0EzVgqYXVBAY7N2gkWTvxZNWYTrvrOFxqxubMrhKahllilnS2O04OwTWjHh+kFEDLVZjYXMAC0vrLl9jqQ/qxcdV5NeTTTlRjuDgdRzKBWIfUrpJxyWBoHf739gZcUQx5BMAMO4nyJRwt6JZ7qR9/krhhbCHYerCJ0mpVqh2YvdCzU+9ZCTDcbdSdDFwzaGsegvxdSgMjj1si4F85O7V20LsHBzFEWqn8xc94FiFrPoU6Odj3RFbDEZ1fN+EXvD51N5JEoQeRXwf6EVpjmC0qcwXp+Oh+WM3xQl0lZaum8G6jfbyKguMpSsXWInlFldXJvpO81Jgwhz2ayPmI5yIJk4KnmZGtSnipqzNrZ+M4BDvmmEK8rwJkhDV4B9Y2PzjM9PnkbbfRcePs80F3D8iizvOkWwuzVl9HjZLiJRSCLsd+97ZnJxyr30Xo+oDa0Zkpio7PAa6kfUqQfJr1MLSFJUBh62xeP495dxtpRHMZ5H4FlRPVx82cLoVsG0Eyc+d/rKltwtll2bhcAxTPqYMo3YjZYKdPMRnT8jin3kGng/p/Tb7qrbWiwLjEMGybb1EjJVl1guoEvOBmNzgRaSaJlDJlhJPuFd8JdjwYAjgSn1mfK+N1RQUHWjpE5qfylx4yr7n7oiaa0BvD43YTPNi7pDR9Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021135927099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0E5VS9lMzdsWlZaZjM1N3RuU0NFVFhhS091WFVGVER3WVlWZHdaQUdBc3FZ?=
 =?utf-8?B?bzFkeWM4YVYrd1hDK3pDZ1lyTm1xTkUzQmV0bFRkSi9VZVNlOUVwSktNWHV0?=
 =?utf-8?B?bERMOStmcWFLRjBydWZ5Wm1UTHFwYnJlVzZxNUEvN3N1c1F6QWRRV3hyYkIr?=
 =?utf-8?B?VFl3bFZlMUU1alp0OXFBaWxLakRHdGFxdVVwbjNvKzNNOVRTVkFXUzViOXhO?=
 =?utf-8?B?aUhwQW1KZ1VFbjRiMlozY21aK1NWeHlUMEJBN0ZHd094M0E5SmpiNjZRTER5?=
 =?utf-8?B?d056dXJGVEFRQlludDJjTUo3ektVT1lvb3grbEorZHJtb2JnRUY5VXZqTjBq?=
 =?utf-8?B?dmYxeXhvMXJOTjlLTTFLRlZtdUJxWkZKZy9RTjYxeFVBN3Bvd1VnQ1lNSGgw?=
 =?utf-8?B?Tyt6bVpNK3RsUzRFQjlBcHZYWFRTdjllRkoyRjJGUTJoT2hxMUJDVTRWcXBE?=
 =?utf-8?B?L1Y1UlM3L2U0NGxIL21NMnpUR0tYUnY1eXhiVHRaQVJIdkVSd1Y4Ym0yOFJo?=
 =?utf-8?B?RGhYaVBPeTVJRHozMGhFKzNEWk1XelRocGN6MSs5aStOSzRVT2lxbFNhc0p1?=
 =?utf-8?B?NkVLWXNJMzA0WnNFMk9VMmg2cFUzUUNMS1JLOGczR2VqQnpHRUFDZWNzelJj?=
 =?utf-8?B?NUF2d2xKdDJ5L0dsdEVnNFh6Qm5qUGxlWmtCeU5sdWlLaElZSTNaekZ1bThD?=
 =?utf-8?B?WURRM00vd1RKSDcxeEx2bFE3OHgzelZSK0d4VU8vQXM3VjVucUhPbmRiTnRl?=
 =?utf-8?B?RVZrV3RLWjBPZkFSSEhPaXdEeTRwMURsT3Noa0N5dDRtbnNvUDJrZnU4Ym9M?=
 =?utf-8?B?ZVZlKzhrbnV3dTVMK0ROd3Bzc2RUY1g0RTNsb0JFaUd6c0xIN3FKeTArdlE0?=
 =?utf-8?B?TGM2NktTS3ZWQTRtSDdWQ0hWR1dSd1dsUDBCQSs1WWFhWkZtcC9aaXhSS0tH?=
 =?utf-8?B?MnQyNld4UllXVG9wekV4ckVBWUFacEEvbEFHV2R1V0d1aU1rcFVEOTJ6RXAx?=
 =?utf-8?B?SUtGWWlUN0tWc25HcmR4ZXR0SjlYZTZISk9Vb091Q3Q4dlNrd2VVWVg3R0VR?=
 =?utf-8?B?WThHQjIweFBDRGRwRXVsVFBHWHNmZE0rd0JCMDRzWm1yak9KNEpSTndnMTlM?=
 =?utf-8?B?Y0V6MnlacDliQ1M0ZHhZYXZna3BOY0tJcnYya2hNdWcrOXh4QURmaG5RdG56?=
 =?utf-8?B?Njl3UmNJOVlaY3VaanI1MnhLeE5nY2xnVEdlcDhXL3VxZmZvaGdUM3Nya2dM?=
 =?utf-8?B?alNQSmN0TkNFeVZlblZqTHpmQzY0b2J1NEhHUWZSejZUQnVaMWloMCtWUGlS?=
 =?utf-8?B?aVN4eHRFRkRIOHZCZUhEN3A1bkRjVVg2V09TbFg3NkZ1T3hwWWp5UHR3UWNZ?=
 =?utf-8?B?Y0xjQmY1cDhTQ1FqeFBiT2ZxUnIvMkY5ZlhxQ3lsRVFIb0RNeHNnM0pkUWJI?=
 =?utf-8?B?blB4UnhwejFNNEJNR2dWdEU3VWd6MHkyQ3hyTHZPeURBMnh0c2NDWm94Vzh2?=
 =?utf-8?B?N1AyM2g0T09lODZZbXNGK0xUV2EzT3NHTnlERlhkdUZ4bks0Q0hoL2FpNE1p?=
 =?utf-8?B?SVlLUE10c2g0WVNKdmw5aWlldGJ2bVRQSUF4Wi9WT05CV3JFRERhWG1EOHVJ?=
 =?utf-8?B?UDNqS25EWVBsRWZTZVlRWnRYbmdPVnp0bldkaHZCNTlFYzVBRHA3STQ2Sm1N?=
 =?utf-8?B?MFpCY1lKSjRUS0xQQzBnR1dDOEpiZzFCSEVyanlJMTNiT2k4djJaRU9ORHZW?=
 =?utf-8?B?ZWlxL3dGVUlPUnBINDArQ0k5SEZPT1Y1YndmczRsWVhyS2pzSGk0UTFDWjN5?=
 =?utf-8?B?Qk1TSDV4ZUJRQ0k4MXdtcFBqWEY3aVlBZUhITWJvSG5tTkU2dHZ0cVdTUTV4?=
 =?utf-8?B?ekEyZXhDTTlqY3NnZWZrdHF6dHR4YjFYeHJOU1o0THI2c0tkRWNBa3VYOXU2?=
 =?utf-8?B?RlRlR3RJcW1uclFyZ3pETGJsL2lLNTBudmNhL3dTTW5xdW1pZEd4NFlJM0Vu?=
 =?utf-8?B?ejFHTG9nWlJMKy83TFpZckltRmJlN01WWWhSRytOUzJRVHlPRVordVhJMEVs?=
 =?utf-8?B?Slg0cTB6WFZKeHNpM0FQWGQyZ1Y3WGljb3ZmNGZxZ1dBVFpPNUkray9KQWs4?=
 =?utf-8?B?dXd3SFA2ZmNybWJGa010TkZyM2RiYWo2eTVVS2FZaXUzN2R1Vkk3Qm12dlBm?=
 =?utf-8?B?Q1ZVaWxNbUh4WDVHei9MK3RVOVNLUnNrNUh6R0dEYnZYNExvRGt2NnhyS2dF?=
 =?utf-8?B?VWM3ZmdUY01YS0VLVk4vQTNZS25leE8zQzltSE1EVk83VGhTeUpFbVcwWUpY?=
 =?utf-8?B?bStDNlFYdUdzdThnc2M0WTA1ck41Sm83bFVkMWdPNytnRGNzRWNVMTl0SUwy?=
 =?utf-8?Q?unfkc5EkrdGsU8zg=3D?=
X-Exchange-RoutingPolicyChecked: yMMXmjrzuA+nc+dbbbT02qU6Cycf1trNEsEgFDR2amEKG9vm4OY2ecKK7n0Qivwo3ZUiH5+FS3u488OqcQJB2hfjdSlQsXj+pIh2ni5Or72o/RcHy+a9RludtfzwrUK8/eGaWhjwFt0Q8ZvAemcozAsy6p4heB0UxCdJNIEcTkZGXzm7o3VUzJGquVvgAUfvITKWL2p/1L01iiLrGjHlByQydpSnEU8TFL/hQE6nxqLZDYVboE3jirEv28VVCGZHUKfYVeomonemrhn9EtexpU4Ycbv1h3/2sBOcdyAjrIyoq/SOFtc/r5WTpell2gdzXRF47ZTfDk9ZguS6gr4NZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: eef0e285-cc56-4834-4737-08df30674128
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:06:54.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R89W14QrsCo5reU990LhwmIULm73s2uj1TmcnyHnVRbbWRZI/HVv5gkX4mw/eBCwml28wT8BB993vfTFPHOTFmdIEchmY2AdbyQUwvDNyNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
X-OriginatorOrg: intel.com

On 10/20/2026 2:24 AM, Przemek Kitszel wrote:
> On 10/19/26 12:51, Aaron Ma wrote:
>> Adapter-scoped synchronization must be available to Admin Queue users
>> from initial queue creation through the last teardown command. Probe
>> currently obtains its adapter reference only after hardware and package
>> initialization, and error cleanup and removal drop it before hardware
>> teardown.
>>
>> Acquire the reference before either normal hardware initialization or
>> firmware recovery-mode initialization. Release it after hardware and
>> device cleanup, balancing recovery-mode probe failures and removal too.
>>
>> This establishes the lifetime prerequisite for moving package ownership
>> exclusion from a module-global mutex to the shared adapter.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> 
> it was me to move hw init before adapter init, to make hw details
> readily accessible to the adapter
> 
> but I agree that SW lock protection covering HW reinit will be great,
> and my needs could be achieved by other means, even if less elegant
> 
> so, I'm happy with your patch
> OTOH I have a big series that git-conflicts, would be easiest if your
> series will be merged first (so I will adjust), but I don't want to be
> delayed (will be CCing you on it going forward)
> 
> the real thing is of course the 3rd patch not this one
> 

I got a Sashiko report about adapter not being present during hw deinit,
which was problematic for PTP. I think the lifetime rules make more
sense if the adapter outlives the PFs.

Sounds good.

Thanks,
Jake
