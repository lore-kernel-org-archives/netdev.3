Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F43F0BE
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784413275; cv=fail; b=cxxOPeNqy09LlObt0kflzhL4V3mFkRqVVJphubNkHXE4IM5AFcDw3Iweqpl3SeFE3ENlOQzb+UN1cb3lzOPgOnzSqBVUYQ6uxkt83C6EQx905xrai1UaV9rPzZeinQgwiJa9bM34Km196toHlQSsfK9Z0O3BLLl9lGMEFbNwPJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784413275; c=relaxed/simple;
	bh=dZanC2b7Ij/sEjy4APcdYwVD211Ql2IEuxHykQ+PFVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLHvzhOTMJUK0UByvuFYueV7gTf8LrGP1FHX38h1+UgsvxmrkT2R3stnjhmS9Dzj1p6yxlUu2yIWz5o0PVe2OC9eMIgUVajB1GhsiC6gAnEt5L3MgM8b26szitoVj0CpjGbWXE8Lq9OLBsAH4lj2DM8HuzcchrdGTR44jTdZyRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RkD/44xd; arc=fail smtp.client-ip=52.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RkD/44xd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8N1MOoEFpp8o71XF/b12FpMI4lmxmeAM/ty4MeseB8VsfS9Wws8PrbLODm2rVpE3hvSXHcpItjZRkxv9EuliM7HddkBjXCHPvDkdfZdoPJaPH+ObNzQMU/LHEp0WpydWbSZR5nN7YZ1/X8lQeXSI1MyHuGu2Qh+bo3PLwmuagAzOgzHShs018P2DdOQOKCQi/NYZiM2bF5FuUPi4kXnFr48MPcNA7JGOeVDPhUEDYKQ95KpZqgGbHLL9QNdT2Iuxl4s/+CKkvEyJhBVKV9SHH1hXOLtQN7KAtwvT4HZ/8UxkehPg5MTp/kklaj7eafJSI9BR8kRQxdDVS6fqeCaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azn05UdkvnHeaBCRvy8BdU0iSwJkovS63TvdYIRsZhs=;
 b=B/L31qxqJiwm5dsysN+hJd6FymzS4w5pI70tUlUcTh2NdJhqZ9o/zIZdhpV/VrWvvx5v1vvUNAGk/Mxx9yb3fK9A74Uw8ncFCR+os5JhtMKkrVXc1iHbFmCftXgm25j3HU6xCqu43ZLlmeJ4TbiysTy6lmq8NHseFu0LMuUr2+pZU+/EFMOT4C16I+EDGAHzJeDYWdCHC06FlvIPj3j5JgaaDeiG03Hqwv0AXS06hM3/tpoTdTbHT7NxHR7AFGY2zDG9E1fm9Hh9FxDjDs2lfOoi9uw/pE8sHcr03pAU79cbYPBgTpqWI/R+0mfEi5ztPi4+fsGLzXwyoGWJNO/weA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azn05UdkvnHeaBCRvy8BdU0iSwJkovS63TvdYIRsZhs=;
 b=RkD/44xd2nUt6vEVZj0A/1fxZY+yDpKWCY4uXdR7ZJpvePPD7OrXezzoPL2XWQzNhDYmMll18j/DgL7gVCNfafYV0XQ5fzpo1eAvm7ViYbq9vil0SMhgsWpNIpJrAgkCuPFQyxgZ5ADA4IE3bMn1MbmgNmqhKUVJBAsMJ5mvM9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.15; Sat, 18 Jul 2026 22:21:10 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0223.011; Sat, 18 Jul 2026
 22:21:09 +0000
