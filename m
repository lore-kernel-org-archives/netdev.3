Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792549588;
	b=hznwWudZQcr7AloFQZSlXuGpHmAhuA0OAPErIg/i6ggwmfKfHk6EOoBznDvF4iD2XI6L
	 rK7HcGuveyRpQuEX2kIJ+GdPYiysZuhi2JSb7W2xPrqJ+o7zDnLH1K20Fb/Ubw27MMIVE
	 hVUijfI2HAL3B/g0LGstQoQKMm+czb05uKfB4oVR/C+HmK0EyEfQ26P2ufeSiPnhWegSA
	 gdOTgcoVp+T4mjtErfb3z7/XpZ8I3wNdIkiyOx8+xToy08fBB/F9l9k20SFUy0DzBvNKt
	 ezNJQ7htC9OpxvS0uZsf3boz9hDeaJNUKB0jBEcFqtcD/MoJCkPozS+fXraLOKEXScw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549588;
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
	bh=OvxWtaPKvDvbOv6/AbwqebaMKi/tXwwjWKhZFnp53Ws=;
	b=zzAhQqm2waTszRHq6Bddl14/aOQ2rNC2MDPcLbaB9GGaPe4xKTiIcmaK0RsUOV6vYxm9
	 MbQp9PEsWIPvDhwFODBt6YXgQO5j5hrRC6KuTVRbUYphV2H934qv8xbYbrMSLIByEz0SH
	 qOT6fPnbPER0d2NDxrHkaUUFgd92kmFOy/AJ4pd2al7GbHZZhGjHyA8uSPhmD7Lik6k7G
	 WRVdUcAoRm3PUxoZH3OUCWta3FQNLezRQ487xLhD3dWUrxh2u0p5+b+xDmSyGINjjjW7H
	 4/bXFfA0xK7Z2ga8E+uUL/Bh+BbtEWy+/Pu3r4fPF2qm866k+WFRtngmBi5XZXrAx4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	dkim=pass header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ce8Wlo3R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.126
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022126.outbound.protection.outlook.com [40.107.75.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF660606A319;
	Wed, 21 Oct 2026 02:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF660606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ce8Wlo3R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhoUWBL5gCa9pqfBv1ZE7wqRcnRBp9I9M0U0Ia6NmZeMoGGG1Vn6L9DNGQ4jOMGGGsPE+AevHgmDNFWpQNrvFqT+ow7uqxT8EjWMx2W+3OSbX40UDqlUuLqLH1A13NKxjWyQL4WBbaAo6YKa7RdAwWxBaYS/j/cJfZgcaCpovWXIHIxr/QdDCMjHkxqvg2rJ2qqg8Cx/I3+/TvtPUSFzgn7Znh7ekEhz15j5vr94ir4zSBrA3ReTUKcHhzwFeDgqCUJgmD6WvFkUWCdvIO4Wl+7Y0uehzDCvHta8b/G+dj8xrrQcymvLZO5yB1wwh4X3FiLX1NT2EP3r9jEgo03djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvxWtaPKvDvbOv6/AbwqebaMKi/tXwwjWKhZFnp53Ws=;
 b=HjdRrRNEiKf40IB85QC8omAO4nbUNcQtbDGrFc1KR+kaQfTLlUervLxOHxeZIkh0AuTqVlbRmgoahZRtR2PxOEMWtL+Ike+4+RTwrLqq7D77La8ZtMU/iSJoS3gqiEkT34j0laMR9oVvPE/EKzxViQ2N3SFLjr/UX7Qj0FcLiJ7ETD31qbAN9epIVavrA3Bjf9xKAxj8wpTXBOsiN7W0MOxRXZebRMyI9AHbgOHsx3e6OqfwUBU7Qr97kX4mW6Z1SLQNuPVsT07wQXYm1tCIWKTxaE+KUaIYbJ8vS98CgV8c2+JTS0eIa/E6gbTJiXMWKX3dTazF0JdWTq8ceofPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvxWtaPKvDvbOv6/AbwqebaMKi/tXwwjWKhZFnp53Ws=;
 b=ce8Wlo3RXF524xCFC0RnI5yvorniLLkd/UB6stnm3noCT+wXjM3QyKS38t2nBTXDo/Biq9h7+PedMP0eK0iXZCUjF62tVRzbpFUsPIin8QIn5lLGHN9LTTre2XOoX+0TA4jY43KOr3+E5fUJfbBHk0bwz2z/yTnpXXTUmt999Dhh3pvazwj/rnZ277OkmNAfiYiFiWKWgmvfewAzw/j9IgrmCW52cct3+tRgfmjcbr5j6Wpvup5OKqoE+2WgZ3X2R7+oilDwuHDWqU0LECoAHwmv7ADhIpPwuo5dki4Z1KdMyU7n6/Q9QuojOxPSLEvoFeb/FRYlkzOfjkfkxChOLA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB6220.apcprd06.prod.outlook.com (2603:1096:400:35c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:26:23 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:26:21 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Eric Dumazet
	<edumazet@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHY0IDEvN10gZHQtYmluZGluZ3M6IG5ldDog?=
 =?big5?Q?ftgmac100:_Make_Aspeed_compatibles_standalone?=
Thread-Topic: [PATCH net-next v4 1/7] dt-bindings: net: ftgmac100: Make Aspeed
 compatibles standalone
Thread-Index: AQHdYIbxAmh+iGMhMkK1ggKf/t8dyrcGvLKAgACI6IA=
Date: Wed, 21 Oct 2026 02:26:21 +0000
Message-ID:
 <SEYPR06MB5134F12076DE6EA68586FF529D662@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
 <20261020-support_ast2700-v4-1-4d36b40939b3@aspeedtech.com>
 <20261020181441.GA510274-robh@kernel.org>
In-Reply-To: <20261020181441.GA510274-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB6220:EE_
x-ms-office365-filtering-correlation-id: 55fab50c-6c89-4426-d9af-08df2f1ab226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|56012099006|261009223027099003|4143699003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 Np0fig0KwH/EQsbV7Qmi9GzCwsj9w3HftYx+k9TPYIefXGrf8Pm6SFfg/qGywcpBGQJv567aKW32CkXHweUBuH7T5rNz4r0I4or27JUeABHOqwPQOSs/t888q9GJ5vq39mdzNDDNFAxELYzdHUeHzcpNkmdaEdO8bNTCfsoDOW3tpuWtXLHwXZlfSKh6IM6BgmzhK4mwc14ACGoVH+KKl+GX3zaW6UvpK+z/k4A0/bf1bBfKA5GJ43D5T6PqaRa40IVHP2BxPYQGkLbMQOM9JZ5EaV+G+Y8rtlL0QjTcBCvUpUwKvkVkIKoaS5d7GAVjLSg4zYWF3+HZoCAJFALRHVc0BDoAP3q6uTgxc783gAjATbmT886ryjClBR7mB2oOc8pDiXatC9i7XJDFZD2yE/E4Mce3ZTCF4QnzL5sX+ZhahlPIt57EtYJPfQH3eZvyHGKUcgrbgbeAAJgp3Zg/JnM8zUPBzRXp99G+H4aos1lGAjvMfiHUuPMcUzymvpLlBkYVyXC1QIyuGR/hSPy/CSJkI2qU5ffLb8rh6WkQo5bwx1rrswzHugsI6w6uZC50qAgBN2N8kmaepCGxMCNOi98jda6lYzzWQgaKiLxP9z16DS3l95cX6mDFoXmF+/9fx0+DpD6owdVuEJKwCdEnlVwhhxWHfWFtGRFcCjAg/OdvhC6WsthKiGnBm0TnZ9KJBkh636mWTjOn25axpTbNBTlxN9dqJMwqATtrxGFWle8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099006)(261009223027099003)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?WTFJWHhPdHNISTFkM2h6Y2NRUmk0dlFqL0gzVmFBcUFMU0NuTExHcCt1elVRRlFY?=
 =?big5?B?Tjl6S3NUYjhEdkMxN1gxSnplVjBjTWZsOXozMmdPSlo3NG1BNHRESjhaajBxbkQ2?=
 =?big5?B?T0JjV2VGaVdFVmZKa1FJZDZLNDVmam5IaUcreTlVWVBRME1VdVh6OUpJNmxiRXB5?=
 =?big5?B?ck5vdEwvMmpPNkJxeTRFc0dVeXBoaSt6MVliaEtVZTJkWG9jSGtxSHBJYW9lckZa?=
 =?big5?B?dWVKSm01eE52bHdxNWJHditCdjFmWmtKanFWYjlmNmZLaWZFbitidTNlMVMwVjZT?=
 =?big5?B?VUpJRmZWdkhWbGRlY01JMC8xbGQ1SG0rNUVBSUlwUG9NTkpKei9QVVdTeUY2SElU?=
 =?big5?B?aVFybmorYzJ6VEtvMDh6QXZiSGsxYUl6M2R5bzh4blpQNHNjQjlmS3RwTW9KWmVo?=
 =?big5?B?S0x1NmJIcDVxYkFVYmRtOFlhWEdobDV5Q2FwdUYzcHIvcjJQNGdockpOTEF3c0NR?=
 =?big5?B?emQ0eHBEeEVQeGUwc0M1UFMwNUVjNFgwRnpQK2Qvc3RnWEtWSHQzZnlGOU83elNE?=
 =?big5?B?akpqbU9HdTkzWFBHYzJnYzFvM0RjUmtaak0vbFRKTmYydDNhSWNjaktVa1lqTEZB?=
 =?big5?B?bzJKang0QkpraGNmbEM2WGNuMFVGRDRBay9QajVVc3hFcHBxaTdJUWJPcWZIbDJq?=
 =?big5?B?d3VuTkFteUkrYWpWeGgzT0dFbmFxOVNtdldJRmNiYzg1ZnFwcHFmL0JKSTVqQnpu?=
 =?big5?B?SVgyMVd4L0dxZXpTV3FaZ3E1UHJYNThrb2tzUWhjL0lJclhLNmRHMFBMZlFGMDJL?=
 =?big5?B?UW1YZ0xseUhyWW9RSVhQNUNKazhKcXp1TkRMSHVrSm9wRnhBS0M1TzFmU0ZYWkFM?=
 =?big5?B?TEFRalNNS21JS2J5M1Vvc2lZYWhObURFUkxFK0VQdTFEMHd0cmMzNUpiVmFkN2E0?=
 =?big5?B?amJnVEdvQlJwMWlER2UwWmNVS2RVRmhVRmlueTZqRXVNUW0yZVJVSktDa3NmWDFB?=
 =?big5?B?LzNKdmQ2SGdwczNoNmxEenI0VGE0MVhycGZtcjlPa2pqbHVjaDBETW05bUpMczRQ?=
 =?big5?B?NDdUcTR5VmJPNE9aYmVRd2g0TTNZU2s3ZWMyWmNodmJOaGtqcVBUZVh3dWE4VzZU?=
 =?big5?B?MmU4MVhMNGVmYjArbWNrN1lGUmVBTURDeFBQQ21ING8wdTQ2L08vQWlhTXk2WXMw?=
 =?big5?B?SWUxRHlKVkl1emJmM3NqT3VIaVhBWWtkQmhIclExckdoQXlVdFd6Q281cmNpVUJ1?=
 =?big5?B?ZEMvVjBwNmRON0VVODNNTWdPcnZjRWNta09aOTRpK21QYXg0blhib3hHM2t2R21i?=
 =?big5?B?SzAzeERDY2Z5RUlTcjk5cFkyNjErc2RFM0ZlWmVPQlNWYzVibHF6UFh6eXZwMGJq?=
 =?big5?B?YUd1NlM0YXR1VGVTNkxUMTAvUVE3K0VIL0NzZHQ1QlRGVCtneXVsUDlFUGpHU2Rk?=
 =?big5?B?aXBWNlFPd0RwbW02Q2g2ODJyaUp0ZUdMbWVUN2xsK3IycUVpUzMwUmhWNnltQ3Zy?=
 =?big5?B?T0RLTzlEVWJrSk11L3VWRUFsUE84WW1Sc3piK0N0Y3pNUi91dGZFMjVFeHJpcWpD?=
 =?big5?B?SkNZNitaMDNiZU0zdTZzLzAvc1ZaeG9jRTBDUjhCa3Q5Mm5ySzJ6RnZEMHhhSVAy?=
 =?big5?B?dmxkSkI5ODRaaXVwRmx6QjNXOVZJMUVqN3JQbU4wMnlzUDc1L1pvNXp0aE9qRVB4?=
 =?big5?B?Y1U2ZGExc2h3elBPcWhrRDc2c01JQy91TktpdlFWc0hvaEQ3RXBFakg1cHZwbExS?=
 =?big5?B?RDVSbWU5OEc5cXJUaFUwcUsxSHJoRng0cFQ1YWo2WW5BWkNaM0dIcXU2TjVsWWtO?=
 =?big5?B?L2xjbXBTQStxblNwY1lWZjYwWDgyL0YyZlNVSGJMREVpeFlkdUJnUE1MQVI2d3dE?=
 =?big5?B?YUw5Q3laK3FYWEE4Szh1OWdwUk9OV0ZmaWIzVk9XR1cwUkRueWEwOEovMXFNWGlC?=
 =?big5?B?ZWUxOWdWc01Dang3TnBObUc3aW5zSVZ5NFNZUVhydVdQOGRTVUpjbGtWS2lZMkVB?=
 =?big5?B?dlRFTUxvZjlabmdtRis3MlA1ZnU2SWl0TTV4VUVhdUpnZFlIeTNsZ0UrcVdOcmZ0?=
 =?big5?B?dWt6OVp5c00yQjd2Mmc0Ym50ZmdseDBpUCt1Z3MxeVZ0K0J2Vk4xQkR5ZFJUWkVq?=
 =?big5?B?NVBmK2JoMzBjbUdLVmROaWJINWhnUzFTRFJTSmJSUE5vaGI5WFl4SitmVC9jeDYy?=
 =?big5?B?TFVMQWRUREl5Tm84NmdQMXJBT2hGbFYvazRlaXltZjlyaURybzUzblIzVnFiM3BM?=
 =?big5?B?b3BFYXAxYXFrZHpXVGFZNTY4Qzd2Zz09?=
Content-Type: text/plain; charset="big5"
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
	hObIfNwZL6+iG4gO9J2oHiKMYmo3MecScyuOT+mqORuAdUqMm6obaDottCThhh9TiSXUesmBfdALL8CF7puSEJU99Ldf1etcq7p1UyEw/t+GZcwWlg+VugXzEc5WVHd4HqKB8rHaPZfGI3KGhkg1kifHoJ/q2sMHmDKL7se8ndgGw8uapsDkw+Mu6r9qA9fZ1253S2jzrUeioot47YcR0ZjUL2fS2RywsuK21JKPfOPU1LnS3LRUJYBbeBvB8Jn2dbGFa9QCP1ft3qj5wCbHvjUeyyXl1UmsRGHKLB6dIZdadBBYIKhgNugSWRPvAwhEBb+veElPsUOQ51HoDSR+aA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fab50c-6c89-4426-d9af-08df2f1ab226
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 02:26:21.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCCoTu8HpUwNMjD52IglR59CqBvxsFTABHK6w3sn+kaReDcmLbD7pP9134EOV8WPXGwcx42NrGNy1UPZgGxRMENPFp32BRaJZLWhK8r2zHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6220

SGkgUm9iLA0KDQo+ID4gVGhlIGFzcGVlZCxhc3QyNDAwLW1hYywgYXNwZWVkLGFzdDI1MDAtbWFj
LCBhbmQgYXNwZWVkLGFzdDI2MDAtbWFjDQo+ID4gY29tcGF0aWJsZXMgYXJlIGN1cnJlbnRseSBv
bmx5IHZhbGlkIHdoZW4gcGFpcmVkIHdpdGggdGhlIGdlbmVyaWMNCj4gPiAiZmFyYWRheSxmdGdt
YWMxMDAiIGZhbGxiYWNrOiBpZiBhIG5vZGUgZXZlciBib3VuZCB0aHJvdWdoIHRoZSBnZW5lcmlj
DQo+ID4gZW50cnkgYWxvbmUsIGZ0Z21hYzEwMF9wcm9iZSgpIHdvdWxkIHNldA0KPiA+IHJ4ZGVz
MF9lZG9ycl9tYXNrL3R4ZGVzMF9lZG90cl9tYXNrIHRvIEJJVCgxNSkgaW5zdGVhZCBvZiB0aGUg
QXNwZWVkDQo+ID4gQklUKDMwKSwgc2tpcCBBc3BlZWQgY2xvY2sgc2V0dXAsIGFuZCBsZWF2ZSB0
aGUgRE1BIG1hc2sgdG9vIG5hcnJvdy4NCj4gPg0KPiA+IE1ha2UgZWFjaCBvZiB0aGVtIGEgc3Rh
bmRhbG9uZSBjb21wYXRpYmxlIGluc3RlYWQsIHNvIG5vbmUgb2YgdGhlDQo+ID4gQXNwZWVkIGNv
bXBhdGlibGVzIHJlcXVpcmUgdGhlIGdlbmVyaWMgZmFsbGJhY2sgYWxvbmdzaWRlIHRoZW0uDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYWNreSBDaG91IDxqYWNreV9jaG91QGFzcGVlZHRlY2gu
Y29tPg0KPiA+DQo+ID4gLS0tDQo+ID4gZnRnbWFjMTAwX29mX21hdGNoW10gaGFzIGhhZCBkZWRp
Y2F0ZWQgZW50cmllcyBmb3IgQVNUMjQwMCwgQVNUMjUwMCwNCj4gPiBhbmQgQVNUMjYwMCBzaW5j
ZSBjb21taXQgMDNhMmFiYTUwYjJjICgibmV0OiBmdGdtYWMxMDA6IExpc3QgYWxsDQo+ID4gY29t
cGF0aWJsZXMiKSwgc28gdGhlcmUgaXMgbm8ga25vd24ga2VybmVsICsgZGV2aWNldHJlZSBjb21i
aW5hdGlvbg0KPiA+IHdoZXJlIGEgbm9kZSBoYXMgYWN0dWFsbHkgYm91bmQgdGhyb3VnaCB0aGUg
Z2VuZXJpYyBlbnRyeSBhbmQgZ290dGVuDQo+ID4gdGhlIHdyb25nIEVET1JSIGJpdC4gVGhpcyBw
YXJ0IGlzIGEgYmluZGluZyBjb3JyZWN0bmVzcyBmaXgsIG5vdCBhIGZpeA0KPiA+IGZvciBhbiBv
YnNlcnZlZCBmYWlsdXJlLg0KPiA+DQo+ID4gTm90ZSB0aGF0IGFyY2gvYXJtL2Jvb3QvZHRzL2Fz
cGVlZC9hc3BlZWQtZzQuZHRzaSwgYXNwZWVkLWc1LmR0c2ksIGFuZA0KPiA+IGFzcGVlZC1nNi5k
dHNpIHN0aWxsIGRlY2xhcmUgdGhlaXIgTUFDIG5vZGVzIHdpdGggdGhlIHR3by1zdHJpbmcNCj4g
PiAiYXNwZWVkLGFzdFhYWFgtbWFjIiwgImZhcmFkYXksZnRnbWFjMTAwIiBjb21wYXRpYmxlLCBz
byB0aGlzIHdpbGwNCj4gPiBtYWtlIGR0YnNfY2hlY2sgd2FybiBhZ2FpbnN0IHRob3NlIGZpbGVz
IHVudGlsIHRoZSByZWR1bmRhbnQgZmFsbGJhY2sNCj4gPiBjb21wYXRpYmxlIGlzIGRyb3BwZWQg
dGhlcmUgYXMgd2VsbC4gVGhhdCAuZHRzaSBjaGFuZ2Ugd2lsbCBiZSBzZW50IGFzDQo+ID4gYSBz
ZXBhcmF0ZSBzZXJpZXMgdGhyb3VnaCB0aGUgQXNwZWVkL2FybS1zb2MgdHJlZSwgc2luY2UgZHQt
YmluZGluZ3MNCj4gPiBjaGFuZ2VzIGRvbid0IGdvIHRocm91Z2ggdGhhdCB0cmVlLg0KPiANCj4g
Tm8uIFRoaXMganVzdCBjcmVhdGVzIHVubmVjZXNzYXJ5IHdhcm5pbmdzIGV2ZW4gaWYgb25seSB0
ZW1wb3JhcnkuDQo+IA0KPiBXaGF0IGEgZHJpdmVyIHVzZXMgZG9lc24ndCBtYXR0ZXIuIFRoYXQg
Y2FuIGV2b2x2ZSBvdmVyIHRpbWUsIGJ1dCB0aGF0IGRvZXNuJ3QNCj4gbWVhbiB3ZSBjaGFuZ2Ug
dGhlIERUIHNjaGVtYS4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIGxvb2suDQoNCkp1c3Qg
c28gSSBkb24ndCBlbmQgdXAgcmUtc3Bpbm5pbmcgdGhpcyBiYWNrIGFuZCBmb3J0aDogdGhpcyBw
YXRjaA0Kd2FzIHdyaXR0ZW4gaW4gcmVzcG9uc2UgdG8gQ29ub3IncyBjb21tZW50IG9uIHRoZSBw
cmV2aW91cyByb3VuZCwNCndoZXJlIGhlIHN1Z2dlc3RlZCBmb2xkaW5nIHRoZSBBU1QyNDAwLzI1
MDAvMjYwMCBmaXggaW50byB0aGlzDQpzZXJpZXMgcmF0aGVyIHRoYW4gZGVmZXJyaW5nIGl0Og0K
DQogICJJJ2QgZml4IHRoZSBiaW5kaW5nIGhlcmUsIHNpbmNlIHlvdSdyZSBnb25uYSBnZW5lcmF0
ZSBjb25mbGljdHMNCiAgIHdpdGggeW91cnNlbGYgb3RoZXJ3aXNlLiBUaGUgZHRzIGNoYW5nZXMg
bmVlZCB0byBiZSBzZW50DQogICBzZXBhcmF0ZWx5IGFueXdheSAob3IgYXQgbGVhc3QgYXBwbGll
ZCBzZXBhcmF0ZWx5KSBzaW5jZSBiaW5kaW5nDQogICBjaGFuZ2VzIGRvbid0IGdvIHZpYSBzb2Mg
bWFpbnRhaW5lcnMuIg0KDQpNeSBvcmlnaW5hbCBwbGFuIHdhcyBhY3R1YWxseSBjbG9zZXIgdG8g
d2hhdCB5b3UncmUgYXNraW5nIGZvcjogb25seQ0KdG91Y2ggYXNwZWVkLGFzdDI3MDAtbWFjICh6
ZXJvIG1pZ3JhdGlvbiBjb3N0LCBubyBleGlzdGluZyBkdHMgdXNlcw0KaXQgeWV0KSBhbmQgbGVh
dmUgQVNUMjQwMC8yNTAwLzI2MDAgcGFpcmVkIHdpdGggdGhlIGZhcmFkYXksZnRnbWFjMTAwDQpm
YWxsYmFjayBhcy1pcywgc3BlY2lmaWNhbGx5IHRvIGF2b2lkIHRoZSBraW5kIG9mIHRyYW5zaXRp
b25hbA0KZHRic19jaGVjayB3YXJuaW5nIHlvdSdyZSBwb2ludGluZyBvdXQgaGVyZS4gQ29ub3Ig
YXNrZWQgbWUgdG8gd2lkZW4NCnRoZSBzY29wZSB0byBhbGwgZm91ciBjb21wYXRpYmxlcyBpbiB0
aGlzIHNhbWUgc2VyaWVzIGluc3RlYWQuDQoNClNpbmNlIHRoZSB0d28gb2YgeW91IHNlZW0gdG8g
d2FudCBkaWZmZXJlbnQgdGhpbmdzIGhlcmUsIGNvdWxkIHlvdQ0Kc3luYyB1cCBvbiB3aGljaCBh
cHByb2FjaCB5b3UnZCBwcmVmZXI/IEknbSBoYXBweSB0byBnbyBlaXRoZXIgd2F5Og0KDQogKGEp
IHJldmVydCB0byBteSBvcmlnaW5hbCBzY29wZSAtIGtlZXAgQVNUMjQwMC8yNTAwLzI2MDAgcGFp
cmVkDQogICAgIHdpdGggdGhlIGZhbGxiYWNrLCBhbmQgb25seSBtYWtlIGFzcGVlZCxhc3QyNzAw
LW1hYyBhIHN0YW5kYWxvbmUNCiAgICAgY29tcGF0aWJsZSwgc2luY2UgaXQncyB0aGUgb25lIGNh
c2Ugd2l0aCBubyBleGlzdGluZyBkdHMgdXNlcnMNCiAgICAgdG8gYnJlYWssIG9yDQoNCiAoYikg
a2VlcCB0aGUgc3RhbmRhbG9uZS1jb21wYXRpYmxlIGNoYW5nZSBmb3IgYWxsIGZvdXIgYXMgaW4g
dGhpcw0KICAgICBwYXRjaCwgYW5kIGNvb3JkaW5hdGUgd2l0aCB0aGUgQXNwZWVkL2FybS1zb2Mg
bWFpbnRhaW5lcnMgc28gdGhlDQogICAgIGFzcGVlZC1nNC9nNS9nNi5kdHNpIGZhbGxiYWNrIHJl
bW92YWwgbGFuZHMgaW4gdGhlIHNhbWUgY3ljbGUNCiAgICAgKGUuZy4gdmlhIGFuIGltbXV0YWJs
ZSBicmFuY2gpLCBzbyBkdGJzX2NoZWNrIG5ldmVyIHNob3dzIGENCiAgICAgd2FybmluZyBpbiBh
biBhY3R1YWwgdGFnZ2VkIHJlbGVhc2UuDQoNCkxldCBtZSBrbm93IHdoaWNoIHlvdSdkIGxpa2Ug
YW5kIEknbGwgc2VuZCB0aGUgbmV4dCB2ZXJzaW9uDQphY2NvcmRpbmdseS4NCg0KVGhhbmtzLA0K
SmFja3kNCg0K
