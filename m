Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011071.outbound.protection.outlook.com [52.101.125.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8B1EDA32;
	Mon,  3 Aug 2026 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744475; cv=fail; b=Or6/aJV0EIrOw+RqPobJCGaKH6Oo2ZFvrfNEWHl98aUkTMa9YmwcuPszb/1XuJOmLMu6VU/SpMOs1aXrBrVQwaNxkVrweBmKxN0/mIXhm0fLo+0TSMUkAqIjbSf3ZjhZ/McWxBeDzokUk/7dwW/oIKU4kAgS1q3XeYTu2rUYr28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744475; c=relaxed/simple;
	bh=jlT5gNbUPZOfSeUZPzxyo8C7FJ6Mn8r3tNX39j9GDO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GopVejbWZ0recAgrz0gIsfcXtWsAUlbEXxYZVRMhOumR/Jwcd9oKRHsfoe9Z6wQ+FgufUYK/nfsJlYyQq0XQGzOC2jZIG51Um10TVH1iZERskQ23E/HAYApFrm7olMOH0grMZCWh1IZr6FbHkpypUWIbhBYdzdaBHErfissgktE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JDvkvd6R; arc=fail smtp.client-ip=52.101.125.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JDvkvd6R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/SWvSTkqwQRqPQ2OUbBEGuBR1aRiy/cDxtPu6to89+rw61uYhWtktqgB9Ll+WdTIYczrcTM1/C6+bRJKIX0K1h2PCe2XPZ9CzqWy9OiFK/JtooYUAi/X02AYcs5ssr3sjSyS8i9rLko0lh55Waw/mwFbTDiJ6OrU/nbAifbHfUtbXASw+EPtJVwW5rXzB2RIKbeeQP+kBKrF70oYIO7adHbIn84slAAj44b/cOY7RtGOnBAjdKeIKhyGUVjrfD88u8d1DUfnoxWlsCP2nfmSMKSRQMFZecM0x9GKVZbrM/BhCYkk8cG/KZD8gLPZlXHljTv3OmZvJ8Eog4gVNQMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlT5gNbUPZOfSeUZPzxyo8C7FJ6Mn8r3tNX39j9GDO0=;
 b=SZCQKWVYCyC7ApsDmNMOCRIsFdfAyWOSTg5mQxHSEDEsaT25HEqjxtVwUPRJWgBAHAKGLCq0WBQR+xGGmawiw7BLz+saVslIrFYXA9sfFFaUNj5opaJuX6hi0mcMj8d2sP5/wAyCdyvLJ7ivUIFUkxsvrDXl1PymLOrETPWlWGEryEJ12iGUGvxuteu2PuuSneQmTwiuTYEvP4QunjZbF1IsGzLDaMIAfedU+A6QChOFMyf+Edf0V6qitneLoQxb3E+MeokSl7BkcTCdbsSoKtSA/RP4VHANdkM8km83Rh2csER08QhKuvs83L0YEYED78eQo5meegupWqDTjKqEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlT5gNbUPZOfSeUZPzxyo8C7FJ6Mn8r3tNX39j9GDO0=;
 b=JDvkvd6RN8gk8C+ssUMlKgb4e2UikYfUydQ2ZRZz2SkthlxKq+QV5HQhq8EI/0oLUmogSdrTm6gfbflJh7CWOEDwMtvOsKbWaGnYDbu5/P7qvNi56aITMM7bhqckR8kmEpcP7yz4y2luc6JLo/NinSVLk2jqeYMGYtYOiCi4WQk=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TY4PR01MB17015.jpnprd01.prod.outlook.com (2603:1096:405:33a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 08:07:49 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 08:07:42 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>, Maxime Chevallier
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
Subject: RE: RE: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Topic: RE: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Index: AQHdHz/RntRPJl+oQEefyqoj3xFOEraEXkgAgAGragCAAA0XIIABuX6AgAQshOA=
Date: Mon, 3 Aug 2026 08:07:42 +0000
Message-ID:
 <OSCPR01MB12769D7E8D9D4FC3C24BE627DD3D52@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <af97a4a2-9a1d-4b36-9055-d05124bf4ab9@bootlin.com>
 <d5013c57-258d-44d2-a98d-2b1cbe541380@altera.com>
 <OSCPR01MB127691D8052A6BBBBDC10C0BDD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
 <5954dadd-f1d9-4b38-a3a4-7c17530a5256@altera.com>
In-Reply-To: <5954dadd-f1d9-4b38-a3a4-7c17530a5256@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TY4PR01MB17015:EE_
x-ms-office365-filtering-correlation-id: 06d5ca93-230d-4c4b-2ed6-08def1364b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|4143699003|11063799006|3023799007|38070700021|6133799003|10067099003|56012099006|921020;
x-microsoft-antispam-message-info:
 iI0BzGB9uRg4FwKlGZx6JD3AWlFtbQ7zDjA9Qkn8qYJ47Tlue1EoZZyxZ8kwJhBbZrFb2LcT1G8ANlv7Pw+SghLCOsgjzPRLxK4+7me+Crw+GUsVUDno+oxN9JMOfl5tQA5kzGk3uvKPegde+vbvo2Ng4/uQWxDbPOLVi5khkJl2fd9sb6GPC+/RA3LaUIbGPYc+k6PQb+Kpf3OlEjru3olgU3ZK4kgUmi9Bdo5hJGePeK5AwS0s8350Knyy4+fX3HNzluGkZ8HSmLrS2icDapRl/e35JfCio4X5UbACKdZ69YPICt6XVhGYp7My11qW6B0MPMxo6gqKgj6ZLkdn3GTlYLoHIuzV/opo+AL6qCpqHuB76XtNPHeCH8SH4MtT4CKpK5t+xO5Pfp++DFfWmpUIB8OWCZC4BRffoDDZnEyLJq3tfsNWNpUpvh8a4VV453lwBKSNtMY365SDSA8ku52x8YrgpZ9szg0VqCKA0HNuPat7xkvlQoH++jLOSdJiWwkpQVbKyYOhEty3z/r1am2VGpoPqJzif10KT33SJj2KmP3x+EQSPAtkW6Dlv8UAD9RcKkF5z+l2k1uL/SfBagj542NTuQJ1GUKhD9pmslcVsxMSMmGcvoirFAEKlmV0viSLVLOSRmIjnKp6o3EdBcX1Qff7IVxqCCQg2K2TCdYrmxWFdN9Vv1rEaHaWmv5txtQQW3xHwFn4T1XA3o35au2qS5MPmkVAuDNDvkwEw8Sxyf29p3ZJbW/Iq4bhX1Fo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007)(38070700021)(6133799003)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjkyK3Z3Q3NBZDg4QUt0c21lOEFySkFxQS9IL0t0Nnc4MUtkUkJhNmYwcldP?=
 =?utf-8?B?cEkxbTJJMTR5c1hNSmRiS2phT1ZnMWNNekZFT3hxeENlcXE3MHJpUEVVSC9m?=
 =?utf-8?B?QmdMS2ovSzVhM2k3eFNBMStTalRDcXd1bWViZXkxWkh2TmJqN3A1UU43YThT?=
 =?utf-8?B?U0ZXek5ydVFOdEpMdkxYMGpTS2pENlZJMGt2b3A1cEJ5dkkzck5wV01POFhP?=
 =?utf-8?B?aGJVT2RUWGdIVitxVm82VlZEcW0wUlNNdS9JMFJmWkZua0N0NUp1dHZVdG42?=
 =?utf-8?B?c1RyQVNHNDMxWXdOdUV0bWswM05EcWRCMVFUd254Qk1pclMrRzlzbENzL1pu?=
 =?utf-8?B?VWtOVkpLbWRKcUtNa1pFbE1GRUltQ2RBSjZPcXo5WVdHdXRKbGNWZFA3THpU?=
 =?utf-8?B?SW11YXdIeUJmc0oxSHNJU0NKWStJM1FWeWZFZW10QWpaTzNqYXB0WEpPV3ph?=
 =?utf-8?B?U0ZYQ1QxWE9mbCtKNlh5cUlDajlOcUlRdUFmdy9penhTbzhpYWcwaDhuNm4y?=
 =?utf-8?B?Z3IzZGRZK2cxaldoOHVadEloTURXVk82czIrQk9CK0RhanBEV3FsdWQxaHhh?=
 =?utf-8?B?WDZGeFJZWVc0cm1lZk9JWVRKTXd1eWd5dnI5dU1sZ01XT3YrbE1VMVMxZmVQ?=
 =?utf-8?B?N252a1ZZYThJWU5uaUN1OXJDcWcvWEZCZmgzUmFuUUt6NEVMdlFLcjRPY3dC?=
 =?utf-8?B?bzBoT210UHliQ0xIaVV2a3UraUw3UVVNYWpISWVtbGgxWUpYalBVVkZkaU53?=
 =?utf-8?B?cXNwVkxJUG9QcTk0SERGRjNZWG5ualE5MHdnQklhb1Z4WXBuNDNFUUlBVEVo?=
 =?utf-8?B?RXdZcDlyWnRXYXAzREtwcFpRRmZwOWZqYjhKdTk0UmNOWFQ4ZWdKbStLZUtm?=
 =?utf-8?B?U0dhMitMK2lDeHRxNmVjVGxvMWNyQVJ4eHFLNjlqajg3aERiUFlDdlJLYmdt?=
 =?utf-8?B?R0t6R0RtdFBtaXNwYmxuUEowaFo1T0hwUk53aTcrUm1FcSs0TU9vZ01ybGk3?=
 =?utf-8?B?RnFsUGc3cVJTSGVSZUpXSittUm5jbFk5cHJQQWw1NHFQZjl2anVlUzI5TWFh?=
 =?utf-8?B?ekc5UFhvdFpjamllbCtmM3lOd0NMWDhhdWtaRk5qOFUvVUorZWQzUXJhU1k5?=
 =?utf-8?B?ME1TK2ZGcUlKdEJ2RWQ1SkMrQkZNNjdWdTU0NzlpMkhRNENKN3FMcGc5TzNx?=
 =?utf-8?B?cXRLcXNVd2g4cEM2eWJsZzlqU2kwR0Z1Mmo1aUJ6Zmk3L3BhSVpldzd2U2Q3?=
 =?utf-8?B?dzBVdEcxOWRhTXlCOFdOSnBYbFE2UmtYS2JzU2dXMEhWNlVCUG51K1VwbEpT?=
 =?utf-8?B?dlkxamN0a1NsUlJwaFNlM0psVytpd3BteXZuR1IvSytlcURvSncwQndFZVFa?=
 =?utf-8?B?RlRtUEU2dXBhOUlNcTR5c21FOGsxWlEyc0NrYkpqdmlxeXJ1MTViT3UzSTly?=
 =?utf-8?B?QVFKTFdFMk9jRFRhQjBjS0VkRkNYb2l0Ym1JVjEyc0RRWmZxZHVGdVk0eXI4?=
 =?utf-8?B?bGVKcnd6ZUVodWhzSTNBdktmY0VTTDBMVmgwT3dkbnd2eUZIa2JCSlMyY1Zw?=
 =?utf-8?B?UU1EcE9xRjVVNmpKRXBRK1VCL21uN2ZacjBmOWRLZjcvTlV0OTNvN1d6cG1S?=
 =?utf-8?B?UEVJUWEwT0JjQXhjQjlaRDlveHJ4SC81YWxFN0l3RGN0RllKcEJQdDZpdWJO?=
 =?utf-8?B?blZwRUVGREJzQ1FjZTlEZldoMG5tZXNBRG9MUThnVWNhdldNb3BHTjV6YStB?=
 =?utf-8?B?RCtCQ0g4U2ZHdTBDRkMyeWVqL3lZRERJZTlRb1VreWxRN2c5bTZ0cHlXanVP?=
 =?utf-8?B?QjEwYkx5SWdvZ3lkK0Y2d1hQUC9Dd29WWVc4Nlc5YkJjQ1E4bmxrbzNXVGlI?=
 =?utf-8?B?VlFTY2x0R1RKMHJnZXpUbXRtNGh3cVZ2WFF3TEtoRmlHRDJmTTRqYzBxUGdo?=
 =?utf-8?B?eUFvMko1dElYckJrOWoreHE0Qjd2L01SejRUeGt3QVZoN1I1QkhpRWpjd3pU?=
 =?utf-8?B?ZVRkcVFnWTRRM3pKdG5jcTRGZ0pYbWhQdHVMWWxOdVdTTUNodm5jaEdabWo0?=
 =?utf-8?B?RkdnYlBUeEpkS2RqendLVDBkVVp5cm95cCtiWjY3QWQ4UGV6VjhwTWJ0Zm12?=
 =?utf-8?B?b1NWams2LzJWOFFUTWpyU1hGOHRURzFEaVpEQUFzSy9Dck5CSnpGTlFULzgw?=
 =?utf-8?B?c25rYzZrL0xCcnBrb2IxVitJMW1renNPYk1ZY2lVNmlFWWhSVXUwK0FvK2FO?=
 =?utf-8?B?cUlRdlA2cGs2R2grbkJLa0hhek4yTnZ0VTFMcEZOcnpBTm9hcVVPR3R5YXRH?=
 =?utf-8?B?YW1wZ2dFdU1IaXBWSE5YeldsajhWcEJXWXFtVTRoc0VSMXV1U3M2Y3F0TzRy?=
 =?utf-8?Q?1OOAMMvxEgjM2KE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12769.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d5ca93-230d-4c4b-2ed6-08def1364b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 08:07:42.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwUeUT2yxZ2cs0p81cqbzYrUNe0lsz6mQrjGtmErxQxe1zhT0OePWmHzBp0QGZkiP95sC6CbyjcjrDq5k7Dc+im+ydGjmAWlGpFh2BhsIR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17015

SGkgTmF6aW0sDQoNCj4gDQo+IE9uIDMwLzcvMjAyNiA5OjU3IHBtLCBPdmlkaXUgUGFuYWl0IHdy
b3RlOg0KPiA+IEhpIE5hemltIEFtaXJ1bCwNCj4gPg0KPiA+PiBPbiAyOS83LzIwMjYgNzozNSBw
bSwgTWF4aW1lIENoZXZhbGxpZXIgd3JvdGU6DQo+ID4+PiArIE5hemltIEFtaXJ1bA0KPiA+Pj4N
Cj4gPj4+IE9uIDcvMjkvMjYgMTE6NTEsIE92aWRpdSBQYW5haXQgd3JvdGU6DQo+ID4+Pj4gQ3Vy
cmVudGx5LCBoYXJkd2FyZSBWTEFOIHN0cmlwcGluZyBpcyBicm9rZW4gZm9yIDgwMi4xYWQgdGFn
cy4NCj4gPj4gdmxhbl9yeF9odygpDQo+ID4+Pj4gaGFyZGNvZGVzIEVUSF9QXzgwMjFRIHdoZW4g
cHV0dGluZyB0aGUgaGFyZHdhcmUgdGFnIGludG8gdGhlIHNrYiwNCj4gPj4gcmF0aGVyDQo+ID4+
Pj4gdGhhbiB1c2luZyB0aGUgYWN0dWFsIHByb3RvY29sIGZyb20gdGhlIHBhY2tldC4gQmVjYXVz
ZSBvZiB0aGlzLA0KPiA+PiBwYWNrZXRzDQo+ID4+Pj4gdGhhdCBjb250YWluIGFuIDgwMi4xYWQg
b3V0ZXIgdGFnIGFyZSBpbmNvcnJlY3RseSBwYXNzZWQgdXAgdGhlIHN0YWNrDQo+ID4+IGFzDQo+
ID4+Pj4gaGF2aW5nIGFuIDgwMi4xUSB0YWcuDQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGlzc3VlIHdh
cyBvYnNlcnZlZCBvbiB0aGUgUmVuZXNhcyBSWi9WMkggcGxhdGZvcm0gKHdoaWNoIGhhcyBhDQo+
ID4+IGR3bWFjNA0KPiA+Pj4+IElQKSwgd2hlbiB0ZXN0aW5nIFFpblEgcGluZzoNCj4gPj4+Pg0K
PiA+Pj4+ICAgICAjIERVVA0KPiA+Pj4+ICAgICBpcCBsaW5rIGFkZCBsaW5rIGVuZDAgbmFtZSBl
bmQwLjEwMCB0eXBlIHZsYW4gcHJvdG8gODAyLjFhZCBpZA0KPiAxMDANCj4gPj4+PiAgICAgaXAg
bGluayBhZGQgbGluayBlbmQwLjEwMCBuYW1lIGVuZDAuMTAwLjIwMCB0eXBlIHZsYW4gcHJvdG8N
Cj4gODAyLjFxDQo+ID4+IGlkIDIwMA0KPiA+Pj4+ICAgICBpcCBhZGRyIGFkZCAxNzIuMTYuMy4y
LzI0IGRldiBlbmQwLjEwMC4yMDANCj4gPj4+PiAgICAgaXAgbGluayBzZXQgZW5kMCB1cA0KPiA+
Pj4+ICAgICBpcCBsaW5rIHNldCBlbmQwLjEwMCB1cA0KPiA+Pj4+ICAgICBpcCBsaW5rIHNldCBl
bmQwLjEwMC4yMDAgdXANCj4gPj4+Pg0KPiA+Pj4+ICAgICAjIFBlZXINCj4gPj4+PiAgICAgaXAg
bGluayBhZGQgbGluayBldGgwIG5hbWUgZXRoMC4xMDAgdHlwZSB2bGFuIHByb3RvIDgwMi4xYWQg
aWQNCj4gMTAwDQo+ID4+Pj4gICAgIGlwIGxpbmsgYWRkIGxpbmsgZXRoMC4xMDAgbmFtZSBldGgw
LjEwMC4yMDAgdHlwZSB2bGFuIHByb3RvDQo+IDgwMi4xcQ0KPiA+PiBpZCAyMDANCj4gPj4+PiAg
ICAgaXAgYWRkciBhZGQgMTcyLjE2LjMuMS8yNCBkZXYgZXRoMC4xMDAuMjAwDQo+ID4+Pj4gICAg
IGlwIGxpbmsgc2V0IGV0aDAgdXANCj4gPj4+PiAgICAgaXAgbGluayBzZXQgZXRoMC4xMDAgdXAN
Cj4gPj4+PiAgICAgaXAgbGluayBzZXQgZXRoMC4xMDAuMjAwIHVwDQo+ID4+Pj4gICAgIHBpbmcg
MTcyLjE2LjMuMg0KPiA+Pj4+ICAgICAgIC0tIEZBSUwgLS0NCj4gPj4+Pg0KPiA+Pj4+IFRoaXMg
c2VyaWVzIGFkZHJlc3NlcyB0aGUgaXNzdWUgZm9yIGJvdGggZHdtYWM0IGFuZCBkd3hnbWFjMjoN
Cj4gPj4+PiAtIGR3bWFjNDogc2luY2UgZHdtYWM0IGRvZXMgbm90IGV4cG9zZSB0aGUgdGFnIHR5
cGUgaW4gdGhlIFJERVMzDQo+ID4+Pj4gICAgIGRlc2NyaXB0b3IsIGl0IGNhbm5vdCBzdXBwb3J0
IGhhcmR3YXJlIGRvdWJsZSBWTEFOIHN0cmlwcGluZw0KPiA+PiBjb3JyZWN0bHkuDQo+ID4+Pj4g
ICAgIFRoaXMgc2VyaWVzIGRpc2FibGVzIGRvdWJsZSBWTEFOIHN0cmlwcGluZyBmb3IgaXQsIHNv
IHRoZSA4MDIuMWFkDQo+ID4+IHRhZ3MNCj4gPj4+PiAgICAgYXJlIGxlZnQgaW4gcGxhY2UgYW5k
IGFyZSBoYW5kbGVkIGJ5IHRoZSBzb2Z0d2FyZSBWTEFOIHBhdGguDQo+ID4+Pj4NCj4gPj4+PiAt
IGR3eGdtYWMyOiB0aGUgUkRFUzMgZGVzY3JpcHRvciBkb2VzIHJlcG9ydCB0aGUgdHlwZSwgc28g
dGhlIGNvZGUNCj4gd2FzDQo+ID4+Pj4gICAgIHVwZGF0ZWQgdG8gcmVhZCBpdCBpbnN0ZWFkIG9m
IGhhcmRjb2RpbmcgRVRIX1BfODAyMVEuDQo+ID4+Pj4NCj4gPj4+PiBOb3RlOiBwYXRjaCA1LzUg
d2FzIGNvbXBpbGUgdGVzdGVkIG9ubHksIGFzIEkgZG8gbm90IGhhdmUgdGhlDQo+IGhhcmR3YXJl
Lg0KPiA+Pj4+IEhvd2V2ZXIsIGl0IHVzZXMgdGhlIHNhbWUgY29kZXBhdGggYXMgZHdtYWM0LCBz
byBpdCBoYXMgdGhlIHNhbWUNCj4gaXNzdWUuDQo+ID4+PiBOYXppbSBBbWlydWwsIGFzIHlvdSBz
ZWVtIHRvIGhhdmUgYWNjZXNzIHRvIHNvbWUgQWdpbGVYNSB3aXRoIFhHTUFDLA0KPiBjYW4NCj4g
Pj4geW91DQo+ID4+PiBzZWUgaWYgeW91IGNhbiByZXByb2R1Y2UgdGhlIGlzc3VlIG9uIHlvdXIg
c2lkZSBhbmQgaWYgdGhpcyBzZXJpZXMNCj4gPj4gc29sdmVzIGl0ID8NCj4gPj4NCj4gPj4gSGkg
TWF4aW1lLA0KPiA+Pg0KPiA+PiBUZXN0ZWQgb24gbXkgZW5kIGFuZCBzZWVpbmcgdGhlIHNhbWUg
ZmFpbHVyZSBhcyBhYm92ZSB3aXRob3V0IHRoaXMNCj4gPj4gc2VyaWVzLCBpcyB0aGlzIHBhdGNo
IDUgaXMgdGhlIG9ubHkgcGF0Y2ggbmVlZGVkIHRvIGZpeCB0aGUgcHJvYmxlbT8NCj4gPg0KPiA+
IEZvciBkd3hnbWFjMiB5ZXMsIHBhdGNoIDUgaXMgdGhlIG9ubHkgb25lIHRoYXQgaXMgbmVlZGVk
LiBEd21hYzQgZG9lc24ndA0KPiByZXBvcnQNCj4gPiB0aGUgdHlwZSBvZiB0aGUgc3RyaXBwZWQg
dGFnICg4MDIuMWFkIHZzIDgwMi4xUSkgc28gdGhlIG90aGVyIHBhdGNoZXMNCj4gYXJlIG5lZWRl
ZA0KPiA+IHRvIGRpc2FibGUgdGhlIGRvdWJsZSBWTEFOIHN0cmlwcGluZy4NCj4gPg0KPiA+IFRo
YW5rcywNCj4gPiBPdmlkaXUNCj4gPg0KPiA+Pj4gVGhhbmtzIDopDQo+ID4+Pg0KPiA+Pj4gTWF4
aW1lDQo+ID4NCj4gSGkgTWF4aW1lLCBPdmlkaXUNCj4gDQo+IEkgdGVzdGVkIHBhdGNoIDUgYWxv
bmUgb24gQWdpbGV4NSA6KQ0KPiANCj4gU2V0dXAgKGJhY2stdG8tYmFjayk6DQo+IA0KPiBpcCBs
aW5rIGFkZCBsaW5rIGV0aDAgbmFtZSBldGgwLjEwMCB0eXBlIHZsYW4gcHJvdG8gODAyLjFhZCBp
ZCAxMDANCj4gaXAgbGluayBhZGQgbGluayBldGgwLjEwMCBuYW1lIGV0aDAuMTAwLjIwMCB0eXBl
IHZsYW4gcHJvdG8gODAyLjFxIGlkIDIwMA0KPiAjIERVVDE6IDE3Mi4xNi4zLjEvMjQgb24gZXRo
MC4xMDAuMjAwDQo+ICMgRFVUMjogMTcyLjE2LjMuMi8yNCBvbiBldGgwLjEwMC4yMDANCj4gUmVz
dWx0czoNCj4gDQo+IGV0aHRvb2wgLUsgZXRoMCByeC12bGFuLW9mZmxvYWQgb2ZmIOKGkiBRaW5R
IHBpbmcgUEFTUw0KPiBldGh0b29sIC1LIGV0aDAgcngtdmxhbi1vZmZsb2FkIG9uIOKGkiBRaW5R
IHBpbmcgRkFJTCAoMTAwJSBsb3NzKQ0KPiBldGh0b29sIC1rIGV0aDAgc2hvd3Mgcngtdmxhbi1v
ZmZsb2FkOiBvbiBhbmQgcngtdmxhbi1zdGFnLWh3LXBhcnNlOiBvbi4NCj4gDQo+IFNvIHRoZSBz
b2Z0d2FyZSBWTEFOIHBhdGggaXMgZmluZSwgYnV0IHdpdGggSFcgUlggVkxBTiBzdHJpcHBpbmcN
Cj4gZW5hYmxlZCwgcGF0Y2ggNSBhbG9uZSBkb2VzIG5vdCBmaXggUWluUSBvbiB0aGlzIFhHTUFD
Lg0KDQpDb3VsZCB5b3UgcGxlYXNlIGFsc28gdGVzdCBpZiBzaW5nbGUgVkxBTiB3b3JrcyB3aXRo
IGh3IHN0cmlwcGluZyBlbmFibGVkLA0KYmVmb3JlL2FmdGVyIGFwcGx5aW5nIHBhdGNoIDU/DQoN
Cj4gSSB3aWxsIGJlIGhhcHB5IHRvIGNvbGxlY3QgbW9yZSBkYXRhICh0Y3BkdW1wIC8gUkRFUzMg
RVQtTFQpIG9yIHRyeQ0KPiBhZGRpdGlvbmFsIHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVzIGlmIHlv
dSBoYXZlIGEgcHJlZmVycmVkIG5leHQgc3RlcC4NCj4NCg0KWWVzLCBhIHRjcGR1bXAgbG9nIGFu
ZCBkdW1waW5nIFJERVMzIEVULUxUIGZyb20gd2l0aGluDQpkd3hnbWFjMl93cmJhY2tfZ2V0X3J4
X3ZsYW5fdHlwZSgpIGNvdWxkIGFsc28gaGVscCB3aXRoIGRlYnVnZ2luZyB0aGlzLg0KDQoNClRo
YW5rcywNCk92aWRpdQ0KDQo+IEJSLA0KPiBOYXppbQ0K
