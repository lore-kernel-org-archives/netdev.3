Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010001.outbound.protection.outlook.com [52.101.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDD3B42D0;
	Thu, 13 Aug 2026 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625119; cv=fail; b=PHTWvoNFtAKz1rblLfv9wmt69o6Rw5/f6n2dXVywFWkYQIh5fyGHceXeNo4ttwT2Z3xHkids1hCeY+aWdGtM8Vvx/Hd5zY8OMVTmmcwmxrdpwS2aUM5sMfIkUtS5hflAbVr9ZrdcqZekyWVVYrt2TyCxrbe041MykFz0dpPBLnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625119; c=relaxed/simple;
	bh=ITJtd1zMxApXO+2q6IgATxRA0VaylOjr1993JWxgm/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPOnOoMRwkRYvXUDBOJeQCMhGmxlsQkx+Wy7Yg9yJBsvQ/Lnv1H9dMOaUJavAkc9Mukl+gTKNHxrZ2Ws24KzlpwAFGGUWRU8I2JHmo6k3WpYvUIJzDnH5k/TXRcY/fMeWRX+gbrQFRd8ALsNUK8X5TmKoVqKR83sayP+GsnZy3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=oFhN495w; arc=fail smtp.client-ip=52.101.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="oFhN495w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCTPEf4DyGXo4TZINyMagMNNufoKNvb5Pxl1kvpF06Tp8RMTg38vR93CUpx9A+0zm3K0N7m4MsMdySDonGGX80Mz2qCpQwe1zjuSdxYPW+dISufO5GkgZEnp3F+tBz/5zc9/VljEl2b5nzPTG/VO8kBVlVnZ9fp6PabObcpM61dYebIgtdhulaw3x+ADbwmWedHh7MMiKOEBTIBHxcdnLzv0Dl5wHrl+STQejOLFrsUpGOE9g03Q9P9M3Ahw+jn+n5cpyb03HI8f7VZMLzpRbJG44mq8r6+I1mqWlwqyHEQ4zIPcKETXuEHz+q6icIZoie+5KeGq8TM3IALG8tg6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xz5Q4fsFA6j8ky/0YPusYCg3Ae+QP4QdIjOhcHWPMg=;
 b=rBngcT4yZ9EgYSyYWmXOWVCagCJ+/58L64UAqq+5U3s0/yJNmkCvREon0x0ZORvXgZ3a/gr+Ov1RbLmS1ECcm0c3+lt7E5+hBhnzZdqE73ay3JqixUr6CwKZvRq+GwmVimHiENHW8Mnwyy1mZB4qHiZxx6rx5ERtCLTS9mqAYVx411hcM3tRHQ997RijyeEwjjSWv1gUKiUDSyHMBO73oSYiiYex6B6yFPjkrb9QWbNItEFO8jYgvNL5zT8DF+GGv5KRJAmsXYJHmz3JtLeUD+qf0v1hI0kaWx/4TEzle9++7UsjcAsFAB3cor8lH30/uPizJxNshrDmXjqhDY7YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xz5Q4fsFA6j8ky/0YPusYCg3Ae+QP4QdIjOhcHWPMg=;
 b=oFhN495wDFjHTV6w23UrQM7gYrjFXFwfzRsHpWBJuDZDqjFYLrfWI6zyzyuxjP9u9lJWx0JefAdxX2xvrho4X9SsG1NaCBF+GgkgOL0dOe9AWAzvu70rAdPIh24/k6uyMOzmYUIIYxgz9aQfTHipiE0IJho6WrC4nk1hQ6mRkPg=
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com (2603:1096:405:20d::9)
 by TY7PR01MB14890.jpnprd01.prod.outlook.com (2603:1096:405:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 12:45:12 +0000
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a]) by TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:45:12 +0000
From: Michael Dege <michael.dege@renesas.com>
To: Manush Prajwal <manushprajwal555@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: renesas: rswitch: fix device_node refcount
 leak in rswitch_get_port_node()
Thread-Topic: [PATCH] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Thread-Index: AQHdKxVXWzFzcTFezkGi0WwAiSN8jbab7DKA
Date: Thu, 13 Aug 2026 12:45:12 +0000
Message-ID:
 <TY4PR01MB14282B3217D649F712BAD67BB82DB2@TY4PR01MB14282.jpnprd01.prod.outlook.com>
