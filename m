Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D94ACC9D;
	Thu, 15 Oct 2026 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064571; cv=fail; b=Y6/s11GchHBqnI2YiwSdYBZoe9rdpOKj90XFG1Qnzf6qtzG5jmTUOr7wvf5fOscK6Qq7xRGeqkurlOwInWvkrUTRhg/hRl9QanLlwek2Bu0pwedP6cj656Pthwp+v2i5GW0GbMorhT3edCReOfWUq/szG7FnVC3yeblBiAxHoeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064571; c=relaxed/simple;
	bh=SdJ9Jth8RgasDNJXfDDWz2qk1b2GCgQE6a/YUt2lgk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdBfUHhVX90YIjV4EmuSnLbAelPRuVqoeHWshpouVmbmijKY55ej93Wz3m0m29EtdYHGC+Set+NWjVpVt58HptwvpJePerpSU9kj1JDGiBeHSOi1XlNxtx3Ms1aBZB8yjaeeHaMac3QUlGES3ETFj0EtPDa6vqvmWLB0QHFWOPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wb67ZfL1; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wb67ZfL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsoZBxh47mqmJd+p1Li/5m7GX57TTiu8vE7M7qpbK2zfKvES+XXy4yKtBtD9m7G8qXbuWyH6TlGoY4EugqPPPG0p+YOaudQoyBaQo5z1vFzo0FItOV+vetiibAPtp6oBbUM9n23ux86dVunTCBXmhO+hrIOx8IYg1BaeZDNwI7i138zUObDg+pKGpSPOZwYzTmI1kR3uKedV/7j5kBrXomjStf7RDSthqSgFYJtGDaZMEXuvAzMlo0DLHB48B1Hdb0Dwfdsl8uNEYsC0h3c/sRLgOnyEbyG62jN3qlaP5FSF8G6tDZqauyMRH1zlvjD7OhXOsKjPSp2nhZud3xOu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdJ9Jth8RgasDNJXfDDWz2qk1b2GCgQE6a/YUt2lgk4=;
 b=DN3kFTKxcwUYfftkz5RhmhMytV0m1GdmE6O+0r853Rpodxw07FT8qXMTrLHFNOn+l1VhTCXvY0yjuKsrfco6l4Tf6FWGrQQa0inakI/YWc9qZ/ezuoIVda1TFJS/HRflg3gBp8cId8Og486ydNqaB/Ms81TcFpoVMLHu2c8sd+34iLczRuao9CD+R4Axjq35tIxOjb6glo31tfj1eUleHiTtZRsUDV+jXbI6N9SfHCV33ABMg/z75H8ntOEK6vSyOzlX1GfPw20adCOc88ihZFZ7jgVjNiB2HtTSWRJUKcS7fsf8GLKx8hmzJDcLmA21D/5Vt1Lbz8VnN+gNu6Sr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdJ9Jth8RgasDNJXfDDWz2qk1b2GCgQE6a/YUt2lgk4=;
 b=Wb67ZfL1jo3A5SV+aS6C3pZXv1XMR8zhqfAJSu9VRYaGGbEfHTB0zPR0sZC7k7zIzv7AaqcLFBWJNJlNQi8TM0Lgdll0Q0AhBk0cd+8UAH3u4vIsOtFyrNOCO5imV1tCzupzKrz5WBm78c00RPY1bPlV0V5H5qJYauLd8m6iuev8AiC98xNphl70Id+ZDE1/bh/0KLCGA14/rHoj7zDxoHux26IgaK/7eboXZTyD/Wx1rSsboCDALotZKgHSzdqiy/rrZ7IMC4xmdnANLmrtx+JXR/wcl2ICyHW8uEnaXBSZUKy+J90ypZdf8kcBHKDRnJchlVkA1QuPkfOVOem9rg==
