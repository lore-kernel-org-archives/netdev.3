Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11710517BB8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571265; cv=none; b=K897eI2Kaouj27gi/Ym6mhwTYSdInjKJwcmF/QoaEIR/nTFKXMVZVdrrQotIimL2ahTO/aic8AJQB9kyEMRUAsEGmDKnBPxS2fVgyi2tQNUJfAqpKLeAoruBrMukoLg9YqVYoZje5jC9uSgxlPcWpFc85t4qLVEMonyOGcaYT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571265; c=relaxed/simple;
	bh=SWVZH4/QVAM/2E1mrrO0hPf7djQF9YbTvA34SJHL8IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JJeSmMCFhTstHaQX7AdftPFC/MTj8t9diIxmQFTL3zO9Wu5p75K4P7gxkiVX5EUR/kDzXoM45PllrGax8R+cGM0v/VwKawmCB6cWDAuQVZ49fNT/BJ9SWRUFFCyHPHKM9UXyLz+inIa+IStE8AvEcIF79/QsrfzAE6kwuBMIhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=ZFSz2283; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="ZFSz2283"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1791571253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWVZH4/QVAM/2E1mrrO0hPf7djQF9YbTvA34SJHL8IQ=;
	b=ZFSz2283c/7Ed7804uIUHsXIUD3tMlQPL5VBGkiJ0S9OUvOy5Tb1ZEbC7gkIOuci/Nrjg2
	ws8lcVUqNYNGCkH4SpZV/NsCxcixx6QKXCYS2oO3A2hvIpAfZW4PFgxqzFMXWYUxhZijUg
	tFYjJc1XZUccB6nC8MdJ5IR8G1Bv1Wu5JZu6+SgixFQPMsmO0PVPxV470xui+l1F0XWv7Y
	umNdYzuB9cw5ZqpqUXZs5gmqPt0f7hg92iO4c3bLH19MCgpmANmB5YPmaopaa7oMav5fBE
	FHVkiYAbRpyGlVcCe2sAp9r+VtPn7n58kCcTmLK8+cjvE/DhFLlGCv3uLBK9Tg==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-72-I2ADaxXoNzOppauNlcnfCw-1; Fri, 9 Oct 2026 18:40:46 +0000
