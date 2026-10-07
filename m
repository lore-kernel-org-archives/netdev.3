Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F264E0B8E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400732; cv=none; b=fdWdEHsYxBE9F/2PQDhVZxlls3IxOjvIylcjqXy1ZrN+chuvCi8hsJ6hgZdgdMUhIdWMkV0TDRqOtMDH+eJy9RMbwHxCjPY+9oPDEiijZbHRyNgelM1xiL1jPVKoeX5OAe3tVKNHX+dz6UE3zDoC73L8+Pl+6iIIfriIQOTQxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400732; c=relaxed/simple;
	bh=NDOqaiCPZbmVDpM4T5ChpCMdzxGghgTgZqLBFn6F0fw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iVSFxioERrTozVoLdVmUEYzf66K6DJTWgGhnizmsQaYzMqVkBUFxX31k2AQtPLdEB83eC+IqTUqBXwyqp1mEC5+XuSNh6X0Pb6JJU4Rtgh7ranZOAU9Cl5uyglKxhovtHWDV+zJN9iTeTnn2yYdanZLmPQlwyXFA4FLDSK/ntog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=TRgRJ2/k; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="TRgRJ2/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1791400717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDOqaiCPZbmVDpM4T5ChpCMdzxGghgTgZqLBFn6F0fw=;
	b=TRgRJ2/kbDQuXUMKJdA1qw3FmYXRj6OvfkAUigFx2JhrNLpHuIdaJYnZ2ObAMlG/UA3OQC
	AbyxCuvez4fIwuDZws1hsswgIgi/C2C9jKl0EA54hnCVxJBppHWltge2TAnGvCm8Z6/l/5
	8gJruiV+QQyKX2DTyJbpcB6a5l74vu03VePbVOc9vZSYELnvval3LJ6oeml8+IDKU00KY+
	3CwtfKjNcs359qQJQXDquiggHdOwphRL1YNxCGv1wc7OfZ7kiQg3bvXSOe6sf2TXupmz0q
	EziohFxgJyMRo6ILN0aFtlaC/MctE6zuovez6A4xJo/mDsrIPneJ71SJj4V9kw==
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-69-r_Z81386PimpFZJIG2ZKfA-1; Wed,
 07 Oct 2026 12:18:33 -0700
