Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31442DFE4
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172036; cv=fail; b=OjPURnNxuHRgXPdwycKWSN3D7ECOvNdUd3nJuyJpHTWRN1haP4QYAnrHdRG4Kls8hNrsinaMUpP/S8hq7LOomYuMu0p0d8FxI6lZBJsGHT7fdpP7mUNT+uRaskkAjUT+UtusxwK/noh64UlEoAlHQVHptc3HpO0kL1jtnczyTF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172036; c=relaxed/simple;
	bh=VWfyKcHxiSNJpfc2qgAKJ+FQuSGhyhz3YkNpFAq4ZGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBu43IHbilswc/Yd2cbApw8TVa+kN2uTfb9GCfHaRPO0u4VrzDF/F8y4GJYp1I9uY2FTWXdsJ0UNbZvJXW2U3M519YPLQmzyDqDFmZXlE6w/xkcoQsYAg1yTFylygTREb8BowRtgWqkxAlOGxhu4NJIkviVdxLs/N25wmBlND0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ow9bahel; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ow9bahel"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWjcy1kjLvgaaa9NdYTuTBrXvlqTlOTKCvx6P/tNdh5+BeWdm3VFAMdh4ldZZ3Vcq6WkkOwKKGt3uQdQdo5KDyEY1NLj256WirFl8WceNB9fWxu0HEb52TlYzT9K2rPYVn7Wd45cpbsntWaldzDVnPz6H/b5c4w3LbOCrYV4/rEPusbJGppdjPPTB4teVIfJhYw1RzMqco6GEBm+AxiZVOArvWrltsL0Mlu48StVe3SyccdU5K2VsbqmzZoECsaOkm68bV9+X0VDGYP7hfJE2594h8aW2YOYhLJX6iAHA7QxwlSszJ393hTPwW1hDkjyQzBsSKm7fXi8/9EMAvJKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwIpTi6N8/R6ZPwbNv/ZqaCk0RBUVUvME3iKLNFXecs=;
 b=CLfjpFs2v4cDWMkVQ4th6i39X8LZPKSPYp4QGGifCivP2CB9cVn/KgIgqfuH60fs4eeoJE4DSCanDlIlwz7gcBGeNW/sZFcgZiYTibIxr9W2RdnBvsL13dEaOqeuP/Zp372TDeuLP18n6OGHHPThcHiCtes2BVUUKx54IyIXIU4i+kVjQSUwoQtq70R/Eca042pFolzvBt+D0nvcmEpbr9IXDDExRVHrdddOjUdnwURK6oDuYxdj5pFHioZBHiG6Dvn0FEsxWw2KY3Ku3/Cxks83z/cJ33on0PYWVcdfTk0K2cc1Jj0nif6jGREm6rgzhx2TdqIz65VBvm7TtcOIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwIpTi6N8/R6ZPwbNv/ZqaCk0RBUVUvME3iKLNFXecs=;
 b=Ow9bahel/U2JiTD/Q4CvtfW8Y9lPBycCCC/9njiWLY4bi6rZbsPf5isWBor/d+j7+IqSBybPj2a0nJgHs9HeUb+fkVmbLb2PsuBDkO+NqnNKXGbeS94pYVMLvxx8x9VCHIOBx9u6BstbZF/OgeOinto4/Ysuj4DwKQBC2a6+zuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:07:11 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:07:10 +0000
