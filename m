Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471879;
	b=JX62xheGhH5UAZhIEvZ8t9mBgNkRLydNoZ+br/ji2popnNbs/sKDERxfzhxbfSSS3Qi/
	 Rk39C8Q5T6xrBZ6HGyruvD3sldu567OKKW8TJNmk0/ePUsy+FddQxWrprocwEhRyEvGh6
	 M5qFLkrovjQ4w+F6QkSl4rHdPGIVBjeaegErX1fFiFzPhgzN5LWsJmngoo9t8OfT4avlP
	 S6UnZ9EAL19qdqTV1E8Sza9aw1sgjXMLTrXg5Pkwg+DgkflntN4AXAFhSzoteu4I1YRlJ
	 oSrX2EiMl8p7qMcbaMlsUak/Ql9tDREEspUJQ2eGmO2YopHR4c3oL1iTPZuw68qerBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471879;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-exchange-messagesentrepresentingtype:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-sharedmailbox-routingagent-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=B9V/FN2NdsEnN9rGGfO8s/uSYSl9tIKbVSeNhlmoImk=;
	b=AGL7hIU8o7weLB5oF/LD/agiU43rwSyGBPm4saQDWe5nEfqy2kUD8Q2VOJW/P8y/ff0q
	 RyW0s0O1uWCH9U9Mc7VvxOlQN7pqCG78edd8ll+t0yhnPMR63iPrJldS+zvhpG1ErH1Cq
	 +dtE86hdEKJYq0mwh5v0bM/bFHezH7mx6iT1gzRrGDCIc+CsUocCmgdfILljoaJHR861m
	 50p+vLBzqEW7WnJJfNPe426P7sFtZqcxsxh2q8pDnmLsS1sS6x6L47H0cz5MBcLRYkdyX
	 i+D4qFA2fuwEXECmRb0At3zAzkuWmcqXTvnZvjZDEyNeQl5PlCa0wUzevWsvm7ZEB8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IU6PhBOD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.66
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD80606A338
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD80606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IU6PhBOD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLdstkOfMPjnk8QaLtnb/r8DWSTyQwWBkeybvpW+5rURI6EZOt3fH1eF7/pRbQygsRxvKu/BzvC00I17q1g7FVnC+g4ewrbJtB2UmyxtUwYeHgUh3Q0+zhVASe7YCnZSoaaLSxe+UwInTvBk5PQQmimmghAWrWTbnUGQ6t2sQTzrGhZAP9ALg+j1prw4MJMq4e3c+VB+36+rRqXg8GAqJ4hQwmdkVwrxQtZOuUPlOiu+LT2YRwKvb1duGLK01XgYi9Ps8aJfjnsYEyjRHMmkV/A+LNIblPp3hwCSprIsvMiQOD/jz/aqI6Hls5UXu2JNfBln5xrSJXvq8fGNqpWU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9V/FN2NdsEnN9rGGfO8s/uSYSl9tIKbVSeNhlmoImk=;
 b=PDp0FATBPud3KHu6lciybq3Ab9zbpIKNuYt5UezKKInvkrbMn+5btL4BsPBSnFm8G2rt+Qx6OBXxK/zJ68CQDxKunCPWyXMi+PHywYQXc5aNkWpX6ItehJ3Z2mx/H2+yo8uZ4h4n1PqNu5FgonW2fm50cIPK0UJPZCxPpZv9cHj3LLcfG0kHMondn7vtP3MatK+BypTxTuwhhYQH7u2u5LzSDRx1a0GnqEK7fRB9OOxlKSG+EiiOv6YSBSlC6+5AHIYOAj1fmTF75VyBObEl2HnfZajo9BEzRbUUEKZKu/HXHGF4EZQhWgqJFJ4CClBpo6niR5bDKtMzHuOgKXzz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9V/FN2NdsEnN9rGGfO8s/uSYSl9tIKbVSeNhlmoImk=;
 b=IU6PhBODDHdIzSmgzerF5I5RdggkmeMoyX8D0lWgHiyy+fdmGSIlxZ8+iBMWZ1BpTsw2Ok0S6VYmmSlsCuLe42Z1Km3EwmCGLGFIkTlPZDKs50HRU1HHFal4ripgBO6Pgy0STpuGsMT60ld9tCQ+Has8vWH4BVFvUotjC+0G8A6cMtmT16vGtX9jLC+Lo6I3sBJynG/4RdaaUKsVic2fedK0060B8vWv7WC9DEvUeeAaEHma0LJagj3TGsKqsexJBKjQIn87e7/HKQfRCo7l4zwJU8u75jYhwWY3vjh58NFVCrdhfpNGiEFFejWo0UL/RM0JptbnPNno8mGKvsD93g==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AMBPR04MB484752.eurprd04.prod.outlook.com (2603:10a6:20b:7da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 08:24:35 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%7]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 08:24:35 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Netdev <netdev@vger.kernel.org>
