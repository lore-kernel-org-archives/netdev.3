Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCC41D201
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275540; cv=fail; b=r0av4t5wHyQAwKdfEi0i53aaF6y+Uz1oTUTBLwohs7J6Nq+dDvpOHG/qdkYH3ft3kmBftz1NRBUImeyYiPVARkg0X37hkSxNGmTvnA0wYN2V/vvPBfiT0NyR8uEjCA8swwFBEno5rJWdu2szGyNvrI6uZeQMEj/mfKKOsP4ujoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275540; c=relaxed/simple;
	bh=actcyMxjhwgU9SBgQTRLFc/00lSG5RK3Ja3GySkjXDI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YnEuygzCwpREOLKZ1EQdKPgOKucCqTRtembJg40YCZeDZCQdRrCpXLHZXB1crN4QB8Q+5BTYByTIrDOABJJIiU7GVj2GC6OkymHvUmgsLko98lYtw25rxMxDPLFNl8mXHUj1ML8ZFLNULskI8ZNS+C3hApqR8WxH2axqV5XrmKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JTyDXYcb; arc=fail smtp.client-ip=52.101.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JTyDXYcb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDrzJ/8dRk70/+ku4MqYhQfoIfUk8RmUdpo5j7ECVIndoZkfcsXL5ExvvnUfrUr3WvfOFMGBdzLtGxlr8WW3UgqPOFvxWwEhRIZuu4nsuKzYE4ygkhkGr5rUMt5Hj2LzraZdsvGEbzEx1azPKzjKf0S6t1pZs/dYhNyfIfgOmul3jGV7fHwR9IjuFS2rmarZvdsQtJsSWGxw2gSNG/a+/RtyUlJ7+7g8CEcfFbQC1d0xNf5bO6SvUtVwS8rOrBENE3qhSv6mIAdIMS7Ajgc9+JDbyfXDN1mCpDPG4DBHNCuEykBXlW7y3exPIKqXIeZrdNx4gxjX+O0omhBeQQzrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej45UGdJ0kDTjT2GrmT4dvc9WZxITB1+I8DLwsuRN58=;
 b=Hg9TVh1T8LqkzbPqLi57dMmkgJOVer0PhRw2kxsxn+ZhEHC/ah2s31X2u0Zw+34oEVkgRIIe7NonD4EicaqjutlpdjhX+KfiKQxYBNM+JivCqbjhVJ/Npgm5ezwNBnNlIaWnBuHHRMBDvA3kXAGX6aR7sicSv1pRix/aJ7BuWd49NxLr2316eJJjWCNo/hZF3J0PyJMkFtGBaXu8yZhUqM5HkANSns+2wWWc/gxmkjM44j8R9MfYWYAFpAv69pxp0snHHVd8KVFddeBeNAe8aOicR5IOs0CqR1VdaiJRLZ9PdHsRkUUQ64c4OUNxD6RVKwxis0ujqygZ6TRAnVzOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej45UGdJ0kDTjT2GrmT4dvc9WZxITB1+I8DLwsuRN58=;
 b=JTyDXYcbBZg2oY9HLVtI3q7nbKFzGZLcPV4pKUZkhcivdsUqk8QqLLSqVMUWjNlDLpngwNNeCR9t3P9Ni0UHCOV6Ec2JHoBOCKqbI6NbxkGz9emzu7AUI4zefWs+nD9eW4IzonnJ7omSzaTF0vrP07UHaOAPn9pLWzlvQ/n/fVHcLg75KFJfPU+ewGyyRGKYqylBvz08w4rgu4IZBqCbL2yotZVo6e7lAnV0dl9KkKZnbfIablCA8mAXJaWhVs/Zppfx8cG/Z4bkhjPj+kb+H6kD76q6KXuOrB+KZ66le7cehyB7GKRUO5Sk1RF8riRe6n1JkJbuX+2F38uFkzO+KQ==
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 15:11:25 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::78) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 15:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 15:11:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 08:10:50 -0700
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 08:10:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: Alexander Zubkov <green@qrator.net>
CC: <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH 1/2] ip: ipstats: Merge statistics split across several
 netlink messages