Message-ID: <d88d1a0b-cc57-42aa-b2b3-7cab15f57ae3@amd.com>
Date: Sat, 18 Jul 2026 15:21:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] pds_core: add support for quiet devcmd failures
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 nikhil.rao@amd.com
References: <20260708212222.296202-2-nikhil.rao@amd.com>
 <20260716071736.179693-3-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260716071736.179693-3-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::16) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: ffea002f-0573-485c-681b-08dee51ade5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	j+KDndXYdZLYbC9yg/dPkZvPVFoz7XfmtinJZ86UIrAyxE1/3N0+RghGtat7TZsHnxVDiUbfY6NdbyiXAzvImWp6BzmE4X2zIzbWSDEbzd5MlO1FADZjbFs+khGxrjLinQRTCqUH+0lZxqqGuS54sW6w+hNoTi7oAN0tpe1lvdKM+ULQhcbwnSkejn5RHJPAS7vxv/5ycQCepSlKlXIG3vKaR9ZSgsGg3fxn7WTrG00Iis0dJjOriIAdkP4vreWXyeyIP0jYbIceCLw0i9O0QtyYDXyNGy9j4YHI3AeUBNf5zG4ictfZPAMEzuvDztqPWlxYhDEmCoQkvGxSmxnAmYcQgg8okbTT1OERbK74lipWXZi/qHlIH7alO2waHjiDraPVVgVZbGxXJkJv/aGK9fnMwCADC7Bt7ik+QBz025jhGKqfBwuCJytyCmoxM2QsFHqF/WCtM5ND5xBZXuimU4KNCYaUv/SadxErcBgYGZeOLkZtaB6IC4DbC3uTHhdMaU4umDd5r3JiTa+IOOPbQS+NPuvO9EEobDSvs4oU3Z4GSEr9e0ka/4qKSTzdaAkldKH2Xo39OOt0aGwAOOaa1UGzuLanr0mbWAtKQxyXMmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDVqejRqWVVIdGRoblM1WUN1dk9Yd1pkaUlBa0YrZnRuTkhRajFtWk5lSHB1?=
 =?utf-8?B?ekxpOUFUUXBlMFBPUjlNRWxLNVpJL0JReEZteW1VNURqbDU4Zkxjb3BMN0E5?=
 =?utf-8?B?cnBHV09OVlUzK29ZZkUvckdWdmw3YzQ5eUwxaEljSmRPTk5rakd6TXZ2UHJ4?=
 =?utf-8?B?Z1ZhOUxKTURaeHliK2RpeWdQSzZhNUVZbkFoamh4WnZ5N1J2WkFsYnhkSXNh?=
 =?utf-8?B?emUrMEEyNDloTTVqZEVRZ2FsaDFIbzZqd2kzd0U4OE40eVhJdFVHQndxUmpW?=
 =?utf-8?B?dWMvSlJOSkVxeTE1bUhuK2RFNEJobVhPSE5ndGxSU1FrYVVrdXc5SmdDdFkr?=
 =?utf-8?B?a2F1c0tsRmFxKzhrYTQzUFBJR3pqS3RVWkJ3dUZNbVduOHpkR0tVbDg2aDdW?=
 =?utf-8?B?L3ZGeVdsVk9hR20vYkdoVk1Tb01hMUhhRndQMG5ScnR6a0NPdDJFNkZoWnB5?=
 =?utf-8?B?TFhNb0VwUmZNTndiN3RYY0h1dTBLdWFxNnBkRDFnbWpFYUdoOFZ5dGlBMHNi?=
 =?utf-8?B?K3NUL0YyMnpPclV0NW5iNHhuSUR6UlkxV1lMUDZ3dkJZUmN6cHl5QXR0TVRV?=
 =?utf-8?B?eDgwYjV2cFFUUHd4VEV1NzZHMCt1KzBBbkRhQi9tbGdFMzR0N1hoQlpEMldL?=
 =?utf-8?B?NkZYZ2dJK2NYM1dITWl6ZlgxTm5YQi9yOGVsa2hXNW1kRlUwVXNYbEtVcDcx?=
 =?utf-8?B?Rjc3RzhYNkxDY3BhQmpSc0lCU0s2SGFla1ljWXpUb2lSTG5lV2hCbHo5c2dO?=
 =?utf-8?B?aGswU2c3WE5lTVJHUm9mU29zVlZsWCtHUFV2R0xXT0RDeEk3Y2hPZ2ZSbFJO?=
 =?utf-8?B?WFZFb0o2MHQ0S3RSNWtzZC9lUEpVY2EvY2JROVZmUW1MelFsT0llMk9uN1g1?=
 =?utf-8?B?Rlo2dnlPYUhNNFdkZS96bkx6d0RySGRUVFViMVFDclFUVjRvVlo0ZUNjNXNX?=
 =?utf-8?B?V0hLQWNGRHUyZFhmeXJ6RjNneEJLVmFGZ211Q0ozb1had3h0QzROYksxY2lT?=
 =?utf-8?B?Nk9aT05UamNUQ3RlbDhEanRZaGtZdnRsYnREVlNBL3FwUFhUelYxbWowMXVU?=
 =?utf-8?B?WVZHbmpaYkpWYmRGTVhMSk1XeDRFSmdzdnFIRWlsYnFWM1lMSnlwN1BrUVlw?=
 =?utf-8?B?a1hxNGFNb0RwWkRPS3Y1cWVScFJqL29pNi9lckhlZHVPUVZXVGpmaUEvV3dT?=
 =?utf-8?B?TG1LMlR6aWhUUWlucDlMbTlsUXRlRTNET0dGc0Vadk4vakVmcVF1MUFrNC93?=
 =?utf-8?B?Wml5ZC9OODFkQ2R5RFNRb1FWWlVNRENObXZURFh4WG81YWFUdmlFdWJtOW1p?=
 =?utf-8?B?cVZHYXRibVE4MGlDc3Q5d2ppZkFyUzFWamFyR0o2ZG5jYjVsQkhwY2pkclhX?=
 =?utf-8?B?VlVyMGZ3Yk5XY1RZRksvY1lKejExV1drK1FtcXhjRVA0c3g4QURNSis1UlZm?=
 =?utf-8?B?RUNvSFV3U29UdVdnNURIVnFFamlFNUNZZHIxWVRWRG4vRUxBT3BqY3JFOEkx?=
 =?utf-8?B?T0ZQQWNROTM4OXMvR0hwVXhGdExwY1Q3dW13cG52bWlkbFF3TFo1VW9xVWlw?=
 =?utf-8?B?YkVlZXlqT1FnWUFWUm93V25BWExOOWFaWjhWME53QjdEc3BTc2NieEc1eXdS?=
 =?utf-8?B?eU5udU85ZjcwYXFoYW5kcGtzNTNiT09hQ05kUmJMTExOL3M3dElvK3hWbHdy?=
 =?utf-8?B?djBUT2dnc043dXJyU2ducXhxWXdjdDF6RmY3b1FyNjk1YmdPTVd5bERiYk84?=
 =?utf-8?B?MFN5a3dxWG10SEs0QnY0UXNrbndBZXl0dldSSDhvQXQwVFdUR2dzejhFSXY2?=
 =?utf-8?B?N3cwZjBVZXdBMnF4cEl1ZmtrUzNSRUF4aG9qbzR5b01HdjkrY0JnK0lDcmlF?=
 =?utf-8?B?VHJLQjM3bHowSVNMYzlEZ2w0eGt6TU5QMXVzZ09LbXc4UU1wNXkzSGxPUlA0?=
 =?utf-8?B?N3V4K1ArR2Rmay91UC9WamduZmxqTld1S1VlMFNYMVRiQ3NJZXFqSXcya29X?=
 =?utf-8?B?eU9KMHJDaFFtOGNwNllJMkhZb1lUREZWSmVEdVp0ZnlQZS9ZTkppQVJRcXdw?=
 =?utf-8?B?VFVxbHM4eU1uV2pJcDFjQmJKK0R1WVRQSi9TTEwrVnZhbEVZM0dNNDBxeVEr?=
 =?utf-8?B?V0J6WkpXMnM4OFNnV1d5dnIwTGRhM2pyN1ZlRGRmTDEweEVrdnI4ZVN3dFI1?=
 =?utf-8?B?bkJhdGRlWWk4VzN3eStSaEd4bUcrNVZKVlBKbzVxQnFDeS91dW9KWlM4VnpT?=
 =?utf-8?B?TzB4S2QyTGFFMDJCM0VhN0pqUytnY0MwWDQybnFqa3FuTFZxYnB1OGpJcnBo?=
 =?utf-8?B?SlV2WVFPOUR5UUVwbXpaNWRnR3RwQzRoMnZkOFYwTEFNcE1CNSt6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffea002f-0573-485c-681b-08dee51ade5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 22:21:09.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StUTILnlLGANoGeqR+KPV2WZewlNRTupijLY/sT5tw+SYtbOmg16WiFC7s3wz55xfZBYLPgM38FgJavIZVcOBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271


