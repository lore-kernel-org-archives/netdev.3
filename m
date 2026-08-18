Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1047CC75;
	Tue, 18 Aug 2026 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079965; cv=fail; b=APlgXQeF7fGbsOac2hImaw2wd8U+YT64roB4FYeQPmCPqKx8ky4adwNbgz4HTKNb7yKubOdbfAcpbGY9Jn2Z/KNRabgM0kltIqlGiZtdyaQyflC7Z2N7VmYn5YEnaN5xcCrVaZZmqbLBEtdcs8+I4UR4nGiY46jYYz9GSRybtKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079965; c=relaxed/simple;
	bh=rSqi6mo3Gg5HeSEIFu83/0vAIHUUTJssQFVqUbSPzFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GzNdzeHN9x8mhc1sYwS5s0bT24AzZ67t0MLTBNhRwieLiHY9WPdI2fWp/RGuxkCvR2UkKQK9gmVGwr2+2OwAhVjK+LvmY+7BaFdiH9pxOYLX0RW18Ep6ttq0779WvC5/4TuyLJHTgNOIHmW53oRlhI0AyRMPpCzmr+OZRl+Ng+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=raTO4Y25; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="raTO4Y25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqUTs6vf5Bsd6Y61o/7SJU12GTF57j/DJMs0AfvYZ38jesAoanEaO04evUfpx5hQmKo0H0qxYieh++U0jQ1U9smJ0TojuQprZWSkm1lzo4M4U4S9MN4Zgec/VONyZVk1ex6y4pW3EMaxWgmhDGWSO4dafJofll1dj3uhKM5NyPVi2t0wm1ET+CHIF7DdJezoNnE4ksbd0QX6vqHM/QhfVMXW/JZgx+rZEgmq2L/XBEGBimalreK3NYhhGO1rwNZ/CIXHx/dUBSMMWWawfjaVP4cCKZhDdlVgSE6OUCWmKVzHBWMLQ1YktXd9+D1bQ1wRIbXWYiIwE6KRtuT2IyIAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR+iuP4ovX54M7Vhx02kxqrTI0iPAHdZvM/V0prXjOQ=;
 b=Q6S3SyNnieJH8IBLvW4lWQCiAyXNKhDz8hCpS13Rw/R2Yz3DOC7bRmEIOYMZ/Q8BO7Pv9i/3/lVd7lbjcGgFVyf/RlGhwaiQ2GdtpH2RsKPmohKhzw8LCHA8DandP+nZTIJaGB8wRL8CGPozi5pE/DHRYQiLkV+qZAQYKDktCj12LWsAZrz6xPbHDZJYsRhMuc4hEdB8ycnUUSv7U5/9pjwjawBOUY+dbgb0ZImMyJTeFOYJKW62vN6tHfXYgRVD2PK+d48OjGCvYxRJ91V/8bD6ZcGEYSepgX7cNsd6May8DWhx9TIps1viM3lrAKdlX7e3OEpuN3M7Ee/v+xqEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR+iuP4ovX54M7Vhx02kxqrTI0iPAHdZvM/V0prXjOQ=;
 b=raTO4Y25OGjX8rsEZYGtR7teg/gTAmOH3oH2xSkxtl3oaasbmjHs51v8ntzNb8k3uIrgx+p2FWQQXWX00eQqnCDoFGuyqcJ2u4+3+miZYIOEIuZHb0h9m3W8bTJ+O3AicoMlHoUjtSio1HNgxaneKH5n62Mp70d3Z50NyCJjUvUzNGIVUA0JXxYAGy1oj85h+KyJBAtJKwys4HsoHDxipG7HzyBDvBdjXIPv1NQHDUvdWDgpGdrwaBO74+obxlgvuTpgtrvYO5gb755vZ/1roYv2tBBTZ5S2GfXC32fA5GrbS0akeNylQtBvudJndbMF89C0Yaiv08SB3pI+hAkkjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AS4PR04MB9714.eurprd04.prod.outlook.com (2603:10a6:20b:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 19:05:56 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 19:05:56 +0000
Date: Tue, 18 Aug 2026 14:05:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Marek Vasut <marex@nabladev.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Alex Bereza <alex@bereza.email>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	dmaengine@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH V6 2/4] dmaengine: xilinx_dma: Move descriptors to done
 list based on completion bit
Message-ID: <aoStCsYpjNrmwuAd@SMW015318>
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
 <20260818174151.1608971-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818174151.1608971-3-srinivas.neeli@amd.com>
