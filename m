Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D22D63E5;
	Mon, 28 Sep 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587126; cv=fail; b=Umwzg/6FBBoYnHMsU0vjBiheAj7BJXjZEEjqyhSGeAFBrteeAWprzFKHcjj1lCG7nuvvvZGEco6g7JDWws8BtI/3Xv0eV9qTCr3ls0ciMvywJAmxq9JLe+Ox/7vvbt8ZEHc7VvMRwtTlDw6M7JITV/nNeEsTRXfHLiDxAeCjZcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587126; c=relaxed/simple;
	bh=1D5OOSdz6C7wLE7gsDWbePRrfp9nzM/thshQOYvynmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kGN/ixNqlkvgx8HFuT1bumXwd6fk2qKKtcoOugP7yyIW9lyis8K0nPQJbZ1iBqNzRv1NWzsbHwztM/NoNdLfk87CRfas+oPRNTu2oKyQWvKpurX3a3N1Im4jNlBU4IcnKUwu6D/WFMPk5OsFz1v35yMftdva/iqpDpHSHXdxd+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WnYUep6S; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WnYUep6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNhnDvpcIYf2aaL/y4/AXXI/2+KtPx+W8QoysFZLjw63h5tM5g1edrshnv6FUgcJ/UWuo9PgZNl/uukRgOupdIGS/P2HFInVjUFDfjc0xaMdlWxTT73RTKzzB2mbcgTk7S7iH1vP6IY9OxPv7WiOg+Qayg7YgWhOjX6nwTSCPL02bo2pv5fDJW8vuPGwrddWjZxbvhhSAJBWEcq9QmE/1AHaawMIdVH9f+2qFd/xRKc5Ixy+heaugG/g5WbFBst0qJBc6BEAQwkjMMb6c3dgY0yvj13Qta1JZ4Fn8dxyqbz34+jhDJ8IeSrtPA8EZjkTNmFuANKaD/LS3Seyo6mQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab8KdPrHZBMl4YHmS58/Xj2wE36/jrdSMgxsw1egVXY=;
 b=Ut1EirahjsUB633e2wyPqK3mFkeTPCa36q4X6i+N4S+AVwsRSXfxi1BYGNSyzlOHHgQmPzkZEeYS/1n0vEHVtkMGoZg4RG7C3K5eBHQiTrLFoWpebLHbiFSRdgPUOvlymjN4JNzypWE08Xuu/9/4YYfsdfcg65O89XlVpuOcyDu1taVxE2spuYS/mEsOBrAkBXqn7l0HmNPs/QGSj/CZZEsgONhL+4eYEHg4lhVgW5QlJ0tl5MhTBG9tAKsjLSvvWdWl9zvNCAelnehha4B3zyg5pR/dqCvzbmJ8LinUzZlo6CPk0VTLBk8dex1ouUlukfikaZSNxOKNwgDRkjYgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab8KdPrHZBMl4YHmS58/Xj2wE36/jrdSMgxsw1egVXY=;
 b=WnYUep6Sk9BjuOd3shfyiQNjCjHtuSnG789gksjK51GpwkH57/JIGjETKPFEIQKtXQklkPm/7kQBZLO2OMTFjAs5DcB146JxS3crXBMJj5IYdeCF4ftGeqE1xjtmTk3Wlmf5r/ILcX7ooy+a8XqcFrBO7G9dCacThFlDXbCwPqNDgicoNIamO0BEoHr5n3tYPo5IxUGTcrNTLoKuyDarhd4yEe+QjtiZas9cORqByL8/IDzvfXN+xncCUX+v5kVo7NM02rdYdwQRLDKNXggR7vPq93G9oCwVOIqCVzwUOFuY6+/I0GXZ4UAh/kAKZHvc7AAmaRb3no/IQwc3X+01sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by PA1PR04MB11470.eurprd04.prod.outlook.com
 (2603:10a6:102:4e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:18:41 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:18:41 +0000
Date: Mon, 28 Sep 2026 12:18:37 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] dpaa2-eth: DPNIs without a DPMAC should be
 virtual devlink ports
Message-ID: <hh6bjsyoe4hidiiyl3bt6tsmizfpf5p4h3gpbflcnsakcpgwjr@2pi6r22dpor2>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
 <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
