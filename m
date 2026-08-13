Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABC43BDB5
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655844; cv=none; b=hVSQXOUcmJcE4fPTB4KP3ZjuZ13uY0BkielNipx91rZn0DewsrP5ie1q4hJ2VSfRkiC9Mg5YH8+wWMYQCurcLzEWe/oAI9IHKa4ecSLuXWMnJt01sfp4aBXg/HBOPLavPg/6lkKqFuegENZaHtyxNg9v7HHLqIw0Hq9lLEQdyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655844; c=relaxed/simple;
	bh=dJWYJiopMkYjHNPQNrxwUXgEyoivEcIVLto09zQqNxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YLz0xogVkET+3mqRCL6WOceBrHaJh0ZM8jAFZ59o287egCuj0zvtH9NqCwbxLOnXlOqpJSo9g/SlmXpwyz88i2hCZmVhvXqBegQp1HjayAvYWpGPMzs5G55cjBTKEu+0Hi1P1XTwOOQ6frt/O3VTbFozL4iDnvo0KpVt2Ntpb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=ZTylvJRt; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="ZTylvJRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1786655824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJWYJiopMkYjHNPQNrxwUXgEyoivEcIVLto09zQqNxs=;
	b=ZTylvJRthHT4r13QK3uX55jMSpiNk/JkXOfRRToKb7TYzz6jsYhfk5hgJiEFymbZdcrKbz
	/oDqKeOWg8NeLmCQKyB1sfevRicFdxrGNI0CqCMYsPpBeh5OPWkEdICmY847Y0m1XiF+cV
	APjIXPf0KDMnqinRG6cSQP6DEcU3Zdl4m17XscKSO2DW1XlujtbWX7RQFLrTouuD9FEAS9
	8225SGMH/kZfX7g+KmHFUX8wYJJZQgpSbkar/SE8tsY48Skb5FjIXPNqQDvYPiwFXpzjr1
	FKelFGLjBaws1dmpvcOFTrYGrYdy+TEfrc1yK9RjxAnXP1oM9RGyWiBKoEWGUw==
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-17-K_7S68D0P4eW-swSsSrQrA-2; Thu,
 13 Aug 2026 14:17:01 -0700
