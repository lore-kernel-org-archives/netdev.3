Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023125.outbound.protection.outlook.com [52.101.127.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3A3B9927;
	Thu,  8 Oct 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437968; cv=fail; b=hLYGScRp4nEU292r9cLmS5WNPYR1LawCvZqf6Bu95uRKvEZb/75sxrucL68Y9kv14Dh7CrIAq73meDtGIQJDu2hHAp0U+rHO2gnQMqTWbAYW7oEASMUytzVc4DFUtFHLmTH2NuaOgx3Lie3pcTlIEhqMkBc7+YHrBfCuosJOZbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437968; c=relaxed/simple;
	bh=0Ke0+h/o0EqlJBXTXVt2fTfK67CUCbTqJ3NNMilA7gI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nZQEjGoNaPdqM7eEu9b0gk7NjTChHRDOxZ9ljqehvbdAxj6saeO4Y9ZktEGMkDbkoiHCEMlkVIOw8L4ZaIGGgNdtDgHBAKDyFMpdTJwJryHIBphVryuvQGLbqGDRaW4JwKnYlRL2NeI2fci/yQLG3zDIkW7GjyBM98z+JUW1HeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=SJzLM+b3; arc=fail smtp.client-ip=52.101.127.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="SJzLM+b3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr7vbASlVw+GzXp+iLUOSdhYiAt7v3y+Zz2OXNUv2qpa2fNOGFM0QDVOuka/zgl7cqvOvOUIdvREeDKaB4REJ+kSvcUhw3Dt6PeTse5+pWLEgHrVcqbmHSOO/+OhKXTq0CMg6JEi/U2yF77Fc6OoGLzkQaqPp6m+E9dty92Hkey/YBOLLaDH6b7SzBHFzgC8BhN936OIFFmF/DeNbyJ8rFZnDqI69R7HD0wsx5Br5HtC+Q+yIBg9TDdX710kh7CuVti32aae/dCLVrbxtnLZo3bj0T+JHCVubknZExscMtl04+bKrIbVq8qMjYnkfleQYL/1ezG3UPYSY7LwJsBzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ke0+h/o0EqlJBXTXVt2fTfK67CUCbTqJ3NNMilA7gI=;
 b=jEUNR71fbvcjmIH4xmlSOhMHfFjMw53jtPy031psnQ/rycHJF3mTKZ1f59mVLypaOgSMbvNPxkN7Hxsr+4BVxLEPZ5quzGTtiQtQYt2qnuuWDj2JqDWcUQlV1q8sirDfTo7Dw817h1Ht5P3IIo1bwpw8Z3U7O+t1Ofr7J19X8hK8q9DmSNmMTtztkS2zL5sWkCudgpu2eFikx1DKRXiCkI2QlDnTLm7E5wxy41PHRiz5wuU8alSYrmWuhH81W9tBPwHHcwhHHkAbjhKCl6TYTPz09BGyii4mhw+vrKKvGuMO5nCa/RB+v21sI95aIsrF582h4yf4KXmuP19nTarQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ke0+h/o0EqlJBXTXVt2fTfK67CUCbTqJ3NNMilA7gI=;
 b=SJzLM+b30h+Ia/5zVtztQdWtNm0w5ifjSLG/Wn85g/cq9SLFx7bWoK2VVIxFgF7kA1fgUYZpIeLr7iNfewKfFirmFMm0Dzef3V84AfHx789JSpiSz/0CTmZ8wxtX5T/O2MhXQzzA6CWSj+hykPK0vHModUCu5uzVE+x8bRXhcNBfkcHpj+TOSzXMBSuAXdC/Rdp3+bXx/UAE8Oix3w8XB9z2xz9v0c2H//8eXnA8BCgIQmdM/6/YHtEfYSDWhtzvUKtV68+KZZcAN4D1jOGuGmDMkvmSWaKTtS+8q7pdUHaAZARhvoQ7MX9Bz0ksxnTMxZWNKuOdP9IZBLg3Z7SLGg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB6241.apcprd06.prod.outlook.com (2603:1096:400:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 05:39:22 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 05:39:21 +0000
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
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDMvNl0gbmV0OiBmdGdtYWMxMDA6IEVu?=
 =?big5?Q?able_AST2700_RMII_support?=
Thread-Topic: [PATCH net-next v2 3/6] net: ftgmac100: Enable AST2700 RMII
 support
Thread-Index: AQHdVWM4P9wWfb0NbkqBDOOqxARznLbwtY0AgAJpeMA=
Date: Thu, 8 Oct 2026 05:39:21 +0000
Message-ID:
 <SEYPR06MB513454E3CF42CCB62402E7F59D932@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>
 <268b6bc5-40a5-47b4-99a2-68d9f56b359a@lunn.ch>
In-Reply-To: <268b6bc5-40a5-47b4-99a2-68d9f56b359a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB6241:EE_
x-ms-office365-filtering-correlation-id: 45bd26bd-7b40-484b-3ff8-08df24fe8144
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|38070700021|56012099006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 +9+SsyT9lg5Ctyp2RhwUh82W/+19n/QnicKk13jgpZWN5mZ3nKnqxD7dJwn5kka7X7kjUxWNLBl7W5PLBUBO4okRTmcEL4kNhADqnaQl82vy1GXTcBOq2Xaqvj8NTh0pAAgRNKuQCVwozsPHRDWjf41U7Yn+OyRuWvfRhcPFVkPaVXgF5m4XX6KJcIAL8RlqWE2/6ViRMdyE2wdkUte83jtoYkJHpPU+d4eMf/7Oe1LKb7UQ9iTgdLLCtwtBi0uaslS07Z3HT7zyKP2lHbw5zV7DTgEtVCBM7iD4AYfxtHdIiPesGkeGQpSJCV0Swa544HUksEEoAgH/TJulIy/GqNNuZkfWUnqtFkX2umyKuM6Uq9+S5bXbWMipGX4URz5Ow5oBwrcp8C/BEOZdzXsXl9BOdp12+u5eEUsBbY24ZCiGz3o7wsIU/qZXC++ZVn07AqLTQXhd4WLmbb07goLlAvIfuI066gOeTNvFQHe/9N87nViW/RBdy563/g7DFmqnHD/Yt3HtcDinhubInrQbDUJGrx0KBcFNDvPNi+YPuIIsrN4UPJmXb7W8R7Rilnh0S0uyHDAfOOTBnPL7lgDVWWn8r5Xgb4SeuHoDsxv2TopZnjG1GdZ2zsw/26yIPDuNl92SjRIa18MnFOQ8Tr9XLsq+A39bQVEcVYViuLYvqWULLR8j4flEgdyhiSyn4tkc6TThhEANA/6j2dic5zxWtw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(38070700021)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?czdPV0luQVRzZzgrcTFFTjc5bFNFRFdJaGZwYjdlS0lkNFJkQnh3V3JkWHdoM3NE?=
 =?big5?B?L1VhWkMxWDI3bG5WSU9BVG1GOTVoSllweWhHQ3FKSTNFcWdZd1Rrcm05NDdnMVBJ?=
 =?big5?B?RmkrNFpSa1VVUlJtNTV5QTg4YWhYRkxaT1RPVm5UeUdOajhtMUZjNENMMFFQYjk4?=
 =?big5?B?d1FBVFNDRFI5aUF2Zkl4SlMyUG00elp0UlEyU1BybHhnZ3hwWWFYcURBcGdHOWg3?=
 =?big5?B?OWp2UWRKSmhDVy9maGJLdldUMjA2WVRUaktJMSs5bHMrRElXNy9TUFpFd3JYZHBu?=
 =?big5?B?b0t1OXdDVjBZNU9TQWlMZjVPdWpLWUUvV3pBcXVrZ2p2Vnl1SDBCMnI2SlBrbzBl?=
 =?big5?B?UWdRbC9jYlVMT0NvWFJkZFJwdEptNUNwSEg1UjlHaEZCbGd3dDM0SEdjOGxoNkFX?=
 =?big5?B?WDZtdG56TVdvVytXbXd5R0NaSHg1cFlrYW1kcnNjbWcyRzNzMGFkU3FOL1hkaWVy?=
 =?big5?B?eUQvWTVJWllvVE5LN1ROeEhOVzlSdTlJNStEeTl3bWdyVHhURjk3empacmcxVnZ1?=
 =?big5?B?L2txM21DOFowaSs5Z1hJNXdVMmpOenRKL3dSWGh1WjNFd3dvVTFsbHc3R1VWQno3?=
 =?big5?B?WDZ2TFZhWkQ3ek53N1lVMzhNSHB3aU1GL3VPTkMvY2F1WUpWMmJackpHUGdPbytR?=
 =?big5?B?SFFKanpWSmpqVTlZcnNkek5EZC9WNUIzdnh1SXJOaDB2R3lHMktsaGgwR2hNeXlz?=
 =?big5?B?TzVHZS9neTFsdkJtQkZ3UTE5TlNUdVVST09QYjlCeGphYVlnME5KUUJjWWRLQzYv?=
 =?big5?B?T0VZYVFraTVSK2ZyKzRMdzZQZm83Q2VEYjVXczJwRWpLQk4ybmRoMDkzcTNqdEdl?=
 =?big5?B?bmtoSlJ4QjFoNVlaTHZDaEFvSmRYbkswU3hqTlZncytkajcyWnhoUUNwbnRaNXNR?=
 =?big5?B?c2dZMWFYb00rUlNEZjNpNkRBaVlBbkxRdXNtaGViaEVmOGVKa0lwYXZYQ3NTRHVH?=
 =?big5?B?dTVvUFhWNkFhd1lBelliTC8vdEljTDBmeURBYXkyTmN3b2wwN3E3SXU3dndOVlpj?=
 =?big5?B?aCtxVVRUd3dWdTZCNDRaZW04djY5NUpQbk1iQnFYK2Y0MURSK3ZGNDlBU3R0T2dW?=
 =?big5?B?NU9pSnhzVXRXMVora3lwcG9EUFFyRUNyUitDS2NIdU92UWhxSkNnRG4zbHFoOERQ?=
 =?big5?B?bndUM2UyUXFRUHZFUFl6OUFUQUlaV25zUFRaOUF6dFhKRnhMbVQyRXdBcHgyQ1ZS?=
 =?big5?B?WFpJZW03Ty9IeG9WVmd6TG5uM05wUVRKeU1LajExcjhyR09aMXEweTlyMjVzYjBH?=
 =?big5?B?RTlRbmI5a3k4VjM5QzBycEtrWUdyUVJITmFVSVVEVXVtMTc1NGFaV2hLa0JCbDRJ?=
 =?big5?B?WHZpQ1lvelJvZkdqeDlvUTBqNGk2c21qakJ5ZzI0U0xhdC9nZ1BJYUxCc0xWb1p6?=
 =?big5?B?cEg3WXZZdndBVWtWdENvWnl5bE8zZzc2K3I1SXB6Nk4vS3piTkFvNktlNmp2a1M4?=
 =?big5?B?TmUvMTZyNnpXbW5WZmZTVjU5T0FNZWcwY0dvYlNMVVZtMEQ0cUhyYysvR2pJZnRw?=
 =?big5?B?UG1rdjZtTGNLQTVpOURBQk1Pcjh3VVlpL2xBSkpTVFo3MmNET0FhVmZadFMwU0l1?=
 =?big5?B?Qzc3OGxPejdEZ0V5U01WN0tGOVkzTzV6VXhTRDJNbjhVV3VqaXQxSmJNZ3ZWUllY?=
 =?big5?B?bUVRbkxGUWw5L3k2OW1sVXkzQUpGUVdzR21PbzR0UG96MERRb0dCWmV0L01LUm1R?=
 =?big5?B?cXlRYkZyQWQvbi9yOVMyQ24zQlRRZWdQaWFDci9MSFJ4czJiNkRqMU1wbXYzYTJu?=
 =?big5?B?bHkyL043RHdhcGVaK1locEwrMDJSRy9xeVEyMTBXaE9KY2pKYWpsK0RHUDQzcE54?=
 =?big5?B?Si9DVDNkZ2t3VnF0YThSNHhRbjg0SDBlclRDVlJPK1doZ01MSjJnd0tRRU4zTGFu?=
 =?big5?B?ZGsycGd4a29aZVpDUmNPTVJwNUJXaFBBVHlOTkVYQjZwcnJldVU0bmlvRlFlVEdK?=
 =?big5?B?ck1ITllvcTcrbFAwMTg1bGF4UVFnWkpSOXVQbFlSY3QrdVE4Y2EraWZoejdFYkZx?=
 =?big5?B?T1FXcEo0VmJzMVN4cUROV1M1TkdoK3dTTlUvTndMZXo0REtYY0Y1OFlIemJ5Vnk3?=
 =?big5?B?STYrbzQzaHE0YjJ5K0t2amtvaitQZzJucTYyYklpVUJ0dWF4b1BVSzdUbS9iYzNi?=
 =?big5?B?OFRyWW53dVIvRmo5RHlFaTBiSmRBaFFCQ3U0REp0RVkxZE9hNmIxK2pYREt1dlk0?=
 =?big5?B?VmZxazZ0Vko4NFBieEYvUW95MUV0UT09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Fgo6DAD74CE5VzqRWEe/gjfpe3XgTA2g2UaiLa1EgVhEVrfe3jgHyMMyHKEUvOHjP8tow3o+lnpLdL59/qNRi77tRaFSIq1c7Q9F/D3XzebYnoeydUKIou7bac++EwI7ZZFQuVnF8Bh8WvdaRfSqI2sMF6GpZBjB1dgzdtdtUzUHz9xmst5EhzkjuY3N6C+yBxJ7uWmbtT6x1x88ueEns/50Ra4bf3eePnXNLA12MP1NhlolYDaC+D3ytz4ZYfKGCGOsu0NeaSlGweZfpbe+m2lSHFkzz9v/2gjFlgI4V78uf3mlpSq8oIPoeSviZKH9Ob97zk3YO9fEV9WKdtJqVA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bd26bd-7b40-484b-3ff8-08df24fe8144
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 05:39:21.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRRxH6/luCVNgum4Od/jWxeXSwVSF5Ikft9Fn1PBo+gzvf04ILE7X4r8Jy0nFq1Zgygr5URf1jUzPGWd6qNi0g8sFZbJ6r2N025IZqEL3mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6241

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+ID4gIHN0YXRpYyB2
b2lkIGZ0Z21hYzEwMF9zdGFydF9odyhzdHJ1Y3QgZnRnbWFjMTAwICpwcml2KSAgew0KPiA+ICAJ
dTMyIG1hY2NyID0gaW9yZWFkMzIocHJpdi0+YmFzZSArIEZUR01BQzEwMF9PRkZTRVRfTUFDQ1Ip
Ow0KPiA+ICsJc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldiA9IHByaXYtPm5ldGRldi0+cGh5ZGV2
Ow0KPiANCj4gSXMgaXQgc2FmZSB0byBhc3N1bWUgdGhlcmUgaXMgYSBwaHlkZXY/IFRoZSBBSSBp
cyBiZXR0ZXIgYXQgdGhpcyBzb3J0IG9mIGxvZ2ljLCBidXQNCj4gbG9va2luZyBhdCBmdGdtYWMx
MDBfcHJvYmVfZHQoKSBpcyB0aGluayBpdCBpcyBwb3NzaWJsZSB0byBub3QgaGF2ZSBhIHBoeWRl
di4NCj4gQW5kIGZ0Z21hYzEwMF9waHlfZGlzY29ubmVjdCgpIGRvZXMgZ3VhcmQgYWdhaW5zdCBu
b3QgaGF2aW5nIG9uZS4NCj4gDQoNCkkgdGhpbmsgdGhhdCBuZWVkcyB0byBhZGp1c3QgdGhlIGZ0
Z21hYzEwMF9wcm9iZV9kdCgpIGF0IHRoZSByZXR1cm4gb2YgdGhlIGVuZC4NCmBgYA0Kc3RhdGlj
IGludCBmdGdtYWMxMDBfcHJvYmVfZHQoKQ0Kew0KLi4uDQoJaWYgKG9mX2dldF9wcm9wZXJ0eShu
cCwgInVzZS1uY3NpIiwgTlVMTCkpDQoJCXJldHVybiBmdGdtYWMxMDBfcHJvYmVfbmNzaShuZXRk
ZXYsIHByaXYsIHBkZXYpOw0KDQoJaWYgKG9mX3BoeV9pc19maXhlZF9saW5rKG5wKSB8fA0KCSAg
CS4uLi4NCgkJcmV0dXJuIDA7DQoJfQ0KDQoJaWYgKCFmdGdtYWMxMDBfaGFzX2NoaWxkX25vZGUo
bnAsICJtZGlvIikpIHsNCgkJZXJyID0gZnRnbWFjMTAwX21paV9wcm9iZShuZXRkZXYpOw0KCQlp
ZiAoZXJyKSB7DQoJCQlkZXZfZXJyKHByaXYtPmRldiwgIk1JSSBwcm9iZSBmYWlsZWQhXG4iKTsN
CgkJCXJldHVybiBlcnI7DQoJCX0NCgkJUmV0dXJuIDA7ICAgICAgICAgICAgICAgICAgICAgICA8
LS0gYWRkIG5ldw0KCX0NCg0KCXJldHVybiAtRU5PREVWOyAgICAgICAgICAgICAgICAgICAgIDwt
LSBjaGFuZ2UgdG8gLUVOT0RFVg0KfQ0KYGBgDQpUaGUgYXBwbGljYXRpb25zIG9mIGRldmljZSB0
cmVlIGluIGZ0Z21hYzEwMCBoYXZlICd1c2UtbmNzaScsICdmaXhlZC1saW5rJy8ncGh5LWhhbmRs
ZScNCmFuZCBsZWdhY3kgbWRpbyBwcm9iaW5nIGZvciBBU1QyNDAwLzI1MDAuDQoNClRoZSAndXNl
LW5jc2knIHdpbGwgYmluZCBhIGZpeGVkLWxpbmsgcGh5IGRldmljZSBvbiBzcGVlZCAxMDAgYW5k
IFJNSUksIHNvIGl0IHdpbGwgaW5jbHVkZQ0KcGh5ZGV2IGZvciBuZXRkZXYuDQpUaGUgJ2ZpeGVk
LWxpbmsnIGFsc28gYmluZCBhIGZpeGVkLWxpbmsgcGh5IGRldmljZSBmb3IgcGh5ZGV2IGluIG5l
dGRldi4NClRoZSAncGh5LWhhbmRsZScgd2lsbCByZXR1cm4gdGhlIGFjdHVhbCBwaHkgZGV2aWNl
IGluc3RhbmNlIGZvciBwaHlkZXYuDQpUaGUgbGVnYWN5IG1kaW8gbWV0aG9kIGFsc28gcmV0dXJu
cyBwaHlkZXYgaWYgdGhlIE1BQyBub2RlIGluY2x1ZGVzIG1kaW8gaW4gZHRzDQphbmQgZmluZCB0
aGUgcGh5IGRldmljZSBieSBtZGMvbWRpby4NCg0KVGhlcmVmb3JlLCBpbiB0aGUgY3VycmVudCBj
b2RlLCB0aGUgZGV2aWNlcyB0cmVlIGRvZXMgbm90IGluY2x1ZGUgJ3BoeS1oYW5kbGUnLCAndXNl
LW5jc2knLCANCidmaXhlZC1saW5rIGFuZCAnbWRpbycgcHJvcGVydGllcywgdGhlIGZ0Z21hYzEw
MF9wcm9iZV9kdCgpIHN0aWxsIHJldHVybnMgMCBhcyBzdWNjZXNzIGF0IHRoZSANCmVuZCwgYW5k
IHRoZSBwaHlkZXYgaW4gbmV0ZGV2IHdpbGwgYmUgTlVMTC4NCg0KQWxsIGFwcGxpY2F0aW9ucyBp
biBmdGdtYWMxMDAgbXVzdCBnZXQgdGhlIHBoeSBkZXZpY2UgaGFuZGxlLCByZWdhcmRsZXNzIG9m
IHRoZSBhY3R1YWwNCnBoeSBkZXZpY2Ugb3IgdGhlIHZpcnR1YWwgZml4ZWQtbGluayBwaHkgZGV2
aWNlLg0KDQpJIHdvdWxkIGxpa2UgdG8gYWRkIGEgcGF0Y2ggdG8gYWRqdXN0IHRoZSBmdGdtYWMx
MDBfcHJvYmVfZHQoKSwgb25jZSB0aGUNCmRldmljZSB0cmVlIGxhY2tzIG9uZSBvZiB0aGVtIHdp
bGwgcmV0dXJuIHRoZSBjb3JyZXNwb25kaW5nIGVycm9yIG9yIG5vIGRldmljZSBlcnJvciB0byAN
Cm1ha2UgcHJvYmluZyBmYWlsZWQuDQoNClRoYW5rcywNCkphY2t5DQoNCg==
