Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F67359A89;
	Tue, 18 Aug 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079444; cv=fail; b=AwoetF14GhGQ9UPbokFPr5lnTBevpilpXM8uoqpXE9he2ARqlQHHoexQv6sSEaDwznQ2zb7k5U/oBwdOoEmGI++nbtUSmI7n7ib9X7h4wXC1wKqb6pCuCFN9oHq1fR9B4ojUNSZVo1YZGaaF26t9vsBZozqGICNrWKpJQOJ2vEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079444; c=relaxed/simple;
	bh=oYkFPQZsdfJgB5SMkQP1vmcFkLuu8oe8wPjrNlA04cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxraODqV8NcJTQMhYwu+YRxgqPiPqrRx52YrTc0AuvhXT0PaNN493uxu46Rm3juFT2AdGXPRfzQsjNq64U0J2SPa5ETcqKYlep8EgrC+uzpXZsmgUUnvXONTHkj25IMET/kWB8Ph+8CY6uPFvBgaSKs+zTRCG057i3vi62uaIdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cs/aDEH2; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cs/aDEH2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doH8w6dipuQsbOGbmmyiJLGcM3zrpMJK24laDVFMktjl97skL0eh33ZZMOVxUQtr15h/Gc1E5kZkWqhfTkcPGfuUMKMJC6aj4Kt135seTOaoP1Z+6o6AyvDNKPEXwWc4BCIerT5pKhoUjn7dRoauR+MY9b0M5qOwRje9BOEKnY3m0Gn+wmSpqbxUIDvwX+ExHeRvl8rn7tkzpdEbOxrezO4ENEHU3/ely+tMYi7C0AethTlyNQyyJpTgP0bktzhleNEeT2tDtwkQDtqsrOAqYXoowWXWLKsrn4tfHtDaM3JA9ofLm9+5IYgvsOkvEF4O32GYJ/WVV5wvkfu5Kl0KLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whuvAtbG1XCjSulTSz3f7HvvdGqv5V67h3efiF3CAnc=;
 b=fnoqN1bTln6XrPTAMVTbs5KKoC73t2lV7/96NagwNC47jEvs25q9H7IQ2KhjOphqnblatwFCuqYiyBlRaVMTBhwZI3rSCYvPaMQq09f5lZeURPMi+HKYRdsmh6ANfKNoTQzvwK6O6ryC5gbsgHUhNb18s3oWfGlAnI74qwVy5PPaLQnihqgVT3W6Jbd3DpPpLBvscKGgpB873T5sCQBObdTJhtSh5SnVPB7dbezvs0fjNdKaLGYHtf0HxugRqeyc4XTT0Kdn+bPVMJAq+e0mSYLpXNV/o6tmD9zE1aJljXhkS3znTXncnst4BOB4wpLdFNP5/p+b6YzEjNFhMeWpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whuvAtbG1XCjSulTSz3f7HvvdGqv5V67h3efiF3CAnc=;
 b=cs/aDEH2CjYYP0lY8n0k5lt7XKNpcUVykGb/Yy+4B12qQL2bQ6Q65C8YLCbfCllbjietg0Pmm4zRilkNMU9WIYrf70U8sUeBFJGf4PdDjBNG8ZXo7JHMYK0dxDXk5IwL4762fH6MgxmnOPmQkTxp2fy63SetQ+VdB2VOJ0d+RnbjkYIFvVubrUAurjp6nVzGCuVdnsgE9JpYs0J6o7fTk5e9F82uFk7M/CrQfwuWaj229oCj/wHpoaYPvXgD+ruR2UpkXcvZEv6Cux92RH+wG+8pOuTARuIACVn1CptjvwIQDJ580GpMOEGak7y++mMlI/0+00TkG/p++siTqA61hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 18:57:19 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 18:57:19 +0000
Date: Tue, 18 Aug 2026 13:57:10 -0500
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
Subject: Re: [PATCH V6 1/4] dmaengine: xilinx_dma: Fix MCDMA descriptor
 fields based on DMA direction
