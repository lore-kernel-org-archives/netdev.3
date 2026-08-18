Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5103912FF69;
	Tue, 18 Aug 2026 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035294; cv=fail; b=OFl8jl1wrRSZ1N6qUCLMVXh+pjCWAbs5710DPLFilTTgKm+sZVU+pyeERtbiXjQCnRS2zR7wRvl6dlS1IZ5da7bXizKkRQKnHNfWVXdKY4GD+AkXQQYWcNORYlGgVroxatopf87mTm6IbTOAWa/pHdqaJ5YIY4B+NWBF7fi74Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035294; c=relaxed/simple;
	bh=Zq6Ufun4OWl57guMHmK7tKbVOWNybhkvc30QvjxGZOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pp0Wge0CmesqplfMVTlz9Vfc+ZFxxTRdz7RNu/OojFdvg6sNVhZu0UrmGSMVOJEJgqoF+olmKbCfsjtUAE4wRLbfmyeFSjWTOCGWOzw1lRHfeFarb9u38E10qNmedZ0KqNZsRY5MnsCPj4vzIkIMG16yWKD58E0SFTWZtV05bG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TO+sMdO2; arc=fail smtp.client-ip=52.101.46.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TO+sMdO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQm7OKnWQs+n0SleG2gXOTNG/v1yr6JPzUEKs2SzKDbEvmmN9CfeA++lPh/1XbBG6pWwzbZDg+316JKv5BmP5ba9pI/3fiCycPq1EYhUc1uyrx/prPLWeskRMPDvTAmnSbHr4UAxExBoLbyiDiXaAbpjb/S3mwsXQeqYBZmIjPBaJnI0gpDO6BZ3rDHKX96wh5N7YUFvj/SUTcGlBMqe61LHRXjq21U+cfOchru4+XxbEdWzD6wbsAP55+bLg7E8CXsyRb+Ty8DvQe/PkxKYTpszZRbBoYkUEr/9xSkiJz8S+uP1avVoFmKlqTjXfHtsyymunLIrQ+8dScBvg4F+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjPhTqBoOyCBi5yKWo9xmK8sbR2T5iya/eYTYZafynQ=;
 b=rS9IgujlTLpZLdTYe7cvRuLAjY5hE8Tbqx44FvIo48NSfjK/ojJmimt0ZRld/+RJqCQubp87IlVL1CauOwPTn4sMMcR53JoX3iQb7QFjFcIYIfgHn/cV8Kjn2BI8Igdf7e481YTbCjhO5JSKcNI4L/oe79hpRHUBCukpjG95eI46zzMn8MhbRfjCmodh2pxkeVhG76Q7bGoKmd1rNoPqYJjQDME9EmN3Jx/wJYjNz7iwoKGSOoCNq9dSrAbF66yJyY9Tcew39GXEvSEfV3A09xNZpJsHWR64TszqMOYluy2O2pX03Bzv6ZmjH8KzCaieMsvPHzCCFDSyUjp852f3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjPhTqBoOyCBi5yKWo9xmK8sbR2T5iya/eYTYZafynQ=;
 b=TO+sMdO2nvg4i06aA/ENGupenqxgjDGb0fN8ePg5mB/NV6jI93/6ExY2cLz54Oh4Te7SmQCDGEIPId0400nq1+zv+GpRoqk2xvM4a5SnUG3NXqDj4/vwYbl9OTJlWydD5Mypx5F8NqfXdfyqtWzpXggmtjoL5P3nnAiB795H5MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 18 Aug
 2026 06:41:30 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:41:30 +0000
Message-ID: <a371aac8-2723-45d1-a226-1f523cd3d881@amd.com>
Date: Tue, 18 Aug 2026 12:11:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: xilinx: axienet: Propagate errors from
 platform_get_irq()
