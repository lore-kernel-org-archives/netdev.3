Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793802387;
	b=wTnOvH41V4OAR8rejWT/DQz/CHH0tbvu7CbrNYAErNc2l9DN/TZYUqbJ7387fYCT3B/7
	 rObhb/bxSzAaLOGBGJ4BW02Izq+glSm+Xs8ClHdst/YbKeaUSjhHqfUsMkA01MlL2k91I
	 8JDh0RxIoEYZwiu+Lxff/7Kq7wgf7luWwQA55/pyZWukilobSNmWPyrZOEAlbQmk32dkU
	 9JAgBQKJ0XHexVhFaqNj4z5LZ8X6budu5vpKBbysHG0jFhnLmhJQj2D7XGTPqTeuBknTk
	 QD3aSekixgIQcy15ZbN3gAAhU3aMfOLAyPbebGwXx1aFBDIJ8i6msKYbz1+HKeFN6Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802387;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iF2Fl5RNYIIHdBIHYPgsXEOXkfDDQ6c9fQDSlxNOYUM=;
	b=WjFE2VN0EG+/Hyvr0FPbWwyMjvjGks5x5eor35B1O67SbEyCa24M2pvSJbNtNuniL1xX
	 SJV2+x7sZO2dYip3ibfJjN+QEW1vtGE0HszyE1SPhpQXgvpJuEvp7Wb1Lu3JODbjHZLjm
	 raVjfqp03R0z5q816+q9ppOvojOx1iOp5pDLXD0EZivqmzkdhEZbii2DPnXRXSYuV30is
	 p62APHxlSEP8TFtubOBtcHrLqFwvAlF8B5l0YAqjWlbwKA1nH0zKG8gCoIUFJhpoXrADY
	 qA3De/wNjypCoB7sCanDNdqOSCL29V0FVH4MGabEVo7+49tobi49ENHZdtyoWGAWJRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Xkg+RD0F;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JfVHrUH+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE961606A31B;
	Wed,  4 Nov 2026 14:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE961606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Xkg+RD0F;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JfVHrUH+
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4EJLW3983082;
	Wed, 4 Nov 2026 09:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=iF2Fl5RNYIIHdBIHYPgsXEOXkfDDQ
	6c9fQDSlxNOYUM=; b=Xkg+RD0FbLggzvhqZvsERqwZ+uTWzofECSW9p/dYNtw/z
	qpP7DHKvLaYqxuRAOpLfV27ZCz7vCYsWkgOIJOXyj2GlWliONVuNOdn0yhItLZus
	gIevWn+9QtjPIzi1lXewcGo6DQyRKrXUu9beMJQpQv7byJBNia4sxZ6i9ATWtPph
	wcXArEQt/kl/pfYO6ED7Y47GXmDvJZ9dWoSX0GFU6yWqcgQ4HAuFySxRTAhlw81q
	Yih7Zz0gnPMo1ja6x1WmvnJscrRJT/yFLPCJnVVT2rn4ewZh0V2jA8D0vvuJJjWB
	6nOJt2e1EUbIXSKWWZCM1XmMGt7/MWHwEyi+DDB9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=iF2Fl5RNYIIHdBIHYPgsXEOXkfDDQ
	6c9fQDSlxNOYUM=; b=JfVHrUH+dEkzwF0dtAEG/h7VfaPfkZJ5xMKVoW0Pg5YVD
	usXG1kHXQjf5VG2SdTWi4Bs3re0st4yP+H6+qHgtzxO//k1+afWYs9iGShUn3JK1
	lx2Tw2KnysedPvCew96kL1B1pOejMlvos0DWAQEAqnWQTmIfByU6SPSJ7Ezrm9Rn
	voafnKaXDO6mZoil/O0Gj2HISOQJmYEoE+Nocb9T/HIJhrvrt2oUN3WSHVMHeq6w
	MvNZhLYrt2iBSu29jBxJUKxUgYAZBXz9kj207CGMpBciVepMdRCqvB3py4Gvo0/7
	Dr54v/N0VSF4ouwDVCGUW7DC+fmHAKZ/7LC2LE1DQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqkb25utx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 09:26:14 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpuAAhmnd0NWoK6fOK/IxHeGqIoM1XUWpannvOlRnbi3Sa0vo4jF8Tt1Aj0lhfkHZ9newfD4P/kSGKJyI8Iyx/CK77ETfSOYOUg+tU13fmY/zR32UaifQo9LuOGrhDn1x2KZ9QU6zJBLIsOsehnONRlPhGSo3KnKlOSItp8bRKv7PUl9fy2Iw/e5SMu7llO2T6PyIfDhkICwOq1dQFQYw+0Lhv6+8bCXmil3P9ip/htbN7wdk+ZMMLV4oTgkQfypKdIL0QJT1aY+UP1XywxeG97MJKVdtwOdEIAK4vrEXk7w3bFnhn4iAJms83X+7YM7Et2a2pRv73BDIMoDQztQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF2Fl5RNYIIHdBIHYPgsXEOXkfDDQ6c9fQDSlxNOYUM=;
 b=i/qRm6peUy2EsYG8+36uS3/f2mpFQRUZUeR1DRAgpG9i0XTu6rB2HuUcHJTRFTZvNNY6N66xZu1Ql8k1vcxnCJzpVlA/uFv5erI7wEA9QeqQ5b9esbzvb2h85hyWSXfVpoIR/GrXSMhcANWXWspUBi8XoLNqeh681XlpiNKBuUvHL2UBxDY9mjchSJwkVqG4auGLwY+of8FWDv529M/S0WEjmt0gS5ikdM4IHqGUpszhmUX2D8SV9ZoNUGFfqx7qypw5p5ndbUjXQvKZjk6WkcLIp6ZYZWroaFQfRwOQONHPQ8dADz89uquH0VCiaei21kOOtCSnpyAiMLM4q+RSnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by CH7PR03MB7859.namprd03.prod.outlook.com (2603:10b6:610:24f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:26:11 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:26:11 +0000
Date: Wed, 4 Nov 2026 15:26:07 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: adin1110: Add OA TC6
 protocol support for ADIN1110
Message-ID: <aus-LdkVRPxR6lFu@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-5-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103160918.409701-5-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0017.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::13) To DM4PR03MB5981.namprd03.prod.outlook.com
 (2603:10b6:5:388::24)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|CH7PR03MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f2f9e8-0b6a-4255-bc9c-08df3a7f9336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|261022075727099003|11063799006|4143699003|261009223027099003|261026140227099003|261022105027099003|261028144727099003|261021135927099003|261102123227099003|56012099006|261026121527099003|261021121427099003|261021123027099003|18002099003|22082099003|6133799003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZhXQfINv6Hvv6j7pq1R2+mMbCbg1LMqtSw4VLYK0VRxrkMdvfSxOq+9pcQQ+qNkzUOt8ymkesbKlqcraSH3GVpr8gw/DWegnPkl4Tcv0He/Mx50aGhcYSZ79Dh/j6kivvco7jev10FhUdXbqJ1VQNm35pTunUii0HYN1q4Muv+G16yojq32QoISdgmDraCaqV5SOP8qi+HuaeMg2Fc0+eX2CNUXn7nAiZnuTPkUw/ulX8D9RWqc+8I60NJMjjYdYacyKjXmSXb2JJR+aOhmm7mXW8SS5pcxE7+atHfng+GrvNB3BIje4gY5E1uO/eYmmLvl7Q+9g9GVK1jyhADs8YF0HOB/xuL5Xd0jSMtyN6GJS+rS0DpwFf/ueDpx+sh/b7NhJJTtA9iMj/UEVMCe1vnYjKZGmmR0Ug/fgrn5l7oUaJC3DUcZwnsaciE2F/DsfA6fkbVOfZocuw666bJLNpoPnwIzwdLjFa7X+huxh6DVR8QlV+iLmyq2GhLEzFbFeUMdcVUGB+P5YD/1srs143MEhpiqX22x9fS7cIXfyMkmNMilZoxSLrLxy7lVukBRP+I5DPLVtDrjEx3D51+NmuXooAWnSUHY+o/fzi6mBievRNh5DnW5JIv5kN4GqL8h57zKkndDegBxp6WacuvA960EEhpF7l4oZ1cojuj6Tmfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(261022075727099003)(11063799006)(4143699003)(261009223027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021135927099003)(261102123227099003)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkkwbGpjM2NGMGRvUEVSL3M4UEJtWWt0MXI0NUxGTlVKemJEU3ZZRXpmOHBK?=
 =?utf-8?B?R1JlYXhEYTE0alFoLzJKdHBTNVgvWTFxMTlacWpCL1lLOWpHMTg0cGZSVDRK?=
 =?utf-8?B?RW9MQ0tKUWpSaVBEY3gyRnNsd040K0M5ZndPOGNReks5WjBwdDcxZFNtc2FP?=
 =?utf-8?B?SUNCeXVscHNTK2JVY2RkNkpMdldlUFpqMFJibGRhVG8rVVdqYTloS3ZNcllG?=
 =?utf-8?B?Tzl2K1NabDlGQXlIRGJ0V1lDMWJOamRKaVBJdmV4Tll5dGF4SHp2K1JZMzFt?=
 =?utf-8?B?WkNJSzVCVUtJQm82dXVlYmlncEpXdjd3OXZjOFo2TGhkTkx6eHY2Q1VmQVZM?=
 =?utf-8?B?RUVldExEczBiaEFiUFNsVWFyV3pQZTRRaFBxTWdHdkM4S2JmUG1HV3VvbXNq?=
 =?utf-8?B?Qm1ZZTRzcFdlS2c2eXlYcy92d2RrekJYL1pEU0ZGcEk3RVVpajkxMTNBVWRR?=
 =?utf-8?B?NDR1QVVOWktnWkFTN0NBdUN0UnNtYXE1cncwVVE3WCt6Ti9FMUE0a0dBRzN2?=
 =?utf-8?B?UFZoWllKNWhadHhMOEJRWklwZTByS1lBaFdBV0ZqVGhvM3dkZlVTNFNpcWp0?=
 =?utf-8?B?YnVLd2R5QWlnQTQwbG5DcGQwU0FkLzhJWjNScXRYWUhRTzN6V0ZLVUdUdmZm?=
 =?utf-8?B?c1p5KzJzQ3pDU09HdkhibUw0UitpU2RxVVBIREtoajllVjhwZDZMc2FzUDFR?=
 =?utf-8?B?bnJzb21nZFpsOU9VNmZwcCtrVlc3WjlwWEtsNTJJNytkQmJkVEtJbHMzTmtm?=
 =?utf-8?B?UmtTSldlbUFURGpJdklJZlY4bFU3SDM4aGtyREI2K3ltVkhlYWdtY3g5UGR2?=
 =?utf-8?B?R0lsWDQyck12WVRIQ2szZFBpZWRiWTljb3pCZ1YrVUptcGJKRmVaK002UENQ?=
 =?utf-8?B?M3ZxTkplTGlyMFQzZDFLeHFlYUR5dnRTaHdVMmM4dmg0dDREVmNpV0hNZVpC?=
 =?utf-8?B?c0NTZ05zSjJaSldJRjNJWHlaY0d4aVU1SnQwOTJSa0hQWGpuYUZFNkRoeTV4?=
 =?utf-8?B?ZHFrM3BlZjN2T1lPTDIwenovbUcwN29DbU5tSStzN3RtWjFXNXlNM1JsVHA4?=
 =?utf-8?B?Z1g4ZHVTWjRjQ0hXQk1pRjNkRHV2ME5jK3E3bjF0SC94M1VoK3o0bEtkam5V?=
 =?utf-8?B?UGZCZFZ1S2VZL3E3djNQZDlhTE5jUjNHS0c2T1p4K1JOZy9jdEF5TWpGZVRp?=
 =?utf-8?B?ZStqbzhmTlFadHA4S2I5V0x0UkkwcFNhMGVNY1JHR1RmNGJIUnVmUnBDNWNJ?=
 =?utf-8?B?bFhZNU0xVVpQcFhNdmNUNS9DL2U3K3pyL05DZVJ3VEVqNDJZSWJxQzdzSEhM?=
 =?utf-8?B?QnFzWHp5blo0Umo4TjBmTUc1RkRDbmRYMG14WXJ1c0hrcVp0ZjI4MkN5a0gv?=
 =?utf-8?B?RnMxUUpoVkZ5Q2QwdlVLMzlhTTFsdXN0UzVvZzBEaEJvMUQyWkxDVmE0clQr?=
 =?utf-8?B?ZVU4eVplSlBwelVnaU5aWTNoQm91T1J3cWdOUGI4ZU1WNnVQSHFzbjRGVzg0?=
 =?utf-8?B?d3duR3NaVDdzQ2N2QmhoS3VkZkE2RjBZZFNjczdsQ0ZYOFAyOVAxSVhhSUV3?=
 =?utf-8?B?V05PcWlJK001eXNGWnVlTUhlNEJzNStlZGpuM2o3cVFXclZWUHE0Umc4MEg2?=
 =?utf-8?B?YU80YnBzYXNCVG9BVW1IYnVRVmpXRk03ZmxZaHRSTWxubFJ1bkRaNmM5VklF?=
 =?utf-8?B?M0pTL3FpKzN0RDl1T0RlU2EvbGh5K21VNENBUmR3YjdEWHp3MmxZVjYvUG5L?=
 =?utf-8?B?WUhOdVJJT1J3a2FuUXhib0lmQ3BnalFxY3h3djNlWTFpbHU2eDZBZHJoemdp?=
 =?utf-8?B?Z0JpRzJHWlBDUU45b1p0WE9RdElRc1VkSUFIQWFnSXlnb0tFUHowcER1d1J6?=
 =?utf-8?B?YU5CTHo1K3hIbjhTN2NwTUIzUmJ4NkpRaEd2L3A3WEx6TTlOZjFuRHlSWGNS?=
 =?utf-8?B?SXN4K3p3REloLytjcHR1QStuTzlzakExQitqZUl3UlMyOVJ0WWlHS0ZjNnk0?=
 =?utf-8?B?czRBbU5rbCtCejIzWm5vclUzZG5raUlDY1FqMGgyd3ZBandOcW1MQnAzcG4x?=
 =?utf-8?B?dGhVL0laSk1WT2owaHBqQVNGQkZibXZrSzFxam1yOU0vMWIvRXQ1em9uVFg0?=
 =?utf-8?B?REdwdkgwZGU1bGp3RjhQUkhuRVVoSlM2dmZtVzhzR0RDMFZMeGk2V0FEYUps?=
 =?utf-8?B?S1pYSml5SkJIWmdxSytoOU5TSE9Dc2JmbldadWVHVEJRM0tQYjJub1ZuUVhn?=
 =?utf-8?B?d1dhWUpjaVRDQ2ptT2hUY2VoSWlwMC8yM1JXZDd2SSs1TlBxNlNzbjVXZi9L?=
 =?utf-8?B?ZzZidzVqRzJCUEFUSXJZTk1FaEpZOEJ2TmVLbFdzREdxUlJkOFV6QT09?=
