Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5C2135AD;
	Fri, 31 Jul 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514357; cv=fail; b=rR6J81BidRNyJkmaTHsaxXePu9zjFG4qr/CJo6wAZhG0nZZ9q4JnaIupJaFFUUgfbSPTpNrHgeg29RvHm7AI0PoSQpNkOGlc35li4rj2fGC/32J5N2/qihYU4ixLm1ho6vfc641FeJqdREvicYZl4GmIL+6TL3no/jCJBEPvbok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514357; c=relaxed/simple;
	bh=Loi3KW9uwyJtfPHJWOEDzDC47uTIQFdz7LqbU+DJRDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ER+tSbFNKKrekb40q5Zxis7dFHvgNeL2QHcVUiqGGIMjB+UNHqM0V/wTgo/dxQwmItlkm3wp/adQHtk/+ikGiY7VkQqIrpYS4A1e0cTNbD3ADi7n0///IJBu9y4l03suMeK3ig2NOfmL3h9AniXAtnJDzf3mHA6+pqW599+mD+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=s7OMxbxV; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="s7OMxbxV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsmZXn72M+P1qmOAlqAi+SbyUGNTPLdCSddJ7gf2e6cnbdhVcOWC4REbGabe1JIPfAKMZEC0Sl3MkzkNAnm3V68hQx03AcUF/GuTnUU6z2cp97QfKmV4Ty+Fhrfslkj0VUenv19bAmgh3wrGWDEk6niHl4rj4XETCxiOLNo9TJzrGHDfhX9iV5xb97zgcPrbXinfncUIM+RO5fXBFU/hsX8NeqHjsT8z6hAvYqKUG8IHPTtY0S/Yv/fQhb74tkBMaSgCmMDuJJQZEu6IbXFxmB7zqLv8DYiZHaqxh7R9uSvSzg9Bt6FEcOfqd9/WTgeTBbDSKVGqK5ci6TpD4JJ/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loi3KW9uwyJtfPHJWOEDzDC47uTIQFdz7LqbU+DJRDE=;
 b=njZxLTcYfT3XcZN0u8N7i18HnURMnpzPqtl8+NZvCnr/faZ/txxJOskRL1yxbE9yb9+yS8h6H01x9p5BXJUrem59f2fxBvNonJdcwQ+0eF3nfAthsYtSFaMSboAnPNjkjGDLxXemRbXCQW7cwFywX/10pRVlji5vPIfkM2of6Emo+6o51BZTlQQuBonPDhZs+2KZbpS4wUNRM/3nZyI6Cv5oGAT7HpI9nXkcg70dyeZUhYloMIgbq4+LsfqGSZEyH5VCWUssNhDsHByKe4i8AlbLTiSIYC6uWbotVZGsQA+/nawYiPhT4T0haEKmw0hSHJ8Vjbut2eYTX0gO17XXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Loi3KW9uwyJtfPHJWOEDzDC47uTIQFdz7LqbU+DJRDE=;
 b=s7OMxbxVnZ7aMKU8RpUwauSyoROzK2HdlfJcvEFW5a7kcNkC370ya8w6mJM5EknF0j6V6PW5j2//XzPGb1D3i5ecbPiDeTm2CWep6bep9HdE917kAAldMAD4HBP0LC+tuSNRJWJziBJjW1Afe2SfSA5OnOgr91khaoR9nRgC7T3lHGxJWZUsFUmtEBsZ+6DCYSYYBUnBxGyp4x6/yixj5C6NX1G3ZgQdbM2DKX+S1jUuAiihFpZ3ZtvKBWK6DUAEO3/2MqfmErdzffWj5yKjxqpkjV7AuCNHtYrelJualZHFRcmKvRme0rdZ36rm4e076baJURwbWShHhmFSsIN2Rg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB8294.namprd03.prod.outlook.com (2603:10b6:8:296::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 31 Jul
 2026 16:12:32 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 16:12:31 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "jun.ann.lai@intel.com"
	<jun.ann.lai@intel.com>, "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>,
	"NG, BOON KHAI" <boon.khai.ng@altera.com>, "matthew.gerlach@altera.com"
	<matthew.gerlach@altera.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Topic: RE: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Index: AQHdH05wmmgu7tuEFEmpHlpVOh/nAbaGCZOAgAAOaYCAAbgtAA==
