Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140D3C10B1;
	Tue, 21 Jul 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624492; cv=fail; b=JCG6Arvz4z2p4ThR6uYqmZ4x/0MI3lOT11dFnuAI6YZO7/G+4D1keLStiGKvpQiGCrQFL6GHUtdyY4FVz2FYLCA+uAMpsL7ku1jRJtBglel/loMFGILbHxqkXAashPxR+IhZHvoUiWlrlccx8lUsC8564Xi8GeQFMg1/KgXT6jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624492; c=relaxed/simple;
	bh=GSNa85SbFKZu9nwmb+BJMylI+lfmQfzl4dpdDyXOd6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iL0XEHt8bA+ouG3HT+IgqaDkqAnrR4MxWh4QGXobJwMQ4ly0iH4UPfB7M3SlHXOCZ2+mE63qsqG5XyYL5h1FyMw87JkHh3uYshngmwDASkby/LMNLebXrvK3aCOmEF3HRrmI9rRcoFTPBF4SNEwsj5giRjfeoCdBNkejxZh8HkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sHvqt0hB; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sHvqt0hB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYjlyaWvQ1ifI16IQbj+x4x6nUvdPKXL00S3ezDYFNELPPEgV51KnVATLuTQSFbNipoTRTmu2zxvvGHsB6fOdnsEq5Ae6zbKPQm9nJ5lbxes5UyhIcXiKUyeJ9cS7/3KhDa0JsSZf54ewGZwQvwTPIlYvq16+HSFWdimbS7tNgIJu7vh+vzQBbE9pQovcuRyIb5bDrpRMgtOiFe9xAcm//vjLZuU2gC8dhVWkcFnQ64ZRqgriYZM/w62cl1v4L8Xb311+Mp1Hb55jCgeZIzJXkK0wHCZ1q+MGU9KRdsBrRwcnLkWDB4ttXxAjyMSOTzDw6LJBACJBwGpaUELf6ozHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp/xtzfX3hcMcxndmH9XrQVVgUUH0t9TqqAzk3LTSvI=;
 b=skc2IRO6JiGOypi2ojJPbrisQd1idswnAHlmneidWK2aR2EvBs1CTJTa64bNAx/8iL0nUPUGxhOEr8SJUaHNQdhiy34jNxkqxZInTOTN1rdbb/hdJH4zjEtX0vDHMCfmi2WKIWUEqTxt8bsWfrqGPZw6C8lGSWf0AiKxuaH/jriF4ALrbShOqmYJpORgOkCLJ5ZIvdeSV/KAEajkqv/nU9xbx+R1wbHuzjqk9028k88OJZZc8RxecWN1s1pHL2lVUN29kfhaAG2BGbgFZt3mMPd4dZd36hy4DZbtFXb1TW3D+ubnEKEwsbMLQDEgQCMM5eBoJkJXQwPzVXZAXZLIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp/xtzfX3hcMcxndmH9XrQVVgUUH0t9TqqAzk3LTSvI=;
 b=sHvqt0hBrcjfeEUI4yHdkQ6bC1U5bQzeEN40ojjzGPx3NHfmpvaZcE7DhvamTfAiABxoRE4hPIC5IU5lNHNbmRDfFry5uwOC2hJm8ShWJROdDp7t77Sb7f0wVQxIRRZPg5j4rwPZla6nYFuo8UNvi3fQCq0oVRs2rzguYip/VTQ/kHESnbdeZx/XtBlg72NFyMFSL2Qy01nNQ9ksKLO8WXxubS36V4vDQHwz1vjHutif8/BUtWWIBI0OdPhIvNra4qTbvA7wiaFKoYFLxULkKBuZSBptQjXB5GNh3n3hvP7Wr45nNvdfgCfBqfvxKYzpzMwaPjapgG6F0VoOVPMDrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 09:01:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:01:24 +0000
Date: Tue, 21 Jul 2026 12:01:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Tim Wong <kanman.wong@dish.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] ipv4: devinet: list global scope addresses
 before link scope addresses
