Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409627A477
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201681; cv=fail; b=Pl98RSG8nOCIEI+q9Q2tDwvZed4Uf2S9txrVocGjx83znqZB7vNj6KJl8w9LXrsYdkt61yLXFDwCE3fEqyudAj894f0tcmSzj3JlNFhv24gBp+FDRMJFKDdwrACiiSqnr0kjOFUB9ldtkWVayrFjcOf3ZxSuEdW0uN/7wVjOklw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201681; c=relaxed/simple;
	bh=oze0cA5d7C0f+C70V3bTYvRlpqwAdXMVDkDD3PnwqyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZajGR8RuJXA/HeE2ZDVhPBPl2KhtJWcoJS5+hal+0DNtFRVoogqKpE/QxCX3WrREDeLNRcS0ASpcgeTIo0KI2LQOQspQSefcJPvyjZum+NjuVDF27Yhb/9axjzUBKr/xIO1kwBwQP/SW7HE6B1Sxx3H92xSnMqANn+6ZKtxq04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=f88IFz9r; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="f88IFz9r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qklnCbQpRFtw29Vs2JiZyyvw3lAWMwVaKMmrjY2FUkA71TElEq+kOBDZ0dwnkHc1SBN/pJRbEYhA1keVyyz9WOXJpVo8kgUJok0nso0q9qcEXZWaCuiCz0NE5qPjF2WtsSd+hGIZC9j7R/hKYc64mg+kmk3X4bExT37F3WdrFJ/M6NUwIM7TnlwvEWcIE1xu3583PqnZnWH/bug3iWri/A66rVF7Ueq3J4CpE4NiGBwEv2ESmSF62FILoR0pGxTPaQNkj74qjUSQDrcDR+oBLHXb+HFga3JsGkFPtBRC/T/2zX5YmVvFiYWPEZil24xLkO1kZ5mJ8GqOVdvWTFPOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oze0cA5d7C0f+C70V3bTYvRlpqwAdXMVDkDD3PnwqyU=;
 b=zHAyuF6dLJL7POil9+NDjBA51v07oKUwwnp8Jxbqt2w0BkSoQeIwoR3M2HLx1eAlfhp+VuJ2iFch3nWTLA8Dc5iUoBPKz+f3P7BWKMwmEGsYaTGKnpqjXamLyrlvo3qgLAU0FbV4Dfxii6HEruCIhTebRAYPNvQM862s2yf11qB9FDiCEahcdIuQYwGic8VIedero7YFEercoROV+PsmDskjjtpPylX9YZMAHnStj9gI+PW+mCyvXIMtnE1ADIt9yVvnXoA4FAOkouFUzr8S+60ucMhlWSFp+PJIqrrOuCdFCx38r7+8HRKsRkmchiRHPZYHTe5Lmpe8zp5GuV6WDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oze0cA5d7C0f+C70V3bTYvRlpqwAdXMVDkDD3PnwqyU=;
 b=f88IFz9rk5fx5koTtTGzpqYx2kUZLV+bnrASn+Iok7fM5kpgxbYCqbXaQ6HX3e30N04BRP7PQLcT5xlNxp62VrsyuGft5bOsS7U0GaoQ6R0t924Y/WS7ftFsTIlJ5iWhj17p9AgP8WBjriis9zOymueBsb7/ZoSgX7KVywKkx+Fy2xa0b+rwe+XNJtwQTcRTTamU6Ni4wwLIP6rBmrJGmC2fyl9yhkfvm4pRYAa+bjuaEMZvJDf/ViZiKhqGgp6REW3/5qmk2oLOvJEHblvIt9uLuujXGIc8UfB6ZhTPEESTqhvKpigdFuB6DOQCQmocDiQFpvDXf0mn+NJvjnfzMQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB7226.namprd03.prod.outlook.com (2603:10b6:8:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 01:21:14 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 01:21:13 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "G Thomas, Rohan"
	<rohan.g.thomas@altera.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: Re: [PATCH net] net: stmmac: Fix E2E delay mechanism
Thread-Topic: [PATCH net] net: stmmac: Fix E2E delay mechanism
Thread-Index: AQHdHW9C1LxS6/B90Eil795H6yg8praBfqMAgAClPwA=
Date: Tue, 28 Jul 2026 01:21:12 +0000
Message-ID: <96829971-f936-4465-9d77-5d9a36765165@altera.com>
References:
 <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <CGME20260727152949eucas1p2a8679cd740d0bccf89db7d0af8904225@eucas1p2.samsung.com>
 <amd5aoSrOSPrcB5e@AMDC4622.eu.corp.samsungelectronics.net>
In-Reply-To: <amd5aoSrOSPrcB5e@AMDC4622.eu.corp.samsungelectronics.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB7226:EE_
x-ms-office365-filtering-correlation-id: 53561ed1-8d93-4dae-523d-08deec468368
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|18002099003|55112099003|22082099003|56012099006|4143699003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 WyJUxoUpHgDP28kEjBNNuVrJUuIaYCJggwbqW2W2k3sS+CVVBEs9JB5YZ9nwSFAeJfuGh3VwSqtqVWDqstOYBST+0uYrfMdglvL///2dAlOR6RGD1bCaLlrU4AIkz2YXX2vgSAemE2KKLjqRE2o0GOLH3WMVC6z65Z8SVLXS38vMqqIyrHQEg6qG7vDpt/eUeEGNvB4S6uFGkr7pnGn7LNEkOLMnR7mBkOIJuiZsaZue2u9s6KTQJ5kTEqCoAPm+DT6S54pF7OXBR2oeTKi3yQPDloEOycCWdHFPtdHnyauSukuiHgzK+zvSnN7ipNymIKl6TPO3Uy6tVe0cqWT0LZq+HpIgHiS5eYcfichVpJE4fDznCME57l7b/9VIqrFTtXym8i0d60tkfKWRjo0BDXzcWytnfLhrD94WQL7eaFdeTJc1TzGuhmfkpOQuEipfOqFWhuL44o+uJuMaEk/H4KVY9C2uDAEyxo7oAkhJOgUwhgU8yxg2U2qZJDFPSvwbO/jaz6gUS0U9JlTzJHlZrJcHRFbxMAKNycAgejuGoh++pjrO6axabA8glAtRC+mdNcDKkfha72pMrQpVvI+wUJ38Fh9FscPhXJF5UzNc5JgZ3dRXt/s/R3m1/7J5vQQiWETtFnHaxfwujldyJ1enyZVBFzKgNv8A7Iczs/jJRxWt/R6POeIFoxyR47mc6PRRr+MlIAJ6iGRWUXkW0iu+xw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(18002099003)(55112099003)(22082099003)(56012099006)(4143699003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW9KNGZBZWhwS0kwMFdqbWlxRnptMHBlYUVQTlUzelFuVnU1UkQ0VXN2bXBk?=
 =?utf-8?B?R1ZhZTVJWVlrVlo5VzBRa2pxMWF2Wk5oc0FYemU2QlJ1aSs5QzNPQlU0Y21W?=
 =?utf-8?B?NXFCQ1FxSWpsUjJQaTBNOFg5MEVaWWJIU2s1aDB1R1VWeExPNUJmL0REcVBB?=
 =?utf-8?B?S0JQenp2TVRmM3BRQ0V1eU5tWTh3OGpBbmVibXp3ckVvaTYzdTRtbmxwU016?=
 =?utf-8?B?aEdUaGpNdVBwNlBhTWNyZk9VaHpLR2lwSTdIOFVyNXNiWnlqQ1hMTEdxNzNG?=
 =?utf-8?B?am1yWThoM09XVFBhYUNnYkVNL2RYYU1hMVd0aEVaaTMwbWNBZ25DVWJFT29Z?=
 =?utf-8?B?ZlpZcmVmY01MOHJ0UHVEaFFWV01tUUE5S25kYndzWmVXUlBQLzRVQytad3c5?=
 =?utf-8?B?YTBhQk5PdUQxUm10Wk1UQzBZYVNlZGhMRXBiSDBxbTBsUmtQQXArK2Jwb2NP?=
 =?utf-8?B?NXl6SWdvOC9ycjMyWm96K2RUS2dmRW9USDlNSkxaY3Y0cFlHTVNNUzdNcktY?=
 =?utf-8?B?MFo4dVlXMVdpZzZsaHBGQTNTbm9PRGxzS2V0bnR0RURKTUVZRURxQUdsbExD?=
 =?utf-8?B?bkxxTWVMVytiTFN6Si93aG9ReDNxd3lyRWhxeGpha0tzUS90dkRrTGFXQmNP?=
 =?utf-8?B?bzhodmJLekh0cFMwS2VwVEQ2MHAxNEJsOTRiL3NSWHQ0RjM0YnVuKzZ0MDI5?=
 =?utf-8?B?M1NLUUdtZm9KT3JCaGc0aVV2eDJ0UmMyNUpISEZwVll6cCthdFU2cTB0V2Nz?=
 =?utf-8?B?Uk5ibUlZbnhjbUZrSytaSXZ4WXhUcDdlVWxvSTg3c0ovZ2dNcXFqTXVqV2dB?=
 =?utf-8?B?NU5MV0I3QW00SFRZZllndEhaS3cvQ0FUVlJZMWtneFB0Wk9vclM4UnNHK2lO?=
 =?utf-8?B?S0ZUNnJ5Nm9XRERZNWNJZXB6N0lwNVZHZXRoa01TbU1aMjNLSVVWeE4wRktp?=
 =?utf-8?B?eDhrNXliOHhPNFNDLzVpTjFSQW94RjBsUUpYTWY0K3hVOXZkM211RG1XdzFQ?=
 =?utf-8?B?ekpkVlpiT1hpZS9HVUpIM1VwOXd3WFRKcWFFQXZDQWZSakg0U1NVQ0dQcTJE?=
 =?utf-8?B?ZmFNbjJYZEI0MUZza1ZGb2RPUVZMRlBsSjB4VWtRZHVDL3RINUU3STlYaEhm?=
 =?utf-8?B?dXpvNVF6T2lhcmdhckhPVEdEalRiK1pzNENyYzArT1U0cjZNTmRDTDNNaURp?=
 =?utf-8?B?c2JQdXJNS3N4MnBvRkpmL0ZUemFqOGN2dlRMNGNaRGFYWmVsenVtVnF1UWZj?=
 =?utf-8?B?VEhJcEZWY3NTaDFIRzM1dC85MXcyUTg0ZEJzV3R6TVV3R0UxUWFhWnVWQlZy?=
 =?utf-8?B?VTgzOG5LMCtrWEd0WjZhUzZxS00vUGVna0g1VFJKN2Z1am1YVVRkWnRNQTRS?=
 =?utf-8?B?ZXE5anoxTnBTUXBoVUQ5VUR2NGNPZS8yRzl5Ni9hOGVIOXR5WGsyNGNOdmpB?=
 =?utf-8?B?bXhpRHhhQm1SQ2RXWThDVXo0V2Z6TTY5bVVtZGo1THBGdXdlM0pjU3RDak4w?=
 =?utf-8?B?VzVKZzdIQW91V0xZOUcvaGxpTzFCdEhBeW41TGRxNUwxSVZmVzBIQWlCb3p0?=
 =?utf-8?B?N1Uwb2w1YU5Ja2RqYzY0czNxek0vbEdrSVk3TEFIZjBMMlJBcWhSL2NVQWM0?=
 =?utf-8?B?Q0NqaytZaXNMKysyNmdSSVRZVE81dDc1VjFoU0dxTWRJaWFkTHZ5T0pCNUVs?=
 =?utf-8?B?bzFUR3JzTkhVTUFPRWRzNklSZHcyc1FaRStyQlM2MGc2SjVVR25FYUZocWFt?=
 =?utf-8?B?TFJTQ3JVS0ZwanpOS0hyczh1TXdTUnNKZ1VTNE9IQTF3TE16cDZDUVZ5N3F5?=
 =?utf-8?B?UlYwNWc5Vi8yczVEQVpCY1o0cGN0QmJlOTY5YUdnYjhaL05UQ0thaFNuTElD?=
 =?utf-8?B?TFFJRncrNFFoTkpuaDlucmZlRFg0VGVpTUZSZ0dZUU5IK0RJa1ZlVzRsSko4?=
 =?utf-8?B?YzVZdjNOc1FPR2JYeWxuMnpqWGl4MjdRNnBLWnZQOGpxTjVNekVRcWZwQ2dB?=
 =?utf-8?B?SWlkRXE3cHlXTklFY0U3VnFYRkxxYzA5L3NkdTRUc1h3cUdZWHVUYUJRMVNl?=
 =?utf-8?B?QVBnVWQ3L0cxejFBbDA5a1BNMjduQkhFWXpXZFp2MFV1ODg1Sm1YVjM5Vkdl?=
 =?utf-8?B?NFk2bnMzT1Joc09xR2JhTytkVE5IK3NZQmViZ0FZbkNyZDJYcllpWHJJaDQr?=
 =?utf-8?B?bzFqdTVxdHlVZ25hS0xoVnRCamVsZzRyY3Vmb0wvdHhHUkJkTFM3Y3ZnMHdT?=
 =?utf-8?B?ekxsWHhoTURMNHBQK0lyZzhBRW1YZ1dFdjMwd0VaVERFNTVRVWs1dnFYOHht?=
 =?utf-8?B?QUF6RGNxSVNZNklXYVdIZ3BZSHZKajhvdUtYd1Q0bXpQU0ZpZmZQSVZJQTBW?=
 =?utf-8?Q?2oVZHTEDJDzmOFBaG6CTbAgZjkdyZbpE8zEKCUnb3uWo2?=
x-ms-exchange-antispam-messagedata-1: 6SapXa+nbhCMl6+wjvQCTqVIIpG/F8CB8Xc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A53F6EB1E4B2D4EA7A5663DD5F69FFD@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53561ed1-8d93-4dae-523d-08deec468368
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 01:21:12.9352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXvsO/ZuN0u2nK/UlRFNZHRVocnPd0IeWQhI48hVZo8yAbzbukGEraz/a7kbU7r1lKBB7LYNBxJc43NV/j7Rxa4JZko8mYUF0XfoOSFdyxaTphFZ+JRhurusY9qYNs6vJk+q2mX/VHPeUQYRPvPnwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7226

T24gMjcvNy8yMDI2IDExOjI5IHBtLCBKYWt1YiBSYWN6eW5za2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gai5yYWN6eW5za2lAc2Ftc3VuZy5jb20uIExlYXJuIHdo
eSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24gXQ0KPiANCj4gT24gU3VuLCBKdWwgMjYsIDIwMjYgYXQgMDc6MjU6MjRQTSAt
MDcwMCwgbXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tIHdyb3Rl
Og0KPj4gRnJvbTogTmF6aW0gQW1pcnVsIDxtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNt
YWRlQGFsdGVyYS5jb20+DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1p
Y3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+PiBpbmRleCAyYTBkN2VmZjg4ZDMuLjI0ZDhjNmU5
ZjFkZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFj
L3N0bW1hY19tYWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3Rt
bWFjL3N0bW1hY19tYWluLmMNCj4+IEBAIC03NTUsNyArNzU1LDggQEAgc3RhdGljIGludCBzdG1t
YWNfaHd0c3RhbXBfc2V0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbmZpZy0+cnhfZmlsdGVyID0gSFdUU1RBTVBfRklMVEVSX1BUUF9WMl9FVkVO
VDsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgcHRwX3YyID0gUFRQX1RDUl9UU1ZFUjJFTkE7
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHNuYXBfdHlwZV9zZWwgPSBQVFBfVENSX1NOQVBU
WVBTRUxfMTsNCj4+IC0gICAgICAgICAgICAgICAgICAgICBpZiAocHJpdi0+c3lub3BzeXNfaWQg
PCBEV01BQ19DT1JFXzRfMTApDQo+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKHByaXYtPnN5
bm9wc3lzX2lkIDwgRFdNQUNfQ09SRV8zXzcwICYmDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICFwcml2LT5wbGF0LT5oYXNfeGdtYWMpDQo+IA0KPiBUaGlzIGNoYW5nZSBkb2VzIG5vdCBj
b21waWxlLCBhcyBoYXNfeGdtYWMgbm8gbG9uZ2VyIGV4aXN0cw0KPiBzaW5jZSAyNmFiOTgzMGJl
YWJkLiBQbGVhc2UgY2hlY2sgcGF0Y2h3b3JrIGZvciBtb3JlIGRldGFpbHMuDQo+IA0KPiBCdXQg
b24gbXkgdGVzdCBrZXJuZWwgNi4xOCBmcm9tIGEgd2hpbGUgYWdvIHdoZXJlIEUyRSBpcyBicm9r
ZW4sDQo+IGl0IGZpeGVzIHRoZSBpc3N1ZS4NCj4gU28gVGVzdGVkLWJ5IG1lIGJ1dCBub3QgcmVh
bGx5Lg0KPiANCj4gQlINCj4gSmFrdWIgUmFjenluc2tpDQo+IA0KPiANClRoYW5rcyBKYWt1YiEN
Cg0KTGV0IG1lIGZpeCBpdCBhbmQgcmVwb3N0IHdpdGggdjIuDQoNCkJSLA0KTmF6aW0NCg==
