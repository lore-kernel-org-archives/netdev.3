Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44D38B7D8;
	Tue, 25 Aug 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658761; cv=fail; b=uM1uhZ2H23xRna1COBTohxqgpSGhyWoOlVMUqcor/0KHdAT4mK2GGn2TbDS/wuZHnLltitoDti2Xc+H0T1kv/Sr/ayqxz9rJYmYIxKKIlQq2D/ohnK22cQyR60la/Yfectm7lsOtHxQwnWYH9bVOCbdc8nNtzsqmix9hBx/yLiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658761; c=relaxed/simple;
	bh=9ChB5qvqNjrK0o6OVIdgfMysLv4t3+64sNIa8zrgfWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5QltXcJvzFBTSVeNmUHKgyLhzONj+oDsG7YcenaPsAfga0IwzxcM5vBKd7mjosn/BOxJmYNcA29c8AEL7zqC+gDLEwH7TKUYJa71WY8Niq/qSwoRfIcDLFoDacZ+Z7yom30RvL0OE2d7NbeJT/1Yy98UKcpw3CQUrbvOYY/fis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OTB48pQL; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OTB48pQL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geycMt2CzfjxmlPyNGDoEvkh6mmDkMSka9uGnad3HXk2tyOovM1b1ZhUmk20fUmfVLB7mvTX5s95wVJghh3xVt7eCL3eC3avPBZBVkFPnTUvQdhuDXya0R9PooVA10dmd+yBwKKYc1My0sdcCECCSqKZdeChxsitWIeUDMZlACIe+84qFZQzuICiE7d8BH/Sbsob7H4EG8ecTdIk9cZEDrcKogfBJa9EKBDaluvbOysIMvtHAHTXCErh4+HyHZhvVl7WI5OK/uys2gPNMEYHmPxqzsuHjNdZMa83LwfsOY6rrTE9l0GeVgef5dPDB4VRgRN237iRWT/W0c++lvDiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+rSbwTkqCCaQlvJc3aEHbLHRFfG1L5nnQ3bftjHsSo=;
 b=aJBcX2feepJDut4XvFb+81xpyljZLW68s8N8SFzLEzISFNHADFm2ZtylsMSCqdl3Mp6SMjzL+bdfhgvEUv/cNaZ5AdUBU8Fsgqe/pMCggfn1tw2f+8y7KLwyDdyqdT6UxwUo1wDOMXM2dzom31Ez8xF4qXlA9Vqd21DqYQWdmVC7iG9QMmrA9VTLb6kOGfN51W+otAeiq6hyEiapVQ5vrjMSL6M2pe2J18I+l9UgQeHrIa65+MJxSnZCjee7uUGYecoSNAhe4DWrfDAo4poW6gCU6FeHSrT1lXzdqilFo3/kq92/LOzr45XwPvjyy5+1tYYeO2NhqnwIymzEAPRxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+rSbwTkqCCaQlvJc3aEHbLHRFfG1L5nnQ3bftjHsSo=;
 b=OTB48pQLKTTKDMiNa1l2ERC837PclULHJt6/Fq6AqlaPwqPlAiJAzLTKQkVvQwYEWdOyIBuTCOdIstALd2W6yYDAJA/E3VpP7wilRrS7Rz1SO6R/C2sH23/kLTVlqoOyKJyUou1SQ3eg3DYYGANmH6SXT50SqMapFQXstZP9D+jkETC+jfRUTtmIcyl1OD9YdnOeKW4Go+6nmRLaPHg0AXipWqUN+GHcjA+kgt6TXtsOQFZxeGpw8/tHHmTRqN54tVBjyGeUERxDycdPdzFfPy0Mn9wCQEETu8P6EYXf3KxL9C/ODIAaBzrzmHUwBMnGfIk9jQokn6bInG4T9woD8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:52:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.010; Tue, 25 Aug 2026
 11:52:34 +0000
