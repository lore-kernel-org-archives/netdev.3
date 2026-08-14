Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB743348896
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786684857; cv=none; b=WdikuoZ65pJQVhdBgwasH9wVqYzDaeVlQkeae2RvJqbYpeewWhDUFkqwRWPGZYy4JmqEUHJmtIIZp6NcbmQRdU5Sor8j0oN/Vpj73x5DTeDJvGwHSOYxCVwXIxId2YYoU8pNZjfveFQnFOvcPJ3xBeQ1yKoQ080iNjxmiTvHfds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786684857; c=relaxed/simple;
	bh=1QYi/OSJX35siUuIQe3jVlfCU0H2MpuUaMKBVP65dVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=n6edqt66F6vpBQifsLG18yqOkzJWSZunjY/GukhHk9j5eyXdUkKPZNEqXB3HGmOGwGeN2KeRvoKoWcr3tMGLUXra66K2ONlTRac1/dZdNHvzuUEXelqXweH6GOJ8dRI11OLq1cj5luAVzwSRx7DifPECfGH58dGReLDDzqQyp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Acb7RPHv; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Acb7RPHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1786684855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QYi/OSJX35siUuIQe3jVlfCU0H2MpuUaMKBVP65dVo=;
	b=Acb7RPHvGA7f9yU0IM2b6DjXw21FpyTzH8Yy9gDWfjpA9XZA1+KXq9XP8fYSu+miMXGVxH
	hMjK/vOz6BgUw/X7mip8kNVp/nPlYYEL47VkffqHyhShnhPfqiJTZzfYDGX6pnSPUFrKJy
	C0CYweIIEv7wMmdOmkw4OmiJaSA7NwI3tWPjaflIWDDhGCpZbFWlsCrGVHdtKjGXGEKWx9
	7Wg8/FNKgN0dXtsJX04SCJ9jB7+CA5Qg4O8z9aCpP0qi30bLaxogEeC/1YWU4NRnMdeJOy
	aDUGqos2Zm85d48xvVsD8vOh/CMFhWsQS1yT8AaNaDKdee6P6o2I6JtmopfgaA==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-29-7U7Jp38UP3ypbkxdLFaBBA-2; Thu,
 13 Aug 2026 22:20:52 -0700
