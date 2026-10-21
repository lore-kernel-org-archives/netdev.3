Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597204;
	b=jW41fWBJbi3fCNa8cGq/8khgj3qj/Wd8Ep9cygtE01uk35OzHrS8yKGbhQKlIiSe9qLl
	 HJOx9TJ9ExWv5pMKcdZ7xd7GJ2NoK2CjBCZfHiNSipnXeqfGzCXNX6kTrjyN9iSrIm6mc
	 9CoPgOOA6oJTqQorwrTnzGNK96cPrnx/djmX7PY7LSipJStVthotAcoFO78X83452PFBo
	 CC/MZtBxJrw8dKodPXHvA588nQvmASor/GreCXczMD2llQvmYF4Yqq+3il9ZvrK/mPGpJ
	 2gXuyux/IUvEWDpM3RXTu0pI2KBCMLAvu3qJf1PNS9hmcVh293qTGpsief4eMn93g7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597204;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H7vUyN45nNaLaDZEyymoRu71mjvVM9A0C8iJwS/LCjc=;
	b=O5o0GxVfRvclIKY9Dicfg3yKzn4jPaeHs+Es903rkXVZX2xDZu06HOu7Q5rOY1X0aVHz
	 djyk/xnw7p3qz5GE+828qJNoJtBx2UJ4PdVm9EGSdhExLigTxDgFNUH4AuTDeFib9iOuQ
	 5mekCSYdoMzIwprgFBUVoCpX3wjp1MeF8JsTwDX3flxEAdTxa5rVwjEKFhHC4R0j2Gz5s
	 roh6zP938coCx074yl5bKGxSa2lt7gQ8c3E+U4cZACU7SrUE56BZWn76ncLY8wv9mIkI+
	 J+mQmISn3z3fHwH/asAoHMC1lRcRGxO1PacipRLtvxuacESSL7GKzQ2/t0kjIAYIF8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=BUTKcQWj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.54
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876B606A328;
	Wed, 21 Oct 2026 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C876B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=BUTKcQWj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFdOr7M/rxb/LtEuDRqJ3A1zh3+7mVQnYxrf1Oryy31KV7JDj183g1TkVs+RXIyfxGXodmW5DTCvw9rB3OK8KzYnVACLxfn1D6EejEmIKhtYoJOPd5crRq5FTtHmmxHKB9K3/7F5pKudTNQ0cz4yuvKyk8FBV4psF2KqnUlx3HwDtR3owU4dircYP0SQ9lhE3IVJUPYDGaEdElCFwshUWZhLm4uwL7hMp3pbIB+MILaV563VnurPyAh422AXnyLtiUUeeWTjCXcPDprKAS/2LBKja1ve6A3ovYN4yt4cTQRmI1N5Shc7pHC15rfO1u+kQHQHpfomniaECiVy8qIPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7vUyN45nNaLaDZEyymoRu71mjvVM9A0C8iJwS/LCjc=;
 b=qhnblYirpy4O04IHjnaze1kjGDC/0t1ZpLf5YEsbyZKvfLIEBfiYcjj4/SR2G/wURBLnSV/9vDZ5IKgHB9tXaleAyy+IZ4wIVBYi9XRMBPjd1JqqIp8h0AvaXiQdCEJaY5WZB4bcuDdbnO4Ub9JmYf9//R2bn3I562YT3A52RONQJOw5fJY6J89t4Zo4NQGKOn4frtyWOYaJGfoHCDC3QnZRjmdDoNxEee+r74zfHY4mD0deYMQ0acAsi+a0rFnuUE1gSTHi0nBohXvU71AEd/FDHKhlZ36fGef/1Cq7We/mljMU2Hz6pDqTysLsQkPLgJMHYOXV/mAJBaxAlpr8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7vUyN45nNaLaDZEyymoRu71mjvVM9A0C8iJwS/LCjc=;
 b=BUTKcQWjz1FJWf3IXNmu3eEPfSfVBG1IkIRnBcO+yGjQWFG/3A9gGSWSTDcmEP0H3rK3xMoIzCad9qSk/4KmbErF3ic+Lyv/8AbUMJntS9tqBP88AAiH1fE5LIrRMQSbkWOUx2NZGrYFZlXsMH3Sja7rAvegYpq+jE9r8XGBFb3pZpI8HyRF2GB5T1jto0Jcp87RNn70BCPNnd02XJulhTMjBI71OJZVwrg1zG6kH9nd4TJ6o7ndjH+pE50AU+hvhbpLl0nTyIEbjpWgzOsm5y3LgFb0FEs40Wa3CNdl+PUQ/1gFKzZfF/T2phpTTC8oSEa257KoMkv8qq13p3CpfQ==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PAVP189MB2334.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:32e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:40:00 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:40:00 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "netdev-bot+sashiko@kernel.org"
	<netdev-bot+sashiko@kernel.org>, "github@szelinsky.de" <github@szelinsky.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"piotr.kubik@adtran.com" <piotr.kubik@adtran.com>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>
