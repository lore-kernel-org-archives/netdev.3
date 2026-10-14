Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022109.outbound.protection.outlook.com [40.107.75.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06B3612F3;
	Wed, 14 Oct 2026 02:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946186; cv=fail; b=mtg/QsHZG/kHnhEapMAJlvE0X2t2r+c2wohrsywwmw6zBI7Hf7tY0zAe7PCRzCCOlHqYj0Ejtnw/EklokXNfY+UAz4DEJkkbqCT6nq/fKxGpnsZaql6wGf7g6e849muH1EQkQCAnrfQunL8rzhwuD/onlABamS57OHUSBmDZTZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946186; c=relaxed/simple;
	bh=ksdUvzbAvkGQAIQ+wJMEE7esVTjOb6i1REabqcesiP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vbo9gRvDif5ZsAOLOKJmCIhv8qZu4gyiOtRfPi/EWJnepLMYFvbcyx1NMl1ulwjyBsD36adYKBEGQSC9HDfeQPULmyT09ic4d/1uUzE4F2IHARV5lEow7e84zVLNupltgXhM2JmVdBj1uNV59CsTftLMTse3MYwWx+AZ02/FstE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LPe0s8jO; arc=fail smtp.client-ip=40.107.75.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LPe0s8jO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKEkQOAUmf4Bc+KShMlkaHhmiobmg/go7XSEHyINeIxgGa+M4TxhSDcWBC0VJlqiQKLfnGEIA0PneUW0BKy0I2BKvk8ZAuZjxV8grkLISgnbXMv/s2AvxhP4V2bq0/xaKyBI9R78tu4fWqq/4OQoczQxWhScGy7/oTeO4IADz41fHSRAAmPFWldMnsAw5O+lOD22siEJng0o9DqUsxgTRBTmEObGmbG7qqNwqrm+0p4KuwSxn6WJLpGY6/XZ2JffFXVZp1tr20xCwEHFY5IykuN9HRKpHv40F0tMWpCnEuOYqXbODdU/U4PfNCfGtYkGR2sO50LHfdiUz9lFJcNqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksdUvzbAvkGQAIQ+wJMEE7esVTjOb6i1REabqcesiP8=;
 b=f79jgTQqWDsJA6xV3yleVkgEkoE8+J+lpvkzHmP7nOOm68TUua//QyJSOq3wXAQW/H8hU/AGWhz3oYCsFBpCsklkM2FUBFSAhNCGRNHve6xcLzn931dR88rJOL0zM+7gy474HuablWR7j3e6+APeVC3b6UHC9nF4SkFg69wgBkTUYPygjpzMfTQOfdyiVzMAzGGFeVST5APVbEAsbMdBXahZ9S23rSCZwTV9z+t6d9RWsccKg1KMsrql7PQS6uBLj9uAqMOiYG13HXbUCxsr/LcKLo7orLztaF8xaseVXzLirgIPGSq+jL3wi2RpPn2wD7E6eGSm4usfep11xe039w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksdUvzbAvkGQAIQ+wJMEE7esVTjOb6i1REabqcesiP8=;
 b=LPe0s8jOt3RVfx23P3v0UvuNQX8zOp4Se65Ih9TPSpdw0yweqDknrTZAceIuXVeqqarRNKKDqj9x+qTC6UDtEXgvyAZ4XpKFG/vrlz4cjuKIorZMfZ/VHYgS93bQzFswCSFEA9XtZ4/I7KD1mZc9mIIkx1/yEz/L6ubWQ7xdlyplX/Ya+YTQbonCDt3SaJViNabxLkDO/VrwU7exbQK/q7TVjfv1u3Oktu978pqVAu3KAU5cZqDa9MHFbhgyMlCrZj4XpXsKNnm9IywstVTYXwDPx1BD44MJMln4FIHe95PlvzF47c7gk4I5QNMaWMMjpjpQUUiG0NfeJ69qqnLEng==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYPPR06MB8304.apcprd06.prod.outlook.com (2603:1096:405:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 02:49:38 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 02:49:37 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDEvNl0gZHQtYmluZGluZ3M6?=
 =?big5?Q?_net:_ftgmac100:_Add_AST2700_compatible?=
Thread-Topic:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDEvNl0gZHQtYmluZGluZ3M6IG5ldDog?=
 =?big5?Q?ftgmac100:_Add_AST2700_compatible?=
Thread-Index: AQHdVWM2owd1VMPC/Ei4XAumWNgo4rb2b4oAgAPRq4CAALb8gIAAuyyAgACimbA=
Date: Wed, 14 Oct 2026 02:49:37 +0000
Message-ID:
 <SEYPR06MB513411BA847E7973291259959D9D2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
 <179161911824.434549.4075299707625994950@kernel.org>
 <20261012-aide-wimp-4edf96aaca1d@spud>
 <SEYPR06MB51346A6CB5D7D7FC6D3FC4DD9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261013-subwoofer-zestfully-fe98c6158ba9@spud>
In-Reply-To: <20261013-subwoofer-zestfully-fe98c6158ba9@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYPPR06MB8304:EE_
x-ms-office365-filtering-correlation-id: 53d290b6-6824-4f38-5c5a-08df299dc92e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|18002099003|22082099003|3023799007|38070700021|5023799004|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 gU2HNGw1gfJ+8jXsw+RBSeS2mtLb+Z5PP36WHJkpe9xNk+QiTLd15sa89YntjXPjK9a9/M0T5PuZth7ifmo/es5KqOkR43s54+2IQTFNseZewH2w2yFSfLzVxfbkUkAHiK1aRzZwr8WzjZZvaeDSAvkvHVN0a2TpahP9YzDyIRynt8BeW7CNygyxtFyAeLIhRmDoglhPO3lM27W6+Plh/9XVSjb+GVEFx+Klh96lyKzNWh42zHT6dYGtDFvfv9m0ARWxaTRNKs2yLO89J/lhp/0YCzvhaCeZc+UwomxWsRBwMDm0ZYFqIXaeurijAQ/WvoSTAslwoDn0AugrM8mGin4t9BZhtx5vxt0vA6IwH+shKSgtqZgRXQDplYpSIbowfGbHToLWMuSPPyrbu5I2iUNN4ZNF/Y50lhnO+bMGdWXyPTSL5uosioBJzjhcAF8ZCuLwJtNfBNeSLz5sCx6LkV/sgY6mMkLAj/WsrCIkqgR2ex1YYEzaPb+Ybu3vM6aJPZIFbJeXcTf2lKtQ+BASXD0VNcPiq6ucCnYpS2U+L5IZEGNiP0krQLz6HuvIfnhCD11DeYnKOzp8ULzEZurbVmdwj3YdkySzmLqt4ZimvQSshVI38wxWgT9DcMcUJJSHWpSYfmX32FzG8B69F2GXYQZlEgVFlvZwKNOs2j0uKn/+wPXC5X6ha7R46DfK+/PMuDneuibUh0JCp4yWD9HzMBmM27yz4RIAMCTzCYPOrxw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(18002099003)(22082099003)(3023799007)(38070700021)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?NTdsZDQ0NXFxeVZKNVFkSGZIN1lXZzh4Smk2cU9NalFWd0hHdng0eFFVU00wYytQ?=
 =?big5?B?SWpCem5ocWRvRmJrVDhFQVVKcVNlUjl4aG5aajFtcUJjMVpxcm1zMFd5elNOZUdF?=
 =?big5?B?OUpDTDhRSDI0OEpkb1BEK0lHZVlCNXJ4Wmx3REEwTUcwRU1MN2txRnE3WWEyc2sr?=
 =?big5?B?bnNEd0lza0pMRXRsRGpETWJLZGIvdzZBREJPMUZ1YVNiTTBjcEE3N1lHWXF1R3Ez?=
 =?big5?B?TThYZ2xqQzQ0M0V5TVVpVmNNSkcyampxNWg1NU1kNFhteDNNSXVvRjdkbmdiVUNh?=
 =?big5?B?S3MvUEl4V0d6MU9WdTFTV0JOVkJ4QzdFUXN4UFpkd2ExSlh1RXFtcnpXL2xkellI?=
 =?big5?B?WjFZNkZkSnhROEhJOEVRcGFGRVVwWVhoUE16ZXNORk1VbTRXYU0xT3hIRnAxRGNJ?=
 =?big5?B?WmJHRUcvcDVBanY4VTZsZXVpSjdFS2J6YmtMR0FuZXRIM0hMaG1haFlOYVQzRHlT?=
 =?big5?B?cDNMZ3BXbGtuanE1WEhJTmlVK0JtTjdRYVF5aTQ1QlFPQWN2MjlqVzk5dzNLTTIx?=
 =?big5?B?d0Zab3NpWE8rTENUbzErRVlCZGo3ZGR6T2FoNmdjTngxNkZGVm5jZGxabkJjS2g1?=
 =?big5?B?KzBEMFdveXdoRFNyYnR5SVM4Z3kxYTdVVVFpRVRHRytNbVoxa1dNZ3FiaUwwbE8v?=
 =?big5?B?Ulc3TnV1K3JCM0QrVk4vaEtQQ1FFak9oeitmRVM4Q0s1WDQ5Z2pnVkl3QkFZdEE1?=
 =?big5?B?WVMyczJyZ1BVRENVZStpbHVsVVluNTJVNXc2TUx1TmRpN3BlQzNVdUl2anNnaHh4?=
 =?big5?B?OURuc1RKdUJJRERGZlJmWmZUT0x0US91YVRwaElHdlZtOXowWmpYOUZuaE1hbVcw?=
 =?big5?B?Ri9jbmQ1Y2xmK0lzZFJyNytwc1U0ci9SdFA1SVBmYWJPZWxvNDBPZlJyaC9sZk1M?=
 =?big5?B?NktDdzQ3eS8vdml5dUF0djBYbFFONmZSQnQvS1RLdHRxbnR4MDJ6V09TdEQxR1RS?=
 =?big5?B?cjB4dXJ1bFE4Y3RRU2hnZVBYSllWVzZEWEpsb3gzVzJjVDNqd0dvam40ZkxiOS9R?=
 =?big5?B?bGROOWNUT3JUczdCc2xKT0YyWG1FcnV3SVhuQjRZUG53emV0bmdEYk1YMEVWazBV?=
 =?big5?B?NkFUWEdRTkVKRC9wYzVjVW9GT1doMUdHbDNHa3l1MkRpd3AvaGZuOGVCZGJGZXpS?=
 =?big5?B?cmRvY1lGKzBManM3bGpmbmR4ZDBhWGoxaVdPWHcralFtK2F5YmRVRVJZemQxZlFu?=
 =?big5?B?Tzl2Si9IZDFtZGhSR09ZNnJ1TmNrOEIxWUYvQnJRNlJFT2pHYlQ0dm1oTzJUZGlR?=
 =?big5?B?ZTNNZnJveVhaNi9lMk5NUnBNcURjdFRhWSs5TzVLcnBMem9tWUNwWEZZSnpmdmJ0?=
 =?big5?B?N3NxUkc4VmNFRHlxc1NFNGNjQ1hvRjZpU0xzV3VjdXZLQzB4bHNIKy96R2VnV04w?=
 =?big5?B?aEgvanFlbzJIL0NFN3M0VGxLYmhYZWVuZ1Fac0dsVUQzeXQ1SHZwSFBtaTBhSHM0?=
 =?big5?B?UTRYVzhYZm42OEV5bFBMWVZoVkZFaEZMdS9PekN4c3ZKSVdNS3cxT1k1VEh1OS9X?=
 =?big5?B?Vmo4SHZGQ1dvOXhQdWhHV2JJZ3duVVNieWlPMGRSTThwZ0huS2FQM3hIYmVlNUlP?=
 =?big5?B?VUM3TlFDSlpuQ3IwYTVTR0pWZ0ZEdE0zZFAzdFVkWEtWcFBMa2JwQWtPamhNeitM?=
 =?big5?B?MUxQK21kVS9NNFZ5QklkYnp4YTNCMzdrUldLNjR5UVNJNklwMzRCY3pZWlgvcHh0?=
 =?big5?B?RVBJUGJxWW1jY3ZRWHRjM1dRUDZjajhEb2RKNERIenY3WDVDVk1oOTV1TGlaRm5h?=
 =?big5?B?cG5DZ3l3aS92UDA0YXNFYzZsMEtTenVXNEc4bWRwUW5qeDZYYkRSMDYyMC9DcTdh?=
 =?big5?B?SUxhaEF6UGJJUk1vdkVzZ2Z1Vzk4S2x1dmRtUmNpUWxUckxTK1o1bURBQkZKeUxS?=
 =?big5?B?RjR6RUJhOU4xSU1yWFI0cm9xK2dxZXU5NW9rL1NPRXU1WlcwbkhTRXRUbmp4dzYy?=
 =?big5?B?c0drdldnNUhWU3ByR1JNL0hTWi91VWZKVmpqUUZEYnBjQmU0NCtlazU4RFRBeENh?=
 =?big5?B?L1dGcUlXckd3aEFWYU5YUElTcXZ3TUU1KzN0YU56bDFHcEl4V1hRQzBDUkdsR2V1?=
 =?big5?B?RWpvSk56QnRBYXFXSGlSYXFUcWhtdVZFcnRqdWVDcDhtcjRnZC9PdlAxOTI5Z3RH?=
 =?big5?B?ZHZ1NVYyUC9CVmtvMnhKS1U2MjVGRUQ4OE5leFNqdHJGNGJFdmlTQjdLKytnemcx?=
 =?big5?B?UEQzLzJmTHdsS1laTUxLcDh3UTMwQT09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	5sg4ke/r1jT3OGPJaQyLk3nC/56aUGTOlKZFBgRtvFrSlCcBuY8sN/fsXWkUCd3CQavn6a8KhKNPN8vXw3vHeW3ZNh0+JuRSBC77+TuFKkqdmhYCXMOqulFFJoAC1fvA4XuhEOufRG/tHPUXVcDXzwkox8/Ss8X9bVAPQnFa7aP3XHktSrF8F9Ljf9K5tVRejvpyvKOLszRXvn1gxVCqYoZDf2tMRrRj3Pw03Qk8a1KMgRJf9KDQOj0i0hCGBZgfoYZZt4LLW4QRmL+4VcdiSHiJaBjbWlEmTb8zx1aExkLI5ht+rao/IfaGZ+uKy3TkZWrJtxr+iBt5AE6EsMlAXg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d290b6-6824-4f38-5c5a-08df299dc92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 02:49:37.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4FluJxWXjrdq3haw5lpRVDDm17dbiqVsYwz0bOQ3A4vMEMDudZwqGE4hpMRdZmaZAwj2LhmO+06ZnKaTBVyPmdoSvGu8dmsZFjsvuThlvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8304

PiA+ID4gPiA+IEBAIC0xOCw2ICsxOCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgLSBhc3BlZWQsYXN0MjQwMC1tYWMNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAt
IGFzcGVlZCxhc3QyNTAwLW1hYw0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgIC0gYXNwZWVkLGFz
dDI2MDAtbWFjDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjcwMC1tYWMN
Cj4gPiA+ID4gPiAgICAgICAgICAgIC0gY29uc3Q6IGZhcmFkYXksZnRnbWFjMTAwDQo+ID4gPiA+
DQo+ID4gPiA+IFtTZXZlcml0eTogTG93XQ0KPiA+ID4gPiBXaXRoIHRoaXMgcGF0Y2gsICJhc3Bl
ZWQsYXN0MjcwMC1tYWMiLCAiZmFyYWRheSxmdGdtYWMxMDAiIGJlY29tZXMNCj4gPiA+ID4gYSB2
YWxpZCBjb21wYXRpYmxlIHBhaXIuIEhvd2V2ZXIsIGF0IHRoaXMgY29tbWl0LA0KPiA+ID4gPiBm
dGdtYWMxMDBfb2ZfbWF0Y2hbXSBpbiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21h
YzEwMC5jDQo+ID4gPiA+IGhhcyBubyBhc3BlZWQsYXN0MjcwMC1tYWMNCj4gPiA+IGVudHJ5Lg0K
PiA+ID4gPiBTdWNoIGEgbm9kZSBjb3VsZCBvbmx5IGJpbmQgdGhyb3VnaCB0aGUgZ2VuZXJpYyBm
YXJhZGF5LGZ0Z21hYzEwMA0KPiA+ID4gPiBlbnRyeSAoRlRHTUFDMTAwX0ZBUkFEQVkpLg0KPiA+
ID4gPg0KPiA+ID4gPiBPbiB0aGF0IHBhdGgsIGZ0Z21hYzEwMF9wcm9iZSgpIHdvdWxkIGRvIHRo
ZSBmb2xsb3dpbmc6DQo+ID4gPiA+DQo+ID4gPiA+ICAgLSBwcm9ncmFtIHRoZSByaW5nLWVuZCBi
aXRzIGF0IEJJVCgxNSkgaW5zdGVhZCBvZiB0aGUgQXNwZWVkIEJJVCgzMCkNCj4gPiA+ID4gICAt
IGxlYXZlIGlzX2FzcGVlZCBmYWxzZSwgc28gZnRnbWFjMTAwX3NldHVwX2NsaygpIG5ldmVyIGNs
YWltcw0KPiA+ID4gPiAgICAgTUFDQ0xLL1JDTEsNCj4gPiA+ID4gICAtIHJlZ2lzdGVyIHRoZSBl
bWJlZGRlZCBNRElPIGJ1cyB0aHJvdWdoIGZ0Z21hYzEwMF9zZXR1cF9tZGlvKCkNCj4gPiA+ID4g
ICAtIG5ldmVyIHNldCBhIERNQSBtYXNrIHdpZGVyIHRoYW4gMzIgYml0cw0KPiA+ID4gPg0KPiA+
ID4gPiBXb3VsZCBhbiBBU1QyNzAwIG5vZGUgd29yayBjb3JyZWN0bHkgaWYgaXQgZmVsbCBiYWNr
IHRvIHRoZQ0KPiA+ID4gPiBGYXJhZGF5IG1hdGNoPw0KPiA+ID4NCj4gPiA+IFNvdW5kcyBsaWtl
IG5vLCBjYW4gdGhlIHN1Ym1pdHRlciBwbGVhc2UgY2xhcmlmeSBpZiB0aGUgZmFsbGJhY2sgaXMg
dmFsaWQ/DQo+ID4gPg0KPiA+DQo+ID4gQWdyZWVkLiBJIHRoaW5rIHRoZSAnYXNwZWVkLGFzdDI3
MDAtbWFjJyBzaG91bGQgbm90IGJlIGJhc2VkIG9uIHRoZQ0KPiAnZmFyYWRheSxmdGdtYWMxMDAn
Lg0KPiA+IE1heWJlIHRoZSBkdC1iaW5kaW5ncyBwdXQgYXN0MjcwMC1tYWMgYXMgYSBjb25zdCBs
aWtlOg0KPiA+IGBgYA0KPiA+IC4uLg0KPiA+IHByb3BlcnRpZXM6DQo+ID4gICBjb21wYXRpYmxl
Og0KPiA+ICAgICBvbmVPZjoNCj4gPiAgICAgICAtIGNvbnN0OiBmYXJhZGF5LGZ0Z21hYzEwMA0K
PiA+ICAgICAgIC0gY29uc3Q6IGFzcGVlZCxhc3QyNzAwLW1hYyAgICAgICAgICAgICAvLyBhcyBh
IGNvbnN0DQo+ID4gICAgICAgLSBpdGVtczoNCj4gPiAgICAgICAgICAgLSBlbnVtOg0KPiA+ICAg
ICAgICAgICAgICAgLSBhc3BlZWQsYXN0MjQwMC1tYWMNCj4gPiAgICAgICAgICAgICAgIC0gYXNw
ZWVkLGFzdDI1MDAtbWFjDQo+ID4gICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1hYw0K
PiA+ICAgICAgICAgICAtIGNvbnN0OiBmYXJhZGF5LGZ0Z21hYzEwMA0KPiANCj4gTG9va3MgZ29v
ZC4gSSBhbSBjdXJpb3VzIHdoZXRoZXIgdGhlIGV4aXN0aW5nIGZhbGxiYWNrcyB1c2VkIHdpdGgg
b3RoZXIgYXNwZWVkDQo+IGRldmljZXMgYXJlIGFsc28gaW5hY2N1cmF0ZT8gQ291bGQgYmUgd29y
dGggbG9va2luZyBpbnRvPw0KDQpUaGFua3MgZm9yIGRpZ2dpbmcgaW50byB0aGlzIGZ1cnRoZXIu
DQoNCkkgd2VudCBiYWNrIHRvIHRoZSBjdXJyZW50IGRyaXZlciB0byBjb25maXJtIHRoZSBleGFj
dCBiaXQNCihkcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5L2Z0Z21hYzEwMC5jLCBmdGdtYWMx
MDBfcHJvYmUoKSk6DQoNCmlmIChwcml2LT5tYWNfaWQgPT0gRlRHTUFDMTAwX0FTVDI0MDAgfHwN
CiAgICBwcml2LT5tYWNfaWQgPT0gRlRHTUFDMTAwX0FTVDI1MDAgfHwNCiAgICBwcml2LT5tYWNf
aWQgPT0gRlRHTUFDMTAwX0FTVDI2MDAgfHwNCiAgICBwcml2LT5tYWNfaWQgPT0gRlRHTUFDMTAw
X0FTVDI3MDApIHsNCiAgICAgICAgcHJpdi0+cnhkZXMwX2Vkb3JyX21hc2sgPSBCSVQoMzApOw0K
ICAgICAgICBwcml2LT50eGRlczBfZWRvdHJfbWFzayA9IEJJVCgzMCk7DQogICAgICAgIHByaXYt
PmlzX2FzcGVlZCA9IHRydWU7DQp9IGVsc2Ugew0KICAgICAgICBwcml2LT5yeGRlczBfZWRvcnJf
bWFzayA9IEJJVCgxNSk7DQogICAgICAgIHByaXYtPnR4ZGVzMF9lZG90cl9tYXNrID0gQklUKDE1
KTsNCn0NCg0KU28gaXQncyBhY3R1YWxseSBCSVQoMzApIGZvciBhbGwgQXNwZWVkIHZhcmlhbnRz
IChBU1QyNDAwLzI1MDAvMjYwMC8yNzAwKSwgdnMNCkJJVCgxNSkgZm9yIHRoZSBwbGFpbiBGYXJh
ZGF5IElQIKFYIG5vdCBCSVQoMTYpLiBUaGUgY29uY2x1c2lvbiBzdGlsbCBob2xkcyBlaXRoZXIN
CndheTogbm9uZSBvZiB0aGUgQXNwZWVkIGNvbXBhdGlibGVzIGNhbiBzYWZlbHkgZmFsbCBiYWNr
IHRvIGZhcmFkYXksZnRnbWFjMTAwIGFsb25lLA0Kc2luY2UgdGhlIGRyaXZlciB3b3VsZCBtYXJr
IHRoZSB3cm9uZyBiaXQgYXMgZW5kLW9mLXJpbmcgaW4gcnhkZXMwLCBhbmQgdGhlIE1BQyB3b3Vs
ZA0Kd2FsayBwYXN0IHRoZSBlbmQgb2YgdGhlIFJYIGRlc2NyaXB0b3IgcmluZyBpbnN0ZWFkIG9m
IHdyYXBwaW5nLCBleGFjdGx5IGFzIHlvdQ0KZGVzY3JpYmVkLg0KDQpUaGF0IHNhaWQsIEkgZG9u
J3QgdGhpbmsgd2Ugc2hvdWxkIGV4dGVuZCB0aGUgc2FtZSBmaXggdG8gQVNUMjQwMC8yNTAwLzI2
MDAgaW4gdGhpcw0Kc2VyaWVzLiBBU1QyNzAwIGlzIGEgYnJhbmQtbmV3IGNvbXBhdGlibGUgd2l0
aCBubyBleGlzdGluZyBkZXZpY2V0cmVlIHVzaW5nIGl0LCBzbw0KbWFraW5nIGl0IGEgc3RhbmRh
bG9uZSBjb25zdCAoY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjcwMC1tYWMiIG9ubHkpIGhhcyB6
ZXJvDQptaWdyYXRpb24gY29zdC4NCg0KQVNUMjQwMC8yNTAwLzI2MDAgYXJlIGRpZmZlcmVudDog
ZXZlcnkgdXBzdHJlYW0gZGV2aWNldHJlZSBhbHJlYWR5IGRlY2xhcmVzIHRoZSBwYWlyLA0KZS5n
LiBhc3BlZWQtZzYuZHRzaToNCg0KY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1tYWMiLCAi
ZmFyYWRheSxmdGdtYWMxMDAiOw0KDQpJZiB3ZSB0dXJuIGFzcGVlZCxhc3QyNjAwLW1hYyAoZXRj
LikgaW50byBhIHN0YW5kYWxvbmUgY29uc3QgaW4gdGhlIG9uZU9mLCB0aGUNCnNjaGVtYSB3b3Vs
ZCBvbmx5IGFjY2VwdCBhIHNpbmdsZS1lbGVtZW50IGNvbXBhdGlibGUgYXJyYXksIHdoaWNoIHdv
dWxkIGJyZWFrDQptYWtlIGR0YnNfY2hlY2sgZm9yIGV2ZXJ5IGV4aXN0aW5nIEFTVDI0MDAvMjUw
MC8yNjAwIGJvYXJkIGRldmljZXRyZWUuIFdlJ2QgYWxzbyBuZWVkDQp0byBzdHJpcCB0aGUgZmFy
YWRheSxmdGdtYWMxMDAgZmFsbGJhY2sgZnJvbSBhc3BlZWQtZzQuZHRzaSwgYXNwZWVkLWc1LmR0
c2ksDQphc3BlZWQtZzYuZHRzaSAoYW5kIGFueXRoaW5nIGluaGVyaXRpbmcgZnJvbSB0aGVtKSCh
WCBhIG11Y2ggYmlnZ2VyLCB1bnJlbGF0ZWQgY2hhbmdlLg0KDQpJdCdzIGFsc28gbm90IGZpeGlu
ZyBhIGxpdmUgYnVnOiBmdGdtYWMxMDBfb2ZfbWF0Y2hbXSBvbmx5IGhhZCB0aGUgZ2VuZXJpYw0K
ZmFyYWRheSxmdGdtYWMxMDAgZW50cnkgdW50aWwgRmViIDIwMjYgKGNvbW1pdCAwM2EyYWJhNTBi
MmMpLCB3aGVuIHRoZQ0KQXNwZWVkLXNwZWNpZmljIG9mX2RldmljZV9pZCByb3dzIGZvciBBU1Qy
NDAwLzI1MDAvMjYwMCB3ZXJlIGFkZGVkIGFzIGEgcmVmYWN0b3IuDQpCZWZvcmUgdGhhdCwgdGhl
IGRyaXZlciBhbHdheXMgYm91bmQgdGhyb3VnaCB0aGUgZ2VuZXJpYyBmYWxsYmFjayBzdHJpbmcg
YW5kIHVzZWQNCm9mX2RldmljZV9pc19jb21wYXRpYmxlKCkgaW50ZXJuYWxseSBpbiBwcm9iZSgp
IHRvIHBpY2sgdGhlIHJpZ2h0IEVET1JSIGJpdCAvDQpjbG9ja3MgLyBNRElPLiBTbyB0aGVyZSdz
IG5ldmVyIGJlZW4gYSByZWFsIGtlcm5lbCArIGRldmljZXRyZWUgY29tYmluYXRpb24gd2hlcmUg
YW4NCkFTVDI0MDAvMjUwMC8yNjAwIG5vZGUgYm91bmQgdGhyb3VnaCB0aGUgZ2VuZXJpYyBlbnRy
eSBhbmQgZ290IHRoZSB3cm9uZyBFRE9SUiBiaXQgoVgNCnRoZSBwYWlyaW5nIGhhcyBiZWVuIHNh
ZmUgaW4gcHJhY3RpY2UuDQoNClNvIEknZCBzdWdnZXN0IGxlYXZpbmcgQVNUMjQwMC8yNTAwLzI2
MDAgYXMtaXMgKHBhaXJlZCB3aXRoIHRoZSBmYWxsYmFjaywgc2FtZSBhcw0KdG9kYXkpIGFuZCBr
ZWVwaW5nIHRoZSBzdGFuZGFsb25lLWNvbnN0IHRyZWF0bWVudCBzY29wZWQgdG8gQVNUMjcwMCBv
bmx5LCBzaW5jZSB0aGF0J3MNCnRoZSBvbmUgY2FzZSB3aGVyZSB0aGUgYmluZGluZyBhbmQgbWF0
Y2ggdGFibGUgZ2VudWluZWx5IGRpdmVyZ2UgcmlnaHQgbm93Lg0KDQpUaGFua3MsDQpKYWNreQ0K
DQo=
