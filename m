Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234303E63AC;
	Mon,  7 Sep 2026 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796036; cv=fail; b=snkxruy9KLBLcazQwkwoov7BneZ0LSAjL/sc5LiyXUzmSMMTdOl/8E6j8o7ngrMyuUMGJQIvJDH9SF2EzYIijb2b6t/uVZHPJ8m/gk2Umf/175hq9oJLsz0Btz/Jf0+YFENhCqtNAsLyEqvfvPoxwgDWO9qI432S5wUkiTWMBGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796036; c=relaxed/simple;
	bh=JAaTD/uIX22yg6bmXPsaXnnJH8ymBsspzmU288XAef8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lLyNwmgmGJmRb/9BR3dP9QWitlWbQrAu/Cjmbj8F5Ro/NI9ZJOfahx5aT3A/MKwjkFayaju94XvrgL8+q8BOMHBsEi04ZWkBtzIWRtLs34u7W2krzQekaywKE3QXHrcVEq17YfQ9ECBqHx2gBwTuqYPJnfIPkaLBVQq7wjrWY/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zB/PoxsE; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zB/PoxsE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb2tL39gDEzM32lNA9YcON826ZRVBNKvS5bIGat46CjRniOo+1nBh9y2g2ErTw52Ni73u2zqP8OAhjRjfTsZtuQU/+c951pu/c4JKZzSRJxHLttjl2ZAoR+r1Jm0KIYbYDhVoed1nts0prPc2+zkF5ECoRRnXpvP+J2GePZQ7OqleKBT8C10Kk4ZssS6XXUJ/RUmP9cW7QhMtpoAblKfYz6NsJluvq6nJmEYDSTUBw+OJFlBtlgyPF4dTtOAIvU7fGSmvZOecqNDbxN3t+ZQY5MYlf1bdIx+8hwNRIjuR4W1jza0eC01FB3U+pjj9RZ/cYh8q8gySEX3B5gvGoyuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAaTD/uIX22yg6bmXPsaXnnJH8ymBsspzmU288XAef8=;
 b=IwACmtA8JtX30uZlhE6Ihqe758ztPN56h7oPqG1Oa/WPO9WhzCwKffmlI2llOcJmrnXEBkAQkL5OJFxhKCqwt5w7S/bHUyW2woj+yOgailsnTsMQzM+pVPLe3EKAp8kHG/5VVEzMZZEnEz9ItDTFDBmdDc+2Z1hwgp+S8W1IAFkbrbQ2RHSW3jZKTpvNBRrKZiAeqK94QYCEOMIuL6otIEg06UPGw6Rw3tIK5XBfwniUESuIzBvsvhnDzgae3awIfJWDzeMT8zDWdAOlHerluDCIbp6hUx/F+8HXkxOXJ2kJKzJT+OKalz/ZdPUhdXLxP1RDy16L4hqKBnATIroEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAaTD/uIX22yg6bmXPsaXnnJH8ymBsspzmU288XAef8=;
 b=zB/PoxsEyUWkn3zU4rkUq26+MZKBl6QllY1paOn25Of6pRmCUQS5cnr4aGPklw/ztRQdkoi5l5+UYu4W0wkSEe98YR7ZVYoNcVPz3qWKqGFJrOtDqDUpuRZtCfsRoP35lNbcmn02clplTz9Eqg/o0ey+otYcX4jGOCg18bNfcKWU6FG0DOK5kiGPVvezFU5SRw9UV89H3maGDJ3iK+WnLyccAn/Y7BzGcuIAzGzZop5nnr768E5iDjAZM3eqJUahsI+Sot/H5MlO/jgdsbKlR43wyp8BKt84GTOUEZLXEwGvKjnAUpXV43i63xDmnmBgUZ3R/7klm0iV+nEH/G6WXg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:47:07 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 15:47:07 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "shenwei.wang@nxp.com"
	<shenwei.wang@nxp.com>, "frank.li@nxp.com" <frank.li@nxp.com>,
	"wei.fang@nxp.com" <wei.fang@nxp.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: Re: [PATCH net-next v2] net: fec: support RX flushing via an ethtool
 private flag
