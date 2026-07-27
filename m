Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F215E5DC
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127616; cv=fail; b=EeNQ3nIEoBl/U2oNw++CIHZqAoBK4bZyh4Dd/drP7PuURuIbZmFDWtR150ljbzBFKr21y//yXFORa2+rhZ80aNN12IcNmXi+S1ilYkhonjaRIZm86VltxO+sDhQ4ieZTIx4DPf5ndr1Trm1Xh3Rz96Cq0QTT1OyONW8ruqI8kos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127616; c=relaxed/simple;
	bh=poVaPehiC+aW/QtwFgMj1RUNevFVvRdmZxVdYcMW5w0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ar9Lj5uSwmdWLhrYysyOpFH4B37HJXTqajbKu6POoctI7PxWTjhMq4nFcuuBpW2yZTJFp2op4HYjkUuOAkfNeZ/tJfXYg3jO9sHcNZJl4/fUWVOz4obuD2pzpA9kl7yDOF6TjBMeT5FeRF6IBiaB57k9UhKH7O1QQSXmBtmI8ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J0stoObw; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J0stoObw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoZbpSCqxYFmgWTXMZchtnBX/VO42zp6CZMnRo9qHnRi09b7aXlvDyCYYpr5HNURCjGGd5oS/Caf/SYmFzuS75aMMkOIT8CRIaovzxrDxjoQfPdbTVrjsPLnDE9zZH6oacaECgushu+HYLnXR1xCJzRYTJfaUXBAmL8BOudd13C5xv1byWKoA3BpwymCsEUBzgkHTQwZdtuu8y/gDC8HHFi/u7//BghyxmobOhugY8ebzDwS9JSRs4geC6lb+jEZuzcLPR4+mK8cytqB5J7EixkO7RVa5gZ1eQg0CEKSPIVlVealGNVLBr+u3q11A1n5SerA/RT0UVzf1qY/5qlZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poVaPehiC+aW/QtwFgMj1RUNevFVvRdmZxVdYcMW5w0=;
 b=LJjZrQWh1n6Rpq0OEY7NpPnwHOLSMAQug0GONcRJExQmU8Wvgp8lGSonZej5BHtASmaxqunp/1+G7Q27warBjafiXXv8rnTgBZFpNo9drbnsGu6VS+Qx56ILKOsWE4t9TkR39flkIPNVYECBV8hP37xLmQIsVfi9xJ9OfNQXB5RSzVN/wnqzrVufWOraf4laMgRFIVYW6POwg6SdB+77cZN/06qavaA0nruJX+y4mm0jbKC0pE/BB1N9J70iHzsfdBGFiWX3/ybdP6G7tHesz8FHdK+XnlPCaxSZTKPyA9l5htTFo39uhSGR6cbqBLDG2qLrLQivLV2zMw4UFJ0nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poVaPehiC+aW/QtwFgMj1RUNevFVvRdmZxVdYcMW5w0=;
 b=J0stoObwcBjrlp8TP++C0JXNjJvqXnwWYdntQASa/uXFFTt7bZoHnrxCN4AuWkTJts2SxS2RbG16zX5H1Vgy1CFa2IoDu27J4z8/KKFuzYTENZ3TiAEuyDBzE3AYdKjev07ae83yeipGM8X4cPbRPlhMSN3F27QFWl0LlYQra6YbkOYTRRfL/OWwuZ63r5W0fDoWyFYoohEp/M2CukAk+ho7Ff4QDMoTa/i0SNC5OexrVnJam65FiNaEODeHmIOXtBjIU8zjzRp1dlc9MTpt5PV0YUFa8RSCrlvWk5UFdQCFPKcyDM6erTxkdRCKFOWqKrMeEvJprewRLvml3U9KDA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GV1PR04MB10077.eurprd04.prod.outlook.com
 (2603:10a6:150:1a5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 04:46:49 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 04:46:48 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH net] ptp: netc: fix potential interrupt storm caused by
 incorrect unbind order
Thread-Topic: [PATCH net] ptp: netc: fix potential interrupt storm caused by
 incorrect unbind order
Thread-Index: AQHdGzhTnxVBlxgFh06/H/5OlNpgMLZ9zI0AgAMC3XA=
Date: Mon, 27 Jul 2026 04:46:48 +0000
Message-ID:
 <GV2PR04MB11739D22B9ABBFA122A56BBAE88CC2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260724065116.521893-1-wei.fang@oss.nxp.com>
 <20260725064745.3890F1F000E9@smtp.kernel.org>
