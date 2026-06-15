Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA483313272
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549638; cv=fail; b=FF7J3a/enoZOb2w+zCBUcpUxZazcJTf1BWIf2lCw641fPhtTDfqrCcS1oHOBPahlcyVJBH0LHHG2VDWsC5Ymfst90sNqCObu0g3rONATeAzDNzRRzStCbuyrIJ0I0CuvHmMAWU/uoZbz6+6JLQKEDWo2zMs/8aRjJuP3n2Xyq2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549638; c=relaxed/simple;
	bh=SMPfvsVS3bwPASvjifJqit1ZKY/x2q3XSd77o+PfLhw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KKEPN1CQFXor6/J5ceOROw+MOaDVmO279WVQPuzK0myyh5m741Pu+WYHi/U4SMClc6irULVHHZNMAPn3mcIndv3gkmDa99Ntz+6Fy5nSMYLixpyz3Q000149V1YpFGXYgiJFZQH5//JW58xRviPlgujKaSS3TRae2Tqt0+26a2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A0y7R5Z1; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A0y7R5Z1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOlUUsUghK8tozAAscVKqO6U8U79gpaJnOt+1+gFMdWsjkpbLUw+y3BuIqDnToi/vPOQGOXW4Ul5kZARf82tVuTtuIPDRoDTUcDKn8mXStgrFg4lGFjXrDe5HyTeaQJSwocbaqWSX5DaVVd01vpGw9k4brKus3EdYdvGFBqiQ52tHyjTYd7A+vhL3sT+WV4V6sUHes4d8LU6+7Ysfu+1mx2+a5GTUDYaZSW+e8VkjzBPKxzRqixKbinrOIuHvQ3pGtt+5DJ7k7ml+gNcfLQJrvEcOYfdsxMtKA6ZbpNXrzxEjvaKW95Kw983LJMkfeXPi/jaNFZOm3dqXyo7K2nxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bytst92IoyAXgldfeiwMlXpzw58pBBW2+HMAs65ALEY=;
 b=vYYLsdml+gQXqkNWObyRKGeyKiPPYzzD+akZqa6KtDzVv62fTTlMqBKN5W3Y5uXWsPExPmJGXND7uCmegVdnZm4Y3O0ZpF59g5XiyVe/lWSfVhyLJY6d16DDmmhwFxEwVnexAifWv5Qqs+NxikdK0PQdTB/hgxJvqd9RXZWSgUntxa/L8BHmY/QZcRR/jvcSG67+qySbxrSm09j60RDo0qqU0PdSuQIoI8XTi5JXbKqFuZvyJkLPjuXlekgygFkX5FYjVxCX7IYd7Uc9jEi5OpwmxvjeAI9dYJCD2j6XJeTYwM2YobOBD5seL3ZXS+7Wz40zcM/uIFD6OyPJn6AyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bytst92IoyAXgldfeiwMlXpzw58pBBW2+HMAs65ALEY=;
 b=A0y7R5Z1H6aCZpIZgpfKyjYqwau/jeFdsBgmGeX7yraHX52PbRFhaliUY3UZhzWgzkIzO95eyJjaG9ia1JJpGDDwAAF87g3hWl9AmD54VtsiLKfBgfLtwVElRHxlGr4oHT2s1TXku1Br8ALf81ghfoZ4bYZtHGfNI5LoDnqpqM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:53:54 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:53:54 +0000