Thread-Topic: [PATCH net-next v2] net: fec: support RX flushing via an ethtool
 private flag
Thread-Index: AQHdOeYqnRmLamjoCkyBNo2G2rNE1ba/Nc0AgAQWqoA=
Date: Mon, 7 Sep 2026 15:47:07 +0000
Message-ID: <371b9a61b150bce5f43e70a8032be4b4bc97e759.camel@siemens.com>
References: <20260901074732.113791-1-alexander.sverdlin@siemens.com>
	 <20260904182056.0d81cf1f@kernel.org>
In-Reply-To: <20260904182056.0d81cf1f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5148:EE_
x-ms-office365-filtering-correlation-id: ab4cb892-6e35-4be3-8b3d-08df0cf7459e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|55112099003|22082099003;
x-microsoft-antispam-message-info:
 xMhWtF96Y6jZo1iKn+0JQqQf0DC7caCiSfBUfgbbdbNVgEb4tWwjjsTy+uI1z6ozNDMsavHzWyJeURcHmMNMx05+rtPUUAczHp4CpAKH2oF8gKB4jCPp293xT7nsTLKY4WbmYShHlg/22jbVudbG6RZSx8pmkpglAuQCLd2ybbNIb2DNPLhpWdbw3UG5B4HyhTioDjPY2oYJDC0dk6o7zea5PhsoVop8e5FRGUDwgiWawL6ZhfNMnW3wT8WU5fOoIK8QaC/RExjNzfVKz+m3+fI7TL8K3tzyhSUS0SGfZZ9hY9H4p+AGDrxSLfbWvI0I+Ky2A+WjL8wNXBxpLTVHapnXQjPVwGeTtDziSp2KhYmZbTyUgPtuh+4mwTZ4a6j7H3b00Y7NdJbbgnq+kFh5RjW2ArZs4KUAYtl4rqLRh9L733Ln6TLABu0wKJx9g749dyWJldD4pkwNwVvizaYKC09rH3t7hlzKNYsNUlBGs5m7PhejcWK60lUx5kJixcpFOGod8bVQKkNbb3JxSmBJjEKfSX4wEzIDhk27y+pRwccb1T3mUT3i4aWDFA710hCWhklrnXeCzRufIZzv7ekL/+9RtBVQr4bgNPaR8IC3LjUtvUhNMFOq7wTNpvB+HQ+sRN7jixsoA24EYgz8Dp2vNE6e2guv2nt55LBeMMvjALU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emNyTjI1ZWVoQXNIMnhtZ3luR21GNGtXYUdoS2t0SnZvM1JlR20vaGVxbzhj?=
 =?utf-8?B?dXdWZ1FtSWZqWTZ3aThRVE01ZHdTaXMwL1dHWVlTRGpERURHUHZ5d3FCNDVD?=
 =?utf-8?B?WENNWHduTDZ0dFc1dWF2cE1KbzhielozbU13dlhwdUxJbWhqMndJeVlHS2tB?=
 =?utf-8?B?c2F0VWk3MWFrOVltTWhBbDZMQjIrV3BmMmtWdzI1alc1cERiazFzMG9GeXZy?=
 =?utf-8?B?Uy90ZTBHdENLNkQxbTBZY2hFTGZSWnlmNnIzU05mTnlUMzhpam4xUWVjT241?=
 =?utf-8?B?aHZrSEZjT1E4WUMrWi9vQXZBMEtOWVpUeW5ieTV1M0d5N3didCtyYmR4cXVs?=
 =?utf-8?B?T25OMEh2ZjJFMk4rWlJteGx3WnRwbnlWSGg5S2xYYWpEdzFnOEd6S05aT1E0?=
 =?utf-8?B?aDhzcDJHRDYvSjZuamY4akZtVHgrbFdyQ1MvNmhTUUduMWh4K1hhUXEybURl?=
 =?utf-8?B?TEptUi8vYWZ5L3pDNnl1c3NSSllJVWs3T1BQam5MdzE1bXBKMzlzbVRGdHlt?=
 =?utf-8?B?TDVYWUJRUjBDQ2dySWJJOGlISXhmbG1vdzdueS9nZ3ArV1Q3OUxyby9HNFlU?=
 =?utf-8?B?dS9VWmdNaHdEbGt6WUc2QTFwaUlOYTEyZ1ZWMTdpelN0Q0tkbDM1ZE5ITDhR?=
 =?utf-8?B?bFhnMjBWYkpNRU1DQ1VRQ0NQQWFXV1FIUktxNnJpUU84VDk0VUVGeUJZSE9o?=
 =?utf-8?B?Qm8zbjFvT3pWZk1XVUpZMnRkVDRBemNTbHMwejJ4djZ3TVBtamo5Wnp3S3Rn?=
 =?utf-8?B?THliYXJPUFlrV0huaTNLOVQyWEJoM2k3aFVZcjZZMGM2MzMzL2tCS004akFr?=
 =?utf-8?B?dXFCY3dTb05CRDhac09ySTBKNjAvQnVXeEdFNzZyL2hDVkd2VnhIc2pLbXZJ?=
 =?utf-8?B?TGRmaDIrUUh6Yncwb01zRWlPR05BcXpSNEVGc09uRElSQlRHZGQyVUdIVFkw?=
 =?utf-8?B?T253dWl4V3RmaEVrYVAycGU0U1M5eDlmTFNzMEJqR2VORE5adTE5SW5WSy92?=
 =?utf-8?B?MllrdEhsakRyQlVaTjNzR0t1Tk9wMXA2MXRlQzNsMTBlYjR2WmlUdml2QVN3?=
 =?utf-8?B?bysrZmlNaWJJK0lNcytHWGtuTzdMRFJnMWpldHpPWWExZEorTjNXSVRLS3JZ?=
 =?utf-8?B?RXNBNjV3TzZoRmNqYTM5b2tjMDZoWGc1VStoSWx5NVhtQjlPWjlkUU4rM0VQ?=
 =?utf-8?B?SC9rREZsaTN1dE1JbW1DbnppUENnaEJOVVB6ejZ2Z2V5TU0wWXJEQXRnQ3Zl?=
 =?utf-8?B?eDd1OXcrdllmdlhDdWxMa3oyWEV3K3JrVnJIMVZnL2s3NmEzam52TlhEUUNJ?=
 =?utf-8?B?Tk04TUJoUlZnR3g4R01DVGJlY3RaQW93dHNXLzc2cUVING5lNitIM3RjMlNk?=
 =?utf-8?B?cVF6eDlESW1LSzdzRklBbmNVVUs5KzZqRXF3WW02a1MvbDR0SW1KTWNFVmlk?=
 =?utf-8?B?NVFuemJnN2xGeXZyRUxDejBKazkrRUhCdkg4bHNERVg3cStDMGsrRVZLSVB0?=
 =?utf-8?B?MHNpbEx2eTJxckw4UTliN2E2U0N1MjZFb00zYVBWZURQQzJuMHV4emkxczBH?=
 =?utf-8?B?OW9NWG1mcWVNbjlLcnF0Nlk1L1VkaXgrVDM4NytJV2doa3pkbUNCcFpKL2NG?=
 =?utf-8?B?b0trY2NuRXM2WldubE1BUlY2SFg1WnlYSWxQZ0o4SUJ1ZjhZZ1JObi8zR0ZX?=
 =?utf-8?B?MFNpclFVSXJjQUIyZ3IzYkJFVTZ1RUZQMkFkOG81WWt4QmlBVEdJUzBtYkpB?=
 =?utf-8?B?djhLYUIrWHlFL2lJR3NVbysrTmJjSU5PdWxWcXgwOTF4NWlEcXNhOG0yOFFE?=
 =?utf-8?B?dVFTTjhrWEVKa3QwMSttN1V1T09KemJWZHB1UDl3d2RvRFd5eXBlbkh2bTEw?=
 =?utf-8?B?bFlWNTRld2NXTVNodXdKeUVNVDQrR1VwZ3lHejBTUEt4L2JrcEQ2OFFXQUdy?=
 =?utf-8?B?TGVHYkQzZ0lRendnaHhTWDNTRDA5OStxamFHd29jNTFpSDREOUJ4a3haRy9j?=
 =?utf-8?B?ZWdyOFNVNGpCRktWQXdmZmJKbUZ5TUkrVGRmc01kUXRFNk02dE9ySmxLYVBw?=
 =?utf-8?B?QmRDdkxweHdWSEJaMTNacDZzYjJyQWJSU3c3dHQ3ZU9MOTdJTVFTMGYyaFN1?=
 =?utf-8?B?Ukphcm5LU045U0prRGVFS21TTzZUcTByOGUzNDdBYnlOY0wyL1JJTHYzdDJO?=
 =?utf-8?B?OXR1aU5RTERCL0tob0dKdVJJdExJNkhkMWRWTWlhU2ZreGVBQkZiTFF6cGly?=
 =?utf-8?B?K20wVk5RN2xiZ0c3c2dhSkpuYjdLeEprcVJORGtoaStPSGxUb3UxMi9HWFEy?=
 =?utf-8?B?amJydWNDbFd6QWJVREhQVW81cWhyZWFIazV3TTBmM0UwdjVNUXZTNU44OFlR?=
 =?utf-8?Q?tstQVJoHG/498260=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1202E9936648B4696A0FF00481FC1E4@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4cb892-6e35-4be3-8b3d-08df0cf7459e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 15:47:07.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRIHgcoX+S6dOoF/Ii2h8ouLB6Lzc7j7KCQsFn+E7VsTKpnFYMM98iMCwjPWhuofC62JLfYqPS8DFOM/ZUNFmSytkfLFcnGx6kbNDr0eZ0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5148

