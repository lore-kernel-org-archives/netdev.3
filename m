Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586942586C;
	Mon, 17 Aug 2026 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972328; cv=fail; b=ReyxL7s1DyGtIaBbpjLSIRtkE40AZlZV3xyEI3d3KGB0bJdegN0goouYk38eq/mOBlkMqv3P6uy7GHlerwAU6F5K3YN2EehTsgLJQjCpqZX1aIAdM2EJG+VLlMWkLMLF0Ey7MGp4CG2FuPT1VkjFeRtgihPszuDdKSGWmqyJDJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972328; c=relaxed/simple;
	bh=WnAezTYn1gyGWhTyNruwNgnu6gWVSpO3Xj00AWzecfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ude5c0q6TLgC/bn9BK766OJmO0VoEkX9jT5HT7wZZC932UikfzotLFwi4qt0I9i7bA/fT2i1QaEZNVYHdYt9cqSV2oYufW8Vo8ddpCyBW+9vO+7LNXlsINa9/LY75scTvXFIWlxGUvYa052f9j8G1RexjqGSdvizcxN4oFmcDJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=W50yYGRN; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="W50yYGRN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRpI1634N1BAgLv7i4xqS9rvSSUepycYwpBtdhLJ26Xd4Gf2H8pDqXLbT22rnaJSVD1V/vSqhhoBU++5mf7/IF32ftHcW9Vv2OYxX+qISpXwk7e0sQvgD4PgI4rDrYgXDQdS0IEFXqbkga2ejxIn6d+vswtkWuP3qCJPXZR2yCNARLUk3yV3q6ci1lwJN9aunuBHjVabvKoy6HY9Jklq9e/OD5NbhL3G1NeFbjZdoQ8Z1lsy7DITMOzYjTWliM/Tvt8DpDa6R8RB8byW0yomJWKD4WD//GVdXwuxqpVmtVljdc88Usbw+x+yblzJYBEk/6EGbNNONGnCX4zx6t7z7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLuNjWV8U3U7+9vYms8WHzoSFiKghqueKkWzZBYH7LA=;
 b=sZzvA/h4Kuf0H0oZFlD/COVSsYH1FW4HN+w622GjikRuTcA2XjidV/Ig9uO0G1MZTWbd6LPBaJvTBuYs3Rl/sj/bJ1gD8x+KYV9zHgA6/Yzru8rrNYKumpkBGgeKib8O0q2wFpRRKR2cu46uyrLthmGX52K6oFfwHQzt3V+LthGTQmI/nP7DHAVnV9C4vMhvWrr3bU2TvguVuMLgB5+z8PaZYoydy4DTnWj/NBVU82rjmHWJu5wxP5BKR4EuRoxd6q/uJlkyTUlvlYk2Zc+xmQ+WF9T5N8w1NagmMfnMVLMD44b1XWk1arOt3MuZdrH0RTNb7/vOWZQOhBxnADwlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLuNjWV8U3U7+9vYms8WHzoSFiKghqueKkWzZBYH7LA=;
 b=W50yYGRNXPGCQqVn+sciOl3E3KxS17kaZqUHKFh8Sdzo/4PfM5f1Lb8KmcK60Mi5OZJxeOXhU8PZkIBt5Orh+EbzxT2nR2OfUkLbGLsr+OJwfAndpnRaMHzl9wWc4TIAHWehmpBXgUGiPVk/nUkbzJlHAYd0TgAp+Za8t3d7fS8=
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com (2603:1096:405:20d::9)
 by TYCPR01MB10199.jpnprd01.prod.outlook.com (2603:1096:400:1ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 13:12:01 +0000
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a]) by TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 13:12:01 +0000
From: Michael Dege <michael.dege@renesas.com>
To: manushprajwal <manushprajwal555@gmail.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Thread-Topic: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node
 refcount leak in rswitch_get_port_node()
Thread-Index: AQHdLCAiwvsD/tMOfESV4bKJu79G6LaiOb6w
Date: Mon, 17 Aug 2026 13:12:01 +0000
Message-ID:
 <TY4PR01MB14282E65E2588C32576740C5582A72@TY4PR01MB14282.jpnprd01.prod.outlook.com>