Date: Fri, 31 Jul 2026 16:12:31 +0000
Message-ID: <5954dadd-f1d9-4b38-a3a4-7c17530a5256@altera.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <af97a4a2-9a1d-4b36-9055-d05124bf4ab9@bootlin.com>
 <d5013c57-258d-44d2-a98d-2b1cbe541380@altera.com>
 <OSCPR01MB127691D8052A6BBBBDC10C0BDD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSCPR01MB127691D8052A6BBBBDC10C0BDD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB8294:EE_
x-ms-office365-filtering-correlation-id: 92754168-6f5a-400f-5753-08deef1e866a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|38070700021|6133799003|56012099006|4143699003|10067099003|11063799006|55112099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 VRE9brG+cefkeltbgxzV5t3SBNVX/ls5KO50w4Yw7zrKvSOptab0bMwxpz9sPrp1inHFCuySUwz93uANLk7NSWB2skDZ11uotdLegqubJDVaNoQrQbYvjf2lpoNaqDAr3smLGJbWiyTAMQKyuAMQel1XOumaiRU+ICFTdJmTpQNG5rXyI182m2EOngn7WTEDsh5AzUquN8zBx3PrY/9AXHKUpT0/GAn6WWKurDldkNRwAsU0s4HI7rtCHOB8QsrBs2/3qChFylIgrG+e3JtfSYz3gbfA+HpgkVhy85Vd9tjnbhZeVwOlSAQdPZ5JiGUVnoqhFD4h/aumXKpvLvNJokqaWU2iSruTGdDoc0xMQE5iXUaIp3zs/011GBbCZMQUkU3NICeVIFYFr+IvK+qlbsPyp3F70BFr4JB+p3uIW4vxV3K+JvpyJaz6b8cqLlWRf2YucytiQeK53j/UWkX0jeTRonNRu3ZT+Dozb2P5e4vpVYPM2d1OqjMRRseka+a/h5SF1DZDUwc8KJNDiw/zgHi0v2xXpqZNmvE5u/rRJM5tnXIAnjFuivBnbn6aa2/CJAb28dYz+Lq9lSSdxs8dVr0q+jZLfiNo8VNVUN1Xl+OIYx6FrCnBJeFUtwaJqWigt/Nddy9DJ7wvf0KPOXXA8SQGUsbZI9mNq4MqNdeS9nyKEXCEmR4uG/c2xIyifJLjCHVGjwp7qw575HNUEvLgK/A9DjEqjYazN2bGXKMbYVSavB6hYe2Do1RzxaBOzi5d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(38070700021)(6133799003)(56012099006)(4143699003)(10067099003)(11063799006)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWlXV3FqUTYwWnU2djJEd3k5MWZQVXhEcDdNdDVmbWpiK2lDeEMxWk9ZYXht?=
 =?utf-8?B?Yi9taHE2dndtM2NNTEU3Zm5uUEdkYnNRRktwQVhiamh1bmFob0FKQWthNzI3?=
 =?utf-8?B?WHJWcDJyRS8xNGFrS24yU1B2dGtXRnZFYm0rSERqVTRCOXhDTEhvRjJTaG85?=
 =?utf-8?B?ZUdxQ0Z2U3hrZXEyR2EvZEJiMkZic3diYVU3UTBlclQxUjRUNTRiL2hOazRZ?=
 =?utf-8?B?QitON3gyUGFGelJEYTFCVkdydStIYWphUEh5OXRGbjNZVkw1VlJjanJnVmpm?=
 =?utf-8?B?d2VQWUhQKzMyLy9HUlJPZ3Fpdy9oUmxiZmI2N045by9OMGtlckVabTZ1ZElX?=
 =?utf-8?B?QkhpZ3JIQ243RTgybC9TbXRBaDB2djM1c0wzVnBVVFlhK1IxOTBnSGtBYXBH?=
 =?utf-8?B?UlFSZnllQjh4aStCa0pjRm8yekhDU0thazJ0cVJVUXZNaGw3OGVVU1hmRTFT?=
 =?utf-8?B?U1pFT2hYL2s4NGhBb2dQTEVQSG1SRCtRVnRRSDdFWTI2UmRDWDYxVDNyeWxj?=
 =?utf-8?B?NWdINVBJcUozdHVqeVgxMHZIQVRRUjI3YVptVzRadEY0Y1RZcEVyWktqU3lW?=
 =?utf-8?B?RDdGai85WXAyOWx2OVZvVTFUWkZMMXJYRmZGMG5QNjBscGJBSnlCQldFWTdK?=
 =?utf-8?B?TSs1UFZzZGZiM3VBell0QXNidTF3Y3JvVlBPbFpGeWtFY3RQMW5obnY4cXpu?=
 =?utf-8?B?U0t2alJUSmkwMWpnejhlNGhyUytLOGh3bnA4K3dGbDdlVStXT3hqVC96aCtt?=
 =?utf-8?B?L1VBK0lVYkRpblBKbUJtVDhYcXk5YW5pazFTMnVOQVByc1dUM2NoZTd0Z1hk?=
 =?utf-8?B?QXl6WUVFK3J3R2FCczNBS29RUHZpYTA3eXVBU1RzWTJJSld3MFIyK09nRklV?=
 =?utf-8?B?UWlvcW5Jelp3Q0hjRCtac0t6NUgraDNXeUJXU3B4MXpYWDErK003Y1gvcmly?=
 =?utf-8?B?MjE3THA1U3M1bTAyaDJwQ0RjZlFrRTRGU3Y2SVpZVWs0TDArZVFtQnhQRHlC?=
 =?utf-8?B?NFcwNE1KM3pCYUJLcllSL3BlYkd4S28wMmJ5ZHlFcFUyMVVHNXcySlpxUGVu?=
 =?utf-8?B?eG9BaGh1RWFZM1BKd0U3OEY0bndXUUpBMEpXWWwvcGRaWWE4RkMyZmJ1QlZ3?=
 =?utf-8?B?Q2xWMUZQYllLS2w2YWQyUXVRY2FxVTNqRUZYMlQrbW9TTGN1aE5yanA2RXFJ?=
 =?utf-8?B?M1FYOGcxektFbzQvclZIRllxM1ZmcFVvLytxMVFpcGRWbU9rQ2QzVXQ1VnBr?=
 =?utf-8?B?RUt1Ujc0OTA5RlhFY0M5M2hmQmcrNGFiK3pMSHFvRC9ZR3pqT2pQZ2NVUUNJ?=
 =?utf-8?B?MFFzcW1VOWpCdFhYcHNHSlRuWHQrR1RhNytrMk1rbi9JWDJYN2h4VVpqQ0ZK?=
 =?utf-8?B?RmE2VHNUKzRaUHdFbW1Sb3V5Q09iV3JsQjFPZGtmdW93N2Q0dFlSblloUDBX?=
 =?utf-8?B?Mk1DaEYyd2UyRnNSYUF3MkpxTFNXMHphOFgvellVekY0cUliUFNHcURWa2RD?=
 =?utf-8?B?RTl6UUtnL29HWVNrNUpDSDZvSEp4Mnd1d3VwMGZYUWJ6SWJKSUZYQTBwaFY3?=
 =?utf-8?B?RnAzbTB2czBnckQ2TjVFeDNLc1MvbkRFb0t5LzY0K3gvNnF6MkNSZUhaSDlw?=
 =?utf-8?B?L0l5WEQ5R1E2S0xXdFVaZDJqTllVYVgrdTVEWVh2K2k5c2J4dVdYQ1hTU05I?=
 =?utf-8?B?eEJqNXU5N3c3WTRRaXZEM3VXNXV3MlhwMTA3azkxNWlib1ZHMitwNlhZcGZq?=
 =?utf-8?B?UmdvdDJ5bEdvbW05U0FDU3VDbDREU0tBMi9lMmJBZE9LK3dIQmhycHljTmJK?=
 =?utf-8?B?NlIySit4Q05WRGdZMlFqTFdBcUJuZUc4MXZmNnpyR2UwTkdUOVdVR0RuUTNt?=
 =?utf-8?B?eENmUFhzUTJwLytmVWIvNHlBb3cxMy9NU1RTOVhiSm8vMTI3U2N5a2tJdmhI?=
 =?utf-8?B?YWdCeWhYTEhMcm5qbTM2dTlWMit3Y1hTR2tvdFRGVTBzZS8wb2NoMnlPV2dq?=
 =?utf-8?B?dkpHZlhFVS82MTkwVkI2dml3eDV4a1Jpb3N4enlqTW1Ka1A2T2o3SlJnL1hE?=
 =?utf-8?B?Q01kUk52eUd0SmdQcHl6SlFPSHJzSSt2eUJhY0kyVGRYMS9yLzE3bklaWlJL?=
 =?utf-8?B?N3V4Q2Z3SVJFOUNCMjYrK1lYVlpoRk15MGhIWkd5T0NLMHJLV1FMSTdrM0hy?=
 =?utf-8?B?VlkyWHFkNjhyd1B0OW5rMEpmZW12cmdqVUtyZTQyUktzUDNlUHp1VGJJR2g2?=
 =?utf-8?B?WURYNHd3R3lMaHAyMG1zSDY4a2Z0U25jdHh1ZWwwS2l6bmdFUzFwM3FGYURu?=
 =?utf-8?B?QSs4N1RDUXFlanVzemo4SytqaHF4L014anhPdVRtSGh3cTJRWHJyclg1SmJC?=
 =?utf-8?Q?opiQAGK6pfcwpi9aF4qnfQrzwaHjHPUJ6wyzP2j4rKi6i?=
