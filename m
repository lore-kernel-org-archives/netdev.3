Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7857D20E;
	Wed,  9 Sep 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970516; cv=fail; b=oMxhqbRtLBp6dzpwbNOibJTK5bL2BbMTQPvluFa/jksixL/gLBuO5u8KEr74v+1v7e1UbA5FzMu5Oi1Ld5CloJQOHiiioaMz+GZfzDyC+EK2enRwP7dCS/jdNhYeZaI/Rutj9yMv4SJEVndSs0JNbitBakvUdwx+j4u8dn9n31I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970516; c=relaxed/simple;
	bh=7altFP417pJ74PFDLujLV0/IBUGMcvz3xMzWCQU2zjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tLTVTKWyeW5ewPv+PAHBln24ZRf86dCH/grnN/RrcTM57uxAQlfBl7b6Zd64jY9ZCvV20ZUuNPPhISLWAC3vcvEGQ0fHwyU2l9kN/K0W7JTcqnLUjGLY7US2nU6zXc9cs0KYumilt0xwEm0TlW9PLK0YdZDWK2GzRjNfRRjp4JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bcn6K4yC; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bcn6K4yC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpKxqJzDTs3SfYbIJGht0zT8bSIoe8YSjAiVcv/q37rRwHEqo8Zrjk5wWD0bBcJBfdUJ3DAzw4Zg9n687qZy6+3MHH6xesKTRtm1Q9ONrVLtllC9BLmK5cqCRuj4tyGY65pxNx8MeImzqmrP0cpibpGVZhMJ9KGSmw/BSzBQqBTPMQSQUqRfwuNzyUCBbSoLE/N1Iof710Xo+FnmAHDCUTs2DUTjXpggu4GH2lQGSOvjrpdgeFQSxcg/DIYdr51srzhLdSqM8YgmJhNPjK84wId8p94v66MMlpvO/oAPyVdEOlsMjXn5rGd9pESkwvwz9Sk2pgf8yyn/avFyuf5zgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g4ui3KyaQOQSKRLvVELivVjmRwDUGPsshAD03VPkCo=;
 b=OkHfYvVh8I2w/c/V1VzEQ3POOf8tdSJ0qRNzDWyQFiHFTvcMOshb1pTi7ud1UsWzC5mxNCKG5h6T9FCwrHIWOFZR37W/ktMHzSQajUAHrVdiamb3KxD3hqnyZpGiDdEiEiSvtgyWsNzhTIIvZHXqdqlbjJWaVpo9BN6bNBhXzRld9q44gm7362KwefvSy3evZuAnbu7Zo+del4TumKfPrjD1QkOcM9tSCqTutFwX+OwAiBrAB1fUiso3BUagvBziyqviLpkzjyJCgoZ3nNlS7Er8qzaGHZ5rQDcoOKaJ8L4m7gw1ev19ww0hIRRCNf8/9cU5BC0Ru8vr1A2X1bdUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g4ui3KyaQOQSKRLvVELivVjmRwDUGPsshAD03VPkCo=;
 b=Bcn6K4yC3RgHHrAZjmt4kgwdDtrHAJJB7aiiJKLabSLikHYlGFSeiN2vnnTpc8sbP8uTgcdQQHb1H2uqDURdSaf1nlwbjarm/ftuiMkW5y/nsRlm0X6OJxUND8yS1r25aGyV9cXlAumWlAPdNC35TIdMhY7YG4yCeY7YRxuf7sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 16:15:09 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:15:09 +0000
Message-ID: <b2dfea6f-078d-4a8c-9b92-db956e6cd18e@amd.com>
Date: Wed, 9 Sep 2026 21:44:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net: xilinx: axienet: Fix IRQ error
 handling