In-Reply-To: <20260725064745.3890F1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GV1PR04MB10077:EE_
x-ms-office365-filtering-correlation-id: 47d1b3cc-6494-4d8c-3362-08deeb9a11cb
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|56012099006|11063799006|4143699003|5023799004|10067099003|6133799003|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 tHaME+LFd6tkNPOBr6N8TmwUy8zQ/QciK9KCPMWAJv1m1QpEzgVnRFA+oUZ7fTMG/we2GFad/7RyR33lrV7GsP9yz7GNT0Dnw/sBBGOKPWmyFIM3+05gp6mUbEFvidjxUlmieQiq8obldOM8dky3+E2LdxgOmbx8KHRt1iTABgpli3hKH4izg5sXzMWSoagibWcJKieQJrXAvfUx0ihIKQ1SLQpSRP8lw5RWPN/UAIfbSL3AGjaAynDTIEhA3XQnydna22vQBYog+DMYN3pY4luX6ErRD/50ZT8x3zo5upcPz4RfrSPHTbovDplZ0MjqyCqQCTLrDajVCzIgeABa3fwJUGKTJQoeAe/bnh5cM6B9E+0dDILAk8VMoIrjF/omuyVUTa5juULEmtVw9+UvFTu7nL+DTVMwzhAB8RAc7QK93HqsNrdrGaifC+dEVsEMlECOyuJEyLg/PKo2w39ft20O7H6fsDmOtV87pTdr6PLHc84UoSF+r/5GZLDIBisWDakkUzCpoYGYyPLzsEFRYQ62T/WlO29T/sq4eClhi68gRPRBm7MjyA9AT+xS4khciA2qlksjOGUy+u/xbaa7Yr4QIGjWwvGIbnriQOv34WxfnlTLUBkhQyoi8/0ynk3shQ0aUQPSeYKyYgFiJsO3Hb7HV9F9JcoMB/iDlrLDIiw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHZ1TytPRlRVMjYzMUpKL3lTNmYyQUVQOWdRSU5jdXp0YnczKzdqR3lZeXVG?=
 =?utf-8?B?Y1BWRTJhMEh2S2Q5eVRXMzE4WEpTTWJqSmtLMTVkbGU0VUJ3czhmUFo1dUFo?=
 =?utf-8?B?RU5EYjRsQnhOOFp5a2pEK09xMmtyMGdnNHZNZnF4VjNYaE9qbnhHU0pZZUJ3?=
 =?utf-8?B?VkFEY3dCVWVOQ2lIY2wwZ01oREVCcDJYcmlkQ1QzUnhjcllOT0pMK3o3enYy?=
 =?utf-8?B?ZEwwekRwSXhCT2ZFVGFtQ1c3MVFsRmpSRGxSeTl4L2l2dlNaVXlydkVxeURC?=
 =?utf-8?B?V1JneTBKTXpTbDUyQUdOdWdyQ1ZtTHBSTElsT2tUNll0dFBra1V6c1BYZ3N3?=
 =?utf-8?B?R2VhWGw5RHNNajVBN3F3RDIrKzlYWEhLZTNOeWRtUFZWYVlQU0xQSUUydjZH?=
 =?utf-8?B?NzNTNXgxWENaMWNMR3JzcWVXSStCb21xdkJDUk5EUEJpRTVJSE83bUNpdkh3?=
 =?utf-8?B?S1RIRjdIanF6dytuQnFIZWQvMzN6ODBnV0xKRnNpbXk2YmJ3N0NhQUlSb1Zz?=
 =?utf-8?B?R2xVS215VTlNNXFQVHhxbGpzUGhMUjVVVHJabG9FWWtaMWNrSG1PMXJ5S0Q4?=
 =?utf-8?B?RjhoTTlQRUJpUEhCeExHOXZwVzVydDRqMGcyUitJRVMyd0s3Q2NUVThPQXNL?=
 =?utf-8?B?akN5N0tuNXlCTFNqMDRlRko2b1dPY1RDTWR1RzhuSCtlckRjbEMrdXJveWVE?=
 =?utf-8?B?VnQwcGk0aDJ0Yk1sV3RJaVJ3bThDYnhZMGJJWW56RTlkdFBMQWJ0M0tFZlRx?=
 =?utf-8?B?OWpoLzdKWWcvNzd0YUdLaU1rTmFMa3ZBbEtFUE4rdmpGVVY4VVVZNmpERUFz?=
 =?utf-8?B?aDkrN0xlNkUrdTNwK243M1pUa2FSYmRFalhjc3h0dGQyWXVoNWx4d0I1UWZ6?=
 =?utf-8?B?K0hCU3Z1cGNjTEg3aVJSYXEwK2hUQnpzTGtqRmc1OEs2NUFNR0IvMTlFdm9z?=
 =?utf-8?B?MEdTRWpBb21Dcm1Ra0RISXZ1Mk1QYUpzZDVacUxqMnh0OVhNa1gyWlpJRUJH?=
 =?utf-8?B?U2dwY1BRd2s0bmt4NDZJYXo0OE1jRGJTdUtGL1ZndENFV2txTzd1MlpzNW5o?=
 =?utf-8?B?NTlLdlc2eGxhdEphdDA4WWFhdXZoUDg2ckMzeGhDbWZJRks3b3d1SkhGaDJB?=
 =?utf-8?B?NGpKT1ZLeVFncG0wYWFlZ3hmVnBTNUNBVWpiaDNZM1JrcGpJNGhOQi82Q3Fy?=
 =?utf-8?B?eDlib3lUUllwM1FPOWVhQ1lwMDRPWkVibVFXR0VPNVVOYXVnVmJjb2E0RGFP?=
 =?utf-8?B?YTNCVllsbUNMaXR2VUJVSExseTFqeHVMazFnVER6elIrN01ZcDA5cWN5d3hU?=
 =?utf-8?B?dExPTzY2NXJRdFJWRlE1THZFKzVpZlJtYjQ1Um9tUFdQaXVFcDh1aTBFWDh6?=
 =?utf-8?B?Q1M0Z1pTUHRXZWczYVlCYlZZbWZ4MFU1a1RORVVjcCtJbWNHUHRDSG1vMEFG?=
 =?utf-8?B?WmYrNVN2RjMwanB5emFkUzZpV3lDNkhKU2RjeEhMSHNNdVZwMzVmclY5ajRl?=
 =?utf-8?B?VTVDYTNXOUd4ZHA0WW4rcGJGWWpOYmxaSGRzUHlDcjF0SFA1MGlFcmlCVWZZ?=
 =?utf-8?B?ODJrMk92R3k3QWcrNndHRmovbXFoclZCZFkyc0xwTmxPZW8xUGtpTC9vMzVy?=
 =?utf-8?B?Z25XcG8rTlhpTFBLeWhua1g5WlRSNVh1Umwxb2lIcGlQZDQxZWtEcWdVaUNk?=
 =?utf-8?B?OU1Nemtyb1NxZ0o3dnZsaE9sL2ZiSTYxSkhoUXVKdVF5MktTY2VPSGFsSmJz?=
 =?utf-8?B?R0NsczllWkZ4b0lvMmRSUStSUlZrbE42VVk2eEUyWjIyUE0vdEtpbXpaZzFm?=
 =?utf-8?B?eVlwTXBGWFhydmQwcVQ4Y2RucUlzSjZqR1dkdUhHODJIbWxFTXZ0Z2JFN2dL?=
 =?utf-8?B?QlhIcGdFcnRjVTVwdW04RUFTbzVtUnllR1laR3llM3FJcHNTY2pNWTE0RHQr?=
 =?utf-8?B?a1VicndmSWlzcmY1OUE1NnovMk85dkhIbmZrQkFEL2dmWW5zZ2t0WVdLdWxS?=
 =?utf-8?B?cFpHN05LRWc4bU1KLzJBWkFJMzhET2VXNFY3UEpFYlRWUDBTcW9XVUo1QTAw?=
 =?utf-8?B?R0RVaDF5YU1GNm55WnBTN21CQklIenBTejZwNithRVZNSFErU1ZQK1dzSEFy?=
 =?utf-8?B?dTVCaGlmTVlZMDlpbXhiaTJRS2hTN2tzMHd5R25HVTRVdmcyaGZ4TkdFMDBX?=
 =?utf-8?B?OXVRUkkxTUg2ZEdIU1U4NDFOd3MwSWZyZlNyTGY1TGRpdDJnWFprdmxtcW9k?=
 =?utf-8?B?dDNiaEVORS9DTHhMa2xGakovUzJRbWdpQ2FETHpod1ErbGlTa1JEZkM5QTNy?=
 =?utf-8?Q?4AvfsVI3brHsD068rO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d1b3cc-6494-4d8c-3362-08deeb9a11cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 04:46:48.8625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y35mfs8iApEPw+kKr1rYk+p8/tNFktxqxeCrrVt0Qn5NHuMrKRs1BuXrNSOoGxoz7WX/YAIU6e0YK8ghQCR/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10077

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B0cC9wdHBfbmV0Yy5jIGIvZHJpdmVycy9wdHAvcHRw
X25ldGMuYw0KPiA+IGluZGV4IDVlMzgxYzM1NGQ3NDYuLjNiYWI4NmFmZThlMjMgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wdHAvcHRwX25ldGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcHRwL3B0
cF9uZXRjLmMNCj4gPiBAQCAtMTAxOSw5ICsxMDE5LDkgQEAgc3RhdGljIHZvaWQgbmV0Y190aW1l
cl9yZW1vdmUoc3RydWN0IHBjaV9kZXYNCj4gKnBkZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBu
ZXRjX3RpbWVyICpwcml2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+DQo+ID4gKwlwdHBf
Y2xvY2tfdW5yZWdpc3Rlcihwcml2LT5jbG9jayk7DQo+ID4gKwluZXRjX3RpbWVyX3dyKHByaXYs
IE5FVENfVE1SX1RFTUFTSywgMCk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgbW92
aW5nIHB0cF9jbG9ja191bnJlZ2lzdGVyKCkgYmVmb3JlIG1hc2tpbmcgaGFyZHdhcmUgaW50ZXJy
dXB0cw0KPiBpbnRyb2R1Y2UgYSB1c2UtYWZ0ZXItZnJlZSByZWdyZXNzaW9uIGluIHRoZSBpbnRl
cnJ1cHQgaGFuZGxlcj8NCg0KVGhhdCBpcyBpbmRlZWQgYSBwcm9ibGVtLCBJIHdpbGwgZml4IGl0
IGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gSWYgRVhUVFMgZXZlbnRzIGFyZSBjb25maWd1cmVk
LCBwdHBfY2xvY2tfdW5yZWdpc3RlcigpIGRyb3BzIHRoZSBmaW5hbA0KPiBkZXZpY2UgcmVmZXJl
bmNlIGFuZCBmcmVlcyBwcml2LT5jbG9jayBpZiBubyBmaWxlIGRlc2NyaXB0b3JzIGFyZSBvcGVu
Lg0KPiANCj4gQmVjYXVzZSB0aGUgaGFyZHdhcmUgaW50ZXJydXB0IG1hc2sgKE5FVENfVE1SX1RF
TUFTSykgaXMgbm90IGNsZWFyZWQgdW50aWwNCj4gdGhlIG5leHQgaW5zdHJ1Y3Rpb24sIGFuZCBm
cmVlX2lycSgpIGhhcyBub3QgeWV0IGJlZW4gY2FsbGVkLCB0aGUgaGFyZHdhcmUNCj4gY2FuIHN0
aWxsIGZpcmUgYW4gRVhUVFMgaW50ZXJydXB0Lg0KPiANCj4gSWYgdGhpcyBvY2N1cnMsIHRoZSBJ
U1IgbmV0Y190aW1lcl9pc3IoKSBwcm9jZXNzZXMgdGhlIGV2ZW50IGFuZA0KPiB1bmNvbmRpdGlv
bmFsbHkgZGVyZWZlcmVuY2VzIHRoZSBmcmVlZCBjbG9jayBvYmplY3Q6DQo+IA0KPiBuZXRjX3Rp
bWVyX2lzcigpIC0+IG5ldGNfdGltZXJfaGFuZGxlX2V0dHNfZXZlbnQoKSB7DQo+ICAgICAuLi4N
Cj4gICAgIHB0cF9jbG9ja19ldmVudChwcml2LT5jbG9jaywgJmV2ZW50KTsNCj4gICAgIC4uLg0K
PiB9DQo+IA0KPiA+ICAJbmV0Y190aW1lcl93cihwcml2LCBORVRDX1RNUl9DVFJMLCAwKTsNCj4g
PiAtCXB0cF9jbG9ja191bnJlZ2lzdGVyKHByaXYtPmNsb2NrKTsNCj4gPiAgCW5ldGNfdGltZXJf
ZnJlZV9tc2l4X2lycShwcml2KTsNCj4gPiAgCW5ldGNfdGltZXJfcGNpX3JlbW92ZShwZGV2KTsN
Cj4gPiAgfQ0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzbid0IGEgYnVnIGludHJv
ZHVjZWQgYnkgdGhpcyBwYXRjaCwgYnV0IGNhbiB0aGUgZHJpdmVyIGVuY291bnRlciBhDQo+IGhh
cmQgbG9ja3VwIGR1cmluZyBwcm9iZSBvbiBrZXhlYyBvciBhbiB1bmNsZWFuIHNodXRkb3duPw0K
PiANCj4gQmVjYXVzZSB0aGUgTkVUQyB0aW1lciBkb2VzIG5vdCBzdXBwb3J0IFBDSWUgRkxSLCBo
YXJkd2FyZSByZWdpc3RlcnMNCj4gcmV0YWluIHRoZWlyIHN0YXRlLiBJbiBuZXRjX3RpbWVyX3By
b2JlKCksIHRoZSBkcml2ZXIgcmVxdWVzdHMgdGhlIElSUSB2aWENCj4gbmV0Y190aW1lcl9pbml0
X21zaXhfaXJxKCkgYmVmb3JlIHJlc2V0dGluZyB0aGUgaGFyZHdhcmUgc3RhdGUuDQo+IA0KPiBJ
ZiB0aGUgaGFyZHdhcmUgaGFzIGEgcGVuZGluZyBpbnRlcnJ1cHQsIGl0IGZpcmVzIGltbWVkaWF0
ZWx5IHVwb24NCj4gcmVxdWVzdF9pcnEoKS4gQXQgdGhpcyBwb2ludCwgcHJpdi0+dG1yX2VtYXNr
IGlzIDAuDQo+IA0KPiBUaGUgSVNSIG5ldGNfdGltZXJfaXNyKCkgbWFza3MgdGhlIGhhcmR3YXJl
IHN0YXR1cyB3aXRoIHByaXYtPnRtcl9lbWFzaw0KPiBhbmQgd3JpdGVzIDAgYmFjayB0byB0aGUg
V3JpdGUtMS10by1DbGVhciAoVzFDKSByZWdpc3RlciwgZmFpbGluZyB0byBjbGVhcg0KPiB0aGUg
cGVuZGluZyBoYXJkd2FyZSBpbnRlcnJ1cHQ6DQo+IA0KPiBuZXRjX3RpbWVyX2lzcigpIHsNCj4g
ICAgIC4uLg0KPiAgICAgdG1yX2V2ZW50ID0gbmV0Y190aW1lcl9yZChwcml2LCBORVRDX1RNUl9U
RVZFTlQpOw0KPiAgICAgdG1yX2V2ZW50ICY9IHByaXYtPnRtcl9lbWFzazsNCj4gICAgIC8qIENs
ZWFyIGludGVycnVwdHMgc3RhdHVzICovDQo+ICAgICBuZXRjX3RpbWVyX3dyKHByaXYsIE5FVENf
VE1SX1RFVkVOVCwgdG1yX2V2ZW50KTsNCj4gICAgIC4uLg0KPiB9DQo+IA0KPiBUaGUgSVNSIHRo
ZW4gZGVmZWF0cyB0aGUga2VybmVsJ3Mgc3B1cmlvdXMgaW50ZXJydXB0IGRldGVjdGlvbiBieQ0K
PiB1bmNvbmRpdGlvbmFsbHkgcmV0dXJuaW5nIElSUV9IQU5ETEVELCBjYXVzaW5nIHRoZSBpbnRl
cnJ1cHQgY29udHJvbGxlciB0bw0KPiByZS1pbnZva2UgdGhlIElTUiBpbiBhbiBpbmZpbml0ZSBs
b29wOg0KPiANCj4gbmV0Y190aW1lcl9pc3IoKSB7DQo+ICAgICAuLi4NCj4gICAgIHJldHVybiBJ
UlFfSEFORExFRDsNCj4gfQ0KPiANCj4gLS0NCj4gU2FzaGlrbyBBSQ0KPiByZXZpZXcgwrcgaHR0
cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNzI0MDY1MTE2LjUyMTg5My0xLXdlaS5m
YW5nQA0KPiBvc3MubnhwLmNvbT9wYXJ0PTENCg==
