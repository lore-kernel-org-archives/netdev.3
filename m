Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D225393E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687580; cv=none; b=Sj7QyBJR9ZvJ/331ds2o4jw9Phppk0yCKGiPIy+NNQTePtFIECjI9C2fUSHkLzNRdrVqsLaErVSbP/ScHO2ANI57mT5f7UmJghdCo5x/d13g3jCzv8+DrU86AxC7IQEaN7/dPlOhB8U091s0vT5kcNMrUvuQMdHa/DYAKPGBwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687580; c=relaxed/simple;
	bh=Yc7n2P2qKrHLnqVQrNBeix/WuLEEarGPEJ2J2SM0g5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lX5C4r9OJQHPSfgvNlos6nlWDojJ420D5Mp0jOXW7X7EWrop/eLpFu9WsdfSOcryBkzJu9/MqjRxwRWqv3OxO4vFjUQT6uUbDUbt8sEd28hSppeT/ZAF7rN2xzRmCC3JZfifeFSKnmDE5BOI/kmrnpWAdk5bYOMgdTkvLCZozaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EP9eFYOI; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EP9eFYOI"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90a602a4e6fso13854966d6.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786687577; x=1787292377; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lz/uKF81Fnnhkx7FACFUp/bRSOPE7rVZftNIntm36gQ=;
        b=EP9eFYOIqrvHy/3R21TAAwf8W+xNVYcI10a6bVJfqox+VQIIgJBr80DeTLGJt31mq4
         /FhfBSWu/gNgEZLicolRfFXGEUMXFPE/aDf+bhWo3ishslxBrpxIPActQJjmNKN3Uy7X
         evv9pYBAnhCidJ8iy5xeWEqu9Wa+UNMFnR1/hoelx/Fu59EOn+dvggQqR6ZE12JrYHX3
         2cWVy4MMR/r5zSbs8eKa2MxxI39ZHjde42SGWE+l9MNlNcso8myaQYr/G6Ljb5ND9Gyu
         QlKeVK0ug/jXx4OCcz8epWGX1KwMum39PQeZCsX0Ye36c/ASci5KHldxK6OmkaqmwCVk
         qWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786687577; x=1787292377;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lz/uKF81Fnnhkx7FACFUp/bRSOPE7rVZftNIntm36gQ=;
        b=szfXG0zMd8XQONlQe1Cdm14iH0ZCaep+EWHLSaEOnzclJMVu1se6Y2N+UfRPDovZbH
         71VUFUFKIUKrnbQdFp0a23zotEXkvVFNOAvuTuQXQsIY7wJlDIPx5sR/41z5TObFboJD
         gdEL30m5QV/+62CTGPUh6lk2kulTusJ/G+t45CcDwGtWV2H7YLiQS2ZBOQu0ya6lead9
         c5+51/rLaMMIbv8dCoSznITzDV5t6HWALpNkglZzn/gaNHBj3wj5MsHsvmeSQnjOcyCB
         /H5t9KKgm8ueLZe4VIesTOscl6posD4ksJ0jLcznjZSSoqCHL0buj/+44cHR4Y47mAEX
         juYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6CgqtzqtlSi0+VA1XZWfqUeLC7PIiPGEmYaPrpDMHI33F0hMZftMX6qFhKYVn9qClg+hGNx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgem6FXp/wHkNBDhMu9R6Fx7Vvcxi9XyzAiXCF/cqAfoc0W/Ub
	9nfKM3Kehc8MxbWFd33ZmrW5Q+gCjbJEtZbEY1gC6AJUfNOXB1LvN/5ibrEUk4eDXQDzJviXz4E
	fRDb+z1aLgLmPxA==
X-Received: from qvnz14.prod.google.com ([2002:a0c:e98e:0:b0:907:47c0:1c58])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ce7:0:b0:8ee:b2ab:d1ab with SMTP id 6a1803df08f44-90a91d18745mr33881456d6.9.1786687576938;
 Thu, 13 Aug 2026 23:06:16 -0700 (PDT)
Date: Fri, 14 Aug 2026 06:06:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260814060616.2164504-1-edumazet@google.com>
Subject: [PATCH v2 net] inetpeer: randomize RB-tree node comparison using SipHash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Michael Blunt <michaelbblunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The inetpeer rate limiting system stores peer entries in a Red-Black tree
keyed deterministically on the remote IP address. Because tree lookups walk
the RB-tree using standard lexicographical comparisons (inetpeer_addr_cmp),
an off-path adversary can predict the exact topology of the tree and the
sequence of nodes traversed during lookups (the gc_stack candidate list).

By combining deterministic tree traversal with aggressive garbage collection
(triggered when tree size exceeds inet_peer_threshold), an attacker can
selectively force the eviction of targeted inet_peer nodes. When an evicted
node is subsequently re-created upon receiving a new packet, its rate-limiting
token bucket (rate_tokens, rate_last) is reset to full capacity. This creates
a side-channel primitive allowing off-path attackers to bypass IP-keyed ICMP
rate limits and infer open UDP ports (similar to SAD DNS style attacks).

Mitigate this by randomizing the RB-tree node comparison logic using SipHash
with a secret key (inetpeer_hash_key) initialized via net_get_random_once().
Nodes are ordered in the tree by SipHash(addr, key) rather than raw IP
addresses. Because the secret key is unknown to external entities, the tree
layout and lookup traversal paths are unpredictable to off-path adversaries,
breaking the deterministic eviction gadget.

