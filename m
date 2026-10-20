Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.151.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457853;
	b=sPwJBOAqecSTSQkoJNll0U3kiZTs202hG/r2wHKD7viMAFNmYerR5OUk56T7mvq7er5d
	 x+WRBEk2YJSv3orHIYS/ze9g3m/T3RNy2zbbJ/kzioCwOEZZhPzLMjn96FLmBVCWffHt0
	 n9N1+hm2aiKw0xFxlGXAcB5/mxMUooACrAjtMQWJYUfAHtbqKiGBdPorbZHsch+1VJHTY
	 Rh4TWmMZeNqI0Cf+GIreIndOwzVCjGir+AMdu0nLEoRo+QRP2rJC9UsU8KUpHHjZaJ59d
	 rSMGMtSSafUwDg8h9fxqHkyXGU39tlohRoxZb6ZgSXfYLmY9UaMxcVlRZprjP81w+kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457853;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=lOiqlet3uOrrmuMZMapWRpOu7lB/oI8g3M6fWrK4XN8=;
	b=vqKG9Slq0drMJ4URTA3qXhjOiwOcuBVvqWwye2cqiOObOdRQ82MOFs/nfsKS44aF4yoq
	 ymllyvCRuScKav099t1iEjWN8Cl8sjZPGwXoqU8PnOt414YzQwETFV4ytT+ctnQZ51ArN
	 dQg1+G7AAn2oEVXVWi8tISMO1ueW9/JvgkCQ5NuHFBjm7a/eWeb9rixIkp8oVxMhoSbmk
	 1L6T7U4iGXq6Swx7+bNwFwr4rB4I9J6zmjt+DXwIvqdMPbK8y8pELHz5ecAhxIB7VSD+h
	 bfYYcVp11xClt95cbxPXZw4o8leeNGAkp+MSBrwL/R+34EiGKsKpzyLxEt0D+zLndqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Zhop33il;
	arc=none smtp.remote-ip=170.10.151.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF1606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25FF1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=Zhop33il
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1792457846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOiqlet3uOrrmuMZMapWRpOu7lB/oI8g3M6fWrK4XN8=;
	b=Zhop33ilGTHmg2KLUQRPp3VIVdpwmQ1qJ/G3nbiKQa84u0pIsZXFWD7Wg5qRfxzvCJ1b6m
	DENbv5Kd9zQIcc0fw+gypuOicfrNOygR9TN1w86IUXlrrPYce8/EdNRl39RHIwnc/RSqc1
	6f1kQCua/dX1Uax6oNq8vtbjkalUG2HymSmd35iaFddMVzOiT1FhBzrEN9jDWDmch8wwzI
	gF0tk1Ni9Kd6vwuRNMTrez3mA8CPejdAeeNOkI6LmMwUg+sX1Skgpd1FvvnzT41WO6DU7r
	mqK5yMgcJ37oGQ+8mLrRA246a6tC3x+E9IvyqZgYi5zW5DvtIQyRnaFLAXHc1A==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-43-vHasIbGQO6qBONeh9IcV6A-1; Tue,
 20 Oct 2026 00:57:22 +0000
X-MC-Unique: vHasIbGQO6qBONeh9IcV6A-1
X-Mimecast-MFC-AGG-ID: vHasIbGQO6qBONeh9IcV6A_1792457840
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by DS2PR02MB11236.namprd02.prod.outlook.com (2603:10b6:8:32c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 00:57:17 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 00:57:17 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "piergiorgio.beruto@gmail.com"
	<piergiorgio.beruto@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "jerry.ray@microchip.com"
	<jerry.ray@microchip.com>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v9 09/11] onsemi: s2500: Added selftest support
 to onsemi's S2500 driver
Thread-Topic: [PATCH net-next v9 09/11] onsemi: s2500: Added selftest support
 to onsemi's S2500 driver
