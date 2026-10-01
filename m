Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADA3F871B;
	Thu,  1 Oct 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852233; cv=fail; b=nQKwIFsaOQwdj+UEQLskpYyQ1Y9aCEel+KZ+CNkkZqRqCcCGQd08lRHetYs7Vc2fiCpdVp5g3tbw1hufFcvdts8WoLv1ZO1F5BE3ub/qb9LRL570+gJUa44wIvKorWaLfeEK26R7PNCA05pJ0/mLc8qv66EFLyxuRyX/ypaU+O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852233; c=relaxed/simple;
	bh=wYH2gBX6/qdqdJWXWp12gdixaxBoG4oC4/9woOe+t2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLMv5HLhStsJ5wAZSrcI8GAWMONIMS7ZPnjJ346hCvGJR1LKv/he8jWfbVtz0HzQncY2oxxzMTNZEnCnXvd2f5eYpgqQ35+yuK6gsoMz7LuPkrz3Pc4x5vsm3RuKSx4iV+th3V6n1tQCfXQGuB7zwy/3S/rPMcvOV1tUXEv57Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CRLZmmfX; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CRLZmmfX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I48MGvbpjSV0DPgINdlwmN/O9wtz4pG9UoD0t4frUvn+LwUsBBbub8/wZxjS11sata2l3Kcktm46eSI8DMDkrMfrNt+bhk51upTWQwyD/JpKbOtmjzYV/SKzA0zV8eKja9TVblLKucrKV4waho/Fi6/eLuJe9kmPtTaMc3eZ18HMgE/E+Db2Xw6Fq7Zq/eom9OfQiHii5qpb3hOnjB72BivnQn0yD0udC/A/Hqfp2qu1RCYFaOJp94TfmtBsMaEY62d/jRWMcHIEiRJQ6PipEh6l6aoTDjMoHZMSUzKmkWmgs1ovoha3lyOgRGRY2oiA34K8i8gKC7LYIrTx2ev0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYH2gBX6/qdqdJWXWp12gdixaxBoG4oC4/9woOe+t2o=;
 b=urgHceGoSLcWRZEcbtzqgz2JFrDOkschCMh3H/xZo/+H3UO8dIuZ7MLZh3E3OaYfionfC6Nf1xm9VC1c+H+4qmHOp8xa1oDBId5XpewrRhfOGNpgspWhsFU5PbKU1Bp2d1DsN9vKK0CiOynPBqrGuwqQPB5c9GgbvzK/TX1eIsEymqFDUICpl1kMJFqrCwchBrL/rRJ4xTsxGT/S74G3GbgNRHliOEUg3U1Ab1erX1bthT2EdWmRleMynh5mSD339dbo/x4PfdptodwXfrv4trNkfOECpxfEBforgClmlz3v+l/O1jx8UCf41dTr1y1Gf3evuj+TmIsKq5Ccd7wx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYH2gBX6/qdqdJWXWp12gdixaxBoG4oC4/9woOe+t2o=;
 b=CRLZmmfXJ/o0xctF9bcLk6XqD5hq6LVcNRItXjy1v9OeSS9F4Yz+zgREGqbrsAtCOynvcqHKP9YjCQATEN4ZhOsTkL7nLcQx9j9UU16y7Onw8pquCZIP2xpQ8aivJf+CmqHB28k74irtNeeb/1IpfOy7O8gk+fnhPtrdAfU6n02lTY9V4CfqEDUF0hsHSvkXrp5teM0xLtCGJfFGOTpGX56uFnTYkXD6zvh/65ntUtQmkr8IiqxVYBqDGeQM/HCwcLiGAIVkIxI+rkCbVnNy5tEa3xB3qnAESRfywMbS/8Vzo6+GteWd8owwYWco3YpCTZ71YKShb5LbFr8i9I8CJg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 10:57:07 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 10:57:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Topic: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
Thread-Index:
 AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5AgAAWOgCAABaJ8IAAgr2AgACyLoCAABjNgIAAnAsA
Date: Thu, 1 Oct 2026 10:57:07 +0000
Message-ID:
 <AS4PR04MB9338B4278A2A5B94FA854056888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <AS4PR04MB9338E76DB4A59D70F1D6AB2F888A2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
