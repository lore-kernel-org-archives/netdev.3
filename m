Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793883154;
	b=WZQX2/Uk+Vx6t0dBKAnKb/LBMVqM9MKuSZ+yP/2E/9qCNX91aTyWfVGP08f9uuTw7F+1
	 lw/aFWLzwS9oLGj2JwgXg+0fsUcVV3kgFp+Y4cduVmM2w0tNig4wd7fELhMVljLhhhXAR
	 aFulsL51l0SN7IEYNsKZZMdvE9JrbE4npwCRu+1ohLiHu6Gn3zjbmXUFrl2INi8xUcSO4
	 7Kc9Zn25k7nOqxb2YGYVaGWv0XrQ1MA7pBkkqp6Ax5IhL9TzSSErRrrz9CIloqFm2UuQ4
	 2B3EvgFr56WJvfWUyxyNAdWGIaOmSF9MUNbT7/A5mLbkspri8c/nXmBqlLBNMGBZplw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883154;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EEu8gdvBSSobuthWf9vDZmytQlTrgC5Eaf7WlVEIYDI=;
	b=32XRN1zHU2K8Tr99zPr8knf+kGaWwKB2Xz7nE/RpAg+j+hsKe4mELIV/p/x3bPJoinIy
	 /K9UqZ7AvLuxLxNvFQzEVmrGBsHbC0dCchbpIFMg4852ody+WtCGHgiEbMS/6zGRa+9ko
	 uEt24pOw/whfF+H31ZXqvHNHJ+qSHqDkmH6sFn418zAJZUhrYl/scwLdFRJrvyRP7IYko
	 8xALVhMjpBZ5e9/ManDkDkntAtUhJDyr8HHfBIWpOog/pzzq1KwpVyOaeAnHDDbHYhYhm
	 mWcn+MO6qS//1DDmQwQ2caw1a8txguZca30ltR069WXNKj6vHufaP80BCGTG9Lr54JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	dkim=pass header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=QJEtKQUJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.99
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6043606A326;
	Thu,  5 Nov 2026 12:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6043606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=QJEtKQUJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNHJImOf/uJv6rK5H9R86aei645i0MRljOOMHzBaOVvs4ALsussnewiL75UBl6WbZrnXFxDjTQ8iqfaNhFyVgoLIX1NQ+VsrRdNNKibAuSKCNLCHpoNktpyG4I+eRMUb2Ed2mf2Z8wCygAi/D2qIk3GDivHpZlRG/SiGN9S+QQWB8BNsNNUEieSUqrqyYK8TcHMyhw4eK5NtJPgDq/tAR+B4p3DuJbWW/p9+SQbiACHD90L+R9A2mF+Oz/wm4eHOd3Hsbihz+y/PHsQUvlqpkrL/JK/hvyVHxWrN8iNjdq01S/s82W73dj62oRXI4V2t9u4HYn83CrCE9Mh3rR/2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEu8gdvBSSobuthWf9vDZmytQlTrgC5Eaf7WlVEIYDI=;
 b=zS6lXPUFzE+AkV7aPs1K+81wxZ23XBhHwiii7a6Gs1cfN/2R6FiyKv/w0Nu9OCR8Y5MVeY1WyQ/Odx58acTsVWDyF++WYD5KAm/KOT3fe5xN6fORj0ckVlpP7iKeodnHVZhaue40e8dBy44oMHq5ftU6d2xu6LYtQUcNKCgFC16x2m3Xik9CwAtXrxLoYYip2gAkYuuz80/L7ezTD6PiQuDV51h55Bk0Adfmh18pVEjblAY6U1w2PS92gqgLL/+6ln1wUfMa9hx7BbZseoTon2LDwST+YOw+qnAnypmkwRy7rBbYiu9X7Oq33W0xRmX+Z+OdGGvQWEnweTamKQjzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEu8gdvBSSobuthWf9vDZmytQlTrgC5Eaf7WlVEIYDI=;
 b=QJEtKQUJGmbZdHVJ7nGkJhuO1JtWIqWcsJuARihGpRq0G/PanRZjkm2BIT0qyoTzN6TpcVi73LCPUyLs8mrFZbTSC1PocjdVKpUWe34NXExeM/VCDmJfmDNMzQkdbb0RhE0dknGCmegPp5+P0VboPCPvAcRwW/bjxBBM/298oe8xDqjenpTLH0NupvbvfXwRHIA1oUnDG62qbK+gl+acEtAMBzcrXbLiuP7m+TbAIQQBSxjTIVSDirVB8Jw82R05qNIHKP5ZRvs/0t+OK8giGhjLH7ghgheLM2TG/Trpqe8DLRhKNCbtf4cilTD5v9b1+68qR8aYqdRpfWVgWS06MA==
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB7049.apcprd06.prod.outlook.com (2603:1096:820:120::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 12:52:28 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::9d82:c43a:404:99a9]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::9d82:c43a:404:99a9%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:52:28 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjUgMi83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?Q?net:_ftgmac100:_Add_AST2700_compatible?=
Thread-Topic: [PATCH net-next v5 2/7] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Thread-Index: AQHdbBy8VeqWedFYz0WJb3TdWkN45rcduewAgAE0KGA=
Date: Thu, 5 Nov 2026 12:52:27 +0000
Message-ID:
 <SI2PR06MB5140F4F6B16A568F82F47BC19D772@SI2PR06MB5140.apcprd06.prod.outlook.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-2-44057f4dde75@aspeedtech.com>
 <20261104-prodigious-ara-of-research-05bf65@quoll>
