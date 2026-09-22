Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B448641A;
	Tue, 22 Sep 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100703; cv=fail; b=mBpHVljEDxCxmiQLTqu2crVkzsrCK3T7yEHhc/ExrUVLqFCRdi+2LP7d58AXIFNP5dAPsgOS+epRhF4t3CsenlCJdEuxoNScynNJP9yJ2UE/eTfx82n1Jw3ufb0SWL/aDKRQ1140aNLfL6wPTsd5jyzTOZCBJEdQSrNAq37PFNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100703; c=relaxed/simple;
	bh=CxI0UStYShv4bZm4lAMtpL6P6pSFz4pQ4O8dXbbdOdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5ylUYqeHz1BQob+/AWpPtTew6Of97l1O9Eq8M1fzvfotSgA5tIctBWtpW0SZBTdSir0DTiFfvyzBrbmr6hhwxBRppyV4x7tK62wPgJKbqQ9jCxwUvZxmJVAJ07Jh+mWsstQQ24dgrKu7hFDtAe81emZQHhRj/qK1JvcsMQRVkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mVhBzPbB; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mVhBzPbB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTjpKMtCvezMJbk9DtRmQi0k+CSucH5sAgZcH//TXgP5oT9C7/ikAvSdmT6AyzMSGhvWKV+xNSODTdpAG1tevjtWQbadHgHOZLsbPtWqJP6XGAk8jmC7PY3zrZxyGGS2OW12KzJWwQIvucUE4KW1pGYMzWDd3oTOfE5GMWmvDa0pMCB7A19/DkPXBhm7x7NcjrNeLfq81opBAmEBSE28UcIozfxbulgK5airFNi+9VabNvLguoq6N8EcNXf4XY+z5lrwNfML3Qg5gU5VRG2KQ0vgNisqwCo2UvLVBHncfMXrPs5LVMHvTxXQ2E7e2gbjUlNbdZrQlmUTNtDYm3JrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWQLg3wPd+BKkgBPwvNJbT1gW87LJ5CZ4HGtH8lXwzY=;
 b=gWDnNnwg5N34Kh5eq8zyIp0xzwzl3JllMksr45sJ44RMxpn+Vj9U8JybQ+527EvSMDJx5lRAlHXD4GgjV+x0aP5D5mLB26kiJ2144q1O3cP+Uas4sEkt4/gYXDi7fd5LAs3mFmd5+pdZugm9QyYPa0c/Aca7g9shEeAZhpxzSAz2xxVh1qFCgYVOlFHvC5MVaVx4F8dXAf3atbq9bdV5KYaogaUwGSj0B0qdXZQ5UO3AgcLDxlTC8POCXuLHydsqUu7SksQwib5T4/Ljf88uHrMoXaxrGhVSOhWC4H/tA7vYJSspGAI363JuIDV2B5VM8hWTl8MDWfe6uHKu3fKzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWQLg3wPd+BKkgBPwvNJbT1gW87LJ5CZ4HGtH8lXwzY=;
 b=mVhBzPbBsTFxJNT/qPh8vB6i3ByaXmF2bJUq2fKSIiVcbN72bzwMWQ6Th3F71sAl7x/yzd8oGoqb8yzOOmoo5yFSXMVVjFbE7qUIRWNYCO+26InziDpk2sTN9/5c+ER/O//v4ACZDR6QA9n5xrPFZKov1aTHwltTgbeYtZN1b3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 18:11:35 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 18:11:35 +0000
