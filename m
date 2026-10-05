Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF7309EF9;
	Mon,  5 Oct 2026 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184063; cv=fail; b=qIGjN3m1OwOjq8HtImCNLexGcx1iIPjP4clHbD4x+tRFJxqcu3ncR8paI1k6S7U8+pbyaaBQ9FRBbADi5WrNmuPHyakVq5updYV2PQI38HiTBV9DUNqF8bFwKkmEh4fhS0X9ZvJMbU32PjXH5HeF7k7xeL6z+rShlIs6et1Osq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184063; c=relaxed/simple;
	bh=TIncW5LSE99DZqk5fNibX4HRlIgDW7Y8+87CnE/olj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRnceXYolrT0hXSXkkhnZDWBS3HUD8fr+V2Zw3od/ISAgdpf8xACVIZHk9K7XW5wHHiN5hHEF7xEO0glAfkjCmvgU2EkTQdYUvtuFJqYSc8Y09Nu51UGgcUiDpm+9x5AgeleNSaMLM0RDjEsVqrlXXRAyGUruMPbDFn4qkXBIA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FzCrb9Zt; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FzCrb9Zt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMnTjmoXgmjYXcx70QmUyKBBZVadW1GAaXUdm6ryxMzyTcNZvSqqYhY8813Hzy09cpqeVlpQB6SQjy3lq/Fb1TT95O4V53IHV2BjLdNNSWq3tNrHNCXsOH9ruR766ssCEzP8fh2Tf8rtCGzlPcZCYdwU1uOInF3tSkvIZpKYJLDHMTKRHJC8RXvq7VqQOltd76ZwMSmnhx6rTZp7J+xG8WYcHnFOFVuq4txK/f1OYYQ3zikre8RY3jEK4yuUANywhhPbRRZjzgwhPcVqHG85K/pHlYdjP00Jue+NM6L6ofnfm3Ds5Cwd7vkbN1WdbVPVbCHgx3n4kZkTo5QmZrgwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxWWLchzfluesD4iG+qveEaqgs8btJtv6ycxXytuHbQ=;
 b=LR3hf8zHQTg9xoVfxAbayPSvcpO/JWz8Q7OE22NW1zlFcwR+2nMmUA9qYXb9GDTR/OJcZ1/eCHVFiVt3IXc87jvZl+tqVLUl51GacQsNHIRanh/t9nWN/7TNSV57cOaqcU6gXOUnOWxCqDCxEVYJf6O54ksf9/OCvTP1/M4U9zubY6qWEC51NUyft2sYhYGlLYPmZjJgbGQzaRhhEHNRm+2GUbjcLdfC0fgf93Vv+oQPFpkcCaOGvPbXQ5Us3a+MtTfDcrZ/i8x7FLZN6+CaJ5Hw9RKZ8DVFsHUSv9Z9LNSJA8b9O1T2RT+rsBulNYn+Rwhpk94wUwZEZSNuQf4vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxWWLchzfluesD4iG+qveEaqgs8btJtv6ycxXytuHbQ=;
 b=FzCrb9ZtZYbJ86j9wZX/XkRDJrNaSDqFtnhpai20fAWqDaNVBKwMc0UfPlt4VkUG45kODk8uNM48ufb6tXc1/ZEVjM+jlZQ33Jkc1j19g89sJ6XrMMA66ea0rj5rnexuqncWiHb+FrSYHacZv1P6TnO2iLUGDCzF6pP9T2h62tQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 07:07:35 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0451.026; Mon, 5 Oct 2026
 07:07:35 +0000
Message-ID: <d54e4b96-fbd3-4717-abbb-c1fb2ea21d60@amd.com>
Date: Mon, 5 Oct 2026 12:37:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: xilinx: axienet: Derive RX frame length
 from residue in dmaengine path
