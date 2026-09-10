Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A047A0A9;
	Thu, 10 Sep 2026 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044432; cv=fail; b=VnleNSOSfPxwBUuM3cnB6UpxjN216mQ2jd7r+r2Z6Y1Ixe49tWxlCPCMSCOBfiUn0Ij8+74411Yh51lKbXnU/FPNaEZoNCvMsVXHXmaw/YMjoDAdc/6KstJFtI9oxjFZuQKt1Ia20K1XPVHtzoKC0Jtvd1BG405Uf3NaLU89ZZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044432; c=relaxed/simple;
	bh=qDP/W/JrYxl/fXJDslVJK+FJYlF3OWGkcX1muw8WynM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjT+djZVCyM506vEVvLN4a4RBm4YBDyaGJ5MtwCcKV5MhfwcdNdXT+CK8BWKvMdCD5rGL4cMfUWoUT8iltz+AW62z7E+fW5faajIO3pV+M1XDEB/K8d6WZgWGubSIIlFpA+qroFmmCcwuE8kby9D/jX/mVwVvwXzBakeUfj7rG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tn0m2M9Q; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tn0m2M9Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlngHRuND/dm/MtoyMDCc2TtJQUTJSgciU9xWV/y8PD9TsXS88gLCMFbB1sG1xxMZX2TZBaEJBsm+fqlE4r2GARpQD6O/bCfbbKyygZiid/EznVSqOFJ8Uii9V4+CduwVWtARWDBJ3HabRdF2o3kPOQVp77GD7+XWHMxBSYLGx+VnIJX1gzbNxTXgAGmxi3O3eg0Ec1RdO725huUdZx3LQJVSmnv0dXieLfRdYNh/JMt6FzgffCSEJQgrexQxygjXg0O85L4cBtFtsduaQloQ+srUNvXnpEKZa0oGOGtIqYNCWM74nKek/tYIUu2XtvQK0Ie/M74Fw4uB1Wnvdbavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAy5Umz5Zq+nT/vwP5loxINh/YMraJMmGad4DijJYJE=;
 b=QpLHQbmvGV6LijGGJXVyOe65Ye+yyAJcB77mbFKRXAkGzZZvC6/7ajIV5iRT2fDcTfoM3Gad0UtNS8/bvoyAfc17ZztddAaeUiVJswUFfhhsFWzrIaHWqal1iZEu2+TnQXZ4RUDKpwajpz6N5BkthCtlCuCoRzq5ahu7vpHZ2oadVZk1TU4YoV/An5Mi3OC2qoofTKSJyPyvZ0YuYHoozAd0qEF7+X3YEjvKTF+jQ1waFeIhTVMbQC0gwCT4pkvHF8Wdf4qXeqvRLP3m2vXxS8J3yVf4m4VJuquYHHFJVG7mBHAzMk3kWVsS0+Lm7Op9LFDL4RSKtgGX6+eKwoLWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAy5Umz5Zq+nT/vwP5loxINh/YMraJMmGad4DijJYJE=;
 b=Tn0m2M9QVPgVP0+Z6gJUFcHI1V5zTyL6tD4jH52Klrv6O1BfCdPrBtZykqSM8B5bWQ+uv44o67fOTM3awr+1RIjKJ3JN4+L3WnTKyd6l/ivtc92RSux32sQck1x8Ueppsshgun5DBTau++p+loyOXpGMJt1hFuu+CVHaqO6J+wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 12:47:06 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 12:47:06 +0000
Message-ID: <f449acd3-4e79-4d88-9eca-baf4d99c20e4@amd.com>
Date: Thu, 10 Sep 2026 18:16:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ
 coalescing parameters