Message-ID: <aoSrBrOV3ZznZdaH@SMW015318>
References: <20260818174151.1608971-1-srinivas.neeli@amd.com>
 <20260818174151.1608971-2-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818174151.1608971-2-srinivas.neeli@amd.com>
X-ClientProxiedBy: PH8PR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::19) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb4a873-5aa5-4980-fecb-08defd5a8761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|23010399003|366016|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CsBqDj9YsUmbLUVzCpi/zk6brw6epan1cAB4gx38vo+yaoI60uttWXAWTYm/GJ383JkjVUr/DLG6ewg1Tru8Sp/Y4ARCp3TcQO+bhlA2VR9myRWM13tuLPeIxr6hvbXwuWiqlyniUB6Q4ioNN6erFrYDVbrlu2ZVbInu9h+uF22oyGpFWd6kDgjP7RUqc0avlzcMScTqrsw9InzPyuvXacfvkJgNRrm9jX09Dfjx5iR6A8QuQN0F5PHvefFiymdGnTEcoqNPZQ75vTV9ybpBr1jrZPeo/yxZsSAOXr7UQnLaAbFsUsDW5aX9g4RFxwdru9ar7x4kfsGchrptW3vN9fAngRunHwYkH0an8YolTKZCkVLy699IfAIzO8NsMHJ5oTqfmdb+LNhZr/L3ecykK7lgHMl9/P89gdSggjGtIO1gCzklr/Ma3Hb0fU7CYm1G+Q4X7FCPiwPpHT8J3RVLxLztrELPsJ5drhQRXPg9OYi2HtctdiBa5sDdJaIvcqyaF6/WgpQFC2oP0dziiBvvwB45wd6keXSaUAEz1Dyopto8Swbv78GOuvZ2kuAylXft/NzjuOQmxDiknM4zP17h7XvuGEwFSmllNRlX8TZwBkdQbb3OtOwNL8IsC9LkcuFbzkrBby8FAkmW7FSxNmrocO2zWFTl2Swt3gUfisd9I4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(23010399003)(366016)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fk0GFx6Ks0EQZiymtpmJ0LpfuvMKkG3jNOuyuCRRzU4Jz2MNFi2MRmLuXhyM?=
 =?us-ascii?Q?jVenrRqqjSSB4i5QgK91A+YYpNHeEC00Z5poX4aNjgNBTJ2jfgC7Pwg/cbkF?=
 =?us-ascii?Q?zI7B1lmBiMjFdaq3Gkj0j8orCPzWrdNPbsUYnxQBdhWTW1592NIePOH6yF3t?=
 =?us-ascii?Q?oOKr+eAHX/pheTET0lB3oUJjYXfOkgg33udv2J6xv8ebiEVXNmCgxWkZrHoJ?=
 =?us-ascii?Q?B7cKi/j/e6Ys53frYcXtEnMyJAjgN/tzQ0ouB5vTFgoE4D68T5mbDPEF4VQe?=
 =?us-ascii?Q?XQVmsa7AGd4xHUR05ZqOecHaJeIelI2AgWmRpFNh3Da3oXp8m1DtyydTN9pT?=
 =?us-ascii?Q?u5qpdkn6vnuPq/NAMcPU/j6WuMsbUIFUgqIyzy2awrILMJUlMkg6OHimsxGU?=
 =?us-ascii?Q?XwoYH2mw34u1lKGbouye+OT6DNqsvVDTlKfNEz1KmIKNoAnw2jjRfR5iT7f8?=
 =?us-ascii?Q?8bEfz3OABljIMWbhozx/w7a2/MdYOaCxHAmtfluyu0E1hicjJ/4Iq58crJUR?=
 =?us-ascii?Q?xCTPxZ/wW54TS6w7e5W+tACpcVERUjn6gWI4Az8Ef3CtZ6ec1zcH5DjZebS9?=
 =?us-ascii?Q?y57Sx0S4iVcOFfREHynAvT3x8ylbr0i4uFsFj2+2bUtKo/FpidfZJiImPRga?=
 =?us-ascii?Q?CNuxlUtWtuZkmwEOwvqSO7VC1Y5uEGl2SKHc0Z4j84vLVpLRhgnetrE9oGZP?=
 =?us-ascii?Q?oNGl4kLn+220gsOky1gwxZAv26Jv9BzPfRXRfnNz3OwOR4Z9kcTosOpmcI1z?=
 =?us-ascii?Q?0LuDjWIFMfxVEwxXgDTjevjmJsGi2UPbQdVGxt9e619hA0HV9SZJwPSh9pRC?=
 =?us-ascii?Q?814EinO9Eo9goE3QeEAk4ThabCdFGA5VzUkKQ9V3HvHQ296rVj12M+OJtcnF?=
 =?us-ascii?Q?rlHuzWKe5OihUXh2zATUsGPzAKLNQ7noWyh+hEfB74UX0IdyjM0X1izCgZ49?=
 =?us-ascii?Q?8kGH1gRCzQY+zhlYJ9+Tsc7agCoMuE8M18AV6+nVPDisnI4+kB8ly64gVkZQ?=
 =?us-ascii?Q?c4Ucy/U81yLtClvyayQ0zoDVoJJZVwWVeeFrIRncYRVb6nmmevPs3u9Lv7e6?=
 =?us-ascii?Q?YEiM+w3Cm6XkRaQqaARwyeXUS2w+WwPyyF/jZCW6tF9fMLj1Yx2EMlqwlrl1?=
 =?us-ascii?Q?JYqVtq6OgwkQorSuyf04tORraOL77H2D/SjC0ZXjvRRjcdyZmBa+t/on+Ro8?=
 =?us-ascii?Q?8l7Y99Ucrs5rIkh9pAo0lg+y/DYKt8Y/i87BJLR/c4mVwi6fm/Kus+KT5O1j?=
 =?us-ascii?Q?ejp369/EsAXo2kIlA8kLKnnVLzcMohQsJBdLMHUySJcqq1DiFyZLhDmDlmim?=
 =?us-ascii?Q?2zFmYLyHuOhpVeassWnniXYIdDSEmH09PyuLw+2YoSjZ/JSkV0Bj1LiK6ij0?=
 =?us-ascii?Q?wwWSz5NxR9oLDT6Ky25kevNmAYQnCaccRI5G5I03jI2ONpYRj+FnHcnezohq?=
 =?us-ascii?Q?8wYIZ46g/0sYwUDxGDGu7JrDfSkzv1lZyX5jR7p9TZV/3rwTLnO00+2Y/Uso?=
 =?us-ascii?Q?e5XlROTqvIS25eM/lfEXbnYWV0rSTlHRU0Kdlh8Fgt/B8P0/49BC2VLSxxBk?=
 =?us-ascii?Q?oqyN6yb0sjyVhreRp0zVMW5C7c6o3vtyX6diEbwxK6viYNQkqEFProW4N5SM?=
 =?us-ascii?Q?cwvRh91FmoJ4iOhE4AToSQlAcqNVZ56v+kq3NiCzgTV7qszTBsrO/Ne6O6oy?=
 =?us-ascii?Q?YYUoMoi7EO9F3+a8mTA8T0Gb7138tIOLOxU6nOntl2s0ltU1uaMTNE58ZP5s?=
 =?us-ascii?Q?zczYPjff9nguXO3ky0WTWK5AXyqE9/0yXy3ovmLAOUVgZMCmaUy+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb4a873-5aa5-4980-fecb-08defd5a8761
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 18:57:19.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP9tkrdX+X4ghMMtPG/m4MnWNbIWgvM8F5b1b8yxGoba1IBk3snhS8TI3UjD8Cbxv+xlEzwDJgdFFlJDoN7PzLc1lkwRglEPDvOq8QLHkiWncLmNfpDXCBMJNTNIzjRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

