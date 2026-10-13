Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3C3AA500;
	Tue, 13 Oct 2026 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869007; cv=fail; b=CSgQU/CL++UrqQqxPMGhH1QO6OyxA0166ObSqHmkKG7nljo/OppnNnQM1K946BgV0KZRRs1XBK/GU0UgVheRWpfKPYDJ+8JRwXq+GxJfO8lmtunfP1/tCPXEeLE+hl+LMqYkM+uImfQaGpMrOMXEKlXDeSMsVzbS7V/ycKPJFGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869007; c=relaxed/simple;
	bh=88gLLKXMmLUjaOsYVu3wSf+pdVk2tzg9UIqW77aUtY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDtf5OdbUBbjrl3fIKa6VwwGvMwKJFQBKjulyvl2Z1cnPeM7DA6KPJOmVxInnb6FiYayKAzqdoPZpihZ5haj6t7MNpVrTgNAqB3Ozr0s2f+TpTr4vML1FHPr6thSViZhrt/dLNiet9l0sPUVMSYt2IF4d7w6G8a5qSx1ZiS6PZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=MV6GDi2W; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="MV6GDi2W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wr5zEYGfuzS7tGg7aXexDJIaZBDm2CjmjJKjYi7ZaaDMy712crTXTMEk7Nr6HQbzMqFoMAN9B99oEtxCIcQYDSZQ2LRQ35R/s+1UomYbZibYO68Zn0wqGztjjubxAdjof7FbxthUECj2ZE3pgAMH45JUPhgVVv3f7hKOneD2JEPZBIu/6Fbpuk5JvAOXOBcOo8FGSmImrjHtoc+Ow7DLyDzL8oXTSND7+2jGh5gqhFBNzk4Nu3Ho5hJy60ZqDCIU4meLjs/iP1xuSCizli+Bc8dQxLyOHKqdyxrJ9igdBjjUg8IU2iPoMk/VCqJU3D3qqcOC1TLPgUv4ffWxwRIW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88gLLKXMmLUjaOsYVu3wSf+pdVk2tzg9UIqW77aUtY0=;
 b=xV94pLsrPnDBiGsvyoDNcAJdSYoD8auU25pSNlE0Qo7hEbbKWXfJdiQReaKm7zvwuqNzqIZC+8zelLqK9N1LUvJBfH5ufW6fr/7oXJkL/QTfLAgh2hoHwvSB1zDLyyOIa5/qpuSCqT3Fnq6e3zgvN0Ytpxq4qkwCtzn9l34PK1/bDNwHtpUm6Q8gOAcTqhm6Gs1+24wFq1YG1HD/FjpOGBJW1aTEAeMC/gBB8RNAv6iLYetO5hk54mc3NGoc6WTUMKBw13xc2Rh1HD7aFnXt6TuFfUUiBr6g5Oz9LHzjjqhKN9UEKf/l17VIjgwIgJxUIn7Xkiwnj1vrvaURPcCZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88gLLKXMmLUjaOsYVu3wSf+pdVk2tzg9UIqW77aUtY0=;
 b=MV6GDi2WGc6gaRORJjFnmyj+yOD5ZFR9WrjVdfNL6z3v5E9v2/A8MCC6eIWmc0eujOqfoB9MPcmbDY96qCgxTvgPpU7wa1aGBxE4WEOHHkGeeMMi9CvkUSPcm5gbFHStyiv17YHuPpXKgh0xDxE9wwou1e79Pv7YfNi1RxfH21/G4BmnEbnJbtNMnLoPo3ANtz/Rb6SGdkVNdQ8vKd5ayd9OvxLwsvoaW95VzQbtNjT/LuZAxafbbYIUd//NzU0QSTI6lhRELNa36rMCXZlPAq0fYkz/X8i9lrRpIshv1suG6orTM4W72q5kIgAaiDeWxS2lYp6UeEQRelVIRiCq6Q==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by OSNPR06MB8906.apcprd06.prod.outlook.com (2603:1096:604:49c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 05:23:21 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:23:21 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>, "netdev-bot+sashiko@kernel.org"
	<netdev-bot+sashiko@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
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
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDEvNl0gZHQtYmluZGluZ3M6IG5ldDog?=
 =?big5?Q?ftgmac100:_Add_AST2700_compatible?=
