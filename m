Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289443B7760
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455462; cv=fail; b=Pt4oJjJVsk7Ewe2rlOkKyzhevZSm2IsZu3Mv3TfwPny/AoHn1QbBpjZTDtuUREhEmrYEMEIX43p1St7IWiu2XG0OxWOPIXIsbz4isRDniF82ji5HOAcAzWRc+SMFCkKefoN7PxVf2MrBIvE7CrbCt7MJhmwltPPV4JQH5HkHQ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455462; c=relaxed/simple;
	bh=yeWUTddq5o7Ixcn9kbiGLTw+HiYwHR0tzEKqlVEAGOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lSAgLAkVQFC5aZhcr0eG0MpxUxg6v80XUAhvavOZqUOJm71skPEWpn7V85dBJ6Ddsjbre3aGK+u1Bhrro/6AxW7HMI2ILY6Q6FNDnqY3Wx7pbR7C2TfJaf9ZM/JoYjM5eZkSDPoCFmCVndG3g9MK5shLCD1oj9bPWATv5jmd+Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZ1i3ie5; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZ1i3ie5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDPGXwUyx4YLNfAjQvq+ASr8xO+aMj5sEU0GOLN6GYMCENETwVT8AyvdxGhJKHI3N3JHe1+6rCe5q6mOCAiWDboDxsOOVGWlow8fm9U1Bkqxg7nw1/NrqjHPom6vrbfjdDF3WDF2ptzEExScsMA/LUASRgkpWtUUL8PaAShnbNdlBKsq3T3UCepBY0yWeWilkNrxFXQb9mE+a48NUx5kQ+01vDMTPAKYavom7jj/MB4mVtnCxUWBY/5YtH74iSiXB3xDMegNEZpYJcYpOumEk6fc9BE1JRUAVNuQYb9L7AZNYg5YfFNk4pw/sNKDH/2Ur8WNHKvxX12nq4DRCJDvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgrgNmfJ1ev+SSS+91lZH/sty+Y8IS7KejMUXd3fnpg=;
 b=FMT+JIhzhaDOTJ+vvA4WZ9Jd102oaV6nRXgktLFy6N/202+ZQ75Wj9lfl5UdMa69pu94Eaj7H5pSHpANcNHrAfcSKdb1Y2wHE1/gtn0YQT50KuG+0eGI8b3RCKyoOc0JbWJJn1SDNfYpTK7+KGSj5TEeyJbQJUyVH/KIAexpZd4gLaFhv7+IYYVuD0zn3JFGEkbyLxepEPXEu7jgCjPtQmLrKa3NiuHP75NPUjGhhxy+T8zZ0hnCS7Pe40aEU6u8jxz63M9Ih50KeCg/HTUA2PxsHhES0Ie2STptfDxuMEnt9m2bZsk1rBpnUVlmQh12TrqLG+AIplJD3Oe5FRjVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgrgNmfJ1ev+SSS+91lZH/sty+Y8IS7KejMUXd3fnpg=;
 b=lZ1i3ie5g2Gc0p53i9IvNvPJD6lEQylQdCokWZFAbCZdhE8Sks45c0QXS72t8kybXLBO3Jw8B+3UbnTJWA0fsrDGkQXtA+YNjOkvmtJBCjR+Ltu78YvNg92QU55+aOf9OtzXraOl6+F0P4tVY7p6Ezr/MChcqUCYkaWPt7NL5/ItT2Zf9c5Bj0mXN73v1MrSpqfZHUwcH1b9R8xkgdTKHXO6zKbXmzcKeofIrp4yKQMXQwzS7zW+pPXVUFaezS5tnHimMZe+sytXUrLVyQQtcryvaUqr2Ht7YniMaHy5tjWsT08EwEH4mTmVTveUziYE1t3xCy9fXo855EXinYc89Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 8 Oct
 2026 10:30:53 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:30:53 +0000
Date: Thu, 8 Oct 2026 13:30:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org,
	horms@kernel.org, petrm@nvidia.com, rostedt@goodmis.org,
	daniel@iogearbox.net, ferenc@fejes.dev