On Tue, Aug 18, 2026 at 11:11:48PM +0530, Srinivas Neeli wrote:
> The MCDMA BD format differs between memory-to-device (MM2S) and
> device-to-memory (S2MM) directions, but the driver was using generic
> 'status' and 'sideband_status' fields for both. This led to incorrect
> residue calculations when the hardware updates direction-specific fields.
>
> Refactor the descriptor structure to use unions with direction-specific
> field mappings, and update the residue calculation logic to select the
> correct status field based on DMA direction.
>
> This matches the hardware descriptor layout and fixes incorrect
> residue reporting.
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
>  - Added Reviewed-by: Radhey Shyam Pandey.
>
> Changes in V3:
>  - Renamed subject from "for MM2S vs S2MM" to "based on DMA direction".
>  - Reworded commit message for clarity.
>  - Added XILINX_MCDMA_BD_HW_SIZE macro and static_assert to verify
>    descriptor size at compile time.
>  - Refactored residue calculation to separate addition and subtraction
>    operations for better readability.
>
> Changes in V2:
>  - No change.
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index bef2b031dba1..2319101be778 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -223,6 +223,7 @@
>  #define XILINX_MCDMA_IRQ_ERR_MASK		BIT(7)
>  #define XILINX_MCDMA_BD_EOP			BIT(30)
>  #define XILINX_MCDMA_BD_SOP			BIT(31)
> +#define XILINX_MCDMA_BD_HW_SIZE			64
>
>  /**
>   * struct xilinx_vdma_desc_hw - Hardware Descriptor
> @@ -277,8 +278,10 @@ struct xilinx_axidma_desc_hw {
>   * @buf_addr_msb: MSB of Buffer address @0x0C
>   * @rsvd: Reserved field @0x10
>   * @control: Control Information field @0x14
> - * @status: Status field @0x18
> - * @sideband_status: Status of sideband signals @0x1C
> + * @mm2s_ctrl_sideband: Sideband control info for mm2s @0x18
> + * @s2mm_status: Status field for s2mm @0x18
> + * @mm2s_status: Status field for mm2s @0x1C
> + * @s2mm_sideband_status: Sideband status for s2mm @0x1C
>   * @app: APP Fields @0x20 - 0x30
>   */
>  struct xilinx_aximcdma_desc_hw {
> @@ -288,10 +291,17 @@ struct xilinx_aximcdma_desc_hw {
>  	u32 buf_addr_msb;
>  	u32 rsvd;
>  	u32 control;
> -	u32 status;
> -	u32 sideband_status;
> +	union {
> +		u32 mm2s_ctrl_sideband;
> +		u32 s2mm_status;
> +	};
> +	union {
> +		u32 mm2s_status;
> +		u32 s2mm_sideband_status;
> +	};
>  	u32 app[XILINX_DMA_NUM_APP_WORDS];
>  } __aligned(64);
> +static_assert(sizeof(struct xilinx_aximcdma_desc_hw) == XILINX_MCDMA_BD_HW_SIZE);
>
>  /**
>   * struct xilinx_cdma_desc_hw - Hardware Descriptor
> @@ -1015,9 +1025,11 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>  					   struct xilinx_aximcdma_tx_segment,
>  					   node);
>  			aximcdma_hw = &aximcdma_seg->hw;
> -			residue +=
> -				(aximcdma_hw->control & chan->xdev->max_buffer_len) -
> -				(aximcdma_hw->status & chan->xdev->max_buffer_len);
> +			residue += aximcdma_hw->control & chan->xdev->max_buffer_len;
> +			if (chan->direction == DMA_DEV_TO_MEM)
> +				residue -= aximcdma_hw->s2mm_status & chan->xdev->max_buffer_len;
> +			else
> +				residue -= aximcdma_hw->mm2s_status & chan->xdev->max_buffer_len;
>  		}
>  	}
>
> --
> 2.43.0
>
