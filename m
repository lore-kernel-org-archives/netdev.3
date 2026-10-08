Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7B3A59BC;
	Thu,  8 Oct 2026 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429883; cv=fail; b=SUeME/BC138o+PLpp9S7NJLqV4aNT2rEhTp0zBlyKEwNBxE38i1oEur7N65iIoZFARLjgqpfwCby+wgbsablo/K8ywMAyrF9WlsfJIQOMy1EOmQX3CyUSQbUFgYXfGlOxi1aswuC8MJMKp8MqPUeR16E/J0BDP3vhWA0zZbYE58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429883; c=relaxed/simple;
	bh=+5mdY7uYE611GwXfjDzDj71IWojj6cBMQhv7P3+3JxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sn0Cb+LeASq1xspbQ8ZupWqAj5oJvJqTmP0sqYClEDvrZj3rIpzhFuQGbxhpWfvs6gj93Oj7JVzb/+qGWCg3682LXKZCDcCG1pIakJnOYdkuW6xd0CbkMMN37cjrqJxWsjnrYUkSiGmh+NyPHkML4TUedOISvsO+j+qDFf8Xo00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RXaol/WN; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RXaol/WN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm6pgtoz9ce9BWJQTRgQA8F8A5pg4nCl3q4zNo8CnvikwPg3WAAOLurBhFiQJP3IgpT6l2ZOlbh4g+ZDUfrVZwUNv625vID1f2QWlv1tL/Q8yxULmI6EMthDvYwd4W+nWHHwSLbe92P9pjvoOuw+788L7l6g5b243I2G196G4i28GkiZMadXC5Ar64YYn16iDHsIF7ayh86a+1olD/p/7XguTR6jU+z0BDZplCrx4ng6K1xc1zNReYTMw+NNmVTtQcdnnPNNoFrU27tWZdX1jDND20apIym8Mpztp8JVuGTEGPxlaXU5s97imfZpm89CuZQO6eZIL5k3BAM3C1fjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVS5SanidLuYcHRMBiB43cxb9GuIOOqJznoZEKeI4go=;
 b=Tj4UjWWiLuf3QwN3O5dTF7UWwADzDMDuaU5fUgLg/Q/bUvmSEVbwkX/IUFTELzXh8tYi8da8mKMn1B6d0w2pVDp4KKLRXhh19isvflJ6rmkVRQndMMykG01SccD9S2Ks34v7ENkFaM0apiLMnYOhkMGLSgFM5dSOqRY5LfxJxLSckNo7I9jNIq/GivCMQmSlFLlM0xCu/n0uulrkshV9rlEFQQfz/SwZO5N8OvfusvD95dUbeSg6d4dUquz7IZrxG1GXd+StFeVrOnO3yKPcRrEvh+ZBMSW3NMyhj57q62H8wAFHtlR0VvB1Bd+cJD8AgXM9/pDFAC7RGoNpJ7IzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVS5SanidLuYcHRMBiB43cxb9GuIOOqJznoZEKeI4go=;
 b=RXaol/WN6jUd5Q1YOjU2r4A7P7iG1Dld5zRPu7o1SWI8bbELxupZ1x62A/JRRoqEGzlLz29zJPKc+J5C6bqQ7Ke7o/7gBaCFricZMtq+htvfI4b6aU6NPtfqwB9SIZvjZP9m77ZzkzD7bFB8v2k2Sqi+lYmrTcEy4flDH7g2v63RSCQH9CdZIkYsPb/hG3gIrxW9ox4jJudm1RoHVrpp0fwOmh3G+9sT7CW7v1iXtZv5cdIjD5OINWnTFq0CWtLaEoWF91x7Qb8NyaTA0iyU19eNmSGuErDnBUYjB4jeP1h4jLSyRdprulyflmFn5o60fJg5Cdmd7nxkTLUdpQvzkg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 03:24:36 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 03:24:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on
 i.MX95
Thread-Topic: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on
 i.MX95
Thread-Index: AQHdUfXK300phESj5kSdvLl0aM8yprbzAN4A
Date: Thu, 8 Oct 2026 03:24:36 +0000
Message-ID:
 <AS4PR04MB93382E107F5799E9FAB9010988932@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261001223947.60189-1-marex@nabladev.com>