Message-ID: <8ac935d1-664b-4a70-a2e3-dbc6a3bc7243@amd.com>
Date: Mon, 15 Jun 2026 11:53:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] pds_core: add support for quiet devcmd failures
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, eric.joyner@amd.com, "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260614050052.1048328-2-nikhil.rao@amd.com>
 <20260615153400.772876-3-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260615153400.772876-3-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 164b6314-e664-41b6-27c3-08decb0f7223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|5023799004|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	zJuUeRQSkDZuzybR8eK8WNuWn/Wc+ZkUIh02Jsy8sIRiX23rCKJMdu9/eq7sjTx+PMO8io5Hn7Sa2cBCXJUsNSwjxs0614625GE3kzUTDv49LUtvetkO2XyslYRAJXKacILs2w2waHKAQeGyo322BDd/T6AKaTfPCCqq4ysAHT9+JqL+6JjXKFHs2wzsZ7vhFtKlANGsrKzyBFB5aPQVdDUunGwqOQJvqY963lR6lY+QFW0OChQLS7+miup5MisBjJeJ4WZoVypUlQAwL6UIJjcmhdh/Nb92PkyOF4yCuoUDH/JaP0aJbRofLAZqZeBH1Ez3+MTuvsV6aaFnBzGLFIU7KkPkLflD6P/H00VUdMNSkCCci1CABIWTNXYaHGuxvUeReP2xJeahLQRvtTqta0r+DTbwYslAgen86I4+Fj7qbsGKKS6/HDAxIeVyDczRqkbhSQv3iDsFn9sgNZEVrVkSpYcUS1xE+pIdeoHnApy5H2OUZzi1OTrqDNqg5Qb31Ta79eY8+T7iXmxdC3f0GPiOQqucvoVmcB+VguEq00O8GWBwpM1gTuy947uUi4Y/n8aTHSpbGlw/d/hlZPbtuEr8Aglne1Rfgp7DFJZ1/w/IqfZc6skvpaGKPnfC7Jcx49Bvjj+HB61r1CeG2PpiTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW5VWkM2Q3BPZXIySTlrTDViUWlvOWk0OHFBTTBaempwZ1hvdkxzeWFvY3cy?=
 =?utf-8?B?clZ4RTVvQzdaait1aVBYTVpuRG1wN2J1QVhUYld5Skk4OCs2TUJSY0dPZ3lp?=
 =?utf-8?B?ckhjZ3pidm1adlhVZ1AvTUoyQ2g1dmZEeUVXQTNLelV6Wkg5alFTT1djY2xX?=
 =?utf-8?B?UCthSUFLZGhxeEZIU2wvcmQ2aVFaRDIvakIyVkVMc3o1dHVwRDBvMDFCZXhy?=
 =?utf-8?B?cXpGZmJ6NDhkc2cxV2xNdERUaDNJMUl6VWZPVklUMXdrS0FCYlBvTUY1Z0xS?=
 =?utf-8?B?MEtxOS9qQzM2TkpYZzNoWitrQ0VvMlBUNmIxTWdMTzJBeThmMDhCS0dzR0lz?=
 =?utf-8?B?aHA5bm9JZXBUVmRtRDgzMzBlOVo4ZXZNWjdrZjlnRExnTDVDTi9EWXBWdGw0?=
 =?utf-8?B?QzNIOFFmOS9iRHVoUGpIVDQxR0VzeXNCNzhnYlhaQ1JhNEpudmZNK21BK1lp?=
 =?utf-8?B?SG8xNnZKYkh4RmRVVnArK2lnZGF5UW5MclRaOEd1OHhocnZJVzAvRnBjVGxX?=
 =?utf-8?B?QlF0ZGI5dC81eHhiSCsyRiswbkhQSWNDaTg0eFNKTGp5WFltQUszdmpETktG?=
 =?utf-8?B?dit0ZVVxeWVHaDZZcFJEYmNQaWZGWk1nMW1ENDhEWmtYRGZZNlFIWHhhQ2tl?=
 =?utf-8?B?K3JraGozUExGdXpaOEhSOURUektWMmZWcHlxcEw1THVFeit1QkhvaE9qbUJ1?=
 =?utf-8?B?QzJlY1o4TWZxeFdKVEo1aUhlcUU2ZElNOWs3blBja3ZwWmlYRmpJUmJFM21J?=
 =?utf-8?B?ODRjV0VmWnF5S0pERHJ3cFh2MldoR3hucHBFM3I2Y0VHM3ZOKzFxL3pDWFY1?=
 =?utf-8?B?OFVtMVZ3Qy95ZE1qVVgvREZEMllSUUllMm1CWi9Td3loMkxDd2FPY1QxUFlu?=
 =?utf-8?B?R1FyVnpwaVIwemxzM3VzOXBWcVZlRXh1a3NwV3J4MGdSNmUwdnQrU3Z6Mm8z?=
 =?utf-8?B?WUREenFyUmhldVpBVHBHL3c2d0xCcDFmOHZEbS8xV1Q4M2VGeW5RSlBHbjJh?=
 =?utf-8?B?UXRIMTd0OTYyOXE0V09VeHQ4bjViaVA3WlM4ZHlGK1UzazFIZkNOK1Yyb1U3?=
 =?utf-8?B?TDd2Nm43bzUwWlZYWGlyNGh5bllkdk9CZmRlVHFkd1F1SGpJaDhWQkE2VytN?=
 =?utf-8?B?cmt4Qy9LTXVWdVZtYkZQa0c2TWRjTmhodURzQ084U3ZrRnp0UHY1d2o5UXp2?=
 =?utf-8?B?OFQ5YzhVbU5QWHNRVHdkTlcxd2JOMVhPTStubWgyM2x1NFlWM3lzOG94QWkr?=
 =?utf-8?B?dzBSQkxtZm5MdTk1cjIzbjZmTGI5SjVYblJST3ZsbU02M2lwcGkwSU9lL2J6?=
 =?utf-8?B?UWNIN3pGUWM0TTdkczRCYjdHNXdUQXd6TXM1UFpXcWpnWXZsQnMzaDNIWGd6?=
 =?utf-8?B?VXMyYlpPdnA2cUxtTGk3SzBRbkVCTUduWk5vd0pXb3Q0Mk9acFB2YTVEWnE0?=
 =?utf-8?B?d1RXdGFoSmwwMWpPWDFRWUh5Z1BKSWZMcHFFVm43MU0ySVRPSkNlYkZMZ3VG?=
 =?utf-8?B?OXVWMVBOdldVbm1wdWgwa1VjbVFOYUhlK05rcjdHTUFIWm01M0pwY0l0VFRY?=
 =?utf-8?B?c3NiSFU2MVNvRlArTC9Bc0JyakxYRU5tQ2wyR0RUMkw5WXBGYmxwSzhpVHVs?=
 =?utf-8?B?WkVUMS9NLzZHQ0MyV0p4c1VmYys4aDRJZHRvTGkvU1Q5NU51RlVSMUpyMGpM?=
 =?utf-8?B?c2dVRHI1VWc0a25DYnpESmlPWFh0WlQ5NENtVUNQYTVBdHc4bFRtZDlCdWtK?=
 =?utf-8?B?V0ZZWm5teUQxNDZoTTBjMW9Xb1RoMmxTbmRIeUpRRHpkR1IvejZBRzZZaXZm?=
 =?utf-8?B?OGhXUnUzUkcyRlhZOHZmdmlYL1hjZ0pTU1l4MGdRQ2RKemRGaUZqd3BTZ0pj?=
 =?utf-8?B?Q3BTL1NyMnFMdGJ1TTdQWVpJU1lyZ1hZSXFyUElIYVRlM0tlcTY5cE1ISDF4?=
 =?utf-8?B?czZyaTFMZVh0QVhlbmVURk9wUkM5M2pkQkpZVEhxOEFzY2c1YzkyZHBOeU10?=
 =?utf-8?B?Y0JucWNlQVBXUTBTN0YvSW9qcXQ3T0lMUGN1K0ViN2JXb1lwWUtNZG13cFpO?=
 =?utf-8?B?WHBOL2YyRUtKUzROZ3Z4eVF3a3pkSFhKaVJHSkZ2ZmNYZzBrbEZmZTZiRDI3?=
 =?utf-8?B?Nnh5ZUkwVlA2TEpYS0lMbWRqY3grcXJOQjRXQWppNGhkL3I0MFRCbjlxM1VF?=
 =?utf-8?B?bkhXMnFIMXJBb21MQ1JxZ3JYd1dxVVZOUkwxZXRYamRjWEdoZmdYVTNZclFv?=
 =?utf-8?B?LzFDWjM5QXE3OEJLRk5qeXpZZGcrZG96aUNzRE41ZUh4ZVlzakdzNHFQY0Zn?=
 =?utf-8?B?WXJrSW44ZE9jQWdKbkpGaDBuVG90S3Axbkc5eWYzemRGeEM2V0lTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164b6314-e664-41b6-27c3-08decb0f7223
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:53:53.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wa6x/vgsOcnCroK81LEivWV+jM0CCzswR0WzVB039rSO3JAdqxTHwEJETA7Pv4willN0kbwxJCCDvTcUNMr6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399