Subject: Re: [PATCH net 05/10] net: pse-pd: check the PI state under the lock
 when setting a power limit
Thread-Topic: [PATCH net 05/10] net: pse-pd: check the PI state under the lock
 when setting a power limit
Thread-Index: AQHdXtn4P8hqdrCUVku3gm/MEdnS0LcEkEmAgAA9PQCAAR/fAIAATeEAgAHr2oA=
Date: Wed, 21 Oct 2026 15:40:00 +0000
Message-ID: <atjcxjV-scVhA6aF@p620>
References: <atb-3EIJynaRwuwe@pengutronix.de>
 <0378ccc3-4807-4d63-8e61-03b465952929@bootlin.com>
In-Reply-To: <0378ccc3-4807-4d63-8e61-03b465952929@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PAVP189MB2334:EE_
x-ms-office365-filtering-correlation-id: 21b60e31-4dc9-4090-515d-08df2f899116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|38070700021|11063799006|4143699003|56012099006|261009223027099003|261009221227099003|261009221727099003|261009223327099003|261009220027099003|10067099003|18002099003|3023799007|22082099003|6133799003;
x-microsoft-antispam-message-info:
 qZnbb2TrOQLD2vxAAQxeGel8clDIgcYnDToGRARMdAbyYE9QnXbOBh94F6SM/629ovEyYuPnA+IvoR62xr4eaFr+nhQuUvC+3Prul3x4eXwu8bnsy18B1klQSIdFfEYTabb7qnbP33eo4mmWJBeObYA+uqr4UfqYWvAwqQkPuz6y3UQmOXnPTtcfP2RxT3uz+eMIJhAk2dy9KWFuGKm6GouObBk5asUiJZQLjlrnFCbbL82PEfDq44QWY1yiq/d26vhNH5HI77aucy++RWMNzM64e0p+S0RLfKzJr59zIemilpBmBp3HTQCmlM9qpHXhWs0VeW0pC02es5/Bqf5iitby1txntv2Ivi1pfZxwpe0HwSf9/qmwIM8Y0SJD0JUQfhGxFY2ScvOn1v+EmNmuup9poiroZA2zPIOOBlmIBCFf7rTKbRciZ833/q+acf4QPJ+hFK6LSqkmvHZUTlh4K/RcczOXAGZ+iNLbRsOHhkq4Sn1eDXAYVv3Gkg+RROMaMg2uxzAMOJh2gGV7I87vJAujdjHv3JQN6K7Su7rcigJPBzX/NRaSn8yRKKnLJ3l6/teVoIHvNODIIe7kmX7o52rOrkwRN7dPy5p4JtZ3hSYAhFi3xJsvMkEqdJAh3NLU0FbeQVqtCKIF4/f20jUbqCvN2ds4S5g2haIb8jLLB18=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009220027099003)(10067099003)(18002099003)(3023799007)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M4YhlrAVyciGo9YTGK1yBuj7n7c+R/ZStiH3xPtfybvCr3eNP2do7RXCDl42?=
 =?us-ascii?Q?h8KIotqbldm9JFVLLx3aLD7WDK3gflsM+UU85xsnZ571rAhISGjm4Z0V1XbZ?=
 =?us-ascii?Q?420wu2B/51tEaj1tGA80I4puXOBupKQSh0021eVdvGu1S3eqvu0pKXMstoio?=
 =?us-ascii?Q?hf8m9eLEyqaitojcDc9LztLKJjW3wpqEX1DU0Dakn0CIIw38s/MHIePc/sJ9?=
 =?us-ascii?Q?XZG1cj/el1Y9IhoQXOWMDLQ44TmsVeF4FWPIBfxrCwnyOmp3ENYQUhYUAO09?=
 =?us-ascii?Q?Xib8t3MyRohjtpJ9JLzqnz0FZj7BTKhp7TNIlE8r15qwDZPoHzxvUgaxKYtx?=
 =?us-ascii?Q?EOlHVef5JFAwYF2h5ormMwcRCZEl9J0dx4WwI4i0jqec4E0GKcZFYpP3hozX?=
 =?us-ascii?Q?dNmHhnYejDSGcQuG032uI72QUVJWy5q0L/xyALjERXmX0fVl+ehg/IreUy90?=
 =?us-ascii?Q?e8YeMCnI8VRVcdSg7ZN9aHkEjni1NXqQuwXmTTRq17BJ3T3WQlVePA9gvhl+?=
 =?us-ascii?Q?NJ+G8buMl5sWANPUPrpv3bfMCr8yE25Fu0h1wu0pGXHj6/AvFWzE5VVMNN3c?=
 =?us-ascii?Q?0dt4HA8W41rQ6LKYOOUQGlRkyMAFuyr2IREJy25scuootUPoqYxPyP7VgR66?=
 =?us-ascii?Q?U6punUaNrwJViheoS7BwzEugGa0M/TSOKxF+grWBB9hDaUCRtiTK19EtgtgL?=
 =?us-ascii?Q?fC5GSjonsocdxCfynTMxTnPZ0ZMs6pmIc50a0BJb5jNbFvQ0sM0nDspR3Vwe?=
 =?us-ascii?Q?+rr6YyeDkHSPa48V84vU3IKbSpKJ79NI7GlD/KN7yZIhsIV10knYHyoYsnG2?=
 =?us-ascii?Q?trjlpTxXKtDNmHGxfmu/ahSXLN2ktxnboD+FPZijAMOe+BxBppY0qKyRCdxP?=
 =?us-ascii?Q?LtmZ2PLYcY6Hs3p+lvJ4LXhvvHWcvT554rjhSP+B6ykd6iWNazKuLyBsYT1o?=
 =?us-ascii?Q?3mIDjT2lP2sCKAqekVrmwErxXkQzPLf0noQJ5NRxyjzGIQMO6GruCFwv4KpE?=
 =?us-ascii?Q?IrAMtxHLiMkN5+rbqUYmUYq12kAh8+MK82JTVwTxCJkfMza/sq0wH1w+6KMO?=
 =?us-ascii?Q?1fsw84s1DpTUxZ/D7D4xArh+U5KKbnjDqrNU8WaO38xIkNcHVEJiwEqjyzQW?=
 =?us-ascii?Q?cxe+gIx5cAzoWwY6jTagKcYzXImhNQCIwiu6DVoJTTlNMAcPAuQxPMD3mMGz?=
 =?us-ascii?Q?EEQ0X7O6qqCTXi/Y3KyUS9tEE/YSxFfo8fR8uUwBhlzjXm50qpScK+b9bcqB?=
 =?us-ascii?Q?uCC6w9qCBR52u6OADOZ0j3+SWuIiwZVJOETT4mwOQbMYiKqEsz+dFjYiPqOa?=
 =?us-ascii?Q?Cec0pBoer/j/2k4/fACU1MbYn5p5yG3aLqmD6FwuYFH+JCgzyKI+YZ2G4oA/?=
 =?us-ascii?Q?YgdXKnyaVkRrf/mmm1gmGjv2DNSWC+XP7X2IKcn4rmoQM1F+vy+J80595oxe?=
 =?us-ascii?Q?9gxoWMUJ6nGNqNxUf9+SERMFYja1+dHKJzjqTFoALFzYijSSKTfZwG0Ifrgz?=
 =?us-ascii?Q?a5xtgU9HxFyypoav6JHHGeeyupPqhdvu4qnSOVizp1uwXX4KThuYeGjVUrBP?=
 =?us-ascii?Q?8ZoZjPE0D/Ibr7cb4YaYSsok6P+i3hT9fQDdl14qC6HSkrLRnxanwQiCZdbD?=
 =?us-ascii?Q?ytKi1kVIpjCPN8glq/UzqPS4BDPHc64apqzJDUwZ6bDVUKFo6t2ERZOkTq2D?=
 =?us-ascii?Q?kBvf3xDWRX1h0J5vi6K90fVRxNf8nYNeR2NS4Y5XRd+soFz1ZuWbitSrofY6?=
 =?us-ascii?Q?oduq1Utt5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28799ACAB79F29478193103980BD1630@EURP189.PROD.OUTLOOK.COM>
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
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b60e31-4dc9-4090-515d-08df2f899116
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 15:40:00.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiVUIeiv4M+67I6wtJUJhRzdzkXfuYBWGtzwwRVjPGcSoMDRhfm49XqFBsOyEzwKbq/KPNSUwy11P6G6XeiP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2334

