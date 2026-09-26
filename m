Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972A282F1C
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790393641; cv=none; b=Z7d/7MsfFW4OzrIQSsrcyZObIYd5e65D1h1k+RnzzfFEOPbzbO6T1Yg1Q+wMarcOnuR2RC2QA1PBq5wSPlinEpSps3rj8/qxFdiGkpQuXgbG7tg0ap+dnpQTb2OAgk6PHe7HL0xT02bxRXkuC+lcErWmbij9NheFuCyk95Dg1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790393641; c=relaxed/simple;
	bh=8Ib/ui7Td96CKuagaJm0tJ2PBj05KXQqQ1EFxR0b6dQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hlF7C7bKaHuKRKAopoMENxdZQiqoq9nUurF2Jf4TPpkIZ1DNdos2ZFEb22SHrgCO5rI1l+fbKgfKZPITVEBpxNiL3deVGT7CbJjxFcWmP35fs6p5PTQXwmflah3mZRc15zQpv+w4wAGhGekKZ1LfxnWdCpfrbIu3HOqozW3wejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oz2ta6dM; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oz2ta6dM"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e087a17dfso2107867a91.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790393638; x=1790998438; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WoVO4vFl+lX9KMlpyhz3UxwZ16AxnImkG43gQb2f+2A=;
        b=oz2ta6dM0hZZqK+ISdZ6EOdHqmClSrCJ5H+BSSxsGu2XCG/D8zXQr3IwkJEftH4E/Y
         3Igo2AXevu7ZbyqbEv9p1uoUyXpajh29j8KpR0oIwrR/Jr6IG2sLm8MZBABz7RP+QoDN
         5SBF9obxK+y8GW/80pNUyd8k/xOpnVW6rWvqSy1GN9XWG0doFHm1r7D5yYiJy/Km1Dh6
         HEn3z6kSJ0KwtQoMcJopQFoGydnr5s3/qPX1h1utxf8ReV1Z6oiQ6lMYOXJ219EGfgCF
         U6kAysaKr5kvcGxKlEWqWaR7OIo894S6CqlrMbGmRdvl34eSlLp+5GMVvuFvJmI3GvCs
         DJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790393638; x=1790998438;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoVO4vFl+lX9KMlpyhz3UxwZ16AxnImkG43gQb2f+2A=;
        b=p/2D9AMHY2KwU6gcFyu57IVAkfYs3zp/PlB1TO7HWmu7yAxpnpgmuRuUbGzbpTE5xG
         ahT1t+rHWx1GQeFyV8iIPWuLElS79qmi7JGgEhHjqRcq5f22Mfoxp9z1/FPPFpM5TXaz
         Gog4ybdbs4Cr8W2JfV2rBj2/IBoAVEI2NarT5nBr1eTtIJFBwaNx7mXfgZBlD69wRyD8
         vNccWw1SwI+Saaffwz+K1ZDTwnROa56SInd5dKVpC0SdV0wDRdhTh8iEw1wpNxoF15XB
         yAuOl3zIapIcN8Z6FiPueL0e4GJAmkQKeJtUyaYog3Wh/M0xpjn9DCR4Pm5x/pYCEHkv
         G5Pw==
X-Forwarded-Encrypted: i=1; AKwUvBw4Y1VHPF0l5wrF7hP/SqDcou28SWpgY6UJ3vSmgmaK665qBrMqoSsaNF+6Uh4ki/ou52K9owU=@vger.kernel.org
X-Gm-Message-State: AFuF++kh2en292ozUswaYMpn3ojcYJ/V4nsqFi6X2w0ce5W3KAoS+hf6
	KM7+qZV1fS9Dutef8Hw14f91A6n7E4jD2u2sHHRpeoadTtoKIeRLzHGoTRCAWUvwY4Bnq9vBRDP
	ImJ9tZA==
