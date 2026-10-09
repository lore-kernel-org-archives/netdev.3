Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020142.outbound.protection.outlook.com [52.101.61.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09874D37C3;
	Fri,  9 Oct 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553517; cv=fail; b=IeGgkB2sueMwq9c2x/g/ZZxBtbTSbPrfnGxBlYhfS3wjzQI675aQtIDK1FHM84birO0vxvy9jVd76jB4pxRiKNIp49hnI67OHbW4bEBnfa2PI9AQrl5MJhVbeJJ+XhKy/3HZW3bXjZSnifLB9HHGlHBSfIQUaPJtbGd3qhKohuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553517; c=relaxed/simple;
	bh=4UgvjE8iaP9fBY49Pl7ZJDlM/vY9QOgg40Cw8fdilyc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=otFNAdPYn+kD/TzHZDS1xdcmM9ydo/u5j2afok4Czg93xUL0993d+IAm32baBpo4TLC6lwEYRHewFBcyiZIT6wQQybbQFOKGC6Y4wonaIlPQ0jwloxbzN/sSKJvTfVwcrqG09Hj1nV02e417wcrm4j9YIoBbFvyIKYfZX8HIBxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=Tv+McS6O; arc=fail smtp.client-ip=52.101.61.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="Tv+McS6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=argoHHjfdhFA54HV/OvTAv8iwgSRcuQN0MSgHZcxgZDYeDOCSeewy9aq1CsD4WVSEpNOGPkvZio4RTU41lKbhaSWhtvkZcXSkk2ZdQULFEwlz6GLH07KkGmr7MIxwvMubeuCzjpZBri28mooPqyRwupUWx7PnOTbQnB4MO+qsUGdhmGJV1qbBaMLvtu1xribuF6kkNkf+yQK/Y1BlMSXUmAM+HVERATc9kxn22lu3PkMkqQbdwtGqAf3bIzXxifqhN5JH8Hq520FfXH5ZHNmLfi9bQ2vZWHufR9jr2wYKhG1qtC+1gx7lGNuaOcLLO4i043/zwN6jS0rHsRI/zZ63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UgvjE8iaP9fBY49Pl7ZJDlM/vY9QOgg40Cw8fdilyc=;
 b=Hb2hXcItOXOq481nPyG482Ow4jnIvPMevBdSglXzYmcQf0Z+h5jEmU86F3UCWjg1zShsJWKsuuMyOrIitgyQfiQEMCan+d9I5WL8UylSNaN0Wys5TQlit7OYcHs0qmUlixw2bHrYWFFqW4VFk1EgKkqJsl8BnDkADx1qrPgyR35bLRitxGzJn9aR+NPGW+RBI9tsE7iMW7Tq6RQMQg1sUCK9y7JtStbBYTFZDWBhaA+9oaxEGXYSUF1fPvQUD71H7Qu8cLhFuTDDQrlGi/PXR/VNsW98fyTZ6PFnQxplGDEVwZ2JVQdpaw+iRkbgVU81+RZSbglOm2U/NyFdlRxIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UgvjE8iaP9fBY49Pl7ZJDlM/vY9QOgg40Cw8fdilyc=;
 b=Tv+McS6O7U9wpGfkfjFlGuVy2/5ycrUa+Rx0IBurr5+jx1M64GBwtmsk0ZUNoODfk4OUdFQz+r1w/x6bRRgii4cEd6Xym7ghCP0i4RY3B6aS1PyG/JZsWaFBiT5CwvgWHLq6JPHMaF/cj6mOYd9Faq5ux6JxvJJ4+Jy2lrtpiSk4CHIhlTlJwlcsGrk8NaTh7bx8hiB5NPBPranCS0YvDocqMYpeUHT3nV7IiEVzg07rFgJmY/yEmxsiw1ZMXriPye5sfCSHEeeWqXeGumI8jUiUMHLj/zBCcntxJMuBgn/wCCAMu6jmQs4UN8h74fYEbW06o/CKPzAZMYij6ZlZeg==
Received: from DS7PR19MB6279.namprd19.prod.outlook.com (2603:10b6:8:98::17) by
 DS6PR19MB418238.namprd19.prod.outlook.com (2603:10b6:8:4c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 13:45:06 +0000
Received: from DS7PR19MB6279.namprd19.prod.outlook.com
 ([fe80::e6d6:e133:f499:2714]) by DS7PR19MB6279.namprd19.prod.outlook.com
 ([fe80::e6d6:e133:f499:2714%5]) with mapi id 15.21.0451.014; Fri, 9 Oct 2026
 13:45:06 +0000
From: Stephan Pruecklmayer <spruecklmayer@maxlinear.com>
To: Stephan Pruecklmayer <spruecklmayer@maxlinear.com>, John Crispin
	<john@phrozen.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "ansuelsmth@gmail.com"
	<ansuelsmth@gmail.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"xuziyougm@gmail.com" <xuziyougm@gmail.com>, "yhyxwgy@gmail.com"
	<yhyxwgy@gmail.com>, Thomas Langer <tlanger@maxlinear.com>, Zahari Doychev
	<zdoychev@maxlinear.com>
Subject: Re: [RFC net-next 00/12] net: add the PON subsystem
Thread-Topic: Re: [RFC net-next 00/12] net: add the PON subsystem
Thread-Index: Ad1X9D5OeUf5Zjd0RJ6I3n/pcdIEnQ==
Date: Fri, 9 Oct 2026 13:45:06 +0000
Message-ID:
 <DS7PR19MB627936A540EF6ABF1B20BC28BB922@DS7PR19MB6279.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB6279:EE_|DS6PR19MB418238:EE_
x-ms-office365-filtering-correlation-id: 8092340e-73ff-4a31-7598-08df260b8700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|56012099006|11063799006|10067099003|18002099003;
x-microsoft-antispam-message-info:
 /hIqnS6Wv3egFqyEyxrvY1+luxoUk2vJEfkp/tTH2KsRg18mK3ESHCo3eofOdY31iZXBPMg8bpPhQDLzQexiCzlEqmjtjm2OpgpdSiryepqkIa1e6PoEAnq1c12D3QRYgVOnZd4C7IYbq4C6kETzOYw17VzSQM29Vx1xSXezA+Ps8DP7/rCQiQzdXl/Y8vUvTSTUuIY/MXofQKCTnApabf4CE3mQ7CMIV+09GzQHs4i2BiDt33jTQjA7nCR/+XnMLUmlcLkMku0NfvZQM5F94WdTKPluIRCpwHjOlS7RkmDp2EzRxsfivLJfYuYRa45SdpQ+Gmh9riMifu+EzpN89Q4cQWBFqt6JZAcKAV8+CEq9pbGZoYYMOuZNMyd0rQd9HXSFepq1pIVh/Sy3Q/PMDb19PYUASKK1T4jwhmIfjZXCw5doWc/ETQm8VTUJ0+L/P4a4sZybPBNjDNcHUh9/sTaiSBNYKCdM9diIxrLNdC8w9yZKGw9ghV6ZXbVMuEPCYoatRRn86LW5Liw6zAbOqi62QfJ9mzWZXlSI5wo6L5+WIZgULkyuK03dO8nNRnoT8nMabXsy11sauWdP8qK6AP6hgDx2/n5pMjJDameZGg/5RjG6X+IuXN3rNLqx/6kCBl9MeIJhxiVBYfJZUgyyJjU4s1cN0NxZUn5bnYTbRVh2MyutrBSTwnjiP0A8/lntGN0SOTlhq8yWGAnvA6CTofKOxzo6PfdTi5J6LcTPkn4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB6279.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHI5dXhycldGaXdLZmVUWUlQTDdlNC8rUC9kRno5cGdocktNLzg1cG04cFdQ?=
 =?utf-8?B?WXVyM1d0V29iSTBXVjdZM25jSUdaMnhxWmozNHRBcUhVUFhCRTJvczVrSmpM?=
 =?utf-8?B?WE5RWEtISHFsd09mdVpESGxwQnAxWm9sWG9rM2hBbEZNMkVsUDRVU3NUQ0Vz?=
 =?utf-8?B?ckpYd0I4VmxITk9nOWFUY3hObEhiUVpOTGhldTZXRDE4bExyYzNtNUU2eElm?=
 =?utf-8?B?UUhjbmlEL1JoMWhPK0dlbExKMXI1Yy9FV1NmcGRmSG1MSEZqUXdDUkFjb3VD?=
 =?utf-8?B?M1pUU09WaExHaWp1bTZrdVVROVR4NlRNNnhuS0tqZlB1Snlpd3FNZ0lEc2Jp?=
 =?utf-8?B?ejlxMHhmTUxlamNDSkxmSWkrUEJ5dHkyWVA2cERrY2dreTlHS2dXYkl1Yk14?=
 =?utf-8?B?NllTaXFyVlZzTGhtRm1TOWUrYkM0TW00cWtVbWowQ2dqQ3RWVUNUdHQyZFpJ?=
 =?utf-8?B?bEdYY1ZFeVk4c3dibHZKU21neE40eHJSeXl4N0lLaHF1czVwTjBOV3BQZFdP?=
 =?utf-8?B?WVBPeGROZXdvY0dVcWRzVkNSOEkwb0JCYzRaaGRxalNFbGNkRXp1ZS9aOHFo?=
 =?utf-8?B?c1RTL2VHQjJYZ1VUa255NXpNL283MUpibDdyMjFZdjAzWGhJWTVWaHBaNU9K?=
 =?utf-8?B?eGpLS1J4QlNRblRqeFk1aFVacTNEMFRlcXFQUllEdnZLTXQ1NXNQSnNsZWl4?=
 =?utf-8?B?anliSDl1KzBKUzMrRnhrTTBTc2FwUzdQSEtuRTc4a2JwT3A0czJmdUN5R09H?=
 =?utf-8?B?VXRqdHhYLzlqSitHMGdXL3N3ZFVhSXRIMnJjWUl3Z293VkJPT1BYSWhrNmdQ?=
 =?utf-8?B?QkNURWJMak9NczVPQURaYWpRS0t6ck9jVmZtWnJDWEpaZm53cjNtcXpYcG1x?=
 =?utf-8?B?Q1JISnpvcUdBSEt3RmF0QVhnTjBsVGlDc2xyUU95MmJLMDNYU2l4SGg3bTEz?=
 =?utf-8?B?MDQ4RG9FUCtBQS9ZRVd6cmZ6c2RLR09jVWc3UTYvRXJsa2hEK3h6dmcxdER1?=
 =?utf-8?B?UTFTclZIWUEwK1FGM0F5YkZrVDE4VHpHRG5XdHpwNUxjVWlkWE80TVB0YURx?=
 =?utf-8?B?MC9vbkorUDNJcGlmeExKM1AyaDNQV2xGY2pNazZFdUV5TkxvTlpHN3FUbms3?=
 =?utf-8?B?Tk42NkczdjR1Sk5xaXZNc2djMkhrSDlyU3dlWTZPdUsrb2lFd1hCM3FkY1dh?=
 =?utf-8?B?SFdnTzdDNldtdEkzMWtWVisremhIUXlkcWdLa0swVDFxdXpoUkM1QnZnb3U4?=
 =?utf-8?B?ZkJ4Y2dlc3FlWTNUdGQ3azVSUXQzTlllWVBySGNNR21nSWZuaWdHbTFlSWNT?=
 =?utf-8?B?cjJrVVBHeUM3QTczWGMyeFhPVlhubjdORXRmTVgxZzNjejdWT2lhUkdEVXJx?=
 =?utf-8?B?ckNiMmhjTUR0U3lQME9vVE1aTmZ1MnVyUWJScks2SlJVNXRGRi9xRUJrYS9B?=
 =?utf-8?B?dC9yRGRwazVMcU5XblJpdjcwaXFKTlNNNzdBeWE3UUxYVG03TXJ5UENWd2cw?=
 =?utf-8?B?WE03L1IwaWxnYms2OUNVZFlCNGxBRi9iRyswb0lPVUFWUm1lc3FDMTRwRnIv?=
 =?utf-8?B?TzVaRVErUzN1cHNvNm9xZHFzbWd6N3JOVWNvZSs2enVJUk9xTnhPa285Zmg3?=
 =?utf-8?B?OGM2RDEvNkxaYU5ZZHhVZGhQVkJpckt5NU1nSFhwT29TWk9pV1o2OWU5eHJ0?=
 =?utf-8?B?UUR2WVd6dWk3M3dUdGFEL3k2aEMzeExQdTJNaEc1MTZUN1hMamhNQXppdUg0?=
 =?utf-8?B?bnVJenNvY3JTcE1BNEVkbG91amFpeWJYZnZYQnVNc25QUXl3KytweEhIbEEy?=
 =?utf-8?B?cU1QSXhKNFpodE4wQXJ5ajU0UkJxZjh6UC9nQU5qa0s3aDlJN2MybTBhNTd0?=
 =?utf-8?B?NXhaYTdLV2tZYzVGNTZzNUhVQ0Q2bmJ2Qjh5VVZiZHJzcUM1NVQxK1lFNXNF?=
 =?utf-8?B?U2hkZWZVUzY3aEsrZEp0akY1VER5c3hsWURPM20zOWxCdWpZbDRmcFM2L09C?=
 =?utf-8?B?d2s4bUdoakxmVHZCdHhmYjdwZVd1RWRyT0ROd2tRL0JIWG5nWnpBR3pzcEIv?=
 =?utf-8?B?TGowckNnaUt2QVhXVGF5cWhYRHI0NjVUSElnY05PTEtaeEdsQkxqS3pqYjhV?=
 =?utf-8?B?L0E4aU5mdzJkTDlxZlVjSWYwMFNjaHZrVEVDNFRUeDJONjcrNUV1QW1uL2F6?=
 =?utf-8?B?dG0weEgwTTBEMXlCRzE0NW96MFpqaHAzeGVTb3JoMjZqcVd1SUVCZEFodmx1?=
 =?utf-8?B?RzdLUHlhQTRRcFRIN1hJV0UxaFdlU1BKblhwdEl1Ym5ORGNVYWYwNmdFTUQz?=
 =?utf-8?B?UHFYUnpqcDB1WFRnODcxOUpMSlprV0pCVGluZzVjR0IrZnIvL3Y2aGQzbi9s?=
 =?utf-8?Q?OlTKV/1gORO+KSmY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6279.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8092340e-73ff-4a31-7598-08df260b8700
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 13:45:06.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbAC+alSQDrwMt3l4anuFmviALzoCxR7jYmHvnVs2aJN8NBTDTfAW6nhCQmP586s4754X8gbO3+Otg3OWVKnZ0uHDGUN7iuPYED0uYD1o9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR19MB418238

QXBvbG9naXplIGZvciB0aGUgYWRkLW9uIC0gbG9vcGluZyBpbiBteSBjb2xsZWFndWVzIHRvIHRo
ZSB0aHJlYWQNCnRsYW5nZXJAbWF4bGluZWFyLmNvbQ0KemRveWNoZXZAbWF4bGluZWFyLmNvbQ0K
DQo=
