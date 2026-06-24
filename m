Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AF259C80
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302863; cv=fail; b=pH0A3UqwLEukk0a0BHnfvjCJD8ecqLKy1ECO0n7Q4oXOzq+p+aSFlLOWXwHtzkMoKpSozuFqiTeLOyFoq1Ey2DGG55RyjtdjNNL997wX2y/QG5ZNXmzcdGT0iBDsYcBzzUfH8mEvAjpiAsp1NGZMFocdgate6OzaLMBi8wzazSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302863; c=relaxed/simple;
	bh=x1W4jJbXViNxqijiu050+wg0odjDBywFX3pGIsxyEE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDZ00+43+ko0b5vnOU71BBDsttvp2Wzxr0uRGSLItfpIjQwNrMDfwiGrllOAMduk3EZWjMSPTMjB7GTxV6ZGRFWGY3ArAiNvtBElqszhs6IOsBcjeuOuMvzplt+Mxmbly1pyizLIkl0KsCQb7WMKndBFXqYgrducxk+PK0BLLdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=yqWo5tdB; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="yqWo5tdB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iklipFPmPCA9atywrT9mO7atqMxJwVN/BU+oxvBGyOab5qCMPScRFTuXeBe09vRdd/3p5GQLuDLhYUhfk/qI72/QoNBJ86Qlw3h1p5TsGpDZu6rWBGT7cLh04ALnRkwoQIQNvlKUFkhOesV9T2R/7wrdLm9bkj8LnlZa7FYbmswBrJ+8LEdzpSb3bzamHuHTtBpwCry6mUXXsQPVeInu72KBddXsOYwR8uxFv9l42M5wuOMYecU4oNU3khhHvurQs6vzAycjsUgnHkaTlo6GCaSWL3WAGFMvDlsv7IEXGsoACig1a3G1MxGRI26i2nAsJzv1/LAthDgLsJyk48PRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1W4jJbXViNxqijiu050+wg0odjDBywFX3pGIsxyEE4=;
 b=Kaw1IB4TmN1MOGADh2YpbvF0H3rMwhYohi+XPL0SC5FODToHwSOpQeOLTkcAwbOAteTQMxNS69GZtAzk+rUuxQHk023ytcrxsFFNaSRkW5p1maJE5P81MHFwIu7PbzT+8ih56FwfKxSASpNU6pI5op3sHcYduyhbVZDYtA8BJi+rvvhEounbghgF/FW3EKj2KpnuC061aeCKVyS/pG2vsLw9QHLLXwDKQhTpM3CE8TqkdVzQDrrGiW78cKGj6cGAnccb/aeYDCHIeWaJhNxgBHwsNCm/VwNF91uDzhm+cJLQq1x/CrYyTdISiEk8FpoHAdx+nfnFpOdgqILFw8LwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1W4jJbXViNxqijiu050+wg0odjDBywFX3pGIsxyEE4=;
 b=yqWo5tdBb+c4om+XwxsvEiHrbTEv9AUxaHey9yKtWqA+9iXugacf4XBuqWFDhot0Rmqzckmqu3HkO9pEL5YdiVSVG6Xsa2z2veVYzmJwZLqKUqapuhtDK513LdbDIv2r8Fp2a/qXM+OUUwhbITnxElm1bK265Exk0y0eONhnslH9heo27T+tEt8IvfE/R9dvcw06STkiJkKw9BX9CWCGcKRmW8s8LLpncNikZFIXSNrWcp9FNi02yfKl+ny2xbfhOm1r1CgSJZpTaQQTr2FfIe8WoxVnGGsku34mrO17VBomnPdhjV51R284vEL69lbryl7L/8PtrjyZ4pkxdLX0sw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS8P189MB2021.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:50b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 24 Jun 2026 12:07:39 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 12:07:39 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Eric Dumazet <edumazet@google.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH v2 net 2/2] tipc: avoid busy looping in tipc_exit_net()
Thread-Topic: [PATCH v2 net 2/2] tipc: avoid busy looping in tipc_exit_net()
Thread-Index: AQHdAzYV5wa0GfnAzEiriuRmwwv0S7ZNnM8A
Date: Wed, 24 Jun 2026 12:07:38 +0000
Message-ID:
 <GV1P189MB198819360D2D4A319EB2A621C6ED2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260623173030.2925059-1-edumazet@google.com>
 <20260623173030.2925059-3-edumazet@google.com>