X-ClientProxiedBy: PH7PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:510:323::19) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AS4PR04MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 563bc530-1364-472f-64e4-08defd5bbb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|22082099003|18002099003|56012099006|6133799003|11063799006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fj6bUOVmbyQOdQySQaUoqf7P+PuR1l0wQCPBD9kVcj3IS8Skhf2MFdd+REhbLndy7SK6fNrcjZ4KCGO/vQf6VSF0qnRwSAsHFW3VEefzEK0V9haDzPBzjf4cEf3WZKOh23n2NNfIM76vBVT4RYX+2eyj0wUXeuahiy7YG3p8QAcS81SfX4MZQrvWhYnTooacuQVuhBdalhgiwI6UwwBW8NTDqU0Xbf8PouDNWinljiMKEVgttgNOowGXvxAMUU/D6o7O8vkujMvVZuFBbDatcZRmPJD5zxKtPijAkbM09JFRdUEI+lyxVfBMGiBS6j/783Bge/ENzgdm2dWNa0LUYzs3Sd2r+HgZuDvwIqB6ZPfK+LBtn70OjHj7wtFCVmSp91DN2FNZ9fFo62UnMaKV4k1T+AhF1VLVkiXvmoeqctDSuogbMys+WQ7016WHvQ9RQNS7SOBDv5ztx++KG40D5DJhLlyiURquJ0Lkr/ZTMlVYJ8Ls9exyxMMa4QCIuMYYWVVPYfYg1IyqVMYeymZ2YgjkOaSTnYSwEbBg3Ox3m98yk/CipudBqqbASnTlbI8bQmyQnGm15r0qkTmaWFwDgEaJByIselK074T33d8FX7BjMExo/lVD6JZthVQ+ENubBj0RuiRftxyEuokanJwarav8bwQjJSgMs0nHpLEowWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(5023799004)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veBfwCcDAKB1uKvJCG8DbipnlUR2L1iqyjy7+Yk+5MJ7VB3xKwTIeu6qbXhz?=
 =?us-ascii?Q?GCxpSOTIy8l5wll326790YMs1k7cZrOy4iX2C1yE9eWQA2MbW1U5T6wmwXjM?=
 =?us-ascii?Q?kF12wU6mIQ7XYR7DvoRh6mqTaUgyEP63xPV1rtXC/XlhwJPlH8ShBeP0f0Uh?=
 =?us-ascii?Q?vJhNNrNvIpcdqaKxuWSODAoXHO2ZHTw3mGZbvL51iwrE9AAs99eHCT8RO7x2?=
 =?us-ascii?Q?hyc5DR54Xt+rGYzmafLiTBdNHg3m/tTy6gR/jAYTuoGH2QwkuyNZ5otHv0qJ?=
 =?us-ascii?Q?bGsUBDKB/JObBUgtwFUihR3wySbN6XwXfroLC6W3wP8GlrNQCrrrDP+CPr5f?=
 =?us-ascii?Q?mE3J+1l67UQ4TOjumd+iFeOKaLR0mg6cDbyERxPV9dtko4fSunNErjMaps6Z?=
 =?us-ascii?Q?4jmtLEwfKDinFGrIah0f5zyJ+pU1h+uKTwJt9+5X7RJf5sn+gG8g81Al4pi+?=
 =?us-ascii?Q?n4GV/RwObUphWUJBwS9gLYTLFrq/Lp0oa0U2nxmekeg4+K+UE9xlIkW6pzeS?=
 =?us-ascii?Q?UZF+U4tOhhUqycJAAqqfYj/Qj92Fz0DLHO0unDWF0C1mRR4up28wqH7RuDl9?=
 =?us-ascii?Q?Fy/7tOmKBnOXHa4SLbBU7m9JXMCybDY2/svFEhW1iW4VbJYs39kbLW1EAFi7?=
 =?us-ascii?Q?mKVoOGuSE8N+jr0UHqszAlVdjvDgOdDe1RsVD3jlRz8TuQ3aDNfG8f0T2+P3?=
 =?us-ascii?Q?epxloG0Qlx5AjudFvOIQOOwX2QpzdVx1fI6iCyQ+DmxhgL4/qqdoWBnUswjF?=
 =?us-ascii?Q?GbMWUfDrOU5HsvS/VFc1Hk4Xny2wcJXcXnjWDYkOnbSwo7QfLdbAkKLHcjjh?=
 =?us-ascii?Q?0vAco9HT85t4XA4G/sJ7TT9I7p9scbDiIk4tJ646TxjeoGIG2KaMjtEICR1p?=
 =?us-ascii?Q?yRPTXmqVTbAiO4Vjk+ROZ2nR/FPb5Q+nwm8xZVNtiMfQfJdBmHjDuAybZe4d?=
 =?us-ascii?Q?+suEUvTxyMY/4q8rStfQriEg0+u0BXM6MQBbVqzcNGILVb782hClPKHCoEXp?=
 =?us-ascii?Q?UKjIq1TiVOdOf4qpMS9VLgtv/j9OcdxF1vmBRqF6CbnEkA9f0DaQyJSiUbmp?=
 =?us-ascii?Q?APN9N7z3SVkx/Xv/wqE8olpcnTa4QlKUmTQuQULttMRjSXhPbQ5gfu48OEzw?=
 =?us-ascii?Q?es0ctcd2hsLk7T2Klai4NL3LXipIBGvDJFVVYWLTKPAAZ6XFdbYLeiiqr+Ht?=
 =?us-ascii?Q?DcXrbbIVLbQItOf1GQDJMrL65qAkvUBp+EY433wPCr+cHwD/nZnQsFvoAG4u?=
 =?us-ascii?Q?z5UyZHbjhN74hFcd6rxiSdSLU0fgkx6h7bIYPaP060zZsuz2fZWbqEEwznAU?=
 =?us-ascii?Q?SFmMyxbSwxgajJ+nvQV9wSC4GBHjnvyScc4/JvQnAR6BbO0ITEmuS+c3kRFh?=
 =?us-ascii?Q?JpEs8xS3EvRdIk0hDU9qm+mq1+V3KgfIQU4mqIbz4VCoXTBXAtnXAi8uUDoT?=
 =?us-ascii?Q?OI1YzYPShhA4Ab/yTOqxL4wGv/6DgjhqWyE2LyjgGu0K4/YX1vq9yzikxbQf?=
 =?us-ascii?Q?ChNd6sqJo3vg4zgfeMSaEPK8nzbvQRQXWmNCw+eIcZzZcz8z5zlxbeU+7wGY?=
 =?us-ascii?Q?VP20CTTDmpB9UYwFVfNM2TnCSpqCIe8jHx0j2orIvViukcS6kk+/WoL4/HjF?=
 =?us-ascii?Q?HxIFCtSg2cyYiK2NuQ/qu996v5M6NndcyFcHjnC/bso0DnH1QJM1mbPOjqyA?=
 =?us-ascii?Q?NUm1paYBN/HJIw4Oay6pIGZbVFMbvskeJ8Z6VA4o3J0krDWuFNG/b7XAtLtT?=
 =?us-ascii?Q?/YO/7vZrCpW69sDqbfILABSQvPwWgzjKJHVL/NgguTbTmF1CGzjk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563bc530-1364-472f-64e4-08defd5bbb72
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 19:05:56.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ai6xlmWzURfSjqL3hGVroDPcI5WuYflC2lQElreQqdwd+IF+soQqE1bEB6sRjqEj1++xZTIvYc0dw3mpXuyIBb93Va8zAoFebjpeLvZ+UqYcLx6+vtT9dzXpatW+Q1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9714

