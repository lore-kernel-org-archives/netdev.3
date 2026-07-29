Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F13381EA4
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305816; cv=fail; b=CE7NE+dsqRdmBv2Wn4jlwMiUxQljr1vi80OZecsUJTo/SbispbsEC+BJmjXJhvc6ql/yAGxxX4kpmvf6+1rvFWckmvMMe1MTjnwtbCSQ02G/y59YuVdPWxV3yr5fDor+OtReE6rLmhgc9vw6ycVypSq0vSsYdwWwcSUmHmOq2Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305816; c=relaxed/simple;
	bh=jUolyhHTodRCRTi/Rdk9KtnQoRA09swZgB83EdcKI3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6T49JFo4Q+cXS2uyPX56HtTTSg7hFf9/FFB3FSea+Zl9C7J4cVm/9NRCmDoRgJ0zl6nSap1e56Oe1G9tSk+jhvqac/O0997bKIZsZXJb6jt9RNSFyRnsXIndpcdo7LzHb10pgX0pLSNr/fsKAlnyEI8B11M28uRg//1k2vjD2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wEYB4fVV; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wEYB4fVV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1uupcUj00FW59F8zWFyF7QqN1R3uSTKrQq/gP4s3YXIrshtkO02Mp30jM2E/m8ml61gzuBRHjGIrGdiGOOvyQjCxE0nV9gPSR+/1yQ8rR4T2Nb3w+ymydQya+Bw53UHzT+srwV8/NLAvtLL/b4R4RjSWupaUsnmwy0eGHSrvqBOER3R1GT0uJ6PCeedoKSlf632utuhoF9t383Ecel8IjSfoZfhqeJ1esrFhd4w7HzuNj1JlmPCk+dxUIiJyMr1oIitMiHrZQ+KoHeV/YrWNZ1atNGTJjNurN0Q5nRgM/Y3sdMbkG+2JKLj51J7KyAOkbMBpLbTLWj1HQkObSu6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUolyhHTodRCRTi/Rdk9KtnQoRA09swZgB83EdcKI3o=;
 b=J3+/9zf5nzBcO308zcng8CdZPEu1x1CFzWUY738V9qN467/RxlUe9TB7RLTnx66wtHmi+blSR0sWsqGSVYxxFCeDhxY2NOYletPiSD1or4PTHRFHPJZUB1tnC/nsoDfzywQkV4FYzTOvItWyhb0kNiphmOTvQD1c5QSA+v8IPGAzsehmKuIjzNj8iemWs/xKokaB7Jv6SWES4BKtxvh/3Gt/KPG3U4VQQH7srYA9P5kCybAQLg78fI2BdG8hEfjzH+vzDCzyBl+AS7t0M3/yZbJC+ERjZxhvioz33S14AMFO/O5Vl6pOhcS02/9cGyeCBmNC7355rfjYdCABdGZx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUolyhHTodRCRTi/Rdk9KtnQoRA09swZgB83EdcKI3o=;
 b=wEYB4fVVKV19hUBn369vu1+trPtjhp44xNNKC5gUF0wTzL8r6dDA2jVkcOKEV6JsMOB2u07NNoID0Lp0mXW0rmY7YALxhZ4HLbR0cQgfibREtYxHfC1FoEHZyic/hkSYfXRo4bbVYX84JFdbmz4ls8YRmm/RHU2oMRsDkIkVGzaXuB2XgJCs3riFExrWGFc7+ACa0jomHMPhrR7FhkRK1e2cra5xA9wqAs1LsSSx9jP6pDywCq8dQE4HxcIl1wYRSoQqOuyBDhOP6ChvKkjzroorMmWyuRYRthlPpacXqMGvYabBUUWcBjyncKwwAeEWGctlwW2mNRfxeiEBAMh/9w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GVXPR04MB10354.eurprd04.prod.outlook.com
 (2603:10a6:150:1e4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:16:47 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:16:47 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH net 2/2] net: enetc: restore RX ring congestion mode for
 ENETC v4
