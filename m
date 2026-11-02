Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793584439;
	b=ptz+fRIODnzhkZW5ALqedIniWRbNnF+6fq0ry9LF1vlWZUy7cBOQEtrnjI6QJGHZe77N
	 AN852+i5Jp0KxqOk1KVzJ7Hx40HP6SxRb0fKd1PxB2dOeOg+Ily+FC44nRfK4X1mgFMwm
	 vyCUIanRKusjOVDW9cbk280WabYGrGKLqbZZ2KNR9qKpBzv1FG3YOkcSuWT+pCjBu8Mex
	 063C6MTFFDwQVjI+sHhL74fnylBuEa2m+yWC11QFSOVePI+AEsq0WGX4beVlk3tYwfNZu
	 5wHU3CotAnl/6nEiFx3FR0Hrm8TUVIIAkQJls5xV9ppI2Twc40Q6jzObmhiDpIafqsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584439;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QdHyI6geFK3MYvFK9OVhhef3TIzI6d2+2DfCMaYSEKc=;
	b=37PDPsaYfJqeSqv/LKF9l/g9tclnnD6lcAvWzMMA/4w2e6qHlPBnhROPVobGDv8cP1qB
	 hBcIwX8VIt2BIovW9wKyK2wR4c4dUrxpdZEnLktE+rJmDSAiZKU4YeEzZ3YyhKfgjw80e
	 /yjFRT8ZqwWi7Mz/5TMNyo2F/zGrsSLZU+a5JwI9N0AO4jYC4tQmACt0SFTfNIzbwL8CY
	 Z+uHJjSiXkCXVk2ahmTZaRKpMIHHi3+pJ2lCBUMqktI8aFLA6rl+XoWdVvkQ51+dPPZd0
	 JP/+L24VdLZ3ZpHJcE7yTexsgceFwVJBIg8XlVtxHzuijjdPdDVtlCdkV/lTDbhHk/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=JRft0SBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.37
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57B606A324;
	Mon,  2 Nov 2026 01:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E57B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=JRft0SBK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYY38UXbO+sJzoeuBTYbRCQUds6bO6DfDpCJipjAyiXqRHQSB/9vwUdog42ndTE6R226BinUpZTVLpiaK/ECFbzu7U8CfYd6fV/geqF7TOiZoF/qVklh4YpuM+6tImzVU6Jy43zSiFP0WCMRMk7aleahRsEZyIGYCoTa0+9sNNQaeyaAGGMZJS6ZuNOZ3nJkYYeNFt2rLJIPvIp9yBJ4WWd40eS/H0pH7zYI+bpTyRFEBLVtUCcpDvKwAK6d/nmCQ+UzcJSjm9bSuH3wzG2fYNK3ufOZdSpgsxRfvwEdr5KNluVRrfd6WHhgJozxRGQP9hEWEoY+Pd44mvHsUUHJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdHyI6geFK3MYvFK9OVhhef3TIzI6d2+2DfCMaYSEKc=;
 b=Z0dV0+91CKasem90BlzLVtAYWKr6qQ7vuvHJsdiZzCt+evEn71dxN4t3ecTaWHuHBamt0hfRNJnjYvUbWxqi2OTKlyK5Vt5/hBpPeL+nYhWx4hyAUXDBCIkcLwlm0Sygpe0SMU9Hlkl9lnt3DXAKO159zaHyCDxT+q25EeCt37qIXC4IIFWX1HXLgjMjVATfzSPJFHMQn143kSg+hOT5oYyzNLIF2M21bMIX6A9ViEjDLtGXjqfNmZwsFfxWcEXvNsNS0+fQTO0dk17D9q8wE068Od/vaHhiptlSxmZFU1Yhlq8wE9Bx9gkFMsizRnwUo3LmrlvbBoUY/1nVDgrfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdHyI6geFK3MYvFK9OVhhef3TIzI6d2+2DfCMaYSEKc=;
 b=JRft0SBK0sZ+uyCW40tGJjdr6OUmMRZwNGkMuwT4rgCBIAbWL/WOUrRedQHUxYDpzT/tlQPgLvz2LfPdHM9R7l1+vqeHYzLnCMEv7Tz5vY8pl4lTQ6DhJYrF3k/vVnaF+Kgj7+meHSl7ILLg7H/U47xwaGTwNQnyfoRDKxzoRLbPKXHHdTFQJQbh4KhsDJ3z4BJOo3W0KkWJHXxfE5rhuRU0Zi9Hqzk+jGaldWqLBJtdzwTEoORVjC9alAalHOawqkSDZJ5SsIKPK+G6fdFh4Zl2Jycd2IiMc0JtJa4bvlJfemQ8wNB4FbzU88S8sMUyqoDFf+4eKCpmpeYPXnUpaw==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PRAP189MB1827.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 01:53:53 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 01:53:53 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
