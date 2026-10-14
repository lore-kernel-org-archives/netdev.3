Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8D2750F2
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959206; cv=fail; b=BRF1ccwXfnpgwP5mjN/FzT49tcky6y6d2EnYQ4CEblylm7PNnu9klos42+p8S0Bkt5VhqKZB5+tfZJSdlVlaywBxpTm6JzYLdXNOHyq+IBMyPxgl0RWFwGEqKL08kriOeoi3sAF6qLNOdqYmdBK3D22QdzH0zwwLL+2aqJLAMTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959206; c=relaxed/simple;
	bh=M//EgXF39U1HHjS8dxd4Xq2dqYuEXKSm65RlQwyrMtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7xRRGjahhn4XtKoldyhEe9NrVamPf90kGmmgaKTqcZ80+zIpRArNHdYs5jTeaojyZkr2hTtfRt6j4Hs0CxSVRwBLlUtmhxgkTMakIZwqYZphH9IcAtw0Wz+xOB5oFe+C2H0Xxg95Yeg4EhClMGcDfgQvX56jmsw1NubVc25sRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hU7MqXvi; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hU7MqXvi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2/aO1SrqXvSGIw/w+l87ZCPzsX7lk+8YhIDnBxaDCtOt9TDd1Y4fNRksE0foYMM+S6cxpegSNGztHxgRO539GasQ7JUluVi35C2Xi6iYJrLKvlFHlT0Ic03xdkmp11Y1qeTTVQRsa9VQJmL61ahcCEn8oVe5LnqkCGiYyjN1T2w31e3+EkuBQucyhWcsH0qyyex5Ie8CcRUB0YtPi389BouHdK04jByGlYVUJyw3IeC4c/JV76dUIpzHvmww78Y1GJ8jDHuWWqaQH5EL6pTkSz1gg0r/EAQvO6nuKvFhonyx6pvU4IMQ8+f+ntJZuJ32mwC3KFnku9ejF6HxYqoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M//EgXF39U1HHjS8dxd4Xq2dqYuEXKSm65RlQwyrMtM=;
 b=rr9fLY085FtRV67BHpIrSDT/n8+kLa/JwUARLG9EXFj+EFEYaEhHjTHurAOETcbpXJstA+grvpIYI15S6YnuGTOSGgkrQeAJHv78hEGOKL2bJHyNPXoB4Nrw94A6BVltjpw8q8phcV1QNezhYSAtqJdQ9Xw8p4duV5nyX6nycokD7YqaeZcgskMZYcKLN7hxwIk2pReCz5qg2TBHaNJu+yJRLIgwi9c71nXMvzMdVWEKnJLrg2gZFYci89jE7PEyC54YDg7u7VSsF+zH9Il0BEwT4kgpimP+p3Z7SBIRzkTxqKYPccakCExaC4x7CZzH97OUupqtmDwBVgGVPU/Ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M//EgXF39U1HHjS8dxd4Xq2dqYuEXKSm65RlQwyrMtM=;
 b=hU7MqXviP1f1ZWf5dpPTd9/h6tvQ+0Pd2Zg4bRjnezvbeKCOr8/rHxdmPArCbTV/IMAjm286RcDKD3uG2Tj8dzmooBjmkLqNKuDqbKY6Pg2YaH8nMyEGp+itRiOKc51bAgssZQzZPb5zQH09xffRHs/+S1BWFe6VkVZ+goEiKlcEKgwgFQIg7lxSEDXFjXdrSiIiOBuM2apSATOFEugFIi0UHw9VehkCu0j9uEzec53KnKk1/v4oCPo8QaRrvbvl/ltzRMjHcbeZt57N7ms+WWYeEg9eJo0e44UDsRVL6cCFa8+OUiNg6W0P2P90GQ0B+fyfuyDP85ILgXiV01gldw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI2PR04MB10089.eurprd04.prod.outlook.com (2603:10a6:800:227::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 06:26:41 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 06:26:41 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v5 net-next 5/9] net: dsa: netc: use entry ID instead of
 pointer to track host flood rule
