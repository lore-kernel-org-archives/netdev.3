Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA3381E85;
	Fri, 11 Sep 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157713; cv=fail; b=ELstdzYxxy/BJ299RMmd80WdhOHjXhkFcq2vMBnmZYRYUhctG84+B+Lcrd6U7IUuLiTv0nzh8TrSymln8xg3nw4+8PzeyRK/lA9f+HWriSJ3yEEcuLUF6SEPb0bcQsr7qAYDEqxRxdkXuElH8dEHIHklBo0wlpAGo/tt9i2WWEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157713; c=relaxed/simple;
	bh=ytzDU06HXXX7R0obHVgbJrKxA+FLPCUjn7prf8tZI7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OgQKKCAdSdgfRkOCA7aR+EZsR+sblXyCiuUhlv5An5Dchln6nMfq1a+Pmhd8aROH6Zyc/MTzZYLxzbWADdmUpHCRIfRKksldhb505tm1WmYmp0E84/Qz5PTYCpa3bksWP/ctUbaglcCZ64f6IzrlILWl5822kER9waqfWxoHYh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AD+rauDv; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AD+rauDv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjhbptavfQ8sKN2YGaJ7bV2wYONBNaTVhD+HUCvXdKU16CDqUOsw3+f4DfHno2dLulqeclcH7brohSef7umEezy6EZoEIOlesEJfI5oH+9l9rtPLot5w6AWlLxbKoFZek1zYkD6iV8nrEO4+XLkDKLguxPB87CUIJ9K7fIXn8JS2C+/gLlgME5GrhGntXHUN/9hncQbIdS7X0BjU3kWOTjbUVFP5/wUT3Jt2vs9UWHZvbtcZLJz7VU19j53vAavy7aO+7l15+UzUqhbmlxAqCUAFr9hC2YwjyvJ+5GBpz0d5uDsHkKUva6wmorXH1yIPjuspN9HwNjY7liB7LpKV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytzDU06HXXX7R0obHVgbJrKxA+FLPCUjn7prf8tZI7A=;
 b=fF8DRt8tdsIn7kGnPjIO+j9hQ3L1+dmIusBAar2qgj1VjXHY0HqmGzpn5QRx0hSPMuLzZVThdQ3SP+JuPvZg7pukqlQb0YE66I7f2OHj59ETEe1NipAXUn/JHxjugsbw75gHHWZ0lkOP0QlwliUPQ0WPreOhJMh/URwR6uITaOdc5scTFVnUWxDmXqDWvnlyI+VUJx7wH+bNJdASKM0R/U59AF+EwoHXkAI74z8OZbP4fKrpIA81uC6tTLVlW/l+IIWWKl5dA5Fz68pHIb0NvXO4k37YnJIN4ZMiNwTgofG9ceuJ+nC52fZeymLxWddalJiN4h1rNZZgMrauX3CeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytzDU06HXXX7R0obHVgbJrKxA+FLPCUjn7prf8tZI7A=;
 b=AD+rauDvwf4XiBWXdotQk3Tklb/MtRqvge10aOapfpTRsuhh0vHzKzWpwnFcTiiUAI9H8HU2NlOr8mu/I1NokxTmDYzxZV3WiJHH2FNxh/rpxll1amwebJt9gbYujTKZLqVxZWjp59uum9PEGF20Nyszxw8Szb/0bOxOTnXi6JR2g617wc1lS+w8ILnnp8snfp3dKMJClO6qnEuLwnAQpyfBnwqlhhQbfVKZq0Mg5gjd8iqlaMjEIVI82VT8apglrbXG+/OsmmTmOMAej4nNycR/4RcM5miDbPBd936FBcRDYX0PqIvZkAoN7yA43p4NjHchu6c1rIuulFw3qjd9bA==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by DBBPR04MB7946.eurprd04.prod.outlook.com
 (2603:10a6:10:1ec::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 20:15:06 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:15:06 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: Wei Fang <wei.fang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH v4 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHdQEb6E7LWlJ9k5E2fPAU5d6thmLbJxbAw
Date: Fri, 11 Sep 2026 20:15:06 +0000
Message-ID:
 <GV2PR04MB117404BFD5F8818898AE307EC96BE2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
 <20260909100733.1139689-4-wei.fang@oss.nxp.com>
In-Reply-To: <20260909100733.1139689-4-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-11T19:24:10.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: e7815f8f-fd40-473d-2c24-08df10415f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|3023799007|4143699003|38070700021|10067099003|921020|11063799006;
x-microsoft-antispam-message-info:
 H8KLXiH4SDGzo7kqfUmMDGFVNOFBNS1J2lEBLmK/qVXd0hO92q6lO5bg4YE8OFU7VicDpCV00sRTTddWjWBC+OREZQ2vIec8GkrFaE0Y9p0OVaK/+FTa/R4JwUBi18LDStLQCdHbD9GoAu19GeG5WkzOjziXSH1RO63c3MEWgDEuSfVlrih0SetoyXj0wyLyQPlqD/lNoRtlyfnmGWIxnslELTNgHRpVf1GioCsuAgLE2+3tbyMGoh51avvuUEOxdeWH65DHlpLmOGWvEtSeFdJajK/qlvjkCFnWdkU/wlD6U4UfWiOSb8YmL340Q4W+Zi7KvgN9qvJzAddrYokuNQjat+/vgiBrBO+t8Qn5bMZAzxm0CVdfpr8Pj07fXMv4yHaXwbFfJCb5zTUwDjqdolBiVMyw7eLe3Fd2/Xq+ph4//I+Dn/na9iiOHebiN/gFs93T0Pc8aJWrlpgyITViXYTRPVcIQkUO262wwk5BRiqmHn14R0uQD5WpZn4BuPE0MZx5cD4saY/dmSRc5M2PGkKBm5M+qAcqdz3E0Kaz1GF/HQNApjZ+o1W9XdYdKA7zw9QKCxYnf+TIA2fv/vfeAP3ZaBg4VcbsCNzRcPPsBautKiTCNxB0xmc60WC3NmeNDMN9byeCbp8MjPmgt0pWPtyxAovcCIQZVt9fMh/eDJx6MlU0iRoOOlL7HDYCi4T15KxvP2q0sYYox6MsNyn5APVGpUsaPrO/UYpmVmhfmkQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(38070700021)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2xtRmNkQkRUdk5GYXozL0dpdzRPM25tNURvWmx1SHRXcUovS09xUWUvT3RD?=
 =?utf-8?B?WHpmYU9vbU12b1FXMktpY3RiYVNwemkzMjZQNHlXQUh0NERhR1ZObFZqaWdq?=
 =?utf-8?B?b0k0UUtTeEwvTithSXpJNVlUL08rRWwzRjJMN01ESTUvazJUbzJoVE9ieFZn?=
 =?utf-8?B?bmJmQklja09nQ0JuWU5MWUhVbmpESEx6UDlneDUvMzFHTTV5VFJnbFE5Znkr?=
 =?utf-8?B?eVNINXNRSjh1S3Zwd2tWbEh0UWc1ZWF4QTVlQ2tuZnR4UHYrc3hBVmk4dHV4?=
 =?utf-8?B?SGVIY29oQ3dmdnBwS3Y5S08wY1p6czZGeEpIUlJuSlNJdk9ZT3psS3phRXA3?=
 =?utf-8?B?T3REa0FDSjZYdE9wbEFETklrVkxIOUcwR08yY2pkcDhoWVZTY1lmL3B2OXB4?=
 =?utf-8?B?dzJRU2NTcXFzWDRNYVdiS3hLdzJEd0dBd2luNVJibS9FZmxQeUNPbHdhZmc4?=
 =?utf-8?B?ZVRSVndQaTBudVN6UDhrWlBYVUZmT005QStKeThMak92MitPakJLSmJLZEZr?=
 =?utf-8?B?VlZjQ0gwSGZPczhPUVJ2NklHOHQyYjgvbnNpeEg3cmZZUWJUNEtIWlBMMHJL?=
 =?utf-8?B?Ymp2blpjN21KZEFoWm15TUdOZXlaamtpKzhWT1c4UkdIREZWRk9QUkQrTldl?=
 =?utf-8?B?Q3VFbElJWVp0TTl0bHhoM3U3N2kzb2p2cmRFdktmR1ZNUnlqNW9LekxQa2sv?=
 =?utf-8?B?WHVVR2ZwS3hrK1JzSTQ1c3NsVmtVYWNsM2NvS0gxSENuU2ZWU2VxMnkrMzF1?=
 =?utf-8?B?ZVBZR0FhWlltZ3lyb1cvRXdkaWtmSkxHbFZ3dFN6THZwcTFaMmJpQzQwNXZN?=
 =?utf-8?B?TWoyeGhXWGNGK2xndVMvQ0RKN0NUdmF3SVZodXY2eWNhMGQxcnAwWUFJWlJ0?=
 =?utf-8?B?NW9GWUJOa3NycFBTamtScUFEelZDRG83aGg1bXllS2FIY3YvZG4xY2RRaVdK?=
 =?utf-8?B?ZzlOWVAxUTYyeW82ZXJ4bWpWOWg1cWtRVHpQWXhJRTk2MGdic3NNTjBBS21E?=
 =?utf-8?B?WFZpeWh6czBMU05QajVVMFJaTmowdm5VLzI1N1U5RjNSUjVNZGlLV2M1cldt?=
 =?utf-8?B?ZFRXekNpNi9iSnRKNGhweDVXeEdRZnhCdlJKK1VZcWZOVWpsMDl0SlF6eUxB?=
 =?utf-8?B?cHUzQlh6a1RIR3Z5MUw4R2hYUWtnWUpVUjY4endmMFJiS2JwMDdiWHNrUnpI?=
 =?utf-8?B?SXZNenM4eElRQ1JCUWhDVG1rTi96RkphVDJqM0t5QkxIQU91ZDlGbDU2bFMx?=
 =?utf-8?B?VlNjNGxVRGpDTmlZek1KaVVveU9hYWo3QTUzL0ZnaGZtSUtMZzV2N3FYV0t4?=
 =?utf-8?B?cGtSWHBKdDRqQjJ0OUVFVkhMeVltQVVwMmZKazV1eEZHQkd1cWJiTmUrSG5V?=
 =?utf-8?B?VFladHFDVWFHSnZxQ3VLbkg1RzBEUUVRRFJMUE1xTFNtSy9tdHRKMlJWUzUy?=
 =?utf-8?B?WHJBVU1RMG9vejNCSmc5WjVRWXRjSlJQS1EyZ0JuSm9aSDVJM0pIMlJRN3Iw?=
 =?utf-8?B?aHdBN3ZnL1d6OUFOUnRsTkV1WnBkbWdwd1RUZkMybjJ1VDZ6ZVdibDN3N1Jk?=
 =?utf-8?B?djlFY2tSQ0RoOEgrZlJORmNQZ1JUWWI0K1RicXJwUnNIL1k5SHR6b0Y3L3Vn?=
 =?utf-8?B?ZnRsK05lMzZiYzlNZHNKTnpDVHFLMmM4d1Zsb2pLTmVnZE51Rk1Ra3AxZ2pQ?=
 =?utf-8?B?aTEvUzR2QmJoTlMxOVZ6MVFpQ2kyRGJXeVlKZUFuT1VEYVAzb2RLOTE5aFli?=
 =?utf-8?B?cWtEbmN2UHJmazlsMGRLd1NKc240TEpEMjlRWG5maWVVUHdVR1IvMjczK2xj?=
 =?utf-8?B?b0s4aGVUWWxxaWNVSnBBcWhWMHZZWld0Z255OWd2OHNWRDRYQ2tQY1ZXRkw3?=
 =?utf-8?B?c0FVZkx1OEQ1RU9LYTIyUzRmK2hHYk5iWHdjenQ3aldqaldOK0V6dDAxczNz?=
 =?utf-8?B?ckJDSUxsQi9pcm1NZ0JXZmlFQnQzWll6MEkrekltS08xeGVMRGd2aldDdlBT?=
 =?utf-8?B?YlF1MkpIdTJONkw0K0hLNlR4U09wemZmcXpJMjgzWUtNRE5ycnlkeUZ3OG91?=
 =?utf-8?B?bW9lUHNwWWEzdTA4YUZQWEwwNHB5NUNyaFhVWUVSSnhZTlJwZm05QjVQMVEw?=
 =?utf-8?B?MHpiU2ZyZU1HYUcyR05qaGxFRFNKcnhTUWVVblM4RS9YdDZaYWVnYzFKcERR?=
 =?utf-8?B?VE5xcy9ObjBDYXFpOXg4OEJadmsyM3JaNzZpL2p1c2gyU3cyNW1FZVhWVlhh?=
 =?utf-8?B?QjEvdnhwRjNmWnRrSGFWb2Nickd6T0VGemhkQldFTVZNaGJkOUtrUVRFbjFn?=
 =?utf-8?B?VzJsaVNFdHM0bS91TXcyaldPT3NNRnk4cFpLRjRuT3FIUnJCMnR2QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7815f8f-fd40-473d-2c24-08df10415f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:15:06.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/9cJFVSMlf9nN9LZoLG4Gwg6hfqwiAQZZFmRZFHCm0kY5G0onIMTef6JgcxTCAtEAuQWB5dfSzPpfC2oJCw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFdlaSBGYW5nIChPU1MpIDx3ZWkuZmFuZ0Bvc3MubnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgOSwgMjAyNiAxOjA3IFBNDQpbLi4uXQ0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQg
bmV0LW5leHQgMDMvMTVdIG5ldDogZW5ldGM6IGFkZCBsaW5rIHN0YXR1cyBtZXNzYWdlIHN1cHBv
cnQNCj4gdG8gUEYgZHJpdmVyDQo+DQo+IEZyb206IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29t
Pg0KPg0KPiBBZGQgYSBtZWNoYW5pc20gZm9yIFZGcyB0byBsZWFybiB0aGUgUEYgbGluayBzdGF0
ZSwgdXNpbmcgbWVzc2FnZSBjbGFzcw0KPiAweDgwIChFTkVUQ19NU0dfQ0xBU1NfSURfTElOS19T
VEFUVVMpIHdpdGggdGhyZWUgVlNJLXRvLVBTSSBjb21tYW5kczoNCj4NCj4gMS4gRU5FVENfTVNH
X0dFVF9DVVJSRU5UX0xJTktfU1RBVFVTOiB0aGUgVkYgcXVlcmllcyB0aGUgY3VycmVudCBQRiBs
aW5rDQo+ICAgIHN0YXR1cyBzeW5jaHJvbm91c2x5LiBUaGlzIGlzIGludGVuZGVkIGZvciBEUERL
LW93bmVkIFZGcyBhbmQgaXMgbm90DQo+ICAgIHVzZWQgYnkgdGhlIExpbnV4IFZGIGRyaXZlci4N
Cj4gMi4gRU5FVENfTVNHX1JFR0lTVEVSX0xJTktfQ0hBTkdFX05PVElGSUVSOiB0aGUgVkYgcmVn
aXN0ZXJzIGZvciBsaW5rDQo+ICAgIGNoYW5nZSBub3RpZmljYXRpb24uIFRoZSBQRiB0aGVuIHJl
cG9ydHMgdGhlIGN1cnJlbnQgbGluayBzdGF0dXMgYW5kDQo+ICAgIG5vdGlmaWVzIHRoZSBWRiBv
biBldmVyeSBsYXRlciBsaW5rIGNoYW5nZS4NCj4gMy4gRU5FVENfTVNHX1VOUkVHSVNURVJfTElO
S19DSEFOR0VfTk9USUZJRVI6IHRoZSBWRiB1bnJlZ2lzdGVycy4NCj4NCj4gVGhlIFBTSS10by1W
U0kgbm90aWZpY2F0aW9uIGlzIDE2IGJpdHMgd2lkZTogdGhlIHVwcGVyIDggYml0cyBjYXJyeSB0
aGUNCj4gY2xhc3MgSUQgYW5kIHRoZSBsb3dlciA4IGJpdHMgdGhlIGNsYXNzIGNvZGUuIEJpdCAw
IG9mIHRoZSBjbGFzcyBjb2RlDQo+IGluZGljYXRlcyB0aGUgbGluayBzdGF0ZSAoMSA9IGRvd24s
IDAgPSB1cCkgYW5kIGJpdCAxIGluZGljYXRlcyB3aGV0aGVyDQo+IFRYIFBBVVNFIGlzIGVuYWJs
ZWQgb24gdGhlIFBGLiBUaGUgVFggUEFVU0Ugc3RhdGUgaXMgaW5jbHVkZWQgc28gYSBWRg0KPiBj
YW4gZGVjaWRlIHdoZXRoZXIgdG8gZW5hYmxlIGNvbmdlc3Rpb24gbW9kZSBvbiBpdHMgUlggQkQg
cmluZ3MsIHdoaWNoDQo+IG9ubHkgd29ya3Mgd2hlbiB0aGUgUEYgY2FuIGFjdHVhbGx5IHNlbmQg
UEFVU0UgZnJhbWVzLg0KPg0KPiBOb3RpZmljYXRpb25zIGFyZSBzZW50IHRocm91Z2ggdGhlIEVO
RVRDX1BTSU1TR1NSIHJlZ2lzdGVyLiBTaW5jZSBzZW5kaW5nDQo+IGEgbm90aWZpY2F0aW9uIG1h
eSB0YWtlIGEgbG9uZyB0aW1lLCBhcyBpdCBwb2xscyB0aGUgcGVyLVZGIG1lc3NhZ2UNCj4gc3Rh
dHVzIGJpdHMsIHRoZSBhY3R1YWwgdHJhbnNtaXNzaW9uIGlzIGRlZmVycmVkIHRvIGFuIG9yZGVy
ZWQgd29ya3F1ZXVlDQo+IHJhdGhlciB0aGFuIHJ1bm5pbmcgaW4gdGhlIHBoeWxpbmsgbGlua191
cC9saW5rX2Rvd24gY2FsbGJhY2tzLiBUaGUNCj4gbGlua19zdGF0dXNfbXNfbWFzayB0cmFja3Mg
dGhlIFZGcyByZWdpc3RlcmVkIGZvciBub3RpZmljYXRpb24gYW5kIGlzDQo+IGNsZWFyZWQgd2hl
biBTUi1JT1YgaXMgZGlzYWJsZWQuDQo+DQo+IEV4cG9ydCBlbmV0Y19wZl9ub3RpZnlfdmZfbGlu
a191cCgpIGFuZCBlbmV0Y19wZl9ub3RpZnlfdmZfbGlua19kb3duKCkNCj4gZm9yIHRoZSBQRiBw
aHlsaW5rIGNhbGxiYWNrcy4gVGhyb3VnaCB0aGlzLCBWRnMgY2FuIHBlcmNlaXZlIHRoZSBsaW5r
DQo+IHN0YXR1cyBhbmQgcmVwb3J0IGl0IHRvIHVwcGVyIGxheWVycyBzdWNoIGFzIHRoZSBrZXJu
ZWwgbmV0d29yayBzdGFjaywNCj4gY29udGFpbmVycyBhbmQgdmlydHVhbCBtYWNoaW5lcy4NCj4N
Cj4gQ3VycmVudGx5IG9ubHkgdGhlIEVORVRDIHY0IGRyaXZlciBzdXBwb3J0cyB0aGlzIGZlYXR1
cmU7IHYxIGRvZXMgbm90Lg0KPiBBbmQgdGhlIFNSLUlPViBmZWF0dXJlIG9mIEVORVRDIHY0IHdp
bGwgYmUgYWRkZWQgYnkgc3Vic2VxdWVudCBwYXRjaGVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBX
ZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgTWFub2ls
IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0K