To: phucduc.bui@gmail.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260909045450.16176-1-phucduc.bui@gmail.com>
 <20260909045450.16176-4-phucduc.bui@gmail.com>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20260909045450.16176-4-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 2728317b-d958-4808-81eb-08df0e8d847b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B8SE1WkYdQBL4cWKDcKz7FVJUxGAvtIO+pNR3nHrgzEy6ssZM/GBjgIJ+awxzGiOzOnAv3P/Ras5mO4jSvwZUkZ1vl27F42DkR0jrgdql81A4vhE8dcIiQL+eiSmfzlhzR0Alj6d8CPz+tYJwP1xPeoL/lFxBBxhj2v1xGIYvPDuDIkAqpEeN+JP2L0fVtJzwHwfYxKQl/N39qBFwpKLxM//lvDQ5uBRH+86Lrdi9mXsCHf2xOS9he2hXrnP8y6vtBHFWpCiWAj6v+7jcbagjHgE+8JoDwqnHFydv4u/Kjr8BRCrbj2E4x7kLm63BbGuqQB1N+LW+TfafLghoqIOmDrq9ohw9hEfhu/a0QrVr7i9kJmSfx98Yo0UBenDUHh53bunAJ9AUdoxyLfqpKMKbuXuf2DqkOm+X3JMsaE/vSmQE5DQOt7Ng69vgP4+W0yqlCTaFJ2m9d1UMYyNugVKheSsqoibmzHy0VA9KdejoVXfaqFdo4a0wanLulRqP5MFDiRqaeUWB5tnJRx2sLzkJd2u5yE7qWJZlWNGy9/LNNB6/KM5Y/HrFQ2Cl6fM2FppJEknlpuKtRluGC7Sp5N0FCRewmIAJgMqtUdF9dz0xbxuWe00b9EdXh3xq+2cpG5gAtjF3a1Zvrw37A2WOmuJ+W7VVllrO6aXHXjR61hwBis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFsZktnSFN5NmtxOHAxdUcydzd1amYvdlo5TzQrWmpLcXE0NlQrUTAyZmNM?=
 =?utf-8?B?WmwwcjBkdnBtakJoajNmWWZCRkJybjZWZ0RHak9CNWs2eU1XMUVjVHZsUXpR?=
 =?utf-8?B?eHlCZDZnWS9jcGdYUFc3cnRGUkEzS1lMZERoY3pqNUZFRWVFQUYrbXVnbWxD?=
 =?utf-8?B?SlVZNjU3aFU5ZXc5VGZCaUllOHprUENJSk9aV3FpaHVMVjBVMFo5dmFFYUc3?=
 =?utf-8?B?R29qdnRqbjV6K2VWQUFTaEpEa2R5ZnNJZFVpSHJMMTc4NnZUc21vOHBFeGo3?=
 =?utf-8?B?L1Q4UDFycjVjc2tjSnpaSjV2SWlSekQzZm5BdXR1NEhvQmVrQUp6NTF2VDEr?=
 =?utf-8?B?R2g4V3RrOWFlWWZXR0t1RzFsZGNmaXNHQXR6MkIzZkVuRkFkY0w0VnRXVWtM?=
 =?utf-8?B?Zk5hU3hVWUNQZWpSRkgyL01UQjBkWjVsRjlaM1ROVlRnR2xSUFdPSEQvYStj?=
 =?utf-8?B?Q3g1MFNlZ05aQUpDZmdRVUVyM3lRa0JhQTNobkk0R1RlSzk1S1JwaUFQK3hO?=
 =?utf-8?B?aHNMbmRNTEZhbDJrbUpxa3R3TEw2L3ZiTzBoalRwLzJ0THE5QzJhZWc1WnU5?=
 =?utf-8?B?VFhIbHh1MVFWMVJwbkZHSVpCQitvSEZIdXBsN3dhaytvVHlJSTFPRFkzSEI3?=
 =?utf-8?B?bTNEcVVxbnppUStwdnRXMjFvRE5QZ1ZLVisvbm11TFdpQjFlSjhhN3FPTCto?=
 =?utf-8?B?MFBQU0NzVUpmbzB4ME5BU2wveVRFR1YvWCs0M0ZWWTBBNkxZekpGTmhjQXgz?=
 =?utf-8?B?MU5iRCtjSC9kTDczek9PNTY1OXdqcXFvT1RnWVV3bHZwV2ErcWlOdGZSMXha?=
 =?utf-8?B?Q1F4T2JiNnNoNXVZT1g3eEV5R2x0ZEhaR0JQb2lTeCtjZkVoRlZ2WW52Ti95?=
 =?utf-8?B?emJTa21MRVdVS1dEbTR0NU9pbC9kRHd2WkVUU1gzL25wZFZxY0VBeFpDbTJW?=
 =?utf-8?B?YkptbFovcFI4ZkVZSEJsSlV1UmlSSFhWZWpOSzhiakpqY05jMDRibGswRUth?=
 =?utf-8?B?eWNZUERWanFlTi91cjREZkdvbTVlOTdYeXVuSWJvbXg2ZUNqVC8wVzU2N29Y?=
 =?utf-8?B?azdCdmZqSytjaEIrMkZKRytTM05mVGppcWNDTGxuT3M0cG5NUEszZm0rN1Jq?=
 =?utf-8?B?dXF3R09yMjZZOVFJb2NoelBFTk42WERKMlVOMVRQR0FOV0NBMkExUFEwNk5x?=
 =?utf-8?B?UGM3dW1UZXZ0elBKejFEY0dlNS9na0c4MUlLbVNHUTRBMzBsb2NXZktqQmFT?=
 =?utf-8?B?QzF0QmhhTkl2MHlMVVZhQUVuSDVDT3pqR05xd21rbUFlZFY5ZzhzZTh5aFZt?=
 =?utf-8?B?bi9BWmE0NXh2SEh4amUwRHlzZzNPR29pVUgyMndVamlYZGRkZFFrSUJPMGJP?=
 =?utf-8?B?bkZsVmVSUUE1Y3VSYnNJVUUyN2RyR3QrV0Y5M1RIWWVCb2lOaURXZWF1ZHlo?=
 =?utf-8?B?RkR0bXhMM3pJdWNZQlIvZG1SZ2NJTzBFUnZDQWEyVWNYdmxpekdBanNTaWxG?=
 =?utf-8?B?UHFnMHE0dVhmZkh2QUR1Wmt6cDBpWE1JM0VkM2lIWDAxUk0yNnU2S0VFNUU5?=
 =?utf-8?B?TERiTzhrNEpoOWhEVXcySFVpZjM3azBlVEtvb3liQ2VFbnA0L1hXU3Fzbkx1?=
 =?utf-8?B?MjNkOUZrQlRwL1ZSK1VMbS9DaURoeHBXNlpyVHV0bmFWc1AwZDhjV2JuSGJO?=
 =?utf-8?B?U1g2RUFLdThuN2RXdWdKMWJCVk81dk94VGhTbVVuTUFpekx5T2w2czJGelBh?=
 =?utf-8?B?RU93WFJuaUJROFo5U2V2OXhVclBJdnNaZTUrTDdXR0tXTHJWTW5rMG5UdlNu?=
 =?utf-8?B?RHJPcHJTOStQYnJsTmlRMG8rSGF5ZklLTDh0U2p6VTg4azB4TnZXQ0pWWE04?=
 =?utf-8?B?L09ZdTVLRzhrRkt1eFN3SUdHNG1Ob20zbTdNTzA1bGk4d2p3d3k2a3dFSDIv?=
 =?utf-8?B?Z3hHSXQvWWJSeDVRWjN0bTVEUjBNZnJxZGJ0RUpkVmNxMytjbFNJd3VrQnZY?=
 =?utf-8?B?OUErNjBzOHEvUnJWRXM2aEE5YndRM0hpWGFFYkg3bzl4NDNraEk5bFV5Wm9n?=
 =?utf-8?B?R2dqU1h6NmkzQzdieTBUS0Z0eVBaYWEyVGZsNVdnZDY0Tm5tWU1XOUg0TDRQ?=
 =?utf-8?B?bnB3RDZWWlpyRGNmdThHdDZNSVc2eVZ0bEY2aG1YYkNjaUJvWjhJL0hoZVNp?=
 =?utf-8?B?TXZsemNsVnBORUN1STJZZVdhTmFjdEdEOVNTRllhYUoySUFLMVg4MVg2QWFP?=
 =?utf-8?B?TWU4bGF4TTBJdEN0NHJsV2hHcG1mK0RGSDVHdDFRZUVMWHlhVWNwamtMdnNN?=
 =?utf-8?B?bEJyajZvbzhxZTVpUkRzU3M3MDlTUUxHL2FIaVcyN1pXMUtzQm9JQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2728317b-d958-4808-81eb-08df0e8d847b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:15:08.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inLJgpsSM17d/wsoHoo0xmQjTdL8iFs/TZ2Yax+a5xMg+k4InBeynx1E2kSJWZDptK0KhHgvcR7pBL0BPKUHjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492



