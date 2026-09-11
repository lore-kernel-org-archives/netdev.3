Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3B59D636;
	Fri, 11 Sep 2026 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157864; cv=fail; b=CMuEJTAZOehl85ptKm/KiuyqVy4HUn4j+r7fioJQ+SwehSQjTKcU4BV+XOOLLgxQpvxkBRqOjb09FFjWcJOUmL3T6v1W2USUWxoDR+ZYsaqje/z/ybiEG+8tANnclA2wv9PShtQYV2rSX5xNOxu4juR7tMYq2sVxzsaQAQ0BoNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157864; c=relaxed/simple;
	bh=jd4tIYZBmGaWDakBVncTnzFplAJ6HwgaslG3ur10Xm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXlMeubQzHLpEPNYTlvPi2CbEcLH3pcAx2HAt4et4hovLv6tS1idAsGvPLNzsWsbuiOePxkF9ttMBe5SOPAiXn8d+YUflLp+gIF1w5EHeN+S0rw+DNVid7Mi/u2mG8tqm6x4YTJP5W+XtBy2ugB59F0q8dqw5b0nXJxngDXK148=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nb55HnX+; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nb55HnX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9U+11fs0/EH4ugW32er+h8ufCVlXZu0MPnkw5lo8hIat8REqkYfL2XjSjzomF2x6BtMq2P9eXybat+3KehK9+P4hq1pzFK+Kr4l4yehP+200ru9WfMLTAspRpqt4BtkZeX06iGOvhNe8TOFPPGm+3F4DLbq/MIrlnuOOv6V4FKGB7oYCSMJ1qlfayg0PCXjivi1WBKqKRNGDMCv4bO/DwpONKwkNE3aIpVhkfqyHhpfOyN5FBmWC8QUsXQhS1b4iDK8jhA49yXEOUrttwrCsamcBpaPWLiUQY8bKpOFO55Z2py4/dZfXu2svX/ecuQHWXUlm/Bym852IRbHpJReow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd4tIYZBmGaWDakBVncTnzFplAJ6HwgaslG3ur10Xm4=;
 b=qdpA6Wo4g0R+tHJsjRrqBXRyDrA0FCN552K7KvS/Jho1ON3sbxA7VakynusL/+kfnRZe1fgFICQHlrZfoHy87piw3Kg98egroXEEvFEd1IY7IKgxrhyDq7+9xnDMR5J/eRVtmJU5m1p/9Sl/eHuJGl4BO7/l5MeWH12zpoqz44KVCotK32j/VSgL6Ul8vDLzlBl5R+inKzSIpCTKp5TYuJv/LxASWaAHi1QyKt1mJ9J9ANpVxSN5EG2iiunIu4NmRB1R0K5Da4rZwSnmhyuMOzWIjyPQJV0SSVb0yQ6usH/K6aRq6i5TWOCAPnvJtZXUvNIHuaAr2PGXajqHVxAaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd4tIYZBmGaWDakBVncTnzFplAJ6HwgaslG3ur10Xm4=;
 b=nb55HnX+uYpMsn5hTqhJ/LG6UDqIhn5uiroBoBo8y1bONsYDoPaFIc5rikGBtj1KlwLuLJUstavSjCBaa74wSSAulhHtjf7tY39kz8keuBMfso8KXP7DlT9MSxjMfoEpzhFxDd4ziv3lxW0BEjWdBFiGJqqbg1aCga8i9zOMZQuU83f+lSBFDcXbtyiOx/nHYwMyXqRIpo9DE8BGloBDcUiqCDIYSVlslsAwCiFXTIlPMKmfPBjPEAy5FOn4n4VAmTwgfAFS2lKeo1yPAlNt38CnRSm+p9YGtjdHPfN+d5ihiCbFGLOa8Nbh8u+qRuw1EqFft0Nb1UomNBtXCwXa1A==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by DBBPR04MB7946.eurprd04.prod.outlook.com
 (2603:10a6:10:1ec::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 20:17:38 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:17:38 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: Wei Fang <wei.fang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
Thread-Topic: [PATCH v4 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
Thread-Index: AQHdQEcdTad/7fPaNkOM6nanLWWCn7bJ0jMw
Date: Fri, 11 Sep 2026 20:17:38 +0000
Message-ID:
 <GV2PR04MB1174092070555DBE69BF8FDBA96BE2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
 <20260909100733.1139689-12-wei.fang@oss.nxp.com>
In-Reply-To: <20260909100733.1139689-12-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-11T20:08:57.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: 329b1f2f-f193-4405-bed1-08df1041b98d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021|10067099003|921020|11063799006|5023799004;
x-microsoft-antispam-message-info:
 9PwYAqS8fosbWGiaXd9MP590oZ+llBBca4e9vmzup32nfwHrMMxbi+1c7nDhpT2QyDk1srThC681aqFbjr2GqdFhtlMxLLXohfmjajmk6iFCHv87+2Lk3biVloTi9XYeZ5OD6yDCSWTGJoAqlPrWpEdcb3eVEF5Tf6sWo7D77QTAqIogFb/2Fl9QVqxNLQoBqMnS+aiFLCY7ODV7JGLHrGC+wa26G/oE0qr/e43BTv/mczAX8mLi+0pZs1dT9yFKuuBbnscb+28Kwycmst1G1v9gWiST7pJZPHefB/6qkmQTg9G9FMYcyN9Gh53f3AGvGLBCDrpo7KQOLgI9+Ofcso2LrmFAZm2U0c12cAl6BADl6xq8ovOjGnnQm/NyqOFC9a7ymwi+bv0TXHWn2surbVSq2RJmeuv5zBtcbl4xFsG0swaU3dPC2Z5MH3Pnd1DAjracI8TCid/D2cmH7yALJkl6dzVNBDRrX85BARLLJotDENfQ82PnN+Vv2veZNyppJifPe6ynNYmcmfciG3aXelFdCSuKJfodDWrxln7YaZrzMj9/cpubJ8Ne5nGP7/OAnkfVlaodniNiyepQfY/12nLbJgXHsRu3STR+jXxzj4DxhdMkPNFGxNLrl8mXiSPxZr1f8MjXsbNmxx88H8F42nBbTc91vAUZm06v9AjgcMgOTc7iAnPU9kSsAfS9T5SU5n5+PMtaE6CLWNu5Cbtt0N6WVZIdJzffFZkDfZeTY1LH7qU40pOCO/G7O94V8WqK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(10067099003)(921020)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2VMUStuWlFwUEFuUC9QRDJwaENLNjJ1SEJsOGFrcEw3c3NnQ0l6aTVNVURs?=
 =?utf-8?B?Rms5RUxWNndndzRwbkw0bDdESldJeTNIcGl2dEJNUmVta001Z3ZMc2hjbkNi?=
 =?utf-8?B?My90dkQ2RFZHUFZCL2N4a1VQSVF0WU96bUlDdjM3dXY4ZUpETUF4WUhnME4r?=
 =?utf-8?B?VXh5U1hkWS9BaGtRMVB6d0xZdExpakl6eGZKVmtHNU5sNnh3ZU5sYmNpbDVR?=
 =?utf-8?B?WDVJTDBuSUcyOWRoNEVnanBhdXg0M0YyKzZobUsvMXFtNURBRWd4dzRrWDc1?=
 =?utf-8?B?SVFJdkFXTjZlYm93K3ljN2FVb1BqQ1AvRGZaU0UxaFBSK1JYM2dHamwrczlv?=
 =?utf-8?B?azJuaitLcnZGTkxGdmZtNG81ZlVBMStGL0ZuWGtTcG1YUmlJMWljb2w0TWN5?=
 =?utf-8?B?MXpDTzVybzlrRUEzclpXTVcrT2cyR1NndlRhUXpJbEtWUVo4NVpxdGJiSENN?=
 =?utf-8?B?SFJENEJqdE9tNkZYWUQ1RjFBNEh5cWVvbUJ4TGFVMHVweDEwUUpZRkExdEJQ?=
 =?utf-8?B?cVlBLzBieVRmV3NDZG1vNXMzZ0ZFWm9HMWRFMjFCWnluM1RyS2c2YVJpaWxm?=
 =?utf-8?B?dHVBS0FEM2M1WG80L1R5MVllYm83ZjNZR05JSFh2UWRTNVJxbDhSVkIvQjJ6?=
 =?utf-8?B?UkxLbDM2WU5JR1RaVnJ5VVZaczY2cyswMnBzZE5ZZzN5MGVIREgzaFRFcitz?=
 =?utf-8?B?RmZhdjVjQTJkRFlhdjJOQjFmdS9vMzJoRktRMUJtZitJMWk0eTBVOWNtRkNF?=
 =?utf-8?B?aExWZUZIQjFBSjBjZm9CZ1F5UWRRN1RzQ2RtUXRwQ0lYMTZic3YwVEpQTDFX?=
 =?utf-8?B?b281Z2M1T0tsaVdiSDZza1BFamlBQlpwSzZUZ3QydTZWd0NXVkM3ZEtIaGhw?=
 =?utf-8?B?b1RRVVp6ejdHVXJDMDBwKzhrSTJaQXBwRW15WDN6dGFlV3J5L2FhTy91S3R3?=
 =?utf-8?B?V0l6akpNVWRTLzEvYVN4eG9BRjNrRThhNTAwaDNrOGNpczhId3F4T2h0Mjll?=
 =?utf-8?B?SDMwTEpLb1pPRW1BQmtuQm1reU8yUUo5Rmo5eEZvQUpPU2taMWZjVUVpZHVP?=
 =?utf-8?B?RU9TeGxFMTRBU25VY0JhTUxQTStIaWt3TmwyUkxxbldnakpsS0w1VnVpTzMy?=
 =?utf-8?B?d2daZEo3YUZPb1NSbTkyOFo2UUw3c28yN2xicmowaHJnYkNGU3A3TGVXVjdj?=
 =?utf-8?B?R2s4L2hnVjF6Vm5mcVRlRWxNK3cxNGlmbUFUdXhncGViazhlZCtOOG00alBB?=
 =?utf-8?B?c2J3angrRGp0SkRxRGRQZ2lDYk11czJ0NWYvZ2FkYVVHeElwbW9hK0g2Y3Vt?=
 =?utf-8?B?clhwTzhCRGdUY2JWRkhRWWM2ZWRST2hjNmFxNEp5RGExN0U5V2JVajNqdkdu?=
 =?utf-8?B?ZVZpZE5QOVdEbkNGQ2FNTzhrUTkxT3RvZis2bFlITzNDZlBVbnFldThCZ0pJ?=
 =?utf-8?B?QitHbmRvQjdhYnVQMnBaVzhTWGt0Tk9kdkExRGNiVDFDc1U0RGJyUU8xUito?=
 =?utf-8?B?Zm5OYXoyUGhNNzBpL3dNckpFaVN4R0JzQ1NKQitRQWdUZGFiZE5idXE0N0U4?=
 =?utf-8?B?S2QwWThxMDBocHZVR2hneVlWL2pCOXlKK1ZsNjk2RkxQNVNab2ljNTY2Rkdu?=
 =?utf-8?B?UVZmWHdidmtMUjdRcUg4dEswMXFuU1JhNW4zcGU0ZnBuWE1aRXl2amN4bzFR?=
 =?utf-8?B?b3hkVHBML0ZGQjBjUTd6MU53Ly9GZkYrc015NkJlMHNyejZrRHFYTmMyVmtV?=
 =?utf-8?B?L3BUSkNWb1Q1NGxIZU5zNEtIYjU5VjM2TlZzenNuMUQxTFNLNE5SUmFsNXBR?=
 =?utf-8?B?UDlhK0hkTnQ0VlNhT0lDa0YyblJ1L3JTU3BySnlJMzhSSmEwSlgxN1JLRE5I?=
 =?utf-8?B?czF3TVB3UitTa2RXK3Z4UFk3eENHaHZZbU1nRGtKM2pKWDhyN1RjdC9uMDN2?=
 =?utf-8?B?K2c1cmdaaVpzNGcyNkVyYzFsdDk4K2pOK3BwMUttSzkxK0h1SGJMM2VpSkJh?=
 =?utf-8?B?MDFtUlRJQ1djMUs3U3hTdkp5eU1raHQxUW9XdUZQa2VLWlZ0RjIxU3E5TmV3?=
 =?utf-8?B?RFFFNXhYQzQwV0syYVFmUHNWRk9leWJzWHNvYkRBTVpESHpobDdubTg3Yldn?=
 =?utf-8?B?cWZad00vbUJlT0ZaeDVjTVljbHI0TUZxNytLc3RhVjBBbm1OdHU2bkxmYXo5?=
 =?utf-8?B?YkFjbE5NYnNzZWJvcE5xTk5Mb09LdTVyYU51Y3FUdm9HR3VhMjZJTHNSWlhp?=
 =?utf-8?B?M2RDQnBDUlFvZHVHRHIzUVdyV0tHcFNNcFovenlSQ2p0Z2pKRjB1MW84c0VB?=
 =?utf-8?B?V1B0dUdKNHk1cUsxR2tYZFhBcVdtQXpGblJnQ01KYXZSVnZldWF1dz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b1f2f-f193-4405-bed1-08df1041b98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:17:38.1191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dh7SBBRKgOIi/c10uxhnDSEokJG7e1BxsJOZNs7OC1mZSBtqZ2aYEd5//ea0NEd7ePZIHs4Ga/7Lkb6wMDq3lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFdlaSBGYW5nIChPU1MpIDx3ZWkuZmFuZ0Bvc3MubnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgOSwgMjAyNiAxOjA3IFBNDQpbLi4uXQ0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQg
bmV0LW5leHQgMTEvMTVdIG5ldDogZW5ldGM6IHJlc3RvcmUgVkYgTUFDIHByb21pc2N1b3VzDQo+
IG1vZGUgYWZ0ZXIgRkxSIGZvciBFTkVUQyB2NA0KPg0KPiBGcm9tOiBXZWkgRmFuZyA8d2VpLmZh
bmdAbnhwLmNvbT4NCj4NCj4gT24gRU5FVEMgdjQsIHdoZW4gVkYgcGVyZm9ybXMgYSBQQ0kgRkxS
LCBpdCByZXNldHMgUFNJUE1NUltTSW5fTUFDX1VQXQ0KPiBhbmQgUFNJUE1NUltTSW5fTUFDX01Q
XSBiaXRzLCB3aGljaCBjb250cm9sIHRoZSB1bmljYXN0IGFuZCBtdWx0aWNhc3QNCj4gcHJvbWlz
Y3VvdXMgbW9kZSBmb3IgdGhlIGNvcnJlc3BvbmRpbmcgU0kuIFRoZSByZXNldCAoZGVmYXVsdCkg
dmFsdWUgb2YNCj4gdGhlc2UgYml0cyBlbmFibGVzIHByb21pc2N1b3VzIG1vZGUsIG1lYW5pbmcg
dGhhdCBhZnRlciBhIFZGIEZMUiwgdGhlDQo+IFNJIGlzIGxlZnQgaW4gcHJvbWlzY3VvdXMgbW9k
ZSByZWdhcmRsZXNzIG9mIHRoZSBjb25maWd1cmF0aW9uIHNldCBieQ0KPiB0aGUgUEYgZHJpdmVy
IHByaW9yIHRvIHRoZSByZXNldC4NCj4NCj4gVGhpcyBpcyBhIHBvdGVudGlhbCBzZWN1cml0eSB2
dWxuZXJhYmlsaXR5OiBhIG1hbGljaW91cyBWTSBjb3VsZA0KPiBkZWxpYmVyYXRlbHkgdHJpZ2dl
ciBhIFZGIEZMUiB0byBmb3JjZSBwcm9taXNjdW91cyBtb2RlIG9uIGl0cyBTSSwNCj4gYWxsb3dp
bmcgaXQgdG8gY2FwdHVyZSBuZXR3b3JrIHRyYWZmaWMgbm90IGRlc3RpbmVkIGZvciB0aGF0IFZG
Lg0KPg0KPiBUbyBtaXRpZ2F0ZSB0aGlzLCBtYWtlIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4N
Cj4gLSBBZGQgRU5FVENfVkZfRkxBR19VQ19QUk9NSVNDIGFuZCBFTkVUQ19WRl9GTEFHX01DX1BS
T01JU0MgdG8NCj4gICBlbmV0Y192Zl9mbGFncyB0byB0cmFjayB0aGUgUEYtbWFuYWdlZCBwcm9t
aXNjdW91cyBtb2RlIHN0YXRlIGZvciBlYWNoDQo+ICAgVkYuDQo+DQo+IC0gVXBkYXRlIGVuZXRj
X21zZ19zZXRfdmZfbWFjX3Byb21pc2NfbW9kZSgpIHRvIGtlZXAgdGhlc2UgZmxhZ3MgaW4gc3lu
Yw0KPiAgIHdoZW5ldmVyIGEgVkYgcmVxdWVzdHMgYSBwcm9taXNjdW91cyBtb2RlIGNoYW5nZSB2
aWEgbWVzc2FnaW5nLg0KPg0KPiAtIFVwZGF0ZSBlbmV0Y19wZl9zZXRfdmZfdHJ1c3QoKSB0byBj
bGVhciBib3RoIHByb21pc2MgZmxhZ3Mgd2hlbiBhIFZGDQo+ICAgaXMgdW50cnVzdGVkLCBzbyB0
aGF0IGEgc3Vic2VxdWVudCBGTFIgY2Fubm90IHJlc3RvcmUgcHJvbWlzY3VvdXMgbW9kZQ0KPiAg
IHRoYXQgdGhlIFBGIGhhcyBhbHJlYWR5IHJldm9rZWQuDQo+DQo+IC0gQWRkIGEgdmZfZmxyX2hh
bmRsZXIgY2FsbGJhY2sgdG8gZW5ldGNfcGZfb3BzLiBUaGUgRU5FVEMgdjQNCj4gICBpbXBsZW1l
bnRhdGlvbiByZS1hcHBsaWVzIHRoZSB0cmFja2VkIFVDL01DIHByb21pc2N1b3VzIG1vZGUgc2V0
dGluZ3MNCj4gICB0byB0aGUgaGFyZHdhcmUgYWZ0ZXIgZWFjaCBGTFIsIGVuc3VyaW5nIHRoZSBo
YXJkd2FyZSBzdGF0ZSBtYXRjaGVzDQo+ICAgdGhlIFBGLW1hbmFnZWQgcG9saWN5IHJhdGhlciB0
aGFuIHRoZSBpbnNlY3VyZSByZXNldCBkZWZhdWx0Lg0KPg0KPiAtIEFkZCBlbmV0Y192Zl9mbHJf
aGFuZGxlcigpIGluIGVuZXRjX21zZy5jIHRvIGRldGVjdCBGTFIgZXZlbnRzIHZpYSB0aGUNCj4g
ICBQU0lJRFIgcmVnaXN0ZXIgYW5kIGRpc3BhdGNoIHRvIHRoZSB2Zl9mbHJfaGFuZGxlciBjYWxs
YmFjay4gSW52b2tlIGl0DQo+ICAgYXQgdGhlIHN0YXJ0IG9mIGVuZXRjX21zZ190YXNrKCkgYmVm
b3JlIHByb2Nlc3NpbmcgVkYgbWVzc2FnZXMuDQo+DQo+IC0gRW5hYmxlIEZMUiBpbnRlcnJ1cHRz
IGluIFBTSUlFUiBvbmx5IHdoZW4gYSB2Zl9mbHJfaGFuZGxlciBjYWxsYmFjayBpcw0KPiAgIHJl
Z2lzdGVyZWQsIGtlZXBpbmcgRU5FVEMgdjEgYmVoYXZpb3IgdW5jaGFuZ2VkLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENs
YXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0K