Message-ID: <20260721090114.GA2510713@shredder>
References: <CAPT8rhu_NGbLd54RFWRxO+=7BHhJ0pS5yeOgo5kNmq4qtQ=t8w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPT8rhu_NGbLd54RFWRxO+=7BHhJ0pS5yeOgo5kNmq4qtQ=t8w@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: a82908a7-ec80-4495-2ad1-08dee706a43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hoTr7wxOT0HQ03sNpE2YrzEWyWCsWFQnfUmCksbxtjKAqzqSHShzPtvjHvLomPYvrw5Hg8pon0nISlV90AKB7JRNC5W//oItEZ5X9oklTis/d8Lk8v04V0SIyb5sBAVAkMccV0Cs3v7e1G6z/S/cO6DyjGYq7GpG/Kqvu3VrkLjNYPXy+8tRqOfQLfMlkIZlajiP0SPEpIRqqh+DOePtVG4tWjF21TNkJb6hWAojb/r8ZRHeWq0gH3c/JzfIefjdb9FqAvPjz30dCLClqnIVlFs/TxGbMnIRfskjubU3LcFznlmITlRCM1NsroE99szg7ZEiDeX7yM9fNjlnWpz/Yl0j78Nf4Bd3txL+ny9vZ02jxj5UAP8ihl+pBAIV8C38WcYNxOLZh7A9tiNC9Eow2K31d1Y3Do3/GYb3nfFznsmesmc37Z7pQKX+TUBtohGi5JfeNieEhH2LHl0oq6ohnL2DAayO/kgD4PmnzdB7vNd8JcIX2VaDk8CmF6dnGHhf/ccw/KiXL1zlVaG1VTQgePYFGDLFaooDKd564m5j1nc8QOyMe6q6biLylhTqfwTjgS9xl0QEkZWC/7cwLd5s5rV0yVwncgu2AjJ3h4qkEAXJ9P73wyudMW6Ywa5tVJaMrX+vw5Y0een4/mg2WTp0gXHGQuvVZicGmdSVc4TVvb8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XufQ/LRAFizbTndV778lb6VcE1G2Yj//Rt5PLpdWZ1/wyeKf2vgsLE0bYZTJ?=
 =?us-ascii?Q?2f03ip58ccNQypFSHUUNrFDfeLhuJClGZ0ajtq1JkuTyMBUXQaBOVglc+A7a?=
 =?us-ascii?Q?bx5C1IPB7DUe03Z4uIOWZ0+TSW/yFmmJNGC/xtterD6UOp8EYplN5kLhL4vL?=
 =?us-ascii?Q?UlNk/yIGGarTA8NH2M156bCuk8m355iqorivvJKXpC3vQy+3KM9TR9RXEFnU?=
 =?us-ascii?Q?ZqeSnC7GupOjdM0I3RjcgtuQ73bqc/n3V/eQR51K/XOIQeiUOeNd/xynoEfH?=
 =?us-ascii?Q?MWM9nYlTUIQ2DY9U88/TiBylitxT2OmyDHZRz08Yl06T6H6vvDry0F8Fr3H7?=
 =?us-ascii?Q?YShVLIGPdwyY+XwOyDCEvp+u8m6k6pLND03JVjQ2mXPoU3J8yfgg8GzU6Tx4?=
 =?us-ascii?Q?fFKFjTo67Xnhgn6RzkNYGDi56tuQd+QbM2xZN5UnBvVOmd0onnwXZtFV3tgi?=
 =?us-ascii?Q?1h+8SJGBvuDwHL1OU0Tvgx9mAP1B/op0ASfSUnYuH9O+dYMtrBN2/hFeA1ui?=
 =?us-ascii?Q?RTKAdgmmp8L5PEyNBLgcyqsN2oGsu86EhSgSJpTvH0PXxYgSp2DBDkJ3yvW+?=
 =?us-ascii?Q?VSKiFXgykpBXjG3c/tfmZCfeC8KnTAQsWshFZYSyhctrJKYBaHWRc+6eQ2tW?=
 =?us-ascii?Q?vv4R2sOF4N3eQaK1k2FNd0dIZrLlZSJW5e6QUnBa15aLteCEWw++bd79L/m1?=
 =?us-ascii?Q?uJiaSXorMCNCnosqPV7LBTsP1dzpfjwCD/kc1G3SNbCmRBqR7plh+9eRQfqa?=
 =?us-ascii?Q?/Csm1Z4YETIQLWcZC9Hnow0YqEq7Z17ZsCjBfpP97RL3H/bdn2C10hrGGP6O?=
 =?us-ascii?Q?I3tracmTIeUx9Kz8roFOIBjLPlvbBQN2XmtHvC9wd6cNJGxbApDMN/cLos+v?=
 =?us-ascii?Q?jR4IfEpjVN/XA7a9SNf0Q3dOLD7Y699+y+7GfV6OTEh1iyn7M64Hl08SAkhm?=
 =?us-ascii?Q?iCI+C1W2RMlQwRXEwXRQGYoYIeGZMTHyTn0ZxVYa/ejyyJmzpXr9LObJdvOe?=
 =?us-ascii?Q?tcYJO/DmlWMbzp0OOC8goPBSimyPJklAm9mZP0NPpKR2fLwVe6BNEdrzUqtp?=
 =?us-ascii?Q?RQa+BYe5pUnteqbmlr0HpMUTtbcLdFulZ/tW62hSlOBcTWTZrnUCo3nP7l0b?=
 =?us-ascii?Q?3hFjGgN1Gn5CDtquoheLc6qL3vIxKTrHZQ4Buk1SlTshOz2n4pyxAfGt00B7?=
 =?us-ascii?Q?OC7j9hY6AiRp8RtsiS5ROYxpuvU5EP+YtKj7UQY+VMMOIeODKWSeVPN2DtfY?=
 =?us-ascii?Q?f9T3BXLVALpmb5uzWXivICsGUYp6L5w8mMvRtBmxz5PMw5g0IcpTAALhbWeZ?=
 =?us-ascii?Q?Kv5J/0/7T02cwjpvuAT7xm89ssleUTqSjbgqlA0D5YC5DM4L0u9gJxkFO+yX?=
 =?us-ascii?Q?r6C13+xJGCyII9l735tSGCClnrXD0jJsdzVnTN8fBSlfpAOJKpuT7CHbR9vv?=
 =?us-ascii?Q?dvomG7D1q453uzp8dvrq4Il8SGLvT6dA80hJt8Sdl3crPVbLYFlasB+itkg2?=
 =?us-ascii?Q?XiAlN3uBs2CjEpCpeWoR6JyBYIQjD2DkB5QE4S3PRMR0+rWtFB/NjC+goqz2?=
 =?us-ascii?Q?dGt/UGknDH5B8bIym8wbvPZaa32XXy9TuirrvSwsDrgDX77Q0w4yQB2lTF6T?=
 =?us-ascii?Q?QP/HJIrM2DjLf3Xx05VsGYHMQ2pcJELz/wX+PNEQzdzgKijm4gGDaTnFK5Gm?=
 =?us-ascii?Q?UrS+LZS9XzM1eOr7xmVOYnzb4+h/uzG9UQJC9tGyLrEYBs0b0fG/zH3vK88j?=
 =?us-ascii?Q?i6EOyy0W7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82908a7-ec80-4495-2ad1-08dee706a43a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:01:24.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbG6WEfyKZBVW7k172+JCIFm6fAaVs2dp6g2XmYOxlkXvHJIi6R6ENOnW6nmXBRN6qpBcFeG8kljgYTdoaOFKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

