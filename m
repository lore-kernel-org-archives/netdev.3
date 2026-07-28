Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA93CA4B5;
	Tue, 28 Jul 2026 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223139; cv=fail; b=u7S66GuZ1IvwIJy2eqpn0M3wuLR3qsVR37u3T3UnKte41RBPW2sszCf2pPNjcOGznBY6TUTDXMrs4DC+gDEdpGggM9G8JjAmDdE2ztAfjtywP+IDbkZydw5WtFRbIhbyUm7dqzcwV6bJkTdCDXZseC0hS3DNQQLg4DVNUQB6L7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223139; c=relaxed/simple;
	bh=pIIzM3O8gKUEV5Or90sVDMe/sdHjMvPe35jbgnroq4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gPX35m88M3CstNTJJ8vdgAIc+ulqaGNXspHpTcDVZrIsJ49uUHGp1b4v3XIvpr5Sp3XBvtXIZQtjKPfpDrtADjFvkM8X6UqcI9EbdrvWaM/H21+Cq/jRtqeJPNjyIW+DjaS0DzA5f+e2wJZhuu4lTw3o5dkr5qAAeXZddjoMUvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=evOSKxE0; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="evOSKxE0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8kewVIIOhmZ2woJ/GUnZBRYQ3t6WA4x6c2KlFDvFr+7RPfwnJz5mT31hBeH0pcIoIEfRQQRxp+1eN2L+EM3TgImIwwE7qRjbPJIYLe2rrnfe7l7cA45PDMEGMCHEpnH3OmDZpPl/Q7pSmK6dKD9WjiY+eJ8/4i/OMYVjMnrOAzGJfSqgPLPtU5qTThI40xUu9qYCPKYNY8liTJSwSsxIvxcnq/asa2xshkSPeiNYsybztGgHEnrAfYVcDJTPrdoNAw52hbO+qbO0t07tkxg1qxLEsJXqjARAtyCeycs69b2hwyfLKE8zMrhdHSvgSmwrXpgZJmqwOIMmUdXlFFgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIIzM3O8gKUEV5Or90sVDMe/sdHjMvPe35jbgnroq4U=;
 b=kI852Cl0zLwagBeUWRgAm0SWPSUQvqkZ+pldTQUWjXCs/OyNS0KCVS+wK/1DssvujEcolTxXTAGSFFIDh5lhEakFff8PXvwJMWuKP9HigmerhVj2cO+ko8rFXpqr/+ttUm4Wrxhw+8ZQht0MBtQuVxcrYHRTX4enEwpDEBN4zWCrNqb06LDNZf+PeN9qtpx/7DKsmrOGd1ReQsNMSimTgw3VDdqyi6XBQTWLRpNYg1RV85SxtLg2WBRkWbK+7LEzdMel6LcYRuzqyFj7mOFhN687Q1DGKtTK30WdEMdHtnn3E3SSZjQnsnfcIsP/OGOIB2n7G010t3OikHDbtzlgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIIzM3O8gKUEV5Or90sVDMe/sdHjMvPe35jbgnroq4U=;
 b=evOSKxE0KySnbD5270ckfpii8Xp0AhujDEnzRbzwZBLy0YDkDoMI0V3iMqgx6XvfzdT9STo/e1IM4/TKVgNMjJpRSxrOc1OiHySvf8VmDrtTLfo7TtFfDu/zjms1e/vwdabczMabUpkCsyuCnRCewWpCc4FgH+njZ7wyDCk5xc2VaPiGE+r1A94tfWPQ4gzGnLhyv95aXV7YLBX+tl8bMMtacf8QQfxTT1aaK6KFo6/Z6OVdcD+i5ebw/KwejUX8ZHv+1hvbMNjpQHFFQGyRTldhvMPG2527kp6dGXfaGoWAKVydgLKNKNjs2RKokJhBrwUP9evLdOZuTXWFPJc/tA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV5PR03MB8412.namprd03.prod.outlook.com (2603:10b6:408:35f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 07:18:54 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 07:18:54 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: fpe: Keep pmac always enabled
Thread-Topic: [PATCH net-next] net: stmmac: fpe: Keep pmac always enabled
Thread-Index: AQHdHYaabXAhVDZDKU2DeUOzpGcjdbaBBAyAgAGDl4A=
Date: Tue, 28 Jul 2026 07:18:54 +0000
Message-ID: <360566d8-4756-402c-ac5b-7b80764bf86c@altera.com>
References:
 <20260727051303.14925-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <70cf4cfa-c329-41a5-b335-561a565627d9@bootlin.com>
In-Reply-To: <70cf4cfa-c329-41a5-b335-561a565627d9@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|LV5PR03MB8412:EE_
x-ms-office365-filtering-correlation-id: cfc8cd1e-0fb2-4adf-be12-08deec787b97
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|55112099003|18002099003|4133799003;
x-microsoft-antispam-message-info:
 znW8tIutSClKZ668AN4naJsGCxAN7UgFEbD28hs0fH2e5q0kLrQ+Y+a3prZem8pB4tyJkO7dV0NpgbqY7CoqHSQeFKgEhqNCxr4D8PdioAOWX2czwXZ7Falnzq5pMdXxKE1RrAk7tinSRPlCw11DX0T+URK9+0z0WFga8+9xgfNzFVcoylugaowSRKibOpco9FzZqUOEp7o885viTdKnkdYzmgigxB5t9MmgCl1if1J6F/5KOmjN5h2/Id2TCeFpThqaCInDD7O+kVKDDdhXYqxLeZGvePiyDMxRafNbx61EIwhO2T4Ef7N6Ihb6SxlMubYNXFBQdcs5r8UFXWsx/0AGrVd7ndMnCyeMRsWKc+StpTD5pfT2xSYEygy84SjC6pHrPZX3i9pyo0mcMc6NW9Zy0e6lyADG3K9nPy6GHxB9eZ7MlFV0IQTaHV8eD/wo2rGrQHgMTiNLl5pew/5a6FOJfYjcy34tloMrH8vZG1XCFDxuL96wFFUcFCbceBkuF5ROklshVEsY46N88scxlyQQj3RM35ENGshqAIwdHfVbT360WdbUNJz0i4fPcAN+QPDofaRpf4kKprRraXA27BacyNki82k7u8X1IeY2Tz+9zSNfBg1fwdLqS5/nNUg8VUtGxa1m7IHRV7AV9Ezvfov7CQ2ipSdsXjVZYT85LIk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(55112099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUNqbmU2dlVHeHM0SGs3RG9XcUhMd3c3akx6eS9DcjV1dnBWN09weXNLL1Zm?=
 =?utf-8?B?eDk1UFdwWTFEaUFQNlh5RUNydUc2SEVEWFI5R25EOEJJSUZqV1JGMjVwMisv?=
 =?utf-8?B?NnhWZlhlQW5xdFFzakFLN1Z6TFNuRnJEbHIxbXJMT24wMmt4eTN3akpyUFpL?=
 =?utf-8?B?ME5nc2FGd1JTSGJXczRsL0sxK0JvMGExWDdZK09HNmNQbkhxWVJ0MmdZc2Rh?=
 =?utf-8?B?QWVsTWJVYzBFbmhvWU5zdTBvZlp5dElWSGRJSmpYbW5jOTA5d1pDZVczNFk4?=
 =?utf-8?B?N25LeEU2VzRDc1gzWHU0UkdvL0tJeDJhTW14ZjViS2s1OVR4VWFROGNpQnRM?=
 =?utf-8?B?TWFLZVUyWngxeWl6dk5NNFVuN0pnQllmU3N2RjJ6bld1Mmx6V0w4aU9MR0xJ?=
 =?utf-8?B?UjBac0hmWWtNOFRoY05MSlpvWnNvY01NSi9EdFpXd0NOQTh0YUtvbWRwUGh4?=
 =?utf-8?B?dnlPOEg2RUNWSVppRDBDZ0dRQWVGT3lpZ0JwRlZYQVp0Z0FVY2luNm9XNUJr?=
 =?utf-8?B?aWVIaTNycVVCOURmajRDSTZ4NVlocFdmYmRBMVUzWWFnNmx4QitNUG9mTENQ?=
 =?utf-8?B?cXkwUUg4UnVoL0tUamtTaCsvN3gwUDgybkdnWVZsMGlKKzRvcWxFeWZlcU9x?=
 =?utf-8?B?bEJKa3lqK094b25NZHNhVkRrbllBazhsSHdyRm9qRGw1QzlXU3JZdWxhc0JH?=
 =?utf-8?B?SXBMSlFiWVpVeGJmYURBaUd1aEhWOCsvZFFWYWdEQUptcFRGQUNIZlpHcHlv?=
 =?utf-8?B?V1hVS1o1QUdBbkZkSERld3Rua0VSUGpyV2FkUzNjSHFxbXg5NEYrM2ZDZ2JG?=
 =?utf-8?B?R0FaZStoU0VLYkcrTSthU3lpbi9WNUY1WVNGcnRibXkrRkdSV1lmVVBJS1pu?=
 =?utf-8?B?TG5rYVg0U2hOSjUyYkYybkdZUFFlM1U3Y2RuVGhUQnVLOEpvYW9yM3o2cExL?=
 =?utf-8?B?c3BCM3MrZzMxUHhNYmFXejhDaWZmditqcWpGUE05eGZWSjRRS0N4TmFjZ3BV?=
 =?utf-8?B?d2dEclRiU2l5ZGZlUEVnWHFacHZEVkZ5RGdaVnBvU2ZjTGZnSmg1R3VYbU5v?=
 =?utf-8?B?ZUZlcCsxak91QnNtOWoxRHpkZ3Q3ejNoWlBLbjJWMHRRUDduODJLc2VnVEMr?=
 =?utf-8?B?bldNTU1RbnRMS1J0eWxyelRNRUFFK3hod3krTEkyamRqZ1ZJZHprUFZjbEo3?=
 =?utf-8?B?OG9JeUpmSGlEVnRHZ0F4UmN3OFFFRkVUMFhvVVE1aEtpSVBpSGh6VGZhY29Y?=
 =?utf-8?B?YVRFbVo1NUhNOWd1c3hwcTdtMVdpcnlPanVoTSttajJ0OU5rVWhmZjZzMjJP?=
 =?utf-8?B?Ym4zRkdPSTlBbXVFdGd6Y0YwUmRMalR6ODhuUHNIdzlvMk1oUG10Zi9jd2Ex?=
 =?utf-8?B?RWhodGg2VnVSRXViSXF1b1kvNlNNYjV3M3c0QjFiVldQNmlGTUE0c1JET0di?=
 =?utf-8?B?NHNKcm0vcHNjWm9oVkxBT3F1TDgxYWFqKzhCeFJOcm5OV21WU0twWmlyRVJr?=
 =?utf-8?B?Y09PWHNnQWVmWUFmTHdKNGg0RWRvNlJzbjNlQ1NyK2grZ1BycEJhc2JBTzd0?=
 =?utf-8?B?VWhlZFVpZEVyYUs4TjM5bGRGSERmNFJvazI2d1FkK3JaWDdnOGdrN2QyVkIv?=
 =?utf-8?B?SUIrdHdKbTZjT0FnZVFnVitkb2NveC9BU3NjOUx0bkpYN21BZ0NZOGNneVlE?=
 =?utf-8?B?YUUvb1FZLzlxQjRCZDJ0OGg2c1RnVzNzZGxqeXk5VjZQUHlDZmFEN3ExMnNN?=
 =?utf-8?B?eUlPZ09tWFZEdTFNREgxZGRLRFJNSEZuVUM1M3JJV2NlcVRiOHJaelFONXhw?=
 =?utf-8?B?a09GNUgvZU5CWVZxdnhhb0t5bGR0RmJSblEzcXFSbEk4YlNwZGZiVVJWdkUr?=
 =?utf-8?B?MFlnaUdjNk8vRTE2aVArWGE2SkhpdUNUcC9BQ2VOQnNXRitjSm5PanRnNUkv?=
 =?utf-8?B?TnpLTis5andsMHJVT0s4RU1WSUgxTzlvTzh3eGo5OTQ1ZFpXUnU5UGphYk9F?=
 =?utf-8?B?WGVadnI2WkRSbWQ2SWpXWkZaK1FvT1k2alYwU0tNMTVGb1dwVEVHVXRRWjU4?=
 =?utf-8?B?SnIzNTlMYnMvZ2cvcGR6N3I1WGNPY2RVNGRIY25vdkFHdjRZMDRKdm1tM0dL?=
 =?utf-8?B?N0xDcEQwcDFXQmZuTkRVNGdDMDF0MGRucmJJb08yK1NYMFlHVFY5dmViYjhG?=
 =?utf-8?B?NjlOZ2FXUzl1dWhobnBPLy8vdUVEcUZ4ZTZNMlJ6dnlWOVdjMzMwYmRQRHRv?=
 =?utf-8?B?VytFT0t0Q2xva0swY1pBbW5MM1J4SkhrdFpPMmhmZTJkL3Y3SVE0Zk9MRlE5?=
 =?utf-8?B?dEMyUG1kejBWMHJwQmJPSU8vbVlzZ2FLQmdnNWVjODlkY2pGa0lER2RSa0Np?=
 =?utf-8?Q?q8XjeNMStfZiiC9M0UxZjaGfjLE6/D0SXat7ed/KHjU3L?=
x-ms-exchange-antispam-messagedata-1: VayQNcoR8OXFGlEfrTK5Es4wFbHeUft87GE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA26D3C0A1EE214EA098819489D8E647@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc8cd1e-0fb2-4adf-be12-08deec787b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 07:18:54.6938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPmc2CMI0GsIv5n0gE66pALsN7C1utGJ3zA8UpFbpDcgzbpui6FeNo6re/HyCkaTBkGiSHKO+wiEb/4fhPBhIBjDKhxBh/oNztsjT/3lohnDkC+gPd1HZZCgmAFlzOrfMwmuqOuFpb2XRhH28Jwj+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8412

T24gMjcvNy8yMDI2IDQ6MTEgcG0sIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOg0KPiBIaSwNCj4N
Cj4gT24gNy8yNy8yNiAwNzoxMywgbXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBh
bHRlcmEuY29tIHdyb3RlOg0KPj4gRnJvbTogTmF6aW0gQW1pcnVsIDxtdWhhbW1hZC5uYXppbS5h
bWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20+DQo+Pg0KPj4gVGhlIHByZWVtcHRpdmUgTUFD
IGluIERXTUFDIGlzIGFsd2F5cyBlbmFibGVkLCBtZWFuaW5nIERXTUFDIGlzIGFsd2F5cw0KPj4g
cmVhZHkgdG8gcmVjZWl2ZSBwcmVlbXB0aXZlIG1QYWNrZXRzLiBLZWVwIHBtYWNfZW5hYmxlZCB0
cnVlIGF0IGluaXQNCj4+IHRpbWUgYW5kIHJlamVjdCBhdHRlbXB0cyB0byBkaXNhYmxlIGl0IHZp
YSBldGh0b29sIHNldF9tbS4NCj4+DQo+PiBUaGUgRlBFIHJlc2lkdWFsIHF1ZXVlIChmcHJxKSBj
b250cm9scyB3aGljaCBSeCBxdWV1ZSByZWNlaXZlcyByZXNpZHVhbA0KPj4gcHJlZW1wdGl2ZSBt
UGFja2V0cyBmcm9tIHRoZSBwbWFjLiBNb3ZlIGl0cyBjb25maWd1cmF0aW9uIGZyb20NCj4+IHN0
bW1hY19mcGVfY29uZmlndXJlX3R4KCkgdG8gc3RtbWFjX2ZwZV9jb25maWd1cmVfcG1hYygpIHdo
ZXJlIGl0DQo+PiBsb2dpY2FsbHkgYmVsb25ncy4NCj4+DQo+PiBBbHNvIGFkZCBhIG1pc3Npbmcg
cmV0dXJuIGluIHN0bW1hY19mcGVfaW5pdCgpIHNvIHRoYXQgdGhlIHBtYWNfZW5hYmxlZA0KPj4g
aW5pdGlhbGl6YXRpb24gaXMgbm90IHJlYWNoZWQgb24gaGFyZHdhcmUgd2hlcmUgRlBFIGlzIG5v
dCBzdXBwb3J0ZWQgYnkNCj4+IHRoZSBkcml2ZXIuDQo+DQo+IENhbiB5b3Ugc3BsaXQgdGhpcyB1
cCBpbnRvIGluZGl2aWR1YWwgcGF0Y2hlcywgb25lIGZvciB0aGUgc3RtbWFjX3NldF9tbSgpIGFu
ZA0KPiBzdG1tYWNfZnBlX2luaXQoKSB0byB2YWxpZGF0ZSB0aGF0IHdlIGtlZXAgcG1hYyBvbiwg
b25lIGZvciB0aGUgbWlzc2luZyByZXR1cm4sDQo+IGFuZCBvbmUgZm9yIHRoZSBwbWFjIGNvbmZp
Z3VyYXRpb24gaW4gdGhlIHJpZ2h0IGZvbmN0aW9uID8NCg0Kc3VyZSB3aWxsIHNwbGl0IGFzIHBl
ciB5b3VyIHN1Z2dlc3Rpb24+DQo+IEFsc28gb25lIGNvbW1lbnQgYmVsbG93IDo+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBSb2hhbiBHIFRob21hcyA8cm9oYW4uZy50aG9tYXNAYWx0ZXJhLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxl
LmFzbWFkZUBhbHRlcmEuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9ldGhlcm5ldC9zdG1pY3JvL3N0
bW1hYy9zdG1tYWNfZXRodG9vbC5jICB8ICA3ICsrKysNCj4+ICAgLi4uL25ldC9ldGhlcm5ldC9z
dG1pY3JvL3N0bW1hYy9zdG1tYWNfZnBlLmMgIHwgMzQgKysrKysrKysrKysrLS0tLS0tLQ0KPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1t
YWNfZXRodG9vbC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFj
X2V0aHRvb2wuYw0KPj4gaW5kZXggOTI1ODVkMjdhYjg4Li44ZWJkZDI0OWU1YzggMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfZXRodG9v
bC5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNf
ZXRodG9vbC5jDQo+PiBAQCAtMTA2NCw2ICsxMDY0LDEzIEBAIHN0YXRpYyBpbnQgc3RtbWFjX3Nl
dF9tbShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgc3RydWN0IGV0aHRvb2xfbW1fY2ZnICpjZmcs
DQo+PiAgICAgIGlmIChlcnIpDQo+PiAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+DQo+PiAr
ICAgIGlmICghcHJpdi0+ZG1hX2NhcC5mcGVzZWwpDQo+PiArICAgICAgICAgICAgcmV0dXJuIC1F
T1BOT1RTVVBQOw0KPj4gKw0KPj4gKyAgICAvKiBEV01BQyBhbHdheXMgaGF2ZSBwcmVlbXB0aWJs
ZSBNQUMgZW5hYmxlZCAqLw0KPj4gKyAgICBpZiAoIWNmZy0+cG1hY19lbmFibGVkKQ0KPj4gKyAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gICAgICBzdG1tYWNfZnBlX3NldF9h
ZGRfZnJhZ19zaXplKHByaXYsIGZyYWdfc2l6ZSk7DQo+PiAgICAgIGV0aHRvb2xfbW1zdl9zZXRf
bW0oJnByaXYtPmZwZV9jZmcubW1zdiwgY2ZnKTsNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX2ZwZS5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX2ZwZS5jDQo+PiBpbmRleCBjNTRjNzAyMjQz
NTEuLjJiZmE4NGFkMDRhNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0
bWljcm8vc3RtbWFjL3N0bW1hY19mcGUuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
c3RtaWNyby9zdG1tYWMvc3RtbWFjX2ZwZS5jDQo+PiBAQCAtNDcsMjAgKzQ3LDEzIEBAIHN0YXRp
YyB2b2lkIHN0bW1hY19mcGVfY29uZmlndXJlX3R4KHN0cnVjdCBldGh0b29sX21tc3YgKm1tc3Ys
IGJvb2wgdHhfZW5hYmxlKQ0KPj4gICAgICBzdHJ1Y3Qgc3RtbWFjX2ZwZV9jZmcgKmNmZyA9IGNv
bnRhaW5lcl9vZihtbXN2LCBzdHJ1Y3Qgc3RtbWFjX2ZwZV9jZmcsIG1tc3YpOw0KPj4gICAgICBz
dHJ1Y3Qgc3RtbWFjX3ByaXYgKnByaXYgPSBjb250YWluZXJfb2YoY2ZnLCBzdHJ1Y3Qgc3RtbWFj
X3ByaXYsIGZwZV9jZmcpOw0KPj4gICAgICBjb25zdCBzdHJ1Y3Qgc3RtbWFjX2ZwZV9yZWcgKnJl
ZyA9IGNmZy0+cmVnOw0KPj4gLSAgICB1MzIgbnVtX3J4cSA9IHByaXYtPnBsYXQtPnJ4X3F1ZXVl
c190b191c2U7DQo+PiAgICAgIHZvaWQgX19pb21lbSAqaW9hZGRyID0gcHJpdi0+aW9hZGRyOw0K
Pj4gLSAgICB1MzIgdmFsdWU7DQo+Pg0KPj4gLSAgICBpZiAodHhfZW5hYmxlKSB7DQo+PiArICAg
IGlmICh0eF9lbmFibGUpDQo+PiAgICAgICAgICAgICAgY2ZnLT5mcGVfY3NyID0gU1RNTUFDX01B
Q19GUEVfQ1RSTF9TVFNfRUZQRTsNCj4+IC0gICAgICAgICAgICB2YWx1ZSA9IHJlYWRsKGlvYWRk
ciArIHJlZy0+cnhxX2N0cmwxX3JlZyk7DQo+PiAtICAgICAgICAgICAgdmFsdWUgJj0gfnJlZy0+
ZnBycV9tYXNrOw0KPj4gLSAgICAgICAgICAgIC8qIEtlZXAgdGhpcyBTSElGVCwgRklFTERfUFJF
UCgpIGV4cGVjdHMgYSBjb25zdGFudCBtYXNrIDotLyAqLw0KPj4gLSAgICAgICAgICAgIHZhbHVl
IHw9IChudW1fcnhxIC0gMSkgPDwgX19mZnMocmVnLT5mcHJxX21hc2spOw0KPj4gLSAgICAgICAg
ICAgIHdyaXRlbCh2YWx1ZSwgaW9hZGRyICsgcmVnLT5yeHFfY3RybDFfcmVnKTsNCj4+IC0gICAg
fSBlbHNlIHsNCj4+ICsgICAgZWxzZQ0KPj4gICAgICAgICAgICAgIGNmZy0+ZnBlX2NzciA9IDA7
DQo+PiAtICAgIH0NCj4+ICsNCj4+ICAgICAgd3JpdGVsKGNmZy0+ZnBlX2NzciwgaW9hZGRyICsg
cmVnLT5tYWNfZnBlX3JlZyk7DQo+PiAgIH0NCj4+DQo+PiBAQCAtNjgsMTAgKzYxLDExIEBAIHN0
YXRpYyB2b2lkIHN0bW1hY19mcGVfY29uZmlndXJlX3BtYWMoc3RydWN0IGV0aHRvb2xfbW1zdiAq
bW1zdiwgYm9vbCBwbWFjX2VuYWJsDQo+PiAgIHsNCj4+ICAgICAgc3RydWN0IHN0bW1hY19mcGVf
Y2ZnICpjZmcgPSBjb250YWluZXJfb2YobW1zdiwgc3RydWN0IHN0bW1hY19mcGVfY2ZnLCBtbXN2
KTsNCj4+ICAgICAgc3RydWN0IHN0bW1hY19wcml2ICpwcml2ID0gY29udGFpbmVyX29mKGNmZywg
c3RydWN0IHN0bW1hY19wcml2LCBmcGVfY2ZnKTsNCj4+ICsgICAgdTMyIG51bV9yeHEgPSBwcml2
LT5wbGF0LT5yeF9xdWV1ZXNfdG9fdXNlOw0KPj4gICAgICBjb25zdCBzdHJ1Y3Qgc3RtbWFjX2Zw
ZV9yZWcgKnJlZyA9IGNmZy0+cmVnOw0KPj4gICAgICB2b2lkIF9faW9tZW0gKmlvYWRkciA9IHBy
aXYtPmlvYWRkcjsNCj4+ICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+IC0gICAgdTMyIHZh
bHVlOw0KPj4gKyAgICB1MzIgdmFsdWUsIHZhbHVlXzI7DQo+Pg0KPj4gICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmcHJpdi0+aHctPmlycV9jdHJsX2xvY2ssIGZsYWdzKTsNCj4+ICAgICAgdmFsdWUg
PSByZWFkbChpb2FkZHIgKyByZWctPmludF9lbl9yZWcpOw0KPj4gQEAgLTgzLDYgKzc3LDE0IEBA
IHN0YXRpYyB2b2lkIHN0bW1hY19mcGVfY29uZmlndXJlX3BtYWMoc3RydWN0IGV0aHRvb2xfbW1z
diAqbW1zdiwgYm9vbCBwbWFjX2VuYWJsDQo+Pg0KPj4gICAgICAgICAgICAgICAgICAgICAgdmFs
dWUgfD0gcmVnLT5pbnRfZW5fYml0Ow0KPj4gICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAg
ICAvKiBGcmFtZSBQcmVlbXB0aW9uIFJlc2lkdWUgUXVldWUgaXMgdGhlIFJ4IFF1ZXVlIHRvIHdo
aWNoDQo+PiArICAgICAgICAgICAgICogcmVzaWR1YWwgcHJlZW1wdGl2ZSBtUGFja2V0cyBtdXN0
IGJlIGZvcndhcmRlZCBmcm9tIHRoZSBwbWFjLg0KPj4gKyAgICAgICAgICAgICAqLw0KPj4gKyAg
ICAgICAgICAgIHZhbHVlXzIgPSByZWFkbChpb2FkZHIgKyByZWctPnJ4cV9jdHJsMV9yZWcpOw0K
Pj4gKyAgICAgICAgICAgIHZhbHVlXzIgJj0gfnJlZy0+ZnBycV9tYXNrOw0KPj4gKyAgICAgICAg
ICAgIC8qIEtlZXAgdGhpcyBTSElGVCwgRklFTERfUFJFUCgpIGV4cGVjdHMgYSBjb25zdGFudCBt
YXNrIDotLyAqLw0KPg0KPiB5b3UgY2FuIHVzZSB1MzJfcmVwbGFjZV9iaXRzIGZvciBub24gY29u
c3RhbnQgZXhwciA6DQp3aWxsIHVwZGF0ZSBhbmQgcmVwb3N0IGl0LCBUaGFua3MgTWF4aW1lIT4N
Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMi1yYzQvc291cmNlL2luY2x1
ZGUvbGludXgvYml0ZmllbGQuaCNMMjM2DQo+DQo+IChpdCdzIGF1dG9nZW5lcmF0ZWQgYW5kIG5v
dCBkb2N1bWVudGVkLCBoZW5jZSB2ZXJ5IGhhcmQgdG8gZmluZCBJTU8pDQo+DQo+IE1heGltZQ0K
DQo=
