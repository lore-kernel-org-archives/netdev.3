Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39D3F5BE6;
	Wed, 30 Sep 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763581; cv=fail; b=lRW4xNFsqlbwlnePTw3VJWFFizKR3yeV1Q9SpTnYX7L2DMYZ++7nqqLElyymVLvYMn6sFdOGwMSus1HPiyQNdZH9OvQeWtm8c/TMXwKTrg1l9pUb/IrdhpMkV2VG+eoQ7Hg/aeqMDCY7seGLOoWzsfj53E089U6QiLYpL20J+cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763581; c=relaxed/simple;
	bh=r+z/wmzxQ9t4Afv651u5oPjNnNA7RB5uptwvFB9UA1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPbvBGgRlEE97UmstrL8RV4cWJzZjBwvTgfKvD5HRumOnZ33iFhXb8T6HPUOeqyLvMsVXyOVWNeK5lcgqWUk4BlmvpLjXL1pToIKJwEsvFw9Wy5SpqwyzZgSXnU+SCIeneXalM1QS0jwcrc1gTw8YDE966uPwpGtwL7cP2gi1Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vvNkc2Ft; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vvNkc2Ft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuKMbIpP2g2WG6zrVnlaDeZdouOSS7S5kWNSDyH2RoLes6EHFcZZppW+ezr2mViwy7cHwqPyQv0be0CJBv+gt6bCEWLBjHO0OSbg3a1ka7lDkt5KhA7Kp2sTiY+a+k8YKepO+MmgvAmVgkEcM6MLNbTv0KcEJMpPopGA3vbaMNHy2tlKnc+vOLcdJAyebxiNOuLhpw/UOKyvef4fXfekJGHY0oc8aH7Uy4hBpzkyTa4q7ISO89ISgu+BUtIh69b8IdAO6V/qoZYeuUDUFwmC9PPVQwbqqdVAs+RNV/nXYEZ/Wm4pk4vAJcMwuMFTHy0T0nIJDnZUub5pIpUj6Eh18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WKG3oBYccLzQ3BYVyeJsgMN3gpamG0UYKfzbD+4wp8=;
 b=gUqSFPiqA6pR+Kt3oL872g4+2h0449Ln4o+v7DBUK6Ucj2BqvtyEikp9cMkEBGl2hgQ1bRjpQ31aZ9dPq1FY92AGryGxasCmF9qclNeq1bvcthL3R/Uldffpc5EzMFTuxhihT/J2neBNcMl2RNEbCd8ZrUa081Lp6t9ZmKhId/WQC7fQFNXS8iAMqOT1il/4hVf5qmrAOrnBs/AeyGFGFo0KZ9FTXAc5u2paSOudHYfoDh8XgCxIcCGfbPweLw2kW1wUHG6KcMXQrNZRT+t8DzW0w7FzD/xod+fvsTBjxDpTjOcnHmmA0twYxlHDmEbdbX5yYFPAyXeX0I3OPgwVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WKG3oBYccLzQ3BYVyeJsgMN3gpamG0UYKfzbD+4wp8=;
 b=vvNkc2Fte3A/SytFbtOPCoojZojkNECsJQK54Zxu6MYUadqMHOYg2nsPxBQ+kZxVy0ipKmHG4vu3pGwnC0DlaKmMu6mBTWnrnTKs4PYItQVZTxDrHjV7KxkCcTFWsF+gjRXWl6fgMs3r5MXprIwdUPJsMSq/Y7DKgIua0sjYAMg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:19:23 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:19:23 +0000
Message-ID: <c25e3096-3801-44a1-998f-5f9377bd7161@amd.com>
Date: Wed, 30 Sep 2026 15:49:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: axienet: cap the TX poll return value at the
 NAPI budget
