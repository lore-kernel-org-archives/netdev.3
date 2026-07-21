Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42A2DF3D1
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612811; cv=fail; b=dS1+1KyoboE2/ddISnPNPsxtNYu6w0U9n+WWe0ZEcntQItwzKxB+vAP7hQ5xa0TQ6ef7nJAOq4Db21YOsk9NoJ04ntnc7Ktih1Ltu3kWvi9aGcGrgoFMtFbaRKtgksy+SxwGYzoZV0+1z8gzOwEfYJ2Pa8eZMJkdNxDlL4kYQ5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612811; c=relaxed/simple;
	bh=ziqmkGWoqxHE55Mc80pZ3WZ9NhYg2eXQAySrX5K4VbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Un0LeV/2RPuDg6R6KP6jeWPRF1vGGY5KDsyCaobWe1Gu0e9vwYDnv+g0My4ZZ/hJpnBWUtRwmv8Tx7ZoiMUlUhuq2wlYHTXya4eHdsDiKvavl2u4NZL6ZFkZuE+QuEi6Y29FD0E7MMOQ9QPSgI2UJOxqfp+ko+K9l1QLsabOvO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=u4SYJnGy; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u4SYJnGy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6M6NTTFVnQZPu+E0KZEJYznWLpfZk6p27b7jqdxXnWlsshECCg0+0inLMNh1Oqa3ytTKJVA1WPB3rHXxr044VMUc0AyNR+tO78bGLQes5Rg6Kd5QwuHV898mtcf1j+74ogeb67jRvjaIAoXb4+wtvXo5dQi7/9VPfO1DCUwSd2T94sRaXAZtlbvk7Q3M4tDutrz/XksXJlhsMSRBjTsQhpRrAZJ6QoR4pyJkl+X+HXZbrLOJs+AdV6scFvtwZ9Pb8p5Cq+2jqnf/EVMTXEeCrDyy4849AIRzt/hiUS4MU/jHwhB1TzmwEHa15/EXWvGaFsOQmqBYc1qVrGNgB7img==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziqmkGWoqxHE55Mc80pZ3WZ9NhYg2eXQAySrX5K4VbU=;
 b=cOue/oE2ZHkVc0uqbuXQBTuoLiqI9CC+qdAo/sWor0CwxsVSmVpSBf+ZvyI8qrNSRV9gGsDDAl5nEW2nRJL5N7x5NE65S/cFDisOR8Ec2OWl67OwW5SvDAT17/1oGrq1iJFED+LBPAoUpsqi5SCEnBP1ttNZ+e9V4npYWLTXlMMZIVT5paVQSTVZ6/KldQjOz9Pnarutq6xW9g1WEGlSgzI0A/mWUT43ALETZcElAUTxjmTAS0sQSsoCviNtMEQI5shLg6kt1n3dejVYnYFGMHOc6v35+3AJtWPF39x3mU9c4dLi55pOyg4JoHeXvDRaLFG0NtB+ixGqzyaVlxeBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziqmkGWoqxHE55Mc80pZ3WZ9NhYg2eXQAySrX5K4VbU=;
 b=u4SYJnGyjh/81pEgPPcJTPNQ7+UBxdZ13/AOOfaOewsgOv3BhP3xxjSGcCvrl10odBtzMw3heKUCd6Apg3CDiT0YukuuI/Ot2105PCMHVRRcjaMsflUusQNLgmAGA7ZRXJlBj9ZaVK7m7vpa8UUr3QUjt2pl3wHHD+RZBayTSsgkdngwj2GnVKBmgoyzff8gYz54F+w50/VtkFfV0vlJXS1P5PMgVdhT2el8Gur7NCCePY1KJjJj2BbCYIpK/dfroOGrheRYXE/q3KkMHCIstGvxSqNJh3IgluXkDRUicRCDtb8LK3MTzYUF1R0sXG4PynHrF85pWOD63nY1KYrq1w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS8PR04MB7701.eurprd04.prod.outlook.com
 (2603:10a6:20b:293::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 05:46:46 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 05:46:46 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH RESEND v4 net-next 07/14] net: enetc: differentiate
 phylink capabilities for pseudo-MAC and standalone MAC