In-Reply-To: <20260830181949.1096-2-green@qrator.net> (Alexander Zubkov's
	message of "Sun, 30 Aug 2026 20:19:48 +0200")
References: <20260830181949.1096-1-green@qrator.net>
	<20260830181949.1096-2-green@qrator.net>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Tue, 1 Sep 2026 17:10:37 +0200
Message-ID: <87o6eh0zyq.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2531d3-9681-4036-1265-08df083b49a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SNGDtmqsChYLc6nyBT3QQu7sysTCmCiy9U0IMM8qbEAffS12YsqI9aclnyMNs5l2xHL138uKtGUtGePG7zQs5VDfk9Y2tBAlb/Yjmwk5HWWYkRwJf5ROxgHbrFg6K4iMw4XTTu7J3blwtq+EcU++naWcYMqON8mi8boYwQmiImPEGFoDSNC1FPjweIgEkMF949NWGYMXJoupMLzxCM23SZq6BftGyEBnczM2hRe5fP0s14KkHlJ9elarULCX7IRc1tBmkVab7IxP67epBPnEOYClyhwMYYEMWGH8LrDKwQG4dtqONmyqZTm6tgfZqagdWkb4pp9U3usqPjOJckACFF1gv0c3JPuzpZuhtyFNEGxnn52+laKX8slx5/xTNw8Ocx+CCTtp7zamYiz0n90yH4JouZYPTMHo9LJran2FYhQfFpd0jBGSqXpqvSND7f3FbOO+i++0uc3KZIUpxyXxpo9iZy8jle4QIf+CPdQIz7VcszDPAuYq6me+ylGNZB8QAvf0fwuRCc38l5EmBHp83lbyfs9IUuaX9Q46is0sN7SlvArJ/2BaZMczxvv3kIX/ZIuheGqCSngdjLpqg392TRX4n91rlPnsMdX7iVXdl++j4sovT1F/q5badfawaMfMxOtSvmNpBm1FpwUNs+JCuXVsW+ii0/lm+atS0d791p5xdN/i9wrRNuS8wiSd+/c8IuXvmvRbpy0BXPJxjXmEhw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4/f3bzP82Fpotx3u5rMGMhtiEsznDbxYgi1c8OW84nfdTUNKeTSTMO4+kxhTlwMuXetMTya9kdOs4VTHrOqmJuxn8qPkjqxSBXKrtJiXiKZEzqC5bDy2jHHbd5CTiPIt6V0ELZsEqbRDOV2v3xFyZicBBhu2pYq/oW3yNOFMSY6poh9AROi89Dh4Fm1WitsJ42wyCUKGz+zZt0sJVUStATLn1rnO/DXoQARyIrA36sE31wXvqMtXKnR3fiCgp+up7CR1RodZ4lLL7H4FnS6eWHC2Tna5JpXxwfvx4ncv/E2qq/RD32sq8qMVsICzwYh+5b/55d17BKvPu5lyFPyn9zONPbaLWl21cqpHassqjb5+cB0CMsrJv0V/L4bcwbgENZbtRYWA32CVaRHoWIsRWxI2y6KkqRombxLgBDMNJCXx4N6xW4MVqSL0ORt/cOMP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 15:11:23.9746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2531d3-9681-4036-1265-08df083b49a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

Alexander Zubkov <green@qrator.net> writes:

> A netlink dump can split the statistics of a single interface across
> several messages. When an attribute does not fit into the current skb,
> rtnl_fill_statsinfo() keeps the partial message, records how far it got
> in idxattr/prividx, and the dump is resumed at the same ifindex, with
> the remaining attributes emitted in the next message.
>
> "ip stats show group offload subgroup l3_stats" requests both

The reproducer I had to use was

    ip stats show group offload | grep 'subgroup l3_stats' | less

