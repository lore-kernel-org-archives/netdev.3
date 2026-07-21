Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F853ED5A3
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613280; cv=fail; b=uNvt9fntwixsPz95M0QlqJPdkp12oLjlgKa/BZDijzx18e9kd7roi2R3thwI8h8ZqZjdSHTC446XED17c0ek7g/K5jXXUBX6kzHxStMtViYiwvynP/ZCfpToI2Du7/gLZNjk2PXU42UvGVSFleaOgeOE+W5gXNCtAbrWHL/a/+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613280; c=relaxed/simple;
	bh=03rJv+428BJ6V+cISAWEHPqI5isryTTweHCjTaAYdD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=luqbbt/te6PVEcuM/S4igRMySPgAjIhd94LD3qqWgA+tj4uCTRYgIDmbSC2Buy5QSPN8QFY78WRh7O4EGIxq3R8kwuTouvHIHj8a/rsdK++XxqPBRljXtf2m64phxlWiU9vjN13utwZgR36t4Ko4AwhCKtYW+ApR/zjFoT2jn6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oiIJAvhs; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oiIJAvhs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnr7IXEddKICt3vGkjo9MHO0Vt/msPIdyPNyWnvszurLR80Ih6EpzaBtCFzo2MK+03gIClqnMphUZjMlKOPKM0ACBbe7TEKXC7VvYdkdTdVU65lkuuwm7M4mkI4AM85Cr57s5NiYmCfWtzVo0spbVPFsqGCL/ZQfe9xOUIKEAB8GTNKn9eIo3kgpV4IAKyul4RbHBRfzxRtQY7xz9Brv8+W681x/XGEegByQAcvei/3M2MzzrOPRZv+Gx1I65H4girRPQYR+yCfNSkSA5uPA8fBPIBx+7p4EF54a4oSOxkl69AsUIejiDNe32thkxOMEUwN4f9faPdOiiMGuhnujcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03rJv+428BJ6V+cISAWEHPqI5isryTTweHCjTaAYdD8=;
 b=Znhjt+MtSftT1ed2zSQS4VSNW3DIOcxUU1HfKzNAHQxwHYmwXtHTifIKtEKUa5paXIS+PktPp396BcU/OjvTi35HWu7Vcxoj4eTslpGXxAgpqkOZv8S348la/a28EY/TPFdC5IsyDXofZcZ/4wGgPB4Dkz8J3dVjLuwB0lqNAX+Th6lS8hGk3Rr/OLfTcAk4dVal7a6i7B4IBeMgUUhh0ynzHMqqsbPlEtXqrhNmX+l2mTFK37l6UiQqJ6DJpaPzT0rBSwAnriHm5JDVaFKh7E5xDGowhvZstnKPPMd7AkvYvXQdrPnDArv0CXf8tte3vmKz0kdZdfg7ThB0qV7GWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03rJv+428BJ6V+cISAWEHPqI5isryTTweHCjTaAYdD8=;
 b=oiIJAvhskmReDW+Iexmi1M71oPr7JFrbqiSTzbQJHc2pZetNGv8gHGXMLGETLg+xz9XBmv2z3bcXAOBwpZBkv5OzfLi8awobG2KC3GI68+dV903F/chQAftXC0xGEwpqnISEaiI6OMp2Ha/WLw+nl1FP+G7aD/QPz8AqhLVydvC35miWO3tlJfbaOAbCJP0v4r6M7L9lYjgf1FR54XG9Fl6xjl06GqNxdwmeUzUot0dWlY4J5AiKkuUvCK4Tkj/WiFbeQjcCIM8uNTo6Di2aWPatks7WEBYECcvfXdHch7Ax0p0i7VxxXq8f6BMWEe7YxeBcOEACgeSIqgY0AmHt+g==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM9PR04MB8859.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 05:54:35 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 05:54:35 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH RESEND v4 net-next 13/14] net: enetc: use
 alloc_etherdev_mqs() to create netdev for VF driver
Thread-Topic: [PATCH RESEND v4 net-next 13/14] net: enetc: use
 alloc_etherdev_mqs() to create netdev for VF driver