Thread-Index: AQHdWBFgo04S+021LU2ZsjCwNg2z/Lb3LkAAgA58LHA=
Date: Tue, 20 Oct 2026 00:57:17 +0000
Message-ID: <CH0PR02MB786716FA81598835B5F7681783672@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261009-s2500-mac-phy-support-v9-9-dcefe1d0bf0d@onsemi.com>
 <179166122477.434549.499211157337170569@kernel.org>
In-Reply-To: <179166122477.434549.499211157337170569@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|DS2PR02MB11236:EE_
x-ms-office365-filtering-correlation-id: 0d06f70a-c664-4a81-4c3f-08df2e451644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003
x-microsoft-antispam-message-info: vrxN1sl2YKnaIgfzvQJFRrGi5t0+sN4/VlQjgHz7fFjXUUe26UO/KhiDz68rte2yx6oIF4ON+4vhmcb0rnDzz7Sz9v7wgQNTCARZobOlXl0XZYxOMaiE5pPmT+ByF/HsXyyAp1wd/4uw54Nsnqs1MWOjyBjlcZHKz0x1+I/llhm/YZ3Bip87CLihZS6SO74fTJOao2jQBZjvllIAi8zMc1qHa15KKZdT5ga+0BzXJmmw1nwr53iTCEZBqQjoJq/8KCl6hSu4U+uqu8aXmWoIUHQLy5ZAiq5IiQAeQ/fX8iKpbLxaboRkSBjYYXpO8Y7nXEpmn33tP4rOMvNd/IV9ojvx5oA4Ce6rgozYqjFnV4y1tw3e00QIZ4Fj2w+37Xb7vdFJgZq9TMW5rOIT/63i+gh6CqpvgE+MEBYZihDCkr0tG7ib58VxN5JAiG02RsLfivJJRsaIF6EnkeMdjnjxn9xckgUDH0VI/Ug+WWMfC4UBdJ7WY+WNJZpx29/QdKDJGtvLBYbTqkhom/oUypYFi9lm51y8uinw1z/GYaVjehW413H4UkuFu2J0fBRousDqVDnVxjIPeKdSi6A63t4cyM7M4uKqipkHAB/xpqF2DNNd9QaLM3zrxGvss/PSoq2G4yaESQhmYEIhbQh0Oc0M2AOqJlfqG1oCMjZVUrYf+VAzpKG0Aq4oF7IAxt4gOFutB0o9sC6jS6kG1ZcdFNthLxxvdQgg3kn8wyLlI64W+p4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm5wVTNuSE1uQTNmekZiTTBVaEN6YWEyL25hZEdPbEZYTmF3N01TU1RJWlI0?=
 =?utf-8?B?THZ5bkJUZ3dUb1FRQkxQc3ZSRU0xa0tmQ2g2YXV5L01wdHl1R3dNYkNIdGxa?=
 =?utf-8?B?ajVmRmczUGZPdWx5NWpjM2pwalRXY2x1OGp1NG1MeDhCWjFyVzNYTlFGMVhF?=
 =?utf-8?B?aWNKZzVWN240VmZkQTJBcEpjVVdaOU1uOWQyRjhvZUR3d1Y5ZU1KQy9yeWRY?=
 =?utf-8?B?TXZFZW1PSXRyYnMweVB6MVhsdnVONG5CeVNDMWphN0h5YzZua2prS1VLU2lo?=
 =?utf-8?B?aXZFYVpGMklFQzZ1UVQxZ0NYYXE4Zmszb2FTUVBGRlNUbmRJa0tLQVhVWUFL?=
 =?utf-8?B?d3RsZ1JWSTNTNzQ3SjQvV1UvRXN0empFYTQvWHZEbFBWMm9KUkE1QnVKZGRI?=
 =?utf-8?B?b0ZMU0RoVEdqWERzMS81eUZEejZJRmdDT2RvUERrOHVPM25tVFJCdmc0Z1hU?=
 =?utf-8?B?RDJFR1h3azlMdFJDTWF0ZGtxcmVNZTYwcUFTR1VYRzMwWEV0WFpJaHVSUTdR?=
 =?utf-8?B?VXBLWXlrUXg1ZmZBRGZFS2hla2FPMnJRVlI3bFBJN0RZcU9MODJzT1pWSzdU?=
 =?utf-8?B?M3MyNWVrMGNVaStnd1MxWUMvYlRaUUVUelZ3QmxvQTJrMThaTVl4OVZWRDYy?=
 =?utf-8?B?VVl1MmNJNisvVTBBUHVJZkpGaDhWaThWKzV2U0FRanNKV2NHYjMwVlJCYnpz?=
 =?utf-8?B?THB4a3gyelpxMVZDblcxREtTc1VxNms3MEphZU5PUlZreDZTb2U4dTdDNTFp?=
 =?utf-8?B?VWNLNTQ4Q0ZoRVF1NFRCZy8wUUV3elA2SHhpOEFBZ211SGxXR1hZcElXODJU?=
 =?utf-8?B?ZkdQNGxTQ2x4cHY4VzlpMFR6TkU0eW9EOTZEY09ZWVVHVXV5ZGFNWjZsL1NV?=
 =?utf-8?B?N3Z6bjduNFg0akVLcnlvVnAyeFRQY3dNOGdGZlJYUkVEWGJKUXh5eVo3bm5U?=
 =?utf-8?B?c0d3bGxnRkxPWkhNb3FObmw4WG5sZFo5ZFdRZ3E3VmNpRUk1bWlJOFFaRWlK?=
 =?utf-8?B?VW05MWZ4bkx1dGY4OXJiM0hvTnRLdEF2Ry9aTnNIb0gvdml4aC9qSVgxc0tx?=
 =?utf-8?B?QXR3aHkwVVk3T3ZuUGxUSWFvQ2dyRmZHLzBMSmY1ZTVlLzJLR1NocjdjaVVR?=
 =?utf-8?B?akV3MnhUbExtWkVZTVBkNGpqYnRUMzlyMUlMQkhoQlFTOUdNOXRrYVZCMU5l?=
 =?utf-8?B?aEttTmhDOVRrZjk5VHNNN0pCVUtURTVpdHN6RVAraGJjRlRXUG9LbmZhS0tu?=
 =?utf-8?B?bG0xblYrQmtHU05NdExoTVJrRHZGT1J1M01YWG1BbnBKNGhvL1B4bmFEOTlD?=
 =?utf-8?B?TVNPVXdqSHg2MTZWR0ZxRjYyNzl5WE5lRXhsUkNac2R5b1NRNVlLN0Ezck1z?=
 =?utf-8?B?VDVzT3dCWjQwcG00eEw4RmNlME56Tm52bml5R2VxYUNYTmJwRnVMOTZFYyta?=
 =?utf-8?B?L3B5aUQwMnBDNXZITHlRQ3ptUWQrMktQREVjVjdSOXk3Q05tejAzcmJaN3NG?=
 =?utf-8?B?KzlFVCtKVzZLNGdoNGdONndEVEg2Sm1Gbnc4NU9SSUpnM2VQVkdreWtDM05B?=
 =?utf-8?B?S09COTNpRURBYm4xN0FaN3NzelRuK1hOaytPZnJJRkNaSzZHd0lhVURiVWtM?=
 =?utf-8?B?cUNMMmxsZkhvaWdXaERIY0l2cGphdTYyaGRLclM0c3FwaUo2QWl0QnRSNFhH?=
 =?utf-8?B?Q0Q0WmUwR2VBU0J5S3dQTXBCSVBod05GTjhpMlVkdTI1Q0VaVXp5L0NKcWpS?=
 =?utf-8?B?M0tRbkYzLzNlSDIreWJCWElCNTdaUWJMWmZZYlhPdUNBWDZHbFpmaFk2SGor?=
 =?utf-8?B?Vm53NlZhREVhRng3eE5vZFJqMkdVTmdPMGlBZVZnRnF1eVRhdTYwNE4reHJk?=
 =?utf-8?B?ZnZ3TCtzUWhOUCtBVmFQcEIwRTJLZ0N5ZHBZc2J1L3EyTjNiWnlMZ0tNWDdU?=
 =?utf-8?B?R3hXWWtsamlsbm5pcjQ4Yk5yMUMyeEdwR01IRU11Z0pNaU5LQnVTRDJSRWhU?=
 =?utf-8?B?Q1p0elcyekcvaFdrL0kzeFhmMGtmTHlGQVZlRC83b0dsRkF2R1N5VmdibjZo?=
 =?utf-8?B?akMrOTlpRDBaWUcwbFZIVmd1dHN0dDB2UTNMaXBMNTdhWHdkZ2cyOW93Y3dD?=
 =?utf-8?B?SXBMWTNqOExMMFBPdlNXWkozYitTbWptLy9ONEhYL3NqQzZNcGs1dDFEZ3BT?=
 =?utf-8?B?dHRnckJ4N0FtWXB2MlRpR3lCMTllbzlvQ25HVWl4SFpmRWNNS3d5b2xpNjR5?=
 =?utf-8?B?eWJBT05NRDQyWnNtdFROUVg2LzNvajlFdDd6TTZIVnEwVFBuU1FXTlAxdmVI?=
 =?utf-8?B?ck4vekNlK3B4Undsc1M4a3N6UUVveDRHRFRBNzZndGM1MTVUckJVMXpBbmRP?=
 =?utf-8?Q?2+sVpfXUFP/WN61M=3D?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: syZzfcHfHPpC7SN7RISckvMJ0PmpyYFnfyQnHIHzK5LPvW3MAB9LH42ur1t3EYWu9aDDeyLl6TxfF5Q041azu/XpyilaymbMk0h80vSTWqAOQQJc4VhnDLy9C4n/KTXLkz3kmaJxh7Ehw6iaYfpqbpph9hLqPJOXei6y34pbn1zN+mg2IK2MC1qLvwgisrUl3KoIij98lrzDUnp9hLgVGUHfl9FvYtf9UtWCibT+k5hQ0RdcsorRSJZtYyvZihcNCr1svRbsQuWGW4EfWlFsQMqKKGVcRsQ1IEiWTXz9E77L9nWupveVOVbuXjXfJpxPh9CyUJX23MbBwlGNOLLuag==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d06f70a-c664-4a81-4c3f-08df2e451644
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 00:57:17.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ux4qYPJkvO86TGu+roNTfbF7DrJH6HooD9qTuVGGoQmRbzR303BGvCekv4rCpluUPeXGDuXhmfZ5mz/S2GnK2+0qVUKlN63ccIrNSjwRUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR02MB11236
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OclILmaWlsrGLFU7QeKUFZUuvOvxevvGWNxUpiuQeNc_1792457840
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbmV0ZGV2LWJvdCtzYXNo
aWtvQGtlcm5lbC5vcmcgPG5ldGRldi1ib3Qrc2FzaGlrb0BrZXJuZWwub3JnPg0KPiBTZW50OiBT
YXR1cmRheSwgT2N0b2JlciAxMCwgMjAyNiAxMjo0MCBQTQ0KPiBUbzogU2VsdmFtYW5pIFJhamFn
b3BhbCA8U2VsdmFtYW5pLlJhamFnb3BhbEBvbnNlbWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIG5ldC1uZXh0IHY5IDA5LzExXSBvbnNlbWk6IHMyNTAwOiBBZGRlZCBzZWxmdGVzdCBzdXBw
b3J0IHRvIG9uc2VtaSdzIFMyNTAwIGRyaXZlcg0KPiANCj4gDQo+IENyaXRpY2FsOiAwIMK3IEhp
Z2g6IDAgwrcgTWVkaXVtOiAxIMK3IExvdzogMA0KPiANCj4gLSBbTWVkaXVtXSBXaGVuIENPTkZJ
R19ORVRfU0VMRlRFU1RTPW4sIHMyNTAwX2dldF9zc2V0X2NvdW50KCkgcmV0dXJucyAwDQo+IGZv
ciBFVEhfU1NfVEVTVCwgYmVjYXVzZSB0aGUgaW5jbHVkZS9uZXQvc2VsZnRlc3RzLmggc3R1YuKA
pg0KPiANCj4gDQo+IENhbiB0aGlzIGNvbmZpZ3VyYXRpb24gYWN0dWFsbHkgYmUgYnVpbHQ/IE5F
VF9TRUxGVEVTVFMgZGVwZW5kcyBvbg0KPiBQSFlMSUIgJiYgSU5FVC4gUzI1MDBfTUFDUEhZIG9u
bHkgdXNlcyBpbXBseSBmb3IgaXQgYW5kIGhhcyBubyBJTkVUDQo+IGRlcGVuZGVuY3k6DQo+IA0K
PiBjb25maWcgUzI1MDBfTUFDUEhZDQo+IHRyaXN0YXRlICJTMjUwMCBzdXBwb3J0Ig0KPiBkZXBl
bmRzIG9uIFNQSQ0KPiBkZXBlbmRzIG9uIFBUUF8xNTg4X0NMT0NLX09QVElPTkFMDQo+IGltcGx5
IE5FVF9TRUxGVEVTVFMNCj4gDQo+IFdpdGggQ09ORklHX0lORVQ9biwgdGhlIGRyaXZlciBjYW4g
YmUgYnVpbHQgd2hpbGUgTkVUX1NFTEZURVNUUz1uLg0KPiANCj4gQSBmZXcgZXhpc3RpbmcgZHJp
dmVycyAoZmVjLCBhZzcxeHgsIGFzaXgsIGxhbjc4eHgsIHNtc2M5NXh4KSBmb2xsb3cNCj4gdGhl
IHNhbWUgcGF0dGVybi4NCj4gDQo+IFdvdWxkIGFueSBvZiB0aGVzZSBmaXhlcyB3b3JrIGhlcmU/
DQoNCg0KVGhvdWdoIHRoaXMgc291bmQgbGlrZSBjb252aW5jaW5nIGFyZ3VtZW50LCBJIGxvb2tl
ZCBhdCBvdGhlciBjb2RlIHRoYXQgdXNlZCAiaW1wbHkgTkVUX1NFTEZURVNUUyINCkl0IGhhcyBu
ZWl0aGVyIElORVQgZGVwZW5kZW5jeSBub3QgaW5pdGlhbGl6aW5nIG5ldF9zZWxmdGVzdCBjYWxs
YmFjayBjb25kaXRpb25hbGx5LiBFdmVuIElmIHdlIHdhbnQgdG8gZml4LA0KSXQgc2hvdWxkIGJl
IGZpeGVkIGluIG90aGVyIHBsYWNlcywgd2hpY2ggd291bGQgZXhwYW5kIHRoZSBzY29wZSBvZiB0
aGlzLiBJIHdvdWxkIHJhdGhlciBub3QgdG8gaW5jb3Jwb3JhdGUNCnRoZSBzdWdnZXN0ZWQgY2hh
bmdlLg0KDQoNCj4gDQo+IC0gcmV0dXJuIC1FT1BOT1RTVVBQIGZvciBFVEhfU1NfVEVTVCB3aGVu
IG5ldF9zZWxmdGVzdF9nZXRfY291bnQoKQ0KPiBpcyAwDQo+IC0gc2V0IC5zZWxmX3Rlc3Qgb25s
eSB1bmRlciBJU19FTkFCTEVEKENPTkZJR19ORVRfU0VMRlRFU1RTKQ0KPiAtIGFkZCBhIGRlcGVu
ZGVuY3kgb24gTkVUX1NFTEZURVNUUywgYW5kIHRoZXJlZm9yZSBvbiBJTkVUDQo+IA0KPiBbIC4u
LiBdDQo+IA0K

