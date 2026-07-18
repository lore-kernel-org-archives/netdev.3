Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A014ABE
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784414066; cv=fail; b=B5z44iMM/nnxvS/V0MRfh8IEyl/Uc5pN47mnBDqbdZtds+v8asbeIZtKO5J4vSzYgWCw8yBK1bj0ZkJ3G/9yif91MT2Vs/aKZ1I9nl4TbzjWaEQQYprjO1yRmkEeaMTxwreEK1jZRRAjcan943ODet4QTC7qFE/fdIq3YX3zK+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784414066; c=relaxed/simple;
	bh=8vb+2PJWsFc9HN0nnNcUg4LPTQvUxPyJ+wzWdQ6jEhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoX2FfeMtOU7XOrQls6ajAER6HQbTG44gY9fF0dKWrOfRlS7CpmY4gqRMRVsx7HLsLH63WAKeGt8YErbXoRObzt56Usn5nt+OSrhy+lHbePp5PL5Nkk+dme3WUdpBpLZrywxUgXRJBEJv4KWwKuv4BRErgTeZ/daS6dD9EiKZdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LvW1DcTq; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LvW1DcTq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA22L2edmt+1lrWMUmS5FEUPlIR9L2egHQXB1HHmRc0DhLzZO0t3vO8jjnRGtu0K6BdEITWk876TIruokmmdeghT3bPIOYutUuTmcB0XBHqLk+9PfdJWdsAacEKAsW1JwPR+kqtkCgIlWZIcVEQcG5KnaCFGjkFjzh/OjA2SwJTrOquwC8sgadkTcLh++O9sp5xvGhqTfhlHymU2FBnf/9uTCLIwfoZRTDMchgEMcEviplIdTiU02SRitKnCPr/sW7b1syfVp4r8A6zcx80XDced6KlYNXwXHTNBzr/BZLZtsb7Dcbee6/nPINB4GVVJx9Wuevqpk0L56U/SyY+GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+oopAvmwVcDf67nLv5fq05Hfrq+QOAJJQ0JOcMEuBU=;
 b=J4OltL4HaKvX9BRVBu0CuL/a4S+2cRlFUZQgACvmVcWOwBfOmnnpxRoqQsLoKcxAo0MMi+oF66zQ8usTno6Fpjx3+mdawNBooU1WkK0359wWDVW0kmxVCrPALgZCMs4sCQiH+hQGEB19V8MGuxxKkIT4/AqVJqnr8jaUwmFv9ULstYu7ecMtJVSbF5hZdgt+fvXXYoeg+x9r/VbXtAuCrwExrrspN/0Bl48yriZZkkof6ECw6kGCB18eE81U0OdwHf4jSaxzj2zCeWP3nC70rq2V9z5e9YFCdiyq0QQnWsqRTH0HEMYKxZGeJTepQrsFDT0Q8w/EjfS8es4r4M7h1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+oopAvmwVcDf67nLv5fq05Hfrq+QOAJJQ0JOcMEuBU=;
 b=LvW1DcTqsai40Qub7maipqwTaUKOn6GBfIHWMamPPygyyvOp9MPio8rJdzJgkNxrD8EziyOK6Bk/qL84BWsfU4rRWL0HIWXHSk+KPq06yjDR8d6PsU9VOaDDuZmR46esJCc2BzaING1NF80dLNYCLMXRa6DQb5gxd/apfoolz7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sat, 18 Jul
 2026 22:34:19 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0223.011; Sat, 18 Jul 2026
 22:34:19 +0000
