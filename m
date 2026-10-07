Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBD3D812A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363567; cv=fail; b=nFMghxi0j4YNCONWuyRCtDlY9xSfU98hY7UwjieHLt+G/ysdrw9QB0dp06AbhcR5Q2yz8+U1CXtNzETmc33hkwI7S8sBWiKTn4z2PBO69c1y5Lu7FwoMmMrnc4EdjdUNbzvgd5iAUXMKWEIWRiCTv0JXfU+Ml/1P6ppEJkyVc6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363567; c=relaxed/simple;
	bh=p1ELVXrOEwqemeaAJlCkOeHyErzuqeEl2iyb1xtinQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjSVLjEktJeJJVieTeDhBg3in6d/HLHAbHUMDXoUou8sTDEhfrW9IvwjQZ2chaoy675IFyyt+QDl3q/gyo5NSqg3qd1S1pqk+GWLsmyGZWmVtoeptnkBo652WAG3xFG58bL+9tpjzOAe2kivQdjL9KXcB/ZGyEX3KkySVJNnacE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=njo4B0If; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="njo4B0If"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb8uAqVsTBNSH2yMlmiOciL+lbMG8vN8FMdBNwD/Q4D97nDZ5zB2K3ggAMLMUEsL3MxkWiIUksiTuFiFqfs9VCXJohiGMkFIwL+Ooyx33c5XpS8+UxFjPkcnrvQ2grETTiKsiTJp5QmAQAJ6ldFDNwX7oR3bj4NfeyngtxWYN8ejNMk0AoZ0aMgWr3LWbWnGNrvAwy1ZXZh1lnbtS6lQKl5oA3hjlh+stcO7vr4jrM3N0tqsvCEsI/F4q/R/EquZjVpy1oVhuVlXTPPeP9HzZV9lLUGnkOwf0oxSutnTJeeRFH5vkSCPg7HB1GOBvSskOLvUxhDs3vTcaKwVWDrE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1ELVXrOEwqemeaAJlCkOeHyErzuqeEl2iyb1xtinQ0=;
 b=T3vXtvNjyDwM/LqTjcp8BAAWUUhG2vp1Ppj/LREmpmyGrn4jf6WJ6tf8vvju8oq5amx0g5YWiDTsE1Z+ibg07i6GURMoiJw9iy60bk3aK3gIyhBFmV+H9XEpvbQ7geH31A0i0CVz1LbwzdBFkmsWNr7C/nNIzvoxWeLzeGzKLE8kEqpfwuwR9BnDg1MJYd19FH/BlJYkHOMFfkjTAUVTxJsxWqtsrtzE11Qw6elc/9Sbdl2WXlOHWPArk8xOK+lYYhgJA2N7qsEVgAFmRNqAuXUJq9U04nBUik4sgQ2O8LDxfN2mKBza92R2+uuHMGBTgBoheEQTWvUvCfenOrLJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1ELVXrOEwqemeaAJlCkOeHyErzuqeEl2iyb1xtinQ0=;
 b=njo4B0IfeEuGS4QEGLrt6ga8NTIrXFpFAeEHkdUn4yGdAKf35X1qfEsTqShuq14VD3xgbTDBcfHl4+nPx1T6YpRagpP9TUO+MkqFfWrem6ekuSqm/mBDjIpDODxli4WOzauxAiUgIES+Ia/tG19K9ipaIGs9lhnYZF0xG1KRvjlVgkGXWuhm/W55H7wpyvOXFXTc6nleGZlstmWUuACQJFw17pXwumv/zCpcH5Ke8OSA2ODoLlVscZMGlZGMnIgL+dC6kXcfM0oDSFi2FgUOvLDTy5dXxaqGe1qiUfI5khPD+sTtQU9byJLi2t5t9lG4hvVN9P3ZckqND+MkYISrjQ==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by BESP189MB3281.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:59:20 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:59:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "xujiakai24@mails.ucas.ac.cn"
	<xujiakai24@mails.ucas.ac.cn>
Subject: RE: [PATCH net v3] tipc: reject attaching bearer of different media
 to the same occupied device
