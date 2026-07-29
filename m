Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8A3B42D7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785308420; cv=fail; b=c7F1AJg+G3b6BVepW8tTP3KVQIFRefy59h+vmX3AbzWRjrs427K6YQmkep+icbEiGQSA1llQ+qfucorWdBSBeUlueN/uo2zkfNMslvqyABKU+wBZXKx/fBd0TxE4DqAXl4+ufT0wciCXbx/bjx8ZyL/rUBvl15WTQOlAhT/Ld1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785308420; c=relaxed/simple;
	bh=E4Zlv/QugfYXRED5nD6S6PXEWP+p1lvH06ep1jGbKgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9yCLV3udX6bOKFQpxaWYENJaMzt8rDJrgArWgES8tXHBzTN/hbJNdBGe/7zC6P0sH87Gl0qnujNuEbbxsEEdQEej8Od9TSZDTFN061fEZ+xterodS0yQ41xrPgVZ/3J+EiA1SQp4NWi0HwJlf69MXo2LVXiPYbQvS2pt/jTpNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wsf31T4o; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wsf31T4o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR6ZP1Ug9slrW42nEdbvZh1gBK6fDwCTHXTq4o401rsfCWF98/1A8YbWhMqgO7JvWvbk/L0LzVjHLN3+rRhb/pSs8ta0iVlBO0L0lebvzalM14CF4IwsFxWTg3iW/AUDr4mRPMdStaGxUiPBwRbS1c+wAN4Waa1Bg2cAwuCR275N67wk3mhcXUKNp9k3r+3DwW0H9waX4whoVJG+v2gTsoUiIXah2ho2DqCTxDWtj7iamb/QbhrhDQeJV+ozSaobBwzFXUBurdbXauT5PRJy34+4epcdJXuDGMOQGx59TQEUahQbcXWjgfU79/AcOSRddxDKMU3ySsZCdDsbDD2x6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4Zlv/QugfYXRED5nD6S6PXEWP+p1lvH06ep1jGbKgc=;
 b=JIav4jLlT7jiGFTcS1Ny+OABUKfn68HbPgOJy2iRtNbCSAJwz5aB/JcXb5g9mQvM7vpwZwTcpnzT5OTz/lrukCHU5H4NeRyyPG8Slg7dCLz3SvY4LES+oP1NM46mM2YzyFAly8Koy3j/ykN7MEhZJHytGuVtXiqAK6Wsh4mnOpDABVH/oLRPcl6NpKapf4D4xVQA6dhGysw9KUyDA1UB5rMaLxckVYBKfQAaICT+isjnv8mbsvqYujgXwwtrkDpCjs40mIZLURvG0Y2A7l1el/DsDHJTZyojUfxf8XiJSnuCllV9pH9s6r4X8zlUv76YFY8fqXpIOXKhDvwoO7AGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4Zlv/QugfYXRED5nD6S6PXEWP+p1lvH06ep1jGbKgc=;
 b=wsf31T4ottfYwH90sGk3u/G+OZX/vNJRm1N3HTzmWZsuVvGrYBfPrPuqp1kY4TMzQLVk28SKnUZ5BKoOu4ItwU/LplUsGN8pOxYeWoydjpq9o3f+Zw5a/ANu7fdzj2g4XcnbJe/NXcy+i5LQpi3hqQmOcjqoYk8+UFS9C7eB+fdKjdkwhaK4+Di358v3tYESdqO8zYyHPWVzOuWSAX78aDqkqkLEwE5nRuKVrUQF+h4a7PFYUYdT304xt7bD6euZgm34R3fPhMXQlXIvJwsPRgwIox3Z+m66erBwuEE5kASvdSt/nHWvrsS7kUIBTOdUqSVNersHBW5HMfwlU/7bSQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA1PR04MB11264.eurprd04.prod.outlook.com
 (2603:10a6:102:4eb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:00:15 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:00:14 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH net 1/2] net: enetc: restore RX ring congestion mode after
 ring reconfiguration
Thread-Topic: [PATCH net 1/2] net: enetc: restore RX ring congestion mode
 after ring reconfiguration