X-MC-Unique: r_Z81386PimpFZJIG2ZKfA-1
X-Mimecast-MFC-AGG-ID: r_Z81386PimpFZJIG2ZKfA_1791400709
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by CO1PR02MB8633.namprd02.prod.outlook.com (2603:10b6:303:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 19:18:27 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 19:18:27 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Richard
 Cochran <richardcochran@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Jerry Ray <jerry.ray@microchip.com>
Subject: RE: [PATCH net-next v8 09/11] net: phy: ncn26000: Support for
 loopback
Thread-Topic: [PATCH net-next v8 09/11] net: phy: ncn26000: Support for
 loopback
Thread-Index: AQHdT5hHC3WxVOTR3EuDzLOt+jRFQrbwh36AgAH0P7A=
Date: Wed, 7 Oct 2026 19:18:27 +0000
Message-ID: <CH0PR02MB786718710AA0CD5A00D17D0683942@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>
 <7723127b-a713-4e96-bb63-fb2dc5367560@lunn.ch>
In-Reply-To: <7723127b-a713-4e96-bb63-fb2dc5367560@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|CO1PR02MB8633:EE_
x-ms-office365-filtering-correlation-id: b2a85bd0-2bda-468c-57e1-08df24a7c3bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|56012099006|5023799004|4143699003|11063799006|10067099003|18002099003|22082099003
x-microsoft-antispam-message-info: ruuxG2bGjr0qoQS16jbDtL/RWgbAccJVeYG60xNwhOJKaDGGJEWwFwlXvgQ6it4BgriY5XbbfTcS2lO35h8R+g2bNq1nYzjsLi0bqUSy/hZhbT2rXw6l+DXO9w1BRQ6TVflu/cU7B7TW/NxFMhOb4qrcobzy4aEJJOZq9AHI8I8UD57krn/uHTz0Wy6mQ5d6rkotpEikTb/jNsvgj4+Mc79L9mZ4kXMLC1tw4j40mOfVfY7A3gSf1rcOZJnZE/6qv6dWuu0vUO7mA5zZZfIIdf52j6WcYUwuunhrhleYFUTnLvKZcsZuVD8jEdArQWJ52mRyvTp732U7AonUV9qG6tng0AuHgtAUupRzuFoUeA6vw2azwo25Fvzq1F6IJ3O3Ro0GuEuac50CU5yt5TyAUiNKh4xcLU8UEctTqIxcBfXkp9OXX02l6UBOJCUMqYXuunrY45tLzNjLBqovlRYPxc8bLvJUia9eZ/c83kFod/V7L07O/9tz84hBlUmnsvhXksfhI7OOaYFt3FOPRksH21TQQjHdj4Br+1iZxfgmnXrlMCXISsJGsLeLmNVNO3CCo+3Q5cchGylEJ8nJRVqOWVeW+s7JAdjOUT/TE44oRjnzSTb5fXC6GOe0gEEWSyZakDKgyA8Vz9RZroCXvIsqAXCDB7/ml3GRXPGInDZCGvXDTXdDA8WBqRuQvv5NMja+0jdXBr5G6KanSTJ/PiaCAqTOU8Y1rpTBXqeln5yaf7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1lMb3NYcyticTJwQldGaVZDSytrRjRVbXVhalpjOVVoNFNXcEE0bndENmd5?=
 =?utf-8?B?WGx2SVNtU1p5OUJlL0MyNUVlVm9NWGkxbE91VDd2QlRnS2twTDZjZ2pndnFF?=
 =?utf-8?B?R1krUitaa0ZJblRmbVZPT2J6c2RrdUJVdFg1NlFsYzJ3NmhPN29kRURpY0tX?=
 =?utf-8?B?bkdHN0FGcEJqNktZdjdqdHRmVHN0RURyZ3VPK3hybHFUNXJzZERGT0NFOUhz?=
 =?utf-8?B?VjBoQUw4QnpJcVJkdHJLcm8zVlVWQ1V1NHl6aWErTFdUM1QwZDdlZTgyMEZ1?=
 =?utf-8?B?U2NNWncyUVdjd0lKbVhqTVp3SFoyR2xqd0RYMUJrakYzVnQzNTI2T3VmaEtF?=
 =?utf-8?B?L09jZytvSGQ1TkRIWXBqVTRVU1dkOFdWeDBkTUt0Wkc5K01IT3YzR0YzblRu?=
 =?utf-8?B?ZmNNWHhuKy84ZVdicnhwbytUVDF5ZmExZ2trRXoxU1pnTXpmeHIvUVNaayty?=
 =?utf-8?B?UXBwRG5UMGZyb2pyOWlFU3FxM0dNTzduYnp5ZEx1Tk56cVQ0SjRaVitYYlA0?=
 =?utf-8?B?NDhZQXQ1MDEvMEptaGZzWE0xT3BTeXljMWxsOHZnVWZNWkJqT25KNzlQcC9n?=
 =?utf-8?B?aG1BalRWQjZIZzJpdXorQUFWMy9YL0dzd0I2NlhEL216WDZkTW9lY3FQYzUz?=
 =?utf-8?B?WHNmVkVEZU5uLzk5S1BveGxaMXRycmRmc2NTdGxJSHlMYnNhdlhEU1pZUUVP?=
 =?utf-8?B?TEVjaVcydURYWnI5SWo3U2hBK0NmV3VRNkMzUmtXSGhBdFlRdDJLazRNaUxh?=
 =?utf-8?B?Ri9iS2YwaUlieXRUampHcXRqeTlhWTVIcXFyOGs3ZTU1akl2RE1ndDZhbk9E?=
 =?utf-8?B?V2JBa3RMV3g3SmxQcW9LTC8zRWJlRHhIWVFYTnpTSTlUVTYzZVZoL3hUb3lV?=
 =?utf-8?B?bUlUZ2Uwb1ZQdTJqc0ZjczljSndYS3ZOblJDUEtad3lPN3JvektGKzdBdTg1?=
 =?utf-8?B?RnVDUTRGOXUwNGR1T01KNkd4bUhzSFMrbEdyNnZLMWJZVytLMlB3MlBOZHNl?=
 =?utf-8?B?aS91c2RZK1UvYUZzamVZS2ozSXR4LzhUNDZtQzNvZU5LYzJxelIyNXNQQzhz?=
 =?utf-8?B?UHBRcFVWZTZsL054TGNHdWdBbVQwcGsyL2w4L1ZDT1FBK2krLzg3Z1UrQWxz?=
 =?utf-8?B?MUZXeERFWDJkUmNVbElpdzVmYkhCYnpuTEYzcThFS2dmU0RGSkx4MTJvbEhn?=
 =?utf-8?B?bjdJNWc3MHJISHF4VDlGd3dLT24wTXpjYlZFZHFrL0xpTGNMa3lkUVYwZm5x?=
 =?utf-8?B?ckYwSzZOWk5meGRBeStjcmFmcjdSMjl5ZFVFa1hXQ1VrYzZPMFA5UVR0c0lI?=
 =?utf-8?B?TElmN0FwS1BoSE5JL1UyUHBpelZnU3Jsakc1ZlE2S2NFSXFjTEFsZkVhTkdB?=
 =?utf-8?B?S0MrNzZDMmw5UFZqaVhnZU01NUpKN0t0R05ybUFrVTlSVWlVV24vWEZNUmFV?=
 =?utf-8?B?Zy9qaWZaNXhxU0ZOYzA1bEhidEE1UVkwWnlaOGxNQWlLSUoySENVMStYRmV4?=
 =?utf-8?B?UytTaHg5QUZ5S1JmdkNFY2lQdVVYY25QaEtDdTh0ampZaUxYRFl5RG51alpY?=
 =?utf-8?B?LzNNK0xXcEg4TVZBSWpQaG1OemY2ZXEyVmNvWHl4ZWVBU083TmRmTFBjS1RH?=
 =?utf-8?B?azVpRjRiOUsvWWQzdkNRRHZLSVB0S2RkTUxSVTFLYkh3bW9jOUM2TUxQUzJ3?=
 =?utf-8?B?bkh3STMxN3ZRVHdCQjYvSGpvTWgvVHJ3Z2xtVzEwUzBQNGxzRFhUdXFOY25D?=
 =?utf-8?B?VitNOW5weVdrZVhnM1RqRkpnak1iRDVnU3VkK2MwVTJxa1ZZWDVJbG1ETDZH?=
 =?utf-8?B?WGUvNHg2Szk0a3BFNlcrTDlLY0hWeGQ4b09XZUpSNVFuMEZKQXUvWjhJOTd4?=
 =?utf-8?B?K1huSW5HblVTdXpNa29KOHU1OThFNGxpcjVPb1I1MFNacGVaQVV1Nms3RkNN?=
 =?utf-8?B?V2tLbUF4QXd1M042UVYwcjhvTlpyeVRON0pIamZnaThsK2taU0JkbmwrSU5Y?=
 =?utf-8?B?YlJqckFvaERXaWFsUkNWNW45c3RJMHRXSVNMNStXbThQMjRSN2NyeklnMkUv?=
 =?utf-8?B?bVp1ZjdWeG5CQ2JSMWxXdHM3Vld1QkhQOW1xTGpaQitGeEpuTllDcUs2SjRN?=
 =?utf-8?B?bDluL1BlRGlXK2NNQksvc0FwbVB1d0hxRzlVY0FrS010VHhmRzk1bkNTdTJp?=
 =?utf-8?B?U0U5c0FXTFdFOUhvVGtxeFJ3WmxGd2t3M3d4M0lMbXM0dmkvZkExVnI2NXJk?=
 =?utf-8?B?Q0ZUZVdIMHZveXVxZWFnb0Q3NEpDSmxJTCtkandUTGZYWDNtNFBvRnEyRHNQ?=
 =?utf-8?B?eEllakNQMUZ0NWtuMkQ1NmhybnN1VGRMRC9VdDM4RjM4eDFja25jSURuQU15?=
 =?utf-8?Q?gJQ+gk9/hYbrEkPY=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vRTGI7RLY7RgXtWXmXTjpUU0t11qu/fJDcBC1k2yoxzMR/s2iMD1jcINBO+oN8ftNJ+qz5NpkHjmG6Hv0jmRBf+j4/WWHKwvi11nFmoT7wuwAYQaMsrQi6i+xp+vvm+90gs+/IGAB9/SzePL3brf9SHtXtvQpouZgozpkMNQIyDQYsu4HSer9P6RO7lI+uhI+vI6G4D2vSoTqBgYNXWKIs0uxQYkar4WveCmFdP1ZNbXMJtwe4Ud8JsAYCvRXE3Zj0BxJqzLGrqEcrj5o/KrRvToPssP9JwjbyFL9Hzas3/DlwYXwsfwwqhfnUgBm0fWGo8WSNkmF7dSfcpBdsL1Uw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a85bd0-2bda-468c-57e1-08df24a7c3bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 19:18:27.1746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPj6RoLnuBByDoLMOG8p8Y2T0wDgrvmN9vYk6bjhbZb7GZ0wUyvpd1nW7Uqn1EV0QaP3VI55PxqhQEro+UHnQlKXMhP5hAdr72Zp72xeZ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8633
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rmHmr9nyyfUUFaM0xDpOBJwDlgvI4-QUNH4-SC1wgBw_1791400709
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgNiwgMjAyNiA2OjA1IEFNDQo+IFRv
OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjggMDkvMTFdIG5ldDogcGh5OiBuY24yNjAw
MDogU3VwcG9ydCBmb3IgbG9vcGJhY2sNCj4gDQo+IA0KPiBOYW1pbmcgaXMgaGFyZCwgYW5kIGkn
bSBub3QgdG9vIHN1cmUgYWJvdXQgdGhpcyBvbmUuDQo+IA0KPiBmaXhlZF9zcGVlZCBjb3VsZCBh
Y3R1YWxseSBtZWFuLCBmaXggdGhlIFBIWSB0byB1c2UgdGhlIGdpdmVuIHNwZWVkLg0KPiBJdCBp
cyBpbiBmYWN0IGRvaW5nIHRoZSBvcHBvc2l0ZSwgdGhlIHNwZWVkIGlzIG5vdCBmaXhlZCBhdCBh
bGwsIGl0IGlzDQo+IGxlZnQgdG8gd2hhdGV2ZXIgdGhlIGRldmljZSBzdXBwb3J0cy4gSW4gdGhp
cyBjYXNlLCBpdCBqdXN0IHN1cHBvcnRzIGENCj4gc2luZ2xlIHNwZWVkLCBidXQgdGhhdCBpcyB1
bnVzdWFsIGZvciBQSFlzLg0KPiANCj4gTWF5YmUgY2FsbCBpdCBnZW5waHlfbG9vcGJhY2tfbm9f
c3BlZWQoKT8NCg0KDQpTdXJlLiBJIGNvdWxkbid0IGNvbWUgdXAgYmV0dGVyIG5hbWluZy4gVGhh
dCdzIHdoeSBJIGNhbWUgdXAgd2l0aA0KZml4ZWRfc3BlZWQgYXMgUEhZIGhhcyBpdHMgc3BlZWQg
Zml4ZWQgYXQgMTBtYnBzLg0KDQpXaWxsIHJlcGxhY2UgZml4ZWRfc3BlZWQgd2l0aCBub19zcGVl
ZC4NCg0KPiANCj4gVGhpcyBoZWxwZXIgaXMgYWxzbyBub3Qgd2hhdCBtb3N0IGRldmljZXMgYWN0
dWFsbHkgd2FudCB0byB1c2UsIHNpbmNlDQoNClRydWUuIEFzIHlvdSBjb3VsZCBzZWUsIHdlIGNv
dWxkIGZpbmQgb25seSBvbmUgb3RoZXIgdmVuZG9yIChkcDgzODY3LmMpIHJlcXVpcmUgDQpsb29w
YmFjayBzZXR0aW5nIHdpdGhvdXQgc2V0dGluZyBzcGVlZC4gQWN0dWFsbHksIHlvdSBmb3VuZCB0
aGlzIGNvZGUuDQoNCkFsc28gaW50ZXJlc3RpbmcgdG8gbm90ZSB0aGF0IGFtb25nIHRoZSB0d28g
dmVuZG9ycyB3aG8gaGF2ZSBPQSBUQzYgUEhZIGRyaXZlciwgDQpvbmUgaXMgc3VwcG9ydGluZyBN
QUMgbGV2ZWwgbG9vcGJhY2sgKGFkaW4xMTQwLXBoeS5jKSBhbmQgd2hpbGUgdGhlIG90aGVyICht
aWNyb2NoaXAtdDFzLmMpDQppcyB5ZXQgdG8gYWRkIGxvb3BiYWNrIHN1cHBvcnQgLiBXZSBhcmUg
dXNpbmcgTUlJIGxldmVsIGxvb3BiYWNrLiBNYXkgYmUsIHdlIGNvdWxkIGdldCB0aGlzDQphbGln
bmVkIGxhdGVyLg0KDQo+IHdvdWxkIHdhbnQgdG8gdXNlIHRoaXMsIG5vdCBnZW5waHlfbG9vcGJh
Y2suIFBsZWFzZSBleHBhbmQgdGhlDQo+IGRvY3VtZW50YXRpb24gYSBiaXQgdG8gbWFrZSBpdCBj
bGVhcmVyIHdoeSB5b3Ugd291bGQgd2FudCB0byB1c2UgdGhpcw0KPiBhbmQgbm90IGdlbnBoeV9s
b29wYmFjay4NCg0KV2lsbCBkby4NCg0KPiANCj4gDQo+IEFuZHJldw0KDQo=

