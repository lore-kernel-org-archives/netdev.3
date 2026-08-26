Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742036997A;
	Wed, 26 Aug 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756937; cv=fail; b=ia5Xa6tZsqMRdkkDH++HN/afGT10hqQfXGpTRou6oShU9qXP/rYrMo/WetIwdUi++0LWM09aOnCBaPvnp55nSYojaw9nCdOl956QIAkFFrPufEXKxHrqH9oH2cDCgJvIg/jDEYWGzGo16sZa0T5zsqEzvRszdIdZfC+7WDQXKkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756937; c=relaxed/simple;
	bh=wuSMFnr1vSOA4R/tg/JB8BWa7E3cGYwpwvFyt4KpyGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTRCdTb9Ux+zLT9DFenHKUhLlypCypk/NGcL2ivYkr9cz28/cEMJRHBpsu6/Tvr8XSdxtx+lXsHuU7PjMyAhuhLpx2gqZ7ZKh1yGzBevdOHGP+3ZNCxD//9rsFm9Ku6zIlIVgPsNCPkyJNRSkSXPSTfgMiAhdBA6AHl94i24j5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b1bPwfXq; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b1bPwfXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPx2m3w05yNFvvg+00dWGEkLjZOY+rKpFnFUzKlJrA8WApulZqtc7jVx7RhdnTOyvWCYkX3vsyyaWgoCadwKwXn2ZteeluL2xzZyCgpksii91GvUY1AWBW5pvEN9It6f4+x27ePpIu85J1w1PUwoX8vg0OgsnsOLQpiXciqT+Fxh4re6ZlHpujh8Cj3vzjFT/tRl6o2NSTP6dE2onjA1yWM1P42AovxKN2jiZuKXeL1Lxeen0ZsWWqCERv6e4mjGgP0wBxQylQbiSAMvx2hX8lJsF9ldnErnMoEqRfqq0mh/APnUXwLigo5DExnSBAf8romx6LzpRmxPgXgy6kcOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MPReGja8iXg8I29tTe7aW34LlmqnlrQKcDTlQGVg3c=;
 b=h3hh1UnwVz19SswaR9q3n58WabE3PEXU4mPbVnCbMtWPJT6unMzzKecbHPx0eKf69ti6t/f0gwywzF9mYZk3l0d+ZUaLfz8hyI4gkIQnf6w5X6TtnQZoIoyGxz88bB1qtbfcbSwbzS0mRJ88d5X+B/wWdYfgaaKseXlwre4wfrbea4St0dsdnBgWxlBbUEl/xFCAiABkbV18bl9sMjl/fU2tDU05o4NzSjdwcQO20TbZ9ETpFcjVNewytEh71ah14uTf1o4WKxzLJnii1rIpWBLggwMFMeKn1EOwHvKoS0ZJrNdiN5pjfg7jt5fyR7Z5iZfBeKONlYsFShg+1+mvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MPReGja8iXg8I29tTe7aW34LlmqnlrQKcDTlQGVg3c=;
 b=b1bPwfXqIoNPZ6a3/dKvCm6lw/BD+eyDRVukI685SlcfwQbjDtCaa0IGcwgz1bDDRw4VE8hNRT7Xp14Qaj7w834C7a0gcGywP9koIxy2DHtkCVMB+thqQwE0C12Tk4UIpAHiDixIM39nV/66xgvi7SozOtpYRGOJRfIQu8oe3jzvReiA2fJ4+7zqkWCQ+8q57TvYDD5JHQpYRpLedPCx21kIrkGZsb94QZDPZA+8392Lko/9o9pFVbtCWPy4H3RHkT1P/k5zZlCw/Vaf8IpmhCVkwYMLOWS0fWsRBPGPwcOrxvvYOeQME/aITlw6tgW6ziQTfbKBeuokK8TFCmlprQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DB8PR04MB6828.eurprd04.prod.outlook.com
 (2603:10a6:10:113::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 15:08:52 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 15:08:52 +0000
Date: Wed, 26 Aug 2026 18:08:48 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: pcs: lynx: add support for 25GBASE-R
Message-ID: <67u2oneqflguonmujyimu4itranljavkvqqkz5swsghgojyvur@5lbkofej2pm2>
References: <20260825-for-upstream-lynx-25gbaser-v1-v1-1-fd71c8047798@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-for-upstream-lynx-25gbaser-v1-v1-1-fd71c8047798@free.fr>
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: e77df9b0-4d62-4a49-eaaa-08df0383f0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|19092799006|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	7h31FeJoJYaiK72cD0XDD3RSRgHMz96kRe+j45EmGJbNOf3JGgZmf2wBGrIcWh7OvhwRczZDwJVreOjTwqPluGvfnWTjm+gxCy/cWwMQGHF9ROv0G+ScWWjq4JByQAw5ukqXxWD4ewXJjKpfynkwrB0z+9BTf5GeTGlCAOWxAlB50e0Ct3Q8iHruETZ8XZcjGhb2540dYHVIT/JL15PXJ0ZsvhOZLPQRtMQwvC/xjtPHujetySVC5+8HI+xN00KPBfFPG2cKYP1g2jsFtMP/thO4HJ+IaJy6f3XOVZAlYBdR8RmUb+BRTIfuySJL/UvR4LQpGWLBSu+QIqX/ttfkPtqQljFVgcsjTxeySfcG+on99gcBSzlH/Khz0gcZuzl2Te9f0Rg4w18RDj37gUxuyCqmgi5UWF5J7sc6GlURo7vo9rsdSLB23gZF8cvKgJXX6MkAtksvKp6NfyOFU1JvEirzmvYKrU40q9+b448Fb8tHgHXhMcfOH8WAT5A/ktP11ZmK1XZF9PgzZPG13aYcCUDg94bf1qotG3W4ppAiLuZTFZU2zlnQhLUuXLHiT5b4U7/Ra9utZrhdTVWua68yUfmPPpo2ImXySEQCoCk2tHt29cMHfP0SJ0hyEp9lmGdZdykBEAWFpC8FvonfO3VQPuQ+qIwd3krPdY3X8VTd3XJEBYCGp82PmuKyRWzRjlftwNUkBT7erWysgtJiHXoOJQAbpCzS69YO4mdyNWatim0yewbSA06bEI9ex1hq/SgA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MtiyqWj20f5IhRRWvMufovKLkBrpmyGjXYkquKHXSB/+I2LZWLuV2aDV+2Ww?=
 =?us-ascii?Q?yEbwD4ImUCSthcdt69yFmVTQD0oHNWAzM3DA/zA3a8kUkoIqtyzcGLNpS0yV?=
 =?us-ascii?Q?/NlVqqgt8l7otlf7Qnl8nCGHfGnHgGFm8j/EUu9j2tFgtjQtAIZDoE7oEhSt?=
 =?us-ascii?Q?h0kWHxd6P4wuVpkejixxfMQD4imP/INJjQJwJGtTSkqSgyd464GfBDl6OhT/?=
 =?us-ascii?Q?QGDrEcaBSuhCuU6QeZmibIA0g0XVhCOTwakG1PVPpJ34hJvaijCk0nNtrRp8?=
 =?us-ascii?Q?L1nV0UhA5moZuUHj4vMuPHfKJtVmbTCMjMl4yXl9etWclYd1U9GkuZu3RcjX?=
 =?us-ascii?Q?ZC3KMmgrQ5wmIa01hPvQwHgpU1oZ7zOd5k/t+jc0sBezbNTNJJ8iuiL2fE4v?=
 =?us-ascii?Q?8ZUh3Cu96hdlUWPaPR+mbQkmwJ8cNueuRFhAmZ5BE07cQG3pgLIjadnuwfI0?=
 =?us-ascii?Q?gb0ZE5BPB6pofIx2Md79UC0jVXzKJZY9oyH57x8A80QT1FkXIIgmt5O0lGLE?=
 =?us-ascii?Q?zE7XrUMzCwHQBFWFmHl6+ImZ+mbA/RD4zybb/vnZuUw+YnlY8j4ibRFtDMMi?=
 =?us-ascii?Q?QN0vfzZPSobE1lXDew6WpgYGQ4v6Yr8cankB7sJXxVbH8g7N7hdz9IWjjO1i?=
 =?us-ascii?Q?U8cQMpcpqAblzht/At9dlAQ9fUwFqWk6a2YRfsa0jR6ri7o3ilQSgLAiYhGa?=
 =?us-ascii?Q?TgtmvTPUILHzd+VsiTQEu8ytkBrbSh7xKdrswn3u4da7a/lOWjVFojIKiEN0?=
 =?us-ascii?Q?lhVzwdXkjiI3NTd6ABnEsK6fVufGrGsoAnfympgzC0moBZCsXw1C1WybGgR5?=
 =?us-ascii?Q?rgNgys8rKygB3MEZZo+duFHOIFty7tqFlPl1Z/S/INI/HPn8qVulHDhWJ1nd?=
 =?us-ascii?Q?+WxtixO7xem2fNrZtQ7UI7MdRC1euo4I6O66EHeO/52YO3pTObnpiljDswjY?=
 =?us-ascii?Q?kwr/gjioxQx64G1eLwEN65r5mLihaVYzknKEYFdUJ7yFHEUOk04vuErMb75o?=
 =?us-ascii?Q?OHxRBZsOBkONIpFPOl5zVzvrTD01YdhD+Dkgiy5IbVsQLtJ7PscdLqCOTL6N?=
 =?us-ascii?Q?7A7MZIdN9tuqYFbmeXO/Ur3W3ESZfuXbFlk05H2vyu6qTvR61huxy+u9yCzZ?=
 =?us-ascii?Q?L5VjfrJ0ieLzhgaWGgAWIxYGw8pauA8zSAJxwwceUJLtYsGV2bnV8TO2GvAy?=
 =?us-ascii?Q?/YsXyeYc5wndog/F9MpAfwdbrtj4U/kWP35I+P+DHVdgetJ9CPyD6+jj0Pyo?=
 =?us-ascii?Q?LuFQcwbpf9ZWrdcd1uaHx+gBcNuYRF7P2QHmo0y7k2kDVXiq05CBwNLf9wjr?=
 =?us-ascii?Q?/CJn95YC/TO9hsJqdGNxZ+v+78j2JMCMJgpyYUMrG0BC4nL8+6wjb3Ya05hT?=
 =?us-ascii?Q?rNLkclPPtyFwW+lDCvFCzzAs2xDTTatn8dRyMopB9+cT9+IT013CtzcOBEcW?=
 =?us-ascii?Q?e5hzOHlAmM9kUMmSFPWIOiFbLHyVIH1nxoX+J7NygzXktHucOxuWBxgvX5W1?=
 =?us-ascii?Q?9s+eibI3tubf66i3Y0Hm5KqldJ3Yfjr1HYb/L+/jVc8rYOwwCxUAhxDgX8vz?=
 =?us-ascii?Q?7gHWm1kukCQ7PZx81dNkp+w4x9YUcKAalr0UlA1pkunnH3w6gEe3xeMCuIEu?=
 =?us-ascii?Q?JkUWKIUq/uXFeRJRq+BJFoTU2J/bbl8Zsh83RzfVEZft47xkys57ushulTpb?=
 =?us-ascii?Q?XzasxoMV//X3SKfk2i3y1YuiiX9vvSco+9XvvDQ3zKK/gpI+pB5dnA9YKe2m?=
 =?us-ascii?Q?H/mtZc1BmQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77df9b0-4d62-4a49-eaaa-08df0383f0ae
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 15:08:52.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1YdegqSU5vTL7lHZsFPU7X6lpetmnpoZnNVO286/5k7bD6YEki+W9CNSjThVbW2DchAWXgBL8oScME4mFyGmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

On Tue, Aug 25, 2026 at 04:00:31PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> The 25G is missing since commit 1cab8fba5073 ("phy: lynx-28g: add
> support for 25GBASER").
> 

This could lead me to believe that the 25G support was ok before the
mentioned commit, which is not true. Can you please rephrase the commit
message so that it's clear that you are actually adding the 25G support
in the Lynx PCS and not fixing up any issue?

> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
> RFC to check if we apply NXP's intend.

And also because net-next is closed for the moment.

> ---
>  drivers/net/pcs/pcs-lynx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index a92081560e641..da4f99059eef7 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -46,6 +46,7 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
>  		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
>  
>  	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_25GBASER:
>  		return LINK_INBAND_DISABLE;
>  
>  	case PHY_INTERFACE_MODE_USXGMII:
> @@ -97,6 +98,7 @@ static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		lynx_pcs_get_state_usxgmii(lynx->mdio, state);
>  		break;
>  	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_25GBASER:
>  		phylink_mii_c45_pcs_get_state(lynx->mdio, state);

You also need to update the phylink_mii_c45_pcs_get_state() helper so
that it treats the PHY_INTERFACE_MODE_25GBASER case, otherwise the
link up print looks something like:

	fsl_dpaa2_eth dpni.2 endpmac5: Link is Up - Unknown/Unknown - flow control off

The following patch should be submitted alonside these PCS changes:
https://github.com/nxp-qoriq/linux/commit/23ab48259b12cbf8d09ea6a99f66fda01d67536a

Ioana
