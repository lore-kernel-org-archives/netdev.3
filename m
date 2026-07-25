Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020117.outbound.protection.outlook.com [52.101.56.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866130C35E;
	Sat, 25 Jul 2026 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949740; cv=fail; b=Shdp81VFa47bskXU+yBnPQgewnvvEcopQ690wINZ9c7SYDTUUyf9cHfWFiwu7JiQX148Z9rffQbz+XEE8e+ETM9qdAt3nYl1BfsiOrfgZdgps1yBlKkCar8ZvnNZ8ULydjgPrQoNRDllUKDkkLUHCgo5csJZsRLfF5kGQhFvQvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949740; c=relaxed/simple;
	bh=csoXXyvSs+ro2xbTKFPQgbYOj/Tcw4zajNfztRF0PfY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PmycjuDzidlZvIuO3Hj2Zrg/usn6I9nfRtryh5SgiGtLzIpB2WJBjv/8kq9pIZpRmbok1hE2G5+bPFXePdZwlWT5bGEUQzbq20TVwgiOR0LwbY1llteNC9XyjCxBUwu3BBQk/AgYOrSnnn8sGQXitCboSx6WydN0VgE5xo2MzPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=CopHMVjg; arc=fail smtp.client-ip=52.101.56.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="CopHMVjg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beBUCSFPPNLXXHwRaNoI2Rw/ZzWkDs4dfUVZfAgQwlx38aAHYOoTWqgELUck3d3fQqQVnL0S+ss+YxqKG9Gnpr6y1N/D/3vBF5tcVoraD51z85/9FmVGH/JBmaFzFIhmplDQus4xJPjQAhmF4467xn2Uc5UycG0ceEdmWyogQV9epgrsmUc/lyLYLgRS7Gte0y1HJQ0bL4RCQJ4JrsMc6RDDTN5sz9HMvOdae3j6WBXxjrRG41ncocopjGuJZ382tD3jRNsr6Lj2ohJldhGOF+ROeBfp06r8fE8NFsV7+tf6VD0ZZ9wqrXS9gpOguEDPOILGaaJZLudf9RgnjjrNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csoXXyvSs+ro2xbTKFPQgbYOj/Tcw4zajNfztRF0PfY=;
 b=DbwQiXv0FFKWyI4aRRjMllheumg6wgyqjTGY5HAfGXeV3MkWxedMYjjP5e6vv+oAoGERsJYjZw8qdUWo8CNb/azDMTNV1blPQGBZmGShtQqOFvP7Thx+U7KY9YI/VmDr1rs2gBGWORijl9FUGk1JkHZ08PCJvHVmOfI/aNI/bdZNMlf54D7qWhHC77ilZqLx/6JC96C8iiQ8LriHvwRmz1FSQ0awXytPOvfBfwXMKRnx6wkFmq59PCA+UjOyy/dapHUAQG3yFeAY8G87LyrFkFShcPvemgjcCKLC27tTUzAWOOELd9qpF6DCvzRZKs8Y9Y+tYlWx3ZaYHduUYftoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csoXXyvSs+ro2xbTKFPQgbYOj/Tcw4zajNfztRF0PfY=;
 b=CopHMVjgcPrh2xkZ7Z92hBMFCglpIXJcxVjjFgWcm1thX7y6YAnslIS3P0SKBI9gi1vPF81nyMizcssQJne1PAC1xNMRJNYjN7OLb0hi77k7Tbt6B8eqpfJPh0wNwk84R0zKL7sR11IUJiDASfImyQ4Pr53qhih42zsgportBy71WZ6bWZsdwPwD+WgSaQQxVYIBw0rgNlCGOF+QxzssYOPkUCyvWIFaJHI7ygSsgU4dSqKzsnU9IU3pgxiaIzwEzBg9/ytY0SPXrtJfG5cekqWgblZ7OPxhW1A1IQdsR98dNDGbJ2lArk8FwLSZWElQL8RJtbMZtXEW6FqgP3893w==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by DS5PPFC0F1095C8.namprd20.prod.outlook.com
 (2603:10b6:f:fc00::822) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Sat, 25 Jul
 2026 03:22:14 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 03:22:14 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next 0/1] qca8k host FDB handling
