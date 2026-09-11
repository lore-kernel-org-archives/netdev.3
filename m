Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72D1E9B1A;
	Fri, 11 Sep 2026 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157822; cv=fail; b=BzxlndSb/87ST3TJFKAngOW3JRAsPhdM1wXpwPRpF+tt0h1qYx4a9rwI8FKnyLL0q/Yvu2vRAO+BxCk0zZRCDFouRCGKokT0Gfq+RwxDqhvRbgbGslHtNVksh8KIAUQ5wZ9kRLQkXOTNakAmvE1B+UPySFc7vwxEWzuerhG03mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157822; c=relaxed/simple;
	bh=kTYRodOtYc0+EH+bbzVQDHNyYD1VsI5CQuY1MW6N7VA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwwF9Q4+hb4d5JYrDBsjPLUOpcZpoNCGfSlrW+7/+QW50K1i90CyLysxPgg0RkXXMOEaSBGlELiY9eWkqV/3imCrV78sRvTcnSBynEPDdlEc4hs6Iu21vDeqe+8oIUY/sv4BdwoUa6Yb07p0/FPOvFM03uZh7jUeOrOIU8Guotw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Br0j3+Vn; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Br0j3+Vn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEoPpW9D36siBHZTW5ZXV2tunx1DRb+fStLwU/8QivJ8RFJRSxlxr/hSRFn7LXq+X4Q7fZnYB6vTu1NErWtoYi3/TcC36qBKoimXjfdNQrb1yeEpDItA34MfQeD4eHcdy81IYbY6tds+in/ZKfKwUuR6XP03ozjnPdgbhV6VoLLlXCO79KPg4DVah52UM1mkNIrh2BRFiarfT+WavvY58904vXzkfUcEo015mmXbtqmdji1GSwE2wFduwot8yYVkCSjhDAXsuIlC3HBr8IXDHO6nLWp1lsDkqK1HiltOPqPNQvUqjL1Rww/ygPR6r49hac5ov3I1gEmZ4dxtUl/beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTYRodOtYc0+EH+bbzVQDHNyYD1VsI5CQuY1MW6N7VA=;
 b=wINdvdIzZCYfxdH4VKoHSqejlHTZhXj5K8q5xNwFve6r/Yiqhw4+HLAY1s+x7kXId/vwyIIjgLpC9QXG/0L6swWTr6T3S2H+dpvNP3o9mzhDUVRrow/gFmWQjnAb78Tz1mfIuEx//6bkWouQAA3PvDvyoggsS3fiBh2rFPZmZ8/J8eMGdW2I7QNsDcK75ECkzgq9pREsirWwx9YNMMCr1d0CTiIFsxaBBi/zV5xueGo1f74J/RH9WxLRr2OAe7d3ZnXlZJoR7tqiqNPnpRach7dnoTJPmvCFs84HJbOV/79TscOE03lO0P3aUIOk8PdJ6RZ64hV9fz3L2EF4a5QZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTYRodOtYc0+EH+bbzVQDHNyYD1VsI5CQuY1MW6N7VA=;
 b=Br0j3+VneyNj8laPZfwBW9sua47F+0CA2pTDZUyHaursEV7Jyd6CW1qXTzHZJ2swpBBFbQKs7sTuNP+3G2UQISuM6qwQQ3FK99COjswFMuZC/zLLSDITn/7dUlbTCDcn6LAzlvOvzzjzMRHFxf0Dizy2o51OGqyLbkUdIT8ndpAWTdd9AikhsK17TWqhRNvUugonHnuNb73n8fI8NmyQgajzlypCYN4FrP1osT/pGIK1KinloisRk8Dbz+RQXaFyYNkQT7awKiWZEwIf21Z3kQnA58MpHbEyKJ9NcPFpTfE9YTisNU9RQxz9m8tW8zCmuyeUuuDyS77oxGV89lXeZA==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by DBBPR04MB7946.eurprd04.prod.outlook.com
 (2603:10a6:10:1ec::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 20:16:58 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:16:58 +0000
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
Subject: RE: [PATCH v4 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Topic: [PATCH v4 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Index: AQHdQEb9111SS2iZe06e//m3XyKy0LbJ0HAg
Date: Fri, 11 Sep 2026 20:16:57 +0000
Message-ID:
 <GV2PR04MB1174062BC754B8C924D1746F396BE2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
 <20260909100733.1139689-5-wei.fang@oss.nxp.com>
In-Reply-To: <20260909100733.1139689-5-wei.fang@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-11T20:02:38.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|DBBPR04MB7946:EE_
x-ms-office365-filtering-correlation-id: 90f57d96-013f-4611-bb9e-08df1041a194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|7416014|376014|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021|10067099003|921020|11063799006;
x-microsoft-antispam-message-info:
 bGfURKTo6Y+YxjGoyt7p44MwyFZ+RcsjSY6JPfjVL6t8AzAGOZVseB81T0YI4tS57OFRByY9LZSYkUFmY/5Km8Lp42wVy3/Im1ePtjMpyYENumMzNCld6yQTbvx+L1JTJb4IoXgOW7vnr571/6Qhxvf1A7ipIYw+ETRFjyUIt8NBfnoJlITSFErb7jnsbtedRMikJAp5fq1HHmsY5Wy4v1wZxmV5TRcXdTw8fM6QTJJ4xyDrFd4ecyCoGTHZYdRuI6gjR1xrksDtDWJHWzoV2R9954GxLHVCmVsaXtS24K0y/UZ/F/o5eoY54r9TpcU8O0huG2/oeb022pfRokpDev7EeiOIzhuHNNrgx5HMsTZ56LjW0/5D6BZSZFPVLEByhkvhhJg9IC7ybm7i8ixpUZ3vW24qvYMEo6jkAdJXi4AaTm/28YR+KIxQDMVsG1z8kEocLcLFmlwOYcJiqj87S5UEHjn24ZCgiUf8evmopHy6e5fQrXnPOrR1d98gS5QMUzt+jFmyhoVMtCpjWCdkJKWsavwr4i1+TfbXtwnv5G7cIOQoU+gNN7qmjW3+Wk7UWx4DKbEwXfif+XHqYij6ijHviP4wlvJAg+1kiT1g1J9WNuq3V7JCCiNNZvsCnl4H9LUkYhN93cSJN+UMAraaP0n96wNAV6Yd7wJqci/Kx8rbxo/tchLuaHBnOcdPxGtXrtwpNB+yrona7w8w6XevAE/7Vl34QJik4Pq7mR3cQnsGBz+YM3/XOm+uQ0QVdnIX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDdEZXpjUXduQW45TEJZaG5VdFF3NmJyWWJ1cStjYlN1WmJIREF5NTd0TTEw?=
 =?utf-8?B?amRXeUh4Sm5QOG5yNnRTK1lpNTBxdXh4bHZvQzdkQzRnWU9ncTRnU0F4RDFo?=
 =?utf-8?B?SGdDV0tHWUY3UmxOMjRIK2Z6ZmhXZWVKODRraDBFb1dLdDh4TmI3SWJEdHk4?=
 =?utf-8?B?aGxVc29HL1ZWaWVuNDY3TjZKcGFzeEJzcmtzcFZiOG1RYWZVYnZYeVJnQzR0?=
 =?utf-8?B?eFZuc0JDdFdXcEg5MmZLZEVPWmk0M2hYUWZtSUo3UUdzV0J1SFBkeS8yVlY3?=
 =?utf-8?B?REMxRlVyVDFNVDd4QnhRTEF5WlgrZE9aemJ1YmxlRkliNnNqbDJpZVRQazg2?=
 =?utf-8?B?ZU1CNHNyMzJuT2pzSHlndUdBT1ZSUjNHWStOeStWczAvNkhRRThVL3BkT3JC?=
 =?utf-8?B?bUNDOEVMTFRjUVViSnpJazhoQ3hFMEJWVEVtL3pXRVVTSEtjcDBySUppZkxI?=
 =?utf-8?B?SEwwQXZTWEoyUS8zczg1RTVoZEdCeFM0YWN2N1JsbnJTZFNLem1LRmVTd3hv?=
 =?utf-8?B?aTVPK2xiLzlZMUZha3dXdEVNTnBBb3p0VUtLeTZxMzFGOGlTOEhtbHJJSGpH?=
 =?utf-8?B?L1FYV0NFVVJBbHlBeTFrbmdkdXkwdFFDVDk2clpKcVR5OWZFSkpUTlJuQU0x?=
 =?utf-8?B?M09uZEhSZGNBRWJDZ2Rvbmh3TlZvb2hsa3dTOHRDcWRYRkI5ay82TnYzUEJV?=
 =?utf-8?B?cFVrc3BYTzZ1TEx4dTR3c2lRZzNHUG0vMW95bXJWVm5BMXBLVy9kRkZUd29k?=
 =?utf-8?B?eGhZemJTa1JDZzk5SThxTzZCbkVMbGJWMkF1RFErWDBxakpLWWExcEhabWVx?=
 =?utf-8?B?OURrUmxBYjdTNWpHdGIySjdXSWZreFBqNXJFRE9Xd05OV0lrcENDL2M1Qkp3?=
 =?utf-8?B?RUpaUmFEdjdyZVMyS1dOUmxXTTVGNllEQTEyZTY5VGprb0d1TVJFK2VqcjBP?=
 =?utf-8?B?YjYzVEFMbWlkTXl2eUZPOCtRRXRiK0pOSVE5RmdkYUQweCtiOVRsYm5RTTBm?=
 =?utf-8?B?bHYzczdWSjRxUDVNQVQ4WUhDakhTUENZNy9POTk2TG8yL3JKRllld1NJNkJY?=
 =?utf-8?B?dng0Y1B3enkwNEQxa1crQlRhNmNSTVRGNEJzS2p5NlhaWWpBcnFZbXpaNG16?=
 =?utf-8?B?RS9UTUk4S3c1QnVwNlNEaHBETWhtQU9uMmo4NXJQZTVGSnFCb0hzSFc4K3Bv?=
 =?utf-8?B?OEcyNTE1Mi9CczhRNE13ZjExcXBBcTRkWURwMHU0NE5tK0w3U0QyelRvZG5O?=
 =?utf-8?B?RlZndkpQeitJZWVUbWxLTFArOXN4VG1Xd1NYejNhS1NSMnlKTnpIRUtiMXA4?=
 =?utf-8?B?Q0xreXhlbGVNN3lUaHFjaWd6dDkzYXlYcHV0UDA4YTVnekxrUlk3WGRsaDZ0?=
 =?utf-8?B?TVZqa2pXWHY1aUVkNEdpaVYyVmRseXRRVXlWb24rUC9sd3Y2dkhEN1c2QWFr?=
 =?utf-8?B?ZnNETjY5QS9jU0ZsWEFsQVdkT1E0TEFGR2drWGxBMmhnQTNlTWJXMmxXeHFx?=
 =?utf-8?B?Rk55YzI5Qk9iZHJXdGtaTTI0aVpKWWorMXhOZ0VFSlV5Q0lQblZlcmVxUGJS?=
 =?utf-8?B?RmRiNUdzQm1FYjI4RnBSZ3Z2VkpwU09TSE1LK1ZEVkJvOERnMkNBLzR6L1hm?=
 =?utf-8?B?SUJsSS9xK1BFcm0wTW5LczZCUkxncmJBMlpKWlhzaWJRYVg1UG53Sm1lWWtL?=
 =?utf-8?B?K1B4ekVGTmhWODVBbHhnOWpQL1c4MFdrR2U4amg4OUhKQU50Mkcwc3kwSktP?=
 =?utf-8?B?N0J6UnhTeXI2cE9WSVoxc3Z3TDBDMGJFMG96akVWZjJiMExnYnpvOEJoKzkw?=
 =?utf-8?B?VExRd2EvZkh3cG44NW8rY2VMRDV1SGtpTGNZVmRjVDZrVS9zeUQwVkdyV1Rm?=
 =?utf-8?B?STJ3TzdaOGVyUTV0Wk9vMDUySVFnOFZCb1h0N01sUGpNek1PWXI1S2FlTDUv?=
 =?utf-8?B?aUowTTdyZC9yY25FYWlzZ21ZeXFITlVUS1l1eHBNd0dNMnZGZCsrY3ZqeXlW?=
 =?utf-8?B?Smcxb0dVWktOMkFySElsN241dFZ3VDVXNDhXMVU0cVJaWVJwcU5Bc1hKRTFj?=
 =?utf-8?B?TXlYc3hJTDQySytadlBUeUVqTWFEYUJlcmFzaTB4UmFERnFhZ2lCSDBySE5R?=
 =?utf-8?B?cG5MTzN0MitKS01vWXV6dW5QbHRDWTkrUk5IM1FjTUIrN2ljVVlHVmFGRzdB?=
 =?utf-8?B?WHZ0WEgxSEp3TEpkcHl1UDVNWVZQMzRhTGdHdXFJUXBjZGJQRTRVRE95eTVn?=
 =?utf-8?B?S3R6RC93cVROd29valM0Y1VSbWljVGxucnlqVjdWcGNEYkt5SUZwSkJWOGxS?=
 =?utf-8?B?eDhvcVZTbEtvaUk4RytIdC9TL0V1Ym9hWit0a2NET0JZTlc0SUYydz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f57d96-013f-4611-bb9e-08df1041a194
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 20:16:57.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgDL4LVfVSgwk/5HInZb5alRBbwadHwGF3tBmg38mgRluaNJxajXpdVgr8AmO04iJVlG+lqZYKj2OQ2FO87xyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

DQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFdlaSBGYW5nIChPU1MpIDx3ZWkuZmFuZ0Bvc3MubnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgOSwgMjAyNiAxOjA3IFBNDQpbLi4uXQ0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQg
bmV0LW5leHQgMDQvMTVdIG5ldDogZW5ldGM6IGFkZCBsaW5rIHNwZWVkIG1lc3NhZ2UNCj4gc3Vw
cG9ydCB0byBQRiBkcml2ZXINCj4NCj4gRnJvbTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+
DQo+DQo+IFdoZW4gYSBWRiBpcyBkcml2ZW4gYnkgRFBESywgaXRzIHVzZXIgc3BhY2UgYXBwbGlj
YXRpb24gbmVlZHMgYWNjdXJhdGUNCj4gbGluayBzcGVlZCBpbmZvcm1hdGlvbiB0byBtYWtlIGNv
cnJlY3QgZm9yd2FyZGluZyBhbmQgY29uZmlndXJhdGlvbg0KPiBkZWNpc2lvbnMuIEFkZCBsaW5r
IHNwZWVkIG1lc3NhZ2Ugc3VwcG9ydCBzbyB0aGUgUEYgcmVwbGllcyB3aXRoIHRoZQ0KPiBjdXJy
ZW50IGxpbmsgc3BlZWQgd2hlbiBpdCByZWNlaXZlcyBhIGdldC1saW5rLXNwZWVkIG1lc3NhZ2Ug
ZnJvbSBhIFZGLg0KPg0KPiBVc2UgYSBuZXcgbWVzc2FnZSBjbGFzcyAweDgxIChFTkVUQ19NU0df
Q0xBU1NfSURfTElOS19TUEVFRCkuIFRoZQ0KPiBQU0ktdG8tVlNJIG1lc3NhZ2UgaXMgMTYgYml0
czogdGhlIGhpZ2ggOCBiaXRzIGFyZSB0aGUgY2xhc3MgSUQgYW5kIHRoZQ0KPiBsb3cgOCBiaXRz
IGFyZSB0aGUgc3BlZWQgY29kZSwgc28gdXAgdG8gMjU1IHNwZWVkIHZhbHVlcyBhcmUgc3VwcG9y
dGVkDQo+IChFTkVUQ19NU0dfU1BFRURfTUFYID0gMHhmZikuIEluc3RlYWQgb2YgZW51bWVyYXRp
bmcgZXZlcnkgc3BlZWQgYWJvdmUNCj4gNUdicHMsIHVzZSBhIGZvcm11bGEgc28gZnV0dXJlIGhp
Z2ggc3BlZWRzIG5lZWQgbm8gZW51bSBvciBzd2l0Y2gNCj4gY2hhbmdlczoNCj4NCj4gICBzcGVl
ZF9jb2RlID0gKGxpbmtfc3BlZWQgLSA1MDAwKSAvIDEwMDAgKyBFTkVUQ19NU0dfU1BFRURfNUcN
Cj4NCj4gVGhlIHNwZWVkIGlzIHJlYWQgdmlhIHBoeWxpbmtfZXRodG9vbF9rc2V0dGluZ3NfZ2V0
KCkgcmF0aGVyIHRoYW4gdGhlDQo+IHNwZWVkIHBhc3NlZCB0byB0aGUgbWFjX2xpbmtfdXAoKSBj
YWxsYmFjay4gV2hlbiB0aGUgTUFDIGhhcyBhIFBDUw0KPiBsYXllciwgbWFjX2xpbmtfdXAoKSBy
ZXBvcnRzIHRoZSBQQ1MgbGluayBzcGVlZCwgd2hpY2ggbWF5IGRpZmZlciBmcm9tDQo+IHRoZSBl
eHRlcm5hbCBQSFkgbGluayBzcGVlZDsgcGh5bGlua19ldGh0b29sX2tzZXR0aW5nc19nZXQoKSBy
ZXR1cm5zIHRoZQ0KPiBhY3R1YWwgZXh0ZXJuYWwgbGluayBzcGVlZC4NCj4NCj4gVW5saWtlIHRo
ZSBsaW5rIHN0YXR1cyBtZXNzYWdlIChjbGFzcyAweDgwKSwgdGhlIGdldC1saW5rLXNwZWVkIG1l
c3NhZ2UNCj4gaXMgb25seSBwZXJtaXR0ZWQgZm9yIHRydXN0ZWQgVkZzLiBSZWFkaW5nIHRoZSBz
cGVlZCByZXF1aXJlcyB0aGUgUEYgdG8NCj4gdGFrZSBydG5sX2xvY2soKSwgc28gYW4gdW50cnVz
dGVkIFZGIHNwYW1taW5nIHRoaXMgcXVlcnkgY291bGQgY2F1c2UNCj4gcnRubF9sb2NrIGNvbnRl
bnRpb24gYW5kIHN0YXJ2ZSByb3V0aW5lIG5ldHdvcmsgY29uZmlndXJhdGlvbiBvbiB0aGUNCj4g
aG9zdC4gQW4gdW50cnVzdGVkIFZGIHRoZXJlZm9yZSByZWNlaXZlcyBhIHBlcm1pc3Npb24tZGVu
eSByZXNwb25zZTsgYQ0KPiBWRiBjYW4gYmUgbWFya2VkIHRydXN0ZWQgdmlhICdpcCBsaW5rIHNl
dCA8cGY+IHZmIE4gdHJ1c3Qgb24nLg0KPg0KPiBOb3RlIHRoYXQgbGluayBzcGVlZCBjaGFuZ2Ug
bm90aWZpY2F0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgeWV0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBX
ZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgTWFub2ls
IDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0K