Thread-Topic: [PATCH net-next v2 1/6] dt-bindings: net: ftgmac100: Add AST2700
 compatible
Thread-Index: AQHdVWM2owd1VMPC/Ei4XAumWNgo4rb2b4oAgAPRq4CAALb8gA==
Date: Tue, 13 Oct 2026 05:23:21 +0000
Message-ID:
 <SEYPR06MB51346A6CB5D7D7FC6D3FC4DD9D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261006-support_ast2700-v2-1-36de51fb8066@aspeedtech.com>
 <179161911824.434549.4075299707625994950@kernel.org>
 <20261012-aide-wimp-4edf96aaca1d@spud>
In-Reply-To: <20261012-aide-wimp-4edf96aaca1d@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|OSNPR06MB8906:EE_
x-ms-office365-filtering-correlation-id: 3a2f3751-df87-4262-380a-08df28ea18ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|38070700021|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 2x6FnQ1yWujYi/nioIHgVqvJeZirWFrm6Iqxtqp12ddtwQrT804+xDcEsYThp6R+EkymDybxSRZ0UjeB0m7n8VG1u8WQVAHX1VC+UtVYW0TaEYuiFOq4jNR38DeYTbmKFsPUsWCdy+XSJSPH6mBCn1d0NV+VIN9HXKXSwTRWSnwNslC2sflqANf4TcS4aH1VIsBgFWtps/EnBRyA01Qo47c0NCIV0byVAoE0zpnkdw+Kx5vnSK50tkCWAvf1l46fYQG6cIK9JaD/Ra684wgA+GV5J10BWNbrOIJ9icBX7AVMBioRldWH5Mi8LYCUMK+3zyGIsgcP0jdbXQq/0Bm56fj4LjtrbE+01a29Usqc0aCBuKk+J2K+jsAc/BpDHj9u/yAS7PDtIjeNEjKQZjG0uTCRLkGvuJSFfIkkuNkOkDfqCz3ygi/tOd6FsGpoDk0dgU5PgqCYFO4P1tpMCbEn2+Vj5wQ/8/3pfg1onhqI8jIV04JptqIGaUF2qSx1wrDk8KiTbWq0FxNgBUo95yirRNRqCGTOueQKpdXXwVWdJrBX2TL5/z8vICaZejhk8hTk4rkEZubuThrsW92bZf1g+y3Oe1LLn6i6yW275k2GjwLJ/cmqbE2btrlN2H7EhNE9oQNIKuHw4rGfv72NsD9AhQcBlrjR2GsS1yT/zbxYGIlIFLc3gd150KA/s4sEzEEYhecfKY0P9rczyliHpuGbxTjzSrpEBB5Z/7Kp3qXV0qE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(38070700021)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?RU1qRjF0SmZRNlhYM24rTHloS085WGRJa09WdXR5Q2VRWVovRFFYQkVlb2dIa0s3?=
 =?big5?B?Y3ZWNjJDWW1nV3Ric0hqSnJYRUtHcDFZeXNyWFFyWEprM1MvUFE3UjBINDhIYlUx?=
 =?big5?B?WjFuYURvZXhyTlpYSlJ4bWQxeklTSEozOGdpN2liSUIzNStTTDV3dUJNS29DdGsv?=
 =?big5?B?WXBlM1BZYXhlOXU1Z2N3bksweis4aWpmd3ZubXdnTkthUzY3bDBiWDEvYXpCQUgy?=
 =?big5?B?ZU8vRjRrdnFnbTQvYlZmclNSUjU0anVYZ2REdzlPUDRmcmprSGhoRnUzNitJTDIy?=
 =?big5?B?WDdMeVdHMmMrR3NtTjVhUmFnOWJMUC9pQitVMVMreFNITGtUbkM1d003aXJrMWtI?=
 =?big5?B?YjlKODdFdUFlcVNBd1VabU5YM0xrZWZ0bnNoWUxoZmU3eng1ZFFXS3NqdURJNG94?=
 =?big5?B?Zm1lVnp4MVZqamJZOTBWUWxYMG90T3R3bjdBTkV6MW5CSWpibHNhMFg4T09pallF?=
 =?big5?B?TWc4ckVmUktwZHp6RUp0ZTBNT28wQ0dIajhtcEV3M1prbUwrZnFDUWxlODRWN1lt?=
 =?big5?B?WWEzUVRGdFVlRHFSbjF1aE8vYTVycGc1Q0l2eG01VkVEQkNsNDZFeVI5eE8xZ2I4?=
 =?big5?B?Z2pxbDZBWG8weEtBdzl1RnY2bERsSTlHeGpXN0xEM2ZBckl4OUNvaisrbldHeDg3?=
 =?big5?B?MzBPS0pMK3hyZC8vZFpHSmlJeWxGa2Z2bUlrcFVUWEpEbFZUMG15OVhyajF6K2N4?=
 =?big5?B?bXZ4SU5qZjJzS2tIWG5mRUUwcmduK2dEdFBIMWpxUWh3cithd2FGbzZ6eVR3OEph?=
 =?big5?B?dDh1eG16M0hESDMwL3ZobEdNUWdidkVKYUxSK0hYY2Y2aUhXcUJOWU03dE8rS2Vh?=
 =?big5?B?Y3g5S3pjRG4zd0o0Ulk3VGFEM1VQaEZzalE4eU45WDZNbEZzTnB6U3JteURiazJv?=
 =?big5?B?ang1MDd3L2gvRm1hbndmT3Q5WS9Xc1RMdDRpTldBcGJBZExjQ0M5MGNJUG5SMkFY?=
 =?big5?B?Kzg4RllUYXF3d3FzMXRjNVlVcjdqcWpLL1dHMEtNVENVNG1YMkNLOTZuaFI5Y2RW?=
 =?big5?B?T3JvWlFldEZpYTA1VjFNUi8rNklkUTB2Z0JzbTc4NVptWisvcWtneU5vVHNoaFE4?=
 =?big5?B?Um9MNGJ2STdjVXZQdHk1S3RMMkdPNG5vQ0NTNjRGcldaajdzam9rRkFDMHgyV1lx?=
 =?big5?B?b0pPcFhXUk1nRnAvakN6RzNubjNKamhmTWhTbGdFbkhxV0cydmNNMEpRUTRxYVFt?=
 =?big5?B?NjNhdC9LTTJRd0JFTEsrU0xvQzFYUXBWczFiMTRpdVZQTS9lVTFvWUJ3TndGSGVi?=
 =?big5?B?cUw3dENzSEpDMTJsSVd3cFpSdXI2SVdLTlN2R2w5SHduY3VIc0h4VXlDTUpwQVlV?=
 =?big5?B?MDJIWE5QUUx0eEJaU3NtcGFSVXpMNDJMNjVFcDJ6V3dpcHhRUlpwKzJpbHJwQVZI?=
 =?big5?B?bHF2dm9zU3ZIQ2ZmajFZWkZZY0VJd25saUxxWi9NUDJEaFpsM2JuaEpQeHU3ajVT?=
 =?big5?B?S3FRMFVoZmVvM0xLV09vMitsdVNINVFIWnRqeVhGeWJFVGUvTTRjQ2o2eHNnYVB1?=
 =?big5?B?dkJ0QnhENnpsU3IrVzBudTBrUm1zNG55aWJ3S3Q4cEJZSGwvRW9xUjBXd0oyN2ZO?=
 =?big5?B?Sit5dGpQL09LVjVwVnpLc2ZReVJzOWdaeWJLei9SMXNsamRHQzkyNEd4eVZYM0Iv?=
 =?big5?B?TXZPKzREOEZRTkdzVmxHRU1UTUpRREdXZWxrZTd1NUJ2aFpneUdtTS9GNHBqYmtX?=
 =?big5?B?YndnNytJR0xWY0tsREdVajV2eXZBbjFjOVFHNk91RHQ2RXdlc21ZcVpJZVV1UVlt?=
 =?big5?B?TlBGUzFjVDdwRkVtMWdaY0NCSHJQUDk5Tlljbm1pVmNpMWVBS28wR0lHakVoUUdp?=
 =?big5?B?QUN5bzdMSEdFaDZKWXhlekJOd2VYeWpjckg4QndDaHFXelFlMCs5bWlJd3NvRGJk?=
 =?big5?B?UmtPWVY4MVdodWZLM0dHQ2tCM2ptc1AycnlPNENkeXlFazZQQmlDeDFYRjVmb2w5?=
 =?big5?B?WWdNQnNGTEFOclByVWpsV3pUS0luUHpXTUFmZlp4RzJ6bGtvMU84YnNHSGUxTUgz?=
 =?big5?B?UU9aS1V5MDlVaUxBaFhJSjh5ZkE1VHY5NUlNN21CQUtXWlFoNkNzV21xT3B0Ym5X?=
 =?big5?B?TE1PL0lYMW1Kd3dnVmtWTHZIZW9wRHFpUjJPMkJhRHVDQTVTUVFIUzhwL1hONlNX?=
 =?big5?B?cFp6RXBBYm52aEY4UWZOQ3lXUXowR3NKazZMbW1NV0hQeWVwUFRKbmpsalZrSWFp?=
 =?big5?B?ZjhnRCtKZGNJOHlwcEpVNE5IRnRhQT09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VmoOJeVY3rGyrSih93NPZjoYtqDs5epwVLjJH4xoH+/8KVApC2e+VN9TZ571s7g6QkcC1VKrOWAzRdmIaRq6i0UGFbqMNlps9BOzZ21U+XdbmWUJp/564UkRCxJiWNRlOUaSF/B5EmOWUKUAzzy8U1ykRQZpiRbCe4l4nWKhbnSjFdrOIauvHR8vtMiZh9vi+uCBOadVmugo8qnQrrTQR++zi+8EfPESgow2Qu5YWT6mH7WjURorT41yY3R9X8emwfWUsB42swsn4HOgGsKGs1W91FvEVWR06aC09G1pzX4GmOPhQy3iInHLolvol4uDXs4hzBpbripuHXNIWqCnWQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2f3751-df87-4262-380a-08df28ea18ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 05:23:21.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eB8FL5E52kuF8mzo77k1oA1ahgcQXMDxIubwNrPEa1y71WwtUOESp31qzJGBN6WRDTIF5DM3zdRki49iN/bAR3yAjKpQT9hGbHbefeIwGgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8906

