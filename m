Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE721B4224
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531409; cv=none; b=mDcRzkbJcUqS0JhqQqtVA/9PEN3GSPHLCZqHLf/hvHsW25NqZdRABuTGnQXxE8j6W77srwtIPl2Z7WVdN6iULEz7XjZpYlc1i/imld7SVlbBjV9Yqf4k7vaaj1dGkdwc3qDp+UAKz/ZfL5AkfNzCjNVVWuhkqdA9UgaWiedoWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531409; c=relaxed/simple;
	bh=opa2vJ38yo/TmbBikeSJKFf5BP2xboddjxfMfty6vr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=heYNmzhCvI37ezHY7gNlDeaRjGuh18i/iV48Yuwn4hhNDyQ2VicXaQoF5LK/kIiuRZDJ4H33IFgn48t4fpKreutOnNvUikJjhgJ32WPJI2eGTB375IaaumqiIx/C713BH9xtr+l3waIMF26WrW4Lm3KQ7RPRIMXfZjXN8+ijifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=Om5Kjp1e; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="Om5Kjp1e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1783531401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opa2vJ38yo/TmbBikeSJKFf5BP2xboddjxfMfty6vr0=;
	b=Om5Kjp1efSRNc7NIANlgyKY8B8fMdTRUWtR0v6pNOBG0UkpDNOoqgNI5HCwDRXUCFTpKG8
	x7KEnzBvZageisHM7nbKm7xF9yPlYF/MNwqORU8lgBaaVlDaOmyY9h0G1gh3nsXoGIQx/c
	q3ay8VWPJXc4UHghFfvbsvAy7wTGOKPfcq96PUg1Db+Lr+oA9XBc8Mtfnt0SbnmNbXs867
	U2a4QrorQl9ZRmeKCVVddCI+UuM1wofOydTxVdvf4a2TeoomM91YP0SG7c85DAoH6egrzq
	xIRdz4bvx53ZzeiTUdJmG0BXnttpr56SOkCUkVCllorcb/jertGyyrAe4adVBg==
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-12-SGChQ_NuMHOVX9M66_CEcA-2; Wed,
 08 Jul 2026 10:23:15 -0700