No amount of interfaces (tried up to 4K VLAN netdevices) triggered the
issue when I requested 'group offload subgroup l3_stats'.

I guess I should have enabled some of those L3 counters :)

> IFLA_OFFLOAD_XSTATS_HW_S_INFO and IFLA_OFFLOAD_XSTATS_L3_STATS, and
> rtnl_offload_xstats_fill() emits them one by one, so a dump over a
> sufficient number of netdevices regularly ends up cut in between the
> two. Each message is currently formatted on its own, which yields two
> bogus records instead of one, and, because ipstats_show_hw_stats() bails
> out when the HW_S_INFO attribute is missing, the counters carried by the
> second message are dropped:
>
>     109: vlan859: group offload subgroup l3_stats on used on
>
>     109: vlan859: group offload subgroup l3_stats
>
> Postpone formatting until the whole object has been received: keep the
> message around, merge into it any immediately following message that
> carries the same ifindex, and format the result once a message for
> another ifindex arrives or the dump ends. At most one interface worth of
> statistics is buffered at a time.
>
> Merging the two messages means merging the nests that were open when the
> first one was cut short and that got reopened in the second one. Netlink
> does not mark nests reliably here -- nla_nest_start_noflag() is used --
> so they are recognized by the message layout instead: a reopened nest
> appears exactly once in either message, and at the outer level is known
> to be a nest by ipstats_stat_ifla_max[]. That knowledge only reaches as
> deep as ipstats.c parses the message, so merging stops at the group
> nests and their contents are appended in the order they arrived, which
> is correct both for a deeper nest reopened between two of its children
> and for an array of same-type attributes, as bridge per-VLAN xstats are.
>
> A layout that does not fit the above cannot be told apart from an array
> of same-type attributes, and reassembling it would corrupt the result.
> Such a message pair is refused with -EOPNOTSUPP and the two halves are
> formatted separately, as before this patch. Failures to allocate or to
> build the merged message are not papered over that way and terminate the
> dump.
>
> Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Alexander Zubkov <green@qrator.net>

The patch looks broadly OK to me, including the commit message, which I
see Stephen isn't too fond of. I agree the comments are way too verbose.
Some more commentary below.

> ---
>  ip/ipstats.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 276 insertions(+), 4 deletions(-)
>
> diff --git a/ip/ipstats.c b/ip/ipstats.c
> index 8a2ac85e..c531885f 100644
> --- a/ip/ipstats.c
> +++ b/ip/ipstats.c
> @@ -850,12 +850,225 @@ ipstats_show_one(int ifindex, struct ipstats_stat_enabled *enabled)
>  	return err;
>  }
>  
> -static int ipstats_dump_one(struct nlmsghdr *n, void *arg)

So the following comment is super long and nobody will read it. You need
to look into the code to figure out what's what anyway, and the comment
does not really help with that. So I'd keep this:

> +/* A netlink dump can split the statistics of one interface across several
> + * messages:

and drop all this:

>               when an attribute does not fit into the current skb, the kernel
> + * ends the message and resumes the dump at the same ifindex, emitting the
> + * remaining attributes in the next message. See rtnl_fill_statsinfo() and
> + * rtnl_offload_xstats_fill() in the kernel.
> + *
> + * Reassembling the two messages means merging the nests that were open when
> + * the first message was cut short and got reopened in the second one. Netlink
> + * does not mark nests reliably -- nla_nest_start_noflag() is used here -- so
> + * they are recognized by the message layout instead: a nest that was reopened
> + * appears exactly once in either message, and, at the outer level, is known to
> + * be a nest by ipstats_stat_ifla_max[].
> + *
> + * That knowledge only reaches as deep as ipstats.c parses the message, so
> + * merging stops at the group nests, and their contents are appended in the
> + * order they arrived. Appending is the right thing to do whether a deeper nest
> + * was reopened between two of its children or the children are just an array
> + * of same-type attributes, as bridge per-VLAN xstats are. It does the wrong
> + * thing only if a kernel splits a nest that ipstats.c does not know how to
> + * show either, in which case the merge is not the first thing that needs
> + * updating.
> + */

