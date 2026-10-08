Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022082.outbound.protection.outlook.com [40.107.75.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D001F936;
	Thu,  8 Oct 2026 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791436854; cv=fail; b=BBGK8Nb3ZV3oB8VYRVIQOH9j81IZJWtnxGVIANx9UUy4dLLGZ14VJKpxd+wOwaoom+7tDKfbg/tD32YjpDW8UfuG1ktGw2ziNNsUP+dxIF9AepSjZCyrkeaWK1sIIbB4g30Yktp9lRAFklcREE/SLio24ux9isBZYA9usSwkdVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791436854; c=relaxed/simple;
	bh=qT2n3TMtJT3HPG09oZ84gvbEZDAM/Z/9tiwEZ394bu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtoDpv1OHv9TVnlWBbnJ76s45cAFW7vTRuwJvRf1rCLUxWiv5Bej0H4l8fUfGrq8jwOAaSFBOCdglbKXIz879cEdFP0G3oBCNI1pCpKtRbDilrPPk7iI2IQVCBXhg7LY63MX89eFcGcAc6XfCQS+xHgCP5V58ovD61CzJ7XrdYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=nBwhEpIX; arc=fail smtp.client-ip=40.107.75.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="nBwhEpIX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlH3hPbVA3R3mXbFX6yjYUw5PAAVavT3i//XeExTSmfDy0R4ZAaVfyahWuKjusPhwsqO0wr1U1yhwQNvBbunLAJawBhy91zCv2YPgpvmQ31BqIbJZ4sEb/acppBcPuule/Uy73N2YTxFkH9xzWxV+6E5WTU1lu5UfTbafQzd4xa98NAafN3W4g1N7MwmH8BGr1t1WQqbYl/MJW1DJ3/vmnVc2hGN33WtGd1Nwdgbey9Ydrxaf3kTlswJW7GbCNlnDedIBWMO/oRiInZwDY3KfioTDmKfZVExtd1alvXJh8TGwzxV6a18/Ul6TZTmSBjVcadqIbSZFgVO2aGhCOg2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT2n3TMtJT3HPG09oZ84gvbEZDAM/Z/9tiwEZ394bu4=;
 b=Osz44wX/GwvMpiPmQ/Qxb683j2eRrU4jKYOKTzIpjJdhXHtEhuJFs+PSl8svPO0+J95MLCjeAnQ5JbEvjiofhIOh25AV09XxPg6BINuHXUaCTPSzC+KpHvypr7aUsDZKK98MnKCgCH2FeDtgnkzO2A6J1gtDrQ92b5OwzoYz1WjuHxAg0fKOOkFjYlDQyhig59RLFlhP4eLMAOTlta/3nYEq1ZoaZPsM4Il6wfgHHjxul6dxHQQAq2KYnyfm7sYjqvXfOF4mrNH2uxTcST06N1Nm7+RKGJwzmEfdhKNN2stZvetexqOf7q+V+F3pD1OcG9J6fk9i3IrcEu4e2Q1mXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT2n3TMtJT3HPG09oZ84gvbEZDAM/Z/9tiwEZ394bu4=;
 b=nBwhEpIXTvcMFh8GSiHgYSyfr6nVHGxTtJkP1CK4iZ1kl/7mM4/BnaZKk88GoxZv5ZsgB5EImyRJn2ubCK0CME59EnXdMhrH4t6QXwJ+uo9GAplZSYVhHjm0N5gfARb8demkpgEYNlhwl+WkVV+cL3zFEP2x8BZQvD4VREBdIOxAYTeiSYEqOKvofqx3ig/ntWF9a1R99AZUJ/49MQ/WuEB0tp6QncRURxR98q1hq2ncZD+sQzMrHGW5nL5uPGAEwfVv7JTrOBDxLBmobUXFCiNUl30dBjPmEXi1dX2dSbz1+BsQmqd2TmTDDjIV/FpptAni+VeoeixoIuOJWP+8qQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB6009.apcprd06.prod.outlook.com (2603:1096:101:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 05:20:43 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 05:20:43 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDQvNl0gbmV0OiBmdGdtYWMxMDA6IFJl?=
 =?big5?Q?quire_phy-mode_for_AST2700?=
Thread-Topic: [PATCH net-next v2 4/6] net: ftgmac100: Require phy-mode for
 AST2700
Thread-Index: AQHdVWM5bYMUFpry20C3vGyqJrP2N7bwsqUAgAJrvVA=
Date: Thu, 8 Oct 2026 05:20:43 +0000
Message-ID:
 <SEYPR06MB5134735A0D0D341F3BB0FE109D932@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-4-36de51fb8066@aspeedtech.com>
 <3e296889-3a08-4511-8a91-26e86a7ea500@lunn.ch>
In-Reply-To: <3e296889-3a08-4511-8a91-26e86a7ea500@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB6009:EE_
x-ms-office365-filtering-correlation-id: 35976f40-9fe9-4340-83ab-08df24fbe693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|4143699003|38070700021|56012099006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info:
 Sg0yxZCeshWBFZAKtgQg+sb7jb5An1gqG1IJghK7S4Ya4jELq2dguGvGuRCZIokeqHDFxlLPR1ACLkK7At7s/CK034x7koAQ70JmEjMomH4tAPOpvymFkmhl/IQ2T54rf2+AMCgFl9FIQeyw32xkH0qynwOiV87pOpizIa+stgpNBXc8COE9cZwKGmhzEe1qhbyyAioqqaC3kWJdw0Pzsm6AszF0l/8R/jbPc8b5xqQvs114+8KmWQmU3lCP0BbdefpSpLTufWiz9XYDUMikhFM//q4j/p2/FRbMdCUte7NqD885I+Msg0lDR7EOT6giJwYokr5QTxIv1hnxUxSEfR4feiBR21Mu5SltO+w5KAUmeix0yHxZF3zSx6SGcTqSt/dIrWh2ZTlPM+SL3StnCz1KEkm4GHV2gOTKyYjs7ulcFuHg8/V6+x7ji0PEKTmVy7rI8PFP8nI3yhMFBppq+3PTM0UyhuCpB22j3kbxr0p/Bv/eG3PQ17+pXw1vYKNhMt1RdXvK+P06w2JjMnW4EPjgYwavY6meXMJg3WiUO4Qvy1cO1QlUsmTxZS3cHubr1cYh0sdIFcNauM7h5r7i+23jGK+9YGRlJUiLlD8iCanOW8tMMbhjgzM8iHB2GzQ0ZhrOJCLmo2zgisk0xwNGd2CnuKHMFGmSjaUPbCBoLGOmDYUUdpo1Ce+CHZi1h50r2p7Wj/7tBGsOiaq7onoNvgWtr+p6VGtrCWC1COt3+OY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(4143699003)(38070700021)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?MTFCK1lLMFVtWVF5VGNyQklKb2J6TmdHYWxMaWRWTzZtZ3VGdVBFeHZiaWpkR2RX?=
 =?big5?B?Z24yQmJzRGh1dkdrbXdoSlhnRENNSk80eXZuTXVocEsvSGNwWWdZQ1JOamlwSmFG?=
 =?big5?B?YzNZZi85OVpKbjZnK1ZlNWgvK0kyU1dNbmdNOUtYZXo0MVVZUXdiK2xIaDNkcjVE?=
 =?big5?B?YlBNOWtSbHorU3F3NWhZU0d6N2tPdy9VeUVKWnNHOVM2QjNoMGwzaDRoTGFycFRj?=
 =?big5?B?L01DaFN2UkI3VTFyR0JoWFlsMUxiQjNwZlJDejBQOXBTWFREU1RldFdVc3VJd1A2?=
 =?big5?B?MDNiRlZwNGVHZ0ZCWlJlTE5OYWE1UTlyZW93OGp4b0tsNittVjMxZVZFQ2EzMjVQ?=
 =?big5?B?MGdoTWVIay9XUDZOWTdYUXZLZ1JSazVabGZTMXlJVFJhZjhiMXllTHp6dDFhT1Y3?=
 =?big5?B?QXNYWWt5cjBXYlZ1dkdLQ292WnBGaytmazZNOVowby9ERUt0eFJDOEVZanhON2dE?=
 =?big5?B?dUxDTXc1TUJCd1FPRzd5MytaVFpCZXFmbUhjMG5tRk5UQ0ZNZFI2N3RKeE9BS3lK?=
 =?big5?B?b0lZdmxXM0tMcGN5QVJOVlJqY0NRN2pmMlVpMTloOTB0Zjl0ODM3SVZLVmkxczVF?=
 =?big5?B?bllHQUxmSThPQndzMlBtazRLS3NOZU0xNkdoK1VVWmlidm9YaVlRbzFXbDJDRCtp?=
 =?big5?B?bzBKOW1Dc0xIQjI5d1FGQTdkdkVNZVg5Vk11RnVSQzVLUFVNWDRLOXUreEg2bGNw?=
 =?big5?B?ZTFpdTl0aW9icU82ek9mVkdhUmNObXNCTHVYRFhVd2RlY2M1TmhhSWFZWVpxNis2?=
 =?big5?B?dWlZRU1EbjVxY2lrSkVFMm5uQ2Jsb1BpRVdQSzBVdDBWTnk2VGJ2NS9lVjdsNVVx?=
 =?big5?B?Q1pQamtVRE9NYld3eHZualZQdHowd2FMK1B3cmk0VU53UU54WmxZV2pJY3A3T0Fx?=
 =?big5?B?LzdBeVBiMWo4SW1JZkVJUjhsd0YvSlF4TCs3YWVRdG1aQzRyVHZNSVo5R25JZWFB?=
 =?big5?B?NEpQMXJyMDV3M3dVR1ZPOXpUekZlblpDaXF1d3JWMmVZdDF4NEpueW40MXRlYkds?=
 =?big5?B?ajhCZFNBQXZBNkVJdWJPZkh3QTVGUmRVMnUxRExnVnZWeXFyOHR0bUxJNW9DY2tk?=
 =?big5?B?ZWF4Y211ZW5maUpGMXRKdjdham5ZQUZXQ0VoUDR6VkxuaGc3TzhHUml2cG56ZmpM?=
 =?big5?B?UzJOZXR0bFJxOWNiTmw3VVF4MWdIaVQ3R1pZSzBSMUlVeTZLc0tsU0F0VmdOTnZN?=
 =?big5?B?Vnp1VlhzaURhRENRMEUydXVTcXgySVlNaWVDcHNNc2hscTJRL0FpdVpKaFFNb2Iy?=
 =?big5?B?aGdwOXhYVzEzME9VWWUzeXBQczdQaUdqWG9JTFBBMzkrZTgyTEM4ZkdJUlJ0UGp2?=
 =?big5?B?RFVqRnFja1c0SEI3eXRuNEcvVDltdkJUamN6dStJd3k4N0RXNGdTWHYvWG93RzhO?=
 =?big5?B?aklHOHZDWk96UWtEdlpmcDM3V1UzTEluRjdjNHBHNVFiZWF2eVpMeFI3QkNzYUVO?=
 =?big5?B?YzRIb3RpYnczWTEyUE91Sml6NFFqM0o3MVhaVHlCa01WVURuMHhJUWFRZFNoY3dU?=
 =?big5?B?RGNSa0pFTDRUVm1LZmg0bzJBcC9OYk8ybnN4ME81cWM2aXJ4ZnArODk2ZVAvd1Bx?=
 =?big5?B?UWVlTUJiYjA5QTVkRTY5Y3NJSVQ1T0RNT21CU082UXlXb2pNNW5ISHUyczJ4cTBn?=
 =?big5?B?cnlERVpFVXpicDZxMHdTbXVyeHV6NE5RMlF4WUJVci9ST1JtYkRTdGw0T1FTSVlC?=
 =?big5?B?MnVUNE1GVkJIR1lVT2gzZzJlMzlCWmVDTXNjNk43R1lVdGdFWUcvVHhVQVltc3RT?=
 =?big5?B?V3RBNmdqSXZKcmNNbU11WFg2YktYZ2hSSnc4QWxmcGZ5cTdBSzN1YWUvN1dsazR2?=
 =?big5?B?Z0J5ZVNjT2xicW40YXJlVTF1NzJUR1hlZzJVSHJBQTNYMUdZVFNLZldueDhKNk5z?=
 =?big5?B?WEtCNllxWDgwY1V2UkNQSHV4WjM1bnRzYnYvUnNvK2hLZTdSNDdLalh4U3ZOQmE4?=
 =?big5?B?ZGJOLzh0endmb2FEQ3c4czF0Yy84eXVkUGJCNUtMNWpndEhrbEJMa3RmTmVkd2Y1?=
 =?big5?B?NjY1dWM2V2lqdVV5anBJMzBtbkg2aW5nbDNXejVGa25ZaitaK2hLdDBld2NlRDhY?=
 =?big5?B?NFNWSE5GTmZZZzVIdkRVLzZiRUZvYzVsd0dYWUQrSCtQVVdFbGhtamx0cFk1UTlj?=
 =?big5?B?ZEhicU1acU5aN1hkZXQ1SWlQRnNtck43MVNzWTdHQndJaGxrZUxWT2Q2Tm1uc0JN?=
 =?big5?B?UEF6d0ZMR3FkQ015bG9DeGxONi9EZz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EGLvxrXOU7syg1NH8rNSjUPpiZBvmV995Jh7b1KMDrsvyQR1PbCaGMWYlKKY7OLaw1v80Lxo8NiOkfyt3AY5qN/kqdpHVO6dc6Q3+SYeBwG63KOXrnNbMYWG2qsh06eTfTLjxiDnmERzuBE70/c76DQ1ad7SZdcCmKqzo8jZZer4Ue5/TOyL+k44v1wCj74AXqMQWw+Kh96vTqkXbYuFMYSjQ0DWKeGDWcsLLJEUxK3baM6QIg2v1P7DLmQPytoqLXGpkI/0HA3VeOr9WYhxNNgM9GqPjtdc9Ha00Za7HpUwKeqYfhA/q0zJExZ56jp7s2ZgnIC84Zep/1BVxEK+ng==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35976f40-9fe9-4340-83ab-08df24fbe693
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 05:20:43.3250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efkyPCuq6aDH89ksdDee44ss3/nO9XYy+JUXKVvLcKMlMwhV8bRhnh7Dyx/3Hoi/7E6Mrqcdrf6cOR1OGKfk7TnZiv6khWchFKrehzshHrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6009

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+ID4gVGhlIGRyaXZl
ciBjdXJyZW50bHkgZGVmYXVsdHMgdG8gUkdNSUkgd2hlbiB0aGUgInBoeS1tb2RlIiBwcm9wZXJ0
eSBpcw0KPiA+IG1pc3NpbmcgZnJvbSB0aGUgZGV2aWNlIHRyZWUuIFRoaXMgZGVmYXVsdCBpcyBu
byBsb25nZXIgdmFsaWQgZm9yDQo+ID4gQVNUMjcwMCwgd2hpY2ggYWxzbyBzdXBwb3J0cyBSTUlJ
IHZpYSBGVEdNQUMxMDBfUVVJUktfUk1JSV9FTkFCTEUuDQo+ID4NCj4gPiBNYWtlICJwaHktbW9k
ZSIgYSByZXF1aXJlZCBwcm9wZXJ0eSBmb3IgQVNUMjcwMCBhbmQgZmFpbCBwcm9iZSB3aXRoIGFu
DQo+ID4gZXJyb3IgbWVzc2FnZSBpZiBpdCBpcyBub3Qgc3BlY2lmaWVkLCBpbnN0ZWFkIG9mIHNp
bGVudGx5IGRlZmF1bHRpbmcNCj4gPiB0byBSR01JSS4NCj4gDQo+IFlvdSBuZWVkIHRvIHVwZGF0
ZSB0aGUgRFQgYmluZGluZywgbWFyayBpdCBhcyByZXF1aXJlZCBmb3IgYXN0MjcwMC4NCj4gDQoN
Ckkgd2lsbCB1cGRhdGUgdGhlIGR0LWJpbmRpbmcgcGF0Y2ggaW4gbmV4dCB2ZXJzaW9uLg0KDQpU
aGFua3MsDQpKYWNreQ0KDQo=
