Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868A49D5B5;
	Mon, 19 Oct 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399898; cv=fail; b=I5kwpiipXVra/AttVX23eliHivA+gT4FnAVe7RFemom1Un4fFzCnEIUK4itlX7aNUzgQ7i+nyuMJ3l8Y9mtsoPepvUu4rmifImgEkNL0gKG3Q7d+ZjftMUiMRWrY0gowHFuPV9oU6tNwSrJgBvEAUJkFMk67ptcvkelfNGO4s5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399898; c=relaxed/simple;
	bh=Rr2Oc8ZlXzp7rDr5XMP6ynjALaCAMUtgNdLpaKFGGy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kAN9yovWBlchY4oi87+ZXAwsfXCBuaRHkaUf4DRLe3yRp8UnsQtkXHSHT0s7C4O9UyPkDMQV/di6UyqpIKj7PnycqIBxVG9Emz+ans39B9e52IpXlolYSpDCLPgCQdp2PfM8P5UI4duyCx8/U7UANsD0CqMefoIOYM+RRaKfUOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=InrxZGS1; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="InrxZGS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMJ/28ycXreJoqi808qGd5a0X9oyG+eAlLYWtSpsJoAw0ItnKxpgWIJpQAIDqiAsv07SwZkGLg+nFeJSa6tisW6fxkbGKhjabQMHFvGzVNs6FuZRSzL/RcJz8QeWVbykFFp/ygeo7pZxo70azaYGxm2PUoptXZrUiPno4kca5WZs5MjYDTL0HP7934fVmXEtkkeawyL4JG5l4rRCtdYH/5dWmy7ZWqyicG/xbnApeROI9/197LeIQ/lRje2y9VyDhB2GHpUoAd2szQsvC7jMbEaDISWzX7Y7xWF4sKW7Abl2PXvR6nPz2aB3D49jGPvVcXwOCrkjCal236Rit6+9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr2Oc8ZlXzp7rDr5XMP6ynjALaCAMUtgNdLpaKFGGy4=;
 b=dpdgUJ5hA/imI9orJt0T26CXOaWSOdiwaxWdhQju0+faBja8Mqt7ONEcNk9MhaByoNLjwDXoB1MeKmambSH4fkVlEv45uRTigFBEd42YXSDb6w4Uuhw5unKTNqkm1nShdIIKDkJI8Cb1f9x69KG3RVzEDR5lg5AlrdtSt2g/kY9N4Sqc4S9rNvBi/JgQEjqJbiHs5y8gz+casZs+JR/QndWPgQ/ydQT5F36q0CY9dvVjt7EIMBqh0Q8Z8qUTKoL+GvVdgPu8RoVFHBMtQgCI2nsOOVUacPw5vLTtQjTnY0AQ+0pisuxvyHrfLpdOucic0p2HgscAfuE1bmx50/tHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr2Oc8ZlXzp7rDr5XMP6ynjALaCAMUtgNdLpaKFGGy4=;
 b=InrxZGS1rMWwkFs/XN1BJU343k4UV3qP8mueCegzREuRQM5RuttAvZUtcCa/8bvH9I2sIy5CJ3pb8GU0kOnVS8VJ7sNiazSFXrVar4WFFqjacSJOh9s+KsDuvaorQfiSFjIXtE42rrLI6u7E7Z4h+JXqDeLQUd3bAgcUbPgwBao6noNYjepaVXGZNJ0p/uTQ0W4MUszoXB0TWPX79WXvPlPV67wl15gYrCjYJy91gpScDZ0vFx8NJ9/ve7wYKjmRmaWhgSvHMhVZlqiQ3NZx5WXd/1mAf385bQLS9a9vAqc3fL3MCfe7mBI+YYAUzfes9ZF25OEoD+W6lA7igeQu0w==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA4P189MB1229.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:51:33 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:51:33 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"18983559317@163.com" <18983559317@163.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v1] tipc: fix use-after-free of broadcast reception
 link at node release
Thread-Topic: [PATCH net v1] tipc: fix use-after-free of broadcast reception
 link at node release
Thread-Index: AQHdXFu6fnDB+oehsE+RzoMyRScJnLcESD8AgABLQ+A=
Date: Mon, 19 Oct 2026 08:51:33 +0000
Message-ID:
 <AM7P189MB113773C71C4C14959CB38E5AC6982@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261015041435.33561-1-18983559317@163.com>
 <179238333253.3135.7191451921379768629@kernel.org>
