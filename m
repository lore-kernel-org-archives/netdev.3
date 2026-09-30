Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028E3B6BEB;
	Wed, 30 Sep 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748745; cv=fail; b=VmOKby0OAH4vfxdEm7osMFFLUxgOfQR0WuJVpRVHFa52BDbZ0ZcYCCT6dRuiDN0S5bHCZGA0wLYmliixf9nYhQl85zCZ2lEEpINWY/iG2cZrvIBVWKDfR5QN4FH9gl7VtUrZ5Uec3fF/nibbyy0o42X9o/LA/Z+LI/XJWc5hxVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748745; c=relaxed/simple;
	bh=T+Snx/va2yCs+a9jvJkJ6FV0+4zCt1WgCV9hXza50yY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eA0/K+f24KqX21y72JfM9AMMpXo8yGfj993z4NArWSMojeUjGLMRtdtANtH9ldC8PMAHUmG16DKto0XYviYwEH6OXOljNBx3e/ckl22XMFpzKYIlrIIG9nYrFSVrWKygdzWpHV9iuH4QyJFVdyw23uRNsjtcfDrcb15YEXLkEk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BdxqnNqJ; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BdxqnNqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pljqZb0Ih5cRcSpAG9hvT8kyhUmhLOIc1bWe4pBG3Yigj9pYIbtE0y7gaIUDw8KmOxdi2lEzfndgYwr3rH33BIQQaMUC6z5ZjpzBKMQIWQ/CiEjhroUaP5fq2+ZLagdFdVF7R/dVz9JEcF1kJM4/h90knA//1QovfMXxOmwYpNM6lT6rbCSNub5ZYelusNAT9wdOGgDK6DwNWDPRhgxBO+T4dxtdnHr/LIM7v+PUPOYUjfoexyNfRh1jZv0GKzWs8yOtMexEqcwlH7IC1ntGOQBAXm7/d5Tg/Lik4EbTnLjDiWVWDAUC29eMR6kifTkoE+E/cfL/R4zBCT+FuzTm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Snx/va2yCs+a9jvJkJ6FV0+4zCt1WgCV9hXza50yY=;
 b=pBepQfGZ2v1NGKnKGMG6WyN/7I9/h3J4UxAsNtH75dTJHVc9/tLJPsIsAX8mHC/ftAk6jlXfOGfGHNgQbBMgM62nBSfELZqi15XGdLt4smIubpyFeFUGHv6MvDmTjZMc0TgVSpBj/TT9aKUQlff50TQCGT4lNPOX1l8PbZCxZZ1CXXEYMchhQLYl7EBPfZtxIYSKHlkb4IhiZMvsvdUzNy2uzaiamOwjwDZF+SszhvKrv9i84ny2Tz3RB9nLclvpYL5325I2WCeNU4SbaG5ojvR5fgL1I+A/w83JKVcP0N6aoHryxsip2XpMs3nbrRdgwCwVwehJKSIzL4sqCtvFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Snx/va2yCs+a9jvJkJ6FV0+4zCt1WgCV9hXza50yY=;
 b=BdxqnNqJEsCCduHHazVjK0JWxs1IzbUoWOWy0XOp2GvIn0+HaTf2+B4ljAHNGfJvQfpbzeSxjHsQlWlm59dH30f7YONbN2AnxYz6JxPDBYPz49FJxcU7MH0VPgRaQZigXik/srnJl9im/BcQ+/CnQa3LSRyBGv/eUpRI5Q+sOgKQiY2pArI4tP7j2eVMQOBtRcaRmK80n2EehLBxAXDGOuKGTJrczHvHQm4NfwrsKRaKk3faJr5B0n3UMTyDkkgVPcNLSOfDTN2pTh5c0GmtET6cCRe8V4k5GHKdy3Ma3mMpA/+ANBJZCrxjcCy5Xs7CPNKAUCLQlOllBgTCG9pjiA==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by BR0PR04MB674960.eurprd04.prod.outlook.com (2603:10a6:2c8:61::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:12:18 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:12:18 +0000
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
Thread-Index: AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5AgAAWOgCAABaJ8A==
Date: Wed, 30 Sep 2026 06:12:18 +0000
Message-ID:
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
In-Reply-To: <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|BR0PR04MB674960:EE_
x-ms-office365-filtering-correlation-id: f99a2a71-eec1-4fbe-4f5c-08df1eb9c835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|18002099003|22082099003|38070700021|4143699003|4133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 rh99euAYRdu7bFeJf8t3+j7DC4JB3l8Bmg2j4F+rg2FruUeUy8l73RQnnVjftK1niAVP2ANJ5xgNq4HDE1Nr1uhv59T+RpcC09TxmZfLEguguTQAwJoqJBXgk+AuvGJDpmhBDOfF7iQnWvTzJWSD+PzKLDqdhjUqNhVkClJYXWdGHddNLel/BDW0TaUx0cOL79VTAEPXnIEsfoMYJjBxPLSd5G4f7ugTWMe1nB9rm9J17JOxIeAmTKCBSWGAN/oD2CagaysxjVmchX+WAy61HaH8sSv/6JPHIpsSNhlNcpcZWwcXV8a3qTL6JWTqcftBlLCZNF5vJuSqmhj7F+fXloSXttcDIvRq5WXWCu2Jl8L2hzNfSv0hm2iuWlCtaRLN95zuwLOYQm7blQQDY0WzcZBDe5aIsSs1/E33wmQJrpeQ24j5yQZzwrOEv9gpDOBLjtqMTUwsLgsl5FfKDv5mE96cQySo4i8X3w7Bf0QWByP3V5P2Ghen+EqnjGlTDbG9TW20SzkkuwGw7Kva9E1Ykqdmg9/W/1tuOAPHzvg+v/LeWRARy/9OEM2K4uVxGfe6+yyGwYHnN/HC5Hzept+QQZ/EPzAYcE42vboNwoavz1Q2Fc8wGSlN7jBphCN+GIAwY6AvZCz3SDGmbDG45MbSYKz5ZwsVf5b3AQG6kziALYk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(18002099003)(22082099003)(38070700021)(4143699003)(4133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aLN+nbmjRN90+auTxXr86rfGC+pIM04lo0JWivIDq7rC2yYefavzzgjGLdvf?=
 =?us-ascii?Q?6ojDccC3P+rCTr06+abgx2usnQuTKklSB7QfbG6IsQJ9l8jJuy571X1kDzfL?=
 =?us-ascii?Q?QpSedTaiyHcWlRagl4/845lAJG5lqCq/RyIUZOBcrUk7PIR/vRFycIzkYRg1?=
 =?us-ascii?Q?tcTT17AFaaSySY2TXvtwjy3SYriMSAHp2XhoHom2py+ojJGgG+2w5sd1ic4V?=
 =?us-ascii?Q?VSFyZgRRdeu9nHHjAZc61e2bdQRfn68LnUMwcJGx1xb61ydg8yMrXdhqJMfn?=
 =?us-ascii?Q?CuicPOXbjbHErdmj5c6GCi7ckTL50gbQqoaucFKJbqMO8kLXN+5ekc+PrG+L?=
 =?us-ascii?Q?kb/YZNsObqPzU8rR72kKtNm+RQe3B9XjG0l7HRA/OQoRUtRC8C0qs/2gTP5L?=
 =?us-ascii?Q?iDwDJpxVmBSLSivEm5bVilUjjN+IDTrRUi00oc/a7kR4x7lN3k+ecrHc2wr2?=
 =?us-ascii?Q?Tct8LhbGvQSZEbVBwAbM4x1SUQS7iHa4T/JgqzRnRLRIT3qnFpKT/XKX6PAq?=
 =?us-ascii?Q?qxiHSqTYjyY/GNug0ULCyWL1DSe4zkL8CjimR2THqbNeQZI4LTN9VKHAbCyw?=
 =?us-ascii?Q?aOG7djQTJ+yswdvtxEmxDnxJxg6iqu+1tZBT2L22aj2InRax8PucJJsmfxx2?=
 =?us-ascii?Q?wdMGyakv+gXTPIEgiuhFO9WPkNNpgAg+Bv4Q6gN2LK3qwh+fJT9LrFuXfezb?=
 =?us-ascii?Q?MQh8eIdsMI1p/ROSYp5+E2DAujo6QZmt1pCbtdZaHMxWuZOdOFCoQ9D289ax?=
 =?us-ascii?Q?UEXNML4iLa12qtF2W3yoe7wEmEbvr1Zd2ra4cAqSvTTDHbuGjUvh9dC3ACYP?=
 =?us-ascii?Q?on4V5Hr69PJfMzRaA3OuQYsb8ODtUfZ8mYx61NISSzHIAOk1V0Yq9sKvwcNe?=
 =?us-ascii?Q?qASBiJVZyl1mYuumK5/4fcv77acxp96v9CIpeCzbMJjTICr8exauHn5tULlX?=
 =?us-ascii?Q?Y66UZM4nKwQrUN2qX7Uh+CmTN/++LekoDErBYoDppGSPExTB7n7i220d6Ig9?=
 =?us-ascii?Q?Dk2LqI9cspi92qu1Hls8BPlCYLM65bBU+Q9RKKIhRKb4jZWXiSVdikDY8TYS?=
 =?us-ascii?Q?3emk4Y6m2Eg0w8DAm1VIs/hBJivVPmW4HEuqVuVvgp1LoUFcLAZKLvq7hS6G?=
 =?us-ascii?Q?XKRjcJXcJO505aEd01g+02FkWGjZL0+e64EdJcNaRr03oMYGrsGKUwlb+20q?=
 =?us-ascii?Q?AeGqWLouEqUhY3hZ+E2ZNH9O7eSd57CDqEpKKeCTtXvfJ6DNOohTCpIYayAF?=
 =?us-ascii?Q?1LhRNV9Hdm03xsfrHgy0cONMVFrNrd4ri/hqzlsRFU8/dSOWRxqzG4bjTupe?=
 =?us-ascii?Q?iA3dO2f7z/FGEDF0//vcGTYMvwyiDy/s67WfxbtDpPURzSBJ53X96LRLRm9z?=
 =?us-ascii?Q?g8aD1r6JOOETv6pPo4+UU1IqFu11CmGvuyl4nLxBkKdSnnmuI7YjSKjz586l?=
 =?us-ascii?Q?35nFyiUdrJ33N3UV1kORu/73G+ZyCy9tnQICRo87u2OlnQVTaVMck0JhWzJ8?=
 =?us-ascii?Q?ab8ocVXjRbSZoKNSGQvnWZfG+8rC4oUilPviuVCuEwyxMpLGsPAbk5oMJn1x?=
 =?us-ascii?Q?IPlxq17yTO1oL9CxmPyMMwmx5bR005bAESg9XTFCoTaG6TSnWWK7GjktIDmz?=
 =?us-ascii?Q?vHfRCpOIZYzWTIqtB6qKwMamh3OaQNeDYQDavsojIS+N14nYaNscGO+LzMCh?=
 =?us-ascii?Q?H8lMYA9Fk5EKkPGxEpw78r69gQz8qIR6UqsSKTSeZLB+sYOZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f99a2a71-eec1-4fbe-4f5c-08df1eb9c835
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 06:12:18.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7XEOflHh6cH/8V85E9ZSlAQvD3ZZh02C7HaftCBqsJDeYCK8GRILP2YyF/Gqch2NL+ScCJZiAHFoe8tcJqU9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB674960

> >> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
> >
> > The system clock of i.MX95 NETC is 333MHz, AFAIU, the MDC rate should
> > be
> > 333/(2*258+1) =3D 644KHz. I'm confused that why you said the rate is 55=
8KHz.
>
> That is what I observe on a scope on local MX95 board (not the EVK).

Clark helped measure the MDC rate on the 95 EVK board this morning, and the
result was 644KHz, which is consistent with the theoretical value. The scop=
e's
accuracy or other factors may be causing you to observe a rate of 558kHz. B=
ut
anyway, the description of 558kHz is indeed confusing because it does not m=
atch
the theoretical value.

>
> >> but also very compatible. However, for example NXP TJA1120 PHY needs
> >> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.
> >
> > We previously used the TJA1120-SDBR daughter card to connect to the
> > ENETC interface (RGMII) of the i.MX95 19x19 EVK board. However, we did
> > not encounter any issues with MDIO access.
>
> Most PHYs are fine with the low frequency.

Yes, but the example you gave is TJA1120, and we also connected to TJA1120
without this problem, so this is what puzzles me.

>
> > Furthermore, I did not see a minimum MDC frequency rate of 1MHz on the
> > TJA1120 datasheet. I'm not sure if this is an errata of TJA1120.
>
> The TJA1120 RM is not public, but look at its predecessor:
>
> https://www.n/
> xp.com%2Fdocs%2Fen%2Fdata-sheet%2FTJA1101B.pdf&data=3D05%7C02%7Cw
> ei.fang%40nxp.com%7C44f566383a0e4f1fbf4208df1ea9fcb7%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C639263387581887659%7CUnknow
> n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3De
> sOmbNzJ0qJ0z7CyZYHWCm5ihMjq%2BFT1AKfT6xT1RUc%3D&reserved=3D0
>
> Page 46 bottom
> Table 37. Dynamic characteristics...continued
> Tclk(MDC) MDC ... clock period ... Min 400 ns
>
> 400ns ~=3D 2.5 MHz .

Thanks, I find the similar context in TJA1120's datasheet. The max period i=
s
1000ns, so the min rate is 1MHz. It's weird that we did not see any MDIO
access issues with TJA1120. I saw a note about MDC timing: "Not measured
in production, guaranteed by design." It's possible that the minimum of 1MH=
z
is a theoretical value, and it may actually work even below 1MHz.

>
> >> As a minimum change, increase the MDC clock to 2.5 MHz which matches
> >
> > The prerequisite is that NETC system clock is 333MHz, so that you can
> > get a MDC clock rate of 2.5MHz (333/(2*66 + 1)). But unfortunately,
> > not all NETC versions have a 333MHz system clock. For example, LS1028A
> > is 400MHz, so the MDC rate will be 3MHz, which will be a problem.
> Yes, this is my concern.
>
> Are those clock which feed MDC clock available via clock framework on LS =
? If
> so, we could calculate the divider based on those clock.

No, we typically hardcode the clock frequency in the driver based on the NE=
TC
version. Another simple method is to set the divisor to 166 instead of 66, =
which
will not cause any problems for using a 400MHz NETC.

