Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743EE4457C5;
	Fri, 14 Aug 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714015; cv=fail; b=TsIE8A7FEjdcLwHQHVp46RVb9PIUq12bzCnQz7USdWchak0sHm6i1fv6Y+QTwxAPU+vyZkyYBYUS1VXWzWPQT3qGJrehcAAXuewPITxQYrcV4KrLEmmUN0JH7kjcm4fzqwTsoDsyJ3czYXsXGLZTcxNKvZZ33gH5NQ0H2TawAp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714015; c=relaxed/simple;
	bh=jxtbZ5k1OGw4RqgOC5GBIj5tudrLXbPUbw+c0RMt0Is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ReRtWkbg9Zpf7MPdv+wYJf4w4uRS35e0xipgwNB1bCVcZGXD80w75oO7PcXaqjiEmhs5pkb6BGO48dlF6xvqdYIJg8RWh2vz5/Nj0vYfVcoY3jfQAPCiB/ZPS16B2s29EvwAyp6S/w+EL5/VsyFXdwv/XPFx31kooZbfzzzZPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uc/gKVpR; arc=fail smtp.client-ip=40.93.194.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uc/gKVpR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4i74WXLSP1FHGoyjRvXssSd/DFtOk833bj7J8mpOKiGz9mPM/ryISfuWlOIoWpBxxRcNNOykVuUMT3sz1Z17bguVjqx+oR8PQjfeVdA6XJnE7o8pgbtd/8x2GhKBK2FeCp8SqE8mUIUTE9qzjy9Uno4Tcarf10D4o5t7ESVEnQjIxrf60jTJVdiOHoObvTSlAFr+OVRKBmi04w3oSFNHWzhKMaxb+I8ePZIR2AxRkPuZiGCssdiyVeAA9SZKNFP+Lp3uzdaEBXPK63Vm79kEWFxtau7JJZ+nJisMEn8YBlUu47hAwyAyVmBtXPjGG3wvU6hWX2qEewlTIScPP5nGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPnGCl0OzW6Htonz2gGacTwkANHbSOIOGNaMtFXQbnM=;
 b=U9u3m6DiXzYy/S0CRoO/krWtUY4n9In+BnhK4H5wfraBRs7cQS9cpu03nsQVrebR/FhG+FO1bfOCMQ++Me3cp2zNha3eZpzfrOK1w8ivM2J4n2mCrnhaMt6B7M2E0rc0eMlBGFFT+Vv8q/2HM8QPSJhuCPICxgnJahOZM9nY1t58k+RA3Dv9pqdLrsncazxlgEELM7EQUxNZQcxa9pUuxgU0AFt1E1VHSiS5pnx2+QvUtzmcsh/wvKD4td1EuEG6Y9IuoFj4GjUGyxsdXFEVAvVqfDCieQC+Z11uY9hUU4z8ktBrlHPkHovs2TjVMSXox51T0YBJA/znpqHboARMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPnGCl0OzW6Htonz2gGacTwkANHbSOIOGNaMtFXQbnM=;
 b=uc/gKVpRnzo0trowFzgdN+FWVHo8/XynaRDSaJ0UoyxAD+1NT1I8lMU/HtEDbJqBjx+xD98AdO9KTGpwb9vuAnNCCXZzSs7kpsWQErohgI720ggLcU9EO0mXtDWP7hnWYkRuBaSMDink+vZImNb9oY6IImj8Tk7Ix47Sy32JYbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 13:26:41 +0000