Received: from LV2PR11MB184224.namprd11.prod.outlook.com
 (2603:10b6:408:411::20) by CH3PR11MB8775.namprd11.prod.outlook.com
 (2603:10b6:610:1c7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 11:42:43 +0000
Received: from LV2PR11MB184224.namprd11.prod.outlook.com
 ([fe80::368b:f908:7ba1:288]) by LV2PR11MB184224.namprd11.prod.outlook.com
 ([fe80::368b:f908:7ba1:288%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:42:43 +0000
From: <Manikandan.M@microchip.com>
To: <miquel.raynal@bootlin.com>
CC: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <aaro.koskinen@iki.fi>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v8 5/8] nvmem: layouts: add Microchip/SST SFDP EUI layout
 driver
Thread-Topic: [PATCH v8 5/8] nvmem: layouts: add Microchip/SST SFDP EUI layout
 driver
Thread-Index: AQHdW6cQ5k7UgM1OlkyPRTapc3up1Lb8u2KfgAHB4wA=
Date: Thu, 15 Oct 2026 11:42:43 +0000
Message-ID: <cd5cb3e9-ffda-40c9-9eb4-18d04abfd56d@microchip.com>
References: <cover.1790847519.git.manikandan.m@microchip.com>
 <89aa4ac1eee01e3c425c12367f1e036354787ce8.1790847519.git.manikandan.m@microchip.com>
 <87fqy8zmtd.fsf@bootlin.com>
In-Reply-To: <87fqy8zmtd.fsf@bootlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB184224:EE_|CH3PR11MB8775:EE_
x-ms-office365-filtering-correlation-id: 73cdd653-c53d-496f-2bfe-08df2ab16cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|56012099006|11063799006|261009223027099003|4143699003|18002099003|22082099003|6133799003|10067099003;
x-microsoft-antispam-message-info:
 6QA4EijBKorN/YlihHLvrp6/RLtr6uID3kqcoLYZNLFprm+n3yyEhS68OaFSoSMZ+TsgXIqx6G05WAYyCBsR2ebd2SCaWDswO4HpbjRIOsRRa382HnjQBoXhIBxchsSf0o18e2dxPlJTRQiM/8cHwpH2/iXiyse0Zh0uCMl2ya5m7kpY8MNV14tZb/3poN03xNrlOPJcCuAQsRUoUvpBNncQNLm2ztjd0Yvh/IesjclKnj9ucmiyRVjz6bd8LeUiIJrd74I0TSBQNGtpSThNwrfmT7RT8If6/J2itFx0XEqH+Kpv1yaz/Dg449e6nJx3x3/vpXSr5gHWeYmsljH4SVcbzcZzr0jkIuT1nQBvVcN+yJWYzOX03ge86jmRPU2Kyq+JmIxWWysTeA569dJUnMEkzeJ4ykJ0vxnpFNnGJslegx3fiSDikbQPQSItJfiW4E9v5R5X5KH6SAmsVQzOZ//inblSeBgK/YZY50QuzNI4w9enC71SKBVd1ku6CtHuT3Cwto684rQUxr3uQe2ap8c6GCRK0A3GqHUXBXGiyZsD8gsNAe7Km4rHPI+/Q4OmbCT+oSIFkSYVOP0oAPBBOSqoUzmMjdGLu5/fsZZm8wbwGWPARtXQX/nCPL8ipdC1kJQJ6Q0BfrFFglJi/yK2dTVVBDwHmZcLgdCzDFvDIkN68DpDvvSEwDh93z36Vzkp92HUN+y8+m+288xZnJa191nrRGsP6T9PCnTbBHcJnUs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB184224.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(4143699003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkZZaExjRFN6VG4vRlEzWWtudUJWeWZtSUF1dnhEMkJmS1pQZy8wM1FDZW9W?=
 =?utf-8?B?MGF4RWZpcjlNMUZRUTNZVkEzMlBaY1RaeGloWm1SczZSUnNPcU1HT0FHd3pl?=
 =?utf-8?B?ZUxnK2VjUnJzNnl0dmU1L3dLL2E2Ti83K2ZPb3VoQ25WamNhV3BRWnJIYTVT?=
 =?utf-8?B?Z2loRE1hMjcyb2dseTRHSWdLVDByTTVuMTZjWFk5U1RneEwrT3JFbW1QZWgr?=
 =?utf-8?B?OXU3UFdPUU9zUkMwRm9vZWFsQUR3WmEyRDgrMklMZ0tzWHhLd3lnU3NDOExJ?=
 =?utf-8?B?cHczZGk5YnN1MFE2Mkg5VTRpbWRpSjNIR3dJVVFzV2tvbTRON05vc3ZCLzRq?=
 =?utf-8?B?WnYwTUtPRElodWhUTkJjK1BUVERnTG5jVVhRLzh0UmlJZXRpbnZxTjBCNStU?=
 =?utf-8?B?Sm5PaGNQZWJXKzdXdG96ejZITis4eWJ2UEtENnNYR1lMcUNWT1dSd2NoWlRT?=
 =?utf-8?B?T05RbHZzeGh6R1JNdC9aeDlxRnAvQ3g2MmEvTDZrRUg4aTdtaWl5ZHVCTUc2?=
 =?utf-8?B?RnNJbXlXd3FGMndoZHRpdStWcjZGWTJCNXREWnFDdVNTaHFKS1M2MTlsbTJN?=
 =?utf-8?B?YmwrdXpiNDRyWitpMzAvSUhkblBmTjVpaGdnSVBCL3drQnlwcmluZG9BZ0dD?=
 =?utf-8?B?bXdTWFpuUStKbkJFM3hUSUp4d082Sk9lWUtjc21NZEUvbjRKQ3pqOWhYeFVp?=
 =?utf-8?B?ZUFOaGU1WlBxNHE2YytXeG42cjZ4NlFBb2JWL0I4TUl2RkpNSERZU0l1ZkhH?=
 =?utf-8?B?eDdrbXBkS01kVE0xblZCMFJqbHp6bEF0c25XRjc1dEkvT2FXKzNETjliMFRI?=
 =?utf-8?B?K1VvVkJZbU1MZisxZ1ZCRnRGUjRWOHlDT1VScFpTS0Y3cGtGUlhrNE5Uajho?=
 =?utf-8?B?N25FTEZEUlFMMUlYUVl5ck1IY2hWSGhBV3haUFJBeEJDTjJPMXhSbThDVHlt?=
 =?utf-8?B?OUd5bmFMNWhWSzNHdlo1SVZIYVlSYW01TkxpbjN6M2paS2NBV1p3bUp0UXd2?=
 =?utf-8?B?dHI3cTZJdThZdllXQTFqRWFDa3ZEcVYvYTh4OGl0UkVlWVhwTCtwOUhSd0w3?=
 =?utf-8?B?YytadFNpUm4yRWR5VmZrL2p0K1VsMmFlejJVUndTb1p2VG1MODBUdXl2Kzh1?=
 =?utf-8?B?K1M0M1lPYnB3VjI5a1psdUszS2wyNXF4VWR3by96eGpjOU55WXIwY0szRzhs?=
 =?utf-8?B?NkM3Nlp3QlhhbkJGNHB6cUNkTm16WEJJbzI5YitoanJNVzdQQm1CV24xRHhr?=
 =?utf-8?B?NmJucmhqTU5JbDBrV0lvMmRPZkRHSDRVL3FkVEMxTnRTb1N5UUJFZEtMZXhj?=
 =?utf-8?B?aEl3aDBzaDNwZFNWc0VQemZnU2dra3I2WnZDVTNjYzZsY25Sbko0M3FDUVhE?=
 =?utf-8?B?YzZobHB3UkFvaStKUGkyVUhOS1VTQjk1SjdlSEpIWFdNcjE2ZE1BUUpIRGVF?=
 =?utf-8?B?UWt3TUlUUnVidFdJcEw5WnNMb3JsakJTMERKZ29uWC9QMTdISzlEcDM2TVg4?=
 =?utf-8?B?YVJ0UzRCMVR1SGtGVjRuUElldXRDRXZaditOYTRQTlRrNkJqZFYrVTJFNmpP?=
 =?utf-8?B?QVU0R00zdTgzWWtpbU5TQWdTVjNYN3FObDlkaVNYZ3BzcWE2YjBudy9jckg4?=
 =?utf-8?B?VDU2S2NFV3lIMDI0YkxDamNYMUJ4VHRYUFJEMVp0L1htR1lyK25sRE5ZQS96?=
 =?utf-8?B?QWdEdGpDaDQ2U3o0Q21MMGlGbHQwKzB3UzViUXhjbkpDdjJERU1UWXBKSlVI?=
 =?utf-8?B?VThUVkZDU2JnNERtUVlmNmZDay8xVlNUWmxHVFpCQ2NaSVp4NmhqNHlIbWRa?=
 =?utf-8?B?dUdTWW9uMkQyVTJWSlNINUdKMnhGa2ZlQWhIVVF1Mk1EZ0RBdjZ4VUp2a25X?=
 =?utf-8?B?dGtHZG9wb0tyenlhOU55VWJzZFVISjlnWWI3SEprWlpBK0FmRlZ4Y3JLS1lQ?=
 =?utf-8?B?WjlhTVhBbGVDZ2NyR1VjdmFFVUN1aGtYR0hrOHRXdStnZkhXVWFoSzJLSXZU?=
 =?utf-8?B?Q1NOQStOeGIxMEs2d3lGd1hjeFVVYnlybXU1ZUNmK3J3UENFNGRRVFk4dHVX?=
 =?utf-8?B?ak1CMG53Q1lrSi9FQmJkU1lVaUo0REVsK2hYOTdxQlcwMnJiRWhudnl4aVRN?=
 =?utf-8?B?SWZ0b0RkT2VjTEdWK3I0ZDNyTUFrck5iT2RuNkFreHQxZUxwSXBCd21ZR2lK?=
 =?utf-8?B?cW8zS2NCVjkvemN5RTRmQVRPKzhxdWxuVjRuSHQ3RlZXd3ltT1J1ZzBLVlkz?=
 =?utf-8?B?T1BMYnc2RGtlQkdZZnY4YjJ6SXFMTUYrUkQ5R21JM3JqUmZncDRVelNQVEN3?=
 =?utf-8?B?QVhYOE53T0lLSEJMUTRNOHlrSUxTVWdnZXd5bmJJQUZjbFE1SHRxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E57F7E3C6044A6488B2291DF5AEB1FA3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB184224.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cdd653-c53d-496f-2bfe-08df2ab16cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 11:42:43.3009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LefeZpc4fdJhs7QJkF0G/pd9/DV/B70eWSXTR4hWS+Lj0XZ3IVGkkEgurXb28mYCpsb+MJW1X8kiaHEymXmGz6KnJ+VZa4WV7G7WTL4UwKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775

SGkgTWlxdWVsLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcg4oCUIGFsbCB2YWxpZCwgSSB3aWxs
IGZpeCBpbiB2OS4NCg0KT24gMTAvMTQvMjYgMjoyMiBQTSwgTWlxdWVsIFJheW5hbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+IE9u
IDE0LzEwLzIwMjYgYXQgMTI6MTA6MDkgKzA1MzAsIE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxt
YW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0KPj4gQWRkIGFuIE5WTUVNIGxh
eW91dCB0aGF0IGV4cG9zZXMgdGhlIGZhY3RvcnktcHJvZ3JhbW1lZCBFVUktNDggaWRlbnRpZmll
cg0KPj4gZnJvbSB0aGUgTWljcm9jaGlwL1NTVCB2ZW5kb3IgU0ZEUCBwYXJhbWV0ZXIgdGFibGUg
KGUuZy4gU1NUMjZWRjA2NEJFVUkpDQo+PiBhcyBhICJtYWMtYWRkcmVzcyIgY2VsbCwgZm9yIHVz
ZSBhcyBhIG5ldHdvcmsgTUFDIGFkZHJlc3MuIFRoZSB2ZW5kb3INCj4+IHRhYmxlIGlzIGxvY2F0
ZWQgYXQgcnVudGltZSB2aWEgdGhlIFNGRFAgTlZNRU0gZGV2aWNlIChubyBvZmZzZXQgaW4gRFQp
LA0KPj4gYW5kIGEgcmVhZF9wb3N0X3Byb2Nlc3MgY2FsbGJhY2sgcmV2ZXJzZXMgdGhlIExTQi1m
aXJzdCBieXRlcyBpbnRvDQo+PiBjYW5vbmljYWwgTUFDIG9yZGVyLiBCaW5kcyB0byBhbiAibnZt
ZW0tbGF5b3V0IiBub2RlIHdpdGggY29tcGF0aWJsZQ0KPj4gIm1pY3JvY2hpcCxzc3QyNnZmLXNm
ZHAtZXVpIi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8
bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBNb3N0bHkgbWlub3Igbml0cywgc2Vl
IGJlbG93Lg0KPiANCj4+IC0tLSBhL2RyaXZlcnMvbnZtZW0vbGF5b3V0cy9NYWtlZmlsZQ0KPj4g
KysrIGIvZHJpdmVycy9udm1lbS9sYXlvdXRzL01ha2VmaWxlDQo+PiBAQCAtNiw0ICs2LDUgQEAN
Cj4+ICAgb2JqLSQoQ09ORklHX05WTUVNX0xBWU9VVFMpICs9IGZpeGVkLWxheW91dC5vDQo+PiAg
IG9iai0kKENPTkZJR19OVk1FTV9MQVlPVVRfU0wyOF9WUEQpICs9IHNsMjh2cGQubw0KPj4gICBv
YmotJChDT05GSUdfTlZNRU1fTEFZT1VUX09OSUVfVExWKSArPSBvbmllLXRsdi5vDQo+PiArb2Jq
LSQoQ09ORklHX05WTUVNX0xBWU9VVF9TU1QyNlZGX1NGRFBfRVVJKSArPSBzc3QyNnZmLXNmZHAt
ZXVpLm8NCj4+ICAgb2JqLSQoQ09ORklHX05WTUVNX0xBWU9VVF9VX0JPT1RfRU5WKSArPSB1LWJv
b3QtZW52Lm8NCj4gDQo+IE5vdCBzdXJlIHRoaXMgaXMgb3JkZXJlZCBhbHBoYWJldGljYWxseSwg
c28gaW4gZ2VuZXJhbCBhZGQgaXQgYXQgdGhlIGVuZC4NCj4gDQo+PiArLyogU0ZEUCBoZWFkZXIg
YW5kIHBhcmFtZXRlciBoZWFkZXIsIGFzIGxhaWQgb3V0IG9uIHRoZSBmbGFzaC4gKi8NCj4+ICtz
dHJ1Y3Qgc2ZkcF9oZWFkZXIgew0KPj4gKyAgICAgdTggc2lnbmF0dXJlWzRdOw0KPj4gKyAgICAg
dTggbWlub3I7DQo+PiArICAgICB1OCBtYWpvcjsNCj4+ICsgICAgIHU4IG5waDsNCj4+ICsgICAg
IHU4IHVudXNlZDsNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBzZmRwX3BhcmFtZXRlcl9oZWFk
ZXIgew0KPj4gKyAgICAgdTggaWRfbHNiOw0KPj4gKyAgICAgdTggbWlub3I7DQo+PiArICAgICB1
OCBtYWpvcjsNCj4+ICsgICAgIHU4IGxlbmd0aDsNCj4+ICsgICAgIHU4IHBhcmFtZXRlcl90YWJs
ZV9wb2ludGVyWzNdOw0KPj4gKyAgICAgdTggaWRfbXNiOw0KPj4gK307DQo+PiArDQo+PiArI2Rl
ZmluZSBTRkRQX1NJR05BVFVSRSAgICAgICAgICAgICAgICAgICAgICAgMHg1MDQ0NDY1M1UNCj4+
ICsNCj4+ICsjZGVmaW5lIFNGRFBfUEFSQU1fSEVBREVSX0lEKGgpICAgICAgICAgICAgICAoKCho
KS0+aWRfbXNiIDw8IDgpIHwgKGgpLT5pZF9sc2IpDQo+PiArI2RlZmluZSBTRkRQX1BBUkFNX0hF
QURFUl9QVFAoaCkgICAgIGdldF91bmFsaWduZWRfbGUyNCgoaCktPnBhcmFtZXRlcl90YWJsZV9w
b2ludGVyKQ0KPj4gKw0KPj4gKy8qIE1pY3JvY2hpcCAodmVuZG9yKSBwYXJhbWV0ZXIgdGFibGUg
aWRlbnRpZmllcjogaWRfbXNiIDw8IDggfCBpZF9sc2IuICovDQo+IA0KPiBUaGlzIGlzIG5vdCBy
ZWxldmFudCwgd2Ugc2F3IGl0IGp1c3QgYWJvdmUgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXg0KPiANCj4+ICsjZGVmaW5lIFNGRFBfTUNIUF9WRU5ET1JfSUQgICAgICAgICAgMHgwMWJm
DQo+PiArDQo+PiArI2RlZmluZSBTRkRQX01DSFBfRVVJNDhfTUFSS0VSX09GRlNFVCAgICAgICAg
MHg2MA0KPj4gKyNkZWZpbmUgU0ZEUF9NQ0hQX0VVSTQ4X01BUktFUiAgICAgICAgICAgICAgIDB4
MzANCj4+ICsjZGVmaW5lIFNGRFBfTUNIUF9FVUk0OF9PRkZTRVQgICAgICAgICAgICAgICAweDYx
DQo+PiArDQo+PiArc3RhdGljIGludCBzZmRwX2V1aV9yZWFkX3Bvc3RfcHJvY2Vzcyh2b2lkICpw
cml2LCBjb25zdCBjaGFyICppZCwgaW50IGluZGV4LA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG9mZnNldCwgdm9pZCAqYnVmLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGJ5dGVzKQ0KPj4gK3sNCj4+ICsg
ICAgIHU4ICpkYXRhID0gYnVmOw0KPj4gKyAgICAgaW50IGk7DQo+PiArDQo+IEkgYmVsaWV2ZSB0
aGUgaWYgYWdhaW5zdCB0aGUgbGVuZ3RoIGlzIHdyb25nIGFuZCBzaG91bGQgYmUgaW52ZXJ0ZWQg
YW5kDQo+IHBsYWNlZCBoZXJlOg0KPiANCj4gICAgICAgICAgaWYgKGJ5dGVzICE9IEVUSF9BTEVO
KQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gU2luY2UgbGVuZ2h0
IGRvZXMgbm90IGNoYW5nZSwgcHJlZmVyIHRvIGJhaWwgb3V0IGVhcmx5Lg0KPiANCj4+ICsgICAg
IC8qIFNGRFAgc3RvcmVzIHRoZSBhZGRyZXNzIGxlYXN0LXNpZ25pZmljYW50IG9jdGV0IGZpcnN0
OyByZXZlcnNlIGl0LiAqLw0KPj4gKyAgICAgZm9yIChpID0gMDsgaSA8IGJ5dGVzIC8gMjsgaSsr
KQ0KPj4gKyAgICAgICAgICAgICBzd2FwKGRhdGFbaV0sIGRhdGFbYnl0ZXMgLSAxIC0gaV0pOw0K
Pj4gKw0KPj4gKyAgICAgaWYgKGJ5dGVzID09IEVUSF9BTEVOICYmICFpc192YWxpZF9ldGhlcl9h
ZGRyKGJ1ZikpDQo+IA0KPiBJcyBieXRlcyAhPSBFVEhfQUxFTiBhIHZhbGlkIHVzZSBjYXNlPw0K
PiANCj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiArDQo+PiArICAgICByZXR1
cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBzZmRwX2V1aV9maW5kX3ZlbmRvcl90
YWJsZShzdHJ1Y3QgbnZtZW1fZGV2aWNlICpudm1lbSwgdTMyICpwdHApDQo+PiArew0KPj4gKyAg
ICAgc3RydWN0IHNmZHBfcGFyYW1ldGVyX2hlYWRlciBwaDsNCj4+ICsgICAgIHN0cnVjdCBzZmRw
X2hlYWRlciBoZHI7DQo+PiArICAgICBpbnQgbnBoLCBpLCByZXQ7DQo+PiArDQo+PiArICAgICBy
ZXQgPSBudm1lbV9kZXZpY2VfcmVhZChudm1lbSwgMCwgc2l6ZW9mKGhkciksICZoZHIpOw0KPj4g
KyAgICAgaWYgKHJldCA8IDApDQo+PiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+
PiArICAgICBpZiAoZ2V0X3VuYWxpZ25lZF9sZTMyKGhkci5zaWduYXR1cmUpICE9IFNGRFBfU0lH
TkFUVVJFKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsgICAg
IC8qIFRoZSBudW1iZXIgb2YgcGFyYW1ldGVyIGhlYWRlcnMgKE5QSCkgZmllbGQgaXMgemVyby1i
YXNlZC4gKi8NCj4+ICsgICAgIG5waCA9IGhkci5ucGg7DQo+IA0KPiBucGggPSBoZHIubnBoICsg
MSA/DQo+IA0KPj4gKw0KPj4gKyAgICAgZm9yIChpID0gMDsgaSA8PSBucGg7IGkrKykgew0KPiAN
Cj4gYW5kIGhlcmUgdGhlIHVzdWFsIGkgPCBucGg/DQo+IA0KPj4gKyAgICAgICAgICAgICByZXQg
PSBudm1lbV9kZXZpY2VfcmVhZChudm1lbSwgc2l6ZW9mKGhkcikgKyBpICogc2l6ZW9mKHBoKSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHBoKSwgJnBo
KTsNCj4+ICsgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgaWYgKFNGRFBfUEFSQU1fSEVB
REVSX0lEKCZwaCkgIT0gU0ZEUF9NQ0hQX1ZFTkRPUl9JRCkNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgKnB0cCA9IFNGRFBfUEFSQU1f
SEVBREVSX1BUUCgmcGgpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgIH0N
Cj4+ICsNCj4+ICsgICAgIHJldHVybiAtRU5PRU5UOw0KPj4gK30NCj4gDQo+IC4uLg0KPiANCj4+
ICsgICAgIGluZm8ubmFtZSA9ICJtYWMtYWRkcmVzcyI7DQo+PiArICAgICBpbmZvLm9mZnNldCA9
IGJhc2UgKyBTRkRQX01DSFBfRVVJNDhfT0ZGU0VUOw0KPj4gKyAgICAgaW5mby5ieXRlcyA9IEVU
SF9BTEVOOw0KPj4gKyAgICAgaW5mby5ucCA9IG9mX2dldF9jaGlsZF9ieV9uYW1lKGxheW91dF9u
cCwgIm1hYy1hZGRyZXNzIik7DQo+PiArICAgICBpbmZvLnJlYWRfcG9zdF9wcm9jZXNzID0gc2Zk
cF9ldWlfcmVhZF9wb3N0X3Byb2Nlc3M7DQo+PiArDQo+PiArICAgICByZXQgPSBudm1lbV9hZGRf
b25lX2NlbGwobnZtZW0sICZpbmZvKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAg
ICAgIG9mX25vZGVfcHV0KGluZm8ubnApOw0KPj4gKyAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAg
ICBkZXZfZGJnKGRldiwgImV4cG9zZWQgRVVJLTQ4IGF0IFNGRFAgb2Zmc2V0IDB4JXhcbiIsIGlu
Zm8ub2Zmc2V0KTsNCj4gDQo+IFRoaXMgb25lIGlzIG5vdCByZWFsbHkgdXNlZnVsIGFueW1vcmUu
DQo+IA0KPj4gKw0KPj4gKyAgICAgb2Zfbm9kZV9wdXQobGF5b3V0X25wKTsNCj4+ICsNCj4+ICsg
ICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQoN
Cg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQo=
