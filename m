Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D2270552;
	Wed, 14 Oct 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004600; cv=fail; b=K/KDtfu+H5coQDVSTKSgdowcJ2+Trt8U4EbxzHupFjFg6lQFLtNG+YTEtaJMakyK7whmfKztMc92VeFouwhdoq/zLfoCnynNZjedn9v/EUfZV1IVT5eae6KVG13MjHvuX4ooVxgRoU3gu5fFy7atq1wFjo9Nc7MhUz1uP8h6oiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004600; c=relaxed/simple;
	bh=MSMLttVvKbVfzAJnddFyNvnfQasJQ5d10UYVcqL4SNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXWmCizdKwHLK8WosP0ykOPMsvSUW0FfrNUFAhRqmazCvgK0q5dxyDC2bPHuFtRO4bxafEuZYT5op1N7VOf8CcoPn3Spq1hwREla3yq4tX+IQk8lGndIhCcKeqnOjNshUgxKGq0rp05UUOnWkp9NS+Cj1s28irfKNinSrFReX8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=nOH32LPU; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="nOH32LPU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxI18ed+qlg2+GYDgTtEwCzqj+3CFMrpmDFXZdYaprOWO/4RXttALH5+nc8+SDLVp278OgAo79B3PnDylbsvBcmqGqw+A9B7Oz7UQ1/9N27Dye4wbFBQbfxKjqQYz64vyHoVplDJacqusJb0Y/4GIfbbT0X35nmwMFLN+avjt4+1d9oliNRl1Jwe2Kxg8yDZVAmDs2M/ZInzGpI6tH2wgyiLTX9LAJCOYt7wVBvVc+d+Rm73JSNV57t3jjL3lwXoqdtGk9MGr/KhqJvOkBLMyu24svo1P6nHnqjNbjIK7lKeDLp1sJodN6EKXFFK3EwkqRxfHwiOJ2P/9KpfVcUQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xxcTVuD4B7f/c/wXgNbJpNlbMp1dan8keS4lsmm3Ro=;
 b=PN4YyQ28Y9aKZpC0a3Gn15qt7Ax/Z+Nzzc3f9LuK8lKLeSNo6tTcZeaAFmjo7jQz6zQFpz2DOP0ALMbyQ+TuvXY7gFpgGbYgHuMdDmif3M1WkLzGdPgJ0FqhhrxjTaa+D4m/C305AVrkukigfPXHNfATt8e3QMyDD7+Jxgpa+GUolX/A9a1woosUSHX9QO50P1JVO/2ygh6onX+nQ0sLE6NDdul8DzsmB/ABCfFFKy+xupzzn4+9L/bgy/am+8SqQcXAsZab68Fqa60etMooZo3j9NGeFF+6tKyezdafCHrUz+L/KdJENZF+sYJTkgijIyB9GwpOBmejfwZ93LUYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xxcTVuD4B7f/c/wXgNbJpNlbMp1dan8keS4lsmm3Ro=;
 b=nOH32LPUY6EnVpfwvO0Tm9mZ8X6h4OFb2204OkUExeBc5FSvrfiEMtGNso7ti/9qpiNEJ/JwAzDar9fAf26yJ86foNLYWLcLV/2cf8oruoCU7gYe6FRLN5scwzBAxDt7JtGccsbwr1My+XFSwjFzqc+CMKwxuALgWD6sQWC3G8LtrnaILcz9MGCs9zlJaxpei+aFAdOQcFa0QYZXNY1RtZ62IWp49BeXGdBKbgylcG4LvYQytaRLohoWbzuI3y9bHql20H5Tld2d57igeZznG5OsbrothJi9ujUz2nUy4pFsfciXfBJ2eNCkMbi79HVr+btbcbKgydtIb8HyTRu4Ag==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB8P189MB0602.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:12d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 19:03:15 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::744:fbdb:56c3:26f5%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 19:03:15 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Carlo Szelinsky <github@szelinsky.de>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Corey Leavitt
	<corey@leavitt.info>, Jonas Jelonek <jelonek.jonas@gmail.com>, Simon Horman
	<horms@kernel.org>, Aleksander Jan Bajkowski <olek2@wp.pl>, Mark Brown
	<broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 0/7] net: pse-pd: decouple controller lookup
 from MDIO probe
Thread-Topic: [PATCH net-next v8 0/7] net: pse-pd: decouple controller lookup
 from MDIO probe
Thread-Index: AQHdVB9p/Viv4HxJEU2jGCbh0k/Z+rb7JBGAgAAQeYCAAAhWgIACOC0A
Date: Wed, 14 Oct 2026 19:03:15 +0000
Message-ID: <as_R4vLgGT6qVolV@p620>
References: <e70bea49-c18a-4d47-9cf5-fd7b8e7675cc@bootlin.com>
 <20261013090933.3552546-1-github@szelinsky.de>