Received: from PH7PR12MB8156.namprd12.prod.outlook.com
 ([fe80::770:345e:ed50:cb0d]) by PH7PR12MB8156.namprd12.prod.outlook.com
 ([fe80::770:345e:ed50:cb0d%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:26:40 +0000
Message-ID: <15cafe8d-e272-4980-91fe-4678f202f0c1@amd.com>
Date: Fri, 14 Aug 2026 18:56:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] net: xilinx: tsn: add the endpoint RX data path
To: Jakub Kicinski <kuba@kernel.org>, nagadheeraj.rottela@amd.com
Cc: srinivas.neeli@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git-dev@amd.com
References: <20260807104431.157230-7-nagadheeraj.rottela@amd.com>
 <20260808194822.132771-1-kuba@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260808194822.132771-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0202.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::8) To PH7PR12MB8156.namprd12.prod.outlook.com
 (2603:10b6:510:2b5::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8156:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 340b3f23-4fe4-432c-a7ac-08defa07aca4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|5023799004|4143699003|56012099006|10067099003|6133799003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hbDv5jZvJ0r31zLVkvrSfM+hqct1IfjxsOT6dqqwWjhvhUl+irjvarrxKUtf1bt/4j6y86pXTZqiZ8e01RtHay4VMgHd0gmDim/asbr8bRy92mr0tcVoc49n9Q07gC2pNrXtnj/3vNEiK1rEEz22RkivnjwnhDZT+CGFJdHYtKWHh4SKEnjPkPdHsc7gGU5CfUYuiUWrdqovNkXdsipPP1gTjZyfAilAa/JD6n59BrSu96GBkX1IzizwnhKQNVuJAggIRe/AGudHxQ3+LvmCu2P/4o92ES83lpQsmdyptk4YiRFUlAenN/ozW0UHDmgPeA26S8zOeJXOjGkindSgeigsCafXk8mcX2ItY1hxLYUxBCaGG2Lnv2h3O+MpyCiwUwQiX/FXB8R+QFR/zPfGZ0uweIaQ9gK3plSzcd4tnKl6krAmdCZqXPR4t9mJxWSVufF+dqVbc3n+hws1uFU9mEQ0neWQgd8Up3hVAgRqq7rEN7HJMRXLYVLyYtw3+33jhrUvYBzDoxacsoCrvlGHxBKenoM+NNlCbLvuPPcJdJHA5BDKClIAE9ynGc9zEkInPmZb5K3b8jepJL1W0j/oKIf09azUbVZXCWSsvmA49wAZfmMSE0XzAQ9JmgAehvJIWJn/794tTkuYiWnzCgMMklcMDqAKnChIclo693NrnJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8156.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(5023799004)(4143699003)(56012099006)(10067099003)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFBiUDVab3l5UXEwK0ZBYWcrbkEvd3I3MXdMc0JXOUFVdndTVENmTmFla3da?=
 =?utf-8?B?Q24zQjNUQkxINE9mdFVFQkhwTlA2Z2pxc0tMaXNjelJJQ2JZczJaOVZZckdp?=
 =?utf-8?B?Z21DTUN6cUtJTDd6YVRPb0srYWFaTVBTOExEWUtvQW1WRHhpZFFzN1EyUm9i?=
 =?utf-8?B?NFJFWk5lS2FMRmRjRSsyZjJ2TFk2T1A5RVdzVnZ1ZGpKMWtXR2t2ei9mRWZR?=
 =?utf-8?B?UmNmZzdJWEpCN3QwdFRTcEVleFhTOFB4TjU2MlBNMDJwbWdXQ0g0WEV3djcx?=
 =?utf-8?B?WXFra2pyNyt2WkZ2Qm9JRyt4R2x5NElDeVlGQ1pPZTBFZTE5MWVOZG9Tek45?=
 =?utf-8?B?c09tRWdrWk5EVUU4ZmhtTmR5YWRpRk1wby9td1RWRGt2UFNlTS9kRTlsd3cv?=
 =?utf-8?B?RmFUODlKSTBaSzZBN3pBQWdPdmtXeUpubWZadHM5ZFNaTDhkUm9WQWpoNVpp?=
 =?utf-8?B?MXJ3MmFuWkFpdExVRUdmNkdhZ2k1OTdXSmU1c0dSbXNvNUZjTGh5WnI2SU1P?=
 =?utf-8?B?Mzg3TUx0UXN4Mi9aMTZQZ0RjK1cwYkU3d2pCenovbVlwZmg4ampvN1R6d2l2?=
 =?utf-8?B?aGY0WVlYcXdqNWVuZW9lUkMxMm1KR2tOZ2RsdEZGNkVSRnJSOCtVR1FZbUt3?=
 =?utf-8?B?dTJ5dnRnMlJEaDhUWHpSVXZuTTc5UTM5V0ZrOU0zb2E5NC8rWmJOMXY4UVpl?=
 =?utf-8?B?Ym9lQXU1aGorMVZFaFRTR3pmQ0J2Tm9QcTlGdjNPYU5adm1MMFpFbWRjdjIr?=
 =?utf-8?B?U1VjSnpCa3JVR29ndVdWc2NEbVFONDU1VGNteERjZzNRaFBGemJpdzFXZkhx?=
 =?utf-8?B?enlnWExrY1kzUUplN0pQYmpSRGJ3TVFBZVVpeFo1VldhRWJMZ0RZQzVNdHlR?=
 =?utf-8?B?cU5HK3M0OWFCVHo3Y2R3MTdWUEd3RmdaS1dXMmZBbjRKZW5ZVzNIOStlWC8x?=
 =?utf-8?B?ZklmdDZhQVluZmI4eFUyQ0tNdGszK1RYaFl6SHVqZUtYRERaTXRTeUdmbEti?=
 =?utf-8?B?T2FsU1FCTFZYY3BsVy9ZUnhDaDZRTmhZeVBLWTJ3aHdPdVBkem1VWlhTdURX?=
 =?utf-8?B?LzI4Vlo3R3o3R1hPV0p4clUyTmkvZ0VDRGRRV2ZIWDE2U1ltTmt4VXVUcERk?=
 =?utf-8?B?a3JYWnZDeDFqVlJnRWFUNlFiQkFoV2ZEZkpOcXRSZzVZdTVUQ2hTU2NqZ0lQ?=
 =?utf-8?B?MTI1TkhhVk1sODA0Vkx0NXk2UnJseE12cU9lSmFXZk1Mc2F6TE1mazR2Wjh2?=
 =?utf-8?B?WjhQZkZmK1NtNllaNFdmdEtzcGFSQkc0WlZrWER2djN5dkxlTVVjbTFvendq?=
 =?utf-8?B?VXJ5SGhCU3MvK2g1MjdRV3RrZ2NRYTFEVE0xYXc4QVpnMmdJWmVpRVF4cTcz?=
 =?utf-8?B?TlBTaWM4V3JVQ2NmSjlrZlhjcHR5RlZTb0NQamVLYkNuVmlqeEp5WEdtVksz?=
 =?utf-8?B?dlV1aVFlRlFkZU11QkJyeTRvV2ZaSzNLbGpoa25FZ3dSQ3I1cnJuU25UalNo?=
 =?utf-8?B?TFNWUHM5clU3Q243T2kydGQzcVhIMG82R0wzdzR1T1d4UTFialNWY1kzNmVx?=
 =?utf-8?B?RDYzTGRoWFhaQnh1a3N0K3ZDbll4S3NvaldSWTNVd09mT1BMYnJ5R3BzMElK?=
 =?utf-8?B?azczVzBIYkNzWEJSaGtkYTFqVWRZbEl2QllnSTBXOXdUWGdTWkVjY0h5R3BS?=
 =?utf-8?B?NlN1SDRsdEt2RXNJUDNGZGFIajJWRTJsQWpNbFdya1hFeUxVaEl6NkttUDBK?=
 =?utf-8?B?QVlLUjJieUJpRW44bHFWV3FBOTFDRkRjOGZsWHlUK1laWVc1YllQdm5KV2J4?=
 =?utf-8?B?b2VaS2NaVytjdit1Zzh5VG04VVdSOGZFN2E4NWl3YWlwbkN4WUxoT1VUQndO?=
 =?utf-8?B?bkM2VEUzS2h2bHJSU1k4R0dxYnFVeDAvTTJQUDNFbEVYcW9QMDVQSjdPU1BB?=
 =?utf-8?B?cFlOT0hIMmFsMFZ0aUJBQlFQNkJSOG9ET3FBZFlENHpWMkhYOEE4V29uOTlH?=
 =?utf-8?B?RXdGZVJQVVQ3Z3pMNDhWLzhBb0dUOHNNRGJsVGRpZHZTZy9EMUlJTzdFMXFx?=
 =?utf-8?B?TzVrNlhGL25lcGYyK1h1ZlQyRDYyem1XLzYvelFjbDVVNTBiVkF3cVpzQytV?=
 =?utf-8?B?dHpPRnp5dy9laEoxdHluSXFUV0NZMjJDcG84R3E4UENpMjJHNnYva1BjZVNY?=
 =?utf-8?B?NVBxbjdFMUlPd2dkQ3d2NFUwYXRFcWZaVHpQTU0vUjBjTGduVTFDSmpVVnFh?=
 =?utf-8?B?QzI0aDA4QVJ6Z2VQUjE4MXpiNG5pempqcFdLNWVMRGlBSXhveCsyZEpzZkJY?=
 =?utf-8?B?bGcvMldmY1RkN28xZjRUOUM2YTRqUTd0a0JMMzhMdDV6ZnFEenRmZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340b3f23-4fe4-432c-a7ac-08defa07aca4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:26:40.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6HCdGLHmWINdVxFeme7rHSzyvHE7Sk57omoTmuQMH9a9mrqFGVO+R/FAw+xUCNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

Hi Jakub,

On 8/9/2026 1:18 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: xilinx: tsn: add the endpoint RX data path
>
> This adds the RX side of the TSN endpoint: RX buffers are posted to every
> RX channel at open time and reaped from the dmaengine completion callback,
> which decodes a TUSER port id out of the descriptor metadata and passes
> MAC1/MAC2 frames up the stack.  The completion callback also refills the
> slot it just consumed, and the channel teardown path grows an extra
> terminate/synchronize/terminate sequence.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> index fa21d59ade16..207ca3242a12 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> [ ... ]
>
>> @@ -42,6 +43,17 @@
>>   #define TX_BD_NUM_DEFAULT		64
>>   #define RX_BD_NUM_DEFAULT		128
>>   
>> +/*
>> + * The DMA descriptor sideband status word packs TID/TDEST/TUSER together;
>> + * TUSER occupies the low byte, TID/TDEST sit in the upper bits.
>> + */
>> +#define TSN_TUSER_MASK			GENMASK(7, 0)
>> +/* TUSER Input Port ID field (bits [5:4] of the TUSER field) */
>> +#define TSN_TUSER_PORT_ID_MASK		GENMASK(5, 4)
>> +#define TSN_TUSER_PORT_EP		0x0
>> +#define TSN_TUSER_PORT_MAC1		0x1
>> +#define TSN_TUSER_PORT_MAC2		0x2
>> +
>>   /**
>>    * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
>>    * @sgl: scatter-gather list backing the DMA mapping
>> @@ -115,6 +127,147 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
>>   	return xchan->skb_ring[idx];
>>   }
>>   
>> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result);
>> +
>> +static void ep_rx_submit_desc(struct xlnx_tsn_ep_dma_chan *xchan)
>> +{
>> +	struct dma_async_tx_descriptor *dma_rx_desc;
>> +	struct skbuf_dma_descriptor *skbuf_dma;
>> +	struct xlnx_tsn_ep *ep = xchan->ep;
>> +	struct sk_buff *skb;
>> +	dma_addr_t addr;
>> +
>> +	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (RX_BD_NUM_DEFAULT - 1));
> [Severity: Low]
> This isn't a bug today, but should this use xchan->ring_size instead of
> RX_BD_NUM_DEFAULT?
>
> struct xlnx_tsn_ep_dma_chan.ring_size is documented as the number of slots
> in skb_ring, is set from the caller-supplied size in ep_alloc_dma_chan(),
> and ep_free_dma_chan() masks with it:
>
>      skbuf_dma = chan->skb_ring[chan->ring_tail & (chan->ring_size - 1)];
>
> The new RX code hardcodes RX_BD_NUM_DEFAULT for the ring mask here, for the
> mask and CIRC_SPACE() in ep_dma_rx_cb(), and for the prefill count in
> ep_init_dmaengine().  The two sides of the same ring now disagree about
> where the size comes from, so a per-channel or ethtool-configurable RX ring
> size would index out of range on one of them.
>
>> +	if (!skbuf_dma)
>> +		return;
>> +
>> +	skb = dev_alloc_skb(ep->max_frm_size);
>> +	if (!skb)
>> +		return;
>> +
>> +	sg_init_table(skbuf_dma->sgl, 1);
>> +	addr = dma_map_single(xchan->dma_dev, skb->data, ep->max_frm_size,
>> +			      DMA_FROM_DEVICE);
>> +	if (unlikely(dma_mapping_error(xchan->dma_dev, addr))) {
>> +		if (net_ratelimit())
>> +			dev_warn(ep->dev, "DMA mapping error on RX submit\n");
>> +
>> +		goto err_free_skb;
>> +	}
>> +	sg_dma_address(skbuf_dma->sgl) = addr;
>> +	sg_dma_len(skbuf_dma->sgl) = ep->max_frm_size;
>> +	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
>> +					      1, DMA_DEV_TO_MEM,
>> +					      DMA_PREP_INTERRUPT);
>> +	if (!dma_rx_desc)
>> +		goto err_unmap_skb;
>> +
>> +	skbuf_dma->skb = skb;
>> +	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
>> +	skbuf_dma->desc = dma_rx_desc;
>> +	dma_rx_desc->callback_param = xchan;
>> +	dma_rx_desc->callback_result = ep_dma_rx_cb;
>> +	xchan->ring_head++;
>> +	dmaengine_submit(dma_rx_desc);
>> +
>> +	return;
>> +
>> +err_unmap_skb:
>> +	dma_unmap_single(xchan->dma_dev, addr, ep->max_frm_size, DMA_FROM_DEVICE);
>> +err_free_skb:
>> +	dev_kfree_skb(skb);
>> +}
>> +
>> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>> +{
> [ ... ]
>
>> +	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
>> +						   &meta_len,
>> +						   &meta_max_len);
>> +	if (IS_ERR_OR_NULL(metadata)) {
>> +		if (net_ratelimit())
>> +			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
>> +
>> +		dev_kfree_skb_any(skb);
>> +		DEV_STATS_INC(ndev, rx_dropped);
>> +		DEV_STATS_INC(ndev, rx_errors);
>> +		goto submit_new;
>> +	}
> [Severity: High]
> Does this path drop every received frame on the configuration described by
> the binding?
>
> The binding added by this series wires the endpoint to an AXI MCDMA:
>
>      dmas = <&axi_mcdma_0 0>, ... <&axi_mcdma_0 23>;
>
> In drivers/dma/xilinx/xilinx_dma.c, the "xlnx,axistream-connected"
> property is only evaluated for XDMA_TYPE_AXIDMA, desc_metadata_modes is
> only set to DESC_METADATA_ENGINE under that flag, and async_tx.metadata_ops
> is only attached in the AXIDMA prep paths.  xilinx_mcdma_prep_slave_sg(),
> which is installed as device_prep_slave_sg for XDMA_TYPE_AXIMCDMA, never
> sets metadata_ops.
>
> So for an MCDMA instance:
>
>    ep_dma_rx_cb()
>      dmaengine_desc_get_metadata_ptr()
>        desc_check_and_set_metadata_mode()   /* desc_metadata_modes == 0 */
>          -> -ENOTSUPP
>      IS_ERR_OR_NULL(metadata) -> dev_kfree_skb_any() + rx_dropped/rx_errors
>
> Every frame would be freed and counted as an RX error, with only a
> net_ratelimit() warning to explain it.  Should ep_init_dmaengine() check
> dmaengine_is_metadata_mode_supported() while arming the RX channels and
> fail the open, rather than letting ndo_open succeed with a dead RX path?
>
>> +
>> +	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
>> +	tuser = metadata[1] & TSN_TUSER_MASK;
> [Severity: Medium]
> Is this metadata layout comment correct, and is metadata[1] the sideband
> word?
>
> xilinx_dma_get_metadata_ptr() returns the app array, not the start of the
> descriptor status words:
>
> drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_get_metadata_ptr() {
>      ...
> 	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> 	seg = list_first_entry(&desc->segments,
> 			       struct xilinx_axidma_tx_segment, node);
> 	return seg->hw.app;
> }
>
> And in struct xilinx_aximcdma_desc_hw:
>
> 	u32 status;		/* @0x18 */
> 	u32 sideband_status;	/* @0x1C */
> 	u32 app[XILINX_DMA_NUM_APP_WORDS]; /* @0x20 */
>
> That makes metadata[0] == app[0] and metadata[1] == app[1]; status and
> sideband_status sit before the returned pointer and are not reachable
> through this API.  The existing consumer of the same API agrees that index
> N maps to app[N]:
>
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_rx_cb() {
>      ...
> 	rx_len = (app_metadata[LEN_APP] & 0xFFFF);   /* #define LEN_APP 4 */
> }
>
> With the base off by two words, tuser and port_id are decoded from an
> unrelated AXI4-Stream application word, so frames are either all dropped as
> "unexpected TUSER port_id" or, once the later patch adds
>
> 	skb_dst_set_noref(skb, &ep->port_md[port_id]->dst);
>
> attributed to the wrong DSA user port.  Could either the index or the
> comment be corrected so the claimed layout is verifiable?
>
>> +	rx_len = ep->max_frm_size - result->residue;
   These review not on latest dmaengine code. Recently we send few patch 
series to mainline and those are got reviewed by tag.
   once we apply those on top of latest xilinx_dma.c, these two comments 
will eliminate.
https://lore.kernel.org/all/20260713072146.45269-1-srinivas.neeli@amd.com/


I will address remaining  comments in next version.

Thanks
Srinivas Neeli

> [ ... ]
>
>> +	skb_put(skb, rx_len);
>> +	skb->dev = ndev;
>> +	skb->protocol = eth_type_trans(skb, ndev);
>> +	skb->ip_summed = CHECKSUM_NONE;
>> +	__netif_rx(skb);
>> +
>> +	DEV_STATS_INC(ndev, rx_packets);
>> +	DEV_STATS_ADD(ndev, rx_bytes, rx_len);
> [Severity: Low]
> This isn't a bug, but could the changelog say why the RX path is not NAPI
> based?  Frames are pushed with __netif_rx() straight from the dmaengine
> completion callback, so there is no poll budget and no GRO, and every frame
> goes through the per-CPU backlog where overflow is accounted to the core
> drop counters rather than the driver.  The per-packet statistics also use
> the legacy dev->stats atomics (DEV_STATS_INC/DEV_STATS_ADD) in the hot
> path.
>
>> +
>> +submit_new:
>> +	if (READ_ONCE(ep->closing))
>> +		return;
>> +
>> +	avail = CIRC_SPACE(xchan->ring_head, xchan->ring_tail,
>> +			   RX_BD_NUM_DEFAULT);
>> +	for (i = 0; i < avail; i++)
>> +		ep_rx_submit_desc(xchan);
>> +	dma_async_issue_pending(xchan->chan);
>> +}
> [Severity: Medium]
> Can RX stall permanently here if the refills fail?
>
> ep_rx_submit_desc() returns silently on dev_alloc_skb() returning NULL, on
> dma_map_single() failure and on dmaengine_prep_slave_sg() returning NULL.
> None of those advance ring_head, bump a counter, or tell the caller
> anything.
>
> ep_dma_rx_cb() has already done xchan->ring_tail++ unconditionally, so the
> number of outstanding descriptors (ring_head - ring_tail) drops by one for
> every failed refill.  The loop above then performs avail no-ops.
>
> The only callers of ep_rx_submit_desc() are ep_init_dmaengine() and this
> callback; there is no worker, timer or poll routine, as the commit message
> notes:
>
>      Refill each slot from the completion callback unless the interface is
>      closing, which keeps the ring full without a separate refill worker.
>
> So once the outstanding count reaches zero the DMA engine raises no further
> completion, this callback is never entered again, and RX is dead until the
> interface is downed and re-opened.  dev_alloc_skb() here runs in the
> dmaengine tasklet with GFP_ATOMIC, and a persistent mapping failure (IOMMU
> or swiotlb space exhaustion) makes all attempts fail deterministically.
> Would a bounded retry, a work item, or an error return from the arming path
> be preferable?  This still reads the same way at the end of the series.
>
>> +
>>   static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   {
>>   	dev_kfree_skb(skb);
>> @@ -229,8 +382,18 @@ static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
>>   	if (!chan)
>>   		return;
>>   
>> -	if (chan->chan)
>> +	if (chan->chan) {
>> +		/* Drain the in-flight completion callback, then synchronize in
>> +		 * case that callback re-armed a descriptor before it observed
>> +		 * ep->closing. xilinx_dma_tx_submit() clears chan->terminating
>> +		 * on every submit, so a single terminate does not cover a
>> +		 * re-arm. The final terminate is a barrier before the channel
>> +		 * memory is freed.
>> +		 */
>>   		dmaengine_terminate_sync(chan->chan);
>> +		dmaengine_synchronize(chan->chan);
>> +		dmaengine_terminate_sync(chan->chan);
>> +	}
> [Severity: High]
> Does this sequence actually close the window, or does it only clean up
> after the damage?
>
> Nothing serializes the re-arm in ep_dma_rx_cb() against the terminate here.
> The check-then-act on ep->closing gives no exclusion:
>
>    tasklet: xilinx_dma_chan_desc_cleanup()
> 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
> 		...
> 		spin_unlock_irqrestore(&chan->lock, flags);
> 		dmaengine_desc_get_callback_invoke(&desc->async_tx, &result);
> 		spin_lock_irqsave(&chan->lock, flags);
> 		...
> 		xilinx_dma_free_tx_descriptor(chan, desc);
> 		if (chan->terminating)
> 			break;
> 	}
>
>    callback: READ_ONCE(ep->closing) == false
>
>    ip link set down: ep_stop() -> ep_exit_dmaengine() -> ep_free_dma_chan()
> 	  dmaengine_terminate_sync() -> xilinx_dma_terminate_all()
> 		  chan->terminating = true;
> 		  xilinx_dma_free_descriptors();  /* kfree()s done_list
> 						     entries, including the
> 						     iterator's `next` */
>
>    callback: ep_rx_submit_desc() -> dmaengine_submit()
> 	  xilinx_dma_tx_submit()
> 		  chan->terminating = false;
>
>    tasklet resumes: `if (chan->terminating) break;` is now false, so the
>    loop does desc = next and dereferences freed memory.
>
> That looks like a use-after-free plus list_del() on freed memory inside the
> DMA engine.  The comment above shows the cleared terminating flag is known
> about, but the terminate/synchronize/terminate runs after the corrupting
> iteration.  Would a real quiesce (for example refusing the re-arm under the
> same lock that the teardown path takes, or fixing the flag handling in
> xilinx_dma_tx_submit()) be the right shape here?  This also still reads the
> same way at the end of the series.
>
> [Severity: Medium]
> The commit message describes only the RX data path and says nothing about
> changing teardown.  Could it mention that ep_free_dma_chan(), which is
> shared by TX and RX channels, now issues terminate/synchronize/terminate
> instead of a single dmaengine_terminate_sync(), and that the reason is an
> internal behaviour of one dmaengine provider (xilinx_dma_tx_submit()
> clearing chan->terminating)?  As written, the open-coded triple terminate
> becomes silently dead code if that provider is ever fixed, and nobody
> touching drivers/dma/xilinx/xilinx_dma.c has a pointer to the dependency.
>
>>   
>>   	if (chan->is_tx) {
>>   		while (chan->ring_tail != chan->ring_head) {
> [ ... ]
>
>> @@ -329,6 +492,12 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
>>   		rx_allocated++;
>>   	}
>>   
>> +	for (i = 0; i < ep->num_rx_queues; i++) {
>> +		for (j = 0; j < RX_BD_NUM_DEFAULT - 1; j++)
>> +			ep_rx_submit_desc(ep->rx_chans[i]);
>> +		dma_async_issue_pending(ep->rx_chans[i]->chan);
>> +	}
>> +
>>   	return 0;
> [Severity: Medium]
> Related to the refill question above: every failure inside
> ep_rx_submit_desc() is discarded here and this returns 0, so ep_open() can
> report success with an under-filled or completely empty RX ring.  Should
> this loop count successful submissions and fail the open when none (or too
> few) were armed?
>
>>   
>>   err_free_chans:

