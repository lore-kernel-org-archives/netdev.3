Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB22D77F5
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337152; cv=fail; b=FYU3T4xyKaB4mifYUkOLbDKgKEa8cjyzTVNf8nsyFLsBgArxNdWRHFA4Y3b1qToMb5S8LKCFCzkh8UT3h2m6oDcCeguHQvwF1NQ9v8NibUCsDN3oKrLjXVDgm+hKhth3k+m/d4v0I5Jkrg2GDWQpxC4m77Kep+VJMGh23KaIo0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337152; c=relaxed/simple;
	bh=1KQcN406MSSsp0fBQmJ2av0cNSCoDZy0J9gwxSTyXnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjDEu8OXwnUInpMrwJQF287j0uRv6ZWwl1nPay7rW8pAuTgVUYXKqGj5UUxWSHK5gEoUJ09YyAWVDPzkK/v2rSAMMfXvJ7Ar6fXKzj/CmST6Z6WyxwQc4rDSw1tmUbA9SyGLyDicNxTP9Mp5sYTVyXPIQKXE1v+mpS2lOsRjtyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cS8QPnWm; arc=fail smtp.client-ip=52.101.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cS8QPnWm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfCMqL9X5vgrbxUgwsfSTKCRk41RcKpE2/G32BzvpxA06r7Jye46D4DLJs5vOiOrdbyYuDo3kXhMbw4PTsl6dEHbUKJgI5jLghwHaDt2k6VRJDQKvvKf5k9FBCR6GpK5MDTvKeBJs36jbZD/kg0vB5wWbFi2FuZDq8WEniABHflMFY6frKSXdb3PvydDFRSGfTC1d+9N3NIbMU3rKHdGgPIbIAqEZLcpCmPM2o4CPsprh0WHBkS+4MECXrwudY4xSdU5/AQJspFk77HZZTXBrgEU5XausF51kqjeTW/wU+rZ6TWz+irSHGFhOd0S8ZlPGUFm+FR/gtGeFrJoplaFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL1RKl6Q7GWci0/kvOpkm26zdfNdZ3+Hhniz78ozQkM=;
 b=eJg5VMVv+56ccpDr0KXZmJU+rkoCkfO7hAdIhO7/HInDAqtJvH2DLFEaAfNNpsLiHtph4Qh8X7cmh1nycpwNb64sTv5Js5QTTIZJTl+6KvHN17kAidacc31fa+oMwufSn9AuBVqV1m+yDLzAddMU9OL9P1CWqFa9GtTWFs9Z6FKPWhOIDDwr8bJDKWgoBKAjiG9sLcs7VMedS2U+QDJCSqGy9WYafNg3jIu8/fKKNoJ+/3b4c75XBazKVgiTRNHOP/8rexOdwWrC6xojkYEEVSHoMAm3e8/5FXLu9A/Wp3q6r9vtpwPKyI6fZUv8htj4+nUi+/gCO7nETtgPSKaNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL1RKl6Q7GWci0/kvOpkm26zdfNdZ3+Hhniz78ozQkM=;
 b=cS8QPnWmk81YdH+sLx17O2xO/gG+jnC+zecipJZaMs1FyQ3oOlZws088UA7Ns2392iESX8nLm0iR17IufchwcM9xTQVKPgcgOJWvS7iSC5HHetDIAGmDjCReJl+paE65Zz+d94Ozh2f/TK+fH2PScvYOjITKFSMz4X6Vzm76F49xFBqPJx+Y2ztnLHgJDJzjtz57ZVZrEn06Mh74+E6C2Dqxv7oaiQJe+mxrGYa7xu8zrwAoxeUjvZ+ULl/lOmj63gsC6+Jm+ixAkRYAebgIrzqnQN12niAxPZAE2dgpZhZP0V7us1XDugQxDs0f/4tKP7yVELvlb/lgvfzVaCLzMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PPF95ABFC125.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sun, 18 Oct
 2026 15:25:42 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 15:25:42 +0000
Date: Sun, 18 Oct 2026 18:25:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Qiliang Yuan <odys.yuan@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] ipv6: account route exceptions to the netns of their
 dst
