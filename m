Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048373DC4DE
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789931763; cv=none; b=Xn/0hyHOgN0e5jd2ZkQUhLyrnD4BbeiwAyGPz3QohmQFemvDI7NizpYY8OxVGx0NhUoVhLGmDt33GzrADl2eYie91RgmeGRlWyFYPnOfZb7bAxTopJlyTUqMx5vDfqtHMsD8XqLBHagW3ASat7ZCulN3C5c0XoNDHeijYGfOohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789931763; c=relaxed/simple;
	bh=549hsFGxjaXP/tsJ0PZxMRBQbUR1FEM5nN/YlvXcRTY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mEJj+vVLqZ2ggoE1ImjgR226DwMTC1dL+W3MkiVksXQYYLSRII0qUVxjXpLDNAS2Ho6DMdZ+kcTrOrOrQN8VwvT/P9Q6ZKOgfyiRX7c01AOv47htmF94t/kbDw9aUKVI5urKA51rvzcZdcDIbmGsCRlglpEKGUs15wq0nu56BU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iGDAipxH; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGDAipxH"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a6f4ba619so2314550b3a.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789931761; x=1790536561; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MRHHzZuzTFHdeZZCwVQrfnnYfoUZ+O10/vzVIYuQB8s=;
        b=iGDAipxHmpQV0+HzqznfMziwFMMMino5CRHFXKSC8yUA1wdpbEKO050adHliTubgjt
         JIQqoNUb3vWUidkyBwe1gC4wAd4mf5GjeXSZvBijbYdmUH3nz0bpNzHHmkIOUb7iCO2I
         aavAejRFw8Vn6NaLJ4EY9C4Noy8bmGvlKsbuRfytHjBN5FcbtOnEP83w2ij3BLDayRWj
         pwkZRtIB+SbXBMfcnZd0jX3mGDpcEdo7zaI6mzeH77VPzjxCY3hkucHmaIvQjO2uH7v7
         zyM2LbE9g0dPMoACEK4tbf/iR6M8dnFXgPYe0HmkgdkQ9o1k2QAQt1aYZgNDzGSTuory
         R2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789931761; x=1790536561;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRHHzZuzTFHdeZZCwVQrfnnYfoUZ+O10/vzVIYuQB8s=;
        b=f3r4G5bcoq1uRxRAcXB9rQwPO82XKHvp/Ca2MNL4Uh23pUvRpWYdLu4AZVnRDvJLTo
         GGjourkv8leW4rMqffai6N/8Rze6B06HXboffdeEHptKZiP72+prCdLZxU4/e4y5ptks
         Lv9/sNGfyQfXaSID2xDz8+au1JMcLFGMVUaSErj8BETsT0obVFHk6Bx5Tb2nv93VbysZ
         xsdD5S0Rj7xqwEQHdnUMshbDGkK5M+PWBzko9GPMffpHgjdnq59b/AWdbdJPVSOV28wY
         cEazYIP6MlRsLcwTxudX6W5SRfvRKFGdGJBL59vo3rxiEjjQtcn36pZ2ymc3iwBNzmOO
         +oRw==
X-Forwarded-Encrypted: i=1; AKwUvBwNgXhbVFI2j1pKyRcCODwIOHmrMxRaHDG83AWcTuS0KuJNqSC6MEoR89pOpdCCsfIOzjFWbrw=@vger.kernel.org
X-Gm-Message-State: AFuF++l2g40CL894G0SWRGbLNGXIugokByFbvY6hs+dxeBrZb3qP43Nz
	kuhkuKJbY9xwKzF9t07E1XcUXJiUAwZe+nfXpO+i0Wa+ROAEOpUU5fQCshYBkz+86BRImEKOJMF
	wlJYpUw==
X-Received: from pfblr25.prod.google.com ([2002:a05:6a00:7399:b0:851:8e56:35d3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1588:b0:878:34b8:232a
 with SMTP id d2e1a72fcca58-87834b8255emr4362395b3a.50.1789931760809; Sun, 20
 Sep 2026 12:16:00 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:14:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920191558.2990636-1-kuniyu@google.com>
Subject: [PATCH v2 net] ipv6: Fix dst leak for uncached routes.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Hangbin Liu <liuhangbin@kylinos.cn>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
detect an uncached route by list_empty(&rt->dst.rt_uncached),
which replaced the static DST_NOCACHE flag check in commit
a4c2fd7f7891 ("net: remove DST_NOCACHE flag").

When a device is unregistered, rt6_uncached_list_flush_dev()
unlinks uncached routes tied to the device from rt6_uncached_list.

Previously, they were moved to another list with list_move()
(__list_del_entry() + list_add()), and since commit 98aa546af5e4
("inet: remove (struct uncached_list)->quarantine"), the routes
are just unlinked with list_del_init().

If list_del_init() runs concurrently, list_empty() evaluates to
true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
dev tied via rt->from as well.

The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
fix races in rt6_uncached_list_del() and rt_del_uncached_list()").

Let's check rt6->dst.rt_uncached_list instead.

Note that IPv4 does not have the same issue.

Fixes: 98aa546af5e4 ("inet: remove (struct uncached_list)->quarantine")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
v2: Add a comment, update stale comments, correct Fixes: tag
v1: https://lore.kernel.org/netdev/20260918041439.2575935-1-kuniyu@google.com/
---
 include/net/ip6_route.h | 4 ++--
 net/ipv6/route.c        | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index b9e8d2b759e9..0f9b7a260d25 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -101,12 +101,12 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 }
 
 /* Only conditionally release dst if flags indicates
- * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
+ * !RT6_LOOKUP_F_DST_NOREF or dst is uncached.
  */
 static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
 {
 	if (!(flags & RT6_LOOKUP_F_DST_NOREF) ||
-	    !list_empty(&rt->dst.rt_uncached))
+	    rt->dst.rt_uncached_list)
 		ip6_rt_put(rt);
 }
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 08bd68f1b5bb..70d643336610 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -139,6 +139,7 @@ void rt6_uncached_list_add(struct rt6_info *rt)
 {
 	struct uncached_list *ul = raw_cpu_ptr(&rt6_uncached_list);
 
+	/* Set once and never cleared: non-NULL marks an uncached route. */
 	rt->dst.rt_uncached_list = ul;
 
 	spin_lock_bh(&ul->lock);
@@ -2721,8 +2722,8 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 	rcu_read_lock();
 	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
 	rt6 = dst_rt6_info(dst);
-	/* For dst cached in uncached_list, refcnt is already taken. */
-	if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
+	/* For an uncached dst, refcnt is already taken. */
+	if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
 		dst = &net->ipv6.ip6_null_entry->dst;
 		dst_hold(dst);
 	}
@@ -2831,7 +2832,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 	from = rcu_dereference(rt->from);
 
 	if (from && (rt->rt6i_flags & RTF_PCPU ||
-	    unlikely(!list_empty(&rt->dst.rt_uncached))))
+	    unlikely(rt->dst.rt_uncached_list)))
 		dst_ret = rt6_dst_from_check(rt, from, cookie);
 	else
 		dst_ret = rt6_check(rt, from, cookie);
-- 
2.55.0.1082.g2b9226bbc0-goog

