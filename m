Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A813A258
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419601; cv=none; b=Ok3dWkoZOJkH/ObJAwJt3U6oOydun65fsfrTewEMn/TrUuCdogQPik2WnsoM8d796paKLPp9SLzf8q2jp4xHNHJhzcqQLaQbJeltjMlf1lYUI2kbit281fYER1oUtUHCoDpsr9li4vJakzOwyeAXYQjtj3S26f3magrQPqgI7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419601; c=relaxed/simple;
	bh=d+ncoBEtUBNTC+bc9W7fc7SD2OyKd42R7omvVQv6Urc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Qdx03nXANsFGpxsxAg39NbOGtafev1iAmWbJ20r+ylXtdBThPZfP3gn9fHDdSWRYZ8ZiB4MMzC6eLqD4GVHlg0UI9bbl3cpl1RBtRfDaaKlzLyT4rx7gnclOxhFZKQqFbx6SMOPVwvZPnHzdB8BfZ2kDaA36XvZaqt+73ekC6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=e5JAC0sI; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="e5JAC0sI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1791419599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+ncoBEtUBNTC+bc9W7fc7SD2OyKd42R7omvVQv6Urc=;
	b=e5JAC0sIMpus9cKybQRV+b/Zp+QvPY+HGoseRyBTG+fDMMzX4cm1IoGv/0qvmqbXqx4Jd3
	+1+gj6GQXpLBbYIYiksjU0syOBN6Tl35DSSR1Tlg/Tv2yn6Qux0W+fcaGeIZqMs1WIUehW
	SC6BsTyrFxNoW23uYNo0zRYHPo0pnr6y3rMGr9bpOFFvipx3PhjN7N0akydKG97BH1OlcX
	jB2bTFixf1bORPKBBHm9nxHoZi8LrRdVE+4Qjxe14mnULnNvExeEBDBSz2Be29rD6xmyzu
	r8F3zn8pHspiR1qJkGNYqNV1nFbN6luO80ZLYOMDQ1dw7pVgs298M0EimvfWGA==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-57-WIbFCSBlMT-xp9yW1euxng-2; Wed, 07 Oct 2026 17:33:16 -0700
