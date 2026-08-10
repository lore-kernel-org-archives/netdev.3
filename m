Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C1313535
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786325426; cv=fail; b=LkfoyD9oJ+U0jpx6PdvmTFYw/3fMGL10a7sq/kn90xyGcKXs6gWNsEmX0UhhsrCuWyI+MiDhQ3DhC3QEPUO2kYVgjvLu3s8RGaCBoYYsUX8cXo0+JfiV9uiikmF/utdaQ06L3Fs35mDRdWkT9bp5Q3eWtIwW1x7Mhv5ynsnBe4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786325426; c=relaxed/simple;
	bh=M2zlfXQyr8C/A5uQd2SUu1r7ojb/7gjWtsfUcuilpzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GNB0PqW6X9xou29n1mniz3jqrVDExypXVhWk0q4REk/p7jTmHEtzaUWDByTPynIpjOC/XOJnbInOQ4GwXb4Bki0GiYQ+LbpL1taxHSpVTBmqgx1UHmBcgtqe73xapsNVu3LuuQNCHAw9IHiL5Ge/c4yoHaCaI8rbeOS0lCFndLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pYxuvjSZ; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pYxuvjSZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrDejqr9Q1EIS8jtLFgQi+6J03pUwacHVfw4lvG2Hq/IHVbtEKRUbMzjSug/URvU2cz3D35+joopEQaSHYQSNqyBPMmrQxu9Le5hIPSW4CclHelLW5AyJIbtlN6BwK3nCzI9w+tkOrlOeH1UXWMy0yXX1hPSc2Rb+gqx/gBEqa+WryyH5com5PdNRPthtVWY8UiRMdv6U4aX4Z/k0zzzvLRBQYvK2W1EByrwHB/3AjKOy4f5COrEnuqISb6TK8pxA4lOQZQ5RB7OAErstGcFelM5T3JbycIyXoBlRuQxPnryMebIHYNAIaixQy9hWk5dFUlnVRvaxwsdpfhDIlMHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2zlfXQyr8C/A5uQd2SUu1r7ojb/7gjWtsfUcuilpzY=;
 b=ZuxtPO9oYdqLVrNhPOI07Sfwair2cu9uQNZGbM0ZOBjRtv63SEVAy/HCetj4sVSCq/NxJDjmlW7X12VYmu+QpfX43dZ47ZsoBvxiw0IlBmQ4o3PRW0GAIjH27jT4mI/Xs8GbvGPHp2PAfZ+REtnQYjsP8vUhcQkGimyxit5RU9LulJoEmnX0cWpgciFjsdcnU2GE2ydN93WDdlV/ONTyeBTCCea2x0HhjdgTfdnUMG9JuMW117cGbKW9LEMWPFLQFDN9lkAv481hrbcvJoR/fzCzuNMWSayuviSxsPWIEdyUno6yqD9y2v5DvlyM/7P3SmjLYhpbeoXnqMyxdlyavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2zlfXQyr8C/A5uQd2SUu1r7ojb/7gjWtsfUcuilpzY=;
 b=pYxuvjSZ4FGI4wSPR6NuGZfseWUPMFsMwnPvuxf2Gcvla0sDPHOCle3b/s/uip+jmUxuBuznGkDcxNPFIahSfeF/dc7yZS/4DQyOiSY2xp8MyLSeFmKywxqwGqFQ/BnyFH0GEkXq6ksY6hGqXRaBMai9vGN/KIfB0eR9G9Gnkhdjs0/izEPjCMLNtFt96LDumLqOzABL+B33suzsKQf09b2kWBabSBcD3nTxT7lriuUi2RTuks7fDaAn4yKaVZE0b+k0j0OtAcZ5dmljlt4qyryn/Cb/VDl+EZE6p8lB9W3bboKRaSLJhq7guGodknApTTi53QjH6RGicMn+8ll1gg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 01:30:17 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 01:30:17 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 3/7] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
