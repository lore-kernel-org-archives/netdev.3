Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3283B71B2;
	Fri, 17 Jul 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280397; cv=fail; b=qf1i7AliPEqDDDqdHZQP+7bckADvfBESUz7wgqONrkJkHRTN5m4zDIe1LaclBfNIWFSDyLoYSkz/prv3zusYqBYrRLfDJyv1ZBuQuzXqiYDGuW2V7VI/4GpkYRzwEzDCRUmOAv4XEXBYPlC6Ljg0S5dAwhi2dzaHsqF4gcdnSTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280397; c=relaxed/simple;
	bh=HsAivsprWGmghMHCN/FOWMU1YJNia1Ch49dmyP7Pl94=;
	h=From:Date:Message-ID:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:MIME-Version; b=je42MW1FcxYZzjGssvgL75yQGQ5X7mFpVQadmtYCUxg6nyiRASQvupQiGqip5M4v6IqpLXLG6TT81Ck5SBvo0RBgQ5U5ilGg+JXN7MBdBHiziGsRMzjs7OBIs0DiklVEp4YyjiX+7Z6wToqkzi809kpYpRQ9XY/MD47tuLe358E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IwQF8ELu; arc=fail smtp.client-ip=52.103.12.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IwQF8ELu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4Okz/MD3Rb27mEvCwmQYV5JjLTn/s5LI1tkt+4xb+Cpi2nXpmJUvndGbRN+PJokXrAnQL4l3JCexiLcmxV1RastexmeCuv2Jl2kdpjQ6dZ1fB2DrOlv61K/NbhRlkSZTiIKPT+sBsxSOxzb0qIGbWvKcmSKAA/OxZ9Lv0Fkq0ojAqAcRfXhiTAgAQQiO1zCnV1NG+aIhVOVl1YX9s4E+ZQq7LzSNkqJKTrh4IXH5EosodYO3m2nDQrEyWZ0/jXxmSpaGTucnZ4XlMmCUXGd76ihVIO+UfEvxsg/ksPRvWiT2l5rMjUY8NT9yTlBocy+qD7g1ZhZBl4vJi14wQ2YWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95Xh3Q7ZOUWcQtthJ5W/4U/EphlEnzw88sA2Ws1si4I=;
 b=xGEJnXItFLMqwq7UmIaTMJeZfcbQnaFY6c/y3lXFk3LyDDPjarq16lzCsVHzyQ26BpmPbMMFWzo5vF03o223WkbhQueG7/iZX1yY4CW1ArVDnXcNFYyUg0kekcLnWgEHTLAgvEGPEhFcnXnEeADjmSfoA/HIlGdD+mIT2N1pg8fNRmK45q39f/h/U58URpbDNDZrnXLIim2CVWdFCHQSxvlsLAzMz4+BUiWierwU2WPnP3nsb/lvlO3OupPPfcO+x2j1+fHInVuBas1Y7mA4SNbcNtGsp3gbPFw9vGZZmGUEHO3eO8a/QZCaP0zXLiKQ39Vb+3EO6ABYBN1bWtAb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95Xh3Q7ZOUWcQtthJ5W/4U/EphlEnzw88sA2Ws1si4I=;
 b=IwQF8ELuN6spbKH4lyniusJkQV8WVHs+mRef/a5KoVyOeMGOCiWJLRxtE6zJSoWAheECfdj/9akP2Mtl/8DgvhCh8/PNWaU9ZfKxTI+EkBm2T1MpcoRWOa/EPIl3p4TrnV5kf2g5jn2TTriANwJUNqdji0M/OD9dRE/bbbEKF6G+GO6zTvGKPCqqXAW5r9AiEQ7Za/ydDPj1Oat+Cn5Ib7E7LezEmZoLAszBzN4ItqplN5ofGx5w6cccc3MQftgmUR+fl6lpP2G31Z1IT1dkGN9sbPaFwOoqMNtH9A3mCdoTFyfAGJ1nXiYXeMxbx3WeizNHfsmetXgH0Yup5vQPCA==
