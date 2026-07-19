Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984038D011
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470060; cv=fail; b=ZXML0k5e9/fK4YsiTtoqZcuJhytJQO+cGFXv3IYEOBkTlTu0dXtTA2ZtVwAbRpO8VLXGYSJrUB+YfUK3o19//KPxxfYRRfJ7S8X+EQ6xRvaJz5Ldr/Q4YylUWaT+iViyEOHcW/C20VLv53TcigHYsoN2ScEz+gMVuIPwK+SKxHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470060; c=relaxed/simple;
	bh=UvVWTi9iei2aBurRBrZaX9KUyA/KvQeRNn7wuhpYAK8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FsfpX1dleRuEdvjhW0Bjtr8Mrhcmz6h0YrYuB3w6nKR7+YMszoGf97stgEs4w9T6/ze3raMvWK763EA7gQuTNQSo8SZtJQ6IqPQHzVOyCuVPPlgT6A6tP2aH0IFgBuTAm1i769tya5+AspsV4lmWcDi/TpXpcsT7GAskuU7oTlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VnSn8TGB; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VnSn8TGB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7oHduwJ6VZk+r47YxJwe9BJgaXkX6yNrBcCyyMdg39CAlyuhOy/dSuXbtecV8RgbgR8g+xgTpQi7lSzHybFWI+C5TFpQnSbVt4LHs9yJPcbQEqNU/z7rFT2ujBRF8JOCq2EUiUYyM8PX2zUv8h/p1R3Dw85y+wQiHldJZPEja4PiHvlF/kptsNNfoELL+fYUQ2zvtem8ihSplQqpp02Z3w5bh4oiNgm5AitTM2XKWL4vZNkoa4NcNi6gwmaa95LIhl1z5CYkRwAb7sdrerolCOdBavTvQfWjP981V4Ad4Gi+4tZwoZTHZSO6Sh0bP84/OhoZnupkS7NHSA9DnDaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvVWTi9iei2aBurRBrZaX9KUyA/KvQeRNn7wuhpYAK8=;
 b=g41prX7/SSXIKrBGOgsDbvg1J44Khpv82k5f8hyNyWZx3EpkG9v7h1+q6xSI4EqXD7zUp625QGfvXIve8IPwJ+c8cnoa31GHNNgvpryM4tPDGI3Mhy7mbypwSCEwyQZe5Is2b3Hu5SnGh0H29aUE4eQMinxeWr81gc2GO90bR2HPujtr+Sfgv/bjXUseD53UauKIjNtm8+7Wg5LV+mH9nJQQTr7TUvkYf6mv6SHdRJCKHettBznceR8mX/6Lhrx9GgYaSKsIHEEmXmlYckDh3uTEUyWmSHvxr7/CEMScbgun5pQFupyStbmeRbf10oCbUooaHEoMDe9jdPIK7LDr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvVWTi9iei2aBurRBrZaX9KUyA/KvQeRNn7wuhpYAK8=;
 b=VnSn8TGB4SIdsizmxf3yhAjN7z66w4ouhX48lxVuSW6brZajEzCJ5e4hq/E44zj+44q2/qkyaB841lvdrMTAH1nEn+Eyi/nkOgULFLgjLgNmtcvwR/Ub6XCsn4RAOpGxwEFh1tH+ZyluA8D75QQxkUNJ8iUng0OSy1Q0jDUh51xvliScKeJFQmBHGCw4Mo2a57maJ0SjZz7Tezur00xTCDOwWtqQXyf2ML7fMDCP0XXECrHhOEuGZeLmWRFqSklt69mfRFMeESuLeaOyep7VwlRwyVu/c7eBryYG+HSypWbGJpeVrLaeUEtNiphN/n1ePkBZd8u5TLujuMP9HmvdBQ==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 14:07:34 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0223.011; Sun, 19 Jul 2026
 14:07:34 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jbe@pengutronix.de" <jbe@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH ethtool-next v3 1/3] sfpid: print all implemented options
Thread-Topic: [PATCH ethtool-next v3 1/3] sfpid: print all implemented options
Thread-Index: AQHdF12y90666wDHhE6jGy+woa+YjbZ04PdA
Date: Sun, 19 Jul 2026 14:07:34 +0000
Message-ID:
 <SJ2PR12MB9008DB9952399B124CA4474BD8C42@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260719090458.659332-1-olek2@wp.pl>