In-Reply-To: <20261001223947.60189-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AM9PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: b4af54ec-3327-4558-0827-08df24ebadf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 zdhZ3jOVN7TnRsr+Yu2VQTJPeZZ+0OYIFNfatoWIV8DxJeLodkVntUUUlq143n8QEJY4mVLiZwb4JYttOjgcC6VB6nOYAIr30en6Y5OB6xkwq722UxQdAJe5YqcqGWTHzd3Dm+KEzkxN6jcaH01o3npkIZ5mk3jk7ph0XmynO7/m69Eg3uwGui864IpT7FREqBeXM4c8tdRSzi2Zzfxc9uta99IcerRiNndauG7E3Kfl/JXGf+zk/ejpPR/od6Vvn31QwwSpLr7VF+otRQcjF1ne6yvG1TqaPww0Up1O7JLA9GXUEUh4elyFWafW4walqNRqyiZDH18xa/YPbgrKIu2RvILGL4Lq64BVLxzS2et2kO0pAhi/FeSUNCDX/I4/s8574syHrFDbplBNwysx+tc0JAn6sqUmp0241xwn6DjpZ10soWS8TRuYDQifxxlGcVZz1zXIT1IUajhJtwuTQceUOzSrv5YtneHGUOQ3Xg57Gt6cyTR6zzc3zqU5nSsm69Ha6lWg0E+ab2qZNLzHfUHyM7OEdu1VZ8PitJbzOZ8FY7v3Qmx85BNiyUEHSVSyWQ3n212LN4NHjlPZV2XEbB/x3CMQo8O77Hk6a/RXq7njweML9IZyEjJPV7nyoHuBAumwtZmplGoLmGLXKcYAi4fEJJbHe3IfC20drais2YWdh+VRWDMjg+ccgzzvzosqNNsxGvARY4huL6FaWEL03mI07T89up4RTh80h4kY1wQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WVnUlfPlX5pMm+DNRlXQUZf09T64+PZdkAw8+eFK7vRy9/nx2VcFCPFBuRr/?=
 =?us-ascii?Q?EKDlTEQYi6m89f6kK8WnDrgcMcZE3i80CuPwLQiNIn8BiOX47ctXT5igVVHt?=
 =?us-ascii?Q?YoOz1tlxYMWhyVUlWwqOmMJ4TjXxO44A4dUEvZ+UvfBwTDKbp2IR0dg/7Q+e?=
 =?us-ascii?Q?FcxFkgAUtkYmhyj3Hlf1mPi9QqYNln6m79yU0ZhkbwEebjOnU634aMArNNcD?=
 =?us-ascii?Q?1FkD18MB5FflPCtyforTYuooyt3KH2YlUOOZ/y5yV6M43pyxZQK42ZLic1Xo?=
 =?us-ascii?Q?nzrcEWFEzPgh8eOxu/WO40csToEl/dge3waX0tfbaunJeGGWtAzNLOMG1BHv?=
 =?us-ascii?Q?x7DF1cSpLn2w5YMUwYs9qJERTEQtoxozno9rlDGuXGw9+UKcs9VhNvB+Bslp?=
 =?us-ascii?Q?l5NVINErXNWTA8+H9w8g8JVZ+7MJTxfja7Bop//PYvvED6lTLHPXztpjIYAq?=
 =?us-ascii?Q?Ulrz2BayTFiwI03gWECMXq/gPPAi1s7nxqPlH3o7vpY9IjKO+tCM4hMvOS1a?=
 =?us-ascii?Q?QxuOcpyBdJ/4KtPberUGDrxyb+W3RsbYFgbrYZkdm4wcqWRjtt9A8lqbkg8Z?=
 =?us-ascii?Q?PHCB+SmD4xt49JBSi2tBeOqqbcSj0ZxEQI2wEfCd0MSLx3CgOMX43jiTZ2iu?=
 =?us-ascii?Q?noAceoymSrmid5kmItEhGLgMFYOJgis2x/yAZJr0UKMOUBmUANrBSPFdfFem?=
 =?us-ascii?Q?0duBWJpSDbujWQ0J54I5SaSL9FeAGs3e1kn2cFu2p5pWzGocEGWOdR+lxahL?=
 =?us-ascii?Q?KGAcGzXAjgHM4oO3/+bsUOqIlqyvUONItYlNCuzttg3mlB2ad0pz0ogmubuT?=
 =?us-ascii?Q?ikR6TmU9LAmhMgxpTeqeSLr974WdSiw7xvbe38BsRy+TxQx1L5FTZY3r66/v?=
 =?us-ascii?Q?+jAs+xMhwZL8QUighRLNlsBv9dOyVMq4+AeQFaGeY1vH0cQRVJ22kD8bkTG2?=
 =?us-ascii?Q?5tQHaTPZMm18gqgtD3ALEa1q0af+c77IAJEoapLakrJ2r0j9ClWPNDie86R3?=
 =?us-ascii?Q?+dOQvYwKexMEsZA/FPaVsUM6GqKk1v4UEOMqkrM2HkqpL57MQ8Abo5kpSTke?=
 =?us-ascii?Q?jO479glliCiXxswt/91a265wQT0OcXfRpuKv+HdEPt7+iwAjGNF7UEcYm5pZ?=
 =?us-ascii?Q?Qm+iFaEOD4dkKtXQcYpEIWoHYAZ3bwRkG0OQxl7LTuc6uqGpFf67IQM5K514?=
 =?us-ascii?Q?ducK+DnBmhdrP9D7RlD/v/G5ha8Z6yUUrw1oo3V195m8PfKxfceQZUaHyGy4?=
 =?us-ascii?Q?f3VpEgeNCwPhZkV7JGvd92qYsLFMB24ldoSf6sRXHI7i9F8bZOJy4zyIcYTd?=
 =?us-ascii?Q?FJkQ4X/OaGZHHK7fRqjZltyKFrD0WIHpcywXJq0jrW06f1BB7X+HQGX8fpDY?=
 =?us-ascii?Q?LoeWfPtV2iYy675cY/GlW3DDivR88dT9GKcjc9Wr5vJPr6pjcrYb/pE5Wp6+?=
 =?us-ascii?Q?vZrp7OqFHdWr2A5mlR7CqH3oMjJs8zCoVmk++5cYpaSoz63lIzeljY4IRj3Z?=
 =?us-ascii?Q?FWLbp21dD1ztdp/rYECYpDt/ijGJbtBqlhkr2VkAezW+Ft1Xn9R9vL3hwXPA?=
 =?us-ascii?Q?y/bWsUxv02UQ2Wr0ypt7YtrCPP4QbXLLLpI/HB1NRHaBX+8F3tyGrPA1F+8R?=
 =?us-ascii?Q?+0ABY3WTjN1sXiUB/9PqmHGD0RJPfzTk0jRWfAhMXKUXRjFhYL1WXaJMcVGr?=
 =?us-ascii?Q?GkP34HjVpyvoBx7Xb+t3aTeF/fCSuxn1Vv3RWfKg9dVFw4Rn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4af54ec-3327-4558-0827-08df24ebadf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 03:24:36.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzSn2Eox1+QDTDW04sv6/ATsvpvXLyiyvAhMC4TJiHvUCpYjU0acSHjYcLMDSvfIoa10secT+TJD7G56BgeprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570