To: Sagi Maimon <maimon.sagi@gmail.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robert.hancock@calian.com, sean.anderson@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260930071536.627964-1-maimon.sagi@gmail.com>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20260930071536.627964-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a24a16-5603-4ad7-df43-08df1edc4c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|22082099003|10067099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	m1UdReGfxtEfI5disR5vba9qsmkiwLmVlFt/Ydz85/w969GPxAQIc9pcRkGoVvSwRggxOm0MMM5opZ+9lPEhsnv+dnPcMdcM35S1ft1ArPVOvLcs7PA2XSCWrohj/KKcSu9pdVOTZ0BBY/zU1EOvGpZzYCjY2FUhhtiYObQBoQKQB76RsFHtvtufnR/wcF0NHhk3/HjBGYwDl+pkCYsYTl78gnsVnzGyv7Th/uEU5YBKJorrVUXKfo+OqjoGOIpiyEKefo9RnvfYNbfdENiM7h5J9V6Yq0eKGRO8s+cw7lp5GFNKKTCgI/mZJ9duXq3GaA4D1TPYH9tRUDWZNSNDq/yWszjYJitbLnXqzvhVZDCxlFmm90ww7Yr4ahpFLHdCSpXFmTbxSKnRRv7dbF8DKWYmi0os53AEmMWXp4eumXEPVwLp+ZsdjspNjnIosnS+3RPsZLJz+NNDqoKK+4jTGorUD2yi+rmS92EoaFa4n5coIeIeTcE90+F2tky8NkrHrFijjkbUTitqh5Vsm5KelrjSWjqB5qAsNY2zFuoU88/isXt6xlm75HsBWaSKfA+0Enrc/5Bd7+lOqq1Z7Sjjw/I5QY/ZVGqTrcmb6VP3Ub2tpdQmnTGM8J06UcvnaORYLRQTHt3aY4jgb5tH9zab4A5S9r74SoRrnWM3Jel17Go=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFZ5TWYxb0pJRk1YOVJpMjQwTGF2eXNYc1dYRkQ3NHlhQWFVWkIyK3h0TE9F?=
 =?utf-8?B?SEt4TkUvVEU2b1hBZFgrT3RYajRqeXQ4bTIyVUg4TENLZzNjMUwyb0dFeWRV?=
 =?utf-8?B?bEdiL2RYZmthNTI3RW9lZjYzWjY0WUxnWU5hZ1J4SE80STMvVFZtTUJvcndN?=
 =?utf-8?B?cHBSL0ZidWZxbzdXbzZMam1la2V5aFIvajFJNmNldkdKYUlocndsVW9VMEpp?=
 =?utf-8?B?T0hsK1VQdVZNSzNNMnFCYWE0S0RYakRNZGF1NkZyVlhWYW52bmJXME5TY2J3?=
 =?utf-8?B?WGxaVEVWdVBLem1xVnUwUXM4UEw3MSs3amRxMWdhdzVuWFphNFJqRTloTHhO?=
 =?utf-8?B?eXh2T3o1RmVUd0dvanlPWlNKVmJjTUhXWHI5MXd0SnVXWW5vZUVxYWYwa0lt?=
 =?utf-8?B?NXBQbG9ranJkVUpDOWZLMUVPb1kzYTQ3cVQxbXdKU0x3djVGemljYUhxbDN3?=
 =?utf-8?B?UGdheEVFbUhSdDBJRCtnNEdnVXI5M1ZEN1ZGdWFpV24xdlptRyt5RytIRlBa?=
 =?utf-8?B?YnZlTkFZTnZzZUZ3VUY5YVd4OENTOGgyd1ZFZFcyRk1DOXFVUWNTazJLbGRI?=
 =?utf-8?B?NUJCQW5QcytFdktKcFI4MmhsWlA0TFRpcHVNNEZubU5WM0N2TW1VYUJCT29K?=
 =?utf-8?B?dkxEekZYTDlPQ0EvWEJKazlTeFVWZW5PYWVzUXR4YXVrUDl3dWNSRlNlZGtn?=
 =?utf-8?B?aFNSYzFRaUYxL1BHQVRLbGRKS0wwclJ2cEFwcEhKTW9vR1lBeXRBR1dCSklk?=
 =?utf-8?B?OEJNb1lQZHJUck9xcG9qWmhDTDVtcFJRdmNOaGY0dWJZQk9zL2hHMjVKRzFl?=
 =?utf-8?B?eDUzdi9YaEtlYmVxQjJudGZSUU1aNXR6bDlkUnFTemcySXJhM2ZycFdmTzdp?=
 =?utf-8?B?UEwxOWdnSm04QnpXemJQbmpCU0ZTdXFJenlVY0NQc3lKWkkrTm81d2d5WFlP?=
 =?utf-8?B?YzhCaXJ2dWx4cnFScHVtRnVnZ0xvNUhjRFJPQkVBRzBBZi9mZVluZUZCR3Mr?=
 =?utf-8?B?OXZ2R1VseGQ2R3dhV29ZaXNSRWZ3cVprNFJhd0ZldUcxcHVBYlV5TWNkYm9t?=
 =?utf-8?B?WDBPSnYzRDJtL1pXQ0MrUTBia3VmSWgyWW1iV0Z0eW5EUXR1amNkS1ZHbGYr?=
 =?utf-8?B?WXJxQkZqc1BzYk1vVEdEVFl6MUZ0aFpEMnZIdDQxc0g1RFNneDByTHBhYXpo?=
 =?utf-8?B?MU9heVRnZXFubFRlYVlVbFJ1SWJFandGRzh3Sll3UWU1Z29SWS8yYk52VFJo?=
 =?utf-8?B?K1Vhei9zcGc5QUM3ajY2ZWRoTVVhSnAvSW8zZXo1My9KQkJWMUxJcGlZRE9s?=
 =?utf-8?B?eTdKYnhQSmpnWkQ2djN6a09aOEs5UGpaRlJXQXM4bGkrckJ2L2pWYXpCdk9w?=
 =?utf-8?B?L1Nkay9aVndsaFl5amJHZHh3ZHQwSmlUS09yMy90d0ZpY3FmR0J6WnBLN1Y0?=
 =?utf-8?B?c3BzSzE4QUhReGlxNE96c3U1K0R2YlU1T2picElReGVPc1dabWNhc3gxbW9x?=
 =?utf-8?B?WkV1NHRyVGU1UDZHZW5oem1JQnRabUtuak1VUWlhY1MxMk1pM3IyVHo0L2dP?=
 =?utf-8?B?Tzd4RDNIUDJYY1JjYjZyNUw5YTVicjBzQjRablVJTUxnRm9VeXkvT2V1ZXpJ?=
 =?utf-8?B?MzVkRkdJdU4xVWxMdk1IbkZnTHBnUTRvTUtiZ25oNURUSCsyeGd6ZE1IZkU2?=
 =?utf-8?B?N2tWeWFpZW5nckkxS01DQlBQN1ZIb2dxcVJaUTFnVzhKMWhHRmFnUVN5MzBp?=
 =?utf-8?B?TzN2R1MrN1pBMkRYTHZXUUw3bThFR2FJOFlZTzcrRnhGWXhqaVErUmRseTAw?=
 =?utf-8?B?QkNkRE51VDZTamxETzRmeVlpMXdaT3pFWURkbElHbXJzN1YxYktDeVQ5bmVJ?=
 =?utf-8?B?a09VTlBKRW5aS1lJZ3JjaEFmcFFLc1hUVitkd0w1VVVveTRMN3FKYWZDS1Iv?=
 =?utf-8?B?b1FzaldyV013OU5GTmZyZWNjTjF5T2NZOVJidkZULzFqdlFnY2w3Y2xTY0Qy?=
 =?utf-8?B?bjk2bzE3RHJrWkFGVmxVZWZXaUJuZXFuNnd4dEN0K2pzVkEyQlFnTysxSitC?=
 =?utf-8?B?a1oyM0NnTUM1UXpUNTVGZEY4Wm9nWTFyT2NaVWFmSDdDc2E3bkNQL0xVNGRQ?=
 =?utf-8?B?NUdFOUJtZVYwNDBsTmRlaE9pbktRSllUc0N1eGxrVS8xb3lEU2p5SklQS3FX?=
 =?utf-8?B?Vk84YkZZNHJLeGFTNWlJai9NeWlvVTZNT081VlUzZzBCMFUwR1pnMS8yb05S?=
 =?utf-8?B?eFV4YzBQeFdvdExmYlFKMG0vQmUvRzFwVm5KU0ptN044VWV2Sktha3dNUHdi?=
 =?utf-8?B?YzhKaEtEVUd6djZhZlpRbFVwdk82VWM3NVZmZUlreTBDeHBLMDlhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a24a16-5603-4ad7-df43-08df1edc4c51
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:19:23.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ORwOY6hpJBLRE+Q4VjBicX0AE0BAdnAiF0zCW5l0EydAdQWPuUYTgzg+M9Bi5aCH6izglGGyjhgdhWryzv4qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702



