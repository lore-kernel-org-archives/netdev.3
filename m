Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9E3D967D;
	Thu, 23 Jul 2026 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834445; cv=fail; b=lb4CalUc5RAQZC1kzAD/1MQbXlZ5MFZ7prBAaAYmHUNEg5M8nOtAz2xQDO6NEmUYCKY90AcudwIojIGflL3z3mtn+QeeRd6NHiqPwCjBVvomzwFEGwOvaSiYR8mSl8YrUgD068yqmXas+H1MMYhQsavUeHASB28wRxVF5aQnIhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834445; c=relaxed/simple;
	bh=nuoEs+aJULx/yqBHIBEXBg9S5bw1H0nt/lJRMKgBpRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1aifv6BPo9hzy17JqRsl15cE7CrINp0RytR5oZbJlSg3lTuE9lUKfw+nP43VdD91isiG6fJ6fRDBpOHkfEJHX6daQGfeX6kIqRzYQdBy05qlJjsYMUwxaB/ka9GelH43Eaun4pudtUsW8nbJbPL7HMzhYwVtf6ey3JG3zjDVME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRvDvMRT; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRvDvMRT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4jnfcGRMnIYm3PCCRy92ADFxClvWoPRqM6KTaFGHs8NJr1gK4QKt/WayCLEdCjlaw8kIgDP6ziAjrnorE1PnXOoJi5rRUNu9FAWVqhgC+E0mS1hoLiCEnpYqOuYk8wqp6Aeecqu/B37KSwJJhDWv16XknY8a27umJCpZQOwmJE08TVMKwLfViwbY12ALmgOBADh0o2Sl03hEMg7Ca3hhri4bgnONboJnNkEwmM5U20BYMsmjdoJUXHP1PExbV8uwQoniXSL2znDADSLC12sMjy9VF7WdGcYTMf7uaNCuEoNGjXV0sny2WPRrXww0siWO6Xmxua2ofTujiICiPTUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=647CF8/q462ZbRwKF3WdF7aHFPU2tLyNFZYbQLVTRjI=;
 b=m2bT8eIw1hPEtFKMJwvPmPJAio0mqpmrjc23zcmK0040e25/J5xeURcjiHeVXn0kF+1XHjS0SoeJA1qTworX8+fHmrsuEhcifCL/9+C/+uKg2JnkYWXBMrvA7E4SXZJNHcVX49u0+qmoiTiQ9PGhvwHQxULeTl/4QuhkiQ2bOTNcYX1x/wfEkpggLgBMTGoHMTAYO9OitdReUEpN53hL9MgZ8TSSXS3jBQfUW/v9nCvYNT1yudzfUG6dnLvTP8+KiuEvVbQylC7V0fDnUxfw/GtvomXD6ZaCxaxIWY6KCApSkj8FZEUukSx2YayrwdnwTsnxlMZ6PuEo4zERWAVbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=647CF8/q462ZbRwKF3WdF7aHFPU2tLyNFZYbQLVTRjI=;
 b=iRvDvMRTd30tMNhMCQTLT0jHTkZmPYVULNejkcZ6GzOoY3U61sLVEAw1iIVc4sIp5FdfJYdKCmIFGX3yTvwYV2i29tLH43aRhxQCeISby+B9JxrEHmC1JrWO2Q7X9sDcu5NImlNJjhtSDu030GOwB4glqkwUOC1p86+jhWDKz9b8xUa0tg9Nx1mg1P0rA7R33jqcA+5v5iT8caPh1CjCV3oTo5WaEvytgdRLQ5lHJrpOy9TtXRKqclYROWURdQNZwmwp0eVNoBbw9uwj/KtH6/mxdJa+GXOFyO1VqNC5x9Tmng4sxY4rV1f/7N5PDsxXOLs9jImwf3Yiga7IvM11Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 19:20:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 19:20:34 +0000
Date: Thu, 23 Jul 2026 22:20:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net 2/2] nexthop: avoid unlocked f6i_list walk in
 nh_rt_cache_flush
