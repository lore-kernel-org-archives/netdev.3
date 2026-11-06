Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793934993;
	b=io2YdxuNHudDEbabbw243qivtGLf0L4M1zM8C39LB+ex2SSKgUOxw9eIILfZDZqUP1j9
	 UxM3qXTlfHd6c3Lo5Sb2pYyHRcAa68VGFbAbVR3sZi+YSTNhIisiTFuItxZReuiXgHUuv
	 hFiRnqCHH9rczjvB7CBCYsNmcdtEpKVlFgWDyCrxDxXefvrgmC+R1Q5xWO8wfbAbkzFyP
	 HAR2e0mWw0b3DESCX0BRNk0hxXZioIKiapxzCCaipYoI4HE8k7LGibQLC843ocAPQLjXR
	 oFoFyO4pxPDuIJ9ORIl1nu+WAFlvZ+UrDZErKlgKPj1EXZmXVRpI35pmuXct1AnDs2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934993;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dKQJ1hqxJMm5ufGt9cHkbgDEczEbIUAAlNGYNj6221E=;
	b=BiXIF3bRNbZ+6gRO0J8xMOC9rj43mANcpR2vReIBRU+R5uT83JrQhpzKx4lRC9IW3C8G
	 4NI8dPeS3ZKQAdwT3QCw65V1OQjUC3X3RwpL3/ZCEWAW5psq3QMpmisGyKoSQ4CLPl74Z
	 NdC+2oneDoZVixqMdqX3CTBjgtU6RyoXu4Gll5EWXDuqFmtFOvTj2eP76jh49/rufmaLo
	 HKrM+wibT03HDlJ/py8sMr3NGICBFdftJVT4kRdbAAhhMq4f39jUeQ/YUesDuWYJDVDNy
	 eeJ0ylXbV/tB9aBExxWubWjYnASlnPNDuUjRFrtQDHO4hkP6zxZHu5EEFFCJstSMMsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=HrsnGpPD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.101
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022101.outbound.protection.outlook.com [52.101.126.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82577606D804;
	Fri,  6 Nov 2026 03:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82577606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=HrsnGpPD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMTZvMyLw7LWtaA4GjKrnog57msSZAOHQVDgKWCQfSZxoPhsxHaWE1vXg7o326J4bZO4x/upiVlL9JvPoArMtpgjI2fj3YQ9uN7sbv2GirpE+B5AHtUH70gy6BRvxaPwumGFfCHv+FpEfI1Ad5yWWZMMw0ohYs6aKtYkO+zr7Sf94fwKyg2A9nAY13BNn/43XaEmIMaDBMVPMVd7z6aZKqbHmjECbSi/SAyKDVQI/oRvXTV1SYdPRsU2IaMNGEthDs3QCFTQ795gMWsMsyidpjr2ZZvFHYW1OkSyoOrRb8QQhb8ATY/akBVbUzba1Fn0dGP1UF0jn6+TrkmMZXPPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKQJ1hqxJMm5ufGt9cHkbgDEczEbIUAAlNGYNj6221E=;
 b=E/ANFnAcrN6oRYyN7maSGEe0zBflAlPXfbITxIMJFHkjxUgVt9TylkNna7Af7GQVxnY+v7FauNT+b9OPCmccbKOY1r1rLsQO/BlRi8A/mSBOktNeJkwntRyLDcLqKQI/3HF+lXg+4UJGgCXKRC9jBTm7ZiQJTqEod6/EAHVw3/j7cfcKUfhbJuOp3vxcOaB/WR+8oOCzwYhjgjFdQkI7l6/herouPk0YJyF/OPZWKsqCM9IDE+xj5aqauWuU/+eeQ0ROeLU1O1mSBbcConkBaGoS3Jt56YQ4I+bH2Fd5KXToeJ1Pr7Q/AVWuy5LyfwVVcfLICdY5swuER24nd/Rehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKQJ1hqxJMm5ufGt9cHkbgDEczEbIUAAlNGYNj6221E=;
 b=HrsnGpPD4CmNlbPEVL7Dq7DmuDRmBV0CsMJC/ltAWBIt4I3og/sRzWZb3TsY2cThGSvGP7JZSZhtgAj21n2WbK6orey4TgJhtrx/w7eaqGlETxzP/+KGXw3pgQFcCqWYjqicq62ocdBYlFN5zaIrDKMGBGV4KMaqteXiXWkaDSlCKRQH465O4zFowfLkK9xZ34ojOjcJtdvvrKNrW/pjGwrzUDyUr6TbZPGBVNjfbKYPazXQLf0hB1ZGUg0z5gTioVpOEbmR9cNcAOwxPh48qTvfNZazxRU5O9EetTIHeCfwW3mca4MOgguwzC4IDJxChAJPbuWA1ujCPwgGQpE+Pw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB6893.apcprd03.prod.outlook.com (2603:1096:400:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 03:16:29 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 03:16:29 +0000
Message-ID: <35dc1ebf-5194-4ec8-adfb-dcc8ea717750@amlogic.com>
Date: Fri, 6 Nov 2026 11:16:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: net: amlogic,meson-dwmac: add
 amlogic,t7-dwmac
To: Krzysztof Kozlowski <krzk@kernel.org>, Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261103163715.385394-1-tanure@linux.com>
 <20261103163715.385394-3-tanure@linux.com>
 <20261105-stoic-cricket-of-tolerance-cb3014@quoll>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20261105-stoic-cricket-of-tolerance-cb3014@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
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
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d1db88-85d7-42e6-b95b-08df3bb4594c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|22082099003|18002099003|10067099003|14125299003|11063799006|4143699003|56012099006|261028144727099003|261026121527099003|261021123027099003|261102123227099003|261022105027099003|261009223027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ko1UReoZElL7bRcS5Y8cXY40TLHp2fud4HB0kEE96vUpwcldjvjYtSbJAD2FKfBMHSQZu6s8RSAYUZ/9hjNEzNR9uJgkVNl4U+1hhTzCTjum+pSIBaBRfLMf/SnWspiCyBDQ4W5c3x/gBaABWtaWScVJtXQSBoC7nqdIfAs5WcouEN0RWlGQKazZwI31cxvLZrb8kHBpOSObYvqwc3GkA0pHEjyIH1IeD2COV6MVHuHpr7e0mEvFBi4DkecEHYIz1a+GafpaiH4UKG70aaYLPz+LHhzmPQ4TfWsb+szQQuoRGId5RKUqZa588fM1zSH8PVhGKA3pCR+C+ceX6XPJwNkw+0X6XgmLsDKrCnfcCaBU+B4OgP1qDfdH6s6pN9zKleVlW98T29TrWK2Pn3aSevVPeYKPNI6nHd83vF4RnpH44Fx2MA2/OBlCgMDrLhaKqhh2lvuHLg9hsk5+94bS1wEK5FLMBVLGKHBchSCtpW1AhkhBNjxeG5OiM2nlNPGYNIwT4iRq9t0YnrMsHhcHplF02jgADOJaYtLL3l67DMiczlkJY6BF+sDnl6ikIiUfkEfVJTglJEheMHtXCDza66jYAa3l6rExhuQwYcNgdfoxBzegpIexOVvWzhNW20+Z+mdsW2yzoh2mVMcLFyJs0eZLbQatdwXe6dbjZ4P2MlA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(14125299003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261021123027099003)(261102123227099003)(261022105027099003)(261009223027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hTNmNLNGdxOFVtNDczaUZEQ0JwL2REaW1RNit1YzdUQlUwZzZENndmVTdG?=
 =?utf-8?B?anZqaWYxNytXa0lhU0Qwd21aQlNrcE8vSzdsWVFVWDYwRC93NmRZVFhCcG8x?=
 =?utf-8?B?NVZPTlFuMjJualhWU3d0cXREMlZJMWpkcGtHOUpLNlFCRnVCdTVIc2lLQmNV?=
 =?utf-8?B?WTAyN3k0cXVZQmFrOFhKakc0c1JBREJTT2FWakhQREY2ejhiRVZCWnhwdURB?=
 =?utf-8?B?QTF3OWROSS9KaEsvY1FnU1NZdFpsazRQbGY2UXJQelg0elNLQ3oxaXlGbGIw?=
 =?utf-8?B?MVNmNmxZWUlPeG5UaDVwWjFXZUJjd2FNS20vek53cTJqdjNDcGRsckpkMnlC?=
 =?utf-8?B?dWl3OFViODhJUXY4cXFRSHcyeThLdi9mYmcyZ1RHZ1YyZ2VZazRUanNONXA1?=
 =?utf-8?B?a3pQc1krL3JxWUMrY0kwajYrVFpjREM0dTc2cjlpOU1aS04zY3pXUDVvSyty?=
 =?utf-8?B?TW5Wbi8yT1JxNno3WENBWkZ4eEQwSVlJT1NtSW9PRUdMeXgzUmxXck5QaDRm?=
 =?utf-8?B?bFQ3S3BQaTU2YmVqQU5IRC9jOUdjcFR0Vk0vZ1JVRUx5SCtxbk01c2x4QWR2?=
 =?utf-8?B?aDRTdUNEdkpsdUpVUVowbHVBWXZIam1BdVUrWmhWM3hHMlkybUsrVXRhNUEr?=
 =?utf-8?B?bnRKQTZHbVBwS3VVOEdvTDJubE93VDhDY1pKT3RhQUh4KzFSTUJxa3B4OTFm?=
 =?utf-8?B?Wlk0akdoZW9abmxWcDl3UDdnYTdpMWUxVmNGVVZYUnAxaHpyOXRJa0JXQXlI?=
 =?utf-8?B?blBRdE1xaGZkWUtqdCtMSXJiSm1uNW9mVnNab3VaT200aTVPNi9MZnN0QVoy?=
 =?utf-8?B?Uzc3V0xONVgzN3BkdlBxTEpwT0h3YWY5WEFZOTBBRFpocGJPc3lPOEQyRTZq?=
 =?utf-8?B?dlpDeGEyTFZuQjRvVHFDY2o1RnlVcTZZL3E1UkVHVlpEVVM3OStNVGdjK011?=
 =?utf-8?B?SGlZVUlCM0ZQK25zUU5sTzNlSlp1WGJ5UTMrdzIydks2MDh5bUZlbDVSaUp3?=
 =?utf-8?B?ZGgzQmxjUzFVdzZMeWh2TExiYklPNTFWVE5FUzRSUHIyYS9KTExSSXV0UW4v?=
 =?utf-8?B?NjYyZVpJT2tUY1FCTUFua3oyUFVXTlpJZ3BVMHcrUEZscVZSMnZJWjNrOXA4?=
 =?utf-8?B?dlJaMi9sY1hKc2Y3YnBveHVDOEJoc2NORjRESS9DRWZuQlh5dVl0M0Y1anRi?=
 =?utf-8?B?ZzlndjN2UEtlSnJvTEJ0dEdjT1RIMHdQZU9WYkZRNmdVYlM2TFNXWHp6Y3Vr?=
 =?utf-8?B?RzJpeW9XMklxOG9uZHFjNktpVjgrdlMzR1NkSTMxUFBCbjN2L0dmTERPVlhY?=
 =?utf-8?B?aVU0ZTNEU2tOYlRQbDQ5V3Z6KzVVSHE4R0lGN1ZURnVOK3RlblFTOEl4amtl?=
 =?utf-8?B?NGhBKzhwS3NCRVd6dE1rZ2wvOVVzU3J2NVlvWmkzMU5ad0Rxc3lscnFwMmRo?=
 =?utf-8?B?ZXl2amNHK2preElJUzJlTGQ1TXl0S2FLa1IrekRheFZuMXZQbWFLcnZRcFRi?=
 =?utf-8?B?WE9MR3JPN01KWllVaHR0K2ZLUFhqY3VqcnlHbklSNEU4YkVzcW5NcGZ5akxm?=
 =?utf-8?B?cG5zeE9OSVlOZFJpVzBaMGhkakMyVDVWMHVMVTNYR3lIYWpKbVFGL1Z4VEU2?=
 =?utf-8?B?NFRxL1RhemVYS1dFWEkrZkxyZ3JWSkdkU2dEMFdDV2JDbmF5MUNNakp2NDVY?=
 =?utf-8?B?Y1RJNG1UbEdOMTdwNUJmSzBIMHd0U2tlQ1lVWTA5QVZqVU9IZi9Iak1KT1FL?=
 =?utf-8?B?djRoMkdoeXM4TnhNellnL2FkdU83ZGM3clp5MTNGMDdoU3R0MEFVdkpnQXJB?=
 =?utf-8?B?ZmdCalVxWUliUjl4K0xiR1pIQWtSa0RYbE5hdG1MRzBXUnU0RXB0VGRjQ2FS?=
 =?utf-8?B?Z0s3UlhUZXgxdWM0MWVLZmU2RTNTUW1RM3dtYXAwenA5N0x6TDIvamFkbnRV?=
 =?utf-8?B?NkhUbzQ0dWJXTkNpaFNYUmx3alNJaHdLNG51Q1VMQ1kvRUo5WnFvc1ZnSlpQ?=
 =?utf-8?B?azFZczBIWEhSVTdCM2hjRjVXWjE3V01iWmkzdU5iYmpqTkwvZHdFMm9Sa3BB?=
 =?utf-8?B?a1N2MDRtYTYzWVlOczdwME1MVFRuQXp4MzJDMTMvN0E1NEJOQjJJcDRSR3pX?=
 =?utf-8?B?QW9hK2VTa0hwaTVjVkowRWh1UGZhSUNRL0tiZ1ZTcE1ybWRVYUxUY1RoeVR3?=
 =?utf-8?B?QXJkbit3S2ZUa205UEI5OG1ITUYwK2g5ZjJTTk1aSmVpcFhrTERXZWF4WFJV?=
 =?utf-8?B?dHRBdGllWWIzYWt1RUZWK2dZN1ZaREYrcWJhbXdxM3VuTFByd2NTb1Z6Y2ov?=
 =?utf-8?B?R2ZoOEZlc2FQU2RBV295RGFDOENPT3M1UnE2c1RvZVdqMFdCcGlNQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d1db88-85d7-42e6-b95b-08df3bb4594c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:16:29.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXhOdMJZu2nvsEapOzqjhowOstq/bh5cMtt93ac5zaD6XAjURMKDesWCPDpjTGlxI3SdDtHyNOK3KlSLmlNkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6893

Hi Krzysztof, Lucas,

On 11/5/2026 7:57 PM, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, Nov 03, 2026 at 04:37:10PM +0000, Lucas Tanure wrote:
>>
>> Assisted-by: LLM
> 
> Drop this one.
> 
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>>   .../bindings/net/amlogic,meson-dwmac.yaml     | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> index e769c9bb70d8..6de013e3e8f6 100644
>> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> @@ -23,6 +23,7 @@ select:
>>             - amlogic,meson-gxbb-dwmac
>>             - amlogic,meson-axg-dwmac
>>             - amlogic,meson-g12a-dwmac
>> +          - amlogic,t7-dwmac
>>     required:
>>       - compatible
>>
>> @@ -57,6 +58,59 @@ allOf:
>>               - const: clkin1
>>               - const: timing-adjustment
>>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: amlogic,t7-dwmac
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: GMAC main clock
>> +            - description: First parent clock of the internal mux
>> +            - description: Second parent clock of the internal mux
>> +            - description:
>> +                clock of the pipeline stage inserted in the bus path between
>> +                the controller and the DRAM. Without it, the controller cannot
>> +                complete DMA transfers.
>> +            - description:
>> +                clock of the register block holding PRG_ETH0 and PRG_ETH1.
>> +                Without it, the block reads as zero and ignores writes.
> 
> This sounds like you take clock from other block. That's wrong, that
> device should take its own clock.

I see that the clock in the dts patch corresponds to <&clkc_periphs 
CLKID_SYS_ETHPHY>. This clock provides the working clock for the APB Bus 
of the ETH PHY controller, and this clock will affect the register 
reading and writing of the ETH PHY (including the ETH_PLL). See section 
15.3.4.2 RegisterDescription in A311D2 Datasheet for details.

> 
> 
>> +
>> +        clock-names:
>> +          items:
>> +            - const: stmmaceth
>> +            - const: clkin0
>> +            - const: clkin1
>> +            - const: pipeline
>> +            - const: pclk
>> +
>> +        # The PHY adds the 2ns RGMII delays, see ethernet-controller.yaml.
>> +        # The RX delay line of this glue is fine tuning in 200ps steps,
>> +        # added on top of what phy-mode describes. The TX side has no fine
>> +        # tuning: its only step is a quarter of the clock period, the full
>> +        # 2ns at 1Gbit/s, so the TX property is not accepted.
>> +        tx-internal-delay-ps: false
>> +
>> +        # Deprecated: new SoCs use the standard *-internal-delay-ps
>> +        # properties instead.
>> +        amlogic,tx-delay-ns: false
>> +        amlogic,rx-delay-ns: false
>> +
>> +  # Delay definitions for Meson8b and newer
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson8b-dwmac
>> +              - amlogic,meson8m2-dwmac
>> +              - amlogic,meson-gxbb-dwmac
>> +              - amlogic,meson-axg-dwmac
>> +              - amlogic,meson-g12a-dwmac
>> +    then:
>> +      properties:
>>           amlogic,tx-delay-ns:
>>             enum: [0, 2, 4, 6]
>>             default: 2
>> @@ -106,6 +160,7 @@ allOf:
>>             contains:
>>               enum:
>>                 - amlogic,meson-g12a-dwmac
>> +              - amlogic,t7-dwmac
>>       then:
>>         properties:
>>           rx-internal-delay-ps:
>> @@ -142,6 +197,10 @@ properties:
>>         - items:
>>             - const: amlogic,meson6-dwmac
>>             - const: snps,dwmac
>> +      - items:
>> +          - const: amlogic,t7-dwmac
>> +          - const: snps,dwmac-5.10a
>> +          - const: snps,dwmac
> 
> I see no such hunk in the code, so not sure how to review this.
> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Best regards,
Chuan