In-Reply-To: <20261104-prodigious-ara-of-research-05bf65@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5140:EE_|KL1PR06MB7049:EE_
x-ms-office365-filtering-correlation-id: 5c39b83f-62bc-46e0-70d0-08df3b3ba5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|7416014|38070700021|261028144727099003|4143699003|261021121427099003|261009223027099003|261022113327099003|56012099006|261102123227099003|261022105027099003|261026140227099003|261021123027099003|261026121527099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info:
 5iZZiMZGQEQ+YqD+13InEte7YcyiorZH3OErRrOLUVlxmzH4/wSPRgbOisOybOjzcbyIIWVl6+wcZqX3DdjduZf2gOBgN0345sXYi8igQ4abkifwsaKV+InkS2H6fTJZSsXlHZ0d9XAqS7dOzvmqrWuMsQmJ1UIC2JGXTC/mnxFnGwgD70sgvyJ++TB+pWOH0+zTZ+LEVNyVgzFCOCYcy2TXLi/8zlfmOfLbtwg2YTRvOz9wVpoFVJBCEF5dIck5dhi5vZjWkkBrEi/9evTNEBoL13n0SHXLgNTzvLPY0w+8jt0AhrbAAjvl4AGozzft6UQva60PhRtibq7GQS3g4t5+Kv+XokroLvWvnKdUsAcOio05ecrQBgQRwkyLzxjY8fgxhc67GI1krItXo+ms0qnMyJ67c277U40RgFwfm2a8ktAJ57AqabA6ckmG2FO+CqoNPPR+/KcyafIXk7MrmTGVkgqWG2GFTTarqxRs8SUXzO1tyoA3fxEK+z9Hnt1yTesum6lpWixCQrEsU+iJxzOQLvgNRtstfx0vYPV3dcSJ0xUgRP/D9LcwQwbP453mukesXu/UcdVJQzZoCq664LLgZiH23Z6BU7Xwm6ZCC3AuSrSrVMMJQ2x1w3qYXQ2uhdiwffItLKi/r63eygdiO35RuCxZJ7hFvqCFejKOYSw9XUzPHb5dbSFLvC90md3IXpSa7NNs1O1iWMU2DHBuEe+xgB/wRiNafTXNwzkzMrI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(7416014)(38070700021)(261028144727099003)(4143699003)(261021121427099003)(261009223027099003)(261022113327099003)(56012099006)(261102123227099003)(261022105027099003)(261026140227099003)(261021123027099003)(261026121527099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0N1cmVyOXdscHF5T2lNOW81bkJkYWQvckRjdGhuZHVROHJJQTE5UVB5QTdO?=
 =?utf-8?B?SlI0NU01QytnN2RKZ3ArYkN2Y2JWQy94S0dGMFVBWGVaMlFXWFFsekI5YTlE?=
 =?utf-8?B?bS9rTHpOSTFWUGwyVkhkT3BsTHl5aUh3SjU2dGloRi9FYVpiZEp3cjVlSHhm?=
 =?utf-8?B?bGRsakIwVE5zbURlN1FZMzRIOFlJZHg4SG1JVmpGUEJQamlkb3hjY2pEeDhu?=
 =?utf-8?B?aDNRUWM3MWJ5NzBLVFpHQWxPemQ1cmo1dm9jd3ZyUmxpOThHVDFqSUorMHA5?=
 =?utf-8?B?Y1NZUmVDejhzWnovQzhxLzlmS2Q0R1k4OEQ4QUNZdEZzdVRibkFRT3UvMnAr?=
 =?utf-8?B?aWdZLzcxUENlRkJXUFpnRU10Umlxb2hiVC91WGEzQmVCa1A5Z3k3V0lYMER3?=
 =?utf-8?B?S1Npc0Jza1lTS0FLWVdWeExXenpIZEpyRTRobzZIZkxhZXJySXFPWUVHdm8y?=
 =?utf-8?B?T0o0NkhSNjF1TmU3MmNJYldGaGNRT1AzRnlVNHRGMGFrVTIva1FxMEUwVnps?=
 =?utf-8?B?Y09hQWM1NVZ6dDlMRFNpc3dkcjFjK2orZnJEaWhVQ25iN3ltcEU2NXBUWkFl?=
 =?utf-8?B?WlVmaitIbVZKVS9CUU5VckE3enk2ZTU5QjU1dFdqUkpGKzErSUJLQVU0YTRC?=
 =?utf-8?B?cVFDMUdvUVhsZDQzOUlkLy9tZ0tNVFNsNXZkeDE3UDlrendkcG5KM3dWdzI1?=
 =?utf-8?B?THFmNjNkN0xnR1QzZjhnY1QyUGJjR1RBeXBucmRQQlZ5OTM5T3Y4bzlpeGMr?=
 =?utf-8?B?RDVYT3BGMSt2MlNsdFhOSFpIbC9VUzNlNkFaekl1Z3grVGlMalhDbnJmYVJB?=
 =?utf-8?B?UzI5djI4ZHFaMTFzeVNRZGJkbXIwNnZxanJ0RHJZdmZwcU9YTmdzamRzZ05P?=
 =?utf-8?B?QWlhU20zK0M0UHY3VEtGeXBzMTFTenZlcHAyc290QWlidDhOaTJkQ2V3WDNJ?=
 =?utf-8?B?TndJTjdEZitiUUhpb2lVUnpnNWtra3F1dW55Nk9VOUphVU5hV00yUjZsWFl5?=
 =?utf-8?B?VEhhUXBQbWJCVzdveTR4SFF6RGM2UnFpVCtIdDFvMVRML2pRYk5VV0VSWXpN?=
 =?utf-8?B?SXNCNzkwMTlTcWZIRXdJRmg3ZmVQYnRDcHhKQnR4YmJ4OVlqSXBxVGw0MEdz?=
 =?utf-8?B?cUxwODJKUU1Za2NKUlpBZGZjTWROcHdrUWIxSHQ4ZjhzbFlhdHIySStyMTVZ?=
 =?utf-8?B?V2k5bUhFRkt1dFVOT3VNVXlOWXhoTnF1SldXQy9wVzV0UFY2MXNTNFRIcE83?=
 =?utf-8?B?bUFTancxQ1FJbHYvUkExb3RvanhTVUg1SFJieVE1N2RFVWU0Sm5OQ1NWY3lu?=
 =?utf-8?B?V3ZoQUF3S2FHMm94VnhUaWRPK2lhYllRSHNreE5OaFBlMmNXRzBXcWtEdjEz?=
 =?utf-8?B?NTBLdXRzWm9Ob3hZQTI0TXY1OVlsZWNZTG54YjRwalc2cFBORjBKQ0xZM3Fv?=
 =?utf-8?B?amExa2xTelJyK0hRR1lyZ3hpM2x1MENPTWtxUmljb0RTSkh6eWVNbElDVVl6?=
 =?utf-8?B?bGVOR0VRWDl5Y1pkQStZcGVrSnFCL2l3YTVkNWQ1RUNuTUQ1NTVOcGt5UXIr?=
 =?utf-8?B?VWtXbjcwZkxrZWNYWkZLRnRVcFhlUHNmRVpJMW1tL3pJbUFFR1dwSXVaNG5y?=
 =?utf-8?B?dEZHdW52YmVVM2Q2NGtoTWpyOFFBenlhNjBvYmlzbERPYkxEa3RTVEpzZkRk?=
 =?utf-8?B?bnVCVFBoM08wVjVtYzRYT2JhN3pDNW53bmoxUUhWSzZDQ05COFpJdEE5VzhW?=
 =?utf-8?B?Z25KQ3NPTkxla3o4L0RmQy9VRjVVSTREYnk2SWZhRnNyT05mWGtYNXA4QjF1?=
 =?utf-8?B?TWM5ZTNRU1ludXVVd3pLYXhScGYvbE9tUi9sRmFOOEx3dFZRNmp4QjJ1U1Z2?=
 =?utf-8?B?MGtzcnhGZmxFSU1hT1E3SngzQTFsYmoybEVnMThjWUxPVjQ3MzNRek9OS3lT?=
 =?utf-8?B?QnNtQ3orMlVETnJ1N3I3TW1BNE9IWE9SeG1tQ29GeDh1WnBRQUpCT3UyRkVj?=
 =?utf-8?B?eWR4SllPUDljRXJlSmN4L1NPRURaNnF0V3ZJRzhBTkpWMXF2RE15ZVNWS3hh?=
 =?utf-8?B?Q3JQbndLTnRRNVFrV0pUekJQaWthdTBKTCt2Q0Rvd2lKb2JNR2QvYUhvZUNQ?=
 =?utf-8?B?NjcwWWR3QkQ4Wng2QXdzMDd1Yk56SXYxdk12YVFDeHd2UTducFl2M1NGT3Bv?=
 =?utf-8?B?MkVUcWJlNFRxcXU5OWNnOTBpVjBLVGNXTWdjVFhIUFJYZHdDOGRPS2ErMGFq?=
 =?utf-8?B?UmpEMEMzVGtaWnFidmt2WXk1MnA5K25oUE1mTzFjeGh4bXErR1hrV284aDJN?=
 =?utf-8?B?QndRcUlIVXkySllDcDFhd3FHekNiMGMvRG9TYnB0ZnlZZ3U2TTRFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZNswxSK7X6DP1i5F32ga7aOLS/2UHdCOYie0KwV21dM/v1MLj4PIfoZWgw0QMN1hTO/39sReZPe4GF/4/f/f/jYn7LSaF2Q8ylppRRYihQ2qrQeEKkj9WMufV/oBd/v/i/z0mltAK5VgjpAo+7oP52H1zenecKYzOGGwU808liOdxf9eBd/FEpZa0+0XWZr29xvE4LL9DRabua4TU5VtTdDjX0fQhakEL8yUTto2UqQmLLx73Ek+XLhZKtf1J6y+YBr1lexE1+BvXfLCpOcYaANTvi50PyUo2oEdS7pamerMzMSafV3ob9dXGKl6nKXR5VsViIYiZgFqN7nZ42BbvQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c39b83f-62bc-46e0-70d0-08df3b3ba5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 12:52:27.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DANRz5IgU9R6iwL7AmoI5meTxED2GwoIejsSdQdfzJhfQ/c64a1tSevRyf0YDWud8GwPci4lawGKpmc6Jo1dxtpaCvmjdIS8a+5+cNzbf58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7049

SGkgS3J6eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IEFkZCBBU1Qy
NzAwIHRvIHRoZSBGVEdNQUMxMDAgY29tcGF0aWJsZSBsaXN0IGFuZCBkb2N1bWVudCB0aGF0IGl0
cw0KPiA+IFJNSUkgUkNMSyBnYXRlIG1hdGNoZXMgdGhlIGVhcmxpZXIgQXNwZWVkIFNvQ3MuIEFs
bG93IHRoZSByZXNldCBsaW5lDQo+ID4gZm9yIEFTVDI3MDAgYXMgaXQgZm9sbG93cyB0aGUgc2Ft
ZSByZXNldCByZXF1aXJlbWVudHMgYXMgQVNUMjYwMC4NCj4gPg0KPiA+IFJlcXVpcmUgInBoeS1t
b2RlIiB0byBiZSBwcmVzZW50IGluIHRoZSBkZXZpY2UgdHJlZSB3aGVuIHRoZSBBU1QyNzAwDQo+
ID4gY29tcGF0aWJsZSBpcyB1c2VkLCBtYXRjaGluZyB0aGUgZHJpdmVyJ3MgcHJvYmUtdGltZSBy
ZXF1aXJlbWVudC4NCj4gPg0KPiA+IEFkZCBhc3BlZWQsYXN0MjcwMC1tYWMgYXMgYSBzdGFuZGFs
b25lIGNvbXBhdGlibGUsIGNvbnNpc3RlbnQgd2l0aCB0aGUNCj4gPiBvdGhlciBBc3BlZWQgY29t
cGF0aWJsZXMuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhA
a2VybmVsLm9yZz4NCj4gDQo+IFlvdXIgcGF0Y2ggY2hhbmdlZCBzdWJzdGFudGlhbGx5LCBzbyBk
cm9wcGluZyB0YWcgd2FzIGFwcHJvcHJpYXRlLg0KPiANCg0KR290IGl0LiBJIHdpbGwgZHJvcCB0
aGlzIGluIG5leHQgdmVyc2lvbi4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphY2t5IENob3UgPGph
Y2t5X2Nob3VAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbCB8IDEyDQo+ID4gKysr
KysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+IGlu
ZGV4IGM4NzBkZDBiZGE3Yi4uMGEzNzZiODQ5YTkxIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdt
YWMxMDAueWFtbA0KPiA+IEBAIC0xNyw2ICsxNyw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAg
ICAgICAtIGFzcGVlZCxhc3QyNDAwLW1hYw0KPiA+ICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUw
MC1tYWMNCj4gPiAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI2MDAtbWFjDQo+ID4gKyAgICAgICAg
ICAtIGFzcGVlZCxhc3QyNzAwLW1hYw0KPiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRl
bXM6IDENCj4gPiBAQCAtMjgsNyArMjksNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgbWluSXRl
bXM6IDENCj4gPiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBNQUMgSVAg
Y2xvY2sNCj4gPiAtICAgICAgLSBkZXNjcmlwdGlvbjogUk1JSSBSQ0xLIGdhdGUgZm9yIEFTVDI1
MDAvMjYwMA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSTUlJIFJDTEsgZ2F0ZSBmb3IgQVNU
MjUwMC8yNjAwLzI3MDANCj4gDQo+IFNvIG5vdCB2YWxpZCBmb3IgMjYwMD8NCj4gDQo+ID4NCj4g
PiAgICByZXNldHM6DQo+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+IEBAIC04MCwxMiArODEsMjEg
QEAgYWxsT2Y6DQo+ID4gICAgICAgICAgICBjb250YWluczoNCj4gPiAgICAgICAgICAgICAgZW51
bToNCj4gPiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1hYw0KPiA+ICsgICAgICAg
ICAgICAgIC0gYXNwZWVkLGFzdDI3MDAtbWFjDQo+ID4gICAgICB0aGVuOg0KPiA+ICAgICAgICBw
cm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgIHJlc2V0czogdHJ1ZQ0KPiA+ICAgICAgZWxzZToNCj4g
PiAgICAgICAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICByZXNldHM6IGZhbHNlDQo+IA0KPiBC
bGFuayBsaW5lIGhlcmUNCj4gDQoNCkFncmVlZC4NCg0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAg
IHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNv
bnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBjb25zdDogYXNwZWVkLGFzdDI3MDAtbWFjDQo+ID4g
KyAgICB0aGVuOg0KPiA+ICsgICAgICByZXF1aXJlZDoNCj4gPiArICAgICAgICAtIHBoeS1tb2Rl
DQo+IA0KPiBQbGVhc2UgY29uc3RyYWluIGNsb2Nrcy4NCj4gDQoNCkkgd2lsbCBhZGQgY29uc3Ry
YWluIGNsb2NrIGluIG5leHQgdmVyc2lvbi4NCg0KLSBpZjoNCiAgICAgIHByb3BlcnRpZXM6DQog
ICAgICAgIGNvbXBhdGlibGU6DQogICAgICAgICAgY29udGFpbnM6DQogICAgICAgICAgICBjb25z
dDogYXNwZWVkLGFzdDI0MDAtbWFjDQogICAgdGhlbjoNCiAgICAgIHByb3BlcnRpZXM6DQogICAg
ICAgIGNsb2NrczoNCiAgICAgICAgICBtYXhJdGVtczogMQ0KICAgICAgICBjbG9jay1uYW1lczoN
CiAgICAgICAgICBtYXhJdGVtczogMQ0KDQogIC0gaWY6DQogICAgICBwcm9wZXJ0aWVzOg0KICAg
ICAgICBjb21wYXRpYmxlOg0KICAgICAgICAgIGNvbnRhaW5zOg0KICAgICAgICAgICAgZW51bToN
CiAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1tYWMNCiAgICAgICAgICAgICAgLSBhc3Bl
ZWQsYXN0MjYwMC1tYWMNCiAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjcwMC1tYWMNCiAgICB0
aGVuOg0KICAgICAgcHJvcGVydGllczoNCiAgICAgICAgY2xvY2tzOg0KICAgICAgICAgIG1pbkl0
ZW1zOiAxDQogICAgICAgICAgbWF4SXRlbXM6IDINCiAgICAgICAgY2xvY2stbmFtZXM6DQogICAg
ICAgICAgbWluSXRlbXM6IDENCiAgICAgICAgICBtYXhJdGVtczogMg0KDQogIC0gaWY6DQogICAg
ICBub3Q6DQogICAgICAgIHByb3BlcnRpZXM6DQogICAgICAgICAgY29tcGF0aWJsZToNCiAgICAg
ICAgICAgIGNvbnRhaW5zOg0KICAgICAgICAgICAgICBlbnVtOg0KICAgICAgICAgICAgICAgIC0g
YXNwZWVkLGFzdDI0MDAtbWFjDQogICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjUwMC1tYWMN
CiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1hYw0KICAgICAgICAgICAgICAgIC0g
YXNwZWVkLGFzdDI3MDAtbWFjDQogICAgdGhlbjoNCiAgICAgIHByb3BlcnRpZXM6DQogICAgICAg
IGNsb2NrczogZmFsc2UNCiAgICAgICAgY2xvY2stbmFtZXM6IGZhbHNlDQoNClRoYW5rcywNCkph
Y2t5DQo=