X-MC-Unique: SGChQ_NuMHOVX9M66_CEcA-2
X-Mimecast-MFC-AGG-ID: SGChQ_NuMHOVX9M66_CEcA_1783531390
Received: from CYYPR02MB9828.namprd02.prod.outlook.com (2603:10b6:930:b8::20)
 by DSVPR02MB11614.namprd02.prod.outlook.com (2603:10b6:8:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 17:23:05 +0000
Received: from CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca]) by CYYPR02MB9828.namprd02.prod.outlook.com
 ([fe80::2767:f7d2:778c:8dca%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 17:23:05 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "ciprian.regus@analog.com" <ciprian.regus@analog.com>, Parthiban
 Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v5 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Thread-Topic: [PATCH net-next v5 07/13] net: ethernet: oa_tc6: Add
 read_mms/write_mms register access functions
Thread-Index: AQHdDmHhTw2cxvt8oEy8gW3cJW1mz7Zj3pAQ
Date: Wed, 8 Jul 2026 17:23:05 +0000
Message-ID: <CYYPR02MB9828C512D59B69CB8EBC721083FF2@CYYPR02MB9828.namprd02.prod.outlook.com>
References: <20260708-adin1140-driver-v5-0-4aca7b51a58b@analog.com>
 <20260708-adin1140-driver-v5-7-4aca7b51a58b@analog.com>
In-Reply-To: <20260708-adin1140-driver-v5-7-4aca7b51a58b@analog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR02MB9828:EE_|DSVPR02MB11614:EE_
x-ms-office365-filtering-correlation-id: 34bcb85c-d316-41c6-3099-08dedd15928f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|921020|38070700021|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003
x-microsoft-antispam-message-info: SNCH4lmiHOawX5LgT8NED6dNxZnBVo+eIVA7bn4PGaml04VP6Z2GDzalesuOdJlCpRP7NQBYJntelehMD47rMY+vpANxfNeCThnSMtWAIrMb1GlvjD8O3RZ/PWfDVgV9dW27iGVNwixodP4pxrnDIDZEIH+SCXKi2Cu6EmDYzpECldAfBlRr+XlN+AA3NlXHdGojJgtfUvvJGj5cmk1CJVuJUWKog/9VXUF3Y1UshpLvhUE/m5yzLBLdNsG2i7oaS5fS+Y7yFafF+qFHF5bWMbSfZcyuUW6NhGan7HBRqbQkjUAn+qUfcIn7b1QmFJEMUrLhiKPmeXZoRLhHFZG/n62/qwzfNKQDxKdpJzFc+TWsk9ezANJF6u4oPVLBwM7IT6aNQiR14uSNPOObiYZhmcNv16YvehRPtlIC3SWEwzpZRiJ8tr2e73RBTNiGxBgjHnNmnNNxS6Rn9852Ftt8zuf0FwV9AKSX++zwSrYWjLAtHS9WSLjZabS6qQUxhNevaa2BehGtpS4pUsXESe8+Wt7RCD/6XA4tBsq1oUA8GZHG2dejvhXVDj8U3dlWYKLPy7V3RxyntU5zjtwGtXoIEBfUN2Ng0idmK+fbd2cNjcSThDbW9b6iUYnx6oxHciYYYieARrS+aOLpVscQRHKvD3OQ4iVS+h8ZHqrbWNYcM7UcbKf6k6qpMf4bDr5hVQzY2o2gn8kVkK1epzYuR9uLlz2ZplRLI3joKjfbbR5gZJU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR02MB9828.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1U4c3FhQmhKb3ZuRTFtd0JjRC9DL0ZsUCtxeWRtZzQ1REhEYTJVU3RNdGdL?=
 =?utf-8?B?d2FLK0xUSW50ZmV5d3RyWXdzTDZwOFFvMXlwUVNqaEJNdVppUjRTUlBpNDJ1?=
 =?utf-8?B?MHFBeWZxOG1CelZQTTQ5ZXh2TGV1L1NGZTVWaTlNdFcwUnlONk5BU0Ztd2tF?=
 =?utf-8?B?TlpLZDUyd0dkZitwaGcvcmRESmlmUk9JUCtobTVBL0xrTGc4RmpMdG9INGVk?=
 =?utf-8?B?dFlUand4OEEzanl0TERNNm9KVXdMdjNNbHZqUUFYS09BYStSY1FDYUljWlRF?=
 =?utf-8?B?Nk50LzN6OGpjclkvY0VYdHptN0N1T0lCSEp0VE1LdzZhczU5NmlFNGVJdFpB?=
 =?utf-8?B?OG9XWG9WSGNqbW9ET1oxUitoSVBxZy84QXExMXcxYndHeHc5MHhYWmU1K0dx?=
 =?utf-8?B?aUN3U09Uak9Mb0hNMWpQRlhjU3d2dkJqbzdtT1ZtMDdHV0Q4aTJyYWNWMThB?=
 =?utf-8?B?d0tiMTk0RGRpeXZEQXBlamN1NzhWT245Z3d6MzcyVlBYTWJsUmJDenZZUm1r?=
 =?utf-8?B?UFRaQ3hISlVaRlVOSzBsRWo0VkY2NXF5WkN1UXZYUUl4cHVUSVRjbnA5bllk?=
 =?utf-8?B?bE12WWhtWDFHVTVQTzN0VzVxTWIwK09aMlVCU0hDT09zbGY0dzJ2RTJzeUU2?=
 =?utf-8?B?NDN4QmRWRFFOQnI4S25hbU9GRnBtYTA3UVpLbTQzdHdWNHgyZjV6ZHVwemZH?=
 =?utf-8?B?NlVSTlJZTnRTb1ducS9OTDh2azBlWnJ4b0RsR05tYkZwWDB0UmNBbFhZZEhH?=
 =?utf-8?B?ZEhOZ0Z0bTVCb2lqVzd1b1p1SUVvOFFRTGphTm9rMjk3Z2pybjBJNk5YZ1Q1?=
 =?utf-8?B?Mm5VMkU4dTIybVVLMkQzWVlCWHJBV2JTalhSdE0rY2p0aC8vbTdyN2JJYkVQ?=
 =?utf-8?B?ZkUyMGlpbjhUbmtMSnhOcWthOVpuNWFUMFpSZmdsU1dpVFM3V0Y4Z3c0S1ZF?=
 =?utf-8?B?NkYwY1RhRW1yYkQxa083VUowcGR5UDFTUk5lRjliTlNpYU0wcWdvZmkrWjRz?=
 =?utf-8?B?RXE1SzJNOEU0dXFmNUNZY1Z2RlBMeUdJMnkzSVlWdW9rZnRQYjh4K21ZaTV6?=
 =?utf-8?B?L3pNQVZNTTNGS0NHY1IweHFKaVpFWWFuRWg5ZDJPMWFDSnlkUmFXbTd0Nmwx?=
 =?utf-8?B?eEJ5OVdEaUNzbzNGTG9RdFJ1VExpejdXdWZvckNRWkJINUdLOUExTFduZG5Y?=
 =?utf-8?B?ZFhhLy9TSGpMbEdwcWFyQXV1R2o5R0piOXVBUHNiZlhBcGtWRmV1WEtRdDZT?=
 =?utf-8?B?VlcrM0FqaTVyUkhWdUdKZFJTUFppS2dTb2NWeDYzUmg1bi8xb0VSbHhpYjEr?=
 =?utf-8?B?MVBabmVGTjVteTlmNzVvU3BVbDdnVS9mV09XL3BpUHlieHk4RnNmd2I1dVZH?=
 =?utf-8?B?Z3RXcWtKY0RIRUlKWWgyR3FsdWZoaXNHM0ExTW9YeVBPdE1mMHNjL1lLYlc5?=
 =?utf-8?B?VDJDaXI2Yy9nQlNMUEJ4NSs1TVdObGxJME81Q1Z6a1AxYnFDMzE4N3hBR0dW?=
 =?utf-8?B?YkhLRHNadU9yQnZPb0VZSXJFUVJhSnRlTENLOUhuN0xRaHNoWUp3T2JSSi9H?=
 =?utf-8?B?a0xRamR4cFNjWVlVbGM2VlFLMW5BOEhiWlQ1MkFMSUtMcHRneXlQK21jQUlY?=
 =?utf-8?B?QllRUnM5MmdIZGh6U0R0UmcvRTJmajZ3V083WFVDcE95MnUzQm9TOWhFVFBC?=
 =?utf-8?B?NUZEWXlJTkJ5eGNIQXpHQ3lyUk5HcnFObkUrQU5xRVNhZXVXRzRVd241OVBZ?=
 =?utf-8?B?NVhacHdrYlZhazcrRjBVYUVDMjBxbkNsd0NhcXJycUFzeVZYNjJNbkk5ZkhC?=
 =?utf-8?B?bmZFcTRLYWpDYnlyRjdoUTc5d3QvNVI2eDhnMlRUeGlmdEdMNCtOQ25LSCtG?=
 =?utf-8?B?SmRtOHBKbDRkRFAzbVdLb1puWW1UbXYyamZEbS9COFA1WDlDRnBMSmUxRnRR?=
 =?utf-8?B?YmM1OEVrL1p2RlNDYkFEcHBVZEY0TUMrZFRrQmxOTUJzbDJ3ZlN4UEdWWUFa?=
 =?utf-8?B?SkRocWZTNlUzZ0Z2TVA1OE14ZXFHUFpiUDViWEhIeUFwUWc0UVBsTFlJMkho?=
 =?utf-8?B?SGlNTHFtOUlJYldKcXlCTFFMcEIrMkc0VUcxT09laEdTQ1VNbnhtT0dJMVo3?=
 =?utf-8?B?MmN6bjQvdjJ3Rnd5bUFLRXlUb0ZKWUREckF0TGdvZVlKT0hURlZkKy92TmdG?=
 =?utf-8?B?OUI4dkpNOTh1dUtGejg4Uzl6eUZFajdGUENpdzRma1k4UVpQU0ZKRTNSMFlC?=
 =?utf-8?B?L0t6V2lHMXdnUmJPZDQyQmw4SUJhM2pHR1lYZjBuOHRhMGtFblROZzZnT2lj?=
 =?utf-8?B?UGFwaEhERjRsLzFWbGtlNkRjR0tqTkw5eE03ZTlSSUlWOGxqVGo2VE4xU0Zl?=
 =?utf-8?Q?AyyWChpLl0fZBtZ4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oD7njjBOruSeb2O0BdTQrEdr2cShCEf0NSV7h07betT/jiGTw1M88bvDv5ZfJwpmQlPTEQ/isouxiad/Mq13ddpbm2GbfQl9mPkyNAvhS8QU3X9CQWqnEKfxXq0vnUvdisruxPBUm8VNw/8En5xyXJJfYOxyhjxJw3jpYfh8MgWmikf7iyeuI8vUAeTIAu/9Vp9SkwBzVyH5Y+d1c3rKINVvb2nwVoXy4Gv/HKyPB57XSk/UN/3JOA9N6mrhfcQ2nB3HcaO5ZK/4Dk/u5hwI1fejg+AOuMry9csCrM9PLzbd/k7ySERfadUVPcYpZZNkRrO1TawB5Di5F24Q19USjg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR02MB9828.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bcb85c-d316-41c6-3099-08dedd15928f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 17:23:05.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWIW4vgT1EBFEOeWFJhzTHLSmb+daYwtgyVBl8MCGkWr56hbmGV7CqJV8k+vcPRtb2OxeTaJ8m/lkLLXcHSRs/nvXa6kv2RvQDgd9xB8DHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11614
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uikPKDgVe86zQqNnjSKOViIkwh5U2CyzNh6Xuz3oCoo_1783531390
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaXByaWFuIFJlZ3VzIHZpYSBC
NCBSZWxheSA8ZGV2bnVsbCtjaXByaWFuLnJlZ3VzLmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4g
U2VudDogVHVlc2RheSwgSnVseSA3LCAyMDI2IDM6MzQgUE0NCj4gU3ViamVjdDogW1BBVENIIG5l
dC1uZXh0IHY1IDA3LzEzXSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IEFkZCByZWFkX21tcy93cml0
ZV9tbXMNCj4gcmVnaXN0ZXIgYWNjZXNzIGZ1bmN0aW9ucw0KPiANCj4gDQo+IEZyb206IENpcHJp
YW4gUmVndXMgPGNpcHJpYW4ucmVndXNAYW5hbG9nLmNvbT4NCj4gDQo+ICsgKi8NCj4gK2ludCBv
YV90YzZfcmVhZF9yZWdpc3Rlcl9tbXMoc3RydWN0IG9hX3RjNiAqdGM2LCB1OCBtbXMsIHUxNiBh
ZGRyZXNzLA0KPiArIHUzMiAqdmFsdWUpDQo+ICt7DQoNCkNpcHJpYW4sDQoNCkkgaG9wZSB5b3Ug
bm90aWNlZCB0aGF0IEkgaGF2ZSBzaW1pbGFyIGZ1bmN0aW9uIGluIG15IHBhdGNoIHdoZXJlICJt
bXMiIGNvbWVzIGFmdGVyICJhZGRyZXNzIi4NCkkgdGhvdWdodCBvZiBhbGlnbmluZyBteSBwYXRj
aCB3aXRoIHlvdXJzLiBUaGVuIEkgcmVhbGl6ZWQsIGlmIHlvdXIgY29kZSBnZXRzIG1lcmdlZCBm
aXJzdCwgdGhpcyB3b24ndCBiZQ0KdGhlIG9ubHkgY2hhbmdlIEkgd291bGQgYmUgZG9pbmcuIFRo
YXQncyB0aGUgcmVhc29uIEkgZGVjaWRlZCB0byB3YWl0IGZvciBvbmUgb2Ygb3VyIHBhdGNoZXMg
DQpnZXQgbWVyZ2VkIHNvIHRoYXQgd2UgY2FuIHVwZGF0ZSB0aGUgcGF0Y2ggYWNjb3JkaW5nbHku
DQoNCkhvcGUgaXQgbWFrZXMgc2Vuc2UuDQoNClNpbmNlcmVseQ0KU2VsdmENCg0K