On 6/15/2026 8:34 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> pds_core: add support for quiet devcmd failures
> 
> This commit introduces support for suppressing error messages during device
> commands by adding a boolean parameter to wait and lock functions. It changes
> pdsc_devcmd_wait and pdsc_devcmd_locked into internal __pdsc_devcmd_wait and
> __pdsc_devcmd_locked variants that handle the new messaging flag. This
> functionality is intended for negotiating the PDS_CORE_IDENTITY_VERSION_2.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
>> index bded6b33289ce..dd9989cfe6b3f 100644
>> --- a/drivers/net/ethernet/amd/pds_core/dev.c
>> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
> 
> [ ... ]
> 
>> -int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>> -                    union pds_core_dev_comp *comp, int max_seconds)
>> +static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>> +                             union pds_core_dev_comp *comp, int max_seconds,
>> +                             const bool do_msg)
>>   {
>>        int err;
>>
>> @@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>>
>>        memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
>>        pdsc_devcmd_dbell(pdsc);
>> -     err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
>> +     err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
>>
>>        if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
>>                queue_work(pdsc->wq, &pdsc->health_work);
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but it occurs in the function
> modified here.
> 
> Can this queue_work() call trigger a use-after-free during driver removal?
> 
> Looking at pdsc_remove() in drivers/net/ethernet/amd/pds_core/main.c,
> destroy_workqueue() is called but the pdsc->wq pointer is not cleared:
> 
> pdsc_remove() {
>      ...
>      if (pdsc->wq)
>          destroy_workqueue(pdsc->wq);
> 
>      mutex_lock(&pdsc->config_lock);
>      set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
> 
>      pdsc_stop(pdsc);
>      pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
>      ...
> }
> 
> Subsequently, pdsc_teardown() issues a RESET command to the firmware.
> If the firmware is unresponsive and the command times out, we reach this
> error path in __pdsc_devcmd_locked(). Since the pdsc->wq pointer was never
> set to NULL, the check here succeeds, and it attempts to queue work to a
> destroyed workqueue.
> 
> Should pdsc->wq be explicitly set to NULL immediately after being destroyed
> in pdsc_remove() to prevent this?

Yes, this is a valid bug. I've already submitted a fix for this 
(Message-ID: 20260610025952.196470-1-nikhil.rao@amd.com)

The initial fix sets pdsc->wq = NULL after destruction, but sashiko 
raised a valid concern about a  NotifyQ ISR race window.

This is a pre-existing bug not introduced by this series, so I'll submit 
the reworked fix separately to -net.

Nikhil