Subject: RE: [PATCH v7 net-next 8/9] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Topic: [PATCH v7 net-next 8/9] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Index: AQHdcaU4eIwceHzesU6ghY8K6MQPtbcp+ZSAgAAhnuA=
Date: Thu, 12 Nov 2026 08:24:35 +0000
Message-ID:
 <AS4PR04MB93382FC439D159E0972D7F3B88702@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
 <20261111062753.1397582-9-wei.fang@oss.nxp.com>
 <sashiko-outbox-210520@kernel.org>
In-Reply-To: <sashiko-outbox-210520@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-12T08:13:41.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AMBPR04MB484752:EE_
x-ms-office365-filtering-correlation-id: ed69023f-4eb8-4758-6d4e-08df409662d5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|23010399003|366016|38070700021|10067099003|11063799006|4143699003|56012099006|261026121527099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 7Tyi687GAWADqHK4UUM8A2SLJNO9sU8ZruwAKLSe80pBRAOxOiHsaGNyomNl9hX2aqhc8Qri2p0pBdWbiC0aUM+x8+MfAZ6+FR0bHB5U9oIGIwULleeovxrDJGzuhKxhSUwS7TYIMBGoTy+Kd8EIFeONOutB86xwsOriw8kh4lXSbT/1If9vi5aCIdisGgxB+U+oCfgD4Dt4Mxz80FtMwB8US4D2VNbsaMGQ2PeQEA0I8gmkUlaSjqjSGEhQKq8m6c4R6WMoGXSm+yAr9FjDW/uydFYjxBJwnlukmOggkA3ooBr06BgMvvnVGF5tmunXKP5J3/WiBLNvVHDcFx8EW7K40O6Q0EM4NadBdoudl0Pbhegyz3zvpTLD4wF/O9kHxpxSvDnanuKtvqk02imN1VSFD75VCuhsrct12qcJ0czf6vhzQnAWF4FH28xZYxeK+dyZLIuI5RT7lJ68dkA0sl46MRXjT59CMWfi+ZY35Y3Ba+PXbu65Szl4/HAr7mZJ2xN4hbCg2gul8KCB6M4Bnjxmx7kcgNaoamG9N5D8Sl+b1QHobymvrMq1cQWVIe+d3/E3rJ+uxbw/o8wgA/436L254qBHfRwASxUSPkvAle03AwGsmZjyiZHsdkG/dPkgwqof+LX0QotRjSUmK/WD5UyaWvM+1OmSJGyCm1b1UC8sMrJEjca1jU47gLmXX5tDTmk4SeVlQpVgNDMcRTXGDw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cCtFZ1RoU2RKVnVia1dnRkZoZytwaVY4VTQrdlFjb0pjVGNwSVZsLzZRem43?=
 =?utf-8?B?QjREb1dvUzhMR2NIaFVyT3h5SmtwNXhNc2p4ekMxT3pkRk4xQjQ4UGhsMUgx?=
 =?utf-8?B?dnNhOFp3aExuTFo3TzZGU29QZ3BIVGN3LzdvT1hPVCtGVlBzWjBEbi9HdVl4?=
 =?utf-8?B?YmtuU0JhWkJmRW5tL0lUT01FTXlCa3dRNjcxWE1teS94cDBURXJwRTNCRnFy?=
 =?utf-8?B?TVdyUjhZTklzVjkxbTNsK3lveGFpUXo1djl5a21VWUVSUDBCSzVuN3lGQ1Z0?=
 =?utf-8?B?dDQ5SWNIM3BNVUp3WG1mMThOVUMvekc0MHo2d0xZeFRVMlpIWlROb0NYcXMw?=
 =?utf-8?B?WlorYklVbFM3Ri8zS3Rkc3cwRDNFcGhNaGtWNXR1bHZScGJucGdLSWowMDRY?=
 =?utf-8?B?K2xvb0VySGpldzNHZmYvN1RXZnR0QWQweWMvazZydW4xREhleXh4a1IrUGRi?=
 =?utf-8?B?NE54Wkl4K0o1ZHlRYWZ6Z3M0TG5wUmJ6cHBKWWxNaHh1ZFR5R2M2T24xVTZi?=
 =?utf-8?B?WXFWQmVQd3p3M0J0L0pnZEpiMS9tK01NVmp3TFBJc2VZNEVaNFFXQUNpZHdk?=
 =?utf-8?B?Ymp0VVBaSEs3dU9ESkhqZVh2MHJabitadW00Z1o4VkI2TDFVQzNhUmYvSXg0?=
 =?utf-8?B?UTh3RHlIbEFvSVJ1Tm5Nb0hudGhram00aEFzMEFwSDhwZkNSajhYc0dkTUY3?=
 =?utf-8?B?TFZwbmF6WEdyanphczRWby9HY2VuN1Qzc1NsWGEveGtDdmZraHpqcnlvMGRT?=
 =?utf-8?B?S2VkSE9VeHJiNzlHSXV1cFJPOE1DYkNOM1ZuVzROdW01alpCcjdOUGF6WXVS?=
 =?utf-8?B?SVJ5dmxwajg0aFBDSC9yMFFMbjF3TThSNkNqbVVxWW9wTjFKd1J0aXFyeWRR?=
 =?utf-8?B?azRhVnJzb2FjRXphNm1kMUNDN1NDSHdnT1BzWHNNdVVQRGxob0hwSi8xSUpl?=
 =?utf-8?B?SkF5a3hVcU1hc0J1L0FzSlRoQTlmcStjZTJpdi9DdjBSQUVpUXk0SU9BV1lw?=
 =?utf-8?B?c1VYNndBMkNDeEpzS0JUQUlDbDZkTGc2TWk0aEJZcFVINWlXcHhtNEhFdmJh?=
 =?utf-8?B?V0RWUzNUZ3B3WDN5aXVnV1duUlh0RmpJWkx4QWJaT0pKOTQxRFZFaDl5Mi9C?=
 =?utf-8?B?UEdzQ2ZNZ0E1MlByU3VCYlRMb1BkLzFaYXBYVVZpd05BOFh0dDVidjA2S216?=
 =?utf-8?B?UFVPbHpuV2FMeGd0cWNqMTNLZHhFaWpycGRlSDJvdWZqRFVuTktTT1lQbUla?=
 =?utf-8?B?ZTdRZ1luWExMWkNJa053cVdpVC9jTXZMVEpYdk5yb2l1RlF4dXBLeEg5dXQy?=
 =?utf-8?B?Zml6aW5XTzZRUXY5czNNNTFDMDhLK0Z6R2hBT3dqRkNFVGFIamZGaW9XV1Nr?=
 =?utf-8?B?ZHdrWlRZKzUwZlg4aGVqRXBGd3MxWGF2bDU5emUrdlBMMEY0eVlWTU5uUEs5?=
 =?utf-8?B?K0w1ZmRrK21OOWMvYVRpV1VFTnliUFBiUXBnbTQxNVluTGtTc1B6YWdYampM?=
 =?utf-8?B?UnhsbVhyQjBXaExIaUpWVDFPOUc3d1FoOXBsODhkWXdrYUt3UnFvZU1NUE5p?=
 =?utf-8?B?VGtNN3FHQW5DV0tGc2ZrTVlTaVdhWGMycDh3UURGTjJaMWNZU3MyWWtJUjd5?=
 =?utf-8?B?SkV1TDh3d1hLdVBTa1J3dSs1L3QwYno0K2VyRnoxS2IycS8vdHRYdlVaenRy?=
 =?utf-8?B?bVc5aVlVOUFaZU9OZUw5cjdnNzlrZnZDZnJxamZWWDRieDJIeEJyNUJPMkN5?=
 =?utf-8?B?K1JNZkU3Q3RXNU9VOUlhaHVNVWVMdW5raEljaElaRmt3MmtEaG41dGhuOHJm?=
 =?utf-8?B?QmprZTBqWGt6ZGl0TmFYUy9hWko2a0hDZnlTS1YyS0JYTzFOKzVQL2lsSlQ4?=
 =?utf-8?B?OTN4eFBYeHZVNk1WdG05RHl0MVdwazRjOFErNUdyWGFJYXAyalZhMFFMc2lY?=
 =?utf-8?B?SmZUbG9SUmY5am1qVFo1ZDBYeUxidmVIdHc0azY2VXhvL2FvSGxBUnpDVEhr?=
 =?utf-8?B?QW54d2xoRXQwazIrRlUxZFFFZ1R5MFBYbXlxU0pmeTd4MTFUUTFRVGRneGRJ?=
 =?utf-8?B?bUZtZ0xCazE3RmdBNnpiaFordUxNMm9yNGlFOUxTZ1dySEJ0OWJhSjkzQzVV?=
 =?utf-8?B?OW1lbGpwQmRDTjRZK21leUI2QWtLaDk3WFhLZkp1UlhwdHRhcVhoYlRpUlAv?=
 =?utf-8?B?T3pmLzM3bkw2SzFQcm40TkRrZ2Rhc1gvc2ljM1JpWllXTmd4elFHcUNlcUNP?=
 =?utf-8?B?cWZXQmhxNUlWWnRUU05ZYlI2YTZQWlExWlJYU0VyZDJHdmRlczFuZkJQckI3?=
 =?utf-8?Q?DGTfMPU+kfbhovqWft?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed69023f-4eb8-4758-6d4e-08df409662d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 08:24:35.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eR/xZthe6duqQ3Jk0em0nEV5tWUBAG63s8W7xWCaLeKRtjdFN2aD2qmFID3JgO/0DXNie8StUyfE7a6XofKcEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB484752