In-Reply-To: <179238333253.3135.7191451921379768629@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|PA4P189MB1229:EE_
x-ms-office365-filtering-correlation-id: 1d3aaf96-0183-46a5-f47b-08df2dbe2d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|4143699003|11063799006|56012099006|261009223327099003|261009220027099003|261009223027099003|261009221727099003|261009221227099003|260925021311599003|260925022911599003|260925021911599003|10067099003|22082099003|20052099010|18002099003|6133799003;
x-microsoft-antispam-message-info:
 7KXNSTkW6WV1u93Zy9uSHC7f3lh/qw6TQESmcCjP/GfyXdR7EpPPjaqLVtzQqMDrugxW8xr7Qfuu9NtSHKyBsftIe2u+R3U4UvQlUBMueLNgKEgnwwBAMkSSiSP2OQKbjc+yGKfajMxHnCYEJZHnleybXeyWVJco+MDCzaB4ZyaQ+C3aFZTBufaUVtFeKeL3V0bhJTKo2nTnQ+mhb0LWfRVyElHtz8cOYxkMBW9jCvcud2hYEHlNCf6+K5FbUrXvz0a9bI26FkqPEJ5tTY2bLhL+PNHT1o/CoDbC4VNLscBwCJm+f0+KVk4AywPMGyLgo5saLFBpbbJvYi2Xo9mkkM6kmfWmD6uQefB+Dv78mI7ULIdtJ/YpNKM+uwgAf636DpGITc5f88YQTHJMM4h3uCMkA4OLOQ8+RlmxBnJkxX5JqxCWPkmDINiP3z5Gp7+b9od27HOmxvqmTNepAhiC7z9F+00BaBkbOfDVHwTTYrGCWo9jwWZCIy9ajr5FM4v3FomH0tR2/j1kWWLlgxRFcKigYLr6ZIMwbnvYxXaeHF0uMDPWxXeYD6j01f7r4WGLw2/umjbcxqaYM2+NfyON4iJkPvT2UIhAA53MCy+18RDTnLovI/aLj+AlsIkPWoBcF5DbjM97yYNbE00RI8Kia58rJz9tNGo7KGIoqgF5/031nKP53Ksf9kb4W1Oz+/+ZHALObIvkduEU97YTEoUjr0e7VVL4yefAYKb8uL/n13I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261009223327099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009221227099003)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(22082099003)(20052099010)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZExueDdwWUE0MVpvK3hiM3paVllnaTNEUWI4d29jNDRxakdpRW1xZzViU2FH?=
 =?utf-8?B?VmsvbkdXcm0zZHpYUXpaQitpREh1cTdFY1J1RFR3cDlQWXdabXB6THBmZUsx?=
 =?utf-8?B?VS9ERTZxZ1FvRHU0cWlBTjBwaHRLSjFMUWwvK1l6Q2F0VnphZEoxdlZqUEdY?=
 =?utf-8?B?Uk9McDIxSDM5L3pJd3lxWWM4WDNYQXgyRVMxSXlQMUNKdmdZWGxUamtMQlFP?=
 =?utf-8?B?WUdiaHBaazdURUM5RHVleEZ5ekQzUTcxSEdMQ2VVOER4dTVsMndnVjUxNFBC?=
 =?utf-8?B?K3NrR05RU09LNmtmVVhvNlFLREtidkR0MkhENzZ5Mk1BTFE1SjVKSmlGRis0?=
 =?utf-8?B?M0dKZFQvV0ozVFpLN1MxMXBBVnRNTkdGM2dFT3hjYnlGRkw3ZjNhcVhzVkRY?=
 =?utf-8?B?N21rRDc0b0RpeS9qejVkeEN2NFR2emhhcldUVTBjYmpXMzV0MEFkbXE4aUlK?=
 =?utf-8?B?elFyQU1PSExXamZPQTJGdDN2dkNBRnUyMnRRcUdGeTdhQjEzS1Yzb1FIaFBE?=
 =?utf-8?B?b0Yxbk1QT1NVM1Vsa3lrWlY0UGZUVURvVjBuQkxwUEtuNDRFcnNEWWVWZ3FN?=
 =?utf-8?B?MVErVHZWYzMvM2swdGF1QXBKQ25icll4Q2tGV09jUExNdVFNQzR0QTRKUXly?=
 =?utf-8?B?SjZWQnBlRWhpVjd5QzRUNHVNN2cyNTUxNkdZVEc5TGt1a1B5MEJDNExiblU0?=
 =?utf-8?B?YlUwVTA3STU3d3EvdkE1UElZQks1UDZOL0tEeXE2V3BwSG5qTCtaVXVUYVJK?=
 =?utf-8?B?SlZwREdKaXo4d2pwL1RKWXdnUjJUUFNldWpreWlnK1NBZ2ZianB0VXh5NkZQ?=
 =?utf-8?B?SDdDL29XYzRzV0s4SERmQnhGSWl6QmNXSVQ1UVVFczk2bEV3TVhOS2t0djcy?=
 =?utf-8?B?RXQ4Z3ZESXdtTUx1SW1xY20veFRqeDUxWHcvNjQzRGtWS2U0OGgvY1FHQjFT?=
 =?utf-8?B?dkgxeFJJeFFQdk4rdzFyVC9tbXplcXQzSk1yTC82MG91OFoxRXl3VUIySnNm?=
 =?utf-8?B?bFd0c3VJY0JSankwaGtqQWd6SDVsMlExYjc3MWFWQXdkM01uK1RPdjBEWWJH?=
 =?utf-8?B?QnBBUlhzTEFVL05jQnBKSUJ6M0Nqb3JLRzNGb0dZTHpFSGtseGRYb1BYV3BP?=
 =?utf-8?B?QXlxVGdKbUkrWU9ueDRBYWo1Q0tQczdudVhDQVk4R2JXQm5tMElOc2N5T01P?=
 =?utf-8?B?b0V5WkdUNngrMDIwOTFQR0s0dnF5bWlnSE5EdG1BbDVqSktBa0pBU0lZTGFn?=
 =?utf-8?B?Mzh5WldsTlhUQkRWVUJvaHpDeDZ6dTdIUXp6cVpaZGZadHQ0ZXFyL2ZCZE82?=
 =?utf-8?B?QjBueHZLODZ6ck96RkxndFkwYmljVmFjaVk2enROWnJkVW5oTk5ibm9zMVVZ?=
 =?utf-8?B?MjRKRTdSeVpRRlJkbFlkYzhaUHdxbythSTRLeHl0VUwxQmkwWEtqTnQrVEFr?=
 =?utf-8?B?YzVaUU1SalJiNlV3SFRTK0wrSVQ2K2NoL29Fd3FkSmNrb3JBUFVJVTdhclJz?=
 =?utf-8?B?MzJsM0lRMHJJSVpaSDBOUjFnSThoaU9rQy82SGVtaWc2TmlnTVBiWkE3N3h1?=
 =?utf-8?B?MGdWNEVQVG1JYTdYRGRGdzhkSFF4a0NCd1lUdkQ5THhtcGFLM0NuMEt3Mi9v?=
 =?utf-8?B?NXJUNXpDLzBTdUJ0QTJJYjM0SUdkT3NWdVEwY3NYbmVDWFdPYXMzd1FOcTZJ?=
 =?utf-8?B?TG9aMlptc1lENTdPTEZzb2JBTzlGRWxYTUsyRHI3aER4S3R6M05tdCtWUkNZ?=
 =?utf-8?B?WmtLRE1LWWdta29yQWJvSGtRZ3BocHoxZ3d5MkhtZ3ZuZlg3eUMzTnlKOFM4?=
 =?utf-8?B?VkM2OTJoMG1XR0xuWU1VUmVqWG9KNWo3bVljUjdHVzR4a0lubkhNYXhlMDAv?=
 =?utf-8?B?ck1hT2RyR2JYd0JWZWFNSlF6TU5Ialk0WW00ckFPQ3ZaazVoUW5lN2Y2S2Rt?=
 =?utf-8?B?bDVQNTVLOHQyenFHU1czVTdobVQwOTRlaENnNG5wdEJwNWwyVWRmK3h1U1R3?=
 =?utf-8?B?YTBZenNsMGVzbWlqdC9wd2grUXdnb0tIRnlZZmZrcmZMNlNxV01BSjE3am05?=
 =?utf-8?B?UGNZQTRSQXZaajFLZkdabGdtWkxWenJsb2swbURmMit6bXpnVDJhaUhkb0xk?=
 =?utf-8?B?aFpWekYzdGN3aXFvaWxpMG9FVDU5dDUweFY1Rlp6SGJIWVZFU04vVDgwais3?=
 =?utf-8?B?MGlSL2NCYXZpVTE2ckIrN25UTzFtZjhqWUQxYzBaRU5ibVQxRHFhT2VqYTZs?=
 =?utf-8?B?UWpPVEg1RlV1b1lJTHkrRndaRHFlc1FLVXA2RG5Xa3lJRHJWZ0QyRE00TmZq?=
 =?utf-8?B?cFRwbk9IZVc2V2RyMkRwOG96dm1LMnVFZnJMSUcwMVBDN055YVBSQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3aaf96-0183-46a5-f47b-08df2dbe2d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:51:33.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nl07ZMcH5wsrQJfB/YqYbaZ9jN3vlEBsDY5G1zDOkLYgq94Qojt9uCTo+jZ35tlUGazZuf3dygyhZ6JuDjBZGZYsEHM0q48IrQoPzEpUyQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1229

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHYxXSB0aXBjOiBmaXggdXNlLWFmdGVyLWZyZWUgb2Yg
YnJvYWRjYXN0IHJlY2VwdGlvbiBsaW5rIGF0DQo+bm9kZSByZWxlYXNlDQo+DQo+VGhhbmsgeW91
IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMiBwb3RlbnRp
YWwNCj5pc3N1ZShzKSB0byBjb25zaWRlci4NCj4NCj5Dcml0aWNhbDogMCDCtyBIaWdoOiAwIMK3
IE1lZGl1bTogMSDCtyBMb3c6IDENCj4NCj5JZiB5b3UgYmVsaWV2ZSBub25lIG9mIHRoZSBpc3N1
ZXMgYXJlIGxlZ2l0aW1hdGUsIHBsZWFzZSByZXBseSB0byBlYWNoIGlzc3VlIG9mDQo+TWVkaXVt
IHNldmVyaXR5IG9yIGhpZ2hlciBhbmQgZXhwbGFpbiB3aHkgdGhlIEFJIGlzIHdyb25nLg0KPklm
IGFueSBvZiB0aGVtIGFyZSBsZWdpdGltYXRlIGFuZCB5b3UgcGxhbiB0byByZXNwaW4sIHBsZWFz
ZSBsZXQgcGF0Y2h3b3JrDQo+a25vdyBieSBpbmNsdWRpbmcgInB3LWJvdDogY3IiIGFzIGEgc2Vw
YXJhdGUgbGluZSBhdCB0aGUgZW5kIG9mIHlvdXIgcmVwbHkgKG9uZQ0KPnN1Y2ggcmVwbHkgcGVy
IHNlcmllcyBpcyBlbm91Z2gpLg0KPg0KPi0gW01lZGl1bV0gVGhlIGNvbW1pdCBtZXNzYWdlIGNv
bnRyYWRpY3RzIGl0c2VsZiBhYm91dCBydW50aW1lIGV2aWRlbmNlLg0KPi0gW0xvd10gVGhlIGNv
bW1pdCBtZXNzYWdlIHNheXMgdGhlIGlzc3VlIHdhcyBmb3VuZCB3aXRoIGEgQ29jY2luZWxsZQ0K
PiAgcnVsZSBhbmQgJ0xMTS1hc3Npc3RlZCAoR0xNLTUuMykgY29kZSBpbnNwZWN0aW9uJywgYnV0
IHRoZSB0cmFpbGVy4oCmDQo+DQo+LS0NCj4NCj50aXBjOiBmaXggdXNlLWFmdGVyLWZyZWUgb2Yg
YnJvYWRjYXN0IHJlY2VwdGlvbiBsaW5rIGF0IG5vZGUgcmVsZWFzZQ0KPg0KPlRoaXMgcGF0Y2gg
bW92ZXMgdGhlIGtmcmVlKCkgb2Ygbi0+YmNfZW50cnkubGluayBvdXQgb2YNCj50aXBjX25vZGVf
a3JlZl9yZWxlYXNlKCkgYW5kIGludG8gdGhlIHRpcGNfbm9kZV9mcmVlKCkgUkNVIGNhbGxiYWNr
LiBBcyBhDQo+cmVzdWx0LCB0aGUgYnJvYWRjYXN0IHJlY2VwdGlvbiBsaW5rIGlzIGZyZWVkIHRv
Z2V0aGVyIHdpdGggdGhlIGVuY2xvc2luZw0KPnRpcGNfbm9kZSwgYWZ0ZXIgYSBncmFjZSBwZXJp
b2QuIE5ldGxpbmsgd2Fsa2VycyBob2xkaW5nIHJjdV9yZWFkX2xvY2soKSBjYW4NCj50aGVuIG5v
IGxvbmdlciByZWFjaCBmcmVlZCBsaW5rIG1lbW9yeS4NCj4NCj4+IFJlcHJvZHVjZWQgaW4gYSBR
RU1VL0tWTSBndWVzdCBydW5uaW5nIHY3LjMuMCB3aXRoIEtBU0FOIGFuZA0KPj4gUFJFRU1QVChm
dWxsKTogMTAgVElQQyBwZWVyIG5hbWVzcGFjZXMgb24gdmV0aCBiZWFyZXJzLCBiZWFyZXIgcmVt
b3ZhbA0KPj4gc3RhZ2dlcmVkIHNvIHRoZSAzMDAgcyBub2RlIGNsZWFudXAgdGltZXJzIGV4cGly
ZSB3aGlsZSBvdGhlciB0YXNrcw0KPj4gbG9vcCBsaW5rIGR1bXBzIHdpdGggdGhlIGJyb2FkY2Fz
dCBmaWx0ZXIgYW5kIHJlc2V0LWxpbmstc3RhdHMgbG9va3Vwcy4NCj4+IEtBU0FOIGhpdCB3aXRo
aW4gdHdvIGNsZWFudXAgY3ljbGVzOg0KPj4NCj4+ICAgQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0
ZXItZnJlZSBpbiBzdHJsZW4rMHg4NS8weGEwDQo+DQo+WyAuLi4gXQ0KPg0KPj4gd2l0aCB0aGUg
ZnJlZWQgb2JqZWN0IGJlaW5nIHRoZSBrbWFsbG9jLTFrIHRpcGNfbGluayBhbGxvY2F0ZWQgYnkN
Cj4+IHRpcGNfbGlua19iY19jcmVhdGUoKSBkdXJpbmcgcGVlciBkaXNjb3ZlcnkuICBUaGUgc2Ft
ZSBkZWZlY3QgZmlyZXMgaW4NCj4+IHN0cmNtcCgpIGNhbGxlZCBmcm9tIHRpcGNfbmxfbm9kZV9y
ZXNldF9saW5rX3N0YXRzKCkuDQo+DQo+WyAuLi4gXQ0KPg0KPj4gRm91bmQgZHVyaW5nIGEgc3Rh
dGljLWFuYWx5c2lzLWFzc2lzdGVkIGF1ZGl0OiBjYW5kaWRhdGUgc2l0ZXMgd2VyZQ0KPj4gc3Vy
ZmFjZWQgYnkgYSBDb2NjaW5lbGxlIHJ1bGUsIGFuZCB0aGUgcmVhZGVyL3dyaXRlciBwYXRocyB3
ZXJlDQo+PiBjb25maXJtZWQgYnkgTExNLWFzc2lzdGVkIChHTE0tNS4zKSBjb2RlIGluc3BlY3Rp
b24uICBUaGUgaXNzdWUgd2FzDQo+PiBub3Qgb2JzZXJ2ZWQgYXQgcnVudGltZTsgaXQgaXMgaWRl
bnRpZmllZCBieSBjb2RlIGluc3BlY3Rpb24gb25seS4NCj4NCj5bU2V2ZXJpdHk6IE1lZGl1bV0N
Cj5UaGVzZSB0d28gcGFyYWdyYXBocyBzZWVtIHRvIGNvbnRyYWRpY3QgZWFjaCBvdGhlci4gV2hp
Y2ggb25lIGlzIGFjY3VyYXRlPw0KPg0KPlRoZSBlYXJsaWVyIHBhcmFncmFwaCBkZXNjcmliZXMg
YSBRRU1VL0tWTSByZXByb2R1Y3Rpb24uIEl0IGluY2x1ZGVzIGENCj5LQVNBTiBzbGFiLXVzZS1h
ZnRlci1mcmVlIHNwbGF0IGZyb206DQo+DQo+ICB0aXBjX25sX25vZGVfZHVtcF9saW5rKCkNCj4g
ICAgX190aXBjX25sX2FkZF9ub2RlX2xpbmtzKCkNCj4gICAgICB0aXBjX25sX2FkZF9iY19saW5r
KCkNCj4gICAgICAgIHN0cmxlbigpDQo+DQo+d2l0aCB0aGUgb2JqZWN0IGZyZWVkIGZyb20gdGlw
Y19ub2RlX3RpbWVvdXQoKSBpbiB0aW1lciBzb2Z0aXJxIGNvbnRleHQuIEl0IGFsc28NCj5zYXlz
IHRoZSBzYW1lIGRlZmVjdCBmaXJlcyBpbiBzdHJjbXAoKSBjYWxsZWQgZnJvbQ0KPnRpcGNfbmxf
bm9kZV9yZXNldF9saW5rX3N0YXRzKCkuDQo+DQo+VGhlIGNsb3NpbmcgcGFyYWdyYXBoIHNheXMg
dGhlIGlzc3VlIHdhcyBub3Qgb2JzZXJ2ZWQgYXQgcnVudGltZSBhbmQgd2FzDQo+Zm91bmQgYnkg
Y29kZSBpbnNwZWN0aW9uIG9ubHkuDQo+DQo+SWYgdGhlIHJlcHJvZHVjdGlvbiBhbmQgdGhlIEtB
U0FOIGxvZyB3ZXJlIHJlYWxseSBjYXB0dXJlZCwgY291bGQgdGhlICJub3QNCj5vYnNlcnZlZCBh
dCBydW50aW1lIiBzZW50ZW5jZSBiZSBkcm9wcGVkPyBJZiB0aGUgaXNzdWUgd2FzIGZvdW5kIGJ5
DQo+aW5zcGVjdGlvbiBvbmx5LCBjb3VsZCB0aGUgcmVwcm9kdWN0aW9uIHBhcmFncmFwaCBhbmQg
dGhlIHNwbGF0IGJlIHJlbW92ZWQ/DQo+DQoNCkFncmVlLiBJIHRoaW5rIHlvdXIgZml4IGlzIGNv
cnJlY3QgYnV0IHRoZSBjaGFuZ2Vsb2cgbmVlZHMgdG8gYmUgcmV3cml0dGVuLg0KDQo+PiBGaXhl
czogZDI1YTAxMjU3ZTQyICgidGlwYzogZml4IGNyYXNoIGR1cmluZyBub2RlIHJlbW92YWwiKQ0K
Pj4gU2lnbmVkLW9mZi1ieTogQmluYmluIERlbmcgPDE4OTgzNTU5MzE3QDE2My5jb20+DQo+DQo+
W1NldmVyaXR5OiBMb3ddDQo+VGhpcyBpc24ndCBhIGJ1ZywgYnV0IHRoZSBtZXNzYWdlIHNheXMg
YSBDb2NjaW5lbGxlIHJ1bGUgYW5kIEdMTS01LjMgd2VyZQ0KPnVzZWQsIGFuZCB0aGVyZSBpcyBu
byBBc3Npc3RlZC1ieTogdHJhaWxlci4NCj4NCj5Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5n
LWFzc2lzdGFudHMucnN0IGFza3MgZm9yIG9uZSBpbiB0aGlzIGZvcm1hdDoNCj4NCj4gIEFzc2lz
dGVkLWJ5OiBMTE0gW1RPT0wxXSBbVE9PTDJdDQo+DQo+VGhlICJVc2luZyBBc3Npc3RlZC1ieToi
IHNlY3Rpb24gb2YNCj5Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJz
dCBzYXlzOg0KPg0KPiAgSWYgeW91IHVzZWQgYW55IHNvcnQgb2YgYWR2YW5jZWQgY29kaW5nIHRv
b2wgaW4gdGhlIGNyZWF0aW9uIG9mIHlvdXINCj4gIHBhdGNoLCB5b3UgbmVlZCB0byBhY2tub3ds
ZWRnZSB0aGF0IHVzZSBieSBhZGRpbmcgYW4gQXNzaXN0ZWQtYnkgdGFnLg0KPiAgRmFpbHVyZSB0
byBkbyBzbyBtYXkgaW1wZWRlIHRoZSBhY2NlcHRhbmNlIG9mIHlvdXIgd29yay4NCj4NCj5Db3Vs
ZCBhIHRyYWlsZXIgc3VjaCBhcyAiQXNzaXN0ZWQtYnk6IEdMTS01LjMgY29jY2luZWxsZSIgYmUg
YWRkZWQ/DQo+DQoNCkFncmVlLiBQbGVhc2UgYWRkIGFib3ZlIHRhZy4NCg0KLS0NCnB3LWJvdDog
Y3INCg==