On 7/16/2026 12:17 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [1]: [PATCH 1/6] pds_core: add support for quiet devcmd failures ---
> commit 2618e77f5d1aae31c9817f09b5056a69e237162a
> Author: Brett Creeley <brett.creeley@amd.com>
> 
> pds_core: add support for quiet devcmd failures
> 
> This commit adds support to allow devcmd failure messages to be suppressed.
> This will be used when adding support to negotiate
> PDS_CORE_IDENTITY_VERSION_2.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
>> index bded6b33289ce..dd9989cfe6b3f 100644
>> --- a/drivers/net/ethernet/amd/pds_core/dev.c
>> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
> 
> [ ... ]
> 
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
> [Severity: High]
> This is a pre-existing issue, but does this error path trigger a
> use-after-free during device removal?
> 
> During device removal, pdsc_remove() destroys the workqueue without clearing
> the pointer before invoking pdsc_teardown():
> 
> pdsc_remove() {
>          ...
>          if (pdsc->wq)
>                  destroy_workqueue(pdsc->wq);
> 
>          mutex_lock(&pdsc->config_lock);
>          set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
> 
>          pdsc_stop(pdsc);
>          pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
>          ...
> }
> 
> The teardown function issues a hardware reset command via pdsc_devcmd_reset().
> If the device is unresponsive and the command times out, the error path here in
> __pdsc_devcmd_locked() catches the -ETIMEDOUT error.
> 
> Because pdsc->wq was left as a dangling pointer, the condition evaluates to true
> and execution falls through to queue_work(), which will dereference the already
> destroyed workqueue pointer.
> 
> Could the pdsc->wq pointer be set to NULL immediately after destruction to
> prevent this, or should the teardown sequence be reordered?
> 
>>        else
>>                memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>>
>>        if (err != -ETIMEDOUT && err != -EAGAIN)
>>                pdsc_deferred_dma_free(pdsc);
>>
>>        return err;
>>   }

Fixed in [1] by reordering destroy_workqueue() after pdsc_teardown().

Thanks,
Nikhil

[1] 
https://lore.kernel.org/netdev/20260714180223.1642792-3-nikhil.rao@amd.com/