CC: "David S.Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v5] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Thread-Topic: [PATCH net v5] tipc: raise the minimum bearer MTU to fit tunnel
 and crypto overhead
Thread-Index: AQHdaMnZq5ZmLZzNT02n2/bccGmfzLcaCBfw
Date: Mon, 2 Nov 2026 01:53:52 +0000
Message-ID:
 <AM7P189MB1137736DEA89EDA8348D8D3DC66A2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <179340438471.4412.6707287163192409104@gmail.com>
In-Reply-To: <179340438471.4412.6707287163192409104@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|PRAP189MB1827:EE_
x-ms-office365-filtering-correlation-id: 45a9ea2c-8d96-4135-bbd3-08df388425c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|38070700021|11063799006|56012099006|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 m0uA84xlamXSEI/JU/Gxf+Q3t+k3E6QsewkIhsV14+nF68k2ZimN5w7JhauTX0bUz6s9iWebYPgYLYCLBsNay90I2Ps0w264MoQfX7Na/e+n2ax+2KR2p1l3ENH+ICjZCqamKU/e5Hejf75jo2iG7WC8bn+X/UheblnBWXcyxUNJADZEnbSrup+eH0I7lRDcrBZXjGbO3c1+ALEA989m3tkxYv95zNHYDnmG8lyQ7e+plAlDD6mafD0eIn1/zSrzONUH8QbYHyl6lJV8A2OsaOK3bDVAVSzeqxDT64znFYgNr7UsPH5ZUZU1mCv/qjtaWiRW9H+mbuM3ONpKYUW1bBLCgp225d1//H61uqBEnisAf2i9udFfGDgaUlk3XjHPp5y8JH4xBKvXqxcFkb3XNdkwQenkJWjIUMnRqQgHD3SMxRsQUe8qGe9Ag8+oA6xLv3EkSJ+SE/I8TKm7gJx+XO8PIzZ6XIpZKBgsZ/dzpvVmOPT/lFPWgdK7aFAqLUJ6YjeegTroJ0mh3OQFRAN4CxgUlh5YsIX3yvJczor7gqcyE21FJHyY2/hzUzu8oZHTEWdof5sbZmHzYD3sqoH0naRbik9dfzz2nJL4HgtjxNTzSHxceOk9TPdk8d4BLfBntXEE5LK+P6k/UWcg3L7Ml3PkYLzEtaOl6owN5JQeQFBxDxWs22BGnow3bzM5hGnd7aqalRaf2Y/3NHd67ZAQgFAIQBkbOhdc0tDUkq9Erhs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(38070700021)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUJNUWhTWWJST2J5VW9vQXVEcm1JUlZSd1JSUURWMklpZStJam5xZktkcnJa?=
 =?utf-8?B?b1hNYU1JbitaZ0hxWkVERC9aL0RPNjlWTnpsRzR3VDFNUlFlK0hJc1YzcU1x?=
 =?utf-8?B?ZUV3SHh3OStYcVVZSDRKM0tPbSs3RmIrWExIbEhwclRFRjdmWEJwZjJWdzhu?=
 =?utf-8?B?M1B6TlBKeUFTbmRGRFYvRTZkOHNNZXFOQnRsdWk1dDZneWE4NDVLTWp6dVBw?=
 =?utf-8?B?bzhnZGRTQjVjWWRZamNMUWZ1bTQxaVRhT0FLY3o2K2JtTnR5MDVKNXRvOXZZ?=
 =?utf-8?B?TlNWR0ZYc215eEQrS1BqQnpWVldzczlWd2U4bUYwK1pYTVRsRlhDUnFpQTJy?=
 =?utf-8?B?UkszNzdLd1J3QXlJVjd0VDNXM0pBVXFnTU5RZXBQNGRVOGMrWHFkTzBEdm9v?=
 =?utf-8?B?eVZPRlJDN3MxRll0clZPQllacC9YVCtPNW1jUXlyV1I2d1lySGdZU3ZjV1Vt?=
 =?utf-8?B?V3Q1UGtheE9TU1g2VzJ3L1ZIN05mT1VQWVJRNWJ3MXB2eXNBK1lBcmxMSVdC?=
 =?utf-8?B?Q1VuWVQrZGoxL0FKbkJ5RjNUS0RUbmswOHlvNkJOL2lxTnF4b21EblFINlBw?=
 =?utf-8?B?cXh1eGJiRmdwUTdPNGJzcEc3WkpVZHAyNng1NVIzNXNySW5RdzJjQk9qalBk?=
 =?utf-8?B?SmxDYUt0T1BqWHhXZFdRVm9Qbm90aGVCSHZYYTY5NUpLQ0d2SndaT3R4bmhL?=
 =?utf-8?B?Q1V4S3paSWs1SDN1VHhJcC9kRFVsWmxXMWVEN3hkQlFXWFFsVHhFQ3A3eGda?=
 =?utf-8?B?UU5mY0FUdTRENFFweWdpTEZRZ3g3TWIxaWpsU3BQSjFuangweldmMklEa0t1?=
 =?utf-8?B?UzhxWHJKZ0tTYTFvNUVRTE5IZ1NURkQxbk5ybDQ1YWpSZFU4WmNYeHl3V1Aw?=
 =?utf-8?B?TDdZZllJS0R6VFBGVVBCR3hRbDVucHc0WVVIQXRLdVZnT3ZvV0IvWm82WDdF?=
 =?utf-8?B?clV3S1lHN2lzeHYwOXRpUGJwMGI0eDlqTGk1NWNPZFgzTTg2Y3k4aXZ1ZVB4?=
 =?utf-8?B?RDVZaGVDMVBHenY5cmwxZzl0cWlQWHoxaGRlMU03bVZ3UXF2NFVTVkN3VGJB?=
 =?utf-8?B?N3hQL0NvVVpqbU9ocWZNbVJtNVVRd2ZIQkc0ZG9KbmM4b1p0TnlodnVDTlRl?=
 =?utf-8?B?cTFsQ3E0SXBNejNGWlhPS1JoWTVzOVBWTk41ZHVSdlRhcUZTVFNYYWdOWUl6?=
 =?utf-8?B?dERRVTVnVkpIOXdUQ2g4LzlXTWt1ZnJ5dWJKZ2llWDdkTERWV2hxMTBpUC9T?=
 =?utf-8?B?MVg5R0V0VjFtekZycXJqWExQVTNwbWxSdmxpTVA5SUphRG5JeVdDWEcvVEZi?=
 =?utf-8?B?dzB1WmVGZWV4TXkreUlkejZ2S205ekwrV01oSkxDNTVrZTB3dW1jVTJjYUVY?=
 =?utf-8?B?OThCYXZzNFNSVTNwZmRQN05OZ21Ka1BqRFBRZW94VDR5V2VnaDVUeVhsQWM2?=
 =?utf-8?B?YThJbG96bDEvMDlTbDZzMzJRNnZheTJpM0E0czJkZCtnNTNJTGVPcU9rdFcz?=
 =?utf-8?B?RUwrR3ZJQlhML1JCWExxVmZOaEcxTUhGUTVTY1JYR2xJRjNVMVFncXFOMGsz?=
 =?utf-8?B?cHBpdW5uVHUwSmxtSjl1a3hWSXBUOHI2TEtvcC9rYWN4bnNKdUdKVUZDMjhz?=
 =?utf-8?B?czJ4blU2eU13ZTliN2hDa3dyOWFTQ2hldGp2M29JMHRUVGE0YUthQkVPM0V0?=
 =?utf-8?B?RjVFNWxZRFFzdkdKN1lCZU5aaWZGUnVPU2JjdU5ManlPNjNHN2tydzAvbGVj?=
 =?utf-8?B?Y1lzbFo2RUM3M1A1dWJ1bVpiY0ZzYjFobDRNZFZVdkVCS1Z3dXVTM1NRdzhl?=
 =?utf-8?B?TWd0eEoyZXNKMTR2YStMcWozanIxMmRhQlRwWHNzbW1tY1RxWDNMN3dMdFVx?=
 =?utf-8?B?eHllQUJ3TzdmNUlONk9WdFVnTXA5S21aeGFGWnpCdC9XMGZ0ZVJUVmh4czhG?=
 =?utf-8?B?eHM1bGxkVXRDZGxrM0Nvcy95aUNJVklBTEdXWmpob0dUdzFueFU3MWo1WHlQ?=
 =?utf-8?B?NjZhcnA3V0pNRmNja1lxamJkazA2TkZVTU50bUs1R1R5VFpOZys0bnhReTJ6?=
 =?utf-8?B?U0t1NlpEeEVBaFErWEhWUW9jY1U1ZnBLRW1QNDdXVDZ0NVl5MUFxUGJYSzQ2?=
 =?utf-8?B?Znc2djE0NFlsSzFROGZTOE00NkUvTWVrT2xNeUQvbDQ4YkpjSzh6VGRaV0tM?=
 =?utf-8?B?eVc0VXBjVllKS28xdzJnWlRLNWpScU53U3paMlNPbmhPcHVFNmdUYm1CSEhO?=
 =?utf-8?B?Nys4RVF1UmtZLzFxcEJ3T3RXL2dBaEFDNkpxeU1CWFBVK2ptaEw1bzBJQlFi?=
 =?utf-8?B?WDZKOHNvbUxCQm9SaHVPM0hiTFRkWEtNZWpVU093QnhHTlhwMlllQT09?=
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
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a9ea2c-8d96-4135-bbd3-08df388425c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 01:53:53.0042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sp0wjcPHNot9OAfy7ki7SdvwYltAIC2uwqzNINMocpcwaCYLYTQzQfnVUcDB8RT5DwP8/Dsfn3DEjPYgVfiUsaeCgQZGZ5bvnPe7z8QpnsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP189MB1827

