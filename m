Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769361F91D6;
	Mon, 27 Jul 2026 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118044; cv=fail; b=lkI0Q09ohm7O9avZlnklTcrO1mcHUY7Fxg00vfJMjdYy69OcUkAVUDu5Uq76oJiJjwrXVltfSvGIpEo/fwVnZ++MmV2JaLOpfqDfp33c5n8PEYIfOJzOzp+pcxbDMS+KtdGCJ88ajKvstxwgAQzLnqFpLsbR5VVaIJ0Zaqo+E6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118044; c=relaxed/simple;
	bh=L5klyaLN/RaoCRQ27/2RLlWbPOK7uf/v54lVpBYJ2+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jeNoHiZZHKT20/KGNdXPfB1hQtAnIsFZCFFtpmIFeHCUkagdfgmjEoU8L5l3wmE01aQbq90+4OMHrc8yuCOM4Fb/A6UV0HCQAT4M8VHIKmHgIMg/1FVYZHv5h6fAV4gJL+UMHkeMP+e97/1uj3vTBYRji+FvIt2TYi97e1zKO7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TpyIKtmB; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TpyIKtmB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPAdtpBH32OYw4kYtcCfHXfsVpwfxk1LdIRIjWriaKwZKXMh1tr09aNFj12tndTNo3YdyUFeSFzyzxBeDzB3aenyr0hrr8bJG0amIFOiqPwXF4zrYTEI9ZywHMZFZx0eXVmhUjHWC661vcgGUnaq0N+CLs8L7EWEHm3ywWlRf68Hbrf6tCxc7x0svAdZtckEK4n40s0Xo/xEdi+LzU4qpyY3b7SDPVgKftMuTaAlplsUSv4Pk9RyTdvjWNVIkUyC/8EhWUUMUmvK0qqTkGvxWMzWugcF56PeFU1KWfUh9AeTZpxn95v/+XltKqqXmpiAVPWjaV82/m0QUoJ0q6I25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5klyaLN/RaoCRQ27/2RLlWbPOK7uf/v54lVpBYJ2+Y=;
 b=A9wPJ6pn7kPCLLJq5J0Slhkwhn0BLbxIlLSU+0sMVEs2/uphj+rmWavvY0/kROmxyXC9X07aFldmIwm1AT8QaqPKyUNE0AunoxGdGzV6MS35xGHmHa5GgArmX3j+yTcAyxknLVHeSaOTFr8jydy+dgizBmZpUUf4XrdSEe95wCCDu+RrkT2hzTpOGxTpfbDKwoA7S2xhgk2UAP+QLggD0lB0tgapgcDTXtQZudrnlDviX6k53ZwEuPsEPLrf1Nfwf7/ucriAQ0naZjTlDKcKnDhLHQvhBvVmW3/BEewFT0R+je6gk8ww1Ljfs/I0CIfb9qFBJoKga4TbKvJNPDoMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5klyaLN/RaoCRQ27/2RLlWbPOK7uf/v54lVpBYJ2+Y=;
 b=TpyIKtmBeFkXNfwtZHVp3Mw9jO6iIWL+lkpKuy+iQbjiy/RBH1ZiSaF1EhWMX9TyXymBGrLfb+bMKG/QXwhW2RGqEZVzsv5GvwSYQLARI95VbQyiqc22+bwOQGn4A9cfInB7fD/3rzlBWSaVEMA7BJVr6zPy42UnWo/EABbhfzukNWg62oUjVihF+QSWcMrbYcUp7K4u2M4LaAAv/I6kVjKRohMFQwnGZTKoEkklQyPAISbdiQsR48pbchsleO/YqccNRqN0zw9GZtk1RWLFCH4oOxksCjTx4DUXieb4zM0lL5uJEM5bQPqrQBnz3KpvSNej2bUIaqRBKKpGVHKI8Q==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5340.namprd03.prod.outlook.com (2603:10b6:5:24d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 02:07:19 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 02:07:18 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Thread-Topic: [PATCH net-next v4 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Thread-Index: AQHdFMmtdiM6ynZpOEeHKhCNr7H3ZbZvx46AgBDoKoA=
Date: Mon, 27 Jul 2026 02:07:18 +0000
Message-ID: <e3c2a7c5-35d3-4c40-9adb-39e9c8659af8@altera.com>
References:
 <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716021932.20037-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260716-monumental-daring-beagle-28e81d@quoll>
In-Reply-To: <20260716-monumental-daring-beagle-28e81d@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5340:EE_
x-ms-office365-filtering-correlation-id: 2c408ea7-dd70-4d55-924a-08deeb83c993
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|11063799006|4143699003|56012099006|10067099003|3023799007|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 MLx1CyXyDGQCRC0JWeq3U5/dTxDkD7pDWDK/BjqkwjZY4h8RLbiKy8K2Cs+ptH7l99R3zjHzCPrFCA/uH/cFW0FaupmOMUZ96rcPXufbCShyXuHiEEBXfoTS8lwRSBB6Ugpwzp0rlZMgR0laqf2U8T8EuZXlrCz3N+sszpyEiIZfQdav96TSUYDtLcwysosBIRoiUxd0KDfK2OMUJAln7XWuevWEGnvZTlsA+RCgZwvbrtazfx8i9vEO7jjuEJhpV7VB5RpYVNi4Iyn153itgB22xNRl3xPeoRxwsiY4Y5pFC9FYnV8V1Q94U3l9QXEAQyPGIiJQz84LCvhC/tHpG1jlhyBT8J58Ih+XLJdVOZl1X0sy8xRymRccx78BPYolX6EVMMZYmzjunqvv9Hz3Ea+pQdBYe/5P5DeYmX7CQ0g2ChWWAtmdG89uMk6XelfxRWRSyJM1nns9QisClmopj80KybW0dx1sYqJV7OOlBDpnwZcHIH7+g3dyWxU/CuSYsIe1eGqZR4I5wVZaRn6N5fVym51IMTwlwsC9+gLGWd9BZvo3DLjXyQYyu3isTrCrxDSwoYrS787rEddWk7PCFW8o+QGYFnP5XwpSmKmU9sKuAO35WMHTaa0K+8SJcK4Qg0FDwCOKw2cn4QohG107JuZdcG7t7O6fa6iDcXfggzrvfGJUzQjPb83LVHGkAzo9NaNB0RB63YU5/rYIXEmu1g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(3023799007)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHIxWWN1TlpmNmxsd1E4NFpZZ2RzRWd3VmRzM1ZBV3pLVWhsbDZsOVpMS0cx?=
 =?utf-8?B?NU9icWZ6ZWttajlHY2Q0ZEFmaTRHVzVPRHBFcjlWVW41R3pUcm9DdzZlNTdP?=
 =?utf-8?B?eTNDditmU0N0cC9zUCtOU0swS3lKeEpGV2xnODNIdzdpcHpXNS9uODdYUHZx?=
 =?utf-8?B?cHBYU1NVZDVyTEsyVHZ1TkI0cWk2T0NOZStYUHlpejRydG9mQURwQS9zVGZB?=
 =?utf-8?B?NDVBUW9EdU01bmtsd0wrKzRTNjNVU3FUNys5a1lJYnFsSTJ5Qm8rZXY5Witx?=
 =?utf-8?B?MTRVck1sYVNvR3dSSTNtejlwRUV3WFA2WTJiWGN1SnlEVFBMejNPbWNMeVNh?=
 =?utf-8?B?M1hQb2xrM0l2ZFpkd1Z3b1FSc3g1RXNvdzlubWFrcDV4dlY2U213NWpQeVI5?=
 =?utf-8?B?aTE0MjdNZFZCQ0JIdkdQV0hJVzFYUlJMckZoM1ZBMUhPb3QybjVYaHRkQi95?=
 =?utf-8?B?UDNWM25WN0FPZEJaVUhCQTdhd1N4dk9hZ041MHNSWkdVdGdaRHl2ZllkblF6?=
 =?utf-8?B?OHNxRTMwbFpCeXg5eEw4T3ZQUm9zOC9HaW1rTmxhTDhRQUNlUkN1cnp1ci9L?=
 =?utf-8?B?L0gvSkQwbG5QcEJRNStkS083b2hwZU1MZk9DMCt2Sk9RWi9rcDVIMklqM2R6?=
 =?utf-8?B?RklrZ0dOdC9YT3NkcTEyZzNQZEVxOWxUQ2RRNjd3c0NyTEtiMjIvV2ZvaVdW?=
 =?utf-8?B?OVFHRlFGWTBuZkw0K21qWTdudm1kdXVPUDF5WGlQMXRyMXNkRUl4TklLN3N4?=
 =?utf-8?B?UG1lMEsrOHBSVFVocWdBTkJPTTdZdXFHODdVem1LT1lKYzRHWDN6TXpBcmFK?=
 =?utf-8?B?RE03cTJGczJzZUlWMzhlUFdNbk42dm5jdjNRUmVza2tRUkl5M2ltVmtpekZF?=
 =?utf-8?B?MUlITXkyU0ltS2hNQTFYSTFZSnYyb3ZMQ0MxMjdadEZQSnB1cWd3YitXT1hm?=
 =?utf-8?B?ZDhobkNmS2YrbFVTemVtLzhaR2Q0Y1A1VW5PNG04bmI5S3h3VlhZTnA3RktZ?=
 =?utf-8?B?OFphVHFsVEd2N1pNYU9pdkhnNGlrQWUvcFd4c3F3UVkxd2VzNUVoQVRJVUlQ?=
 =?utf-8?B?SlpQRFIvZjkzL0I0cURzeU9ZeVpLUFdQUTRyY1krVkcrV0xuMWVQbTQ4aWRX?=
 =?utf-8?B?cUR1NnlkVGhUVU1qUXBwY3BhQno2U1VZc0tKWEk2bVJjN3I2MXkxeThRNEcr?=
 =?utf-8?B?ckJkbFJ5MmxlQk96V3l2SjFvcVZNV2wzTXhxbVNuR0Q2STg3NXhGSFNFZ2Qv?=
 =?utf-8?B?MUJva1h3RzVFOTVlbEM5MXgvQ3krSW5UZUhSYXEzZytOdysxbFZIaTlqMmpM?=
 =?utf-8?B?UFBXWWluZDlVd1lPaXlZVDZWdS9Lc0F0VFAyR3lOcGlXMDh6NkI3TU9UWDBK?=
 =?utf-8?B?THFzS3JOT3dwaE1qWWJnWmNKWDRTeG1VcUlYV0o2VkZoQXRXRXNLU2pMZTIw?=
 =?utf-8?B?Y0JiTGwzTElqTityNUp4WktZc0l0K1ZaamZDNktXdlZyZzh5K2tWYlJLNzFF?=
 =?utf-8?B?MWM1UUlGa0pqSHprZ0RCRVp2WnRsRTNKbkc3ZlFHR3hSYVRnTkhUOFpkdXJ6?=
 =?utf-8?B?QzdVL09TSG1rVjVYZVVZUDhKMXBQK1pSaG5qcUhTSW13L0JMM3k3WkhiM2Jq?=
 =?utf-8?B?MjFNNUdldU01TG5MaDlxRzhtNVREZEQ1cGhoZGVVVkRSSTFkRmxuUm4xbVdS?=
 =?utf-8?B?bU13RHU2RHkwOUdnMGFkOHhhZ1crRVBSbFdCOXRKczRGbkpyR2YrL0VpcUFx?=
 =?utf-8?B?UlNOMzlQdm1aSmhwbitMT0FmWVppUEtMcHo5RG9FajZXVTBpVkFnRnFxWEkr?=
 =?utf-8?B?WXF3Qkp5WjZoSVRHZk4vWlZzYi9jYVNSUk9GeUpvTkJPRlRzbEM2b3FHbUpV?=
 =?utf-8?B?Snl5cjMyL2p2eTFyN2IxZGFKbFZ2Vlh5bmxrSXowMTJZT0ZXZ0dlcWR4NytX?=
 =?utf-8?B?emxYaDMyZlBUVTFnWjBhYlRPZ2RtM1d0ZTFqbHVLVnFHM0dQTk0zK3V3YW5z?=
 =?utf-8?B?V2RFeDQwQk9rN1VHNFQzOXByMTBkcHJPOVZsdzhJYnY4WnVJRmk3TjNaZ3c4?=
 =?utf-8?B?bWR5Z284TlhkUzJQRUJCNy90SSt4ZWtMRjlOZVZ1WDRRbG51TXhWRHVSK3A2?=
 =?utf-8?B?SVd1ZmlSWnZBNUFEVmFhS2tBZjE0dmZZRk5BeDBaZkI5QnVzcDFmNFpSZGFy?=
 =?utf-8?B?R1YzRkNJc08xc3h4bi9KaUhEWUlXOGtXclJYM0RSbXAwejU1ZU9BYUVQUy9q?=
 =?utf-8?B?ZThvUnVxUUhNWXZOY2plOGtmaWpzN2g5QjY0M3FubWNPWjg1Mm04amRCbHRU?=
 =?utf-8?B?a3lwejQvUjlwU3d5WlgzMk1XVWQ1YlRtbmdPcDZTbktxR1o4Y1VwV0lMNGx5?=
 =?utf-8?Q?402tm2/6LtZE7OXaNkts2xcO9mEEIKXGqdRWY1xPM5Gm9?=
x-ms-exchange-antispam-messagedata-1: jNsrxwPtjeP5c8fLyMl1Zg230Oj9cJ+aI80=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D89FA742310847A9C96AEBE0353C1C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c408ea7-dd70-4d55-924a-08deeb83c993
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 02:07:18.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRjBRxvhv65z28nsGlUi8CEE54HeBolLIzL53BzGEEWcgd6ewZniIK/wT1LdA9WQuXD5tCrCa7HNHkp9vQ3DAJ0leckTmkls+tbVsTqRU0ADzaVvu/dBHwFWJs5s2FevsVGY74RBUnrEsRNEYRmmjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5340

T24gMTYvNy8yMDI2IDM6NTYgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFdl
ZCwgSnVsIDE1LCAyMDI2IGF0IDA3OjE5OjMyUE0gLTA3MDAsIG11aGFtbWFkLm5hemltLmFtaXJ1
bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+IEZyb206IE5hemltIEFtaXJ1bCA8
bXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IFRo
ZSBBZ2lsZXg1IFNvQ0RLIFRTTiBDb25maWcyIGJvYXJkIHVzZXMgYSBHTUlJLXRvLVJHTUlJIGNv
bnZlcnRlcg0KPj4gaW1wbGVtZW50ZWQgYXMgRlBHQSBzb2Z0IElQIGJldHdlZW4gZ21hYzEgYW5k
IGl0cyBQSFkuIFRoaXMgY29udmVydGVyDQo+PiBwcm92aWRlcyB0aGUgUkdNSUkgVFgvUlggY2xv
Y2sgZGVsYXlzLCBzbyB0aGUgTUFDIGludGVyZmFjZSBzZWxlY3Rvcg0KPj4gbXVzdCBiZSBjb25m
aWd1cmVkIGZvciBHTUlJIHdoaWxlIHRoZSBQSFkgaXMgY29uZmlndXJlZCB3aXRob3V0IGRlbGF5
cy4NCj4+DQo+PiBBZGQgdGhlICJhbHRyLHNvY2ZwZ2Etc3RtbWFjLWFnaWxleDUtdHNuIiBjb21w
YXRpYmxlIHRvIHRoZSBtYXRjaCB0YWJsZQ0KPj4gYW5kIGRldGVjdCBpdCBpbiBwcm9iZSB0byBm
b3JjZSBHTUlJIGZvciB0aGUgTUFDIGludGVyZmFjZSBzZWxlY3RvciBhbmQNCj4+IHN0cmlwIHRo
ZSBkZWxheSBiaXRzIGZyb20gcGh5X2ludGVyZmFjZSBzbyB0aGUgUEhZIGlzIG5vdCBjb25maWd1
cmVkIHRvDQo+PiBhZGQgZGVsYXlzIGFscmVhZHkgcHJvdmlkZWQgYnkgdGhlIEZQR0EgY29udmVy
dGVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQubmF6aW0u
YW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBM
dW5uIDxhbmRyZXdAbHVubi5jaD4NCj4+IC0tLQ0KPj4gdjQ6IEFkZCBSZXZpZXdlZC1ieSBmcm9t
IEFuZHJldyBMdW5uLg0KPj4NCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1t
YWMvZHdtYWMtc29jZnBnYS5jIHwgMTMgKysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zb2NmcGdhLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zb2NmcGdhLmMNCj4+IGluZGV4
IDFkN2YwYTU3ZDI4OC4uYmY1OTFhNjg1MDJmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtc29jZnBnYS5jDQo+PiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zb2NmcGdhLmMNCj4+IEBAIC02OSwx
MiArNjksMTMgQEAgc3RydWN0IHNvY2ZwZ2FfZHdtYWMgew0KPj4gICAJdm9pZCBfX2lvbWVtICp0
c2VfcGNzX2Jhc2U7DQo+PiAgIAl2b2lkIF9faW9tZW0gKnNnbWlpX2FkYXB0ZXJfYmFzZTsNCj4+
ICAgCWJvb2wgZjJoX3B0cF9yZWZfY2xrOw0KPj4gKwlwaHlfaW50ZXJmYWNlX3QgbWFjX2ludGVy
ZmFjZTsNCj4+ICAgCWNvbnN0IHN0cnVjdCBzb2NmcGdhX2R3bWFjX29wcyAqb3BzOw0KPj4gICB9
Ow0KPj4gICANCj4+ICAgc3RhdGljIHBoeV9pbnRlcmZhY2VfdCBzb2NmcGdhX2dldF9wbGF0X3Bo
eW1vZGUoc3RydWN0IHNvY2ZwZ2FfZHdtYWMgKmR3bWFjKQ0KPj4gICB7DQo+PiAtCXJldHVybiBk
d21hYy0+cGxhdF9kYXQtPnBoeV9pbnRlcmZhY2U7DQo+PiArCXJldHVybiBkd21hYy0+bWFjX2lu
dGVyZmFjZTsNCj4+ICAgfQ0KPj4gICANCj4+ICAgc3RhdGljIHZvaWQgc29jZnBnYV9zZ21paV9j
b25maWcoc3RydWN0IHNvY2ZwZ2FfZHdtYWMgKmR3bWFjLCBib29sIGVuYWJsZSkNCj4+IEBAIC02
NTAsNiArNjUxLDE1IEBAIHN0YXRpYyBpbnQgc29jZnBnYV9kd21hY19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAJcGxhdF9kYXQtPnBjc19leGl0ID0gc29jZnBnYV9k
d21hY19wY3NfZXhpdDsNCj4+ICAgCXBsYXRfZGF0LT5zZWxlY3RfcGNzID0gc29jZnBnYV9kd21h
Y19zZWxlY3RfcGNzOw0KPj4gICANCj4+ICsJZHdtYWMtPm1hY19pbnRlcmZhY2UgPSBwbGF0X2Rh
dC0+cGh5X2ludGVyZmFjZTsNCj4+ICsNCj4+ICsJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxl
KHBkZXYtPmRldi5vZl9ub2RlLA0KPj4gKwkJCQkgICAgImFsdHIsc29jZnBnYS1zdG1tYWMtYWdp
bGV4NS10c24iKSkgew0KPiANCj4gRG9uJ3QgYWRkIGNvbXBhdGlibGVzIGFyb3VuZCB0aGUgY29k
ZS4gRG9lcyBub3Qgc2NhbGUuIFlvdSBoYXZlIGRyaXZlcg0KPiBtYXRjaCBkYXRhIGV4YWN0bHkg
Zm9yIHRoYXQgcHVycG9zZS4NCj4gDQo+PiArCQlkd21hYy0+bWFjX2ludGVyZmFjZSA9IFBIWV9J
TlRFUkZBQ0VfTU9ERV9HTUlJOw0KPj4gKwkJaWYgKHBoeV9pbnRlcmZhY2VfbW9kZV9pc19yZ21p
aShwbGF0X2RhdC0+cGh5X2ludGVyZmFjZSkpDQo+PiArCQkJcGxhdF9kYXQtPnBoeV9pbnRlcmZh
Y2UgPSBQSFlfSU5URVJGQUNFX01PREVfUkdNSUk7DQo+PiArCX0NCj4+ICsNCj4+ICAgCW9wcy0+
c2V0dXBfcGxhdF9kYXQoZHdtYWMpOw0KPj4gICANCj4+ICAgCXJldHVybiBkZXZtX3N0bW1hY19w
bHRmcl9wcm9iZShwZGV2LCBwbGF0X2RhdCwgJnN0bW1hY19yZXMpOw0KPj4gQEAgLTY3NCw2ICs2
ODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzb2NmcGdhX2R3bWFjX21h
dGNoW10gPSB7DQo+PiAgIAl7IC5jb21wYXRpYmxlID0gImFsdHIsc29jZnBnYS1zdG1tYWMiLCAu
ZGF0YSA9ICZzb2NmcGdhX2dlbjVfb3BzIH0sDQo+PiAgIAl7IC5jb21wYXRpYmxlID0gImFsdHIs
c29jZnBnYS1zdG1tYWMtYTEwLXMxMCIsIC5kYXRhID0gJnNvY2ZwZ2FfZ2VuMTBfb3BzIH0sDQo+
PiAgIAl7IC5jb21wYXRpYmxlID0gImFsdHIsc29jZnBnYS1zdG1tYWMtYWdpbGV4NSIsIC5kYXRh
ID0gJnNvY2ZwZ2FfYWdpbGV4NV9vcHMgfSwNCj4+ICsJeyAuY29tcGF0aWJsZSA9ICJhbHRyLHNv
Y2ZwZ2Etc3RtbWFjLWFnaWxleDUtdHNuIiwgLmRhdGEgPSAmc29jZnBnYV9hZ2lsZXg1X29wcyB9
LA0KPiANCj4gT3RoZXJ3aXNlIGR2aWNlcyBhcmUgY29tcGF0aWJsZT8gVGhleSB3aHkgd291bGQg
eW91IG5lZWQgdGhpcyBlbnRyeSBpbg0KPiB0aGUgZmlyc3QgcGxhY2U/DQpIaSBLcnp5c3p0b2Ys
DQoNCkp1c3QgdG8gY29uZmlybTogc2hvdWxkIHdlIGFkZCBhIHNlcGFyYXRlIHNvY2ZwZ2FfYWdp
bGV4NV90c25fb3BzIGFuZCANCnVzZSB0aGF0IGFzIC5kYXRhIGZvciB0aGUgVFNOIGNvbXBhdGli
bGUsIGluc3RlYWQgb2YgY2hlY2tpbmcgdGhlIA0KY29tcGF0aWJsZSBzdHJpbmcgaW4gcHJvYmUg
YW5kIHJldXNpbmcgc29jZnBnYV9hZ2lsZXg1X29wcz8NCg0KQmVzdCByZWdhcmRzLA0KTmF6aW0N
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