Message-ID: <2e13a4fa-04c2-4eab-8d30-0ab86bdb1763@amd.com>
Date: Mon, 27 Jul 2026 10:07:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] pds_core: fix deadlock between reset thread
 and remove
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, nikhil.rao@amd.com
References: <20260714180223.1642792-2-nikhil.rao@amd.com>
 <20260721165512.423561-2-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260721165512.423561-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|PH7PR12MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7be95e-d018-4d95-0886-08deec017f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|5023799004|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6+VDjwcVYkParIvf7vBHiNzgHw/OthwimvNy8fAH7VrxDwtQg+gh9jgoZMTuHOi1wh1fTsceARTEtzfLKH8GQgdsFeL5/ttJAs1Rn2fh2j26N8IEUOwiFqfb8NAEHTfBFbQVhX0OEzaTii46a8w4pH3JGwyXWTWJaDiVcBOSlEXgRBmd/sGPnMrlaycZ302AJ/WFMiSa50SEldVbTcuWJ3AK90RgdXpvz82MqvohZDejG9jSdFGeMLeDySZ8yp4RbPGNNfm7aIx9rZyYnWPmtCEZ757nuGAEkq6betY+YwWyODy/w1f4ii/WJuWPkVy1BqDk9GYUX5xs55Nn7PE9lRublybxxVdcEfL79PR6UDm+CNhDqXMInygw4XzYr4+G52wWIVybwLMzAHJPU75ulAvrKq11VhKWffVBQjkVkowG74CCzTlVRUslCYy0ILl8WwxGuMPf5bn/dHGlz2R2RZCqBWiuREZuBNODvJtXWcdTpMHBVtGDki1SJcrrM5E7evxFxopSptsVvXt/1ReluITexKXhClI8CAP6wb61356iYcMZvibV7NTKMID+CS9V4AnZrHQuIhZ3iEV2ZFpDcgruJhYm8AMXz5EzM4SmFzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXlvZlpjNVZZTzkvcklUd0tFRWVxVnA2TG12UnBnS2o3L2E4MEpFM3F1RXVB?=
 =?utf-8?B?N2dpQ3dWZzBqYS9FRmhPcjJMMHduRkxGODhKWjU3UE4ybzloMkxwMGJFeVd4?=
 =?utf-8?B?U3hveUJKMmpSY0tuS3M3eGpFaVlNbmxscEE4UmEwNjVTeVgyKys0cWE1TzRq?=
 =?utf-8?B?aWlIbVRHZFlUK2JSR216QjNnWFl6U3F3SEFETlVYbkJhVGUwNkNmS0hHQzcz?=
 =?utf-8?B?STVmMWU4T1A0clNxVUJka2hndWVHVGpKZFA4VlNyWTdHYzRhL21nTC93TXVn?=
 =?utf-8?B?NDYrKzNaeGZEWUR6c3g1NlovN1JpblYvV3B3d244bE1TbERQcEdvL2xSMDNM?=
 =?utf-8?B?RzJKRTVHUVkycjBDWUNrcmxRUjNBRHhreDdFTXlTWEVMUGtjSFIyZGlwVXhs?=
 =?utf-8?B?SFJRaVlML3oxa0t6Z0Mzc2VTZDdvU0tnK2wvYmhSbjRXdGZRZk5xMGl6SWwr?=
 =?utf-8?B?ODZtM1hMMTQ0dWVLaGlFK3VibkdNNEE5QTV2Q04yQ0Q0OFh0Q1h1WW43MHpV?=
 =?utf-8?B?RVJaWkFxRGQrVkl6S25lZ3o1ZHBTakJmbC9vTkVITGhKNzR1STlFR3d2SHJ0?=
 =?utf-8?B?M3RTKzZrM2FaWXVHVmJMYk1ySFhRSzJuWTY1cFp4OVJsSmtDelIvbzZ4WWpT?=
 =?utf-8?B?MlNMV0V0SThZVEgvcVpqcHNVWmIwaEx3UHRJanFPYXg3cE1hMDRKYmRUeCt3?=
 =?utf-8?B?ZmhYUEZsMDFUSWJXVVFDLzV2WlczQTRuVmR5S0w5aU5zT0JoK05FWG1kTnFx?=
 =?utf-8?B?SFo4NjFLZmhlM2hnTmMyYTRXQndKYjA1NktZT0lUY0hNb0NtMmN3d0RLRks0?=
 =?utf-8?B?c0tXTTJPcm1FLzE0a3M1WFc3OXpuamdpTDluZkpFSzJ0VWMzZ2tDZXhTbWE4?=
 =?utf-8?B?VHhmcGpOY1pKeEFXRi9zYXptR2NaMFVDbmREUHVvWGxRNjZYWVNkZkVkRVRn?=
 =?utf-8?B?NWJPSkRUdGdwOVM3aGVVb3hhc0hXck1lcG1BbDg4NSt6a0l6eXN3Q3dLOTNX?=
 =?utf-8?B?TEVVUmdsT3BnOXZDemZJczF0Q1ZDd2RMdG9ldmh5UE4xK3hVelNXZGtBcWNq?=
 =?utf-8?B?OWU1R1hxdHp6dWJPMXhTSjdQV1pVVU94ZHZvVkJpS3NxVlJzZnAwYlZra2ZP?=
 =?utf-8?B?YTJSV1dTYUdRNjJHTHNqUjBqZUFzOTFUU1JJdGF5M2lmemhrZks4M2E2SDlD?=
 =?utf-8?B?WTF0a0tPbW5qdFh5MHMwNFdYRkNHdFh1eEl6eWtNVlU2ek9XTzY0dUxLbGZO?=
 =?utf-8?B?ZFdubHpKQ2FiaDFqWjQ4QitzMEg1SC9vd2xEajdoWDZ1OTZDV3R4bTE5eGph?=
 =?utf-8?B?emlUbXpqdlQyREZzd213QmZDQVdnZXVKbERRUytsVVFHSzU0V1pwTkpwb2FY?=
 =?utf-8?B?YXVSYk1oLzZlTTdEcG1oTXZiRk54NmYvR2xEcFN5eVhxekwvNm9EbVA5VWh6?=
 =?utf-8?B?endHOGRWT0c3eHN4Smw2SjRHMzlPQlhBbXZVVGl3c1ducVIvR01hRGRVUGF0?=
 =?utf-8?B?emoyU2o4S3ZBUTVWMW94Ni8zRzZ4QjRsQU5ycUtnYTNZU2dFS3hFRklIZlFJ?=
 =?utf-8?B?MjR2dTc4WmhXbEhZZEtLdzhxdFdJVVBFMEprMTZOdVRZK1dpSjVjeFJkTzcv?=
 =?utf-8?B?MkFCNFNLWFBMc0JTZmczc3VDZVlnVys4T1ZDdkNiVi9DbmswblJsakZBWXpW?=
 =?utf-8?B?YXFncC9LWmtXcTcxNDU5bkhyYkU1aGdNQ0Q4d1JMY1VGNFkzTklTTXpWR1lq?=
 =?utf-8?B?Z3FkQlVpQWorVHl5VkpRRGFTQnhLNmdnNWtjQmZLWjFoeVpGUVlDd0VWaTdt?=
 =?utf-8?B?NmcvdmVIY24veGFQaFlBL29uQWlaYml0NnpGM1haZk82dHFDYVp5a29kYTJP?=
 =?utf-8?B?YjczQVhabldLdzhoUTJ6Mk9LT2RBRkxDR0hCK21RVFovZGtpc2IzT1JuUXB5?=
 =?utf-8?B?Q3hxTUFlMFFSbWowUmJFL1BRMG00THdwamxsYkYyRHhMQ0Q3V0k2dUFsYy9p?=
 =?utf-8?B?M3ZJVVZNNXJjLzc5RzJMWDVqbzFkaHVpWjN5SndxZHlrajFrZXB0YUJOYTZt?=
 =?utf-8?B?SkZNcjY1dDFrWjlZWWw0eituYTFKdzRzU296cWE4THV3S1JNZ1MvdC90bVVj?=
 =?utf-8?B?NjlGWTNaUHlGY2pSK1ZQd1BQaUJjeThiNklUVHAydnpMeGNvQW4rdlRHaGU5?=
 =?utf-8?B?YUZSN1VYTWdOanpUTmw5cW9yYThsbldqSEp2My9zdjZ1aDd5emh5ZXF3bGR4?=
 =?utf-8?B?aTVFaXBaeWIreGdpNFQ4NEdZQjlHMTUzdG80c21UYjZFSUE2WG0vSmRZNngv?=
 =?utf-8?B?T25hb2UrbUtOdzFoZnRVcXVVYlpBeXV4bkFXZHQ5ejVzYTBVd2R2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7be95e-d018-4d95-0886-08deec017f1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 17:07:10.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhGPvQuFy6OBelSL2KZ/mRHTOMmS8j5wbSmTxeKG0Sx51tmNM3136Z0t+FNgAwPVEr6as3oXE3YCTzMQNQKkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883

