Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967744065B;
	Tue, 25 Aug 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668408; cv=fail; b=bgREVuQxK/4e3fcas2Jx63cpxAkJPfpRZG5WUhNPNiRf6mbVK2EwUmpy6jiKQr4+JCONhrNQg8zl4kOtoED9rD1ZLfVC2IpbKdZVKpJoA0gbN6gYCij9HUhrwytQjTs86Zkoc0W2uHND4netLulvmVqtFTGb6DKqoPz9pRhzkAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668408; c=relaxed/simple;
	bh=BXO0VzOZBW+1Xu1EVQCygWa9WyySL3CgojR8TqZarag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTQ+jNjLUzsxnDPO53JHMK3CQnx73xxYzlO0LVEOzEGOx0m+xA+2/L4GzwwqahX4G6kP46Cm5WfSicgWvW53ykXqO3WmrNtyBjjNZAY0EKjVMMN7DkHe70kCkgCppefFLpuwM/AlMWyTAgCdJvqOrie2tSrc9K/LGHKeJIpGKIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=aQPsaCZp; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="aQPsaCZp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN23W5pLxk78ig0eczYlvFe0MleS3SjYwy5aSPyNgBAWPEIYFkLIYSya/ydJKImbPQSRu23Khfwzk3hb8uXgCOVXCnEFWA6ZAQIv+ixv7hNAI2WSS6MNND0HMQp1FTDeOqN0EKVp9YPKOnBBByw/u9VjCCyo6Lw02a4BpLqiOwgN0LiaolhIsGPI4ZfFGENYsF1Z8XCjSe2VudLuhwuxJqbADxuZ6pALE1Mvyg8dWSnMTUOLTiVRKoc4H7/lkqh6XwEqP6IwVyGxnepp7E4ra51PQJRjo3GTSqieAl6dvJJfsES0vJvU7Tq1Ols/ZGSsejHimq96RLIOILiuAABnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4nmG7ocnJOh2+/FycjKDXESZrtfAJdtv4hSPsO/0xc=;
 b=O0+LnjLgD4oIPZKvHX3sDWP9371L+o4U2I6w4z+sIJaUbEzPuthn8UzeUyUdnH0R5DmkW4zl0f4UUmb2hevKCsnnkmnNZd8WRb2nRX9wRsRbaYc8ULpxwxHIg9viMbHhwn9txy4OcQT/Cu7zkSJeDJC7QMZlTFw8tRd69QW/MQe/xhWGzSWmKxfXcuK3aUr07FkxRAqKAFIAT3oY+0Cr3Tn6Bp/pWuUT25RtWNwPB0BaYZSXuxOObZj38Ti/EO/McRG+ua8kImax0URhHIUbFCjJxRvTwiQsPzNK69Y3CAgloyt5so84fOSXdyJ0gVZQY5GDscEWj+GCWLW+B1Bh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4nmG7ocnJOh2+/FycjKDXESZrtfAJdtv4hSPsO/0xc=;
 b=aQPsaCZpHOuxeZPAXHbgXebpn627RSpoS4s2w1wtQbSgQnYRVIxP8eRIpm7wCnBAFH0ttw90DCk6jZ5yULWRaUMjhjUCW1yBQLp6r2cGWC6tf6yYqO2L9WRzbAtbfT7sAeMrUpgdoMNF2MrP3eXbsVeHyROxQ6CNtqEaLwzOWw+qIQ+vBkmiiZchJjbvFSLY0W89fx6hwVHx5SqjDKxA89n/DhGf1KBy2YU2q1E0TkUnOjEFq861U5SHanPkG24VjQO1tsH/LnmtOO0204Hs0kEMyHc7SF2t0U/Z+LlbGtCSEIZeYoyK8J1rpt5cUJpxhxjIshtTMG+yHjPSAedX+A==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by VI0P189MB3317.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:33:21 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 14:33:21 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Roland_Kov=E1cs?= <roland.kovacs@est.tech>,
	=?iso-8859-1?Q?David_Nystr=F6m?= <david.nystrom@est.tech>
Subject: Re: [RFC PATCH net-next v2 0/2] net: pse-pd: Add LTC4266 PSE
 controller driver
