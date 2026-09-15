Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9143D4EC;
	Tue, 15 Sep 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494862; cv=fail; b=By2YxRQDYgA29F/269TAlPJ0lXa557jL6Yl9pa5csZRSATn9kZPIm6jkkokhQeB8IPWgW+r3Uv2bDLczsC+AFwhQqPoCWtky8VFLx9nCMzFNnwuPWqjEJR/m0TaW1nhpZk3w7vXdvnpjB4kJ6GOnbq4m8ih3T1VlQ+9fabM8q/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494862; c=relaxed/simple;
	bh=cd2Zh+siKUw4iFkh0IUFRrLGbHIg9pK2B7vQ4SBBDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbWJXq6dIz8m1vnA9fYBgAa3nCubv8Q95LvADrP+cTx2hYbbvBpyW4UZz/E1X4SplC1OpLCKurLckyK56HnTsLZWjG2Lu2aBxYPZ/03pfkTn7o7JbbaEll7GoKK1abQQI+GO7U0mnE8+46dUxO7iZpt3auUxKrhNGr+KgZYvsE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rokOR0Fm; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rokOR0Fm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J27yW8dCaK8nRSGWdAQxwf7fDTQ1sMaz8cwQdrmrCe7N0pjRt6nbIRan0OBhvKHY8c0wcAY+K+s7438/q4nRfazo0z0a2mDnY/AaWvxuwZ/FSy3lTDnjcBI02qc0jqXRSJ9vB4b2APnJy8OXbhrJDk8eL5qhECo26tcMe4bZDx/Z/8vBT+d4OdCy4bPTOIBv/Lo+/SqD0FdKvAxwOouyCgRxTip/HmUtkHZs8ELVOjWl9btAY6Hpvq+TBtwvuLDlJpbL9BHbv1cYOsneOcHsXpMhipPVzZJHkV4bpAXvTJKx0tsq/lgwwIL/L6LrTjqcbR+Ke4SNNpaMSX8hJM8H0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R107t7PobhUoYxLHdvWqugZBl+ZCwO+vJk5COSXsxLM=;
 b=DUZbxi2/aMXxEruIjTO0ALtG28ylnePw6qym0hVK0PRht9OvJ6uUWSGJCmuvRQ3qkbsoQU5dR0BBd55OYSyM5CUxzgPbqECz4yqsybYMnU0Yh9+cduLTReprj4Mp5yDq/7JnF0sWpmENtZm5OnKURCIsfRbujT/GpbifYzwcdIF7CEP+wlHURVQpMkAxWYTq9k+EwB6QkSTRDXqNtgWlTxzd11I9jEGxiXWtGufUaEbl4mDWJzw1sJ4to+Q3blJVJ+j0oHMW4wvXQCS+CVxz8OZ0b6QVGft2g2sU/AZAc/MEbr7AZOxrx0o06TvTHxqgulR9YUGVOD9oFzCmC7rW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R107t7PobhUoYxLHdvWqugZBl+ZCwO+vJk5COSXsxLM=;
 b=rokOR0FmpOt4c4BAVlXN+QL1R4q7gT5jsM26oaK5Yjs7mcJptxmYbcb49ingBrY7YedC+KL5Q1V206coQRcyIqgW47LjGBt+a6uSnVokZtYH0ldPQ2XDPjJwWL5reHDCw6NtuzJ3cm7obY0U/UCv7yq0ye3re/jSQUZb6NPMO4BUX9aubIX8kGA8acT5yu51WWDEYcMv9hNeUqtE04EoIHWTTp7uA/cGafAhDkoLTnqqVaNXTCarKmZkzzAdQS5Yk9NGuCHUPyd295XKm6NS+dNgjnCpvv+fsRZa9wtmx6HZHkA5/8H9NJ0ZMXd73QHsIcHfFCDcAjaMFkZVlJFitA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS5PPFBB8C78349.namprd12.prod.outlook.com (2603:10b6:f:fc00::660) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 15 Sep
 2026 17:54:12 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 17:54:12 +0000