Thread-Topic: [PATCH v5 net-next 5/9] net: dsa: netc: use entry ID instead of
 pointer to track host flood rule
Thread-Index: AQHdWi/Pet93JkiaRk2WLB4nM0oltrb7PtMAgAFWvGA=
Date: Wed, 14 Oct 2026 06:26:41 +0000
Message-ID:
 <AS4PR04MB9338D0485D62F4FBAE744BFC889D2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
 <20261012095924.1129312-6-wei.fang@oss.nxp.com>
 <sashiko-outbox-169416@kernel.org>
In-Reply-To: <sashiko-outbox-169416@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI2PR04MB10089:EE_
x-ms-office365-filtering-correlation-id: c8fd7bd2-69a0-4513-cbb4-08df29bc1c1d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|5023799004|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 jeSIwbfbm0zi1EY87XImweVS4Tv304Muz8Xq1590lrLRbswQVkYA/cposOxizz2WCNx7Z9XvyRp+SQGr9UXDHNOvxDp/m1yXgojiOu1fuHMWxK5QXEwml4IEk1JEZeFIv1YJH8NdVOkm5BoDUViYc2lTFW2OZGMqv+gHXBj08J45BJSNwaZTbJCoMmrwR7gBORULDD2TWLl1cwqtT8rMpGMhhg8iYVdEbqhGFxD1mwVqTrkyxrbGiR7ugiZu8o+5mhM/feIpZzHQxybulSJnrB9i+6qGGkK2LV1FjUzJMbWCRkcm4pRJUZDAuPHk2IA7WCBspdUP3lLd87IPBYSQ2F8TYsqaQPh/ddWyTj4BpQx4NWTK2DhTLqTZd/XqAB09/cLAah2Ixly6nH1OFvAcVziSvjy/sMtRg9gUNlBSp3a7XgJXT+Bezs2s30XgQvu9R+i3wtizLJjU9dp0LvIa8bUd5qf0j1oy2vBCd64L5kJrcyHT5kGuJbP/y3fKLncsMGb8Rsv8I9iL8r/esGSUaaZ4Jcl7X4Dn80O0w/XCOqeXBKEz7gNiQswjHVp3Tujzw6L+JZKHmd4u1zb6oA6gVqgs1WxKYeP4qiL6LyuV5Kqe+B/zyLmCNq6Gle4XPgLu0MZC9oGzMRLRkF+ycGx3q9ysV0uP4qGXYF6m33UQsClPEINyEw0RFXxSs6/jHkcSQXGonqrJRZqvutW6uDXS0faNnjCskKyp+HisUnaSb3Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDdkbUdUS3dlMmtRaTNyQVhGRWRudHlsdjdRTGgya2R3Q2cvaGttSlJzU3Zn?=
 =?utf-8?B?elRHanlkYWRDQzVUcEJOVkQ0dElsUUtuWjlabG5Najc2ZSs5NDdSRUtDNGlC?=
 =?utf-8?B?ZDc5RkJ2MUhJL3IvdEhtalQwajJnVVFmblJPK2VZZW9WT3BKQUd4bzRxb0hY?=
 =?utf-8?B?VFNjbmM4NUMwMVZpMjd2OTI4MjRZM1V6djVKU2xQdzlib0ZMYnNQclFhSVl1?=
 =?utf-8?B?ck90VEcvMWc4QWpwWlp1ZUQxellma2Q4YnVBdS9DMW1iRVBUZmJna1ErZ1Bp?=
 =?utf-8?B?cjJmNC91K09mRHIvUEIyUEhHdEkyb2VkT3FxM0FZbE9HdHRIdlZyVUlaZHZP?=
 =?utf-8?B?aHB3Szl1VTR4T1g3Qm9PL0RMOCt2VlhJZExwTEdtUmJGa2hETkU4WC84dC9W?=
 =?utf-8?B?U1BZU0o1K2ZoS05oNFlKa09lbThPa0F1dEFhN1hnbTN5MXpFTmJrSnNTenVt?=
 =?utf-8?B?NHhaOEVTV1ZKTEszRDdhQ2p2OGJQbmdYNERCeW1xTzVYQjVvdWwwU2hEZGFI?=
 =?utf-8?B?TmJreHJGbGt5ai95UXRNTDNyTnc0cVNCZFlQUW5ISE9sVTl2bFZWWGphRW1h?=
 =?utf-8?B?NUwvSGVFeXc1ekJkcE9Od2EzUkVPZTFNYnc5Zlp3Q0JjRFBVdVB5SjdPSHI1?=
 =?utf-8?B?bi9SSkZ1RUE3UW9nNlJkZTJKRmg5MkhuRXAzd2kwZ3Z6Q3pKNGZDclJGMVBP?=
 =?utf-8?B?VE5LMERvSmtLSEZDcW9vMmR0RTdtM2FCdFdoYnphanltOHllc1ZxZzZBQzBw?=
 =?utf-8?B?WjlNdWtZYUhiUk1YbVY4UU1qb0JPRU43dXU1K1NNelNOWXVUdmJaWkFvY1pO?=
 =?utf-8?B?Q3VndjVqNC9FVVljMC9GNUkrblA5QjBoY2hJZWVTL21heC9obmgxRWlrbFZ5?=
 =?utf-8?B?dE9IbS9XK1lOcTMyOWp0eUw4THVsNW9NSXBJbng4TDNtQ2V5UmM1N0Jzd21i?=
 =?utf-8?B?TEZRZzdoUUZ2Yk9iRWFVWEs0RG1zYmJCRVZkYmdoUy9QS0NjWGpKemx0UTkw?=
 =?utf-8?B?VHVpTGNGeEl0YlBEN2FzOXpabHR5YXFOSEdRV0VUZ3hrbW9VSHIxLzMxQkVp?=
 =?utf-8?B?UVNUNTRMaUExT2hadXdpdSsxK3VJQWNLVmdyNU5MV2pZZURmaXBYNU9xRzJT?=
 =?utf-8?B?S2hLN0hJcUJJVTVndlpPU0NLZW5nQ1hWZHB1YmVLN1pFMG1EZjBvYUpZVmFn?=
 =?utf-8?B?VlloVE1OUTFjZVhtWUEwNHh2R1NxKzMzOCs2aHZwVnNUTG9tUGVlV1RhbnhZ?=
 =?utf-8?B?dWhmQWxqWmNiWk9VblptS1pIKzY3ZmxIaGRjbDNzdFhLQXZoeGhrY05hdkxm?=
 =?utf-8?B?aFE5OEtQeXQ2ZDk5dVhncEsySVZtMjc5OUdqZDhIRFBiV0lhOFNUWnREMEo1?=
 =?utf-8?B?alQrb0U1ZEtjZHRMVnVjQ1VYNC9uZlRjZXhFQzBUZ0dEbjRSOC9vYmVCNk5I?=
 =?utf-8?B?UjZzUzhqZFVmaXBPdGgzdC8wWEJEanRIQWFBeFZNeWJVOXlCTFdFT1lPcDQw?=
 =?utf-8?B?ejhIbC9zbjhmdVNrYi95UkNxZm5uUmV4dUpsMGt1eThpWVFwNEhQM0lZTlZ2?=
 =?utf-8?B?RnBLbktlSkpNQXg2YkRjNW5UaEVFZ212Yjd4YUkrd2ZmaFlDcjJhaUhMZEdF?=
 =?utf-8?B?MU5HdDV0K3FaUDhuM3FWT1lpaWJTVHlwTDVOOVN5SXh3enRYRzFoZWJsUHRs?=
 =?utf-8?B?SzFJclBGTzRpZzZLd3FlOU1vaGtKaDBVN2FGNzlnWmpBTG1OTWFRWktkcGpO?=
 =?utf-8?B?bHhEc0U5SERWL2syVWV3c2gxTHJ1VUV1V01zK3d3ZWVCWFNpREY3azF1MUhz?=
 =?utf-8?B?YTVJaEFmSitxMWxGbzZGbUdVcWd0bW5nUTZ4WnBvZy9pV3VNSUliNnVRNEQy?=
 =?utf-8?B?VUtMK0twU3ZQdDNDdmNDRGtiSFJYbDE4cVUyb0pHTHAwQnQrM1o0UTQrc2l6?=
 =?utf-8?B?dFAzb3Q5YkIwWnYyTFFSYjlYOFZrVVFZdlhWWUUwbjg4MVNUajBGZGsxUGlx?=
 =?utf-8?B?eXFuUkRldEFRbHc4dFczbkpEMGNDTzdjaHB1cmd3TW5xZ09pMitlazFyQlRn?=
 =?utf-8?B?dW1nNzJKYThZZkNvVk4wQXo1U3hTdzdrTGk1b0VzakFuNytZbGFMVjI4RnZo?=
 =?utf-8?B?QzJrWkdpTy9WazVWbW12T0M2ODV0Z1Z0ZnZyNDdDeTRqNnZHcGI0eVB6OHNz?=
 =?utf-8?B?MytpOUh0c3M2OVlBWWM4VHpIbkR1cmFKWWpwdWxrNjhhNjh6VjRuN2ltUFg3?=
 =?utf-8?B?bk5tWEVic0p5NXJ3Z2ZHMXRKWUJQQnJtaVVRWE92RnJjbzBIbSs1bzBWUXdU?=
 =?utf-8?Q?0QAHeLj8nv3d6plMMJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fd7bd2-69a0-4513-cbb4-08df29bc1c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 06:26:41.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtVWf3bQ/8vHt8DLujoZY6Vb0Epi5FLb3tJBSwkzscgm6lCjPQY2FMoHjw+iciJZPJs1nUgZMAnC154FARw5dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10089

