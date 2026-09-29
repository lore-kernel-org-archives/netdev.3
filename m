Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB43D47DA
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695976; cv=none; b=lZ9Qyr9eZ30qQG84kGpqNvlE/3ejdgSmH8MFpjAahqZiOoza8rAToqbfQgmpo8scGmU3S+YsQvpI13E0MIhWplteRqX0m6ct5XSv2l9Qmu1ih+Nuqy1ge4m4Opi1EMv7LWOkrx8E/Z5dc6ajzKzkq0xcGKWJ2AWLYGFcbRa8ttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695976; c=relaxed/simple;
	bh=sLeFLA8GyGIGzop0GUHDZ8IYvvEGGAEwQf2irwyUsL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RGObkz8+A7vZ3b3VA9l+pG1M3tLKbw8RtWMcGEoy8p2lnpwut77iIuhJgSLzYd4rQ6I1rMifc1QPMYIJ1NEO96OeLHtocdfWD6EfP4qmy/dikt29PrB4pfO88C98p5LZLFQK3mpLR0/VMtdhbvUSzIgV5lZv/ys4ZYdcNg7rM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=igjh5/ye; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="igjh5/ye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1790695974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLeFLA8GyGIGzop0GUHDZ8IYvvEGGAEwQf2irwyUsL8=;
	b=igjh5/yetX5XXcV2q2n7sbzbkl0Bq/twkJVJqbgeWSTRkn6ivp/omkxkXFRqYJwBzd/JQn
	6xKkqt53189eG7K9kA1lidG0aCkaO+XOglfZqmBfmOGsk0rfBx3Q3ksvI4E5uJIRsYnUsW
	i5M47Q4mYavd/W6XmJOeEoPQ2WUG75x4yfTXLuQHKaM0Ccq0cM2FxCeXYyw6XnuSHaC1Xy
	4oH8PRsvLbrVpwbgcPmM0d0zkujoOjkLZJW3qOAbPTaMeFgonPXiIiDj/MuR5q0LSN67Bq
	3FSLRy2QFyHpTS4+x0bdvcmNGQlVpsqXjxHJ93Xs1nBZB6fxsgvMez58KRZr+Q==
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-67-GWGPz-cfOp6KxYn4EEKe3Q-2; Tue, 29 Sep 2026 08:32:50 -0700
X-MC-Unique: GWGPz-cfOp6KxYn4EEKe3Q-2
X-Mimecast-MFC-AGG-ID: GWGPz-cfOp6KxYn4EEKe3Q_1790695967
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by EA8PPF6B62805CD.namprd02.prod.outlook.com (2603:10b6:30f:fff5::8cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 15:32:45 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%4]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 15:32:45 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>, Ciprian Regus <ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AQHdUCZLG/LHNk9dPU+RlNy7BUtXj7blrc2A
Date: Tue, 29 Sep 2026 15:32:44 +0000
Message-ID: <CH0PR02MB7867E70B791166AD5FA107A8838C2@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-cade88cf61c2@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-5-cade88cf61c2@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-5-cade88cf61c2@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|EA8PPF6B62805CD:EE_
x-ms-office365-filtering-correlation-id: 558f4a3a-8952-4a5f-7d08-08df1e3ee8b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|38070700021|10067099003|11063799006|56012099006|4143699003|6133799003|921020|18002099003|22082099003
x-microsoft-antispam-message-info: vMrBefLnMT4SHwZ6fC/IAggJ/Brr1yo6IX3o2jC/5r/BhKspJSKltIVZIAexwVTRjXbLfwZyv/TQOOthjzHneLWd/Z5pxsW2OxL/BNzSDODnChsM5A+Hy4QBTXTt8mgPO3BEl7nWloRTdCjfAG2a6l9PEZRXLxGSuJ8ls4u659081YIjIrToPnavseePUIBQ1VsmnXNKtwp6xMRBuEGeq8ynNyu82Eka5NHJzmH16X6DzEotjtM0BW7r70V9eoEZH5YlRxDnnTk2S/YNyZomEtYOCmDFzURIz3RKeWTi8aAJGx1HY0G+19xkCGH1/jYMN4Wxaf1K8MpIod/yjUts1U45b5yFrUc3M0xGfP9ObYLA/fk4sHIzDHEcMODzUdklH6GMkKWso4FRn4M5qET7AEHp68qxfPtgAoQMCqagSkzsIo9a9YMWptjsfyBPB9frz798/u3WQqpm10s77C0t+waFMl5xquOpp1ccA60kJpVzA79WshI5NsVNI1zLxmkBjdXCzwqSrg0bAEJct+J4gkFWVzAXKNeIIcFd10JDQbAREJ6JCtEoN5AGj49STAq+bWQzhT6ugDkde0jEiuhf0ynnIfaYLc1JCJS4mNEzCYsTiII5VAHovLqrj3XdiLJgRlR0o7MH8Y/7znB9GD7KwIgoN4x1rqYfgovfqVX1solnprl1JBIjugMx3X0+zOh2PQquV0g+SsNlIAVLedpEkuCEMNjcgh82bnJZp3P5iei8Dr4IBiJotmf8z2iJXNqI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzlib1Q1M3g5TlBTRnd4akZmNjF5NTFhdlkwWWo4TjdNNDdWaW9mUmo2WnVC?=
 =?utf-8?B?T2MxaENDeG0weVg5Zkg0bFE0TG9zNWpJVlllRmtjSU1reDJ3QkdHM2dxVnZw?=
 =?utf-8?B?MnVZUE9NVWltWHgzQmx2M0hSSVFMRC83MlB3RGlIaU10di9ITjd0S1RtU1dv?=
 =?utf-8?B?OU82UURtNEdjOEtxbnRQbVpHTmw3TlRpM1lBUDl4aVJhVXpWWENnZXRZR1Fx?=
 =?utf-8?B?N0ZzcmJ5bytpbllDRXYzSDVOZWVnL2RZSis1Rm40alRST296RkVyTWdZbDhJ?=
 =?utf-8?B?WWVvMmJKcmg1aitvbU5kWXMzeWFXUXdTU0pkTkhnU2VxRG9xZkJHTEE5Y0pX?=
 =?utf-8?B?czcxbjZrL1RLSXVpUTh4ckVRNDFmayt1VHc2T1JlYXhiSnVZRnkzVFBSODhk?=
 =?utf-8?B?aWxIeENwSW5zSTdTZTFpUWJzcldFYytCZWk2aFJZNzl2TWRLUTdUVlVWVmkz?=
 =?utf-8?B?M2xJQ3dhQ3hiYzE2OUptRysyby9WZkdOWEdDT0xMV2xnaDBQalVaaWVUUWxO?=
 =?utf-8?B?SjlDZTErWGo1dHdZVGk1c0lPUGlXanJaYWliOW14Z2pEcVpkOUVVTmFnMXht?=
 =?utf-8?B?eTRmbllGM3hYZ24xVDJTYVRNUFNCZHhpdC9DMlFUTkU1MGVsUVNYditIK3Va?=
 =?utf-8?B?Y1pIUzB3L2wydXBXdm81OEVLdUpZK1hRR0trbXFZN3V5d3BkcGZsRFE0TGdZ?=
 =?utf-8?B?UkVsZW5ZMTZiaFBwNlpSSkJSWHVHa3dxS1A4MTZJSmZ3SEdxVE1FTkp1Tzcr?=
 =?utf-8?B?TnB1K2N4K2FSL2JPTFBQQnhpZG5vbEN0aEMxMWdJNTBTdnpJTkZnR3QzS0ZJ?=
 =?utf-8?B?SUtoOGpJWDZySGlVUnBhVFd6YUZHS2dTenVsZm5idEltd3lZNEhaZXQ0UVRR?=
 =?utf-8?B?Ull0MDNQNGcvMTN3MExPdFhXSlNvcC9ROUh0VEpQYWhWaUxoVnhBRnE0MEY0?=
 =?utf-8?B?NWp5N1FYS0t5M3Q2TEtZMmtOc0ozdVhMYXQ4WGRCNWdTYzQ5OXp5aUhPcmlj?=
 =?utf-8?B?ei9UNmNmWUNyVmQ1QzZDU1F0eTZXNXNLNStqcGNEYlUxaWo3QlBuMWFHMXp0?=
 =?utf-8?B?djErZ2JhSjg1RUQ3QUp5M1ZDdmtPN0VDcm5uV3ZhbUE4Z28wODBSNHltSXB0?=
 =?utf-8?B?ZVB2aHpiNGJhWnd5MlZ4cXN3OHgyYmlCaS9qOU9UTFl5SjhqVG1FREJHbzln?=
 =?utf-8?B?aWt3SVB6QWJIc0JlOUFacHA1QnJRSDFPOXgyci9wR1BYZUlaNGJBb015L29T?=
 =?utf-8?B?YjZVdVlqcys5dWZoTTR1Sm5xa0ljU3Mxc3diSmQ0aE02S2lYYi9FT1diZDF2?=
 =?utf-8?B?S0JlbW5IUTQybmZsNTRBR1VxaHBHOFlxK3hHYzRDYU5reHZpVmYzdnE4VVl0?=
 =?utf-8?B?UWtGV2taYnZLNlk0T1RtS0taWmk0RmVNQy8vMnUxMmpieEc4RCtha3A0Mndt?=
 =?utf-8?B?RG9BYzZWSXBlN2FtaGRoOGVNNzQ2SHpqSU5TMzByWGphMHZqUzJNaHU0eXFj?=
 =?utf-8?B?QVh6bnhoRGpCbUxMaHFFVEhoWmNVQ2JjTm9QKzM5R0crNDVtYk9NeG1UbmJM?=
 =?utf-8?B?UE92N05JaXZLaWNjUHpHWFpDN0wyeGVRZWN3UjRZOWNiSmhYcU9zcVg5bXVm?=
 =?utf-8?B?OUxaaFRUOW5XR2I5TnlmMU96ek5odHZad1B5Y0prR3oxcXZkMmNmOXg1OFFI?=
 =?utf-8?B?U09qRW82ODFtZjUzbVNUK0xSSVBQeEFiN01RQTIvMmlNUEZRdEJNbTlSMWRK?=
 =?utf-8?B?dUJWcml3NzJ6WVdlcktoZ3ZXcTdHZ3ZHMDRDeUpETllhUnlQMld0bWNRVmhx?=
 =?utf-8?B?cTNwazFGVFQ5M1NGYWFkaDZyMWFzY3R4N1l6U0dJTXlmNmN3alJucWQ1TEEx?=
 =?utf-8?B?UU1JRlFCSnV5dkNxa2JLLzFLbFlWREFtRUJtVmhTb3h1UWdpSzMwVzFvaUE1?=
 =?utf-8?B?cm1KanFpdlpHQlZpNVg0MkJWUFBCTGZWZ1dxK2NQdVJDeVBkWUIvVkJ0eVZ6?=
 =?utf-8?B?bVJydE9JUXo3eWdyalV1Y3Q5dS9HaDNjMzF0UTNjQXE2bHVCQi9jcXYxL2ZT?=
 =?utf-8?B?Z0grbi9YeEM1RDI2R2pqa2Npa3JRaVZsY2d0V0ZZSVZOZ2F3UWFreUhzQ1lL?=
 =?utf-8?B?VDZpdlVTVUlvdFpYUDVhWkRlY1k0LzVMUndEaC9obW1aMmZWK21JampncGtG?=
 =?utf-8?B?OVlLLzNnN21mSEo5WDZ6bm1WL3hTQ2JqMk4zSnNhL2JKbHpwNDRkbDUxY3RB?=
 =?utf-8?B?UC9oMGZhaVN5NngxZEZralh0S3BiL1hyTWNEd1pVbnZKQ29Kd3Q0ZGhZcTBY?=
 =?utf-8?B?RDFlczVUblBlUWkvdVFNakZvQzk3SjZ4MklyUlFiSG5rdWxkY1l2cXZMdUtJ?=
 =?utf-8?Q?7DDsuqJ9BlcHbTyo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OTvxisO9MAxFs2Ocqw0drKEIBUmr+gy/NPcfQOksHLyksJ7zJmpR6X2wKysvQhsmMKe9jz6kM/C9KzzF7XIKQ25f0notovks2nKXHmSYkkA35irLg04b8Ix6ELz0/16jgjSENCtG1jv6q62I3B5JWYnLheop4eTmnwM7/ynLeV56eYo7bta3ITRIYHx4qNrbygvLiaYmuvT0tVX/ocsNPQtsAukqKKhn/th3H5jgkjm/BOZ3lge6+WCMRmpwVO20B7IKdMaubPIuNV6hZ1Gqxr+o+WcZTAI+wVjX7VAtlHvILIRIL+HcDKs5HKnnAQluRy4xjZ9OJliLjsR6qGw4EQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558f4a3a-8952-4a5f-7d08-08df1e3ee8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 15:32:45.0054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kzNs+1IKz4CA0NwP2okAYiGvOl781J57GIzw50Adm98y2GhPfaYXDvPngDml9sPd7pUhP87Y8PA2Seeh0wkdTqZP7Z5sEJ+YiL6fLwDouOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF6B62805CD
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IliBJuzXbPKHC2sM5sjTm6HCraM_Mu8vCeaUtZ2e9Ew_1790695967
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QWRkaW5nIEFuYWxvZydzIGVuZ2luZWVyIHRvIHRoZSBjYyBsaXN0IGFzIGFkaS9LY29uZmlnIGlz
IGNoYW5nZWQgYW5kIC0tYXV0by10by1jYyBvcHRpb24gbWlzc2VkIGl0LiANCg0KU2luY2VyZWx5
DQpTZWx2YQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlbHZhbWFu
aSBSYWphZ29wYWwgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK1NlbHZhbWFuaS5SYWphZ29wYWwu
b25zZW1pLmNvbUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0LW5leHQgdjggMDUv
MTFdIG5ldDogZXRoZXJuZXQ6IG9hX3RjNjogU3VwcG9ydCBmb3IgaGFyZHdhcmUNCj4gdGltZXN0
YW1wDQo+IA0KPiAtLS0NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9h
ZGkvS2NvbmZpZyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FkaS9LY29uZmlnDQo+IGluZGV4IGJk
YjhmZjdkMTVkYS4uMTIwYTUyZTZiMjgzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9hZGkvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hZGkvS2NvbmZp
Zw0KPiBAQCAtMjksNiArMjksNyBAQCBjb25maWcgQURJTjExMTANCj4gY29uZmlnIEFESU4xMTQw
DQo+IHRyaXN0YXRlICJBbmFsb2cgRGV2aWNlcyBBRElOMTE0MCBNQUMtUEhZIg0KPiBkZXBlbmRz
IG9uIFNQSQ0KPiArIGRlcGVuZHMgb24gUFRQXzE1ODhfQ0xPQ0tfT1BUSU9OQUwNCj4gc2VsZWN0
IEFESU4xMTQwX1BIWQ0KPiBzZWxlY3QgT0FfVEM2DQo+IGhlbHANCg0K