Message-ID: <408b7740-58a8-4fb6-be78-352773a7db13@amd.com>
Date: Tue, 22 Sep 2026 23:41:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: xilinx: axienet: Free outstanding DMA buffers
 on dmaengine stop
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260917100525.250952-1-suraj.gupta2@amd.com>
 <178998604072.2160803.17018942361014137390@kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <178998604072.2160803.17018942361014137390@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::12) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a5db9a-fd10-4491-279e-08df18d4f00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|5023799004|56012099006|4143699003|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	clAsV5E805FMjjph/c58wrmU2TblY9nsS9CnOKGikuXwi9GbToSjex9QW0m72H7Lqeual6fMeFVsff9Ad+pbWzpmz6qwEmXrIei/nrX1HjzqN6pWn8Hth6hmHXfKXg8uB3ZNcuA9k0izRWCcrkycLKYMYHsQ9YpN+fDqkrCrFs+/DiHyzR12dI2rOMFC2YCtz1V8OWGlpAdYyQeXB1Eg1wJCaTE4mGNyAFfMZ0r0i8wqE1i9Y5SPWIJKX8NGFkSUcxPZTbjzdGwPOW16S6KnQMr/s/1FKCDS7wfbaug6YzzXNlpttDjEtUQ3GOphTkwrH4xeyNrTL9nr7koGwKj6NQgYLOlRljd3a3U4Bn1AgV4vk6Rq1MAvp3TUYOxmJQGrDEq7sMMkOTcYfR3kdV/OFyA9nFjL8sDr10uQSGXvGqi5lFT3lqX+qlcLGwvNW5YJkRH9KHCr9xLyKkMJIQxNr1Cm5nqlVXdv6YLZWt3AmTFFCr0DaepDMozqXydTUX1e8Vmedl1oAP+DIokRWAxC2cuXdFB23TSztff23LibOe8jx71WaQ3W46MU0eefENd3Z0uUvQcqupiuZzuYihBHzAv5dpWsbaUyIElSWFePlw1gVjWcug5r9vQPmesMf3c+5v58Irj6jjm4f+MXaErm7fd0g4BpLqoHgmAgzRoAtdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z005M09JYjIxY1U4RWdOR3hXOE9wUklkSnBWZ2VkUTVxSW9hK3NRck5RdjBD?=
 =?utf-8?B?RVlFVUZOL3E2MU1CUHFaRk83aDExN3kwSnVvY1h6MjdlbzVPaTFkTmp4NEtW?=
 =?utf-8?B?QXBoSVBnaFljN2hJV1BUUnRWZjhiaFpwajZJdEg1L3pPbm4rVUV1MENCSVpK?=
 =?utf-8?B?WDBIdlJlRER2SHhnVEVRQ0o0bS9YZ2xrMllVSWFFYWFLbEs5TENOalJxM3l3?=
 =?utf-8?B?UGI0YkVPMy8zaUVTTytrMGhZR1dlaHpRdWNZZTVRS3NDR1ZTWkMreG04S3dB?=
 =?utf-8?B?TUtvL09rL1A1YUNmSlVFdGlRbXpXa0w4R0VuMVVzbjQ5NCtnQlp5SFhpd01F?=
 =?utf-8?B?RTZpMUV4YjBYMFBrR3hSVDJpbzVNNU8rRWs3dUFCZFkyekp1Qkc3V1lnRysw?=
 =?utf-8?B?Y0E4SGh0VVRVS0pIUUZJSEZxOXhwQy91THZvNll4S0U5TW5laWZaOWtHRHNZ?=
 =?utf-8?B?Z3psa0pKaGVrdTVIaDlKUnBkTC9ienVhckZ6QmZIbWlaYzdqdWJGUkVOSVpa?=
 =?utf-8?B?Q3RCMFd5UnFyU1ViY05FeTh3MjNYcGY1U1hzY0pzY0xVQVYyaVVGYkVLdkc4?=
 =?utf-8?B?RTBpUVkzb0dmaDhOS1lZSW9rYmpzczhWcjFQWEtnZTVSaGo1cXJiMzEvUUg4?=
 =?utf-8?B?b1FmYnNYNzdiYXJPZ0tYRUU1K0JUaFN4NUk2Q0JncmhuSk5Nc2VZRUh3SzVY?=
 =?utf-8?B?WDRNTGRWOXI4c2U0bW5YM2hOOUo4bEFHTC9taWZlZzluc1BTb3pvN0pSQkNo?=
 =?utf-8?B?eE9aQStHWWF4b2dWTVZDR2IvOXExRmtEaWluM2xzaEJzWEZYN3FyTTBjcmMx?=
 =?utf-8?B?akYvUUhVbUFUaXR6R0tWL1lTSWlCajh6Y1NadDNaL0QxU0JXUkdqMCtidWR3?=
 =?utf-8?B?eFVpOUJncllHdUdqQkt1b0l4N1NCcDg0cCtSdlh0ZTZ1a1FFVTIrdms2V3Q2?=
 =?utf-8?B?VCs1SllOY09sRDZvUG1yYUMydVMrMENyd3RyZXpLcFZ3OUtuSk96cGFBUDlM?=
 =?utf-8?B?bHJXSlBYVC9XOGR6a1YyL3Q3dTNVODA5cEVNSDd6MlBiZ05KMTZ6MWlsSDkw?=
 =?utf-8?B?cm1DdERubTlTeWxMaVo0RHlqWUJFKzRKVW9lc3JGRjFJYzRESDZ4VERJbWJs?=
 =?utf-8?B?bTVFb3JwblB2Z0dLL1pPTFplNEZDTEhoSzZ4eTFSa2hRYlBnZlVFMGxpWWtj?=
 =?utf-8?B?Ny9PWDJjcm5qaVFnNGFWVy9OMXAxR0pzTEpBM2p2eEZ0YXFSRlhjRzBMc3hF?=
 =?utf-8?B?WTlGWDFmRUZmUlIrcXhHajluVENUbHpNRHJnL3FTQWkxSC9IRndaeWtXamZh?=
 =?utf-8?B?L3hQMTZ5VmpxVkJYTFJ6dWxjOW8rRXFzN0VHY3FIUWF6OVVEWjNiN1BTK3Ns?=
 =?utf-8?B?OVlRQ1FrMTBUaHVOVldSN0NvNURVcHdFUENjZ1czaEdKd1VZK1NnQ1JmeDYz?=
 =?utf-8?B?OVRSbUhNcEJiWVRZamZuWjB3MitJeTdRQ0h5MG1ieUJySDQ5ZTlFSnY1VVMz?=
 =?utf-8?B?YnlXUjZDZk1RcStmV3EvWElHNnMreFRoUWZ3M3gwR0tSekd1d2x1NzV1U3lW?=
 =?utf-8?B?bVlkT3FmbEZvUkJzSG5Rb3ZlbGhnalpZcXhVOGZvSXB4ckdKMmVJWjRQRCt3?=
 =?utf-8?B?WUhLQUJFRy9Sd28rT1hiZnpWa2YvWHBTVmpJL2FSRkNsSVk2UC96bFVMbGk0?=
 =?utf-8?B?Vmc2L09KZmVrVTNuRTkyKys2OEZuVVlPTmV1UHpmOWZoTFNYSFVhNFphZGIy?=
 =?utf-8?B?T3ZGTEdQSjFhMG1PNzRRREYxVnJPSzR2aUVjRGxzZjBOOTR3OEZmb0xyeEQ1?=
 =?utf-8?B?STZoUjNVdGUyclg4YmFSY2QrNEV4NXN2cDNHcXlvU1BKQjYwbDhCZUJ6ZHVS?=
 =?utf-8?B?ZFZXanUwdmQvRkNYZDNvMFdCT21OTmVoSXNZTm1yK3o5ZFZpN3JkQU5XaHNu?=
 =?utf-8?B?ckNLZDNWTEFqaWVVZisvQVBjZWVmN09oMFN5dEVTTDc3ZUFSYnBXZUNBUEcz?=
 =?utf-8?B?L0RBTCt2VE13YUZVay9xTWVOeFhoamJMcmZLRmRGWFBTZmxWMWhKbXJmb0Zz?=
 =?utf-8?B?dlp1bHFVTEcxeGhQaWZNaDM1cEcxaXhvL24reDNFTzZSSzFmM2pXbDZSb3Ni?=
 =?utf-8?B?L0xMQkY4b25EQkQzUXlPckZFbjhjQ05sMFVXcXhBdHdZUGp5YnptUUNkS2xt?=
 =?utf-8?B?aDFoQ25pZ2pMaytTQ1ZxM2RmQjdRUitOSmxjajZTZmIxMDJjbEsvdnJpeXNh?=
 =?utf-8?B?dEd0QjgvNEpwNDQrSXorb0RadTZvMFd3cU96RlFjOVkrQVFBTXJ5OUh4bC9j?=
 =?utf-8?B?ZkZSQmdESXVBaVIyUGp6MDJzS1YxYTMrcTFRVXlkU3BoVHVvZi9VZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a5db9a-fd10-4491-279e-08df18d4f00a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 18:11:35.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPTadn1lBSVzKZ3iDOILpY3/rG/gw1WM1wuGFej7eZbM3xMLiENcR/8khjuwIme9i1CS5rleb818qmsiODqXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691



