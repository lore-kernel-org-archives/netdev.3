Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882973;
	b=L+GMClZfBhylskteFW9qkxYDrvqCCgQCvkS91oRjn8mWsvC7g1b2/4KePTN8X9dqw46b
	 7/Y+f/ZTo0k9G8ScPmYigu1C2qWIDiEnDNimAWiZ8O2dA7ycnrhiPciwpfzHdoNk7alx/
	 u4LXhGK8LsBiSaz5p3fYnJ5Vvi4N13gVhVwGJwIKnrgvoDZJBLabH7Bsk9eZfgjPeHRkI
	 xi3VJlB+6OLPlzIR6AkrW5GncdyREAsN/qDhqNBfUCud28xYxikTMw27hgObfZjEKjtqe
	 vpKWCwOiYvmcn4uUbCrPrpjAYj9E8HTTxOTJQYOghKkirI2kVlewZnK5M6HFVobxQYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882973;
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
	bh=HGhFYo8ZQohtTPJQLsMf+lxVl3JNo0xS78XrHYoRMEo=;
	b=cdSdl1wmgXeLxql5sgmpRai4oSzNxaKc6zTqOyZbJM4Z/6WtLIHBtl16cgS/xD/3tC2b
	 n8B3Rw7ypR+9mFhvbD4h5+ts7HsNdJRs5whmslD68JO8eOYw1mWl9iDgyJkS38Y8c90Bf
	 k9dgPf/dJEInGpLW8VDyb02/s4x/UJUA+X3dgcqMantbhOC4CW2QnTW3hmk7UdoAbU1gR
	 JFFgFME8qTqZ1x6wiZx+RESSvAJ1yV2QtzEIy3jdliBmhw6S93bvNjIWe8r1/Blx3kH30
	 mui33BKdK/yEPcPF8cxGrkY2Yr60q7UzF3sc+T/0p99nHvW7tumG4oZL6KVRSQ5XbeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	dkim=pass header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kGYNYYMk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.134
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022134.outbound.protection.outlook.com [52.101.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CE606A326;
	Thu,  5 Nov 2026 12:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19CE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=kGYNYYMk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofS95FxC0tHr/RfPGuwJvkKuKLmOSoRDPA4cawn9bIiGxEOoqUrM/bI/6if8M/JdPm+uAkbyNRjvSYjhm1G5cZMsbkX1tHE6Mi5L62Dy31YDXY69THeOMtXeidE9aAiQDNE5jXRetT/fY+QIoqKz00lMvBCuGFmTjVHxXThM4/n+gucFvgBg6Y8VJ3rkgb/JRoVjs4lBy04x1YhMpSAZJSMI9cTY7etdvcpQ35UvNVwmQp5RQfeA7ZG66Ny0PcQfSAwScpMMTU30jp2LaWXdbfYga5Uf89LBlsilUJfrX0xZDMDT+HkfVuL6RtU4D36YaLQOnE2KN4TTknokUDiYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGhFYo8ZQohtTPJQLsMf+lxVl3JNo0xS78XrHYoRMEo=;
 b=ww3pfBY12fdUITGb8/50GihX82QYPp0jvdrz1bCqkRF7sVMuOMRo9HFLyP9ncpvfw4PtXOpVJdw4EiVV+hVUve+goNmMeEnAHM9fAdQnDzGsaX2RwLflsAJwLiEQX/p1md7er6ogjfW36y3G3HVyZDS5qEYyyTmGrK6s48njHvLel6vOjmdbWlphJTMc1uIW2NGQpFb9Go95ma1gx9eSuZLO6sFYpdCBDWfGCSA0tucwNfJbT1WDOGOgGpW4v8aaP3807rZOGjE4oCHuXpjKyj1J27yMmaXzGIMb8jXFqJT8E2/shr8OBQ/RARvoN3uS/t8O5nxGJjUGNSdSA5ZuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGhFYo8ZQohtTPJQLsMf+lxVl3JNo0xS78XrHYoRMEo=;
 b=kGYNYYMkCoexH/hprAZl1Iw4VbmjC5G6ZzaR4s97K8jG3SRjHJz+3TW6+qL6Ru1LCP1HL844alonqg1XeOLnVviyJPmkuCqo3ZBySYYEV24ayVBEokJzOpK9BtPptHUXnbAXHR/gQ6M8Cp977CP+HfT4ZMo/zH1LFmz6aWHo5GW6BUh3jZ0VXGZrcx78BFuo8oFosGHCRZX2/9789WlP1vWpKp4T00BUHoYJTyDZu+/Z/UYhcfr+Jbi9rau6jFfZjfW2Loazb54PRJxZK/PwNTCTUsQ6CvdGTk+WDVBuqapKsHhCh9zb96aW6RsGICpcxut5Jv4wnZvMUvgHxZp3SQ==
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Thu, 5 Nov 2026 12:49:28 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::9d82:c43a:404:99a9]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::9d82:c43a:404:99a9%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:49:28 +0000
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
 =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRDSCBuZXQtbmV4dCB2NSAxLzddIGR0LWJp?=
 =?utf-8?B?bmRpbmdzOiBuZXQ6IGZ0Z21hYzEwMDogTWFrZSBBc3BlZWQgY29tcGF0aWJs?=
 =?utf-8?Q?es_standalone?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjUgMS83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?B?bmV0OiBmdGdtYWMxMDA6IE1ha2UgQXNwZWVkIGNvbXBhdGlibGVzIHN0YW5k?=
 =?utf-8?Q?alone?=
