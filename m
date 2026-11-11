Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387309;
	b=bN3ryVY4ESXsWMZi1g8QWpud4v/ZCgkx1goTWAGF0wPf3XTvZxlTvbdpoYdBts+thytF
	 Ovrk0n66hfTL1qMF7q1IXwy5latHt7LMUc+SkeWGa4HfIQHBzKBgsoYvht8O5HqcBG2WT
	 +KaPYfxQSduUobeNSMWRCyPf/nLp8x4O53AzfvEGFyQSBKagvJddfm6CUsgB4C0LfN40p
	 2xQYWSzl2fDU18RovslZPAxEKNmSAcn37Nn6n3rwnHGDwx5/7yiDWBJ/WRWHWfrrON50p
	 mq47ElperKMn1vXaogH2qSKMhTd+bfKvnB0XDbwjO7hVRJfJYqJtEl8/2IzFW7kS6qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387309;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AokTGQCiLUqUMqHBE0dr4DU+tIljusSSzhPmNlehGjc=;
	b=Mi2Iygnd2ULBp6iJW0nuRBblh+bNXgB/8DvLi8zR0UlUNRnujIcrg9Kb2wHnxoph3vXq
	 ah76kLRcHH3ORRHh9grzp3H/lejALhCO+PsjBii29xl5J9z0oR0vbCSDoxkGwqBtsz972
	 82GfL+B6uPSY1IoX7JTG287D3FIXvKhgfXtZlVodZEPmH2AmNpcRhFWjY2u9qRCwFFkDP
	 F+rIMuzrWfN94Lt58C3klW6sv9u/mw1sF4HFBGXVvreuIWVyXbsJYGCQhkBZaTnB00dJK
	 a0RxlbtJqbwx71fVAzHwIEh8/mdiu17FVvcuS5mYagL071RVnEL4ILaXkbSdHWdkCcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LThVbZ3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.8
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A3606A327;
	Wed, 11 Nov 2026 08:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD6A3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LThVbZ3W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjtgegdJpyq05idc5rvfEkSPKYSFOVUIkbaJDtwUIEetHFb66RmERSDnaOdpY6jixliqkqx8USNuHdm/0BkwVwJQwO9YxaU/dTn8ZuzniZ4j9cdR3l4hI1coBqZJRbxV9siEm2cdppFQsbNl89QVqQtMTVaVqar1yI/44aRKFQ98sMILRHMjmMws/hq/6nnqa9G4rCi4LahD8sdBVuvW/KUYBvZBt/n1DhS8ryJXd/kTHDVfWHz9m91aN7xiVoZ13QdVWv5RLD4dIJO4/eGg2lLPEbSCDrewvDq4xPzywor6EvWQEC52pu0J5jRz830jLFgrF6wBqrvjoEbBTd+XHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AokTGQCiLUqUMqHBE0dr4DU+tIljusSSzhPmNlehGjc=;
 b=DfLtzVIUqqs4P1ZAaAuobtrcF2n1f3H+aDbLuKwSVNzwiz5H0QJTwE1biv9nxV/H3k6QETo/lTJb1txFiWjpk/jPoJaxMAQmMtMyV2Fb2bXt2ZM9APaQ1XHwMeGJoG+PtH42DHn5MFSD2JsPoWzZRw4eTq99XdPVwKZod+ZWNDitq09zjFezODhrNiCiirF67tx8mRgF/iZpjFi9O9CiuzTKudj2n3rpmhrn3Ukyt3YmILHKNpUawcBhUhiPe0B5umJ9QfbHHHj4m1gEJoQsA71NSFo83uZ4hvh7q/tWByEOUE/97ic6TBD2bQ8IXohrLsFTjm7gSL9U92I3iY5V8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AokTGQCiLUqUMqHBE0dr4DU+tIljusSSzhPmNlehGjc=;
 b=LThVbZ3WJJ3l9hdCqQSLO40cPjWr97JQ5SyZSwjQaq9sV5cyUSeBpROiwzpDANR+3lQatRHpgOAgV80diK3qsd0inlK8GXa184B8a5B1RRdEJZBUfnITWBicE/YSj4FMfupuC8S4Im3Uh8qOVk5Fi4vqs0zUSWxK3+cF7P4NIdwIf336/oqBQtOyUFFfJaqzrGOtrShnsGoJVpfOCzth1iOVB0g1r+E0OyJEySPnC3sdieKOzhGLo0KM5ReP1F/Mn9vfXLyXF6OuH/NPkXFVhGmJPc3eglypzXs5H34A5HDSXxLt2P52Bnj8A7xYdnOOzfUXI5YMOrm4cxc7kF6kUA==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by AM8PR04MB8018.eurprd04.prod.outlook.com
 (2603:10a6:20b:236::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:55:05 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:55:05 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v3 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHda5zqnIx6OMg9R0KUIBh7/TYuDbcmCqCAgAKOT2A=
Date: Wed, 11 Nov 2026 08:55:05 +0000
Message-ID:
 <GV2PR04MB1174069E2031569C5C43DBB6096712@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
 <bf8effe9a06ba569b5e5a36cc1d1982b2e3fff53.1793712309.git.claudiu.manoil@nxp.com>
 <20261109173701.GW18859@horms.kernel.org>
In-Reply-To: <20261109173701.GW18859@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|AM8PR04MB8018:EE_
x-ms-office365-filtering-correlation-id: 0cbc232c-0e84-429f-ce6a-08df3fd17afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|261009223027099003|261026121527099003|261022075727099003|10067099003|38070700021|4143699003;
x-microsoft-antispam-message-info:
 f6dyWKAgcPeUOU+4XjG8m1KAEHi1cC7H8zln8JDHfuSDhozEam0HOROaQyVnDX5IIyVyJ1dV7tC+UbcOADpni0jDykiHVN2ecX8rV2CFqHw81ukBIG2D93QG1CbPraFRU4xSGg7/nt8cydZIcX0jZxLnlVSS+k2BY018Nn2s+TR60XPQfSx4OCB4wuLlb/LaHKLvZLq3mQfMcNBrHPedIPk20mY2DIdsAZ11SWh5ZHVHfz0y0OFA6wVi8KU7MQ8lvIdhSPJ8BjL83E3hLZaJNI2sIlA9bFFAKFS7um4uIIHy0QNGVQn8dcqzqrdtEi5JZz4Butdr08vkyb0Q6Iypii3tuYecfjqjgItEebOgiCcMj5VNZG07QgVTUc/O5o5tiN4CD4KAmWoqP6/iKFEgDUE6QZLyosmjMgxqwDXasUBlJnZPhsBGht9lxwTrPoPGcsLNQXma9GflDtouaLoFSY7hdq9Xr1toSjVxWfxmD7+xuSL90S7Va3bGWi0H/IAxXOl7740w4Q1Zwl2Z0fsSZt7XO1PVTcQoNPZF3Ny76DmGsQf/eJ0a0ZiYXvSq4t+cqS4YFmRtRUSL0lnrT6T10Ha4yHzMIP0cUHZo0/phzeFgiY88/Dn3J7cZl7prMmjqvpP0bMR1EIP1k+h4OdVIHuJeTIkRpWNxAT+ZeWyjmQpUx+Zwny6pdDWHdnOiD/fC6IYInp/fVLXUFt6mnJDdI12qoSlXVjTbOVa3GIKeZBM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022075727099003)(10067099003)(38070700021)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZDDwGnex889iTCm6lA3ja6+e3nZfqki2JkKcbHb3Y0nDnMrH3JPNeUG8CZnr?=
 =?us-ascii?Q?y0FLi0bvQjD0Ir14j0L9pgjXGLcLfLrcU9QtNGyp62KvfaxJ11aGNRVmsKjg?=
 =?us-ascii?Q?gfXZGiTtSWRgUsJ3/f6bnkc/nQrOGgMK9OC1gDhnzSKtxBpbjhR8zi3bVhOU?=
 =?us-ascii?Q?rlkfLUcdJ9oBR2kdHwidyAeXmd4Mbgys52Y/QCcEedBqTECBofbJqib4xXm0?=
 =?us-ascii?Q?7tEm9I0JhF2lKlGFKhHiKWpkuHzH0WWcU5qzTKyau0jYJw3xmVtdcNfiTL7d?=
 =?us-ascii?Q?ih52o0ypBbxRk/FPKdM5hG7cKciZjRA0WCKkhX41/kB2jjMNUSQAGwPiAjiZ?=
 =?us-ascii?Q?XA83jnoqxtnpgV+AEEAXPPJMOOB/QVG7tA30rCsxvfrR2JQKh/bWwj/CaDbP?=
 =?us-ascii?Q?z7QdNiX4AuB5nIebGcMwQLum0MJnFPggAWDi8nSjhqsltKKjVRFTqD+HB4nl?=
 =?us-ascii?Q?7oMBc2pX0zcJd+Gv+bt8bf8VdtXqt3s3NmSMyr4qQl8lXoNV9OgIlkAWcPSl?=
 =?us-ascii?Q?RRl366/0XyLo91G5Bp0KUCTwh5b0lIwXzRdO5N18Pr+u/cvrDIiPNv4NU7EM?=
 =?us-ascii?Q?sXFaFYUKHY7Oba1CMq5Qt3lDhfohfaPB5nTrokvj/ErGCRB5cuA7NyzJNTfl?=
 =?us-ascii?Q?4rvQaMRnovLJCqJrp3ZPVoJvKDNNPQ4CU/zIn6lX8YUxPb2toCwvfitPNTps?=
 =?us-ascii?Q?eyRz4oWG8IPC2Cez1NFADCTp6Fi5U+jjkJcIW3G4kPWu6KkyVwqxzH3Nut7z?=
 =?us-ascii?Q?InBBGHypk5PvKVSdojb9gxGQcBWcxujCQ7qHPnzs/JsMPdma8a9ukfl3r3W5?=
 =?us-ascii?Q?o0vRUc+tuojM+lsF61f7SoZjSmALm1nnA4B6jJACN4MSmZAgJddGawAJn80J?=
 =?us-ascii?Q?EgHV9Xl1X/a2ByfrLfOZ5BbOoLLJcmWaDA+sXPDhSdVTAzZ4Cv3rDL95NHVe?=
 =?us-ascii?Q?UcNK/kM5xIAM/h/Ukmab+7KyJwOYK2XWwNIjYJxOJMIqMirxiGg1gZBQpNBd?=
 =?us-ascii?Q?RH4ti3Mmqc0Z2hSRTNIB2cf9FtgI+gnqglbI41FMFENYAlbQgSggBsIps8TH?=
 =?us-ascii?Q?lXU9SBQh9M4d6wqQt9QHlxutEYYOjvM/ag1tQR0U5FQpHiNcalZwlw2nsY6H?=
 =?us-ascii?Q?L+FP7fK1F6PCVajOMtUau9j9ywzYK6BJA1sctIr+2dk6fJYRI6N8Op6pd/q+?=
 =?us-ascii?Q?h2cJEdTKBcsoDArUYrthp+raLNlfXgtcEb64JzPFltK4ZGg0TBqzxoguiIjJ?=
 =?us-ascii?Q?Z/QfSUfCnovMH93DXJGzUkmmDdvxTWLiFO+L0AS2TD4dDcs6xH79wno8ewZO?=
 =?us-ascii?Q?We+yI5mXOzESZh7T6chjDH/CwsIlz+DQGfL6tVpJXaVD4yFnM7xTVJKip8bK?=
 =?us-ascii?Q?3phds6ynVV5Tkqsd4pzzYMMowLUXgTQ1JfSZXIgNAJwWo1UKns2fPyO0tu6t?=
 =?us-ascii?Q?iEhaKLT7Paah50/VN9WoC1pQ8Z/s2eL03MvCwyjVmRa1ssb0rymSOU5N4rG/?=
 =?us-ascii?Q?IP3OZEb4b3STLiRmy0pqAg2SlaTIHxEZHJn2aHF/HhCDHHxlLNNyywV1F7TD?=
 =?us-ascii?Q?7jjLX/HGYPPy0CXmyZecEVUsk5ht5AoY4mPRXL6XFhD7/cSLtHedgbASJkPM?=
 =?us-ascii?Q?gi2PA17oHyj6axjy02NJ3dXUrQQDUJluP6M1Wy9u2v2xMFUNjibeotZmYHLO?=
 =?us-ascii?Q?SPp02Xx3tDda4N118nNT5QMLOq68lLr5bzQug/6FNAtMVSQAjsGrRBDxEhVb?=
 =?us-ascii?Q?Y3P09ZXvWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc232c-0e84-429f-ce6a-08df3fd17afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 08:55:05.3717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+XL0/BDBDNkJsFTMbl7GjqYF3Vb6y+aQ7LcF3DSE76NSM3xaCtMxjOh9v3+cabgR/UeZlRYQoKposSEwGI5Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018

