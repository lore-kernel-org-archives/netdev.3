Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753F48C3E9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635810; cv=none; b=KbGIPthKWEP0VoOvkILREgwkoRABhAD9JV1u5UJcUDISZjRyLL88xURDsnGX354+nJ1bOMPhdNF8KaUbUPWXLuwR9DIFYaGkqw2Xi9C/s5TdVAyeG1b9yuYJCLbWyqploGwCr+oUQNSzpTOmnDpuKxstrAOtECyvISfVPLL5An0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635810; c=relaxed/simple;
	bh=1XdYZ8IKYtizx4tm/2dKLQh/yB3b4MF3jWH/5AN37gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ekcfwCTQKeKNV4DKi2nolcbJ52zmQG+slxzPVUGMOK6QDbxs0JG1I/Y2eczjAa0pYCYwQJcqtEg/KCP8mIfsSQB/6ayGyN5LIBYZVtY/FlBoYStoB620A8QAdxgEuFm2v4Yy8aKzOAwgPZJnDLsM0bDgyObcblFKr9lloYDJYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Zb25q6JG; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Zb25q6JG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1790635807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XdYZ8IKYtizx4tm/2dKLQh/yB3b4MF3jWH/5AN37gU=;
	b=Zb25q6JG6Rc9XfHK8eejrRTfNiSpKEmIx4kpPNja/iBNwrLguOC56/kzQf9RskF3dAAiS4
	7QYVi0L2aYZWsxviSWxH0VRb973hpF36GBkQKWYrBufh2RcBPPsT/2319C8TfmLhie8B38
	Em3+P9wFjBUEYuEzA4nQA6eJgjRYg+4Fc7mZBqhH//pOz333FQ0Z7zmaQGb6kHTh+URbPZ
	CCinpvbWPcW+/UMJx5SJDn9yfd44uSzNVDzLNmH/rzNuuTlXtxT39eO1nJtxHYGi0L+UJQ
	oPDwcOKiRMcR/qhk60eEK3qlKHzFGUfP9/L39mDZs3DOh9lJnJunKYGlIN37eQ==
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-63-M1woYulpMze6a-PkMp8LUQ-1; Mon, 28 Sep 2026 15:50:04 -0700
X-MC-Unique: M1woYulpMze6a-PkMp8LUQ-1
X-Mimecast-MFC-AGG-ID: M1woYulpMze6a-PkMp8LUQ_1790635802
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by SJ0PR02MB7743.namprd02.prod.outlook.com (2603:10b6:a03:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 22:50:01 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 22:50:01 +0000
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
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v8 07/11] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
Thread-Topic: [PATCH net-next v8 07/11] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
Thread-Index: AQHdT5hH4t1huW7wAUedG4YUiiG99rbkl1fw
Date: Mon, 28 Sep 2026 22:50:00 +0000
Message-ID: <CH0PR02MB78673D8A3CF809B016983DAC838D2@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-7-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-7-7e011aacc309@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|SJ0PR02MB7743:EE_
x-ms-office365-filtering-correlation-id: a23919d2-d6b4-4379-d940-08df1db2d429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|921020|6133799003|56012099006|18002099003|22082099003|4143699003|38070700021
x-microsoft-antispam-message-info: AawceS7FrI10U/kJ7DAesQM60Wh06RvW461mVmSFAUrPW73z3qB+J0QboP+BVUAwrBjsPyl6F4oLMMuawPxqxyfB1YdWNqZO8OW/hJ/5GjZapy1fBlGxTyvZyHJxa317iBXG/j9fPg/qJ/k6UpnzzFJY2rx/NDcc99svYn0x90rugPtihD0y2p4P951ryIaMmgg1ySqDqcVfov9FsDP+2idFfmyisS7ovWkDCdvJUPr57ispw0ORgCDlHwPFDltIsb3Idpzgoi42qWvs1L15Bg5fnyzpkL2QO152Y9oxgJ1p8xpDXJ0kSEWdePmp2kfJQrk1EiMck3lQB9GR9Yu3JDIkiSPnrrqhoTSgymoJs5CSX/qkQclhScU1f94lBKmamoWau9hptIKDUKneHV1mDGH8tG01WSa3SNawr9aFgMw8M4qOfm/N//1m2IqGskoFdq/QfvZmzrshGHkHAevm+qTWXiSga3XsUgrEoHPVhlQLUJ1GIEyveYCV7QlMIzJFo9scn698X/xGXQLUrA/3JPcDxOGvl88NmtCosMFlKAx0D2mdGQWqVqlHxfHHITegLikun/zyD6a2x6gS/u7BClGkGvHG6LUiC0V7zV1gLC8JeGA6Um3ZB5otmzWBg9HUiSJSTgJDIpTV43cAGl0/5bqWT2cb9qTMEbY6/7LnKzK4sBhdHvSR5zwQ4JkLR78vkB+1RZMeIiWQfzp92KjWnWKdv4qbatgENYWl7cVYXqVVrzOgaCpRksrb3I2HKP50
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(921020)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDJyREZVVmlESlFmNnZDVWFoZXFaNmI1a1ZPL3o2alg1dUpiRU00SnZKdXJN?=
 =?utf-8?B?cW5jZVRDV3QvSmk1RFFIaUQ5NFZwbGxUMnVUaG90cEpOelBPZGFuOGErTWRp?=
 =?utf-8?B?ejBpdVhhRUpQZlY5dHlOc2VVcmsyOU1DUWlCdXZHSmpndWhmWUtlYTJKdmcr?=
 =?utf-8?B?L01YblFmNGd0MGVFeFhuTU5DUkR3L1pGWDVNYnlyaXIrejNnOFo3TWgzMm1O?=
 =?utf-8?B?MVEzeUlmVVRraitUL01QZ0VMdXJXeFN0K2haUVhTc0g3bVZKblJHc05FTG5v?=
 =?utf-8?B?M0JFcVp6cU1uSHJzNVlIWi9jUDhQUld0YmhtN2ZnUWJNZDl5cGhjZ3JSU1NO?=
 =?utf-8?B?UkJrK3FUS2VQbitaQUNVMnNXellObGhRRnNpOU5rdENOTWR3cHhGVE03TEQ3?=
 =?utf-8?B?QVZteTZVQTVFSnlRL2JBa29saTNhSnUwVE1UUFFLRzY1N1B6UGxQbW8yZ1Vi?=
 =?utf-8?B?WmQ4K1JUQ0pzanhrVEdRUGY5a05aWWRqZVJydjBhTE83ZklVT3k0WFZNZTl1?=
 =?utf-8?B?YURIWEtVSGl5NWxKMWFGR0xpZWJJakY0dWNPRno5U0l6cGNFb1BLWDFjV0Vz?=
 =?utf-8?B?RldNZVhQdTFLWitDQSszR3M2Nmk2TE9SQ3lzMVZHNzBWWWJFelhJTGZUN0FV?=
 =?utf-8?B?M1pvcDhnZUhPK1ZSOVBtRVpxMkJZL3FxNzZ5TnFXVHRNNEw0anRIT1hQNE9k?=
 =?utf-8?B?bUQvRDJRY3VqM2EycG1Nc040SnBhdXFwKzNEUmIrUExQU3drRjZ3ZGoyUGdl?=
 =?utf-8?B?UlVzc2RLeXdVeXpMbGYvYlFHZ0VlUFFzRmExajZRaXNKV1ViK3d4NE1kdWpG?=
 =?utf-8?B?TXV3cndvS2tlRGN0NFRZL1VZWTVpYmlvdm05amVzR00xYlptb2puNUdsMlFQ?=
 =?utf-8?B?aklrUndMVWRFZ3BqWEVKbVJhTE1UeVdESVJ3SUxzSGVUc1FxakNYVjhIclZl?=
 =?utf-8?B?d21hYUE4VWRwOWZicFdONm9heXEzR2Y2WVJiZTdWYVBEejRiZDJkQnVTdk0z?=
 =?utf-8?B?OXBtZ053TllMRHo3UE9rSnp2VGxZUmZTdDlUOUtLa2tib28xM3FNTGJlOUho?=
 =?utf-8?B?TEpKbzZERlloQWI3a3h5dmlMSmI2TmRiQ292WmJzc3ZPYXN5VUtNMng5cjVp?=
 =?utf-8?B?SGthRTdZdTBDVjZVc1JpcEtOUm8zTjQxSngrWTYzT3hMM3JjRHVBa0JGQ0dT?=
 =?utf-8?B?bXk4ZGwvYkoyejR4UG5xUkx1d2kxMzgxU08zMnllQ0NMc3BHaUhTNTREWHQ0?=
 =?utf-8?B?UjNaWXErdjRMVEFKeGtuZkxzdUQzV09ocnJnV2NHSWxldTJqUUZ5d21mMEFY?=
 =?utf-8?B?RWpKWmhqZmUxNjFxaUdNWnA0M0o0YldhZE1Eeml1UVJ0Nld0L2FJdUZaU1c2?=
 =?utf-8?B?S09BeW9Nc2ZGd3BQenNiTEVTRDhBalN4eUpvSk9WVU9EblJTUGg5anAxQjFm?=
 =?utf-8?B?S09aQVJwVnY3UG94ZllNbHljKy9wRC9RbElFY0QrbU9TT05tdkdhVjZlYkJy?=
 =?utf-8?B?Rk1FR0NTNWk1c1lJVENjWkswcmVZQnpXdkV3L01DZCtsQkZ4N0ZCRU5iNTNL?=
 =?utf-8?B?NkZHUjdJV2QxVm9xNnZIK2hDTHRXT0FRSC9hUVBSTXhuZW9KclhrbTF2YjVM?=
 =?utf-8?B?UGoraVlmSU1JSGxBalpuYXIwbGQrWlYzQ1IwMExyL3Mxc045bCtvSkt0SE1s?=
 =?utf-8?B?bDB1MlBXWStPazlsem1nMG4wVU9lQWJCMSsxeFNYbnY2empCQzU1TW9OSnJt?=
 =?utf-8?B?R2lmZnFld1BXajhBUDFUUk9WYWFzZHUyOHlxbUo3SDF1NU5DUHloUjduMHV5?=
 =?utf-8?B?Ty9venpYTVhVclcrdzlFUmlhZXIvNmZubGg2S3RyRmtNcjV2cEltMkpEdEll?=
 =?utf-8?B?bENTbXUxQSt0cXQwUXZ5MWJ0NEVMeStEcDYveHMwWnVjZmVrb1hyaDlONVB0?=
 =?utf-8?B?Nm1mZ1l1Zm1UcXUvTTZWQXp6OFpGckR2NUYyY2doUlUvenhxWjF0NG9nRVVD?=
 =?utf-8?B?T2l3SnVpQ1JVdnBlL1p4NDJ5Yk5NWis5YzN0d0Rud2swMk5vS3paUmU2RktB?=
 =?utf-8?B?UHhZRkltYVNGQkE1TGFKZ2QwOE5sUDBpYndJVWRHT2tzNFVpYjk5R2VSbnd5?=
 =?utf-8?B?b0g2bUZVbjhNanp4RGdDeDZnckpLTnZ0RGpoZHNSdEc2eEYvbm5HRXFVWTg2?=
 =?utf-8?B?R2tHK0UzdzJBZXRaVVdFeXBCUkk2OXVhZnkyMlZJalcycTgwNjFFRTBWemlJ?=
 =?utf-8?B?NUM5WERtT0xqL3g4WEI2RFdqRFU3WGo2Wmc4TFFCUThpbDMyRzdVWlhweElv?=
 =?utf-8?B?aUxzd1BNMkp2ZzFFM2Yza09ySkt3dVo0YjA2T1I0RFZ4SER1TENJWW1WZm1n?=
 =?utf-8?Q?7omCGjHxnUobw/CY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ciAMpz/0svXYMZPYOGh2eAgZxa4JatOnJCFifbMaZ5QtzK1eAKsq0DBBx8bVaxR+GlePS53szQaQxOvc+XAVcvwgHcLpl6onE7dR3XUOliY4BhEu9TFJ5TRG9vcNi/zX5fpLimUPRHu+24osA3HLImLHQC8PamK0rLn06pHnQTHJY1wBuNcuOzaloJkDefMceRT+GzWguNmn8irEQite1huFLgcKDqCSnEoJnGsy2s36igeHy+kgCbMc0z+yWuddapkgEgGOryZ+lpdVAZOhLNwi1Zu/fr5LkqpCFUT21lMbSna1H98HY6RQXOvRPLFxZ630mxN9npF5/z2sYdCwJA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23919d2-d6b4-4379-d940-08df1db2d429
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 22:50:01.0216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQo7N2Z/mnxjkU2zdrXVWAdL4VBd0/TjAIRtNE5J1/Htnp7M02TIMGXxG2v/FB3vUcs9wyHEMalZFUGASFkk7onnrO4WAX3XfqTF6lYNGTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7743
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nOuFDj3Ki2EoIwAZWWxknCJ5jHODcG60Wb7Oadu62KU_1790635802
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QW5kcmV3LA0KDQpUaGlua2luZyB0aGF0IEkgZG9uJ3QgbmVlZCB0byByZW1vdmUgIlJldmlld2Vk
IGJ5IiB0YWcgZm9yIG1pbm9yIGNoYW5nZXMsIEkga2VwdCBpdC4NCi5yZWFkX21tZCwgYW5kIHdy
aXRlX21tZCBjYWxsYmFjayB3YXMgY2hhbmdlZCB0byB1c2UgbmV3ZXIgY2FsbHNiYWNrcw0KcmVj
ZW50bHkgaW50cm9kdWNlZCBpbiB0aGUgaW4gdGhlIGtlcm5lbC4NCg0KTGV0IG1lIGtub3cgaWYg
eW91IHdhbnQgbWUgdG8gcmVtb3ZlICJSZXZpZXdlZCBieTogdGFnIGZvciB0aGlzIGNoYW5nZS4N
Cg0KU2luY2VyZWx5DQpTZWx2YQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IFNlbHZhbWFuaSBSYWphZ29wYWwgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK1NlbHZhbWFu
aS5SYWphZ29wYWwub25zZW1pLmNvbUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0
LW5leHQgdjggMDcvMTFdIG5ldDogcGh5OiBuY24yNjAwMDogU3VwcG9ydCBmb3Igb25zZW1pJ3Mg
UzI1MDANCj4gaW50ZXJuYWwgcGh5DQo+IA0KPiANCj4gQWRkaW5nIHN1cHBvcnQgZm9yIGludGVy
bmFsIFBIWSBvZiB0aGUgaW50ZWdyYXRlZA0KPiBtZWRpYSBhY2Nlc3MgY29udHJvbGxlciBTMjUw
MC4gUExDQSB0eCBvcHBvcnR1bml0eSB0aW1lcidzDQo+IGRlZmF1bHQgdmFsdWUgaXMgY29ycmVj
dCBpbiB0aGlzIGRldmljZSwgY29tcGFyZWQgdG8NCj4gdGhlIGN1cnJlbnRseSBzdXBwb3J0ZWQg
UEhZIE5DTjI2MDAwLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVu
bi5jaD4NCj4gU2lnbmVkLW9mZi1ieTogU2VsdmFtYW5pIFJhamFnb3BhbCA8U2VsdmFtYW5pLlJh
amFnb3BhbEBvbnNlbWkuY29tPg0KPiANCj4gLS0tDQo+IGNoYW5nZXMgaW4gdjgNCj4gLSBjaGFu
Z2VzIHRvIHVzZSBuZXdlciBBUEkgZm9yIHJlYWQvd3JpdGVfbW1kIGNhbGxiYWNrDQo+IGNoYW5n
ZXMgaW4gdjcNCj4gLSBObyBjaGFuZ2UNCj4gY2hhbmdlcyBpbiB2Ng0KPiArIC5yZWFkX21tZCA9
IGdlbnBoeV9yZWFkX21tZF9jNDUsDQo+ICsgLndyaXRlX21tZCA9IGdlbnBoeV93cml0ZV9tbWRf
YzQ1LA0KDQo=