On 9/9/2026 10:24 AM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails,
> while platform_get_irq() returns a negative error code on failure.
> 
> Handle both failure cases appropriately: return -EINVAL when
> irq_of_parse_and_map() fails, and propagate the original error code
> returned by platform_get_irq() instead of returning -ENOMEM.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>

Thanks!
Suraj

> 
> Changes in v4 :
>   - Add error handling for irq_of_parse_and_map()
> Changes in v5 :
>   - Change the error code returned when irq_of_parse_and_map() fails
>     from -ENOMEM to -EINVAL.
> Changes in v6 :
>   - Add Simon's Reviewed-by: tag.
>   - Drop the Fixes: tag as this patch is intended for net-next.
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 3927ababf833..782f903d318f 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2971,10 +2971,14 @@ static int axienet_probe(struct platform_device *pdev)
>   			dev_err(&pdev->dev, "could not map DMA regs\n");
>   			return PTR_ERR(lp->dma_regs);
>   		}
> -		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
> +		if (!lp->rx_irq || !lp->tx_irq) {
>   			dev_err(&pdev->dev, "could not determine irqs\n");
> -			return -ENOMEM;
> +			return -EINVAL;
>   		}
> +		if (lp->rx_irq < 0)
> +			return lp->rx_irq;
> +		if (lp->tx_irq < 0)
> +			return lp->tx_irq;
>   		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
>   			return lp->eth_irq;
>   

