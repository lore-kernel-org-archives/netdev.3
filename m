Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09449E5EA
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303564; cv=none; b=lJEDCzUhL3tp5oymGGpHTLof/rSv3vu7U0/dXNoFb3ZEVYPOF5dm14Rv/MFOBUwshi3gx1Ac+VFMNaZUkyMyCP7OLpjLhRnybjMFq/uKGriwsRwlKcS/hGdkiYWfjYH/J+u0Tv+5NsulmMyclHv4B0L1+P4DU0oyEpMFEgUjEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303564; c=relaxed/simple;
	bh=PkYnh8S1VT72APbM7Ysdv494MtCKfko0DMCtusVqUfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VaqHC9AEgLHuJZwtj34Oqmi7dSyeUuB5Qy0Alt7cYURRbE3CXs03nObHWxgI3efcojj+2Vvl9jHTnxHNjP6GBA8RUfM7qT3gCFki0ImIxBf8Ja1seq8wh51of+r3PRFaV6S7xEzwQo6MrgyQ7nHgg+0Okpn9PWa+YnqEgd8uVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=YSYUOjz9; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="YSYUOjz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1791303556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkYnh8S1VT72APbM7Ysdv494MtCKfko0DMCtusVqUfk=;
	b=YSYUOjz9xldtbFnNDHkXq0SPh0PtaamQxwuJM7hVc7sSosqxxhJVbig5w/pCd+iXl6ppoj
	AG5vmwPs9kBHzL9eBqL7aRXYWvkwwwQwvlzQPjh7zG0YHuovSkLiV6d/IiccOSgf1HcN8F
	I2S8H2eSiszrDgzCEffACFyrDXVNiaUTGtd/9UrzC2MhgCiXOMvwNgL+nu6h9Afh5VTtBX
	L9jvAxZmDYBjIsN+C7aF5m7ktOudDaCyYunDXTPmDf/Owi9ZX35nc/jVbOnneI1brpy5gB
	w2LGTluoxaFKJWmD3wqe2nBfS5BpVZym0GF+vp96JWpKxAd+L11wue/5Ro8bYA==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-53-jcGMHVPTPBOGvS_JckhiZQ-1; Tue,
 06 Oct 2026 09:19:12 -0700
