Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECA34D90C
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467462; cv=fail; b=hCqXHG0I11zh65S3BS4JLMSSVzyDqtlVuEDARn+d3rwGmmri8v882v+guVrQkIOS5yam9/d1WvpDjPvFbyTq6/2+weKAfeWNmPc/xstYmPnnVrKaV8sjEUFkJt7WrZm1LoSNodN5nVBaPwiPW8YqVWphIs9Z3B2Z4emmLB7YklA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467462; c=relaxed/simple;
	bh=deL59zhD+YqBnGwmplrXcXebq2Oz8+oax/QLmybVVmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPQr8PK2dn+5dlunHxuovFexTV271WtSPyktQkSAuEIO+MfWoQAyrB/LhUFh0Og39OoZq18DBghAINn3km2iCCjnEBG9hUls0TvspTRFU/0px9B2+9GPq0P0JgLon5UJgOzWM5ezEkZ8qrWwfKvTDNK4LjfZXjpxfp95l74qI1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XwJWmAvN; arc=fail smtp.client-ip=52.101.57.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XwJWmAvN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lONUlW7Z0PAywIORqHiiQKVFGV/S3sEbGeyOA7I2SNDr0ICK5EUuIXmbKsf3VosEhAgXTkpEJSEJ6JvsoK6FoRKiBIP44ZknLWMqX1J5oIfrQxWdSTrQ3HUxT/MOHlOCtMT6cFonUvMFY7N4WNdgpZOjiJoQY2CUtI7ETxktTY6nkYXUFabb4dceYITzLV5K93rm8Exl19in9k2Z/XnFIPikhNrcEkLY2zNtmL/gLXDjwj+xpKczUahzzCbehz8ATiPaQgTMkCTUtnM5pMeG4VrcviBis1LE5zl2Eojon9a7WGgXjrOmeRi/p2yL69SV7KGNBAYLERLjg6xF3X9KTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i/HJxLPIK59SnSOrOUPkBKSQ/8lmSPAgWsORYMQ8T4=;
 b=ctpgSZ7Fp6EKTC6wTU6FOHbsY2aP2KAC9zg6+JLH1HuXVzjLaEGkAJuXOj50C8dEIRgUj7v1P4zu6HEe/XUdtF9aAATfMAl3YpaNorulmxLXZjSVhNPHVnXMY5S2Fx6ZIxZr0gF09IPHU26GfRpqtrY2U62DBxhP0X/VSdxNkUMJXWswSWDV3aIQeIJQpl+sgOivbF6Ah/90BVGbq5Tn7t1UEfp7Gyl31lDXhRiW1WXsNhdRMbN1uaOikErfXPAc5NwUk3KwF2RzEZC95lMLcRMLKBqCjj6/ke5cQWRiC4vNAAWYXwKGexYM9qWnlQz+lNu+DxtfX8c4Jr/j5SDhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i/HJxLPIK59SnSOrOUPkBKSQ/8lmSPAgWsORYMQ8T4=;
 b=XwJWmAvNO2OYb0ysNM2/2KTcNyn84nYOCuRrFh0BtCKeOCci4pTkwTf8WSnqhwh+BqiHqctvhA04+uI6sgkXvhWrra+q10qJhpZG7FWlL5bqII/JIrZ6GTD4jCr4YSLWqJm733g7UoicIBxaA129RQki24bOHjxNm/C7IxgR+cIK+5Q+gq37393Gwe3l/m1VMeRQ0dEKEOcDFDl7dJNy4x1Ytu8QdZYrV66lH30GMBUOS1z6Mzy4A/AmiXgt2oI9rs+zIrc3DxRXOlhCQhyD1IdXpmOM/NaEtm6D2mPhxEv2YyIdFAsXHiWnlNfbGGxSBP0G6GLJ951TvyK761gSIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 16:57:36 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 16:57:36 +0000