Writing is kinda Claude's thing, so it does it a lot, it comments
everything like crazy, inlines whole functions instead of reusing, etc.
I find myself having to moderate its code a lot because of this.

> +
> +enum {
> +	/* Merge the outer level and the group nests, append below that. */
> +	IPSTATS_MERGE_MAX_DEPTH = 1,
> +};
> +
> +static struct rtattr *ipstats_rta_find(struct rtattr *rtas, int len,
> +				       unsigned short type, unsigned int *count)
> +{
> +	struct rtattr *found = NULL;
> +	struct rtattr *rta;
> +
> +	*count = 0;
> +	for (rta = rtas; RTA_OK(rta, len); rta = RTA_NEXT(rta, len)) {
> +		if (rta->rta_type != type)
> +			continue;
> +		if (found == NULL)
> +			found = rta;
> +		(*count)++;
> +	}
> +
> +	return found;
> +}
> +
> +/* Whether the two messages can be reassembled at this attribute, and how.
> + * MERGE means RTA and OTHER are the two halves of one nest that the first
> + * message left open. APPEND means the attribute belongs to one message only
> + * and is copied over as it is. REFUSE means the type is present in both
> + * messages in a layout that cannot be told apart from an array of same-type
> + * attributes, so reassembling it would corrupt the result.
> + */

Drop the comment. It's clear from the code and the names what it does.