Subject: Re: [PATCH net-next 2/3] ipv4: Pass netns to fib_table_lookup()
Message-ID: <20261008103045.GA1343979@shredder>
References: <20261006155454.853588-3-idosch@nvidia.com>
 <179141500789.434549.13454267658228381768@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179141500789.434549.13454267658228381768@kernel.org>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: a27862a4-1b84-4901-2be6-08df25273ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P/MFcPN84LjQej1dfGQderex4s1FVvlLnIGN9tTlqaafqYDNAMMRUH7yJ4Gb355jXaiFWlauDwnwXP1N6hw2qVspFMhQVJ3/LC8KIiulwwWhSAYEfcofGL8GYx/jlY7lkLqp0uCf93bndKy8Ui8dAKzfF1niK6+zAehWDdVC62obW26y+6er6mTHCLIJGkjQNgGcdOQVgNtJSaRIU/y/+04QjFy+Z/A13ujpOcAn2g41WOp/Vp8paj15/FJxKeDTTM8j9uEDt1Y4v301N0z1O8vlyc4AIBdA1Mwb8UxwkFbN4LIjYeaCx0QhuH5GgKWS2cA8hi1T8t+Esqp8grz53zgGnJXHEbMxk2kvQ2XxdtQn0jg6EJPOQNVFA3MN/UYMv8aMjsdJPnAiQbUMvtsAnSz7pVJJTel2Fnxec3e0/GXQT3CsAU+lc4V6hkE0I8CZjIcbKtdV6H9y5lpR8KnAXLFxB4CRcIHpQjZjlVxQk/zV7ihOEqjepnvd/naV0L7WzDOIWXgTBbN3qLeUJRJicu0VNqkdHBncHxqFk8r36rIzOC1y2lr/iLrb90LuaSugFOYxDSeDCn/pd67YGgoxC39/eye4UnPfxeL1M1gBj3upVSB0bvMZKroUECbPNN/pZ83sL34QszraWLhHw8JHjcNhwBi2rQMwdAQQEcqdNiY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2c2SEpaaHNNQnhoQTV4cjRYQlRuNWRFNkZ2K1FnTUdLbi9HUVY5WWpoOTZl?=
 =?utf-8?B?RDBxQmdBQ2h6bnNtQW5HdFMrSUZ5Z1I2NkFjdUZqR0grOXMwaEVIdkNOVHBO?=
 =?utf-8?B?bWpkejgwbDJKMDRXV3REeTd4YzhOQUpxSG9JY1liMzBpanQvMEJoQmFCWTRw?=
 =?utf-8?B?V1AwdERJa2tJS2JOQnJkU1N1K3d2QURxbXdnQW80ZzRDcGZvdTRnNkEvUm9L?=
 =?utf-8?B?TEJkSXdWTDRUU0svUTRweDl0Y0h4dHh1RVJCQ0JnSEFmQSt0U2hEc3kyMmF4?=
 =?utf-8?B?SWx4VWh4NWplYkRLaXplOStJSXBjUGRGUnRsOXdkdkx6NEQ4N3RodzBacmRT?=
 =?utf-8?B?cmpRaTFZTWVpc0JmcGVzYzVVU2Q2SUNacEpjVmttQ2lHaFYwNms2TEhhMHdG?=
 =?utf-8?B?bENlQzdoWXA3ZVZqSFZ0U2N1QlpscVVMVysvSGRZczh4U3JSbFl2Y0x5OXNY?=
 =?utf-8?B?R1lsSjg3eUF6VThPQUhJTWJlR0ZaZkUzNjUzYUQxd09nRXpXb01OdzhQR3p4?=
 =?utf-8?B?QnhKMExzUWJIZWVRWDBZWnhSdExPeE1aYjhnMUtVSzBYYkxXazBwQ1cwRTJm?=
 =?utf-8?B?ZW5KcmZsZHdvbTNhZE9ldTJxVHY4aUlkdlI2V2ZhY1FxMS9nNnlIeHU5YWJj?=
 =?utf-8?B?ekpTWEc1QS9vci9rcUx1ZVdXejNVVk91SXArck5TREJmUUJLSGJpZFJPa0tx?=
 =?utf-8?B?SW9HL2loaE5GZmxVZnAwdTNjQS9aWlcvNUhmTG5RZ25tMG1vRXVxQlptdFlo?=
 =?utf-8?B?T0EvY0tTMkUxMWo4ZVhwRTZJVmp5bGo5SFRVdnBzQVd1c1FOWnBraDZWK1hG?=
 =?utf-8?B?KzNrbEJ5dG0zVWV0cllIQU40enU4RG0rdVY2aFBnUXFqdkU5VU85ZmtFdklU?=
 =?utf-8?B?UkxVeDZZT2xsbElUbTBoQjl3dkowRE1zK0NzYVFQZktUemMyc241RzNQT3p0?=
 =?utf-8?B?WWY2bVJNelFjaXc3eG9ZM0ZRL0RZV0p0M1ZVMTFzczB2UHJQcFEwTi9kYlRX?=
 =?utf-8?B?R1g0L1ZQOStsQ29ySkxsYVcwYkduWVd0M3UwdWpZT1BiTmZQZld2KzhoMXZt?=
 =?utf-8?B?UkFXU1FsT1ZPakdMWFY3KzRyVDJTdERoM2NEcjJOMzFIT0ViSXFUL0NDMVNY?=
 =?utf-8?B?bTVHM3pxVjU0Y0N5Z1BtVUJ1OXErbkhRL2ZJOEhWbGp4cjliM2w5bjFwU3hQ?=
 =?utf-8?B?aHR5M3JDUlRjS1lRWVRaem1FeHNyK2FSY1dyRnJ5elhlV3BEYmkvVy85cEJa?=
 =?utf-8?B?K0pIZGlIYnFleUp4T0JyTVYxbnFtRkZOcjdtQlZPdDFyKzJGMXNyb0R0a25B?=
 =?utf-8?B?dEhCWTI5UWQ5VFdPcndCblhiMFpNZnMraTFSaHgyZWhKWjlxaVNsOFNYaHpB?=
 =?utf-8?B?WHlWKzJmTFF1M1Q0VUFTaUFGRUpjekxjZVhDdi9ncnliZG9OUW5wdVNrbG53?=
 =?utf-8?B?cWNEak5oa1MvZTE2UDV0V3NnNTVoazV1bHJDbldiL1Nab1J1MGZ5VkV2TW1O?=
 =?utf-8?B?OWxrTWZzTTBUZlo1dk5sQ2dLRVozVGhqZnMzdUJkSFhZMFhMN0dOY0JtOTBs?=
 =?utf-8?B?UDR4bE9BWFZ5ak5nUnlSRWs0b2dpbDBnWkZMUDFYVUNmWFdYODU5S1ZPdEk1?=
 =?utf-8?B?ZmEyNWVjZmdhNFdJQVJYUUJNc2theVFJMmZ2ZUNhaWtxSzd2SmNlZWRCNDk5?=
 =?utf-8?B?T2QvVlE3bHIreDZZTUx2WHQ3bmp1UTQxR1lLeWZnbXJaRUtXazcyMmQ1WFE1?=
 =?utf-8?B?M1huUmdZbXh0cDFSMmd1UnNOb1A5emxRZjUyWHErUEN5aTVlRHFCang3cFJI?=
 =?utf-8?B?L2JJbndFcFNzU1Z4Yk1ZdDkyTElvRml2TWxvSUMxMGpoYzlpbHNqbUxtc1RY?=
 =?utf-8?B?K1d5bFNoZDk4aERmTlVtLzdPWkxlMXV2UEpEa2hSY01IOCtBZVhlNmxKcWUx?=
 =?utf-8?B?L0tXZ0FqUEk1NnJZTitqSCtMaVVWZWYzckF4UmlIZmJkV0pPS0QvR1ZGcFFq?=
 =?utf-8?B?KzkzbkJGN0V4bHlSeUF5cDVjMjVGRU05SVBoNVp0N3JzcjVTdTBHZnhFZFR1?=
 =?utf-8?B?WDNadVlQQ2p6Um1mbGZ6SGRhT25semhKVllnc1ZOVXRkNDFQL2xXbUFERWZR?=
 =?utf-8?B?dHlCNmtySTl0R1ZLUjNTTlJCOHBKbWVXZGZ1dmlWZ0tZQzhzQ1FpSUtLVTZT?=
 =?utf-8?B?d2pWbTZCZXBBYjBTVERqcU1saUpWTkc5N2FwZkMxRndweTQ4WWZhQWZyNFNx?=
 =?utf-8?B?RmxsRWRCd2s5clJ5SkZsN0k3bGNCUHBYUE5rS3M2d3ZRczlJVjJ3bm9mdmNM?=
 =?utf-8?B?c2cyUFkvM3dCWGNOeUhUelNmRUpDcTFVRExyS1R1bUwvTHE5cCtkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27862a4-1b84-4901-2be6-08df25273ae8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:30:53.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7d+TXox0ZHDM63b+75nhb6/Q9hEFg+EjllX5JOO8NmUsiwKP36oqLMn+NJ10fGXM6n3N4PfjMzoCkZe+SsaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717