Message-ID: <20260723192023.GB3531265@shredder>
References: <20260722002951.2614721-1-xmei5@asu.edu>
 <20260722002951.2614721-2-xmei5@asu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722002951.2614721-2-xmei5@asu.edu>
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 1460c163-066f-442c-456d-08dee8ef77e0
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	pcIQ/jdC80Js0OzqH12WghGGLXKP2VGTAS4LqOmU0U3TXbWxDCaqef/qEYjINwx0wtRsDI/3tfrQgTbXKK5fRdZYxoEgRJxgiWItLu2JSiQBtozzovk+Cu1VWeHIAiUFpE2f8pD3Y4qikpvdFcNnD2zRQLfmN9cyimg3M3eyDH6966cIehvO8fSzhvDAo0tNp2Luk4Mbx4zeEPhLPTpbThbNChiWdXudcVYOvGsPQn8jpWREbk0VJjm9oj15iRqQaIlX1sjV6kisJ5ASvaDoYbz0q1NQZtceauBTHIPpehFcOLXajA5caFzrzVglPUCAfKGcJ3STxC6aI5xSKjkptbpxLKwUxXnRxpyqKx44z6u3dzdKL/i/sXOE5wD0ZD/faiZFDhZJCThUOMsKm3LGxWUQ6/IkpjML1lr9vWWgch+hj5kerQrhnCNERfCyH9wiSzn9LszPnre7H5FCLitX0oICZ/6UVocs3lF2KIkhfwmwEws8ERKZbHOP/WzmtCDhprLccM232Nh5l+6NGZkHv8LzKiJi+6cMWwoQpmItw2QFBhGopI7L68u8kHDOJTjpYnoA1E3IUHih4KijvpEbem8Vhv5qBx3Q0dSyMTyslnNq2RcMRcZPK6nbaujR3/3pm+dDqng0Lk31tjsv7fTUjfBndCAaZ+R+MHxQe+HBevI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Koo7kq+7ffH6FpfvY74cT4CYaM0/9/wnw3t47a8dtPfmDGEpMOz62HU4GXh2?=
 =?us-ascii?Q?awlxIe6O2lowOSjvwMZ6R6DMLPwIH86K5egyfR3IZlpyrUVgEojyU2OuKT9v?=
 =?us-ascii?Q?QlpGm3N7a0BJ+RLx8c1Vh8ZuhrPChHZNoDg9afwYVSF9g/7iTnCXgZ/oguQe?=
 =?us-ascii?Q?APPCDzN3BISwQsKjWkHY7BIujFwtsx4bGQS/oQU4wUBDXpXD349ZySapUcLt?=
 =?us-ascii?Q?7tikH00YljdImSog5FCVWTKw3l9tv6A6evK5sY2jeFQy9A7uZVA5RRJRo11X?=
 =?us-ascii?Q?AM4oecyna0EXDu+SnaCmcbuDUkaJNy/fc98UMFi3oBNH4k7N41UCe26rD1cc?=
 =?us-ascii?Q?r/b3Pu7TFDkSReXWvCoOhMoATC9D2SQNMb3DBTGhdSailk/3Bj/qyNMg8GOM?=
 =?us-ascii?Q?kfovF3gKvj6u6VCH7wx5EuqUN9L70gB/kRNunxXRUlmAnk1UT2InJsiqR2H9?=
 =?us-ascii?Q?bDYNVg7/O+i9SS42u9Qb3wdSMwBaUddY2xppAO8lG8S198DOnQen9fx970/k?=
 =?us-ascii?Q?YdmLFlU+Nyzf/7AYiAIpKrlcVjX2IrVzktwASk4CVQTrtcAEKpByjrMwbU/u?=
 =?us-ascii?Q?oh1zsrMIlfoSkt2MxIJEznAGlM6g0dRabjWg0CjNiEvTaLbSKIkUW+1uSXNK?=
 =?us-ascii?Q?c/FDNobdHArzqXogL/BYKdSJFyFsk8hHuvBUpU5EzJLC5AXXRz07QwQ7xWre?=
 =?us-ascii?Q?Bjc03ly/BFp21m7IBj+WmasPOcBSW6QWKzbPbfH7Vs1U42XoT+D/RqEwIcAI?=
 =?us-ascii?Q?FZ14TgqvW5OaDTBfmlwoF4J/WxvQhwLKa/qlXKIATg7NLR1s7AyhzTCkyuFi?=
 =?us-ascii?Q?zA1qhie/a3ggI+lorOUHAdIW+Z3xMHbWFdV0nnV6Rzv12EAeOYOZH9g3yAMo?=
 =?us-ascii?Q?mCXu4ST17cJ1BXKVarAje3mRkifc35im68k6WvkuuwJzZlC0H4ZXpOUOaOjy?=
 =?us-ascii?Q?OIwpzZVCLhgGC0EZetfRZYuAbxm+IwtHSoneZ3zz1ARQV/GEBIqSx8P1n/FT?=
 =?us-ascii?Q?Xbjiw9xH2/z+VoumFhhIfBU77DfypEZQVUmc/EcXQrkGRlLqlDklRrGvcQgE?=
 =?us-ascii?Q?jp9MAYgufu2jtyhjy9QX+TZtJ/1UXR2lwfAiSvFG8kPNVDniahefPMzsIFVV?=
 =?us-ascii?Q?UXUaqSMwioHD7Dj5bBxmP8WlhjDAE1jgTT5G+q8XZjaq49REO76jzfUe/K8M?=
 =?us-ascii?Q?S5L6izGLPkJ0yjXtuQxo364ILfkQYxFRG4t2UZPSHCrwKsifDBL3hI24thvz?=
 =?us-ascii?Q?QLwDyXStuM72JvvHxcqIXdPeYGOIdktDqSwSjYG6rZ+/FsJox0cVDc84hMhU?=
 =?us-ascii?Q?sy1eCfCIvusuUEW6OTv71g8RCJZMoTuFtObMrigSegK1EaeiwTlvkJXx2fIJ?=
 =?us-ascii?Q?ggfbrtdFfCDAIe8wpRLe7TMQfx5+z/F/k64JgC92Z+8astyrEg8DsqKliWFt?=
 =?us-ascii?Q?W01o9dHwf10GfbI+q5u9ogsN8gVdGDFSf3WWXDz8MyAab/BisUcykaKrpK5Q?=
 =?us-ascii?Q?BO+Qa3nUvBvNMSrtu8zXcPB/QauIaOqX2hPnf0/oNA5dhF264+yV4lSn1Bub?=
 =?us-ascii?Q?yx/rZEKmI8BVno87IeJISLn/uuGlIo7xoIxdqRr8QDluu9DBlQwFFC5s4LSD?=
 =?us-ascii?Q?O9I27+qszmBpxQDfg4kq82PB6NHtlU8T33EE/u33SBX0JqB1gmmyKaAYW4Pb?=
 =?us-ascii?Q?cgNSnktI2xif5Ck6SF0s7buEwnOjsEuhTaJmVbH0pCxL0otTaUkBOgSec4do?=
 =?us-ascii?Q?v4ppaZZ4ew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1460c163-066f-442c-456d-08dee8ef77e0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:20:34.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KNqCpWaLGEXaejwSlU0r0AA9xLoPdwA2g6KUnpw61TLPfeiwvwFj51Wd8e2L7AtfrK7E6k955fKmOdQadLBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

