Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA652EBB84;
	Thu,  1 Oct 2026 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815548; cv=fail; b=WYARaBFySifvUx1uOcb96iEw7i6tuUQvL2VRodH79YPLGQJiIAGV7gBEqPeYD51R0erbHJXAORSo1nS6komRy6FUkuXpAnAioPjmhK0TSpsIlNH/twNF3H8VF/TvTur84UOf6C4f0ouC6Qvd1VUxaTUZXz0+9236eCtkW9i0UIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815548; c=relaxed/simple;
	bh=uSwQ6G3az854oUnP2bzxZ2sQOppu/LAJohfPiPDrbvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+fM38pVtxg6l80Mr8Y29cmXo28NoZU1zoILRzgOIvV4O3lQ9oqbwx3x8a1RjkR2Lm/HYIbNZDDJ2Z1JAfoQhpqBoIpz2M3wlwDbAbToH7u00KfYRvPaGbV6Z3ZDNvv4LMLnPm1I2XkuBoNnu6UYvFFwJLcgwzS0nlFW6oRH6Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K7onzYOJ; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K7onzYOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc9Oe6m1SyMnEDBPc3GeFdzHZQuIWLqyhrE5Aun9lwTNUlRZ5akNbOC/Mnn2rbTRZFFvizqP1picebdXjyy8gzYfDwvhgygpIy+Bg2YdK5v6Q7p78rkxK2V0ZDt78kFwJkeavczvLj4ZyhgvjtguhniVIdyuFWVP9Ia7N+N15LzJik4zKcCN4sIDidsc45UmooBgdOhfYZG8XwPYz4Y8gtEH8KcP+LhiBjLTLNNffu4C0dN0omggz1Cz2PQJP34tIzv6GSbhCW7AJ2pcwz35SK6Y2hh9rwcXOskMUjXNd3MC7M30Tr4jY/V84mTADgBCGD8I7TkXkusEgksYD9p04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSwQ6G3az854oUnP2bzxZ2sQOppu/LAJohfPiPDrbvg=;
 b=SV2bODhRvlS1Jy9De3KGUd60iYTcgBM9tq7bgKpdWtKk2v4ax+MolJPAn7q7Mr2Wd1x/vA3l0ZlpX26J/GdykscWTBwdRevvWdpgvvpIl5+z1pfDcXZk5DYj8uryRlG5ekib2qB5H+UJTtI66Zev5i9qEl3VLOPXmrwS+zAFKjenYDSDDBS52Rqtpyji+lg+Y61NfCVSNYfFXLUuVvoTuvJfDulfl/juLTGI/mR4fCjYKJ3SLV7N35oPDFRRfEICEraFAkk/KW1X9LA5laL+P3nyq6K5M97fxemv4AtdXRSqg+VMuGScnSXQgzxMZMweqPCCWCpROjXciC9oF0/Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSwQ6G3az854oUnP2bzxZ2sQOppu/LAJohfPiPDrbvg=;
 b=K7onzYOJX5F625WUCwlZM6wir9gFB2WpVQMcd53GuIp3ha7Bl/CfH4WJId+NuMOK21T3h3NeJgyyfQMywfe8ClUgeOUfs/fbkRNSisjlWJwgB48DYIIvp1c66p6HWxHczrrlxtQBZOfQ/gOIwTToRxL1PFggLoygfqxmerLJwXG0SwtlCj0nn2cJGOqMGmN3T8ePQ654sVL3qotRdQ6RZfFYB7DIheSuAmM//w5YhGQMCoTpaa4SIlKsSIAxcm8cSWdSYSTY9RmbRBhvLzgC3bRK8XGzu1FhdWlJ3ALTBmi2bkbUGNDntcUL5QA5FP6jm7kzyHPCDSjDq/xy0lZ6sA==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 00:45:43 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 00:45:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Topic: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Index: AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5AgAAWOgCAABaJ8IAAgr2AgACyLoA=
