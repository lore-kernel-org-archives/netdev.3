Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023136.outbound.protection.outlook.com [40.107.44.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CE36A377;
	Fri,  2 Oct 2026 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920424; cv=fail; b=AltdMQYmCHk5LeSoHpf9K3wmaMaYJL1Ux7YlN1tTv5aTDWnuZM/V6Z+wiEyvDvrj8IoxamwYbVS2Sq9FBSCEzAaq6vmuNGEwbxJpUY8S1bu5Oe7ej/VxJuqV7CP/+Wa8znhaMIkS68ukDV9eJC3ldGa449nT/OyjmiAXbb6xbQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920424; c=relaxed/simple;
	bh=QyAo44k86cjy7Inn/HRyDIQ7Hwd29FoxQh/BmDKn4m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idWBo+GZI31msZOOv1huL3SPH6adORzCZPugQgdpxXhywdYbcx4Zxeh1zY7CIylHD1oQGp6dhSpy5XG/BMHFxwB8iTV7oRy7CZ1EqdOZseZfWgFwhBUGIPuZ16trzEoF63OQRZ7PJIhdAf7kPQjzaxKueLBl8mssVD+YpiW7EB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=TnRIDlu9; arc=fail smtp.client-ip=40.107.44.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="TnRIDlu9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxnLGs4HRBiOFwVlO37+NvKa4nsmffO476XOwis0kRgzsEgQWM/6Xl43lXcsZdE+7QmeMUhrGuzVVNR3YxPRWRy3yOr7M+QTnVsuveHUTTqg1KB+Ar/CWGpMalmbSEABgv9HurTcJ9IJwIBOXVQNTul6uYWHxgeIfcOGlMKwqjbENcGkBeg5PYJfUJ1dsVq+fMnSatIAbbUClfPGwcvzSF3WYtD7bZpgRGqR6fVZRNkH/WWq2ewpRmAal5f1dDi3Sxt/SkrQXplqXIfyENEwd1MIoyLVwJExrXVYdZJVTzPTyUZzz1iopf3KfTEepuF20SUPDaIlKqQ4xIFWd4W7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyAo44k86cjy7Inn/HRyDIQ7Hwd29FoxQh/BmDKn4m0=;
 b=cRgMcYfT2kedQCyej2yeY27bTEQ3gdvTjGvgGKL+A6VtapVbmqpLIShvW/hkwaklkKbQuQjch7WAV6cwnclIyW0KntIreFQJhrO5CszjYBXxcsBE1ZXRzX+eehhK2pU8foo5ezy1gL5F+f9kjC4kCphYlPkiU7kLIGFBQidwU0iSp3yKX4/d50XwZfCT8pIsC4IpA6O4WM71gka1YpEVFKhbzXprTjmWXkJpuhMQgouqCbTWPVoA5+ertBCZwarBxeNW2/z7k/hPeaiuyTodOW4YwRWX0/3mBoSK8knfdh+LYnuFY1ETGMyjShFeNy5UKsjHdAfqcbtdWTmBnf85eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyAo44k86cjy7Inn/HRyDIQ7Hwd29FoxQh/BmDKn4m0=;
 b=TnRIDlu9vLDKBBeNAWg0P42RuSl/TV/DMqJNNXdvhjoWE1B3qUaKyiL8UNSrlkRLVzaV3xm6c9Pu0WJ1XflmE9RKWcKGIc+ot38ic+MBOOBQpI7aDZbDSCFaQyHVbWc06J9Wbh3Ftu9JSCfm9D5lVy+qR1F1s3mEzaS/s1/2mhA6kweUZwNEleKFkWXvhI2HIv8THdwmYFKh18EJh+MYbAdvXFc3N7GDm8XAmg2e8Y/N/FFMk278KmVjxyiIhNB9DlcAXC5xnAlmV+dzTp8daknML0TeBT9Pm5e4eG++SPOWOM9Ijtr6ns6FTYK/hwgmsv6n7KDl7N2HIESYVdvwrw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY2PPF86E4C9764.apcprd06.prod.outlook.com (2603:1096:408::79b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Fri, 2 Oct
 2026 05:53:37 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 05:53:37 +0000
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
 =?big5?B?pl7C0Dogpl7C0Dogpl7C0DogW1BBVENIIDAvNV0gbmV0OiBmdGdtYWMxMDA6IEFk?=
 =?big5?Q?d_AST2700_support?=
Thread-Topic:
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIDAvNV0gbmV0OiBmdGdtYWMxMDA6IEFkZCBBU1Qy?=
 =?big5?Q?700_support?=
Thread-Index:
 AQHdTlAasj9uKBxgPkm1zHM8L1PmQbbisb8AgAJznjCAAKgvgIAAkPjAgAC6rYCAAqhMEA==
Date: Fri, 2 Oct 2026 05:53:37 +0000
Message-ID:
 <SEYPR06MB51346CEDA33BEB5509B657C69D892@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
 <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
 <SEYPR06MB5134D5AEAD86D3E4C97D1DB99D8C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <36d6dac0-30ab-440a-bf35-81b33ecd8e8b@lunn.ch>
 <SEYPR06MB5134FA89E6754F168E94C1B29D8B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e8a8de24-4f6d-4645-9022-36995d8fd770@lunn.ch>
In-Reply-To: <e8a8de24-4f6d-4645-9022-36995d8fd770@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY2PPF86E4C9764:EE_
x-ms-office365-filtering-correlation-id: 1c539b88-9e39-4f03-7509-08df204980f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|4143699003|56012099006|10067099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info:
 6BGsWTrfoLK4Pu0sTB0YW637NHnN02Ydod6SG9dseoKxeHM/McjjGkwjCIg3KLgRwDKWS3npQ6E6WJjnMcAbJxreG3/9aR+ckqeNu8NHxqIvz27Git/r5zTqHR6pklB1QGFgEPDiebElf/76NZ8q+1RIrczA+5DBt7HcS2Up0aEC8cTI1dv2iwJxfayhgGbf+8etp3lZYiZ9RJLNTSlrwu0YfD2RpAXxxDJl/smDz+FvOB9GExdSHIk822KzngFsS/1lvtmEz3RiBALLX+vRMzmjWXeJfaXpBxTuikW0I7upXcyQc2cPg4ieyHNwRu6/ytMHupiOkmxtgXKtvNijPGQXpaHOZ5b5bV++ZXMea8IrVyQ+kV5g8ZPJr3igkGK7IBx5WFYHMz6tm51yaCs+tKSVpeFdU3XOiUKaP9n2HAYdmtbhdzr5D9QLXJbVAHLzfzJH6xi6X9+FgVJEcCq8bbX52T8HiUcDsUpmzr5BXb/IJ6gsLSIoLuDNNGwjb0ntJPTkPRPtMDXCgyFB0UkOKinYHkGsQEG0xams7yLKaMrefpXZ/+GX7zLuXmUZevISkB4hpiAwJbb0tSk4mJ6BOYPb+Z3znGiQ+/7uHh/L6RzzBGSZBd2nCv0zG4tEKcb4nyZb4DG7Zoc4+67WqGwiQ7ziIiFHS4EZed068Lx0BQtNWFaU1g8YkyGjdkET/fR36c91rXkV2e3ieekyXJLfGCYFsTaox4D8eZDlcsl/QIg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(4143699003)(56012099006)(10067099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?YjRJUC9yTjhnMzB1bjIwYUh4U2dYWTlSOUE1Z3F0KzBER2RUQlQ1UGZscjgwN01w?=
 =?big5?B?N3VCTHVsMjRkaEh1NkRkZEQyYTUxT3FFRkhQZ1JqTm0vM1loWDlNaHhKUDZtVEtR?=
 =?big5?B?TDRHRHN0YkQyRWlvNnJhamZMMmZjdCtpM1lYNnNhZXFqQ2ZtS2xQdUNDWGhSYysx?=
 =?big5?B?OE9IczM4WTQ1TU14U2VWSElTNksrU2Y4Q0lXNExsQnBic2FzZEtSZU5MM01SZ3lL?=
 =?big5?B?b2lFUGp2Tys2bWtDMTg0aW5LeWo5L0pONTN2UVRJRmJMV1lzUjJRMVZwemo3TTBQ?=
 =?big5?B?cU5qWlQ3WWh6ckk5amd2QXVYbnYraHRISlAydGxuWTQ4TVVsdTNYRUxzMjNRZmVl?=
 =?big5?B?NWZmSE5qN3p3SUtwN2VuNDIwbUVmVWZyU2trRE9HQk93RjV5Q1JqeDAySVBpd2pQ?=
 =?big5?B?dE9yNjErL3gxS1NndUE0WXprZDl5UGNsVDI4Vm1LbWRnSDlEcUNKTGdiV3lEZ1Fw?=
 =?big5?B?V1h3a3VmcFNwcnFFaU9ZRmVYMWJqL2tQVjRVaUFMMU13dzY5anE5djNDMWFwQzZB?=
 =?big5?B?TmxOZ3lvMjhZaE1MK0dXbzFrVXl4c0ZNWVR1VXY0WUgwdXRtM05ZN1MvUTZNWDJ6?=
 =?big5?B?K2RmVzNxeGhBSnNISlVsa0ZTZFVjL05ERk9TMk53RnU2Um1IUm5ROUFoNG10V0gr?=
 =?big5?B?QXlqMCtGc0dWZmZhSkcxcHlueFExMFdPaGV5cUJkRXY4d0NWeC83eEo1RkdCRnJJ?=
 =?big5?B?Y250dWJaTWFnNmwyK2JPeEFYa2hpWDhWbE9OR0tLUWdoZ1g1YTgwektOWjl1dmNJ?=
 =?big5?B?M2Fnd2I3dXlTaU40bzFJL1YxWGwxLy83MjdqZUw0Z2hzTHMveTNWVkQ1VEZnbUVx?=
 =?big5?B?a0JzRzNzbklneUxkVGlidERQNlNYbnk3KzM1UWVYUXZIK3JZS3Z2WnpvZzZ5bWh6?=
 =?big5?B?SnpRNXoyOEZDdnNFei9uRUhkSWk1djdENlNXWDJXVmpRcnRnM3BnT3Bra1d0QTEw?=
 =?big5?B?bmlSZkFwUXZJQUVZOUFxbExVcU01bmZmRXpOcHV5dVQ5VHlsblRuM3Q4eks5c05x?=
 =?big5?B?ZXNlVzdPbWx1U0o1TXhBdzJuR3loMFAwc1lMYmIxVVBHdE40bTBweEI3cGNraE9z?=
 =?big5?B?NmZJQnlSNEJKYllwcHN0WjljWDJHeEVWTmt2Y1llbDZESDdlakRSd3F3S0xMM3BF?=
 =?big5?B?UjZGREFxYS9Pd2t4MzM2NGVSTlJMVmsyWEQrMmVLVi85R2JDeU9nNnI5UXM4SklC?=
 =?big5?B?RkIweml3TFg0anRUa05QTk1reVFZWkFBS3A4Tm4xMTg1VEN0d1FBTG5mUG96QWlv?=
 =?big5?B?TGN5ZkVDb1lQTVZFRGZxL1IvcjJveXhpc3EyWVY1Ym1UNEdiUm5MY1pvQnpiSEZp?=
 =?big5?B?b1hQcm40Y3MvQWYwTTRBN2lIU1NHQ1hSWnZIUDFBaDVQNUdMUUI4SXBaT0dWZmNh?=
 =?big5?B?VkFGd095Ymw0azZoM2k4MUNpVUdpVHQ1NU1TWlJKNUpqbHBOTzl4SXpqOHlEcnpm?=
 =?big5?B?VVlFVEV0eFo0TXJyMzJVZ3g2RWg3SCs2Skd4S2dFQ0l3Z0NwOEYyV1VXd1pwRy95?=
 =?big5?B?czVqQUZXak1uVFMxNTJaOGlWODZnclkwYVFWUHdza2tLK3lVWFl6UW80d1NTTUw3?=
 =?big5?B?Z203L0s1V1h6ZlJibXYyT2t2OFYxK2thYVdQaW1JR0tyajdtUCtBY2VVb1MwVnMr?=
 =?big5?B?aGxVMFJmS212Sm5oVXdKbEFDbFBVWk9iVDloSnFLRGtBTVNoRGxSM054TlRmTkR6?=
 =?big5?B?Z0RGWVZYdHNBcUM2UFJuS1ZzUkhWUnhOaVpoQnN1eitRcE4zMUxEYlIwb2d1L01n?=
 =?big5?B?M2h2b0hrdm40OTM2S0lvdit5ZWJjaDhWemQ4U1h0QVJ1S1dsNDI2bll6NE9aVEF4?=
 =?big5?B?WnY0YnBNbkNhTjllTVJaSFBjMk9EVTVBWkd0aG5LMU5jb0VMeXF6OXhqZElWOWZu?=
 =?big5?B?VFlJMGlLeTJ4akQ2RG81MkY4UWFuWUsrRW16ak1xWCtrK2hCVjliTlNrQ1Q5YnB3?=
 =?big5?B?ejEybW80dXUzQW1DOTVqUHExNHV0VHRMMFJ0Y0dUZUw4MFY0R0RTTU95aTFuV1VO?=
 =?big5?B?cGU4eWhENjZOMFo3bFVXRU9RKzZwTWZGVzhPTnJXQm5YYzNMRGlzbzRIRVh0NzEx?=
 =?big5?B?NmpzTkxNTXk3QjliYzczbFR5bE53N2lBbGZTWk4vYjg5aHM0K0hrenRFOVZMaEk5?=
 =?big5?B?TDJNUzBSYjFDMDdCSWVZSXBkR0xEaGc0WWVxbVhIQUlHZGU2aURwNjZxNUdRNmJO?=
 =?big5?B?ZWtVMkVSUlJPem9iNWxTMUYwWkF0Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c539b88-9e39-4f03-7509-08df204980f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 05:53:37.7161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKLS4KPgbXvd1o+5M7mUcBId4L1lletN0upYuCpMPb9s0pHVSfehZfmy212uC1Vkz2ixgsDHIH+03EB/T1HktR6CEZY8hf9PFfNMpR0bKLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF86E4C9764

PiA+ID4gRG9lcyB5b3VyIEFTVDI3MDAgYm9vdGxvYWRlciBhbHNvIGhhdmUgdGhlIGRlbGF5cyBv
ZmYgYnkgZGVmYXVsdD8NCj4gPiA+DQo+ID4NCj4gPiBZZXMuIEFsbCBvZiBNQUNzIGluIEFTVDI3
MDAgYXJlIGNvbmZpZ3VyZWQgdG8gZGlzYWJsZSBSR01JSSBkZWxheSB3aXRoDQo+ICJyZ21paS1p
ZCIuDQo+IA0KPiBzdGF0aWMgaW50IGZ0Z21hYzEwMF9taWlfcHJvYmUoc3RydWN0IG5ldF9kZXZp
Y2UgKm5ldGRldikgew0KPiAgICAgICAgIHN0cnVjdCBmdGdtYWMxMDAgKnByaXYgPSBuZXRkZXZf
cHJpdihuZXRkZXYpOw0KPiAgICAgICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0
b19wbGF0Zm9ybV9kZXZpY2UocHJpdi0+ZGV2KTsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ICAgICAgICAgc3RydWN0IHBoeV9kZXZpY2Ug
KnBoeWRldjsNCj4gICAgICAgICBwaHlfaW50ZXJmYWNlX3QgcGh5X2ludGY7DQo+ICAgICAgICAg
aW50IGVycjsNCj4gDQo+ICAgICAgICAgaWYgKCFwcml2LT5taWlfYnVzKSB7DQo+ICAgICAgICAg
ICAgICAgICBkZXZfZXJyKHByaXYtPmRldiwgIk5vIE1ESU8gYnVzIGF2YWlsYWJsZVxuIik7DQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gICAgICAgICB9DQo+IA0KPiAgICAg
ICAgIC8qIERlZmF1bHQgdG8gUkdNSUkuIEl0J3MgYSBnaWdhYml0IHBhcnQgYWZ0ZXIgYWxsICov
DQo+ICAgICAgICAgZXJyID0gb2ZfZ2V0X3BoeV9tb2RlKG5wLCAmcGh5X2ludGYpOw0KPiAgICAg
ICAgIGlmIChlcnIpDQo+ICAgICAgICAgICAgICAgICBwaHlfaW50ZiA9IFBIWV9JTlRFUkZBQ0Vf
TU9ERV9SR01JSTsNCj4gDQo+IFRoaXMgZGVmYXVsdCBpcyBub3cgaW5jb3JyZWN0IGZvciB0aGUg
MjcwMC4NCj4gDQo+IEkgd291bGQgc3VnZ2VzdCB0aGF0IGZvciB0aGUgMjcwMCB5b3UgbWFrZSBw
aHktbW9kZSBhIHJlcXVpcmVkIERUIHByb3BlcnR5LA0KPiBhbmQgZmFpbCB0aGUgcHJvYmUgaWYg
aXQgaXMgbWlzc2luZy4NCj4gDQoNCkFncmVlZC4gSSB3aWxsIGFkZCBhIGNvbmRpdGlvbiBjaGVj
ayBmb3IgcGh5X21vZGUgcHJvcGVydHksIGlmIGl0IGlzIG1pc3NpbmcsIGNvZGUNCndpbGwgcmV0
dXJuIGZhaWwgYW5kIHByaW50IG1lc3NhZ2UuDQoNClRoYW5rcywNCkphY2t5DQo=
