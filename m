Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010060.outbound.protection.outlook.com [52.101.228.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C329E116;
	Tue, 18 Aug 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058122; cv=fail; b=bqYujdEaj2rHf5aah1RkbPxuqUG+AIOiat5PQrxUtcVv3WKjPKnXxML5woUHC95XMcuIQYzyh5ygeYGfvVHFxOHeICZ29g4NbPaymsXQ8gSFs5ZT5gwbKktUGpKomgyrpU+O7yM1UwHnUKDRCE8nLWgfUzs6povLLpiOqbIgomY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058122; c=relaxed/simple;
	bh=ZFQPeYwf+UDM+0Rq/c4rHRbJrJ8l/O6iEixumoooWW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LRG4KWTRhJQVv79Ksuyv1i1LcnRKhYbe4lWe6ZQLcxgreyGrO0btB8uWb0/+KC7T4X0uaRL4wIpbCnul+B98JnOJO2ronCFRz4fq0BbbhK5QhQobsWpy+mrDiN8ACruoJ7hbTnu7POXi+jID79hTw0wr2JZi/SqU/nilFEB9OxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ctABu90Q; arc=fail smtp.client-ip=52.101.228.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ctABu90Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh95tt3Sbb9seXm+qWiu8f0Nmn9lHE5qKgVjTqeWPwm6jB21PKn8hXLylfjrcoz9DLuLXkK5ZlhgaVlnvs/rC6inxeRTbB8r5kZI61muF7EUVfrYTdkhPxhUbowaVk09DtIidIoW3tJA/a89tc2F5z+b3z95o2YBK9udmnUqBwv9Wy2RBWKCyy40m/Dx8NJvGx4Xr3TGuCJk/riS0NHd324TJVCA3wEdf1/wCJrLAz2RIaaS3hDe6lr/FNDXar5EgIfWKj8qW+spfPAowyC44oPEX/1fe8lVMcBRYk00fn/RnI/mUA4aNiVqq281Zh4I1kdL1Gs+6KTSuKRq+G1AuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXZZHFJ62TC3wODXfFfKvFzZM3uqw9TusN/34ZkprAw=;
 b=M+5g7xt2DTvdOanH83o74gvBmoheW+7vfNLv+jFs69wxNJATTIFmH9iyK4kq4SJ7dKdTCLkABjxcZRRlbznr3M3+8pPq6NEyDW/KeTsIiMIdMXDxMpG5dqXnz/AOD1tfohERbhsyP145vm563SeNuxLzNdX8vaLQ/cCisW217vU0Wktu4Op0gSpcSYxjw9ZU8c8M0sP2IPNTQ4ReJ6Y2QCJRydUopCgYkJ/8fBa2dlDI3kEjNQsN1duZeiYftMge6x2Ojar4g1proviADVz71lXt43Ol4EgsIqp+gsyxh9QMtBHcInrsLQDgA2pIt1HDcpIZY25QCbqFDE2dpielbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXZZHFJ62TC3wODXfFfKvFzZM3uqw9TusN/34ZkprAw=;
 b=ctABu90QgO0BBACjLYcVVDSvc0UpfRKV/mjOxnvnLtRMh+RtKrQRIYmyi/IKF3UOgpVKzmwZo8+bYeYb8ih9qy7UyY7ZuWujkBx8kpN50tyv3XgXfh7cwKOQoze+U6Q14c1PARL88cbHra0yEEt8iCq5tnvc+g/p+JGiiUUHrO8=
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com (2603:1096:405:20d::9)
 by TYCPR01MB7918.jpnprd01.prod.outlook.com (2603:1096:400:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:01:55 +0000
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a]) by TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a%5]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:01:55 +0000
From: Michael Dege <michael.dege@renesas.com>
To: Jiawen Liu <1298662399@qq.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
Thread-Topic: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
Thread-Index: AQHdLw/klMbufTkiHUeLoAQZflLH/7ajxQhw
Date: Tue, 18 Aug 2026 13:01:54 +0000
Message-ID:
 <TY4PR01MB142827F5B7F90EB74FE33CB8382A62@TY4PR01MB14282.jpnprd01.prod.outlook.com>
