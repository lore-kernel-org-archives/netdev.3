Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B2348C7F
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 01:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314183; cv=fail; b=htPYjxf6XvczZ68mUl7SIa7LUepvAIi4PHf7upYwx5uLcGg/bfa9dIQk0ohXhkqZAujm+oMQsP8N/t1uwVy3f8nZ5MJUVROSfcNrKkSXFxhWPFfrhJr316oCnqcB5jKvp65RRjXL2tHlYCrXH6qB34tBTsufnO5mwtgi1YJnfk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314183; c=relaxed/simple;
	bh=bH4U8jJ8NTmUDRfuB76wpFvVoveXaEw98cQEdJ/Xmvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s2zKHUWBGt8wOyDNiWrSUioXDJhrmkGLYzpnd8B4dQ+/lzrG+8/H0PQXisVwLpD3HQc3FpxLgTLQ42CLzPgbJ0dvIffeH95WtH2KjnQ6Zr2/qb0rU4asGcwIHQgfNNpj8HeWlcjaKIrx89tYTgV5d+m6UfBaZwLS53UvkAi/Jo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cd0IhlJ0; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cd0IhlJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o52/xCD+T2Ky6FY7SvPISj74ZLIC5efP/0afLi8mkALRm2rUxL93yAH878VYJPsMOY91LRAYY1Rzmt7FYJ4g3pOPSyfxURS8Z3gQcUysBoHQfDTW1FAppSrQVE9ChYHAeS0Dc/1wQvY8filVUGFGa5KDBH/F8m9dSFUCT048h+mLCvP+D3zb7F4Pdw1b1PCFrgolnuKeP1/i6m5rxrUzbm2KP3pJBdevuvIarFEM21YztxLoY1SDtNypWAlvoO2NIPWfxuzBSa9fuFRNQcjDUuYUogI8ofZBseRvFkwM5WF9BgSytuHwa2JIDqxgckZQYoDsY38oRh3K2j43URDn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH4U8jJ8NTmUDRfuB76wpFvVoveXaEw98cQEdJ/Xmvg=;
 b=n3xLcHkR7aY29tS27xamzIltn9rqIzsZjg+UoUUsV66p/J8x8N4Upn3QAd+++kmTbAJNenAJbnl4WHPIJ2uTuX3AP5sK1e0PBXV6vVV4ZDVkvSJKx2xjJfmOUVys8yCyhurAaov0FkgSFOgH/6obchUZKbJCtIkct6A+xGSfuEQfrjB0iph0QmNSeBohjGNU72dNQQXkhm91oiE2SOiRi6HBsUIdbZTRd5qfIAfyBoyBvliZtvxli7awflUDJQHfc0erMyYnWV8VMTsVrqTy++WlQZ2ZF6giDcwBu8spHh6P23X5BB0qoFZQID/vZ/fEPd/5RsDKwIgQkKxw9qyP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH4U8jJ8NTmUDRfuB76wpFvVoveXaEw98cQEdJ/Xmvg=;
 b=cd0IhlJ0xXkvau5QwPYTYJvtcp+79ZOCmfKoVFjkwhmo4FXhYG+EgVi3sP81qhzQh3CVBC7UVEPDNXno3hPC2Z8mAvwEAKraPkuUPHxF+Px36KhA5mhRjfz6NzIUFRySE8+OQzjG/TuhjqlY+iW0D3ete32IMl5bui4v7Bx1jk/LrZG5yCXtBsBwavhk4UL/6te3Rhzba3FbMFrdLEP+Y52JHl8fm1kgaZyHYDaU8WGaxaGwcBWoISCmrJERf0sUqmtpP3ZvH3G/Gu7JrhC3+qE8wzgJx/XewjXugt8X7K5NAF8v/3wjDfHAYPq3So+mkEPkmulNeAUfrwX8HH6UQQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM9PR04MB7617.eurprd04.prod.outlook.com
 (2603:10a6:20b:286::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 01:56:13 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 01:56:13 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Linux Kernel Network Developers
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 1/8] ptp: netc: use
 ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Thread-Topic: [PATCH v3 net-next 1/8] ptp: netc: use
 ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Thread-Index: AQHdOSF2s760xtH4WkKkMD+rqmYMCba5YzYAgAEm+7A=
Date: Wed, 2 Sep 2026 01:56:13 +0000
Message-ID:
 <GV2PR04MB1173990C7B78E5A04779B435088B72@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
 <20260831082335.1184605-2-wei.fang@oss.nxp.com>
 <20260901082024.E6F931F000E9@smtp.kernel.org>
