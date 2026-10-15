Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E33D47A5;
	Thu, 15 Oct 2026 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030601; cv=fail; b=O0IsyPlLORQgNPlNg1PBbOrJnKDLjs1H763fJdsEG8OxiaUOkf7wU8BDH8LtFg9pY6gcUjFQyzNuwY5bZHeoW5gUr+whGrq5ygCgKqEF2dQlrEJMGRfGnGquAn5j5VERocV5TYlLeuXkjBz/ZACFq4hJP6QYcfBaLLkiaYYN/ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030601; c=relaxed/simple;
	bh=AicSALScglMVVJJ3fkzL3hqM2Bhb/HnDDzhhfKRIHkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeSMBKBFJbUt04cVR+CF+FVvVVnFyAHjY7ZPE/7NOq3B+9/bIc5MKCy7dARSq36s2sZpW8i6VBxbyt8XbE5466Qc9x+Ad42e/ghUKY1YJftOWayBp9t93c3bkQzgIlyTKLQ3tfAzKkrtYBV39etDFcJCdYuU0am2lGAiNsvYhw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HIOmvo3n; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HIOmvo3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upAPQiPkpI5MGIXZ6c9rHjL12y8eYp+pegw4pLMGtKaHDTlF24OwbMoC8YeGIbeZzimxuzubBsHqhyTe2HJHfg+v2jbw7/bcycKLxISxJ/j36fwntFg4YSOuxMR70CoZdkH9Z08XHJ+SHnSXmkm6xAhV6yo6+wqxqO8bpbpgfDKjAps8ZqbAPHYaYpVVtxxYZIZi8y00u9fQlqqQs56OCkRnd+AOglYqHw99QtaEaJH+T8u9GCvvYP3t4NVQFcEOIT9GSWoStDD6qDhGem8bIowC3chqnQ8V0GsUkxbcJQiUihoeinXta2WZZGpO0IPxM4EbYQ2X/ZgIL5diJT3qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9gW6wwryeuZ6FJWimskwKiUHTO1ilUjjC63eeivGWg=;
 b=AvGx2+ckkUCSXf8PnNSdMYfKMr/XzJG1MMvorMyw18G93qil7o3qckiCiWZw8iTGSyfpxVOL7B6Yf+plYcKHG8QHM3CMuZD4cwOZcim0t/8ilHVcIBFUtKiGPEWYhm7YZeTg/3/tvmus+iVSZZ4T4gvOarfEYqkGV9FshuZ+vw5z4r5vAWFiSlMKfGtLsblxewqNrEavPq+PgzY53TdtbRQz7353aI8ktcqIsu4brRE6KeYHn3kA9eKSHL+ncJ+Z9s+0fY5049YL64IhkCpucukPDcDkMQ0d0qjNZ+cpy2z3DBa0laRM/QLuWujyCGxWS67ts3PCA2svlecvF78Vsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9gW6wwryeuZ6FJWimskwKiUHTO1ilUjjC63eeivGWg=;
 b=HIOmvo3nWlcQLacpbuPrj/8X/F2MxMFd0Z1BmrJBbMJg7OowdpBFipecguHdwD0pvbfexCYBCU5BJ6NRj+qs0XoPfLWOs8osHVxkL39dIOGJkVYtPBOcyuLsLV9IkGJ4xAoKx1hCRHkLtXz4jxzg4Y1mTTY4WJvZ62BKBwhFcWKJvnNh8eEPizOpx3lMIz9H4OyHaucEfhK2e1F0A6WqFnRi9hPXhfDjaj9r5vBj2axhvtKnZwHLkoJvT+gkS7pdTlECl49o3Wq8PtQWA+Dn1VuD953WI15u6MU4I/xrt3NqQjpn7dYaNHULzQgzeVCGWUVxz8B/zi1eOWbuZiGUcA==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by GV4PR04MB501844.eurprd04.prod.outlook.com (2603:10a6:150:411::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 02:16:35 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 02:16:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
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
Thread-Index: AQHdWzYWcGWiu6GnSkuraTQS0Cw4c7b91uag
Date: Thu, 15 Oct 2026 02:16:35 +0000
Message-ID:
 <AS4PR04MB933876A424328F6A6FCFD29C889C2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
 <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>
In-Reply-To:
 <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|GV4PR04MB501844:EE_
x-ms-office365-filtering-correlation-id: cc1d2dec-85cd-424d-9e68-08df2a625683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|19092799006|38070700021|56012099006|5023799004|11063799006|4143699003|261009223027099003|18002099003|10067099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 AmvesX40FKgQLxSMekA31Lk2JMiL2xARqSwn0ZpUS7xxK2Q+44lV/oJJLbq6iALU/XxSlN+5rwXUC2mCWY3cGnsM83yZMaxaCZYDKWS9TGXwSlohOItIy98Kj4xv53RwH3hlY0w58J6rFBF2Jn95sCqKUlQmB3hODp9NK9gSkXeRn++TTGvnhHrr0qazJlMbCsXyDRWRKikJww/LW/AU1AdsdenAbhmAZd91jMIUEFzfwtQwgY5aXQ9vsK94EDHjH1KhcUAs6Tr6U0TwZDXnz0TC82bLLvi5TT4S/49pUpE/7CHWFkUpoW9pmNkIlseQAY508wC53LkBQK2Z+YtBv55Lp3lEbqaNsyWLubC6vXEBxLxOP0wDxvqmpklqf4CVzudZih0lrwMZiX02WoVVj06iOqrs9vkkelITnLX7WjiTl2ok3S+mP4mKoeIaf/zXrRGLsHNMvfD0zPDqy2knrBIQnMrJCP/crowc5seet1ad2HaQQ62Wd8UNvA2AfTfVDR18gpDUAIqz+C0SF2Og2amm3TRt8W/KXfXU8xLbINO7s8kjhhMws6yfQJzNzSRzUx1LhatHuuGnaBbE0pg1OBxFH4NbmvqLuz37MghZCE0OBfT/q86EkWIo0hqFog+rWb987CSFDIzrEKEG+J9+iqYAYGDHNcMcSuvJgzbbgMYIogdqZT1BZOWe19ewkgcIrXzX/WpiIxuvQ/l6QzyAbBxe6OU/NIDYDFUUwbVFdts=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(19092799006)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ce03STH+wInOTFdcslqsqt1lJ7HjLGoukGzg2b97yqgw7V1RiR2gILdPMIPH?=
 =?us-ascii?Q?fLyJtIa/ozE1V9y1vDyleXnn5SXcYYwT2kS3aGXKYFbL0n2KOC3jJK+gOYVG?=
 =?us-ascii?Q?E9oqnLqfNWcvWSUB6oWAByuV8F3JhAtiizL5o3l0wRWXS9D0XBiVn9/jNGlp?=
 =?us-ascii?Q?2SIHtF/G3ZHswg5HlRv7pPT3ktktJ8Duuz+Fn2BPVPm9dKh21RgUDtJzY4yL?=
 =?us-ascii?Q?n4glbwk1DWGRpFhxnnPC8bmUP2usxSNe/28S+ChKWNShqFfSYR4ukFO+itys?=
 =?us-ascii?Q?S/OMNbksjwOwkAFByi0Ck4DPZ2gWYX8kBQRTOVkiv8sNmeXZM/BevDxexypF?=
 =?us-ascii?Q?Fy2kJnGmk3lek5wNShTLYEIfJfCGctFybR/itu7efHP74mDpoH54TlGdJL5Z?=
 =?us-ascii?Q?ViIlAIqTzY2kAolIDXRiNfcDGliHxP2pqq6NKxr38MJk+a452AFmLZsvGN9p?=
 =?us-ascii?Q?3Hztozfpx3VMx5qophRHRrC6uATzViWeXNA/DOGOShOk4/6mFkk5YDUXuRI1?=
 =?us-ascii?Q?WVBZKq8Wq6uw5ttGLsOIs4zlBuC/7XgO9PAVbrKxL+DhBxGcFGcrIzDtnUqv?=
 =?us-ascii?Q?zuDKe2utT0y8GGUsRmWSxxAGqpZ/fMB1iRyS/mGnA28+TivjFy2n+TXHtZgQ?=
 =?us-ascii?Q?/bp7yXUOcbAcbzkepjVkg1Kb5KryduyRiOvsAj+rfu8om5uyWekGmKUYtxgc?=
 =?us-ascii?Q?rh8zGc6OQ9tbtIS9W9qT7awqNhNdo8bGz0GHyJfUPtSyqblhJNnsRR7jFAyB?=
 =?us-ascii?Q?KKhQb7ER9yjDvwyb29k75vN6ms9Dw/dxKKOsSP/6oILpdngyY8r5cOKavlhb?=
 =?us-ascii?Q?q23trwv+umnuFjnQ4xt/Ziqr0Ru52OrtXLadfvPDGjCgG+kIcAju18wr2xEO?=
 =?us-ascii?Q?MIFtipKmoGNw63eeLgvMQ9Bw2ctPR3b5rhpDS7Hb6KywgU43/5XsrtDCgRN5?=
 =?us-ascii?Q?PxeMdY14P4/7otUaaukZUOeisAtrPtxyGY/wEGetcp4zwG8n4oApFt5ZSpK4?=
 =?us-ascii?Q?lvDqumgk7oNzkfDSZrqSAUihO7OVabYCxouykJviJABT9kFr8YUBmJPPdA4U?=
 =?us-ascii?Q?4pCJBdZL+AkI3GcWvqKrQUV11GiCnlaKtH74FCvHsEceLVhCCuGHpp7Tzf8b?=
 =?us-ascii?Q?segQixJ3YSYrRaYW88UDYusYRP9NmBv72sJfJRk6DBk3Ew6GaW/Fx7ZQmest?=
 =?us-ascii?Q?zuqcg832SxyYYyAahUgak8tKWkxerdNNjIt7UNcdsYWKPSonr1L5jnjazGor?=
 =?us-ascii?Q?ZvDAkveKEcHvFAqy8fWw/VJO7JJk5Ry+MG5xsT1QtwMb+gkLrSGsFpf2Lg0t?=
 =?us-ascii?Q?pLE5a1CPdvi8KzoCbFwhXUnIVON9yLKz0ymdHPkl1jERq5QykczsqO9VRnM/?=
 =?us-ascii?Q?/7qNsHQdlzdR/2PjOsvaQEA9ltXWMqzrQ2r/29DV78zWusEnLCRDb8ZFuDQf?=
 =?us-ascii?Q?4nWmZs+YsajUNBFFlJGm7td8UEfa4jLZc64CrSgLDK3usExaXcii/aoDBo0u?=
 =?us-ascii?Q?dMfP5UxR370/SNx4tRdtk9Mh/SIk8Sn9czXYXj+nfIaqzDI2zmtSpjAhuklz?=
 =?us-ascii?Q?EGj3HTLRs8VOJ3dmVdA6zCBN554jhayxahgzbw9U0eajs2av+KpgB1q6pZ3U?=
 =?us-ascii?Q?8y4kcNzqenktd5Cl6mHEwin5Zkf+5ltv4tA57R+G/fn1TrTnCl+ABpIIto7J?=
 =?us-ascii?Q?IKtfExKgh7XxnfWIw+u78ebqWQofQAfPynmKsakjua+CBYuJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1d2dec-85cd-424d-9e68-08df2a625683
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 02:16:35.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLHQwyjWJfG9wzXYtYqI5N6WBDFoRU13o8J7Tyb4wOSjlGy/OHFNTC4tP72NLG0h0PE2W6+CznB4Ka9GpAi/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB501844

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> b/drivers/net/ethernet/freescale/enetc/enetc.h
> index d9e91832a9c1..ed5402f1b73c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -500,6 +500,7 @@ struct enetc_ndev_priv {
>=20
>  	struct clk *ref_clk; /* RGMII/RMII reference clock */
>  	u64 sysclk_freq; /* NETC system clock frequency */
> +	struct of_changeset *ppm_ocs; /* pseudo-MAC fixed-link changeset */

struct enetc_ndev_priv is shared by both PF and VF, but ppm_ocs is only
used by PF. Would it be better to move it to struct enetc_pf?

>  };
>=20
>  #define ENETC_CBD(R, i)	(&(((struct enetc_cbd *)((R).bd_base))[i]))
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 71c971618388..70e34ca6ddf8 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> -/* Copyright 2024 NXP */
> +/* Copyright 2024, 2026 NXP */
>=20
>  #include <linux/clk.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/of_platform.h>
>  #include <linux/unaligned.h>
> @@ -932,6 +933,14 @@ static void enetc4_pl_mac_link_down(struct
> phylink_config *config,
>  	enetc4_mac_tx_graceful_stop(pf);
>  }
>=20
> +static void enetc4_get_pcr_speed(struct enetc_hw *hw, int *speed)
> +{
> +	u32 val =3D enetc_port_rd(hw, ENETC4_PCR);
> +	int pspeed =3D FIELD_GET(PCR_PSPEED, val);
> +
> +	*speed =3D (pspeed + 1) * 10;
> +}
> +
>  static const struct phylink_mac_ops enetc_pl_mac_ops =3D {
>  	.mac_select_pcs =3D enetc4_pl_mac_select_pcs,
>  	.mac_config =3D enetc4_pl_mac_config,
> @@ -946,23 +955,112 @@ static void enetc4_pci_remove(void *data)
>  	enetc_pci_remove(pdev);
>  }
>=20
> +static void enetc4_put_ppm_fixed_link(struct enetc_ndev_priv *priv)
> +{
> +	if (!priv->ppm_ocs)
> +		return;
> +
> +	of_changeset_revert(priv->ppm_ocs);
> +	of_changeset_destroy(priv->ppm_ocs);
> +	kfree(priv->ppm_ocs);
> +	priv->ppm_ocs =3D NULL;
> +}
> +
> +/* Pseudo-MAC ports have no real PHY; the link is fixed, with the operat=
ing
> + * speed set at probe time from PCR[PSPEED]. Describe this with a fixed-=
link
> + * subnode synthesized at runtime onto the port's own OF node, so phylin=
k
> + * picks it up through dev_fwnode() exactly as if it came from static DT=
.
> + */
> +static int enetc4_add_ppm_fixed_link(struct enetc_ndev_priv *priv)
> +{
> +	struct device_node *np =3D dev_of_node(priv->dev);
> +	struct device_node *fixed_link;
> +	struct of_changeset *ocs;
> +	int speed, err;
> +
> +	if (!np)
> +		return dev_err_probe(priv->dev, -ENODEV,
> +				     "Missing of_node for Pseudo-MAC port\n");
> +
> +	enetc4_get_pcr_speed(&priv->si->hw, &speed);
> +	speed =3D enetc_phylink_match_pseudo_mac_speed(speed);
> +
> +	ocs =3D kzalloc_obj(*ocs);
> +	if (!ocs)
> +		return -ENOMEM;
> +
> +	of_changeset_init(ocs);
> +
> +	fixed_link =3D of_changeset_create_node(ocs, np, "fixed-link");
> +	if (!fixed_link) {
> +		err =3D -ENOMEM;
> +		goto err_destroy;
> +	}
> +
> +	err =3D of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);
> +	if (err)
> +		goto err_put_node;
> +
> +	err =3D of_changeset_add_prop_bool(ocs, fixed_link, "full-duplex");
> +	if (err)
> +		goto err_put_node;
> +
> +	err =3D of_changeset_apply(ocs);
> +	if (err)
> +		goto err_put_node;
> +
> +	of_node_put(fixed_link);
> +	priv->ppm_ocs =3D ocs;
> +
> +	return 0;
> +
> +err_put_node:
> +	of_node_put(fixed_link);
> +err_destroy:
> +	of_changeset_destroy(ocs);
> +	kfree(ocs);
> +
> +	return dev_err_probe(priv->dev, err,
> +			     "Failed to add fixed-link node\n");
> +}
> +
>  static int enetc4_link_init(struct enetc_ndev_priv *priv,
>  			    struct device_node *node)
>  {
> +	bool dynamic =3D node && of_node_check_flag(node, OF_DYNAMIC);
>  	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
>  	struct device *dev =3D priv->dev;
>  	int err;
>=20
> -	err =3D of_get_phy_mode(node, &pf->if_mode);
> -	if (err) {
> -		dev_err(dev, "Failed to get PHY mode\n");
> -		return err;
> +	/* Pseudo-MAC ENETCs are described by a runtime-synthesized fixed-link
> +	 * node rather than static DT. This covers both a missing OF node and a
> +	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
> +	 * by the PCI core and thus carries no fixed-link description.
> +	 */
> +	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {

This indicates that the node pointer can be NULL, but
enetc4_add_ppm_fixed_link() subsequently does not allow node
to be NULL. This is puzzling.

> +		pf->if_mode =3D PHY_INTERFACE_MODE_INTERNAL;
> +
> +		err =3D enetc4_add_ppm_fixed_link(priv);
> +		if (err)
> +			return err;
> +
> +		/* The fixed-link node was spliced onto dev's own of_node, so
> +		 * phylink will find it via dev_fwnode(dev). Use that node for
> +		 * the subsequent MDIO/phylink setup below.
> +		 */
> +		node =3D dev_of_node(dev);

Based on the implementation of enetc4_add_ppm_fixed_link(), the
input parameter dev->of_node cannot be NULL. I'm not familiar
with the of_changeset_* APIs. Will enetc4_add_ppm_fixed_link()
update this pointer?

> +	} else {
> +		err =3D of_get_phy_mode(node, &pf->if_mode);
> +		if (err) {
> +			dev_err(dev, "Failed to get PHY mode\n");
> +			return err;
> +		}
>  	}
>=20
>  	err =3D enetc_mdiobus_create(pf, node);
>  	if (err) {
>  		dev_err(dev, "Failed to create MDIO bus\n");
> -		return err;
> +		goto err_mdiobus_create;
>  	}
>=20
>  	err =3D enetc_phylink_create(priv, node, &enetc_pl_mac_ops);