X-Exchange-RoutingPolicyChecked:
	D/lYpwe3M+7a0y+w2Jb8fvHO7NOth7yuS7uv0tudMoIYnhLgt6HEyB286iwK22JfbPCWsA3rLyG2GPwz3aes1+MPP6TFe9HxqiDqSV3I2BN0p+xXh1GpMkfOXzIYH9/UmxfIRhxcNfj81B+hoDlrYds88ScXfhseXcQwwoDmbHLn+zACbYbeZ4792gufmbMXb76zVGifZ2QcmL7cQAM4OZffQXSrVtFfdhuLt443GX2fEBTcf/UxyqKeMhNQq8B2wADaJuJN1Xw/y8W8FtQ5JEkgKfEqvBWZL5PC5Dzh96mfPauuK5uNS5h4oA548giZcZXDnRdtKC7wStu885gEbg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f2f9e8-0b6a-4255-bc9c-08df3a7f9336
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:26:11.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXGufL21jIIHNnB1efV1j3qGErPU4Vj2fjY4uI61JfECzbPQuaeWNiVJADRFhzv0urO6KmVOG9FLMZ86BWZrOeo4ZxBr6CIa+taTUZ80jmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7859
X-Proofpoint-GUID: -FqR-JgBbNehPwG7hthNFMtxHkauhRPg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NyBTYWx0ZWRfX53DYh8gXvgRY
 q01qLie8/bJXlyLg4l5bI+XM0pqVnkCkg5z5apbhsRWvW5eVk0o69VtuntIAEZLPGQcbDXRb6ry
 V1r454GjPDrllnp63CLE8hn/8GUDfTjTpxD9x7dbHCp728PoklMG