Date: Tue, 25 Aug 2026 14:52:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Lawrence Lee <lfqlee314@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>, Jaehee Park <jhpark1013@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] ipv6: update NUD_FAILED neighbors from NA messages
Message-ID: <20260825115226.GA1338930@shredder>
References: <20260813233344.445265-1-lfqlee314@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813233344.445265-1-lfqlee314@gmail.com>
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf0d03e-535d-4793-36ed-08df029f5a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	lCNK0GZZNpPXZwzLomYoDOmD+UDnhR2Y8OvFSJPqugBpNSgC8C7P98PSDlPuYiAQpMd0WrLIVXZ5NNcY/+QfDyRPNWmA0xZ5tSbJrLfdQeNveAUkjCorSB4I0rhLUYfa675og8KWm40DqkzgUjpX7i+pwQmwKm/1AdS8xavOutpuKMrk/AmN5cHOUrefYmkciUXYaz2orPpcIUoecsl0ela9fYdqoaJoG0u73U/ANpoXRYAhgStkK+MpLO90Ku3p1zMKmYzeX8EYTwdl882u+wVmkKXCjN1YY/G47tNIy3KSE8ouRT2qCFxbiSaRuYuXUJZROvFJ/qtCRP7eMiDX3nQmWiUXJ8PjZqo5YAtBnWBjtD8NDrHLURShO1Vd6p498Lk7YsGKxZh5//5778XND1kJ0VAcE4Xjj4rYlu201UIieE1LqFK00x+Jv9MWp7oxC2XgxmR5q0CskUw4Yy+KX+w/siETpLzWVCW3YniZF7dQXShTjbjCRXdHp2jzp4IPzSpwzJCy0fw96ipsalyCS4V33BaOwlvUrbTRKsb11fppxFzzQIa8l2u3ujGzxEIPauNrOlLHemTyKWcBnmbbtci8wtdXjdVpSq4JywlNcqzEUnuyWylyvpS3uu5fgIvb97ZEkxV8ovWFVDU6EQX4sL1PWTpjNIzH+v8IZa5JQF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VpidgNdBS4ZIE0Oh/F8Nst2Pf3BaChqjp0XkRNgQPPs+POoYtv7VjZCmMEZ8?=
 =?us-ascii?Q?w1XJRbOhNnWialjJbTnds1aMdLAR+YmU+JoNBDx5IX3K80oz9dy44gKVyQ9s?=
 =?us-ascii?Q?ZUgCsZ+QWmDYxi72ZfQ9R7LBsW8r7u8xSltmVhNUUAJVQSXGxpjZqkjawj2+?=
 =?us-ascii?Q?F4zuwl9PCrfhdc0wzWzV3tPy22llmdiMz4v1eNeVyZq6BkKGZ1UADzmPL5u6?=
 =?us-ascii?Q?wYaxNNYeoAQIt49tBY9RK20BRHMxnqgSuv4Ny9GQ90eQBc/u6oBpq292XqVD?=
 =?us-ascii?Q?lR9oNoDtLCWCUk9/xSK52CPecP97k1aTETiEX6wxtOMfnb6I8hVpHbux4AQC?=
 =?us-ascii?Q?c0jviuQ30frEcce8/0hImEvaNURP4+adatGnjWxTgNcXQMcNo4F7KuvKcY54?=
 =?us-ascii?Q?JL0h80fjJThccMNCVIvyAPn/F9qrejJffmdkvI8nI4MAGamfZGzIXyW47N5K?=
 =?us-ascii?Q?VyBf1FB/4QES2SDCvwGEuETDy+fdfBKDFhkWB3NJMM9X9YAR1ucsWF2gYvIh?=
 =?us-ascii?Q?3Fn8oypKSZk8QklrLzDTR222ZUW/79Twgbo2S/k6+xKZ0iWTlISzu6WWRO9u?=
 =?us-ascii?Q?bwOqXeeaY2EqSVS9bpLL1rY0xIQXH8VHHzZNK0iM50YHzkNSd3he7CGdfWtU?=
 =?us-ascii?Q?QS2PY+nUq7OGGSZPUhB6QkRBJ9Ac/HaW7t0uUgdfYLJ8o6lBtB44FVnA0W6x?=
 =?us-ascii?Q?BMMXgYDFdIsRT0da51JLtO2ZmpkYMxoCx/3REC+cfCNhE6KSeprFmstweqhv?=
 =?us-ascii?Q?qaSv5Wfxdunrlji9Q08OP+tF0EyGTODrTDqVO70ozppT5uTf2CC9tpVIj6p4?=
 =?us-ascii?Q?7MG+noB1aLLbo3RFPxxauqKzgCp4Gjenz3JJvXq1kKJr6MOBVZRJ9AYOWnag?=
 =?us-ascii?Q?cJvc8lf5iAf6XFH8ymxAMR1vH6ebbMRzbkvsdQUti0OCbV5ybsnCT4ZRjkSU?=
 =?us-ascii?Q?QayzvnGHxD9lfUM2K/D6eKk0QEoayLWIxbX3LXAQgaet9GZ8If8eo3V3Ak2B?=
 =?us-ascii?Q?p+NiB7s8EFeBlrv6IvElaEW6b+u/AOyHfPaWyi8wuye3a56n+H2rw0ZUooWc?=
 =?us-ascii?Q?1qeQorQCd1ZIczZb/xXyX7E7rswvWLuL8q7qn3ygqRSiviEYPl/cqpyd5vMc?=
 =?us-ascii?Q?hXJyI8+o/UJYH21gYCFldWDyeFP5seDWipZd4zcfN+yowPqGYH0to890L6KZ?=
 =?us-ascii?Q?79JVjNtZsDoAD3hqaE9CKPEdWWqNzXTLgfXIDtDAPBHSHH1JNYxRg8eJ+9/B?=
 =?us-ascii?Q?r/hjUph1P08xHKBgunPjAXprB6hbQNgPE3ICg/Z4PauqlLjUFVqIq/aj4w8k?=
 =?us-ascii?Q?nq1m2iJa1jn+veGoFrYkYux164cNk3KqjWaMbGVugFl861T/d/KJtMu69cRx?=
 =?us-ascii?Q?5UfeH6uQjk62vhloNT2g/iPrqYgZuRvDmpYGCyfuwWZ4W5L9qW4xPKE8/zQ2?=
 =?us-ascii?Q?bUAR42BXX9g/JmAWiOLdkdXMol5a2xH4YNctrp7k7IGf5wXzzM8SXaaJi67H?=
 =?us-ascii?Q?gfYnwQ0g85JAgB0h/m7qfqDadITppeA6HsnZbH4zV5rpV/JxTB6BnazkyzXh?=
 =?us-ascii?Q?kfFICZGeh+Lk/PTr/5Yqj+UezvLGFWnMqvo3RrebwbH+9u+VJeFSvfYeodYq?=
 =?us-ascii?Q?Hvusob5knnMQnYSmciAtQR2lxVyGj8tpZ/e+4BxjN5/5Az93Eh022/Op+wfr?=
 =?us-ascii?Q?QHgyR8OQliad5fsWFNyceI0d7uONAcVScX4GtC9NY/EwicEz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf0d03e-535d-4793-36ed-08df029f5a2e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:52:34.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0fQyOkyFE+abgIJPw+WH+hJoXtInzJnWVxEEHfsKI+FH6o6ixSvp6J6yhlW8rA5LHO78YlSG1vnCwGF3a20mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

