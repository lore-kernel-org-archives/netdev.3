Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4ED48F002;
	Mon, 28 Sep 2026 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586747; cv=fail; b=SBORMmIGvhs83F+Jnth+rwQA89eJTSeG+hYsD56mzhk2C/zS2Azm0wM1p0nkirjre3FlvrwBLFghUoymNQhG5yyQan757Kl3MTHF5QRePvo9vPUMFg8YgPuHgVKu6w/62N4JA0FYgPMzgbPsx4IHm9zyYkrcH+wwkakIVqXu+aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586747; c=relaxed/simple;
	bh=FOuHmL5Y6jK1L6uwYEXLkfvTVuyShQC54+q9zDGVadI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MDy2A8rN2ePbbsLOQ9m/N24L+vJ65grt+KKNJxM4ldOqDFnDIs5X/NuRuE0H3rHMiikjZy3B+OHTCoqC7DdfBW8ifFSdLxAuWw7RJJ/nZVgnv3YOwNrwEop0FFtGyPgiXFcHGh7lneIRA7GaPCFqDbguVhVwMtDfLueWTDH+Z0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ilcHwIBh; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ilcHwIBh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yABcFVXMfLei5r81totJf9REqgDO43FxDBCM0DAHWa5K08ru6cactyqUQs2FjWtjqea6tqH6vZCDqrvi7XvP+62OfQs/AFYCDukm+k7Qt2LifY2stDPDP1+8MIBzMXccBOX8qZQ1LuYaiSc5Ig2fI/X4e4qFZuXdNknWB6tdpPyBf+cUu7lnbjZ08luqQeW9mgLdQ3z8G1jolXRUsPKlu3VCnzxt8wSJTJkuIWXzyvIjiqtqITfSPmCwKwV+Z1x6oNzzwBRTW15E+0BT8XJPSSOsj2zPoHVJ0PPy1Xgpp4zGZpY5n9C8l2rXsN1Y9yQaA1E+pJCQKwHRFM5hc3qZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMGcBnVBff+YF7WheUmK9iIfk/jFKqFWDobfgb5nNt0=;
 b=gSCXsZZ3O3iMzEjpk6oappcC2qUS5SvaFu4fNFKHDxFBioApLkgOtfZEEQWAodIEqnB/Sh5mswfG07RelPka/1pVImM/UyogpKkJMJNiNZugfsHIXLiyab/3gJJK1Tmi0MrIL/5XDlvRJzIWHo0bUuAApJw+a9GD4UpJSilMUWVBJq4odi500VUPd9yco7Ws9OmS7FKAesnObC/q5g/c/oFGJsviWdR5AF8caxvbF4z2TGDDd/oGXy6Iml1UIfDGD1UHphoYzfEFDFAL4TJAXy5OhOTGMZafiC6M20Y9Qw84z+RMs28xZN6oRAIiHYLMJbomsMAmc4SybWK47QczYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMGcBnVBff+YF7WheUmK9iIfk/jFKqFWDobfgb5nNt0=;
 b=ilcHwIBhpvMn4Cz6p1xeBcYze9RhJcADKv4dAPP2EwKbKqUz2Ry5rjSarOgntHORwn+1PYc6B/CsCF5/WsmVh4VexdicchOlYMRs1GuSvVQ+htGiQ35LqoHMSv1qwtXCFdlQZ9W6kMAjAfiMfFqDsrOyZmiC2MJJeZ9yYB9SbM09Jy4hJFbo+HAxjnZzmcqWCz201/8GTSiStP1F/pX8ij7Vui1jODM/OEve3ZciDwYRbP4ovZKfjyKBYFJNyCzhEHUjhFEsPiCfMlmoR1ZfkFccqYplCSphKfgLqCtv9lSpX4yIUGTpn0Yl2LaorfElNIXU3vLmMdEyM3UQfqfphA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by DBBPR04MB7962.eurprd04.prod.outlook.com
 (2603:10a6:10:1e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 09:12:23 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:12:23 +0000
Date: Mon, 28 Sep 2026 12:12:19 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpaa2-eth: use the DPMAC id as the devlink
 physical port number
Message-ID: <ajmz2ulwmxzwmc2qymbka6ddlhfr3hcolkvszdsnhbdzqxwbpd@raxnrv3i3xgt>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
 <20260923-for-upstream-dpaa2_ports-v1-1-b59c865edd00@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-1-b59c865edd00@free.fr>
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: a267c6af-0bbc-4bdd-f617-08df1d409b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|19092799006|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	cvSuR3mjbbXMpKY1CR+eMT1dFXFixbj0cX97zF2a2m0AVpsPDLJtk3+kMtbEg4lVbA/SCDpTi3+Sg/954IUel0shuWhLcT3H7v1oLtxpo6xuzDjdPXP/u3Q1jHpSKpVNlyAUXhTXdAp5l4jmaHOjUzzAHAkaEQ8YFKYo/D24mYUm+aCQDNBDn1rh4tB48h1Rey99mYPZg7Ct5aZdBUro1w/uvZ2Rdyv+0qTaCzY0OyJdyBvCtPucByomxXqE2K19jfH1/4X9dwlKwX/ajFjhMLX3uWW8YCG3O6zsufVGm9OOiw/RUbQQlJVBeNlcEONKdzPppC227pQV2ihu9bsjPUqOuOxEbFnp81jLoDsNmpJOqzARqno9sycfddpZ36b2HCIFPkvB1al13UBzqCXMGR1wF8RY/YQCDaFS+VbmH0oU/25hSOlUr6lcxlo2VHaZhKTt1r3+aDVK3szfhoT2axmlzfv35dcJDslwcYVR1dboInYj+y3x4h5zFLXOTI3RjeHENIUdgWBJuKLG4MO5oraqetacJes1SUsa/brwx7JzIsKQ0wWJtIDTOEliYXb/qc1EjlEFyb68lEeoTM1kotFxXBnMKK0rNLcjYWrb2AMYCK+Jv/Q/dY170JRx2XXXhrZgtxJSp/PaqUIE0smHzsbtUWWQD1+vvOCADK16VAG2JdduoZSSYC7lu/wwVVdNpBFuDiito3TZLTSXYtTKXfRIJMssHWyhl6NOTy5ijDewp72yV0AY43sYNauq7oGX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(19092799006)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wa5MrCnnxoNZnCFNW7lDpPPFtwXHeRxq0eQwzhBPQ1ZGxjxGF2DINHaBSLVv?=
 =?us-ascii?Q?sJb75h8+vKPKsfuX/tzsx34RRtZz5ofdEZhHUJK/TfnaPcKkJQ+ZPVUkAjiH?=
 =?us-ascii?Q?cpYHstjq8h2Z4Xlf+qQyfzJgw8uaLi5c2TJVrcvaAG1ma+Zcp/KfZ9ExdRLm?=
 =?us-ascii?Q?jqNFHW1qcPkhl4g7LFABzGEH+6qAsnde7PZWO8kMWJHUISoEzLkq8LANgEIl?=
 =?us-ascii?Q?UJodT4rq7hnIurswN6ekJ2ZCczLmW8wXcKw5L+GN2t+kT6E8rH6x7/XgeXMQ?=
 =?us-ascii?Q?44p3+T+ax9T6XoNX8sxYkJL3Ey9vYa9UaLdVJKmZkeGpSMtsQ31wt7Si/tkB?=
 =?us-ascii?Q?NYMLJwUvWN2Yzb1apffjHQbIVbKwZKOIZ8b0JzLcXHKmce/RfjukkyGgC2Qh?=
 =?us-ascii?Q?HAPzgCKH4Q9/OV8C9tUxfNzFZfwcLqFFJUFUVLK9XBgcz9DJyrSDK9z6SHBY?=
 =?us-ascii?Q?ZvjW6v0oLvmeecqnp/k5YrrlChIjgX6ImQiSrU2to0YZmim1QQ5zXFgF3avA?=
 =?us-ascii?Q?TYt78eUVXGJMEgtSscWgL3DwnQfk0Z96yg8B6cjiw9nCzDebugVLjuWY1sy1?=
 =?us-ascii?Q?QU9vnfssGX9nsOGtIZ95RQ7zz8k8nOXHRJVTiJqv5P0Xqc+qpy73SlLzJS2f?=
 =?us-ascii?Q?w207u0G9bKlEmGPUIsHEj45CyXJo5aoQaxaHzziCWSDZn7LGtTCjADpUOKN4?=
 =?us-ascii?Q?SOtFN2NrHLg3bfqQQkuHgRuasxqVmCJcMBj2henTQRxxr9T+U9RdsWtHQd+Z?=
 =?us-ascii?Q?+ku3irmLm/OmH3ARyTqDoDmOldsN3HIgEIFyjVYmhiS5ENnR0/eIg+sie3kp?=
 =?us-ascii?Q?AcVSP1p4NkwhECFCzN9QVpK78SPqrQakdZU+CX7DCvY0QFu7VDo48RJFLYIV?=
 =?us-ascii?Q?QIH590nPjYHDCDy0JmWCGnPeEJGFv6PRynziNi/8XmnHuTfJa8+hM37vFRX6?=
 =?us-ascii?Q?ZCAsE/sY1Enyk5Px8wjI+77k2HJB3WHAT7vby1sPWafacFc5xJ6MT/jNpMQR?=
 =?us-ascii?Q?gfmyhZWvunKtoWnd3TVA09LO1xhBhOaFfO6wFq4SI7lN8fZuTI8f2iXUHM6M?=
 =?us-ascii?Q?rA9ct0rnm8OP5FaFEi/vZG3d1ptjNKElGipMvZX3WWY0E+A8qXJDLBhFcnhc?=
 =?us-ascii?Q?s31mTyzgu4yBBGJu3VV0CdKysehGRQJ5iYVqoa1Qa8ZrMl0RRgpD0Rlur9gL?=
 =?us-ascii?Q?mjJuKhjJ/ZvTwM3fVKG0MfokkGImqbrt4OcU2KP/VUUN+nJf/5+boUZcVuCm?=
 =?us-ascii?Q?m89nqf4TSJBzFxbyS/r7cT8YS5Sg5ch6PCLksWe3xZIWPU5BX/zOBqRj/XQw?=
 =?us-ascii?Q?L3/ilNPGlYTb7r80ShooHGKI/1S9RCcMrD7rtYrCwYtOnTev2FrHevvTmGiI?=
 =?us-ascii?Q?mZUWhoZff/J3pbie4tUj9R6aBZTP7hx/rXmFr4Hg10TrrQFYYbem+PMAHXp6?=
 =?us-ascii?Q?+cpZB8t+V7tQCDZfGQ6xuwgCsuj359lv1kNJLUQQcdxmXU1rwtQhodN+i6xF?=
 =?us-ascii?Q?fp9LiCJHMdsGkLxOA6zj2P5rbBnMaG6DsUSIIm6cy+/QQB1EwVpKKvLXwbd4?=
 =?us-ascii?Q?W9u+JJtVgyIwNUUWQYGTMSq6ZVFJv7rPi6724jomli9CGzA1OwHSKQAH0qSy?=
 =?us-ascii?Q?GYd4w4vknU+JazH+82OxfLE6q2GrQ4OLqQeR/mC5JbPiknSQ7qo3Fdd/QtUs?=
 =?us-ascii?Q?97Y80x9GHz9iKBI6lp8X41bU/w4csnoX071CkAyovnIcUIpd7QwOTYBCvYd5?=
 =?us-ascii?Q?Qw7RKw9kUQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a267c6af-0bbc-4bdd-f617-08df1d409b47
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 09:12:23.0888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kiv7v8M47Ybri9E6YkBr4Fhx1eOve0LsP3GgVrgkoRF7a2xRlWwHsT5u+N+OkvfvZUkOeMUagpHTZcXSnp/toA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962

On Wed, Sep 23, 2026 at 02:58:00PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> dpaa2-eth registers every DPNI as a devlink port of flavour physical
> without setting a port number. All DPAA2 interfaces therefore report
> the same phys_port_name, p0 (see devlink port show).
> 
> The DPNI endpoint can change at runtime while the attributes of a
> registered devlink port cannot, so log a warning when it happens.
> 
> Another benefit: udev rules can match ATTR{phys_port_name} to name an
> interface based on its DPMAC.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   | 26 ++++++++++++++++++++++
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  2 ++
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  1 +
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> index 8775c931106b..8b2addd3f83a 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> @@ -213,16 +213,42 @@ void dpaa2_eth_dl_unregister(struct dpaa2_eth_priv *priv)
>  	devlink_unregister(priv->devlink);
>  }
>  
> +static u32 dpaa2_eth_dl_port_number(struct dpaa2_eth_priv *priv)
> +{
> +	u32 port_number = 0;
> +
> +	mutex_lock(&priv->mac_lock);
> +	if (priv->mac)
> +		port_number = priv->mac->mc_dev->obj_desc.id;
> +	mutex_unlock(&priv->mac_lock);
> +
> +	return port_number;
> +}
> +
>  int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
>  {
>  	struct devlink_port *devlink_port = &priv->devlink_port;
>  	struct devlink_port_attrs attrs = {};
>  
>  	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	attrs.phys.port_number = dpaa2_eth_dl_port_number(priv);
>  	devlink_port_attrs_set(devlink_port, &attrs);
>  	return devlink_port_register(priv->devlink, devlink_port, 0);
>  }
>  
> +void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
> +{
> +	u32 registered = priv->devlink_port.attrs.phys.port_number;
> +	u32 current_number = dpaa2_eth_dl_port_number(priv);
> +
> +	if (registered == current_number)
> +		return;
> +
> +	netdev_warn(priv->net_dev,
> +		    "devlink port number %u is stale, the DPMAC endpoint is now %u (0: none); rebind the DPNI to update it\n",
> +		    registered, current_number);

I agree with sashiko's feedback on this warning message. I would prefer
a simple "devlink port number %u is stable, rebind to update".

Ioana