X-MC-Unique: K_7S68D0P4eW-swSsSrQrA-2
X-Mimecast-MFC-AGG-ID: K_7S68D0P4eW-swSsSrQrA_1786655821
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 DSWPR02MB11443.namprd02.prod.outlook.com (2603:10b6:8:353::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Thu, 13 Aug 2026 21:16:58 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 21:16:57 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdKs/qH9kSA0y0qky/TWZL6h0yBLacGY3QgAA6PgCAACf34A==
Date: Thu, 13 Aug 2026 21:16:57 +0000
Message-ID: <DM5PR02MB3369B34BD9F03C712032939383DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
 <20260812-fix-race-condition-and-crash-v6-1-6cf90f4a271a@onsemi.com>
 <DM5PR02MB3369B6A836C24C3DCE913F5683DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
 <190d172c-ee3c-4396-baef-1f0765f72ec8@lunn.ch>
In-Reply-To: <190d172c-ee3c-4396-baef-1f0765f72ec8@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|DSWPR02MB11443:EE_
x-ms-office365-filtering-correlation-id: b6c7d8f5-92c7-4843-71c8-08def980353a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003
x-microsoft-antispam-message-info: JpLIiDLQsw/YyZfzL+noU3ka5WMj8YFui6OzpFjapi5zXihN2YiCiC530FlGjXPKz/CszgGUeky6ZX2IG36kZk1OWFIXE5nl4XagN2vYLJ/yS92dk8QlQPrqqNXzVIu+z3VvkBXyIGHMT7m3TQFXrXdY2CeV9Mjr7/8s1Qw1gMIocIOW4hgowh8QrVm0TgpshIT6/KMblbpZDtfbBQ6eczW9fQ283MOWpDsOA0ssNTFGCNluF07n8zstwEykwsPb2LHqZJTcbTN+O1dFBBX+1hDx9/MOIb8gO3L0NE5MmIsRS1VJYnL0alksAown4RDm3XEtIP1sjLtjtmkuN2Xw9OKPlhMGhzYSu+GKffJC61iGWFwwFzlVkPeNyZCeJji2K3i22Hprn84e9m3EmXBXOMxOxqqIkeeu7RpUxg2Q43pjvckyB4G3edQXIdIIkFwVyNJ2IDNyfOkD4aF3dcR6YUMv0p3rhY+ncOva0EqUPCL/Mn/+b1xmPcttl4NlHtEhDZLHR2DzQfef4oWAKETxula0vLdBCFW+bKa9DC0ISjrGZjEYaMK9cn1OPqGNVKdC2LqLXaVhwII8NjiFnNeoCqDR/5hxAwt5En3myqCR1kDdBJ7MDumB4TAG/KO4SGcXyY/2U+Fpamt6dfPuaUXmB1ttldDgK8PgEKYHD0sYpN0xK704GeiQIBKuQX6T71D9HTFQ7FICiHICcyYWJAFEqxHOf+1Ca3HNHk8IGTsa5c0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm0zRW9MdnphWXQwOGJwMWNFajJhNXI0Z3I1RFZ1b3p6RmpsRE5aMVhQNWZN?=
 =?utf-8?B?ZXIvTTNxVDhvOUllZVBDOVNSblo2L3JqRlVpSWNTYlgwMlU4SXp6aTN1N2pE?=
 =?utf-8?B?YXFMeFhtWnpzczlPUmh5V2F2YWVvWGE4Ky8xdXFVdjdkZ0dKWi93djQ1Rm40?=
 =?utf-8?B?ZHBvdzN5cjh4K2lQRFpsQjMwb3JEd0F2enZwTTVybjMzUWZibDdERGRnOGM1?=
 =?utf-8?B?WGl6Slk1SUZXdDNkSUhhN2NZU1JzKzU3RzJIdTh2VUUxNjBUTE41WTBaSmZF?=
 =?utf-8?B?Umxwa09wY1hyZ3g5bFcxUlNjbUs3NC9hVFRhcXJOTG1ybndjZ2ppL2pINXNz?=
 =?utf-8?B?ZjJEVmZTZmVmR2xVdTZuRnVpUlhIc0lMUHJ0eXJaeHE5a21iV1VvRUJqSEpL?=
 =?utf-8?B?MlRhZTNXZUdJK1pTQjU3N0tQU1FxY1JtSXZOWE1aWHVmNUVTYVo2a0NwM3Js?=
 =?utf-8?B?dkZHaUVwMm5HZmZjeS9qOVdCMkpMTG5iaFBwRUlTZVJhVyt5RlpzYlNtbE9S?=
 =?utf-8?B?NDExckxVdmdIQ0V4MXk3aVFQbVJ5RElXTFZPTkJLaUVXTHFyTHBUR1JMeVNk?=
 =?utf-8?B?K0lFQUQxeVM2Y0EwK2tDbE1kRlR2b0Z1NlEvczNhSDVCU2MvdDhyVndoRlJP?=
 =?utf-8?B?bHp5WXFsNCtQeDhwNVo0R0hjVlFRUlZHK25hc0M1OXN1Uld1RkJPQm5aWnhC?=
 =?utf-8?B?SEYyeHhNeDU2QVhOVHF5RXR1ekxuMTM2clFFbVlIVWRRRzNMdzlHU2RGSWcr?=
 =?utf-8?B?V1k5WUVlVXV6VVlsWlUzZTNLbkRkWWRhd3ZSbnVTZUFHRTZ2aDJNTnJqRm10?=
 =?utf-8?B?dDN0TkJXam5oVFk4SS9BQlN0ZzlPTTZsS0FYWGNScmoxWXNqR3l5KzhmTmxx?=
 =?utf-8?B?V05UeVRabndxNk9KUnpMSnhzcTNlVnhNMWlHV0pBeVJSSjJyK3BMd01mQnF2?=
 =?utf-8?B?K0Ric0llQTAxc29NdWFkS0xjQXhSQjRFNElTaHZNV2hLbC8xMFF5emZnbXFu?=
 =?utf-8?B?STdMMStyTm1LaW9oSEIxWnZNblU3eWVLQmcxVitRZDRMM3QzV0Irb0JaRzk1?=
 =?utf-8?B?QlBwUUNqd2VVOWlVV3UybkUrOHpvSFBCbVVlejQzb3kwa0ZoblVQWmxaM0xt?=
 =?utf-8?B?WG82QzUvSHp4akxmWUdzVFl5c1ZHN0lmKzBhb3dBVVI5eGZRT0RFSHJVbFh3?=
 =?utf-8?B?SlF4eFp2OGN3Vkg5SFFsK0ZHZ1c5dzFQQ2VnQ3ZRZTRPZzhwYjVTR3AzVVZR?=
 =?utf-8?B?VHRMUnRLOGlaak5FZUVyNi9FMUw3ZzEvNzBBYjdWc01ETm11OWUvOE9MQ2o4?=
 =?utf-8?B?bDl3VGUvMjFWN2dTZkdqN0picUphanpzQS8xQXc2V0J5TnJKcDVDTlpxVEFx?=
 =?utf-8?B?WHdBMDRra3d0b3JsalhyWnJrNTVwcEtFTTNCMHJjT0ROQWNVRnFPdkFXUS9I?=
 =?utf-8?B?d3F5QW1QV3FHZ2J4SW9WejU4UEJmVEV0NTNXbjBCajFxdG9KckZ4NWovaTJk?=
 =?utf-8?B?cWVXMnMxRXVtTUxUV1FERHUxNCtabTdaZngwbmFTNE44K3dzcmRyUytTdjhP?=
 =?utf-8?B?aWVPQ1gySmR1eFpFdmlZT2ttUnlnNjZRdWZNcjdRZlpKNWVjQkJOb3lUM3pT?=
 =?utf-8?B?Ynl0RnNDNTlJUTc1TGpraXlBSHZaS253dnlhLzhyRTRtTWs5RnFmdGNOU2Fv?=
 =?utf-8?B?Zy94Y1J1RGMyUGU3WDF6Y3kzQVJYN0hMQ00rcU5tKzVTT2FJa2VyNUxwWEtS?=
 =?utf-8?B?VlNvTjQvTnVXZ01EeEowcWpyZEh3em5ralBjck9tMGNCQUFCVHRWZ3JtRXVm?=
 =?utf-8?B?YWRBZFFNeEJWTHptV093RjI3SjZCN3cyaXJqUnJTajZ4OWM5OEtzcWdxdVIr?=
 =?utf-8?B?ZFZDSTQ5eElndjFnUHhXR1J1UGloSiszWXBmeEprLzAyZ3pubWlEVzdrMEYr?=
 =?utf-8?B?U2Ywa0JBNzY2ZTFLa21XYnJleEFlRFM4cS91ZlBDZEthcWd3QzF1T0FSR0FY?=
 =?utf-8?B?WTArRUYxM3pKZFNhbCtvNmZjUHl1bHBSMlNSdlRRUHBzOXorNGIvS3RIWGln?=
 =?utf-8?B?ZjBDUmlMYStqMkJ5TlJPNGo2S3JLdUJXdmRqdU50MndnTUMvMmhEVGIvR1JJ?=
 =?utf-8?B?Q1hTejVJM1p3S0E4eXFQUGwvcjZ3YkxLdzRkMFFQU2s0TnNQRVI2MWJFOWFh?=
 =?utf-8?B?UTBHRmd6RWE2R01EOG1RNm5kSlkxSkpJYkJIbGlYWXJJSlBJNTd5Rk5BbHl1?=
 =?utf-8?B?QTR4TGZyajlOTEhpSCtvaEZQV3FzYU4zZ0pIbzdkWE9sZUwwRE5xSGRyTjVj?=
 =?utf-8?B?SjVvOTI2L01ES3YyME5uVXZwdXFYbWVEc1VkeWEwdytCQ2xNZGtmMFpOczZ3?=
 =?utf-8?Q?qHaJgdQWDGBsCqjY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sSBUqr+ahnGJTBKic8UbWC2w36zCsFxbtLWUpaWT5L35jdRyN+gn0eMFbFKiIVvmwkjhURqTvpEvn8NlhD4H3MM8fKbOz6aUSzj5aZ/wqenTqkcBSiJ3i99J44L6WSvDsNstj0ISZk7976gghSYukcEdVq9XRlgXlZEceA8Bhd7GFppVNSqctDocMUTcnzv9TgrsmNzODt++1tPINevQwlRrSPqA6gOAEKkUukbAKPXvc+JguYklWlqMKngaq5qMXfms0HY7gJPqDjXOBBTjKq9w9GMUAoUX1bOBs1AQukSy/+c+6KqPhxqhHnkaxI/UbWhnKKu9/74rGm3Bok2Wmw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c7d8f5-92c7-4843-71c8-08def980353a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 21:16:57.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56m2p86E3SZXr6pf5zxNA1R8ejI1zby2+juBbX+ZpYhwqu9+L5TNbBF8ayGk6LnZPIKYj/nB/lmaEMOmIDE0CZmRjC/4YSrQCPe0DLkck7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11443
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JtagTvMl4hfHkqDmFsdO8jFy1vof-nO_yBuXMb3yqb0_1786655821
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTMsIDIwMjYgMTE6NTEgQU0NCj4g
VG86IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjYgMS80XSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6
IFByb3RlY3Qgc2tiIHBvaW50ZXIgdXNlZCBieSB0d28NCj4gZGlmZmVyZW50IGtlcm5lbCBpbnN0
YW5jZXMNCj4gDQo+IA0KPiBPbiBUaHUsIEF1ZyAxMywgMjAyNiBhdCAwMzo1Mzo0OVBNICswMDAw
LCBTZWx2YW1hbmkgUmFqYWdvcGFsIHdyb3RlOg0KPiA+IFBhb2xvLCBBbmRyZXcgKG9yIGFueW9u
ZSB3aG8ga25vd3MpDQo+IA0KPiBQYW9sbyBjYW4gcHJvYmFibHkgZ2l2ZSB5b3UgYSBiZXR0ZXIg
YW5zd2VyLi4uDQo+IA0KPiBJIGFzc3VtZSB5b3UgYXJlIHN1Ym1pdHRpbmcgdG8gbmV0LCBhbmQg
eW91ciBwYXRjaCBpcyBiYXNlZCBvbiB0aGUNCj4gbW9zdCByZWNlbnQgbmV0LiBTbyB0aGUgcGF0
Y2ggYXBwbGllcyBjbGVhbmx5IHRoZXJlPyBUaGlzIGluIGl0c2VsZg0KPiBzaG91bGQgbm90IGJl
IGEgcHJvYmxlbS4NCg0KWWVzLiBJdCBpcyBiYXNlZCBvbiByZWNlbnQgIm5ldCIgYnJhbmNoIGFu
ZCBhcHBsaWVzIGNsZWFubHkgdGhlcmUuDQoNCj4gDQo+ID4gV2hhdCB0byBkbyBmb3IgdGhlIGZv
bGxvd2luZyBlcnJvciBmb3IgbXkgc3VibWlzc2lvbiB0byB0aGUgbmV0IHJlcG8uIEkgc2VlIHRo
ZSBmb2xsb3dpbmcNCj4gZXJyb3IgaW4gcGF0Y2h3b3JrLg0KPiA+ICJDb25mbGljdHMgd2l0aCBw
ZW5kaW5nL25ldCBwYXRjaGVzIChuZXQtbmV4dC0yMDI2LTA4LTEzLS0wNi0wMCk6IGVycm9yOiBw
YXRjaCBmYWlsZWQ6DQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jOjY5MyBlcnJvcjog
ZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmM6IHBhdGNoIGRvZXMgbm90DQo+IGFwcGx5DQo+
IA0KPiBJIHRoaW5rIHRoaXMgaXMgZ2l2aW5nIGEgd2FybmluZyB0aGF0IHdoZW4gbmV0IGlzIG1l
cmdlZCB0byBuZXQtbmV4dCwNCj4gd2hpY2ggaGFwcGVucyBtb3N0IFRodXJzZGF5cywgdGhlcmUg
aXMgZ29pbmcgdG8gYmUgYSBjb25mbGljdC4gSG93IGJhZA0KPiBpcyB0aGF0IGNvbmZsaWN0PyBJ
ZiBpdCBpcyB0cml2aWFsLCBkb24ndCB3b3JyeSwgaXQgd2lsbCBnZXQNCj4gaGFuZGxlZC4gSWYg
dGhlIGNvbmZsaWN0IHJlc29sdXRpb24gaXMgbm90IG9idmlvdXMsIG1heWJlIHlvdSBjYW4gbG9v
aw0KPiBhdCBpdCBub3csIGFuZCBwcm92aWRlIHRoZSBhbnN3ZXI/DQoNCk91dCBvZiAyNCBodW5r
cywgMiBmYWlscy4gTGV0IG1lIGNoZWNrIGlmIHRoZXJlIGlzIGEgd2F5IHRvIHJlc29sdmUgdGhv
c2UNCmJ5IHNwbGl0dGluZyB0aGUgY2hhbmdlcyBpbiB0byBzbWFsbGVyIHBhdGNoZXMuDQoNCj4g
DQo+IEFuZHJldw0KDQo=