On Thu, Aug 13, 2026 at 11:33:44PM +0000, Lawrence Lee wrote:
> I noticed an inconsistency between IPv4 and IPv6 in how the kernel handles
> neighbor advertisements/ARP replies for NUD_FAILED neighbor entries
> and would like some guidance/input from maintainers.
> 
> For an existing IPv4 neighbor that is in the NUD_FAILED state, receiving an
> ARP reply for the neighbor IP will update the entry in the kernel to
> either NUD_STALE or NUD_REACHABLE depending on if the reply is unicast or
> broadcast.
> 
> For an existing IPv6 neighbor that is in the NUD_FAILED state, receiving a
> neighbor advertisement (NA) for the neighbor IP does nothing as
> ndisc_recv_na() explicitly ignores NUD_FAILED neighbor entries:
> 
>         if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
>                 goto out;
> 
> This check was added by commit titled "[IPV6] Don't update FAILED
> entries on receipt of NAs." (Hideaki Yoshifuji, 2005-01-16; pre-git, in
> mainline since v2.6.12-rc2) with the justification "As NAs do not create
> new entries (RFC2461 7.2.5), NA should not change state of FAILED entries."
> 
> However, RFC9131 introduced a method for NAs to create new neighbor entries
> (implemented as `accept_unsolicited_na` and later renamed to
> `accept_untracked_na`), which means the original justification for ignoring
> NAs for NUD_FAILED neighbor entries is no longer 100% correct. I think to
> remain logically consistent, it makes sense to allow NAs to update
> NUD_FAILED entries anytime we allow creating new entries with
> `accept_untracked_na`.
> 
> I realize that RFC9131 section 4.2 states the following:
> 
>     ... routers create a new Neighbor Cache entry upon
>     receiving an unsolicited Neighbor Advertisement for an address that
>     does not already have a Neighbor Cache entry. These changes do not
>     modify the router behavior specified in [RFC4861] for the scenario
>     when the corresponding Neighbor Cache entry already exists.
> 
> However, I would argue that since NUD_FAILED is purely a kernel construct
> and has no equivalent state defined in RFC4861 section 7.3.2, a neighbor in
> state NUD_FAILED does not actually have a valid Neighbor Cache entry as
> defined by RFC4861 and should be treated as if the neighbor entry doesn't
> exist; therefore NUD_FAILED neighbors does fall within the scope of
> RFC9131.
> 
> The motivation for this question comes from my work on SONiC, a network OS
> which is built on top of Debian and runs on switching hardware. We have
> encountered an issue where the switch receives traffic for an IPv6 neighbor
> before that neighbor is resolvable, which leads to the kernel neighbor
> being set to NUD_FAILED. When the IPv6 neighbor becomes ready to receive
> traffic, it sends an unsolicited NA to the switch which gets ignored
> because the kernel neighbor is NUD_FAILED. Subsequent traffic destined to
> this neighbor stays entirely within the switch ASIC and isn't visible to
> the kernel, so there's no stimulus for the kernel to send neighbor
> solicitations; as a result, the neighbor entry stays unresolved and traffic
> to the neighbor is dropped.

