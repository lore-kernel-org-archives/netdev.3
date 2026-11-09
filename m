Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794217520;
	b=BnP12VkCBBSX9ttjGXtuPD7ALreLeIAxCI1ghkHv/LXvFWfJiSXoxxPZRJUTdP+mbnP2
	 2B7r8+OlMzOgvQoYWe7/13g2vX/tiiaFosG/aZtT/VkFO/6KX9fgcrxQy+snlPH6aRE7/
	 BYg4iVJqtJiIv7WQnVS2r+okmilZsTjgkLG97gtrJQ9AVirwsipn6a4MmfiyNmsBMKA7m
	 1F4PIoBrkEekwbsBt1DzLEt0kCrGLVngCh26iY8+Fu/MhKR6fIWgsgR6mZoRRyYpWhQgD
	 Uqg/EYr0/Xi7ipbQ7gaDVghPPKItMaUPAXzbHpih9mE7EeaKvgK02TlNBDsP9kZu31Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217520;
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
	bh=0ZnAKrE+bLVMppBTDLT7h5cJ6Tmoi2tsT0BuQredjeY=;
	b=ic/4oGpnda98DTo8iFMbMLIV/r6cTJX99GnxrAdzpMTD7CiInU/dkp+faXlYx4syy4SG
	 wtDfnEko21ax0dOTTDl+INh9wdQwFcffQ3nyUwUdR2MIsSx36GK5JzrRu5FNG6ODyv8W4
	 84+8LRHifYWRUaO0NpP52nfEEsZ/cIQPaqkPpzQsMGkdnjUsDsUc6J567CbmeTURYxZ2j
	 PICOgUlwBoLoOFei9rdX2KiER0epo8opLRi8p7u8vZ8GHgl9G1tZMfbTR/jgx6tGgyVcH
	 Ebb4MnBGCRNVA4FWF6bvSXNXuRPsCXn95dJpvKL2vfGgh+v7wTStLFMfcGUJI70otpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=D1eO8FPG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.46
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF275606A31C;
	Mon,  9 Nov 2026 09:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF275606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=D1eO8FPG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSosJ1zauTsAus7B3AgLpJEXInLpdjDqCWE851+UjdI5RjKdN4nos2+31ZlgJABOHczD551mMXXMUcaGnsdCOauKvDnFNf4clc1vUx5HBXtkT75EExmcrss3iczE7VVHk/JIeV96ecMbYkbbSZAqmNwY8DhLjTpzEJjemtJvF/NMNLh3lGzSccJj30VzOs7wajZTimAt01Xg/eEl1ue4sQ+Dwib5giQSs71ISIUZiHQTKIFqGvLyeGnhKswv3RskpXEQrrDiePEKXUUq7mBr1d0GsUDl2K3wsGCj6M/+QDp/1+hfwKJyvyLKCIBqeZ0llh49QrIA/xDG//FCALWpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZnAKrE+bLVMppBTDLT7h5cJ6Tmoi2tsT0BuQredjeY=;
 b=KjJXzIbYZwMMHZxFbmoI566cZrXKIf5JJZSTukiFb3U1wnTYcuXd6QvwvDfZ5a59dLlIVnuJOcsrTLs4bH/uLyO0y0z+xi2EeKVDnl5nEDyKcQE/RAvoTF7e1FRg7usZQdoDV5qlS6fB8b+XHgSLru35G3GPScXLH+vYKj9Qnmr62fAXuCtS50Y38xmifgaG1CqsoAs1rPN68qtRnEItDT6O2MT9iq1jnrh4h/l9wVXqIvz9Y0VigT4gfB70aeGyCTw3VEikGKBggmdVH3CgjhkNzRlgrLbX02GkUam7iuYeQkUXHxytl2c0vUbPbrBX71Luao8NuGYDcjhWRc55kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZnAKrE+bLVMppBTDLT7h5cJ6Tmoi2tsT0BuQredjeY=;
 b=D1eO8FPGcni26ELcxyBkhDCBiLbPBXu7+DMDsbIf41VqzujlyVil7a1UZk7Q3fDiXwXbrF+o8hGbry3Ve5cWyrWgkxoH/WxCwOXgBfVNGEp/izDVxAYdkVbVnHkfDFzpAErzdLV4AvQfZsJP1ki1mxeMC9t3h6yPeu+6UWJtvsSMonjjmVhO3KdCixjUHfnzkUe+uXtYubbiwp3ZQUzFPTOk9abYZNhue859KO+7pLnYNxQEVShtbqrWLiBKJ5ZLJCRHg4OA8jfXlut4TEYU/eij6Yprct7QoZUk4BYvwUYFspj8iGwfB7AyOrKvjmIKYWfK4DL03keQJDWUb/6FnQ==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA2P189MB2635.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:40a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:45:16 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:45:16 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Noah Weinberger <NoahWeinberger2003@proton.me>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH] tipc: bound reassembly size in tipc_buf_append()