References: <20260813111121.1672-1-manushprajwal555@gmail.com>
In-Reply-To: <20260813111121.1672-1-manushprajwal555@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14282:EE_|TY7PR01MB14890:EE_
x-ms-office365-filtering-correlation-id: 66dcf9f1-ce32-4607-144e-08def938b788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 /ZXPDW+Pbm0d6nZDUngbVJCvhuB8+lZXSBHKFHCZBVn6IRC6sEb9VaGSN5ipJGr/3cEBY3xskPoMMbxvjS3PA1jHgXrEdQZcrXC37FecHX+81bjqtNS5+OhN3y6/au25YBlurzATMyMNwtn/uYw7EPvTQhWV6dK5FIXtFMLZ4LmVlOZWGJvNfXrKQp6a4GDkawp57naacuLy8trCMOVAaXFZwcTL+6E3zWUN9T1pjbKDS8gNqECwtWLIUQ2r6fG6HXwX8vsXHP8Si1fB2bShhy21/pGqXrUheMRFEGL3GAUYjdK0S/x6tYwCbCWK39h0uGycTFlQunyKusOPNNCfapoJFp8zZGPOyjZFfR/NBcfROcEkCBFYaOXAlfV46rgnb9ylAm3eiSXY7kKaQWyTBsHekNxiCC1UNRddZZ/J14I202JnQOX0po8BL5l5YLPIeo6k82/mP3TnveuiwfWahPB+V7fncDmACOJviO3S91pcs5dEzkD9rq02qaUsaPkXahrpk1/vxmHnNk5mMZMSEKNADRpU2Bo8Z3xfWLhQKGR0TVXtHISB8kzr1BAHQIeu68J8AY7+xmgnatCzHUjNRBfEdvJIeXfiZqXFF3Te7yw/gnkUSdGGe7nIWNCBa73686VGtD+xM24FoLFcLI3tFuP5U+Um20W1W/xDSYKbppLvRLLOlcjAL9x1psbh9xei+DAZAeMDN38mvn1UzQim4w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14282.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Udk5hjslNQdBXxj9rfA4LAgs1jcLsOW3N10Uy6AVhoen+9YhFVeTsFycvIFM?=
 =?us-ascii?Q?lD+EyAi2IuiED7KdeoaSuaUdjNcnt3qPjKCrW4DbcldTuxoGD4FH68LdtAbA?=
 =?us-ascii?Q?IuhsAS5dr8ZlCCd0YbCNnnL1hgJ2ZDJNESiLJ0aIJ3fNuoRzltCdlwZXWqsS?=
 =?us-ascii?Q?q+wtXaJbNQngFlj/fQ/J1/8FleMIWCcK0G/zFARDAEIQXRf74GLVwzOnjItZ?=
 =?us-ascii?Q?QdjKjgZGKGeNqcbhvv/yBJfCacytt/qYzqUWM8dtm8MLiG0pnBLRK55S/N+R?=
 =?us-ascii?Q?tt07m/dbbnGFxGwzkDdx9zIe1BX4+g+AbY0Zwm2eru277s7wAGBAy5nlvpHS?=
 =?us-ascii?Q?rNx34aZFbkNwJVtWQBwzJbslWeZ8IOsKdBCWYlJ9Wb0habasl/aQy+Gv1Qt+?=
 =?us-ascii?Q?4yJFHDLZdc0fJ6jSZ3/WZuoqF2DTM5iQsKiTdDe65ck+osnzdEj06czz3jFD?=
 =?us-ascii?Q?r00j1f+qgHbvnrDsOGfZnv1GpSswL4wSK8hPQjiY8XCzNI06KgZDol4MXygr?=
 =?us-ascii?Q?0yADw/dDvglEd9qnTx5rqeN4uo3vHPh9/dmkyBb6eDZpMAKPwpMogFCinlSw?=
 =?us-ascii?Q?/O/PGOn7vQh2q/mSxaMLP+Ch5d7+JV2YtK/e3/wV1IAVLE6s80oAsIrNN60N?=
 =?us-ascii?Q?Zg3pF16Bo2hLuixlnjKYz7pcsd6uABdvWAkcAlJyY8hVsja54dWrcrZVZUWx?=
 =?us-ascii?Q?rH2mzO1WO9k4Kl05SdRZCGyAoqSpNlLxsvZ6UfI/RUDr2kJ/50Jmm1UZgxLG?=
 =?us-ascii?Q?LBjBTLkEquKIgrp2GM2+sJTWThKPNuJRU3E5VoqLrXX73hyAnNSc/J7qV5Vp?=
 =?us-ascii?Q?jRvUWp4cwAweJrqmvVQ3ux0wPocX29UwrDNXttMy9MpykdDM2QZPCJsuhti2?=
 =?us-ascii?Q?vi1IX2kx5ZfOYyRvd0drPbZNvHraz6GisksXNmSgBBPakbH4ksU3buWGIXd6?=
 =?us-ascii?Q?l1wikvWpUDrIS7i8OFMrzJZWM+bODD9uqo0E+J+8+Cb1WvOhoT4+kI2T/ZLT?=
 =?us-ascii?Q?XINE+rBFLNlJRCxxuP+tKfIhepRiApYB2Ml029KW//NeJh/WPNKaYb5esb+T?=
 =?us-ascii?Q?tCW80Mg2o02mGylrf9XDkIB8VIoSrk4JZlVLnJg7IWDd/3QwX7TxkFND8v1H?=
 =?us-ascii?Q?Eg5CwGUGn7C8boQsGd9KlrcY8FjWEstTlm1BnoyKeVbGVxckNJai3UD4erPZ?=
 =?us-ascii?Q?ml3eC/QNo34TyekR6bD+q2II+05a69/nEHiCkXFZKzyT2ys4uoKumwc+0uJn?=
 =?us-ascii?Q?T4SYuZTHWV1Jd1OwJg5+YrckKWzjC1vmRyXsJNi4ywOmersNZgNTErq0M4kx?=
 =?us-ascii?Q?Io/WtD0f2RgLdKU1IdyRS9HAu8T9QmgS25nOnSU/OqPOgfH1IXM10GTyfKOF?=
 =?us-ascii?Q?NBIrfT2yLSzzQ1J/U7iMjZVvYQt+H+2f8UCksneYArpmrU2CRgNfLNs+DQqY?=
 =?us-ascii?Q?QVEcfQabo8W3oLo6vnPV5cYi65fWKwbbP9DEz7GH/OVw+wN8Ayy3tLpc3jcN?=
 =?us-ascii?Q?NkUm5YHf7i5XAB58lXOKNIBT0E3Tt+yZBgwg348NlpHxmNSGwCJH12Pn3goi?=
 =?us-ascii?Q?gBNCZgw/gWXcdkpPtgwEOgyX9byqMlSbapmFEEtNXZNuAa7tEpsTdlZeHhbR?=
 =?us-ascii?Q?7JhhoHQjvx+2L/ZB5JaATno86FbA8N1nMszIBTHRYqTFSxCk/zh1ct66oeY8?=
 =?us-ascii?Q?IfUt+s2audHW+ZGCbhdD/Mo7IwpZ0zFKrd1fFVC30ImTt3oZbF8ou64DRdz1?=
 =?us-ascii?Q?g/rCgk/tRg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dcf9f1-ce32-4607-144e-08def938b788
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 12:45:12.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNTflRGQL4bir9LqH1DJXUBcxFLEADU3uY3HsN+T6eJuDu/uC9jxNIoo8qXcwBX1avRV2S5MJS9r7bX8ptzTfnCRF0yzkh5thOoAEEDzjYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14890