In-Reply-To: <20260623173030.2925059-3-edumazet@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS8P189MB2021:EE_
x-ms-office365-filtering-correlation-id: 80daf50d-3a6a-4ddf-329f-08ded1e92fa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|6133799003|22082099003|18002099003|4143699003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info:
 GejZqfCrTEScx0vMFQIrsGVRX5lT04Ddf+rHSyWlobqODpXxAmssvIrok/7kPcrnlyEMx5UTJmuTVcraWWRzGZzZPNB4bGnHHsy0ytwzNf2EEHZIcwo9ps9rS8bDB8BxPKR2hoI9yX5ciMBOQ/VqvWe/PLExniii3XdYpE9gHodSqJSjhSVreu8c1EInbP8rDpnuADKv41UbqVrvODn489TNpDZ8M9Ws9Hw8l9n7KISj+vRgX0AaZ09lKHz9ahDgL06DtgmHYq18ayoXKvrSCQBdmnjSJ0WQljgbXN4Th5PegKgQbdl03tgCK1M7zyYlc4ToDc+2einY9ReKzbFYSi7pXUkIExWRY+b9rCeK6rjngIB/rvynCwbDlhQ2OwhQhu7PDMFZIjv0YmUA/4JjZ5XGBYmO7t847Hepa3vEnPjS/stAS5wTBDFHeW9fRbRj36cvlZBTCZNnO26S2Fgsl7tkDQTLRXt33KIUa2UEvQ2xerwHD3w5yLCAgkfGUq1QiWrvL/hj1nhHYe8pNWANwGveYbiLMhJKxgib5mShx7iua6372SDJ3/57YmCfBUhQuedy+qo7WnTAze/WyImp6JsKNZl3H6NNyxVe5mlOO/PsUXVBL7w04JU4dv3IG0AgoVSHFLJjEnscnLwL02OkPQezVIDYPHldwNtNzcm6DckOV5a7Pf6tyvdVh2C+S/Wv++0OokFCaU6GLUaylUDfVqcTx32qjF/HJvxXKQsnCfE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(22082099003)(18002099003)(4143699003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bk43Z29SYzNaMk5MdVJMbkU4RnZleHJ0NmJMZnZYRVpLOFBBMEpmOUY5WGVI?=
 =?utf-8?B?N3hlWkwremlQelBwc0JiNEdEZkxxekFPQ2FTa01vN0hPNkJ4VDVER0NzQmdV?=
 =?utf-8?B?VURXSmlmU3YzU1c3Unl2UkxmTng3cEo4TkQ0N2J1OXpRWXg1WElHbVpVRFdL?=
 =?utf-8?B?bmRZcUI0OGVHTlNLN0RkMHFlR0lrSkxBWjJOM210dUZwWDRDK2w4dWlhc21m?=
 =?utf-8?B?WFV3M1RGWlE2Wk9qTW5zU1krTDZBekE1MmpRdlhPU0k2c3dQNStMdG5yQTNQ?=
 =?utf-8?B?K084dVBsOUpsb3IwVG1GNDBDMDdaTmxCNG5YYnlTUVZPeEJRRktqNmdJK20y?=
 =?utf-8?B?Qm9jaWpLUVJERWxGeEhSL1RsQjIyL0Z0bFdoNmhlN2EvNnBLNXpobW5OODZD?=
 =?utf-8?B?VjBKelo3OFFYVzdCM2lwRTFNQ1VBZnluS2lUdEJxV0lhVW5VTjF2UnFTbHJ5?=
 =?utf-8?B?OEYxclBmTW1VUms5cmZBa1VzV0x3SWNRbERUS2dtb0RzaVFvZCtWYWxtYkxX?=
 =?utf-8?B?Z0xIUzNIMEVOQi9RY2VRcVZOenZhZXpqOUNKVUVIZGhYa1BvMnBFdS80a0Ru?=
 =?utf-8?B?YnZBaGdjS0pTOFFJdHlTOGYrUVh5a09TM2xRNW5DSEw5TDVrVkRWREJRNXEx?=
 =?utf-8?B?WWk1SXFKU2MzN1JQZ3lvQ2FqVnhZLzRuc09PdEdqdVZzZjhURUJnL0ZSWFRE?=
 =?utf-8?B?UmpUWTBPMEpSa0V4Ukg3L3RKOFMrODloMmFvRXNKc2tTcXd3dWVINFM4Z0lp?=
 =?utf-8?B?eGQ5SjQ2SjBJR2JBWXdTcFFFdlQ5ajZHeVhhOUQ0eE9vMlpPSmRpU3BZbVpQ?=
 =?utf-8?B?Qm5YMElDUURTOGRyUkdMKzVPbnNUMHVjcnNDTHAzak5ERHdwQ0dSdjZ1WWRN?=
 =?utf-8?B?dGI3eWdYdmdiVktpSkJMODh2VXNiSUNaSTJQc1VxWGtocStkd1N2TTdMS1lO?=
 =?utf-8?B?ZlVBQStxMlFQLzZzb0dmV2s4NTRCczJJMHoyQVdRcnZCbTU4WDV6cXRMeGFz?=
 =?utf-8?B?UFR5eGI1Z1lYM1RoMVRIWnhUNXhSNi8wdWp1cWNFM2NtYndJb1VIem9JbDFh?=
 =?utf-8?B?U20yWjMyb0F6dmdKMUFhbWVKSWo0NHBtSEx4UHFKWWxCU05Wcm9FUGY0SHlZ?=
 =?utf-8?B?UEhBUVJ2OHRzanpGMWdaci9mNmxYc3FvcktndUp3cVpzL09hYU05bjNhM1g2?=
 =?utf-8?B?NllXVSsvSWRNQ0NlNWRnUzdzRjNiRjBsdnNkWis3S0tTa3NwNDNNUEI0K3NH?=
 =?utf-8?B?QjJveWhlcms1QWZpbjF6UWRwSjZXd3QvZms2WlNDT1kySUFHdlZzSnpLemVq?=
 =?utf-8?B?Nys0Nk9ZTTdLV2hMcWJGZTZoVHIyT2NhNDdLWDRQZFVFK2VOTWVVdFZQSmNE?=
 =?utf-8?B?RWQzaHd5VThaMVNCanM2c2thelZlbzN0WFNQTnhwc1ZFVXAvUHJCZjFOUktT?=
 =?utf-8?B?SE85ZVlidi9Oam1vT1dqc2JybElXOVp0WDBveTVLS3R4TlFzMGNzR1puV1hL?=
 =?utf-8?B?RWhWZklsV2sxMDBTejNHZDdsWHczSDgrVEdnQ054TGhOZG9SMnRSUC9lckJ4?=
 =?utf-8?B?SDhqVmhRYVloVTJzNnoxaXNIS2J2UEJRcDV5Z1NRRVZiREFrNy9xRmcvckxZ?=
 =?utf-8?B?TmZwU0hKblFYWmZudnpVcUcrbGQ0QTdoUGhpY1pRN2t5M0pXRnZGajVoQUxR?=
 =?utf-8?B?TmprcUZjQVo5OHB4cnZlL21CeGNhVWt6L2FQUEtNeGZhaWFWRHNNMmwwL1lC?=
 =?utf-8?B?YzRscEh0OXVUYjVqTTRER3VGY2kyTk5uTlNMMkdrdjlXUFMvam53TjdVQnVo?=
 =?utf-8?B?UmpJeGFldkVZMXlramhLU1VvUkt3RUZZM1ZaOW9oR1ZJa2pEdkkzbHhVblVI?=
 =?utf-8?B?aFVzTmdDMVIxRS95U3NtZnU2K2VyYUtYZ3Z2WGlHbEFrbzdiTnpzckI5OWJw?=
 =?utf-8?B?Ri9hM2FJMHZTZXBUWjMzZHpBQUJLaWZ3blQrTmdLdlJwajZGWnJZdE9ZU3JK?=
 =?utf-8?B?RHhmamRjL2h5YnZpS0lzVFdFVzhhdjdvbk4xSGplTWRHN0FwZ1pLdFFDT3Jv?=
 =?utf-8?B?eVZoUDAzMjA5a1NpUWNLMTdON1gyVUl6bjRtL2pPTjBRWGtpdmZ5bXRYZHRI?=
 =?utf-8?B?RlJ5bjhFRmloZm5NMFlBQ0lCTVJPMVd0VG1sL3l1Y2ZDTktnak55REhQQXFF?=
 =?utf-8?B?UFZkU0dVQUlsYXgzQ2pnbDJ4ZmV0NHZUZnluL3hXc3pVQVdwQlJ0QUYzNWg0?=
 =?utf-8?B?ZEo5d3UwSGp1My9ac3BERGw4L05PR0VPMGUrbm9MM0FGZHMxOGZ0Rjd4akxR?=
 =?utf-8?B?TmtjVGlpSis4Ymw0cFk3NlFMa2FhbVptWXdZRHpsdXp6d2dERmcvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80daf50d-3a6a-4ddf-329f-08ded1e92fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 12:07:38.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: On9wG4nw0ONbrcroce8144bSZEhDr/WtB5DzjdJxd8LrtWK9mYOzRvq+9cf2HedgDcaTKjMBjbgMLWHlgBSCgSqkvwyBlrIspzauuz/lZGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2021

PlN1YmplY3Q6IFtQQVRDSCB2MiBuZXQgMi8yXSB0aXBjOiBhdm9pZCBidXN5IGxvb3BpbmcgaW4g
dGlwY19leGl0X25ldCgpDQo+DQo+QmxhbWVkIGNvbW1pdCBpbnRyb2R1Y2VkIGEgYnVzeS13YWl0
IGxvb3AgaW4gdGlwY19leGl0X25ldCgpIHRvIHdhaXQgZm9yDQo+cGVuZGluZyBVRFAgYmVhcmVy
IGNsZWFudXAgd29ya3MgdG8gY29tcGxldGU6DQo+DQo+ICAgICAgIHdoaWxlIChhdG9taWNfcmVh
ZCgmdG4tPndxX2NvdW50KSkNCj4gICAgICAgICAgICAgICBjb25kX3Jlc2NoZWQoKTsNCj4NCj5U
aGlzIGxvb3AgY2FuIGJ1c3ktd2FpdCBmb3IgYSBsb25nIHRpbWUgaWYgY29uZF9yZXNjaGVkKCkg
aXMgYSBOT1AuIFRoaXMNCj50eXBpY2FsbHkgaGFwcGVucyBpZiB0aGUgbmV0bnMgZXhpdCBpcyBl
eGVjdXRlZCBieSBhIGhpZ2ggcHJpb3JpdHkgdGFzaywgb3IgdW5kZXINCj5rZXJuZWxzIGNvbmZp
Z3VyZWQgd2l0aG91dCBwcmVlbXB0aW9uIChDT05GSUdfUFJFRU1QVF9OT05FKS4gSW4gc3VjaA0K
PmNhc2VzLCBpdCB3YXN0ZXMgQ1BVIGN5Y2xlcyBhbmQgY2FuIGxlYWQgdG8gc29mdCBsb2NrdXBz
Lg0KPg0KPkZpeCB0aGlzIGJ5IHJlcGxhY2luZyB0aGUgYnVzeSBsb29wIHdpdGggd2FpdF92YXJf
ZXZlbnQoKSwgYWxsb3dpbmcgdGhlIHRocmVhZA0KPnRvIHNsZWVwIHByb3Blcmx5IHVudGlsIHRo
ZSB3b3JrIHF1ZXVlIGNvdW50IHJlYWNoZXMgemVyby4NCj4NCj5BY2NvcmRpbmdseSwgdXBkYXRl
IGNsZWFudXBfYmVhcmVyKCkgdG8gdXNlIGF0b21pY19kZWNfYW5kX3Rlc3QoKSBhbmQNCj53YWtl
X3VwX3ZhcigpIHRvIHdha2UgdXAgdGhlIHdhaXRlciB3aGVuIHRoZSBjb3VudCBkcm9wcyB0byB6
ZXJvLg0KPg0KPlRoaXMgdXNlcyB0aGUgZ2xvYmFsIHdhaXQgcXVldWUgaGFzaCB0YWJsZSwgYXZv
aWRpbmcgdGhlIG5lZWQgdG8gYmxvYXQgc3RydWN0DQo+dGlwY19uZXQgd2l0aCBhIHdhaXRfcXVl
dWVfaGVhZF90LiBUaGUgYXRvbWljX2RlY19hbmRfdGVzdCgpIHByb3ZpZGVzIHRoZQ0KPm5lY2Vz
c2FyeSBtZW1vcnkgYmFycmllciB0byBlbnN1cmUgdGhlIHdha2V1cCBpcyBub3QgbWlzc2VkLg0K
Pg0KPkZpeGVzOiAwNGMyNmZhYTUxZDEgKCJ0aXBjOiB3YWl0IGFuZCBleGl0IHVudGlsIGFsbCB3
b3JrIHF1ZXVlcyBhcmUgZG9uZSIpDQo+U2lnbmVkLW9mZi1ieTogRXJpYyBEdW1hemV0IDxlZHVt
YXpldEBnb29nbGUuY29tPg0KPkNjOiBYaW4gTG9uZyA8bHVjaWVuLnhpbkBnbWFpbC5jb20+DQo+
Q2M6IEpvbiBNYWxveSA8am1hbG95QHJlZGhhdC5jb20+DQo+Q2M6IHRpcGMtZGlzY3Vzc2lvbkBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQNCj4tLS0NCj4gbmV0L3RpcGMvY29yZS5jICAgICAgfCA0ICsr
LS0NCj4gbmV0L3RpcGMvdWRwX21lZGlhLmMgfCA0ICsrKy0NCj4gMiBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL25ldC90aXBj
L2NvcmUuYyBiL25ldC90aXBjL2NvcmUuYyBpbmRleA0KPjFkZGVjZWExZGY2ZTkxMDAzMzRjNDdh
MjhmZjZjMDY1MjkyZmI5YWQuLjMxNTk3NWMzYmU4MTg2Nzg0ZTljNDRjOWZmDQo+NjlkNjJjMTdm
ZmQ0YjkgMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvY29yZS5jDQo+KysrIGIvbmV0L3RpcGMvY29y
ZS5jDQo+QEAgLTQ1LDYgKzQ1LDcgQEANCj4gI2luY2x1ZGUgImNyeXB0by5oIg0KPg0KPiAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+KyNpbmNsdWRlIDxsaW51eC93YWl0X2JpdC5oPg0KPg0K
PiAvKiBjb25maWd1cmFibGUgVElQQyBwYXJhbWV0ZXJzICovDQo+IHVuc2lnbmVkIGludCB0aXBj
X25ldF9pZCBfX3JlYWRfbW9zdGx5OyBAQCAtMTE4LDggKzExOSw3IEBAIHN0YXRpYyB2b2lkDQo+
X19uZXRfZXhpdCB0aXBjX2V4aXRfbmV0KHN0cnVjdCBuZXQgKm5ldCkgICNpZmRlZiBDT05GSUdf
VElQQ19DUllQVE8NCj4gCXRpcGNfY3J5cHRvX3N0b3AoJnRpcGNfbmV0KG5ldCktPmNyeXB0b190
eCk7DQo+ICNlbmRpZg0KPi0Jd2hpbGUgKGF0b21pY19yZWFkKCZ0bi0+d3FfY291bnQpKQ0KPi0J
CWNvbmRfcmVzY2hlZCgpOw0KPisJd2FpdF92YXJfZXZlbnQoJnRuLT53cV9jb3VudCwgYXRvbWlj
X3JlYWQoJnRuLT53cV9jb3VudCkgPT0gMCk7DQoNCkl0IGNvdWxkIGJlIG5pY2VyIGlmIHlvdSBj
aGFuZ2UgdG8gdGhpcyBzaW1wbGUgY2FsbDoNCndhaXRfdmFyX2V2ZW50KCZ0bi0+d3FfY291bnQs
ICFhdG9taWNfcmVhZCgmdG4tPndxX2NvdW50KSk7DQoNCj4gfQ0KPg0KPiBzdGF0aWMgdm9pZCBf
X25ldF9leGl0IHRpcGNfcGVybmV0X3ByZV9leGl0KHN0cnVjdCBuZXQgKm5ldCkgZGlmZiAtLWdp
dA0KPmEvbmV0L3RpcGMvdWRwX21lZGlhLmMgYi9uZXQvdGlwYy91ZHBfbWVkaWEuYyBpbmRleA0K
PjY2ZjNjYjg3YTBhYWFhYzhmNDBlOGYyMzdhYjlhNDRkNTM5YjFjZDguLjYyYWU3ZjViNTg0MDlj
ODk3OThjOTE1ZGUNCj5lNzUyYWM0MjQ4NzU4MWYgMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvdWRw
X21lZGlhLmMNCj4rKysgYi9uZXQvdGlwYy91ZHBfbWVkaWEuYw0KPkBAIC00MCw2ICs0MCw3IEBA
DQo+ICNpbmNsdWRlIDxsaW51eC9pZ21wLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4N
Cj4gI2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPg0KPisjaW5jbHVkZSA8bGludXgvd2FpdF9i
aXQuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gI2luY2x1ZGUgPG5ldC9zb2NrLmg+
DQo+ICNpbmNsdWRlIDxuZXQvaXAuaD4NCj5AQCAtODMwLDcgKzgzMSw4IEBAIHN0YXRpYyB2b2lk
IGNsZWFudXBfYmVhcmVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gCXN5bmNocm9uaXpl
X25ldCgpOw0KPg0KPiAJZHN0X2NhY2hlX2Rlc3Ryb3koJnViLT5yY2FzdC5kc3RfY2FjaGUpOw0K
Pi0JYXRvbWljX2RlYygmdG4tPndxX2NvdW50KTsNCj4rCWlmIChhdG9taWNfZGVjX2FuZF90ZXN0
KCZ0bi0+d3FfY291bnQpKQ0KPisJCXdha2VfdXBfdmFyKCZ0bi0+d3FfY291bnQpOw0KPiAJa2Zy
ZWUodWIpOw0KPiB9DQo+DQo+LS0NCj4yLjU1LjAucmMwLjc5OS5nZDZmOTRlZDU5My1nb29nDQo+
DQoNCg==
