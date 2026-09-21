Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85F35C6AA;
	Mon, 21 Sep 2026 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976619; cv=fail; b=Egv0E0yRPukuLJQ8RfIkvzMflFFHAb/LZag29xF6RUoqOnGK/i9s/Anx8oYN6iwKLLRFwKrwQ9mJKSz5VP2NY/1AEzS1uhxSBAcHMRaT2D6KeL4WXC7aj0vqXlvvMIhEycX5nFUm21GTuVw0YulUmnOClcJ3jEsmkpDczjvoRyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976619; c=relaxed/simple;
	bh=SvFyCzIGutcRjQUBRz9Kio9vb1oZ9nvZBsPe90o/kI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DppVNj/NGssixJnZEjX9oaLIG41gbeWB3FwdfOWkcrWfWUDvXgJHWn9mZIuB5svUZbt3Uf4VgjTWPor13HM3M+0eCabjk+T5O5Cvyb5zDImPtH80mnpl50sFoZTUZf86IIZfqPPteZogXcr0lyv9/Ez7i5H724q4K9tTux5kqxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=myvQfmRL; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="myvQfmRL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiq+2+M8/uy8W54oPTKimn9nkoTm+xmaCT7F+NEV0XOw9XIV/8QaV9rBV6pZUmz74y1NpXYa7sRBl9AOy5boVUmt1l6NXHDCcr4eM8w0/LmMwfvopDG0IGrmbzdRgktNPkxzBuoa8dENwkjRmoMoRVQZLn2FKrUig3XpC4urZhkY0YZvnF+mRAEXu/6C9xgHppkobn68tL+iZrFotEERurgBZeEYtjLL1Gvbl1ccT7+sIQEHp5qm3aoDsJfGXX2JLdfHKQjmKurMUXcTYEDLwVAk/Np5g/FIpLp/B3UcFOtPpIrh855RDK3giXEwbHUL0wNoOVFu8x5uNdjBwgyyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=575s0GFQJRx2z7gNbkrE9Rqk/zAnM1BjwloRj0Vc7AM=;
 b=dBTdKthe+DX7wPL8fXpl5EI+pVsipZ2wPbiEj1ZFICjIn/rjuYH+h4u8HWUMsgrIVdHpZQZ+O3EF6y0s19bqUlVDt8A2zzmCkAyV8XhzHDbJBeRPr6OrlTqDhlRWRrRxtGuvD+OLyYJT+hZmj3ygdzZ1LZHyMVEPLICHV4X5jRKgb1EKOAYhX3J+hYm86uRirdcEwsYfjtUUpyOtap3J3Gv2olkLfFzyaSR1KLhzYxizGLHL45S+5x5NerOi5/92vOrpMaTtfTs8d3VDMFtXYjbjBt9Wqj8CuKzsmM031wJ1c9mVJ8yiGo8j6pJN7wJ8aaAUrSmPhL8nBrglw+M5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=575s0GFQJRx2z7gNbkrE9Rqk/zAnM1BjwloRj0Vc7AM=;
 b=myvQfmRLbist/DS0zhpFvqHNCw/MuA2BHEvrhaRdCxIF2FuqvSO/ymY/vLBZRkMoIssTNSPjCbyT3Mv3K/nO15dCv0OLEUG97kfFcKaRvOH4685ZHegLKntqI6eyiYp0VDmLXYIQ5Ol+o1zBHsFJfsGzHcXNtxQh5t0MvCq6+4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:43:34 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0428.014; Mon, 21 Sep 2026
 07:43:34 +0000
