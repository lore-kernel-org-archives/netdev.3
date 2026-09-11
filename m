Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C783A784E;
	Fri, 11 Sep 2026 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115859; cv=fail; b=gd7gh7rLc0l4Q61OjrRfd+bjPUTsUjqi/Ki4wd3QZ/IUfUaFhfforpGURFF2walF4GhGda+UjWPMpM06QeG2f/PZvmIiSCNb1mvIqVZfATAFrQdcuA77hyScFOY9+V2IixhUDi1VDsdybqohrlODmm+pJ97IW+l5IF5xl8lykdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115859; c=relaxed/simple;
	bh=UA6O7uDIHSplbsa/NtDjqfb4x56wO7gZXsFsYeaQ/Ao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmetvKhj+EPSiocw6Iiri/vJctKQbhlZ1HHmZObjygqQA7CAdFJo6I4S1QKQ/pLr5y3BYRqGuX5nZ1DOkK0OSij8J3BmU73vzuxsUm3tdIslqHaWHT5bhKm0nyuR/m+tUGVUFYyj1x7xOTlawujBDBA64vj1b3OOLYP6ZHffpj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yS+CA44v; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yS+CA44v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmxc9GG0wlGBX83xhJ4B9mq/Y+v4jJsh4EmE2ojOCnh4vjmUjunWkKKG3m4588L/svRpgafmJzili3p0nuqCidBhk4Fp6JQSGW2jClwXVEHNn+9AWxPAcnmUoZ7vlQ+SFleTpMp6HOc4P2IiOLMgQO/jwXn/2pnA7OJptLsKjv0hy+fm6Jb05Cq48rIq1BNfx9tW8t7DK3jT0aGHAGHQtwey03rA+ycFwNEOKlxFDK1fgVk2Gm/xrGHX1C2luSQvFWCarjhVvemg1deZOvk362B8rtQxDvzMOWqiR6OJrCgY+5wzbP0twtbweNv97Wd0msVQcc0FxmEzcscvujgB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA6O7uDIHSplbsa/NtDjqfb4x56wO7gZXsFsYeaQ/Ao=;
 b=G0rH8x5jyJGtXSn5yYOvTtVCdZLfh0ju2HH7apF2mMgNG+/BMbkzAvLltPBDOYPjKzG4ni2I1q3tU6gwg+r+rJpc9ZYgbiWhoKoJ+uZrUwWZtxiWbVsBO7Uw7OK1+sKlgOE/4rXSonQK+B7838OCvCOQITcqib3vICfRxEnEACfUeRNS+NFF77RP5HzarC1ViKHUBDHmeXIcsKpzuERj38jO7vyIcMlkBsS4qTrKI5OGRUEaEKmFzJoQykWvT2ChXit3eEAKtoMEfu803aEPPz5qaJp2njy77ssN3xTnVzT+pMMM+m6qpeMfXGh49+73AhsUJLtIZK1sR+730v051w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA6O7uDIHSplbsa/NtDjqfb4x56wO7gZXsFsYeaQ/Ao=;
 b=yS+CA44v/smueBC+4KZ36/N0FOHsiQnsq+VsuUArHUNXwrr8lQYPj4aCEWtBILOAyyRzEZw04g1fXpc35iBZXR4s42YTyl5c/W+aAe5RlT0Zyn+0rNGaRSJicviO32w4GbWDV0UQlNmd+gz+1GHDyIYdMPoNTaTzHmvVElPi1+6lGki/K3ZtbeVm0NOCANhwfnwqqg6sdL2lN04ixXsc6IWLTF9uwkiL6P0S8wsUQp/y5iiJ0z/poXhZD6onpq2GC/lzLvyZtgq0vRi+P9BQJxQvVypUSJIeRhWw928FKCY9WKK7U2NdaFH3rV6l2ofqA4ZyiOkANbOnltu74JjTuQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU4PR10MB9167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 08:37:24 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 08:37:24 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "hauke@hauke-m.de" <hauke@hauke-m.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: dsa: mxl-gsw1xx: deassert internal PHY resets
 before MDIO registration
Thread-Topic: [PATCH v2] net: dsa: mxl-gsw1xx: deassert internal PHY resets
 before MDIO registration
