Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6542CB14
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552284; cv=fail; b=CiwzrN7HvqXGsRVv7n33msvaUq8TQIYL4jfbJsHYglrn1ntulov9B26fE0nXsUrmHYEuAY35gyQuHKke/FNYei3iMESEqJK/8Htf1ojLzhQeiZhFaeVyKo5V+hzBcdr6xZn1yHwDZTirIb5mklzYQMJECGGUOehEYK9BsgvcKIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552284; c=relaxed/simple;
	bh=uXb7bV1EtZ5svIsDv3tKUeWKeliP9iVpo/YcjTxRSZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eX5HQRP4EhmS7npMETcFodhTb/p8ekm0ZtBf2XgGl5CH9VdFK5r/TkpKD0jIow2iFL+Sr+b6cpIp6BB61x1xB4E+YN6mNc+wU0bC25RggBjyjedylO07zCfOIttgCX2hHJbr1Q0zF3yWJCOiS8NF96RlFTHryvJ+NCu8p/051XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pp6W2YHs; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pp6W2YHs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta7a1YiorIVU/Me4DY5KEVNeXDu3juGBk5mSEj/zyyRL6ZmbfPGYgsvaZvwOWKR1uu3Go1NsQgAXloZwvwrDavBK8MARNPPET0AkXARgEiOSbQUrfTUCL0vyXV6h3m0a01E95ZSB80MGDPLpp+CrWayj2SUTzZy11Kh4e7PST+Lf+prZ9n51H/AIUoT0M/fH/xyk7kQdF87vpQtMJF5pQlCQn/FEy/kOaa1rsLkth7ny8diO3aLv/foUrvDir87AhrWEa1MXK3UmlJ/6hGpMLNA/hGq0cRp0lLUlfBwLINUa0jimIxh6m/lL3ZAN9sjt83xcLHOtzPwcjNR1IA4FSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReYP251wAnFY2EQUbtQoRCY9BC/+rEVvWqXqt1IgMj0=;
 b=W+Wbbdjv0ujKYnyM3VUUyukBrFt2j1zwweWP/eGvcQFobCj+QMajpcvDZTg045GpDwFsJ/EVMi/cC3LX4vBTbiyrEFnREN+ngQplL31O+driG6P4FV7s8VhTxjswdEY+cTZ3gQMzcWq2extJ06Pnu89nKPNOXYYIyhXuHCSZnq1KEaVpmpGn6VPCpffDfT1JvAAheFumHGPbi9uxP2uQulnbGWRceF8Rq6ekxRiC/qILGy+TvDxRN/eLbLNsyC10YBgzQhxgZF97kg/WMEUUYYAsEuMXChGSq/hBHRufbeqxyG5zSu30u/0xVPDhiHP6yCa5XWARkHBj2G2Vubbsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReYP251wAnFY2EQUbtQoRCY9BC/+rEVvWqXqt1IgMj0=;
 b=Pp6W2YHsT0iIvQAIgENCgX3+chC0c33XgRn86c04nt/vxJO6XQAO/p90tsfva8t+tY5/bFyC+2FKR14wDY3oljsoiMGb89QiPo+g/Smyhor5KLESXEe3RQKAEWbDqXXCT5pD8ACFQuJEZHXexFvQZVPLa0IP0e/ovO9okGiAthwGZ0Vu6KqG6zqtWjlL/+/0JgY0ea6Kzc3kV1XkyQHfWpeuXvVCpBLTl+yUi8v15Fk+ptkK4TVogUlMpAhbu6yJ61IioXaLXELv0hXN8IfrN5s8dqWszbxvy3KHq3GJWho7N9I/Fyp22sXLrEJ3mo3Y7y3yKt+9DxX2FB77zAHVgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 16:31:15 +0000