X-ClientProxiedBy: AS4P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::6) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|PA1PR04MB11470:EE_
X-MS-Office365-Filtering-Correlation-Id: 362584de-04ff-468b-f41a-08df1d417cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|19092799006|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	mU0rMKGB426fbJv8PxPFqZBXv1cj5Ur2A5MNBleSyih0MUAW2XO/ekFrWulGfIucBnslfxlsE5dfLK+Qra2RDtThMPtz2zgrkNgFD+FEJ35/6MQbs+j5LNWrBxhXAZKrjntGa16r+2XF3/RoRr/0ChQKZJPldAKmvp+FMLQDrJnOopCmsczfRpE2DP8NI16Kt50lYT7l2iQ+SZ7UQUQYkLnKMiwRNITC+i26EETQ3zzChchEvTxFE1PTRIHPAm9WiLfS1KJaFgj2w8058RWQVucX8qikqBzOeefaryu/f2C9vieOo93M8I4lcMX3bVEaDzF/t0Tp7NhokOEtpfK1ca2X3JQ64pvkQYcAIgbpow/2t/BdD5J1s3bIlWeHwbRFBM/fge21RKGbeQY8FP73ZV84KDc4w8Em1glOAc+kxkAI05kuLnBARaH5GbpQDJSyK3lhFY0+bXB2e3nWDmXM5Ye1jNAPpWFfI9gTJQlcYw1XK/9hIOwTudravCVzfXz5lvIxoEXepZMzFD+UqXMyVtX7dkmiG/9EZRc2fh/pqn8Z4D1k89JWTjOE1IPB5wegxURFwfzAeegNqU0lUQdEmJmqiqOFeqOi7PPbd3vZ8X6z1OBhPvrloIJCabV41nYm/IW1wVwXffxSPUqr/ijcFds+/rf71ZQjYFgEODbTbugkpi0I8uZL1FCQLQBv4WFVVncUO8FrdX/oDSqZlqd/CCqb9BtXdy3m9qi3Dqvs3fU3JNg8gHDHgfCzQto/BrdF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(19092799006)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hO0qlcUvjeCZfTjQCyRWtHxozZHopeLu3+16tGz2OSCdES6f1PCWrJwPj8Km?=
 =?us-ascii?Q?hW8QID3Jg5me8ooBCO9RM7kB+qH2d+e1QoJTVfDT+KhMsqVeSG0I61ZhVHfB?=
 =?us-ascii?Q?XoVI+rsXK6kSzG646rbfi5T9HUEj0cV00+Ijm3fMk84JicEJN/HnryqMPVLQ?=
 =?us-ascii?Q?S7oNvM6TXXjepZGFtwdTcYKKczqCRAX6fO1NduXC2ehUzyVKw8SbYgroC4yP?=
 =?us-ascii?Q?HRJQTcNDyKWZDIlqLV82mnpAcvPFd3TqmVm9A/y64DoyY/XsrHo4TsRVMWn3?=
 =?us-ascii?Q?M/ZgF4wi6aXPljN9i29GvSt/ioOT7lgVPOZwIJpOerd0vCyurDsHMfQ9zFiR?=
 =?us-ascii?Q?MUDRD9dX8AcaMEF9DxzkXCnxk7CZzsET80Gb0TeCHEc7e0bpJ171jauHVgij?=
 =?us-ascii?Q?Xn9hA0cq3HLy2Mil69vETXVvyFHbBsk4b0kJrDDxsE4encc3kcutbwfF2P0p?=
 =?us-ascii?Q?lj4xEFsUIWFQNHOt4w6ZdT5D1gfiT3CBPT+VbolU5Fz/7RRLT3gkWeb8wUSA?=
 =?us-ascii?Q?15JPyJF6fFz+VTyr4Plxhd53n8TUPUsMAPBd8ejRI+NYsygtfWZ6tdwUdFWh?=
 =?us-ascii?Q?c6M09OX18tyJdatOQ2cJyNNNl49BMTw9n+LgUoZZhowf9WPV2l6hvAxkG0Ts?=
 =?us-ascii?Q?XeEbcRtxfB9j5MFuMNiaOUB3PnVNn35GyePPqsykcon5QABfyRVDQ68P+YKr?=
 =?us-ascii?Q?17YNZ0gXdlknn+jWSifALlS2IawxCQA0b9f1LWMhxyTx6voMEWnfvdDnkcRe?=
 =?us-ascii?Q?USBYK14QDHHbkhFP48JnabjdhVPSBNjcLoMpeqn7FFNXPrdeK3Ua6Otsw/yS?=
 =?us-ascii?Q?Aw8raO9Mumcr4wMiy9Lqe4zTUPKpc3zxlTzOCCQ55lG7jX7vPwc2xDqwyS5i?=
 =?us-ascii?Q?Gs7U6ugXWbncCVmwhW3cs3wx1yg02NsEXJoPpOn7JCqwdm23utYER+Fg36q3?=
 =?us-ascii?Q?+aSYai0V3TUzn+EEG+xC0Atcl8HQd+5bcr9OzlnNtVwSPFd0lwfW5VyDE9Dt?=
 =?us-ascii?Q?2iMnFpVB8RNG2s8rRVdUXao4bZKAvqoOqNu/1p5ia9IKWFkg2KJPb9or8GZj?=
 =?us-ascii?Q?7Cf2XY61qJnkw3FjZ2O0X3xTk5pozoWoh5wQAC5Yo0fatF81cgtecdIvsofF?=
 =?us-ascii?Q?5697h8UzCyLPKauGcvFpoyjWJA08nDe8BC+/bT/CmwRW9wiRb4elByKjFIbW?=
 =?us-ascii?Q?Roq4rB7EWRPgpp3lJ1o0aSGqLiIWfG7kF/sQLYgNcXVw+KPzT/uJ7mpJOvSN?=
 =?us-ascii?Q?OfC9SqqW2GbhjsF9DamGgPwIfojxJ54QpTFe+GI5csGHA7A0PahXaVIDK7uX?=
 =?us-ascii?Q?r4WKCXNOPCXzzSLPOhPWDLH5fc22Zu2x/8V4OB2gxBOoNXgFg7TPGhlYVsbD?=
 =?us-ascii?Q?t/xQ64LdQqeCaBYVSYZhlUIvz3gkJGSkEKQuggp7xyriUyckL+p+pqHPvfJW?=
 =?us-ascii?Q?rLojblAoQcTYJYjk9X6SFY0yVmgWjLIuV+idoLfohquYBbrpeVL6lW/5s/HP?=
 =?us-ascii?Q?GNHb4pLEZGxPhatGFlnPRQOMC9wYaLRCHq9K/BvO/cKjwNC6A9Ijm9RRCMIY?=
 =?us-ascii?Q?+C1xBVB6uekJPa86ddh7t+0OB6nr+TtxLZqQ87XFEy47yinISMKYFMCTuLsh?=
 =?us-ascii?Q?8UbdGmd7o4YgYcRe0Yxsuxj7z5oRWKVLuD0eNeOhh7syrefqczUvIlBUgv01?=
 =?us-ascii?Q?2saiEeuHmame2+Jnn0JZdYzKJB6EwMQh3QQQIYE2UCdsiMM99i+LtaA/C2wB?=
 =?us-ascii?Q?8xdZ4hNYpw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362584de-04ff-468b-f41a-08df1d417cbf
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:18:41.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jluQAx6z2rAYCh9BdshDTa6e4/K17rZ9130uqQKw/EzqGE9RVHNHL2U2m55SNvULS1rshZJdUdPI1nWEUbFd9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11470

