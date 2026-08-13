Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438148C8D2
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636446; cv=none; b=KPkFiH43uDxEz2VlgtiHs138pJX0rjP+ktTUbWIuDhjCUClkSNnWAsDcGfEawSWMm0vBwf+ekHjTPLlcMjuoIwosHsVMGNuowKmgXjcjRQ0HZGHgNoqtD+1MG6SRMgPn/pieyipCAhS65IzrlNB6xWrU78AwTVZPe3GiOmSrAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636446; c=relaxed/simple;
	bh=7nJuOnvd/jcBTZNo5MFUfnM6mqKZ0NxwKMRCa01A/KE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=fYLRBsTrNKIQaciVgRLTcMilEJD3/87Z17sYl4KrBRvePCxxosDuLlCcBJTujtW0myxQEbnLo1RytLsaTBxZGNm7l9KE/ytqCuSzVrPFJGX3QRKGtZt31cLgTQq8ETmbjgemzNglEJwlqb8B08XHWe5sp2FS0oZbh+aozVmSmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=RkXDMoM+; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="RkXDMoM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1786636435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7nJuOnvd/jcBTZNo5MFUfnM6mqKZ0NxwKMRCa01A/KE=;
	b=RkXDMoM+6eASflgEgTwn71DHeFyWcg32zI5biAIYNRfXW3AmGmzvu/P86/q8uVkjgGL0u/
	Qxobe1cbQXojuX04Dag7kSBY81jOrBqI96k8LwKvCCeE2Ohr4Q785kfaxupaTHKx5bE46G
	eEWyj2sJeWLkSsY1rvunFPrJo4ytJTEn0b25GATCxfymJfY519wPDNITsDuFBSSztqWOx5
	qGyWUZ5nnQKaOF+cxkibP9ZYKp14rmHSZJVCmbiahL8x5O3LtNbvudmub7jcc3iLoIh7Pz
	NcLgZ5cyf5xxryzzluA//MqMvPgHJ61a+o/obIbreJvJF3wygH+Yw7SACoVTdQ==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-55-U4qr6RExMZ2fzPC-kk1SCg-1; Thu,
 13 Aug 2026 08:53:53 -0700
