Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A31F5825
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112000; cv=none; b=T78p0NUk2mqqPC7dFKb012A/I9lWwsVGb98igExhbp/wu5QwYhzhWWHlAvoTt3UDPzcuwRDc3Mf2TEE97p18KkwpHxO87gSSO15caGRXCbBxK5XPHBJJ8Et3QDdMOK0rxjC2t60E9pRc3w/jkycViMJ6mYUMcxS9LnJqv9AZ5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112000; c=relaxed/simple;
	bh=p2C/vMCuM1NTnFGMI+3LeERVie3mtO58x0cAa3UIuog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TAUERuadamRqoOeM1XCJ7cUR26rZ1STmykmEKJX2zNhvqmgwfPjvCpbWST63V8imw9VJLBw86SAres1TB45VsFCUNHOmclSM+xgWVeOpkZOkVAF0oothBYQhGoT5t4cGn2QfFaZi5xsGTaI/SOEp/wftGIcV3HWhtRmr+xZ2l7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=R8DFwooh; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="R8DFwooh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1785111998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2C/vMCuM1NTnFGMI+3LeERVie3mtO58x0cAa3UIuog=;
	b=R8DFwooh6Xl3w/Hgoq3peajG3XJ6SBrSgOxs6TjpBwqdKoho1eIDc8Ta+aly07ALUdaNrd
	/9EGfbxVViqYwuXbTOpnd08OSjdpGiNbmOLHxz/0TmwSItYyCKN4SV00U/FV4Mnhp2OJk5
	hn7HMshXFxZ92U/qrW3qXCPKFuT4kyO3E2W97NGPSvjeeEQFYcde6Jwqo7yQVb2sZpA/8a
	5Ry4CBXYkryyWxBicPHbMz9OjXMXoI4L5rVOzStZoTpGAR/yn1AqRpJgjaDIOQsvEcbR3H
	rDjoYGisIiTZS/pCeivHrNMWbc27ocKp1++OPbAQX32kf1zPlPhp9ml0B0fnrw==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-15-ErlzuPo0MtucxMyNWiUb6w-1; Sun,
 26 Jul 2026 17:26:31 -0700
X-MC-Unique: ErlzuPo0MtucxMyNWiUb6w-1
X-Mimecast-MFC-AGG-ID: ErlzuPo0MtucxMyNWiUb6w_1785111989
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 SA0PR02MB7353.namprd02.prod.outlook.com (2603:10b6:806:e6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Mon, 27 Jul 2026 00:26:28 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 00:26:27 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH net v4 1/3] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v4 1/3] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdGLeoVL6TsfxYnUaMkZauN2GDwrZ5UrKAgAc0FjA=
Date: Mon, 27 Jul 2026 00:26:27 +0000
Message-ID: <DM5PR02MB33696E45FEF9C356B64D9CAF83CC2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
 <20260720-fix-race-condition-and-crash-v4-1-8273e2f38a1f@onsemi.com>
 <43382111-f55c-4ed2-bcad-586a51b3e413@microchip.com>
