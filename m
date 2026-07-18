Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5BAD24
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416591; cv=fail; b=cUBqrsd1dZTBf8CZgzGe5vJ8TvlGebTAmZa7RE3BkESKG0RTRjgo+ptJWWJjlcYsibwDu98qRxdUOj5XkGQZ2nOucyCWGdtzVEM60K/mGj/n8j8ybtKS/yB75rZ87Eiz/avr2MLBcJpAupmq0bk0StOua2p8K1goOV7onsX4Ye4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416591; c=relaxed/simple;
	bh=+mr0NIiwOnxzm4KOrSWkDi3Ak6Gsv5EhdrT/nJbGU3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkokYVb5/7J8m97l5iP6Kl/B6SCUXrkJtwKw0ACQtqsAHH9bbaFSF6mtagfOpbh429Jb1aMNgkEa6Jumi3vhTSbfB6biIHIx+kBCJIhgIqejLO+wq6ogbZWJo26kUyo/jdr4JV70b23ijIUJfsIWHX9P0sImXyLYZ4RIQH6OWyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P5QTIJA4; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P5QTIJA4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKYVV2TwGf1oNcVnt62QrycUoQGYz8bW5l1+Mgu4RFenSxwTFxQ0gOc0EvRbHcSOUKxmq9tof7g61vvOMfTDXyRbEU5pvtfiKA6kiN7LRU4X5Cmoh7NkCctR8CHFfeiT7teXxlY32XnXAuBxXhSmpqYWoyi4sTm5G/XrhzQiRJ4EFsngB2lSIR18gLZe0epvPr7Aujs2YKpEwrSQIjSNfIyTeFlgb7tgr+/iyZmd2oHVUg+COJmNSUuuRJtijzxAaQdoHB51SGDecu88uGeAr7OqCK4zMhnPapAllmZPE2jxG442CMsh5dY4c9o3MWEp12z1b0d2J6MtrqZdfJW3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJfT9SCFturmLKVs9od6s+qHgLTjGqV7+k9WknV36Z0=;
 b=j6LZ9PSTyHEtAY1BkNJw6xkmXd78fS4GWyE49sQWHM7c0++wQlMDuX3lyAAdn+mXM2J3pYXRRNLoE/VySoyyt6TnFf2JiJkhN3Toy6ijXtY0ZlTI3snj4eclg9xPPyc5wvGi8mN7I0pBCD8ghnTgNBMkmptvr6DurG9ZerhDrthOPGoIx852L8hAZboHLwJwvv5p9e2pzP8mrEW8t+UvPhO+daPIJReik8JWQpip71uDCj3485nPQRnz9NhEPWk7iZaV47iyr4cNlMlosCWaqoA7OKdNkYJptDRelTWyUHEtr9N0TCquD6PNq3aOJf1Uc2+b4RpvyoA2CEnE6KDJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJfT9SCFturmLKVs9od6s+qHgLTjGqV7+k9WknV36Z0=;
 b=P5QTIJA4lNdSzcQczK2UG8V/erAITYSKC216gkyuNJ8FsX9NgCgzhGk0Iezg7/4jFaCk0nEYjGaR/+KUNaFfh+M651y28ooyekHZAM3gZGtFasex+PJ+0J2wz8/pqzeCjijEoh6zmF09UbHJZVKXMMi3tJdAOU9vL2b+zLEDkYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 23:16:26 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0223.011; Sat, 18 Jul 2026
 23:16:26 +0000