X-MC-Unique: U4qr6RExMZ2fzPC-kk1SCg-1
X-Mimecast-MFC-AGG-ID: U4qr6RExMZ2fzPC-kk1SCg_1786636432
Received: from DM5PR02MB3369.namprd02.prod.outlook.com (2603:10b6:4:68::27) by
 PH0PR02MB7544.namprd02.prod.outlook.com (2603:10b6:510:4d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Thu, 13 Aug 2026 15:53:50 +0000
Received: from DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e]) by DM5PR02MB3369.namprd02.prod.outlook.com
 ([fe80::a77f:334f:452d:2b3e%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:53:49 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Topic: [PATCH net v6 1/4] net: ethernet: oa_tc6: Protect skb pointer
 used by two different kernel instances
Thread-Index: AQHdKs/qH9kSA0y0qky/TWZL6h0yBLacGY3Q
Date: Thu, 13 Aug 2026 15:53:49 +0000
Message-ID: <DM5PR02MB3369B6A836C24C3DCE913F5683DB2@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260812-fix-race-condition-and-crash-v6-0-6cf90f4a271a@onsemi.com>
 <20260812-fix-race-condition-and-crash-v6-1-6cf90f4a271a@onsemi.com>
In-Reply-To: <20260812-fix-race-condition-and-crash-v6-1-6cf90f4a271a@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3369:EE_|PH0PR02MB7544:EE_
x-ms-office365-filtering-correlation-id: bbc0a7d9-daea-4aab-c91e-08def9531120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003
x-microsoft-antispam-message-info: o/CFKot5pwhWrPJdKZQmXPKYqGvDWXih9o6qs8sntmrB4VEGAZk0JSs3Nb0ETkWaTCP0uDPuaLZkbNpCmm1964kibWPs6E01uTQ37b/HcOW8czVK6AOHeTwuDHwWYwquD19hrcNDNx3MMec/Bb0I0Uhn348lW8TBx04UY2t5OcShyhuC0qJbccg/n7V+bmTKqP8X9Q1x79/DlP7UaIY1UmWpnlsAmuI7m69/TzFmvrwBk/N9anev4ZecVfh+Apn/5kGSWbubA4DapZLhe+J7ZO6NSLuCTtiVDdxIANBtX7opFKryZEn/sXTtdcxDoZKPcfhXwb16WBMo1gVGOjCtyCFTQy7KBPxCQle+xaSeNfbVDJXO6EQZ4A/a9c5f9sD6c1syeg/qA2wBCYfaEEpCiOtIV4E5taasq20xypUgzA3EpMrOBKHjnomSAwitZHRdZ12n5ukEIhDNGWT9B1LvmvzNbrpnuTnHuCA6Ux51LqT9fNoOCTWqmJCFZqoyWjucHQLQ9hXtKWaD5b2bHABFuN1U8xUJA+87XQM8b94t9uxkNIigRBAMP/YjYWWilUGpZvlRzxmbOgKvnnJaLet92WQ2vswcqtQ2Jlj4dvnoKN4KhmwQXqq5M209G5jfnbgs7v9LtBzA1y/9nPoKWYkNqmozCZI+SYM/7n2zkD/tJOJZ4dLOFvvmyjHj8kOgNHJWG87DzArNheUkhdBDUpGZwGmHcmYApHkrHNMLrrCSjqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3369.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2hwcStISGozZkFPci9uUmk3dENxMUhaSHlZRkUwK2NLYzMzdGJVc0RjQ0Nm?=
 =?utf-8?B?Nmk2UU1TcGFiTkRjbGpFWFVoRFN2VFNWSFM2NVhKS3lIRVoxeWhkYmMvSy9u?=
 =?utf-8?B?a2xBQnRUVitqbUlmb05LeWtYb3pEOWxTQXBLSWNmYUU3Ri9Jd1BkUFU3eVo4?=
 =?utf-8?B?WlFRbHhIYkZOcCsyaER1c0N1WlJmZTFqa2wzQWVmZ1lzR0lFQ0tNbzBlOGtT?=
 =?utf-8?B?ZGZkQnV0ZitZQ1FJekhieEk1azBHMFBOVEhhQ1JaMlB5UVJOTk5xcmpBNE8z?=
 =?utf-8?B?cEY1aHJHZHNZMHdISGFZSE50bFVxZlFuYVhOcHcxOGVBNnJNMW5nWGptbkJt?=
 =?utf-8?B?Zm9SajNwdVBqMWhKUGRrbHovV2xOa2l6SUZ0clEraHQraU80SVR0d3pLSFVs?=
 =?utf-8?B?ZHNVdFJxLzVRajFaaTVmUlhKaVdWMmVMa25ETDBncnA4OFZUczNrKzBPZWRu?=
 =?utf-8?B?SXNXTjNIa0xuTkEzUFlwaklkWjh3LzJSY0w2VWxqYjVuYUsyNTk0ME0wSSto?=
 =?utf-8?B?cWc0TTA2SjBxMCtPdVdNcE92a2x0YUUwZ0dMNlZLUm8rbndXY3NQU0g1U0gy?=
 =?utf-8?B?aXNZMFFvbnJib0RLRHZsYXJ4WnpocUFyVXJIK3NJSHFNVEU4UnRKYW5NL1FQ?=
 =?utf-8?B?UmZnWFJLMmc3d1NhV2VJYWFVN0RyaVA4TUF4R3BxbWhQZEZXTkpGTFlSUW9S?=
 =?utf-8?B?SnZTVUQyVThqK2wwZ3dFRGEvYlg5eFl6WXRNaEU3dEcwSjcxd0pERGtKUWQw?=
 =?utf-8?B?SmdhL0RIQ3N6NlpXc3RUSHgrTEtzNUFLL1BsQUtZOUgwdUkwZGpvcy9nVkMv?=
 =?utf-8?B?YUZpZXNTWG1pczAyZENWeXgwZjE5YW4zZ0IxNVIyUXZuS0llMUVXbGpNVDlq?=
 =?utf-8?B?OXI1S0ZISUVIVXVRc2tXVDV5UFVqcmpldFhiZkR6aVBWNW5LSzFOd2FlYkN6?=
 =?utf-8?B?bWdtQk5wKzZReGp5SHVVblJhQ29JZ3pmL1ZGbEpBRUlnS21CMFE2a1FuczlO?=
 =?utf-8?B?NHovT1hQZGlyM3JCWmp6Q0JGcEt3MTRYRThBczlsRllvMGJxLytScTFPZGZ1?=
 =?utf-8?B?WWoyRGlxanhtRENKaGlocWFMVUJNR3ByaXpSQ0syMXEwU09sNWFRZ1haL29w?=
 =?utf-8?B?amxmNW9MS0pJZ21tTWxnbTdxYUxqenpwcStpYnBlS3JNemp4OEZZa1lVOGQ5?=
 =?utf-8?B?TnZ4YndoRTZLUXlmL0ZON1dOUmlHS0syMyt4aTczWWR3N2hOakV3Y2tYYURB?=
 =?utf-8?B?L2xZUDdUK3piS1ZEd2d5UjlQY3JmMk93OHZBREptRUxjZ2VSUkt6VGxJNTE5?=
 =?utf-8?B?M2N5YVR4NTVQVU42L0huY09VZnd6dmJSNmoxSzFKajcyaElDZEJkMkxsei9u?=
 =?utf-8?B?LysxbFNyeFg0ejMxUm93cEFXOVpPanJzZ3V3ZERFc3d1ZlBaMitKWmxZK1dH?=
 =?utf-8?B?Y3FNUXRyendPeTFFdEUzM0hFWWh4UXdaQ3NkZS9EN1ZrZ3NhTDlIdWwwR0Yv?=
 =?utf-8?B?dDl1dGVuaXR3bzExWVBsVmM5V1VCU2hvdFRkSXNxRmUrNVptNzNQOWNGV2ZS?=
 =?utf-8?B?b0JOd2J0V09pdk1weWdWL2FEdFNac29kZEIzOGpjSUpucjl6L0h2Nm5TdmZQ?=
 =?utf-8?B?aTQ0ZWVEQkxHSGhVOUl4TFkxdTJRNmwwUCtJeDZmck9qVldnaGp6ZC9QTzlW?=
 =?utf-8?B?S28rZTdhY21rOFNvMDZlWHYrZVNSODVlbG1md0RMaTZYYUY5ajluWjlaNkJz?=
 =?utf-8?B?YzhSNmF5dmpVdk5MclN4UXJwV2gwZm1Zb0ppWno5Rk5EYjd3RjdEY3JpVGJG?=
 =?utf-8?B?QUVyaU9FV1QrZ3hVUmpURDcyR1ZQb0F6YjNsdHZJMzdRSjZTZ2dNTy9yZ050?=
 =?utf-8?B?Qis4WHBlNDRQWXYvaGpmNmgxRnZieldwMUpadnEvL0h0aXhqQms1SmRjYXUy?=
 =?utf-8?B?aTlGYW1KUTl2QURxSzJ2SFB4N2l1SnBFMzNZTzVQUTJFTzIyOHdUNlVBRnFP?=
 =?utf-8?B?NTNBOVN0N1RScUxTeDd1QUoxTWFuWWRDdHVaUkNHayt0TThzdVBQY3V1Y09h?=
 =?utf-8?B?WGd0YUFLMW9mNXdFellDK1FGNDN2Sk9XRm1tdUJhMHoxb01la1RrV0JIdjFC?=
 =?utf-8?B?OXVGVi9VbWlraHc3MWlkcFVwS2hNMW1zdkQzaUV6ZGpUSE5CUUoyQXYzU280?=
 =?utf-8?B?aHZoK0lJM1NmR29nYXRxdXpQOFZUd1c3K1ZjRmNmbWs4UThIemF6d2hwWEpz?=
 =?utf-8?B?NnNTbHJaV3NpNldSbDI1UEM5d2paeURqZDJGQURIZmNVNllNb3p5aGVMQTZL?=
 =?utf-8?B?MmlETy9oMEJoSTZTeW1mc0NzSmsySlRGcWVWRFd2QTgzOW1VNUtCRFF2NlNq?=
 =?utf-8?Q?+n+/4PBlOVjTMPmo=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ht0kUHgIjIGrJdkMd3PMAunXrGqCi5n+zsqV/BmWFCYdNoMbk7zqDgOrvvXuouPfsRdBkVM3V2T+gbHDzcsWRbMqpcHUh0zzoV9BGiztdbjxZuOWtZWxdzaVhEfV5L4FckrAHaj3Ys45xfuMaOWjiYnCuHpFmUU8jdzieJRWqe+hjzmP0FAhefzaPYQIComQfZtmeyOvSp2LD1+KZADSp0iILJjKzJtJXGc+6hh6SBiAaPj4JY2yVpgFETXnk128GSJX8l455dlXLF0hioIVfljpmh9I532qhkyd43Lvzy/eW3zVFhKM62Bk8EhE7L3+wDMAAt8ZeZhND/kmvV8xow==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc0a7d9-daea-4aab-c91e-08def9531120
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 15:53:49.7964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KomISg3hpwqTXCM0lHUTXFHf8Klo98XhAxPaEWFUVEQShZCqoenujIzNPS4EbD5maakzvhMSVglAHR1vbaNtIWRk/yPemffwE17YVw4GVbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7544
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XD-c2mgQzCVZw2hxRPFJHW5LhJK3hUxPejk88t7BJD4_1786636432
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

UGFvbG8sIEFuZHJldyAob3IgYW55b25lIHdobyBrbm93cykNCg0KV2hhdCB0byBkbyBmb3IgdGhl
IGZvbGxvd2luZyBlcnJvciBmb3IgbXkgc3VibWlzc2lvbiB0byB0aGUgbmV0IHJlcG8uICBJIHNl
ZSB0aGUgZm9sbG93aW5nIGVycm9yIGluIHBhdGNod29yay4NCiAgICAgIkNvbmZsaWN0cyB3aXRo
IHBlbmRpbmcvbmV0IHBhdGNoZXMgKG5ldC1uZXh0LTIwMjYtMDgtMTMtLTA2LTAwKTogZXJyb3I6
IHBhdGNoIGZhaWxlZDogZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmM6NjkzIGVycm9yOiBk
cml2ZXJzL25ldC9ldGhlcm5ldC9vYV90YzYuYzogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCg0KQ29u
ZmxpY3QgaXMgZHVlIHRvIHRoZSBjaGFuZ2VzIGluIHRoZSBzYW1lIGZpbGUsIHByb2JhYmx5IG92
ZXJsYXBwaW5nLCBvbiBib3RoIHJlcG9zLiBIb3cgZG8gd2UgaGFuZGxlIHN1Y2ggc2NlbmFyaW9z
PyBTaG91bGQgSSB3YWl0IGZvciBuZXQtbmV4dCBjaGFuZ2VzIHRvIGdldCBtZXJnZWQgdG8gbmV0
Pw0KDQpGWUk6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBm
L3BhdGNoLzIwMjYwODEyLWZpeC1yYWNlLWNvbmRpdGlvbi1hbmQtY3Jhc2gtdjYtMS02Y2Y5MGY0
YTI3MWFAb25zZW1pLmNvbS8NCg0KU2luY2VyZWx5DQpTZWx2YQ0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFNlbHZhbWFuaSBSYWphZ29wYWwgdmlhIEI0IFJlbGF5DQo+
IDxkZXZudWxsK1NlbHZhbWFuaS5SYWphZ29wYWwub25zZW1pLmNvbUBrZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggbmV0IHY2IDEvNF0gbmV0OiBldGhlcm5ldDogb2FfdGM2OiBQcm90ZWN0
IHNrYiBwb2ludGVyIHVzZWQgYnkgdHdvDQo+IGRpZmZlcmVudCBrZXJuZWwgaW5zdGFuY2VzDQo+
IA0KPiANCj4gVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IFRoaXMg
bWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCj4gDQo+IEZyb206
IFNlbHZhbWFuaSBSYWphZ29wYWwgPFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT4NCj4g
DQo+IFRocmVhZGVkIElSUSB1c2VzIHdhaXRpbmdfdHhfc2tiLiBUcmFuc21pdCBwYXRoIGFsc28g
dXNlcyB0aGlzIHBvaW50ZXINCj4gd2l0aG91dCBhbnkgbXV0dWFsIGV4Y2x1c2lvbiBwcm90ZWN0
aW9uLiBBcyBhIHJlc3VsdCwgaXQgbWlnaHQgbGVhayBza2INCj4gYnVmZmVyLCBwYXJ0aWN1bGFy
bHkgaWYgdGhyZWFkZWQgSVJRIHNldHMgZGlzYWJsZV90cmFmZmljIHRydWUgYWZ0ZXINCj4gc3Rh
cnRfeG1pdCBhbHJlYWR5IGNoZWNrZWQgYW5kIGZvdW5kIHRoYXQgZGlzYWJsZV90cmFmZmljIGJl
aW5nIGZhbHNlLA0KPiBpZiB0aGV5IGhhcHBlbiB0byBydW4gb24gZGlmZmVyZW50IGNvcmVzLg0K
PiANCg0K