Why "Subsequent traffic destined to this neighbor stays entirely within
the switch ASIC and isn't visible to the kernel"? If the neighbour is
unresolved and you're relying on the kernel to perform the resolution,
then you should trap these packets and inject them to the kernel's Rx
path. This should provide "stimulus for the kernel to send neighbor
solicitations".

If you can't do this for some reason (please explain why), then you can
either:

1. Trigger the resolution from user space via NTF_USE.

2. Configure offloaded neighbours with NTF_EXT_MANAGED so that the
kernel will periodically probe them and keep them reachable when
possible.

> 
> The main questions I'd like to pose:
> 
> 1. When RFC9131 was implemented (`accept_untracked_na`), was an intentional
>    choice made to not update the handling of NUD_FAILED neighbors? I
>    searched through the discussions for all three commits relevant to this
>    feature but did not find any mention of NUD_FAILED handling:
>        commit f9a2fb73318e ("net/ipv6: Introduce accept_unsolicited_na knob to implement router-side changes for RFC9131")
>        commit 3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolicited_na to accept_untracked_na")
>        commit aaa5f515b16b ("net: ipv6: new accept_untracked_na option to accept na only if in-network")

AFAIK it wasn't an intentional decision to not update NUD_FAILED
neighbours.

> 
> 2. Should unsolicited NAs be allowed to update NUD_FAILED neighbors when
>    `accept_untracked_na` is enabled (this would align with existing
>    IPv4/ARP behavior that allows ARP replies to update NUD_FAILED
>    neighbors).

Looks fine, but I suggest first evaluating the alternatives above. They
don't require any kernel changes. Besides, dropping traffic to an
unresolved neighbour instead of trapping to the CPU doesn't make a lot
of sense.

Also, note that "align with existing IPv4/ARP behavior" is not accurate:
arp_process() updates an existing NUD_FAILED entry unconditionally and
it can transition from NUD_FAILED to NUD_REACHABLE. So, your patch is
strictly more restrictive than IPv4 rather than aligned with it.