Thread-Topic: [RFC PATCH net-next v2 0/2] net: pse-pd: Add LTC4266 PSE
 controller driver
Thread-Index: AQHdMK/GAoecupEPdUSnby/yYa1CLLatKwYAgAGw7wA=
Date: Tue, 25 Aug 2026 14:33:21 +0000
Message-ID: <ao2nqVYvpaP44Zcg@p620>
References: <20260820142429.2285172-1-kyle.swenson@est.tech>
 <41dd51e5-ac20-48b5-9e7c-4d2d261f3402@bootlin.com>
In-Reply-To: <41dd51e5-ac20-48b5-9e7c-4d2d261f3402@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|VI0P189MB3317:EE_
x-ms-office365-filtering-correlation-id: 954613d5-616f-4c85-5e14-08df02b5d030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|6133799003|5023799004|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 K2gQIpz0ptJfyeLB92C3Lr3j8KBvCavWAVCK/94hEW+M8kqfWuJGxp1jEmIFfLHIpkTxIFS2bxN2BK/BZWwkkjHrCUsOqn1CpqMgj4oFvGgUgUo+aiJahqK2YYuEvrFzY2uHtDCTfOhEA960WzV09X+Oaq5qESU2Y/E2kXXP0IMXL+nNVfdW8/UCTF61s8xNXpiwMXdRjw5tPkTx/QKrVLnD8i6WExv0GdpELCYjgXkODF1awuT7eG14BzUgQ1XQvAoBVwJ5GpHxmIiiG0Gm+Y8WAgecVXoxp6+cVK57P4clMSDwXg70MkTRzkH524dmTZf11ctuIqnsa98WDMdK/DniE8PntWXz6D1peyPy5sy1sEwjIsPBOUEgaCRg6755aZGUH2WqExmqD2KRyBejwmiKum/4ILGac0XXEETy7xAKkTDbR/WmO6TMChIFkd7Orme/X691a2J4TTuouVupa639CNJAyGdb3nvoDaPiL0QNhcJ/xPQD0QgdvBZ+aNjZ5QAt/Q8wSF5eHjEoHhvL6supLMZoUFZ6pNdF1qhh94Tx4qZPHo9QNrZady65HWQwputSUQyAAJ0doYx0z6gPCViwKZsVu3FWeHneLxNcTe8I566MHIe+tS+iULFjDYy2tz2fyUu+aaf9SIUYWrpEgIUFjoj4Mityx83vigMOW14=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(6133799003)(5023799004)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D5h4LnWR7LT0K0AK1zmN5GcUWsIwC57qVMYEnGZPmjq507bxh7OpxE7yC8?=
 =?iso-8859-1?Q?J1vJ7WvLslPcuFl/gUM2Mwx4BEo+UstYfw5or5LZRp/IOit9WwvsgYQrwh?=
 =?iso-8859-1?Q?GTMTUR95ZJHA97MW2diTt6b/ng1cF/D3leah6YBhvidrlnZEdEORmMLwdM?=
 =?iso-8859-1?Q?yGd+D1saLXIlTPUklAVBOz0kzKz9L1HwKvvQ2L4NfJwIt/wjJIgysevtDg?=
 =?iso-8859-1?Q?CPvnUjGtoieKcvxdSwHHrK9f5mKxLDippMaOFGEQV9Cu/RbNn2E+IojzOo?=
 =?iso-8859-1?Q?2foGlUAdEt7zkHH7FHJygjRadwbvo1e74B6Vvoz36d3LqPelPC3o1b5uw9?=
 =?iso-8859-1?Q?It/6j6KydENCrNKwJX2khpkVKs8Mpc6fjKdDYrStG4DDYs10v8Kr1kHI2/?=
 =?iso-8859-1?Q?fQKVayarc3aqfGt4nr/LnKkuE0UEKIg/Npr+tCxAKevxzQCZouP5ghjA3l?=
 =?iso-8859-1?Q?RJqyVbfYgQ7d8d3kYGGpyPK1uEPY1R127KGvbAaHw2dQmZXANnqqzljx8m?=
 =?iso-8859-1?Q?hyye2YbmnPTv+ZQsGk+kUtNknO036nfe30AJsltYNj8oa+FhOVaJ5vtV/I?=
 =?iso-8859-1?Q?kMkQ9BxmyKwZOr+C1MMq2P/yIl6F5BM7Va0wcnqa3Xk37Bdw9uZklwUnd3?=
 =?iso-8859-1?Q?w92HZgh+gJyN5hSojzKFLzumyH3VqbQ7fnc3v4G6yJJP4JCOQbDdvYTQ4H?=
 =?iso-8859-1?Q?GPbQ1zCe7hJgG+mqsTUfQstDiszfp636zDJMVQ56rUGHOxUXyDJ29/7Qmj?=
 =?iso-8859-1?Q?Mh/74WDXu7/kxrRmHoUOVcisYAU90FF69VkLrbM30j+6zOHYUjy8+FDcES?=
 =?iso-8859-1?Q?IDeFuC5p7PtNjZIsHxfExJNI9pT0ixEGnPCqqQWkx8b4GG7LirJTX4c5V7?=
 =?iso-8859-1?Q?+dNfKtRgPT0FjTaNFGsXx4uh6ih6hStmxHqWva/sWEaHIn3zv+FjaYWof4?=
 =?iso-8859-1?Q?CMxz+rA+NK6xj0AKOgMW82PYqjRwawHTUbv9TMDvnFpQ9DsVwStGI05keZ?=
 =?iso-8859-1?Q?sqgc/vw92q+VUynbTwup8lAhkhZEPqZAl2DAFj5nseGiDJT5GYCWehE+LH?=
 =?iso-8859-1?Q?XcJVRhKiM04bNwzXcYHARTUjGbjPfQtrBetYl8Wdy3PVNTF1EwB3mRmCgA?=
 =?iso-8859-1?Q?tzLlVdrPSmrduMnm6H4WYVJ7ZSxHRtYdoOxkuKpJoTunKdf/WfVTpevuzN?=
 =?iso-8859-1?Q?L21Wy6QJtfGI+Yx5NhdVaGRnsRhK8jOnDCayjxojVOrzH9doF9QIo6zifh?=
 =?iso-8859-1?Q?7ItEjDfsfVLyj7rlXLpd91CWsydAkKBtI3ARbk2ltVSP5Fnni/WVAaRTww?=
 =?iso-8859-1?Q?NzpiJ64xMt232bjeAWJC8D3S5rj2dt327gAzYl0ZWwKXFSxl6kd9Yo1J9p?=
 =?iso-8859-1?Q?jId/8pMQkZMd9WWwSWulfEDDY1/o6maTmTrDePReOPFlN0ij7QGeI1prXU?=
 =?iso-8859-1?Q?tjNqE8JtuOYmAKdH6Ko7qCGGhxAj9Y5UxKH75t9fNsgM9JUYq5L2j/qLz5?=
 =?iso-8859-1?Q?IYNRAJl61a2gDTRA1LSoDYOUypZ+hssXOVrXvcgb+wCctBFmEfDFciTej6?=
 =?iso-8859-1?Q?Zp12AqoKEqhPq2qHrkgiWpP7UkTkeQoGJgMtb56O17vYAW1aXx2rSf9N+n?=
 =?iso-8859-1?Q?/UUYNZ6A1czdesl95Q11J8bL0QloFfmyEY1Ez8FvsUxcPrPYq//na1k2fx?=
 =?iso-8859-1?Q?88QDvtsSE8s2AqaoQXKjfcvPegurlshuRMqQteabHwmnQlLK8TzBaGqg2J?=
 =?iso-8859-1?Q?VtuiP1KbxqcatWLphL8rsKrV1OZkljbjfXWPh8teR8/0Vy++wWQOLqklhy?=
 =?iso-8859-1?Q?hbC9Yi4ooA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <471266D5DE5BA54FAED5AC27B2408FD6@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 954613d5-616f-4c85-5e14-08df02b5d030
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 14:33:21.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bg0cBLz0350QHQrKhG0BpeHhdvnGn0t1053n9tgq0f862D/9YKyDRyMyzq7wHSgXVuVFz9Wjip1Yz24AetnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3317