To: Vinod Koul <vkoul@kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "Katakam, Harini" <harini.katakam@amd.com>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-2-suraj.gupta2@amd.com> <aICPiS1_ITwELrxq@vaman>
 <BL3PR12MB65713879CB569E3B330C1E76C95FA@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aKxJQLx6yprNdU03@vaman> <3369241a-b591-415a-9f40-36f95bdd6a9d@amd.com>
 <aqFWBEct9AoIR9KC@parshuram>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <aqFWBEct9AoIR9KC@parshuram>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::7) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c721829-7ef7-4762-8d97-08df0f399eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	InjQR8IQvJV9FfvDUgaAuDCWUiJpgDuHL6EEw0fC2X93sF/7YKZ9pMnr3znfO1IOejoaLx4vYrlViBRgAV1XUrBXqyDb3sza9HNmKZmOqh4yaDkI/SnyFawa4XomW1RfDkdWd1oDUmD83p4c9Y4AfxeqC/3bniVC4K9daBqaFrvYzE6OloUi3YhCmjFgfNQT1+umFWZ62nuiNsrxawmNBqHlfukMtB4fXZ5MlgI5mIb4vWI/WcP44N3ZswBYgoZsPrH1RVVqOPEjIR1wwj9GXxMiA84mobVCPsjktpww6lq6Don0aeNOJOtuWWiOq4N7ZXRxGcLJE2ct2z2/OA/+CLJeJfiSuEZgglA31JL9IR/NBQ6eN0WzqE3hNfp1R9ZVDAX1HAq0/Zok86c7BDdgYNBnoOhPeVk0Jakd+0wR0MiLcA2n+nDfNY33bNw+bBGbkpYSZ+g6LXZe30bCwJw4JE5fw9VvQ0GBruRMH4cjlcnjDIhV/braMDVC7WD7mnE+qMUNMYpyI4rAeShK+BPozYw8K1gdCWx68yq5K1wSu5/6gD2yJ7M4EfEYiS7N6gtXSs1EyK9zv0mgmhRCUGekS+A+RurO6rZmmMSKHhOiSW3K8a1BLV7GaMolSuMx/wIqRVdIEOMuAxOCDQoJ+YdXyZppM6Bbp5QNqtVMBpD+DEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Aycm5FQnhKZE1ETnErRWFmb1c2Q2sxbjlWbENXaDhpK095eDlsN3RWNy96?=
 =?utf-8?B?U2JPRktGWDZ1WlRSQW9ZM2lpdG9MVHY1Y1E5OHFsZEJmcHhxV2FaQ2dsSnFD?=
 =?utf-8?B?bDV3QTFtQXQxRGR3MVBpQTgrSWVLdHk1OEVHSkFncHBWRmcyTXdEY1pTOVMv?=
 =?utf-8?B?STBkcUh6NFhNWVRMTG5ubGlicXlIWmxlSkxmcnlQcXpCeVVqeVlqMFVkZEk3?=
 =?utf-8?B?eDBCMU5xZXRFb0xvM1AzMWM4TDRDU0N3S2lZMEdjT0JDTVFxWHYzeGJrNlB5?=
 =?utf-8?B?MWlpOUttMzFtSmJVZGhxMDF0VlVHR1lFZVFEVmRKMHJPSmZMQmhpNXFucUxP?=
 =?utf-8?B?ZXFRQ1FhZGF1OGpjWkZvM3cwWmNKdjR6aDZTZXdVSFVwSmEwMXBEUVhsdUg0?=
 =?utf-8?B?NG1RRkxvKzMvN3plVVFiRnpJbENLa2ZFb1lod2lWYVVaNWt4cHZsVXUxU3Bw?=
 =?utf-8?B?UHlCWE11L3BIcHk1NmpYSGNEaWVGZ1VyRkJMQUZzRk40a09BV3ExMTRkaHVQ?=
 =?utf-8?B?cENUOVphRlVkU2dVRlJkU3FTMEpScDBXd0pmbGlMTkZ4c00wRVRTeEVlcjJR?=
 =?utf-8?B?WDdTb1dXTnMxN09nM0tiY0t4UEFaRFdnTDB5T0UvNnpnY2NwYlJZK3BSdkNk?=
 =?utf-8?B?ZGZmbzcwejI3NkhPZFh3ejVFV1U2U0tTMWRFVWlnK1FYSmtNc201Qm1PR1hm?=
 =?utf-8?B?Z0lGRHp5ekpOUThZc21lSzVUUWJLQUZWK0VYczFsQmFxWnI4aFZxdW1ObWU2?=
 =?utf-8?B?M21iRWJoTUp2Q09YTjBwWHA1QnRORXZ5Qm5BZmRMYWlOV2FLbnN6allnbmRW?=
 =?utf-8?B?TmpoVFBDN1RVbFhYMndGSkk5SnhjVHlIRHBueGZncGtuNVNvVnJjRkpMNFZ1?=
 =?utf-8?B?My9nbEJYd2dSTWEzdngxV0QrazdqZ3BrbjZla2locTV1NTBHNjdVeXVaTmtr?=
 =?utf-8?B?ZXBPaVN4QnhZWWw5dFRnbW9xRUJrTTA1MEgrQkM5bDVFTklhNVdtWVVpaURz?=
 =?utf-8?B?L3M1Yzlja2RKbHkvWk1zam41anhZeWtDaSs0ZW4yZEFiN0JuVWNqdXVtdDZO?=
 =?utf-8?B?VlJTNUxzVElGWXI1NmtlUCtYZGJmU0hXcjRyZmkvdXhXbnBFNnU2cGdUakVt?=
 =?utf-8?B?Q1ZFSVlUbWFWdXdXQmVzalViaDFDT3A3dkw3R3RERG1qN2RqSUF3a2RNS1ZH?=
 =?utf-8?B?RVp5TG52dGFTR1cyRWFxZnpZZXNtUm9CU3JlNFdxRjU5RkpucmI1VHVOSm42?=
 =?utf-8?B?ejNqSm1xYUhDanhpRS9OR293WXhhUGJVZWc5WUw5dnJuZDlmb1d2aHZYVTZw?=
 =?utf-8?B?YnVuR2JSeDArUlNjc2d6SjJ0RFA4NkgyZUlVMWs0aGlSa1Y1S0Zxd28zWnow?=
 =?utf-8?B?SDlKL3Y2a3NBTEhkeWd0ZnpuMWQ1WGg0ZW1rMmVpMlJFb3c0b05ST2ZVWXVX?=
 =?utf-8?B?dlhoOEYvSW5IcXRnSk1laWNvVCs1ZlpSSU45eFdJa2M3ZEZpWTJUTldtZVZh?=
 =?utf-8?B?aEx4QjlSbW1GenkrQ0pzVW91akRUVFhzeURIdU1HZUs1NTBUOFd6L0Nnc3RJ?=
 =?utf-8?B?SWRORGJFaUdOK1FOeU1yaThUZTZ6dExtRThWUWlxMWNIY0xMKzFSUllTWGRs?=
 =?utf-8?B?elN6TEtlUkdPMGZ4dGxEdnJuR1IyN3RyTDgzbGU0VEJaUzlTZ0JyTC95VXRC?=
 =?utf-8?B?VXl5ZTVXZTlpNUJPQnNYTG1tNThLbTdtbTVsaG83YzFQZkV6R0dtUFlTaXNH?=
 =?utf-8?B?T0xuQVBHWG9jRlZoRFNCTUpERzNWaERGOXpBVmRRb25QYXVTVVZ3aVpBcmll?=
 =?utf-8?B?RWJjNUZjbGVUSitEaFNyZkJ2ajRDNEVKY3RWWnk1cDdldkluL3JHcDdiRG1X?=
 =?utf-8?B?UFhTTnIrYW1XZjhPRmxPTE1NTDJuQUt1Z05BWGZEUERkbVRLOTZ5c1BYYjBG?=
 =?utf-8?B?RHpKMkdQeEZHb2dKaWhVTGpXZmhGUzlsZ28zdGt0RCswTWJBa2p0NVhRQzQw?=
 =?utf-8?B?NW1vcy9VSGMyWUhvRU1hL2ZBeDl3ZTR4eVV5YndjTXYraWxCdWFvTzNYaVU5?=
 =?utf-8?B?UmZjVEpHTW1XZHhHVmIwanpZRElRd1VVVm01THhpSmpvQjd1NDNOUlZzK1Fl?=
 =?utf-8?B?elhMZnNUZmJtV2t2b0lFZjJNcmZvK0hVMWpCdmtTeFJXQW1YdTBKNWt4NWJK?=
 =?utf-8?B?ZktLelpzUlFXTVUvYVlBSmQzY3pYVThYVHpic29WMU9BLzJydHZYQUd2aVB2?=
 =?utf-8?B?RzB5NXQxckZ0eEQ3L0gyUEE5b2RBUDc4OG5ab2gvdjFBRm1JZGx1dHUyQVlB?=
 =?utf-8?B?MExDcGF3Lzkya2YvYTY5bWszTEY4V1paQTZTb3ppTThjOEExdHdHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c721829-7ef7-4762-8d97-08df0f399eaf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:47:06.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xljmtrk2UTmiH4vuMuDNMyekflyvEQgpVzWeRBIyArTl+mUlJU1SantkE26d4VVOb6fgt0t991C0dfmtg3xIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812