x-ms-exchange-antispam-messagedata-1: lBfHTcor3vx9ERH0FzK/CditiSsYJqjP6Ww=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B66E31C549AED64D9791D33225FE0045@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92754168-6f5a-400f-5753-08deef1e866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 16:12:31.5296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArZyse+F+3Bn0bTlWdcmPRmrPIBptMaat+QfaleOlV+kEL/h8k7w6ITNwT2ZEBfmAEyXrPE1st4N1mNKwN9bgCL/68WjhtkQ+PFR1hGEVZeUNG5JmSk2So3pOfyFJJvCSxhFU9uDg0aJO7H/e1Rf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8294

T24gMzAvNy8yMDI2IDk6NTcgcG0sIE92aWRpdSBQYW5haXQgd3JvdGU6DQo+IEhpIE5hemltIEFt
aXJ1bCwNCj4gDQo+PiBPbiAyOS83LzIwMjYgNzozNSBwbSwgTWF4aW1lIENoZXZhbGxpZXIgd3Jv
dGU6DQo+Pj4gKyBOYXppbSBBbWlydWwNCj4+Pg0KPj4+IE9uIDcvMjkvMjYgMTE6NTEsIE92aWRp
dSBQYW5haXQgd3JvdGU6DQo+Pj4+IEN1cnJlbnRseSwgaGFyZHdhcmUgVkxBTiBzdHJpcHBpbmcg
aXMgYnJva2VuIGZvciA4MDIuMWFkIHRhZ3MuDQo+PiB2bGFuX3J4X2h3KCkNCj4+Pj4gaGFyZGNv
ZGVzIEVUSF9QXzgwMjFRIHdoZW4gcHV0dGluZyB0aGUgaGFyZHdhcmUgdGFnIGludG8gdGhlIHNr
YiwNCj4+IHJhdGhlcg0KPj4+PiB0aGFuIHVzaW5nIHRoZSBhY3R1YWwgcHJvdG9jb2wgZnJvbSB0
aGUgcGFja2V0LiBCZWNhdXNlIG9mIHRoaXMsDQo+PiBwYWNrZXRzDQo+Pj4+IHRoYXQgY29udGFp
biBhbiA4MDIuMWFkIG91dGVyIHRhZyBhcmUgaW5jb3JyZWN0bHkgcGFzc2VkIHVwIHRoZSBzdGFj
aw0KPj4gYXMNCj4+Pj4gaGF2aW5nIGFuIDgwMi4xUSB0YWcuDQo+Pj4+DQo+Pj4+IFRoaXMgaXNz
dWUgd2FzIG9ic2VydmVkIG9uIHRoZSBSZW5lc2FzIFJaL1YySCBwbGF0Zm9ybSAod2hpY2ggaGFz
IGENCj4+IGR3bWFjNA0KPj4+PiBJUCksIHdoZW4gdGVzdGluZyBRaW5RIHBpbmc6DQo+Pj4+DQo+
Pj4+ICAgICAjIERVVA0KPj4+PiAgICAgaXAgbGluayBhZGQgbGluayBlbmQwIG5hbWUgZW5kMC4x
MDAgdHlwZSB2bGFuIHByb3RvIDgwMi4xYWQgaWQgMTAwDQo+Pj4+ICAgICBpcCBsaW5rIGFkZCBs
aW5rIGVuZDAuMTAwIG5hbWUgZW5kMC4xMDAuMjAwIHR5cGUgdmxhbiBwcm90byA4MDIuMXENCj4+
IGlkIDIwMA0KPj4+PiAgICAgaXAgYWRkciBhZGQgMTcyLjE2LjMuMi8yNCBkZXYgZW5kMC4xMDAu
MjAwDQo+Pj4+ICAgICBpcCBsaW5rIHNldCBlbmQwIHVwDQo+Pj4+ICAgICBpcCBsaW5rIHNldCBl
bmQwLjEwMCB1cA0KPj4+PiAgICAgaXAgbGluayBzZXQgZW5kMC4xMDAuMjAwIHVwDQo+Pj4+DQo+
Pj4+ICAgICAjIFBlZXINCj4+Pj4gICAgIGlwIGxpbmsgYWRkIGxpbmsgZXRoMCBuYW1lIGV0aDAu
MTAwIHR5cGUgdmxhbiBwcm90byA4MDIuMWFkIGlkIDEwMA0KPj4+PiAgICAgaXAgbGluayBhZGQg
bGluayBldGgwLjEwMCBuYW1lIGV0aDAuMTAwLjIwMCB0eXBlIHZsYW4gcHJvdG8gODAyLjFxDQo+
PiBpZCAyMDANCj4+Pj4gICAgIGlwIGFkZHIgYWRkIDE3Mi4xNi4zLjEvMjQgZGV2IGV0aDAuMTAw
LjIwMA0KPj4+PiAgICAgaXAgbGluayBzZXQgZXRoMCB1cA0KPj4+PiAgICAgaXAgbGluayBzZXQg
ZXRoMC4xMDAgdXANCj4+Pj4gICAgIGlwIGxpbmsgc2V0IGV0aDAuMTAwLjIwMCB1cA0KPj4+PiAg
ICAgcGluZyAxNzIuMTYuMy4yDQo+Pj4+ICAgICAgIC0tIEZBSUwgLS0NCj4+Pj4NCj4+Pj4gVGhp
cyBzZXJpZXMgYWRkcmVzc2VzIHRoZSBpc3N1ZSBmb3IgYm90aCBkd21hYzQgYW5kIGR3eGdtYWMy
Og0KPj4+PiAtIGR3bWFjNDogc2luY2UgZHdtYWM0IGRvZXMgbm90IGV4cG9zZSB0aGUgdGFnIHR5
cGUgaW4gdGhlIFJERVMzDQo+Pj4+ICAgICBkZXNjcmlwdG9yLCBpdCBjYW5ub3Qgc3VwcG9ydCBo
YXJkd2FyZSBkb3VibGUgVkxBTiBzdHJpcHBpbmcNCj4+IGNvcnJlY3RseS4NCj4+Pj4gICAgIFRo
aXMgc2VyaWVzIGRpc2FibGVzIGRvdWJsZSBWTEFOIHN0cmlwcGluZyBmb3IgaXQsIHNvIHRoZSA4
MDIuMWFkDQo+PiB0YWdzDQo+Pj4+ICAgICBhcmUgbGVmdCBpbiBwbGFjZSBhbmQgYXJlIGhhbmRs
ZWQgYnkgdGhlIHNvZnR3YXJlIFZMQU4gcGF0aC4NCj4+Pj4NCj4+Pj4gLSBkd3hnbWFjMjogdGhl
IFJERVMzIGRlc2NyaXB0b3IgZG9lcyByZXBvcnQgdGhlIHR5cGUsIHNvIHRoZSBjb2RlIHdhcw0K
Pj4+PiAgICAgdXBkYXRlZCB0byByZWFkIGl0IGluc3RlYWQgb2YgaGFyZGNvZGluZyBFVEhfUF84
MDIxUS4NCj4+Pj4NCj4+Pj4gTm90ZTogcGF0Y2ggNS81IHdhcyBjb21waWxlIHRlc3RlZCBvbmx5
LCBhcyBJIGRvIG5vdCBoYXZlIHRoZSBoYXJkd2FyZS4NCj4+Pj4gSG93ZXZlciwgaXQgdXNlcyB0
aGUgc2FtZSBjb2RlcGF0aCBhcyBkd21hYzQsIHNvIGl0IGhhcyB0aGUgc2FtZSBpc3N1ZS4NCj4+
PiBOYXppbSBBbWlydWwsIGFzIHlvdSBzZWVtIHRvIGhhdmUgYWNjZXNzIHRvIHNvbWUgQWdpbGVY
NSB3aXRoIFhHTUFDLCBjYW4NCj4+IHlvdQ0KPj4+IHNlZSBpZiB5b3UgY2FuIHJlcHJvZHVjZSB0
aGUgaXNzdWUgb24geW91ciBzaWRlIGFuZCBpZiB0aGlzIHNlcmllcw0KPj4gc29sdmVzIGl0ID8N
Cj4+DQo+PiBIaSBNYXhpbWUsDQo+Pg0KPj4gVGVzdGVkIG9uIG15IGVuZCBhbmQgc2VlaW5nIHRo
ZSBzYW1lIGZhaWx1cmUgYXMgYWJvdmUgd2l0aG91dCB0aGlzDQo+PiBzZXJpZXMsIGlzIHRoaXMg
cGF0Y2ggNSBpcyB0aGUgb25seSBwYXRjaCBuZWVkZWQgdG8gZml4IHRoZSBwcm9ibGVtPw0KPiAN
Cj4gRm9yIGR3eGdtYWMyIHllcywgcGF0Y2ggNSBpcyB0aGUgb25seSBvbmUgdGhhdCBpcyBuZWVk
ZWQuIER3bWFjNCBkb2Vzbid0IHJlcG9ydA0KPiB0aGUgdHlwZSBvZiB0aGUgc3RyaXBwZWQgdGFn
ICg4MDIuMWFkIHZzIDgwMi4xUSkgc28gdGhlIG90aGVyIHBhdGNoZXMgYXJlIG5lZWRlZA0KPiB0
byBkaXNhYmxlIHRoZSBkb3VibGUgVkxBTiBzdHJpcHBpbmcuDQo+IA0KPiBUaGFua3MsDQo+IE92
aWRpdQ0KPiANCj4+PiBUaGFua3MgOikNCj4+Pg0KPj4+IE1heGltZQ0KPiANCkhpIE1heGltZSwg
T3ZpZGl1DQoNCkkgdGVzdGVkIHBhdGNoIDUgYWxvbmUgb24gQWdpbGV4NSA6KQ0KDQpTZXR1cCAo
YmFjay10by1iYWNrKToNCg0KaXAgbGluayBhZGQgbGluayBldGgwIG5hbWUgZXRoMC4xMDAgdHlw
ZSB2bGFuIHByb3RvIDgwMi4xYWQgaWQgMTAwDQppcCBsaW5rIGFkZCBsaW5rIGV0aDAuMTAwIG5h
bWUgZXRoMC4xMDAuMjAwIHR5cGUgdmxhbiBwcm90byA4MDIuMXEgaWQgMjAwDQojIERVVDE6IDE3
Mi4xNi4zLjEvMjQgb24gZXRoMC4xMDAuMjAwDQojIERVVDI6IDE3Mi4xNi4zLjIvMjQgb24gZXRo
MC4xMDAuMjAwDQpSZXN1bHRzOg0KDQpldGh0b29sIC1LIGV0aDAgcngtdmxhbi1vZmZsb2FkIG9m
ZiDihpIgUWluUSBwaW5nIFBBU1MNCmV0aHRvb2wgLUsgZXRoMCByeC12bGFuLW9mZmxvYWQgb24g
4oaSIFFpblEgcGluZyBGQUlMICgxMDAlIGxvc3MpDQpldGh0b29sIC1rIGV0aDAgc2hvd3Mgcngt
dmxhbi1vZmZsb2FkOiBvbiBhbmQgcngtdmxhbi1zdGFnLWh3LXBhcnNlOiBvbi4NCg0KU28gdGhl
IHNvZnR3YXJlIFZMQU4gcGF0aCBpcyBmaW5lLCBidXQgd2l0aCBIVyBSWCBWTEFOIHN0cmlwcGlu
ZyANCmVuYWJsZWQsIHBhdGNoIDUgYWxvbmUgZG9lcyBub3QgZml4IFFpblEgb24gdGhpcyBYR01B
Qy4gSSB3aWxsIGJlIGhhcHB5IA0KdG8gY29sbGVjdCBtb3JlIGRhdGEgKHRjcGR1bXAgLyBSREVT
MyBFVC1MVCkgb3IgdHJ5IGFkZGl0aW9uYWwgcGF0Y2hlcyANCmZyb20gdGhlIHNlcmllcyBpZiB5
b3UgaGF2ZSBhIHByZWZlcnJlZCBuZXh0IHN0ZXAuDQoNCkJSLA0KTmF6aW0NCg==
