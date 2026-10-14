Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30B33998
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944645; cv=fail; b=pzC8wl3Lt4DxBTM2MeBXE2qxEKdMEdUxyBKVgm/N46WVt3Bjfy5RTbWknIucfGk/rn+GHXe5pnOZ8YQI4rCyySKHJ6lhuNYGJTcYNTTEsLf9asohPj/tjpPOsGoYu0Kd5SXv1WzUZEFyMqpXqNw8vPhYtKXGLvre2ahkWsvyHKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944645; c=relaxed/simple;
	bh=X/Oe87wkknB3HC4nxTueGQl7YByEpoeg5+viWSR1exs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hhs5JrZBU+Ej54LiMYj7tjEkiGPgVANq6kXEuj40a7G53C06z2IeXwU6xzkjzCmJt1EzOtS9IRrfuuNT6kltK0Lk7+lQcM4f9hUzl31+urirp6nwoVyDQ8EWb6NUb3pi2p3JZOjDQaZ6I25TteElAVsapgLYbdxuYK9x85NmxUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TcNPXGkz; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TcNPXGkz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9+DTSo4L80zzW2S5dkYbB60VlJ+eCTFS7vw1M6A7zHGZVpCax4Q77lxc2NZ90C5qOzdx+1nv0SXVvmHVop5UL7WWV6WXp1JhWFo1c6a7MRyiIVwYw5//awsOKzRvRanq3NjFGNkRCIy57Lhbef3grct+Ok4ulHIDFJ01GJqJcrFzBz8kxp6x+x8sgBQP/IPJg28jHXQslAP+lQKU7GyK9beZEMnmzDeRfepDHEZUEVMtbo/b8iOAQY0u+Q7gkmGebu4p2LjbjlVugvz5DkoIJNpCUWmn3AFznbT6wQ8KUFK55Rs8VoOiyiV7K4qDN1b59bzbveGcuc7NGPP7c5tFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/Oe87wkknB3HC4nxTueGQl7YByEpoeg5+viWSR1exs=;
 b=sKwZ4wgzM4y7voGVLzBAZF8XzfXQU3ML7flAhrpoSeT8Vm+kD+03UCwp5tH1TdfqoWyGtP/GI5R7TnmO9ikIwkrUm0jDyT6XhYi2Lgs6Xj6v4COH0falB+Ke8e/wQU1TBPxqqebrusGFRWwDAa/wy1xpqwFPd3gAxFE/F+cNZyfVyA+tVEDSbYcPh1ozrnKTr5kK9sAq5tHGrkXRH906dxoxsX8SQfv88D9kNnQO2AA70W98+MYrYu/Kv6arPSbH3sHGSlHYqpHv1jwvA74i0F/xOLRNVTq1aAoZ4+O6UVp44SCIvQewkMKuglvERhRHo3UAWUqb/avYvMJWzpnzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Oe87wkknB3HC4nxTueGQl7YByEpoeg5+viWSR1exs=;
 b=TcNPXGkzHUQansT5v+CR1TEpH69uazOEdzDzlIOhdI0SjO7L+zFH7bgRPGGuthxwBKybnorOCeh84c0OT/5zSX8qLBkpnSO5M5SVbhMGft+zXC4dMZdOPzCotAKj0WAXlqGtn64o2DuKtl3kJnoQHEso28KuIpvq8Nd6ii/LOC9TxnFHzu9cFBZP/B/eUbcWEvEQmltaou0FNlrZBjrKczusfK/xn+HM6eDFklcj0iDq0w3r5pY9Biyu/rACRkC9y8D/bcfQsZGS/2C/Ob9J6zcSyWgQ7YBpzl2bp4xtcUi4P3mThuV95snoW1kQ3ql/UEm+WQnO92s3dZujslw+7Q==
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 14 Oct
 2026 02:23:57 +0000
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::75d8:3bd9:28df:cfdb]) by DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::75d8:3bd9:28df:cfdb%2]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 02:23:57 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Topic: [PATCH v5 net-next 4/9] net: dsa: netc: tie setup resources and
 reset to DSA setup/teardown
