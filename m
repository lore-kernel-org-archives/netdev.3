Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D234B1A6
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314540; cv=fail; b=hdHhBn+laj4zJrx7dVoKjMWxlxtj6BGrQMD0w9Zi7ze4TV85s55ZEvtLGeNaj4CXSA6tHEbVhpGxqXXz9ncbEzoZEKNaW2Hx0Jo6DQKktLcDstfeK3aqyB4lsMI2eaihPIEAlqIV6pLBZb5kEDNfWo0DQ/uOXs9oFOikwqGA4E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314540; c=relaxed/simple;
	bh=RwD4OPjJqzfkEFA+kNz3bGQ3MKsWxfbTQ780yyxpcdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jeygNaj/CNCyyBkIcfCHLTxRArXIeabknstRd71U7brJOYcB07rVhJe1efJeAXnbi9Z37tzclHoHstCkFmVzfXpsV1CVaHFH+bsM5c6ySBu9SmN7oq6MNxG1nIJitwPKETroMnysemVCmbJlPVILwZetpauSXXQT4gQPBUB7ouo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VK8jGcZY; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VK8jGcZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7VWU1840JAFwT1fpq6ko8slQqY20MtwwbN2AIa/cgBVffj9Y8TuMTWXYw3W9SFj2iQSeXd6k4woFKtmWJ/Bs7rUQa8FynxtyaIypBZtYMYnF0WeMz2eldVLM+zUn7AHU1eOyq0iTTNphRsulG6JLjDyaMcK0kcLBgxY6mmwRCEYOEhH6TihH3F0rrDTXz2ZSUQfGA4pjiyVYlWYZeZF0SR9HDut43ITQkywa3BKhq1OkFOWxf8Nrkc96Fr+hIkIMFtUB3W/gFfr5ujMORUfjFLXaLzp5p5sL/BkYS5zhHjSI0OMI/No8DhWzXnTDf9QZaYTUi6SGp5Cu0I4/lKVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwD4OPjJqzfkEFA+kNz3bGQ3MKsWxfbTQ780yyxpcdo=;
 b=R/6z0XlhMyJhXa9QYBShXL8sxsoWQtJ98GZy2onVzR9OfEtYeaEeI+4fZrl47E2CfiN29kgCc7DIzhhnFXgEUwGeT4BbIiFgeiNkoFSYSSH5P0sMIQOZceGP9l5ZK9+ZC+EOez/d4vvoUshd3IOt+E0Bc8UMpyM+aIp+vtfAR96iCNVTgpQZiLbcAkHNT6q03UuLZbCmuox2lOo2Gcj8X78NSbldPKW8SnX0At+iRXnJFUGRz30IwZ7ZHeGXYUHfC5casgnyiQ5F4kCbpItA8W07m+jIxlUBLoKetOl/5br66Jvf2WyuJID//5fbpVUPDtEthLPR+QfXz+tGDbdihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwD4OPjJqzfkEFA+kNz3bGQ3MKsWxfbTQ780yyxpcdo=;
 b=VK8jGcZYxFA9OJwrUlnSSVyBBpBq133/LVhDkyQQ9bgiPZwaxt12B/+1x0YQx7tksPmfWbQ1iSbNguXDPydTEy7iFt2xIXxNdFjjNMOuWn6Vry1dEE0+mT/slughPbkdV0IYyZG8PdnlCzUbsC7R8DA2od4xwIVAwa2D+zsoUF40nDTp5IZI7fz3MFTxoS6FciAgcXLoJERwvnjzy+inZuahB68dL4s1rJ3Hhcrx4+rNmAUuMMcA3JlKzieUudYrcywXz699Gh82a/fZ08OB4uxM6fqTOf+hawHaYj+ODMlsiYeWH1LjLfhlR0iG8AXyj2jRJOAA8E8rZIbGUgFqZw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GVXPR04MB9904.eurprd04.prod.outlook.com
 (2603:10a6:150:119::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:02:11 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:02:11 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Linux Kernel Network Developers
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 3/8] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
Thread-Topic: [PATCH v3 net-next 3/8] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
Thread-Index: AQHdOSF+DFS+J5ivnEWEUGwBCbwTlba5YzeAgAEopQA=
Date: Wed, 2 Sep 2026 02:02:11 +0000
Message-ID:
 <GV2PR04MB11739F1217DAF1105EDCA3E1788B72@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
 <20260831082335.1184605-4-wei.fang@oss.nxp.com>
 <20260901082025.AF94B1F00A3D@smtp.kernel.org>
