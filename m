Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360493FFFAB
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600834; cv=none; b=qX8h/WxXFRoQjX72l8hseUvK8IwZniV+KA+Ss2RIDe0BMUhMZCeG/OusXNA5gywR/UqlNNuqQxT80DTSsFzw65cBdmE8crSei8mWW9yv5Cq/dciq/g0m1c4VRJy0KCf7EsnxyastCH4v+iItlM92a68sOZ8wamAXjXSbWpQbeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600834; c=relaxed/simple;
	bh=zHUfKMiMoXbQvZmhEA21FDHchJ/7yJ1FP6dHe6ierTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QP4F1n8yLvISoFxhF9toL2bjXUrTdwi//i0pkeVHB8CHe2J2t8t/1rQIG9A4JEUbGbQlAEdqt+H8GbxW5N7TxstXa9HbeDjpwIkEZ2lmAuW1wOPi2qeZeuU6frL723HyUMYh5fJd+JZ7Wxf+i2xKb5PtYKZjyGL7UUbRvZmKfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=UHVrZjUn; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="UHVrZjUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1784600831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHUfKMiMoXbQvZmhEA21FDHchJ/7yJ1FP6dHe6ierTE=;
	b=UHVrZjUnSVW9rI67NDx/C2zpiMFM5Ci1pqwa5GvSgoerfvWGvIGRRz7SpyxAMNW69C/ScH
	Ire7VIFz05Ig9r03Fmbbmj0pNVhdVtNHIUnHAxJJ/21kkeuTSvlBubTjt6kWpFGpqYWzuE
	zzsRm4XvfVbFf8NV3FGAoyxHoTl9MvLyBksRbR47ywkSbUoWxHgXg5iiVocX5eXpdBFAQw
	knaXyaWUf5914ARKC9QbtVPC3qAL36WG0EiDEm6snxRAiMsPO/+wUBMQSUVZSw+RTdwiL/
	QsAThUfuC9MhCz3baUGAqjWrCSXFfVCJOMHoc2XPWUiOFNiuUTO2PqNayEYqjw==
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-7-cGwY8U17MRq2xsz3MXNUoQ-1; Mon, 20 Jul 2026 19:27:09 -0700
X-MC-Unique: cGwY8U17MRq2xsz3MXNUoQ-1
X-Mimecast-MFC-AGG-ID: cGwY8U17MRq2xsz3MXNUoQ_1784600827
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 SJ0PR02MB7728.namprd02.prod.outlook.com (2603:10b6:a03:324::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:27:05 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 02:27:04 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
CC: Simon Horman <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Topic: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer
 overflow handling
Thread-Index: AQHdDNIEPFihzRID2EWGXn7wp5MuZbZm1NMAgBAGyyCAABiIAIAAYZ1A
Date: Tue, 21 Jul 2026 02:27:04 +0000
Message-ID: <DM5PR02MB33694B53700F25B78E40E65683C22@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
 <20260710142019.1619159-1-horms@kernel.org>
 <DM5PR02MB33693344BE338A70BC70FDD283C32@DM5PR02MB3369.namprd02.prod.outlook.com>
 <b86c8bff-6f78-42c6-8de9-ae280df5c18b@lunn.ch>
In-Reply-To: <b86c8bff-6f78-42c6-8de9-ae280df5c18b@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|SJ0PR02MB7728:EE_
x-ms-office365-filtering-correlation-id: 51008b2b-6bcb-4d06-0b91-08dee6cf8ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003
x-microsoft-antispam-message-info: tEtkOmpUqpt2zdYgKqrRgsVZ2VAjQosCvxlla+5an0NCPFPQKqrmBKzC1ptMAIM3XXQtuu+T0jTGAFo+QlhPSjGY6isSaQ5QqE0gnVSZodo2RwNgQ3y1SVrXv3CDyLrdsaxSViRrqIngOT9gmPphV8dFf0RTOHSut0PVGLb0LIcAuQmn331ICpEAbAqL0xYFeYMcWTzr22pJfHVCzSxmEPxC7uNDp/l8+Fv7HLFHTtGbIIoHzyP1c2ndagdJRVWV7/kC3Mp3DfqcIi7rmqztBWqr6PL9vmxCz6mD2QQTsldF9CzARqHcDdCrlWXXPjJ2smr+5ZyJ70Y4fMndUe1EP+7LQmiHi1BIEBBhgk/CMsKGusVqhMEiBzr1ve2QhMvdvIKoalPpWDRS9fGCXj6FYLBbdkbXhad07idpi29pfnY+hzwS4YBRnSR0tzLB+8VS12zXKJXSmRZnLV01gFdOUi20HCd1TyvvMkkcGUdQ50doRq/6a1+cuXe3zIpfTs8y4kjhc8YJcAdDxvr9qXcs7iOiudnEDezUwVqi6IAwi13lInzPZcjABAFCV6ebqnF6jtyzqb8ECmlCTMEFopzNlyBL9v0tupF44a8eMRHYQkjs9PNec0fCpj+BIVqvDRVp/Pu78K3RqEsv6WoLMZ5GDfjZlFMBRRzwklpizVMQc6b1QQW2XvRyeZF3i7qbhF047BouKnaDIZWbcdGKPWkWBPGU/qt9xTNUKlldDgUrSqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWE3WGlDcWczZUl3VkgrN0VDTlZJblVRcU5ZNHFTcTdVYUQ0bXNFenl2dkdW?=
 =?utf-8?B?eU11aFA5NS9QQlBwUTRxVGo2cHNhV2Myd1NmOGNlRXZrOVMvdmFDdzM0RGtV?=
 =?utf-8?B?NmhpTDc3ZVZlTXpQanpiTkYrc1d1K2hVN2lIR0hYdEVOSWVwaVpLMEFVQUNh?=
 =?utf-8?B?blA0bWZJZGxVV1NpRElmZEpqMU5reEpLOXpMRUZiODRHTFdrbGVPWVlFVW4y?=
 =?utf-8?B?N2dxSWI3UWJwR1pJVnJYMHhKSkJmekY5c0p6S0xJdDFFVVNjdy9ZMUN5NHJB?=
 =?utf-8?B?UmNGb3ZrZlZZbkt1cHhPTkxJWmdNNlFwaVRleDE1YUVDNjhhekZaT2tTRGVD?=
 =?utf-8?B?MCtTelZYVG1QWWNTbUlic2lyTXFYdCtnTVB4dVhzM1o2bm0zYmNFbUM1Y0tU?=
 =?utf-8?B?bXIrMkdadk1JakZKamd6VzlGMWJVL0o5emQvelJ3N0dtWnN0dnVjakZwK251?=
 =?utf-8?B?TmNmelFIcFdrMkJaQ1ZDVXA0UnBCdHExb2lhcTN2YkU4SUJZYnJpakc5KzlX?=
 =?utf-8?B?SHlZY2h4M0Nkd1VOZjduczlycEF4MnJOcEgyT2ZSSU5BWW1EWEFQMGM5czl6?=
 =?utf-8?B?Vk1EYnhQMVNzK3lyc1c0bHZtaGxZM29UajdsTzF2b3BFQWwwbGV5KzA0Z241?=
 =?utf-8?B?UHpQSFZnMUtyZ1Y0OHBGOGh2aENFMDZweW5KWitmay8zMks3L285cDFBbnpD?=
 =?utf-8?B?eVFwbkJWRTRLQkJvZFVqbEtZSXV0Y0xnUFdWT2lCN0t1d1RNZzNZZklaaXVF?=
 =?utf-8?B?b2tZVDFnQzlEY3lnSURSaUpRbS9CR2lFVW5lTG9zTzZqeHpXYmhkbXhKbUxh?=
 =?utf-8?B?T1FBN1J2RWM0NmdITkFHbjlyRzhRR0JvMW1WY29WRlVkb3hqTEtiTXFrZCtF?=
 =?utf-8?B?ZU56c21QcDNRZDUzME9hNjVKMjRORHJUdk5LdUVRY3B1a0hsbCtWSkQvdHRR?=
 =?utf-8?B?VDBzc1NFUmcyQkVyMVRBcjJpM2NkZ2JnQTgvOGRXSkdkMjRBMWZxWEhybWkv?=
 =?utf-8?B?NkVBVTh1bVRiSUF2cFdoa2VMR203SUp5SkZnTkpURTdraENDOG9NM0hXM0hn?=
 =?utf-8?B?c0ZyOGVHbGpxM0pWVnRUYkVvSlZpU3JRdVNGR0hVdUZBVnIwd3MxK244aWl4?=
 =?utf-8?B?dGZkYTVtU2RHb3pjT3JQQnovSFZyaVJibGR3cmF4c0dmWXF5RERSRGpURXhY?=
 =?utf-8?B?bGlmUTJ2V2xTbGc2RzErWktHbURNcm1xOERCZnVQeExWdUd6SnpaTi9nY21D?=
 =?utf-8?B?blkxTGs3Y2tsQWVHeEtsUVRvODY4U3FXRjc5ZW1laHQ0QkFXTi8ySUo2L1JW?=
 =?utf-8?B?bjRyL01qNzJKK3QwUS8rUUkyMmhzYlZobTJNQ3U2aFFiSGpCUlVFK25zM09D?=
 =?utf-8?B?eDlMdnUrQTVtdjRxWmJrUU44ODg2K1NxQ0xSODFYTGt4Z3JObEczams4akps?=
 =?utf-8?B?c0JOS1VvTUdOamVxS1UxOVZWRkw0cUhrODNIZkhGOEd1ME5WendIUzcwUk1t?=
 =?utf-8?B?Zjc2MVNwKzNuNklSa0xFdk9SREYzT2doRUxTb0JzQmNSS0RaaDUwM3daTlNx?=
 =?utf-8?B?N2pLc2N6eEYyWWN5YVpvOHNCT0RkeHBERldZbmNMOTVLSngwMThoalViWFQ3?=
 =?utf-8?B?VzdHT3JnK1NiWFc5WEdnaVRRRjZ5ZytwQkRzR2V3alBXLyttR1U5UmE0UXRF?=
 =?utf-8?B?WWVoZGU3UGFlWVI3ZVhINjZab0pxSXM5aWs3QVFESjVZVTNIekg3MXhkbEdE?=
 =?utf-8?B?UmF3d0FMcFNXbVNmRm4wTCtrZUZMOGFzWktacmE2bW9jTkRhTUZxbE5hL3BD?=
 =?utf-8?B?SEFiSDNhR2RSMFBMcmp3STFYTE1LNUZaS3Z4cDVKamlvbk1VMEJFQzRyMC9Y?=
 =?utf-8?B?Y1pyWEUxYWJWekhxUDF6QSs0NmJKcXdxeGphU2ovTXEwKzBkNkVXU1duT0dk?=
 =?utf-8?B?QVFkNFJJQVpNbmxpTWVwMmF2Z0ZVNWNmMlZGTFB1aFd1WGR4SzlmaWVZNlVR?=
 =?utf-8?B?SmhaRURiQ3NzNVlkM21MWmdzOWExc1VBK2tsc3BHS3UyMHFuU0Ywd010MUs2?=
 =?utf-8?B?Ym8yem1YSVJ2dmpVODBjRzVrcU56bHl0aktsRHZXL01zbXpzdWpQKzdLOHA4?=
 =?utf-8?B?c0tVU2RJWUkxZHB5RzFuR2VCQ2FvczlvL21GRVV1dEZJZGxzbktXQzEzbURV?=
 =?utf-8?B?MWZKbjR6NTFoLzVSaUpXS0FZSytlRTMrUmNzREphZWo4WFpQL0RLTVlpdUJo?=
 =?utf-8?B?SlljcGFJTXdBWE9hSDBMODdwRUVOK1c3OU1WY1hDMmhObUcwY2RLaGlJTlZD?=
 =?utf-8?B?elVDNW5jL29HNXhmMHBodHRLeVhka21SdHJqTk4rclVNWGtDelhvNS9xRGR5?=
 =?utf-8?Q?TVkMFyGN8solk9gQ=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FseHesfi1U6WhC+prSgTjBPVuk7Y2gfhsIWuuGV4Hj5vSiYslFj7tsyyn0kaNarKY4s86CRYvcNxxE6NtBllGkV8DQQMDlPqY1VIgCJnWB4L7jXjkQI7+M6r1XAmSf2cxSAqRYAPi/aKvmyOQXU0m7zPORJIbFL/v/gQwJT7zJqa3Z1pnbuURtrWVEvaTtYKwx4GEP+BcNwRiWqWTl+mKk5j/pwv6sn9J03GfJzk7tDwPrj+jjfpfpeQrVj8k8JXUVR8u04TjcOR50Heesr7ik4PBQf1dK9PXo4L215TFM9pWf0sRZBcsBqtT7dp3AnGxWFDjJjhk6s8Ute/H5rMew==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51008b2b-6bcb-4d06-0b91-08dee6cf8ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 02:27:04.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Z4cGx6a+Q6cV0vVmMXuFtEhC/mez7ku62tWx3Yjf+hW01y77tLLdyqNh8Ah5O1KPM1PMUMfDesZAD+gEcS5DJezo0J+DGunQUhA6UKOtJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7728
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AdRLYiV5BvmzvsFC7tg0TochUZeDIvLPKZdcx9tTNQ4_1784600827
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzNdIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjog
SW1wcm92ZW1lbnQgaW4gYnVmZmVyIG92ZXJmbG93DQo+IGhhbmRsaW5nDQo+IA0KPiBZb3Ugc2hv
dWxkIHByb2JhYmx5IHJlcG9zdCBpdC4NCg0KVGhhbmtzLiBJIGhhZCBmb2xsb3ctdXAgb25lIGxp
bmUgY2hhbmdlICsgY29tbWVudHMuIFNvLCBJIHN1Ym1pdHRlZCBuZXdlciB2ZXJzaW9uLg0KDQo+
IA0KPiBUaGUgbGFzdCBjb3VwbGUgb2Ygd2Vla3MgdGhpbmdzIGhhdmUgYmVlbiBmYWxsaW5nIHRo
cm91Z2ggdGhlIGNyYWNrcw0KPiBkdWUgdG8gdmFjYXRpb24gYW5kIGNvbmZlcmVuY2VzLiBSZXZp
ZXdlciB0aW1lIGhhcyBiZWVuIGxpbWl0ZWQuDQo+IA0KPiBJdCBtaWdodCBhbHNvIGhlbHAgaWYg
YWxsIHRoZSBUQzYgZGV2ZWxvcGVycyB3b3JrIHRvZ2V0aGVyIGFuZCByZXZpZXcNCj4gZWFjaCBv
dGhlcnMgcGF0Y2hlcy4gUGF0Y2hzZXQgaGF2aW5nIFJldmlld2VkLWJ5OiBpcyBtb3JlIGxpa2Vs
eSB0bw0KPiBnZXQgYWNjZXB0ZWQgd2l0aG91dCBvbmUgb2YgImJpZyIgcmV2aWV3ZXJzIGxvb2tp
bmcgYXQgaXQuDQoNCkFncmVlIHdpdGggeW91Lg0KDQpQYXJ0aGliYW4sIENpcHJpYW4sDQoNClBs
ZWFzZSBhZGQgeW91ciByZXZpZXcgY29tbWVudHMsIGlmIGFueSwgd2hlbiB5b3UgZmluZCBzb21l
IHRpbWUgYXMgY2hhbmdlcyBhcmUgaW4gY29tbW9uIGNvZGUuDQpodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL2NvdmVyLzIwMjYwNzIwLWZpeC1yYWNlLWNvbmRp
dGlvbi1hbmQtY3Jhc2gtdjQtMC04MjczZTJmMzhhMWZAb25zZW1pLmNvbS8NCg0KPiANCj4gQW5k
cmV3DQoNCg==