Thread-Topic: [PATCH v2 net-next 3/7] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
Thread-Index: AQHdJuSYrLzpo/x7qUycz1ZVCMwTk7aVDd8AgAFz7HA=
Date: Mon, 10 Aug 2026 01:30:17 +0000
Message-ID:
 <GV2PR04MB117394A33DEB46DDA7105B67788DE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
 <20260808032146.2335723-5-wei.fang@oss.nxp.com>
 <20260809031904.90B581F000E9@smtp.kernel.org>
In-Reply-To: <20260809031904.90B581F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB9398:EE_
x-ms-office365-filtering-correlation-id: ec2cd12c-4274-485e-66ee-08def67eef3b
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 //QGozp3HyCfKN4Too2dO+Z163q6+H5KicoLRNoDU55DmGY/cOaj0WnHOWtLu/d2aUlz0FWODiMPR4fNdW+IY/lWvZqADvEMNHZoQOONcIdFi0+gHNGXgmGLZ6SJFjHptFXLC9ma6wzcfo2mgMCRoTnUdO+0SJeEyc3la2GKbxsPuc3+a+PfpK4GYAVYDFI1tLBT+aFxKWShiT+cWcwhkgYT8bdRNCGRBXVi3WJvy9XoPXtlkf01/cNeMqqtlJP3vgBpVk3DEz7ZOEDoXLKSWHX31hZKjzV6FRPpGmFOu9MYT034TPbtgfrPs5pz6roPfZxUPX872EDutlYmElLfVEHPIjuyPfRxjHzwtSylsR1GfVb3n0DRWZL45jbNOlOdM2ZLfQYFbqrX4UsCfLBueDPOu1Nz3510Zr3JwD8oRzCjHTX4jjswB4KiWI5Ez4/Q4TZECug/eCgCwGog4z3+l6NqQgiMmXvJtNvBHeRbTAV4vBLdYwE3Gm7EHZ+N+zs2ovrUkYzVk4Qadvea/E+20VPVM8X3a3UsAre6UWxqciVuxnLSmteOsiHAoUj+rNlCKnYhn+oEuvM+kTueSvwWg70oyVE3iP5ip4OQ72zjiK3WBlt3i1Gp9WPRCuBwdxZHdOCOiDgr+rzZDRgOIm6bFbCPUk2cNMrHqmFYqm/rWd3CwArKmvhkcX/z6wFuWZ9Uz84Rdj8DuXhLVjVtqOya2nG23VOKFtaigdd9oZjpvMM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blgyZlBJTUc3d3NEQjRtYnhzNURiTWhydnpyODd1TFFKdmQ5QWVRN1JteUIr?=
 =?utf-8?B?ZFNSQnlCejJhczRnNXZydllUNmFyTmdPUGdESFN2N2k0QzlWYXRETllBZW14?=
 =?utf-8?B?TXVYZVo2RkJRdTVWWXFwK1RRK3lWelBjdko3YmxEanlzSTRiZ0hEMHJ4WDBO?=
 =?utf-8?B?S05EaXZvbmNOdWM2dUIyOEtyRlBRZE54c0xzQ2hjTWxvcElSTE5MT0FOVmlz?=
 =?utf-8?B?bElUdExWdzljaGFiTWxtc2pZVjBIZnhNUzdSdm80eWY4djVPU2FVV3ViVXNo?=
 =?utf-8?B?Qjl4VjVWck1yNkIrRjlVZ1dxSjZwL3FBeUFhQU82UXVBMGl0bDd3c1A0bVhq?=
 =?utf-8?B?YUxlbnhvanRha1RWUEF6ZjlBMGtJRkh2NG81MkpxcDM0eVBlTnRWWFJkZXJD?=
 =?utf-8?B?em1RdUhWNkFIR0IycTFESkZlMDFFVVFyUmFiWkU0Z1JPQkZrbGFrSXp1WFJ4?=
 =?utf-8?B?NFNtSWVxSHdWblk5a0ViOXowMUtMZklsNlV4T0tscEh3SWtzTng1R2plTjk2?=
 =?utf-8?B?K0RPdGhVM1NUaGVWVnk2Y2Z6Unl6Nm5Va29NUnF2WnVSbjNyNGFoNVJsVmFi?=
 =?utf-8?B?dTd3eDRuTEZOd2l0a2phRFRmV2lNcE9GaHUyVXh0UDJnQVU1Z2grd2RxbDFJ?=
 =?utf-8?B?V2R2dHF5eVhMMDdkT1djUlFFcnFCUmcrSXFSUUd4UkhtQURLRHVaWmlibnJL?=
 =?utf-8?B?b29MU2VXU1Erekc4azhqaGxaTmpnVERuVW05bVR1aSsvUjd6cStTZVdobEVx?=
 =?utf-8?B?SG1pcW9icnhabmJvVUpLS25CMzdjRkNrVmxhYWNwM0loZFI2WVlmT2tMSE5t?=
 =?utf-8?B?amZUc3NZaitRQmM5cTFRcTlxQkFYZ0NxNjNkWkxid0RSMmJ5VXhBNnRrRmp5?=
 =?utf-8?B?S0JZRU1vNzJKcmpkM2VSQkx0NXdDREIxdUJCQm1JbzRXWkRzWjMwUTZNdlYw?=
 =?utf-8?B?aDV0N1p1RXFqaVhzYjV2R0YrclhQU3JNcnhYbVRia2Q2MWExQ1p4amJ3c0RM?=
 =?utf-8?B?MDc5SXZsSkpPL1dhUTVianNndDlxbE1sRjFtbEZnTXZOM2JkSERnNDNuSzQ1?=
 =?utf-8?B?K2MzZmczQmdjU0pzYnVKa3o1SFVmK3V5TVBac1RiWXkyaW9DQVNzZkF2bHJq?=
 =?utf-8?B?UnQ0b09MdFBjL1hFLzVBZEpUQVhvUU43M1pVYmwxUE96SStwT0lWeXJNSUZo?=
 =?utf-8?B?MHIyekU3ejlGWkdsT1JVTXZRVGJBUlExMHE2VmhTVS9yMUlkT1dhUHNURHZC?=
 =?utf-8?B?MHBsQmhIM0dzWks4MDY5b1c0QkRMRXNzKytBdEJvRGx2b2oyVzhsY08wQ0do?=
 =?utf-8?B?UjIvS2JjMlBxOFAyaVRocW5LcVFLb3dNVXZqdzV5S0wzNzgzVnpLRS92dmxO?=
 =?utf-8?B?aE5hczkvM0ZtOVdhRjZIQmtkL01kWXJ5Mms0UHF5MTdTeis2MEZkdUovY28r?=
 =?utf-8?B?WDIwWm9WdFdva3JQaG5EU3hWcnZyaGxtcWZISGduV3Yydlc0eWd6OGNsN0gw?=
 =?utf-8?B?TkdmSzV5NWZLQktrUFpNM0pEU3ZWU2ZTN0RkbjdLNTZ4THdWUDBpUTZyQjFD?=
 =?utf-8?B?YzZubjM3Sk80VThLRVlIcUZOQzZtLy9ibVpuSnQ5RzNrY1RVZ2Y2a1ZVM1RW?=
 =?utf-8?B?Y29hbXBVeEFZcU11UWtROVR4NkJLd25yVEx1cXJhNm1LdkVYWEdJZW1pdnBx?=
 =?utf-8?B?QlNEVll4NytDYTdpUmJvNmx3VVh3bXRYVzQyWTNZemt1NDVoQVN4OWVUYXVt?=
 =?utf-8?B?RHZyVWR5Nmk3eFIvQ3JLN2JrdjFwMTNDdkJJTjJLZ0RsUU5nd2R1QnlBZUFp?=
 =?utf-8?B?d1dzbXMybTVpWjBpTmVaQlZFUnhoakxTYU83N0xjVUpIelNib0lMM0hhS21F?=
 =?utf-8?B?a3dZeWJxUXFQV3FwZFM2UGZuNEdzbVJTM1ZyYjF6VE5GZmZENlJ0UUJYbGkx?=
 =?utf-8?B?SWtWNmlvT3VrZ0hYVXF4QTJpSjRrUTlKcHdJRG5ub1FSMGdNek5yUG9hL0lV?=
 =?utf-8?B?YXdzaUVPZE9qeENxS0I1RVFRT3JvVHhBNDZuc0YrN2pxZG9BcENZRnFwejdh?=
 =?utf-8?B?ZER6REg1SHE4Zy9LUkNUSzVoVTMwbGFuS1NUSlBLU3c0QmFiUjNZdkN4Njky?=
 =?utf-8?B?dlBsSE9ieU1DT2N5a0dEZ0ZhRGpQdEUxSW1neFUyVHNWK2d5b0NJUlFPTTJQ?=
 =?utf-8?B?M1ZZNEttcUd1dk51bFM4V1hvOXFjR3Y3V3hnclRzOFdmWDhHb29UL21LcDd1?=
 =?utf-8?B?WGJlQnZjZjA2MHZULzN5RjBDc0FxelhaaG5iMTVjU3RnbHMvVDdtR21JV0Ez?=
 =?utf-8?Q?Zw52CHIhrADEACwXbT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2cd12c-4274-485e-66ee-08def67eef3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 01:30:17.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pghU2EwV1MhcOiVXSMWyz3TRaSSFyuACeqiSKGVWQh+mdkZWnnGLMm9jHN2T+fTs4cN+svAdN8kiZMrqw/8odQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9398