From: Simon Horman <horms@kernel.org>
Sent: Monday, November 9, 2026 7:37 PM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
[...]
> Subject: Re: [PATCH net-next v3 2/5] net: enetc: Enable probing of versio=
n 4.4
> devices
>=20
> On Tue, Nov 03, 2026 at 04:09:08PM +0200, Claudiu Manoil wrote:
> > The ENETC v4.4 devices are present on S32N79 SoCs and feature only
> > Pseudo-MAC ENETC ports, whose PFs use either the 0xe101 or the 0xe110
> > PCI device ID, and the VFs answer to the usual device ID of 0xef00.
> >
> > While the ENETC PF instances are usually designated by the 0xe101 ID,
> > in newer IP versions the 0xe110 ID was introduced to indicate the
> > power-on reset default NETC switch management interface. These IDs do
> > not indicate any functional difference between the designated ENETC
> > instances, and can be interchanged and re-assigned at boot time (i.e.
> > from firmware).
> >
> > Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > ---
> > v3:
> >  - Added sysclk_freq info for the v4.4 ENETC devices.
> >
> > v2:
> >  - Described why there are two ENETC PF IDs in the commit message, as p=
er
> >    review.
>=20
> I realise this was forwarded somewhere by an automation, but it seems not=
 to
> the full CC list, so I'm reproducing it here:
>=20
>   commit 6de2e15f2fb313f3ab9a84d0bfd5a867de11c72c
>   Author: Claudiu Manoil <claudiu.manoil@nxp.com>
>=20
>   net: enetc: Enable probing of version 4.4 devices
>=20
>   This commit adds driver data and platform info entries for ENETC v4.4 P=
F and
>   VF devices on S32N79 SoCs with a 500 MHz system clock frequency.
>=20

Will add this line to the commit message.

>   > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
>   > index c6571b5cc8425..b989823859ff2 100644
>   > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
>   > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
>=20

[...]

>   Can probing ENETC v4.4 on an 8-core S32N79 SoC overflow priv->int_vecto=
r[] in
>   enetc_int_vector_init()?
>=20

I already have a downstream 'fix' for this, where int_vector is allocated d=
ynamically.
I'm going to include it in the v4 patchset.  Since this issue only affects =
the new chip
(S32N79), it's not a 'net' kind of fix.

[...]

>=20
> Link:
[...]
>=20
> This does seem to be a legitimate concern to me, and I think it warrants =
a v4.
>=20
> There is also a review of patch 1/5, here, which I think warrants investi=
gation too.
>=20
> Link:
[...]

Thanks for sharing the links, I wasn't aware that Sashiko already scrutiniz=
ed v3.

Regards
Claudiu