SGkgSmFrdWIsDQoNCk9uIEZyaSwgMjAyNi0wOS0wNCBhdCAxODoyMCAtMDcwMCwgSmFrdWIgS2lj
aW5za2kgd3JvdGU6DQo+IE9uIFR1ZSwgIDEgU2VwIDIwMjYgMDk6NDc6MjkgKzAyMDAgQS4gU3Zl
cmRsaW4gd3JvdGU6DQo+ID4gVGhlIEZFQyBjb250cm9sbGVyIGNhbiBmbHVzaCB0aGUgUlggRklG
TyBvZiBhbiBpbmRpdmlkdWFsIHJlY2VpdmUgcXVldWUNCj4gPiB0aHJvdWdoIHRoZSBSWF9GTFVT
SG4gYml0cyBvZiB0aGUgRkVDX1FPU19TQ0hFTUUgKEVORVRfUU9TKSByZWdpc3Rlci4NCj4gPiAN
Cj4gPiBSWCBmbHVzaGluZyBwcmV2ZW50cyBmcmFtZXMgaW4gdGhlIFJYIEZJRk8gZnJvbSBiZWlu
ZyBibG9ja2VkLiBCbG9ja2luZw0KPiA+IGNhbiBvY2N1ciB3aGVuIHRoZSBmcmFtZSBhdCB0aGUg
aGVhZCBvZiB0aGUgUlggRklGTyBjYW5ub3QgYmUgZm9yd2FyZGVkDQo+ID4gYmVjYXVzZSB0aGUg
cmluZyBpdCBpcyBhc3NvY2lhdGVkIHdpdGggY2Fubm90IGFjY2VwdCBpdCwgaS5lLiB3aGVuIHRo
ZQ0KPiA+IHJpbmcncyBSeEJEW0VNUFRZXSBpcyBub3Qgc2V0IG9yIEVORVRfUkRBUm4gaXMgbm90
IHNldC4gV2hlbiBSWCBmbHVzaGluZw0KPiA+IGlzIGVuYWJsZWQgZm9yIGEgcmluZywgc3VjaCBh
IGJsb2NraW5nIGZyYW1lIGlzIGZsdXNoZWQgKGRpc2NhcmRlZCkNCj4gPiBpbnN0ZWFkIG9mIHN0
YWxsaW5nIHRoZSBGSUZPIGFuZCBob2xkaW5nIHVwIHRoZSBvdGhlciByaW5ncy4NCj4gPiANCj4g
PiBFeHBvc2UgdGhpcyBwZXItcXVldWUgY2FwYWJpbGl0eSBhcyBhIHJ1bnRpbWUgZXRodG9vbCBw
cml2YXRlIGZsYWcNCj4gPiAoInJ4LWZsdXNoLXFOIikuDQo+ID4gDQo+ID4gRHVlIHRvIGVycmF0
dW0gRVJSMDUwMzk1IChvYnNlcnZlZCBlLmcuIG9uIGkuTVg4UVhQKSwgZW5hYmxpbmcgUlggZmx1
c2hpbmcNCj4gPiBvbiBtb3JlIHRoYW4gb25lIHF1ZXVlIGF0IGEgdGltZSBjYW4gbG9jayB1cCB0
aGUgcmVjZWl2ZSBwYXRoLCBzbyBvbmx5IGENCj4gPiBzaW5nbGUgcXVldWUgbWF5IGhhdmUgZmx1
c2hpbmcgZW5hYmxlZC4NCj4gPiANCj4gPiBBY2NvcmRpbmcgdG8gaS5NWDhRWFAgUmVmZXJlbmNl
IE1hbnVhbCwgIndoZW4gYm90aCBjbGFzcyAxIGFuZCBjbGFzcyAyIGFyZQ0KPiA+IGRpc2FibGVk
LCBSWCBmbHVzaGluZyBmb3IgdGhlc2UgcmluZ3MgbXVzdCBhbHNvIGJlIGRpc2FibGVkIi4gQm90
aCBSWCBhbmQNCj4gPiBUWCBRb1MgY2xhc3NlcyBhcmUgZW5hYmxlZCB2aWEgRE1BX0NMQVNTX0VO
IGJpdCwgY3VycmVudGx5IHRpZWQgdG8NCj4gPiBudW1fdHhfcXVldWVzIGluIHRoZSBkcml2ZXIu
IEN1cnJlbnRseSB0aGVyZSBhcmUgbm8gY29uc3RyYWludHMgb24NCj4gPiBudW1fdHhfcXVldWVz
ID09IG51bV9yeF9xdWV1ZXMsIG5laXRoZXIgaW4gRFQgbm9yIGluIHRoZSBjb2RlLCBldmVuIHRo
b3VnaA0KPiA+IGhhdmluZyBkaWZmZXJlbnQgdmFsdWVzIGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNl
IGV2ZW4gd2l0aG91dCBSWCBmbHVzaGluZy4NCj4gPiBSWCBmbHVzaGluZyBjb2RlIGp1c3QgdGFr
ZXMgbWluKCkgb2YgdGhlIGJvdGggdmFsdWVzIGZvciBub3cuDQo+IA0KPiBGb3IgdGhlIGVycmF0
YSAtIGhvdyBpcyB0aGUgdXNlciBzdXBwb3NlZCB0byBwaWNrIGEgcXVldWU/DQo+IFRoZSBkb2N1
bWVudGF0aW9uIHRhbGtzIGEgbG90IGFib3V0IGRldmljZSBzcGVjaWZpYyB0ZXJtcyBpbnN0ZWFk
IG9mDQo+IHVzaW5nIGdlbmVyaWMgZWFzaWx5IHVuZGVyc3Rvb2QgdGVybXMuIElPVyBpdCByZWFk
cyBsaWtlIHNsb3AuDQoNCkZhaXIgcG9pbnQgb24gdGhlIHdvcmRpbmcsIGxldCBtZSByZS1waHJh
c2U6DQoNClRoZSBGRUMgaGFzIGEgc2luZ2xlIHNoYXJlZCBSWCBGSUZPIHRoYXQgZmVlZHMgbXVs
dGlwbGUgRE1BIHJpbmdzIHZpYQ0KaGFyZHdhcmUgY2xhc3NpZmljYXRpb24uIFRoZSBGSUZPIGlz
IGRyYWluZWQgc3RyaWN0bHkgaW4gb3JkZXIsIHNvIGlmIHRoZQ0KZnJhbWUgYXQgaXRzIGhlYWQg
aXMgY2xhc3NpZmllZCB0byBhIHJpbmcgdGhhdCBjdXJyZW50bHkgY2Fubm90IGFjY2VwdCBpdA0K
KHRoZSBob3N0IGhhcyBub3QgcmVwbGVuaXNoZWQgdGhhdCByaW5nJ3MgZGVzY3JpcHRvcnMpLCB0
aGF0IG9uZSBmcmFtZQ0KaGVhZC1vZi1saW5lLWJsb2NrcyB0aGUgZW50aXJlIEZJRk8gYW5kIHN0
YXJ2ZXMgYWxsIG90aGVyIHJpbmdzLA0KaW5jbHVkaW5nIGhpZ2hlci1wcmlvcml0eSBvbmVzLiBS
WCBmbHVzaCBsZXRzIHRoZSBNQUMgZHJvcCBzdWNoIGEgYmxvY2tpbmcNCmZyYW1lIGluc3RlYWQg
b2Ygc3RhbGxpbmcgdGhlIHdob2xlIHBvcnQuDQoNClNvIHRoaXMgaXMgbm90IGEgZ2VuZXJpYyAi
cXVldWUgZnVsbCAtPiBkcm9wIGl0cyBvd24gcGFja2V0cyIgc2l0dWF0aW9uLg0KT24gYSBjb250
cm9sbGVyIHdpdGggaW5kZXBlbmRlbnQgcGVyLXF1ZXVlIEZJRk9zIGEgYmFja2VkLXVwIHJpbmcg
b25seQ0KZHJvcHMgaXRzIG93biB0cmFmZmljOyB0aGVyZSBpcyBubyBjcm9zcy1xdWV1ZSBpbXBh
Y3QuIE9uIEZFQyB0aGUgc2hhcmVkDQpGSUZPIG1lYW5zIGEgbG93LXByaW9yaXR5IHJpbmcgY2Fu
IHN0YWxsIGEgaGlnaC1wcmlvcml0eSBvbmUsIHdoaWNoIGlzIHRoZQ0Kc3BlY2lmaWMgcHJvYmxl
bSB0aGlzIGtub2IgYWRkcmVzc2VzLg0KDQpJbiBwcmFjdGljZSBhIHVzZXIgd291bGQgZW5hYmxl
IHRoZSBmbHVzaGluZyBvbiB0aGUgbG93ZXItcHJpb3JpdHkNCnJpbmcocykg4oCUIHRoZSBvbmVz
IHdob3NlIGJhY2tsb2cgeW91IGFyZSB3aWxsaW5nIHRvIGRpc2NhcmQgdG8ga2VlcCB0aGUNCkZJ
Rk8gaGVhZCBjbGVhciBmb3IgaGlnaC1wcmlvcml0eSB0cmFmZmljLiBUaGUgcXVldWUtPnByaW9y
aXR5IGFzc29jaWF0aW9uDQppcyBoYXJkY29kZWQgaW4gdGhlIGRyaXZlcjogVkxBTiBQQ1AgMOKA
kzEgKGFuZCB1bmNsYXNzaWZpZWQpIC0+IHJpbmcgMCwNClBDUCAy4oCTNCAtPiByaW5nIDEsIFBD
UCA14oCTNyAtPiByaW5nIDIuDQoNClRoZXJlIGFyZSBhY3R1YWxseSB0d28gY29uc3RyYWludHMg
c3RhY2tlZCBoZXJlLCBhbmQgSSBzaG91bGQgaGF2ZSBtYWRlDQpib3RoIGV4cGxpY2l0IGluIHRo
ZSBjb21taXQgbWVzc2FnZSBhbmQgZG9jdW1lbnRhdGlvbjoNCg0KLSBXaHkgZmx1c2ggaXMgbmVl
ZGVkIGF0IGFsbDogYSBsb3ctcHJpb3JpdHkgcmluZyBjYW4gaGVhZC1vZi1saW5lLWJsb2NrDQph
IGhpZ2gtcHJpb3JpdHkgcmluZyB0aHJvdWdoIHRoZSBzaGFyZWQgRklGTy4NCi0gRXJyYXR1bSBF
UlIwNTAzOTU6IG9ubHkgb25lIFJYX0ZMVVNIIGJpdCBtYXkgYmUgc2V0IGF0IGEgdGltZSwgc28g
b25seQ0Kb25lIHJpbmcgY2FuIGJlIHByb3RlY3RlZCB0aGlzIHdheS4gV2l0aCB0aHJlZSByaW5n
cywgdGhlIHJlbWFpbmluZw0KcmluZyBtdXN0IGJlIGd1YXJhbnRlZWQgbm90IHRvIHN0YWxsIGJ5
IG90aGVyIG1lYW5zIChsaW1pdGluZyBsaW5rIHJhdGUsDQpmb3IgaW5zdGFuY2UpLg0KDQpTbyBi
ZWNhdXNlIG9mIHRoZSBFcnJhdGEgd2UgY2Fubm90IHNldCBSWF9GTFVTSCBpbiBxdWV1ZXMgMSBh
bmQgMiwgYnV0DQppZiBQQ1AgNS03IGJhbmR3aXRoIGlzIGFscmVhZHkgbGltaXRlZCBpbiBIVywg
d2UgbWlnaHQgd2FudCB0byBzZXQgUlhfRkxVU0gNCm5vdCBpbiByaW5nIDIsIGJ1dCBpbiByaW5n
IDEuDQoNCj4gSW4gZ2VuZXJhbCBBRkFJVSB0aGUgZmx1c2hpbmcgc2hvdWxkIGJlIGVuYWJsZWQg
aW4gdGFuZGVtIHdpdGggcGF1c2UNCj4gZnJhbWVzIHJpZ2h0IG5vdy4gSXQnZCBiZSBncmVhdCBp
ZiB3ZSBjYW4gc3RpY2sgdG8gdGhhdCwgb3IgZmFpbGluZw0KPiB0aGF0IGFkZCBhIGdlbmVyaWMg
Y29uZmlnIGtub2IgcmF0aGVyIHRoYW4gcHJpdmF0ZSBmbGFncy4NCj4gVGhlcmUncyBub3RoaW5n
IHByaXZhdGUgYWJvdXQgdGhlIGRyb3AgZGVjaXNpb24gd2hlbiBob3N0IHJpbmcgaXMgZW1wdHkN
Cg0KSSBkb24ndCB0aGluayB0eWluZyBpdCB0byBwYXVzZSB3b3JrcyBvbiBGRUMsIGJlY2F1c2Ug
cGF1c2UtZnJhbWUNCmdlbmVyYXRpb24gaXMgcG9ydC1nbG9iYWwuIFRoZXJlIGlzIGEgc2luZ2xl
IGZsb3ctY29udHJvbCBlbmFibGUgYW5kIGENCnNpbmdsZSBwYXVzZS1xdWFudGEgc2V0dGluZywg
ZHJpdmVuIGJ5IHRoZSBzaGFyZWQgUlggRklGTyB0aHJlc2hvbGRzLg0KVGhlcmUgaXMgbm8gcGVy
LXJpbmcgcGF1c2UuDQoNCkkgZnVsbHkgYWdyZWUgdGhlcmUgaXMgbm90aGluZyBwcml2YXRlIGFi
b3V0ICJkcm9wIHdoZW4gdGhlIGhvc3QgcmluZyBpcw0KYmFja2VkIHVwIi4gSWYgd2Ugd2FudCBh
IGdlbmVyaWMgdUFQSSwgdGhlIG5hdHVyYWwgc2hhcGUgd291bGQgYmUgYQ0KcGVyLXF1ZXVlIGF0
dHJpYnV0ZSAoZHJvcC1vbi1iYWNrcHJlc3N1cmUgLyBmbHVzaCksIG5vdCBhIHBhdXNlLWxpbmtl
ZA0Kb25lLCBzaW5jZSB0aGUgZGVjaXNpb24gaXMgaW5oZXJlbnRseSBwZXItcmluZy4NCg0KRG9l
cyB0aGUgYWJvdmUganVzdGlmeSB0aGUgZXRodG9vbCBwcml2YXRlIGZsYWcgaW4geW91ciBvcGlu
aW9uLCB3aXRoIHRoZQ0KZml4IGJlaW5nIGEgbXVjaCBiZXR0ZXIgY29tbWl0IG1lc3NhZ2UgYW5k
IGRvY3VtZW50YXRpb24gb3IgZG8geW91IGhhdmUNCmEgbmV3IGdlbmVyaWMgdUFQSSBwcm9wb3Nh
bCBpbiBtaW5kPw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNp
ZW1lbnMuY29tDQo=