On 9/30/2026 12:45 PM, Sagi Maimon wrote:
> axienet_tx_poll() reclaims every completed TX descriptor in one pass:
> it passes lp->tx_bd_num to axienet_free_tx_chain() as the descriptor
> limit, and @budget is only used as the napi_consume_skb() bulk-free
> hint.  It then returns the number of packets reclaimed, which is bounded
> by the ring size rather than by the budget, so the poll can report more
> work than it was given.  This was seen after TX completion interrupts
> had not been taken for a while and a full ring was reclaimed at once:
> 
>    eth0: NAPI poll function axienet_tx_poll+0x0/0x180 [xilinx_emac]
>          returned 96, exceeding its budget of 64.
> 
> netpoll is affected as well.  poll_one_napi() polls with a budget of 0
> to reclaim the TX path only, and warns once if any work is reported.
> 
> Keep reclaiming the whole ring and cap only the value returned.
> Documentation/networking/napi.rst allows a poll to process any number
> of TX completions; it is the reported work that must stay within the
> budget.  Stopping the reclaim at the budget instead would also leave
> completed descriptors for a later poll, which does not come when
> napi_disable() is pending.  When more than @budget packets were
> reclaimed, returning @budget keeps the poll scheduled, and the next poll
> completes NAPI and re-enables the interrupt as before.  A budget of 0
> now yields 0.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Fixes: 5a6caa2cfabb ("net: xilinx: axienet: Fix packet counting")
> Assisted-by: LLM sparse
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> 

