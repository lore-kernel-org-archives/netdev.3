Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE2384CCA
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574644; cv=none; b=HZPQ5sd6HeO06FWjWpPhhjjt2xABOgVOB+Ck91NAI2K0Oj6ECmxoVYaiCzUKn0oEs/fphfWeuvcL51Qt7DpWUnct3fi7a6q/XCebTlkkiYPyMcjihv8Ht70bkfTqrJ9KeAob61Ja8/pouDfgD9cghncn2edZfTD63uREX3RW71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574644; c=relaxed/simple;
	bh=7Kz9xstIMZ2fdxX7rkgjWR1ExQHjG8dSl4TNM8iWX4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=dN5dwPMoJ+SFYP6QcIpztH5YZ5BpSxgzHsOjP23NICnK6uJyHveYYDy9CL/NnGGJeE7rfTUO2f/OkkNHeFGLddkiLZveJoTFaYgDMDL4WJ6syChYw7xwW/3hNmeN6ke+jIEnXfGHL4ZL1Dk24l3a6O1fodVs2PMv79/5x6ceWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=jlV/gDWv; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="jlV/gDWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1784574642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Kz9xstIMZ2fdxX7rkgjWR1ExQHjG8dSl4TNM8iWX4s=;
	b=jlV/gDWv1cR8JrrpZbk+SuTNRGKwhrtcDHW0mBcXdZ+F8Y9Bt1yTwSJnblcx0w+zPvH+CQ
	hLFkadDjne/jgagwQvF7q23M7e0yhYQ3V8GRQ9QelgyO0xYW16Ve2UsfW8vFeo5Uuz+j+j
	AUhuSJfSJoPCHKgDCrzpIZ6/dY97Rq9JWUQvDEW2z8dEy7U4jlpLb3zzdGotmxXMgzMG1f
	HuVFOB8hIaoM7MHXU05Q1itq8dKlRt0NGy9WVlBzhneBk7rSSrrdRZQRh3DubcNg9PFMw7
	XfjsSLXTVrs4jtob0Y5YdHweC3IBDzCW4OIgNoSrUR92Fd4N4nHkDqj+k6xPaw==
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-70-C3vAKLWzOviY9R0dFccQkQ-1; Mon,
 20 Jul 2026 12:09:29 -0700
