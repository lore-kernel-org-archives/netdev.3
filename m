Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B237F315;
	Fri,  4 Sep 2026 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487348; cv=fail; b=MTp7GeFkoBErUK6nUCNRufug5z+HO+SEzU4Id28pjlcTOK++d0woQwUAb1RmFjj60cX1VEvRPhtQsKwl4ZDHb0YRDXgiDLot2GEP5psE/zqTzEOV2B95Jqpi3LtDnsRWfSwE69De4EEUBtduYG2kKnE2xbUttEQkxvreqW8pjYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487348; c=relaxed/simple;
	bh=daJYG8FuCwznihAgYoWsIYNe6A5kGZSUJ2EE2UcLkrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvUU2rSIlNdky6hi3HLitOISJAaFnmwRvjzmCNmMjrsQ/SXytuF0lKBzLoe184855c2w7PNOyxSxICjgwMS773yfdXZvpwaMuvL/jsoHGQ/InHFnxk1nnXPkD4XX5Z9TMg9CoLpgVVTK0ViGx+p52GapLPYF5K6794wtNPEVZ5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P/zf8s3O; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P/zf8s3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li07JzYpNQC+l5yzbm0YfzU+Yqz4YkaGhLnDc1TzWhfLiVAc7/3m8uY7sQwQymgOkeHH4vtvJINdZrtNChN+f4iUbuOoN+4SlSYxC+NyKVWtofRkUuMYGTXqzCSSo3GZqPLWVdtW860LnD05NjDUOBjA9KSVJjVowjSujb4VPSDwCGjgjOB6O/qT4AqIRWH+PeocFzxDUipwABNTV13ixBoAgKRuNYxd5w1t/fU9Mwwq/gJWcITW6jM9xiA6C9iqu9qdzSDlPNfyk16AJFHQB/Esv5hot6V9Gea7H/ByBc+9KK47xw7mJuRXSkngaKv+cYs7swxE6wcIQCcZjGdeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daJYG8FuCwznihAgYoWsIYNe6A5kGZSUJ2EE2UcLkrY=;
 b=JaEcTN+Og4cbaQaR9h+V6iaJ1VpFcqmfOtkKyJHWYNDryFcrIVP0XBdvit+k9vRx4WgL45S2R3a26mVtgYfgPbivtdp+vQETr4rZ9mR9ikM26Bu+bRTSuiw0DO0+hciQVXAxmoW947WWL2gXR8DpiC8nmdqGSUxU9Qa9EVGXWI70hFkUfw1U/HERvPZpRQDk0DSLcIjzayTqZYvqiDZq7BwM56DH2wZCn5gnhaDvZASNMZkuHfKNfxSJLK0303PTY2cplPekzWMjwVr55Bwzwez6fVx0xVSV5uCrW/jjQuVZf+mKaMxLoJTy0DMiCzPArbwQAQMT21/NHmdEqkcMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daJYG8FuCwznihAgYoWsIYNe6A5kGZSUJ2EE2UcLkrY=;
 b=P/zf8s3OrMRwaMB0WEtq6YJ2J/Vin82800kFCq2I8LtJ+A55eP24PF4MZnY24NH3EXiheAvJptzRnQJz3SZH756BI//mQSiKsiho+Dg9Hv36LJRHL8CPnNOJ6GPXfMcfeAQ7zMM3IMHX+mbQ25Mo92awVWad2yrkNIIBB70UgJFupHD8DNZTSWLyhRMG+zye2RANP8hE6yDuTmKEC6VQcxicuFIgkWGoRN9hGWqmFh1uSAfyjykIuMrzEK9Y8a02HZhXzr/LTpedat5EEY6qo2Sy4ktaw0TbW4iXkG65FBxdl26gImxcBfnPeWKHtb/o+qlOH5t/HNY8BDeohAnGKQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB8350.eurprd04.prod.outlook.com
 (2603:10a6:102:1ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 02:02:18 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 02:02:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
Thread-Topic: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and
 ENETC v4 VF support
Thread-Index: AQHdOPfweXM7sOZf+ke0Lrbimycunra8LZ+AgAAH3UCAAU7EAIAAK3lg
Date: Fri, 4 Sep 2026 02:02:17 +0000
Message-ID:
 <GV2PR04MB1173952BF2F4BD845D5C7844888B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
	<20260902195613.1e18b44c@kernel.org>
	<GV2PR04MB11739E1618294F313E989A7ED88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <20260903162232.791e4c43@kernel.org>
In-Reply-To: <20260903162232.791e4c43@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB8350:EE_
x-ms-office365-filtering-correlation-id: 20356547-6fb9-4e2f-75fc-08df0a288c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|19092799006|376014|11063799006|22082099003|18002099003|4133799003|38070700021|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 uGbj9kN4e58w+6M5AEr6OUrXYxsDVdMvnRWRcqTN+bLjzY5xHfJH4tUMWz4sQw+sBCH1SVPAVp46z6nglmbMrJBjTSIEmn1EvJ/+rU8XrzuGdkTgIhkgg/hA20osAJwGOsChoO6gR7SFL8B4Z9RnPPfDnXQGHFFW4x1cFOQai6UfjmqLAfVXgm6wuVH8HPWPH7ryKm5gmQppr7F/sSRLpcK5ZexRd//BgXlEEeuRS7TvinGcfivJJ7cem4HDqf8GOQe5NkQTm6OCMG6+Kbzm6lh7xeZRR90nTVOAUN2gvZtTMWG/nJa0vSc762Z23EjcMEgQRsTkFMiqLs5rdlZCOkzrN+VGP5Wir/nKh71OdT6FNFicIV+WKVTVS2mXFxsk3ClUAXRhYQVkyYJe008cpeAXaKSP3ByvLvUDkSdDCt2TMNWXiuniIqIUrnCrrmHHT3qpFtUXeDmfDTfhtNHsIetFOVqivxE1UD7ZASdyt0mM0YBMmtGzArajjxAFJyrnlpnaD+/vW6/lREfU2LxVvx4ATg/IszqldbQ6F9uRz1RY6uRRGNW6ndAojOYYeGmRd8a8wMAdJ932PYYGcMoSRhVIXX0Pe+KeXKvwOmhNaaGGf7SeF7C04XLJ6XhzycBzZxLcCo2ffEgxdZq6+ki9iEY5/ikrflo3ZHiKhTCL/oQqdRXYro54nzA3+d5xt4lZw71qzeOeO3kuSpmDZykL6m6umDyhn0OcE9J1Xxy+IZM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(19092799006)(376014)(11063799006)(22082099003)(18002099003)(4133799003)(38070700021)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wyuHnzfDSaiveLt3IWX5gqe/9BLZ3+5dlVjxn0r2HUR8qwN31Emz4ExHD69t?=
 =?us-ascii?Q?Vxw3rt+wQIcLje2COZKFeP4iQqm1+PNu24IRU1tCJoCGvae/RLVEeovVay9k?=
 =?us-ascii?Q?u+HPZ+UQvqQLwa/J7XmM4VJL5mc9lLqBwrL3z6c/Bznygp+by4WbBkP4+D49?=
 =?us-ascii?Q?Bi7do4CoTT4dDDZcjeuziddqYBAHdYdARceEdcDalAN/jS0gXWgz/Ep94hd4?=
 =?us-ascii?Q?vfc+itZekpjV53Czwr4C37fJUFiLz/91ns8/3umjydKSpAF/WZucKa4nNiqN?=
 =?us-ascii?Q?b9poN4m3YJM4iMzcnuds+IR4/+T3rUfL0ghnyL1w14pCZLNlhAgrN1rdtiz1?=
 =?us-ascii?Q?YmeiZAALtPIOFHVcZlVoGwE7Ulfikc2GanEpcUJciz9zpx9hNQ5w/tX5j0qh?=
 =?us-ascii?Q?cNB8x4/KB/LNNm+gkINzRjN8WN/D2EKrxY8e70giIbuqM+NDc/si2Y5o83Si?=
 =?us-ascii?Q?HJIPZ3eXNu/vcnEfwmjb2YndmBA+bu8z+UGgfrQHDIjAmVbC1pJqMLTGIwVy?=
 =?us-ascii?Q?uw1f2GvikQqu/9MRexFjY/W24IcpDGYs3YtpXf1U3r36tRXjtyWmFB0uQkyx?=
 =?us-ascii?Q?1qnRVSE0E1voxh3kyUyfFs1eEFVqlDwiBHzi6gjR4oinDQ9cvEnh4TnYDREq?=
 =?us-ascii?Q?6ffjjoSkh/iM5AaebmruHfmjeJ7SubzHeokFvDhl5exNtlXqaYdXe+YRBYS/?=
 =?us-ascii?Q?fdP1ydGcgfuDOd7xygO25xHFQCOhqGfsa3LIa6rjRr798DUWGRSTnsu4g2EX?=
 =?us-ascii?Q?LKWEHp0EybLiBT4oa8zic79X77lrDB3Wu7BP6ouD0pFWxI0vBQCr2ihZYO2X?=
 =?us-ascii?Q?NFrM+F3vDqMg/fr8T7H5vatwx+SVpGtZfjCC/Ougd3lc7aaEeM8R86YoO3yk?=
 =?us-ascii?Q?9J7SPlf1IuJgxqbCWGEftpWZ6uKTC+sguSKm1GTBxbZ2Yyu8NEfE8IjYxcKo?=
 =?us-ascii?Q?lWFAH/uWPFb5Qc8wTDsn2CVzxPJ8flHISCYu1LQid0XzNQkDfwPuGNQBebCb?=
 =?us-ascii?Q?5M7ZyW8hPeiIpfk05kYsTPOCYN2LidLyr0jrt3cxHBbcbV64Kz3Us3Ul3X6W?=
 =?us-ascii?Q?grM93hAICue6b2Irn7zioFUNu80Este680pKeFnhltWSDSkzOzOuV2wkexDe?=
 =?us-ascii?Q?mJma53V3ERr1NmxjcZ9vZxxXLkHVJr4Ift5oYhDNucrJG1NYP60v2QJ5/FSV?=
 =?us-ascii?Q?vcBtExBMTmbLk1kU/J5TvIuKhG1LSPtttDIRoypj1BiF0slqPYfHfowL47Lf?=
 =?us-ascii?Q?wCzUbxz+ShdfTTYgcMVBK2PLZOo8yaDEaEEXZdebd8/pQmqm7gHhYHuuA6j2?=
 =?us-ascii?Q?ghwAanED+tTnup56Wmhe/eq3RMYpyerwWcUn/5iDyvDl/mECv8gTJKj/WqYU?=
 =?us-ascii?Q?rC2LxtTS0c/0pxMnKymG2GP+nVldqeErjHrunOm8KmUHTl/SHaT2Q7m39wpw?=
 =?us-ascii?Q?LvkPOJGhakw5oXNxH3bCaVE6oFW9MiKqz0W2jfENdg8y8EtZlDIguN46B5Tw?=
 =?us-ascii?Q?QB/+UuUguomBpNV8/yP2m+6s0F4MHANp/9lRuaDiW52lQNspQ7PRkbcdKS+j?=
 =?us-ascii?Q?1OblH8l9SzvaptsPZBqMGnjMzPcVo00QY0oZK1Z/9kps3lmAatEkS6FLQMaQ?=
 =?us-ascii?Q?GL5dKMlPVazg289tTU08ujKkj8AeKuMR+TnGWgLxs6wUC5SF59CtNUikA1aq?=
 =?us-ascii?Q?PXedvC73EoaZKXdiMrAFKFPpSo4uzJwakzWonksvJmXE2EOu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20356547-6fb9-4e2f-75fc-08df0a288c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 02:02:17.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtQLAKWtCGnoUaVG4l48a2o0kAqlOtiR/4lDNKGNKPl+Mh1UBTtuFXFV7zW58JTGsOI+OCNB/x5OsVeL9mnA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8350

> > > You only replied to some of the AI feedback, should we assume that
> > > feedback on patches 12/13/14 is legit and expect v4?
> >
> > I have not seen any other feedback on patches 12/13/14. Except for a
> > pre-existing issue on patch 14, but I do not think the issue needs to
> > be addressed.
> >
> > Sashiko review link:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsas=
h
> >
> iko.dev%2F%23%2Fpatchset%2F20260831025441.635045-1-wei.fang%2540oss.
> nx
> >
> p.com&data=3D05%7C02%7Cwei.fang%40nxp.com%7Cdaedc3330cdd4e7b25e70
> 8df0a12
> >
> 3c4f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63924074558397
> 7688%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> MCIsIlA
> >
> iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dp
> FJgf
> > %2FatLEXFRvgYlZaSDj03LonRvB7Xq8Ykd4eDaYU%3D&reserved=3D0
>=20
> Please TAL at:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fnetde=
v-ai
> .bots.linux.dev%2Fsashiko%2F%23%2Fpatchset%2F20260831025441.635045-7-
> wei.fang%40oss.nxp.com&data=3D05%7C02%7Cwei.fang%40nxp.com%7Cdaedc3
> 330cdd4e7b25e708df0a123c4f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C639240745583994975%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1
> hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUI
> joyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dnp8ORiHSmuEzsBU4lfjqOi9hsVW661f
> %2B7%2BSNCj1utb8%3D&reserved=3D0

I also checked netdev-ai.bots as well yesterday, but it showed "Embargoed u=
ntil
9/7/2026". I have received the review comments email today, and I will conf=
irm
them one by one. Thank you.