On Wed, Jul 22, 2026 at 12:29:51AM +0000, Xiang Mei (Microsoft) wrote:
> nh_rt_cache_flush() walks nh->f6i_list during an RTNL-serialized nexthop
> replace without holding nh->lock, racing the unlocked IPv6 route
> add/delete that mutate the list under nh->lock and free fib6_info
> entries (nh_rt_cache_flush() is inlined into rtm_new_nexthop()):
> 
>   BUG: KASAN: slab-use-after-free in nh_rt_cache_flush (net/ipv4/nexthop.c:2243)
>   Read of size 8 at addr ffff888012953e18 by task exploit/146
>    nh_rt_cache_flush (net/ipv4/nexthop.c:2243)
>    replace_nexthop (net/ipv4/nexthop.c:2610)
>    rtm_new_nexthop (net/ipv4/nexthop.c:3323)
>    rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
> 
> Unlike the other f6i_list walks, this one bumps each route's sernum via
> fib6_update_sernum_upto_root(), which needs tb6_lock; taking nh->lock
> around it would invert the established tb6_lock -> nh->lock order and
> deadlock. As the only purpose is to invalidate cached dsts, bump the
> IPv6 sernum for the whole netns with rt_genid_bump_ipv6() instead,
> mirroring the rt_cache_flush() already done for IPv4 just above.
> 
> Fixes: 081efd18326e ("ipv6: Protect nh->f6i_list with spinlock and flag.")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
>  net/ipv4/nexthop.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index c1d3b7d7100d..1e9ccac6bf0f 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -2240,18 +2240,18 @@ static void remove_one_nexthop(struct net *net, struct nexthop *nh,
>  static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
>  			      struct nexthop *replaced_nh)
>  {
> -	struct fib6_info *f6i;
>  	struct nh_group *nhg;
> +	bool have_f6i;
>  	int i;
>  
>  	if (!list_empty(&nh->fi_list))
>  		rt_cache_flush(net);
>  
> -	list_for_each_entry(f6i, &nh->f6i_list, nh_list) {
> -		spin_lock_bh(&f6i->fib6_table->tb6_lock);
> -		fib6_update_sernum_upto_root(net, f6i);
> -		spin_unlock_bh(&f6i->fib6_table->tb6_lock);
> -	}
> +	spin_lock_bh(&nh->lock);
> +	have_f6i = !list_empty(&nh->f6i_list);
> +	spin_unlock_bh(&nh->lock);
> +	if (have_f6i)
> +		rt_genid_bump_ipv6(net);

Can you look into converting this list to RCU in net-next so that we
wouldn't need rt_genid_bump_ipv6() and instead restore
fib6_update_sernum_upto_root()?

Note that rt_genid_bump_ipv6() is much more expensive than
rt_cache_flush().

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

>  
>  	/* if an IPv6 group was replaced, we have to release all old
>  	 * dsts to make sure all refcounts are released
> -- 
> 2.43.0
> 
