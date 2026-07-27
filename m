Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E421BC2A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785110817; cv=none; b=OBf4l4Fp2bf6ZpmFFiswnmPtLvDIaROoziaRHjPxigGlTJNXx/Pti7Gl3TViiHBJQPbLot5PueT+1YngYkcxDbbUdWVycBXueVIvuDRe1HD3LS9JA5qa0JS3gd6yat7IJyX7l5SM4FDDI1hyQYgr2lpvHXTkfKK09JPi7cJQ4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785110817; c=relaxed/simple;
	bh=7u/m7GVeIZVPP9yBYsuqj1nnvbcchiBfBGRmq3/i594=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NHfapi0pPN6GLwfW8D6y4DIBXr2trqjVwTPGgZcUHWRMa2lJP4paF60+vfVa/6DV1uJLOchiPktj+/UJgNykEPer1dtaoBJA6Hes60tsuT6cGEBR4e6xlYBb4OUbcdGnoStgMsOH6TEjtWEyeERa9nCwItaueBDPFWG6sQnv9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=bw8MolKA; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="bw8MolKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1785110810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7u/m7GVeIZVPP9yBYsuqj1nnvbcchiBfBGRmq3/i594=;
	b=bw8MolKAKlYy2ZPy6l8GmjIXyIQALicKh49/EpsU2hkFkJre2ND6a8uPK4svg/BxWricfG
	51qCJhiZTe8GM9scXnEgUUHmBiVbNagjlRr3ju+f8BXesb9bvtSLxEmG2MBd0Qsn0sLO4v
	sq+PAkN8DIWklVChuEYyhHHAlaGm63iz/t7/ph+mMckell2Ns6tQ8BlmINX54I+7j1cr6S
	JwDTSqQCdoEovLPbSK8lEeUcRD+/wFX3OtkfFUO/iuP5NouWnzpUyqm7wdEfmUIdsVOZku
	Arz6eI7gFRPdNxg6fNLZXbDt/z98tETje5ncBvDqzFCz1VY5n5/YUTv6oJMfBg==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-73-Q8MYF2NKMlqpc-zEzz95HA-1; Sun,
 26 Jul 2026 17:06:48 -0700
X-MC-Unique: Q8MYF2NKMlqpc-zEzz95HA-1
X-Mimecast-MFC-AGG-ID: Q8MYF2NKMlqpc-zEzz95HA_1785110806
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 DSVPR02MB11589.namprd02.prod.outlook.com (2603:10b6:8:3a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.12; Mon, 27 Jul 2026 00:06:44 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 00:06:44 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH net v4 2/3] net: ethernet: oa_tc6: Improvements to error
 recovery
Thread-Topic: [PATCH net v4 2/3] net: ethernet: oa_tc6: Improvements to error
 recovery
Thread-Index: AQHdGLerrB262/IW7k25zCk9+Bfz4bZ5UtiAgAcgtXA=
Date: Mon, 27 Jul 2026 00:06:44 +0000
Message-ID: <DM5PR02MB3369F0D8574CD2D41FD5462483CC2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
 <20260720-fix-race-condition-and-crash-v4-2-8273e2f38a1f@onsemi.com>
 <419bb6ee-297c-4b88-8306-bc6a286c2e54@microchip.com>