X-MC-Unique: I2ADaxXoNzOppauNlcnfCw-1
X-Mimecast-MFC-AGG-ID: I2ADaxXoNzOppauNlcnfCw_1791571240
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by LV0PR02MB11298.namprd02.prod.outlook.com (2603:10b6:408:32e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:40:38 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:40:38 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Eric Dumazet
	<edumazet@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jerry Ray
	<jerry.ray@microchip.com>, Ciprian Regus <ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c to
 its own directory
Thread-Topic: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Thread-Index: AQHdWBF4M/EMxq6bWUq+jfBhDl2vh7b1ioCA
Date: Fri, 9 Oct 2026 18:40:38 +0000
Message-ID: <CH0PR02MB786772ED51E929003F855A5283922@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com>
 <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|LV0PR02MB11298:EE_
x-ms-office365-filtering-correlation-id: 8bb85d67-ed75-47d7-04e3-08df2634d03a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|4143699003|921020|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003
x-microsoft-antispam-message-info: o+ZA8S32FxhD9bFlciEKrp1WPaNiCy2AJ6mxhqwMcgJ1GgwUqoNZV1ehU8p9evOfjujWopT4InTWEipf3HtWT/2AZs+irohdJhW6ujP3m355IJ5joK3eTnrD461Xnfzef2EoWovfv8YyGlhZ613dgxPS+0vFpcMmIZXcwPhHT9FS6SXBBsfHktHSMNpudcx5RzByq6Uc5xgZnjzFoYJiHyWelYQddUu2PrZkpO6fYimZebCa2jhseYlPQvFmUId7omIK0FugW7p+MEGY2BHrc0h0nFz8GgHlSt1nJiYPGACadJmfGqS6Ciys6B3q6FHeW20lhXUI28sfQsL7nTahYdPJQHE+/uvctdkOC7uUef8fwPitTNMM+NTRwvK7lUWvz66CTNTCZdcvskp3pzDYipmyTP+ev28K2DmRJQhVfPrLVxbZe3l82XRoQiTMApUBZrFYH4VV+9VTeKidMIrUFFxb2sBogJuaQzi4FG9bMX/Nh2+1S9GjS4/uBHEooKZ9O9uXvf7d++y0HErXO9VvS8rc2aa5th8j81qH8nrf565D3swLYNQTfTeNs/2Yhff2kTfhh7nGnf4UVR1QVWjQTmnz5xsX4KcsftpCsayF2U32raha8ZZl7Qf8SL5gk7PkmCLgdFDyZWIems1YLJrp2IvgIYkEXemaTfrsAio6Zo1fp4Sv5PC3uyKfhKu3uSZksZxDyOsVhjgHaqpIaq9BsXdRaeT4yvUdXAkwLo/BLI4cvjlX30kzvMsoY1oNswKM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(4143699003)(921020)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2wzRklETmVnU3p2QW1tVFl2OHVVclk4TXRWbzltSGQ1YjhOQmZtck5EWHAw?=
 =?utf-8?B?SE05R2pPc0NQVUZjWVFXWTFQQVo3L2haWUxIZlNuTml5L3ZVVVJRMWpoODNI?=
 =?utf-8?B?bEw1Qlp1KzgvV2lGOEcwYzV1V1g3NmpVemhWa0pmWFNwbStQTjZycTNCTkFW?=
 =?utf-8?B?eHB1Q2EzTUVkRHZqRVlVWmtSejhpR3JUU0wzWXVCNWZ5Kzg4VWZkSSt5Ni9M?=
 =?utf-8?B?WXRKcEdIUGdJQkhoT3RTS2FxSFptR3k2aGpjRDg5RjBWbm45RGU4S2lnM214?=
 =?utf-8?B?RjdWZU5UVDM2VGZoQWxyOFpUQlJRRW9yakJSOGcrMEhuUVNZekFlWG5pY01F?=
 =?utf-8?B?VmhpUi9QeHVHK3NnSUVkZGNXeWpzNkJlRlZ0RkQzNWpLcG5VeE50ZTc3WHVj?=
 =?utf-8?B?Nm1GdzRDcVJ0Wk5DSmI3bldhZWR1dmJGNG9rVk5mMzBydy9hQkpLd2hDV0x5?=
 =?utf-8?B?bHRtRncwelBpajY2OWhtVmpTa0Z1WXdsRHVkazR2N2R5MkJJb0huN3I0WjNF?=
 =?utf-8?B?U051STk4RWhBUG1GSjhQVzRsV015aXFGN2lyVURUYXlQTWxQeTVQN1lONW1U?=
 =?utf-8?B?b1NUQkdBei9FOWxrdnYxbUlRZTdXVlVZNSsvS0lDNk5GU3laczB4RWlpcDA2?=
 =?utf-8?B?bUNzOE8rV3hQNG9tT1hIZlhkZEsrMUxMSTF0TXowWUc4ZjF4RXNFNllHUng2?=
 =?utf-8?B?NHNiTFROMWFDNjlkYWdGU2pPS3Y1UjFvcE9NRDdMZUFSYU5zakUvUjNuLzUw?=
 =?utf-8?B?R3ExcjA1NjRoMkhEZVVSUU9idVIveS9GMHdWTzRDWTVIZmlJcGg0NjNVY2Fx?=
 =?utf-8?B?SWR5OHIwOXlXTkx5SldiZitGaWExdWFXZ0lnYnMvekJySXdDdWpWbm8wTmEx?=
 =?utf-8?B?elpsSVhncEdUNm1wckhIS3FOMENGSDdzemhKWFlPRkhCdnViMW91Qk5Sb1Rp?=
 =?utf-8?B?MkZvQ2haak5OWGRXT3ZuVlNJQ2VRUDRoNGZySDIxWkg1L21kdG9ucHVkbURq?=
 =?utf-8?B?U0JSeHorR3hjVHg2RExVVnNYaXdjb290WnVlS29SKzJMalZmeWJHTnFnNFZR?=
 =?utf-8?B?TVVpanIzSUR6eDhKY1U4eHJDVU1FdDVPU2Rka3ZhRGVVYWdyUExPZ3FoVUxX?=
 =?utf-8?B?YnllbDdmOVFDVTdDdmY1YUtpUEIzeWptSkY2ZnUySzdYVVRNNFZmZm9aUnJl?=
 =?utf-8?B?a3pnMVRGWHpENzIxVGxZTm5zYUpqYkx6UVUwY1dBRU1zaVVVTVVENUVXVW54?=
 =?utf-8?B?RU1SK0xuUHJHdDYwZFl4K1dFTnJWVW96QXo3Y3greG5XQUtiU0diM28rZWpV?=
 =?utf-8?B?c1B2L00xOHoyVXJzNjVvZStjcWF2QzhJSkJnT3NRVkV0VGxBSWN6TUZpamNM?=
 =?utf-8?B?eGc5T0wzWno1Mmg2U3NUSG0yNHFPQVMxWVhoOGVHbktYdFdqcDUvdVE2Yjg2?=
 =?utf-8?B?czRBMkJnNTJEbXhVejlXcUh4TEpuV0Exc3hoZUp3TnBQSXdpSGovbi9GYWRl?=
 =?utf-8?B?ZE1VWlFoVkd0VWY2NTRxc09oYTNIdThGTVp5VHZCYWY0OVJQQW16cDQxSzlK?=
 =?utf-8?B?WjRiSFpkNlpYYVAya0RPWGtkYkJucll2OVZsanIxNGhkenhzQS9MWXR4ZkJ3?=
 =?utf-8?B?TlpNazNxRWp2d1BvVmtsTTNOcEhjWXM1Z1JKd1NuaEZ5Z2VTUFloYU1PaHhT?=
 =?utf-8?B?cnUyWmhQQUdVNmZFNkxjbmNaSG5ocm04eHJ0cDRqYWhKV0JwZ0tkNTM2bFcx?=
 =?utf-8?B?THZ0clJKL2dlampIeTJZQ1VnUlQrc09sTEFnNlQzRC90OHhFN2lLYk9zYzVj?=
 =?utf-8?B?Snh4blZEeUorSVB6T1hVUi9mQ3Z4TTVDL3hZcklnNUJZYVdYN3RaMnpDTWJl?=
 =?utf-8?B?MllvTzFybEVLb2VRdUxRYWI2ZGRIcjRRaEIrcFJ5M3N3WDJtdzU3VTZqYTBG?=
 =?utf-8?B?TWtqRGRod3hMeGplNzRXNXNlR0JxWitVSFAxMWpleldFWXFXWlhiOWlpQi9Y?=
 =?utf-8?B?TWhwQkNSTWxhdFphODJ4a2drZEFiaHJEckNtdzBWUEFCclN2U1dBUHFNZ1E1?=
 =?utf-8?B?YXpFdEJsZktEVzBXTldIZTkreG1LUzBhM0MxSTVTbUhvYXJQK0ttYjl6RE9x?=
 =?utf-8?B?WldWd2hVRXgvUmh1SnlIWmpCOWY1cmVMK1hsaFY2QTMvRHRXZVlCRnVIYjZJ?=
 =?utf-8?B?aTQxKzNXVE4rYkxDRVdvOVFjNTNCNkUzbzZIRnRnbVh0aFIwODVWOE9mbVVl?=
 =?utf-8?B?UWtLNTZ6czlCUXA2VUxRZktMVmxxOWJLYXpnQ3pBN3RLajZJalpWcVQwUFVL?=
 =?utf-8?B?NkVNZDRKcEtzNFgyOEhzdit4ckliOHFLc2Z4UllyV25kUWkxSHcvOWFsNllI?=
 =?utf-8?Q?Yvoe13x9TU42nm9Q=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f5bdws82KKWj8K5caSMDoLlbUmKCfXg3pELafq7AG34evCxwKkVBfma5D7cfUAVgdC8WMGyenjODGb/UCcymfIdbo0PmFl2nk5Ya948jiYKY+yCwPn7WvVhMWQnzOCs7rCS7C4hS4nGbCbiOw4LMroi8ktBECZiXq0iyMF/RaMXHkpKwodm9E8sYZvs7QmG3g4cMhEjDen3E7/Gj+amSNDg0KgtZx3LeSKFXh0LRkMInvURbks20CG8mjlDQGyVFIxdTdGrAVIHzEKDIDmjWSYr3xd7zuLcH0rFZ91hKnbOs/TgG0uibH1kdlaF5JQ8y9ouRQffvIYj2O2irwBazVw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb85d67-ed75-47d7-04e3-08df2634d03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:40:38.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SECfRi51qRh0IPi15Gkrvv/GkUBFWqjTaqRgWCKjwM1z0+/bAcMhph1Ewy63uLAIgbDVef6oHFeFzSpt1YRjl/j91ZM4WYSbRE0/lmylzk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11298
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QPxWa6xPLLN97HIlQ0iYHTGiwtiVpEegjfuASJP1z94_1791571240
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

QW5kcmV3LA0KDQpKdXN0IHdhbnQgdG8gbWVudGlvbiB0aGF0IHRoZXJlIHdlcmUgY291cGxlIG9m
IG1pbm9yIGNoYW5nZXMgdG8gdGhpcyBwYXRjaCBhZnRlciB5b3UgZ2F2ZSAicmV2aWV3ZWQtYnki
Lg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VsdmFtYW5pIFJh
amFnb3BhbCB2aWEgQjQgUmVsYXkNCj4gU3ViamVjdDogW1BBVENIIG5ldC1uZXh0IHY5IDAzLzEx
XSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IE1vdmUgb2FfdGM2LmMgdG8gaXRzIG93biBkaXJlY3Rv
cnkNCg0KDQogDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNo
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdv
cGFsQG9uc2VtaS5jb20+DQoNCg0KDQo+IGNoYW5nZXMgaW4gdjkNCj4gLSBDaGFuZ2VkIE1BSU5U
QUlORVJTIHRvIGFkZCAiYWxsIGZpbGVzIiB1bmRlciBvYV90YzYNCj4gLSBBZGRlZCB0aGUgbWlz
c2luZyAiaWYgQ09NUElMRV9URVNUIg0KPiAtIEFkZGVkIFJldmlld2VkIGJ5IHRhZw0KDQo=