Date: Thu, 1 Oct 2026 00:45:43 +0000
Message-ID:
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
In-Reply-To: <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS8PR04MB8056:EE_
x-ms-office365-filtering-correlation-id: ee62df4d-b193-4eef-1c9c-08df1f5552ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|56012099006|38070700021|11063799006|4143699003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info:
 aHYC40d6pOGCLITymT+bsOA97597HSF6nnMJO/rZKR2aTQ7VMsWjZfLB3+l/3eKsYUkh9q3iXXyHM7anfoJAEvuJCLxqidU+glXOXWEt7ynljZR8hs+Dr/osaDl8RK4Jdyh+BlIM/0lqUWfgY2h2WWAsk3JSrV1kee+7wlBlRV9j4de0tvxSLWiaEQAUHFC619RYB76FheuYivL9LfWeSHthTV0SDuZ2y01WdtvApf3C7lCbYi1Otgi1RC4hRfPLM7D0y/slItnNUAR0RNeT/FwScVnno16ud4bD2f2Asnjb54GWqcnR5CRMxSCdRv+uepo66+Wi7+lRgCui+TLliCoToDTHqXGRiKVdSiIZe1Ue1B04vcJMUZyn+AQ2ztuqN8KVdLTmqMlowE72xYHV52ILl4Qu7OAwMR35eL5TCw4PW5dHayiWKqfEJhsFjaJHLO6ADH4hnUGO9d84li+xrrOd/l7qlJ6clSJjRDKlVx4c6R5ShGRbsYLp+9PUu5/+PTNTdVCmls6VzReU1Hlmgr33Lr4JVXw09A0egOdvAf6Jw4G1j1gulfHVN4BBF1NovZ3jHAeGEYTC5CfbAMgCpGA/n3jkOGEVtrN+hAHb5P0lL4O++cytIlPCHh9CGjl/CWEgQwiTk0zgCd7iMlFWkMMlEeNJpFqePGb4Q41Dbws=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(56012099006)(38070700021)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2xVbkpiN1UxSHlvY2F4WXo2aGgvMDZpeDkxYUt3Rlc0enR4LzRDL0VPRGRx?=
 =?utf-8?B?RzNOK1Z3TEU5eWJXb3p0M1hsclZ5QXd1M1RibUFZcWtyRTFSckcxeTJJNndh?=
 =?utf-8?B?NGUxS3d6eGJiL0xvYjdTSUdOU2RLYXM1SGF4UUhkVW9oSGhHNzU0dVJ1Y2hx?=
 =?utf-8?B?NDcwVll4MnZyU3ZWLzNrVkUzUkFXTTVKRmEvQ3d5Mnc3QU16K2JLTDNCc3Vt?=
 =?utf-8?B?NlhKaEdETVorTEthSmI1Y0hZUGVaNFZUNW1PS2tCdmhXZk9ReEtuZVJyeHFL?=
 =?utf-8?B?cFAvYnRJNDZ2cStDQWtGbjA2by9IcGFCNU1PdVdBRGtCS3VZcGJLMEUreHV2?=
 =?utf-8?B?RlBsdjlKVGJWKzdXTzM4bG5EMS9yaTlFR0VHQVhuaDlIRU44dm9seVBQS3J4?=
 =?utf-8?B?amJ2T0x3c2RXTk5lZUVYdzQ3RWFvMEtDUGhlbFZweFJnblRpa1NnNm1kZHRo?=
 =?utf-8?B?TzBTaVZHV0w2VTNMZ1JzcG5MbEdRWWprSW1neFltUDJ3M2lVRjNVWVptZmtO?=
 =?utf-8?B?NUJHNVc4VTM4bzRlNE8wUzhiVm1CU2kvMUMzWE0vTXMrdEhqWkk4Z2RQWVQx?=
 =?utf-8?B?UWhjS3NwOU5OV2RPaTc0ejBJOFhlblhyd0gySXhnYWhZQzIvUm81SW81Z25y?=
 =?utf-8?B?YlJJY05qc1J5Yk9WZW0zSlBOVG5IME90MHBwYkxSWXhqb1c3Wi9qcis5Ym14?=
 =?utf-8?B?L3RMeFpZRWQxUE41WkpHaHU1NGF0Y05BWGx1VWJmNW1wY3Y2MkJESERnZFBI?=
 =?utf-8?B?WEszQ1QxZUpqNi9oMmFGVERKdjJNcnVNRjE2YzlZcXllNVlVWEMxOE9XM3Fm?=
 =?utf-8?B?ZVF6ZGdXY1FOdEhsZjJaUU4vQXNMOURWVDFuc1ljYWhDWm5aVWtSaGZCdHVK?=
 =?utf-8?B?U1ErUTVjbTJob3E1REdHck1zY29XRWMxWWtjSktURThTeTNFK2t4VjhmUmMw?=
 =?utf-8?B?b240czZReDdoNXdjd01YRjNaQVZvN1VyWGJJblpyd1AyWG8vb0pCdmRMUGRj?=
 =?utf-8?B?VUxiY0VWb002VXl2UmtVMkZhMXZWbWp0VGozcGdTOEZGYnFxczdwYW5xZXpl?=
 =?utf-8?B?TlMyUm1xeEl3K052SEhnTUVGcktDOTNFUExtc2JOZUpGK05CU1pSMGc1WGtn?=
 =?utf-8?B?Ty8wNmZOeXpVMEVmbTE4SVB2TUdFd3gveTQzY2RRNitmMjlZcElCdisxU1JG?=
 =?utf-8?B?d1FqUkdqOUJ2OGRsc0w1RHRxYzBsdFVySzBWMmExajZZK1loOXdKWnl1NlUw?=
 =?utf-8?B?dkc5Mjcwb2J3aXl2c05PekwyQ01JdmdCRW5tek9NVkJyWkxDbU9XNDBBRmJq?=
 =?utf-8?B?UmpxMHR0SExmRm9ESlhnWFRhdmo2REZocnFMNjdjQjk0RDRnVEVYWjhnUlRB?=
 =?utf-8?B?WXB4bkxvOXk1bU1YMS9oRkQ1QzhKYzZPZWs1Z2pUa0xwT2tWWnkveE9leTNz?=
 =?utf-8?B?MDlSbmVWWFdIMlhGZFhDYnAydnlBSGM5QWttdG1VS1BqRDhHZThjNDdydUlH?=
 =?utf-8?B?QXhZMmxRT3BlQXVpdUFTcFpBZFQzWUJ4VWY5VHowakVuQUVqVXIrZXE2NElQ?=
 =?utf-8?B?aGJsdisySUxVelNwRTlUQzZTNGlzb3dyUnVNN3p6VGVKV3BZQ0tMQTNnK2FZ?=
 =?utf-8?B?aWJHd3dWOVBMZkRUMWU2c2RJWVEwVW1SNU42a2d2cGdFTW1ETC9Xd0s5ekg5?=
 =?utf-8?B?SzBGblNGZlNTdzNnaUZNSmY1eEg3Zlk1QmdNTTI2bUdnTHIwU3ZKd3VTN2g5?=
 =?utf-8?B?VkZvWGh4SW1yZkQzUVZibEVnazlQemRNK1NuNHhLTTN5ZStja2pSckN2ZnJl?=
 =?utf-8?B?Rkxhd1h6SmVxQS9sZGQzbURWRDUxb2NlaTNkYkNDUDlHTUM4bG11RG1PUHk0?=
 =?utf-8?B?aGpsNndPTFhBZ2I5UUZjNmQ5ZWZzb0VNUzVzVnRKTk8yNUpVQ0FjQStRY2FP?=
 =?utf-8?B?VEhvYktMNVZlTkczRjVuR0dYWUVFWFBtYnFpOWFnY29PdEFaQTdaaGRCZzMy?=
 =?utf-8?B?NHM4L3dHM1VPMjdVV2JRSG4zUitTVGtjQUxjVVJqclAybEFVQk05VXBWenV5?=
 =?utf-8?B?L0pEei9xc2paRGhubC9SSGNlN1RCbytUajQ3QWdNaWxIb3ZUQkd0c29XcUlD?=
 =?utf-8?B?NEhnT3BpcVI2TENKNHdqWTloalkzL09SS0NqNW9wRUNqOTVoVWVSZy9UWGpn?=
 =?utf-8?B?SWVVa3Z1YVpIc2phelVaV1ZpL3ZmcHFheVdYR0VENVFtZHJ5R1dRZWJGNFN0?=
 =?utf-8?B?SitQRTNNMVh5Z01TdGVBN2NKdWJ4TlpvSVZNVmRWWEM5eFg2RCt3allGaHRR?=
 =?utf-8?Q?CF3i10Sql1a6WHRqBN?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee62df4d-b193-4eef-1c9c-08df1f5552ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:45:43.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4hzOYKXvLrv4wqwDTht/O6cVvPYEfWhgcKjZM/q3Np2erq6drzgCTWmTnbWJScZ3jgTOse4P2lYZFatneEEkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056