On Mon, Aug 24, 2026 at 02:43:44PM +0200, Kory Maincent wrote:
> Hello Kyle,
>=20
> Sadly, we won't present together at the next ELCE, but well, we still can
> drink a beer together. Are you going anyway?
Yep, I'll be there and look forward to it!

>=20
> On 8/20/26 16:25, Kyle Swenson wrote:
> > This RFC series intends to continue discussion around the support for
> > the LTC4266, an older PSE controller that supports powering Type 1 and
> > Type 2 PDs.
> >=20
> > This chip has four individually controllable ports, each with its own
> > detection, classification and current-limiting abilities.  The driver
> > declares the static power budgeting strategy.
> >=20
> > The LTC4266 only enforces a current limit (I_CUT and I_LIM), not a powe=
r
> > limit, so an admin power limit has to be turned into a current limit.
> > There are two problems that fall out of this I don't feel like I've got
> > a great solution to either and would welcome feedback, hence the 2nd RF=
C
> > version.
>=20
> Of course every controller is doing it on its own way ...
> I have taken a look at your driver, it would be more precise to use the
> voltage used on each ports instead of the constant LTC4266_VPORT_MIN_MV.
> I don't have the datasheet of the registers but does a read voltage retur=
n a
> value even with no PD plugged?

That, I think, is the crux of the issue- the LTC4266's port voltage is
only valid when it's powering a PD.  Otherwise, the values I've seen
measured while not powering a PD are anywhere from 0 10V and they vary
randomly. The values read aren't the typical or expected port voltages
that like the TPS2388x will show, unless the PD is powered.

