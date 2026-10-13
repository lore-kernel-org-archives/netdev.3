Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A146D559;
	Tue, 13 Oct 2026 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858192; cv=fail; b=t1+h2yJ26c90Z3xwaCCg3ZO/k+PJ1CJlw5D4MtXA8ZfL/9aSUJkfUCF6I6f3OK9UX5Ig9AGs7egbWztZLWhnvYcUXymmBvI8LV3qmjSdmgjWbpHThJWdArO7Wir3lLy7tVns2372RBgF9kAbjwfgvThpTI475tUEtHGUgzsjRV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858192; c=relaxed/simple;
	bh=Hbj+FdcJrPf0VUY0lGsZDSstMWUuIg3BEa1SUeRMK30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOr7zfrsXCR4NrKZcIrXPJA/Bgte+OjzdDE1ISDELaMOiJS7hiJ0Q5ifeNmlChwpWSFHbzGaMSV0QYoaKdQ6j0Hf0yR5SGPU39bTXWw6+tdHKvJ38fYAheclP6NWuQNkWe1zUzHGaQMgyeXVyFfQw2T9ZVSVY7gDSkLH4RVFy+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WMOvWoUf; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WMOvWoUf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDK3INOIQi76Cxw2W4u2pfIz/dIfBoRplzNkd+tx/ZPKTVBE0jerXJyVIqwYtqA446Mp3hqdxKkA78uKNCmV+LnhfRzdVqRkL0l1c0klcnF86cBtdhJA+bn1h+LXPN3BFpKbWMWpixnVKCGTLDKMPG8Wqn09mbId8+/76LCkC6CVE9PeB3bzLX+ZwT7seSujPrLDbxo10MMu2zqwvpFsmZbclZwHw5T5vYu8vnFxotsiZgHa/lj4kicQsDgUm8otaSg7wYHizV16Hh3SGecm8WmYK2H5FNV9IiYM4QPWBqGiD1Rh0i4Xlm+wqEF9aRkM9LJScrFY1gLHBbUm1h6eoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbj+FdcJrPf0VUY0lGsZDSstMWUuIg3BEa1SUeRMK30=;
 b=WOil4v5NlwtfK5/bw1vVoDh6QWfjHSefYdIqxNyC0OchNYuRo33zxqfUDGLBXsmLxCa+P0CNpMBJNNyiWRezvYRQkczzogppSd+IrCpxT1rGjz/MtfX1L9Fv0VLubESy04kmY94ReElz+5MRTQRsYpjIHLtjqZLop67VNpDITWGvkbWHeH2Ko+xfwPr4DiP/WJroLj5XREcEyO+5fVlCQDucF00wkg98E8zd7k7HmfhDAx3DBejP4Kk59iAW35UaC67UoXX0ekFe6l7HGrIEXFnZzip7l0niADqytzjC2bknFjW+SPlEtUxYKXoFRcSfAFjTPEn95M4kAluflMCe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbj+FdcJrPf0VUY0lGsZDSstMWUuIg3BEa1SUeRMK30=;
 b=WMOvWoUfhVSw6ouZbkYV7gx3aB8qf6Fc3mkvk1VMfkiJ5FkMzS8Wc3wIMXPZx37sq+UPhnT2pFAu54Fy6hPIt/L2+bPl9ixZ0dL6Md3VEyqIoSvIycuxrnoXzeohT9v2d6DHYdESYZP8W1zxeVe57Uz5znBx8CF3mPVScxXTj1GBF8Y497O3P2mQdu5R1eAF/VmwSnAkqEKncccwt0hUwblsLQd6kF0DMlHq7w2sQB5Yg3q++D1+1T5X0fxLZw3pANrbSoO/PxfV7+/f8p2g7qxZe3XOFtuHTNujUkcA1jLLBGTEIgx4ITVkc8sLu14Y732YG/t9G1cS5wENZ0UtoA==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 02:23:03 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 02:23:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: dl-S32 <S32@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v1 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdV+todoZtUuB4hEiKAorU+ERkYLb2AydggAOIMICAATbrUA==
Date: Tue, 13 Oct 2026 02:23:03 +0000
Message-ID:
 <AS4PR04MB93383ECAB9896DD89629CB8D889E2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
 <701f38d08f9ea371877645223e6ac919af7870b5.1791548316.git.claudiu.manoil@nxp.com>
 <AS4PR04MB9338CC6990BCB8781706AAD088912@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <GV2PR04MB11740B17401171A7F3876B6E0969F2@GV2PR04MB11740.eurprd04.prod.outlook.com>
