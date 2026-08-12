Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5938C412
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564629; cv=none; b=tFiTYr4t/T5IO4SXQWD4gmHh5smbnI5gN2G2viAVBIeBRVAzHDNWyiw7Y5Ubx0tFkHjkwRrg1y7yJ02aXY6hr28vLHhI9eITCvmAe/VX8ZJ79Dld8KhAhCl5dF8YSwgFH0L5eXzDa6NdZfJ8uR9DVhdGhDGCuhE/qFNTeCsst14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564629; c=relaxed/simple;
	bh=+Q5jLTWGQBFZXvRPOhGrqO8BqgOxlTQqjvIOIja/E9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=h7uZKYJi3ieKHtj6kPhE0lHqm5bPob7QiI/UQGtRHFEVNZLGO55rNADLaXWapfznX5aO/bciBWg8IboevChlUA8pcjHxYDr5fS0Zt9jvyXo4SiExLh+Fp1dbcpDQ998hjkUk+0JL4nUKIlw+uhne+wYN0qWkZ1hph0Guc4LHCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=BDeItweR; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="BDeItweR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1786564626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q5jLTWGQBFZXvRPOhGrqO8BqgOxlTQqjvIOIja/E9k=;
	b=BDeItweRgeTISC7plaa0KsPVEo7sPU4aBVY3LY5w4KnyqrXYwM6hFIYfeX1SM9a+uAoMxe
	1Us0hW/0Y3htDACLtD4+Eb27AY11xicHnMlA7GVUNC95LZUA508JlAg+Dz+7xEp+z/kBU/
	OaKUkZoP1ebqiIjrSSB9Ej9g8vLoyMY1rUEJfbxum94hamVHoFj4YZEDmnPjDcImZT8uYm
	3IgPJ1CW6NfrcG2iVMH79zbo0J1G0hKXXnxYczF4C9h/KMzhWDnh2yyLU6GKRjrCyMiLq/
	xa8/U1YS6BpEiCtwFdtvKF8GOAYIM8Vbih6I+6p7BBxW6XnoEE9pNjtyz7nWuA==
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-16-ym1_ITsiN1uzc-3hcdivrQ-1; Wed,
 12 Aug 2026 12:50:30 -0700
