Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6086E45D920
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113771; cv=fail; b=PTaFhJmUd67l46tXpYINbt0eugyWAF5ZpoAo17MeDkaiXYZSTPT1K3KRsm048j4iFYbv5t6W9Gfn4KwRmkgNtu84DWlSwsuQUo2jaIwJGMjECU2OG2N9eAB8cW87xzjsYsqSfZTaIoNDcg4SGaUTO0Yk+FVYdPTgBceiDVIWNlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113771; c=relaxed/simple;
	bh=fawmpRFr4hfotpyy/ojCYfx0xISCDMdkopY/97+prOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjafur4Oq5VYNWUUvksFGGAlEHfOQnJJl59JGi4HmUbORpTeiRWAeDW5yd7Tzxmlg1yofoSmyyzJslZ+ZC5cEnJ4Iu/YNtlVmCs7CUcZWoDNq0KI9rKpInuKq0OID01rc9Seu/UQPRQew6MH5XQirQf1i+tAaAwyTDsyEPKpmOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Xzg3ls1K; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xzg3ls1K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zlv98olNMcolmLaE4MeGJ0qYC9VHRCfhWwpvlTWEYLxPtbhLF/qGKhnNs98Wi2EsEFzNHFCsVdSwNoH/9eWZ9nGV5aLTnStBHE7lLe1DDnbtIgrZKOVTBp6Vba3Adwif1DROKLn6JjrAvxgFRlpSOFeS503krOa2o/gf+79NBLUUC42BKzsnYagCL+JRa2NtJMzoFD3kP6eDgKFi6AgNcAomCHPRbzD2ifGknVevns0Z2kl5vSvqi+twh3lh9owhgOmkzqMZVxwRNK6D/yDAl5EqhH+vrNCfnZ2i4CxyipI/wDnoLpNEQqb79QV7D8lt/e5lbffzmgJeR1rv/dSW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fawmpRFr4hfotpyy/ojCYfx0xISCDMdkopY/97+prOY=;
 b=uikOBH+Wpyt17z/FxfmAlPPxdmzj5aqm6Pw22yJLoC5YEL9Xqwfj+HLmHx67S8ohPn8o/RKwmCIYps3t20DOdVV+dRCgqjQPKnPtJmoYcXwDBDhhcxLjKsaK57XrOiraKhpVaZSdGoph3MYNtMxJc922iMDsn7ux45aZhBnxp1H6FefoKGCL4ilxYjL8bEHrHGL/WPsC1n6zdBGP9yM/0mbh/V+X3d5gOzTOMhUHDP5ZU3NAMzUNw61mRy5WccX+mqLwpYSOHE3HnbyygFH5VXrenUo7q8j00QOo/L7Ge6JnJOVRJQpxbrZyzGEGXYvlmHEqjX+dv0E+h0ca5qelxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fawmpRFr4hfotpyy/ojCYfx0xISCDMdkopY/97+prOY=;
 b=Xzg3ls1KzPUCE0oVsmzoeiLXZcVk+MGu9TRe/Y55QIR3qH0mijG8njpBuGfKQw1QB6LhezNXR/ggR/1W4COQX+LVlUk4m4eHsdYsrXtcMeVtqii0vaxakQYjoqwe9XI3rRcx7DCbAXx4MwuXYr/Au2GmiESBzEUMrhMnHEUysaw5+u2ET369CydPoA6dH64Wm0FhvKsioRwpvokHbiRIi5IIRZ08MG6JuiRQ5Fo+TBLRH1Qzdb/500Onbi6OW30AgCq/IYaPp/HsU28HF0kx8X/3E4FHxvGZhvmi4t+ncKZfvpyuMXuzUkGyNvU8KKkicVnx9nJW92RJRGep4SrqNw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by BR2PR04MB325065.eurprd04.prod.outlook.com
 (2603:10a6:2c8:7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:02:45 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 08:02:45 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Wei Fang <wei.fang@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Topic: [PATCH v4 net-next 13/15] net: enetc: implement
 ndo_set_rx_mode_async for ENETC v4 VF
Thread-Index: AQHdQEcm+ZA6TK/2NUaXUOXwDyCWibbHoDIAgAFnF+A=
Date: Fri, 11 Sep 2026 08:02:45 +0000
Message-ID:
 <GV2PR04MB117394E2003D6EEA7EBD9111B88BE2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
 <20260909100733.1139689-14-wei.fang@oss.nxp.com>
 <20260910103729.2ECA91F000FF@smtp.kernel.org>
In-Reply-To: <20260910103729.2ECA91F000FF@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|BR2PR04MB325065:EE_
x-ms-office365-filtering-correlation-id: 22f9d063-05cd-4ac9-2489-08df0fdb101a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|23010399003|1800799024|38070700021|10067099003|6133799003|3023799007|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 7hSDfnfmN/K8onO/jlhw45EmvxJiwAEHsqMkk6gMR9Yzz2we/kG4NDSkM10Opbba4x9JhFM3JxDsxoTL66o0kd+jZjO9wWPq+hbbwKfWnSOhhSM6cAYRfkJKgVaYIM7aos/KrLt/pnXvLwmnDVV/UX4WYAClzdNCrd3LGhXsJ0xJqCuozOne3OJGWr7I/gX58XN1usYAe6tC/pidSxMPpIYLzMfh/bf/ctXMOOkbO41Rxt/D0xmwqjK02fB/Q/azOrqtf/ReEZb6kGPiimG7BfI5sWb1plyMmT89x0e9bERFCl0BNorob5wipt6C2f/oUnl5Sl+xYZvLAWcUZbsnITTOVImyajMERXewqgCeVdX6PqDbyjT8pj78UbXNxGURjjvgJIKvcdg+G6ltqjvxW0CCMab3fyjorpUHPYzJxOV7s9/E9m01WwFw0Jy2zf/3GRm+WPEJDlCxnE80c9l5ZT9sR5F0SCFzK5fqol2vL00L7M03mZddiB9DfyFP7ysjy8wyY/3GXUra0rBTyNwA5JdM8/HLsAPG0zj7811dQrIrtPtrSzGgTvHkK6fAnk7TPdHVA8cryOsGZSgdL1EkgAHxRzyT9rgVNcmMS85eyV7+ucbrYy0M5S2qH5pjt9D9xICceJZUQlWngsUGT8nHPwz5N7mSWy8bKsIKfAe5XOig/7OQDgQGJpO0sCA0BF8k34x0A5Iui4mb/Bg/1yJRFk5XSSvQzQtut6/0z9ILJVQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(23010399003)(1800799024)(38070700021)(10067099003)(6133799003)(3023799007)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dERCUXhwQU9UTUhXN1Y3QWIxOGF3VFhzQ2RyemJHNk9SWG1MdWR3a0s2ZnpW?=
 =?utf-8?B?NlJEZGR1SVpZb2xkOHBtaGtYYk1BL0xmTUtoNG5KdTNMaTZpQmQ0S3hGZnNJ?=
 =?utf-8?B?SFF6aHdiTGxreG9iN3ZYUkY1cmNhOEpkaGNFQUtUTlYzRFBBeXJEd0Y5UzZH?=
 =?utf-8?B?M1JYeFZYTWFHQncvQmt0bTNuWGZHTzJEZWllcFVPak1icVhrVUR0VlZoQVJL?=
 =?utf-8?B?K0VpZDJpY0Q4YXBZcGhnVXBHbkJmQ1NybWZmSHYrVjlwai9qQXMza0RKbzhJ?=
 =?utf-8?B?REJmdm5keUNHUHY3emsxWU80dTFkRitIZ1R5a1V6bzhkcnk2RW1LeHFoMkxN?=
 =?utf-8?B?YnNVT1FiaEFBRk1pLytKSzY4NTBBdUFucW16NENvOC9UeWxYZ2NTc0l0QTBt?=
 =?utf-8?B?Zk1WS0prTXFza2NHdEU2aFJEa2QvcHhXNmxvR2NaMkduVUk3d2lVZ000QU5r?=
 =?utf-8?B?NForb1p6ME94cDh2cmdONm5oRlBYRlF1ZUJXZnZ3aWlramR4a3ZLekZLSjds?=
 =?utf-8?B?Q1hUUWlVMngxaVk2R3A2RWNxL1NrLzNJNkI0ekxHbWJweUdYdjU0SXNuSVJN?=
 =?utf-8?B?NWgyRXVFZ1grOCtZN2dHZ2hSR2dlTHAydGZ3SmQ3akpVSmVHWmo5cjJWTC84?=
 =?utf-8?B?NXNTUzlmZW5FZzRmZUpkLzRhWlFwajh0aFRVMTZkZnNXMWdpa3JWQW1xYWFH?=
 =?utf-8?B?K1crc01rMmQ1eUpOc3JQSDRETTZXK3hhWDVTTVMyZTYrdTRCY2hEVzZ3SjFM?=
 =?utf-8?B?RkJDUUNjZjZ6MmV1M0RkNU9jMDBXOFFTa0RkRDlwRzNnaTU4SmRVTGhrSFN3?=
 =?utf-8?B?UXlVMDhJWDB5K3N0RkkxRzRhQk9KNGgwSXd5SkJ4MHIrUFJ3NG1Sbi9Ea21p?=
 =?utf-8?B?Y294VUxHYWJEZWUxWFhNWXY5Y1AweVB6N2E2UkhrQkFYR1NKS09oMmFNVlpk?=
 =?utf-8?B?THROYncvMUt1cjRvdDNFRTdxcUhjaUlGQ1BmeCsyaG1STnFEeWFXV3gwUU5U?=
 =?utf-8?B?ZmNXdThQUGZMUi9WYW5HQ04wZUN3K25DQzdZTUNERm44V2twYUdqWWFmUVJq?=
 =?utf-8?B?Z3JKVGt5WWlBYlFXVG5GQ0tPa2M3Z3hmTXNoTlhiZUtNQ2w0dFFtb0J1d3o5?=
 =?utf-8?B?YkhyUEI3b21JSkNrditjQ3MrUkF2U2lEQ0tBV2ZQK0xNOEZyNmd2bkVaRklP?=
 =?utf-8?B?NlNVRGVWSlZ3WVp1OW9qSTNFTnJvWlJBT2NQWEUrVms0V3FVVENKZ25qTUho?=
 =?utf-8?B?UEd5ckZvempSelRFQVd0Y2JEV29HK2tJbzFKR1B0V05VRVNqYk9jaFJKOGhm?=
 =?utf-8?B?VWlnWjY0YU5FOTNHZWIrRjVJWFpkdWduU29vbDBWU1pnVkpSeVVZclU5T2k0?=
 =?utf-8?B?cTJhQnFGVzBzcERBK2htUVZ6WkwybEc0alBDOXdsZ011RjNCUnh2QzdKbkpy?=
 =?utf-8?B?YmZXMDlYVWtsdW1ZZDhIajZWUWJlVGxaSDJhU1lmdm03ZUg4aGhBUDl1aHlM?=
 =?utf-8?B?N1R3YTN5NHlYS1RSTEJNdithb1QxVURjalZBWHc0S3BSUVFRckxNYkZsWWw5?=
 =?utf-8?B?eU15ZVZRazNxZ1BrWDB5SU5SNkdrWTJXVzJiVVBnSlIydko1K1NObUhWdmxm?=
 =?utf-8?B?S0w1UXF0aWp3L2tacnJnbm5HOUlHRWVNV2JzOW1ENGhhSGtYNEtGdWJDM3l5?=
 =?utf-8?B?cjFjUzNaZnU4LzNObDNvalJhaXEzMDdTcmpENkVpT0w3TVQwNWRmVnIxSFRK?=
 =?utf-8?B?L3Y0WWxsSm9QQVdyajNDSloxamMrZWRFZWpRemVUL21MZVkxQXlyMkx1RzF1?=
 =?utf-8?B?Y2lRd2UxZy8vK1UreDZGWnBIU1dsWE9QRDJOSXVFT3NlV0ZjRTRXREU0amF6?=
 =?utf-8?B?VEEvd2o3Z0NZV1dIek5zbGxuZG1NSGlRREF1TEs4NUUwRVpaZXFsUjA5SVcy?=
 =?utf-8?B?YWJLMk9VV05ubGhnMzJvV2dwdnlwb2dTMnl3Rk1KTFJQTGlaWDNSZHdkRzFG?=
 =?utf-8?B?ZjRWUnFUMDdieFZ1QXp0ektTbnR1bkNVZUl5RFFla0pmMnc3REdhWTMzU1Jt?=
 =?utf-8?B?emRDa1hoYXN3Z2x0akFaTlhsYmtzdDJRcmY5Wkh0a2N6TVB3dTVWMDBCam1K?=
 =?utf-8?B?YmhXbldxOGZOakx4Y0tlazZmL3A4aVlEbXBQL1FLMUplWlZOREpyK0NwWEx1?=
 =?utf-8?B?anBYd21hZng4THNhNzg1NjMwUEZQNElwdnhEcmo4cVFqRm1Xc0l6Zlc3Yk80?=
 =?utf-8?B?aWw4QzBXdjBjWGxVWk85QzRtOFpoQ0lRL2N0SUFHbExpMXZua2RLWGlrK1R0?=
 =?utf-8?Q?RT6Dqko31PX2T9NGBh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9d063-05cd-4ac9-2489-08df0fdb101a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 08:02:45.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJL8+vjDXi//09lwAx5R788+bl5xanU0MSvU20RP1MR9x6GI6e4bKHNeyNJ1tJrQVwSSjY9/eR+dKmG4ZUiiXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB325065

PiA+ICtzdGF0aWMgaW50IGVuZXRjX3ZmX2VuYWJsZV9pZmZfcHJvbWlzYyhzdHJ1Y3QgZW5ldGNf
c2kgKnNpKQ0KPiA+ICt7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWVyciA9IGVuZXRj
X3ZmX3NldF9tYWNfcHJvbWlzYyhzaSwgRU5FVENfTUFDX0ZJTFRFUl9UWVBFX0FMTCwNCj4gPiAr
CQkJCSAgICAgICB0cnVlLCB0cnVlKTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJZGV2X2Vycigm
c2ktPnBkZXYtPmRldiwNCj4gPiArCQkJIkZhaWxlZCB0byBlbmFibGUgcHJvbWlzY3VvdXMgbW9k
ZSwgZXJyOiAlcGVcbiIsDQo+ID4gKwkJCUVSUl9QVFIoZXJyKSk7DQo+IA0KPiBbU2V2ZXJpdHk6
IE1lZGl1bV0NCj4gV2hlbiBleHBlY3RlZCBwZXJtaXNzaW9uIGRlbmlhbHMgb2NjdXIsIGRvZXMg
dGhlIHVuY29uZGl0aW9uYWwgdXNlIG9mDQo+IGRldl9lcnIoKSBvdmVycmlkZSB0aGUgaW50ZW5k
ZWQgc2lsZW50IGZhaWx1cmUgcGF0aCBpbiB0aGUgdW5kZXJseWluZw0KPiBtZXNzYWdlIHNlbmRl
ciwgY2F1c2luZyBsb2cgc3BhbT8NCj4gDQo+IElmIGFuIGFkbWluIGhhcyBzZXQgSUZGX1BST01J
U0Mgb3IgSUZGX0FMTE1VTFRJLCBhbnkgc3Vic2VxdWVudA0KPiB1bnByaXZpbGVnZWQgdXNlciBh
Y3Rpb24gdGhhdCB1cGRhdGVzIG11bHRpY2FzdCBsaXN0cyAoZS5nLg0KPiBJUF9BRERfTUVNQkVS
U0hJUCkgdHJpZ2dlcnMgYSBuZXRkZXYgcnggbW9kZSBzeW5jLCByZXN1bHRpbmcgaW4gYSAtRUFD
Q0VTDQo+IGFuZCBhIGxvZyBwcmludC4gQ291bGQgdGhpcyBiZSB1c2VkIGJ5IGxvY2FsIHVucHJp
dmlsZWdlZCB1c2VycyB0byBjYXVzZQ0KPiBhIGxvY2FsIERvUyBvciBsb2cgc3BhbSBvbiB0aGUg
VkY/DQoNCk5vdCBhIHJlYWwgcHJvYmxlbS4gVGhlIHJlcXVlc3QgaXMgc2VudCBieSB0aGUgVkYs
IHRoZSBkZW5pYWwgcmV0dXJucyB0bw0KdGhlIFZGLCBhbmQgZGV2X2VycigpIGxvZ3MgdG8gdGhl
IFZGJ3Mgb3duIGRtZXNnIOKAlCBhbnkgc3BhbSBvbmx5IGFmZmVjdHMNCnRoYXQgVkYsIG5ldmVy
IHRoZSBQRiwgaG9zdCwgb3Igb3RoZXIgVkZzLiBOb3RoaW5nIGNyb3NzZXMgYSB0cnVzdCBib3Vu
ZGFyeSwNCnNvIHRoZXJlIGlzIG5vIGxvY2FsIERvUy4NCj4gDQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGVycjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBlbmV0Y192Zl9kaXNhYmxlX2lm
Zl9wcm9taXNjKHN0cnVjdCBlbmV0Y19zaSAqc2ksDQo+ID4gKwkJCQkJc3RydWN0IG5ldGRldl9o
d19hZGRyX2xpc3QgKnVjLA0KPiA+ICsJCQkJCXN0cnVjdCBuZXRkZXZfaHdfYWRkcl9saXN0ICpt
YykNCj4gPiArew0KPiBbIC4uLiBdDQo+ID4gK3N0YXRpYyBpbnQgZW5ldGNfdmZfZW5hYmxlX2lm
Zl9hbGxtdWx0aShzdHJ1Y3QgZW5ldGNfc2kgKnNpLA0KPiA+ICsJCQkJCXN0cnVjdCBuZXRkZXZf
aHdfYWRkcl9saXN0ICp1YykNCj4gPiArew0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwll
cnIgPSBlbmV0Y192Zl9zZXRfbWFjX3Byb21pc2Moc2ksIEVORVRDX01BQ19GSUxURVJfVFlQRV9N
QywNCj4gPiArCQkJCSAgICAgICB0cnVlLCB0cnVlKTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiAr
CQlkZXZfZXJyKCZzaS0+cGRldi0+ZGV2LA0KPiA+ICsJCQkiRmFpbGVkIHRvIGVuYWJsZSBtdWx0
aWNhc3QgcHJvbWlzY3VvdXMgbW9kZSwgZXJyOiAlcGVcbiIsDQo+ID4gKwkJCUVSUl9QVFIoZXJy
KSk7DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gV2lsbCB0aGlzIGFsc28gY2F1c2UgbG9n
IHNwYW0gd2hlbiBtdWx0aWNhc3QgcHJvbWlzY3VvdXMgbW9kZSByZXF1ZXN0cyBhcmUNCj4gcHJl
ZGljdGFibHkgZGVuaWVkIGZvciB0aGUgc2FtZSByZWFzb25zIGFzIGFib3ZlPw0KDQpTYW1lIGFz
IGFib3ZlLg0KDQo+IA0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiBbIC4u
LiBdDQo+ID4gK3N0YXRpYyBpbnQgZW5ldGNfdmZfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZp
Y2UgKm5kZXYsDQo+ID4gKwkJCQlzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqdWMsDQo+ID4g
KwkJCQlzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqbWMpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBlbmV0Y19uZGV2X3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihuZGV2KTsNCj4gPiArCXN0cnVj
dCBlbmV0Y19zaSAqc2kgPSBwcml2LT5zaTsNCj4gPiArCWludCBlcnI7DQo+ID4gKw0KPiA+ICsJ
aWYgKG5kZXYtPmZsYWdzICYgSUZGX1BST01JU0MpDQo+ID4gKwkJZXJyID0gZW5ldGNfdmZfZW5h
YmxlX2lmZl9wcm9taXNjKHNpKTsNCj4gPiArCWVsc2UgaWYgKG5kZXYtPmZsYWdzICYgSUZGX0FM
TE1VTFRJKQ0KPiA+ICsJCWVyciA9IGVuZXRjX3ZmX2VuYWJsZV9pZmZfYWxsbXVsdGkoc2ksIHVj
KTsNCj4gPiArCWVsc2UNCj4gPiArCQllcnIgPSBlbmV0Y192Zl9kaXNhYmxlX2lmZl9wcm9taXNj
KHNpLCB1YywgbWMpOw0KPiA+ICsNCj4gPiArCS8qIElmIHRoZSBlcnJvciBjb2RlIGlzIC1FT1BO
T1RTVVBQIG9yIC1FQUNDRVMgb3IgLUVQRVJNLCByZXR1cm4gMA0KPiA+ICsJICogZGlyZWN0bHkg
dG8gYXZvaWQgbWVhbmluZ2xlc3MgcmV0cmllcy4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGVyciA9
PSAtRU9QTk9UU1VQUCB8fCBlcnIgPT0gLUVBQ0NFUyB8fCBlcnIgPT0gLUVQRVJNKQ0KPiA+ICsJ
CXJldHVybiAwOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBXaGVuIHByb21pc2N1b3VzIG1v
ZGUgaXMgZGVuaWVkIGZvciBhbiB1bnRydXN0ZWQgVkYsIHdpbGwgdGhpcyBjb2RlDQo+IHNpbGVu
dGx5IGRyb3AgZXhwbGljaXRseSByZXF1ZXN0ZWQgdW5pY2FzdCBhbmQgbXVsdGljYXN0IGFkZHJl
c3Nlcz8NCj4gDQo+IFNpbmNlIGVuZXRjX3ZmX3NldF9yeF9tb2RlKCkgY2F0Y2hlcyB0aGUgLUVB
Q0NFUyBlcnJvciBmcm9tIHRoZSBQRiBhbmQNCj4gcmV0dXJucyAwIHdpdGhvdXQgYXR0ZW1wdGlu
ZyB0byBmYWxsYmFjayBhbmQgcHJvZ3JhbSB0aGUgZXhwbGljaXQgYWRkcmVzcw0KPiBsaXN0cywg
Y291bGQgdGhpcyBjYXVzZSB0aGUgVkYgdG8gZHJvcCBsZWdpdGltYXRlIHRyYWZmaWMgKGUuZy4g
SVB2Ng0KPiBOZWlnaGJvciBEaXNjb3ZlcnkpIHdoZW4gcHJvbWlzY3VvdXMgbW9kZSByZXF1ZXN0
cyBmYWlsPw0KDQpGb3IgdW50cnVzdGVkIFZGcywgc2V0dGluZyBwcm9taXNjdW91cyBtb2RlIGlz
IG5vdCBhbGxvd2VkIGFuZCB3aWxsIG5vdCBmYWxsYmFjaw0KdG8gY29uZmlndXJlIHRoZSBsaXN0
cywgdGhpcyBpcyBpbnRlbnRpb25hbGx5LiBCdXQgZW5ldGNfdmZfZW5hYmxlX2lmZl9wcm9taXNj
KCkgYW5kDQplbmV0Y192Zl9lbmFibGVfaWZmX2FsbG11bHRpKCkgd2lsbCBnZW5lcmF0ZSBlcnJv
ciBsb2dzLiBUaGVyZWZvcmUsIHVzZXJzIGNhbiBjaGVjaw0KdGhlIGxvZ3MgdG8gZ2V0IHRoZSBj
YXVzZSBvZiB0aGUgZXJyb3IuDQoNCklmIGFuIHVudHJ1c3RlZCBWRiB3YW50cyB0byBvYnRhaW4g
YmFzaWMgbXVsdGljYXN0IHNlcnZpY2VzLCBpdCBzaG91bGQgY29uZmlndXJlIHRoZQ0KbXVsdGlj
YXN0IGFkZHJlc3MgbGlzdCBpbnN0ZWFkIG9mIHNldHRpbmcgcHJvbWlzY3VvdXMgbW9kZS4NCg0K
PiANCj4gPiArDQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+IA0KPiBbU2V2ZXJpdHk6IEhp
Z2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCB3aGVuIGFuIHVudHJ1c3Rl
ZCBWRiBzZW5kcyBhIG1haWxib3gNCj4gbWVzc2FnZSB3aXRoIGFuIGFydGlmaWNpYWxseSBzbWFs
bCBsZW5ndGgsIGRvZXMgaXQgY2F1c2UgYW4gb3V0LW9mLWJvdW5kcw0KPiBoZWFwIHJlYWQgaW4g
dGhlIFBGIGRyaXZlcj8NCj4gDQo+IExvb2tpbmcgYXQgZW5ldGNfbXNnX2hhbmRsZV9yeG1zZygp
IGluDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Y19tc2cuYywg
aXQgYWxsb2NhdGVzIGEgYnVmZmVyDQo+IHdob3NlIHNpemUgZGVwZW5kcyBlbnRpcmVseSBvbiB0
aGUgVkYtY29udHJvbGxlZCBsZW4gZmllbGQgd2l0aG91dA0KPiBlbmZvcmNpbmcgYSBtaW5pbXVt
IHNpemU6DQo+IA0KPiAJbXNnID0ga3phbGxvY19vYmpzKCptc2csIG1zZ19zaXplKTsNCj4gDQo+
IFRoZW4sIGluIGVuZXRjX21zZ19zZXRfdmZfbWFjX2hhc2hfZmlsdGVyKCksIHRoZSBjb2RlIHZh
bGlkYXRlcyBsZW4gIT0gMA0KPiBidXQgZmFpbHMgdG8gZW5zdXJlIHRoZSBidWZmZXIgaXMgbGFy
Z2UgZW5vdWdoIGZvciB0aGUgYXJyYXkgZGVyZWZlcmVuY2VzDQo+IHVwIHRvIGluZGV4IDM6DQo+
IA0KPiAJY2FzZSBFTkVUQ19NQUNfRklMVEVSX1RZUEVfQUxMOg0KPiAJCWlmICghbXNnLT5oZHIu
bGVuKSB7DQo+IAkJCXBmX21zZyA9IEVORVRDX1BGX01TR19JTlZfTEVOOw0KPiAJCQlnb3RvIHZm
X3N0YXRlX3VubG9jazsNCj4gCQl9DQo+IA0KPiAJCXVjX2hhc2ggPSAodTY0KW1zZy0+aGFzaF90
YmxbMV0gPDwgMzIgfCBtc2ctPmhhc2hfdGJsWzBdOw0KPiAJCW1jX2hhc2ggPSAodTY0KW1zZy0+
aGFzaF90YmxbM10gPDwgMzIgfCBtc2ctPmhhc2hfdGJsWzJdOw0KPiANCj4gSWYgYSBWRiBzZW5k
cyBFTkVUQ19NU0dfU0VUX01BQ19IQVNIX1RBQkxFIHdpdGggbGVuPTEsIGl0IHdpbGwgcmVhZCBw
YXN0DQo+IHRoZSBhbGxvY2F0ZWQgYnVmZmVyIGJvdW5kcy4gQ2FuIHRoaXMgYmUgdXNlZCBieSBh
biB1bnByaXZpbGVnZWQgdW50cnVzdGVkDQo+IFZGIHRvIGRpcmVjdGx5IGF0dGFjayB0aGUgaG9z
dCBQRj8NCg0KVGhpcyBpcyBhIGZhbHNlIHBvc2l0aXZlLCBQRiByZWFkcyB0aGUgbWVzc2FnZSBm
cm9tIGl0cyBvd24gRE1BIGJ1ZmZlciwgd2hpY2gNCmlzIDEwMjQgYnl0ZXMuIFBGIHdpbGwgc2lt
cGx5IHJlYWQgZXJyb25lb3VzIGRhdGEgYW5kIGRpc2NhcmQgaXQgaW5zdGVhZCBvZg0KYWNjZXNz
aW5nIG1lbW9yeSBvdXQgb2YgYm91bmRzLg0KDQo=