In-Reply-To: <20260901082025.AF94B1F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GVXPR04MB9904:EE_
x-ms-office365-filtering-correlation-id: 9b6078a4-f6d6-4a15-a9ce-08df089633d3
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|56012099006|38070700021|4143699003|6133799003|10067099003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info:
 6VGoHEyywgm3rdU3r2tMjD/mw4tHA3j8pjOMKAjmZiNockAwTQtgbFrbiU4pLtyMAgJPRCyEj1553/YJauShfL+xG7Au6o/R457FfEW7Dip4v7c2sRNA3PAAK8G5l+ALbM3S8SKogeLbiPGsp0XPy44r5sM0vlr4nCd9Kz9uEnBDnByJ9KJ2xRJpfLu1yfp5B10Fuo0UO1DV+121v5yVxLHK1Tnabn9D/s6z9WY9UPoS8sOPTopxRH7EPrQpAoiYKpdUsIrQ1Wj2z4ZU1OetBOpSBe1u+0yW4fxWT9kXA2KOLpPbmfnW4qWnBmp1t4BR7diADTwWIIm9mjWtJss2T9FYpscJB0ibC0gHZII5CeAeh99ygUwSV/0daqZvRlr2ysNF+7OdyN/dAiEZtarwlbmWRtnIgeM9M2W3wz9c7DyZ/zmAF8q7fkFHtLj3ph2Z4+q8p4uARmU9MuHmqi9XjnLPzV5rfFoIqRS+FASTUHkuVFXSfWWFXUI4cPt/mquXLQEVgqVVduoQufSWDp+p5pJ+T5xmfTLjaK0sFeFyHDNZjaYjNSTj3+g1LBbCHjapOlUunmyBZESTLGCTkXPsJXBo23grxKCKDFywJYN9nlm1L1SEiJ7NdF6hPKDpEZEzhcKUJ9h23simLAkyt6/YM/+M5Q/8My9t6GE4Yx0o0Ee9AOYCfNa2hAQJmWAKhTjuoeyIaaxoOYKJoxjgPb5fQA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(56012099006)(38070700021)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGxrYWdGU3Y2MHZEMjFzUDVSKzdYUnVHc3kxT2oxMzJrL2cyZHlpbzNWVDFi?=
 =?utf-8?B?SU5UL0NJWTNSNXp0Mm5zYVpTVkRRVFcwRE5MQzRCUHhsMTdHNVkyWmw1Wkxk?=
 =?utf-8?B?TVExbWF3TW1nQ21KWkRBUzM5ZEhPZjNwemFUbW5HTjZyV0JXcEhwYS9laExW?=
 =?utf-8?B?RnByS2RZSUNMNEVVOTFNcGFWSzI5UkJmZWtjTjF2SE1RRmpoTzVkWFpOWUxZ?=
 =?utf-8?B?QWdtdjZPQ3BKbFY4L3pHUHRIaXk2SUhrd09HUURPY3N4ZSsyQnMzYXl3bTZL?=
 =?utf-8?B?Y1pQZFFuMmIya2x1S01NVFBTdzA2bkVSM2N3SWJqMm1vWmVXeG9hRGJEaUJR?=
 =?utf-8?B?eVcwZG9hb08xV2pLZGlBZzY1cXZmOVg1dC9xWGRwYktmR2dKTkNsWGJqQTJR?=
 =?utf-8?B?dnBUWjVma0RFUDNIL3JnRy85SFZqQ3p6SG1NTzg3ZWx1OVpPejBCZlZkTnVB?=
 =?utf-8?B?NHhUbHRrL25Td1EzOGNZc3I3RnhBSnpWV0FubkJVWU1nQ3BDNHZURXE4WmNO?=
 =?utf-8?B?dW0wZTFJZ1k3Mk5NQU9CNTVRZlpmVS9Ialp4Sm94Q0VpcGJzMlp5cDF3N3I2?=
 =?utf-8?B?VHpTeEZiN0NRZlBBNW94WlBRRFgwQzZTczRrM0p6cW9lQXJGWGw5TVZqZFhj?=
 =?utf-8?B?MlpDQVdvVzhQcDArLy9wb3pPVUJ1QUFIUHRjTEpjcUJpUHZORTdyZ1pqRWY5?=
 =?utf-8?B?NUdVdEl1U0lZN2lYVkU0dXV2eURsWmppc0F5MHlEQWh2SVA4SU9zeTB3TmNR?=
 =?utf-8?B?ZlR4RjFLTVlLR0htMS9jWUIrMDBGSjA0ZnFhOFB5OUNsSXpZOUVDOThieFdM?=
 =?utf-8?B?R0hHWnR2MHBYbGNDZktySEs3NENDT1ZmNDJLWlQxeE1BQlkveEZjbjNqU2dj?=
 =?utf-8?B?MnYzRWpycml6OXVDSmhXZHBRd2VaRUovUldGb3FPanBmTnZ2eGM3ajkzMzZz?=
 =?utf-8?B?VXJLMXB1eHdLS1k3V0srTHBKOFJvM09MUDdFRFNycE1TR0loMitJTXZNc0Vv?=
 =?utf-8?B?UUhSTEo3Nm9uaUh3VG9PVnM5OCsyRU1iOWFReTJoMDNZZ2NzVDJLWkp6ckF1?=
 =?utf-8?B?QUNxZEVzU1lJdnVRaDJFMTQ2S25HWnZmOWdUZE5Vc0JyYjk4aVZiSC83ampQ?=
 =?utf-8?B?VWkvdjc4YWFNU2Q3SnVIcUxTM3pBd0J1aDdYM1c4aDY5cUlsYUdYaFFNVWt2?=
 =?utf-8?B?ZU4rL0V0VkI5d0VIWjZGeWZCY1RYWE5lSUlncldTU2kwN0Z6cnJ6MFlEYjdu?=
 =?utf-8?B?SkNlUzhtOGtjZHVBaFAyTHRxeUtOVDVRM0pXdjVXTUFGdWorTy9pdXlsVWtv?=
 =?utf-8?B?MDlGTUpwVFdsaml5djM1a0R5SVdsTmNPVkI3dGZBQVdXTEFWQ1pCQnRvYi94?=
 =?utf-8?B?dnpnbWJEeTJ6YmpMT1NtTFRoMDN2S2p1eHk5UnNmTGF3VXhLcENhWkhacDJX?=
 =?utf-8?B?UjY1cHV4RmtqSHQ2RVptTEJWb2ZsNXJ5WFVjRGMxVldUMTZjQ2Yra0JYeVIy?=
 =?utf-8?B?ZU5LcHFibi9QbXZFQVJlZWs5VG40Yy9GVG5yWnBLdEI4TWxldkJ2OUUxelJa?=
 =?utf-8?B?WXNpZ1l2MXV5SkZXbkpManNSVDl0MU5yU1VpL0V4S3JYbVRBMkhZVUtSQ25D?=
 =?utf-8?B?UTQyL2MwblNaaHVnZ0t6b3VkY0dYY0pZUi9lUVdKRlVBLy8rRHA2bm5nY3Ey?=
 =?utf-8?B?QjRJSVN4MjF0R3BycmxIb2lSVWFKS1VRZUkvcFdsMTRRelkvM0hsYnhXNVBT?=
 =?utf-8?B?RGdIR3I4bEliU25iRXhRWTBhakFWaEhPSnY1Z0prdnBrbHFqRlhhWS9RSm5K?=
 =?utf-8?B?eEJhY0IyOFlYUWlWbTFjY25JbHpWV3FNZ1ZKb0VNNXcwZCtoTFMvZlYyU3Zh?=
 =?utf-8?B?RDNyNUEwbG5EUTZaSlBhQndsRjFhSDFjOXFWZEVIajlKbW05cHNFNSs4dXVU?=
 =?utf-8?B?MUJaYjNzOG50N1Bsb3JBOGRLUFlYTkpnbnVQMTZONlpvSTNtS056QTBpSTk3?=
 =?utf-8?B?RDFsWlpQbk1xR3lEVlRzeDR1U0I1QXFjMGl2RDdHd3preklETmRGTnFzaktp?=
 =?utf-8?B?RDU5anBNRkZWUG0xdytEbDF5dDdaNnNjTmx3WGU4dTFnT3p6MUhudmR4eGN2?=
 =?utf-8?B?cnU1QldFdmJxYXE5WGY1THdFYkxyMWZxc1NIYWhROGovK0t1N3plckUrUWEv?=
 =?utf-8?B?dTc3RlNvMHlJb2I0TUhTVGpNUlNkekNiL1VHOVlicFpEaERsSlVicjVnSTI4?=
 =?utf-8?B?L3lNbDZQdHEwazZoQ0FWYWtoQUZ6UkhDUFhLRlhEVm9reUEvaU1EeWFHdHAv?=
 =?utf-8?Q?x5k46Mz0mBldUFdg5p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6078a4-f6d6-4a15-a9ce-08df089633d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 02:02:11.7226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUwh47B6gTkQoGtuEvMQJ0jaol7Lo6NOzwtzGi3tsa7UYuSJ+Xk6Cwu6+5y+kZnQ5aLrFLloCmHlvN66tbhgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9904

