Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBD395AD4;
	Mon,  7 Sep 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747582; cv=fail; b=OiuaoNg4AGzjeLIYO5jRLcaeLzHnvGrO6h7J91YsabjVnvmWtqix2WbNirlWadT4Qa0XSrZO8f8ujBcz84HGe7TJfIz9zOUUZSoTINPuxzatzVaxvyLpMVsVqMVB70MhqMurwvm9pTGX3Yg3G5LXJeZXv7hcIdV9I/6JGyYsiBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747582; c=relaxed/simple;
	bh=ZQmgEiidD8171vowaSuFw30wJBqiG4OqMkhAaQFxq2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DPMyegvZjtW3ToJADtMm3orJlevBLPq76JrbBwBaH0hc0iJ2ZYmTuI1a69Pq1XySdx58xOy/1gX1Hv7cXqJXIUnVsEmgOfSuHHdQRPkgX6wP5t5mEX1bixCSd8IsmCSfVjE6A0F3Wceible7S8/xwxMmgfBWGpOVrMeYA6bKoeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oD0EQ+8m; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oD0EQ+8m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz8fsJhr4ztal/uu3OIicOA8FLvY45or9Y4oWo5GkcRLh4Cf+lCwJ5LXjB3laylv2Xvuse9l06fIbLFM5Xx79LfVlFUYoUHK+KOZzvQaCbdxuB1HB2kkMjbUe7qS3D99n68CwZgdqpchV8ATZiOxBlYQxRE0tQBPkdvaXpRWXa4//awogTz/D2lx2RJGc1WalBTrCbMJqy2cgwJ4jxgujG3ke7PKTTYX+3R+jHKUHjWqGruV4AqcFZ0mfmW5ZrgAzXgTazhkv8vFM+ZSmWmTjYUSfVWjdI8ugEuKwH1YGYqVixfiT08ppMsZRPptJNWnSD3qzwid1/QBL94QGkArfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQmgEiidD8171vowaSuFw30wJBqiG4OqMkhAaQFxq2M=;
 b=qrW96UNMI3RoW0lOTlup8fRShLiwFDoT5SPFJFzHMv1BQ+8usWpV3Z+FR//mYundoy+AnUf+G5zMGVToic2P5i8tOjlsqjhkvuvHmgKP77p4yTNZq7nxsuLmI2j27d2QL5zL2fCWCY9PCbhlTZbBBQDaR4WsEzNJavO4PPqoUpxWR5WpAQpMDYXMKBRINH1tSyU442SgvQkm8TMHQMx4C1dTO20gYw53kOvJbYiwc4+t/E4A8NDqmJPwR2nVR7kJv5tfUC9FS6DQ+bEFuR5k0mQDgiebBMCVFb7S7RugJNKhkxk9bzZ5OhYT3GV+irSWWrNOERLJFiFyNN+usP2EVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQmgEiidD8171vowaSuFw30wJBqiG4OqMkhAaQFxq2M=;
 b=oD0EQ+8mdgvnpXZ45KfTe45qwu387UG+Fpa/pSxYXitCfJLeDzSwlczLZwCvebryVsQBvGpVj9ucdfjN4u59zHeLw37lznaAuyWYmeMvjss0oKOVLAWdRtyc/8GhFqGGZJ5bGc2Z3aiOAxgqCRe1a0X2VTCjuTZvF/aC4iRJOq6Z4GfJxwXeuRCWUidJAg3cb1UXQtftGnqfSkDerAK0jROwWg+GhXmaPBzp2ucy9fdulA2ckW3fUphREbUaziUInDf98J/4T53i9PaOGpkCKpn2begJ6h6EYfldkihS/t7NfdBMKVZPTKdX4yVT+jn2F3PY70Vtne3h3uE3TL6hIw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM7PR04MB7173.eurprd04.prod.outlook.com
 (2603:10a6:20b:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:19:37 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:19:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>, Simon Horman <horms@kernel.org>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "swboyd@chromium.org"
	<swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v3] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH net v3] net: fec: Propagate PTP initialization errors
Thread-Index: AQHdPFv6qpHQhy0yEUyO3GP6X/WK1rbBi1SAgADXq4CAAAJXAA==
Date: Mon, 7 Sep 2026 02:19:36 +0000
Message-ID:
 <GV2PR04MB1173965A34420E072C0DD3A1988B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260904105542.70540-1-phucduc.bui@gmail.com>
 <20260906131711.247708-1-horms@kernel.org>
 <CAABR9nFYrmteCtb6E_txg13U31Bf50p0PUBvaOXi3gmT7Z+0RQ@mail.gmail.com>
