Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B74C0424
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798613; cv=none; b=jI6QvUcEb5mwU34K86FQA0t8RmbJUQTQshRW9cZtbEtyteX9kovggdKMXq6dGm+qDAFkG9zTnT4pweChHltbf5HqYOY697qNUqSi/gxU27lJ4LKYupbD7owRTpbEmEYngUjsv8ZIaCGdfRqWo/Dh/9u1It9jvIiP6e7gAtRf2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798613; c=relaxed/simple;
	bh=ThoT7cXfDyyrpjdI4GGUDFw/EtThazkBFBTRFFAW/OI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IKz8Mkao1yEw/l7MlhgR/OgQMzs38P3af6mocHKCXevmO5WaigAZwqSzfnO26PzhRBT9ncAIzK8HV8rtMdsLt9JXztgtbyvlyFdDCn4YD08BHUMCbhTso+g/iYytwM0NkmUyJkrDRrgxnUAXEjojW9xukKNMxC5hX0xQq6BS9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNzHpKKv; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNzHpKKv"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e2d3a3ff86so23552345ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798611; x=1791403411; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0OjECR4PbKu7DNQWWCoLM1tH92ztwNdu/t4kIPA7nQ=;
        b=hNzHpKKvvda0Av3H06YRJKppgoYc56JHACByHVUygVig6uLwLVSuToFyrOYismFn0E
         MrsPg29wZgKqoR8w2dIjYBpTIwUADmCtRVhpYCSabkmdeqV9hX1a74wrIXlSZXDN7HMw
         eWthRNAj4ugaw1+SdbC4dZUWWvPWa6GbS6S59IsCj/lyeX7MdBTvH42q96fNosya0ZkB
         8POzv/ZkWBT2j/cCcc/EIS9ur943u3AXwrIIagqk4MBuR5xF7GV1bdaNpkq7LCxg0WxY
         eFna8FHK7YNkvWvfnaMtHQcj7wG0/n+n6W6UCOq7pB7CMmxnocguQieehgEXMGN4UH2M
         df1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798611; x=1791403411;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0OjECR4PbKu7DNQWWCoLM1tH92ztwNdu/t4kIPA7nQ=;
        b=yBjK/7uekwukm1eqKo0shwQmGJ9Qy04UGgPDHOa4PuHwKvo3ww3KVwQzF0Wv/2OLof
         WR2ATATCIqXv2cPzjr8Qr6G3A9uo/gP07RZ3mDxFqoHrHzw1ZSk9+VCyCVm0Fdk8oRTz
         yDEg47B6JoUpO4/h3srkTdrvtlesr5CwqBnsE0RmYmRLxyvqzBa2/J3bgBPqs3IU7khE
         S4MFxWYnr1bBbGXGJ1jcXTVHNdmr9y1bSt9ULSp35YP9vie2RkpyJ8PpH1tAab3giFHH
         1zQTpC1mWZamwrPB9sgYFuZ/OWcEc1+J32iwtFgB3LomZLgpopfocwooKKCx1Y03ah3M
         bYVQ==
X-Forwarded-Encrypted: i=1; AKwUvByVYkeRymk/Env+VzPueXwdvscgn6nozPMaUcoXBCZWXoVyNTnvQDM8qivWvOvK3LjFQX1aFv8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvMr9hta1S88KaNkV+tr7FJ4qw9awR7pMyMQXyEGMl4ZdctzEU
	nYMR2Kvt0J8eDvzIPUoDex5rw8y2w4YSwi7D7XFFahIS24ek49MF37tuTA/jdAHEfHlD7G7XZoN
	t9u/CrA==
X-Received: from ples3.prod.google.com ([2002:a17:903:2143:b0:2e2:f303:e8cf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54b:b0:2dd:c053:d73e
 with SMTP id d9443c01a7336-2e2e4bbe928mr20672765ad.37.1790798610628; Wed, 30
 Sep 2026 13:03:30 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:09 +0000
In-Reply-To: <20260930200326.718459-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930200326.718459-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930200326.718459-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/8] ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Later, we will add ipv4_neigh_lookup() as a wrapper for
neigh_lookup(arp_table(net), ...).

The existing ipv4_neigh_lookup() is more like ip6_dst_neigh_lookup().

Let's rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/route.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7da2f1acbb5..50c842617e45 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -146,9 +146,9 @@ static u32 *ipv4_cow_metrics(struct dst_entry *dst, unsigned long old)
 	return NULL;
 }
 
-static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
-					   struct sk_buff *skb,
-					   const void *daddr);
+static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
+					       struct sk_buff *skb,
+					       const void *daddr);
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr);
 
 static struct dst_ops ipv4_dst_ops = {
@@ -163,7 +163,7 @@ static struct dst_ops ipv4_dst_ops = {
 	.update_pmtu =		ip_rt_update_pmtu,
 	.redirect =		ip_do_redirect,
 	.local_out =		__ip_local_out,
-	.neigh_lookup =		ipv4_neigh_lookup,
+	.neigh_lookup =		ipv4_dst_neigh_lookup,
 	.confirm_neigh =	ipv4_confirm_neigh,
 };
 
@@ -409,9 +409,9 @@ void rt_cache_flush(struct net *net)
 	rt_genid_bump_ipv4(net);
 }
 
-static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
-					   struct sk_buff *skb,
-					   const void *daddr)
+static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
+					       struct sk_buff *skb,
+					       const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
 	struct net_device *dev;
@@ -2910,7 +2910,7 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 static struct dst_ops ipv4_dst_blackhole_ops = {
 	.family			= AF_INET,
 	.default_advmss		= ipv4_default_advmss,
-	.neigh_lookup		= ipv4_neigh_lookup,
+	.neigh_lookup		= ipv4_dst_neigh_lookup,
 	.check			= dst_blackhole_check,
 	.cow_metrics		= dst_blackhole_cow_metrics,
 	.update_pmtu		= dst_blackhole_update_pmtu,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

