Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64661386C9
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416017; cv=fail; b=M/j+4by7Sf0m2dU6+3gtrSmIcGX0NC52NSGVEUvKVkSaz4PBWp0ZPcOI4nurZOwC61W4wrX7fp8o1YoMqmBCBvrpuHoBPiFljGK8nSDR+KawuSDR9tmVoLr4WiABGBpJAc6+gXsFFwVrL6LQG74DK8yPoYXHrJ0R8ZJHJ+gOUK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416017; c=relaxed/simple;
	bh=iBVAJIMZ76OfsM7zw2UsLu7TJ2YBtOd5jc1SYS1k3cw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s7ow8p4fZTjxU4kyohUXZAeVKUuzX93Ot2tb9sdBOqBLQc7KL3PnK5iiTG6ooHm58xhcMTIT4cYoaOC3XFEREC930Yx1uyJHP2wSyaE3VZ8FK5mMRBR6tCokNOdklR5uF6fcJkjCcGsAxXdlGZZbX73cyQqviK1gFEAd/ixgYpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zh3HzITB; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zh3HzITB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqYxDP3CJl+b7TwzIlehTueaCW8pXt64GqDQ4roEZBgoN4YGQCkCPAjHppLJmQIpoCYRFNJmq/PZpP0Ba5j8u7UV4OhofrKBoggq61OuDI9HQxXbfmjRtG+aX1iMykdDWWg6JARYI5ZBid2ctClc1BMivVlEW/z/faxwVjQLBJv46rL2Bldd6zSnIFxQVCPaKjXJpS3SRnE4ZArh1oa2jX03NQWTpRRMB5Eon35fRs8PJiX6vpRP5K4sedhxFojXk0KvldUVO/uixfpJXlgfHKYF8qtvF7GxXjQKQfwh+US/rioNB3GmuR23Zc9H8xNnID+l/NiH0gk+n8GuE3gcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8qIy90L8h94jgDDG3MzK3EdcC2/ZqaeYEKphura928=;
 b=GdGRtEMFNrlgnmnOnuLYtsXVsR+sv8FgZvC6Hjh9ZHLlEw1Yj3eweBMLAwr04BPxW1b/+Hxdtrlt8jnFw7sn2JtypdkZL/5Nd5pdkEE8vrnK8i8/vHkuWJjhZ5KVZhubZUuBdIjkqk2sRydfU+VdIxLUL5x39oacOD/1RujlVkjvhqkSURV9KWU8kjwzQJ4CnHSzuLgsBYrnUoNqnR08G+WFzr4eXIFtE5FuMsPZPzog7GL9zwaxksUHGohqpAsRpH3SYF1Q91J67POy6Lv62dKuk+eOBCFiGx8LGyntc1zz6575N9dK2KjjxE5KUdF2EYi0QnSfWOyd9L1YUqBQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8qIy90L8h94jgDDG3MzK3EdcC2/ZqaeYEKphura928=;
 b=Zh3HzITBryaM6DPJ5h8VakDo/cCWoOJ191vCZ+0EFOvf/7gSg1MHQroO/xhamrfAXHjEH3of40DAraIpeKiU3E7VxT3MUipi9g3KsvBWr2a5WOq6F99BZh1NJdW2RRBpqZFbQkC45DSKOUZtttDHXojqBD09TWFzw3F7sNrtU6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sat, 18 Jul
 2026 23:06:52 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0223.011; Sat, 18 Jul 2026
 23:06:52 +0000
