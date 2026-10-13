Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD155349B4;
	Tue, 13 Oct 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919335; cv=fail; b=hLfFl40BesgS9xFVHpZFYGazZdxBtfZcdjIyCLlPgU4WJK2NTUo2ww6TXG2FkMyYK+g1QQBImNMO1ZZEBwZSVtdmRtKCOeyPkBDAcRF2NixrO3IlX1kVanRvikFWhS/k3ydQi/b2TpTHmV9p6pCpMuqjxOWppok9LsYDWRZJg18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919335; c=relaxed/simple;
	bh=Pq/F77y8/UWlQQGV4AzfCD+2hSsPM2CTewNsq/6JEDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjPI+3aLP0UR3EXcfsI+ZiCoY/Ize5YZixYpvJVFSJLOVyiHBtxL0pyfiwr+QA8O/udbJ9sRUMB/SvT9o6TtaWVlO3+WNCPO9IUFBkZCmwsd9GssLlTbcvnF36hj0r1O6njUmPGbFCy4hn5UK/kTfP84dYb1TiLGHsEYpo8ASXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RmL1BZmr; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RmL1BZmr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMpEe6xcF17hPR0j9MRKx2QOWCmX/KR/m7CXBjk66D1KfQZcm3wHJYrANue1NjlhbO65xR7tYhnSWxef7nOKAvwbSGkk6eGl732pp+1Krq+jUVtlII2NAaqHc8zFoRlqmfBN5ryf/BsexIs+G7UpBx3Az9ftr4WotDz9d9NsxzQNLAI3q6ncqUOdu6kI3ZZuYKYiQNT8s/NbTAyr+KRPunEOVkxzoOtP3E2LKpuffEROEVgKvU+IOTKWFa8j4i96vD3dtgSES4oOEcnynL3vhmm129rDuVfmDIzjHwEU7rYIYXlXiEfuWbCl9pijrV0S0PdfAubAtT4+OlBknJb3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjOCMFC/Y7+GWbjEe0AG+BvdtDKX/n8qS43ZqrokTDo=;
 b=oxIhPJg22eqmdcQHPUSMz7O3/nrYrraU9uc4zvJAP1HomB5p5KGd0oFLmPnfuKca/XgOp+Z3o6/8Qil/xbT1xCRdAW9VekA0QcUKsIuPd+t5Vu91DwPuG0QbalhwMbomKluZ9iULvOcFvJGc6nXiYGv69l7LrBeFhA4SYOPCYyhjbmDeybNjPA4HvNdr92QwZllFye2jWox5kaQ3Yjfnjwz1wJ2t1MH2hMCWMMyx81lQpp1o2xCi7uAex2Oy6GNgp6dYEysNPxYu21tcg5NVlEaZOey4/X6JNqyKmmB0tjRSeiocxcJ3oaHsn0J6M4W7IQNsPUK9fg1An1SNgC/wWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjOCMFC/Y7+GWbjEe0AG+BvdtDKX/n8qS43ZqrokTDo=;
 b=RmL1BZmrhr4G8ceZdBHSVEbHActzxaJp0BQdySJsHyzpP012c4hHMbuZ2a/vQG5CzMsN6E/+DybtPsKClcCpsz4RYJJ0RWtg1AEm8lRrSwXWtlbPtpotKRQxuhxnoIntFS6rsxpCQ2kMccwDTcYD778sTFzLjN7gducCf69A/Gk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 19:21:50 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 19:21:50 +0000
