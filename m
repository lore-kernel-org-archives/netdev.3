Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325434F24E;
	Fri, 21 Aug 2026 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277162; cv=fail; b=c9EcTDpc3e97OY9oomKUfYNtIYvPsvltiQo0mF4jhR10sc9c8Me2sDWLHu6NRCh163+Wv7iZ8dwS9QOoEZ1tI+kQ9HJEdph2U0XEIWUExAu9cbJbt5xQsrmkEKJ4hXxaum+/z+zZwE48wj5Gff4IuwkUppjBtfyhCSy2XhbTCxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277162; c=relaxed/simple;
	bh=tMnPzJnqaZJV0xys2QcisGyNZgG9+43nFpJGFX0jk4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+Ra3UE64nk39Vij8ETmmTi7ii/zUTXeIDR78OX2ZQ4vxi2I4Nf4H3u7SSmY5WL0x1qd5/leyc+Uqgl9LAlbvvJDN4XhPloXT7dey68g6wfdLE9DfqnhfwxfVCQrUO3qTJinBFPuuHu7+aZJ4SIAkkQ+e/MbeIkh3wkI4SxuUGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EAwVJxVJ; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EAwVJxVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJc/9hAluubL/sVvHqkbIk0pP3YDF7TuFhH2bqndwWK797ZxIgyRzn7OBmbtSyiHykLnTHmQ0a5tm8zknQyQRCGL8LLKkolBIZTS6/B1VK5tXHjkwAE+tnfbFjgsvABu6Xq+SOEklqpKdA1AXVYDHxf+T6yeq648IEU8yy2VhHuVxAQoU0F1uJbyySLYEsMde5yQyypS4bPfRzCgYdtdcURP4xNvywVDjRnnGPkM4HYmDW0N1kXI3gVlVzGm4DAMhgnWUYr2A/JWszJQCjj235bbC1XRV38UJRnx03DTZO6yv0PXVHNHNmk0RrFXat3ZGLCcbSfG0/akCBdIwqroyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMnPzJnqaZJV0xys2QcisGyNZgG9+43nFpJGFX0jk4I=;
 b=V5PrBL98ZQJwaYElEDJLO/T6zJ9TcEo0UDWgivTjDj/YHIR0IAUgvwW18/qZtxmm3d8CHXLxxmTovI0ZKhhaazO8Qp0GgIuKrVTu7Lmbawhw0sQA22AmSO4lEfWmpFwyUNa4jgnlVmeR4kpF2v46NjOEzZ0uPtCyEMCy6MKWNkQRsULmOtey78xBkRBkUfpNa4F3cf6oLqAY2VJINzwAPm3G0ZZJNS0zeqfuoAenSiSR5tGxl8Icq3fC0pRC/6DboeVCtxzvlj8rQOqMRySjfG5HLc3pyqi/vLorhm99RQ8Wr+5iGYnUAXy9kSPoa96DM0C0N01oKTAgrOtW6qK+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMnPzJnqaZJV0xys2QcisGyNZgG9+43nFpJGFX0jk4I=;
 b=EAwVJxVJCqDO6tF3BkjKWoHOcfPczhS8gebfMnyHt7dWx9OQxnMi5DobVFo0IrJLXXWlRY3nXhN5nUaEOJhBGNfISoYKaRdyJTosLYEdEAXdJ3pJSheycIiYFo++18ogMm3WnMlqhLPh8Y0wSiVGQ23KSxxJj7olZ1vPkodh2amtWbMxpiuEWbT1HyLJfjjkQTE8O1rIgIubuFTUTFo47MTh/e9phbFeVS49dIrOc9F8Km+NCTSYgoC+iqRzfWXtFhHZDQeKAcj995QgvnOEcXXVUXXDqggnzCBTSCAViPmoMrlk8+qI25Z+Dxiqs5JUEc5lY93QWGLJXN7VsntmKQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DU0PR04MB9670.eurprd04.prod.outlook.com
 (2603:10a6:10:31e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 01:52:37 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 01:52:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Thread-Topic: [PATCH net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Thread-Index: AQHdLsHSSJyJyiLXAUK698/iUQ0RUbanG1iAgACl1sA=
Date: Fri, 21 Aug 2026 01:52:37 +0000
Message-ID:
 <GV2PR04MB11739C05FD4C2D5A8B477B82D88A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260818033342.3154990-1-wei.fang@oss.nxp.com>
 <20260820155615.GA265046@horms.kernel.org>
In-Reply-To: <20260820155615.GA265046@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-21T01:49:48.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DU0PR04MB9670:EE_
x-ms-office365-filtering-correlation-id: 00905d28-8ae1-4e28-adec-08deff26e070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|23010399003|56012099006|11063799006|4143699003|3023799007|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 u7VstBWY1ipxO09UIA072JfXMzrTF+1yxVKY5LdZ8zAcGTxQ0KQ2nFb7m0TAr1NST25IkpNbO9oho7OBvTGyPl12xy3L+L8gH+5qx1NrDTRJvPj2FCoWReXtnxASOlySfNzm5mg7gM/L5+D/xP2diAevgEyO01P5c7Ou//kl7mpBYHyfuxBgxruWOycL+UqgZw4uMhKkfs7MGbIeSAIWvktYY7ET2hWikH9X6oYvZmcNqEkF6jZOJkdXvLK0JGCIlO2Z8qUFtJ51HrtEHPFh2VDMjpl9lK4freixN+W0l8mcxPUspCCL2Ejs3z1jSe+YFxhF3Sq1ZTKhRY/yeZj8XccTWKOG+JIleINIhJO9TNmOr1G3TQnkqwzr7zfDUe45B6N08esUqPf+09BjMPEQahJYtzKOz/a46YNnWTXo6oFCx9lrFVMJi8oEc7PCVJvkOO5+w9oeW0gP4FLwb9PKFa/eQ+NTRsk4B+FP248ffmhRC+P5n+IGmTAwgI0Muvp2hf5XOsGjnQuvZ0qDlbX6HEVTNtRs1Ght009WlbJPMrdbOtSRbLtyDBqSUeRxIJ2JZ7elO+9m8c0R1SubZUQEqIcvZCy6g4JPR8nk0uIuBwuAPCqt5TMULPGKLKFlm0NE7IEE40x7FuzBmS6NQdrRQyrpPtfMfmbHHs+e5mmPsnKd8Kj+Y9ZnYumbxk6K1vGRUWCr1cXmnuIq81VYopj58M742sw0xZldcEYnylZ6TnA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(3023799007)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGl5T1R0cWpnSWVGN2FKUFJNQktWMjhsV2hvUlNTNUZnanBubmUxQ1NteTky?=
 =?utf-8?B?OVY3RHYrWlUxTHIrd3pkUXZWS2tSRGhUOEhUVVRSMFhjYURBVHpiNFJ3aElR?=
 =?utf-8?B?K1A0Z3NCUEhiaGhFcUpMUGswWDN4Y2hmMmtSWTh3NzUrNDhFenQxZjM0b1g3?=
 =?utf-8?B?Z2MvRWUzN1VWL1NUMkdYY0c2QTFzN2RVTjBHdVlIeGJQSUc4QVg5MjR6REti?=
 =?utf-8?B?bldMdUtPanoxczlFLzNnUGdDYkd5Zlo5WEM1NG9vUUF2ZEhYUGtIUEh6T3Mr?=
 =?utf-8?B?dmpUYkJZenUwejVtWHExaGQ3Y1lGb1ZBN0h1UU1JditWYWFyMXlIdFN2WVRB?=
 =?utf-8?B?aDFKV2IyRC9oNHdTYnI1cDR3VXVFVlRsOUVWWGpLc0VuSTdKZ3p3bDRJNzRW?=
 =?utf-8?B?TGh1QUFNL3Q3Qy92dnI3OFd4TWRNUEtIK21qRDlTOVpjQzRhTWt4ckM3VWZE?=
 =?utf-8?B?ajFHeEJ6RnAyYzNZM1dSUit6Wk4zcUk1VzZLby9QWmRXRmFaYnlqM2JYekg2?=
 =?utf-8?B?Zk50VE9jTUdTcjZBbC9VL0hqQ3ZNN00rMmtSS3FGYjRESTZEVFk1Rlc3U1kz?=
 =?utf-8?B?bFhCZHJmenErMnNmOERIVEoycUFZbkVPUTg1V1JjMktBNmFvZkt5Y0l2VU5x?=
 =?utf-8?B?QWdrQzdaeG9BNnc0bTJCSi9CakpVOXptZFEwQnBxSElvdXErek85MnFPdUI0?=
 =?utf-8?B?UWJPaGxWSks3VHFXSmlqWGRYT3JXTkl0U2JlS3R4T0JjVmxvVFVNMG43SXlx?=
 =?utf-8?B?QjFzcXZYNDRnOVA5SGlwMTF2eVVIcW9JNTdSWFlNbzNmK2FoZVN2aHJ1ZFBl?=
 =?utf-8?B?SjRvQWxtVDlhQ3JtSnJTRit5TWxvcytXanp0c21xTzhzejZEQVdha3BDaHFi?=
 =?utf-8?B?RjJnZUFicnlYdmkxdzVWUkpldGdoeG9XZExabWZBZzkxSThJdEt1WEw5Y3RM?=
 =?utf-8?B?SUkvQm1XQXBUTklyb2ZLNVVqdHVqRHJxdUdkYXFIclhWWDNVdVRqMDllYWhE?=
 =?utf-8?B?SFMzVW1zQS9FWnFWSnFmemtlNVg4Vmh4aXh5MlZtcGVEZE5LdzUxK2VJM0Fk?=
 =?utf-8?B?aXhGbUJnWXR6WTJVaXZWTmZkSGxMODAvMy9zRzFpRzRSM1FLMHhVNHZjZnRG?=
 =?utf-8?B?WWowUUNNVDRUL1JpYVA2VGRBQTZRdHEvSGxTbnZhdUxsSHNSSEs2VmYrUGFF?=
 =?utf-8?B?M1UwOVpvSE9WUzVNakEyVlFja1ZBSXdURW9pQVMyTVVNOVArVjNtVnBiejdt?=
 =?utf-8?B?MGdBeFZVNE1pWDVSREkrL2VlZmlvanZ4T0VyeGR3aE9VVWRoRzFGczJ3K3px?=
 =?utf-8?B?angwRFB4NXJURXlNQW1WcXRQbjhDVUl0UEd2dy9RTzhPbFNLbnRKZEp1YVRB?=
 =?utf-8?B?SHJUMU1Na21WSzRWbUpyMk1qaUVsVHUzQk5xU1BJcklJY21KTUZjeFI5cFZD?=
 =?utf-8?B?ZXovL3BQaGtBRTVwNmJySEZzV0dQcHRxRU9yMEt2YmRBUkRoOVV0WTErVllT?=
 =?utf-8?B?SDNMWmV2YzJYZFVtWEFRMENXOVVndHFFV3pSWnVXUTV3eEZhTDVsWFZGcnpV?=
 =?utf-8?B?c0ZjalFOdjMxQThlSmRUQStYc0hFMTRBREdsdjQxOE4yN3Z2NkV1cEs3c2lm?=
 =?utf-8?B?MVphVG9haDlKL2xudWg2Wk9wa3YweDgvdjFrem51Q0YwWld5cHFJeFYweDh4?=
 =?utf-8?B?TENadkdlNTFkUnJxMXh0alpKVklBSWFRU1lSMy8xV0oyMXB5T2hDSkw1WStO?=
 =?utf-8?B?VW83K0cyVWpvSmpSenhoc1hud2NyaUFwczBXQ252Z0ZFTmRmMXlKbVlMRjUw?=
 =?utf-8?B?c0N3V1RBazU5aE5VMnpCL0pVZE41eGtwMjI3QkMzUjNqVzh2RkxIc29tc1NE?=
 =?utf-8?B?WkoxTG1Bbm9UUmgxNHMyVzBuUFV4ZW4wRVVZSTBuTXhhU0pVQk5ldDFYOUpG?=
 =?utf-8?B?amc4UTM3NjlGSjZCUFZvbFcwTFE2c2kwYW8yOGJjYVFBY29yS2Y3d0FZUU93?=
 =?utf-8?B?RmdWSStQSnUwOTl3ZG44YjQ3UmE2cThaVFhYOURKV2Z6aGVZN01GdHBmdjdX?=
 =?utf-8?B?UHV0Z1NFQ2hyZ2VmSnh1TzRkZlA3NzVXZmlKdkQ0c01Zak90VzJJSnUwZWN3?=
 =?utf-8?B?Y21Rd2dXYUpBbDhmK21VRlk0eGlqVklpMi8yQW4yTEZzSXFyY1kxN2t4TEN5?=
 =?utf-8?B?QlRVY2hhTitsR0UyL29hUzhPTnk1eDJua3ZXRFhMeFJJc3JRUEtHaDRwU2lU?=
 =?utf-8?B?d0plZGM1VzExTzVXY05pOWVwQ3RRY2hQL2NETlhETlo2SFhIdUkrOG1ncXhw?=
 =?utf-8?Q?tL9U42pt1bM8AZMFKd?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00905d28-8ae1-4e28-adec-08deff26e070
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 01:52:37.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPx1YN7WvYsFkiTro0mgVHcrGUInMXDGf9yJyUV5eoZPeA/jpr1thnie6NyVVb3zXZafAyPxKq0XaN/EffsiNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9670

DQpOWFAgQ29uZmlkZW50aWFsDQo+IE9uIFR1ZSwgQXVnIDE4LCAyMDI2IGF0IDExOjMzOjQxQU0g
KzA4MDAsIHdlaS5mYW5nQG9zcy5ueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiA+DQo+ID4gVGhlIG1heF9wZXJpb2QgYm91bmQgaW4gbmV0X3Rp
bWVyX2VuYWJsZV9wZXJvdXQoKSB3YXMgY29tcHV0ZWQgYXM6DQo+ID4NCj4gPiAgIG1heF9wZXJp
b2QgPSAodTY0KU5FVENfVE1SX0RFRkFVTFRfRklQRVIgKyBpbnRlZ3JhbF9wZXJpb2Q7DQo+ID4N
Cj4gPiB3aGljaCBleGNlZWRzIFUzMl9NQVggd2hlbiBpbnRlZ3JhbF9wZXJpb2QgPiAwIChlLmcu
IDB4MTAwMDAwMDAyIGZvcg0KPiA+IHRoZSBkZWZhdWx0IDMzMzMzMzMzMyBIeiBjbG9jaykuIEEg
cGVyaW9kX25zIHRoYXQgcGFzc2VzIHRoaXMgY2hlY2sgYnV0DQo+ID4gZXhjZWVkcyBVMzJfTUFY
IGlzIHRoZW4gc2lsZW50bHkgdHJ1bmNhdGVkIHdoZW4gc3RvcmVkIGludG8gdGhlIHUzMg0KPiA+
IHN0cnVjdCBuZXRjX3BwOjpwZXJpb2QgZmllbGQuDQo+ID4NCj4gPiBBIHRydW5jYXRlZCB2YWx1
ZSBvZiB6ZXJvIGNhbiByZWFjaCBuZXRjX3RpbWVyX3NldF9wZXJvdXRfYWxhcm0oKSwgd2hlcmUN
Cj4gPiB0aGUgbG9jYWwgdTMyIHBlcmlvZCB2YXJpYWJsZSB3b3VsZCBhbHNvIGJlIDAsIGNhdXNp
bmcgYSBkaXZpZGUtYnktemVybw0KPiA+IGluIHJvdW5kdXBfdTY0KGRlbHRhLCBwZXJpb2QpIHdo
ZW5ldmVyIHRoZSBzdGltZSA8IG1pbl90aW1lIGJyYW5jaCBpcw0KPiA+IHRha2VuICh3aGljaCBh
bHdheXMgaGFwcGVucyBmb3IgYSBzdGFydCB0aW1lIG9mIHswLCAwfSkuDQo+ID4NCj4gPiBBZGRp
dGlvbmFsbHksIG5ldGNfdGltZXJfZW5hYmxlX3BlcmlvZGljX3B1bHNlKCkgYW5kDQo+ID4gbmV0
Y190aW1lcl9lbmFibGVfZmlwZXIoKSBib3RoIGNvbXB1dGU6DQo+ID4NCj4gPiAgIGZpcGVyID0g
cHAtPnBlcmlvZCAtIGludGVncmFsX3BlcmlvZDsNCj4gPg0KPiA+IEEgemVybyBwcC0+cGVyaW9k
IHJlc3VsdHMgaW4gYW4gdW5zaWduZWQgd3JhcGFyb3VuZCB0byAweEZGRkZGRkZELA0KPiA+IG1p
cy1wcm9ncmFtbWluZyB0aGUgRklQRVIgaGFyZHdhcmUgcmVnaXN0ZXIuDQo+ID4NCj4gPiBGaXgg
YWxsIHRocmVlIGlzc3VlcyBieSBjYXBwaW5nIG1heF9wZXJpb2QgYXQgTkVUQ19UTVJfREVGQVVM
VF9GSVBFUg0KPiA+ICgweEZGRkZGRkZGKS4gVGhpcyBlbnN1cmVzIHRoYXQgYW55IHBlcmlvZF9u
cyBwYXNzaW5nIHRoZSByYW5nZSBjaGVjaw0KPiA+IGZpdHMgaW4gYSB1MzIgd2l0aG91dCB0cnVu
Y2F0aW9uLCBzbyB0aGUgc3RvcmVkIHZhbHVlIGlzIGFsd2F5cyB2YWxpZA0KPiA+IGFuZCBub24t
emVyby4gVGhlIGFjY2VwdGVkIHJhbmdlIGlzIHJlZHVjZWQgYnkgaW50ZWdyYWxfcGVyaW9kIG5z
DQo+ID4gKHR5cGljYWxseSBvbmx5IGEgZmV3IG5hbm9zZWNvbmRzKSwgd2hpY2ggaXMgbmVnbGln
aWJsZSBpbiBwcmFjdGljZS4NCj4gPg0KPiA+IEZpeGVzOiA2NzFlMjY2ODM1YjggKCJwdHA6IG5l
dGM6IGFkZCBwZXJpb2RpYyBwdWxzZSBvdXRwdXQgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+DQo+IElmIHNvLCB0aGVuIEkgdGhpbmsg
TkVUQ19UTVJfREVGQVVMVF9GSVBFUiBjYW4gc2ltcGx5IGJlIHVzZWQgaW4NCj4gcGxhY2Ugb2Yg
bWF4X3BlcmlvZC4NCg0KWWVzLCBJIGFsc28gY29uc2lkZXJlZCB0aGlzIG1vZGlmaWNhdGlvbiwg
YnV0IHVsdGltYXRlbHkgY2hvc2UgdGhpcyBsYXp5DQphcHByb2FjaC4gU2luY2UgeW91IGJyb3Vn
aHQgaXQgdXAsIEkgd2lsbCBpbXByb3ZlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQpUaGFua3Mu
IDopDQoNCj4NCj4gU29tZXRoaW5nIGxpa2UgdGhpcyAoY29tcGxldGVseSB1bnRlc3RlZCEpOg0K
Pg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wdHAvcHRwX25ldGMuYyBiL2RyaXZlcnMvcHRwL3B0
cF9uZXRjLmMNCj4gaW5kZXggMjg4ODliN2IzZTE1Li42NmQxZjA1MzI1ODUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcHRwL3B0cF9uZXRjLmMNCj4gKysrIGIvZHJpdmVycy9wdHAvcHRwX25ldGMu
Yw0KPiBAQCAtNDM0LDIyICs0MzQsMjIgQEANCj4gICAgICAgfQ0KPg0KPiAgICAgICBpZiAob24p
IHsNCj4gLSAgICAgICAgICAgICB1NjQgcGVyaW9kX25zLCBnY2xrX3BlcmlvZCwgbWF4X3Blcmlv
ZCwgbWluX3BlcmlvZDsNCj4gKyAgICAgICAgICAgICB1NjQgcGVyaW9kX25zLCBnY2xrX3Blcmlv
ZCwgbWluX3BlcmlvZDsNCj4gICAgICAgICAgICAgICBzdHJ1Y3QgdGltZXNwZWM2NCBwZXJpb2Qs
IHN0aW1lOw0KPiAgICAgICAgICAgICAgIHUzMiBpbnRlZ3JhbF9wZXJpb2Q7DQo+ICAgICAgICAg
ICAgICAgaW50IGFsYXJtX2lkOw0KPg0KPiAgICAgICAgICAgICAgIHBlcmlvZC50dl9zZWMgPSBy
cS0+cGVyb3V0LnBlcmlvZC5zZWM7DQo+ICAgICAgICAgICAgICAgcGVyaW9kLnR2X25zZWMgPSBy
cS0+cGVyb3V0LnBlcmlvZC5uc2VjOw0KPiAgICAgICAgICAgICAgIHBlcmlvZF9ucyA9IHRpbWVz
cGVjNjRfdG9fbnMoJnBlcmlvZCk7DQo+DQo+ICAgICAgICAgICAgICAgaW50ZWdyYWxfcGVyaW9k
ID0gbmV0Y190aW1lcl9nZXRfaW50ZWdyYWxfcGVyaW9kKHByaXYpOw0KPiAtICAgICAgICAgICAg
IG1heF9wZXJpb2QgPSBORVRDX1RNUl9ERUZBVUxUX0ZJUEVSOw0KPiAgICAgICAgICAgICAgIGdj
bGtfcGVyaW9kID0gbmV0Y190aW1lcl9nZXRfZ2Nsa19wZXJpb2QocHJpdik7DQo+ICAgICAgICAg
ICAgICAgbWluX3BlcmlvZCA9IGdjbGtfcGVyaW9kICogNCArIGludGVncmFsX3BlcmlvZDsNCj4g
LSAgICAgICAgICAgICBpZiAocGVyaW9kX25zID4gbWF4X3BlcmlvZCB8fCBwZXJpb2RfbnMgPCBt
aW5fcGVyaW9kKSB7DQo+ICsgICAgICAgICAgICAgaWYgKHBlcmlvZF9ucyA+IE5FVENfVE1SX0RF
RkFVTFRfRklQRVIgfHwNCj4gKyAgICAgICAgICAgICAgICAgICBwZXJpb2RfbnMgPCBtaW5fcGVy
aW9kKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlRoZSBwZXJpb2Qg
cmFuZ2UgaXMgJWxsdSB+ICVsdVxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bWluX3BlcmlvZCwgbWF4X3BlcmlvZCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1pbl9wZXJpb2QsIE5FVENfVE1SX0RFRkFVTFRfRklQRVIpOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gLUVJTlZBTDsNCj4gICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5sb2Nr
X3NwaW5sb2NrOw0KPiAgICAgICAgICAgICAgIH0NCg0K
