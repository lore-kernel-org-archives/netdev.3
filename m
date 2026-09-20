Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EC43AB0
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925210; cv=fail; b=LNvapFkcPNkS0FuBuiaz3OTQDfJlqufIsCp5BCwUTjaGaexKXM8iiYjlJEJnrvOy5AChmgyHqVsgZb6WAGbEOeHZMyfYQ3Nsv4NFNmFX3Ey3z2wMb+jBcuN6eY/3vY6GvODHOnqiknBvivdISTBDZwI6zilMRmceXEpuq6KjrJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925210; c=relaxed/simple;
	bh=obL7PnAE0SwAew0FVizRq4n4RF/8euNeNSF9cLOPJyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kyVEhGWciHilAWEEyjbLvPoKT6yUnH7Fr8b84QlsRpHwcVZBI2JXlqwjt9xMItHACi1vMr9RHniWHht6SRx1+yYMJODmJV8gfEcK6y7NqXXrmTFM6S537QcibSd+IoAa5AXHOO0XGgJuSRZ4Lx5LNPatcoqRwte6Qx+cdaapZz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tKgS/EZi; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tKgS/EZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE9mNTF0gYuaBHTaPvvux/+rj6KuatkuZAYYRU+sqg0VdBqL+Kjm0Z1pYLcB2cH5axHVTkZDgPt75yqLIjVG7y/ELjmZDkmkWGUWNkA0JMgl9nAIqdBkGCqX1EyHiPE/Afu+n5rLvieV0mNbumwBOmYHMz5A39G8VD7P7UvzThG8IdFri6gH/LLVhu7fCM1jaVh7ekutIex+s05Lp1eWVpcjZICqT2pmCvHtaeGt0PHqidD0GVVJemzp9nP0JuiEpj4cnchphyKIxg+45lO5A6CMdFZjQZx9zoGdGJ8LTF7RHvJXFMJF7eIQgkMhANYET73t95nCaGq1AsK1wHsniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttT+R0XK+yqphKoayTWrJ9loOLwbOYAHaE+aQ9CkGbY=;
 b=pZToYb2HPmkkH7Tv7wfggQmVQH9kn5SQyIqFfVQ4o5N6FPPSCSeYbcx5C6fYV3q0X5W687uwtUeUIVVMkRBxbyo6tTNf+KoPpvKuSPTpeXpL7TQ0H1YkEfsD12j7c0IHapHbF1L5kZoNSPbCQcuCZlavYytkTjsMH2shSXspS1bO0RWf9XoiTRP2F9w/jHzFTIkFel2A97rJBhrYCfO9qO4OQOfTciYDIipI74R37ncR8ESdU6/hbbTdpALtb5fD/T/47+y+npgpMq4bQ9RI35qc39Xjm230cSEei8VpfIjKwT9vYysp+vJE9arWk5AoG5cEionFs0kdzNkJ96WJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttT+R0XK+yqphKoayTWrJ9loOLwbOYAHaE+aQ9CkGbY=;
 b=tKgS/EZiOGESxb7QKGZsqNJQMxP244oxJoS2p+jaQnH71cbdGbmaTMn5UlfCot7tV+faigu5RiXYSfvxM7gTg6i31/+rasU8KRpMVZaa/bWVANT6oLV3UMkgWzpObLuteoLugB7KIIGRT0y2yscBcBowLQHgnAfqzuXzKrkHWP/3Jh2vlIt9EvOR8eLD9JTVvEY1QMH42Zf7KBgANF9xl7MhCCw9dJY2zfdZQ6dGZxFMaybSYbvfTTu94SvEtTmsgDL9BJHGvDrTzbnkfSYdN3Sy1bjrYiaS9Jl7k1hsyOPjODJxfMVY1RY/CZOtyCiqhxtMM+xID/84x6T/cULiTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 17:26:45 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 17:26:38 +0000
Date: Sun, 20 Sep 2026 20:26:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>,
	Marc Harvey <marcharvey@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] ipv6: Fix dst leak for uncached routes.