X-Authority-Analysis: v=2.4 cv=EOOTQFZC c=1 sm=1 tr=0 ts=6aeb4086 cx=c_pps
 a=fY0JyvE1RNjZr0fjhzOn9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=yybNDLw_Pjjozo7rEucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -FqR-JgBbNehPwG7hthNFMtxHkauhRPg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NyBTYWx0ZWRfX44ieS9DW/vEh
 VikvPA/Wg3ljWT3RoiRQY5o4MtIHGzARcL31/XVNi/E0zwsaMq+s8iUQfz/Bei2BAqDTSePZckK
 f3zc+KjGQKmohRwBdYwzX/bivzsdxHwuHwWUUEdOgwPqdlPFdiwAURJcG9mWz+545gU5IlAw+cd
 /Mq60H6+ZmaH/Xh7ey2npa8MwDqO5sTB5tEWwEXcgJFhgEKUZfB49Hw9/vYT+fc5TUiKvBKHdo+
 IikBs5dXHvwyKhshKKQP/dOyRdEH04OYfwvET6DDbjm2HseD5q04aezj2KK9i94gndbbNztgxqx
 cRgEN1HL3qtdqy1QSwSLY/KY6lebAIyyZrtfJ49Qf7+NTDqhIpQi1oL2PZHzj5q2PvMdRwEPqTq
 EcMM4jL3dJDL5yJP8kUYxz7qA++vMqnneUckiy6scbXQXJBXm+AkFE2dEGOqoMo+jCeiEI5sXYK
 agx+kTa0d0ezFtFDOWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040057