On Tue, Aug 18, 2026 at 11:11:49PM +0530, Srinivas Neeli wrote:
> In AXI MCDMA, xilinx_dma_complete_descriptor() walks the channel's
> active_list and unconditionally moves every entry to the done_list. The
> MCDMA IOC interrupt handler invokes this function on every
> interrupt-on-completion, but with interrupt coalescing (IRQThreshold > 1)
> an IOC interrupt may fire after only a subset of the queued descriptors
> have actually been processed by the hardware. As a result, descriptors
> whose completion bit is not yet set in the BD status were being reported
> as completed to client drivers.
>
> Add a check for the descriptor completion bit before moving entries from
> the active list to the done list, using the appropriate direction-
> specific status field (s2mm_status for DMA_DEV_TO_MEM, mm2s_status for
> DMA_MEM_TO_DEV).
>
> This mirrors the AXIDMA fix in commit 7bcdaa658102 ("dmaengine:
> xilinx_dma: Freeup active list based on descriptor completion bit").
>
> Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in V6:
>  - No change.
>
> Changes in V5:
>  - No change.
>
> Changes in V4:
>  - Reworded commit message to reference the AXIDMA fix it mirrors
>    (commit 7bcdaa658102).
>  - Added Reviewed-by: Radhey Shyam Pandey.
>
> Changes in V3:
>  - Added Fixes tag.
>  - Expanded commit message to explain the interrupt coalescing scenario
>    and why the has_sg guard is omitted for MCDMA.
>  - Changed local variable from 'bool completed' to 'u32 status' for
>    cleaner status field access.
>  - Simplified completion check logic.
>
> Changes in V2:
>  - No change.
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 2319101be778..506ce1ec29bc 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1784,6 +1784,17 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
>  					      struct xilinx_axidma_tx_segment, node);
>  			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>  				break;
> +		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +			struct xilinx_aximcdma_tx_segment *seg;
> +			u32 status;
> +
> +			seg = list_last_entry(&desc->segments,
> +					      struct xilinx_aximcdma_tx_segment,
> +					      node);
> +			status = (chan->direction == DMA_DEV_TO_MEM) ?
> +				seg->hw.s2mm_status : seg->hw.mm2s_status;
> +			if (!(status & XILINX_DMA_BD_COMP_MASK))
> +				break;
>  		}
>  		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
>  		    XDMA_TYPE_VDMA)
> --
> 2.43.0
>
