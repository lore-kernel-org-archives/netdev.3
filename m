Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDA352005;
	Mon, 24 Aug 2026 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583483; cv=fail; b=svbrm7EnLWzjIGJMGgrYkoQekz6I83sgwPqf0I9xG8gaigEm8kz/NGshNGNT9XA1hxXtZ41msRXFRH3KIQBMEhkexevK1HtzEev4SKTFBepjBUZyLBW70+TYpI1pTa7H4cevgPmo0praaMb/ysn/Qq760japQALISoosIxRg6Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583483; c=relaxed/simple;
	bh=GsSxBfn9JV3Bp9iOuVbekQLbqQ3eSQ0mLSHnn1GOknE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tfHwZrk7Acs6dOZgPYOmcOgMYtU26jXwOvDmfMcBNtpa9FAuso/XdwjIf5ILeB+Szm0TuACfcGxzkEr3wvcfG1aIIEzjOevXKEFpPFRMpi+pfRxxP5CxzbOZ4uZpj9IpaohFInT8aSVfohHWAMHP88CNnLcODW55bhgHzAdLCKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Fa+wGPVr; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fa+wGPVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EI0wcnEl5f8bK9jP52+TvqYWfNcoL1VA0aZpOp169BWqCSAnc45aP4KRGRHNBJRbFTBhBqoobauRxqNGjGjgJSGHHvTFhxv4UKYj9JkQxJLxbMPg6fFvNtmh0vmJa5TfQPYQheJVo0bQAnYwvRunezO59Q6KJ3On1hBUxRf+7pBa0kGZ0H1BWKgerVeng0NOxFsRuXJ5PcNJL1+JhH+m0I5WVV2uMGxlezocbYiiWlqnHVnswYrja+gKZqDvHGVnPydc0fNEH8W3Ms/EmwO/udWdxfDQhI5EubeV0Qm+wQaVcBq58ni2CRWsqteg6Bd516CkjnX3T0Pfq51Aof7Pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA19Y0/0v61Rl6IlValoIm0l3LqKgtbPnaywd/8yp/Q=;
 b=stkg7osJAz6eoO87qfFYL4AQDnZ+GN05RvgJiC/zX2jEjxtdbiV5TeaVYdKstklUhl/e9BP1IjuLBOu+w2t503gV6VWa92eQBhi6nmylKX6aoVx0IRzKBGLPObjOyW+qjGFQT+Lx9XRPrJiK+zBVMH9kP7ABqgvocG1cYXAw/HhOFGpQ0tyMTQGtESt4zvvdKLBiH6VyU07AqxNCIFe6CtHxYLkZEQ+kMojhgkO1s/+Oy2R0bK+HRfjPB5i6jd25hsWbJ1h/zIcJWf4hVkP1rEQkBBFE/WGsNH5Kr/lgLWMTkTGKTgUv/FSTQH9BeX/1BZo/Eyy+jdfLHxR1ankeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA19Y0/0v61Rl6IlValoIm0l3LqKgtbPnaywd/8yp/Q=;
 b=Fa+wGPVrq/9dEoi/0z9ZI7pacuTgUOGJDEOsARAsUfV/XvgLWcpj8GZF8sc9sM60MkTo7LNd4yE8hlMpOWS3dkykT6hAQ3JQaxj+yZquYMID7WkcL7aHKqhGUcO94EpzmKqE2z6GfbHnzhkV3hzBCdlXDM9rOWxFckIjlTOvChg1wQ+lRRGfrupI43jDbvIeIWM4NHYuTNhRWIg55rDfZ6ewhhePbTPzCZVVXId3DCMGZrDUQwL0jSDAGsawWiLn0HAptWKQ5yxVYrUFdxSn92qz9giFqRUDSPd548S+eXDfyVBFcFXKNzDjeRM7bs4JtCKw8PJI8dUZ2ubdGp3cDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:57:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:57:58 +0000
