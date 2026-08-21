Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE7303A0D;
	Fri, 21 Aug 2026 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283131; cv=fail; b=V4ptH9echKj8A1shnytTXGvBLlDx+uT2z4qLdk56jimXpZYHKlDSC+1cnVhwBNHaVwnVMuvN4fMZUkWeTz7oyAC33VXciYdRlsOw44xf2/oimiTDE6QwUY+VslKMyfk+4aFzNzWRwxi3LHgzqMY4oFJOSmZpGtppWBnYJahiwU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283131; c=relaxed/simple;
	bh=GS1UXRvUEHw2Y/hnr8xYF/+wv9yP8Hn7af7WOcFX9Vs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uc45FIiWoOWJtdg5dLAtwnUr3b0N87G63jiMrOPPWFuLIMHhlKZ0Zw74ddXMu01PYJ2yzlULBvudK4su1GvTLFAT/Vcz75ioS6+J10ohSTapwYRpdEdl7CwvcT+hBrrEW47X6kIgONon6c1g219AOTfXj3PHAylVO2aWDDNFZ4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wuoigr1X; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wuoigr1X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tilbDA/30kyU2fLHeFGRTFC/1yFXLCAKYC+Oc9O69zOoMEEQhxwqpg24urBOfXeUDIq+75/5/p5jb3DIUzQw2h8MTl7XmSyMMHy/fkjOpyR/msWJU1HkiNjFDMbZeXZPBZ8SNJww+ng9IzD/QWV8j+e8ed+sIx48EQcfzwIQ7Fo+5HFa7Zl7wIJ1sq/Q4XVGh8HTPUaCx6UV+yjbWeMgXg3ByIHdCjw0+YfKNvpkjGJmfiE4PKXvOG5+mJvw8dOkcBKDv7HWp/Pf1Xy/lz8jZ7WNUCKb+JYEjDz2Hm421SX0g14KZlvTLMoctPAl+OhmROI1o2sojXwwN80+CjxXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KBvMJN2dWM16fXTj6sO0ZWzpjyDCRt93bjujdj5fL4=;
 b=mmyS8uS0gdDmXop/l+XCUXwIFxdh1fAXbw/wTwrl9poIJ8AyCX23YoHEQpCJm4waDp2RerrWLU/5WP4IP+g9KFr9v9+0DHGAKt0QaucTIJlQrFDg+9kYGQW+dnyxANJ9lnA2xz2PY2K8mmd+YY+CChO0Jd1uEtNS49htYkJXHsGmixRGIX0Ne7RaY5zVhGFXeIT1STCGDpqDcfdxHCJCRpd4ckYFT5vA5s2HZ+iKH6CzgT+N4PiUxjIGWm53vja4Qm3fB6PtIgGQxQ853yXeESyzuLrCLqNK4OiAnG1+MRYf1i5vgpGlmnvD8qZninhi99k/8ommmMqf+17aEqL3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KBvMJN2dWM16fXTj6sO0ZWzpjyDCRt93bjujdj5fL4=;
 b=Wuoigr1X9/QK8ax2pS1igGVOdXRUfvqAl6JHApfiNdcAggKWI/r2/W+g5G4I7e4xDwlRNuV/Ov/0WIOIr6ves68ipY+VCtr5N9cSE1E4iTHXqO8kCHDm5kWjczN4KaPjtNnXVzGUkzCew74ivxpqC1M5NnMPvpTrdlpxgOL6YDOeYlxTw/qH2iCbJTYbIVn+ZTCsZtw5eze/26sEaCx8vjsgJciDOZT7xRPsg1EhIPm4aAn3wDChX3tF6DZvSa+FZq8PomLDyLGgXWggY4UcnN568ezlAuT9QdlcfIts3/WO0jM47AB4OhqTCIg5vLyptAHdUiSji3P41e32mCPsnA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB8687.eurprd04.prod.outlook.com
 (2603:10a6:102:21e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:32:06 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:32:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
CC: Simon Horman <horms@kernel.org>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Thread-Topic: [PATCH net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Thread-Index: AQHdLsHSSJyJyiLXAUK698/iUQ0RUbanG1iAgACl1sCAABuBAIAAAJrg
Date: Fri, 21 Aug 2026 03:32:06 +0000
Message-ID:
 <GV2PR04MB11739FA413E42D8ED0E7F30C688A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260818033342.3154990-1-wei.fang@oss.nxp.com>
 <20260820155615.GA265046@horms.kernel.org>
 <GV2PR04MB11739C05FD4C2D5A8B477B82D88A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <qdqufnjopqbl5yjwicf7zsmi6dbvzrq4teyj33pqhtx5naf7dw@2jc32iztcu54>
In-Reply-To: <qdqufnjopqbl5yjwicf7zsmi6dbvzrq4teyj33pqhtx5naf7dw@2jc32iztcu54>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB8687:EE_
x-ms-office365-filtering-correlation-id: 96f11475-dabd-49f7-0a51-08deff34c623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|23010399003|7416014|366016|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 eKmgJwcd1dmk5lrGarT6fdMLmuxVVV0Q/kbt4OtyD+YytIdXKPjhtBrm2zPx+pIVpuTCol13HSzk6qd1O135PYAhvvsn/HjdvxDFzZJM3wMmwRasPnaHwyy0ahJaTRGDQORmr/OtNxVQayxnlRKUlwjz9w7mqGlfuiN846rf8ehfpxYyG+LlqpEkNc3birLOKABNt/5EgCez3GZPvaGUDPDC0vSYoNF1vI+FvHeYRswniWQmOCsSZzH07sW83d6+rtI7QXFYneei0vjbsKyBROtz6HHXKxIebawKpTKqWHR6OysvtKFUxTctq/aSrh7i0ESN3Nq396CO8SjrZE6Bh6jAkt4Kvbd1dKjiGGVxvEdjPFtdy3MSi2dZKuqp4sp9rloa4UwDRoxj9k58WM5gZSICrHI9ZS5MCkfALqfpTsOsEg7l/Cocu74ntBgGAf10E0iBTE+P4+g97VKrypEb5lDvJQYLusvbv+DTuKXzC/3C+/WDkw67SREfRo/WCktxU1VO2beVApNebPurwo6CpTNIG3vILsHMBOUuw0oWAN3zXcoi9/0waVvQTsYAOcP8htLkt+hgp/EKYmaApFli+hYKzXhWNsCmFgWY474AceBPallVq5ptozsp7i6lcLKeF8ja1yIroexHbjed3xGM2RiuWPZSdb3doRnT23MmbH3Vqo8zPkRBiaFN4XYjrDxPTPFA7EAyWR6n84Zav6hR0GDPcBcSWzbtep3O6yYVDt8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(7416014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1u0I3sxg20VGPfp/g82y9+L5iFq9MMo3wQHGHHuFIzyzvuvANCHyJfwEJIPN?=
 =?us-ascii?Q?cn/u7G6yDmvO6Go/L0yviQfYAk8DmsGlPq3KF4Nx2l2D0e90LJ7yX4JTwW20?=
 =?us-ascii?Q?9I5SIKYserpXZpvjCG4mHyrZgcDc/SBso871jn8gKdtfpc7oSNGNdGr7cksH?=
 =?us-ascii?Q?HxO/oB0DpSg++BHPQJJPdwNPcuZ7LRl2aeFElKACPjHYj/4j4cN/H/EMuGqE?=
 =?us-ascii?Q?nz2A/s915KaVRmGmIOqx+nPlFlEsVJMdEeGlFBWY8d4YnGSrCfCdZu2MWxRc?=
 =?us-ascii?Q?++UkaLnInVOyzozyqIJA6Fzw7YaNro53XNFtSkOl0jGjuJKucDzmbxrSmirL?=
 =?us-ascii?Q?UocyvZwcSmUj97UQRUpn2B3x2/FTvGVk+3fKv69PQ9VAf6Ar0H6UaQFvsM02?=
 =?us-ascii?Q?hidkUaz5M+xE66o9GFBMWcemgobpfaccPRqMKnZCteh1zxa96YkzY0waY1EJ?=
 =?us-ascii?Q?AYwOO0mcYmUYyYe6LfOmTohyI9382QrjO+TY+rQozF4RxZVu7q/gnMJEWa38?=
 =?us-ascii?Q?7iyLuyBQrm+rARldR8+PrrmuMb25lxP1ZmntvyxgVwBaYzJpSoOmVqJ1JMPE?=
 =?us-ascii?Q?rdeFk8WEB5i5Iw67dqZxQty1kt49sfFr9wIoiZ/BPPTBtrTx56UqLjL5RZgv?=
 =?us-ascii?Q?SCTpRO+YYtO4fYzIgvlGS0IHkiGMAGX3g4EelrWhOImHA67WIJcJkeXKkOPE?=
 =?us-ascii?Q?tLrcAgezGW263vpamAaXPWpgEl+DNv8RFokEtemto26n8UUmcr5YELvXWC0e?=
 =?us-ascii?Q?2nZXY2xrApQTFrvBk2Tmrhy79ggxur7c9jAd4oCJ2rEVdLDtay0b27wETcS+?=
 =?us-ascii?Q?OguB6/L+pGMEFuOBQsC5ACSY39PwwBgETjmc2DNY42fbqQGC2MGw2FLSvYjW?=
 =?us-ascii?Q?KY8T/aSYdKzGQc6obTS5F//EQf9lpSe+QCQZ2JfL2QwuWflmCzYF5KYaZMoB?=
 =?us-ascii?Q?fuLP65u/Af7YbIilSUHVvgmfV0nhJpEZLZBIfFs0CTrj0aYu4MyhT0tPpgvY?=
 =?us-ascii?Q?9CNa3xUQwGJUAEeD9v2GpcmDETnF7c9P/Wn1Glw2P4hjCnzUGTjhUzrc/hRp?=
 =?us-ascii?Q?l0dw48TykPOa0qBH9T2YYuVbZ+lsgncHi5RiyxWLJG20gFwEiLygIzUE93Op?=
 =?us-ascii?Q?PY2vinVRYifo9+Ta2qQuDsp4F/BYMNjjPd0Id80EaPYDc1sfO8xNPQATz+p8?=
 =?us-ascii?Q?mCUKDCwvxFP+LraPq33c5QIzEd38mG3oYcZtVPqMO00V9nGQhngnrKR/X2ge?=
 =?us-ascii?Q?jZK783GYHRRQEV+2jPA8OW95Jh6388ZeuDv2zW/d9xYu2L/kPfEUzsd7Ri5h?=
 =?us-ascii?Q?iF/RvCDIxdfELFuq0k7kUdX1Fzu94MsT2XsqK8Hl9/OmHrd68T3Duvgppdzx?=
 =?us-ascii?Q?8hvfKGeQg4TRx+hLdRtZ54VuTfSB/ZPQdhdx38iXnf2r/arSwKT+1Wpy37H5?=
 =?us-ascii?Q?NhVasuZRYbxorY4VUUn0IH22JI+dmAUfkYHZV+8cuujJp5BgRQ7drC8sLv6m?=
 =?us-ascii?Q?0JT/EO7cLwiCl/mu1eJKM1cvCGnn0oDDGzciN5+pFknOD+JQabLTNChp+S8r?=
 =?us-ascii?Q?GoFaWcGI/2VefzuJbEczPyis6tBjp0MN8ammVK0sBjr51S+2LsVX+1VshwQP?=
 =?us-ascii?Q?+7Icxkva8eI+eQnyJgYVxI7M+PYfYxXjvwj2l70Wxb1rGf22XxM+2lW15Arx?=
 =?us-ascii?Q?feIZJtm1VRIZxHDdjZ4vIMXq7k59Or4ipxZjozWJIVBER6Xl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f11475-dabd-49f7-0a51-08deff34c623
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:32:06.0558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I18JgciPma06bx4eqPingPGruZ/mhF5qseB/GLEtGSh3znKg43Tdqiwa+LFhg+fXNkJKUvrlybpWa4NtTtc3Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8687

>=20
> On 26-08-21 01:52:37, Wei Fang wrote:
> >
> > NXP Confidential
>=20
> Which part is confidential ?

Sorry, the company's email policy has been updated, and this label needs
to be manually deleted, but I didn't notice. :(


>=20
> > > On Tue, Aug 18, 2026 at 11:33:41AM +0800, wei.fang@oss.nxp.com wrote:
> > > > From: Wei Fang <wei.fang@nxp.com>
> > > >
> > > > The max_period bound in net_timer_enable_perout() was computed as:
> > > >
> > > >   max_period =3D (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> > > >
> > > > which exceeds U32_MAX when integral_period > 0 (e.g. 0x100000002
> > > > for the default 333333333 Hz clock). A period_ns that passes this
> > > > check but exceeds U32_MAX is then silently truncated when stored
> > > > into the u32 struct netc_pp::period field.
> > > >
> > > > A truncated value of zero can reach netc_timer_set_perout_alarm(),
> > > > where the local u32 period variable would also be 0, causing a
> > > > divide-by-zero in roundup_u64(delta, period) whenever the stime <
> > > > min_time branch is taken (which always happens for a start time of =
{0, 0}).
> > > >
> > > > Additionally, netc_timer_enable_periodic_pulse() and
> > > > netc_timer_enable_fiper() both compute:
> > > >
> > > >   fiper =3D pp->period - integral_period;
> > > >
> > > > A zero pp->period results in an unsigned wraparound to 0xFFFFFFFD,
> > > > mis-programming the FIPER hardware register.
> > > >
> > > > Fix all three issues by capping max_period at
> > > > NETC_TMR_DEFAULT_FIPER (0xFFFFFFFF). This ensures that any
> > > > period_ns passing the range check fits in a u32 without
> > > > truncation, so the stored value is always valid and non-zero. The
> > > > accepted range is reduced by integral_period ns (typically only a f=
ew
> nanoseconds), which is negligible in practice.
> > > >
> > > > Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output
> > > > support")
> > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > >
> > > If so, then I think NETC_TMR_DEFAULT_FIPER can simply be used in
> > > place of max_period.
> >
> > Yes, I also considered this modification, but ultimately chose this
> > lazy approach. Since you brought it up, I will improve it in the next v=
ersion.
> > Thanks. :)
>=20
> Hopefully, not the lazy part. ;-)
