Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0984A3D23;
	Wed,  7 Oct 2026 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373460; cv=fail; b=Th26e7ykGQChVJkD15+mb+hIJu01l4V8l/ECz818TZe7Up7a+K+XgxxF+3o8/uPtYR6PRWadH+9lYZ5hEw9n6RLBDy3bEsn5R1r4SgkxmfAStNUKSlr1GB653l6PIKhk+DwbbfTWXH+btVIyKVs7hhSWvxnxLPQ+OdDiphD/VhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373460; c=relaxed/simple;
	bh=Xkvr/1UAw4Rhloj9l1W3JogykWCYaJR0qrXRyV6KL00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q43w8dXa0Uy/y27iWfZtzQevhnPHQHaoLEB5ueF8g4rAdS9+fcu4lRGF8H1lr4UayQ1niFJ1A1EUqiPNUzJGu6lLV/VPTssRILvCTOt2hKQAP7OlltWJps6+Et9ePUY7ptNcYma9zbz2EXadK6ZcAdw1whtyOMODWPjD+W1nvkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9anrLDN; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9anrLDN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v38Shd3Jahz7LJdO1qd6Xy/BpmJE6z4XpoI5A3reby+IVfLhPyMqQLovnvAe6aXXLFOPopufmddMCy5P+mIfLVWPZI/C/2vjZzDvwOOXIIp4r8qLm7gqurz4IqzPr5o+HKRXpNuhU75CL65p19dESTCOET5d2zXpMsnYdXmPJQFa5/rmrzlhl3svOVs2nfk8bm6nYmTCkN9DYwECQWgt0vhMqR4p5dSnkyRE/hdByr4TWFV8SIibbwcyjJzzagcJ4qiV/H7ro6ut/YGOgsX8aoL0UsYlUnpOoHB7mD3J7+V0wB+ScxAsYhNBHXjDLSmBxTolHM9yLJt3gmOV3DHsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XphpFaYWITZeJ8xnllor33Ug+PB8ByFnJX3c4xSLLlo=;
 b=q2nr98xUFGNfpoo3RNlta+Acb55j0Wqpa+0GAhTtv9t5XGu6Ev+qRrGaQqktZOOmAZAAyimrWuGrWwG65ACf33CU8YJbb/Uh1LxdP0e5gS7JWnTdJwr5CqTrK078Oq2QIugpWBu9ZnnW7JXGLxmYPjSBdJmQIk5RDcUf+N1eO1WtQQiAb9Jr/96NGzLSdtqaZTNKFgr4Msh1q6p3snvqowzAzVwRH0qeyzJfUG+/zFv3rFny4e5+TRx/YxVde750qCLBHKOoDAclbadULVPyB7JKlZPCRDt0OCTSsb0KOZ41GBP0/6EhpPT9zpfkL2N+4B0+Ug0lv9eiZdkrre+CFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XphpFaYWITZeJ8xnllor33Ug+PB8ByFnJX3c4xSLLlo=;
 b=d9anrLDNCPXQI2Kh9LUQGXSKcAIH42U5nllXhgIUIhbUkUgXXFvU5ppBsi7Gv+T1oTFMbVbvTg3dgt5iZSNtSsMknaiz+Ll5eRynf64yie2q7iyxhWN77gTDkaldtUNtCol4uMHPgcYcKEeWFeyk2xrOvl/AQHS+pVXRMF14lk8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 11:43:58 +0000
Received: from IA1PR12MB8408.namprd12.prod.outlook.com
 ([fe80::10cf:64f0:2de6:e466]) by IA1PR12MB8408.namprd12.prod.outlook.com
 ([fe80::10cf:64f0:2de6:e466%7]) with mapi id 15.21.0451.022; Wed, 7 Oct 2026
 11:43:58 +0000
