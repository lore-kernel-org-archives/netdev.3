Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60443C585C;
	Fri, 21 Aug 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306464; cv=fail; b=D/bZcJWK/MhQafjjQUDYcadlXyQ/wa2gcGuiaSOieYnVcAs5YJMSD8tP5l1jvjwM0OavNG6af9I1hfDOxwnnKaKGZw8BH4fnw6gJ1tXRlp91ChnqDR8tb5XKR/s5dJFXe7aJfO5Fszo+Q6HfDJ0tZmq3xe2S/8ZeNAEzhAreZnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306464; c=relaxed/simple;
	bh=UqRon/kv1xPws34ewt8PuQ8N9uzdJWf6NzcWZKPj1wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqAmWxUB+LYpiQVx2YFQsDbNKkCvEOMir0aVNLAf/+hc+I5wcitDk6EFe8+R8I2OjuR/UfmStYEWBW3r+TUSGVOe0ekOeW4+UrEUR6SwoEMCLOx0TRCO1Fck/ovfWFJl2zbhfM5Q0OU0kGmEKzXMf/boEEV6MWhxCiWYum8pyn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hSSuaAwh; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hSSuaAwh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhNixrpwPZLsZ3uh1O5FmtZ7XfsL26K2+3W6/p4dpvMcyNeMBW3sUvUwXT/w+DzEa3+Ebza5oEbezJ2SKTHXO4OANpCD2P+Eepkes3x2Erew6OYh2UTLDGD0gswMxbOCMEtWeno2ez/BHk26e2bPoiQiek71OEq0TzgON2xQ9FZLj5ltPfjGjuecsbfEbIs5LU/7+BTwaFF7CY6xPv68s9B4rNm5SyrbRECbeQsVD68fKI3eukavDkUI1m8AY2ku/Jyo47VuYCNSFeJSfye2qCpYKPQplwB0zxfI1KD6iGOxlFsVfMi457RwB53po6QHNDuEKpnCx11GrzssSMQFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O40zQ7iIr02AOEyB4EuA4EeckX2WXiejBLEBo914Ls=;
 b=CtqSZiWtxL6EJ3MaPj2vEvP8IO4yw/q5GHje5kfqicu5IMX4WeIyLPvnJQsb89dkit8fV1IfBbEZVzQztGnT/MXAPpO4P+AvD7i5nLoxCcn3nvuGuRRN89a1iMvqvU+3lt5V/EpQWbkjDh+KQE6twWYWzoXi/CeqZNnd5T/06Zqo5tCoQUtHYRlVr9ffl6srVjMw8h2Lob1B3EDlJ5dM6K7ZV+0CjC29on6ncs0CSRS4HwZ0MrQyfd2lgbZoeYGsMX8LrUe84Bfuk7izmiPTyEDv1LenP0DhkQwkrptsDhrjKcSKmrj+M8gkAvPoDim8W3s7hUTpRhwg36ysfzMhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O40zQ7iIr02AOEyB4EuA4EeckX2WXiejBLEBo914Ls=;
 b=hSSuaAwhxh2hvza8VHzHtWgabp6TYo7VArtGMJ94YqYz/EGYojMQ/I8yEvza62A8ri5VCQnNmW3u7X9zi7Ym5KsKAAwMfNk8qJN/z61HtEgKyQUZexzcpkh8rQ29jIlgq0vThkxRIRwg1/4njIvNUwIsCrz0Z4RsQK409IOgHhhqcd3aHRTueKiKCPdKihtp0w3dBppY/EsjVVttKKjrm0Upex50LzwJtBVYm8H/P3BlTCXmtLstEyKa8rapoLmdTLQVqo+6aogF3rzd2LfCnW/HVx2oQ/aHAD0gwFhsG53hT0OL7N4WqU+puGigSXEOj9BFqrRfwRq6RDzC00LcDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DUZPR04MB10040.eurprd04.prod.outlook.com
 (2603:10a6:10:4dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 10:00:51 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 10:00:51 +0000
Date: Fri, 21 Aug 2026 13:00:46 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <xjhcgn2ki6a4vlmo5cbn4oagw3jyn6zkomjcva5w7gnugzbloy@odub7owqu5pa>
References: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com>
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DUZPR04MB10040:EE_
X-MS-Office365-Filtering-Correlation-Id: 450da999-1b08-4870-96f2-08deff6b14d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|19092799006|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	LS6g7BBSBXkhakcC9Jx1exNw9AvwCVrPtTRmkEgAdpoPZym2Ynag4vV1qxq5Qcwm0ozRfW6ftcsGBmmhdN6V127uO2kk0J9zp5c5hUPN1I2YqIFVIVIYNc22EirAacyjt4UU7DnbuMa8e0zBAl+w+se5iWPQUQt0MjbToFVOt7O4w1dyqv3Otoz9G25IYEG2ZSoJ1gZVf6Am5n8XCmOG1fuyppOoB3k+Y9RQNv759DXlX4CKRZ/4rfph+OJJu+N+pW8yXfgcLSyJm1Q7URKVS6Lyt3+mA/UQ1Le66+83I1tEXg7AWi7dPqXb0hr+WIQrPwFPSxV4+Va3k93k5Xmf0Tk40mc3HElruBl0517WK5aSe9+IV6zvKCIO+rubB6pE0LJAQwWLqFcyBhEDu2st0OSEvmHn97EvMpKpg+AaGrHxC9XJ5ln5h8UxhYCUl202JZu9itrLcmOKqTOKZyT2K2m5SIlT54X0jnxpfvHsTfaBLMdtTIwR0agGiOmfClHDjIi7PPrmFInm/4Mzj3i76CZiLr8azt+C4aKDW74J9kWGC9YivxH5e8ldniNqJBzhfOmOjYtzT1i3QP4TaIIoTkv4j4ne6HgZpNAtF0e+x/mBo+ahI5R3WshmECqeketU+NMHad5zDwNU0xSdtjBcMsiItkv5izIER1uy7FtbjGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(19092799006)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2QJ60JETjc5FRUGW6sVlTSap1rMKC4PneacOsQPSOI8ceeDfnKyQp7XOhcO?=
 =?us-ascii?Q?GwXh1mYf1SBmpA6Quv3e4qYCdkTzP5iXt902K+9Uq1YwBlbjWPbIPK75I9Mu?=
 =?us-ascii?Q?WkgnimciCdKppDbl2q0EHXz862xcTgIDu+SyGKCjgOYdRQxn1cve568n5+me?=
 =?us-ascii?Q?EbzbqIqGKZ2ekyX7bSloGQRjMf8CFgs2YUIM6h7+5jfKUKWvfvGIwN5AGoxh?=
 =?us-ascii?Q?T+BniE1MXnu5mtGY+I9ncoAKdHHOXIsh2dvY016S4fmtkZLGILhRcEPEMvpp?=
 =?us-ascii?Q?EvzakTHNyfixNiBr/35gQCc4mxVlRSng9MZWhP1dYDr4/xjINqjfKGqmVAsJ?=
 =?us-ascii?Q?nXXeSGK2CW5zeq7pmDH6XFy12dtF6e5W3NnxDR8VqdZGcKJJE6wzwAue6oqE?=
 =?us-ascii?Q?XQvU1dl5N+uj26xvNITG8QQCMhpqPCMW0OeFMLdGA8qsaB4R/jBahy6i5SnV?=
 =?us-ascii?Q?mOuoRFJS3vauo8b4L9hgl21mhznZYQ0ZNMPZl+rWEKez84BbvVaqkhI47UX3?=
 =?us-ascii?Q?W6WXj9E8bK46v2VR/3gcgAWYArS3zuBhO1Av3l8KgdCfDfr0whP7XqnQNBnj?=
 =?us-ascii?Q?bTZccG882aJzDrWhZU+U3CSF+xkFn/cKDL2kvzfWwQf3bUomVsaTEpjD5Uew?=
 =?us-ascii?Q?UZ/+1R6JwIk6tD53Yhguc8cWPfs6Yy1ipegrFCbuSBtTFJXVdWlkSJbMIgLJ?=
 =?us-ascii?Q?8mQElUnco8oCdgkKFgB0i59JVFaXr+INe6Lm30ElLS+SAfGT/QmS/84QXu8v?=
 =?us-ascii?Q?qhetJoSoQT2Zh8SANFb3MmTGoV9YnmE0B6ausOvv2iDvILfKkKzmgrea2mSM?=
 =?us-ascii?Q?HwlbdyjgvBkl8rP5IXdw1ynu7UAnLpUIwuo/eBvElj9TlhlVTUGUBtxEzotH?=
 =?us-ascii?Q?DBDvpD/EPvpVkO1ZIULeSg4oJL2hWQ2kyRpyQPhlfmxnOvdZe1a+Xmngl4wQ?=
 =?us-ascii?Q?jMyidU30L9R9AvQn5WbLlOlPAOg33sAlxsr+CHhI+mXiutzxdPaqtj+1A0aH?=
 =?us-ascii?Q?8u6B/nqoopbO6r10QcezSRmFSCEcAWythS6pG5l28OBbE0z3fETVsE1YnUC7?=
 =?us-ascii?Q?RkDTC0scgaQDlMrLwH70J3mLieIu97aVG/uBHm0JRUqV0Hx5qMkAbx034WkJ?=
 =?us-ascii?Q?q0SbHqPAp6XbsFuKHbMy3LBvDmFALRTgJchM9/w1JcVYJ3dZJ64ofH0xLf+D?=
 =?us-ascii?Q?4a7MS7/0BzGbLej6IJtxjyiaDcxmQAMgK0WI+pjE4nAhlqCJrsfrw54SAE3i?=
 =?us-ascii?Q?6jRls91P6JmvH4R2FzeEWChwpeVCo38EooShwEDZIBdgXdP+ndpvRMsTiE4v?=
 =?us-ascii?Q?/60U7FCHnp7vj3XVKLA8zOCo9KAdgrVO+D4utNSoqo4s7ORj+cZVA88rZABI?=
 =?us-ascii?Q?JSOi3Kz/C3Ela17yMjgc+rILl9LviSbTFN4l8g9eKmUtWwVY4cU4R1W6ySo1?=
 =?us-ascii?Q?itLQkPmIBka/gX+4UET7NnOblh7O/244pJytC1kR9nMPW5/9sD7rv3lKQBjR?=
 =?us-ascii?Q?ymV2U/MSyQYGKf3/ex2qiGrB7n/Iem5ZyUEGjJShbz1Tn8/3lJ+kzqXPz2Q7?=
 =?us-ascii?Q?cY4vKe2XOzoQgIOqT7+yIa3xlJCANTjlAR0d1mEPveP2YhUF2+n6XiJBik44?=
 =?us-ascii?Q?L1v8IMKInm6H1WUmLa/WElwDmYIRbfBAad40Kg8MgxCWWKRDbFrMtbo5ZAcU?=
 =?us-ascii?Q?fMy9X0GbBwBNq+O10UN8KPkrMCgkXnr+NpcgqsjM0PQpWP7jRyWT2zkW7HtH?=
 =?us-ascii?Q?pn4/cLgUYw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450da999-1b08-4870-96f2-08deff6b14d9
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:00:51.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FAVb9+3W7DrVib+1BG1chm7x378RALIUNAR6KM7J3Z2pP+MG19QsmQ8OuwXq9DNCHvSBpkmv0zZdFTnaeinKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10040

On Thu, Aug 20, 2026 at 07:41:40PM +0200, Patryk Biel wrote:
> The Lynx PCS USXGMII setup programs the replicator advertisement, but
> does not explicitly enable and restart in-band autonegotiation or program
> the replicator link timers.
> 
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.
> 
> After programming the USXGMII device ability, configure the replicator
> BMCR with reset, autonegotiation enable and autonegotiation restart. Also
> program the replicator link timer registers with the values used by the
> ENETC/Felix setup.
> 

For v2 please explicitly target the net tree by changing the subject
prefix to "PATCH net ".

> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
> This is a follow-up to the discussion started here:
> 
> Link: https://lore.kernel.org/netdev/CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com/
> 
> To summarize: on systems that don't rely on the U-Boot Felix switch
> driver to pre-configure 10G-QXGMII in-band autonegotiation, the Lynx
> PCS USXGMII code programs the replicator device ability but never
> actually enables/restarts autonegotiation nor sets up the replicator
> link timers. This leaves link establishment dependent on bootloader
> state that isn't guaranteed to exist.
> 
> This series only addresses the PCS side of the problem: it configures
> the USXGMII replicator BMCR (reset/AN enable/AN restart) and the link
> timer registers whenever lynx_pcs_config_usxgmii() is called, so that
> in-band AN comes up correctly regardless of what the bootloader did.
> 
> It intentionally does NOT yet remove the "only supports in-band AN for
> now" limitation, nor does it wire up neg_mode-based configuration to
> support the managed = "in-band-status" property being absent from the
> device tree. That part still needs more work/testing on my side (in
> particular the in-band-disable path isn't behaving as expected yet
> with the PHY I'm testing against), and I'd like to discuss the right
> approach for it separately before sending a follow-up series.
> 
> Feedback welcome, especially on whether this is an acceptable
> incremental step or whether it should be bundled together with the
> neg_mode/in-band-disable work
> ---
>  drivers/net/pcs/pcs-lynx.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index a92081560e641ad2b297b7395cc72bf2f59ea16c..33655079fe51dba9dc96b0f7a79c4303e9492463 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -20,6 +20,9 @@
>  #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
>  #define IF_MODE_HALF_DUPLEX		BIT(4)
>  
> +#define ENETC_PCS_REPL_LINK_TIMER_1_DEF	0x0003
> +#define ENETC_PCS_REPL_LINK_TIMER_2_DEF	0x06a0
> +
>  struct lynx_pcs {
>  	struct phylink_pcs pcs;
>  	struct mdio_device *mdio;
> @@ -154,6 +157,7 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  				   const unsigned long *advertising,
>  				   unsigned int neg_mode)
>  {
> +	int ret;
>  	struct mii_bus *bus = pcs->bus;
>  	int addr = pcs->addr;
>  
> @@ -164,10 +168,38 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  	}
>  
>  	/* Configure device ability for the USXGMII Replicator */
> -	return mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
> -				 MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
> -				 MDIO_USXGMII_FULL_DUPLEX |
> -				 ADVERTISE_SGMII | ADVERTISE_LPACK);
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
> +				MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
> +				MDIO_USXGMII_FULL_DUPLEX |
> +				ADVERTISE_SGMII | ADVERTISE_LPACK);
> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII replicator config\n");
> +		return ret;
> +	}
> +
> +	/* Configure autonegotiation */
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_BMCR,
> +				BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);
> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII replicator control config\n");
> +		return ret;
> +	}

Doesn't it make more sense to issue AN restart after you configure the
link timer?

> +
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, LINK_TIMER_LO,
> +				ENETC_PCS_REPL_LINK_TIMER_1_DEF);
> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII Link Timer 1\n");
> +		return ret;
> +	}

Please use the link timer value returned by phylink_get_link_timer_ns()
instead of the hardcoded values brought from the u-boot driver. Keep in
mind that the value to be written in LINK_TIMER_LO and LINK_TIMER_HI is
in steps of 3.2 ns.

Ioana