On Tue, Oct 20, 2026 at 12:19:28PM +0200, Kory Maincent wrote:
>=20
>=20
> On 10/20/26 07:40, Oleksij Rempel wrote:
> > CCing regulator related folks.
> >=20
> > On Mon, Oct 19, 2026 at 02:30:24PM +0200, Kory Maincent wrote:
> > >=20
> > > On 10/19/26 10:51, netdev-bot+sashiko@kernel.org wrote:
> > > > >    	previous_pw_allocated =3D pi->pw_allocated_mW;
> > > > >    	pw_diff =3D pw_req - previous_pw_allocated;
> > > > >    	if (!pw_diff) {

[...]

> > > > regulator_set_current_limit()
> > > >     pse_pi_set_current_limit()
> > > >       ops->pi_set_pw_limit()         <- new, higher limit
> > >=20
> > > @Oleksij, Here is another example of an issue related to the PSE PI b=
eing a
> > > regulator provider.
> > >=20
> > > @Carlo, Kyle is working on a series that remove the support for a PSE=
 PI
> > > being a regulator provider. We will see where it goes.
> >=20
> > Removing the regulator provider support is a bad idea:
> >=20
> > - We will end up implementing a poor man's regulator framework inside t=
he
> > network subsystem. Networking folks will have to deal with physical con=
straints
> > already solved by the power management community, requiring a different=
 mindset
> > and domain experience.
>=20
> That's what we thought at the beginning of the implementation of PoE but =
in
> fact that's not the case. I don't see currently any cases of using alread=
y
> solved regulator constraint in the PoE core.
> The drawback are:
> - locks issues: solved one by using worker but there are still others
>   appearing like this one
> - code complexity due to all the regulator callback wrapper
> - converting mW to mA for regulator framework then to mW again for the
>   PSE driver callbacks. There are even devices that are using current
>   limit therefore there will be 3 conversions.
>=20
> The more painful issues are the lock issues.
>=20
> > - We lose built-in regulator infrastructure: DT safety constraints
> > (regulator-max-microamp), over-current/under-voltage notifications, and
> > sysfs/debugfs (regulator_summary) visibility.
>=20
> I disagree here.
> regulator-max-microamp: has not interest from the PI side but this is
> related to its power supply. The PI should still stay as a regulator
> consumer so the power supply could describe this binding.
>=20
> over-current/under-voltage notifications: we are already reporting these =
PSE
> PIs notification through ethtool. We will loose
> regulator_notifier_call_chain() call but well there is no consumer to the=
 PI
> regulator provider so it's mainly useless.
>=20
> Yes, we will loose sysfs/debugfs visibility, but is someone really using =
it
> as all PSE communication goes through ethtool?
>=20
> > - The race above is just a lock scope issue across pcdev->lock and the
> > regulator call, not a flaw in the abstraction.
>=20
> That's not something easy to solve as PSE and regulator provider are nest=
ed
> together.
> Either we put all of the lock issues inside workers, it will not be
> synchronous and will smell hackish but well...
> Or we try to combine the PSE lock with the regulator nested lock in one w=
ay
> or another.
> Do you have a better idea?
>=20
> > - Writing a custom power state machine in net/ will introduce more bugs=
 than it
> > fixes - especially if we overestimate our ability to upstream complex c=
ustom
> > logic under LLM review supervision.
>=20
> Removing regulator provider will simplify a lot the implementation so I
> think it will rather remove bugs than introduce new one.
> I think we should let Kyle works on it with a RFC and we will see where i=
t
> goes.

For what it's worth, and for others that might be interested but I missed
on cc, the RFC is here:

https://lore.kernel.org/netdev/20261020-pse_regulator_fixes-v1-1-fd6084a22c=
ba@est.tech/

Thanks,
Kyle=