On 9/21/2026 3:50 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new @stopping check in axienet_dma_rx_cb() does not actually
>    fence RX resubmission against the terminate in axienet_stop(), so the…
> 
> Pre-existing issues:
> - [High] TX ring head/tail desynchronization causes a NULL pointer
>    dereference in axienet_dma_tx_cb().
> 
> --
> 
> net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
> 
> In the dmaengine path the driver clears the ring slot's skb pointer in the
> TX and RX completion callbacks, so a non-NULL skb marks a slot that still
> owns a live DMA-mapped buffer, and axienet_stop() unmaps and frees every
> such buffer instead of only kfree()ing the ring shells. It also sets
> @stopping before dmaengine_terminate_sync() and checks it in
> axienet_dma_rx_cb() to fence RX resubmission, and releases the channels
> before freeing the rings.
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 1722b7038f340..fc314f67f157c 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -881,6 +881,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
>>   	u64_stats_update_end(&lp->tx_stat_sync);
>>   	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
>>   	dev_consume_skb_any(skbuf_dma->skb);
>> +	skbuf_dma->skb = NULL;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can clearing the slot's skb
> here turn an existing TX ring desynchronization into a NULL pointer
> dereference?
> 
> axienet_start_xmit_dmaengine() advances the head before the fallible steps:
> 
> 	lp->tx_ring_head++;
> 	sg_init_table(skbuf_dma->sgl, sg_len);
> 	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> 	if (ret < 0)
> 		goto xmit_error_drop_skb;
> 
> 	ret = dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> 	if (!ret)
> 		goto xmit_error_drop_skb;
> 
> None of the xmit_error_* labels rewind lp->tx_ring_head, and they return
> NETDEV_TX_OK without ever calling dmaengine_submit(), so that slot is
> consumed with no descriptor behind it and skbuf_dma->skb is never assigned.
> 
> axienet_dma_tx_cb() pairs completions with slots positionally:
> 
> 	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
> 	len = skbuf_dma->skb->len;
> 	txq = skb_get_tx_queue(lp->ndev, skbuf_dma->skb);
> 
> so after one skipped slot the head/tail pairing is off by one for the life of
> the interface and the next completion lands on the skipped slot.
> 
> Before this patch that read a stale, already consumed skb pointer. With
> skbuf_dma->skb = NULL set on every completion, the skipped slot's skb is
> deterministically NULL, so the dereference above runs on NULL from the DMA
> channel tasklet.
> 
> The triggering condition is a single dma_map_sg() failure, i.e. the same
> IOMMU aperture exhaustion the commit message describes as motivation. Would
> it be reasonable to advance lp->tx_ring_head only after
> device_prep_slave_sg() succeeds, or unwind it on the pre-submit error paths,
> as part of this series?
> 