In-Reply-To:
 <CAABR9nFYrmteCtb6E_txg13U31Bf50p0PUBvaOXi3gmT7Z+0RQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM7PR04MB7173:EE_
x-ms-office365-filtering-correlation-id: e0780646-605b-4848-9a61-08df0c8676de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 N2FSsQvDvqsG1RR0NOwN//oOshf+Vtfv8kBehEW7ohz3aUzlpkPMINPua9d5Z5NBSipe4SDJbtnCTth80mqRV+FTSGp7k//0IBgYamJRlpFg7giqoMvv2itblqY6d59oUgh9LXQokIXx6YY3Gqu/borfdVsVLocyxaeIlQvp9/ZR9hzq/g7HGN5YGNk5FMoPEk3liUxiXv7SXlo99ji8CowOBVhKvDRuV6IIZcq4czpJ+1vsmdybXE9svbAqptuxef+MmBkf2dEfQzbC8Ies2M0FQ8ooqBoyoSDcknZuoj2ICiByLnTWqBXNhs/hNLw0xA5eou6i6QmuDgbTxUhxGb24bt6GlKxhB96bBKJfCrfRxZPD3CM3eg57nzjLtIlVdqpwDSCwk2qbbtLBH9W58cjoKGPi7HY7a9i2dwUOFxMiGLKFMrB5zfba99mGZavE2vAdaI2Ws6VNgFMyOPK0GsP6OFi3qLUKJme6LRVk+MD+mcBD9HIzB7YtB5tk9EYUsB8IWf0A3Sf9n/O+8DLE+G9c1SIZtQBJECPff8eb/ErcvtmTlN2aGNSkcLLxJFP383bIcGW4oGnkpS5MvpYlfNlZHC94oHLksfE9f9S5YjbuO7RodX/e6ZlWX2wZcjf24GZGxZOp1ClATZRvLxsoLoLZkfnMeoeE6EqTSitVdDGnpDcp5jgWKVCKVE1Zk7GxX7sgJIIM9n2rGp9FtAyAQeTx9VW2N/gltthH5ur2QzI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BED1DAxBG92ptNFm1qXak/6drX1Y3thz2sM1FJdqBAlqE/WVhEq+LhJi3x77?=
 =?us-ascii?Q?Tl1x8nvl/JG9tAYLpWsWQgZMMo90Vo5m5lafuGyJxcJ/lVINMDcNi+IlxNH5?=
 =?us-ascii?Q?kH9wYzO+CaKj7qlhKMoq/8cATTwjd9Dg2/nlIPY7M6Fqb1gn5aEzh0N72Lc7?=
 =?us-ascii?Q?sbZ/ncfy6vZRrXBXncX4ZPfZ5aNfrHVUi7WhKm3UV40FEHzQFLWdKYAwK0Ba?=
 =?us-ascii?Q?m/YFB2OpOp33Tojio+veNF9FLlrFXUBQhBOkuBIZZNxLcJoPECf7JzQIJ9Q+?=
 =?us-ascii?Q?QvgMwAKULtHyTweCB+t/3GsTyv2m08QyB3oZV1lFnth9Cjyx7f9N73SsxWbM?=
 =?us-ascii?Q?6sSSx/6s2QC0c65XHPiILOdae/pXyygEChxqp0gw84GaqQj80YKbtfp6Ga/0?=
 =?us-ascii?Q?qWvMFzJHSe3539B8eBFiHmbNkZjD8t7WSIsjjXh84rpqn0VdwfKuQPD2Pt8l?=
 =?us-ascii?Q?Ma3pcH7F2Ti9ufKeE2YDfr7l80+ATDQU38veO14ZNnVZaSfG7gkHYeZMunqk?=
 =?us-ascii?Q?Yi4SkcJSKi97q2WwYHd0zD8QPqmslpS9o2/s7DVJGcQvOEdZmL228JN/ysRH?=
 =?us-ascii?Q?umN+NkYt498M97iRZIp5ERsczWb4WbnVwCHwSpaSiXtsyEEYYP2IYH/H3NBs?=
 =?us-ascii?Q?H89i0WXd+IUP1OW8WQ+M3mk+ey/jM8+8CMCkpNw1melos92iPTVrLiOJyJJ9?=
 =?us-ascii?Q?ODhPlq37b9wJ8vcF0ztT44/Ej46w/ye/rVwJS/mql7+XxNSKsfp5dxL79S68?=
 =?us-ascii?Q?qRXEAGtYc2Vmi4mG66owr60gtykud0qd5PVBOabaAHqXeBZ/y0s0WXko5Xrk?=
 =?us-ascii?Q?oZRIOmGF+Rjvb9Wh8+k6S6kCOItfbdcN6UxGbbYzQQ7mtX88eDtKtGm9CO9f?=
 =?us-ascii?Q?pLGOFMCNGzYvqgx1MDwLxz3qWGwtJk4/f+UR9r6v+GJAwKh+8JTaUCmf31ZM?=
 =?us-ascii?Q?sqWvl8h4JgkhL+Ahw0VFIc7pQ0GrxDR2NBWCm18eG3Iecp1OwVj8u+aK45h6?=
 =?us-ascii?Q?BK3SKDHDU6kGEjQEzqgmO/B7ZMf8l2i/z7CeoCPgMJPso2od4ZD9JbKbFcYD?=
 =?us-ascii?Q?Oz1pZVlH/oSzgAlQCqR0k7ERRXyXk7hv7SdvZ/zGQabsnMb8dsk8r9NYlQtn?=
 =?us-ascii?Q?e5QbzLKvttNIoNKqsaZmWHmTxTVsayWRMeuWL9OxTQz936duzhZmos/6t4bZ?=
 =?us-ascii?Q?0Ku5sU6QUJuIgSGpZlOeg3cWZXlyAacxh7T090yZt6vErqv44d0rBCQ90k8l?=
 =?us-ascii?Q?3w3WU6CyaFqulOabs8biUu0Y5Lhx1GJ7D5CtbSkfEp4tSDgeUzYD+r0Fly6l?=
 =?us-ascii?Q?7fqexM++phgdjIRknohEvJ42BpYm8SL4ztaSAP1PVUEqvec74jT5dhgPS9jx?=
 =?us-ascii?Q?7nGKDdIlJUAwm2CIyZ+CNODO5upzkPXiwc4yyKGgmVXBtFzcz0dvpZ9Pi1FL?=
 =?us-ascii?Q?z3lUe7ZlIgRCbtYis0RTrNy5O0yaY5P2PFgZxl1hBd7d6p13i/3xKsTa04to?=
 =?us-ascii?Q?ehNGIftfqIwvb+HuVvYQ/YBCe2KNtKVLNSZ+jIMdJ/c7C06DQJI3ts6nQNd9?=
 =?us-ascii?Q?T4wUVC6Dj7DzbqAxdKpP8i+hCFqIZgx0+f4ngyuRZA1LpqOwWVXBuf4t+ubp?=
 =?us-ascii?Q?3IUvb4N8Mgy/3rQ4/OOXnWswkVX1o4GKQUSi5EXIZS6akVZMmjH0aswpCCph?=
 =?us-ascii?Q?OcOtvis8erfb8ruOLSDnNTlPsoqK3zcUGY1uOK8XdgK0IUrO?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0780646-605b-4848-9a61-08df0c8676de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 02:19:36.9072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSlc/oJToI3WUokVYiBpHgulUHXVGYXtfxZS1YaeWkwNWN9t9NEM/aCAQ2yFUEQ8ERPcEvHAmCPP0pM9Q1mVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7173