Thread-Topic: [PATCH net 2/2] net: enetc: restore RX ring congestion mode for
 ENETC v4
Thread-Index: AQHdHjjeIef0NPNok0O+O/XpTxHlvLaDx6eAgAA/j7A=
Date: Wed, 29 Jul 2026 06:16:47 +0000
Message-ID:
 <GV2PR04MB117397EC2484493DC4BB40A5488CA2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260728023217.2499420-1-wei.fang@oss.nxp.com>
 <20260728023217.2499420-3-wei.fang@oss.nxp.com>
 <20260729022916.490F91F000E9@smtp.kernel.org>
In-Reply-To: <20260729022916.490F91F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GVXPR04MB10354:EE_
x-ms-office365-filtering-correlation-id: fa65a9e8-397b-4382-4b75-08deed38f852
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info:
 7opauWMhVqojkJcrglSRS86kVW37k8Ie1F8aZIcyeW+arvFUicNLAMuOoWUX6enJeqy9ry95DnO1HzGLiE8uF/pI/rPU6IXWSsIP/ZwuVCNrNGiSpNy4xuSzc0nILObHjemJ3T0N9zJfDmSI+JlS36MgzmSX+dd+wKbT/B7pWksGAlPksSFhQVvLPeM9UrrtxgKu9Fapz5nyhgJmAAbhQ/TDr9JtCMKhVYZTgR0gzmLPDhcB4h8oBK2PLYdu2WRFt2aivTojxty0kY8bJmqDok0oCsMBukR8lMiI5nygDU6qDt3I17frvZilROe1rqXhRVCHNZCtW41ZPFeRKd4Zc/joeKaSpNzyP+G1R1z8CpOmMnaw3Wxrz3mUTWZT0y8OF8Eiq9pl+DDfDta1AS5PPGX1LJRZFa9d1Hu3wF8EmsRno2OBBaPjWzioey09+tfSI/wAtFGPIN0W7+9MKU+gqIE4J+vUCl8pBPNweqGkN7Otdi3ai6U2aRXjSoDxLSvZleQAA3bGc0JWycqqpi44YxhVHezqqvIyNP2dl1cUOm+aFS3dZSLq+DsGD1bz1iDu+Cf0NWp4vjrfRE1QKU4iiUisJ55DvqL6RHiBFEZJiFqURxdHVwWhKIhOWRRyJgulUhYJMfWZda+JdkKfJiKyl6FKtJNnJdDcMQbkEjS4BxI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDlnRTR3T1VjUXZkOGJrUjBMdFZ5RzFGTFFHUTlITlRsd1hXUHl3Q2RHUXpx?=
 =?utf-8?B?dncvWjU3WU44elNXNTR2Q0FrSFUrcHB6TWtPN09naVBCZXlUSWc3RzdyYzNG?=
 =?utf-8?B?NkUvZ0xmZkYvOEx1OUJNYUhnTlpzK1JVaGFIL3hYQlJ1MzhCWS9JM0dmbGlJ?=
 =?utf-8?B?S25ZVlVYckh1MHkrZUxtcDdhY1JrUm5lSy90M01mT255VW5lWjBpYUJnWUpN?=
 =?utf-8?B?L010R3B6WE1qcUY5b08vQWh2WlkzMDZ4SWRJeEFFMkdoTGE0MEg5K01YcnJN?=
 =?utf-8?B?aGVmaEhPb3BOR084d3RTWHRMQ2lxaEhUeUZpQko4clZBcGQ1VTR4NEpZRWtp?=
 =?utf-8?B?dW9taStqVVpDb0FPbDVzQTJHUkptdk43SFhiZHVJeWFRMGk2eW5tY3o0SFM5?=
 =?utf-8?B?YVVhbFNmQktrMmF1VW1HdUM2TS9nUis1UFVrRzR6SnZaczBVZHc4ZGpYSGQ0?=
 =?utf-8?B?K3N0UlhXTTV2RFV6Y3BKQjA0bFlneHZpM1dia3FkYnR0S2tsa0hLTWhJSWNV?=
 =?utf-8?B?R0x3aHgwd1Zsbi9VT0Z6R3JHWFRTcGQ4NEY1Yk1kRWhRTzZwTjNCMTJCRGd4?=
 =?utf-8?B?eC9iQzRLMTFFNklHVnRsMFNpM2lkbE8xeWtRektSZWYzcG1BZFJONm4zaWY3?=
 =?utf-8?B?clBtd3RFaGFxaGtYeUlDVlVZRTN4ZHdXbXFoandJS0tQWTBaS3E2TElCZUZa?=
 =?utf-8?B?MlhNTEhJanF0T3FhTUUzT1hOV21TT3V4Mmd1Y29CL0ZhQm91OG90SVFEek5i?=
 =?utf-8?B?eTFOMzMyWFh0dUw0ZUs3alVqSDJDZVljakFxdUpGWUJUalBFelRMb3owNjBt?=
 =?utf-8?B?SXpTNXdRNkhYdDc2LytvZ04zelF2aXJRS0U4WllNN2tlbStFNCtFL0kzSXAw?=
 =?utf-8?B?d2FqeU93dUliY054YmpRSklRVEJ1b01qckdtd0R0WStBQVRLZG4yclppVHc1?=
 =?utf-8?B?cTVHUk5RY1V2cm5zUW4wSnlRZ01vbEFLcUxoSnMxQ1NYc3h2a1dzcEtTNHRW?=
 =?utf-8?B?MkNWT2NqK3p4UG90eUxCV3EvUEFFeC9lVWk2VGViVDh4T3pFeXFDbllqcEZi?=
 =?utf-8?B?bTZTN2NLYzlzL1MvcW9wMjY3MzAxRWRWVm5Zd0YyYUFGd0JKWkdCV2RBQmpB?=
 =?utf-8?B?ODlweVNjZmNiZUR1M3VzTWhldW0zNkNxUWlVNHFvK2x2WmxkMnZPQm5iQzZH?=
 =?utf-8?B?MzJkWm1YSHBhNnBsL3JLMFcybFh2U29OZ2FtVWZZMkhpWDUxd3dhazIzeFdC?=
 =?utf-8?B?V3lmUkRSUUw5bmdET2pBTGUxZWQ1Sm1WOHd5SnN0dHIyK0JNQ1BLR29tM09J?=
 =?utf-8?B?c0VuTEtrdmNUSHluZ1hFUEZwbzZ5QnVTaUxvanIvQkpSZk5wdU9qYWJrQnlw?=
 =?utf-8?B?Zk44Z0FRNVAyVTFoNFR4ZEMrUnZnV2JJWWViV3Z4T2psVDdqVEVLblZRdVpt?=
 =?utf-8?B?cndZcnNmVW5jSTRER1VDbys1THNzUGVIVDIzbGxkUmFkckxnVDNEZmI5QUk4?=
 =?utf-8?B?RXNxNDRRbmN5ZVV0aXc4WHNKR3VIT3JEVUlMYTNCMEk2V0NOWEJ3SS8xeW80?=
 =?utf-8?B?UlcvVkZmTkpJeWJGaENScHhNUmJ2cW9QTktIZ0hJMHJpMDBpZDBlSFkrK3NC?=
 =?utf-8?B?V251UWlyTUpDZmF1UW9lbFZqMFI4WktwNzRFQmMwZHZsdEY3ajBJT29tNXBB?=
 =?utf-8?B?SmFaOG5NL0dSWFgrZS9Gb2hLUjE1YVVMc0NaV2V1amdVS3hoaEdjNzVoazJv?=
 =?utf-8?B?UmJ3ek1HeG0rMFV0aUxwN09pOWtYZFR2L1RjNDZpWHMwaE1QNnFVemgyU2xI?=
 =?utf-8?B?SXdOcXFUTWRoQjRyc2VjdGNoY3hMMGptejZTL3lhcDhRZ0ZoN1pPdlZBYnFP?=
 =?utf-8?B?ak0wWDFpUE8zbDMrSEZGeEpxMmRVRy9DdExEYVB6S1B4dGF3d0krLy9NaG5D?=
 =?utf-8?B?ejErQnVvWEpHZHdabms4VUVLRUluZUNIQkUyL1lINnZOaDJLbXJVaEJlUmxw?=
 =?utf-8?B?dFZ2aFBmRWw3YXVYVkYwRFBSMHRwczE2Si93RXNPVnozdStkMGFBZzZyK081?=
 =?utf-8?B?NC8zbGZpSmxlUnllRktzU3J2ZnJDRTFaZlZlRlpsaGVBZ1BlUGErbWoxQmlv?=
 =?utf-8?B?OFM3NzIvRDFHSXY4SG1sUHRpMnNORzBKdFZLcVJ6a25aVnJXbUJGL0Q1MGlk?=
 =?utf-8?B?d09Nd3gyQ20zQzluWEVURVg2Y01ibWRkQjNvNCs3QStMMXVLS0VqcWhkTit3?=
 =?utf-8?B?d2FLeFM3N1R0YTZ6WTJwYjBLNXdGZXF6UkJ1dGp1U3NsenRSbVBDazU0UjZu?=
 =?utf-8?Q?Ui4e5iFzFwKiy3sWe8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa65a9e8-397b-4382-4b75-08deed38f852
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 06:16:47.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pgk9xyqNJyOLIX9tPSLWz3i8S/6M2s77Fv+wi9gpRavgtqkmEl5w8i9rUicEPGZqO2D07eJ1htkG8GsPkYy4RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10354