On Wed, Sep 23, 2026 at 02:58:01PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> A DPNI whose endpoint is not a DPMAC has no physical connector: it
> may have no endpoint at all, or be connected to another DPNI or to a
> DPSW port. It is still registered as a physical devlink port, number 0,
> so userspace sees a physical port that does not exist.

Reword this so that it's clear that you are describing the state before
the patch.

> 
> A virtual port has no phys_port_name, so only the DPNIs that serve a
> DPMAC report one, and "p<dpmac id>" never collides.

Reword this as well and mention directly what you are changing.

I would also suggest a change in the subject title:
 dpaa2-eth: mark DPNIs without a DPMAC as virtual devlink ports

> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> index 8b2addd3f83a..30e6cb2190db 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> @@ -230,16 +230,23 @@ int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
>  	struct devlink_port *devlink_port = &priv->devlink_port;
>  	struct devlink_port_attrs attrs = {};
>  
> -	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
>  	attrs.phys.port_number = dpaa2_eth_dl_port_number(priv);
> +	if (attrs.phys.port_number)
> +		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	else
> +		attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
>  	devlink_port_attrs_set(devlink_port, &attrs);
>  	return devlink_port_register(priv->devlink, devlink_port, 0);
>  }
>  
>  void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
>  {
> -	u32 registered = priv->devlink_port.attrs.phys.port_number;
> +	const struct devlink_port_attrs *attrs = &priv->devlink_port.attrs;
>  	u32 current_number = dpaa2_eth_dl_port_number(priv);
> +	u32 registered = 0;

Move these changes to patch 1/2.

Ioana