Received: from MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587]) by MW4PR12MB6802.namprd12.prod.outlook.com
 ([fe80::51f4:a3d9:b44e:9587%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 16:31:14 +0000
Message-ID: <2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
Date: Wed, 12 Aug 2026 19:31:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260804094518.53b56d24@kernel.org>
 <7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
 <20260811080433.26f404dd@kernel.org>
 <8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
 <20260811103832.28e5c8d4@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20260811103832.28e5c8d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::6) To MW4PR12MB6802.namprd12.prod.outlook.com
 (2603:10b6:303:20f::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6802:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: aac4599d-83dc-404b-0300-08def88f206b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|5023799004|10067099003|22082099003|6133799003|4143699003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	VW7K4QwTayE6BPDlql9wVysBeH6ONLE0hCuFlnSB2jnbNfsW63c3Km0IzJG47LBIfGpcSkemNEel/F6dyPagUE9A3s6CLre/bWhnFJWj96ypnoBuhDaHnNpSPA+KBUqWBQMn5tgqg8J2dl7KPFAhQjuzZd5Gyji9h9sTD1KR/ijAqR89Hk5Gu8LEYDYgwTD6oObIcuNZWcNWJq6NeMWH9BSIuW2HiY5E8L/avtMT1ApGx6vySXokS4fC8Xzjqy7Zp30IdpPNVlId+05GyIVTKB7bzKopazP99CTnKi3hAyGukIn/Q6jAV0da/B9r+vwXZbY2Y5CPNy22o82JG3nm1Bs/vH9voaWU9veF4oywuLrSbZPsDgYQshoNHIILULzfjwfBYvBNB9JjbZXU++NoJxlRQQWu9ts7E2zxgwxBKIk4lCGLVkli8O1ddqYXDVmUAhm53A99RxiAPakY52GzGR/h93KMXGQ/ie3Je3PW/Fv+9CLPQbwihuSYoV7akmNFfna0CVIZWUt2Pq4FYu7o44scKwqUegD6io5365bCawCPJtVdC0CAGGMMqiR/HfEN1CgZiyamY8KkLFiJFQTmHXp+zfZZCkCVIIIVdQGjOlu3PGnKmSM55sc3S8P5BeVN4PnTT5PpXlvBRwctI3kUAlaR4eO7jtS7PGehxI00GIY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(6133799003)(4143699003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME53Z3g5UnNwOUJkQkVMdmEwUGRWYXppbVA5c3huMWo3T1g5UnVmT3J2TWJi?=
 =?utf-8?B?SURTLzRHTkZicUNESkVXZnl4ZytyaDhIK3RGdEw0QUdFdmd0dDZBRC9NdERh?=
 =?utf-8?B?bG5nS0VrNlZKclVMbjNNdFBLTU1CV29uRG1iOUZMU0lNT2t1ck5QWXhSZTlG?=
 =?utf-8?B?ODd6bEFLVERYTUhTNmV5QWZHY3J6WFpnZ0kwQmpoRTJ4ekFLdmZkTythYUh3?=
 =?utf-8?B?WDFIOWhpbGhINmk4WWpwRFlOVEdXQm5hV3VwS0FEK3pZNGN6bk1QeDlOMGV5?=
 =?utf-8?B?blNFa2J5Z01BNythWklCaENkMkYxbi9XOEFxRDRUVEVYRVk1VTNMbmdobXYw?=
 =?utf-8?B?cFpCeFh5QkFDcHFnZUw2ZG4zVm5rR255bVFlTk95ZytIaWp3dG03VTZxTXFQ?=
 =?utf-8?B?d05CazNNKzQ4dlhITy9aTS9IQWdaNDJEUExZMjRJd2M4aFdiaDducXJuT0do?=
 =?utf-8?B?YWplYUpNc2NCRjY0VE9kdXlMWTRidWt2cUgxMS9QeDFTSXBoVWhPcmg0TDdJ?=
 =?utf-8?B?aHFwTHpvVFZPRlRTTkdwUDVhdEdHdGhVSSs2MFhpR0JpN1VUd3IzTFpBcGFW?=
 =?utf-8?B?bXRYUTFPS0l0WDIyNDJ3a0lRUHEvTWZQMUg3THRId3duVHBoeEMvNjdCQ2Ey?=
 =?utf-8?B?ZlRCbm1JaVl4SER5YnlNVXhIbllGSUs0ZFVKMGFqVGNrQzFqdzU5c2RmK0dK?=
 =?utf-8?B?SmQ0S0d0TlNHcWxwZFE0WG9QYlhrSllIeVdJOWhFNlN5Skk1aUdOR0lmQnlz?=
 =?utf-8?B?Q2R3QXFBZFFKcldhZzdwMTdLYWs3cmpCTldxWkl3em9NdlQvTFZUOHdQelA3?=
 =?utf-8?B?NDd3VC81WmlJMlRuZFJvOXNYbG94NGRYdHNqZnlnV0hnbWJ1eGo0Zm1BN0lM?=
 =?utf-8?B?UldCL3BrYVEwUGNET3c4MVFDMmREandVdnBnU2ZnUU1RMExLbGpxUWdwK3Zo?=
 =?utf-8?B?N2lEdkpCOXZxVDFYMk1SeUp5YVZGelMrVDV2Ykpjd0E4UXkzNG5qcXZBaUpM?=
 =?utf-8?B?cVNzMndhYnROL0Y2QklrYWR3OHdaVS9DQnJ6RU5jejNQdkN0RWJnUWt3dGR0?=
 =?utf-8?B?WXBzVERXditjRWZSaXptUzZybU4wT3o2VWtFeFVXU28vRGpEUUFsNkViZmds?=
 =?utf-8?B?OW9YUWIySm9UYnU4TDY0eGVIN0tYSzJQR2hsbHVmSFZtZWdXY2VLbE9xNmxu?=
 =?utf-8?B?ckMzeXdWbUNlcUF0Q3I1bG8vRGRYVExxRmZjd0JzeUNhanhXaU9SY2ZWdGNi?=
 =?utf-8?B?MElubDB5Z0Rsb2JwWG1WUjZRWGVwTDBMdmc2Lyt2aGEwclFtUHFOVlJOcmsr?=
 =?utf-8?B?WHQweTBQZ1JuZjJYWXNMT2lRNUJNSEVkL1dsVjNseTE4NklWMy9SY0grYTAr?=
 =?utf-8?B?MUZGSmJkWHNxbVpIcGNjbUdNUWQwaW9xZWRzM0tjNm9XdDhWL2FRSm80Q0JR?=
 =?utf-8?B?a1B2TGtWVm5OZlh0d0FOU3pVNFp2N2xDR3JTRjZXcjFKWFJVaXk0SURmWHhR?=
 =?utf-8?B?Q1R0OXlLZXUxYXhYK0M3bXhCSTllTFJjeVREdEN2TFZCZmN2QWVxTytkZXd1?=
 =?utf-8?B?N1dkeFc5SExranBua1FZclRVYXh6eklRdnMydjAyUytBaVJNVmxETWlkTDZa?=
 =?utf-8?B?bWNWZzMzcE02anNlZmlJRXoyVVVhNzc0YzJuMTU0d0tYSmhyVlNQRUdYZVEv?=
 =?utf-8?B?UHBmREpoRkl5bG5qWElvOGovLy9pUGZJQXkxdWVuRGtNUC9HRWpZbzhuQjFG?=
 =?utf-8?B?MnpXUys2NzRMbEo3N0ZSQzFNc2xkbHJtY0pZT0ozZkVMa2NLQnNHL3UvU2xp?=
 =?utf-8?B?ODJlQkZLTzR1OEpITW5xV1c2dHJBTWpWNXlpUUUvVDlQMVZjUmI5OTEwVlpw?=
 =?utf-8?B?OS91a0k0aSt3ZHJPVG1sMXpFdXFpNE1nTDdUWkcrckN5ZDdBamJoSkc3QU9u?=
 =?utf-8?B?MFYzMzRvb2FjTkRiVSszQzBabFhUZmk5TFdScm5YUE5nVlRsQXBmNnByMVVz?=
 =?utf-8?B?WDNxYkxHUjBnNDNyWUhTcmw1aEJvUHpjMktCNXNyNUlobUhnSkRLY2VlbTdJ?=
 =?utf-8?B?Qkhkdkl5cjRzTmlqbDBNbWl2L3hWWE1uak13WFBjMGY1eUgzcFVidXF4cytj?=
 =?utf-8?B?T1dMNFZydnBKS3pDRmZobjNXRlNVMDJIZTk3RlJ3MWNRK3dJUWZrUnRSTkZX?=
 =?utf-8?B?Z3dmbHBub3F6Q3lGbEdXZElHNjdNVzhHZXRKdDVYUEljQWI3WVJOdEppbHdW?=
 =?utf-8?B?aHJub1ozMzRmZ0dHMWc5eDBwSXpEYThqcEM4VHVCVjExWjRQVXVOa3NQK0ZO?=
 =?utf-8?Q?64x7qFm5wqvefp7K7e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac4599d-83dc-404b-0300-08def88f206b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:31:14.5988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCLMGdYXhekg5qm10oomdxWsmBs8c0gsA6MJavKJGfQj5mPuiXHbCL+E2+EBIXNGkEc7wK7kGI0znCc1duiz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

On 11/08/2026 20:38, Jakub Kicinski wrote:
> On Tue, 11 Aug 2026 19:57:31 +0300 Nimrod Oren wrote:
>> On 11/08/2026 18:04, Jakub Kicinski wrote:
>>> On Tue, 11 Aug 2026 10:20:52 +0300 Nimrod Oren wrote:  
>>>> On 04/08/2026 19:45, Jakub Kicinski wrote:  
>>  [...]  
>>>>
>>>> Seems like the bigger culprit is the earlier xdp test, which leaves MTU
>>>> at 9000:
>>>>
>>>> # # Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed
>>>> # # Defer Exception| CMD: ip link set dev ens25f1np1 mtu 1500 xdpdrv off
>>>> # # Defer Exception|   EXIT: -15
>>>> # # Defer Exception|
>>>> # not ok 17 xdp.test_xdp_native_adjst_head_grow_data.ipv4
>>>> # # Totals: pass:14 fail:3 xfail:0 xpass:0 skip:0 error:0
>>>> not ok 1 selftests: drivers/net: xdp.py # TIMEOUT 360 seconds
>>>>
>>>> https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/13-xdp-py/stdout  
>>>
>>> Ah, well spotted. That's the test timeout, I'll bump the timeout from
>>> the current 6min to 10min. Once it passes we'll know the true time
>>> needed, and we shall set the timeout to 150% of the expected case..
>>
>> Sounds good, thanks.
> 
> 10min wasn't enough, bumping to 15min :(
> 

In these runs xdp-py took ~9.5 minutes. Both pp-alloc and rss-api tests
passed:

https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/774403/test-outputs/

https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/774889/test-outputs/

https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/775361/test-outputs/

>>>> I'll try to reproduce this internally and investigate what happened.
>>>>
>>>> Also, I noticed that the pp-alloc test isn't properly restoring the rx
>>>> ring size due to the timeout. In the subsequent retry, it's attempting
>>>> to double it again, this time from 2K to 4K:
>>>>
>>>> # # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G',
>>>> 'ens25f1np1', 'rx', '4096']' timed out after 20 seconds
>>>> # # Exception|
>>>> # not ok 1 pp_alloc_fail.test_pp_alloc
>>>>
>>>> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py-retry/stdout
>>>>
>>>> The high MTU and ring size along with the heavy debug kernel likely make
>>>> the pp-alloc test significantly slower. I'll also prepare a patch to fix
>>>> this pp-alloc cleanup issue.  
>>>
>>> To be clear - if the commands time out - how can we fix the cleanup?
>>> Or do you mean some other bug?  
>>
>> In the pp-alloc test, the ring size command timed out, but the change
>> was still applied in the end.
>>
>> Currently that test only attempts to restore the original ring size if
>> the set command returns successfully. This case makes me think that it
>> should attempt the restoration regardless...
> 
> Would the defer() not time out as well if the command to apply 
> the config timed out? Any idea what the main time consumer is 
> for the reconfig? It can't be anything device related since 
> the device isn't really impacted by kernel config options...

It looks like most of the time is being spent in SLUB debugging. In the
pp-alloc test, reconfiguration runs while background traffic is active.
The SLUB overhead disappears a short while after the test traffic stops,
so a deferred restore command is more likely to succeed.