Thread-Index: AQHdbBy8iK0bacl+gkmJItDgUE8TnbcduOEAgAAHQtCAAaHKAIAADZTg
Date: Thu, 5 Nov 2026 12:49:28 +0000
Message-ID:
 <SI2PR06MB51406DA90F387ED0C64073869D772@SI2PR06MB5140.apcprd06.prod.outlook.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
 <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
 <SEYPR06MB513412E04F4F0AE8ADE0375E9D682@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261105-ambrosial-natural-ibis-7cecb6@quoll>
In-Reply-To: <20261105-ambrosial-natural-ibis-7cecb6@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5140:EE_|TYZPR06MB5323:EE_
x-ms-office365-filtering-correlation-id: 5b3645fa-823e-40a9-d071-08df3b3b3ae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|261028144727099003|261009223027099003|261022105027099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 a57Ejo0E5UJjV9RtZ/NPwY3EVlBpaAU20yM4N1mt60Q3uCJjFYFxnsflXSwYGRCeCazyh5CXuyEYZVXsjjleCWJ2kCGKPyUKjsOFHkEzsYEUzk1YT25yqoOV9LMe0YvrphhBo5KHPy0Lj+iVWnLr3YxcevJksj/+Ezfg7EddZ5HhvLT502c6mC8FZQf+wIzudHPkvf+BFdesNv9+fnlDCHWQ/LbVqIipmaCqE/6wCeD1kNgduk6RVZeVceGs1ggrEK8QaR4NjqXlLagf+N1tpvJR969WnA4Tfgs5ykzq9e1hOPiAaUbXVJc7NtxReFqok4vwrrK7Vn7DAgHjqMDTXJa2n9bsLfBZHtsFT2tYIg2ZV0sk0MK4FUfZFRk5UIzK4XuDLptZTaw/eiZXjeIds+/HwA2xXADZiOAoEXNDgsi/VlHQAiYsXjyPmMztXETqX4YktzS60YpOLl+KnuGHO5Jpd9qCOM4vcJhNhbwOoa1FadFUKZMvDbxJcDnA02H8f1CAG+OymkexARKe58FDgnXrAkNcYqZatJBzCoFCAwpoInrVjTA6wPPZPiaIYXCQgyWGj3+H0eq7vPGhS0qQEKzdiQTU1agE8HxTv7HnY4XJbLBt/sTG7SFc5JwDUBIF+DRWWgm1yyzOfDKmRv4uElEGfQgjumtWIJJYDoK04w7ioUVYUmzopiBtJBfX1gUHSCiaU54dmkaXcCIri7ERlw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(261028144727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWNhdlQxLzdOWEl4TlVUZXRib1V3UnNSUWhuNzBqWUlocUVpZTFuZ3UzUjNv?=
 =?utf-8?B?a1BYNTAvUTFacU8rZTEyeWpwWm5LNjBLRm9IeXVUNzNMb3RGdzU2QVBSWWxF?=
 =?utf-8?B?a283M3lmcEljaHp2cGs4YndpVlhMSDBYOXRVMnJBNFB2M3VVMWlUb2s0N1VI?=
 =?utf-8?B?MGl4ZFB1eXJkYWJxWUNoMHQrZnN2eWhCVjVzTVQySFN1SVE5clFZdjNKMk1l?=
 =?utf-8?B?U2dnUUU1Zk5NSjZPdmoxbDJlRjNxYmdNU2UwWUxCQUZHNWVIS2FZZTZ6bmhR?=
 =?utf-8?B?OEdDUHJxSFR4d0ZTUGE0V0JWWW1oUEJiYjUrNGRQTjdQY1lvMmsyVDVGcDVu?=
 =?utf-8?B?ODF3L3d1SEx6V1pkczlGUnNKczZFTkpONmlibnp5N3g2UlZSeG1aNHEwSU1i?=
 =?utf-8?B?YUliSk5tOEpYOEpReFFkeTNtYjhBMUdTNi95VXVMNm5GRnF4SkQ3SStpRUNo?=
 =?utf-8?B?dXpIQXloaHdINlh2T1VhNEZhM1hhVlUrNkZtdUdRRE1kZlZYODJFTGVlVjQy?=
 =?utf-8?B?WWJ0SG9nRHh0VEdka0YvRWFMallVMVdOeVorZ0Y5eVcwNXR4RVNOaXR5RnVY?=
 =?utf-8?B?VjZoZTZkSy8xOUs1N3RjR210dmxZdWxPTXFrRGQrYjFSNndvbGpsN3EvMVNR?=
 =?utf-8?B?K0Fya2Vpakw3dXlRNStJM291aEFpU2s0ZkxUaGVtcWRqWGtjOHBYa0F3aHMr?=
 =?utf-8?B?RjFoU0hhcEh2THVKcXFwa1RmU04rWlQ0aWJ5RHF2TUpDdmtGcXNnUnM4bEhN?=
 =?utf-8?B?U29RUlFMZy9ZNlpZMjA1MVp6M3NsN29FRE5TYW1FYkZrTEZjeFFwZkRMM1Er?=
 =?utf-8?B?KzlRcGp4eDBWM2NMU3VGVFVBVzZQb1BOVzdobGxTZWZROVJZcE9Kc1V6Y2F1?=
 =?utf-8?B?ZXhKQ01CM3BDQTZKTkJnYjJLYjY3amdjcFRRbWpOOWZ0VThKeXgxNHlzcmtU?=
 =?utf-8?B?cUZmYzdtTWdTVEh0SWhwNU81RURrTlU0MUVmWHBmM1dZb2sxc2I0L0dNaWJV?=
 =?utf-8?B?bU1yMFdIWU1FREJQeWxFNVFJTWdTL0RHUWNjVFk1aGlBN0NENTh2aFBxZ0t5?=
 =?utf-8?B?Ty9MRk5QaldydXRvVTllWlhNUWVXdUl0U2ltNXdvRzAzVXBCNDA2SGw1b25h?=
 =?utf-8?B?VHVIbnZQdUhDc1dRa3lwMVc1TjM0dWN3aVB4ejhreG1pQzhhcVVuNUNkWUY4?=
 =?utf-8?B?TGZjL0F5aGZ0T0czbFNpS3JxVU5hMVFlTDZiLzExZGQ5dXhiS0lKSnhQeUcz?=
 =?utf-8?B?VS9VaktOTS95VVdINHd1anZKd3cyNktPYjRwcTh6cjlBZjNhZSt0RWpiMkk4?=
 =?utf-8?B?R09jRDJ2Z25QcE1OZ3MxaFEvR003dGwxVUdHcUQ2TzVCQ1NuOHpIcW9CMWJF?=
 =?utf-8?B?Q1k0eFNwcUlyZVRSVHoyTUJkY3BacU12MUptMC9tejFKdFo2SUVpZm5MU1Iw?=
 =?utf-8?B?ZGRTbjZ0VVVNbGtCMEJ6NjBjKzdOWjV2TkVHL0owTzVZWmFMdXBILzZsRjRj?=
 =?utf-8?B?VnQ0UEJ5M0hOVmdoYVRUbjA3c0lYL1pwSk0vbGN0cnJLM3Q3RVRxUnk3ZmRn?=
 =?utf-8?B?blpyZWtEQ25DVEN5OGUxOHp1eVQ4SjdoUGtEWktjTDJmN2t6VjRkOEtQZ0RE?=
 =?utf-8?B?V2lKOTVGcURuUWwzL2dKWUx3bE5xN2NQTnVZZVo3T0dOdE9Id045bzVxV3dM?=
 =?utf-8?B?ZEtRcHlONnNSNnVpa1YxcUpabG5PMWhMYk85YjJWSzNXQUtPZWJ5L0hPRGMv?=
 =?utf-8?B?RWhuVExMRWVGblV0NndKbXQ3bXVZOW9kdHZqaUV6aHIxL3ZXbEFNeTJEOFFW?=
 =?utf-8?B?RUFhbGZ0M1Vua2RmM2JRR0dKVi9yZEdhQXhMenloZjJWUStyRUNsNTI3aTVv?=
 =?utf-8?B?VlpJV2NlcXlzK2czQ0dmSXY0UlNrUGx1ZkRrMzNlREpCdGRxYUFLL3NIZ0Ny?=
 =?utf-8?B?aUsrKzlXZ1p0czlsS3RqcGVIdnZaMHBsNmhJcDVRVGZWMzlnbXhZNlNqODlx?=
 =?utf-8?B?SEp4R2NGKzMyYTBQV24rcElqZkZIWWZJOTJoWE1paC9WbWx6R3gxaStkZjNQ?=
 =?utf-8?B?djhFWFBNZis3b04weEg5TElqN2pJRWlPNU1EQm1RQkJ5b2FmTTdHYTdXeW9l?=
 =?utf-8?B?U2hNb2dJM2N4dHp5TG9NWjJEWEtqS2Zya2ZQRTlMc3N5bGVhTnZYSDI1U2c5?=
 =?utf-8?B?NW44ZGlGZS9OVjk5TnpFV3FHZGdiMGtkdk9HekEvcHN6U05vcWpYZlBNcWF6?=
 =?utf-8?B?OFd6U0Fab1dLZStwcEY2VU1CVkJhTEtXQ0Y0Zit6aThjVEUzeHhtRXd6T3Ri?=
 =?utf-8?B?YXFpNTZxQ1Q4T0tTNFdLMmExTFQwbkM2ZHdaTWZxWjN5RS9GRU1nQT09?=
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
	BD6r8NGty8bqpv2qh9MbWbSKSNd7UkWt+wqAzu98GfIWF5cU7LxL7afpKy0BpoU8Y1VtiQ7TEav2YsbIdPZiWSmjcS/s9x+DbUNhe7DUN/t/Dk2w20/swDz/cIamyJxqU55eHI7g+jv4rduNTu/ZyAHbrG4K9T7VSA7w2E3CW+Sx6FgrIsZbGm5H963LqzBBM3LRAwCJ0I9nJZW2JovjA9zu3+FLPisneKrvchGGjDKBXTP/wQkm2Z+RKhKkqS6EwgRsq75d79iMVNbs76/Al0xFO5dm/0xD/aJG16Xzc3l1Opzuq29/vOGt0571lD1htoPNZYIZs/36FLAqApmz3Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3645fa-823e-40a9-d071-08df3b3b3ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 12:49:28.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kukslQ1ESRBhjmvBNInZg+8p4ME+7ycS7pUDg0qzxmuq5E0u3Bjnxlj6uixYyExC4M+b1fUTFzMW5kk5a1PhSEf1TZz56mUYP93jmqiKK4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323

PiA+ID4gPiBUaGUgYXNwZWVkLGFzdDI0MDAtbWFjLCBhc3BlZWQsYXN0MjUwMC1tYWMsIGFuZCBh
c3BlZWQsYXN0MjYwMC1tYWMNCj4gPiA+ID4gY29tcGF0aWJsZXMgYXJlIGN1cnJlbnRseSBvbmx5
IHZhbGlkIHdoZW4gcGFpcmVkIHdpdGggdGhlIGdlbmVyaWMNCj4gPiA+ID4gImZhcmFkYXksZnRn
bWFjMTAwIiBmYWxsYmFjazogaWYgYSBub2RlIGV2ZXIgYm91bmQgdGhyb3VnaCB0aGUNCj4gPiA+
ID4gZ2VuZXJpYyBlbnRyeSBhbG9uZSwgZnRnbWFjMTAwX3Byb2JlKCkgd291bGQgc2V0DQo+ID4g
PiA+IHJ4ZGVzMF9lZG9ycl9tYXNrL3R4ZGVzMF9lZG90cl9tYXNrIHRvIEJJVCgxNSkgaW5zdGVh
ZCBvZiB0aGUNCj4gPiA+ID4gQXNwZWVkIEJJVCgzMCksIHNraXAgQXNwZWVkIGNsb2NrIHNldHVw
LCBhbmQgbGVhdmUgdGhlIERNQSBtYXNrIHRvbw0KPiBuYXJyb3cuDQo+ID4gPg0KPiA+ID4gQW5k
IGRldmljZSB3b3VsZCB3b3JrIG9yIG5vdD8gSWYgZGV2aWNlIHN0aWxsIHdvcmtzIGFmdGVyIGFs
bCB0aGVzZQ0KPiA+ID4gc3RlcHMgYWJvdmUsIHRoZW4gd2h5IGlzbid0IGZhbGxiYWNrIGFwcGxp
Y2FibGU/DQo+ID4gPg0KPiA+ID4gQmUgZXhwbGljaXQsIGJlY2F1c2UgSSBoYXZlIG5vIGNsdWUg
d2hldGhlciBBc3BlZWQgY2xvY2sgc2V0dXAgaXMNCj4gPiA+IG5lY2Vzc2FyeSBmb3IgZGV2aWNl
IHRvIG9wZXJhdGUuDQo+ID4gPg0KPiA+DQo+ID4gSXQgaXMgbmVjZXNzYXJ5OiBmdGdtYWMxMDBf
c2V0dXBfY2xrKCkgZW5hYmxlcyB0aGUgTUFDJ3MgY2xvY2ssIGFuZA0KPiA+IG9ubHkgcnVucyB3
aGVuIHByaXYtPmlzX2FzcGVlZCBpcyB0cnVlIC0gc2tpcHBlZCBpZiBhIG5vZGUgZXZlciBib3Vu
ZA0KPiA+IHRocm91Z2ggdGhlIGdlbmVyaWMgZW50cnkuIFdpdGhvdXQgZnRnbWFjMTAwX3NldHVw
X2NsaygpLCB0aGUgTUFDIG9uDQo+IA0KPiBUaGlzIHBhcnQgaXMgb2J2aW91cy4NCj4gDQo+ID4g
QXNwZWVkIHBsYXRmb3JtIHdvdWxkIGJlIGxlZnQgd2l0aG91dCBhIHdvcmtpbmcgY2xvY2ssIHNv
IGl0IHdvdWxkbid0DQo+ID4gYmUgYWJsZSB0byBjb25maWd1cmUgcmVnaXN0ZXIgYW5kIFRYL1JY
IGF0IGFsbC4NCj4gDQo+IFNvIHlvdSBhcmUgc2F5aW5nIGRldmljZSB3aWxsIG5vdCB3b3JrPyBU
aGVuIG1ha2UgaXQgb2J2aW91cyB0aGF0IGNsb2NrIGlzDQo+IG5lY2Vzc2FyeSBmb3IgYmFzaWMg
cmVnaXN0ZXIgYWNjZXNzLg0KPiANCg0KWWVzLCB0aGUgTUFDIG9uIEFzcGVlZCBwbGF0Zm9ybSBk
b2VzIG5vdCB3b3JrIGF0IGFsbC4gV2l0aG91dCB0aGUgY2xvY2ssIGV2ZW4gYmFzaWMgcmVnaXN0
ZXINCmFjY2VzcyB0byB0aGUgTUFDIGlzIG5vdCBwb3NzaWJsZS4NCg0KVGhhbmtzLA0KSmFja3kN
Cg0K