PiA+IEBAIC0xOTA4LDIwICsxODk0LDE4IEBAIHN0YXRpYyB2b2lkIG5ldGNfcG9ydF9zZXRfaG9z
dF9mbG9vZChzdHJ1Y3QNCj4gZHNhX3N3aXRjaCAqZHMsIGludCBwb3J0LA0KPiA+DQo+ID4gIAkv
KiBJUEZUIGRvZXMgbm90IHN1cHBvcnQgaW4tcGxhY2UgdXBkYXRlcyB0byB0aGUgS0VZRSBlbGVt
ZW50LA0KPiA+ICAJICogd2UgbmVlZCB0byBhZGQgYSBuZXcgZW50cnkgYW5kIHRoZW4gZGVsZXRl
IHRoZSBvbGQgb25lLiBTbw0KPiA+IC0JICogc2F2ZSB0aGUgb2xkIGVudHJ5IGZpcnN0Lg0KPiA+
ICsJICogc2F2ZSB0aGUgb2xkIGVudHJ5IElEIGZpcnN0Lg0KPiA+ICAJICovDQo+ID4gLQlvbGRf
aG9zdF9mbG9vZCA9IG5wLT5ob3N0X2Zsb29kOw0KPiA+IC0JbnAtPmhvc3RfZmxvb2QgPSBOVUxM
Ow0KPiA+ICsJb2xkX2VudHJ5X2lkID0gbnAtPmlwZnRfaGZfZWlkOw0KPiA+DQo+ID4gIAlpZiAo
bmV0Y19wb3J0X2FkZF9ob3N0X2Zsb29kX3J1bGUobnAsIHVjLCBtYykpIHsNCj4gDQo+IFtTZXZl
cml0eTogSGlnaF0NCj4gRG9lcyB0aGlzIGNvZGUgc2xlZXAgaW4gYXRvbWljIGNvbnRleHQ/DQo+
IA0KPiBUaGUgcG9ydF9zZXRfaG9zdF9mbG9vZCBjYWxsYmFjayBpbiBEU0EgZHJpdmVycyBpcyBp
bnZva2VkIHZpYQ0KPiBuZG9fY2hhbmdlX3J4X2ZsYWdzIChlLmcuLCB3aGVuIHRvZ2dsaW5nIHBy
b21pc2N1b3VzIG9yIGFsbG11bHRpIG1vZGUgb24gdGhlDQo+IGludGVyZmFjZSkuIFRoZSBuZXR3
b3JraW5nIGNvcmUgaG9sZHMgbmV0aWZfYWRkcl9sb2NrX2JoKCkgZHVyaW5nIHRoaXMNCj4gb3Bl
cmF0aW9uLCBjcmVhdGluZyBhbiBhdG9taWMgY29udGV4dCB3aGVyZSBzbGVlcGluZyBpcyBwcm9o
aWJpdGVkLg0KPiANCj4gSG93ZXZlciwgbmV0Y19wb3J0X3NldF9ob3N0X2Zsb29kKCkgY2FsbHMg
bmV0Y19wb3J0X2FkZF9ob3N0X2Zsb29kX3J1bGUoKSwNCj4gd2hpY2ggcGVyZm9ybXMgYSBzbGVl
cGFibGUgYWxsb2NhdGlvbjoNCj4gDQo+IAlob3N0X2Zsb29kID0ga3phbGxvY19vYmooKmhvc3Rf
Zmxvb2QpOw0KPiANCj4gQWRkaXRpb25hbGx5LCBpdCBjYWxscyBudG1wX2lwZnRfYWRkX2VudHJ5
KCksIHdoaWNoIGFsbG9jYXRlcyBhIERNQSBidWZmZXINCj4gdXNpbmcgZG1hX2FsbG9jX2NvaGVy
ZW50KCkgd2l0aCBHRlBfS0VSTkVMIGFuZCBjYWxscyByZWFkX3BvbGxfdGltZW91dCgpDQo+IHdp
dGggYSAxMHVzIHNsZWVwICh1c2xlZXBfcmFuZ2UpLiBFeGVjdXRpbmcgdGhlc2Ugc2xlZXBhYmxl
IG9wZXJhdGlvbnMgd2hpbGUNCj4gaG9sZGluZyBhIHNwaW5sb2NrIHdpdGggQkggZGlzYWJsZWQg
d2lsbCB0cmlnZ2VyIGEgc2xlZXBpbmctaW4tYXRvbWljIHBhbmljLg0KDQpGYWxzZSBwb3NpdGl2
ZS4gLnBvcnRfc2V0X2hvc3RfZmxvb2QgaXMgb25seSByZWFjaGVkIHZpYSBuZG9fY2hhbmdlX3J4
X2ZsYWdzLA0Kd2hpY2ggcnVucyB1bmRlciB0aGUgUlROTCBtdXRleCAoc2xlZXBhYmxlKSDigJQg
bm90IHVuZGVyIG5ldGlmX2FkZHJfbG9ja19iaCgpLg0KVGhhdCBCSCBzcGlubG9jayBvbmx5IHdy
YXBzIG5kb19zZXRfcnhfbW9kZSwgd2hpY2ggbmV2ZXIgdG91Y2hlcyB0aGUNCmhvc3QtZmxvb2Qg
Y29kZS4gU28gdGhlIGt6YWxsb2MvZG1hX2FsbG9jX2NvaGVyZW50L3JlYWRfcG9sbF90aW1lb3V0
IHNsZWVwcw0KYXJlIGFsbCBpbiBhIHNsZWVwYWJsZSBjb250ZXh0IGFuZCBzYWZlLg0KDQo=