Date: Tue, 15 Sep 2026 20:53:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net v2] ipv4: fib: fix data-race and stale genid check
 around nh->nh_saddr
Message-ID: <20260915175354.GA805835@shredder>
References: <20260915071503.465875-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915071503.465875-1-xiaolinkui@126.com>
X-ClientProxiedBy: FR0P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS5PPFBB8C78349:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e9552a-50b1-4855-6f82-08df13525973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|4133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WIpD0BU5Q7zZRx9b9ZnDtseUy6sEkNiCa9WqJ4kd/pa/XkiOul/zbcfuh4z0JKiJfatIZ/STchn0DLAm0gBOM3XHajyjNWMk11q69WBCLL9JfRehQnRrY2l4+GHFZeNxLtdrrMA5XSt4//0NdcgW/yMXh4C9GHbfsHK37Ort6cwu8a8VJieRl3zLCUSy8pu1zWe5Uq14FYY9foR+cLGphP8VJ2kVajKya1YUacOyOOE7q3moS0HBYlgkfQFsJ7WAnAHppuBEFXIvLXXqB8VuVr9F2M39nYwj9NT1FVcbqh3lrlDiH4f5o79qJLQC1XOXhXhxF2B5KaFszpJXD0/8Ex+Pd0lr9K77a3EaPD+Xo+e9du/AKDzpWidk0oY/X/v/nEpg/fWBe1+P1Y5USuS4XI1rg6X3b59SZFRB27Eg/2/DekYl+vDHUhjho4gojm+B4zEHKD7n1ZPgDw3b+oxn/Rt9+v7Ba5HlB9i5ZqOcSolCf7e9OhGdF3PB7FvSqB8AQNc80DqqxlovraM72Py3lu6RyiZud0r/EmWlweI9T74vSVaaycIC9nxCCz5GwxC2l3+Wjf5IQGD7utmfMwD5YsFrIVWTV5pq1Y5OXzznzkMVKUZg2yIt3O7HCKzXXjYW1KimC3Nwk7g6gvWBvXmLzPVBrfkZCdkZClLbBawmUyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(4133799003)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BpdLlGXWhR+YT7+P7uSdWAQoScJEb3H7KdaC6qMAt3oxEZ/TSAvDQiPspMYl?=
 =?us-ascii?Q?dHPQVCsKXGeg1PaHalxnjtakviK4Mp75sv0LaM+4OR0RrNwKnIv1ZnVHMGv3?=
 =?us-ascii?Q?g9mP6xW7JYDvuhDe4eZHdFi3Y1mwHiqYN1pEPDeLlhOPHHa9HdByWNi8Wtis?=
 =?us-ascii?Q?WT2+W+njA9SBTSQ/XDSQ8B797Dt7VBpay2QAyyCbCgPR5qi6udB3zw+t3R4s?=
 =?us-ascii?Q?F5qH0NWO5daRbi5oaTt7PgMe/S94rYXU9lmw6UVHFuTGtkV9ocLFIeVl1ktp?=
 =?us-ascii?Q?mvXHj3VOfLfq1usiGFbvsQYtKqEhgVb6B2XqIxM8ORPF+7dXMN0OTs3UvloZ?=
 =?us-ascii?Q?tO2xFtbYKox+sHDc5LZynzoZI7JIn2uXUn6+mYhcu1Yz2RPbzadPEJBvOvAa?=
 =?us-ascii?Q?aIxONxpuZgkkd7w21p6ZFRfiC2ifKZ6VFLVpDHE8x0pvT8Dpk3C2tzLVcK9J?=
 =?us-ascii?Q?+gw+0gDk+tbzZXQ7gWkYdg6g+xWMut8oBpgjvZKkw9ZdHm7nf3aibhJ8DoZd?=
 =?us-ascii?Q?NAdjVwS21vWk+14KyyrTh0J8mxXRVmT1rtzIcSTlOvVhlk5BfkO4VXxoFmil?=
 =?us-ascii?Q?Ok44FdDkHNFBTXiwHnSv5aXkb6tzcFLX9wSq2kofuUaGG+I5i70XjlT7MIIK?=
 =?us-ascii?Q?DXuMeH0rXE2UzJg0J+ENHz3ZXdQ/7+Khj2OcJy30X1P+qQxFjorcPviwvWx2?=
 =?us-ascii?Q?3wsogNUcb8YDXTBQWqlB6zeia5eZhAtHCsVYhoO+Z7vgITssA9hSMuMLgx6w?=
 =?us-ascii?Q?xHThtbnRM/B4WOkQjVdl2W+OQVFnAbeTHs6y29tPTJ8GVH60IvpV0Zla6OKR?=
 =?us-ascii?Q?IjcZgxtpzu9Dca+AzFfyX+1uwocK7Y0DagW3WseCBIuQfjy4wfuwd+pqnaVu?=
 =?us-ascii?Q?ni4xDrWAaEh7xrApbkHJ+lc+KUGuUaCPY/JDsrH88hUjr7dZM2JMnBa3wpE0?=
 =?us-ascii?Q?vgEJ6r1fx65zaTAiQtSxMB7TRPZw/m5+y6acQiIJpRSI0QI+WyEfspE0Bcfb?=
 =?us-ascii?Q?48sCkMG2qUdjTOJHhwLBiv8bEFiY+6sSLK+HPGygSKaikp+ApNlrgq7cHh9y?=
 =?us-ascii?Q?3KmwDBl1FhSieOKzziEFQtWGG6HaofIf0BCSvriwce7ZkODs7SVOIGkIoPqF?=
 =?us-ascii?Q?pq6zDQxExq6edSQhh4+sGaBvFOCSWeA8AKW+rfxSGRixfCOzxC1yVdHnUcAl?=
 =?us-ascii?Q?fP4yDOSecASV5kAWnu763dtAmwCKhPeAb1Az4ga2hEQQSimbtaKfU/KbgXUE?=
 =?us-ascii?Q?wXSDSbOObYL3yIpZSRw+V3nPWA4N+CVjxR5G+ZyA4zzIS6JDvJSm7/ZpOgnQ?=
 =?us-ascii?Q?xr1uQHst3W8iEIvpgxvrg6GnsgLPYTlZQ+mI0P0SRwTfkiO0cLidLkyJkcAF?=
 =?us-ascii?Q?0Jag22qSnco6LRz65g3ww2zO02z3Xpjul8eWj1/yAaIM1lmp2k2CGK10vdz7?=
 =?us-ascii?Q?ApPT/Ema2SmyF0XjbEXAczhprZdirfZDHUMp0pwGFU9P/q8RU+mqxFyKyFSG?=
 =?us-ascii?Q?NCoeIQikqbmYCzIDNBly2VDR6M6pJtbz6KPQ7NVvBjWutzBGFRF0+Xo9fqhL?=
 =?us-ascii?Q?B/+EOKPZ8y3UXLoUEi46JX22FurdQdMO5z9CKQC7/iVkkkK+qWrTgJ99V8ep?=
 =?us-ascii?Q?D+S90FfoUDLbb8tbAHY2tteyfGIM95BfhyhVT6ND5HSbFEbykTrKgYq77vuH?=
 =?us-ascii?Q?fYXihXUhNceqwyFUZi/0M7Htf3pbU/EKw+BXs9Uoi092uxZtTWqZcgUPieIq?=
 =?us-ascii?Q?CIuKCw7QNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e9552a-50b1-4855-6f82-08df13525973
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:54:12.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3FjPBPNqKb9JBa9r9x4D4oxIYlsRdh3uM47sTdf7LnpjmXe47hPQqTMeoiwqjnB4xiHI6EO7jFbX20xowOKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBB8C78349