Message-ID: <c64b8484-283d-46d1-8721-53f9b9a962f1@amd.com>
Date: Wed, 14 Oct 2026 00:51:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] net: xilinx: axienet: Add 10G/25G (XXV)
 ethernet support
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261006110550.1990213-4-suraj.gupta2@amd.com>
 <179163334454.434549.6060647558462905074@kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <179163334454.434549.6060647558462905074@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 1081fef6-50d8-4da4-3256-08df295f3b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Gv6e0JdIWT/jzUuPtbnb46QLprjgXFp7wl3gLGU9M0K49bInZp9uolFnT4Ii7OOBVsenpsqjBuCdRounZ9hL141U5mY+Cdh/80C5FhVV1X6A/IOC5HwxYi7iSb+nNKR6h9ci+s6CbZSaQfF/eZJPQiSO08Y9LIFYFUmh9mepgMIg6uXUVbSna6R1LSdf88q/hyAliQv3fvtbPzE/CxTEMXV7/SMCrPMSZGOheMQFXNg29icKcXGTNendnRYxJ2/ztIv5Pu7+1A5grF4DMqy4+7VyIjnaE92qvwtAAsE3bdPHg/2EosrQVcVXo04Q0jnaKzDNAQvHdRice5jzbj75V5mnNnEx/WfBT5hLt14Af51farIVy57QVE0H1KkFyzU1g14C7qy2zmYIGjyK39KPkp2Iv4DlTdVBsmPasHdFHCsgUsHtuTzRhyHwhYarTJf4IrI2sFxouAr0NRsNyzMJYMJ5wGg4EMACxwzaISEsTT082aSqQ3kABaF3jLXcQjK+zmllCX9kmg7MdySzUWn+XadlNUc/Xp9hs6iGC/iZIvwnOw3oiqRHR1hO/YMVnLzR5acc8sx4R4X1pFJhR32vzGnhKagZBlUe/gRGcaadie1lgvmem4sVtNHTV+FuIczi0wGfSFzey9Qnhxgu/2Ja2GX/RYNJlWOJPp9w4ixrbek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU9tU0xkelBaV0NoT0l5Y3I1eTJRRjJONUx0UnJycDBZVHFQZzFBeCs2cHZY?=
 =?utf-8?B?UW4xWlR3QmVSdXdzY0Z6c08vSDdLVmhnMjVtYkVxS1VnTkJCY05MYXZJOTAy?=
 =?utf-8?B?Z2drelg5dlQ3NC9rUWNGdkI0UjViNzRyaURMTGpxeFl4czNQbVp2UDR2NXky?=
 =?utf-8?B?b3hlVVI2SXZWK0UyVWoxYXZyYWN3VU9pbDdCVHkyNkJkQU9QQnNVNUZ0MXZq?=
 =?utf-8?B?b3kwNzB2NmFiVGk3cDVxMWM1eTZNS2NUUTkzODVSRW93NGxRT0xEQ2xjRkxk?=
 =?utf-8?B?YlY3RVBKTW9LSW9LNlRFMGI4MkVERXJ6Vko5cGRzRVFUcDNMbnU5SXNEYzFm?=
 =?utf-8?B?UzgvdnYyZEU0RlFaWkZjYWlmZFNLUkdoUjNmLzJDbmZiTnpReU5tTGErYjJ5?=
 =?utf-8?B?VzFxUjgvRjlxZTdyNEkraVVHeklqOVhyUG12bm9IQ2hPL0o4Z0FmTHpOa3U5?=
 =?utf-8?B?R0tmSkN1d2p0SUtDL1RSSDZZQzJSN3JEZ0R2UXJ4eVMzL3BDV3RIZ0FseFZt?=
 =?utf-8?B?SDBiNW5zWmZnR1E0UzFVa2V1bk90QlhHZllxbHEydUdVdE45UmJwdXVBOTBa?=
 =?utf-8?B?Y25DQ3ZaZ3p0R3ExOVhwVEkxaSt4UUNrRjFhQTFaeE9UNXdaekR6RXFVN1VI?=
 =?utf-8?B?NXNLcm4wVmF0QTlFMHovTENYWFhTMW4vYnZXeGs4M0poOHZKMzlBbnF2TmhF?=
 =?utf-8?B?OUdXM1dteFlpT2RYZklSeU45bnlLTnZwWVgxd0dqc3Q5ZlRYRFBwOFcrRGpU?=
 =?utf-8?B?ZGdudnV6ZUhRajJiaW9WYk9QZzBxWWM3NVVpRjhLR3B3WFkzM3BtNkluczZM?=
 =?utf-8?B?cmdlSVZwNnJ2czlGM2pNd21yMnJLSThrRC9FekZ0MURjcCtEV3pGVVJWb1pR?=
 =?utf-8?B?MHRhcnlSRWt2YkNFNCtaMWN5QXpObzVhZzBCbEN3UTdtOFliUy9zcEIvSDRW?=
 =?utf-8?B?MnQ1dEFHUy9RVXIxV0xmb28wY25OaEI4d1M3QThPR2p0MlByak95dHFGU3F1?=
 =?utf-8?B?QnZjRXhLNnBjQUZBZTEzWERFVVFGR2R2SzRRcCtPWDh5bFczSXBiQ09zVm11?=
 =?utf-8?B?SGx5eTRyVDVFdUdaanRaR3RmQ3kzUlQ0Z3BWNUdKbmVtanNBRnBpdzN2U3A2?=
 =?utf-8?B?Zlg5VEt4QlVNYlRiSG1iOXd6TEIzMWRWNWZ6ZUhXN3lkODlOWEZrVHoxYkJM?=
 =?utf-8?B?a1NLMGlSUmhZYlp3V0g4MHRkQUdlYkpkRnhtbklzc0RFRHFhZlduTlFGZ254?=
 =?utf-8?B?cUtHS3B4M2JGMVBBWi9MY0ZjdzVZZmNscFR3UjNyRXhlSEVZSW13MERja2Y2?=
 =?utf-8?B?ZVVxaWRGQ1pVOFczVVpzQlpKK3BPQlpqR05ZSzlIOEZvbmVwVVJqcldoZnU2?=
 =?utf-8?B?bEZDWC9makxIMHFBMHQ0NWVLNFJnb1pLdk4vSnRBSjh0QTNSb1pjNm80SExv?=
 =?utf-8?B?amRkM3ZWS0F6REtwUnNFck9GckJIRS84NUVUYXNSNFhJTlRROEhBYTh1RkVh?=
 =?utf-8?B?UUQ2NnFuQUF3MStRaUFmK29hTDJNUXV1NTR5UnpvSkxsUEtWeStyNWk1TW5W?=
 =?utf-8?B?cytpUWh3RFl2QjRFRzE0amRHMlFiY25pUEhHTEE3VGZadVQwTGtTbUt3a2w4?=
 =?utf-8?B?WnFsTTNrK1liK3gwaE9TVUxVUzhZN3BrOXEweFV0N3gvcHFCOUpCQitnTDB5?=
 =?utf-8?B?clhTMk9lNnZFQWhSbnExbkd2bWRlUWNyV1k5Nisrb1JHcTZ0Z3pyd2VRRWNG?=
 =?utf-8?B?aWJnYXlRRytwK1l1N3JCakdkN3p0N0UxeEt0SWZNV0NCVEhnc1RSRXVhbzNU?=
 =?utf-8?B?aUQ1YjRESEYwdlJaa1lFNXhVcDkza0FIVHczL1RDTFZ1V0ZQdFljMzM4clZv?=
 =?utf-8?B?L1hlTGhNaHpZbkNGS0RObWl4V3h4eVNtMWk1RVJIRkNZTEhLbXZHZ0VFWVlM?=
 =?utf-8?B?anArRHdEc0I5b1owNVAzYmlsUzB6eW44czVsVmhsQjdiVGNqRU85TzRrckNX?=
 =?utf-8?B?TGJ0UTlOY3hOQ3h3MXlWT2t6MTc5Umg1ZlJ5dm13V01vZHIvRE5ONElEUzZh?=
 =?utf-8?B?VFo5SUp6NkppMVN5ZE9uUEUyelh6N3h4Sm5TWHFZZE1jaHQvL0JnakFvR3I5?=
 =?utf-8?B?d1l2RHQrU2Qvdlk1NStneW5tU3pkakNBaWZ6Uk5IVE01cUh2UnFBUXdIYk82?=
 =?utf-8?B?cis4SzJxOW1aZU9PRDZiMEoyb1JqMSsrRGdSaE13QTVEaGlPMTl6MDVMT1pj?=
 =?utf-8?B?cDRXSFQ1b2RWQWRVTExydFVkalBCNSt5UkNqeFdFV1dGRTlMcHUyY0cwUFFq?=
 =?utf-8?B?RHRaMzJNNDNvSGtQbHE2SkUvWVZqaGlJSUZmdXlXVmFUdzh1c3hWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1081fef6-50d8-4da4-3256-08df295f3b67
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:21:50.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVPubVarPl+46ZDEEb09ULKaeli6rJvIyN7Y8QvbJqe8uf99K8f8LkU+9cLZG6PMeKcJ2mZXc78f0Eb5t6tJXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204