In-Reply-To: <20260901082024.E6F931F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM9PR04MB7617:EE_
x-ms-office365-filtering-correlation-id: c59e66e9-9789-4a5e-3876-08df08955e72
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|23010399003|376014|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 A94BVLgcaI9obL+TD4DsShiByRlbzHJ54OXf5N6NIUldfdaHjqd0ZgLX8tQoSPJhFxycFoagEKGRGYdjThLasAbH0RuBhVwpPqorBcOLh2LsZAdTqUH7Pxyw5AZTEq2gR2DkQM9PFGlROZlYUWjH370fZAgCtOgzxBxGsN0ZxHXZBZAFzSGId1LIYLmVVG+PuNpjbci4IXDah1lRZQBySwL6pb8tZtb6MRBCwkpkQ88J66nU7P40JGtT3EW24LjxyjxRCIIh2IEDVSePrhUkv4hxlsD0tXFk726j0Nn7JZCKkYbOlOhA9dV0FbHu/NKeNcsgU27TywS0rB7G2xRrBlAVcT+6u8BhZx2+RyGwLuQHmH3Y7SAwFNQ+zXOFWsxRUeAj8yblu/Hz38ix7KlXg5/OrHmsYZ4XODFmTTJUOb9bXTpg2kSOoyFkDZBV/itZMlYTpYb9FsYcEjnI6g5BJJqcVs2nmBALBEqBlOilmZy3mouo+nCH+TX8h6b2YgAhubs+BwNs33VhqO6MHvrpR3Mh6FXFmgIEkkWD6u9V47tZPyMTKLM3tUL0ltAiFQ4iP7NKQOMQuhOd49saCQl4M+DVH1tHitLWQmF/2KuFOairYwMSf8NQIfnrQPQl76sl3uNyv/r5bASuBQG82ayxaJBKAtgzpeAw33RU0NF7E4eQsJSY09Cgbvs1RuMGgmJaj+oijRXLMmlEOLApUitF47Vkeg5wfHCIoBPTJfAvQXg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmROb3ZhcUhDRlFJc1dpWW8zb0JtWHJmQkMxMitJZTZZVXhDbER1TkdjWjUr?=
 =?utf-8?B?bytGWCtmeTFuV0krZXFtYUh3em9oUStwUFNCVWljR041MnpuMlFGY1pRbHIy?=
 =?utf-8?B?SkJpbW9hQVk4UkxhRDNPdXNnSFZ5T1ZPR0IzTUpJTyt5T1BFa2pPNks1ZW9J?=
 =?utf-8?B?SUJzaXpUVElRTEdxMUtBcTJ0OHBGSkowc1RYbnpnTWlxVVI2NGdWSVJvWThJ?=
 =?utf-8?B?YjFkMXl3bk9nT2tBT1VRVEZhck1lU3JnRVBWeGNxOUgxaUpJTVAyU2U1NHNQ?=
 =?utf-8?B?eXhXbU1CNTJHRXlVSmZHWkpkbVFhZHlKdUhNN0NaK3lVY2MwNDdJYzFLUDNx?=
 =?utf-8?B?Nm5BMXVGZXFjVzQzQjBpTnJWdUI2eitvTXpxQzBpK0FmdjBKZjFyL1JNM3Qw?=
 =?utf-8?B?TVdhUG9rdFpWUXpmQjhiU3lRR3RJLzgwR0U0VFpubkdwTTlDK3Y2S3Bvd0Y2?=
 =?utf-8?B?dE1tNmwwVFNMUWhBdHhkNmxya1RsU3RXOXZHNWNhdFZ2NlpZdCs0M1R4N3VF?=
 =?utf-8?B?VW80TGk0TTJmNEdIZmtOV0FVVHRvanY4VXhIaTRvSTJ0dTNPbyt0R2kweE9U?=
 =?utf-8?B?d2dWeTlLM1hYN1B3b2VQY094Wkh3UWxldFJ6TU8yZ1pvQ0x1bElEb2dzVHJJ?=
 =?utf-8?B?WXREYUw3N09wYUFyQmc5QjdKQm10Mjk1ZmZ5T21BamVyNFp2SEJoNGpYalVR?=
 =?utf-8?B?UGFKb3BKb1pxZk83V0NPLzM0REFqQjJoWGtFdGs5OU1nVVZUQUNHSE5mSDNJ?=
 =?utf-8?B?TW1UMFk5N1NOTmtzK213blBLMkNMYyt0T1cwM09qTWlBaXBnNldHTW93TjFQ?=
 =?utf-8?B?T0dFWVJGeFh1NGNkazZnWVRUVmROcXBRRU5yUjc0Tm9mUVlSb2FGNmtFZk9o?=
 =?utf-8?B?Y01JMkVqbVNpSW9RTU1LcHRoT29SQXZLRzJtZlM4SWxBUUJlSWgxcGtWTUZl?=
 =?utf-8?B?ZU54c2phcDJQUGMrWGlCTlAvbnNUOTRLK2JrUnZnVUFVTTlMUWxJVDh6b2VF?=
 =?utf-8?B?OUNLMWRDdCtUb09kZ2YrbUs3STZuUm44MWV1SnpDZ00zZWJiVHVxWHRLc1Ey?=
 =?utf-8?B?UGZCOVo3b3ExZncya2dUOW8wZVc4MzZvWFRHVlQvMkdhUVIxSElNVDRNOXB4?=
 =?utf-8?B?dCs3Y010TkF6b3FyM0s1eUd0My9weUpNdlNPS0RXTHJCRFNlRkNZRGZ0K3JR?=
 =?utf-8?B?WksvZlJtcGxmVVc5UGpvZTc1ZEpZZGpMK2N0VzZTaFpxQ3BkYzRHWjJvRk43?=
 =?utf-8?B?Yjh6VTcvcjBDRDA2NkNHMW1lQ20vSExPV0J5b0Z1aFJWdjd0UjJzQVYwdGZQ?=
 =?utf-8?B?TWEySFlHa0JLdHpmdGR4WEljVWpyMTZOdDVhNHFvbVo2QnoreS81SW5hTFJ4?=
 =?utf-8?B?YlhqZDdrUWJRa1d1R2RwRlpLeDNiS1ljOG9TbWpweVdOc3c4NWpYZUM5dWV4?=
 =?utf-8?B?RFE0NkJKdXZDV1lYei9pZmlIcFA2bVJ6cGp2M3RSejNoQjlDQ2lmbFVIVndH?=
 =?utf-8?B?aXNCNkhqbk9TMytYWFJGd1NCNUN6cGY4cEgvYlErSDNNLzFmcDBnSlFmcEly?=
 =?utf-8?B?Ry9mV2hFWG9PeWwyNkNnaTJpbFdnL2hmYmxYY0pTOFZFcEtsWmZZZXF5MG5F?=
 =?utf-8?B?Q2E1RjFuN1gzdHMvN2tIdnc1ODBFZk9kb1lmUVRHckxGL3BNTnZRYncwSStJ?=
 =?utf-8?B?WGdTNTg4ZU1HS0VwMG5KQnFKUjI3TXpUc3ljRDVmazdRZ0VibWxjMjcxY0hj?=
 =?utf-8?B?bEtEMFU0WWRQVlNmM3ZjQ3pSdVIzalpENkhmMHV4cVZka0hIc24xb005M2Zk?=
 =?utf-8?B?anhqODd0V0VFOHF6WlFmYUNCNlRSU1JsYVBpemhDT0RmUTdlWjFxOFpZM2ZW?=
 =?utf-8?B?RFp1aGJPd1Ryb2NPOWpiODFtLzhlenRqZlZia3VnQTBTaElJVFd5WjRhSmJv?=
 =?utf-8?B?WVdnOXcvQkhCTEVDZ1hrWlRpTVpEK0dLbndJclNrYVVmZWtwK0Q5OVEzanZI?=
 =?utf-8?B?RGxSRjhBSE1rYWZwbFZzQ2x5TEhwdWxjY0JrTHd5bUI5U2xnY3UvcWdNaEF5?=
 =?utf-8?B?TDhoUnBDZGZuY3NkcDBJS3dQTU9laU9pZnBqZmJTWUtNNmV0cFJ6VElFNnpJ?=
 =?utf-8?B?VkVuelBkZ25FdU5rSkVkN2tsVzBxUitQTDlqSGk0Zi92QjUyZjZKK0diV1dJ?=
 =?utf-8?B?UmFRK0lhTE5JQkdkYjFKWDlKUjZvT2d6ME5nd1IzYjFGSU9LS2d2V1A4dE1H?=
 =?utf-8?B?RVdFUkk2ZnFiWUtCVUE4Q3NoUVBzaExyZ3RhZWxadTNRNFZSNmNTYzd4Q2xh?=
 =?utf-8?Q?3G4tQm/6CZuXV1hYMV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e66e9-9789-4a5e-3876-08df08955e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 01:56:13.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9rroXagtkYGCBldComI+fp/+wW2hjU+Z1a2Hdsvp7JYejp2jQWe2YfxRn32QhGEBIbX9sdcRYlKmeNJfmS5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