On Mon, Jul 20, 2026 at 12:16:23PM -0600, Tim Wong wrote:
> __inet_insert_ifa() inserts a new primary address by advancing an
> insertion pointer past every existing primary address whose scope
> is >= the new address's scope. Because IPv4 scope values are
> numerically smaller for wider scopes (RT_SCOPE_UNIVERSE < ... <
> RT_SCOPE_LINK < RT_SCOPE_HOST), the comparison
> 
>     ifa->ifa_scope <= ifa1->ifa_scope
> 
> is true for a global-scope new address against essentially every
> existing entry, so the new address is pushed all the way to the
> tail of the primary address list, ending up *after* any link-scope
> addresses that were configured earlier.
> 
> On an interface carrying a mix of global- and link-scope IPv4
> addresses (e.g. a routable address alongside an RFC 3927
> 169.254.0.0/16 address, or any address explicitly assigned link
> scope), this makes the resulting order in in_dev->ifa_list -- and
> therefore the order addresses are reported via netlink
> (RTM_GETADDR), ioctl (SIOCGIFCONF), and /proc/net -- depend on
> configuration order rather than scope. Userspace consumers that
> pick the first address returned for an interface (e.g. via
> getifaddrs()) can end up preferring a link-scope address over a
> global one.

It's a user space problem. The kernel provides all the needed
information for user space to make an educated choice.

There was already an attempt to change IPv6's intra-scope order to match
IPv4's and it broke user space:

https://lore.kernel.org/all/20260529112357.5079-1-fmancera@suse.de/

Now you propose changing IPv4's inter-scope order to match IPv6's. It
will most likely break user space and kernel selftests. Please solve
this in user space.

> 
> IPv6 already avoids this: ipv6_add_addr() keeps idev->addr_list
> ordered so global-scope addresses precede link-local ones
> regardless of configuration order.

I don't understand the point about configuration order. Only the
intra-scope order is determined by configuration order, no?

> 
> Fix the comparison so the insertion pointer only advances past
> addresses that are at least as global as the new one:
> 
>     ifa->ifa_scope >= ifa1->ifa_scope
> 
> This groups global-scope primary addresses ahead of link-scope
> primary addresses in in_dev->ifa_list, preserving insertion order
> within each scope group, and brings IPv4 address enumeration order
> in line with existing IPv6 behavior.
> 
> Signed-off-by: kanman.wong <kanman.wong@dish.com>
> ---
>  net/ipv4/devinet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index a35b72662e43..056f2169c6a3 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -510,7 +510,7 @@ static int __inet_insert_ifa(struct in_ifaddr
> *ifa, struct nlmsghdr *nlh,
> 
>   while (ifa1) {
>   if (!(ifa1->ifa_flags & IFA_F_SECONDARY) &&
> -     ifa->ifa_scope <= ifa1->ifa_scope)
> +     ifa->ifa_scope >= ifa1->ifa_scope)
>   last_primary = &ifa1->ifa_next;
>   if (ifa1->ifa_mask == ifa->ifa_mask &&
>       inet_ifa_match(ifa1->ifa_address, ifa)) {

The patch is whitespace-damaged.

> 
> base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
> -- 
> 2.51.0
