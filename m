Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8438DC73;
	Sun, 18 Oct 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339136; cv=fail; b=Gw2XpvfmcVXd+htsPafcPnU2BK7cmoximZMPmdGQzcI++gckDhLl+lRDiFjBUZBDL1ZzfiRtpceRfROw1D5GK5+XTmAx+2QRo79YDN/lQpSa1sRhpb9BwNLzkpR8mNhlLsFz1YCxcKzXOONVBGGcip5KDHetUjqiveyCPc4PJWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339136; c=relaxed/simple;
	bh=xGPqwUyAwkEDqLlVUWLbEO5l0ELGkWzEB8RKGwUU2aY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMlCKtqGkB+0qX3j2ctgKeqMsvuV2WwjFYNosYMaT4DSheetcCqllEviYR7OpyZ6xmeaqXVvC6U2c9kv2Jdp4fSmr/L3ioeIcHGmO0CVz0KuRNTsQJtdVWxmpuAXVCzs8yaqKKgNLSR6U1Q24finiSICDkUU9C8DOBt+mpiAls0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z7IGs/b+; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z7IGs/b+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgQ7H9IxNBUpwM4DLD1Rswyp09grmahTdMoCyWs8WBd8gXx/dO0pdVLQAE9K2unzP+qihKg/gw7yr/aIiuquobDD3yLyN8IYXch6l+G09KPToEbOkUbqLGoX0V/mvJ9S1wI25sU14IVDUaQOZ0VfuQ5d6PsXdQKfxzzfh8EXU1mtgq5MCify5qrN//n4YMWe3iSLSixPcmw3cNpzhCDFlfj+RHDYhuJkcwcKh/auLv1+N3BqbJZrnnlvyFTp7qUy2t8Rss0iPYasMHS0/ZA1A0I6w2zo/Tc5LFyRlulkEMvDMmWE7SXlCKca0dfoCVzaAeSFREEXYGR5XWar+sET7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hblpFLutTRpEz0J94/3w1nXZD1bst0nBnSKId5Bje8=;
 b=r+4dWxj6rqqRzaYR4BZip2X5GFwItmUHUQMbDemdhXEcuOD4jQklms89ABwGWfhRe3UdOhIvg3zenGPnobOXM/bQBVpB85NtBlyQTTdPe+/qlXLFBrCc+8To5AptAzgbN/aBFVpwQ2UitWDSmbuwx/Z/fIEE8eZOovwS1rANzLrMGSMb0GDec4n0j3AXK7x3aiFr99TbxbrjGIXDz9n+3u5wBRJ4WX/ywvkbm+3RpAZHLQhZcUhkBMas/1rTrl2jS5VUezisr0bn0iWUcSlf1vh0cDDBqGQrA65Q1QMzSpQaPLl3TnCrCIJGvVSMM1/DLz+wQrQjheAIiYJNlT2woA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hblpFLutTRpEz0J94/3w1nXZD1bst0nBnSKId5Bje8=;
 b=Z7IGs/b+TR1s9De/c+b2FIu8Qjuzl8RBX54Yt8f/E/HJUmbLRAreVZ1k5hBqLMe54bLFNjpsgHzWRaFoRwgyCuQAf82RJQa5YJV+A7w8KuYxomLXtPNb73evMxgQtwXW7ntdPcrtCur7jBBZUqoUsq6EybaQg/YMKxsWRa1CC1bp42yjgqSzfbh8V4Tv4tnhIVHHKPA/4WpZ9XUzArMm9b4cokBftRv8pZHFY0FgWz7Ds46MvFhYhSgoITNvcHOwR58chGFm00lm2s1vRGLHIkY2sXpyyXkyJFAQDmr2gp4d5sF39ZVR5Axn5IDOPXJm66lif5LPFRmAB1SxoOa6nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 15:58:51 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%4]) with mapi id 15.21.0522.013; Sun, 18 Oct 2026
 15:58:50 +0000