> BTW I don't understand why in ltc4266_pi_set_pw_limit you are using the
> detected class for power comparison. If the user wants to set a power abo=
ve
> the current detected class, well lets allow him to do so. Also this will
> prevent any power limit set if no PD is plugged which is not good.

Well, my intent was that if a user configures a power limit on a port,
the limit we program should be within the IEEE802.3 limits for the
class- so I capped the admin set power limit to the maximum value of the
class.  However, I don't have any problem with allowing the admin to set
an arbitrary power limit on a particular port and then using that
regardless of the detect class.  That simplifies the whole "no port
voltage unless a PD is powered problem"

>=20
> > The first problem is programming the current limit from the
> > admin-specified power limit for power limits other than a specific PD
> > class.  For this, I replaced the linear regression in the first RFC wit=
h
> > the minimum port voltage for a Type 2 PSE (50V, from Table 33-11 in the
> > IEEE 802.3 spec) to convert power to current.
>=20
> See above, please use a measured voltage for more precision.

If we let the admin power limit be whatever the admin has programmed, we
don't need a port voltage until we need to write a current limit for the
power, so we could do something like use a class-default power limit for
a device and let it power up, and then adjust the current limit using the
port voltage that's now valid (because the PD is powered).

I'll think through this some more.

>  > The second problem is that when the admin does something like
> >=20
> >      ethtool --set-pse eth1 c33-pse-avail-pw-limit 10000
> >=20
> > the command fails with:
> >=20
> >      netlink error: Can't calculate the current, PSE voltage read is 0
> >      netlink error: Result not representable
> >=20
> > unless the PSE port has been enabled first, and the PSE has detected an=
d
> > classified a PD on that port.  I'm hopeful I'm just missing something I
> > can do differently in this driver, but if not I'm open to adjusting
> > things at other layers to support this.
>=20
> To have this working the pi_get_voltage should return some value even wit=
h
> no PD plugged.

Yeah, I guess my question is _what_ to return, since 0 causes the
netlink error, and returning some constant if there's no PD attached
feels like a lie.

But it sounds like the intent with pi_get_voltage is that it should
_always_ return a non-zero voltage for the port, and that voltage should
be in the 44-57V range (depending on the supply voltage for the PSE
voltage domain (which I also can't read via the LTC4266)).

>=20
> I am replying only here for now. I will take a look more deeply on your c=
ode
> when this is solved. Is it ok for you?
Yes, of course!  Thanks for your feedback already.

>=20
> Also I think your code is rather ready, so you could remove the RFC prefi=
x.
> With it, the nedev check are not triggered.

Will do, I'll repost as non-RFC when the net-next merge window opens
back up.

> Also in the 2nd patch you should add yourself in the MAINTAINERS file for
> this new driver.

Ack.

>=20
> Regards,
> --=20
> K=F6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>=20

Thanks so much!
Kyle=