Message-ID: <20260920172628.GA2051643@shredder>
References: <20260918041439.2575935-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918041439.2575935-1-kuniyu@google.com>
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e88c3c8-d47c-4abe-e56e-08df173c5420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	mWtu1mEzgJf7HhD2T2HJ3K8i0t5Buonc50MMJYXTS4aLjfmvWR6F2Uk99pMOA85qeCfQEhUB8lfhn3QDTqkmza0ZddIRHRQKFk+7IEdneu41+aKRKSuCgH5rBKniseQWbd8Oy+ggkwZWLAqP02HCtbM+VWeqjUE+kPVZVaquHEOWAvY7U9QxvC196SkgIMEWxTfe1oYHNVqHG5zAckRYiBaqh4H01rYqy2oS2yr+MO9lAQg8ytLc17XDmjCLj+Qx94mgj99pGEBAZvW8ukgzFbj4HvI+0W1GWDxwBBC/5tvFTtzDQCspY1n9/2f52a68sYjd5KkYjt56wJUYw6mHFWxHbv8cMeEqFJBbVyeYSis+qByBBpq/8Y2DWTdlrnWNMv6x0qxomBouWBVBAh2PnX7cEd6owS3ER0B7wOSKy3HtNrDfqomT5bhKHIX9VdQqWT/CKm6h0xCzCOneTTqS+VCtwfdkNnqUClgceO/jFByCi3QW9gJvqXO2mPwKC6XStKJ0pOOP82gdR0kXwwC54DwFLceaRKVqGbkot8m0g9MqyNWtKL04OayYSurJuVYz3GOk2KYHRQi1kBEIrI9U1NS1y8qC+9r1MYWgKw2M2HUUDl0ZY6ZRBUP8P2n8J/Li7qaYAO7j2p0HXkCKNZaFvf4c5m+xEgrsWVsSu1nwhow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZHg9pE98CADMQxHDSY4cFmhICwMAnpDOoJd2XbMt8eQ8VH1jI+rozzMrGTo?=
 =?us-ascii?Q?zc8iQjJCNlxGJS2biIrT3GqKqRsV2/HJMtjyUIMSJ+Y122Z+eD5A72bIQaiN?=
 =?us-ascii?Q?v3Psyl9i5biACqkaSjqeJk6J4sgjf54xkCHGvlUcQRMWSr5HgMyhkogkuxhu?=
 =?us-ascii?Q?Snc7AYAHMy0ZzHbzuVHbNoCsss6GMC0M1c6EpDGY7pYiSRxQvGwMLU1LxPD4?=
 =?us-ascii?Q?8kZZdBhM2Q0lO0kelLix2mcMR+8N7sXgkQu051HQEGE32RbeQmgzVBQ2Djyr?=
 =?us-ascii?Q?tmSXsc8sHR/q5W10VGQdUcK4eso1mspWodklR79YcacVesPXnFYKiM7AF4wU?=
 =?us-ascii?Q?XOMphu6ZHdfZ7vgdR5LxnanKhl70Tcfc31FGIDFkqAKMcn8+OmdOzuj8rECW?=
 =?us-ascii?Q?l4tD0h972M9XOIB+x8YUaPiQCTNAPgd4iVMpvL0SF5Mcp7mr8kUlHqCdWLKc?=
 =?us-ascii?Q?c3eAncFgTt0CLy4/KDUuBuyzZ9L4sdPDljWyYdvp7BeMDrmlwAJ6kHa8ZVid?=
 =?us-ascii?Q?2A1iFlPQgqT4Fnvt3+jGI+sjlqLJ3OnCfROyK3riJahWfQHbaFDixLLJ+hXy?=
 =?us-ascii?Q?v9Zua+njkJFnPL2DIXiGd/N1NgFPimMTV8MhThFqA4V4kwuVHcBxhUaXKzlK?=
 =?us-ascii?Q?mTfP62ojWtTItr6ftyW+4Y+yTBG1VCN26s+JvQPaY2lcMWMi8kpmffT3Spn1?=
 =?us-ascii?Q?y9l4Ce6XBVGhRXFu/bFs/Y+bqDvYqfQlcDJtjzbOznGdfAEARwlAnjTAfLHb?=
 =?us-ascii?Q?/vIiVhizFuKIyUI4X3sIlrw5tnSYhM11UUdi7JSY3xFA25GoUsVwZ97xhGwM?=
 =?us-ascii?Q?YA19FArSVZQxK0Sw9ZnnOE7Otkk/hWlWhWztLGq9Q4wJpkGTir7JsqUIfryh?=
 =?us-ascii?Q?ggi/K5RBvkVuzNK+7aISYKJ5VCUmvzTlI4YbNUKrZ3uRhNhdd++coP0QwHW5?=
 =?us-ascii?Q?Jb6qvEIY4rdDAMnq2g+QD1ZeVYZbRDS3NM2rxDWXkJ7sJWzapQeU7zm6WniB?=
 =?us-ascii?Q?A6ro45I7Ndu6Hks2enTXzoJBYnXt1FfqtYoitVPRsNrgzg4102pFAx+YRH2N?=
 =?us-ascii?Q?KmrOmDTK5FYiHd2hyeV5N8nwgrEzhDwHFQcGiznByH1sE+Hwff8g5tVkjNC2?=
 =?us-ascii?Q?7X+oXeQTJ35A12L4vBp9/OE09UnLVGwEH3zt9v4CZcXNVvYGj7w5LAwb7yyU?=
 =?us-ascii?Q?ahnaKKdCzxyir8QqS5LVopHY08atja+0zDoC3OgBGkePOj9ct7aeikwziTvO?=
 =?us-ascii?Q?Qo+pGlG1VRbzCd5xPV6w39dNFf12DPXNKklDafo7fES51QoimJKhqzttFzTw?=
 =?us-ascii?Q?itRL7SzaDhJurEOQqHAQLPu+U2vEldJQd/w52583m8gGP+Tic8wLrOafNrS2?=
 =?us-ascii?Q?WYSuZnGq7xY86biHk2Grb/AhM3U6BxbanJfTWoAaVeWPAx2ry4ji+FMGfLaY?=
 =?us-ascii?Q?L/aYgfynDoBrpMvXaAFdI9wEo1Q0Ovc0jd4camax/H35xRV0wLb6h2YfMzmQ?=
 =?us-ascii?Q?MOqAg1yvC+FzFoAKFl164Kw3EpEuwGCI2u4RClm0UkmjxWn8FmgljtLtxWPh?=
 =?us-ascii?Q?rG5ML0dHGYLrzmJgHWvcqGX5pZQEwAdHKwpnw4PT6XV4Gj0cKlO4BiLnrd6p?=
 =?us-ascii?Q?LedJ4v5xFSdFpVmCyopnQgLFM3pbjWX7fypz2uHUTYO/lOfp6JCbzW8ZaC2H?=
 =?us-ascii?Q?S2nve0f+2T43F1LZoIVCdsailP0LIjocEKkUAc9/cy4NqfhymsTiEo6sTX2r?=
 =?us-ascii?Q?+vqi5bcosg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e88c3c8-d47c-4abe-e56e-08df173c5420
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 17:26:38.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APSPxVIQPJiPJ0qjon1IgR2LfGGtJlXK/rNKSUFdq0Orl3q0huTaWcj81YqCJFg8m8x3wJUyleHZ9jVsLf74lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