Thread-Index: AQHdP30Vzl7VbfjkJECNadZxXYxq1LbEgm0AgAFrcoA=
Date: Fri, 11 Sep 2026 08:37:24 +0000
Message-ID: <9c5f04b37e3a17a5ac900ad62021457d795840b3.camel@siemens.com>
References: <20260908103030.4032992-1-alexander.sverdlin@siemens.com>
	 <ap_p3hpoa1MII9pz@makrotopia.org>
In-Reply-To: <ap_p3hpoa1MII9pz@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU4PR10MB9167:EE_
x-ms-office365-filtering-correlation-id: 1a23d102-c340-44e0-0132-08df0fdfe752
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|55112099003|18002099003|22082099003|38070700021|56012099006|11063799006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 g2ciNsNo0HlPJDDTGu2LF2oW9fwwpo7mzWnNaffBEv5HuVJQGsGsJ+oWUZQ5ItnfmEL8tHT2gZeGxTYRxRtuwEk2fTnOb0aNUce86wW27Ve5YpjO84Ha+wrPfrFk4J1aMdNHr76W2tlaQCSD5O4SbtMsvYFl4QZKnTtrrlPMlNORAo11TL72vciLF2f5YdLBKjMiENIdSrpVA3gOB4YokJb6sS756QynXzHILBiqd1bOWIq39XnkIQ5hrPrFkmTp11UNnCTwahvRDSZxpH/OIuc0ksn3o+hZBGujKYVQ6KLysezIKb2Hglqc7vFosueuH8UODDUaQRrWa/fuXH1SwlU255Cg2Kgpa5onBCpnmMxOZA3cucizSqgBEh0ehEsZibKmt3sIgSoLtPZ5xzCpR+6s15TrNzPptE3VbTqdGqrFX2/uVX6c2Cv7w2lMiJHRtz9zbh8WYlzDFg98NA5uMBjmg4YqJw7eq5e6yfo9yDosucqoCiIK57gowsqLdXPfqILMThS3mMelgeM0/78zLJlCPd/AVB5l2Y0Ea1V+yHKut7/QCsa2Ld4TwCCp+qUoWHah51Cf/XYl59zLAmVE4m7fnCcXZofBysk/4Y69M9FZQFuSFHvvuVGHZwbvafRPq8gXZXiYdSjHH3NHxHUqXgcH5dwv/Gp7kyro8DkgkIc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEg4TWR6cUQ5Ymh4eDV4cVRwR1lTcG8yWVQxUm1OaTgyRHBtZnlUTlVXK21Y?=
 =?utf-8?B?WnFVMXhiZUZYQVZxSWFTUmdzUml6UWJXNXUwLzl3TzRJdWg5TFk1MHgvSFZ6?=
 =?utf-8?B?SzJzZGkxN3VFcU05TnVFNkJBT05vdTRKQWdkRGJySXBDV2NGK1dRYlJvamdW?=
 =?utf-8?B?eFNDV1lFbzNCWG1ocnVPd0NUZzl5bnFHVmgwbWdnVXdEZXcwNXk4VlUvQUcw?=
 =?utf-8?B?amNkT0VpSW1FM2FiSjBFWkYvVFp4UnVzOHE4anNBMWpaQ0c2ZzM1MkhOZmZN?=
 =?utf-8?B?VmQyZ3k1amgzUXkwM2IvNGtMcDNEUXJzZ1pPUWFXWVViUDRkRFV5c2NjbDBH?=
 =?utf-8?B?UzM2eGc2a0tKRVFJZ1M1SktPdWZpSEtBMkpqMjJzYytweXpkTVJtWkVDT3Rq?=
 =?utf-8?B?S3NGclorY0pXUFRyK3V6NklnUHRldzBQMkptRDAwRlJEVEs4UVRualR0QWgz?=
 =?utf-8?B?c2kwNlU3R2xib3pmK3BYRXRlSGZzRFlKSHhoZ2t1ZlVQR1FhbDVXU1U0SG82?=
 =?utf-8?B?VXovcGJCY2h0aXJoZHZqcjEvVWtXek5EWFNmeXVCRUZlVkdwNXVmY3h2S3NR?=
 =?utf-8?B?Y3dISGpwTEF2bUp4SURtazBsdVVNZDFpc01sdHpqWU5rQWFsa01xMk96QWRq?=
 =?utf-8?B?OVAxWmoxS3haUkdtbUZUY2dmZW9sU3FadUpzQjY0MUtNaWt5OEdsaDZFRkJj?=
 =?utf-8?B?ekNHUGFhS1h3U1ZGZVZYZEdMTHVQTFRvU09LWW1kaEh5Z3VUTTI1WUVUckli?=
 =?utf-8?B?d0d4Q2FtTDdmSkNONUJaQjFzYi81NFhyZkp0dC92UkVqVk4vQ0VDc3FZMnZl?=
 =?utf-8?B?MElTMy9yYzQvcTM3dU40L1lrMEltZzB5d3JVYTY0dHdkcWJvMitVZGZ0ME5s?=
 =?utf-8?B?UVF3eXBDTWc5RWJNVkRlUE5UT0RYNExMOWFrSkZrblhDRmNUYVFkV3ZSZkN0?=
 =?utf-8?B?Tm0xdUY2WWVTTWZTZjdlL3RkUEJRcUhZYnN1Wit6bXJMb2NOTUpXTHM0MVE5?=
 =?utf-8?B?UUZZUlJFSVU2NTFpenIxOEo4YlZteWZNT3J4emJDY0psOUZMSG1QZExQUnZP?=
 =?utf-8?B?SWZNK01hOExLK3JPeXZqUENBbUIzVkFkTmdIUzFPTDlHMnFvUTlpdjhTYXlC?=
 =?utf-8?B?MklOYytNbDhiTEZabWRVcmtXejhJUHN2Qm9ld25wRENJVFdPTXpadi9xUUJh?=
 =?utf-8?B?cTFvRWhVZWkvUFVJSDRWdStnZjZ0M29xNWRZQU55Q0ovbVF1K1FJbGhCaGlq?=
 =?utf-8?B?c0lHczVhYzVZaU1QN1pjbFI2b1RjV0lsMTlkNXhFRllFTCtJOGM0MDIwTlVD?=
 =?utf-8?B?Mk84OWNnMURiZFRiT2tWRTlxUk5OWmdLZ0ZMUHB1VnVyU2lLUXMxZzBBMkpY?=
 =?utf-8?B?VkF0UHJleldTcE81MHJOcmpzcEMrb2JLT2w1YW91K05zR2o0OXpLRmUreExy?=
 =?utf-8?B?THQ5b2VKQ2tsUkVrSkZxVFY1VkdBdTY3eVBoazFUSXBkZk9PWFYzbDczSklE?=
 =?utf-8?B?TGkzV1lRZlJhaFE3RGQ0UC8zeWlIS1E2VlNvM2p2ckQvVEtRUUFld3BzaUxj?=
 =?utf-8?B?Si9lUENJZG80bTROb09xSnM5UDhPRDR3eXhyNkF5bnpIZmtaaldPbXQrUGc4?=
 =?utf-8?B?UnBKWkMrQlVVcG0vZlpycklDU0dET0gxRHRjbTFzU21GVXJVWjBheWRjOFFq?=
 =?utf-8?B?enhPL3ZCNVBINEJSem45ZGIxeEViVkR2anNLeS80TGtXeVRzamMvSHN4SmlB?=
 =?utf-8?B?Rk5IajFnUllRVVpzZWVOZUhjeEFQUExLTjhYYXpId2pVVFBuTWF1MHRkb2tP?=
 =?utf-8?B?MUI5WFR4SCtOcTBMcy9EV1h5T2NOcWFDRGd1Q2lYRTlQSXhiV3VzK0Z2R3lp?=
 =?utf-8?B?c214cmJFbTEyNmhVRGJ3MnQ5dVBqb3ZYNFpXbEpSTUFNZ2JJY3Q3aWF4MUpO?=
 =?utf-8?B?SUtDbnNsbFFpaEV4c2Z1bVZwSTFNbm1hR3VHQXd6MWNWRmpIeWpackZ1cUps?=
 =?utf-8?B?OXc2Q0lSSW9IYzdORC8ybTE4T2RIRUozc1pjdW5YSEpkVDVMdmJjT3ZKWkZs?=
 =?utf-8?B?VDVYZjNRaERhcVBDSXBOdk1Fc0d1dzFpMnRnQ3p6c0xIWnZ1eldtK2xVUjE3?=
 =?utf-8?B?eXlLdXRWajZIVWZqSFU2bFRpejhEZmwzWjFSYmxvVEw4WVhLdGNLSnB6M2cv?=
 =?utf-8?B?S0cwcnU4aUh5UXhlK1V0WXlFelpGdGNoVGFER0VKeUF3VGp5ZnM4ekNrV0tT?=
 =?utf-8?B?dFEwQjZKeG5WSGFFN0cvUG5KakpTdjZqN0ROZk0zaUllQVdGVzh1RVZrUGhk?=
 =?utf-8?B?K0taZ1RiMW5SaWdDQ3VVdVJ5R09XVVFzNVhlMTZXdWliVzVkNHpHUHY5N2Fn?=
 =?utf-8?Q?zfkKX3sfqSmkYEIcp+yis3KOXmKznWNNPSCXYF3dagHWc?=