PiA+IEJ1dA0KPiA+IGFueXdheSwgdGhlIGRlc2NyaXB0aW9uIG9mIDU1OGtIeiBpcyBpbmRlZWQg
Y29uZnVzaW5nIGJlY2F1c2UgaXQgZG9lcyBub3QNCj4gbWF0Y2gNCj4gPiB0aGUgdGhlb3JldGlj
YWwgdmFsdWUuDQo+IA0KPiBEbyB5b3Uga25vdyBmcm9tIHdoaWNoIGNsb2NrIGFyZSB0aGUgTURD
IGNsb2NrIGRlcml2ZWQgZnJvbSBvbiBNWDk1ID8NCg0KU2VlIGJlbG93IGZvciBkZXRhaWxzLg0K
DQo+ID4+PiBUaGUgcHJlcmVxdWlzaXRlIGlzIHRoYXQgTkVUQyBzeXN0ZW0gY2xvY2sgaXMgMzMz
TUh6LCBzbyB0aGF0IHlvdSBjYW4NCj4gPj4+IGdldCBhIE1EQyBjbG9jayByYXRlIG9mIDIuNU1I
eiAoMzMzLygyKjY2ICsgMSkpLiBCdXQgdW5mb3J0dW5hdGVseSwNCj4gPj4+IG5vdCBhbGwgTkVU
QyB2ZXJzaW9ucyBoYXZlIGEgMzMzTUh6IHN5c3RlbSBjbG9jay4gRm9yIGV4YW1wbGUsIExTMTAy
OEENCj4gPj4+IGlzIDQwME1Ieiwgc28gdGhlIE1EQyByYXRlIHdpbGwgYmUgM01Ieiwgd2hpY2gg
d2lsbCBiZSBhIHByb2JsZW0uDQo+ID4+IFllcywgdGhpcyBpcyBteSBjb25jZXJuLg0KPiA+Pg0K
PiA+PiBBcmUgdGhvc2UgY2xvY2sgd2hpY2ggZmVlZCBNREMgY2xvY2sgYXZhaWxhYmxlIHZpYSBj
bG9jayBmcmFtZXdvcmsgb24gTFMgPw0KPiBJZg0KPiA+PiBzbywgd2UgY291bGQgY2FsY3VsYXRl
IHRoZSBkaXZpZGVyIGJhc2VkIG9uIHRob3NlIGNsb2NrLg0KPiA+DQo+ID4gTm8sIHdlIHR5cGlj
YWxseSBoYXJkY29kZSB0aGUgY2xvY2sgZnJlcXVlbmN5IGluIHRoZSBkcml2ZXIgYmFzZWQgb24g
dGhlDQo+IE5FVEMNCj4gPiB2ZXJzaW9uLiBBbm90aGVyIHNpbXBsZSBtZXRob2QgaXMgdG8gc2V0
IHRoZSBkaXZpc29yIHRvIDE2NiBpbnN0ZWFkIG9mIDY2LA0KPiB3aGljaA0KPiA+IHdpbGwgbm90
IGNhdXNlIGFueSBwcm9ibGVtcyBmb3IgdXNpbmcgYSA0MDBNSHogTkVUQy4NCj4gDQo+IEhtbW1t
LCBhcmUgdGhvc2UgY2xvY2sgYXZhaWxhYmxlIG9uIE1YOTUgPyBNYXliZSB3ZSBjYW4gZG8gc29t
ZSBzb3J0IG9mDQo+IGZhbGxiYWNrIC0tIGFzc3VtZSAxNjYgTUh6IGNsb2NrIG9uIExTLCBhbmQg
b2J0YWluIHRoZSBjbG9jayBhbmQgY2xvY2sNCj4gcmF0ZSB2aWEgY2xvY2sgZnJhbWV3b3JrIG9u
IE1YOTUgPw0KDQpUaGUgTURDIGNsb2NrIGlzIGRlcml2ZWQgZnJvbSB0aGUgTkVUQyBzeXN0ZW0g
Y2xvY2suIEZvciBpTVggcGxhdGZvcm1zLCB0aGUNCnN5c3RlbSBjbG9jayBpcyBjb250cm9sbGVk
IGJ5IHN5c3RlbSBtYW5hZ2VyIChNMzMgY29yZSksIExpbnV4IGNhbm5vdA0KY29uZmlndXJlIGl0
LiBNb3Jlb3ZlciwgdGhlIGFjdHVhbCBzaXR1YXRpb24gaXMgYSBiaXQgY29tcGxpY2F0ZWQuIEZv
ciBpTVg5NSwgdGhlDQpzeXN0ZW0gY2xvY2sgc291cmNlIHByb3ZpZGVkIGJ5IHRoZSBTb0MgdG8g
TkVUQyBpcyBJTVg5NV9DTEtfRU5FVCwgd2hpY2ggaXMNCjY2Nk1Iei4gVGhlcmUgaXMgYSAxLzIg
ZGl2aXNvciBpbiBORVRDTUlYLCBzbyB0aGUgY2xvY2sgaW5wdXQgdG8gTkVUQyBpcyAzMzNNSHou
DQpUaGVyZWZvcmUsIHRvIG9idGFpbiB0aGUgYWN0dWFsIHN5c3RlbSBjbG9jayBmcm9tIHRoZSBj
bG9jayBmcmFtZXdvcmssIHdlIG5lZWQNCnRvIGFkZCBhIGZpeGVkLWZhY3RvciBjbG9jayB0byB0
aGUgRFRTIGFzIHRoZSBORVRDJ3Mgc3lzdGVtIGNsb2NrLiBTb21lIHBsYXRmb3Jtcw0KZG8gbm90
IGhhdmUgdGhpcyBkaXZpc29yLiBTbyB3ZSBkbyBub3QgYWRkIHRoZSBzeXN0ZW0gY2xvY2sgdG8g
dGhlIGJpbmRpbmctZG9jIG9mDQpib3RoIGVtZGlvIGFuZCBlbmV0Yy4NCg0KSW4gYWRkaXRpb24s
IHRoZSBORVRDIGlzIGFsc28gdXNlZCBvbiBTMzIgcGxhdGZvcm1zLCB0aGF0IG1pZ2h0IGJlIGFu
b3RoZXIgc3RvcnkNCmFsdG9nZXRoZXIuDQoNClRoZXJlZm9yZSwgaGFyZGNvZGluZyB0aGUgY2xv
Y2sgZnJlcXVlbmN5IGFjY29yZGluZyB0byB0aGUgTkVUQyByZXZpc2lvbiBpbg0KdGhlIGRyaXZl
ciBpcyBhIHNpbXBsZSBhbmQgcXVpY2sgbWV0aG9kLCBqdXN0IGxpa2Ugd2UgZGlkIGluIHRoZSBl
bmV0YyBkcml2ZXIuDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ny4zLXJjNS9z
b3VyY2UvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMjTDM3NzAN
Cg0K