Hello Manush,

Thank you for your patch.

> -----Original Message-----
> From: Manush Prajwal <manushprajwal555@gmail.com>
> Sent: Thursday, August 13, 2026 1:11 PM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: netdev@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Manush Pra=
jwal
> <manushprajwal555@gmail.com>
> Subject: [PATCH] net: ethernet: renesas: rswitch: fix device_node refcoun=
t leak in
> rswitch_get_port_node()
>=20
> [You don't often get email from manushprajwal555@gmail.com. Learn why thi=
s is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On an of_property_read_u32() failure, rswitch_get_port_node() sets port t=
o NULL and jumps to the out
> label before releasing the reference the for_each_available_child_of_node=
() iterator was holding on
> it. Once port is overwritten with NULL, that reference can never be relea=
sed since out: only puts
> "ports", the parent node. Call
> of_node_put(port) before clearing it.
>=20
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> ---
>  drivers/net/ethernet/renesas/rswitch_main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/et=
hernet/renesas/rswitch_main.c
> index 6fe9648163..ffdc42f430 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -1315,6 +1315,7 @@ static struct device_node *rswitch_get_port_node(st=
ruct rswitch_device *rdev)
>         for_each_available_child_of_node(ports, port) {
>                 err =3D of_property_read_u32(port, "reg", &index);
>                 if (err < 0) {
> +                       of_node_put(port);

I am not sure why you are adding this here. The code jumps to the label "ou=
t" and that is where=20
"of_node_put(port)" is called. Is there a reason why you want to call this =
twice in a row?

Best regards,

Michael


>                         port =3D NULL;
>                         goto out;
>                 }
> --
> 2.46.2.windows.1
>=20