x-ms-exchange-antispam-messagedata-1:
 WwDvGrPYvgDehSvqef3rrtXNrYi4qT03CeR/s7ts3PSXLLlV1DQ5Wyn9
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A9793C4967B5A4DBF6F665DF3F6B0E2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a23d102-c340-44e0-0132-08df0fdfe752
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 08:37:24.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aylYVo9fQEiR9+IBVwfPqQATg2pbvKs5+1q/Mf1CbpoXYXZqZJD5wOoAze0lvQcmILUuNUQ45/Ri8urrc50NLoMDQG3mKZ11ONV9GgvmKQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9167

SGkgRGFuaWVsIQ0KDQpPbiBUdWUsIDIwMjYtMDktMDggYXQgMTE6NTYgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gPiBXaGVuIHRoZSBzd2l0Y2ggaXMgYm9vdHN0cmFwcGVkIHdpdGggUFNf
Tk9XQUlUID0gMCwgdGhlIGludGVybmFsIFBIWXMNCj4gPiBkZWZhdWx0IHRvIGEgaGVsZC1pbi1y
ZXNldCBzdGF0ZS4gVGhlIGRyaXZlciBwcmV2aW91c2x5IG9ubHkgd29ya2VkIHdpdGgNCj4gPiBQ
U19OT1dBSVQgPSAxIHdoZXJlIFBIWXMgYXJlIHJlbGVhc2VkIGZyb20gcmVzZXQgYXV0b21hdGlj
YWxseS4NCj4gPiANCj4gPiBEZWFzc2VydCB0aGUgUEhZIHJlc2V0IGxpbmVzIHZpYSB0aGUgUlNU
X1JFUSByZWdpc3RlciBiZWZvcmUgdGhlIE1ESU8gYnVzDQo+ID4gaXMgcmVnaXN0ZXJlZCwgc28g
dGhhdCBQSFkgSURzIGNhbiBiZSByZWFkIGR1cmluZyBidXMgc2Nhbi4gT25seSByZWxlYXNlDQo+
ID4gUEhZcyBmb3IgcG9ydHMgdGhhdCBoYXZlIGEgcGh5LWhhbmRsZSBpbiB0aGUgZGV2aWNlIHRy
ZWUsIHNvIHVudXNlZCBwb3J0cw0KPiA+IGRvIG5vdCBjb25zdW1lIHBvd2VyLiBBIHNpbmdsZSAz
MDBtcyBkZWxheSBhZnRlciBkZWFzc2VydGluZyBhbGwgbmVlZGVkDQo+ID4gcmVzZXRzIGVuc3Vy
ZXMgdGhlIFBIWXMgYXJlIHJlYWR5IGZvciBNRElPIGNvbW11bmljYXRpb24gKHJlZmVyIHRvIElu
dGVsDQo+ID4gWFdBWSwgTWF4bGluZWFyIEdQWTExMSBkYXRhc2hlZXRzIG9yIHRoZSBMYW50aXEg
Y291bnRlcnBhcnQgb2YgdGhlIGRyaXZlcikuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxl
eGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+ID4gDQo+
ID4gWy4uLl0NCj4gPiArc3RhdGljIGludCBnc3cxeHhfc2V0dXAoc3RydWN0IGRzYV9zd2l0Y2gg
KmRzKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZ3N3MXh4X3ByaXYgKnByaXYgPSBjb250YWluZXJf
b2YoZHMtPnByaXYsIHN0cnVjdCBnc3cxeHhfcHJpdiwgZ3N3aXApOw0KPiA+ICsJc3RydWN0IGdz
d2lwX3ByaXYgKmdzd2lwX3ByaXYgPSBkcy0+cHJpdjsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqcGh5X25wOw0KPiA+ICsJdTMyIHBoeV9yZXNldF9tYXNrID0gMDsNCj4gPiArCXN0cnVjdCBk
c2FfcG9ydCAqZHA7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWRzYV9zd2l0Y2hfZm9y
X2VhY2hfdXNlcl9wb3J0KGRwLCBkcykgew0KPiA+ICsJCXN0cnVjdCBwaHlsaW5rX2NvbmZpZyBj
ZmcgPSB7fTsNCj4gPiArDQo+ID4gKwkJLyogSXMgdGhlcmUgYW4gaW50ZXJuYWwgUEhZIG9uIHRo
aXMgcG9ydD8gKi8NCj4gPiArCQlnc3dpcF9wcml2LT5od19pbmZvLT5waHlsaW5rX2dldF9jYXBz
KGRzLCBkcC0+aW5kZXgsICZjZmcpOw0KPiA+ICsJCWlmICghdGVzdF9iaXQoUEhZX0lOVEVSRkFD
RV9NT0RFX0lOVEVSTkFMLCBjZmcuc3VwcG9ydGVkX2ludGVyZmFjZXMpKQ0KPiA+ICsJCQljb250
aW51ZTsNCj4gPiArDQo+ID4gKwkJLyogV2lsbCB0aGUgUEhZIGJlIHJlYWxseSB1c2VkPyAqLw0K
PiA+ICsJCXBoeV9ucCA9IG9mX3BhcnNlX3BoYW5kbGUoZHAtPmRuLCAicGh5LWhhbmRsZSIsIDAp
Ow0KPiA+ICsJCWlmICghcGh5X25wKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJ
b2Zfbm9kZV9wdXQocGh5X25wKTsNCj4gPiArCQlwaHlfcmVzZXRfbWFzayB8PSBHU1cxWFhfUlNU
X1JFUV9QSFkoZHAtPmluZGV4KTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoIXBoeV9yZXNl
dF9tYXNrKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCS8qIERlYXNzZXJ0IHJlc2V0
cyBvbmx5IGZvciBQSFlzIHJlZmVyZW5jZWQgYnkgYWN0aXZlIHBvcnRzICovDQo+ID4gKwlyZXQg
PSByZWdtYXBfY2xlYXJfYml0cyhwcml2LT5zaGVsbCwgR1NXMVhYX1NIRUxMX1JTVF9SRVEsIHBo
eV9yZXNldF9tYXNrKTsNCj4gDQo+IExpa2V3aXNlIGRvaW5nIHRoZSBvdGhlciBjaGFuZ2UgbWF5
IGFsc28gYmUgYSBnb29kIGlkZWE6DQo+IERpc2FibGUgdW51c2VkIFBIWXMgZm9yIGEgc3dpdGNo
IHdpdGggUFNfTk9XQUlUID0gMSBzdHJhcHBlZC4NCj4gSWUuIHVzZSByZWdtYXBfdXBkYXRlX2Jp
dHMgb24gdGhlIGludmVydGVkIHBoeV9yZXNldF9tYXNrLg0KPiBUaGlzIHdvdWxkIG1ha2UgdXMg
ZW5kIHVwIHdpdGggdGhlIGlkZW50aWNhbCBzdGF0ZSBpbmRlcGVuZGVudGx5DQo+IG9mIFBTX05P
V0FJVCBiZWluZyBzdHJhcHBlZCBvciBub3QuDQoNCk1ha2VzIHNlbnNlISBXaWxsIGRvIGluIHYz
Lg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29t
DQo=