Thread-Topic: [RFC PATCH net-next 0/1] qca8k host FDB handling
Thread-Index: AQHdG+TJheDnIb4mhkmapMoTvFAtVg==
Date: Sat, 25 Jul 2026 03:22:13 +0000
Message-ID: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Mahcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF42224DB53:EE_|DS5PPFC0F1095C8:EE_
x-ms-office365-filtering-correlation-id: da7143d6-586e-4259-1202-08dee9fbec0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info:
 Xt0Amcxi2YcjUGeMYvs6XQZf8gsPsM+1dPpV4DUGLE0LEDqDkcnYsI5AQNX1+dJ+rgW6eVSSLkFScte2XHg0l+6xFfFYuZPsaAsKskTQKA6bkqEeKImYjUbfnmkiDwBwDccQmASwuXNTIOlVyaNV1Nzy1PmMTfS+C1LWhrLMqCu/1VhJq5+7hky8NCgLRhwTEDyWA4X9gh02U0ECUZaG22S9lEpmH7gloT+hMOOJVAXE+nZ/i02sNmBomBzVzto9HkwCfKOVA7825xVKsTpHQF1Rr6c9lLuxLgr9SetwjsKqDROGR4iEch9dwzkoQC3b8bnuhM6bS3MzdrdBtxfg7lIWYCvASCSg1IDM7Jl04MtXSnL7lLHz4jKjzDyu0+aZp60P9j4WVe5LAtJBI2I5V0K4WNl/8QUBVZHXKU1qJTXeu7OGs+cpiP7Wktn2OzHMhONqAHo7zoOuQsYjFqyVvhGQ6884rJyWzmhtGHLf+Sy23IM1BotyVGTLCFu+gEqxKOxBf8Szs0rDlgqQBNsUTrSsiZn5MXZCpBvLg1Ts5tmkXhXA9SEeXs0vou73ZVwpIr4P6gsi004WHomwoLfAA8V/DJtefxyeDEBozjnb3G7QSf75I/kMqPg8jg2df0cp9v6jxkhaNPJNRy2W4NemU6wAv/OcXXKd+zx52Gw7w6WPNPmtDK3vkCZ4aWK1aT4KXg9LDnLL/YAmKWEjYW7d1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3hyMURQVUl4NEU5QnpBT1VXYmhhYmQzK2FoZ1luTUVIQkczS3NlYXZmanBx?=
 =?utf-8?B?RjgxTHFacW1HcmhDTDdQSmw2dSs0dXRrZUhOZDdvYmt0cjQxdVhrelFVWGx1?=
 =?utf-8?B?YVpINks5RGFCS3RzaHhubHVleEdiZCs3eUZ3MDVNV095dytkaXk1R1RMS00r?=
 =?utf-8?B?SmpKQXBab0U2dENmdUhnaFZwL01HdUZ5ZTA2ZGg4RE92WjBtc255aUZ6bXRX?=
 =?utf-8?B?VmJZY3hqQ2ZGQXpmK2ptTm5LR1hJa1RpRkNlUFdGM0lEOHoya2YvYjM0UFFO?=
 =?utf-8?B?RTNNK0VYUkFSbmlXNUdaYjE4aXJzN3QzVUpYQWRsYWI5WHZCK2FnRTBnYWs3?=
 =?utf-8?B?alRLU1pTL0FBS0JYS2pUMk5xdnNESUtkeFBQVFh1UW1icFNwT2djeG55SHFw?=
 =?utf-8?B?aUFtYm43blc4Z2RLdUtCSjVkRmRpVFByYkRHbm84QVhEZE4yYitkU1pUU24x?=
 =?utf-8?B?RStpVTQydFh2TklHaWhFT0hLWGNSOU9MUnJ2SGdiWFdGVXJoWTdYSlluNVZY?=
 =?utf-8?B?QXdEMjNBb2h0cHdjdlViYnUzRjROczFydmhjZE5tbWdnMHZaam9FNktReEln?=
 =?utf-8?B?T0tnMndNZ3pjZkh1ZnY4QkRNTExDdktZYXlTc2c3T25PWWFWcGtrSUxkS0tM?=
 =?utf-8?B?VmZnMUtIRS82elRBWDQra1lIdGEzOWhReDllNzZKcWc1SmJpekFueVdCSkNl?=
 =?utf-8?B?WWJhalp1cEtGMUllMUxtUll0aFFWMDlKSVl0blRuVDNwZ3VNMk80RFZJTnhy?=
 =?utf-8?B?U0ppcnFiSS80UUkvSXNjbi9nbnBtMW1UK1F1a0x3TlBGMm1jUWxkV2tDaitQ?=
 =?utf-8?B?cmJqb1VDUENuSEx1ZmZaZlNIRTlkNm1JMHN5OEtJZ1I3cUFINDZLZ1BURHRZ?=
 =?utf-8?B?M0tXamZvajhxR25YL2pHdERIamdPMmU1cFR6K2FRSlp3TWNqL0I2SDZDelZC?=
 =?utf-8?B?K3RWV01JVjRMUGJKSkhCOHZZTkhZTmUxM3k2UjlnbnRKUDVtTVNNRTZ5M2Y5?=
 =?utf-8?B?Z3R5KzNLVVZ0VlZQaGwzOXErZ3VnTnkwaUUzRVVma3lxM1YwVFRMVzBNaG5T?=
 =?utf-8?B?U0FCY1pWRkNKOWdNbjJvRm4ySjRPY1dTeHVjaURiOEZBdnpHM3ovL1BhL1Zm?=
 =?utf-8?B?OVQwaHVSRzJvZHRLNHluS3NScGJQZGhHa1Jyb2oxNmV0SjRZYkc2eUk3Qlpo?=
 =?utf-8?B?Y2pXRHFwT0luN3VyaE9XekFpRUtZWTdJckViS0pWcUo0enpDSlE4U2M2SGRK?=
 =?utf-8?B?eHRoSnhyN3kvbWxvT1liSklsQmtPc3pYMzc5c2d2TVozcmxCL1M5MXF1dHJN?=
 =?utf-8?B?L2ZzMU5wS3hWZXBUL3NXc0toZDlCY1FJMlBSc1AyUk5kdDAweElNYWFGdCtH?=
 =?utf-8?B?OFZITzdBMkhaczluT01wU2g1WE8yOVY2aTF5WTl6dVlZR0VxWmtjQ284RDhs?=
 =?utf-8?B?VjNUMUxXdEtlMUVQMXlJUTY1cjMyNk10Ums2YnVoVTUrZi9PY3ViUit3cDg1?=
 =?utf-8?B?a2JEL3BpcUI0RkdmeVpUd2h2c3BWUDdNejBjYkUyd1FCVmpaM0IyTXZiM2ww?=
 =?utf-8?B?UUdqWHdLV0YxeFByKzZzSDBTclRsZnkzZDlvb0VFNWpxTTZVQjB5VkFzRWVE?=
 =?utf-8?B?emF4NXpOSWxZSVhMRUIrbDFuOWxBR2NxYTN0NERjSmRlUC83ZUFmRUV1YjdI?=
 =?utf-8?B?Rmh3NTRvWU1WN0wzYjliQnE0clVLUW81cE5VWS85YmZMdWJiaU9TZHZmcHU4?=
 =?utf-8?B?NlMxYktzRHE2TzVsV1B6Y1UwWDV5N1RxR1dhNWp4aVNoMnlaSlZCZ2N0bTlp?=
 =?utf-8?B?STB3cmxWU1A2Ly9aMHk2QS9GZ3B3aDdqU3pwWFp0YkRWak9jdk8yOWFqN25H?=
 =?utf-8?B?T2dwaWFreVdTZ0RHY01EQ2REM1MyR0gvQzkzKzI1QkFoNU4vZFM3UmZZVjFs?=
 =?utf-8?B?cnF1RUtKN1BNODVtZldheWlCZm02Nmd1emU5bFVKbDhsZi9QRWg0UXRLdUtF?=
 =?utf-8?B?S3BqaFZZdGszY1Y0TEl5WEd0dVd2dmRoeVVPSHNaejd5ZUdUdThNN3NEZlBC?=
 =?utf-8?B?Z2F6Y3NkdWYydk9MUVJzcHBEN3RHa3NHdEI5UVc5R2Fkb2hLalNvenpYalM1?=
 =?utf-8?B?REJ0dkp0bWxIVkFFK0c2N3AwUHVSaG13R1VBVWdJZHVZbm0xcnM4QVJrWENC?=
 =?utf-8?B?RXJydHpyaFJzdnBVY3dFZ0JyYk5BUW1ZcmFnODNwZXNoUEhYUUtWSzROUlpY?=
 =?utf-8?B?N3dqRjFydC83cXdUcGp3VmxWNXdXRnMrL1VubWFubzY5YUs4QmlVRURvMXRy?=
 =?utf-8?B?TWVqUmZHWmpONUlqS0l0LzRRNk1pbm1xSVU2UWtMdytlekZJeEJpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Mahcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF42224DB53.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7143d6-586e-4259-1202-08dee9fbec0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2026 03:22:13.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhiXDTIDNCk77YD7hj6CMSm3WczHeZXY3ToPvtxXWDjBq74t+nzFumDHzyt1HpWbTA7HpME/dOYfyzRe2heIwTn7EZsDNkbP+W2AJFSXteg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC0F1095C8

