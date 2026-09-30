Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023137.outbound.protection.outlook.com [52.101.127.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5F327C08;
	Wed, 30 Sep 2026 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733226; cv=fail; b=qMhvJdv1Uo7wK+Uy8tqKFT4C79vb8oJUedXn0+8a63h3quPd301sKgRiIJMrmv7OsFnQ3sQipGscKyjPTTKump9Ub1z+RF+Jkv/2r1a7wpF+z5CGvsQZ/+Oq3D8XXLaERamB2MM9Kwm0EhVDXtskxAhHyq2Dvo476Ah7PRntKEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733226; c=relaxed/simple;
	bh=//SjXxX48pcB6VW0fvJEGD2RmKW25yfbK3oE04pDVEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eSJh+B6pDLD98+URIVQSrQqNQbP78MXvhHSdRNRMYOYxaZYa6spjzJro1nn6qlSJ7KM+/gh0wFiwfwNoSVfg1UyBTPAqGe+iDttB+0M+KwnQtcUJEyEAuE4VYrAD78r7s1CuYqJi8HtKzXcfl533iNIKYGxBcd4z4RsEkSWfCHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=MeStLVgX; arc=fail smtp.client-ip=52.101.127.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="MeStLVgX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjhT+vu6LbvrHysp3dGa/+COX5b/tgiY9IETN4Nv93+qszAPaUBkQdyd0w3MCntWnYnXJp7kjfogOiumgM8NOYsGbminOf/I2XoeXNKNZF0xK3leZw3LiMD5G7oL0QvN/7QkGhATS4Xga8RGdY9WG5Oct53NSMi4Xwc0dyH5KvUKVILqYw8ebK/x7lkJ4aMWpl/rF86Uely/DRpLdocwco3f/zKkNmFqV5iN9wSZBdoj6UWuogSQAI02GxF+1LGewRvFX2DudG9yTo4SVOuJJq+12ZZ8g0hOCZyjMBWK88mtMzBxZBULLtMiwUXAE9ujqE2m2eJ/YgWWCy74QDxhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//SjXxX48pcB6VW0fvJEGD2RmKW25yfbK3oE04pDVEE=;
 b=W8N3D5WRCo3wPkZ0OWnErbdkeFgq/pcH9HxY165pUDNDAVGUVyCvQJOHBEqCut9nIgxCpcW/LAE52Ihs+BqZv3Ge4WiwTz6AjnLZcTqK9zssHthEgvJZGXoO7wwjVfzcWYAxI32WdaTQKdoATifcuAlu/WZzVLx6GpKSdUVa8MBdP9D9U4eAruyp72EOFlOFBu9Q5iEg4EZmKk96UL0UZE6X7eDb1F9WWvuozdPodfWsihi0pADQdLhVsYiY3PC0+eDtqx2aXcFTdyVmh7E10HvU9/BPUs+pW6HorY/HBrq6GkPAMoJtpQRDZwhEvKmbVutWLSnbLwWc41/qWKgRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//SjXxX48pcB6VW0fvJEGD2RmKW25yfbK3oE04pDVEE=;
 b=MeStLVgXuhQvlIqXfaQnl4NwnJwxnZl9LaU17o4uogMeNl+mfe+hr7CJIMvdhqN7Rt8rhGFGWP6TsBbD2bZ+I+aRqbmmRhwSf64m2hrI8doj4GsQ7PkwNu/h+9jz5nwqIsyiRWV8kXqqIsoDhhiDsg7A8jqI4L0EvNr2eTD0fb3PThfz4gOoRRmzN+S7Xfuj/MZ6uQXchdOdIDqDmLPj0tEKRYW3jYGQ/wbUuGOh57QklU97m00FDop6cvvecxa5zX4gr3Qtn3nU56ihKzUkZQtwLpQZWxHF+GqOB8Bz9oV4M8idyUz2DGQeMmR5FNFql9n9df/Dp4Me957VM/+AxQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 01:53:40 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 01:53:40 +0000
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
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIDAvNV0gbmV0OiBmdGdtYWMxMDA6IEFkZCBBU1Qy?=
 =?big5?Q?700_support?=
Thread-Topic:
 =?big5?B?pl7C0DogW1BBVENIIDAvNV0gbmV0OiBmdGdtYWMxMDA6IEFkZCBBU1QyNzAwIHN1?=
 =?big5?Q?pport?=
Thread-Index: AQHdTlAasj9uKBxgPkm1zHM8L1PmQbbisb8AgAJznjCAAKgvgIAAkPjA
Date: Wed, 30 Sep 2026 01:53:40 +0000
Message-ID:
 <SEYPR06MB5134FA89E6754F168E94C1B29D8B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
 <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
 <SEYPR06MB5134D5AEAD86D3E4C97D1DB99D8C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <36d6dac0-30ab-440a-bf35-81b33ecd8e8b@lunn.ch>
In-Reply-To: <36d6dac0-30ab-440a-bf35-81b33ecd8e8b@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6959:EE_
x-ms-office365-filtering-correlation-id: c4cb397e-e4a8-4f00-e841-08df1e95a68c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|38070700021|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 RRfgP8SjW6TTU4kor3RUKIZLfPxAuAmk9fZJ9XnY94s4PFsSYdyIo1+Bgm2Ni1ONYAbc5sEm0Z78X08bgV6T24TEipybDKJcztdmy9ELF1kr6ttFpvJJY78hQ9WVYAHL4RvPiOHjbGfbDv4Xl9K9gv0H/JYFl1IfWbnS/zfvfKLEyT9t0FemqnP+Kwq0LaocMmI5MjHPmy2b26UdChCMS4nxch8D7NzsASsyGuO+smMhvq0j6KQ4QylJwu8quf2/myZzzg1TaXefzt/ahIJ6GfTM0BLSFVTuhmc5RogmMOxuSMzbtXaoeNoV4z4vNSN/ApdkJNNp2BAj3rpK9Ia+JGu94SgXgqvbr59+i5+Irk7jpXXaIiFvIjYd7gt5LqpB0L8SEIUAa1t1eyYudAiqp1ctNw1sfofLUGb1EQpolfSngJVMvOsBX5Iafm1PgExqhiEJJrfvhm7r8ftNfSs9DK0OdvprcadZiPXT/5BciXu7N/N2wC5+2JLHISuUyNph6emREq8Gd3zU8qVBNlT3CczI+U7z0M6lyu5XdMevH+jMl3B54wNprIGnBWo3f1mEhZtg2HxfEe8WDUUPDBqQqPE3KiGf28vgmDREKy7ImCpf0oVrwNNbUVfGGXKcwJpACk+L3yZaeL8uDlcd3/jQaUm98Dj3D5oKKoDdoCHYJ+mG+5sNaU9SBkP4Mku+RU6BvZjElm1zqgZd+Ufi7Ct80Olc+W1XFzUKtHLgKiXzfKo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?dDZvOXB5UXArRGhJU05wVTRxSDNkWE9MS3FsdlV4Y2xxaXN3OGZqUTNyZzlGcjZG?=
 =?big5?B?UXdlVThGYndvZjJHRXNzUWRTZGJjMTlMNjBwOURyblNyK0VHT0pHZDRxWXkrTSsw?=
 =?big5?B?ZXdWRHJBNTc3RVQ1UFhsZmMzQ2VvaGlIcTVtby9aTkVIK0RJUXZreDFySU55am9p?=
 =?big5?B?T0srYUc0MDRlTy8wQWh4MlA5TlFDcnJrNUZlRng4L21CcXU3SXVNRTA4WlQ5Mm1R?=
 =?big5?B?aTIxaXpqUEYxR1RxZUFpVklpS3ZndGt3Y2I0c3RxSzUrZUZGVjJLTVZkdjJDZEhr?=
 =?big5?B?U3JTdWlraDRROTNtc1hpc0ZwdkwzR0RWeUFoSjVITHJxY09Idmo5Ujh0Ny9FK3BT?=
 =?big5?B?WWtBWVRWaWx0VFpidTdkMUtKNTE1cTBHc1pma0orUW0rampyZktPNXVRNWpkemE0?=
 =?big5?B?Rm5Hb3lHTVpOR0xDYXR4QmtET1VkeEtuSTIvMkFIU2xHdjE5YVlqRWxibnVTN2t2?=
 =?big5?B?UVRJOWlkSjFhaEpYWU51OWkxV0NHY2w2b3VMM1hNMWsrQmQ4R1FNMW45ZkpqMG5X?=
 =?big5?B?S0ZmOE9RWXo0MWtvbGVrNllWYm5HcVlJQVUwbE5GS05TWDNpbnpXTTFra3dxL3N3?=
 =?big5?B?ajRmMC9DUG9MNEg1aHJybHlCWTNkL0dzRndDTW4rTk5yQWFIYTVNVVVhK1VzbWRi?=
 =?big5?B?aHpQYWhpdlYvbmpDSjhpVDU4M2JLZGpIdUlpME9naWNQbk1odHErcVZDQStncVRF?=
 =?big5?B?bmk2NWVQZmNDWUxtZENMdXZWbkxiN2VVWDJycmFvVWlJV0pZeldsSXJPOUQvVUFs?=
 =?big5?B?RnpxUXJuYkluRFZic2tmMGVWbnRrYVQrTk1oSDFDb1ozb1o3akRPQ0lBekxXUDBN?=
 =?big5?B?bSttelhUdTA5L1hDMGlOWXBhSFB6WWd5TUYvNjk4cjRlNWM1a1gyczk3WU1wd01P?=
 =?big5?B?OHhUTEJobHFaeTdqaXk5dWxpbEQ4WnFzb3p6eitWeXJmdHlXU2lOWGlQTjg4amNq?=
 =?big5?B?WTd2VS9sSEpuMUZONTRUK1NIZW84b3RDbTFJOVZqY1pUVExQNmdnRVNPdjEvWXUv?=
 =?big5?B?Y0xySTY5dGdwNVFuMnVzKzlDMHU2R084MldyaklHM2ZsRlZVSTFvd2lURjd4RU51?=
 =?big5?B?OHh6VmdQcU1aZXY2eHpkd3Qvd1hXc2hVbU5HQ3p6SFpiUHRaeVQ4S2VUUXk2RDdu?=
 =?big5?B?dHgwb1RXTjVsRXlZdTJOejVMbHU3M2tNeHh0NXd0VDJSMVE1ZnU0N3k3cUxxclZp?=
 =?big5?B?NW95ajFFUHVWTHEwaisrN0hiNmVlMlEwT2lFZTNMaXRack5FWW5QRFQrVk5WRVdw?=
 =?big5?B?WVUxaXRPOWZKd041TUFnSHF6MEdPdDUxaVJpcXh3d2J1NVZGeW1KOVZ1UmNrOTZ4?=
 =?big5?B?bWZNWVZQMXN4b2xUcVdyOGlWTy93a1ZvajBWZEd5ZGw1VGlncjZQUURCUTNvN2RN?=
 =?big5?B?dWVmWmVsS1VnM2NzditYaVNjRldid0l0cFFoYldreDZxY2hNbHZ2MEc1OUIramI0?=
 =?big5?B?MitHMmZPSkM2MXc1TlVsOG5Va0RQb3NnRmpUNmlxZG1mT2xQbDFSN2UrSjBFVUll?=
 =?big5?B?dW1CSG5oYlZIUG5Ca1phTFk4VEc2VFhkVTcxQzVRaGVCeVNsU09XMWNVWm5QTTlw?=
 =?big5?B?RGMwNmI2VEJuandDaW1IR2pHaGhxZjMzVFl4OW1vOU9DTHpRUDkyMHIzY0dLTURN?=
 =?big5?B?QlZVcjZLNXdNWjVacUtBbm1YRENBOXJYRXBZSXNQR2k0UFU0TklaQ0lCRzNmUFUy?=
 =?big5?B?ZGxHUjFWVHNtYzVOd05nUXo1R3phNzhpeksxUkI0UjcrdGpIbmwwWVM4K1Z2MzZY?=
 =?big5?B?czZvQU5WUlZCZTRITFA0c1ZLVk42KzNCQlhFaW1qZW01TE01RGRWS01WbW1YbEZi?=
 =?big5?B?S3VTVE1VK1p5bEJZUVA4R21GWEZORDdaOE5wVGV5RGhiZFpyREphZEdPWGlFZzRq?=
 =?big5?B?RVRQNTJNaDdhV3hOMlNTcjVyMzhzRzdIcTRkbGhtNkovUDVQWlNqMXNBd1U4enZi?=
 =?big5?B?NnV3eUlZL2FZWDlDRWlCRUV6eFhxWU15S2Exb1pTRmRXTjA5ajdyRzhhTGsyRlN4?=
 =?big5?B?V2V5Z05MS2MvUHUwbGhEeStmNWpyWTNVQkFWcGJVZ0I0Z0ZjVno5WHFxN1BaZjg4?=
 =?big5?B?QTZ0TWV1TE1PcS9nbTkrSVdVVCtSZTRhYjhpRG9qSkZ2L283bXNJYXRpZUFycjNp?=
 =?big5?B?OWNsN3VCaEowRVpTbVBObGZlbUMzUmpzSEZnNE8rb3dkeDN4NmM5RUozaUZqUkpl?=
 =?big5?B?MlFvUGxaT3RDRFVZVVpuc2p3MERqQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cb397e-e4a8-4f00-e841-08df1e95a68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 01:53:40.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2x1HwCW8UJrlw88MLEptiOqo+Xhh0mMTxnYuqaEa5jNqi4CpdrJ4wBcZdjGjb6lBtrT5TpyhyYRZj2af0RkTCVWktq0MhX2Fb6Yb+aEklzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6959

PiA+IEN1cnJlbnRseSwgd2UgcHJvdmlkZSBvdXIgY3VzdG9tIG9yIHVzZXIgdG8gY29uZmlndXJl
IFJHTUlJIGRlbGF5IGluDQo+ID4gYm9vdGxvYWRlciBzdGFnZSwgaXQgaXMgdGhlIHNhbWUgYXMg
QVNUMjYwMCBpbiBib290bG9hZGVyLg0KPiANCj4gRnJvbSB3aGF0IGkgdW5kZXJzdGFuZCwgb3Bl
bkJNQyBoYXZlIGNoYW5nZWQgdGhlaXIgYm9vdGxvYWRlciB0byBub3QgaW5zZXJ0DQo+IGRlbGF5
cywgZm9yIHRoZSBBVFMyNjAwLiBUaGF0IGFsbG93cyB0aGVtIHRvIGhhdmUgRFRTIGZpbGVzIHdp
dGggdGhlIGNvcnJlY3QNCj4gJ3JnbWlpLWlkJy4NCj4gDQoNClllcy4gV2UgYWxzbyBjaGFuZ2Ug
b3VyIFNESyB0byBjb25maWd1cmUgdGhlIHBoeS1tb2RlIHRvICJyZ21paS1pZCIgdG8gc3VnZ2Vz
dA0Kb3VyIGN1c3RvbWVyIG9yIHVzZXIgaW4gQVNUMjYwMCBhbmQgQVNUMjcwMC4NCg0KPiA+IFNv
LCB3aGVuIGJvb3RpbmcgdG8ga2VybmVsLCB0aGUgUkdNSUkgZGVsYXkgd2lsbCBiZSBrZXB0LiBU
aGUNCj4gPiBmdGdtYWMxMDAgZHJpdmVyIHdpdGggQVNUMjYwMCBhbmQgdGhlIG5leHQgZ2VuZXJh
dGlvbiBBU1QyNzAwIGRvZXMgbm90DQo+ID4gbmVlZCB0byBjb25maWd1cmUgdGhlIFJHTUlJIGRl
bGF5Lg0KPiANCj4gRG9lcyB5b3VyIEFTVDI3MDAgYm9vdGxvYWRlciBhbHNvIGhhdmUgdGhlIGRl
bGF5cyBvZmYgYnkgZGVmYXVsdD8NCj4gDQoNClllcy4gQWxsIG9mIE1BQ3MgaW4gQVNUMjcwMCBh
cmUgY29uZmlndXJlZCB0byBkaXNhYmxlIFJHTUlJIGRlbGF5IHdpdGggInJnbWlpLWlkIi4NCg0K
VGhhbmtzLA0KSmFja3kNCg==
