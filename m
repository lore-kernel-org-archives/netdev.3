Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.153.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208923;
	b=2Gb48sckHLu3Rw6D7ckDgKyxLGB6wVf7DFgGnGVcVbz9x6XYfDc4oI8s96uVB1j6Yh1T
	 to0w8CBu3kHvEwe8KqdiEzwB6iETPUzI05zOjMFzetGgr5NDABJmJdrDEGmcn1AGwb0/S
	 fqJVU6QXEUTlsA1Q4nObik4hwiczKx4Dv2Gpq/CPtitw3xcdQM59RmkIcKHO2pJ0+bEb9
	 LVa9Aa31/vfvRC0sPxo+rknvVtfnNVcmMBIEKHijhPcHFiXZyl2Fvk58SdqGBrZfCDW+Y
	 XbIfN6qWFaeoD0IP2jOoRDM5eDs/jGxi03w4tcvJyJHJbbnkN0b6U0kePYQiy+/JnpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208923;
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
	bh=KYPV6wensJpZ0H54sDjKI19wMYHjxgHB0HtbqVPpv58=;
	b=IgytYj3mjKHsUM7qqaTrAOv9wz21ZljMs4By64cUhd5JBu6JD+pv5vAqFmu7Cu2WQqjF
	 Al2EMSWMaqkFFb9u6/gURqBXsqY2VtgqtFbTnFaLStG2E9QZTHh1I9FlAvWizdQSBUNka
	 hSiOJy4fm1cfUmUdZcAlfXezKT7n6rjeD+tculqgrv3zYDSDLnfa79w08AbptW1l4RD7g
	 Qsykjw7eTKCWnw1vYA8oVkcHjMd+eQeDk2+DtAqEG1O1RG5RGmp0Mua6WPBt87rt69WT4
	 Wzg/cdIndYGjN/v+XUnSgqmJDIE++Ayg8n0WwRdbutclbDpYdgOurA6n2FPjc2Js1GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=U4HC1FtR;
	arc=none smtp.remote-ip=170.10.153.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D7606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B0D7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=U4HC1FtR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1794208922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYPV6wensJpZ0H54sDjKI19wMYHjxgHB0HtbqVPpv58=;
	b=U4HC1FtRnEEKCShpWzWxrn4AsaQHPuVLsK+G3zFGdIkMDwrDg39sjIsDE9+IHPC4ur3Zl6
	GHOgoNuldSnsqHWsdlc4/xcqkChCxM4Pdkraej67ODTpYpMUaxC2tmiE732eD54I8tNPvP
	8K6jeWQhwP1V/9dND3cgRZ7iKa9oiQJNVoxh4+yoiQDAC3RLSSw30DG6tfYrCnjwhJoMAA
	JDzxgbRRteCYAzVSS+5mLjE7ckYouAoTtrWL5BoFrpXw57tZmgxAYbCUSJdKDDSPL6k/Yv
	1ThTN6XtxfyGb3NqQ32Xad6lZh27ebhNQTamFU/wZc91Nfg1FgCUZUeWotzwcQ==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-64-1NgwYe-IOoG7hJ3ewe4KTQ-2; Sun,
 08 Nov 2026 23:21:49 -0800