Thread-Index: AQHdF+1U0b1XT98MNEmlt9MrKMcSSLZ3PTKAgAA9wCA=
Date: Tue, 21 Jul 2026 05:54:34 +0000
Message-ID:
 <GV2PR04MB11739309B2D03F3C910C377C788C22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-14-wei.fang@oss.nxp.com>
 <20260721021332.C1B431F000E9@smtp.kernel.org>
In-Reply-To: <20260721021332.C1B431F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM9PR04MB8859:EE_
x-ms-office365-filtering-correlation-id: 8042624c-0c65-4f32-d4b2-08dee6ec8ae4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 7Uh2NrO793w3otfyNntePeTJpKvXobJyaojPHVBS2+BTonPUmegl0YfTO9h0eZhMHiKFhbGg7UlytdIWS56tD7G/0NITOc+Jbci+P2sUw3gNUiTswwjfGB4aUxt6qNmcpN1KUWfToEu0R+gbgJrBm2LH/VFXZept09EVKDPxNMG1tqSKiSc2p0eszp+OEcoRh0Pw7lI0mum/SxyGiTNOdd0dCvEKwBVLQVQ7NKgy0rwPDEJXs/0qCQQd8VP67xTR9pqsgc7xJBn0QjBeoskI2txFwO9Jty0z8biMyq0tPhF9sUfaCNcKzrbdHazdmutO/VNcYHwuT6g9yweKiVJcwQqFp9Bdbz28tN4sT0KnWbW4dxWB6HcDUsk+tz8iSTI8PCmkxePeUORWq6RQOFT/I95evkZeftFd52halHC0qeKz/lBp9C7Q1JXMHwgRjH1CXARobF6LFMvgD7mwa348EpyNvEsOpSFy6kDSv7bH81My4BaroVPOm/2fMvkM94jb8Z9kBH3GrJW0P6tYzq9ciyUFPVE6jQefHzgHk7O9OPhIfIozKoLgf6wvXVze098FerytnICLMisVHvge0U50bYGmNiU2LtsuWux4wYFBhB9NiOhxPHvy8QNyQ6xNaJJ61VcojkKKyZRjVhR0OWC7OWvlBLFSUOH2Bt0iNCbD6c+EOIBE/pLhUf8nbqTlCYiVJ5F3WGNE+DMsu/Lc630lnA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXA0T0NKOTU0V09ud3d5ekhQaU45MTBFQzB4L0R0YUFjZ1k0d21OVnNEbzI3?=
 =?utf-8?B?RnVPa2lBTHp1a2NyMzhycWNONTZVM3ArWU9jWnBKamJXd0VGMWNSdFN2Ukp5?=
 =?utf-8?B?WUNnK1JwdXlrWXN0VmlYc2hVVkVqcVREM05kbjl2UU9uVld2TEdlME1vYVJi?=
 =?utf-8?B?OE13WlVGQi9kbWdrVVIzUHA2UmZsWDJOT2lYUWVsUTlnMzMwcUw0QitROFd6?=
 =?utf-8?B?dlZqK0R4K3NKSkJ0TjQvOHBLUHkreFVHN2tFYTdUSUtaWlUwZ2JSZjFwYVJO?=
 =?utf-8?B?YUx4UUk1UlpvYi9xYml2alJEZk8zdDlURjF0dnhPdHN0UDlvaGQ0Um15cXBa?=
 =?utf-8?B?bFMrWDlTUzN0b0ZXN1NseXVHK2t3VjRoUXlyKy9xTVNwNEd1T3dxNGErMCtl?=
 =?utf-8?B?YVN2ODkvWk5zeWVwQnFNZWhCbkxNdHpoZWg2MDgyM0d1WmhZR0xDTmpQb2N0?=
 =?utf-8?B?dStQWXFuZXkyVGRhYjZoazNvb3Z5YWpYK3JUNkRzNlNZSzk2TXNwbm8rNWR4?=
 =?utf-8?B?VExNVmRvUW9nNUJORERrOWQ2ZmYxVmtDdXYxOWRJRytvTnZ3anBCaU8vZWh6?=
 =?utf-8?B?S1p6Ry9wZWZMa3dNdDBTSXpVVnB4WTJtY1ZFUm5MNGtPVC9FaHloc1ZEbUhF?=
 =?utf-8?B?YitUR3Z2Tm93Qzl0N0Z3Z1FoU25XT0dMbzh3QXduTW1OZHpHYVBiRHdQNmtz?=
 =?utf-8?B?WXd0RnhzOUpPUEJza1JGYlJ3UkNXM2JkSUw5SkprS2duSHBSRlphSWdsb1VB?=
 =?utf-8?B?RFFueFJwZFFsbDExK2pBaTY5eHB6MnN4d0ZXMy9TUmo0TkFENEYwYWJkaHhR?=
 =?utf-8?B?L01mUE1UendNdkw0THp3cUd3dlBWNFpwMUlScWxIVWkrNkUwWTBmWGx4QnpO?=
 =?utf-8?B?R0JsQkNQZHRKQnZKVnRYUTJ2bkZNYk05Z25LNjlLajhTQ2p5VEU5WVRlZnR4?=
 =?utf-8?B?NEJYS3FoZjlBdFBFZGJJNDdhdm5nMm1heWZSdVFxZXV1eTYyWlRvQXlEdVk4?=
 =?utf-8?B?L1hCeklZeWx1dzBYcFROMHprVUVYSVlqNGNGYkYyWWFaZkN2NmNHVW02OUlD?=
 =?utf-8?B?OEtrdWVDQUZTQVdyTGlhMlV3SkVoKzlsYzF0V3pmWVduWitHT0VEYUpJMHA3?=
 =?utf-8?B?UHNZd2x4KzhSZ1hqdEtMeHl5VkdlNHovWThTNTdzTEN1dVhCUS9LUG4xYWl1?=
 =?utf-8?B?TlVTOWx6cktmSVY4K0tQUEJaazBWeU5OZWpNcENlZXRiMFlKcFovNVdWWTYx?=
 =?utf-8?B?RzNnZjFuR3ZPNHVNTGw5NXZLeVBhbFpUSDBFc1JqT2VSSE1HTnJvZWJ6Z2hK?=
 =?utf-8?B?RTNBSm4yT2Z0ZURIVlJSVUdkNGxGNE5wYnJMbmxISzBoZHlZbjl1MmJaWkhV?=
 =?utf-8?B?RWtTc2RWU2hvK203dTRwM3JCMk9BMnYwV3Z6dW9YZTE4Y1ByRTJubWFwYzBx?=
 =?utf-8?B?QllXbnUzdnFZYlhINlg2T3A0TVN5d0svdW4zbFZBemcvUm9MSHpsYWFuY0sv?=
 =?utf-8?B?a1ZBNHJpL2lRZm41b085VGJ6SFlWSHY5dVFQNUlFRDBOSGx2bE13VExIMzM5?=
 =?utf-8?B?a25DN1V1SWFmZmtrTW0yOGtnalcwSytrQ0FuKzBhYnQzZ1o5dUFqU0syckY0?=
 =?utf-8?B?b3NNWXRqSmRWRlhoc2xvb2V1K2hsbTZsdVUwWkhEYkhmckxnM2pTVW5Dc1Vw?=
 =?utf-8?B?MnFGdzRhMUV2T1kyTmt6TjhMZWp5RlQ3ZU1hdy9vbkthNmd4eTUzWGZHTGFD?=
 =?utf-8?B?Y3FmWTdZOEkyOE11OFdJd3pTbmJzZW54eldqdFlYYU5SQmtNbkEyZ1ZBZWkv?=
 =?utf-8?B?MDhubjBUNEpYTWpIbmFtTHBSTnRMMkZvdm8wNjZXZFZKU2sxUTg0OWxaVTQw?=
 =?utf-8?B?bWhYeTZaa0M2NDlpL3MyOU5rMGV5bkhSTEltWmNKdy9zLzY1MExFMEl0QVc3?=
 =?utf-8?B?WDZ3ZHIzb2draStQYUFJRFNBd2FOK25KUWhGTzVqUjVpMGJjditjR3ltKzIz?=
 =?utf-8?B?L3lzemNYTURNVVBBTkZ0bFVDRmFleFF3dnUvR20vYmI3alFLenJaeEVyQTVW?=
 =?utf-8?B?YThZSXFVNkRzSk1EdENWKzNRSHBtcXNkS1hEdVVxNUNZaVJpNDlKdVhqQXgw?=
 =?utf-8?B?ZFlOdUxueXpvRmEwZDZIYzJWNGJvL2VrcUhyemtQNitJd1hUazB6SUsrUkpw?=
 =?utf-8?B?dGhlc3ZuYTg5eFNET2FXSHlwM1BGY3Z6bXBST2graVZsUWtLRjlLSVlBU004?=
 =?utf-8?B?QVhodXJrdGVjcHJJRURtRWRjYkJscVFaTytEVVBHVmE5VTIrSEVScEMxSDhm?=
 =?utf-8?Q?9gFiCjTunJM85hcgZe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8042624c-0c65-4f32-d4b2-08dee6ec8ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 05:54:34.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kMv1dgrWZp3DXx2Zum9iYewFiXnWVSh3vpiz3g+JxDUPQYpjcnUwy0CjE3AoNu+5Dn4GpMabM94AZYsX84jNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859

