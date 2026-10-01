Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998498632B;
	Thu,  1 Oct 2026 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790813095; cv=fail; b=KQzWF559i9lBS6iOzeAA8RHP+mwAnDpdnPFPiQ2a1nyTVBi36ucTv9NJVqDuuNybgQZljh6VNbzx//T1f52YoZIoYZSds1Od5LRtKra7EprLW5Xcns8kcLsdCsC4CjhhTLqBbSAdFITPqR8jLjUnLPejdRvyYeIX4P8U9FJYp18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790813095; c=relaxed/simple;
	bh=k5KuIZix7nORtJw+2dwb6x5raxpOMr4XC+43c15qjb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YcCvbbph7NtfJqiBj5S/WTkC3ueWyadRXyPwoic8XMBE4uZbCPD1dIUNT1dxpeUtR+z9CI19+OwV9U+z2lkxclM5lC0DhAMjtTxPiP2VOlmyBizDa4PaLpHlUf/S1h4r8UIcb7twqUXrsdy/F6Puj9qyXNA3qMruwB4xwRm8gDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EZtjrjjR; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZtjrjjR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjHUllbR8ohN5EZqFrbDv99QPq3Dzm7KGhVjMjJ3CxzMuQZXB8w72sd0vzng9p9m942PSk9iMofNIYb7zGpscIa7AZ6wYwxkArisNjTn+mosy7uAZfWXXXYZFlbUFyFdiyspSosznse1UiJSL5o3sfhggXvDX6itYQdQt6YZIiutrvq5MPuwFqIR5Ul4u5x8vd/9NVifYcyHtoEJPOrPf9WvPfLwr5mnx5MKRi+nfndXgTNL6olpYiBDYHB/DLt+TCchjZRjZV65CogAZkIDCaYMS5GxKcs6abnc0TvmJMR/9gKzS9Lv8TTM7tfdudj3dd/x1eG4UmGIqtuey60VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZlMNieBSlnMlY3IjVHd/in9D4Der4/eCKlRpivbYMw=;
 b=TYxYKINLDhpzkaZspXzgE9ADMsFoauj5n5rLaIHPy50+Rb6Q+1X/5sHokxJDBZmcF/KG7Mjw6tFzvGjgjg9vOUWILXclQ3MgfgafVtnxOs4Btb+ZzmUE3SGSsYs8iWonAfiyj2syH768Kv8nsiLTnmbQP3pssuk7BBACV0amBvZxJRp53eYftYPLdRPqwAeYqkuI8cr+alf3pt2npQ1GXXmYzESEBWDiMM6bm4uXVVViTviV/hijURnX4Lh2WGQUs87vzBRq1ClALsKfJdkNEjafOC5Ow4nYFDNF224Efse5zw37PvzKuF5j0q8ogs46iRPDTsoGmXr1qTDEYzut2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZlMNieBSlnMlY3IjVHd/in9D4Der4/eCKlRpivbYMw=;
 b=EZtjrjjRvAldey5SL6qOtQrDi5+aM4zx+isTxSsWJ8tbQthhihSniyDIUQuyxLQHVdc14KeGxQrUiwIcMLkr42mi6veRhMbk6B+RplASMUSvS1B4a7Sq781bupFHDmhry9Ob8wG7YeuA/nM9S9bFJBA7mskefId5npRjrFqw8GSkWJMOXvC+cpRM3xId8v6NOZJgHT1Nd8LGUVZgtbgU6h+d87JoSgk4zTP8+l/yzIoEigIAZQP8kJ7Kd3QpWPZmoXzAVtGFfabRZMmsjWpymM3dO3jxLybES7wkt0A4mE5E8L+NJNo82KEfnwRGd5GJ4HIuzBPqlBhpzvFhQ2mUJg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS4PR04MB9316.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 00:04:49 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 00:04:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Marek Vasut <marex@nabladev.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Topic: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Index: AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5AgAAWOgCAABaJ8IAAfjUAgAC1TyA=
Date: Thu, 1 Oct 2026 00:04:49 +0000
Message-ID:
 <AS4PR04MB933861A407E780BD0AD80FCC888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <c09f289e-4831-4171-abba-4f1d006b3532@lunn.ch>