PiA+IEBAIC0xMDIxLDUgKzEwMjEsNTUgQEAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIG5ldGNf
dGltZXJfZHJpdmVyID0gew0KPiA+ICB9Ow0KPiA+ICBtb2R1bGVfcGNpX2RyaXZlcihuZXRjX3Rp
bWVyX2RyaXZlcik7DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIG5ldGNfdGltZXJfZ2V0X2N1cnJl
bnRfdGltZSAtIHJlYWQgdGhlIGN1cnJlbnQgUFRQIHRpbWUgZnJvbSB0aGUgTkVUQw0KPiBUaW1l
cg0KPiA+ICsgKiBAcGRldjogUENJIGRldmljZSBvZiB0aGUgTkVUQyBUaW1lcg0KPiA+ICsgKiBA
bnM6IFRoZSBjdXJyZW50IFBUUCBjbG9jayB0aW1lIGluIG5hbm9zZWNvbmRzLCByZXR1cm5lZCB0
byB0aGUgY2FsbGVyDQo+ID4gKyAqDQo+ID4gKyAqIFJlYWRzIHRoZSA2NC1iaXQgY3VycmVudCB0
aW1lIHJlZ2lzdGVyIChUTVJfQ1VSX1RJTUUpIGZyb20gdGhlIE5FVEMNCj4gVGltZXINCj4gPiAr
ICogZGV2aWNlIGFzc29jaWF0ZWQgd2l0aCBAcGRldi4gUmV0dXJucyBhbiBlcnJvciBpZiB0aGUg
VGltZXIgZHJpdmVyIGhhcyBub3QNCj4gPiArICogeWV0IHByb2JlZCBvciBoYXMgYWxyZWFkeSBi
ZWVuIHJlbW92ZWQuDQo+ID4gKyAqDQo+ID4gKyAqIENvbnRleHQ6IFByb2Nlc3MgY29udGV4dCBv
bmx5LiBBY3F1aXJlcyB0aGUgZGV2aWNlIG11dGV4IHZpYQ0KPiBkZXZpY2VfbG9jaygpLA0KPiA+
ICsgKiAgICAgICAgICB3aGljaCBtYXkgc2xlZXAuIE11c3Qgbm90IGJlIGNhbGxlZCBmcm9tIGF0
b21pYyBjb250ZXh0LA0KPiBzb2Z0aXJxLA0KPiA+ICsgKiAgICAgICAgICBCSCwgb3Igd2hpbGUg
aG9sZGluZyBhIHNwaW5sb2NrLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAgb24gc3VjY2Vz
cywgb3RoZXJ3aXNlIGEgbmVnYXRpdmUgZXJyb3IgY29kZS4NCj4gPiArICovDQo+ID4gK2ludCBu
ZXRjX3RpbWVyX2dldF9jdXJyZW50X3RpbWUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU2NCAqbnMp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlz
dHJ1Y3QgbmV0Y190aW1lciAqcHJpdjsNCj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4g
KwlpbnQgZXJyID0gMDsNCj4gPiArDQo+ID4gKwkvKiBTZXJpYWxpemUgYWdhaW5zdCBkcml2ZXIg
dW5iaW5kOiB0aGUgcmVtb3ZlKCkgY2FsbGJhY2sgcnVucyB1bmRlcg0KPiA+ICsJICogdGhlIGRl
dmljZSBsb2NrLCBzbyBob2xkaW5nIGl0IGhlcmUgZW5zdXJlcyB0aGF0IHByaXYgcmVtYWlucyB2
YWxpZA0KPiA+ICsJICogZm9yIHRoZSBlbnRpcmUgZHVyYXRpb24gb2YgdGhlIHJlZ2lzdGVyIHJl
YWQuDQo+ID4gKwkgKi8NCj4gPiArCWRldmljZV9sb2NrKGRldik7DQo+IA0KPiBbU2V2ZXJpdHk6
IEhpZ2hdDQo+IERvZXMgYWNxdWlyaW5nIHRoZSB0aW1lcidzIGRldmljZSBsb2NrIGhlcmUgY3Jl
YXRlIGEgY2lyY3VsYXIgbG9jayBkZXBlbmRlbmN5DQo+IHdpdGggdGhlIHN3aXRjaCdzIHJlbW92
ZSBwYXRoPw0KPiANCj4gV2hlbiB0aGUgc3dpdGNoIGRyaXZlciB1bmJpbmRzLCBpdCBhY3F1aXJl
cyB0aGUgc3dpdGNoIGRldmljZSdzIGRldi0+bXV0ZXgsDQo+IHRoZW4gcnRubF9sb2NrKCkgdmlh
IGRzYV91bnJlZ2lzdGVyX3N3aXRjaCgpLCBhbmQgdGhlbiBvbmVzdGVwLT53b3JrX2xvY2sNCj4g
dmlhIG5ldGNfcG9ydF9kaXNhYmxlKCkuDQo+IA0KPiBJbiB0aGUgZGF0YXBhdGggd29ya3F1ZXVl
LCBuZXRjX29uZXN0ZXBfd29yaygpIGFjcXVpcmVzDQo+IG9uZXN0ZXAtPndvcmtfbG9jaywNCj4g
YW5kIGNhbGxzIHRoaXMgZnVuY3Rpb24sIHdoaWNoIGFjcXVpcmVzIHRoZSB0aW1lcidzIGRldi0+
bXV0ZXguDQo+IA0KPiBCZWNhdXNlIGxvY2tkZXAgdHJhY2tzIGFsbCBkZXYtPm11dGV4IGxvY2tz
IGluaXRpYWxpemVkIGJ5IGRldmljZV9pbml0aWFsaXplKCkNCj4gYXMgYSBzaW5nbGUgbG9jayBj
bGFzcywgd291bGRuJ3QgdGhpcyBmb3JtIGEgZGV2LT5tdXRleCAtPiB3b3JrX2xvY2sgLT4NCj4g
ZGV2LT5tdXRleCBjaXJjdWxhciBkZXBlbmRlbmN5Pw0KPiANCj4gQ291bGQgd2UgcHJldmVudCB0
aGUgdGltZXIgZnJvbSB1bmJpbmRpbmcgd2hpbGUgdGhlIHN3aXRjaCBpcyBhY3RpdmUgYnkNCj4g
Y3JlYXRpbmcgYSBkZXZpY2UgbGluayB3aXRoIGRldmljZV9saW5rX2FkZCgpIGluc3RlYWQsIHdo
aWNoIHdvdWxkIGFsbG93DQo+IGxvY2stZnJlZSByZWFkcz8NCj4gDQoNClRoaXMgaXMgYSBmYWxz
ZSBwb3NpdGl2ZS4gVGhlIHByZW1pc2UgdGhhdCBsb2NrZGVwIHRyZWF0cyBhbGwgZGV2LT5tdXRl
eCBsb2Nrcw0KYXMgYSBzaW5nbGUgbG9jayBjbGFzcyBpcyBpbmNvcnJlY3Qg4oCUIGRldmljZV9p
bml0aWFsaXplKCkgbWFya3MgZXZlcnkgZGV2LT5tdXRleA0KYXMgYSBub3ZhbGlkYXRlIGNsYXNz
LCBzbyBkZXZpY2VfbG9jaygpIGlzIGRlbGliZXJhdGVseSBleGNsdWRlZCBmcm9tIGxvY2tkZXAn
cw0KZGVwZW5kZW5jeSBjaGVja2luZy4gVGhlIGRldi0+bXV0ZXggLT4gd29ya19sb2NrIC0+IGRl
di0+bXV0ZXggY2hhaW4gaXMNCm5ldmVyIGJ1aWx0IG9yIHJlcG9ydGVkLg0KDQpUaGVyZSdzIGFs
c28gbm8gcmVhbCBkZWFkbG9jazogdGhlIHR3byBkZXYtPm11dGV4IGluc3RhbmNlcyBhcmUgZGlm
ZmVyZW50DQpvYmplY3RzICh0aGUgc3dpdGNoJ3MgZGV2aWNlIHZzLiB0aGUgdGltZXIncyBkZXZp
Y2Ug4oCUIHNlcGFyYXRlIFBDSWUgZnVuY3Rpb25zKS4NClRoZSByZW1vdmUgcGF0aCBuZXZlciB0
YWtlcyB0aGUgdGltZXIncyBsb2NrLCBhbmQgdGhlIGRhdGFwYXRoIHdvcmsgbmV2ZXINCnRha2Vz
IHRoZSBzd2l0Y2gncyBsb2NrLCBzbyB0aGVyZSdzIG5vIEFCQkEgb3JkZXJpbmcuDQoNCmRldmlj
ZV9saW5rX2FkZCgpIGlzbid0IG5lZWRlZCDigJQgaXQgd291bGQgYWRkcmVzcyBhIG5vbi1leGlz
dGVudCBwcm9ibGVtDQphbmQgc3RpbGwgd291bGRuJ3QgbWFrZSB0aGUgcmVhZCBsb2NrLWZyZWUu
IA0KDQo=
