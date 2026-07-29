Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF26279903
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289937; cv=fail; b=SoUcF4aTp2IjBJsZbOCqIgU+4R9LbA86PIKXl0t+DzV3wAOYui47a5h9LwQaTNVHaEkgk8rHjrcYlUGKZM+5+x3bg2W3obszM+zlhpLTJFoOtL1xnYCezdCngfww/Vuk1DxaRSpITnG5T7meZlW6MQF5UwY8eZAhVxTdZ+ZHu8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289937; c=relaxed/simple;
	bh=X0+mjITgGxpL4kCzWJRSj4HQChLYCTBghwZevtEv2ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGkDf3HFdmdHku76ayp9lXUFuMR/nckkm/EWTXI0lq++a9NVN9u8bwPyLFFQg1+L90KPpw/NdRqAe8XOpagGBf5mLC86m13i7LAxknuJJT3YXqXNQfDOBqYkaJK22M9u2bLFqx2Nq70FGsOevXkpZkSrEKynoWkFXas4YeyGr28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Tz4TwiHZ; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tz4TwiHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlSwxbLU0jPAb18zASklRyVcsr3kKI45+Kj8e8PjgC3lLOdNQIgMgy/0iVDOTxGKr8kLTW8AzE/CeOqVBoTiwhn98c9+8TnFPfQT0uc+COb7nFSzjDdMAd5Ww9YL2hFkKwShcNn3lLBPZm+Kjdt3I7ptYBCxsjI+TSbRq2uf9Jngl9V7uxippIzHu/FZiuYAGbdprHWqsNDXD8lQtkmLh12LV0lzDv3zEP+h1PRGZ/z9+E3Exe0KxN8p7GkiWOJ4vIz+1zEOdNzroxv5EUtYUzvpygl3SyvKSgAXA4bUajIi+bZGAhxSu+SXKoL9DsBUgXEZiOutESQ5bIOfP8ZVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0+mjITgGxpL4kCzWJRSj4HQChLYCTBghwZevtEv2ZQ=;
 b=o0FWW0bOoXyHRMgMx0NuKeA36Ni/fp8yvaaL+DD8XdBXdiOS0Qv1V0LjKhcdxnso6d0DO4TN2yPAVtPc51DzR7j38P8CxOyUOOG5SmS1PXwjKtSzgMPDxuoBD3p1S5b8Zbu0ZWDZPBnX7bGXO26I8j4kWhR1LY99ecSN01zzEHIUQl5BX1U6Eh0vUZU4IOBlWPqKl3cbtvDOWqfacU9E1IKjtiOE0dcIDT8h/BCXy7NzRYe9EcRIQXU2T72u4A4h5m4+4D7l2R9VR0/K4Bmu/+tHMTur95ZE65kXD3xk7wWpx7dMUtkLIX1+QjbNZTFYC2Ae+bohfLNRNlnq4cadcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0+mjITgGxpL4kCzWJRSj4HQChLYCTBghwZevtEv2ZQ=;
 b=Tz4TwiHZbjD/GbVDyjiCIsgm8rAZWU7kCSGvOdv4YTjOUnB61m71O0fiebVnKluKM/DpyACftfJ7o/7h2G2hF4cla2lkuXeLu2pxsfJS3aJVJBGxMj0uZTE8WuObavE3mKwzOJvLEbxhrq98vy+E+gWdZj8LV7cp6ZBLwf6jYzP/X9ODJ1ewp9HcssFwOvTx2/oXI2mF+94bes7O9xsUUbaasxli6W/iTqK4o4y+2V9XWlzRufKZwT7A9k68Ta1/lZxUTSaxWmaeo+LxoqKq0uFNHSskkTKvGT7gh6l4u3LXeyEBGKESSUIJDMP+CrW7tJRouMZH4pOyOCwvcSiyZg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS4PR04MB9484.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 01:52:09 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 01:52:09 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net] ptp: netc: fix potential interrupt storm caused by
 incorrect unbind order
Thread-Topic: [PATCH v2 net] ptp: netc: fix potential interrupt storm caused
 by incorrect unbind order
Thread-Index: AQHdHY1El7J2/1x2Q0izOfzN6pnyV7aCcciAgAFM1CA=
Date: Wed, 29 Jul 2026 01:52:09 +0000
Message-ID:
 <GV2PR04MB11739570509F92DE861FCABE988CA2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260727060348.1887464-1-wei.fang@oss.nxp.com>
 <20260728060051.B45491F000E9@smtp.kernel.org>