Thread-Index: AQHdHjjb4ftyiuw6qkiy2MgovCsT/raDx6gAgABLssA=
Date: Wed, 29 Jul 2026 07:00:14 +0000
Message-ID:
 <GV2PR04MB117396AD7EB61A3BDDE4E5DE488CA2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
 <20260728023217.2499420-2-wei.fang@oss.nxp.com>
 <20260729022917.395E21F00A3A@smtp.kernel.org>
In-Reply-To: <20260729022917.395E21F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA1PR04MB11264:EE_
x-ms-office365-filtering-correlation-id: c3cbc142-6b1c-46e0-963d-08deed3f0a84
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|376014|6133799003|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UmZz7GcAeiym2Kh94JvD+U1fWW1xgvrJOCJUNowoFg2p5PJ9f6pG4Z051DEBmVGJhK72WlM9msByynfMpa50bTmkIQwi8r1GPwGSrmXDYQBRRXswkJ5Ep2tIjhOQ+/kId0EgGY8kLOqBLEuF4trHJ2VAovUIWkoTJRDWoBNXA8ckMMbUWPuwDnw9xQXIZYau5GnXtwH5rMYP4ZqOUSb/avesCw0hfBChU+/eLUSDSAcNvT0FxM4zFjvYNvehjCFj5bU1W30u68cad9zqi9XhIdjTkSaVWgogvW9xU38wIBy7+JoGwcvTxTGUcjH0a3vmV5qnW758ZGK81nrFNiW2sH4vFTRemCjzHRlmgAxPwpPl+yBIePUluPSnSUaAwr1WyPM9x4lWk+0zjXPCUApC9kJ7ZLxZjtfd1pRkx79tJKHv/2zQOl42K+I0VBCiDOjWLc6DyDAR2nhVkq/4gFL51zoWSnc4jP6l4PiYgmJqvgxekumxJ7xcF4ZrXBxk/4c9p09Tn4z8GpKRsRM5TVJKz9NTH8PGc8CnEutyBq0y9mf7P/vNrJfiUkzMrXcJKU6+pika0eN24zBuKt9RzCPLe6R121cm5Uk5R3OIM1ENQEA9XppAh0huRdIfWE7wKAH8cQTwYhEYMG6RvcuLgawXvkJj0le3XxqOXNue4oEUVYuVOj8oyTGExc5d8gHNFwIzCDAl1FoX+gU1US6QM8Si+gqWa2iMyipsDcOD5T0TJlM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(6133799003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTg4NjE5SWlVWThBSmlDaUszMVpUZXZCZFJoYktiZWZ3OW5PMEo3d21mZk9y?=
 =?utf-8?B?YzFVeDZDU0puV1JtdlptdXVaY0toNHFMQjZkUmZpVXVhUkMyWVljQlVub055?=
 =?utf-8?B?VTNBbG9DTDJhVWpPdVdDd2tqRnBNZHJ5V2dXNDFFZ2d5S21MWkQ4TkE1WXp6?=
 =?utf-8?B?d0NIZnplVWxubFpIUjVGc2c4Mi9yekx4SGFYbHhNNU8xWWRzeVBYdzB0OHNm?=
 =?utf-8?B?UlpHQVg2eHJhV0RJbVllZCsyRnRDS29Sc010ejBESllrV1ROTzArNU85RzVF?=
 =?utf-8?B?d21qdHhXSlVyQjdHSWZ1Y1puM0hvZ3Bka0NCbGFVZC90QzFQRFM2VnBEbkJl?=
 =?utf-8?B?VkxBMzQyUTZreWxJaXFadHozVmtPTnpKYWcxdEVrU0UvS291R1NXTE1qQ2kr?=
 =?utf-8?B?eVcxQTRiNVVTZXBEUmVoSlhiOU8zOERMUnhoYXJ0VDAzK3ZEYm4xakp2OWF4?=
 =?utf-8?B?Y0NLeEhidDB5VDlaUEkrTmYybVlicmJndzN0YVk2RmR6b3prbm5xQ2t0cXFO?=
 =?utf-8?B?TE9YcFoxNEpHSjhuNC9iQklOOWI3YW53M2craTdYWWJrMTY1NDBUakdqT3o4?=
 =?utf-8?B?VCt3Qy8vV3hLSjRnR2NlRUtFaEhSdWR5VUNxMTNIMFN0ZHZnZFVTV3pnYjdk?=
 =?utf-8?B?WUpKamJmVTIzMVhrNFY5YndEZW1sREthcXZBQlFMMnhERndiR1FYSkZIUHox?=
 =?utf-8?B?Z2NZSjMzeHN1Qk5vVktvVGFiNkJ1eEFHQXdIOVhNR1VYRjd3QmRnQ2RqUEdP?=
 =?utf-8?B?TzVaelFJT09YUkZJSng2M3UyVTdDblY4YVBQdXByVTdzbGJMNnc2YWZ6UDVH?=
 =?utf-8?B?VHV0b2V4U2hQTWJndDlMUFFydUJGakNyVjdKSUhVSm84ZTloTDNnQlJZME84?=
 =?utf-8?B?OTU2OU1pZFA5SDBYSm1ZTU5nbi9aS0pLQ3JMOVJoaFptNDF1TkJhMWdKQTZL?=
 =?utf-8?B?REMwOGRvNXZteGs0OGl4T3VGMnBDWERraG1BV0ROc1lrN01BSVA4dXR2S1lq?=
 =?utf-8?B?aVhRcUc3U3V5TE1EKzdmVnZCWkNjd3ovTFZ4MUxUUkttM0NFOXBrR0FDRmI3?=
 =?utf-8?B?Tk9Gb2hhNDJURXFtVEFWczU3cmYvQ0lKc2Y0eE9ib0Urbm9KRlMxT04rK0d3?=
 =?utf-8?B?d3VIUWg5YW91YkR0UlZHS29Nd2hMUWNXNHhtTVFzelU0cXIxWW9mTzRzMFFh?=
 =?utf-8?B?Vmg2VUtpQmxsdWhUbjZacjRhY2N4aVpiby9uN1lsbnNIMkcra3dLcmtpSW55?=
 =?utf-8?B?cjZ3KzFxRkljTXhBRVVzdDdLRzVORWVLcGRSN0cwYlhrSFYvZzV1WFd0QWxx?=
 =?utf-8?B?cFczZDkxelZnUUwwUjI3YldFVFR0bjRoZ1hLN0RUWWlkU3VrZFdxQkE5cC9m?=
 =?utf-8?B?d09ZNjNwMFlGMWgyWkdnRGdTTFd3Q0ZCbzJ3ZUFEaTJpVFIrVFZTbWxLMU1I?=
 =?utf-8?B?NFh5MHVBa2dqd21LZ2xUMytqZ2Jwcm8rdTZRcnZ6R0V2QWhoSkxGdmNnQm1O?=
 =?utf-8?B?SDJwbzlqeEIwL0ZLNGk5cVVvckhaRTlzSDV2MDhkR3dPR1MrUVNHTGdmVGU3?=
 =?utf-8?B?K0tVNW9HQVRQUE9ETlRFNkpZZHBkUUxZVHJBSkVacHpuNmVsQlZLdkhObFVa?=
 =?utf-8?B?VS9kakV3MFprQ1ZYdHZKVCtlU2EzWUhqOFNJZ09UQ3Fsek80eUlxQTFJaHJu?=
 =?utf-8?B?MXNvYWRSWk1XQnlZYTV6QWxxL0RxVkxlVDhQUWlvZHdXWEtseTVGZC9MeEh6?=
 =?utf-8?B?SHZ3dFlJNUM4akdqQlRmc2VBNEN1RzVNbFQ2dXVmNkxvdTVseFFIcHc2U1dl?=
 =?utf-8?B?S1hUaEdMaS9GZ0xOcU1icmsxUWh6akVQemgxVzl5T3cyMC9BZDlDQ3luSElx?=
 =?utf-8?B?WmdocmdqS0JSYWVZNzhDNXZDWFRJREprV3I4dTNsUmVaZHhhMjVCVGdZdW5T?=
 =?utf-8?B?L3Q3OGdpcS9sbElnVzk2MGlWNXRhYVd6bWVOaW9pRG1tTC94ZTA1U1JSS0ky?=
 =?utf-8?B?bmh1VjY5VEV4Z01PR28ra3B1ZkowNms3cHEwckt1amJGbmtmb2lnazU5ZHFO?=
 =?utf-8?B?TjlHeFhLaitlOS91UWlJaXhkL3E0MnVJQWxtZ3d4aHo2R1VPNGZEM2IwRUdh?=
 =?utf-8?B?WGZmRnowRUhqcmNINmozRFMzSXNtRk1KdWQ0dEpwdW1zTEJVWkxVekQwckI3?=
 =?utf-8?B?RC9VL2lzL2x3SDJjc0diZWVRYmkxRlBCQ1pjSW10OXAwdnBSa1B5WGcyWWJz?=
 =?utf-8?B?cWU4UFhZYWpkclVhRllwcWZsOXpCQ2V4M2xPVnRPVXYyUUY5c0JBemd4REdn?=
 =?utf-8?Q?VKoz4TM/B1BIelDxIX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cbc142-6b1c-46e0-963d-08deed3f0a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 07:00:14.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLug+BJkDZyXagOo+pKIrdT60ZhMsJeeVy7Z/QVfZkHVpGYc1WsqX0DM/4AkHNdOeEIe3scA0OyNFPZlGI+ycw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11264

PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19wZi5j
DQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjX3Bm
LmMNCj4gPiBAQCAtNjMzLDYgKzYzMyw4IEBAIHN0YXRpYyB2b2lkIGVuZXRjX3BsX21hY19saW5r
X3VwKHN0cnVjdA0KPiBwaHlsaW5rX2NvbmZpZyAqY29uZmlnLA0KPiA+ICAJfQ0KPiA+DQo+ID4g
IAlpZiAodHhfcGF1c2UpIHsNCj4gPiArCQlzZXRfYml0KEVORVRDX1JYQkRSX0NNLCAmcHJpdi0+
ZmxhZ3MpOw0KPiA+ICsNCj4gDQo+IFtTZXZlcml0eTogQ3JpdGljYWxdDQo+IFRoaXMgaXMgYSBw
cmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCBjYW4gdGhpcyBsb2NrbGVzcyByZWFkLW1vZGlmeS13cml0
ZSBvbg0KPiB0aGUgRU5FVENfUkJNUiByZWdpc3RlciByYWNlIHdpdGggZHJpdmVyIHJlY29uZmln
dXJhdGlvbj8NCj4gDQo+IExvb2tpbmcgYXQgZW5ldGNfcGxfbWFjX2xpbmtfdXAoKSBpbiBlbmV0
Y19wZi5jLCB0aGVyZSBpcyBhbiB1bnN5bmNocm9uaXplZA0KPiByZWFkLW1vZGlmeS13cml0ZSBs
b29wIG9uIEVORVRDX1JCTVIganVzdCBiZWZvcmUgdGhpcyBmbGFnIHVwZGF0ZToNCj4gDQo+IAlm
b3IgKGlkeCA9IDA7IGlkeCA8IHByaXYtPm51bV9yeF9yaW5nczsgaWR4KyspIHsNCj4gCQlyYm1y
ID0gZW5ldGNfcnhiZHJfcmQoaHcsIGlkeCwgRU5FVENfUkJNUik7DQo+IAkJLi4uDQo+IAkJZW5l
dGNfcnhiZHJfd3IoaHcsIGlkeCwgRU5FVENfUkJNUiwgcmJtcik7DQo+IAl9DQo+IA0KPiBJZiBw
aHlsaW5rJ3MgbWFjX2xpbmtfdXAgZXhlY3V0ZXMgYXN5bmNocm9ub3VzbHkgaW4gdGhlIHBoeWxp
bmtfcmVzb2x2ZQ0KPiB3b3JrcXVldWUsIGNvdWxkIGl0IHJ1biBjb25jdXJyZW50bHkgd2l0aCBh
IHVzZXIgdHJpZ2dlcmluZyBhIGRyaXZlcg0KPiByZWNvbmZpZ3VyYXRpb24gdW5kZXIgcnRubF9s
b2NrIChsaWtlIGF0dGFjaGluZyBhbiBYRFAgcHJvZ3JhbSk/DQo+IA0KPiBJZiBzbywgZW5ldGNf
cmVjb25maWd1cmUoKSBtaWdodCBjYWxsIGVuZXRjX2Rpc2FibGVfcnhiZHIoKSwgd2hpY2ggY2xl
YXJzDQo+IHRoZSBFTkVUQ19SQk1SIHJlZ2lzdGVyIHRvIGRpc2FibGUgdGhlIHJpbmc6DQo+IA0K
PiAJLyogZGlzYWJsZSBFTiBiaXQgb24gcmluZyAqLw0KPiAJZW5ldGNfcnhiZHJfd3IoaHcsIGlk
eCwgRU5FVENfUkJNUiwgMCk7DQo+IA0KPiBJZiBtYWNfbGlua191cCgpIHJlYWRzIHRoZSBFTkVU
Q19SQk1SIHJlZ2lzdGVyIGJlZm9yZSBpdCBpcyBjbGVhcmVkIGJ5DQo+IHJlY29uZmlndXJhdGlv
biwgYW5kIHdyaXRlcyBpdCBiYWNrIGFmdGVyIGl0IGlzIGNsZWFyZWQsIGl0IHdpbGwgd3JpdGUN
Cj4gYmFjayB0aGUgc3RhbGUgRU5FVENfUkJNUl9FTiAoZW5hYmxlKSBiaXQuDQo+IA0KPiBTaW5j
ZSBlbmV0Y19yZWNvbmZpZ3VyZSgpIHByb2NlZWRzIHRvIGNhbGwgZW5ldGNfZnJlZV9yeHR4X3Jp
bmdzKCkgdG8gZnJlZQ0KPiB0aGUgRE1BIG1lbW9yeSwgcmUtZW5hYmxpbmcgdGhlIGhhcmR3YXJl
IFJYIHJpbmcgYXQgdGhpcyBtb21lbnQgd291bGQNCj4gY2F1c2UNCj4gdGhlIGhhcmR3YXJlIHRv
IERNQSBpbmNvbWluZyBuZXR3b3JrIHBhY2tldHMgaW50byBmcmVlZCBrZXJuZWwgbWVtb3J5Lg0K
PiANCj4gQWRkaXRpb25hbGx5LCBiZWNhdXNlIHRoZSBuZXcgRU5FVENfUlhCRFJfQ00gc29mdHdh
cmUgZmxhZyBpcyBzZXQgaGVyZSBhZnRlcg0KPiB0aGUgaGFyZHdhcmUgcmVhZC1tb2RpZnktd3Jp
dGUgbG9vcCwgY29uY3VycmVudCByZWFkZXJzIGxpa2UNCj4gZW5ldGNfc2V0dXBfcnhiZHIoKSBj
b3VsZCBvYnNlcnZlIGEgc3RhbGUgZmxhZyBzdGF0ZSBhbmQgcGVybWFuZW50bHkgbG9zZQ0KPiBm
bG93IGNvbnRyb2wuDQo+IA0KPiA+ICAJCS8qIFdoZW4gdGhlIHBvcnQgZmlyc3QgZW50ZXJzIGNv
bmdlc3Rpb24sIHNlbmQgYSBQQVVTRSByZXF1ZXN0DQo+ID4gIAkJICogd2l0aCB0aGUgbWF4aW11
bSBudW1iZXIgb2YgcXVhbnRhLiBXaGVuIHRoZSBwb3J0IGV4aXRzDQo+IFsgLi4uIF0NCg0KSSB3
aWxsIGltcHJvdmUgdGhpcyBwYXRjaCBzZXQgdG8gc29sdmUgdGhlIHByZS1leGlzdGluZyBpc3N1
ZS4NCg0KLS0NCnB3LWJvdDogY3INCg0K