X-MC-Unique: 1NgwYe-IOoG7hJ3ewe4KTQ-2
X-Mimecast-MFC-AGG-ID: 1NgwYe-IOoG7hJ3ewe4KTQ_1794208902
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by LV0PR02MB11136.namprd02.prod.outlook.com (2603:10b6:408:335::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 07:21:40 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 07:21:39 +0000
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
Subject: RE: [PATCH net-next v10 08/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
Thread-Topic: [PATCH net-next v10 08/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
Thread-Index: AQHdbkU7K/ZZSGDp3UW3vWqItWxnR7cjUAmAgAHDs9A=
Date: Mon, 9 Nov 2026 07:21:39 +0000
Message-ID: <CH0PR02MB78677ACDC62782D4F8F5C09E83732@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261106-s2500-mac-phy-support-v10-8-31b5a69b85b7@onsemi.com>
 <179409694139.994134.9808308167935611990@kernel.org>
In-Reply-To: <179409694139.994134.9808308167935611990@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|LV0PR02MB11136:EE_
x-ms-office365-filtering-correlation-id: 8942e273-696c-47b2-531d-08df3e3218f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|10067099003|38070700021|56012099006|4143699003|5023799004|11063799006|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026121527099003|261009223027099003
x-microsoft-antispam-message-info: xnycj0qFseurvIA6i6DqUCocYXHgDd+ni6n/fAyJXwM6IqQJ4GofrxXJe9VKTnKrE6cGFTJ2UOje1bvehHMznoL961MbL6XVvciEFrn7ZfkSAIAXTrKoqWoEXv4JnqQavGsDtMs0DSNZrkZZsSRQfl0jXNTdm64DzlSC1Jq3zEUhsnmhaXEU3hefHXq/VGbP63qNcTtnSc7MicjqpLRD6W/GU/rTRdEl24JHqjAH54HQjCgObpMChVj0muhs6qtoQzSiPmrOaq5t5+A4EdHjKSN5pA8SRc3jn4vt+zfFhDdo+LNL4pjMghwpCHXxCeBMC6/JE7ltideU+NaCuS6YM5ZWF47IfVjruAb433S08dgArulkjpHZ6dKHa+e+70vaSOZDoHH9oe5AAIAGGeme3Up3e8TUphyZN8C59FEyeQmhdHP9eJGe4WPA46M1lL8t44t/3BUKPWT4uFya9CU5Ovc9F2Wy45Y7K50XompWY+mHeKHR9bNkHzdqeaAm3ZioZUyQRneAB8TDQhTPWYKBzIWFrfhC7dv7Pxn38eoxGhu69PRGPNQlV9k+0ohJcRAvSC7QsBHi3ZIrKz8mIm8t1gkQbfeTMoCh4sYFTuy/GDlXxtGWbJHc/nZYMoOP2h1/zKCGIMFXwYuxNQco/Q/5eeeuM7udx9jpeoNGEGCsCBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(10067099003)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDBNWVprRnJ1Z0t5KzFZcm80WDByNC9pdUxaZ2tzYk84S3BMRzYxZldqR0ZR?=
 =?utf-8?B?SUZTVDd0aFNpWTR4b2ZKbUVlZDY5SXlSalB1aEd3VUJjT0N3RWIyUEJKTmZN?=
 =?utf-8?B?LzNYUUVaVWxwQ0xaeXhWbEhJRHFGWU9VK1V1MjhiUE9WRHNpMS8vN0dITThI?=
 =?utf-8?B?cGhyV2ZtR2l0SEVJMjZMdXVnWDQ3Y05PRm0wWmw5OWRrQndRR2VMSDFaKys0?=
 =?utf-8?B?Y0toRHAvTDJKc2czanBPa1FVWUNabXUvT3A0NlF1ZW5kVkNISUg3RHk5Y1ZP?=
 =?utf-8?B?ZFlZb2tSSkR5N0hiZXREQTlWZHFTME50dUo1MUxwb3N6elhRYWZBakxaWXRx?=
 =?utf-8?B?NFBiZUZ4dk9HU1lEdzlOaHV6ZlFxVVNEeXNCM1BZdUhGWlhyVUVENzJpRTFW?=
 =?utf-8?B?bHFqMzhzU3ZuNWhNclB2RGVKeEVrNHJpRng0UHFsb3NNVUxEVGNQU2l1cWtJ?=
 =?utf-8?B?VmhCeGJQQjBzSUd6WjRPR1E0dXhwOXhUZUFSWGV3cmVVOGpJRkxlK0NCc0ZM?=
 =?utf-8?B?WWRkQjRibE0rbUxFcTF5eHJWVmtwdXBuTHdoQ1ZtL3pCbHdMbTdGbEkvSU1t?=
 =?utf-8?B?ekZXQm1aQmpLSDgrbmlwUVR5NFBZUjdhbzhkaU9IK01NMHhQc0s1YmlOU1Zo?=
 =?utf-8?B?UWF1ZmtMV09RaHIzTkdwaU1jekhJVTh3N1NBWndvQkwrUHkrSWZza2VBay8z?=
 =?utf-8?B?b05aQXRXOXZ4WVZ6MjBIdlhQMGFVRXdaTUFONFkvS1k5a1l3UzcxaEZ3U0Ru?=
 =?utf-8?B?YUNUbHUxeExremRKVjJOYWdSR0lFTmRlNVZlNkw3YW5hZHhudndSNlRPMnJa?=
 =?utf-8?B?dU5BcU1uTUVxL016dkh2MFBIeTZtM3dFNVhTZ3UvQm0vSXpEWllKeEJOdE16?=
 =?utf-8?B?SHpjeHd4Y3AwL0liQ2xyWkV6SkFqamVGZVRwaS84SkNyTDlUSm1VcXZla3NE?=
 =?utf-8?B?T2U4TU5KZzd5eExMRHhDSHJBNUFRWUhQYlhKc2VWNmtsVXZHTnBaYXp4aUVN?=
 =?utf-8?B?anB3SmxEc3hOdm1kR3RJRHVNdVF0dnMzcVBMckJwNGpscHB1THlhNkVCWno3?=
 =?utf-8?B?UjNPa0V5dHQ4VHYzWnB6UUkydkJBek9JZEM1MVNMcXY1N3JLZk5ia3dILy9t?=
 =?utf-8?B?dnY4ZGNORHlucjJjZGtmOStFQ3JBQjBmSGlkRU1CUEYxUFBTTWQrNlY4enk5?=
 =?utf-8?B?eTk0ZVZxTE9NUWlNUm1hQ3h6NjlhNEpnVEx5U2NTRnM1TitmU01ZeUxOdjhY?=
 =?utf-8?B?Sk81d2liSGUwVVo5ZW92Z0JVNTRrSCttSWN4WXVKMndzKzdiVlcxbWx5MVlU?=
 =?utf-8?B?N1Z1TFRjTm11SCthZ3lUS1FNbDhXT0dOYTZwQXRxUWJuazY2MmJwckErZkEy?=
 =?utf-8?B?SWR5dFVCbGpEMkJBV2NYM1hUSEFUUWRZem5FQktSWkliZzRvUThuOVZSeUlI?=
 =?utf-8?B?NUU1czVSdXoyYTgwOVVOd0xJV1AzNGE0elB2T2lhMFJ1NGxrNC94RmNYUmZS?=
 =?utf-8?B?VDFBTCtRWjZFUzJxanMvMitRWGNBaE0zTDQwK3AyWFE1Q2t5bVBrQVA4c0Jy?=
 =?utf-8?B?RVJyUEVIRmlzYURHNVYzNWhoZ1RMNEt3dUtrQVllR0xIZW41RWRFcndRZ1dO?=
 =?utf-8?B?TW95WW1zT3JMQnV3SnIrRGQ1OHk5WUNVY25pcHNSRWFhMnFFZXVDZjdKbHU1?=
 =?utf-8?B?dDlWQ1VsbnVZWEh4SnpTNnVYVGNjRnZsOEVSbEZLMHlsK2Z3L29QakU1L1pD?=
 =?utf-8?B?QkoveG1lWnFiek5taERMQzZsd2xuWnVicUtsL1NIcEF1YUxCYSt5RVhkb295?=
 =?utf-8?B?YW1hdXl1TmFkSlRRU1NoVUd5bWFNZ0hNcVhqSjdOcDZ3Um1JdmNycjdISVFV?=
 =?utf-8?B?Smc3YUk2R3FkaXh3SWZKbWkwK1FDZ2V3K29SV0Y0Ri9lRFdGaVRvL2ZMamYr?=
 =?utf-8?B?c2Vwb3J4dlZ0anUvOEhSUUVKd2h4RXBmNlVrdlNuNkgwdm1UU0FWVDNUcEVP?=
 =?utf-8?B?aHpGamFuUzdENVJYWlcyL3lTcEtPaWIxZDU5SWxiR0NKUlRGTHRtQWNOeERP?=
 =?utf-8?B?MEEvS0ZkTlkvWFRVOS9sWTlVQnhheWR5UGJNUHAxK1dHNm9ZWm5sN0NzcEpC?=
 =?utf-8?B?V1NhakJManZDKzd5cVRMRitUdmtSOUs1QlM4Z3ZObXg0TXI2ZkdRVlFxLzFm?=
 =?utf-8?B?RDg3UUVxM3dtTThMbXhGd2RLeUsyNUtGYjUvZExBNHhNMU80ZWRUUlprSlcz?=
 =?utf-8?B?aFJtMFdDRG12OHVOKzgrTENFMjkxY2pjRXlCdnIxeU5KbUxydTVmWXhTRHR0?=
 =?utf-8?B?YjV4bEtndzZjcVNqbm02QlhIcTJBdm5FT1dtaWY1TGNVdDRIN3ZRZz09?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g6d5yi0IVU5H7x8wZwyN1FlywTWJVikJwqH3PKO+gLvO4iP0j8upPDNrvlz9J+xHWfxtiAaLBgimMoTau+YrRPyewIAPH+l9D9DWBOLe8czjMhMJDB05TbHAM1Ie/K2f/6F2CbNz4w8LkB2EpTCbjACd6o5VOakwsXgOwNCBqutKC/O76wwO+WrlTrNSD7ECPRtZ6plMxyUHrQ79W8daRfFtntZATNvcvRVTdoVvtyLDMPlYhiolWRyDV03ZkRWVaTww303UewG0SF8+J1Bwo6z0r6SV4+auXjoPoDSvwkSYIRbDdm3kBLf8d8tE6eI3LHK2iiOYhLllo3RYX/67aQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8942e273-696c-47b2-531d-08df3e3218f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 07:21:39.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Br7FHkL1p/b5Ya+xl5ArBHvFvqHR8uAXHD7d79ma2cSauXM/oOF9Lg8+lp2XLNkKBPkOvMmrV4ljKXTSSLS1WqBSvF7xkPAJwYo1/WJdqPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11136
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9LlVmxxSi6p_qh1wCw4odO404EwHOdUlzwckabEtEaM_1794208902
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBuZXRkZXYtYm90K3Nhc2hpa29A
a2VybmVsLm9yZyA8bmV0ZGV2LWJvdCtzYXNoaWtvQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgdjEwIDA4LzExXSBvbnNlbWk6IHMyNTAwOiBBZGQgZHJpdmVyIHN1
cHBvcnQgZm9yIFMyNTAwDQo+IE1BQy1QSFkNCg0KPiANCj4gPiArIGlmIChlbmRfdmFsaWQgJiYg
ZnJhbWVfZHJvcCkgew0KPiA+ICsgb2FfdGM2X2NsZWFudXBfb25nb2luZ19yeF9za2IodGM2KTsN
Cj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBOb3RoaW5nIGhlcmUgY2hlY2tzIHRjNi0+cXVp
cmtfZmxhZ3MgJiBPQV9UQzZfQ09ORklHX1JYQ1RFIG9yDQo+IHRjNi0+Y3RjX2NhcGFibGUuIERv
ZXNuJ3QgdGhpcyBjaGFuZ2UgUlggYmVoYXZpb3VyIGZvciBldmVyeSBPQSBUQzYNCj4gZHJpdmVy
Pw0KDQpZZXMuIEl0IGRvZXMuIEJ1dCBkcm9wcGluZyBmcmFtZXMgYmFzZWQgb24gRkQgYml0IGlz
IGluIHRoZSBzcGVjaWZpY2F0aW9uLg0KSSBkb24ndCBzZWUgYW55IGlzc3VlIGVuYWJsaW5nIHRo
aXMuIEluIGZhY3QsIGlnbm9yaW5nIHRoaXMgYml0IHdvdWxkIGNhdXNlDQpkcml2ZXIgdG8gcmVj
ZWl2ZSBtYWxmb3JtZWQgb3IgaW52YWxpZCBmcmFtZS4NCg0KSSBmaXhlZCB0aGUgY29tbWl0IG1l
c3NhZ2UgdG8gbWFrZSBpdCBjbGVhcg0KDQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gVGhp
cyBnb3RvIHdhcyBhZGRlZCBlYXJsaWVyIGluIHRoZSBzZXJpZXMsIG5vdCBoZXJlLCBidXQgdGhl
IG5ldw0KPiBjdXQtdGhyb3VnaCBjb2RlIHNpdHMgcmlnaHQgYWZ0ZXIgaXQuIERvZXNuJ3QgdGhp
cyBvb3BzIGlmIHRoZSBTVERDQVANCj4gcmVhZCBmYWlscz8NCg0KWWVzLiBGaXhpbmcgaXQuDQoN
Cj4gDQo+IA0KPiANCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBEb2VzIHRoZSBTMjUwMCBs
YXRjaCBQVFBOU0VDIHdoZW4gUFRQX1NFQyBpcyByZWFkPyBUaGUgb2N0ZXQgc3RhdGlzdGljcw0K
PiByZWdpc3RlcnMgaGF2ZSBhIGNvbW1lbnQgZGVzY3JpYmluZyB0aGlzIGtpbmQgb2YgbGF0Y2hp
bmcsIGJ1dCB0aGUgUFRQDQo+IHRpbWUgcmVnaXN0ZXJzIGhhdmUgbm90aGluZyBzaW1pbGFyLg0K
PiANCj4gV2l0aG91dCBzdWNoIGEgbGF0Y2gsIGEgcmVhZCBuZWFyIGEgc2Vjb25kcyByb2xsb3Zl
ciBjb3VsZCBwYWlyIHRoZSBvbGQNCj4gc2Vjb25kIHdpdGggYSB3cmFwcGVkIG5hbm9zZWNvbmQg
dmFsdWUsIGFuZCBiZSBvZmYgYnkgYWxtb3N0IGEgc2Vjb25kLg0KDQoNCldlIGFyZSBkb2luZyB0
aGUgYmVzdCB3ZSBjb3VsZCBkby4gVGhhdCBpcyByZWFkaW5nIGJvdGggcmVnaXN0ZXJzIGluIGEg
c2luZ2xlIHJlYWQuDQpOb3RoaW5nIHRvIGZpeCBoZXJlLg0KDQoNCj4gPiArIH0NCj4gDQo+IFsg
Li4uIF0NCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciBzMjUwMF9tYWNfc3RhdF9z
dHJpbmdzW11bRVRIX0dTVFJJTkdfTEVOXSA9IHsNCj4gPiArICJyeF9taXNtYXRjaF9kcm9wcyIs
DQo+ID4gK307DQo+ID4gKw0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IElzbid0IHRoaXMg
Y291bnRlciBhbHJlYWR5IGNvdmVyZWQgYnkgdGhlIHN0YW5kYXJkIG5ldGRldiBzdGF0cz8NCg0K
DQpJIGRpZCBjb25zaWRlciB0aGlzLiBUbyB1c2UgdGhlIGV4aXN0aW5nIG1lY2hhbmlzbSwgSSBo
YXZlIHRvIGFkZCBhIHBvbGxpbmcgd29ya2VyDQpqdXN0IHRvIGFjY29tbW9kYXRlIG9uZSBjb3Vu
dGVyLiBCZWNhdXNlIEFQSSBkb2Vzbid0IGFsbG93IGJsb2NraW5nIHR5cGUgU1BJIGNhbGxzIA0K
dG8gZ2F0aGVyIHN0YXRzLlNvIGRlY2lkZWQgdG8ga2VlcCB0aGlzIHdheS4NCg0KPiANCj4gDQo+
IC0tDQo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vbmV0ZGV2LWFpLmJvdHMubGludXgu
ZGV2L3Nhc2hpa28vIy9wYXRjaHNldC8yMDI2MTEwNi1zMjUwMC0NCj4gbWFjLXBoeS1zdXBwb3J0
LXYxMC0wLTMxYjVhNjliODViNyU0MG9uc2VtaS5jb20NCj4gPGh0dHBzOi8vbmV0ZGV2LWFpLmJv
dHMubGludXguZGV2L3Nhc2hpa28vIy9wYXRjaHNldC8yMDI2MTEwNi1zMjUwMC1tYWMtcGh5LXN1
cHBvcnQtdjEwLTAtMzFiNWE2OWI4NWI3JTQwb25zZW1pLmNvbQ0KPiA9bmV0ZGV2LWFpLmJvdHMu
bGludXguZGV2Pg0KDQo=