Message-ID: <3568052a-0213-4502-ae38-4f0f2a113b82@amd.com>
Date: Wed, 7 Oct 2026 17:13:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c: master: dw: Clamp GETMRL/GETMWL to controller FIFO
 limits
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
 Frank Li <Frank.li@oss.nxp.com>
Cc: Frank Li <Frank.li@oss.nxp.com>,
 Shubham Patil <shubhamsanjay.patil@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com,
 jk@codeconstruct.com.au, matt@codeconstruct.com.au, netdev@vger.kernel.org
References: <20260908102724.3232660-1-shubhamsanjay.patil@amd.com>
 <aqL4HaQ1gjeaJYUQ@lizhi-Precision-Tower-5810>
 <eff031f6-e212-43a8-98c0-5f52a4b9317b@amd.com>
 <arVBZ0j2noe0g0Wi@lizhi-Precision-Tower-5810>
 <44e2c06b-7742-47a7-b2fa-2284867d4f32@amd.com>
 <20261006-fc1d7a5f0e4e3b1b453450f9@linux.microsoft.com>
Content-Language: en-US
From: "Patil, Shubham Sanjay" <shubpati@amd.com>
In-Reply-To: <20261006-fc1d7a5f0e4e3b1b453450f9@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::13) To IA1PR12MB8408.namprd12.prod.outlook.com
 (2603:10b6:208:3db::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8408:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb3951b-aec5-4235-92fc-08df246845d4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	ncaT0Dm4Vy6SXdXFH1k9ePgk0xTNpJf6U32UifymeS6oRSgrgtqUC6U9cTyCFcXBk1Fgdz6n08pl6wCPMNVW1OnB4hZGecGntUp5oZZXqjr12T+YAVmVuQk3k0dyXjuZL31aessZPyEGqxala/e93z+8vZoHRukmUZScIYn1eVaY62+0wfgAsADr9cK9DEV1QI8O2OZIW+RayT4Pbt9IAG/bvyROTLZwsdoUBDsuEYyHEhJT4wjpgWICpr4eyPxjf7X5nLwaaCnQYyHKBrTPyvzvIvjuj8GITX+p+cuS5A4qzw3M5nSLE37pJfaS2JrKP6MROv9B1CcK4DRHSgdkJY2M4Suyd6Ol/mpeZ4kwIJd+imXecOJzIl/aJm+sUf5w6hnJWbv4LTlwpbz6iZX57F6uJsX5SHIwFDwId7GNKLlwDEKQevDfonAZaL9bONjhZDPHGcsPSBOSDgMrjW6CZOkNBJ9UwFCTa6bzsl/RO+F4D5p27HAuKuXvnLDZ3ArJvVOfnXSXz9HFV3Dhs+oWZQx8ZHAJHnIvm8jnIQv8a4wM+rZiUeEMJlk9U6hDlfY18dsPXjbEHSeFUt0fN8ygbsNNP0Qk70KKvybAXbrVBQskzqIDTPoBNCsqn0yUJPcI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8408.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkhKWDR3eE9jYUhKN2krTDFyQ0wvdm4xT3pPYy9oSGcvQjB0VWJORWRuNUV2?=
 =?utf-8?B?aHY4bGEzeHZPUlB6bVdqUFVHaU1LdEl4YVJSR1B5dlVoTnJySVZaSXNpMjF4?=
 =?utf-8?B?QTJaZVNsNTc4UW9XVkZTRE9SWG93ZkVKUVMvUVp3eTgxZEJueW5Ba0R3c1Vq?=
 =?utf-8?B?RjRKSkVoUE5OWnc5eVYrNmgxdHY5cWhSeUZkYTl3OEZmczRxc3B2Wjdsb2ln?=
 =?utf-8?B?YWNxK2c2cDZpYWlsY3UxRzV6VzR3a1Z1UkZtdExOVjBRekhQSGk0QXV0dnRK?=
 =?utf-8?B?eGpkU3I3bFBQeHE1MFRsUnJkTDFrZUNrNVlTYWdjbVVJWjRZYldiekxwTlRS?=
 =?utf-8?B?dENYZmlxSmN5MXM4bHRlNlFpNDNDZkZwclNxcFgzTU05QWkvbmtaeVJiK1N0?=
 =?utf-8?B?Z0toZGFpYUVweXo0VEhqVUNtNWtWb1VxZGlZV3ZHR1hkMWZmVW9tU0N1VHQ3?=
 =?utf-8?B?cDJRVmY3L3FPRnBqQW4rU2p4K0pkOU5uaE85ek1Bai85dk80Vk5uQVhVVWk1?=
 =?utf-8?B?Vmtza0F4WGpBMWM1dDF2MjRHY3k3dGdyV2c3NlB0SS9ha0dBTHB0Nm5KZDNo?=
 =?utf-8?B?bFE0QWQxTDlyQ2liMjNoNmRBbHlGV0Y1eUs4VG1JbVNrVVo1MURXT2luVkhP?=
 =?utf-8?B?ZEErYUxoYVh5ZUludUM1UmNpNnNRZ2hqYUh3Nk9GS0wxckR5UER5b0NtYm0z?=
 =?utf-8?B?MSt4V2IyeFYyMGt1TWFDdlBGQlZNN1RZT29BcDVVaE1EL2J3c08yWW5tOEgw?=
 =?utf-8?B?RDN4L0FUSnpWdTJEZm9SU1N5eFdrdS82ZjZVNE5OSi9Vd1RtOFNzS2htM2FU?=
 =?utf-8?B?WEhhcUxsdFplWU9FcS9pT3ppQUoweUc4NG5lNDNyZDIzUHE4Si9NQXdYUXlF?=
 =?utf-8?B?R2k5NUpkNmp0My9lQkxRWTc5eFJDYzgveTFBTlEyQi9xemRMNEpSR1VON05I?=
 =?utf-8?B?Y0pvenZFN1IwZE40ckZwNC9vTGE1VVZ3cFVTbHNxYzdRZjMzdWdZaG9leFIv?=
 =?utf-8?B?Rk1jemlUcHF6SGNraU5uVkpGZHVrcHNjNEZidU1rcldWK2lmUWRqNGd1OTRO?=
 =?utf-8?B?aVN1Y3NsVG05OHppNVZLYnQyckZqNW9TcVo2WHlQVklvYVRraW5BcVY3YWph?=
 =?utf-8?B?dUJyVzJiaUY3dlQxME1XU3JrR04wWTJ5aThBTytSZHkzTkRMaXZPY0hyTVVP?=
 =?utf-8?B?U1VJeEs5Si9WOWl1WVprbFV4TEZMRE14TkI4Qk1aQ2krTTdYdGdEZXNDTWNi?=
 =?utf-8?B?WnQ4RDM3dFJUNzkwQU5hd1o4TkJlby81NzdkeFBENlMydGpaaDZlSGFoZnVv?=
 =?utf-8?B?aFdLQVFoTlBBalFaV1NabVdUMXBjL1ZFc0hFWk5vRkhVNmJnWllyMUlHcEF3?=
 =?utf-8?B?MEdWN3EwT3h5Uk5JazZHcUxjYkdRVzc4SS9sc0s0R0hUNzBMOTc1YzhlWGlu?=
 =?utf-8?B?eXRlT0JLN3JFRXNIamZEdzlGUldxWHMzaWZFZk0vdEpEWFdFS2lvT0F1OC91?=
 =?utf-8?B?MmZoUEtRSUVIczVTOGpCUGF3U2xKUWZld3JsdEdIVkYyS0FmK3VpelNFSDdx?=
 =?utf-8?B?R01qR0wyZWdOc2FqR29KaVVncEd6clFBcFZKb0daWlRWdzhTMjBZWGdQdHBG?=
 =?utf-8?B?b3p3a3RZU1hPWkxObHp4Y0w5ZUhSZThaTHF1R082NUdzTGI1cnpVUWVNSGNk?=
 =?utf-8?B?R01VYW15Yy9mNFVBRG5xTUlCREhVWVJ0WXBsMDdER0tOSXM1TENEWDcyY1VI?=
 =?utf-8?B?SUhXQXFIT3lHaW03d1phREcrYmc3UDRPbzljVXhGSHpZUFhZdGV1dlJoWXZm?=
 =?utf-8?B?UEVMV3lYUzB5REQwNmljVGxpRGlDZGRrdW9FN0dpeUQ0Ni9nZjZlek43aVNJ?=
 =?utf-8?B?WWFDTnozM2YwWVFMVkFyTHN2bnJUZXphYnk5c0xxYmhOekhLaVBtbys0cHhh?=
 =?utf-8?B?clNJWGtUaFJEU3l3UElEaUlFVmJ0bW1RdUhmcGIyNE9EcEdEaWcwT3FRa0Zj?=
 =?utf-8?B?dXJEQzZZUStjNnQ0NHdlWjFYY25zYTRTd1UyRngzUkRsTGtJUHZ1TVFBazFa?=
 =?utf-8?B?ZmVuYUFTL2NqaWt5SW5TbGdUQUIzT1ozZU5RTkVrSkVFaDEyc2Q2UE9hc28v?=
 =?utf-8?B?QTBmZm5icmQ1VWhHSnRDSk5GbzRNdlpWeEU5Nkd6dWhTbjVKS21iRmtqRXVM?=
 =?utf-8?B?ajlIV3BYc1ZvTHZid0cwSWhwaEdPQXcxZVZhdXFEdkh3OUE3WnpVNC8yL0NY?=
 =?utf-8?B?WnVwZTZtQlM3LzY1YlJIQ2p2RTR1ZWVhbko3a0Nqai9qYUZLSnVOWjVoRVBk?=
 =?utf-8?B?RkxTbzdwSFVmVWQ2SVltN09DWTBhUXZsNm1GbXJhbk5nNUNuNDljQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb3951b-aec5-4235-92fc-08df246845d4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8408.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:43:58.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glIjIEkIY8g7NrlvKLIpofPECtPtlfqlikmla6GWLuMLGE7L7UqE1il9/jpmbNJg8d0hEn6EADeXCIoOhSrK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916



On 10/7/2026 1:05 AM, Meagan Lloyd wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Oct 06, 2026 at 06:05:16PM +0530, Patil, Shubham Sanjay wrote:
>> On 9/24/2026 8:57 PM, Frank Li wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Thu, Sep 24, 2026 at 10:25:44AM +0530, Patil, Shubham Sanjay wrote:
>>>>
>>>>
>>>> On 9/11/2026 12:04 AM, Frank Li wrote:
>>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>> On Tue, Sep 08, 2026 at 03:57:24PM +0530, Shubham Patil wrote:
>>>>>> The DW master rejects private SDR transfers larger than
>>>>>> caps.datafifodepth with -EOPNOTSUPP. Targets often report MRL/MWL
>>>>>> values larger than that FIFO, so the core stores limits the controller
>>>>>> cannot meet.
>>>>>>
>>>>>> After a successful GETMRL/GETMWL, issue Direct SETMRL/SETMWL to the
>>>>>> same target with lengths capped to the data FIFO (in bytes), then
>>>>>> rewrite the GET payload so the core keeps the same values. Only update
>>>>>> the GET buffer once SET is acked, so a failed SET does not leave the
>>>>>> core and the target disagreeing.
>>>>>
>>>>> I think i3c device driver should know these information choose
>>>>> min value dring each xfer. even though you set devcie's MRL/MXL, device
>>>>> driver still issue a longer transfer.
>>>>>
>>>>> Frank
>>>>
>>>> Understood - I will drop the SETMRL/SETMWL and stop rewriting the GET
>>>> payload, and instead expose the controller limit so the min is taken
>>>> per transfer. Two questions on how you want that done:
>>>> 1) Where should the min be taken?
>>>>      a) In the core: the controller driver sets max_read_len /
>>>>         max_write_len / max_ibi_len in struct i3c_master_controller, and
>>>>         the core caps i3c_device_info to min(target, controller) after
>>>>         GETMRL/GETMWL. Device drivers then use i3c_device_get_info()
>>>>         as-is and cannot forget.
>>>>      b) In each device driver: the core keeps reporting the raw target
>>>>         values, and drivers do the min themselves.
>>>
>>> We can provide APIs for device driver to get whole data path required
>>> max_read/write_len.
>>
>> Thanks. Next v2 will be:
>>
>> Patch 1 - core: add max_read_len/max_write_len to struct
>> i3c_master_controller, set by the controller driver before
>> i3c_master_register(), plus two helpers for client drivers:
>>        u16 i3c_device_get_max_read_len(const struct i3c_device *dev);
>>        u16 i3c_device_get_max_write_len(const struct i3c_device *dev);
>>
>> Each returns the smallest limit along the whole data path, i.e.
>> min_not_zero() of the target's GETMRL/GETMWL value and the controller
>> limit, and U16_MAX when nothing limits it. i3c_device_info keeps the raw
>> target values untouched.
>>
>> Patch 2 - dw: advertise the data FIFO depth to the core, by setting
>> base.max_read_len/base.max_write_len in dw_i3c_common_probe() before
>> i3c_master_register().
>>
>> Thanks,
>> Shubham
> 
> I'd vote to avoid overloading the terms 'max_read_len' and
> 'max_write_len' as it currently refers to the device's MRL and MWL
> values retrieved through the GETMRL, GETMWL CCCs.
> 
> So, maybe something like:
> 
> struct i3c_master_controller fields rx_fifo_bytes, tx_fifo_bytes
> 
> i3c_device_get_max_read_xfer_bytes() - min(rx_fifo_bytes, device mrl)
> i3c_device_get_max_write_xfer_bytes() - min(tx_fifo_bytes, device mwl)
> 
> -
> 
> The first meaningful user of this patch would be mctp-i3c driver. Where
> the i3c_xfer.len would need to be updated from using the device's mrl/mwl
> to whatever these new API functions return.
> 
> I think that the mctp-i3c driver update should be part of this series since
> it'll be the first user. Unless, Alexandre and the MCTP maintainers disagree.
> 
> Thanks,
> Meagan