On 7/21/2026 9:55 AM, Simon Horman wrote:
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://sashiko.dev/#/patchset/20260714180223.1642792-2-nikhil.rao@amd.com?part=1
> ---
> --- Patch [1]: [PATCH net v3 1/2] pds_core: fix deadlock between reset thread and remove ---
> commit e973ecbe07b7edd4ed406cf37388217ed5a167be
> Author: Nikhil P. Rao <nikhil.rao@amd.com>
> 
> pds_core: fix deadlock between reset thread and remove
> 
> This commit switches the PCI reset function in pdsc_pci_reset_thread() to
> use pci_try_reset_function(). This avoids a deadlock that occurs when
> pdsc_remove() holds the device_lock while waiting for destroy_workqueue()
> to complete.
> 
> Link: https://patchwork.kernel.org/comment/27002369/
> 
>> pci_reset_function() acquires device_lock before performing the reset.
>> pdsc_remove() is called by the PCI core with device_lock already held.
>> If pdsc_pci_reset_thread() is running when pdsc_remove() is called,
>> destroy_workqueue() will block waiting for the work to complete, while
>> the work is blocked waiting for device_lock - deadlock.
>>
>> Use pci_try_reset_function() which uses pci_dev_trylock() internally.
>> This acquires both the device lock and the PCI config access lock
>> without blocking - if either lock is contended, it returns -EAGAIN
>> immediately. This avoids the deadlock while also ensuring proper
>> config space access serialization during the reset.
>>
>> The pci_dev_get/put calls are also removed as they were unnecessary -
>> the driver-owned workqueue is destroyed in pdsc_remove(), guaranteeing
>> the work completes before remove returns. The PCI core holds its
>> reference to pci_dev throughout the entire unbind sequence.
> 
> [Severity: High]
> This is a pre-existing issue, but since we rely on destroy_workqueue()
> during pdsc_remove(), does this leave a dangling pointer that can be
> accessed during teardown?
> 
> In pdsc_remove(), destroy_workqueue(pdsc->wq) is called but pdsc->wq is
> not set to NULL. Immediately after, pdsc_remove() calls pdsc_teardown()
> which calls pdsc_devcmd_reset(). If the firmware is unresponsive,
> pdsc_devcmd_wait() times out and pdsc_devcmd_locked() will unconditionally
> evaluate if (pdsc->wq), which remains true, and attempt to queue health work.
> 
> Additionally, hardware interrupts are not fully masked until pdsc_stop()
> is called after destroy_workqueue(). Could an interrupt arriving during this
> narrow window cause pdsc_adminq_isr() to race and call
> queue_work(pdsc->wq, &qcq->work) on the destroyed workqueue?