On Tue, Nov 03, 2026 at 06:09:17PM +0200, Iustin Stolniceanu wrote:
> From: Ciprian Regus <ciprian.regus@analog.com>
> 
> The ADIN1110 and ADIN2111 support two SPI host interface protocols,
> the generic SPI protocol and the OPEN Alliance TC6 protocol. The
> protocol is selected by the state of the SPI_CFG1 pin, which the device
> latches when it comes out of reset. The driver currently supports only
> the generic SPI protocol.
> 
> Add support for the OPEN Alliance TC6 protocol on the ADIN1110, using
> the oa_tc6 framework, when the adi,spi-oa-tc6 property is set. The
> framework handles the data transfers and the MDIO bus. Register
> accesses go through read_reg/write_reg callbacks, so the existing MAC
> configuration code is shared by both protocols. The ADIN1110 specific
> MAC registers are in MMS 1.
> 
> The framework does not append the FCS to transmitted frames, so set
> CRC_APPEND in CONFIG2 to let the MAC append it. Also set the port state
> to forwarding on open, as the generic SPI path does, otherwise the
> broadcast and multicast filters drop all received frames.
> 
> The ADIN2111 is not supported in OPEN Alliance TC6 mode yet, and probe
> fails with -EOPNOTSUPP.

Not sure -EOPNOTSUPP is correct, maybe -EIO or something?

> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> Co-developed-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
> ---
>  drivers/net/ethernet/adi/Kconfig    |   1 +
>  drivers/net/ethernet/adi/adin1110.c | 186 +++++++++++++++++++++++++++-
>  include/linux/oa_tc6.h              |   1 +
>  3 files changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
> index bdb8ff7d15da..c35f68814c21 100644
> --- a/drivers/net/ethernet/adi/Kconfig
> +++ b/drivers/net/ethernet/adi/Kconfig
> @@ -22,6 +22,7 @@ config ADIN1110
>  	depends on SPI && NET_SWITCHDEV
>  	select CRC8
>  	select PHYLIB
> +	select OA_TC6
>  	help
>  	  Say yes here to build support for Analog Devices ADIN1110
>  	  Low Power 10BASE-T1L Ethernet MAC-PHY.
> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 53fac3dc8be6..d08b165bf7c4 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -19,6 +19,7 @@
>  #include <linux/mii.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/oa_tc6.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/phy.h>
>  #include <linux/property.h>
> @@ -114,6 +115,8 @@
>  #define ADIN_MAC_P2_ADDR_SLOT			3
>  #define ADIN_MAC_FDB_ADDR_SLOT			4
>  
> +#define ADIN1110_MMS0_LIMIT			0x30
> +
>  DECLARE_CRC8_TABLE(adin1110_crc_table);
>  
>  enum adin1110_chips_id {
> @@ -145,6 +148,7 @@ struct adin1110_port_priv {
>  	u32				nr;
>  	u32				state;
>  	struct adin1110_cfg		*cfg;
> +	struct oa_tc6			*tc6;
>  };
>  
>  struct adin1110_priv {
> @@ -161,6 +165,9 @@ struct adin1110_priv {
>  	struct adin1110_port_priv	*ports[ADIN_MAC_MAX_PORTS];
>  	char				mii_bus_name[MII_BUS_ID_SIZE];
>  	u8				data[ADIN1110_MAX_BUFF] ____cacheline_aligned;
> +
> +	int (*read_reg)(struct adin1110_priv *priv, u16 reg, u32 *val);
> +	int (*write_reg)(struct adin1110_priv *priv, u16 reg, u32 val);
>  };
>  
>  struct adin1110_switchdev_event_work {
> @@ -192,7 +199,18 @@ static u8 adin1110_crc_data(u8 *data, u32 len)
>  	return crc8(adin1110_crc_table, data, len, 0);
>  }
>  
> -static int adin1110_read_reg(struct adin1110_priv *priv, u16 reg, u32 *val)
> +static int adin1110_read_reg_tc6(struct adin1110_priv *priv, u16 reg, u32 *val)
> +{
> +	struct adin1110_port_priv *port_priv = priv->ports[0];
> +
> +	if (reg >= ADIN1110_MMS0_LIMIT)
> +		return oa_tc6_read_register_mms(port_priv->tc6, OA_TC6_MAC_MMS1,
> +						 reg, val);
> +
> +	return oa_tc6_read_register(port_priv->tc6, reg, val);
> +}
> +
> +static int adin1110_read_reg_generic_spi(struct adin1110_priv *priv, u16 reg, u32 *val)
>  {
>  	u32 header_len = ADIN1110_RD_HEADER_LEN;
>  	u32 read_len = ADIN1110_REG_LEN;
> @@ -240,7 +258,23 @@ static int adin1110_read_reg(struct adin1110_priv *priv, u16 reg, u32 *val)
>  	return ret;
>  }
>  
> -static int adin1110_write_reg(struct adin1110_priv *priv, u16 reg, u32 val)
> +static int adin1110_read_reg(struct adin1110_priv *priv, u16 reg, u32 *val)
> +{
> +	return priv->read_reg(priv, reg, val);
> +}
> +
> +static int adin1110_write_reg_tc6(struct adin1110_priv *priv, u16 reg, u32 val)
> +{
> +	struct adin1110_port_priv *port_priv = priv->ports[0];
> +
> +	if (reg >= ADIN1110_MMS0_LIMIT)
> +		return oa_tc6_write_register_mms(port_priv->tc6, OA_TC6_MAC_MMS1,
> +						  reg, val);
> +
> +	return oa_tc6_write_register(port_priv->tc6, reg, val);
> +}
> +
> +static int adin1110_write_reg_generic_spi(struct adin1110_priv *priv, u16 reg, u32 val)
>  {
>  	u32 header_len = ADIN1110_WR_HEADER_LEN;
>  	u32 write_len = ADIN1110_REG_LEN;
> @@ -263,6 +297,11 @@ static int adin1110_write_reg(struct adin1110_priv *priv, u16 reg, u32 val)
>  	return spi_write(priv->spidev, &priv->data[0], header_len + write_len);
>  }
>  
> +static int adin1110_write_reg(struct adin1110_priv *priv, u16 reg, u32 val)
> +{
> +	return priv->write_reg(priv, reg, val);
> +}
> +
>  static int adin1110_set_bits(struct adin1110_priv *priv, u16 reg,
>  			     unsigned long mask, unsigned long val)
>  {
> @@ -881,6 +920,22 @@ static void adin1110_set_rx_mode(struct net_device *dev)
>  	spin_unlock(&priv->state_lock);
>  }
>  
> +static int adin1110_set_rx_mode_tc6(struct net_device *dev,
> +				    struct netdev_hw_addr_list *uc,
> +				    struct netdev_hw_addr_list *mc)
> +{
> +	struct adin1110_port_priv *port_priv = netdev_priv(dev);
> +	struct adin1110_priv *priv = port_priv->priv;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);

guard(mutex)(&priv->lock)?

OK, but the rest of the driver doesn't use that, so I can see why you
refrained from going that way.

> +	port_priv->flags = dev->flags;
> +	ret = adin1110_setup_rx_mode(port_priv);
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
>  static int adin1110_net_open(struct net_device *net_dev)
>  {
>  	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
> @@ -938,6 +993,31 @@ static int adin1110_net_open(struct net_device *net_dev)
>  	return 0;
>  }
>  
> +static int adin1110_net_open_tc6(struct net_device *net_dev)
> +{
> +	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
> +	struct adin1110_priv *priv = port_priv->priv;
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +
> +	/* Needed for the broadcast/multicast filters to forward to the host */
> +	port_priv->state = BR_STATE_FORWARDING;
> +
> +	ret = adin1110_set_mac_address(net_dev, net_dev->dev_addr);
> +	mutex_unlock(&priv->lock);
> +	if (ret < 0) {
> +		netdev_err(net_dev, "Could not set MAC address: %pM, %d\n",
> +			   net_dev->dev_addr, ret);
> +		return ret;
> +	}

For the above, it wasn't quite clear to me why you don't call
adin1110_port_set_forwarding_state()?

> +
> +	phy_start(net_dev->phydev);
> +	netif_start_queue(net_dev);
> +
> +	return 0;
> +}
> +
>  static int adin1110_net_stop(struct net_device *net_dev)
>  {
>  	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
> @@ -961,6 +1041,14 @@ static int adin1110_net_stop(struct net_device *net_dev)
>  	return 0;
>  }
>  
> +static int adin1110_net_stop_tc6(struct net_device *net_dev)
> +{
> +	netif_stop_queue(net_dev);
> +	phy_stop(net_dev->phydev);
> +
> +	return 0;
> +}
> +
>  static void adin1110_tx_work(struct work_struct *work)
>  {
>  	struct adin1110_port_priv *port_priv;
> @@ -1006,6 +1094,18 @@ static netdev_tx_t adin1110_start_xmit(struct sk_buff *skb, struct net_device *d
>  	return netdev_ret;
>  }
>  
> +static netdev_tx_t adin1110_start_xmit_tc6(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct adin1110_port_priv *port_priv = netdev_priv(dev);
> +
> +	if (skb_put_padto(skb, ETH_ZLEN)) {
> +		dev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	return oa_tc6_start_xmit(port_priv->tc6, skb);
> +}
> +
>  static void adin1110_ndo_get_stats64(struct net_device *dev,
>  				     struct rtnl_link_stats64 *storage)
>  {
> @@ -1056,6 +1156,16 @@ static const struct net_device_ops adin1110_netdev_ops = {
>  	.ndo_get_phys_port_name	= adin1110_ndo_get_phys_port_name,
>  };
>  
> +static const struct net_device_ops adin1110_tc6_netdev_ops = {
> +	.ndo_open		= adin1110_net_open_tc6,
> +	.ndo_stop		= adin1110_net_stop_tc6,
> +	.ndo_eth_ioctl		= adin1110_ioctl,
> +	.ndo_start_xmit		= adin1110_start_xmit_tc6,
> +	.ndo_set_mac_address	= adin1110_ndo_set_mac_address,
> +	.ndo_set_rx_mode_async	= adin1110_set_rx_mode_tc6,

Would it make sense to use the async mode for the non-tc6 case as well?
Then you can drop the work there and have the same ndo callback for both.

> +	.ndo_validate_addr	= eth_validate_addr,
> +};
> +
>  static void adin1110_get_drvinfo(struct net_device *dev,
>  				 struct ethtool_drvinfo *di)
>  {
> @@ -1123,6 +1233,69 @@ static int adin1110_check_spi(struct adin1110_priv *priv)
>  	return 0;
>  }
>  
> +static void adin1110_oa_tc6_remove(void *data)
> +{
> +	oa_tc6_exit(data);
> +}
> +
> +static int adin1110_oa_tc6_probe(struct adin1110_priv *priv)
> +{
> +	struct adin1110_port_priv *port_priv;
> +	struct oa_tc6_quirks quirks = {0};
> +	struct net_device *netdev;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &priv->spidev->dev;
> +
> +	if (priv->cfg->id == ADIN2111_MAC)
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "OA TC6 isn't supported for ADIN2111\n");
> +
> +	netdev = devm_alloc_etherdev(dev, sizeof(*port_priv));
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	port_priv = netdev_priv(netdev);
> +	port_priv->netdev = netdev;
> +	port_priv->priv = priv;
> +	port_priv->cfg = priv->cfg;
> +	port_priv->nr = 0;
> +	priv->ports[0] = port_priv;
> +	SET_NETDEV_DEV(netdev, dev);
> +
> +	quirks.reset_settle_us = 50000;
> +
> +	port_priv->tc6 = oa_tc6_init(priv->spidev, netdev, &quirks);
> +	if (IS_ERR(port_priv->tc6))
> +		return PTR_ERR(port_priv->tc6);
> +
> +	priv->read_reg = adin1110_read_reg_tc6;
> +	priv->write_reg = adin1110_write_reg_tc6;
> +
> +	ret = devm_add_action_or_reset(dev, adin1110_oa_tc6_remove,
> +				       port_priv->tc6);

Spurious newline above.

> +	if (ret)
> +		return ret;
> +
> +	/* The OA TC6 framework doesn't append the FCS, let the MAC do it. */
> +	ret = adin1110_set_bits(priv, ADIN1110_CONFIG2, ADIN1110_CRC_APPEND,
> +				ADIN1110_CRC_APPEND);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (device_get_ethdev_address(dev, netdev))
> +		eth_hw_addr_random(netdev);
> +
> +	netdev->if_port = IF_PORT_10BASET;
> +	netdev->netdev_ops = &adin1110_tc6_netdev_ops;
> +	netdev->ethtool_ops = &adin1110_ethtool_ops;
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +	netdev->netns_immutable = true;
> +
> +	return devm_register_netdev(dev, netdev);
> +}
> +
>  static int adin1110_hw_forwarding(struct adin1110_priv *priv, bool enable)
>  {
>  	int ret;
> @@ -1649,6 +1822,7 @@ static int adin1110_probe(struct spi_device *spi)
>  	const struct spi_device_id *dev_id = spi_get_device_id(spi);
>  	struct device *dev = &spi->dev;
>  	struct adin1110_priv *priv;
> +	bool oa_tc6_protocol;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(struct adin1110_priv), GFP_KERNEL);
> @@ -1663,11 +1837,19 @@ static int adin1110_probe(struct spi_device *spi)
>  	mutex_init(&priv->lock);
>  	spin_lock_init(&priv->state_lock);
>  
> +	oa_tc6_protocol = device_property_read_bool(dev, "adi,spi-oa-tc6");
> +

Spurious newline.

> +	if (oa_tc6_protocol)
> +		return adin1110_oa_tc6_probe(priv);
> +
>  	/* use of CRC on control and data transactions is pin dependent */
>  	priv->append_crc = device_property_read_bool(dev, "adi,spi-crc");
>  	if (priv->append_crc)
>  		crc8_populate_msb(adin1110_crc_table, 0x7);
>  
> +	priv->read_reg = adin1110_read_reg_generic_spi;
> +	priv->write_reg = adin1110_write_reg_generic_spi;
> +
>  	ret = adin1110_check_spi(priv);
>  	if (ret < 0) {
>  		dev_err(dev, "Probe SPI Read check failed: %d\n", ret);
> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index e0627b99e569..2fd051e1c604 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -79,6 +79,7 @@
>  #define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
>  #define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
>  
> +struct mii_bus;

A mistake here? Doesn't seem related.

>  struct oa_tc6;
>  
>  enum oa_tc6_quirk_flag {
> -- 
> 2.43.0
> 
