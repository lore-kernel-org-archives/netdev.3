Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0B494A10
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062627; cv=none; b=F6ZGEFJigS58cqym+1/PYq7joFnuo/XuG05K7Ijc93eHmh5Ze5ob7M4FKI7/XEc/Kn+4vJIrLoLLd4oya6XAFnQtvI3C41HWh70X+WjWhU/lw2QLC70L2DJnZnk3ygAXNSHghCFj7Q6bqEiZ4YkUwk+TorIOeacgJ5zZ18hbWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062627; c=relaxed/simple;
	bh=YFzOIl4HWghWMp2lAQuk1H58PtPzCNfCXIS+NpdkBZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DHGgXzfPCR+CixsTswig0U71Bq48gwtiTdYQ1lFSFDFAVusrLtrX6AcIbmnKlDGqjYi6pmadV6CUjzs9teIVxEZ5wOq8D0Fbxz5GTcdIde9kQbC9g64bK2mzYHhMdLpm6P5W7LsiBWt4nYOkzo1xhw37I5EHCzT+MJCYdHffmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDTv+wHq; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDTv+wHq"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso583240a91.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062626; x=1791667426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wiOikGFamsRkgS9kwvuByl1mO8zUgVaffR3/L5ESCuU=;
        b=XDTv+wHqjK1nGeQklGzNZc1tNmmuLMCD/QG9md+y8nIJWj+DNX3xSOBrqauWJypu8F
         95B/7LlMBSX1Q50aukwzIhV/2u9PBsDqg5WaZ/uYXoE97sSs8Cv/hepGTSSwA2EWrnTB
         wSrZmUc6etZCghE789FhpS8Agtq+DgcxcFS//KFsUNpx7KqenhzKwwdKCZSANiwWUnT9
         vpuXDxVpzjqH/xKF0KGJ7yg/s+IK4kg++xVqbpKfv/fg+vf9C3GLEOw/krsYjqLHShLc
         leV2JKJ5Tdq+OZ0yk2IsQDJxSGCgYqD2pQVqFUwmjj+4JmKOhKoIfnYkyH6ojSiFPm/G
         ZvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062626; x=1791667426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiOikGFamsRkgS9kwvuByl1mO8zUgVaffR3/L5ESCuU=;
        b=iPEUdwvjZTGRnmwfdEi3CdLTkloPWnVIXD4px8uJKZ5d++6Ug98Hno6dWtHYivbau6
         B5JHxqxE6LBSx6ItwEBoXBYwznjggi1JIWzmPpR2E8ALTZAkk7ru8zSDmaezLfKu18UG
         O7H8M6CcodJiYW9lHyezZVz9sMCfmSVc2ztW6pIf9IgaWba/LVu3Z0wuA394Cefc3KJv
         oNGwprpATtd5xtJRU66OAViPDyc6aphKpWxYJLlSN2FdGuy7s2gtobQ3TOvjHmL1nX1R
         izj4BRP9X7x/KP12uSXAsKC8Z602tqjdTgg0kpaXTjuZO1WU1eFHllpo3iPsgHjDjFNV
         Q11g==
X-Forwarded-Encrypted: i=1; AKwUvBzXf2SarNBr/IOcos/aLkzUerETNXyOKiSZsgngFu1A6rE+UOXUyL1SmrEqrXlhI0M1v7mBuPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJJPY3/T/S59OvDQyTeXa/KDD8DJwyZsi1zcmjGfbwjJTrif17
	Il7QlTmg249sGF4uMKqtXyRiL3K3MGcHs+bRC87p7ZrQ2j3ZRcxVkHG1If+zFPbPsuWQ4z1L7oQ
	sIwirng==
X-Received: from pghc19.prod.google.com ([2002:a63:da13:0:b0:cc7:d704:8c90])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54c6:b0:3a4:9416:a2f8
 with SMTP id 98e67ed59e1d1-3a4f32d90c9mr6958962a91.9.1791062625378; Sat, 03
 Oct 2026 14:23:45 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:15 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/9] ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
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

