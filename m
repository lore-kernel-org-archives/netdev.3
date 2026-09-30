Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061E367B8C;
	Wed, 30 Sep 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739662; cv=fail; b=Ho9NS2Mf/Dg/il1eLtQxmiLvv2QFwBg4AUJurVGiVd06ZCM0kGc7tktERIsIfswZEtp8eiHqabSocX3C2VRSGBSVWyKxCpP1rq5VI94/u40AzQzwLUWKjJwYCKpeQaU1a5I/8Y5/+8OvtvBlJh8lXiphV6s9pj1vovthl7LhOBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739662; c=relaxed/simple;
	bh=sE/1Vt0OKhH47iXsZUwwbgoNdcszfGPuaw9SKGMV2Aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gcC0bokbu3go86OJpwBTiYwWoKBVsIzzBnZhCnt7z0dcnV2QzShcyGovwI0h4P8FOAs3yfikJJxFtyhYkJCrFI4Oim2GAou3BITh2Ff3EzcD4zaxEjHgUdOTf43acqweS34wM3draRw63MM4aY43nzlbpZ60ERmKKXv/zqMr5p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QrQbso+o; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrQbso+o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgYp5Hw7tZqAkxbvFp8Ugw9ucXy5CYY7SnaFDQrj7Ad0Mt+VePZshKXOKeJ+sUxhOI1aQkzKAwJollWFhcydbJBtdHmqt9n6EJtMVwuX4KoGLVFCULaVgNGUdD09cSKBXDki0x+OvAMkUGEkaW/Lbxm4w+/lUz88Cs/IwjZooyx6ePdqperraVqPg2i6OYdHILj7OVa0BMHjOPYPy19JpnPNLy1og3jRGvFCuIN7UpzkHyaaY1Dots0uCJMWkp6LIhYJPxfooY3pEQGuy+VNQB8KX0LUEvaQbBSu1CH2sQ/knFntiNHt4n/Xt6TuenicORlPMDplKqfRIRdvYtuTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FooK3/iMVtgeKe+RI4+rQd/4WBKXOByYRWb0U+e+wG4=;
 b=vIXzdj5m56fMeySVp/bx89UPl0HegWOHuBMcvmKadvgj0ly6cHgICapF6ey987XUXSoVmzPuyTsT9fnYXu4nLuz1Ef5A8ijnmkC5GecS4YmR2jflHxS9mhLle1z87Ont6b83NBkkMliTvGnq9XyiN3CeBpxKN7wUw4SS8gQ+zrkpNetxQRbTz4bGLVT38qQnmXMDEj2OaLuyUkhIDSkTCUmep1qvuQlWzW+rp0XF8bbRjKJTnijrTmuQmKHEw4Exj3jaQbi2G/8iS37tRkWL6v9FCIm+Kel1xUVZOKYFlnDub3Pu4+75wMeMjYDHoDh0gSdH5QNwh8NKT57giPp+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FooK3/iMVtgeKe+RI4+rQd/4WBKXOByYRWb0U+e+wG4=;
 b=QrQbso+oQ5ZL4D4rcjEobDV1xks85kRkIRga3V2ATUdtbzSyw1chuLYSmKFJJwxTf7TGfV+R6paD54BYMYJhrDGCjVgbl4zOZr7SisppZMHkRKyxxURxXyQIp3ln4QBDUcpqJF87FiZU9EOJT8j6jyYNF0HXDr3B+ez6sjrYuKqlV+f84eny10Nhs3ygcZzsXxNR/jc9O+IR7v+Qa6x15dfYvNrJEdz2ZzSn2bl9SDoF/Ft8fEsZOz/dOpxQA4U0jVJw0ZVYO7wt8S2qHPM0mf4nR4IUkJ7di+XSx+lwdB7JX/ReRpiRAt+/FzL+tLZEZFVtZ1LTgu/UIGSuyQKRuw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS8PR04MB9141.eurprd04.prod.outlook.com (2603:10a6:20b:448::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 03:40:57 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 03:40:56 +0000
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
Thread-Index: AQHdTE9m1hutRzwLFUKmfktoRBJfE7bmds5A
Date: Wed, 30 Sep 2026 03:40:56 +0000
Message-ID:
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260924180607.60932-1-marex@nabladev.com>
In-Reply-To: <20260924180607.60932-1-marex@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS8PR04MB9141:EE_
x-ms-office365-filtering-correlation-id: 084bbf6a-24b2-4e9a-7c52-08df1ea4a304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 jmh3HfFk5Fn3EwNWAmA51efwnhGm+ifhWJ1R7e53mXWNGJxl8K8nQSSBXWyqsz0L8RloRMKPQc1X9ih1JQ3Q3cLCADDq6v6QQ1k2/XfgejJ6hAdf78Kdy52WObdhtsnQfp84tpQgqaQs3y407csTxjfxdmZ5XqFtgYCmJesv9vb7QfAa7n11nii0X5TneQfAW61IovNTrKS7Gg7O+8qQAeJaByhothz3kZOEjTwF3HE3wHyi5jgOoT9cpHMOlfyug67gqZRySNgY7CJluF/VHTiJ2DIdcwPi8o9xEeZlEa5o9Now5EuQJyZkEfGiCChHeIOTlNFIeyKQm92tNex4ZMvxJfxLFqKzYtI8aEYBN2qCfmrLW1X0XbMcRVNF3Hw38DJNrSqZJrZ7S+ew5hr9BtlphdioidZ+nzehn3rTnnor68EgZ4GDqVfVVTu7adP2jj0MAonptFFS+y4puxECPX++LydjoYbNzC1Quf61GGA0bstL34nkBEwXcKRf+Z6Eahc+XH6PwdCYq1W1hAMCykxtkXdLg++EaKI7aPrcSGstOxf5pWtpYcqBYeKDoPlHnf7k5o1NpdQ2hht9u6q0ybUfkSkuZO1EAJaBccysy3QZL05212gtUd4y4lXf43to0n1BnyRnoUH/0jMusg9WzOp7sAFGTzRSSgJYV9RYAIG5HrAKNep4qIoAmcVYnuBvVdq6J9u8Peo688C2JLsw9oiKBh6/NOJ+2abMeL5VIcQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WCtDvc57U4xSKvfINQVop4tqxVSBKX+WAEeNUY2p+s/aN+7GO7BkGfQLp4V1?=
 =?us-ascii?Q?4OCaShOYanWECU6Q0Z6NynH2qojidRHPq+1+v5cK0RMG1z0lnuLZgndBm8I7?=
 =?us-ascii?Q?HyaBstDxtWS4gapJUiE12PMM3bOaOis9oD46uHBQvN7FjKwahXSC5coeOXKZ?=
 =?us-ascii?Q?9X3R1PXpHYlcJO1svfHgCYRp+sWAYeX/id/F/Jxy5KHptYAwu+3QehICG6NC?=
 =?us-ascii?Q?Gvf6s/8zw2guau1aGEPNWsCZiMgF4p31p52FqLcWnFXH0zt0E3dvfKHjdhXu?=
 =?us-ascii?Q?wPjb3sH+1mcqiB+ymLPvEMBDmirXo0tKgfmGarOn7Wpbr1zc3KTU+KJ2qkp2?=
 =?us-ascii?Q?gz/hF4NnpYpRiKUW99q50oJq/c4/r1bxaSZnqzdtZGpvnNIv9TuptAQxptQu?=
 =?us-ascii?Q?w+tlSz8JAX91wPL42gjjZFsly5GvbdbyiMgV88IqjbVqUDFIykNvbwDlOKX0?=
 =?us-ascii?Q?F2NAZUqznEL3uDv5Z0sTdxNV1SmE6BH8tGxwzEj5e5HJkRjynm526WmeQIkp?=
 =?us-ascii?Q?kyLs4CTyYwVEHhNY1LtqvTXSB+2SytDm1Q6/RwiZMp0GIjKIdRWoh85951ot?=
 =?us-ascii?Q?REMV7TI2m4O5EQpRHCUH4GCYu5na30wEx8mAU50dz+4qfad2rMR2X3Ppccim?=
 =?us-ascii?Q?v+2vJVVig21Y+Uusuhi3X3BWE5OUckC4ao49RecJx75lijOHKz0N2lzWdRQA?=
 =?us-ascii?Q?ypMF4BpkydrXTlvtMDZV5qeObCOjSz/msu7w2UoIafVjikx1gGILDyqXFD1f?=
 =?us-ascii?Q?LNsy+ibWzKDKRFia0nWmtbnMKoAiMbPe/2nPjXA/H9sRc9xuO2EDvJWouAWA?=
 =?us-ascii?Q?pRQ6dW5Ybp5mCvZiZBB1/dNzMdi7XQTRSYIpkAtwJyXOYcinWKdP13pqJ01O?=
 =?us-ascii?Q?KC20m9QtKKo3UJMWEs+zuvlUsxyqIYHXwQk4wXv7Ntqer/b6OjogHN6bj8rV?=
 =?us-ascii?Q?Xc0W1UqSv1csqu03mr2aD7wi/5KIW0lYBLQoaaYtpsAEs1LdyU3RA7Th7A4z?=
 =?us-ascii?Q?BWckwRKOKlPDAZoKjPSKqTa46+aG3Qtq5qMvL+4vVSS6PH3dmaNsLf6JbqNp?=
 =?us-ascii?Q?q0P3wOAzUvKKQsUgQ/k/HcUD3GHUg+xOIDgKnFGRAUePVQ1bkymBUhz1+RIp?=
 =?us-ascii?Q?N53T8L03ZKXNzSLfsAjN+nF+QEbo30f3nExng0/1RnG9Kope11CBqY6Obzx1?=
 =?us-ascii?Q?/1CLM2M33p75/7TYhLsZlvXAjr2OHJ3/p0na42GBnh/JrSFD2rlwer/t0XQ9?=
 =?us-ascii?Q?EsE46oUaHUqeCCw8StuMY2Oas/219MlANgKbr2pQDAWIItux7q4SkorAX7mB?=
 =?us-ascii?Q?LQmNjIL6pdP5ketYAAKdQBvTzIqppBZUJg7hPTK/CqWIo8DMV6SHdZt0asu1?=
 =?us-ascii?Q?eSSM28F8PeoKeSKQKdYr13cONvXA2UrQQwu60OYogex0X3DlWZPejl90zYLp?=
 =?us-ascii?Q?BIJXxHi+d/AlE9F5+6ehg/eF3ASnNJGoDVxcN/hACZK17vuwVJULTMySUtsq?=
 =?us-ascii?Q?gIMJJlLZDb5DQEnrqbsLCMDQediQ3g2owR6VVRSMQLzIAgWNn8m71+ElqVkQ?=
 =?us-ascii?Q?eIHdoZiBAT8Z0iG1smJ0Gx50WlIPOU4q1L2soMAP8xhnwgGPXByzmxgvyM/P?=
 =?us-ascii?Q?YDM0toIyczh7lngh0Lpl/xrqnJAeeQxdS8+d48fYCWjw6Z/nAnz25rxFvwjV?=
 =?us-ascii?Q?+FTw0Jo621kvyR6BLMgYFhlPk8tZSdggAGuSrOcRG1cKualP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 084bbf6a-24b2-4e9a-7c52-08df1ea4a304
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 03:40:56.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Temrx0LSt0vINPRIqRAbb+nsbzfMCEvPHyMeX8LElkm7PMmXW+JwvR1eEeh3hs1kPqXIAYhKfL/B4SZ+Nc1EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9141

Sorry, this email was missed because it did not match the filtering rules I=
 set.

Hi Valdimir and Claudiu,

Please take a look at this patch, it may affect LS1028A and S32N7 platforms=
.

> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,

The system clock of i.MX95 NETC is 333MHz, AFAIU, the MDC rate should be
333/(2*258+1) =3D 644KHz. I'm confused that why you said the rate is 558KHz=
.

> but also very compatible. However, for example NXP TJA1120 PHY needs
> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.

We previously used the TJA1120-SDBR daughter card to connect to the ENETC
interface (RGMII) of the i.MX95 19x19 EVK board. However, we did not encoun=
ter
any issues with MDIO access. Furthermore, I did not see a minimum MDC
frequency rate of 1MHz on the TJA1120 datasheet. I'm not sure if this is an=
 errata
of TJA1120.

>=20
> As a minimum change, increase the MDC clock to 2.5 MHz which matches

The prerequisite is that NETC system clock is 333MHz, so that you can get a
MDC clock rate of 2.5MHz (333/(2*66 + 1)). But unfortunately, not all NETC
versions have a 333MHz system clock. For example, LS1028A is 400MHz, so
the MDC rate will be 3MHz, which will be a problem.

> the 802.3 specification. Also, even old PHYs like LAN8210Ai, KSZ8794,
> DP83822 support up to 2.5 MHz MDC clock frequency, and it covers the
> NXP TJA1120 as well. There is no known rationale for why the 558 kHz
> was picked when the eMDIO driver was added.
>=20

> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: Use 2.5 MHz per 802.3 spec, update commit message
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> index 998aaa394e9c4..a90a04a47befd 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> @@ -24,7 +24,7 @@
>=20
>  #define ENETC_EMDIO_CFG \
>  	(MDIO_CFG_HOLD(2) | \
> -	 MDIO_CFG_CLKDIV(258) | \
> +	 MDIO_CFG_CLKDIV(66) | \
>  	 MDIO_CFG_NEG)
>=20
>  #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
> --
> 2.53.0