On 9/9/2026 6:20 PM, Vinod Koul wrote:
> On 07-09-26, 20:23, Gupta, Suraj wrote:
>>
>> Hi Vinod,
>> On 8/25/2025 5:00 PM, Vinod Koul wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On 23-07-25, 11:49, Gupta, Suraj wrote:
>>>>>>    struct dma_slave_caps {
>>>>>>         u32 src_addr_widths;
>>>>>> @@ -520,6 +528,8 @@ struct dma_slave_caps {
>>>>>>         bool cmd_terminate;
>>>>>>         enum dma_residue_granularity residue_granularity;
>>>>>>         bool descriptor_reuse;
>>>>>> +     u32 coalesce_cnt;
>>>>>> +     u32 coalesce_usecs;
>>>>>
>>>>> Why not selectively set interrupts for the descriptor. The dma descriptors are in order,
>>>>> so one a descriptor is notified and complete, you can also complete the descriptors
>>>>> before that. I would suggest to use that rather than define a new interface for this
>>>>>
>>>>
>>>> The reason I used struct dma_slave_config to pass coalesce and delay information to DMA driver is that the coalesce count is configured per channel in AXI DMA channel control register[1].
>>>> AXI DMA IP doesn't have provision to set interrupt per descriptor[2].
>>>> I can explore other ways to pass this information via struct dma_async_tx_descriptor or metadata, or any other way.
>>>> Please let me know your thoughts.
>>>
>>> dma_async_tx_descriptor has dma_ctrl_flags and one of them is
>>> DMA_PREP_INTERRUPT which you can set for a descriptor and control when
>>> you get the interrupt
>>>
>>> I am not a fan of adding custom interfaces.
>>>
>>> --
>>> ~Vinod
>>
>> Apologies for reviving this old thread. I got pulled onto other work and am
>> now picking this back up.
>> Reposting the context below so we can converge on the interface direction.
>>
>> As mentioned earlier, interrupt coalescing on AXI DMA/MCDMA is a per-channel
>> configuration (IRQThreshold + IRQDelay), not a per-descriptor attribute.
>> Because of this, DMA_PREP_INTERRUPT does not map cleanly to the underlying
>> hardware model:
>>
>> - The coalescing delay is a per-channel timeout expressed in microseconds,
>> whereas a boolean flag cannot represent a time-based value.
>> - Linux Dynamic Interrupt Moderation (DIM) adjusts both the coalescing
>> threshold and delay at runtime, requiring an atomic per-channel update.
>> Flags on already queued descriptors cannot provide this capability.
>>
>> DIM is important for modern Ethernet drivers because it balances throughput,
>> latency, and CPU overhead at high speeds.
>>
>> If adding a new interface to configure interrupt moderation parameters for
>> networking clients using DMAEngine is not preferred, would either of the
>> following approaches be acceptable?
>>
>> - Passing the coalescing parameters through per-descriptor metadata, or
>> - Using the existing Xilinx-specific struct xilinx_vdma_config from
>> include/linux/dma/xilinx_dma.h, which already provides coalesce and delay
>> fields.
>>
>> I initially avoided the latter in favor of a standard dmaengine interface
>> that could be used by other networking clients utilizing DMAEngine. However,
>> I'm open to either approach if it aligns better with the subsystem's
>> direction.
> 
> Given the above description, I somehow didnt feel that you can use
> existing flags. It is setting the flag per descriptor applies for that
> channel imo...
> 

You're right that the effect ends up being per-channel. The trouble is 
two-fold:

1. Coalescing here is two values, not one: a count (DMACR[23:16]) *and* 
a separate delay timer (DMACR[31:24]). A flag carries neither, so the 
DMA driver would have to infer the count by walking the queued 
descriptors and measuring the spacing between flagged ones before 
programming DMACR. That only holds while the flag pattern stays regular.

2. DIM re-tunes both the count and the delay at runtime, from a 
workqueue, on descriptors that are already queued. A flag can't be 
updated after submit, so DIM can't take effect until the queued ring 
drains -- whereas it needs an atomic per-channel update decoupled from 
submission. The practical cost is a stale window of up to a full ring 
depth: the channel keeps moderating at the old rate -- too many IRQs 
when DIM is trying to back off under load, or too much latency when it's 
trying to react quickly -- which defeats DIM's sub-millisecond feedback 
loop.

Happy to walk through a concrete RX/DIM timeline if useful, but that's 
the crux: the flag can express a static count, not the delay, and can't 
be re-tuned for already queued descriptors.

Regards,
Suraj