X-MC-Unique: ym1_ITsiN1uzc-3hcdivrQ-1
X-Mimecast-MFC-AGG-ID: ym1_ITsiN1uzc-3hcdivrQ_1786564225
Received: from MWHPR02MB3375.namprd02.prod.outlook.com (2603:10b6:301:61::16)
 by BL3PR02MB8004.namprd02.prod.outlook.com (2603:10b6:208:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 19:50:22 +0000
Received: from MWHPR02MB3375.namprd02.prod.outlook.com
 ([fe80::f19:3f8f:e27a:e484]) by MWHPR02MB3375.namprd02.prod.outlook.com
 ([fe80::f19:3f8f:e27a:e484%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 19:50:22 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>
Subject: RE: [PATCH net v5 2/4] net: ethernet: oa_tc6: Improve the error
 recovery
Thread-Topic: [PATCH net v5 2/4] net: ethernet: oa_tc6: Improve the error
 recovery
Thread-Index: AQHdH8PLBrFHopDFWku0jLIeGc2wkLaQ4UeAgAnrM4A=
Date: Wed, 12 Aug 2026 19:50:22 +0000
Message-ID: <MWHPR02MB3375E0EEEBC17D9D18CED67B83DC2@MWHPR02MB3375.namprd02.prod.outlook.com>
References: <20260729-fix-race-condition-and-crash-v5-2-3906bc485daf@onsemi.com>
 <20260806104323.151154-1-pabeni@redhat.com>
In-Reply-To: <20260806104323.151154-1-pabeni@redhat.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR02MB3375:EE_|BL3PR02MB8004:EE_
x-ms-office365-filtering-correlation-id: c0c8ab64-a6d2-4e9c-eeaf-08def8aaf221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003|38070700021
x-microsoft-antispam-message-info: XYjs5WOf9gtVz1arlA7O9qOOwWnyhi+O4G+CFrO1Ol+6a5Dbe3f3Whd8S3JUG8VkFlI48ODmQM6cisEu8p6LWj3Yr2qbv08E2MwJ+BiY9LrF+xOZfYn/4TgdGjTFR/V/wJAwymWtGcTvtrY/Up+cuO0rcRGXzfOGpM4MtPUFuZJ9RTvi0QptOGkmMt0bd4+EplO5/F86INFRlR2NIyaL95tndpojH6Igm2pRJ1VL6u28C0ccO4BWUkaQmh2lUIWU3eIkaPUb/rOOIoTQlBoMZQ+yS6x5uattxLnyPcgKKa1koQrp2k45QlxV23hqnxvCGkSVdjuqnmKvPHpL1f4eyFdfJNCmEm7dIl+8+U3yRS5JoDX7cbpdPAVDegywrOqzxA4CSHmcqWWdmdhWncS5kOhWFKkO6AEzT0pWRandYdR9EC3tI2yIPkiGCEdu5CJETJ+BqgF/yOsgTvH3/u4Zfh2yNBuNhUAN/zdjHkB8ZZ9vTjPGX93hYM1htzbG6FGKwSprt77HwZmrGvye09YrTOGooAzVMBc6v2m/kkf3m3VzjL8V7iwTjewo0N43jVXbkObQd5H8M8twv9E107qwxMn8h0ksPrTiKMSEeAW2/3xhCMJEwBu5pRch0Ps1jN3A0q3VDPfRiGRQQKJoBUWwTLuMy9BAwbnGkl5GCCJbr1qahqRuTk3kdDanFMD/zQ/kSWt1krE1lVwwhnsGi81fp/AAlNuFylN4bd2yTzh7UXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB3375.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWMvZ3kzbk0zTVJ1SGlnck9xVmN3QWZIN0MxclZCbVFiV2x6Z3p5Y28rS3Bx?=
 =?utf-8?B?VkhmcmF2OWdVVE9OTVBvaGVyNnNwS0Q4dUJEZWNJVmdmNmlPUVk2SzIycDlJ?=
 =?utf-8?B?MlBJako5UGEzeXF2YmIzTUJXNlVaTWJKWE5PQ3ROd0QwNk1ySTBBSnVtUWth?=
 =?utf-8?B?TzcxeStETHphYnZlQWo4RDVxQzNCQitpdDBjUDAwWG0vTXJWaXBTVllYVlJC?=
 =?utf-8?B?R04rN1FkRlNySnBwQUE0Nmd0OTlGdnRzNi9hTVpKYU41bnFEVHQwdXJLNkw3?=
 =?utf-8?B?aTdYNmxGejJETUZLUzFzUjM1MnZFa0dOMTZrK0FyekFXbW54SzVuUVAzSzU1?=
 =?utf-8?B?Rk11VVpBWU9OeWNoK0xxTjFZMU1VdDgrWC85SzA5cG5CUS9TRFY3UHp5UVJL?=
 =?utf-8?B?RUZSRlAzdFZXOVg0UktYdlJWdDhDNERySVNUaXZKRmdqS1owK09ydFY4OFZ3?=
 =?utf-8?B?NTZWRG9XaEhiMENhK3h3WmptZENkbTZ4d2dJa1lQakpGNU8yS2ZvcmEvaGZu?=
 =?utf-8?B?VTF0ZCs3NUczdWcxWXVWbkZ0MnNQcCtrb0pGbEg4UWw1VUIwQzRud3lZRjNx?=
 =?utf-8?B?bTNCNmg4NURPSDJtM3RzeE96ZVk1YTJacTRKVmN2N3c4UUQyZmsvRlJXcENi?=
 =?utf-8?B?SVlWdk9UaEZDenlFYXIweUdFUUtaR0pQcmpnMXVDQjBra2s3TzlKUW93ZFRP?=
 =?utf-8?B?SVo2REUrRDMraTh2S1p4eTArWmowQk44M1ZNc1RtUTg1dGFuY3IxQXp0clQx?=
 =?utf-8?B?aWFCcDViNE43eTlGZklmSElZMnlvQXBnZ1YraWJYa0Z2OGkraWFmNGdqYmlW?=
 =?utf-8?B?ZTBtWnVSLzlNK3NqQnoyRnVRMzBRSjFRM1FUTS9iZTVKQnRuZ3djc0NpWCtt?=
 =?utf-8?B?bG1QSlJyNTBhNHVpcXpkOENZTFFiSU1iQVhJaHlNYnhCSEtTa3RZOGRDejQ2?=
 =?utf-8?B?K1ZPd0F5czlHbVAwK0lyQVcvNERTYWNCdjhhRjVGNytyckR3cDMzcnVKV0Yz?=
 =?utf-8?B?akw2eXhzOC9LY2gvTmpOM2lnNCtjcGdONjdsZmY3Q0d0bnpvbFFEUE5QTWVo?=
 =?utf-8?B?L2gvTnNFdENFbjYyeTZzclpmeFZQMTV5cHNhaTl0MW1GTkE3cjVEQlZPNE9N?=
 =?utf-8?B?WXgwa2hZYU40ZGpSSlBuMEhia2NNb0IvODAvK0duc3Rab3gvUFloWlltTWxh?=
 =?utf-8?B?YndqT3NFVnZHNHpkdzczckNRdDBLbmRNbGdoeUJvejFFdmE1cFhpOXhydWFj?=
 =?utf-8?B?aTg5WGZsTFZWaEphaWVSaWRpRGtmRWJuR0hmUmNWSzJTVEZmNmhDd24ybldO?=
 =?utf-8?B?N2RBaCtSZHJuTU1NTXFwZW9MdG4yOUdub0VzeEp6YmRXWk1SaXV1QkhuUkhE?=
 =?utf-8?B?ZmQ0OGZPMnZGVEZxSDM5azAxTWRWSE1PQXdJcW5FbDBabzFpUHU0bGp4d0lR?=
 =?utf-8?B?Ylk5UDAvVGQ5Y05jN1J3T1VIdjBWa3VOTDZIZC9peHZKT1FDc2pmOGY3Ymsz?=
 =?utf-8?B?K1NqS2JyU3UxSkZaZ1hrQjdnUDU5UmhDakpGZHJFc2JGMHRTaVZOZ0VuWU1k?=
 =?utf-8?B?azgvZm03Wk1MU1NxdW03WUlYUHpSMkZvdlhxL2FpZmlZaUVZeUR0Q3VOUnBn?=
 =?utf-8?B?QWd0K3E0T29JZDFMMGNnamNRNGJzSWlYOXpPTzNJQXNOcFhCeG5vWHBYTUx0?=
 =?utf-8?B?UWlPNEpTWUtybDVzTldrSldQeWdrb0l6UU41OTZlZDd2NTJHTXQrd2pXZDZD?=
 =?utf-8?B?U0xtaVZiVXF1YlRwZkNDOW0vMDluZW5weE45RmNsMnA5cHl1OEpsb08zWit3?=
 =?utf-8?B?UDU3SHdzcStSWTNRSFl2YnNaYmpYbkorTGtSVVd3byt4UVlKREtJWTh6TkFr?=
 =?utf-8?B?d0lVY2JoYndpRWxuYXYxMHdpSEpUM3ozRTdnK0cvNDNFRE5pWk1oM29aTEN5?=
 =?utf-8?B?OUtoVmtjclNaZjNCaEV1QlZqcnhDOW05eU5WU3RNUnZTL3B3Mm0wSWxCSUhy?=
 =?utf-8?B?K0xiZkFuc2daQ1NNck5GQTdWcFhzUG5WanJlWGFQMnJyRkdMMWRrK3FPVm5Q?=
 =?utf-8?B?MTFyVGZ4OE01YnFlb0tPdTAxYzFtTHNOblU3bGNlRDRzaEk0TU9yRmpobDgz?=
 =?utf-8?B?OGJJSDBhczNONEFIYmtoTGRWVUZOdTRUWmFoTjYzalJDWHpTcmlTU0xlZzJw?=
 =?utf-8?B?S25zOFhYOWpISWRLZXBCRUt0cjA4N0F0WTd0ZG55S0U0QStBTG14dzNsYjl0?=
 =?utf-8?B?VDdnMlBwM1hRdm1GWHVZY0c1R1UydTBqeG5jYjltOEhjTXdLUm9BdjI3VTIx?=
 =?utf-8?B?UytUaFpBdzdMeHBzbG1uVW9xTkIvektZZFJLZU1FUGhKbTVaaHZjZz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RyTBWFVvt7151aojYMyIuhU+TdXJWUGGMuyywMhsAct/y04DQOgauhce8ttlFsz4hejZ1slVJ17lfICUyIwYfGXXkj1+1F0Lln2XIG6XnDjsCplLxwpivDWiJU3n2I0UTKcfuWR7qtTvwQRI/NagQcLIRgTxXJE783BN+Cl60HPm8GlrK51XdIVSylDbpbvYXFQwsGzheH0v+WGiChHPtRoszc6+/ocKWjI2Qp4oNIZb98SocdhfHl/tHgzOwGMHA9nWqsqOq9GbsbEdhvqO6rCGcK4ONMv8HGYE+HwTvWDCsX6isMlWlSDrCE05zLO1xJbsae7V34odT6Sx3WTh7g==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB3375.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c8ab64-a6d2-4e9c-eeaf-08def8aaf221
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 19:50:22.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pm7ZZufCU2qYSAKSV2UNx58ii5OH7xrBQ/Z9k2qO4sm+rJ1dG4nvJPf04+bMfPrXfBV2aimt9ixxX3/68EMFJ1NAy8mDqQUXI/1wvXh5sVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8004
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 61zv1V1hd9MsDmps3_pfHqPq9atXEwCB98DflGIwg6s_1786564225
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCA2LCAyMDI2IDM6NDMgQU0N
Cj4gQXV0aG9yOiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2Vt
aS5jb20+DQo+IA0KPiANCj4gDQo+IFdvdWxkIGEgcmVuYW1lIChzb21ldGhpbmcgbGlrZSByeF9y
ZXN5bmMgb3Igc2tpcF91bnRpbF9mcmFtZV9zdGFydCksIG9yIGENCj4gc2Vjb25kIGZsYWcsIGtl
ZXAgdGhlIHR3byBjb25kaXRpb25zIGRpc3Rpbmd1aXNoYWJsZSB3aGVuIGRlYnVnZ2luZz8NCg0K
QWdyZWVkLiBDaGFuZ2luZyB0aGUgZmxhZyB0byAid2FpdF91bnRpbF9zdGFydF92YWxpZCINCg0K
PiANCj4gWyAuLi4gXQ0KPiANCj4gVGhpcyBpc24ndCBhIGJ1ZywgYnV0IGNvdWxkIHRoaXMgdXNl
IHRoZSBkb2N1bWVudGVkIGFjY2Vzc29yIGluc3RlYWQgb2YNCj4gcmVhY2hpbmcgaW50byB0aGUg
c2tfYnVmZiBsYXlvdXQgZmllbGRzPw0KPiANCj4gaWYgKCF0YzYtPnJ4X3NrYiB8fCBza2JfdGFp
bHJvb20odGM2LT5yeF9za2IpIDwgbGVuZ3RoKQ0KPiANCj4gVGhlIGFyaXRobWV0aWMgaGVyZSBk
b2VzIG1hdGNoIHRoZSBvdmVyZmxvdyB0ZXN0IGluc2lkZSBza2JfcHV0KCkgZm9yIGJvdGgNCj4g
cmVwcmVzZW50YXRpb25zIHNlbGVjdGVkIGJ5IE5FVF9TS0JVRkZfREFUQV9VU0VTX09GRlNFVCwg
YnV0IHNrYi0+dGFpbCBhbmQNCj4gc2tiLT5lbmQgYXJlIGludGVybmFsIGZpZWxkcywgYW5kIHNr
Yl90YWlscm9vbSgpIGluDQo+IGluY2x1ZGUvbGludXgvc2tidWZmLmggYWRkaXRpb25hbGx5IHJl
dHVybnMgMCBmb3Igbm9uLWxpbmVhciBza2JzLg0KPiANCg0KQ2hhbmdlZCB0aGUgY29kZSBub3Qg
dG8gYWNjZXNzIGZpZWxkcyBpbiBza2J1ZmYgYW5kIHVzaW5nIHNrYl90YWlscm9vbSBpbnN0ZWFk
Lg0KDQoNCj4gWyAuLi4gXQ0KPiANCj4gDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBbRmluZGlu
ZzogbWFpbi0yLTVdDQo+IFtTb3VyY2VzOiBvcHVzLTVdDQo+IFNpbmNlIHRoZSBsb29wIG5vIGxv
bmdlciByZXR1cm5zIG9uIHRoZSBmaXJzdCAtRUFHQUlOLCBob3cgbWFueSBTVEFUVVMwDQo+IGNv
bnRyb2wgdHJhbnNmZXJzIGRvZXMgb25lIGJ1ZmZlciBub3cgY29zdD8NCj4gDQo+IA0KPiBBbGwg
Zm9vdGVycyBvZiBvbmUgYnVmZmVyIGFyZSBzYW1wbGVkIG9uIHRoZSB3aXJlIGJlZm9yZSBhbnkg
b2YgdGhlbSBpcw0KPiBwcm9jZXNzZWQsIHNvIGEgc2luZ2xlIG92ZXJmbG93IGV2ZW50IHRlbmRz
IHRvIGxlYXZlIHRoZSBleHRlbmRlZCBzdGF0dXMNCj4gYml0IHNldCBpbiBtb3N0IGZvb3RlcnMg
b2YgdGhhdCBidWZmZXIuIFdpdGggT0FfVEM2X01BWF9UWF9DSFVOS1MgPSA0OA0KPiB0aGF0IHR1
cm5zIG9uZSByZWFkL3dyaXRlIHBhaXIgaW50byB1cCB0byA0OCBwYWlycyBvZiBjb250cm9sIHRy
YW5zZmVycw0KPiBpbiB0aGUgU1BJIElSUSB0aHJlYWQsIGJlZm9yZSB0aGUgcmVjZWl2ZWQgZnJh
bWVzIGFyZSBoYW5kZWQgdG8gdGhlDQo+IHN0YWNrLg0KPiANCg0KV2hpbGUgdGhpcyBpcyB0cnVl
LCB3ZSBjYW4ndCBhZmZvcmQgdG8gbm90IHRvIHJlYWQgU1RBVFVTMCByZWdpc3RlciB3aGlsZSBo
YW5kbGluZw0KbWF4IDQ4IGRhdGEgY2h1bmtzLCBhcyB0aGVyZSBpcyBhIGNoYW5jZSB0aGF0IHN0
YXR1cyBiaXRzIG1heSBiZSBzZXQgZHVyaW5nIHRoaXMNCnBlcmlvZC4gSW1wcm92aW5nIGl0IHRv
IG5vdCB0byBnbyBmb3Igd3JpdGUgd2hlbiBzdGF0dXMwIHJlZ2lzdGVyIHZhbHVlIGlzIDAuDQoN
Cg0KPiANCj4gDQo+IFRoZSByZXRyeSBmbGFnIGlzIHN0aWNreSwgc28gb2FfdGM2X2xvb2tfZm9y
X25ld19mcmFtZSgpIHJ1bnMgYXQgbG9vcCBleGl0DQo+IGV2ZW4gd2hlbiBhIGxhdGVyIGNodW5r
IHJlY292ZXJlZC4gU2VxdWVuY2U6DQo+IA0KPiBUaGlzIGFsc28gYXBwZWFycyB0byB1bmRvIHRo
ZSB0YzYtPnJ4X2J1Zl9vdmVyZmxvdyA9IGZhbHNlIGFkZGVkIGluIHRoZQ0KPiBlbmQtcGx1cy1z
dGFydC1pbi1vbmUtY2h1bmsgYnJhbmNoIG9mIG9hX3RjNl9wcmNzX3J4X2NodW5rX3BheWxvYWQo
KS4NCj4gDQo+IElzIHRoZSB0cmFpbGluZyBjYWxsIG5lZWRlZCBmb3Igc3RhdGUgY29uc2lzdGVu
Y3kgYXQgYWxsPyBUaGUgb3ZlcmZsb3cNCj4gcGF0aCBhbHJlYWR5IHNldHMgdGhlIGZsYWcgaW4g
b2FfdGM2X3Byb2Nlc3NfZXh0ZW5kZWRfc3RhdHVzKCksIHRoZQ0KPiB0YWlscm9vbSBhbmQgTlVM
TCBwYXRocyBzZXQgaXQgaW4gb2FfdGM2X3VwZGF0ZV9yeF9za2IoKSwgYW5kIHRoZSBvbmx5DQo+
IHJlbWFpbmluZyBjYXNlLCAtRU5PTUVNIGZyb20gb2FfdGM2X2FsbG9jYXRlX3J4X3NrYigpLCBs
ZWF2ZXMgcnhfc2tiIE5VTEwNCj4gc28gdGhlIG5leHQgbWlkLWZyYW1lIGNodW5rIGhpdHMgdGhl
ICF0YzYtPnJ4X3NrYiBicmFuY2ggYW5kIHNldHMgdGhlDQo+IGZsYWcgYW55d2F5Lg0KPiANCj4g
WyAuLi4gXQ0KDQoNCkkgYWdyZWUgd2l0aCBhbGwgdGhlc2UgY29tbWVudHMuIEJ1dCBhcyBJIGFk
ZGVkIGluIHRoZSBjb21tZW50LCB0aGVyZSBpcyBubyBzaW5nbGUgbG9naWMNCnRoYXQnbGwgd29y
ayBwZXJmZWN0bHkuIFdoZW4gYnVmZmVyIG92ZXJmbG93IGhpdHMsIHdlIGRvbid0IGtub3cgd2hp
Y2ggZGF0YSBjaHVua3MgYXJlIGdvb2Qgb3IgYmFkLA0Kd2hpY2ggYW1vbmcgdGhlIHRvdGFsIHJl
Y2VpdmVkIGFyZSBnb2luZyB0byBmb3JtIHRoZSBmdWxsIGZyYW1lLiBTbywgd2UgbWF5IHJlbGVh
c2Ugb25lIG9yIHR3byBmcmFtZXMgDQp3aGljaCB3ZSBkb24ndCBuZWVkIHRvLiBJbXByb3ZlbWVu
dCBoZXJlIGlzIHRoYXQgd2UgdHJ5IHRvIHJlY292ZXIgYXMgbXVjaCBhcyBwb3NzaWJsZSBjb21w
YXJlZCANCnRvIGRyb3BwaW5nIGFsbCBkYXRhIGNodW5rcyBvbmNlIHdlIGhpdCBidWZmZXIgb3Zl
cmZsb3cuIA0KDQpDdXJyZW50IGxvZ2ljIHdvdWxkIHJlY292ZXIgbW9yZSBmcmFtZXMgd2hlbiB0
aGUgZnJhbWUgc2l6ZSBpcyBzbWFsbGVyIHRoYXQNCndvdWxkIHJlcXVpcmUgZmV3ZXIgY2h1bmtz
Lg0KDQo+IA0KPiBbU2V2ZXJpdHk6IExvd10NCj4gW0ZpbmRpbmc6IG1haW4tMy03XQ0KPiBbU291
cmNlczogb3B1cy01XQ0KPiBEb2VzIHRoaXMgY29tbWVudCBtYXRjaCB0aGUgcmVzdWx0aW5nIGNv
bnRyb2wgZmxvdz8gVGhlIHdoaWxlICh0cnVlKSBsb29wDQo+IGRvZXMgcHJvY2VlZCB0byB0aGUg
bmV4dCBpdGVyYXRpb24gb24gLUVBR0FJTi4NCg0KWWVzLiBDb21tZW50IG5vdCBtYXRjaGluZy4g
QmVjYXVzZSBpdCB0YWxrcyBhYm91dCB0aGUgY29kZSB0aGF0IHdhcyByZW1vdmVkLg0KUmVtb3Zp
bmcgdGhlIGNvbW1lbnQuDQoNCj4gDQo+IFdoYXQgY2hhbmdlZCBpcyB0aGF0IHRoZSBjb250aW51
ZSB3YXMgcmVtb3ZlZCwgc28gdGhlIHRhaWwgb2YgdGhlIGxvb3ANCj4gYm9keSBpcyBub3cgcmVh
Y2hlZCBvbiB0aGUgcmVjb3ZlcmFibGUtZXJyb3IgcGF0aDoNCj4gDQo+IGlmICghdGM2LT53YWl0
aW5nX3R4X3NrYiAmJiBuZXRpZl9xdWV1ZV9zdG9wcGVkKHRjNi0+bmV0ZGV2KSkNCj4gbmV0aWZf
d2FrZV9xdWV1ZSh0YzYtPm5ldGRldik7DQo+IA0KPiBUaGF0IGNvZGUgd2FrZXMgdGhlIHR4IHF1
ZXVlLCB3aGljaCBsZXRzIHRoZSBzdGFjayBxdWV1ZSBuZXcgc2ticywgcmF0aGVyDQo+IHRoYW4g
ZHJhaW5pbmcgd2FpdGluZ190eF9za2IuIENvdWxkIHRoZSBjb21tZW50IGJlIHJld29yZGVkIHRv
IGRlc2NyaWJlDQo+IHRoZSB3YWtlLXF1ZXVlIGNoZWNrIGJlaW5nIHJlYWNoZWQ/DQo+IC0tDQo+
IFRoaXMgaXMgYW4gQUktZ2VuZXJhdGVkIHJldmlldy4NCg0K

