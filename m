Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFF33D509;
	Thu, 30 Jul 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416759; cv=fail; b=H9BUcfY4GuBGhtpWXNiBXOauH+vn1fptvf86MqeItpt7SUTxdgjLVYpsZ1JeC6ZImdO2bF/91SEAccK1I/9Q0d2E9Rndran7Y+Dp40phW/DkMmeH/hIoSVBkkfmrBUh0wyJvWX5gfy25Rboaru4FppWBx6telIDmeqqhhQiyu6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416759; c=relaxed/simple;
	bh=qvm9Ve8OhbwD8LO2g/HwO/96fqHhuqi2+mgAfhcaQp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DKRdybNMEGgWCZkv+bKn8/jrriaLsNZb/pZaJ2kf36HIbMvLGZqw4yqwBBjOQDsSNvVe/PyyNiEtSnsxlDZhaQ1tmpZ0T4tGeCG4TRx9HpbG7OF61SuqhdIEGGXNqD3fsdvskplLd06B7yB7yE6hnYZ3S56SZdE2NYzWVKkW/yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=J3Ay+tic; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="J3Ay+tic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzFllubN6Cnuf93sEE79wS75C/6jRqt4ixaxfzzX+AiWnGEykQodgT7V/n5HPJcMACs6YHcaLczGb2qqD7drlKXAn3gK+quisb2rggc0WAW5qlnpr7UchQAxgxuPVlMvJRTr+XW7MUqx70aZMLcLKAAOqRr4+V+g3Ajy7CE+TdAg9PrsuyYJXU95J0oqrZQSosRbm0iFCgyQrGz0JLlwUzW2eoFeS2ttpt6RtAlcIxC1M24dD8DzFen1FWLfoZgu09/NEy4XTd/9Su86HbTRcJEZuhSs5P8th3kZuVDw0FfM+FVry+w5DVL+D7LvjSU8vwifvcXm+AHdnudlDkoWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvm9Ve8OhbwD8LO2g/HwO/96fqHhuqi2+mgAfhcaQp0=;
 b=UtacwzJ3ueSjy3H1Q+nGGKkit5IqM3hhqkixkGDsE9/dZFtP9YM0iaZf/yaYDY8hrlvv6eHoI/LBoRjUm1qPxSPhggItxTrRFUl8dXqn7ih/KyVWod8OVqGcCol/Kk7MQUlZQBz8940biv7x+ds2Y3R7y6sH/+JxbXJ6GD7cUrw+/S3/UX5I0mhak83G5Y4/1kBqaJPvPRiKsinlmtAnFmJsjHrwvGwi0n34UlF+9qechKgWDrgIKexRyptuF82vlpAGUgHLhuPi+SUO/t5tIkiWswDHNTKsHfKc/p6oY0oROKKRcUJMUoTeC1yQ6ZhOqad2ks76umDpViqVZnx9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvm9Ve8OhbwD8LO2g/HwO/96fqHhuqi2+mgAfhcaQp0=;
 b=J3Ay+ticRTqbVAddEXOZb848D/aBrjap4o70sV/opM3uYFr0aSTAY73RKrRwX/NTOfz6bqh3+47hdLi82LYhVZWSV+TU2CRNAFncao9tTdY7wVL+uZMnWUazSG+Ikf5PJLhSnDNJaG0OqYkEfwLs0GgPnyLsx4pIilun9c1+IxIZ6hkUY2VTrYPLLuNZQT8QtH56NIRNq+eATFv8c0HgTbDa0G9BfBoROejAbF4UXvrPHO7jNM/T3k2fFiW5QwLjFtHLOb0UbwexLHahxm3YEXstpzsKwEBrV7uj8IS1nIwa8qg3T6B/llxEdQZXKVcnX392I8etYGGVV1cqr7z3jA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV9PR03MB8365.namprd03.prod.outlook.com (2603:10b6:408:368::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 13:05:30 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:05:30 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Ovidiu Panait
	<ovidiu.panait.rb@renesas.com>, "andrew+netdev@lunn.ch"
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
Subject: Re: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
Thread-Topic: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Index: AQHdH05wmmgu7tuEFEmpHlpVOh/nAbaGCZOA
Date: Thu, 30 Jul 2026 13:05:30 +0000
Message-ID: <d5013c57-258d-44d2-a98d-2b1cbe541380@altera.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <af97a4a2-9a1d-4b36-9055-d05124bf4ab9@bootlin.com>
In-Reply-To: <af97a4a2-9a1d-4b36-9055-d05124bf4ab9@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|LV9PR03MB8365:EE_
x-ms-office365-filtering-correlation-id: 394bce0a-9c28-41f9-8e1f-08deee3b3ba9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003|55112099003|921020|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 qwZ/qn8dH27vA4Fs9UQ5TnBaXjWfZtxMTsHCLuA/3hhISse9u8bMOKUpFM1ydIXWgwPIhAls1VjUFk9RccQvZoucKrDmHFsM7eljpIC2rCuzS8bNDUX3TYxQxx01MhOWeu5d+tqI6XxrHoxGJ+w253PR7qgnEHMDcdpCjzX7To3453UV6G0rk58j8aUGs3W1bGsiqUdQrlV1KGLV1biv+MSRkGcMKmKFlGbOQqwyfKXUDBxrTUeujsfr43lnu+eJtvI6ud6ASlIjisAQqVu3kRqvGtfvtZ7GR7g8YK5gD0vjm1gPqsqdyeoY4i2UAPMIsw6/G5l2i/vGdJz5fQNrVfQaM2jzL+jsLhbSgmzH0+mPpD5He0ScZ1hO+kXK6V/aaHT6u/zAywJl61At4CVqzughWLKqPnlygOKhnBnpgFq9L+VWORzzsJ2E9DLWmuPk36MlXP3Lx94AliqMbLSZShCa60BGYdrva0Pga1j81efposkYFeEghXjFy3ttpfXQvvqpr/uG+r/oF/vx24uvGedN4c5WSdv2sK6NPg8JP0QSRhGz/LdArMUh/GYMYmZrlIOsPB56FkiLUzOLKNHsHXLAes/vCvRToQInLC9AxcKWRuBtpJvfE3cqyu5n3Vi8sqKRDgd1SRe4qkRt2dxgYuvLwbegEv3u+9NZxM227bAb8EwegbxosRBzBkmlftP7MKHWUUonJ1d2QOAT4Czw4FY68epCUlCF7X09UEp//9xIp/PgxWRy1kUKxye4qWT5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(55112099003)(921020)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDQ0VUdObWlqRXdFSGNBME5PdkFiczVLbVU1b0ZiejFTMEJXNkM2ZjlmMHUw?=
 =?utf-8?B?dnNCK0VENE1YM2JlSEk1b1VPRFpQVlFDTjFuTWo4dE5mbWVNUzMxcXF2SWJP?=
 =?utf-8?B?NDdtaHpyc3lVeXlNYlJQNll0dEFrQ2lLeEZXa0hDdnVVR2N6U1ZidUJSU2xx?=
 =?utf-8?B?WUZoRWsxK2pQbkRJMUlOczdDajl4TnhFMEh0WlVrbUU4VzFla29NV283Y01w?=
 =?utf-8?B?Vk01Q3NieGkxK3RtNko0U3Z3alprUjJRMWs5dUJ5ZGYyeksybk42UFY5TTE1?=
 =?utf-8?B?TTZKZHM1cGZSZjFqdFRCeVhHSkJldk1BL2w1M1ZRRHNMbkMrTSs1OXNFUzdx?=
 =?utf-8?B?dkF6RjUwcnR2ZnBYZCtjYnZkTm1XWWUwVjRLZ1I3VTIxMGxJR1JMaWFlZERC?=
 =?utf-8?B?OXVnVGpSeWlscnZoeFJMT3gwYURONk9JYlZycllEMUVublhWaEJvZ0ZZd3Iy?=
 =?utf-8?B?QzNpdWNPL1BnMnRQTXNnc0Z4QjVoa3lmKzNhTE80NHF4RlBTSlAyVThOd2Jr?=
 =?utf-8?B?UjNZWUdoZnBSUGJrelJ1LzM5WThHQXFBR0lWLytWVStCcTNPOTBlditGSWFG?=
 =?utf-8?B?TFdEOERCNWJoNllMMnM1cXNzeGFVRng3TThkekRFa1dxazg3RHZHVXNKSzZr?=
 =?utf-8?B?bEFMR01HNktJSWpxSFliTHFlZjVLUDRkUjBBWC9pOGNRNXdNd1JXMGY3dUFD?=
 =?utf-8?B?NFhpYXVoV2FsYlRsZms4cFBoOUVBKzNQQlpzNi9Yc1lIQUI2aUJIOCtzNEpG?=
 =?utf-8?B?VHYzQlFRb3ZKWkZyTDlhR3JNajAzTThqenNDbFNMQWVGQUVOQTVzZlo4R2JK?=
 =?utf-8?B?aHg2U3dacDdtTzlBUDQwYzQ4QUVhVmpzemp5eEtZSjlKUll0Mk1XcDBQUjRj?=
 =?utf-8?B?aEd5VVp0c2NvN1MzdHUzV0luMVJYSEdKL0o4V2d3aW9mUDMvZEtRM3kvUVRK?=
 =?utf-8?B?V1NLalZHRk5zQ3BGbm03bU4yeElVeXlCcGJmK2NNSGhmQ3F2ZW5YVXpvQXo4?=
 =?utf-8?B?WUhHWS94TlZpSjREVDRMT2xxd0tLalduVmd4aXY3dzVMcFdtYnFzc0U4b3Jm?=
 =?utf-8?B?cm9WeUZ5ZkpydGVxZFgwTk83VzdWblpQUFhKS0l4cW5rWHZGNzQ5c3Jtcmxs?=
 =?utf-8?B?bjloY0lyWDZHS0k1OFVJU2gxSUpueCtKbWFpbjIxYXZ0OEJyUnp5T0RvR3lv?=
 =?utf-8?B?Z1hUSVI4aHFLb1VyWXNHQTBST242cHFHeitWOXluSVRHK0ZWM1JKMjBCTnhR?=
 =?utf-8?B?dmxJNXhEWTlvVG8wQ2J0aFVCTlNHOEswZWN2a0o4REg3b2FoZEpEb1JJRVJV?=
 =?utf-8?B?bTVFTTcrd3BhMkZzL0JaanBSK28vaDFDVDJCRHRFK0VGRUFGc09zbEFNWGVr?=
 =?utf-8?B?TVY2ODAxZTRORm9weFNLYXF1TUdkbFY5c05MdTdlUTFtNkNQdndsNGlTS1Fs?=
 =?utf-8?B?UStpQldOTzJWSUQyVlM1ZllXMjhVSi82a2lGSWNrVC96T0ZMSGs1L1l6NzdP?=
 =?utf-8?B?enRFV012ZEFtcm5xdEM2STRPcFpCTnk2Q29aaTZ3bGxSK0R1NWlvMjNJVjZm?=
 =?utf-8?B?R3NSOW9JMlpzT0JPY2xoSTdTYXl2MnUzeFZGY3luUUQ5RTYrRVFnZlFjNW5t?=
 =?utf-8?B?WlBYcHZnSlpZMFFNVTMxdXo0bU9jOEcwL1VmYWppc1EvWkEzZDJLaUFnZ1p1?=
 =?utf-8?B?TVNnWVhibmg0R09ZWVFlVTBIc2NOajBXWHNpM01md1QvcUlNNnRrQUpRNTVQ?=
 =?utf-8?B?SlgxdGh6UjlJT2lVek9Qa2VWSE9YUndsKzZ1N0lPd20vRE1HanYySXFYZ0NE?=
 =?utf-8?B?NUp3VUtSUGd6Nm13MnVDNDBiUVRSNG4rTmwwOHpEMFYydkVFdk9CV3d2Wm8z?=
 =?utf-8?B?RnVWQkxqcXI1NEQ4TVRraU84OHpzTXNSUDJ6dG1UWFQrNnVWdFZiVllLaEhJ?=
 =?utf-8?B?UXFOZlBMUy9Ud2JwWFpicHFLc3A0UFEySXlYWHNNRXRSODNDQlZmZDloTU9X?=
 =?utf-8?B?OXlLZ3hqSGprVUF2T3lPNk5tOVN4blkzWE9hQk9WWnc0UnBTWmFJTWlDWlJM?=
 =?utf-8?B?c0dZS0dGdnNYV0dEWFFwaW5jbkoxZHVvTlB3cUdyRTgwek5HSXE1WjZPOFZu?=
 =?utf-8?B?VWhRM0RVYWExMGZRbXFoMEM5SmNVaDR5SkozR25heno1MlhLcWl5d3NXd3Ji?=
 =?utf-8?B?cVp5MXp2MFZic0p5QUpNTHk3UEZhclVMOGFmOWV5ZkhzSkR1Q2dYaXRoMDlV?=
 =?utf-8?B?bWFyUFlmenRuVFVyVkdPcG4zVm1KWFA3aDJOTGJsYm5iYUUrVW5lNnhpYU9O?=
 =?utf-8?B?dndPZVl2bnZKcmNFeEJvTjlxMStRM0VwSHNBZjdEVTBsVC84SWlwQ014ZkVn?=
 =?utf-8?Q?LDIumG/8m3IfzznS6kwhffixgunJ1kdBSyGjG6RgUwcG2?=
x-ms-exchange-antispam-messagedata-1: 0IkSLGjQdD8u8A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <698B3AFE53781741AA5317EB9891B14C@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 394bce0a-9c28-41f9-8e1f-08deee3b3ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 13:05:30.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tu4p2f4HMkUJUdgbVXTPBS7ZQHL5MPap5hScbG77rubfjUWmhRfoLSKNA3eKl/n2cP5Ej7TkKWciZrgOuRulntnG5NYxAOWCMo/OD6ccCjIscVqhBXVcmqXePaZRW2+If4rMZ07KSzaIacxxoS+nLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8365

T24gMjkvNy8yMDI2IDc6MzUgcG0sIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOg0KPiArIE5hemlt
IEFtaXJ1bA0KPiANCj4gT24gNy8yOS8yNiAxMTo1MSwgT3ZpZGl1IFBhbmFpdCB3cm90ZToNCj4+
IEN1cnJlbnRseSwgaGFyZHdhcmUgVkxBTiBzdHJpcHBpbmcgaXMgYnJva2VuIGZvciA4MDIuMWFk
IHRhZ3MuIHZsYW5fcnhfaHcoKQ0KPj4gaGFyZGNvZGVzIEVUSF9QXzgwMjFRIHdoZW4gcHV0dGlu
ZyB0aGUgaGFyZHdhcmUgdGFnIGludG8gdGhlIHNrYiwgcmF0aGVyDQo+PiB0aGFuIHVzaW5nIHRo
ZSBhY3R1YWwgcHJvdG9jb2wgZnJvbSB0aGUgcGFja2V0LiBCZWNhdXNlIG9mIHRoaXMsIHBhY2tl
dHMNCj4+IHRoYXQgY29udGFpbiBhbiA4MDIuMWFkIG91dGVyIHRhZyBhcmUgaW5jb3JyZWN0bHkg
cGFzc2VkIHVwIHRoZSBzdGFjayBhcw0KPj4gaGF2aW5nIGFuIDgwMi4xUSB0YWcuDQo+Pg0KPj4g
VGhpcyBpc3N1ZSB3YXMgb2JzZXJ2ZWQgb24gdGhlIFJlbmVzYXMgUlovVjJIIHBsYXRmb3JtICh3
aGljaCBoYXMgYSBkd21hYzQNCj4+IElQKSwgd2hlbiB0ZXN0aW5nIFFpblEgcGluZzoNCj4+DQo+
PiAgICAjIERVVA0KPj4gICAgaXAgbGluayBhZGQgbGluayBlbmQwIG5hbWUgZW5kMC4xMDAgdHlw
ZSB2bGFuIHByb3RvIDgwMi4xYWQgaWQgMTAwDQo+PiAgICBpcCBsaW5rIGFkZCBsaW5rIGVuZDAu
MTAwIG5hbWUgZW5kMC4xMDAuMjAwIHR5cGUgdmxhbiBwcm90byA4MDIuMXEgaWQgMjAwDQo+PiAg
ICBpcCBhZGRyIGFkZCAxNzIuMTYuMy4yLzI0IGRldiBlbmQwLjEwMC4yMDANCj4+ICAgIGlwIGxp
bmsgc2V0IGVuZDAgdXANCj4+ICAgIGlwIGxpbmsgc2V0IGVuZDAuMTAwIHVwDQo+PiAgICBpcCBs
aW5rIHNldCBlbmQwLjEwMC4yMDAgdXANCj4+DQo+PiAgICAjIFBlZXINCj4+ICAgIGlwIGxpbmsg
YWRkIGxpbmsgZXRoMCBuYW1lIGV0aDAuMTAwIHR5cGUgdmxhbiBwcm90byA4MDIuMWFkIGlkIDEw
MA0KPj4gICAgaXAgbGluayBhZGQgbGluayBldGgwLjEwMCBuYW1lIGV0aDAuMTAwLjIwMCB0eXBl
IHZsYW4gcHJvdG8gODAyLjFxIGlkIDIwMA0KPj4gICAgaXAgYWRkciBhZGQgMTcyLjE2LjMuMS8y
NCBkZXYgZXRoMC4xMDAuMjAwDQo+PiAgICBpcCBsaW5rIHNldCBldGgwIHVwDQo+PiAgICBpcCBs
aW5rIHNldCBldGgwLjEwMCB1cA0KPj4gICAgaXAgbGluayBzZXQgZXRoMC4xMDAuMjAwIHVwDQo+
PiAgICBwaW5nIDE3Mi4xNi4zLjINCj4+ICAgICAgLS0gRkFJTCAtLQ0KPj4NCj4+IFRoaXMgc2Vy
aWVzIGFkZHJlc3NlcyB0aGUgaXNzdWUgZm9yIGJvdGggZHdtYWM0IGFuZCBkd3hnbWFjMjoNCj4+
IC0gZHdtYWM0OiBzaW5jZSBkd21hYzQgZG9lcyBub3QgZXhwb3NlIHRoZSB0YWcgdHlwZSBpbiB0
aGUgUkRFUzMNCj4+ICAgIGRlc2NyaXB0b3IsIGl0IGNhbm5vdCBzdXBwb3J0IGhhcmR3YXJlIGRv
dWJsZSBWTEFOIHN0cmlwcGluZyBjb3JyZWN0bHkuDQo+PiAgICBUaGlzIHNlcmllcyBkaXNhYmxl
cyBkb3VibGUgVkxBTiBzdHJpcHBpbmcgZm9yIGl0LCBzbyB0aGUgODAyLjFhZCB0YWdzDQo+PiAg
ICBhcmUgbGVmdCBpbiBwbGFjZSBhbmQgYXJlIGhhbmRsZWQgYnkgdGhlIHNvZnR3YXJlIFZMQU4g
cGF0aC4NCj4+DQo+PiAtIGR3eGdtYWMyOiB0aGUgUkRFUzMgZGVzY3JpcHRvciBkb2VzIHJlcG9y
dCB0aGUgdHlwZSwgc28gdGhlIGNvZGUgd2FzDQo+PiAgICB1cGRhdGVkIHRvIHJlYWQgaXQgaW5z
dGVhZCBvZiBoYXJkY29kaW5nIEVUSF9QXzgwMjFRLg0KPj4NCj4+IE5vdGU6IHBhdGNoIDUvNSB3
YXMgY29tcGlsZSB0ZXN0ZWQgb25seSwgYXMgSSBkbyBub3QgaGF2ZSB0aGUgaGFyZHdhcmUuDQo+
PiBIb3dldmVyLCBpdCB1c2VzIHRoZSBzYW1lIGNvZGVwYXRoIGFzIGR3bWFjNCwgc28gaXQgaGFz
IHRoZSBzYW1lIGlzc3VlLg0KPiBOYXppbSBBbWlydWwsIGFzIHlvdSBzZWVtIHRvIGhhdmUgYWNj
ZXNzIHRvIHNvbWUgQWdpbGVYNSB3aXRoIFhHTUFDLCBjYW4geW91DQo+IHNlZSBpZiB5b3UgY2Fu
IHJlcHJvZHVjZSB0aGUgaXNzdWUgb24geW91ciBzaWRlIGFuZCBpZiB0aGlzIHNlcmllcyBzb2x2
ZXMgaXQgPw0KDQpIaSBNYXhpbWUsDQoNClRlc3RlZCBvbiBteSBlbmQgYW5kIHNlZWluZyB0aGUg
c2FtZSBmYWlsdXJlIGFzIGFib3ZlIHdpdGhvdXQgdGhpcyANCnNlcmllcywgaXMgdGhpcyBwYXRj
aCA1IGlzIHRoZSBvbmx5IHBhdGNoIG5lZWRlZCB0byBmaXggdGhlIHByb2JsZW0/Pg0KPiBUaGFu
a3MgOikNCj4gDQo+IE1heGltZQ0KDQo=