PiA+IC0JbmRldiA9IGFsbG9jX2V0aGVyZGV2X21xKHNpemVvZigqcHJpdiksIEVORVRDX01BWF9O
VU1fVFhRUyk7DQo+ID4gKwkvKiBDdXJyZW50bHksIHRoZSBzdXBwb3J0ZWQgU29DcyBoYXZlIGEg
bWF4IG9mIDYgQ1BVcyBhbmQgdGhlIFZGcw0KPiA+ICsJICogaGF2ZSBsZXNzIHRoYW4gNiBSWC9U
WCByaW5ncy4gU28gbm8gaXNzdWVzIGZvciB0aGVzZSBzdXBwb3J0ZWQNCj4gPiArCSAqIFNvQ3Ms
IGJ1dCBmb3IgZnV0dXJlIFNvQ3Mgd2hpY2ggaGF2ZSBtb3JlIENQVXMgb3IgbW9yZSBUWC9SWA0K
PiA+ICsJICogcmluZ3MsIGFsbCB0aGUgcmVsYXRlZCBsb2dpYyBuZWVkcyB0byBiZSBpbXByb3Zl
ZC4NCj4gPiArCSAqLw0KPiA+ICsJbmRldiA9IGFsbG9jX2V0aGVyZGV2X21xcyhzaXplb2YoKnBy
aXYpLA0KPiA+ICsJCQkJICBtaW4oc2ktPm51bV90eF9yaW5ncywgRU5FVENfTUFYX05VTV9UWFFT
KSwNCj4gPiArCQkJCSAgbWluKHNpLT5udW1fcnhfcmluZ3MsIEVORVRDX01BWF9OVU1fVFhRUykp
Ow0KPiANCj4gW1NldmVyaXR5OiBMb3ddDQo+IERvZXMgdGhpcyBjb2RlIGhhbmRsZSB0aGUgY2Fz
ZSB3aGVyZSB0aGUgaGFyZHdhcmUgcmVwb3J0cyAwIHJpbmdzPw0KPiANCg0KVGhlIG51bWJlciBv
ZiByaW5ncyBjYW5ub3QgYmUgemVybzsgaWYgaXQgaXMsIHRoZW4gaXQncyBhIHNldmVyZSBidWcu
DQoNCj4gSWYgc2ktPm51bV90eF9yaW5ncyBvciBzaS0+bnVtX3J4X3JpbmdzIGlzIDAsIHRoaXMg
cGFzc2VzIDAgdG8NCj4gYWxsb2NfZXRoZXJkZXZfbXFzKCksIHdoaWNoIHRyaWdnZXJzIGEgIlVu
YWJsZSB0byBhbGxvY2F0ZSBkZXZpY2Ugd2l0aCB6ZXJvDQo+IHF1ZXVlcyIgcHJfZXJyKCkgaW4g
dGhlIG5ldHdvcmsgY29yZSBhbmQgcmV0dXJucyBOVUxMLiBUaGUgcHJldmlvdXMgaGFyZGNvZGVk
DQo+IEVORVRDX01BWF9OVU1fVFhRUyBndWFyYW50ZWVkIGEgdmFsaWQgY291bnQuDQo+IA0KPiBT
aG91bGQgdGhlcmUgYmUgYSBjaGVjayB0byBlbnN1cmUgdGhlIHJpbmcgY291bnRzIGFyZSBhdCBs
ZWFzdCAxPw0KDQo=