Thread-Topic: [PATCH RESEND v4 net-next 07/14] net: enetc: differentiate
 phylink capabilities for pseudo-MAC and standalone MAC
Thread-Index: AQHdF+08LNaOEerxr0qjrlb5R3YIL7Z3PTKAgAA7kpA=
Date: Tue, 21 Jul 2026 05:46:46 +0000
Message-ID:
 <GV2PR04MB11739573C989BD91409EBBC5D88C22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-8-wei.fang@oss.nxp.com>
 <20260721021331.6E5DD1F00A3A@smtp.kernel.org>
In-Reply-To: <20260721021331.6E5DD1F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS8PR04MB7701:EE_
x-ms-office365-filtering-correlation-id: 951cec68-3205-4dce-0af7-08dee6eb7390
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|6133799003|4143699003|11063799006|10067099003|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ShnCQxTXeW12CJYPj1k8K4wDRoks/cQEIvkVTXTdwPhZEGdmWy/vh5WjmGVfB/OXkqGefo2/XHTOOWBhqugSfZz/nUIAAdi5q0lxtRSijt+ox6Cka4m3DiiuPdGH2vR+wFLr3NlLFwWLBdJRkAcqLYFtqLx7OfIZ1bzflpxaMMn5GVtDfb8LmtEfxArJLKbTESMXPHqKkssEPPilQjMs/womlZVZeEgFGmujJVKJiq6au+o0akMZOKzodPh/5kxLbh6IvvmVgvcJ7RpXlpGC665V/nBl0uo1O5AVp3PNzJCuvtZqKHS/pnAw6DDrx46DKlq3QOm0RPmMWR0cHETRecohXtYOy6LVPSnAt3hJIf/wfSvoNI1jWD/8Irh2DqyksZ+Qca4QnZkYmqmS0/9sHmapx2O4MBFI1RvUrCb2o50gW6nPoLsiR2zjboUWuLNHBOtYxFpkQxZuwfWJFDtryQpUYDUk8+P/GHhB15HLXOJK+8/NCLGWcMy/gKA19JP+Z4Lg4K8OvucQgF/wy4i5OYZAB1PJwGcDERyLHevjFxJqXNZRAoo23cHsdFmQu0h4tw7pgx5o8sc8VMLN15heWHLsSTkLLqvLX0PVX4ZS/SbsEJ8oNiaO7kHa3ApU985eZHDwbvw/dqdj/y7DxmbLFWYMdYJDvcbooomVV+9szaxoapft7fDC21oNyVm+vLUwlWC1fu0s0amJKYgkpx18PKViKLPhLr6nShpAHzL+9Hs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXFWelI1N0Q0Rm9NQWFEaFpESXpDMkxrKzYzSUJJSHlwNXpockJOZHZtdmdX?=
 =?utf-8?B?Q255YmhsM0lwTnkydHJSTjcyMnpETzBQYWhtakhtVG12UFkwTytZczdXYUtk?=
 =?utf-8?B?TkcvWHdLYlBxUHk0bWdnNEl2Y2dFUlBaeStzeFpFWU5oRVZNbWdWaDJxSktt?=
 =?utf-8?B?cHUrSjJnQzRtbk9BeVlWRGMzNWtjN25Dc1pNR2ZwSXZPdW9SWjdPbzE5WFda?=
 =?utf-8?B?RC9uRVdZQUNSb1VIcXN4MjB3YnovWmVYNHlIL0ZHdXM4RDZjUmtlNmQ3UExi?=
 =?utf-8?B?eXFVTWhmMGxmVko2Vk02NXZGVTFJSlFNRkVhd05WeCs0SytkcUpER3I4QnJo?=
 =?utf-8?B?Z1pvamVqdTFFenFEMnVXSFpjdjd6UXNBMGNOdndvaGlXTFFzVS9HNDZyYzB4?=
 =?utf-8?B?WmJWV0RsL01YWGVVeU1DeTBQV1RxY1NCYm5TNnI1SFVtNDMxcklSTmRwUE1p?=
 =?utf-8?B?TmV1ckxTVXZXUDN4SlcvaU9YWUlNd29XWThGR0NEM2FkbUV5bjRlMXMxcDA5?=
 =?utf-8?B?bWtVS0xoc3BKZjg4Mjdmd3JPWHE2Q2JhQlRjS2FPYXV5TDBKSmhIcGdtOGZW?=
 =?utf-8?B?YXExTmVMUlJoVk56a2hiY2orNkxiVWNQZEhEMUVhZUVveFZySk5SZE5rRU9V?=
 =?utf-8?B?aVFDT21aV3dEcWNVMDJNZHBnQ0d5WDdiaklZaW1QbGxvZ29xREtPUTdlclVy?=
 =?utf-8?B?SnhhbDJscmZpQlZMS1Jka285VmlNbmd1LzA2Q1dWb3BEYjNsaXF1eVVjMlY0?=
 =?utf-8?B?UytNK0h2K3FFdFJOMm1YVDU3TGR0MmJidlhFS3MzWE9vaXhKK3Z2S1VxNFpp?=
 =?utf-8?B?UWYwVC9JN2tlY3MxMlRSSnlFejNvRnpkWXNZSjZoSkg1YUp4Nko2S2RTZTRs?=
 =?utf-8?B?VUgzOTBOa09GU3dCSGZacXMwdTBMQlNsYS9RbE5PenNUNnBWTkxlNjRmQ3F3?=
 =?utf-8?B?M3dERStiSzFIdE1qQ054WnRncGwxMVRWUGxKRDA1TnE4c1lDSHBlWXBZRy9Q?=
 =?utf-8?B?N2Q3cnNuQ24waE5hMmpwb1FhQ1QzK0kyY2FMMzNKNFZJRGN1ai8vK0ZLT2pX?=
 =?utf-8?B?T1A4ZVc4M25KSGovMEh1TURNL0RoVjZBQXJveko1LzgwWWVqa1EwbjhwMkIw?=
 =?utf-8?B?M3ZvWUozMzZUM1VsendtMTZLcnVSQmhFMHF6UnBhU1lBUXBkazhiMzRYOUll?=
 =?utf-8?B?eCtvdkozWFNUTTUyaFFYL0thVlAvL1BxMGRoN2ZnTVZvYXl0aS9LTVBWejRv?=
 =?utf-8?B?WUhDU2dtU0ZpeWdMeDczOFRISjZJSXVQMXdjVGJ0RFhjTXJheVVZSWhXcm5G?=
 =?utf-8?B?M3lLakNsRG9ycFc5YzBibEtpOHNDUlkvZ2psTHRTYUNwd0YrSHZMQXFhZWV4?=
 =?utf-8?B?ZE5pcUhSM0I5eG1lWnJZNzFlRmZiMmlrSVVoTHY3ckg2VFF0MVFkdUdLSE5M?=
 =?utf-8?B?S2tydm5qUWZCblhYVTJYUURuNFlGeW5iWm9JREJqdDdXMzYwTG5DVnZKQ1g1?=
 =?utf-8?B?eXA5djRpTWEzS2poS1JYUlJWRWNoMThOQ1YwelJHL29BZEl0b3BpUGUzNmEy?=
 =?utf-8?B?Z3lCRHlwbEd2K3FDWld5WURRRmo2Y2RWb05KcGFMeGRLVG1kN293MkdyaXFD?=
 =?utf-8?B?eEE1VnBaYmR2bDBWUjhEQS9OamhLNUthM1BmZlNTc2hvdU9VYk05MHJUeHhS?=
 =?utf-8?B?dzhLZXJ3dXhNT2IrcG9LcXVRdjgxMHY2dXJ2ZkVBWnlNTVpra3lxbVBONHdR?=
 =?utf-8?B?OFcyb3JGSlBUVVE2QStwejVhcHZ6ZjlDb0JUaThXaWprUFBraUR6U0QvbVVz?=
 =?utf-8?B?NUlzRlpwbUdxRjliWWY5YnI2YlRXeE5MS3JYSG1OaVE5UTJ2UUJxQVdEN0t1?=
 =?utf-8?B?ckxsd2JDNGlIdTFMRGV5SVZwWU12Vit0MFc5MmVsdFZNQlJCc0VMNGt5WGVz?=
 =?utf-8?B?YlMyS2FnUHNScXNsb1FzeFR5ZjdpUm5id2JuMDBsNjNaUjNFcW0xRWhncFpS?=
 =?utf-8?B?VE5LSlhJSFJXZGxENnhpOWwrc1d2MEtzbElwenl4bVUvdFBOY3VjN0g2RUoy?=
 =?utf-8?B?aHpLVGxYbUoyUE55NmdPRStURUNqTGc3M2w0b0FQaG54VHpScU94ZUQ5a1BH?=
 =?utf-8?B?bGlVSy8xU3ZHcHEwOVBBa2FhU2pibEtRd2xDL3MyVmx4bWlaazFHVWxjbWRM?=
 =?utf-8?B?bEkvdS91N1FLU2VXT0N1SWNQcWhIMGZ3T0tEcUF5NHpURzhxL1NyZGRqcXNk?=
 =?utf-8?B?MHBMY1llSSt1MWZSLzlRbkk4OGtRT2hNT2tRbWRwQzBhNW5DemZsUzRERVBh?=
 =?utf-8?Q?9G1JwO0godYBkm2kyg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 951cec68-3205-4dce-0af7-08dee6eb7390
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 05:46:46.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xrj4r8HScLOO/UwJ108hEmoaVAxI86DflENJRUHTITo9Vgq16brNdErEfkMUCF4z1ey6cK0z0tCjPJ5PK203dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701