Message-ID: <f601268d-795f-46e3-a70a-d6f025c3871d@amd.com>
Date: Sat, 18 Jul 2026 16:16:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] pds_core: add host backed memory support for firmware
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 nikhil.rao@amd.com
References: <20260708212222.296202-6-nikhil.rao@amd.com>
 <20260716072313.192902-1-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260716072313.192902-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 722d65e2-39fe-4e62-08fe-08dee522973f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	q8UIiEohshjinOWkjy79WvLDlRVhFOXdynbYSGI/cdLKPwnfMkEOxC/rnO9L2K57Y5mu6Ia0BfjDyR7McJQIX4LiX4gyjR5ul3Auvq4QVNHN4q8/Pr3hGjnqevG1mHYHWUDHhYMRQF2Am5oARZjJEtJ3aSBS5E6FgSXh5sr0ch677cwCg1QnrbBkp2UWedJ+Z0tWBA9M0UFExO7vwa/LXe4LOvesp0cYYGwc904YYwhFP4xzRmSHufq4ywEvGuKXHRQP46bpZxaYD657JKBYunX4cZxF3JJ6dLg9mmNDDyTSs64+PNqefWPylmz8NX6GD6Ht8Kse4m7fiiTb0uR1D60894PyTeq8sFn7Cfp+eg+I5p/2kdEBDP8aO+QZ451pMSi9cPOfPzox6wB27Yq8jew3A5RBwNGfpDLZ8hHtddsfZ6vb/jUAG/FKt1V+Zjd9oASOADFpbn/LVaYCrkE0jbXUQu8s0rAE+0BrV+Lai7q/c1j7OTrVVT63++JLJcMz2EK7pZykBALmaEp2QqR8IaHbThYDr3tOJeXl3rX2D+5CkRXJP27AOQB4sOZZ8hVs9WxCoK1u+ofG4cNW1gPU1h3uXFhzctvTMdny6WvR65c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnZ4ZEN2WDhPRndRVXFVY1U0NmVaNjM0eXVqNnJZdWhqL2JYaDNaMGVpbyt2?=
 =?utf-8?B?NGtvN1d4SnBBTkJjWVVTZ2FjYlNxMVF3RTBwcDJubmp1VW9vMG1LZkZaRU9T?=
 =?utf-8?B?bmJmQ3Z3QXplQUZhekpXdEtwQmxETXdIS3A5WVJjNmdIcWJFZE1XWGJzemhs?=
 =?utf-8?B?aUM2ZVZGMXY4bzhYK0pTUmpDQ0tLeFZHZmtpNHI4QVpXSGFYL05pYm0xZjVi?=
 =?utf-8?B?SVZ0WWozM1ptM0ttdVZuRHdVY3hsdUhBbVJXdTlNT0UzMDJKMmlBajF6Nk1R?=
 =?utf-8?B?RmFmajdoWVRJeE14YjF5S1daOE5QV0VTb2hpaUthQUMrbGI2SXRnaWJVU3ZS?=
 =?utf-8?B?bTRZTUJRY1JSMHFKRTU4clFBQUlZSGhSTk16UEQvWU00SVJOVTk5TjlXOGJl?=
 =?utf-8?B?RVdGdFNWcWJPanNYWngzbWl1K20vdFBQT2FKbW1OQkpSWHZrWWFnSzNKSytL?=
 =?utf-8?B?SlI0ZHR5aUE2OHlJdHhnMXY3dmFMY0dnTmg3T1NKMGZhUnNEV3c0SWlGVkFv?=
 =?utf-8?B?dzFOa1ZhY2R1Y0VNUFYxdm9vYmtJQXpiczBpclRWWjF0TmdJcUJsenBvMTN6?=
 =?utf-8?B?UE5SRG9zVTNmLy81eFZZNjBaTlN2YmZvWDl3Q3RNL1V1V2dTb1R5U3YzQTly?=
 =?utf-8?B?NmJHcFljUmtmeDVOMy8wemtmMmdZVjlvdFJWT0tvN2VKQ291WnJiY0NmTDdW?=
 =?utf-8?B?SmxaRVBGNmRGa1VJcXJBQ2luYVoyeUJ3b3J4NkNqWldJSGpXcDFNeDM4TWZX?=
 =?utf-8?B?UUpLYWFMTVZFR0NYWklNelREVDRRVHgzK1RjblVuaGN2RGIrcFpmNk1rZHh4?=
 =?utf-8?B?dTlWaG5tdHp1QVpvQWNkYlp4NkF1ektFT0VJYUd5UVVHSUc2WmQvK044MVh5?=
 =?utf-8?B?TGpVc1h1TmRtN3Z3VWRJU1Z0bmc5TDBJWFdJcTRpRjJ1VEdvUFRnWlpOZDdr?=
 =?utf-8?B?cVUxQStVSjg0eHU5Mk5XNlE0d2lJd1E5a3JtSXdycnc5aXVuRnZ3Wmc3ZmlC?=
 =?utf-8?B?N3VucUdlMWpEYnpWTVd2Ni9nQWRyS1ZZWkh0aHlnWjVDaFRVM1Ixa0lkRzZp?=
 =?utf-8?B?eVVKZDB3TzcrS0w1cDNmaDZscDV4WUdkZ0IrcVh3aUVHWEI3TFptYngyQ0pm?=
 =?utf-8?B?b0tnSUJQYklPQ0lScjZqMDMycFlTMlJMUVgxcjBRMDNiZDBUNmRuTjA0MXdr?=
 =?utf-8?B?L3M2YlpwckNTK2hiUXpOdWVnUGNMMTlUaHNxT1l6NG1BUE5sWlhGMmdmRzJO?=
 =?utf-8?B?ZEtiTFRVZmwzRzVZam1vak5hMGlSbHRhQ2lMVkw0b050Z09YMWc5T0ZTRUFH?=
 =?utf-8?B?T3hMTnZNdFlLNWhOVElDdDZ1STMzcGh4K1VtbDNjYnBPbytUUWZwR3RhVWtE?=
 =?utf-8?B?N1lCRmhRM2RMM0ZWZUQxSmM1RWV0ZGg0Z1Rjd1hvV3JxOWJHYmtNM21IcHN5?=
 =?utf-8?B?STFoeFFJQStLU0graHJkYnlRS3hxNTcwQS9BWThmcEhIQkoxY0dWRzZCWXBI?=
 =?utf-8?B?RmdpVWQxbTlCd2FWS09IVitCY08rZlduenVKRHRrVnlPZjJQT1QrUWhiNzMr?=
 =?utf-8?B?UzhKZy9MMGJiV256Y3VURVZDS3hoWnp0Q1VMK3RwbzJZVUw2cmRNVVk0SkFm?=
 =?utf-8?B?YXh1OHRqdVZHV2hleEtWb001TXpyVGRzVWVCVHZkSjBKWWdKZjdqOGNqVmQy?=
 =?utf-8?B?MTZ2WmpUZzBBSWREWldqNCtIejlXQXJ0WTRaUU9sNHluTFdKTW82MnFGYjRH?=
 =?utf-8?B?cTdDamM2aVI4RytnZE03dFJUQzk1VVVJTHJSTmN6KzJCNFljRm1NRnRCblpF?=
 =?utf-8?B?Qm01U1VnenhFaThram4vT0tNS09jU0R2RXlQU2U1akhKTWpaOWdUSk9mb1Fx?=
 =?utf-8?B?SVZXQ3N2Vk1EMjdzTEpEaU1hSWQ4bTVDR3Nkb3ppK3pKVFZKb296NW1McWJh?=
 =?utf-8?B?N2RPOXAxUkZPSWJhcmE4MGsvajh0bFJzWGJWdGdJVlhZTWlsYU1EdlV2VGdw?=
 =?utf-8?B?bDRtTlBZZTVmRXJXQmwvbk93V1d5d1d5QWc0Z3liLzZmNVR2M2xOZ2NxbWJl?=
 =?utf-8?B?MTA4dE9jNWRyMzdjcUxyQnRLbjl0QTNrWUR2Q25PYytLQlpmSS9LQ3NaRGQ0?=
 =?utf-8?B?OVBVVFZvMFFtVDdBQ2J1T1JwQjl4VmFDRzZSRjZ2bkUyZFZBWDdwNWlod3Mw?=
 =?utf-8?B?QUIzUmdzNzBwaS9kTXMwRDhuVWsza0V3eHdrVjRMOXdMSWFKM0praEl5UTFx?=
 =?utf-8?B?YzZUdThDTk5qYjdLQkh5NUdBODcxeDEzM2diUzhQcG4xanVqQU56aktSMWor?=
 =?utf-8?B?dzlveE1sdFlCNkxySWVJQUF0cUZXVjFDTWUyTGowTW9ZZWwzYUtRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d65e2-39fe-4e62-08fe-08dee522973f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 23:16:26.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHaEKAPtXABah74L3rQ/ZXHrQfN2NCBWuG8ChmjFoVJgWnu0n1s5H/34/fThwRkR6vV9IK1//ZOdVyDOhHXvIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202