VGhpcyBpcyBhbiBSRkMgYmVjYXVzZSB0aGUgY29uZmlndXJhdGlvbnMgd2hpY2ggZXhlcmNpc2Ug
Ym90aCBwYXJ0cyBvZgp0aGUgY2hhbmdlIGN1cnJlbnRseSByZWx5IG9uIFFDQThLIHBhdGNoZXMg
Y2FycmllZCBkb3duc3RyZWFtIGJ5IE9wZW5XcnQuCgpPcGVuV3J0IGVuYWJsZXMgYXNzaXN0ZWQg
bGVhcm5pbmcgb24gdGhlIFFDQThLIENQVSBwb3J0IGFuZCBjYXJyaWVzCm11bHRpLWNvbmR1aXQg
c3VwcG9ydCB3aGljaCBmbG9vZHMgdW5rbm93biB0cmFmZmljIHRvIGFsbCBDUFUgcG9ydHMuIFRo
ZQpob3N0LUZEQiBza2lwIHdhcyB0ZXN0ZWQgdGhlcmUgb24gbXVsdGktY29uZHVpdCBRQ0E4SyBk
ZXZpY2VzLiBUaGUgc3RhbGUKZHluYW1pYy1lbnRyeSBwdXJnZSB3YXMgdGVzdGVkIG9uIElQUTQw
MTksIHdob3NlIGRvd25zdHJlYW0gRFNBIGRyaXZlcgp1c2VzIHFjYThrLWNvbW1vbi5jIGJ1dCBp
cyBub3QgeWV0IHByZXNlbnQgdXBzdHJlYW0uCgpUaGUgcGF0Y2ggYXBwbGllcyBpbmRlcGVuZGVu
dGx5IHRvIG5ldC1uZXh0LCBidXQgbWFpbmxpbmUgUUNBOEsgZG9lcyBub3QKY3VycmVudGx5IGVu
YWJsZSBhc3Npc3RlZF9sZWFybmluZ19vbl9jcHVfcG9ydCwgc28gdGhlIHJvYW1pbmcgcGF0aCBk
b2VzCm5vdCB5ZXQgaGF2ZSBhbiBpbi10cmVlIHVzZXIuIEkgd291bGQgYXBwcmVjaWF0ZSBndWlk
YW5jZSBvbiB3aGV0aGVyIHRoaXMKY2hhbmdlIHNob3VsZCBiZSBmb2xkZWQgaW50byBhIHJlbmV3
ZWQgUUNBOEsgbXVsdGktY29uZHVpdCBhbmQgYXNzaXN0ZWQKbGVhcm5pbmcgc2VyaWVzLCBvciBz
dHJ1Y3R1cmVkIGRpZmZlcmVudGx5LgoKVGhlIENQVS1wb3J0IGhvc3QtRkRCIGhhbmRsaW5nIHdh
cyBvcmlnaW5hbGx5IGRldmVsb3BlZCBieSBPbGFmIE1hcnpvY2NoaS4KVGhlIGR5bmFtaWMtZW50
cnkgcHVyZ2UgYW5kIElQUTQwMTkgdGVzdGluZyB3ZXJlIGRvbmUgYnkgQnJhbmRvbiBNYWhkYXZp
LgoKQnJhbmRvbiBNYWhkYXZpICgxKToKICBuZXQ6IGRzYTogcWNhOGs6IGZpeCBob3N0IEZEQiBo
YW5kbGluZwoKIGRyaXZlcnMvbmV0L2RzYS9xY2EvcWNhOGstY29tbW9uLmMgfCA1NiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCsp
CgoKYmFzZS1jb21taXQ6IDA0MDI2Yzk5OGMyNGFjNDdlYjc2ODg2Yjk3OTBjNTcxMGI2MDNlYjQK
LS0gCjIuNDMuMAo=