In-Reply-To: <e7f574ab-5fcf-484a-a5bf-fc94d45b2311@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|PA4PR04MB7949:EE_
x-ms-office365-filtering-correlation-id: 27162961-ccb0-4f6f-e431-08df1faabc58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|23010399003|38070700021|4133799003|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 0OME0gEk9O85LVsqg/2SRosuv+vgDgvVVd3vCKmfe2vSyeoNmmdFQY2uHSc0ONsFHdpR9Nyhp2c1MUHB2Am7aocuAviXy9o+V/ax98lBgL4RaNpJRaagHhh9uVnCnAasuimoYoUN7J9Lkn4IjHBEJuvLu8NJ+la4HGjw4mD9Kd23Vgp7AKf+vVlBWeem6UmVnLH1bBvoxKqjb1UEFjCjQKvlTlhB0dR+54lg0d09t0qrSplFp0ToYxvQDTj3XVb7CVgtTr9UWudg5RZv6dOf5DIE0ST/JIQz4jarjtCwEihsveViRmBMMeomj0T7occIsGgH73Ro73LgDiNdiTShy6FCDyO3cfQZNKoGygc8VRpPAzHnIjvTYUhtc/RS/IJ2zoLjhscKeZ9j9zR5EtLTv0IhCiQwJPJRWoykkXfgOwO8UBcUxL7JvGjr+llOfimCqcMpFzfE63ZZ5FuuhcpWkqN5NBIpRFC82r1LKK+nDdpE+Zcx9YzK6IpRzdyErYLOVE7vvsLHj1nUFLQeOLsOI5x5K0iR2CAtwsuBBBqNg3wn7HokKGvtKIq6w6jbYZasboy87dKb9x3PewYK49yuRiyxqmEhNsMLEqAOs2SB4NVDWlVE0ltqmWdlSt519i647HgHlaNoPtwAmB1Z3sKdf5LBbXHnJ10Rm38cNXNhTxw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(23010399003)(38070700021)(4133799003)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TNMZjFEUMmKEPJZymdDICOExtUVkc4J/J2rCtrRfyZ/ywbRSqkpOGkjQvwYh?=
 =?us-ascii?Q?jxFtP13pcCSg1ecBubGwjvbdLoOHBgtzVS85+4QFR27Re26FRjeBhms+Bh8b?=
 =?us-ascii?Q?k+JwCoq2G4gK3qAwwIkQFr8NsvRZ7JWOoIfoBXRy3dIOKSTL2jk7CHMjocaY?=
 =?us-ascii?Q?vM5WwFUHHBrWpTpUNPKNg31XIZQUUkmd1KYzLvPWt8wpTWcs220rhA+Ix0BJ?=
 =?us-ascii?Q?vuKArwIeX3jISpuDmQerzxNH/te5E42VOmFbQJluHf/ZS/kBVALNlK2YB2kU?=
 =?us-ascii?Q?QN6IzQ/fnIvNFY7bHOb+PfMpI6LsqeMuwK/chVuJnclb3rm71VAsGw5RAgM3?=
 =?us-ascii?Q?8lCcVcnyjKtPhRmF4DxygT4iBDrpYTRgIIhtW/UCx9J5ByWdGRHRVo3jb4Da?=
 =?us-ascii?Q?ppKknuLXyBPEimlC6/Q4VU5FzuSiaqt7siQDIue979VbnZMKw8JtwSCm1p9Q?=
 =?us-ascii?Q?165fiGuOgoYl6c1P2OFVySjJeeAp84Jb77EELpEcBKsAGz7tiCXUP41/nzXJ?=
 =?us-ascii?Q?5KeDf1gER3cWW0GVd5dagw7IPuOSsJC4FBQ3kNWOXeMm776SpmuoZu2+iksf?=
 =?us-ascii?Q?97yM/fF5HP/IgkqvnMF2c1hunYRf9jjg9KRBbIN+daqHemF3olRH9yS/vGhB?=
 =?us-ascii?Q?9rFXYknm1DWna+NepQ+zl0ZIOqHEfWiqQJDlb5kkpZhPdKb0YF1b0F2HQhyx?=
 =?us-ascii?Q?/Wp4I0UxKowpxHEnSSU0+2iU8bOfyFCLwYK77MsfLpcR8Sc0gTWxDX4ACTaA?=
 =?us-ascii?Q?vAbDCf93ZRLeeOFynvQQNfJA8Y+vIwZQXZgwo/N5LY7l2bwweS4wIBdOGS5+?=
 =?us-ascii?Q?ahrYslj++us8EEWYGg7oxMlO8iD4OgPpH9dQ2k3uFf0Lart9ZJRkIfOasTaC?=
 =?us-ascii?Q?OhzeWrbBOZkAzBYKDjCuX3xYloKpjyuJdRv2fFsBID1bZ2lt9rzykrMsjCGI?=
 =?us-ascii?Q?2z9x3pyrs2pSR/eEibutrjSV1eJ+UhQlXCR+Ajd7ucSo9fOt4MLhSsg4hEWc?=
 =?us-ascii?Q?iFoyxC4YFZEl7Ai7Plcb/Lo+QcfO8fIO29cIPtHIAqc4OXMUigquOLHvmob3?=
 =?us-ascii?Q?ddNox1q2/WzwRv+OVzzAZ9sbTMjJUfKvioT92XNmj6RYOmda9btGU3IOSwzH?=
 =?us-ascii?Q?tZh5MU+2icxSp5kQb3FUgRLO88/61r0LlfM2JHKvP3p5FY+4e8qgqcM4C89m?=
 =?us-ascii?Q?yEPexMldHpwxD7eC/E/mc9N2w67ePJVaMA13Ykf7gDlvYMQM2BAUg660Iqmb?=
 =?us-ascii?Q?f5E5WUAWJZjfNCWV6cOzfJtK03xqnjtvEj83mn5DJ101NET5ZsH7vg5ZgHMv?=
 =?us-ascii?Q?fjD2qLPPw4uERWY1L226Tz3BtmC3ZuaOFH8cYE+m8Gy4OVjixmjhs2+xhj7r?=
 =?us-ascii?Q?AhDZ9eGG19E76Wjz5Pf+8LmHUKE6sbFmj6gpTN8DWFcokXjEqChXuD8C6GBJ?=
 =?us-ascii?Q?u8BSIZ9lYCLqsptzln0IrD21XC3BDJiSeuVgGpHKLEwiBe5HbTh2YkkE4jbq?=
 =?us-ascii?Q?mCUoBTNujvvwjXKh0srHPttWEzqmS97XkebMB0tf4ppb++Z+8olxG56LLuC2?=
 =?us-ascii?Q?W0lJqfTu8tE9y7lXb9Rhhs5dTqLUbGoChuwyaVb/sgzjYdNYzXLJBM7Kq1u/?=
 =?us-ascii?Q?O0sHSUwin1EI81PdNMF6qtWbRRF5ID+jQFj6pj1OlDnH3AztQujG4kCZ5YNC?=
 =?us-ascii?Q?k6kQXpvfKeagkK9dtZdJdvsQsqfbet9C/uKcv/D8cXr8dzNn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27162961-ccb0-4f6f-e431-08df1faabc58
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 10:57:07.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPZHqKS7TS3zcxFJVdynTn7RY7LX/gx8l1IQ0yYIPAj2tMbEOG1XmH5ot5tzDKoGb555ERmnVTXPdXKnUZghng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949

