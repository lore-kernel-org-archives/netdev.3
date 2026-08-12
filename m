Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A53DFC8C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568395; cv=none; b=reag2aqVD4mZ0jfCu7e4wun1kuz5o+D0BtHWdverm7xgqUJBbt2NbcpRLQzts4Ux1jQx2MbWqxymDNEVJoQdeD6d3hVM+dj7dY1hlMdfaUA9oL49lVNtILeZmeCV6jaRySE2UDVsYYKXvl43al2c5Od6ZT+UNEPmvU//QaZeMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568395; c=relaxed/simple;
	bh=OzfZjMVOkGq6Y+O/q04kJQa3QIlqvCyVRV1mtRMj3l4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WhYvSCUuIOqD7rqGMhnxB2CT3FWvL2/zNwnW3Om4CHTX5xISJA0uZ2Gc9gUkFnPDU5LQmKbVnf99oE0ZGS6pJKUVHQ/7lA/y8dHVYuKPoVDkJamByOMxHCXBVUYzeLp7dLPO4hhJjKjZ0npQenbGRtzXxfbLgVdhn6GCw90ZzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vt57oSIx; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt57oSIx"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930b6bdcb4fso4765485a.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786568392; x=1787173192; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fHbXxuxlXqPkA+YdmnZqC7r5vbuh2GdoYZFVe/EIOnM=;
        b=vt57oSIxuy9HeNr3EMjjAYnBp9RVzERLQGgMkjTzCPQ3pjeWyfzPbj/ik3LYkAaepB
         gpDGweyTEyz1h7IexuzPPVuSu5e8fVok+VFUEPf9Xsgx7CpYAl3gex8hRoO8KGRMKkFm
         GsItncj9GzsUlVC1J/n5z1O1UMvgqdm2FYKZhTBKd5QQEv2c9mU88AKk/bjAj7B9V5on
         Fk/ci5DZ3OQe9FNNBAZgi2tQBfUdnTnx/jSsz9p4QROlA7MtribXeKDuFEauxuJHPYSA
         S5mRs9tWn/mf+eS7KA/lfhMJFgdcx/fASmmIwty+jcUv2pYVExt2jGR7UsguvZP1sVj+
         f12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568392; x=1787173192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fHbXxuxlXqPkA+YdmnZqC7r5vbuh2GdoYZFVe/EIOnM=;
        b=UlSmS8mkzt7RYJPOnSncg86FK55QhHemP/KgtK1zxFdaPBsQtuHxFt7jmxPqToYnSi
         kLP3qtWvfyscZAeWIDfo9hnmke4aybJ7tm268rODDOS1kgP1tk/ghfkDQd/tnx7hNioa
         7aSZReTY2bU8zAq0fVysImkwV+wHXu1yf0vO1UAsondaUw1WOmrVhBFZ/u83joSpU1Vi
         H2lThz93FsrqekiZLB3S3vmtkjd+xi4+L+tGjpIRkjRgG5MgUNkiWyfZTx0/LE+MKsrx
         5ZoKmWTvRR4tV+xyf1GRo0rFPTUJ0j4Zmv2eYx1OlJS+IJGuAs1nHWme2zj+g5yEtk6N
         3c9w==
X-Forwarded-Encrypted: i=1; AHgh+RpxtRRQYyLDbS2pk8OLCALDIxb0lcySEDQMpiidAcas/1OUfwVKUszXf5ze4QMTzr3RZgZCCOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxgMcZDliGjmdYB+sPbbBWIohpJNMOfIfjOoMH6zt9Dy68o3J
	7mjglhD/hCW52cPzS2mAsDkIQEGlSJrBZM5doQlR1IXBsLuadLnyxINQmOvhmkBSFJ8FkoU1/6Y
	P475RYIQmIxyAlw==
X-Received: from qkip23.prod.google.com ([2002:a05:620a:22f7:b0:92e:50a6:4cfa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:240f:20b0:92e:541e:632b with SMTP id af79cd13be357-936bf8ca806mr86885685a.2.1786568392214;
 Wed, 12 Aug 2026 13:59:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 20:59:46 +0000
In-Reply-To: <20260812205946.356185-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812205946.356185-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812205946.356185-3-edumazet@google.com>
Subject: [PATCH net 2/2] inetpeer: randomize RB-tree node comparison using SipHash
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
with a secret boot-time key (inetpeer_hash_key). Nodes are ordered in the tree
by SipHash(addr, key) rather than raw IP addresses. Because the secret key is
unknown to external entities, the tree layout and lookup traversal paths are
unpredictable to off-path adversaries, breaking the deterministic eviction
gadget.

Cache the computed 64-bit SipHash (hash) in struct inet_peer and compute the
target hash (dhash) once at the beginning of inet_getpeer() to avoid recomputing
SipHash at every step of the RB-tree walk.

Fixes: b145425f269a ("inetpeer: remove AVL implementation in favor of RB tree")
Reported-by: Michael Blunt <michaelbblunt@gmail.com>
Suggested-by: Michael Blunt <michaelbblunt@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
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
index 1e2bd1c522326c9ba14c3ceeb8e934f703b827a5..96871f52010f330e2ce7f60ad375178e8eac290c 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -21,6 +21,7 @@
 #include <net/ip.h>
 #include <net/inetpeer.h>
 #include <net/secure_seq.h>
+#include <linux/siphash.h>
 
 /*
  *  Theory of operations.
@@ -52,6 +53,32 @@
  */
 
 static struct kmem_cache *peer_cachep __ro_after_init;
+static siphash_aligned_key_t inetpeer_hash_key __read_mostly;
+
+static u64 inetpeer_addr_hash(const struct inetpeer_addr *a)
+{
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
@@ -73,6 +100,8 @@ void __init inet_initpeers(void)
 {
 	u64 nr_entries;
 
+	get_random_bytes(&inetpeer_hash_key, sizeof(inetpeer_hash_key));
+
 	 /* 1% of physical memory */
 	nr_entries = div64_ul((u64)totalram_pages() << PAGE_SHIFT,
 			      100 * L1_CACHE_ALIGN(sizeof(struct inet_peer)));
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
2.55.0.691.gc56d675ccc-goog

