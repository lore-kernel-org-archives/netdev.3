Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E87569F1A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097491; cv=none; b=LZtsrErjfddGmXfdCv+HYfoXz5Sq6BuJ32eJCs2TDqTrlYamsDzV4GnTOGXsKpwj22T9BORkHUBQWC8+Q9/UNV5y1gyhlEgFjrdRVcBg47/pfDxYI5+BcsaGcNhXt+9Okl+fjGCHL93yWZFY8FI5VHjmEdeZxfVK2/1jhmv3wYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097491; c=relaxed/simple;
	bh=epn30mWjkiTwOj01gaRVI/PNJ6sdwtCyiCQDaSFwVWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RYDifvdEQtOZHuxaBujlLASHnUT+C4xgVB7gOqJ9KRVtuWBwb7/IpAxKqd92Q2AZJZ9v0pb3st2JyQ+Y1yP5/5tlfvqmvYQq9YXyFCZ3b0Q88YuI5XJ+rzBnr0dWyps/GxXCtjAhEacTwOQXDOwHTIaj7jnEd6UvHuhHUVPWR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=MRS/Stu0; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="MRS/Stu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1790097489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epn30mWjkiTwOj01gaRVI/PNJ6sdwtCyiCQDaSFwVWU=;
	b=MRS/Stu098NYSRIAcd5Wb5utXayZ771UToQQQfdi4lx4BxXDJiNQcSnyIoWusZKcxeroex
	YRANA2af1fh1E08xeW3VH+EBc3CDegYZHsS2QjVsDOQG8OPP2In8AzNbM29wsykJElTa5L
	cyiy8hr5xUeCcv3vqt9IMDlhH2H9RSKDGTQmJfAZjEgwsb3AE/vbqF2oaMmgjgWPKcJApy
	bjvl/s0GL6AB/Pt4l3Q3fq81/20+7TRL8k7qfLZWynz4hZZFtRSJymcXO9szSE/9xf5l7w
	Aofwa03ck3CJYI0LuR5byVCtl6RJqXKwXyfBwH6XDlTASBmLl9F+irFfV7C0kQ==
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-38-aAJTUy0oO4yCaZSylKu4Ug-1; Tue,
 22 Sep 2026 10:11:03 -0700
X-MC-Unique: aAJTUy0oO4yCaZSylKu4Ug-1
X-Mimecast-MFC-AGG-ID: aAJTUy0oO4yCaZSylKu4Ug_1790097058
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by SJ0PR02MB7120.namprd02.prod.outlook.com (2603:10b6:a03:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 17:10:57 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 17:10:56 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Alessandro
 Zini <alessandro.zini@siemens.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Ciprian Regus <ciprian.regus@analog.com>, Qingfang Deng
	<qingfang.deng@linux.dev>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4 3/3] net: ethernet: oa_tc6: add reset-gpios
 support
Thread-Topic: [PATCH net-next v4 3/3] net: ethernet: oa_tc6: add reset-gpios
 support
Thread-Index: AQHdSnIrkgfjvB7jmEaRvbSoLxmrd7ba00Bg
Date: Tue, 22 Sep 2026 17:10:56 +0000
Message-ID: <CH0PR02MB7867646C6EFB684AC8AA6FCA83832@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260918231450.55966-1-alessandro.zini@siemens.com>
 <20260918231450.55966-4-alessandro.zini@siemens.com>
 <56ded0b9-4975-46fd-93dd-b5777a24b2c8@microchip.com>