>  static const struct pci_device_id enetc_pci_mdio_id_table[] =3D {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
> -	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID), 0, 0,
> 258 },
> +	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID), 0, 0, 66 },
>  	{ 0, } /* End of table. */
>  };

No, please do not add the divisor to the driver_data. All NETC v4 devices
use the same vendor ID and device ID, but their system clock may be
different. So the divisor is different as well.

In addition to EMDIO, the ENETC port and NETC switch port also support
virtual MDIO, which uses their own MDIO registers to access the external
PHY. Therefore, the modifications go far beyond this.

If you don't mind, I can add a patch set to address this issue later. You c=
an
simply revert the commit 587acb86d646 "enetc: Increase eMDIO MDC rate
to 2.5 MHz".

>  MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
> diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdi=
o.h
> index 623ccfcbf39c3..7dfd65622c95d 100644
> --- a/include/linux/fsl/enetc_mdio.h
> +++ b/include/linux/fsl/enetc_mdio.h
> @@ -33,6 +33,7 @@ struct enetc_hw;
>  struct enetc_mdio_priv {
>  	struct enetc_hw *hw;
>  	int mdio_base;
> +	int mdc_div;
>  };
>=20
>  #if IS_REACHABLE(CONFIG_FSL_ENETC_MDIO)
> --
> 2.53.0

