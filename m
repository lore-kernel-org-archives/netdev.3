Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841484C150B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798614; cv=none; b=HDOWLd9Ln13HSVdFbJlg34PKkZOhMc9V87FjZOGJMK90YD53Bqx8a9bCEdXIEyKC5LW/bCDZaVvUyx1odbqeAPQ1pB5qwb+TvxtnLqRr1g0hN2k590Z1dlcRPAuCBnhq2RFgvzORN1wKAoO0S5JEubgnbOifOuFMY6VL8gsdMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798614; c=relaxed/simple;
	bh=YFzOIl4HWghWMp2lAQuk1H58PtPzCNfCXIS+NpdkBZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jXslsIWGhuow5aqlQn4MK17BdUYGmOhc7VHN9RZAtqz5UwZBqCvHrimaaIMQwAlIQVLtVBqcSEOsSNrn39O/xRR0i44szwVCASNm+HXhCFHDlJ5Iodnbt7zv/ztnYZSX5IFX4zyYgJqh0iT99v8J6RNF7uITRTG/a8lJDLSuE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wB78YDCN; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wB78YDCN"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df7bc60df6so44474275ad.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798612; x=1791403412; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wiOikGFamsRkgS9kwvuByl1mO8zUgVaffR3/L5ESCuU=;
        b=wB78YDCNn4pnMKtrWLK2hy+1PUSEld2Fjz+wwHLH5van8hIJ6wqBdneI001pgg0eI4
         iCmJuEQdCQksw5udSlsMavlyI2BLQe313Ss/xFSALzKuj3V2r9dZcPWwknUwB8MnS7Rl
         POZ1MIqRYo3dUHVeEuhKI+RUmQjzD0zap29kagfy/mEG/eTj9SYhYfI/8KWXXXFHtV8l
         O2tubJP/QAComZcF5/ujQGjT6I77UT11ga11xG6AAYTHDmf07wN/FSqGQFIg2PJnw8Bn
         5i10kH/BkoSRV2UjBPMfuSBZarugPm//5T8G9Er/VCHerNMdXMv7UcEFTtNI8ifxJUde
         AUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798612; x=1791403412;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiOikGFamsRkgS9kwvuByl1mO8zUgVaffR3/L5ESCuU=;
        b=zOS8YMMVIfILQPxYLv5qMU3ZIwlWSCaEVKBoKLdBfd92U2Y2O1cfTmtrOiYfLR3XrJ
         bix8n4WdPsbAMFdJLGmwjSvrz/HWRk9JVyYjnfQp8QLd4lZ5qkWIavxtZh6PWlBW2Jrz
         7aZcqsTq273BDak3CzzHg8nnzG6meDUTIgdFBPQ1cUDhGP+ucToiQ0DDp4Lwwh5G7FFW
         VfXTTLifXSEZGz46RAUKHHoEFNZ8m51r+rJT0gDgASAInVyWXi/V6El0QH2AE9aWJ6C5
         WUvzxGxlGGZv0xlZSpXnZBoCSm1fvTQyAbmiwuh7QZoEIHY2NEmCF65uBXe6dLfMrZo0
         howw==
X-Forwarded-Encrypted: i=1; AKwUvBytDpiIyCcWflvUJ1FzCuIjEQdCbBalhjPC3ve+PV5ubbtbXBvnVuErJedhI0dFB6vI35yc7W0=@vger.kernel.org
X-Gm-Message-State: AFuF++l6LqUnY3IJDllvmXjdE00baKBYx3z2rS/+wWdTeBf1nu+FiHdc
	hLTr031vGt488bcUQLjr2XWjENB7KfJflXwHTdzZO9bZ47TtIE4QtYGKCbdbzMMY89GOkfvkMPs
	qUSFzfA==
X-Received: from plaw12.prod.google.com ([2002:a17:902:c78c:b0:2e2:ed24:d1d4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c2:b0:2df:9eb0:760d
 with SMTP id d9443c01a7336-2e2e4c13f6amr20678625ad.61.1790798611447; Wed, 30
 Sep 2026 13:03:31 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:10 +0000
In-Reply-To: <20260930200326.718459-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930200326.718459-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930200326.718459-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/8] ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Later, we will add ipv6_neigh_lookup() as a wrapper for
neigh_lookup(nd_table(net), ...).

The existing ip6_neigh_lookup() is called from ip6_dst_neigh_lookup()
with a gateway address.

Let's rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip6_route.h |  6 +++---
 net/ipv6/ndisc.c        | 12 ++++++------
 net/ipv6/route.c        | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 0f9b7a260d25..5a21ed4b6e1c 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -430,7 +430,7 @@ u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 		      const struct in6_addr *daddr,
 		      const struct in6_addr *saddr);
 
-struct neighbour *ip6_neigh_lookup(const struct in6_addr *gw,
-				   struct net_device *dev, struct sk_buff *skb,
-				   const void *daddr);
+struct neighbour *__ip6_dst_neigh_lookup(const struct in6_addr *gw,
+					 struct net_device *dev, struct sk_buff *skb,
+					 const void *daddr);
 #endif
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 12d85d7f8234..e1cbffaa0ad0 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1359,9 +1359,9 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	/* routes added from RAs do not use nexthop objects */
 	rt = rt6_get_dflt_router(net, &ipv6_hdr(skb)->saddr, skb->dev);
 	if (rt) {
-		neigh = ip6_neigh_lookup(&rt->fib6_nh->fib_nh_gw6,
-					 rt->fib6_nh->fib_nh_dev, NULL,
-					  &ipv6_hdr(skb)->saddr);
+		neigh = __ip6_dst_neigh_lookup(&rt->fib6_nh->fib_nh_gw6,
+					       rt->fib6_nh->fib_nh_dev, NULL,
+					       &ipv6_hdr(skb)->saddr);
 		if (!neigh) {
 			net_err_ratelimited("RA: %s got default router without neighbour\n",
 					    __func__);
@@ -1395,9 +1395,9 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 			return reason;
 		}
 
-		neigh = ip6_neigh_lookup(&rt->fib6_nh->fib_nh_gw6,
-					 rt->fib6_nh->fib_nh_dev, NULL,
-					  &ipv6_hdr(skb)->saddr);
+		neigh = __ip6_dst_neigh_lookup(&rt->fib6_nh->fib_nh_gw6,
+					       rt->fib6_nh->fib_nh_dev, NULL,
+					       &ipv6_hdr(skb)->saddr);
 		if (!neigh) {
 			net_err_ratelimited("RA: %s got default router without neighbour\n",
 					    __func__);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a76869ff87cd..8baac4d85251 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -206,10 +206,10 @@ static inline const void *choose_neigh_daddr(const struct in6_addr *p,
 	return daddr;
 }
 
-struct neighbour *ip6_neigh_lookup(const struct in6_addr *gw,
-				   struct net_device *dev,
-				   struct sk_buff *skb,
-				   const void *daddr)
+struct neighbour *__ip6_dst_neigh_lookup(const struct in6_addr *gw,
+					 struct net_device *dev,
+					 struct sk_buff *skb,
+					 const void *daddr)
 {
 	struct neighbour *n;
 
@@ -228,8 +228,8 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
 {
 	const struct rt6_info *rt = dst_rt6_info(dst);
 
-	return ip6_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
-				dst_dev(dst), skb, daddr);
+	return __ip6_dst_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
+				      dst_dev(dst), skb, daddr);
 }
 
 static void ip6_confirm_neigh(const struct dst_entry *dst, const void *daddr)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

