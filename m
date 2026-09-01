Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD536494F
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245979; cv=fail; b=Hca2FfK1qzvnxJt+F7YVjJvbuUE7tZHVQ4gh6afHcnON1Y3J2CYJnV5/TOPsJRrLBHLk+X+m+75iV/ZeeYuRTeeXsOGGfadhk7W1nwvpesJXFZx+FaljQpsxP/Vfcsefi1HZhPGLnPmCwhhpTaiQ2WN5itIKYXmtQCpfdqcVAo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245979; c=relaxed/simple;
	bh=iTKrdPsx2CnZeLQq9PM2W5U48umWveBW5oI7unpVutw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oimzFoLveKji8mCWHu6iatbc93hvDYAZCZae3we89ZpkE2oxsiZbBWiR8dOxEyO/Kzne/Mc4NxsHdGRE3X4VJTIyCZ9xbe5XpVYyFaKYA7F4oEt+zTI3iMNnVaJ0vlWd1A9NcgjGoC0aAI2tO2900wyi6SDadLWvl5DYDksampo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KHzOZhA7; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KHzOZhA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXrEe/d4obpWBYHjWxr8+dAOvS8qppgZhKv7TiIG0+2NUBSNlN/AfIr87f3SwmOxr7GEgSwdiBFQ4dRSi+mCLIchLdlpcdbZeF3AyJf26HzxsVtvwLpLvNUcqS9o50HM/IZZiTQmnQxkoBM7WfmKPFWnGMn+3sZYRzAXLn8db/jj4KB2CNKk8C9FuK7BuvQ9XT4jZiDRTz1s1W9qrkE5ho4AUGVHQLVZQlMakgOWifxXJmpHbYBXUAHpnjXdaEOF5/UDsXZaMeE5gg7d0ArBWoLYASeBPNj2vu4GuM3R2I/dvyHlR8Qt+Ob4smC+G43X0Zp02tScpcYOxG9PkDXa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTKrdPsx2CnZeLQq9PM2W5U48umWveBW5oI7unpVutw=;
 b=B8BXRX5+C9uiP2xOsMDFMpK9PosfW/QPBCEj2nxZQAT+fBKShlNo4RX3HiD+qy+H22kUhEzbDDOlYBE4w0NsPlKBPtQuPwgj4RwTxeVZ44gZ1hVu1y/PK+SAKiv4bD3nXPtNa5XENwRD5FY8uQDDbjSPpxJIwuPn6frvu/fUEMzFBqgt05SfHgAOIWtJ4q350TxulyfEDwGKmXjiVBKMBUrgi5g1vCdyzG78sVYaHC09jlmd+nsfYtbBnB/lG8Zu2vflvQVHCLvM74QL7Z5vsWJMz6uKKz3+YMvDwbj0P5TfxKUme7fh6j9X9HyWi/0PnTE7Ay+ojmlmz/CsNpSyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTKrdPsx2CnZeLQq9PM2W5U48umWveBW5oI7unpVutw=;
 b=KHzOZhA7Z0OTORQ/4stf7u3w8ZiDtOPYO7xmWBHrwbjq+arYu4F3geUTa72KCaKK5uDs3kATca5rk7xQxcUv4CcLi39smExa9hAcAAGqEHvJ5UWN2Ha+ouTqrDBh4hf3WI4SL75GxplS4295zkhU3IyejBDlr1OnA2GTIaOjPgH5HKqpFel3NPbJoxkpQ0GB/vRg0lz/ItUsZhdLqkrcR+tkPjc03ENtUNV0dKgnLVTZZa/ayJSwA+bfdfU7IPCvUFlWt41nIMqJbEoA0zlPbwma8MoXXwzMUjdcr/9QrVgZmpGtvI2W8XYbDdJjUJNccy7MKn1wAUbmLiqih7Vp5A==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA6PR04MB11807.eurprd04.prod.outlook.com
 (2603:10a6:102:522::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:59:29 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:59:28 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Netdev <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 07/15] net: enetc: add .ndo_set_vf_mac() to
 the enetc v4 driver