On 10/10/2026 5:25 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 4 · Medium: 2 (1) · Low: 4
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Under the new xlnx,xxv-ethernet binding, the interface cannot be
>    opened.
> - [High] The new early return in axienet_open() leads to a double free /
>    use-after-free after a failed resume.
> - [High] The XXV RX path takes frame lengths from a source the XXV
>    hardware does not write.
> - [High] The XXV MAC's receive max-packet-length register is never
>    programmed to match the RX buffer size.
> - [Medium] Pause is advertised and reported for XXV but never applied to
>    the hardware.
> - [Medium] The GT reset-done timeout is only 1 ms, and this patch makes
>    missing it fatal to ndo_open.
> - [Low] A real fix for an existing 1G bug is bundled into this feature
>    patch without a Fixes: tag.
> - [Low] axienet_xxv_poll_link_ready()'s kernel-doc says missing PCS block
>    lock is expected with an unplugged cable and must not fail bring-up,…
> - [Low] The jumbo-frame flag and the MTU range disagree for XXV.
> - [Low] The kernel-doc for axienet_device_reset() is now wrong for XXV.
> 
> Pre-existing issues:
> - [Medium] axienet_dma_rx_cb() passes `rx_len = app_metadata[LEN_APP] &
>    0xFFFF` straight to skb_put().
> 
> --
> 
> net: xilinx: axienet: Add 10G/25G (XXV) ethernet support
> 
> This patch adds support for the Xilinx XXV 10G/25G Ethernet IP to the
> axienet driver. The XXV-specific code lives in new xilinx_axienet_xxv.c/.h
> files and is described through an axienet_10g25g_config with callbacks. It
> also propagates axienet_device_reset() failures from axienet_open().
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 5af48d5cbed3b..c09f88b552fce 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -1710,6 +1710,10 @@ static int axienet_open(struct net_device *ndev)
>>   	axienet_lock_mii(lp);
>>   	ret = axienet_device_reset(ndev);
>>   	axienet_unlock_mii(lp);
>> +	if (ret) {
>> +		dev_err(lp->dev, "axienet_device_reset() failed: %d\n", ret);
>> +		return ret;
>> +	}
> 
> [Severity: Low]
> This isn't a bug in the new code, but this check also fixes an existing
> problem on the 1G path. Before this patch, phylink_fwnode_phy_connect()
> overwrote the ret from axienet_device_reset() before anything checked it.
> 
> On the 1G legacy DMA path, axienet_device_reset() can already fail. That
> happens when __axienet_device_reset() times out or when
> axienet_dma_bd_init() cannot allocate descriptors:
> 
> axienet_device_reset() {
>      ...
> 	ret = __axienet_device_reset(lp);
> 	if (ret)
> 		return ret;
> 
> 	ret = axienet_dma_bd_init(ndev);
>      ...
> }
> 
> In those cases open continued into phylink_start() and
> axienet_init_legacy_dma(). The core had not been reset, or there were no BD
> rings.
> 
> The commit message only says this "matters for XXV". Could this go to net as
> a separate fix with a Fixes: tag, so stable picks it up?