References: <20260814190423.933-1-manushprajwal555@gmail.com>
In-Reply-To: <20260814190423.933-1-manushprajwal555@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14282:EE_|TYCPR01MB10199:EE_
x-ms-office365-filtering-correlation-id: 5216616e-3e25-4827-1dbc-08defc612026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|38070700021|11063799006|10067099003;
x-microsoft-antispam-message-info:
 hw/34zw+atjPJNDhwqSm5uVAT8//HAaUkm0gccCp8+Yjdm3jHwQ0UVKQOmebV7QRmHvb2rEkg+zs4A8UutOStVLcuT/jT7WHs4CNzfKtIFmcoa1ZhsbenyEPmYZqnBOO9KNSqvxOeoih+FktO8gW9rl9HU3HCo7lYpCIzcCrnbspzzhjUaGitxx5O+SS+jdcgPsZGxwuIZFvhOv/eB2TrS8fF8hevp2/t/JelS4s9APyAU81ZSnv2mX9mFby+OZoKJzfAUlv74CShqJMLMu991xr0mkFJ5pUo8GDlOHZqrIeeOpJh0Xvf12M+h3iVEDKqnSp2hKE7gUMlhCx9SwiaDD9AG2PYih5fwXttiUYJJlokVROdwyFgVlfh/WZhlN1+CbwzR37z6EWZYc1fHkCAUSiMZFPTl0hpfgCO8PPJuK0piyyIPr59WmpjhgfA+hP11fCcfN1A//0a2hcLXmymvigPD8aUqKFocnPIZ2Ke3udV9K14LDEr4yJtJ36GmNVozvgnxxPf9Su1DgHNIJHYsBbazBhtsOktL/2jw7Qjj5LZppAdGGDQuHI5/Oq810bAvdQPP/bDnv73zemfSXNCYjgKj/HjH0E5ouGwuB5i7vIsMOLm4ipePJNch1ip0Evj0AFR0ZNkMi9TlZIEJU2ZbeZCyZvXdZ55nUvzP/G/vAzPvbAenogJ5i5o53lwZ2VMMcuq0Vq3JWf+yE3ur0PLA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14282.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1SrxQbohVgfOmQH5O4KQAJFhqcbKsMMqp9BCa98EeOupq6qNHh+j2o2SPq7B?=
 =?us-ascii?Q?ZC4yUAm4zF7kGvzFfWzIhcMj+44uassBdV19Vgx4uoCMDOQ4gfy63OEjwFVF?=
 =?us-ascii?Q?b0uPfqcgyEyoVi0ZD5YPYqKZNBraKTDtloW18p6M1cd+D8dlxdrOsx5mphPf?=
 =?us-ascii?Q?YD/V8h2h2irEXpY7gYZ3ehBL8a/BHdMfOXh0uwuzy4yrUDeWUWsBfgu9i67F?=
 =?us-ascii?Q?0dER+3nXKTU7Z817whQUe1aITynkKMyMoLQmqYQsqzOgQAI7NGGa6Mwu+gQ4?=
 =?us-ascii?Q?eIEj9YUtICJnEl3gWKoaKeu35rJla0hM+5Q2+nQ7hbaX4d6piGbXWBE/lm3v?=
 =?us-ascii?Q?0G/TPbWkx93rwFOTglzdTWwBnit6Vs3p1kudIjFGQ+p5eQ4C+0EeUZUo0NhT?=
 =?us-ascii?Q?pTkfsJdsuEbHwVi+8mYW4zGtVrMqhrlywGxvlvRv+W1Djg6O2WcWRmU+XATp?=
 =?us-ascii?Q?d0RrE8rXp9Zcsnno9MC42FkAVn62Hw7shIpTv/MvaRstZ2lD4B48XcYyvr+D?=
 =?us-ascii?Q?/wJ9H1FZ0MiYMQO/QUe9W1qML0p1CcoIf8eDjVrmLnbHwQvbH5UBrcb1vm+z?=
 =?us-ascii?Q?oSh+1Vxl0eStkJ/ysaIx7DvyF/xOcQa7i/Muo3FkjNZ47dO0UICvxbzV0Mq9?=
 =?us-ascii?Q?XWDdPjgB/zZBHIWO2qHI0ImIFmNN76bM5rBgAMfT+NZO3PZ3bazc2gdAoeAs?=
 =?us-ascii?Q?0hvHb7UBzTuOP36GOS8FvSkUicBw+tizdcvrIMyE50gAWYW7iXRhdLnoLfx8?=
 =?us-ascii?Q?I40gky7ntjMpesYfbMeMirtb2Xyi7jYhzFKZST6qSJet0Nq8oNY2BojnMaal?=
 =?us-ascii?Q?1d8v44MiTMO5OvzNpwE/zUByugQexywkwVYW1sq2Vv/bSOsSJlZuAJiCJ833?=
 =?us-ascii?Q?PhSJdcehwxUVQuZOgFtzn7gaJzUErYLluwXR1oaLthBFrCZzE+oXhXBAhVzI?=
 =?us-ascii?Q?Ol2k9M1BSFp0ketR9UkrG5FY+9PWzkqt+ro8gT719/RIwXWikRluRa1dFtCc?=
 =?us-ascii?Q?mTthDSNGNBfQZHrNUOgLEm+NiXb2uEPlNw7ckqsSjZEX1HGiJK3aMgzCM2r9?=
 =?us-ascii?Q?2csMB4+ViGUQWQ/MXkZ6Dm3q8DSgeq/M62YxAukTQ0aG8jvl5EVXM37yeYEn?=
 =?us-ascii?Q?w1Hd9g9pXLJAbtR+zas+9qM/LjWHqD/UFtyeJ3Dwwev1GkEBgyrUd/MG5FLL?=
 =?us-ascii?Q?C2GdHbWmH0dtLB1oJ71iA/42v9m5ggMbp/+DdsQrea32ZDwHyqBaHV/feVPW?=
 =?us-ascii?Q?ubvmSA72MkDOXu3B4EObQJj3WU/0e8cdmr0mvpcFYdPT4rEBp67fWYw6XkTk?=
 =?us-ascii?Q?7ZfY1yRrnKJuvhIvtFVR8z7gZZM3DLps/hxan+juKHlLzB4ZA3P377b/fRw+?=
 =?us-ascii?Q?Yic5PU4PMgMLiltrNlaaAYTemot0NNeE4EKAFoD7KEl+Wa7wqK0ZraJqFtqH?=
 =?us-ascii?Q?pfioe+/bMK4rJrGy9XXo8ixP2t8TtbgwjCH/Cx75NjDz8y9ZgGjVA2gZO0TN?=
 =?us-ascii?Q?qZZ+zau1RjNTNapWRgC9PUjGCRxB64uUMsg94sDT8TZdT0fzGO45g7OAP5wB?=
 =?us-ascii?Q?5ON5uO/Bi5pRwWm1dX4GYlFrjBswg7wqRAbhdkOKyX4kcS2IwnNYe/wlDcWP?=
 =?us-ascii?Q?KP14/fDONvFzIIYnkYYlieSqbBimZN53DRMsem9HRHLE1kVJC3r4UtWyqHvL?=
 =?us-ascii?Q?qy8DReDsWwYQ5wkGPMjatGPxQS1CVIklnpb6U1aUUygXmLLiiYI0PKT+wrBo?=
 =?us-ascii?Q?ObL9IJ2P3w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5216616e-3e25-4827-1dbc-08defc612026
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 13:12:01.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zk2jAXPyDRAbrtOij32suTjqcLOR57hpXlDP5w/it2Ty9GbR48klnaHct7FwxdF4P0WA+kZGWQkyb4xsLTn9W0KseSV7SiPlTIs3wzO3wWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10199

