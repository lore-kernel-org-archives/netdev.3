Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E5453A28
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111874; cv=fail; b=b9LIO99yb1a+Z6fCNNsv6QMKtO7stJTN5MjXI8amSlsrLzro54XxrLRm4fMNMlXScY9wvCjd1vloJJAssfI2MfPH69ZViI3mzkCUaUMw9SxoWl3NfxUvpyq+Zbpi+T/vul4GvFqNz4/R6z5YwGAbfMBFa76ScQOAf2hrmnf5Hjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111874; c=relaxed/simple;
	bh=EMtO4Ffngg5Et7sGs7BU6+HzLtr2eeyR6xJ23ppTwLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N84HpCc6Jgv/oL72mONFdpAFFYs/rc0HzRtpcziLewGCIpE7tdaq+Y5BpvG9mufY1MWZUO9xBiMP1Fa1vpkywBuof53velWGSpt/QHDKEgFSpLjN/qFt8VV9FCZmMJPvdatWgxTEzlvb7gmkVsSHkIwxn3V5FRanHMilMGjOXSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=riUsJBoW; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="riUsJBoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZhbN+JBlPi28C4QPA/2UxTbORumCYIXGBqoX7a68uyMA5kHHyMb6S3THz6SIMw1zbk+7m8X0BayJUTOfJ7o/yk7PCgWYGrX/plA2f4AL05sZK2m8mv1J1sOW/6CjFnWIr7VjWP/H3rIqWlSjfMUJh8OHeF6QuW0uxORvQVZ9drI2bqRu99cMtrXVG3PELX+jv/LAue23YkMdNbC6WmNmabKrK9syJwukJhhFtWmd7UCMAkn9isFU/A2fVCqChIKCiFmpxxP53lIh3tBizi6KBqj9nTQl6DsgsoEkPpzgOakN0l5ivo4sEACmoyBrIN4uA1B1jk+7236/KpttRzdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMtO4Ffngg5Et7sGs7BU6+HzLtr2eeyR6xJ23ppTwLA=;
 b=qd5ZTeHicSZmsb97XkATd7KjO1TC1FMwC2EvjHVF8AnudDaN5JiH1q+N/9UEDBfSglcVZ41ML8FbRBfCaZex4BcuBDXgwllvFi9q04Kf8eNQ3Oxuv2F8Hoc5dHDjoy3DPW7gRUN3WIFc2ic/qCs/kyFnGX2XsFF9I8ea8dp5RJ6Xip+lXF5qttRi5dzoMEbH0aQXRN1X4R95opBHdAtN9cjG3kdXnei+QrWjf5LQG6kfhugGPVdap1DUKfyMUmK6HthAcqsS9QufHXlOVFnZAaNqw8/TerpfRMA68gyWRIXf0uLgPAGdCBMczg9TKykKSWsPdDOzWBfK/5Kx6rnS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMtO4Ffngg5Et7sGs7BU6+HzLtr2eeyR6xJ23ppTwLA=;
 b=riUsJBoWhcqyFrECKYweFTquPH99/mscrkx+xsZxoqqPObqRQmdGzmH2VGlSQh4SZaMG4oU7NiOdDS5z+Sp6RAMzBUptawyVXqn9BOLdkgnpYuuiLkQtlFi3AYmoeCEmP0H2Ur6ylu6FaLjqis8qrBmSIIsQdQaZNnyJ7/u2fIG5LR0QcJeCQQ+g3cBHI30S3bFqZ36wj6cMvgyuvLMZyAr4H56EPLLvFrCrrSsnOVhStH4qIDHPWkHdxjeiCKnU/l9xKUKy5r3b16HhJ7M77UhjIjYEdafJtzGxhll8/++vTox9L+Z2kL1soMRKtIALBJepxNl/F5ZVkiso0//Zhw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS8PR04MB9191.eurprd04.prod.outlook.com
 (2603:10a6:20b:44e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 07:31:06 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 07:31:06 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 12/15] net: enetc: add VF support for i.MX94
 and i.MX95
Thread-Topic: [PATCH v4 net-next 12/15] net: enetc: add VF support for i.MX94
 and i.MX95
Thread-Index: AQHdQEchbkqy/1IS102rWAwwbGnMoLbHoDIAgAFeNwA=
Date: Fri, 11 Sep 2026 07:31:06 +0000
Message-ID:
 <GV2PR04MB1173999712AF50D7ADFA9D4B988BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
 <20260909100733.1139689-13-wei.fang@oss.nxp.com>
 <20260910103728.6631A1F00898@smtp.kernel.org>
