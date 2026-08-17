Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011054.outbound.protection.outlook.com [52.101.125.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B51411FB9;
	Mon, 17 Aug 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969730; cv=fail; b=DLrSUHF9kqDLmv0DMiQnKIkph/8tX9sOz2hMdZ92HykBYSsbokIaodTA5VCW4Gz/rWfg3EPDBdhdKDmrmatr0argECsqNXzcc/zRzkyNCGkv//Bbz9Zljg7iNwBh9ui8v/jPWVnuTt8oJ/H3SlfxoDUp2sM8tTLjzuiOffqe9og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969730; c=relaxed/simple;
	bh=0SI8z4Mg/YXyagQEva8VsCPIak9JD/hFrOXD1KjRZCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gOwMEjPobQ6n05EQIPEk3r9qu45JsGvkQI59wXDHXdPh+lWZgLR0koDh6qjf5un9JMyHhsXl6AM1+KcsndL+DRua+yOaLmjxHWHJCtElwdo/5nfaHUVvMLICJPVqI890EDXDbZDpia1af52/gP4hfQNxFKtI4odclycnl3IiFoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=bKbmSPNl; arc=fail smtp.client-ip=52.101.125.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="bKbmSPNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHqbZdhMp10s0n4my6m2t8Tx0wPtAd8udcsSCcKYM44QnRJFNMqr/XmxFvsva4+4vCXDBhKy1n48bBenT6qLT/PF3YuZDtVwnc+NlJ5pvrscvGVTONqbHIiWpai94BLwvWE1dDJzYms5X7swwmeFVe3Our1kHybzL/dXsiXIR0bEWXCffM6SZDTowjCnzgHbQSDEAWUUdyOwnAhyqxDgQqPz/K5GR28G/PXFzhXyO0lYC6URK1AwaJGJ106zosk7IrI1Mq55NkyUk6ezLGmTWpeAPhmgmAjrKdAJ4q6PyOHTcwFAH4E2HpDjnMmN7NbejDb5WNxJUiF8jce5LQvoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2oN6jqsWqUOji4TRFtiMHPOEgFZNB0VDvQGAgYpnV4=;
 b=o7CPPOgiWOHK7T1lrWGNOrH6g4s3EJOnCS7LjBawB0J1Ysvkpg4q/uGC+FhfoyrxnfIh2X9Q7dNHFEzfAMVD5bwRfq72BZh4OYxTDPblMBmK2GLuwEZcwdCaLZQ+0RhaEwp09Rs9t2WgCgp13anMm5kYkqF060p7t45Yyptgajk19WtR8Bx/XenKc84YWDbVemklbS2Tb4iXeBxGl4/IysU50Bi3tN8GWZX2IXNMAuFkZWNut4DmovLT6vGmnvI09flop9HS57+rz/l4i0+TDkkwC2F5Uk+czzn/O61qUZpfq9btacC6NjQ/xPt47ICPwJxs6oPiDN9tDkXC+at12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2oN6jqsWqUOji4TRFtiMHPOEgFZNB0VDvQGAgYpnV4=;
 b=bKbmSPNlkMZUF+s3YCS952nNvaGGOTIwHO8f5FXpwcACl3iMTbfS1VEvYtCnhQCPyjwrGdt4T4hdNa03alYVhHGBPHDW26n+cmBbN2ygr5R/pQR1rnPpqpH/wdJveUNwZ6RCaQR1HZ/Tn1drVXU/cakTqdZpLGdGaserIAZgcJ8=
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com (2603:1096:405:20d::9)
 by OS9PR01MB12183.jpnprd01.prod.outlook.com (2603:1096:604:2e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:28:44 +0000
Received: from TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a]) by TY4PR01MB14282.jpnprd01.prod.outlook.com
 ([fe80::655d:9c47:4499:eb3a%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:28:33 +0000
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
Thread-Index: AQHdLCAiwvsD/tMOfESV4bKJu79G6LaiLo2g
Date: Mon, 17 Aug 2026 12:28:33 +0000
Message-ID:
 <TY4PR01MB14282297556165468224837C682A72@TY4PR01MB14282.jpnprd01.prod.outlook.com>
References: <20260814190423.933-1-manushprajwal555@gmail.com>
In-Reply-To: <20260814190423.933-1-manushprajwal555@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB14282:EE_|OS9PR01MB12183:EE_
x-ms-office365-filtering-correlation-id: f49c8ef1-bce6-47bc-5009-08defc5b0dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 WOtXhNrPj4r7MneNm5BeKrQvo3obeRY8ntkMq+IUuGZwHMqjFMSS7Lrb/XJPTVp6MvTP6m51+bJm7sW17u2GNwiEuYDXmOpX69F3V5KTCvtRSXQ5R0TxM++YP6uq7Fx1nxND/CetvOO70vCuIHca4vIlFz84wjOMqB8bgQ8b2/W9LCaYa6NR2UmKJXSOOKprUoV0hdyyzOqo7GsjbHRPRsIgE8iryAUjY/eW29FbsczK2drdkkgDRlDJOpFO+mkAZX/2qb245uvlqcjkMa1TLWCWDXfMrHPoTCY2HzV7CNztTmw1EPDywvsNYfbQHvHVQhca2UZqzN7oVnZoSrb7cRuGUu11Lf/MTxDwwCLZmPh1PF/oTMo9tO28l8dAFFkeU4v+RXNdz4R+dX/g3ivQAMXJe+VDdEpSPKpapNe++woIzOti3cBq9X552/+d9aukgGreMU+vt1bdblVsmlkAD4R68VoonvHj9g16nUg/lz2vBe3NHHNeN6XDtKqQ75vQyjgz5MMQYCmW9/tpawN4Xij3ucVg2iFFln62Nf1qkGPJnxgMzX2yRF52yH0a39CWutvTgFW7hgU8PN0QvqurQST5oMvJ0wdiE8ZkMLSwa/uBPCUCeTEJM3OQnK8MD4tj6LTvvYZbMG2uSIqEzciaMkIWPDyq/rFS3WMT4DjYU357+C4fR1CRbaos0jUaY42Hnz+v50VVL6BEdBldYKfr0g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB14282.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t4IG5PrstAs81iydHY9cNOuqo+28IZ2yGJOhta426YUjv+KR5zoKk7uod4Cn?=
 =?us-ascii?Q?eNIrTdLXNXnYTzp2ZL75y0xepnuc5ZZzE8oPFWocg+6dystGa50oWs9lrho1?=
 =?us-ascii?Q?JKtsTMgwRLAolHboCDv0ZiusKrzPxZmVXd5r8eulFMeUF2V0VApYYMbM0jqJ?=
 =?us-ascii?Q?GKBn/t6lQDBBnkyakFbuv8mcRJC3Zj5NlNPX2E8uwEa16ET99EPfNUyc6avC?=
 =?us-ascii?Q?qbiFoL68ENh5AegVOkP7ki9zZXbIoQVigmzUyyyTGky0aDm41GpWEKLsw8Pq?=
 =?us-ascii?Q?BYKR7TAvuWEcwWDb2hUrmz8F3cfDX/p7OVMvMVQ+MbDwIFE/hR2QWGpKpGQP?=
 =?us-ascii?Q?SSBF3suAM7pYzEQEXpqhHVyaevVTs+viqGDeuxw1jXCu6uDxTfwe6fLrCx5a?=
 =?us-ascii?Q?nFJtrGltX12FMvkQAwMyG2+WOjsA25H3XPiX6UKNucwqMXCRfj8kRCJ7ZIa4?=
 =?us-ascii?Q?4XbLl9aNWiGCdPa6oxF6zXdMLef4PQ6kQlTaBRyIZH5IQICLlAV0mVT3RCIf?=
 =?us-ascii?Q?AmXgkUgSr0RU3NE2h0zdMGiaCjqUIxa54IaiOQeOqggfTVmwCPbd350ElqDA?=
 =?us-ascii?Q?V5i3W36LAd2OF1kWMGSAdPgS7GZx4ptNk94+iqdGDUykjw61VLLAE/zwsn7W?=
 =?us-ascii?Q?2+QLqKFCdLJGCsWJrDzf6Tlysyu0SPkn1W3MzNbG4UIiZYP6bmAn/imNgveS?=
 =?us-ascii?Q?egYIKsdoAFT+Wk4S7UOLZl/xQxyGsjDPZz84GTTwxfKJuSEEhRPuv0v0q3tJ?=
 =?us-ascii?Q?cL4C73ro0PrlElWxonkatI85qoxl4yU3EEZRHeN36mgBtRDwPkTOdSw8s/oq?=
 =?us-ascii?Q?fKUKb/+rgxr1Jjb/Hqh/ilFWFr1PU9VtPbvS+12aFmP8ECxLPDnV9pl3YVYf?=
 =?us-ascii?Q?lThcMzyEh5mYkm4RUE71jKFzdWJGMtaMjUGTHTCZSCrxgRtYzpz7xloq9JSM?=
 =?us-ascii?Q?yzpNnV3iA6vgAXCU6BS2tfxCdoxOGepLU4MV467Ygj1CLrYTnl6bY0Y+Fj2f?=
 =?us-ascii?Q?7KgrLl6D8jc8jnIvyRRqI4jIpmScFb4cHIDDdll3km6d9x2C2NlqMNXZDTDN?=
 =?us-ascii?Q?8/fN/E7JlnpWiVLDHur2lxqotq2Z9vI4OT8GruNZA6bW9KrnGN1+rSemBjFp?=
 =?us-ascii?Q?IKGlYb2CGQAK4QmGXE5cN5WqBKPSVjodklT/EK/BAxX+x5es2ukN2AVj565y?=
 =?us-ascii?Q?4+HBEzzHJdbsr7P2T2S7JJFxB6hfpc1WyyOz8KbRg3dtLmIaaSbZaa3CA9DF?=
 =?us-ascii?Q?HhY1J3wTvBWB9B3fg6GX/JEurXTKWgZ98xyUpHAWDs6tASi3A9tN0Zlo17Uj?=
 =?us-ascii?Q?X+k6vasKIIw8KzrcuNlNDQBUhZ9eM3plU8O1shrasH8n1veLGcUlgathDMLI?=
 =?us-ascii?Q?/4W9b4F37b2+Vv5YrpmD682md/SqCwx1QUn15AvJ7ZBvVfnqQQeEE4vr2VLs?=
 =?us-ascii?Q?MWEExkqF96n3FgZ28LU17g1G0UgOI7u6Okoyfngh7PGa743wnXyLqpPrYjXx?=
 =?us-ascii?Q?jDmNnmCEYBJ7VTVYdcPq3+oALu89kmf6UZOiBE3z5rFZJl7mvXFaXuEePcgi?=
 =?us-ascii?Q?C6EtzbxbwT99tqISG3e6DfD21spy6wUSTDjb/h0nqn0E8pQn42OQV2YHSCze?=
 =?us-ascii?Q?PiwqwmQGXKnJV63cO+VZMEKaJUQ6aqYmj273+jKhJXmWm6czeEeKtFrAyKUS?=
 =?us-ascii?Q?hWycj+K9l9pt35wr8bs0RLqpSAo6YUgVt9AiwmA+Fao/2Cq77P43V2/8xT0f?=
 =?us-ascii?Q?NEJhXVBakQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f49c8ef1-bce6-47bc-5009-08defc5b0dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 12:28:33.6130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH9qGTXsGCVs5kWLxprxLR3srV6WYNSCUij8liHCwS9fCIQbACDN4ERN2aLNSHX8pNBt2iz9S2P/iHQ+1xxVT4J2HnIb64r/fHRboDxagnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12183

Hello Manush,

Were you able to test this on real HW?

I am currently on a different code base and device (X5H). I have tested it =
with your original=20
patch and with v2 of the patch.=20

Patch v1 works fine; patch v2 does not work.

Best regards,

Michael

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
> +		if (of_property_read_u32(child, "reg", &index))
> +			break;
> +		if (index =3D=3D rdev->etha->index) {
> +			port =3D of_node_get(child);
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