Cache the computed 64-bit SipHash (hash) in struct inet_peer and compute the
target hash (dhash) once at the beginning of inet_getpeer() to avoid recomputing
SipHash at every step of the RB-tree walk.

Fixes: b145425f269a ("inetpeer: remove AVL implementation in favor of RB tree")
Reported-by: Michael Blunt <michaelbblunt@gmail.com>
Suggested-by: Michael Blunt <michaelbblunt@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: addressed sashiko's feedback
v1: https://lore.kernel.org/netdev/20260812205946.356185-3-edumazet@google.com/

 include/net/inetpeer.h |  4 ++++
 net/ipv4/inetpeer.c    | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/net/inetpeer.h b/include/net/inetpeer.h
index f475757daafba998a10c815d0178c98d2bf1ae43..414e9adf4c51145f14313993f04d1f47c0aaa07d 100644
--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -35,6 +35,7 @@ struct inetpeer_addr {
 
 struct inet_peer {
 	struct rb_node		rb_node;
+	u64			hash;
 	struct inetpeer_addr	daddr;
 
 	u32			metrics[RTAX_MAX];
@@ -125,6 +126,9 @@ static inline int inetpeer_addr_cmp(const struct inetpeer_addr *a,
 {
 	int i, n;
 
+	if (a->family != b->family)
+		return a->family < b->family ? -1 : 1;
+
 	if (a->family == AF_INET)
 		n = sizeof(a->a4) / sizeof(u32);
 	else
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 1e2bd1c522326c9ba14c3ceeb8e934f703b827a5..761a1dddc778ed774d5ce2dbf6190c67fe33c1a5 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -21,6 +21,7 @@
 #include <net/ip.h>
 #include <net/inetpeer.h>
 #include <net/secure_seq.h>
+#include <linux/siphash.h>
 
 /*
  *  Theory of operations.
@@ -52,6 +53,34 @@
  */
 
 static struct kmem_cache *peer_cachep __ro_after_init;
+static siphash_aligned_key_t inetpeer_hash_key __read_mostly;
+
+static u64 inetpeer_addr_hash(const struct inetpeer_addr *a)
+{
+	net_get_random_once(&inetpeer_hash_key, sizeof(inetpeer_hash_key));
+
+	if (a->family == AF_INET)
+		return siphash_2u32((__force u32)a->a4.addr, a->a4.vif,
+				    &inetpeer_hash_key);
+
+	return siphash_4u32((__force u32)a->a6.s6_addr32[0],
+			    (__force u32)a->a6.s6_addr32[1],
+			    (__force u32)a->a6.s6_addr32[2],
+			    (__force u32)a->a6.s6_addr32[3],
+			    &inetpeer_hash_key);
+}
+
+static int inetpeer_entry_cmp(u64 dhash,
+			      const struct inetpeer_addr *daddr,
+			      const struct inet_peer *p)
+{
+	if (dhash < p->hash)
+		return -1;
+	if (dhash > p->hash)
+		return 1;
+
+	return inetpeer_addr_cmp(daddr, &p->daddr);
+}
 
 void inet_peer_base_init(struct inet_peer_base *bp)
 {
@@ -84,6 +113,7 @@ void __init inet_initpeers(void)
 
 /* Called with rcu_read_lock() or base->lock held */
 static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
+				u64 dhash,
 				struct inet_peer_base *base,
 				unsigned int seq,
 				struct inet_peer *gc_stack[],
@@ -105,7 +135,7 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 			break;
 		parent = next;
 		p = rb_entry(parent, struct inet_peer, rb_node);
-		cmp = inetpeer_addr_cmp(daddr, &p->daddr);
+		cmp = inetpeer_entry_cmp(dhash, daddr, p);
 		if (cmp == 0) {
 			now = jiffies;
 			if (READ_ONCE(p->dtime) != now)
@@ -170,6 +200,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 			       const struct inetpeer_addr *daddr)
 {
 	struct inet_peer *p, *gc_stack[PEER_MAX_GC];
+	u64 dhash = inetpeer_addr_hash(daddr);
 	struct rb_node **pp, *parent;
 	unsigned int gc_cnt, seq;
 
@@ -177,7 +208,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	 * Because of a concurrent writer, we might not find an existing entry.
 	 */
 	seq = read_seqbegin(&base->lock);
-	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
+	p = lookup(daddr, dhash, base, seq, NULL, &gc_cnt, &parent, &pp);
 
 	/* Make sure tree was not modified during our lookup. */
 	if (p && !read_seqretry(&base->lock, seq))
@@ -190,12 +221,13 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	write_seqlock_bh(&base->lock);
 
 	gc_cnt = 0;
-	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
+	p = lookup(daddr, dhash, base, seq, gc_stack, &gc_cnt, &parent, &pp);
 	if (!p) {
 		if ((u64)base->total < 2ULL * READ_ONCE(inet_peer_threshold))
 			p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
+			p->hash = dhash;
 			p->dtime = (__u32)jiffies;
 			refcount_set(&p->refcnt, 1);
 			atomic_set(&p->rid, 0);
-- 
2.55.0.699.gb54405d56f-goog