Thread-Topic: [PATCH net v3] tipc: reject attaching bearer of different media
 to the same occupied device
Thread-Index: AQHdUasFhTCpMenif0O8z7qNxQ2SOrbvAK0AgALPoeA=
Date: Wed, 7 Oct 2026 08:59:20 +0000
Message-ID:
 <AM7P189MB1137F9257E1AB0A2A6DFDBB6C6942@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261001134432.49481-1-tung.quang.nguyen@est.tech>
 <179120888498.434549.6187275495514737229@kernel.org>
In-Reply-To: <179120888498.434549.6187275495514737229@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|BESP189MB3281:EE_
x-ms-office365-filtering-correlation-id: 91a9e19f-1f78-4b4b-47c2-08df245146ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|10067099003|3023799007|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 E1bXnxarY8XaAsFJOj1azaY1QzTpZ2IT/S8aFmPOuEZ8YH2sWubgo/g5nFPyjB8G7M1G/q5Or6nXB6MM4uwyazYReyxfS9m1oTjxC+3S8EMWaJJXXnDgoYJJhaJW3INQHHXXZQBuKI1jVBcmb1o73lzpFBuQVQqobTldAqdOp6iRKpieFnJZT/8wtkRxyXnbL2PJJDh3mUEX8n0qEAPZZevu75kzgoVb4LpgtHHENh1GTLhjuUAYSc2R9eoaMVCydJYg1RbDnQ2mt3NDHMgMDtv2hcSXsYkzTSjxJn72gFOniH4e6v6o5AGt8M6XaVOvQUibkd1Kg6x8cYm9BR5FX6k+dFRHi6RCwvhbjL8yf8A+5toGi7KMyfSgBVPJNzm5furi9R/q+dfp59wePyo1y2rn8cSPIS+4kQ6M1NVznnLIgS46i5MFWVRFLJ/qa5OtOWFi5vjw0/EsZF0SMWNPxn6YQOfQFqYOvBLxuULieSMJ+a2l/KGjZ10meBgjZZVMY/ZbZUwnM9kRwqyEF3o/Yma9wXIIKJEjcCeyDk4qvAoI8X3/wTOTSB+yGKm/bz+AMGycHVxPepuDyjC55Zd23gzorbS4zNbAlDcQzBu6wrbj/yCghQwUSZo+yQHyZgQboZROMMYriF6Bx+PPrWzLl6Z7WmhwFfMpA0SPvCcGkkI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlBIbkQvSTZlMENIbFNiNWZIZkl0Q1hNeDZ5eEtTOTAyODZXMlFNSFRVRnZP?=
 =?utf-8?B?a0d1d2RYM2RnSzBvRzNBUDdKUDZuQWYvRHozZXd1dnVkNUFuK1ZvQ3F6bEVE?=
 =?utf-8?B?d05iN3VhNkFUV0d5TWJPV2F1R21JQnNVUGxkMVZ1eUQ2VUdpNmVpbU9JTUNH?=
 =?utf-8?B?K2U4dGlGYTVWaFFEWXlBTXNJcnpyTGlsSG9RVGdIYktGbFYwNU4wWDVpblBo?=
 =?utf-8?B?NGdRUzFmQm5zTThrNDhqUUtMQi90bmxVMW5ZdCttRGNRcjJQTVZnN05sVDZo?=
 =?utf-8?B?Slp1ZVdsYTRjZEVCc3BxWXZjckF6UTYyeWZpdTlsVTlhV0ovbmIwbjMrVUhN?=
 =?utf-8?B?TXRnVHdFb2N5RzNHK0xVM3NnSFczQmJXRElRQ28yZ21kYWJGQ0ZMclFSRUM5?=
 =?utf-8?B?bTRxeVpsT2g2T2hqVXNpMVJLL3N6L0djK0toV3Y3ZEFiT0tFQXI2clB2eFM0?=
 =?utf-8?B?VSt1cmpwNndta1M2Q2FZWld5ZWFRU0VjRzJiV3RrNXJ1SUxBVmpsUGVBQndQ?=
 =?utf-8?B?UFVNT1l3SnRFU1VwS1hnTGpqcmlEREY2UXZNR2JpdmNyUGxGSHpLMjlPSjFa?=
 =?utf-8?B?SlNpOFZVMFpRaW1jaXhhRmdGdnJKZU9ZTEtqUStxUHZyUGYyLzFIeTN5cU9P?=
 =?utf-8?B?VUgwMkEzU1pyTkxJcDh3U1hTTkl2ZGZrUUgvTkFwd3ZvWEVmVDh3c25QcmJw?=
 =?utf-8?B?RW56WXhabmhCRE15Zm1tUlAyRFhKYXBkangzVXkrNEQwazAxUDNEQW95UTNz?=
 =?utf-8?B?YUZlWGR6Wi94RXBMUVBMdUxid0VTY2JMek43MXN3R25XOTN3ZXRYUDlvWDIz?=
 =?utf-8?B?S0ZHWms1L3BOcTZwTVRzOEU3UXBnemNwN0NlRGtCTVJYUHVMWEVzVDVkQ3hn?=
 =?utf-8?B?S01KN0ZRK3dJYUdBbW5mamh0em9GNk9CalFrMnUxK1RDNDhLS051alZMbGVD?=
 =?utf-8?B?bWxkOGJqbUpjdkd6SGRlbUMwUGs0aXZKVHlFY0VNdlFEV0g3TkxmMzdhRmNH?=
 =?utf-8?B?UmtXR1BhUWxIcXFkTWVkNXRZSWIvOGlpMHd6bXFnMDUybEJnL1BLbk1WUGpS?=
 =?utf-8?B?UVRmQlJIMDlYa1dtME9yNVEyWW54MC9xYlIyTitxdzl6NlJtcnA3bkVTMVQ4?=
 =?utf-8?B?QkRWcG14ZnJjM0pZd1piOFl5WndCUnNpNkxUMWUxS1RrNkZZY0xsMVU2bjBq?=
 =?utf-8?B?UGpDTEd2MTZpdk5nOXFWTkc5WEZERllCZTZMT0pweVYzWUpLQjhDd00yL1pQ?=
 =?utf-8?B?KzA4YVllQno1Y3NpUEZzYnVZMjZKSzEyZEdQUElYTDFRN2h1MzFjZWdFeTN1?=
 =?utf-8?B?dzNrNjVzK09md1ZoNFBmM0NJQ1VzZEtkR1dwREFtaEh6YnBZOEU3Qk9qZHNx?=
 =?utf-8?B?UUk1di92Sm5XaVhTVVc4N0gxM1RyRlhZMlpoUTRmbURGUU9NVy96SW9nV2I5?=
 =?utf-8?B?TlBnU1dmOUJSbGduVWxwMjNqSVZzL1JGeENMb2JkZWhQZHA5VEI4WFBlb0d4?=
 =?utf-8?B?d0JBcVRDajduZHlPWk5Wcm1nc2ZUbEYxNVcrUWlJN1Q1M0pRdHZoUUhyVkxt?=
 =?utf-8?B?RFY2Q2F6YnJhWXlUM0xVMUQ1UHA4RVFKNnc1aCs3ZzgyN1hTVDc5NU1VQjc0?=
 =?utf-8?B?eG04ZjhaQXZCTlVubzQ1NU1ldUtGYzErdFBubytzUW9ZOENudDNpbTBIRGlR?=
 =?utf-8?B?dVZVMTFlclJBa01kOFdmWURnaGRHK0RmeWgxb0hlcGJxalhwZTBCTXZjQ2Rr?=
 =?utf-8?B?WEtnQS9tbklFckwydlF1NFFhalJaZGc4WEx6OVFFNkdxcXFVQ2oxeFZCMi9B?=
 =?utf-8?B?cGJWd0E1UDdZT3VZSUtqak5MNSsreEJUOENxeit4VG5LSmh0eHFHSmVOclNC?=
 =?utf-8?B?YVlXbWQ5ZFQ5dUpDdFpCQWFFL0s3aUZYL3Z4N3F2RzdpUmZwRW5NeCt4UjNj?=
 =?utf-8?B?eFhIVTAwTEJ0UmJ5OU9xd1Y0Sk9mVVNpOUQrSWVKbjdQdTlJZ2NaTVhCcWFN?=
 =?utf-8?B?dzF1R2wyQ0Z3S0NyazRnUUFzc2EzN2l5YkpDdmlOZW5MNnp5R1pEelNLLzB5?=
 =?utf-8?B?RmdRVDc3ajU4RWdRSTRDcW9jc3VCWlJhVGZTV1FrcHNrYXNjZWdHOEZ2RzJh?=
 =?utf-8?B?cjNHS3lVTWxnSGZQRUU1MjJHK3NuZzhYMytiYU55VFcwdnFaUTAwbC9BSmEr?=
 =?utf-8?B?UzZ4c3ZvMDB5U0tvM3VwVHdUZlVTek8wcFRTaUcxeWxWNWNxYWxRYjc4SlRZ?=
 =?utf-8?B?Q1ZwWDRXQlBqREt1TWNac29nSVNDTDNtWmhYNFQxamYwdGExTUxudkw1c0NJ?=
 =?utf-8?B?aU9qTmJta28wQ1NmOE1UNVpuc1dEakgySW03d295Mllud2FQbVBJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a9e19f-1f78-4b4b-47c2-08df245146ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 08:59:20.6040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzZWhBjeIiDWd4D58lisVTl5dygkZt18BHDUg078FsvH/FkApOoX8wyhSE7RTIFRk2Vgl6Qi93bL1TWlNe27qiqO+ieD9OkGRR9CNluqq6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3281

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHYzXSB0aXBjOiByZWplY3QgYXR0YWNoaW5nIGJlYXJl
ciBvZiBkaWZmZXJlbnQgbWVkaWEgdG8NCj50aGUgc2FtZSBvY2N1cGllZCBkZXZpY2UNCj4NCj5U
aGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAz
IHBvdGVudGlhbA0KPmlzc3VlKHMpIHRvIGNvbnNpZGVyLg0KPg0KPkNyaXRpY2FsOiAwIMK3IEhp
Z2g6IDEgwrcgTWVkaXVtOiAwIMK3IExvdzogMg0KPg0KPklmIHlvdSBiZWxpZXZlIG5vbmUgb2Yg
dGhlIGlzc3VlcyBhcmUgbGVnaXRpbWF0ZSwgcGxlYXNlIHJlcGx5IHRvIGVhY2ggaXNzdWUgb2YN
Cj5NZWRpdW0gc2V2ZXJpdHkgb3IgaGlnaGVyIGFuZCBleHBsYWluIHdoeSB0aGUgQUkgaXMgd3Jv
bmcuDQo+SWYgYW55IG9mIHRoZW0gYXJlIGxlZ2l0aW1hdGUgYW5kIHlvdSBwbGFuIHRvIHJlc3Bp
biwgcGxlYXNlIGxldCBwYXRjaHdvcmsNCj5rbm93IGJ5IGluY2x1ZGluZyAicHctYm90OiBjciIg
YXMgYSBzZXBhcmF0ZSBsaW5lIGF0IHRoZSBlbmQgb2YgeW91ciByZXBseSAob25lDQo+c3VjaCBy
ZXBseSBwZXIgc2VyaWVzIGlzIGVub3VnaCkuDQo+DQo+LSBbSGlnaF0gVGhlIGZpeCBpcyBpbmNv
bXBsZXRlOiB0aGUgbmV3IG9jY3VwaWVkLWRldmljZSBjaGVjayBpbg0KPiAgdGlwY19lbmFibGVf
YmVhcmVyKCkgKG5ldC90aXBjL2JlYXJlci5jOjMwOC0zMTEpIGNhbiBiZSBieXBhc3NlZC4NCj4t
IFtMb3ddIFRoZSBjb21taXQgbWVzc2FnZSBkb2VzIG5vdCBtYXRjaCB0aGUgY29kZS4NCj4tIFtM
b3ddIFRoZSBuZXcgY2hlY2sgaW4gdGlwY19lbmFibGVfYmVhcmVyKCkgKG5ldC90aXBjL2JlYXJl
ci5jOjMwOS0zMTEpDQo+ICBjb21wYXJlcyB0d28gcG9zc2libHktTlVMTCByZXN1bHRzIG9mIF9f
ZGV2X2dldF9ieV9uYW1lKCkgd2l0aG91dCBh4oCmDQo+DQo+LS0NCj4NCj50aXBjOiByZWplY3Qg
YXR0YWNoaW5nIGJlYXJlciBvZiBkaWZmZXJlbnQgbWVkaWEgdG8gdGhlIHNhbWUgb2NjdXBpZWQg
ZGV2aWNlDQo+DQo+VGhpcyBwYXRjaCBhZGRzIGEgY2hlY2sgdG8gdGlwY19lbmFibGVfYmVhcmVy
KCkuIEl0IHJlc29sdmVzIHRoZSBpbnRlcmZhY2UNCj5uYW1lcyBvZiB0aGUgZXhpc3RpbmcgYW5k
IHRoZSByZXF1ZXN0ZWQgYmVhcmVyIHRvIG5ldF9kZXZpY2VzLCBhbmQgcmVqZWN0cyB0aGUNCj5u
ZXcgYmVhcmVyIHdoZW4gYm90aCByZXNvbHZlIHRvIHRoZSBzYW1lIGRldmljZS4gVGhlIGdvYWwg
aXMgdG8gc3RvcCB0aGUNCj5kZXZfcmVmY250IGxlYWsgd2hlbiwgZm9yIGV4YW1wbGUsICJldGg6
ZXRoMCIgYW5kICJpYjpldGgwIiBhcmUgYm90aCBlbmFibGVkLg0KPg0KPkNsb3NlczogaHR0cDov
L2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjA5MTgwMTM1MDkuMTg1Mzk1Mi0xLQ0KPnh1amlh
a2FpMjRAbWFpbHMudWNhcy5hYy5jbi8NCj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvdGlwYy9iZWFy
ZXIuYyBiL25ldC90aXBjL2JlYXJlci5jIGluZGV4DQo+PiAwNWRjZDJmOWU4ODdhLi5mNDgwZmZm
Y2E4NDNlIDEwMDY0NA0KPj4gLS0tIGEvbmV0L3RpcGMvYmVhcmVyLmMNCj4+ICsrKyBiL25ldC90
aXBjL2JlYXJlci5jDQo+PiBAQCAtMjg1LDE3ICsyODUsNDIgQEAgc3RhdGljIGludCB0aXBjX2Vu
YWJsZV9iZWFyZXIoc3RydWN0IG5ldCAqbmV0LA0KPj4gY29uc3QgY2hhciAqbmFtZSwNCj4NCj5b
IC4uLiBdDQo+DQo+PiArCQkvKiB1ZHAgbWVkaWEgY2FuIGJlIHVzZWQgdG9nZXRoZXIgd2l0aCBh
bnkgbWVkaWEgKi8NCj4+ICsJCWlmIChiLT5tZWRpYS0+dHlwZV9pZCA9PSBUSVBDX01FRElBX1RZ
UEVfVURQIHx8DQo+PiArCQkgICAgbS0+dHlwZV9pZCA9PSBUSVBDX01FRElBX1RZUEVfVURQKQ0K
Pj4gKwkJCWdvdG8gcHJpb3JpdHk7DQo+PiArDQo+PiArCQlpZl9uYW1lID0gc3RyY2hyKChjb25z
dCBjaGFyICopYi0+bmFtZSwgJzonKSArIDE7DQo+PiArCQlkZXYxID0gX19kZXZfZ2V0X2J5X25h
bWUobmV0LCBpZl9uYW1lKTsNCj4+ICsJCWRldjIgPSBfX2Rldl9nZXRfYnlfbmFtZShuZXQsIGJf
bmFtZXMuaWZfbmFtZSk7DQo+DQo+W1NldmVyaXR5OiBIaWdoXQ0KPkNhbiB0aGlzIGNoZWNrIGJl
IGJ5cGFzc2VkIHdoZW4gdGhlIGV4aXN0aW5nIGJlYXJlcidzIHNhdmVkIG5hbWUgbm8gbG9uZ2Vy
DQo+cmVzb2x2ZXMgdG8gdGhlIGRldmljZSB0aGUgYmVhcmVyIGlzIGJvdW5kIHRvPw0KPg0KPmRl
djEgY29tZXMgZnJvbSBsb29raW5nIHVwIGItPm5hbWUgYWdhaW4uIEl0IGRvZXMgbm90IHVzZSB0
aGUgZGV2aWNlIHRoZQ0KPmJlYXJlciBhY3R1YWxseSBob2xkcyAocnRubF9kZXJlZmVyZW5jZShi
LT5tZWRpYV9wdHIpIGZvciBMMiBtZWRpYSkuDQo+dGlwY19lbmFibGVfbDJfbWVkaWEoKSB1c2Vz
IGRldl9nZXRfYnlfbmFtZSgpLCBzbyBhIGJlYXJlciBjYW4gYmUgZW5hYmxlZA0KPmJ5IGFuIGFs
dG5hbWUuIFRoYXQgYWx0bmFtZSBjYW4gbGF0ZXIgYmUgZGVsZXRlZCB3aGlsZSB0aGUgYmVhcmVy
IHN0YXlzDQo+ZW5hYmxlZC4NCj4NCj5EZWxldGluZyBhbiBhbHRuYW1lIGdvZXMgdGhyb3VnaDoN
Cj4NCj5ydG5sX2xpbmtwcm9wKCkNCj4gIHJ0bmxfYWx0X2lmbmFtZSgpDQo+ICAgIG5ldGRldl9u
YW1lX25vZGVfYWx0X2Rlc3Ryb3koKQ0KPiAgbmV0ZGV2X3N0YXRlX2NoYW5nZSgpDQo+DQo+VGhp
cyBzZW5kcyBvbmx5IE5FVERFVl9DSEFOR0UsIGFuZCBvbmx5IHdoZW4gdGhlIGRldmljZSBpcyB1
cC4gT24NCj5ORVRERVZfQ0hBTkdFLCB0aXBjX2wyX2RldmljZV9ldmVudCgpIG9ubHkgc2V0cyB0
aGUgYmVhcmVyIHVwIG9yIHJlc2V0cyBpdC4NCj5Pbmx5IE5FVERFVl9VTlJFR0lTVEVSLCBORVRE
RVZfQ0hBTkdFTkFNRSBhbmQgYSBiYWQNCj5ORVRERVZfQ0hBTkdFTVRVIGRpc2FibGUgaXQuDQo+
DQo+Rm9yIGV4YW1wbGU6DQo+DQo+ICBpcCBsaW5rIHByb3BlcnR5IGFkZCBkZXYgZXRoMCBhbHRu
YW1lIGZvbw0KPiAgdGlwYyBiZWFyZXIgZW5hYmxlIG1lZGlhIGV0aCBkZXYgZm9vDQo+ICAgICAg
KGIxLT5uYW1lID0gImV0aDpmb28iLCBob2xkcyBldGgwLCBldGgwLT50aXBjX3B0ciA9IGIxKQ0K
PiAgaXAgbGluayBwcm9wZXJ0eSBkZWwgZGV2IGV0aDAgYWx0bmFtZSBmb28NCj4gICAgICAoYjEg
c3RheXMgZW5hYmxlZCkNCj4gIHRpcGMgYmVhcmVyIGVuYWJsZSBtZWRpYSBpYiBkZXYgZXRoMA0K
Pg0KPkluIHRoZSBuZXcgbG9vcCBzdHJjbXAoKSBkb2VzIG5vdCBtYXRjaC4gZGV2MSA9DQo+X19k
ZXZfZ2V0X2J5X25hbWUoImZvbyIpIGlzIE5VTEwgYW5kIGRldjIgaXMgZXRoMCwgc28gdGhlIGNo
ZWNrIGlzIHNraXBwZWQuDQo+dGlwY19lbmFibGVfbDJfbWVkaWEoKSB0aGVuIGRvZXM6DQo+DQo+
CWRldiA9IGRldl9nZXRfYnlfbmFtZShuZXQsIGRldl9uYW1lKTsNCj4JLi4uDQo+CXJjdV9hc3Np
Z25fcG9pbnRlcihkZXYtPnRpcGNfcHRyLCBiKTsNCj4NCj5UaGlzIHRha2VzIGEgc2Vjb25kIHJl
ZmVyZW5jZSBvbiBldGgwIGFuZCBvdmVyd3JpdGVzIGV0aDAtPnRpcGNfcHRyIHdpdGggYjIuDQo+
SXNuJ3QgdGhpcyB0aGUgc2FtZSBkZXZfcmVmY250IGxlYWsgdGhlIGNvbW1pdCBtZXNzYWdlIGRl
c2NyaWJlcz8NCj4NCj5PbiBORVRERVZfVU5SRUdJU1RFUiBvbmx5IGIyIGlzIGRpc2FibGVkLCBi
ZWNhdXNlIGl0IGlzIHRoZSBvbmUgZm91bmQNCj50aHJvdWdoIGRldi0+dGlwY19wdHIuIGIxJ3Mg
cmVmZXJlbmNlIGFuZCBwYWNrZXRfdHlwZSBzdGF5IGluIHBsYWNlLCBzbw0KPm5ldGRldl93YWl0
X2FsbHJlZnMoKSB3YWl0cyB1bnRpbCBiMSBpcyBkaXNhYmxlZCBieSBoYW5kLg0KPg0KPklmIGIx
IGlzIGRpc2FibGVkIGZpcnN0IGluc3RlYWQsIHRoYXQgY2xlYXJzIGRldi0+dGlwY19wdHIgd2hp
bGUgaXQgcG9pbnRzIHRvIGIyLCBhbmQNCj5iMiBpcyBsZWZ0IG9ycGhhbmVkIGluIHRoZSBzYW1l
IHdheS4NCj4NCj5USVBDX05MX0JFQVJFUl9FTkFCTEUgaXMgR0VOTF9VTlNfQURNSU5fUEVSTS4g
Q0FQX05FVF9BRE1JTiBpbiBhDQo+dXNlciBuYW1lc3BhY2UgaXMgZW5vdWdoIHRvIGRvIHRoaXMg
d2l0aCBkdW1teSBvciB2ZXRoIGRldmljZXMuDQo+DQo+VGhlIG5hbWUtYmFzZWQgbG9va3VwIGNh
biBhbHNvIHJlamVjdCByZXF1ZXN0cyB3cm9uZ2x5LiBTdXBwb3NlIHRoZQ0KPmFsdG5hbWUgImZv
byIgaXMgbW92ZWQgdG8gZXRoMSwgb3IgZXRoMSBpcyByZW5hbWVkIHRvICJmb28iLiBBIHJlcXVl
c3QgZm9yDQo+ZXRoMSB0aGVuIGdpdmVzIGRldjEgPT0gZGV2MiA9PSBldGgxIGFuZCBpcyByZWpl
Y3RlZCwgYWx0aG91Z2ggZXRoMSBoYXMgbm8NCj5iZWFyZXIuDQo+DQo+V291bGQgaXQgYmUgbW9y
ZSByb2J1c3QgdG8gY29tcGFyZSBhZ2FpbnN0IHRoZSByZWFsIGJpbmRpbmc/IE9uZSBvcHRpb24g
aXMNCj5ydG5sX2RlcmVmZXJlbmNlKGItPm1lZGlhX3B0cikgZm9yIEwyIG1lZGlhDQoNCk9LLiBJ
IHdpbGwgdXNlIHRoaXMgY2hlY2sgaW4gdjQuDQoNCi0tDQpwdy1ib3Q6IGNyDQogDQo=
