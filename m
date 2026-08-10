Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F96361DB1
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786332838; cv=fail; b=KRRyyJ/vIwzd38pS38Q43QHWJqOSyu/KH8I08PtD13CfUC53cdcdt42qvLm9pagpieSsS1GC1ltEtV30+NJq9sw4LFMktvHoVYZN6OVdyTdvsk+DLqtnvnNIJ9v+5drr4FxiUNmDvUNUbEly6D50epuUGMDtn2gbEMffzJqxlh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786332838; c=relaxed/simple;
	bh=22yxGffuyA7DqE/hTRO0W2yzQqom3Ay2NfHZ9aJKgm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CyPaOV5388UNeX381texw6yGlFbbsHY9P83wugcflaAIhpM0keKeO2dJZjWba6b6fM/cNLnxe8gisGjMwh4JAa6fcBcdeZ4NjseXOrlo7eyRXas1edCOB/zVpepsTrZHhEnYd04JEOpLBG8v6fiamKPwgjQ7A9V11Ebl9uhRS5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LzauPLIF; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LzauPLIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3R/Ivlk85wEnIJT6A7MlH5y8LwgJYi0OG6TcfxQTQJq0kekzuNyN8sXyhcoeeAKtCHkovXud/BilHot6AzsaKNR+ZvKIG6XVIvtcIYJWOiRxDRw2u8yVOyIoSRzpaZh2VCavfS159qYjPonZw+10uJaaQYNjyHvXXNBHRazcUv9Mqt02eAKSSA6eS44m9X/pzwLKgZOKOHnFNyMFM30o0Rnc1X1MU0uSN2lWpdWc1ERcsQsI7tkVkQeJJZFq9geDO7iHbdSM9GigoU6v7dizHrRNS0RJOo5UwXEg6ZsTXjCU/Cu+49kIzZS2J/Sji+gjvw1BzxxbHH3EAvJFFwCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22yxGffuyA7DqE/hTRO0W2yzQqom3Ay2NfHZ9aJKgm4=;
 b=uyLwLr/Tml6uSL6mnMBxqUzYJrlIf3wdpRXevocxugXfJggQgUg2SIyaPgvrOkrJE5ebPubEQs7wN9o6qbZxMABabH4oIXgVbvh+OaIi7Nou5hN1NQMxtkBGJwdfbC7Qhw+mFUrvHTv2G9Y1qZV+YikPrkd86m98MnRDOp9/oULa9U4kAgf39Mjv3DKJvsQppELo/Yapqo7aHyN80yxZjXjBekmu30JL8UDBHB1x0xIZU2zdUpjzuIRV5wHSWxZSMUpcMh5GMc2jNp9yVKbEXYKUIfzIpiBDrZ7KzYDP6JSegTd2cSIfbScMQq4HAp90Pp8x+dDzb07kTul+lL3yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22yxGffuyA7DqE/hTRO0W2yzQqom3Ay2NfHZ9aJKgm4=;
 b=LzauPLIFp74gLvG9k/cFdcXkyP7PZ9mgIjoC3zK2QdhpPyNFdXlL5qlCNrWnnM7cz1HJlUTrZqlpLPlZELq96ENHkMWS+hCZMl3mALmsBRs3EMg77GK7OW3d+EjEAevejUyJmaBbzJ87SZ5RBjCp4X78bJ2hdA88xC8vBpwJu/LgWRWih1GaR5iwZWJlIQ04er8lttHUUKIi+xcTg3hi2cLzYgWB5tSbJGwf7u9gAHrQnxIBR4Hky4mpVT7x07Hji22/S0WUYmsnSc2dhIWrMQb2xkpZKwO1ypnVkkkSP1Ha6Y7fkFQSigc7bKTgbVB/2ZJ3yJmVFflNdCMdbtDrHw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS5PR04MB9756.eurprd04.prod.outlook.com
 (2603:10a6:20b:677::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:33:49 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 03:33:49 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 6/7] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Topic: [PATCH v2 net-next 6/7] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Index: AQHdJuSiaIAhMvKBpEasSbaxE0qI5raVDeOAgAGWbSA=