Thread-Index: AQHdWi/K+bT0PSxuE0yauhMzx/ZLsbb7PtKAgAES6+A=
Date: Wed, 14 Oct 2026 02:23:57 +0000
Message-ID:
 <DB9PR04MB933223C3DEB59DA8B1310F85889D2@DB9PR04MB9332.eurprd04.prod.outlook.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
 <20261012095924.1129312-5-wei.fang@oss.nxp.com>
 <sashiko-outbox-169415@kernel.org>
In-Reply-To: <sashiko-outbox-169415@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9332:EE_|DBBPR04MB8042:EE_
x-ms-office365-filtering-correlation-id: 9e42ce0a-940c-4e4a-3e36-08df299a3396
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|19092799006|1800799024|22082099003|18002099003|38070700021|261009223027099003|4143699003|10067099003|6133799003|56012099006|5023799004|10063799003|11063799006;
x-microsoft-antispam-message-info:
 gyPYTw4qLlS7YNlFf1B/Rvmskq3fZwxdLy8P6QRKHSpDKfK1hLo1kBGvUaGuXJgBLHNUtpSRCowug7t0vjC6k7e75ADxuQ1V1P8Lx5GYeF8eBsAwu+NiGT0lQRd74Ny/pnQWFCXB1F2T6JGIKWXCbYwHF28ycETrDdqixhbtAmspbcuiQZXKqBavvzLoximoOWXIb8bwLiS2Cd71ufKrTwVdW1MqaOc29RMrXqcRP0GsG8BCQ9sPY+AOntvUgkKhhuP2sG9wbPCGNaQrWBcmX2OPIJTHro0g2vAj7GnPWqmMk8aLfgRbFTvGHbPBJ8QGaCq1B25YZtrEftn/wYqftn6SxHLMEyIWy1YFejC6cEV9D4KtHF+tx5Ukpp86dEnyWzhA3gxHY2JurMV1cmpZGGGx29ddmwy8BLO7GwWYKsa/xZFVS3M0ijfkHKGeaMVV4nKc0YYmVVe6p3AL9MOK08VAISgUhrXeaHZ4FHz/lPMleZhin7qt7wnEGGLam5MHGkUEk0pxuyLx6v6rcwXdWVVzEKL8XY8TJwv79p9OBSMaYO+xAsOSaRfBE+Od8YxBpLJD7wptMSFUgITGttNO9nDj+g6Kgy47gsoLKwEUA54V2oyKQVUfbB9NFhG5ZFfZkHqVJ6YKPVWZa73BwQIjJbn5yiQA5cEVrLeziGUrWGmB4WZx9H0KocMwci7ZE3L1JS4BlS7Dm4sK34opF/fKgQnpEWwnAQlDDWYJIBj6dHs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9332.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(38070700021)(261009223027099003)(4143699003)(10067099003)(6133799003)(56012099006)(5023799004)(10063799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UE9UdWZXOHJ6UW1ldWZBeDVwTnRFMDVzK3pXcUpUWHR1eWczRFNrcUlzSHEx?=
 =?utf-8?B?bnB4WDBBOWo0SDZnWFovbDVOVE9jWGgrTkczNTQ3Tkhha25Ob0Z6T2Z4M2Vq?=
 =?utf-8?B?Qmp6MndRaHhyR3JWL1hDUnN6ekp4WlpVNGRHZWJLdmV5SmR2cGN5d2JXdFNw?=
 =?utf-8?B?L3ROQXdVWVl2QTFOVG9QUnZmNnRsTGFNY3Z3Z2k5eEtqaTZzbWRndnlQSHVS?=
 =?utf-8?B?d0QzK3o0TGtVckxSTWZIdjhMeno4cVpUZXh1aG1FQkNmcXlhSEhLYm82cUgz?=
 =?utf-8?B?OWErVjFVVy9QSW9OOUt0emVuMDh1QnJqeWdBbnZ1Y0JXZ1ZuZC82NWZQVks4?=
 =?utf-8?B?bmVPeTl2Uml2VE5rYTJid1dwSHp5TDZVWUZyM1I0cnNTUVRlbmdwaXdjWXRn?=
 =?utf-8?B?QTFlUVlUdWllT0RLMnhwWDlqZlQwcHF6OUNQSTBSa0c5WlJhQ2lyQ21RaGts?=
 =?utf-8?B?OFp3T0kxNDZ2NmdKOWxXbUdiRU9TVFUwdk5WUWhTS0lYOVFWbWY2WkxHWWI4?=
 =?utf-8?B?RWliMXVleXFiZWdkZk53d283M3NZUFdxeFM3MHNydXJKQ3UrNXQvaGlHdlhK?=
 =?utf-8?B?cFNyaEtQeEVMcE1FeDdmWU1tZENzNHd0a0E5VWFyb3R5dC9UOUN2QlUyb2R3?=
 =?utf-8?B?Zk1HZ1dIdngvNGdwY3NXUzVsbW4xdS9IQ3E0dEhlQW5NVG1IUmhmeDdib3ZZ?=
 =?utf-8?B?bTRhT3duQzlNdDN3a3dJTWZlTFY2NW04VUZXYVp6YVlURitzZC9sbXdRUENL?=
 =?utf-8?B?MnJuVnI5ZDV6TTMxSjVRTVYyQ0ZMQTRXMjAxb2l3TXVkc3FYalcwNkJzWGJ5?=
 =?utf-8?B?YVhTMXJEV2RneDNzclY4RHU1R1ZaYmhVMmFpTUM5dCtjRFdIcFZaRnZCQVBk?=
 =?utf-8?B?R2orV0lRUE8ybkhpenl5NzZUbUY5YnJ5bFMzRlpLSzhBQWpYcUE1MURRQWFm?=
 =?utf-8?B?THpFQW1sSWF2cVRTN2lzVnpZMjlWMDB4NVhpSFZ6ZmNLRm1RZlRFRmNtN29L?=
 =?utf-8?B?K2dWQmhIVXhmSXphaHAyUHhJQWk5UGFKZE83ZlpFR1BMUHZ3eTBmTEt0VEpX?=
 =?utf-8?B?Y29SQlRTUkRuMHh1STJ5TnVaNGZFNmhuM1dkNDZyanpXM05RdGdCRDArVXBv?=
 =?utf-8?B?U2VRWVA2elMvcWdLNlY2dDFML01Zc1B5SjFMRkM4dHZCZ2NndnhoUTNGUzNx?=
 =?utf-8?B?UzVNRzI2Z3hSZ2N6eVpsekRPNE1JR09rdzdGSnZyVm9FVVpsaWpPMURWZXR4?=
 =?utf-8?B?cXdkS0ovTk5PMUxJNm9XLzRJR1dMbHI2eHRFWjh4MTFIeFl4MGJzc1hLeVk2?=
 =?utf-8?B?SEdtUXdVY2kvYTJORXUwM2x2d1Z5M25RbURMYkl0M2RsK2RTK2ZzQ21xSDh6?=
 =?utf-8?B?azQ2QkJJK2ZiTmdDMlliNEFYc3NLdnNORUFuU0tiS2MrOFhOUTRxRGQvcWRn?=
 =?utf-8?B?bWt2OWx1bDQ0ekl4ak8vb3dvZW1ncjVRQWdWOUwyc2IvR2Zwa1NQQmVQOGhR?=
 =?utf-8?B?d0FzdXRxanp4OUxYOXV5ZE4zUTNlNGhsbGFZS25uZzVsazNBM0FBcGZudUM1?=
 =?utf-8?B?djRTam9qb1FkVFlaQUpuZzFUR0ZCSGRLdEdidUI3NzNnSWd2Q1dOTmdmVWNh?=
 =?utf-8?B?Y3U2dStMN0svOEx2NzhaMS9lczBSSThTcXR1aHEvRUNoTjJrbEZKUXQ3eU1P?=
 =?utf-8?B?RTlaTmVSeVNLcjJvcC8vTDJGMFBlbm5jb0ZFUTFiaEhjcjI2MCtPU2YrZTdq?=
 =?utf-8?B?aVVqb3RnWEpJNjJqT0hJOCttczNZZ1JzVkFlNkpQSU45Qm43RzkzYUNoVU9E?=
 =?utf-8?B?UXhOZ3lWeUlpS3RwKzNZNnBTNHB6bGcrNGUrc2JXSUlUeUtPenNTSFlaTTMy?=
 =?utf-8?B?aHNuYXdPUk9kRTVGR2RrS2UxTDJSODJkZkZ5V2VGZmMydm5mdWJERHRKMjlP?=
 =?utf-8?B?Z1NPRTlrSDhaNTZHMHZ2cms5aUpmdWR4T2liWkVpS3QrcncrOEZIWklDS2hr?=
 =?utf-8?B?MDdla01UR1BFNDNCZGhNOElrYjZ5NXB6ekZSWTlXaUR0dU44aXN4M0llSzI1?=
 =?utf-8?B?TFRSbUtZYjYyTmlpWEs0akVSdlFUenFaRkdHSmJVbWNsdHFhazRmMkV4WkM0?=
 =?utf-8?B?UVVjVGZ6MjRrK3ZpZFJIeXJGakFPMk1LZkQxWWpHZU1MZmNLOVU3QkM1UGZS?=
 =?utf-8?B?U21qaXBteVYxblN1aEtWYktLWUlUVk9mRVU2MHhucUh2TEY5b2VFSGN0bEU4?=
 =?utf-8?B?V0FCbFIyUkdDZWxualkyNitHZFozaTlGOXpzazRaRzZwSE81UElaVXJsQjVt?=
 =?utf-8?Q?Z6evokGATQBCKeU5kW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9332.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e42ce0a-940c-4e4a-3e36-08df299a3396
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 02:23:57.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZW+GHTgw6bYroguQcGS5kagYDmkmx6Jp4lqH/EdSxomxv1CVRWUBJOiQna60fu1wNaUz6w+vckRRe2KZ669+lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042

PiA+ICtzdGF0aWMgaW50IG5ldGNfc3dpdGNoX3Jlc2V0KHN0cnVjdCBuZXRjX3N3aXRjaCAqcHJp
dikNCj4gPiArew0KPiA+ICsJaWYgKHByaXYtPmluX3Byb2JlKQ0KPiA+ICsJCXJldHVybiBwY2lf
cmVzZXRfZnVuY3Rpb25fbG9ja2VkKHByaXYtPnBkZXYpOw0KPiANCj4gW1NldmVyaXR5OiBIaWdo
XQ0KPiBDYW4gYSBjb25jdXJyZW50IHRocmVhZCBleGVjdXRlIHRoaXMgcGF0aCB3aXRob3V0IGhv
bGRpbmcgdGhlIFBDSSBkZXZpY2UNCj4gbG9jaz8NCj4gDQo+IEluIGEgbXVsdGktc3dpdGNoIERT
QSB0cmVlLCBwcml2LT5pbl9wcm9iZSBpcyBzZXQgdG8gdHJ1ZSBkdXJpbmcNCj4gbmV0Y19zd2l0
Y2hfcHJvYmUoKS4gVGhlIHRocmVhZCB0aGVuIGNhbGxzIGRzYV9yZWdpc3Rlcl9zd2l0Y2goKSwg
d2hpY2gNCj4gaW50ZXJuYWxseSBhY3F1aXJlcyBhbmQgcmVsZWFzZXMgZHNhMl9tdXRleC4gSWYg
dGhlIERTQSB0cmVlIGlzIGluY29tcGxldGUsDQo+IGl0IHJldHVybnMsIGFuZCB0aGUgdGhyZWFk
IGNhbiBiZSBwcmVlbXB0ZWQgYmVmb3JlIGV4ZWN1dGluZw0KPiBwcml2LT5pbl9wcm9iZSA9IGZh
bHNlLg0KPiANCj4gQ29uY3VycmVudGx5LCBhIHNlY29uZCB0aHJlYWQgY291bGQgcHJvYmUgdGhl
IHNlY29uZCBzd2l0Y2gsIGNvbXBsZXRlIHRoZQ0KPiB0cmVlLCBhY3F1aXJlIGRzYTJfbXV0ZXgs
IGFuZCBjYWxsIGRzYV90cmVlX3NldHVwX3N3aXRjaGVzKCkuIFRoaXMgaW52b2tlcw0KPiBuZXRj
X3NldHVwKCkgZm9yIHRoZSBmaXJzdCBzd2l0Y2guIE9ic2VydmluZyBwcml2LT5pbl9wcm9iZSA9
PSB0cnVlLCB0aGUNCj4gc2Vjb25kIHRocmVhZCB3b3VsZCBjYWxsIHBjaV9yZXNldF9mdW5jdGlv
bl9sb2NrZWQoKSBvbiB0aGUgZmlyc3Qgc3dpdGNoJ3MNCj4gUENJIGRldmljZSwgZGVzcGl0ZSBu
b3QgaG9sZGluZyBpdHMgZGV2aWNlIGxvY2suDQoNClllcywgdGhlcmUgaXMgYSBwb3RlbnRpYWwg
aXNzdWUsIEkgd2lsbCBmaXggaXQNCj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJuIHBjaV9yZXNldF9m
dW5jdGlvbihwcml2LT5wZGV2KTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gRG9lcyB0aGlz
IGludHJvZHVjZSBhbiBBQi1CQSBkZWFkbG9jayBiZXR3ZWVuIHRoZSBQQ0kgZGV2aWNlIGxvY2sg
YW5kDQo+IGRzYTJfbXV0ZXg/DQo+IA0KPiBXaGVuIGEgbXVsdGktc3dpdGNoIERTQSB0cmVlIGlz
IHNldCB1cCwgbmV0Y19zZXR1cCgpIGNhbiBiZSBjYWxsZWQgZm9yIGFuDQo+IGFscmVhZHktcHJv
YmVkIHN3aXRjaC4gSW4gdGhpcyBjYXNlLCBwcml2LT5pbl9wcm9iZSBpcyBmYWxzZSwgYW5kDQo+
IG5ldGNfc3dpdGNoX3Jlc2V0KCkgY2FsbHMgcGNpX3Jlc2V0X2Z1bmN0aW9uKCksIHdoaWNoIGFj
cXVpcmVzIHRoZSBQQ0kNCj4gZGV2aWNlIGxvY2suIEhvd2V2ZXIsIG5ldGNfc2V0dXAoKSBpcyBp
bnZva2VkIGJ5IHRoZSBEU0EgY29yZSB3aXRoIHRoZQ0KPiBnbG9iYWwgZHNhMl9tdXRleCBoZWxk
Lg0KPiANCj4gQ29udmVyc2VseSwgd2hlbiBhIHN3aXRjaCBpcyB1bmJvdW5kIChlLmcuIHZpYSBz
eXNmcyksIHRoZSBkcml2ZXIgY29yZSBmaXJzdA0KPiBhY3F1aXJlcyB0aGUgc3dpdGNoJ3MgZGV2
aWNlIGxvY2sgYW5kIHRoZW4gY2FsbHMgdGhlIGRyaXZlcidzIHJlbW92ZQ0KPiBjYWxsYmFjay4g
VGhlIG5ldGNfc3dpdGNoX3JlbW92ZSgpIGZ1bmN0aW9uIGNhbGxzIGRzYV91bnJlZ2lzdGVyX3N3
aXRjaCgpLA0KPiB3aGljaCBhdHRlbXB0cyB0byBhY3F1aXJlIGRzYTJfbXV0ZXg6DQo+IA0KPiBu
ZXQvZHNhL2RzYS5jOmRzYV91bnJlZ2lzdGVyX3N3aXRjaCgpIHsNCj4gICAgIC4uLg0KPiAgICAg
bXV0ZXhfbG9jaygmZHNhMl9tdXRleCk7DQo+ICAgICBkc2Ffc3dpdGNoX3JlbW92ZShkcyk7DQo+
ICAgICBtdXRleF91bmxvY2soJmRzYTJfbXV0ZXgpOw0KPiAgICAgLi4uDQo+IH0NCj4gDQo+IElm
IFRocmVhZCAxIGlzIHVuYmluZGluZyBTd2l0Y2ggQSAoaG9sZGluZyB0aGUgZGV2aWNlIGxvY2sg
Zm9yIEEgYW5kIHdhaXRpbmcNCj4gZm9yIGRzYTJfbXV0ZXgpIHdoaWxlIFRocmVhZCAyIGlzIHBy
b2JpbmcgU3dpdGNoIEIgKGhvbGRpbmcgZHNhMl9tdXRleCBhbmQNCj4gY2FsbGluZyBwY2lfcmVz
ZXRfZnVuY3Rpb24oQSkgaW5zaWRlIG5ldGNfc2V0dXAoQSkpLCB0aGUgc3lzdGVtIGNvdWxkDQo+
IGRlYWRsb2NrLg0KPiANCg0KLS0NCnB3LWJvdDogY3INCg0K