In-Reply-To: <56ded0b9-4975-46fd-93dd-b5777a24b2c8@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|SJ0PR02MB7120:EE_
x-ms-office365-filtering-correlation-id: fdbffa52-89a2-413a-9979-08df18cc7797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|38070700021|11063799006|10067099003|56012099006|4143699003
x-microsoft-antispam-message-info: mqoaf6mRP0b9vy/4/9wEpappqvs9dAoWMV0aLqUHm6Hda+tvksdBwZqAC7z1tjEz8m+8fo1+RO6hRGUsnSQiplxQPOCFJQDQBXp9ZA0ez3EqgH3LP2RUITnHcXtCr3RK0QLpYZz2LU26k5LtIF42AZROKX8D5edDjkO4ynjGmVtR/z1MmLnSSa8UCYTInOBstaEvu0VheNwcFtMcMQIuWXV1sFUYFpnvOdpyv0h5lOw5Oxd4u9j87a9oU46Aw3Nj/lmwp2UagRQAnI0Pqz7s+0We7Chl9v8Fy7YUF6TMkGpJ4Xl981n3oNMI67FA5DP755mFbQeM4kdC0um9sLEMH/rG8U/SuAVTYiTOT6CBKqJStF3IGitJ9XdVO2TFgs67oZ41G2/mRBYrCdnqalK3HrVhJ/jweH2ZW0eZh4Uj+zQ8rb03o0pSGk7O80DJKwACFYk3c697ift9iexGw/JJUIzjTtxAfhGqYmfHdJsrDuIBlsGmzA2gH+um8nnq8qbKPMzNQJc44aUnH2/yJX+2rEtWGaBunC3jP5QJnP3a7BGCYOZnI+AzxAlNE5z6iry+8a5Bk+zKdC/gxjhn3i9YOorYIeFSFCo4Qbg9twb8uwmmet9xrpcRJpYh92DG10PaYqTDy0I8ZKXFho9MTi91Ssts1hxFsW5jKuNFBRuwK9uB17bv90H5ab0ET0r2FyhCOtJJ2GNPC0qU9SM8jPVl6JTsgAkS8zjRoH8u+QLM3KE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGFLMFpEbU9xRmtPclFjYzFzT1JGY3RTUzdwK2hrWC95Tlp1UzJxYysrOTVR?=
 =?utf-8?B?ZlJ2SS84em1idTA1eHg3dTk4ZGdxZ1Qrb0NTN3pUUVd5UGFUS2hqZ3MrbXpP?=
 =?utf-8?B?MEZvM2ZCY1dOTGhlbTcrVStqWDVOQXNTaXFmSklFN3kvaWZIYjBKUkNML281?=
 =?utf-8?B?VHgzOXZEd3lqejlBbWxTbmJKSFNMd1FBOXQrQzQyUVdCWnZxYm5yZGtjRjZw?=
 =?utf-8?B?ZjBMOFdzNW9kVHpXdndTOHRkMkhmYWJpdG1uQkJFOGRUdFd4cktCSVR5VHFM?=
 =?utf-8?B?bEdLNnlYekFobklHWUIrMDF4YlZPeUltWnFoSzlsQW1RTGUzZW40QjZCVjFQ?=
 =?utf-8?B?bCtlTGFpV2syYy82ZThYUGhzem5lUFdKU09zYXhWRHJzbDZDcHQ2WGU0TWlq?=
 =?utf-8?B?K3Nuc1F4ZDZMcHE5MVBaZzVWeEJneWNkNy9SNEp4VHg4R2JUWS81cVQrSzNP?=
 =?utf-8?B?RHRGU3BhWDNNYUVpU050cUd5TUQ0a3p0WVNWeWFvNi9HcTlQVVBaTW1UQjky?=
 =?utf-8?B?eUMrMU1mWmpHVWlNWDRIY2dGWFhzUHJxUURsOWJ5ZVRVYS9zbUJrekRVY241?=
 =?utf-8?B?ZTQ0cVNDbUxHVjdOckZaM2dJU2tIODNQR3luV2JnZ1R0dEMrajV5azZxM0pB?=
 =?utf-8?B?ZEZraVF1SVBNQjlMbmIwaVE4TE96YVJTcEZtTkRkVlRKaUtjcmZORE4rMll3?=
 =?utf-8?B?ZHhTbGtpRmo1WVJPbHBCMTVCTUNXbXZUSWxlY2RoNlAwOVgzZElncXFIL05v?=
 =?utf-8?B?SGRIVXFLeGk2WVBQQ2tLWkEraUtrakdMdDAyVS9YZ0hZck1lRmZ3c1BkMzJ6?=
 =?utf-8?B?NVlwZG1PUEQvbVJoSks0aTh1eWlXd3dqNllMN04wTnd6eXVNS2hCMTF1cm0x?=
 =?utf-8?B?bk5HTEYzaFpxNmJRUXptZENFZ2tKRGRFTTlCRW5EbUpGcTcyTjZpcEdCWk0y?=
 =?utf-8?B?NVR5blZNMkJma0pQTTVhRVcyWk9wZU1Tc1ZIQTRiRlJUd3owdlZBMWMzVDdV?=
 =?utf-8?B?emx3cThlUmNBTmNlNnBUbjFGWmJLYk8rK0F5enF3MUVxR1ZrVFRUOEdpbE1P?=
 =?utf-8?B?d2QxWm1IR3gzVHhKblp1bFVZM3ZjUjRtU2hQM0llRHJ0amQxZGhpcjZvSElT?=
 =?utf-8?B?amRWZFlvNFE2dEo3bTRrVkVDdlAzLysrOXI3N09YcWdQa2FBdGM1NUE0aml4?=
 =?utf-8?B?MlVFenRwWnVLUUJkV1Y0SFVwSDVGTXZjcWFyZnRTV255WnB1R2JRbWhzOUVV?=
 =?utf-8?B?b2JEUDhBUEk4TzMyUnU2bDU2Z2dDMDBxVDF2T2FTUndkNlY4RS9PTVlXaXM0?=
 =?utf-8?B?Ny9nMnRVZUJHMXpNaFF3Z0FFbWs1TlAzS0tWWTVoNVJUSjRYSkIwWVZnUEg5?=
 =?utf-8?B?YzVndithQkNuSjRidCtjNlBiTWlEaWhZTHFHZ1ZYVDd4VlZNcHI4cUpYUzMr?=
 =?utf-8?B?Mjd5RTJtaFhod1YraFVCV1hHOFd1OTg1cVEyRVVBSDZ5czJxNlBhOTFRR1or?=
 =?utf-8?B?LzhBU3FvVTJ6RnJZem5nMEJWUThFSDNCc3dyQW5OTDJTanA3UkMxWmVMMzdY?=
 =?utf-8?B?dEhPQ2VRR282akt5WTgxK0RCdllzZlJkVlVkYkhrMDgyamtOU0Jtbm1lYXFZ?=
 =?utf-8?B?dlJ5ZjdXUFh2SGxwRWRmRkJObndUUFZjODlna2VHZ3FNRDJKaEdDK3hZalla?=
 =?utf-8?B?UndBKzl3Zy9mWTFiMTVvZERVaHpPQWp4MlhRT21yVWNtN0d2alBqT2szWTdH?=
 =?utf-8?B?aWFDQ0ZRdlBmSVl0RU90V0tsVVR0N0RPd1lXSXV3OWFKM1V3TXZ3eWlXU2d3?=
 =?utf-8?B?TTIxemwwandQVTRXZzZRYXRyMmVxcE9GNllhOVp3M3ZCT3N4KzhkdnZsc1Y0?=
 =?utf-8?B?U0RBdkdqMDFHUVpNZ3lNTnFoeXkwUEp0b2NDekErRzgxdThqRmQvMTlJa1hI?=
 =?utf-8?B?MTc1UzZkdkxpWnBpNjNZNEZ6L202YkxKY1pweVo3SmFGZUdFSTZYUXdJbGR4?=
 =?utf-8?B?ZmVnc2s4K3R6SlBLamJBQ1JYVmpwbktjK1BrMW00ZmpTTFZKMFFpT3BRWHpy?=
 =?utf-8?B?RFVvYTVLQTlGTlJFWXBIZjdoeksxc1dFNjl4b3VHVlVPVW5QRVhjekUyS3Vo?=
 =?utf-8?B?S3FuNC9BWjAyc3pybE5nOG1MZnNEbjk4MkNlcFhuTUtjVHdkWUhIVFBkcFZR?=
 =?utf-8?B?S3hDZ3Qrc1IrdFBJbW9jY2YrTTRpR2F1cGZkeGpJTWVnd3NGUHNHNVd4cjRP?=
 =?utf-8?B?d2RUeEx3ZDRBZFFSWXZDSlovNytLZkk2V0xhRXllSFIrbWxHVjVDYzFmZXg0?=
 =?utf-8?B?cWNFWlBhd04zR2pzcitpUXpyVW5DQlRuOE1nVHJyemgyNlhxNjR3UEtaQTRC?=
 =?utf-8?Q?tPbU9WcySnMKpwBg=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EPasDP0KL80WXPvEYo0Z/VbbYHLpM9EvD2r03BrN03BI5MmTMEaJ4c0CrSwRZjh/ic3sxjJEaskJTHn1pAaNatbwGFphQfCyZIffThdBvxgqjvQB7wMCw8tYxBXzgVPRqpULHRznJub5wEa0JxScNyrgORednU/uGak+kOxFBqnOpphdRKL60U8mx164z4wwnFCTm29uS7swn6Ct/zSHqwkCBMEPlf+wjgh+FL70P4J/2DWNZ6NrStJyRIbjGRfR//9dfU/wRtVxglaiAZNZoJAgX/IvonY5p160zQFZsn+bXoOJ7j/NZ3rujMQknEyyQwY/h0gcoQkpJtJZiZGb3g==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbffa52-89a2-413a-9979-08df18cc7797
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 17:10:56.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hs6GZOymvj2PB5wSOFLehlZW5juwZjSJAl0iO2veyh/d24QHAs9Wzpj6cuFg8xSiurjtgRrW8qDiXVIWcCx+kVmgoYE+jHZPX9XgbnwOUiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7120
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uVviLvn-Dg4v687kDMNlToP7MOlZ1bsrTjBhPj7dOQw_1790097058
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXJ0aGliYW4gVmVlcmFzb29y
YW4gPHBhcnRoaWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBTZXB0ZW1iZXIgMjIsIDIwMjYgMjowMCBBTQ0KDQoNCj4gDQo+IEFsc28sIGRvIHdlIHN0aWxs
IG5lZWQgb2FfdGM2X3N3X3Jlc2V0X21hY3BoeSgpIHdoZW4gcmVzZXRfZ3BpbyBpcw0KPiBpbXBs
ZW1lbnRlZD8gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBzb2Z0d2FyZSByZXNldCBwYXRo
IGlzIG1haW5seQ0KPiBuZWVkZWQgZm9yIE1BQy1QSFlzIHRoYXQgZG8gbm90IGV4cG9zZSBhIHJl
c2V0IEdQSU8uIEluIHRoYXQgY2FzZSwgaXQNCj4gbWF5IGJlIGNsZWFuZXIgdG8gcHJlZmVyIHRo
ZSBHUElPIHJlc2V0IHdoZW4gYXZhaWxhYmxlIGFuZCBmYWxsIGJhY2sgdG8NCj4gdGhlIHNvZnR3
YXJlIHJlc2V0IG90aGVyd2lzZSwgcmF0aGVyIHRoYW4gYWx3YXlzIHBlcmZvcm1pbmcgYm90aCBy
ZXNldHMuDQoNClJlZ2lzdGVyIGJhc2VkIHJlc2V0IGluaGVyZW50bHkgYXNzdW1lcyB0aGF0IE1B
Q1BIWSByZXNwb25kcyB0byBTUEkgDQpyZWFkL3dyaXRlIHRyYW5zYWN0aW9ucy4gSGVyZSBpcyBv
bmUgdXNlIGNhc2UgaW4gdXNpbmcgR1BJTyBiYXNlZCByZXNldCBpbiBhZGRpdGlvbg0KdG8gcmVn
aXN0ZXIgYmFzZWQgcmVzZXQuIE9uZSBjb3VsZCBpbXBsZW1lbnQgYSByZWNvdmVyeSBtZWNoYW5p
c20gd2hlbiANCk1BQ1BIWSBsb2NrcyB1cCB0aGUgU1BJIGludGVyZmFjZSBmb3Igc29tZSByZWFz
b24sIA0KDQpBcyB3ZSBrbm93LCB0aGUgY3VycmVudCBjb2RlIGp1c3Qgc2V0cyBkaXNhYmxlX3Ry
YWZmaWMgZmxhZyB0byBwcmV2ZW50IHRoZSBpbnRlcmZhY2UgZnJvbSANCndvcmtpbmcsIHdoZW4g
U1BJIHRyYW5zYWN0aW9uIGZhaWxzLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhcnRoaWJh
biBWPiAvKiBDaGVjayB0aGUgUFJPVEUgYml0IHN0YXR1cyBzbyB0aGF0IHdlIGNhbiByZXNldA0K
PiB0aGUgZGV2aWNlICovDQo+ID4gcmV0ID0gb2FfdGM2X2NoZWNrX2N0cmxfcHJvdGVjdGlvbih0
YzYpOw0KPiA+IGlmIChyZXQpIHsNCj4gPiAtLQ0KPiA+IDIuNTUuMA0KDQo=