PiA+ICBzdGF0aWMgdm9pZCBlbmV0YzRfc2V0X3R4X3BhdXNlKHN0cnVjdCBlbmV0Y19wZiAqcGYs
IGludCBudW1fcnhiZHIsIGJvb2wNCj4gdHhfcGF1c2UpDQo+ID4gIHsNCj4gPiArCXN0cnVjdCBl
bmV0Y19uZGV2X3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihwZi0+c2ktPm5kZXYpOw0KPiA+ICAJ
dTMyIHBhdXNlX29mZl90aHJlc2ggPSAwLCBwYXVzZV9vbl90aHJlc2ggPSAwOw0KPiA+ICAJdTMy
IGluaXRfcXVhbnRhID0gMCwgcmVmcmVzaF9xdWFudGEgPSAwOw0KPiA+ICAJc3RydWN0IGVuZXRj
X2h3ICpodyA9ICZwZi0+c2ktPmh3Ow0KPiA+IEBAIC03NjQsNiArNzY1LDggQEAgc3RhdGljIHZv
aWQgZW5ldGM0X3NldF90eF9wYXVzZShzdHJ1Y3QgZW5ldGNfcGYgKnBmLA0KPiBpbnQgbnVtX3J4
YmRyLCBib29sIHR4X3BhdXMNCj4gPiAgCWludCBpOw0KPiA+DQo+ID4gIAlmb3IgKGkgPSAwOyBp
IDwgbnVtX3J4YmRyOyBpKyspIHsNCj4gPiAgCQlvbGRfcmJtciA9IGVuZXRjX3J4YmRyX3JkKGh3
LCBpLCBFTkVUQ19SQk1SKTsNCj4gPiAgCQlyYm1yID0gdTMyX3JlcGxhY2VfYml0cyhvbGRfcmJt
ciwgdHhfcGF1c2UgPyAxIDogMCwNCj4gRU5FVENfUkJNUl9DTSk7DQo+ID4gIAkJaWYgKHJibXIg
PT0gb2xkX3JibXIpDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+DQo+ID4gIAkJZW5ldGNfcnhiZHJf
d3IoaHcsIGksIEVORVRDX1JCTVIsIHJibXIpOw0KPiA+ICAJfQ0KPiANCj4gW1NldmVyaXR5OiBD
cml0aWNhbF0NCj4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGNvdWxkIHRoaXMg
dW5wcm90ZWN0ZWQgcmVhZC1tb2RpZnktd3JpdGUNCj4gbGVhZCB0byBtZW1vcnkgY29ycnVwdGlv
biBpZiBpdCByYWNlcyB3aXRoIGVuZXRjX2Rpc2FibGVfcnhiZHIoKT8NCg0KWWVzLCB0aGlzIGlz
IGEgcG90ZW50aWFsIGlzc3VlLCBsIGNhbiBhZGQgYSBzcGlubG9jayB0byBmaXggdGhpcyBjb3Ju
ZXIgaXNzdWUsDQpidXQgSSdtIG5vdCBzdXJlIGlmIGl0IGlzIHdvcnRoIGRvaW5nIHRoaXMsIGJl
Y2F1c2UgdGhlIGJlbmVmaXRzIGFyZSBtaW5pbWFsLg0KDQo+IA0KPiBJZiBwaHlsaW5rX3Jlc29s
dmUoKSBleGVjdXRlcyBlbmV0YzRfc2V0X3R4X3BhdXNlKCkgY29uY3VycmVudGx5IHdpdGgNCj4g
ZW5ldGNfcmVjb25maWd1cmUoKSwgdGhpcyBsb29wIGNhbiByZWFkIEVORVRDX1JCTVIgYmVmb3Jl
IHRoZSByaW5nIGlzDQo+IHRvcm4gZG93bi4NCj4gDQo+IElmIGl0IHdyaXRlcyB0aGUgbW9kaWZp
ZWQgdmFsdWUgYmFjayBhZnRlciBlbmV0Y19kaXNhYmxlX3J4YmRyKCkNCj4gY2xlYXJzIHRoZSBl
bmFibGUgYml0LCBpdCB3b3VsZCBpbmFkdmVydGVudGx5IHJlLWVuYWJsZSB0aGUgUlggcmluZyBp
bg0KPiBoYXJkd2FyZToNCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0
Yy9lbmV0Yy5jOmVuZXRjX2Rpc2FibGVfcnhiZHIoKSB7DQo+ICAgICAuLi4NCj4gICAgIC8qIGRp
c2FibGUgRU4gYml0IG9uIHJpbmcgKi8NCj4gICAgIGVuZXRjX3J4YmRyX3dyKGh3LCBpZHgsIEVO
RVRDX1JCTVIsIDApOw0KPiAgICAgLi4uDQo+IH0NCj4gDQo+IEJlY2F1c2UgdGhlIHNvZnR3YXJl
IGZyZWVzIHRoZSBhc3NvY2lhdGVkIERNQSBidWZmZXJzIGR1cmluZyB0ZWFyZG93biwgdGhlDQo+
IGhhcmR3YXJlIHdvdWxkIHRoZW4gRE1BIGluY29taW5nIHBhY2tldHMgZGlyZWN0bHkgaW50byBm
cmVlZCBtZW1vcnkuDQo+IA0KPiA+DQo+ID4gIAlpZiAodHhfcGF1c2UpIHsNCj4gPiArCQlzZXRf
Yml0KEVORVRDX1JYQkRSX0NNLCAmcHJpdi0+ZmxhZ3MpOw0KPiA+ICsNCj4gDQo+IFtTZXZlcml0
eTogSGlnaF0NCj4gQ2FuIHRoaXMgcmVzdWx0IGluIHRoZSBzb2Z0d2FyZSBzdGF0ZSBhbmQgaGFy
ZHdhcmUgcmVnaXN0ZXIgYmVjb21pbmcNCj4gZGVzeW5jaHJvbml6ZWQ/DQo+IA0KPiBTaW5jZSBF
TkVUQ19SWEJEUl9DTSBpcyBzZXQgYWZ0ZXIgdGhlIGhhcmR3YXJlIHJlZ2lzdGVycyBhcmUgdXBk
YXRlZCBpbiB0aGUNCj4gbG9vcCBhYm92ZSwgdGhlcmUgYXBwZWFycyB0byBiZSBhIHJhY2Ugd2lu
ZG93LiBJZiBlbmV0Y19zZXR1cF9yeGJkcigpIGlzDQo+IGNhbGxlZCBieSBhIGNvbmN1cnJlbnQg
ZW5ldGNfcmVjb25maWd1cmUoKSBkdXJpbmcgdGhpcyB3aW5kb3csIGl0IHdvdWxkDQo+IHNlZSB0
aGUgdW5zZXQgZmxhZzoNCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0
Yy9lbmV0Yy5jOmVuZXRjX3NldHVwX3J4YmRyKCkgew0KPiAgICAgLi4uDQo+ICAgICBpZiAodGVz
dF9iaXQoRU5FVENfUlhCRFJfQ00sICZwcml2LT5mbGFncykpDQo+ICAgICAgICAgcmJtciB8PSBF
TkVUQ19SQk1SX0NNOw0KPiAgICAgLi4uDQo+IH0NCj4gDQo+IFRoaXMgd291bGQgb3ZlcndyaXRl
IHRoZSBoYXJkd2FyZSByZWdpc3RlciB3aXRob3V0IHRoZSBDTSBiaXQuIFRoZW4gdGhpcw0KPiB0
aHJlYWQgc2V0cyB0aGUgc29mdHdhcmUgZmxhZywgbGVhdmluZyBmbG93IGNvbnRyb2wgZGlzYWJs
ZWQgaW4gaGFyZHdhcmUNCj4gd2hlbiB0aGUgc29mdHdhcmUgc3RhdGUgZXhwZWN0cyBpdCB0byBi
ZSBlbmFibGVkLg0KPiANCj4gPiAgCQkvKiBXaGVuIHRoZSBwb3J0IGZpcnN0IGVudGVycyBjb25n
ZXN0aW9uLCBzZW5kIGEgUEFVU0UgcmVxdWVzdA0KPiA+ICAJCSAqIHdpdGggdGhlIG1heGltdW0g
bnVtYmVyIG9mIHF1YW50YS4gV2hlbiB0aGUgcG9ydCBleGl0cw0KPiANCj4gWyAuLi4gXQ0KPiAN
Cj4gPiBAQCAtOTQ5LDcgKzk1NCwxMCBAQCBzdGF0aWMgdm9pZCBlbmV0YzRfcGxfbWFjX2xpbmtf
ZG93bihzdHJ1Y3QNCj4gcGh5bGlua19jb25maWcgKmNvbmZpZywNCj4gPiAgCQkJCSAgICBwaHlf
aW50ZXJmYWNlX3QgaW50ZXJmYWNlKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZW5ldGNfcGYgKnBm
ID0gcGh5bGlua190b19lbmV0Y19wZihjb25maWcpOw0KPiA+ICsJc3RydWN0IGVuZXRjX25kZXZf
cHJpdiAqcHJpdjsNCj4gPg0KPiA+ICsJcHJpdiA9IG5ldGRldl9wcml2KHBmLT5zaS0+bmRldik7
DQo+ID4gKwljbGVhcl9iaXQoRU5FVENfUlhCRFJfQ00sICZwcml2LT5mbGFncyk7DQo+ID4gIAll
bmV0YzRfbWFjX3J4X2dyYWNlZnVsX3N0b3AocGYpOw0KPiA+ICAJZW5ldGM0X21hY190eF9ncmFj
ZWZ1bF9zdG9wKHBmKTsNCj4gPiAgfQ0KPiANCj4gLS0NCj4gU2FzaGlrbyBBSQ0KPiByZXZpZXcg
wrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNzI4MDIzMjE3LjI0OTk0MjAt
MS13ZWkuZmFuZw0KPiBAb3NzLm54cC5jb20/cGFydD0yDQo=