Hello Manush,

Besides the problem mentioned previously. The links on the interfaces do no=
t come up.

> -----Original Message-----
> From: manushprajwal <manushprajwal555@gmail.com>
> Sent: Friday, August 14, 2026 9:04 PM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; davem@davemloft.net; Eric Dumaze=
t <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev=
@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org; Manush Prajwal <manushprajwal555@gmail.com>
> Subject: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node refc=
ount leak in
> rswitch_get_port_node()
>=20
> From: Manush Prajwal <manushprajwal555@gmail.com>
>=20
> On an of_property_read_u32() failure, rswitch_get_port_node() set port to=
 NULL and jumped to the out
> label before releasing the reference the
> for_each_available_child_of_node() iterator was holding on it. Once port =
was overwritten with NULL,
> that reference could never be released since out: only put "ports", the p=
arent node.
>=20
> Rework the function around for_each_available_child_of_node_scoped()
> instead of adding a manual of_node_put(), so the iterator's reference is =
dropped automatically on
> every exit path. Since port is the function's return value, take an expli=
cit reference with
> of_node_get() on the match before breaking out of the loop.
>=20
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> ---
> v2: Rework using for_each_available_child_of_node_scoped() instead of
>     a manual of_node_put(), per Andrew Lunn's review.
>=20
>  drivers/net/ethernet/renesas/rswitch_main.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/et=
hernet/renesas/rswitch_main.c
> index 6fe9648163..ffdc42f430 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -1303,8 +1303,8 @@
>  /* Call of_node_put(port) after done */  static struct device_node *rswi=
tch_get_port_node(struct
> rswitch_device *rdev)  {
> -	struct device_node *ports, *port;
> -	int err =3D 0;
> +	struct device_node *ports;
> +	struct device_node *port =3D NULL;

Here you declare "port"
>  	u32 index;
>=20
>  	ports =3D of_get_child_by_name(rdev->ndev->dev.parent->of_node,
> @@ -1312,17 +1312,15 @@ static struct device_node *rswitch_get_port_node(=
struct rswitch_device *rdev)
>  	if (!ports)
>  		return NULL;
>=20
> -	for_each_available_child_of_node(ports, port) {
> -		err =3D of_property_read_u32(port, "reg", &index);
> -		if (err < 0) {
> -			port =3D NULL;
> -			goto out;
> -		}
> -		if (index =3D=3D rdev->etha->index)
> +	for_each_available_child_of_node_scoped(ports, child) {
But here you  use child.

> +		if (of_property_read_u32(child, "reg", &index))

Same as above

> +			break;
> +		if (index =3D=3D rdev->etha->index) {
> +			port =3D of_node_get(child);

Here too.

Best regards,

Michael

>  			break;
> +		}
>  	}
>=20
> -out:
>  	of_node_put(ports);
>=20
>  	return port;
> --
> 2.46.2.windows.1

