Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DA3E5EEC
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651537; cv=fail; b=tDgZINjp1gf/NLx+jusqwUp+zhZHJD+BsdPBnJiAwSoKdG7nXzC466OQU2e3z/iQ1F/qOuHUby5JboEgi32vorgc60fTezXCD1oxd9nG+lhfhRFxHl/u98VjT/YHsOLTlPZ/9hSxWZ/+t0LkyuZu/M/xkP2Q2thZx0VJCFYgaNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651537; c=relaxed/simple;
	bh=MVtLJlrZEfSb3FfZkGrgPNdKYLdCcmVzhLCzmY8Fq88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6yoFn2Eo2xuCdNNfLNkZYIpZCkl3dMqxH5+aTKahevBmVpx7XtErUuxgMYYIxEIaHOyjlMwWDPHD3KmMfz/PuMgtAfsf5mBtOP5yjym1uaykLIeBo9xlSRklF7sOJsBGyQAoGTZPe4Sdd1/OC8yl+PBctAf9RwKMjD17zExmbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVEZllFZ; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVEZllFZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3D4HNBM41sxkVNvqCVwXFoVaHccmlH8XnkicscWODwMy/YucVxFsrNwY4jCKBP/fHUwHTEFry5lMOvz7HfxtNeQKTPxLU+EuP5q37zwG8N05P0GEh+KCXvmx1SXRGjilHFa6lEuPYifDeOwm0Gtr/3h2m99OO8wy8GCGTxOJXla0RV+xbhq3JQ+p5jE23aRHFl2NtDN5t7ksnPBGaO8iGqCe4XcR9sCmZ7c+sVIe/hsxUekN0fzQLdQ05hXmVCArDXt9F7VV+KjWc3NxJ0WKyT+1BLM+zSkJFPCRlYyC2xizTTr7rRJt6E6FFgXogzfGGnoH8OTyXY2hcLxucsj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVtLJlrZEfSb3FfZkGrgPNdKYLdCcmVzhLCzmY8Fq88=;
 b=Y82M1wDk4CsNbCf6NWcgcQ1EUgnTcM3Iv+t5nakr74w2TPVIoKwnxQd/VnCQr9gMtPCbkggbDkX2ZQycDiRmoxbXhPHyY4rkLeWsb/eBoSnZfeFbVASYueXG4r3R63KYHOmIDBM2waDHhGjpsqyzMz2n1opkL2KkKtfr/8upingg8HeJJodct5iIuVbV15tKQ5JGGeRxluBD/B76slNHSTeLhv5UFbhX+lge3CubEdW4J40wNuoYZkoDa+jYpWAZMV2P1E78i65cFOiArA3TbbozNKGkweotiBQgrDteLfqhngVpha+eCyhAKOShZ/oQQH8VqvZasuE17RJyoWDKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVtLJlrZEfSb3FfZkGrgPNdKYLdCcmVzhLCzmY8Fq88=;
 b=TVEZllFZLd4YN3Pb4Z5B80fqyyLugzijI+HfgAqCgEt01OZanBhU4cXMCi/OjF4yoh9SPI9RHOo6IXALWIZXuWgeZiDYVfKMGmT01sjxZxD+FahnEWQ+I7Yo+hmN+Bidv+oQWANYUl5OfY+QXtIRP3OZoANS6g6T0x8oA2QfjDSH1pl/OJmvwPLFY38bh2/O/Ddpl97pRrcKd2Ek3d8f+PnlKwoNUJUrWeVtPgadnZKF9nS+aIeGCVo5DcPNO+Mi/t1d60ORtq7rKeEH3eawQsnbtLSHtyQnhcnmPjXyimfysZPSaq6iCcO1phf/VV7viDtRjloqlQ4J3Fjc37lYRw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 09:52:09 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::25c9:b561:2aea:8e3c]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::25c9:b561:2aea:8e3c%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 09:52:09 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>, Boris Pismenny
	<borisp@nvidia.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Thread-Topic: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Thread-Index: AQHdMolZcioeE/Gpn02iujIOQZmferar6gaAgAFky4CAATrkAA==
Date: Tue, 25 Aug 2026 09:52:09 +0000
Message-ID: <7bddbd246387fe4dfdc1e638b50d44a73aecdc83.camel@nvidia.com>
References: <20260822225524.2328465-1-kuba@kernel.org>
	 <willemdebruijn.kernel.1157fb673940e@gmail.com>
	 <9d75871db36b1801eb381f5445c10fd29e2ad8a8.camel@nvidia.com>