X-MC-Unique: C3vAKLWzOviY9R0dFccQkQ-1
X-Mimecast-MFC-AGG-ID: C3vAKLWzOviY9R0dFccQkQ_1784574566
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 CO1PR02MB8691.namprd02.prod.outlook.com (2603:10b6:303:150::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 19:09:22 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 19:09:22 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Simon Horman <horms@kernel.org>
CC: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>
Subject: RE: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Topic: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Index: AQHdDNIEPFihzRID2EWGXn7wp5MuZbZm1NMAgBAGyyA=
Date: Mon, 20 Jul 2026 19:09:22 +0000
Message-ID: <DM5PR02MB33693344BE338A70BC70FDD283C32@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
 <20260710142019.1619159-1-horms@kernel.org>
In-Reply-To: <20260710142019.1619159-1-horms@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|CO1PR02MB8691:EE_
x-ms-office365-filtering-correlation-id: 6b74ae91-6f54-4805-1084-08dee6926843
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003
x-microsoft-antispam-message-info: qVImfTh2X5zvkPd8AbawY+NojwEKr5Rd+QUMOU9svt5xK8m6aUUNfruuoduEL6SZ7xKZTVKmdnLjYlIKA8UPSa16h77xfROJYAUe27IKvvzf9W/4boyE7W01Po7vLQqGdT/lyov1410WGWXb4FLhMrO7YsCoAp/A9SPPDiRvwkfSrZh9n4jzWWTu9LBYYf2sy1XIQdRZRkkM6WBfJCNk/wo9GaL25T+60PpetygmJURunDBNoMjKZc1RwTkwrN87Sw7X5KsyX84DnbKI3ug/ENbY1iZUnoxWeQ05G8auglK7ZEQj1Bb9qxdBH2Wdjk2qVgtXUUJPBH4aMG+upK8puw5nYbgABLzZRakcR5GGZHbANopCPEeJKWk8IrkjgQDLXaoFJTkGal0Az6bGnq4X4vN97kspa8TodUYKiCvjicYtRIVqAL9pD0bShR1EAEnApR7mANZZDvfsX5YPolBkl2A4kD/CW0ewPfMmf3rwDd71WybmalCa0xBNpxaMGAPeK+cBhy1JV42CYELmTuS5r3SpyNgbAwI1wXoMVKAo2sr9azK8r8topDB66Nk062L2nVdeSJ+YK3OFUibu+2s/c98JtzXK40YxnarCxMwvzECHI5QX+TdIHn+Ut1HVs9cY4BKhz1uSp2KZz++XM6FSqvFycvKrqKiKQJPP/0fajhDyzmMiGaRWHyc5M50IrgPX2VKqr+GNqXpdA5HDzgwO4lBljGDSZ5o9rGs2rQQRYQU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1dmaVFyZkV6S201OTd2NnRkWUpnalJhdlR3VFByRG9DWDJFYUZPcUh2UHpC?=
 =?utf-8?B?UlFBQXN3VEU1aXhKT3VnSG16SVZLOXF1NDVHTVpCRnR6U2pkcWR0dkhMdm9y?=
 =?utf-8?B?UzVwWmx3LzVPRU95Y1I0Vy9vcFNCcnFxcGs3YmNiQjZsNjdTb3hXV2o1VEtQ?=
 =?utf-8?B?cmFPeDdOdmdYV0RRaTRwTXVkSjcwdmFWellMTGhnN0Vwckp1b0VBc0lZQWIy?=
 =?utf-8?B?ajlYTy9zQU9KNGNJQnN3bzhLSTBkcVFiOXcxMGdmdy91Wjh2ZndObEJMdVM3?=
 =?utf-8?B?eWIyQVBiUmcrSnpUTDQrcW5pZTF2clhkakhReXdrNUt5cWlkQXBodmR6Vllx?=
 =?utf-8?B?MSt3cXhyZ0x0dk5BRkF6VURUYi8zcTl2VnNwV0hvVENna3diY3JmN2piTzY5?=
 =?utf-8?B?cUtYZzBjS3M5RVJ2NThYcWVsQytVSWVUNUNTS1l5Z1piY0JTamgvdXQzVW81?=
 =?utf-8?B?bG5LUkVOWGp2TlNoUTNZQVFZVlJjZkxTVUhlT29jMmZsK0F3OTBmdGtpZCtZ?=
 =?utf-8?B?dnl1cTZyWk9vcnJXeFNQZ1pneFUydVNjb01nNE42em1kYmFveEhHOGdoMEYy?=
 =?utf-8?B?ZUd3TzMxYy9YT3U3c0hVNHJrcWtjL09GQ09INkF5YVEzdWZ4dU5Semo4MTNk?=
 =?utf-8?B?bEEvQlpiUC8wQWRySVNWM2xUd0c4V0hmTHVGV1EwNXdpempaVGE4K2pCbWNI?=
 =?utf-8?B?SXZZekQ2a2NHYlRycHVzNWJocGpXVlQwdTNYYjJ3MnlWRUtqcEdFMTBmdTI4?=
 =?utf-8?B?ZUR5eW5hVy9ad2x2LzZnQnFBYzE5QmtDeTFIOUY4YjR0b2tURy9VQkJ0L3Rv?=
 =?utf-8?B?VWhtYzV0Qmp2Q3c4QUVUdytDLzNXS2twWUlLODIrR2hHd25ycm5md3ZnWE5r?=
 =?utf-8?B?TFgySTd4WGdnOE5XaHpjdFczcnRKMzFMa0VSYUJRMWxjdVJjZVFrOWJBQ1N1?=
 =?utf-8?B?Z3FkRlZUMWhiTDVTYlMrUkNRODUwZnYrUjZCaERpaW1rK3dlZllZSzJ4cm5O?=
 =?utf-8?B?UHJsMC9XRitpOEpZM2FrVGNkZ0JWb09ZTnNzblFZdUtKVzFPL1JVa1E3c29B?=
 =?utf-8?B?Qk5sb2dkUjAwNzYvbGJ6WldwaWM2YUxjS1FQN2ZLQk5RUE1YeXJ6djBIREhI?=
 =?utf-8?B?bmhhWVF0dE41a2h4dGtPbVdrengzWWxBZFo5TkgyZDZKRUJMVmppMTFDRG13?=
 =?utf-8?B?bDRXdkk2NTRSSkZqVHc0dmtmR3ZDMjc5UGlsL0xIYnBlVEFpNFJLZW9rYTFX?=
 =?utf-8?B?ZDZoSnlpaHIzVHFWeVA1ZkwyTHFXdzc3MXk1LzMvR25UZUkvdTJLY3NVVjU4?=
 =?utf-8?B?VWtVeUdDdS9hSzFQOVJPaStkV0t1eU4wUW5YVGluTmExcGljVDhRQTB2cXFU?=
 =?utf-8?B?aGcxWEtjeGtvVzNjazlUbHpOdXF6ZzVYUXF0eXRjRk9hb2xSRVJJNEV4SmNt?=
 =?utf-8?B?K1JZeUc4VEhpRGlaaHhrRGZ4VHNUT3lYdGxhbWFyN0JPWm9ZL3NZenRkeDMx?=
 =?utf-8?B?QndWcDJIWjRpYUwzMG1RSEZWU2crY2RCb1V1MXdaSy82VlAwdUo5NTU0bGtJ?=
 =?utf-8?B?N1Q1ajBDZ2k2MC9rTkc3WU9UUEJQaTJSVzBaemZQRzdPZjgrVzFGYnB0R1Bn?=
 =?utf-8?B?bFlBU1Q3QTNMVDBhb3dwTElZRkhFdzkrckJ3RGJXeVRaa253di9TZUt5U2pn?=
 =?utf-8?B?WFhVb1J1SjVmWmkra0RnSWgvVTJUMkNGUXNvUW8xeHUvbkNPeS8wMENxRzF6?=
 =?utf-8?B?ZzVYV0Uxd3doaEw3M1lmME1QWi9CbXVIc05EdFl6NTk1NUFObTZMOUhQQU1D?=
 =?utf-8?B?V3V4T0RYQ1B3WGd0dDM1R2xRNytrdFB6ZTdWWW56UldHMHZ0RFBEQ2FUc0tH?=
 =?utf-8?B?RzBBWkkrQnE5NUIwNVN2enVwbDhpNC80WWdHVENNWHdQV0hSMyszTzVYWno3?=
 =?utf-8?B?aHdGMjUrRUJ5RjNIZkJtL3EyaHFNYlVheXd4MXFvSXJ4NVAxZDVjMnE0SFFl?=
 =?utf-8?B?RGVFMG1ad3FEYVNNVjMyeTU0ZmJ4T3hVV0tkM2IrY1Qwd0Z0SUdiN1NnMGJU?=
 =?utf-8?B?SS93MFBSRkpNMmNEUFQzWHVNS3ZiRU9YOXlJNDFvWlYyOGx6WkRjRHl4em54?=
 =?utf-8?B?dkxVQnZxbHpMOGJKY3RpRldaUEoreEdSTTc1c05hMFBLa1ZIMWowOHZjQ3dO?=
 =?utf-8?B?dzVZWFR3UE9JbmxVUmF6bkpNVTdxT2g0elVBZEZBV0xUWWU0ZjVYN0FLOTlq?=
 =?utf-8?B?SXhtOVNoSFhYTHFZQ25mN01aM1NoOGw3M0V0TCt1am80TXZ0RC9RdVp4RjVO?=
 =?utf-8?B?S25rUE0rc3FndlRGZW1UZWJ4Q2xzN0Y4RkQ1bGZmQkZyNFk0N1dySUEvLzhJ?=
 =?utf-8?Q?m46UxXAIJhev9wfk=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nxJj27ELqxWf//PDVm8j828uc6FJIhueiLmJZyaujw44feeCeLjH9LpE151ZjwK+iy0lMcH0FJBnkrDJYxG8d7SKuHSAKC5MVCnERHpCf02wE9njvqkjzkXPnmmdAR9027XW7Z+UH7Y0iMQZVtyJ5YMr+wWp9IVVPibwfUcSz/nW1DZ0Wl47IVyF2CAzwr/UdnFZURaoE+O2Jk19ec6tnlfdtW+dadIdrjrRobs1fZZDMoZ8w2tbrSg2uq73boYf8CttJAFWpxgyG55mkobiQGwYvzulNEc6iMu34frv+I+SCaAFHFg3kAPZ6c1fxoTiN5ewpB0lprp1Y9UzvL4LCA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b74ae91-6f54-4805-1084-08dee6926843
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 19:09:22.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzbcS9vH4cQsaxIdvdE35o/2qjNsUTxozoU/11xpFuXf9FlYkgEy/A/zpFmdXX3f562+13HdjCGxwXy6pPgTn4NLx4ZvF/IvdJxnXGjenZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8691
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lF0AZtFurvf_RfhBtxJLu5v7pfc4yWNuffNgny7nqAs_1784574566
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiANCj4gW0hpZ2hdDQo+IE5vdyB0aGF0IG9hX3RjNl9wcmNzX3J4X2ZyYW1lX2VuZCgpIHJldHVy
bnMgaW50IChhbmQgY2FuIHJldHVybiAtRUFHQUlODQo+IHZpYSBvYV90YzZfdXBkYXRlX3J4X3Nr
YigpIHdoZW4gdGFpbCArIHNpemUgPiBlbmQpLCBzaG91bGQgdGhlDQo+ICJwcmV2aW91cyByeCBm
cmFtZSBlbmQgKyBuZXh0IHJ4IGZyYW1lIHN0YXJ0IiBicmFuY2ggYWxzbyBvYnNlcnZlIHRoZQ0K
PiByZXR1cm4gdmFsdWU/IFRoYXQgYnJhbmNoIGlzIG5vdCBzaG93biBpbiB0aGUgZGlmZiwgYnV0
IGluIHRoZQ0KPiByZXN1bHRpbmcgZmlsZSBpdCByZWFkczoNCj4gDQo+IGlmIChzdGFydF92YWxp
ZCAmJiBlbmRfdmFsaWQgJiYgc3RhcnRfYnl0ZV9vZmZzZXQgPiBlbmRfYnl0ZV9vZmZzZXQpIHsN
Cg0KDQpBbmRldyBhbmQgb3RoZXJzLA0KDQpJIGRvbid0IGtub3cgd2h5IG15IHYzIHN1Ym1pc3Np
b24gaXMgdW5kZXIgIkFyY2hpdmVkIiBmbGFnLiAic3RhdGUiIGlzIHN0aWxsIG5ldyBhbmQgSSB3
YXMgd2FpdGluZw0KZm9yIGl0IHRvIG1vdmUgdG8gIkNoYW5nZSByZXF1ZXN0ZWQiIGJlZm9yZSBz
dWJtaXR0aW5nIHRoZSBuZXh0IHBhdGNoIHNldC4gTWF5IGJlIG15IHVuZGVyc3RhbmRpbmcNCmlz
IHdyb25nLiAgSG9wZSBJIGNhbiBzdWJtaXQgdGhlIGZvbGxvd2luZyBwYXRjaC4gDQoNCkZZSToN
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvbGlzdC8/c2Vy
aWVzPSZzdWJtaXR0ZXI9cmFqYWdvcGFsJnN0YXRlPSZxPSZhcmNoaXZlPXRydWUmZGVsZWdhdGU9
DQoNClNpbmNlcmVseQ0KU2VsdmENCg0KDQoNCg0K