This is a pre-existing bug & can be fixed in separate series.>
> [Severity: High]
> Can this early return lead to a double free after a failed resume?
> 
> axienet_suspend() calls axienet_stop(). In dmaengine mode, the only mode XXV
> supports, that frees the skb rings and releases the DMA channels. It does not
> clear the pointers:
> 
> axienet_stop() {
>      ...
> 	for (i = 0; i < TX_BD_NUM_MAX; i++)
> 		kfree(lp->tx_skb_ring[i]);
> 	kfree(lp->tx_skb_ring);
>      ...
> 	dma_release_channel(lp->rx_chan);
> 	dma_release_channel(lp->tx_chan);
>      ...
> }
> 
> axienet_resume() then ignores what axienet_open() returns:
> 
> axienet_resume() {
>      ...
> 	rtnl_lock();
> 	axienet_open(ndev);
> 	rtnl_unlock();
> 
> 	netif_device_attach(ndev);
>      ...
> }
> 
> Suppose axienet_xxv_mac_init() returns -ETIMEDOUT from the GT reset-done
> poll. axienet_open() now returns before axienet_init_dmaengine() runs, but
> the netdev is still netif_running().
> 
> The next ndo_stop can come from ifdown, from dev_close() in
> axienet_shutdown(), or from unregister_netdev() in axienet_remove(). It would
> run axienet_stop() again. That calls dmaengine_terminate_sync() on the
> released channels and kfree()s the already freed tx_skb_ring/rx_skb_ring
> arrays and their entries. It then calls dma_release_channel() a second time.
> 
> Before this patch the reset error was overwritten and open always
> re-allocated, so stop stayed balanced. Resume ignoring the open error
> predates this patch, but this early return is what makes the problem
> reachable.
> 
>>   


