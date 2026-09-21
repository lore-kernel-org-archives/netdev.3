Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBE157487
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964255; cv=none; b=tz4u4txKWiaGvceYEe+PNe1HDvgEGt4zOyf0JS758CxuNEy7VNnoIXvguPqZUTYf80PxSwWuO29x5IiUhJjNYEtJXeczLO741ZYiabbgWfd8DbMJlbcv3T/t7Lo4PJLMzAt3+S0EJCSui/x1NUtpMpQEdNc71T2gSmWCaXEbHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964255; c=relaxed/simple;
	bh=GASaJk4gMXSCH7AgvJaoIqbLuhXpEKXlbXXPujL6QpU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGg1q+Ze6UMHeWjvg42+2d+Fzzb+gzmSQ+n+qqdmHDTPeTwVCRKieoi/kwSS/fMcdkBY5rJYBIV3K3YpSYNSQoGewNGRpAs6Na8NF3X6MLVC55lYOdCzOqmJSr7AzcXad3PmJEn1Cpc2TZz8PiW0oDL5tYmQQxbwO9eHb/p5l4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX53+69s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX53+69s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D281F000FF;
	Mon, 21 Sep 2026 04:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789964253;
	bh=ZkwhNUx0ke+7m3F9pjmPZi87bUasInd9oGgPqC/F574=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lX53+69sOyGV1xYJtvWfCX66dwmzve+Eyj0JVj33iGBaGxZHXB1zTobfO/CiPVDRq
	 FLmtxMcQ202bs3hWb5/uup0P16+4kcxMfw00r2clinVQCT6IZZ0zYs446sx3NTkSbw
	 5CRXPho0gfWqRZZ52j+/qdGmKjy206tm5Ir66QDbPPp1RYKZ49HCjBQVaHjfbxMHA7
	 w+N5l7B54gq1Y61YRYlPtNeFv2qgHUcizCTVgWrNbQtERCwbaObtZsNJGCq0jxRhR9
	 j9lCauoWkWrCC1MUIlmpbkMasFo2haVpKxPN0Nm8igfdfhcDEEQL4XxzxVa5lpgx0O
	 ImS1Snowb9G7Q==
Subject: Re: [PATCH v1 net] ipv6: Fix dst leak for uncached routes.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 weiwan@google.com, marcharvey@google.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Mon, 21 Sep 2026 04:17:32 +0000
Message-ID: <178996425243.2160803.4584297902384929765@kernel.org>
In-Reply-To: <20260918041439.2575935-1-kuniyu@google.com>
References: <20260918041439.2575935-1-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete backport metadata: the Fixes: tags select stable
  trees where the patch is either useless or actively harmful, and the…
- [Low] Comment vs. code mismatch left by the patch.

Pre-existing issues:
- [Low] Documented refcount contract of the IPv6 link-scope l3mdev lookup
  disagrees with the implementation.

--

ipv6: Fix dst leak for uncached routes.

This replaces the list_empty(&rt->dst.rt_uncached) test in
ip6_route_output_flags(), ip6_rt_put_flags() and ip6_dst_check() with a
check of rt->dst.rt_uncached_list, so a route that was already unlinked
from rt6_uncached_list by rt6_uncached_list_flush_dev() is still treated
as holding the reference taken by ip6_rt_cache_alloc().

A couple of questions about the Fixes: tags and about the comments that
were left behind.

> Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_DST_NOREF")
> Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic")
> Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")

[Severity: Medium]
Should this also carry Fixes: 98aa546af5e4 ("inet: remove (struct
uncached_list)->quarantine")?

The commit message itself says the routes used to be moved with
list_move() and are only unlinked with list_del_init() since that
commit.  Before it, rt6_uncached_list_flush_dev() left the entry linked
on ul->quarantine, so list_empty(&rt->dst.rt_uncached) could not become
true for a live uncached route.  The other unlinker,
rt6_uncached_list_del(), only runs from ip6_dst_destroy() and
xfrm6_dst_destroy(), i.e. after the refcount already dropped to zero.

