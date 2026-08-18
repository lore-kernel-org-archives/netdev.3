Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95C37F8CC
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065938; cv=none; b=GKw04cl4O7uK78Z064i+BJGv1aPT0vOmSfdqsD5S1p4wq4G+1xuoq48a9bCmm5/WJ1OR8pOehAldN0/4ugDEIw9/yAor6qNVVeojA5+VsBINUi54+pgR8w4pJ/WCKSGjwzSg3ScmNFJWaKKACuS3X6ZjVYX3/GPGTNrnUHPOrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065938; c=relaxed/simple;
	bh=zPchE/8kOJYR3RwzG0jQNACqR0GWSO+dUdVbdMzS0lU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=igpwkKoomKu5S6cMhSdm+0G261y8LKrnJAN7kaYSjeLQz+bi/9j8cLTRyHp9kySm2l88IINdfeiNthefCKhw6XLj4P134uyPpTyF9Q+L93uw9GAkzaXNJQ/SLsghttOEDcEFVXR9QDc8uMAablNHzn1BEn1201f6ombZqIBYiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GL2kvT5N; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GL2kvT5N"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4f946461so508578885a.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787065935; x=1787670735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWurW2MMOGKUUjhfyILYCl5UIX1u/LhqJ443mXPj14E=;
        b=GL2kvT5NH26mv6duOTYUk2n5q1O+yg7H4yG89au2KIHTJFHqkzq7IaqFK1Zcxi2NPV
         s1TWoM4STEt/Tv4y/LIEt2CY8J+2a9bFVpMLh6g0inEZFjaxCcqLb5pZUG4Hkk3eUHK1
         T9BgQxjYTj0xEhSBHuhvvaYn929yeDvWlAt2Tacb1EC2luDRn7vEqmZAjFC8bSOt5qiD
         q2hxjpePKmNe1Eg9Dok78GSR5kPioIuFqUgUewMYlesX2Ct114sNVhK2xil+oiPquUfu
         WScLW0H0c71iDC3G+oZdM7NAUlAh+WMpUBcoq5iWV+cQHIS175f+mC/LCoIdL/pr0eBw
         iTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065935; x=1787670735;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWurW2MMOGKUUjhfyILYCl5UIX1u/LhqJ443mXPj14E=;
        b=PVDJaqzlZ+KoeUerfHRUgUNNdbl+tNg+EidajLUgIhPTSlF/UNW9V1nPoI/tFCyHAA
         3UnW4vEsMxk7kkbXTeJy9lt8P3Lh1w/h+MrJSSAh03nvsnF7QdqdT1KCK4hPTY4EEKPe
         iYy4KDJhhxB/JZmWRGC83WIoZ4OqCMjfsGqXZjEPZ7wEWBzwuO0smc/KDAIDNes4bqZO
         zBe1Oz72msXhQtkViYQHoQKgGVSTNpKoNEmLohY1tAxvwKNpd0pwKl2AyUbivA0lEnxN
         vSelsWrW5nmRMRUEw1lKZGiNxQhf1HKs91K77YKYwwcqHe2uRlRwnEgpdOyJp6sWqy6O
         y1mw==
X-Forwarded-Encrypted: i=1; AHgh+Rqgaj0AK0NNWKLLpXhhTUzYAntbU7Cw9lycZnhtYiiEeTJZZ1zn1+GZfxF2NNJdaJ3Ngunv8PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lu/z7MsVu1Dmx6sHDBX+n5I3E8g6Dbi7NuecFeyRy+5ss+5b
	fO12k/lpe4Z9iVarSNBUWVJsTeTjxv7dUVJCwmPI30Qt9r+UJZmkBbO4VZViUBmXVYZp0svVNQZ
	7gzDhYinHuXXmXA==
X-Received: from qkbg7.prod.google.com ([2002:a05:620a:a347:b0:936:ea35:9634])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4087:b0:936:a89f:29ba with SMTP id af79cd13be357-93704adccddmr897220185a.5.1787065934577;
 Tue, 18 Aug 2026 08:12:14 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:12:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260818151213.3953963-1-edumazet@google.com>
Subject: [PATCH v3 net] inetpeer: randomize RB-tree node comparison using SipHash
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
v3: Properly rebase v2 (Ido)

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
index 5b957a831e7c39f2e9b224469f0eba4703833475..adf6dc8a95b4f35ab89bb7c429b43ae102b1eb1b 100644
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
@@ -190,11 +221,12 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	write_seqlock_bh(&base->lock);
 
 	gc_cnt = 0;
-	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
+	p = lookup(daddr, dhash, base, seq, gc_stack, &gc_cnt, &parent, &pp);
 	if (!p) {
 		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
+			p->hash = dhash;
 			p->dtime = (__u32)jiffies;
 			refcount_set(&p->refcnt, 1);
 			atomic_set(&p->rid, 0);
-- 
2.55.0.737.g08866a6d13-goog

