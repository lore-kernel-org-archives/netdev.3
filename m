Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC436DA0D;
	Tue, 13 Oct 2026 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857865; cv=fail; b=cLiaeIOyui6bCChLYhm+x/itGLBr8Qrezse2p5y3yKUWtO9TRDJaH98wiaTsZJ4bZuvdVt9GugON4xkvisNobWjpa370Gf6mwDWFowVErwQtRlRE2syi0+bz2mx3gem0lwq2FQUa7f32or7eeN9E81MCAwa35QnG14Aos6zgHzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857865; c=relaxed/simple;
	bh=T9Jyb1n4fQ5wc7ZoHSCBAJxEnVRqtB7BxHq1wmC10Ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmA4M1+Fg2i25dD8CUn/kbWj+5qO4ElYv3D4KX9BAaGvzYfg8YrxWOhLU6BxBSjPK8LMgWtLOS8j7B8mgdRXxZOqViLTsPWdYmXraJEBZOl2d+l/8TGHYhAuiJ3ETz8v5nKdwxsAs+Qd7BSCntXa9S5gPEJ7NRdtgLbLr0ZJKEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ka0OEmn6; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ka0OEmn6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPKEbW6jNJJxhXhgABqsb54LgclJltV6ow3gET1VLiA+v0mVExba7EgXEGKIFJAKjiRUIx3nIrFNW0e2vysAnxLFCeehaTg3POQ0IPjuRRVjIDmTSmx14yMkYpY1euv9VqMGJYynH2+sPn7m6BlAxmFrrO9T5Rdi8rDbUpjzvFeaAWkvrU591IxeDnQ9kZnpXSHKwI+nHh7DsRviz86pOIhDreHnE31vjrsQXf5pwSUrvlcl26TQTutj1VXpZviGhGwp//p/wgNSvpBEJLLXV+n9LmhV2vQj7dr8/6uHIOM59kU8z3+deEsdH2t+gC2aQgEbg+fGgIaXpO7XddozDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9Jyb1n4fQ5wc7ZoHSCBAJxEnVRqtB7BxHq1wmC10Ko=;
 b=dTuAfo1EZ/9dtEzUIW4AIpQMECPMaC8BXXJD5EeqnsQ3zsgvjKqGDwte7qxBmDJbDOMWdIGCWvbm/a9KarDVoRuYg+orgeTWK9XMqovl4UGi7UGKmESEpWXXLPQ976wY1pyNJUQ2hF676NU//i7DShlPdfVV7vID/BSMVuA2MU1KGahy0cjuyLevgW5fNtE/Gam+0VpVDAH0VYwHOXFp7mRzw8Q3DgRwxh9ZTgWn8R2Ng5hQEuT4eSgpihIHx/jGpPkhJ0uaCUsN0gtVIORJk/uZavRN0tgOAVKhx/uX6GxNen6flF3uA8m51B6fX8JeKgjGLgd1LDvMO+Hhghs3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9Jyb1n4fQ5wc7ZoHSCBAJxEnVRqtB7BxHq1wmC10Ko=;
 b=Ka0OEmn6k4K3qxG+ByjngVo9wCEsM26PAzTuuL1ZHQgXPbpXQj+mIKZcB/qczFsatpYOtPlf9dy09JBR5rmkLdZ2eJpA2QYSPabC99rWgeUJ0eblFJ98/xKphMar4/C/ZSWS6yMjp9eoNYbE64mjbyHKUan30o1w1XWWG+EClx2nbSggS50/IuQ9LB4PkxlCrSQgiBVxfJlYOW4tB2mK1/gTW7mF2o6Yyc12ERbWuyC/+uW82NjZQ5pekmXpdhFYSk5Vztj4FeDIhnyENsXJH+CMGvSw+cO6NUzpSRk8Rs3xOAhmfKKRxYjG/Bos/zO7S8Wz/0utsLwOq1N0FhM9Rg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by CPJPR04MB008549.eurprd04.prod.outlook.com (2603:10a6:380:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 02:17:40 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 02:17:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Topic: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Index:
 AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5AgAAWOgCAABaJ8IAAgr2AgAIhnoCACbi8oIAHPoGAgACYykA=
Date: Tue, 13 Oct 2026 02:17:39 +0000
Message-ID:
 <AS4PR04MB9338A3A7CF410D39C6B49969889E2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <d8e72848-1611-4d6e-b3e8-17013bce7948@nabladev.com>
 <AS4PR04MB9338F6AFA7DF06339C54DD1288932@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <c4c6953e-c831-4b1f-8600-67c226384876@nabladev.com>
In-Reply-To: <c4c6953e-c831-4b1f-8600-67c226384876@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|CPJPR04MB008549:EE_
x-ms-office365-filtering-correlation-id: 58afab5f-cedd-4078-5481-08df28d02806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|19092799006|1800799024|366016|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 FAg69EJsKgnPYYpPmM9srK6PSl73RbmFhCkCqhpgZTMeOvvl7JTWg+dgRpHxUeGut6Eeij6zH8Oobx6ZrIYX+yV3TUdNQRml22Fh5yxdqKB9Yu7wVJ6MaUv1GinKtrUI829H4HiZwajI2fPZkKOkpL/Bmr3BI9l1n3j8jZmuOzfa/srfZkuTaSNKL8p3x7Sf4WluR4mVNnlgwUraON6tEjlNwRUE6p6VE5AwssNS9mcg8JxN19TCAyEl+quCIGPbV3rj08vhwbx22yYXhfsz/hOwnDozj0I+PfXrRg9C7WS+jm1ApTSbjBJr0vyOUCPBDmGszXtR34ha2xFlnv4QmJcCx6rh8oXJ3i+Lq2+gi85O0EKUqUJY4ZyrTpU9vnvuJ/8/N9LNnIpeAkNhtBJxfXgk+qJD/LibzmAIRGfmHnOnvg3ulJCJ2m7JpQOyGqkRXasjHSWk/h5uwOednryuwLY65QSGRXSktptULsSOJIpByUn6vHfue5jeQWueYBsxpPJAakWn+Ts7hA5LhBujtNHI+tB8BulGW45BPr76QVze2/k4mrKuBfzeHtGB4VVRseZllczhM893rfJUseK6FMBNWV1tbTyHVSgsAYoHcm5+tzYhiD7vH4/s0DvXaGObKcebHIqTniOLDQtP7vWEhoVxoraDkpUQgZ5I/gwha7pTt/aEoVtFcgMlcskFsBKtqlOKz87yktGMCGO9ndlxrZamcQM7RZPsHO25m7DAcTA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXQwR0tqVGJmZVY3bXFWYlVFaGFHRnVEL0VPSkt3SjA1V1BraW10cnA3VFIv?=
 =?utf-8?B?cWhyclhRTWEzQ2NBeFpLZnoyRkxGbkUwREhFeHFjUmFsR2E0N1E4bkZRR0oy?=
 =?utf-8?B?VkJhb1grbk9kaWNINHJyTnlDTnJiNlYyOExKWWxFTHg0QXFWT1JWV3B1NzY3?=
 =?utf-8?B?cWZjM20wazdjRjB5UGIzY2lIY0hGYTY0bGdvWXJhOVJ0QVVQbXBESWQwRmJO?=
 =?utf-8?B?Wkd4OHVGNCtqcnJTZ3dueGE0TzZmQTgxRC9zV2VxU3RkMlVMeEZEQ2JERXlJ?=
 =?utf-8?B?aEFvODZUNUFtVmdlazREU1pscUU4K2I4cDhXRHN1M21GZDIrcjNxSW1GMlpT?=
 =?utf-8?B?UDlPTSttZ0x4b3I5MWw3aEp0VWE1QnVySlI5OUhsdXExS3JwcUt5dEJlQXpv?=
 =?utf-8?B?cnBuN24yckV4cmhsWFlHOVZGdlVzT2IraE1UZ2MrL2RxRWx6TnFtQkZLL2xV?=
 =?utf-8?B?aFFrTnZ6SW5SZEtkV2xIRFh6bkk5UExqL2lsU1lHcGRTSllYQlJ0WDF1Qit1?=
 =?utf-8?B?ZUoyRGNBbVBxR1d1ektWYkJzam5xd1VKWHYyZ3J1eDNhVjNkc0p2dk9Hc0ND?=
 =?utf-8?B?aE1Dc2RxV3p4dEh0R2R2YVVscGYwaitna1JNNGF0b0N3Ky9zSUJqbG1SWktk?=
 =?utf-8?B?NDFGWEhoM1Y5VFBieWhHclBuQnV1Um5DQW1rWU5Fd2tWRVZ6WFdyYkZ3UVNq?=
 =?utf-8?B?V2RlVkNtd0taWklka3BUdS9mbDZmZ0w2Wkd3QWhJWllieFlTNGhSc3JScnV1?=
 =?utf-8?B?Y2x4RTZsb3NKeDB5ampIc2U3Y052Zjh6YkY5ZHp5bHVhRUlSVnlsditCdWtw?=
 =?utf-8?B?L2pZRjh3UW1lQU1sblkrOEc0T3Y4MnFUZzViUU1obnRMNU9ZeXJ0ZWhNcHF3?=
 =?utf-8?B?RHJTVjBBMnJFNks4UUxpNnhTZWtPeEpIdkh4Y0VYOGJBQ3RFeXRHVVRYWTBV?=
 =?utf-8?B?Mi9xcDBnZnRVYVZFUjM3KzV5eDhwZG8zOUkxSTF6QVE3ZDFJMEI4UDB5VXli?=
 =?utf-8?B?Z0FJWWpGUWpTU1E3N1FYNThBZXhqbE1BOHkybDc1bXhVSmtIWnRyT0pSME9w?=
 =?utf-8?B?YmJGazMwOGdYRnBlS0t3UStNZTFFSXRhQWFOcmtDam1NUGxSdzh6NFcvTVVj?=
 =?utf-8?B?S0VFVS92akRxYlhnaFhFVXhxdC8wcjRaSjFTeTV5bllLY2h4NjRPTW1CT3hB?=
 =?utf-8?B?QVA2a2lBczU4aWVESXRHNjZMeTFuT3B5VWdtM0RtT0NzY3ZId3hRb095N212?=
 =?utf-8?B?Y1dkWWFVZ3J6MzE0Tzk3WVlPRm9Jb1VrVnk2WXF0TGtlRXZNOUtNSFowWWE2?=
 =?utf-8?B?aUVsY0NYbzdIaEVQQkxVbmtCMHhSZjg1NEdtMG5pVHREdDJTakZJY0FWS01z?=
 =?utf-8?B?NU4xU0phNEpuTkw4Z2lSZ3V3Rm1mUW04SFpqbzRJak52aFJLM09hclhGeTVB?=
 =?utf-8?B?aUxyc3IrYmdIQjRJeFVMeHFvZmovYkJTd0RuaGFvNm5tVHB5bzNzWHV2V2JN?=
 =?utf-8?B?b21nSHV5dW1oT3ozc1ErTHZtWTErekc0bG1iVFdLbHhtVVU4eUxDcTVCTVBt?=
 =?utf-8?B?VGhMWHhwSDBuZzdCQXBIeHZkY204TVlydDNXT1BBUFVtZjkycWFRZk82NmZL?=
 =?utf-8?B?Z3JWd0RSdmZiOWZxZUVxNjkzRE5yZUxvcEVzUW5YYWgvZmFqb2lQRExmbkZh?=
 =?utf-8?B?U2xBbWFjQUhuU2pZQ1pVTzkwU3AxSWpPTS8zaEI0NGE4bzRuMURSZFhEczBy?=
 =?utf-8?B?TVV3QzZSWDFteVhDenpNNnRZVk4xemIxV1dpd2xTQ2hrdjVPWjJDbXBzZFBh?=
 =?utf-8?B?aU4wL0VXNjVmUElGN0l2VlpIS1BEODhFdzZ1ZFphWTdsd3o3amhXVllMRmMx?=
 =?utf-8?B?V2Q1MXZNT09yTmtxa0E4VWRGM3RKNE13dWNRNTAvOUhmeWRWR0dIWkNPM0l1?=
 =?utf-8?B?Y0Q0ZmFwOWFyQitQLytnSlJ0NUZIYmxkRFN5YWtWVXpoa1dyejRLcTB6Zmdx?=
 =?utf-8?B?RU80dnZTL1I4azB5aTFBRVBPTGdCaTUxN2Y5NEx6SVhwMmVlQlBJaDYzbEpz?=
 =?utf-8?B?aWNUdTBzNWZyYWtTbzdDK1Y2ZnY2dXhubXc1WTZTZlZVdVYzWktYM0FOcEJ6?=
 =?utf-8?B?T29mWVBvMjFGRjI4WE13WE1sUm9mMUF6Wkwya1lEeWFuS0JkdUQwUXVXeGs2?=
 =?utf-8?B?K1RiWjFHVUxMTmhHZ3pPQ202TzA5VDdlemlvWUF5OEhwTkNUY0pjSzhTZERx?=
 =?utf-8?B?NFVjK0RIWUUzd3prU1ZZdTAzN0pNVll4OUtqYm9pUktIejc1Skl2YlI5bkNR?=
 =?utf-8?Q?FVMNVPu9gLmhm/Q7lc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58afab5f-cedd-4078-5481-08df28d02806
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 02:17:39.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhl0b6+6tWy9W+TTLxzqz4E5QHB4f8D3JqF3syoj0N0oTxo1vyKP+x+YE0B3X9ki6SLT0RkeEQhuuSogBdayew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPJPR04MB008549

PiA+Pj4+IENsYXJrIGhlbHBlZCBtZWFzdXJlIHRoZSBNREMgcmF0ZSBvbiB0aGUgOTUgRVZLIGJv
YXJkIHRoaXMgbW9ybmluZywNCj4gPj4+PiBhbmQgdGhlIHJlc3VsdCB3YXMgNjQ0S0h6LCB3aGlj
aCBpcyBjb25zaXN0ZW50IHdpdGggdGhlIHRoZW9yZXRpY2FsDQo+ID4+Pj4gdmFsdWUuIFRoZSBz
Y29wZSdzIGFjY3VyYWN5IG9yIG90aGVyIGZhY3RvcnMgbWF5IGJlIGNhdXNpbmcgeW91IHRvDQo+
ID4+Pj4gb2JzZXJ2ZSBhIHJhdGUgb2YgNTU4a0h6Lg0KPiA+Pj4NCj4gPj4+IFRoYXQgNjQ0IGtI
eiBhbmQgNTU4IGtIeiBkaWZmZXJzIHRvbyBtdWNoIHRvIGJlIGFuIGVxdWlwbWVudA0KPiA+Pj4g
bWlzY2FsaWJyYXRpb24gLyBtaXN1c2UuDQo+ID4+DQo+ID4+IEZvciB0aGUgc2FrZSBvZiBjb21w
bGV0ZW5lc3MsIHRoZSBNWDk1IEIwIEkgaGF2ZSBvbiBteSBkZXNrIG5vdw0KPiA+PiBwcmludHMg
dGhpcyBpbg0KPiA+PiBTTToNCj4gPj4NCj4gPj4gICA+JCBjbG9jay5yDQo+ID4+IC4uLg0KPiA+
PiAwOTc6IGJ1c25ldGNtaXggICAgICAgICAgID0gIG9uLCAgMTMzMzMzMzMzSHoNCj4gPj4gMDk4
OiBlbmV0ICAgICAgICAgICAgICAgICA9ICBvbiwgIDY2NjY2NjY2Nkh6DQo+ID4+IDA5OTogZW5l
dHBoeXRlc3QyMDBtICAgICAgPSAgb24sICAgMjQwMDAwMDBIeg0KPiA+PiAxMDA6IGVuZXRwaHl0
ZXN0NTAwbSAgICAgID0gIG9uLCAgIDI0MDAwMDAwSHoNCj4gPj4gMTAxOiBlbmV0cGh5dGVzdDY2
N20gICAgICA9ICBvbiwgICAyNDAwMDAwMEh6DQo+ID4+IDEwMjogZW5ldHJlZiAgICAgICAgICAg
ICAgPSAgb24sICAyNTAwMDAwMDBIeg0KPiA+PiAxMDM6IGVuZXR0aW1lcjEgICAgICAgICAgID0g
IG9uLCAgIDI0MDAwMDAwSHoNCj4gPj4NCj4gPj4gQW5kIHRoZSBjeWNsZSB0aW1lIG9mIE1EQyBp
cyAxLjhtcyAsIHdoaWNoIGlzIHNvbWUgNTUwIGtIeiAuDQo+ID4NCj4gPiBUaGUgZW5ldCBjbG9j
ayBpcyB0aGUgc291cmNlIG9mIE5FVEMgc3lzdGVtIGNsb2NrLCBhbmQgdGhlcmUgaXMgYSAxLzIN
Cj4gPiBkaXZpc29yIGluc2lkZSB0aGUgTkVUQ01JWCwgc28gdGhlIE5FVEMgc3lzdGVtIGNsb2Nr
IGlzIDMzMyBNSHouDQo+ID4gU28gdGhlIE1EQyBjbG9jayBzaG91bGQgYmUgNjQ0IEtIeiwgdGhl
IGZyZXF1ZW5jeSBtZWFzdXJlZCBieSBDbGFyayBpbg0KPiA+IHRoZSBhdHRhY2htZW50IGlzIGlu
ZGVlZCA2NDRrSHouDQo+IElzIHRoZXJlIG1heWJlIGFueSBvdGhlciBjbG9jayBzb3VyY2UgdGhh
dCBtaWdodCBmZWVkIHRoZSBNREMgY2xvY2sgb24NCj4gTVg5NSBCMCwgdGhhdCBjb3VsZCBleHBs
YWluIHRoZSA1NTgga0h6IEkgb2JzZXJ2ZSA/DQoNCkkgZG8gbm90IHRoaW5rIHNvLiBJZiB0aGF0
J3MgdGhlIGNhc2UsIHRoZW4gc2V0dGluZyB0aGUgZGl2aXNvciB0byA2NiB3b3VsZCBub3QNCnJl
c3VsdCBpbiBhIE1EQyBjbG9jayBvZiAyLjUgTUh6Lg0KPiANCj4gSSBhcG9sb2dpemUgZm9yIG15
IGxhdGUgcmVwbHksIEkgYW0gY3VycmVudGx5IGNhdGNoaW5nIHVwIG9uIGVtYWlsLg0KPiANCj4g
VGhhbmsgeW91IGZvciB5b3VyIGhlbHAgIQ0K
