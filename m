Received: from smtp.fortinet.com (smtp.fortinet.com [208.91.113.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C993B811F
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.91.113.81
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787132; cv=fail; b=XkW8ywoirpOa9HpWiB7xjK47DZ5rCSS46+RaQHumb1WQ6WRcZXuvMME11nNexPxV5y1KNXuroeS72C5wrCmbug/kwulieXlhxPGp5W98HUfx0FSpwCDeJbhsjj6+DfPrXSXjyTvi53rrLyMR4Ej7aNbOWPb0+FoLnhLktjkjSbk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787132; c=relaxed/simple;
	bh=zawqtK4w6Wci4NO4k3/HObbiNO+jGW6TGS8nj3ZyqLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpdfvpY41pcI9IwN3hBhx5KgDj/AisMtmV1LFA0gVtarUFEAjrKIW/xeGWqpxivwleVc9vBq3qzKiDJwlZWaaLgH+ozG9WNTj8z5qoXquK62kQ73i0qwm8DZktcMv4W9H/qgEoaLH5G4rIXCgnXh/dDmoTVmiLKFUTgYTrPqQac=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fortinet.com; spf=pass smtp.mailfrom=fortinet.com; dkim=pass (2048-bit key) header.d=fortinet.com header.i=@fortinet.com header.b=be+qzyEd; dkim=fail (1024-bit key) header.d=fortinet.com header.i=@fortinet.com header.b=QcN1LAR6 reason="signature verification failed"; arc=fail smtp.client-ip=208.91.113.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fortinet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortinet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fortinet.com header.i=@fortinet.com header.b="be+qzyEd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fortinet.com header.i=@fortinet.com header.b="QcN1LAR6"
ARC-Seal: i=2; a=rsa-sha256; t=1787787125; cv=pass; d=fortinet.com; s=dkim;
 b=Ju60axXNQ+iyPo89sODFoAai77EH56X9+YTrS4fTusIIZMg4yTKmt8FivPMqVkw8NZJBRcdX5fYX
	VrJEOU/o/9JHkFMrVOokFsFrku4/Zm0shqlE1K1xREEiPS8KpVtwFithZDc0BWuX9wxMBIa0Dfss
	8proiTbnqtevslEtf6Jggqu7nNFQH2neX2Ntq8BpGLcevyehMFLcv7jWzufXmycKwqbx01Dlvw3O
	ftXP9syZw1ofMJeeJjXyD9ZNVgGmIKbxBtwSw3+LCIo8U2uIct3a+wY+nBnSf2CT7ChObI4XvL7U
	fQ4ZyXP5IX2KWtTfUGArAIGm2lJw5ND9ZDjD4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=fortinet.com; s=dkim; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:content-type:mime-version:dkim-signature;
 bh=WB3VH2cAgFKwqi9XZlscGBA1r7lHzdB1XU1j0eiJANM=;
 b=bSXB4ghaFic65YOaJEsU1uA5ZIJhW5aDs6zyZt4FoqO6qotukZYUlOcD5YD6ZwC/TtKRAcVQyey+
	U+Z7xfiMyvUtSF93omuyDh6Yw/7xQM+DKKmES110nEGVeJXWo1XdtZ43e25Vt1AFj1Agivm8BYJg
	/7Dmsg4Q1lpgov9mchl5kHFhNkhJVsWza+XT3d94mqa4KxPFlJDSzQbjFpcspFfZz6Yvwct6DXzJ
	fn4/lfA5oDfIlHlmV8srMegnZ1SlrRNtXX6Yr8DnLvQTY4FALfZdBsDMBduo5s42jZK7sRYu1JU9
	oTKxk7uTldKzLaIFeWa5CfLYyiqpgRC+9sukCQ==
ARC-Authentication-Results: i=2; smtp.fortinet.com;
	dkim=pass header.i=@fortinet.com;
	arc=pass (i=1)
Authentication-Results: smtp.fortinet.com;
	dkim=pass header.i=@fortinet.com;
	arc=pass (i=1)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cw8hr7DWflTVcar2qOTvuM5N1yHxAsCuqTwcZFE3j1m5g/vmW6tSweThpD/m06euVf4sTx5JuNWzH/1Qf0quaiFtf9d8u6pXOrepyE1rpnCf1bbcdGTtW9McVAHgWyX1/KN1UklGlWJvLzrLIMI+2/JZ3p82VFCV4lKCNvxHx0YpgbL0Y9YObCSAQ8dSTMQj2Pei/9WUEKdQZJwMrBucTJcOM1xdq/DcgCktm4HWGIJ8VY0PVDDouQ8sN/sPEYDkvv+3m6Ejf+SppHTjre9OTXZSaR67tI3orBxkjWedsSBdc8LuxchZwbrGyqrzj5Z0hNTDod1WMgyzcbOjKK+F5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmiryIiS4bewmBfsUp+NKcrOngFiQArqJdJzBX8wXP0=;
 b=yxUzxJaWi3dyiVeDgbFT+dc4mN39qdi5rFrIqgFrvyip6KShE3q18FaI5Tj7jm8YzV70LBpTPExnJ1myczDVRLFQaPzqhU98Glk7/4eZmzPHWlzQpbX7kSBBquVC9HbZbc0QteB4kvVUV7Fjw+PMW6Eq4ajXwSWhupU0IkdpNMulay8RP0enhv/YJ+czps9BMWUqfFEmd29DhGrLWJxdBtqL/HWnwnJSZaz6miCHWsx2SuF7+Rna86Wv2AABjGCgS63yOTaxNJPYPDH6akNId4rlqtBPqcUveVSTmlCpifK9EdQuT8M/xpikDAV15FrDMYznj7u0rHE4ojBgC9A8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortinet.com; dmarc=pass action=none header.from=fortinet.com;
 dkim=pass header.d=fortinet.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=fortinet.com; s=dkim; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:content-type:mime-version;
 bh=WB3VH2cAgFKwqi9XZlscGBA1r7lHzdB1XU1j0eiJANM=;
 b=be+qzyEdY1TDwxh9YfJYXL2CwK5a1yn+2ZOhuHq65LQHb4bfZsuYvygha+1EbIGiKiGsSypFvF5N
	bn/WCR5oRkq9HAN6LeW6elt0VKPQijEoKyI2uPUzYnGHsTFOQpt5Tdm+0yvroZEGpc+x85U1otTu
	0x+/k2nz8plk1GIZv3Rf4+i3w6EfM0pFat9YaaH3SUGwykFmy/rZpfcuMMp3Hiix6o/C6PP7o8eo
	lbV+9va4+3mtSYQHAQqJE6CdRVwq2H9kTteu3KwPkfpMwIS8J9LIoaP3900fZiYdnjx9O2euqauw
	/dgJdIEnrWlV9D9e+0vM5Ix1NJdWRa8IIkjqGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortinet.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmiryIiS4bewmBfsUp+NKcrOngFiQArqJdJzBX8wXP0=;
 b=QcN1LAR6axHJ/x1VTWCYwbc77tRCOMLr6Gaua2udrgngAjHJLG7u/L5lBhzBFZFv28C+s8H/MtPb3FSkkzkKf6CpeXBjZfwunHJDfkg+kV42UnBTNZ2gDLISc2qtBsLiJFjgl00hYeUuID6xDIm4tPij3hcEz6WJNCLD/hf6IGU=
From: Srilatha Addanki <saddanki@fortinet.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>
Subject: RE: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Topic: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Index: AQHdNL/5gg/ZiuzKC0+waAp0eE4DvravIHDwgADJzBuAAQy6B4AABVyg
Date: Wed, 26 Aug 2026 23:31:59 +0000
Message-ID:
 <SA1PR18MB64191BF8C9F6A501752F65DEB3AE2@SA1PR18MB6419.namprd18.prod.outlook.com>
References:
 <BN3SPRMB0002D8DE46CAA989F8F3961CB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
 <BN3SPRMB00020EA67E11CAB28D9EBE6AB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
 <GV1P189MB1988D232DCFFF279C4EC4595C6AE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <SA1PR18MB64195FFB1FE652AF2586686DB3AE2@SA1PR18MB6419.namprd18.prod.outlook.com>
In-Reply-To:
 <SA1PR18MB64195FFB1FE652AF2586686DB3AE2@SA1PR18MB6419.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortinet.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB6419:EE_|LV8PR18MB5709:EE_
x-ms-office365-filtering-correlation-id: e4cdbc22-0560-4783-df75-08df03ca39ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 rcCginKKt1dPBymmJ2Zwpkv0A4MqvXbxS5Uy5IBAV69JFSmHvWAL3mZuXpqNWDvhI5dGHcd9JYvxdJ2jcfOhO0rcGvXHGs7xxFTcbj4AWe5kOLjcfQlwPiyKXmhOIqA+e6ZJWZcAHDWh9dMehDNjRFsGthWsM6PxasX4c4+pnGb3T42CI7dWxBg7Q+Zqs+BpcTN0pprlYJ0YI99triUdWORCzz2JMF6aCoWHpaMXDuOGEHEkN3ISp9ijGAFHToCC8TQ5nH/5ZDr+JQ2/kQL5BRPbHSG0gZkh6Y9Cyzc5Zwh1t4qu9+XIbFFC8ortGcl912jT3rDWU5r2U7PUBFiaXqeqe42V6eGOpImZk456qoFurVNFb8810/B+qw9rLDr/pbjrGYiIfLUgGON5DsI/atnb9AdBnTQQac+OhbRLvFwdTNgs4hWRxptUzKX2bRXpoQNc1523f9yh2WvmxSoIuwHQAFqC9VZY9ut9R5UeWCvi/VtO3Dtz4QjDvL2jOIpyK91jWv1KfSuzJ6jSNZ/c+8PcXln8u8ZKMfaF5WDBYeou642/XUGce89k0sGW50wY3Vh/whwLe4u1gOe4DTuUCbrIWljhrDTnFUxfkmBVYH1I3G130XcDfbtITcyTyYM73UxSSwF8cswJH6XWJzX/afryWxwA+jJp3vbrJw3KvxwcHEG2lKKOcM8ddPd/LYmOl39LIxAVPrNGFRBssJL2mYip3bE6uzMHqVgKOmxBrW0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB6419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MJx0AGhXnw3tIkI/hEUONuoQmfjpSQg4BBDgBbu6yj1qtzbWw5XtJgs3XQ?=
 =?iso-8859-1?Q?l1FTRPikjHJJBK8S7CisC7wSm5FH271L7QZdILrkbErnlL/JZyWDEruHhY?=
 =?iso-8859-1?Q?fYL2x265M19u8nz4jzah/NjZjHJQ+83pYsfnA3pBhsadHijsav6VQgiv8D?=
 =?iso-8859-1?Q?uoQhmGJhyAdf8boZLtdhYpGMk6peuC+XiYwEtEakccojVyhSutLAG2MUQv?=
 =?iso-8859-1?Q?VrtdsEUJz/7Zk18q6A+43xJmFXbqjhSpjc/WF3fg+zd0VxcGojqFsXGkPl?=
 =?iso-8859-1?Q?OM4tw/H48O4V/0SWx9tA6zkrQnKyNHnNOn0nNSfZBOHCfItWdLL4b240h9?=
 =?iso-8859-1?Q?PYmerfFYcTXvu1Uvx/CgFrDxPezmjbY4ooaDrD94oQXoOGOH2Bq3Wg1hzJ?=
 =?iso-8859-1?Q?05eMd2U8Be5eAdhsT/AA+9lO39wgbP9Fe8vGR+VAAOTBqPW+6nUXJ+qxjJ?=
 =?iso-8859-1?Q?n3zHEoCrmT0NBB/lCNl3/QXv87HtUocuTF2SlWGW4zBUtGong/XasCKPoR?=
 =?iso-8859-1?Q?1LNXecmnj8eqd6fQj3IlVww9YSxjb6adG3K2lUh8UljYeUhooV2z7ItHmi?=
 =?iso-8859-1?Q?6FEJ8Oq1u29kJDjnxJDKxnlxEuc7FuR0oveXYkzSpbNUiRL2uZqNqr4JO8?=
 =?iso-8859-1?Q?DxeVFsbJYpa/5b3Onur0xjf3CNkA3z5/xqUUPZzfyX/Wht0C63M5hObzlx?=
 =?iso-8859-1?Q?l6mq3ylAPLg1lESlM3k4Dq+A567Z1/AFlViB6hXp/7I5zZ/x7K44CXpt5C?=
 =?iso-8859-1?Q?qzDv5Y7uttLhAEFwgzzlTByAcZMZizZxZbhp2SOfzIfF0WKAFN3mvmulUC?=
 =?iso-8859-1?Q?rQRDA2MoasWv9rjMsbuuEJqTVZdlu9ji3MBpsQn2UGZ99LbO56L71nbDfj?=
 =?iso-8859-1?Q?XZntbzkGRZ1wBxelMFIfNCpVzWM4V3jTY9uBo22au+G6NN/ye9zFsh5v9V?=
 =?iso-8859-1?Q?i/S/L2a9baeRWOZixDNLYGIWTR2O8wy19oKWJHb96WhyRJiTnhjk7WvoCT?=
 =?iso-8859-1?Q?LhLkQ+1B+IJMG1+my6TPaGWbCV5dRkQCMuKRs9CIN8Q85PGRMXY2GLyfQZ?=
 =?iso-8859-1?Q?kjEApsagl4IF8AYaBn87OVCOVVoyWa8px6Xc8hiQ3KQd560nPOPv2Pjy9U?=
 =?iso-8859-1?Q?veeeoH8+WGGa0FGt/m5XcKVDawvFoHNactEmnw+NAUoaktiO/aY0vJQr32?=
 =?iso-8859-1?Q?0QayUuqQVTqgFY+J4vLiOewZDqC4oeMa9rYlDBCJRBJ6YV0h4Sju4nTD/F?=
 =?iso-8859-1?Q?4TmOQAer4122hxVSdh+zaLV6W4dStJYIqLGvkHbE67PHKqtlk8X9TBjB4Z?=
 =?iso-8859-1?Q?x54yvwklOrcua9cY9xmcf65ET2VQJFheYdR8auIkytvhrwTTNAp/9j3u/n?=
 =?iso-8859-1?Q?Qg39y4uS3PUHegTKu5QiD/VD7ikJ4lJ3J9SrrhAB7bcKD0cmNq/aYmItqy?=
 =?iso-8859-1?Q?Fb9GN0OYUl8oT5lJKCOs4QofNIo99MclqjXvU1FnXlXiQeRVeFbNyGlBnW?=
 =?iso-8859-1?Q?InWf4bboQgVzXSvKmrV93uAKyiCRV/WmU6waf0CRBT8jtFaVKuB/i8LwDh?=
 =?iso-8859-1?Q?QWDTYxbdye8MhOSkp3Y1YNUJA+yhuvFZz2WZ1xT3+bxa9c6mQEC4aVRt88?=
 =?iso-8859-1?Q?m3mUvYKDtpVlG56kDDZgu8H4ene7yUgS/bO8Uwbi8Viy0vyAvulDw5bb93?=
 =?iso-8859-1?Q?EM7zqZOagjXvaUsMIY7ekuEBnw5kYLLBUiB4U0umNMdz/JXvTvaAKFfsl5?=
 =?iso-8859-1?Q?wd/rvA/9ejuLT9HqpyA4XOZosYl6i+CYj3KQ3W1vpxmrGQzVEPZqh7lQcw?=
 =?iso-8859-1?Q?dP4ERD08BA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	q+y+Kmj3UMxxtB6SOJFIKGSgGBM90nLQ2KzrTaKMmjVHdOxGFjOjJN6kONysiTxBQieLVmw8rmcixb2Tw6+dT7z6uBhitXlQVM5v21opAEYV2fFmOVkCxky6KAdNKWdoNTs/neqkqEnYEnAkA5Sjah7RAG9t/Y5YGZBjk6dZFA2KbS6bqd20p89n9Bw0gClSJvp/BjQPUgiREtiLXUGV/qmJcsqr0vCzP20SVHgmcyRynAXBNIeUnkQoMiciST6b9GfWO7ntgRIwIKkgGMIQdzQx9zGfpMSm9YKt9AXPaNW4myv9NlZy7WBumfljos0RRhrv28Dz4cQ1jjSV9tCfww==
X-OriginatorOrg: fortinet.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB6419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cdbc22-0560-4783-df75-08df03ca39ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 23:31:59.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2c36c478-3d00-452f-8535-48396f5f01f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fk/f6f5KoghfnU7lBORmiaT6jCHeM4igDf2V/xWBfImxti2TtADqXKestYAiBFt7S0eWDmELMkbPYDwNigr6pPKCjSVymWZHxqxTDsOpzRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5709
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVFYWC88UVpdWFhYWFpbSFpZSBsJDAwJBgMBKA4HGhwBBg0cRgsHBUhZSFpeSBwdBg9GGR0JBg9G
 Bg8dEQ0GKA0bHEYcDQsASFhIWkhZWkhcWEZRW0ZZXEZZWFlIUEhYSFhIW0hYSFhIWEhZX0gCBQkEBxEoGg0MAAkcRgsHBUhYSFpaSAYNHAwNHigeDw0aRgMNGgYNBEYH
 Gg9IWEhaXkgcHQYPRhkdCQYPRgYPHRENBigNGxxGHA0LAEhY
X-FEAS-DKIM-smtp.fortinet.com: Valid
X-FEAS-ARC-smtp.fortinet.com: Pass (Highest instance tag i=1)
X-FEAS-Client-IP-smtp.fortinet.com: 40.93.14.101
X-FE-Last-Public-Client-IP: 40.93.14.101
X-FE-Policy-ID-smtp.fortinet.com: 13:5:6:SYSTEM

By "idempotency option," I mean a flag or parameter in the API (or CLI to=
ol like tipc bearer enable) that allows the operation to be called safely=
 multiple times without returning an error or modifying state if the bear=
er is already enabled (similar to CREATE IF NOT EXISTS or mkdir -p).

Since tipc bearer enable returns -EEXIST / "Error: Already enabled", call=
ers currently have to either:

=A0 =A0 Pre-check the bearer status before enabling, or

=A0 =A0 Explicitly handle and ignore the "Already enabled" error code.

I was curious if there is an existing/planned API flag (e.g., --ignore-al=
ready-enabled in the command) to handle this on the kernel side, or if ig=
noring the error in user space is the recommended pattern.
________________________________________
From: Tung Quang Nguyen <mailto:tung.quang.nguyen@est.tech>
Sent: Wednesday, August 26, 2026 12:32 AM
To: Srilatha Addanki <mailto:saddanki@fortinet.com>
Cc: mailto:netdev@vger.kernel.org <mailto:netdev@vger.kernel.org>; mailto=
:jmaloy@redhat.com <mailto:jmaloy@redhat.com>
Subject: Re: [TIPC] Enabling an already-enabled bearer triggers brief lin=
k flap (~243ms down) despite 1000ms tolerance 
=A0
ALERT : This message originated outside of the Fortinet network.=A0 BE CA=
UTIOUS before clicking any link or opening an attachment.


> Subject: [TIPC] Enabling an already-enabled bearer triggers brief link =
flap (~243ms down) despite 1000ms tolerance

> Questions:
>=A0 1. Behavior: Is re-enabling an already-enabled bearer expected to re=
set the link?

No, re-enabling an active bearer does not reset that bearer/link. TIPC ke=
rnel rejects that command and returns error message "Error: Already enabl=
ed".

>=A0 2. Tolerance: Why does the link go down for 200ms when tolerance is =
1000ms?

There is no relation between tolerance and duration of down link,

> 3. API Design: Is there an idempotency option for bearer enable?

I do not understand this question. Can you give an example of the "option=
" you expect to have ?




***  Please note that this message and any attachments may contain confid=
ential and proprietary material and information and are intended only for=
 the use of the intended recipient(s). If you are not the intended recipi=
ent, you are hereby notified that any review, use, disclosure, disseminat=
ion, distribution or copying of this message and any attachments is stric=
tly prohibited. If you have received this email in error, please immediat=
ely notify the sender and destroy this e-mail and any attachments and all=
 copies, whether electronic or printed. Please also note that any views, =
opinions, conclusions or commitments expressed in this message are those =
of the individual sender and do not necessarily reflect the views of Fort=
inet, Inc., its affiliates, and emails are not binding on Fortinet and on=
ly a writing manually signed by Fortinet's General Counsel can be a bindi=
ng commitment of Fortinet to Fortinet's customers or partners. Thank you.=
 *** 