This is a pre-existing issue, will address it separately.

>> @@ -1171,6 +1172,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>>   						       &meta_max_len);
>>   	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>>   			 DMA_FROM_DEVICE);
>> +	skbuf_dma->skb = NULL;
>>   
>>   	if (IS_ERR(app_metadata)) {
>>   		if (net_ratelimit())
>> @@ -1193,6 +1195,12 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>>   	u64_stats_update_end(&lp->rx_stat_sync);
>>   
>>   rx_submit:
>> +	/* Do not re-arm the RX ring while a stop is in progress, or the
>> +	 * teardown could free a buffer still handed to the engine.
>> +	 */
>> +	if (READ_ONCE(lp->stopping))
>> +		return;
>> +
>>   	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
>>   				   RX_BUF_NUM_DEFAULT); i++)
>>   		axienet_rx_submit_desc(lp->ndev);
> 
> [Severity: High]
> Does this check actually fence resubmission against the terminate?
> 
> axienet_dma_rx_cb() runs from the xilinx DMA channel tasklet, which drops
> chan->lock around dmaengine_desc_get_callback_invoke() in
> xilinx_dma_chan_desc_cleanup(), concurrently with axienet_stop() in process
> context. READ_ONCE()/WRITE_ONCE() only prevent tearing, they do not make the
> check-then-submit sequence atomic:
> 
> CPU0 (DMA tasklet)                     CPU1 (axienet_stop)
> axienet_dma_rx_cb()
>    READ_ONCE(lp->stopping) == false
>                                         WRITE_ONCE(lp->stopping, true);
>                                         dmaengine_terminate_sync(rx_chan);
>    axienet_rx_submit_desc()
>      skbuf_dma->skb = skb;
>      dmaengine_submit(dma_rx_desc);
>    dma_async_issue_pending(lp->rx_chan);
> 