In-Reply-To: <419bb6ee-297c-4b88-8306-bc6a286c2e54@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|DSVPR02MB11589:EE_
x-ms-office365-filtering-correlation-id: 165e842c-088c-4c08-e578-08deeb72f193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|10067099003|11063799006|6133799003|22082099003|18002099003|38070700021
x-microsoft-antispam-message-info: Gm01K6rUzuoAajWpXry6PyFYTbL3uQ7jT2cCbYu8ME3Ahj2H1nQw5fyaHjb5OGbBxs4OrwTX6g4RIEBlKRy6okfgCHItfXZ0xJUllkad0LoX3ZiCNiWeZ3D9phyOGMCgmZuAXYEfVv8CMqTnwFmLPLGGMY/+Q44edomjH+QnhJS34qbXv3qNxlPwqxzl/Ilp7FpjUGpry1m4tXgV3RDVOOT8mNNuxDpPPGro76XIbb7p1NVToJeoGXLTXvXS9fPfXzAOgjsIz1WQ6HhX+BBGhU1iXk1laNN7bsVGZWXF3t+qXbJpI7OexVd5QCgslYBMpZYAWuCZEbBOkdDaNAXLcFAcDhHHtWPqK7qQ7OgrDdfZaee1npm7pEOdNy2GxaXlChB5G0ULuTUA2FPDxDqVSaIi/4vi5u4Xh5btkLX1Qn5OlQyMxn3ByPcBnguzhMPLK/wedPZe42lhcsJsLGzzzPj/nix1o9b6gNBWHZ8FCh8u4JZdwDTLac4nK0v/dOwERQwOkuHWlw2Ei+8/gNkwToWHoWYcMH6DVzUOp4SzxP6XQr2s8dLncAxb7xJsd2ULwwoPZNNHDQERtCVO/Hug8i6qSNkPyQz2HGuGKuRLBKGcdS6OdEIvYds22Nst8uJS69pin6FCPmmmyPwWBZPS7wqW8umrfGHfRGCsxjrxXPSpgcHCVSvNX68S4opVXJNmfhELnKGguUOMZPwwfj1C25eanAh8aeKUo8tsRBBzSAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWFrb1VBenE2VlFSOTNxWExQaDd1ZjFTUjB0RjJ0OG0wTGM1MmhOb1hEQU15?=
 =?utf-8?B?d3lmQjhhWVV3Lzl6eFFQL2oxaVFyUDlvWWU2MzVwWFpLdTlZQkVmUnlmdXBk?=
 =?utf-8?B?c0pNSmdMWEVXOFNjTGdWMmJ4Tm1hV2pBV0RHb3hBWUZGR1NPdkd1Zk9nUnIy?=
 =?utf-8?B?bElEekxtOVd5VXZJTzFKU0xXVVhoUCtvcXVuRDdGUXAwbEszMVVRejNKeWFT?=
 =?utf-8?B?WEN2VTNpbDlyQUxJYUVkQ1J3UDd2TU80Zk5wQ1UwM1ZFTjZLKzk1NzBvK0Nt?=
 =?utf-8?B?T0dkeFphWVZveEl2K0lyVjkzRk9yV3V6aDl3QlJBNzJha1kyRmFTbjRGSDRB?=
 =?utf-8?B?T0gwNXloVmt5QmVSZklIUjdoS2NHTzB3TW9wc3JDZDdUUkRBenRnZnFKNC9Z?=
 =?utf-8?B?UWJXQnhlYnkvVUg5ekg1VHJ0UEZ5SzVVN0lFdVFRalltWlZEWDdlMlVKMzJo?=
 =?utf-8?B?KzRaSkJEQ1VNbzZ2VkI1bXI2VjYxMjYxTkdNVHBhTFB3cnNGWjlhdVZ2OUZH?=
 =?utf-8?B?d3dmU3JZZ0xrU3pvRURiRjRQbEVXR0FQZTUvczFybVZ0NW5ySWlRQmdCY1hP?=
 =?utf-8?B?bE1ncmpZdjFtMzdTUWFacUl5aUM3L1QvMkErM3RHYmdheTRYTW5wdVJWZyt3?=
 =?utf-8?B?OXVEdkNtR2paelpLUEV0WWJRR3diVTNsS0oyTnVzaldTbjlCWlByTkxLbWQ5?=
 =?utf-8?B?SGdGZE9qakN2RTBHb0kvSjlRb1diOFk0TFE2ajJoNmVUT1MvWS9wYXh2SE1H?=
 =?utf-8?B?RjN5bFFaQ0s3OGpTVmRvUkI5K3B3Uk14S2dCZGRpSzlIL2cvdkM2b1FWQ2V6?=
 =?utf-8?B?VnRPV2ZKT2ZSUE1VTTdkZXc3QjNHZk5Cc1RiTnllNTkwWW5URExHWXNnYVgw?=
 =?utf-8?B?bXR4bHJDMU03STRPZzRHaDlYVmNrU3p6cGNWZExUUC8rNEJydEZvT1Fuck8r?=
 =?utf-8?B?Qnd1MUpBeExMRDIzSzY3ZHFuUGRib296bSs2K25NVWdpcjhjeVJaUWZ3c01X?=
 =?utf-8?B?d2VHRldwNDJCZnlhejBZY25iVWVNN1ZlZ3ltWFNSMU94WjBEbkcwUWdCdndO?=
 =?utf-8?B?ZE50bGs5OTN2Mnprbmw5Vm0zVytFOXlLcVVrV0hBTDBxdjVmMHpFMXlWWllH?=
 =?utf-8?B?b0Y5Mm5QUDRqZkw0cGQ0ZzdleTJ4aDhmaVhRbjd2d3puRVNQK3NGQ0hsSkJV?=
 =?utf-8?B?REg5RVloeGxGeXNnR0VxZUZRNDZNcVI3VVJYU24yY1laQjg1Y3duTEZrWmpE?=
 =?utf-8?B?d3l0eVJlZ2pPclFWdEwzSEZZdUdJcnVSeTM4NmMyZldDV2pQWG5FMzJzb1ox?=
 =?utf-8?B?M0QxQURDbzdpTENXakJMVjdLbU1keE1UdS9xYlNIdzdrZytVaWI1bGl6Rzdy?=
 =?utf-8?B?TytqNldMR2EyVmhDU2I5dUVUV3FlUUFRZDdXUERLTnhpd1JzTUdrcXNQRlc4?=
 =?utf-8?B?TGN6ak5EVXRGNkVnOWhBeXRWZi8rSXVKYktmRlpIdm1kcFZPUm9mTmlUazJz?=
 =?utf-8?B?RmVPaHB2aXNoR1QvbUZRRHhBRjZKR1g5cFp4dEpnNEl6MldRc2FxM3VQSHJp?=
 =?utf-8?B?OXhpbjVYSWgxaUdnZ2lGUkJ5ZmV0Qi84WW9SdDNzbGQyMDBWUFUrTytpUHo0?=
 =?utf-8?B?RW91cHZ0QXUwU0ZGdDE3V0xoSWlKQ1I4dncvQkZZeEZQaWpkRGhSSHBaVUlD?=
 =?utf-8?B?ak13TWQ3bERocnA3VTBDTk9GVkZHbWNkcm9uTzRweWlBc2x5YnJCVjB6dFJ2?=
 =?utf-8?B?WU5tYUpiaUE1TXhMVHZrUHR1SVI5YmUydFljTDFYckJDOVJJZlJKd2twcFVz?=
 =?utf-8?B?VW8wU1hHb2lCZFhETnZQeDBaTkVEQmE4d01SYlF3MnRoaENvR2Y2MHNVVjFV?=
 =?utf-8?B?NTJFUVNYSmcrQUhTRW1oL051OUJGalIvZzhueVFUTjBwN2dzc3FwRGp1b1hK?=
 =?utf-8?B?Zy9LR2pqb2NnT2tNR21LUzA1ZnJNa0lFTWJIZnFWWTBnejNjYUYzd29RUmpi?=
 =?utf-8?B?UkkvNDJGbXVNdTYxK2thR2NQMldSNVFMbC8wNm5ERnp4M3pYRDRydmZxamVs?=
 =?utf-8?B?RXh3N3A1TUNDVTNvcDAvU2diaVIwOUViTWxaUTIwRnhmVnk1ejBveGxYZEJv?=
 =?utf-8?B?SUNnMW5mSTdBa1ljOEtsNnQvcnM4NU90M0kyNW5SVk9IUzFWaGJtaitSeHB6?=
 =?utf-8?B?MzBGZVFCcWczMkIwSStiT0pnd3Q0dTc3d1RZcm5CUVdXOW5NbzltRUM1b1Bx?=
 =?utf-8?B?Mi9EQlhjUmtEVUFzTE04RnVyN1V1UzJlNTlsdHRJWTZnQlpHY3djaFRlNWpN?=
 =?utf-8?B?bUpQTzJaNDBpNTdXeEN6VlBiWGdkcUJKN2lsYzJCdnFtZmdJK0xoaGs5SWlT?=
 =?utf-8?Q?yFJUhHg0Pb+ikT6s=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SXdKmN1r8l3XpjFBdoZR9UZbWD1Y+/gAiwslP/8XECAyXInClPga1uWoKXT/gL4l7CYO8rwoCxtHMsVKCKOHwS71Rev1pF9Dtrwwb555WNGRWFBV/K5FQRmARcclZbqmUI55BCRcBet/GsxeDvh7rF9mYrxo4+qHqpuYVl1jfc57tcY0+9zu/AItRgC3l8nInfRzY+I2miYdLQ+eQMZ165Ap6vbot1GJhA4eaXo9dmn3hzloA+UBC754R06z98Kb7tU0R2xJw0sPNoGFTnrITLpEBfA1lf7QNZvewBuuUAthrrNsQ0IGauWib4Guvqlbue81p9F5kznsJWWAxTHjXg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165e842c-088c-4c08-e578-08deeb72f193
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 00:06:44.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4h6viYdLt0+FSnyP4NUEdwm1fRNA2lHF7CG/NQbXfSMSHh/5ZXEWAaBkaAFQWeNqYonQV4EV4csalCWE+IE+JDwj4DsEgpqoavbHQQ5LTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11589
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t_jRh2CPQhjgRPZdsN65cVo0TIgDDsPo-b56eK9kbNo_1785110806
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXJ0aGliYW4gVmVlcmFzb29y
YW4gPHBhcnRoaWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgMjIsIDIwMjYgMzowOSBBTQ0KPiANCj4gSW1wZXJhdGl2ZSBtb29kIGZvciB0aGUg
c3ViamVjdDogIkltcHJvdmUgZXJyb3IgcmVjb3ZlcnkiIChuZXRkZXYNCj4gY29udmVudGlvbiku
DQoNCkRvbmUNCg0KPiANCj4gT24gMjEvMDcvMjYgNzo1MCBhbSwgU2VsdmFtYW5pIFJhamFnb3Bh
bCB2aWEgQjQgUmVsYXkgd3JvdGU6DQo+ID4gc2l6ZSA9IGVuZF9ieXRlX29mZnNldCArIDE7DQo+
ID4gb2FfdGM2X3ByY3NfcnhfZnJhbWVfZW5kKHRjNiwgZGF0YSwgc2l6ZSk7DQo+IG9hX3RjNl9w
cmNzX3J4X2ZyYW1lX2VuZCgpIG5vdyByZXR1cm5zIGludCwgYnV0IHRoaXMgZHJvcHMgdGhlIHJl
dHVybiDigJQNCj4gZXZlcnkgb3RoZXIgY2FsbCBpbiB0aGlzIHBhdGNoIHByb3BhZ2F0ZXMgaXQu
IElzIGl0IGRlbGliZXJhdGU/DQoNClllcy4gV2UgYXJlIG5vdCBjaGVja2luZyB0aGUgcmV0dXJu
IGNvZGUgb24gcHVycG9zZS4gKEluZGlyZWN0KSBBbnN3ZXIgaXMgaW4gdGhlIA0KY29tbWVudCBi
ZWxvdy4gSSB3aWxsIGNoYW5nZSB0aGUgY29tbWVudCB0byBtZW50aW9uIHRoaXMgc3BlY2lmaWNh
bGx5IGZvciBjbGFyaXR5Lg0KDQo+ID4gKw0KPiA+ICsgLyogUHVycG9zZSBvZiByeF9idWZfb3Zl
cmZsb3cgaXMgbWFrZSB0aGUNCj4gPiArICogY29kZSB0byBsb29rIGZvciBuZXcgZnJhbWUuIEF0
IHRoaXMNCj4gPiArICogc3RhZ2UsIHdlIGhhdmUgYSBuZXcgZnJhbWUgdG8gcHJvY2Vzcy4NCj4g
PiArICogU28sIG1ha2luZyBpdCBmYWxzZSwgaW4gY2FzZSBpdCBpcyBzZXQNCj4gPiArICogdG8g
dHJ1ZSBieSBvYV90YzZfcHJjc19yeF9mcmFtZV9lbmQuDQo+ID4gKyAqLw0KPiA+IC0gcmV0dXJu
IDA7DQoNCg0KDQo+ID4gKyByZXR1cm4gb2FfdGM2X3ByY3Nfb25nb2luZ19yeF9mcmFtZSh0YzYs
IGRhdGEsIGZvb3Rlcik7DQo+IGZvb3RlciBpcyB1bnVzZWQgaGVyZS4gRWl0aGVyIGRyb3AgdGhl
IHVudXNlZCBwYXJhbWV0ZXIgb3IgYSBub3RlIHdoeSBpdA0KPiBzdGF5cy4NCg0KSSB3YXMgc3Vy
cHJpc2VkIHRvbyBhcyBJIGRvbid0IHJlbWVtYmVyIGFkZGluZyBpdC4gV2hlbiBJIGNoZWNrZWQs
IEl0IHdhcyB0aGVyZSBiZWZvcmUuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gUGFydGhpYmFu
IFYNCj4gPiB9DQo+ID4NCg0K