Thread-Topic: [PATCH] tipc: bound reassembly size in tipc_buf_append()
Thread-Index: AQHdb9AiZNdI/aFN/0i/7RwovwEqUrclfJFg
Date: Mon, 9 Nov 2026 09:45:15 +0000
Message-ID:
 <AM7P189MB113732F9A1E2C9DD3C9E3F48C6732@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References:
 <AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg=@proton.me>
In-Reply-To:
 <AoU-V5M5ZCKF37bLl8ILhgeNdsnCEaiaQNuWP4K56kRfJsnhkIexZ8tFRLq7uzGiA0qNqK6shXcSZ5E4hyV0-QI0ZWSuKiJzKvMrv3NfqCg=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|PA2P189MB2635:EE_
x-ms-office365-filtering-correlation-id: 2d379eae-af79-4657-776f-08df3e46289d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|3023799007|38070700021|5023799004|11063799006|56012099006|10067099003|261026121527099003|261102123227099003|261021121427099003;
x-microsoft-antispam-message-info:
 9WDxDMtLzKin5l4PvFWq9jhPEBv23GeYAwwa2BohVg61GXZcaMpbQtj1anHwJLg4dNpNpf6A+hR0KqwMKlYHoxd4UdP75vkHyvIKCaV4lpel4ZrSS4XKQ+HusyGiAVvBMmiBQ3s+SoOH+t5effDSkKrz77D0eqVhON82IsPr1esyZ9Mp4+r11w0hfQX1uE3v2VLwegi4dpu3TlTbfmqJ3cfA+DvZVGpKnz6v6AsGwyJkuJoCEoxu77Dl2r9+jEGCjAbl/goLUoW/SKaMJdccGL+hL3VA9zBEciJNZUwyrkqA7V3wM+TvQbgJlFa8RnIUs+voUZ/036paI8EunKjfMgiM8WimFgLhxSUBmQ4DUk3ebqWRNc7u+IMeLMvCEeAuWJvaq7OJYr8hDR1KalGEtdazCKkCZU58c93nisjNiktshBhsGbPRXMdpzVzpFJ36SsIxUjbfAeU6wq4DCxZI2jtv0Ju0M7UckjO2R3xdQT3Pzk8fp7XQh90rGcVYgnV1YouB0asUZn8dXQfWbJvKxEH1xSA8bn02ELPlLffNbnsrEQYZRgRmPmPoMEBuJSbXNzwQJdFx2TjSBZHDwuaWii4/Fq1bNJ7NlGHwU0QWxcuym+ZokITc+KU1mCkp0lJ6Ppm+kxnv+Y0fMiikVG+NRyD2IharEqTjCKTFkzCoHj7CI8Qoye3XgjGwBUfxIg7uXEFoLfUjetT5kmt52aD1NzxLspaWLia4aMf86qMI9vk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(38070700021)(5023799004)(11063799006)(56012099006)(10067099003)(261026121527099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTFpSXp5N3p6SmVRbTdGN3ZtcDZKWWhJOXdkZnJacnJpNnVSUGY2dWRxUWNw?=
 =?utf-8?B?VC9RVC9TdVEyaWJ3WENnbXJxbXk2V3dDRmZKeGNEblhobG5GUXdodEZ5WERk?=
 =?utf-8?B?RDVPd2IvWnlEWWlhYW1wWjBLa0tCZmIzMzdUK1RQUm1oVElFalB3VVN0WXRp?=
 =?utf-8?B?V2xNOS9XaUptMUlHWjJmNm13MGUweXN2Z25Cb0JMVktKc1UwRXJGOFZheE5F?=
 =?utf-8?B?SndkWVAxQmZxRXQwWFpqcGtxRytLVGZnOWJzZ2sxc21FNzhMSWRhT1NnNnVX?=
 =?utf-8?B?Ry9Tb0luRVJQNmhpcE8zeHd2RlRxNVZJbzFMVmFCc014UUZyWTZscHB6bm9n?=
 =?utf-8?B?SFo1dG44RGxxOTdXQWovcjZnVzBLMEthaE9pWVQwbmduRzFkVkRCR2FkZFNV?=
 =?utf-8?B?SC9melZraEtWTElvVThlR1JGbnUvZ3ZzOUMxdW1RS1hsY3JPUHNTbTF6Y3Y0?=
 =?utf-8?B?M0hYbUJNSW9uOGVmTjYwU2hRWVRjeHk1Rk1SMnBtWTBMTWFHeHAyWVkxSGRh?=
 =?utf-8?B?MU5EYThDdVVtRHJidjlwSEE4OVpmbWVoZWxscTl6UHBqN0JyWVBraEJ0Q0Nk?=
 =?utf-8?B?b2VXdmdSSjBEZ1NZeHU5b2NnQXJrNkRkQUgvNFRHNnhXNmFxM1Q4L3U5MVZL?=
 =?utf-8?B?ZmpaSy96WTFXNFhOUnQ1aTNHdGJtY2l0cG9hNW1OOUlhTHdkTFM2ZDk2NzBR?=
 =?utf-8?B?cksrcXRsYW9qVGRia3dOS0Jwa21rbkxuOG9za2FWWVh2QnJwUmJSUHdxRG94?=
 =?utf-8?B?S01zZ2JpY3lHd1hGckxsMURLV1AxUmZ3ZFp5UU9rNkc5Y0xFUFVOTDVpdkFT?=
 =?utf-8?B?NjIvYzhHcG5DSDFCRlMzQ29uS2UyTHFWakJFWHByTWJPbjFEa1VuMGVPcFZW?=
 =?utf-8?B?TEJLRHJBeUpYaFVNdlAwdjR4YlZrOW1RVEZDUDVJSWlQMEFsUnBST010L3hz?=
 =?utf-8?B?dnpSN2RZMTVmOUVsdDQyMlBzNStHL0RoOHZLaTc3N1d2VWVBTUFpZ3AyanV6?=
 =?utf-8?B?REtrZHRRK0p0UHlIR0tsbHhVWkYrNFdJRlpHQVFFUkdCSUFWNUl2TXcxWjRl?=
 =?utf-8?B?TEZDU2dBem5YV1dneTVnOU1xMzM4b3FkVTVKNnNTbmVQNXhkdXFROUV6RDdT?=
 =?utf-8?B?RW5GQ3Fqa2lrVTN3cUpoSHJyL2lZZjIzcllRRVJDU2JUQUpmd0ZpdzFoY3lM?=
 =?utf-8?B?SWNUeTA4Z3d3NkI5ak5vNzNpaTdrVGh2OFRhQUlHZUR5WEhjTkhmVW03Sjl3?=
 =?utf-8?B?NFFMeWUvNmgrWGE0Ymw3SkZBcS9oZlNTOGlqc3A2bndQK2lmRGlzWjYrczV0?=
 =?utf-8?B?RHZZVWpNbXZLaWRwaDNwc1NERWQ2ZzNiYVFHVlZIcWhWdVVnRE94WGROcEx1?=
 =?utf-8?B?Qy9BNTJzNHJzMnNRYy85ZTJSM1hjUnZVOXQ0aGdHNFpYUFhYNFl3azFxRVhK?=
 =?utf-8?B?bGxxbmMwMGI5NzFZNGZ0cUplRG16L25keFlsVTBienhBb1NWR3BndUN4bVpP?=
 =?utf-8?B?SEg0V3pqZHV0NE94a3JaSTlVUEx6TmVMMjM3aDhVL2xJcmlQQm5pRzhma2FS?=
 =?utf-8?B?L2VWdkxGK1Z3NmVPY05DR2dnb21BNVVPSEpLNVAxVWo4dFR2cjNBQ1FTQjNS?=
 =?utf-8?B?dE9laGMzZjljL1BxazJYbGQzZ0QvK2haWTMveXM1R0xUeHR2Y1ZOOWliYzFs?=
 =?utf-8?B?U0hVcENvaU1ncysveHlZRjZWTlF4YmN1OHdKWnVQVURJdXArbUduT3A2VWRO?=
 =?utf-8?B?Q3VHSm5vWC8wWUlHM0F3dVFiSzlWT2krME9HTEVpbUJpZVlablNBTWk3MmJk?=
 =?utf-8?B?Zmtnc212U0NlQkZ2SEN3Z04rdGphdklMTmY4bW93dnhxRVc2ZVdwYXNqMHdB?=
 =?utf-8?B?ZUxBTXV5Rzhwcmx0NGRoVjVCNmZpTDVha0h3RHRFWVM5bmtDYmNuVmtMVVEv?=
 =?utf-8?B?UzVHMEVpWEdCRVhrcTZCMHUyYUJoNm9OQ1V4ajFzdTE2QUswNmlNeS96Wk9N?=
 =?utf-8?B?NzNoanhiUnlFNDhOcFpSWU5VRDBYc3QvQ2IzZFU1ZTMwUUtncGZNMzIvV01C?=
 =?utf-8?B?UFV2enhQcHQ0UzYvRWJqWU92cTB1RFNqZGh4bnFYQ042ZmJjcWxHcVdMTnVS?=
 =?utf-8?B?aXlLdndTeW9nM0ZVeHI2YkltcWlUMytqci9Dai81VnNsN3lMOTNMaW9DZGgy?=
 =?utf-8?B?QzdFSFVDVDAxUmNORU02V1pwMFNBakFsSXI2c0Q5aUdIQ2srTkswNVdLNVVP?=
 =?utf-8?B?SmM5em5SMnhDdGxqTWU2ZmZncFIyaGc2K2pVU3BuZ0Z0aUdTYUQ0R3J4UlZn?=
 =?utf-8?B?bUFiYXlrY2dhb2JjRzFHWllGWXFtMGRDWng2OGJLcnpndlRsQ05wZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d379eae-af79-4657-776f-08df3e46289d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 09:45:15.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLE5RmmWLgePsk5EL5mTCYhYWq+yPWUxtJs7albSF6Ew4voCP6crLMrkoRhB7bfvS7hOjoGjEEZHg5HItnZPpliaJjZc9cFLeqv26lk/epY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P189MB2635

PlN1YmplY3Q6IFtQQVRDSF0gdGlwYzogYm91bmQgcmVhc3NlbWJseSBzaXplIGluIHRpcGNfYnVm
X2FwcGVuZCgpDQo+DQo+SGVsbG8sDQo+DQo+dGlwY19idWZfYXBwZW5kKCkgYWNjdW11bGF0ZXMg
ZnJhZ21lbnRzIG9uIHRoZSBoZWFkIHNrYiB3aXRob3V0IGFueQ0KPmN1bXVsYXRpdmUgc2l6ZSBv
ciBmcmFnbWVudC1jb3VudCBsaW1pdDogaGVhZC0+bGVuIGFuZCBoZWFkLT50cnVlc2l6ZSBncm93
DQo+d2l0aCBldmVyeSBhcHBlbmRlZCBmcmFnbWVudCwgYW5kIHRoZSBkZWNsYXJlZCBpbm5lciBt
ZXNzYWdlIHNpemUgaXMgb25seQ0KPmNoZWNrZWQgYnkgdGlwY19tc2dfdmFsaWRhdGUoKSBvbmNl
IHRoZSBMQVNUX0ZSQUdNRU5UIGFycml2ZXMuDQo+DQo+QSBwZWVyIHRoYXQgaGFzIGVzdGFibGlz
aGVkIGEgVElQQyBsaW5rIGNhbiBzZW5kIGEgRklSU1RfRlJBR01FTlQgZm9sbG93ZWQNCj5ieSBh
biB1bmJvdW5kZWQgc3RyZWFtIG9mIGluLXNlcXVlbmNlIEZSQUdNRU5UIHBhY2tldHMuIEVhY2gg
ZnJhZ21lbnQNCj5jb25zdW1lcyBhIHNlcXVlbmNlIG51bWJlciwgc28gdGhlIGxpbmsgcmVjZWl2
ZSB3aW5kb3cgc2xpZGVzIGFuZCBldmVyeQ0KPnBhY2tldCBwYXNzZXMgdGhlIHdpbmRvdyBjaGVj
azsgbm90aGluZyBib3VuZHMgdGhlIHJlYXNzZW1ibHkgaWYgdGhlIGxhc3QNCj5mcmFnbWVudCBu
ZXZlciBhcnJpdmVzLiBUaGUgaGVhZCBza2IncyBmcmFnIGxpc3QgdGhlcmVmb3JlIGdyb3dzIGJ5
IHJvdWdobHkgb25lDQo+YmVhcmVyLU1UVSBza2IgcGVyIGF0dGFja2VyIHBhY2tldCAtIGEgcmVt
b3RlIG1lbW9yeS1leGhhdXN0aW9uIGRlbmlhbCBvZg0KPnNlcnZpY2Ugb24gYW55IGhvc3Qgd2l0
aCBUSVBDIGVuYWJsZWQgYW5kIGEgYmVhcmVyIHVwLg0KPg0KIFRoaXMgY2Fubm90IG9jY3VyIGJl
Y2F1c2UgcHJvdG9jb2wgbWVzc2FnZXMgYXJlIGd1YXJhbnRlZWQgdG8gYmUgc2VudC9yZWNlaXZl
ZA0KKFRJUEMgbXVzdCBiZSBjb25maWd1cmVkIHVzaW5nIElQc2VjIG9yIEVuY3J5cHRpb24gc28g
dGhhdCBubyBjcmFmdGVkL2NvcnJ1cHQgbWVzc2FnZXMgYXJlIHNlbnQvcmVjZWl2ZWQpLiANClRo
dXMsIExBU1RfRlJBR01FTlQgaXMgYWx3YXlzIHNlbnQvcmVjZWl2ZWQuDQoNCi0tLQ0KcHctYm90
OiByZWplY3RlZA0KDQo=