Agreed, will add a spinlock to guard the callback's re-arm and the 
stopping set in axienet_stop()

Regards,
Suraj

> Note that dmaengine_terminate_sync() ends in dmaengine_synchronize(), which
> for this provider is xilinx_dma_synchronize() -> tasklet_kill(): it waits for
> the running tasklet to finish rather than discarding what that tasklet
> submits.
> 
> Does the late submit re-arm the hardware? xilinx_dma_tx_submit() queues the
> descriptor and clears the provider's terminate state:
> 
> 	append_desc_queue(chan, desc);
> 	...
> 	chan->terminating = false;
> 
> and xilinx_dma_terminate_all() left the channel idle:
> 
> 	chan->terminating = true;
> 	xilinx_dma_free_descriptors(chan);
> 	chan->idle = true;
> 
> so the racing dma_async_issue_pending() reaches start_transfer() and
> reprograms CURDESC/TAILDESC with DMACR.RUNSTOP set.
> 
> Is anything after that point stopping the channel again? dma_release_channel()
> -> dma_chan_put() only does:
> 
> 	if (!chan->client_count && chan->device->device_free_chan_resources) {
> 		/* Make sure all operations have completed */
> 		dmaengine_synchronize(chan);
> 		chan->device->device_free_chan_resources(chan);
> 	}
> 
> and xilinx_dma_free_chan_resources() dma_free_coherent()s chan->seg_v without
> a stop_transfer() or reset, so moving the release ahead of the ring free does
> not appear to close the window.
> 
> The new teardown loop then sees the resubmitted slot:
> 
>> +		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
>> +			skbuf_dma = lp->rx_skb_ring[i];
>> +			if (skbuf_dma && skbuf_dma->skb) {
>> +				dma_unmap_single(lp->dev, skbuf_dma->dma_address,
>> +						 lp->max_frm_size, DMA_FROM_DEVICE);
>> +				dev_kfree_skb_any(skbuf_dma->skb);
>> +			}
> 
> Can this unmap and free a buffer the engine is still writing into, turning
> the former mapping leak into DMA write-after-free?
> 
> Documentation/driver-api/dmaengine/client.rst also states:
> 
>     The behavior of this function is undefined if dma_async_issue_pending() has
>     been called between dmaengine_terminate_async() and this function.
> 
> which is exactly what the racing callback does inside the window, and this
> patch removes the extra dmaengine_synchronize() calls that followed the
> terminates.
> 
> There is a second placement question: the ring is dereferenced before the new
> check,
> 
> 	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
> 	skb = skbuf_dma->skb;
> 
> so a completion from a re-armed channel arriving after tasklet_kill() and
> after kfree(lp->rx_skb_ring) touches freed memory before the @stopping test is
> reached.
> 
> The commit message says "Set @stopping before terminating and check it in the
> callback to fence resubmission, and release the channels before freeing the
> rings so a late completion cannot touch a freed ring." Given the above, does
> the check-submit-issue sequence need real serialization against the stop
> transition, or a second dmaengine_terminate_sync() once all callbacks are
> known to be drained?
> 
>> @@ -1752,20 +1761,43 @@ static int axienet_stop(struct net_device *ndev)
>>   		free_irq(lp->rx_irq, ndev);
>>   		axienet_dma_bd_release(ndev);
>>   	} else {
>> +		struct skbuf_dma_descriptor *skbuf_dma;
>> +
>> +		WRITE_ONCE(lp->stopping, true);
>>   		dmaengine_terminate_sync(lp->tx_chan);
>> -		dmaengine_synchronize(lp->tx_chan);
>>   		dmaengine_terminate_sync(lp->rx_chan);
>> -		dmaengine_synchronize(lp->rx_chan);
>> -
>> -		for (i = 0; i < TX_BD_NUM_MAX; i++)
>> -			kfree(lp->tx_skb_ring[i]);
>> -		kfree(lp->tx_skb_ring);
>> -		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
>> -			kfree(lp->rx_skb_ring[i]);
>> -		kfree(lp->rx_skb_ring);
>>   
>> +		/* Release the channels before freeing the rings, so the DMA is
>> +		 * fully torn down before the memory its descriptors reference is
>> +		 * freed.
>> +		 */
>>   		dma_release_channel(lp->rx_chan);
>>   		dma_release_channel(lp->tx_chan);
> 
> [ ... ]
> 

