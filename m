Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792479370;
	b=FGLtndcm4+fA938Yrl9D0029S4ZoDpobSDFjx1kWB/sAtCaA8JfjcDIb3E10nFvgz5I/
	 kkKzj9RwOR8HB3aSYqvu8jI9x6FCD0nnlx6xXlPCsECG60H98+R53OOCSwazSmRDwiD2S
	 JnN9+17eV2yxeXNSoUbJ4sWMK0g0o8DryRIjGrxpCR+Fg1fQSv86tzmNPR+/lDIk1OOKs
	 qfSvbUFhd2VRcYtBgKjm6GzcS2m2RQNTxWkbswVyxed37kBjhum4evKlZvmjDH1yZQeWl
	 40PRypO485hexG/ilEO3+3HjnJxNMP/zkN+gWTQgHNAmIdYFFN21jgL99TcrUZCYs+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479370;
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
	bh=GnG26yZWjR3YSBdnoYClwxknJeShJxBQ7Xyacvp6hmo=;
	b=e9x5Tugzablc6JBq42WiW5MRVasQjhXRx87jqyOvY9gKtESLc3kmTgKK7/x4JJuP+6Yr
	 HAun++CkaHw4hcEJOMnqAWfU0+cxdE4b4EkgX+JwxKsdg4EbYk3Q5QT+NCuJ8bS7euTkd
	 Dm9NhE/eSIZxPgjGPZbzIDyVoCOTvlF4BLkCyc4ruTrwRbBlUQj8pXZ7hduE4N15xMqeG
	 Cj1Gr8EQYXmDC3NkjyLZ5zO1mKZYFEYCYJndYVixUbeAgn4Da59aaud2XapCXKlcBg74w
	 nsVsR+jIRcPBuVsycDQocHHqj1utA8kyIREQ40eXRRmjUirzPJq5PHSIc6jr5xh4xQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmdIzrUl;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BE60A2613
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009BE60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bmdIzrUl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792479369; x=1824015369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4/1B1ufwhgF15k34/IfxiAPF1C6M94c9N4kd6BWseDc=;
  b=bmdIzrUlLyYWEWpPqeOA20zz4EHrVub4sUQnbgwelJHHG02O8gyzEklm
   RsNK3mdi5I6v76us+otMXWW6hXu5x1J7ccH+MIUt8RyJaUs65bW2JQpzc
   2LXNxuW9c4SykdPHXK1xk7tyUHbQowtMQNHUft4HQk3EH5ZGpcTQ/JUaK
   i7MO7Wmm+xhzENvfghY5rznnfzc2IwPnZFQYRx+m3AC5rhmE8WwlxZN50
   ydNVOUvrzA1xDEfzjpwH99k0g4gmjshrZsWm4llMJfG4L7UJPjukZkniw
   t0ItvLGceH1GybJLpp1LLsO18BJ+WnGWL8a+qrQXeatabCcxyuv0rj/nv
   Q==;