X-MC-Unique: 7U7Jp38UP3ypbkxdLFaBBA-2
X-Mimecast-MFC-AGG-ID: 7U7Jp38UP3ypbkxdLFaBBA_1786684851
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 SA3PR02MB10083.namprd02.prod.outlook.com (2603:10b6:806:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 05:20:49 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 05:20:48 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdKs/qH9kSA0y0qky/TWZL6h0yBLacGY3QgAA6PgCAACf34IAAhaUw
Date: Fri, 14 Aug 2026 05:20:48 +0000
Message-ID: <DM5PR02MB33697DFABDC38A6C5C0946CD83DA2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
 <20260812-fix-race-condition-and-crash-v6-1-6cf90f4a271a@onsemi.com>
 <DM5PR02MB3369B6A836C24C3DCE913F5683DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
 <190d172c-ee3c-4396-baef-1f0765f72ec8@lunn.ch>
 <DM5PR02MB3369B34BD9F03C712032939383DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
In-Reply-To: <DM5PR02MB3369B34BD9F03C712032939383DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|SA3PR02MB10083:EE_
x-ms-office365-filtering-correlation-id: 7951c978-095f-404f-d389-08def9c3cd22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|38070700021|56012099006|18002099003|4143699003|11063799006|22082099003
x-microsoft-antispam-message-info: 145FWaBAX3QmoMIPERmOgEfhymZXHIGbTlDJHh47aOkh6deCfu+bNdNoKenmopM1XuXnXPgeCgYEYe7D7gIdC6PcN9CguKbQhVD623loRYV8ED/o2xoWY31eDk9lnsh3CpGQJKrEuJcW2PjCVutqyFzD8ZRrpDt1txAvviztF7b2n0guv4gu/h176ANn8tBnzLzePGWagM/IbbaEz5Ut7m61W79X1eJEcW1DD9rms1q/EtCWGHwbqBa5BBzwhcy5UeKQ2q5AD+VbGQuVNg7bd3bLcgQk00Qd65KzIUGa8mp999qXKWuaAaonnYogPLmr1XPGgNJhYjwx2JFrXcPSsH3PlPOHC52TYWuRDIaoJHp2ctUvmYCldBVR+2vj0jBU3QX++DXeFvj3g3vzpGkfWUKMitRHKCJfuUMNALYx0dF6T9Z7eZQ7vcI8PK1QNtmj9hkmPw9hLg94RZvatIW+Cq/MLz5FainiGGEPgJdTMIibJVRpZeY2FVmgoJqDTCg9+e0hXkfPs0hLbxyxVnWtUZtzHR465fqEbWc6wUykWB26ceDIf3JzhUVaB3IlzyDIVTYYOgFnGD8zAemtkLQfKCp8+vejk0vBBSLYld6mXXA7AuD/GHX9/SDqYbc2KDXsfg5aQ8d82RxrGvsyy6+FPPy8CwGZhX2Dx/NOhpcXwsfjU1pOgWhSEIQql54LOrNjxQ9E0zEkOgr//gtelBVefSQ/Gw4RETc/Y3PE86SbBlE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(38070700021)(56012099006)(18002099003)(4143699003)(11063799006)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZKWWp4S2N4OTRIQktFS2tYK0UwYktob2xTWVJJRE1wMXYyc1BlZzYxZDJo?=
 =?utf-8?B?WGdlRW5HRFRjb1JQWXdjV2lmcjV3czVyOXdqbkRmS202Sm93L2RwS2c5UkFr?=
 =?utf-8?B?bzluTFFhK0RPME9DbERCemlwQVVKT1dHZVZKOTNkVCtDaXRQTlBYMVErV3pO?=
 =?utf-8?B?MDRpZytnYkdZOGlKRmVKT2Q1aFdMTFRtVS9kMmtEVGRYaWFmK0FaeVRZaHNG?=
 =?utf-8?B?T2N6VWxKQWM3VFRJVVZRdDJWWWlvb2JxWVpucEFpOGVtT0Y3a0g5VUI1ZHIr?=
 =?utf-8?B?OFo4YjJCaXZRUlZsdWJhZUlab05JWElibXlobytDUWY2bys1S0xmVjY5OEZQ?=
 =?utf-8?B?Nm5RZytXUHFLa1dNZFA0MGVrL2xJYVRGY3ZCZ2J1RjhueHhmN0tQaGtSRTYz?=
 =?utf-8?B?dk0zYzRjM091Ynlaek1uL3dUd0d2UmdZYThPWGJKZlJUbEF1MXcvTDN4dU8z?=
 =?utf-8?B?MVJOLzcyN1RzMFJITHdZKzk5SEhiNHowYUJwZXE2N0VUMEZZdys1RnZqQW5j?=
 =?utf-8?B?MzJVazhhc0hvdEMxYkQxY25hQUdKdk9iQXU5VnNIcjMvNjFJNUpzaG1pQ1Fi?=
 =?utf-8?B?dHBIWTNPRG5BbGR4dG1jcFRmdGw2VG91UU1MdFU0RnMzdlVkbTlDT0VibWtU?=
 =?utf-8?B?QmMvdEIrU0pxYVgrd1B3U1d2aHVXMXNncW1XWTZBYU1XMlhmWWk0VTZpZmVG?=
 =?utf-8?B?OFlmZExoMmtHYVZYbGF0TUZyMENOY1drYXJicnB6L0ZPL3BTa083MWU0RXI1?=
 =?utf-8?B?ZDRIUHUxZk13bWdsTGQ0NEZlRHBzUkhTdG9mUWh6aEo4YjJ5YWx1Ri9rMEVO?=
 =?utf-8?B?V3BrTkVGNTdlZEI3dEE4N3VVdFQrZjJtekJobmtOeTk1VGsvV0Q2cm9nSm9H?=
 =?utf-8?B?Vk5ZNkVhQ2Q1aURFaW10S0padjdoUnU3eHRQK2E2dGZWa001c1hRWXhqejNk?=
 =?utf-8?B?bElqaSs2MmdUaTBTbjk0aGlvRzlUYmRsTFNxclcvbWEvKy9tbk5Ic2ZvVmM0?=
 =?utf-8?B?VU1oaUVlcEEwWE5vYXMrTGJOWmQzVjlqZllJVEVzY1Q4cHpueEF4K0RqZ3ha?=
 =?utf-8?B?ZmlmYTh2a1d1V0syaURZaEpqcHg0cTFNVlNGTmpROHlGS2VIUkpuL3dCejU0?=
 =?utf-8?B?Y3RVNHZ1K2xTRW1RalRYN1NqL1dESkVaNkxsQVlyYnJONFZ2Z1JMT25GRTI3?=
 =?utf-8?B?Q3RTM0p6ekdPenNBc292TDJGc3lNUUxNSWR5WnoyRnhmeGh4OFJ0cDl5SW9a?=
 =?utf-8?B?MDNISDc1WjBxSDZPa3Nvd2ZkTHVFZHhvTWhsalRGQ2Z5MkFrR1ZCLzh1UHNZ?=
 =?utf-8?B?dlpmaWFNazk5VU5WZTdRUnZtZWhjVmRHcXZoeUpGNklxTFVzNmdLTVpWS1Zh?=
 =?utf-8?B?RjZJdzV0enowVEc2cDlBenc4Z2ZTZVpaYlR3cFZiNzRiVGErclZ0ekNjMFM0?=
 =?utf-8?B?K3gvV1FSTlpsZWkzZGRybk1OZTVvTVY0VnN1YVo5TEd2NzExeVFlQUFqMWVU?=
 =?utf-8?B?cFQwdkNhNDRka1JyWmhpMmt2UjBmbWtoMjQzaTRPSG1FSWFsZlVla3ZlTU51?=
 =?utf-8?B?MjF2REFmRlVIOWpSSEtxWFUzV3pMS0xYRHFkQ1BtRGxES0s1NW9Lc2UvZ2Ro?=
 =?utf-8?B?V0Jlb0wzNU5SaEUwWFh3WnR3My9lNnRPR1ZTNFh3YXFBYXpIZE8rbm1RTzRP?=
 =?utf-8?B?S2Q2NFdQaTRiMmJFOFg5TDRIQnpCKzY5Z251MkFOWjlQTy94d1A0UGMrVHlF?=
 =?utf-8?B?VUJCVERWZ3lxRmdHRC9nZ01sUlZZTitUY1dzS3R5cFVxWHRvVUYzdFhXK0dk?=
 =?utf-8?B?bDY3Q01TRjBvMnJPQWdxQ3lWRVFxcHVLRXpWalVGMFNRU3dlcG0xMENQb2xW?=
 =?utf-8?B?bEFvT0NKcFhzVWdOVmIzdTUyTm9IcisyV1d3SXBHZ1pqeXlhK0R3Wmx0YTJv?=
 =?utf-8?B?c2NuREJ4b0hEb1E3TVdEazRSSEpoM0Z3MWdreG9vK3BVazRVMVNNeTBjNUs1?=
 =?utf-8?B?c2dzZmZCTDVIZHJpR2VaZjdCM2ZiZU9uQ1F2ZUd1VWpjdGlNcmZkNGtkZE5C?=
 =?utf-8?B?M2Y0djNTNzJsRzZ5V0hhQzVKcFFGOVJKUWVsaForT3JoRHNvbTJwT1gvSnZ0?=
 =?utf-8?B?Nlp0S3d0RFVPNCs1Qmk0dG02RDBBZEJDSzhBVlRUdEo5YmZyb2NPdVlmY045?=
 =?utf-8?B?K1VFbllTbkN5a2dXMEVxbUFEcEkweGRuQW9jVExHQlN3cXNVWFZnbXhxR0lm?=
 =?utf-8?B?UzYyMVM5TWdZUDZwa1lqUzQ1NXVmQ21JN2xpMUxZNEZrVkhJclIzWUd1dzA0?=
 =?utf-8?B?L3FVaVZ6OVQwejBGb2Fuai9qN3NMVUt4U1daVFNNRWVjdkhJL0tCWmJOcFBW?=
 =?utf-8?Q?Det3H6PiAoex5ulU=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OyCS4OOYbMmyV21S9ObKob9v2eqVh18F0OY4ScAYsAy850BddJ3VDoCoUae58YrQtxH58JzEoe9Rl8GmtJ4ZYc1JUgm5f1YrnKCYL8hR2SZ1X/IpjnHD/ljUZQDalR5XN2oUva29ooEPtH6ISpObpzgvlIWZJkZS7GCA3y06b/KyYbs/Ntl5Usr8elQSwoeO7K4Go7Y+hI38fjZTwkb6S0C7Ffwcid2VF+a5nmBR6nsnbl+P5DuRmMvk2/P1fAFxkfWMAENyfg3CRLeW5T6Yz4iQHtHd+TAOiTys6XZa2QtmaM9O26y/RsXazzF71fGQl7KTDCvBZcNO3pY3f3pIZg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7951c978-095f-404f-d389-08def9c3cd22
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 05:20:48.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UNBRDYT2V+Xy4fTnp7eTrfWoAEFQwGtoYVwAYF6rzPXUZtVotC1ilZk0pdao3y3RqK4wB1UyHnENbeyQfJlFWI1Cl0LHlLw/vpVfFkBH2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10083
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _0dviqtq6SST1RWH26f08IjQTMX1G8yi-vcEhZUyBok_1786684851
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QW5kcmV3LCBQYW9sbywNCg0KPiANCj4gPiBJIHRoaW5rIHRoaXMgaXMgZ2l2aW5nIGEgd2Fybmlu
ZyB0aGF0IHdoZW4gbmV0IGlzIG1lcmdlZCB0byBuZXQtbmV4dCwNCj4gPiB3aGljaCBoYXBwZW5z
IG1vc3QgVGh1cnNkYXlzLCB0aGVyZSBpcyBnb2luZyB0byBiZSBhIGNvbmZsaWN0LiBIb3cgYmFk
DQo+ID4gaXMgdGhhdCBjb25mbGljdD8gSWYgaXQgaXMgdHJpdmlhbCwgZG9uJ3Qgd29ycnksIGl0
IHdpbGwgZ2V0DQo+ID4gaGFuZGxlZC4gSWYgdGhlIGNvbmZsaWN0IHJlc29sdXRpb24gaXMgbm90
IG9idmlvdXMsIG1heWJlIHlvdSBjYW4gbG9vaw0KDQoNCkFmdGVyIGxpdHRsZSBpbnZlc3RpZ2F0
aW9uLCBsb29rcyBsaWtlIGl0IGlzIHRyaXZpYWwgaXNzdWUgYW5kIG1haW5seSBpdCBjYW4ndCBi
ZSBoYW5kbGVkIGJ5IA0KcmVhcnJhbmdpbmcvY2hhbmdpbmcgdGhlIHBhdGNoZXMuIElzc3VlIGlz
IHRoZSBjb250ZXh0IGRpZmZlcnMgYmV0d2VlbiAibmV0IiBhbmQgIm5ldC1uZXh0IiBicmFuY2gu
IA0KSSBhbSBob3BpbmcgdGhhdCB0aGlzIGNhbiBiZSByZXNvbHZlZCB3aGlsZSBtZXJnaW5nLg0K
DQpJbiB0aGUgZm9sbG93aW5nIGV4YW1wbGUsICJuZXQiIGJyYW5jaCBoYXMgSU5UX01BU0swX0FM
TF9JTlRFUlJVUFRTLiBCdXQgaXQgaXMgY2hhbmdlZCB0bw0KT0FfVEM2X0lOVF9NQVNLMF9BTExf
SU5URVJSVVBUUyBpbiBuZXQtbmV4dCBicmFuY2guIFNvLCBubyBtYXR0ZXIgaG93IEkgbW92ZSB0
aGUgY29kZSBhcm91bmQsDQp0aGlzIHdpbGwgbm90IGFwcGx5IGNsZWFubHkuDQoNCnN0YXRpYyB2
b2lkIG9hX3RjNl9kaXNhYmxlX3RyYWZmaWMoc3RydWN0IG9hX3RjNiAqdGM2KQ0KIHsNCiAgICAg
ICAgdTMyIHJlZ3ZhbCA9IElOVF9NQVNLMF9BTExfSU5URVJSVVBUUzsNCisgICAgICAgc3RydWN0
IHNrX2J1ZmYgKnNrYjsNCg0KDQpTZWNvbmQgcGxhY2UsIFNUQVRVUzBfUlhfQlVGRkVSX09WRVJG
TE9XX0VSUk9SIGluIG5ldCBkaWZmZXJzIGZyb20gDQpPQV9UQzZfIFNUQVRVUzBfUlhfQlVGRkVS
X09WRVJGTE9XX0VSUk9SIHRoYXQgaXMgaW4gbmV0LW5leHQgYnJhbmNoLiANCg0KICAgICAgICBp
ZiAoRklFTERfR0VUKFNUQVRVUzBfUlhfQlVGRkVSX09WRVJGTE9XX0VSUk9SLCB2YWx1ZSkpIHsN
Ci0gICAgICAgICAgICAgICB0YzYtPnJ4X2J1Zl9vdmVyZmxvdyA9IHRydWU7DQotICAgICAgICAg
ICAgICAgb2FfdGM2X2NsZWFudXBfb25nb2luZ19yeF9za2IodGM2KTsNCisgICAgICAgICAgICAg
ICBvYV90YzZfbG9va19mb3JfbmV3X2ZyYW1lKHRjNik7DQoNCg0KPiA+IGF0IGl0IG5vdywgYW5k
IHByb3ZpZGUgdGhlIGFuc3dlcj8NCj4gDQo+IE91dCBvZiAyNCBodW5rcywgMiBmYWlscy4gTGV0
IG1lIGNoZWNrIGlmIHRoZXJlIGlzIGEgd2F5IHRvIHJlc29sdmUgdGhvc2UNCj4gYnkgc3BsaXR0
aW5nIHRoZSBjaGFuZ2VzIGluIHRvIHNtYWxsZXIgcGF0Y2hlcy4NCj4gDQo+ID4NCj4gPiBBbmRy
ZXcNCg0K