X-Received: from pgar20.prod.google.com ([2002:a05:6a02:2e94:b0:cc4:33fd:a4f7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc3:b0:39e:27e:2f09
 with SMTP id 98e67ed59e1d1-3a098ae1e18mr6546763a91.8.1790393637484; Fri, 25
 Sep 2026 20:33:57 -0700 (PDT)
Date: Sat, 26 Sep 2026 03:33:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926033355.3295550-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] ipv6: Remove FIB6_EXCEPTION_BUCKET_FLUSHED.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The FIB6_EXCEPTION_BUCKET_FLUSHED logic has been dead since added.

Commit 0346ec2f080b ("ipv6: Prevent rt6_insert_exception() for
dying fib6_info.") restored the original race protection in
rt6_insert_exception() by reusing fib6_info.fib6_destroying.

The flag now prevents two races for per-cpu and exception routes.

Let's remove FIB6_EXCEPTION_BUCKET_FLUSHED and set fib6_destroying
in fib6_purge_rt().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_fib.c | 14 +++++++-------
 net/ipv6/route.c   | 45 ---------------------------------------------
 2 files changed, 7 insertions(+), 52 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9ff761962b45..0dc6ebee6e56 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1019,12 +1019,6 @@ static int fib6_nh_drop_pcpu_from(struct fib6_nh *nh, void *_arg)
 
 static void fib6_drop_pcpu_from(struct fib6_info *f6i)
 {
-	/* Make sure rt6_make_pcpu_route() wont add other percpu routes
-	 * while we are cleaning them here.
-	 */
-	f6i->fib6_destroying = 1;
-	mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
-
 	if (f6i->nh) {
 		rcu_read_lock();
 		nexthop_for_each_fib6_nh(f6i->nh, fib6_nh_drop_pcpu_from, f6i);
@@ -1042,7 +1036,13 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 {
 	struct fib6_table *table = rt->fib6_table;
 
-	/* Flush all cached dst in exception table */
+	/* Make sure rt6_make_pcpu_route() / rt6_insert_exception()
+	 * will not add other percpu / exception routes after cleaning
+	 * them up in __fib6_drop_pcpu_from() / rt6_flush_exceptions().
+	 */
+	rt->fib6_destroying = 1;
+	mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
+
 	fib6_drop_pcpu_from(rt);
 	rt6_flush_exceptions(rt);
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 475ced827ec5..a76869ff87cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1663,13 +1663,6 @@ static unsigned int fib6_mtu(const struct fib6_result *res)
 	return mtu - lwtunnel_headroom(nh->fib_nh_lws, mtu);
 }
 
-#define FIB6_EXCEPTION_BUCKET_FLUSHED  0x1UL
-
-/* used when the flushed bit is not relevant, only access to the bucket
- * (ie., all bucket users except rt6_insert_exception);
- *
- * called under rcu lock; sometimes called with rt6_exception_lock held
- */
 static
 struct rt6_exception_bucket *fib6_nh_get_excptn_bucket(const struct fib6_nh *nh,
 						       spinlock_t *lock)
@@ -1682,40 +1675,9 @@ struct rt6_exception_bucket *fib6_nh_get_excptn_bucket(const struct fib6_nh *nh,
 	else
 		bucket = rcu_dereference(nh->rt6i_exception_bucket);
 
-	/* remove bucket flushed bit if set */
-	if (bucket) {
-		unsigned long p = (unsigned long)bucket;
-
-		p &= ~FIB6_EXCEPTION_BUCKET_FLUSHED;
-		bucket = (struct rt6_exception_bucket *)p;
-	}
-
 	return bucket;
 }
 
-static bool fib6_nh_excptn_bucket_flushed(struct rt6_exception_bucket *bucket)
-{
-	unsigned long p = (unsigned long)bucket;
-
-	return !!(p & FIB6_EXCEPTION_BUCKET_FLUSHED);
-}
-
-/* called with rt6_exception_lock held */
-static void fib6_nh_excptn_bucket_set_flushed(struct fib6_nh *nh,
-					      spinlock_t *lock)
-{
-	struct rt6_exception_bucket *bucket;
-	unsigned long p;
-
-	bucket = rcu_dereference_protected(nh->rt6i_exception_bucket,
-					   lockdep_is_held(lock));
-
-	p = (unsigned long)bucket;
-	p |= FIB6_EXCEPTION_BUCKET_FLUSHED;
-	bucket = (struct rt6_exception_bucket *)p;
-	rcu_assign_pointer(nh->rt6i_exception_bucket, bucket);
-}
-
 static int rt6_insert_exception(struct rt6_info *nrt,
 				const struct fib6_result *res)
 {
@@ -1745,9 +1707,6 @@ static int rt6_insert_exception(struct rt6_info *nrt,
 			goto out;
 		}
 		rcu_assign_pointer(nh->rt6i_exception_bucket, bucket);
-	} else if (fib6_nh_excptn_bucket_flushed(bucket)) {
-		err = -EINVAL;
-		goto out;
 	}
 
 #ifdef CONFIG_IPV6_SUBTREES
@@ -1818,10 +1777,6 @@ static void fib6_nh_flush_exceptions(struct fib6_nh *nh, struct fib6_info *from)
 	if (!bucket)
 		goto out;
 
-	/* Prevent rt6_insert_exception() to recreate the bucket list */
-	if (!from)
-		fib6_nh_excptn_bucket_set_flushed(nh, &rt6_exception_lock);
-
 	for (i = 0; i < FIB6_EXCEPTION_BUCKET_SIZE; i++) {
 		hlist_for_each_entry_safe(rt6_ex, tmp, &bucket->chain, hlist) {
 			if (!from ||
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