In-Reply-To: <20260910103728.6631A1F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS8PR04MB9191:EE_
x-ms-office365-filtering-correlation-id: 0207490c-51a9-4c95-201b-08df0fd6a461
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 oLa9bLuoa3KaCbH8ESay0ecurgRQz1BYu4oddiR/SUetz/s5yxWwmXw8WIAvBQQve/DLrszhXzbzxe6zEGXXb/HvJsiHkpo8qagGC83awp42DLYpI0Od6t7zrxd0xVkjiqwaHM1HtaHbhVSt7wcKU/AQgf7tFcqQCmgMEWlnlxDgTiUzbX49Z2IcT2f87j5ru6xb7pvQvQVQ+jHAn63l9qAm74snA9RpAYuhtfFiBZeGGH8u7ubiHoTgqbtFfEMkYDs7VmBHDgkMKffKKx/NFqM1P9KUumSCVFUvsu7z+exG8z95idyTT3aJ5+0f1j8qi5monMQ8TJ+NouHdUWFjRYMilcv4MfywuCe8jVaQY9otEBPZhuvNFgtWGa05WqakViFIyVHXXRABAHu+ofX7ilUEITISbRykRNQnPj7h3WrqMIcE5Vjg/eN/RniGK0Y73NNPASPzXL8nwSZ3w5taBnD9D9pysu/Vw5MzpNTqyWHIhGjwtghiReJgoCTV4clBv6T0kN6UG9940HvpLBQOPODGVHkTJTkrcNyrzbHyq43glSkBV1iArJYkzFR+GAoJRAp/mjJHkWHQfEGCHc6SpA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTBRWG5ibTRzaUpNbUV0cjQxbGowVnhXQmNUYk9GZTFiSkY4UWRQdWZRR242?=
 =?utf-8?B?WURUZ0crSGY2c2FEOXViWEcxa0dCOUZQeHVVWXlGRkZkUG1pVFY4MzlyMHdS?=
 =?utf-8?B?QTdZT3BpeEdYaTdMUTVuZ3RDc1VORGdiczVQOEF3ZmozMzdpWnE3TWZxOGtr?=
 =?utf-8?B?TC9walZWTlV2cWExVVowbU9RWE5xQUYxWStEbUR5WjdWeUhDbWxNUVdJOWZF?=
 =?utf-8?B?aEJRN3Eyc2FKOXd2eEZLZ0RBcjlxNkkwWElNM3VJMjUxb21KeDlyY2x1dXNj?=
 =?utf-8?B?TXhVZkdrZ1Fia1JuT2U4YVo5Y1pka1h5U0Q4QWJxQU52VVlQV1RYK3BPNDlo?=
 =?utf-8?B?RDBOSFNwVzZPNHdreUxCdG83ZXp4M0dvTHFFYXZXRng5cW5NOW9ISXhOL2hK?=
 =?utf-8?B?Y2Z6SUpEREVMaG5qV2hrSDI1QTJ1SzBlUXlTSERjZWdGR1BOZkJuc1l2RWh3?=
 =?utf-8?B?UXZsRVMyQndTa2twR01vR3k3bytsNy9vQnZKeHdRcE1NblZaVzlJREFJVm9Q?=
 =?utf-8?B?cG03SysrK3JGN2lGaFBLMG54dldKdG45OVAvRk9OSkxEK0dZVUZVOXZOa0xK?=
 =?utf-8?B?UDU1OEl5aGhheVdjZlQ0VUFRby9zenhweHhQbzNrNkNFejRHdzQ3OEg4N05D?=
 =?utf-8?B?UEdsS0UyUzI2TlBKNXp0SkdVaUdvSEhyYTA0N3Bld0JiUnE1azh0T05BOSs3?=
 =?utf-8?B?QW1MZGdIcHowR3c3NFgvaS92SWM4OWhubVVoRFpaQW5JR0RZdGxSeEt2UW04?=
 =?utf-8?B?R0E1TDRUeTQ5ZVBpQ21pOUVtRTJmYk1CWEJXcktDUlpsN3ZDbjVPU3YzeDZt?=
 =?utf-8?B?a0NGZk00WnY1WmlIekVNN3I1MVRRNkw2N1hRaThUOEFpVlRrTFpSOGFjMERw?=
 =?utf-8?B?MkRQMnFzWkJPMTA1SFV4UFo1aUF2SHBKZlhPSWQ4b3BId1cvQjZKTkxTaGlX?=
 =?utf-8?B?VXpMTnp0Yjk2ZU1SYktCWGUwd29GaWhMNFZyQU1YMEV0bUZ0Q0JPZjhhbzJC?=
 =?utf-8?B?ZVFxdmg1OTRSN2lqRXFucXAwMGRwcytkSEcvTDRaeEVtTktZRU1sVWZVNmF5?=
 =?utf-8?B?QW4zUUJGSjdBd1FERE1lUmUyQ3BvZXBET3JvME4xYlNVVFhsbmJuYkV2ZW9U?=
 =?utf-8?B?TENFQ2NpSVBrSmpuQ0ExQm1nMkVrWGZVdWVWOXZjcGxUZEVRQStTdVFpdjdX?=
 =?utf-8?B?M0ZhU00xazFIMjFvQ2Q5ZWJmdWdBdlJKQ3RsN0tzbHh0YkF2VW5wOG9JWDJ5?=
 =?utf-8?B?c1h2ZmJXc1JDd0t0cnl5ZSthTFlDTVJNUW42YmlQaGFOdEVSbEJDTS81c1da?=
 =?utf-8?B?ZjduTEFZUkZKQXVlaDdCTlhpOUFNcG5SbVdXS0dPcUEzS1dOMGdzZjRqT3JX?=
 =?utf-8?B?MEJiOGhZdjhYRDM3ekxLSDY2TWU0a0tGMVhhd1RITXlqRERiWThkWVNXYmdm?=
 =?utf-8?B?L0d3Tk1tbG5QUkVXMkE5Mk5GYXRqM0dZcFZyOTRtQ1ZwWnNyZnZJM1lTQmdJ?=
 =?utf-8?B?dW81SVE4K1NMWUVMcSsvVFpjNWp3bFpsaGJOckpUOE16cmJHNm8zVnExYmxl?=
 =?utf-8?B?TE9vSGd1WDlVWEVCVmsyR1BocExrOVhuQ0habkJUdEIrd21teThkL0swRDFw?=
 =?utf-8?B?a1F4cVg0Q01zcjZLeHNXWXNwWnBnNFA0eEIrcVZmZ1M2aUtLc1diTnNrei94?=
 =?utf-8?B?K1VESnEyMjBnM1F3YlF5TitEd1BXdnpKUGtONTRLQTk1MTMrSmxWM1VHL2Yv?=
 =?utf-8?B?ZE96b3V2aXZlTUcwMmdaSjY4YUZFYVZHWHoyWlJhNWJLVWNOdFdnUndtVVQz?=
 =?utf-8?B?TkZWb1BDaHRHUEtTZUM2U2syQ2ZNbkUxMkFnbkxlbTV4RWxzSDgxRkRWS2V0?=
 =?utf-8?B?bkFvczEzN2VkYjRpOUlxRzJRSlpQQXczb2tiNkRRaFZvQlE3QWtvZWZxTEdm?=
 =?utf-8?B?c25jUHUrUFdBMnhQQ0JVcmdYUDZkVHI1Zk1nQ21iM21yR2xmN3g4TzlNVHZj?=
 =?utf-8?B?UlpoVmpTY2xKVmdSNG5vZHp6R1BVTjdWTmhIMlRrYzd4cXJIdkM3QXFyMXBx?=
 =?utf-8?B?aFptVGRWckY3T1FUb09VbFJwampLQzZGc3ZnVlRXMEZPNTlHQ3k4UEJtL0ta?=
 =?utf-8?B?blIzOGJNSTE3bVA4OUc5WjZQdmxoNVV4MjRmb2NWNVFyTjNoTzAvY0QyVzhw?=
 =?utf-8?B?dkJhRVhxWjUwY3hKa3RzQWFuMGp2L0djYlBXSUhadXJySy9Pc1pxYUdRQTZr?=
 =?utf-8?B?ZzNFUVRXTk1iZUFoY3pWc0plMFppelhFaS8rUFg5Y2U4NkJBUnVBTGFDRzFU?=
 =?utf-8?Q?gc44B4VHaOLLL2fIjN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0207490c-51a9-4c95-201b-08df0fd6a461
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 07:31:06.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4NrlsKoQYNx/yMQ6eFc0DuEzfkgU48I6P94oDi1eqMtS7CdVSlZJLwfgLFe4vIxB3K5O7dN3BgvZevjMtNvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGVuZXRjX2RydmRhdGEgZW5ldGM0X3ZmX2RhdGEgPSB7
DQo+ID4gKwkuc3lzY2xrX2ZyZXEgPSBFTkVUQ19DTEtfMzMzTSwNCj4gPiArCS50eF9jc3VtID0g
dHJ1ZSwNCj4gPiArCS5tYXhfZnJhZ3MgPSBFTkVUQzRfTUFYX1NLQl9GUkFHUywNCj4gPiArCS5l
dGhfb3BzID0gJmVuZXRjX3ZmX2V0aHRvb2xfb3BzLA0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0K
PiBEb2VzIHJldXNpbmcgZW5ldGNfdmZfZXRodG9vbF9vcHMgZm9yIEVORVRDNCBWRnMgaW5hZHZl
cnRlbnRseSBleHBvc2UNCj4gZW5ldGNfZ2V0X3JlZ3MoKSBvbiBoYXJkd2FyZSB0aGF0IGRvZXNu
J3Qgc3VwcG9ydCBpdD8NCj4gDQo+IFdoZW4gYSB1c2VyIHJ1bnMgZXRodG9vbCAtZCBvbiB0aGUg
RU5FVEM0IFZGIGludGVyZmFjZSwgaXQgdHJpZ2dlcnMNCj4gZW5ldGNfZ2V0X3JlZ3MoKS4gVGhp
cyBmdW5jdGlvbiBpdGVyYXRlcyBvdmVyIGVuZXRjX3NpX3JlZ3MgYW5kIHJlYWRzDQo+IEVORVRD
MS1zcGVjaWZpYyBDb21tYW5kIEJ1ZmZlciBEZXNjcmlwdG9yIFJpbmcgKENCRFIpIHJlZ2lzdGVy
czoNCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19ldGh0
b29sLmM6ZW5ldGNfZ2V0X3JlZ3MoKSB7DQo+ICAgICAuLi4NCj4gICAgIGZvciAoaSA9IDA7IGkg
PCBBUlJBWV9TSVpFKGVuZXRjX3NpX3JlZ3MpOyBpKyspIHsNCj4gICAgICAgICAgICAgKmJ1Zisr
ID0gZW5ldGNfc2lfcmVnc1tpXTsNCj4gICAgICAgICAgICAgKmJ1ZisrID0gZW5ldGNfcmQoaHcs
IGVuZXRjX3NpX3JlZ3NbaV0pOw0KPiAgICAgfQ0KPiAgICAgLi4uDQo+IH0NCj4gDQo+IFNpbmNl
IEVORVRDNCB1c2VzIE5UTVAgaW5zdGVhZCBvZiBDQkRSLCB0aGVzZSBNTUlPIG9mZnNldHMgYXJl
IG5vdA0KPiBpbXBsZW1lbnRlZC4gRG9lcyByZWFkaW5nIHRoZW0gdHJpZ2dlciBhIHN5bmNocm9u
b3VzIGV4dGVybmFsIGFib3J0DQo+IChidXMgZXJyb3IpIGFuZCBjYXVzZSBhIGtlcm5lbCBwYW5p
YyBvbiBBUk0gYXJjaGl0ZWN0dXJlcz8NCj4gDQo+IFRoZSBQRiBkcml2ZXIgZGF0YSB1c2VzIGVu
ZXRjNF9wZl9ldGh0b29sX29wcyB3aGljaCBhdm9pZHMgdGhpcywgYnV0IHRoZSBWRg0KPiBkYXRh
IGhlcmUgcmV1c2VzIHRoZSBFTkVUQzEgb3BzLiBTaG91bGQgdGhlcmUgYmUgYSBkZWRpY2F0ZWQN
Cj4gZW5ldGM0X3ZmX2V0aHRvb2xfb3BzIHRoYXQgb21pdHMgZ2V0X3JlZ3M/DQoNClRoaXMgaXMg
YSBmYWxzZSBwb3NpdGl2ZSwgdGhlIHJlZ2lzdGVycyBvZiBFTkVUQyB2NCBWRiBpcyBjb21wYXRp
YmxlIHdpdGggdjEuDQoNCg==
