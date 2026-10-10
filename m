Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C93803D9;
	Sat, 10 Oct 2026 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599263; cv=fail; b=DlipfWdIKOVbSrpzd/o3KOBh4bE71vAEIgZGKzxNIiY5sipmRzSc8e6NqGcoBmvjD48u+o+ef2+LfanWf/1+/OWnuKCafmqg9H6Asj6+CsH5PpnteX1tRx65sVGnoEcEClKYdy9YIJNywuVqrQn98C27gqgiOk0YbVpLe2IcV8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599263; c=relaxed/simple;
	bh=NmcDrgO42s8P8f1Fva/wxy39/uIjmuV3uYio6V39cxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PxGIOXx5O5hSa+tBk4B6NdYraFE3c+Se6IXmdmO0hHdw20gNfptY8uSSG3TxDdlfFU1fLefgejhj2R7OTlIjtzF31f6L233Ud/FrDJBTH5qS3LmGLGAFbGfQWqkPARhkm7+yqNyAh0zKgPCCqCi+SV/vtXkMkBYgffSoMPfcNQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g858LtI3; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g858LtI3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkNVyNHv6JuHxE121TUSGA394ugPNfDeVzdKZuzj2Oxvis06OQVy5iQ7WX+TpNzsNfTYhjjpf6mgv/K8tZvG90KKY+qwf5GDE6FFxIa1ynZr4BA9N7A2zSCAEth2CSMWUfLwxiq4ZM7bLasKCshkO7b6z0h+IjcajBBwstGuQlaMthqONVBCjQTpHWu9eQqvpiAHPf8+4LGoRTAxTjCpVlyby9AmaE9ZdUXtsPd70XnMXt9xZSwXclu1HjboYf6wi6aWgryMRYbA/SbK9f6ZD9JSxHeqn04hm3VEwfDXad9TYk/NjloPcnB1WqKzP2/+c8ttPGtSTkzucYFgi7bnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmcDrgO42s8P8f1Fva/wxy39/uIjmuV3uYio6V39cxA=;
 b=XrRzrT19e0KtHELUp0n9YTQQEcQKAZosnW22L+hOvkCFPz6nUQtBty9T21BHGQ0WRD/FInIc/VQFKVkKjQPZHHWzgJwgjiJAKW0bLQt8GSQRO3cNxMljBrnpr0pwVldJm/PsUCkcaekpHUJOmBN+lUdlYRqZGNWSbzb2buUeQIxxTizcTpQyVnl+Wk+Tp2GviU4x+o4ZoigHD5bfrwMmtcm40nEwjct2xmfNay9RgfJcVb+SfU6rIlV2ScL/a/Vy09O9mFAIkrTjm68S45WoGj16RF4deruza6PcDyBa4lImo63/RP4AkwadnGZF4grC417v4G7FlVT7iHtsPYZ5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmcDrgO42s8P8f1Fva/wxy39/uIjmuV3uYio6V39cxA=;
 b=g858LtI3dyQ6ve6ihRqPJkNcQFxk5fSJezp9ZZrnOAMqK9f657Nr54rWRe6PPBVXqyhvT7PldMjBKXHdc8ujyx07N0OLn1phhSJRRnfXheV5X34wr27u1SzY7xHTEESqiFuPfXFQSel3gaCJmoQRkEm9I7FAY/83hmb5QmCkZGnOjCLxnClMYkfiUmC4Z8TDLYHHo8VlantOCc0ci5Led5+GhL11FymtpNT5o02o0dzjhaXP4u4A29ak2KM7RFvlm7yTqiGBs7MVX1WBfgK19fMeXVCnOSxmi2lCp7o9DFBCX3e6BJ0Hx2w4CUYE7O9yAcfSOVTZ0lTmFKKo90Uk/A==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by MI9PR04MB338771.eurprd04.prod.outlook.com (2603:10a6:290:87::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Sat, 10 Oct
 2026 02:27:39 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:27:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "vjardin@free.fr" <vjardin@free.fr>, "Y.B. Lu" <yangbo.lu@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Ioana Ciornei
	<ioana.ciornei@nxp.com>
Subject: RE: [PATCH net v2 2/3] net: enetc: fix support for PTP_EXTTS_REQUEST2
 ioctl
Thread-Topic: [PATCH net v2 2/3] net: enetc: fix support for
 PTP_EXTTS_REQUEST2 ioctl
Thread-Index: AQHdV4FL/ZfyAh5Xj0W3dqeuhlwZtrb2DsCA
Date: Sat, 10 Oct 2026 02:27:39 +0000
Message-ID:
 <AS4PR04MB9338638ED25F517A2A9B3EF788912@AS4PR04MB9338.eurprd04.prod.outlook.com>
References:
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-0-0f4eeff2295d@free.fr>
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-2-0f4eeff2295d@free.fr>
In-Reply-To:
 <20261009-for-upstream-qoriq-ptp-extts-flags-v2-2-0f4eeff2295d@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|MI9PR04MB338771:EE_
x-ms-office365-filtering-correlation-id: 7d3bc933-0bda-4e7d-a29c-08df26760e01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|38070700021|261009223027099003|10067099003|921020|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003|41080700001|15866825006;
x-microsoft-antispam-message-info:
 OIo8bC7Rb6hfKGUh8AQ82HS84aSw/Eps9fMHJC1W//AvgxVKUq2j6o1kyTDNQWR/JMvXdNyB0c31rQs4NabrGqV9xEGGph7sRYHmW2Nm9iX/dHjnRTeaPQrqtt9xvFFiIri+9MkkqUuofTvSVx6D7bDFESaLGoIgpwYvnJeUTVchuwgUv6iupOi0n5VELkDHR5c2lk9qBsMD0w01zr858kKMMUvijg6FDgKheEfm2XaVvvyX+PaToe+tYW0Lx4xicLrY7iFslKpUDV+7YCDwkpppL/7EK725QWYQhWhH4VpYXdNWKMUaGgOr2bmfmeixxh2ANaG/SXhz6qufbybKxg1I8Bgv2SaVJ84x5AwSXmckvldN5T+NbKwjAiTXE88bEiqFBZWtYFMzzyJH34Mw+HXceQzw1GSnPG8Izjp0kcfMfL1dWsYHDLp2KNy/uGuoXzhXzDwnQQjv/lFeEcDWU6NYIoTcjRAGAsUGDEjTs2j6ZjhAciLOdyDyRBf34/Qu2mi87gFECNBnjcHv9JsiOqrNMC6H48N4uLnbOedebsrnPfuoR0AoNr2+YNUbG1iSmLhmIxsZ7dc7kFw22tAIUGIF6mgNx4l3kBQXYS5Tcj4majfHPSozObMSjyFF0nJ4pojeC2PRVi5z6mU5dYw4cpsnFU3a/Qxp6bIpvYxTBu2AgYfU9SrTqSqnXkD6EhEFp3mggWXNc7EW93fqHX7+2Gs6GczlWkWkdxdSQWGrR+gcp2jVwIkROvPXQUaWsSP+AtkltvZsjWhQWWnm1R9B0upknLL98Px4fvUiPkD3A8awSkdhtT4aj44waxEbXEt7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700021)(261009223027099003)(10067099003)(921020)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1NUQkdacEtpRG9HNmg2NW1FalZSaHR3Qml2T01xY0NCNXUzOFdFcG9kWjhK?=
 =?utf-8?B?dno0WXVLMHJFRHJwdU5ySlpjVzk2VE83bExIOEdzOXNGLzBBQURVdVcwMjF6?=
 =?utf-8?B?WHZXUG1SRlZjNFBNdTNIV3ppRlNSSEZZZVQrRU9aSkM4NDJNSy9sQmNzTXFm?=
 =?utf-8?B?azdKNTFNK1Izc28vUG1FQXZycHhoV21JaEJuN0ppVkMwZFdaWWlQYlFjR2tY?=
 =?utf-8?B?cFUwREMwTUVnTFE1VEtqOVhvc2hFVDMrQng3Y1NkZGc3RGViUW9GcFk2bmVZ?=
 =?utf-8?B?SDhmT25Cc3JzRENkV1hlNWpwNmcwWkJpanU0SUg4QTY0a1NTM0RCanlWby9t?=
 =?utf-8?B?TE03aHhCY25WYVRtNFEzb3N2WVdCRzJFQ09YVXdWdkNTU2h5dUgvb0xUbHRW?=
 =?utf-8?B?aXB4bWF2VmpubHNZTG1pUkJyMHBDNUJtT0IrV1dyMFlFMHN1QnNpcXE4M0xJ?=
 =?utf-8?B?bEhyelBPWVBxQWxmSTFXK29uVzN1d0YzYlFjekZPVzVEMHFXRk9qZXZJS0lU?=
 =?utf-8?B?MTJVdGFZTmp3Y2NlVzMrVnRMZnJBZ2w1RkJIYjB2VHU2eUl5eEZJM0RpTm9v?=
 =?utf-8?B?VVpLWklYTGpDZlRnWkUydE5yYlVxWFNob2NZOXlXazhCWFBvUE5KY2M2S0pv?=
 =?utf-8?B?UUZLaktNZlE4Vm9RRmt0d2pUZktTb1B2MXA5RE4rcVJmYVJLdUlNTGNMQ2l0?=
 =?utf-8?B?NVRQQmFtK01YVHFpOXBsN3V3aWRTYm40T1ZRbjY4M2Z6UWZsZTB5QVRwMFU0?=
 =?utf-8?B?OE9ScWo3cWtPK1dkSWhCZjlndXQ1K1FVZGhkcVVOVWdONWJKbmJ5MVVEZm5j?=
 =?utf-8?B?OEo3dGtTMXVLVGZsZHNNWk9mU21wM0NaVmxsbzZ6RTM2N3ZmSFpLSE9nUVV2?=
 =?utf-8?B?WDhQM2FpVWVrbUt4S2RrSy8rMlpPcE53blBERStUTXBsb3c3WUcyNExtTWtW?=
 =?utf-8?B?bWlRUFNIdzNkWGxSbkY2RHhnWmxRd1RQR1JBUDVFaEtadm9QeHdUbXdRK2lQ?=
 =?utf-8?B?K29zcko0OHowOHZHcVF1d2dEdG0yN0M5S1cvQThTRUZRd3F4Z3N2R1dJU085?=
 =?utf-8?B?VHdMNEt3cmY3MDdabU9PTzcyOUd4U1ZpYURJU0d1dlFhdzc0SVJQQStHa2hG?=
 =?utf-8?B?M1VhT1ArOEwzQ1NKU29kenV0UDJkb3FQUGNrU3lZMDkrYktnVmJzUmNkclZp?=
 =?utf-8?B?YWJ4M3BxeFg4Y3M1OXpnQUVPM09sS0RkWnVjTzQ3Q0k4ZzNCbmx2UEtmNDFk?=
 =?utf-8?B?Qzc4SjZnWC94OGRDVEpKZElpdG1sTVA5anZyNmgvME94SDJYSEliMit5UWFL?=
 =?utf-8?B?UVVpc01pZzlTWlRYdmlwSUwybmMwbkFsQUZJekpZbll1R25SSWdjT1BjMUU5?=
 =?utf-8?B?MVM1dVNMd2xnc0Q2SVdnemJtbWtUVTFpNDg4Ky9qMG4rRlMxYjVTemVnQUVp?=
 =?utf-8?B?VTJXSDhPUkdCTXlRMCtERGk5TGRFMTc1MFA1akkvQkNOU0hDVnZ6R3dlVkRo?=
 =?utf-8?B?NHQ2OUVkVnRJQ3d5UGVseS8vRnUvUnNLME1sMTF2TXMxWm14dmtkRXhyUnNC?=
 =?utf-8?B?S0l0RjVzRmkyM3F0dVNuMFNMRUFHYlR2bCsyS20zVXBwNUM5SHFISlVWK2Rr?=
 =?utf-8?B?UEl2bG1RYktiZGpDU0lJK3hnb2IvTzRzZkVUT2wwWkY2bXRNNVRLTTE4dGxw?=
 =?utf-8?B?MDhJYVNwdEd5UGQ1d2JRdFFHb3BTVncxZ2s3YTBIUVo0OUw5VmJZVGVXM2hF?=
 =?utf-8?B?M095aDBpSEg1VHJUdTNiYTdXdjZ0Nk1pSWJsSmlSRVB1MkM4MkZNRnlldGhk?=
 =?utf-8?B?enhYTWdpRUhieFFQdWFrUW1PVE50YmVlSmRJd01HeVBRcHRValJXS2ZFZjhm?=
 =?utf-8?B?V1dSbEVGWXFqZ3ZUSTVkWUcxMGVqNmZaVDlMNGUvdFRVeG4ycHNWRUZQN0Vu?=
 =?utf-8?B?SVhCeFZTanI1RE9SZHpBcGY5YWs1dmEwUHJsQ3F3R0EzUnFKeDFGVnJhbGJn?=
 =?utf-8?B?WkJEaHNoVzVGNDQ1dG9WcFlzQjAyR2kyKzRHenRPNkJJT3RXVUp6SDRsOTU4?=
 =?utf-8?B?ZmM4TlVqOXVWYWpZNG1YQWxHTlQ0a2ZtSXRmQ0ZSRkx1K3J1bXpUSHNqeWNP?=
 =?utf-8?B?RW1zWGtJTlBHbFhLUTBTRGlmWnJCVlFSdDJ2S1ljSWVSRnZneUdRazVROUxw?=
 =?utf-8?B?eGs3eHJRUHJRK1g5V01GaUdxaHNKOVVSRXVHU0tOS0loYjdUdTZFa3psZTRD?=
 =?utf-8?B?OHJxL0JhY0RMNnAvOVdNU2NNa0c3QkpkL2pxemxocjBzclRtaWN5RkcrVXVY?=
 =?utf-8?Q?Nrl3W18uSByR3JqH0r?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bc933-0bda-4e7d-a29c-08df26760e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 02:27:39.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3MdibS8V4oHZ4UYT3tW2UIFrNjUtLkfUc3F+cufygnoJ2rjVHLzL2uvymGuioqN5SBzqLkDV5LVFAUOjh+enA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB338771

PiBDb21taXQgN2M1NzFhYzU3ZDlkICgibmV0OiBwdHA6IGludHJvZHVjZSAuc3VwcG9ydGVkX2V4
dHRzX2ZsYWdzIHRvDQo+IHB0cF9jbG9ja19pbmZvIikgbW92ZWQgdGhlIHZhbGlkYXRpb24gb2Yg
dGhlIGV4dGVybmFsIHRpbWVzdGFtcCByZXF1ZXN0DQo+IGZsYWdzIGludG8gdGhlIFBUUCBjb3Jl
LiBBIGRyaXZlciB0aGF0IGRvZXMgbm90IHNldA0KPiAuc3VwcG9ydGVkX2V4dHRzX2ZsYWdzIHN0
aWxsIGFjY2VwdHMgdGhlIGxlZ2FjeSBQVFBfRVhUVFNfUkVRVUVTVCBpb2N0bCwNCj4gYnV0IGV2
ZXJ5IFBUUF9FWFRUU19SRVFVRVNUMiByZXF1ZXN0IGlzIHJlamVjdGVkIHdpdGggLUVPUE5PVFNV
UFAuDQo+IA0KPiBUaGUgRU5FVEMgdGltZXIgaXMgdGhlIFFvcklRIDE1ODggdGltZXIsIHNldCB1
cCBieSBwdHBfcW9yaXFfaW5pdCgpLCB3aGljaA0KPiBwcm9ncmFtcyBUTVJfQ1RSTCB3aXRoIEVU
RVAxIGFuZCBFVEVQMiBjbGVhcmVkLCBzbyBpdCB0aW1lc3RhbXBzIHRoZQ0KPiByaXNpbmcgZWRn
ZSBvZiBpdHMgZXh0ZXJuYWwgdHJpZ2dlciBpbnB1dHMuIERlY2xhcmUgdGhhdCwgd2l0aA0KPiBQ
VFBfU1RSSUNUX0ZMQUdTLCBzbyB0aGF0IGEgZmFsbGluZyBlZGdlIHJlcXVlc3QgaXMgcmVqZWN0
ZWQgaW5zdGVhZCBvZg0KPiBiZWluZyB0aW1lc3RhbXBlZCBvbiB0aGUgcmlzaW5nIGVkZ2UuDQo+
IA0KPiBUaGlzIGFsc28gbWFrZXMgdGhlIGxlZ2FjeSBQVFBfRVhUVFNfUkVRVUVTVCBpb2N0bCBz
dHJpY3Q6IGEgcmVxdWVzdCBmb3INCj4gdGhlIGZhbGxpbmcgZWRnZSwgb3IgZm9yIGJvdGggZWRn
ZXMsIG5vdyBmYWlscyB3aXRoIC1FT1BOT1RTVVBQIGluc3RlYWQNCj4gb2YgYmVpbmcgdGltZXN0
YW1wZWQgb24gdGhlIHJpc2luZyBlZGdlLiBUaGF0IGNhbm5vdCBiZSBhdm9pZGVkOiB0aGUgY29y
ZQ0KPiBhZGRzIFBUUF9TVFJJQ1RfRkxBR1MgdG8gZXZlcnkgUFRQX0VYVFRTX1JFUVVFU1QyIHJl
cXVlc3QsIHNvIGEgZHJpdmVyDQo+IGhhcyB0byBkZWNsYXJlIGl0IHRvIGFjY2VwdCB0aGVtLCBh
bmQgb25jZSBkZWNsYXJlZCBpdCBhcHBsaWVzIHRvIGJvdGgNCj4gaW9jdGxzLiBDb21taXQgMzIw
MGZkZDQwMjFkICgiYnJvYWRjb206IGZpeCBzdXBwb3J0IGZvcg0KPiBQVFBfRVhUVFNfUkVRVUVT
VDIgaW9jdGwiKSBtYWRlIHRoZSBzYW1lIGNoYW5nZSBmb3IgYmNtLXBoeS1wdHAuDQo+IA0KPiBG
aXhlczogN2M1NzFhYzU3ZDlkICgibmV0OiBwdHA6IGludHJvZHVjZSAuc3VwcG9ydGVkX2V4dHRz
X2ZsYWdzIHRvDQo+IHB0cF9jbG9ja19pbmZvIikNCj4gUmV2aWV3ZWQtYnk6IEphY29iIEtlbGxl
ciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS29yeSBNYWluY2Vu
dCA8a29yeS5tYWluY2VudEBib290bGluLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBK
YXJkaW4gPHZqYXJkaW5AZnJlZS5mcj4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZW5ldGMvZW5ldGNfcHRwLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9lbmV0Yy9lbmV0Y19wdHAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9lbmV0Yy9lbmV0Y19wdHAuYw0KPiBpbmRleCAxNjJjYmM4MDE3MzAuLjVmZmVlODgyZDYyNCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRj
X3B0cC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0
Y19wdHAuYw0KPiBAQCAtMTYsNiArMTYsNyBAQCBzdGF0aWMgc3RydWN0IHB0cF9jbG9ja19pbmZv
IGVuZXRjX3B0cF9jYXBzID0gew0KPiAgCS5uX3Blcl9vdXQJPSAwLA0KPiAgCS5uX3BpbnMJCT0g
MCwNCj4gIAkucHBzCQk9IDEsDQo+ICsJLnN1cHBvcnRlZF9leHR0c19mbGFncyA9IFBUUF9SSVNJ
TkdfRURHRSB8IFBUUF9TVFJJQ1RfRkxBR1MsDQo+ICAJLmFkamZpbmUJPSBwdHBfcW9yaXFfYWRq
ZmluZSwNCj4gIAkuYWRqdGltZQk9IHB0cF9xb3JpcV9hZGp0aW1lLA0KPiAgCS5nZXR0aW1lNjQJ
PSBwdHBfcW9yaXFfZ2V0dGltZSwNCj4gDQo+IC0tDQo+IDIuNDMuMA0KPiANCg0KUmV2aWV3ZWQt
Ynk6IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KDQo=