SGkgQ29ub3IsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+IGR0LWJpbmRpbmdz
OiBuZXQ6IGZ0Z21hYzEwMDogQWRkIEFTVDI3MDAgY29tcGF0aWJsZQ0KPiA+DQo+ID4gVGhpcyBh
ZGRzIGFzcGVlZCxhc3QyNzAwLW1hYyB0byB0aGUgRlRHTUFDMTAwIGNvbXBhdGlibGUgbGlzdCwg
d2hpY2gNCj4gPiByZXF1aXJlcyB0aGUgZmFyYWRheSxmdGdtYWMxMDAgZmFsbGJhY2suIEl0IGFs
c28gdXBkYXRlcyB0aGUgUk1JSSBSQ0xLDQo+ID4gY2xvY2sgZGVzY3JpcHRpb24gdG8gaW5jbHVk
ZSBBU1QyNzAwLCBhbmQgYWxsb3dzIHRoZSByZXNldHMgcHJvcGVydHkNCj4gPiBmb3INCj4gPiBB
U1QyNzAwIGluIHRoZSBzYW1lIHdheSBhcyBmb3IgQVNUMjYwMC4NCj4gPg0KPiA+ID4gZGlmZiAt
LWdpdA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZhcmFk
YXksZnRnbWFjMTAwLnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gPiBpbmRleCBkMTQ0MTAwMThiY2Y2
Li5iZWU5NTcwYTZmNjNmIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAwLnlhbWwN
Cj4gPiA+IEBAIC0xOCw2ICsxOCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiAgICAgICAgICAgICAg
ICAtIGFzcGVlZCxhc3QyNDAwLW1hYw0KPiA+ID4gICAgICAgICAgICAgICAgLSBhc3BlZWQsYXN0
MjUwMC1tYWMNCj4gPiA+ICAgICAgICAgICAgICAgIC0gYXNwZWVkLGFzdDI2MDAtbWFjDQo+ID4g
PiArICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNzAwLW1hYw0KPiA+ID4gICAgICAgICAgICAt
IGNvbnN0OiBmYXJhZGF5LGZ0Z21hYzEwMA0KPiA+DQo+ID4gW1NldmVyaXR5OiBMb3ddDQo+ID4g
V2l0aCB0aGlzIHBhdGNoLCAiYXNwZWVkLGFzdDI3MDAtbWFjIiwgImZhcmFkYXksZnRnbWFjMTAw
IiBiZWNvbWVzIGENCj4gPiB2YWxpZCBjb21wYXRpYmxlIHBhaXIuIEhvd2V2ZXIsIGF0IHRoaXMg
Y29tbWl0LCBmdGdtYWMxMDBfb2ZfbWF0Y2hbXQ0KPiA+IGluIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ZhcmFkYXkvZnRnbWFjMTAwLmMgaGFzIG5vIGFzcGVlZCxhc3QyNzAwLW1hYw0KPiBlbnRyeS4N
Cj4gPiBTdWNoIGEgbm9kZSBjb3VsZCBvbmx5IGJpbmQgdGhyb3VnaCB0aGUgZ2VuZXJpYyBmYXJh
ZGF5LGZ0Z21hYzEwMA0KPiA+IGVudHJ5IChGVEdNQUMxMDBfRkFSQURBWSkuDQo+ID4NCj4gPiBP
biB0aGF0IHBhdGgsIGZ0Z21hYzEwMF9wcm9iZSgpIHdvdWxkIGRvIHRoZSBmb2xsb3dpbmc6DQo+
ID4NCj4gPiAgIC0gcHJvZ3JhbSB0aGUgcmluZy1lbmQgYml0cyBhdCBCSVQoMTUpIGluc3RlYWQg
b2YgdGhlIEFzcGVlZCBCSVQoMzApDQo+ID4gICAtIGxlYXZlIGlzX2FzcGVlZCBmYWxzZSwgc28g
ZnRnbWFjMTAwX3NldHVwX2NsaygpIG5ldmVyIGNsYWltcw0KPiA+ICAgICBNQUNDTEsvUkNMSw0K
PiA+ICAgLSByZWdpc3RlciB0aGUgZW1iZWRkZWQgTURJTyBidXMgdGhyb3VnaCBmdGdtYWMxMDBf
c2V0dXBfbWRpbygpDQo+ID4gICAtIG5ldmVyIHNldCBhIERNQSBtYXNrIHdpZGVyIHRoYW4gMzIg
Yml0cw0KPiA+DQo+ID4gV291bGQgYW4gQVNUMjcwMCBub2RlIHdvcmsgY29ycmVjdGx5IGlmIGl0
IGZlbGwgYmFjayB0byB0aGUgRmFyYWRheQ0KPiA+IG1hdGNoPw0KPiANCj4gU291bmRzIGxpa2Ug
bm8sIGNhbiB0aGUgc3VibWl0dGVyIHBsZWFzZSBjbGFyaWZ5IGlmIHRoZSBmYWxsYmFjayBpcyB2
YWxpZD8NCj4gDQoNCkFncmVlZC4gSSB0aGluayB0aGUgJ2FzcGVlZCxhc3QyNzAwLW1hYycgc2hv
dWxkIG5vdCBiZSBiYXNlZCBvbiB0aGUgJ2ZhcmFkYXksZnRnbWFjMTAwJy4NCk1heWJlIHRoZSBk
dC1iaW5kaW5ncyBwdXQgYXN0MjcwMC1tYWMgYXMgYSBjb25zdCBsaWtlOg0KYGBgDQouLi4NCnBy
b3BlcnRpZXM6DQogIGNvbXBhdGlibGU6DQogICAgb25lT2Y6DQogICAgICAtIGNvbnN0OiBmYXJh
ZGF5LGZ0Z21hYzEwMA0KICAgICAgLSBjb25zdDogYXNwZWVkLGFzdDI3MDAtbWFjICAgICAgICAg
ICAgIC8vIGFzIGEgY29uc3QNCiAgICAgIC0gaXRlbXM6DQogICAgICAgICAgLSBlbnVtOg0KICAg
ICAgICAgICAgICAtIGFzcGVlZCxhc3QyNDAwLW1hYw0KICAgICAgICAgICAgICAtIGFzcGVlZCxh
c3QyNTAwLW1hYw0KICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1hYw0KICAgICAgICAg
IC0gY29uc3Q6IGZhcmFkYXksZnRnbWFjMTAwDQouLi4NCmBgYA0KDQpUaGFua3MsDQpKYWNreQ0K
DQo=
