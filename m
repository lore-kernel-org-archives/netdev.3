Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DD38DC5C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245190; cv=fail; b=HSQa4oY5aeYzxxkwzldoVjfLdiNkKOg7GINyqgwwQnzWq529sXNCIDVOXD5JTlEa3xAt2OZblx7Rn31w8zE20oW9dtym3cyw3KAGxWYfSMfC8mE8dAmA2H7GkE+JLSeN1GDuPD/pqk4rd6vpmrtakdcvGdnRWWzohsnIBmr6c2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245190; c=relaxed/simple;
	bh=bNATLOdRiolvCYTVyKNGyCDNn3e+TVF/7rhhpjIbqhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVr5Ro9AMv4R+x6bCf5y1Jm7/5Huy4Gy2htXCyq7QRCfvkx0M7DeEzD7xYz9CTAvfgfxpUBge+SsLKTI16eJGlRVc69dn0QZuubrCncPEU38skxUdCibU7AyrApj7uBt87zAhUAlUYUoC16fC+VdJ1GSJ3eOUt2oR/eP3DMlV3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h6UNcxlP; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h6UNcxlP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOMZye4UXHgz0c9WhpmyFvdLZo2DGTERlwGUhRLWD0uJ37+Zv39uhbduZ87h6b9TN11eQHAm7+bsFLD6vbZwbwhKT3WAr+RQY2rd5wNVFWMiiQ3mGLjpZZ+pGB84+21cEGCt07NHM8vPYMIMkfgq8rahhmK2yrb9d6CZSYM6i/rgxj21O4pSC9n3EbdCGG11Fp2Y/Jl8p554A9R/g1t3+qFHe0KuKwtZ0XzVUYEMKNSsqlsBYKlMBjydT+2afGgtcOEVyYKKGYWHhs+blMKpkvZZhbI+qwCC6WEVAxPNtYwzAKqOM1qcfOAcrNyGUQkNuntnvlIL8PSFDctADXKDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNATLOdRiolvCYTVyKNGyCDNn3e+TVF/7rhhpjIbqhQ=;
 b=a3Kl+XJXLC6F7c16lHMIvofDj2czYGxbzrmv2hLteBw1MWI/YRxcSrpCndc6gxAo+N0/lNwG9w6H3yJwuU4ZP/UIjMRrfRFIQtQMJUTmUIF+7Y9+u8adIEcEpdMUzZOmKo8mj6HcNb2chqOMZXtPvUDzhRduea1AzFA06swttb560BUK7FLvL1fqLqK25E3FM4NJhynwssWjKsu8FjlVgyWH5Zor+F3rd9j2G6R/ifMNtpc3T5+t4cez724M67T5TH3ovIHrdEmRAKX0tmQ8BM5XgFS645E5AFnGkncmDv4BdBVPZ0/5G7Vgi9o4jWvRZP1Y9CyspfSjeI4fJ9Xztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNATLOdRiolvCYTVyKNGyCDNn3e+TVF/7rhhpjIbqhQ=;
 b=h6UNcxlPCVSz7TPINd/TReAs7ivJGk3c2vNQdNKxKP43U47owFhNswyFCu3tbpnB9Lh56UEEFY19AXe/7z2Blcu2w2scKqDO5KYrQHJIR+KwzfgnPrKBV3lUPghnr2uVKrUyKge+wXIIqsRtbiSa5x6fICpz/SGMaLlfuLH+UOT2GbQbFYRJ8k/+0Q1OF6X8+pPb/ZL/yiuKNEDE3Gxk1XRUAzvOq6yA5pe97enzGQMIeS6462pgVBBrZOJY5n7HWX+5QDhWzvYsCJLcYfPv9ikQLox4j9bPx96PJDuIykHPNnukGlCMItBlENC5ImsiYsHeO+1jmL0xZMaOhblKMw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VI0PR04MB11954.eurprd04.prod.outlook.com
 (2603:10a6:800:31f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:46:20 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:46:19 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Netdev <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHdOPf5rPAr6++Cq0ud6wQBTmAapLa5ELeAgAA4huA=
Date: Tue, 1 Sep 2026 06:46:19 +0000
Message-ID:
 <GV2PR04MB1173957C7D083D4293AB60DB588A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-4-wei.fang@oss.nxp.com>
 <20260901032359.788A11F00A3E@smtp.kernel.org>
In-Reply-To: <20260901032359.788A11F00A3E@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VI0PR04MB11954:EE_
x-ms-office365-filtering-correlation-id: c492c95c-3de2-47ab-0232-08df07f4badc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|38070700021|56012099006|10067099003|5023799004|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 SBzUwON2JmA1k5obDiUJxmBt/jKaqdD1HYvn2eGSgYtrxR87jDiypboD2JVfXwqa2zaKvvCvDQTVCDTT2N5XdKQSq99vfYk+opF4xgOQjhqYaNkq5PxcVEaVA1Yn6BMH6hc3RJgMd53koHmAsQgFaL00Lj/9VegMbuWatcppPf2MnVm1xVHX63p26DleAJFt0IqawJmbILI7E9sPqjIbyOPEzV/ce2hhW4/h6UwGFdd/F1CwTkAhvayLyZylnnW42BXJm8/c4Pexz98L+QIXthMaBE85Hfd0sDaMdyg/FJVBlcSbTy6mY0UzCDklSFuAvZiyTYwH5s82eIPmj02G/E7Z97H6FO4wmbD0bJtcP3UxyzKd87JOP4NGQCYNpiI4AWrrkk417jEO0lb83ay765Epii0oLiIItAXvO6x2jZS5sk1Qct5Ioqf6SezRAwySb+2a/p0O92Jw4zDveVvc+YvuST3rot4bQckufMUDS4CpAzrXU+hujvGu4l2Q2hzDmTU+ICeYhLXg+bFXfpbxSuOJYlYMVyhSsbS3JmYC/PbeuEp46+NdEFeFkh8YgcGwsR9hl88zqk2DK+4kTSwKCjVw8YkCDhyqRtej77IePHrpHAnAHI8iUkGZ6khuCAjOrdfxYZx2A+48CIfW/f/91worz2/TWgwW4oJOTl6/ggdojwxwc8WTCWE+fGrkFJVqjMwcbLw/JaYJOXlXykt78DGtmepEshMOU0yX6CSxEws=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(10067099003)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHZRL3YvZkNaclpURFAzUTNTbEc5aFZGWjJ6Nmo4YjgxWWpLclRseUppUDQ5?=
 =?utf-8?B?Q0RtcEdBdDVWV2NEU01zSUt6OHJvang0YTdWUHE0YjVoeXJUbSs4MTJpdFZE?=
 =?utf-8?B?ZGduaEtLeHlUR2xJalBPUWdRcGZPeVFtOGN5bWIySmVzVlk4ZUlXTTNIWXhs?=
 =?utf-8?B?MmVXdE9wSnJYbXh3S3hzbHVwM3l0NTZBMGRsOVl4Vk5TTm41bnhlOG1oa1ZB?=
 =?utf-8?B?Wjlrc09EbHRzeVdWZXVOcTNKQ0lPVWFsWDVvaVNFdWpHMWhkV0U4bHNHZDdp?=
 =?utf-8?B?TW9keUtyZXVTT2RxalNLVCtmek9PVXlqaFpsdkFXSisvVWc1VlQzMGpYUGU2?=
 =?utf-8?B?RFpzRlhCdlExZzFpV1RySmhRdlZGMHg5Y1NSWW9tVDJMcEVNU0NVRTdoeUNW?=
 =?utf-8?B?SkMwYmpEL2tKRis4R0w0V1NXb3NSK3NWOC9VZVVOMDVVWHQ2bjRVUG1iaEds?=
 =?utf-8?B?WVRTbFBQUlhaUVpIWEhhckt0S25NZnBBV0w2cDNoTU43K0ZXWXpqY2Q1YzZl?=
 =?utf-8?B?NVEyT2RLVEF0N0RUV3ZNT3UxRFpoVC9hQ0ZqZzc1Y1UxNDA0VXdaWmFNMzZt?=
 =?utf-8?B?Q1hKOFJITndzSThiZHNaSkxGODNqZmV1VmNxQjZiRnYycWtHT0l4SVdZTTBR?=
 =?utf-8?B?aVdRTWRnSzZyYWErdEtncDZXVCtBTFpMeEt1ckFDK1BsV1JrSDN6c2pPaVdO?=
 =?utf-8?B?WVI0b1l2MlRqOXBURnIwTy90b0F1MmpYVWN3N1kvZGVZVTFlKzZ3VFVqOUl0?=
 =?utf-8?B?TCtLOWhVZUs5OVUrOE5nWDJKdjNkMUVCdkJJUlZxRzFLanZtWkxpUEpJc25u?=
 =?utf-8?B?QlM3bE05aGFjVzFWOTdkV0c2Z1Q4dkhSUDhLTENvdElrOEkwdlZTQTgwWW92?=
 =?utf-8?B?ZGdQRk1PeEQrcWQzK0JEZkNzbklzOTlsYm01Y2dtQzRibjVhTWdsOXlDYjNw?=
 =?utf-8?B?SEtTSzhGS0dtQXhibWdnN01MaXBjQU8zL244QTBKWkptSXQvM2Exd2g4YzRC?=
 =?utf-8?B?Ty9zd09jWjRNQlNENitEdnhUekQvQzkzRElKMUJoeENkMGtGc0oxTDJJZ3dv?=
 =?utf-8?B?SXVlUnN0KzhDMm1QVzlXUDNlTWtGTmdIMHlJdS9QWTF1QURwKzNkc2lJNXNE?=
 =?utf-8?B?LzRHTGdjZUExMWZKT2Z0YUo1ODFtN01zd0JnWGw4WThTQ2xlSC8yb01OYnNX?=
 =?utf-8?B?cWQzaHo4aFFoVW1aYUFLZGN0aGxqM1YvdzlvWnZ5MkQ1N1I4ejVXSlpxUDQ0?=
 =?utf-8?B?YUtWTEt2TjVqcHRoc2tHYTVaYUR5aFZkSlBnMkZpWE5UYk9yTlFPV3BIN0Y3?=
 =?utf-8?B?YklmQytPNTNxUFVsekNlTllMME9iaGFxODNzU1VUdVBOOEhCVDR2ZUNtclNv?=
 =?utf-8?B?NjNFSSswakF4alp2WTRPUlZoZXRrbFZVNXBmMi9SUGZzOFRFTys2eE1aSU12?=
 =?utf-8?B?ZnpuK0ZqaThpZmFGMkczanhhcWkrY3h1WHo2NmE0RHRYVy9UM1UxQzBXSllN?=
 =?utf-8?B?cFNQbldScllhbEpPZjZlYlVPZEd3RnJ5OENFaFVlZElpQ2oyOE1MazQ1RTRq?=
 =?utf-8?B?eVl6cFcwK1Z0ZFNJclpFTXhEbGdDZEU2ZXJMa1pWYXJ6Y00yelFRMWdTVnlS?=
 =?utf-8?B?KzBEWExXbzB2UWh3TWh2NzdiSjAzUk9adm5uMWo5ajBUcjc0blVMUXNVQUNn?=
 =?utf-8?B?eFRjL2JoV2d3ZkxxQWptVWk2NVdNaS9xeFowTjE3dFgwT1h0a2FYZ2Yzc2Ji?=
 =?utf-8?B?Qzh2M2lpdmpiSER1bi9Sd0VVRWt1VndQYS9PUFV0UDRPVHdWVjlUdWZYQXRB?=
 =?utf-8?B?SUIwT0pBNzh3OXIvazhDY3NnbHUwU0RqaFRkTDdzOUl3eTdsZmZFaE5sSEpW?=
 =?utf-8?B?c0JHTVUrQ2FOc3pmdkpGbXpTNC9FSG1MekptT1ZVcG91dHlFK2NWY2tkUWp4?=
 =?utf-8?B?RmVJdStNQ2dCbW14eGgrdmtMSTdPQlRLWENGS2lmOGRwQ01HVG1pNytTczdD?=
 =?utf-8?B?aWE2c3VhUHFYRTJTSmxtdlFNRmtlS3FCc3JlM3VmZHlMTWkzT2h3TDdQTjlt?=
 =?utf-8?B?NElxRUlDKytoa2FHOU4rdlpBVlYra0pFNXNzY1l3ZUk2SEU3cGg2L2FwT2do?=
 =?utf-8?B?ZVdEd1VTbnpQVXNCYnArVHNDNjV6cXV5ZVJleUUveHdpbXZ2cUdOaVJQRjh3?=
 =?utf-8?B?MzNRYjY2OEV0cm9uaVhRUlpLY0Y3ZzhkQW9kSzdNOWJkSUxXMm9aOHRNaFRk?=
 =?utf-8?B?d1QvMkRCV0ExZ3FEY3F1TzRVY2JSZEpLOFZjV0VZYi9aUkhUdGdQVU5leFhG?=
 =?utf-8?Q?7XEcesEyGJPDBa4zHB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c492c95c-3de2-47ab-0232-08df07f4badc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 06:46:19.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfGjFY8LXqp+xKxRRSwp/RrxGcpF2YDY+qe91Kh/XdTIHvp2+AD+FBkl6X2kO8Z0w3FtDEnjLb3NoupDY2+tRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11954

PiA+ICtzdGF0aWMgaW50IGVuZXRjX3BmX3NlbmRfbXNnKHN0cnVjdCBlbmV0Y19wZiAqcGYsIHUz
MiBtc2dfY29kZSwgdTE2DQo+IG1zX21hc2spDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBlbmV0Y19o
dyAqaHcgPSAmcGYtPnNpLT5odzsNCj4gPiArCXUxNiBvbGRfbXNfbWFzayA9IG1zX21hc2s7DQo+
ID4gKwl1MTYgbXNfc3RhdHVzOw0KPiA+ICsJdTMyIHZhbDsNCj4gPiArDQo+ID4gKwkvKiBUaGUg
TVMgYml0IGlzIHNldCwgaW5kaWNhdGluZyB0aGF0IHRoZSBjb3JyZXNwb25kaW5nIFZGIGhhcyBu
b3QNCj4gPiArCSAqIHJlYWQgdGhlIGxhc3QgbWVzc2FnZSwgUEYgY2Fubm90IHNlbmQgbmV3IG1l
c3NhZ2UgdG8gdGhlIFZGLiBUbw0KPiA+ICsJICogYXZvaWQgc2VuZGluZyBtZXNzYWdlcyB0byBz
dWNoIGEgVkYsIHRoZSBiaXQgY29ycmVzcG9uZGluZyB0byBWRg0KPiA+ICsJICogaXMgY2xlYXJl
ZCBmcm9tIG1zX21hc2suIEJlY2F1c2UgdGhlIE1TIGJpdCBjYW4gb25seSBiZSB3cml0dGVuDQo+
ID4gKwkgKiBhcyAxLCB3cml0aW5nIGEgMCBoYXMgbm8gZWZmZWN0LiBXcml0aW5nIGEgMSB3aGVu
IHRoZSBiaXQgaXMNCj4gPiArCSAqIGFscmVhZHkgc2V0IGlzIHVuZGVmaW5lZC4NCj4gPiArCSAq
Lw0KPiA+ICsJbXNfc3RhdHVzID0gZW5ldGNfcmQoaHcsIEVORVRDX1BTSU1TR1NSKSAmIDB4ZmZm
ZjsNCj4gPiArCW1zX21hc2sgJj0gfm1zX3N0YXR1czsNCj4gPiArCWlmICghbXNfbWFzaykNCj4g
PiArCQlyZXR1cm4gLUVJTzsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gRG9lcyB0aGlzIGxv
Z2ljIGludHJvZHVjZSBhIHRpbWUtb2YtY2hlY2sgdG8gdGltZS1vZi11c2UgcmFjZSBjb25kaXRp
b24/DQo+IA0KPiBJZiBhIFZGIGFja25vd2xlZGdlcyBhIHByZXZpb3VzIG1lc3NhZ2UgYnkgY2xl
YXJpbmcgaXRzIE1TIGJpdCBpbW1lZGlhdGVseQ0KPiBhZnRlciBtc19zdGF0dXMgaXMgcmVhZCwg
dGhlIG1hc2sgd2lsbCByZW1haW4gemVybyBhbmQgdGhpcyBlYXJseSByZXR1cm4NCj4gd2lsbCBw
cmV2ZW50IHRoZSBsaW5rIHN0YXRlIGZyb20gYmVpbmcgdXBkYXRlZC4NCj4gDQo+IEJlY2F1c2Ug
dGhlIGVhcmx5IHJldHVybiBwcmV2ZW50cyB0aGUgc2hhcmVkIE1DIHBheWxvYWQgZnJvbSBiZWlu
ZyB1cGRhdGVkDQo+IGluIGhhcmR3YXJlLCBhbmQgdGhlcmUgaXMgbm8gcmV0cnkgbG9naWMsIHdp
bGwgdGhlIFZGIHJlY2VpdmUgdGhlIG9sZCBsaW5rDQo+IHN0YXRlIHdoZW4gaXQgZXZlbnR1YWxs
eSByZWFkcyB0aGUgcmVnaXN0ZXIgYW5kIGJlIGxlZnQgcGVybWFuZW50bHkgb3V0IG9mDQo+IHN5
bmMgd2l0aCB0aGUgUEY/DQoNClRoaXMgaXNzdWUgc3RlbXMgZnJvbSB0aGUgaGFyZHdhcmUgbGlt
aXRhdGlvbiwgdGhlIHNvZnR3YXJlIGNhbm5vdCBndWFyYW50ZWUNCnRoYXQgdGhlIGhhcmR3YXJl
IHdvbid0IGNsZWFyIHRoZSBNUyBiaXQgYWZ0ZXIgdGhlIGNoZWNrIGlzIGNvbXBsZXRlLiBIb3dl
dmVyLA0KdGhpcyBwcm9ibGVtIGlzIGhpZ2hseSB1bmxpa2VseSB0byBvY2N1ciwgYXMgbWFpbGJv
eCBtZXNzYWdlcyBhcmUgaW5mcmVxdWVudCwgYW5kDQpWRiBoYXMgYW1wbGUgdGltZSB0byBwcm9j
ZXNzIHRoZW0uIElmIHRoaXMgc2l0dWF0aW9uIGRvZXMgYXJpc2UsIGl0IGluZGljYXRlcyB0aGF0
DQpWRiBpdHNlbGYgaXMgYWxyZWFkeSBtYWxmdW5jdGlvbmluZywgbWFraW5nIHJldHJpZXMgcG9p
bnRsZXNzLiBUaGVyZWZvcmUsIEkgYmVsaWV2ZQ0KdGhhdCBhZGRpbmcgYSByZXRyeSBtZWNoYW5p
c20gdG8gYWRkcmVzcyB0aGlzIHRoZW9yZXRpY2FsIGlzc3VlIGlzIHVubmVjZXNzYXJ5LA0KYXMg
aXQgd291bGQgb25seSBjb21wbGljYXRlIHRoZSBjb2RlIGxvZ2ljIGFuZCBpbnRyb2R1Y2UgbmV3
IHByb2JsZW1zLg0KDQo+IA0KPiA+ICsNCj4gPiArCWlmIChtc19tYXNrICE9IG9sZF9tc19tYXNr
KQ0KPiA+ICsJCWRldl93YXJuX3JhdGVsaW1pdGVkKCZwZi0+c2ktPnBkZXYtPmRldiwNCj4gPiAr
CQkJCSAgICAgIlBGIGNhbm5vdCBzZW5kIG1lc3NhZ2UgdG8gVkYocykgMHgleFxuIiwNCj4gPiAr
CQkJCSAgICAgbXNfbWFzayBeIG9sZF9tc19tYXNrKTsNCj4gPiArDQo+ID4gKwllbmV0Y193ciho
dywgRU5FVENfUFNJTVNHU1IsDQo+ID4gKwkJIEZJRUxEX1BSRVAoUFNJTVNHU1JfTUMsIG1zZ19j
b2RlKSB8IG1zX21hc2spOw0KPiA+ICsNCj4gPiArCXJldHVybiByZWFkX3BvbGxfdGltZW91dChl
bmV0Y19yZCwgdmFsLCAhKHZhbCAmIG1zX21hc2spLCAxMDAwLA0KPiA+ICsJCQkJIDIwMDAwMCwg
ZmFsc2UsIGh3LCBFTkVUQ19QU0lNU0dTUik7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IENh
biBhbiB1bnRydXN0ZWQgVkYgdXNlIHRoaXMgc3luY2hyb25vdXMgcG9sbGluZyB0byBpbnRlbnRp
b25hbGx5IHN0YWxsIHRoZQ0KPiBQRidzIGV4ZWN1dGlvbiB0aHJlYWQ/DQo+IA0KPiBUaGlzIGJs
b2NrcyBmb3IgdXAgdG8gMjAwbXMgd2FpdGluZyBmb3IgdGhlIFZGIHRvIGFja25vd2xlZGdlIHRo
ZSBtZXNzYWdlLg0KPiBTaW5jZSB0aGlzIGlzIHJlYWNoYWJsZSBieSB1bnRydXN0ZWQgVkZzIChl
LmcuLCBydW5uaW5nIGluIGEgVk0pLCBjYW4gYQ0KPiBtYWxpY2lvdXMgVkYgaWdub3JlIHRoZSBt
ZXNzYWdlIGFuZCB0aWUgdXAgdGhlIFBGIHRocmVhZD8NCg0KVGhlIGBlbmV0Y19wZl9zZW5kX21z
ZygpYCBmdW5jdGlvbiBpcyBjdXJyZW50bHkgb25seSB1c2VkIHRvIG5vdGlmeSBsaW5rDQpzdGF0
dXMsIGFuZCBtZXNzYWdlcyBvbmx5IG9jY3VyIHdoZW4gdGhlIGxpbmsgc3RhdHVzIGNoYW5nZXMs
IG1ha2luZyBpdHMNCmZyZXF1ZW5jeSBleHRyZW1lbHkgbG93LiBFdmVuIGlmIG5ldyBtZXNzYWdl
cyBhcmUgYWRkZWQgaW4gdGhlIGZ1dHVyZSwNCnRoZXkgd2lsbCBzdGlsbCBiZSB2ZXJ5IGluZnJl
cXVlbnQuIEkgZG9uJ3QgYmVsaWV2ZSB0aGF0IG1hbGljaW91cyBWRg0KaW50ZW50aW9uYWxseSBi
bG9ja2luZyBmb3IgMjAwbXMgd291bGQgaGF2ZSBhbnkgaW1wYWN0LCBzbyB0aGVyZSdzIG5vdGhp
bmcNCnRvIGZpeC4NCg0KPiANCj4gWyAuLi4gXQ0KPiA+ICtzdGF0aWMgdm9pZCBlbmV0Y19tc2df
cmVnaXN0ZXJfbGlua19zdGF0dXNfbm90aWZpZXIoc3RydWN0IGVuZXRjX3BmICpwZiwNCj4gPiAr
CQkJCQkJICAgIGludCB2Zl9pZCkNCj4gPiArew0KPiA+ICsJdTE2IHBmX21zZyA9IEZJRUxEX1BS
RVAoRU5FVENfUEZfTVNHX0NMQVNTX0lELA0KPiA+ICsJCQkJRU5FVENfTVNHX0NMQVNTX0lEX0NN
RF9TVUNDRVNTKTsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZwZi0+bXNnX2xvY2spOw0KPiA+
ICsNCj4gPiArCWVuZXRjX3BmX3JlcGx5X21zZygmcGYtPnNpLT5odywgdmZfaWQsIHBmX21zZyk7
DQo+ID4gKw0KPiA+ICsJLyogU1ItSU9WIGlzIGJlaW5nIGRpc2FibGVkIGlmIHBmLT5zcmlvdl9l
bmFibGVkIGlzIGZhbHNlLCBzbyBubw0KPiA+ICsJICogbmVlZCB0byBzZXQgbGlua19zdGF0dXNf
bXNfbWFzayBhbmQgbm90aWZ5IHRoZSBsaW5rIHN0YXR1cy4NCj4gPiArCSAqLw0KPiA+ICsJaWYg
KCFwZi0+c3Jpb3ZfZW5hYmxlZCkNCj4gPiArCQlnb3RvIG1zZ191bmxvY2s7DQo+ID4gKw0KPiA+
ICsJcGYtPmxpbmtfc3RhdHVzX21zX21hc2sgfD0gUFNJTVNHU1JfTVModmZfaWQpOw0KPiA+ICsN
Cj4gPiArCS8qIE5vdGlmeSBWRiB0aGUgY3VycmVudCBsaW5rIHN0YXR1cyAqLw0KPiA+ICsJZW5l
dGNfbXNnX25vdGlmeV92Zl9saW5rX3N0YXR1cyhwZiwgUFNJTVNHU1JfTVModmZfaWQpKTsNCj4g
DQo+IFtTZXZlcml0eTogSGlnaF0NCj4gRG9lcyBjYWxsaW5nIGVuZXRjX21zZ19ub3RpZnlfdmZf
bGlua19zdGF0dXMoKSBoZXJlIGJsb2NrIG90aGVyIG1haWxib3gNCj4gb3BlcmF0aW9ucz8NCj4g
DQo+IEJlY2F1c2UgZW5ldGNfbXNnX25vdGlmeV92Zl9saW5rX3N0YXR1cygpIGV2ZW50dWFsbHkg
Y2FsbHMNCj4gZW5ldGNfcGZfc2VuZF9tc2coKSB3aGljaCBjYW4gcG9sbCBmb3IgMjAwbXMsIGFu
ZCB3ZSBhcmUgaG9sZGluZw0KPiBwZi0+bXNnX2xvY2ssIHdpbGwgYSBzbG93IG9yIG1hbGljaW91
cyBWRiBibG9jayBhbGwgb3RoZXIgVkYgbWFpbGJveA0KPiBvcGVyYXRpb25zIGFuZCBsaW5rIHN0
YXRlIHByb2Nlc3NpbmcgZm9yIHRoaXMgUEY/DQo+IA0KDQpNYWlsYm94IG1lc3NhZ2VzIGFyZSBp
bmZyZXF1ZW50LCBhbmQgbGluayBzdGF0dXMgbWVzc2FnZXMgYXJlIG9ubHkNCmdlbmVyYXRlZCB3
aGVuIHRoZSBsaW5rIHN0YXR1cyBjaGFuZ2VzLiBUaGVyZWZvcmUsIHRoaXMgdGhlb3JldGljYWwN
CnByb2JsZW0gaXMgbm90IHdvcnRoIGZpeGluZy4gRXZlbiBpZiBpdCBkb2VzIG9jY3VyLCBpdCB3
b24ndCBjYXVzZSBhbnkNCmlzc3VlcyBvdGhlciBWRnMgd2lsbCBzaW1wbHkgZXhwZXJpZW5jZSB0
aW1lb3V0IGVycm9ycy4NCg0K