On 7/16/2026 12:23 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [5]: [PATCH 5/6] pds_core: add host backed memory support for firmware ---
> commit 0970ce1c8fa02a37c722e99472916638286b6ad9
> Author: Nikhil P. Rao <nikhil.rao@amd.com>
> 
> pds_core: add host backed memory support for firmware
> 
> Some newer AMD/Pensando cards have minimal memory and there are cases
> where components, specifically in the control plane, need more memory.
> This series adds support for host backed DMA memory that can be used
> by the firmware for the previously mentioned cases.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index a7a0bcf98ed3f..356a69c895b63 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> 
> [ ... ]
> 
>> @@ -673,3 +675,161 @@ void pdsc_health_thread(struct work_struct *work)
> 
> [ ... ]
> 
>> +static int pdsc_host_mem_add_one(struct pdsc *pdsc, int index)
>> +{
>> +     struct pdsc_host_mem *hm = &pdsc->host_mem_reqs[index];
>> +     union pds_core_dev_comp comp = {};
>> +     union pds_core_dev_cmd cmd = {};
>> +     int err;
> 
> [ ... ]
> 
>> +     /* Track this allocation so pdsc_host_mem_free() can clean it up */
>> +     pdsc->num_host_mem_reqs++;
>> +
>> +     memset(&cmd, 0, sizeof(cmd));
>> +     memset(&comp, 0, sizeof(comp));
>> +     cmd.host_mem.opcode = PDS_CORE_CMD_HOST_MEM;
>> +     cmd.host_mem.oper = PDS_CORE_HOST_MEM_ADD;
>> +     cmd.host_mem.tag = cpu_to_le16(hm->tag);
>> +     cmd.host_mem.size = cpu_to_le32(hm->size);
>> +     cmd.host_mem.buf_pa = cpu_to_le64(hm->pa);
>> +
>> +     dev_dbg(pdsc->dev, "Sending devcmd for mem add tag %d size %d pa %pad\n",
>> +             hm->tag, hm->size, &hm->pa);
>> +     err = pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
>> +     if (err || comp.status != PDS_RC_SUCCESS) {
>> +             dev_err(pdsc->dev, "mem add failed err %d status %d for tag %d\n",
>> +                     err, comp.status, hm->tag);
>> +             err = err ? err : -EIO;
>> +             goto err_del;
>> +     }
>> +     dev_dbg(pdsc->dev, "mem add completed for tag %d\n", hm->tag);
>> +
>> +     return 0;
>> +
>> +err_del:
>> +     /* After MEM_QUERY succeeds, firmware expects MEM_ADD or MEM_DEL */
>> +     pdsc_host_mem_del_one(pdsc, hm->tag, PDS_RC_ENOMEM);
>> +     return err;
>> +}
> 
> [Severity: Medium]
> When the MEM_ADD device command fails, does this error path leave the memory
> allocated and DMA mapped?
> 
> Since pdsc->num_host_mem_reqs was incremented before the command, the memory
> will eventually be freed when pdsc_host_mem_free() runs at driver teardown.
> However, it appears up to 4MB of memory per failed request could be held
> uselessly for the entire operational runtime of the driver.
> 
> Should the driver explicitly unmap and free the memory in this error path?
> 
> [ ... ]
Same response as in [1]