On Tue, Sep 15, 2026 at 03:15:03PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> source address with no lock held, while fib_info_update_nhc_saddr()
> stores a new value from another CPU as soon as the preferred source
> address of the egress device changes.
> 
> Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid
> and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
> in fib_result_prefsrc() after syzbot reported
> 
> 	BUG: KCSAN: data-race in fib_select_path / fib_select_path
> 
> but it only covered that reader. fib_select_multipath(), reached from
> fib_select_path(), is a second lockless reader of nh->nh_saddr and was
> left bare.
> 
> Moreover, nh_saddr is only meaningful when nh_saddr_genid matches
> dev_addr_genid, as established by 195374d89368. fib_select_multipath()

It's established by commit 436c3b66ec98 ("ipv4: Invalidate nexthop cache
nh_saddr more correctly.")

> skips that validation, so it can score a nexthop using a stale source
> address and skew the ECMP selection.
> 
> Annotate both reads with READ_ONCE() and add the missing genid check,
> mirroring fib_result_prefsrc().
> 
> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> V1: https://lore.kernel.org/all/CANn89iJhFL2LNQCXTANQAx8B1GVdGTJgrDwPTZOjbH8k1ygtsg@mail.gmail.com/
> 
> V2:
> - point Fixes: at 32607a332cfe, which introduced the bare reader
> - add the missing genid check as suggested by Eric Dumazet
> 
>  net/ipv4/fib_semantics.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 7a362f2e2c2b..e2bfc11aea09 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2184,6 +2184,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  	bool use_neigh;
>  	int score = -1;
>  	__be32 saddr;
> +	int genid;
>  
>  	if (unlikely(res->fi->nh)) {
>  		nexthop_path_fib_result(res, hash);
> @@ -2192,6 +2193,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  
>  	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
>  	saddr = fl4 ? fl4->saddr : 0;
> +	genid = saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
>  
>  	change_nexthops(fi) {
>  		int nh_upper_bound, nh_score = 0;
> @@ -2204,7 +2206,9 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  		    (use_neigh && !fib_good_nh(nexthop_nh)))
>  			continue;
>  
> -		if (saddr && nexthop_nh->nh_saddr == saddr)
> +		if (saddr &&
> +		    READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
> +		    READ_ONCE(nexthop_nh->nh_saddr) == saddr)
>  			nh_score += 2;
>  		if (hash <= nh_upper_bound)
>  			nh_score++;

The cached generation ID can remain stale for a long time and during
this time we will silently downgrade the nexthop selection to be hash
based. We need to refresh it in case there is a mismatch. Something
like:

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e2bfc11aea09..5c9021ea3a79 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2176,6 +2176,15 @@ static bool fib_good_nh(const struct fib_nh *nh)
 	return !!(state & NUD_VALID);
 }
 
+static __be32 fib_nh_saddr(struct net *net, const struct fib_info *fi,
+			   struct fib_nh *nh, int genid)
+{
+	if (READ_ONCE(nh->nh_saddr_genid) == genid)
+		return READ_ONCE(nh->nh_saddr);
+
+	return fib_info_update_nhc_saddr(net, &nh->nh_common, fi->fib_scope);
+}
+
 void fib_select_multipath(struct fib_result *res, int hash,
 			  const struct flowi4 *fl4)
 {
@@ -2206,9 +2215,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
 		    (use_neigh && !fib_good_nh(nexthop_nh)))
 			continue;
 
-		if (saddr &&
-		    READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
-		    READ_ONCE(nexthop_nh->nh_saddr) == saddr)
+		if (saddr && fib_nh_saddr(net, fi, nexthop_nh, genid) == saddr)
 			nh_score += 2;
 		if (hash <= nh_upper_bound)
 			nh_score++;