Agree, will fix it>>   	ret = phylink_fwnode_phy_connect(lp->phylink, 
dev_fwnode(lp->dev), 0);
>>   	if (ret) {
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
>> new file mode 100644
>> index 0000000000000..9f7efab84f827
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_xxv.c
>> @@ -0,0 +1,323 @@
> 
> [ ... ]
> 
>> +/* Option table for setting up XXV Ethernet hardware options */
>> +static struct axienet_option xxvenet_options[] = {
>> +	{ /* Turn on FCS stripping on receive packets */
>> +		.opt = XAE_OPTION_FCS_STRIP,
>> +		.reg = XXV_RCW1_OFFSET,
>> +		.m_or = XXV_RCW1_FCS_MASK,
>> +	}, { /* Turn on FCS insertion on transmit packets */
>> +		.opt = XAE_OPTION_FCS_INSERT,
>> +		.reg = XXV_TC_OFFSET,
>> +		.m_or = XXV_TC_FCS_MASK,
>> +	}, { /* Enable transmitter */
>> +		.opt = XAE_OPTION_TXEN,
>> +		.reg = XXV_TC_OFFSET,
>> +		.m_or = XXV_TC_TX_MASK,
>> +	}, { /* Enable receiver */
>> +		.opt = XAE_OPTION_RXEN,
>> +		.reg = XXV_RCW1_OFFSET,
>> +		.m_or = XXV_RCW1_RX_MASK,
>> +	},
>> +	{}
>> +};
> 
> [Severity: Medium]
> Is the pause configuration ever applied to the XXV MAC?
> 
> axienet_probe() sets MAC_SYM_PAUSE | MAC_ASYM_PAUSE in
> lp->phylink_config.mac_capabilities for every MAC type.
> axienet_xxv_phylink_set_capabilities() only adds speed bits, so XXV
> advertises both pause modes.
> 
> axienet_10g25g_config has no .mac_link_up. axienet_mac_link_up() therefore
> silently drops the resolved tx_pause/rx_pause:
> 
> 	if (lp->axienet_config->mac_link_up)
> 		lp->axienet_config->mac_link_up(ndev, speed, tx_pause, rx_pause);
> 
> This table also has no XAE_OPTION_FLOW_CONTROL entry. The
> XXV_CONFIG_TX_FLOW_CTRL1_OFFSET and XXV_CONFIG_RX_FLOW_CTRL1/2_OFFSET
> registers are only read for ethtool -d and never written.
> 
> As a result, phylink and ethtool -a/-A report and accept pause settings while
> the MAC stays at its reset default. Should XXV program the flow control
> registers from a mac_link_up callback, or stop advertising pause?


Setting pause configurations for XXV is not validated yet, I'll stop 
advertising pause for now and can be added later after proper validation.

> 
> [ ... ]
> 
>> +/**
>> + * axienet_xxv_gt_reset - Pulse the XXV GT reset line
>> + * @lp: Pointer to the axienet_local structure
>> + */
>> +static void axienet_xxv_gt_reset(struct axienet_local *lp)
>> +{
>> +	u32 val;
>> +
>> +	/* Reset GT */
>> +	val = axienet_ior(lp, XXV_GT_RESET_OFFSET);
>> +	val |= XXV_GT_RESET_MASK;
>> +	axienet_iow(lp, XXV_GT_RESET_OFFSET, val);
>> +	/* Allow 1 ms for the GT reset to settle (see timeout note above) */
>> +	usleep_range(1000, 2000);
>> +	val = axienet_ior(lp, XXV_GT_RESET_OFFSET);
>> +	val &= ~XXV_GT_RESET_MASK;
>> +	axienet_iow(lp, XXV_GT_RESET_OFFSET, val);
>> +}
> 
> [Severity: Low]
> The kernel-doc for axienet_device_reset() in xilinx_axienet_main.c still
> says:
> 
>   * Ethernet core. No separate hardware reset is done for the Axi Ethernet
>   * core.
> 
> For XXV, that function now calls config->gt_reset() first, and this pulses
> XXV_GT_RESET_MASK. XXV is dmaengine-only, so the DMA reset and BD init
> described there never happen. The function now also returns mac_init()
> failures such as the GT reset-done timeout.
> 
> Could the comment be updated to match?

Sure, will update the comment.>
> [ ... ]
> 
>> +static int axienet_xxv_poll_link_ready(struct net_device *ndev)
>> +{
>> +	struct axienet_local *lp = netdev_priv(ndev);
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* Confirm XXV Ethernet is up: on IP v3.2+, wait for GT
>> +	 * reset-done before further register access, then poll until
>> +	 * RX PCS block lock is asserted.
>> +	 */
>> +	if (axienet_xxv_ip_has_gtwiz_status(lp->xxv_ip_version)) {
>> +		ret = readl_poll_timeout(lp->regs + XXV_STAT_GTWIZ_OFFSET,
>> +					 val,
>> +					 (val & XXV_GTWIZ_RESET_DONE) == XXV_GTWIZ_RESET_DONE,
>> +					 XXV_LINK_POLL_INTERVAL_US,
>> +					 DELAY_OF_ONE_MILLISEC);
> 
> [Severity: Medium]
> Is 1 ms long enough for GT reset-done?
> 
> axienet_xxv_gt_reset() releases ctl_gt_reset_all after 1-2 ms, and the GT
> reset sequence only starts at that release. This poll then gives the GT
> wizard DELAY_OF_ONE_MILLISEC to assert both TX and RX reset-done.
> 
> GT reset-done covers PLL re-lock and the RX reset sequence. With no signal
> present, the CDR lock wait in that sequence can run until its internal
> timeout. The comment at the top of the file says the bound is empirical and
> that PG210 does not specify it.
> 
> With the new check in axienet_open(), a timeout here now fails ndo_open.
> Could an unplugged cable push this past 1 ms and fail bring-up? The
> kernel-doc above says an unplugged cable must not do that.
> 
>> +		if (ret) {
>> +			netdev_err(ndev, "XXV MAC GT reset not complete! Cross-check the MAC ref clock configuration\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = readl_poll_timeout(lp->regs + XXV_STATRX_BLKLCK_OFFSET,
>> +				 val, (val & XXV_RX_BLKLCK_MASK),
>> +				 XXV_LINK_POLL_INTERVAL_US,
>> +				 DELAY_OF_ONE_MILLISEC);
>> +	if (ret)
>> +		netdev_err(ndev, "XXV MAC block lock not complete! Cross-check the MAC ref clock configuration\n");
>> +
>> +	return 0;
>> +}
> 

reset-done is refclk-driven, independent of link partner. block-lock 
(signal-dependent) is already non-fatal.> [Severity: Low]
> The kernel-doc says a missing block lock is expected with an unplugged
> cable, and the function returns 0 in that case. Should this be logged below
> netdev_err()?
> 
> As written, every ip link set up on a port with no link partner logs an
> error that points at the ref clock configuration.
> 
>> +
>> +/**
>> + * axienet_xxv_mac_init - XXV MAC-specific bring-up after the DMA reset
>> + * @ndev: Pointer to the net_device structure
>> + *
>> + * Return: 0 on success or a negative error number otherwise.
>> + */
>> +static int axienet_xxv_mac_init(struct net_device *ndev)
>> +{
>> +	struct axienet_local *lp = netdev_priv(ndev);
>> +	int ret;
>> +
>> +	ret = axienet_xxv_poll_link_ready(ndev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	lp->options |= XAE_OPTION_FCS_STRIP;
>> +	lp->options |= XAE_OPTION_FCS_INSERT;
>> +
>> +	return 0;
>> +}
> 


Agree — block-lock-not-asserted is a normal no-link state, not an error. 
Demote to netdev_dbg (not ratelimited; it's once per open, so level—not 
rate—is the issue) and reword to drop the ref-clock blame. The genuine 
netdev_err stays on the GT reset-done timeout, which does imply a 
bring-up/refclk fault."

> [Severity: High]
> Should the XXV RX max packet length be programmed here?
> 
> XXV_JUM_OFFSET (CONFIGURATION_RX_MTU, ctl_rx_max_packet_len) appears only in
> the ethtool -d table and is never written. Its reset default is 9600 bytes.
> 
> At the default MTU, axienet_device_reset() sets lp->max_frm_size to
> XAE_MAX_VLAN_FRAME_SIZE (1522). axienet_rx_submit_desc() maps each RX buffer
> at exactly that size.
> 
> If a link partner sends frames of 1523 to 9600 bytes, the MAC accepts them
> and splits each one across several S2MM descriptors. axienet_dma_rx_cb()
> treats every completion as a whole frame. Would these fragmented frames be
> passed up the stack?
> 
> Changing the MTU never updates the MAC either, so the software and hardware
> frame limits can be out of sync in both directions. On 1G the MAC drops
> frames above its configured limit, so this does not happen there.
> 
>> +
>> +static void axienet_xxv_phylink_set_capabilities(struct axienet_local *lp,
>> +						 struct phylink_config *cfg)
>> +{
>> +	u32 core_speed;
>> +
>> +	core_speed = axienet_ior(lp, XXV_STAT_CORE_SPEED_OFFSET);
>> +	/* Bit[1:0]: 00=25G, 01=10G, 10=runtime-switchable 25G,
>> +	 * 11=runtime-switchable 10G. Bit 0 is the active rate. Advertise
>> +	 * only that rate.
>> +	 */
>> +	if (core_speed & XXV_STAT_CORE_SPEED_10G_MASK) {
>> +		cfg->mac_capabilities |= MAC_10000FD;
>> +		__set_bit(PHY_INTERFACE_MODE_10GBASER,
>> +			  cfg->supported_interfaces);
>> +	} else {
>> +		cfg->mac_capabilities |= MAC_25000FD;
>> +		__set_bit(PHY_INTERFACE_MODE_25GBASER,
>> +			  cfg->supported_interfaces);
>> +	}
>> +}
> 

I agree, will fix it.

> [Severity: High]
> Can the XXV interface be opened with a device tree that follows the new
> binding?
> 
> The xlnx,xxv-ethernet binding comes from "dt-bindings: net:
> xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet". It requires neither
> phy-handle nor managed = "in-band-status", and neither of its examples has
> them.
> 
> Nothing sets lp->phylink_config.default_an_inband for XXV. At the end of the
> series there is no default_an_inband anywhere in drivers/net/ethernet/xilinx/.
> phylink_parse_mode() therefore leaves cfg_link_an_mode as MLO_AN_PHY.
> 
> axienet_open() then calls phylink_fwnode_phy_connect(), which does:
> 
> 	phy_fwnode = fwnode_get_phy_node(fwnode);
> 	if (IS_ERR(phy_fwnode)) {
> 		if (pl->cfg_link_an_mode == MLO_AN_PHY)
> 			return -ENODEV;
> 		return 0;
> 	}
> 
> axienet_open() passes that -ENODEV back to the caller, so the interface never
> comes up. Should this function set cfg->default_an_inband = true, or should
> the binding require managed = "in-band-status"?


I agree, will modify example to indicate inband in DT yaml& set 
cfg->default_an_inband = true in driver .>
> [ ... ]
> 
>> +const struct axienet_config axienet_10g25g_config = {
>> +	.sw_padding = true,
>> +	.internal_pcs = true,
>> +	.regs_n = XXV_REGS_N,
>> +	.clk_init = axienet_10g25g_clk_init,
>> +	.setoptions = axienet_xxv_setoptions,
>> +	.probe_init = axienet_xxv_probe_init,
>> +	.gt_reset = axienet_xxv_gt_reset,
>> +	.mac_init = axienet_xxv_mac_init,
>> +	.get_regs = axienet_xxv_get_regs,
>> +	.phylink_set_caps = axienet_xxv_phylink_set_capabilities,
>> +	.pcs_ops = &axienet_xxv_pcs_ops,
>> +};
> 
> [Severity: Low]
> This leaves .jumbo false, which the kernel-doc defines as "MAC supports jumbo
> frames" being false. axienet_probe() still sets ndev->max_mtu = XAE_JUMBO_MTU
> for every MAC. axienet_change_mtu() only checks against lp->rxmem:
> 
> 	if ((new_mtu + VLAN_ETH_HLEN + XAE_TRL_SIZE) > lp->rxmem)
> 		return -EINVAL;
> 
> So ip link set mtu 9000 is accepted on XXV. For XXV, is the .jumbo flag
> wrong, or the max_mtu? xxvenet_options also has no XAE_OPTION_JUMBO entry,
> and XXV_JUM_OFFSET is never written.
> 

Agree — set .jumbo=true for XXV (no reg programming needed).

> [Severity: High]
> Where does XXV get the RX frame length from?
> 
> .non_dmaengine is left false, so every XXV RX completion goes through
> axienet_dma_rx_cb(). That callback reads the length from AXI DMA APP word 4:
> 
> 	/* TODO: Derive app word index programmatically */
> 	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
> 
> On the 1G AXI Ethernet, the MAC's RX status stream writes that word. PG210
> describes the XXV IP with only AXI4-Stream data interfaces and no status
> stream.
> 
> xilinx_dma only attaches metadata_ops when the DMA node has
> xlnx,axistream-connected:
> 
> 	if (chan->xdev->has_axistream_connected)
> 		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
> 
> Without that property, dmaengine_desc_get_metadata_ptr() fails and every
> received frame is counted as rx_dropped. With it, app4 holds stale or zero BD
> contents. Zero-length skbs or wrong lengths would then reach eth_type_trans()
> and skb_put().
> 
> The real byte count is in the BD status length field, which xilinx_dma
> reports as the residue. Does XXV need its own MAC-specific RX length source?
> 

Resolved by rebasing on Srinivas' residue series (97f9c11a6dd9, rx_len = 
max_frm_size - residue); note dependency.> [Severity: Medium]
> This is a pre-existing issue, but XXV now goes through the same callback.
> axienet_dma_rx_cb() passes the metadata length straight to skb_put():
> 
> 	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
> 	skb_put(skb, rx_len);
> 
> The callback does not check the dmaengine result or residue. rx_len is not
> bounded by lp->max_frm_size or skb_tailroom() either. Could a length larger
> than the posted buffer hit skb_over_panic()? The 1G dmaengine path already
> had this problem.
> 


Bounded by residue series; note dependency.

Regards,
Suraj