In-Reply-To: <20261013090933.3552546-1-github@szelinsky.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB8P189MB0602:EE_
x-ms-office365-filtering-correlation-id: b6382c7a-e5fd-4616-8183-08df2a25cd4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|20046099003|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 pSAb28eqBt+aPD4Q2AT1O65mlHHzBhhC/09CsSYK6M3Jr1MSQM9sTeHRNpuFl09inUc+LEPA40zM9fhzwaDZm4yw4w59C2d1R7PKFmHxsgd2xTic7kwmiUkmbcDRF06lOe1I0Q3k7mJU4lyjdClotV9rDgJUGTm1dZ1MQT/LEn1LOGgkvBVKby7Z6pSXIKxCp3z44he8UqYcMfl/R4paePtSsztOLro1KRPIVVHCodRpVpznDgNBlyPQRDIWw7R7R4iVe896Q6y4gga1MwN7hG3ZaomoGu1xrrBSjqOC2SuXf1t4cYNHznzlBkSJou7gjg0QVJfYmyAGZzpfOcUbboVISFMM7isVGa0Lc1eV8uFFyUNeptTbnUIwgolha6RRcQgNsvjhEXCunqEyMHHDu89x8aRzd0jJT7L7DP4biz+aQeF3VOE9kHiFlbcIE0vevh0LJrtcwJpC8FXMg5CIoXuFpRPAYEQ9tAJ9pa/MpzY/7YThUk2Cw4dLn3xLuVBF8i0FQpypG5Ow5O04lKE2MTEoJU5JcST/qoVy+6fGa8MBk3zGKxbotD7QLvh13XpszpqupcoRC6bFpzWETQxvy4+LT+55SbKmzoy+WNopNZ5mp05CLfroqP/Vn0Pr4FSmDA3Wl5irk/HlF7bcECq9NRIUCI5H0hRpjdiugZlyXqarsUkSh0YVWVs2QJGL2pMK051BoYncM+zTDFW9foazJM9fAv6JXGQfa8I/J4DWcBI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(20046099003)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CkV82Sj5MYRorD9Xxv0FA9ulwlMNoeCb0MYKkW/oZNChUYXWyId/g+w7Sg?=
 =?iso-8859-1?Q?EtptWv4EiZp87LSnO0ts99oSeyvKV8EmZekuaol2veR6Gi59IWhy/KYLTV?=
 =?iso-8859-1?Q?qJfDzr8MTDpBIH3VgWR3+Rr8Tm4S4p7fFLroU43IjCQ3+wylkQYgHed+d+?=
 =?iso-8859-1?Q?2JjTjUMSm1g7DKuPtu491Kq1N4faxM0Mls9PHWj0ahhHzBs9dku30hClQo?=
 =?iso-8859-1?Q?YN8e6ynj0NI/WRsxONtdPkAqYg7/314Uo7hrgOMjnkopX5lCuQovALbjbE?=
 =?iso-8859-1?Q?GmGX9XbwgcdPa5+WeyHFNpzMgZHg0QM/AtrSE2UVXmfzgGNt7TICM/q9lm?=
 =?iso-8859-1?Q?8uv9nXOizxCSr0Yax+gIfyWD7jya4o8WcGTyeCj/tWeINHEwWshOJ2pqC6?=
 =?iso-8859-1?Q?ZYnwefcF22f8AhF05DZNR3UT4c7gqusoKUv/KjfjeP4wX/nXyA3IX0Gw9m?=
 =?iso-8859-1?Q?a22UB2Nzor05wUzhSO9sSMeint3rIoBhO8L2aJWdOMT76noCcilg7nrJA4?=
 =?iso-8859-1?Q?lj2mVNkEMJy/qpfo1ZZ7EDWaa6kwTUQzez1vXEtETOD3arwx/iyYixTVoF?=
 =?iso-8859-1?Q?BFNI5P6mzsaMjEBzCm4QMs8htqvcctbjT0VmHJkm1UdaGPyRnajlNA9KXa?=
 =?iso-8859-1?Q?/kPfxS4CIPJCZ89iEcg6V1Ju7X3tf34aBl3k+x+0j5wJBbeS5LYFQJOy80?=
 =?iso-8859-1?Q?l3l0dpv50t46WwhyMbxSCRfEA010T2gjN5MUY5ZHbA9bna2hAdpfcYVUAQ?=
 =?iso-8859-1?Q?rbBWn1HE75REMK2NmlwuwPEaQNtD7RKVxT/5M1XbJhvZGyb6P+hrzmAuiT?=
 =?iso-8859-1?Q?0PocQnPKop6u5wQ4KEXO/I1ck0e++xHnwyCLBhZBZdmetyNRBQ9TiSWT5g?=
 =?iso-8859-1?Q?WFF6Z+QV188U4eGLyfRlQsqrnBQdyh5B620Cebv5vCRpO2sIyFuelXPVUR?=
 =?iso-8859-1?Q?pCTQb9rJNuM874rZ1b3jOGQG6bgsOnwsQ4zZvWyJeCvTrbO8DfaLzsBdvh?=
 =?iso-8859-1?Q?5s1ml59l3CCb5US4/OUpPOCp/A8TM3huPWJG9HsqD7LjaYEWqZuZzOopxr?=
 =?iso-8859-1?Q?BjWMfDgZOMIZv49b2ns/SowZFjPake+q8YAQVhOoiAQBXfG8DN0z7mI5aF?=
 =?iso-8859-1?Q?CA/i/KiNHy9X8fkIe3iDsnGggFGRH5vFpeTNBa/GmvLvjOFtS2lD96ZY6n?=
 =?iso-8859-1?Q?3vsluCdVn6MfYQanXwFUSfikxBnZ09arUj4AXMdCHjQgU+Be7P9s+VA3Nh?=
 =?iso-8859-1?Q?WDN8avLQmsAop8woPBZQ34ftkMvyUP1YdR8bZFdRd3wRkMB26PLe7gayOZ?=
 =?iso-8859-1?Q?CDM1AmWX5877Cwc4xJ9Uj63oMbfg9tHfO+lWdbMKCRRrP2WbLfJauGmc3s?=
 =?iso-8859-1?Q?rksFBk5d/4FkJ11rs8zrj4SaTE5Cg+Vxrb8nZxMg6aKK2PrZBQYzCtvp6j?=
 =?iso-8859-1?Q?AHC6gZlKBqFIqdEEErExxB4nDu7utT6cVyyNv7dExC8XEQrzH9grMMvL49?=
 =?iso-8859-1?Q?K5sUvV9l/3NxDIEL4xkIBAcyA/q166uw72n2IhhiSpySqvAPYLPPkoKNSq?=
 =?iso-8859-1?Q?+9fJmwgyFOectGQ18mY+KELWSW3N16rfGO2LRwQ82g0cyy6/JF0FiGAzJB?=
 =?iso-8859-1?Q?/SEuX8krUQwK0Oh2VyPKThYLNAZOFy5WczXMMfYk31W2TFnZ5fRNxflswe?=
 =?iso-8859-1?Q?Al35qPGbndVkrvce32TP6a1yxG368959sAAybBRAbLVb33M/CRqG00SsOx?=
 =?iso-8859-1?Q?JmCYc61V79HKqaA1wR/rAEaSQlwSts3EizhNuHwBFGAgK3f1+VqCnzUcHS?=
 =?iso-8859-1?Q?PUkqpocb7g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <12DD5C1BFE24FA498D5AA73F75F5908F@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6382c7a-e5fd-4616-8183-08df2a25cd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 19:03:15.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZnqe22gIRsOw61IbrSxOnYfMjDY0J9G0kUnN5AcTaIPnTidC6l4pfQj36u6nYM+DKjK1XwWp/kkqI+ujDz/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0602

