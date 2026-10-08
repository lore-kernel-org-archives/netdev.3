Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022121.outbound.protection.outlook.com [40.107.75.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23B485CDE;
	Thu,  8 Oct 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461425; cv=fail; b=XBhbXnYxGhm8Pn38Ux+Tdqfy9KDhqtQHmdAjlL++mCbut9xzEhAuNIfcT6hRWrwggYSFzU7US/KTMyO2dBcKdWJFEF0lHumUniU6qMrYpwlxuq4NPc1oS/6bnnDWXJp5m9GiHV0l3wEzAmJlSupUtIdRZcMfX65L8BHg+8e9TIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461425; c=relaxed/simple;
	bh=9fEM8ps5LIf3ZTSac8+HmQlWITzpnBY0fbfKyBylMk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSo3t0YL/3OkkZii7alVrJi/L/Jzkpi/YzHjRL/w/fMw9KlsstMWCjSnT2uWwVNSL8uB2YHyyGFPkLFwVBJ2yo1FVpDVu7OXAp+qKTycoHotUW7UuOLmmAtfXst3ePNp9R8ANkPV69PWsTZT4pcvIF9PdV7D3zeowdRzALrRmUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=eAqdmwXv; arc=fail smtp.client-ip=40.107.75.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="eAqdmwXv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVYJYWVW1Ec3Qcy7cWsSmh8L2Gr2q/p2rVj8nhXxr+gSwPhmBKaNQpIWV38tHs2qSET47KueW2TJzylnkGOowpt4gaXNhJBw+qgj8gNG/PrCZ/oBxXSpbZhx+VnI7nikCdd8zTkiEXzEJxpCnAjAU+V6z60SoY+tvW7Cng+LYHn4n2z42uATiRLoN4ZXixGDTu7loE1ufsTfQy90BlIWR0F3ixwX74asPwvMnYhEru+aiWKJnhkNAsEQs+Vrf+EA0YVxr8DXKF4PoNV0S1wG3J9jejzXQdzGEQ+hxjlQavcD26bSgavOIA3F2ZJ29IvdiLmzHC3+UX0y3N7R94Wmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fEM8ps5LIf3ZTSac8+HmQlWITzpnBY0fbfKyBylMk4=;
 b=JAeHGon2ZseggPVKor+G8msym8hCmnFc+NQNrDcpwReF283GWbU7PikLYRiStbauqZy+cCA7zljUybEUr+5DKjZY8/uQyl066E5Ur34BGZIzfWoZLpUAlGToXqCgeXuqEbV0DwUOWW6W4sZiPngwlFDaJB6g26s4m6BtxsSVpUrtqCUj/t+a0BoRCVcLTAb+KnB/3KGuZCVmb41/dpJvwnm4yTOUsP43DBWjElSToN1riHhV8994WsBs4BbIFcRjo0X4hvPcfWYeSLJInMqpTARBJQbgFriHk5ye0+dkebZBqUmcmbQ+1xdy071TzDqBOuAQjuUazMrVpY5jk/JfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fEM8ps5LIf3ZTSac8+HmQlWITzpnBY0fbfKyBylMk4=;
 b=eAqdmwXv6FjRskChZpUEbg30OdtLeIBbYkebreznk3A/70TfvxChuzQC5FNirrXbEM654lyPaxHPvGOrNops1Rjn/YI8+Lyev7tJhUhDTCiayipdRMYy7Ekh5+u3IW3cJxpMgg97nTh58VwhoktIrDMagBishdi3BzreymaBvvmRwRFxrzcNmls3sv5wnRwxFNPSby9QugBppV2FOu3TdvpTAVm7W0OyY+y0HpF6uQjkuMFkaSU48ZQC0dmFlowkvfpZs1yeyzal+pAF2rLZRS+zd+4D+vKQZPxuLLKhvCHHe2eyrXQyyRR+ZmsAqKvUNxMBkLcQJXz8H4Vi2C5/DQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5671.apcprd06.prod.outlook.com (2603:1096:101:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 12:10:20 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 12:10:20 +0000
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
 =?big5?B?pl7C0Dogpl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDMvNl0gbmV0OiBmdGdtYWMx?=
 =?big5?Q?00:_Enable_AST2700_RMII_support?=
Thread-Topic:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYyIDMvNl0gbmV0OiBmdGdtYWMxMDA6IEVu?=
 =?big5?Q?able_AST2700_RMII_support?=
Thread-Index: AQHdVWM4P9wWfb0NbkqBDOOqxARznLbwtY0AgAJpeMCAAG99AIAAAMWg
Date: Thu, 8 Oct 2026 12:10:20 +0000
Message-ID:
 <SEYPR06MB5134D3605CBEC9E5435DDDF49D932@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>
 <268b6bc5-40a5-47b4-99a2-68d9f56b359a@lunn.ch>
 <SEYPR06MB513454E3CF42CCB62402E7F59D932@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3eff4d4c-7376-4fc1-983e-396ccda08ef8@lunn.ch>
In-Reply-To: <3eff4d4c-7376-4fc1-983e-396ccda08ef8@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5671:EE_
x-ms-office365-filtering-correlation-id: 545a67c9-a5f7-456e-565a-08df25351f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|38070700021|10067099003|56012099006|4143699003;
x-microsoft-antispam-message-info:
 19kJL2t0i1INNaU2qBntwJdIunHwHbe2U1aGfuOoA6AkjeXiYn3TWm+9u7F65H6TBs206MF3K/cB2y4mCMQQUMXh+N2A/wkgcG6+Em69jZlYrD3NN9s0LZK4Lka4s9914I/Vgk/FhX2RV6azDaoMfQ7KfRx632kQW2NjJ4GMqIXQ0wCPZrQBwZAZggH0j3tOYczYac0Mu6eWTkLdGlXK9jQcN2NHWQHyj2siiPuUeA68VpuEN4+iT4GwkGWb2oCj0ATxCbjii9FxgjPRcj50xmpCZjfxIQRReTsm4AgJqUP0TiDmQ7pgIx/DDGir6sbLgq68lPA+MvIBrLMvthUdg2d0/Fsj5QssFpgb8q3mwUCFCzFhcw9mO6KOKC3oITDCNfhNqQb1ETi82dZprQOdqEQgJfhzy9ByP1IZOqQGDIrR5qskqPtnttSrVwuyTbhRgrnnX8g1UVSrxSvxOViKhL+m6SWmlAL5dtY/oa8ZElF6DMbqjfB/3jrH7sAAFl1h6iJVmhpchVEummnSnfysySQwm6Z/VpB8zmf7fW6Ba1E71VkUZsZ2Icg56Dp6rmREXIvjUIAgamnzl5MFO/Zt5hcp+P0IMDQ4Emq59C77doyfhaclbIzT4yDFQY7lga3wuRkRiqOyTyjhS9YSPVTRDk7Hjv5whfRmBqkaG5AfAgOQD52Vppgld/5hOyG7PVL69K4f3qWmGCKh8PydOVqUGavBtPxzDxo6XdeTy/AMiDo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?TTkzSjJSNXI4ZVAxSlFuR01SMlRHU0wzODRYemp6MVFra3J4QnB4QXVZVGpIdkJQ?=
 =?big5?B?RFp4OUJBVVliUmxzQlE1R2ptRjZ4eFRHdnBLSFNxV2FBNmdWOEM5QmpqaTgxMkNv?=
 =?big5?B?c3MzZStkaFhiUGxXbENIZXhtdVFDQWlSbkhVWVhJdFpqWXRZUmwwUU5jSlhOQkF4?=
 =?big5?B?cGdyZjRKOWxIaHFKNDBlYi9ySTlmeTI0UTlzVEg2OCt3QnVwUGp3NllySUJaMEVi?=
 =?big5?B?YWxwNC9vRkZwT01IMG90dnIyWnU0N0w4QzdkeUphTWNJRjQ0YmtuTjRuSzZQYXE5?=
 =?big5?B?V0UxNEtHYlRHWVE3ZUtrNTNyTkdmOE5RaTBobUJEOUdYc0JoQnhoNTFKU3hjK2U3?=
 =?big5?B?c0pnZVZWL2pEbUErS0ZaMU1EWUpzRndYN1NtcGJoVmpmVnpJWURlNGdXeWhhck9V?=
 =?big5?B?aUZvRE9XNStHQk5HSk1vR3hrZVVwWENIakMwZFo4c1ByRHRyc0VnUGRSUk9qVEwz?=
 =?big5?B?TXQwSnphYzFBM2dFdHNMNklvWTY3UVFjUEMwaU85OFNlY3RydlkrWUE3Y0tUL0s2?=
 =?big5?B?ZHZyQmVRVExZTmlIZzhCM3gvT0lDaFNQRDFMcEFkN09wSmFnYnBScjFNSzlQWTBI?=
 =?big5?B?MXVmUlg5MW9RUTFQK1d2N1cwYjF4MGFRcDd0RFFERVJ3VEhVQ3BjZDJJVTdnakg3?=
 =?big5?B?MkxCbWE5dStWc0d1cmZkVHMrV3VWWWFnOSs5UVhWTzNiaTY1d0YzZmtPbTFsOXZV?=
 =?big5?B?TVdtQnFKTHJRREQ5UFNUT0MzK0JHNHpYbFhtZHlTSmdhZnJ5TytXekRJZ3JKOUov?=
 =?big5?B?YkVzdE5OaWJodjhFR2VTRHZNUnhCZksxdlRiUzc0VW9zbnVUK2NvSWVaRnVTM0Jo?=
 =?big5?B?L2pQeUxkd2VJRzh0ZEtPWnNJL2ZGWWlPTmxPcDk5dm1DeUZuS2ZVSWJManRhbW9n?=
 =?big5?B?YlIzV1BpbXZMMHQ4OVhmcXh3Uk0ydXlUN1dabno2SnpRRFl0Tmh3akxVYnFLWE5R?=
 =?big5?B?SEs0TmxuamxydmN4WFNuSHB5K09uRlZlOUtGcWtaMFkrVlpFaC8rWTdLdCswMHpj?=
 =?big5?B?SElpaU16TVE1ODlhNzhOUlRsN3hURU1sYTZmR2ttU3Vkd0lFbEtnREpneHNIK0FR?=
 =?big5?B?SHlrN0QzTEtFR2RzV0xmUlZZU2NldjVMOW4xOXFkNkRPM0orbWV5YWozam1xS3p4?=
 =?big5?B?S09KbnFWUklTSWhUV0taQWFoeEtBRDhKVXlQU21GRCtlaHM1YzlzOVpscEY4MFJQ?=
 =?big5?B?dEdVN2tJdWQxektsbU9ValJNSzVGSENmaU8vLzJ0NDJIRzdxcnR2UTRyK3hhbWs2?=
 =?big5?B?R2w0dGc4NjRzMnRsMTErVjlOMWVObzNtbXBrWXcrZmZocnQybTl0SDJPa3l3N1Fq?=
 =?big5?B?V2dDVm1QNno2V3E4WlgvU2xRaDVsT2Q2WCs2V2VlcjlqcXFqNEZDWHRtOVpYWU5L?=
 =?big5?B?NDF2MFo5R05YVGZRQ2dobkdJY3psdHlDekp1STZTS0RBTmkvd21rZE1HUW00VEtT?=
 =?big5?B?WUovS3NyMnVBK1I0VVZFTDIxdmxXamgzd2hHQVFCY1NJclVpQjFjdVp2NGVjTDh1?=
 =?big5?B?UEhPbXo0Q1FnWWhRblJJaXdFNnNGNEN3ejE5TG5Cd0JKbm9QWThYbmFsWWFjUEpq?=
 =?big5?B?SU5VRFYrR3dXVG5ia2xaRTRDYVBPRFNGcTBYZVR0RmpjaTFHSmp5U1dwaUJmVmVI?=
 =?big5?B?TEUzWWFUK2s3aXVZNWZNZjM3VTBkYXY1U0hDNWljYTJrSU5TbE95SmVHM1JFV1ZP?=
 =?big5?B?SWtLclRQU2lUemxXLzE1dHR1aXduSWF2TmhGN1o5UTBZOFdDRERSOHBEYVlIL0Ir?=
 =?big5?B?NUR0WWVSbmxobE9qM3ZxRHFicjd5eG9hQmhKVUZsRXFuWS9XcURWNkFocFZRZkxy?=
 =?big5?B?bTJWMlVtb3dtcWRIOGxnR3BRb0MxSVpDQmc5SVVLVkM0Zm5DcjVhRFhyS1FzR3Vv?=
 =?big5?B?R20vSmtBZkdRQjdiWktiMGdraE1mcTNJbWVmZ3NqOGlROXZLL2Z3djlBUExDMktJ?=
 =?big5?B?QTc5NUdpWlFHdlRMMlpSdnFsdGc4WUJrdC91dDVsamg0S09VU3ovYVd5dUZlMytT?=
 =?big5?B?T3o4bUZPNWtXUU5OVzhmT3RlZC93Y2RUZGRtZVRiMjlpWVFKc0VjVnRsNWtPQklS?=
 =?big5?B?bFlVWkI5MCtzUFNySVRCVUpmL1FyR1BBOE9rZUR5WDN0RzRaeDlqSlhIdyt6bi9v?=
 =?big5?B?TlNPUEJIZll2d01IR3BvR2NnRWN1REtvZSttaXZkRGNuUmkwdFNzdjFwZlBXTWhH?=
 =?big5?B?SjdaWXRpYU01RVFDMzNUdG5XcGlvUT09?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	2ABmkPt+JNVV53uqBen18KrjtuD+GpLcDBFwb52mgXhL0ZXe2sYo6wp4WaGvXPC2fT7SXrCs/g3qOMcOLAAN6IdAr8vY+PtKJJ75lcUu5V6shZC0AXLej9UlXxGlEBMF57nBgoD075HHP9XfXBrTD0E3BZKc4SZzNFdLa5Ej8pC2N0cisQKjqNeBuE0GGq7QY1yluSv7zBahXIkGuFxjnPWt6tPKA9AMUqOwQNmfNhLnuR0kF/QDEatH5r5+f1qF/4xFbusXoO1spUpVn7ZhdCLx4hscpC5T0NSGbQLyx8qn3MKXWNEoXJPuyxj4mn8/b5AAn1yC+eheAK1+8IGBGQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545a67c9-a5f7-456e-565a-08df25351f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 12:10:20.2666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bl7DEgUBSAIWNRshVEg+9lebmOy+cmZE1v0ZPw2ZFutquWkmdGzYZUBtqqKHOBMvopOnEAxTfe6yGZ/gTWkwv/An8s9ZXLWEYwZNq+NmeBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5671

PiA+IFRoZSBhcHBsaWNhdGlvbnMgb2YgZGV2aWNlIHRyZWUgaW4gZnRnbWFjMTAwIGhhdmUgJ3Vz
ZS1uY3NpJywNCj4gJ2ZpeGVkLWxpbmsnLydwaHktaGFuZGxlJw0KPiA+IGFuZCBsZWdhY3kgbWRp
byBwcm9iaW5nIGZvciBBU1QyNDAwLzI1MDAuDQo+ID4NCj4gPiBUaGUgJ3VzZS1uY3NpJyB3aWxs
IGJpbmQgYSBmaXhlZC1saW5rIHBoeSBkZXZpY2Ugb24gc3BlZWQgMTAwIGFuZA0KPiA+IFJNSUks
IHNvIGl0IHdpbGwgaW5jbHVkZSBwaHlkZXYgZm9yIG5ldGRldi4NCj4gPiBUaGUgJ2ZpeGVkLWxp
bmsnIGFsc28gYmluZCBhIGZpeGVkLWxpbmsgcGh5IGRldmljZSBmb3IgcGh5ZGV2IGluIG5ldGRl
di4NCj4gPiBUaGUgJ3BoeS1oYW5kbGUnIHdpbGwgcmV0dXJuIHRoZSBhY3R1YWwgcGh5IGRldmlj
ZSBpbnN0YW5jZSBmb3IgcGh5ZGV2Lg0KPiA+IFRoZSBsZWdhY3kgbWRpbyBtZXRob2QgYWxzbyBy
ZXR1cm5zIHBoeWRldiBpZiB0aGUgTUFDIG5vZGUgaW5jbHVkZXMNCj4gPiBtZGlvIGluIGR0cyBh
bmQgZmluZCB0aGUgcGh5IGRldmljZSBieSBtZGMvbWRpby4NCj4gPg0KPiA+IFRoZXJlZm9yZSwg
aW4gdGhlIGN1cnJlbnQgY29kZSwgdGhlIGRldmljZXMgdHJlZSBkb2VzIG5vdCBpbmNsdWRlDQo+
ID4gJ3BoeS1oYW5kbGUnLCAndXNlLW5jc2knLCAnZml4ZWQtbGluayBhbmQgJ21kaW8nIHByb3Bl
cnRpZXMsIHRoZQ0KPiA+IGZ0Z21hYzEwMF9wcm9iZV9kdCgpIHN0aWxsIHJldHVybnMgMCBhcyBz
dWNjZXNzIGF0IHRoZSBlbmQsIGFuZCB0aGUgcGh5ZGV2IGluDQo+IG5ldGRldiB3aWxsIGJlIE5V
TEwuDQo+ID4NCj4gPiBBbGwgYXBwbGljYXRpb25zIGluIGZ0Z21hYzEwMCBtdXN0IGdldCB0aGUg
cGh5IGRldmljZSBoYW5kbGUsDQo+ID4gcmVnYXJkbGVzcyBvZiB0aGUgYWN0dWFsIHBoeSBkZXZp
Y2Ugb3IgdGhlIHZpcnR1YWwgZml4ZWQtbGluayBwaHkgZGV2aWNlLg0KPiA+DQo+ID4gSSB3b3Vs
ZCBsaWtlIHRvIGFkZCBhIHBhdGNoIHRvIGFkanVzdCB0aGUgZnRnbWFjMTAwX3Byb2JlX2R0KCks
IG9uY2UNCj4gPiB0aGUgZGV2aWNlIHRyZWUgbGFja3Mgb25lIG9mIHRoZW0gd2lsbCByZXR1cm4g
dGhlIGNvcnJlc3BvbmRpbmcgZXJyb3INCj4gPiBvciBubyBkZXZpY2UgZXJyb3IgdG8gbWFrZSBw
cm9iaW5nIGZhaWxlZC4NCj4gDQo+IFlvdSBjYW5ub3QgY2F1c2UgcmVncmVzc2lvbnMgd2l0aCBl
eGlzdGluZyBkZXZpY2UsIGUuZy4NCj4gDQo+IGFzcGVlZC1hc3QyNTAwLWV2Yi5kdHMNCj4gDQo+
ICZtYWMwIHsNCj4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiAgICAgICAgIHBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX3Jn
bWlpMV9kZWZhdWx0ICZwaW5jdHJsX21kaW8xX2RlZmF1bHQ+OyB9Ow0KPiANCj4gTm8gcGh5LWhh
bmRsZSwgbm8gdXNlLW5jc2kuDQo+IA0KPiBTbyBlbmZvcmNpbmcgdGhlc2UgbXVzdCBiZSBsaW1p
dGVkIHRvIDI3MDAuDQo+IA0KPiBJdCBsb29rcyBsaWtlIHlvdSBjYW4gdGVzdCB0aGF0IHNvbWUg
c29ydCBvZiBQSFkgaGFzIGJlZW4gZm91bmQuIEJ1dCB0aGVuIHBsZWFzZQ0KPiByZW1vdmUgYWxs
IHRlc3RzIHdoaWNoIGNoZWNrIHRoYXQgcGh5ZGV2IGlzIG5vdCBOVUxMLiBBbmQgaW5jbHVkZSBh
IGdvb2QNCj4gY29tbWl0IG1lc3NhZ2Ugd2h5IHRoaXMgaXMgc2FmZSBhbmQgd2lsbCBub3QgY2F1
c2UgcmVncmVzc2lvbnMuDQo+IA0KDQpUaGFuayB5b3UgZm9yIGJyaW5naW5nIHRoaXMgZGV2aWNl
IHRvIG15IGF0dGVudGlvbi4NCkkgd2lsbCB2ZXJpZnkgYWxsIGFwcGxpY2F0aW9ucyBydW5uaW5n
IG9uIHRoZSBBU1QyNzAwIGFuZCB1cGRhdGUgdGhlIGNvbW1pdCANCm1lc3NhZ2UgdG8gZXhwbGFp
biB3aHkgdGhpcyBjaGFuZ2UgaXMgc2FmZS4NCg0KVGhhbmtzLA0KSmFja3kNCg==