Date: Mon, 10 Aug 2026 03:33:48 +0000
Message-ID:
 <GV2PR04MB11739F3BD79B8F4904AAD682188DE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
 <20260808032146.2335723-8-wei.fang@oss.nxp.com>
 <20260809031907.888511F00A3D@smtp.kernel.org>
In-Reply-To: <20260809031907.888511F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS5PR04MB9756:EE_
x-ms-office365-filtering-correlation-id: 9fcd10ef-f1c4-4807-1c22-08def69030f4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 2BzxQRmbmb5Sqh+RGBoh7w4Cy2pzm8kKai6f2vvtpBB+gJvDnaZ2HFTfYDJ9JufUBIkdJe2GzOWcqvDz6J2cGQ7j8BW2yjfGFLWxPKViuz8vGj8QOyIrZrZZKiVZzR3FdDyQMi9gjlvC6pr45/jmucWqgd8hvSm4/Ait8dCz//409lDcQuOiiBJjk4tuz/swo4mSs+mY0Q/13DMfcbzEgNhRx1AMrkkYsPUjKc5dz45NxC70DfygSKqkK4vQhm1ru2Nl2ADCIaznUMI8SmDJlLdXaKgQ+0i0mo7ET/0EPax1+ibtdRSBbwAtHprT2pNFiYbIqhNZc3CFvgXYYMO8oH5iawURAL6051kC6MWpFMr36viNyo9VQWJF9hGL3Vi4RsLNmMyOCTtzFrjIv94F7HO8W+3KDk0A6637dHnkNhHe00tzweSYcPXqqRduKpjFOktCifg4md8KyXnjp3Kj5+YI68rWS1QZBIn/JqpuhiK2s5fG29/6cLRwjH8UWqeOPY3jAT2PTKLT/MecCfyQkNUwyzlMNV6/WuoRGbbSH2XAyvsKniRETlpd3f7+RoEGs2y7AnofnFF+PQYJHv7O2vDrwryUHn+lkRQP2BhF5xAVM9i7ZOoFLvgbn72cs2Mtkhd1AJ/qpBXtapU0uC558lqw8qKmN2Me8/ZWmbBKtmTh2cMEkmW6UVmUGvNB9kpMnBdQiqmz54TKsRYYYmbynmWQc9f6eK3fo0sS+qh3vLo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzdJK2t6WlJseUZ4Q0QvNHoxdUR3ei9RcDliWVhvUkVyYm5venppSS82MmNP?=
 =?utf-8?B?aEdjMU1ObWR1KzhTN2Ywc3dqTFRPY3Awc1NJTTgvblJFZnhOSzNsQjlsUW0r?=
 =?utf-8?B?WWJCR0dOa2ZVdFJlUDlLYkxqV2FUSzNZakZLMjk4VlJ5bG9nZDhyblcwdXhX?=
 =?utf-8?B?WkVnOU12MzFaYm9BU0RxTU1WWDBZUk9BaXhWN3p3ZU5TaHNJb3ppeHEvK0Jl?=
 =?utf-8?B?N21sYVdCRTgvdzI0SmdvYjl3cHJFTUF3MkNWOGNvSlBDMkhiUHo3OStJYi91?=
 =?utf-8?B?RzVUSzF2NUwra3dGWXRQeUhVRysycnZiR0RyVit3MUZXMGVYTTNRTmZyVlo3?=
 =?utf-8?B?QzIzVjlId1R3d0hzaUdYWUxubG9GUkNnYW5QcTNSTUI1Q3Jub1ZubGRWVk5z?=
 =?utf-8?B?bFk5aUFzTGRJeHVmeUdvMTB3OHowaE1oQituVm16L2pNdFVsamVjUEZZcFNo?=
 =?utf-8?B?cEViTnN4d2pneVdGWmtHLy9nZVQxOWcrSXJQSjkrLy9CWUxHMHdlMUpIOHZl?=
 =?utf-8?B?V0tBbFZNTWdHYnNaMUJPZStlNXVWNXJiS2NDOEdWRkhRMzdQang3RTdYQlpu?=
 =?utf-8?B?TlkzM2loKzNQVzArajFUVUxxT3c1RzBoZzdQSkVURFZWekMvREJCa00vRmFQ?=
 =?utf-8?B?T0s4bjhMc1lxV3VYMW5QUGtRUnU5OURVNkl1MlZ0VnVLdFlGcDd4MkZGcnFU?=
 =?utf-8?B?OW9SMksxLzVXaGZ6SEFkQ0pjWmoyOW9WL3IyWm14Y0U5cEwvT0tGNnM1Sm50?=
 =?utf-8?B?RUpHRmdoMTRsY1c5RWdUd2tOc2FKaUE1NEQ5S2U0QXlwZ0RENUl5NThac3R4?=
 =?utf-8?B?T2ZrNncvRy9manNYN2FQdkN5RjhvTEcyUjljNUMreFNPQUNPRVV1dUljSEg5?=
 =?utf-8?B?ZmxUTUpFa1ExQVhlSmtTNW9WWTdVZnlLK3ZQcVM1V3FqdE80cENIellPbUFD?=
 =?utf-8?B?dkw2UnJNNEFZK0ZxTmlmeDlXTnM4by92SUl5dW9zU3hIcUlSRFFWNEZBVXBs?=
 =?utf-8?B?Q1pTRVBpRzBpRENnblVEQ0h3aUc2RTFNSFo0SlVZWUcrQ1BlTG1jTmc3OW1V?=
 =?utf-8?B?dytROXJCM2pHU09MZThUam92OUhsa0ZOQm9BclhhaHcvdHlzcGRCaFdLS2h0?=
 =?utf-8?B?cU1mSkZjcWpxMjRIdzkzTHRqV0dkOG1jVDhOc2xvVWVidDJEa2cwWUM4OEE4?=
 =?utf-8?B?TlRkR3ppVXQwT1N2RVRvWE1yblo5d3ZGZUY4QkgwZmczRFBtOVZPcTBPTXVy?=
 =?utf-8?B?Y1Z4Y3BwaE54UG50MzErdEExbmFtRjh3S2tUbU1ORUFhbHFXdWtFM3JGM3NT?=
 =?utf-8?B?S3FWZ2ozRXYrRjNYdjZTa3E0c2puSEpuWU9rSnJDK3BZMWc4RlhuMHdmSXBt?=
 =?utf-8?B?WjQvd3M4cnZOdXNyb0pRZzM3MjVNRlBTcHhFUmVud0NFQUk3WlpUQWpVbnJK?=
 =?utf-8?B?MjVVZzlLY0NGVnF1QTVlN25YQXVWelQybk1yZDlEdnp0UDlpYTdWc0NRY1lJ?=
 =?utf-8?B?dFNYamEwM3ZrZFU4UElWTEdNL0FVZmtYeUhrbzVNZmZ4TzZRZlBNRUVxSkZr?=
 =?utf-8?B?M3Z2Sk1QcnJDeC9nRUtlNUdscmNRRW1uaGo5QU1lUDZNSEZIazF3ckZOYmxw?=
 =?utf-8?B?dFhYYW1VSThCaXF2LzZVd3dmWXFBVG8wWlJqTFhZMjNRUGN2d24xamtndVNT?=
 =?utf-8?B?NHpKcHUvcy9jNmZIVjJia1MvKzdxLzFiOGhFYkhaUkgybWtROUxWN1M1ZDAx?=
 =?utf-8?B?bG8ydU9uZXFidldFWnFHQVA5aDJRU3M5NjFFbzBhV2JEY1BSclJyN3Y3M0VS?=
 =?utf-8?B?RkdmekF5WjVEK3JuRFpxWEdlNjdyeHZZdnZZNHcvYW5uNU12ajJNMjVJUElZ?=
 =?utf-8?B?bndJY1ZKc2FtakpPZnZBVmtUZUovMDdwS2srQTNVVndETFkzOWh0YS83K2dT?=
 =?utf-8?B?WHoyYUlybXllb2p0MlFzYVRhQnYvWE1yQk94QVYwR1lRRnBXVkd5ZWRSN3J5?=
 =?utf-8?B?YURxUW5YOWJJaWVkbFB5VExmQ2Fad3RGRkE4ank4Nm5sUkw5NjR4c0xrQnB2?=
 =?utf-8?B?Y1drYVd5MlV6NTVmdzdOVnZpYjcva3o2QzF2NmRLNjN3ZlJGRmFyVXRZZHR0?=
 =?utf-8?B?UU4wbGdsV05QQjJPWENqaWh0UzNZZlBMdSs3Qk5pZVdsSmhoanN6S3BLR3Zx?=
 =?utf-8?B?SnU3RzFIaEozU1BYQnhqbExKU2tGbWpRRVhSY0IxZXBHYmhNOG4xQUd1eU5t?=
 =?utf-8?B?L05EQTdhY0d4cHo2UkhJNlMzQ0FJVFZVMzBQV0ZyeTh0ckxremFBVm1ITmxQ?=
 =?utf-8?Q?rj+RJ8rvBqqbYEyWaJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcd10ef-f1c4-4807-1c22-08def69030f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 03:33:48.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkU90luHhjCku+NPpkuIdavA6LW44ewV91Z7PRKLbM8nl6ONfuV8CUIyAI3Z4n1Or34jCZlujD/azDqTv9u0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9756

