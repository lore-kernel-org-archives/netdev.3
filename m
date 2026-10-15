Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF81FC0;
	Thu, 15 Oct 2026 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028549; cv=fail; b=cRbsNEG9lEh8urlU8d2QGksj2Vj3k0z9KJ7etmuerCidxTazQ2ZnhMgHpx7Wq7PRtRePjtiD8vdm+Sfo51IoUS1XQF0QOBSsRFOTsQ2c/gaaCj+ycFOZHGvFm/6ytF9CGaxYzn+axVOJ3Jh1Zp/hngmV4BGPxCCIYP1DSEjP1Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028549; c=relaxed/simple;
	bh=XS1MbT71MeErVPwUgAlzZwqfQlvI+VUfRzj76d08Mac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4SVKFPkI819xfeOMQKebg7+G5/LB9WLFykLllbUTcTvKf3lRb/Hsnk4YB0t59GyJcwl8qvXTSS5hX6gDSJqD2+s3DBx7KVkrpxnNVmsoWMH2OliKqKY3cVSS0OA6ua9W/Zj/iBNeb7HHVyI7C1j5B35EGUzOmeFAq4r46c+imQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nweSX/Cn; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nweSX/Cn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8GT9/u3zHzfCeAjJ636Us0KlskKoq2dRMOJV+MotQA2e61pSj851iRFSsWz54dgYti9CQ8ZJjzwiHhaRreX0Kzn3v3aeSMmpaly7FwW6DhVdKipow8aKvhT5W3WXXAYzPlI3rwIAF71kq57VK8W1d9fD/dy8uPpE9KnMdJjOlg6VnIFfLlnSJLcRzZVEc9Ur7+X7mfYCRQ7YlwuHR1M+IB64K19ueRkh06fXrFrqUVs/xXhFuGIMM0ALQBqu8MAvvQds52RlZa60bftIgI0LyDSjHKBeXUH/zdG3f1JccNJgfha7nqwoYmySXE5xw0rC9/CPh6RK8pLwaXHkNFVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz5r6NE8c/Z/JxPswj8XRsAzjbbtlDhYnRGUcUNORrI=;
 b=lrq+nc0iXvrgb846N5inG7ZeqpO0pVQZCALFXQRU3/Pg5IZCy4XDDI4PgImuLMLM3e1R6DvjO2VcTljedEDJJYVZt1nUATtDFhp56idNRBmBRUlf7/T0GUtvjP7FRsFpZISNhWk7MvRMrNaPRu7A4B7goFcdGH6c6zzzCpNx4nzAj/kvpaqJ7NbT7pP7fcb+5gpV/t8Ga3xRGAjK7qc13Hg5zTTs6DygFuqRfy4xnjRKU6hfzdNqE/BAQzZdvl5Ja3YVK/6lSEmRqZnNMqiBd2VF9jzm6hmK9ONCVMW9pIIKee6wWEUyAA3Qhx6dJeVCBpTKhFvJ7MPxy0Il0R0iQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz5r6NE8c/Z/JxPswj8XRsAzjbbtlDhYnRGUcUNORrI=;
 b=nweSX/CnuCMB3Xefgv5VGqAax/DltoEdU2yzRsnYyB2b14TIeBONtzjTDU/404qa3A6RtyiGAK143ZveWRwb+UjvCAVS6mZT2eZW/KslodBrgQbhnwaxUfE14RgybQU5BuOg0evXDqRJ02CcGwn759TxPax2alyBTC0rsgIQuAFEuptoOZ/fjJHnmn9vco0DpOMWXznAFzPArMaF/vgpwvCn1YSiLLCRfx8IJrQ/TOGGIAA6CKZSyPK07WjUVWl+SPi70yoPBwfLWv2nEDtWNL2FJTiOIP2F1sViLhWCpfsaOFH2uvaGBD9hzqNPG1tRivH6p1FfVEiptWrnvOhm1A==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS8PR04MB8214.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:42:23 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:42:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v2 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdWzYXZeZbpCUZ5kqiSxB2ep/F1rb901Fw
Date: Thu, 15 Oct 2026 01:42:23 +0000
Message-ID:
 <AS4PR04MB9338EE95020485A9C5C45BCD889C2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
 <537a977b10b3d76c30b1f879f423bde4fd6f42f8.1791908694.git.claudiu.manoil@nxp.com>
In-Reply-To:
 <537a977b10b3d76c30b1f879f423bde4fd6f42f8.1791908694.git.claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS8PR04MB8214:EE_
