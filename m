Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F894C9E0B;
	Wed, 16 Sep 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587766; cv=fail; b=a1qypofrEAXQZy8LAG3z1/zQjS1UNn2u9oRsu2+RewnvLOU3/5HGdycrfSLru72YVpOIS7jEWQGNVWJusQWJcptFfSLfWBxt7zfOZatfUiJ5wiyjdnJrQYQ9I6+KsdzrdnFjh42JXE+GTWFxI6JZAAT85k5Hks2qUhbEAmi8C4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587766; c=relaxed/simple;
	bh=OxzbhVo7ckIn/PKqwIvH3sBzyn0QmZldqhYxfPFEQY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ea2G5hZBP3+nebYMBv4R5N9KArHR5DVXduGxbN6GrNiHfrb4h6tLWBGT8Mw2x9k6ET5avX8twjhcpqeoz9q0BW9lNrcVX8pHcHKIGD9FcbTt8WB2hYQdrQ0+hR0a/9+IcLS8abcrmA3sbP40TrUGEVQdADywCQQc16Gu9SonPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qHUFmwo0; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qHUFmwo0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2zCvNRu92/DNOYuqygHcWo53ByBxwzK486V1jZWw1j8KjdzvEhWEssE54TmTtASG32NXXdcconftcH2eWvX4GYHJUeDSbMS7sSx0dpcSVEqiCpXPDECwUycaVLxpyYFyrav2AaQdvUUW/NqzlAnjq7VZ90TRNh1tAt6dqMq8HUlLCnfsx1hLJgt0IUQrm+FeHa2VedvRzoJm56G+MwDCuYEtwwixYe7fWW7dDGkFO3BrXX91snyJH+DcW7YffZebVnSZ6fCkyUNdQRGMKhxJLkBAjxoRITmoYSoabNvajiuzuKk7XCaLG4xwtlSur8FyrpDUkLnNMW9nNxgVoN1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ94gPoSlBVBjA57+k4dQUoKeLbvphQhJhWcsBOCPDs=;
 b=soDRV4AOcV4eKdsP5pP5dAi2jCpV0XM9luUJhgXSLnSuY2PnpsFJCANZoC2/TI/uU9DZXvqUTFRzH4NyEm92+SHWSi7Lg9XZ2ZHG467FX/cfNZg27Y0I1hGj+szkoe3eJxRKp7/jXuqoR9/Tx8QcO86lYLwQymCmxGf8+hCBWa5Y4i2nPPWH/egOk5+q9YJ4Qr9Fsa7kromdRGZV905vpR8ovXtvx0z4GsXNcrEnOANCDoi/JZO6hy2CGXWfIo5rs+Ft5/Mx8sLGkGP632USmbfcOXEjEL/BscVqfmMJetM1yHgn3zWMhiMN0hjxUdOKWF1vpbwCCu8GCAtLj8KDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ94gPoSlBVBjA57+k4dQUoKeLbvphQhJhWcsBOCPDs=;
 b=qHUFmwo047awKG84HEo/rIOubSwaHg2yljgo6cNlf05Z0WinzyKetqObJTHY3usY81ua1OjxgtYxCqdYdFsxbWpQQCGCnS2k5gVM9zfUlKOFQ8VpfZaSw30M/1gM+ZQyiumeKr6uY9UlUMuGNSngkWfm/DMsm418PItobxVkyN3n2PWJkIK4App4LFDegMK3xyahm3alloWAU3QYf78wkZht64BbyNJA/DeeXf7t6X0CsaxifhdMHe+UAPL5jI8rB7Msk43a4idde6xhNnYTj4VMU9P0e4xwmHBLSHEHbWn/qrL514FxTAUJFSkbp1S26CiuKImyDjWUDonGLqzW8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 19:42:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:42:25 +0000