Message-ID: <321585a9-551e-4b5b-aa96-3fbc29aa65e6@amd.com>
Date: Sat, 18 Jul 2026 16:06:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] pds_core: add PLDM component info display
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 nikhil.rao@amd.com
References: <20260708212222.296202-5-nikhil.rao@amd.com>
 <20260716072248.190353-2-horms@kernel.org>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <20260716072248.190353-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::18) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SA1PR12MB999085:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8ef522-92e8-486f-a440-08dee5214126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10063799003|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vVXhPAmzL17ll/QEx4lfjA+zymEZ1JAtrrtjZih+dit+sJ6wyXVjylO+18g/GkEBQmCuL6tUOwLfYyROc5DBPCnOh9wrIbI6YJ4GFqVqYMYIyP8XEGXv+ZIc6RAwupu/f+ezt2dQ1XADUVMSXXg+h4FYSq8fZjnT9wmFgnCw6xYrnwjSO8yygPFGF7+SIEDAE67wOhe+ebp5mAxaDg63Lf26WyANV53tvtv7olAqodn0ZytXsjDFbhoamyGWFvrRZXMqZPTrY3qsXLSfQ1feRg+EM1YqSKOou8+XT0ugFzPTVq37bT29WE5YMkQ8x3kYiQnT4H86OFXhxHobkxPj3G8VrYXxXt+Mq3iTbCQYEvj1UJ5D3Zw9aoQIbduSai0HhvmK9aoTzL3M16KNOt7kF6Ip5WNDkNlB/XvWsCOzBERfXH9vrjx6bRpTBWmNZIuj3gnn0tuZ9gzuRXTjvHlVHDPvazvd0geJWOgUf/PCOBc/P8lXEDniROGyz1q+WemIi6SbMh4yOtStq5Uwzz+bLMzDdFHtXNybpvVBpOYMZpNfwKvbUXggKBp/Nd1EKKZRvMp4Kboxile1k875+J8B8yQSeRgnH9+65HaOFF3gOPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10063799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFlaNS9PT0ZhbGQ0NGFxYXc5NHNrVWd2eTEvek5rQllKMGhVUmZqTURPa0Jy?=
 =?utf-8?B?L3pUK2xDY1lNU0g4QXZlNVdiQVhkQmxTZ0FERXk1MDg0Nk1tUDBrenhCV2Za?=
 =?utf-8?B?M2JHTnZqSmxKNkw3NFFtMEFuMFU0NUVQeW5jQlUrYUdCZ2FKcnNqc2paN3JM?=
 =?utf-8?B?UXlZZEY2bUp5RXZzT01JY2cxMnZuOW1URndKN2w3RkFLREJuMXdWVzh5bjNq?=
 =?utf-8?B?cTJtbjNJd0V1L2h6Q3IyMEJ5R3RueDQ2ZTl2aTRGSTRxUHBOeHp4NW5tdTAz?=
 =?utf-8?B?YXMyNW1IQndSTDVZdUpDTXUycURuek1SMkZpRDhVeGd5bHZxN1A0aXp0TVVE?=
 =?utf-8?B?TXRYNlMzeG8rcE9oRWQxMnkzVWVMWmRaN2xERlVIWWNHaE9MUkszT1VpQjZC?=
 =?utf-8?B?RCtGRDFyMmxxRWllOUVUb2gybjVYSzlaSmlteEJYNXhXVUNvNTFadmlrcGk0?=
 =?utf-8?B?anlaN2FxTytra2VYaVJtbE1XbHljMnNSWFErZ2I4NXZMZ1pTZ0VGSWRDSVAw?=
 =?utf-8?B?ZStkSlpEbDdnRHhnUHY3RkdnY0VZQzRmUEZSWS93OXMydlF6TEdOaitaalpx?=
 =?utf-8?B?R0swcW5CaC9sUS9kTEdzYTFqNCtld1ZlQjNpbUZHaHJWRkd2WTZTV2RUU0l1?=
 =?utf-8?B?MHRsNVZtWHNJYk4rNDBqT1FDaGI0WEx0dWRKRzJTVDlSSFR0cmhQRS80ajVU?=
 =?utf-8?B?Q0RSWXBNZ053WjVMUE5UckZ4TnIrVzdwdGpKclFBYTlHQ1owdnR2VHpBK0tO?=
 =?utf-8?B?NTFOUWo1L213aEsyVTVhWWdTZjRQVktVaUtZQ3VXYWVCdjNVVUo5SjQ5bVhN?=
 =?utf-8?B?R2wxSDRSUFJiV3RVUXlnU3cvbkZISVFsUUg0UE0xVENtWWJQRlRkcHE4NGph?=
 =?utf-8?B?SFMxSjJ1cDdBSEg4ZFhvazN5dDNFUGdhbVZmZTBUSjhGV1pWcm9zNlFKOC83?=
 =?utf-8?B?cDFFSnZEaVA3MFYvV29mU3Vnb3lTY2hCUGVSZkVmVkNmdEFjT2lLVEh6VHRu?=
 =?utf-8?B?aEtVc1FyejVXdlhabG9BT0MyTjVaRkNseGo4NExWTWJva3ZyTGtHaHFTS3dF?=
 =?utf-8?B?aU5iaGRCa0FMVjB0U0VybmdKMG5sMjloR04xZzF5K0pmcjdBRzlmOVRjTzcv?=
 =?utf-8?B?L0NrSlY0ODB6QktySW1mTWRXRGhQWU1NSXdHTEZ4WTJ5RHFVQllsek9UOUFJ?=
 =?utf-8?B?UDAraktMMTdDTzR2bEVFNDg1eUpQQ0JWVXd1RU56dHBmQVFzWGpsWHhZbmRJ?=
 =?utf-8?B?SUtPNFB4KzJWeU1SbVRFUUMzRTFJeXZBdmZTZWZPZ1RvVTNkNVZ6VSszbWZN?=
 =?utf-8?B?TitvSHNzbXBjbU50RnVjczNaNWJVS3AzQkp6eTVLY2JQaDJRMG1aRXE2c1Yw?=
 =?utf-8?B?aTBpTW5HUFFQM3hhTmtVTmxQbUlTNC9KeWxsd3FSWXRUYUNEMjdSdWRZazNB?=
 =?utf-8?B?QUR6SnRERlRIZ3pOVlJXNjkxVHRPeVBDRUduU3d4YUpyZHNQckxVQnFFQ0NQ?=
 =?utf-8?B?RThpd0lPdjcvMkFTeU4vK3h0R0dFTzNsKy9GY3JtYUtGTENiRWRxMngyUGJU?=
 =?utf-8?B?OGRtTFlRVFJhNWtiblNzeVdhQ2RLOW5RU1dGUm1ZRzFZL0hxaXg2UEttMWtW?=
 =?utf-8?B?U3kxTkE4QkRsL2RCdlFGdE5XWUkxRHBRbmNTSjB2dHE4OHlVZlFaZFp1amdq?=
 =?utf-8?B?TUd6NXZFR3JRNUg0WU5aVVo1bDR1cnNjR1JDTGx4dndrUXlsSXZhOGZHcndk?=
 =?utf-8?B?SVRjS0JhRnc1a1BndlJMUGxzQmJXWE1JT3h5UkVZdFNZenFDYXYrZG93dHBn?=
 =?utf-8?B?Q2FaZytUdnJ6RXZINEpYNkloY3QrSzEwMCtmMDhCMzN1TzBZNVlNSU91dm1M?=
 =?utf-8?B?d2hIWTVucjgyTEkya29LeGdvT1dCd3VidlJ5ZVBzd0liUnZyRExJLzVoQTVn?=
 =?utf-8?B?UFdCN1BlakF5RkRDL0R4aU5YM09RM3ByVFpxWFRKT1YvUGwwWk13dlhPSU9W?=
 =?utf-8?B?WlJXbW9hZ1dhMVFBZEI1dko2MUVLZFBCdE9GaFU3OTJwMGhuTFBzcjc2VUFa?=
 =?utf-8?B?Z0Fmb0JyaEZKejBCYzJxZlBXNlRpczFLSmVraUV6emRZUDA5elQ4SUN3R3RB?=
 =?utf-8?B?azBsU0NQT1h0Y0FXZXgzY1oxd0dveTRRS3R5MTFPdzRUUThuN1kwOVNwNmVR?=
 =?utf-8?B?TEVxSm8zZWZJQjVJY3hlMEJWRnA1eGQyRW1Pbys4Wm9oYUtGbmZUQXNBVkxR?=
 =?utf-8?B?N0JIc0NLZkRZMS83bVBXZlRwcTBKMXl3YUR6NUxNeXB1Mm9aTGxtdCtoK3l6?=
 =?utf-8?B?NVZyWDF4blV3d2FZOFRqMTZSUGZHK0JrMkpiVCt2eS9GcmlYZ1d2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8ef522-92e8-486f-a440-08dee5214126
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 23:06:52.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZraTfQ/ZaiaoEDZ7f/0BttJ/xDLc/ookhB4zvV16C60I4prfQ7kPVFtL1TBQEHrwTmyF8Hecb1sFLfX6IXE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085

