Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020117.outbound.protection.outlook.com [52.101.56.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA63033F5;
	Sat, 25 Jul 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949742; cv=fail; b=APCGngNLxHcmwXOQQ536YN5wcsjOAPKdDFySvtixvunI8O8iguZ5jSjpkGw73/9q1sBL5cabhW7eYZc/EKBpwUY1MZU0iQ11oDUlwu2YZyANb4vQZotUWvefmW4coYqX3XoGxXJOgQjyLQ7I7vKc0hoMaatchZpU0PxllOtYw6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949742; c=relaxed/simple;
	bh=zTZeu4+z3iJkhirnxvgRrU+CWs3+8+yxK+jzybw6pRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHu+ZCFXHaAEcewX5dXl978xpSlrKppiEpYxaKJAgFK+4Lwu+tzo0ov8KY3KBv6BmwWH+vXvEjrpd7BTFYKCzW2gizclU+z/WWq1sjqZOOJeYi6XJVlYSgHyKI4qxXxuoZWvHffjcpe3BuvhnDw2Jke8e+1gqyUTFX6uX3N5bp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com; spf=pass smtp.mailfrom=Mahcom.com; dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b=yHQL8Rqc; arc=fail smtp.client-ip=52.101.56.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Mahcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Mahcom.com header.i=@Mahcom.com header.b="yHQL8Rqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvKh89vWWWTmLjC22Lfpb3CtU7MEjN4tGd4eceH9RsSWKhOGvR14Z4ULR7x7ChYUDQs+SJqHAOZNmNqX5Jocd6FKQXfO3otIJQDOb7hhEutvLkuCZrHeR7D0slQZnpxYplrP6LrAt0k+nCM1r480TJGXhDnXwaAmVD09eA9buZ/yaHvAPXQRvZKc1r2Wx+woFVHkjsqI70rY/7Bss2t7TvabX1ODWLbdp5B48cfomYorScPSmeylaSs3kI0Yz7UFTvP7F+Yw/LkS3YwNsr0AyA3hlUNwGT164fJdDkoAhQbJKL6BT9bmCMNmOTfPZyROvBDgcIvLD9vk2NlqBaNh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTZeu4+z3iJkhirnxvgRrU+CWs3+8+yxK+jzybw6pRY=;
 b=Ds+ToG4ehNRt7AZAdkwUuhl2TwMNHxvhkBueUso8RTQRkm28exwdJ3N1hsnLip/1w4+i3/yck2/s7riim6lqCkjY62vKr2di00SI1f2qW5LhkA1TBOtBhzvAucOFfvCVcppdcsm+T4udMZ0UhprTYhEx+WRF9LuzQ9Q0wLSrkJPC1fFL7AYxH7hD0AiS5263ptSNAejUkBjfC08lggl/QP0uruCf/UKBxPKj7mFy4hXrZOBh4ZD4rDF8yE2Fqttusg30Ch1Vdr/wEZ/PWgkeujuqVnJP4//skwzzuH5GZ0ObnvcH3+R7H6+0TXsSeTSWdF+RQXfKyWt7PAxAyj6tYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mahcom.com; dmarc=pass action=none header.from=mahcom.com;
 dkim=pass header.d=mahcom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mahcom.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTZeu4+z3iJkhirnxvgRrU+CWs3+8+yxK+jzybw6pRY=;
 b=yHQL8Rqc7AXX1Qz4FBimK2UT1YU8zUBmVbQ4od7AT5Vob2by5bkzedjL7J6W3m+XbIoaTV1pEazXPv26HNFZMDoOxE0L1AwDupWemNU41dcJ2ETnq9MtB0wno3JkO8baz9u7MenRy85nOIu6ZXyVw/T4eaBsnqEZfmArZI/sJXdUSkz3b0/pX/DZa//01dkiBWzF9sAQvM3C0wXCWLepft6NVyNUeNWgFrNffzFurEmiROvbfj/Rs/q/g0Pd0IzyouNn+ALYEvkS6BzEUQvMipoB61I6SYV1J3/IXM0sLRjXpp4+FFH+Z7WVvbtIAvn8oWwZKZlnD37FKVF42/fAeQ==
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 (2603:10b6:20f:fc02::19) by DS5PPFC0F1095C8.namprd20.prod.outlook.com
 (2603:10b6:f:fc00::822) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Sat, 25 Jul
 2026 03:22:17 +0000
Received: from IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97]) by IA0PPF42224DB53.namprd20.prod.outlook.com
 ([fe80::8f44:a6f3:9ef6:1e97%8]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 03:22:17 +0000
From: Brandon Mahdavi <Brandon.mahdavi@Mahcom.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lists@marzocchi.net" <lists@marzocchi.net>
Subject: [RFC PATCH net-next 1/1] net: dsa: qca8k: fix host FDB handling
Thread-Topic: [RFC PATCH net-next 1/1] net: dsa: qca8k: fix host FDB handling
Thread-Index: AQHdG+TLCACH8nw27EWZnshgJZ3HhA==
Date: Sat, 25 Jul 2026 03:22:17 +0000
Message-ID: <20260725032159.421627-2-brandon.mahdavi@mahcom.com>
References: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
In-Reply-To: <20260725032159.421627-1-brandon.mahdavi@mahcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Mahcom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF42224DB53:EE_|DS5PPFC0F1095C8:EE_
x-ms-office365-filtering-correlation-id: 2d6dbb1f-c887-4a17-5cfc-08dee9fbee51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|56012099006|10067099003|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 eoPqDEp6dotODqaePWHPQAJ218Ev6X1swH/zGMzLddka1qqGa9614QqJix6XnzZZcABvIFPAte34Bca404rofkKWTEArOd28Bo6kqyRCriNhj1HKmNAuQE1fHNt3fWBh/IiOReR5gtkry0wC39RoipywPjT8Rq7kCVgc3XnFK3uVJqwp/Cdntn2Z6mzy/que0IDAP8jQMeVyCT+7dvPsvuVA+dHeRJXykR3p8Te+lQ0dV9S6DcsbTiahSMrubFeCkT7/iQDZhrMPxio0hsbZ8ZY0yjhuCufy6xMOywz6jsyE3odkuG7WxIeIRmYydBqwsMI7SzHd4XmwPI1WUag5+fotiyWx3bO7Z4mDffmEGyZlmGDfZf4NA+InbvyGtzeWJ7B6L/7AnNzWaROtlLciFtwRIi4vD5sU81ChyW0JHZ/3kd71LPPlQrTi2x5fTczb5+M9My7f5HO/z2t9XkxFtESFXYEYm6s+QVWPJCaff7aB2gnh12FjxK7Z/Ofiw35IBdi/6y6Ho7UF+Vtj1UdsF/QCgKttj/Y8KUvYCGQ5dzfePFV04ojyut5CdqDYNIjiOVlRXjJEGP6NbOg/JMjm1QIydLVY0jRG99sgITo7uzoTooWjjD8li8hMconuYMYylWP2HsvIXOtoxQf82prkfs7+GlAVpNiBGsySwY03MCvcjQvJkjY7k+fnMhzBchepIX0sBMpztWwqymGJDEGkzUFHNREcgSrYz/3Kx7CRo+o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF42224DB53.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzIzeEhrakxhUkhRcDJGWUFCamljSENwcGRkN1NjVTFiY2cxVURlUVhYVXFH?=
 =?utf-8?B?NlgvOVlJUWRhR0hPMzlRblYxbVBpcXhUWFFiVEFNMmtUZk5IdGRNS095OHJY?=
 =?utf-8?B?RTFaVDA1ZVo0STFhODVyazdocFBvQkZML0crK3dpaEd0c2UrR3RpaStKRzNu?=
 =?utf-8?B?dXcrM1l6dWpITFFPV1VjSHRnQThON2IweHVVS2JIVmxmVzFyYWQ2OFdEdFYz?=
 =?utf-8?B?ekRPRWt3dmdlVDdQS1dxSDY5NDE2VGNpUUZRUEdIQnppUHJZQXAvbGNrNmJv?=
 =?utf-8?B?YlNUM3M3RFFOcEFtYVFYU2p2aE1xa0VVSTl3UGRpKzFRU1NPYmVENGdCQ0ph?=
 =?utf-8?B?OTJJM2o1d3I2OXlBYThHNUFyTUwvcWpkWW5HYkFmT2pDa29EWkxsWm0rMGtE?=
 =?utf-8?B?THJSc3RmSEx2bVVkbVhnNFd1N2tBUU9BME1WZStjSW5mdS81cU4za3dxcXZL?=
 =?utf-8?B?K1gwbXkrWXl6MFp0NWRiMTZ0TVBVbzdqZkpURVlnUEVnR1RWUWpUSDVTc2ZY?=
 =?utf-8?B?SXlmaDh4QmdsWWxFS1lLcEF0c1JVTm9oY2M3MTd2bXowL1RkVnYzN0pFYkhz?=
 =?utf-8?B?K0ZoTXhxUGEwWFE3VVhyNUZFUi91bCtpTDE5aDBLYlEyV2psWUxCU21BbzRB?=
 =?utf-8?B?Y1poUUI1cFlGTWVkRFdmMmhtclJ5MmNjS2RSNWowVU5mTkNkZ0JnNTdYd2RK?=
 =?utf-8?B?bXU3LzhseHM3SHVpeWkvNFBveHhObEFPUE1PamZJeExxRERaaVFDTVNRUWRG?=
 =?utf-8?B?aE5UbzZwZnVXd1pmVzVJbHRtZ0RPZUhHYXdickF4ZTNtaGZSaFQwcFhUK2ds?=
 =?utf-8?B?bnFQWi9yVFZua3VjUTVLZEY3U3J0dlZhbXl2ZDUwall3ZmEvWHpJN0lMbjdx?=
 =?utf-8?B?OWlIQmt0ekNudEFlNHZodFJvZmVHcDRFRlR3NWN3UnphUWdCV0lWUGRKUUN1?=
 =?utf-8?B?SlhwY2pTSDdMd29oRmIrL01uY1VUZ0JNT2RwNmttR0lnek5XMTFhYVhTVll2?=
 =?utf-8?B?NzNDZ1BjVGVlVmZsbERXREhmWEFmcnhkQTVqWThXQ3JCRWIzcnRQM20rZWJG?=
 =?utf-8?B?czNMenVFTlNjMVhtUlVmR3pOM3N5OElaMkVSVUVxNHQzWVhUVUtlTFhDaUNL?=
 =?utf-8?B?b1FyV1NvekhTeHkwYnNkSFZZVW1HaXV4SHRPV3VwVWNnSTd2MEkxam15MlJj?=
 =?utf-8?B?TGwzdFhicCsyc0YxbGZaODJGN1lPa0E5RGx3aFd5QXJKWTlGaVh4Z0NXckFu?=
 =?utf-8?B?VkZVSCtlUGE0V2xMWS8xNnJqUnJ6ZEM3MDNBTW9hUkwrZE1NNklwaFZLVm81?=
 =?utf-8?B?ckI3MVpNS3h0TENqYVMxTmI1V0I3ZjlpMXRXM3dmNlNNUDdxMmQ0ZXEyUXNJ?=
 =?utf-8?B?cGJRNTZJZjM0eU9JVWFOTjNFQ29KWmhERnNQMTRHajBJVlczekxFQVIzT204?=
 =?utf-8?B?QlUwK1E0S08wVnFzRFFFNWVvVTR4WVA4SmIveG1MSlV2VzRpU3J1WndPVnBN?=
 =?utf-8?B?a2NvMHlOMDdIaThBU1UzRHhFSEJiYVo0d3NqSW0weUZnQm5OVmJzNDR3MDZm?=
 =?utf-8?B?UzdWV1dPZVgzcTBmazVLdWRSV3B0TFRLMDBsNGR2Zy9BVlRZMW5TT1NLNW9Z?=
 =?utf-8?B?TWRYdTRUcFRSbXh0Mm01WWJOeUZ6TUczQzNNQkZCam5oNlIxbFAzSUFuajFo?=
 =?utf-8?B?NG1xTkd3SS9Tc3BCdWdWUVZrTkZxODVFVTMxZ3Z0Q2dOWEFSYitsaHk4cXlC?=
 =?utf-8?B?OTh3Z2NjOThrcU5Qb09lMmN3SXkvU3RqVjNBVnJGdjM1RHRpSWZLZnVxMmE2?=
 =?utf-8?B?VDNhQjZxcVNCU1E1Vk9SWTJzd3ZxZ1hSMlRaeko1Nk53OGpLa0V1clAyR1p6?=
 =?utf-8?B?d0thek9oNHFUdXBhYm9tb3FsTjVvZHNZQnI5c3RnV2RuQ0lTNFRKbzdUZ1FX?=
 =?utf-8?B?cXI2MXg4aE5qdTVLOC9xbE43QVlDZnlJVkdKZmhVbEZDRDA0Tmd2K2xsK0RM?=
 =?utf-8?B?aUNNSkZjNlAzODdhdXpheU9JU2IwVzYrVVFRVFZKTlh0eU01MVRMaHlFdnVz?=
 =?utf-8?B?L0JqbDdQVVp2M0NnWVowamw1ZFBjbWlPT3hMSUZuRkx4dlYwdFI5VWRFQ0R5?=
 =?utf-8?B?SmhFcXBHTS9OWGpWaUVlVHdYbnQ5T05hUm4weFkrcVV1Kzh6VmVWNGp5THA4?=
 =?utf-8?B?N1IvaVVyNHF4ejNFSzJxaUc2U0JVSCtZYXZWeHBvL29uNDkrUWtYcmlwUW5X?=
 =?utf-8?B?V3psZDY1S3BjbUJjTVducXdyUXVGYmp6MFVGUnZuYkkyU0hpaXRsMnVUMW4r?=
 =?utf-8?B?Rlg2eU0xbTRyK3Nnd1dBWUtKUmgvcnlZUVlSdVhYRzQrREFGd2NMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Mahcom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF42224DB53.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6dbb1f-c887-4a17-5cfc-08dee9fbee51
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2026 03:22:17.7190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92901e00-cf2e-4465-88d5-f158582648a6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nHCeaqCFi57UoHo4oy9EAEEgqglnZKPAvHwI6G1yAnGcApcJKGeBAfNnpoHmKlOtP0GvIZFcYGDgj3icrxUjxBzI6JF043u5krUt9zW96g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC0F1095C8

RFNBIGluc3RhbGxzIGhvc3QgRkRCIGVudHJpZXMgb24gQ1BVIGFuZCBEU0EgcG9ydHMgZm9yIGFk
ZHJlc3NlcyB0aGF0IGFyZQpyZWFjaGFibGUgdGhyb3VnaCBzb2Z0d2FyZSBpbnRlcmZhY2VzLiBU
aGUgUUNBOEsgQVRVIGhhcyBvbmUgZW50cnkgcGVyCntNQUMsIFZJRH0sIHdoaWNoIG1ha2VzIHRo
ZXNlIGVudHJpZXMgdW5zdWl0YWJsZSBmb3IgbXVsdGktY29uZHVpdApjb25maWd1cmF0aW9uczog
c3VjY2Vzc2l2ZSBhZGRzIG92ZXJ3cml0ZSB0aGUgZGVzdGluYXRpb24gcG9ydCwgd2hpbGUKY29t
YmluaW5nIENQVSBwb3J0cyBpbiB0aGUgZGVzdGluYXRpb24gbWFzayBkdXBsaWNhdGVzIGhvc3Qt
Ym91bmQgdHJhZmZpYy4KCkhvc3QgZW50cmllcyBhcmUgbm90IHJlcXVpcmVkIG9uIFFDQThLLiBV
bmtub3duIHVuaWNhc3QgZmxvb2RpbmcgYWxyZWFkeQpzZW5kcyBob3N0LWJvdW5kIHRyYWZmaWMg
dG93YXJkIHRoZSBDUFUgcG9ydHMsIGFuZCBwb3J0IG1lbWJlcnNoaXAgbGltaXRzCmRlbGl2ZXJ5
IHRvIHRoZSBjb25kdWl0IGFzc29jaWF0ZWQgd2l0aCB0aGUgaW5ncmVzcyBwb3J0LiBTa2lwIGhv
c3QgRkRCCmVudHJpZXMgb24gQ1BVIGFuZCBEU0EgcG9ydHMuCgpBIHNraXBwZWQgaG9zdCBhZGQg
Y2FuIGNvaW5jaWRlIHdpdGggYSBzdGF0aW9uIHJvYW1pbmcgZnJvbSBhIHVzZXIgcG9ydCB0bwph
biBpbnRlcmZhY2UgYmVoaW5kIHRoZSBDUFUuIEluIHRoYXQgY2FzZSwgYSBkeW5hbWljYWxseSBs
ZWFybmVkIEFUVSBlbnRyeQpjYW4gc3RpbGwgcG9pbnQgdG8gdGhlIG9sZCB1c2VyIHBvcnQuIFNp
bmNlIHRoYXQgZW50cnkgcHJldmVudHMgdW5rbm93bgp1bmljYXN0IGZsb29kaW5nLCBob3N0LWJv
dW5kIHRyYWZmaWMgaXMgZGlzY2FyZGVkIGJ5IHNhbWUtcG9ydCBmaWx0ZXJpbmcuClB1cmdlIHRo
ZSBzdGFsZSBkeW5hbWljIGVudHJ5IHdoZW4gc2tpcHBpbmcgdGhlIGhvc3QgYWRkLCBidXQgcHJl
c2VydmUKZGVsaWJlcmF0ZWx5IGNvbmZpZ3VyZWQgc3RhdGljIGVudHJpZXMuCgpBbHNvIHNraXAg
dGhlIGNvcnJlc3BvbmRpbmcgaG9zdCBkZWxldGUsIHNvIGRlbGV0aW5nIHRoZSBzb2Z0d2FyZSBl
bnRyeQpkb2VzIG5vdCByZW1vdmUgYSBsZWdpdGltYXRlbHkgbGVhcm5lZCBlbnRyeS4KClRlc3Rl
ZCBvbiBJUFE0MDE5IHdpdGggYXNzaXN0ZWQgbGVhcm5pbmcgZW5hYmxlZDogc3RhbGUgZW50cmll
cyB3ZXJlCnJlbW92ZWQgd2hlbiBhIHdpcmVsZXNzIHN0YXRpb24gYXNzb2NpYXRlZCBhbmQgZG93
bnN0cmVhbSB0cmFmZmljIHJlY292ZXJlZAppbW1lZGlhdGVseS4KCkxpbms6IGh0dHBzOi8vZ2l0
aHViLmNvbS9vcGVud3J0L29wZW53cnQvaXNzdWVzLzIxMzE3Ckxpbms6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9vcGVud3J0L29wZW53cnQvcHVsbC8yNDE2MgpDby1kZXZlbG9wZWQtYnk6IE9sYWYgTWFy
em9jY2hpIDxsaXN0c0BtYXJ6b2NjaGkubmV0PgpTaWduZWQtb2ZmLWJ5OiBPbGFmIE1hcnpvY2No
aSA8bGlzdHNAbWFyem9jY2hpLm5ldD4KU2lnbmVkLW9mZi1ieTogQnJhbmRvbiBNYWhkYXZpIDxi
cmFuZG9uLm1haGRhdmlAbWFoY29tLmNvbT4KLS0tCiBkcml2ZXJzL25ldC9kc2EvcWNhL3FjYThr
LWNvbW1vbi5jIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9xY2Ev
cWNhOGstY29tbW9uLmMgYi9kcml2ZXJzL25ldC9kc2EvcWNhL3FjYThrLWNvbW1vbi5jCmluZGV4
IDEzMDA1ZjEwZWRiNy4uYTNiNWE3NTZkYmMyIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9kc2Ev
cWNhL3FjYThrLWNvbW1vbi5jCisrKyBiL2RyaXZlcnMvbmV0L2RzYS9xY2EvcWNhOGstY29tbW9u
LmMKQEAgLTMyMiw2ICszMjIsMzYgQEAgc3RhdGljIGludCBxY2E4a19mZGJfc2VhcmNoX2FuZF9k
ZWwoc3RydWN0IHFjYThrX3ByaXYgKnByaXYsIHU4IHBvcnRfbWFzaywKIAlyZXR1cm4gcmV0Owog
fQogCitzdGF0aWMgaW50IHFjYThrX2ZkYl9wdXJnZV9keW5hbWljKHN0cnVjdCBxY2E4a19wcml2
ICpwcml2LCBjb25zdCB1OCAqbWFjLAorCQkJCSAgIHUxNiB2aWQpCit7CisJc3RydWN0IHFjYThr
X2ZkYiBmZGIgPSB7IDAgfTsKKwlpbnQgcmV0OworCisJbXV0ZXhfbG9jaygmcHJpdi0+cmVnX211
dGV4KTsKKworCXFjYThrX2ZkYl93cml0ZShwcml2LCB2aWQsIDAsIG1hYywgMCk7CisJcmV0ID0g
cWNhOGtfZmRiX2FjY2Vzcyhwcml2LCBRQ0E4S19GREJfU0VBUkNILCAtMSk7CisJaWYgKHJldCA8
IDApCisJCWdvdG8gZXhpdDsKKworCXJldCA9IHFjYThrX2ZkYl9yZWFkKHByaXYsICZmZGIpOwor
CWlmIChyZXQgPCAwKQorCQlnb3RvIGV4aXQ7CisKKwkvKiBOb3RoaW5nIHRvIHB1cmdlLCBvciBh
IGRlbGliZXJhdGVseSBjb25maWd1cmVkIHN0YXRpYyBlbnRyeSAqLworCWlmICghZmRiLmFnaW5n
IHx8IGZkYi5hZ2luZyA9PSBRQ0E4S19BVFVfU1RBVFVTX1NUQVRJQykgeworCQlyZXQgPSAwOwor
CQlnb3RvIGV4aXQ7CisJfQorCisJcmV0ID0gcWNhOGtfZmRiX2FjY2Vzcyhwcml2LCBRQ0E4S19G
REJfUFVSR0UsIC0xKTsKKworZXhpdDoKKwltdXRleF91bmxvY2soJnByaXYtPnJlZ19tdXRleCk7
CisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCBxY2E4a192bGFuX2FjY2VzcyhzdHJ1Y3Qg
cWNhOGtfcHJpdiAqcHJpdiwKIAkJCSAgICAgZW51bSBxY2E4a192bGFuX2NtZCBjbWQsIHUxNiB2
aWQpCiB7CkBAIC04MjksNiArODU5LDI5IEBAIGludCBxY2E4a19wb3J0X2ZkYl9hZGQoc3RydWN0
IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCwKIAlzdHJ1Y3QgcWNhOGtfcHJpdiAqcHJpdiA9IGRz
LT5wcml2OwogCXUxNiBwb3J0X21hc2sgPSBCSVQocG9ydCk7CiAKKwkvKiBUaGUgQVRVIGZvcndh
cmRzIGEgdW5pY2FzdCBoaXQgdG8gZXZlcnkgcG9ydCBzZXQgaW4gdGhlCisJICogZGVzdGluYXRp
b24gbWFzaywgc28gYSBob3N0IGVudHJ5IHNwYW5uaW5nIG11bHRpcGxlIENQVSBwb3J0cworCSAq
IHdvdWxkIGRlbGl2ZXIgb25lIGNvcHkgb2YgZWFjaCBob3N0LWJvdW5kIGZyYW1lIHBlciBDUFUg
cG9ydC4KKwkgKiBTa2lwIGhvc3QgZW50cmllcyBlbnRpcmVseTogdW5rbm93biB1bmljYXN0IGlz
IGFscmVhZHkgZm9yd2FyZGVkCisJICogdG8gYWxsIENQVSBwb3J0cyBieSBHTE9CQUxfRldfQ1RS
TDEgYW5kIGZpbHRlcmVkIGJ5IHRoZSBpbmdyZXNzCisJICogcG9ydCBMT09LVVBfTUVNQkVSLCBz
byBob3N0LWJvdW5kIGZyYW1lcyByZWFjaCBleGFjdGx5IG9uZSBDUFUKKwkgKiBwb3J0LCB0aGUg
Y29uZHVpdCBvZiB0aGUgaW5ncmVzcyBwb3J0LgorCSAqLworCWlmIChkc2FfaXNfY3B1X3BvcnQo
ZHMsIHBvcnQpIHx8IGRzYV9pc19kc2FfcG9ydChkcywgcG9ydCkpIHsKKwkJLyogVGhlIGJyaWRn
ZSBub3cgc2VlcyB7YWRkciwgdmlkfSBvbiBhIHNvZnR3YXJlIHBvcnQgYmVoaW5kCisJCSAqIHRo
ZSBDUFUgKGUuZy4gYSB3aXJlbGVzcyBpbnRlcmZhY2UpLiBBIGR5bmFtaWNhbGx5LWxlYXJuZWQK
KwkJICogQVRVIGVudHJ5IG1heSBzdGlsbCBwb2ludCBhdCB0aGUgdXNlciBwb3J0IHRoZSBzdGF0
aW9uCisJCSAqIHJvYW1lZCBhd2F5IGZyb207IGEgdW5pY2FzdCBoaXQgb24gaXQgZm9yd2FyZHMg
aG9zdC1ib3VuZAorCQkgKiBmcmFtZXMgdG8gdGhhdCBzdGFsZSBwb3J0LCB3aGVyZSB0aGUgaW5n
cmVzcyBwb3J0IGZpbHRlcgorCQkgKiBkaXNjYXJkcyB0aGVtLCBpbnN0ZWFkIG9mIGZsb29kaW5n
IHRoZW0gdG8gdGhlIENQVS4gUHVyZ2UKKwkJICogc3VjaCBhbiBlbnRyeSBzbyB0aGUgYWRkcmVz
cyBpcyB1bmtub3duIHVuaWNhc3QgYWdhaW4uCisJCSAqLworCQlpZiAoIXZpZCkKKwkJCXZpZCA9
IFFDQThLX1BPUlRfVklEX0RFRjsKKworCQlyZXR1cm4gcWNhOGtfZmRiX3B1cmdlX2R5bmFtaWMo
cHJpdiwgYWRkciwgdmlkKTsKKwl9CisKIAlyZXR1cm4gcWNhOGtfcG9ydF9mZGJfaW5zZXJ0KHBy
aXYsIGFkZHIsIHBvcnRfbWFzaywgdmlkKTsKIH0KIApAQCAtODM5LDYgKzg5Miw5IEBAIGludCBx
Y2E4a19wb3J0X2ZkYl9kZWwoc3RydWN0IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCwKIAlzdHJ1
Y3QgcWNhOGtfcHJpdiAqcHJpdiA9IGRzLT5wcml2OwogCXUxNiBwb3J0X21hc2sgPSBCSVQocG9y
dCk7CiAKKwlpZiAoZHNhX2lzX2NwdV9wb3J0KGRzLCBwb3J0KSB8fCBkc2FfaXNfZHNhX3BvcnQo
ZHMsIHBvcnQpKQorCQlyZXR1cm4gMDsKKwogCWlmICghdmlkKQogCQl2aWQgPSBRQ0E4S19QT1JU
X1ZJRF9ERUY7CiAKLS0gCjIuNDMuMAoK