To: netdev-bot+sashiko@kernel.org, srinivas.neeli@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com
References: <20260929081316.803997-1-srinivas.neeli@amd.com>
 <179101666253.434549.6997219153038627116@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <179101666253.434549.6997219153038627116@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::10) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: ff91efff-fac2-46cd-d5f6-08df22af54fb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|5023799004|56012099006|4143699003|260925022911599003|260925021911599003|260925021311599003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	c3g0ORY+GKWYQSacjQFsUYpqW+glbNRt9bRnlUTq3P1KT/dCdlNTeFnVzWHGSZl+GXgRaxmsS5gSUPeK7Tybm/yY4ER1PazQRgVk4PHd1BXa5j2maqQF/kaTVBxBCzCmx5qz1CleWj/9YL+ywc8FHpvWmd6A+gURM4O5u6cMBgZlXcvcp0Mo7BWToGTNGhyU5/gTBhcXNEMkw+4KXmW43SG4jMpb5ailAORAkOypgPdTjqPN/DO82SfK2I6TDfeHcWvqVNVGm+wZk/Zd8mHsOXryxnLpji97AqIZY89QIqvq2cydUrtCdE7KRSUwTzfc6ndNMUaqznSSzr368ZPwSUJTsWzy4jCFSlNKKFG9rWmivHQSvD6810uYOI/V5ed3aAjN1825MYiSH1DlyAChdljvm91dPCDOEBcQWS7Q4U6/5lWvGzzHBTL76TpHRgpIXGtSsRLKHrsyotc9kqwEXX9q2yWLHlpIt84+fuD8U/7qoQz1hlMd7gOKtOED5SXzof5WZP6lEZFeCFCAy2BC+UYxrFSM3+mwZa/W63E7yPELDfizpRg0EsuTBxbfK0JtbwiGXMpJrv/sMnwzCX3t1PPZ7AM5pDCFz7PgVQ8tkivi0uWo4aPIWYPOPDKxgfS5dHKk3CmskpyynfWstjwQ9QtionVUURFofFHStJfWOg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(4143699003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU43S1JRYTlsVHIvd3hnT0F2ZldNWXFUWmVuSUdVMlN6dXVLRzgzZmJYYjky?=
 =?utf-8?B?V1MyNk9ka2RFWGRUVWxmSTkxZi9zNXN4TWp5OElxTkV2REF5cFV5NllGYTlu?=
 =?utf-8?B?OFpSN29SREdkVjk2elUrZEhHUVJGNWJzeWw4NGp5ZVFLSmx3RVdZZnd1S096?=
 =?utf-8?B?REdSSFhXZDBPOVRHMEpOa2ZGS28vcS9NcEM0b0JLNGJZVnVtWEMyZDJBbjU3?=
 =?utf-8?B?RVlCVVc1QytJcGVkeWl1eElRUzNKQ2FKWjJvVUIrSVdBME43K281SGU5WllG?=
 =?utf-8?B?SHRCcGNOMW1zekkzQUUyUisxTXpHM29NWGpPMEZlM0JMSkpjVy9pUStIVEtn?=
 =?utf-8?B?TTVpNWRVR1FyNHRRVmgzSkY3bmRBbGVZbENxSk4rT041cVVzbUY3dTNWMTFO?=
 =?utf-8?B?dzVKMDZnaVFlYUdJTTcwbjBheUo2SHcxZnFOcDNETWFFV1ZmaGpJT3c2Y1RB?=
 =?utf-8?B?L3BtL0JsOFBUZXIzM0ovOUhTYzNoNmJiR2NPbHd3aUJHMmJ3RDhnbVFRZkQv?=
 =?utf-8?B?bTdqa1pFcnVPSkRpcFRXelVYYitzc09hTk10OW9qTDVOa2g4UWF0RXcxNGZ2?=
 =?utf-8?B?S1pxSk42ZGNvU21LK3JpVnRlUEtGWWlRbFdZRjcyMG8vSnZHYVBLdnVtMXdh?=
 =?utf-8?B?YUZTT2tHSzB5SEp3aklCdVJraHM5TXdIUnVFUTR2QjIzY1pRYXJlVVB2S1Jh?=
 =?utf-8?B?cDhtRCszQVkxMWdRUFlpaUQ1NmdYeGZ0b1BQZW03SUhtQ1kyZmRYVlFSMVpT?=
 =?utf-8?B?Tm9xSmkvS0xDZ0NyZElBTnFLeGV1K0xVR0t1L3dscSt0eDVTS2R4VDZtblF0?=
 =?utf-8?B?RWc0TFhDVGIvWEtaU0VQUCsvTXozc3BKYXdZRlFUbENBa0ppQnRISVFpZ3kz?=
 =?utf-8?B?WXRaK29MOXYxaVp4M1lQb3VuYWhWNDNxTGplMWhYWVI1U1drOE1FR3FkVlgx?=
 =?utf-8?B?OCszTGw3Kzc0dkozS2o3bHErc05yMWMyM0NLRllqMlNHU2l1QlRzNkhuaGhJ?=
 =?utf-8?B?T2cyNTlXR1I5TzRtczdLcmpOTkdRcUZjY2VML05hSy94TUZjS1k4Skpxd1Np?=
 =?utf-8?B?UklmcldJZnZaK3RHUlVVbWs2OVhEU2E2LzBKVXlxWkxsTzROelNyK2FEYjh0?=
 =?utf-8?B?cDVrWjVET2pWaFZqSnh3TXVWVCswNG4rdFlhTFlCb2ltVkkxbDFnaXI4WnNp?=
 =?utf-8?B?eHpFOEh1NWJNVHA2ZlM4Vkp0ZlIrcitadVVoelVkOVZxa3VJWUtXYXc2czRv?=
 =?utf-8?B?SGphQS9XZFBLWkZTNjhOWDQzV2trNzhqcmxuMHFWdGZYT1RsMURrREFxNEs2?=
 =?utf-8?B?LzE3Sy9rQ1I3cTd0SWtrc0lNcVdTQnMzUXpNMlBDMVF1TVBLWFZwY1NOWnFR?=
 =?utf-8?B?RWVJdFFLeTBnUUthbU9qNW10WFRyQlEvd2VRYmIzRER3NDRRMHZkV01xK3pS?=
 =?utf-8?B?YVpDaGhDWVNsb1dCcHZDaGkrcVd5bE43OUJkd0J0bW9aaTYra1dsZ0ZkTGg5?=
 =?utf-8?B?NzAyYlNUQ1lxRUd4YnMrSzVHSFhCby8xSGVMSlRxUFdGeU9la0lRNkQzVjJB?=
 =?utf-8?B?cjVBT01VNzQ3bWlNd0ZraVFrM0dqSyt3aHVxREtqeEk2L2NyT2k5cUNzUVdz?=
 =?utf-8?B?VHNRcUxDSS9HK3Jyb1ZmVjRsRDR5RXZaYkpmMFFYVEt2bG5IN0o0OXdKeHpm?=
 =?utf-8?B?dVZJV2d1R0NnQStFTjNWc3EzaytFbU8vL28wQ2J0QU5SSm1BWm1sN2Q1cEZq?=
 =?utf-8?B?KzQrQ3lHQ0tNNDJhZ0IrRGE2K0NHRXVsL0RUc3ZCbHpoQUEzSi9aNDlSa1JW?=
 =?utf-8?B?RHdCTnNMd2FKQityZ0NEbkZLS3ZBckZwaHZJa0N6ZXlydGp3QWNQTkQwYTVO?=
 =?utf-8?B?T0x2bzNmWmE1Ti9VQzdZaTRXM3V5ZDRkT0lPU3pSeXcyUGRwdDd2aDdicXJy?=
 =?utf-8?B?eWJkQ2dLdjZITU9ESGNFaVZuYmR1QUdGVzZYaDc3YzJ5M3VuM2JVcEZ2QWpu?=
 =?utf-8?B?bDVESDFsUnYrNGpmSGpHdVdsNkdtQXFPMUVoNUYwbkIvTEd3TVhUNWQraER0?=
 =?utf-8?B?TkVBZjdkMjB0WnVLeWdzeFFvdm9JTU1lNmdjY0tIZDhYQytaa2xzTU5YbTV0?=
 =?utf-8?B?elVLOWlWL2MrQUlpYjl4NHpmaXc1Y3hDMUEvRHZreURKU2lIaEs1UTc0Skd1?=
 =?utf-8?B?Q05Ha3RUOUNqMkY0S1k0RVE2UXozVnJRcmJCcHByWjhQUEVIR0VMR2MwMTF0?=
 =?utf-8?B?MmMzWHhTNFNpc1RybDRxeWdBNnU4N0lSSjdVRnlPWnlCOCtnWnhpZnZkbnlV?=
 =?utf-8?Q?rGxaJPLQiYREVMkq1b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91efff-fac2-46cd-d5f6-08df22af54fb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:07:35.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YAaLtS4FIjR2WVAmJeR3H+Hza/LDd1RfYgQmYrMS1WSi4ma3JZDbbOUJR6E0JN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

Hi,

On 10/3/2026 2:07 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider.
>
> Critical: 0 · High: 4 · Medium: 1 (3) · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] In direct (non-SG) AXI DMA mode, the new residue-based length
>    makes axienet_dma_rx_cb() deliver RX buffers that the hardware never…
> - [High] On MCDMA, which the cover note names as the target of this
>    change, the residue-based path accepts successful completions for…
> - [High] The commit message says the residue approach is correct
>    'including multi-descriptor frames where the residue is summed over…
> - [High] The residue-based length cannot tell a complete frame from a
>    truncated chunk of an oversized one.
> - [Medium] axienet_dma_rx_cb() computes rx_len = lp->max_frm_size -
>    result->residue and feeds it straight into skb_put() and…
> - [Low] The patch has no Fixes: tag and targets net-next, but its commit
>    message describes a user-visible failure of existing code: 'On designs…
> - [Low] The commit message describes the old failure only as an 'invalid'
>    length.
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but RX can stop
>    permanently after refill failures.
> - [Medium] This problem wasn't introduced by this patch, but
>    axienet_rx_submit_desc() advances lp->rx_ring_head before…
> - [Medium] This problem wasn't introduced by this patch, but
>    axienet_stop() leaks the outstanding RX skbs and their streaming DMA…
>
> --
Several of these concerns arise because the Sashiko review ran
against net-next, which does not yet contain the MCDMA dependency
patches that this change relies on. The patch description already
references the MCDMA series [1] and states the dependency.