In-Reply-To:
 <GV2PR04MB11740B17401171A7F3876B6E0969F2@GV2PR04MB11740.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-13T02:17:52.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|PR3PR04MB7449:EE_
x-ms-office365-filtering-correlation-id: 87d0a697-a959-47f5-dc98-08df28d0e89d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 8LtIaaBxmyQY1UZeIzPP2qbgjgLmjNzxPQxPHpaUXcyex5b8CQchEAWnsmHV9DtFLSjeTu0W9xESBqpZFy//eFRj2CvEdxfq7UjlQoGiZANpgFcpSCg78ch7pjSG8r/VPslCrPtq5KKAiKtI1Ae3t9nvbt3IpDo9DnRdHhrLYbKYj8EPnYs8FBQwIySRbAMoa8p75uRKumZno4jvcC+2hRa34upeK7RZ7xE2saGeRGlNwmx4kXOzhNpTyxzJcfA5Bc0FHGT/9JG3XuX6u40NKl7yu3gAh9pvfUguwYWTgT6hSqoMvAjNEyaPH8rSuaVVAGQnf/dnbkVndmBPNiSafvle0G8yqb9gyS/OI/H83I8JE7vXlvQJ545bn/ok3xjETKMDjrdrs6wH2/SHBzhcEV0I6jnN5zO4nHB7OyromwnOhicwiPCuEFv+2OGJ0IMIhEhXssxynr0t+FHpxU1MDJ/Y+yYx9N3R00h5mgLcLMvU+gOd4mnRy9O+8PhRk7xjhFcWsuJ3MtM7yMjnCFRc/L6TPsEtvh5H2UQzBIYLXDLAyeoMG8AaFhqLt7duwQ4j/wSEVc1XwI9g3Sh3EBaMOtuqoMstjNNdl5rS0pxyJMCpV9qucWNjMtbrF0WJVHT7p127uLfmzK9vot9TsuvFu/lyuO8n7fZVuYa+L4ap2649H4ZQTCgAU84IkCEBhzb61v1f/W4sE+7LJUiFQIVO6U/ZfeYOvLG5CRnYVgCVE/I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VitoRmZ4aUpqYWdiaUkyWGtGN0krRTZOWnpzZVdyRHF3VldKSmtLT2ZwUEdy?=
 =?utf-8?B?a2k1Z0ljcmx6VDd3VGJuSjl4WW56aXZQZGRDNTJjQldMS3cyQWRXb3c5TVRE?=
 =?utf-8?B?SW55Sm9xaWxmaTRNVVluT3k2elZyazRSMG5rYkJoZ3RhSFdiVWdOTm9oS0kx?=
 =?utf-8?B?cko2b0NhSXBPUDVqa3Yyb1d2OVZXc0xLaGdDVW5lYzRPN2R1aGVrUUMzWnRs?=
 =?utf-8?B?bXNjY0pac1g1TnZxR2lNdzBYdzhjMUgrOHBZWlY2YkhRM2VyZWF5TElYQVlN?=
 =?utf-8?B?MVlzUXJpd1RRQjhWVUdybTR2aEttS2NrakZTR3JSNGR1Y2NSdE13Sks0WG9I?=
 =?utf-8?B?K2N1T2xqYklkMUlFSytlYWw5Z1Ewa05NYU9wY0tvQ1Q4VTAwQjNJTU1TQ1J6?=
 =?utf-8?B?MzVyUFN0RzBVN05aTVJ1SlZoWTRzZVJYYXEzbUtLcnhKL2gwWVROL3ZZdXlY?=
 =?utf-8?B?Q1FWQUY3cnA5SXpOODNFYzlqTHdkNG0xeXY2RzJjR2RHaW9QMWpKRWU1ODZF?=
 =?utf-8?B?bUVFT2tBdFppYTB1dGFHclYxUm92S2puYkxDYXpqMysyVGEzS3JGRC83Mkcz?=
 =?utf-8?B?RktaRTNmU2tjNEY4WEFUNWdRM1FSa1hmdmxHdmtIQ0JENWY2VlNHOUt3TUFW?=
 =?utf-8?B?V213a1RzVUVzYmY3M0pweHV1bGxPU2haVnQwcWdSUk1mNGcvZXVBZEQ1OXd6?=
 =?utf-8?B?WlZ5VnFlcE9ycHVneU5rVlhoOWlJSkViejF5OXdmK0ZZQklGYmFzTml4ZWhy?=
 =?utf-8?B?VEN5SGJjNVF6bkpXVmY2R2lqaUc0cUhlNUllYitPVDRsYzErTjF4a01Wa3By?=
 =?utf-8?B?MGFVckR3UHY4ak80ZEc1UlRmQTNhNUw0YUZxNW9kZzZZVXFBUmh4U2RqVmhs?=
 =?utf-8?B?Mzl6Tlh1OUVwVVB0YjNEZlVkQWhTbXNtaW8ybDEycWJKUG55Rlo4TUx5Ymxi?=
 =?utf-8?B?TXU3MHp5ZFlnRHBLMm0vVEVJend4em56T1J4TUl4SExpallMbGJ1a1B4VHlr?=
 =?utf-8?B?alpTMTZxQ2VCNjk1T2RTQU0vaWJuL2NXKzU5UzEwQVBpQ3Vzc1RPSjl3WjU0?=
 =?utf-8?B?RzVOaHhxMUpPVWFyRklFcEVYMDVXalZqUmszNFFJamk1SENxWXEvYUUva3cx?=
 =?utf-8?B?ajI1ckovSjhpQ0lOSUlONE8xeDE1R2pZUzVGT2sxTk9yd3VrRVpuODJ2T3Vv?=
 =?utf-8?B?RlF4VEVvZ3V6cFlQSGhQQStlUkhGV2paV0N6clB3WUpGTW5lNUR0SXdDdTd1?=
 =?utf-8?B?dncvZWtnSUdmNzBlWUR1Y3lzMUNIcHhyd1YySDVBaEpibWxiK3o1dUpBaWJz?=
 =?utf-8?B?cmZGdGxOMzZnMGROeGVabE5MUzlEbnI4Ymtwd3o0MGVLSnFiWGY4UDhEVVBF?=
 =?utf-8?B?dXhhdytKbzN1Tm5CcjZveVZucWhhZEZYbkVWNTUrd2FUdmN0NVB0bUEra295?=
 =?utf-8?B?SjBidnFJNXhXRzJuU1l1RDhYbDJlelNVMTIwWnNVS3AyaFBVYXVsZTNSZ2cr?=
 =?utf-8?B?TXFwK0l6eGxEa3RBV2lVNFQwNDhPY3JZVHprRFdsM2VUa3hGSjcrQWR3QTlD?=
 =?utf-8?B?OU5BckJRTXJ6UThjQSt2ZDRBbnRXYnRicU5QdHNIT2pxZjdMcENYeFo1My9V?=
 =?utf-8?B?UG5PTk95dm5YR0I0b3MvZHNoYU5GTXJUdS82K21waEV1cWJJdWN1cjkxUWlo?=
 =?utf-8?B?akxMWm1lbkp5K24vOHZjMGV3NERSeXZIZWwzeFpIVDdLeUUzekt0dG92NGR4?=
 =?utf-8?B?bU1seWIycEVURnU2Y3BqNUtRS0ZQQk1RNTdoaEp1WnhueS8wSm9XRHBFVnFo?=
 =?utf-8?B?N2xycHNGK1VrbEl3REg0UzV3VDdGTnk0Y3NsUEVQM2JJKzhvNzY2S1NxYlFz?=
 =?utf-8?B?OFdIcE9tWVl2RG5udU1KMTFsS0EvUytIQ2Y5NGdDazBFdFZPMmp0cUhzWlhS?=
 =?utf-8?B?YzB4SVVta25uME1LQTlkU09BeVZrbE01ZzhoQkdHYXVFSkxickd4Q3BxZm9q?=
 =?utf-8?B?cE9aNzNoc1NsdGhMUkJuc3FpNTBpWFRlY1QyUEMxY2ZuQmFKckxZSlowQmJI?=
 =?utf-8?B?YW50aS9yRjVWMldaZkd0R2xXNHBvZ21QTXp0SU1YVXZYUjZ5bnQrbXovRXNT?=
 =?utf-8?B?V0NoUHpmRGp6Q0h2K2VxMEhWY2hpZGxzWmJYNGtGNkMzN2RZSEdURlVXVUQ5?=
 =?utf-8?B?WUwxL1ZGT1ZIY2dsN2h6TS9XSGNDby9RaVJtS1lqMHhoVVI1QlphemJBTXpE?=
 =?utf-8?B?aDN6blFyK2c0SWtKT2xvK0R2VlZnVTEydnQrZkgrTlhqeXA0c0VHWitDT1Jl?=
 =?utf-8?Q?CLBEC493vmfRIJGnKK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d0a697-a959-47f5-dc98-08df28d0e89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 02:23:03.0428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxfgmHG8fQG3aWHsyI1SSsreoGJodi/gh4aYUhRlRBa6LmYKcGaXULZBZMiatYbfje+b52UtvC2BStqYjR+8og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