LGTM

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>

Thanks,
Suraj

> Notes:
>      Changes in v4:
>      - Different approach, as Paolo Abeni and the review of v3 suggested:
>        keep reclaiming the whole ring and cap only the value returned,
>        instead of stopping the reclaim at the budget.  napi.rst allows any
>        number of TX completions per poll, and stopping early could leave
>        completed descriptors behind while napi_disable() is pending.
>      - Subject changed to match; v1-v3 were "net: axienet: bound TX
>        completion cleanup by the NAPI budget".
>      - Fixes: now names 5a6caa2cfabb, which made the return value unbounded
>        (review of v3).
>      - Only axienet_tx_poll() and its kernel-doc change now.
>      - Suggested-by: Paolo Abeni.
>      - Build-tested only so far; v3 was tested on hardware, v4 not yet.
>      - v3: https://lore.kernel.org/netdev/20260924135052.185129-1-maimon.sagi@gmail.com/
>      
>      Changes in v3:
>      - Report no work for a budget of 0, so netpoll cannot trip the
>        WARN_ONCE() in poll_one_napi().
>      - Add the Assisted-by: tag that v1 and v2 omitted.
>      - v2: https://lore.kernel.org/netdev/20260917115657.20697-1-maimon.sagi@gmail.com/
>      
>      Changes in v2:
>      - Treat a budget of 0 as no limit, so that netpoll still drains the TX
>        ring.
>      - v1: https://lore.kernel.org/netdev/20260914114821.55503-1-maimon.sagi@gmail.com/
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f34..243b07fd5be8 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -984,9 +984,9 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>    * axienet_tx_poll - Invoked once a transmit is completed by the
>    * Axi DMA Tx channel.
>    * @napi:	Pointer to NAPI structure.
> - * @budget:	Max number of TX packets to process.
> + * @budget:	NAPI budget, or 0 when polled by netpoll.
>    *
> - * Return: Number of TX packets processed.
> + * Return: Number of TX packets processed, capped at @budget.
>    *
>    * This function is invoked from the NAPI processing to notify the completion
>    * of transmit operation. It clears fields in the corresponding Tx BDs and
> @@ -1027,7 +1027,12 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>   		axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
>   		spin_unlock_irq(&lp->tx_cr_lock);
>   	}
> -	return packets;
> +
> +	/* The whole ring was reclaimed above, which may be more than the
> +	 * budget, but a poll must not report more work than it was given.
> +	 * netpoll polls with a budget of 0 and expects no work reported.
> +	 */
> +	return min(packets, budget);
>   }
>   
>   /**
> 
> base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7