This is intentional. In the timeout case, firmware could still be
accessing the memory (slow response, not actual failure). Freeing
immediately could cause firmware to DMA into freed memory. The memory
is freed at teardown regardless of MEM_ADD result.

> 
>> +void pdsc_host_mem_free(struct pdsc *pdsc)
>> +{
>> +     int i;
>> +
>> +     if (!pdsc->host_mem_reqs)
>> +             return;
>> +
>> +     for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
>> +             dma_unmap_page(pdsc->dev, pdsc->host_mem_reqs[i].pa,
>> +                            pdsc->host_mem_reqs[i].size,
>> +                            DMA_BIDIRECTIONAL);
>> +             __free_pages(pdsc->host_mem_reqs[i].pg,
>> +                          pdsc->host_mem_reqs[i].order);
>> +     }
>> +
>> +     kfree(pdsc->host_mem_reqs);
>> +     pdsc->host_mem_reqs = NULL;
>> +     pdsc->num_host_mem_reqs = 0;
>> +}
> 
> [Severity: High]
> Does this code risk leaving the firmware with dangling DMA addresses?
> 
> The loop unmaps and frees the provisioned host memory pages, but it doesn't
> appear to send a corresponding PDS_CORE_HOST_MEM_DEL device command to notify
> the firmware that the memory has been revoked.
> 
> While pdsc_teardown() sends an explicit reset command for Physical Functions,
> it skips this step for Virtual Functions. If a VF frees memory without sending
> a MEM_DEL command, could the firmware still attempt to access the freed memory,
> resulting in IOMMU faults or use-after-free corruption?
Same response as in [1].

For PFs: pdsc_devcmd_reset() runs before pdsc_host_mem_free() in
teardown. The reset clears all firmware state including host memory
state, so individual MEM_DEL commands are not needed.

For VFs: They never allocate host memory. VF init path (pdsc_init_vf())
doesn't call pdsc_setup() or pdsc_start(). pdsc_host_mem_add() is only
called from pdsc_start() in pdsc_init_pf().

Thanks,
Nikhil

[1] 
https://lore.kernel.org/netdev/e5c3a2f0-4104-4e3b-a85e-a6899f662169@amd.com/