The three tags listed point at 2018/2019 commits, which selects
v4.20..v6.10 trees where the misdetection described here cannot happen.

There also seems to be an undisclosed dependency worth a note below the
--- line.  The new predicate uses dst.rt_uncached_list as a "was ever
added to an uncached list" flag, which only works because 9a6f0c4d5796
("dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()")
added the initialization in dst_init():

net/core/dst.c:dst_init() {
	...
	INIT_LIST_HEAD(&dst->rt_uncached);
	dst->rt_uncached_list = NULL;
	...
}

dst_alloc() uses kmem_cache_alloc() without __GFP_ZERO, so on a tree
without 9a6f0c4d5796 the field is slab garbage for any dst never placed
on an uncached list.  There, would ip6_route_output_flags() skip
dst_hold_safe() and return an unreferenced dst, and would
ip6_rt_put_flags() call ip6_rt_put() on a dst it never referenced?

On top of that, dst.rt_uncached_list only exists since d288a162dd1c
(v6.4); before that the field lived in rt6_info as rt6i_uncached_list,
so the patch would not build on the older trees the tags select.

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

[Severity: Low]
Should the comment just above ip6_rt_put_flags() be updated too?  It
still describes list membership:

include/net/ip6_route.h
/* Only conditionally release dst if flags indicates
 * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
 */

rt->dst.rt_uncached_list is assigned in rt6_uncached_list_add() and is
never reset to NULL; both rt6_uncached_list_del() and
rt6_uncached_list_flush_dev() only list_del_init() the node.  So after
this change the test means "was ever added to an uncached list", which is
intentionally still true for routes already unlinked by device flushing.

Leaving the old wording in place makes it easy for someone to later
"restore" the list_empty() form and bring the leak back.

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

[Severity: Low]
Same question here for the comment sitting directly on the converted
line, "For dst cached in uncached_list, refcnt is already taken."  The
condition no longer asks whether the dst is currently on the list, and
the flushed-but-still-referenced case is exactly the one this fix
depends on.  Would "for dst that was added to uncached_list" (or
similar) be more accurate?

[Severity: Low]
This is a pre-existing inconsistency and not something introduced here,
but since this is the site that compensates for it: the documented
refcount contract of the l3mdev link-scope lookup disagrees with what
the implementation can return.

net/l3mdev/l3mdev.c, kernel-doc for l3mdev_link_scope_lookup():
 *	This function does not hold refcnt on the returned dst.
 *	Caller must hold rcu_read_lock().

drivers/net/vrf.c, above vrf_link_scope_lookup():
 * Note: Caller to this function must hold rcu_read_lock() and no refcnt
 * is taken on the dst by this function.

But vrf_link_scope_lookup() -> vrf_ip6_route_lookup() -> ip6_pol_route()
passes RT6_LOOKUP_F_DST_NOREF, and the FLOWI_FLAG_KNOWN_NH branch of
ip6_pol_route() states the opposite rule:

net/ipv6/route.c:ip6_pol_route() {
	...
			/* 1 refcnt is taken during ip6_rt_cache_alloc().
			 * As rt6_uncached_list_add() does not consume refcnt,
			 * this refcnt is always returned to the caller even
			 * if caller sets RT6_LOOKUP_F_DST_NOREF flag.
			 */
			rt6_uncached_list_add(rt);
	...
}

That branch looks reachable from this path: an IPv6 raw socket with
IPV6_HDRINCL sets FLOWI_FLAG_KNOWN_NH, and with a link-local or
multicast destination and an oif enslaved to a VRF,
ip6_route_output_flags_noref() goes through l3mdev_link_scope_lookup();
if the matched nexthop has no gateway the RTF_CACHE clone is returned
ref-held.

No leak today, because ip6_route_output_flags() is the only caller and
encodes the exception in the line this patch changes.  Would it be worth
correcting the exported kernel-doc and the vrf comment, so a future
l3mdev_link_scope_lookup() caller does not drop that reference and leak
the dst along with the device pinned via rt->from?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918041439.2575935-1-kuniyu%40google.com
