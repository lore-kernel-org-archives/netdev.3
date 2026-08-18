Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656C3B776D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070362; cv=none; b=R0JkX9RHAlT3OmYdbn4xSQUV/3RlvybHst0+GMptKkj72jPXJ/gxngnWuxo9766qx3GOAKLuXP+lRHRGurq+L+1dC91L7Geq9csw6JyryqzD+K4BL1YPZDF/RnFg4/hPl0KCBDIBzZ5G43rcKa5CTMTqFYeElyZDpUicRLlgMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070362; c=relaxed/simple;
	bh=hFAQfzghpWNU6LmtajzF+eg8+sNCuekIW+NUGMUSF70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tHU6tpmw6bEq54wcPYqnDD5t6MJ1rYiErIFOqXeRWB7MpGsDBcRKuGaO6yd/hkDzl3Ag5DlMh4vDLbVnbpE9mye38vNAAWuP4t21QKv0q7gkHveTTHyyMqrxwt0h9CcXzKJP77pVHPYeCoI2dkaijljpR6aqaTRT1NxGH90ASZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=fUc4hYVP; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="fUc4hYVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1787070360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFAQfzghpWNU6LmtajzF+eg8+sNCuekIW+NUGMUSF70=;
	b=fUc4hYVPVGZ/4NwEojZcaurHlEq4Pp75lN5DfVp9nc4Se6qKUkD9NDXbplEp3PzfEIAXU6
	nBvv4OkdsAWJaiG+1dhT+QXA+fSGvbTPSsrvUwFKqI4A7y30Ja3txfj6ii38UyCpbuZDLf
	pxmDNXvje/5cE5pHCStH5FHI0G340R5JTD/Ayoi3arjcRXP1Q07GXb751ZDWkc9SYXxPav
	GaWbhxpb6Y2Qv2pqFjvSgXSXwGh5RkmQBYg/nvFKrN7z9yuUijY43n0wBF+/obFy/ta5IJ
	vTuhEFWYq5ENAqEMb7q/UzOvwFKZm+OUIBKxoRZVvQTe++mvKV4MbcYM1JEL7g==
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-1-7RRMUgc2N1y0BxlS5lFQxg-1; Tue, 18 Aug 2026 09:24:02 -0700
X-MC-Unique: 7RRMUgc2N1y0BxlS5lFQxg-1
X-Mimecast-MFC-AGG-ID: 7RRMUgc2N1y0BxlS5lFQxg_1787070240
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 BL3PR02MB8148.namprd02.prod.outlook.com (2603:10b6:208:35f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:23:59 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:23:58 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Jakub Kicinski <kuba@kernel.org>, Selvamani Rajagopal via B4 Relay
	<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v6 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Thread-Topic: [PATCH net v6 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Thread-Index: AQHdKs/q7VW66rKlKES7HGsioAxWYLakAY2AgAADN9A=
Date: Tue, 18 Aug 2026 16:23:58 +0000
Message-ID: <DM5PR02MB33692A7DA56968540A3F950383A62@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
	<20260812-fix-race-condition-and-crash-v6-3-6cf90f4a271a@onsemi.com>
 <20260818090655.1e28cd61@kernel.org>
In-Reply-To: <20260818090655.1e28cd61@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|BL3PR02MB8148:EE_
x-ms-office365-filtering-correlation-id: 1418c6bc-9a49-4878-c0da-08defd451b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|10067099003|56012099006|6133799003|11063799006|4143699003|22082099003|18002099003|38070700021
x-microsoft-antispam-message-info: gzVXxJiNmuqM2JjrR4PC2A3FwIA242vMMJpbhj3vM2qPIzyofsqDh+LKAaFqNWck8G8tOD3A/NAcvbOOU2oQPYxD9ascXSedMOuas0kJdU1d//6n5QSqDu8Tdcs3DBTNChgMISJslt+DccAHVMwUtAMQExsApJ6ekcGyNLp+V5YL69q6jYncFXDHm4UYq54CH14Lzo0Pts1O0jV8kAyjUWYPqv9jHVN5Mmv+3Uz9DmevGf4zF5KNzdC/p/rBu2BsCjE9ZEgWZafcBalQh4GUrBADFyPD53WnE3+DZ6Vp1/Mb5T6BWxv9JjXpshF9uxVr0TNArMtCWwWzy1K67tvxEkr//WvQg6kSlgn51ciZgMgqJTUKcmmTeQZMg0lmckriiJ/4OcvSOThWBZcogu8bcu1ijKzRVVC7iYbmW2ro3naQiHRtZhXykM3mMeKDsAkOWW92qR1dz3M2/bU15l3TRhln75lRjq6kmlbJhAPMc/gw8e+/mAdWSP5a50Gi/FAleHA5wOWRhDWo7NLauChW1L6b6UZVngaiKIzpLetbHWk/Zg8tsceCOdVGrRkJVB8rvf6bkDNwlMnQs5Wu9uWZTqd+xo4RRUO3BpZBDbWCNyWSFaM+H4PGzkTmebsp7UnW+ZZjwvud8zcZ2LLbY3vShZQMwdCAiN0B4kKqY96tCn+O+K3uJGSha4PLulW+fMvt4mYz1fVYy5F01WaImSSclyK0jsFihHGxRh84PIHKh7g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1Y0QmIzdnFPN2pDTTUrcWt0VlhFK21zS0VvTTJnZ2ovRGFMMWJYY1VsK3JD?=
 =?utf-8?B?NzRVOG9xV2JabW9hZlRDRXhFUnpyWjA1NnRGT25PdG0vOC9lTHFWRmFlTjJ4?=
 =?utf-8?B?RU5CdWpZZ2ZqVHJtUFBwNHM4VDJ1bExtY1lNajhCWEw2SHZ3ZkVEc1cvYVRM?=
 =?utf-8?B?bHdmOWJEdS9Hc0JpNWpIMDNRM1I4VmpBT2ovYm53Tm9WQnQzeUtMd0pVNklo?=
 =?utf-8?B?Q1JydVBqN3o3VnRMOGl0M3RsaGFRK01KTDF0L213dGN4dkN6YlNlK25DbXcw?=
 =?utf-8?B?MXMyOXZuakVYcGtiQ2J0SmxuVHIwLzJVWlhlZTFOZHRhKzA3dDJYWTFyS3gy?=
 =?utf-8?B?c2NmQllXd3FVbTE2NEJvRTFYK2tjaEFJdXhUcGViemZKR0Rlb2pOMERUSkRl?=
 =?utf-8?B?SHQ2N2drdU1obklTYThkYW9GczFnVVYwNWRnU0tDWFRSbi9oSWpGcHFYQUdx?=
 =?utf-8?B?VFhXMWRFb1NnOFVIWUhQRUVuWnZEMENpenNrZE1GREM0dXozRHRydElOVXZl?=
 =?utf-8?B?OHhodWh6MGpLaVZuWHFFUzgzbE92QjcrZ2kvOVRsOFRHdk5BUTNMOXRtcWV4?=
 =?utf-8?B?MzF3VzhwU3FWK3J3a3h5K3pHeDdib2hpM0hwdm96ZWpKeWhvQjRjUko4WE1E?=
 =?utf-8?B?Z0Y4WWs2cnJtMmJGZ1phdHNwVm5Zb2dodEtGSkY1SDJUaXI1STdZNVdPZWMx?=
 =?utf-8?B?UE1lYkVpcE1KWFVaVTlkM2kySU02UmxxVUlPZENWd05aeWQ4S0laTDJwa0pk?=
 =?utf-8?B?U3dtRE1YeFNmWGFxVUtTMlR4MUN5dkpPdHNvMzYvQTdQRnVUdkhlZGIxZWNZ?=
 =?utf-8?B?cjNIRmNNOGZWakdKWUVjUGhqK0k3S21FNTRvVyt3azRMdGxNRFV6cVBDZ1NG?=
 =?utf-8?B?ekk5MkQ1RDV4bVc5dEpkSC9qMncvV3ZwanRRRklzcW13MUVlbytKc0tmNjUw?=
 =?utf-8?B?ZmNMcGVaaXRIRGtHTU5XQlJ2V3FMVklMemtKM1h4OUZ0Q0U2c3F3ZDlmcDZM?=
 =?utf-8?B?UXlad2RQY0hmTmdYQmwyRm00WU1PK1RRSmNtZHl2NzN0MWM4Tm9zUXBoRU1P?=
 =?utf-8?B?VlBzeU83dEUwSkJQeWh4SnNEaEYzc01BNXJSVzhaYmxYRm1nNzExOHArRXh6?=
 =?utf-8?B?eVdLTFpoVkdIYWoxYUVuMjFTeG5WaG8wOU9NQmM1WWUxYWFQNU4wWUp6MzVH?=
 =?utf-8?B?YXpBMEVDT2pZd1B3bWw4T1hGeG5aYWVuclFvQ1NMQzZpYS94bVVUVkxidmMz?=
 =?utf-8?B?a2UwTTMxUHVnSXdLVXhMd0UxSC9qNG5Da0hTSkNGVjZvdE9CTEYwWUVqT05G?=
 =?utf-8?B?WlpDUkUzV3lLeUNPRFQvdS9JcHM4SzR1MWJWeWpFa1RsTFBEWlBDcWRLMDJ0?=
 =?utf-8?B?SHB5dVFwSHZkQXBLMENLZ21IV3ZpUFZKRmx6Q3V4QWxRSXpCcDd4K2lnaVpJ?=
 =?utf-8?B?MEFINSttMTRlYUVkTkFwNkRucUE4TnA4N3JqTHhEZXJ3Y004ayt3eTN5MmE5?=
 =?utf-8?B?V3p0R09LeXJkZVk5MUllM29hZnFWT1c0Mm1ZbkxnSDR6OE5YQXJkZHIxK2d3?=
 =?utf-8?B?ZUYzV0g4RGV0UGUwSENENnBYbHZKcS9zeE5Ia1loNDk0NC9IQkNwYlYzOHVR?=
 =?utf-8?B?Sk1aRmV1NkpFL1NQNU54ZmNoUk5hc3RTTjE1UEhwSk1SZHZXS0lIZythcVY3?=
 =?utf-8?B?c1p1MW5PNmlmRWkzdU9tNEpYdzRQNU0ycUttNExZQy8vUDlIV3hqcWtMdmVP?=
 =?utf-8?B?OUhqRVhic3JLN1psSVBuSkhDaGNLNFhUbjkvOUQrekp0dGtoc21BbnljR3pV?=
 =?utf-8?B?UXp0QnpuZmN1djJGd1p4VUJQdDB5RGlEa1hkOS9XZUJ2NVNDeTQrNlJMWUhq?=
 =?utf-8?B?OTZHUVlvbEhXOEp5cGxRKzlXYUE4bVE1UW1DVTYrbGhLQzJkMHg5a0c0VGZ5?=
 =?utf-8?B?eUpaOHA5NWFPczZLbTVSajBWaTF4bUdPR1lWeTlNMEp3SkpQaU1ZL3BjUk1R?=
 =?utf-8?B?cDhLT3JTdWxJQWhYdnZNak1Hc0h5d1dndllmOUNCaUp1VmsvVEVMaS8rWVMw?=
 =?utf-8?B?RFM0TkRaSlg2QmU0TTFlRDljNjJiM3lCUDRQM3RGNzFRT2dzZ1dUVlRIK0U2?=
 =?utf-8?B?UUZNaFJ4S1lobGFBYTF1Q3dlL0h2bERqYUptVjBCMHR4czdBOFVDNGhJQ3d4?=
 =?utf-8?B?eFFGYWRDb1BXbmY0WG5mS0lJdkg1UUpqTWpaU0FrbnNLYU9oUGtFUG16M2tv?=
 =?utf-8?B?YXpBczNoaktCcC9lb1Y1aTB5WjNKT3JydmxucEJiSVZBeHA1OXg4aElPbk1z?=
 =?utf-8?B?Tk84dkk3VHRVK2FjRkdCVFUxejhtL2pVUzFUQ1pRdlYxTkZBZkVCdz09?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pd3EnBpAs/on7H7esBU4EElUioEoJhEqo64GiTTFg1q6MxqC7vQi0WmtRV0PSoPTDXAj4ydWjD0HmIl+SF/sGopLZzXdfPk8FXaJYifkfD+aO0QqN46ctcc8chhzM2+Acp9Fp5i7paGvA8oeqzqsgHwqL85FitE/doofBMq6AQepHLuWOSxIGw+B//HLBB8u0odCnvAVSIIkf37dTKssMtUGQLLXBc9HggeNAjq/JW6W78CgkLiwUN3eaU5giTjSaiepC2IHg66JVzxP8IH0RQxYX+TX+nKsDQluXT2EJ96m5C90uypLwe63nDz+S8R3iSJ5A5AaQUkgc/5SOTFusA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1418c6bc-9a49-4878-c0da-08defd451b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 16:23:58.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRLgtC1zCRilnL2J1GLwfGgHerMwZKZo9XzFZ8LZ8XUbeQcaaAK80QKJ/5z5nsjkwbs33/K4XUx7Wun2zvVweVFnE0txnzyxekGGbIZYgiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8148
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7y_8TZlCumBqE3eELlTj7K58NySTVvfkq-TbWRVOCZc_1787070240
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpha3ViIEtpY2luc2tpIDxr
dWJhQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxOCwgMjAyNiA5OjA3IEFN
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHY2IDMvNF0gbmV0OiBldGhlcm5ldDogb2FfdGM2
OiBEaXNhYmxlIHR4IHF1ZXVlcyBvbiBmYXRhbCBlcnJvcg0KPiANCj4gT24gV2VkLCAxMiBBdWcg
MjAyNiAyMDowMDoxMSAtMDcwMCBTZWx2YW1hbmkgUmFqYWdvcGFsIHZpYSBCNCBSZWxheQ0KPiB3
cm90ZToNCj4gPiArIC8qIGRpc2FibGVfdHJhZmZpYywgd2hlbiBzZXQsIGlzIGEgcG9pbnQgb2Yg
bm8gcmV0dXJuIHRvIHdvcmtpbmcNCj4gPiArICogc3RhdGUuIFRYIHF1ZXVlcyBhcmUgZGlzYWJs
ZWQuIEluIHNvbWUgY2FzZXMsIHVwcGVyIGxheWVyIG9yDQo+ID4gKyAqIHZlbmRvciBjb2RlIG1h
eSBpbmFkdmVydGVudGx5IGVuYWJsZSB0aGUgcXVldWUuIEludGVudGlvbiBvZg0KPiA+ICsgKiB0
aGUgZGlzYWJsZV90cmFmZmljIGZsYWcgaXMgdG8gc3RvcCB0cmFmZmljIGZyb20gZmxvd2luZy4N
Cj4gPiArICovDQo+IA0KPiBJIGRvbid0IGdldCB0aGlzIGNvbW1lbnQgYW5kIHdoeSB0aGlzIGlz
bid0IHBhcnQgb2YgcGF0Y2ggMS4NCj4gUGF0Y2ggMSBpcyB0aGUgcGxhY2Ugd2hlcmUgdGhlIHN0
b3AgaXMgcmVtb3ZlZDoNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIGNvdWxkIGhhdmUgbWFk
ZSBwYXJ0IG9mIHBhdGNoIDEuIFNpbmNlIHRoaXMgY2hhbmdlcyB0aGUgYmVoYXZpb3Igb2YNCmFh
X3RjNl9kaXNhYmxlX3RyYWZmaWMsIEkgdGhvdWdodCBJIHNob3VsZCBoYXZlIGl0IHNlcGFyYXRl
bHkgc28gdGhhdCBpdCBpcyBjbGVhciBmb3IgdGhlIHJldmlld2VyLg0KDQoNCj4gDQo+IC0gaWYg
KHRjNi0+ZGlzYWJsZV90cmFmZmljIHx8IHRjNi0+d2FpdGluZ190eF9za2IpIHsNCj4gLSBuZXRp
Zl9zdG9wX3F1ZXVlKHRjNi0+bmV0ZGV2KTsNCj4gLSByZXR1cm4gTkVUREVWX1RYX0JVU1k7DQo+
IC0gfQ0KPiANCj4gQWxzbyB0aGUgInZlbmRvciBjb2RlIG1heSBpbmFkdmVydGVudGx5IGVuYWJs
ZSB0aGUgcXVldWUiDQo+IGlzIHNvbWUgdmFndWUgaW5kaWNhdGlvbiBvZiBhIHJhY2U/IEkgaGF2
ZSBubyBpZGVhIHdoYXQgInZlbmRvciBjb2RlIg0KPiBtZWFucyBoZXJlLCB0aGlzICJsaWJyYXJ5
IiBoYXMgb25lIHVzZXIuIElmIHRoZXJlIGlzIGEgcmFjZSBwbGVhc2UgZml4DQo+IGl0LiBJZiB0
aGVyZSdzIG5vdCAtIHBsZWFzZSBkb24ndCBhZGQgY29uZnVzaW5nIGNvbW1lbnRzLg0KDQpJdCBp
cyBub3QgYSByYWNlLiBJZiB2ZW5kb3IncyBjb2RlIChvciBldmVuIGZyb20gY29tbWFuZCBsaW5l
KSBtYXJrcyB0aGUgaW50ZXJmYWNlICJkb3duIiBmb2xsb3dlZCBieSAidXAiLA0KcXVldWUgbWF5
IGJlIHJlLWVuYWJsZWQuIFRoaXMgdXNlIGNhc2Ugd2FzIHJhaXNlZCBieSBBSSByZXZpZXcgZHVy
aW5nIHRoZSBwcmV2aW91cyBzdWJtaXNzaW9uLCB3aGljaCBpcyBhIA0KdmFsaWQgcXVlc3Rpb24u
IFNvIEkgdGhvdWdodCBJIHNob3VsZCBjYXB0dXJlIHRoaXMgaW4gdGhlIGNvbW1lbnQuDQo=