In-Reply-To: <c09f289e-4831-4171-abba-4f1d006b3532@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS4PR04MB9316:EE_
x-ms-office365-filtering-correlation-id: 48051432-92da-4668-49b2-08df1f4f9c57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|19092799006|366016|10067099003|4143699003|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 qCiei/AOx8cP/DlA/Dy+kvCbZzD0VvdyReFJ9B6jGq2YBQUW91n5Nne+t90XbQ1aY+UORor2wvK6wlaG8vq9bLD/X+zIXSlnVtBiHldUA77JET8JidgdmrDl3MNuc0A79LXPiIfgjSFrt9JzOXbxdgHfkMOPN9RxArIxfadmWM7sszyblP0BRNZoYZRNszat5VGZtVplm2BTKfG7UYLUEu9bPc6g7Oef81RA854UqARGa9qW2LgchJtjkHP7EiYF1i6OwdtwxV1WwFqANtmrlU1dYTMI4PyZ2CBFGP1jzVo2JVIJSNCBXs7pgoZ/aLQvpOJOJVGyS8uwtUy32Bqdnpk23vHWbjUKuhuhV4us5I7pec1XbbFYMRYJVi7gp2LJQZgQQJ0FXSdW8QYWQXODMDq/Dt5+o5oTTfm4Ll4kE6ConJy4TaLV7c7crmgu1LRHLmTarFNgdXLDxqHf6LVaJR93ZkNgLAx21uD1IUkLPHztM7Hf945rmbZjOkaPAXaQ0rY00uRVwd/ahQrY9mCMZf1W+acPVsDCtc1WUTybe4CoG6pU8HkGjy9DmzUAbJPwocWMNm4mWFbsaNcOUA5QQSB0UUq6k8oDgnRZD/04eOI5eO7Ne44Z191I8yY+JXEaJLnwyLZFRAwNVO/X/fDjjB2PLDAg0rJXVoMTjlWqyj3jfgXUVvjuGS77nSbbq87SCUP67sgsxgOukJ7l3Tvpp/3zadPY/cOKu+TSYJm1R7Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(19092799006)(366016)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PMp99u03pFAMKNz2S8Q3itAtMnhOwEXHBLlXXld/5F53mzvuA4U+YdjEHwg0?=
 =?us-ascii?Q?6TxJWtoTqasWWvoj6Z+Vv71jPbYbzt0beYEsheBZrVLahkh4NgwIsEYfaZEc?=
 =?us-ascii?Q?MCtwfcDNLhADAqclN8ubmsVV4sZN2m9X14noGmQSF94lVRA62v0lHWfddhQb?=
 =?us-ascii?Q?kh1nhE59mM+8c+NQoUw/2EfEa+3c3JDfeRSSAhDjUqj1CULLkSahXONmDZhT?=
 =?us-ascii?Q?ioNsYSrpu+e+AILcN/1AHls2nxAZdsUuszj4nSV/ZSGMW+V5OWPZXlZXgjXL?=
 =?us-ascii?Q?5/y03VvyCM3Khg6r+3liVI4KyFDsdMR9n+2HIhhb5vvooPTQOUAUf1J33n1G?=
 =?us-ascii?Q?gMWSlqIo/o9gLo4U9ml1mdcm4YZpgx47xkvD1EPVPzp8/km71mu/WZPHx5YF?=
 =?us-ascii?Q?O2l7kUao1ry8cTP1GCf0lfEiTrz5ztafMipCqy/Seygh4nf/tfYBY4smb5t9?=
 =?us-ascii?Q?Zuvj5iU5k7xg8Q2xhHa10aRAy68SnYTDTST2ru+97TBSCvhtF8ldh0Aef613?=
 =?us-ascii?Q?LyfuX+wutly04ip8iZ+AMW30SaVY0sH3zO41znrTk3YBzxhWqfxBF9EAtPpo?=
 =?us-ascii?Q?uzREqF5/jy3cHSbPLivOosoZ+d0evQ6LCgX94RorpJjfm8HdS2Ph1dn2zg8d?=
 =?us-ascii?Q?R6pR2ypa2WZ13HKMHvqVRn5kecoYgkEr/156VQaToPQkAPSgywcMTuexp+/q?=
 =?us-ascii?Q?sUd7p1o3XJp8ezZ3b48VKfVYmLx9/oIw/rvoW0QDtiGSZGKEq6x1T4E+NXfF?=
 =?us-ascii?Q?nfdWsGkj9eJeG0TXqmTTwh13WeNj4ak9LydYy2qE/gqbOXI5ISfz0ar5AedF?=
 =?us-ascii?Q?UVWfR26rDBCFAw5/CzpDG707/ljqLRHoo82S1CslSD7D0Sa7mrcugb3LsKwM?=
 =?us-ascii?Q?22czgoFjPziDy6cJfx9LjtJ4sWBVDSMLO7GX+R/frvc3CEigV7EIOnB5+SNY?=
 =?us-ascii?Q?BnNfd3rXg9s4EsU1TYmV0Klqkbl1bK8P4KOv/Ttld0iLelcSDaO0bQfw6ZPW?=
 =?us-ascii?Q?o2jUdNXdBgpKRgWuEWsrHXw2glZXnwOLd4UaxruZbK1lsCQtdz9XrqeLtemG?=
 =?us-ascii?Q?5TJ+A2hANe01NcPlBLqWGZhnHsbCRE6aEGTEvGycFyDK2oAuLX44xFNg0wS4?=
 =?us-ascii?Q?SbwnhKQEvO3rOtBxoiBdFceOzCDBSKIsiobnl4+GEuaAXAjdXHFtWQgf2FnV?=
 =?us-ascii?Q?4MWaKjADV/HP4SZiGnHS7pS5zWOmg4SFzJxOMwtb7aBs6c96dtVgwBTHE3JC?=
 =?us-ascii?Q?msmoOhoXQWr7ySY+/s3euZUYWx2U+SF2IxGQDzEi2ybp+tgflErjKktaHErd?=
 =?us-ascii?Q?ODC1uyufaIQ1hkiH6aM9gVPUA4C3EPRzSOZ0DFENCNERJjrrJ0UtcRYqLI/8?=
 =?us-ascii?Q?UDXHISnM+QDfXAo/OZZPZmM7OqYjO5SNV07ZPadLd3qfUl8K7n2TxGpNrKAS?=
 =?us-ascii?Q?qV0r1Jp0rV5xAZDXWt/EpIp4xC8wOM03OMhROqYdts7Au0htVe/I71cqp2GL?=
 =?us-ascii?Q?qiPQnSF7ho1zyLAgA2FousB3CCG0m2S5vbuXmWZacaKgTNTHSNtc+ECvLbW4?=
 =?us-ascii?Q?r6swBfMQEYXUDio6M+QNRBtWuuRgXY5/DIY9visDcGtgGt+be2h1AVd2NYMB?=
 =?us-ascii?Q?RlJH9PxFQvmT/mLLUPynwCtN/M4rTvpYE9do/wypMxV15QO8XW5jW1oCVKkK?=
 =?us-ascii?Q?9tN9iFwhE3aQ4sq6FNcga7Yd2hfPlhFb+INJ2OIWTIRfhobe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48051432-92da-4668-49b2-08df1f4f9c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 00:04:49.5278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErWydqmPyczNcHDXJfzJaJCJbM2fe/467shYBVNbPVCOx2eapGNBcG1tdQF6LSaKOY/Ozx9W5FunO53degiAEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9316