Date: Wed, 16 Sep 2026 14:42:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: bestcomm: Enable compile testing
Message-ID: <aqrxFTWEsJmFIrel@SMW015318>
References: <20260915181709.11323-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915181709.11323-1-rosenp@gmail.com>
X-ClientProxiedBy: CY8P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 51185947-e0fd-4e51-c3a0-08df142aa268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|19092799006|376014|11063799006|6133799003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5Ukv9fn/FTVjHy6thG3+kshcOERY6tjtnpDmTf1FabwtR4LfzY+RIR9IO8XgMXuF0RLZQgDKIs1k6K2P4m85tRrRd4uUyC5Nng5KdWtrWnwwQPTasumJ7fHa9I7I+izv0y3SrD/Uj2s/M5jwZNW4BeQFzjJRnTkNav6DfF0qhH6n7zg3oxP6IC5UiD8wvyXTmu70RH1/tiX5qDF2YuxLUyiZLmDgZ/n88x7dvKr0+y1zYZWkPItc7O50SSklvoBAXpYgXy7X6xG8gevVMwo8csheNpwf1qyx+bDdhncNYaOmirfBRlBWJIId6jgKwZlwq+RlSd3rLm5jvcY32GqnMvLCHHIbLNWNZgaTnzS+8xZ2xpQtYzbAgU9kkehKuFuwkoYC/QAPZRVHdKOJzPCmtd6Pzd4BFeAPWzp65LCZgf7uemTppCq0MAElK3o4tbXqAGU8GiLqrtXVSc2mtQ3LduPAZafGCf/7wK3Kk6uPHyfFaFDDUP+pHbsi7v4pSoC0qkbxvE39XBkKFqGQ8Z8+8BwKWSxalk5Wu3OU9A0k0v35y5zlfdMOLChtOmclb03FgjJmOcMZMCCsNBOmD4CQQ62dlbjFt/nsB2KOvJKTds6midyYb54156XrFt3xoX6UKrerrSMO0ng+JP2suA0z9VkEHZI5JKXffpsrOYTNNJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(19092799006)(376014)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5McfBc3UefHfi5siTmjXC7mrbNGiOCCLbFeBskF0o/0sv1sJSnBwDswD1Ypz?=
 =?us-ascii?Q?XwyNqBZ0+cR5Zw3wYJHJ538+P7PlFdJXlW7ScW88YWJlzoVyrqY70fJVwhAY?=
 =?us-ascii?Q?zqWO1giOVWhaXhzqcG+lugWAOpOf/pTeInlCjI0c1nS66a4eKRqJtZKPYd9I?=
 =?us-ascii?Q?apXgz7MmIILjboYbcfv4Bis5as5RZ32jl0gN6WTcL/DzFubuFZjg+HqySbqc?=
 =?us-ascii?Q?i9azRC5OLGyBrqOR6UY7vHkTE1KDymbCQch/EzLiX/F0abJpHdg+i1XdQ3T0?=
 =?us-ascii?Q?gcBOPhOqSbmxPAATF4qHPhB4SAQPCQ7MQ9NgydAtEBNZGZDeHgmhIGgQZLaK?=
 =?us-ascii?Q?mOjTcWXRpdue4iPso6lpMiyB7IQ6if+ZzuOU0A1nSe6fRNO2lQ0u7oVV1raS?=
 =?us-ascii?Q?NjcELzKt2Y3F6Li8DwyDI708jI8WnFRmJucvm0DDFx1eLfuAeHi05oBhPM/u?=
 =?us-ascii?Q?75YkS/ZNGndWbvb7TbUpGYMMsvYVCYT7gcl40RrodQmuYI7q3MXU+oZk0yP5?=
 =?us-ascii?Q?2pIZ+XsCjW6IDgjnMWyQWY/Tu7UUm3Lohyx3U7yRQ2fY+imB0gpIM/rGOmNF?=
 =?us-ascii?Q?+jrYXW2Dh3iOyvoyFUswwNmVgcBkpTbLWz/pFjrmIfWjJa8/lDqp5ZtWt59k?=
 =?us-ascii?Q?gq93Lc73MslZBEnFHrnL5GJvvOJfG0Ha/S7Gkxpk/jum7TpcgYp3RH69VdUB?=
 =?us-ascii?Q?YF9qSX16Z6/lHts06SmRTtrFRnUPPxJl1NA1cUwWsIuvs/V2adkijf+AK/v4?=
 =?us-ascii?Q?qaISu9w/msrpHmOlJpEfaZJJHXFO/c/pUsy5P99WWOf2ajNq87ZCdC8t8zep?=
 =?us-ascii?Q?w9xjWI0mGNL0fkiO6RHwUbWArpkzhBLNgjDCn5o/20DbIcc5SeFxG2O7gJgA?=
 =?us-ascii?Q?Xsx00hpHjcblb6Nsd/23sTW0M+3uMLB19Fx9fIUQ/NxgMo15GUsMeJJXljEh?=
 =?us-ascii?Q?BfH6keDjGOjvTPB2TbFTawggFiyQMR7JtCVO3rzs8oH8mxCB2j1euFsrv2ln?=
 =?us-ascii?Q?rc7vXaU+VeTh1BT09YCL+e4qQ/5Y6ppk6ZI4Prg3sDnIojnwaj2Ltn8d7tfT?=
 =?us-ascii?Q?mJ3eqXf20F+sjGERcQnmgngdplSClALuekykU84E2QARAHb1nfKIW6sr1V95?=
 =?us-ascii?Q?2iL0MV+fqIJsZKX/SvtEDED4WZWeOSuc9VMU3+6ftwDIlMVM/9OF56LcGpmE?=
 =?us-ascii?Q?l6TsWiiMlTCh8yro8pYX3P5yDR2njzIzkHquT+R+SLPQxG8YjmiQshVAsVMI?=
 =?us-ascii?Q?mB99u87SfWnrQCoPX95kxa3AYmXHPR3IztV8nLzPh9oapPSweI4UzPcUJBsI?=
 =?us-ascii?Q?pd0Ta8LS3kqCiRnERc9r/NY8Uv7YJcSJPZaLGUwks8DxQMEt0TAs2ZRcmYnJ?=
 =?us-ascii?Q?DT2X+Yaghe62ch35nxwXDo8sEOQA1cxJaY8dAR10mO6bjSzS7pPJ52Z0rvvA?=
 =?us-ascii?Q?nU4pQPgNViZ0VkdfRKQidJzwbn9e5q1QTTZI1OfPo5C5GQsCUdJL58myKUhb?=
 =?us-ascii?Q?+LhrEERiaRvZ4Bxewv/cLSdsJ50NlIAbCjxNXI6niCIqXBuCi3XqOF8WqZvY?=
 =?us-ascii?Q?w8ZTUnmbpfj4FwkPYiW9yWOAylQ3KLReioAI8LMx8Ci0k5QjJEUjzVnf3xqD?=
 =?us-ascii?Q?VcfibvFMEFYEWAkOdQlyI29EJxkoCnGe1Dc4dQbZ9pZuYhSv5QNQPJ0oguQw?=
 =?us-ascii?Q?8UJGZTZbga1M+OFRWMLiwmw34rpArJwWb0BfwEkCndHLTzcQjCpLGqaw13tp?=
 =?us-ascii?Q?FuwUF2nW4mwLlH8rTXQ0NDzU4hpl3AwjkHri6zUlO/ljhKpoNEI5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51185947-e0fd-4e51-c3a0-08df142aa268
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:42:25.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8the8W4XWYvAcFr6I9GHFC4LGjP050mnsIF3/eA4pspHbOkm0p6+hUYjD3lbsyg3Z7rkan6iMFkZNsCfUUsw5A9Q5Ug0WcHnaS8DiTLO01851G6EEg8UsFTeIw8etLR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694