In-Reply-To: <43382111-f55c-4ed2-bcad-586a51b3e413@microchip.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|SA0PR02MB7353:EE_
x-ms-office365-filtering-correlation-id: c802fa10-561b-477c-7720-08deeb75b288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|11063799006|10067099003|56012099006|4143699003|6133799003|22082099003|18002099003
x-microsoft-antispam-message-info: UzReEiNm2Yl2vSDM3yR+drLrOlOlhx71PYBeUZ50kujBcl770vsqa9/9Ph/xHkLi0bgMXcf0kqJjGDprsjJv8cm8LUoonVyTSsCjfDQSzBbtNBj4YoGvs8iVhhFRIKbKwmgs/V5HdcaqcOQ2sev4DF5hB62PORKbCN0Y6x8Mgcr9qFBbxWZNNF7X0Unac3R/nkNgwlK56j46VkCZ/ZxRusaV3sqbnG2eWUl8U6uwIIAgAG7pj68ii4QpwXpWSrfFdTt2/60pX1oCk9cz2XgvAPyKYr+VzA3BqIlwBMUib/cJai0XnKvtYJ+KpuJth6G1bZQkAXhLg0MHwBnHTLhuavce3PTwNSqdQLPS+XZyNMlGRVcsZXtij4tlLLDitKMb0DxzzGgIVx0LzPP8fnm3fsabW06ht5WEoznliNdijO0q4sZCjLsrhwYfOu+YSlPApmdeUk9J7ftyw7jukOPDsB36x3TuBRoWUOaNCHIfErmnRhL4UNYoLWZBNVNgXUkqCT+hJw96iMYv6t503eGGOpeQ+XbaAOmZB57CYBD0OURxqY7BifwLXSaaikhBiVLW5f+rIZZOjJLitaNoQltCP/sQlJsGtqVgGTZujg4BH8KNCDNWHabE9nIvwhC/lryKmvHvDZjYtX8b04Qd87jtbT6UPRJJBdfjuElQI8CxAAAqDnWyGk8pZ/8a4l3GfTE/q3S+E43EPkVUIywhkuMv3Us73sSKj1ujRgLAYBTDMOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(11063799006)(10067099003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzdZelRHMTJqbzl1SHhodU9EQ2JWNm9HS29OYWFwTG5iRkZkVHk5ZFE4UkFy?=
 =?utf-8?B?OHNuaGlYbUZQRFBjM0VGcFlzdmovcEh4R2dwZWpBS2YzRGZheDczcngzMm5U?=
 =?utf-8?B?UHYrZVJGWVpiQ2I1M1R5Zm1GbnBFSGRtcGNPem8zQ2tkeSs5VFVMMXpJNGtq?=
 =?utf-8?B?YitZNGZXdEtidUx2NU81ckFxTGZvU21mWjArbkdWZGhCSHhaS0ZFNTR4N1VI?=
 =?utf-8?B?T0tDKzFpVEhPZThBSE16YTVEV2NxclpMbEhKblBDK1BvUTlpY3RJUGFnakha?=
 =?utf-8?B?K09lMkFnSGc3Y2JCT2d5WVV0cGtLbzQxbVBSMU5SZXhIWGl0amw4dU9FRy9D?=
 =?utf-8?B?NXkxTTJnY0FNWTVscVFHNkxXek1pb1BjbkhEZmpoZ3Z0UVl2QjM1cGhYWG5C?=
 =?utf-8?B?VG40QzZ5akVJWG9sNEZWdS9FeUVLY3NPU2xEM2tYbWplaUxOb3lEUm1EKzdH?=
 =?utf-8?B?QURnU1ZSVDdvY0FodW52L0pZUS9zNzNOdWVkM2tKQnFUNlI2NEw5ajZwbUla?=
 =?utf-8?B?WWczcVVFa2JJRHdVaWVMS1k3VzF3eFpHN1Aza0tON24wL3BHUjUveUQ2OHh5?=
 =?utf-8?B?WWMzK1dLekdqVUt6TnJoRkU1WTd2d1FoLzhtWnFadXgxaVFpS0pUOS81RDhP?=
 =?utf-8?B?WW5USGpXbUtseGo0ZFhibS8zUU9UTFlpUWEzS3NsUWJKR1NhRDVSN3RnQy9Q?=
 =?utf-8?B?WlZsM3R6aHVuQVJqUEh0cWwwcE1yYXcvRHZBR2xVZUtLVFV3My9WV21DbVoy?=
 =?utf-8?B?ZGlOaG9BZk9MV2pWaVpNNVZ5eHNqUEI4anJvZXZwSVAzUGo5M2Fia0FsWGc4?=
 =?utf-8?B?THlUdDJUM3phcmpyQ1VnZlNuL1F6V3FTYmlJMEtMd0JtaFpNcllrb21RODFO?=
 =?utf-8?B?MlllWnFNekExUlR2TXRraDFFdkVxTkxheVkxdTFnVkZpU2R4UG83WmJ5WS9v?=
 =?utf-8?B?QXZVUlRmMTgxc1UvQ0E5MUNzWjZtUlVUaTRHc0NOdzMxRTRNcW1nbmRQRVdu?=
 =?utf-8?B?WFQ2QUU5cjZ6cnVrOHlSYm40N0phUVlKeWRVMVlxM0pyc21xa2VDZk0zbnNm?=
 =?utf-8?B?dkVnaEJnNlRlQU5HR1NlQ2ZQMnNwcGdjU0t2SUR0ZkxLaE1WY0xZTy9jSDRq?=
 =?utf-8?B?YVBYeWtwMG5ib28rOUNpV1REVDgybDBqS0xWWlRIZWd2cTBFZzRLOEVNL3Z1?=
 =?utf-8?B?L0pQdDhnbW8yVFVoMVdPL3JoaDN5aFBMR2ZmcThBMGpZTXUxZEQ1RGx6WjJU?=
 =?utf-8?B?SzhGTG5ZR21aUkVycW13V1BCTzAzcTRzdUxya25lUlA3YzVvaW9SMk9PUVJU?=
 =?utf-8?B?VkFkOURxZjJSbEtJdG51UWNDVDJ3VkFpQjAySWdhemJNUUxFU2tBeU9XSjg2?=
 =?utf-8?B?c0N5WXdiUUhLY2VRSlVsQ21qNWlaQWVWdGhveVV1M1ZNYzUzM09TVWF3clZJ?=
 =?utf-8?B?aHJwWXYraWg5UjRrdmNMRHNKTTNJZk5BV09PdXVHSEN3OWtjUFRFYm9UTTJw?=
 =?utf-8?B?MjZiTGQ0NXpvN0N0SXl6aENKbXBtNkNEd2tLTVlsYi9INmxsMEx4N1ZkT3FH?=
 =?utf-8?B?UWVWYjd4eDJNNmZQUlA4cFEyemZQRGtCam9rS001cVZIZjZXVGx0K3NSN3Fa?=
 =?utf-8?B?cWYrSW9QUDdBWC90S1J3b1lMNmJVcGZ6THlQTGtZdkxLNUswTnBxNUxIRUY5?=
 =?utf-8?B?L08vWXlhRlFiT1grUW5rRzRYYWltcjdRR1NHS3lqS0luWC94TU9aRFhHMHJy?=
 =?utf-8?B?V0poUkoyWDVsbk1CYUk5SXF2eDR2SW9mY08xVlJqRXlWci9QdnJQeS9yR3Fv?=
 =?utf-8?B?SzdJUzRCUHhxWTRRQkRYQmxDditOQ0MvNWFIYk1YYVhTYURGUlNiNHZjNndq?=
 =?utf-8?B?Q0ZmQ2pGaU9rdVVXUndhQzdESE5rSjM3OFNxNDdmdnRxbld3NHNPUUlJMnVL?=
 =?utf-8?B?VmxzTG9lUkZsMEF6NWRXd1NXK0lPcXN5VU9xemwrM2hWV2kvLzlPSFZrTnQr?=
 =?utf-8?B?MS9zOGRPUGRwVkJTaVJPcnZUbm81c1pvQkdCSHdMUDNwQURGTVhwdVZpaXp2?=
 =?utf-8?B?dzcvV29LNWNuUkx4Q3dXcm5jdXU0OXV4ajdEb0FBc3RsZEJ2d01OcWNaY01o?=
 =?utf-8?B?d05sVzd2bDhMeEpQUnJRaGh3S25lS1g0dE5XL00xbndTN09qWlNWQm5QbWJK?=
 =?utf-8?B?eWI1dzBTTk9pU2YzaUtnUk1wNjVCQm4yRVNvSFpRK1MrRkltdDh4cXlpSTVS?=
 =?utf-8?B?cG1odUp1bEthZkhSNit1VTZ1VVJqdFhmRzdCQ1hENTlkczN1cUJrZUFZaWht?=
 =?utf-8?B?blgzZGk4Vmh5dG5Na0xQUnRPdGk5ajdqSTk0bGJFZnNlK2t2T044Y0d6OXVI?=
 =?utf-8?Q?2aIdV3sc2nHZNO2g=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SFHMhwXTtMXB1lstw8Rc5clLGEVTvTlDrJKe5uX9r2MV9nSj3ztiZE0DevSGEVZ/r2OARGfn6ntTEeNa81x7axBSeqcCsD95IedrufJZv7t0cmPwVMSf9iu9ndpEHDUg0rW6OgGQEhy+9SrsUvHbY0TWqpJUYvZVFOwLJL2TImozkRisjWAcQJd/u7y5TbBXq/Fu3DkZDV9Sysrxwr9y9nmfoOBkzvV6TjkaIG8PKtll2uvqKu+rywVBctd6c0Vwpssa8ciaSXmPY0GR7HHRoacC9JFB2ufbop7BU12jCNhEvv6vb0Y2mFUruHVMHBsmMpFW8nKlLyHhxUj9Ibbt5g==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c802fa10-561b-477c-7720-08deeb75b288
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 00:26:27.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAK02KBtT+BV8dboLDn4UFDAd2kiAnQjApFKp5yxhZ2L11qEjbBZKUJkqUptPgLi66sKUPvXxpR8gTL2JLU0pu4MlQeLfE7SB4IJHMTvYAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7353
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tE7RaWFSNtoIeQmuB3Mp_knK-Dpqw1pgC_zWRH08gVw_1785111989
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhcnRoaWJhbiBWZWVyYXNv
b3JhbiA8cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVseSAyMiwgMjAyNiAzOjA5IEFNDQoNCj4gPiByZXN1bHQsIGl0IG1pZ2h0IGxlYWsg
c2tiIGJ1ZmZlciwgcGFydGljdWxhcmx5IHRocmVhZGVkIElSUQ0KPiA+IHJ1bnMgaW4gdGhlIG1p
ZGRsZSBvZiB0cmFubXNtaXQgcGF0aCwgbmVhciBza2JfbGluZWFyaXplLg0KPiBUeXBvOiAidHJh
bm1zbWl0IiAtPiAidHJhbnNtaXQiDQoNCkZpeGVkLiBUaGFua3MuDQoNCj4gPiB2b2lkIG9hX3Rj
Nl9leGl0KHN0cnVjdCBvYV90YzYgKnRjNikNCj4gPiB7DQo+ID4gKyBzcGluX2xvY2tfYmgoJnRj
Ni0+dHhfc2tiX2xvY2spOw0KPiA+IHRjNi0+ZGlzYWJsZV90cmFmZmljID0gdHJ1ZTsNCg0KDQo+
IEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRoaXMgaXMgdGhlIHJpZ2h0IHBsYWNlIHRvIHByb3ZpZGUg
dGhpcyBjb21tZW50LA0KPiBidXQgRllJOiB0aGUgZGlzYWJsZV90cmFmZmljIHJlYWQvY2hlY2sg
aW4gdGhlIGhhcmQtSVJRIGhhbmRsZXINCj4gKG9hX3RjNl9tYWNwaHlfaXNyKCkpIGlzIG5vdCBw
cm90ZWN0ZWQsIHdoaWxlIGl0IG1heSBiZSB3cml0dGVuIGluDQo+IG9hX3RjNl9leGl0KCkgdW5k
ZXIgdHhfc2tiX2xvY2suDQoNClllcy4gSSBhZ3JlZS4gSWRlYWwgd2F5IGlzIHRvIHByb3RlY3Qg
ZGlzYWJsZV90cmFmZmljIGlzIHRvIHVzZSBzcGluX2xvY2tfaXJxLg0KDQpCdXQgZGlzYWJsZV90
cmFmZmljIGZsYWcgaXMganVzdCBvbmUtd2F5IHRpY2tldCB0byBzdG9wIHRoZSBkZXZpY2UgZnJv
bSB3b3JraW5nLA0KV29yc3QgY2FzZSBzY2VuYXJpbyBpcyBvbmUgbW9yZSBpbnRlcnJ1cHQgd291
bGQgY29tZSBhZnRlciB0aGlzIGlzIHNldCBieSB0aG9zZQ0KZnVuY3Rpb25zLCB3aGljaCBpcyBo
YXJtbGVzcywgaW4gbXkgdmlldy4NCg0KSSBhbSBvcGVuIHRvIGNoYW5naW5nIGl0LiBJZiB5b3Ug
KG9yIGFueW9uZSB3aG8gcmV2aWV3cykgd2FudCB0byBwcm90ZWN0IHRoaXMgZmxhZyANCndpdGgg
c3Bpbl9sb2NrX2lycSwgSSBjYW4gY2hhbmdlIGl0Lg0KDQo+IA0KPiBPZiBjb3Vyc2UsIHNwaW5f
bG9ja19iaCgpIGNhbm5vdCBiZSB1c2VkIGluIGhhcmQtSVJRIGNvbnRleHQsIHNvIHBlcmhhcHMN
Cj4gYSBkaWZmZXJlbnQgc3luY2hyb25pemF0aW9uIGFwcHJvYWNoIGlzIG5lZWRlZD8NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gUGFydGhpYmFuIFYNCj4gPiArIHNwaW5fdW5sb2NrX2JoKCZ0YzYt
PnR4X3NrYl9sb2NrKTsNCj4gPiBkaXNhYmxlX2lycSh0YzYtPnNwaS0+aXJxKTsNCj4gPiBvYV90
YzZfcGh5X2V4aXQodGM2KTsNCj4gPiBvYV90YzZfZnJlZV9wZW5kaW5nX3NrYnModGM2KTsNCg0K