Thread-Topic: [PATCH v3 net-next 07/15] net: enetc: add .ndo_set_vf_mac() to
 the enetc v4 driver
Thread-Index: AQHdOPgHwD5qYtLD1kmR69ROxa8n8ba5ELWAgAA8NOA=
Date: Tue, 1 Sep 2026 06:59:28 +0000
Message-ID:
 <GV2PR04MB117398E89D7F46740F76A8AD788A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-8-wei.fang@oss.nxp.com>
 <20260901032358.067311F000E9@smtp.kernel.org>
In-Reply-To: <20260901032358.067311F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA6PR04MB11807:EE_
x-ms-office365-filtering-correlation-id: b2fd7c30-4215-4806-0d12-08df07f690b6
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 WgwI5F1HZ2au7vC45pYj+kF1onJT7p82GsgvgOufcxjPSJr0lxOKQrlqnww2xot74RVeYqZwpzj2keMP1Z6JRvACsUx/AgA6TvHNJGCoDMtrtoYg2zYY3QpmP24//sODiwCLcFXoCRSZOpXpq/vYeFwnBFhJsMOEoSawF92YOK0uB+pbxOP8Cfdc8qR2IlqbP/Wi+o1xiHXOekIoKwyr7HjW2a5VxOb9uwRabz+Xo1oCwAV/OC0Qp/aUcMlhNtnt+Zh0g6DBRbJcgLQXhll1nUlODmW0Zx2IAsddVkcl4uX2dbiZC6UP6POO9LxN4yufTE6+moEbURyoX2fehYyhri1Ne2yrtvWaYEpsvRrVWvLtGxSAl4odeRMgGWlZEtm4kqb8/V6PdpfPW69h2MGlxFKYg2HfgOFraMBpYFS2L5yhQKqD6FQgouPUtj/YPrcOUouMUJ/accfON1Hw+5DtdCkBgIIvEjH048DG6MopXhcFobAv+hf9BuDUuaz716P6P0Sa3l98Us+0yjy4mf2zWYBJFHego+X0KkJZcI7og54HawWQXMRN0wNiYiv+BqdI+aqe/GMapc65SOpUI4JDr7TyvwhZUNbpm5/8fxiGtImRj7LiZHuz5MoBm2YAzj70o04cDmfNpp+KLdFDil4XYFtYY/tRMQFyxn0BDJxk9t+kHzWge5eVuJD0MweCf8Uyic7OigF9PWlhDmSy1Q7gPtGV8BsTwEsnyjazOxUOPJQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDBETW9aQkc5dHRId241MVlMNUVqcUg5ZThwVEd6YW1rMXhTZ0VBNVNERmZP?=
 =?utf-8?B?ckQwc1NTM3ZkeEdRMTYrQUp1NFRNbjM5M1BPVXZva3crQ0VFUDFyUit2bjhm?=
 =?utf-8?B?Um82WlVhTkFqb2FyMk5sOEp0aWl4amp0ZEl0dVIvQVFKMnlPQm1DdFVHcG4v?=
 =?utf-8?B?ODZrNWZncjBVam1hckdYRUpyUWdUVm9UbDhoeUJhSEZidVNMdWhYV1RSd1pq?=
 =?utf-8?B?QTRKYzdXalg4MEFqNXNqQUFpL3hqVzIwQm5ud1lnc3hxbDV1elJKUXYzSmFG?=
 =?utf-8?B?RG9wQVkvTVZpa3JtaElURmcrVXFTdys3OFR2andSRjhHV04rZE0zdnU5SDY2?=
 =?utf-8?B?VTkweVFFTE1XanZqVVBmYUxRWnV3NlZLUVYxZEtIbFNBa1hFbnFKSVViLzdp?=
 =?utf-8?B?aEo5NVN4MDczTFM0cjJFM3Q5RVVKT0pSVXl6THgvbE9DNWF1eXNpaGduaTlN?=
 =?utf-8?B?L2NhZ0FSS1JrckxIeXRrZmYvUDZ0aTluRGowV3FmZjg2MFFrYzhjeWNLKzNF?=
 =?utf-8?B?dzNVNmFuV0tIbHlLUzQvU24wdmIvcnJLaElvL0tBeitSWHhBUWJERjF1L0ox?=
 =?utf-8?B?czdGb3VzNk1OMjBOU3BUd2RoWFBzRDk1WmtWRUFSdzh6OTBGL05sK2gvOG9U?=
 =?utf-8?B?bzlJMWRlU0ZWNkxYWGg2Y3FBS3ZucU4vcUQ3clhoNE5NenBnZjl3VUFhN0Vj?=
 =?utf-8?B?elBPajhyV3h4UlRWYnJreW44c3RqM3J0ZENXTmVJendtU3lVY3d5d3ZMc0gy?=
 =?utf-8?B?Vzc0WlBlY09EVHZnK2lKUk9WQUVHbFFmUkRmeC9mQUVTSlNRYnNuR21Ud1I4?=
 =?utf-8?B?U211cjI5QnpucWY2WkluUXdmUEdBVWw2cG1CblJUd0o1NFB3UHErajc4QjFE?=
 =?utf-8?B?Y01vY015YzFoTGxyNExYYjdMRnllemFVNlAyNUk5bVhjTng0a2srdDRMelR4?=
 =?utf-8?B?VU9ibm50aWg3L0JoN0dkemhrOFpERmhOK3JJWVJvVnYxczFKVU9SR2IvWmZ2?=
 =?utf-8?B?dXNNbjRUWWVWVk1DRnRUOU84OW9hUFRMNjB1UXlTTVAxR3BpSXpucC9PTW1N?=
 =?utf-8?B?Mi9qeUtBYVpkdldKSE5CR0h6Si9Lc1ZjS2VHUEJ2aXByUGZrTjk5dzVoK1h6?=
 =?utf-8?B?NFd4em9kTGI1RDYrTmFPell6Wlp3SHN0a3lnM0l3RG9BdFhsRkVkeE81NFZm?=
 =?utf-8?B?YnVLZzRiNUs5M1VpRjYxWE8rTjdRU0F1TEFjazB5dHIxVzZ2WFNTV3RJOEVR?=
 =?utf-8?B?WjJadkVZeHlER29rU1BxZmtDMXByMDZiOWRVMElseXRIZ09QZjUydk5Nd2tq?=
 =?utf-8?B?dDY4T0haelN0RGwvM3Yvb0EvR2RLUFF1VEhOdlpqWnRvTk9QMDBwaXA5ZHNu?=
 =?utf-8?B?OERxenBSUDBBa3IxNGpiTTc3dExPb2xpcDZvL1hjQi92WWJjZi9laWVNelBO?=
 =?utf-8?B?UmlVR3g5aWxMUjBpME50YXVTQ0JCNHNWQlhZSTc1VDE3NTcyWjlaQWs0NEUx?=
 =?utf-8?B?OEhpVjJ5Y1RuNlczSnMrMWZMaUJVMVBsRGo3QVVqcngzajExMkVrK3RuZEc0?=
 =?utf-8?B?cm5YRDhxdit2djRkUDNIVTJxc2dreE9PWW1TbFZMZVlLYlBzSWtOZnVZRUgy?=
 =?utf-8?B?M1p4VEh1MG1hQitTTU1QUktoVk1aRmZ0WkFZN3diYTEyZFp2WktmS2ZXdlpO?=
 =?utf-8?B?NW00RFA1b3NBZ0dQQW1ONjFPWlRDRlo4dGdZbVlvbDhUMmxlVERheUoxRm9J?=
 =?utf-8?B?Q2hZb3Ayb3lldnpNcHVSVmZDaWZGSXlCa21jM0ZNcXAvNC9uenZyL3RGRm51?=
 =?utf-8?B?TGlrTGtQVmZ6azNVWnFNK3dBcStHMllucWxiS1krMngwZE1kemY5K1U1RHpp?=
 =?utf-8?B?ZDZkY3p3VzBFOTBiakVVbms5YzNBYWc1Vy9LUWZTQjBlRVpBL0pLMUpKVjNl?=
 =?utf-8?B?U3lFVlFLbFZUUUUvdjNwM3ZTbmNTa2lLeDZOR1ZQMUlnYjI0U2hTbHB6NXZu?=
 =?utf-8?B?TUFhajhuVGdqK0JPNWR0anVWQzJ6K2dxb1ZicWJOQUFWUjJGZElMcFVqTlRZ?=
 =?utf-8?B?M05TMEhTRVV1WEs5RGp3WWxMVDl3UVZRSmV6OXByWEdYdE9lbGVxRjdmSjZW?=
 =?utf-8?B?UUw2OGhOdHM4SVcwL0hVaWY1M2hEQjJNWFNrb3YrRDhOUEdwaDBqUzhkQ3dJ?=
 =?utf-8?B?WWlQQWhqTFgra29QeFA1WSsrRjVUTTBLVWg5UDh1SkMvYlFjYnVQempxdEM1?=
 =?utf-8?B?SVgzR2lmc1VrMmNURTBacGFKZmQ5UkdSbDMrZTdISUprM0pEN00yaktsaC84?=
 =?utf-8?Q?NTT9XemW3qTZe9ozHk?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fd7c30-4215-4806-0d12-08df07f690b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 06:59:28.0847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DV4/0mxDldcfsGf6IOmVGmsbVQliTatC+43F1ALD8T5pTmwGNrE2dJtMgwM3tY72kZXOvaIhYr8uP2n+yeV8SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11807

