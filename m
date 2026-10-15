Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955051CF62;
	Thu, 15 Oct 2026 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070464; cv=fail; b=miD8pi+BAcr0hQ+RbE1NZoV7hzAmnGDBPlmUtpOr6JC+op9BwFxvsT2sebo3uO6Rb9c2SI2rTnCRvf3N5ZMcBaSRa5wdNlaX6c4STL2z1Sdb9cGfqRVjKsOvMCjcy1D0Uld63UWbj+N9IqRVqtg9QThWBcQOJo2tGK4MFaniO6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070464; c=relaxed/simple;
	bh=4haOELsZPyp7TJWZHDFi/daxRy9dxKLAsWZxY8h8Igs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYGx5aNArvAsBnNnKlGJ3d6w54RyZQ4YwbEKcF/8G6ulJR6ROTCDoCK+Uv3tZtwK6EeCy4bZjudzsItv1CSgPuCqk36gvkpTbqIRzOr1fSdQzKBgpBUdiPixI427ItM1PXWUpWYThw1AW/N5I7pTK4Psqu8BOhvQExH9O4ZXjzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BMkvbxDu; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BMkvbxDu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs5tMWfPBF8odvL6Z1rt1ypnbhLWadOAXOJwIeNTOBJFildxoWFXIHsvjue9lkgWnvnBBqPKImiznF8TVOgFD9c8DG4alNtd0SSXXQRgifLAfzQ48/GdyvZdvNaHSFsgHNTfvna+nu8/9xn97jYw83Drt09E43NLVMFEvMLChKLCHjewvB/UznH8zUD+1qQoCRXqOh7HAfWOwSah2DvWnnqshqZdbxv+f4Ouiih0HEWoqhSGDq1UAFtX4xXK6FAmS8d932SDo3s6xhXAW27Y8ZbKb+I8+ULgrihIHAIZzlF9GbcxhjquWa8fY3S2PZMsTs/HahprHbYe+PwyjKYDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT9W2ZqG8PMAOmnJa6qGpt/ZQKKTT3x/eW9kbddIWis=;
 b=V672SyjGFSS5crT5Kf892ooyEga52egapzU7zG79+AiP8ogUG9cZRAKznvWEZaa3QJp6sGWRUdfVFYG5HnaOIEn0mQpR8BjX/kzv9dcJ4qvYgR/QhbDyMjcPoJtjV43nlXjPv2GRO1fweNzXBfMshjjwrys2BnP8A1EG1B7Rjc6IdtPmEsI9IIIxoJFh1rdBjChbRgfjitBu/nWGyRXrVIZ5VL++SmLo4ZWpdv+QCtEIcVi6oUpY/ytccmBx5fxDPRzvUuDYuFlPZMFTpOyv6LZH4n4d7vlk5cqGNZ07Sr85NqIYoHw9XUzJBzZNXZGflZS89No0cDjMtW+VwsTYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT9W2ZqG8PMAOmnJa6qGpt/ZQKKTT3x/eW9kbddIWis=;
 b=BMkvbxDum/11vxVoqU5Z3F7t4KiKydDO6AwbpQkfRdJOmjds6FHA1TnVfCG7oWxmk2bCbaKeUpY19TVxTUH4QBAsahQzV2XxXaWnEg+Po9TULaVgh6kcNuPAt32M3Vy4hsqsOgfIZ3ikQKqdPCguVBAfLkIbBaTk+Zp9MdEYLWNZwlQm/OgoWNztYpawmijNZV321CuD3Nqv2zBe7owbImcvsAwSPdnME4mkGYq/k55VsFkqQNy/5j15AlcOW/1PG6HUxGmwJHemCJqOw8V7tFWyGEEI6rJiwS9h/sDhryLJpTOzxakVZ/tbiEbYkOXlHv5eOrE9PT3BvxMTvtCU3A==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by CPJPR04MB809864.eurprd04.prod.outlook.com
 (2603:10a6:380:20a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 13:20:56 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 13:20:56 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Russell
 King <linux@armlinux.org.uk>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Topic: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Thread-Index: AQHdWzYWe74LlF4VAU2QF0Eh2lZjvrb93/uAgAC0P2A=
Date: Thu, 15 Oct 2026 13:20:56 +0000
Message-ID:
 <GV2PR04MB1174099F6844DBF759BE22E0A969C2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
 <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>
 <AS4PR04MB933876A424328F6A6FCFD29C889C2@AS4PR04MB9338.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB933876A424328F6A6FCFD29C889C2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|CPJPR04MB809864:EE_
x-ms-office365-filtering-correlation-id: e3f00ac7-791a-40d9-ec2f-08df2abf2541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|7416014|6133799003|10067099003|18002099003|22082099003|3023799007|5023799004|11063799006|261009223027099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 6NOIjwf+QnFUU1bUuk0ucLCNVIscQtzR/f44scbXfiGzhIN93lvv+8Bh1fYtC05qY2LNrsRqrCD9HYG03Xin5c2oEdlhdK5jnxW0YwnRuFfonrtUmdroHjZVNxB2l/IRIzwQCJt0rp/47wk+qjbD0jzfOPc7oqVvefX/cYo/LgdlP1cbuU/FkGqH+J+ok2/DyHt+PBLfRKzz4ROIJn0+kkt6+83WRIIcRLHynMrIMc8urC3WwDrrXzlq4sOtZIN4fImTEnwYpMjBwz5LB2hdyoKtqXmyUunIpccsyjRBlCOf8UlNno4G+GYr27UL72mXaRsvFpawkPOpReUZbBEdHZFMhfMUBL3DBBd4W4y+bfCibfcsEKM0HF7mWyvudeTl8VeXiMDod1q7guOhcBL999KXCiy0DhiQXc0AfT2grp+IBPZOExtDsNSH6WE8mEaTxstwCjieRyOBGJxNBHehzUltAkwPaBJlCtuesA0tenNu22vzUjPv7JPRNoMI+w4oSP21IbkZiB6cJ9nR8hHxGKoLOWWFXWr/EX9GY8m3vfxhs3Lusmu89RDZWTAHvBmT2pUtUNT4ZybOdecsZ9ETV29AezmLi+crN56qOsbAyyELh3/7ow02JrV1fOPSW8P27S1mav/WLM3tVfcJc0B16q5xCrVgM+N+bPx/xwjnAy9iBHBy7tfaPkI6zhZ72+lnYHm7erehpsakjW4ZcEPZRH8tMg5nbQSh+e28eQgnGvQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(7416014)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(5023799004)(11063799006)(261009223027099003)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WiBVV3LYeON41CH6owW2cceq+sneYJrwyANl/8Hcg5iqeph0sjhYcjoFFDaC?=
 =?us-ascii?Q?aEEQO+SvBOMEo1vPlcP2Hc6oEMSRMUqf4ihF3w3hRryCLiGiGbCBIeGg0bqy?=
 =?us-ascii?Q?0juWPlh4J5imiyTCbqBj3fbWjL2PXIPvTysSnNWuKUjLaR3DK0GFlpO8YgFc?=
 =?us-ascii?Q?xyax5b2XbJmwEqoiOPddpoQgnFxSOge0I8Qnn5QWLL0KsSO2gB+9N9vz5tVA?=
 =?us-ascii?Q?36T8LchMmgg5CN5kgOqsjqTIpgFB3ANjEQjxUP1ROasBkMF31H10v04ELVNc?=
 =?us-ascii?Q?13rueIGku25KvOV0kP+N+KpSL56rkThG+60JL4m+c4gYeZut6Mgct+oUaT5j?=
 =?us-ascii?Q?+AEgw35AQcdexK67An5M4QNsxKC7YB3snaktvriaoLbIdvV/J+vTn/zQFLN7?=
 =?us-ascii?Q?Yzb0B7F+XSCcgs5agVa77/8ro9Wwsjw/LgF2vnjAgffV1Z60XZecNIJHh/L5?=
 =?us-ascii?Q?zYGz+lSldRwNwD72jY58qPwa8bWmuzvzmuJJAeP4nNJbs989UUXJFIFZ5WXI?=
 =?us-ascii?Q?gFnrR7DfhRgDnzVNCXa+bzXTwXmXfi4Q2BxcLSWeKN0y1vRJwwSwUv1y212E?=
 =?us-ascii?Q?4iU29ao6X/krLMyyzdhVeq8OFmsBdaUJ29SGI2Bu+7EzbnEXJqDoxyrpG6Nf?=
 =?us-ascii?Q?GwUzwE4/vjMF2wLJqTiClqM/sgequkkEI9DWxnKbCFRkDtBGt37gpx2GcblK?=
 =?us-ascii?Q?R8c0JPFtw9IAhjc3wIxzLADoB1mIbQtogNBGuBF+hPmE9ZNk8P3ChZv/pyC8?=
 =?us-ascii?Q?BEAVQ5IDr394La4+LBUIFZRD3No24jApY/62qp7YgrMcbTcT92lZNDyaaeQ9?=
 =?us-ascii?Q?iypFp2Z2qv2Lee0GPTP5GXcostrlZLr1I2lDs39RX0/Hx4m1IrKs6HkfLwpI?=
 =?us-ascii?Q?9dx3Km9gzsxzW9T8mC5KNsioQCkK+eO42G49PYih5VcdCbGUlxJSRPSx3uW3?=
 =?us-ascii?Q?TRrGA+tGx5uu9veBKq/c5QOF2Tv6iK0zFa32VODlpDRuEjBrk2eoTJiK/SP2?=
 =?us-ascii?Q?Jt0lFT7uWloTuVQ/gtReijckACq7nEzUjmdPBl/3fxoW2KWsW7mfJ3sV0ceZ?=
 =?us-ascii?Q?kBuV+5aGZQxZTVyP7zpFd0a7HOzgqJT9oPaV+e4+HHis/aULfaghn768Mlgb?=
 =?us-ascii?Q?aS4JB7KcVQNMkFVUACzwYVlb83KeHxbbS0ro1aU+rxnXMwTEsOrN/RPQCEw6?=
 =?us-ascii?Q?pwUG3dNzUjVpKyLuO3KXHGbRC7sRTXHDNSvfdJ790DqOsH/94f4YcJeBwEvP?=
 =?us-ascii?Q?KAf6f1uByKWBuch8jVvAJmCSBOYvEDvhFIwRSJ8EbF28ia4uET4sFPyv0ELX?=
 =?us-ascii?Q?y1sq8ygtVuYKEpXb97kCXQ2MZC3b5Hycfr7yyXyMhG5QFb4+Vw63d9+nryPG?=
 =?us-ascii?Q?1AsWR1hl4zV5mbeJyQAaIWt/I5B71haLUovW76H74V4BmDfiXJfa6v9Fz6qS?=
 =?us-ascii?Q?y1ZtXckre+E1SbaVj0bK/V3gidtDEfwEtnHbxjVWfEzcW9JsHkVN2FC2Z2tP?=
 =?us-ascii?Q?eefOsWdrmnUCXAxpSaKYKcgii1ijuU5yV37+Mpoq4lgul/Ai+oJZPgkGXwxE?=
 =?us-ascii?Q?xpzosHrnYJGgQMRP1GKVnquTdpc+oCtO2wfufSBxsjtyvny/i8SL15OEyzdI?=
 =?us-ascii?Q?7lu/A3xisDZtJ85qekEEBLoQy+aiEWYFbKdDTgpRi07RYQzCZgmUCWPKCy4V?=
 =?us-ascii?Q?X5wgR1IVlokPIRLzrv+8V1HemKwAhXm8KbLxg5TFhza/bcDFjnne2IedxcpQ?=
 =?us-ascii?Q?ZfcySpIpOw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f00ac7-791a-40d9-ec2f-08df2abf2541
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 13:20:56.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzmoI/akRZB4rbDUF4d8IJDKBijecQsYUdgvGTFxdL8Xz7Yv113yhaT5f6ynvPANWjTiZjrMRvVnbGSbGwbpkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPJPR04MB809864

From: Wei Fang <wei.fang@nxp.com>
Sent: Thursday, October 15, 2026 5:17 AM
[...]
> Subject: RE: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support f=
or
> ENETCv4 Ports via a fixed-link node
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index d9e91832a9c1..ed5402f1b73c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -500,6 +500,7 @@ struct enetc_ndev_priv {
> >
> >  	struct clk *ref_clk; /* RGMII/RMII reference clock */
> >  	u64 sysclk_freq; /* NETC system clock frequency */
> > +	struct of_changeset *ppm_ocs; /* pseudo-MAC fixed-link changeset
> */
>=20
> struct enetc_ndev_priv is shared by both PF and VF, but ppm_ocs is only
> used by PF. Would it be better to move it to struct enetc_pf?
>=20

Ok, will try this out.

> >  };
[...]
> > +static int enetc4_add_ppm_fixed_link(struct enetc_ndev_priv *priv)
> > +{
> > +	struct device_node *np =3D dev_of_node(priv->dev);
> > +	struct device_node *fixed_link;
> > +	struct of_changeset *ocs;
> > +	int speed, err;
> > +
> > +	if (!np)
> > +		return dev_err_probe(priv->dev, -ENODEV,
> > +				     "Missing of_node for Pseudo-MAC port\n");
> > +
> > +	enetc4_get_pcr_speed(&priv->si->hw, &speed);
> > +	speed =3D enetc_phylink_match_pseudo_mac_speed(speed);
> > +
> > +	ocs =3D kzalloc_obj(*ocs);
> > +	if (!ocs)
> > +		return -ENOMEM;
> > +
> > +	of_changeset_init(ocs);
> > +
> > +	fixed_link =3D of_changeset_create_node(ocs, np, "fixed-link");
> > +	if (!fixed_link) {
> > +		err =3D -ENOMEM;
> > +		goto err_destroy;
> > +	}
> > +
> > +	err =3D of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);
> > +	if (err)
> > +		goto err_put_node;
> > +
> > +	err =3D of_changeset_add_prop_bool(ocs, fixed_link, "full-duplex");
> > +	if (err)
> > +		goto err_put_node;
> > +
> > +	err =3D of_changeset_apply(ocs);
> > +	if (err)
> > +		goto err_put_node;
> > +
> > +	of_node_put(fixed_link);
> > +	priv->ppm_ocs =3D ocs;
> > +
> > +	return 0;
> > +
> > +err_put_node:
> > +	of_node_put(fixed_link);
> > +err_destroy:
> > +	of_changeset_destroy(ocs);
> > +	kfree(ocs);
> > +
> > +	return dev_err_probe(priv->dev, err,
> > +			     "Failed to add fixed-link node\n");
> > +}
> > +
> >  static int enetc4_link_init(struct enetc_ndev_priv *priv,
> >  			    struct device_node *node)
> >  {
> > +	bool dynamic =3D node && of_node_check_flag(node, OF_DYNAMIC);
> >  	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
> >  	struct device *dev =3D priv->dev;
> >  	int err;
> >
> > -	err =3D of_get_phy_mode(node, &pf->if_mode);
> > -	if (err) {
> > -		dev_err(dev, "Failed to get PHY mode\n");
> > -		return err;
[...]
> > +	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
>=20
> This indicates that the node pointer can be NULL, but
> enetc4_add_ppm_fixed_link() subsequently does not allow node
> to be NULL. This is puzzling.

enetc4_add_ppm_fixed_link() checks dev_of_node(priv->dev) and
if NULL, it returns error and prints following err message:
"Missing of_node for Pseudo-MAC port\n".
Which is fine for the enetc_is_pseudo_mac() case.

One alternative would be to take the common 'else' branch in case of NULL
node for the pseudo-MAC, and let of_get_phy_mode() return with error, but=20
in that case "Failed to get PHY mode\n" is not a good error indication.

So, nothing to change here, the 'if' branch check for the pseudo-MAC case i=
s
correct as it is.

>=20
> > +		pf->if_mode =3D PHY_INTERFACE_MODE_INTERNAL;
> > +
> > +		err =3D enetc4_add_ppm_fixed_link(priv);
> > +		if (err)
> > +			return err;
> > +
> > +		/* The fixed-link node was spliced onto dev's own of_node, so
> > +		 * phylink will find it via dev_fwnode(dev). Use that node for
> > +		 * the subsequent MDIO/phylink setup below.
> > +		 */
> > +		node =3D dev_of_node(dev);
>=20
> Based on the implementation of enetc4_add_ppm_fixed_link(), the
> input parameter dev->of_node cannot be NULL. I'm not familiar
> with the of_changeset_* APIs. Will enetc4_add_ppm_fixed_link()
> update this pointer?
>=20

Sure, all these functions take 'np' as argument, and 'np' is
dev_of_node(priv->dev), which is the same as dev->of_node.

> > +	} else {
> > +		err =3D of_get_phy_mode(node, &pf->if_mode);
> > +		if (err) {
> > +			dev_err(dev, "Failed to get PHY mode\n");
> > +			return err;
> > +		}
> >  	}
> >
> >  	err =3D enetc_mdiobus_create(pf, node);
> >  	if (err) {
> >  		dev_err(dev, "Failed to create MDIO bus\n");
> > -		return err;
> > +		goto err_mdiobus_create;
> >  	}
> >
> >  	err =3D enetc_phylink_create(priv, node, &enetc_pl_mac_ops);