Message-ID: <780faaf8-154a-4fc8-8fcf-ec3c75ce4d11@amd.com>
Date: Sat, 18 Jul 2026 15:34:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] pds_core: add PLDM firmware update support via
 devlink flash
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 nikhil.rao@amd.com
References: <20260708212222.296202-4-nikhil.rao@amd.com>
 <20260716072042.186444-2-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260716072042.186444-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 148ad411-cef6-4ace-20d4-08dee51cb4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|4143699003|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aFxP/n6gxg3fCmD9jFNO23PyLtcBxTVXBp/JsesVfiWK2V7RNqD3Cg6z2AW7b2w4LFxfhBtyOg6TiDUFgJ2gWFpdxRQ/becL7m1jorAUjjXRQrQuGijTqJ7hsHuUoXn6wK4Mpt6L13rDw+H+rDYzZlA7ynQ6+jzH+WdsS2CmjxoVyDM1a22v+tztWtPuSiSxZmkt4ZbWNIU6aCtqJZSi1QdNX7BVQT+NPvPwanMwDyQ2CgnSPcnofZpCjZs0zE8KTouwvDwPmMjOOqHZQME0X33qZg1bEL1Z4QzYnX+s2F/ObO+RXgJtP974PqIUad5uRLZ2gSfX3/sBEbe9DDkVmxDc1DmAhKSfzmuTo9Aj45hYil/NPd1GT9y9uFqMJYf6WNl+JzM9mbTtoM9YxSxlFuWNgV9Q1HcAQ/ucs2nnBzmeZMwTwIvZqXiCxmNjgtL22pf9oaBpu4t4ujFH5MNx59Oiy8WRjzj0F4ZtJcSKYoACA/RNsAhM0JBR22+EwH82VqnIjZQk+8Lcb890jN3jlIYgFji/4QvOLhGPbczlXoJPWqxmlPLUWxc6axKMWNkiowZz6AGA+SNhsKYM8GMG9YAnl0rPpY5skUm9ZN80f2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0FFZ2RMNXVudGs1MHlVUjJWSnF4Yk9KVEh4SktDay9uNEVnSEc1aDZHQmo1?=
 =?utf-8?B?MStGRGdWV1p1Mm1sT2NsOGFEUkllS2oyZmVBc0NYVFR2bkpDNit6ejFMVWJa?=
 =?utf-8?B?RHBaT1VaZC9IZlZ0Mm9DY3JTc2E1Nm9IMHlSOWpZTUloSnBVVG1xc0RncFhl?=
 =?utf-8?B?REFqdHhsVWFZUHRjMVN1Vk1FdW5Lc0lDazdMbXJXalpWSm9rd0FBQWpxbjRt?=
 =?utf-8?B?Ymd2NkxkWVE1YjFhV2V0RnRyd3YySTdsS2JKR2plNm4rT2RVb2YwaGg1RnFp?=
 =?utf-8?B?Z0t1Qlo1aGNsdUhSdUluY1NjenBtL2VnN1FxcDN1cFRUOGN2b0FUc0hxSFV2?=
 =?utf-8?B?d1I3ckJudktZT2ZQV3h5VjV5cXhTc0EvUURVVWozNXNSS3FubkFnMmpYZlpW?=
 =?utf-8?B?dE5RUzB2UG9PM2NLQmNzbDZCZjZ4R0JabzVsSk9YYW1INUdiRzlpS3BiWFNm?=
 =?utf-8?B?NG1YN0REUUdIYXBXb1E5cmNTOXo0eThwVDcwWHRma3lDdWlUUEV0SEM0blps?=
 =?utf-8?B?Y3JENEpUZ1psZDFQaXB1Y0NJOXJ3MUtzcXM1Y1lsNXNBckFsWi9oVHFqb3R3?=
 =?utf-8?B?NnNiaVMyTG56Vm1VUWhaOWl6cVl1WnZ4YndDSyt3MTArd2xoS0FuOHlqanJ6?=
 =?utf-8?B?WXp1LzY1MlVZRFNBeFZNdjlRNlk1RU96MVJDNG41UFowblBLWjVqVGRHcWhq?=
 =?utf-8?B?aVVHb0dGVm15aUNRbEFMNjVJK0E2eUROUEpONHpjc09wMkN3Uy9ZVittdDdq?=
 =?utf-8?B?MXdnSVh3cUF3bC81ekFDdDVndUl4U2I5UGl3ekt6WFdWRjQ0ejd4czZBZXJX?=
 =?utf-8?B?bHNCbHowR1B3RlJ6OUJIUUdjV0pJVk9JWXcxUmpHM3dFc3F1cDkzTDF5dUVa?=
 =?utf-8?B?K2JjSFdPeGY5WWNjZElqYk5VeDRKYzl0aHQvYTJQc3lTSTBSSzJVWWpva2U5?=
 =?utf-8?B?YmovWVc1MllrVUFkMERKaC8vankrY2htOUZoK1FnMHdyY1RCNjhXRS8rNm5Y?=
 =?utf-8?B?azZ0TU5wbjFjL2RKTzBPZS9VQmFkSDlHZ0o2K2NNbEpUS3pDQ29XbW1QVkdN?=
 =?utf-8?B?TlV0Zm9QcitFYzlabzJRWXZCbW1LTmJqQzlEaTVXTXIrazRBTE9KMnFIWmVm?=
 =?utf-8?B?RUZmb0RrcEFsK2k1YTB4RnR3R3NKWElBOGRJaFlxbjdVeW9tVmMwYVc5RTVy?=
 =?utf-8?B?UkNsRlBDNWlobkhESkpnUVBQMUw1R0dyczdndjlTRWltVkI1ZmNCNTg2U1Jw?=
 =?utf-8?B?WFQ5cmU4c1puS0IvRmVFbWxGMm42emV1TGJuSDd3VGFlUlpqOURKbDZycEl1?=
 =?utf-8?B?Vyt2d3RNeGVQbXdCejhpSytsdFVZancvRVlMSk01bFVmcEpaUG9hK21rbU1N?=
 =?utf-8?B?c1VZelVVYWhLK05rLzdQZmFkOWFjc0J2eHJtVXczR0VGZC9Gd2lkS2xrM0dO?=
 =?utf-8?B?WGJSckJUbGV2aEdNVm5jMDg3WEJwb0NXRVVuSHd2NXl5RVlaMjI1OU5weGVt?=
 =?utf-8?B?d1ZCb0hYOXh3SkRqaWYzVmI4VGx6SEIzN2lOQnZFeFVteGJ2ZUJhT3hxekRZ?=
 =?utf-8?B?endld3ZiVVZTdktzWTQ5cnFDZ0Y2aDBDdUxJZ1NOclpuWXRuT2I0eGMwNEU4?=
 =?utf-8?B?bXNQTExZZVBiTUYwZ2FEYjE5SmVpb2V5VS9UMTBIbUlERmMreWVJOWR2Vk9i?=
 =?utf-8?B?b251ZjQzRFVSbTJFR1JncUZBSW9QM3lhYnFtQlg5YWdndVNrandiSkJ0aER0?=
 =?utf-8?B?T0ZPdUZuby91d29MK3NUam1PK3BzK0dvRGhiREN6MUxxaGIvSDc4MG1NY1Nt?=
 =?utf-8?B?K1d1ZWd4UjZRSy9PejNrUlZlVWxzSDZlakFkTlcxcHRlNlZua2VDVlNobmhO?=
 =?utf-8?B?WTV1REwzTG9qN3MzU0ZEOU9DSFJZZ1FOdTU0L3YxQ0lwUTI3UGlqR21uSytk?=
 =?utf-8?B?QWZLbHJIMGl1MHJ6UVRrU1M2TTNwY1JDL3A1THFwOU9PSFVqMDArZXJKNWZQ?=
 =?utf-8?B?d3JwR3BGVFhlK1ZmcFEwNkh0M20vd01uREpXcklWOUpJYXN0ejhNR3g1UlpZ?=
 =?utf-8?B?TmRpSGdpNEdDaDY1ZC9ab3hRdWE4RWlNRnNVMnhia3ROREZQa2MyRVNHcDFM?=
 =?utf-8?B?aHVtTXhsSGlIMjJxSXdNK09LTUdUeWE3N0pVMzMyeGU1UHhlaHl0Vi82Q0w0?=
 =?utf-8?B?NGJTQ1YyeDJXVW1PVFlXRldXRGRQbFVyeGo3UndhY0d0aUcvcTNabzlvakI0?=
 =?utf-8?B?UXRCbkZsK0pSRmtwdUFZV0JRNytXelJ5OEJNaENiYWxPdmhqV0J5S2h3a0Ev?=
 =?utf-8?B?L1B0bVcySzA1Ukl1R0tUNnpqSXVnY3BGSTR4Wk4xWW1JRWR4by9ldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148ad411-cef6-4ace-20d4-08dee51cb4f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 22:34:19.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvHgklWlhNgL7b6cRojaR+pUXmBM6PX7vybB656XFX7ccGpGjvn2RZX/Ih6Zyr3JElofqt924qhpANDm2ICS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440