To: phucduc.bui@gmail.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260817105241.63345-1-phucduc.bui@gmail.com>
 <20260817105241.63345-3-phucduc.bui@gmail.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260817105241.63345-3-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SA0PR12MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: 779f87f1-fc33-4e22-ee0e-08defcf3ba88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	KH2QDpnDY5T1mErdk1CQuul/18ltBVtSN+Ru2EUgfIaQHiDl7df5JFp/SeVOgO80DVeB39fyC678fIdQgl/GKkBWtkqThKXLf0NeM31UgNe59gzpDoGt/+Mvn/ymLFyFP0VtpQz5gacH+S4b+Zw4iFACAnrdsVcfcyUZeQ4/GcsViY3omKXSUv0hCWUG+Cg97B5Z3/+45urLTzT8IB++YZlt5mC7WeIsF3ZyyJP0ax7NwuG4SAXW1qYXcQbvtex4tTR1mJXiyJbt8//+qwTrh3s7DCYJhvnGRYmKv7awcLTd+uKG0qJ+0Ev4iqf3HujhodhG2e3x5YllZN+izJZpdUJWNsegwDjo3Ic+BNfW6IZM87Rp2lhgaeNAsdmbC81vgKk9tjhUQRAfXx2MYEpmvFEOuxhV9G6ZG8jqIcmjMOMo0m9ZQcCMf14r/WFERxdBjCeQK2w61ROSKN9GUxtJdc12psEbDnXkPhPzsksfuYruqTUMD55vcS9UGpRUQDgy52vfCnyMNLPFEgzuOc2DsjRqz13pqkBjjUhzRvoAC2j7lNkIPY2hDDVLS6XfcMiCc02qlViftWPxioV0ZIN9Ktj6VTNVpVif1Dth0a54SOF2835jR22EU370jInelhmHz0gWf9EnyXKrjtrE2ysH+GySlZJXzAl/dgjAddeI/7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDMwK2hxYjVBbmVZVHZIVnU5NFpyVXdFTElhNTBXVGhZUTRsQmQ0Y3VMaFVG?=
 =?utf-8?B?RXhMbTlsRTNYN0Rwd2ZWSHNwSnhVRCtLb0ZsVG1KcWRWcVBmR3o4VjROcEcw?=
 =?utf-8?B?cmRNbXZ1YVhuOXNtMTFtNW1OSEtrTjBZdkY4NXNQY2R6YmN3SkZUbitSaXRL?=
 =?utf-8?B?N1VhV0xPUWY3WWJFK0g4bytVWFJncFF3QldWWjN4OENRK2x3cFl5UDA0Q2NW?=
 =?utf-8?B?TzEzY2N2RnUwTEJRNmJGWmxtVzArd3I5ejg1TU9YbXMrQU8vOEpDaGl5N1Rm?=
 =?utf-8?B?K2tmeGFvY0UzblNQd0xYVDRKZHErQ1FwU1FvV1o2VUcxZlU4d25sR3V4RmVX?=
 =?utf-8?B?cE5HU0VYelZIbGhaUS9aMktBK0pVWWRmeVExRUU0Smp1bFljV0RLV2JLNXlx?=
 =?utf-8?B?V1BFZFBWbWJDSnZNRmdWSGdQV2I4Z2lKeDA1bityOGNZUDJvOWYwc3g2RjN4?=
 =?utf-8?B?bldrZU43WEczWDQrR1FhUlh0ZUpjd0J4RW9TYktPRmRzWnFBSUJjSElpRXVX?=
 =?utf-8?B?cUlsdzN1UEFKbjFSaFZ5MzdaS1N5WjViTytMV2ZPRTZPUy8xZ3VMUlRUeU0v?=
 =?utf-8?B?RUdGeG9vN0xld2Rjb053ak5hekFnZ1FqNlVobVBkZVM0Tmx4SnZLMnk3YmlH?=
 =?utf-8?B?eFZ3YjF5TTQ5VmFyN1d2dVpPazNPZDlxTlI5bW50NTZNdlNvb3FtVVpIZkdO?=
 =?utf-8?B?Z1pmVUtrMHBUOGRZZVFicTlCOUV2ZHp5ZFc1NWwydTh3cGZQU0dRQ3dmS1Vm?=
 =?utf-8?B?ZHpleThqaXhYdEllWnN4R1dsZVQyYXNzWlJZcXp1M1c0YllFMm11WGtzdHc4?=
 =?utf-8?B?S0d1QzYxcUd3bDBReDg3ZlRHUVFGeU9iVDhDWUNzVXV3QU9tZFVhVmV5enZD?=
 =?utf-8?B?U0hXL1VaVk41UitwbmY0MDdVd2drNUg0R1hEVFRwY2RHaUV1RnhkZkp1TW02?=
 =?utf-8?B?TG8vWFNzTi9Rd1gzaS9CM29KcnA0SWlYaHFNc043VkdTRXcxUjVzQUllTmtz?=
 =?utf-8?B?Q0tVN2lTbVo0Z1dpQ3RJb3Bualdjb1hGTGNsTU1tMWYzU3NFb3dMVDJtbEli?=
 =?utf-8?B?VnpubkNqa1pRUzUwdjlNdWFGMkZ6OW0wa29sSUczU3dEMExVUnVPT0E2RTUy?=
 =?utf-8?B?aDc0dXJKRm1hUGtoV2tLUm9EQnNPQU15eWwxOUhvSWZ0TElsdXNhMzUwejhE?=
 =?utf-8?B?WGF6VEppUzNITVhxSlI1dHQ2b1NOYXlIV1RZaWtnUy80WFZyVW5SbHhkdWpa?=
 =?utf-8?B?bUgwSnZvYVdEK1BzLzBGR0ZQWEhCOEtFSzlnbjJhR0lXZnhzTXd1VEVpczZP?=
 =?utf-8?B?OGlrZ3VEWDVHa3l0WjFLdU9yVm5nZkVoMmQvc3BxYTIvMWdVa1k0Z203bXoy?=
 =?utf-8?B?bXFXaEdEV0ZFQTRWOWdPQjM5V0g3Q0plK2FCcEY2SjJibk03ZXFUZDh1MTFN?=
 =?utf-8?B?Y1RKK0ZhOGZNU0JHVGU1cWxuYnNER3oxZkZDS2tmcHFLekt4VnpLeG1GQ1J2?=
 =?utf-8?B?a0Z2dzh0aCt2SkpwMmJaa0NqSXVCWjhoVG9vWDZtTjRGODVIZ20zUHptc2dL?=
 =?utf-8?B?VTltYTM3TGEyUlVWN0hEVWh5RzI2WlpVR3VoOGFLck9hOUZVOGNhbUJ2Ky9S?=
 =?utf-8?B?Zk4ycVZyTDluYlQ5Q2ZWOEx0UWcrZThHREtJVTY3NDBib2g5WjR0eFNBV2Uz?=
 =?utf-8?B?OFoweTZxc21IOEg4a25GZXA4azI0bS9VWFlZVmg4a0c3TlBIaTJ3aGc5TVA5?=
 =?utf-8?B?d1d4TFBFNXIwSmhpZVhzdnp3bzJqb2p2R3ZEc29vRTh4dTJxaTJ3NkdMU2w2?=
 =?utf-8?B?MEFBQWdKQ3ZYK05IZzhZNXM1cjlaR2JsSVlxM0gxRUcwaHNtekcwOWZKZmQ4?=
 =?utf-8?B?THpjRm9Da20wVFJLb2ZlUDY1akJlMDdVeWFnOTdGU3V3Wk1RTDA5bC9lV21a?=
 =?utf-8?B?Ykd4VUNlc1dyeVVWV0piQW84YjhXSnd5bGlUSkFjMWJibWxWcVJlNWdzczVW?=
 =?utf-8?B?VFZubVNvOXRXemRzRnIyYUt3ZzM0T2ZIVEljNTVLbjg5bk40dkVnZTZGaS9a?=
 =?utf-8?B?bjRvSUhrVUVnWDlDN3R0b1dXWTRGQ1doeUIrMUhyUGc0Nm1qWkp6d3NQckJC?=
 =?utf-8?B?Nnd5NjVkV1dydFA2SjlCRndZWWhUR1ZkVjBsN1FHdFgyYWNzakd3SXhZaWNy?=
 =?utf-8?B?d0VtQjhuSVVhcW8xa09adHY3b0lvQXN1QXU4Z2d4eUM4ak5hM3YrUDBwYWVu?=
 =?utf-8?B?YWZUU1NINzNYbmFSTmhPQk5aU0hXUDZ5eG9mTU00cllDeXI4RUROUi92eXFt?=
 =?utf-8?B?bm9xRW1WK1paZGxORDFXZ0Q1cFBidXIvVFdCc0JtQUJwbTcxNVFqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779f87f1-fc33-4e22-ee0e-08defcf3ba88
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:41:29.9208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MX5shA6rzJRhiSXNP1a41Ods5Si0nCDeJ3SbQfdFYC8vajmIj1QzuaED69JIJ2Ww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383

On 8/17/2026 4:22 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq() returns a non-zero IRQ number on success and a
> negative error number on failure. Therefore, 0 should not be treated
> as an invalid IRQ number.
> 
> Propagate the original error code instead of overwriting it with
> -ENOMEM.
> 
> Remove the redundant error message since platform_get_irq() already
> reports errors when the IRQ lookup fails.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
This is a bug fix. So please add a fixes tag and same for 1/3 patch.

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 50f88a38b6f6..d982ab6f8a4a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2968,10 +2968,10 @@ static int axienet_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "could not map DMA regs\n");
>   			return PTR_ERR(lp->dma_regs);
>   		}
> -		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
> -			dev_err(&pdev->dev, "could not determine irqs\n");
> -			return -ENOMEM;
> -		}
> +		if (lp->rx_irq < 0)
> +			return lp->rx_irq;
> +		if (lp->tx_irq < 0)
> +			return lp->tx_irq;
>   		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
>   			return lp->eth_irq;
>   

