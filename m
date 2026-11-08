Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794143955;
	b=V/bA8a3VSQLQqEBRwovwqpy8+Hk0T1PV+UCgCKMZGK4DDb2OJ5Kfk4FsmjxmqmKAIg5C
	 zSaQtJEdRqRnWHWaE1oh/3AeNiLu4DK9QkcSQWbgRJnmXhsGMbpu1tdnPNHMfGDlxkOpX
	 uHzlK/8FB3/a1BzqerDo2hlxJZWqaP19ivifAOEnlmYXaeOqRV2kP/cofQsQoS1Bh03os
	 7WB0K+U6CxMF5zImssrwHCopcCgBLTgvp/TOfR3kaXW5xG0T9LlYRpFOYgQ40nSv3F6tJ
	 UH8kfmXKRElps1NvxAUkvf1CH97oUyyJQJQnPXVBVe+3gu5m5f6xKDT/ggshSncNoeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143955;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kb5frZ1/UenSdbYvoAPHIzM10ma1Nj6hc6y33get5N4=;
	b=JLSk2H/3t74UXjmMGiSDDbx85ZS2mMyTyVtdwrDKmntXC11EvGwNXWdUk29dWD7yODkw
	 1mWFxCbrDp52cxzU2qFKKhYJJ32Y0Zb7eJui4SXEeo9JzDTz5R94Yhk/ICHLj8vsHjKo0
	 8nZUkqv9q2jtagxXiM7a13LVHLI4gLUaqYfYRgThpm5adMZBrUAkwMbaqT6HMVNoPyQGK
	 Um5Q26KC4VwfbgVdp43OX98oDdjE+N0/Z/hTe7nPD48tjKUGB6imbFtSNytGl8yc/xC/M
	 Uf4p6PgFpM/ZZlCg972dqZC3pxVmzPhfC1gqrbsJl4gbm5+FcNfHQhnlSKLlwKYAD0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fW5GFjxq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.20
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010020.outbound.protection.outlook.com [52.103.20.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292A606A31C;
	Sun,  8 Nov 2026 13:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D292A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fW5GFjxq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdUEckcSKDLWsM4i1ZgHwpVlypqdd7nU26yDaoq5eZ/A7K5dH4otA3SGkZTSMz9scHufbpKZ3QXZIIDF2QsAbtwSL7NQIUECe4c1IYdsEAQNdZ0MRrtnz/62CCxCWGVga4BPWBOlevO4df6nR5LBJyM7doawEfBuuaYPa3RZ7Efw/kaYb25C/U32fLeV60884/nmCxn4jRahf1YfjMtPohVyn6h7vTMJre/AyYP5FcXTvLSMxMoNYR5jB0Q0l7JrPfMZYK8qOpRVka5nj/rhuUc9CNx6+VEZW7Tk4QAsNWpBjGH7FEROzvLM2lmOh1wRMXZq1dcwJdDD6k3JQSuSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kb5frZ1/UenSdbYvoAPHIzM10ma1Nj6hc6y33get5N4=;
 b=xbaNyCnQEClfL+Y+q1/DAl/c3vY2XaizmhN+NWxIV3CDPC6QZd+y1CjKD1gQM35/psuuh/cVOHm3bHnY5UY0y8TdnStddWBNH9dYKZ4J4RER1bexxURynfux6AOmfnAQKaD72HeDnIJWq4+oEV3IPCMw9MqWrzfTZNEc8AUTN6pW6EZPsLM1yUPrpw8ZOZlfAfgEf1U71uaNT1UsUFufGn9TXqC3k32q/T6wfTzmogMGmK+1kH4v7HElUkGMCVS1t91V9v5LytEz0Js5q38JZPXmb/bMPesfUbQdrTsTyKWHGP5V1O9jaBAeT4CucUR9QoDeH3/kGRzrsGbIHj9PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb5frZ1/UenSdbYvoAPHIzM10ma1Nj6hc6y33get5N4=;
 b=fW5GFjxqJEtVyXj8D+IigqoOwra55B0sBD5hMaMI2mcifBxHUS3ZJwHvNztaSmNjSboHw4OJNHi80Y00W5cGxaqi0C0xP557dmIUQoHpNZ9OLYseIJNjp2xsqxqW037damiKIG/0qW7m/ycZOdmXiEem4mtEunCPYgylXjc4ft9I2P8b7k4WpaSLvCbK/7elvp630xlOXpzAnjDqrcMBk6jD7TT7pZY2iqyQmEUapm/Ck+ma0ul1N+3IGT7mkk+bxp8ctjCrHpVLNkuE8X3FghHcZIZDtNdQz46mOp0VW/4Hh/xqs4Xzbm9qTbR37GMSMEMQc3VqzjU4McUa60niZQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by SA6PR05MB10987.namprd05.prod.outlook.com
 (2603:10b6:806:446::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 13:19:12 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 13:19:12 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "wang.zhan@smartx.com" <wang.zhan@smartx.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3] net: preserve rps_default_mask on failed writes
Thread-Topic: [PATCH net-next v3] net: preserve rps_default_mask on failed
 writes
Thread-Index: AQHdb4O+1b7u9iHTI0SAfp4fp6e3Mw==
Date: Sun, 8 Nov 2026 13:19:12 +0000
Message-ID:
 <a235de028cc4160692127c6bf44ac567185b5449.1794143938.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|SA6PR05MB10987:EE_
x-ms-office365-filtering-correlation-id: 6322bfc7-9274-4a62-b2da-08df3d9ae14f
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|25010399006|8022599003|8062599012|8060799015|19110799012|15080799012|5062599005|22091999003|24121999003|31061999003|24021099003|41001999006|1602099012|10035399007|30101999006|26121999007|3071699003|102099032|440099028|4302099013|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wm5TVU9ib0VEakZHMkkrNFN1aWUzdGg1blZhc1BPdXZxeXZMaDhqLzZYY29v?=
 =?utf-8?B?czlqVXo3RGJxN2hRSHNXRkJLM1dRWXJVZWx4V1Z5cjcvK1BlZDhQTjVYS0J6?=
 =?utf-8?B?M1o5b0pRWG1yc3BtQ1ljVHRzb2JQRFNCeUp5bTVoeGdoa1NMeGFTYStMa0U1?=
 =?utf-8?B?SDNIL2kvWllrR3E1NnJkcVNwZ2RMQ2h4Z2w4RUpPbHJxbUdIaHZSZU5ocXhz?=
 =?utf-8?B?K0FCQTlKRGxxc2JZMFR4eDh0K005WGVGNjVVZW5LSXE2czFUZlRjVDBsOHR6?=
 =?utf-8?B?UDN2RGpGbTQzS2ZSbVBIR2ZsOFNCMFV5ODIyVkh6NllST0RsenpDbmt1WXRU?=
 =?utf-8?B?UXdpN29waExWUmVXQytxVlhodnpFZUc3TjhmemRzTFVEN3FUTWpGNk5MdlVv?=
 =?utf-8?B?VHlmemppWlZjeXZ1cTZRTDhMSVpNZlhpS3pMcmUxNURtMFJDU3hFMmd1M1JV?=
 =?utf-8?B?TElDZm53dmhXb2hlUTFtb0dwakd1KzNaU05xbDZtRmpTOHdlMlhOTGdxMFRt?=
 =?utf-8?B?NFJFaXFNSXRPMVdIcWtzWlZDdTRPMDI3Vnl5NEJpaVJzbXA2S2c5Z1R6dVIy?=
 =?utf-8?B?WmkzTTNQUlpUT2tZanliK0tRZHJTZnZDMGNpZ3BqSk0rMXVyV09xSTFlNm9T?=
 =?utf-8?B?V2xpZHgvOW96TEJrWXJQdDcxdzBTR09VREdZcjVKUGplZzR1UW9pbG11RHY2?=
 =?utf-8?B?RVo2K21jdUE2OVRiTEo1cU9HR3VPM1FsTmhjYmh0bE5Qc2VwcE94dnhmN3JU?=
 =?utf-8?B?NEdDNUpIb3lRZFJ2L3BFU0lMcHY4UHdYSnVYNGttMkZIRk9Tcm4rOFRRMHlM?=
 =?utf-8?B?d3crRWVYRGUrM00rTGhESDJtbXVQRlRtTTNWNWZsSm1BcXg0YTBkM29HNlZv?=
 =?utf-8?B?ZUs4eFM0V2hkbzJRcm1wbVd2Sys1MDFiQjFpYk9JRUNPMUhaazBMTW0zZ2Na?=
 =?utf-8?B?OUZrdkIxK3VSM0JSamM1cWZWd1dHeHIxN0NnSGZCSC9xWTBnMVAzbDdqTnZW?=
 =?utf-8?B?SXRFSS9Fc3pGRytCTlJHNmIxTUN5YmxIbjdUOEI2RHp2SUJnbnYzKzZXSU9E?=
 =?utf-8?B?elAzZFdMVmtzbVF6bVRaL2x0eWh0RDViL2VFaHk1N2I5UmlpYkZUZnRYandX?=
 =?utf-8?B?akovSUczcXlXQStkUElJZnE4NmlmaHl2dkpldHo3U0kwYWZmSTk5b3VhNDgz?=
 =?utf-8?B?eGk4QUJVM05JbHR2NGthaEY3cWx4RFRuY252Y1dyVkovRHpyeWlrNEhoVkYy?=
 =?utf-8?B?WTduWlJEbFZUVWJ5NVVtNHhxNU5mSTdLbllUcEMwMS9KbExRalE2LzNZZkc5?=
 =?utf-8?B?TmxTcWtLQ3ZCVkh3dG9qOFltMEN5ZUNKd1psOXgvRlJPVVNlM0xpYVkzczR4?=
 =?utf-8?B?SzhoTGFDRjhkRDNmaFhNZEp5RjdnQkJVK0RjdmlITXRWSUgya1BJeCtWZWdi?=
 =?utf-8?B?alpSVWdSVmRqTCt0bHkzeEg4RTlRc1dBYkJGaDNHQjUyTVRVSy9nVHBGVi9i?=
 =?utf-8?B?S2xUQm5TWVRackRzbVQrT2tKcTRFTUpEalpETm0xaVM1KzJZekdKbkVpRi9s?=
 =?utf-8?Q?csO9hWb3uT1DFPVrGOWuf7O8F1+6RPTDC+reooWucDdL0A?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2M0eFRQdURxL1dXcEh3a1JrYnhsNnBmQkVyeFQyMUxJdEJaWEhaNW5HMFdn?=
 =?utf-8?B?RUl3UjJjenlZUFhPdkxodDh0RTlKVUFZUlVNaEJaYzdud1YyenlxM3JsQzl6?=
 =?utf-8?B?VFF4TEhwNlRvVU9vT1pBV1djTnJBZnhVRGlaM0R3VDFDWG1tNzRtVE5zK2lS?=
 =?utf-8?B?S3JSYTFkaWd0MVJVbWdwWmhXTThPOUgwMUFzRU43LzV5cWhwbWZ1MVhFU29w?=
 =?utf-8?B?aGNIM21tRHV1MnJvQk9EMHBhSFZUL3o5SHlsbC9IVEhuVlI5djBVSVJ0ajc0?=
 =?utf-8?B?V3NtbWozZnd5RFFNckFPOWVDVmJQa2FBcFVEWnpoZG4yVXVETEtHUnBUbDJ6?=
 =?utf-8?B?VWs5Q0NWL1ljRmloVFA4aStFSEFNSXVYZzZldkZPSlVkQkVSYm9aWS9RaGJT?=
 =?utf-8?B?bTFEd1J1K2lzemNOOXhCOE0xUUVUem1EU3YwYnhKbW9uRmtBcmJTcjBDU1lT?=
 =?utf-8?B?VGdVZ1RGNTMrMVloZW1NT01SbW5QTTl2d2tKWUp6VGpVbGJJdm15aXVWODE5?=
 =?utf-8?B?Vm11eFFvNmV0ZTR0S2hvVDM0RytBWXFoRjJQODhzYTk0V1VJNHY3alNPMHdZ?=
 =?utf-8?B?blhnUnN4TDVBQ2l4WVRNRzZ1bzZ3VUdvWGlYcWsxelNMU2F5QTFKNlozcERB?=
 =?utf-8?B?YVE0b3VaVnlhVm9rYUFJUkMzb3g2V2l3Uno4djJ4MGl0NVZFVFhNZ1RTM3dD?=
 =?utf-8?B?K2pxdmFKS2Y2Si9SZ2h2V3l4ckJDSTFBbFlEUFlLZjJLN0Z6Z0cvNU1ONlE0?=
 =?utf-8?B?THJXdy9weDZSeUxLN05TTytJOWZ1aGxBN3V5cUxKRys3YkUzb3htVU9OaFl0?=
 =?utf-8?B?M2ZESjg2OC90VVd2THRSMk9TMk9lTFp5dWU3cDdGQUhMK1UvZWJwSXRlc1ND?=
 =?utf-8?B?V004dG5oWFpsaW00aDlINmNaTFk4MFRPRzlLenFsZi9FSkJRQ212dTBra2ts?=
 =?utf-8?B?U3hodlpmSHJXWjFUNTBHSklTM0RTMFBCemVyV21NOVJCcVE4dWVNUjhZWlJv?=
 =?utf-8?B?SThlNWlRNmIrVEFOSEFHUmhJUlJBbDFxQ2R3SDNWQ2FIeVdXUHg1SzJMWUVP?=
 =?utf-8?B?NUdSbjNFMllWVy92YStHODM5VXExVXg4TThFT3M4cUtGb2NzcHV1L09aSU50?=
 =?utf-8?B?QmxzM1Q4REE2TzdIdEw5MXRpWGlLd3ZRV1E5QzE0MVNmUWFmUTNNdHkzNDlD?=
 =?utf-8?B?VWYwRXRvTXlCTmlkRytIbTVmdktoRkpHYmNZUG5UOUsxVEVLN0RMdkdqVURt?=
 =?utf-8?B?YnJIajlrbmV2bm50UGRmWVh3M2FBVWNiaFdlU0NxVXFBTG5vQnhRaTNSanZ1?=
 =?utf-8?B?ODJvODM5VG1xUy9saU1vN3REaHgvRjlPdlkwZ1ZkbDNnOVdVNUczSnNmK2Ir?=
 =?utf-8?B?akp1R09tNlZDV2U1L3NnWUROUmV0TlEzZTZDdzMwU09PeXp2enRsbFFXUXdm?=
 =?utf-8?B?T3JHdlhUZ3BEb1I5UzB6SXhGcForVlNncFErbmt2NmxubDFIL2VvUDlkc0dT?=
 =?utf-8?B?b1hlN0ZmdldTbm5CMHZPZVlCYmxOT3A3Ung3eU1xcWFmbnIvbld3YlEramFy?=
 =?utf-8?B?c0Y3Ym9SSXdCcTlLRUNvV3llemlzd1dscjJhV01aT1V5Z2RZSXd0djdXbGNS?=
 =?utf-8?B?d3NoNTBJL0cvTWxwQ090QjVuZ1Q0TjYzMFdLQUROb0Y0OVphanhDL1BOd3BN?=
 =?utf-8?B?R216MjBZanZNa2t6U3J6b0pJeWRRQ0swdWlIOHFJeXBwd29ISTRSQmNLT1Zh?=
 =?utf-8?B?cE5qaWlFbXlpWFpsZmh3ckF5cHJGK3ZJOS95a0ZIRGxhTHo0eGdXYUdzdlZY?=
 =?utf-8?B?WVFCeHRuVmhTdlN0MDBteXhhZ0xERlptTTRCRGpLUlZlNExaVk9adVdZWkxN?=
 =?utf-8?Q?fRuo1lJSDby6H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6322bfc7-9274-4a62-b2da-08df3d9ae14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2026 13:19:12.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR05MB10987

cnBzX2RlZmF1bHRfbWFza19zeXNjdGwoKSBwYXNzZXMgdGhlIGxpdmUgcGVyLW5ldG5zIG1hc2sg
dG8KY3B1bWFza19wYXJzZSgpLiBiaXRtYXBfcGFyc2UoKSBzdG9yZXMgY2h1bmtzIGFzIGl0IHNj
YW5zIGZyb20gcmlnaHQgdG8KbGVmdCwgc28gYSBsYXRlciBlcnJvciBjYW4gbGVhdmUgbG93ZXIg
Y2h1bmtzIGNoYW5nZWQuCnJwc19jcHVtYXNrX2hvdXNla2VlcGluZygpIGFsc28gaW50ZXJzZWN0
cyBpdHMgaW5wdXQgaW4gcGxhY2UgYmVmb3JlCnJldHVybmluZyAtRUlOVkFMIHdoZW4gbm8gaG91
c2VrZWVwaW5nIENQVXMgcmVtYWluLgoKQ29uc2VxdWVudGx5LCBhIGZhaWxlZCB3cml0ZSBjaGFu
Z2VzIGJvdGggdGhlIHZhbHVlIHJlYWQgZnJvbSB0aGUgc3lzY3RsCmFuZCB0aGUgZGVmYXVsdCBj
b3BpZWQgdG8gUlggcXVldWVzIGNyZWF0ZWQgbGF0ZXIuIE9uIGEgZm91ci1DUFUgVk0sCmFmdGVy
IHNldHRpbmcgdGhlIG1hc2sgdG8gMSwgd3JpdGluZyB6eiwwMDAwMDAwMyBmYWlsZWQgd2l0aCBF
T1ZFUkZMT1cKYnV0IGNoYW5nZWQgdGhlIG1hc2sgdG8gMy4gV3JpdGluZyBhIG1hc2sgY29udGFp
bmluZyBvbmx5IGlzb2xhdGVkIENQVXMKZmFpbGVkIHdpdGggRUlOVkFMIGJ1dCBjaGFuZ2VkIGl0
IHRvIDAuIE5vIGtlcm5lbCBtb2RpZmljYXRpb24gb3IgZXJyb3IKaW5qZWN0aW9uIHdhcyBuZWVk
ZWQgdG8gcmVwcm9kdWNlIGVpdGhlciBjYXNlLgoKUGFyc2UgYW5kIHZhbGlkYXRlIGEgdGVtcG9y
YXJ5IG1hc2sgYmVmb3JlIHRha2luZyB0aGUgbXV0ZXguIEFmdGVyIGJvdGgKc3RlcHMgc3VjY2Vl
ZCwgc3dhcCBpdCB3aXRoIHRoZSBsaXZlIG1hc2sgdW5kZXIgcnBzX2RlZmF1bHRfbWFza19tdXRl
eC4KUmVhZGVycyBhY2Nlc3MgYW5kIGNvbnN1bWUgdGhlIHBvaW50ZXIgd2hpbGUgaG9sZGluZyB0
aGUgc2FtZSBtdXRleCwgc28KdGhlIHJlcGxhY2VkIG1hc2sgY2FuIGJlIGZyZWVkIGFmdGVyIGRy
b3BwaW5nIHRoZSBtdXRleC4KClRoZSBpc3N1ZSB3YXMgZm91bmQgd2hpbGUgZnV6emluZyBzeXNj
dGwgd3JpdGUgZXJyb3IgcGF0aHMuIFdpdGggdGhlIGZpeCwKdGhlIG92ZXJmbG93IGFuZCBob3Vz
ZWtlZXBpbmcgZmFpbHVyZXMgYm90aCByZXRhaW5lZCB0aGUgbWFzayBhdCAxLAp3aGlsZSB2YWxp
ZCB3cml0ZXMgb2YgMiBhbmQgMCBzdGlsbCBzdWNjZWVkZWQuIFRoZSBleGlzdGluZwpycHNfZGVm
YXVsdF9tYXNrIHNlbGZ0ZXN0IGFsc28gcGFzc2VkLgoKUmV2aWV3ZWQtYnk6IFdhbmcgWmhhbiA8
d2FuZy56aGFuQHNtYXJ0eC5jb20+ClRlc3RlZC1ieTogV2FuZyBaaGFuIDx3YW5nLnpoYW5Ac21h
cnR4LmNvbT4KU2lnbmVkLW9mZi1ieTogWWluZ2ppZSBXYW5nIDx4LXByb2Zlc3NvckBvdXRsb29r
LmNvbT4KLS0tCkNoYW5nZXMgc2luY2UgdjI6Ci0gVXNlIHN3YXAoKSB0byBwdWJsaXNoIHRoZSBu
ZXcgbWFzaywgYXMgc3VnZ2VzdGVkIGJ5IEpha3ViIEtpY2luc2tpLgotIERyb3AgdGhlIEZpeGVz
IHRhZyBhbmQgdGhlIG5ldyBzZWxmdGVzdCBwYXRjaC4KLSBSZXRhcmdldCB0byBuZXQtbmV4dCBh
bmQgcmViYXNlIG9udG8gbmV0LW5leHQvbWFpbiBhdCBmYTUxOTYzOTI2OTEuCgp2MjogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci9jb3Zlci4xNzkzMjg2NjI2LmdpdC54LXByb2Zlc3NvckBvdXRs
b29rLmNvbQoKIG5ldC9jb3JlL3N5c2N0bF9uZXRfY29yZS5jIHwgMzAgKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvc3lzY3RsX25ldF9jb3JlLmMgYi9uZXQv
Y29yZS9zeXNjdGxfbmV0X2NvcmUuYwppbmRleCA5MjI2Yjk2ZjJlODkuLjQ2MmQyZDYzZjBjZiAx
MDA2NDQKLS0tIGEvbmV0L2NvcmUvc3lzY3RsX25ldF9jb3JlLmMKKysrIGIvbmV0L2NvcmUvc3lz
Y3RsX25ldF9jb3JlLmMKQEAgLTEwNSwzNCArMTA1LDM2IEBAIHN0YXRpYyBpbnQgcnBzX2RlZmF1
bHRfbWFza19zeXNjdGwoY29uc3Qgc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwK
IAkJCQkgICB2b2lkICpidWZmZXIsIHNpemVfdCAqbGVucCwgbG9mZl90ICpwcG9zKQogewogCXN0
cnVjdCBuZXQgKm5ldCA9IChzdHJ1Y3QgbmV0ICopdGFibGUtPmRhdGE7CisJc3RydWN0IGNwdW1h
c2sgKm5ld19tYXNrID0gTlVMTDsKIAlzdHJ1Y3QgY3B1bWFzayAqbWFzazsKIAlpbnQgZXJyID0g
MDsKIAotCW11dGV4X2xvY2soJnJwc19kZWZhdWx0X21hc2tfbXV0ZXgpOwotCW1hc2sgPSBuZXQt
PmNvcmUucnBzX2RlZmF1bHRfbWFzazsKIAlpZiAod3JpdGUpIHsKLQkJaWYgKCFtYXNrKSB7Ci0J
CQltYXNrID0ga3phbGxvYyhjcHVtYXNrX3NpemUoKSwgR0ZQX0tFUk5FTCk7Ci0JCQluZXQtPmNv
cmUucnBzX2RlZmF1bHRfbWFzayA9IG1hc2s7Ci0JCX0KLQkJZXJyID0gLUVOT01FTTsKLQkJaWYg
KCFtYXNrKQotCQkJZ290byBkb25lOworCQluZXdfbWFzayA9IGt6YWxsb2MoY3B1bWFza19zaXpl
KCksIEdGUF9LRVJORUwpOworCQlpZiAoIW5ld19tYXNrKQorCQkJcmV0dXJuIC1FTk9NRU07CiAK
LQkJZXJyID0gY3B1bWFza19wYXJzZShidWZmZXIsIG1hc2spOworCQllcnIgPSBjcHVtYXNrX3Bh
cnNlKGJ1ZmZlciwgbmV3X21hc2spOwogCQlpZiAoZXJyKQotCQkJZ290byBkb25lOworCQkJZ290
byBvdXQ7CiAKLQkJZXJyID0gcnBzX2NwdW1hc2tfaG91c2VrZWVwaW5nKG1hc2spOworCQllcnIg
PSBycHNfY3B1bWFza19ob3VzZWtlZXBpbmcobmV3X21hc2spOwogCQlpZiAoZXJyKQotCQkJZ290
byBkb25lOworCQkJZ290byBvdXQ7CisJfQorCisJbXV0ZXhfbG9jaygmcnBzX2RlZmF1bHRfbWFz
a19tdXRleCk7CisJbWFzayA9IG5ldC0+Y29yZS5ycHNfZGVmYXVsdF9tYXNrOworCWlmICh3cml0
ZSkgeworCQlzd2FwKG5ldC0+Y29yZS5ycHNfZGVmYXVsdF9tYXNrLCBuZXdfbWFzayk7CiAJfSBl
bHNlIHsKIAkJZXJyID0gZHVtcF9jcHVtYXNrKGJ1ZmZlciwgbGVucCwgcHBvcywKIAkJCQkgICBt
YXNrID86IGNwdV9ub25lX21hc2spOwogCX0KIAotZG9uZToKIAltdXRleF91bmxvY2soJnJwc19k
ZWZhdWx0X21hc2tfbXV0ZXgpOworb3V0OgorCWtmcmVlKG5ld19tYXNrKTsKIAlyZXR1cm4gZXJy
OwogfQogCgpiYXNlLWNvbW1pdDogZmE1MTk2MzkyNjkxMDUxOTYzNzI2Nzg3OTQ0ZGI4NzI0MjBk
ZmE3NQotLSAKMi40My4wCgo=
