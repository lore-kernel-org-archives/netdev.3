Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC130566B
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704887; cv=none; b=cykPzAxpZaPFgvk3/n2zCytfnZwz0HFFPT8t4h0nVvzy/LWwKA1Syh7/sGIRFnOlzlzZycxBcfea+qWdndBEkmgoKm2kjesLtBwypA1oG5mLAkO0tMv5NYh3Yy+Xeg2qtP+Xkn2RDGyKTO2/OVFbRm8/7C2RIZFbxNM3fxXXvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704887; c=relaxed/simple;
	bh=FSarEM8iQQ8keW9NPGo+8hqEox6qxyQvzQPoAKUWMgo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nbOl4G241sIGipQMnCvYLsjCQn8jMQtfmdDDjnfQEGQGqmfBAu3iXPYfYDsO4ovKEv6T3Mgt7UbX5e//4nFU1RvJLEWg/3dHdojr8c+k2NHfRaSXKna1rFHXuICnyqRcaOrsPlwvWna2D4g2xOO6N8yfyVQZqTjuqzSdiOPfgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOQOMWSp; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOQOMWSp"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86261e66700so374246b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789704886; x=1790309686; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e16S4AiXInegGd5qXubRPt3W8kfZfXuxeZ1bG9Fw0OI=;
        b=nOQOMWSpp1QRFlmF3VsrN7fl/CQoY9pYuCvQTtP+7EZrwtNBp30VxRXvFvRxhtV6vi
         ss2JLnts8/dJ/o/CsaoqC11gncMjdOVR1YnI5ghcipaQWUsDAW01bE4MYP841e6vYz9/
         NrUBW30hh7qQtXoQ/jtQyX5o3K9shgGWm3FEZtMSmOGvL2j0s/e5iQxTwbpEpoOA3QsO
         8kqY7w1Xwxrec6lFJIOZ7UGqbulQW3A7SkZAELaB814t0W12tljuPTvT1JAlodJjI00w
         EUx5RjTNcjqLBTdl6Suil748u49LnQ9lmqFhc9yfszMJlKjwH+lyVKMlNpgqx+2y5aU/
         hWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704886; x=1790309686;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e16S4AiXInegGd5qXubRPt3W8kfZfXuxeZ1bG9Fw0OI=;
        b=d6ldA9eW4FllL7CTUvF5r6xPnbshpjlPy75pPcKJr1a+IH5mgpI2b2bX8QGXTs6RiM
         0Ht37bO4vtULvQDPvqbnj7tJpyB00n7OcDNKb2iJ5nX0vaH+tx18oPEATwUuxNe5BIsZ
         qz4Hq8ybO8Zdov9iT9pKGeOvR3PrPeXviRYaxJpeNcl3I53TFmRNyWOw/ThEG9qV/BkA
         RlFonr798PHJkX+LsaDr9R/gkcpcSbbY93gnWpEvujN0yLfjsGO9vXrARmXM36fHPRgk
         AdDKNkLEAMlQ4lA8TJi5+Hf0W9XJwOfFc35O4Df5S7JSZ6vipTuleeuAaav29MOnItSt
         IEcA==
X-Forwarded-Encrypted: i=1; AKwUvBxJDS7PLbOAx6bJO+r0YMCc0PQJJHatbpVLc1Y8l5PE+1DVOUerpNGHVbd6GWj98fQvFT3gXrw=@vger.kernel.org
X-Gm-Message-State: AFuF++lrEnZ0gBdBy0RtssZMEH6IBq6ZA+i4eyaSy1fHo+EgTrmxAFEF
	G9lRdNGVUmaZacq5opEO8QK9g8siv2o7Hogza/FKEl5bnFK2eA4/ceFWE+XfGwski0YB9iHZlqc
	jZ34xPg==
X-Received: from pgei10.prod.google.com ([2002:a05:6a02:526a:b0:cc4:3178:f54f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4403:b0:872:cadc:bdf2
 with SMTP id d2e1a72fcca58-874dc1f7ad3mr2547743b3a.14.1789704885597; Thu, 17
 Sep 2026 21:14:45 -0700 (PDT)
Date: Fri, 18 Sep 2026 04:14:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918041439.2575935-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv6: Fix dst leak for uncached routes.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>, 
	Marc Harvey <marcharvey@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
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

Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_DST_NOREF")
Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic")
Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip6_route.h | 2 +-
 net/ipv6/route.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index b9e8d2b759e9..2c5ded121f54 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -106,7 +106,7 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
 static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
 {
 	if (!(flags & RT6_LOOKUP_F_DST_NOREF) ||
-	    !list_empty(&rt->dst.rt_uncached))
+	    rt->dst.rt_uncached_list)
 		ip6_rt_put(rt);
 }
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 08bd68f1b5bb..b18cd0d9148c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2722,7 +2722,7 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
 	rt6 = dst_rt6_info(dst);
 	/* For dst cached in uncached_list, refcnt is already taken. */
-	if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
+	if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
 		dst = &net->ipv6.ip6_null_entry->dst;
 		dst_hold(dst);
 	}
@@ -2831,7 +2831,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 	from = rcu_dereference(rt->from);
 
 	if (from && (rt->rt6i_flags & RTF_PCPU ||
-	    unlikely(!list_empty(&rt->dst.rt_uncached))))
+	    unlikely(rt->dst.rt_uncached_list)))
 		dst_ret = rt6_dst_from_check(rt, from, cookie);
 	else
 		dst_ret = rt6_check(rt, from, cookie);
-- 
2.55.0.1082.g2b9226bbc0-goog