Those patches prevent MCDMA from retiring descriptors before
hardware completes them, which directly addresses the
DMA_TRANS_NOERROR on unwritten descriptor and rx_len=0 concerns
raised in the High severity items.

Thanks
Srinivas Neeli

pw-bot: cr

> net: xilinx: axienet: Derive RX frame length from residue in dmaengine path
>
> This patch changes how the axienet dmaengine RX callback gets the frame
> length. It now uses the posted buffer length minus the dmaengine residue
> instead of the APP metadata words. Failed transfers are detected from
> dmaengine_result.result, and the unused LEN_APP macro is removed.
>
>> The dmaengine RX path derived the received frame length from the descriptor
>> APP metadata. That only works when the optional AXI4-Stream status/control
>> interface is present, because the hardware populates the APP fields solely
>> when that interface is enabled. On designs without it the length read back
>> is invalid.
> [Severity: Low]
> This describes a failure users can see in existing code. The patch has no
> Fixes: tag and is aimed at net-next. Should it carry a Fixes: tag?
>
> The APP word length read that this patch replaces:
>
>      rx_len = (app_metadata[LEN_APP] & 0xFFFF);
>
> came in with commit 6a91b846af85 ("net: axienet: Introduce dmaengine
> support"). xilinx_dma has populated the SG residue that the new code
> relies on since d8bae21a48dbe1.
>
> If such designs were never considered supported, could the message
> describe this as enabling new hardware configurations instead of fixing
> invalid behaviour? In either case, the RX length questions below would
> probably need to be settled before this is suitable for stable.
>
> [Severity: Low]
> Is "the length read back is invalid" accurate for the main target
> configurations?
>
> xilinx_dma only installs metadata_ops when xdev->has_axistream_connected
> is set. That comes from the "xlnx,axistream-connected" DT property, which
> is only parsed for AXIDMA. xilinx_mcdma_prep_slave_sg() never sets
> metadata_ops.
>
> In those cases dmaengine_desc_get_metadata_ptr() returns an ERR_PTR. The
> old callback then dropped every RX frame with "Failed to get RX metadata
> pointer". Before 8bbceba7dc5090 it dereferenced the ERR_PTR instead.
>
> Could the message mention that symptom? It could also say that the RX
> path no longer needs a metadata-capable DMA channel.
>
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 782f903d318f3..e7490650482bb 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> [ ... ]
>
>> @@ -1159,29 +1158,26 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>>   {
> [ ... ]
>
>>   	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
>>   	skb = skbuf_dma->skb;
>> -	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
>> -						       &meta_max_len);
>>   	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>>   			 DMA_FROM_DEVICE);
>>   
>> -	if (IS_ERR(app_metadata)) {
>> +	if (result->result != DMA_TRANS_NOERROR) {
> [Severity: High]
> With the metadata check gone, this is the only validation left. Can MCDMA
> report DMA_TRANS_NOERROR here for RX descriptors the hardware has not
> finished?
>
> xilinx_dma_complete_descriptor() only checks the BD completion bit for
> AXI DMA:
>
>      if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
>          ... XILINX_DMA_BD_COMP_MASK ...
>      }
>
> So on MCDMA, every IOC interrupt retires the whole active_list.
>
> Since commit 60786900347901, xilinx_mcdma_start_transfer() extends the
> running chain on every refill. It sets the coalesce threshold from
> desc_pendingcount:
>
>      if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
>          reg &= ~XILINX_MCDMA_COALESCE_MASK;
>          reg |= chan->desc_pendingcount << XILINX_MCDMA_COALESCE_SHIFT;
>
> That count only covers the newly pending batch, which is 1 per refill.
> The initial batch of 128 is above XILINX_MCDMA_COALESCE_MAX, so the
> threshold is not reprogrammed at all. An IOC after a single packet would
> then retire every outstanding RX descriptor.
>
> The hardware never wrote the status of those descriptors, so
> xilinx_dma_get_residue() returns the full control length. This callback
> then computes rx_len = 0 and passes a zero-length skb to eth_type_trans()
> and __netif_rx().
>
> At the same time, xilinx_dma recycles those segments while the hardware
> still owns the chain (xilinx_mcdma_clean_hw_desc() memsets the BD). The
> hardware can then DMA into buffers that this callback has already
> unmapped and handed to the stack. That ownership part predates this
> patch, because the old IS_ERR path also freed the skb.
>
> MCDMA is the configuration this change targets. Does the provider need to
> validate completion per descriptor before the residue can be trusted
> here?
>
>>   		if (net_ratelimit())
>> -			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
>> +			netdev_err(lp->ndev, "RX DMA transfer failed\n");
> [ ... ]
>
>> -	/* TODO: Derive app word index programmatically */
>> -	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
>> +	/* Actual length = posted buffer length - residue. */
>> +	rx_len = lp->max_frm_size - result->residue;
>>   	skb_put(skb, rx_len);
>>   	skb->protocol = eth_type_trans(skb, lp->ndev);
> [Severity: High]
> In direct (non-SG) AXI DMA mode, does this hand RX buffers to the stack
> that the hardware never wrote?
>
> axienet_init_dmaengine() queues RX_BUF_NUM_DEFAULT (128) descriptors and
> calls dma_async_issue_pending() once. In direct mode,
> xilinx_dma_start_transfer() programs only the first descriptor, but moves
> all 128 to active_list:
>
>      dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
>                     hw->control & chan->xdev->max_buffer_len);
>      ...
>      list_splice_tail_init(&chan->pending_list, &chan->active_list);
>
> When that one transfer completes, xilinx_dma_complete_descriptor()
> retires every active descriptor. Without SG, nothing stops the loop:
>
>      if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>          break;
>
> Each descriptor gets the same residue from
> xilinx_dma_get_residue_axidma_direct_s2mm(), which is hw->control minus
> BTT. With equal-sized buffers, every callback computes rx_len equal to
> the first packet's length.
>
> The other skbs came from netdev_alloc_skb() and were never initialized.
> skb_put(), eth_type_trans() and __netif_rx() would still pass them up as
> packets. Before this patch, the metadata check dropped them via IS_ERR or
> gave them rx_len 0.
>
> xilinx_dma supports this mode explicitly (5c9142a8063f71,
> 60786900347901), and axienet does not reject it. Is "correct across all
> designs" in the commit message accurate for this configuration?
>
> [Severity: High]
> The commit message says this is correct "including multi-descriptor
> frames where the residue is summed over the chain". Does that hold when
> one posted RX buffer is split across several hardware BDs?
>
> axienet_rx_submit_desc() posts a single sg entry of lp->max_frm_size.
> xilinx_dma_prep_slave_sg() splits it into segments of at most
> max_buffer_len:
>
>      copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg), sg_used);
>
> That split happens whenever max_buffer_len (from xlnx,sg-length-width) is
> smaller than max_frm_size. Examples are a width of 10 or less with a 1522
> byte buffer, or 13 or less with a 9022 byte jumbo buffer.
>
> S2MM closes a BD on TLAST and starts the next frame in the next BD. A
> short frame that ends in BD0 can therefore be followed by the next frame
> in BD1 of the same descriptor. xilinx_dma_get_residue() just adds up the
> per-segment values:
>
>      residue += (axidma_hw->control & chan->xdev->max_buffer_len) -
>                 (axidma_hw->status & chan->xdev->max_buffer_len);
>
> Take a 1023/499 split and a 500 byte frame. rx_len here comes out as 999.
> skb_put() then covers 499 bytes of the unwritten tail of BD0, which is
> stale netdev_alloc_skb() memory, followed by the start of the next frame.
> That next frame is itself truncated.
>
> Could this leak uninitialized heap contents to AF_PACKET users, or onto
> the wire when the port is bridged?
>
> [Severity: High]
> How does this tell a complete frame apart from a chunk of an oversized
> frame?
>
> For MTU > 1500, axienet_device_reset() enables jumbo receive but sizes
> the RX buffer to the local MTU:
>
>      if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
>          lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN + XAE_TRL_SIZE;
>          if (lp->max_frm_size <= lp->rxmem)
>              lp->options |= XAE_OPTION_JUMBO;
>
> No receive max-frame limit is programmed. The MAC therefore accepts
> frames longer than one posted buffer, up to rxmem.
>
> S2MM then carries such a frame into the BDs of the following descriptors.
> Each of those completes with DMA_TRANS_NOERROR. The first has residue 0,
> and the later ones hold the remainder.
>
> Only result->result is checked, so each chunk is delivered as its own
> frame. eth_type_trans() parses the start of each continuation chunk as a
> new Ethernet header.
>
> Can a sender on the link hide an inner frame in the tail of a jumbo frame
> and have it processed as if it had arrived directly? That would bypass
> MAC address filtering, as well as any VLAN or ACL decision an upstream
> switch made on the outer frame.
>
> Before this patch, the last chunk's app4 value (the full frame length)
> reached skb_put() and panicked. Now the chunks are delivered silently.
> Should full buffers, or chunks that do not start a frame, be dropped
> here?
>
> [Severity: Medium]
> Should rx_len be checked against [ETH_HLEN, max_frm_size] before
> skb_put() and eth_type_trans()?
>
> This code also assumes the residue always covers the full posted length.
> In direct S2MM mode with max_buffer_len < max_frm_size,
> xilinx_dma_start_transfer() only programs the first segment, and the
> residue covers only that segment:
>
>      seg = list_first_entry(&desc->segments, ...);
>      hw = &seg->hw;
>      return hw->control - finished_len;
>
> rx_len then works out to BTT + (max_frm_size - first_seg_len), which
> includes the never-written tail of the netdev_alloc_skb() buffer.
>
> When residue == max_frm_size, as in the MCDMA and direct mode cases
> above, rx_len is 0. eth_type_trans() then fails to pull the MAC header
> and reads h_proto from unwritten bytes.
>
> A residue larger than max_frm_size would wrap and hit skb_over_panic().
> That has not been shown to be reachable with correctly behaving
> hardware.
>
> [ ... ]
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but can RX stop for good after
> refill failures?
>
> axienet_rx_submit_desc() returns without posting anything when
> netdev_alloc_skb(), dma_map_single() or dmaengine_prep_slave_sg() fails:
>
>      skb = netdev_alloc_skb(ndev, lp->max_frm_size);
>      if (!skb)
>          return;
>
> After init, the only refill point is the loop at the end of
> axienet_dma_rx_cb():
>
>      for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
>                                 RX_BUF_NUM_DEFAULT); i++)
>          axienet_rx_submit_desc(lp->ndev);
>
> Suppose allocation keeps failing until every outstanding descriptor has
> completed. Then no further callback runs and nothing retries, so RX stays
> dead until the interface is brought down and up again.
>
> [Severity: Medium]
> This is a pre-existing issue, but axienet_rx_submit_desc() advances the
> ring head before submitting, and it ignores the returned cookie:
>
>      lp->rx_ring_head++;
>      dmaengine_submit(dma_rx_desc);
>
> xilinx_dma_tx_submit() can fail without queuing the descriptor:
>
>      if (chan->err) {
>          err = xilinx_dma_chan_reset(chan);
>          if (err < 0)
>              return err;
>      }
>
> axienet_dma_rx_cb() matches completions only by incrementing
> rx_ring_tail. Would a later successful completion then be paired with the
> wrong skb and DMA mapping?
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does axienet_stop() leak
> the outstanding RX skbs and their DMA mappings in dmaengine mode?
>
> dmaengine_terminate_sync(lp->rx_chan) ends up in
> xilinx_dma_free_descriptors(). That frees the descriptor lists without
> calling the client callbacks. axienet_stop() then frees only the
> wrappers:
>
>      for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
>          kfree(lp->rx_skb_ring[i]);
>      kfree(lp->rx_skb_ring);
>
> It never calls dma_unmap_single() or dev_kfree_skb() for the skbs posted
> between rx_ring_tail and rx_ring_head. Each ifdown can leak up to 128
> max_frm_size skbs and their mappings.
>
> This patch does not change that, because the old IS_ERR path also
> refilled the ring.
>