PiBQcmUtZXhpc3RpbmcgaXNzdWVzOg0KPiAtIFtIaWdoXSBBc3ltbWV0cmljYWwgTUFDIGFkZHJl
c3MgcmVnaXN0ZXIgYWNjZXNzIGJldHdlZW4gc2V0IGFuZCBnZXQNCj4gZnVuY3Rpb25zIGZvciB0
aGUgUEYgKHNpID09IDApLCBjYXVzaW5nIHRoZSBib290bG9hZGVyJ3MgTUFDIGFkZHJlc3MgdG8g
YmUNCj4gaWdub3JlZCBhbmQgb3ZlcndyaXR0ZW4uDQo+IC0tDQo+IA0KPiBjb21taXQgNzMzMmNl
M2E0MzZjZWJmYjliMGEzMDQ4OThlYzBiNTkyZDFiMGZmOQ0KPiBBdXRob3I6IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiANCj4gbmV0OiBlbmV0YzogYWRkIC5uZG9fc2V0X3ZmX21hYygp
IHRvIHRoZSBlbmV0YyB2NCBkcml2ZXINCj4gDQo+IEFkZCAubmRvX3NldF92Zl9tYWMoKSB0byB0
aGUgZW5ldGMgdjQgZHJpdmVyIHRvIGNvbmZpZ3VyZSB0aGUgTUFDDQo+IGFkZHJlc3NlcyBvZiBW
RnMuDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUv
ZW5ldGMvZW5ldGM0X3BmLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5l
dGMvZW5ldGM0X3BmLmMNCj4gPiBpbmRleCAxN2ZkOWVlMjc5NDJmLi5lZWI3MGZlZWI3NzM3IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0
YzRfcGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9l
bmV0YzRfcGYuYw0KPiA+IEBAIC01NzksNiArNTc5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBu
ZXRfZGV2aWNlX29wcyBlbmV0YzRfbmRldl9vcHMNCj4gPSB7DQo+ID4gIAkubmRvX2h3dHN0YW1w
X2dldAk9IGVuZXRjX2h3dHN0YW1wX2dldCwNCj4gPiAgCS5uZG9faHd0c3RhbXBfc2V0CT0gZW5l
dGNfaHd0c3RhbXBfc2V0LA0KPiA+ICAJLm5kb19zZXRfdmZfdHJ1c3QJPSBlbmV0Y19wZl9zZXRf
dmZfdHJ1c3QsDQo+ID4gKwkubmRvX3NldF92Zl9tYWMJCT0gZW5ldGNfcGZfc2V0X3ZmX21hYywN
Cj4gPiAgfTsNCj4gDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpcyBhIHByZS1leGlzdGlu
ZyBpc3N1ZSwgYnV0IHdoaWxlIHJldmlld2luZyB0aGUgTUFDIGFkZHJlc3MgaGFuZGxpbmcgaW4N
Cj4gdGhpcyBmaWxlLCBJIG5vdGljZWQgYW4gYXN5bW1ldHJpY2FsIHJlZ2lzdGVyIGFjY2VzcyBi
ZXR3ZWVuIHRoZSBzZXQgYW5kIGdldA0KPiBmdW5jdGlvbnMgZm9yIHRoZSBQRiAod2hlbiBzaSA9
PSAwKS4NCj4gDQo+IEluIGVuZXRjNF9wZl9nZXRfc2lfcHJpbWFyeV9tYWMoKSwgdGhlIGNvZGUg
dW5jb25kaXRpb25hbGx5IHJlYWRzIGZyb20NCj4gUFNJUE1BUjA6DQo+IA0KPiAgICAgdXBwZXIg
PSBfX3Jhd19yZWFkbChody0+cG9ydCArIEVORVRDNF9QU0lQTUFSMChzaSkpOw0KPiAgICAgbG93
ZXIgPSBfX3Jhd19yZWFkbChody0+cG9ydCArIEVORVRDNF9QU0lQTUFSMShzaSkpOw0KPiANCj4g
SG93ZXZlciwgdGhlIHNldCBmdW5jdGlvbiBlbmV0YzRfcGZfc2V0X3NpX3ByaW1hcnlfbWFjKCkg
Y29ycmVjdGx5IHdyaXRlcw0KPiB0byBFTkVUQzRfUE1BUjAgZm9yIHNpID09IDAuDQo+IA0KPiBE
b2VzIHRoaXMgY2F1c2UgdGhlIFBGIChzaSA9PSAwKSB0byBmYWlsIHRvIHJlYWQgdGhlIHByaW1h
cnkgTUFDIGFkZHJlc3MNCj4gY29uZmlndXJlZCBieSB0aGUgYm9vdGxvYWRlciBvciBmaXJtd2Fy
ZSBkdXJpbmcgZW5ldGM0X3BmX2luaXQoKT8NCj4gDQo+IFNpbmNlIGVuZXRjX3NldHVwX21hY19h
ZGRyZXNzZXMoKSBjYWxscyBlbmV0Y19nZXRfc2lfaHdfYWRkcigpLCB3b3VsZG4ndCB0aGlzDQo+
IHJlYWQgZnJvbSB0aGUgd3JvbmcgcmVnaXN0ZXIsIGFzc3VtZSBubyBNQUMgaXMgcHJlc2VudCwg
YW5kIGdlbmVyYXRlIGENCj4gcmFuZG9tDQo+IE1BQyBhZGRyZXNzIHRoYXQgb3ZlcndyaXRlcyB0
aGUgYm9vdGxvYWRlcidzIE1BQyBhZGRyZXNzPw0KPiANCg0KVGhpcyBpcyBhIGZhbHNlIHBvc2l0
aXZlLiBGb3IgdGhlIFBGIChTSSAwKSwgUFNJUE1BUjAvMSgwKSBhcmUgcmVhZCBvbmx5DQpyZWdp
c3RlcnMsIHRoZSBNQUMgYWRkcmVzcyBvZiBQRiBzaG91bGQgYmUgY29uZmlndXJlZCBieSBQTUFS
MC8xDQpyZWdpc3RlcnMuIFRoZSB2YWx1ZXMgaW4gUE1BUjAvMSBhcmUgcmVmbGVjdGVkIGluIFBT
SVBNQVIwLzEoMCksIHNvDQp0aGUgZHJpdmVyIGNhbiBnZXQgdGhlIE1BQyBhZGRyZXNzIGZyb20g
UFNJUE1BUjAvMSgwKS4NCg0K
