Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86273A3E8B;
	Wed, 29 Jul 2026 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306514; cv=fail; b=qd0rkREi4XuqbdJtLyZngmbExn/0qZTmSb+zqgUDAO5JFP9+md8Ua64279YGdkO+ARL7vxsLkz6DXATEgjo2bVm6kMOQ7P847OhHvV58zNcib6fxR7+gyrtn7ceJhZuc4kGQfGBPhs6DvFQVzR2j63PEPksK623CLljUWx/r59w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306514; c=relaxed/simple;
	bh=KP6KAMXvT62fdm6vEOckj0F1jlGOtwGea5FMTrSIPak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uBZTWoFIhTVijEQUE/8WQ4jCp9SKBHD/+Uf04gpB3n2F8TQ7Qya5W+L6mqrgcWWSTaVfHANCitwSxUq8v1zNbjc270tZByOwy9ACJOOjhTqfRt3p/mCHfzbApmW/u0z3tYUBdlmgZDcEz+bsslO7KaVmcRnVCmhJWt8C9lBDAxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pjjmkt3c; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pjjmkt3c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYg+DP8I8rumKvuHkoZtBRg89hssqAZWA+3BYYNbAgTQ+8AIL9dwrki0/bqOHccFrR3xA9aYC7XM046dDkwu9oG7vA6bUMTdG59RBb8iFHAEcaZJkKIjcljE1Y6QauBtp1VqSMeKeaRJYsUwAbwO7clQJnzz6rDjaSrtVfxtoEI8IURUPaY7gkEPcM784+KiM37bI4M1oDe3IJHLJRhRe2gE47HxYnj/ogQj7fo9lt2jtp0Hs/DBWEtYK7ezvALr9lhBO1uZEjER2Os4gfMdL8PosG1CqtbHhst1SJF0xkWHHEB3XFentlQ018Ty3sJmPRTU4NJdC1jJO5ArxoJnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKHtUYfsERNefLZcwqJVDK/ViitxDqppw+/BYICuLjk=;
 b=T1GBjf2ARDZi4BfetmWIIQJ4ZYyNcXpte/MPFAnClFpeaF8bZKoGL1nyQpWjHcsO+tUFFzk5fMbGJynXmbveQCClceFNts5u2mn+zGG3fFJfmPa5xEMVcs2wk2+dlomXJ1OOdvo3Xza9wtJl413Y7yRkNjDSF2SGsqCSIXAJ5ZtfxjJbfI5pDvu/WiMR8uK6OJLcB9qK4IxU8NRBQZv69Dr1TWsWt1jJJdQYnM/21yO+lAEhcBj6cbL/NV1hTYY+l1qdhrxDGsIOnV558xRUR5qKrICmb88+wMhhog6kItRIjD/gyfd8QVIeGadxtmBqUo8p6eGTKCXpDir8qDMjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKHtUYfsERNefLZcwqJVDK/ViitxDqppw+/BYICuLjk=;
 b=Pjjmkt3cdOk8hJ0v8DVvudu/TE9cPbh8Qz0cGS7SEvUtqhjd3RKPZxwZLdJAanRfmU3pz1roG95ogutbkZbWcB/fWEVdayj6dtHbshWTeXYgoklwA7//ZJjF2CxTouUtglyiIWECrKa57ECAGHTgfGIVon6i1wBMdj7vH270LLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:28:25 +0000