On Tue, Sep 15, 2026 at 11:17:09AM -0700, Rosen Penev wrote:
> Allow the BestComm DMA engine to be selected for PowerPC
> compile-test builds.
>
> The freescale ethernet and sound drivers now need a dependency on
> PPC_MPC52xx as they use headers/functions from that platform.
>
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/bestcomm/Kconfig           | 3 +--
>  drivers/net/ethernet/freescale/Kconfig | 2 +-
>  sound/soc/fsl/Kconfig                  | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
> index 5dd437295964..153b5492c93c 100644
> --- a/drivers/dma/bestcomm/Kconfig
> +++ b/drivers/dma/bestcomm/Kconfig
> @@ -5,7 +5,7 @@
>
>  config PPC_BESTCOMM
>  	tristate "Bestcomm DMA engine support"
> -	depends on PPC_MPC52xx
> +	depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
>  	default n
>  	select PPC_LIB_RHEAP
>  	help
> @@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
>  	depends on PPC_BESTCOMM
>  	help
>  	  This option enables the support for the GenBD tasks.
> -
> diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> index b34c0fcfddea..d81984fcec64 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -38,7 +38,7 @@ config FEC
>
>  config FEC_MPC52xx
>  	tristate "FEC MPC52xx driver"
> -	depends on PPC_BESTCOMM
> +	depends on PPC_BESTCOMM && PPC_MPC52xx

use seperate patch for difference subsystem.

Frank

>  	select CRC32
>  	select PHYLIB
>  	select PPC_BESTCOMM_FEC
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 04940879dfd8..101bc952aa14 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -234,7 +234,7 @@ config SND_SOC_MPC5200_I2S
>
>  config SND_SOC_MPC5200_AC97
>  	tristate "Freescale MPC5200 PSC in AC97 mode driver"
> -	depends on PPC_BESTCOMM
> +	depends on PPC_BESTCOMM && PPC_MPC52xx
>  	select SND_SOC_AC97_BUS
>  	select SND_MPC52xx_DMA
>  	select PPC_BESTCOMM_GEN_BD
> --
> 2.55.0
>