Message-ID: <8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
Date: Tue, 11 Aug 2026 19:57:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260804094518.53b56d24@kernel.org>
 <7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
 <20260811080433.26f404dd@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260811080433.26f404dd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: b1837106-5299-4f99-3378-08def7c9a4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|5023799004|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2YCq+wwZfZ34PdnrtMmioHLPPZjDyW6pcBHH1NqTQaKGfXMyR/SbcFDlwkteArRexcuGk545vS7kslC5PNSDfcaaqQyCX5k9GeUi/DBayLpYxx2FRP14E9rJAt503AV+Eehm+xWs3avql3f9XEnZJXyfAILp0oJkhXmsKxgAca7dlJ6kiATApm0UF5ayxpe+Rxx0vw4IDrx6CiCNvrbppcoaDg+lLnXsbdShxN5E4ofCgL53CxWjT5WQGRMkXocqYJDaDdwyEV4J0w+YMmVW+UeNFQ+KUpDd5d0vmCBJyoeB+jKkRyMFWqZbqz/uZsZytpoaqgpM9ClhCufIOrFMcjwHhDt4S4MNvTQlkEaJN3ITmcqnkzaD1kzlvlAMhiII/e5qwTow6vf7VKgLqQtQrXzL5q9siD1p4tdHNrkqyaExYF3hJqnxZKT4UsR+l5ctEeiV0riHUh9+CJAizyJC+mldiNDOAe1FYT5Pe9A2q32BIp0pWyRA/GtRk7aHLOj1xWo3n3V7xvDFNuL/79hM2Q5P8srK4RvRARG4/NPvxIfiDsXpzxvku4AMwdgddIgSrtV9qd4rIOqsH4jN3Y5B1YU+UeAzQvuO/TeVdYIkK7vd4CgEFCmH3xtLawT8C5ypHaS5XN8tf6q+qhe/mUGej8FL+jRldU0NDhqwwK/qoXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NytqSGJYRlJ2NnlOeGQ1cnRxek1QRml6TXQ4WnpKb1M4bEVHbDFXN0dtWCt0?=
 =?utf-8?B?cEwwQldvdHc1cjBlZXFtbFh5Nk96ckNXdmgzaytUUkRhS3Rid0lTN2xEZFNt?=
 =?utf-8?B?MStualhwQi91T3pxc1AzNjlaWkVyeWxVR25SUm9RYS9KU3RxR3REVEplM0Qy?=
 =?utf-8?B?SE00ZThtdEdVY2lYbDVtOHpZV2ExY0d3MVQzNnFyNWN6c0lUQmJiUzNwUUZ0?=
 =?utf-8?B?UlNuTlpVNE81MkFGVVdsZGg5VjlwcVV3eUtvbGlEL1R5L2xQdEM2NStoTWpM?=
 =?utf-8?B?SDFkNmNIaEs2eFNKN0hwZnR5ckxQUVBBQWVUa0QweFdYRlNIYitiNUsxTTA2?=
 =?utf-8?B?NmtWNDRtamN2dGpwd1M2YnlIM1ZRR3NSZUlTcnV1RHRpWkZ1cngyYnNjMHh6?=
 =?utf-8?B?VkdrVVVoY3FxenViZzNlL1IwQmpZdjdmV3ZJbnBrZ0F3MW5BOG05MTh3RkN3?=
 =?utf-8?B?a1YvRzdHSExaaXJPVVozdndjK29Scy9zaHI3bmN5S0lpLzIybnhFeFpEUS9a?=
 =?utf-8?B?M1ZNZXR1UzdGOWx6TkxjUERzMm00MGNUSTVWY1VVVEdyNUU4OTlWV2FjZGto?=
 =?utf-8?B?b1hZRk5UVjlUczJNYjkvd2xtYUpmWTlzcGx2Vi82SzZabXZrNTlsMzR4VnNF?=
 =?utf-8?B?OEw2ZHgyWmdLd240ZTF3NzIrU0Nka09IaDZ4ME1LTjR4VnY1WVVYa0UvUk52?=
 =?utf-8?B?MnpydXA3clhQbXZrdklTRnlWTGhidTZkdW5acmZhcXlhOEc1QUszOHR3WkJX?=
 =?utf-8?B?MUVkQ3U4cjFoaXNaMnpFckxwMTFSZFl4ZlZCdlNja2wzNWZ6M29QYUZ5dTVy?=
 =?utf-8?B?ektpd1dyMmd5UmpWdjB0VVlnTFROeFQ2ZWJiNDJqZUhoM1JianpYWWhpc2RP?=
 =?utf-8?B?OTZwMm45WjBWYkMveERjQU1rWEFlcEQ1NjlIc2RxZWlkd096b1J6aVkxUEI4?=
 =?utf-8?B?dDIrWTlSbVcxcXlFZ0s2SUdTTzVpbHF4Y1gzNUJRRmxzWUZjYnlCOEFyaFZh?=
 =?utf-8?B?ZUFUTTFqcW00T05xaGdPbUl4c0thbE1vSnFlUURhQkpJTXFNbjdtV2ZyRmRM?=
 =?utf-8?B?alh1dy8yQnl4S1M2cFFlUU5vMW5KRWc3QTVENktTZHhWMmxoOVY4RC9UelVv?=
 =?utf-8?B?akJ1VHRCZVFkdHVkRFRFM0JiYUFsU2VxTmMrVjZTeXh0UEEwdlVTbTdJK1FK?=
 =?utf-8?B?Z1FIMUg2Z05mS0pvSjBqVkErZmNPdkJXblk5eVAvcDI1dUNUSzdvMmpjRkRL?=
 =?utf-8?B?a0c0aGJOejhIdXJKS0poMmxqTXRLb2ZLdTlJa0RXQ1M1SC9jcXVVQUxTYmVa?=
 =?utf-8?B?Sy9GOUFSNVVGQURDaUF5L1RneGc4UU13MGprc2VjSDczU0dHWDR6bkVjRytI?=
 =?utf-8?B?cGhFK3FnMjZ0T3EyS3Y5Sm9iNThVYjQ0R21IcXRKTCtZR3VadXRiWHhiZmRt?=
 =?utf-8?B?S3QvODF5SmxTNFBiSWZ0bkthMW13NkJPemNKSXY5dVg0cnlUcUJhYUpzd1Y0?=
 =?utf-8?B?ajhvQnYvQWhGdlNrT2dza25jSzhrYVZycXZYWGswUE5heDJrQnoyNHpwa2xY?=
 =?utf-8?B?cWxLQnBLOXdWWDhUY0l0S25EZTlScVpYSTM5MmJLdGJkdHBzWWVTc3R0ZVZr?=
 =?utf-8?B?bk9yVjdzc05tTXAwUGVsalB2QW1pVDFHK3NaVWJCbmZPa3VBMytFV05rZWgv?=
 =?utf-8?B?NjRmTmtEOVdEdVh4RDJ4WTZ0ZDdhV2V2TWpBQU5WMjhzYzZkMWhCcjh3L3J6?=
 =?utf-8?B?djZ4NWtNUkg2cnRXZ01jd3lXbEp1TEFtd1lsUVBRS3BTMS91SHlldXhmRG9s?=
 =?utf-8?B?cHNScEcyRDlJWE56YW1aY0RSU3Fnd1MzRk82SWxCVHFYZ2c2czU4NkRKTS9i?=
 =?utf-8?B?YnhjQ0E4NklaLzgrUlllb1VtcDNqc3VTQjB4dGZXMElCbVVZUFNldUdERFZa?=
 =?utf-8?B?WWNyNW5CWFNMeEttME1VNU1nNWhHUjVBRHQ0WEp3RWpPSDlLbXc0UzBPbDlG?=
 =?utf-8?B?WTRkK3djRDlTZVB1K2Y0YmdIWVFNc0QyYkEvNkNCWlorcHRpN1RSSm0zNHNq?=
 =?utf-8?B?alBnOGF5emppTEhHYUxMeVhydDcvbzR4cVFxaG9GN1BxZERGeUZPMUIrRDB0?=
 =?utf-8?B?WThKbE85Q3NnK2dLRUM0MkxrL3lUS202N1VjTU45WUszOUxSMHdlRHVNNGZV?=
 =?utf-8?B?TzVjTGhsUEsvUTYzM2hTYldCMW1yZTk2a1BaYnB2c0htbHF2bXVjS0RQTUtx?=
 =?utf-8?B?OGpQL1QyVEIwN1dJM0txL204RWlUa0JqSGdKZG5vaUIwb3d6UWNNZFh5Rk0w?=
 =?utf-8?B?NWxCQTBVTjZkK3ZoVVdHNDlBaXYxQXFCS2gvanpMNytDV0hPSXd0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1837106-5299-4f99-3378-08def7c9a4e4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:57:36.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgYgtgPLZGSpL9pqudNjurvVN+uHjGP0IxwOaavw7Uz/y9f58UEbR55z+Fy83kUkX5vwArkX9vrbOWdSydjofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