On 7/16/2026 12:20 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [3]: [PATCH 3/6] pds_core: add PLDM firmware update support via devlink flash ---
> commit 865af5a5208d8bbf12e2bc16faaacfc3c3239978
> Author: Brett Creeley <brett.creeley@amd.com>
> 
> pds_core: add PLDM firmware update support via devlink flash
> 
> This commit implements PLDM firmware update support in the pds_core driver
> using the upstream pldmfw API. It allows updating an entire PLDM FW package
> at once or updating specific firmware components by name.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
>> index 84ea502ecb128..b149d29bd2560 100644
>> --- a/drivers/net/ethernet/amd/pds_core/dev.c
>> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
>> @@ -206,15 +206,56 @@ static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>>        else
>>                memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>>
>> +     if (err != -ETIMEDOUT && err != -EAGAIN)
>> +             pdsc_deferred_dma_free(pdsc);
>> +
> 
> [Severity: High]
> Can pdsc_deferred_dma_free() prematurely free DMA memory that the device
> firmware is still actively accessing?
> 
> If a DMA-based devcmd like pdsc_devcmd_send_component() times out after
> polling and returns -EAGAIN, the DMA mapping is added to
> pdsc->deferred_dma_list in pdsc_flash_component_chunk(). The firmware update
> aborts on the host, but the device might still be processing the command in
> the background.
> 
> If an unrelated devcmd (e.g., from a periodic health check) executes and
> succeeds shortly after, this logic will unconditionally unmap and free all
> deferred DMA memory. Does this lead to memory corruption or IOMMU faults if
> the firmware continues to access the freed memory?
> 
>>        return err;
>>   }
>>
>> +void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
>> +                        dma_addr_t dma_addr, void *va, size_t size,
>> +                        enum dma_data_direction dir)
>> +{
> 
The free is not premature. The devcmd interface processes one command at 
a time in firmware. A (non-EAGAIN/non-ETIMEDOUT) completion of any 
devcmd proves the prior DMA is quiesced.

> 
>> @@ -227,6 +268,47 @@ int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>>        return err;
>>   }
>>
>> +static int __pdsc_devcmd_with_data(struct pdsc *pdsc,
>> +                                union pds_core_dev_cmd *cmd,
>> +                                const void *data, size_t data_len,
>> +                                union pds_core_dev_comp *comp,
>> +                                int max_seconds, bool do_msg)
>> +{
>> +     int err;
>> +
>> +     mutex_lock(&pdsc->devcmd_lock);
>> +     if (!pdsc->cmd_regs) {
>> +             err = -ENXIO;
>> +             goto unlock;
>> +     }
>> +     if (data_len > sizeof(pdsc->cmd_regs->data)) {
>> +             err = -ENOSPC;
>> +             goto unlock;
>> +     }
>> +     memcpy_toio(&pdsc->cmd_regs->data, data, data_len);
> 
> [Severity: High]
> This is a pre-existing issue, but can a concurrent PCI reset unmap the device
> BARs while the firmware update is actively copying data to MMIO here?
> 
> When devlink flash initiates a firmware update, __pdsc_devcmd_with_data()
> acquires devcmd_lock and begins copying up to 2KB of data via memcpy_toio().
> 
> Concurrently, a PCI reset (e.g., via sysfs or AER) triggers
> pdsc_reset_prepare(), which calls pdsc_unmap_bars() without acquiring
> devcmd_lock. pdsc_unmap_bars() sets pdsc->cmd_regs = NULL and calls
> pci_iounmap().
> 
> Could this race cause a kernel panic if the firmware update thread dereferences
> the now-NULL pdsc->cmd_regs pointer or accesses unmapped MMIO memory? The long
> polling firmware update that repeatedly copies large data blocks might
> exacerbate this race window.
This is a valid race. Since this is a pre-existing issue, I will submit 
a fix to -net.

Thanks,
Nikhil