On Wed, Oct 07, 2026 at 11:16:47PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch adds `const struct net *net` as the new first
>   argument of the fib_table_lookup tracepoint.
> 
> Pre-existing issues:
> - [Low] This problem wasn't introduced by this patch, but the
>   fib_table_lookup trace event's TP_fast_assign leaves `__entry->gw4` (4…
> 
> --
> 
> ipv4: Pass netns to fib_table_lookup()
> 
> This commit adds a struct net argument to fib_table_lookup(). It passes
> that argument as the new first argument of the fib_table_lookup
> tracepoint and updates all callers. The next patch will use it to report
> the netns cookie in the tracepoint.
> 
> > diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
> > index feb28b359eff2..9a88060aa92e1 100644
> > --- a/include/trace/events/fib.h
> > +++ b/include/trace/events/fib.h
> > @@ -14,10 +14,10 @@
> >  
> >  TRACE_EVENT(fib_table_lookup,
> >  
> > -	TP_PROTO(u32 tb_id, const struct flowi4 *flp,
> > +	TP_PROTO(const struct net *net, u32 tb_id, const struct flowi4 *flp,
> >  		 const struct fib_nh_common *nhc, int err),
> >  
> > -	TP_ARGS(tb_id, flp, nhc, err),
> > +	TP_ARGS(net, tb_id, flp, nhc, err),
> 
> [Severity: Medium]
> Does the raw_tp_null_args[] table in kernel/bpf/btf.c need to change
> along with this prototype? It still has:
> 
> kernel/bpf/btf.c:raw_tp_null_args[] {
>     ...
> 	/* fib */
> 	{ "fib_table_lookup", 0x100 },
>     ...
> }
> 
> btf_ctx_access() applies this mask by argument position. It does this
> after skipping the hidden __data argument:
> 
> 	if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
> 		info->reg_type |= PTR_MAYBE_NULL;
> 
> Now that net sits at position 0, 0x100 marks arg 2 (flp) as
> PTR_MAYBE_NULL. nhc has moved to arg 3 and is no longer marked nullable.
> 
> nhc can be NULL at runtime. fib_table_lookup() in net/ipv4/fib_trie.c
> passes NULL for it on both -EAGAIN paths and on the out_reject path:
> 
> 	trace_fib_table_lookup(net, tb->tb_id, flp, NULL, -EAGAIN);
> 
> For tp_btf programs, the verifier would then treat nhc as a trusted
> non-NULL pointer. It would accept code that uses nhc without a NULL
> check.
> 
> The verifier would also reject valid programs that read flp fields
> directly. check_mem_access() only allows direct PTR_TO_BTF_ID access when
> !type_may_be_null(reg->type). Programs would be rejected even after they
> are updated for the new argument order, as the commit message asks.
> 
> Should the entry become { "fib_table_lookup", 0x1000 } in this patch?

I will simply make 'net' the last tracepoint argument. It will be
inconsistent with the IPv6 tracepoint, but it will avoid this problem
and won't break BPF programs that attach to the raw tracepoint.

> 
> The later "ipv4: Report netns cookie in fib_table_lookup tracepoint"
> patch in the series does not seem to change it. This also seems to
> contradict the "No functional changes intended" line in the commit
> message.
> 
> >  
> >  	TP_STRUCT__entry(
> >  		__field(	u32,	tb_id		)
> 
> [Severity: Low]
> This is a pre-existing issue and was not introduced by this patch. In
> this event, TP_fast_assign() seems to leave gw4 and gw6 unset when nhc
> is non-NULL and its gateway family is neither AF_INET nor AF_INET6:
> 
> 	if (nhc) {
> 		if (nhc->nhc_gw_family == AF_INET) {
> 			...
> 		} else if (nhc->nhc_gw_family == AF_INET6) {
> 			...
> 		}
> 	} else {
> 		p32 = (__be32 *) __entry->gw4;
> 		*p32 = 0;
> 		...
> 	}
> 
> This happens for gateway-less routes, such as the local and connected
> routes that fib_magic() sets up. For those routes, fib_nh_init() copies
> a gateway family of 0 into the nexthop.
> 
> TP_printk() always prints both arrays with "gw %pI4/%pI6c". The event
> payload is not cleared when it is reserved, so can this print stale bytes
> left by earlier events?
> 
> trace_buffered_event_enable() also allocates its per-CPU buffered-event
> page without __GFP_ZERO. Can up to 20 bytes of old page contents reach
> trace readers that way?
> 
> Would it make sense to zero gw4 and gw6 before the family-specific
> assignments?

Pre-existing. I will take care of it separately.

pw-bot: cr

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006155454.853588-1-idosch%40nvidia.com