X-CSE-ConnectionGUID: Phkcu3zTSXerI3TkVL+UNQ==
X-CSE-MsgGUID: FT5Ome4FRTyT0tYYhk7+SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1076767"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1076767"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 23:56:09 -0700
X-CSE-ConnectionGUID: cdxfcCMKQaec9blo5Yst9A==
X-CSE-MsgGUID: EopZX1JaRzO/rs633SalFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3070146"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 23:56:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 23:56:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 23:56:07 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 23:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaY9YCnY7B/IZO5TkcejLbhT0g0W/hGJMX44BictgLVofYWD8EhQ0SFJLGw8Y8AbW+L0Y4TNolRGW4jESc/fmI8V7YMjQK2S2ykd4DwjxbnIFrgsxSyFbK65Dq70vvEWxeb5tioNnrZgrW6iP2aK9732IFeHJ0ze2ee9HgEdGsTFrXuqcbrIH8sR7/NllSm6qt6kfcnuJrrdPqxwMXQYynIK0oFzQccYKm+US+fKROV6I7WdxBOsODnyApc6qlQWSu53yxvoXCYMrg9tnShB9Qd/jPLdBxhRfrFsqgEm7hOOkBOiebaQH16J+LwCd8pfdnXG80QWaAXOvkXfQO2gmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnG26yZWjR3YSBdnoYClwxknJeShJxBQ7Xyacvp6hmo=;
 b=Gzv5Y5o8fM1vluT1y85kGGMYN2GUkVySlt62gQdCABHcx5cxHD5nqv0rZCkTz9+hKG3C8YnB9dwwM3d4alaFNXBL/S/ph5/ZYK34ndwlHYT8v7nVXY5Hf0MfYNbdxsQFtrth3sOBht3btRHT3AmDOpyOyVXRQa6cb7JSC3fZ7TQ3S8z/IwqxAYRlzK/3ivPFn00WEj6m6kSE4q0nBeTCcXVX6KJiGNw1rFK7g74Xb1o4m1StNS59V3yBryHJCU6MKO54Whqvt3kQaQvdFbUrA25HAMF2A/XJGTg098H9J0W4thoBem7PYYoDW3I8y6fWZrOKIRx72X6QBjRK+Ni0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by SA2PR11MB5018.namprd11.prod.outlook.com (2603:10b6:806:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Tue, 20 Oct
 2026 06:56:00 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::79de:af84:3b43:84e3%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:56:00 +0000
Message-ID: <1562f299-bb3e-4fe6-81d9-e11f67606737@intel.com>
Date: Tue, 20 Oct 2026 09:55:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: igc: I226-V does not wake from S5, PHPM D3 link-disable bits
 never cleared
To: Michael Serajnik <dev@mser.at>, <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>
References: <179223208565.28107.1987245697366860479@mser.at>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <179223208565.28107.1987245697366860479@mser.at>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
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
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5630:EE_|SA2PR11MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6b26d0-afca-42a8-8ca0-08df2e7732c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: beArdxfK5MJlfSTi4RLhQvB6gicvqp4k6DgO/F4C1PeYOhFFH+O4MWwd67x+eV/1QK5kGsrZvCYpYMTS4m9ptI5rvv6uZO56HEIK7YeKtxe7djKj4dgzm/DvVeCswiuHmKeLz7/hwhY4ls4+AK9equaDvc3vq6OYTjYJf969k2EbtbdjVBlf2o40wGn3FR201ANZa82PZXFkkYvYGX4PbIv/02n9bmxy/BXb0WeNKxng/ONsCkiGE8+39pvmMwnv35nRdojT5+WmcwIQ5G0iKjg1jWeShbwluZ0VsBwq5JVtoNWGuo1QgZwn+Zt8QWBQnWluMnYRB1Etj5Mm7e9YPiocGD4zsrsHFcvMRC5PcxfoDLrA6Bj0XI0G+AX5RSVki89tERTjn6pVhRNFv7NF3tTAZCQjZdyky6CG9RKYTHPk8D/sM9zkRDw4eJmtmKuuAiXdvXOQDVOcFq/3lFKFUqKvRd6C0TYwZsoyx4Km6Htjxfx4oGNkFBhTGL7RWlYkOgiUBT757HdWKbMBN52WR+8gDMBg6hCt1sbptOdEduCWwYWrRRKn3OCINqNVlO/IRJ9mhKysIFF8uPNl3jOTmx6+OoFAcCzWLtLu5NwXV67fkwz6IVKDKhrmyIs28fybeOcGplGq6vAOfD6cI7p4TOQeHlg/JWl7Xyo5FQv7s60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tIeFF1RkRidHBOUWU2UDBveXZFQzIzbzgzelQxK1IyVkR2RlVvVEg5SmFm?=
 =?utf-8?B?dlp5dzFSUXg5ZkdldENPbUR3YlY2WFpIbFMwMGszdnRhVm51NUtqYkRCcG1P?=
 =?utf-8?B?WGNnd0F1dzQ1NmZuR3VyRXI4TEZHMUpzMkRKOHNySEYxQ2ZkV1VMV2hWdDk4?=
 =?utf-8?B?bGVBL3RVZ3Z6NU9YalpMZjFrU2V3eTZyWnJHenp2anp4a09JZGQ2NTRFdmdE?=
 =?utf-8?B?MDJDY3NHaFNIUlYxT09GS3VtWG0xUUlTR2U3ZExvYXJxVHBkMjN0eGdQM0VJ?=
 =?utf-8?B?SklRQ2Q0dlZLZzFCUlJ3VE9SaWdGWTdpdDF3L0p5QWxDd3cybGl4R3NOWDRh?=
 =?utf-8?B?ZjZ3cGswVldUQkFJQStRMWFLbnE3NFV1TEh1QTNwTzFEeDltb0N4eEJtWUtF?=
 =?utf-8?B?VXRBSzF0T205MlgxY09yMlZ0YlJuZnBUa3l3emZqRE5aNkYyOGFNTUJpajMz?=
 =?utf-8?B?K3BJZUQ2amVIbFVvOC9CQTdjbE0vMVNPemhNM2VaTUc2aXJGaUlUbmg3MDRs?=
 =?utf-8?B?dk5MK2pIbjhBTmx0eTFRNHVJWUVmZXBTZXViTkdyTHU4Ky84dFpvb2pKWHZm?=
 =?utf-8?B?UThrRTl5Y25YdlNuYUJxeW1yd3RuQTlQSTNjMjdMSHhVeG43aDl3ZXVzcndl?=
 =?utf-8?B?VkErVy91aTZUeEJNb3pVNkV6MC9MYjd3dFZoMW8ra3ErL0dsMDFOcVlVU2xm?=
 =?utf-8?B?YmQ5aVdsU0ZnSGxRU0ZoRFN6K0w4UXk0UllqaEJWclZyb25YV2R1c3NzSjFu?=
 =?utf-8?B?bEs4N1hPY3llMStMYUFiZnlsYS9ST3Q2UmRuUWp4SjdIS2xJeXlMbFlZZTUy?=
 =?utf-8?B?WlNBRTBtVmtZSFh5aUsvaVFIOHBOVEI3RjVuQytoVndvRmMyck01VVFDdkpw?=
 =?utf-8?B?ZWFPZ1JqMzF6ejYzOU53aW1mNHkwSnFqbmxyN28zQ2UxdHhSZExSWWh2clNY?=
 =?utf-8?B?c0djSHJtemNianV5SkYzaWgxWko0Tnl0RGdaSXhIczUrSDlOZTkzTjFWbE1i?=
 =?utf-8?B?NWtLNGpzc0x2MmVENmlPc0ZnSUdvL3p2NklvL1NMWDUzR0lhcThZTnJ3Nk5B?=
 =?utf-8?B?dEF1MzRmdVhoT1ZHYm1nVjVML0hvOGxvT2JNS2VRU2VYdzJxUmdIUUVVY21X?=
 =?utf-8?B?VnFXVHF5RTRCbFNWcHlaWm4vRm1XWEJXcHFoT0V0REJwYWZjeTlPWXlFZmlD?=
 =?utf-8?B?aFU0V29WVzZnbGd1NFlLVXJDeHNad1NkS09QbmM2VWtCeU93VldXRWUvUHJj?=
 =?utf-8?B?UjlPYnNxa2pnLzdQY1I3WDMwODROek1jT3Nqbm44ejZ1QXFSa3phMGJsUWVO?=
 =?utf-8?B?aEczZ2wzYWtReW5mWm1Sa2J1MFdDbzBHVytRVTlLc3RTZ3FIMVVXMjZnS1VP?=
 =?utf-8?B?MFY5bzNtTzg5OWNlbWhBOUlZTFh3cXRyRkNvUXU2WUszVjJuOTlxbzgvTVho?=
 =?utf-8?B?NGp4WXFNcFltZmcxY2FaL3IrTWpWZTVzUmNOOGhWSm42WXZYL0J1QXFIVGFw?=
 =?utf-8?B?a3RBdXhuT29zTVNjdkdhZHdjS0svU1U5L01BRUtNVFZRWDd6ZFpMbHFUQ0JJ?=
 =?utf-8?B?SHQySjRpczVoemJqMHp0Mk5VcFdrbUxKdzlZT05ZcjNvRnNXUUNIWk1XSGhl?=
 =?utf-8?B?TzZCR2NGVWtxT2hTOWpHaVRUUGFrT0IzbE1wOWIrN3hFTThuLzN1NkgrYnRn?=
 =?utf-8?B?dFI3ZHlpS0ZjVk1aMHl1QkNPRTFSOWdqR3B4NnNucVkvU3RPUUIrVGEzWkky?=
 =?utf-8?B?YzZIZnV1N1BuVGJOMTIxNVpwMjI5S0t4MVVPOXVDMkpncDhCZnl1TkYzYTNC?=
 =?utf-8?B?TW1VOE5Ib051bk9zOVA5OEFrRFJjNXdjUEIwTVFoL2RRNkszRlZsY2hsVkRu?=
 =?utf-8?B?TllQaFIwUnFhSmdqdmhNZmdPMlFXRVJMS2JCbHN2MndGdzA3SjQ0Z1M4QWZk?=
 =?utf-8?B?NDNESXIva1B6T3JiTkcxSDlHOGlndGMvRk5hMHVXRkFZMW9RaEt2Nm9odk4v?=
 =?utf-8?B?OW5TK0pZS2xJaXE5c1RjV2l2U2J1ZWlLb0oxRElqT3laWVRKcXAzVmtwWFlI?=
 =?utf-8?B?VVdyWlM5SWxsTElJblBiS0RtQjdVVEg1bjRvTWcwU0tFaXprYmMydDZjdTg5?=
 =?utf-8?B?MU9aUk9OSGFEQjd5OXp3bTYya3FpNzVZQTN1c2dJdEE4d29xeTVTOW1YOUQx?=
 =?utf-8?B?RTdFcEhXRE5RSkZHaS9uVmJJU09aTGRIVlNWTlF2aTZQSUhCVG1LYTR5NEVY?=
 =?utf-8?B?ZTlsSWpxcXhTWklDMUVFOVpQZDZOWi9XY2N0WXduRElLUm1RZUQrd0RJMFdl?=
 =?utf-8?B?MlRubk5BL2RXRmRPZHhRaFJEMGJHd3NBSGpRendjckZ6M0dmZUZxUT09?=
X-Exchange-RoutingPolicyChecked: 5KCaAEVRIox2ftbNgU8uuZro+yjYP66W56IvIpM6glAbe5x4bIY/TnBlHv4JQy/agvUjjXXKQ0APQ8MSFWGbRGvRi7hPyTK4i3XCSsT7PsXlh8TAMEhx86P3Go60tIkCBoBPZS0V21PYTUgOe6ELMyVzS5ByDxvd3b/WosDsQIpJlYI9Ukyc6x2E2qbdZnAfj1jLEX5N6jhQLlmLDUbe1c79U+7S8r4lewmvaUrd/aVPw2Sr67M2tCXLa3O3NdSZg1GclbYNqmodxUXqqdH7dMi7H1FcAimENFF0pWZQ8m85Oy0Jigq2LsS4YobEaibpJAQ7MBnU8u8kkLfvACMSjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6b26d0-afca-42a8-8ca0-08df2e7732c6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:56:00.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UYu9UpXl9Ib/VoF03ZBmwZQAvwA0gUUZf3MTrBSwUPRi6pG3pvmkQcOjU9qeiWvLySvF0z8UZ8lML/XfPv0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5018
X-OriginatorOrg: intel.com

On 17/10/2026 13:14, Michael Serajnik wrote:

> What I see:
> - `ethtool eno1` shows "Supports Wake-on: pumbg" and "Wake-on: g".
> - BIOS: ErP disabled, Power On By PCI-E enabled.
> - /proc/acpi/wakeup has the NIC and every port on its path enabled.
> - After `systemctl poweroff`, the port LEDs go dark, the switch sees
>    no link, and a magic packet from the same subnet does not wake the
>    machine.
> 
> Register read:
> With igc unbound (strict devmem refuses the mmap while it is bound),
> I read BAR0 + 0xE14 (IGC_I225_PHPM):
> 
>    PHPM = 0x00045298
>    DIS_1000_D3 (0x0008), DIS_100_D3 (0x0200), DIS_2500_D3 (0x1000)
>    are all set (mask 0x1208).
> 
> As a sanity check, RAL0 (0x5400) read 0x62e7fcbc, which matches the
> MAC address bc:fc:e7:62:d6:2f.
> 
> These bits come from the NIC's NVM, not from the board firmware, and
> FreeBSD bug 282140 (below) reports the same link-disable bits on other
> hardware, so I do not expect a BIOS update to change this. [1]
> 
> With all three speeds disabled in D3, the PHY has no link while the
> device is in D3, so the magic packet never reaches the MAC, however
> WUFC is programmed. In mainline igc, `__igc_shutdown()` sets WUC,
> WUFC and CTRL.ADVD3WUC and calls `igc_power_up_link()`, but nothing
> in the driver clears these PHPM bits, and igc defines neither the
> bits nor a D3 LPLU operation.

Hi Michael,

With these bits cleared, the link should resolve to the lowest, 10Mbps 
speed. In recent years, an increasing number of switches stopped 
supporting 10Mbps, so we have been receiving reports of similar problems 
from time to time.

I think I can fix it in the driver, but to double-check that the problem 
is indeed this, and not something else in the wake-from-shutdown path, 
could you try to reproduce with a different link partner (switch or 
back-to-back) that is known to support 10Mbps link speed?

Thanks!
--Dima