PiA+ICtzdGF0aWMgaW50IG5ldGNfYnVpbGRfcHRwX2lwZnRfa2V5ZShzdHJ1Y3QgaXBmdF9rZXll
X2RhdGEgKmtleWUsIGludCBwb3J0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZW51bSBuZXRjX3B0cF90eXBlIHR5cGUpDQo+ID4gK3sNCj4gPiArICAgdTE2IHNyY19wb3J0
LCBmcm1fYXR0cl9mbGFnczsNCj4gPiArDQo+ID4gKyAgIGtleWUtPnByZWNlZGVuY2UgPSBjcHVf
dG9fbGUxNihORVRDX0lQRlRfUFRQX1BSRUNFREVOQ0UpOw0KPiA+ICsgICBzcmNfcG9ydCA9IEZJ
RUxEX1BSRVAoSVBGVF9TUkNfUE9SVCwgcG9ydCk7DQo+ID4gKyAgIHNyY19wb3J0IHw9IElQRlRf
U1JDX1BPUlRfTUFTSzsNCj4gPiArICAga2V5ZS0+c3JjX3BvcnQgPSBjcHVfdG9fbGUxNihzcmNf
cG9ydCk7DQo+ID4gKw0KPiA+ICsgICBzd2l0Y2ggKHR5cGUpIHsNCj4gPiArICAgY2FzZSBORVRD
X1BUUF9MMjoNCj4gPiArICAgICAgICAgICBrZXllLT5ldGhlcnR5cGUgPSBodG9ucyhFVEhfUF8x
NTg4KTsNCj4gPiArICAgICAgICAgICBrZXllLT5ldGhlcnR5cGVfbWFzayA9IGh0b25zKDB4ZmZm
Zik7DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIGNhc2UgTkVUQ19QVFBfTDRfSVBW
NF9FVkVOVDoNCj4gPiArICAgY2FzZSBORVRDX1BUUF9MNF9JUFY0X0dFTkVSQUw6DQo+ID4gKyAg
IGNhc2UgTkVUQ19QVFBfTDRfSVBWNl9FVkVOVDoNCj4gPiArICAgY2FzZSBORVRDX1BUUF9MNF9J
UFY2X0dFTkVSQUw6DQo+ID4gKyAgICAgICAgICAgZnJtX2F0dHJfZmxhZ3MgPSBJUEZUX0ZBRl9J
UF9IRFIgfA0KPiBGSUVMRF9QUkVQKElQRlRfRkFGX0w0X0NPREUsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBJUEZUX0ZBRl9VRFBfSERSKTsNCj4gPiArICAgICAgICAgICBpZiAo
dHlwZSA9PSBORVRDX1BUUF9MNF9JUFY2X0VWRU5UIHx8DQo+ID4gKyAgICAgICAgICAgICAgIHR5
cGUgPT0gTkVUQ19QVFBfTDRfSVBWNl9HRU5FUkFMKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ZnJtX2F0dHJfZmxhZ3MgfD0gSVBGVF9GQUZfSVBfVkVSNjsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAga2V5ZS0+ZnJtX2F0dHJfZmxhZ3MgPSBjcHVfdG9fbGUxNihmcm1fYXR0cl9mbGFncyk7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgIC8qIFNldCBJUCB2ZXJzaW9uIGJpdCBpbiBmbGFnc19tYXNr
IHRvIG1hdGNoIElQdjQgb3IgSVB2Ng0KPiA+ICsgICAgICAgICAgICAqIHBhY2tldHMNCj4gPiAr
ICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICBmcm1fYXR0cl9mbGFncyB8PSBJUEZUX0ZB
Rl9JUF9WRVI2Ow0KPiA+ICsgICAgICAgICAgIGtleWUtPmZybV9hdHRyX2ZsYWdzX21hc2sgPSBj
cHVfdG9fbGUxNihmcm1fYXR0cl9mbGFncyk7DQo+DQo+IFtTZXZlcml0eTogTG93XQ0KPiBEb2Vz
IHJldXNpbmcgZnJtX2F0dHJfZmxhZ3MgZm9yIGtleWUtPmZybV9hdHRyX2ZsYWdzX21hc2sgbGVh
dmUgdGhlIGxvd2VyDQo+IGJpdCBvZiBJUEZUX0ZBRl9MNF9DT0RFIHVubWFza2VkPw0KPg0KPiBJ
biBpbmNsdWRlL2xpbnV4L2ZzbC9udG1wLmgsIElQRlRfRkFGX0w0X0NPREUgaXMgR0VOTUFTSygx
MSwgMTApIGFuZA0KPiBJUEZUX0ZBRl9VRFBfSERSIGlzIDIsIHNvIEZJRUxEX1BSRVAoSVBGVF9G
QUZfTDRfQ09ERSwNCj4gSVBGVF9GQUZfVURQX0hEUikNCj4gb25seSBzZXRzIGJpdCAxMS4gIFdp
dGhvdXQgT1JpbmcgSVBGVF9GQUZfTDRfQ09ERSBpbnRvIGZybV9hdHRyX2ZsYWdzX21hc2ssDQo+
IGJpdCAxMCBpcyBsZWZ0IHdpbGRjYXJkZWQgaW4gdGhlIGZyYW1lIGF0dHJpYnV0ZSBmbGFncyBj
aGVjayAobWF0Y2hpbmcgYm90aA0KPiBJUEZUX0ZBRl9VRFBfSERSIGFuZCBJUEZUX0ZBRl9TQ1RQ
X0hEUiwgdGhvdWdoIGtleWUtPmlwX3Byb3RvY29sIHN0aWxsDQo+IHJlc3RyaWN0cyB0aGUgcnVs
ZSB0byBJUFBST1RPX1VEUCkuDQoNCkZvciBORVRDIHN3aXRjaCwgaXQgb25seSBzdXBwb3J0cyB0
d28gdHlwZXMgb2YgTDQgaGVhZGVyLCBvbmUgaXMgVURQIChiaXQgMTEpLA0KdGhlIG90aGVyIGlz
IFRDUCAoYml0IDEwKSwgc28gaXQgaXMgZmluZSB0byBzZXQgdGhlIFVEUCBoZWFkZXIgYml0IChi
aXQgMTEpIGluIHRoZQ0KSVBGVF9GQUZfTDRfQ09ERSBtYXNrLiBJUEZUX0ZBRl9TQ1RQX0hEUiBp
cyBub3Qgc3VwcG9ydGVkLCBzbyB0aGVyZSBpcw0Kbm8gbmVlZCB0byB3b3JyeSBhYm91dCBpdC4N
Cg0KDQoNCg0KTlhQIENvbmZpZGVudGlhbA0K