On 11/08/2026 18:04, Jakub Kicinski wrote:
> On Tue, 11 Aug 2026 10:20:52 +0300 Nimrod Oren wrote:
>> On 04/08/2026 19:45, Jakub Kicinski wrote:
>>> Hi!
>>>
>>> The CX7 testing in NIPA is looking pretty good, one major source of
>>> noise, tho, is that the pp-alloc test sometimes locks rtnl for
>>> a minute.
>>>
>>> Here's a failure in that test itself:
>>>
>>> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G', 'ens25f1np1', 'rx', '2048']' timed out after 20 seconds
>>> # # Exception| 
>>> # not ok 1 pp_alloc_fail.test_pp_alloc
>>>
>>> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py/stdout
>>>
>>> Then the next test that runs also times out during setup:
>>>
>>> # subprocess.TimeoutExpired: Command '['ip', '--json', '-d', 'link', 'show', 'dev', 'ens25f1np1']' timed out after 20 seconds
>>> not ok 1 selftests: drivers/net/hw: rss_api.py # exit=1
>>>
>>> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py/stdout
>>>
>>> pp_alloc test can fail, but spilling into the next test is a problem.
>>>  
>>
>> Seems like the bigger culprit is the earlier xdp test, which leaves MTU
>> at 9000:
>>
>> # # Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed
>> # # Defer Exception| CMD: ip link set dev ens25f1np1 mtu 1500 xdpdrv off
>> # # Defer Exception|   EXIT: -15
>> # # Defer Exception|
>> # not ok 17 xdp.test_xdp_native_adjst_head_grow_data.ipv4
>> # # Totals: pass:14 fail:3 xfail:0 xpass:0 skip:0 error:0
>> not ok 1 selftests: drivers/net: xdp.py # TIMEOUT 360 seconds
>>
>> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/13-xdp-py/stdout
> 
> Ah, well spotted. That's the test timeout, I'll bump the timeout from
> the current 6min to 10min. Once it passes we'll know the true time
> needed, and we shall set the timeout to 150% of the expected case..
> 

Sounds good, thanks.

>> I'll try to reproduce this internally and investigate what happened.
>>
>> Also, I noticed that the pp-alloc test isn't properly restoring the rx
>> ring size due to the timeout. In the subsequent retry, it's attempting
>> to double it again, this time from 2K to 4K:
>>
>> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G',
>> 'ens25f1np1', 'rx', '4096']' timed out after 20 seconds
>> # # Exception|
>> # not ok 1 pp_alloc_fail.test_pp_alloc
>>
>> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py-retry/stdout
>>
>> The high MTU and ring size along with the heavy debug kernel likely make
>> the pp-alloc test significantly slower. I'll also prepare a patch to fix
>> this pp-alloc cleanup issue.
> 
> To be clear - if the commands time out - how can we fix the cleanup?
> Or do you mean some other bug?

In the pp-alloc test, the ring size command timed out, but the change
was still applied in the end.

Currently that test only attempts to restore the original ring size if
the set command returns successfully. This case makes me think that it
should attempt the restoration regardless...