> +enum ipstats_merge_action {
> +	IPSTATS_MERGE_APPEND,
> +	IPSTATS_MERGE_MERGE,
> +	IPSTATS_MERGE_REFUSE,
> +};
> +
> +static enum ipstats_merge_action
> +ipstats_merge_action(const struct rtattr *rta, unsigned int nrta,
> +		     const struct rtattr *other, unsigned int nother, int depth)
> +{
> +	if (rta == NULL || other == NULL)
> +		return IPSTATS_MERGE_APPEND;

This is one useful tidbit from the wall of text above, and it should be
here, not there:

	/* If we have >1 hit for an attribute, it's an array of
         * same-type attributes. Bail out. */
> +	if (nrta != 1 || nother != 1)
> +		return IPSTATS_MERGE_REFUSE;
> +
> +	if (depth == 0) {

Hmm, I suspect this depth == 0 and the above IPSTATS_MERGE_MAX_DEPTH == 1
are correlated? We can't validate attribute type in ipstats_merge_action
at depth > 0, so it's unnecessary to recurse into ipstats_merge_rtas()
beyond and and we can optimize this case by just copying all the
attributes right away through ipstats_copy_rtas.

If this just returned an IPSTATS_MERGE_APPEND in an else branch, then we
wouldn't need ipstats_copy_rtas(), IPSTATS_MERGE_MAX_DEPTH, and the
related special casing.

> +		unsigned int type = rta->rta_type;
> +
> +		if (type >= ARRAY_SIZE(ipstats_stat_ifla_max) ||
> +		    ipstats_stat_ifla_max[type] == 0)
> +			return IPSTATS_MERGE_REFUSE;
> +	}
(	  else {
		return IPSTATS_MERGE_APPEND;
	})

Maybe the branch needs to be elsewhere for actual array calls. I took a
code modified like this for a spin, and got the same output, but I
wasn't trying to cover all counter types, so I might be missing
something.

Plus the optimized copy saves the find calls, which is not nothing.

But in any case I don't like how we end up with this
IPSTATS_MERGE_MAX_DEPTH pretending to be all configurable when in fact
the only value that makes sense is 1.

> +
> +	return IPSTATS_MERGE_MERGE;
> +}
> +
> +static int ipstats_copy_rtas(struct nlmsghdr *n, int maxlen,
> +			     struct rtattr *rtas, int len)
> +{
> +	struct rtattr *rta;
> +
> +	for (rta = rtas; RTA_OK(rta, len); rta = RTA_NEXT(rta, len)) {
> +		if (addattr_l(n, maxlen, rta->rta_type,
> +			      RTA_DATA(rta), RTA_PAYLOAD(rta)))
> +			return -EMSGSIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipstats_merge_rtas(struct nlmsghdr *n, int maxlen,
> +			      struct rtattr *a, int alen,
> +			      struct rtattr *b, int blen, int depth)
> +{
> +	struct rtattr *rta;
> +	int rem;
> +	int err;
> +
> +	for (rta = a, rem = alen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem)) {
> +		unsigned int nrta, nother;
> +		struct rtattr *other;
> +		struct rtattr *nest;
> +
> +		other = ipstats_rta_find(b, blen, rta->rta_type, &nother);
> +		ipstats_rta_find(a, alen, rta->rta_type, &nrta);
> +
> +		switch (ipstats_merge_action(rta, nrta, other, nother, depth)) {
> +		case IPSTATS_MERGE_REFUSE:
> +			return -EOPNOTSUPP;
> +		case IPSTATS_MERGE_APPEND:
> +			if (addattr_l(n, maxlen, rta->rta_type,
> +				      RTA_DATA(rta), RTA_PAYLOAD(rta)))
> +				return -EMSGSIZE;
> +			continue;
> +		case IPSTATS_MERGE_MERGE:
> +			break;
> +		}
> +
> +		nest = addattr_nest(n, maxlen, rta->rta_type);
> +		if (nest == NULL)
> +			return -EMSGSIZE;
> +
> +		if (depth < IPSTATS_MERGE_MAX_DEPTH) {
> +			err = ipstats_merge_rtas(n, maxlen,
> +						 RTA_DATA(rta), RTA_PAYLOAD(rta),
> +						 RTA_DATA(other),
> +						 RTA_PAYLOAD(other), depth + 1);
> +		} else {
> +			err = ipstats_copy_rtas(n, maxlen, RTA_DATA(rta),
> +						RTA_PAYLOAD(rta));
> +			if (!err)
> +				err = ipstats_copy_rtas(n, maxlen,
> +							RTA_DATA(other),
> +							RTA_PAYLOAD(other));
> +		}
> +		if (err)
> +			return err;
> +
> +		addattr_nest_end(n, nest);
> +	}
> +
> +	for (rta = b, rem = blen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem)) {
> +		unsigned int nrta, nother;
> +		struct rtattr *other;
> +
> +		other = ipstats_rta_find(a, alen, rta->rta_type, &nother);
> +		ipstats_rta_find(b, blen, rta->rta_type, &nrta);
> +
> +		/* Whatever is present in both messages has been dealt with
> +		 * in the loop above.
> +		 */
> +		if (ipstats_merge_action(rta, nrta, other, nother,
> +					 depth) != IPSTATS_MERGE_APPEND)
> +			continue;
> +
> +		if (addattr_l(n, maxlen, rta->rta_type,
> +			      RTA_DATA(rta), RTA_PAYLOAD(rta)))
> +			return -EMSGSIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipstats_ifsm_len(const struct nlmsghdr *n)
> +{
> +	return n->nlmsg_len - NLMSG_LENGTH(sizeof(struct if_stats_msg));
> +}
> +
> +static struct nlmsghdr *ipstats_msg_merge(const struct nlmsghdr *a,
> +					  const struct nlmsghdr *b, int *err)
> +{
> +	int hdrlen = NLMSG_LENGTH(sizeof(struct if_stats_msg));
> +	int maxlen = a->nlmsg_len + b->nlmsg_len;
> +	struct nlmsghdr *n;
> +
> +	n = calloc(1, maxlen);
> +	if (n == NULL) {
> +		fprintf(stderr, "Error merging netlink answer: %s\n",
> +			strerror(errno));
> +		*err = -errno;
> +		return NULL;
> +	}
> +
> +	memcpy(n, a, hdrlen);
> +	n->nlmsg_len = hdrlen;
> +
> +	*err = ipstats_merge_rtas(n, maxlen,
> +				  IFLA_STATS_RTA(NLMSG_DATA(a)),
> +				  ipstats_ifsm_len(a),
> +				  IFLA_STATS_RTA(NLMSG_DATA(b)),
> +				  ipstats_ifsm_len(b), 0);
> +	if (*err) {
> +		free(n);
> +		return NULL;
> +	}
> +
> +	return n;
> +}
> +
> +struct ipstats_dump_ctx {
> +	struct ipstats_stat_enabled *enabled;
> +	struct nlmsghdr *pending;
> +};
> +
> +static int ipstats_dump_pending(struct ipstats_dump_ctx *ctx)
>  {
> -	struct ipstats_stat_enabled *enabled = arg;
> +	struct nlmsghdr *n = ctx->pending;
>  	int rc;
>  
> -	rc = ipstats_process_ifsm(stdout, n, enabled);
> +	if (n == NULL)
> +		return 0;
> +
> +	ctx->pending = NULL;
> +	rc = ipstats_process_ifsm(stdout, n, ctx->enabled);
> +	free(n);
>  	if (rc)
>  		return rc;
>  
> @@ -863,8 +1076,63 @@ static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
>  	return 0;
>  }
>  
> +static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
> +{
> +	struct ipstats_dump_ctx *ctx = arg;
> +	struct nlmsghdr *merged;
> +	struct nlmsghdr *copy;
> +	int rc;
> +
> +	if (ipstats_ifsm_len(n) < 0) {
> +		fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len);
> +		return -EINVAL;
> +	}
> +
> +	if (ctx->pending != NULL) {
> +		const struct if_stats_msg *pending = NLMSG_DATA(ctx->pending);
> +		const struct if_stats_msg *ifsm = NLMSG_DATA(n);
> +
> +		if (pending->ifindex == ifsm->ifindex) {
> +			merged = ipstats_msg_merge(ctx->pending, n, &rc);
> +			if (merged != NULL) {
> +				free(ctx->pending);
> +				ctx->pending = merged;
> +				return 0;
> +			}
> +			if (rc != -EOPNOTSUPP)
> +				return rc;
> +
> +			/* An attribute layout that cannot be reassembled:
> +			 * show the two halves separately, like older
> +			 * versions did, rather than dropping either.
> +			 */
> +			fprintf(stderr,
> +				"Cannot merge statistics of ifindex %d split across messages\n",
> +				ifsm->ifindex);
> +		}
> +
> +		rc = ipstats_dump_pending(ctx);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	copy = malloc(n->nlmsg_len);
> +	if (copy == NULL) {
> +		fprintf(stderr, "Error saving netlink answer: %s\n",
> +			strerror(errno));
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(copy, n, n->nlmsg_len);
> +	ctx->pending = copy;
> +	return 0;
> +}
> +
>  static int ipstats_dump(struct ipstats_stat_enabled *enabled)
>  {
> +	struct ipstats_dump_ctx ctx = {
> +		.enabled = enabled,
> +	};
>  	int rc = 0;
>  
>  	if (rtnl_statsdump_req_filter(&rth, PF_UNSPEC, 0,
> @@ -874,11 +1142,15 @@ static int ipstats_dump(struct ipstats_stat_enabled *enabled)
>  		return -2;
>  	}
>  
> -	if (rtnl_dump_filter(&rth, ipstats_dump_one, enabled) < 0) {
> +	if (rtnl_dump_filter(&rth, ipstats_dump_one, &ctx) < 0) {
>  		fprintf(stderr, "Dump terminated\n");
>  		rc = -2;
>  	}
>  
> +	if (rc == 0)
> +		rc = ipstats_dump_pending(&ctx);
> +
> +	free(ctx.pending);
>  	return rc;
>  }