PiA+IEBAIC0xNjUsNiArMTY1LDQ3IEBAIHN0YXRpYyB1NjQgbmV0Y190aW1lcl9jdXJfdGltZV9y
ZWFkKHN0cnVjdA0KPiBuZXRjX3RpbWVyICpwcml2KQ0KPiA+ICAJcmV0dXJuIG5ldGNfdGltZXJf
cmQ2NChwcml2LCBORVRDX1RNUl9DVVJfVElNRV9MKTsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qKg0K
PiA+ICsgKiBuZXRjX3RpbWVyX2dldF9jdXJyZW50X3RpbWUgLSByZWFkIHRoZSBjdXJyZW50IFBU
UCB0aW1lIGZyb20gdGhlIE5FVEMNCj4gVGltZXINCj4gPiArICogQHBkZXY6IFBDSSBkZXZpY2Ug
b2YgdGhlIE5FVEMgVGltZXINCj4gPiArICoNCj4gPiArICogUmVhZHMgdGhlIDY0LWJpdCBjdXJy
ZW50IHRpbWUgcmVnaXN0ZXIgKFRNUl9DVVJfVElNRSkgZnJvbSB0aGUgTkVUQw0KPiBUaW1lcg0K
PiA+ICsgKiBkZXZpY2UgYXNzb2NpYXRlZCB3aXRoIEBwZGV2LiBSZXR1cm5zIDAgaWYgdGhlIFRp
bWVyIGRyaXZlciBoYXMgbm90IHlldA0KPiA+ICsgKiBwcm9iZWQgb3IgaGFzIGFscmVhZHkgYmVl
biByZW1vdmVkLg0KPiA+ICsgKg0KPiA+ICsgKiBDb250ZXh0OiBQcm9jZXNzIGNvbnRleHQgb25s
eS4gQWNxdWlyZXMgdGhlIGRldmljZSBtdXRleCB2aWENCj4gZGV2aWNlX2xvY2soKSwNCj4gPiAr
ICogICAgICAgICAgd2hpY2ggbWF5IHNsZWVwLiBNdXN0IG5vdCBiZSBjYWxsZWQgZnJvbSBhdG9t
aWMgY29udGV4dCwNCj4gc29mdGlycSwNCj4gPiArICogICAgICAgICAgQkgsIG9yIHdoaWxlIGhv
bGRpbmcgYSBzcGlubG9jay4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiBDdXJyZW50IFBUUCB0
aW1lIGluIG5hbm9zZWNvbmRzLCBvciAwIGlmIHRoZSB0aW1lciBpcyB1bmF2YWlsYWJsZS4NCj4g
PiArICovDQo+ID4gK3U2NCBuZXRjX3RpbWVyX2dldF9jdXJyZW50X3RpbWUoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBuZXRjX3RpbWVyICpwcml2Ow0KPiA+ICsJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArCXU2NCBjdXJfdGltZSA9IDA7DQo+ID4gKw0KPiA+
ICsJLyogU2VyaWFsaXplIGFnYWluc3QgZHJpdmVyIHVuYmluZDogdGhlIHJlbW92ZSgpIGNhbGxi
YWNrIHJ1bnMgdW5kZXINCj4gPiArCSAqIHRoZSBkZXZpY2UgbG9jaywgc28gaG9sZGluZyBpdCBo
ZXJlIGVuc3VyZXMgdGhhdCBwcml2IHJlbWFpbnMgdmFsaWQNCj4gPiArCSAqIGZvciB0aGUgZW50
aXJlIGR1cmF0aW9uIG9mIHRoZSByZWdpc3RlciByZWFkLg0KPiA+ICsJICovDQo+ID4gKwlkZXZp
Y2VfbG9jaygmcGRldi0+ZGV2KTsNCj4gPiArDQo+ID4gKwlwcml2ID0gcGNpX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiA+ICsJaWYgKCFwcml2KQ0KPiA+ICsJCWdvdG8gdW5sb2NrX2RldmljZTsNCj4g
PiArDQo+ID4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmcHJpdi0+bG9jaywgZmxhZ3MpOw0KPiANCj4g
W1NldmVyaXR5OiBIaWdoXQ0KPiBJZiBhIHByaXZpbGVnZWQgdXNlciB1bmJpbmRzIHRoZSBwdHBf
bmV0YyBkcml2ZXIgZnJvbSB0aGlzIFBDSSBkZXZpY2UgdmlhDQo+IHN5c2ZzIGFuZCBiaW5kcyBh
IGRpZmZlcmVudCBkcml2ZXIgKGxpa2UgdmZpby1wY2kpLCB3b24ndCBwY2lfZ2V0X2RydmRhdGEo
KQ0KPiByZXR1cm4gdGhlIG5ldyBkcml2ZXIncyBwcml2YXRlIGRhdGEgc3RydWN0dXJlIGluc3Rl
YWQgb2Ygc3RydWN0IG5ldGNfdGltZXI/DQo+IA0KPiBDb3VsZCB0aGlzIGNhdXNlIHR5cGUgY29u
ZnVzaW9uIGFuZCBtZW1vcnkgY29ycnVwdGlvbiB3aGVuIHN1YnNlcXVlbnRseQ0KPiBhY2Nlc3Np
bmcgcHJpdi0+bG9jayBhbmQgcHJpdi0+YmFzZSBkdXJpbmcgdGhlIHJlZ2lzdGVyIHJlYWQ/DQo+
IA0KPiBXb3VsZCBpdCBiZSBzYWZlciB0byB2ZXJpZnkgdGhhdCBwZGV2LT5kcml2ZXIgaXMgYWN0
dWFsbHkgdGhlIG5ldGNfdGltZXJfZHJpdmVyDQo+IGJlZm9yZSBkZXJlZmVyZW5jaW5nIHRoZSBk
cml2ZXIgZGF0YT8NCj4gDQoNCkl0IGRvZXMgbWFrZSBzZW5zZSwgSSB3aWxsIGFkZCBhIGNoZWNr
IGZvciB0aGlzIHVudXN1YWwgY2FzZS4NCg0K