PiA+IEBAIC01MDAsMjIgKzQ3MywxOSBAQCBzdGF0aWMgdm9pZCBuZXRjX3RpbWVyX2hhbmRsZV9l
dHRzX2V2ZW50KHN0cnVjdA0KPiBuZXRjX3RpbWVyICpwcml2LCBpbnQgaW5kZXgsDQo+ID4gIAkJ
CQkJIGJvb2wgdXBkYXRlX2V2ZW50KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcHRwX2Nsb2NrX2V2
ZW50IGV2ZW50Ow0KPiA+IC0JdTMyIGV0dHNfbCA9IDAsIGV0dHNfaCA9IDA7DQo+ID4gKwl1NjQg
ZXR0cyA9IDA7DQo+ID4NCj4gPiAtCXdoaWxlIChuZXRjX3RpbWVyX3JkKHByaXYsIE5FVENfVE1S
X1NUQVQpICYgVE1SX1NUQVRfRVRTX1ZMRChpbmRleCkpDQo+IHsNCj4gPiAtCQlldHRzX2wgPSBu
ZXRjX3RpbWVyX3JkKHByaXYsIE5FVENfVE1SX0VUVFNfTChpbmRleCkpOw0KPiA+IC0JCWV0dHNf
aCA9IG5ldGNfdGltZXJfcmQocHJpdiwgTkVUQ19UTVJfRVRUU19IKGluZGV4KSk7DQo+ID4gLQl9
DQo+ID4gKwl3aGlsZSAobmV0Y190aW1lcl9yZChwcml2LCBORVRDX1RNUl9TVEFUKSAmIFRNUl9T
VEFUX0VUU19WTEQoaW5kZXgpKQ0KPiA+ICsJCWV0dHMgPSBuZXRjX3RpbWVyX3JkNjQocHJpdiwg
TkVUQ19UTVJfRVRUU19MKGluZGV4KSk7DQo+ID4NCj4gPiAgCS8qIEludmFsaWQgdGltZSBzdGFt
cCAqLw0KPiA+IC0JaWYgKCFldHRzX2wgJiYgIWV0dHNfaCkNCj4gPiArCWlmICghZXR0cykNCj4g
PiAgCQlyZXR1cm47DQo+ID4NCj4gPiAgCWlmICh1cGRhdGVfZXZlbnQpIHsNCj4gPiAgCQlldmVu
dC50eXBlID0gUFRQX0NMT0NLX0VYVFRTOw0KPiA+ICAJCWV2ZW50LmluZGV4ID0gaW5kZXg7DQo+
ID4gLQkJZXZlbnQudGltZXN0YW1wID0gKHU2NClldHRzX2ggPDwgMzI7DQo+ID4gLQkJZXZlbnQu
dGltZXN0YW1wIHw9IGV0dHNfbDsNCj4gPiArCQlldmVudC50aW1lc3RhbXAgPSBldHRzOw0KPiA+
ICAJCXB0cF9jbG9ja19ldmVudChwcml2LT5jbG9jaywgJmV2ZW50KTsNCj4gPiAgCX0NCj4gPiAg
fQ0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3Vl
LCBidXQgZG9lcyB0aGlzIGxvb3AgZGlzY2FyZCBhbGwgYnV0IHRoZSBsYXN0DQo+IHRpbWVzdGFt
cCBmcm9tIHRoZSBoYXJkd2FyZSBGSUZPPw0KPiANCj4gVGhlIHdoaWxlIGxvb3Agc3VjY2Vzc2Z1
bGx5IGRyYWlucyBtdWx0aXBsZSB0aW1lc3RhbXBzIGZyb20gdGhlIFRNUl9FVFRTDQo+IEZJRk8N
Cj4gaWYgdGhleSBhY2N1bXVsYXRlIGJlZm9yZSB0aGUgaW50ZXJydXB0IGlzIGhhbmRsZWQuIEhv
d2V2ZXIsIGJlY2F1c2UgZXR0cyBpcw0KPiBvdmVyd3JpdHRlbiBvbiBlYWNoIGl0ZXJhdGlvbiBh
bmQgcHRwX2Nsb2NrX2V2ZW50KCkgaXMgb25seSBjYWxsZWQgb25jZQ0KPiBhZnRlciB0aGUgbG9v
cCBjb21wbGV0ZXMsIGl0IGFwcGVhcnMgYW55IHByaW9yIGV4dGVybmFsIGV2ZW50cyBpbiB0aGUg
YmF0Y2gNCj4gYXJlIHNpbGVudGx5IGxvc3QuDQo+IA0KDQpUaGlzIGlzIGEgZmFsc2UgcG9zaXRp
dmUsIHRoZSBpbnRlbnRpb24gaXMgdG8gZ2V0IHRoZSBsYXN0IHRpbWVzdGFtcC4NCg0K