Date: Mon, 24 Aug 2026 09:57:49 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: phucduc.bui@gmail.com
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: fec: only stop PTP if it was initialized
Message-ID: <aoxb7aqGAOUjrg6C@SMW015318>
References: <20260824100834.31655-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824100834.31655-1-phucduc.bui@gmail.com>
X-ClientProxiedBy: SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2460fe56-4496-47b4-dcbc-08df01f01592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|19092799006|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Asg0nnx2FX+H10FYB54Mtym95cd9PmcNqLNrRgXcZEPwEYvxoULfpDOgeFRlYaUnebhPexapAcz7V7LujrjfTi2O8aTaA/nwlK6MjBSq47Dcwdf1pC3dCZ+JTZZmc/H3vVZ5BeZOU27K+57Z7R6VdU6GdSv/TFVgpCUGIszB69KG49GNPHn+52gLI39yao0Xny6d4sfRql9cbJ8Z6YG65YRSK5TC31pp6oAZqySOkNuWN0U9/BvPtAC/Enfu3G9EKOeb+rD5PyzS4DkIi0kAh4XlUuVhMwu+vut5Mts03ionPdW5JT3C6Lwv7spNBxiv7Azcc6T7NdcyX181leYHjgxzvqIbfYa25ma1GhM2saI1s2rTcOlGUCITuu4DrvdDTnRWgNPwLZ1tGD+5XMxT2zwlqgw5axDMzD+GDCI6v2Y2/9X/Ofcz6zYWBp4fXLLJLSjm5kwG6ZEJsR/Mxumrj736JuMP9RVm/I22TCUTRx7042ktO3NOiNUgGE2qqESWqycc7ZBZqq/4LlR/zURo29KH06v2D/ikSl8njBijDbudvMvcHrSKGxiKICwfWGJP/+wBNnNcZP1HsPtDF4kr6260pRjDJ4qfLM7i7UdPGQ5SN26JPm7ITNIBN4zHJjGq0BBHEoe9lBX9HUOAUWFXApiE+tgih7P9jjOzDkDFxKo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewa9tw6xYJcuJVYQEpVx0cLTQhQ79r4qIfXocG2EkfBJRwqg9H4sIIedgVb/?=
 =?us-ascii?Q?DI08wDFlPacE0G89iyMCPMC3qTJ5amuXB/WOhtS9dX0nW9M4WntQLE5ZuNjI?=
 =?us-ascii?Q?CCbI6rnVfGW9Xexo98L/2szDFV83mGF4PM0iXtjHHw/bkflI+M7MVdBag+4g?=
 =?us-ascii?Q?aDQ+DtbQTHngSzfdCKULQqe1IoOKCLXiGPT9ujgg+FlppHHxQS8gxh6ZCOjF?=
 =?us-ascii?Q?z37oxSXUq5ZZ0nv7VS/h6TPXa9AfUqKqukiiGZ5yF3Xi9ZOOySj3wYyj+ZVW?=
 =?us-ascii?Q?OEyr3fnojn7etxgNdZJl7CwiuwFHS3HHZasHPetm7iMxMIEjSFsqcj24i6r3?=
 =?us-ascii?Q?NbgyLuDJmBC0M/QemoTUcXyC6SXiTlUivwpwsESprCPigzoZSd8W7nmXCqsy?=
 =?us-ascii?Q?VrgBOL9e00lJLyy3o1tyaENk7B2qgUAq3q6El0fgluy8DeGp6YuzIdajJ3By?=
 =?us-ascii?Q?qM4kVOwN/OjjPZdG+orAT1pb81YTAR6BGbA6HxUh5+YVsN+fzUk/wAYrauRP?=
 =?us-ascii?Q?Jq7hn4hvaitiMGILABe41oaz6A7Y18tlOmY2YqvvSKml37BylaXh/i8JOEOP?=
 =?us-ascii?Q?o9p1P2lk3Cr6/hchmxqKX4uaH4iqJ5KVPR6D4/EGurMVvJecw3CuMKregKRe?=
 =?us-ascii?Q?Bl7L4qKh7NZ7EO45MAjYppcUFIcM4oKKObVw9y3TqRAMcKNO3tX8tld7w4P5?=
 =?us-ascii?Q?orTB4Dt7NAT2GH2fnYy1fNaENrJRjqLgQ2yxuUrWN01O7KuHpaphbSmbxxMW?=
 =?us-ascii?Q?Dx4GAaoCi/CgKe4dsTxQqZirqoG0R/kIO86Ml5/EhUPqqsn0O2VnvyANaSe+?=
 =?us-ascii?Q?Q/9ElvOLB926XibS1voOiJIT2gmfkKx1KNO8+zcExIiITAevMNzoSvQZLq2K?=
 =?us-ascii?Q?usCKQshbitvGqXbTqcNmz/lo8QUMrr1sbkLKUpDXRqxBsed9SVS3eaoYuJJ4?=
 =?us-ascii?Q?w64vDPxfJPP3IdCpdk51JEwG82SQ6XANTx8cHqsScV8t60OR/hdtJ57ors9q?=
 =?us-ascii?Q?+9gknMgQhnEsF2tiuJnnc5IX0BNgnD5o6Wl2CUfgNHKhQ+74sduYWqJgDDIl?=
 =?us-ascii?Q?pHZ+/GJJHamwHdkx7jyKGTSiHYiuVDqxi+pQifdlqS+fXBwyqv1opx2odyG7?=
 =?us-ascii?Q?QJfIUuXDJi6MfSHqssRBPXuBAgFbsPaSuCJz4lsR1C10LabEEHMUp/fCmYRk?=
 =?us-ascii?Q?V+JliuR39ttUvkBpZdkSu1LzGWFrw0y8QgNfUu5HT5kXHW+to3fQNJV1Q2a2?=
 =?us-ascii?Q?KwoS2de5yyWXXURV3pUO485pJ6o2cfIjg3gfnLYjIkK6lk9Mnlh5B2SJ/pMo?=
 =?us-ascii?Q?+iY+Vfxec13FvkDSaPv2G00Ay1S7xOk0Ei64vXO2mAI1mikLzc0v1tCcSULz?=
 =?us-ascii?Q?lgIlG14Ybar+jA7FgX0rKr9jhzxSCp5N9t+Rmp+xG2otyIT/pegdEy8epuBQ?=
 =?us-ascii?Q?tcCW8Tbud7IjyJKpbowLR/oiaJPEgtIeclScx2xlawI4fExFr4DJI3TKWLaX?=
 =?us-ascii?Q?fvoQzE/juTcFmlF73U0qHE2Pm3aSaKgIm/7mp4Roz4NGtTcaPhGrKH99sDOC?=
 =?us-ascii?Q?nDJR52UskBFH4v0Snb8JmYVnumGsltflYy3cY5fSklJuq2zUqkyuaDMQ9d1R?=
 =?us-ascii?Q?lZlC04YuuoIrVGfjsoDcV9bTtSRoxSnCFakLIMB2juLw8fha2oEka0qwPA3X?=
 =?us-ascii?Q?JNulcMjlK9vD8fUZPCSwFQWwFEvEes6JLw+8gnq0QIHipgzGR+gAGK9pzLpD?=
 =?us-ascii?Q?wxLyue7y17nVXnRkltSMEuYfkUeiNG6YAndXX4iOMwWiOxrAOTyW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460fe56-4496-47b4-dcbc-08df01f01592
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:57:57.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzkUIFw8Ug4Rpq7bhpUUDYhmJJd01knkWvFtpDDZj3zAdb3mdKUG38bK1sgtUc2eM3HSMi81/e8/U2CRcO1VLSm293VaJ7IEUsQsBrHyjiAN6HG841L4UlW3NofLp76r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

On Mon, Aug 24, 2026 at 05:08:34PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> fec_ptp_init() is only called when fep->bufdesc_ex is available.
> However, fec_probe() unconditionally calls fec_ptp_stop() on the
> failed_init path.
>
> Check fep->bufdesc_ex before calling fec_ptp_stop() to avoid stopping
> PTP when it was not initialized.
>
> Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index ced4dbf8cd90..7a87f40d12d9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5457,7 +5457,8 @@ fec_probe(struct platform_device *pdev)
>  failed_irq:
>  	fec_enet_deinit(ndev);
>  failed_init:
> -	fec_ptp_stop(pdev);
> +	if (fep->bufdesc_ex)
> +		fec_ptp_stop(pdev);
>  failed_reset:
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --
> 2.43.0
>
>