> >> Hmmmm, are those clock available on MX95 ? Maybe we can do some sort
> of
> >> fallback -- assume 166 MHz clock on LS, and obtain the clock and clock
> >> rate via clock framework on MX95 ?
> >
> > The MDC clock is derived from the NETC system clock. For iMX platforms,=
 the
> > system clock is controlled by system manager (M33 core), Linux cannot
> > configure it.
>
> That is probably still fine, as long as the clock are available via SCMI
> and their clock frequency can be read (not written/set), we can use them.

Yes, SCMI can read the clock frequency. However, because some platforms
have a divisor between the clock source and NETC, we also need special
handling in DTS - for example, a fixed-factor-clock. In addition, some
platforms do not expose a clock provider at all (e.g. LS1028A, and likely
S32N7), so they would require adding a fixed-clock in DTS.

All of these extra DTS modifications exist solely to obtain the clock
frequency - yet for a given NETC version, that frequency is effectively
a constant. Whether we put it in a fixed-clock/fixed-factor-clock in DTS
or in the driver, we are hard-coding the same constant; the only
difference is where it lives.

For these reasons, I believe hard-coding the per-version frequency
in the driver is the simpler and more efficient approach, rather than
introducing this extra DTS complexity just to read a constant.

>
> > Moreover, the actual situation is a bit complicated. For iMX95, the
> > system clock source provided by the SoC to NETC is IMX95_CLK_ENET, whic=
h
> is
> > 666MHz. There is a 1/2 divisor in NETCMIX, so the clock input to NETC i=
s
> 333MHz.
> > Therefore, to obtain the actual system clock from the clock framework, =
we
> need
> > to add a fixed-factor clock to the DTS as the NETC's system clock. Some
> platforms
> > do not have this divisor. So we do not add the system clock to the
> binding-doc of
> > both emdio and enetc.
>
> This is something which can still be handled by a compatible string match=
.
>
> > In addition, the NETC is also used on S32 platforms, that might be anot=
her
> story
> > altogether.
> >
> > Therefore, hardcoding the clock frequency according to the NETC revisio=
n in
> > the driver is a simple and quick method, just like we did in the enetc =
driver.
> >
> https://elixir.bo/
> otlin.com%2Flinux%2Fv7.3-rc5%2Fsource%2Fdrivers%2Fnet%2Fethernet%2Ffr
> eescale%2Fenetc%2Fenetc.c%23L3770&data=3D05%7C02%7Cwei.fang%40nxp.c
> om%7C5cf4fb9826954a20a0bf08df1f5c1ab2%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C639264152594829487%7CUnknown%7CTWFpbGZs
> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk
> FOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DC8sTNGPtiqsUqz
> 1eXYif8deaG1R1e%2BEjcpzGHnkR16k%3D&reserved=3D0
>
> Let me try something better, give me a day or two.

Okay, but please consider Andrew's suggestion. Add clock-frequency
support for greater flexibility in adapting to different situations,
instead of fixing the MDC clock to 2.5MHz.

BTW, I'm currently OOO until next Thursday, so I won't be able to
reply to emails during that time. Sorry.

>
> Jakub, do you want a revert of this one, fix, or follow up patch ?