Hello Carlo,

On Tue, Oct 13, 2026 at 11:09:33AM +0200, Carlo Szelinsky wrote:
> On 10/13/26 10:39, Kory Maincent wrote:
> > On 10/13/26 09:40, Paolo Abeni wrote:
> >> @Carlo: you should always reply to the AI review, even to point out
> >> previous discussion on the same point. And you should try to be more
> >> concise (even in the cover latter, should a repost be needed).
> >
> > Indeed, the cover letter should be more concise. It's hard to read like=
=20
> > that.
>=20
> Hi K=F6ry, hi Paolo,
>=20
> Thanks for the feedback. I will reply to the AI review points and make
> the cover letter shorter.
>=20
> I am already working on v9, because some of the AI findings are real.
> So if you don't mind, you may want to wait for v9 before reviewing.
>=20
> Thanks,
> Carlo
>=20

I just wanted to give some words of encouragement after having gone
through the past versions of your series and all the sashiko reviews...

I've been pulling your series off the list pretty regularly to fix
exactly the core problem you're trying to solve: that is, a pse driver
built as a module causes the netdevs associated with a PI to
EPROBE_DEFER until the module is probed.  I hit this with the LTC4266
driver I've posted, and since that platform has a cascaded DSA setup
with two switches, building the pse driver as a module resulted in no
netdevs.

Beyond just words here, if you add me to cc for your next revisions,
I'll pull it and test it locally with the LTC4266 driver I've got up on
the list.  Even if you don't, I'll look for the updated series, test it,
and then if it (still) works to solve the EPROBE_DEFER problem when the
ltc4266 is built as module, I'll offer my Tested-by tag.

Cheers, and keep it up!

Thanks,
Kyle=