PiBbIC4uLiBdDQo+ID4gQEAgLTQwMCwyNSArNDAxLDQyIEBAIGludCBlbmV0Y19waHlsaW5rX2Ny
ZWF0ZShzdHJ1Y3QgZW5ldGNfbmRldl9wcml2DQo+ICpwcml2LCBzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUsDQo+ID4gIHsNCj4gWyAuLi4gXQ0KPiA+ICsJCWlmICghaXNfZW5ldGNfcmV2MShwcml2
LT5zaSkpIHsNCj4gPiArCQkJbWFjX2NhcHMgfD0gTUFDXzUwMDBGRCB8IE1BQ18xMDAwMEZEOw0K
PiA+ICsJCQlfX3NldF9iaXQoUEhZX0lOVEVSRkFDRV9NT0RFXzEwR0JBU0VSLA0KPiA+ICsJCQkJ
ICBwZi0+cGh5bGlua19jb25maWcuc3VwcG9ydGVkX2ludGVyZmFjZXMpOw0KPiA+ICsJCX0NCj4g
DQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhlIGNvbW1pdCBtZXNzYWdlIGV4cGxpY2l0bHkgc3Rh
dGVzIHRoYXQgMTBHQkFTRS1SIG1vZGUgaXMgbm90IHN1cHBvcnRlZCB5ZXQNCj4gYW5kIGlzIGFk
ZGVkIHNpbXBseSBhcyBwcmVwYXJhdGlvbi4NCj4gDQo+IFdpbGwgYWR2ZXJ0aXNpbmcgYW4gdW5z
dXBwb3J0ZWQgaW50ZXJmYWNlIG1vZGUgdG8gcGh5bGluayBpbg0KPiBlbmV0Y19waHlsaW5rX2Ny
ZWF0ZSgpIGNhdXNlIGl0IHRvIGFjY2VwdCBjb25maWd1cmF0aW9ucyBmb3IgaXQsIGxlYWRpbmcg
dG8gYQ0KPiBicm9rZW4gY29uZmlndXJhdGlvbiBzdGF0ZSBvciBhIGhhcmQgcHJvYmUgZmFpbHVy
ZSB3aGVuIGl0IGF0dGVtcHRzIHRvDQo+IGNvbmZpZ3VyZSB0aGUgTUFDIGFuZCBQQ1M/DQo+IA0K
DQpBcyB0aGUgY29tbWl0IG1lc3NhZ2Ugc3RhdGVkLCB0aGlzIGlzIHNpbXBseSBwcmVwYXJhdGlv
biBmb3IgMTBHQkFTRVIgbW9kZS4NClRoZSBwcm9iZSBzaG91bGQgZmFpbCBpZiB0aGUgcGh5LW1v
ZGUgaXMgc2V0IHRvICIxMGdiYXNlLXIiLCB3aGljaCBpcyBhIG5vcm1hbA0KYmVoYXZpb3IuIE5v
IGZpeGVkIGFyZSBuZWVkZWQgdG8gYmUgZml4ZWQgZm9yIHRoaXMuDQoNCg==