x-ms-office365-filtering-correlation-id: 84bb843e-fb67-413a-8e08-08df2a5d8f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|19092799006|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 P44pI8A9zJK3KIp3fWcYTZ6NIXoEPLSrTocTmjhNyZpox2Zp1Wo6bt0YQ0iozGI6rZMWCumzEBfXOmCD1ddt4zpbeX4nmjGJK2k2w7j4KJ7jttygjd6pQ17xLQff9c3pEed33vqi5wQEaIH+9Gvm5DY0j6fhKF6l2wLxAhUe1zkxUf1zgTooLfQLjzL/78hfQS3fXbRDwipj4Owvl05IOH4sC011u89UAdQgCK1i/tLCW+8Mf2LjiMZJXrSzA7LitPVarDMll3Dvo0g74gqmxmQ3HGN4x1x+GP0lbS+Pujf5351isDrnu8h/Z1JjsOVqefxokvM7ig7sf0mtE7J6lGn+cZbgc08DK5rv+tYaEDiyqIRqdBSu21z5Sibw2IZKeIZtsWvo5zu6h+BikjOj+lJPvn6Q0pJnp6jXkG+QPeqmR5BhARWAVlNMdHlG/cqddCaeWg0koJPoliR3JmOFnsCF0gwY7PpsBODsgQOh4H27arQuOvYI2NeNngkNpdcgcQt5NpiK7xV3pgO0egSEpObx5P3L/sDRA0Vd7rhC+yRsXaH5h/Kmzi6JDmqAwdFmkGlCBHv7XBUsK55YabrQimahWBOym/zGPBiqeY0q4iWaVE1QXfSVyMX9RUDYsww96A5ELRMkIis99rWZ4Qpi5xxXa169ziy/EeNwPPGmZNu1gcYiGQMNFSkeQ5zKksAnIu/ipcyrKkxD9B/hEJRjEvQmeTSqwjf0qH0bzYPHZjk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(19092799006)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iCzQe6aFL/jEror3+XohTDmwH3oUg6HPi/hblZpyP5rAFhNyLqEKBxfDYvyT?=
 =?us-ascii?Q?rMcFkHLzmJ7Y8stAtjR6eAFJvhxBTaTkw1foX/SClnbS9qIsd017mSJtcV3k?=
 =?us-ascii?Q?ffCAjMsMng0iGScPIoaaPrqxz2E/p9GZGpjDug6wzfgLTrmpJ4rOFV59VbVj?=
 =?us-ascii?Q?pNSgZXuGGl0npbNMeJyAe13+2IMnazC2H4pV9/Oq/K9IuMbywmGwJC7vlcR/?=
 =?us-ascii?Q?ZeKRl4Ce2Myj5f+rN6nfgfnq+nrI2S1uLNAxrOtf8lQ4YJnFPF2ndXELb5PM?=
 =?us-ascii?Q?8xsUQSHxWIzbTrRZoE94bE3Cv1G6ZdPiQssR2lslTNOg/R1dGscVjd4Y8kWL?=
 =?us-ascii?Q?NiqVUVyPwUyRkEcNNajaE4LdwM1vM1UQFuam1t10Q1wRBhtmSs0l8dB2nraJ?=
 =?us-ascii?Q?Y042zQ7DfKTmhn7h8hsFua+GI6bN7W85LeH/Tp0QYYCNX2SjFhSAOq/Y+j5A?=
 =?us-ascii?Q?3GvzeRVCm2jyEf10ohfWGKc7HhZ6wjQnKUm7o65fT5yNxOokIwM75vQ8lJ8z?=
 =?us-ascii?Q?LCq/aBQTffUW/cV3gEfFo/AIc6TqCqx0oQovD9Hzl0LAV71pVM4tzMmiGtTH?=
 =?us-ascii?Q?CT3e03AgOfo7ICQEe15RUtyAYnt41BsyaOIIWAG1UDCc4afsIMxcgrzbliD+?=
 =?us-ascii?Q?qkZRZnz3zJpIlYhkf/SCYX71pEPFA1U/0fhdZ7iIM5jZOroqOPAlO/o+xrXD?=
 =?us-ascii?Q?0Oe9w6OVFV64/fjYJjMXi3bNI2P4VeYbwuVU+f8K6SgljAWa8M773yJG0/T/?=
 =?us-ascii?Q?BxhOzSStSFYpzmNvRArw3YiI/frrh1as+aotTUyqb9Zjd/We7MIrzH8JDibX?=
 =?us-ascii?Q?vH8gny2Gt0SxTyokNor3RJ9V9jdm5m/s8EvNwjN/vYwYlNPUkVoXFVbIsNbM?=
 =?us-ascii?Q?D5Ycv1God9LnDXJw/ZmD8XRla/5M90hIl1aMxhkX1Lu/5wLXDlJ164QAOEyI?=
 =?us-ascii?Q?8JjQizoAfUwiR6HaaD8Q/AqBW0hWLGx6hJd0p5XXwp2lvmFHhS4AIcsTu0b4?=
 =?us-ascii?Q?EbC7hvz7tSq9LOOu3ZREgMfuzw+qkQ7RUS9HGY+/fc9pTqHmdA2nnpvgrL6i?=
 =?us-ascii?Q?Je1a+521karhv5W+TgRQlNHx/9dsmZeIgXKjS7X12EOELIqoMpWIRRkHSyTA?=
 =?us-ascii?Q?tNmtrunIh5+70YHnikahE9lddCDApAKKOcVzLWz3gbI1zMp9twRPzCKuNNdl?=
 =?us-ascii?Q?oF+ZQTWxr4ZlEMdyKvQ/YX2eYd1lA8MKLeFTi3M/olhzCbAGnaHUfTEqB1MJ?=
 =?us-ascii?Q?rz5ewFx3fhIJRb2xH1eWE01bEZSelXvfKyis5DKwpkLsGF/fcBWPaVv1OZEi?=
 =?us-ascii?Q?OxoaILDzl4i1xJ8am/lQyB2xPTCWvXAuwoHHFmDVH5Hdw3ykMJmnuoIQZONH?=
 =?us-ascii?Q?APTyfnbXlyn7WRX/88er/nUFCNn1Wol3mPj6ec88/rIvnCzmvfpc+ntozvxZ?=
 =?us-ascii?Q?ercQ5wcR9TpnURqFP0XUoNIylrS6TpBAG7gEptbGs6rm6Ku6Z64rdY4WLEWf?=
 =?us-ascii?Q?EIWqIacujOyr05GDGsvVH8dw/w5+7jXrxszZLHnvooa/QMP3+G7XdM1rus4C?=
 =?us-ascii?Q?rSmBZNYbNb6evIyr+mesFisyO5eSq8CzvnQnLptd0RmnQuSwjcMmOVWUx8Sx?=
 =?us-ascii?Q?GvU2+pFZAK7CcKAEbi9i1VJ6pXRAz2EAkTDtGkdKbtiW2clg9FREdTcXlIvC?=
 =?us-ascii?Q?wqpZfZxjFXX1EnMZ9d//0YSN2j7giLk2oWn3ChIhmDldjZDn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb843e-fb67-413a-8e08-08df2a5d8f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 01:42:23.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vstDyNChjTG6OnBGhPmMw6u0VN8g0wBPUfXEQXPodo6+MLHuuzqdx++kKRHVtVJjLV6/stDZaY35lKdnErjtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8214