PiA+ICtzdGF0aWMgdm9pZCBuZXRjX3BvcnRfdHh0c3RhbXBfdHdvc3RlcChzdHJ1Y3QgbmV0Y19w
b3J0ICpucCwNCj4gPiArCQkJCSAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqbnNrYikNCj4gPiArew0K
PiA+ICsJREVDTEFSRV9CSVRNQVAodHNfcmVxX2lkX2JpdG1hcCwgTkVUQ19OVU1fVFNfUkVRX0lE
KTsNCj4gPiArCXN0cnVjdCBza19idWZmICpjbG9uZSA9IHNrYl9jbG9uZV9zayhuc2tiKTsNCj4g
PiArCXN0cnVjdCBuZXRjX3N3aXRjaCAqcHJpdiA9IG5wLT5zd2l0Y2hfcHJpdjsNCj4gPiArCXN0
cnVjdCBza19idWZmX2hlYWQgZnJlZV9saXN0Ow0KPiA+ICsJc3RydWN0IHNrX2J1ZmYgKnNrYiwg
KnNrYl90bXA7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHRzX3JlcV9pZDsNCj4gPiArCWludCBlcnIg
PSAwOw0KPiA+ICsNCj4gPiArCWlmICh1bmxpa2VseSghY2xvbmUpKQ0KPiA+ICsJCXJldHVybjsN
Cj4gPiArDQo+ID4gKwliaXRtYXBfemVybyh0c19yZXFfaWRfYml0bWFwLCBORVRDX05VTV9UU19S
RVFfSUQpOw0KPiA+ICsJX19za2JfcXVldWVfaGVhZF9pbml0KCZmcmVlX2xpc3QpOw0KPiA+ICsJ
c3Bpbl9sb2NrX2JoKCZucC0+dHN0YW1wX2xvY2spOw0KPiA+ICsNCj4gPiArCXNrYl9xdWV1ZV93
YWxrX3NhZmUoJm5wLT5za2JfdHh0c3RhbXBfcXVldWUsIHNrYiwgc2tiX3RtcCkgew0KPiA+ICsJ
CWlmICh0aW1lX2JlZm9yZShORVRDX1NLQl9DQihza2IpLT5wdHBfdHhfdGltZSArDQo+ID4gKwkJ
CQlORVRDX1RYVFNUQU1QX1RJTUVPVVQsIGppZmZpZXMpKSB7DQo+IA0KPiBbU2V2ZXJpdHk6IEhp
Z2hdDQo+IERvZXMgdGhpcyBsYXp5IGdhcmJhZ2UgY29sbGVjdGlvbiBvZiB0aW1lZC1vdXQgVFgg
U0tCcyBwZXJtYW5lbnRseSBsZWFrDQo+IHNvY2tldHMNCj4gYW5kIG5ldHdvcmsgbmFtZXNwYWNl
cz8NCj4gDQo+IFdoZW4gYSBmcmFtZSByZXF1ZXN0cyBhIHR3by1zdGVwIGhhcmR3YXJlIFRYIHRp
bWVzdGFtcCwgc2tiX2Nsb25lX3NrKCkgaXMNCj4gdXNlZCwNCj4gd2hpY2ggdGFrZXMgYSByZWZl
cmVuY2Ugb24gdGhlIHNvY2tldC4gSWYgdGhlIGZyYW1lIGlzIGRyb3BwZWQgaW4gc29mdHdhcmUN
Cj4gKGUuZy4sIGR1ZSB0byBxZGlzYyBkcm9wcyBvciBjb25nZXN0aW9uKSBiZWZvcmUgcmVhY2hp
bmcgdGhlIGhhcmR3YXJlLCB0aGUNCj4gaGFyZHdhcmUgbmV2ZXIgZ2VuZXJhdGVzIGEgdGltZXN0
YW1wIHJlc3BvbnNlLCBhbmQgdGhlIGNsb25lIHJlbWFpbnMgaW4NCj4gbnAtPnNrYl90eHRzdGFt
cF9xdWV1ZS4NCj4gDQo+IEJlY2F1c2UgdGhlIGRyaXZlciBvbmx5IGxhemlseSBjaGVja3MgZm9y
IHRpbWVkLW91dCBTS0JzIGhlcmUgd2hlbiBhIG5ldyBQVFANCj4gcGFja2V0IGlzIHRyYW5zbWl0
dGVkLCB0aGUgcXVldWUgd2lsbCBub3QgYmUgcHVyZ2VkIGlmIHRoZSBhcHBsaWNhdGlvbiBzdG9w
cw0KPiB0cmFuc21pdHRpbmcgb3IgY2xvc2VzIHRoZSBzb2NrZXQuIFRoZSBzdHJhbmRlZCBjbG9u
ZSBob2xkcyBhIHJlZmVyZW5jZSB0byB0aGUNCj4gc29ja2V0IGluZGVmaW5pdGVseSwgd2hpY2gg
aW4gdHVybiBwcmV2ZW50cyB0aGUgYXNzb2NpYXRlZCBuZXR3b3JrIG5hbWVzcGFjZQ0KPiBmcm9t
IGJlaW5nIGRlc3Ryb3llZC4NCg0KV2hlbiB0eF90eXBlIGlzIHNldCB0byBIV1RTVEFNUF9UWF9P
RkYsIG5wLT5za2JfdHh0c3RhbXBfcXVldWUgd2lsbA0KYmUgY2xlYXJlZC4gSWYgdGhlIGFwcGxp
Y2F0aW9uIGNsb3NlcyB0aGUgc29ja2V0LCB0eF90eXBlIHNob3VsZCBiZSBzZXQgdG8NCkhXVFNU
QU1QX1RYX09GRi4gSW4gdGhpcyBjYXNlLCBJIGRvbid0IHRoaW5rIGl0IGlzIGFuIGlzc3VlLg0K
DQo=