References: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>
In-Reply-To: <tencent_2EBD0396FF7A54CAD61F16E942D2E8FA3A0A@qq.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14282:EE_|TYCPR01MB7918:EE_
x-ms-office365-filtering-correlation-id: fd330b30-1a81-4ce7-b573-08defd28e126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|11063799006|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 UfSE9akKLxWBkpzsjXu9v37tZEe8zmY32NsT/AxNRRimyqnyK1iD0TFcebrzOnmxSp9/0Elbia1KPpP90uOjjlLbqwpaXI0jau5LVJwuFB/ZwYQBoHkQFTGqRXzhO1iT+NbNMhCei+z5BSc93AorjpRalfZDEBn07IsTa7iBN3yfPFYfyZXvgmhUUU35rFqACG23oPYdEknV7N4aAUcGOyMsG7dOkU6bskBNND15hwUZIHC/114NVUeeZNQdXzAcul5i8L2PQrCnVJup16+yYTSfCSN5V4V5TdQkzWGgPuuqyipTJ9UTwPAO5Rbr11pvmvpI6qbT3Rslr8njPOc7tSxR6GGZK3YlHBuDPo92SJz/r1voS7t+8xozTlmC4Il7yZZUu9YEe/uCyxe5GHRJ7m8f7r6ad4dcWPlrgBEFC0FyEgFMH65wSavHz4YE/Jn1QCIo8RsfMU/xhg2U8mY80cLnI9HC4Wc/avItGaOGgHOYc3Kc32MfJTgnaflhG3wCg22GDnEjV1q9vaFmtyXpFMxixuJJwNGduuwYyxTGlXLit6VDK1hTDsVnmgjJmzfLM1Xiu10/Ic4ETgAx5DRKM1yUAARInB6SXlwnnfQaLw2BKE1LQ3UWMCC52FkwpQ6rHvEohYJvT/PZAOTxgQ+85RGwgVUzShwOY3Tc1iptebWH8lR0Hkcq36vVKXy4fCbzsuB/R69C9yGUvqgozKVcYQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14282.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c3p0aXvZ7peYyg3qBvWa7ENhCTTdnLiNIUylvAYsnNXTeu3Jtko5ooVfBBPy?=
 =?us-ascii?Q?sfnJA1GWcsoKGUGxp4cpJMtkTSEYmfWqdREroqCB4ZlfC0W56cecZ0jOg5Fk?=
 =?us-ascii?Q?gz/AHxFkGHgu6Lll8reSl5I5Vdr7+m0nNE9cLlgoJJXf8Iw1vkWo7Sqdyw2E?=
 =?us-ascii?Q?RNAKnxAUxSz7QsDRNIOmMbDjbhTUMjs4iiJoBOOlZRkPvATnrCFWwPh8BZNa?=
 =?us-ascii?Q?DsXJj5eJIgqfsZjqcDiCO9elTHb5A+x/gmwrpCdfcXkJQU5kRArjJ12iPy9x?=
 =?us-ascii?Q?g9jbjIDp2mcKUmxGM6/NRHcxaed/pFLjD98oXYWp7CgfSoH6XDSBHUvcfv3P?=
 =?us-ascii?Q?3AMs61oCw0XziyCRKn5OhU79Nt4eoKqs1jM8JgB7LYLLl4biKHh2MuY1OKWP?=
 =?us-ascii?Q?UV/7kBmk1Up2Utm3se6JWxbAdtmOmZjU07ycUZjTo+rQ43V8zvKUDPZRxPTG?=
 =?us-ascii?Q?KA7LOM6ZJFEsQHU8F9pXlhrU/jxoxuTRv6kdMrir6U8e2narNiqOHye2xJ6r?=
 =?us-ascii?Q?YbZOFwYDYyGxqWDitez9egpArnQIa5vv9H7TFHT/HBlcFMiNP3sAQyJ2Gu5s?=
 =?us-ascii?Q?jqASX1KQ7FgIACtDJ7clXxGw+hCUQvxz69pyO0iinhsOufmrFbKjRuUs7ccW?=
 =?us-ascii?Q?ABRh3PfEutVHvSJDkQFUSfEEpekuCQQW49hF98FvZrtDCwTDoXuNJWWczXbo?=
 =?us-ascii?Q?IomxjFl888Jk7zFzAwlV77fQs1bHfr1X+IfULIqXZDEbiMa3Hf3sjn5P9lx6?=
 =?us-ascii?Q?6gObqa+CRA7qn4+fa9b27mo6VURUgjX0WrIs4zgt/2ncF0BiGmxERBIgpkvj?=
 =?us-ascii?Q?qj3l4//iSFYWnMUacJlqRrkMkLI+rpfxi5FBaqW+3Jwj/Ynsm0vjOuHYZwcA?=
 =?us-ascii?Q?PgLIdVpEBqoMKjvnIXa30jDgMbLSM7OUuzYIEST3dGsTgFvvJSiRzRrasfnp?=
 =?us-ascii?Q?LNdLiJJx1xP/0ZmsXn98nS3cnzVxkHQLBopZ1sDOGxUA6Vj2+1YRAVme01u4?=
 =?us-ascii?Q?vw4oGmL0q1MYHuVryY8YbDQJhVojw8fptBhCGN5uZSHsc9wKxJo/fxSlHSs8?=
 =?us-ascii?Q?NQUu/45PGqa24cF7xhX6+B+Aut6s4WJvobKI5Uyd37UFnVoCu32OAAkSqPes?=
 =?us-ascii?Q?Y1oxmlkN/uv4OqHsCTfkOZX+kEkHIglJFcndlKltSTC3HsyqHPL5zGJzN9Ov?=
 =?us-ascii?Q?qoz5pis3mSCsttLc1sEGsQNmBnOAVO3l1AuFkMB9HBxogYsq9QVYxxbCyWay?=
 =?us-ascii?Q?ccG0p90jb06NqKhV4Ds5q4Gx+axVdLGr7DzDBLlhiMLx9oyftETIMuGiMSI3?=
 =?us-ascii?Q?DMyvCQMYh5XEe5r/3jcdZgarfsuzcibH/+i8aETEFkpVBzyK+oo6tDBfosxj?=
 =?us-ascii?Q?kUjGhbehaAeTTn3L8zH/U7SsSLyPzcNTbdN0iqW/nwUAT8lQxvb7B+XRREcu?=
 =?us-ascii?Q?LKqLfGgw9rwVGFIMj+p88CrVnO4Giq97pWEKKx+V2U03ZFjhzYqqUdUzcpeC?=
 =?us-ascii?Q?SOQu51aCqjddAheSiBwV11TCUznT39l3f9505uFygyKFD0OKOSsSR8oPViDq?=
 =?us-ascii?Q?iEBnXXaOnsx0wIZWes2uDxPCvJYXARZNNu8nbcOS1PqM/odz1ROdVT/jh11a?=
 =?us-ascii?Q?uC8g7PoAGz5W2jonuMCAb59xXrUeJt00XFcBORp2nC/6AsllfhGT7zUhlHUg?=
 =?us-ascii?Q?/M9zj8rjeOZxA82DG38Ms4uUosx5f6iIO2HyzqPAJz2fQkkCnBjrETWh/JVF?=
 =?us-ascii?Q?z7AqF6R6ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14282.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd330b30-1a81-4ce7-b573-08defd28e126
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 13:01:55.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8f+txYsPwPTqV8dIliiUWvs4eyB+xz6p4NnOsIx29H4QkopxeS0K3Hg1vyWmsjE7nufWAmAQLFNS6C1DzIZyMOrt+FUt1ucgd13tt1CQDa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7918