> +	{ .revision =3D ENETC_REV_4_4,
> +	  .dev_id =3D NXP_ENETC_PPM_DEV_ID,
> +	  .data =3D &enetc4_ppm_data,
> +	},

You have reused driver data of the i.MX94, which has a system clock
frequency of 333 MHz. However, for the S32N7, I think its system
clock frequency to be 500 MHz. And the system clock frequency is
used for DIM. Therefore, you'd better to add the new driver data
for S32N7.

> +	{ .revision =3D ENETC_REV_4_4,
> +	  .dev_id =3D NXP_ENETC_PF_DEV_ID,
> +	  .data =3D &enetc4_ppm_data,
> +	},
> +	{ .revision =3D ENETC_REV_4_4,
> +	  .dev_id =3D NXP_ENETC_VF_DEV_ID,
> +	  .data =3D &enetc4_vf_data,
> +	},
>  };
>=20
>  int enetc_get_driver_data(struct enetc_si *si)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 2c9d9042eb0b..64789bd0f33e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -414,6 +414,7 @@ enum enetc_bdr_type {TX, RX};
>  #define ENETC_REV_1_0		0x0100
>  #define ENETC_REV_4_1		0X0401
>  #define ENETC_REV_4_3		0x0403
> +#define ENETC_REV_4_4		0x0404
>=20
>  #define ENETC_G_EIPBRR1		0x0bfc
>  #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
> --
> 2.34.1