Message-ID: <ef2f9f61-dc86-474a-82a1-ff761237a67c@amd.com>
Date: Mon, 21 Sep 2026 08:43:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: fix CONFIG_CXL_MEM dependency
To: Arnd Bergmann <arnd@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
 Alejandro Lucero <alucerop@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20260917155519.2121486-1-arnd@kernel.org>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260917155519.2121486-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::17) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: beea80b4-78cd-4b62-a0fc-08df17b409d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|921020|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JBd3q9b+tdRe/Khl/GqCaob9lD6vatUf3DHVqLZbRqgB/9WjNd2szTEM94TtJXb8pV8Yp8qIQq2ZzinCeqEnWX1ACBLDWqYYI3sqluF5yvGxDFQ4LNW6OKQKze9IDgtS67O62UXMVRJclqLgrGhXUUiMZAFdqVg83NUOf8ocQUiHAgv0SLLLmRPhDqurj00xWJA/WMb+FVCKiKo/z1J3KjkOzbZT0ot1r04mGGt2AU7oB3jXTEMtTXiMKUmu8JF2q2i9d6/3Y0CIswzAr5AD6MedTZpY1x/L6gsWdYRILFy7u45BA7fK9kee/KZ4iL2H45QwCIiWWajbUeaf5vYUzoQocE98QF6hqu3EyVFAVgTBsrtufB5ODd6E00RfwQ7I10h0xySo/4UDmJQvHxtoEZnOyOwwfmp28Q6TBlvzwyho533+35EZ4iTErdtE1QOzwEK3bFv2yQVBNJlX5nR4BsAEPrnJS3XWIlDBQeFFCt1yAfTK9uuINPJimERPniKBPNV8J3R4PA6DY8dyUvGzD4bi7v1THEbNc6gPx66V/d+mjGQa7dHR15Xw88C+mCrk4DDKhmQiIAeIYSyRmeL2IDvGNpfIIuhDs32G1226tKs6WpPiTOXoxOjZ7C6zdtnjoGI1+QQlRClKa/jdzbvl+BCTXt1dYmsRg8BQTg2TUjNyPI4pCVD1E+s8/aJvgsJDg5rOi9mus+i1xbtacoqvSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(921020)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1E5SXNpNmdvelRBdUl2VmFRcm95TkxVOHBNalVKamNzcmJJY2JPZmpMR0Ir?=
 =?utf-8?B?akNuZXpVWW5yZ2dpRGNlSDUxN1BHT1NiNlc5NU9ydFp6RERQdzJSSVNHK01F?=
 =?utf-8?B?WnVmVzZFeFVDM2MwcWV5QXdNemhQNXZ1OGVWQXJnOTRnbnhjR0p3RWJiaVZs?=
 =?utf-8?B?SklmT3FBYzV1N3AxVXZhc3VXNXRRMVFtZHUvNnBtei80N3JRWi9qQlkzSVNt?=
 =?utf-8?B?UW04SlRYa2lROSs1bUJzb0ppbEJzdkxya0FTbnZ4SHhKYVdqRWppbUdHaFRC?=
 =?utf-8?B?R3BuN25NZlp3SmozR2FXYm9Ba1FXNUFvdUNvVVJPRDdPdjJRMmZ2c3JpTFdt?=
 =?utf-8?B?cFJxNmxHYU1HT2lyTEwrZ0xGYlBWUmZGN0FwWlZERXU0V296VmdiRVhIN1BN?=
 =?utf-8?B?VGxESmhEY1F3OWtablBoKytKdFh3N2FGU0c4ZWZ1d3NRazBMUjRibUJIbjVq?=
 =?utf-8?B?eU8zeXc4SGZIL2VaUEtrb1lzbXE4dWFrV2VYVWM0a0ZXSlZkUXk5eDVxUDJr?=
 =?utf-8?B?OTROZVFjUjdwaFEweTN1UnUrZXpSZjVacE12MjljSmo5SUIySklRbXh5WHgr?=
 =?utf-8?B?WFJmS0VwSlZkclh4QnJPWk9PTzhDOTRmYWVFcDdFWVZRbVdHM2ZSQlh6V2lQ?=
 =?utf-8?B?YkQyRHA3WG1iRkgzOFp0bGNzdXQ3YWxZRUxweWY0Rmc5V2RrTkR0R0RVWHFo?=
 =?utf-8?B?ZEJYUlFrRXFxQndSYlNiclovRy9sRmFJRys3OU9tWVNtMlppRHFEcGNFSVFi?=
 =?utf-8?B?aktYTGxUMUVOZFVrRXlmM0tEL1FDTnp6cm9vY2xuYzFqb2xOSlBuTkY2WGE1?=
 =?utf-8?B?TmZBaWZnc1d5aFZrVkc5WG5RaXk4allieVJqVUxIaVlLZEJncWowcGgrM0FZ?=
 =?utf-8?B?VEJQZ1hmUFRmeGU0eVZOVE1oUEU5RkVHZmJOR2tlejZDSkI3NmJXRWFnTEFY?=
 =?utf-8?B?SnQyZm53OFN1VTZxMVk2bTg2UjRZb25KTnd4ZnZiSUkwUVBDaVdENUJFeTdx?=
 =?utf-8?B?M3NGU0pJVFBxRXJ6L2FOK1VUWnlHYnZHc2NycFVwNVBvSnhpcTFiNUY5cldM?=
 =?utf-8?B?OXM1ZkhiV3BWQ2VLd1Nxdm5tVHpYYmFaaHlGQ1JBYXJxVmdLSzBtM1JwWHhu?=
 =?utf-8?B?ZHBUVzRsVHBIMnVqTjAyWHByN2xPaWFsVHp1NUM1cUx6eG1xQmVsRWNYREVF?=
 =?utf-8?B?eDFtZ3RJK0Rsc01Ub0NnNkZYYWVtTHoyNFE4VnVDWFVYVEJ2TkgwaWhjMXBR?=
 =?utf-8?B?WjM1b1FYc2Rkd0RSYTc2UjdmVEMrdm1jVGZlcVdROVpHTnBNUXB1Wkp2eXpN?=
 =?utf-8?B?d2RLZkl6QjVHQy9kRTBkNnNjU1NCejhyU1RjRU9XRWFtYk14T1FLMUV3Z2Fn?=
 =?utf-8?B?TFBGdVBGK0VyNGcrWEJtWStoT1JnSVFMNjE3RVJKWjF2dXY5Nk9uWnhEaUkw?=
 =?utf-8?B?Y1V5NVdzczIraFRRb0RoelpNMk1NRU52THJCMEI0WW42am40REtTOEx3Ym1v?=
 =?utf-8?B?K3Zvalo1YkNMK3lkY0RwUk5mWlk5VVFuYTZrVkdmTUhGbENXeUxTYjZxTnBJ?=
 =?utf-8?B?NDA2a1A0dm9Ib1RxWU02YWdBK2lmTzQ2YTV1OTlSbFVNMXA0RXFUSDdyYm1K?=
 =?utf-8?B?N25rM2JOL2xUWmxhNnZGQ01MUi8rdEpaUXpSS2duY1dUeUJIV29IWDZYK1Zv?=
 =?utf-8?B?dzZkSlptL2l6SnJQc3ZFZi9obGVHdXNQMWJRLzU4S0tGYUJScWVDbVdNY3VS?=
 =?utf-8?B?ejhrMlNyM3piKzk1RGw5QWJHdURuT01LNVZ6VldLdXhWeWdHcXE2VytMa05y?=
 =?utf-8?B?UkRkb1VwdjZyc0tiSWRieUg1cURCbGhhUTlQRUZzOG4zYXdwR1djK0FLZ0lM?=
 =?utf-8?B?NVJ2TnNiOWw2ODh6RjZuczBjYTdFMDlvaGZmSUZlRlF2OC9ZeUlxc0xnNnov?=
 =?utf-8?B?ek1YMy90MDAyb1pjaVowUnZ0QVVBTWxEdityaVFVRTNPYkMwR0RuN0wvVUNw?=
 =?utf-8?B?QVZtUFpsN1FlYVRyTnByL1NvWXIrc1h4b1B2d1ZPTXZMb0gxd3hmbzV1bkVO?=
 =?utf-8?B?ZkFjM21oWTN2VlBqc0N3MHpSY2QrUi9IcGlVY2lqb0tkRWNsWWZIRjQxNHRh?=
 =?utf-8?B?eVpYNmJuNnJEckdlQUFKdTdlY1h0NUNqZU9HQThvdW1lNSswVFpPaEFDSDQv?=
 =?utf-8?B?YmRXMkt3ckZWbVlIYkNIMzNZTXRiK1dLdG1LK1pKY1ptK284dDFReG9jeGkw?=
 =?utf-8?B?VEo2Rm9tVHpabDVLMWZ1NXU3WEkyZS8yWGNJbFZSSkFXeHVOdjBEdUJYeVVK?=
 =?utf-8?B?SWNwVmZLUzViaW5aSlpRSC9qR0M4THcyNVVvQ2NNcG5vMGlCMXpBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beea80b4-78cd-4b62-a0fc-08df17b409d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:43:33.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYWA2KkBrYQe5JLORLQof4QoRmBKbudCU4wMJLbEJrK+nxSopFmhUo66UEd/y0l+cEtmcuoiHF9FfDnx6XkzmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790


On 17/09/2026 16:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A recent patch introduced a call to devm_cxl_probe_mem(), which is only
> available when CXL_MEM is enabled. If CXL_MEM is in a loadable module,
> this causes a link failure for a builtin driver:
>
> s390-linux-ld: drivers/net/ethernet/sfc/efx_cxl.o: in function `efx_cxl_init':
> efx_cxl.c:(.text+0x156): undefined reference to `devm_cxl_probe_mem'
>
> Adapt the dependency to require CXL_MEM instead of CXL_BUS, which
> we know is available when CXL_MEM is.
>
> Fixes: 0418860ef2ca ("sfc: obtain and map cxl range using devm_cxl_probe_mem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/sfc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 979f2801e2a8..e2898ec2e6e9 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -68,7 +68,7 @@ config SFC_MCDI_LOGGING
>   	  a sysfs file 'mcdi_logging' under the PCI device.
>   config SFC_CXL
>   	bool "Solarflare SFC9100-family CXL support"
> -	depends on SFC && CXL_BUS >= SFC
> +	depends on SFC && CXL_MEM >= SFC
>   	default SFC
>   	help
>   	  This enables SFC CXL support if the kernel is configuring CXL for


Reviewed-by: Alejandro Lucero <alucerop@amd.com>