X-MC-Unique: jcGMHVPTPBOGvS_JckhiZQ-1
X-Mimecast-MFC-AGG-ID: jcGMHVPTPBOGvS_JckhiZQ_1791303548
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by SA0PR02MB7114.namprd02.prod.outlook.com (2603:10b6:806:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 16:19:07 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 16:19:06 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Jakub Kicinski <kuba@kernel.org>, Selvamani Rajagopal via B4 Relay
	<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AQHdUCZK/42vAQikQEyQnWutx/ewbbbvvicAgAD+CiA=
Date: Tue, 6 Oct 2026 16:19:06 +0000
Message-ID: <CH0PR02MB78678AF6F2018A8E443E2B9183952@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
	<20260928-s2500-mac-phy-support-v8-5-7e011aacc309@onsemi.com>
 <20261005180842.66ea6c93@kernel.org>
In-Reply-To: <20261005180842.66ea6c93@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|SA0PR02MB7114:EE_
x-ms-office365-filtering-correlation-id: 67effc68-c7a8-4bb8-2fbc-08df23c58ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|38070700021|4143699003|11063799006|10067099003|56012099006
x-microsoft-antispam-message-info: 9g2uLbuA101+rtt2vOwiH3ziTBnE0vlNY9Ax2R9SEgwJSAWV6Rx6MdpiH1PNtJ+OoY2uyUM9/Skj+V1dq77Vesn3twn+t3PnXRjlDaLxfNgNu3kMOVaesN8Rlqowr/lBtyGpNV3KV1pQa3siUhM5T4c/IREs2dlW+/LsJwl4a9r3rI1CIArtQ6SjJdCqto/Pk5JjYy3lzLYVgbXVCp2ytnY3qhv7HWYUyw8WEYU0NOPzZgqGkNiYEIhHcqJWb9MsezjU4lRV7IRtAbpRbqFK2bIjFmvk/bKAZXExYoBiz2hy8EYlfiQRIgIi/d+5RrPTw81D1koJJApQKhqekMIs/zSha6r6bRwqqcxVlDb/BF2wPfSFqzCWZLd5hqE3BwjvsYK3wjxxzR9ZmWcc/jqo/WZTf3IfSADVFVT9RtXIJBgBc+4cXDATBqY/FhrhiOn/mcLEmx+fa81JJo5VT3thNMgz7TiK8FyAsU9dYd8KaxWlG1ADx3vJx7HNkwjbhFTnqPehSSisySg4W/7n3m/aQrl2Cd3buCilWVmUd/btWff2TP4IMxJs7i39jTkeijZZy+5BVOo8KaCWNtcJE2X6JE18VH/EOKMSOTtuZLTdlh2rtaTSpFmB4oetg6QJ0xrB3UzfhXYfxbnKssV/iGTV3Ru0dopnutyhPqA7ZbvWCJ8xVtequ4FXBnfDqTP86DMP+kmFniaB6xFxkbfoxGAO8fGPfQJHXAkjS0VQ7xtklSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGk0NC85Sm4vdzg4blRCSk9MY2tYcktlTHc1VGJTM0Y2YkFOM1Q1UkRTY2ov?=
 =?utf-8?B?eXBNVndSaFcvSnIzeXh4cmo4eS8yV25GbmNnaGlSOVgrQTd6NnZKRTUvV3lp?=
 =?utf-8?B?cjl1L0daZGgvYjJWSlBXelBSQTBxc2xlOThLOXo1ZG92NFdGY3hLYUlWWU1Y?=
 =?utf-8?B?bkhxd0FVZlRGZWthVTVoVTUxUk9XQUtLL3U3TG0vNHN3WC9NWmJiVnV1cElW?=
 =?utf-8?B?TG1TeGV0dmVmOVlQbGJCOGhoOEZsVkhXRDB2Z0JUWisvazh4NkdtY2hoZVJn?=
 =?utf-8?B?VXdZK3F5bzRSVG14bFNITDJ6TGpBWWIrc0RYalJiY09nU3ptYVorNGdQa2tB?=
 =?utf-8?B?RnM4U3UvZ0dySUE1Q3RLczE1eU0rUzhDNG91WFpWWkNhekUybFFXWDhZRWhk?=
 =?utf-8?B?Zk5vZitGSU5MNDVKU2RpSmUyeklZZUZyK3J5V2FhVTR2RUtrUlNsWGJEOGlt?=
 =?utf-8?B?ZGQ2MjFOOEdFVW5kVFJXSEcxaSt3M2VHNlF6ZklFTjVlMXZzUUI0Yk1BdkFl?=
 =?utf-8?B?RnJwMGxHZUltTW0vb1RIOXYyOTg2NFhXRC9mMlRLMUp2a3d6Z3JKQ2VFdWlU?=
 =?utf-8?B?YUVZZVNWT3hhMEVUcCtWNWN5OEhCMVlER0ppdWxVNWFRWE1BcWgzQXlRdTZT?=
 =?utf-8?B?czZPRTV4SVc5ZGlKQ014bm1MM3B2NmZ6c1plK21iOUoyMTl3cUswaGJkcThl?=
 =?utf-8?B?SnZ6V2JrbEJTV1Z6bHpPUGFQeVBQeTBGU08yVVVnQm9aT1Vocm5ZZGVQc05Z?=
 =?utf-8?B?Rys2alp5WW9pQXFIaXhZWEFUbzBDRnd2K1hZL2s1NnFvYkpmUnpTbFFHMXRl?=
 =?utf-8?B?OWZBTldCQ3lZY3dtdStobHRsTksxYitELzVOSHJYcXA1SUVpcHlxaXZTV1JI?=
 =?utf-8?B?dkg4d2UzUkJLTzVyR1YyU2NiUEpFSVVzRzNoMExiakpDd3A5eXJaMFNzUVlt?=
 =?utf-8?B?M2NVOU1Walp4cmpCWFpyNEJvL0VDMjhJNjVXbVVYRDdnZWFTL05qMlEyS3RU?=
 =?utf-8?B?b0hoYVdxNlNJWFpBbkRUSDcwdUU1Y3VZZW9KWDhXZ1M5WWw0OFZySytDQ3F6?=
 =?utf-8?B?amVFRWthYXd0OXJDRWxPVnUxd2FXdkxBKzZDZGxkdnB4bTZ2YXBYNm9CcVQ3?=
 =?utf-8?B?bWRiL3VRRTFpNmZHck16NVAzenZ3NlF5VEVTR08vTzVHR0IzVjNjQjdmQ0lF?=
 =?utf-8?B?SlhyNjNwZVNkZGFiUzVqR3dUbG9qZS8xTG56RVdzdXhCd3dDZUMvZFgrM3Mz?=
 =?utf-8?B?VkhZWXhHaUtNbWZLODJsbWRhd1pPa1orT0p2SGN2N1AzZkFVK1VLUUluK2Zl?=
 =?utf-8?B?Mld5NEthcUQ1RDFOdEd1T1EwTVZzRlRGZ0hnY3MrU0t6MmZDYzEzdEswZHVB?=
 =?utf-8?B?eVJ6czJvRm5HZ1AyZXpCR0JhSDZCMTB0OFo2UEtiVGEwc2xVOHF3bGdlQ3RO?=
 =?utf-8?B?ZG4veFM3OVRXWEVEemY3Mmptb0JkV2hWVWlsWW5HRDZPUCtwRUxBK3ZrRkF5?=
 =?utf-8?B?UDAvS1E3b21xMU9KdldrRDZFTmNBYk1HajR5TWhXcDUrekxyRkVHMnNkTVAz?=
 =?utf-8?B?VVR2TndEWkZXRkkyYnF2cGFGc3F3ZVZkTTFFOVdGMlpReFBwNVlhRW9XZHVL?=
 =?utf-8?B?WGNEcWd3N2pkUTRTWS90RU4vbGxiZjM1bUdIWXpzeWlOY3RONWtjQmVyem1J?=
 =?utf-8?B?aU0wTmg0MGQ0RmIwVm40RzF1MHRSUVFiYkFzdGE3NE9MdG9aYWdwWXowemY4?=
 =?utf-8?B?MGg4V0dBblR1bGQrRlovY1N3OGJNZTJjSzlVOUNjQkpUM3NZdmlibERTZUZE?=
 =?utf-8?B?WTdNdDVTa0VkQ3Q2LzM5Y3U0RE83dWh5ZVhMOTlLWHAzTG5wdGI3ZDBFdTBk?=
 =?utf-8?B?MEJpWWhoemdyLzlVVWhjcURpZ3BZZ3FyOHJmWGVxSTd1ZWdmUUFvbld5QkNj?=
 =?utf-8?B?cDBaMGpmV1pIZWFpSzJxUUIvRi9mVFVRc0dreXoyMzFuZVpvRGRoZmRlcWJ4?=
 =?utf-8?B?N0d6YTRJWDBYTk45UUM4ZExIQWZvOWtNM0toTC9uQkJ2QlBxN3R3WDY3bmZR?=
 =?utf-8?B?WDdWNWZDdEtPRVUwYUZmWFY5cXNOZGV1RlNMQ1o3aEtpZUhCTUs4KzJTNGpG?=
 =?utf-8?B?ZlVva2JCRTFUMGpuMVd0Ym96cTNRbzZHSnNGbVNjcXAxUEh3Q2Y3N05IQ0pU?=
 =?utf-8?B?U3JZVkducXdWMytTSzE3S3BFQ2R2Z1laRGV6NWx1NjBTLzlaYmZjcjZ5VW9i?=
 =?utf-8?B?Z1l6aEYxbHNyQi9uKzRNUXVDMkFjaEgxeXhhalVKbHdjbXZONmdwaU5DNWZN?=
 =?utf-8?B?ZzNmTHF5OHVsVGZpUThGNVNQbkZ3dUJwWmdqQUhjRTFOWUozREkrZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3vKBGKGBcaqAJtptUSDkh8cxvbUsGs48lqdssIh29R8fgjXvjoXctH0yVh1GbsMx0VZaZ2xlNMf5kkEiDgiW3yTbuqmY7oHoFovuGhA+muSG/dJrWLYEEXNs6RVJRqIeQtiAm1Lwa8ziQBmBKOd87M4v5s1601lvBuSUUvFF6epcqJej8OwjIiSex0L15FfOuovx4NqH0916CS5f50ksoJGEzFMY/a/TI/EkPRTMk/FvGSruyCxDfEtxq7zm9NaHbpu0Jnm3QJ2ida47lYT0gn3djotz6obqXVhOv7NiXU9ETN1AVmXE2Sx0v6Sns8F1NXLEBmCR9Kv5NSz+mnOPCA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67effc68-c7a8-4bb8-2fbc-08df23c58ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 16:19:06.7661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfr6eF6lIUnZYJrE+6WqhErxOFXx+G/osNMRpJDNgVBxp6n24XRiSbe4byG9OGvL/VdBSW4W4vtFXLlC/UYvRuCFuEoLTUBWrzhmE/2z4cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7114
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ljkOhKoxs-x7ezydstWqs4j9XG14zYwMAo5D-yFsOy0_1791303548
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgNSwgMjAyNiA2OjA5IFBNDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjggMDUvMTFdIG5ldDogZXRoZXJuZXQ6IG9h
X3RjNjogU3VwcG9ydCBmb3IgaGFyZHdhcmUNCj4gdGltZXN0YW1wDQo+IA0KPiANCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvb2FfdGM2L29hX3RjNi5jOjE2NTA6NzogZXJyb3I6IG5vIG1lbWJlciBu
YW1lZCAndmVuZDFfbW1zJyBpbg0KPiAnc3RydWN0IG9hX3RjNicNCj4gMTY1MCB8IHRjNi0+dmVu
ZDFfbW1zID0gLUVPUE5PVFNVUFA7DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIFNvcnJ5LiBU
aGlzIGxpbmUgc2hvdWxkIGhhdmUgYmVlbiBwYXJ0IG9mIDYvMTEgcGF0Y2guIFdpbGwgbW92ZSBp
dC4NCg0KPiB8IH5+fiBeDQo+IC0tDQo+IHB3LWJvdDogY3INCg0K