Message-ID: <20261018152533.GA2597316@shredder>
References: <20261016091556.2750902-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016091556.2750902-1-edumazet@kernel.org>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PPF95ABFC125:EE_
X-MS-Office365-Filtering-Correlation-Id: 211730b8-879a-4c5a-c7ec-08df2d2c12c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ETTblB0fW1klzjr9KQpi776PUXpeoZSVETi02hP7X2K+2Nd/YPmdZTtcY39RDaRHK5FJdV5RUXVSL5FhA6uLjsvezxlPu+gku4F6qJdQU8U/smMIAVf8CcLV13Q6D79fE9QN/31gdSFIg7NKjPByQASe/7xLLMU5vU1HEK61TdVHkRL96aqVvPudkojnQMavWHmOYaM2XG45+NgsyxtBHv7o2cd49J3nynOcxbw9sDBU5BbD+wk80LZZGfbSeHstRlVvVlewSfYKtAqdEOVuQglgKpY2P5ECLZpPtkGbMUFgCS6IQA7jgQ/L/Z+C+RnCl76MLyu1CNe+3sckTNgKUIuMBiarZ+ngRTyJZMvPqSqCj+JGBT9gnzXPIcNrotvjaw7FRxwYEmPc7xG2PSAkxpYd4Tf+DsH33PpxfTajMGKrVDE1wRirsNsFi7F4rpIPFfmLAGL5rYD2d5pn3Wiexr/mv3uI+0Jmz31HGNu/qPiCZ9btuYlXKghHl4ugi3zNdKCT4eUHs7r5g96xun458wxxTDkeHujheMyclimRq+Nb4fG6aH9etKT5vKq64oyhbf0uUg/Pkr81y1IvO6cSy92IoOK41ZK9qQi+PMCB9uTvOENmuLE1rUMMc0UqmcK0Y2gQHE2ini0QO16tsuOzaihbkbJD0Ma1yoc0jw02mQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mrh0MBowf+3WF9P8ZN3CbNpZ4umtNr13TgKtW0I7vRJTgDLFaGqd/Khw68Pb?=
 =?us-ascii?Q?/9vV8fT3LV1S2iJ7HbyNnKufxcTNZs4bCLC3bFxnGHExpfPpNAVOws07TxJ2?=
 =?us-ascii?Q?MoEomnx24yoxgyCxsuYl/Rko2t/cBf3sFeIhf8yYfK8y63vWTBVCd9mInUC2?=
 =?us-ascii?Q?F4dQXJOkkH7168Pp4pynDgSN9kD2I+7HSSwGveEZLb2HWC9uSEMKhBUNkN64?=
 =?us-ascii?Q?EB7ZQQCGjMsfQtqmUjmm84kQCNSQAchp+wVqM0Y/tLKC4mSAAJBedag7fDkp?=
 =?us-ascii?Q?eEJGG69DEDJvTyv0GFzCmzANH07xniuhaQ3FLELUeU/wo3XzOuj16gbqZQ+f?=
 =?us-ascii?Q?lij4snryOLERtzPg3NyfAYr5hLF3v4xaaDR6UCWzusIKsB76ED0OAJjzIjg8?=
 =?us-ascii?Q?K+AIewjU3Bg1hs29YVm9NappMJvcvw9djL/wXfptnpSVZxxad89zB6QkDvxR?=
 =?us-ascii?Q?uGlDOOIaN0C6A6D3kCLr5+gr8oK1zeHEMQd+qvwwj8LQXXEOcKRuKR29fzCX?=
 =?us-ascii?Q?bA5dPLQbYz7EyDjJA9OYKawn6khtAfudeFhdlbdiLErF0jIMfUZ4JzkvKMq5?=
 =?us-ascii?Q?wj/QpnipnuXhL/NXDeYbBasiBbYqszT6WtKzO6RMZSj6HHgmZgFKZ830Mh2n?=
 =?us-ascii?Q?hge47QZfY7FU0yDTaY7yJwOIu2FQT7NchRdwcCnG3rAdUPoIIklBjowZvuw4?=
 =?us-ascii?Q?yLWR5HD4ZC2xv7pLD+DTYG/A5NC/c/6uZnwFvgLYnhXxmSZEhzd1Ad+9Q3rJ?=
 =?us-ascii?Q?DouAZwbIJ2iVcCEBseQVoATKrpwG5USM6tK+Nu8ibiilPJTkOABP6v3TBJfF?=
 =?us-ascii?Q?vmMV5QPcyfIapseuh8kfdBmnp9cUoan/xGV6u7Ka++53NjMzYn9fhRcewKbt?=
 =?us-ascii?Q?cMg1FLfrEd/9+8NxP+6LTs+XlRBfa6eXCEmba6gX/SByVGKFdWqk3uz8ivAW?=
 =?us-ascii?Q?PKazWCOXjv6QXpL6Kszi8EpOMQUVMaKFnpZM/WKtpf/BLa8LXnOMYiC6UQGF?=
 =?us-ascii?Q?PXbpmoAEUY4ETZyLimoOWxp4QtqNSUCeoYft/rvZRdMzwVg+ijBO9kWx+Vho?=
 =?us-ascii?Q?iG4RhImEdlFSvF0b5OMCPA83gFwhOmB2capXmaY0zLXL8scEQL0lDo4xQWXG?=
 =?us-ascii?Q?UOxI3KK85wB5hALSITzvcIZoZfKHOBdMdLC7SBii1pxSJOJ/CNBWWqAvEt7G?=
 =?us-ascii?Q?+wxRsUe+/Eyb1BppaLWv+8bPYelPloGSKzMALBglXVn0RJco0N+U4s4x9+MN?=
 =?us-ascii?Q?D7eoow2ACf2vrLpBt8wvzBq83/IT2vJpRiguRJ3FRZgcJ+7LR3VixyjskeC/?=
 =?us-ascii?Q?ZtJpBFEJ3GHSQpB7H3v/byjcx6h+dtTPkz2R/8JOmDo41JkLxm8pwzYGlDBv?=
 =?us-ascii?Q?+iAef0YtQuSGvnwH39/9uRHeJ+bHvbFb54mT0hEIyxccpBqks1nWKqMiGJcl?=
 =?us-ascii?Q?ibtYar6zgHDdfnT02sCAuK3Ed/aAlLVedgqAoFocwiSn6ogO5wViVyUhQZ4y?=
 =?us-ascii?Q?4fqT/nQIeYFPDCbwztNUhMPYmZlZ9slTLNY0cy/jgc1uNNzIwO8wtOlVTqD8?=
 =?us-ascii?Q?fMV/ws10zEvbypVRuBJK80TuE+w13R42hlzJ8zoJ95wrpeH5X+kQBHXT8GmO?=
 =?us-ascii?Q?FKKplX3ynXFjKU+PV1iewWMNe8GbcEE41acPjz+rgCjTBMxh8Fzd+gP1YjKW?=
 =?us-ascii?Q?q2XboD5jWwQ3Q/6CK4dgJSMVU32xJR7vRq3FhZF6guLXApoc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211730b8-879a-4c5a-c7ec-08df2d2c12c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 15:25:42.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4MXoUv7q1XruTDQo6MoMVfjzRsmuJEjGs4hz+SdEkYh5AvLArLn6G59dzFEjR4ZSWJnC3l7IzHBgGhUe6/uCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF95ABFC125

On Fri, Oct 16, 2026 at 11:15:56AM +0200, Eric Dumazet wrote:
> rt6_insert_exception() and rt6_remove_exception() update
> rt6_stats->fib_rt_cache of dev_net(rt6i->dst.dev), but the device of an
> exception dst can move to another netns while the exception is still in
> its bucket.
> 
> This happens when the bucket is flushed from an RCU callback, for
> instance from nexthop_free_rcu() for the nh_info of a replaced nexthop,
> whose exceptions still point to live routes. If the device moves to
> another netns before that callback runs, the decrement hits the other
> netns, whose u32 counter underflows in /proc/net/rt6_stats, while the
> counter of the original netns never goes back down.
> 
> Account exceptions to the netns their dst was allocated in, derived from
> dst->ops as ip6_dst_gc() already does, which does not depend on the
> device. The dst already relies on that netns' ip6_dst_ops being alive
> when it is destroyed, which happens after the exception is removed.
> 
> Fixes: 81eb8447daae ("ipv6: take care of rt6_stats")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