In-Reply-To: <20260719090458.659332-1-olek2@wp.pl>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH3PR12MB8330:EE_
x-ms-office365-filtering-correlation-id: 836dd929-e6a5-4f40-1f95-08dee59f1508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|3023799007|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 fGFB1jwvhdRh1ueRcyStBiNIkjrxgYLadXpNpIVlzzUOjctqJp3KM8OlwgUhtMwp2TVzqjoRC5Ugqh/9leCY1HeIGrPCqnBXn3ckrLi5sg2E486YexYgFryZnT3Yol3mItXLyv5H0d0GrigA82zvJeI4nMhBEK4GD7Q8L3qvFrvv7mFYSgOQLZ+v0CY1E713hobZnnE04dzYGdEMinCuIwkB4X05DHiNy2GBOizyVFRuF4izdoNGfAbJRrqDk1hjzwKKW9c/3AJNiLbHhmYSqq0HqM4B6xMELO6oeKwgQF43twOdnEVBMhk6AKMyDgegIKLX98brq6/sgwefY22iQBjtydPAvo3+T+uZ+Oe6kmefC5A/F1LSy21H1lzZnLAVgZ2h7aoH4KbWnIQH/x5HJqB8Q18/uWXEL8oH3/0tbHSGLerfMnq1OBzi6bnfMlpwa+KgWoPzwBbyjjkf2L4gbJJqAtqKd4NWlbQuuLp+d1rObWZbCZYHg1O+mwqMk5tDMLrkn6D6OuYxk6z9cfqSLZNHmolU5JfjagwruygscOnDAm8UmVIOpck8YENvdCxGgSZiEGixm0LFT4kEU/dTo15EyENoe0ykecKhGuRW/BNExJHO9avBj20JTrSrIjeGWYHR7jfpxUAbHIvk0YM8eeeoU5KbjT7iSJEN3/0QlbXZ7QpUUiJRujCY2b37z54i+1K/colKPXANKhxWsDyT/VvM1x9CNh55ac8IL1vz2eI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDBEMEtWd3MzNUV1Q0tsdlV4UUlkWlpjcUVadkgrWnp2a3BWMG95ME01VGt1?=
 =?utf-8?B?S2FmNEQzaXNlNnB6bEVhZGtCZGlxM1Bjdkt0amZOS1pmOE16NWNjWEVJVG5W?=
 =?utf-8?B?blllYnRINnluTWFjWktqQmlMb25rODdzOVBLVTFER3ZLN2N5Z0wxOWhGYWlM?=
 =?utf-8?B?akQ1VHdTYjcwUHFqY1pQZlMxK3dsdTg2QW9LWXI2bWh5TVZOOXI3cVc2STlP?=
 =?utf-8?B?OWRoSWxNb1NZWjlWWHZ6S3d2VmFqWUdDQlVadDhCS0pkRkZYOHNuQkg2dkxG?=
 =?utf-8?B?WThJS25KTGxzSUxFMHVIODl6WU9zaDdVc3pRMkNBTTJ6dkcvVmdrR3EzNTY5?=
 =?utf-8?B?OUJQa0NsdFlCREFtYmtWQVFuRXFlZDVrNVdjNEYrZ1V3TjFrbmZsckdXNWJ2?=
 =?utf-8?B?Mjk0Y1Q3WjZRcXkyVG1lWDkzQThTVVlRVXhkcm8yTEx6dU83eXVJemNjKzJy?=
 =?utf-8?B?d2ZZVTBZdFFrV3M0bHBsL2d4UjVzdmlaZE1VMG5Ed3lqVExMQ2VNKzV6SHJh?=
 =?utf-8?B?UU93K0xaVHgvc0hwVGJMYXJHOVB4Vmp4d2l2alVDT1ZoMERSd3FudlBSd3N5?=
 =?utf-8?B?ZFdCSGZGMFg3ajZ1WHFwZ1VhU3ozWXd4d0xQOThTTzljQzZiR2RkQVZJZmNu?=
 =?utf-8?B?YmN5d1BQZWptelFpNDFZaHo4dk9xbGVESXdxSmhyNzdZUFdUVEJma0FtZjRi?=
 =?utf-8?B?SSswajBsK1U3K3B0S24zUFFuT0EvQVFzd29ELzIxNXJDWFM1aStzMnJwbXhx?=
 =?utf-8?B?Q3JrZDk1TUhucjhIU3M0NjdwZGJLNjNNdThEbUN2OW9zRkl0Q1NsTnhYM3Q3?=
 =?utf-8?B?dVQ0dzdWb05WUnV6a3lVTUtMOVREUnBKOGc4aGZQalo1UFU5ZUhVaGFBMXpK?=
 =?utf-8?B?aXB2Uk0vdU52SmE2T1hRcmJYYVB2V0lLYnZmMWluVTZKK1RIVXI4ckRZVlIw?=
 =?utf-8?B?TXRxMjVKb29ybTFRUHpUSnVCelNUbUcydEQ2QzRvSndaYzFCTzNVRWpVNU0z?=
 =?utf-8?B?dzVXWUhCa1dkTVBHWkZLT0hQRkE2OWxWRkh3ZzNvOWVNM2RNRXA5RXBDZTBY?=
 =?utf-8?B?RFZCOVJZUHYvU3ZNeVJPRDVnU1VqQWp2b0NCWFpXQ0dVNmRKTkFzSk9NL1ZK?=
 =?utf-8?B?TTF6bWh6eGpKL2JHQ1BXNWcySFZRMVRZME1DTW1kZTgvQVNpY25XZnNqUER5?=
 =?utf-8?B?eStKSnROZmdlNlJ1WklvOHpNb2NBSGRDS2l1b3JqMEE2WFBndlo3UldkbWd5?=
 =?utf-8?B?Y2wzSUgzeFdvVk5OalVxbzlHUzVUS2w2S3J3SzBIb01EeFZwakVCZEdITlAw?=
 =?utf-8?B?YlRMUVFrdjJTdHBYdjhBUE41THFuRVlIcW10b1c2VnF1NDRaeEdseVIrNHVP?=
 =?utf-8?B?Yk96eVR2ZE5CK2JhNUEwdEJ4Nm1DcjJwd0pCN3FRYUFjY1JwK1QwaEhIY2w4?=
 =?utf-8?B?VXpMWkw0bnZBNnVpNzhraUhtUnZDdnA1d3EyTVBjSkJQaWtqbG0raFdvYnFq?=
 =?utf-8?B?cnhJK3cvVERvK1FSeTAxMkwxMUJMTTZCQkN0RDZzTWpXWVBraDBmZXdRd0Jq?=
 =?utf-8?B?bytZaE1ZLzRpUUlsQUgxaGJzQTFRUm9yWWRQT3ZSdndKY2xNR2k3MEtvbUxq?=
 =?utf-8?B?ZGpPcWhWRjVOclplNjBISEtra3ozdUw0NTBRU21Tb0hzalVmT0Z6S2tnWWg0?=
 =?utf-8?B?YXJCY0lkZ1V4cHpBNjk4bzBCUFBKdGJkK084a1ZsM2ZPSGpUR1VVaHgrTDlR?=
 =?utf-8?B?N21hK3ZFcDZBNmdoRzhzR3MzZDk2NmZ6L0dDRHlDcXNnaUxsRE1aYm42TDI3?=
 =?utf-8?B?NjNMZ2p1b1Riem5yZ1VaUjBhVDY5YUpJdVZnZnhxNExCb2VjMVNvOWgySGtT?=
 =?utf-8?B?WG1zMDNaM1F6Wm9NcnlsZVJvZU4zaS94TC9JNEhLcThWMUNJSnhJYjhqbGpz?=
 =?utf-8?B?UUpadjNrMkNyeW1lYkRrazNTNVBuUlJmbWdaYjhPODNieDBicjZMU204RFZE?=
 =?utf-8?B?SlhqVDVuaU9KTnhIbDY1S2JYMlpxK1oxeXJRSEUyOTRhYlh0Q0lyZE1oWVBX?=
 =?utf-8?B?T1VKSFdIQUIyYSt6ZXZuRTdQRFhPT1RBMEx5c1NKQ3lXR1lQWFE2Nm1lSHN3?=
 =?utf-8?B?T1JqQjgxZHRDVDEzM1VoS29sb0RObjlxY1hveUtGUldHZGNML0d1Z1FuMlgr?=
 =?utf-8?B?dVZwblI5Q1lWVkNUOER3dEE2K3ZBQlQrRWR2NDJnYlBWT2ZQQTk3UmxjcXRE?=
 =?utf-8?B?aEhjRVV6b0xTcUpYNStwMitETUJ4aE9TQjVHd2RXbGlFV2Z4WW1zZEdKdzlN?=
 =?utf-8?Q?kPFdowzC1cQPPrssqF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836dd929-e6a5-4f40-1f95-08dee59f1508
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2026 14:07:34.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2aMpg2HKDSBAEHapQMRQXa35g0oizXv/3TK6zskPKZ6kE0aCnEquD9yiz1cjiZhkLpTx6cyrlP7ojtL02T09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGVrc2FuZGVyIEphbiBCYWpr
b3dza2kgPG9sZWsyQHdwLnBsPg0KPiBTZW50OiBTdW5kYXksIDE5IEp1bHkgMjAyNiAxMjowMQ0K
PiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG9sZWsyQHdwLnBs
Ow0KPiBta3ViZWNla0BzdXNlLmN6OyBhbmRyZXdAbHVubi5jaDsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0
LmNvbTsNCj4gamJlQHBlbmd1dHJvbml4LmRlOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFtQQVRDSCBldGh0b29sLW5leHQgdjMgMS8zXSBzZnBpZDogcHJpbnQgYWxsIGltcGxl
bWVudGVkIG9wdGlvbnMNCj4gDQo+IFNGUCBtb2R1bGVzIGltcGxlbWVudCBtdWx0aXBsZSBvcHRp
b25zLiBCZWZvcmUgdGhlIOKAnGpzb27igJ0gb3B0aW9uIHdhcw0KPiBpbnRyb2R1Y2VkLCBhbGwg
b3B0aW9ucyB3ZXJlIGxpc3RlZC4gQ3VycmVudGx5LCBvbmx5IHRoZSBsYXN0IG9wdGlvbiBpcyBs
aXN0ZWQuIFRoaXMNCj4gY29tbWl0IGZpeGVzIHRoaXMgYnVnLiBPcHRpb25zIGFyZSByZXByZXNl
bnRlZCBhcyBhcnJheS4NCj4gDQo+IEJlZm9yZToNCj4gJCBldGh0b29sIC1tIHNmcC13YW4NCj4g
Li4uDQo+IAlPcHRpb24gdmFsdWVzICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IDB4MDAg
MHgzMg0KPiAJT3B0aW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBSQVRF
X1NFTEVDVCBpbXBsZW1lbnRlZA0KPiAuLi4NCj4gJCBldGh0b29sIC0tanNvbiAtbSBzZnAtd2Fu
DQo+IFsgew0KPiAuLi4NCj4gICAgICAgICAib3B0aW9uX3ZhbHVlcyI6IFsgMCw1MCBdLA0KPiAg
ICAgICAgICJvcHRpb24iOiAiUkFURV9TRUxFQ1QgaW1wbGVtZW50ZWQiLCAuLi4NCj4gICAgIH0g
XQ0KPiANCj4gQWZ0ZXI6DQo+ICQgZXRodG9vbCAtbSBzZnAtd2FuDQo+IC4uLg0KPiAJT3B0aW9u
IHZhbHVlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiAweDAwIDB4MzINCj4gCU9wdGlv
biAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogUlhfTE9TIGltcGxlbWVudGVk
DQo+IAlPcHRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IFRYX0RJU0FC
TEUgaW1wbGVtZW50ZWQNCj4gCU9wdGlvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDogUkFURV9TRUxFQ1QgaW1wbGVtZW50ZWQNCj4gLi4uDQo+ICQgZXRodG9vbCAtLWpzb24g
LW0gc2ZwLXdhbg0KPiBbIHsNCj4gLi4uDQo+ICAgICAgICAgIm9wdGlvbl92YWx1ZXMiOiBbIDAs
NTAgXSwNCj4gICAgICAgICAib3B0aW9uIjogWyAiUlhfTE9TIGltcGxlbWVudGVkIiwiVFhfRElT
QUJMRQ0KPiBpbXBsZW1lbnRlZCIsIlJBVEVfU0VMRUNUIGltcGxlbWVudGVkIiBdLCAuLi4NCj4g
ICAgIH0gXQ0KPiANCj4gRml4ZXM6IDQwNzE4NjJmNThkOCAoInNmcGlkOiBBZGQgSlNPTiBvdXRw
dXQgaGFuZGxpbmcgdG8gLS1tb2R1bGUtaW5mbyBpbg0KPiBTRkY4MDc5IG1vZHVsZXMiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGVrc2FuZGVyIEphbiBCYWprb3dza2kgPG9sZWsyQHdwLnBsPg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gIC0gZml4IGluZGVudGF0aW9uIGFuZCBjaGVja3BhdGNo
IHdhcm5pbmdzIENoYW5nZXMgaW4gdjI6DQo+ICAtIGZpeCB0eXBvIGludHJvZHVjZWQgLT4gaW50
cm9kdWNlZA0KPiAgLSByZW5hbWUgbW9kdWxlX3ByaW50X2FycmF5X3N0cmluZygpIC0+DQo+IG1v
ZHVsZV9wcmludF9hbnlfYXJyYXlfc3RyaW5nX2VudHJ5KCkNCj4gLS0tDQogDQpSZXZpZXdlZC1i
eTogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCg==
