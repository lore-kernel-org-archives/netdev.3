Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4B4A206F;
	Thu, 15 Oct 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070769; cv=fail; b=n/SbBcnvzdgV0Cmws4HzBtxPdKBRenk911G4iDvYJ/Quz/eo9RDd0+Z/mZ7b57V8p4FRTd6h5l5sQU6cUTENw8tanTlw28D4Ab89WYTJaiPNYYhCChtp0p1LrS9qaN5cUAlxVUPrNRBDElWrjuLj8VzjW9ltxh6wTaxY2qIH/sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070769; c=relaxed/simple;
	bh=m4uqxc1yNimz+FLs7Rp8ICmp7lGyg61nMcdUMY4QLXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NRdNwOu9fEEZiJavC+sikAMVNUDhIZUX5sufxNss+T9aQIrrYzWOBuObNUVkhc+PV92+Aj/kx/K1M1AQYS3cKcO+5+5OcgC2r9ZjMAsCRE4tv4YnaRYiJ+YJzpqYF/Uh6M9IXceTEoiJ3d/Jjf6OzLb5LQJBayD0e24k5smTR/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=icx1MzxA; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="icx1MzxA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXWmn4IeaUs4rHFJW1Yqpif9rynzkg8nvhyxlGbtwD6kMWrd8RObkAQC+++8m2qZPlPBhc1z44ckzi+KPiQJaosQa8UvaPgGS2EmgzOQXa0Q7wtpStHYaquib5cn7pILIq9/K/IVaaH4g/nBWcbo3+LWnqwDRE0/OBGtKroAiRgGTqK9yyLx7wnPsiqnbqHhb0QSplzKLpZhQKDw2+TnzcQS5OWy5OWstSjIhi7EzXYfuw41hWiNEoDDwWkdfuDDIW0D6QrwUqd/jc6jrqW4wN9C0iOzHj77PM3rWW2Qe/zUoboZVSHAGjnlYo3c/HcvbjZ99E1Q4Bf3KYQBkOYSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4uqxc1yNimz+FLs7Rp8ICmp7lGyg61nMcdUMY4QLXI=;
 b=TDEKFbrJAYNu/65hOS5b9w2eZrjUT4/NXyxsjNoesBtQeqD/i8y2oykzfysXePxXXkZ2Z8wgCUirTulDfsa8EhhXTEFqL6l2BRURRQwsdw+QIeHbTryonk9GfDP+puDyyw84VSDtaawZ6JDKrVjhHAfyqoaNywrv1u5BBYPNGaGq7wjUuz4VyFrLXeYsTBc3V3fbXrcNd8XTVdaFOdY3fNoE4op3JlxVHdaT0rLxDuzAp0Z//PhoOQdrtkbtbd2OnlCxkbGxVv4TyOA5vHdduehhZ9r3dkbVRyXwOto+3aMv0IXbDj9RFpLH2lTRsRiIufT4bcK9Z0fy52gSUhIs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4uqxc1yNimz+FLs7Rp8ICmp7lGyg61nMcdUMY4QLXI=;
 b=icx1MzxAq5KUpY3nOk6Mlu3dLcC5zAVf6cpfKjNrD2gGWVNT4VVojVsVHu++jglQwQ0K3+qPZaVplXDV4zXHEKsYuf8fC/hZMOgiMx/pMqBhvePwHmu5wZFUoIThtdHBpyv3lHkLuj1N1pGm1+gXvjIgWNUu+hYipMjMTgX6CwbJ2qR9h9691BpcL2iNqPdxC4Xm6uwDQgp5zR+tjoPaUPyRLLdNAkRco7bzigIP3Q3eQ5vx5EvhimEwvyIfnEYL7aAkF8lOP8/+suFmgQUcKDTHd8+Huf5eQH+qd1+lW9Qh0XI6QiubzU06nwROLJLGxfF0027RfINgSjLGP7QOYg==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by MA6PR04MB441830.eurprd04.prod.outlook.com
 (2603:10a6:250:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:26:04 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 13:26:04 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: kernel test robot <lkp@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, dl-S32
	<S32@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@kernel.org>, Russell King <linux@armlinux.org.uk>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Topic: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Index: AQHdWzYWe74LlF4VAU2QF0Eh2lZjvrb+TCEAgABOQRA=
Date: Thu, 15 Oct 2026 13:26:04 +0000
Message-ID:
 <GV2PR04MB11740DF323A5E1DCF2E8D6131969C2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References:
 <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>
 <202610151650.UHqL0Sb7-lkp@intel.com>
In-Reply-To: <202610151650.UHqL0Sb7-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-15T13:23:45.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|MA6PR04MB441830:EE_
x-ms-office365-filtering-correlation-id: 36e12091-a449-4096-5388-08df2abfdcc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|19092799006|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Cbh5iOxOQMf2HdBw1KJaEpYW/qlPfdEqLXKMssDsQxsHqyrtmpPCb/igHotbfLaKJOhHjbdkXrOKTqsMKRjXy55mO2Aoul5AtVBDPkRoLmkC3lmjCak5IJnhs47F1rwWwE7kiCd18rh2oy5+EUX88uHJtxiSdf0d3xwbFThCpll8l/BWeb3DIz1JtCOJHPR9b+A4fNn6zvRMdt4u9f8xuJyQZnAUeoCvMSnXteOITqUbZy/fGW7EHYGm8vwNW7D2yvKGM1zPtcwKgOv1qOJ/LqtAZINp91543XfWdWn1ECxKLTgkIdL5+YEr6bkL+8xNu/ubap+JUehnRqsYmh1bnd9XyCHklF8EPr1P7yr9sR5rrytKZxdtBjTnHrFkLVB/odsrOZQRD3jwgHB8uzkswdd+5qA/zBOaKn9dPg2uBnyM1XtsPb3f4ZP+T5T+yn2E9bDAxKGLtKAv5gYx0zflbIzuzFBZqMUdZo0C3IPJvghxYeW/dQSLB11F/odbQIp8APFOcDftj3kbyTCv7AVQ91d+OuwNlU4xWV6wDQiQv9gDc2d1+0Vo8iwWuE8hSzWOnbUl3m2RyCqe8RtwB4U6Qo2C7jv+Ko3NiNEnYvHhguKJSY3NOgj9QKy23gLhcBzLmTWhLTwQrRCbruz8J9jdo6mCPX6Bmf+fQHe5i5ArTSGgmCpiGoGNyCWrWXgLHVB/D6DRtXtSX9vLfE6gH+Q/sFwgjyaIeN2aB6VbsGDr1BU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(19092799006)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnNBNCs2am85UGNYcUpFOHdLdFZ4aGlnYmFmRC9XVDJjY3k4RmJ2b2dqczZP?=
 =?utf-8?B?RVJ3RHNaRkh5LytGU25rVHRYbVBmcXg1MDgrKzRCMmRvTVlMclY4Nmp0M3E3?=
 =?utf-8?B?MFE4SGI3cnFFaEVjOUtIeHlzcSt6MExnckJHeDZSdzY2Y2tJZWI1RnhtUzNE?=
 =?utf-8?B?WlF1RjhrZ0pXcTkzeC8zZXU0dzB6YlVrWVlWZkVBUzJLKzExY2ZBbUNiUkdT?=
 =?utf-8?B?bkRtOHIxZTlFMW9EejBFVG9qVytBOTk2WHkrWXAxY1oyWlA4dko5NFFZZGZK?=
 =?utf-8?B?b1dTcEFiSHhOMnhPTzROZHlnVHRBUlp1aENuV0hXWHlpZlpkbnNXanJ6RFd4?=
 =?utf-8?B?VW03NVduc3lmeFpuMDJtM0hpb3FiNEs3UHB5U056RkFKYXdZa1hRV3JXMERM?=
 =?utf-8?B?ME1RQzV3UEx0MkJZTU1jeDErVlJUc1F3cWpESlBYb0p3bHgrNnM3V0cxUU4w?=
 =?utf-8?B?UVdNZk0yMHpuemtGRjNpcjErSzZBRFQzR0QrcEh3YnBRSXNIbGdpZ0t5QnJQ?=
 =?utf-8?B?Tnppd3QvUG51OGk3OVdBUnpXY1F0YjE3TFdhdzNFeUphRmdqVEkwUFRlOHZ6?=
 =?utf-8?B?MmlOSEtHMG9scmhKSWlQWUhRcURXdFR1aTcrMGp5UFpYWFpOQitPUTMvd0tJ?=
 =?utf-8?B?d1NpRUhMTmNsQVR2Qk1NVGd3TlZsSHByTjZSYlB5cStPNlc5Qi9PL1ZhdFQ3?=
 =?utf-8?B?Ris2bGxUTUtiSnB5bFZueTJqOTQzZWFqU3BLTjZNY0o4WTR4UzYybEZjcHIv?=
 =?utf-8?B?bk1VZjRCZ1ZFcnZlMUszRUVaajRaZzhSbktpZ2RsN0tzOFJFaFZKQTVNbVN3?=
 =?utf-8?B?eC84L09LTFIwZWlZTUZjbUh0SjZqMlh3R3FEb0wyQ2R2aDFPR2tDWjkxVWpl?=
 =?utf-8?B?ZXVtK0JjZStLa3I4YkUzYXN4VVBBQWV4WHB5b3MzN1ZjeXpxWnhhbTBGdmJV?=
 =?utf-8?B?bUxGMlFuQlJBcHVsbHhpWXZ6czBFMnZjamR2VUYzL0dSZjJ3RE5EOS9FKzBI?=
 =?utf-8?B?bFplQnk5eGdUQ0NHSDh2aG8rcUgzeUUvWUNlblVCT0wwMzRkMzBreDJzQlNB?=
 =?utf-8?B?N1lqS3l5UkhNbmdBcUF6YWhKRElIL0NBOFJQd3FQRHVpY0dUZlJqWkQ4dno5?=
 =?utf-8?B?Q29SWE9GWU1QcjE4YWN2OUZMTzBzUnVvd2p6REJ3cEpYZnl3djdQM1FuMWxW?=
 =?utf-8?B?c2F2Y3lFLzJWZVN6SGJGRFlXL0pta3d5dG5WQmk3d1F2dStXak9HcWs0Z1V0?=
 =?utf-8?B?MFhHWkhhUHNGcS83M0lUZXNOZDFzOUE0N2liSlZ1OWR3MnNOZUNKa2p4NzJN?=
 =?utf-8?B?Ny9Sc3NSVENGUVl3K0hOTEx4QXFCaEYzRnhLdExlUUVlU3FmbFQrM1F3aDZY?=
 =?utf-8?B?US8zd3NRS3VJTzNmNE81cE5YVGg2ZGYrUDR2a0Y3TUlyOEsvQVZ4cU54Ty9U?=
 =?utf-8?B?OHRLQ2ZpSEVBNnI4OVBTZlptVjlxMHk5WXRpK1lwNDh5WGl4UHlZY0M1Mjhr?=
 =?utf-8?B?RFpHdjQ0WEJKWk1HWHFSWmtFK3Fab0hTcURvb0o5MTJWL3p1REhab2d1ajJI?=
 =?utf-8?B?MG9qY1MxN3F6S203ZlJCRzUzUkh3VXU1YUx6RS9uUEVtenpQTFd2RzNJS1ll?=
 =?utf-8?B?clovb2todnFlblRmWjlvQ3FCTmpybm9Mb0Roellvem1vNXdHTFhPVmt0c2Zq?=
 =?utf-8?B?d1BxWFY1dGF2L2F5RXk3dDlnTUFXZ2dkTk95eW5yMHJQdExONFFoU09nMDly?=
 =?utf-8?B?RGZ2R0lFcEZYVXIzdlJhZzFCMTRBY1o0TDZGMnBRK20rczhEYmlJdWlyZmx2?=
 =?utf-8?B?WVE3OHFDbGdCcElwd0g1ZCszb2g3T0tINlV6NnhjUXR0S1hlREhQczRManMy?=
 =?utf-8?B?b1BibjlETnNhWVRZNEFpUFlGMlBFZXVwSy8zc2xOZTZZdWdqWUZjazNuMU10?=
 =?utf-8?B?TnN5ZDNXeVQxVEdQNXBENzFsdEhlbkJJMU9rd1hkU21SVlUzMjdhWGhyQlQ3?=
 =?utf-8?B?aXNPQmR0Ky9zZnpaQ1NKeitNUkd1REE5WlZGeGlDc0UreHFYQTRKWkZxQSt3?=
 =?utf-8?B?djBHWllvWk04WDNnMTUyTUt6aWhGZUxwWTF2ZTF4cGlxMWRsNDg2ODlNWmNR?=
 =?utf-8?B?SitaZlQ2ZENqVWpHUThlM0hiZEd0bVR0VU4vTFd6SVB3ZUJQb011QWdya3Br?=
 =?utf-8?B?bTlrQUhTd3oySzM5dVBNaDhPZGZMZjIvMldrU2pzWEpTOTg4K2RGRndhaERK?=
 =?utf-8?B?eURwZWt1OVNTRGhiTVQ5b0ZIQjQ0SVN4dWgxV1dEY2FsS2d6VXRxamJScFBR?=
 =?utf-8?B?dU5VT1llQktaeTIyTGRpQzdNSCtPYWJWencrWmIzR3dPMEF0WnI5Zz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e12091-a449-4096-5388-08df2abfdcc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 13:26:04.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB1fCj0DhGyAtjfdY6mqxcIjEhU4GuNjunn2yRYx5SX2UltwznWlMDcpMgxBoe3PR70+178Ab3u4G+vC9NPx+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB441830

DQpOWFAgQ29uZmlkZW50aWFsDQpGcm9tOiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NClNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE1LCAyMDI2IDExOjQ0IEFNDQpbLi4uXQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYyIDEvNV0gbmV0OiBlbmV0YzogQWRkIHBzZXVk
by1NQUMgc3VwcG9ydCBmb3INCj4gRU5FVEN2NCBQb3J0cyB2aWEgYSBmaXhlZC1saW5rIG5vZGUN
Cj4NCj4gSGkgQ2xhdWRpdSwNCj4NCj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9s
bG93aW5nIGJ1aWxkIGVycm9yczoNCj4NCj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBuZXQt
bmV4dC9tYWluXQ0KPg0KPg0KDQpbLi4uXQ0KDQo+ID4+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYzo5NjM6MjogZXJyb3I6IGNhbGwNCj4gPj4gdG8gdW5k
ZWNsYXJlZCBmdW5jdGlvbiAnb2ZfY2hhbmdlc2V0X3JldmVydCc7IElTTyBDOTkgYW5kIGxhdGVy
IGRvDQo+ID4+IG5vdCBzdXBwb3J0IGltcGxpY2l0IGZ1bmN0aW9uIGRlY2xhcmF0aW9ucw0KPiA+
PiBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgICA5NjMgfCAgICAgICAg
IG9mX2NoYW5nZXNldF9yZXZlcnQocHJpdi0+cHBtX29jcyk7DQo+ICAgICAgICAgIHwgICAgICAg
ICBeDQoNCkknbSBsb29raW5nIGludG8gdGhpcywgcHJvYmFibHkgSSBuZWVkIHRvIGd1YXJkIHRo
ZSBvZl9jaGFuZ2VzZXRfKiBjYWxscyB3aXRoDQojaWZkZWZzIGluc2lkZSB0aGUgZHJpdmVyLg0K