Received: from PH7PR19MB6088.namprd19.prod.outlook.com (2603:10b6:510:1df::20)
 by SA1PR19MB5071.namprd19.prod.outlook.com (2603:10b6:806:188::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 09:26:33 +0000
Received: from PH7PR19MB6088.namprd19.prod.outlook.com
 ([fe80::b629:a6cc:c2ad:22e]) by PH7PR19MB6088.namprd19.prod.outlook.com
 ([fe80::b629:a6cc:c2ad:22e%6]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:26:33 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Fri, 17 Jul 2026 17:26:42 +0800
Message-ID:
 <DM4PR19MB6098A25EDB5602853E1EE44BACC62@DM4PR19MB6098.namprd19.prod.outlook.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add Maxio MAE0621A PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    Heiner Kallweit <hkallweit1@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org,
    Russell King <linux@armlinux.org.uk>,
    Rob Herring <robh@kernel.org>,
    Krzysztof Kozlowski <krzk+dt@kernel.org>,
    Conor Dooley <conor+dt@kernel.org>,
    Luo Jie <jie.luo@oss.qualcomm.com>,
    Wolfram Sang <wsa+renesas@sang-engineering.com>,
    devicetree@vger.kernel.org,
    linux-kernel@vger.kernel.org
In-Reply-To: <20260717-immortal-moth-of-will-6ab571@quoll>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
    <MN0PR19MB6091F865EF7FE6AC1EE41C10ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
    <20260717-immortal-moth-of-will-6ab571@quoll>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DM4PR19MB6098.namprd19.prod.outlook.com
 (2603:10b6:8:6d::6)
X-Microsoft-Original-Message-ID:
 <656ed827aedc4a1e9af3f24251c0bca5.1784280402008020.tspi3m-maxio-krzysztof-reply@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR19MB6088:EE_|SA1PR19MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: b93f277a-2180-4302-ec2f-08dee3e57bfc
X-MS-Exchange-SLBlob-MailProps:
	e5BdfXQOl3OFoO0nGfopvAk+O3ylgvVAARPWu78VV9V9pe1mrk+Wb6WvKGiOlbRcfGuYWnshhD1U83CcDfska2JjjD3Hn/FmQSndyfI28/8t0XNE69wbS58zNb19Og/q/Tk/gKHWfkv9BIlk4z0KDDcmbLyk7+Hrnlf9RGNGL1deJK4ojKF2F+ZphPTAJopoWqDYVabptkniPBlJyzzkRUmEO89g9CG4PjNDOJRHc9+AU7rmjG6/DMp6MNrpWZYmwkvO0fQEbqg1qhBFWsNjf3d7agEPxlSGxygu6IQSi1IUixhtFvCZBIJYCdxqrC/CvzszF2pgft48J8nhgs7ORKf5n6uWrGWCYO0lBT51/SvWqojbboax2iygWLIbb3EkX5HV6sSdJF7hPaYesZwNrvVDO1e9kt0DZPktG0+E+td+g51Ee1v8XF6nXP8Om4KaZCWvXabnyRiXp2+Jwb9j71fOs3zULropd+KGBcH4HlZZ6HUfNsk5JQ8S9uCz5oq6K/PvTF/ndMfccNZZSf7dlcWs5NSov8TROfILTFtTyIIRu5uARRhaVZNjLKocpt8QgHmDoxSUTCS7t/6HYhy1Kpdw/Sh+tD58gtMO/iqcchbEJxozhVT+tIaOP6W7v+XbAlVdQ8R7FFtBGdwpBh7J1G+Zw1uRt0YNEAIPlfwoSx3+QhjLD6twkIDI46z3VTWegvUq6UinTcpFxHAd5ugZvvb6v9XaM9q1m9LJG9bRQ8C7MV0UfoCYCzDrg/qx9nWRGeRKQVx6n85WezN8UqncvO0Rrx0Gr1VqGtfRr4bZ2lWLtsC8YGtWi107ECkGh3WUwyLyGo1JxUs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|24021099003|41001999006|51005399006|8060799015|15080799012|6090799003|23021999003|25010399006|5072599009|10035399007|40105399003|1602099012|440099028|26104999009|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHRDd0ZBZUw1V2ZmN0hvVW1XcTN5andmSnpvOWFLcXY0Ni8rRUpUajJtbWkz?=
 =?utf-8?B?emphUWxyM3l4MHNmbnNjWTJpbS9RWHpKQ0NTQkg1blVCZ211K01MUENLbUJK?=
 =?utf-8?B?bmpZR3ZzUWt2ektCVWJaN05mZUE5ayt5Yklsc1RUSU80K1pFS21GMnh5TnYr?=
 =?utf-8?B?MnpWZnBOOEx3bW4xTXQwelAwUHYzc3d1WU1NUXpIdnp1RFNHQTcyS0htQjd6?=
 =?utf-8?B?SkRkUGRQYUdLMkhJR0dxL2wwUlBZKzlhc1o0aWpIQStjZzNjeS90SkkrZzlt?=
 =?utf-8?B?Mi9ZWVRzR0pkYjkrUkV0TWlKdy8vcWNTZ2tZLyt3UENBZ0xjSzFuUFNxM0g2?=
 =?utf-8?B?VjRjSW9vYTFTNklvRTA4RmJFRWNNZC9mdlc0bnpSR21uYmVSR0o1Z1orM1k5?=
 =?utf-8?B?L0RFb1BRdXRQUW5jZW84Qm1SaHhTbTZBdXNOVWc2MjVtY0tqSnVFa3B1bnNU?=
 =?utf-8?B?ZkxwQ3ZHM0R5YWFYKzFyWXZteHRhQ1hwVzhmTTVPUHZtR0FUZEpob0Rya3Ni?=
 =?utf-8?B?MzF2R1NyaTJWcURiWlVaRjV1ODBUQ2FqS21CZXNtUWw2NUp0cVNMUk0vZDJF?=
 =?utf-8?B?VTZoQ0MwWDhyUHdlbm95Q3pwT3g3WWxOSkp0QjIzSy9FZG4zRmFGWVNxeldm?=
 =?utf-8?B?d1ErNlpzeWF6OGhXRWpISngvTDhab3YwLytjb3k1N3E3T1kzQkNpR3g5ZkEr?=
 =?utf-8?B?SUVrL3BVbWFZemtiVjNCU3Z0bUtOSysyWXRua1VicEJGWnNYaE1qRWZoc3hG?=
 =?utf-8?B?aVdqUmY3d1hrdHhtdDNZRDh1NmpYRlBEQ1Zwc1hDZW54MzJPdThCWXRUTlJ4?=
 =?utf-8?B?VjA5TjJqT1FudFh0ZEtvWVZpWEJCUDhONWJ6VW9PMUc5eVpBTkt3SThPT2V5?=
 =?utf-8?B?VlRiTm5QTFhvcXdsRmZ2ZzV6OTloM3NWVDNmQ1lwVStaajJnZ0lHTXlPeVZj?=
 =?utf-8?B?aWhiZk9zZUlZRmRqRVRCQXozcjZKYzBaQnk5bzduUFdneFZwcXE3dUwycURY?=
 =?utf-8?B?bXhtZlVXd3NmR21ibVJEQWFHQ3B1ZWcyQlM5U3pSeXBkRTBoLzJEeU1RNlI3?=
 =?utf-8?B?MTB4d1RUVjBGckVjOU9YekQ5MDh4T2o5YjJXK2ZXSzdHNmxCdXQ2RmFwVGlY?=
 =?utf-8?B?N0JLQVJZeXcxcDVLdzFGcXU3M3hkOTltMnRNQlpVbzhTVjRLMVNPZ1B2OUti?=
 =?utf-8?B?aVZYWERJS1hVMXp2R0JPOS9POXMrenE0YTlSNEhuUXVKaHM2N3NLemg2dlZW?=
 =?utf-8?B?V3NxV05MZjM3MlFlamw2NEJvK3FqdnM2YlRCcFZBamNaNE5CWWNJbHBKcHRa?=
 =?utf-8?B?RFdyK3R3d2d5TmMvMDFIbEtFOHhJK3JaM3Vpem1OeXltemtHUzhpQXNXdnlI?=
 =?utf-8?B?MzRXeGczSTZhMTRWdS94L21yZ1NnUmI0U1EyRHVuQTBWVTJWQlViRG9LeHR4?=
 =?utf-8?B?NHdPUlBWZzE2MlAzSkJJck9rWFMzZkhyRWtGN1VzMEpKRFk1UUU2RTlrRG5j?=
 =?utf-8?Q?KCtDjg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlpEUUhLM0Z3SnJEcFdOYlVNMDNKU2VVT3RmYzNTQWpkNS9Bb2VwQ3N5Rzl6?=
 =?utf-8?B?ZFFNcXhmcUJnTitRWDJQOWs0aldKV2pHVUZNd21GZ1FPd2c0TmhCQk9wNmtY?=
 =?utf-8?B?YWFjQ0UwU0ZKbEwyRTFQN3BhUk9OUjBVZGdKbTZQVFdGSS9QSXZEQS8yV0Vs?=
 =?utf-8?B?dEt6QmkxRVJESE5oaFJBQ2JuaFQ2czhiTjNzQ2h6K0oxd2NYbW1XNTBvWHVH?=
 =?utf-8?B?ZDBQSXZkWVBkM2tXcmhFb3I0S1VvTGI5M2NnWkF1aHE5MDJCZ2E2dkphSWdU?=
 =?utf-8?B?MS9UVXRpdFhzR0pudmtEM2JOeUg0NHBNQmZGdzUwY2VqWEhnbnhQdWpNUkZh?=
 =?utf-8?B?Z25xSmZzWGN1OG91SjJ0Ty9QYVk2ZEY4Wkh2OVhiNWdoQVNoZmF0elltb01S?=
 =?utf-8?B?aitCbXpyemZYZ3FWcmdxczB1S0xvTTIzaEZWN2dFODNITURvcXI3K05rajdC?=
 =?utf-8?B?NG4rOVZjaytydnNudGZYVXA3cHpIZE9tUGRodVdvSSt4OUVCWTlJZ0pITGww?=
 =?utf-8?B?QW8zWEpkUHQ4cE9yc0FDV0FKZWdlYjQ5OGYyOUpTQXFtNDRQd2V0bTdPa1Rr?=
 =?utf-8?B?Z2hHemtTM1ZCekhUejVmamxQeS96N0FXaWlLNzdzNU1rcENRRTlmQXk5MmJ1?=
 =?utf-8?B?ZGcwbVJ1WDYzRm4xZkI0d2QyR3BuRmEwcG9ZMVA5YVNzQUJZeHVkVkdkWGlJ?=
 =?utf-8?B?ODJpeXJ5eHZNalB6UDZEUnM1SGpXdEJRdkhwQUlrSWp0SVFXWk83eWFsTGpi?=
 =?utf-8?B?ZGhhaTBkQjVIMVhkRkVyNVhQWHEwUk15TVU0WXV3YkVRZXA2cU9ZbVd4Nndx?=
 =?utf-8?B?UnRxc2w5UGRld0tITU5WWDZaL3JKWTE0Uk9vQXVlcWV6MU9nNDVqcTJCUlVm?=
 =?utf-8?B?dG05ekMzQ25jVStZeVRjRE1ycWJVUU1LM1draGRvYXJ3WXpqb2lyemphWkZM?=
 =?utf-8?B?b004RHpmWVdLWS9tVGNuS2QzNUdwTU8wanZkWnBIYUNHQVgzYU9CZ2NGc0Fo?=
 =?utf-8?B?MXU4OHJuQUNtSzliL3gxWHZ6K0hpWW5aV2xoOFlwZ2RranlHQ0xZRFl2TFho?=
 =?utf-8?B?Y2lTNjEzYWNzTDVLYndrOE1MQ2VFT1h6OVBGMFZ5b2M4MWJnWFJlSk1nUnZP?=
 =?utf-8?B?QXpBOENZcExTdDFDeVZ1ZzNKUFRuaXVBb05TeHJhdW43L0kvbFF3ZkVCWDdt?=
 =?utf-8?B?RXJYWkhoOXRNTHlHbEJuYVVtOUIzMmtHa0lxSHJybTA1QUVEVDJHVm1lamxz?=
 =?utf-8?B?ditRWVVybjRPcE94MkxZSUd3bkVLUmFiWVFkRHFyR1J3aGpybzJxeDhYK1Ux?=
 =?utf-8?B?WTFFV2w3MFpvNmh0VHkwVlFndGZFL2QyNWRhd1VLTGFLcDM4UjN3UXJ0SnRW?=
 =?utf-8?B?Q0xJT1FITFJDYTRDdkVlbitxOFlVRWRFUm91NExnQjRZa3hGazJuR0luK1Y0?=
 =?utf-8?B?aUhEM2hKVTNJdEYxZGhabVNNMDEzZ2QyRHptMFBMN3lwb3dUelBRRFgvdTYr?=
 =?utf-8?B?ajM4L2R6U0V3eDBjdW1nTU9sM0VJUDdvQVJOUVV6R3RjZDQ5dGlkYU85MmtS?=
 =?utf-8?B?YXB2VnREOTdXRkQ1MG1TN1JqSHNpa2N1WURvWnhJRysxbitlTHhGK2xMUkow?=
 =?utf-8?B?RjhadnpzK0loZzZScXpySFNwNGJoMHJpTWtKdXo3R2Y5TFgrcUgyVVRLY0NB?=
 =?utf-8?B?bVhvbWI1QU9RS1YwcXZHcWYxU2g3VDhQRlFFc3hEVXN2UWttYTVZaWJ1SjVp?=
 =?utf-8?B?SEJZcUxlUUNKdlN2WG9jaHBkYzJLbHA3V3psNGxxRDlwVlpzbHlSR2FURk5l?=
 =?utf-8?B?cG43eHFEUy94cVhYV2pQdU9XZGRDZE96ZjVQQVRUTW1kOTNUUGc0SDBqWjAv?=
 =?utf-8?B?S1U5YVExM3FxMlpzY2pUNzl4RnhFTmlUS2hXQTFGMUxTV3c9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f277a-2180-4302-ec2f-08dee3e57bfc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR19MB6098.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:26:32.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5071

Hi Krzysztof,

> How did you address previous feedback?
>
> If you ignore feedback, shall we ignore the patch?

You are right. I should have documented the disposition of Andrew's
comment in this patch's changelog below the --- separator, rather than
only in the cover letter. Sorry about that.

Andrew suggested allowing a value of 0 to disable CLKOUT and noted that
this could also be added later. I intentionally did not add 0 in v2. The
only setting I have tested on this PHY is 125 MHz, and public documentation
for page 0xa43, register 0x19 is not available, so I cannot yet verify the
register programming and reset requirements for disabling CLKOUT.

Andrew's comment:
  https://lore.kernel.org/r/1a02ef89-2608-44c4-847f-239d9b86c7ab@lunn.ch

The deferral is recorded in the cover letter's Changes in v2 section:
  https://lore.kernel.org/r/MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com

I did not intend to ignore the feedback; I deferred that optional extension
until it can be documented and tested properly. I will state this explicitly
in the per-patch changelog in any future revision.

Best regards,
Liu Changjie