The pdsc->wq use-after-free and the interrupt race mentioned above have 
been fixed by [1]

> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index 38a2446571afa..1074a022a52fb 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
>> @@ -606,9 +606,10 @@ void pdsc_pci_reset_thread(struct work_struct *work)
>>        struct pdsc *pdsc = container_of(work, struct pdsc, pci_reset_work);
>>        struct pci_dev *pdev = pdsc->pdev;
>>
>> -     pci_dev_get(pdev);
>> -     pci_reset_function(pdev);
>> -     pci_dev_put(pdev);
>> +     /* Use try variant to avoid deadlock with pdsc_remove().
>> +      * If lock is contended, the watchdog timer will retry.
>> +      */
>> +     pci_try_reset_function(pdev);
> 
> [Severity: High]
> This is a pre-existing issue, but could this uncancelled work item perform
> an uncoordinated PCI reset if it executes after an AER recovery?
> 
> When a PCI error is detected, pdsc_health_thread() queues pci_reset_work.
> If the PCI core independently initiates AER recovery before this work executes,
> it calls pdsc_reset_prepare(), which then calls pdsc_stop_health_thread().
> 
> While pdsc_stop_health_thread() cancels health_work, it does not appear to
> cancel this already-queued pci_reset_work.
> 
> Because the AER thread holds the device lock during recovery, if this work
> is delayed and executes after AER recovery completes and releases the lock,
> will pci_try_reset_function() successfully acquire the lock and perform a
> hardware reset while the driver thinks the device is actively running?
Link to the fix for the finding above -
https://lore.kernel.org/netdev/20260727170030.361116-1-nikhil.rao@amd.com/T/#u

Thanks,
Nikhil

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=0ad134881508