Agreed on both, I will use those names as-is. v2 will be:

Patch 1 - core: add rx_fifo_bytes and tx_fifo_bytes to struct
i3c_master_controller, set by the controller driver before
i3c_master_register(), plus the two helpers above in drivers/i3c/device.c.

Patch 2 - dw: read QUEUE_SIZE_CAPABILITY for TX_BUF_SIZE and RX_BUF_SIZE
and publish both limits. The driver currently has that offset defined
under the wrong name and unused, and derives a single depth from the TX
data buffer status level, which patch 2 corrects to use the right depth
for each direction.

Patch 3 - mctp-i3c: use the helpers for mi->mrl and mi->mwl.
The helpers will use min_not_zero() and return 0 when neither side
reports a limit, so "unknown" stays encoded the same way it already is
in i3c_device_info and mctp-i3c behaves exactly as it does today in that
case. That keeps patch 3 a straight substitution of the two helpers for
info.max_read_len/info.max_write_len.

The value returned by i3c_device_get_max_read_xfer_bytes() and
i3c_device_get_max_write_xfer_bytes() will be documented as the limit
for a single message in that direction.

Thanks,
Shubham>
>>
>>>
>>>> 2) Either way, a driver that ignores these limits still gets
>>>>      -EOPNOTSUPP from dw_i3c_master_i3c_xfers() when the transfer does
>>>>      not fit the data FIFO. Should the driver keep returning that, or
>>>>      would you consider splitting an oversized private SDR transfer into
>>>>      FIFO-sized chunks in the controller driver? My understanding is
>>>>      no - splitting changes what the target sees on the bus - but I
>>>>      want to be sure before v2.
>>>
>>> the decision about split transfer should be decided by device drivers.
>>> Not all device treat two continue repeat START as continue write/read.
>>>
>>> Frank
>>>>
>>>> Thanks,
>>>> Shubham>
>>>>>>
>>>>>> GETMRL is variable length: the optional third byte is max IBI payload
>>>>>> and is only present if the target returned it. Clamp that IBI byte to
>>>>>> the IBI queue depth from QUEUE_SIZE_CAPABILITY.IBI_BUF_SIZE (bits 19:16
>>>>>> at 0xe8, encoded as 2^(n+1) dwords).
>>>>>>
>>>>>> Rename the unused EXTENDED_CAPABILITY macro at 0xe8 to the databook
>>>>>> name QUEUE_SIZE_CAPABILITY.
>>>>>>
>>>>>> Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
>>>>>> ---
>>>>>>     drivers/i3c/master/dw-i3c-master.c | 149 ++++++++++++++++++++++++++++-
>>>>>>     drivers/i3c/master/dw-i3c-master.h |   1 +
>>>>>>     2 files changed, 149 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
>>>>>> index 4563d8761ba0..51defcb57761 100644
>>>>>> --- a/drivers/i3c/master/dw-i3c-master.c
>>>>>> +++ b/drivers/i3c/master/dw-i3c-master.c
>>>>>> @@ -203,7 +203,13 @@
>>>>>>     #define BUS_IDLE_TIMING                      0xd8
>>>>>>     #define I3C_VER_ID                   0xe0
>>>>>>     #define I3C_VER_TYPE                 0xe4
>>>>>> -#define EXTENDED_CAPABILITY          0xe8
>>>>>> +#define QUEUE_SIZE_CAPABILITY                0xe8
>>>>>> +#define QUEUE_SIZE_CAPABILITY_IBI_BUF(x)     (((x) & GENMASK(19, 16)) >> 16)
>>>>>> +/*
>>>>>> + * IBI_BUF_SIZE is encoded as 2^(field + 1) dwords: the smallest buffer is
>>>>>> + * 2 dwords and each increment of the field doubles the depth.
>>>>>> + */
>>>>>> +#define QUEUE_SIZE_IBI_BUF_MIN_DWORDS        2
>>>>>>     #define SLAVE_CONFIG                 0xec
>>>>>>
>>>>>>     #define DYN_ADDR_LO_MASK GENMASK(4, 0)
>>>>>> @@ -844,6 +850,130 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
>>>>>>          return ret;
>>>>>>     }
>>>>>>
>>>>>> +/*
>>>>>> + * Cap the limits a target reported through GETMRL to what this controller can
>>>>>> + * actually transfer, so the core never asks for a private read the data FIFO
>>>>>> + * cannot hold. The optional IBI payload byte is capped to the IBI queue depth
>>>>>> + * instead; since that byte is a u8, the IBI cap only ever applies to
>>>>>> + * controllers whose IBI queue is smaller than 255 bytes.
>>>>>> + *
>>>>>> + * Direct SETMRL is optional, so a target may implement GETMRL and NACK the SET.
>>>>>> + * Clamp the values handed back to the core either way: a failed SET only means
>>>>>> + * the target keeps its own larger limit, which is harmless as long as the core
>>>>>> + * stays within ours.
>>>>>> + */
>>>>>> +static int dw_i3c_master_clamp_mrl(struct dw_i3c_master *master,
>>>>>> +                                struct i3c_ccc_cmd *ccc)
>>>>>> +{
>>>>>> +     u16 max_fifo_bytes = master->caps.datafifodepth * sizeof(u32);
>>>>>> +     u32 max_ibi_bytes = master->caps.ibififodepth * sizeof(u32);
>>>>>> +     u16 actual_len = ccc->dests[0].payload.actual_len;
>>>>>> +     struct i3c_ccc_cmd_dest set_dest = { };
>>>>>> +     struct i3c_ccc_cmd set_cmd = { };
>>>>>> +     struct i3c_ccc_mrl set_mrl;
>>>>>> +     struct i3c_ccc_mrl *mrl;
>>>>>> +     bool clamp_ibi = false;
>>>>>> +     bool clamp_read;
>>>>>> +     u8 ibi_len = 0;
>>>>>> +     u16 read_len;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     /* Need at least the 2-byte max read length field to act on. */
>>>>>> +     if (actual_len < 2)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     mrl = ccc->dests[0].payload.data;
>>>>>> +     read_len = be16_to_cpu(mrl->read_len);
>>>>>> +     clamp_read = read_len > max_fifo_bytes;
>>>>>> +
>>>>>> +     /* Optional third byte is valid only if the target returned it. */
>>>>>> +     if (actual_len > 2) {
>>>>>> +             ibi_len = mrl->ibi_len;
>>>>>> +             clamp_ibi = max_ibi_bytes && ibi_len > max_ibi_bytes;
>>>>>> +     }
>>>>>> +
>>>>>> +     if (!clamp_read && !clamp_ibi)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     set_mrl.read_len = cpu_to_be16(clamp_read ? max_fifo_bytes : read_len);
>>>>>> +     if (actual_len > 2)
>>>>>> +             set_mrl.ibi_len = clamp_ibi ? max_ibi_bytes : ibi_len;
>>>>>> +
>>>>>> +     set_dest.addr = ccc->dests[0].addr;
>>>>>> +     set_dest.payload.data = &set_mrl;
>>>>>> +     set_dest.payload.len = actual_len;
>>>>>> +
>>>>>> +     set_cmd.rnw = 0;
>>>>>> +     set_cmd.id = I3C_CCC_SETMRL(false);
>>>>>> +     set_cmd.ndests = 1;
>>>>>> +     set_cmd.dests = &set_dest;
>>>>>> +
>>>>>> +     ret = dw_i3c_ccc_set(master, &set_cmd);
>>>>>> +     if (ret)
>>>>>> +             dev_dbg(&master->base.dev,
>>>>>> +                     "SETMRL not accepted by target: %d\n", ret);
>>>>>> +
>>>>>> +     if (clamp_read) {
>>>>>> +             mrl->read_len = cpu_to_be16(max_fifo_bytes);
>>>>>> +             dev_dbg(&master->base.dev,
>>>>>> +                     "clamped target MRL from %u to %u bytes (FIFO depth limit)\n",
>>>>>> +                     read_len, max_fifo_bytes);
>>>>>> +     }
>>>>>> +     if (clamp_ibi) {
>>>>>> +             mrl->ibi_len = max_ibi_bytes;
>>>>>> +             dev_dbg(&master->base.dev,
>>>>>> +                     "clamped target IBI len from %u to %u bytes (IBI buffer limit)\n",
>>>>>> +                     ibi_len, max_ibi_bytes);
>>>>>> +     }
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/* Same contract as dw_i3c_master_clamp_mrl(), for the write direction. */
>>>>>> +static int dw_i3c_master_clamp_mwl(struct dw_i3c_master *master,
>>>>>> +                                struct i3c_ccc_cmd *ccc)
>>>>>> +{
>>>>>> +     u16 max_fifo_bytes = master->caps.datafifodepth * sizeof(u32);
>>>>>> +     struct i3c_ccc_cmd_dest set_dest = { };
>>>>>> +     struct i3c_ccc_cmd set_cmd = { };
>>>>>> +     struct i3c_ccc_mwl set_mwl;
>>>>>> +     struct i3c_ccc_mwl *mwl;
>>>>>> +     u16 write_len;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     if (ccc->dests[0].payload.actual_len < 2)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     mwl = ccc->dests[0].payload.data;
>>>>>> +     write_len = be16_to_cpu(mwl->len);
>>>>>> +
>>>>>> +     if (write_len <= max_fifo_bytes)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     set_mwl.len = cpu_to_be16(max_fifo_bytes);
>>>>>> +
>>>>>> +     set_dest.addr = ccc->dests[0].addr;
>>>>>> +     set_dest.payload.data = &set_mwl;
>>>>>> +     set_dest.payload.len = sizeof(set_mwl);
>>>>>> +
>>>>>> +     set_cmd.rnw = 0;
>>>>>> +     set_cmd.id = I3C_CCC_SETMWL(false);
>>>>>> +     set_cmd.ndests = 1;
>>>>>> +     set_cmd.dests = &set_dest;
>>>>>> +
>>>>>> +     ret = dw_i3c_ccc_set(master, &set_cmd);
>>>>>> +     if (ret)
>>>>>> +             dev_dbg(&master->base.dev,
>>>>>> +                     "SETMWL not accepted by target: %d\n", ret);
>>>>>> +
>>>>>> +     mwl->len = cpu_to_be16(max_fifo_bytes);
>>>>>> +     dev_dbg(&master->base.dev,
>>>>>> +             "clamped target MWL from %u to %u bytes (FIFO depth limit)\n",
>>>>>> +             write_len, max_fifo_bytes);
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>>     static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
>>>>>>                                        struct i3c_ccc_cmd *ccc)
>>>>>>     {
>>>>>> @@ -866,6 +996,18 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
>>>>>>          else
>>>>>>                  ret = dw_i3c_ccc_set(master, ccc);
>>>>>>
>>>>>> +     /*
>>>>>> +      * Clamp GETMRL/GETMWL responses to the data FIFO depth, and the
>>>>>> +      * optional GETMRL IBI byte to the IBI queue depth. The GET itself has
>>>>>> +      * already succeeded, so its result is never overridden here.
>>>>>> +      */
>>>>>> +     if (!ret && ccc->rnw) {
>>>>>> +             if (ccc->id == I3C_CCC_GETMRL)
>>>>>> +                     dw_i3c_master_clamp_mrl(master, ccc);
>>>>>> +             else if (ccc->id == I3C_CCC_GETMWL)
>>>>>> +                     dw_i3c_master_clamp_mwl(master, ccc);
>>>>>> +     }
>>>>>> +
>>>>>>          pm_runtime_put_autosuspend(master->dev);
>>>>>>          return ret;
>>>>>>     }
>>>>>> @@ -1728,6 +1870,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>>>>>>          ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
>>>>>>          master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
>>>>>>
>>>>>> +     /* Read the IBI data buffer size advertised by the controller. */
>>>>>> +     ret = readl(master->regs + QUEUE_SIZE_CAPABILITY);
>>>>>> +     master->caps.ibififodepth = QUEUE_SIZE_IBI_BUF_MIN_DWORDS <<
>>>>>> +                                 QUEUE_SIZE_CAPABILITY_IBI_BUF(ret);
>>>>>> +
>>>>>>          ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
>>>>>>          master->datstartaddr = ret;
>>>>>>          master->maxdevs = ret >> 16;
>>>>>> diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
>>>>>> index 17ad817d1f8e..54c3912374c8 100644
>>>>>> --- a/drivers/i3c/master/dw-i3c-master.h
>>>>>> +++ b/drivers/i3c/master/dw-i3c-master.h
>>>>>> @@ -15,6 +15,7 @@
>>>>>>     struct dw_i3c_master_caps {
>>>>>>          u8 cmdfifodepth;
>>>>>>          u8 datafifodepth;
>>>>>> +     u32 ibififodepth;
>>>>>>     };
>>>>>>
>>>>>>     struct dw_i3c_dat_entry {
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>
>>
>>
>> --
>> linux-i3c mailing list
>> linux-i3c@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-i3c