DQpOWFAgQ29uZmlkZW50aWFsDQo+IEZyb206IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0K
PiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxMCwgMjAyNiA1OjAyIEFNIFsuLi5dDQo+ID4gU3Vi
amVjdDogUkU6IFtQQVRDSCBuZXQtbmV4dCB2MSAyLzVdIG5ldDogZW5ldGM6IEVuYWJsZSBwcm9i
aW5nIG9mDQo+ID4gdmVyc2lvbiA0LjQgZGV2aWNlcw0KPiA+DQo+ID4gPiBUaGUgRU5FVEMgdjQu
NCBkZXZpY2VzIGFyZSBwcmVzZW50IG9uIFMzMk43OSBTb0NzIGFuZCBmZWF0dXJlIG9ubHkNCj4g
PiA+IFBzZXVkby1NQUMgRU5FVEMgcG9ydHMsIHdob3NlIFBGcyBleHBvc2UgYm90aCB0aGUgMHhl
MTAxIGFuZCAweGUxMTANCj4gPg0KPiA+IEkgdGhpbmsgdGhlIGRldmljZSBJRCBvZiB0aGUgRU5F
VEMgUEYgd2l0aCB0aGUgcHNldWRvIE1BQyBzaG91bGQgYmUgMHhlMTEwLg0KPiA+IFRoZSBkZXZp
Y2UgSUQgMHhlMTAxIHNob3VsZCBiZSBvbmx5IHVzZWQgZm9yIHRoZSBzdGFuZGFsb25lIEVORVRD
cw0KPiA+ICh3aXRob3V0IHBzZXVkbyBNQUMpLiBJcyB0aGlzIGEgaGFyZHdhcmUgaXNzdWU/IElm
IHNvLCBhIHdvcmthcm91bmQgaXMNCj4gPiB0byBzZXQgdGhlc2UgUEYncyBkZXZpY2UgSUQgdG8g
MHhlMTEwIGluIElFUkIgbW9kdWxlLiBUaGVuIHRoZSBkZXZpY2UNCj4gPiBJRCAweGUxMTAgd2ls
bCBiZSBwcmVzZW50IGluIHRoZSBQQ0llIEVDQU0gc3BhY2UuDQo+ID4NCj4NCj4gT2ssIHdpbGwg
Y29uc2lkZXIgZ29pbmcgZm9yd2FyZCB3aXRoIDB4ZTExMCBleGNsdXNpdmVseSwgaW4gdjIuDQo+
IFRoYW5rcy4NCg0KQXMgQWxleCBleHBsYWluZWQgaW4gdGhlIGludGVybmFsIG1haWwgdGhyZWFk
LCB0aGUgZGV2aWNlIElEIGlzIG5vdCByZWxhdGVkDQp0byBwc2V1ZG8gTUFDIHZzIHBoeXNpYyBN
QUMuIFRoZSBkZXZpY2UgSUQgMHhlMTEwIGlzIHVzZWQgZm9yIHN3aXRjaA0KbWFuYWdlbWVudCBw
b3J0LCBhbmQgdGhlIGRldmljZSBJRCAweGUxMDEgaXMgdXNlZCBmb3Igbm9uLW1hbmFnZW1lbnQN
CnBvcnQuIFNvIHRoZSBjdXJyZW50IHBhdGNoIGlzIGZpbmUsIHRoZSBvbmx5IHRoaW5nIHRoYXQg
bmVlZHMgaW1wcm92ZW1lbnQgaXMNCnRvIGluY2x1ZGUgdGhpcyBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UgdG8gYXZvaWQgY2F1c2luZyB0aGUgc2FtZSBjb25mdXNpb24NCmZvciBvdGhlcnMgYXMgSSBo
YXZlLg0KDQo=