> > [Severity: High]
> > Does this error return leave the devm-managed IRQ active while propagat=
ing
> an
> > error back to the probe function?
> >
> > If ptp_clock_register() fails, fec_ptp_init() returns an error which
> > propagates to fec_probe(), causing it to jump to failed_reset.
> >
> > The error path in fec_probe() manually frees ndev via free_netdev(ndev)=
.
> >
> > However, the PPS interrupt was registered just prior using devm_request=
_irq(),
> > so it remains active until fec_probe() returns and devres tears it down=
.
> >
> > If the PPS interrupt fires between the manual free of ndev and the devr=
es
> > cleanup, will fec_pps_interrupt() cast dev_id to ndev and attempt to
> > dereference the already-freed ndev structure, causing a use-after-free =
crash?
>=20
>=20
> This is a pre-existing issue:
>=20
> Previously, I suggested using request_irq() and free_irq() manually,
> but that would add more code.
> Another option is to replace alloc_etherdev_mqs() with
> devm_alloc_etherdev_mqs(). With the LIFO cleanup order,
> devm_request_irq() will be cleaned up before free_netdev(res->ndev),
> which should resolve the issue.
>=20
> Since this is a long-standing, pre-existing issue, I think it would be
> better to handle it in a separate patch.

This issue is currently being addressed in another thread:
https://lore.kernel.org/imx/20260904-fec-ptp-pps-event-uaf-v1-2-9af446be4a1=
1@cherr.cc/