On Fri, Sep 18, 2026 at 04:14:37AM +0000, Kuniyuki Iwashima wrote:
> ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> detect an uncached route by list_empty(&rt->dst.rt_uncached),
> which replaced the static DST_NOCACHE flag check in commit
> a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> 
> When a device is unregistered, rt6_uncached_list_flush_dev()
> unlinks uncached routes tied to the device from rt6_uncached_list.
> 
> Previously, they were moved to another list with list_move()
> (__list_del_entry() + list_add()), and since commit 98aa546af5e4
> ("inet: remove (struct uncached_list)->quarantine"), the routes
> are just unlinked with list_del_init().
> 
> If list_del_init() runs concurrently, list_empty() evaluates to
> true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
> and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
> dev tied via rt->from as well.
> 
> The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
> fix races in rt6_uncached_list_del() and rt_del_uncached_list()").
> 
> Let's check rt6->dst.rt_uncached_list instead.

Please add a comment that we now rely on this field being written once (never
NULL-ed). Otherwise it's quite fragile. Something like:

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 36e999b22d42..a6b21edbda29 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -139,6 +139,7 @@ void rt6_uncached_list_add(struct rt6_info *rt)
 {
 	struct uncached_list *ul = raw_cpu_ptr(&rt6_uncached_list);
 
+	/* Set once and never cleared: non-NULL marks an uncached route. */
 	rt->dst.rt_uncached_list = ul;
 
 	spin_lock_bh(&ul->lock);

> 
> Note that IPv4 does not have the same issue.
> 
> Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_DST_NOREF")
> Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic")
> Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")

The commit message reads as if the problem is only visible since
98aa546af5e4 (v6.11), so why blame commits going back to v4.13?

> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/ip6_route.h | 2 +-
>  net/ipv6/route.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index b9e8d2b759e9..2c5ded121f54 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -106,7 +106,7 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
>  static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
>  {
>  	if (!(flags & RT6_LOOKUP_F_DST_NOREF) ||
> -	    !list_empty(&rt->dst.rt_uncached))
> +	    rt->dst.rt_uncached_list)
>  		ip6_rt_put(rt);
>  }
>  
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 08bd68f1b5bb..b18cd0d9148c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2722,7 +2722,7 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
>  	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
>  	rt6 = dst_rt6_info(dst);
>  	/* For dst cached in uncached_list, refcnt is already taken. */
> -	if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
> +	if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
>  		dst = &net->ipv6.ip6_null_entry->dst;
>  		dst_hold(dst);
>  	}

Nit: The comments here and above ip6_rt_put_flags() are now stale given
that we no longer check for membership in uncached_list. You can change
to something like:

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 2c5ded121f54..0f9b7a260d25 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -101,7 +101,7 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 }
 
 /* Only conditionally release dst if flags indicates
- * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
+ * !RT6_LOOKUP_F_DST_NOREF or dst is uncached.
  */
 static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
 {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 36e999b22d42..515115abe2f0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2721,7 +2721,7 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 	rcu_read_lock();
 	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
 	rt6 = dst_rt6_info(dst);
-	/* For dst cached in uncached_list, refcnt is already taken. */
+	/* For an uncached dst, refcnt is already taken. */
 	if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
 		dst = &net->ipv6.ip6_null_entry->dst;
 		dst_hold(dst);