Hi Jiawen,

Thank you for your patch.

> -----Original Message-----
> From: Jiawen Liu <1298662399@qq.com>
> Sent: Tuesday, August 18, 2026 2:42 PM
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft=
.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pab=
eni@redhat.com>;
> netdev@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-kernel@v=
ger.kernel.org
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>; jiawen <1298662=
399@qq.com>
> Subject: [PATCH] net: renesas: rswitch-main: fix runtime PM cleanup
>=20
> [You don't often get email from 1298662399@qq.com. Learn why this is impo=
rtant at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: jiawen <1298662399@qq.com>
>=20
> Update renesas_eth_sw_probe() for the confirmed driver lifecycle defect.
>=20
> Keep the change limited to the concrete operation shown in the final patc=
h.
>=20
> Signed-off-by: jiawen <1298662399@qq.com>

Reviewed-by: Michael Dege <Michael.dege@renesas.com >

> ---
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/et=
hernet/renesas/rswitch_main.c
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -2123,6 +2123,8 @@
>         { /* Sentinel */ }
>  };
>=20
> +static void rswitch_deinit(struct rswitch_private *priv);
> +
>  static int renesas_eth_sw_probe(struct platform_device *pdev)  {
>         const struct soc_device_attribute *attr; @@ -2194,6 +2196,9 @@
>         ret =3D rswitch_register_notifiers();
>         if (ret) {
>                 dev_err(&pdev->dev, "could not register notifiers\n");
> +               rswitch_deinit(priv);
> +               pm_runtime_put(&pdev->dev);
> +               pm_runtime_disable(&pdev->dev);
>                 return ret;
>         }
>=20
>=20