PlN1YmplY3Q6IFtQQVRDSCBuZXQgdjVdIHRpcGM6IHJhaXNlIHRoZSBtaW5pbXVtIGJlYXJlciBN
VFUgdG8gZml0IHR1bm5lbCBhbmQNCj5jcnlwdG8gb3ZlcmhlYWQNCj4NCj5BIHBlZXIgY2FuIGxv
d2VyIHRoZSBsaW5rIE1UVSB0byBUSVBDX01JTl9CRUFSRVJfTVRVICgxMDAgYnl0ZXMsIHBsdXMg
dGhlDQo+VURQIGVuY2Fwc3VsYXRpb24gaGVhZGVyKSB3aXRoIHRoZSBtYXhfcGt0IGZpZWxkIG9m
IGEgUkVTRVQgb3IgQUNUSVZBVEUNCj5tZXNzYWdlOyB0aXBjX2xpbmtfcHJvdG9fcmN2KCkgb25s
eSBjaGVja3MgdGhlIGxvd2VyIGJvdW5kIHJldHVybmVkIGJ5DQo+dGlwY19iZWFyZXJfbWluX210
dSgpLiAgVGhlIHNhbWUgYm91bmQgaXMgYXBwbGllZCB0byB0aGUgZGV2aWNlIE1UVSB3aGVuIGEN
Cj5iZWFyZXIgaXMgZW5hYmxlZC4NCj4NCj5UaGF0IGJvdW5kIHByZWRhdGVzIHR3byBsYXRlciBy
ZWR1Y3Rpb25zIG9mIHRoZSBsaW5rIE1TUzoNCj4NCj4gIHRpcGNfbGlua19tc3MoKSA9IG10dSAt
IElOVF9IX1NJWkUgICAgICAgICAgICAgICAgICAgICh0dW5uZWwgaGVhZGVyKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAtIEVNU0dfT1ZFUkhFQUQgICAgICAgICAgICAgICAoQ09ORklHX1RJ
UENfQ1JZUFRPKQ0KPg0KPldpdGggQ09ORklHX1RJUENfQ1JZUFRPPXksIHdoaWNoIGlzIHRoZSBk
ZWZhdWx0LCBhbiBNVFUgb2YgMTAwIGdpdmVzIGFuDQo+TVNTIG9mIDI4LiAgT25jZSB0aGUgbGlu
ayBjb21lcyB1cCwgdGlwY19uYW1lZF9ub2RlX3VwKCkgY2FsbHMNCj5uYW1lZF9kaXN0cmlidXRl
KCksIHdoaWNoIGNvbXB1dGVzDQo+DQo+ICBtc2dfZHN6ID0gKCh0aXBjX25vZGVfZ2V0X210dSgp
IC0gSU5UX0hfU0laRSkgLyBJVEVNX1NJWkUpICogSVRFTV9TSVpFOw0KPg0KPkZvciBhbiBNU1Mg
b2YgMjggdGhlIHN1YnRyYWN0aW9uIGlzIG5lZ2F0aXZlIGFuZCB0aGUgcmVzdWx0IHRydW5jYXRl
cyB0bw0KPjB4ZmZmZmZmZjA7IGZvciBhbiBNU1MgYmV0d2VlbiA0MCBhbmQgNTkgaXQgaXMgMC4g
IG5hbWVkX3ByZXBhcmVfYnVmKCkgdGhlbg0KPmFsbG9jYXRlcyBhIGJ1ZmZlciB3aXRoIG5vIHJv
b20gZm9yIGFueSBpdGVtICh0aGUgdTMyIHNpemUgd3JhcHMpLCBhbmQNCj5tc2dfcmVtIG5ldmVy
IHJlYWNoZXMgemVybywgc28gZXZlcnkgY2x1c3Rlci1zY29wZSBwdWJsaWNhdGlvbiBvbiB0aGUg
bm9kZSBpcw0KPndyaXR0ZW4gd2l0aCBwdWJsX3RvX2l0ZW0oKSBwYXN0IHRoZSBlbmQgb2YgdGhh
dCBvbmUgc2tiLCBvdmVyDQo+c2tiX3NoYXJlZF9pbmZvIGFuZCBpbnRvIGFkamFjZW50IG1lbW9y
eS4NCj4NCj5XaXRob3V0IGNyeXB0byB0aGUgTVNTIGlzIGF0IGxlYXN0IDYwLCB3aGljaCBzdGls
bCBkb2VzIG5vdCBob2xkIHRoZSBmaXJzdA0KPmZyYWdtZW50IGJ1aWx0IGJ5IHRpcGNfbXNnX2J1
aWxkKCk6IElOVF9IX1NJWkUgZnJhZ21lbnQgaGVhZGVyIHBsdXMgYQ0KPm1lc3NhZ2UgaGVhZGVy
IG9mIHVwIHRvIE1BWF9IX1NJWkUuICBXaXRoIHBrdG1heCBiZWxvdyB0aGF0LCB0aGUgaGVhZGVy
DQo+Y29waWVzIHJ1biBwYXN0IHRoZSBwa3RtYXggYnl0ZXMgYWxsb2NhdGVkIGZvciB0aGUgZnJh
Z21lbnQuDQo+DQo+UmFpc2UgVElQQ19NSU5fQkVBUkVSX01UVSB0byBNQVhfSF9TSVpFICsgMiAq
IElOVF9IX1NJWkUgc28gdGhlIE1TUw0KPmNhbiBhbHdheXMgaG9sZCBJTlRfSF9TSVpFICsgTUFY
X0hfU0laRSwgd2hpY2ggYWxzbyBsZWF2ZXMgcm9vbSBmb3IgbmFtZQ0KPnRhYmxlIGl0ZW1zLCBh
bmQgYWRkIHRpcGNfYmVhcmVyX210dV9mbG9vcigpLCB3aGljaCBhZGRzIEVNU0dfT1ZFUkhFQUQN
Cj5vbiB0b3AgZm9yIENPTkZJR19USVBDX0NSWVBUTz15LiAgVXNlIGl0IGZvciB0aGUgZGV2aWNl
IE1UVSBjaGVjaw0KPih0aXBjX210dV9iYWQoKSksIHRoZSBVRFAgTVRVIGNoZWNrLCB0aGUgbmV0
bGluayBNVFUgc2V0dGluZyBhbmQNCj50aXBjX2JlYXJlcl9taW5fbXR1KCksIHdoaWNoIGFsc28g
Ym91bmRzIHRoZSBtYXhfcGt0IG5lZ290aWF0aW9uLg0KPg0KPkZvdW5kIGJ5IG1hbnVhbCBjb2Rl
IHJldmlldyBhbmQgcmVwcm9kdWNlZCB3aXRoIEtBU0FOIHVzaW5nIHR3byBuZXR3b3JrDQo+bmFt
ZXNwYWNlcyBqb2luZWQgYnkgYSB2ZXRoIHBhaXIgKHNlZSBiZWxvdykuDQo+DQo+Rml4ZXM6IGZj
MWI2ZDZkZTIyMCAoInRpcGM6IGludHJvZHVjZSBUSVBDIGVuY3J5cHRpb24gJiBhdXRoZW50aWNh
dGlvbiIpDQo+Rml4ZXM6IDIzMjBiY2RhZTYyOCAoInRpcGM6IGZpeCBjaGFuZ2VvdmVyIGlzc3Vl
cyBkdWUgdG8gbGFyZ2UgcGFja2V0IikNCj5TdWdnZXN0ZWQtYnk6IFR1bmcgTmd1eWVuIDx0dW5n
LnF1YW5nLm5ndXllbkBlc3QudGVjaD4NCj5TaWduZWQtb2ZmLWJ5OiBKb2FzIEFudG9uaW8gZG9z
IFNhbnRvcyA8am9hc2FudG9uaW8xMDhAZ21haWwuY29tPg0KPi0tLQ0KDQpSZXZpZXdlZC1ieTog
VHVuZyBOZ3V5ZW4gPHR1bmcucXVhbmcubmd1eWVuQGVzdC50ZWNoPg0K