On 7/16/2026 12:22 AM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [4]: [PATCH 4/6] pds_core: add PLDM component info display ---
> commit 4d0cc8aef76c7e2e30f98535495312200941b646
> Author: Brett Creeley <brett.creeley@amd.com>
> 
> pds_core: add PLDM component info display
> 
> Add detailed component information display via devlink info. This
> allows users to see individual firmware components and their versions.
> Components are reported as fixed, running, or stored based on their
> firmware-provided flags.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>> index 3b763ee1715ee..63fe45e91f710 100644
>> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
>> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> 
> [ ... ]
> 
>> +static int pdsc_dl_component_info_get(struct devlink *dl,
>> +                                   struct devlink_info_req *req,
>> +                                   struct netlink_ext_ack *extack)
>> +{
>> +     struct pdsc *pdsc = devlink_priv(dl);
>> +     u8 num_components;
>> +     int err;
>> +     int i;
>> +
>> +     /* Pairs with WRITE_ONCE in pdsc_fw_components_invalidate().
>> +      * Use READ_ONCE to get a consistent snapshot of num_components.
>> +      * pdsc_fw_components_invalidate() can zero it concurrently during
>> +      * firmware recovery; using the local copy avoids iterating zero
>> +      * times when we already decided the cache was valid.
>> +      */
>> +     num_components = READ_ONCE(pdsc->fw_components.num_components);
>> +     if (!num_components) {
>> +             err = pdsc_get_component_info(pdsc);
> 
> [Severity: High]
> Does this code expose uninitialized memory to concurrent readers?
> 
> If two threads execute this concurrently after the firmware component list
> has been invalidated, one thread could enter pdsc_get_component_info(),
> which updates the count before the array is populated:
> 
> drivers/net/ethernet/amd/pds_core/fw.c:pdsc_get_component_info() {
>      ...
>          pdsc->fw_components.num_components = num_components;
>          for (i = 0; i < num_components; i++) {
>                  struct pds_core_fw_component_info *info =
>                          &pdsc->fw_components.info[i];
> 
>                  memcpy(info, &list_info->info[i], sizeof(*info));
>      ...
> }
> 
> A second thread could concurrently execute pdsc_dl_component_info_get(), see
> num_components > 0 via READ_ONCE(), and proceed to iterate over the array
> while the first thread is still executing memcpy() into the array.
> 
> Could this be addressed by moving the update of num_components to after the
> array population is complete, perhaps using smp_store_release() and
> smp_load_acquire() to ensure proper ordering?
> 
>> +             if (err)
>> +                     return pdsc_dl_report_fw_ver(req,
>> +                                                 pdsc->dev_info.fw_version);
>> +             num_components = READ_ONCE(pdsc->fw_components.num_components);
>> +             if (!num_components)
>> +                     return pdsc_dl_report_fw_ver(req,
>> +                                                 pdsc->dev_info.fw_version);
>> +     }
>> +
>> +     num_components = min_t(u16, num_components,
>> +                            le16_to_cpu(pdsc->dev_ident.max_fw_slots));
>> +     for (i = 0; i < num_components; i++) {
>> +             err = pdsc_dl_report_component(req,
>> +                                            &pdsc->fw_components.info[i]);
>> +             if (err)
>> +                     return err;
>> +     }
>> +
>> +     return 0;
>> +}
Not a bug. devl_lock serializes the .info_get
ops on the instance, so the two concurrent executions of 
pdsc_dl_component_info_get described above cannot occur

Thanks,
Nikhil
