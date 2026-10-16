Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022109.outbound.protection.outlook.com [52.101.126.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388E2AD0C;
	Fri, 16 Oct 2026 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115282; cv=fail; b=qSQHWfsixdLjbf+Rt4wjIIIAg2Sr5LW1OF3iLsnvcsHhFPfWDHblsnde9bpvwxCU6JosjamdjpDbGEJhHUoUnRZG76cg569Hk/7sOIapZ1JiuAnX1IGneG4xGVwOqE/KLqGWTklcnnMt36J5Pz3KfPno32wuTLCg4+WB3RsXGCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115282; c=relaxed/simple;
	bh=qKHuQCKnu5TuBnDhFEqGdCM3anw2AHXqtzbLAQEq4M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ch11V7EkIbugpnLUYytsllAs2bBRySAZ+EedLe28sbBh78UcQax3iMXqLdWFVFU2+On3UUmzuRI+n+hJeZCa8jqsXH2zMu++H7cKgd8rXHjjCeVBFShw0MYCBd7OvIrATGHqUjhb06FRtoSJzxmcO9DlKVPu9hcJPAMhjR1PHEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=rZeiTsS0; arc=fail smtp.client-ip=52.101.126.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="rZeiTsS0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnQAkxEwwfkWxBpYQ3igo6e77pPGENnwlPvPJCgCO2x5iCBh5EDLg8782IilNB2ulBrjVSnA4Xz2Pom9rucv+3dP5lTbzWAj161tjVU6WOc/HYLNtn8omAuybRni6FqyV/ab3MQ5Snlrq+ycky2kbP+S6uV3sbu9BOsijkIqxwNTmYmRA54t+ScRaKks8Ar4Eo1ZBWJ1ehK84KVKD8NgOnTmN+99DMBKUiXINccDmxwNIyUOdE9/kaLUfn9eSOfkC026ROH/BuWwV+bEHYpvkCs+0+N2LQIYYhrQkLOJ6RRMzG/lY0bxFMxjv4QLyjcHaNjsnWD5jefyZRwxqzDafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKHuQCKnu5TuBnDhFEqGdCM3anw2AHXqtzbLAQEq4M4=;
 b=EVAA+cEd+fLUzAO7XpZoK/yjMDDFxudHSK2jt3mByMDqaFmL0m7CgNDMLDV8zyKpsgpIVfaUAtttayOVd7bFCOrAwpFUZBzKa0rOJtxYPvBCfggvF/8ex9IY9vDbPvltxl3mnLVeF3Gplvall/gJk4cSp7yc5HmK+eSRTKkGeUcC+Tw8+GSnoyfwpVpZsJgN1DbsHrA8X5mCLETS0UZuEwJm98WBFWou/AU94DG8kd05Uh/y5JATpM+jcRsbl4WaaVZT9izM80hyG3Em4x+T8IXXlVJ2bvfcSgytnWv0u/IEPBKhGLSyoWTQ5hES6+PoBd6vmvPaRDIYlyiE8drLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKHuQCKnu5TuBnDhFEqGdCM3anw2AHXqtzbLAQEq4M4=;
 b=rZeiTsS0WJBuV7m/6cT4cunaHE03oNukBpHM7z+EMEPoTq+padF1eSJd1/X5xsAlqJJLT7aUjg3P+TebTMFeMJkdsw5YUrPAk0hNCjIdhGFkLRvvM1LcLoe5PdFuAx33tE+lFS8Ui3G1STPDrVw3hp/GD2RJ4VRxf1x6DC4fbuZ0tyUx5itXTH3asHkiJbxybfrdNuxwMFUzpzYCZ0PbnXOtRWFt+9pCyrXRkTWGKAR1nLHVzlCaxo3upZm4WJW6wnBvdb3oa1EtAR+3q3mz3qivUh3R1xVPZPWa579zYCSphQKNCq+O0eq07gXhjxQ7kHXHE3qI/b/cAu6ptDsNwg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6207.apcprd06.prod.outlook.com (2603:1096:101:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:47:54 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 01:47:54 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
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
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYzIDEvNl0gZHQtYmluZGluZ3M6IG5ldDog?=
 =?big5?Q?ftgmac100:_Add_AST2700_compatible?=
Thread-Topic: [PATCH net-next v3 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Thread-Index: AQHdXHD9n9Q7HrGikUqVTdhqbVWs7bb++zAAgABqZOA=
Date: Fri, 16 Oct 2026 01:47:54 +0000
Message-ID:
 <SEYPR06MB51346CDBE8434290ED671A979D9B2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
 <20261015-support_ast2700-v3-1-8d7999171ac4@aspeedtech.com>
 <20261015-anthem-kitty-d0f8794da246@spud>
In-Reply-To: <20261015-anthem-kitty-d0f8794da246@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6207:EE_
x-ms-office365-filtering-correlation-id: 360a5922-476c-4f51-ca43-08df2b277f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|38070700021|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 XLhYe4cnBfMwN6vNi+PPpu8pDE1Vtf8tFTvk2k0IFha8E0HC4XJraM59tnizuaffzAQ9UDCCaUTldQ6YbMbnzKESlEcs7XDFHirkM8khyZXl9qLy9KMaCDIZIQX+s8hSJ2KrojzY2TkU6/IRuF365yMYsekQnH3BAXLY+ZEyLhP5jsy1iFp4Ui++VvI8hprklfYHn4711meMbiwUQiBzZpiqIc73xP6w1vHRIXBCGUttAEpsmEqjl70b8GYCPFmF2e5YzzPAGhYTmBZgNbAUm0bl5ll6nI5ScbkvL4vZWHEDqulTKpPhXd+Rfg3sAbjWU9+R4YoiRDcvEckAUCDdzwAeFo8rbZyiFpbYDag5VT21ljniTFZpHcOau8JopFfyrnTFIieGEMmuxOAk6wxzlW9En8EoQE31xw5Kjbx/ca2vJ5JxMaiWHglSzwD9ApxldAmw+NLr/up+9Z5/eS6eZ/oeGIae0jmdi8iyGmqmBbbhE+D/hzcJsVSCOtgfn+nHpl2h0BQasX/NJOyCjSkNFCjilOa6b6yrHLaJB8Al5Wwe3X6Fp+5ay4wQIAmmRaZtHoC1cfUx13P9/jPg9sx10RQZykL6C1ke9QEnQ+D1Tn9xTddCGWwCwRIVLmAWag8mGW156lhyhJ4/7BCcxKrmtVydaZ8Y8wmiCaLmTw4q/+l9Xy+VIBk35ViF7qS3hbo8JlmIOnsxab4XuglWgkau+YWTf5ZEwtoeTPLHcU9Lcsk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?QzRrak5sOEgveVVyOHp4clR3YUt1ZWk0bnFud3kvbmw0Uzh3eVc2TitBMVc2bkhM?=
 =?big5?B?YkFCbHdvL1JvZWU0N2J1MzdFQzhzVmFhYkk1b1hhTVlMUmNPL1lYVWdyY1RUbDU1?=
 =?big5?B?eWlIK0MvdFZxMUhCS1Y0TEV5bHpsUzd6TWdnM1NRM0xLZE9IMFU2TkUyVDViZ1A0?=
 =?big5?B?eHd5dGN1bWFnZUcwQlpzWWEzZTM5T3RZeHFYRnJhVk1tV0ZrSGp1SVlJSGkyWE96?=
 =?big5?B?dDBoem5rMEw1N2lzNXdMbklVVk4xUEpUU0dIdlNsaDFudzBQd3JmSHNSLzV2VlhI?=
 =?big5?B?Ymw0YXRYSEl2K2NIOUhKVHpVeFpDd2VNZU1LcC9raUZmYktPb1ZQWHZ5bnlyVW1o?=
 =?big5?B?NTdZcWk5WFY2eVc0QUFxU3pWQlNBaVBXNnQrTUcrMWp0NzlKY3JVR0U2T1hzZnZJ?=
 =?big5?B?ZXdoY203dFYzbGpBOHhseWVvU2R3dExsMTQ3RlFCY1ppbmkwbi9mczBESFZrY1oy?=
 =?big5?B?WG5WYXgxSjljTXJhbkw1NHVodEd0dFBlM3dLbVEzV3lmMWYvSm1OY0V4VzE2QkZ0?=
 =?big5?B?QkVaTkFVRHRwZDZCY1ZHWXUveUtZRXlVRjBQWkIrUVdXSWdrSk0zcGZLWDRPOUto?=
 =?big5?B?dXFiN0V0bDRRWU95b1VDK1BIdGJ5UkEzcDRteXpmamVDdGdaWUdlS0tkbTFwRG50?=
 =?big5?B?YUlIUEZDUkcyZk1NdGNmYW5rUDA0RjFKdXJ4bWNWZTVjWXJXOVhqQWs5aTR0djNL?=
 =?big5?B?WmlSTkFLVy9uRlNuc2gyNFFtWXdUZ0llNUZEZ2FqZGxKZ1N5R0FCbGdzYTNQMzR0?=
 =?big5?B?MGZvNUZ2SDRFR3d4dnoxcHVOM013UXhXdW9XUGo1UStGMHExclg0VUx5V29ua1NG?=
 =?big5?B?YVN1dTdjZGQ5bkdCSUduL01qM2tXV2ZKNGR0OGlUUjlkdVpTRVNGRS9IZktiR2hF?=
 =?big5?B?bGx3di8vbHIveUlpaGNBVUwwL3lESTg0RTFTU2Y3cEs2WURoSDlRNjhSbHFvNkM1?=
 =?big5?B?MFF5SUJ4WW1pZXN1Y1hVcEhaaUFtclF0cEV4RmlRR1ErOE9IcnNydVhIUjY2VGJC?=
 =?big5?B?MUtQbzZ6M3VKQ1llTlI4Z2ZGNHdxaVV4ams1ZTNneWZQZFFna016UHpOL1F5Um8v?=
 =?big5?B?T1RTc21aK0ppS3BxUzZ4YzVVbWVuTDFXeUVnbVNwOG90N1BLR3UwOTZCbnJoZTRa?=
 =?big5?B?UlVZUGtyWms2enVzOGNJWERVNDJlclhZdXVBZloxNE1tbHJIdlM4SEVWOXlhbitq?=
 =?big5?B?OVY1Z29OZXVlenJIbWhSUDY1RVp4UlBPM0cvYXBpSEZ5bmlwTnRIRmk3NnFOb1VL?=
 =?big5?B?ZzF4QnVtN1lIMTNFSTdybzlFRC8rV0c5d1pIbVFVajdTZ2hueHhXYk1mbnBETVVK?=
 =?big5?B?VS8vS0hZSTUrRVhNSkw1aTc0SXNuMURxb01tYnM2SWt6UW13bDJCaEhLMGZ0TlNt?=
 =?big5?B?VlUybGlwci9TSG95YmlOTERkdDFnaUp6aHB5d0tvSnVjbEZ4Ry9Hemlvc1FCOXVk?=
 =?big5?B?bGt6NWRlS1hQd0lET1p6VXV5ZW1KSE9JbXMwSGRtVmpsQWdta0dwNVhaQlhQSjlE?=
 =?big5?B?TzB4aGpIekRYM2RJOGlrRit6T1BZVDB4YWloU0xWYVF1S1V4S091dUNYU0FtVnBJ?=
 =?big5?B?Y2NKbjFoM3FEZlB6VmJEc0swZ1JCN0JjNXMra1FScG9aemRkdnBMaTF4VStzem9y?=
 =?big5?B?c3JnWVV1TmNBME5NRU15MVBGQ3ZQelY5UlBONnBaZ2NkK2tla3ArVTJvZGNnRENR?=
 =?big5?B?dnZjUlkzSmJjWEV4aFUzcVV3MnBWUWxPVjI0TlQvVngzZGNTdWxVVWo5c0I2Zk9Y?=
 =?big5?B?Q2VpM1pGcmZvQ1djWW44dFZJenRTNWZRN0EvNEtkNjlIcnZ1bG8xSTlEQ1NHajly?=
 =?big5?B?Qm80N0hLU3N2TkRIbGNEK21VT0JoZ1ZqeW43Q1d2UTU3UHVjWkZXU1dPblo1UmRa?=
 =?big5?B?V2tNQ2JKTHhqYm51d0x5VFdqNzFVanc4aGszSnRtOVZuMlA0b0dkdlAzUi9MVTZV?=
 =?big5?B?bGlzQVJrblRwWVlxOXNpYkRSQytUcDM4RGhpQ2pyR2tWM0R6elp6U3JqY05vWlZp?=
 =?big5?B?TkdvQU5xZVdyNGVzV2FDSWgrT0lGTWhrbGJQSUZoaS9VYkVzNHQ2VENLYUFIeEps?=
 =?big5?B?dkRETy9xMEhWRWhCMVV3eE1vRlh5UHdCV2gySDR1dVZxYzd2VHFydzZWSFRmZjFz?=
 =?big5?B?UUEyeXFUR29XWVZkN1pTM2V5OGpyUytXQ243SCtLN0twekNaU0dYYTFGOTMwMTZs?=
 =?big5?B?MkJZQWZyNk45ZFg5K1RtN2dFKzJGZz09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FzykdAjGAIH1Gd1IkRT63dGbDXsn1yifw8zP/xVbmW6aZ+X+8PmM01reo0D2wQb1qt208OdNK0DpmgWLb/IFFargU75Ze9dgzwhhnwDZ+3eFgR6C2s1GFh/4h/s2b0V2op0nqd5uCdkrf4pwVCHDES14ZWiMBqanjZ7YMpUeE8C+j9Tyk01BwKPNe2D36K333aYPPSyUXk8ZWElmznmSwiEIRHNVJd6g5Kb0Q1CYTrnU2hENC1nMpXuwV0vWmH1YBVjjrCZI6t3LHPW4xl18Aagit9iiyKZNo3c7gddeYkHxvTLFNHXz6MrR1g+mdv/NU3nfjdwyEQWiD0iIZr5QSA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360a5922-476c-4f51-ca43-08df2b277f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 01:47:54.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvym7tI3kLIHQoVgAny0PkQyt6/k8KcXk8BdvPENaLHnDr224zHs+tBCZxOqBODXtJUWyDFfoHIeWcS7MVT9WTYptpevk/nuxIPMV23Jtfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6207

SGkgQ29ub3IsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IEFkZCBBU1QyNzAw
IHRvIHRoZSBGVEdNQUMxMDAgY29tcGF0aWJsZSBsaXN0IGFuZCBkb2N1bWVudCB0aGF0IGl0cw0K
PiA+IFJNSUkgUkNMSyBnYXRlIG1hdGNoZXMgdGhlIGVhcmxpZXIgQXNwZWVkIFNvQ3MuIEFsbG93
IHRoZSByZXNldCBsaW5lDQo+ID4gZm9yDQo+ID4gQVNUMjcwMCBhcyBpdCBmb2xsb3dzIHRoZSBz
YW1lIHJlc2V0IHJlcXVpcmVtZW50cyBhcyBBU1QyNjAwLg0KPiA+DQo+ID4gUmVxdWlyZSAicGh5
LW1vZGUiIHRvIGJlIHByZXNlbnQgaW4gdGhlIGRldmljZSB0cmVlIHdoZW4gdGhlIEFTVDI3MDAN
Cj4gPiBjb21wYXRpYmxlIGlzIHVzZWQsIG1hdGNoaW5nIHRoZSBkcml2ZXIncyBwcm9iZS10aW1l
IHJlcXVpcmVtZW50Lg0KPiA+DQo+ID4gTWFrZSBhc3BlZWQsYXN0MjcwMC1tYWMgYSBzdGFuZGFs
b25lIGNvbXBhdGlibGUgaW5zdGVhZCBvZiBwYWlyaW5nIGl0DQo+ID4gd2l0aCB0aGUgZ2VuZXJp
YyAiZmFyYWRheSxmdGdtYWMxMDAiIGZhbGxiYWNrOiBpZiBhIG5vZGUgZXZlciBib3VuZA0KPiA+
IHRocm91Z2ggdGhlIGdlbmVyaWMgZW50cnkgYWxvbmUsIGZ0Z21hYzEwMF9wcm9iZSgpIHdvdWxk
IHNldA0KPiA+IHJ4ZGVzMF9lZG9ycl9tYXNrL3R4ZGVzMF9lZG90cl9tYXNrIHRvIEJJVCgxNSkg
aW5zdGVhZCBvZiB0aGUgQXNwZWVkDQo+ID4gQklUKDMwKSwgc2tpcCBBc3BlZWQgY2xvY2sgc2V0
dXAsIGFuZCBsZWF2ZSB0aGUgRE1BIG1hc2sgdG9vIG5hcnJvdy4NCj4gPg0KPiA+IFRoZSBleGlz
dGluZyBhc3BlZWQsYXN0MjQwMC1tYWMsIGFzcGVlZCxhc3QyNTAwLW1hYywgYW5kDQo+ID4gYXNw
ZWVkLGFzdDI2MDAtbWFjIGNvbXBhdGlibGVzIGhhdmUgdGhlIHNhbWUgc3RydWN0dXJhbCBwcm9i
bGVtOiB0aGV5DQo+ID4gYXJlIGN1cnJlbnRseSBvbmx5IHZhbGlkIHdoZW4gcGFpcmVkIHdpdGgg
ImZhcmFkYXksZnRnbWFjMTAwIiwgYW5kIGENCj4gPiBub2RlIHRoYXQgYm91bmQgdGhyb3VnaCB0
aGUgZ2VuZXJpYyBlbnRyeSBhbG9uZSB3b3VsZCBoaXQgdGhlIHNhbWUNCj4gPiBCSVQoMTUpIHZz
IEJJVCgzMCkgbWlzbWF0Y2guIEdpdmUgdGhlbSB0aGUgc2FtZSBzdGFuZGFsb25lIHRyZWF0bWVu
dA0KPiA+IGFzIEFTVDI3MDAsIHNvIG5vbmUgb2YgdGhlIEFzcGVlZCBjb21wYXRpYmxlcyByZXF1
aXJlIHRoZSBnZW5lcmljDQo+ID4gZmFsbGJhY2sgYWxvbmdzaWRlIHRoZW0uDQo+IA0KPiBUaGlz
IG5lZWRzIHRvIGJlIHR3byBjb21taXRzLiBPbmUgZml4aW5nIHRoZSBleGlzdGluZyBkZXZpY2Vz
IGFuZCBvbmUgYWRkaW5nDQo+IHRoZSBuZXcgb25lLg0KPiANCg0KQWdyZWVkLCBJIHdpbGwgc3Bs
aXQgdGhlbSB0byB0d28gY29tbWl0cyBpbiBuZXh0IHZlcnNpb24uDQoNCj4gPiBmdGdtYWMxMDBf
b2ZfbWF0Y2hbXSBoYXMgaGFkIGRlZGljYXRlZCBlbnRyaWVzIGZvciBBU1QyNDAwLCBBU1QyNTAw
LA0KPiA+IGFuZCBBU1QyNjAwIHNpbmNlIGNvbW1pdCAwM2EyYWJhNTBiMmMgKCJuZXQ6IGZ0Z21h
YzEwMDogTGlzdCBhbGwNCj4gPiBjb21wYXRpYmxlcyIpLCBzbyB0aGVyZSBpcyBubyBrbm93biBr
ZXJuZWwgKyBkZXZpY2V0cmVlIGNvbWJpbmF0aW9uDQo+ID4gd2hlcmUgYSBub2RlIGhhcyBhY3R1
YWxseSBib3VuZCB0aHJvdWdoIHRoZSBnZW5lcmljIGVudHJ5IGFuZCBnb3R0ZW4NCj4gPiB0aGUg
d3JvbmcgRURPUlIgYml0LiBUaGlzIHBhcnQgaXMgYSBiaW5kaW5nIGNvcnJlY3RuZXNzIGZpeCwg
bm90IGEgZml4DQo+ID4gZm9yIGFuIG9ic2VydmVkIGZhaWx1cmUuDQo+IA0KPiA+IE5vdGUgdGhh
dCBhcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc0LmR0c2ksIGFzcGVlZC1nNS5kdHNp
LCBhbmQNCj4gPiBhc3BlZWQtZzYuZHRzaSBzdGlsbCBkZWNsYXJlIHRoZWlyIE1BQyBub2RlcyB3
aXRoIHRoZSB0d28tc3RyaW5nDQo+ID4gImFzcGVlZCxhc3RYWFhYLW1hYyIsICJmYXJhZGF5LGZ0
Z21hYzEwMCIgY29tcGF0aWJsZSwgc28gdGhpcyB3aWxsDQo+ID4gbWFrZSBkdGJzX2NoZWNrIHdh
cm4gYWdhaW5zdCB0aG9zZSBmaWxlcyB1bnRpbCB0aGUgcmVkdW5kYW50IGZhbGxiYWNrDQo+ID4g
Y29tcGF0aWJsZSBpcyBkcm9wcGVkIHRoZXJlIGFzIHdlbGwuIFRoYXQgLmR0c2kgY2hhbmdlIHdp
bGwgYmUgc2VudCBhcw0KPiA+IGEgc2VwYXJhdGUgc2VyaWVzIHRocm91Z2ggdGhlIEFzcGVlZC9h
cm0tc29jIHRyZWUsIHNpbmNlIGR0LWJpbmRpbmdzDQo+ID4gY2hhbmdlcyBkb24ndCBnbyB0aHJv
dWdoIHRoYXQgdHJlZS4NCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGJlbG93IHRoZSAtLS0gbGluZSBv
ciBub3QgZXZlbiBpbmNsdWRlZCBpbiB0aGUgcGF0Y2guDQo+IA0KDQpJIGFsc28gdXBkYXRlIHRo
aXMgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=