In-Reply-To: <9d75871db36b1801eb381f5445c10fd29e2ad8a8.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH8PR12MB9766:EE_
x-ms-office365-filtering-correlation-id: ac74e107-07d4-4f0b-c87f-08df028e878b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 gw1nimDuOsT6uKw0C85cVeX2LWnGKpRTuVjUybbcP03dGPwp++ErKr0hT1t56Rr9WQFjfrQxtGi8XFRzHhR1AH383LSfap+PganYsJbCRBLDy/bxl7kbb/nEmYxOXo1u9aw9iRGHXKQJE6ogwmZwjhNQ1xJY0vApRGAa1wilXBW0ONEG2BiVMgSFGrizbT96BlbHf3t5cuv7rv96L02AIYqB0yEfINiS10Z6Z757i1PcJzN3IerH/AuyqBl+C8oGJg4pFxqF40ujjc5L9oUyy75/DLGT673t88XVLOk1EkggRjAMY8dJgj6zTcjQ2KRwm9a64FpDdJSRpkRONKGaCaG+n+BNNT8YbXgJT1z48ZVRycpBSIGro6apr9sfDzkftVnlXDIEq4Vjr+3XiiglbwoXYAhca47nXB8estl6qQGGkO3ZCEgClqoh3N0YFsPnWQQJaZrpa7O4liEIfXfrCka8irU+dlps/82akxOJeI/g6dA85UqTk3F9TIPx5yFTvaKr+eLyYwPoxCX74WDTEvfqacfowOT9jBUMyOd9raNG3fCWXqb4mnoZUPb07DRIRnePnniz4e2Z5R0IzivB7viscDF3mOr70itfwx61/LnkYsAyseDlIlRy9ga/KaMYwpkE9e1JWXGEjwV7gqx5JqqW6jPOV+tKn4mAJMdazjS8Wj3BbdPR/QsSn592o0mxZq/Gr0KQhUzFdETO4g9WtRlrKBSVraIk7TF3muDBL0k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzNXa0VqRlBoRjhtbHp1Z1oxY3FGb2lMRFYrVEtlMkFBbm4vc0xzdzk2Rmd4?=
 =?utf-8?B?QUtLanVpQ2w1Tk9uSjNXZ1IwZUIrRUFTU1Q5WHVLbkpYSUJuSjR2MExONXZR?=
 =?utf-8?B?Rm95QnpNUW4zTVBSbTArRktraGcwcXZHa05wQUdLVzZWU1l5UTRlbkFCUThv?=
 =?utf-8?B?dWZIbUN6ZXVMZ3Y0WEkrQ2MrRllDTzh1WUVvREt5dXBsZW8wUVI5RUZZSXp2?=
 =?utf-8?B?aHRQZ3VnenBFN0ZxZFNnREdhTHNiR2RlMlhMNXh6NzNhSGh6cEJ4ZkVmK29a?=
 =?utf-8?B?c1k1d3NmWXoyNDcyMFlQdC9Nbk9LWmp5VVlSYjI4aHZiOEcyL1hKdk13SzI3?=
 =?utf-8?B?UjQ5VEtHT0M4enV2V3ZZcXVPNldVSDQxMENpc2ZDQlZwNmgyTmQzdnhjWGhS?=
 =?utf-8?B?eHlXY2FFV0U5WEJLOWRUSkNrcndseENlNWNwUWJza1ZwTmZ4cS9Ya1VNWVZr?=
 =?utf-8?B?a1MvdmpYN1FTbnVqY3hlMjhwclBFSHFNaFVadlR6WDNKdG5BaGowVC8rZWMz?=
 =?utf-8?B?M2JFM3ducmxBY3RuaFpGakY0N1lmaU9lMXVNcGM1TVh5VktNUk4yZ0U2amVP?=
 =?utf-8?B?ZnhvUUprZ1BZSncyMUdwVkRnUTFhUzJxejFzRWd5RW1jd0EwckNYOTh5WjhP?=
 =?utf-8?B?bFhIRUdlR3dFczFoT3FYUnUvZ1l4dUZwemRDcHpPUGNQMHlLRmM5UTlQVTJu?=
 =?utf-8?B?ODh4c091ZHF2cEFWMUlwcFFVamtnbUl6WEE3TkJNdGpjeU5vTHNhN21DcFEv?=
 =?utf-8?B?NVEwcys1bXpmalV1UUJDUVJobU1oU1NPdGFqL1VuV0k4WGZyZ0lmMXBoSXNB?=
 =?utf-8?B?bWkzUHloRFlUUE5tSFlNdjZzMlVHWktzRXlxT1ZtN3NqQkc2ZjhNMmxCSDYx?=
 =?utf-8?B?eTh3UXduN3llT2lVVWlMZjA4NzNqREp3S2dVeVJvS2RDZ3pzVFZ3c2JYUjMz?=
 =?utf-8?B?TVNwVGJPLzVYZk93Z0NNNHpRNUNSTzVHWDhsT2txUFYvUXZkaUdrb3VlRGFO?=
 =?utf-8?B?bCtNa1VRa0pSZkdLdzBwQmFNcnIxNXU1WGFXOFd6d0V2VVFCWWxVcDl1TEcy?=
 =?utf-8?B?MUZwQ2haWlU3UW8zZHJJUmFyd0tyTk9rUDNmU01MYlMwRnY5V2VDeUZKVm5L?=
 =?utf-8?B?MTFPcHkrdWNrcTdFWlBaY3JFYW1nRXU2Y0dXMDZ4allvTUVMSGN5bzZ1K2dn?=
 =?utf-8?B?NTlKSENtM2hzTml1YWpNeW5rdHdzU2hkb01PQjBOOE1VNEtYWG5EWENJT1ZB?=
 =?utf-8?B?cFNlSEtMSWVjZkpYKzNnelJaWjNDTjlzT0FRK0VkUW5maWxDdE5pN2IrV2Fp?=
 =?utf-8?B?SGl5ZGVEUktOUDNhR01rRWRkNEU2OUZ1SnBLUFNVbjV5K0d0aDhXeEk3ZzJ2?=
 =?utf-8?B?TTdCK0ZwWEdPS1V0QTFsbGIzKzFtTG0vNVpHQkdMd0ZUTHBYVnRrai9VTjN5?=
 =?utf-8?B?MDRIdGZIeEJLZDVFSXBGTE9LbGl3U2VJMHlMcUhWRlF1Y3RXbVhsTkozM1ha?=
 =?utf-8?B?Qmpzb3BNb0lZQkpES2JyRXlUV0lOZVA3Q0FJRmg1VHBldy9tUktJSTRhVndu?=
 =?utf-8?B?QUF3TFNCbGtEM3VpNzVadHE2bGRvS01sazRtRXNiSlRyUm9lMUt2MUd1QTNp?=
 =?utf-8?B?TTk3U3VFN3VYTExSVElmWC9kNjZnZmRlTXo5dlVQTVBBRXNlNlBXVDZxSXIx?=
 =?utf-8?B?R2VVNUU0YmRMVGtuYXNZb2R3UFUrZDFvMStPbFUwNDl5TThPMWxxV1c3OGFj?=
 =?utf-8?B?a0xFRFY1N01aVW10SGMxTGJMWnRwaGNMN3ZjZFlQOTJBYlJKYTVITjAxekJn?=
 =?utf-8?B?U3Jja3lLYWtrWkdVWmVJMm1wQUhldmpJMGFlTW9jU0JDbUNKT05pVlkwU3NY?=
 =?utf-8?B?V1hWRmNoOXdOSnRVeUdrS1lNVGlxNHRWaC9sRE90MlRpRGRuZ3VsT2dVbDhS?=
 =?utf-8?B?eTNlVVZ6ZzllN1ZkR0FmbExZdm5FUWJpY29va2lvQ3pmKzdhdExBaEdxbmwx?=
 =?utf-8?B?dnVBL2ZGN1BqQW1zUzNNVXhwc2E3c3JyMkhjbW1Gcm1ZOXc2R1gvakJXK2t3?=
 =?utf-8?B?WkJoa1RtdnVuSTFITjluaURwK3VkeWIybFZ1c0o3S1A3aG5wMmZEYXp5REY2?=
 =?utf-8?B?OExMb0VGekFScGtqWTFmbWRGa3d1RFY1VFF0aVUvTEJZWHdPb0RGdlFmWEFH?=
 =?utf-8?B?WnBkWEVFK3dMa3BUajZ1VlhlN2hBd2VqTkxKWkVzMHB4K2M0R0NVOFJXckNV?=
 =?utf-8?B?cnZ4UUt3Y1plZ3lZM3NSMHhITlgyRjBpQ2QyTmc1bW5YRDBoTVlRRExjb1FE?=
 =?utf-8?B?TURsOEdpeDVFR2ViUWRlNmV5UjNSNklRQnBIT0JUYWRwU0dxT0Q4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B7CF6EBD10A424CBD9B67F3FDB0C0E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac74e107-07d4-4f0b-c87f-08df028e878b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 09:52:09.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1N+7R5Qpgvy6rckXacUKugCbVAMuvFwWrKrYuDqlduh96lBI18iDbeQlCEEAM18e5IdK83dNJ/YNUaK++CSQ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE3OjA1ICswMjAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIFN1biwgMjAyNi0wOC0yMyBhdCAxMzo0OCAtMDQwMCwgV2lsbGVtIGRlIEJydWlqbiB3cm90