X-MC-Unique: WIbFCSBlMT-xp9yW1euxng-2
X-Mimecast-MFC-AGG-ID: WIbFCSBlMT-xp9yW1euxng_1791419594
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by MN2PR02MB6704.namprd02.prod.outlook.com (2603:10b6:208:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 00:33:09 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 00:33:09 +0000
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
Subject: RE: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Topic: [PATCH net-next v8 05/11] net: ethernet: oa_tc6: Support for
 hardware timestamp
Thread-Index: AQHdUCZK/42vAQikQEyQnWutx/ewbbbwgbOAgAJVW1A=
Date: Thu, 8 Oct 2026 00:33:09 +0000
Message-ID: <CH0PR02MB7867BA9673FF8E34AF41CF2583932@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-5-7e011aacc309@onsemi.com>
 <89dadff0-d78a-4d4d-8ac2-be299e00ae9b@lunn.ch>
In-Reply-To: <89dadff0-d78a-4d4d-8ac2-be299e00ae9b@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|MN2PR02MB6704:EE_
x-ms-office365-filtering-correlation-id: 1081efeb-758d-4d0b-8116-08df24d3ba93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|56012099006|4143699003|11063799006|10067099003|18002099003|38070700021
x-microsoft-antispam-message-info: jvcumaNRpIP914NYQoXFXFMkPHVIeX647L+RMsMsgbbyvMQ86jci4OzeKFxftNPgD71IwYw7HythPrV+Ip2TwFJ4d37oCoPk0rs/WgsA20kHlaOXAVwhmmIGFI1n0MK2pUDbK0Yl3AuIJ1o8jLLuZvguSY6JtlxGin4pBzFLgjwUGu21ZXxZjF5kxviVL2/6+1z69g+1aOkUjh4/8kLooRGJxsWCTDt/NW/cDcmH2H8HAWKRzzUNt+JqLtmU7tcottZVmaIu8GcrPqADE2feiOhyzBpD//4J/5nwX67VT7SuUllXt8vsjh4/0iTYttyCWfwoIO174OH0spZfrQfvwdk55/m55CECdof4luduJe813cd+FyMZt2dfySVq3/MuaWZKNyH6mugCyIE9R4Ugnk8vumNrQJljDRBO+C6S+AFeCsTh9822t04hVhrB2WgPB4XwgYu3PS1jhKVauCimq7st0kCXGuOgkP2daXrHYna0QFwuiQFQGxKt9gvuVFvcRXSv3dEIMQ4v/T/z7j2DJgqGxQed9bdXTF3wH54hEIiPgg+FXBpEtvpaAts3w4XQd9Avo0r88cqyLEK1dnhkgpP0yB/3p3fudauF19jSd142DuaXr08VFHd7LJYpSgdSOlN7MUs55ztomg2Hk9h7pkVEy0NrE4IXhYEDGgBcdpnWStHMZtXO1xXXwoQXbY8M9LqTVOUJLbdMRreOD9FlauEleXYx2L961nEUR2TioI4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVBCejF6ZGVpcGF0cEUwbkVEUGVaVXpGVzFMczFoeHZ1R1AzOWU3Sk04ZWZW?=
 =?utf-8?B?UUJuc255V1hqaXp4YjllM21ieWEraFdaUUVsL1VvOTJQQjlSM3hiUjFXeEFu?=
 =?utf-8?B?ZC9FSXpBWEdFN0FGV2tDTzMxLysveVJCWXNEeGFpMkxjSjEraFI4RzZsRHJt?=
 =?utf-8?B?OWZTd3VFRkwxRy9vRHlGU3NaYzlUdTNWL1Q1WDVjU1JWLzFtMmFKZ1gydUw2?=
 =?utf-8?B?cWZsK1I5Uk5EZEx5RDhVNGZLNTZaTzVUZzhoMUxoUzlZQS9sTzhFNmNDejd0?=
 =?utf-8?B?UFB4QjFNYmt0RDBRb3RhdlJNM0xJRkJ3M0VVY2xEV3JuQTBXN1BaTnk3Nmx5?=
 =?utf-8?B?RjFERXJVa3J1WHJoL05YZGZDZVd6eWVuV3FKUzNiUys5VGhnUWd1Q3dyZ2tX?=
 =?utf-8?B?MWk3elJMWjhydDJrWWlNZkd6dGtkQ0lOdGoyenZEVGRtcVlLOTBvVlNucWtm?=
 =?utf-8?B?YUdUU2gwUVJvWXlOMDFXenlxWkRXUmtOZ2lIT1ZibjAvdFJ0ZXoxVnJyeXYz?=
 =?utf-8?B?ellaM2JZNjFyUWNEOW1FS2lyZTFDdlVSamhpZ0hFZitNR0hMbW1ZMDhwYmZN?=
 =?utf-8?B?dW5PMSs4K3hLTFJUdkpURzlrMzhqb1pkMVcvdU9CRk9tZlNXS0NYSEMxdzA2?=
 =?utf-8?B?Q3JUS3JYSHFySmVLZ040ZXVpNEZjM1NWbGtXY0p1UWdHUVRpSkkrNjFTK0Zu?=
 =?utf-8?B?T3hUV0txQzJjaGordWJoRklUaEF2VVFQdFhaQU1aMm1acXRwTVBJUUw3SFdL?=
 =?utf-8?B?QmlXVlV2TTR1QWpHZE81SStKM29MamNlbGwyc1REK3VzUVBSUmFWRE9WRm8v?=
 =?utf-8?B?cHZCdGg4N0ltRjRJamZ2SzNUd2J3Wm1GTUIwb0Z3STc1a21QVitFQ1RoUkYr?=
 =?utf-8?B?ZEwxUEw1a1JlcTZ4ZXhtWEl6N0cybXVEVzdrTmEveDBIUTBtNHRPcHVhOGdS?=
 =?utf-8?B?WlZOOWRNaWZ6aE9OOW96NzVWelYxQWhKMDJRcVNZcUl2eFR6UXpSMzkwSXF0?=
 =?utf-8?B?SWRXM3NkRlAvN2pvMnBzUnZKdEc2N2lMMUtlWEsvakxOc09SWWdwK2hpNDVY?=
 =?utf-8?B?UTNBdHRITmJ3c1JLS0c1YmdSZklDUmRRbnZzeUVRYjIxWWd6eEN5UWc2S09u?=
 =?utf-8?B?NDZ3WjhsQ0lIbkNJRmEwZTAvZDVQUDloeExqUm9YdVpTeDRUb2lzQ2hldndm?=
 =?utf-8?B?aWJKdnJQbzd0WjMxbm5LaTRad3RPWVFKWC9zNVNxeENoQjNXckk4Q0t3eVda?=
 =?utf-8?B?VGdiYVBIemhPUGdrazhpbzV0TjQ2eEJNMTBFaGxkRXlncmlZazc2Qis3eHU5?=
 =?utf-8?B?eFI1MUU5aytFVXVJK3JXYzFCYjgwZkdvZ0toeWZ2NW9pVzYyNGUyOXZuZHNy?=
 =?utf-8?B?Um1MQzd4OGV6UU5CWEdjajJ0bEdtdFdnVlNkRGkyMDJ2UHFsbTFuRkNCWlZZ?=
 =?utf-8?B?Vk9xQysvVVQ4RmRKa1pIQ2lMY3RsVktaUDhCRFl6UERmbFMzdEJGTVhrWVFB?=
 =?utf-8?B?cENNRzhPdC9GT0IyeGxpekVvWDc5Q3BXNFhLTFhZQVBsQ2hxbXExTkZ3aEw1?=
 =?utf-8?B?U2ZmVHBoVUxGTUFpRlM3Sk01dzFJWFNKYThrY0FaNWw1aEJmMHlkYXFqWlBO?=
 =?utf-8?B?U3luWWZCL29VMHVPVXZkYlRHSFBIVHBkdDJzVHFuWHk0VG5CRE1KSDVhM0JV?=
 =?utf-8?B?NlZPRWZHK3Mvb1VaUCtJQUExQjM0U21VK0xQNXpJeENGcnpwSFdpY2w3b3Bn?=
 =?utf-8?B?TmE1MGNRYmp3MFJaR1ZqbmVpV2NYdjBtS1dudWI4ZzlJVC9HTGx4WFdQY01v?=
 =?utf-8?B?UCtzbmJYTkt3MVdBTUd0OGRGTnBHSG54ME1jbktxc2hhOTZEdzhZRkFEbFc0?=
 =?utf-8?B?L2hINzNpTXV2NUVTU2pDd2tSWHY5SnFwbktMK3NUQjc1ZFQ0ZjhOZzMwdHpD?=
 =?utf-8?B?THprdGFSRi9OMnF5NStuT0pENkcycXdMOThoK0I2UXJPVDZWZW1IdnY1a1VD?=
 =?utf-8?B?Z1JMeTBsRUtLNGlvZGREM1MxSHBxbHRmcldiVDZDV09lM051L1FlVE0rNm52?=
 =?utf-8?B?d05EQ1BxbDRYRFBFcEo1bzNrNUV4QnJwTVFmZWJBUXpRc3ZtQzNQOWVrVXh1?=
 =?utf-8?B?STIxdVM0dk9kbExPcnlUV04rMGZZd01QcG5TN01vRTJIZTRHdDJGUWowbWxr?=
 =?utf-8?B?UWxPUzdsTFdJMmVZMGUxZWpOMmRvd2xmQWswZkluaTIxS2dGdXRCK2tmbjI0?=
 =?utf-8?B?S0xNa0JuTmZUYllRWG1MT2lsUlNKaExKTDQ2YVBTL0pJMDFtMFU5aUJ4V1Jh?=
 =?utf-8?B?bTBIeXhZVU9TbmZZQUUrMHIyUmNxTWN4OTFUamVKanZQQk52QWp4Z3lGSVZL?=
 =?utf-8?Q?iLxnpenCZ97y95dg=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HAv7bVnlRqIO+DZqhaRc+5eBBZoYlsSBcH7+WgRjWTzcQckPL3mpg7LZx+KX+WHdte1KkmYdZT2JpoB8D4sYkKDweXCjBrsHkHkkk4bCvIBRT9pf9EPo/wZo8YLkLP5rrES/NDii0dsdM4+9ourbCu3CvuuNZqboalOqDm90mTvFZu0SLyOGCvQgsFy7S8aSV7fhl29bK93PEzvCF5wlV2hk461niWw5Gqb0ulhjul+ytjGYvVNxZIiD7Npv2EQalHMqA9e99NvP7EH3kZUj34fI/j1h2WBPDW6e8Ivlq1cpYaaogAxnq0FcVN5k2xM85PxN4+Er0q0nagQJe7rpBw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1081efeb-758d-4d0b-8116-08df24d3ba93
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 00:33:09.6332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsuuJrHY68qZ9103BnvaH1hx7ZFFKbxUcMV6NyXyyABpKsM29m6cVjYruELO7hj96POUJZl+tAoRl/r30p5n+IS2g8CVViY4RlyobDwkMhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6704
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HNQOUm8DN9xwv_z5B1nTa3KfMBSm0Gn9jQqRUqDIsHw_1791419594
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgNiwgMjAyNiA1OjQ5IEFNDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjggMDUvMTFdIG5ldDogZXRoZXJuZXQ6IG9hX3Rj
NjogU3VwcG9ydCBmb3IgaGFyZHdhcmUgdGltZXN0YW1wDQoNCj4gDQo+IFRoZSBpbmRlbnRhdGlv
biBpcyBhIGJpdCBvZmYuIEdlbmVyYWxseSB0aGUgd2hvbGUgb2YgQklUKC4uLikgd291bGQgYmUN
Cj4gb24gdGhlIG5leHQgbGluZS4NCg0KVGhhbmtzLiBGaXhpbmcgaXQuDQoNCg0KPiANCj4gVGhl
IGdvdG8ncyBoZXJlIGFyZSBhIGJpdCBzcGFnaGV0dGkgY29kZSBsaWtlLiBTaW5jZSBhbGwgb3V0
OiBkb2VzIGlzDQo+IHJldHVybiwgbWF5YmUganVzdCB1c2UgInJldHVybiB0cnVlIiBhYm92ZS4N
Cg0KQWdyZWUuIFdlbnQgbGl0dGxlIG92ZXJib2FyZCBpbiBrZWVwaW5nIG9uZSBleGl0IGZvciB0
aGUgZnVuY3Rpb24uDQpEcm9wcGVkIHRoZSAiZHJvcCIgdmFyaWFibGUgYW5kIHVzZWQgcmV0dXJu
IHRydWUvZmFsc2UuDQoNCj4gDQo+ID4gfQ0KPiA+ICsgdmFsdWUgPSByZWdzWzBdOw0KPiANCj4g
SSBhc3N1bWUgdGhlcmUgaXMgYSAjZGVmaW5lIGZvciByZWdpc3RlciAwPyBJdCB3b3VsZCBiZSBt
b3JlIHJlYWRhYmxlDQo+IHRvIHVzZSB0aGUgbmFtZS4NCg0KU2luY2UgaXQgaXMgdXNlZCBvbmx5
IGluIHRoaXMgZnVuY3Rpb24sIEkgaGVzaXRhdGVkIHRvIGFkZCBhIG5hbWUuIEJ1dCBJIHJlYWxp
emUgdGhlIHVzYWdlDQppc24ndCBjb25zaXN0ZW50LiBJIHdpbGwgYWRkIGEgbGFiZWwgZm9yIHRo
aXMgb2Zmc2V0IGFuZCBvdGhlciBvZmZzZXQgZm9yIHRoaXMgYXJyYXkgdG9vLg0KDQoNCj4gPiAr
IHNucHJpbnRmKGluZm8tPm5hbWUsIHNpemVvZihpbmZvLT5uYW1lKSwgIiVzIiwNCj4gPiArICJP
QSBUQzYgUFRQIGNsb2NrIik7DQo+IA0KPiBBcmUgbmFtZXMgbWVhbnQgdG8gYmUgdW5pcXVlPyBI
YXZlIHlvdSB0ZXN0ZWQgdGhpcyBvbiBhIGJvYXJkIHdpdGgNCj4gbXVsdGlwbGUgZGV2aWNlcz8N
Cg0KR29vZCBxdWVzdGlvbi4gSSBhbSBjaGFuZ2luZyB0byBhZGQgIk9BIFRDNiBQVFAgPHNwaS1k
ZXZpY2UtbmFtZT4iLiBUaGlzIHdheSwgdGhlIG5hbWUgd2lsbCBiZQ0KdW5pcXVlLg0KDQo+IE9B
X1RDNl9SRUdfQ09ORklHMCAtIE9BX1RDNl9SRUdfQ09ORklHMD8NCj4gDQo+ID4gKyBzdGF0dXMw
ID0gcmVnc1tPQV9UQzZfUkVHX1NUQVRVUzAgLSBPQV9UQzZfUkVHX0NPTkZJRzBdOw0KPiA+ICsg
aXJxbSA9IHJlZ3NbT0FfVEM2X1JFR19JTlRfTUFTSzAgLSBPQV9UQzZfUkVHX0NPTkZJRzBdOw0K
PiANCj4gSXQgdGhlbiBmb2xsb3cgdGhlIHBhdHRlcm4/DQoNCldpbGwgZml4IGFsb25nIHdpdGgg
b3RoZXIgaW5zdGFuY2VzLiBUaGFua3MuDQoNCj4gDQo+IEFuZHJldw0KDQo=