> > No, we typically hardcode the clock frequency in the driver based on th=
e
> NETC
> > version. Another simple method is to set the divisor to 166 instead of =
66,
> which
> > will not cause any problems for using a 400MHz NETC.
>=20
> There are use cases where you want the MDIO bus running at the 802.3
> speed, or higher.
>=20
> Some PHYs need firmware download because the OEM saved $0.02 by not
> putting on an EEPROM. I've seen boards take 10s of seconds to download
> the firmware on boot.
>=20
> The Marvell PHYs allow you access to the raw TDR cable testing values,
> which is a lot of data. Getting it faster allows nicer and more
> responsive tools.
>=20
> There might be an MDIO managed switch hanging off the MDIO bus, so
> again, lots of traffic.
>=20
> So please look at setting the divisor correctly to achieve 2.5Mhz, and
> maybe consider implementing the device tree property:

Yeah, you are right, using clock-frequency is more flexible. We should add=
=20
lock-frequency support later, so that a suitable divisor can be calculated
based on the current NETC system clock rate. Thanks.

>=20
>   clock-frequency:
>     description:
>       Desired MDIO bus clock frequency in Hz. Values greater than IEEE 80=
2.3
>       defined 2.5MHz should only be used when all devices on the bus
> support
>       the given clock speed.
>=20
> so it can be overclocked.
>=20
>    Andrew