ZToNCj4gPiBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiA+IEhpIQ0KPiA+ID4gDQo+ID4gPiBU
aGlzIFBvQyBzZXJpZXMgdXNlcyBhIGZpZWxkIG9mIHRoZSBQU1AgaGVhZGVyIGludGVuZGVkIGZv
cg0KPiA+ID4gdHVubmVscw0KPiA+ID4gdG8gYXV0by1zdGVlciBSeCB0cmFmZmljLiBWYXJpb3Vz
IGF0dGVtcHRzIGhhdmUgYmVlbiBtYWRlIGF0DQo+ID4gPiB0cnlpbmcNCj4gPiA+IHRvIGdldCBS
eCB0cmFmZmljIHRvIGxhbmQgY2xvc2UgdG8gdGhlIGNvcmUgd2hlcmUgdGhlIGFwcGxpY2F0aW9u
DQo+ID4gPiBydW5zLg0KPiA+ID4gQnkgZGVmYXVsdCBSU1MgcGlja3MgdGhlIFJ4IHF1ZXVlIGJh
c2VkIG9uIHRoZSBmbG93IGhhc2guDQo+ID4gPiBJJ20gbm90IGdvaW5nIHRvIGNvdmVyIGFsbCBw
cmV2aW91cyBzb2x1dGlvbnMgaW4gZGV0YWlsIGJ1dA0KPiA+ID4gYnJvYWRseQ0KPiA+ID4gLSB3
ZSBoYXZlIFJGUyBpbiBTVyB3aGljaCBsb29rcyBvbiB3aGljaCBDUFUgVHggaGFwcGVucyBhbmQN
Cj4gPiA+IGJhY2tsb2dzDQo+ID4gPiBSeCBwYWNrZXRzIHRoZXJlLCBpdCBpcyBxdWl0ZSBlZmZp
Y2llbnQuIGFSRlMgaXMgYnVpbHQgb24gdG9wDQo+ID4gPiBvZiBSRlMgYnV0IHRyaWVzIHRvIHBy
b2dyYW0gZmxvd3MgaW50byB0aGUgTklDLiBTb21lIE5JQ3MgaGF2ZQ0KPiA+ID4gYSAiY2FjaGUi
IGFuZCB0cnkgdG8gYXV0b21hdGljYWxseSByZW1lbWJlciB0aGUgZmxvdyB0byBxdWV1ZQ0KPiA+
ID4gYXNzb2NpYXRpb24uDQo+ID4gPiANCj4gPiA+IEFsbCB0aG9zZSBzb2x1dGlvbnMgYXJlIGVu
dGlyZWx5IGxvY2FsIHRvIHRoZSByZWNlaXZlci4NCj4gPiA+IElkZWFsbHkgd2Ugd291bGQgd2Fu
dCB0aGUgc29sdXRpb24gdG8gbG9vayBzb21ldGhpbmcgbGlrZQ0KPiA+ID4gVENQIHRpbWVzdGFt
cCBvcHRpb24gLSB3ZSBzZW5kIGFuIG9wYXF1ZSBjb29raWUgdG8gdGhlIHBlZXIsDQo+ID4gPiBh
bmQgdGhlIHBlZXIgZWNob2VzIGl0IGJhY2sgdG8gdXMuIE91ciBOSUMgY2FuIHN0ZWVyIGJhc2Vk
DQo+ID4gPiBvbiB0aGF0IGVjaG9lZCBjb29raWUuDQo+ID4gDQo+ID4gQW5vdGhlciBvcHRpb24g
aXMgdG8gcmV2ZXJzZSBSU1MgZW50cm9weS4gVGhpcyByZXF1aXJlcyBrbm93bGVkZ2UNCj4gPiBv
Zg0KPiA+IHRoZSBSU1Mgc2VjcmV0Lg0KPiA+IA0KPiA+IEVzcGVjaWFsbHkgd2l0aCBQU1AsIHRo
ZSBvdXRlciBVRFAgc291cmNlIHBvcnQgaXMgZGVmaW5lZCBhcyBmbG93DQo+ID4gaGFzaCwgc28g
Y2FuIGJlIHVzZWQgZm9yIHRoaXMuDQo+ID4gDQo+ID4gSGF2ZSB0aGUgcmVjZWl2ZXIgY29tcHV0
ZSBhIDQtdHVwbGUgaGFzaCBzdWNoIHRoYXQgaXQga25vd3MgdGhlIFJTUw0KPiA+IGJsb2NrIHdp
bGwgc2VsZWN0IHRoZSBpbnRlbmRlZCBxdWV1ZS4gVGhlIG9ubHkgZnJlZSB2YXJpYWJsZSBoZXJl
DQo+ID4gaW4NCj4gPiBnZW5lcmFsIGlzIHRoZSBzb3VyY2UgcG9ydC4gVGhlbiBjb21tdW5pY2F0
ZSB0aGlzIHByZWZlcnJlZCBzb3VyY2UNCj4gPiBwb3J0IHRvIHRoZSBzZW5kZXIuDQo+IA0KPiBJ
IHdhcyB0aGlua2luZyBvZiBzb21ldGhpbmcgYWxvbmcgdGhlc2UgbGluZXMgYXMgYW4gYWx0ZXJu
YXRpdmUuDQo+IFdoZW4gaW5pdGlhbGl6aW5nIFBTUCBmb3IgYSBjb25uZWN0aW9uLCBsb29rIGF0
IHdoYXQgdGhlIGRldmljZSB1c2VzDQo+IHdpdGggLmdldF9yeGZoKCksIGFuZCBmaW5kIGEgdmFs
dWUgc3BvcnQgKGVpdGhlciBieSBsaW5lYXIgYWxnZWJyYSBvcg0KPiBsaW5lYXIgcHJvYmluZykg
c3VjaCB0aGF0IHRoZSA0LXR1cGxlIGhhc2ggcmVzdWx0cyBpbiB0aGUgZGVzaXJlZA0KPiBxdWV1
ZS4gVGhpcyBtaWdodCByZXF1aXJlIHNvbWUgbm9uLXRyaXZpYWwgY29kZSBjaGFuZ2VzIHRvDQo+
IHJlaW1wbGVtZW50DQo+IHRoZSBoYXNoZXMgaW4gU1cgdGhvdWdoLCBidXQgaXQncyBsb2NhbCB0
byB0aGlzIHNwb3J0IHNlbGVjdGlvbiBvbmx5Lg0KPiANCj4gcHNwX2Rldl9lbmNhcHN1bGF0ZSgp
IGFuZCBwc3Bfd3JpdGVfaGVhZGVycygpIGJvdGggY29udmVuaWVudGx5DQo+IGFscmVhZHkNCj4g
aGF2ZSBhIHNwb3J0IGFyZ3VtZW50LCB3aGljaCBpcyBjdXJyZW50bHkgaWdub3JlZCwgc28gcGx1
bWJpbmcgdGhpcw0KPiBpcw0KPiBlYXN5Lg0KPiANCj4gVGhpcyB3b3VsZCByZXN1bHQgaW4gemVy
byBSWCBjaGFuZ2VzIGZvciBkcml2ZXIgaW1wbGVtZW50b3JzLg0KPiANCj4gQW4gZWFzaWVyIGFs
dGVybmF0aXZlIHRvIGF2b2lkIHJldmVyc2UgZW5naW5lZXJpbmcgUlNTIGhhc2gNCj4gaW1wbGVt
ZW50YXRpb25zIHdvdWxkIGJlIHRvIHZhcnkgdGhlIGRlc2lyZWQgc3BvcnQgYWNyb3NzIG11bHRp
cGxlDQo+IHBhY2tldHMgYW5kIHVudGlsIHBhY2tldHMgc3RhcnQgY29taW5nIHRvIHRoZSBkZXNp
cmVkIHF1ZXVlLg0KPiBQcmVzdW1hYmx5DQo+IHRoaXMgY291bGQgY29udmVyZ2UgdG8gdGhlIGRl
c2lyZWQgcXVldWUgaW4gTyhudW1fcXVldWVzKSBUWCBwYWNrZXRzDQo+ICsNCj4gYWNrcy4gTWF5
YmUgY291bGQgYmUgZG9uZSB3aXRoIFRDUCBrZWVwIGFsaXZlcyBhdCBjb25uZWN0aW9uIHNldHVw
Pw0KPiANCg0KQW5vdGhlciBpc3N1ZSB3ZSBoYXZlIHdpdGggYSBwb3RlbnRpYWwgbWx4NSBpbXBs
ZW1lbnRhdGlvbiBpcyB0aGF0IEhXDQpHUk8gY2Fubm90IHdvcmsgd2l0aCB0aGlzIGZlYXR1cmUg
YXMgcHJvcG9zZWQsIGJ1dCB0aGVyZSBhcmUgb3B0aW9ucy4NCg0KRm9yIEhXIEdSTywgbWx4NSBO
SUNzIG5lZWQgdG8gZGVjYXBzdWxhdGUgcGFja2V0cyBiZWZvcmUgc2VuZGluZyB0aGVtDQp0byB0
aGUgSFcgb2JqZWN0IHdoaWNoIGRvZXMgR1JPLiBUaGUgU1BJIGFuZCBQU1AgdmVyc2lvbiBhcmUg
cGFzc2VkIGFzDQpDUUUgZmllbGRzLiBUaGVyZSdzIG5vIG1vcmUgQ1FFIHNwYWNlIHRvIHBhc3Mg
cmVxX3FpZCBhbG9uZ3NpZGUgdGhvc2UuDQoNCk9wdGlvbiAxIHdvdWxkIGJlIHRvIG9ubHkgc2V0
IHJlcV9xaWQgb24gX2NoYW5nZXNfIChlZGdlIHRyYW5zaXRpb25zKQ0KYW5kIGtlZXAgaXQgMCBv
dGhlcndpc2UuIEFsc28gbWFrZSBpdCBtZWFuIHF1ZXVlID0gcmVxX3FpZCAtIDEgdG8gYWxsb3cN
CnRoZSB1c2Ugb2YgcXVldWUgMC4gSWRlYWxseSwgb25seSB0aGUgZmlyc3QgcGFja2V0IGluIGVh
Y2ggZGlyZWN0aW9uDQp3b3VsZCBoYXZlIHJlcV9xaWQgIT0gMC4gVGhlc2UgcGFja2V0cyBjYW5u
b3QgYmUgZGVjYXBwZWQgYW5kIGNhbm5vdCBnbw0KdGhyb3VnaCBIVyBHUk8sIGJ1dCBhbGwgc3Vi
c2VxdWVudCBvbmVzIHdpdGggcmVxX3FpZCA9PSAwIG1heS4gZHN0X3FpZA0KaXMgb2YgY291cnNl
ICE9IDAgaW4gYWxsIHBhY2tldHMgYW5kIGlzIGhvbm9yZWQuDQoNCkJ1dCB0aGVuIHlvdSBuZWVk
IHRvIG1ha2Ugc3VyZSB0aG9zZSBwYWNrZXRzIGFyZW4ndCBsb3N0LCBhbmQgbWF5YmUNCnJldHJh
bnNtaXQgcmVxX3FpZCB1bnRpbCBpdCBnZXRzIHJlY2VpdmVkLiBJIHRob3VnaHQgYWJvdXQgaXQg
YSBiaXQsDQptYXliZSB1c2luZyBUQ1AgYWNrcyBhcyBhbiBpbmRpY2F0aW9uPyBPciBqdXN0IHRy
eWluZyBiZXN0LWVmZm9ydCBhDQpjb3VwbGUgb2YgdGltZXMuLi4NCg0KT3B0aW9uIDIgd291bGQg
YmUgdG8ganVzdCBkaXNhbGxvdyBIVyBHUk8gd2l0aCByZXFfcWlkLg0KDQpBbmQgb3B0aW9uIDM6
IHNwb3J0IHNlbGVjdGlvbiB0byBnZXQgdGhlIGRlc2lyZWQgUlNTIHJlc3VsdCBtYWtlcyB0aGlz
DQppbnRlcmFjdGlvbiBub24tZXhpc3RlbnQuDQoNCkNvc21pbi4NCg==