Received: from DS4PR12MB9795.namprd12.prod.outlook.com
 ([fe80::faca:89b7:3641:91e3]) by DS4PR12MB9795.namprd12.prod.outlook.com
 ([fe80::faca:89b7:3641:91e3%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:28:24 +0000
Message-ID: <cbb289a8-c0e5-4c1d-b102-006e857284d4@amd.com>
Date: Wed, 29 Jul 2026 11:58:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net: axienet: Clear stale AXI DMA TX/RX
 status before re-enabling interrupts
To: Jakub Kicinski <kuba@kernel.org>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, michal.simek@amd.com, git@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260716124841.2761722-1-kusuma.vasana@amd.com>
 <20260724231934.1679801-1-kuba@kernel.org>
Content-Language: en-US
From: "Vasana, Kusuma" <Kusuma.Vasana@amd.com>
In-Reply-To: <20260724231934.1679801-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To DS4PR12MB9795.namprd12.prod.outlook.com
 (2603:10b6:8:29e::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9795:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 5255e7f9-f963-4647-e90a-08deed3a97b7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	pwsBABhFfD1yCBmbARSvPz3zTF26A9vqHFXfUHes+sLB1GqU4/87CXDvaNUoRWb0INTyRm8W7MGQpWDLG+pMP+y+JHLwbjJdADJMPNRZ/wQ6pLD7SFlAv2os1HdrDqnnDVPlMyZuomADzSU8MoGUcJKuxt1ZjaPQQldXtPw7e4EfsDTgwOJA2RmbfYNlLbF/bGLaa0ixaRLGoGniKXB5twbrkTSjcJjqaMChW047JL7f5VeDDnVXOeBHmVPsDS8PRnAqnSRC1ABYUoaazAYqoJVcdPsMlmHd0MKAmHcRKtH8JuZB+F0UXIxx08OmQ0c0NtkQtxBEvwbRbI6EUF+LS45K2qtyjQY+jqyu+ZfW3HuyEi7cq5YRpE6S5+kiCXRo7hvpxaK2mRv8KtyHn6N4i/iYotiqiZk3vwNyt6H+rB7DkMJVkKkzWaMSrWGwGYMVBRx29cztdeRNtmTa/f8gAWj79PpNnhWHEkAI55kAsvOe17DBNzIzY5ET1BzD0mhHoMD3Ln/tpWhziCWvGIm4+9aIiqvTM1K1A1wrZ5Sylx+nTMcGcPEotlZ4PpPAmsQC++kFfj/GFOMB9bJGx34ViKUO4Rf/ooWKfFfMbtSS5Mu2RTSCj6B0BdjBhdmHPydZ/ce/auNFAWhHp1LIFNj1o7qYkGWoLGo86UKP/uhq49Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9795.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejdHVHFvbjNrdDlTVDdwM2ZERzBOVnhSMHdPaVJJdzhFMUwrdmkxOXMzMDBi?=
 =?utf-8?B?d29EQ1UzNDlOajhCbWVtZGROVDJaa2tCcmFDL3NRb09rZXh3dVRMWUY4NHA2?=
 =?utf-8?B?UmNFSytyWkM5MHpmZ20yS3J3US84NW1BZS9xOWFiSk5ZZ2IxbXhDOFZHeXNo?=
 =?utf-8?B?OWh0dG1oV3ZCSlBXM2t4Q0xXbFJPVTdWank2VmxxWDdjS3ZrM3hPU1RtTU43?=
 =?utf-8?B?aG1BRFVYUSs1QlpsU0VjRzAxdGNqVmtkSGdicFJYNlNJbVNocllFRC8wbjRs?=
 =?utf-8?B?NVQ5c2JWcUY3WDRSN3kwbzJ3cWgrbXdwK2hHN1FMVmhaamVsc2RreWMrTXVt?=
 =?utf-8?B?YW5CTHhBNjZvblFwQjExcmlRSkZ5RVRiN01wdXBHalV0Z3drTDBUR0xkbHNJ?=
 =?utf-8?B?Ykhja3I2STU0NEV1eCtBOHlPUXVPT0JZakwwMUxLMm82QzM3TzFFUFllVGlB?=
 =?utf-8?B?Zkw2ekI4cmNWbHFCZGxEODgyV0JiS1I2Y2pIY0cvRUhsMXdqellFOEdwU2FK?=
 =?utf-8?B?TUx0dUQvMUZPVzZWdjNwNWdCcGJOWkRsbTZBQjYwVTREeUY4blVqTUNiZVY4?=
 =?utf-8?B?eWFudlhrMWJUNTNlak5lK21sdFphZDhzUDE4UnlWMGdPSmJka2JqTVVxZTZl?=
 =?utf-8?B?REkvbUJ1YWYvZ3ZWK0RHeE1CQXlxUWxFVVd0SUFlU3p3aDdOZjh5TmFhcVRN?=
 =?utf-8?B?OXJWTldzN25mcTk0OXhEY3BZaFZFY0VCdFVGSU5hYTYzbk5tQmdOU2pRYzMz?=
 =?utf-8?B?S0VzeFNhY0l0dXRnZXRIZk1WSmh6Z1JZVnp5RzMzcWdZRFQ2VzJGQmlJcmpy?=
 =?utf-8?B?M0lHOW1SMjJDNnFzejVrWHZjVFVTWklJRlc4bVVBU3dtcnQwY1hGZ3N4U0ZH?=
 =?utf-8?B?cnN6OUNUWGdMTEk5VlNxK3NCR05wU3YvRmxUYlJ4bStabGpnUU80V015V2Jr?=
 =?utf-8?B?TFpIY1BQMDNMeFdLQUJJZExydDIxQStkY3VkVmxoaUprbGNBbWRxQ016bm0x?=
 =?utf-8?B?dWpOWG9XbXZQUFYxRHlkN1dqdmg5TmxnQ2k0eTFiRkoyME15Y1JwRlNCcytv?=
 =?utf-8?B?RFA3YjJ3dGc2SzgzaVllVlNPRG9VSkYvVFNJTU1McXJuZ3Q3b2dDdG1DNU5l?=
 =?utf-8?B?UG9CeUR0THpETXQxSFJ0dkFRWHZvV0hNaUd2SytwTmdKbm85NXVBd3UzVHJQ?=
 =?utf-8?B?cFhvczJ6SVNHYUNhN0RDU1luYjBzNkQ2a2dzaDZMRjlDblFreWxzcy8vU0VQ?=
 =?utf-8?B?ckF6ZkVwK3lLaFJpTE9tMVNzNkVwVGl0SmYvMFBiZzJMdW9hWGZxTjJlTG1E?=
 =?utf-8?B?L1E4Sm1ldExFRDJJMmJOUCtXbVJuSXBEajRZNGV2UnZPYlR0anU3bGlIZGRC?=
 =?utf-8?B?b1ZJSkNYVTF6L2tCSGd0eUVYSW0xZ21BeGNpb2JzQ212NmpjNk55ZE5zSUly?=
 =?utf-8?B?a0dsWTAxZ2N0WkpuYWpObGdqUVhwb3dRKzRXa0JjYWhjNWlEWmE0TnM5bWdG?=
 =?utf-8?B?c3RVcUdlWHRaZUtZNWo0cy9Zc2pnd00wRWNYNVJKS1ArWkpReHdYdHZPNDN0?=
 =?utf-8?B?NHNqWk5NVi9Yci96WmZTZGU1QVZoTkp5bDJOT1I0aUFFMzVYYThyYU1udEJI?=
 =?utf-8?B?Q0IwWTVDUTJncXdlRDRnQityZW1JakQwQjMrVGxlK1BxbDhubUorSzNITlA0?=
 =?utf-8?B?NTA1ek4rRURMNFlNelErU1RWd0hxOUVoemFraVk1TE4xWmdUMzlDNEhaSWQx?=
 =?utf-8?B?R3BmL1V5NDF3UEJENXM4bHpSMmFnZGlESzduelBQNStQTnkwTXJURmlVWUx0?=
 =?utf-8?B?RUhnWGhaWW1UUmtxd3k3MVZDQU1ibG9tcWxhWTBIL2JnOUhPMmpDOWJpekFB?=
 =?utf-8?B?V05pM3FwSUhERmVzZVRBazVHenlMbkh4MzVSdDZqOHhBRGhPcmdETHF6RjI3?=
 =?utf-8?B?SXRmQnRSbXBSOHZuSFVzVm1IdG04bXFCU0tXSEpOWU9aNE1IcVhBZm1JcXFW?=
 =?utf-8?B?NFhIZFVtOHlKMnlxMzFVSnlneHZsVStNT3EybzR6Q2RxN0doYm5adEpNKzY4?=
 =?utf-8?B?eEhZKzlCWnh4SzlsL0pMZXhNdnF0aWUrOUFzVGJKTWlWSnNpaFF3TFR3a25w?=
 =?utf-8?B?NkFLa3ZiL0dYQ010cXlxWllQakJYdTZmQURtcDZvU2JKSFBGV080ZzZsamNC?=
 =?utf-8?B?WGRlbDk3bTBFK0Z1QzVPNXRncEttcVE3ZE5kSlplcVdYMjVLQm1uNWY4dzA1?=
 =?utf-8?B?MnkxNHd4VTBtSStYeVpyK083dm5MenNiZjV4ZncxZWd2aWdKNlgxZE05VTll?=
 =?utf-8?Q?de8gUuoEv+CMeVFCmq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255e7f9-f963-4647-e90a-08deed3a97b7
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9795.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:28:24.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfYvT94LIcIDVaHApgGyuTSnJINZD+Ci4gpTKQEUp/KL8txKlfTEQ77aD6g/1F0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940



On 7/25/2026 4:49 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts
> 
> This patch clears the AXI DMA IOC/DELAY status bits at the end of the TX
> and RX NAPI poll handlers to avoid a redundant stale interrupt caused by
> IOC/DELAY bits latched into the status register while interrupts were
> masked in the control register during NAPI. The clear is performed
> unconditionally, before the napi_complete_done() / CR re-enable step.
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index fcf517069d16..29050c8d04e2 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -1018,6 +1018,13 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>>   			netif_wake_queue(ndev);
>>   	}
>>   
>> +	/* Clear stale IOC/DELAY bits that may have latched during the
>> +	 * poll window to prevent a stale interrupt when there is no
>> +	 * work pending.
>> +	 */
>> +	axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
>> +			  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
>> +
>>   	if (packets < budget && napi_complete_done(napi, packets)) {
>>   		/* Re-enable TX completion interrupts. This should
>>   		 * cause an immediate interrupt if any TX packets are
> 
> [High]
> Can this sequence race with a late completion arriving after the poll
> loop has exited but before the SR write?
> 
> The AXI DMA engine writes cur_p->status and latches SR.IOC asynchronously
> from CPU execution. The poll loop's exit condition reads cur_p->status,
> and between that read and the unconditional SR IOC/DELAY clear that this
> hunk adds, the hardware can set COMPLETE_MASK on the next BD and latch
> SR.IOC for it. That legitimate notification would then be wiped by the
> new W1C write.
> 
> Since napi_schedule() is only called from the ISR, and the ISR only fires
> when the IRQ line asserts, napi_complete_done() will succeed here even
> though a new completion has appeared. The subsequent CR re-enable would
> then observe SR.IOC=0, so the level-sensitive line does not re-assert,
> and the completed BD is stranded until the next unrelated completion or
> DELAY-timer expiry moves things forward.
> 
> Before this patch, any SR bit latched during the poll window (whether
> stale or from a late completion) re-asserted the IRQ line after CR
> re-enable, which the changelog frames purely as an unnecessary stale
> interrupt:
> 
>      After NAPI completion, re-enabling interrupts immediately
>      re-asserts the IRQ line due to these stale status register bits,
>      even when no new work is pending.
> 
> Did that same behavior also serve as the recovery path for a completion
> that lands in the SR-clear/CR-reenable window? If so, would it be worth
> either re-checking cur_p->status after the SR clear and skipping
> napi_complete_done() when new work has appeared, or performing the CR
> re-enable before the SR clear so a late latch still asserts the line?
> 
> NAPIF_STATE_MISSED does not appear to help here because it requires a
> napi_schedule() call, which only the ISR performs.
> 
> For configurations where axienet_calc_cr() does arm the DELAY timer
> (coalesce count > 1), the stranded BD is recovered when DELAY expires:
> 
>      /* Only set interrupt delay timer if not generating an interrupt on
>       * every packet
>       */
> 
> Under DIM with low traffic the coalesce count can settle at 1, in which
> case DELAY is not armed and there is no bounded recovery for the last
> BD of a burst until another packet arrives. Is that concern valid, or is
> there another mechanism that ensures the last BD is drained?
> 
>> @@ -1293,6 +1300,13 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
>>   		cur_p = &lp->rx_bd_v[lp->rx_bd_ci];
>>   	}
>>   
>> +	/* Clear stale IOC/DELAY bits that may have latched during the
>> +	 * poll window to prevent a stale interrupt when there is no
>> +	 * work pending.
>> +	 */
>> +	axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
>> +			  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
>> +
> 
> The same question applies to the RX path: a completion arriving after
> the while loop's cur_p->status check but before this SR write would have
> its SR.IOC latch cleared, and the subsequent CR re-enable would then not
> re-assert the line. Is there a reason the RX path is not exposed to the
> same race?


Thanks for the review. I agree and will add a BD status recheck after 
clearing the SR to handle any completions that arrive during the race 
window. I will address this in V3.

Thanks,
Kusuma