In-Reply-To: <20260728060051.B45491F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS4PR04MB9484:EE_
x-ms-office365-filtering-correlation-id: c74d48fd-fd7f-430e-b229-08deed140039
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|4143699003|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 89dyJvnHjXybNY1w+QYHUF661WZ6veBQ/sSRbcD5QPvI4f7Qui3M1rOQr683SqRRUMnCOWtM9+PnI05IYcnS5RODZIN6AeI5ZmfiKbPDpKY0hDS5hfOzwwih7xA9svuHQoTjvxnpu1nXMLJUtXiK30aYsxKCOwB8jvIF1GcZ+Yg0/LwM0l4tGV7xaZ7KM8WTmQKV/FDNeWl5pHlsVKvN5aJrx2jQXuo+K9vzDymFVlosAn3YC8QmBoIyEvjNP02k5ieKUFnCrFxjLv4IepxqC+nSZbIOEKwOyjYYHJ7UGdkW3hh7lzoxPy7ONE93m6IBvNWMIlCLJ7fKeh/nE1fm1DxhuAsvXpM6dOJWqZkDkltA/6E2xAui7fVGFH1hXEq1wSEFg8ptlYb2XRMhvBcASNMkmPxgqhDEnIq1Z/uIplThYGYKwNIExQTGHi+kGJJOdC1CHkJd5W7KLoFOr+6bmV7XZKbSpLuns8fKIOprFJs/1lIxqfSzQ5vvnN/q1H6DfAZmYII5gGqJM9v3ic5Ach6t/CusBdfQVvWJPEtURUkNPGiVMbGQkXMUnfOfCbsGJ9qJ9qlijfxSQd47dxM3Ub9n+Yjc0VNVWWhzzCbSFwkxohpY/DLWkSefV8goOZo6T8QLEI/9lSxl38URwH8nZr7c58OnPbKO0cYJMbwTbokzSImmF8U+MERJl5cvM/iY0dWQI8MR9dU1/E1ViI7UC0wX5l794YS1AweBW5nD524=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUdpUUVHOTIyQ1I2Vy9QSlhublBhZk0zQkx6VVpITDFiQ201a050cjRhajlJ?=
 =?utf-8?B?bzZDMWVFN3lWUUVhOHhUdFg2bHZabWVyd1AyNTFkbmxHWEUwY204Ynl6VmQ5?=
 =?utf-8?B?Z1pPamE3Nm1tRkxDa1RPWldzeWtZOVNNL1JtWngyaGQ3cm1OSUJHUXFYYUFU?=
 =?utf-8?B?TDRXTEhROUNUYWdYOG56aGFUZ0hHeXVxbXlFL0E3UDBjYSthOWhXeTMvZStt?=
 =?utf-8?B?a05kVXlMUFl6RGhLSnQxcHpDWElWNG9QMjcrZWpLanJKb00rRlRKVjBoWGJz?=
 =?utf-8?B?U1owRUpSU0hxZHpNWWt2eDJWdVRYVTFaekhlMVVOU0FpZUN0bkI0ZDRuNkJI?=
 =?utf-8?B?Qzh5SXFOZ3lpd01CYTZtZS9EZFVxMy83NG5EQjFwUnBUY3hNWk85SWhQOW4x?=
 =?utf-8?B?aDBoTE0vMFRXR3ZXSnpmeUMwaE00K3hPMFpRMFBQZ0tEK1FpSnJPYWx4bzFz?=
 =?utf-8?B?YUhZVmpOU01SSFd0QUNjdDZRYWVONlpOMmlFNGNPUVZ2RDlEK25hTHZBUjNi?=
 =?utf-8?B?aXBiOFlXNWhuQnRjdXZBUVhGVTA5MHF1dksvdGF2UGQzRm9SSHlUQTQwaFVB?=
 =?utf-8?B?a0lwZlZWZlBmM1BDaFg1R0RBbkNLd3BFMU9OZ203Qit0Tlk0b0ZSa01rZVE0?=
 =?utf-8?B?eGtZYlE2QmpvbDVPU2tia2oyNXUyUmlEenZwdTd0Rm8zN09NT3NlR0JnTnRT?=
 =?utf-8?B?TkYvS0xFVVFydXg2V0ZGZE91VE1LWGlqOVN6NjVSVXYvemw3ZStCZllYT2R2?=
 =?utf-8?B?eHhDV3VTYWVpZitkUHB2Q2g4SlBqSkRBWFJZVFJaVHQ3bE1nTjMzanVBTFpQ?=
 =?utf-8?B?LzRYRnFNQ204eUxIKyttN3RmYWZoZUs4aWZzYktTelJ2K2NjRHJjNDdmZklY?=
 =?utf-8?B?dmV5ZVBaK3pGcVdHMGJZbEMwSTZGaUtkdk9QdjY3dkdFRU9NUEtia3lubHpN?=
 =?utf-8?B?aEsrZ3pnWVNRb0UzempKdXdnaVJTYTgySWRwRHJRYVNCWnVGNGNXVmU1bHgy?=
 =?utf-8?B?TGVteU9saDYvT2lvY21RTzBmVXdKbDBqOVFnN1h5Y1JoRzROa0cvRXhBMmkr?=
 =?utf-8?B?WUpzRzltaC9xMk4zNWx2VHp4UUJVb0VxcVRhTTRHQzdpTEpHZTZycER2NHRS?=
 =?utf-8?B?NWVsUXVmWDNadmhnZHM1dnI5eGExbW0vNHQ0bEkwdXhXMnVzZG02eTV0aitQ?=
 =?utf-8?B?Z2tIcHFTRUw3R3VYYjIzSnZyVXFjLzIxaVhwNUl2WXN3YUZjZ01CQUZYMjRJ?=
 =?utf-8?B?a3hkVzh0ckljalRzbEdhNCtYanpRSmJaUnBjcHh1TS9Dbysxd0hlL2JqMjRm?=
 =?utf-8?B?R2J5UFEyNWJOQm8xZkN0aE5FWHhvZEFGQmUrQXVYdXZDRHAyN0IxZG1KVU84?=
 =?utf-8?B?bllrMUZJQnFYMTlCQU1pUXNJTGE1K3p3TS9mUVNKZ2dUMXplYkxDR25aMkdC?=
 =?utf-8?B?dzFNY3VEdDdYYncvaFJ2YjQzKy91c05qZExtMGhndmdIOTMvaUpnQmZ2RWlk?=
 =?utf-8?B?TkhPVkhUUFMvZ3NsWDdRU2pReXAvdS9TN0dxeGVvTDNxSXliQVE4ZmtXRytF?=
 =?utf-8?B?azA2M2VmSUJ6aUd0Sms1ODRoVTZ2T2ZndGdpNEhpbS9jcU9iT3ZxU2Vxc2I0?=
 =?utf-8?B?OTcwd0YwVUpCQWlVT1M2UFBMRkJkTDFBeHFaQzFmakoweGFIbE45Q1ZzVTBZ?=
 =?utf-8?B?U3g4UFp2R2dtWjFzRnU2OFNjOURDckIwKzdVS082K2hOL1JzSExtWk1tejdk?=
 =?utf-8?B?MFRjOHl4N1RiUVNQc1pDTjl1UVpsNjZJYmd1ZVFzaWMvRlFzc2pWMmRxNEJv?=
 =?utf-8?B?cmx0b1J3b1l3aVJhdTBmUTNqVU5IbWp2ZUtLTlF3MHkzajFPbFlUcy9LYVBY?=
 =?utf-8?B?ZjlqU0V3SWlMMURrZzhWN3hVY3A1OWJZSDVTK3YySVJDcnpaT0VlbTZYWUVz?=
 =?utf-8?B?azU3aEpWaHZGeEwxTDBHR2FnVVZDcVg3TlpHOCtrd09jMDh5NDVvS0RDK2RK?=
 =?utf-8?B?UWZZS0ZJWHNjVzhLd2Q1c0VmdExPQnZQYW1veEpmTDdCM284V29SeHZ0TkIv?=
 =?utf-8?B?SFo1RDhwRWY1TjJBMm8wWUNaWFdXRVZwd3plVGFOajA4TXRDRnNQTjIrZTN3?=
 =?utf-8?B?aTRnNVZyZ2M1VFo5VnRTcUVUYWR0UmtiQjc0bmF5YnhlODA3OWlBNWY2UGdJ?=
 =?utf-8?B?QVRVWjc5NDdJbmg0dUM5cCs1dlVGMG9aWGZGMlpVQnZXaHhXT0hOVWFuUkVx?=
 =?utf-8?B?bVUvU3pKZkhsR005czZIdTBqZkhDRWJ2YUxJM0dMekRkN3Fkc01QTHlkeit3?=
 =?utf-8?Q?A0n1GGtSsxN7PawbBs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d48fd-fd7f-430e-b229-08deed140039
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 01:52:09.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+KXP/0pPR8AEfgpPIq3h0WKuWuq6z2KNI/x6orRjU/liyvMbsOswls1lAQe9uIG2FYdfHx5CCzOkEdy8x8xCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9484

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B0cC9wdHBfbmV0Yy5jIGIvZHJpdmVycy9wdHAvcHRw
X25ldGMuYw0KPiA+IC0tLSBhL2RyaXZlcnMvcHRwL3B0cF9uZXRjLmMNCj4gPiArKysgYi9kcml2
ZXJzL3B0cC9wdHBfbmV0Yy5jDQo+ID4gQEAgLTc2OSw2ICs3NjksNyBAQCBzdGF0aWMgdm9pZCBu
ZXRjX3RpbWVyX2luaXQoc3RydWN0IG5ldGNfdGltZXIgKnByaXYpDQo+ID4gIAkJICAgVE1SX0NU
UkxfVEUgfCBUTVJfQ1RSTF9GUzsNCj4gPiAgCW5ldGNfdGltZXJfd3IocHJpdiwgTkVUQ19UTVJf
Q1RSTCwgdG1yX2N0cmwpOw0KPiA+ICAJbmV0Y190aW1lcl93cihwcml2LCBORVRDX1RNUl9QUlND
LCBwcml2LT5vY2xrX3Byc2MpOw0KPiA+ICsJbmV0Y190aW1lcl93cihwcml2LCBORVRDX1RNUl9U
RU1BU0ssIDApOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0
aW5nIGlzc3VlLCBidXQgZG9lcyB0aGlzIGluaXRpYWxpemF0aW9uIGFsc28gbmVlZCB0byBjbGVh
cg0KPiB0aGUgZXZlbnQgcmVnaXN0ZXIgKE5FVENfVE1SX1RFVkVOVCk/DQo+IA0KPiBJZiB0aGUg
aGFyZHdhcmUgaG9sZHMgcGVuZGluZyBldmVudHMgZnJvbSBhIHByZXZpb3VzIHVuYmluZCBvciBh
biB1bmNsZWFuDQo+IHNodXRkb3duLCBjbGVhcmluZyB0aGUgbWFzayBoZXJlIHdvbid0IGNsZWFy
IHRoZSBwZW5kaW5nIGJpdHMgdGhlbXNlbHZlcywNCj4gbGVhdmluZyBzdGFsZSBpbnRlcnJ1cHQg
c3RhdHVzIGluIHRoZSBoYXJkd2FyZS4NCj4gDQoNClRoaXMgaXMgYSBmYWxzZSBwb3NpdGl2ZSwg
VE1SX1RFTUFTSyBwcm92aWRlcyBjb250cm9sIG92ZXIgd2hpY2ggcG9zc2libGUNCmludGVycnVw
dCBldmVudHMgaW4gVE1SX1RFVkVOVCBhcmUgcGVybWl0dGVkIHRvIHBhcnRpY2lwYXRlIGluIGdl
bmVyYXRpbmcNCmhhcmR3YXJlIGludGVycnVwdHMgdG8gdGhlIGludGVycnVwdCBjb250cm9sbGVy
LCBzbyBubyBuZWVkIHRvIGNsZWFyIHRoZSBiaXRzDQphcmUgc2V0IGluIFRNUl9URVZFTlQgYnV0
IG5vdCBpbiBUTVJfVEVNQVNLLiBBbmQgdGhlIGRyaXZlciBpbml0aWFsaXplcw0KVE1SX1RFTUFT
SyB0byAwIGJlZm9yZSBjYWxsaW5nIGVuYWJsZV9pcnEoKS4NCg0KPiBbIC4uLiBdDQo+IA0KPiA+
IEBAIC05MDEsNiArOTAyLDExIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBuZXRjX3RpbWVyX2lzcihp
bnQgaXJxLCB2b2lkICpkYXRhKQ0KPiA+ICAJLyogQ2xlYXIgaW50ZXJydXB0cyBzdGF0dXMgKi8N
Cj4gPiAgCW5ldGNfdGltZXJfd3IocHJpdiwgTkVUQ19UTVJfVEVWRU5ULCB0bXJfZXZlbnQpOw0K
PiA+DQo+ID4gKwlpZiAoIXRtcl9ldmVudCkgew0KPiA+ICsJCXNwaW5fdW5sb2NrKCZwcml2LT5s
b2NrKTsNCj4gPiArCQlyZXR1cm4gSVJRX05PTkU7DQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gW1Nl
dmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgZG9lcyB3
cml0aW5nIGJhY2sgdGhlIG1hc2tlZCB0bXJfZXZlbnQNCj4gZmFpbCB0byBjbGVhciBwZW5kaW5n
IGJ1dCBtYXNrZWQgaGFyZHdhcmUgZXZlbnRzPw0KPiANCj4gTG9va2luZyBlYXJsaWVyIGluIG5l
dGNfdGltZXJfaXNyKCksIHRtcl9ldmVudCBpcyBtYXNrZWQgYmVmb3JlIGJlaW5nIHdyaXR0ZW4N
Cj4gYmFjayB0byB0aGUgcmVnaXN0ZXI6DQo+IA0KPiAgICAgdG1yX2V2ZW50ID0gbmV0Y190aW1l
cl9yZChwcml2LCBORVRDX1RNUl9URVZFTlQpOw0KPiAgICAgdG1yX2V2ZW50ICY9IHByaXYtPnRt
cl9lbWFzazsNCj4gICAgIC8qIENsZWFyIGludGVycnVwdHMgc3RhdHVzICovDQo+ICAgICBuZXRj
X3RpbWVyX3dyKHByaXYsIE5FVENfVE1SX1RFVkVOVCwgdG1yX2V2ZW50KTsNCj4gDQo+IElmIE5F
VENfVE1SX1RFVkVOVCBpcyBhIFdyaXRlLTEtdG8tQ2xlYXIgcmVnaXN0ZXIsIHdyaXRpbmcgYmFj
ayAwIGZvcg0KPiBhbnkgbWFza2VkIGV2ZW50cyBtZWFucyB0aGV5IGFyZSBuZXZlciBjbGVhcmVk
Lg0KPiANCj4gSWYgcHJpdi0+dG1yX2VtYXNrIGlzIDAsIHRoZSBJU1Igd2lsbCB3cml0ZSAwIHRv
IE5FVENfVE1SX1RFVkVOVCBhbmQgdGhlbg0KPiByZXR1cm4gSVJRX05PTkUgd2l0aG91dCBjbGVh
cmluZyB0aGUgYWN0dWFsIGhhcmR3YXJlIHN0YXRlLiBDb3VsZCB0aGlzDQo+IGNhdXNlIHRoZSB1
bmFja25vd2xlZGdlZCBoYXJkd2FyZSBpbnRlcnJ1cHQgdG8gcmUtdHJpZ2dlciBpbmRlZmluaXRl
bHksDQo+IGZvcmNpbmcgdGhlIGtlcm5lbCdzIHNwdXJpb3VzIGludGVycnVwdCBkZXRlY3RvciB0
byBwZXJtYW5lbnRseSBkaXNhYmxlIHRoZQ0KPiBJUlEgbGluZT8NCj4gDQoNClRoaXMgaXMgYSBm
YWxzZSBwb3NpdGl2ZSwgcHJpdi0+dG1yX2VtYXNrIGlzIGVxdWFsIHRvIHRoZSB2YWx1ZSBvZiBU
TVJfVEVNQVNLDQosIGlmIHRoZSBpbnRlcnJ1cHQgaXMgbm90IGVuYWJsZWQgaW4gVE1SX1RFTUFT
SywgdGhlIGhhcmR3YXJlIHdpbGwgbm90IGdlbmVyYXRlDQp0aGUgaW50ZXJydXB0IHdoZW4gdGhl
IGNvcnJlc3BvbmRpbmcgYml0IGlzIHNldCBpbiBUTVJfVEVWRU5ULg0KDQo=
