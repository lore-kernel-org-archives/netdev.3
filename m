Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023110.outbound.protection.outlook.com [52.101.127.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04E39C017;
	Tue, 29 Sep 2026 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665963; cv=fail; b=Jm9P3YqAmUsiWLnRyFeaG767rESYFtE7pgbw4z2i5Nl92QMeTq5juwCOSy6ZFFwfyoXNWekzRL55aXYOPEQPlhdak+Rqheod2g3xGUxv8wTwwvlP73qZmRS9EbpgPwXJZyyHmnKrd7QeSUZD5WVP+Zg089hxUU6CrZgCm9C2A1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665963; c=relaxed/simple;
	bh=d5dpJ8UwSHC1yslyatz8yB87OcDmu7LVHDKsenjCLLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmX6e1UuN00BWfK3mWjo4gYnAgqsDi8YaK5oZFgPzYuFl6UtAN+E5UK9d3Wcc6VC6MLV24EVBs6bpTs7/5TErVa4Wh2bYn4FbdT5u3KnDxtHznKTY0aN/xbG0viaZgoZ5JzAbEPyDaDNbQFp7FCCv2P+Hvs4BKwi6t63Xum0hg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=L6W6V6XS; arc=fail smtp.client-ip=52.101.127.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="L6W6V6XS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/K7PyXgUEiOsjg20Mk3id+HMJZcnjNUzcaR3ASCBQwWqIVPdzEqjP53N9focXRl/xODL+O+DAa1mGFk1o6Fg5L9YhT3U3REzlmgE9ntFKHUqPMBIUc/8XuxHkCSroDsj4VGC9B4MTIP2oBvumnnW/FT6mM1cuVHmsFFzPYgibV11SrPBT+SC7iZeEpS7QMvGNge5dFT8aK2UQAwJqLoIJCOkUDPxauw9Qsn8hqgFTsa6aMnDkXhnOI5hAKK5bVmTgodR+ZNyg3/EDT878qnbP1x06q/nz28X2a2LyrtaA/7bBtoBabCvd3AjdD/EfCm/OnonaKmneaeJiQWkvGcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5dpJ8UwSHC1yslyatz8yB87OcDmu7LVHDKsenjCLLE=;
 b=NrCzeLa8h1VTpc/IeZ6hhxu5lxlN9bH0LBw6hl1esHxcR16xg4+AIE8MZRGA03P1qoMogWeKsBOVhFRNP8W+xmJ6ndtGHKMDd/Sv8jRxK8ehpcawZUZbrO7wAecB0IU3YSAks+t0QGY5p0fLkknMwMHDEGBYa/mUiAUZJ6Y/QY8OoID107qxPMD5bnPUqKk4Q/6+Eg61jD4MbAudvrywDgLV0wPUdy8Vc/rJMoRIif0GhXplo6WAvbdZc9ERAY/CqkFcKFZ+8p+Z0kl/QHRvmCz3dG+76Pa72wKxCnIeJ8sEf3dEVRpCvFH4ZOeHQTHrRPe+gQjEtuQEKrQxabWnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5dpJ8UwSHC1yslyatz8yB87OcDmu7LVHDKsenjCLLE=;
 b=L6W6V6XSfPzSuaxUe1yGJ7SsmK7UIOUQG+6Tl7OqVx5qcfZmK5Gat6DjQETMIE9pwrXKPtM4kZYJ8o7y0Bju5bMPSB9Zb8mEH4PZav+DUwC3hx8HwnCZm79Lppd9WjYLRKJQPwP2mOw8DxfH6c3ukLDwbbe82tb+71ZR5wZXoUl9N+guTK1DIHr65CaN0e253PrUBmpIiJShBv9T717lTlQxYKSslsTDX0rDDUQ5SjeI/CEug9+GejaEyYMHPr7qABa8AytrOEAOaL3TOEXZtJlySAgNvmLBv6bbN2Ep0vHkHxwnoyNK4Lf8HIqy//IYHKluFAVf65CZFdJagXyiFg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PUZPR06MB5435.apcprd06.prod.outlook.com (2603:1096:301:ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:12:38 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 07:12:38 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIDAvNV0gbmV0OiBmdGdtYWMxMDA6IEFkZCBBU1QyNzAwIHN1?=
 =?big5?Q?pport?=
Thread-Topic: [PATCH 0/5] net: ftgmac100: Add AST2700 support
Thread-Index: AQHdTlAasj9uKBxgPkm1zHM8L1PmQbbisb8AgAJznjA=
Date: Tue, 29 Sep 2026 07:12:38 +0000
Message-ID:
 <SEYPR06MB5134D5AEAD86D3E4C97D1DB99D8C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
 <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
In-Reply-To: <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PUZPR06MB5435:EE_
x-ms-office365-filtering-correlation-id: 34bbe0b4-b0af-4617-5f8b-08df1df90b1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|56012099006|10067099003|6133799003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 UeH2C/wBhdRUqzU/xVj6uibIeXQFjc/5uYCAQYq7DlyFIl4jxJi0whc0/9cPp+xNq4cH0qM/ADPrPzRidwf22OC+p2kucDbQvLI+OyQkwuoHUvdflUnXBIeyZUN0LHjY6v688VVVAU2sWXlFSohH9CWxs49cgmR3GxzfOsGsy9LklKMNw1B5+QbkrZa4qbrGwNEGxKtWPhQegEC2l/2e0BeokBne6B9hAkKHshgKLmrdTiuEl9zQZHRq+VRhQAxVbYneJfZMewLF2ErqG4IWPvwgxeRFB3qw89QFT4Jxl7ZVXeJy+1lyN2RMsxdssPo9+882EJk1nIg3WhuZZgiYVJVu1LYgub7/xILtecYsFB2m6EFnOffTzk1BbD8beUzVl4Ip0nXD3u/pfWQeHc5S9NOTjV71mV/8G1K70Pd4+0gT1cTZqUw2OmgcBHlRBqapwlblOmdBcpNYgmd5ErzneqwQQjLwqvVfDfhmVex7sHkCKDpLTan0VRyPHEFK/j5ZppDRvNyP8kkcWRHw1SGci74uTo8Qznh7x1t0U7Q/7ZvB5gnsruhVHkmVhiiz8+AQt0D0XMar6pDH4LE2A8XjjEUloVgkEv4leoScdlthlDmzQgUDoNd7yYWLm9/Hwe2YYJqaEiBM7mpzWYECLO1YSwAL5udSNxqI5g//hKi5GdBPT+dZWupagsHXf5l4dJhOHUVgY/o6q5F7bNwkDXxP6gjVipOMSMWj+bTn6mFqi4k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099006)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?RmRjUDB0N21YdzlRZ3dOZGl0ZzRFUnN4YXpZY01DdkgyQVFrVXpLL25NSndMQ0Zk?=
 =?big5?B?WVBCQ3BXZ3JFSWppRmlVTG9tbWYyZ2dXWjA5R01FNW0zTXQ1Mm9ZWEJLY1FKWG1L?=
 =?big5?B?R3lnVFd6cUZjUm4rSklpUHB4NEFZNGwrUEZEdlc3ZnI2ZktUSUhkNUdBam0ya3VD?=
 =?big5?B?Ym8rRk5wZ2JKOC9mSW9DVEJHSDFRcUg5Vk9jVTV3d2FZSlhKcmdrWFFhbFl0TjZJ?=
 =?big5?B?R2RKM0RaS0ljS2Z1ek9hWFcybFZ5b2xXOWhlZ04ybnlRa2NoMWEyR00wRHg1VDd4?=
 =?big5?B?eGQ2REJNVDVMdEVwRWI2T2U2OVQrYzZUTW5zemFLcXRzODRGMG9vY0xiU2YrMXRt?=
 =?big5?B?SUFIbWRGZDhiaXRYNnVBZG1vTkFMcGNLKy80Z1dQRlkyY1hvVENBbXI0cmVtUDdD?=
 =?big5?B?bTA0bXBoUlVZZnpzWVNReVU3RGkzV3FhL1NSWWpUeDVsUUFmeVFkc2hjK0t4MHNL?=
 =?big5?B?dkliQnZQU2JhM1FzdHhzYnRPL3Qyc1RtTjltYVZ5bWxUYlNzV3ZwSy9TL29obURH?=
 =?big5?B?WkxJakMvQWRBR3pMRldGeklydUx2dHZxeDc0YmZQT2JSUU1ELy9lYThRSTdOM2Vy?=
 =?big5?B?ZGlYSGdpZVI4Rk1YSGJEcHhtS2twWXFOVXBRTytBVS8vNVp2dHNxM0xqV0RHdElj?=
 =?big5?B?VUdFZXBNTlR0YUNIKzc4R3l4NnRCUVZrVXNKdEtnaTBpRGpRTHdPemJ5QlIvWFBv?=
 =?big5?B?aUJRbDF3U2MzVTFJQUxQQ05oM2VORVlPZExHVFZCZjY4aGtteG9pLzc3V3QzeGh0?=
 =?big5?B?UldwQU9JdHNobjlqeFpIUlhSVHpLQnkxa1RuL2pMNFJyUkhOWWpvYTM5MXlHbnZ5?=
 =?big5?B?ajQ3dzVrRldYeFJaeER4L3JWVkViOXpSbENGZWZSeEFGUlZNbmVReHJYR0l5aTZQ?=
 =?big5?B?K3VSNEEwN2hTSzhsWEk0b1FCZi9sanFoamkyMG1NdE16OFRPZlNJanBaUUFENXNu?=
 =?big5?B?bkVIWXNGd1hNTUt3ZzUzNHBMaDU1NFZKUnZVQzM3UmxnNUo1TXc5RFRIU0Y4MC9U?=
 =?big5?B?SSt1SzMrWGlRaHZiaVhXemMxTlhTeGo4NnFCNzh3Q1VaM3FPWGNOQ0N4dnFaUS9m?=
 =?big5?B?eHRjb3UvcW1JRFkxYlA3VnRLVmhBVFBVaVZrNGpaUDlYOUxZU2crTExpK2hjYW5T?=
 =?big5?B?RHZJWlBqVWd5aTBkZXhNVTEyZWpISEFXaUVBUGswTmNVOHFLUGtZeFAzc3ZpaWFZ?=
 =?big5?B?eEYrc2gzN0Y2WlBIYXkycW1wWUFtc05FN09NM2c3TW4xcCtDMS9ObSsrczFpV3hX?=
 =?big5?B?cUFXb1BHQVJUQWpac0Fqek9XN3poc0twOUpWQjlOeDg3UVNvcXR6MzBrODJPV1lq?=
 =?big5?B?RXh4K000am40eVJWTEVSaFVWV0xNUE4zaWVMNXI2dkt5VlFtME1JWDZQZ0FBZW0w?=
 =?big5?B?WjhuRlZCY2p4TGpvWm50eEE0cmViVmF1WFJVZm1sMTJhRkdVS2dsSURpOVhWNzVm?=
 =?big5?B?NThuRFhQc1BQZ0k4d05nU1ZxblFsaFl3cWdvTDBydUNnS1V1OHBzbDZ6blk5aWJo?=
 =?big5?B?UmErTDJMcS9DeGNBdmQyajFTRWp2dW80QmMybU5aNWRzaHEwOW9kYTA5YXl5WVhK?=
 =?big5?B?Uk10cXNzU2s3aWpBUEk0c2VkYjYzeFg1bmNiMndzM1EwVXE2bzl2NUs4NzVicm84?=
 =?big5?B?R3hEWkppUkRNQ1NtTEU2Wlk4SmRyZTBrNWVYcVZrQkh1N2g4NXU1U0Zwa2JjV3pF?=
 =?big5?B?VytVSUMzaHdKRnF4QkRUd0V2NzE4S21WcU9icXRIbnFmVEk4MWNHZTNrelZkMmdj?=
 =?big5?B?ZithYnptT1JEcXpCZXlPWm85bVNtdTRieVB1d1hIN0l3dGg2TkV6YWF6RThJd3pw?=
 =?big5?B?bE1qQXlWN3h1YWtaRjRJVGF4SW1FLzVSd0t1M2FYSXF0elVhQTFaZC81S1FPNEdm?=
 =?big5?B?ZCs0dlEzMExnNlhnS1BhV2krRU43VFl2RUJIVUZKWmdMOWhMT2RqSXBtYm13SW1x?=
 =?big5?B?QWc2TXBHV2ZCdVhhdnZuUm5qVWt0T0tZWEFMU2owd3YxQWIzZmZyZkY3TnQ2Mjlw?=
 =?big5?B?NG1tNzlyYWo5WHBRN04wVm5JbXBieTN5TVBYSk1STDJTeGJncWQ3UmY3QnBDNmJK?=
 =?big5?B?cmRyQjRTRjN5Qjc1K25wYU8zS3U2UGxuRVcwbnQ1d210UmFsOWxIK2hzUklPYnkw?=
 =?big5?B?K3ZLK0dPTEw2N1lsdzRjVlg4YUxHNHVIMGpjbTdNL0dJZ1pTdGZNWllGczhOZSsx?=
 =?big5?B?WlpuMjh0R2Q0bCt6ZTJBTzVxYk1zZz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bbe0b4-b0af-4617-5f8b-08df1df90b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:12:38.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Ni4/G73uzDJzyi35FpssQapIHedZwcIMHni/uVQCI/MQr3vZjDWcDEhkBAT+LKYB4ZEV3w2h7KsNEUPWn9O/I5h2KyViZTFPmW6hISWyjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5435

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiBBU1QyNzAwIGtl
ZXBzIHVzaW5nIHRoZSBGVEdNQUMxMDAgTUFDIElQLCBidXQgdGhlIGVuYWJsZW1lbnQgaXMgbm90
DQo+ID4gbGltaXRlZCB0byBhIG5ldyBjb21wYXRpYmxlIHN0cmluZy4gVGhlIFNvQyBjYW4gYm9v
dCB3aXRoIHRoZSBNQUMgb24NCj4gPiBBUk02NCwgbmVlZHMgdGhlIEFzcGVlZC1zcGVjaWZpYyBS
TUlJIG1vZGUgYml0IHByb2dyYW1tZWQgd2hlbiBhIHBvcnQNCj4gPiBpcyB3aXJlZCBmb3IgUk1J
SSwgYW5kIHJlcXVpcmVzIHRoZSBkcml2ZXIgdG8gdXNlIHRoZSB1cHBlciBETUENCj4gPiBhZGRy
ZXNzIGZpZWxkcyBpbiB0aGUgcmluZyBiYXNlIHJlZ2lzdGVycyBhbmQgcGFja2V0IGRlc2NyaXB0
b3JzLg0KPiA+IFRob3NlIGZpZWxkcyBleHBvc2UgYSAzNS1iaXQgRE1BIGFkZHJlc3MgcmFuZ2Ug
b24gQVNUMjcwMCwgc28gdGhlDQo+ID4gZHJpdmVyIG11c3QgcmVxdWVzdCBhIG1hc2sgdGhhdCBt
YXRjaGVzIHRoZSBhZGRyZXNzIGJpdHMgdGhlIGhhcmR3YXJlIGNhbg0KPiBlbmNvZGUuDQo+ID4N
Cj4gPiBUaGUgc2VyaWVzIGZpcnN0IGRvY3VtZW50cyBhbmQgd2lyZXMgdXAgdGhlIGFzcGVlZCxh
c3QyNzAwLW1hYw0KPiA+IGNvbXBhdGlibGUuIEl0IHRoZW4gdHJlYXRzIEFTVDI3MDAgYXMgYW4g
QXNwZWVkIE1BQyBpbiB0aGUgZHJpdmVyLA0KPiA+IGVuYWJsZXMgdGhlIFJNSUkgbW9kZSBwcm9n
cmFtbWluZywgd3JpdGVzIHRoZSBBU1QyNzAwIGhpZ2gNCj4gPiBkZXNjcmlwdG9yLXJpbmcgYmFz
ZSByZWdpc3RlcnMsIGNhcnJpZXMgdGhlIFJYL1RYIGRlc2NyaXB0b3IgaGlnaA0KPiA+IGFkZHJl
c3MgYml0cywgcmVidWlsZHMgZnVsbCBETUEgYWRkcmVzc2VzIGJlZm9yZSB1bm1hcHBpbmcgYnVm
ZmVycywNCj4gPiBhbmQgcmVxdWVzdHMgYSAzNS1iaXQgRE1BIG1hc2suIFRoZSBoaWdoIHJpbmcg
YmFzZSByZWdpc3RlcnMgYXJlIG9ubHkNCj4gPiB0b3VjaGVkIGZvciBBU1QyNzAwIHNvIG9sZGVy
IEFzcGVlZCBkZXZpY2UgdHJlZSByZWdpc3RlciB3aW5kb3dzDQo+ID4gcmVtYWluIHVuY2hhbmdl
ZC4gV2l0aCB0aGF0IGluIHBsYWNlLCB0aGUgRlRHTUFDMTAwIEtjb25maWcgZW50cnkgY2FuDQo+
ID4gYmUgbWFkZSBhdmFpbGFibGUgb24gQVJNNjQgd2hpbGUga2VlcGluZyB0aGUgZXhpc3Rpbmcg
QXNwZWVkIE1ESU8NCj4gPiBkZXBlbmRlbmN5IGZvciBBU1QyNjAwIGFuZCBuZXdlciBBUkNIX0FT
UEVFRCBzeXN0ZW1zLg0KPiANCj4gVGhlcmUgaXMgbm8gbWVudGlvbiBvZiBSR01JSSBoZXJlIG9y
IFJHTUlJIGRlbGF5cy4gR2l2ZW4gdGhlIG1lc3MgdGhhdCB0aGUNCj4gQVNUMjYwMCBpcywgaSB3
b3VsZCBleHBlY3QgdG8gc2VlIHNvbWUgZXhwbGFuYXRpb24gaG93IHRoYXQgaGFzIGJlZW4gc29s
dmVkLg0KPiANCg0KQ3VycmVudGx5LCB3ZSBwcm92aWRlIG91ciBjdXN0b20gb3IgdXNlciB0byBj
b25maWd1cmUgUkdNSUkgZGVsYXkgaW4gYm9vdGxvYWRlciBzdGFnZSwNCml0IGlzIHRoZSBzYW1l
IGFzIEFTVDI2MDAgaW4gYm9vdGxvYWRlci4gU28sIHdoZW4gYm9vdGluZyB0byBrZXJuZWwsIHRo
ZSBSR01JSSBkZWxheSB3aWxsDQpiZSBrZXB0LiBUaGUgZnRnbWFjMTAwIGRyaXZlciB3aXRoIEFT
VDI2MDAgYW5kIHRoZSBuZXh0IGdlbmVyYXRpb24gQVNUMjcwMCBkb2VzIG5vdA0KbmVlZCB0byBj
b25maWd1cmUgdGhlIFJHTUlJIGRlbGF5Lg0KSSB3aWxsIGFkZCBtb3JlIGRlc2NyaXB0aW9ucyBh
Ym91dCB0aGUgUkdNSUkgZGVsYXkgY29uZmlndXJhdGlvbiBpbiB0aGlzIGZpcnN0IG1haWwgaW4g
bmV4dA0KdmVyc2lvbi4NCg0KVGhhbmtzLA0KSmFja3kNCg0K