Message-ID: <49c589b9-054d-4f92-ba80-b095571472bb@nvidia.com>
Date: Sun, 18 Oct 2026 18:58:39 +0300
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 net] net: skbuff: don't copy alloc_cpu in skb header
 copies
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261013155658.2196020-1-cjubran@nvidia.com>
 <CAL+tcoDJx+suVKWjuHDMVMNThK1SS_a=0t1FkUninHnsAkraGg@mail.gmail.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <CAL+tcoDJx+suVKWjuHDMVMNThK1SS_a=0t1FkUninHnsAkraGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25b::9) To DM4PR12MB9734.namprd12.prod.outlook.com
 (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 91281c63-badc-406c-e165-08df2d30b3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009223027099003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S1FToFtFIhWOJ/PWSFvOZJLyy8wXhiOMBa7dDpa1nZeumZ2B7rs5XICFrguIpW+ngBonVvVSOy5LJR5kw0zKxiz2khQffCltyrOuZxOVJ4IHFpavpF83TuoUstOIa3fZOt4NhmnzaGdVZNDpka2uiyBzZ6n76jk0G2xes/l/LRnwM4Di5A44qbPvXH241GN3fl3v8PFTvPKSpEVkZWwgDxxZrVqK/gnBX27DY0+nzlzSHvHaqCdDH9Cc5++M4L78UrAAErOGH9v+ZKu+mZXlJgnB0CuMM8bUiySaIhRl065VhwzjNFmNGogYJYwNpqSH3I/2/xjECrAuEW9SowTb3etz2iB7DVUdj6pBe/4mCfH69a4G3P0/ty1JVcz9fiWb85z3jKYzlguQH9mwXA3GdaF09GsUB9wLukA9IY/QdSgSwrjW8nHW/AK85i2qDTrwBsfsFsVkqkFYd+5PbLcQhgT5jHJQpN4cV/a01v4ezr4swg6qDtOq0h1Y07KIGEShuvA0Cd/72/tDf81cfxm/hPMQs1EpevB8IEaGe9XD1UbcRIfdLdPA48G3b0NgtbXeZgmNwVBl63uGpokESJK0AOJPb5Vxv/N7LnFDBubF9Z2YeibbCA9Nobn8zEQKFiguG/ubh4hjhHFoCH0/uWR6z9pJsKeP1m28ujj15kucT+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnR0M2RQL3dBV3pLUFMvT05tRHVXV1I2SFh2NEJTVjJuVjB0TXk0STdFbjRn?=
 =?utf-8?B?Q3JseWYxeXlmUVFheWIxNE5hSHlaUEw5RFVUMTlYRllUYW5TSWdOdUpzaXow?=
 =?utf-8?B?eTRvSERDckRuOUxmb3V3OGtqNWNoTm5lWEgvdExWL3dwTHU5bG5RMjVwWXQ3?=
 =?utf-8?B?Zkg2SWZKTTh0YlZiNmFOdTBsbjRGeG9tOTM2ayt5bUhaM05FbHJFeGNDUzhB?=
 =?utf-8?B?cWhibTAva2l6eTFlMkpOUVBXOTltUGlpNlNZc2ZKYjlmQ2gweURINjBXbVVW?=
 =?utf-8?B?RDhNbjlLWE9kMFRBSUh6eDBRdWdPazR6V282amZyR2VyZ25rMkIrekpEUk5G?=
 =?utf-8?B?Y0RvWDJqbWM5WG1EVXVTb0lYZURtdjB5cnVJWXVrc2tnV2N2allNUmNoUHRC?=
 =?utf-8?B?UjdBZnE4SlpiUHhKRVdpaC9VMlhRbm9yZC9YM3FrOWZPSjAwTUtGQ1hYYUJQ?=
 =?utf-8?B?TVRKaHp0amQzbnRTWkZSMnVqR1o5NEx5Q1VhbmkvNWNlNDV0SjVseVZEN1BX?=
 =?utf-8?B?MHM2a3pTOEFhMWdsWjNuVll5Z3I1MDFHd3dlTUNMazFTY1grdHltaXZIRlRs?=
 =?utf-8?B?Q2NuR0FEQlhVRGRWVE5rTHpGZDVYTnBLdEQ1S0pwTDd6NFp3M3B1WkFTSU1D?=
 =?utf-8?B?K1pHR3Nvd1A5R0xQSVZ0Nkh5NGJORUZaM1YwSFdlMW1ickZRSmkrTGxlRURD?=
 =?utf-8?B?UE5SSUxMSHkvR3FkYVhRWEZjcS9iVmw2TnlHZFR2VzBpNUVoY1crbFdtVVZR?=
 =?utf-8?B?ckJ2dG5PR0hTbXJZYjhxaDJYak9nanU4OHhHRS9MdE02UHhUajYyZURKTity?=
 =?utf-8?B?ZDd6d29ZcWlTeVA4MXBQU09keXBYNVQ1TTZDa1l0MzI3WVY1cEhQMFp0Mi9v?=
 =?utf-8?B?aTh0cEIvUWM0YjBqVmp4M2paajBrM1pRMTdwQmlsc1RSY0MxcnN5bmdhUGUv?=
 =?utf-8?B?S1VnUVpyRE8wKzE5NjZWdDlKblMzcnJjemZFbERNT0QrWXdtNmhvNkFwWGZt?=
 =?utf-8?B?bUwxSlJIbmUyQUs0Qk5lQVpRL3VyODIxMDIrRGZ0VHlZcGlXWGlqOCtHK1h0?=
 =?utf-8?B?VVJ4YzJFSUFOU0JvVjRZY1Z3Z3h6Y2tsbkZwZDdLYU1qK0E2MFBOMmZhdXFD?=
 =?utf-8?B?dk5KUCs1RUs0eWprQTUrRHRJMVlhdHd6UWhYVjNPOVJmN01NazF0ZXJFMFQv?=
 =?utf-8?B?S0lZZEUveFEwUllseW15a0U0cnBLZHQ0TjJVNWl4QXNBWkFpVzJKYXl2T2tS?=
 =?utf-8?B?UGFXZ214YzZ4NUZYNXEvVW1jbG5GcVdYZWtuL1lqeGplVnl1dS9mQ1RSVFhm?=
 =?utf-8?B?NGk1NlY5cWZRL0tvR250RDVvVDhmK0hDdWlTOFdRZFlycVJETVd2QmNpeUlh?=
 =?utf-8?B?SXJlQ0g1bHRmWktnOW5wVjJMV2dNTDZFTDJKOURGc3N3aEVOSDViMml1OXo4?=
 =?utf-8?B?YzBoU1dGSFdFbldWMnR3ek5OL0YyMXh0UWREYndDWDJST3hvcUZpanZSSUVn?=
 =?utf-8?B?YzlKVWIzaXFpMDM1MjU1TU9naUZnUWhPMDZjbWpXRldOeVpualR0eHJPTGhE?=
 =?utf-8?B?U0ViWXBZMnRhZVZhdUlKdEVmWlA5ZUNoMXloV1hXOUxvMUN4cmFPUysrYUhV?=
 =?utf-8?B?Q0NKV2JwTGVLdFp5N3MwbC9zNG9SOU1WUFpmN2I0UXQwVklzRUFPaUIxajAy?=
 =?utf-8?B?TExXNTRON2sxTXBOY1hFa0ZrdVU1MHplV21uZ3ZFT3hhWllPQ2dnRWZRQzFB?=
 =?utf-8?B?M0hlV1EwZDB6L1hkdjdmaTNyNE5ldXM0RTJhajFjbDQxdEJwdmlxRGJZMm04?=
 =?utf-8?B?aXdyUlk2Qjlta1lPWHFIZ2ZWdTBXblpmQ2lwa3liWFphaXdEM0RQamJCazIz?=
 =?utf-8?B?a1hIeVNhN1grV1hSL3J1WkFOV0haeG5ncG43SDRrUGxOVndLL1JwZjN6Vk01?=
 =?utf-8?B?eXZuSEQwYzd3RDNUSGw0MkpHR3Fra2J0YS8vT25PSC9VQUpHVGhiczJBOWJs?=
 =?utf-8?B?OTVncWhuVDkwM3UrenBxbzhSbDF3enFERDN0bDRQQ1lvZkJ1Q0EzM0x6RGJJ?=
 =?utf-8?B?dHhKZzkrdUd1UFQrdlR6cUpyZkdpSzlrbGRLemtZZ3pKKzUzTkpLS0VRaFZq?=
 =?utf-8?B?eDhUVEJxR200anFyYy9SVXpqaXpyay91OFJyZFZQUVdhR2I4VUpBQ1NFQ21y?=
 =?utf-8?B?aGliN1ZLNk56bzFJNHVnR2lHVHpJMzNpNXQ3a0REbjg3aGpMLzc3aDNJVlFq?=
 =?utf-8?B?MjE1T2IzNytGYUU1ZlhJQU5JNFl2bFV1SGZnaHB0N3ZZQ1hLdkhCSThLcHVD?=
 =?utf-8?Q?nnSKaNldcEP3iJPyYT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91281c63-badc-406c-e165-08df2d30b3cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 15:58:50.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czM/ok3s0x7vmYRzc5zA2a1lOa8gSRzAb+8hDC6bNxHKZIivR+7bF5edKMPW/cRcPwH/DSwoovTQAbUlaYiP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160


On 16/10/2026 11:11, Jason Xing wrote:
> On Tue, Oct 13, 2026 at 11:59 PM Carolina Jubran <cjubran@nvidia.com> wrote:
>> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
>> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
>> headers group copied by __copy_skb_header().
>>
>> This is wrong for newly allocated skbs. For example, skb_segment()
>> allocates a new skb and records the current CPU in alloc_cpu, but
>> __copy_skb_header() overwrites it with the value from the original skb.
>>
>> If the original skb was allocated on another CPU, the segment may later
>> be treated as remotely allocated and unnecessarily deferred there when
>> it is freed.
>>
>> Move alloc_cpu out of the headers group so it is preserved across
>> header copies. Initialize it explicitly in skb_clone(), which allocates
> nit: s/Initialize/Copying
>
>> the skb object directly instead of going through __alloc_skb().
>>
>> This was discovered while investigating a throughput regression with
>> software IPsec. The load used 512 IPsec tunnels carrying traffic over
>> VXLAN, with 512 parallel iperf3 flows and an MTU of 4500.
>>
>> Before the fix:
>>
>>    16.09%  queued_spin_lock_slowpath
>>               |
>>               --15.90%--_raw_spin_lock_irqsave
>>                         |
>>                         --9.37%--__slab_free
>>                                   kfree
>>                                   skb_release_data
>>                                   napi_consume_skb
>>                                   mlx5e_poll_tx_cq
>>
>> After the fix:
>>
>>     6.84%  queued_spin_lock_slowpath
>>               |
>>               --6.57%--_raw_spin_lock_irqsave
>>                        |
>>                        --5.00%--__slab_free
>>                                  kfree
>>                                  skb_release_data
>>                                  napi_consume_skb
>>                                  mlx5e_poll_tx_cq
>>
>> Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Thanks. Overall it looks good to me:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Thanks for the review!
>> ---
>>   include/linux/skbuff.h | 2 +-
>>   net/core/skbuff.c      | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>> ---
>> V2 log:
>> - Move alloc_cpu after the headers group and fix the indentation. (Eric Dumazet)
>> ---
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index a3ff380d43f01..b3272d379409e 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -1036,7 +1036,6 @@ struct sk_buff {
>>          __u16                   tc_index;       /* traffic control index */
>>   #endif
>>
>> -       u16                     alloc_cpu;
>>
> nit: no blank line here after you remove it


Yeah, I will drop one line. Thanks

>
>>          union {
>>                  __wsum          csum;
>> @@ -1088,6 +1087,7 @@ struct sk_buff {
>>
>>          ); /* end headers group */
>>
>> +       u16                     alloc_cpu;
>>          /* These elements must be at the end, see alloc_skb() for details.  */
>>          sk_buff_data_t          tail;
>>          sk_buff_data_t          end;
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 41beaf625421a..3d82eb87f4582 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -1593,7 +1593,6 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>>   #ifdef CONFIG_NET_RX_BUSY_POLL
>>          CHECK_SKB_FIELD(napi_id);
>>   #endif
>> -       CHECK_SKB_FIELD(alloc_cpu);
>>   #ifdef CONFIG_XPS
>>          CHECK_SKB_FIELD(sender_cpu);
>>   #endif
>> @@ -1618,6 +1617,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb)
>>          C(len);
>>          C(data_len);
>>          C(mac_len);
>> +       C(alloc_cpu);
> One minor question: does it affect the following two cases:
> 1) skb_morph()
> 2) else branch in skb_clone()
>
> Looking at the above logic, I think as to #2 point it seems the impact
> doesn't matter...

For skb_morph() this patch does not change the existing behavior.
skb_morph() reuses an existing destination skb and turns it into a clone of
src by calling __skb_clone(dst, src).
Before this patch, alloc_cpu was part of the headers group, so
__copy_skb_header() inside __skb_clone() copied src->alloc_cpu to
dst->alloc_cpu implicitly.
After moving alloc_cpu out of the headers group, the explicit
C(alloc_cpu);
in __skb_clone() preserves exactly the same behavior.


>
> And I'm a bit confused reading the allocation process because there
> are two possible split allocations for the skb structure itself and
> the head/data area. They might run on different cpus, which means it's
> hard for 'alloc_cpu" to choose appropriate one to free under this
> condition.

Good point. The current documentation describes alloc_cpu as the CPU
that allocated the skb, while skb_attempt_defer_free() refers to the
CPU that allocated the skb/pages.
So it seems that alloc_cpu is best effort for deferred freeing?


>
> Thanks,
> Jason
>
>>          n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
>>          n->cloned = 1;
>>          n->nohdr = 0;
>> --
>> 2.38.1
>>
